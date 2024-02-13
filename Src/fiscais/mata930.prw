#INCLUDE "Mata930.ch"
#INCLUDE "PROTHEUS.CH"

#define __CFO			1	// C�digo do CFO
#define __ICMS  		2	// Aliquota do ICMS
#define __VALTOT		3	// Valor total da Mercadoria
#define __VALIPI		4 	// Valor do IPI
#define __VALICM		5	// Valor do ICMS
#define __ALIQIPI		6	// Aliquota de IPI
#define __TES			7	// C�digo do TES
#define __ISS			8	// C�digo deadmin	 Servi�o do ISS
#define __DESCON		9	// Desconto do Item

STATIC lFisLivro := (SuperGetMV("MV_LJLVFIS",,1) == 2)		// Utiliza novo conceito para geracao do SF3
STATIC lHistFis  := .F.

/*/
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
���������������������������������������������������������������������������Ŀ��
���Program   � MATA930  � Autor � Eduardo / Edson       � Data �08.08.2001  ���
���������������������������������������������������������������������������Ĵ��
���Descri��o �Reprocessamento dos Livros Fiscais                            ���
���������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                        ���
���������������������������������������������������������������������������Ĵ��
���Parametros�ExpL1: Indica se foi chamado por uma rotina automatica        ���
���          �ExpA2: Parametros da rotina automatica                        ���
���          �                                                              ���
���������������������������������������������������������������������������Ĵ��
��� ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                       ���
���������������������������������������������������������������������������Ĵ��
��� PROGRAMADOR  � DATA   � BOPS �  MOTIVO DA ALTERACAO                     ���
���������������������������������������������������������������������������Ĵ��
��� Edilson      �19/12/02�      � Implementada a rotina para que o programa���
���              �        �      � possa ser executada dentro do modulo     ���
���              �        �      � SIGALOJA.                                ���
����������������������������������������������������������������������������ٱ�
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
/*/
USER FUNCTION MATA930(lAutoA930,aPergA930)

LOCAL nOpcA		:=	0
LOCAL aSays		:=	{}
LOCAL aButtons	:=	{}
Local oObj
Local bProcesso	:= { |oSelf| Ma930Param(oSelf,lAutoA930) }  
Local oTProces

Private lVersao101	:= GetRpoRelease()>="R1.1" 

DEFAULT lAutoA930 := .F.
DEFAULT aPergA930 := {}  

If !lVersao101

	If (AMIIn(9,12,72))

		AjustaSX1()
   		Pergunte("MTA930",.T.)
		//����������������������������������������������������������������Ŀ
		//� mv_par01 - Data Inicial                                        �
		//� mv_par02 - Data Final                                          �
		//� mv_par03 - Entradas / Saidas / Ambas                           �
		//| mv_par12 - Da Filial                                           |
		//| mv_par13 - Ate a Filial	                                       |
		//������������������������������������������������������������������

		AADD(aSays,STR0001 ) //"Esta  rotina ira refazer os Livros Fiscais referente ao periodo"
		AADD(aSays,STR0002 ) //"informado e o tipo, se Entrada ou Sa�da. ATENCAO! Esta rotina"
		AADD(aSays,STR0003 ) //"devera ser executada em modo mono-usuario."
	
		AADD(aButtons,{ 5,.T.,{|o| Pergunte("MTA930",.T.) }} )
		AADD(aButtons,{ 1,.T.,{|o| nOpca:= 1, o:oWnd:End() }} )
		AADD(aButtons,{ 2,.T.,{|o| o:oWnd:End() }} )
	
		FormBatch(STR0004,aSays,aButtons,,190,395 ) //"Reprocessamento Fiscal"
	
   		If ( nOpcA == 1 )
			Ma930Param(,lAutoA930,)
   		EndIf
   EndIf
								
Else
	If lAutoA930 .And. Len(aPergA930)==11
		Ma930Param(,lAutoA930,,aPergA930)
	Else
		oTProces := tNewProcess():New( "MATA930" , STR0004 , bProcesso , STR0004 , "MTA930",,,,,.T.,.T.) 
		oTProces:SaveLog(OemToAnsi(STR0008))
	EndIf
EndIf 									

