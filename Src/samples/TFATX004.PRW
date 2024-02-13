#INCLUDE "Protheus.ch"
#include "fileio.ch"

#DEFINE FILIAL_ORIGEM			1
#DEFINE FILIAL_DESTINO			2
#DEFINE DATA_CORTE				3
#DEFINE SERIE_PREFIXO_DESTINO	4

Static cLogAtuTab := "logs\atualização de tabelas " + DTOS(Date()) + StrTran(Time(),":","") + ".csv"

User Function TFATX004
Local aPergs := {}
Local aResp := {}
Local oProcess
Local dOldDtBase := dDataBase

    Aadd(aPergs,{ 1 , "Filial Origem"	 , Space(Len(SE1->E1_FILIAL))  , "@!"  ,""  ,"SM0" 	,".T." , 60 ,.T. })
    Aadd(aPergs,{ 1 , "Filial Destino"	 , Space(Len(SE1->E1_FILIAL))  , "@!"  ,""  ,"SM0" 	,".T." , 60 ,.T. })
	Aadd(aPergs,{ 1 , "Data de Corte"	 , Date()  					   , ""    ,""  ,"" 	,".T." , 60 ,.T. })
	Aadd(aPergs,{ 1 , "Série/Prefixo Destino", "RMS" 				   , "@!"  ,""  ,"" 	,".T." , 60 ,.T. })
    
    If ParamBox( aPergs,"De/Para Filial",@aResp, , , , , , ,"TFATX004",.T., .T.) .And.;
		MsgNoYes("Confirma a transferência da base da filial " + aResp[FILIAL_ORIGEM] + " para  filial " + aResp[FILIAL_DESTINO]  + " usando novo prefixo/série " + aResp[SERIE_PREFIXO_DESTINO],"Transferência CR e CP")

		cFilAnt := aResp[FILIAL_ORIGEM]
		dDataBase := aResp[DATA_CORTE]
        oProcess := MsNewProcess():New({|lEnd| PTfatX004(aResp,oProcess) }, "Atualização de tabelas","Atualizando...",.F.)
		oProcess:Activate()

    EndIf 

	dDataBase := dOldDtBase

Return Nil
//-------------------------------------------------------------------
/*/{Protheus.doc} PTfatX004
Funcao para processar a alteração da filial nas tabelas pré-definidas

@author		Claudio Donizete
@since		23/07/2018
@version	1.0
/*/
//-------------------------------------------------------------------
Static Function PTfatX004(aResp,oProcess)
Local cBxDtFin := GetMv("MV_BXDTFIN")

// Força a reabertura do movimento financeiro
PutMv("MV_BXDTFIN", "1")

oProcess:SetRegua1(2)
// Força pergunte para não contabilizar on-line
If SX1->(dbSeek(Pad("FIN070",Len(SX1->X1_GRUPO))+Pad("04",Len(SX1->X1_ORDEM))))
	RecLock("SX1",.F.)
	SX1->X1_PRESEL := 2
	SX1->X1_CNT01 := "2"
	MsUnLock()
EndIf
// Força pergunte para não contabilizar on-line
If SX1->(dbSeek(Pad("FIN080",Len(SX1->X1_GRUPO))+Pad("03",Len(SX1->X1_ORDEM))))
	RecLock("SX1",.F.)
	SX1->X1_PRESEL := 2
	SX1->X1_CNT01 := "2"
	MsUnLock()
EndIf

TransfCR(oProcess,aResp)
TransfCP(oProcess,aResp)

// Restaura o parâmetro
PutMv("MV_BXDTFIN", cBxDtFin)

Return
//-------------------------------------------------------------------
/*/{Protheus.doc} TransfCR
Transfere Contas a Receber em aberto da Filial Origem para filial destino

@author		Claudio Donizete
@since		27/07/2018
@version	1.0
/*/
//-------------------------------------------------------------------
Static Function TransfCR(oProcess,aResp)
Local cAliasTrb := GetNextAlias()
Local nReg := 1
Local nTotReg
Local cCabecCsv
Local nHdlCsv
Local nX

	BeginSql Alias cAliasTrb
		SELECT COUNT(E1_FILIAL) OVER (PARTITION BY ' ') TOTREG, R_E_C_N_O_ RECNOTAB 
		  FROM %table:SE1%
		 WHERE E1_FILIAL=%exp:aResp[1]%
		 	   AND E1_SALDO > 0
			   AND E1_TIPO <> 'RA'
			   AND E1_TIPO NOT LIKE '%-'
			   AND %notDel%
	EndSql
	
	nTotReg		:= (cAliasTrb)->TOTREG
	oProcess:IncRegua1("Atualizando contas a receber ")
	oProcess:SetRegua2(nTotReg)

	nReg := 1
	// Processa todos os registros da query
	While !(cAliasTrb)->(Eof()) 
		// Posiciona no RECNO da tabela original
		SE1->(DbGoto((cAliasTrb)->RECNOTAB))
		oProcess:IncRegua2("Atualizando registro " + Alltrim(Str(nReg++))+"/"+Alltrim(Str(nTotReg)))
		Begin Transaction
			If TransfSE1(aResp)
				If TransfNFS(aResp) // Transfere NF e Pedidos
					If TransfBoleto(aResp)
						ProcLog(@cCabecCsv,@nHdlCsv,"SE1",aResp)
					Else
						DisarmTransaction()			
					Endif	
				Else
					DisarmTransaction()
				Endif
			Else
				DisarmTransaction()	
			Endif	
		End Transaction	
		//Exit
		(cAliasTrb)->(DBSkip())
	End
	(cAliasTrb)->(DBCloseArea())

