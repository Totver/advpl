#INCLUDE "PROTHEUS.CH" 
#INCLUDE "TBICONN.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"

#DEFINE IMP_SPOOL 2

#DEFINE VBOX      080
#DEFINE VSPACE    008
#DEFINE HSPACE    010
#DEFINE SAYVSPACE 008
#DEFINE SAYHSPACE 008
#DEFINE HMARGEM   030
#DEFINE VMARGEM   030
#DEFINE MAXITEM   010                                                // Máximo de produtos para a primeira página
#DEFINE MAXITEMP2 044                                                // Máximo de produtos para a pagina 2 (caso nao utilize a opção de impressao em verso)
#DEFINE MAXITEMP3 015                                                // Máximo de produtos para a pagina 2 (caso utilize a opção de impressao em verso) - Tratamento implementado para atender a legislacao que determina que a segunda pagina de ocupar 50%.
#DEFINE MAXITEMP4 022                                                // Máximo de produtos para a pagina 2 (caso contenha main info cpl que suporta a primeira pagina)
#DEFINE MAXITEMC  012                                                // Máxima de caracteres por linha de produtos/serviços
#DEFINE MAXMENLIN 150                                                // Máximo de caracteres por linha de dados adicionais
#DEFINE MAXMSG    006                                                // Máximo de dados adicionais na primeira página
#DEFINE MAXMSG2   019                                                // Máximo de dados adicionais na segunda página
#DEFINE MAXBOXH   800                                                // Tamanho maximo do box Horizontal
#DEFINE MAXBOXV   600
#DEFINE INIBOXH   -10
#DEFINE MAXMENL   080                                                // Máximo de caracteres por linha de dados adicionais
#DEFINE MAXVALORC 015                                                // Máximo de caracteres por linha de valores numéricos
#DEFINE MAXCODPRD 040                                                // Máximo de caracteres do codigo de produtos/servicos



/*/{Protheus.doc} DANFE_P1
//TODO Descrição auto-gerada.
@author william.souza
@since 15/05/2020
@version 1.0
@return ${return}, ${return_description}
@param cIdEnt, characters, descricao
@param cVal1, characters, descricao
@param cVal2, characters, descricao
@param oDanfe, object, descricao
@param oSetup, object, descricao
@param lIsLoja, logical, descricao
@param lAutomato, logical, descricao
@param lViaJob, logical, descricao
@type function
/*/
User Function DANFE_P1(cIdEnt,cVal1,cVal2,oDanfe,oSetup,lIsLoja,lAutomato,lViaJob)

Local aArea     := GetArea() 
Local lExistNfe := .F.
Local lRet		:= .T.

Default lIsLoja	:= .F.	// indica se foi chamado de alguma rotina do SIGALOJA

default lAutomato := .F.
Default lViaJob := IsInCallStack("U_MyT9NfePdf")
Private nConsNeg := 0.4 // Constante para concertar o cálculo retornado pelo GetTextWidth para fontes em negrito.
Private nConsTex := 0.38 // Constante para concertar o cálculo retornado pelo GetTextWidth.
private oRetNF

Public  nMaxItem :=  MAXITEM

Private aNotaBol	:= {}
Private __cNumBor	 := ""
Private aBoletos	:= {}
Private oMySetup	:= oSetup    


CriaSx1(Padr("NFSIGW",Len(SX1->X1_GRUPO)))

MySetProp(@oDanfe,lViaJob,lAutomato)

Private PixelX := odanfe:nLogPixelX()
Private PixelY := odanfe:nLogPixelY()
Private aIdentCarga	:= {}
Private aEtiqCargas	:= {}
Private lExporta	:= .F.		//WM 2018-10-10 tratamento exportação
Private nVolSC5		:= 0		//WM 2018-10-10 tratamento exportação

If lViaJob
	DanfeProc(@oDanfe,Nil,cIdEnt,,,@lExistNfe,lIsLoja,lAutomato,lViaJob)
Else
	RptStatus( {|lEnd| DanfeProc(@oDanfe,@lEnd,cIdEnt,,,@lExistNfe,lIsLoja,lAutomato,lViaJob)},"Imprimindo Danfe...")
EndIf
                       
If lExistNfe        
	If MV_PAR21 <> 1              
		oDanfe:Preview() //Visualiza antes de imprimir
	EndIf               
Else
	If !lIsLoja
		Aviso("DANFE","Nenhuma NF-e a ser impressa nos parametros utilizados.",{"OK"},3)
	EndIf	
EndIf             

//Se SIGALOJA, o objeto oDANFE é destruido onde foi instanciado
If lIsLoja
	lRet := lExistNFe
Else
	FreeObj(oDANFE)
	oDANFE := Nil
EndIf

If Len(aBoletos) > 0	
	U_MailBor(aBoletos[1][1],aBoletos[1][2],aBoletos[Len(aBoletos)][2],cFilAnt,aBoletos[1][3])
EndIf

If MV_PAR22 == 1
	MyPrintEtiq()	
EndIf

RestArea(aArea)

Return(.T.)        


/*/{Protheus.doc} MyPrintEtiq
//TODO Descrição auto-gerada.
@author william.souza
@since 15/05/2020
@version 1.0
@return ${return}, ${return_description}

@type function
/*/
Static Function MyPrintEtiq()

Local cMyPrinter:= ""
Local oEtiqPrinter := Nil
Local nCont1	:= 1
Local cSql		:= ""
Local cAliasTmp	:= ""
Local lImprimiu := .F.

If Len(aEtiqCargas) > 0		
	
	CursorWait()
				
	For nCont1 := 1 To Len(aEtiqCargas)

		cAliasTmp	:= GetNextAlias()
		cSql		:= " SELECT "
		cSql		+= " 	ISNULL(COUNT(1),0) AS QTD "
		cSql		+= " FROM ( "
		cSql		+= " 		SELECT  "
		cSql		+= " 			DISTINCT "
		cSql		+= " 			 F2_CLIENTE "
		cSql		+= " 			,F2_LOJA "
		cSql		+= " 		FROM " + RetSqlName("SF2") + " SF2 "

		cSql		+= " 		WHERE F2_FILIAL = '" + aEtiqCargas[nCont1][1] + "' "
		cSql		+= " 		AND F2_CARGA = '" + aEtiqCargas[nCont1][2] + "' "
		cSql		+= " 		AND F2_SEQCAR = '" + aEtiqCargas[nCont1][3] + "' "
		cSql		+= " 		AND SF2.D_E_L_E_T_ = '  ' "
		cSql		+= " 		) AS T1 "
			
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAliasTmp,.F.,.T.)
		
		TcSetField(cAliasTmp,"QTD","N",0018,0000)
		
		(cAliasTmp)->(DbGoTop())
		
		If (cAliasTmp)->QTD > 1		
			
			If ValType(oEtiqPrinter) == "U"			
				cMyPrinter := U_MyRetPrinter()			
				oEtiqPrinter := FWMSPrinter():New("CTPAX072"+StrTran(Time(),":",""), IMP_SPOOL,,,.T.,,,cMyPrinter)
				oEtiqPrinter:SetPortrait()
				oEtiqPrinter:SetPaperSize(DMPAPER_A4)					
			EndIf
		
			U_CTPAX072(aEtiqCargas[nCont1][1],aEtiqCargas[nCont1][2], aEtiqCargas[nCont1][3], oEtiqPrinter, @lImprimiu)		
		EndIf
		
		(cAliasTmp)->(DbCloseArea())
				
	Next nCont1
	
	If lImprimiu
		oEtiqPrinter:Preview()	
	EndIf
	
	CursorArrow()
EndIf

Return()


Static Function MySetProp(oDanfe, lViaJob,lAutomato)

Default lViaJob		:= .F.
Default lAutomato	:= .F.

oDanfe:SetResolution(78) // Tamanho estipulado para a Danfe
oDanfe:SetLandscape()
oDanfe:SetPaperSize(DMPAPER_A4)
oDanfe:SetMargin(60,60,60,60)
oDanfe:lServer := if( lAutomato, .T., oMySetup:GetProperty(PD_DESTINATION)==AMB_SERVER )
// ----------------------------------------------
// Define saida de impressão
// ---------------------------------------------
If lAutomato .or. oMySetup:GetProperty(PD_PRINTTYPE) == IMP_PDF
	oDanfe:nDevice := IMP_PDF
	// ----------------------------------------------
	// Define para salvar o PDF
	// ----------------------------------------------
	
	If !lViaJob
		oDanfe:cPathPDF := oMySetup:aOptions[PD_VALUETYPE]
	EndIf
ElseIf oMySetup:GetProperty(PD_PRINTTYPE) == IMP_SPOOL
	oDanfe:nDevice := IMP_SPOOL
	// ----------------------------------------------
	// Salva impressora selecionada
	// ----------------------------------------------
	fwWriteProfString(GetPrinterSession(),"DEFAULT", oMySetup:aOptions[PD_VALUETYPE], .T.)
	oDanfe:cPrinter := oMySetup:aOptions[PD_VALUETYPE]
Endif

Return()    


Static Function MyNewPrinter(oDanfe, lViaJob)

Default lViaJob := .F.

If Right(RetFileName(oDanfe:cFilePrint),6) == StrTran(Time(),":","")
	Sleep(1000)
EndIf
                 							
oDanfe := FWMSPrinter():New("DANFE_"+Iif(Type("cIdEnt")<>"U",cIdEnt,"")+Dtos(MSDate())+StrTran(Time(),":",""), IMP_PDF, .F., /*cPathInServer*/, .T.)							

MySetProp(@oDanfe,lViaJob)

Return()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³DANFEProc ³ Autor ³ Eduardo Riera         ³ Data ³16.11.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rdmake de exemplo para impressão da DANFE no formato Retrato³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto grafico de impressao                    (OPC) ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function DanfeProc(oDanfe, lEnd, cIdEnt, cVal1,cVal2	,lExistNfe,lIsLoja,lAutomato,lViaJob)

Local aArea      := GetArea()
Local aAreaSF3   := {}
Local aNotas     := {}
Local aXML       := {}
Local aAutoriza  := {}
Local cNaoAut    := ""

Local cAliasSF3  := "SF3"
Local cWhere     := ""
Local cInner	 := ""
Local cEstenv	 := ""
Local cOrderBy	 := "%"
Local cAviso     := ""
Local cErro      := ""
Local cCodRetNFE := ""
Local cCodRetSF3 := ""
Local cMsgSF3    := ""
Local cCodRetNFE := ""
Local cAutoriza  := ""
Local cModalidade:= ""
Local cChaveSFT  := ""
Local cAliasSFT  := "SFT"
Local cCondicao	 := ""
Local cIndex	 := ""
Local cChave	 := ""
Local cCampos := ""
Local lFirst  := .T.

Local lSdoc  := TamSx3("F3_SERIE")[1] == 14
Local cFrom 	:= ""
Local cSerie := ""

Local lQuery     := .F.

Local nX         := 0
Local nI		 := 0

Local oNfe
Local nLenNotas
Local lImpDir	:=GetNewPar("MV_IMPDIR",.F.)
Local nLenarray	 := 0
Local nCursor	 := 0
Local lBreak	 := .F.
Local aGrvSF3    := {}
Local lUsaColab	:=  UsaColaboracao("1") 
Local lMVGfe	:= GetNewPar( "MV_INTGFE", .F. ) // Se tem integração com o GFE
Local lContinua := .T.
local lChave	:= .F.
local cChavSF3 := ""
Local lVerPerg := .F.
Local nTotalReg := 0
Local cPerg 	 := "NFSIGW"
Local cFilial	 := ""      
Local aCargas	 := {}
// DBM = Variavel Customizada para impressão da Danfe. Utiliza o XML da ITGS ou do Protheus.
// DBM X ITGS

Local lYPadrao	:= U_MyNewSX6("DBMT009_03"												,;
										".T."													,;
										"L"														,;
										"True = Pega o XML padrão do Protheus. False = Pega o XML da ITGS"	,;
										"True = Pega o XML padrão do Protheus. False = Pega o XML da ITGS"	,;
										"True = Pega o XML padrão do Protheus. False = Pega o XML da ITGS"	,;
										.F. )

default lEnd := .F.
Default lIsLoja	:= .F.
default lAutomato := .F.
Default lViaJob	:= .F.
Private oNfeDPEC
Private oNfe

//
// NFSIGW
// MV_PAR01 - Da Nota Fiscal
// MV_PAR02 - Até a Nota Fiscal
// MV_PAR03 - Da Série
// MV_PAR04 - Tipo de Operação [1=NF Entrada, 2=NF Saida]
// MV_PAR05 - Impressão [1=Pré-Visualiza, 2=Imprimir]
// MV_PAR06 - Imprime Verso [1=Sim, 2=Não]
// MV_PAR07 - Estado de Envio 
// MV_PAR08 - Imprime boleto ?
// MV_PAR09 - Imprime minuta ?
// MV_PAR10 - Ordem de impressão ?
// MV_PAR11 - Da carga ?
// MV_PAR12 - Ate carga ?
// MV_PAR13 - Da sequencia ?
// MV_PAR14 - Ate a sequencia ?
// MV_PAR15 - Do cliente ?
// MV_PAR16 - Da loja ?
// MV_PAR17 - Até o cliente ?
// MV_PAR18 - Até a loja ?
// MV_PAR19 - Da emissão ?
// MV_PAR20 - Até a emissão ?
// MV_PAR21 - Quebra impressão ?
// MV_PAR22 - Imprime etiquetas ?
// MV_PAR23 - Apenas NF Venda?
// MV_PAR24 - Da Transportadora?
// MV_PAR25 - Ate a Transportadora?
// MV_PAR26 - Imprime Roteiro de Entregas?
// MV_PAR27 - Imprime Resumo de Canhotos ?

If lIsLoja
	//Se SIGALOJA, define as perguntas que sao feitas no Pergunte NFSIGW
	MV_PAR01 := SF2->F2_DOC 
	MV_PAR02 := SF2->F2_DOC
	MV_PAR03 := SF2->F2_SERIE
	MV_PAR04 := 1	//NF de Saida
	MV_PAR05 := 1	//Frente e Verso - 1:Sim
	MV_PAR06 := 2	//DANFE simplificado - 2:Nao
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	//³                        Agroindustria                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If FindFunction("OGXUtlOrig") //Encontra a função
		If OGXUtlOrig() // Retorna se tem integração com Agro/originação modulo 67
			If FindFunction("AGRXPERG")
				lVerPerg := AGRXPERG()
			EndIf
		EndIf
	Endif
	
	If lVerPerg
		lContinua := Pergunte("NFSIGW",.T.)  .AND. ( (!Empty(MV_PAR06) .AND. MV_PAR06 == 2) .OR. Empty(MV_PAR06) )
	EndIf
EndIf

If Iif(lViaJob.or.lIsLoja,.T.,Pergunte("NFSIGW",.T.)) .And. ( !Empty( MV_PAR06 ) .and. MV_PAR06 == 2 .Or. ( Empty( MV_PAR06 ) )) // "CATUPDANFE"
 
	MV_PAR01 := AllTrim(MV_PAR01)
	If !lImpDir
		dbSelectArea("SF3")
		dbSetOrder(5)
		#IFDEF TOP

			If MV_PAR04==1

			 	If lSdoc                                         
					cCampos += ", SF3.F3_SDOC" 
					cSerie := Padr(MV_PAR03,TamSx3("F3_SDOC")[1])
					cWhere := "%SubString(SF3.F3_CFO,1,1) < '5' AND SF3.F3_FORMUL='S' AND SF3.F3_SDOC = '"+ cSerie + "' AND SF3.F3_ESPECIE = 'SPED'" 			
				Else
					cSerie := Padr(MV_PAR03,TamSx3("F3_SERIE")[1])
					cWhere := "%SubString(SF3.F3_CFO,1,1) < '5' AND SF3.F3_FORMUL='S' AND SF3.F3_SERIE = '"+ cSerie + "' AND SF3.F3_ESPECIE = 'SPED'" 
				Endif

			ElseIf MV_PAR04==2
	
			 	If lSdoc                                         
					cCampos += ", SF3.F3_SDOC" 
					cSerie := Padr(MV_PAR03,TamSx3("F3_SDOC")[1])
					cWhere := "%SubString(SF3.F3_CFO,1,1) >= '5' AND SF3.F3_SDOC = '"+ cSerie + "' AND SF3.F3_ESPECIE = 'SPED'"		
				Else
					cSerie := Padr(MV_PAR03,TamSx3("F3_SERIE")[1])
					cWhere := "%SubString(SF3.F3_CFO,1,1) >= '5' AND SF3.F3_SERIE = '"+ cSerie + "' AND SF3.F3_ESPECIE = 'SPED'" 
				Endif	
			Else
			
				If lSdoc                                         
					cCampos += ", SF3.F3_SDOC" 
					cSerie := Padr(MV_PAR03,TamSx3("F3_SDOC")[1])
					cWhere := "%SF3.F3_SDOC = '"+ cSerie + "' AND SF3.F3_ESPECIE = 'SPED'" 		
				Else
					cSerie := Padr(MV_PAR03,TamSx3("F3_SERIE")[1])
					cWhere := "%SF3.F3_SERIE = '"+ cSerie + "' AND SF3.F3_ESPECIE = 'SPED'" 
				Endif	
			
			EndIf

          	If lSdoc 
				If !Empty(MV_PAR07) .Or. !Empty(MV_PAR08)
					cWhere += " AND (SF3.F3_EMISSAO >= '"+ SubStr(DTOS(MV_PAR07),1,4) + SubStr(DTOS(MV_PAR07),5,2) + SubStr(DTOS(MV_PAR07),7,2) + "' AND SF3.F3_EMISSAO <= '"+ SubStr(DTOS(MV_PAR08),1,4) + SubStr(DTOS(MV_PAR08),5,2) + SubStr(DTOS(MV_PAR08),7,2) + "')"
				EndIF
			EndIF

			
			cWhere += "%"
			
			cAliasSF3 := GetNextAlias()
			lQuery    := .T.

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Campos que serao adicionados a query somente se existirem na base³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Empty(cCampos)
				cCampos := "%%"
			Else       
				cCampos := "% " + cCampos + " %"
			Endif 
			
			If mv_par04 == 2 
					    	
		    	If !Empty( mv_par07 )
			    	cEstenv :="%AND SF2.F2_ESTENVI = '"+mv_par07+"'%"
			    Else
			    	cEstenv :="%"
			    EndIf
			    
			    If MV_PAR10 == 2                        
				    cOrderBy := "%F3_FILIAL, F3_NFISCAL, F3_SERIE, F3_CLIEFOR, F3_LOJA%"
			    ElseIf  MV_PAR10 == 1
				    cOrderBy := "%F2_FILIAL, F2_CARGA, F2_SEQCAR, DAI_SEQUEN %"
				Else
					cOrderBy := "%F2_FILIAL, F2_EMISSAO%"
				EndIf
			    
			EndIf 
			               
			/*
			Entradas
			*/
			If MV_PAR04==1
				
				BeginSql Alias cAliasSF3
					
					COLUMN F3_ENTRADA AS DATE
					COLUMN F3_DTCANC AS DATE
					
					SELECT	 F3_FILIAL
							,F3_ENTRADA
							,F3_NFELETR
							,F3_CFO
							,F3_FORMUL
							,F3_NFISCAL
							,F3_SERIE
							,F3_CLIEFOR
							,F3_LOJA
							,F3_ESPECIE
							,F3_DTCANC
					FROM %Table:SF3% SF3
					WHERE SF3.F3_FILIAL = %xFilial:SF3% 
					AND SF3.F3_SERIE = %Exp:MV_PAR03% 
					AND SF3.F3_NFISCAL >= %Exp:MV_PAR01% 
					AND SF3.F3_NFISCAL <= %Exp:MV_PAR02% 
					AND %Exp:cWhere% 
					AND SF3.F3_DTCANC = %Exp:Space(8)% 
					AND SF3.%notdel% 															
				EndSql

			/*
			Saídas
			*/			
			Else 
			     
				BeginSql Alias cAliasSF3
					
					COLUMN F3_ENTRADA AS DATE
					COLUMN F3_DTCANC AS DATE
					
					SELECT	 F3_FILIAL
							,F3_ENTRADA
							,F3_NFELETR
							,F3_CFO
							,F3_FORMUL
							,F3_NFISCAL
							,F3_SERIE
							,F3_CLIEFOR
							,F3_LOJA
							,F3_ESPECIE
							,F3_DTCANC
							,F2_FILIAL
							,F2_CARGA
							,F2_SEQCAR
							,DAI_SEQUEN
					FROM %Table:SF3% SF3
					
					INNER JOIN %Table:SF2% SF2
					ON SF2.F2_FILIAL = SF3.F3_FILIAL
					AND SF2.F2_SERIE = SF3.F3_SERIE 
					AND SF2.F2_DOC = SF3.F3_NFISCAL 
					AND SF2.F2_CLIENTE = SF3.F3_CLIEFOR 
					AND SF2.F2_LOJA = SF3.F3_LOJA       
					AND SF2.F2_CARGA BETWEEN %Exp:MV_PAR11%  AND %Exp:MV_PAR12% 
					AND SF2.F2_SEQCAR BETWEEN %Exp:MV_PAR13%  AND %Exp:MV_PAR14% 					
					AND SF2.%notdel%


					LEFT JOIN %Table:DAI% DAI
					ON DAI.DAI_FILIAL = SF2.F2_FILIAL 
					AND DAI.DAI_COD = SF2.F2_CARGA
					AND DAI.DAI_SEQCAR = SF2.F2_SEQCAR
					AND DAI.DAI_SERIE = SF2.F2_SERIE
					AND DAI.DAI_NFISCA = SF2.F2_DOC 
					AND DAI.DAI_CLIENT = SF2.F2_CLIENTE 
					AND DAI.DAI_LOJA = SF2.F2_LOJA
					AND SF2.%notdel%
					
					WHERE SF3.F3_FILIAL = %xFilial:SF3% 
					AND SF3.F3_SERIE = %Exp:MV_PAR03% 
					AND SF3.F3_NFISCAL >= %Exp:MV_PAR01% 
					AND SF3.F3_NFISCAL <= %Exp:MV_PAR02% 
					AND SF3.F3_CLIEFOR BETWEEN %Exp:MV_PAR15% AND %Exp:MV_PAR17%
					AND SF3.F3_LOJA BETWEEN %Exp:MV_PAR16% AND %Exp:MV_PAR18%
					AND SF3.F3_EMISSAO BETWEEN %Exp:MV_PAR19% AND %Exp:MV_PAR20%
					AND SF3.F3_DTCANC = %Exp:Space(8)% 
					AND SF3.%notdel%                
					
					%Exp:cEstenv%
					AND %Exp:cWhere% 
					
					ORDER BY %Exp:cOrderBy%
										
				EndSql			
			
			EndIf
			
		#ELSE       
			MsSeek(xFilial("SF3")+MV_PAR03+MV_PAR01,.T.)		
			cIndex    		:= CriaTrab(NIL, .F.)
			cChave			:= IndexKey(6)
			cCondicao 		:= 'F3_FILIAL == "' + xFilial("SF3") + '" .And. '
			cCondicao 		+= 'SF3->F3_SERIE =="'+ MV_PAR03+'" .And. '
			cCondicao 		+= 'SF3->F3_NFISCAL >="'+ MV_PAR01+'" .And. '
			cCondicao		+= 'SF3->F3_NFISCAL <="'+ MV_PAR02+'" .And. '
			cCondicao		+= 'SF3->F3_ESPECIE = "SPED" .And. '
			cCondicao		+= 'Empty(SF3->F3_DTCANC)'
			IndRegua(cAliasSF3, cIndex, cChave, , cCondicao)
			nIndex := RetIndex(cAliasSF3)
		            DBSetIndex(cIndex + OrdBagExt())
		            DBSetOrder(nIndex + 1)
			DBGoTop()
		#ENDIF
		If MV_PAR04==1
			cWhere := "SubStr(F3_CFO,1,1) < '5' .AND. F3_FORMUL=='S'"
		Elseif MV_PAR04==2
			cWhere := "SubStr(F3_CFO,1,1) >= '5'"
		Else
			cWhere := ".T."
		EndIf
		
		If lSdoc
			cSerId := (cAliasSF3)->F3_SDOC
		Else
			cSerId := (cAliasSF3)->F3_SERIE
		EndIf
		
		While !Eof() .And. xFilial("SF3") == (cAliasSF3)->F3_FILIAL .And.;
			cSerId == MV_PAR03 .And.;
			(cAliasSF3)->F3_NFISCAL >= MV_PAR01 .And.;
			(cAliasSF3)->F3_NFISCAL <= MV_PAR02
			
			cFilial := (cAliasSF3)->F3_FILIAL
			dbSelectArea(cAliasSF3)
			If  Empty((cAliasSF3)->F3_DTCANC) .And. &cWhere //.And. AModNot((cAliasSF3)->F3_ESPECIE)=="55"
				
				If (SubStr((cAliasSF3)->F3_CFO,1,1)>="5" .Or. (cAliasSF3)->F3_FORMUL=="S") .And. aScan(aNotas,{|x| x[4]+x[5]+x[6]+x[7]==(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA})==0
					
					aadd(aNotas,{})
					aadd(Atail(aNotas),.F.)
					aadd(Atail(aNotas),IIF((cAliasSF3)->F3_CFO<"5","E","S"))
					aadd(Atail(aNotas),(cAliasSF3)->F3_ENTRADA)
					aadd(Atail(aNotas),(cAliasSF3)->F3_SERIE)
					aadd(Atail(aNotas),(cAliasSF3)->F3_NFISCAL)
					aadd(Atail(aNotas),(cAliasSF3)->F3_CLIEFOR)
					aadd(Atail(aNotas),(cAliasSF3)->F3_LOJA)
					
				EndIf
			EndIf
			
			dbSelectArea(cAliasSF3)
			dbSkip()

			If lSdoc
				cSerId := (cAliasSF3)->F3_SDOC
			Else
				cSerId := (cAliasSF3)->F3_SERIE
			EndIf

			If lEnd
				Exit
			EndIf
			If Len(aNotas) >= 50 .Or. 	(cAliasSF3)->(Eof())
				aAreaSF3 := (cAliasSF3)->(GetArea())
				if lUsaColab
					//Tratamento do TOTVS Colaboração
					aXml := GetXMLColab(aNotas,@cModalidade,lUsaColab, lAutomato)
				else
					// lYPadrao DBM X ITGS
					aXml := GetXML(cIdEnt,aNotas,@cModalidade,lAutomato,lYPadrao, IIF(MV_PAR04==1,"0","1")  )
				endif	

				nLenNotas := Len(aNotas)
				For nX := 1 To nLenNotas
					If !Empty(aXML[nX][2])
						If !Empty(aXml[nX])
							cAutoriza		:= aXML[nX][1]
							cCodAutDPEC	:= aXML[nX][5]
							cCodRetNFE		:= aXML[nX][9]
							cCodRetSF3		:= iif ( Empty (cCodAutDPEC),cCodRetNFE,cCodAutDPEC )
							cMsgSF3		:= iif ( aXML[nX][10]<> Nil ,aXML[nX][10],"")
						Else
							cAutoriza		:= ""
							cCodAutDPEC	:= ""
							cCodRetNFE		:= ""
							cCodRetSF3		:= ""
							cMsgSF3		:= ""
							
						EndIf
						If (!Empty(cAutoriza) .Or. !Empty(cCodAutDPEC) .Or. Alltrim(aXML[nX][8])$"2,5,7") .And. !cCodRetNFE $ RetCodDene()
							If aNotas[nX][02]=="E"
								//DBClearFilter()
								dbSelectArea("SF1")
								dbSetOrder(1)
								If MsSeek(xFilial("SF1")+aNotas[nX][05]+aNotas[nX][04]+aNotas[nX][06]+aNotas[nX][07]) .And. SF1->(FieldPos("F1_FIMP")) <> 0 .And. Alltrim(aXML[nX][8])$"1,3,4,6" .or. ( Alltrim(aXML[nX][8]) $ "2,5"  .And. !Empty(cAutoriza) )
									RecLock("SF1")
									If !SF1->F1_FIMP$"D"
										SF1->F1_FIMP := "S"
										// DBM X ITGS
										SF1->F1_YIMPDNF := 'S'										
									EndIf
									If SF1->(FieldPos("F1_CHVNFE"))>0
										SF1->F1_CHVNFE := SubStr(NfeIdSPED(aXML[nX][2],"Id"),4)
									EndIf
									If SF1->(FieldPos("F1_HAUTNFE")) > 0 .and. SF1->(FieldPos("F1_DAUTNFE")) > 0 //grava a data e hora de autorização da NFe
										SF1->F1_HAUTNFE := IIF(!Empty(aXML[nX][6]),SUBSTR(aXML[nX][6],1,5),"")
				   						SF1->F1_DAUTNFE	:= IIF(!Empty(aXML[nX][7]),aXML[nX][7],SToD("  /  /    "))
									EndIf
									MsUnlock()
								EndIf
							Else
								dbSelectArea("SF2")
								dbSetOrder(1)
								If MsSeek(xFilial("SF2")+aNotas[nX][05]+aNotas[nX][04]+aNotas[nX][06]+aNotas[nX][07]) .And. Alltrim(aXML[nX][8])$"1,3,4,6,7".Or. ( Alltrim(aXML[nX][8]) $ "2,5"  .And. !Empty(cAutoriza) )
									RecLock("SF2")
									If !lViaJob
										If !SF2->F2_FIMP$"D"
											SF2->F2_FIMP := "S"
											// DBM X ITGS
											SF2->F2_YIMPDNF := 'S'										
										EndIf
									EndIf
									If SF2->(FieldPos("F2_CHVNFE"))>0
										SF2->F2_CHVNFE := SubStr(NfeIdSPED(aXML[nX][2],"Id"),4)
										SF2->F2_CODNFE := cAutoriza
									EndIf
									If SF2->(FieldPos("F2_HAUTNFE")) > 0 .and. SF2->(FieldPos("F2_DAUTNFE")) > 0 //grava a data e hota de autorização da NFe
										SF2->F2_HAUTNFE := IIF(!Empty(aXML[nX][6]),SUBSTR(aXML[nX][6],1,5),"")
				   						SF2->F2_DAUTNFE	:= IIF(!Empty(aXML[nX][7]),aXML[nX][7],SToD("  /  /    "))
									EndIf
									MsUnlock()
								// Grava quando a nota for Transferencia entre filiais 
								IF SF2->(FieldPos("F2_FILDEST"))> 0 .And. SF2->(FieldPos("F2_FORDES"))> 0 .And.SF2->(FieldPos("F2_LOJADES"))> 0 .And.SF2->(FieldPos("F2_FORMDES"))> 0 .And. !EMPTY (SF2->F2_FORDES)  
							       SF1->(dbSetOrder(1))
							    	If SF1->(MsSeek(SF2->F2_FILDEST+SF2->F2_DOC+SF2->f2_SERIE+SF2->F2_FORDES+SF2->F2_LOJADES+SF2->F2_FORMDES))
							    		If EMPTY(SF1->F1_CHVNFE)	
								    		RecLock("SF1",.F.)
									    		SF1->F1_CHVNFE := SubStr(NfeIdSPED(aXML[nX][2],"Id"),4)
								    		MsUnlock()
								    	EndIf	
							    	Endif					    
							    EndiF
								ElseIF MsSeek(xFilial("SF2")+aNotas[nX][05]+aNotas[nX][04]+aNotas[nX][06]+aNotas[nX][07]) .And. Alltrim(aXML[nX][8])$"1,3,4,6".Or. ( Alltrim(aXML[nX][8]) $ "2,5"  .And. cModalidade == "7"  ) //Contingencia FSDA
									RecLock("SF2")
									SF2->F2_CHVNFE := SubStr(NfeIdSPED(aXML[nX][2],"Id"),4)
									MsUnlock()
								EndIf
								
								lExporta := RetTipoNf()			//WM 2018-10-11 
								
								// Atualização dos campos da Tabela GFE
								if FindFunction("GFECHVNFE") .and. lMVGfe  // Integração com o GFE 
										
									dbSelectArea("SA1")
									dbSetOrder(1)
									If SA1->(MsSeek(xFilial("SA1")+ SF2->F2_CLIENTE + SF2->F2_LOJA,.T.))
										// Inicio WM 2018-10-10 Tratamento nota de exportação
										lExporta := RetTipoNf()
										// Fim WM
										GFECHVNFE(xFilial("SF2"),SF2->F2_SERIE,SF2->F2_DOC,SF2->F2_TIPO,SA1->A1_CGC,SA1->A1_COD,SA1->A1_LOJA,SF2->F2_CHVNFE,SF2->F2_FIMP)
										
									endif
								endif 

								If ExistFunc("STFMMd5NS") //Função do Controle de Lojas - Legislação PAF-ECF
									STFMMd5NS()
								EndIf
							EndIf
							dbSelectArea("SFT")
							dbSetOrder(1)
							If SFT->(FieldPos("FT_CHVNFE"))>0
								cChaveSFT	:=	(xFilial("SFT")+aNotas[nX][02]+aNotas[nX][04]+aNotas[nX][05]+aNotas[nX][06]+aNotas[nX][07])
								If MsSeek(cChaveSFT)
									Do While !(cAliasSFT)->(Eof ()) .And.;
										cChaveSFT==(cAliasSFT)->FT_FILIAL+(cAliasSFT)->FT_TIPOMOV+(cAliasSFT)->FT_SERIE+(cAliasSFT)->FT_NFISCAL+(cAliasSFT)->FT_CLIEFOR+(cAliasSFT)->FT_LOJA 
										If (cAliasSFT)->FT_TIPOMOV $"S" .Or. ((cAliasSFT)->FT_TIPOMOV $"E" .And. (cAliasSFT)->FT_FORMUL=='S')
											RecLock("SFT")
												SFT->FT_CHVNFE := SubStr(NfeIdSPED(aXML[nX][2],"Id"),4)
												SFT->FT_CODNFE := cAutoriza
											MsUnLock()
											//Array criado para gravar o SF3 no final, pois a tabela SF3 pode estah em processamento quando se trata de DBF ou AS/400.
											If aScan(aGrvSF3,{|aX|aX[1]+aX[2]+aX[3]+aX[4]+aX[5]==(cAliasSFT)->(FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA+FT_IDENTF3)})==0
												aAdd(aGrvSF3, {(cAliasSFT)->FT_SERIE,(cAliasSFT)->FT_NFISCAL,(cAliasSFT)->FT_CLIEFOR,(cAliasSFT)->FT_LOJA,(cAliasSFT)->FT_IDENTF3,(cAliasSFT)->FT_CHVNFE,cAutoriza,cCodRetSF3,cMsgSF3})
											EndIf										
										EndiF
										DbSkip()
									EndDo
								EndIf
							EndIf 
							// Grava quando a nota for Transferencia entre filiais  
							IF SF1->(!EOF()) .And. SF2->(FieldPos("F2_FILDEST"))> 0 .And. SF2->(FieldPos("F2_FORDES"))> 0 .And.SF2->(FieldPos("F2_LOJADES"))> 0 .And.SF2->(FieldPos("F2_FORMDES"))> 0 .And. !EMPTY (SF2->F2_FORDES)  
							  	SFT->(dbSetOrder(1))
								cChaveSFT := SF1->F1_FILIAL+"E"+SF1->F1_SERIE+SF1->F1_DOC+SF1->F1_FORNECE+SF1->F1_LOJA
								If SFT->(MsSeek(cChaveSFT))
									Do While cChaveSFT == SFT->FT_FILIAL+"E"+SFT->FT_SERIE+SFT->FT_NFISCAL+SFT->FT_CLIEFOR+SFT->FT_LOJA .And. !SFT->(Eof())
										RecLock("SFT")
											SFT->FT_CHVNFE := SubStr(NfeIdSPED(aXML[nX][2],"Id"),4)
											SFT->FT_CODNFE := cAutoriza
										MsUnLock()
										//Array criado para gravar o SF3 no final, pois a tabela SF3 pode estah em processamento quando se trata de DBF ou AS/400.
										If aScan(aGrvSF3,{|aX|aX[1]+aX[2]+aX[3]+aX[4]+aX[5]==(cAliasSFT)->(FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA+FT_IDENTF3)})==0
											aAdd(aGrvSF3, {(cAliasSFT)->FT_SERIE,(cAliasSFT)->FT_NFISCAL,(cAliasSFT)->FT_CLIEFOR,(cAliasSFT)->FT_LOJA,(cAliasSFT)->FT_IDENTF3,(cAliasSFT)->FT_CHVNFE,cAutoriza,cCodRetSF3,cMsgSF3})
										EndIf
										SFT->(dbSkip())
							    	EndDo
								EndIf
							EndIf														


							If MV_PAR10 == 1 .And. !lViaJob .And. aNotas[nX][02] <> "E"
                           	
                           		nPos := aScan(aCargas,SF2->(F2_FILIAL + F2_CARGA + F2_SEQCAR))
                           		                         		
                           		If nPos == 0 .And. !Empty(SF2->(F2_CARGA + F2_SEQCAR))
                           			
                           			SF2->(MyIdentCarga(oDanfe,F2_FILIAL,F2_CARGA,F2_SEQCAR))
                           			aAdd(aCargas,SF2->(F2_FILIAL + F2_CARGA + F2_SEQCAR))
                           			                           			
									If MV_PAR21 == 1		
										oDanfe:Preview()
										MyNewPrinter(@oDanfe,lViaJob)
									EndIf                           			
									
         							If MV_PAR26 == 1
	         							
	         							SF2->(MyRotEntre(oDanfe,F2_FILIAL,F2_CARGA,F2_SEQCAR))  
	         							       							
										If MV_PAR21 == 1		
											oDanfe:Preview()
											MyNewPrinter(@oDanfe,lViaJob)
										EndIf      
	         							
	         						EndIf
	         						
         							If MV_PAR27 == 1
	         							
	         							SF2->(MyResCanh(oDanfe,F2_FILIAL,F2_CARGA,F2_SEQCAR))         							
	         							
										If MV_PAR21 == 1		
											oDanfe:Preview()
											MyNewPrinter(@oDanfe,lViaJob)
										EndIf      
		         							
	         						EndIf
	         						
                           			
                           		EndIf
                           	
							EndIf
							
							cAviso := ""
							cErro  := ""
							//-----------------------------------------------------------------------
							// Validacao para quando for TOTVS Colaboracao, pois o retorno do 
							// xml sera o que vem da Neogrid, e nao o que enviamos.
							// Para que nao fosse alterado totalmente a estrutura do Objeto, 
							// atribui a variavel oRetNF o retorno, e abaixo identifico se possui 
							// o objeto NFEPROC, caso tenha, deixarei na mesma estrutura do legado.					
							// @autor: Douglas Parreja	@since 30/10/2017												
							//-----------------------------------------------------------------------												
							oRetNF := XmlParser(aXML[nX][2],"_",@cAviso,@cErro)				 	
							if ValAtrib("oRetNF:_NFEPROC") <> "U"
								oNfe := WSAdvValue( oRetNF,"_NFEPROC","string",NIL,NIL,NIL,NIL,NIL)				
							else
								oNfe := oRetNF
							endif
							
							oNfeDPEC := XmlParser(aXML[nX][4],"_",@cAviso,@cErro)

							If ValType(oNfe) == "U"
								AVISO("ERRO",aXML[nX][2],{"Ok"},3)
							EndIf
														
							aXML[nX][2] := StrTran(aXML[nX][2],"'","")
							aXML[nX][2] := StrTran(aXML[nX][2],"´","")
							aXML[nX][2] := StrTran(aXML[nX][2],"ç","c")
							aXML[nX][2] := StrTran(aXML[nX][2],"Ç","C")
							aXML[nX][2] := StrTran(aXML[nX][2],"ã","a")
							aXML[nX][2] := StrTran(aXML[nX][2],"Ã","A")
							aXML[nX][2] := StrTran(aXML[nX][2],"á","a")
							aXML[nX][2] := StrTran(aXML[nX][2],"Á","A")
							aXML[nX][2] := StrTran(aXML[nX][2],"à","a")
							aXML[nX][2] := StrTran(aXML[nX][2],"À","A")
							aXML[nX][2] := StrTran(aXML[nX][2],"õ","o")
							aXML[nX][2] := StrTran(aXML[nX][2],"Õ","O")
							aXML[nX][2] := StrTran(aXML[nX][2],"NÃO CADASTRADO;","")
							aXML[nX][2] := StrTran(aXML[nX][2],"NÃOCADASTRADO;","")
							aXML[nX][2] := StrTran(aXML[nX][2],"NAO CADASTRADO;","")
							aXML[nX][2] := StrTran(aXML[nX][2],"NAOCADASTRADO;","")
																			
							If Empty(cAviso) .And. Empty(cErro)
								ImpDet(@oDanfe,oNFe,cAutoriza,cModalidade,oNfeDPEC,cCodAutDPEC,aXml[nX][6],aXml[nX][7],aNotas[nX],aXml[nX][11],lViaJob)
								lExistNfe := .T.
							EndIf
							oNfe     := nil
							oNfeDPEC := nil
                    
							If MV_PAR21 == 1
								oDanfe:Preview()								
								MyNewPrinter(@oDanfe)								
							EndIf
	
						ElseIf lIsLoja							
							/*	Se o Codigo de Retorno da SEFAZ estiver preenchido e for maior que 200,
								entao houve rejeicao por parte da SEFAZ	*/
							If !Empty(aXML[nX][9]) .AND. Val(aXML[nX][9]) > 200 
								RecLock("SF2",.F.)
								Replace SF2->F2_FIMP with "N"
								SF2->( MsUnlock() )

								cNaoAut := "A impressão do DANFE referente a Nota/Série " + SF2->F2_DOC + "/" + SF2->F2_SERIE + " não será realizada pelo motivo abaixo:"
								cNaoAut += CRLF + "[" + aXML[nX][9] + ' - ' + aXML[nX][10] + "]"
								cNaoAut += CRLF + "Se possível, faça o ajuste e retransmita a NF-e."

								if !lAutomato		
									Aviso( "SPED", cNaoAut, {"Continuar"}, 3 )
								endif
							EndIf	

						Else
							cNaoAut += aNotas[nX][04]+aNotas[nX][05]+CRLF
						EndIf
					EndIf
					
				Next nX
				aNotas := {}
				
				RestArea(aAreaSF3)
				DelClassIntF()
			EndIf
		EndDo
		
		If !lQuery
			DBClearFilter()
			Ferase(cIndex+OrdBagExt())
		EndIf
		
		If !lIsLoja .AND. !Empty(cNaoAut) .and. !lAutomato
			Aviso("SPED","As seguintes notas não foram autorizadas: "+CRLF+CRLF+cNaoAut,{"Ok"},3)
		EndIf

	ElseIf  lImpDir
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Tratamento para quando o parametro MV_IMPDIR esteja        ³
		//³Habilitado, neste caso não será feita a impressão conforme ³
		//³Registros no SF3, e sim buscando XML diretamente do        ³
		//³webService, e caso exista será impresso.                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nLenarray := Val(MV_PAR02) - Val(Alltrim(MV_PAR01))
		nCursor   := Val(MV_PAR01)
		
		While  !lBreak  .And. nLenarray >= 0

			If lFirst			
				If MV_PAR04==1
				
					cxFilial := xFilial("SF1")
					cFrom	:=	"%"+RetSqlName("SF1")+" SF1 %"
	
				 	If lSdoc 
				 		cCampos += "%SF1.F1_FILIAL FILIAL, SF1.F1_DOC DOC, SF1.F1_SERIE SERIE, SF1.F1_SDOC SDOC%"                                         
						cSerie := Padr(MV_PAR03,TamSx3("F1_SDOC")[1])
						cWhere := "%SF1.D_E_L_E_T_= '' AND SF1.F1_FILIAL ='"+xFilial("SF1")+"' AND SF1.F1_DOC <='"+MV_PAR02+ "' AND SF1.F1_DOC >='" + MV_PAR01 + "' AND SF1.F1_SDOC ='"+ cSerie + "' AND SF1.F1_ESPECIE = 'SPED' AND SF1.F1_FORMUL = 'S'  ORDER BY SF1.F1_DOC%"			
					Else
						cCampos += "%SF1.F1_FILIAL FILIAL, SF1.F1_DOC DOC, SF1.F1_SERIE SERIE%"
						cSerie := Padr(MV_PAR03,TamSx3("F2_SERIE")[1])
						cWhere := "%SF1.D_E_L_E_T_= '' AND SF1.F1_FILIAL ='"+xFilial("SF1")+"' AND SF1.F1_DOC <='"+MV_PAR02+ "' AND SF1.F1_DOC >='" + MV_PAR01 + "' AND SF1.F1_SERIE ='"+ cSerie + "' AND SF1.F1_ESPECIE = 'SPED' AND SF1.F1_FORMUL = 'S'  ORDER BY SF1.F1_DOC%"
					Endif
	
				ElseIf MV_PAR04==2
					
					cxFilial := xFilial("SF2")	
					cFrom	:=	"%"+RetSqlName("SF2")+" SF2 %"
	
				 	If lSdoc  
				 		cCampos += "%SF2.F2_FILIAL FILIAL, SF2.F2_DOC DOC, SF2.F2_SERIE SERIE, SF2.F2_SDOC SDOC%"                                        
						cSerie := Padr(MV_PAR03,TamSx3("F2_SDOC")[1])
						cWhere := "%SF2.D_E_L_E_T_= '' AND SF2.F2_FILIAL ='"+xFilial("SF2")+"' AND SF2.F2_DOC <='"+MV_PAR02+ "' AND SF2.F2_DOC >='" + MV_PAR01 + "' AND SF2.F2_SDOC ='"+ cSerie + "' AND SF2.F2_ESPECIE = 'SPED' ORDER BY SF2.F2_DOC%"			
					Else
						cCampos += "%SF2.F2_FILIAL FILIAL, SF2.F2_DOC DOC, SF2.F2_SERIE SERIE%" 
						cSerie := Padr(MV_PAR03,TamSx3("F2_SERIE")[1])
						cWhere := "%SF2.D_E_L_E_T_= '' AND SF2.F2_FILIAL ='"+xFilial("SF2")+"' AND SF2.F2_DOC <='"+MV_PAR02+ "' AND SF2.F2_DOC >='" + MV_PAR01 + "' AND SF2.F2_SERIE ='"+ cSerie + "' AND SF2.F2_ESPECIE = 'SPED' AND SF2.F2_EMISSAO >= '" + %exp:DtoS(MV_PAR07)% + "' AND SF2.F2_EMISSAO <= '" + %exp:DtoS(MV_PAR08)% + "' ORDER BY SF2.F2_DOC%"			
					Endif
				
				EndIf
			EndIf	
			cAliasSFX := GetNextAlias()
			lQuery    := .T.
			lFirst    := .F.

			BeginSql Alias cAliasSFX			
				SELECT	
				%Exp:cCampos%
				FROM 
				%Exp:cFrom%
				WHERE
				%Exp:cWhere%
			EndSql

			nTotalReg := Contar(cAliasSFX, "!EOF()")
			(cAliasSFX)->(DBGoTop())

			If lSdoc
				cSerId := (cAliasSFX)->SDOC
			Else
				cSerId := (cAliasSFX)->SERIE
			EndIf
			
			If Empty(cSerId) .Or. lEnd
				lBreak :=.T.
			EndIf
			
			While !Eof() .And. !lBreak .And. ;
				cxFilial == (cAliasSFX)->FILIAL .And.;
				cSerId == MV_PAR03 .And.;
				(cAliasSFX)->DOC >= MV_PAR01 .And.;
				(cAliasSFX)->DOC <= MV_PAR02
										
				aNotas := {}
				For nx:=1 To 20
					aadd(aNotas,{})
					aAdd(Atail(aNotas),.F.)
					aadd(Atail(aNotas),IIF(MV_PAR04==1,"E","S"))
					aAdd(Atail(aNotas),"")
					aadd(Atail(aNotas),(cAliasSFX)->SERIE)
					aAdd(Atail(aNotas),(cAliasSFX)->DOC)
					aadd(Atail(aNotas),"")
					aadd(Atail(aNotas),"")
					If ( (cAliasSFX)->(Eof()) ) .OR. (nCursor >= nTotalReg)
						lBreak :=.T.
						nx:=20
					EndIF
					nCursor++
					( cAliasSFX )->( DbSkip() )
				Next nX

				aXml:={}
				if lUsaColab
					//Tratamento do TOTVS Colaboração
					aXml := GetXMLColab(aNotas,@cModalidade,lUsaColab, lAutomato)
				else		
					aXml := GetXML(cIdEnt,aNotas,@cModalidade, lAutomato)
				endif
				
				dbSelectArea(cAliasSFX)
				dbSkip()
				
				If lSdoc
					cSerId := (cAliasSFX)->SDOC
				Else
					cSerId := (cAliasSFX)->SERIE
				EndIf
			
			EndDo

			aXml:={}
			if lUsaColab
				//Tratamento do TOTVS Colaboração
				aXml := GetXMLColab(aNotas,@cModalidade,lUsaColab)
			else		
				// lYPadrao DBM X ITGS
				aXml := GetXML(cIdEnt,aNotas,@cModalidade,lYPadrao, IIF(MV_PAR04==1,"0","1")  )
			endif
			
			nLenNotas := Len(aNotas)
			For nx :=1 To nLenNotas
				dbSelectArea("SFT")
				dbSetOrder(1)
				cChaveSFT	:=	(xFilial("SFT")+aNotas[nX][02]+aNotas[nX][04]+aNotas[nX][05])
				MsSeek(cChaveSFT)
				If !Empty(aXML[nX][2]) .And. Empty((cAliasSFT)->FT_DTCANC) .AND. (AllTrim((cAliasSFT)->FT_ESPECIE)== 'SPED') .Or. (lImpDir .And. !Empty(aXML[nX][2]))//Realizada tal alteração para que seja verificado antes da impressão se a NF-e está cancelada ou e do modelo sped
					If !Empty(aXml[nX])
						cAutoriza   := aXML[nX][1]
						cCodAutDPEC := aXML[nX][5]
						cCodRetNFE	:= aXML[nX][9]
						cCodRetSF3	:= iif ( Empty (cCodAutDPEC),cCodRetNFE,cCodAutDPEC )
						cMsgSF3 	:= iif ( aXML[nX][10]<> Nil ,aXML[nX][10],"")
					Else
						cAutoriza   := ""
						cCodAutDPEC := ""
						cCodRetNFE	:= ""
						cCodRetSF3		:= ""
						cMsgSF3		:= ""
					EndIf
					cAviso := ""
					cErro  := ""
					aXML[nX][2] := StrTran(aXML[nX][2],"'","")
					aXML[nX][2] := StrTran(aXML[nX][2],"´","")
					aXML[nX][2] := StrTran(aXML[nX][2],"ç","c")
					aXML[nX][2] := StrTran(aXML[nX][2],"ã","a")
					aXML[nX][2] := StrTran(aXML[nX][2],"Ã","A")
					aXML[nX][2] := StrTran(aXML[nX][2],"õ","o")
					aXML[nX][2] := StrTran(aXML[nX][2],"Õ","O")
					aXML[nX][2] := StrTran(aXML[nX][2],"NÃO CADASTRADO;","")
					aXML[nX][2] := StrTran(aXML[nX][2],"NÃOCADASTRADO;","")
					aXML[nX][2] := StrTran(aXML[nX][2],"NAO CADASTRADO;","")
					aXML[nX][2] := StrTran(aXML[nX][2],"NAOCADASTRADO;","")
					
					oNfe := XmlParser(aXML[nX][2],"_",@cAviso,@cErro)
					oNfe:_NFE // By Deny 19.11.2011					
					oNfeDPEC := XmlParser(aXML[nX][4],"_",@cAviso,@cErro)
					If (!Empty(cAutoriza) .Or. !Empty(cCodAutDPEC) .Or. Alltrim(aXML[nX][8])$"2,5,7") .And. !cCodRetNFE $ RetCodDene()
						//------------------------------
						If aNotas[nX][02]=="E" .And. MV_PAR04==1 .And. (oNfe:_NFE:_INFNFE:_IDE:_TPNF:TEXT=="0")
							dbSelectArea("SF1")
							dbSetOrder(1)
							If MsSeek(xFilial("SF1")+aNotas[nX][05]+aNotas[nX][04]) .And. SF1->(FieldPos("F1_FIMP"))<>0 .And. Alltrim(aXML[nX][8])$"1,3,4,6" .or. ( Alltrim(aXML[nX][8]) $ "2,5"  .And. !Empty(cAutoriza) )
								Do While !Eof() .And. SF1->F1_DOC==aNotas[nX][05] .And. SF1->F1_SERIE==aNotas[nX][04]
									If SF1->F1_FORMUL=='S'
										RecLock("SF1")
										If !SF1->F1_FIMP$"D"
											SF1->F1_FIMP := "S"
											// DBM X ITGS
											SF1->F1_YIMPDNF := 'S'
										EndIf
										If SF1->(FieldPos("F1_CHVNFE"))>0
											SF1->F1_CHVNFE := SubStr(NfeIdSPED(aXML[nX][2],"Id"),4)
										EndIf
										If SF1->(FieldPos("F1_HAUTNFE")) > 0 .and. SF1->(FieldPos("F1_DAUTNFE")) > 0 //grava a data e hora de autorização da NFe
											SF1->F1_HAUTNFE := IIF(!Empty(aXML[nX][6]),SUBSTR(aXML[nX][6],1,5),"")
				   							SF1->F1_DAUTNFE	:= IIF(!Empty(aXML[nX][7]),aXML[nX][7],SToD("  /  /    "))
										EndIf
										MsUnlock()
									EndIf
									DbSkip()									
								EndDo
							EndIf
							
							// Atualização dos campos da Tabela GFE
							if FindFunction("GFECHVNFE") .and. lMVGfe  // Integração com o GFE 
									
								dbSelectArea("SA2")
								dbSetOrder(1)
								If SA2->(MsSeek(xFilial("SA2")+ SF1->F1_FORNECE + SF1->F1_LOJA,.T.))
									
									GFECHVNFE(xFilial("SF1"),SF1->F1_SERIE,SF1->F1_DOC,SF1->F1_TIPO,SA2->A2_CGC,SA2->A2_COD,SA2->A2_LOJA,SF1->F1_CHVNFE,SF1->F1_FIMP)
									
								endif
							endif							
							
						ElseIf aNotas[nX][02]=="S" .And. MV_PAR04==2 .And. (oNfe:_NFE:_INFNFE:_IDE:_TPNF:TEXT=="1")
							dbSelectArea("SF2")
							dbSetOrder(1)
							If MsSeek(xFilial("SF2")+PADR(aNotas[nX][05],TAMSX3("F2_DOC")[1])+aNotas[nX][04]) .And. Alltrim(aXML[nX][8])$"1,3,4,6,7" .Or. ( Alltrim(aXML[nX][8]) $ "2"  .And. !Empty(cAutoriza) )
								RecLock("SF2")
								If !lViaJob
									If !SF2->F2_FIMP$"D"
										SF2->F2_FIMP := "S"
										// DBM X ITGS
										SF2->F2_YIMPDNF := 'S'
									EndIf
								EndIf
								If SF2->(FieldPos("F2_CHVNFE"))>0
									SF2->F2_CHVNFE := SubStr(NfeIdSPED(aXML[nX][2],"Id"),4)
								EndIf
								If SF2->(FieldPos("F2_HAUTNFE")) > 0 .and. SF2->(FieldPos("F2_DAUTNFE")) > 0 //grava a data e hota de autorização da NFe
									SF2->F2_HAUTNFE := IIF(!Empty(aXML[nX][6]),SUBSTR(aXML[nX][6],1,5),"")
			   						SF2->F2_DAUTNFE	:= IIF(!Empty(aXML[nX][7]),aXML[nX][7],SToD("  /  /    "))
								EndIf
								MsUnlock()								
								// Grava quando a nota for Transferencia entre filiais 
								IF SF2->(FieldPos("F2_FILDEST"))> 0 .And. SF2->(FieldPos("F2_FORDES"))> 0 .And.SF2->(FieldPos("F2_LOJADES"))> 0 .And.SF2->(FieldPos("F2_FORMDES"))> 0 .And. !EMPTY (SF2->F2_FORDES)  
							       SF1->(dbSetOrder(1))
							    	If SF1->(MsSeek(SF2->F2_FILDEST+SF2->F2_DOC+SF2->f2_SERIE+SF2->F2_FORDES+SF2->F2_LOJADES+SF2->F2_FORMDES))
							    		If EMPTY(SF1->F1_CHVNFE)	
								    		RecLock("SF1",.F.)
								    		SF1->F1_CHVNFE := SF2->F2_CHVNFE
								    		MsUnlock()
								    	EndIf	
							    	Endif					    
							    EndiF								
							EndIf
							
							// Atualização dos campos da Tabela GFE
							if FindFunction("GFECHVNFE") .and. lMVGfe  // Integração com o GFE 
									
								dbSelectArea("SA1")
								dbSetOrder(1)
								If SA1->(MsSeek(xFilial("SA1")+ SF2->F2_CLIENT + SF2->F2_LOJA,.T.))
									// Inicio WM 2018-10-10 Tratamento nota de exportação
									lExporta := RetTipoNf()
									// Fim WM

									
									GFECHVNFE(xFilial("SF2"),SF2->F2_SERIE,SF2->F2_DOC,SF2->F2_TIPO,SA1->A1_CGC,SA1->A1_COD,SA1->A1_LOJA,SF2->F2_CHVNFE,SF2->F2_FIMP)
									
								endif
							endif
							
						EndIf	
						dbSelectArea("SFT")
						dbSetOrder(1)
						If SFT->(FieldPos("FT_CHVNFE"))>0
							cChaveSFT	:=	(xFilial("SFT")+aNotas[nX][02]+aNotas[nX][04]+padr(aNotas[nX][05],TamSx3("FT_NFISCAL")[1],""))
							IF MsSeek(cChaveSFT)
								Do While !(cAliasSFT)->(Eof ()) .And.;
									cChaveSFT==(cAliasSFT)->FT_FILIAL+(cAliasSFT)->FT_TIPOMOV+(cAliasSFT)->FT_SERIE+(cAliasSFT)->FT_NFISCAL
									If (cAliasSFT)->FT_TIPOMOV $"S" .Or. ((cAliasSFT)->FT_TIPOMOV $"E" .And. (cAliasSFT)->FT_FORMUL=='S')
										RecLock("SFT")
										SFT->FT_CHVNFE := SubStr(NfeIdSPED(aXML[nX][2],"Id"),4)
										MsUnLock()
										//Array criado para gravar o SF3 no final, pois a tabela SF3 pode estah em processamento quando se trata de DBF ou AS/400.
										If aScan(aGrvSF3,{|aX|aX[1]+aX[2]+aX[3]+aX[4]+aX[5]==(cAliasSFT)->(FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA+FT_IDENTF3)})==0
											aAdd(aGrvSF3, {(cAliasSFT)->FT_SERIE,(cAliasSFT)->FT_NFISCAL,(cAliasSFT)->FT_CLIEFOR,(cAliasSFT)->FT_LOJA,(cAliasSFT)->FT_IDENTF3,(cAliasSFT)->FT_CHVNFE,cAutoriza,cCodRetSF3,cMsgSF3})
										EndIf
									EndIf
									DbSkip()
								EndDo
							Endif
						EndIf
						// Grava quando a nota for Transferencia entre filiais 
						IF SF1->(!EOF()) .And. SF2->(FieldPos("F2_FILDEST"))> 0 .And. SF2->(FieldPos("F2_FORDES"))> 0 .And.SF2->(FieldPos("F2_LOJADES"))> 0 .And.SF2->(FieldPos("F2_FORMDES"))> 0 .And. !EMPTY (SF2->F2_FORDES)  
						  	SFT->(dbSetOrder(1))
							cChave := SF1->F1_FILIAL+"E"+SF1->F1_SERIE+SF1->F1_DOC+SF1->F1_FORNECE+SF1->F1_LOJA
							If SFT->(MsSeek(SF1->F1_FILIAL+"E"+SF1->F1_SERIE+SF1->F1_DOC+SF1->F1_FORNECE+SF1->F1_LOJA,.T.))
								Do While cChave == SFT->FT_FILIAL+"E"+SFT->FT_SERIE+SFT->FT_NFISCAL+SFT->FT_CLIEFOR+SFT->FT_LOJA .And. !SFT->(Eof())
										SFT->FT_CHVNFE := SubStr(NfeIdSPED(aXML[nX][2],"Id"),4)
										SFT->FT_CODNFE := cAutoriza
										MsUnLock()
										//Array criado para gravar o SF3 no final, pois a tabela SF3 pode estah em processamento quando se trata de DBF ou AS/400.
										If aScan(aGrvSF3,{|aX|aX[1]+aX[2]+aX[3]+aX[4]+aX[5]==(cAliasSFT)->(FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA+FT_IDENTF3)})==0
											aAdd(aGrvSF3, {(cAliasSFT)->FT_SERIE,(cAliasSFT)->FT_NFISCAL,(cAliasSFT)->FT_CLIEFOR,(cAliasSFT)->FT_LOJA,(cAliasSFT)->FT_IDENTF3,(cAliasSFT)->FT_CHVNFE,cAutoriza,cCodRetSF3,cMsgSF3})
										EndIf
									MsUnLock()
									SFT->(dbSkip())
						    	EndDo
							EndIf
						EndIf
						//-------------------------------
						If Empty(cAviso) .And. Empty(cErro) .And. MV_PAR04==1 .And. (oNfe:_NFE:_INFNFE:_IDE:_TPNF:TEXT=="0")
							ImpDet(@oDanfe,oNFe,cAutoriza,cModalidade,oNfeDPEC,cCodAutDPEC,aXml[nX][6],aXml[nX][7],aNotas[nX],lViaJob)
							lExistNfe := .T.							
						ElseIf Empty(cAviso) .And. Empty(cErro) .And. MV_PAR04==2 .And. (oNfe:_NFE:_INFNFE:_IDE:_TPNF:TEXT=="1")
							ImpDet(@oDanfe,oNFe,cAutoriza,cModalidade,oNfeDPEC,cCodAutDPEC,aXml[nX][6],aXml[nX][7],aNotas[nX])
							lExistNfe := .T.
						EndIf
					ElseIf lIsLoja							
						/*	Se o Codigo de Retorno da SEFAZ estiver preenchido e for maior que 200,
							entao houve rejeicao por parte da SEFAZ	*/
						If !Empty(aXML[nX][9]) .AND. Val(aXML[nX][9]) > 200 
							RecLock("SF2",.F.)
							Replace SF2->F2_FIMP with "N"
							SF2->( MsUnlock() )

							cNaoAut := "A impressão do DANFE referente a Nota/Série " + SF2->F2_DOC + "/" + SF2->F2_SERIE + " não será realizada pelo motivo abaixo:"
							cNaoAut += CRLF + "[" + aXML[nX][9] + ' - ' + aXML[nX][10] + "]."
							cNaoAut += CRLF + "Se possível, faça o ajuste e retransmita a NF-e."
									
							Aviso( "SPED", cNaoAut, {"Continuar"}, 3 )
						EndIf
					Else
						cNaoAut += aNotas[nX][04]+aNotas[nX][05]+CRLF
					EndIf
	
					oNfe     := nil
					oNfeDPEC := nil
					delClassIntF()				
				EndIF
			Next nx
		EndDo

		If !lIsLoja .AND. !Empty(cNaoAut) .and. !lAutomato
			Aviso("SPED","As seguintes notas não foram autorizadas: "+CRLF+CRLF+cNaoAut,{"Ok"},3)
		EndIf
    EndIf
    
ElseIf ( !Empty( MV_PAR06 ) .and. MV_PAR06 == 1 )
	if !lAutomato
		Aviso("DANFE","Impressão de DANFE Simplificada, disponível somente em formato retrato.",{"OK"},3)	    
	endif
EndIf

// Se chamado pelo colaboradores do Televendas e/ou que usam o modulo Call Center
If cModulo == 'TMK'
	If Len( aGrvSF3 ) <> 0
		U_GRVLOGARQ('DANFEII',MV_PAR01,MV_PAR02,MV_PAR03,MV_PAR07,cPerg,'S', AllTrim( Str( Len( aNotas ) ) ) + ' Nota(s) Fiscal(is).' )
	EndIf
EndIf 

If Len(aGrvSF3)>0 .And. SF3->(FieldPos("F3_CHVNFE"))>0
	SF3->( dbSetOrder( 5 ))
	For nI := 1 To Len(aGrvSF3)
		cChavSF3 :=  xFilial("SF3")+aGrvSF3[nI,1]+aGrvSF3[nI,2]+aGrvSF3[nI,3]+aGrvSF3[nI,4]+aGrvSF3[nI,5]	
		If SF3->(MsSeek(xFilial("SF3")+aGrvSF3[nI,1]+aGrvSF3[nI,2]+aGrvSF3[nI,3]+aGrvSF3[nI,4]+aGrvSF3[nI,5]))
			Do While cChavSF3 == xFilial("SF3")+SF3->F3_SERIE+SF3->F3_NFISCAL+SF3->F3_CLIEFOR+SF3->F3_LOJA+SF3->F3_IDENTFT .And. !SF3->(Eof())
				lChave := iif( lUsacolab, .T., Empty(SF3->F3_CHVNFE) )
				If (Val(SF3->F3_CFO) >= 5000 .Or. SF3->F3_FORMUL=='S') .And. lChave
					RecLock("SF3",.F.)
					SF3->F3_CHVNFE := aGrvSF3[nI,6] // Chave da nota
					SF3->F3_PROTOC := aGrvSF3[nI,7] // Protocolo
					SF3->F3_CODRSEF:= aGrvSF3[nI,8] // Codigo de retorno Sefaz
					SF3->F3_DESCRET:= aGrvSF3[nI,9] // Mensagem de retorno Sefaz
					SF3->F3_CODRET := iif (SF3->(FieldPos("F3_CODRET"))>0,"M",)
					MsUnLock()
				EndIf
				SF3->(dbSkip())
			EndDo
		EndIf
	Next nI
EndIf
RestArea(aArea)
Return(.T.)

Static Function MyIdentCarga(oDanfe, cMyFilial, cMyCarga, cMySeq )
                                                                                         
Local aAreaDAK	:= DAK->(GetArea())
Local oFont1	:= TFont():New("Calibri (Corpo)",Nil,-48,Nil,.T.,Nil,Nil,Nil,Nil,.F.,.F.)
Local oFont2	:= TFont():New("Calibri (Corpo)",Nil,-36,Nil,.F.,Nil,Nil,Nil,Nil,.F.,.F.)
Local oFont3	:= TFont():New("Calibri (Corpo)",Nil,-56,Nil,.T.,Nil,Nil,Nil,Nil,.F.,.F.)
Local oFont4	:= TFont():New("Calibri (Corpo)",Nil,-10,Nil,.F.,Nil,Nil,Nil,Nil,.F.,.F.)
Local oFont5	:= TFont():New("Calibri (Corpo)",Nil,-25,Nil,.T.,Nil,Nil,Nil,Nil,.F.,.F.)

DAK->(DbSetOrder(1))
DA3->(DbSetOrder(3))
SX5->(DbSetOrder(1))

If DAK->( DbSeek(		Padr(cMyFilial,TamSx3("DAK_FILIAL")[1]) ;
					+	Padr(cMyCarga,TamSx3("DAK_COD")[1]) 	;
					+	Padr(cMySeq,TamSx3("DAK_SEQCAR")[1])	))

	oDanfe:StartPage()
	                        
	oDanfe:Say(-0003,0820, "Pag.: " + Alltrim(Str(oDanfe:nPageCount)),oFont4,,,)	
	
	oDanfe:Say(0090,0120, "Filial/Carga/Seq/Romaneio",oFont1,,,)
	oDanfe:Say(0150,0190, Alltrim(DAK->DAK_FILIAL) + "/" + Alltrim(DAK->DAK_COD) + "/" + Alltrim(DAK->DAK_SEQCAR) + "/" + Alltrim(DAK->DAK_YROMTR),oFont2,,,)	
	
	If SX5->( DbSeek( xFilial("SX5") + "Z3" + DAK->DAK_YHORA ) )
		oDanfe:Say(0230,0030, "Carreg. ás " + Alltrim(SX5->X5_DESCRI),oFont2,,,)	
	EndIf
	
	If !Empty(DAK->DAK_YCOD2)
		oDanfe:Say(0270,0180, "Carga complem.: " + Alltrim(DAK->DAK_YFIL2) + "/" + Alltrim(DAK->DAK_YCOD2) + "/" + Alltrim(DAK->DAK_YSEQ2) ,oFont5,,,)	
	EndIf
	
	oDanfe:Say(0300,0345, Alltrim(DAK->DAK_YPLACA),oFont5,,,)
	
	aAdd(aEtiqCargas,{DAK->DAK_FILIAL, DAK->DAK_COD, DAK->DAK_SEQCAR})
	
	MyImpPedWMS(oDanfe, cMyCarga, oFont1, oFont2)
	
	oDanfe:EndPage()       	

EndIf                                                            

RestArea(aAreaDAK)
Return() 

Static Function MyResCanh(oDanfe, cMyFilial, cMyCarga, cMySeq )
                                                                                         
Local aAreaDAK	:= DAK->(GetArea())
Local aPergOld	:= {}
Local cPerg		:= ""
Local nLoop		:= 0

DAK->(DbSetOrder(1))
DA3->(DbSetOrder(3))
SX5->(DbSetOrder(1))

If DAK->( DbSeek(		Padr(cMyFilial,TamSx3("DAK_FILIAL")[1]) ;
					+	Padr(cMyCarga,TamSx3("DAK_COD")[1]) 	;
					+	Padr(cMySeq,TamSx3("DAK_SEQCAR")[1])	))

	For nLoop := 1 To 60
		If Type("MV_PAR" + StrZero( nLoop, 02 )) <> "U"
			aAdd( aPergOld, &( "MV_PAR" + StrZero( nLoop, 02 ) ) )
		EndIf
	Next nLoop	
	
	cPerg := PadR("CTPRL140",Len(SX1->X1_GRUPO))
	
	Pergunte(cPerg,.F.)
	
	MV_PAR01 := DAK->DAK_COD
	MV_PAR02 := DAK->DAK_SEQCAR
	MV_PAR03 := DAK->DAK_COD
	MV_PAR04 := DAK->DAK_SEQCAR	
	MV_PAR05 := DAK->DAK_DATA
	MV_PAR06 := DAK->DAK_DATA
	
	U_CTPRL140(oDanfe,.F.)
	
	For nLoop := 1 To 60
		If Type("MV_PAR" + StrZero( nLoop, 02 )) <> "U"
			&( "MV_PAR" + StrZero( nLoop, 02 ) )	:= aPergOld[nLoop]
		EndIf
	Next nLoop  
	
EndIf                                                            

RestArea(aAreaDAK)
Return()  

Static Function MyRotEntre(oDanfe, cMyFilial, cMyCarga, cMySeq )
                                                                                         
Local aAreaDAK	:= DAK->(GetArea())
Local aPergOld	:= {}
Local cPerg		:= ""
Local nLoop		:= 0

DAK->(DbSetOrder(1))
DA3->(DbSetOrder(3))
SX5->(DbSetOrder(1))

If DAK->( DbSeek(		Padr(cMyFilial,TamSx3("DAK_FILIAL")[1]) ;
					+	Padr(cMyCarga,TamSx3("DAK_COD")[1]) 	;
					+	Padr(cMySeq,TamSx3("DAK_SEQCAR")[1])	))

	For nLoop := 1 To 60
		If Type("MV_PAR" + StrZero( nLoop, 02 )) <> "U"
			aAdd( aPergOld, &( "MV_PAR" + StrZero( nLoop, 02 ) ) )
		EndIf
	Next nLoop	

	cPerg := PadR("CTPRL139",Len(SX1->X1_GRUPO))		

	Pergunte(cPerg,.F.)
	
	MV_PAR01 := DAK->DAK_COD
	MV_PAR02 := DAK->DAK_SEQCAR
	MV_PAR03 := DAK->DAK_COD
	MV_PAR04 := DAK->DAK_SEQCAR	
	MV_PAR05 := DAK->DAK_DATA
	MV_PAR06 := DAK->DAK_DATA
	
	U_CTPRL139(oDanfe,.F.)
	
	For nLoop := 1 To 60
		If Type("MV_PAR" + StrZero( nLoop, 02 )) <> "U"
			&( "MV_PAR" + StrZero( nLoop, 02 ) )	:= aPergOld[nLoop]
		EndIf
	Next nLoop	

EndIf                                                            

RestArea(aAreaDAK)
Return()

Static Function MyImpPedWMS(oDanfe, cMyCarga, oFont1, oFont2)
Local cEmpWMS	:= U_MyNewSX6("CL_0000308"												,;
								"02"													,;
								"C"														,;
								"Código da empresa na qual deverá ser feita a query para busca da quantidade de pedidos de venda gerados a partir da carga - WMS"	,;
								"Código da empresa na qual deverá ser feita a query para busca da quantidade de pedidos de venda gerados a partir da carga - WMS"	,;
								"Código da empresa na qual deverá ser feita a query para busca da quantidade de pedidos de venda gerados a partir da carga - WMS"	,;
								.F. )
Local cFilWMS	:= U_MyNewSX6("CL_0000309"												,;
								"14"													,;
								"C"														,;
								"Código da filial na qual deverá ser feita a query para busca da quantidade de pedidos de venda gerados a partir da carga - WMS"	,;
								"Código da filial na qual deverá ser feita a query para busca da quantidade de pedidos de venda gerados a partir da carga - WMS"	,;
								"Código da filial na qual deverá ser feita a query para busca da quantidade de pedidos de venda gerados a partir da carga - WMS"	,;
								.F. )
Local aAreaSM0	:= SM0->(GetArea())								
Local cSX2SC5	:= ""
Local cSql		:= ""
Local cAliasTmp	:= ""
Local nLinha	:= 0370
Local cTipoPed	:= ""  
Local cNumPed	:= "" 
Local nPos		:= 0

If !Empty(cEmpWMS) .And. !Empty(cFilWMS) 

	SM0->(DbSetOrder(1))
	If SM0->( DbSeek( Padr(cEmpWMS,Len(SM0->M0_CODIGO)) + Padr(cFilWMS,Len(SM0->M0_CODFIL)) ) )		
		
		cMyCarga	:= StrZero(Val(cMyCarga),5)
		cSX2SC5		:= MyRetX2Arq(SM0->M0_CODIGO, "SD3")
		cAliasTmp	:= GetNextAlias()

		cSql		:= " SELECT DISTINCT "
		cSql		+= " 		 D3_FILIAL "
		cSql		+= " 		,D3_DOC "
		cSql		+= " FROM " + cSX2SC5 + " SD3 "

		cSql		+= " WHERE D3_FILIAL = '" + Padr(cFilWMS,TamSx3("D3_FILIAL")[1]) + "' "
		cSql		+= " AND SUBSTRING(D3_DOC,1,5) LIKE '%" + Alltrim(cMyCarga) + "' "
		cSql		+= " AND LEN(D3_DOC) = " + Alltrim(Str(TamSx3("DAK_COD")[1]))
		cSql		+= " AND SD3.D_E_L_E_T_ = '  ' "

		cSql		+= " ORDER BY D3_FILIAL "
		cSql		+= " 		 ,D3_DOC "
		
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAliasTmp,.F.,.T.)
		
		(cAliasTmp)->(DbGoTop())
		
		If (cAliasTmp)->(!Eof()) .And. (cAliasTmp)->(!Bof())
			
			oDanfe:Say(nLinha,0270, "Pedidos WMS" ,oFont1,,,)				
			nLinha += 60
			
			While (cAliasTmp)->(!Eof())											
								
				cNumPed := Alltrim((cAliasTmp)->D3_DOC)
				
				oDanfe:Say(nLinha,0180,cNumPed,oFont2,,,)
				
				If Right(cNumPed,1) == "F"
					cTipoPed := " - FIFO"
				ElseIf Right(cNumPed,1) == "L"
					cTipoPed := " - LIFO"
				ElseIf Right(cNumPed,1) == "C"
					cTipoPed := " - CRITICO"
				ElseIf Right(cNumPed,1) == "P"
					cTipoPed := " - 1/3"
				EndIf								
				
				oDanfe:Say(nLinha,0340,cTipoPed,oFont2,,,)
				
				nLinha += 45

				nPos := aScan(aIdentCarga,{ |x| x[1] == cMyCarga })
				
				If nPos == 0 
					aAdd(aIdentCarga,{cMyCarga,{}})
				Else
					aAdd(aIdentCarga[nPos],cNumPed)
				EndIf
				
				(cAliasTmp)->(DbSkip())
			EndDo
			
		EndIf

		(cAliasTmp)->(DbCloseArea())
		
	EndIf
	
EndIf

RestArea(aAreaSM0)
Return()                                    

Static Function MyRetX2Arq(cMyEmp, cMyAlias)
Local cNomeSX2		:= "SX2" + Padr(cMyEmp,3,"0") + GetDbExtension()
Local cStartPath	:= Alltrim(GetSrvProfString("STARTPATH",""))
Local cAliasTmp		:= GetNextAlias()
Local cArqTmp		:= CriaTrab(Nil,.F.)
Local cX2Arquivo	:= ""

If Right(cStartPath,1) <> "\"
	cStartPath := cStartPath + "\"
EndIf

DbUseArea(.T.,__LocalDriver,cStartPath+cNomeSX2,cAliasTmp,.T.,.F.)
IndRegua(cAliasTmp,cArqTmp,"X2_CHAVE",,,,.F.)

(cAliasTmp)->(DbSetOrder(1))

If (cAliasTmp)->(DbSeek(cMyAlias))
	cX2Arquivo	:= (cAliasTmp)->X2_ARQUIVO
EndIf

(cAliasTmp)->(DbCloseArea())
FErase(cArqTmp+OrdBagExt())

Return(cX2Arquivo)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³ Eduardo Riera         ³ Data ³16.11.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Controle de Fluxo do Relatorio.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto grafico de impressao                    (OPC) ³±±
±±³          ³ExpC2: String com o XML da NFe                              ³±±
±±³          ³ExpC3: Codigo de Autorizacao do fiscal                (OPC) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpDet(oDanfe,oNfe,cCodAutSef,cModalidade,oNfeDPEC,cCodAutDPEC,cDtHrRecCab,dDtReceb,aNota,cMsgRet,lViaJob)

Default cMsgRet := ""
Default lViaJob := .F.

PRIVATE oFont10N   := TFontEx():New(oDanfe,"Times New Roman",08,08,.T.,.T.,.F.)// 1
PRIVATE oFont07N   := TFontEx():New(oDanfe,"Times New Roman",05.5,05.5,.T.,.T.,.F.)// 2
PRIVATE oFont07    := TFontEx():New(oDanfe,"Times New Roman",06,06,.F.,.T.,.F.)// 3
PRIVATE oFont08    := TFontEx():New(oDanfe,"Times New Roman",07,07,.F.,.T.,.F.)// 4
PRIVATE oFont08N   := TFontEx():New(oDanfe,"Times New Roman",06,06,.T.,.T.,.F.)// 5
PRIVATE oFont09N   := TFontEx():New(oDanfe,"Times New Roman",08,08,.T.,.T.,.F.)// 6
PRIVATE oFont09    := TFontEx():New(oDanfe,"Times New Roman",08,08,.F.,.T.,.F.)// 7
PRIVATE oFont10    := TFontEx():New(oDanfe,"Times New Roman",10,10,.F.,.T.,.F.)// 8
PRIVATE oFont11    := TFontEx():New(oDanfe,"Times New Roman",10,10,.F.,.T.,.F.)// 9
PRIVATE oFont12    := TFontEx():New(oDanfe,"Times New Roman",11,11,.F.,.T.,.F.)// 10
PRIVATE oFont11N   := TFontEx():New(oDanfe,"Times New Roman",10,10,.T.,.T.,.F.)// 11
PRIVATE oFont18N   := TFontEx():New(oDanfe,"Times New Roman",17,17,.T.,.T.,.F.)// 12 
PRIVATE OFONT12N   := TFontEx():New(oDanfe,"Times New Roman",11,11,.T.,.T.,.F.)// 12 
PRIVATE lUsaColab	  :=  UsaColaboracao("1")

PrtDanfe(@oDanfe,oNfe,cCodAutSef,cModalidade,oNfeDPEC,cCodAutDPEC,cDtHrRecCab,dDtReceb,aNota,cMsgRet,lViaJob)

Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PrtDanfe  ³ Autor ³Eduardo Riera          ³ Data ³16.11.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do formulario DANFE grafico conforme laytout no   ³±±
±±³          ³formato retrato                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrtDanfe()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto grafico de impressao                          ³±±
±±³          ³ExpO2: Objeto da NFe                                        ³±±
±±³          ³ExpC3: Codigo de Autorizacao do fiscal                (OPC) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrtDanfe(oDanfe,oNFE,cCodAutSef,cModalidade,oNfeDPEC,cCodAutDPEC,cDtHrRecCab,dDtReceb,aNota,cMsgRet,lViaJob)


Local aAuxCabec     := {} // Array que conterá as strings de cabeçalho das colunas de produtos/serviços.
Local aTamCol       := {} // Array que conterá o tamanho das colunas dos produtos/serviços.
Local aSimpNac		:= {}  
Local aSitTrib      := {}
Local aSitSN        := {}
Local aTransp       := {}
Local aDest         := {}
Local aHrEnt        := {}
Local aFaturas      := {}
Local aItens        := {}
Local aISSQN        := {}
Local aTotais       := {}
Local aAux          := {}
Local aUF           := {}
Local aMensagem     := {}
Local aEspVol       := {}
Local aEspecie      := {}
Local aIndImp       := {}
Local aIndAux       := {}
Local aLote         := {}
                           
Local nHPage        := 0
Local nVPage        := 0
Local nPosV         := 0
Local nPosVOld      := 0
Local nPosH         := 0
Local nPosHOld      := 0
Local nAuxH         := 0
Local nAuxH2        := 0
Local nAuxV         := 0
Local nSnBaseIcm	 := 0
Local nSnValIcm    := 0
Local nDetImp		 := 0
Local nS			 := 0
Local nX            := 0
Local nY            := 0
Local nL            := 0
Local nJ            := 0
Local nW            := 0
Local nTamanho      := 0
Local nFolha        := 1
Local nFolhas       := 0
Local nItem         := 0
Local nMensagem     := 0
Local nBaseICM      := 0
Local nValICM       := 0
Local nBaseICMST    := 0
Local nValICMST     := 0
Local nValIPI       := 0
Local nPICM         := 0
Local nPIPI         := 0
Local nFaturas      := 0
Local nVTotal       := 0
Local nDesc         := 0
Local nQtd          := 0
Local nVUnit        := 0
Local nVolume	    := 0
Local nQtdEX        := 0
Local nVUnitEX      := 0
Local nLenFatura
Local nLenVol
Local nLenDet
Local nLenSit
Local nLenItens     := 0
Local nLenMensagens := 0
Local nLen          := 0
Local nColuna       := 0
Local nLinSum       := 0
Local nE            := 0
Local nMaxCod       := 10
Local nMaxDes       := MAXITEMC
Local nPerDesc      := 0
Local nVUniLiq      := 0
Local nVTotLiq      := 0
Local nZ            := 0
Local nQtdCx		:= 0
Local nLoop			:= 0

Local cAux          := ""
Local cSitTrib      := ""
Local cUF           := ""
Local cChaveCont    := ""
Local cLogo         := FisxLogo("1")
Local cMVCODREG     := Alltrim( SuperGetMV("MV_CODREG", ," ") )
Local cGuarda       := "" 
Local cEsp          := ""
local cEndDest      := ""
Local cXJust		:= ""
Local cDhCont		:= ""

Local lPreview      := .F.
Local lFlag         := .T.
Local lImpAnfav     := GetNewPar("MV_IMPANF",.F.) 
Local lImpInfAd     := GetNewPar("MV_IMPADIC",.F.)
Local lConverte     := GetNewPar("MV_CONVERT",.F.)
Local lImpSimpN		:= GetNewPar("MV_IMPSIMP",.F.)
Local lMv_ItDesc    := Iif( GetNewPar("MV_ITDESC","N")=="S", .T., .F. )
Local lNFori2       := .T.
Local lCompleECF    := .F.
Local lEntIpiDev   	:= GetNewPar("MV_EIPIDEV",.F.) /*Apenas para nota de entrada de Devolução de ipi. .T.-Séra destacado no cabeçalho + inf.compl/.F.-Será destacado apenas em inf.compl*/

Local lPontilhado 	:= .F.
Local aAuxCom 		:= {}    	
Local cUnTrib		:= ""
Local nQtdTrib		:= 0
Local nVUnitTrib		:= 0

local aMsgRet 		:= {}
Local cUnCom		:= ""
Local nQtdCom		:= 0
Local nVUnitCom		:= 0

// RCIMS de MG
Local lUf_MG		:= ( SuperGetMv("MV_ESTADO") $ "MG" )	// Criado esta variavel para atender o RICMS de MG para totalizar por CFOP
Local nSequencia	:= 0
Local nSubTotal		:= 0
Local cCfop			:= ""
Local cCfopAnt		:= ""
Local aItensAux     := {}
Local aArray		:= {}
Local aRetirada     := {}
Local aEntrega      := {}

Local _lGerouBord	:= .F.	
Local oFont4		:= TFont():New("Calibri (Corpo)",Nil,-10,Nil,.F.,Nil,Nil,Nil,Nil,.F.,.F.)
Local cModFrete		:= ""
Local lDestaque		:= .F.
Local oFontDest		:= TFont():New( "Times New Roman",6,6,.T.,.T.,6,.T.,6,.T.,.T.)
Local cBcoAtu		:= ""
Local cAgeAtu		:= ""
Local cCtaAtu		:= ""
Local cSubAtu		:= ""
Local cTpUnid		:= ""
Local cTpUnidEx		:= ""

Default cDtHrRecCab := ""
Default dDtReceb    := CToD("")
Default lViaJob		:= .F.

Private aInfNf      := {}

Private oDPEC       := oNfeDPEC
Private oNF         := oNFe:_NFe
Private oEmitente   := oNF:_InfNfe:_Emit
Private oIdent      := oNF:_InfNfe:_IDE
Private oDestino    := oNF:_InfNfe:_Dest
Private oTotal      := oNF:_InfNfe:_Total
Private oTransp     := oNF:_InfNfe:_Transp
Private oDet        := oNF:_InfNfe:_Det
Private oFatura     := IIf(Type("oNF:_InfNfe:_Cobr")=="U",Nil,oNF:_InfNfe:_Cobr)
Private oImposto
Private oEntrega  := IIf(Type("oNF:_InfNfe:_Entrega") =="U",Nil,oNF:_InfNfe:_Entrega)
Private oRetirada := IIf(Type("oNF:_InfNfe:_Retirada")=="U",Nil,oNF:_InfNfe:_Retirada)

Private nPrivate    := 0
Private nPrivate2   := 0
Private nXAux	    := 0

Private lArt488MG   := .F.
Private lArt274SP   := .F.  

Private nAjustImp     := 0
Private nAjustaRet    := 0
Private nAjustaEnt    := 0
Private nAjustaFat    := 0
Private nAjustaVt     := 0
Private nAjustaPro    := 0
Private nAjustaDad    := 0
Private nAjustaDest   := 0
Private nAjustaISSQN  := 0
Private nAjustaNat    := 0

oBrush              := TBrush():New( , CLR_BLACK )

nFaturas := IIf(oFatura<>Nil,IIf(ValType(oNF:_InfNfe:_Cobr:_Dup)=="A",Len(oNF:_InfNfe:_Cobr:_Dup),1),0)
oDet := IIf(ValType(oDet)=="O",{oDet},oDet)

nAjustImp  := 0
nAjustaRet := 0
nAjustaEnt := 0
nAjustaFat := 0
nAjustaVt  := 0
nAjustaPro := 0
nAjustaISSQN:=0
nAjustaNat := 0
// Popula as variaveis
if( valType(oEntrega)=="O" ) .and. ( valType(oRetirada)=="O")
	
    nAjustaNat   := 4
    nAjustaEnt   := 81
	nAjustaRet   := 162
	nAjustaFat   := 149
	nAjustImp    := 148
    nAjustaVt    :=  147
	nAjustaISSQN := 20
	nAjustaPro   := 0
    nAjustaDad   :=  20
    nAjustaDest  := 10
	nMaxItem     := 0

ElseIF ( valType(oEntrega)=="O" ) .and. ( valType(oRetirada)=="U")
	nAjustaNat   := 4
    nAjustaEnt   := 84
    nAjustaFat   := 71
    nAjustImp    := 70
    nAjustaVt    := 70
    nAjustaISSQN := 20
	nAjustaPro   := 70
	nAjustaDad   := 20
	nAjustaDest  := 7
	nMaxItem     := 4
ElseIF ( valType(oEntrega)=="U" ) .and. ( valType(oRetirada)=="O")
	nAjustaNat   := 4
	nAjustaRet   := 84
	nAjustaFat   := 71
    nAjustImp    := 70
    nAjustaVt    := 70
    nAjustaISSQN := 20
	nAjustaPro   := 70
	nAjustaDad   := 20
	nAjustaDest  := 7
	nMaxItem     := 4

EndIf

If ( valType(oRetirada)=="O" )
	aRetirada := {IIF(Type("oRetirada:_xNome")=="U","",oRetirada:_xNome:Text),;   
    IIF(Type("oRetirada:_CNPJ")=="U","",oRetirada:_CNPJ:Text),;
    IIF(Type("oRetirada:_CPF")=="U","",oRetirada:_CPF:Text),;
    IIF(Type("oRetirada:_xLgr")=="U","",oRetirada:_xLgr:Text),;
    IIF(Type("oRetirada:_nro")=="U","",oRetirada:_nro:Text),;
    IIF(Type("oRetirada:_xCpl")=="U","",oRetirada:_xCpl:Text),;
    IIF(Type("oRetirada:_xBairro")=="U","",oRetirada:_xBairro:Text),;
    IIF(Type("oRetirada:_xMun")=="U","",oRetirada:_xMun:Text),;
    IIF(Type("oRetirada:_UF")=="U","",oRetirada:_UF:Text),;
	IIF(Type("oRetirada:_IE")=="U","",oRetirada:_IE:Text),;
	IIF(Type("oRetirada:_CEP")=="U","",oRetirada:_CEP:Text),;
	IIF(Type("oRetirada:_FONE")=="U","",oRetirada:_Fone:Text),;
	""}
endIf

If ( valType(oEntrega)=="O" )
	aEntrega := {IIF(Type("oEntrega:_xNome")=="U","",oEntrega:_xNome:Text),;   
    IIF(Type("oEntrega:_CNPJ")=="U","",oEntrega:_CNPJ:Text),;
    IIF(Type("oEntrega:_CPF")=="U","",oEntrega:_CPF:Text),;
    IIF(Type("oEntrega:_xLgr")=="U","",oEntrega:_xLgr:Text),;
    IIF(Type("oEntrega:_nro")=="U","",oEntrega:_nro:Text),;
    IIF(Type("oEntrega:_xCpl")=="U","",oEntrega:_xCpl:Text),;
    IIF(Type("oEntrega:_xBairro")=="U","",oEntrega:_xBairro:Text),;
    IIF(Type("oEntrega:_xMun")=="U","",oEntrega:_xMun:Text),;
    IIF(Type("oEntrega:_UF")=="U","",oEntrega:_UF:Text),;
	IIF(Type("oEntrega:_IE")=="U","",oEntrega:_IE:Text),;
	IIF(Type("oEntrega:_CEP")=="U","",oEntrega:_CEP:Text),;
	IIF(Type("oEntrega:_FONE")=="U","",oEntrega:_Fone:Text),;
	""}
endIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Carrega as variaveis de impressao                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aadd(aSitTrib,"00")
aadd(aSitTrib,"10")
aadd(aSitTrib,"20")
aadd(aSitTrib,"30")
aadd(aSitTrib,"40")
aadd(aSitTrib,"41")
aadd(aSitTrib,"50")
aadd(aSitTrib,"51")
aadd(aSitTrib,"60")
aadd(aSitTrib,"70")
aadd(aSitTrib,"90")
aadd(aSitTrib,"PART")
aadd(aSitSN,"101")
aadd(aSitSN,"102")
aadd(aSitSN,"201")
aadd(aSitSN,"202")
aadd(aSitSN,"500")
aadd(aSitSN,"900")


If MV_PAR09 == 1

	aPergOld := {}
	
	For nLoop := 1 To 60
		aAdd( aPergOld, &( "MV_PAR" + StrZero( nLoop, 02 ) ) )
	Next nLoop
	
	aAreaSF2  := SF2->(GetArea())
	aAreaSA1  := SA1->(GetArea())
	
	SF2->( DbSetOrder(1) )
		
	If SF2->( DbSeek( xFilial("SF2") 							;
					+ Padr(aNota[5],TamSx3("F2_DOC")[1]) 		;
					+ Padr(aNota[4],TamSx3("F2_SERIE")[1]) 		;
					+ Padr(aNota[6],TamSx3("F2_CLIENTE")[1])	;
					+ Padr(aNota[7],TamSx3("F2_LOJA")[1])		;
					) )
	    
		            
		SA1->(DbSetOrder(1))
		
		If SA1->(DbSeek(xFilial("SA1") + SF2->(F2_CLIENTE + F2_LOJA)))
			// Inicio WM 2018-10-10 Tratamento nota de exportação
			lExporta := RetTipoNf()
			// Fim WM

			If Alltrim(SA1->A1_TPENTRE) $ "3|4"
						
				U_MINUTA(oDanfe, {	SF2->F2_DOC		;
								, 	SF2->F2_DOC		;
								,	SF2->F2_SERIE	;
								,	SF2->F2_ESTENVI	;
								,	.F.				})
			
			EndIf
		
		EndIf
		
	EndIf
		
	For nLoop := 1 To 60
		&( "MV_PAR" + StrZero( nLoop, 02 ) )	:= aPergOld[nLoop]
	Next nLoop
	
	RestArea(aAreaSA1)
	RestArea(aAreaSF2)
                  
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro Destinatario                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aDest := {MontaEnd(oDestino:_EnderDest),;
NoChar(oDestino:_EnderDest:_XBairro:Text,lConverte),;
IIF(Type("oDestino:_EnderDest:_Cep")=="U","",Transform(oDestino:_EnderDest:_Cep:Text,"@r 99999-999")),;
IIF(oNF:_INFNFE:_VERSAO:TEXT >= "3.10",IIF(Type("oIdent:_DHSaiEnt")=="U","",oIdent:_DHSaiEnt:Text),IIF(Type("oIdent:_DSaiEnt")=="U","",oIdent:_DSaiEnt:Text)),;
oDestino:_EnderDest:_XMun:Text,;
IIF(Type("oDestino:_EnderDest:_fone")=="U","",oDestino:_EnderDest:_fone:Text),;
oDestino:_EnderDest:_UF:Text,;
IIF(Type("oDestino:_IE")=="U","",oDestino:_IE:Text),;
""}

cEndDest := NoChar(oDestino:_EnderDest:_Xlgr:Text,lConverte)
If  " SN" $ (UPPER (oDestino:_EnderDest:_Xlgr:Text)) .Or. ",SN" $ (UPPER (oDestino:_EnderDest:_Xlgr:Text)) .Or. ;
    "S/N" $ (UPPER (oDestino:_EnderDest:_Xlgr:Text)) 
   
            cEndDest += IIf(Type("oDestino:_EnderDest:_xcpl")=="U","",", " + NoChar(oDestino:_EnderDest:_xcpl:Text,lConverte))
Else
            cEndDest += +","+NoChar(oDestino:_EnderDest:_NRO:Text,lConverte) + IIf(Type("oDestino:_EnderDest:_xcpl")=="U","",", "+ NoChar(oDestino:_EnderDest:_xcpl:Text,lConverte))
Endif

If oNF:_INFNFE:_VERSAO:TEXT >= "3.10"
	aadd(aHrEnt,IIF(Type("oIdent:_dhSaiEnt")=="U","",SubStr(oIdent:_dhSaiEnt:TEXT,12,8)))
Else
	If Type("oIdent:_DSaiEnt")<>"U" .And. Type("oIdent:_HSaiEnt:Text")<>"U"
		aAdd(aHrEnt,oIdent:_HSaiEnt:Text)
	Else
		aAdd(aHrEnt,"")
	EndIf	
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calculo do Imposto                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTotais := {"","","","","","","","","","",""}
aTotais[01] := Transform(Val(oTotal:_ICMSTOT:_vBC:TEXT),		"@e 9,999,999,999,999.99")
aTotais[02] := Transform(Val(oTotal:_ICMSTOT:_vICMS:TEXT),		"@e 999,999,999,999.99")
aTotais[03] := Transform(Val(oTotal:_ICMSTOT:_vBCST:TEXT),		"@e 9,999,999,999,999.99")
aTotais[04] := Transform(Val(oTotal:_ICMSTOT:_vST:TEXT),		"@e 999,999,999,999.99")
aTotais[05] := Transform(Val(oTotal:_ICMSTOT:_vProd:TEXT),		"@e 9,999,999,999,999.99")
aTotais[06] := Transform(Val(oTotal:_ICMSTOT:_vFrete:TEXT),		"@e 999,999,999,999.99")
aTotais[07] := Transform(Val(oTotal:_ICMSTOT:_vSeg:TEXT), 		"@e 999,999,999,999.99")
IF(oNF:_INFNFE:_VERSAO:TEXT >= "3.10")
	aTotais[08] := Transform((Val(oTotal:_ICMSTOT:_vDesc:TEXT)+Val(oTotal:_ICMSTOT:_vICMSDESON:TEXT)),"@e 9,999,999,999,999.99")
Else	
	aTotais[08] := Transform(Val(oTotal:_ICMSTOT:_vDesc:TEXT),		"@e 999,999,999,999.99")
EndIf
aTotais[09] := Transform(Val(oTotal:_ICMSTOT:_vOutro:TEXT),		"@e 999,999,999,999.99")

If ( MV_PAR04 == 1 )
	dbSelectArea("SF1")
	dbSetOrder(1)
	If MsSeek(xFilial("SF1")+aNota[5]+aNota[4]+aNota[6]+aNota[7]) .And. SF1->(FieldPos("F1_FIMP"))<>0
		If SF1->F1_TIPO <> "D"
		  	aTotais[10] := 	Transform(Val(oTotal:_ICMSTOT:_vIPI:TEXT),"@e 9,999,999,999,999.99")
		ElseIf SF1->F1_TIPO == "D" .and. lEntIpiDev
			aTotais[10] := 	Transform(Val(oTotal:_ICMSTOT:_vIPI:TEXT),"@e 9,999,999,999,999.99")
		Else	
			aTotais[10] := "0,00"
		EndIf        
		MsUnlock()
		DbSkip()
	EndIf
Else
	aTotais[10] := 	Transform(Val(oTotal:_ICMSTOT:_vIPI:TEXT),"@e 9,999,999,999,999.99")
EndIf

aTotais[11] := 	Transform(Val(oTotal:_ICMSTOT:_vNF:TEXT),		"@e 9,999,999,999,999.99")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Impressão da Base de Calculo e ICMS nos campo Proprios do ICMS quando optante pelo Simples Nacional    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 
If lImpSimpN   

	nDetImp := Len(oDet)
	nS := nDetImp 
	aSimpNac := {"",""}

	    if Type("oDet["+Alltrim(Str(nS))+"]:_IMPOSTO:_ICMS:_ICMSSN101:_VCREDICMSSN:TEXT") <> "U"
	    	SF3->(dbSetOrder(5))
	
			if SF3->(MsSeek(xFilial("SF3")+aNota[4]+aNota[5]))
				while SF3->(!eof()) .and. ( SF3->F3_SERIE + SF3->F3_NFISCAL  == aNota[4] + aNota[5] )
					nSnBaseIcm += (SF3->F3_BASEICM)
					nSnValIcm  += (SF3->F3_VALICM)
					SF3->(dbSkip())
				end 
		   	endif
		    		    	
	    elseif Type("oDet["+Alltrim(Str(nS))+"]:_IMPOSTO:_ICMS:_ICMSSN900:_VCREDICMSSN:TEXT") <> "U"
			nS:= 0	    
	    	For nS := 1 To nDetImp 
	    		If ValAtrib("oDet["+Alltrim(Str(nS))+"]:_IMPOSTO:_ICMS:_ICMSSN900:_VBC:TEXT") <> "U"
	 				nSnBaseIcm += Val(oDet[nS]:_IMPOSTO:_ICMS:_ICMSSN900:_VBC:TEXT)
				EndIf			
				If ValAtrib("oDet["+Alltrim(Str(nS))+"]:_IMPOSTO:_ICMS:_ICMSSN900:_VCREDICMSSN:TEXT") <> "U"
					nSnValIcm  += Val(oDet[nS]:_IMPOSTO:_ICMS:_ICMSSN900:_VCREDICMSSN:TEXT)
				EndIf
			Next nS
			
	    endif
    	    
	   	aSimpNac[01] := Transform((nSnBaseIcm),"@e 9,999,999,999,999.99")
		aSimpNac[02] := Transform((nSnValIcm),"@e 9,999,999,999,999.99")
    
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro Faturas                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nFaturas > 0
	For nX := 1 To 3
		aAux := {}
		For nY := 1 To Min(9, nFaturas)
			Do Case
				Case nX == 1
					If nFaturas > 1
						AAdd(aAux, AllTrim(oFatura:_Dup[nY]:_nDup:TEXT))
					Else
						AAdd(aAux, AllTrim(oFatura:_Dup:_nDup:TEXT))
					EndIf
				Case nX == 2
					If nFaturas > 1
						AAdd(aAux, AllTrim(ConvDate(oFatura:_Dup[nY]:_dVenc:TEXT)))
					Else
						AAdd(aAux, AllTrim(ConvDate(oFatura:_Dup:_dVenc:TEXT)))
					EndIf
				Case nX == 3
					If nFaturas > 1
						AAdd(aAux, AllTrim(TransForm(Val(oFatura:_Dup[nY]:_vDup:TEXT), "@E 9999,999,999.99")))
					Else
						AAdd(aAux, AllTrim(TransForm(Val(oFatura:_Dup:_vDup:TEXT), "@E 9999,999,999.99")))
					EndIf
			EndCase
		Next nY
		If nY <= 9
			For nY := 1 To 9
				AAdd(aAux, Space(20))
			Next nY
		EndIf
		AAdd(aFaturas, aAux)
	Next nX
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro transportadora                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTransp := {"","0","","","","","","","","","","","","","",""}

If Type("oTransp:_ModFrete")<>"U"
	aTransp[02] := IIF(Type("oTransp:_ModFrete:TEXT")<>"U",oTransp:_ModFrete:TEXT,"0")
EndIf
If Type("oTransp:_Transporta")<>"U"
	aTransp[01] := IIf(Type("oTransp:_Transporta:_xNome:TEXT")<>"U",NoChar(oTransp:_Transporta:_xNome:TEXT,lConverte),"")
	//	aTransp[02] := IIF(Type("oTransp:_ModFrete:TEXT")<>"U",oTransp:_ModFrete:TEXT,"0")
	aTransp[03] := IIf(Type("oTransp:_VeicTransp:_RNTC")=="U","",oTransp:_VeicTransp:_RNTC:TEXT)
	aTransp[04] := IIf(Type("oTransp:_VeicTransp:_Placa:TEXT")<>"U",oTransp:_VeicTransp:_Placa:TEXT,"")
	aTransp[05] := IIf(Type("oTransp:_VeicTransp:_UF:TEXT")<>"U",oTransp:_VeicTransp:_UF:TEXT,"")
	If Type("oTransp:_Transporta:_CNPJ:TEXT")<>"U"
		aTransp[06] := Transform(oTransp:_Transporta:_CNPJ:TEXT,"@r 99.999.999/9999-99")
	ElseIf Type("oTransp:_Transporta:_CPF:TEXT")<>"U"
		aTransp[06] := Transform(oTransp:_Transporta:_CPF:TEXT,"@r 999.999.999-99")
	EndIf
	aTransp[07] := IIf(Type("oTransp:_Transporta:_xEnder:TEXT")<>"U",NoChar(oTransp:_Transporta:_xEnder:TEXT,lConverte),"")
	aTransp[08] := IIf(Type("oTransp:_Transporta:_xMun:TEXT")<>"U",oTransp:_Transporta:_xMun:TEXT,"")
	aTransp[09] := IIf(Type("oTransp:_Transporta:_UF:TEXT")<>"U",oTransp:_Transporta:_UF:TEXT,"")
	aTransp[10] := IIf(Type("oTransp:_Transporta:_IE:TEXT")<>"U",oTransp:_Transporta:_IE:TEXT,"")
ElseIf Type("oTransp:_VEICTRANSP")<>"U"
	aTransp[03] := IIf(Type("oTransp:_VeicTransp:_RNTC")=="U","",oTransp:_VeicTransp:_RNTC:TEXT)
	aTransp[04] := IIf(Type("oTransp:_VeicTransp:_Placa:TEXT")<>"U",oTransp:_VeicTransp:_Placa:TEXT,"")
	aTransp[05] := IIf(Type("oTransp:_VeicTransp:_UF:TEXT")<>"U",oTransp:_VeicTransp:_UF:TEXT,"")
EndIf
If Type("oTransp:_Vol")<>"U"
	If ValType(oTransp:_Vol) == "A"
		nX := nPrivate
		nLenVol := Len(oTransp:_Vol)
		// inicio WM 2018-10-10
		If !lExporta
			For nX := 1 to nLenVol
				nXAux := nX
				nVolume += IIF(!Type("oTransp:_Vol[nXAux]:_QVOL:TEXT")=="U",Val(oTransp:_Vol[nXAux]:_QVOL:TEXT),0)
			Next nX
		Else
			nVolume := RetVolEx()
		Endif
		//Fim WM
		
		aTransp[11]	:= AllTrim(str(nVolume))
		aTransp[12]	:= IIf(Type("oTransp:_Vol:_Esp")=="U","Diversos","")
		aTransp[13] := IIf(Type("oTransp:_Vol:_Marca")=="U","",NoChar(oTransp:_Vol:_Marca:TEXT,lConverte))
		aTransp[14] := IIf(Type("oTransp:_Vol:_nVol:TEXT")<>"U",oTransp:_Vol:_nVol:TEXT,"")
		If  Type("oTransp:_Vol[1]:_PesoB") <>"U"
			nPesoB := Val(oTransp:_Vol[1]:_PesoB:TEXT)
			aTransp[15] := AllTrim(str(nPesoB))
		EndIf
		If Type("oTransp:_Vol[1]:_PesoL") <>"U"
			nPesoL := Val(oTransp:_Vol[1]:_PesoL:TEXT)
			aTransp[16] := AllTrim(str(nPesoL))
		EndIf
	Else
		// inicio WM 2018-10-10
		If !lExporta
			nVolume := Val( IIf(Type("oTransp:_Vol:_qVol:TEXT")<>"U",oTransp:_Vol:_qVol:TEXT,"0") )
		Else
			nVolume := RetVolEx()
		Endif
		// Fim WM 2018-10-10
		aTransp[11] := AllTrim(str(nVolume))
		aTransp[12] := IIf(Type("oTransp:_Vol:_Esp")=="U","",oTransp:_Vol:_Esp:TEXT)
		aTransp[13] := IIf(Type("oTransp:_Vol:_Marca")=="U","",NoChar(oTransp:_Vol:_Marca:TEXT,lConverte))
		aTransp[14] := IIf(Type("oTransp:_Vol:_nVol:TEXT")<>"U",oTransp:_Vol:_nVol:TEXT,"")
		aTransp[15] := IIf(Type("oTransp:_Vol:_PesoB:TEXT")<>"U",oTransp:_Vol:_PesoB:TEXT,"")
		aTransp[16] := IIf(Type("oTransp:_Vol:_PesoL:TEXT")<>"U",oTransp:_Vol:_PesoL:TEXT,"")
	EndIf
	aTransp[15] := strTRan(aTransp[15],".",",")
	aTransp[16] := strTRan(aTransp[16],".",",")
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Volumes / Especie Nota de Saida                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
If(MV_PAR04==2) .And. Empty(aTransp[12])
	If (SF2->(FieldPos("F2_ESPECI1")) <>0 .And. !Empty( SF2->(FieldGet(FieldPos( "F2_ESPECI1" )))  )) .Or.;
	   (SF2->(FieldPos("F2_ESPECI2")) <>0 .And. !Empty( SF2->(FieldGet(FieldPos( "F2_ESPECI2" )))  )) .Or.;
	   (SF2->(FieldPos("F2_ESPECI3")) <>0 .And. !Empty( SF2->(FieldGet(FieldPos( "F2_ESPECI3" )))  )) .Or.; 
	   (SF2->(FieldPos("F2_ESPECI4")) <>0 .And. !Empty( SF2->(FieldGet(FieldPos( "F2_ESPECI4" )))  ))

	   	aEspecie := {}   
		aadd(aEspecie,SF2->F2_ESPECI1)
		aadd(aEspecie,SF2->F2_ESPECI2)
		aadd(aEspecie,SF2->F2_ESPECI3)
		aadd(aEspecie,SF2->F2_ESPECI4)
        
		cEsp := ""
		nx 	 := 0 
		For nE := 1 To Len(aEspecie)
			If !Empty(aEspecie[nE])
				nx ++   
				cEsp := aEspecie[nE]
			EndIf
		Next 
		
		cGuarda := ""
		If nx > 1
			cGuarda := "Diversos"
		Else
			cGuarda := cEsp
		EndIf
		
		If !Empty(cGuarda)
		  	aadd(aEspVol,{cGuarda,Iif(SF2->F2_PLIQUI>0,str(SF2->F2_PLIQUI),""),Iif(SF2->F2_PBRUTO>0, str(SF2->F2_PBRUTO),""),Iif(SF2->F2_VOLUME1>0,str(SF2->F2_VOLUME1),"")})
		Else
			/*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ1
			//³Aqui seguindo a mesma regra da criação da TAG de Volumes no xml  ³
			//³ caso não esteja preenchida nenhuma das especies de Volume não se³
			//³ envia as informações de volume.                   				³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ1
			*/
			// 22.03.11 - Almir Bandina - há casos em que o campo espécie esta ficando em branco
			aAdd( aEspVol, { "Caixa(s)", Iif(SF2->F2_PLIQUI>0,str(SF2->F2_PLIQUI),""), Iif(SF2->F2_PBRUTO>0, str(SF2->F2_PBRUTO),"" ),Iif(SF2->F2_VOLUME1>0,str(SF2->F2_VOLUME1),"") } )
			//aadd(aEspVol,{cGuarda,"",""})
		Endif 
	Else
		// 22.03.11 - Almir Bandina - há casos em que o campo espécie esta ficando em branco
		aAdd( aEspVol, { "Caixa(s)", Iif(SF2->F2_PLIQUI>0,str(SF2->F2_PLIQUI),""), Iif(SF2->F2_PBRUTO>0, str(SF2->F2_PBRUTO),"" ),Iif(SF2->F2_VOLUME1>0,str(SF2->F2_VOLUME1),"") } )
		//aadd(aEspVol,{cGuarda,"",""})
	EndIf
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Especie Nota de Entrada                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If(MV_PAR04==1) .And. Empty(aTransp[12])   
	dbSelectArea("SF1")
	dbSetOrder(1)
	If MsSeek(xFilial("SF1")+aNota[5]+aNota[4]+aNota[6]+aNota[7])
     
		If (SF1->(FieldPos("F1_ESPECI1")) <>0 .And. !Empty( SF1->(FieldGet(FieldPos( "F1_ESPECI1" )))  )) .Or.;
			(SF1->(FieldPos("F1_ESPECI2")) <>0 .And. !Empty( SF1->(FieldGet(FieldPos( "F1_ESPECI2" )))  )) .Or.;
			(SF1->(FieldPos("F1_ESPECI3")) <>0 .And. !Empty( SF1->(FieldGet(FieldPos( "F1_ESPECI3" )))  )) .Or.;
			(SF1->(FieldPos("F1_ESPECI4")) <>0 .And. !Empty( SF1->(FieldGet(FieldPos( "F1_ESPECI4" )))  ))
			
			aEspecie := {}
			aadd(aEspecie,SF1->F1_ESPECI1)
			aadd(aEspecie,SF1->F1_ESPECI2)
			aadd(aEspecie,SF1->F1_ESPECI3)
			aadd(aEspecie,SF1->F1_ESPECI4)
			
			cEsp := ""
			nx 	 := 0
			For nE := 1 To Len(aEspecie)
				If !Empty(aEspecie[nE])
					nx ++
					cEsp := aEspecie[nE]
				EndIf
			Next
			
			cGuarda := ""
			If nx > 1
				cGuarda := "Diversos"
			Else
				cGuarda := cEsp
			EndIf
			
			If  !Empty(cGuarda)
				aadd(aEspVol,{cGuarda,Iif(SF1->F1_PLIQUI>0,str(SF1->F1_PLIQUI),""),Iif(SF1->F1_PBRUTO>0, str(SF1->F1_PBRUTO),""),Iif(SF1->F1_VOLUME1>0,str(SF1->F1_VOLUME1),"")})
			Else
				/*
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ1
				//³Aqui seguindo a mesma regra da criação da TAG de Volumes no xml  ³
				//³ caso não esteja preenchida nenhuma das especies de Volume não se³
				//³ envia as informações de volume.                   				³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ1
				*/
				aadd(aEspVol,{cGuarda,"","",""})
			Endif
		Else
			aadd(aEspVol,{cGuarda,"","",""})
		EndIf
		
		MsUnlock()
		DbSkip()		
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Tipo do frete³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SD2")
dbSetOrder(3)
MsSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA)
dbSelectArea("SC5")
dbSetOrder(1)
MsSeek(xFilial("SC5")+SD2->D2_PEDIDO)
dbSelectArea("SF3")
dbSetOrder(4)
MsSeek(xFilial("SF3")+SF2->F2_CLIENTE+SF2->F2_LOJA+SF2->F2_DOC+SF2->F2_SERIE)

lArt488MG := Iif(SF4->(FIELDPOS("F4_CRLEIT"))>0,Iif(SF4->F4_CRLEIT == "1",.T.,.F.),.F.)
lArt274SP := Iif(SF4->(FIELDPOS("F4_ART274"))>0,Iif(SF4->F4_ART274 $ "1S",.T.,.F.),.F.) 

If Type("oTransp:_ModFrete") <> "U"
	cModFrete := oTransp:_ModFrete:TEXT
Else
	cModFrete := "1"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro Dados do Produto / Serviço                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLenDet := Len(oDet)
If lMv_ItDesc
	For nX := 1 To nLenDet
		Aadd(aIndAux, {nX, SubStr(NoChar(oDet[nX]:_Prod:_xProd:TEXT,lConverte),1,MAXITEMC)})
	Next
	
	aIndAux := aSort(aIndAux,,, { |x, y| x[2] < y[2] })
	
	For nX := 1 To nLenDet
		Aadd(aIndImp, aIndAux[nX][1] )
	Next
EndIf


For nZ := 1 To nLenDet
	nQtdCx	:= 0
	If lMv_ItDesc
		nX := aIndImp[nZ]
	Else
		nX := nZ
	EndIf
	nPrivate := nX

    If lArt488MG .And. lUf_MG
        nVTotal  := 0
        nVUnit   := 0 
    Else
	    nVTotal  := Val(oDet[nX]:_Prod:_vProd:TEXT)//-Val(IIF(Type("oDet[nPrivate]:_Prod:_vDesc")=="U","",oDet[nX]:_Prod:_vDesc:TEXT))
		//07.07.17-Almir Bandina-Por causa dos produtos terem o fator conversão quando exportação a unidade tributada fica em quilos
	    //nVUnit   := Val(oDet[nX]:_Prod:_vUnTrib:TEXT)
	    nVUnit   := Val(oDet[nX]:_Prod:_vUnCom:TEXT)
	EndIf

	//07.07.17-Almir Bandina-Por causa dos produtos terem o fator conversão quando exportação a unidade tributada fica em quilos
	//nQtd     := Val(oDet[nX]:_Prod:_qTrib:TEXT)
	//nQtdCx	 := Round(ConvUM( Padr(oDet[nX]:_PROD:_CPROD:TEXT,TamSx3("B1_COD")[1]) ,Val(oDet[nX]:_Prod:_qTrib:TEXT),0,2),2)  // fazer tratamento para calcular QUANT. em caixa
	cTpUnid		:= ""
	//inicio WM 27/08/2018
    If ValTYpe(oDet[nX]:_Prod:_ucom:TEXT) == "C" .and.  ValTYpe(oDet[nX]:_Prod:_qcom:TEXT) == "C"  .and. oDet[nX]:_Prod:_ucom:TEXT == "CX"
		nQtdCx	 	:= Round(val(oDet[nX]:_Prod:_qcom:TEXT),2)  // fazer tratamento para calcular QUANT. em caixa
		cTpUnid 	:= oDet[nX]:_Prod:_uTrib:TEXT
		nQtd	 	:= Val(oDet[nX]:_Prod:_qTrib:TEXT)
		nVUnit		:= Val(oDet[nX]:_Prod:_vUnTrib:TEXT)
		cTpUnidEx   := oDet[nX]:_Prod:_uCom:TEXT
		nQtdEx	 	:= Val(oDet[nX]:_Prod:_qCom:TEXT)
		nVUnitEx	:= Val(oDet[nX]:_Prod:_vUnCom:TEXT)
		
	Else    
		nQtdCx		:= Round(ConvUM( Padr(oDet[nX]:_PROD:_CPROD:TEXT,TamSx3("B1_COD")[1]) ,Val(oDet[nX]:_Prod:_qCom:TEXT),0,2),2)  // fazer tratamento para calcular QUANT. em caixa
		cTpUnid 	:= oDet[nX]:_Prod:_uCom:TEXT
		nQtd	 	:= Val(oDet[nX]:_Prod:_qCom:TEXT)
		nVUnit		:= Val(oDet[nX]:_Prod:_vUnCom:TEXT)
		cTpUnidEX 	:= oDet[nX]:_Prod:_uTrib:TEXT
		nQtdEx	 	:= Val(oDet[nX]:_Prod:_qTrib:TEXT)
		nVUnitEx	:= Val(oDet[nX]:_Prod:_vUnTrib:TEXT)
    Endif
    // fim WM
	If Type("oDet[nPrivate]:_Prod:_vDesc:TEXT")<>"U"
		nDesc := Val( oDet[nX]:_Prod:_vDesc:TEXT )
	Else
		nDesc := 0
	EndIf
    
    aAreaSD2 := SD2->(GetArea())	
	
	SD2->(DbSetOrder(3))
	
	If SD2->( DbSeek( SF2->(F2_FILIAL + F2_DOC + F2_SERIE + F2_CLIENTE + F2_LOJA + Padr(oDet[nX]:_PROD:_CPROD:TEXT,TamSx3("D2_COD")[1]) ) ) )
	
   		nPerDesc	:= SD2->D2_DESC
	
	EndIf
		
	RestArea(aAreaSD2)
	
	nVUniLiq	:= nVUnit-(nDesc/nQtd)
	nVTotLiq	:= nVTotal-nDesc

	nBaseICM	:= 0
	nValICM  	:= 0
	nBaseICMST	:= 0
	nValICMST	:= 0
	nValIPI  	:= 0
	nPICM    	:= 0
	nPIPI    	:= 0
	oImposto 	:= oDet[nX]                
	cSitTrib 	:= ""
	lPontilhado	:= .F.	
	If ValAtrib("oImposto:_Imposto")<>"U"
		If ValAtrib("oImposto:_Imposto:_ICMS")<>"U"
			nLenSit := Len(aSitTrib)
			For nY := 1 To nLenSit
				nPrivate2 := nY
				If ValAtrib("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nPrivate2])<>"U" .OR. ValAtrib("oImposto:_Imposto:_ICMS:_ICMSST")<>"U" 
					If ValAtrib("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nPrivate2]+":_VBC:TEXT")<>"U"
						nBaseICM := Val(&("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_VBC:TEXT"))
						nValICM  := Val(&("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_vICMS:TEXT"))
						nPICM    := Val(&("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_PICMS:TEXT")) 
					ElseIf ValAtrib("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nPrivate2]+":_MOTDESICMS") <> "U" .And. ValAtrib("oImposto:_PROD:_VDESC:TEXT") <> "U"   //SINIEF 25/12, efeitos a partir de 20.12.12 
						If oNF:_INFNFE:_VERSAO:TEXT >= "3.10" .and. &("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_CST:TEXT") <> "40"
							If AllTrim(&("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_motDesICMS:TEXT")) == "7" .And. &("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_CST:TEXT") == "30"
								nValICM  := 0
							Else
								nValICM  := Val(&("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_vICMSDESON:TEXT")) 
							EndIf
						Elseif &("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_CST:TEXT") <> "40"
							If AllTrim(&("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_motDesICMS:TEXT")) == "7" .And. &("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_CST:TEXT") == "30"
								nValICM  := 0
							Else
								nValICM  := Val(&("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_vICMS:TEXT"))
							EndIf
						EndIf
					EndIf
					If ValAtrib("oImposto:_Imposto:_ICMS:_ICMSST")<>"U" // Tratamento para 4.0
						cSitTrib := &("oImposto:_Imposto:_ICMS:_ICMSST:_ORIG:TEXT") 
						cSitTrib += &("oImposto:_Imposto:_ICMS:_ICMSST:_CST:TEXT")					
					Else 
						cSitTrib := &("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_ORIG:TEXT") 
						cSitTrib += &("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_CST:TEXT")
					EndIf
					If ValAtrib("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nPrivate2]+":_VBCST:TEXT")<>"U" .And. ValAtrib("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nPrivate2]+":_vICMSST:TEXT")<>"U"
						nBaseICMST := Val(&("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_VBCST:TEXT"))
						nValICMST  := Val(&("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_vICMSST:TEXT"))
					EndIf
				EndIf												
			Next nY			
		
			//Tratamento para o ICMS para optantes pelo Simples Nacional
			If ValAtrib("oEmitente:_CRT") <> "U" .And. oEmitente:_CRT:TEXT == "1"
				nLenSit := Len(aSitSN)
				For nY := 1 To nLenSit
					nPrivate2 := nY
					If ValAtrib("oImposto:_Imposto:_ICMS:_ICMSSN"+aSitSN[nPrivate2])<>"U"
						If ValAtrib("oImposto:_Imposto:_ICMS:_ICMSSN"+aSitSN[nPrivate2]+":_VBC:TEXT")<>"U"
							nBaseICM := Val(&("oImposto:_Imposto:_ICMS:_ICMSSN"+aSitSN[nY]+":_VBC:TEXT"))
							nValICM  := Val(&("oImposto:_Imposto:_ICMS:_ICMSSN"+aSitSN[nY]+":_vICMS:TEXT"))
							nPICM    := Val(&("oImposto:_Imposto:_ICMS:_ICMSSN"+aSitSN[nY]+":_PICMS:TEXT"))                   
						EndIf
						cSitTrib := &("oImposto:_Imposto:_ICMS:_ICMSSN"+aSitSN[nY]+":_ORIG:TEXT")
						cSitTrib += &("oImposto:_Imposto:_ICMS:_ICMSSN"+aSitSN[nY]+":_CSOSN:TEXT")				
					EndIf
				Next nY	
			EndIf
		EndIf
		If ValAtrib("oImposto:_Imposto:_IPI")<>"U"
			If ValAtrib("oImposto:_Imposto:_IPI:_IPITrib:_vIPI:TEXT")<>"U"
				nValIPI := Val(oImposto:_Imposto:_IPI:_IPITrib:_vIPI:TEXT)
			EndIf
			If ValAtrib("oImposto:_Imposto:_IPI:_IPITrib:_pIPI:TEXT")<>"U"
				nPIPI   := Val(oImposto:_Imposto:_IPI:_IPITrib:_pIPI:TEXT)
			EndIf
		EndIf
	EndIf
    
	nMaxCod := MaxCod(oDet[nX]:_Prod:_cProd:TEXT, 35)

	

//	nMaxDes := MaxCod(NoChar(oDet[nX]:_Prod:_xProd:TEXT,lConverte), 165)
	nMaxDes := MaxCod(NoChar(oDet[nX]:_Prod:_xProd:TEXT,lConverte), 195)
		
	// Tratamento para quebrar os digitos dos valores
	aAux := {}

	AADD(aAux, Alltrim(TransForm(nQtd,		TM(nQtd,TamSX3("D2_QUANT")[1],4))))
	AADD(aAux, Alltrim(TransForm(nVUnit,	TM(nVUnit,TamSX3("D2_PRCVEN")[1],/*TamSX3("D2 _PRCVEN")[2]*/4))))
	AADD(aAux, Alltrim(TransForm(nPerDesc,	"@r 99.99%"))) // Coluna adicionada - Percentual de desconto	
	AADD(aAux, Alltrim(TransForm(nVUniLiq,	TM(nVUniLiq,TamSX3("D2_PRCVEN")[1],4))))
	AADD(aAux, Alltrim(TransForm(nDesc,		TM(nDesc,TamSX3("D2_DESCON")[1],TamSX3("D2_DESCON")[2]))))
	AADD(aAux, Alltrim(TransForm(nVTotLiq,	TM(nVTotLiq,TamSX3("D2_TOTAL")[1],2))))
	AADD(aAux, Alltrim(TransForm(nBaseICM,	TM(nBaseICM,TamSX3("D2_BASEICM")[1],TamSX3("D2_BASEICM")[2]))))
	AADD(aAux, Alltrim(TransForm(nValICM,	TM(nValICM,TamSX3("D2_VALICM")[1],TamSX3("D2_VALICM")[2]))))
	AADD(aAux, Alltrim(TransForm(nValIPI,	TM(nValIPI,TamSX3("D2_VALIPI")[1],TamSX3("D2_BASEIPI")[2]))))
	AADD(aAux, AllTrim(TransForm(nBaseICMST,TM(nBaseICMST,TamSX3("D2_BASEICM")[1],TamSX3("D2_BASEICM")[2]))))
	AADD(aAux, AllTrim(TransForm(nValICMST,	TM(nValICMST,TamSX3("D2_VALICM")[1],TamSX3("D2_VALICM")[2]))))

	aadd(aItens,{;
		SubStr(oDet[nX]:_Prod:_cProd:TEXT,1,nMaxCod),;                               // 01 
		SubStr(NoChar(oDet[nX]:_Prod:_xProd:TEXT,lConverte),1,nMaxDes),;             // 02 
		Alltrim(TransForm(nQtdCx,TM(nQtdCx,TamSX3("D2_QUANT")[1],2))),;              // 03 
		IIF(Type("oDet[nPrivate]:_Prod:_NCM")=="U","",oDet[nX]:_Prod:_NCM:TEXT),;    // 04 
		cSitTrib,;                                                                   // 05 
		oDet[nX]:_Prod:_CFOP:TEXT,;                                                  // 06 
		cTpUnid,; 																	 // 07 	07.07.17-Almir Bandina-Por causa dos produtos terem o fator conversão quando exportação a unidade tributada fica em quilos oDet[nX]:_Prod:_utrib:TEXT
		SubStr(aAux[1], 1, PosQuebrVal(aAux[1])),;                                   // 08 
		SubStr(aAux[2], 1, PosQuebrVal(aAux[2])),;                                   // 09 
		SubStr(aAux[3], 1, PosQuebrVal(aAux[3])),;                                   // 10 
		SubStr(aAux[4], 1, PosQuebrVal(aAux[4])),;                                   // 11 
		SubStr(aAux[5], 1, PosQuebrVal(aAux[5])),;                                   // 12 
		SubStr(aAux[6], 1, PosQuebrVal(aAux[6])),;                                   // 13 
		SubStr(aAux[7], 1, PosQuebrVal(aAux[7])),;                                   // 14 
		SubStr(aAux[8], 1, PosQuebrVal(aAux[8])),;                                   // 15 
		SubStr(aAux[9], 1, PosQuebrVal(aAux[9])),;                                   // 16 
		SubStr(aAux[10], 1, PosQuebrVal(aAux[10])),;                                 // 17 
		SubStr(aAux[11], 1, PosQuebrVal(aAux[11])),;                                 // 18 
		AllTrim(TransForm(nPICM,"@r 99.99%")),;                                      // 19 
		AllTrim(TransForm(nPIPI,"@r 99.99%"));		                                 // 20 
	})
    // WM inicio 2018-10-10
	If lExporta
		aadd(aItens,{;
			"",;                               										// 01 
			"",;             														// 02 
			"",;              														// 03 
			"",;    																// 04 
			"",;                                                                   	// 05 
			"",;                                                  					// 06 
			cTpUnidEx,; 															// 07
			Alltrim(TransForm(nQtdEx,	TM(nQtd,TamSX3("D2_QUANT")[1],4))),;		// 08 
			Alltrim(TransForm(nVUnitEx,	TM(nVUnit,TamSX3("D2_PRCVEN")[1],4))),;     // 09 
			"",;                                   									// 10 
			"",;                                   									// 11 
			"",;                                   									// 12 
			"",;                                   									// 13 
			"",;                                   									// 14 
			"",;                                   									// 15 
			"",;                                   									// 16 
			"",;                                 									// 17 
			"",;                                 									// 18 
			"",;                                      								// 19 
			"";		                                 								// 20 
		})
	Endif
	// WM Fim

	If lUf_MG
		aadd(aItensAux,{;                      		
			SubStr(oDet[nX]:_Prod:_cProd:TEXT,1,nMaxCod),;                            // 01 
			SubStr(NoChar(oDet[nX]:_Prod:_xProd:TEXT,lConverte),1,nMaxDes),;          // 02 
			Alltrim(TransForm(nQtdCx,TM(nQtdCx,TamSX3("D2_QUANT")[1],2))),;           // 03 
			IIF(Type("oDet[nPrivate]:_Prod:_NCM")=="U","",oDet[nX]:_Prod:_NCM:TEXT),; // 04 
			cSitTrib,;                                                                // 05 
			oDet[nX]:_Prod:_CFOP:TEXT,;                                               // 06 
			oDet[nX]:_Prod:_uCom:TEXT,;												  // 07         07.07.17-Almir Bandina-Por causa dos produtos terem o fator conversão quando exportação a unidade tributada fica em quilos oDet[nX]:_Prod:_utrib:TEXT
			SubStr(aAux[1], 1, PosQuebrVal(aAux[1])),;                                // 08 
			SubStr(aAux[2], 1, PosQuebrVal(aAux[2])),;                                // 09 
			SubStr(aAux[3], 1, PosQuebrVal(aAux[3])),;                                // 10 
			SubStr(aAux[4], 1, PosQuebrVal(aAux[4])),;                                // 11 
			SubStr(aAux[5], 1, PosQuebrVal(aAux[5])),;                                // 12 
			SubStr(aAux[6], 1, PosQuebrVal(aAux[6])),;                                // 13 
			SubStr(aAux[7], 1, PosQuebrVal(aAux[7])),;                                // 14 
			SubStr(aAux[8], 1, PosQuebrVal(aAux[8])),;                                // 15 
			SubStr(aAux[9], 1, PosQuebrVal(aAux[9])),;                                // 16 
			SubStr(aAux[10], 1, PosQuebrVal(aAux[10])),;                              // 17 
			SubStr(aAux[11], 1, PosQuebrVal(aAux[11])),;                              // 18 
			AllTrim(TransForm(nPICM,"@r 99.99%")),;                                   // 19 
			AllTrim(TransForm(nPIPI,"@r 99.99%")),;		                              // 20 
			StrZero( ++nSequencia, 4 ),;                                              // 21 
			nVTotal;				                                                  // 22 
		})
	Endif
	// Tramento quando houver diferença entre as unidades uCom e uTrib ( SEFAZ MT )
	If "MT" $ Alltrim( Upper( SuperGetMv("MV_ESTADO") ) ) .And. ( oDet[nX]:_Prod:_uTrib:TEXT <> oDet[nX]:_Prod:_uCom:TEXT )

	    lPontilhado := IIf( nLenDet > 1, .T., lPontilhado )
    	
		cUnTrib		:= oDet[nX]:_Prod:_uTrib:TEXT
		nQtdTrib		:= Val(oDet[nX]:_Prod:_qTrib:TEXT)
	   	nVUnitTrib	:= Val(oDet[nX]:_Prod:_vUnTrib:TEXT)

		cUnCom		:= oDet[nX]:_Prod:_uCom:TEXT
		nQtdCom		:= Val(oDet[nX]:_Prod:_qCom:TEXT)
	   	nVUnitCom	:= Val(oDet[nX]:_Prod:_vUnCom:TEXT)

		aAuxCom := {}
		AADD(aAuxCom, AllTrim(TransForm(nQtdCom,TM(nQtdCom,TamSX3("D2_QUANT")[1],TamSX3("D2_QUANT")[2]))))
		AADD(aAuxCom, AllTrim(TransForm(nVUnitCom,TM(nVUnitCom,TamSX3("D2_PRCVEN")[1],TamSX3("D2_PRCVEN")[2]))))
   	
		aadd(aItens,{;
			"",;                                                    // 01 
			"",;                                                    // 02 
			"",;                                                    // 03 
			"",;                                                    // 04 
			"",;                                                    // 05 
			"",;                                                    // 06 
			cUnCom,;                                                // 07 
			SubStr(aAuxCom[1], 1, PosQuebrVal(aAuxCom[1])),;        // 08 
			SubStr(aAuxCom[2], 1, PosQuebrVal(aAuxCom[2])),;        // 09 
			"",;                                                    // 10 
			"",;                                                    // 11 
			"",;                                                    // 12 
			"",;                                                    // 13 
			"",;                                                    // 14 
			"",;                                                    // 15 
			"",;                                                    // 16 
			"",;                                                    // 17 
			"",;									                // 18 
			"",;                                                    // 19 
			"";                                                     // 20 
		})

	Endif
/*
	cAuxItem := AllTrim(SubStr(oDet[nX]:_Prod:_cProd:TEXT,nMaxCod+1))
	cAux     := AllTrim(SubStr(NoChar(oDet[nX]:_Prod:_xProd:TEXT,lConverte),(nMaxDes + 1)))	
	aAux[1]  := SubStr(aAux[1], PosQuebrVal(aAux[1]) + 1)
	aAux[2]  := SubStr(aAux[2], PosQuebrVal(aAux[2]) + 1)
	aAux[3]  := SubStr(aAux[3], PosQuebrVal(aAux[3]) + 1)
	aAux[4]  := SubStr(aAux[4], PosQuebrVal(aAux[4]) + 1)
	aAux[5]  := SubStr(aAux[5], PosQuebrVal(aAux[5]) + 1)
	aAux[6]  := SubStr(aAux[6], PosQuebrVal(aAux[6]) + 1)
	aAux[7]  := SubStr(aAux[7], PosQuebrVal(aAux[7]) + 1)
	aAux[8]  := SubStr(aAux[8], PosQuebrVal(aAux[8]) + 1)
	aAux[9]  := SubStr(aAux[9], PosQuebrVal(aAux[9]) + 1)
	aAux[10] := SubStr(aAux[10], PosQuebrVal(aAux[10]) + 1)
	aAux[11] := SubStr(aAux[11], PosQuebrVal(aAux[11]) + 1)
	
    lPontilhado := .F.

	While !Empty(cAux) .Or. !Empty(cAuxItem) .Or. !Empty(aAux[1]) .Or. !Empty(aAux[2]) .Or. !Empty(aAux[3]) .Or. !Empty(aAux[4]);
	       .Or. !Empty(aAux[5]) .Or. !Empty(aAux[6]) .Or. !Empty(aAux[7]) .Or. !Empty(aAux[8]) .Or. !Empty(aAux[9]) .Or. !Empty(aAux[10]);
	       .Or. !Empty(aAux[11])

		nMaxCod := MaxCod(cAuxItem, 35)
//		nMaxDes := MaxCod(cAux, 165)
		nMaxDes := MaxCod(cAux, 195)

		aadd(aItens,{;
			SubStr(cAuxItem,1,nMaxCod),;                           // 01 
			SubStr(cAux,1,nMaxDes),;                               // 02
			"",;                                                   // 03 
			"",;                                                   // 04 
			"",;                                                   // 05 
			"",;                                                   // 06 
			"",;                                                   // 07 
			SubStr(aAux[1], 1, PosQuebrVal(aAux[1])),;             // 08 
			SubStr(aAux[2], 1, PosQuebrVal(aAux[2])),;             // 09 
			SubStr(aAux[3], 1, PosQuebrVal(aAux[3])),;             // 10 
			SubStr(aAux[4], 1, PosQuebrVal(aAux[4])),;             // 11 
			SubStr(aAux[5], 1, PosQuebrVal(aAux[5])),;             // 12 
			SubStr(aAux[6], 1, PosQuebrVal(aAux[6])),;             // 13 
			SubStr(aAux[7], 1, PosQuebrVal(aAux[7])),;             // 14 
			SubStr(aAux[8], 1, PosQuebrVal(aAux[8])),;             // 15 
			SubStr(aAux[9], 1, PosQuebrVal(aAux[9])),;             // 16 
			SubStr(aAux[10], 1, PosQuebrVal(aAux[10])),;           // 17 
			SubStr(aAux[11], 1, PosQuebrVal(aAux[11])),;		   // 18 
			"",;                                                   // 19 
			"";                                                    // 20 
		})

		If lUf_MG
			aadd(aItensAux,{;
				SubStr(cAuxItem,1,nMaxCod),;                       // 01 
				SubStr(cAux,1,nMaxDes),;                           // 02 
				"",;                                               // 03 
				"",;                                               // 04 
				"",;                                               // 05 
				oDet[nX]:_Prod:_CFOP:TEXT,;                        // 06 
				"",;                                               // 07 
				SubStr(aAux[1], 1, PosQuebrVal(aAux[1])),;         // 08 
				SubStr(aAux[2], 1, PosQuebrVal(aAux[2])),;         // 09 
				SubStr(aAux[3], 1, PosQuebrVal(aAux[3])),;         // 10 
				SubStr(aAux[4], 1, PosQuebrVal(aAux[4])),;         // 11 
				SubStr(aAux[5], 1, PosQuebrVal(aAux[5])),;         // 12 
				SubStr(aAux[6], 1, PosQuebrVal(aAux[6])),;         // 13 
				SubStr(aAux[7], 1, PosQuebrVal(aAux[7])),;         // 14 
				SubStr(aAux[8], 1, PosQuebrVal(aAux[8])),;         // 15 
				SubStr(aAux[9], 1, PosQuebrVal(aAux[9])),;         // 16 
				SubStr(aAux[10], 1, PosQuebrVal(aAux[10])),;       // 17 
				SubStr(aAux[11], 1, PosQuebrVal(aAux[11])),;	   // 18 
				"",;                                               // 19 
				"",;                                               // 20 
				StrZero( ++nSequencia, 4 ),;                       // 21 
				0;                                                 // 22 
			})
		Endif
		
		cAux        := SubStr(cAux,(nMaxDes + 1)) 
		cAuxItem    := SubStr(cAuxItem,nMaxCod+1)
		aAux[1]     := SubStr(aAux[1], PosQuebrVal(aAux[1]) + 1)
		aAux[2]     := SubStr(aAux[2], PosQuebrVal(aAux[2]) + 1)
		aAux[3]     := SubStr(aAux[3], PosQuebrVal(aAux[3]) + 1)
		aAux[4]     := SubStr(aAux[4], PosQuebrVal(aAux[4]) + 1)
		aAux[5]     := SubStr(aAux[5], PosQuebrVal(aAux[5]) + 1)
		aAux[6]     := SubStr(aAux[6], PosQuebrVal(aAux[6]) + 1)
		aAux[7]     := SubStr(aAux[7], PosQuebrVal(aAux[7]) + 1)
		aAux[8]     := SubStr(aAux[8], PosQuebrVal(aAux[8]) + 1)
		aAux[9]     := SubStr(aAux[9], PosQuebrVal(aAux[9]) + 1)
		aAux[10]    := SubStr(aAux[10], PosQuebrVal(aAux[10]) + 1)
		aAux[11]    := SubStr(aAux[11], PosQuebrVal(aAux[11]) + 1)
	    lPontilhado := .T.	
	    
	EndDo
*/	
	If (ValAtrib("oNf:_infnfe:_det[nPrivate]:_Infadprod:TEXT") <> "U" .Or. ValAtrib("oNf:_infnfe:_det:_Infadprod:TEXT") <> "U") .And. ( lImpAnfav  .Or. lImpInfAd )
		If at("<", AllTrim(SubStr(oDet[nX]:_Infadprod:TEXT,1))) <> 0
			cAux := stripTags(AllTrim(SubStr(oDet[nX]:_Infadprod:TEXT,1)), .T.) + " "
			cAux += stripTags(AllTrim(SubStr(oDet[nX]:_Infadprod:TEXT,1)), .F.)
		else
			cAux := stripTags(AllTrim(SubStr(oDet[nX]:_Infadprod:TEXT,1)), .T.)
		endIf

		
		While !Empty(cAux)
			aadd(aItens,{;
				"",;                                 // 01 
				SubStr(cAux, 1, nMaxDes),;           // 02 
				"",;                                 // 03 
				"",;                                 // 04 
				"",;                                 // 05 
				"",;                                 // 06 
				"",;                                 // 07 
				"",;                                 // 08 
				"",;                                 // 09 
				"",;                                 // 10 
				"",;                                 // 11 
				"",;                                 // 12 
				"",;                                 // 13 
				"",;                                 // 14 
				"",;                                 // 15 
				"",;                                 // 16 
				"",;                                 // 17 
				"",;                                 // 18 
				"",;                                 // 19 
				"";                                  // 20 
			})        
			
			If lUf_MG
				aadd(aItensAux,{;
					"",;                              // 01
					SubStr(cAux, 1, nMaxDes),;        // 02
					"",;                              // 03
					"",;                              // 04
					"",;                              // 05
					oDet[nX]:_Prod:_CFOP:TEXT,;		  // 06		
					"",;                              // 07
					"",;                              // 08
					"",;                              // 09
					"",;                              // 10
					"",;                              // 11
					"",;                              // 12
					"",;                              // 13
					"",;                              // 14
					"",;                              // 15
					"",;                              // 16
					"",;                              // 17
					"",;                              // 18
					"",;                              // 19
					"",;                              // 20
					StrZero( ++nSequencia, 4 ),;      // 21
					0;                                // 22
				})
			Endif
			cAux 		:= SubStr(cAux,(nMaxDes + 1))
			lPontilhado := .T.	
		EndDo
	EndIf

	If lPontilhado
		aadd(aItens,{;
			"-",;                              // 01 
			"-",;                              // 02 
			"-",;                              // 03 
			"-",;                              // 04 
			"-",;                              // 05 
			"-",;                              // 06 
			"-",;                              // 07 
			"-",;                              // 08 
			"-",;                              // 09 
			"-",;                              // 10 
			"-",;                              // 11 
			"-",;                              // 12 
			"-",;                              // 13 
			"-",;                              // 14 
			"-",;                              // 15 
			"-",;                              // 16 
			"-",;                              // 17 
			"-",;                              // 18 
			"-",;                              // 19 
			"-";                               // 20 
		})
		If lUf_MG
			aadd(aItensAux,{;
				"-",;                          // 01 
				"-",;                          // 02 
				"-",;                          // 03 
				"-",;                          // 04 
				"-",;                          // 05 
				oDet[nX]:_Prod:_CFOP:TEXT,;	   // 06 		
				"-",;                          // 07 
				"-",;                          // 08 
				"-",;                          // 09 
				"-",;                          // 10 
				"-",;                          // 11 
				"-",;                          // 12 
				"-",;                          // 13 
				"-",;                          // 14 
				"-",;                          // 15 
				"-",;                          // 16 
				"-",;                          // 17 
				"-",;                          // 18 
				"-",;                          // 19 
				"-",;                          // 20 
				StrZero( ++nSequencia, 4 ),;   // 21 
				0;                             // 22 
			})		
		Endif
	EndIf

Next nZ

//----------------------------------------------------------------------------------
// Tratamento somente para o estado de MG, para totalizar por CFOP conforme RICMS-MG
//----------------------------------------------------------------------------------
If lUf_MG  

	If 	Len( aItensAux ) > 0

		aItensAux	:= aSort( aItensAux,,, { |x,y| x[6]+x[19] < y[6]+y[19] } )

		nSubTotal	:= 0

		aItens		:= {}
	  
		cCfop		:= aItensAux[1,6]
		cCfopAnt	:= aItensAux[1,6]			
		
		For nX := 1 To Len( aItensAux )

			aArray		:= ARRAY(20)
			
			aArray[01]	:= aItensAux[nX,01]
			aArray[02]	:= aItensAux[nX,02]
			aArray[03]	:= aItensAux[nX,03]
			aArray[04]	:= aItensAux[nX,04]
			aArray[05]	:= aItensAux[nX,05]
						
			If Empty( aItensAux[nX,03] ) .Or. aItensAux[nX,03] == "-"
				aArray[06] := ""
			Else
				aArray[06] := aItensAux[nX,06]
			Endif

			aArray[07]	:= aItensAux[nX,07]
			aArray[08]	:= aItensAux[nX,08]
			aArray[09]	:= aItensAux[nX,09]
			aArray[10]	:= aItensAux[nX,10]
			aArray[11]	:= aItensAux[nX,11]
			aArray[12]	:= aItensAux[nX,12]
			aArray[13]	:= aItensAux[nX,13]
			aArray[14]	:= aItensAux[nX,14]
			aArray[15]	:= aItensAux[nX,15]
			aArray[16]	:= aItensAux[nX,16]
			aArray[17]	:= aItensAux[nX,17]
			aArray[18]	:= aItensAux[nX,18]
			aArray[19]	:= aItensAux[nX,19]
			aArray[20]	:= aItensAux[nX,20]
			
			If aItensAux[nX,6] == cCfop

				aadd( aItens, {; 
					aArray[01],;                                           // 01 
					aArray[02],;                                           // 02 
					aArray[03],;                                           // 03 
					aArray[04],;                                           // 04 
					aArray[05],;                                           // 05 
					aArray[06],;                                           // 06 
					aArray[07],;                                           // 07 
					aArray[08],;                                           // 08 
					aArray[09],;                                           // 09 
					aArray[10],;                                           // 10 
					aArray[11],;                                           // 11 
					aArray[12],;                                           // 12 
					aArray[13],;                                           // 13 
					aArray[14],;                                           // 14 
					aArray[15],;                                           // 15 
					aArray[16],;                                           // 16 
					aArray[17],;                                           // 17 
					aArray[18],;                                           // 18 
					aArray[19],;                                           // 19 
					aArray[20];                                            // 20 
				} )

				nSubTotal +=  Iif(Alltrim(aItensAux[nX,13])<>"-",Val(StrTran(STRTRAN(aItensAux[nX,13],".",""),",",".")),0)
				
			Else
				
				aadd(aItens,{;
					"",;                                                                                           // 01 
					"SUB-TOTAL",;                                                                                  // 02 
					"",;                                                                                           // 03 
					"",;                                                                                           // 04 
					"",;                                                                                           // 05 
					"",;                                                                                           // 06 
					"",;                                                                                           // 07 
					"",;                                                                                           // 08 
					AllTrim(TransForm(nSubTotal,"@E 99999999.99")),						;      					   // 09 
					"",;                                                                                           // 10 
					"",;                                                                                           // 11 
					"",;                                                                                           // 12 
					"",;                                                                                           // 13 
					"",;                                                                                           // 14 
					"",;                                                                                           // 15 
					"",;                                                                                           // 16 
					"",;                                                                                           // 17 
					"",;                                                                                           // 18 
					"",;                                                                                           // 19 
					"";                                                                                            // 20 
				})
                nSubtotal := 0
                
				aadd(aItens,{;
					"",;                                                    // 01 
					"",;                                                    // 02 
					"",;                                                    // 03 
					"",;                                                    // 04 
					"",;                                                    // 05 
					"",;                                                    // 06 
					"",;                                                    // 07 
					"",;                                                    // 08 
					"",;                                                    // 09 
					"",;                                                    // 10 
					"",;                                                    // 11 
					"",;                                                    // 12 
					"",;                                                    // 13 
					"",;                                                    // 14 
					"",;                                                    // 15 
					"",;                                                    // 16 
					"",;                                                    // 17 
					"",;                                                    // 18 
					"",;                                                    // 19
					"";                                                     // 20 
				})
				
				cCfop 		:= aItensAux[nX,06]
				nSubTotal +=  Iif(Alltrim(aItensAux[nX,13])<>"-",Val(StrTran(STRTRAN(aItensAux[nX,13],".",""),",",".")),0)

				aadd( aItens, {; 
					aArray[01],;                                             // 01 
					aArray[02],;                                             // 02 
					aArray[03],;                                             // 03 
					aArray[04],;                                             // 04 
					aArray[05],;                                             // 05 
					aArray[06],;                                             // 06 
					aArray[07],;                                             // 07 
					aArray[08],;                                             // 08 
					aArray[09],;                                             // 09 
					aArray[10],;                                             // 10 
					aArray[11],;                                             // 11 
					aArray[12],;                                             // 12 
					aArray[13],;                                             // 13 
					aArray[14],;                                             // 14 
					aArray[15],;                                             // 15 
					aArray[16],;                                             // 16 
					aArray[17],;                                             // 17 
					aArray[18],;                                             // 18 
					aArray[19],;                                             // 19 
					aArray[20];                                              // 20 
				} )

			Endif
			
		Next nX
		
		If cCfopAnt <> cCfop .And. nSubTotal > 0

			aadd(aItens,{;
				"",;                                                                                            // 01 
				"SUB-TOTAL",;                                                                                   // 02 
				"",;                                                                                            // 03 
				"",;                                                                                            // 04 
				"",;                                                                                            // 05 
				"",;                                                                                            // 06 
				"",;                                                                                            // 07 
				"",;                                                                                            // 08 
				AllTrim(TransForm(nSubTotal,"@E 99999999.99")),;       					// 09 
				"",;                                                                                            // 10 
				"",;                                                                                            // 11 
				"",;                                                                                            // 12 
				"",;                                                                                            // 13 
				"",;                                                                                            // 14 
				"",;                                                                                            // 15 
				"",;                                                                                            // 16 
				"",;                                                                                            // 17 
				"",;                                                                                            // 18 
				"",;                                                                                            // 19 
				"";                                                                                             // 20 
			})		
			nSubtotal := 0
		Endif
		
	Endif
	
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro ISSQN                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aISSQN := {"","","",""}
If Type("oEmitente:_IM:TEXT")<>"U"
	aISSQN[1] := oEmitente:_IM:TEXT
EndIf
If Type("oTotal:_ISSQNtot")<>"U"
	If XmlNodeExist(oTotal:_ISSQNtot,"_vServ")											// Tratamento DBM X ITGS
		aISSQN[2] := Transform(Val(oTotal:_ISSQNtot:_vServ:TEXT),"@ze 999,999,999.99")
	EndIf
	
	If XmlNodeExist(oTotal:_ISSQNtot,"_vBC")											// Tratamento DBM X ITGS
		aISSQN[3] := Transform(Val(oTotal:_ISSQNtot:_vBC:TEXT),"@ze 999,999,999.99")
	EndIf
	
	If XmlNodeExist(oTotal:_ISSQNtot,"_vISS")											// Tratamento DBM X ITGS
		aISSQN[4] := Transform(Val(oTotal:_ISSQNtot:_vISS:TEXT),"@ze 999,999,999.99")
	EndIf
EndIf

If Type("oIdent:_DHCONT:TEXT")<>"U"
	cDhCont:= oIdent:_DHCONT:TEXT
EndIf
If Type("oIdent:_XJUST:TEXT")<>"U"
	cXJust:=oIdent:_XJUST:TEXT
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro de informacoes complementares                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aMensagem := {}
If Type("oIdent:_tpAmb:TEXT")<>"U" .And. oIdent:_tpAmb:TEXT=="2"
	cAux := "DANFE emitida no ambiente de homologação - SEM VALOR FISCAL"
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
EndIf 

If Type("oNF:_InfNfe:_infAdic:_infAdFisco:TEXT")<>"U"
	cAux := oNF:_InfNfe:_infAdic:_infAdFisco:TEXT
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
EndIf

If !Empty(cCodAutSef) .AND. oIdent:_tpEmis:TEXT<>"4"
	cAux := "Protocolo: "+cCodAutSef
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
ElseIf !Empty(cCodAutSef) .AND. oIdent:_tpEmis:TEXT=="4" .AND. cModalidade $ "1"
	cAux := "Protocolo: "+cCodAutSef
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
	cAux := "DANFE emitida anteriormente em contingência DPEC"
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
EndIf

SC5->(DbSetOrder(1))
If SC5->(DbSeek(xFilial("SC5") + SD2->D2_PEDIDO))
	If !Empty(SC5->C5_CBD)
		cAux	:= ' CBD: ' + SC5->C5_CBD
		//cCodAutSef
		While !Empty(cAux)
			aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
			cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
		EndDo
	EndIf
EndIf

//dados adicionais referente a coleta de leite

dbSelectArea("SF1")
dbSetOrder(1)
IF MsSeek(xFilial("SF1")+aNota[5]+aNota[4]+aNota[6]+aNota[7])

	if SF1->F1_PGANT01 <> 0
		cAux	:= ' Convenio: '+Transform(SF1->F1_PGANT01 ,"@E 9,999.99")
		While !Empty(cAux)
			aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
			cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
		EndDo
	EndIf
	
	if SF1->F1_PGANT02 <> 0
		cAux	:= ' Tx Resfr.: '+Transform(SF1->F1_PGANT02 ,"@E 9,999.99")
		While !Empty(cAux)
			aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
			cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
		EndDo
	EndIf
	if SF1->F1_PGANT03 <> 0
		cAux	:= 'Prest.Tanque: '+Transform(SF1->F1_PGANT03 ,"@E 9,999.99")
		While !Empty(cAux)
			aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
			cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
		EndDo
	EndIf
	
	if SF1->F1_PGANT04 <> 0
		cAux	:= ' INSS: '+Transform(SF1->F1_PGANT04 ,"@E 9,999.99")
		While !Empty(cAux)
			aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
			cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
		EndDo
	EndIf
	if SF1->F1_PGANT05 <> 0
		cAux	:= ' Vacinação: '+Transform(SF1->F1_PGANT05 ,"@E 9,999.99")
		While !Empty(cAux)
			aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
			cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
		EndDo
	EndIf
	if SF1->F1_PGANT06 <> 0
		cAux	:= ' Adiantamento: '+Transform(SF1->F1_PGANT06 ,"@E 9,999.99")
		While !Empty(cAux)
			aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
			cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
		EndDo
	EndIf 

EndIf

If !Empty(cCodAutDPEC) .And. oIdent:_tpEmis:TEXT=="4"
	cAux := "Número de Registro DPEC: "+cCodAutDPEC
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
EndIf

If (Type("oIdent:_tpEmis:TEXT")<>"U" .And. !oIdent:_tpEmis:TEXT$"1,4")
	cAux := "DANFE emitida em contingência"
	If !Empty(cXJust) .and. !Empty(cDhCont) .and. oIdent:_tpEmis:TEXT$"6,7"// SVC-AN e SVC-RS Deve ser impresso o xjust e dhcont
		cAux += " Motivo da adoção da contingência: "+cXJust+ " Data e hora de início de utilização: "+cDhCont
	EndIf
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
ElseIf (!Empty(cModalidade) .And. !cModalidade $ "1,4,5") .And. Empty(cCodAutSef)
	cAux := "DANFE emitida em contingência devido a problemas técnicos - será necessária a substituição."
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
ElseIf (!Empty(cModalidade) .And. cModalidade $ "5" .And. oIdent:_tpEmis:TEXT=="4")
	cAux := "DANFE impresso em contingência"
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
	cAux := "DPEC regularmento recebido pela Receita Federal do Brasil."
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
ElseIf (Type("oIdent:_tpEmis:TEXT")<>"U" .And. oIdent:_tpEmis:TEXT$"5")
	cAux := "DANFE emitida em contingência FS-DA"
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
EndIf

If Type("oNF:_InfNfe:_infAdic:_infCpl:TEXT")<>"U"
	If at("<", oNF:_InfNfe:_infAdic:_InfCpl:TEXT) <> 0
		cAux := stripTags(oNF:_InfNfe:_infAdic:_InfCpl:TEXT, .T.) + " "
		cAux += stripTags(oNF:_InfNfe:_infAdic:_InfCpl:TEXT, .F.)
	else
		cAux := stripTags(oNF:_InfNfe:_infAdic:_InfCpl:TEXT, .T.)
	endIf
	cAux := MyRetInfDesc(cAux)
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
EndIf

/*
If !Empty(SF2->F2_CARGA) .And. !Empty(SF2->F2_SEQCAR)         
	cAux := stripTags("Carga: " + Alltrim(SF2->F2_CARGA) + " - Sequência: " + Alltrim(SF2->F2_SEQCAR) + ".", .T.)			
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
EndIf
*/

/*
dbSelectArea("SF1")
dbSetOrder(1)
If MsSeek(xFilial("SF1")+aNota[5]+aNota[4]+aNota[6]+aNota[7]) .And. SF1->(FieldPos("F1_FIMP"))<>0
	If SF1->F1_TIPO == "D"
		If Type("oNF:_InfNfe:_Total:_icmsTot:_VIPI:TEXT")<>"U"
			cAux := "Valor do Ipi : " + oNF:_InfNfe:_Total:_icmsTot:_VIPI:TEXT
			While !Empty(cAux)
				aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
				cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
			EndDo
		EndIf      
	EndIf
	MsUnlock()
	DbSkip()
EndIf
*/
If lArt274SP .And. SuperGetMv("MV_ESTADO")$"SP"
	If Type("oNF:_INFNFE:_TOTAL:_ICMSTOT:_VBCST:TEXT") <> "U"
		If oNF:_INFNFE:_TOTAL:_ICMSTOT:_VBCST:TEXT <> "0"
			cAux := "Imposto recolhido por Substituição - Art 274 do RICMS"
			If oNF:_INFNFE:_DEST:_ENDERDEST:_UF:TEXT == "SP"
				cAux += ": "
				aLote := RastroNFOr(SD2->D2_DOC,SD2->D2_SERIE,SD2->D2_CLIENTE,SD2->D2_LOJA)
				For nX := 1 To Len(aLote)
					nBaseICM := aLote[nX][33]
					nValICM  := aLote[nX][38]
					cAux += Alltrim(aLote[nX][3]) + " - BCST: " + AllTrim(TransForm(nBaseICM,TM(nBaseICM,TamSX3("D1_BRICMS")[1],TamSX3("D1_BRICMS")[2]))) + " e ICMSST: " + ;
									AllTrim(TransForm(nValICM,TM(nValICM,TamSX3("D1_ICMSRET")[1],TamSX3("D1_ICMSRET")[2]))) + "/ " 
				Next nX                      
			Endif
			While !Empty(cAux)
				aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
				cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
			EndDo
		Endif
	Endif
Endif 

                                                           
If MV_PAR04 == 2
	//impressao do valor do desconto calculdo conforme decreto 43.080/02 RICMS-MG
	nRecSF3 := SF3->(Recno())
	SF3->(dbSetOrder(4))
	SF3->(MsSeek(xFilial("SF3")+SF2->F2_CLIENTE+SF2->F2_LOJA+SF2->F2_DOC+SF2->F2_SERIE))
	While !SF3->(Eof()) .And. SF2->F2_CLIENTE+SF2->F2_LOJA+SF2->F2_DOC+SF2->F2_SERIE == SF3->F3_CLIEFOR+SF3->F3_LOJA+SF3->F3_NFISCAL+SF3->F3_SERIE
	    If SF3->(FieldPos("F3_DS43080"))<>0 .And. SF3->F3_DS43080 > 0
			cAux := "Base de calc.reduzida conf.Art.43, Anexo IV, Parte 1, Item 3 do RICMS-MG. Valor da deducao ICMS R$ " 
			cAux += Alltrim(Transform(SF3->F3_DS43080,"@e 9,999,999,999,999.99")) + " ref.reducao de base de calculo"  
			While !Empty(cAux)
				aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
				cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
			EndDo
	    EndIf
	    SF3->(dbSkip())
	EndDo
	SF3->(dbGoTo(nRecSF3))
ElseIf MV_PAR04 == 1
    //impressao do valor do desconto calculdo conforme decreto 43.080/02 RICMS-MG
	dbSelectArea("SF1")
	dbSetOrder(1)
	IF MsSeek(xFilial("SF1")+aNota[5]+aNota[4]+aNota[6]+aNota[7])
		dbSelectArea("SF3")
		dbSetOrder(4)
		If MsSeek(xFilial("SF3")+SF1->F1_FORNECE+SF1->F1_LOJA+SF1->F1_DOC+SF1->F1_SERIE)	                                                                                                                                      		
			If SF3->(FieldPos("F3_DS43080"))<>0 .And. SF3->F3_DS43080 > 0
				cAux := "Base de calc.reduzida conf.Art.43, Anexo IV, Parte 1, Item 3 do RICMS-MG. Valor da deducao ICMS R$ " 
				cAux += Alltrim(Transform(SF3->F3_DS43080,"@ze 9,999,999,999,999.99")) + " ref.reducao de base de calculo"  
				While !Empty(cAux)
					aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
					cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
				EndDo                                                                                                                                                               
		    EndIf                                                                                                                                  	
		EndIf  
	EndIf
EndIF    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Impressão da Informação Complementar ³
//³referetena ao produto 6147 - Amostra ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If VERAMOSTRA(SD2->D2_FILIAL,SD2->D2_DOC,SD2->D2_SERIE,SD2->D2_CLIENTE,SD2->D2_LOJA)
	aadd(aMensagem, "ICMS RECOLHIDO ANTECIPADAMENTE POR SUBSTITUIÇÃO TRIBUTÁRIA - PROTOCOLO ICMS 108/2013 - SP x PR" )
EndIF

//Alteração solicitada pelo Wellington
/*If	SD2->D2_TES='547' .AND. SF2->F2_FILIAL="05" .OR. SF2->F2_FILIAL="06"
	cAux += " Local de Entrega: Refrio Armazens Gerais Ltda."
	cAux += " Rod.Regis Bittencourt, KM 293,5 - Bairro Potuvera"
	cAux += " Itapecirica da Serra - SP"
	cAux += " CNPJ: 49.363.468/0002-10 | IE: 370.015.278.117. "
 */
	//AUTORIZACAO RECOLHIMENTO ICMS/MG
	If	SD2->D2_COD = '0210009' .Or. SD2->D2_COD = '0210010'      //Massa coalhada e creme de leite
 		cAux += " Dispensa de Recolhimento antecipado do ICMS,"   
		cAux += " conforme autorização concedida pelo Secretário de Estado de Fazenda. "
	EndIf
	
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
//EndIf

For Nx := 1 to Len(aMensagem)
	NoChar(aMensagem[Nx],lConverte)
Next

If Type("oNF:_INFNFE:_IDE:_NFREF")<>"U"
	If Type("oNF:_INFNFE:_IDE:_NFREF") == "A"
		aInfNf := oNF:_INFNFE:_IDE:_NFREF
	Else
		aInfNf := {oNF:_INFNFE:_IDE:_NFREF}
	EndIf
	
	For nX := 1 to Len(aMensagem)
		If "ORIGINAL"$ Upper(aMensagem[nX])
			lNFori2 := .F.
		EndIf
	Next Nx
	
	cAux1 := ""
	cAux2 := ""
	For Nx := 1 to Len(aInfNf)
		If ValAtrib("aInfNf["+Str(nX)+"]:_REFNFE:TEXT")<>"U" .And. !AllTrim(aInfNf[nx]:_REFNFE:TEXT)$cAux1
			If !"CHAVE"$Upper(cAux1)
				If "65" $ substr (aInfNf[nx]:_REFNFE:TEXT,21,2)
					cAux1 += "Chave de acesso da NFC-E referenciada: "
				Else
				cAux1 += "Chave de acesso da NF-E referenciada: "
				Endif
			EndIf
			cAux1 += aInfNf[nx]:_REFNFE:TEXT+","
		ElseIf ValAtrib("aInfNf["+Str(nX)+"]:_REFNF:_NNF:TEXT")<>"U" .And. !AllTrim(aInfNf[nx]:_REFNF:_NNF:TEXT)$cAux2 .And. lNFori2 
			If !"ORIGINAL"$Upper(cAux2)
				cAux2 += " Numero da nota original: "
			EndIf
			cAux2 += aInfNf[nx]:_REFNF:_NNF:TEXT+","
		EndIf
	Next
	
	cAux	:=	""
	If !Empty(cAux1)
		cAux1	:=	Left(cAux1,Len(cAux1)-1)
		cAux 	+= cAux1
	EndIf
	If !Empty(cAux2)
		cAux2	:=	Left(cAux2,Len(cAux2)-1)
		cAux 	+= 	Iif(!Empty(cAux),CRLF,"")+cAux2
	EndIf
	
	While !Empty(cAux)
		aadd(aMensagem,SubStr(cAux,1,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN) - 1, MAXMENLIN)))
		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENLIN) > 1, EspacoAt(cAux, MAXMENLIN), MAXMENLIN) + 1)
	EndDo
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro "RESERVADO AO FISCO"                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aResFisco := {}
nBaseIcm  := 0

If GetNewPar("MV_BCREFIS",.F.) .And. SuperGetMv("MV_ESTADO")$"PR"
	If Val(&("oTotal:_ICMSTOT:_VBCST:TEXT")) <> 0
		cAux := "Substituição Tributária: Art. 471, II e §1º do RICMS/PR: "
   		nLenDet := Len(oDet)
   		For nX := 1 To nLenDet
	   		oImposto := oDet[nX]
	   		If ValAtrib("oImposto:_Imposto")<>"U"
		 		If ValAtrib("oImposto:_Imposto:_ICMS")<>"U"
		 			nLenSit := Len(aSitTrib)
		 			For nY := 1 To nLenSit
		 				nPrivate2 := nY
		 				If ValAtrib("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nPrivate2])<>"U"
		 					If ValAtrib("oImposto:_IMPOSTO:_ICMS:_ICMS"+aSitTrib[nPrivate2]+":_VBCST:TEXT")<>"U"
		 		   				nBaseIcm := Val(&("oImposto:_Imposto:_ICMS:_ICMS"+aSitTrib[nY]+":_VBCST:TEXT"))
		 						cAux +=  oDet[nX]:_PROD:_CPROD:TEXT + ": BCICMS-ST R$" + AllTrim(TransForm(nBaseICM,TM(nBaseICM,TamSX3("D2_BASEICM")[1],TamSX3("D2_BASEICM")[2]))) + " / "	
   		 	  				Endif
   		 	 			Endif
   					Next nY
   	   			Endif
   	 		Endif
   	  	Next nX
	Endif
	While !Empty(cAux)   
		aadd(aResFisco,SubStr(cAux,1,64))
  		cAux := SubStr(cAux,IIf(EspacoAt(cAux, MAXMENL) > 1, 63, MAXMENL) +2)
   	EndDo	
Endif  

If !Empty(cMsgRet)
	aMsgRet := StrTokArr( cMsgRet, "|")
	aEval( aMsgRet, {|x| aadd( aResFisco, alltrim(x) ) } )
endif
        
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calculo do numero de folhas                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nFolhas	  := 1
nLenItens := Len(aItens) - MAXITEM // Todos os produtos/serviços excluindo a primeira página
nMsgCompl := Len(aMensagem) - MAXMSG // Todas as mensagens complementares excluindo a primeira página
lFlag     := .T.
While lFlag
	// Caso existam produtos/serviços e mensagens complementares a serem escritas
	If nLenItens > 0 .And. nMsgCompl > 0
		nFolhas++
		nLenItens -= MAXITEMP4
		nMsgCompl := 0
	// Caso existam apenas mensagens complementares a serem escritas
	ElseIf nLenItens <= 0 .And. nMsgCompl > 0
		nFolhas++
		nMsgCompl := 0
	// Caso existam apenas produtos/serviços a serem escritos
	ElseIf nLenItens > 0 .And. nMsgCompl <= 0
		nFolhas++
		nLenItens -= MAXITEMP2
	// Se não tiver mais nada a ser escrito fecha a contagem
	Else
		lFlag := .F.
	EndIf
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializacao do objeto grafico                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If oDanfe == Nil
	
	lPreview := .T.
	oDanfe 	:= FWMSPrinter():New("DANFE", IMP_SPOOL)
	oDanfe:SetLandscape()
	oDanfe:Setup()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Preenchimento do Array de UF                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aadd(aUF,{"RO","11"})
aadd(aUF,{"AC","12"})
aadd(aUF,{"AM","13"})
aadd(aUF,{"RR","14"})
aadd(aUF,{"PA","15"})
aadd(aUF,{"AP","16"})
aadd(aUF,{"TO","17"})
aadd(aUF,{"MA","21"})
aadd(aUF,{"PI","22"})
aadd(aUF,{"CE","23"})
aadd(aUF,{"RN","24"})
aadd(aUF,{"PB","25"})
aadd(aUF,{"PE","26"})
aadd(aUF,{"AL","27"})
aadd(aUF,{"MG","31"})
aadd(aUF,{"ES","32"})
aadd(aUF,{"RJ","33"})
aadd(aUF,{"SP","35"})
aadd(aUF,{"PR","41"})
aadd(aUF,{"SC","42"})
aadd(aUF,{"RS","43"})
aadd(aUF,{"MS","50"})
aadd(aUF,{"MT","51"})
aadd(aUF,{"GO","52"})
aadd(aUF,{"DF","53"})
aadd(aUF,{"SE","28"})
aadd(aUF,{"BA","29"})
aadd(aUF,{"EX","99"})


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializacao da pagina do objeto grafico                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oDanfe:StartPage()

oDanfe:Say(-0003,0820, "Pag.: " + Alltrim(Str(oDanfe:nPageCount)),oFont4,,,)


nHPage := oDanfe:nHorzRes()
nHPage *= (300/PixelX)
nHPage -= HMARGEM
nVPage := oDanfe:nVertRes()
nVPage *= (300/PixelY)
nVPage -= VBOX
nLine  := -42  
nBaseTxt := 180
nBaseCol := 70
/* Comando Say Utilizados
Say( nRow, nCol, cText, oFont, nWidth, cClrText, nAngle )
*/

DanfeCab(oDanfe,nPosV,oNFe,oIdent,oEmitente,nFolha,nFolhas,cCodAutSef,oNfeDPEC,cCodAutDPEC,cDtHrRecCab,dDtReceb,@nLine,@nBaseCol,@nBaseTxt,aUf)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro destinatário/remetente                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case Type("oDestino:_CNPJ")=="O"
		cAux := TransForm(oDestino:_CNPJ:TEXT,"@r 99.999.999/9999-99")
	Case Type("oDestino:_CPF")=="O"
		cAux := TransForm(oDestino:_CPF:TEXT,"@r 999.999.999-99")
	OtherWise
		cAux := Space(14)
EndCase

nLine -= 8
//oDanfe:Box(nLine+197,nBaseCol,nLine+270,nBaseCol+30)
oDanfe:FillRect({nLine+198,nBaseCol,nLine+269,nBaseCol+30},oBrush)
oDanfe:Say(nLine+265,nBaseTxt+1,"DESTINATARIO /",oFont08N:oFont, , CLR_WHITE, 270 )
oDanfe:Say(nLine+260,nBaseTxt+11,"REMETENTE"     ,oFont08N:oFont, ,CLR_WHITE , 270 )

nBaseTxt += 30 
//oDanfe:Say(nLine+195,nBaseTxt,"DESTINATARIO/REMETENTE",oFont08N:oFont)
oDanfe:Box(nLine+197,nBaseCol+30,nLine+222,542)
oDanfe:Say(nLine+205,nBaseTxt, "NOME/RAZÃO SOCIAL",oFont08N:oFont)
oDanfe:Say(nLine+215,nBaseTxt,NoChar(oDestino:_XNome:TEXT,lConverte),oFont08:oFont)
oDanfe:Box(nLine+197,542,nLine+222,MAXBOXH-40)
oDanfe:Box(nLine+197.5,542.5,nLine+220.5,MAXBOXH-41.5)//BOX NEGRITO
oDanfe:Say(nLine+205,552,"CNPJ/CPF",oFont08N:oFont)
oDanfe:Say(nLine+215,552,cAux,oFont08:oFont)

oDanfe:Box(nLine+222,nBaseCol+30,nLine+247,402)
oDanfe:Say(nLine+230,nBaseTxt,"ENDEREÇO",oFont08N:oFont)
oDanfe:Say(nLine+240,nBaseTxt,aDest[01],oFont08:oFont)
oDanfe:Box(nLine+222,402,nLine+247,602)
oDanfe:Say(nLine+230,412,"BAIRRO/DISTRITO",oFont08N:oFont)
oDanfe:Say(nLine+240,412,aDest[02],oFont08:oFont)
oDanfe:Box(nLine+222,602,nLine+247,MAXBOXH-40)
oDanfe:Say(nLine+230,612,"CEP",oFont08N:oFont)
oDanfe:Say(nLine+240,612,aDest[03],oFont08:oFont)

oDanfe:Box(nLine+247,nBaseCol+30,nLine+270,302)
oDanfe:Say(nLine+255,nBaseTxt,"MUNICIPIO",oFont08N:oFont)
oDanfe:Say(nLine+265,nBaseTxt,aDest[05],oFont08:oFont)
oDanfe:Box(nLine+247,302,nLine+270,502)
oDanfe:Say(nLine+255,312,"FONE/FAX",oFont08N:oFont)
oDanfe:Say(nLine+265,312,aDest[06],oFont08:oFont)
oDanfe:Box(nLine+247,502,nLine+270,542)
oDanfe:Say(nLine+255,512,"UF",oFont08N:oFont)
oDanfe:Say(nLine+265,512,aDest[07],oFont08:oFont)
oDanfe:Box(nLine+247,542,nLine+270,MAXBOXH-40)
oDanfe:Box(nLine+247.5,542.5,nLine+268.5,MAXBOXH-41.5)//BOX NEGRITO
oDanfe:Say(nLine+255,552,"INSCRIÇÃO ESTADUAL",oFont08N:oFont)
oDanfe:Say(nLine+265,552,aDest[08],oFont08:oFont)

//nBaseTxt := 790 

oDanfe:Box(nLine+197,MAXBOXH-40,nLine+222,MAXBOXH+70)
oDanfe:Say(nLine+205,MAXBOXH-30,"DATA DE EMISSÃO",oFont08N:oFont)
oDanfe:Say(nLine+215,MAXBOXH-30,Iif(oNF:_INFNFE:_VERSAO:TEXT >= "3.10",ConvDate(oIdent:_DHEmi:TEXT),ConvDate(oIdent:_DEmi:TEXT)),oFont08:oFont)
oDanfe:Box(nLine+222,MAXBOXH-40,nLine+247,MAXBOXH+70)
oDanfe:Say(nLine+230,MAXBOXH-30,"DATA ENTRADA/SAÍDA",oFont08N:oFont)
oDanfe:Say(nLine+240,MAXBOXH-30,Iif( Empty(aDest[4]),"",ConvDate(aDest[4]) ),oFont08:oFont)
oDanfe:Box(nLine+247,MAXBOXH-40,nLine+272,MAXBOXH+70)
oDanfe:Say(nLine+255,MAXBOXH-30,"HORA ENTRADA/SAÍDA",oFont08N:oFont)
oDanfe:Say(nLine+265,MAXBOXH-30,aHrEnt[01],oFont08:oFont)

//////////////////////////////////////////////////
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro Informações do local de entrega                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If valType(oEntrega)=="O"
	Do Case
		Case Type("oEntrega:_CNPJ")=="O"
			cAux := TransForm(oEntrega:_CNPJ:TEXT,"@r 99.999.999/9999-99")
		Case Type("oEntrega:_CPF")=="O"
			cAux := TransForm(oEntrega:_CPF:TEXT,"@r 999.999.999-99")
		OtherWise
			cAux := Space(14)
	EndCase

	nLine -= 8

	oDanfe:FillRect({nLine+188+nAjustaEnt,nBaseCol,nLine+258+nAjustaEnt,nBaseCol+30},oBrush)
	oDanfe:Say(nLine+230+nAjustaEnt,nBaseTxt - 27," LOCAl" ,oFont08N:oFont, , CLR_WHITE, 270)
	oDanfe:Say(nLine+230+nAjustaEnt,nBaseTxt - 21,"ENTREGA",oFont08N:oFont, ,CLR_WHITE , 270 )

	oDanfe:Box(nLine+187+nAjustaEnt,nBaseCol+30,nLine+222+nAjustaEnt,542)
	oDanfe:Say(nLine+195+nAjustaEnt,nBaseTxt, "NOME/RAZÃO SOCIAL",oFont08N:oFont)
	oDanfe:Say(nLine+205+nAjustaEnt,nBaseTxt,NoChar(aEntrega[1],lConverte),oFont08:oFont)
	oDanfe:Box(nLine+187+nAjustaEnt,542,nLine+212+nAjustaEnt,MAXBOXH-40)
	oDanfe:Say(nLine+195+nAjustaEnt,552,"CNPJ/CPF",oFont08N:oFont)
	oDanfe:Say(nLine+210+nAjustaEnt,552,cAux,oFont08:oFont)
	oDanfe:Box(nLine+212+nAjustaEnt,nBaseCol+30,nLine+237+nAjustaEnt,502)
	oDanfe:Say(nLine+220+nAjustaEnt,nBaseTxt,"ENDEREÇO",oFont08N:oFont)
	oDanfe:Say(nLine+230+nAjustaEnt,nBaseTxt,MontaEnd(oEntrega),oFont08:oFont)
	oDanfe:Box(nLine+212+nAjustaEnt,402,nLine+237+nAjustaEnt,802)
	oDanfe:Say(nLine+220+nAjustaEnt,412,"BAIRRO/DISTRITO",oFont08N:oFont)
	oDanfe:Say(nLine+230+nAjustaEnt,412,aEntrega[7],oFont08:oFont)
	oDanfe:Box(nLine+237+nAjustaEnt,nBaseCol+30,nLine+260+nAjustaEnt,730)
	oDanfe:Say(nLine+245+nAjustaEnt,nBaseTxt,"MUNICIPIO",oFont08N:oFont)
	oDanfe:Say(nLine+255+nAjustaEnt,nBaseTxt,aEntrega[8],oFont08:oFont)
	oDanfe:Box(nLine+237+nAjustaEnt,725,nLine+260+nAjustaEnt,MAXBOXH-40)
	oDanfe:Say(nLine+245+nAjustaEnt,735,"UF",oFont08N:oFont)
	oDanfe:Say(nLine+255+nAjustaEnt,735,aEntrega[9],oFont08:oFont)
	oDanfe:Box(nLine+187+nAjustaEnt,MAXBOXH-40,nLine+212+nAjustaEnt,MAXBOXH+70)
	oDanfe:Say(nLine+195+nAjustaEnt,MAXBOXH-30,"INSCRIÇÃO ESTADUAL",oFont08N:oFont)
	oDanfe:Say(nLine+205+nAjustaEnt,MAXBOXH-30,aEntrega[10],oFont08:oFont)
	oDanfe:Box(nLine+212+nAjustaEnt,MAXBOXH-40,nLine+237+nAjustaEnt,MAXBOXH+70)
	oDanfe:Say(nLine+220+nAjustaEnt,MAXBOXH-30,"CEP",oFont08N:oFont)
	oDanfe:Say(nLine+230+nAjustaEnt,MAXBOXH-30,aEntrega[11],oFont08:oFont)
	oDanfe:Box(nLine+237+nAjustaEnt,MAXBOXH-40,nLine+260+nAjustaEnt,MAXBOXH+70)
	oDanfe:Say(nLine+245+nAjustaEnt,MAXBOXH-30,"FONE/FAX entrega",oFont08N:oFont)
	oDanfe:Say(nLine+255+nAjustaEnt,MAXBOXH-30,aEntrega[12],oFont08:oFont)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro Informações do local de retirada                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If valType(oRetirada)=="O"
	Do Case
		Case Type("oRetirada:_CNPJ")=="O"
			cAux := TransForm(oRetirada:_CNPJ:TEXT,"@r 99.999.999/9999-99")
		Case Type("oRetirada:_CPF")=="O"
			cAux := TransForm(oRetirada:_CPF:TEXT,"@r 999.999.999-99")
		OtherWise
			cAux := Space(14)
	EndCase

	nLine -= 8

	oDanfe:FillRect({nLine+188+nAjustaRet,nBaseCol,nLine+258+nAjustaRet,nBaseCol+30},oBrush)
	oDanfe:Say(nLine+237+nAjustaRet,nBaseTxt - 27," LOCAL",oFont08N:oFont, , CLR_WHITE, 270)
	oDanfe:Say(nLine+237+nAjustaRet,nBaseTxt - 21,"RETIRADA"     ,oFont08N:oFont, ,CLR_WHITE , 270 )

	oDanfe:Box(nLine+187+nAjustaRet,nBaseCol+30,nLine+222+nAjustaRet,542)
	oDanfe:Say(nLine+195+nAjustaRet,nBaseTxt, "NOME/RAZÃO SOCIAL",oFont08N:oFont)
 	oDanfe:Say(nLine+205+nAjustaRet,nBaseTxt,NoChar(aRetirada[1],lConverte),oFont08:oFont)
	oDanfe:Box(nLine+187+nAjustaRet,542,nLine+212+nAjustaRet,MAXBOXH-40)
	oDanfe:Say(nLine+195+nAjustaRet,552,"CNPJ/CPF",oFont08N:oFont)
	oDanfe:Say(nLine+210+nAjustaRet,552,cAux,oFont08:oFont)
	oDanfe:Box(nLine+212+nAjustaRet,nBaseCol+30,nLine+237+nAjustaRet,502)
	oDanfe:Say(nLine+220+nAjustaRet,nBaseTxt,"ENDEREÇO",oFont08N:oFont)
	oDanfe:Say(nLine+230+nAjustaRet,nBaseTxt,MontaEnd(oRetirada),oFont08:oFont)
	oDanfe:Box(nLine+212+nAjustaRet,402,nLine+237+nAjustaRet,802)
	oDanfe:Say(nLine+220+nAjustaRet,412,"BAIRRO/DISTRITO",oFont08N:oFont)
	oDanfe:Say(nLine+230+nAjustaRet,412,aRetirada[7],oFont08:oFont)
	oDanfe:Box(nLine+237+nAjustaRet,nBaseCol+30,nLine+260+nAjustaRet,730)
	oDanfe:Say(nLine+245+nAjustaRet,nBaseTxt,"MUNICIPIO",oFont08N:oFont)
	oDanfe:Say(nLine+255+nAjustaRet,nBaseTxt,aRetirada[8],oFont08:oFont)
	oDanfe:Box(nLine+237+nAjustaRet,725,nLine+260+nAjustaRet,MAXBOXH-40)
	oDanfe:Say(nLine+245+nAjustaRet,735,"UF",oFont08N:oFont)
	oDanfe:Say(nLine+255+nAjustaRet,735,aRetirada[09],oFont08:oFont)
	oDanfe:Box(nLine+187+nAjustaRet,MAXBOXH-40,nLine+212+nAjustaRet,MAXBOXH+70)
	oDanfe:Say(nLine+195+nAjustaRet,MAXBOXH-30,"INSCRIÇÃO ESTADUAL",oFont08N:oFont)
	oDanfe:Say(nLine+205+nAjustaRet,MAXBOXH-30,aRetirada[10],oFont08:oFont)
	oDanfe:Box(nLine+212+nAjustaRet,MAXBOXH-40,nLine+237+nAjustaRet,MAXBOXH+70)
	oDanfe:Say(nLine+220+nAjustaRet,MAXBOXH-30,"CEP",oFont08N:oFont)
	oDanfe:Say(nLine+230+nAjustaRet,MAXBOXH-30,aRetirada[11],oFont08:oFont)
	oDanfe:Box(nLine+237+nAjustaRet,MAXBOXH-40,nLine+260+nAjustaRet,MAXBOXH+70)
	oDanfe:Say(nLine+245+nAjustaRet,MAXBOXH-30,"FONE/FAX retirada",oFont08N:oFont)
	oDanfe:Say(nLine+255+nAjustaRet,MAXBOXH-30,aRetirada[12],oFont08:oFont)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro fatura                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAux := {{{},{},{},{},{},{},{},{},{}}}
nY := 0
For nX := 1 To Len(aFaturas)
	nY++
	aadd(Atail(aAux)[nY],aFaturas[nX][1])
	nY++
	aadd(Atail(aAux)[nY],aFaturas[nX][2])
	nY++
	aadd(Atail(aAux)[nY],aFaturas[nX][3])
	nY++
	aadd(Atail(aAux)[nY],aFaturas[nX][4])
	nY++
	aadd(Atail(aAux)[nY],aFaturas[nX][5])
	nY++
	aadd(Atail(aAux)[nY],aFaturas[nX][6])
	nY++
	aadd(Atail(aAux)[nY],aFaturas[nX][7])
	nY++
	aadd(Atail(aAux)[nY],aFaturas[nX][8])
	nY++
	aadd(Atail(aAux)[nY],aFaturas[nX][9])
	If nY >= 9
		nY := 0
	EndIf
Next nX
              
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Fatura / Duplicata                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//nLine -= 3
nLine -= 5
nBaseTxt -= 30 
//oDanfe:Box(nLine+275,nBaseCol,nLine+310,nBaseCol+30)
oDanfe:FillRect({nLine+276+nAjustaFat,nBaseCol,nLine+309+nAjustaFat,nBaseCol+30},oBrush)

oDanfe:Say(nLine+305+nAjustaFat,nBaseTxt+7,"FATURA",oFont08N:oFont, ,CLR_WHITE , 270 ) 
nBaseTxt += 30 

nPos1Col := 0
nPos2Col := 0
For Nx := 1 to 8
	oDanfe:Box(nLine+275+nAjustaFat,nBaseCol+30+nPos1Col,nLine+310+nAjustaFat,nBaseCol+115.1+nPos2Col)
	nPos1Col += 84.1
	nPos2Col += 84.1
Next
//Ultimo Box
oDanfe:Box(nLine+275+nAjustaFat,nBaseCol+30+nPos1Col,nLine+310+nAjustaFat,MAXBOXH+70)


nColuna := nBaseCol+36
If Len(aFaturas) >0
	For nY := 1 To 9
		oDanfe:Say(nLine+287+nAjustaFat,nColuna,aAux[1][ny][1],oFont08:oFont)
		oDanfe:Say(nLine+296+nAjustaFat,nColuna,aAux[1][ny][2],oFont08:oFont)
		oDanfe:Say(nLine+305+nAjustaFat,nColuna,aAux[1][ny][3],oFont08:oFont)
		nColuna:= nColuna+84.1
	Next nY
Endif

//nLine -= 15
nLine -= 18
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calculo do imposto                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nBaseTxt -= 30 
//oDanfe:Box(nLine+328,nBaseCol,nLine+376,nBaseCol+30)
oDanfe:FillRect({nLine+329+nAjustImp,nBaseCol,nLine+375+nAjustImp,nBaseCol+30},oBrush)
oDanfe:Say(nLine+372+nAjustImp,nBaseTxt,"CALCULO",oFont08N:oFont, ,CLR_WHITE , 270 )
oDanfe:Say(nLine+360+nAjustImp,nBaseTxt+7,"DO",oFont08N:oFont, , CLR_WHITE, 270 )
oDanfe:Say(nLine+370+nAjustImp,nBaseTxt+14,"IMPOSTO",oFont08N:oFont, , CLR_WHITE, 270 )
nBaseTxt += 30 

oDanfe:Box(nLine+328+nAjustImp,nBaseCol+30,nLine+353+nAjustImp,262)
oDanfe:Say(nLine+336+nAjustImp,nBaseTxt,"BASE DE CALCULO DO ICMS",oFont08N:oFont)
If cMVCODREG $ "2|3" 
	oDanfe:Say(nLine+346+nAjustImp,nBaseTxt,aTotais[01],oFont08:oFont)
ElseIf lImpSimpN
	oDanfe:Say(nLine+346+nAjustImp,nBaseTxt,aSimpNac[01],oFont08:oFont)	
Endif
oDanfe:Box(nLine+328+nAjustImp,262,nLine+353+nAjustImp,402)
oDanfe:Say(nLine+336+nAjustImp,272,"VALOR DO ICMS",oFont08N:oFont)
If cMVCODREG $ "2|3" 
	oDanfe:Say(nLine+346+nAjustImp,272,aTotais[02],oFont08:oFont)
ElseIf lImpSimpN
	oDanfe:Say(nLine+346+nAjustImp,272,aSimpNac[02],oFont08:oFont)
Endif
oDanfe:Box(nLine+328+nAjustImp,402,nLine+353+nAjustImp,557)
oDanfe:Say(nLine+336+nAjustImp,412,"BASE DE CALCULO DO ICMS ST",oFont08N:oFont)
oDanfe:Say(nLine+346+nAjustImp,412,aTotais[03],oFont08:oFont)
oDanfe:Box(nLine+328+nAjustImp,557,nLine+353+nAjustImp,697)
oDanfe:Say(nLine+336+nAjustImp,567,"VALOR DO ICMS SUBSTITUIÇÃO",oFont08N:oFont)
oDanfe:Say(nLine+346+nAjustImp,567,aTotais[04],oFont08:oFont)
oDanfe:Box(nLine+328+nAjustImp,697,nLine+353+nAjustImp,MAXBOXH+70)
oDanfe:Say(nLine+336+nAjustImp,707,"VALOR TOTAL DOS PRODUTOS",oFont08N:oFont)
oDanfe:Say(nLine+346+nAjustImp,707,aTotais[05],oFont08:oFont)


oDanfe:Box(nLine+353+nAjustImp,nBaseCol+30,nLine+378+nAjustImp,232)
oDanfe:Say(nLine+361+nAjustImp,nBaseTxt,"VALOR DO FRETE",oFont08N:oFont)
oDanfe:Say(nLine+371+nAjustImp,nBaseTxt,aTotais[06],oFont08:oFont)
oDanfe:Box(nLine+353+nAjustImp,232,nLine+378+nAjustImp,352)
oDanfe:Say(nLine+361+nAjustImp,242,"VALOR DO SEGURO",oFont08N:oFont)
oDanfe:Say(nLine+371+nAjustImp,242,aTotais[07],oFont08:oFont)
oDanfe:Box(nLine+353+nAjustImp,352,nLine+378+nAjustImp,452)
oDanfe:Say(nLine+361+nAjustImp,362,"DESCONTO",oFont08N:oFont)
oDanfe:Say(nLine+371+nAjustImp,362,aTotais[08],oFont08:oFont)
oDanfe:Box(nLine+353+nAjustImp,452,nLine+378+nAjustImp,592)
oDanfe:Say(nLine+361+nAjustImp,462,"OUTRAS DESPESAS ACESSÓRIAS",oFont08N:oFont)
oDanfe:Say(nLine+371+nAjustImp,462,aTotais[09],oFont08:oFont)
oDanfe:Box(nLine+353+nAjustImp,592,nLine+378+nAjustImp,712)
oDanfe:Say(nLine+361+nAjustImp,602,"VALOR TOTAL DO IPI",oFont08N:oFont)
oDanfe:Say(nLine+371+nAjustImp,602,aTotais[10],oFont08:oFont)
oDanfe:Box(nLine+353+nAjustImp,712,nLine+378+nAjustImp,MAXBOXH+70)
oDanfe:Say(nLine+361+nAjustImp,722,"VALOR TOTAL DA NOTA",oFont08N:oFont)
oDanfe:Say(nLine+371+nAjustImp,722,aTotais[11],oFont08:oFont)

nLine -= 3

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transportador/Volumes transportados                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nBaseTxt -= 30 
//oDanfe:Box(nLine+379,nBaseCol,nLine+452,nBaseCol+30)
oDanfe:FillRect({nLine+380+nAjustaVt,nBaseCol,nLine+451+nAjustaVt,nBaseCol+30},oBrush)   //ANALISAR
oDanfe:Say(nLine+446+nAjustaVt,nBaseTxt   ,"TRANSPORTADOR/" ,oFont08N:oFont, , CLR_WHITE, 270 )
oDanfe:Say(nLine+438+nAjustaVt,nBaseTxt+7 ,"VOLUMES"        ,oFont08N:oFont, , CLR_WHITE, 270 )
oDanfe:Say(nLine+448+nAjustaVt,nBaseTxt+14,"TRANSPORTADOS"  ,oFont08N:oFont, , CLR_WHITE, 270 )
nBaseTxt += 30 

oDanfe:Box(nLine+379+nAjustaVt,nBaseCol+30,nLine+404+nAjustaVt,402)
oDanfe:Say(nLine+387+nAjustaVt,nBaseTxt,"RAZÃO SOCIAL",oFont08N:oFont)
oDanfe:Say(nLine+397+nAjustaVt,nBaseTxt,aTransp[01],oFont08:oFont)
oDanfe:Box(nLine+379+nAjustaVt,402,nLine+404+nAjustaVt,482)
oDanfe:Say(nLine+387+nAjustaVt,412,"FRETE POR CONTA",oFont08N:oFont)
If cModFrete =="0"
	oDanfe:Say(nLine+397+nAjustaVt,412,"0-EMITENTE",oFont08:oFont)
ElseIf cModFrete =="1"
	oDanfe:Say(nLine+397+nAjustaVt,412,"1-DEST/REM",oFont08:oFont)
ElseIf cModFrete =="2"
	oDanfe:Say(nLine+397+nAjustaVt,412,"2-TERCEIROS",oFont08:oFont)
ElseIf cModFrete =="3"
	oDanfe:Say(nLine+397+nAjustaVt,412,"3-TRANSP PROP/REM",oFont08:oFont)
ElseIf cModFrete =="4"
	oDanfe:Say(nLine+397+nAjustaVt,412,"4-TRANSP PROP/DEST",oFont08:oFont)
ElseIf cModFrete =="9"
	oDanfe:Say(nLine+397+nAjustaVt,412,"9-SEM FRETE",oFont08:oFont)
Else
	oDanfe:Say(nLine+397+nAjustaVt,412,"",oFont08:oFont)
Endif
oDanfe:Box(nLine+379+nAjustaVt,482,nLine+404+nAjustaVt,562)
oDanfe:Say(nLine+387+nAjustaVt,492,"CÓDIGO ANTT",oFont08N:oFont)
oDanfe:Say(nLine+397+nAjustaVt,492,aTransp[03],oFont08:oFont)
oDanfe:Box(nLine+379+nAjustaVt,562,nLine+404+nAjustaVt,652)
oDanfe:Say(nLine+387+nAjustaVt,572,"PLACA DO VEÍCULO",oFont08N:oFont)
oDanfe:Say(nLine+397+nAjustaVt,572,aTransp[04],oFont08:oFont)
oDanfe:Box(nLine+379+nAjustaVt,652,nLine+404+nAjustaVt,702)
oDanfe:Say(nLine+387+nAjustaVt,662,"UF",oFont08N:oFont)
oDanfe:Say(nLine+397+nAjustaVt,662,aTransp[05],oFont08:oFont)

oDanfe:Box(nLine+379+nAjustaVt,702,nLine+404+nAjustaVt,MAXBOXH+70)
oDanfe:Say(nLine+387+nAjustaVt,712,"CNPJ/CPF",oFont08N:oFont)
oDanfe:Say(nLine+397+nAjustaVt,712,aTransp[06],oFont08:oFont)

oDanfe:Box(nLine+404+nAjustaVt,nBaseCol+30,nLine+429+nAjustaVt,402)
oDanfe:Say(nLine+412+nAjustaVt,nBaseTxt,"ENDEREÇO",oFont08N:oFont)
oDanfe:Say(nLine+422+nAjustaVt,nBaseTxt,aTransp[07],oFont08:oFont)
oDanfe:Box(nLine+404+nAjustaVt,402,nLine+429+nAjustaVt,652)
oDanfe:Say(nLine+412+nAjustaVt,412,"MUNICIPIO",oFont08N:oFont)
oDanfe:Say(nLine+422+nAjustaVt,412,aTransp[08],oFont08:oFont)
oDanfe:Box(nLine+404+nAjustaVt,652,nLine+429+nAjustaVt,702)
oDanfe:Say(nLine+412+nAjustaVt,662,"UF",oFont08N:oFont)
oDanfe:Say(nLine+422+nAjustaVt,662,aTransp[09],oFont08:oFont)
oDanfe:Box(nLine+404+nAjustaVt,702,nLine+429+nAjustaVt,MAXBOXH+70)
oDanfe:Say(nLine+412+nAjustaVt,712,"INSCRIÇÃO ESTADUAL",oFont08N:oFont)
oDanfe:Say(nLine+422+nAjustaVt,712,aTransp[10],oFont08:oFont)

oDanfe:Box(nLine+429+nAjustaVt,nBaseCol+30,nLine+454+nAjustaVt,232)
oDanfe:Say(nLine+437+nAjustaVt,nBaseTxt,"QUANT.",oFont08N:oFont)
oDanfe:Say(nLine+447+nAjustaVt,nBaseTxt,Iif(!Empty(aTransp[11]),aTransp[11],Iif(Len(aEspVol)>0,aEspVol[1][4],"")),oFont08:oFont)
oDanfe:Box(nLine+429+nAjustaVt,232,nLine+454+nAjustaVt,352)
oDanfe:Say(nLine+437+nAjustaVt,242,"ESPECIE",oFont08N:oFont)
oDanfe:Say(nLine+447+nAjustaVt,242,Iif(!Empty(aTransp[12]),aTransp[12],Iif(Len(aEspVol)>0,aEspVol[1][1],"")),oFont08:oFont)
//oDanfe:Say(nLine+447,242,aEspVol[1][1],oFont08:oFont)
oDanfe:Box(nLine+429+nAjustaVt,352,nLine+454+nAjustaVt,472)
oDanfe:Say(nLine+437+nAjustaVt,362,"MARCA",oFont08N:oFont)
oDanfe:Say(nLine+447+nAjustaVt,362,aTransp[13],oFont08:oFont)
oDanfe:Box(nLine+429+nAjustaVt,472,nLine+454+nAjustaVt,592)
oDanfe:Say(nLine+437+nAjustaVt,482,"NUMERAÇÃO",oFont08N:oFont)
oDanfe:Say(nLine+447+nAjustaVt,482,aTransp[14],oFont08:oFont)
oDanfe:Box(nLine+429+nAjustaVt,592,nLine+454+nAjustaVt,712)
oDanfe:Say(nLine+437+nAjustaVt,602,"PESO BRUTO",oFont08N:oFont)
oDanfe:Say(nLine+447+nAjustaVt,602,Iif(!Empty(aTransp[15]),aTransp[15],Iif(Len(aEspVol)>0 .And. Val(aEspVol[1][3])>0,Transform(Val(aEspVol[1][3]),"@E 999999.9999"),"")),oFont08:oFont)
//oDanfe:Say(nLine+447,602,Iif (!Empty(aEspVol[1][3]),Transform(val(aEspVol[1][3]),"@E 999999.9999"),""),oFont08:oFont)
oDanfe:Box(nLine+429+nAjustaVt,712,nLine+454+nAjustaVt,MAXBOXH+70)
oDanfe:Say(nLine+437+nAjustaVt,722,"PESO LIQUIDO",oFont08N:oFont)
oDanfe:Say(nLine+447+nAjustaVt,722,Iif(!Empty(aTransp[16]),aTransp[16],Iif(Len(aEspVol)>0 .And. Val(aEspVol[1][2])>0,Transform(Val(aEspVol[1][2]),"@E 999999.9999"),"")),oFont08:oFont)
//oDanfe:Say(nLine+447,722,aTransp[16],oFont08:oFont)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calculo do ISSQN                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nBaseTxt -= 30 
//oDanfe:Box(nLine+573,nBaseCol,nLine+597,nBaseCol+30)
oDanfe:FillRect({nLine+574+nAjustaISSQN,nBaseCol,nLine+596+nAjustaISSQN,nBaseCol+30},oBrush)
//oDanfe:Box(nLine+574,nBaseCol+1,nLine+596,nBaseCol+29)
oDanfe:Say(nLine+596+nAjustaISSQN,nBaseTxt+7,"ISSQN",oFont08N:oFont, , CLR_WHITE, 270 )
nBaseTxt += 30 

oDanfe:Box(nLine+573+nAjustaISSQN,nBaseCol+30,nLine+597+nAjustaISSQN,302)
oDanfe:Say(nLine+581+nAjustaISSQN,nBaseTxt,"INSCRIÇÃO MUNICIPAL",oFont08N:oFont)
oDanfe:Say(nLine+591+nAjustaISSQN,nBaseTxt,aISSQN[1],oFont08:oFont)
oDanfe:Box(nLine+573+nAjustaISSQN,302,nLine+597+nAjustaISSQN,502)
oDanfe:Say(nLine+581+nAjustaISSQN,312,"VALOR TOTAL DOS SERVIÇOS",oFont08N:oFont)
oDanfe:Say(nLine+591+nAjustaISSQN,312,aISSQN[2],oFont08:oFont)
oDanfe:Box(nLine+573+nAjustaISSQN,502,nLine+597+nAjustaISSQN,702)
oDanfe:Say(nLine+581+nAjustaISSQN,512,"BASE DE CÁLCULO DO ISSQN",oFont08N:oFont)
oDanfe:Say(nLine+591+nAjustaISSQN,512,aISSQN[3],oFont08:oFont)
oDanfe:Box(nLine+573+nAjustaISSQN,702,nLine+597+nAjustaISSQN,MAXBOXH+70)
oDanfe:Say(nLine+581+nAjustaISSQN,712,"VALOR DO ISSQN",oFont08N:oFont)
oDanfe:Say(nLine+591+nAjustaISSQN,712,aISSQN[4],oFont08:oFont)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Dados Adicionais                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nPosMsg := 0
DanfeInfC(oDanfe,aMensagem,@nBaseTxt,@nBaseCol,@nLine,@nPosMsg,nFolha)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Dados do produto ou servico                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAux := {{{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}}}
nY := 0
nLenItens := Len(aItens)

For nX :=1 To nLenItens
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][01])
	nY++
	aadd(Atail(aAux)[nY],NoChar(aItens[nX][02],lConverte))
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][03])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][04])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][05])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][06])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][07])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][08])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][09])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][10])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][11])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][12])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][13])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][14])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][15])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][16])
	nY++
//	aadd(Atail(aAux)[nY],aItens[nX][17])
	aadd(Atail(aAux)[nY],aItens[nX][19])
	nY++
//	aadd(Atail(aAux)[nY],aItens[nX][18])
	aadd(Atail(aAux)[nY],aItens[nX][20])
	nY++

	If nY >= 18
		nY := 0
	EndIf

	/*
	aadd(Atail(aAux)[nY],aItens[nX][17])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][18])
	nY++
	aadd(Atail(aAux)[nY],aItens[nX][19])
	If nY >= 19
		nY := 0
	EndIf
	*/
	
Next nX
For nX := 1 To nLenItens
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++

	If nY >= 18
		nY := 0
	EndIf
	
	/*
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")
	nY++
	aadd(Atail(aAux)[nY],"")

	If nY >= 19
		nY := 0
	EndIf
	*/
	
Next nX

// Popula o array de cabeçalho das colunas de produtos/serviços.

/*
aAuxCabec := {;
	"COD. PROD",;                                                  // 01 
	"DESCR PROD",;                                                 // 02 
	"NCM/SH",;                                                     // 03 
	IIf( cMVCODREG == "1", "CSOSN","CST" ),;                       // 04 
	"CFOP",;                                                       // 05 
	"UN",;                                                         // 06 
	"QUANT.",;                                                     // 07 
	"V.UNITARIO",;                                                 // 08 
	"VLR TOTAL",;                                                  // 09 
	"TOT.DESC",;                                                   // 10 
	"V.UNI LIQ",;                                                  // 11 
	"TOTAL LIQ",;                                                  // 12 
	"BASE ICMS",;                                                  // 13 
	"BASE ICMS ST",;                                               // 14 
	"VLR ICMS",;                                                   // 15 
	"VLR ICMS ST",;                                                // 16 
	"VALOR IPI",;                                                  // 17 
	"ICMS",;                                                       // 18 
	"IPI";                                                         // 19 
} 
*/

aAuxCabec := {;
	"COD. PROD",;                           // 01 
	"DESCR PROD",;                          // 02 
	"QTD.CAIXA",;	                        // 03 
	"NCM/SH",;                              // 04 
	"CST",;                                 // 05 
	"CFOP",;                                // 06 
	"UN",;                                  // 07 
	"QUANT.",;                              // 08 
	"V.UNITARIO",;                          // 09 
	"DESC %",;	                            // 10 
	"V.UNI LIQ",;                           // 11 
	"TOT.DESC",;	                        // 12 
	"TOTAL LIQ",;                           // 13 
	"BASE ICMS",;                           // 14 
	"VLR ICMS",;                            // 15 
	"VALOR IPI",;                           // 16 
	"ICMS",;                                // 17 
	"IPI";                                  // 18 
} 

// Retorna o tamanho das colunas baseado em seu conteudo
aTamCol := RetTamCol(aAuxCabec, aAux, oDanfe, oFont08N:oFont, oFont07:oFont)

aColProd := {}
DanfeIT(oDanfe, @nLine, @nBaseCol, @nBaseTxt, nFolha, nFolhas, @aColProd, aMensagem, nPosMsg, aTamCol)

lPag1 := .T.
lPag2 := .F.
lPagX := .F.
lInfoAd:= .F.

nFolha++
nLinha    :=nLine+478
nL:=0  

For nY := 1 To nLenItens
	nL++
	If lPag1
		If nL > MAXITEM .And. nFolha == 2
			oDanfe:EndPage()
			oDanfe:StartPage()
			oDanfe:Say(-0003,0820, "Pag.: " + Alltrim(Str(oDanfe:nPageCount)),oFont4,,,)
			nLinha    	:=	181

			DanfeCab(oDanfe,nPosV,oNFe,oIdent,oEmitente,nFolha,nFolhas,cCodAutSef,oNfeDPEC,cCodAutDPEC,cDtHrRecCab,dDtReceb,@nLine,@nBaseCol,@nBaseTxt,aUf)			
			DanfeIT(oDanfe, @nLine, @nBaseCol, @nBaseTxt, nFolha, nFolhas, @aColProd, aMensagem, nPosMsg, aTamCol)
			If nPosMsg > 0
				DanfeInfC(oDanfe,aMensagem,@nBaseTxt,@nBaseCol,@nLine,@nPosMsg,nFolha)
				lInfoAd := .T.
			EndIf	
			nL :=0
			lPag1 := .F.
			lPag2 := .T.
			nLinha := 169
		Endif           
	Endif

	If lPag2  .And. lInfoAd
		If	nL > MAXITEMP4
			nFolha++
			oDanfe:EndPage()
			oDanfe:StartPage()
			oDanfe:Say(-0003,0820, "Pag.: " + Alltrim(Str(oDanfe:nPageCount)),oFont4,,,)
			nColLim		:=	Iif(!(nfolha-1)%2==0 .And. MV_PAR05==1,435,865)
			nLinha    	:=	181
			
			DanfeCab(oDanfe,nPosV,oNFe,oIdent,oEmitente,nFolha,nFolhas,cCodAutSef,oNfeDPEC,cCodAutDPEC,cDtHrRecCab,dDtReceb,@nLine,@nBaseCol,@nBaseTxt,aUf)			
			DanfeIT(oDanfe, @nLine, @nBaseCol, @nBaseTxt, nFolha, nFolhas, @aColProd, aMensagem, nPosMsg, aTamCol)  
			nLinha := 169
	
			nL:=0
			lPag2 := .F.
			lPagX := .T.      
			lInfoAd:= .F.
		EndIf
	Else
		If	nL >= MAXITEMP2
			nFolha++
			oDanfe:EndPage()
			oDanfe:StartPage()
			oDanfe:Say(-0003,0820, "Pag.: " + Alltrim(Str(oDanfe:nPageCount)),oFont4,,,)
			nColLim		:=	Iif(!(nfolha-1)%2==0 .And. MV_PAR05==1,435,865)
			nLinha    	:=	181
			
			DanfeCab(oDanfe,nPosV,oNFe,oIdent,oEmitente,nFolha,nFolhas,cCodAutSef,oNfeDPEC,cCodAutDPEC,cDtHrRecCab,dDtReceb,@nLine,@nBaseCol,@nBaseTxt,aUf)			
			DanfeIT(oDanfe, @nLine, @nBaseCol, @nBaseTxt, nFolha, nFolhas, @aColProd, aMensagem, nPosMsg, aTamCol)
			nLinha := 169
	
			nL:=0		
		EndIf
	EndIf
	
	lDestaque		:= .F.
	
	If aAux[1][1][nY] == "-"
		If nY > nMaxItem
	   		nAjustaPro:=0
	   	endif
		oDanfe:Say(nLinha, aColProd[1][1] + 2, Replicate("- ", 192), oFont07:oFont)
	Else
		
		If 			XmlNodeExist(oNFe,"_NFE")							;
			.And.	XmlNodeExist(oNFe:_NFE,"_INFNFE")					;
			.And. 	XmlNodeExist(oNFe:_NFE:_INFNFE,"_DEST")				;	 
			.And. 	XmlNodeExist(oNFe:_NFE:_INFNFE:_DEST,"_CNPJ")		;
			.And.	XmlNodeExist(oNFe:_NFE:_INFNFE,"_IDE")				;
			.And.	XmlNodeExist(oNFe:_NFE:_INFNFE:_IDE,"_TPNF")				
		 	
			If Alltrim(oNFe:_NFE:_INFNFE:_IDE:_TPNF:TEXT) == "1"			
			 	SA1->(DbSetOrder(3))			 	
			 	If SA1->( DbSeek( xFilial("SA1") + Padr(oNFe:_NFE:_INFNFE:_DEST:_CNPJ:TEXT,TamSx3("A1_CGC")[1]))  )			 	
					// Inicio WM 2018-10-10 Tratamento nota de exportação
					lExporta := RetTipoNf()
					// Fim WM

			 		PFB->(DbSetOrder(1))			 		
			 		If PFB->( DbSeek( xFilial("PFB") + Padr(SA1->A1_GRPVEN,TamSx3("PFB_GRPCLI")[1]) + Padr(aAux[1][1][nY],TamSx3("PFB_CODPRO")[1]) ) )
			 			lDestaque		:= .T.
			 		EndIf			 	
			 	EndIf		 	
		 	EndIf
		 	
		EndIf
		
		If nY > nMaxItem
	   		nAjustaPro:=0
	   	endif 
	   	
		oDanfe:Say(nLinha+nAjustaPro, aColProd[1][1] + 2, Iif(lDestaque,"** ","") + aAux[1][1][nY], Iif(lDestaque,oFontDest,oFont07:oFont))
		oDanfe:Say(nLinha+nAjustaPro, aColProd[2][1] + 2, aAux[1][2][nY], Iif(lDestaque,oFontDest,oFont07:oFont))
		oDanfe:SayAlign(nLinha-5.57,0281,aAux[1][3][nY],oFont07:oFont,45, 10, ,1, 0 )
		oDanfe:Say(nLinha+nAjustaPro, aColProd[4][1] + 2, aAux[1][4][nY], oFont07:oFont)
		oDanfe:Say(nLinha+nAjustaPro, aColProd[5][1] + 2, aAux[1][5][nY], oFont07:oFont)
		oDanfe:Say(nLinha+nAjustaPro, aColProd[6][1] + 2, aAux[1][6][nY], oFont07:oFont)
		oDanfe:Say(nLinha+nAjustaPro, aColProd[7][1] + 2, aAux[1][7][nY], oFont07:oFont)
		
		oDanfe:SayAlign(nLinha-5.57,0420,aAux[1][8][nY],oFont07:oFont,45, 10, ,1, 0 )
		
	   	oDanfe:SayAlign(nLinha-5.57,0484,aAux[1][9][nY],oFont07:oFont,30, 10, ,1, 0 )
		
		oDanfe:SayAlign(nLinha-5.57,0511,aAux[1][10][nY],oFont07:oFont,45, 10, ,1, 0 )
		
		oDanfe:SayAlign(nLinha-5.57,0567,aAux[1][11][nY],oFont07:oFont,30, 10, ,1, 0 )
								
		oDanfe:SayAlign(nLinha-5.57,0590,aAux[1][12][nY],oFont07:oFont,45, 10, ,1, 0 )
		
		oDanfe:SayAlign(nLinha-5.57,0635,aAux[1][13][nY],oFont07:oFont,45, 10, ,1, 0 )
				                                                                              
		oDanfe:SayAlign(nLinha-5.57,0679,aAux[1][14][nY],oFont07:oFont,45, 10, ,1, 0 )
				
		oDanfe:SayAlign(nLinha-5.57,0719,aAux[1][15][nY],oFont07:oFont,45, 10, ,1, 0 )
		
		oDanfe:SayAlign(nLinha-5.57,0761,aAux[1][16][nY],oFont07:oFont,45, 10, ,1, 0 )
				
		oDanfe:SayAlign(nLinha-5.57,0792,aAux[1][17][nY],oFont07:oFont,45, 10, ,1, 0 )
						
	   	oDanfe:SayAlign(nLinha-5.57,0823,aAux[1][18][nY],oFont07:oFont,45, 10, ,1, 0 )
						        
	EndIf
	
	nLinha := nLinha + 10 
Next nY 
If nL <= MAXITEM .And. Len(aMensagem) > MAXMSG .And. nFolha == 2 .And. nLenItens <= MAXMSG
	oDanfe:EndPage()
	oDanfe:StartPage()
	oDanfe:Say(-0003,0820, "Pag.: " + Alltrim(Str(oDanfe:nPageCount)),oFont4,,,)
	nLinha    	:=	181                
	DanfeCab(oDanfe,nPosV,oNFe,oIdent,oEmitente,nFolha,nFolhas,cCodAutSef,oNfeDPEC,cCodAutDPEC,cDtHrRecCab,dDtReceb,@nLine,@nBaseCol,@nBaseTxt,aUf)
	DanfeIT(oDanfe, @nLine, @nBaseCol, @nBaseTxt, nFolha, nFolhas, @aColProd, aMensagem, nPosMsg, aTamCol)
	If nPosMsg > 0
		DanfeInfC(oDanfe,aMensagem,@nBaseTxt,@nBaseCol,@nLine,@nPosMsg,nFolha)
	EndIf
elseif nPosMsg > 0 
	oDanfe:EndPage()
	oDanfe:StartPage()
	oDanfe:Say(-0003,0820, "Pag.: " + Alltrim(Str(oDanfe:nPageCount)),oFont4,,,)
	nLinha    	:=	181                
	DanfeCab(oDanfe,nPosV,oNFe,oIdent,oEmitente,nFolha,nFolhas,cCodAutSef,oNfeDPEC,cCodAutDPEC,cDtHrRecCab,dDtReceb,@nLine,@nBaseCol,@nBaseTxt,aUf)
	
	DanfeInfC(oDanfe,aMensagem,@nBaseTxt,@nBaseCol,@nLine,@nPosMsg,nFolha,.T.)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Finaliza a Impressão                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If lPreview
	//	oDanfe:Preview()
//EndIf

oDanfe:EndPage()          

//Parâmetro que define se imprime Boleto.
If MV_PAR08 == 1

	aPergOld 	:= {}
			
	For nLoop := 1 To 60
		aAdd( aPergOld, &( "MV_PAR" + StrZero( nLoop, 02 ) ) )
	Next nLoop
	
	aAreaSD2  := SD2->(GetArea())
	aAreaSF2  := SF2->(GetArea())
	aAreaSE1  := SE1->(GetArea())
	aAreaSUA  := SUA->(GetArea())		
	
	SF2->( DbSetOrder(1) )
	SD2->( DbSetOrder(1) )
	SE1->( DbsetOrder(2) )
	SUA->( DbsetOrder(8) )
	
	//Encontrar o pedido no Televendas
	SUA->(DbSeek( xFilial("SUA") + SD2->D2_PEDIDO))
	cMenuCo := 	SUA->UA_YMENUCO	
	
	//Se for venda pelo MENU.COM,não vai emitir o boleto. 
	If cMenuCo == "1"
		
		//Posicionar na SE1 para gravar no Histórico do Titulo. 
		SE1->( Dbseek( xFilial("SE1") + SF2->(F2_CLIENTE + F2_LOJA + F2_PREFIXO + F2_DUPL ) ) )
		If SE1->(RecLock("SE1",.F.))
			SE1->E1_HIST := "VENDA MENU.COM"
			SE1->(MsUnlock())
		EndIf
	ElseIF SF2->F2_COND == '013' // condicao de pagamento da Kotaki
		If SE1->( Dbseek( xFilial("SE1") + SF2->(F2_CLIENTE + F2_LOJA + F2_PREFIXO + F2_DUPL ) ) )
			U_CTPRL160(	oDanfe)
		EndIF
	Else					
		If SF2->( DbSeek( xFilial("SF2") 							;
							+ Padr(aNota[5],TamSx3("F2_DOC")[1]) 		;
							+ Padr(aNota[4],TamSx3("F2_SERIE")[1]) 		;
							+ Padr(aNota[6],TamSx3("F2_CLIENTE")[1])	;
							+ Padr(aNota[7],TamSx3("F2_LOJA")[1])		;
							) )
			
				SX6->(DBSetOrder(1))
				If SX6->(DBSeek(xFilial("SX6")+"CL_0000538"))
					cBcoAtu		:= Padr(SX6->X6_CONTEUDO,TamSx3("EE_CODIGO")[1])
				EndIf
				If SX6->(DBSeek(xFilial("SX6")+"CL_0000539"))
					cAgeAtu		:= Padr(SX6->X6_CONTEUDO,TamSx3("EE_AGENCIA")[1])
				EndIf
				If SX6->(DBSeek(xFilial("SX6")+"CL_0000540"))
					cCtaAtu		:= Padr(SX6->X6_CONTEUDO,TamSx3("EE_CONTA")[1])
				EndIf
				If SX6->(DBSeek(xFilial("SX6")+"CL_0000541"))
					cSubAtu		:= Padr(SX6->X6_CONTEUDO,TamSx3("EE_SUBCTA")[1])
				EndIf
			
				//18/07/17-Almir Bandina-Tratamento para obter as configurações bancárias do cadastro da condição de pagamento 
				//         quando houver conforme solicitação do Sr. Daniel
				DBSelectArea("SE4")
				DBSetOrder(1)
				If DBSeek(xFilial("SE4")+SF2->F2_COND) .And. !Empty(SE4->(E4_YBCOBOL+E4_YAGEBOL+E4_YCTABOL+E4_YSUBBOL))
					cBcoAtu	:= SE4->E4_YBCOBOL
					cAgeAtu	:= SE4->E4_YAGEBOL
					cCtaAtu	:= SE4->E4_YCTABOL
					cSubAtu	:= SE4->E4_YSUBBOL
				EndIf
		
				
			//28/03/18-Almir Bandina-Tratamento para considerar o banco/agencia/conta/subconta do cadastro de amarração 
			//         Cliente x Banco, sendo esse o nivel mais baixo. Procura primeiro pelo Cliente, se não achar procura
			//         pelo grupo do Cliente
			DBSelectArea("PGH")
			DBSetOrder(2)		//PGH_FILIAL+PGH_CLIENT+PGH_GRPVEN
			If DBSeek(xFilial("PGH")+SF2->F2_CLIENTE)
				cBcoAtu	:= PGH->PGH_CODBCO
				cAgeAtu	:= PGH->PGH_AGENCI
				cCtaAtu	:= PGH->PGH_NUMCON
				cSubAtu	:= PGH->PGH_SUBCON
			Else
				DBSelectArea("SA1")
				DBSetOrder(1)		//A1_FILIAL+A1_COD+A1_LOJA
				DBSeek(xFilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA)
				// Inicio WM 2018-10-10 Tratamento nota de exportação
				lExporta := RetTipoNf()
				// Fim WM
		
				DBSelectArea("PGH")
				DBSetOrder(1)		//PGH_FILIAL+PGH_GRPVEN+PGH_CLIENT
				If !Empty(SA1->A1_GRPVEN)
					If DBSeek(xFilial("PGH")+SA1->A1_GRPVEN)
						cBcoAtu	:= PGH->PGH_CODBCO
						cAgeAtu	:= PGH->PGH_AGENCI
						cCtaAtu	:= PGH->PGH_NUMCON
						cSubAtu	:= PGH->PGH_SUBCON
					EndIf
				EndIf
			EndIf
			//28/03/18-Almir Bandina-Final
					
			
			If SE1->( Dbseek( xFilial("SE1") + SF2->(F2_CLIENTE + F2_LOJA + F2_PREFIXO + F2_DUPL ) ) )
			    
			    While SE1->(!Eof()) ;
			    .And. SE1->(E1_FILIAL + E1_CLIENTE + E1_LOJA + E1_PREFIXO + E1_NUM ) ;
			    == xFilial("SE1") + SF2->(F2_CLIENTE + F2_LOJA + F2_PREFIXO + F2_DUPL )
		
		    		SEE->(DbSetOrder(1))
				
					If SEE->( DbSeek( xFilial("SEE") + cBcoAtu + cAgeAtu + cCtaAtu +  cSubAtu ) )
			    
						U_DBMST008(  ""										;
									,""										;
									,""										;
									,""										;
									,""										;
									,""										;
									,""										;
									,Iif(Empty(SE1->E1_PORTADO),SEE->EE_CODIGO,SE1->E1_PORTADO) 			   				;
									,Iif(Empty(SE1->E1_AGEDEP),SEE->EE_AGENCIA,SE1->E1_AGEDEP)						;
									,Iif(Empty(SE1->E1_CONTA),SEE->EE_CONTA,SE1->E1_CONTA)							;
									,Iif(SE1->(FieldPos("E1_YSUBCTA")) > 0,Iif(Empty(SE1->(E1_CONTA+E1_YSUBCTA)),SEE->EE_SUBCTA,SE1->E1_YSUBCTA),"") 							;
									,Iif(Empty(SE1->E1_NUMBCO),"2","1") 	;
									,MV_PAR07 								;
									,.T.									;                
									,{{	SF2->F2_FILIAL						;
									,	SF2->F2_DOC							;
									,	SF2->F2_SERIE						;
									,	SF2->F2_CLIENTE						;
									,	SF2->F2_LOJA						;
									,	SE1->E1_PREFIXO  					;
									,	SE1->E1_PARCELA }} 					;
									,oDanfe									;
									,@__cNumBor								;
									,Iif(lViaJob,.F.,Empty(__cNumBor)) 		;
									,@_lGerouBord							)
								
		
					 	If _lGerouBord
							aAdd(aBoletos,{__cNumBor,SE1->(E1_PREFIXO + E1_NUM ), SEE->EE_CODIGO })
						EndIf
				                   
				     
				    Else
				    
				    	Aviso("DANFE-BOLETO";
				    		  ,"Não foi possivel encontrar os dados bancários para geração do boleto !" + Chr(13)+ Chr(10);
				    		  +"Banco: " + cBcoAtu + Chr(13)+ Chr(10);
				    		  +"Agência: " + cAgeAtu + Chr(13)+ Chr(10);
				    		  +"Conta: " + cCtaAtu + Chr(13)+ Chr(10);
				    		  +"Carteira/SubConta: " + cSubAtu + Chr(13)+ Chr(10);
				    		  +"Verifique os parâmetros CL_0000538, CL_0000539, CL_0000540, CL_0000541 e a tabela SEE !";
				    		  ,{"Ok"};
				    		  ,3)
				    
					EndIf				     
					SE1->(DbSkip())
				EndDo							
			EndIf     		
		EndIf
	For nLoop := 1 To 60
		&( "MV_PAR" + StrZero( nLoop, 02 ) )	:= aPergOld[nLoop]
	Next nLoop
	
	RestArea(aAreaSUA)
	RestArea(aAreaSD2)
	RestArea(aAreaSE1)
	RestArea(aAreaSF2)
	EndIf                
EndIf
                                              
Return(.T.)  

Static Function MyRetInfDesc(cInfAdic)
Local nCont1 	:= 1 
Local nPos	    := 0
Local nEsc		:= 0
Local cBkp		:= cInfAdic

cInfAdic := StrTran(cInfAdic,"|*-*| |*+*|","|*-*||*+*|")

While At("|*+*|",cInfAdic) > 0 .And. At("|*-*|",cInfAdic) > 0

	cInfAdic := Left(cInfAdic,At("|*+*|",cInfAdic) -1) + SubStr(cInfAdic,At("|*-*|",cInfAdic)+5,Len(cInfAdic))
    
	nEsc++
	
	If nEsc > 0099 
		cInfAdic := cBkp
		Exit
	EndIf

EndDo                                                             	

Return(cInfAdic)

                                                              
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ DanfeCab  ³ Autor ³ Roberto Souza        ³ Data ³ 13/08/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do Cabecalho do documento.                       ³±±
±±³			 ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FAT/FIS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function DanfeCab(oDanfe,nPosV,oNFe,oIdent,oEmitente,nFolha,nFolhas,cCodAutSef,oNfeDPEC,cCodAutDPEC,cDtHrRecCab,dDtReceb,nLine,nBaseCol,nBaseTxt,aUf)

//Local aUF		 := {}
Local nHPage     := 0
Local nVPage     := 0
Local nPosVOld   := 0
Local nPosH      := 0
Local nPosHOld   := 0
Local nAuxV      := 0
Local nAuxH      := 0
Local cChaveCont := ""
Local cDataEmi   := ""
Local cDigito    := ""
Local cTPEmis    := ""
Local cValIcm    := ""
Local cICMSp     := ""
Local cICMSs     := ""
Local cUF		 := ""
Local cCNPJCPF	 := ""
Local cLogo      := FisxLogo("1")
Local lConverte  := GetNewPar("MV_CONVERT",.F.)
Local lMv_Logod := If( GetNewPar("MV_LOGOD", "N" ) == "S", .T., .F. )
Local cLogoD	:= ""

Local cDescLogo		:= ""
Local cGrpCompany	:= ""
Local cCodEmpGrp	:= ""
Local cUnitGrp		:= ""
Local cFilGrp		:= ""
Local cFilNota		:= ""
Local cNumNota		:= ""
Local cSerNota		:= ""
Local cCodCli		:= ""
Local cLojCli		:= "" 
Local aAreaAtu		:= GetArea()
Local aAreaSF2		:= SF2->(GetArea())

Private oDPEC    := oNfeDPEC


Default cCodAutSef := ""
Default cCodAutDPEC:= ""
Default cDtHrRecCab:= ""
Default dDtReceb   := CToD("")

cNumNota	:= PadL(oNFe:_NFE:_INFNFE:_IDE:_NNF:TEXT,TamSx3("F2_DOC")[1],"0")
cSerNota	:= PadR(oNFe:_NFE:_INFNFE:_IDE:_SERIE:TEXT,TamSx3("F2_SERIE")[1])

SF2->(DbSetOrder(1))

If SF2->( DbSeek( xFilial("SF2") + Padr(cNumNota,TamSx3("F2_DOC")[1]) + Padr(cSerNota,TamSx3("F2_SERIE")[1]) ) )
	cFilNota	:= SF2->F2_FILIAL
	cCodCli		:= SF2->F2_CLIENTE
	cLojCli		:= SF2->F2_LOJA
EndIf

nLine    := -42
nBaseCol := 70

// PICOTE DO RECIBO
//oDanfe:Say(MAXBOXV, INIBOXH+80, Replicate("- ",500), oFont08N:oFont, , , 270 )
oDanfe:Say(000, INIBOXH+74, Replicate("- ",150), oFont08N:oFont, , , 90 )

oDanfe:Box(nLine+350, INIBOXH+10, MAXBOXV, INIBOXH+40)
If Len(oEmitente:_xNome:Text) >= 50
	oDanfe:Say(MAXBOXV-5, INIBOXH+20, "RECEBEMOS DE "+NoChar(oEmitente:_xNome:Text,lConverte), oFont07N:oFont, , , 270 )
	oDanfe:Say(MAXBOXV-5, INIBOXH+30, "OS PRODUTOS CONSTANTES DA NOTA FISCAL INDICADA AO LADO", oFont07N:oFont, , , 270 )
Else
	oDanfe:Say(MAXBOXV-5, INIBOXH+20, "RECEBEMOS DE "+NoChar(oEmitente:_xNome:Text,lConverte)+" OS PRODUTOS CONSTANTES DA NOTA FISCAL INDICADA AO LADO", oFont07N:oFont, , , 270 )
EndIf

oDanfe:Box(nLine+042, INIBOXH+10, nLine+350, INIBOXH+70)
	
oDanfe:Box(nLine+570,INIBOXH+35,MAXBOXV,INIBOXH+70) 
oDanfe:Say(MAXBOXV-5, INIBOXH+45, "DATA DE RECEBIMENTO", oFont07N:oFont, , , 270)

oDanfe:Box(nLine+350,INIBOXH+35,nLine+570,INIBOXH+70)
oDanfe:Say(MAXBOXV-080, INIBOXH+45, "IDENTIFICAÇÃO E ASSINATURA DO RECEBEDOR", oFont07N:oFont, , , 270)

oDanfe:QRCode(MAXBOXV-420, INIBOXH+15,SubStr(oNF:_InfNfe:_ID:Text,4), 50)

oDanfe:Say(MAXBOXV-500, INIBOXH+20, "NF-e", oFont08N:oFont, , , 270)
oDanfe:Say(MAXBOXV-522 , INIBOXH+20, "Nº "+StrZero(Val(oIdent:_NNf:Text),9), oFont08:oFont, , , 270)
oDanfe:Say(MAXBOXV-568, INIBOXH+20, "SÉRIE "+oIdent:_Serie:Text, oFont08:oFont, , , 270)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro 1 IDENTIFICACAO DO EMITENTE                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nBaseTxt := 180
oDanfe:Box(nLine+042,nBaseCol,nLine+139,450)
oDanfe:Say(nLine+057,nBaseTxt, "Identificação do emitente",oFont12N:oFont)
If len(oEmitente:_xNome:Text)>43
	oDanfe:Say(nLine+070,nBaseTxt,SubStr(NoChar(oEmitente:_xNome:Text,lConverte),1,45), oFont12N:oFont )
	oDanfe:Say(nLine+080,nBaseTxt,SubStr(NoChar(oEmitente:_xNome:Text,lConverte),46,45), oFont12N:oFont )
Else
	oDanfe:Say(nLine+070,nBaseTxt, NoChar(oEmitente:_xNome:Text,lConverte),oFont12N:oFont)
Endif
If len(oEmitente:_xNome:Text)>45
	oDanfe:Say(nLine+090,nBaseTxt, NoChar(oEmitente:_EnderEmit:_xLgr:Text,lConverte)+", "+oEmitente:_EnderEmit:_Nro:Text,oFont08N:oFont)
Else
	oDanfe:Say(nLine+080,nBaseTxt, NoChar(oEmitente:_EnderEmit:_xLgr:Text,lConverte)+", "+oEmitente:_EnderEmit:_Nro:Text,oFont08N:oFont)
Endif
If len(oEmitente:_xNome:Text)>45
	If Type("oEmitente:_EnderEmit:_xCpl") <> "U"
		oDanfe:Say(nLine+100,nBaseTxt, "Complemento: " + NoChar(oEmitente:_EnderEmit:_xCpl:TEXT,lConverte),oFont08N:oFont)
		oDanfe:Say(nLine+110,nBaseTxt, NoChar(oEmitente:_EnderEmit:_xBairro:Text,lConverte)+" Cep:"+TransForm(IIF(Type("oEmitente:_EnderEmit:_Cep")=="U","",oEmitente:_EnderEmit:_Cep:Text),"@r 99999-999"),oFont08N:oFont)
		oDanfe:Say(nLine+120,nBaseTxt, oEmitente:_EnderEmit:_xMun:Text+"/"+oEmitente:_EnderEmit:_UF:Text,oFont08N:oFont)
		oDanfe:Say(nLine+130,nBaseTxt, "Fone: "+IIf(Type("oEmitente:_EnderEmit:_Fone")=="U","",oEmitente:_EnderEmit:_Fone:Text),oFont08N:oFont)
	Else
		oDanfe:Say(nLine+100,nBaseTxt, NoChar(oEmitente:_EnderEmit:_xBairro:Text,lConverte)+" Cep:"+TransForm(IIF(Type("oEmitente:_EnderEmit:_Cep")=="U","",oEmitente:_EnderEmit:_Cep:Text),"@r 99999-999"),oFont08N:oFont)
		oDanfe:Say(nLine+110,nBaseTxt, oEmitente:_EnderEmit:_xMun:Text+"/"+oEmitente:_EnderEmit:_UF:Text,oFont08N:oFont)
		oDanfe:Say(nLine+120,nBaseTxt, "Fone: "+IIf(Type("oEmitente:_EnderEmit:_Fone")=="U","",oEmitente:_EnderEmit:_Fone:Text),oFont08N:oFont)
	EndIf
	
Else
	If Type("oEmitente:_EnderEmit:_xCpl") <> "U"
		oDanfe:Say(nLine+090,nBaseTxt, "Complemento: " + NoChar(oEmitente:_EnderEmit:_xCpl:TEXT,lConverte),oFont08N:oFont)
		oDanfe:Say(nLine+100,nBaseTxt, NoChar(oEmitente:_EnderEmit:_xBairro:Text,lConverte)+" Cep:"+TransForm(IIF(Type("oEmitente:_EnderEmit:_Cep")=="U","",oEmitente:_EnderEmit:_Cep:Text),"@r 99999-999"),oFont08N:oFont)
		oDanfe:Say(nLine+110,nBaseTxt, oEmitente:_EnderEmit:_xMun:Text+"/"+oEmitente:_EnderEmit:_UF:Text,oFont08N:oFont)
		oDanfe:Say(nLine+120,nBaseTxt, "Fone: "+IIf(Type("oEmitente:_EnderEmit:_Fone")=="U","",oEmitente:_EnderEmit:_Fone:Text),oFont08N:oFont)
	Else
		oDanfe:Say(nLine+090,nBaseTxt, NoChar(oEmitente:_EnderEmit:_xBairro:Text,lConverte)+" Cep:"+TransForm(IIF(Type("oEmitente:_EnderEmit:_Cep")=="U","",oEmitente:_EnderEmit:_Cep:Text),"@r 99999-999"),oFont08N:oFont)
		oDanfe:Say(nLine+100,nBaseTxt, oEmitente:_EnderEmit:_xMun:Text+"/"+oEmitente:_EnderEmit:_UF:Text,oFont08N:oFont)
		oDanfe:Say(nLine+110,nBaseTxt, "Fone: "+IIf(Type("oEmitente:_EnderEmit:_Fone")=="U","",oEmitente:_EnderEmit:_Fone:Text),oFont08N:oFont)
	EndIf
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro 2                                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nBaseTxt := 460
oDanfe:Box(nLine+042,450,nLine+139,602)
oDanfe:Say(nLine+055,nBaseTxt+35, "DANFE",oFont18N:oFont)
oDanfe:Say(nLine+065,nBaseTxt+10, "DOCUMENTO AUXILIAR DA",oFont10:oFont)
oDanfe:Say(nLine+075,nBaseTxt+10, "NOTA FISCAL ELETRÔNICA",oFont10:oFont)
oDanfe:Say(nLine+085,nBaseTxt+15, "0-ENTRADA",oFont10:oFont)
oDanfe:Say(nLine+095,nBaseTxt+15, "1-SAÍDA"  ,oFont10:oFont)
oDanfe:Box(nLine+078,nBaseTxt+70,nLine+092,nBaseTxt+85)
oDanfe:Say(nLine+088,nBaseTxt+75, oIdent:_TpNf:Text,oFont10N:oFont)
oDanfe:Say(nLine+110,nBaseTxt,"N. "+StrZero(Val(oIdent:_NNf:Text),9),oFont10N:oFont)
oDanfe:Say(nLine+120,nBaseTxt,"SÉRIE "+SubStr(oIdent:_Serie:Text,1,3),oFont10N:oFont)
oDanfe:Say(nLine+130,nBaseTxt,"FOLHA "+StrZero(nFolha,2)+"/"+StrZero(nFolhas,2),oFont10N:oFont)

nHPage := oDanfe:nHorzRes()
nHPage *= (300/PixelX)
nHPage -= HMARGEM
nVPage := oDanfe:nVertRes()
nVPage *= (300/PixelY)
nVPage -= VBOX

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Logotipo                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lMv_Logod
	cGrpCompany	:= AllTrim(FWGrpCompany())
	cCodEmpGrp	:= AllTrim(FWCodEmp())
	cUnitGrp	:= AllTrim(FWUnitBusiness())
	cFilGrp		:= AllTrim(FWFilial())

	If !Empty(cUnitGrp)
		cDescLogo	:= cGrpCompany + cCodEmpGrp + cUnitGrp + cFilGrp
	Else
		cDescLogo	:= cEmpAnt + cFilAnt
	EndIf

	cLogoD := GetSrvProfString("Startpath","") + "DANFE" + cDescLogo + ".BMP"
	If !File(cLogoD)
		cLogoD	:= GetSrvProfString("Startpath","") + "DANFE" + cEmpAnt + ".BMP"
		If !File(cLogoD)
			lMv_Logod := .F.
		EndIf
	EndIf	
EndIf

If nfolha>=1
	If lMv_Logod
		oDanfe:SayBitmap(005,075,cLogoD,095,096)
	Else
		oDanfe:SayBitmap(005,075,cLogo,095,096)
	EndIf
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Codigo de barra                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nBaseTxt := 612
oDanfe:Box(nLine+042,602,nLine+088,MAXBOXH+70)
oDanfe:Box(nLine+075,602,nLine+077,MAXBOXH+70)
oDanfe:Box(nLine+077,602,nLine+110,MAXBOXH+70)
oDanfe:Box(nLine+105,602,nLine+139,MAXBOXH+70)
oDanfe:Say(nLine+097,nBaseTxt,TransForm(SubStr(oNF:_InfNfe:_ID:Text,4),"@r 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999"),oFont10N:oFont)


If nFolha >= 1
	oDanfe:Say(nLine+087,nBaseTxt,"CHAVE DE ACESSO DA NF-E",oFont09N:oFont)
	nFontSize := 28
	oDanfe:Code128C(nLine+072,nBaseTxt,SubStr(oNF:_InfNfe:_ID:Text,4), nFontSize )
EndIf

If !Empty(cCodAutDPEC) .And. (oNFe:_NFE:_INFNFE:_IDE:_TPEMIS:TEXT)$"4" .And. !lUsaColab
	cDataEmi := Iif(oNF:_INFNFE:_VERSAO:TEXT >= "3.10",Substr(oNFe:_NFE:_INFNFE:_IDE:_DHEMI:Text,9,2),Substr(oNFe:_NFE:_INFNFE:_IDE:_DEMI:Text,9,2))
	cTPEmis  := "4"
	If Type("oDPEC:_ENVDPEC:_INFDPEC:_RESNFE") <> "U"
		cUF      := aUF[aScan(aUF,{|x| x[1] == oDPEC:_ENVDPEC:_INFDPEC:_RESNFE:_UF:Text})][02]
		cValIcm := StrZero(Val(StrTran(oDPEC:_ENVDPEC:_INFDPEC:_RESNFE:_VNF:TEXT,".","")),14)
		cICMSp := iif(Val(oDPEC:_ENVDPEC:_INFDPEC:_RESNFE:_VICMS:TEXT)>0,"1","2")
		cICMSs := iif(Val(oDPEC:_ENVDPEC:_INFDPEC:_RESNFE:_VST:TEXT)>0,"1","2")
	ElseIf type ("oDPEC:_EVENTO:_INFEVENTO:_DETEVENTO:_DEST") <> "U" //EPEC NFE
		If Type ("oDPEC:_EVENTO:_INFEVENTO:_DETEVENTO:_DEST:_UF:TEXT") <> "U"
			cUF := aUF[aScan(aUF,{|x| x[1] == oDPEC:_EVENTO:_INFEVENTO:_DETEVENTO:_DEST:_UF:TEXT})][02]			
		EndIf
		If Type ("oDPEC:_EVENTO:_INFEVENTO:_DETEVENTO:_DEST:_VNF:TEXT") <> "U"
			cValIcm := StrZero(Val(StrTran(oDPEC:_EVENTO:_INFEVENTO:_DETEVENTO:_DEST:_VNF:TEXT,".","")),14)
		EndIf
		If 	Type ("oDPEC:_EVENTO:_INFEVENTO:_DETEVENTO:_DEST:_VICMS:TEXT") <> "U"
			cICMSp:= IIf(Val(oDPEC:_EVENTO:_INFEVENTO:_DETEVENTO:_DEST:_VICMS:TEXT) > 0,"1","2")
		EndIf
		If 	Type ("oDPEC:_EVENTO:_INFEVENTO:_DETEVENTO:_DEST:_VST:TEXT") <> "U"
			cICMSs := IIf(Val(oDPEC:_EVENTO:_INFEVENTO:_DETEVENTO:_DEST:_VST:TEXT )> 0,"1","2")
		EndIf	
	EndIf
ElseIF (oNFe:_NFE:_INFNFE:_IDE:_TPEMIS:TEXT)$"25" .Or. ( (oNFe:_NFE:_INFNFE:_IDE:_TPEMIS:TEXT)$"4" .And. lUsaColab .And. !Empty(cCodAutDPEC) )
	cUF      := aUF[aScan(aUF,{|x| x[1] == oNFe:_NFE:_INFNFE:_DEST:_ENDERDEST:_UF:Text})][02]
	cDataEmi := Iif(oNF:_INFNFE:_VERSAO:TEXT >= "3.10",Substr(oNFe:_NFE:_INFNFE:_IDE:_DHEMI:Text,9,2),Substr(oNFe:_NFE:_INFNFE:_IDE:_DEMI:Text,9,2))
	cTPEmis  := oNFe:_NFE:_INFNFE:_IDE:_TPEMIS:TEXT
	cValIcm  := StrZero(Val(StrTran(oNFe:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VNF:TEXT,".","")),14)
	cICMSp   := iif(Val(oNFe:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VICMS:TEXT)>0,"1","2")
	cICMSs   :=iif(Val(oNFe:_NFE:_INFNFE:_TOTAL:_ICMSTOT:_VST:TEXT)>0,"1","2")
EndIf
If !Empty(cUF) .And. !Empty(cDataEmi) .And. !Empty(cTPEmis) .And. !Empty(cValIcm) .And. !Empty(cICMSp) .And. !Empty(cICMSs)
	If Type("oNF:_InfNfe:_DEST:_CNPJ:Text")<>"U"
		cCNPJCPF := oNF:_InfNfe:_DEST:_CNPJ:Text
		If cUf == "99"
			cCNPJCPF := STRZERO(val(cCNPJCPF),14)
		EndIf
	ElseIf Type("oNF:_INFNFE:_DEST:_CPF:Text")<>"U"
		cCNPJCPF := oNF:_INFNFE:_DEST:_CPF:Text
		cCNPJCPF := STRZERO(val(cCNPJCPF),14)
	Else
		cCNPJCPF := ""
	EndIf
	cChaveCont += cUF+cTPEmis+cCNPJCPF+cValIcm+cICMSp+cICMSs+cDataEmi
	cChaveCont := cChaveCont+Modulo11(cChaveCont)
EndIf

If Empty(cChaveCont)
	oDanfe:Say(nLine+117,nBaseTxt,"Consulta de autenticidade no portal nacional da NF-e",oFont10:oFont)
	oDanfe:Say(nLine+127,nBaseTxt,"www.nfe.fazenda.gov.br/portal ou no site da SEFAZ Autorizada",oFont10:oFont)
Endif

If  !Empty(cCodAutDPEC)
	oDanfe:Say(nLine+117,nBaseTxt,"Consulta de autenticidade no portal nacional da NF-e",oFont10:oFont)
	oDanfe:Say(nLine+127,nBaseTxt,"www.nfe.fazenda.gov.br/portal ou no site da SEFAZ Autorizada",oFont10:oFont)
Endif


// inicio do segundo codigo de barras ref. a transmissao CONTIGENCIA OFF LINE
If !Empty(cChaveCont) .And. Empty(cCodAutDPEC) .And. !(Val(SubStr(oNF:_INFNFE:_IDE:_SERIE:TEXT,1,3)) >= 900)
	If nFolha == 1
		If !Empty(cChaveCont)
			nFontSize := 28
			oDanfe:Code128C(nLine+135,nBaseTxt,cChaveCont, nFontSize )
		EndIf
	Else
		If !Empty(cChaveCont)
			nFontSize := 28
			oDanfe:Code128C(nLine+135,nBaseTxt,cChaveCont, nFontSize )
		EndIf
	EndIf
EndIf



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro 4   NATUREZA DA OPERACAO /  DADOS NFE / DPEC                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nBaseTxt := nBaseCol + 10
oDanfe:Box(nLine+139,nBaseCol,nLine+164,602)
oDanfe:Box(nLine+139,602,nLine+164,MAXBOXH+70)

oDanfe:Say(nLine+148,nBaseTxt,"NATUREZA DA OPERAÇÃO",oFont08N:oFont)
oDanfe:Say(nLine+158,nBaseTxt,oIdent:_NATOP:TEXT,oFont08:oFont)
If(!Empty(cCodAutDPEC))
	oDanfe:Say(nLine+148,610,"NÚMERO DE REGISTRO DPEC",oFont08N:oFont)
	
Endif
If(((Val(SubStr(oNF:_INFNFE:_IDE:_SERIE:TEXT,1,3)) >= 900).And.(oNFe:_NFE:_INFNFE:_IDE:_TPEMIS:TEXT)$"2") .Or. (oNFe:_NFE:_INFNFE:_IDE:_TPEMIS:TEXT)$"1|6|7")
	oDanfe:Say(nLine+148,610,"PROTOCOLO DE AUTORIZAÇÃO DE USO",oFont08N:oFont)
Endif
If((oNFe:_NFE:_INFNFE:_IDE:_TPEMIS:TEXT)$"25")
	oDanfe:Say(nLine+148,610,"DADOS DA NF-E",oFont08N:oFont)
Endif
oDanfe:Say(nLine+158,610,IIF(!Empty(cCodAutDPEC),cCodAutDPEC+" "+AllTrim(IIF(!Empty(dDtReceb),ConvDate(DTOS(dDtReceb)),Iif(oNF:_INFNFE:_VERSAO:TEXT >= "3.10",ConvDate(oNF:_InfNfe:_IDE:_DHEMI:Text),ConvDate(oNF:_InfNfe:_IDE:_DEMI:Text))))+" "+AllTrim(cDtHrRecCab),IIF(!Empty(cCodAutSef) .And. ((Val(SubStr(oNF:_INFNFE:_IDE:_SERIE:TEXT,1,3)) >= 900).And.(oNFe:_NFE:_INFNFE:_IDE:_TPEMIS:TEXT)$"2") .Or. (oNFe:_NFE:_INFNFE:_IDE:_TPEMIS:TEXT)$"1|6|7",cCodAutSef+" "+AllTrim(IIF(!Empty(dDtReceb),ConvDate(DTOS(dDtReceb)),Iif(oNF:_INFNFE:_VERSAO:TEXT >= "3.10",ConvDate(oNF:_InfNfe:_IDE:_DHEMI:Text),ConvDate(oNF:_InfNfe:_IDE:_DEMI:Text))))+" "+AllTrim(cDtHrRecCab),TransForm(cChaveCont,"@r 9999 9999 9999 9999 9999 9999 9999 9999 9999"))),oFont08:oFont)
nFolha++

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quadro 5                                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oDanfe:Box(nLine+164 - nAjustaNat,nBaseCol,nLine+189 - nAjustaNat,350)
oDanfe:Box(nLine+164 - nAjustaNat,350,nLine+189 - nAjustaNat,602)
oDanfe:Box(nLine+164 - nAjustaNat,602,nLine+189 - nAjustaNat,MAXBOXH+70)
oDanfe:Say(nLine+172 - nAjustaNat,nBaseTxt,"INSCRIÇÃO ESTADUAL",oFont08N:oFont)
oDanfe:Say(nLine+180 - nAjustaNat,nBaseTxt,IIf(Type("oEmitente:_IE:TEXT")<>"U",oEmitente:_IE:TEXT,""),oFont08:oFont)
oDanfe:Say(nLine+172 - nAjustaNat,360,"INSC.ESTADUAL DO SUBST.TRIB.",oFont08N:oFont)
oDanfe:Say(nLine+180 - nAjustaNat,362,IIf(Type("oEmitente:_IEST:TEXT")<>"U",oEmitente:_IEST:TEXT,""),oFont08:oFont)
oDanfe:Say(nLine+172 - nAjustaNat,612,"CNPJ/CPF",oFont08N:oFont)

Do Case
	Case Type("oEmitente:_CNPJ")=="O"
		cAux := TransForm(oEmitente:_CNPJ:TEXT,"@r 99.999.999/9999-99")
	Case Type("oEmitente:_CPF")=="O"
		cAux := TransForm(oEmitente:_CPF:TEXT,"@r 999.999.999-99")
	OtherWise
		cAux := Space(14)
EndCase
oDanfe:Say(nLine+180 - nAjustaNat,612,cAux,oFont08:oFont)

Return()

//============================================
//		Template DBM X ITGS
//  Variavel Customizada : lYPadrao 
//============================================

Static Function GetXML(cIdEnt,aIdNFe,cModalidade,lAutomato,lYPadrao,cTpNota)  

Local aRetorno		:= {}
Local aDados		:= {}

Local cURL			:= PadR(GetNewPar("MV_SPEDURL","http://localhost:8080/sped"),250)
Local cModel		:= "55"
Local nZ			:= 0
Local nCount		:= 0
Local oWS
Local aCopy			:= aClone(aIdNFe)
Local aCopy2		:= aClone(aIdNFe)
Local nCont1		:= 1
Local nPos			:= 0
Local aNotas		:= {}
Local cNotas		:= ""

//	Template DBM X ITGS
Default lYPadrao	:= .T.
default lAutomato := .F.
If !lYPadrao  // ITGS

	aRetorno := aClone(U_T9WSDanfe(aIdNfe, cTpNota ))
			
EndIf 
	
If Len(aRetorno) == 0 .or.  lYPadrao .OR. Len(aRetorno) < Len(aIdNfe)

	cIdEnt := RetIdEnti()
	
	If Empty(cModalidade)    
	
		oWS := WsSpedCfgNFe():New()
		oWS:cUSERTOKEN := "TOTVS"
		oWS:cID_ENT    := cIdEnt
		oWS:nModalidade:= 0
		oWS:_URL       := AllTrim(cURL)+"/SPEDCFGNFe.apw"
		oWS:cModelo    := cModel 
		
		
		if lAutomato
			if FindFunction("getParAuto")
				aRetAuto := GetParAuto("AUTONFETestCase")
				cModalidade := aRetAuto[07]
			endif
		else
			If oWS:CFGModalidade()
				cModalidade    := SubStr(oWS:cCfgModalidadeResult,1,1)
			Else
				cModalidade    := ""
			EndIf
		endif  
		
	EndIf  
	         
	oWs := nil
	
	For nZ := 1 To len(aIdNfe) 
	
	    nCount++
	
		aDados := executeRetorna( aIdNfe[nZ], cIdEnt, , lAutomato )
		
		if ( nCount == 10 )
			delClassIntF()
			nCount := 0
		endif
		
		If !Empty(aDados[1])
			aAdd(aRetorno,aDados)
		EndIf
		
	Next nZ
	
EndIf

If Len(aRetorno) == 0
	aRetorno := {{"","","","","","",cTOd("  /  /  "),"",""}}
EndIf

If Len(aRetorno) > 0
	aEval(aCopy2,{ |x,y| _y := y, aCopy2[y] := Array(Len(aRetorno[1])), aEval(aCopy2[y],{|z,w| aCopy2[_y][w] := MyRetDefault(aRetorno[1][w]) }) })
EndIf

For nCont1 := 1 To Len(aRetorno)
	
	nPos := aScan(aCopy,{ |x| Alltrim(x[5]) == Alltrim(SubStr(aRetorno[nCont1][3],4,TamSx3("F2_DOC")[1])) .And. Alltrim(x[4]) == Alltrim(SubStr(aRetorno[nCont1][3],1,TamSx3("F2_SERIE")[1])) })
	
	If nPos > 0
	
		aCopy2[nPos] := aClone(aRetorno[nCont1])

	EndIf
		
Next nCont1
                                                                                                         
aEval(aCopy2,{|x,y| Iif(Empty(x[2]),aAdd(aNotas,Alltrim(aCopy[y][5]) + "-" + Alltrim(aCopy[y][4])),Nil)})

If Len(aNotas) > 50

	aEval(aCopy2,{|x,y| Iif(Empty(x[2]),Aviso("DANFE " + Alltrim(aCopy[y][5]) + "-" + Alltrim(aCopy[y][4])												;
											,"Não foi possível recuperar a  nota fiscal " + Alltrim(aCopy[y][5]) + "-" + Alltrim(aCopy[y][4]) + "! " 	;
											+"Esta nota NÃO será impressa ! Confira a impressão após a finalização !"									;
											,{"Ok"}																										;
											,3)																											;
											,Nil) ;
					})


Else
    
	If Len(aNotas) > 0
	
		cNotas := ""
		
		aEval(aNotas,{|x,y| cNotas += x + Chr(13) + Chr(10) })
	
		Aviso("DANFES"																									;
			,"Não foi possível recuperar as notas fiscais abaixo. Tais notas NÃO serão impressas ! Confira a impressão " ;
			+ " após a finalização !" + Chr(13) + Chr(10) + cNotas														;
			,{"Ok"}																										;
			,3)
	
	EndIf
	
EndIF


Return(aClone(aCopy2))

Static Function MyRetDefault(xRetVal)
Local xRetDefault := Nil

If ValType(xRetVal) == "C"
	xRetDefault := ""
ElseIf ValType(xRetVal) == "D"
	xRetDefault := cTod("  /  /  ")
ElseIf ValType(xRetVal) == "L"
	xRetDefault := .F.
ElseIf ValType(xRetVal) == "N"
	xRetDefault := 0
EndIf

Return(xRetDefault)

Static Function ConvDate(cData)
Local dData
cData  := StrTran(cData,"-","")
dData  := Stod(cData)
Return PadR(StrZero(Day(dData),2)+ "/" + StrZero(Month(dData),2)+ "/" + StrZero(Year(dData),4),15)
  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DANFE     ºAutor  ³Marcos Taranta      º Data ³  10/01/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Pega uma posição (nTam) na string cString, e retorna o      º±±
±±º          ³caractere de espaço anterior.                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function EspacoAt(cString, nTam)

Local nRetorno := 0
Local nX       := 0

/**
* Caso a posição (nTam) for maior que o tamanho da string, ou for um valor
* inválido, retorna 0.
*/
If nTam > Len(cString) .Or. nTam < 1
	nRetorno := 0
	Return nRetorno
EndIf

/**
* Procura pelo caractere de espaço anterior a posição e retorna a posição
* dele.
*/
nX := nTam
While nX > 1
	If Substr(cString, nX, 1) == " "
		nRetorno := nX
		Return nRetorno
	EndIf
	
	nX--
EndDo

/**
* Caso não encontre nenhum caractere de espaço, é retornado 0.
*/
nRetorno := 0

Return nRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ DanfeIT   ³ Autor ³ Roberto Souza        ³ Data ³ 13/08/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do Box de Itens.                                 ³±±
±±³			 ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FAT/FIS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function DanfeIT(oDanfe, nLine, nBaseCol, nBaseTxt, nFolha, nFolhas, aColProd, aMensagem, nPosMsg, aTamCol)
	
Local nAux  := 0
Local nAux2 := 0
Local nX    := 0
Local cMVCODREG	:= Alltrim( SuperGetMV("MV_CODREG", ," ") )
aTamCol[01] := 0045
aTamCol[02] := 0143
aTamCol[03] := 0040
aTamCol[04] := 0035
aTamCol[05] := 0022
aTamCol[06] := 0022
aTamCol[07] := 0013
aTamCol[08] := 0047
aTamCol[09] := 0049
aTamCol[10] := 0042
aTamCol[11] := 0041
aTamCol[12] := 0038
aTamCol[13] := 0045
aTamCol[14] := 0044
aTamCol[15] := 0040
aTamCol[16] := 0042
aTamCol[17] := 0031
aTamCol[18] := 0031                               

oBrush := TBrush():New( , CLR_BLACK )

If nFolha == 1   

	nLine -= 2

	nBaseTxt -= 30
	oDanfe:FillRect({nLine+455,nBaseCol,nLine+574,nBaseCol+30},oBrush)
	
	oDanfe:Say(nLine+568,nBaseTxt+7,"DADOS DO PRODUTO / SERVIÇO",oFont08N:oFont, ,CLR_WHITE , 270 )
	nBaseTxt += 30 
	aColProd := {}
	nAux     := nBaseCol + 30	
	AADD(aColProd, {nAux, nAux + aTamCol[1]}) //"COD. PROD"
	nAux += aTamCol[1]
	AADD(aColProd, {nAux, nAux + aTamCol[2]}) // "DESCRIÇÃO DO PRODUTOS/SERVIÇOS"
	nAux += aTamCol[2]
	AADD(aColProd, {nAux, nAux + aTamCol[3]}) // "QTD.CAIXA"
	nAux += aTamCol[3]
	AADD(aColProd, {nAux, nAux + aTamCol[4]}) // "NCM/SH"
	nAux += aTamCol[4]
	AADD(aColProd, {nAux, nAux + aTamCol[5]}) // "CST"
	nAux += aTamCol[5]
	AADD(aColProd, {nAux, nAux + aTamCol[6]}) // "CFOP"
	nAux += aTamCol[6]
	AADD(aColProd, {nAux, nAux + aTamCol[7]}) // "UN"
	nAux += aTamCol[7]
	AADD(aColProd, {nAux, nAux + aTamCol[8]}) // "QUANT."
	nAux += aTamCol[8]
	AADD(aColProd, {nAux, nAux + aTamCol[9]}) // "V.UNITARIO" 
	nAux += aTamCol[9]
	AADD(aColProd, {nAux, nAux + aTamCol[10]}) // "DESC %"
	nAux += aTamCol[10]
	AADD(aColProd, {nAux, nAux + aTamCol[11]}) // "V.UNI LIQ"  
	nAux += aTamCol[11]
	AADD(aColProd, {nAux, nAux + aTamCol[12]}) // "TOT.DESC"
	nAux += aTamCol[12]
	AADD(aColProd, {nAux, nAux + aTamCol[13]}) // "TOTAL LIQ"
	nAux += aTamCol[13]
	AADD(aColProd, {nAux, nAux + aTamCol[14]}) // "BASE ICMS"
	nAux += aTamCol[14]
	AADD(aColProd, {nAux, nAux + aTamCol[15]}) // "VLR ICMS"
	nAux += aTamCol[15]
	AADD(aColProd, {nAux, nAux + aTamCol[16]}) // "VALOR IPI"
	nAux += aTamCol[16]
	AADD(aColProd, {nAux, nAux + aTamCol[17]}) // "ICMS"
	nAux += aTamCol[17]
	AADD(aColProd, {nAux, nAux + aTamCol[18]}) // "IPI"

	oDanfe:Box(nLine+454,nBaseCol+31,nLine+574,MAXBOXH+70)
	nAux := nBaseCol + 30	
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[1])
	oDanfe:Say(nLine+462, nAux + 2,"COD. PROD", oFont08N:oFont)
	nAux += aTamCol[1]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[2])
	oDanfe:Say(nLine+462, nAux + 2,"DESCR PROD", oFont08N:oFont)
	nAux += aTamCol[2]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[3])
	oDanfe:Say(nLine+462, nAux + 2,"QTD.CAIXA", oFont08N:oFont)
	nAux += aTamCol[3]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[4])
	oDanfe:Say(nLine+462, nAux + 2,"NCM/SH", oFont08N:oFont)
	nAux += aTamCol[4]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[5])
	oDanfe:Say(nLine+462, nAux + 2,"CST", oFont08N:oFont)
	nAux += aTamCol[5]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[6])
	oDanfe:Say(nLine+462, nAux + 2,"CFOP", oFont08N:oFont)
	nAux += aTamCol[6]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[7])
	oDanfe:Say(nLine+462, nAux + 2,"UN", oFont08N:oFont)
	nAux += aTamCol[7]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[8])
	oDanfe:Say(nLine+462, nAux + 2,"QUANT.", oFont08N:oFont)
	nAux += aTamCol[8]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[9])
	oDanfe:Say(nLine+462, nAux + 2,"V.UNITARIO", oFont08N:oFont)
	nAux += aTamCol[9]
//	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[10])
  //	oDanfe:Say(nLine+462, nAux + 2,"DESC", oFont08N:oFont)
//	nAux += aTamCol[10]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[10])
	oDanfe:Say(nLine+462, nAux + 2,"DESC %", oFont08N:oFont)
	nAux += aTamCol[10]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[11])
	oDanfe:Say(nLine+462, nAux + 2,"V.UNI LIQ", oFont08N:oFont)
	nAux += aTamCol[11]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[12])
	oDanfe:Say(nLine+462, nAux + 2,"TOT.DESC", oFont08N:oFont)
	nAux += aTamCol[12]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[13])
	oDanfe:Say(nLine+462, nAux + 2,"TOTAL LIQ", oFont08N:oFont)
	nAux += aTamCol[13]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[14])
	oDanfe:Say(nLine+462, nAux + 2,"BASE ICMS", oFont08N:oFont)
	nAux  += aTamCol[14]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[15])
	oDanfe:Say(nLine+462, nAux + 2,"VLR ICMS", oFont08N:oFont)
	nAux  += aTamCol[15]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[16])
	oDanfe:Say(nLine+462, nAux + 2,"VALOR IPI", oFont08N:oFont)
	nAux  += aTamCol[16]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[17])
	oDanfe:Say(nLine+462, nAux + 2,"ICMS", oFont08N:oFont)
	nAux += aTamCol[17]
	oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[18])
	oDanfe:Say(nLine+462, nAux + 2,"IPI", oFont08N:oFont)
	
	For Nx :=1 to Len(aColProd)
		If ( valType(oEntrega)=="U" ) .and. ( valType(oRetirada)=="U")
			oDanfe:Box(nLine+469,aColProd[nX][1],nLine+575,aColProd[nX][2])
		ElseIf ( valType(oEntrega)=="O" ) .or. ( valType(oRetirada)=="O")
			oDanfe:Box(nLine+469+nAjustaPro,aColProd[nX][1],nLine+575+20,aColProd[nX][2])		
		Endif
	Next
Else
                                  
	If nPosMsg > 0
		nLine -= 265
	
	//	nBaseTxt -= 30 
	//	oDanfe:Box(nLine+454,nBaseCol,MAXBOXV,nBaseCol+30)
		oDanfe:FillRect({nLine+455,nBaseCol,397,nBaseCol+30},oBrush)
		oDanfe:Say(360,nBaseTxt+7,"DADOS DO PRODUTO / SERVIÇO",oFont08N:oFont, , CLR_WHITE, 270 )
		nBaseTxt += 30 
		aColProd := {}
		nAux     := nBaseCol + 30
		AADD(aColProd, {nAux, nAux + aTamCol[1]}) //"COD. PROD"
		nAux += aTamCol[1]
		AADD(aColProd, {nAux, nAux + aTamCol[2]}) // "DESCRIÇÃO DO PRODUTOS/SERVIÇOS"
		nAux += aTamCol[2]
		AADD(aColProd, {nAux, nAux + aTamCol[3]}) // "NCM/SH"
		nAux += aTamCol[3]
		AADD(aColProd, {nAux, nAux + aTamCol[4]}) // "QTD.CAIXA"
		nAux += aTamCol[4]
		AADD(aColProd, {nAux, nAux + aTamCol[5]}) // "CST"
		nAux += aTamCol[5]
		AADD(aColProd, {nAux, nAux + aTamCol[6]}) // "CFOP"
		nAux += aTamCol[6]
		AADD(aColProd, {nAux, nAux + aTamCol[7]}) // "UN"
		nAux += aTamCol[7]
		AADD(aColProd, {nAux, nAux + aTamCol[8]}) // "QUANT."
		nAux += aTamCol[8]
		AADD(aColProd, {nAux, nAux + aTamCol[9]}) // "V.UNITARIO"
		nAux += aTamCol[9]
		//AADD(aColProd, {nAux, nAux + aTamCol[10]}) // "PER DESC"
		//nAux += aTamCol[10]
		AADD(aColProd, {nAux, nAux + aTamCol[10]}) // "VLR DESC"
		nAux += aTamCol[10]
		AADD(aColProd, {nAux, nAux + aTamCol[11]}) // "V.UNI LIQ"
		nAux += aTamCol[11]
		AADD(aColProd, {nAux, nAux + aTamCol[12]}) // "TOT.DESC"
		nAux += aTamCol[12]
		AADD(aColProd, {nAux, nAux + aTamCol[13]}) // "TOTAL LIQ"
		nAux += aTamCol[13]
		AADD(aColProd, {nAux, nAux + aTamCol[14]}) // "BASE ICMS"
		nAux += aTamCol[14]
		AADD(aColProd, {nAux, nAux + aTamCol[15]}) // "VLR ICMS"
		nAux += aTamCol[15]
		AADD(aColProd, {nAux, nAux + aTamCol[16]}) // "VALOR IPI"
		nAux += aTamCol[16]
		AADD(aColProd, {nAux, nAux + aTamCol[17]}) // "ICMS"
		nAux += aTamCol[17]
		AADD(aColProd, {nAux, nAux + aTamCol[18]}) // "IPI"

		oDanfe:Box(nLine+454,nBaseCol+31,398,MAXBOXH+70)
		nAux := nBaseCol + 30
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[1])
		oDanfe:Say(nLine+462, nAux + 2,"COD. PROD", oFont08N:oFont)
		nAux += aTamCol[1]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[2])
		oDanfe:Say(nLine+462, nAux + 2,"DESCR PROD", oFont08N:oFont)
		nAux += aTamCol[2]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[3])
		oDanfe:Say(nLine+462, nAux + 2,"QTD.CAIXA", oFont08N:oFont)
		nAux += aTamCol[3]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[4])
		oDanfe:Say(nLine+462, nAux + 2,"NCM/SH", oFont08N:oFont)
		If cMVCODREG == "1"
			oDanfe:Say(nLine+462, nAux + 2,"CSOSN", oFont08N:oFont)
		Else
			oDanfe:Say(nLine+462, nAux + 2,"CST", oFont08N:oFont)
		Endif
		nAux += aTamCol[4]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[5])
		oDanfe:Say(nLine+462, nAux + 2,"CST", oFont08N:oFont)
		nAux += aTamCol[5]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[6])
		oDanfe:Say(nLine+462, nAux + 2,"CFOP", oFont08N:oFont)
		nAux += aTamCol[6]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[7])
		oDanfe:Say(nLine+462, nAux + 2,"UN", oFont08N:oFont)
		nAux += aTamCol[7]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[8])
		oDanfe:Say(nLine+462, nAux + 2,"QUANT.", oFont08N:oFont)
		nAux += aTamCol[8]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[9])
		oDanfe:Say(nLine+462, nAux + 2,"V.UNITARIO", oFont08N:oFont)
		nAux += aTamCol[9]
//		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[10])
//		oDanfe:Say(nLine+462, nAux + 2,"DESC", oFont08N:oFont)
//		nAux += aTamCol[10]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[10])
		oDanfe:Say(nLine+462, nAux + 2,"DESC %", oFont08N:oFont)
		nAux += aTamCol[10]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[11])
		oDanfe:Say(nLine+462, nAux + 2,"V.UNI LIQ", oFont08N:oFont)
		nAux += aTamCol[11]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[12])
		oDanfe:Say(nLine+462, nAux + 2,"TOT.DESC", oFont08N:oFont)
		nAux += aTamCol[12]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[13])
		oDanfe:Say(nLine+462, nAux + 2,"TOTAL LIQ", oFont08N:oFont)
		nAux += aTamCol[13]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[14])
		oDanfe:Say(nLine+462, nAux + 2,"BASE ICMS", oFont08N:oFont)
		nAux  += aTamCol[14]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[15])
		oDanfe:Say(nLine+462, nAux + 2,"VLR ICMS", oFont08N:oFont)
		nAux  += aTamCol[15]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[16])
		oDanfe:Say(nLine+462, nAux + 2,"VALOR IPI", oFont08N:oFont)
		nAux  += aTamCol[16]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[17])
		oDanfe:Say(nLine+462, nAux + 2,"ICMS", oFont08N:oFont)
		nAux += aTamCol[17]
		nAux2 := nAux
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[18])
		oDanfe:Say(nLine+462, nAux + 2,"IPI", oFont08N:oFont)
		nAux += aTamCol[18]
//		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[19])
//		oDanfe:Say(nLine+468, nAux + 2,"IPI", oFont08N:oFont)
//		oDanfe:Box(nLine+454, nAux2, nLine+461, nAux2 + aTamCol[18] + aTamCol[19])
//		oDanfe:Say(nLine+460, nAux2 + 2,"ALIQUOTA", oFont08N:oFont)
		
		For Nx :=1 to Len(aColProd)
			oDanfe:Box(nLine+469,aColProd[nx][1],398,aColProd[nx][2])	
		Next
		nLine -= 257

	Else 
	
		nLine -= 265
	
	//	nBaseTxt -= 30 
	//	oDanfe:Box(nLine+454,nBaseCol,MAXBOXV,nBaseCol+30)
		oDanfe:FillRect({nLine+455,nBaseCol,MAXBOXV-1,nBaseCol+30},oBrush)
		oDanfe:Say(nLine+768,nBaseTxt+7,"DADOS DO PRODUTO / SERVIÇO",oFont08N:oFont, , CLR_WHITE, 270 )
		nBaseTxt += 30 
		aColProd := {}
		nAux     := nBaseCol + 30
		AADD(aColProd, {nAux, nAux + aTamCol[1]}) //"COD. PROD"
		nAux += aTamCol[1]
		AADD(aColProd, {nAux, nAux + aTamCol[2]}) // "DESCRIÇÃO DO PRODUTOS/SERVIÇOS"
		nAux += aTamCol[2]
		AADD(aColProd, {nAux, nAux + aTamCol[3]}) // "QTD.CAIXA"
		nAux += aTamCol[3]
		AADD(aColProd, {nAux, nAux + aTamCol[4]}) // "NCM/SH"
		nAux += aTamCol[4]
		AADD(aColProd, {nAux, nAux + aTamCol[5]}) // "CST"
		nAux += aTamCol[5]
		AADD(aColProd, {nAux, nAux + aTamCol[6]}) // "CFOP"
		nAux += aTamCol[6]
		AADD(aColProd, {nAux, nAux + aTamCol[7]}) // "UN"
		nAux += aTamCol[7]
		AADD(aColProd, {nAux, nAux + aTamCol[8]}) // "QUANT."
		nAux += aTamCol[8]
		AADD(aColProd, {nAux, nAux + aTamCol[9]}) // "V.UNITARIO"
		nAux += aTamCol[9]
		AADD(aColProd, {nAux, nAux + aTamCol[10]}) // "DESC %"
		//nAux += aTamCol[10]
		//AADD(aColProd, {nAux, nAux + aTamCol[10]}) // "VLR DESC"
		nAux += aTamCol[10]
		AADD(aColProd, {nAux, nAux + aTamCol[11]}) // "V.UNI LIQ"
		nAux += aTamCol[11]
		AADD(aColProd, {nAux, nAux + aTamCol[12]}) // "TOT.DESC"
		nAux += aTamCol[12]
		AADD(aColProd, {nAux, nAux + aTamCol[13]}) // "TOTAL LIQ"
		nAux += aTamCol[13]
		AADD(aColProd, {nAux, nAux + aTamCol[14]}) // "BASE ICMS"
		nAux += aTamCol[14]
		AADD(aColProd, {nAux, nAux + aTamCol[15]}) // "VLR ICMS"
		nAux += aTamCol[15]
		AADD(aColProd, {nAux, nAux + aTamCol[16]}) // "VALOR IPI"
		nAux += aTamCol[16]
		AADD(aColProd, {nAux, nAux + aTamCol[17]}) // "ICMS"
		nAux += aTamCol[17]
		AADD(aColProd, {nAux, nAux + aTamCol[18]}) // "IPI"
	    
		oDanfe:Box(nLine+454,nBaseCol+31,nLine+675,MAXBOXH+70)	                                  

		nAux := nBaseCol + 30
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[1])
		oDanfe:Say(nLine+462, nAux + 2,"COD. PROD", oFont08N:oFont)
		nAux += aTamCol[1]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[2])
		oDanfe:Say(nLine+462, nAux + 2,"DESCR PROD", oFont08N:oFont)
		nAux += aTamCol[2]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[3])
		oDanfe:Say(nLine+462, nAux + 2,"QTD.CAIXA", oFont08N:oFont)
		nAux += aTamCol[3]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[4])
		oDanfe:Say(nLine+462, nAux + 2,"NCM/SH", oFont08N:oFont)
		If cMVCODREG == "1"
			oDanfe:Say(nLine+462, nAux + 2,"CSOSN", oFont08N:oFont)
		Else
			oDanfe:Say(nLine+462, nAux + 2,"CST", oFont08N:oFont)
		Endif
		nAux += aTamCol[4]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[5])
		oDanfe:Say(nLine+462, nAux + 2,"CST", oFont08N:oFont)
		nAux += aTamCol[5]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[6])
		oDanfe:Say(nLine+462, nAux + 2,"CFOP", oFont08N:oFont)
		nAux += aTamCol[6]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[7])
		oDanfe:Say(nLine+462, nAux + 2,"UN", oFont08N:oFont)
		nAux += aTamCol[7]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[8])
		oDanfe:Say(nLine+462, nAux + 2,"QUANT.", oFont08N:oFont)
		nAux += aTamCol[8]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[9])
		oDanfe:Say(nLine+462, nAux + 2,"V.UNITARIO", oFont08N:oFont)
		nAux += aTamCol[9]
		//oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[10])
		//oDanfe:Say(nLine+462, nAux + 2,"DESC", oFont08N:oFont)
		//nAux += aTamCol[10]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[10])
		oDanfe:Say(nLine+462, nAux + 2,"DESC %", oFont08N:oFont)
		nAux += aTamCol[10]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[11])
		oDanfe:Say(nLine+462, nAux + 2,"V.UNI LIQ", oFont08N:oFont)
		nAux += aTamCol[11]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[12])
		oDanfe:Say(nLine+462, nAux + 2,"TOT.DESC", oFont08N:oFont)
		nAux += aTamCol[12]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[13])
		oDanfe:Say(nLine+462, nAux + 2,"TOTAL LIQ", oFont08N:oFont)
		nAux += aTamCol[13]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[14])
		oDanfe:Say(nLine+462, nAux + 2,"BASE ICMS", oFont08N:oFont)
		nAux  += aTamCol[14]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[15])
		oDanfe:Say(nLine+462, nAux + 2,"VLR ICMS", oFont08N:oFont)
		nAux  += aTamCol[15]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[16])
		oDanfe:Say(nLine+462, nAux + 2,"VALOR IPI", oFont08N:oFont)
		nAux  += aTamCol[16]
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[17])
		oDanfe:Say(nLine+462, nAux + 2,"ICMS", oFont08N:oFont)
		nAux += aTamCol[17]
		nAux2 := nAux
		oDanfe:Box(nLine+454, nAux, nLine+469, nAux + aTamCol[18])
		oDanfe:Say(nLine+462, nAux + 2,"IPI", oFont08N:oFont)
		nAux += aTamCol[18]
				
		For Nx :=1 to Len(aColProd)
			oDanfe:Box(nLine+469,aColProd[nx][1],MAXBOXV,aColProd[nx][2])	
		Next
		nLine -= 257	
		
	EndIf	

EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ DanfeInfC ³ Autor ³ Roberto Souza        ³ Data ³ 13/08/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do Box de Informações complementares.            ³±±
±±³			 ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FAT/FIS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function DanfeInfC(oDanfe,aMensagem,nBaseTxt,nBaseCol,nLine,nPosMsg, nFolha,lComplemento )

local cLogoTotvs := "Powered_by_TOTVS.bmp"
local cStartPath := GetSrvProfString("Startpath","")
Local Nx:= 0
Local Nw:= 0
local nPosAdicionais := 0
default lComplemento := .F.
oBrush := TBrush():New( , CLR_BLACK )

If nFolha ==1

	nBaseTxt -= 30 
	//oDanfe:Box(nLine+597,nBaseCol,MAXBOXV,nBaseCol+30)
	oDanfe:FillRect({nLine+598+nAjustaDad,nBaseCol,MAXBOXV-1,nBaseCol+30},oBrush)
	oBrush:End()
	
	oDanfe:Say(MAXBOXV-25,nBaseTxt+1,"DADOS",oFont08N:oFont, , CLR_WHITE, 270 )
	oDanfe:Say(MAXBOXV-13,nBaseTxt+11,"ADICIONAIS"    ,oFont08N:oFont, ,CLR_WHITE , 270 )
	nBaseTxt += 30 
	
	oDanfe:Box(nLine+597+nAjustaDad,nBaseCol+30,MAXBOXV,622)
	oDanfe:Say(nLine+606+nAjustaDad,nBaseTxt,"INFORMAÇÕES COMPLEMENTARES",oFont08N:oFont)
	
	
	nLenMensagens:= Len(aMensagem)
	nLin:= nLine+618+nAjustaDad
	
	For nX := 1 To Min(nLenMensagens, MAXMSG)
		oDanfe:Say(nLin,nBaseTxt,aMensagem[nX],oFont07:oFont)
		nLin:= nLin+10
	Next nX
	
	If Nx <= nLenMensagens 
		nPosMsg := Nx
	EndIf 
	
	oDanfe:Box(nLine+597+nAjustaDad,622,MAXBOXV,MAXBOXH+70)
	oDanfe:Say(nLine+606+nAjustaDad,632,"RESERVADO AO FISCO",oFont08N:oFont)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Logotipo Rodape
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ												
	if file(cLogoTotvs) .or. Resource2File ( cLogoTotvs, cStartPath+cLogoTotvs )
		oDanfe:SayBitmap(MAXBOXV+1,752,cLogoTotvs,120,20)
	endif	
	nLenMensagens:= Len(aResFisco)
	nLin:= nLine+618   
	For nX := 1 To Min(nLenMensagens, MAXMSG)
  		oDanfe:Say(nLin,632,aResFisco[nX],oFont08:oFont)
  		nLin:= nLin+10
	Next

ElseIf nFolha == 2

	if lComplemento
		nLine -= 208
		nBaseTxt +=30 
		nPosAdicionais := MAXBOXV-239 
	else	
		nLine :=  0
		nPosAdicionais := MAXBOXV-25
	endif	
	
	nBaseTxt -= 30 
	oDanfe:Box(nLine+597,nBaseCol,MAXBOXV,nBaseCol+30)
	oDanfe:FillRect({nLine+398,nBaseCol,MAXBOXV-1,nBaseCol+30},oBrush)
	oBrush:End()
	
	oDanfe:Say(nPosAdicionais,nBaseTxt+1,"DADOS",oFont08N:oFont, ,CLR_WHITE,270)
	oDanfe:Say(nPosAdicionais+12,nBaseTxt+11,"ADICIONAIS"    ,oFont08N:oFont, ,CLR_WHITE , 270 )
	nBaseTxt += 30 
	
	oDanfe:Box(nLine+397,nBaseCol+30,MAXBOXV,622)
	if lComplemento
		nBaseTxt += 30
	endif
	oDanfe:Say(nLine+406,nBaseTxt,"INFORMAÇÕES COMPLEMENTARES",oFont08N:oFont)
	
	
	nLenMensagens:= Len(aMensagem)
	nLin:= nLine+416
	
	For nX := nPosMsg To nLenMensagens
		oDanfe:Say(nLin,nBaseTxt,aMensagem[nX],oFont07:oFont)
		nLin:= nLin+10
		Nw++
		If Nw >= MAXMSG2
			Exit
		EndIf	
	Next nX
	
	nPosMsg := 0
	
	oDanfe:Box(nLine+397,622,MAXBOXV,MAXBOXH+70)
	oDanfe:Say(nLine+406,632,"RESERVADO AO FISCO",oFont08N:oFont)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Logotipo Rodape
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ												
	if file(cLogoTotvs) .or. Resource2File ( cLogoTotvs, cStartPath+cLogoTotvs )
		oDanfe:SayBitmap(MAXBOXV+1,752,cLogoTotvs,120,20)
	endif	
EndIf	
Return() 

 /*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DANFE     ºAutor  ³Fabio Santana	     º Data ³  04/10/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Converte caracteres espceiais						          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/

STATIC FUNCTION NoChar(cString,lConverte) 

Default lConverte := .F.

If lConverte
	cString := (StrTran(cString,"&lt;","<"))  
	cString := (StrTran(cString,"&gt;",">"))
	cString := (StrTran(cString,"&amp;","&"))
	cString := (StrTran(cString,"&quot;",'"'))
	cString := (StrTran(cString,"&#39;","'"))
EndIf	
		
Return(cString)	


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DANFEIII  ºAutor  ³Microsiga           º Data ³  12/17/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION MaxCod(cString,nTamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Tratamento para saber quantos caracteres irão caber na linha ³
//³ visto que letras ocupam mais espaço do que os números.      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local nMax	:= 0
Local nY   	:= 0
Default nTamanho := 40

For nMax := 1 to Len(cString)
	If IsAlpha(SubStr(cString,nMax,1)) .And. SubStr(cString,nMax,1) $ "MOQW"  // Caracteres que ocupam mais espaço em pixels
		nY += 7
	Else
		nY += 5
	EndIf
	
	If nY > nTamanho   // é o máximo de espaço para uma coluna
		nMax--
		Exit		
	EndIf
Next

Return nMax

//-----------------------------------------------------------------------
/*/{Protheus.doc} RetTamCol
Retorna um array do mesmo tamanho do array de entrada, contendo as
medidas dos maiores textos para cálculo de colunas.

@author Marcos Taranta
@since 24/05/2011
@version 1.0 

@param  aCabec     Array contendo as strings de cabeçalho das colunas
        aValores   Array contendo os valores que serão populados nas
                   colunas.
        oPrinter   Objeto de impressão instanciado para utilizar o método
                   nativo de cálculo de tamanho de texto.
        oFontCabec Objeto da fonte que será utilizada no cabeçalho.
        oFont      Objeto da fonte que será utilizada na impressão.

@return aTamCol  Array contendo os tamanhos das colunas baseados nos
                 valores.
/*/
//-----------------------------------------------------------------------
Static Function RetTamCol(aCabec, aValores, oPrinter, oFontCabec, oFont)
	
	Local aTamCol    := {}
	Local nAux       := 0

	Local nX         := 0
	Local nY         := 0
	Local oFontSize  := FWFontSize():new()
	
	if !oPrinter:lInJob
		For nX := 1 To Len(aCabec)
			
			AADD(aTamCol, {})
			//aTamCol[nX] := Round(oPrinter:GetTextWidth(aCabec[nX], oFontCabec) * nConsNeg + 2, 0)
			
			If !IsBlind()
				aTamCol[nX] := oFontSize:getTextWidth( alltrim(aCabec[nX]), oFontCabec:Name, oFontCabec:nWidth, oFontCabec:Bold, oFontCabec:Italic )
			Else
				aTamCol[nX] := MyCalcTam(aCabec[nX],1)
			EndIf
			
		Next nX
		
		For nX := 1 To Len(aValores[1])
			
			nAux := 0
			
			For nY := 1 To Len(aValores[1][nX])
				
				If Iif(!IsBlind(),(oPrinter:GetTextWidth(aValores[1][nX][nY], oFont) * nConsTex + 2) > nAux,(MyCalcTam(aValores[1][nX][nY],2) * nConsTex + 2) > nAux) 
				
					//nAux := Round(oPrinter:GetTextWidth(aValores[1][nX][nY], oFont) * nConsTex + 2, 0)
					
					If !IsBlind()
						nAux := oFontSize:getTextWidth( Alltrim(aValores[1][nX][nY]), oFontCabec:Name, oFontCabec:nWidth, oFontCabec:Bold, oFontCabec:Italic ) + 4
					Else
						nAux := MyCalcTam(aValores[1][nX][nY],1) + 4
					EndIf
				EndIf
				
			Next nY
			
			If aTamCol[nX] < nAux
				aTamCol[nX] := nAux
			EndIf
			
		Next nX
	else
		aTamCol := {45, 69, 39, 19, 23, 19, 33, 49, 46, 40, 41, 45, 39, 46,40,51,42,34,30}
	endif
	// Workaround para o método FWMSPrinter:GetTextWidth() na coluna UN
	aTamCol[6] += 5
	
	// Checa se os campos completam a página, senão joga o resto na coluna da
	//   descrição de produtos/serviços
	/*nAux := 0
	For nX := 1 To Len(aTamCol)
		
		nAux += aTamCol[nX]
		
	Next nX
	*/
	/*If nAux < MAXBOXH
		aTamCol[2] += MAXBOXH - 30 - nAux
	EndIf
   	If nAux > MAXBOXH               
		aTamCol[2] -= nAux - MAXBOXH - 30
	EndIf*/

Return aTamCol

//-----------------------------------------------------------------------
/*/{Protheus.doc} RetTamTex
Retorna o tamanho em pixels de uma string. (Workaround para o GetTextWidth)

@author Marcos Taranta
@since 24/05/2011
@version 1.0 

@param  cTexto   Texto a ser medido.
        oFont    Objeto instanciado da fonte a ser utilizada.
        oPrinter Objeto de impressão instanciado.

@return nTamanho Tamanho em pixels da string.
/*/
//-----------------------------------------------------------------------
Static Function RetTamTex(cTexto, oFont, oPrinter)
	
	Local nTamanho := 0
	//Local oFontSize:= FWFontSize():new()
	Local cAux := ""
		
	Local cValor := "0123456789"
	Local cVirgPonto := ",."
	Local cPerc := "%"	
	Local nX := 0
	
	//nTamanho := oPrinter:GetTextWidth(cTexto, oFont)
	//nTamanho := oFontSize:getTextWidth( cTexto, oFont:Name, oFont:nWidth, oFont:Bold, oFont:Italic )
	/*O calculo abaixo é o mesmo realizado pela oFontSize:getTextWidth
	Retorna 5 para numeros (0123456789), 2 para virgula e ponto (, .) e 7 para percentual (%)
	O ajuste foi realizado para diminuir o tempo na impressão de um danfe com muitos itens*/
	For nX:= 1 to len(cTexto)
		cAux:= Substr(cTexto,nX,1)
		If cAux $ cValor
			nTamanho += 5
		ElseIf cAux $ cVirgPonto
			nTamanho += 2
		ElseIf cAux $ cPerc
			nTamanho += 7
		EndIf		
	Next nX
	
	nTamanho := Round(nTamanho, 0)
	
Return nTamanho

//-----------------------------------------------------------------------
/*/{Protheus.doc} PosQuebrVal
Retorna a posição onde um valor deve ser quebrado

@author Marcos Taranta
@since 27/05/2011
@version 1.0 

@param  cTexto Texto a ser medido.

@return nPos   Posição aonde o valor deve ser quebrado.
/*/
//-----------------------------------------------------------------------
Static Function PosQuebrVal(cTexto)
	
	Local nPos := 0
	
	If Empty(cTexto)
		Return 0
	EndIf
	
	If Len(cTexto) <= MAXVALORC
		Return Len(cTexto)
	EndIf
	
	If SubStr(cTexto, MAXVALORC, 1) $ ",."
		nPos := MAXVALORC - 2
	Else
		nPos := MAXVALORC
	EndIf
	
Return nPos

//-----------------------------------------------------------------------
/*/{Protheus.doc} MontaEnd
Retorna o endereço completo do cliente (Logradouro + Número + Complemento)

@author Renan Franco
@since 11/07/2019
@version 1.0

@param  oMontaEnd	 Objeto que possui _xLgr, _xcpl e _xNRO.

@return cEndereco   Endereço concatenado. Ex.: AV BRAZ LEME, 1000, SÊNECA MALL
/*/
//-----------------------------------------------------------------------
Static Function MontaEnd(oMontaEnd)

	Local lConverte		:= GetNewPar("MV_CONVERT",.F.)
	Local cEndereco		:= ""

	Default oMontaEnd	:= Nil

	Private oEnd		:= oMontaEnd
	
	if  oEnd <> Nil .and. ValType(oEnd)=="O"

		cEndereco := NoChar(oEnd:_Xlgr:Text,lConverte) 
	
		If  " SN" $ (UPPER (oEnd:_Xlgr:Text)) .Or. ",SN" $ (UPPER (oEnd:_Xlgr:Text)) .Or. "S/N" $ (UPPER (oEnd:_Xlgr:Text))
            cEndereco += IIf(type("oEnd:_xcpl") == "O", ", " + NoChar(oEnd:_xcpl:Text,lConverte), " ")
		Else
            cEndereco += ", " + NoChar(oEnd:_NRO:Text,lConverte) + IIf(type("oEnd:_xcpl") == "O", ", " + NoChar(oEnd:_xcpl:Text,lConverte), " ")
		Endif

	Endif	

Return cEndereco

//-----------------------------------------------------------------------
/*/{Protheus.doc} executeRetorna
Executa o retorna de notas

@author Henrique Brugugnoli
@since 17/01/2013
@version 1.0 

@param  cID ID da nota que sera retornado

@return aRetorno   Array com os dados da nota
/*/
//-----------------------------------------------------------------------
static function executeRetorna( aNfe, cIdEnt, lUsacolab, lAutomato)

Local aExecute		:= {}  
Local aFalta		:= {}
Local aResposta		:= {}
Local aRetorno		:= {}
Local aDados		:= {} 
Local aIdNfe		:= {}
Local cAviso		:= "" 
Local cDHRecbto		:= ""
Local cDtHrRec		:= ""
Local cDtHrRec1		:= ""
Local cErro			:= "" 
Local cModTrans		:= ""
Local cProtDPEC		:= ""
Local cProtocolo	:= ""
Local cRetDPEC		:= ""
Local cRetorno		:= ""
Local cCodRetNFE	:= ""
Local cMsgNFE		:=	""
Local cURL			:= PadR(GetNewPar("MV_SPEDURL","http://localhost:8080/sped"),250)
Local cModel		:= "55"
Local dDtRecib		:= CToD("")
Local lFlag			:= .T.
Local nDtHrRec1		:= 0
Local nL			:= 0
Local nX			:= 0
Local nY			:= 0
Local nZ			:= 1
Local nCount		:= 0
Local nLenNFe
Local nLenWS
Local oWS
local cMsgRet		:= ""

Private oDHRecbto
Private oNFeRet
Private oDoc

default lUsacolab	:= .F.
default lAutomato	:= .F.
aAdd(aIdNfe,aNfe)

if !lUsacolab

	oWS:= WSNFeSBRA():New()
	oWS:cUSERTOKEN        := "TOTVS"
	oWS:cID_ENT           := cIdEnt
	oWS:nDIASPARAEXCLUSAO := 0
	oWS:_URL 			  := AllTrim(cURL)+"/NFeSBRA.apw"
	oWS:oWSNFEID          := NFESBRA_NFES2():New()
	oWS:oWSNFEID:oWSNotas := NFESBRA_ARRAYOFNFESID2():New()  
	
	aadd(aRetorno,{"","",aIdNfe[nZ][4]+aIdNfe[nZ][5],"","","",CToD(""),"","","",""})
	
	aadd(oWS:oWSNFEID:oWSNotas:oWSNFESID2,NFESBRA_NFESID2():New())
	Atail(oWS:oWSNFEID:oWSNotas:oWSNFESID2):cID := aIdNfe[nZ][4]+aIdNfe[nZ][5]
	
	If lAutomato .or. oWS:RETORNANOTASNX()

		if lAutomato
			if FindFunction("getParAuto")
				aRetAuto := GetParAuto("AUTONFETestCase")
				oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS := NFESBRA_ARRAYOFNFES5():New()
				aAdd( oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5, NFESBRA_NFES5():New() ) 
				oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[1]:CID := aRetAuto[01]
				oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[1]:oWSNFE := NFESBRA_NFEPROTOCOLO():New()
				oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[1]:oWSNFE:CPROTOCOLO := aRetAuto[02]
				oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[1]:oWSNFE:CXML := aRetAuto[03]
				oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[1]:oWSNFE:CXMLPROT := aRetAuto[04]
			endif
		endif

		If Len(oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5) > 0
			For nX := 1 To Len(oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5)
				cRetorno        := oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSNFE:CXML
				cProtocolo      := oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSNFE:CPROTOCOLO								
				cDHRecbto  		:= oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSNFE:CXMLPROT
				oNFeRet			:= XmlParser(cRetorno,"_",@cAviso,@cErro)
				cModTrans		  := IIf(ValAtrib("oNFeRet:_NFE:_INFNFE:_IDE:_TPEMIS:TEXT") <> "U",IIf (!Empty("oNFeRet:_NFE:_INFNFE:_IDE:_TPEMIS:TEXT"),oNFeRet:_NFE:_INFNFE:_IDE:_TPEMIS:TEXT,1),1)
				If ValType(oWs:OWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:OWSDPEC)=="O"
					cRetDPEC        := oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSDPEC:CXML
					cProtDPEC       := oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSDPEC:CPROTOCOLO
				EndIf
				
	
				//Tratamento para gravar a hora da transmissao da NFe
				If !Empty(cProtocolo)
					oDHRecbto		:= XmlParser(cDHRecbto,"","","")
					cDtHrRec		:= IIf(ValAtrib("oDHRecbto:_ProtNFE:_INFPROT:_DHRECBTO:TEXT")<>"U",oDHRecbto:_ProtNFE:_INFPROT:_DHRECBTO:TEXT,"")
					nDtHrRec1		:= RAT("T",cDtHrRec)
					cMsgRet 		:= IIf(ValAtrib("oDHRecbto:_ProtNFE:_INFPROT:_XMSG:TEXT")<>"U",oDHRecbto:_ProtNFE:_INFPROT:_XMSG:TEXT,"")
					If nDtHrRec1 <> 0
						cDtHrRec1   :=	SubStr(cDtHrRec,nDtHrRec1+1)
						dDtRecib	:=	SToD(StrTran(SubStr(cDtHrRec,1,AT("T",cDtHrRec)-1),"-",""))
					EndIf
					
					AtuSF2Hora(cDtHrRec1,aIdNFe[nZ][5]+aIdNFe[nZ][4]+aIdNFe[nZ][6]+aIdNFe[nZ][7])
					
				EndIf
	
				nY := aScan(aIdNfe,{|x| x[4]+x[5] == SubStr(oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:CID,1,Len(x[4]+x[5]))})
	
				oWS:cIdInicial    := aIdNfe[nZ][4]+aIdNfe[nZ][5]
				oWS:cIdFinal      := aIdNfe[nZ][4]+aIdNfe[nZ][5]
				if lAutomato
					cCodRetNFE := aRetAuto[05]
					cMsgNFE := aRetAuto[06]
				else
					If oWS:MONITORFAIXA()
						cCodRetNFE := oWS:oWsMonitorFaixaResult:OWSMONITORNFE[1]:OWSERRO:OWSLOTENFE[len(oWS:oWsMonitorFaixaResult:OWSMONITORNFE[1]:OWSERRO:OWSLOTENFE)]:CCODRETNFE
						cMsgNFE	:= oWS:oWsMonitorFaixaResult:OWSMONITORNFE[1]:OWSERRO:OWSLOTENFE[len(oWS:oWsMonitorFaixaResult:OWSMONITORNFE[1]:OWSERRO:OWSLOTENFE)]:CMSGRETNFE
					EndIf
				endif
	
				If nY > 0
					aRetorno[nY][1] := cProtocolo
					aRetorno[nY][2] := cRetorno
					aRetorno[nY][4] := cRetDPEC
					aRetorno[nY][5] := cProtDPEC
					aRetorno[nY][6] := cDtHrRec1
					aRetorno[nY][7] := dDtRecib
					aRetorno[nY][8] := cModTrans
					aRetorno[nY][9] := cCodRetNFE
					aRetorno[nY][10]:= cMsgNFE
					aRetorno[nY][11]:= cMsgRet
					
					//aadd(aResposta,aIdNfe[nY])
				EndIf
				cRetDPEC := ""
				cProtDPEC:= ""
			Next nX
			/*For nX := 1 To Len(aIdNfe)
				If aScan(aResposta,{|x| x[4] == aIdNfe[nX,04] .And. x[5] == aIdNfe[nX,05] })==0
				
					conout("Falta")
					conout(aIdNfe[nX][4]+" - "+aIdNfe[nX][5])
					aadd(aFalta,aIdNfe[nX])
				EndIf
			Next nX
			If Len(aFalta)>0
				aExecute := GetXML(cIdEnt,aFalta,@cModalidade)
			Else
				aExecute := {}
			EndIf*/
			/*For nX := 1 To Len(aExecute)
				nY := aScan(aRetorno,{|x| x[3] == aExecute[nX][03]})
				If nY == 0
					aadd(aRetorno,{aExecute[nX][01],aExecute[nX][02],aExecute[nX][03]})
				Else
					aRetorno[nY][01] := aExecute[nX][01]
					aRetorno[nY][02] := aExecute[nX][02]
				EndIf
			Next nX*/
		EndIf
	Else
		if !lAutomato
			Aviso("DANFE",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{"OK"},3)
		endif
	EndIf 
else
	oDoc 			:= ColaboracaoDocumentos():new()		
	oDoc:cModelo	:= "NFE"
	oDoc:cTipoMov	:= "1"									
	oDoc:cIDERP	:= aIdNfe[nZ][4]+aIdNfe[nZ][5]+FwGrpCompany()+FwCodFil()
	
	aadd(aRetorno,{"","",aIdNfe[nZ][4]+aIdNfe[nZ][5],"","","",CToD(""),"","",""})
	
	if odoc:consultar()
		aDados := ColDadosNf(1)
		
		if !Empty(oDoc:cXMLRet)
			cRetorno	:= oDoc:cXMLRet 
		else
			cRetorno	:= oDoc:cXml
		endif
		
		aDadosXml := ColDadosXMl(cRetorno, aDados, @cErro, @cAviso)
		if '<obsCont xCampo="nRegDPEC">' $ cRetorno
			aDadosXml[9] := SubStr(cRetorno,At('<obsCont xCampo="nRegDPEC"><xTexto>',cRetorno)+35,15)
		endif	
		
		cProtocolo		:= aDadosXml[3]		
		cModTrans		:= IIF(Empty(aDadosXml[5]),aDadosXml[7],aDadosXml[5])
		cCodRetNFE	:= aDadosXml[1]
		cMsgNFE 	:= aDadosXml[2]			
		
		//Dados do DEPEC
		If !Empty( aDadosXml[9] )
			cRetDPEC        := cRetorno
			cProtDPEC       := aDadosXml[9] 
		EndIf
		
		//Tratamento para gravar a hora da transmissao da NFe
		If !Empty(cProtocolo)
			cDtHrRec		:= aDadosXml[4]
			nDtHrRec1		:= RAT("T",cDtHrRec)
			
			If nDtHrRec1 <> 0
				cDtHrRec1   :=	SubStr(cDtHrRec,nDtHrRec1+1)
				dDtRecib	:=	SToD(StrTran(SubStr(cDtHrRec,1,AT("T",cDtHrRec)-1),"-",""))
			EndIf
			
			AtuSF2Hora(cDtHrRec1,aIdNFe[nZ][5]+aIdNFe[nZ][4]+aIdNFe[nZ][6]+aIdNFe[nZ][7])
			
		EndIf
		//Altero o cRetorno para o XML padrão que foi enviado.
		cRetorno := oDoc:cXml

		aRetorno[1][1] := cProtocolo
		aRetorno[1][2] := cRetorno
		aRetorno[1][4] := cRetDPEC
		aRetorno[1][5] := cProtDPEC
		aRetorno[1][6] := cDtHrRec1
		aRetorno[1][7] := dDtRecib
		aRetorno[1][8] := cModTrans
		aRetorno[1][9] := cCodRetNFE
		aRetorno[1][10]:= cMsgNFE
								
		cRetDPEC := ""
		cProtDPEC:= ""		
				
	endif
endif

oWS       := Nil
oDHRecbto := Nil
oNFeRet   := Nil

return aRetorno[len(aRetorno)]

static function getXMLColab(aIdNFe,cModalidade,lUsaColab, lAutomato)

local nZ			:= 0
local nCount		:= 0

local cIdEnt 		:= "000000"

local aDados		:= {}
local aRetorno	:= {}

default lAutomato := .F.

If Empty(cModalidade)
	cModalidade := ColGetPar( "MV_MODALID", "1" )	
EndIf  
         

For nZ := 1 To len(aIdNfe) 

	nCount++

	aDados := executeRetorna( aIdNfe[nZ], cIdEnt, lUsaColab, lAutomato )
	
	if ( nCount == 10 )
		delClassIntF()
		nCount := 0
	endif
	
	aAdd(aRetorno,aDados)
	
Next nZ

Return(aRetorno)

static function atuSf2Hora( cDtHrRec,cSeek )

local aArea := GetArea()
 
dbSelectArea("SF2")
dbSetOrder(1)
If MsSeek(xFilial("SF2")+cSeek)
	If SF2->(FieldPos("F2_HORA"))<>0 .And. ( Empty(SF2->F2_HORA) .Or. SF2->F2_HORA <> cDtHrRec )
		RecLock("SF2")
		SF2->F2_HORA := cDtHrRec
		MsUnlock()
	EndIf
EndIf
dbSelectArea("SF1")
dbSetOrder(1)
If MsSeek(xFilial("SF1")+cSeek)
	If SF1->(FieldPos("F1_HORA"))<>0 .And. ( Empty(SF1->F1_HORA) .Or. SF1->F1_HORA <> cDtHrRec )
		RecLock("SF1")
		SF1->F1_HORA := cDtHrRec
		MsUnlock()
	EndIf
EndIf

RestArea(aArea)

return nil

//-----------------------------------------------------------------------
/*/{Protheus.doc} ColDadosNf
Devolve os dados com a informação desejada conforme parâmetro nInf.
 
@author 	Rafel Iaquinto
@since 		30/07/2014
@version 	11.9
 
@param	nInf, inteiro, Codigo da informação desejada:<br>1 - Normal<br>2 - Cancelametno<br>3 - Inutilização						

@return aRetorno Array com as posições do XML desejado, sempre deve retornar a mesma quantidade de posições.
/*/
//-----------------------------------------------------------------------
static function ColDadosNf(nInf)

local aDados	:= {}

	do case
		case nInf == 1
			//Informaçoes da NF-e
			aadd(aDados,"NFEPROC|PROTNFE|INFPROT|CSTAT") //1 - Codigo Status documento 
			aadd(aDados,"NFEPROC|PROTNFE|INFPROT|XMOTIVO") //2 - Motivo do status
			aadd(aDados,"NFEPROC|PROTNFE|INFPROT|NPROT")	//3 - Protocolo Autporizacao		
			aadd(aDados,"NFEPROC|PROTNFE|INFPROT|DHRECBTO")	//4 - Data e hora de recebimento					
			aadd(aDados,"NFEPROC|NFE|INFNFE|IDE|TPEMIS") //5 - Tipo de Emissao
			aadd(aDados,"NFEPROC|NFE|INFNFE|IDE|TPAMB") //6 - Ambiente de transmissão		
			aadd(aDados,"NFE|INFNFE|IDE|TPEMIS") //7 - Tipo de Emissao - Caso nao tenha retorno
			aadd(aDados,"NFE|INFNFE|IDE|TPAMB") //8 - Ambiente de transmissão -  Caso nao tenha retorno			
			aadd(aDados,"NFEPROC|RETDEPEC|INFDPECREG|NREGDPEC") //9 - Numero de autorização DPEC
			aadd(aDados,"NFEPROC|PROTNFE|INFPROT|CHNFE") //10 - Chave da autorizacao
		
		case nInf == 2	
			//Informacoes do cancelamento - evento
			aadd(aDados,"PROCEVENTONFE|RETEVENTO|INFEVENTO|CSTAT") //1 - Codigo Status documento 
			aadd(aDados,"PROCEVENTONFE|RETEVENTO|INFEVENTO|XMOTIVO") //2 - Motivo do status
			aadd(aDados,"PROCEVENTONFE|RETEVENTO|INFEVENTO|NPROT")	//3 - Protocolo Autporizacao		
			aadd(aDados,"PROCEVENTONFE|RETEVENTO|INFEVENTO|DHREGEVENTO")	//4 - Data e hora de recebimento					
			aadd(aDados,"") //5 - Tipo de Emissao
			aadd(aDados,"PROCEVENTONFE|RETEVENTO|INFEVENTO|TPAMB") //6 - Ambiente de transmissão		
			aadd(aDados,"") //7 - Tipo de Emissao - Caso nao tenha retorno
			aadd(aDados,"ENVEVENTO|EVENTO|INFEVENTO|TPAMB") //8 - Ambiente de transmissão -  Caso nao tenha retorno												
			aadd(aDados,"") //9 - Numero de autorização DPEC
			aadd(aDados,"") //10 - Chave da autorizacao
		
		case nInf == 3	
			//Informações da Inutilização
			aadd(aDados,"PROCINUTNFE|RETINUTNFE|INFINUT|CSTAT") //1 - Codigo Status documento 
			aadd(aDados,"PROCINUTNFE|RETINUTNFE|INFINUT|XMOTIVO") //2 - Motivo do status
			aadd(aDados,"PROCINUTNFE|RETINUTNFE|INFINUT|NPROT")	//3 - Protocolo Autporizacao		
			aadd(aDados,"PROCINUTNFE|RETINUTNFE|INFINUT|DHRECBTO")	//4 - Data e hora de recebimento					
			aadd(aDados,"") //5 - Tipo de Emissao
			aadd(aDados,"PROCINUTNFE|RETINUTNFE|INFINUT|TPAMB") //6 - Ambiente de transmissão		
			aadd(aDados,"") //7 - Tipo de Emissao - Caso nao tenha retorno
			aadd(aDados,"INUTNFE|INFINUT|TPAMB	") //8 - Ambiente de transmissão -  Caso nao tenha retorno												
			aadd(aDados,"") //9 - Numero de autorização DPEC
			aadd(aDados,"") //10 - Chave da autorizacao
	end
	
return(aDados)

static function UsaColaboracao(cModelo)
Local lUsa := .F.

If FindFunction("ColUsaColab")
	lUsa := ColUsaColab(cModelo)
endif
return (lUsa)


//-----------------------------------------------------------------------
/*/{Protheus.doc} DANFE_VI
Funcao utilizada para verificar a ultima versao do fonte DANFEIII.PRW aplicado no rpo do cliente, assim verificando
a necessidade de uma atualizacao neste fonte.
 
@author 	Eduardo Silva
@since 		25/08/2014
@version 	11.9
 
@param	Retornar a ultima data do RPO que esta no cliente. Pois o cliente não esta utilizando o DANFEII com isto esta 
		sendo informado a mensagem que o RdMake não está compilado. 						

@return nRet
/*/
//-----------------------------------------------------------------------

User Function DANFE_VI

Local nRet := 20140825 // 25 de Abril de 2014 # Eduardo Silva ## Cliente não tem o DANFEII compilado no RPO ajuste para não dar erro

Return nRet

/*/{Protheus.doc} ValAtrib
Função utilizada para substituir o type onde não seja possivél a sua retirada para não haver  
ocorrencia indevida pelo SonarQube.

@author 	valter Silva
@since 		09/01/2018
@version 	12
@return 	Nil
/*/
//-----------------------------------------------------------------------
static Function ValAtrib(atributo)
Return (type(atributo) )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ VERAMOSTRA     ºAutor  ³ Tiago Bizan        º Data ³  06/26/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica se algum produto da NF e de Amostra                     º±±
±±º          ³                                               	                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                 		                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VERAMOSTRA(cFil,cDoc,cSerie,cCli,cLoj)
	
	Local aAreaD2	:= SD2->(GetArea())
	Local aArea		:= GetArea()
	Local cB1RED10	:= U_MyNewSX6(	"CL_B1RED10",;
									"0006147",;
									"C",;
									"Produtos de Amostra",;
									".",;
									"",;
									.F. )
	Local llRet		:= .F.
	Local cChaveD2	:= cFil+cDoc+cSerie+cCli+cLoj 
	
	SD2->(dbSetOrder(3))
	SD2->(dbGoTop())
	
	If SD2->(DBSeek(cChaveD2))
    	While cChaveD2 == SD2->D2_FILIAL+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA  
			If ALLTRIM(SD2->D2_COD) $ ALLTRIM(cB1RED10)
				llRet := .T.
				Exit
			EndIF
				    
			SD2->(dbSkip())	
		EndDo
	EndIF
	    
	RestArea(aAreaD2)
	RestArea(aArea)
	
Return(llRet)





Static Function RetVolEx()
Local aAreaSav	:= GetArea()
Local aAreaSD2	:= SD2->( GetArea() )
Local aAreaSC5	:= SC5->( GetArea() )
Local nRetVol	:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Tipo do frete³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SD2")
dbSetOrder(3)
If MsSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA)

	dbSelectArea("SC5")
	dbSetOrder(1)
	If MsSeek(xFilial("SC5")+SD2->D2_PEDIDO)
		nRetVol := SC5->C5_YQTPLEX
	Endif

Endif
	
RestArea( aAreaSC5 )
RestArea( aAreaSD2 )
RestArea( aAreaSav )

Return nRetVol





Static Function  RetTipoNf()
Local aAreaSav	:= GetArea()
Local aAreaSA1	:= SA1->( GetArea() )
Local lRet		:= .F.

dbSelectArea( "SA1" )
SA1->( dbSetOrder( 1 ) )
If SA1->( dbSeek( xFilial("SA1") + SF2->(F2_CLIENTE+F2_LOJA) ) )
	If Alltrim(Upper( SA1->A1_EST )) == "EX"
		lRet := .T.
	Endif	
Endif

RestArea( aAreaSA1 )
RestArea( aAreaSav )

Return lRet


/*/{Protheus.doc} CriaSx1
//TODO Descrição auto-gerada.
@author william.souza
@since 15/05/2020
@version 1.0
@return ${return}, ${return_description}
@param cPerg, characters, descricao
@type function
/*/
Static Function CriaSx1( cPerg )

Local aAreaAtu	:= GetArea()
Local aAreaSX1	:= SX1->( GetArea() )
Local aTamSX3	:= {}
Local aHelp		:= {}

//
// NFSIGW
// MV_PAR01 - Da Nota Fiscal
// MV_PAR02 - Até a Nota Fiscal
// MV_PAR03 - Da Série
// MV_PAR04 - Tipo de Operação [1=NF Entrada, 2=NF Saida]
// MV_PAR05 - Impressão [1=Pré-Visualiza, 2=Imprimir]
// MV_PAR06 - Imprime Verso [1=Sim, 2=Não]
// MV_PAR07 - Estado de Envio 
// MV_PAR08 - Imprime boleto ?
// MV_PAR09 - Imprime minuta ?
// MV_PAR10 - Ordem de impressão ?
// MV_PAR11 - Da carga ?
// MV_PAR12 - Ate carga ?
// MV_PAR13 - Da sequencia ?
// MV_PAR14 - Ate a sequencia ?
// MV_PAR15 - Do cliente ?
// MV_PAR16 - Da loja ?
// MV_PAR17 - Até o cliente ?
// MV_PAR18 - Até a loja ?
// MV_PAR19 - Da emissão ?
// MV_PAR20 - Até a emissão ?
// MV_PAR21 - Quebra impressão ?
// MV_PAR22 - Imprime etiquetas ?
// MV_PAR23 - Apenas NF Venda?
// MV_PAR24 - Da Transportadora?
// MV_PAR25 - Ate a Transportadora?
// MV_PAR26 - Imprime Roteiro de Entregas?
// MV_PAR27 - Imprime Resumo de Canhotos ?

aAdd(aHelp,{ "Nota Fiscal Inicial      		", "", "", {"Informe o número da nota fiscal       ", "inicial a ser considerada no filtro.  ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Nota Fiscal Final        		", "", "", {"Informe o número da nota fiscal       ", "final a ser considerada no filtro.    ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Série Nota Fiscal         	", "", "", {"Informe a série da nota fiscal a ser  ", "considerada no filtro.                ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Tipo de Operação          	", "", "", {"Informe o tipo de nota fiscal a ser   ", "impresso [Entrada ou Saída].          ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Impressão                 	", "", "", {"Informe se deverá ser feito a         ", "visualização da nota ou impressa      ", "diretamente."                           },{""},{""} })
aAdd(aHelp,{ "Imprime Verso             	", "", "", {"Informe se será utilizado a impressão ", "no verso da nota fiscal.              ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Estado de Envio/Zona?     	", "", "", {"Informe o estado de envio a ser       ", "considerado no filtro.                ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Imprime Boleto?    			", "", "", {"Informe se o boleto deve ser impresso ", "logo após a DANFE.                    ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Imprime Minuta?    			", "", "", {"Informe se a minuta deve ser impresso ", "logo após a DANFE.                    ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Ordem de impressão?   		", "", "", {"Informe a ordem de impressão das DANFE", "S                                     ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Da carga?       				", "", "", {"Informe a carga inicial 			   ", "                                      ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Até a carga?       		 	", "", "", {"Informe a carga final   			   ", "                                      ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Da seq carga?       			", "", "", {"Informe a sequencia inicial 		   ", "                                      ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Até seq carga?    		   	", "", "", {"Informe a sequencia final   		   ", "                                      ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Do cliente?       			", "", "", {"Informe o cliente inicial   		   ", "                                      ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Da loja?       				", "", "", {"Informe a loja inicial   		   	   ", "                                      ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Até o cliente?    	   		", "", "", {"Informe o cliente final    		   ", "                                      ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Até a loja?       			", "", "", {"Informe a loja final   		   	   ", "                                      ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Da emissão?       			", "", "", {"Informe a emissão inicial      	   ", "                                      ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Até a emissão?       			", "", "", {"Informe a emissão final         	   ", "                                      ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Quebra impressão?       		", "", "", {"Informe se o arquivo de impressão deve", "rá ser quebrado por nota/carga        ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Imprime Etiquetas?       		", "", "", {"Informe se as etiqutas de separação de", "vem ser impressas na impressora térmic", "a"                                      },{""},{""} })
aAdd(aHelp,{ "Apenas NF Venda?       		", "", "", {"Informe se será impressa apenas NF de ", "venda                                 ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Da Transportadora?    		", "", "", {"Informe a transportadora inicial      ", "                                      ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Ate a Transportadora?   		", "", "", {"Informe a transportadora final        ", "                                      ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Imprime Roteiro de Entregas?  ", "", "", {"Informe se o roteiro de entregas deve ", "ser impresso                          ", ""                                       },{""},{""} })
aAdd(aHelp,{ "Imprime Resumo de Canhotos?   ", "", "", {"Informe se o resumo de canhotos deve  ", "ser impresso                          ", ""                                       },{""},{""} })

aTamSX3	:= TAMSX3( "F2_DOC" )
U_MYPUTSX1(	cPerg,	"01", aHelp[01,1],	aHelp[01,2], aHelp[01,3],	"mv_ch1",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","SF2",	"","S","mv_par01",""             ,"","",""			,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[01,4],aHelp[01,5],aHelp[01,6],"" )
U_MYPUTSX1(	cPerg,	"02", aHelp[02,1],	aHelp[02,2], aHelp[02,3],	"mv_ch2",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","SF2",	"","S","mv_par02",""             ,"","","zzzzzzzzz"	,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[02,4],aHelp[02,5],aHelp[02,6],"" )
aTamSX3	:= TAMSX3( "F2_SERIE" )
U_MYPUTSX1(	cPerg,	"03", aHelp[03,1],	aHelp[03,2], aHelp[03,3],	"mv_ch3",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","",		"","S","mv_par03",""             ,"","","zzz"		,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[03,4],aHelp[03,5],aHelp[03,6],"" )

U_MYPUTSX1(	cPerg,	"04", aHelp[04,1],	aHelp[04,2], aHelp[04,3],	"mv_ch4",   "N",		1,			0,			2, "C", "","",		"","S","mv_par04","Entrada"      ,"","",""			,"Saída"            ,""		,""	,""        ,"","",""           ,"","",""        ,"","",aHelp[04,4],aHelp[04,5],aHelp[04,6],"" )
U_MYPUTSX1(	cPerg,	"05", aHelp[05,1],	aHelp[05,2], aHelp[05,3],	"mv_ch5",   "N",		1,			0,			2, "C", "","",		"","S","mv_par05","Pré-Visualiza","","",""			,"Imprimir"         ,""		,""	,""        ,"","",""           ,"","",""        ,"","",aHelp[05,4],aHelp[05,5],aHelp[05,6],"" )
U_MYPUTSX1(	cPerg,	"06", aHelp[06,1],	aHelp[06,2], aHelp[06,3],	"mv_ch6",   "N",		1,			0,			2, "C", "","",		"","S","mv_par06","Sim"          ,"","",""			,"Não"              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[06,4],aHelp[06,5],aHelp[06,6],"" )
aTamSX3	:= TAMSX3( "A1_EST" )
U_MYPUTSX1(	cPerg,	"07", aHelp[07,1],	aHelp[07,2], aHelp[07,3],	"mv_ch7",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","",		"","S","mv_par07",""             ,"","","  "		,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[07,4],aHelp[07,5],aHelp[07,6],"" )
U_MYPUTSX1(	cPerg,	"08", aHelp[08,1],	aHelp[08,2], aHelp[08,3],	"mv_ch8",   "N",		1,			0,			2, "C", "","",		"","S","mv_par08","Sim"          ,"","",""			,"Não"              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[08,4],aHelp[08,5],aHelp[08,6],"" )
U_MYPUTSX1(	cPerg,	"09", aHelp[09,1],	aHelp[09,2], aHelp[09,3],	"mv_ch9",   "N",		1,			0,			2, "C", "","",		"","S","MV_PAR09","Sim"        ,"","",""			,"Não"              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[09,4],aHelp[09,5],aHelp[09,6],"" )
U_MYPUTSX1(	cPerg,	"10", aHelp[10,1],	aHelp[10,2], aHelp[10,3],	"mv_chA",   "N",		1,			0,			1, "C", "","",		"","S","MV_PAR10","Carga"        ,"","",""			,"Nota"              ,""			,"","Emissão"        ,"","",""           ,"","",""        ,"","",aHelp[10,4],aHelp[10,5],aHelp[10,6],"" )
aTamSX3	:= TAMSX3( "DAK_COD" )
U_MYPUTSX1(	cPerg,	"11", aHelp[11,1],	aHelp[11,2], aHelp[11,3],	"mv_chB",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","DAK",	"","S","mv_par11",""             ,"","","  "		,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[11,4],aHelp[11,5],aHelp[11,6],"" )
aTamSX3	:= TAMSX3( "DAK_COD" )
U_MYPUTSX1(	cPerg,	"12", aHelp[12,1],	aHelp[12,2], aHelp[12,3],	"mv_chC",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","DAK",	"","S","mv_par12",""             ,"","","  "		,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[12,4],aHelp[12,5],aHelp[12,6],"" )
aTamSX3	:= TAMSX3( "DAK_SEQCAR" )
U_MYPUTSX1(	cPerg,	"13", aHelp[13,1],	aHelp[13,2], aHelp[13,3],	"mv_chD",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","",		"","S","mv_par13",""             ,"","","  "		,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[13,4],aHelp[13,5],aHelp[13,6],"" )
aTamSX3	:= TAMSX3( "DAK_SEQCAR" )
U_MYPUTSX1(	cPerg,	"14", aHelp[14,1],	aHelp[14,2], aHelp[14,3],	"mv_chE",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","",		"","S","mv_par14",""             ,"","","  "		,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[14,4],aHelp[14,5],aHelp[14,6],"" )
aTamSX3	:= TAMSX3( "A1_COD" )
U_MYPUTSX1(	cPerg,	"15", aHelp[15,1],	aHelp[15,2], aHelp[15,3],	"mv_chF",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","SA1",	"","S","mv_par15",""             ,"","","  "		,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[15,4],aHelp[15,5],aHelp[15,6],"" )
aTamSX3	:= TAMSX3( "A1_LOJA" )
U_MYPUTSX1(	cPerg,	"16", aHelp[16,1],	aHelp[16,2], aHelp[16,3],	"mv_chG",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","",		"","S","mv_par16",""             ,"","","  "		,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[16,4],aHelp[16,5],aHelp[16,6],"" )
aTamSX3	:= TAMSX3( "A1_COD" )
U_MYPUTSX1(	cPerg,	"17", aHelp[17,1],	aHelp[17,2], aHelp[17,3],	"mv_chH",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","SA1",	"","S","mv_par17",""             ,"","","  "		,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[17,4],aHelp[17,5],aHelp[17,6],"" )
aTamSX3	:= TAMSX3( "A1_LOJA" )
U_MYPUTSX1(	cPerg,	"18", aHelp[18,1],	aHelp[18,2], aHelp[18,3],	"mv_chI",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","",		"","S","mv_par18",""             ,"","","  "		,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[18,4],aHelp[18,5],aHelp[18,6],"" )
aTamSX3	:= TAMSX3( "F3_EMISSAO" )
U_MYPUTSX1(	cPerg,	"19", aHelp[19,1],	aHelp[19,2], aHelp[19,3],	"mv_chJ",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","",		"","S","mv_par19",""             ,"","","  "		,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[19,4],aHelp[19,5],aHelp[19,6],"" )
aTamSX3	:= TAMSX3( "F3_EMISSAO" )
U_MYPUTSX1(	cPerg,	"20", aHelp[20,1],	aHelp[19,2], aHelp[20,3],	"mv_chK",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","",		"","S","mv_par20",""             ,"","","  "		,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[20,4],aHelp[20,5],aHelp[20,6],"" )
U_MYPUTSX1(	cPerg,	"21", aHelp[21,1],	aHelp[21,2], aHelp[21,3],	"mv_chL",   "N",		1,			0,			2, "C", "","",		"","S","mv_par21","Sim"          ,"","",""			,"Não"              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[21,4],aHelp[21,5],aHelp[21,6],"" )
U_MYPUTSX1(	cPerg,	"22", aHelp[22,1],	aHelp[22,2], aHelp[22,3],	"mv_chM",   "N",		1,			0,			2, "C", "","",		"","S","mv_par22","Sim"          ,"","",""			,"Não"              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[22,4],aHelp[22,5],aHelp[22,6],"" )
U_MYPUTSX1(	cPerg,	"23", aHelp[23,1],	aHelp[23,2], aHelp[23,3],	"mv_chN",   "N",		1,			0,			2, "C", "","",		"","S","mv_par23","Sim"          ,"","",""			,"Não"              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[23,4],aHelp[23,5],aHelp[23,6],"" )
aTamSX3	:= TAMSX3( "F2_TRANSP" )
U_MYPUTSX1(	cPerg,	"24", aHelp[24,1],	aHelp[24,2], aHelp[24,3],	"mv_chO",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","",		"","S","mv_par24",""          	,"","",""			,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[24,4],aHelp[24,5],aHelp[24,6],"" )
U_MYPUTSX1(	cPerg,	"25", aHelp[25,1],	aHelp[25,2], aHelp[25,3],	"mv_chP",   aTamSX3[3],	aTamSx3[1],	aTamSX3[2],	0, "G", "","",		"","S","mv_par25",""          	,"","",""			,""              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[25,4],aHelp[25,5],aHelp[25,6],"" )
U_MYPUTSX1(	cPerg,	"26", aHelp[26,1],	aHelp[26,2], aHelp[26,3],	"mv_chQ",   "N",		1,			0,			2, "C", "","",		"","S","mv_par26","Sim"          ,"","",""			,"Não"              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[26,4],aHelp[26,5],aHelp[26,6],"" )
U_MYPUTSX1(	cPerg,	"27", aHelp[27,1],	aHelp[27,2], aHelp[27,3],	"mv_chR",   "N",		1,			0,			2, "C", "","",		"","S","mv_par27","Sim"          ,"","",""			,"Não"              ,""			,"",""        ,"","",""           ,"","",""        ,"","",aHelp[27,4],aHelp[27,5],aHelp[27,6],"" )

RestArea( aAreaSX1 )
RestArea( aAreaAtu )

Return()
  
Static Function MyCalcTam(cString, nOption)
Local nCont1 	:= 1 
Local nRetTam	:= 0
Local nPos		:= 0
Local aAsc2Tam 	:= {			;
 {  1,5} ; 
 ,{  2,5} ; 
 ,{  3,5} ; 
 ,{  4,5} ; 
 ,{  5,5} ; 
 ,{  6,5} ; 
 ,{  7,5} ; 
 ,{  8,5} ; 
 ,{  9,0} ; 
 ,{  10,3} ; 
 ,{  11,5} ; 
 ,{  12,5} ; 
 ,{  13,0} ; 
 ,{  14,5} ; 
 ,{  15,5} ; 
 ,{  16,5} ; 
 ,{  17,5} ; 
 ,{  18,5} ; 
 ,{  19,5} ; 
 ,{  20,5} ; 
 ,{  21,5} ; 
 ,{  22,5} ; 
 ,{  23,5} ; 
 ,{  24,5} ; 
 ,{  25,5} ; 
 ,{  26,5} ; 
 ,{  27,5} ; 
 ,{  28,5} ; 
 ,{  29,5} ; 
 ,{  30,5} ; 
 ,{  31,5} ; 
 ,{  32,0} ; 
 ,{  33,2} ; 
 ,{  34,4} ; 
 ,{  35,4} ; 
 ,{  36,4} ; 
 ,{  37,9} ; 
 ,{  38,7} ; 
 ,{  39,2} ; 
 ,{  40,3} ; 
 ,{  41,3} ; 
 ,{  42,4} ; 
 ,{  43,5} ; 
 ,{  44,2} ; 
 ,{  45,3} ; 
 ,{  46,2} ; 
 ,{  47,2} ; 
 ,{  48,4} ; 
 ,{  49,4} ; 
 ,{  50,4} ; 
 ,{  51,4} ; 
 ,{  52,4} ; 
 ,{  53,4} ; 
 ,{  54,4} ; 
 ,{  55,4} ; 
 ,{  56,4} ; 
 ,{  57,4} ; 
 ,{  58,3} ; 
 ,{  59,3} ; 
 ,{  60,5} ; 
 ,{  61,5} ; 
 ,{  62,5} ; 
 ,{  63,4} ; 
 ,{  64,7} ; 
 ,{  65,6} ; 
 ,{  66,6} ; 
 ,{  67,6} ; 
 ,{  68,6} ; 
 ,{  69,5} ; 
 ,{  70,5} ; 
 ,{  71,7} ; 
 ,{  72,6} ; 
 ,{  73,3} ; 
 ,{  74,4} ; 
 ,{  75,6} ; 
 ,{  76,5} ; 
 ,{  77,8} ; 
 ,{  78,6} ; 
 ,{  79,6} ; 
 ,{  80,5} ; 
 ,{  81,8} ; 
 ,{  82,6} ; 
 ,{  83,4} ; 
 ,{  84,5} ; 
 ,{  85,6} ; 
 ,{  86,6} ; 
 ,{  87,8} ; 
 ,{  88,5} ; 
 ,{  89,6} ; 
 ,{  90,4} ; 
 ,{  91,3} ; 
 ,{  92,2} ; 
 ,{  93,3} ; 
 ,{  94,5} ; 
 ,{  95,4} ; 
 ,{  96,3} ; 
 ,{  97,4} ; 
 ,{  98,4} ; 
 ,{  99,4} ; 
 ,{  100,4} ; 
 ,{  101,4} ; 
 ,{  102,3} ; 
 ,{  103,4} ; 
 ,{  104,4} ; 
 ,{  105,2} ; 
 ,{  106,3} ; 
 ,{  107,3} ; 
 ,{  108,2} ; 
 ,{  109,6} ; 
 ,{  110,4} ; 
 ,{  111,4} ; 
 ,{  112,4} ; 
 ,{  113,4} ; 
 ,{  114,4} ; 
 ,{  115,3} ; 
 ,{  116,3} ; 
 ,{  117,4} ; 
 ,{  118,4} ; 
 ,{  119,6} ; 
 ,{  120,4} ; 
 ,{  121,4} ; 
 ,{  122,3} ; 
 ,{  123,3} ; 
 ,{  124,3} ; 
 ,{  125,3} ; 
 ,{  126,4} ; 
 ,{  127,4} ; 
 ,{  128,4} ; 
 ,{  129,0} ; 
 ,{  130,3} ; 
 ,{  131,4} ; 
 ,{  132,4} ; 
 ,{  133,8} ; 
 ,{  134,3} ; 
 ,{  135,5} ; 
 ,{  136,3} ; 
 ,{  137,9} ; 
 ,{  138,4} ; 
 ,{  139,3} ; 
 ,{  140,8} ; 
 ,{  141,0} ; 
 ,{  142,4} ; 
 ,{  143,0} ; 
 ,{  144,0} ; 
 ,{  145,3} ; 
 ,{  146,3} ; 
 ,{  147,4} ; 
 ,{  148,4} ; 
 ,{  149,4} ; 
 ,{  150,4} ; 
 ,{  151,8} ; 
 ,{  152,3} ; 
 ,{  153,8} ; 
 ,{  154,3} ; 
 ,{  155,3} ; 
 ,{  156,6} ; 
 ,{  157,0} ; 
 ,{  158,3} ; 
 ,{  159,6} ; 
 ,{  160,2} ; 
 ,{  161,3} ; 
 ,{  162,4} ; 
 ,{  163,4} ; 
 ,{  164,4} ; 
 ,{  165,4} ; 
 ,{  166,3} ; 
 ,{  167,4} ; 
 ,{  168,2} ; 
 ,{  169,6} ; 
 ,{  170,2} ; 
 ,{  171,4} ; 
 ,{  172,5} ; 
 ,{  173,3} ; 
 ,{  174,6} ; 
 ,{  175,4} ; 
 ,{  176,3} ; 
 ,{  177,4} ; 
 ,{  178,2} ; 
 ,{  179,2} ; 
 ,{  180,3} ; 
 ,{  181,5} ; 
 ,{  182,4} ; 
 ,{  183,3} ; 
 ,{  184,3} ; 
 ,{  185,2} ; 
 ,{  186,3} ; 
 ,{  187,4} ; 
 ,{  188,6} ; 
 ,{  189,6} ; 
 ,{  190,6} ; 
 ,{  191,4} ; 
 ,{  192,6} ; 
 ,{  193,6} ; 
 ,{  194,6} ; 
 ,{  195,6} ; 
 ,{  196,6} ; 
 ,{  197,6} ; 
 ,{  198,8} ; 
 ,{  199,6} ; 
 ,{  200,5} ; 
 ,{  201,5} ; 
 ,{  202,5} ; 
 ,{  203,5} ; 
 ,{  204,3} ; 
 ,{  205,3} ; 
 ,{  206,3} ; 
 ,{  207,3} ; 
 ,{  208,6} ; 
 ,{  209,6} ; 
 ,{  210,6} ; 
 ,{  211,6} ; 
 ,{  212,6} ; 
 ,{  213,6} ; 
 ,{  214,6} ; 
 ,{  215,5} ; 
 ,{  216,6} ; 
 ,{  217,6} ; 
 ,{  218,6} ; 
 ,{  219,6} ; 
 ,{  220,6} ; 
 ,{  221,6} ; 
 ,{  222,5} ; 
 ,{  223,4} ; 
 ,{  224,4} ; 
 ,{  225,4} ; 
 ,{  226,4} ; 
 ,{  227,4} ; 
 ,{  228,4} ; 
 ,{  229,4} ; 
 ,{  230,6} ; 
 ,{  231,4} ; 
 ,{  232,4} ; 
 ,{  233,4} ; 
 ,{  234,4} ; 
 ,{  235,4} ; 
 ,{  236,2} ; 
 ,{  237,2} ; 
 ,{  238,2} ; 
 ,{  239,2} ; 
 ,{  240,4} ; 
 ,{  241,4} ; 
 ,{  242,4} ; 
 ,{  243,4} ; 
 ,{  244,4} ; 
 ,{  245,4} ; 
 ,{  246,4} ; 
 ,{  247,4} ; 
 ,{  248,4} ; 
 ,{  249,4} ; 
 ,{  250,4} ; 
 ,{  251,4} ; 
 ,{  252,4} ; 
 ,{  253,4} ; 
 ,{  254,4} ; 
}
Local aAsc2Tam2 	:= {			;
 { 1,4} ; 
 ,{ 2,4} ; 
 ,{ 3,4} ; 
 ,{ 4,4} ; 
 ,{ 5,4} ; 
 ,{ 6,4} ; 
 ,{ 7,4} ; 
 ,{ 8,4} ; 
 ,{ 9,0} ; 
 ,{ 10,2} ; 
 ,{ 11,4} ; 
 ,{ 12,4} ; 
 ,{ 13,0} ; 
 ,{ 14,4} ; 
 ,{ 15,4} ; 
 ,{ 16,4} ; 
 ,{ 17,4} ; 
 ,{ 18,4} ; 
 ,{ 19,4} ; 
 ,{ 20,4} ; 
 ,{ 21,4} ; 
 ,{ 22,4} ; 
 ,{ 23,4} ; 
 ,{ 24,4} ; 
 ,{ 25,4} ; 
 ,{ 26,4} ; 
 ,{ 27,4} ; 
 ,{ 28,4} ; 
 ,{ 29,4} ; 
 ,{ 30,4} ; 
 ,{ 31,4} ; 
 ,{ 32,0} ; 
 ,{ 33,3} ; 
 ,{ 34,3} ; 
 ,{ 35,4} ; 
 ,{ 36,4} ; 
 ,{ 37,7} ; 
 ,{ 38,7} ; 
 ,{ 39,2} ; 
 ,{ 40,3} ; 
 ,{ 41,3} ; 
 ,{ 42,4} ; 
 ,{ 43,5} ; 
 ,{ 44,2} ; 
 ,{ 45,3} ; 
 ,{ 46,2} ; 
 ,{ 47,2} ; 
 ,{ 48,4} ; 
 ,{ 49,4} ; 
 ,{ 50,4} ; 
 ,{ 51,4} ; 
 ,{ 52,4} ; 
 ,{ 53,4} ; 
 ,{ 54,4} ; 
 ,{ 55,4} ; 
 ,{ 56,4} ; 
 ,{ 57,4} ; 
 ,{ 58,2} ; 
 ,{ 59,2} ; 
 ,{ 60,5} ; 
 ,{ 61,5} ; 
 ,{ 62,5} ; 
 ,{ 63,3} ; 
 ,{ 64,8} ; 
 ,{ 65,6} ; 
 ,{ 66,5} ; 
 ,{ 67,5} ; 
 ,{ 68,6} ; 
 ,{ 69,5} ; 
 ,{ 70,4} ; 
 ,{ 71,6} ; 
 ,{ 72,6} ; 
 ,{ 73,3} ; 
 ,{ 74,3} ; 
 ,{ 75,6} ; 
 ,{ 76,5} ; 
 ,{ 77,7} ; 
 ,{ 78,6} ; 
 ,{ 79,6} ; 
 ,{ 80,5} ; 
 ,{ 81,6} ; 
 ,{ 82,5} ; 
 ,{ 83,4} ; 
 ,{ 84,5} ; 
 ,{ 85,6} ; 
 ,{ 86,6} ; 
 ,{ 87,8} ; 
 ,{ 88,6} ; 
 ,{ 89,6} ; 
 ,{ 90,5} ; 
 ,{ 91,3} ; 
 ,{ 92,2} ; 
 ,{ 93,3} ; 
 ,{ 94,4} ; 
 ,{ 95,4} ; 
 ,{ 96,2} ; 
 ,{ 97,4} ; 
 ,{ 98,4} ; 
 ,{ 99,4} ; 
 ,{ 100,4} ; 
 ,{ 101,4} ; 
 ,{ 102,3} ; 
 ,{ 103,4} ; 
 ,{ 104,4} ; 
 ,{ 105,2} ; 
 ,{ 106,3} ; 
 ,{ 107,3} ; 
 ,{ 108,2} ; 
 ,{ 109,7} ; 
 ,{ 110,4} ; 
 ,{ 111,4} ; 
 ,{ 112,4} ; 
 ,{ 113,4} ; 
 ,{ 114,3} ; 
 ,{ 115,3} ; 
 ,{ 116,2} ; 
 ,{ 117,4} ; 
 ,{ 118,4} ; 
 ,{ 119,6} ; 
 ,{ 120,4} ; 
 ,{ 121,5} ; 
 ,{ 122,3} ; 
 ,{ 123,4} ; 
 ,{ 124,2} ; 
 ,{ 125,4} ; 
 ,{ 126,4} ; 
 ,{ 127,3} ; 
 ,{ 128,4} ; 
 ,{ 129,0} ; 
 ,{ 130,3} ; 
 ,{ 131,4} ; 
 ,{ 132,3} ; 
 ,{ 133,8} ; 
 ,{ 134,4} ; 
 ,{ 135,4} ; 
 ,{ 136,3} ; 
 ,{ 137,8} ; 
 ,{ 138,4} ; 
 ,{ 139,3} ; 
 ,{ 140,7} ; 
 ,{ 141,0} ; 
 ,{ 142,5} ; 
 ,{ 143,0} ; 
 ,{ 144,0} ; 
 ,{ 145,2} ; 
 ,{ 146,2} ; 
 ,{ 147,4} ; 
 ,{ 148,4} ; 
 ,{ 149,3} ; 
 ,{ 150,4} ; 
 ,{ 151,8} ; 
 ,{ 152,3} ; 
 ,{ 153,8} ; 
 ,{ 154,3} ; 
 ,{ 155,3} ; 
 ,{ 156,6} ; 
 ,{ 157,0} ; 
 ,{ 158,3} ; 
 ,{ 159,6} ; 
 ,{ 160,2} ; 
 ,{ 161,3} ; 
 ,{ 162,4} ; 
 ,{ 163,4} ; 
 ,{ 164,4} ; 
 ,{ 165,4} ; 
 ,{ 166,3} ; 
 ,{ 167,4} ; 
 ,{ 168,4} ; 
 ,{ 169,6} ; 
 ,{ 170,2} ; 
 ,{ 171,6} ; 
 ,{ 172,5} ; 
 ,{ 173,3} ; 
 ,{ 174,6} ; 
 ,{ 175,4} ; 
 ,{ 176,3} ; 
 ,{ 177,4} ; 
 ,{ 178,2} ; 
 ,{ 179,2} ; 
 ,{ 180,2} ; 
 ,{ 181,5} ; 
 ,{ 182,4} ; 
 ,{ 183,3} ; 
 ,{ 184,3} ; 
 ,{ 185,2} ; 
 ,{ 186,2} ; 
 ,{ 187,6} ; 
 ,{ 188,6} ; 
 ,{ 189,6} ; 
 ,{ 190,6} ; 
 ,{ 191,3} ; 
 ,{ 192,6} ; 
 ,{ 193,6} ; 
 ,{ 194,6} ; 
 ,{ 195,6} ; 
 ,{ 196,6} ; 
 ,{ 197,6} ; 
 ,{ 198,8} ; 
 ,{ 199,5} ; 
 ,{ 200,5} ; 
 ,{ 201,5} ; 
 ,{ 202,5} ; 
 ,{ 203,5} ; 
 ,{ 204,3} ; 
 ,{ 205,3} ; 
 ,{ 206,3} ; 
 ,{ 207,3} ; 
 ,{ 208,7} ; 
 ,{ 209,6} ; 
 ,{ 210,6} ; 
 ,{ 211,6} ; 
 ,{ 212,6} ; 
 ,{ 213,6} ; 
 ,{ 214,6} ; 
 ,{ 215,5} ; 
 ,{ 216,6} ; 
 ,{ 217,6} ; 
 ,{ 218,6} ; 
 ,{ 219,6} ; 
 ,{ 220,6} ; 
 ,{ 221,6} ; 
 ,{ 222,5} ; 
 ,{ 223,4} ; 
 ,{ 224,4} ; 
 ,{ 225,4} ; 
 ,{ 226,4} ; 
 ,{ 227,4} ; 
 ,{ 228,4} ; 
 ,{ 229,4} ; 
 ,{ 230,5} ; 
 ,{ 231,4} ; 
 ,{ 232,4} ; 
 ,{ 233,4} ; 
 ,{ 234,4} ; 
 ,{ 235,4} ; 
 ,{ 236,2} ; 
 ,{ 237,2} ; 
 ,{ 238,2} ; 
 ,{ 239,2} ; 
 ,{ 240,4} ; 
 ,{ 241,4} ; 
 ,{ 242,4} ; 
 ,{ 243,4} ; 
 ,{ 244,4} ; 
 ,{ 245,4} ; 
 ,{ 246,4} ; 
 ,{ 247,4} ; 
 ,{ 248,4} ; 
 ,{ 249,4} ; 
 ,{ 250,4} ; 
 ,{ 251,4} ; 
 ,{ 252,4} ; 
 ,{ 253,4} ; 
 ,{ 254,5} ; 
}

Default nOption := 1

cString := Alltrim(cString)

For nCont1 := 1 To Len(cString)
	
	If nOption == 1
		nPos := aScan(aAsc2Tam,{ |x| x[1] == Asc(SubStr(cString,nCont1,1)) } )
		
		If nPos > 0
			nRetTam += aAsc2Tam[nPos][2]
		EndIf	               
	Else
		nPos := aScan(aAsc2Tam2,{ |x| x[1] == Asc(SubStr(cString,nCont1,1)) } )
		
		If nPos > 0
			nRetTam += aAsc2Tam2[nPos][2]
		EndIf	
	EndIf
	
Next nCont1

Return(nRetTam)