Return(.T.)
/*/
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Fun��o    �A930RPEntr� Autor � Eduardo Riera         � Data �08.08.2001 ���
��������������������������������������������������������������������������Ĵ��
���          �Rotina de reprocessamento das notas fiscal de entrada        ���
���          �                                                             ���
��������������������������������������������������������������������������Ĵ��
���Parametros�ExpL1: Indica se nao existe interface                        ���
��������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                       ���
���          �                                                             ���
��������������������������������������������������������������������������Ĵ��
���Descri��o �Esta rotina tem como objetivo reprocessar os livros fiscais  ���
���          �das notas de entrada.                                        ���
���          �                                                             ���
��������������������������������������������������������������������������Ĵ��
���Uso       � Materiais                                                   ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
Static Function A930RPEntrada(lAuto,oObj)

Local aOtimizacao := {}
Local cQuery      := ""
Local cAlias      := "SF1"
Local cIndex      := ""
Local lQuery      := .F.
Local lRefaz      := .F.
Local lUsaCfps	  := GetNewPar("MV_USACFPS",.F.)
Local xWhile	  := ""
Local cFilOri		:= FWCodFil()
Local cFilIni 		:= Iif(Empty(MV_PAR12),cFilAnt,MV_PAR12)
Local cFilFin 		:= Iif(Empty(MV_PAR13),cFilAnt,MV_PAR13)
Local cCNAE			:= "" 
Local cCodSef     := ""

#IFDEF TOP
	Local nX          := 0
	Local aStru       := {}
#ENDIF		

//���������������������������������������������������������������������������������
//�Quando � automatico, efetua o reprocessamento apenas da filial atual -> CFILANT�
//���������������������������������������������������������������������������������
If lAuto
	cFilIni := cFilAnt
	cFilFin := cFilAnt
Endif

dbSelectArea("SM0")
SM0->(dbSeek(cEmpAnt+cFilIni,.T.))
If !lAuto
   oObj:SetRegua1(SM0->(LastRec()))
Endif   
	
While ! SM0->(Eof()) .And. FWGrpCompany() == cEmpAnt .And. FWCodFil() <= cFilFin

	If !lAuto
	   oObj:IncRegua1(AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL)
	Endif   
	
	cFilAnt 	:= FWCodFil()
	#IFDEF TOP
		aStru		:= {}
	#ENDIF
	aOtimizacao	:= {}
	cQuery		:= ""
   	cAlias		:= "SF1"
	cIndex		:= ""
	lQuery		:= .F.
	lRefaz		:= .F.
	nX			:= 0
	xWhile		:= ""

	dbSelectArea("SF1")
	dbSetOrder(1)
	#IFDEF TOP
		If ( TcSrvType()!="AS/400" )
			lQuery := .T.
			cAlias := "MA930GRVQ1"
			aStru  := SF1->(dbStruct())
			cQuery := "SELECT SF1.*,SF1.R_E_C_N_O_  SF1RECNO "
			cQuery += "FROM "+RetSqlName("SF1")+" SF1 "

			If FWModeAccess("SF1",3)=="C" .And. SF1->(FieldPos("F1_MSFIL")) > 0			
				cQuery += "WHERE SF1.F1_MSFIL='"+cFilAnt+"' AND "
			Else	
				cQuery += "WHERE SF1.F1_FILIAL='"+xFilial("SF1")+"' AND "
			EndIf
			
			cQuery +=       "SF1.F1_DTDIGIT>='"+DTOS(MV_PAR01)+"' AND "
			cQuery +=       "SF1.F1_DTDIGIT<='"+DTOS(MV_PAR02)+"' AND "
			cQuery +=       "SF1.F1_DOC>='"+MV_PAR04+"' AND "
			cQuery +=       "SF1.F1_DOC<='"+MV_PAR05+"' AND "
			cQuery +=       "SF1.F1_SERIE>='"+MV_PAR06+"' AND "
			cQuery +=       "SF1.F1_SERIE<='"+MV_PAR07+"' AND "
			cQuery +=       "SF1.F1_FORNECE>='"+MV_PAR08+"' AND "
			cQuery +=       "SF1.F1_FORNECE<='"+MV_PAR09+"' AND "
			cQuery +=       "SF1.F1_LOJA>='"+MV_PAR10+"' AND "
			cQuery +=       "SF1.F1_LOJA<='"+MV_PAR11+"' AND "
			cQuery +=       "SF1.F1_STATUS <> '' AND "
			cQuery +=       "SF1.F1_STATUS <> 'C' AND "             // NOTAS FISCAIS COM BLOQUEIO
			If cPaisLoc<>"BRA"
				cQuery += "NOT ("+IsRemito(3,'SF1.F1_TIPODOC')+ ") AND "
			EndIf
			cQuery +=       "SF1.D_E_L_E_T_<>'*' "
			cQuery += "ORDER BY "+SqlOrder(IndexKey())
	
			cQuery := ChangeQuery(cQuery)
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias,.T.,.T.)	
			For nX := 1 To Len(aStru)
				If aStru[nX][2]<>"C"
					TcSetField(cAlias,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
				EndIf
			Next nX
		Else
	#ENDIF
			
		If FWModeAccess("SF1",3)=="C" .And. SF1->(FieldPos("F1_MSFIL")) > 0			
			cQuery += "F1_MSFIL='"+cFilAnt+"'.AND."
		Else	
			cQuery += "F1_FILIAL='"+xFilial("SF1")+"'.AND."
		EndIf
				
		cQuery += "DTOS(F1_DTDIGIT)>='"+DTOS(MV_PAR01)+"'.AND."
		cQuery += "DTOS(F1_DTDIGIT)<='"+DTOS(MV_PAR02)+"'.AND."
		cQuery += "F1_DOC>='"+MV_PAR04+"'.AND."
		cQuery += "F1_DOC<='"+MV_PAR05+"'.AND."
		cQuery += "F1_SERIE>='"+MV_PAR06+"'.AND."
		cQuery += "F1_SERIE<='"+MV_PAR07+"'.AND."
		cQuery += "F1_FORNECE>='"+MV_PAR08+"'.AND."
		cQuery += "F1_FORNECE<='"+MV_PAR09+"'.AND."
		cQuery += "F1_LOJA>='"+MV_PAR10+"'.AND."
		cQuery += "F1_LOJA<='"+MV_PAR11+"' .AND."				
		If cPaisLoc<>"BRA"
			cQuery  += "!("+IsRemito(2,'F1_TIPODOC')+") .AND."			
		EndIf	
    	cQuery += "!EMPTY(F1_STATUS)"
		
		cIndex := CriaTrab(,.F.)
		IndRegua("SF1",cIndex,IndexKey(),,cQuery)
		dbGotop()
		#IFDEF TOP
		EndIf
		#ENDIF
	dbSelectArea(cAlias)
	
	If !lAuto
	   oObj:SetRegua2(SF1->(LastRec()))
	Endif   
	
	While ( !Eof() )
	
		lRefaz := .T.
	
		If (ExistBlock ("MTA930F1"))
			If !(ExecBlock ("MTA930F1",.F.,.F.,{cAlias}))
				lRefaz := .F.
			EndIf
		EndIf
		If lRefaz
			dbSelectArea("SF3")
			dbSetOrder(1)
			MsSeek(xFilial("SF3")+Dtos((cAlias)->F1_DTDIGIT)+(cAlias)->F1_DOC+(cAlias)->F1_SERIE+(cAlias)->F1_FORNECE+(cAlias)->F1_LOJA)
		
			If FWModeAccess("SF3",3)=="C" .And. SF3->(FieldPos("F3_MSFIL")) > 0
				xWhile := "SF3->F3_MSFIL == '"+cFilAnt+"' .And. SF3->F3_NFISCAL == (cAlias)->F1_DOC .And. "
			Else	
				xWhile := "SF3->F3_FILIAL == xFilial('SF3') .And. SF3->F3_NFISCAL == (cAlias)->F1_DOC .And. "
			EndIf
			
			xWhile += "SF3->F3_SERIE == (cAlias)->F1_SERIE .And. SF3->F3_CLIEFOR == (cAlias)->F1_FORNECE .And. "
			xWhile += "SF3->F3_LOJA == (cAlias)->F1_LOJA .And. "
		
			If lUsaCfps
				xWhile += "(SubStr(SF3->F3_CFO,1,1)<'5' .Or. FisChkCfps('E',SF3->F3_CFO))"
			Else
				xWhile += "SubStr(SF3->F3_CFO,1,1)<'5'"	
			Endif
			xWhile := &('{||'+xWhile+'}')
		
			While !Eof() .And. Eval(xWhile)
				If SF3->F3_FORMUL=(cAlias)->F1_FORMUL .And. SF3->F3_REPROC == "N"
					lRefaz := .F.
					Exit
				EndIf
				dbSelectArea("SF3")		
				dbSkip()
			EndDo
		EndIf
		If lRefaz
			//����������������������������������������������Ŀ
			//�Posicionando cadastro de clientes/fornecedores�
			//������������������������������������������������
			If (cAlias)->F1_TIPO $ "DB"
				SA1->(dbSetOrder(1))
				SA1->(MsSeek(xFilial("SA1")+(cAlias)->F1_FORNECE+(cAlias)->F1_LOJA))
			Else
				SA2->(dbSetOrder(1))
				SA2->(MsSeek(xFilial("SA2")+(cAlias)->F1_FORNECE+(cAlias)->F1_LOJA))
			Endif
			//���������������������������������������������������������������Ŀ
			//� Carrega a Nota Fiscal SF3 referente a Notas Fiscais de Entrada�
			//�����������������������������������������������������������������
			MaFisIniNF(1,IIf(lQuery,(cAlias)->SF1RECNO,SF1->(RecNo())),@aOtimizacao,cAlias,((cAlias)->F1_IMPORT<>"S"), "MATA930", lHistFis)
			
			Begin Transaction
				//���������������������������������������������������������������Ŀ
				//� Efetua a exclusao dos registros referente a Nota Fiscal no SF3�
				//�����������������������������������������������������������������
				dbSelectArea("SF3")
				dbSetOrder(1)
				MsSeek(xFilial("SF3")+Dtos((cAlias)->F1_DTDIGIT)+(cAlias)->F1_DOC+(cAlias)->F1_SERIE+(cAlias)->F1_FORNECE+(cAlias)->F1_LOJA)
				// Verifico se o campo "SF3->F3_CODRSEF" contem valor na tabela, se existir armazeno o conteudo na variavel "cCodSef" (que e previamente limpa). 
				cCodSef := "" 
				If !Empty(SF3->F3_CODRSEF)
					cCodSef := SF3->F3_CODRSEF
				Endif					
				cCNAE := ""
				If SF3->(FieldPos("F3_CNAE"))>0 .And. Alltrim(SF3->F3_CNAE) <> ""
					cCNAE := SF3->F3_CNAE
				Endif
				
				While !Eof() .And. Eval(xWhile)
					If Empty(SF3->F3_DTCANC)
						//���������������������������������������������������������������Ŀ
						//� Efetua a exclusao dos registros referente a Nota Fiscal no SFT�
						//�����������������������������������������������������������������
						If AliasInDic("SFT")
							dbSelectArea("SFT")
							dbSetOrder(3)
							MsSeek(xFilial("SFT")+"E"+SF3->F3_CLIEFOR+SF3->F3_LOJA+SF3->F3_SERIE+SF3->F3_NFISCAL+SF3->F3_IDENTFT)
							While !Eof() .And.;
								xFilial("SFT")+"E"+SF3->F3_CLIEFOR+SF3->F3_LOJA+SF3->F3_SERIE+SF3->F3_NFISCAL+SF3->F3_IDENTFT==;
								xFilial("SFT")+"E"+SFT->FT_CLIEFOR+SFT->FT_LOJA+SFT->FT_SERIE+SFT->FT_NFISCAL+SFT->FT_IDENTF3
								//
								If FWModeAccess("SFT",3)=="C" .And. SFT->(FieldPos("FT_MSFIL")) > 0 .And. SFT->FT_MSFIL == cFilAnt
									RecLock('SFT',.F.,.T.)
										dbDelete()
										MsUnlock()
									FkCommit ()
								Else
									RecLock('SFT',.F.,.T.)
										dbDelete()
									MsUnlock()
									FkCommit ()
								EndIf
								//
								dbSelectArea("SFT")
								dbSkip()
							EndDo
						EndIf
						//���������������������������������������������������������������Ŀ
						//� Efetua a exclusao dos registros referente a Nota Fiscal no SF3�
						//�����������������������������������������������������������������
						RecLock('SF3',.F.,.T.)
						dbDelete()
						MsUnlock()
						FkCommit()
					EndIf
					dbSelectArea("SF3")
					dbSkip()
				EndDo
				//���������������������������������������������������������Ŀ				
				//� Inicializa a gravacao nas funcoes Fiscais               �
				//�����������������������������������������������������������
				MaFisWrite()
				//���������������������������������������������������������Ŀ
				//� Efetua a gravacao dos registros referente a Nota no SF3 �
				//�����������������������������������������������������������
				MaFisAtuSF3(1,"E",IIf(lQuery,(cAlias)->SF1RECNO,SF1->(RecNo())),"","",cCNAE,"MATA930",,cCodSef) 

				dbSelectArea("CDA")
				dbSetOrder(1)
				MsSeek(xFilial("CDA")+(cAlias)->("E"+F1_ESPECIE+F1_FORMUL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA))	
					if CDA->CDA_CALPRO == "2"   //N�o reprocessa La�amento Manual, apenas feito via TES.	
						lRefaz := .F.
					EndIf			       
		        if lRefaz
		        	MAFISCDA(,,.T.,(cAlias)->("E"+F1_ESPECIE+F1_FORMUL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA),(cAlias)->F1_FORMUL,cAlias)
		        	MAFISCDA(,2,,(cAlias)->("E"+F1_ESPECIE+F1_FORMUL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA),(cAlias)->F1_FORMUL,cAlias)
		        EndIf	
		
				//���������������������������������������������������Ŀ
				//� Ponto de entrada, na gravacao do livro            �
				//� fiscal															�
				//�����������������������������������������������������
				If ExistBlock("MT930SF3")
					dbSelectArea("SF3")
					dbSetOrder(1)
					MsSeek(xFilial("SF3")+Dtos((cAlias)->F1_DTDIGIT)+(cAlias)->F1_DOC+(cAlias)->F1_SERIE+(cAlias)->F1_FORNECE+(cAlias)->F1_LOJA)
					ExecBlock("MT930SF3",.f.,.f.)
				EndIf
			End Transaction
			MaFisEnd()
		EndIf
		dbSelectArea(cAlias)
		dbSkip()
		If !lAuto
			oObj:IncRegua2(STR0006+" "+Dtoc((cAlias)->F1_DTDIGIT)+" "+STR0007+" "+(cAlias)->F1_SERIE+"-"+(cAlias)->F1_DOC)		
		EndIf
	EndDo
	SM0->(dbSkip())
	If ( lQuery )
		dbSelectArea(cAlias)
		dbCloseArea()
		dbSelectArea("SF1")
	Else
		dbSelectArea("SF1")
		RetIndex("SF1")
	EndIf
Enddo
	
//������������������������������������������Ŀ
//�Volta a empresa anteriormente selecionada.�
//��������������������������������������������
dbSelectArea("SM0")
SM0->(dbSeek(cEmpAnt+cFilOri,.T.))
cFilAnt := FWCodFil()

Return( .T. )
/*/
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Fun��o    �A930RPSaid� Autor � Eduardo Riera         � Data �08.08.2001 ���
��������������������������������������������������������������������������Ĵ��
���          �Rotina de reprocessamento das notas fiscal de Saida          ���
���          �                                                             ���
��������������������������������������������������������������������������Ĵ��
���Parametros�ExpL1: Indica se nao existe interface                        ���
��������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                       ���
���          �                                                             ���
��������������������������������������������������������������������������Ĵ��
���Descri��o �Esta rotina tem como objetivo reprocessar os livros fiscais  ���
���          �das notas de saida.                                          ���
���          �                                                             ���
��������������������������������������������������������������������������Ĵ��
���Uso       � Materiais                                                   ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
Static Function A930RPSaida(lAuto,oObj)