Return Nil
//-------------------------------------------------------------------
/*/{Protheus.doc} TransfSE1
Transfere Titulos a Receber em aberto da Filial Origem para filial destino,
baixando o titulo na filial origem e incluindo na filial destino

@author		Claudio Donizete
@since		27/07/2018
@version	1.0
/*/
//-------------------------------------------------------------------
Static Function TransfSE1(aResp)
Local lRet := .F.
Local aAreaSE1 := SE1->(GetArea())
Local cFilSe1 := aResp[FILIAL_ORIGEM]
Local cChave
Local cTitPai
Local nRecNoSe1 := SE1->(Recno())
Local nX
Local nY
Local aTit := {}
Local cTipoTrf
Local cTipoTit
Local aRecno	 := {}
Local aCposAlt
Local cAliasTrb := GetNextAlias()
Local cFilOld := cFilAnt 
//.T. - Gera o titulo de ISS (se houver) na filial de destino juntamente com o titulo NF, baixando o titulo ISS na origem
//.F. - Nã gera o titulo de ISS na filial de destino, permanecendo o titulo ISS na origem em aberto. 
Local lTrfISSf	:= GetNewPar("MV_TRFISSF",.T.)
Local cParcela 	:= ""
Local dOldDtBase := dDataBase

	cChave := cFilSe1 + SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA)
	cTitPai := SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA)
	cTipoTrf := SE1->E1_TIPO

	nRecNoSe1 := SE1->(Recno())
	// Posiciona no registro a ser transferido
	SE1->(MsSeek(cChave))
	// Primeiro adiciona os registros a serem transferidos, pois 00801000100	primeiro
	// deve-se transferir o titulo principal, depois os agragados. Como os agragados podem
	// vir primeiro, entao utiliza-se uma matriz de recnos para transferir os titulos na ordem
	// em que foram incluidos, pois um abatimento nunca eh incluido primeiro que um titulo
	// principal
	// Os titulos de impostos nao se incluem nesta lista visto que os mesmos serao incluidos junto com
	// o titulo principal
	While SE1->(!Eof()) .And. SE1->(E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA) == cChave
		// Nao eh abatimento
		If (SE1->E1_TIPO $ MVABATIM) .Or. SE1->E1_TIPO == cTipoTrf // Titulo Principal
			Aadd(aRecno, SE1->(Recno()))
		ElseIf (SE1->E1_TIPO $ (MVABATIM+"/"+MVIRABT+"/"+MVINABT+"/"+MVCSABT+"/"+MVCFABT+"/"+MVPIABT+"/"+MVISABT+"/"+MVFUABT))
			If !Empty(SE1->E1_TITPAI) .AND. Alltrim(SE1->E1_TITPAI) <> AllTrim(cTitPai)
				SE1->(DbSkip())  
				Loop
			Endif
			Aadd(aRecno, SE1->(Recno()))
		EndIf					  			
		SE1->(DbSkip())
	End	
	aSort(aRecno) 
	// Transfere todos os titulos agregados
	nY := 1
	lMsErroAuto := .F.

	While ! lMsErroAuto .And. nY <= Len(aRecno)
		SE1->(DbGoto(aRecno[nY]))    
		cTipoTit := SE1->E1_TIPO  //Tipo do titulo que sera incluido para verificar a parcela
		// Incrementa a parcela para que nao haja registro duplicado na filial de Destino
		cParcela := SE1->E1_PARCELA
		cChave := aResp[FILIAL_DESTINO] + SE1->(aResp[SERIE_PREFIXO_DESTINO]+E1_NUM+cParcela+cTipoTit)
		/*
			While SE1->(MsSeek(cChave))
				cParcela := Soma1(cParcela)
				cChave := aResp[FILIAL_DESTINO] + SE1->(aResp[SERIE_PREFIXO_DESTINO]+E1_NUM+cParcela+cTipoTit)
			End

		*/
		// Não transfere se o titulo já existir na filial de destino
		If SE1->(MsSeek(cChave))
			lRet := .F.
		Else
		    lRet := .T.
			//ponteiro pode ter sido desposicionado ao buscar pelas parcelas do Titulo
			SE1->(DbGoto(aRecno[nY])) 
			// Preenche o E1_TIPOLIQ, para que o cálculo de baixas parciais do novo titulo seja efetuada pela
			// dif. entre E1_VALOR - E1_SALDO e não pela soma das baixas do SE5 (não terá SE5 no novo titulo)
			// No CP não precisa fazer isso.
			aCposAlt := { 	{ "E1_FILIAL"  , aResp[FILIAL_DESTINO] } ,; // Codigo da filial que recebera o titulo
							{ "E1_FILORIG" , aResp[FILIAL_ORIGEM]	} ,; // Codigo da filial de origem do titulo
							{ "E1_TIPOLIQ" , "XXX"	} ,; 
							{ "E1_TITPAI"  , If( !Empty(SE1->E1_TITPAI), aResp[SERIE_PREFIXO_DESTINO] + Substr(SE1->E1_TITPAI,4), " ") },; // Troca o prefixo também no E1_TITPAI, para que consiga encontrar os impostos do novo titulo
							{ "E1_LA"	   , "S"},;
							{ "E1_HIST"	   , Alltrim(SE1->E1_HIST) + " trf fil " + aResp[FILIAL_ORIGEM] },;
							{ "E1_ORIGEM"  , "TFATX004" } ,; // Codigo da Rotina que originou o titulo
							{ "E1_PREFIXO" , aResp[SERIE_PREFIXO_DESTINO]   } ,; // Prefixo do título destino
							{ "E1_PARCELA" , cParcela   } ,;
							{ "E1_VALOR"   , SE1->E1_SALDO }}

			// Grava titulo na filial de destino
			lMsErroAuto := .F.
			// MSExecAuto({|x, y| FINA040(x, y)}, aTit, 3)
			// If lMsErroAuto
			// 	   DisarmTransaction()
			//     lRet := .F.
			//	   Exit
			// Endif
			lRet := DuplicReg("SE1",aCposAlt) > 0
		EndIf	
		If !lRet
			Exit
		Endif
		nY ++
	End // Aqui efetuou a transferência dos titulos e seus agregados (Abatimentos)

	SE1->(DbGoto(nRecNoSe1))
	
	If lRet

		// Altera para filial do titulo de origem para fazer a baixa
		cFilAnt := cFilSe1
		aTit := {}
		dDataBase := SE1->E1_VENCREA

		AADD(aTit , {"E1_PREFIXO"	, SE1->E1_PREFIXO	, NIL})
		AADD(aTit , {"E1_NUM"		, SE1->E1_NUM		, NIL})
		AADD(aTit , {"E1_PARCELA"	, SE1->E1_PARCELA	, NIL})
		AADD(aTit , {"E1_TIPO"		, SE1->E1_TIPO		, NIL})
		AADD(aTit , {"E1_CLIENTE"	, SE1->E1_CLIENTE	, NIL})
		AADD(aTit , {"E1_LOJA"		, SE1->E1_LOJA		, NIL})
		AADD(aTit , {"AUTMOTBX"		, "TRA"				, NIL})
		AADD(aTit , {"AUTDTBAIXA"	, dDataBase			, NIL})
		//AADD(aTit , {"AUTDTCREDITO" , dDataBase			, NIL})
		AADD(aTit , {"AUTHIST"		, "fil " + aResp[FILIAL_ORIGEM] + " p/" + aResp[FILIAL_DESTINO] + " " + DTOC(aResp[DATA_CORTE]),NIL})
		//Aadd(aTit , {"AUTJUROS"	, /*nJuros*/ 0		    , Nil})
		//Aadd(aTit , {"AUTDESCONT"	, 0      			, Nil})     
		//Aadd(aTit , {"AUTMULTA"	    , 0    			    , Nil})
		//Aadd(aTit , {"AUTCM1"		, 0    				, Nil})
		//Aadd(aTit , {"AUTDECRESC"	, 0	       			, Nil})
		//Aadd(aTit , {"AUTACRESC"	, 0	      			, Nil})
		//Aadd(aTit , {"AUTPRORATA"	, 0    				, Nil})
		//AADD(aTit , {"AUTVALREC"	, nSaldo			, NIL})
		
		// Executa a Baixa do Titulo
		lMsErroAuto := .F.
		lRet := .T.
		
		MSExecAuto({|x, y| FINA070(x, y)}, aTit, 3)
		If lMsErroAuto
		//DisarmTransaction()
			MostraErro()
			lRet := .F.
		Endif

		If lRet
			SE1->(MsGoto(nRecNoSe1))
			If SE1->E1_ISS != 0 .And. lTrfISSf
				// Baixa tambem os registro de impostos-ISS	 
				SE2->(dbSetOrder(1)) // E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA
				If SE2->(dbSeek(xFilial("SE2")+SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA)))
					If AllTrim(SE2->E2_NATUREZ) == Alltrim(&(GetMv("MV_ISS"))) .and. STR(SE2->E2_SALDO,17,2) == STR(SE2->E2_VALOR,17,2)
						dDataBase := SE2->E2_VENCREA
						aTit := {}
						// Altera para filial do titulo de origem para fazer a baixa
						cFilAnt := aResp[FILIAL_ORIGEM]
						AADD(aTit , {"E2_FILIAL"	, SE2->E2_FILIAL	, NIL})								
						AADD(aTit , {"E2_PREFIXO"	, SE2->E2_PREFIXO	, NIL})
						AADD(aTit , {"E2_NUM"		, SE2->E2_NUM		, NIL})
						AADD(aTit , {"E2_PARCELA"	, SE2->E2_PARCELA	, NIL})
						AADD(aTit , {"E2_TIPO"		, SE2->E2_TIPO		, NIL})
						AADD(aTit , {"E2_NATUREZ"	, SE2->E2_NATUREZ	, NIL})
						AADD(aTit , {"E2_FORNECE"	, SE2->E2_FORNECE	, NIL})
						AADD(aTit , {"E2_LOJA"		, SE2->E2_LOJA		, NIL})
						AADD(aTit , {"AUTMOTBX"		, "TRA"				, NIL})
						AADD(aTit , {"AUTDTBAIXA"	, dDataBase			, NIL})
						AADD(aTit , {"AUTHIST"		, "fil " + aResp[FILIAL_ORIGEM] + " p/" + aResp[FILIAL_DESTINO] + " " + DTOC(aResp[DATA_CORTE]),NIL})
						//AADD(aTit , {"AUTVLRPG"		, SE2->E2_SALDO	, NIL })
						// Executa a Baixa do Titulo
						lMsErroAuto := .F.
						MSExecAuto({|x, y| FINA080(x, y)}, aTit, 3)
						
						If lMsErroAuto
							lRet	:= .F.
							//DisarmTransaction()
							MostraErro()
						Endif
					EndIf
				Endif
			EndIf
		EndIf	
	Endif
	// Garante que o titulo voltará o mesmo originalmente posicionado
	SE1->(RestArea(aAreaSE1))
	cFilAnt := cFilOld // Restaura filial atual	
	dDataBase := dOldDtBase