Local aOtimizacao := {}
Local cQuery      := ""
Local cAlias      := "SF2"
Local cIndex      := ""
Local lQuery      := .F.
Local lRefaz      := .F.
Local lUsaCfps	  := GetNewPar("MV_USACFPS",.F.)
Local xWhile	  := ""

#IFDEF TOP
	Local nX          := 0
	Local aStru       := {}
#ENDIF

Local cFilOri		:= FWCodFil()
Local cFilIni 		:= Iif(Empty(MV_PAR12),cFilAnt,MV_PAR12)
Local cFilFin 		:= Iif(Empty(MV_PAR13),cFilAnt,MV_PAR13)
Local cOrigLan		:= ""
Local cCNAE			:= ""
Local aEstruSF2     := {}
Local aSF2Zerado    := {}
Local aSD2Zerado    := {}
Local aSF2Back      := {}
Local aSD2Back      := {}
Local nInd          := 0
Local nRecAntSD2 	:= 0                                                        
Local lGerValor     := .F.
Local cCodSef       := ""

//���������������������������������������������������������������������������������
//�Quando � automatico, efetua o reprocessamento apenas da filial atual -> CFILANT�
//���������������������������������������������������������������������������������
If lAuto
	cFilIni := cFilAnt
	cFilFin := cFilAnt
Endif

dbSelectArea("SM0")
SM0->(dbSeek(cEmpAnt+cFilIni,.T.))
If !lAuto
   oObj:SetRegua1(SM0->(LastRec()))
Endif   
	