Return lRet
//-------------------------------------------------------------------
/*/{Protheus.doc} TransfNFS
Transfere Notas Fiscais de Saida, Item da NF, Pedido e Item do pedido 
da Filial Origem para filial destino, referente ao titulo a receber posicionado

@author		Claudio Donizete
@since		27/07/2018
@version	1.0
/*/
//-------------------------------------------------------------------
Static Function TransfNFS(aResp)
Local lRet := .T.
Local cAliasTrb := GetNextAlias()
Local cAliasItNf := "ITNF" + GetNextAlias()
Local cPedido
Local cNumPed := ""
Local cFilOld := cFilAnt
Local aCposAlt 

	BeginSql Alias cAliasTrb
		SELECT COUNT(F2_FILIAL) OVER (PARTITION BY ' ') TOTREG, SF2.R_E_C_N_O_ RECNOSF2
		  FROM %table:SF2% SF2
		
		WHERE F2_FILIAL=%exp:aResp[1]%
			  AND F2_DOC = %exp:SE1->E1_NUM%
			  AND F2_SERIE = %exp:SE1->E1_PREFIXO%
			  AND F2_CLIENT = %exp:SE1->E1_CLIENTE%
			  AND F2_LOJA = %exp:SE1->E1_LOJA%
			  AND SF2.%notDel%

	EndSql

	SD2->(DbSetOrder(2)) // D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
	SF2->(DbSetOrder(1)) // F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
	SC5->(DbSetOrder(1)) // C5_FILIAL+C5_NUM
	SC6->(DbSetOrder(1)) // C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
	SC9->(DbSetOrder(1)) // C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
	
	// Muda para Filial destino
	cFilAnt := aResp[FILIAL_DESTINO]

	// Transfere a NF
	While lRet .And. !(cAliasTrb)->(Eof())

		SF2->(DbGoto((cAliasTrb)->RECNOSF2))

		// Pesquisa a NF na filial de destino, pois pode haver mais de uma parcela no SE1
		If !SF2->(DBSeek(aResp[FILIAL_DESTINO]+SF2->F2_DOC+aResp[SERIE_PREFIXO_DESTINO]))

			// Posiciona no RECNO Original da tabela
			SF2->(DbGoto((cAliasTrb)->RECNOSF2))

			aCposAlt := { {"F2_FILIAL", aResp[FILIAL_DESTINO] },;
						  {"F2_SERIE" , aResp[SERIE_PREFIXO_DESTINO] },;
						  {"F2_PREFIXO", aResp[SERIE_PREFIXO_DESTINO] } }

			lRet := DuplicReg("SF2",aCposAlt) > 0
			
			BeginSql Alias cAliasItNf
				SELECT COUNT(D2_FILIAL) OVER (PARTITION BY ' ') TOTREG,  SD2.R_E_C_N_O_ RECNOSD2, SD2.D2_PEDIDO
				FROM %table:SD2% SD2
				
				WHERE D2_FILIAL=%exp:aResp[1]%
					AND D2_DOC = %exp:SF2->F2_DOC%
					AND D2_SERIE = %exp:SF2->F2_SERIE%
					AND SD2.%notDel%
				ORDER BY SD2.D2_PEDIDO, SD2.R_E_C_N_O_

			EndSql

			// Transfere os itens da NF
			While lRet .And. !(cAliasItNf)->(Eof())

				cPedido := 	(cAliasItNf)->D2_PEDIDO
				// Gera com novo nr. de pedido para não duplicar na filial destino
				cNumPed := GetSXENum("SC5","C5_NUM")
				ConfirmSx8()

				While lRet .And. !(cAliasItNf)->(Eof()) .And. (cAliasItNf)->D2_PEDIDO == cPedido
					SD2->(DbGoto((cAliasItNf)->RECNOSD2))

					aCposAlt := { {"D2_FILIAL", aResp[FILIAL_DESTINO] },;
								  {"D2_SERIE" , aResp[SERIE_PREFIXO_DESTINO] },;
								  {"D2_ORDSEP", SD2->D2_PEDIDO },; // Guarda o nr. do pedido de origem
								  {"D2_PEDIDO", cNumPed  } } // Guarda o nr do novo pedido

					lRet := DuplicReg("SD2",aCposAlt) > 0
					If !lRet
						Exit
					Endif

					(cAliasItNf)->(DbSkip())
				End

				// Transfere os pedidos e os itens dos pedidos
				If SC5->(DBSeek(aResp[FILIAL_ORIGEM]+cPedido))
					aCposAlt := { {"C5_FILIAL", aResp[FILIAL_DESTINO] },;
								  {"C5_SERIE" , aResp[SERIE_PREFIXO_DESTINO] },;
								  {"C5_NUM"	  , cNumPed  } } 

					lRet := DuplicReg("SC5",aCposAlt) > 0
						
					SC6->(DBSeek(aResp[FILIAL_ORIGEM]+cPedido))
					While lRet .And. !SC6->(Eof()) .And. SC6->(C6_FILIAL+C6_NUM) == SC5->(C5_FILIAL+C5_NUM)
						aCposAlt := { {"C6_FILIAL", aResp[FILIAL_DESTINO] },;
										{"C6_SERIE" , aResp[SERIE_PREFIXO_DESTINO] },;
										{"C6_NUM"	  , cNumPed  } }

						lRet := DuplicReg("SC6",aCposAlt) > 0
						SC9->(DBSeek(aResp[FILIAL_ORIGEM]+SC6->C6_NUM+SC6->C6_ITEM))
						// Transfere SC9
						While lRet .And. !SC9->(Eof()) .And. SC9->(C9_FILIAL+C9_PEDIDO+C9_ITEM) == aResp[FILIAL_ORIGEM]+SC6->C6_NUM+SC6->C6_ITEM
							aCposAlt := { {"C9_FILIAL", aResp[FILIAL_DESTINO] },;
											{"C9_PEDIDO", cNumPed  } }
							lRet := DuplicReg("SC9",aCposAlt) > 0
							SC9->(DbSkip())
						End
						SC6->(DbSkip())
					End
				EndIf
			End // Terminou de transferir os itens da NF, os pedidos, os itens dos pedidos e a SC9
			(cAliasItNf)->(DBCloseArea())
		EndIf

		(cAliasTrb)->(DbSkip())		
		
	End	// Terminou de transferir as NF

	(cAliasTrb)->(DBCloseArea())
	cFilAnt  := cFilOld

Return lRet
//-------------------------------------------------------------------
/*/{Protheus.doc} TransfBoleto
Transfere Boletos a Receber da Filial Origem para filial destino, 
referente ao titulo a receber posicionado

@author		Claudio Donizete
@since		27/07/2018
@version	1.0
/*/
//-------------------------------------------------------------------
Static Function TransfBoleto(aResp)
Local lRet := .T.
Local cAliasTrb := GetNextAlias()
Local aCposAlt

	BeginSql Alias cAliasTrb
		SELECT COUNT(PDR_FILIAL) OVER (PARTITION BY ' ') TOTREG, R_E_C_N_O_ RECNOTAB 
		FROM %table:PDR%
		WHERE PDR_FILIAL=%exp:aResp[1]%
			AND PDR_PREFIX = %exp:SE1->E1_PREFIXO%
			AND PDR_NUM = %exp:SE1->E1_NUM%
			AND PDR_PARCEL = %exp:SE1->E1_PARCELA%
			AND PDR_TIPO = %exp:SE1->E1_TIPO%
			AND PDR_CLIENT = %exp:SE1->E1_CLIENTE%
			AND PDR_LOJA = %exp:SE1->E1_LOJA%
			AND %notDel%
	EndSql
	While lRet .And. !(cAliasTrb)->(Eof())
		// Posiciona no RECNO Original da tabela
		PDR->(DbGoto((cAliasTrb)->RECNOTAB))

		aCposAlt := { {"PDR_FILIAL", aResp[FILIAL_DESTINO] }, ;
					  {"PDR_PREFIX", aResp[SERIE_PREFIXO_DESTINO] } }

		lRet := DuplicReg("PDR",aCposAlt) > 0
		(cAliasTrb)->(DbSkip())
	End

	(cAliasTrb)->(DBCloseArea())