While ! SM0->(Eof()) .And. FWGrpCompany() == cEmpAnt .And. FWCodFil() <= cFilFin
	

	If !lAuto
	   oObj:IncRegua1(AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL)
	Endif   
	
	cFilAnt 	:= FWCodFil()
	#IFDEF TOP
		aStru       := {}
	#ENDIF
	aOtimizacao := {}
	cQuery      := ""
	cAlias      := "SF2"
	cIndex      := ""
	lQuery      := .F.
	lRefaz      := .F.
	nX          := 0
	xWhile	  	:= ""

	dbSelectArea("SF2")
	dbSetOrder(1)
	#IFDEF TOP
		If ( TcSrvType()!="AS/400" )
			aStru  := SF2->(dbStruct())
			lQuery := .T.
			cAlias := "A930RPSaida"
			cQuery := "SELECT SF2.*,SF2.R_E_C_N_O_  SF2RECNO "
			cQuery += "FROM "+RetSqlName("SF2")+" SF2 "
			
			If FWModeAccess("SF2",3)=="C" .And. SF2->(FieldPos("F2_MSFIL")) > 0			
				cQuery += "WHERE SF2.F2_MSFIL='"+cFilAnt+"' AND "
			Else	
				cQuery += "WHERE SF2.F2_FILIAL='"+xFilial("SF2")+"' AND "
			EndIf
			
			cQuery += "SF2.F2_EMISSAO>='"+DTOS(MV_PAR01)+"' AND "
			cQuery += "SF2.F2_EMISSAO<='"+DTOS(MV_PAR02)+"' AND "
			cQuery += "SF2.F2_DOC>='"+MV_PAR04+"' AND "
			cQuery += "SF2.F2_DOC<='"+MV_PAR05+"' AND "
			cQuery += "SF2.F2_SERIE>='"+MV_PAR06+"' AND "
			cQuery += "SF2.F2_SERIE<='"+MV_PAR07+"' AND "
			cQuery += "SF2.F2_CLIENTE>='"+MV_PAR08+"' AND "
			cQuery += "SF2.F2_CLIENTE<='"+MV_PAR09+"' AND "
			cQuery += "SF2.F2_LOJA>='"+MV_PAR10+"' AND "	
			cQuery += "SF2.F2_LOJA<='"+MV_PAR11+"' AND "
			If cPaisLoc<>"BRA"			
				cQuery += " NOT ("+IsRemito(3,'SF2.F2_TIPODOC')+") AND "
			EndIf
			cQuery += "SF2.D_E_L_E_T_<>'*' "
			cQuery += "ORDER BY "+SqlOrder(IndexKey())
	
			cQuery := ChangeQuery(cQuery)
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias,.T.,.T.)
			For nX := 1 To Len(aStru)
				If aStru[nX][2] <> "C"
					TcSetField(cAlias,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
				EndIf
			Next nX
		Else
	#ENDIF
		
		If FWModeAccess("SF2",3)=="C" .And. SF2->(FieldPos("F2_MSFIL")) > 0			
			cQuery += "F2_MSFIL='"+cFilAnt+"'.AND."
		Else	
			cQuery += "F2_FILIAL='"+xFilial("SF2")+"'.AND."
		EndIf
		
		cQuery += "DTOS(F2_EMISSAO)>='"+DTOS(MV_PAR01)+"'.AND."
		cQuery += "DTOS(F2_EMISSAO)<='"+DTOS(MV_PAR02)+"'.AND."
	   	If cPaisLoc<>"BRA"
			cQuery  += " !("+IsRemito(2,'F2_TIPODOC')+") .AND."
	 	EndIf
		cQuery += "F2_DOC>='"+MV_PAR04+"'.AND."
		cQuery += "F2_DOC<='"+MV_PAR05+"'.AND."
		cQuery += "F2_SERIE>='"+MV_PAR06+"'.AND."
		cQuery += "F2_SERIE<='"+MV_PAR07+"'.AND."
		cQuery += "F2_CLIENTE>='"+MV_PAR08+"'.AND."
		cQuery += "F2_CLIENTE<='"+MV_PAR09+"'.AND."
		cQuery += "F2_LOJA>='"+MV_PAR10+"'.AND."	
		cQuery += "F2_LOJA<='"+MV_PAR11+"' "
	
		cIndex := CriaTrab(,.F.)
		IndRegua('SF2',cIndex,IndexKey(),,cQuery)
		dbGotop()
		#IFDEF TOP
		EndIf
		#ENDIF
	dbSelectArea(cAlias)
	If !lAuto
	   oObj:SetRegua2(SF2->(LastRec()))
	Endif   

	//�����������������������������������������������������������Ŀ
	//�Realiza a delecao dos registros provenientes do Mapa Resumo�
	//�������������������������������������������������������������
	If lFisLivro
		A930LjDelF3()
    EndIf
	
	While !Eof()
	
		lRefaz := .T.

		If (ExistBlock ("MTA930F2"))
			If !(ExecBlock ("MTA930F2",.F.,.F.,{cAlias}))
				lRefaz := .F.
			EndIf
		EndIf	
		//����������������������������������������������������������������������
		//�Desconsiderar F2 que tenham sido gerados pelo LOJA e NFs sobre cupom�
		//����������������������������������������������������������������������
		SD2->(dbSetOrder(3))
		If SD2->(dbSeek(xFilial("SD2")+(cAlias)->F2_DOC+(cAlias)->F2_SERIE+(cAlias)->F2_CLIENTE+(cAlias)->F2_LOJA))		
			 cOrigLan := SD2->D2_ORIGLAN
			 // Somente realiza o tratamento caso nao tenha sido zerado os valores nas tabelas SD2 e SF2
			 If ((cAlias)->F2_VALBRUT) > 0 .AND. (SD2->D2_TOTAL) > 0 
			 	lGerValor := .T.
				If lFisLivro .AND. cPaisLoc =="BRA" .AND. cOrigLan == "LO" .AND. !Empty((cAlias)->F2_NFCUPOM) .AND. ;
					(cAlias)->F2_ECF <> "S"
					
					While !Eof().AND. SD2->D2_FILIAL = xFilial("SD2") .AND. SD2->D2_DOC = (cAlias)->F2_DOC .AND. ;
						SD2->D2_SERIE = (cAlias)->F2_SERIE .AND. SD2->D2_CLIENTE = (cAlias)->F2_CLIENTE .AND. ;
						SD2->D2_LOJA = (cAlias)->F2_LOJA        
						
						A930LjGrava("SD2", @aSD2Back, @aSD2Zerado)         // Faz o backup e em seguida zera os valores do array referente a SD2
					  	aSD2Zerado[Len(aSD2Zerado)][1] := SD2->(Recno())   // Guarda o recno do registro a ser zerado
					  	aSD2Back[Len(aSD2Back)][1] := SD2->(Recno())   	   // Guarda o recno do registro a ser atualizado
					  	For  nInd := 1 to Len(aSD2Zerado)                  // Retorna os valores da SD2 zerados
					  		SD2->( dbGoTo ( aSD2Zerado[nInd][1] ) )        // Posiciona no SD2 da NF
	   				   		Lj7GeraSL( "SD2", aSD2Zerado[nInd][2], .F., .T.)
	   				  	Next nInd
						SD2->(DbSkip())
			   		End
	   			EndIf
	   		 EndIf	
		EndIf

		If lRefaz .AND. IIf(!lFisLivro,(!(cAlias)->F2_ECF == "S" .AND. Empty((cAlias)->F2_NFCUPOM)) .OR. ((cAlias)->F2_ECF == "S" .AND. cOrigLan<>"LO" ),.T.)
			
			dbSelectArea("SF3")
			dbSetOrder(1)
			MsSeek(xFilial("SF3")+Dtos((cAlias)->F2_EMISSAO)+(cAlias)->F2_DOC+(cAlias)->F2_SERIE+(cAlias)->F2_CLIENTE+(cAlias)->F2_LOJA+"5",.T.)
			// Verifico se o campo "SF3->F3_CODRSEF" contem valor na tabela, se existir armazeno o conteudo na variavel "cCodSef" (que e previamente limpa). 
		    cCodSef := "" 
			If !Empty(SF3->F3_CODRSEF)
			   cCodSef := SF3->F3_CODRSEF
			Endif
			If FWModeAccess("SF3",3)=="C" .And. SF3->(FieldPos("F3_MSFIL")) > 0
				xWhile := "SF3->F3_MSFIL == '"+cFilAnt+"' .And. SF3->F3_NFISCAL == (cAlias)->F2_DOC .And. "
			Else	
				xWhile := "SF3->F3_FILIAL == xFilial('SF3') .And. SF3->F3_NFISCAL == (cAlias)->F2_DOC .And. "
			EndIf
			
			xWhile += "SF3->F3_SERIE == (cAlias)->F2_SERIE .And. SF3->F3_CLIEFOR == (cAlias)->F2_CLIENTE .And. "
			xWhile += "SF3->F3_LOJA == (cAlias)->F2_LOJA .And. "
			
			If lUsaCfps
				xWhile += "((Left(SF3->F3_CFO,1)>='5' .And. Left(SF3->F3_CFO,1)<='7') .Or. FisChkCfps('S',SF3->F3_CFO))"
			Else
				xWhile += "Left(SF3->F3_CFO,1)>='5'"
			Endif
			xWhile := &('{||'+xWhile+'}')
	
			While !Eof() .And. Eval(xWhile)
				If SF3->F3_REPROC == "N"
					lRefaz := .F.
					Exit
				EndIf
				dbSelectArea("SF3")		
				dbSkip()
			EndDo
			If lRefaz
			    If lGerValor .AND. lFisLivro .AND. cPaisLoc == "BRA" .AND. cOrigLan == "LO" .AND. ;
			    	!Empty((cAlias)->F2_NFCUPOM) .AND. (cAlias)->F2_ECF <> "S"
			       
				  	aEstruSF2  := SF2->(DbStruct())	        // Faz o backup e zera os valores do array referente a SF2
					For  nInd  := 1 To Len(aEstruSF2)
						If aEstruSF2[nInd,2] == "N"
	    					aADD(aSF2Back,{aEstruSF2[nInd,1], SF2->&(aEstruSF2[nInd,1]) })   
						EndIf
					Next nInd
					                 
				    Lj7GeraSL("SF2",aSF2Zerado, .F., .T.) 
				    
				EndIf
				//����������������������������������������������Ŀ
				//�Posicionando cadastro de clientes/fornecedores�
				//������������������������������������������������
				If (cAlias)->F2_TIPO $ "DB"
					SA2->(dbSetOrder(1))
					SA2->(MsSeek(xFilial("SA2")+(cAlias)->F2_CLIENTE+(cAlias)->F2_LOJA))
				Else
					SA1->(dbSetOrder(1))
					SA1->(MsSeek(xFilial("SA1")+(cAlias)->F2_CLIENTE+(cAlias)->F2_LOJA))
				Endif
				//���������������������������������������������������������������Ŀ
				//� Carrega a Nota Fiscal SF3 referente a Notas Fiscais de Entrada�
				//�����������������������������������������������������������������
				MaFisIniNF(2,IIf(lQuery,(cAlias)->SF2RECNO,SF2->(RecNo())),@aOtimizacao,cAlias,.T.,"MATA930", lHistFis)
				//���������������������������������������������������������������Ŀ
				//� Efetua a exclusao dos registros referente a Nota Fiscal no SF3�
				//�����������������������������������������������������������������
				Begin Transaction
					dbSelectArea("SF3")
					dbSetOrder(1)
					MsSeek(xFilial("SF3")+Dtos((cAlias)->F2_EMISSAO)+(cAlias)->F2_DOC+(cAlias)->F2_SERIE+(cAlias)->F2_CLIENTE+(cAlias)->F2_LOJA+"5",.T.)

					cCNAE := ""
					If SF3->(FieldPos("F3_CNAE"))>0 .And. Alltrim(SF3->F3_CNAE) <> ""
						cCNAE := SF3->F3_CNAE
					Endif
			  
					While !Eof() .And. Eval(xWhile)
						If Empty(SF3->F3_DTCANC)
							//���������������������������������������������������������������Ŀ
							//� Efetua a exclusao dos registros referente a Nota Fiscal no SFT�
							//�����������������������������������������������������������������
							If AliasInDic("SFT")
								dbSelectArea("SFT")
								dbSetOrder(3)
								MsSeek(xFilial("SFT")+"S"+SF3->F3_CLIEFOR+SF3->F3_LOJA+SF3->F3_SERIE+SF3->F3_NFISCAL+SF3->F3_IDENTFT)
								While !Eof() .And.;
									xFilial("SFT")+"S"+SF3->F3_CLIEFOR+SF3->F3_LOJA+SF3->F3_SERIE+SF3->F3_NFISCAL+SF3->F3_IDENTFT==;
									xFilial("SFT")+"S"+SFT->FT_CLIEFOR+SFT->FT_LOJA+SFT->FT_SERIE+SFT->FT_NFISCAL+SFT->FT_IDENTF3
									//
									RecLock('SFT',.F.,.T.)
										dbDelete()
									MsUnlock()
									FkCommit()
									//
									dbSelectArea("SFT")
									dbSkip()
								EndDo
							EndIf
							//���������������������������������������������������������������Ŀ
							//� Efetua a exclusao dos registros referente a Nota Fiscal no SF3�
							//�����������������������������������������������������������������
							RecLock('SF3',.F.,.T.)
							dbDelete()
							MsUnlock()
							FkCommit()
						EndIf
						dbSelectArea("SF3")
						dbSkip()
					EndDo

					//���������������������������������������������������������Ŀ
					//� Inicializa a gravacao nas funcoes Fiscais               �
					//�����������������������������������������������������������
					MaFisWrite()
					//���������������������������������������������������������Ŀ
					//� Efetua a gravacao dos registros referente a Nota no SF3 �
					//�����������������������������������������������������������
					MaFisAtuSF3(1,"S",IIf(lQuery,(cAlias)->SF2RECNO,SF2->(RecNo())),cAlias,(cAlias)->F2_PDV,cCNAE,"MATA930",, cCodSef)	 

					dbSelectArea("CDA")
					dbSetOrder(1)
					MsSeek(xFilial("CDA")+(cAlias)->("S"+F2_ESPECIE+"S"+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA))	
						if CDA->CDA_CALPRO == "2"//N�o reprocessa La�amento Manual, apenas feito via TES.	
							lRefaz := .F.
						EndIf
		           if lRefaz
				   		MAFISCDA(,,.T.,(cAlias)->("S"+F2_ESPECIE+"S"+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA),(cAlias)->F2_FORMUL,cAlias)
				   		MAFISCDA(,2,,(cAlias)->("S"+F2_ESPECIE+"S"+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA),(cAlias)->F2_FORMUL,cAlias)
				    EndIf	

					
					If lGerValor .AND. lFisLivro .AND. cPaisLoc == "BRA" .AND. cOrigLan == "LO" 
						
						DBSelectArea("SF2") 
						DBSetOrder(1)
						Lj7GeraSL( "SF2", aSF2Back, .F., .T.)           //Retorna os valores da SF2 
					 	
					 	nRecAntSD2 := SD2->(Recno())                    //Guarda o ultimo recno da SD2
					   	For  nInd := 1 to Len(aSD2Back)                 //Retorna os valores da SD2
							SD2->( dbGoTo ( aSD2Back[nInd][1] ) )
	   				   		Lj7GeraSL( "SD2", aSD2Back[nInd][2], .F., .T.)
	   					Next nInd 
	   					 
	   					SD2->( dbGoTo ( nRecAntSD2 ) )
	   					
   			       	EndIf  
					//���������������������������������������������������Ŀ
					//� Ponto de entrada, na gravacao do livro            �
					//� fiscal															�
					//�����������������������������������������������������
					If ExistBlock("MT930SF3")
						dbSelectArea("SF3")
						dbSetOrder(1)
						MsSeek(xFilial("SF3")+Dtos((cAlias)->F2_EMISSAO)+(cAlias)->F2_DOC+(cAlias)->F2_SERIE+(cAlias)->F2_CLIENTE+(cAlias)->F2_LOJA+"5",.T.)
						ExecBlock("MT930SF3",.F.,.F.)
					EndIf
				End Transaction
			EndIf
		EndIf
		dbSelectArea(cAlias)
		dbSkip()
		If !lAuto
			oObj:IncRegua2(STR0006+" "+Dtoc((cAlias)->F2_EMISSAO)+" "+STR0007+" "+(cAlias)->F2_SERIE+"-"+(cAlias)->F2_DOC)
		Endif
	EndDo
	SM0->(dbSkip())
	If lQuery
		dbSelectArea(cAlias)
		dbCloseArea()
		dbSelectArea("SF2")	
	Else
		dbSelectArea("SF2")
		RetIndex("SF2")
	EndIf
Enddo
	
//������������������������������������������Ŀ
//�Volta a empresa anteriormente selecionada.�
//��������������������������������������������
dbSelectArea("SM0")
SM0->(dbSeek(cEmpAnt+cFilOri,.T.))
cFilAnt := FWCodFil()

Return .T.

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AjustaSX1 �Autor  �Mary C. Hergert     � Data � 28/02/2005  ���
�������������������������������������������������������������������������͹��
���Desc.     �Ajusta grupo de perguntas                                   ���
�������������������������������������������������������������������������͹��
���Uso       |MATA930                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function AjustaSX1()    

Local aArea := GetArea()
Local aHelpP  := {}
Local aHelpE  := {}
Local aHelpS  := {}  
Local nTamSx1Grp :=Len(SX1->X1_GRUPO)

// mv_par12 - Da Filial?
Aadd( aHelpP, "Informe a filial inicial para o         " )
Aadd( aHelpP, "reprocessamento.                        " )
Aadd( aHelpP, "                                        " )
Aadd( aHelpE, "Informe a filial inicial para o         " )
Aadd( aHelpE, "reprocessamento.                        " )
Aadd( aHelpE, "                                        " )
Aadd( aHelpS, "Informe a filial inicial para o         " )
Aadd( aHelpS, "reprocessamento.                        " )
Aadd( aHelpS, "                                        " )
PutSX1("MTA930"	,"12","Da Filial","Da Filial","Da Filial","mv_chc","C",2,0,0,"G"," "," "," "," ","mv_par12"," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," ",aHelpP,aHelpE,aHelpS) 

// mv_par13 - Ate Filial?
Aadd( aHelpP, "Informe a filial final para o           " )
Aadd( aHelpP, "reprocessamento.                        " )
Aadd( aHelpP, "                                        " )
Aadd( aHelpE, "Informe a filial final para o           " )
Aadd( aHelpE, "reprocessamento.                        " )
Aadd( aHelpE, "                                        " )
Aadd( aHelpS, "Informe a filial final para o           " )
Aadd( aHelpS, "reprocessamento.                        " )
Aadd( aHelpS, "                                        " )
PutSX1("MTA930"	,"13","Ate a Filial","Ate a Filial","Ate a Filial","mv_chd","C",2,0,0,"G"," "," "," "," ","mv_par13"," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," ",aHelpP,aHelpE,aHelpS) 

If SX1->(dbSeek(PadR("MTA930",nTamSx1Grp)+"12")) .And. SX1->(AllTrim(X1_F3)<>"XM0" .Or. AllTrim(X1_GRPSXG)<>"033")
	RecLock("SX1",.F.)
		SX1->X1_F3		:=	"XM0"
		SX1->X1_GRPSXG	:=	"033"
	MsUnlock()
EndIf

If SX1->(dbSeek(PadR("MTA930",nTamSx1Grp)+"13")) .And. SX1->(AllTrim(X1_F3)<>"XM0" .Or. AllTrim(X1_GRPSXG)<>"033")
	RecLock("SX1",.F.)
		SX1->X1_F3		:=	"XM0"
		SX1->X1_GRPSXG	:=	"033"
	MsUnlock()
EndIf

// mv_par03 - Livro De?
DbSelectArea("SX1")
DbSetOrder(1)

If SX1->(DbSeek(PadR("MTA930",nTamSx1Grp)+"03"))
	If Empty(X1_DEF03)
		RecLock("SX1",.F.)
		Replace X1_DEF03	With "Ambos"
		Replace X1_DEFSPA3	With "Ambas"
		Replace X1_DEFENG3	With "Both"
		Replace X1_PRESEL	With 3
		MsUnLock()
		DbCommit()
	Endif
Endif

// mv_par08 - Cliente De/Ate
DbSelectArea("SXG")
DbSetOrder(1)
If SXG->(DbSeek("001"))
	DbSelectArea("SX1")
	DbSetOrder(1)	
	If SX1->(DbSeek(PadR("MTA930",nTamSx1Grp)+"08"))
		If SX1->X1_TAMANHO <> SXG->XG_SIZE 
			RecLock("SX1",.F.)
			Replace X1_TAMANHO	With SXG->XG_SIZE 
			MsUnLock()
			DbCommit()
		Endif
	Endif
	If SX1->(DbSeek(PadR("MTA930",nTamSx1Grp)+"09"))
		If SX1->X1_TAMANHO <> SXG->XG_SIZE 
			RecLock("SX1",.F.)
			Replace X1_TAMANHO	With SXG->XG_SIZE 
			MsUnLock()
			DbCommit()
		Endif
	Endif	
EndIf

RestArea(aArea)
Return()

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Ma930Param�Autor  �Rodrigo Zatt        � Data �  12/18/07   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao para verificar perguntas                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � MATA930                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Ma930Param(oSelf,lAutoA930,lAuto,aPergA930)
Default	aPergA930	:=	{}

	If  lAutoA930
		mv_par01	:= IIF(Len(aPergA930) >= 1 ,ctod(aPergA930[1]),ctod("//"))
		mv_par02	:= IIF(Len(aPergA930) >= 2 ,ctod(aPergA930[2]),ctod("//"))
		mv_par03	:= IIF(Len(aPergA930) >= 3 ,aPergA930[3] ,"")
		mv_par04	:= IIF(Len(aPergA930) >= 4 ,aPergA930[4] ,"")
		mv_par05	:= IIF(Len(aPergA930) >= 5 ,aPergA930[5] ,"")
		mv_par06	:= IIF(Len(aPergA930) >= 6 ,aPergA930[6] ,"")
		mv_par07	:= IIF(Len(aPergA930) >= 7 ,aPergA930[7] ,"")
		mv_par08	:= IIF(Len(aPergA930) >= 8 ,aPergA930[8] ,"")
		mv_par09	:= IIF(Len(aPergA930) >= 9 ,aPergA930[9] ,"")
		mv_par10	:= IIF(Len(aPergA930) >= 10,aPergA930[10],"")
		mv_par11	:= IIF(Len(aPergA930) >= 11,aPergA930[11],"")
	EndIf

	//�����������������������������������������������������������������������������������Ŀ
	//�Verifco a cPaisLoc, versao, parametro, e campos referente ao Historico de Operacoes�
	//�Fiscais. Roadmap 11.7.                                                             �
	//�������������������������������������������������������������������������������������
	If cPaisLoc == "BRA" .And. GetNewPar("MV_HISTFIS", .F.) .And.  GetRpoRelease()>="R7" .And.;
		SF1->(FieldPos("F1_IDSA2"))>0 .And. SF1->(FieldPos("F1_IDSED"))>0 .And.;
		SF2->(FieldPos("F2_IDSA1"))>0 .And. SF2->(FieldPos("F2_IDSED"))>0 .And.;
		SD1->(FieldPos("D1_IDSF4"))>0 .And. SD1->(FieldPos("D1_IDSB1"))>0 .And.;
		SD1->(FieldPos("D1_IDSBZ"))>0 .And. SD1->(FieldPos("D1_IDSF7"))>0 .And.;
		SD2->(FieldPos("D2_IDSF4"))>0 .And. SD2->(FieldPos("D2_IDSB1"))>0 .And.;
		SD2->(FieldPos("D2_IDSBZ"))>0 .And. SD2->(FieldPos("D2_IDSF7"))>0
		
		Pergunte("MTA930",.F.)
		lHistFis := Iif(MV_PAR14==1,.T.,.F.)
	EndIf


	If FisChkDt(mv_par01) .And. FisChkDt(mv_par02)
		If (mv_par03  == 2) .Or. (mv_par03  == 3)
			If lAutoA930
				If cPaisLoc <> "BRA"
					DelSaiRem(lAutoA930)
					A930RPSaida(lAutoA930)
				ElseIf cPaisLoc == "BRA"
					A930RPSaida(lAutoA930)
				EndIf
			Else
				If cPaisLoc <> "BRA"
					oObj := MsNewProcess():New({|lEnd| DelSaiRem(lAutoA930,oObj)},"","",.F.)
					oObj:Activate()
					oObj := MsNewProcess():New({|lEnd| A930RPSaida(lAutoA930,oObj)},"","",.F.)
					oObj:Activate()
				ElseIf cPaisLoc == "BRA"
					oObj := MsNewProcess():New({|lEnd| A930RPSaida(lAutoA930,oObj)},"","",.F.)
					oObj:Activate()
				EndIf
			EndIf
		Endif	
		If (mv_par03  == 1) .Or. (mv_par03  == 3)
			If lAutoA930
				If cPaisLoc <> "BRA"
					DelEntRem(lAutoA930)
					A930RPEntrada(lAutoA930)
				ElseIf cPaisLoc == "BRA"
					A930RPEntrada(lAutoA930)
				EndIf
			Else
				If cPaisLoc <> "BRA"
					oObj := MsNewProcess():New({|lEnd| DelEntRem(lAutoA930,oObj)},"","",.F.)
					oObj:Activate()
					oObj := MsNewProcess():New({|lEnd| A930RPEntrada(lAutoA930,oObj)},"","",.F.)
					oObj:Activate()
				ElseIf cPaisLoc == "BRA"
					oObj := MsNewProcess():New({|lEnd| A930RPEntrada(lAutoA930,oObj)},"","",.F.)
					oObj:Activate()
				EndIf
			EndIf
		EndIf
	EndIf
Return(.T.)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �A930LjDelF�Autor  �Microsiga           � Data � 08/05/2008  ���
�������������������������������������������������������������������������͹��
���Desc.     � Deleta o SF3 no periodo informado nos parametros mv_par01  ���
���          � e mv_par02 para Mapa Resumo.                               ���
�������������������������������������������������������������������������͹��
���Uso       � MATA930                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function A930LjDelF3()

Local dDataIni 	:= mv_par01				// Data inicial 
Local dDataFim 	:= mv_par02				// Data final
Local lExistSFT := AliasInDic("SFT")	// Se existe o SFT
Local aArea		:= GetArea()			// Guarda a area corrente

While dDataIni <= dDataFim
	DbSelectArea("SF3")
	DbSetOrder(1)
	If DbSeek(xFilial()+DTOS(dDataIni),.T.)
	
		If FWModeAccess("SF3",3)=="C" .And. SF3->(FieldPos("F3_MSFIL")) > 0
			xWhile := "F3_MSFIL == xFilial('SF3')"
		Else
			xWhile := "F3_FILIAL == xFilial('SF3')"
		Endif
		xWhile := &('{||'+xWhile+'}')
		
		While !Eof() .And. Eval(xWhile) .AND. !SF3->(EOF()) ;
			.AND. SF3->F3_ENTRADA >= dDataIni ;
			.AND. SF3->F3_ENTRADA <= dDataFim
			
			If SF3->F3_SERIE == "ECF" .AND. !Empty( F3_PDV ) .AND. Alltrim( SF3->F3_OBSERV ) <> "NF CANCELADA"
				SF3->(RecLOCK("SF3",.F.))
				SF3->(dbDelete())
				SF3->(MsUnlock())
			EndIf
			SF3->(DbSkip())
		End
	EndIf
	//��������������������������������������������������������
	//�Apos deletar o registro no SF3, deleta os itens no SFT�
	//��������������������������������������������������������
	If lExistSFT
		DbSelectArea("SFT")
		DbSetOrder(2)
		If DbSeek(xFilial("SFT") + "S" + DTOS(dDataIni),.T.)

			If FWModeAccess("SFT",3)=="C" .And. SFT->(FieldPos("FT_MSFIL")) > 0
				xWhile := "FT_MSFIL == xFilial('SFT') "
			Else
				xWhile := "FT_FILIAL == xFilial('SFT') "
			Endif
			xWhile := &('{||'+xWhile+'}')
			
			While !Eof() .And. Eval(xWhile) .AND. !SFT->(EOF()) ;
				.AND. SFT->FT_ENTRADA >= dDataIni ;
				.AND. SFT->FT_ENTRADA <= dDataFim
					
				If SFT->FT_SERIE == "ECF" .AND. !Empty( SFT->FT_PDV ) .AND. Alltrim( SFT->FT_OBSERV ) <> "NF CANCELADA" 

					RecLock("SFT",.F.)
					dbDelete()
					MsUnlock()

				EndIf
				DbSkip()
			End
		EndIf
	EndIf
	dDataIni++
End

RestArea(aArea)

Return NIL
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �DelEntRem �Autor  �Cleber Stenio Alves � Data � 19/05/2009  ���
�������������������������������������������������������������������������͹��
���Desc.     � Deleta os Remitos de Entrada existentes no SF3             ���
�������������������������������������������������������������������������͹��
���Uso       � MATA930                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function DelEntRem(lAuto,oObj)

Local cQuery      	:= ""
Local cAlias      	:= "SF1"
Local cIndex      	:= ""
Local lQuery      	:= .F.
Local cFilOri		:= FWCodFil()
Local cFilIni 		:= Iif(Empty(MV_PAR12),cFilAnt,MV_PAR12)
Local cFilFin 		:= Iif(Empty(MV_PAR13),cFilAnt,MV_PAR13)

#IFDEF TOP
	Local nX          := 0
	Local aStru       := {}
#ENDIF		

//���������������������������������������������������������������������������������
//�Quando � automatico, efetua o reprocessamento apenas da filial atual -> CFILANT�
//���������������������������������������������������������������������������������
If lAuto
	cFilIni := cFilAnt
	cFilFin := cFilAnt
Endif

dbSelectArea("SM0")
SM0->(dbSeek(cEmpAnt+cFilIni,.T.))
If !lAuto
   oObj:SetRegua1(SM0->(LastRec()))
Endif   
	
While ! SM0->(Eof()) .And. FWGrpCompany() == cEmpAnt .And. FWCodFil() <= cFilFin

	If !lAuto
	   oObj:IncRegua1(AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL)
	Endif   
	
	cFilAnt 	:= FWCodFil()
	#IFDEF TOP
		aStru		:= {}
	#ENDIF
	cQuery		:= ""
   	cAlias		:= "SF1"
	cIndex		:= ""
	lQuery		:= .F.
	nX			:= 0

	dbSelectArea("SF1")
	dbSetOrder(1)
	#IFDEF TOP
		If ( TcSrvType()!="AS/400" )
			lQuery := .T.
			cAlias := GetNextAlias()
			aStru  := SF1->(dbStruct())
			cQuery := "SELECT SF1.*"
			cQuery += "FROM "+RetSqlName("SF1")+" SF1, " + RetSqlName("SF3")+" SF3 "

			If FWModeAccess("SF1",3)=="C" .And. SF1->(FieldPos("F1_MSFIL")) > 0			
				cQuery += "WHERE SF1.F1_MSFIL='"+cFilAnt+"' AND "
			Else	
				cQuery += "WHERE SF1.F1_FILIAL='"+xFilial("SF1")+"' AND "
			EndIf
			
			If FWModeAccess("SF3",3)=="C" .And. SF3->(FieldPos("F3_MSFIL")) > 0			
				cQuery += "SF3.F3_MSFIL='"+cFilAnt+"' AND "
			Else	
				cQuery += "SF3.F3_FILIAL='"+xFilial("SF3")+"' AND "
			EndIf

			cQuery +=       "SF1.F1_DOC>='"+MV_PAR04+"' AND "
			cQuery +=       "SF1.F1_DOC<='"+MV_PAR05+"' AND "
			cQuery +=       "SF1.F1_SERIE>='"+MV_PAR06+"' AND "
			cQuery +=       "SF1.F1_SERIE<='"+MV_PAR07+"' AND "
			cQuery +=       "SF1.F1_FORNECE>='"+MV_PAR08+"' AND "
			cQuery +=       "SF1.F1_FORNECE<='"+MV_PAR09+"' AND "
			cQuery +=       "SF1.F1_LOJA>='"+MV_PAR10+"' AND "
			cQuery +=       "SF1.F1_LOJA<='"+MV_PAR11+"' AND "
			cQuery +=       "SF1.F1_DTDIGIT>='"+DTOS(MV_PAR01)+"' AND "
			cQuery +=       "SF1.F1_DTDIGIT<='"+DTOS(MV_PAR02)+"' AND "
			cQuery +=       "SF1.F1_STATUS <> '' AND "
			cQuery +=       "("+IsRemito(3,'SF1.F1_TIPODOC')+ ") AND "
			cQuery +=       "SF1.F1_DOC = SF3.F3_NFISCAL AND "
			cQuery +=       "SF1.F1_SERIE = SF3.F3_SERIE AND "
			cQuery +=       "SF1.F1_FORNECE = SF3.F3_CLIEFOR AND "
			cQuery +=       "SF1.F1_LOJA = SF3.F3_LOJA AND "
			cQuery +=       "SF1.D_E_L_E_T_<>'*' AND SF3.D_E_L_E_T_<>'*'"
	
			cQuery := ChangeQuery(cQuery)
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias,.F.,.T.)	
			For nX := 1 To Len(aStru)
				If aStru[nX][2]<>"C"
					TcSetField(cAlias,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
				EndIf
			Next nX
		Else
	#ENDIF
			
		If FWModeAccess("SF1",3)=="C" .And. SF1->(FieldPos("F1_MSFIL")) > 0			
			cQuery += "F1_MSFIL='"+cFilAnt+"'.AND."
		Else	
			cQuery += "F1_FILIAL='"+xFilial("SF1")+"'.AND."
		EndIf

		cQuery += "F1_DOC>='"+MV_PAR04+"'.AND."
		cQuery += "F1_DOC<='"+MV_PAR05+"'.AND."
		cQuery += "F1_SERIE>='"+MV_PAR06+"'.AND."
		cQuery += "F1_SERIE<='"+MV_PAR07+"'.AND."
		cQuery += "F1_FORNECE>='"+MV_PAR08+"'.AND."
		cQuery += "F1_FORNECE<='"+MV_PAR09+"'.AND."
		cQuery += "F1_LOJA>='"+MV_PAR10+"'.AND."
		cQuery += "F1_LOJA<='"+MV_PAR11+"' .AND."
		cQuery += "DTOS(F1_DTDIGIT)>='"+DTOS(MV_PAR01)+"'.AND."
		cQuery += "DTOS(F1_DTDIGIT)<='"+DTOS(MV_PAR02)+"'.AND."
		cQuery += "("+IsRemito(2,'F1_TIPODOC')+") .AND."
    	cQuery += "!EMPTY(F1_STATUS)"
		
		cIndex := CriaTrab(,.F.)
		IndRegua("SF1",cIndex,IndexKey(),,cQuery)
		#IFDEF TOP
		EndIf
		#ENDIF
	
	dbSelectArea(cAlias)
	(cAlias)->(DbGoTop())
	If !lAuto
	   oObj:SetRegua2(SF1->(LastRec()))
	Endif   
    SF3->(dbSetOrder(1))
	While !(cAlias)->(Eof())
		If SF3->(MsSeek(xFilial("SF3")+Dtos((cAlias)->F1_DTDIGIT)+(cAlias)->F1_DOC+(cAlias)->F1_SERIE+(cAlias)->F1_FORNECE+(cAlias)->F1_LOJA))
		   	If Empty(SF3->F3_DTCANC)
				//���������������������������������������������������������������Ŀ
				//� Efetua a exclusao dos registros referente a Nota Fiscal no SF3�
				//�����������������������������������������������������������������
				RecLock('SF3',.F.,.T.)
				SF3->(dbDelete())
				SF3->(MsUnlock())
				SF3->(FkCommit())
			EndIf
        EndIf
		(cAlias)->(dbSkip())
	EndDo
	If !lAuto
		oObj:IncRegua2(STR0006+" "+Dtoc((cAlias)->F1_DTDIGIT)+" "+STR0007+" "+(cAlias)->F1_SERIE+"-"+(cAlias)->F1_DOC)		
	EndIf
	SM0->(dbSkip())
	If ( lQuery )
		dbSelectArea(cAlias)
		dbCloseArea()
		dbSelectArea("SF1")
	Else
		dbSelectArea("SF1")
		RetIndex("SF1")
	EndIf
Enddo
	
//������������������������������������������Ŀ
//�Volta a empresa anteriormente selecionada.�
//��������������������������������������������
dbSelectArea("SM0")
SM0->(dbSeek(cEmpAnt+cFilOri,.T.))
cFilAnt := FWCodFil()

Return( .T. )

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �DelSaiRem �Autor  �Cleber Stenio Alves � Data � 19/05/2009  ���
�������������������������������������������������������������������������͹��
���Desc.     � Deleta os Remitos de Saida existentes no SF3               ���
�������������������������������������������������������������������������͹��
���Uso       � MATA930                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function DelSaiRem(lAuto,oObj)

Local cQuery      	:= ""
Local cAlias      	:= "SF2"
Local cIndex      	:= ""
Local lQuery      	:= .F.
Local cFilOri		:= FWCodFil()
Local cFilIni 		:= Iif(Empty(MV_PAR12),cFilAnt,MV_PAR12)
Local cFilFin 		:= Iif(Empty(MV_PAR13),cFilAnt,MV_PAR13)

#IFDEF TOP
	Local nX          := 0
	Local aStru       := {}
#ENDIF		

//���������������������������������������������������������������������������������
//�Quando � automatico, efetua o reprocessamento apenas da filial atual -> CFILANT�
//���������������������������������������������������������������������������������
If lAuto
	cFilIni := cFilAnt
	cFilFin := cFilAnt
Endif

dbSelectArea("SM0")
SM0->(dbSeek(cEmpAnt+cFilIni,.T.))
If !lAuto
   oObj:SetRegua1(SM0->(LastRec()))
Endif   
	
While ! SM0->(Eof()) .And. FWGrpCompany() == cEmpAnt .And. FWCodFil() <= cFilFin

	If !lAuto
	   oObj:IncRegua1(AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL)
	Endif   
	
	cFilAnt 	:= FWCodFil()
	#IFDEF TOP
		aStru		:= {}
	#ENDIF
	cQuery		:= ""
   	cAlias		:= "SF2"
	cIndex		:= ""
	lQuery		:= .F.
	nX			:= 0

	dbSelectArea("SF2")
	dbSetOrder(1)
	#IFDEF TOP
		If ( TcSrvType()!="AS/400" )
			lQuery := .T.
			cAlias := "MA930GRVQ1"
			aStru  := SF2->(dbStruct())
			cQuery := "SELECT SF2.*,SF2.R_E_C_N_O_  SF2RECNO "
			cQuery += "FROM "+RetSqlName("SF2")+" SF2, " + RetSqlName("SF3")+" SF3 "

			If FWModeAccess("SF2",3)=="C" .And. SF2->(FieldPos("F2_MSFIL")) > 0			
				cQuery += "WHERE SF2.F2_MSFIL='"+cFilAnt+"' AND "
			Else	
				cQuery += "WHERE SF2.F2_FILIAL='"+xFilial("SF2")+"' AND "
			EndIf
			
			If FWModeAccess("SF3",3)=="C" .And. SF3->(FieldPos("F3_MSFIL")) > 0			
				cQuery += "SF3.F3_MSFIL='"+cFilAnt+"' AND "
			Else	
				cQuery += "SF3.F3_FILIAL='"+xFilial("SF3")+"' AND "
			EndIf

			cQuery +=       "SF2.F2_DOC>='"+MV_PAR04+"' AND "
			cQuery +=       "SF2.F2_DOC<='"+MV_PAR05+"' AND "
			cQuery +=       "SF2.F2_SERIE>='"+MV_PAR06+"' AND "
			cQuery +=       "SF2.F2_SERIE<='"+MV_PAR07+"' AND "
			cQuery +=       "SF2.F2_CLIENTE>='"+MV_PAR08+"' AND "
			cQuery +=       "SF2.F2_CLIENTE<='"+MV_PAR09+"' AND "
			cQuery +=       "SF2.F2_LOJA>='"+MV_PAR10+"' AND "
			cQuery +=       "SF2.F2_LOJA<='"+MV_PAR11+"' AND "
			cQuery +=       "SF2.F2_EMISSAO>='"+DTOS(MV_PAR01)+"' AND "
			cQuery +=       "SF2.F2_EMISSAO<='"+DTOS(MV_PAR02)+"' AND "
			cQuery +=       "("+IsRemito(3,'SF2.F2_TIPODOC')+ ") AND "
			cQuery +=       "SF2.F2_DOC = SF3.F3_NFISCAL AND "
			cQuery +=       "SF2.F2_SERIE = SF3.F3_SERIE AND "
			cQuery +=       "SF2.F2_CLIENTE = SF3.F3_CLIEFOR AND "
			cQuery +=       "SF2.F2_LOJA = SF3.F3_LOJA AND "
			cQuery +=       "SF2.D_E_L_E_T_<>'*' AND SF3.D_E_L_E_T_<>'*'"
	
			cQuery := ChangeQuery(cQuery)
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias,.T.,.T.)	
			For nX := 1 To Len(aStru)
				If aStru[nX][2]<>"C"
					TcSetField(cAlias,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
				EndIf
			Next nX
		Else
	#ENDIF
			
		If FWModeAccess("SF2",3)=="C" .And. SF2->(FieldPos("F2_MSFIL")) > 0			
			cQuery += "F2_MSFIL='"+cFilAnt+"'.AND."
		Else	
			cQuery += "F2_FILIAL='"+xFilial("SF2")+"'.AND."
		EndIf
				
		cQuery += "F2_DOC>='"+MV_PAR04+"'.AND."
		cQuery += "F2_DOC<='"+MV_PAR05+"'.AND."
		cQuery += "F2_SERIE>='"+MV_PAR06+"'.AND."
		cQuery += "F2_SERIE<='"+MV_PAR07+"'.AND."
		cQuery += "F2_CLIENTE>='"+MV_PAR08+"'.AND."
		cQuery += "F2_CLIENTE<='"+MV_PAR09+"'.AND."
		cQuery += "F2_LOJA>='"+MV_PAR10+"'.AND."
		cQuery += "F2_LOJA<='"+MV_PAR11+"' .AND."
		cQuery += "DTOS(F2_EMISSAO)>='"+DTOS(MV_PAR01)+"'.AND."
		cQuery += "DTOS(F2_EMISSAO)<='"+DTOS(MV_PAR02)+"'.AND."
		cQuery += "("+IsRemito(2,'F2_TIPODOC')+")"
		
		cIndex := CriaTrab(,.F.)
		IndRegua("SF2",cIndex,IndexKey(),,cQuery)
		#IFDEF TOP
		EndIf
		#ENDIF
	
	dbSelectArea(cAlias)
	(cAlias)->(DbGoTop())
	If !lAuto
	   oObj:SetRegua2(SF2->(LastRec()))
	Endif   

	SF3->(dbSetOrder(1))
	While !(cAlias)->(Eof())
		If SF3->(MsSeek(xFilial("SF3")+Dtos((cAlias)->F2_EMISSAO)+(cAlias)->F2_DOC+(cAlias)->F2_SERIE+(cAlias)->F2_CLIENTE+(cAlias)->F2_LOJA))
		   	If Empty(SF3->F3_DTCANC)
				//���������������������������������������������������������������Ŀ
				//� Efetua a exclusao dos registros referente a Nota Fiscal no SF3�
				//�����������������������������������������������������������������
				RecLock('SF3',.F.,.T.)
				SF3->(dbDelete())
				SF3->(MsUnlock())
				SF3->(FkCommit())
			EndIf
        EndIf
		(cAlias)->(dbSkip())
	EndDo
	If !lAuto
		oObj:IncRegua2(STR0006+" "+Dtoc((cAlias)->F2_EMISSAO)+" "+STR0007+" "+(cAlias)->F2_SERIE+"-"+(cAlias)->F2_DOC)		
	EndIf
		
	SM0->(dbSkip())
	If ( lQuery )
		dbSelectArea(cAlias)
		dbCloseArea()
		dbSelectArea("SF2")
	Else
		dbSelectArea("SF2")
		RetIndex("SF2")
	EndIf
Enddo
	
//������������������������������������������Ŀ
//�Volta a empresa anteriormente selecionada.�
//��������������������������������������������
dbSelectArea("SM0")
SM0->(dbSeek(cEmpAnt+cFilOri,.T.))
cFilAnt := FWCodFil()

Return( .T. )
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �A930LjGrava �Autor  �Vendas e CRM        � Data � 22/03/2009���
�������������������������������������������������������������������������͹��
���Desc.     � Faz o backup e zera os valores do array                    ���
�������������������������������������������������������������������������͹��
���Uso       � MATA930                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/ 

Static Function A930LjGrava( cAlias, aArrayBack, aArrayZero) 

Local aEstruAlias   := {}                                  // Variavel com a estrutura da array 
Local nCount        := 0                                   // Variavel contador
Local nZera         := 0                                   // Zerador 
Local lRet          := .T.                                 // Retorno 
	
aAdd(aArrayBack, {0,{}})
aAdd(aArrayZero, {0,{}})
aEstruAlias  := (cAlias)->(DbStruct())
For nCount := 1 To Len(aEstruAlias)
	If aEstruAlias[nCount,2] == "N"
		aAdd(aArrayBack[Len(aArrayBack)][2],{aEstruAlias[nCount,1], (cAlias)->&(aEstruAlias[nCount,1]) })  
		aAdd(aArrayZero[Len(aArrayZero)][2],{aEstruAlias[nCount,1], nZera })    
	EndIf
Next nCount   
	 
Return lRet	

USER FUNCTION AxAltera(cAlias,nReg,nOpc,aAcho,aCpos,nColMens,cMensagem,cTudoOk,cTransact,cFunc,;
				aButtons,aParam,aAuto,lVirtual,lMaximized,cTela,lPanelFin,oFather,aDim,uArea,lFlat)

Local aArea    := GetArea(cAlias)
Local aPosEnch := {}
Local bCampo   := {|nCPO| Field(nCPO) }
Local bOk      := Nil
Local bOk2     := {|| .T.}
Local cCpoFil  := PrefixoCpo(cAlias)+"_FILIAL"
Local cMemo    := ""
Local nOpcA    := 0
Local nX       := 0
Local oDlg
Local nTop
Local nLeft
Local nBottom
Local nRight
Local cAliasMemo
Local bEndDlg := {|lOk| lOk:=oDlg:End(), nOpcA:=1, lOk}
Local oEnc01
Local oSize

Private aTELA[0][0]
Private aGETS[0]

DEFAULT lVirtual:= .F.
DEFAULT cTudoOk := ".T."
DEFAULT nReg    := (cAlias)->(RecNO())
DEFAULT bOk := &("{|| "+cTudoOk+"}")
DEFAULT lPanelFin := .F.
DEFAULT lFlat := .F.

//�������������������������������������������������������������������Ŀ
//� Processamento de codeblock de validacao de confirmacao            �
//���������������������������������������������������������������������
If !Empty(aParam)
	bOk2 := aParam[2]
EndIf	
//����������������������������������������������������������������������Ŀ
//�VerIfica se esta' alterando um registro da mesma filial               �
//������������������������������������������������������������������������
DbSelectArea(cAlias)
If (cAlias)->(FieldPos(cCpoFil))==0 .Or. (cAlias)->(FieldGet(FieldPos(cCpoFil))) == xFilial(cAlias)
	//��������������������������������������������������������������Ŀ
	//� Monta a entrada de dados do arquivo						     �
	//����������������������������������������������������������������	
	If SoftLock(cAlias)
		RegToMemory(cAlias,.F.,lVirtual)
		//�������������������������������������������������������������������Ŀ
		//� Inicializa variaveis para campos Memos Virtuais		 			  �
		//���������������������������������������������������������������������
		If Type("aMemos")=="A"
			For nX:=1 to Len(aMemos)
				cMemo := aMemos[nX][2]
				If ExistIni(cMemo)
					&cMemo := InitPad(SX3->X3_RELACAO)
				Else
					&cMemo := ""
				EndIf
			Next nX
		EndIf
		//�������������������������������������������������������������������Ŀ
		//� Inicializa variaveis para campos Memos Virtuais		 			  �
		//���������������������������������������������������������������������
		If ( ValType( cFunc ) == 'C' )
		    If ( !("(" $ cFunc) )
			   cFunc+= "()"
			EndIf
			&cFunc
		EndIf
		//�������������������������������������������������������������������Ŀ
		//� Processamento de codeblock de antes da interface                  �
		//���������������������������������������������������������������������
		If !Empty(aParam)
			Eval(aParam[1],nOpc)
		EndIf		
		//������������������������������������������������������Ŀ
		//� Envia para processamento dos Gets				   	 �
		//��������������������������������������������������������
		If aAuto == Nil
		   If !lPanelFin .AND. !lFlat
		   
				//���������������������������������������������������������������������������Ŀ
				//� Calcula as dimensoes dos objetos                                          �
				//�����������������������������������������������������������������������������
				oSize := FwDefSize():New( .T. ) // Com enchoicebar
				
				oSize:lLateral     := .F.  // Calculo vertical 
				
				//������������������������������������������������������������������������Ŀ
				//� Cria Enchoice                                                          �
				//��������������������������������������������������������������������������
				oSize:AddObject( "ENCHOICE", 100, 60, .T., .T. ) // Adiciona enchoice
				
				//������������������������������������������������������������������������Ŀ
				//� Dispara o calculo                                                      �
				//��������������������������������������������������������������������������
				oSize:Process() 
				
				nTop    := oSize:aWindSize[1]
				nLeft   := oSize:aWindSize[2]
				nBottom := oSize:aWindSize[3]
				nRight  := oSize:aWindSize[4]
								
				If FindFunction("ISPDA").and. IsPDA()
					nTop := 0
					nLeft := 0
					nBottom := PDABOTTOM
					nRight  := PDARIGHT
				EndIf
				// Build com corre��o no tratamento dos controles pendentes na dialog ao executar o m�todo End()
				If GetBuild() >= "7.00.060302P" 
					bEndDlg := {|lOk| If(lOk:=oDlg:End(),nOpcA:=1,nOpcA:=3), lOk}
				EndIf
	
				DEFINE MSDIALOG oDlg TITLE cCadastro FROM nTop,nLeft TO nBottom,nRight PIXEL OF oMainWnd	
	
				If lMaximized <> NIL
					oDlg:lMaximized := lMaximized
				EndIf
	
				If FindFunction("ISPDA").and. IsPDA()
					oEnc01:= MsMGet():New( cAlias, nReg, nOpc,     ,"CRA",oemtoansi(STR0004),aAcho,  aPosEnch,aCpos, ,nColMens,If(nColMens != Nil,cMensagem,NIL),cTudoOk,,lVirtual,.t.,,,,,,,,, cTela) //"Quanto �s altera��es?"
					oEnc01:oBox:align := CONTROL_ALIGN_ALLCLIENT
				Else
					
					aPosEnch := {oSize:GetDimension("ENCHOICE","LININI"),;
						 oSize:GetDimension("ENCHOICE","COLINI"),;
						 oSize:GetDimension("ENCHOICE","LINEND"),;
						 oSize:GetDimension("ENCHOICE","COLEND")}
					
					If nColMens != Nil
						oEnc01:= MsMGet():New( cAlias, nReg, nOpc, ,"CRA",oemtoansi(STR0004),aAcho,aPosEnch,aCpos,,nColMens,cMensagem,cTudoOk,,lVirtual,,,,,,,,,, cTela) //"Quanto �s altera��es?"
					Else
						oEnc01:= MsMGet():New( cAlias, nReg, nOpc, ,"CRA",oemtoansi(STR0004),aAcho,aPosEnch,aCpos,,,,cTudoOk,,lVirtual,,,,,,,,,, cTela) //"Quanto �s altera��es?"
					EndIf
					oEnc01:oBox:align := CONTROL_ALIGN_ALLCLIENT
				EndIf
				ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| IIf(Obrigatorio(aGets,aTela).And.Eval(bOk).And.Eval(bOk2,nOpc),Eval(bEndDlg),(nOpcA:=3,.F.))},{|| nOpcA := 3,oDlg:End()},,aButtons,nReg,cAlias)
			Else

				DEFINE MSDIALOG ___oDlg OF oFather:oWnd  FROM 0, 0 TO 0, 0 PIXEL STYLE nOR( WS_VISIBLE, WS_POPUP )
		
				aPosEnch := {,,,}
				oEnc01:= MsMGet():New( cAlias, nReg, nOpc,,"CRA",oemtoansi(STR0004),aAcho,aPosEnch,aCpos,,,,cTudoOk,___oDlg  ,,lVirtual,.F.,,,,,,,,cTela) //"Quanto �s altera��es?"
				oEnc01:oBox:align := CONTROL_ALIGN_ALLCLIENT
					
				bEndDlg := {|lOk| If(lOk:=___oDlg:End(),nOpcA:=1,nOpcA:=3), lOk}

				// posiciona dialogo sobre a celula
				___oDlg:nWidth := aDim[4]-aDim[2]
				ACTIVATE MSDIALOG ___oDlg  ON INIT (FaMyBar(___oDlg,{|| If(Obrigatorio(aGets,aTela).And.Eval(bOk).And.Eval(bOk2,nOpc),Eval(bEndDlg),(nOpcA:=3,.f.))},{|| nOpcA := 3,___oDlg:End()},aButtons), ___oDlg:Move(aDim[1],aDim[2],aDim[4]-aDim[2], aDim[3]-aDim[1]) )

			Endif
		Else
			If EnchAuto(cAlias,aAuto,{|| Obrigatorio(aGets,aTela) .And. Eval(bOk).And.Eval(bOk2,nOpc)},nOpc,aCpos)
				nOpcA := 1
			EndIf
		EndIf
		(cAlias)->(MsGoTo(nReg))
		If nOpcA == 1
			Begin Transaction
				RecLock(cAlias,.F.)
				For nX := 1 TO FCount()
					FieldPut(nX,M->&(EVAL(bCampo,nX)))
				Next nX
				//�������������������������������������������������������������������Ŀ
				//�Grava os campos Memos Virtuais					  				  �
				//���������������������������������������������������������������������
				If Type("aMemos") == "A"
					For nX := 1 to Len(aMemos)
						cVar := aMemos[nX][2]
						cVar1:= aMemos[nX][1]
						//Inclu�do parametro com o nome da tabela de memos => para m�dulo APT
						cAliasMemo := If(len(aMemos[nX]) == 3,aMemos[nX][3],Nil)
						MSMM(&cVar1,TamSx3(aMemos[nX][2])[1],,&cVar,1,,,cAlias,aMemos[nX][1],cAliasMemo)
					Next nX
				EndIf
				If cTransact != Nil
					If !("("$cTransact)
						cTransact+="()"
					EndIf
					&cTransact
				EndIf
				//�������������������������������������������������������������������Ŀ
				//� Processamento de codeblock dentro da transacao                    �
				//���������������������������������������������������������������������
				If !Empty(aParam)
					Eval(aParam[3],nOpc)
				EndIf
			End Transaction
			//�������������������������������������������������������������������Ŀ
			//� Processamento de codeblock fora da transacao                      �
			//���������������������������������������������������������������������
			If !Empty(aParam)
				Eval(aParam[4],nOpc)
			EndIf
		EndIf
	Else
		nOpcA := 3
	EndIf
Else
	Help(" ",1,"A000FI")
	nOpcA := 3
EndIf
//�������������������������������������������������������������������Ŀ
//� Restaura a integridade dos dados                                  �
//���������������������������������������������������������������������
MsUnLockAll()
RestArea(aArea)

If lPanelFin
	FinVisual(cAlias,uArea,(cAlias)->(Recno()))
Endif	

Return(nOpcA)

User Function PRCSD2

Processa( { || U_Mata930(.T., { Dtoc(SF2->F2_EMISSAO), Dtoc(SF2->F2_EMISSAO), 2, SF2->F2_DOC, SF2->F2_DOC, SF2->F2_SERIE, SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_CLIENTE, SF2->F2_LOJA, SF2->F2_LOJA }) } )

Return