Return lRet
//-------------------------------------------------------------------
/*/{Protheus.doc} TransfCP
Transfere Contas a Pagar da Filial Origem para filial destino, 

@author		Claudio Donizete
@since		27/07/2018
@version	1.0
/*/
//-------------------------------------------------------------------
Static Function TransfCP(oProcess,aResp)
Local cAliasTrb := GetNextAlias()
Local nReg := 1
Local nTotReg
Local cCabecCsv
Local nHdlCsv
Local nX

	BeginSql Alias cAliasTrb
		SELECT COUNT(E2_FILIAL) OVER (PARTITION BY ' ') TOTREG, R_E_C_N_O_ RECNOTAB 
		  FROM %table:SE2%
		 WHERE E2_FILIAL=%exp:aResp[1]%
		 	   AND E2_SALDO > 0
			   AND E2_TIPO <> 'PA'
			   AND E2_TIPO NOT LIKE '%-'
			   AND %notDel%
	EndSql
	
	nTotReg		:= (cAliasTrb)->TOTREG
	oProcess:IncRegua1("Atualizando contas a pagar ")
	oProcess:SetRegua2(nTotReg)

	nReg := 1
	// Processa todos os registros da query
	While !(cAliasTrb)->(Eof()) 
		// Posiciona no RECNO da tabela original
		SE2->(DbGoto((cAliasTrb)->RECNOTAB))
		oProcess:IncRegua2("Atualizando registro " + Alltrim(Str(nReg++))+"/"+Alltrim(Str(nTotReg)))
		Begin Transaction
			If TransfSE2(aResp)
				If TransfNFE(aResp) // Transfere NF e Pedidos
					ProcLog(@cCabecCsv,@nHdlCsv,"SE2",aResp)
				Else
					DisarmTransaction()			
				Endif
			Else
				DisarmTransaction()	
			Endif	
		End Transaction	
		//Exit
		(cAliasTrb)->(DBSkip())
	End
	(cAliasTrb)->(DBCloseArea())

Return Nil
//-------------------------------------------------------------------
/*/{Protheus.doc} TransfCP
Transfere Titulos a Pagar em aberto da Filial Origem para filial destino, 
Baixando o titulo na filial Origem e incluindo na filial destino

@author		Claudio Donizete
@since		27/07/2018
@version	1.0
/*/
//-------------------------------------------------------------------

Static Function TransfSE2(aResp)
Local lRet := .T.
Local aCposAlt
Local nRecNoSe2 := SE2->(Recno())
Local cFilSe2 	:= aResp[FILIAL_ORIGEM]
Local cChave
Local cTipoTit
Local cFilOld   := cFilAnt 
Local aAreaSE2  := SE2->(GetArea())
Local cFornece
Local cLoja
Local aRecno	:= {}

	// Primeiro adiciona os registros a serem transferidos, pois os primeiro
	// deve-se transferir o titulo principal, depois os agragados. Como os agragados podem
	// vir primeiro, entao utiliza-se uma matriz de recnos para transferir os titulos na ordem
	// em que foram incluidos, pois um abatimento nunca eh incluido primeiro que um titulo
	// principal
	// Os titulos de impostos nao se incluem nesta lista visto que os mesmos serao incluidos junto com
	// o titulo principal
	cChave := cFilSe2 + SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA)
	cFornece := SE2->E2_FORNECE
	cLoja	 := SE2->E2_LOJA
	cTipoTit := SE2->E2_TIPO

	SE2->(DbSetOrder(1)) // E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA
	SE2->(MsSeek(cChave))
	While SE2->(!Eof()) .And. SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA) == cChave
		If (SE2->(E2_FORNECE+E2_LOJA) == cFornece+cLoja .And. SE2->E2_TIPO $ MVABATIM) .Or.	;
			(SE2->(E2_FORNECE+E2_LOJA) == cFornece+cLoja .And. SE2->E2_TIPO == cTipoTit)
			Aadd(aRecno, SE2->(Recno()))
		EndIf	
		SE2->(DbSkip())
	Enddo
	
	aSort(aRecno)
	
	// Transfere todos os titulos agregados
	nY := 1
	lMsErroAuto := .F.

	While lRet .And. !lMsErroAuto .And. nY <= Len(aRecno)
		
		SE2->(MsGoto(aRecno[nY]))
		cTipoTit := SE2->E2_TIPO  //Tipo do titulo que sera incluido para verificar a parcela
		
		// Incrementa a parcela para que nao haja registro duplicado na filial Debito
		cParcela := SE2->E2_PARCELA
		cChave := aResp[FILIAL_DESTINO] + SE2->(E2_PREFIXO+E2_NUM+cParcela+cTipoTit+SE2->E2_FORNECE+SE2->E2_LOJA)
		/*
			While SE2->(MsSeek(cChave))
				cParcela := Soma1(cParcela)
				cChave := aResp[FILIAL_DESTINO] + SE2->(E2_PREFIXO+E2_NUM+cParcela+cTipoTit+SE2->E2_FORNECE+SE2->E2_LOJA)
			Enddo
		*/
		// Não transfere caso o titulo já exista na filial de destino
		If SE2->(MsSeek(cChave))
			lRet := .F.
		Else
			lRet := .T.
			SE2->(MsGoto(aRecno[nY])) //ponteiro pode ter sido desposicionado ao buscar pelas parcelas do Titulo	

			aCposAlt := { { "E2_FILIAL"  , aResp[FILIAL_DESTINO]   } ,; // Codigo da filial que recebera o titulo
						  { "E2_ORIGEM"  , "TFATX004" } ,;
						  { "E2_PARCELA" , cParcela   } ,;
						  { "E1_LA"		 , "S"        } }
			
			lRet := DuplicReg("SE2",aCposAlt) > 0
		EndIf

		nY++
	End
	
	If lRet

		SE2->(MsGoTo(nRecNoSe2))
		aTit := {}
		// Altera para filial do titulo de origem para fazer a baixa
		cFilAnt := cFilSe2
			
		AADD(aTit , {"E2_PREFIXO"	, SE2->E2_PREFIXO	, NIL})
		AADD(aTit , {"E2_NUM"		, SE2->E2_NUM		, NIL})
		AADD(aTit , {"E2_PARCELA"	, SE2->E2_PARCELA	, NIL})
		AADD(aTit , {"E2_TIPO"		, SE2->E2_TIPO		, NIL})
		AADD(aTit , {"E2_FORNECE"	, SE2->E2_FORNECE	, NIL})
		AADD(aTit , {"E2_LOJA"		, SE2->E2_LOJA		, NIL})
		AADD(aTit , {"AUTMOTBX"		, "TRA"				, NIL})
		AADD(aTit , {"AUTDTBAIXA"	, dDataBase			, NIL})
		AADD(aTit , {"AUTHIST"		, "Bx.p/trf.fil " + aResp[FILIAL_ORIGEM] + " p/" + aResp[FILIAL_DESTINO],NIL})

		// Executa a Baixa do Titulo
		lMsErroAuto := .F.
		lRet := .T.
		MSExecAuto({|x, y| FINA080(x, y)}, aTit, 3)
		
		If lMsErroAuto
			lRet := .F.
		Endif
	Endif

	// Garante que o titulo voltará o mesmo originalmente posicionado
	SE2->(RestArea(aAreaSE2))
	cFilAnt := cFilOld // Restaura filial atual	

Return lRet
//-------------------------------------------------------------------
/*/{Protheus.doc} TransfNFE
Transfere Notas Fiscais de Entrada, Item da NF e Pedido da Filial Origem para filial destino, 
referente ao titulo a pagar posicionado

@author		Claudio Donizete
@since		27/07/2018
@version	1.0
/*/
//-------------------------------------------------------------------
Static Function TransfNFE(aResp)
Local lRet := .T.
Local cAliasTrb := GetNextAlias()
Local cAliasPed := "PED" + GetNextAlias()
Local cAliasItNf := "ITNF" + GetNextAlias()
Local nRecnoSf1
Local nRecnoSC7
Local cNumPed := ""
Local cFilOld := cFilAnt 
Local aCposAlt

	BeginSql Alias cAliasTrb
		SELECT COUNT(F1_FILIAL) OVER (PARTITION BY ' ') TOTREG, SF1.R_E_C_N_O_ RECNOSF1
		FROM %table:SF1% SF1
		
		WHERE F1_FILIAL=%exp:aResp[1]%
			  AND F1_DOC = %exp:SE2->E2_NUM%
			  AND F1_SERIE = %exp:SE2->E2_PREFIXO%
			  AND F1_FORNECE = %exp:SE2->E2_FORNECE%
			  AND F1_LOJA = %exp:SE2->E2_LOJA%
			  AND SF1.%notDel%
		ORDER BY SF1.R_E_C_N_O_ 

	EndSql

	SF1->(DbSetOrder(1)) // F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO
	// Muda para Filial destino
	cFilAnt := aResp[FILIAL_DESTINO]

	// Transfere a NF
	While lRet .And. !(cAliasTrb)->(Eof())

		nRecnoSf1 := (cAliasTrb)->RECNOSF1
		// Posiciona no RECNO Original da tabela
		SF1->(DbGoto(nRecnoSf1))

		// Pesquisa a NF na filial de destino, pois pode haver mais de uma parcela no SE2
		If !SF1->(DBSeek(aResp[FILIAL_DESTINO]+SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO)))
			
			// Posiciona no RECNO Original da tabela
			SF1->(DbGoto(nRecnoSf1))

			aCposAlt := { {"F1_FILIAL", aResp[FILIAL_DESTINO] } }

			lRet := DuplicReg("SF1",aCposAlt) > 0
			If !lRet
				Exit
			Endif

			BeginSql Alias cAliasItNf
				SELECT COUNT(D1_FILIAL) OVER (PARTITION BY ' ') TOTREG,  SD1.R_E_C_N_O_ RECNOSD1, SD1.D1_PEDIDO
				FROM %table:SD1% SD1
				
				WHERE D1_FILIAL=%exp:aResp[1]%
					AND D1_DOC = %exp:SF1->F1_DOC%
					AND D1_SERIE = %exp:SF1->F1_SERIE%
					AND SD1.%notDel%
				ORDER BY SD1.D1_PEDIDO, SD1.R_E_C_N_O_

			EndSql

			// Transfere os itens da NF
			While lRet .And. !(cAliasItNf)->(Eof())

				cPedido := 	(cAliasItNf)->D1_PEDIDO
				// Gera com novo nr. de pedido para não duplicar na filial destino
				cNumPed := GetSXENum("SC7","C7_NUM")
				ConfirmSx8()

				While lRet .And. !(cAliasItNf)->(Eof()) .And. (cAliasItNf)->D1_PEDIDO == cPedido
					
					SD1->(DbGoto((cAliasItNf)->RECNOSD1))

					aCposAlt := { {"D1_FILIAL", aResp[FILIAL_DESTINO] },;
								  {"D1_PEDIDO", cNumPed  } } // Guarda o nr do novo pedido

					lRet := DuplicReg("SD1",aCposAlt) > 0
					(cAliasItNf)->(DbSkip())
					
				End 

				// Seleciona os pedidos do Item da NF
				BeginSql Alias cAliasPed
					SELECT COUNT(C7_FILIAL) OVER (PARTITION BY ' ') TOTREG, SC7.R_E_C_N_O_ RECNOSC7
					FROM %table:SC7% SC7
					
					WHERE C7_FILIAL=%exp:aResp[1]%
						  AND C7_NUM = %exp:cPedido%
						  AND SC7.%notDel%
					ORDER BY SC7.R_E_C_N_O_ 

				EndSql
				// Transfere os pedidos
				While lRet .And. !(cAliasPed)->(Eof())
					nRecnoSC7 := (cAliasPed)->RECNOSC7
					// Posiciona no RECNO Original da tabela
					SC7->(DbGoto(nRecnoSC7))
				
					aCposAlt := { {"C7_FILIAL", aResp[FILIAL_DESTINO] },;
								  {"C7_NUM"	  , cNumPed  } } // Gera com novo nr. de pedido para não duplicar na filial destino

					lRet := DuplicReg("SC7", aCposAlt) > 0
					(cAliasPed)->(DbSkip())
				End	
				(cAliasPed)->(DBCloseArea())
			
			End // Terminou os Itens da NF e Pedidos de Compra
			(cAliasItNf)->(DBCloseArea())
		EndIf
		(cAliasTrb)->(DbSkip())	
	End
	
	(cAliasTrb)->(DBCloseArea())
	cFilAnt := cFilOld

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} ProcLog
Grava LOG dos registros alterados

@author		Claudio Donizete
@since		23/07/2018
@version	1.0
/*/
//-------------------------------------------------------------------
Static Function ProcLog(cCabecCsv,nHdlCsv, cAliasTrb,aResp)

// Cria cabeçalho do CSV
If Empty(cCabecCsv)
	cCabecCsv := "Alias;Chave;Filial Origem;Filial Destino;Série Destino;Data Corte"
	If Empty(nHdlCsv)
		If	File(cLogAtuTab)  
			nHdlCsv := fOpen(cLogAtuTab,FO_READWRITE+FO_EXCLUSIVE)
			FSeek(nHdlCsv,0,2) // Posiciona no final do arquivo
		Else
			nHdlCsv := fCreate(cLogAtuTab)
			fWrite(nHdlCsv,cCabecCsv+CRLF)
		Endif	
	Endif	
Endif

cLinha := CHR(160)+cAliasTrb+";"+; 							// Alias
			CHR(160)+(cAliasTrb)->&(IndexKey(1))+";"+; 		// Chave
			CHR(160)+aResp[FILIAL_ORIGEM]+";"+; 			// Filial Origem
			CHR(160)+aResp[FILIAL_DESTINO] +";" +;			// Filial Destino
			CHR(160)+aResp[SERIE_PREFIXO_DESTINO] + ";" +;	// Série/Prefixo Destino
			CHR(160)+DTOC(aResp[DATA_CORTE])				// Data Corte
			
fWrite(nHdlCsv,cLinha+CRLF)

(cAliasTrb)->(!Eof())

Return Nil

/*/{Protheus.doc} DuplicReg
Funcao para duplicação de registros 

@author		Claudio Donizete
@since		25/07/2018
@version	1.0
/*/
Static Function DuplicReg(cArquiv1, aCposAlt)
Local aArea   		:= GetArea()
Local aArea1   		:= (cArquiv1)->(GetArea())
Local aCampos  		:= {}
Local nCampos		:= 0
Local nContador		:= 0
Local nElem			:= 0
Local nReturn		:= 0

If Len(aCposAlt) <= 0
	Return(nReturn)
EndIf

dbSelectArea(cArquiv1)
nCampos := FCOUNT()
For nContador := 1 To nCampos
	nElem	:= aScan(aCposAlt, { |x| AllTrim(x[1]) == FieldName(nContador) })
	If nElem > 0
		aAdd(aCampos, {FieldName(nContador), aCposAlt[nElem,2]		})
	Else
		aAdd(aCampos, {FieldName(nContador), FieldGet(nContador)	})
	EndIf
Next

RecLock( cArquiv1, .t. )
For nContador := 1 To nCampos
	// dbSelectArea(cArquiv2 )
	// FieldPut(FieldPos(aCampos[nContador, 1],aCampos[nContador, 2]) )
 	cVar 		:= (cArquiv1+"->"+aCampos[nContador,1]) 
  	&cVar		:= aCampos[nContador, 2]
Next 
MsUnlock()         
nReturn := RECNO()	

(cArquiv1)->(RestArea(aArea1))
RestArea(aArea)       

Return(nReturn)

User Function F070VMOT
Local lRet 

// Não validar situação de cobrança, para motivo de baixa transferência
If Left(cMotBx,3) == "TRA"
	lRet := .T.
Else
	If !(SE1->E1_SITUACA $ "0FG") .and. !MovBcoBx(cMotBx, .T.)
		lRet := .F.
	EndIf
Endif

If ! lRet
	Help(" ",1,"FA070MOTINV")
Endif

Return lRet