#INCLUDE "mata972.ch"
#INCLUDE "PROTHEUS.CH"
/*
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������ͻ��
���Programa  �MATA972   �Autor  �Andreia do Santos   ?Data ? 16/06/00    ��?
��������������������������������������������������������������������������͹��
���Desc.     �GIA Eletronica - Valida para a Secretaria da Fazenda do Es-  ��?
��?         �tado de Sao Paulo vigorando a partir da referencia julho/2000��?
��?         �a Nova GIA, contem em um unico documento as informacoes eco- ��?
��?         �nomico-fiscais de 5 documentos em 1: GIA, GIA-ST-11, GINTER, ��?
��?         �Zona Franca Manaus/ALC e DIPAM-B. Portaria CAT 46/2000.      ��?
��������������������������������������������������������������������������͹��
���Uso       ?AP5                                                         ��?
��������������������������������������������������������������������������ͼ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
*/
User Function MATA972(lAutomato)
//��������������������������������������������������������������Ŀ
//?Salva a Integridade dos dados de Entrada                     ?
//����������������������������������������������������������������
Local aSave:={Alias(),IndexOrd(),Recno()}

//��������������������������������������������������������������Ŀ
//?Define variaveis                                             ?
//����������������������������������������������������������������
Local	nOpc	:=	0
Local	oDlg
Local	cTitulo
Local	cText1
Local	cText2
Local	cText3
Local	aCAP		:= {STR0001,STR0002,STR0003} //"Confirma"###"Abandona"###"Par�metros"
Local	cTipoNf		:= ""
Local	aD1Imp		:= {}
Local	aD2Imp		:= {}
Local	nScanPis	:= 0
Local	nPosPis		:= 0
Local	nScanCof	:= 0
Local	nPosCof		:= 0
Local	cCampoCof	:= ""
Local	cCampoPis	:= ""

Default lAutomato := .F.

Private cPerg	:= "MTA972"
Private lEnd	:= .F.
Private cArqCabec
Private cArqCFO
Private cArqInt
Private cArqZFM
Private cArqOcor
Private cArqIE
Private cArqIeSt
Private cArqIeSd
Private cArqDIPAM
Private cCredAcum
Private cArqExpt
Private cIndSF3  := ""
Private nTipoReg := 0

//��������������������������������������������������������������Ŀ
//?Janela Principal                                             ?
//����������������������������������������������������������������
cTitulo	:=	STR0004 //"Arquivo Magn�tico"
cText1	:=	STR0005 //"Este programa gera arquivo pr?formatado dos lan�amentos fiscais"
cText2	:=	STR0006 //"para entrega as Secretarias de Fazenda Estaduais da Guia de  "
cText3	:=	STR0007 //"Informacao e Apuracao do ICMS (GIA )."

//��������������������������������������������������������������Ŀ
//?Verifica as perguntas selecionadas                           ?
//����������������������������������������������������������������
If !lAutomato
	Pergunte("MTA972",.T.)
EndIf

While .T.
	nOpc	:=	0
	DEFINE MSDIALOG oDlg TITLE OemtoAnsi(cTitulo) FROM  165,115 TO 315,525 PIXEL OF oMainWnd
	@ 03, 10 TO 43, 195 LABEL "" OF oDlg  PIXEL
	@ 10, 15 SAY OemToAnsi(cText1) SIZE 180, 8 OF oDlg PIXEL
	@ 20, 15 SAY OemToAnsi(cText2) SIZE 180, 8 OF oDlg PIXEL
	@ 30, 15 SAY OemToAnsi(cText3) SIZE 180, 8 OF oDlg PIXEL
	DEFINE SBUTTON FROM 50, 112 TYPE 5 ACTION (nOpc:=3,oDlg:End()) ENABLE OF oDlg
	DEFINE SBUTTON FROM 50, 141 TYPE 1 ACTION (nOpc:=1,oDlg:End()) ENABLE OF oDlg
	DEFINE SBUTTON FROM 50, 170 TYPE 2 ACTION (nOpc:=2,oDlg:End()) ENABLE OF oDlg

	If !lAutomato
		ACTIVATE MSDIALOG oDlg
		Pergunte(cPerg,.f.)
		Do Case
			Case nOpc==1
				Processa({||a972Processa()},,,@lEnd)
			Case nOpc==3
				Pergunte(cPerg,.t.)
				Loop
		EndCase
	Else
		Processa({||a972Processa(lAutomato)},,,@lEnd)
	EndIf

	Exit
End

//��������������������������������������������������������������Ŀ
//?Restaura area                                                ?
//����������������������������������������������������������������
dbSelectArea(aSave[1])
dbSetOrder(aSave[2])
dbGoto(aSave[3])

Return

/*
������������������������������������������������������������������������������?
������������������������������������������������������������������������������?
���������������������������������������������������������������������������ͻ�?
���Funcao	 �a972Processa�Autor  �Andreia dos Santos  ?Data ? 19/06/00   ��?
���������������������������������������������������������������������������͹�?
���Desc.     ?Faz o processamento de forma a montar os arquivos temporarios��?
��?         �para gerar gerar o arquivo texto final.                     	��?
���������������������������������������������������������������������������͹�?
���Uso       ?MATA972                                                    	��?
���������������������������������������������������������������������������ͼ�?
������������������������������������������������������������������������������?
������������������������������������������������������������������������������?
*/
Static Function a972Processa(lAutomato)
LOCAL aApuracao
Local cRef  := ""
Local lRet  := .F.
Local nX    := 0
Local lAglFil  := (mv_par22 == 1)   // A Vari�vel ?local para ser passada por par�metro na fun��o a972MontTrab, que ?chamada por outras rotinas.
Local lGerCR26 := (mv_par23 == 1)
Local lGerCR27 := (mv_par24 == 1)
Local aAlias   := {}
Local cArqTrb  := ""

Default lAutomato := .F.
/*
������������������������������������������������������������������������?
�Parametros															    ?
�mv_par01 - Data Inicial       ?     									?
�mv_par02 - Data Final         ?   										?
�mv_par03 - Tipo de GIA        ? (01-Normal/02-Substitutiva)			?
�mv_par04 - GIA com Movimento  ? (Sim/Nao)								?
�mv_par05 - GIA ja transmitida ? (Sim/Nao)								?
�mv_par06 - Saldo Credor - ST  ?    									?
�mv_par07 - Regime Tributario  ? (01-RPA/02-RES/03-RPA-DISPENSADO)     	?
�mv_par08 - Mes de Referencia  ?      									?
�mv_par09 - Ano de Referencia  ?      									?
�mv_par10 - Mes Ref. Inicial   ?      									?
�mv_par11 - Ano Ref. Inicial   ?      									?
�mv_par12 - Livro Selecionado  ?      									?
�mv_par13 - ICMS Fixado para o periodo?									?
�mv_par14 - Nome do arquivo    ?										?
�mv_par15 - Vers�o do Validador?										?
�mv_par16 - Vers�o do Layout   ?    									?
�mv_par17 - Drive Destino                                               ?
�mv_par18 - Filial De                                                   ?
�mv_par19 - Filial Ate                                                  ?
�mv_par20 - NF Transf. Filiais                                          ?
�mv_par21 - Seleciona Filiais?                                          ?
�mv_par22 - Aglutina por CNPJ?                                          ?
�mv_par23 - Gerar o registro CR=26 ?                                    ?
�mv_par24 - Gerar o registro CR=27 ?                                    ?
������������������������������������������������������������������������?
*/
PRIVATE dDtIni		:= mv_par01
PRIVATE dDtFim		:= mv_par02
PRIVATE nTipoGia	:= mv_par03
PRIVATE nMoviment	:= mv_par04
PRIVATE nTransmit	:= mv_par05
PRIVATE nSaldoST	:= mv_par06
PRIVATE nRegime		:= mv_par07
PRIVATE nMes		:= mv_par08
PRIVATE nAno		:= mv_par09
PRIVATE nMesIni		:= mv_par10
PRIVATE nAnoIni		:= mv_par11
PRIVATE cNrLivro	:= mv_par12
PRIVATE nICMSFIX	:= mv_par13
Private cVValid   	:= mv_par15
Private cNomeArq	:= ALLTRIM(mv_par14)+".PRF"
Private cVLayOut  	:= mv_par16
Private nHandle
Private lSelFil   	:= ( mv_par21 == 1 )
Private cLib		:= ''
Private nRemType 	:= GetRemoteType(@cLib)
Private lHtml		:= 'HTML' $ cLib
Private cFunc		:= 'CPYS2TW'
Private cFilDe  	:= mv_par18
Private cFilAte 	:= mv_par19
Private nGeraTransp := mv_par20

If Empty(cFilDe) .And. Empty(cFilAte)
	cFilDe  := cFilAnt
	cFilAte := cFilAnt
EndIf

cRef := strzero(nAno,4)+strzero(nMes,2)
Do Case
		Case nRegime == 2
			If cRef <= "200012"
				lRet := .T.
			EndIf
		Case nRegime == 4
			If cRef >= "200007"
				lRet := .T.
			EndIF
		Case cRef >= "200007" .and. cRef <= Substr(DTOS(date()),1,6)	
				lRet := .T.
		OtherWise
				MsgInfo(STR0019)
EndCase

If lRet
	//��������������������������������������������������������������Ŀ
	//?Monta arquivo de Trabalho                                    ?
	//����������������������������������������������������������������
	a972MontTrab(aApuracao,.F.,dDtIni,dDtFim,cNrLivro,nRegime,cFilDe,cFilAte,cVLayOut,lSelFil,lAglFil,lGerCR26,lGerCR27,aAlias)
	//��������������������������������������������������������������Ŀ
	//?Grava arquivo texto                                          ?
	//����������������������������������������������������������������
	a972GeraTxt(lAutomato)
	//��������������������������������������������������������������Ŀ
	//?Fecha arquivo texto                                          ?
	//����������������������������������������������������������������
	If nHandle >= 0
		FClose(nHandle)
	Endif

	/* Se for HTML disponibilizo o arquivo para download	 */
	If lHtml .and. FindFunction(cFunc)
		&(cFunc+'("'+cNomeArq+'")')
	EndIf

	//������������������������������������������Ŀ
	//?Apaga arquivos temporarios               ?
	//��������������������������������������������
	For nX := 1 To Len(aAlias)
		cArqTrb := aAlias[nX]
		If File(cArqTrb+GetDBExtension())
			dbSelectArea(cArqTrb)
			dbCloseArea()
			Ferase(cArqTrb+GetDBExtension())
			Ferase(cArqTrb+OrdBagExt())
		Endif
	Next

Endif
//��������������������������������������������������������������Ŀ
//?Restaura indices                                             ?
//����������������������������������������������������������������
RetIndex("SF3")
Ferase(cIndSF3+OrdBagExt())

Return

/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Function�A972MontTrab�Autor  �Andreia dos Santos  ?Data ? 25/07/00   ��?
�������������������������������������������������������������������������͹�?
���Desc.   �Armazena as informacoes nos arquivos temporarios para depois  ��?
��?       �gerar arquivo texto.                                          ��?
�������������������������������������������������������������������������͹�?
���Uso     ?MATA972                                                      ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972MontTrab(aApuracao,lRelDIPAM,dDataIni,dDataFim,cNrLivro,nRegime,cFilDe,cFilAte,cVLayOut,lSelFil,lAglFil,lGerCR26,lGerCR27,aAlias)
Local cCod_Mun  	:= ""
Local cFiltro 	:=	""
Local cChave		:=	""
Local cCGC			:=	""
Local cTipo		:=	""
Local cInscr		:= ""
Local cCodMun		:=	""
Local lZranca		:=	.T.
Local cRefIni		:= ""
Local cCNAE		:= ""
Local cUF       	:= ""
Local cRef      	:= ""
Local cQuery    	:= ""
Local lQuery    	:= .F.
Local cAliasSF3 	:= "SF3"
Local cAliasSA1 	:= "SA1"
Local cAliasSA2 	:= "SA2"
Local cCodMunDp 	:= ""
Local nT        	:= 0
Local cRe       	:= ""
Local lConteudo 	:= .F.
Local aStruSF3  	:= {}
Local nSF3      	:= 0
Local cMvUF     	:= GetMV("MV_ESTADO")
Local cCodUf    	:= "09#11#26"
Local aFilsCalc 	:= {}
Local aApuICM   	:= {}
Local aApuST    	:= {}
Local aQ20			:= {}
Local nQtdQ20   	:= 0
Local nX        	:= 0
Local nY        	:= 0
Local nF		  	:= 0
Local cSubCod   	:= ""
Local cD2_Re    	:= GetMv("MV_RE",,"")	// Campo D2 - Exportacao (Sem Integracao EIC)
Local lD2_Re    	:= !Empty(cD2_Re)
Local lExibMsgTms	:=	.F.
Local lGeraExp	:= .T.
Local lTms			:=	IntTms () .And. AliasInDic('DT6')
Local cDip11		:= GetNewPar("MV_DIP11","")
Local cDip13		:= GetNewPar("MV_DIP13","")
Local aAreaSm0	:=	SM0->(GetArea())
Local lStSb		:=	.F.
Local cIndSF3		:= ""
lOCAL cSlctSFT	:= ""
Local lAntiICM	:= 	Iif(SF3->(FieldPos("F3_VALANTI"))>0,.T.,.F.)

Local lA2_CODMUN 	:= SA2->(FieldPos("A2_CODMUN"))>0
Local lA1_CODMUN 	:= SA2->(FieldPos("A1_CODMUN"))>0
Local lMV_MUNA2  	:= SA2->(FieldPos(AllTrim (SuperGetMv ("MV_MUNA2"))))>0

Local lOcorrGen	:= .F.
Local cMv_StUfS	:= GetNewPar( "MV_STUFS" , "")
Local cMv_StUf 	:= GetNewPar( "MV_STUF" , "")
Local nPos			:= 0

Local nCal1     	:=0
Local nCal2     	:=0
Local nCal3     	:=0
Local nPosFil		:=0
Local aSM0			:= {}
Local cPJIEAnt	:= ""
Local n0			:= 0
Local n25Sai    	:= 0
Local n24Sai    	:= 0
Local n24Ent    	:= 0
Local n23Sai    	:= 0
Local n23Ent    	:= 0
Local nPerc     	:= 0
Local dIni      	:= CToD ("//")
Local dFim      	:= CToD ("//")
Local acRe			:= {}
Local acRebk		:= {}
Local lCodRSEF	:= SF3->( FieldPos( "F3_CODRSEF" ) ) > 0
Local aFilClone	:= {}
Local nValor		:= 0
Local lachou23   	:= .F.
Local lachou24   	:= .F.
Local lachou25   	:= .F.
Local lF3TRFICM	:=  SF3->(FieldPos("F3_TRFICM")) > 0

Local cCfop1		:= " "
Local cCfop2		:= " "
Local cCfop3		:= " "
Local cCfop4		:= " "
Local nValCFOP	:= 0
Local lTop			:= .F.

Local lA1CODMUN 	:= SA1->(FieldPos("A1_COD_MUN"))>0
Local cMVCODMUN	:= SuperGetMv("MV_CODMUN")
Local cMVCODDP	:= Alltrim(GetNewPar("MV_CODDP", "1004"))
Local cMvEstado	:= SuperGetMV("MV_ESTADO",,"SP")
Local cCodMunX	:= GetNewPar ("MV_CODMUN", "X")
Local cAliasF3	:= ""
Local aDipamB23	:= {}
Local aDipamB24	:= {}
Local aDipamB25	:= {}
Local nRemetent	:= 0
Local lMA972MUN := ExistBlock("MA972MUN")
Local lMA972VLR := ExistBlock("MA972VLR")

Default aApuracao	:= {}
Default lRelDIPAM	:= .F.
Default dDataIni	:= dDataBase
Default dDataFim	:= dDataBase
Default cNrLivro	:= "*"
Default nRegime		:= 1
Default cFilDe		:= cFilAnt
Default cFilAte 	:= cFilAnt
Default cVLayOut	:= ""
Default lSelFil  	:= .F.
Default lAglFil		:= .F.
Default lGerCR26	:= .F.
Default lGerCR27	:= .F.
Default aAlias		:= {}

cCredAcum  :=IIf(Type("cCredAcum")<>"U",cCredAcum,"")

#IFDEF TOP
	If TcSrvType() <> "AS/400"
		lTop 	:= .T.
	Endif
#ENDIF

If Empty(nGeraTransp)
	nGeraTransp := 2
EndIf

//����������������������������������?
//?Cria arquivos temporarios       ?
//����������������������������������?
a972CriaTemp(lRelDIPAM)

If lRelDIPAM
	nAno := Year(dDataIni)
	nMes := Month(dDataIni)
Endif

cRef := StrZero(nAno,4)+StrZero(nMes,2)

//��������������������������������������������?
//�Verifica como as filiais serao processadas:?
//? apenas a filial                          ?
//? filial de/ate                            ?
//? filiais selecionadas                     ?
//��������������������������������������������?
If lSelFil
	aFilsCalc := MatFilCalc( lSelFil, , , (lSelfil .and. lAglFil), , 2 )			// Aglutina por CNPJ + I.E.
EndIf

If lSelFil .And. ( Len(aFilsCalc) >= 1 )
	aFilClone := aSort(aFilsCalc, , , { | x,y | x[2] < y[2] } )
	cFilDe 	:= aFilClone[01][02]
	cFilAte	:= aFilClone[Len(aFilClone)][02]
Endif

DbSelectArea ("SM0")
SM0->(MsSeek(cEmpAnt+cFilDe,.T.))
While !SM0->(Eof ()) .And. FWGrpCompany() == cEmpAnt .And. (SM0->M0_CODFIL<=cFilAte)
	//����������������������������������������������������������������������������������������������Ŀ
	//�Se foram selecionadas as filiais, identifica se a filial posicionada esta selecionada no array?
	//������������������������������������������������������������������������������������������������
	If lSelFil
		If ( nPosFil := aScan(aFilsCalc,{|x| Alltrim(x[2]) == Alltrim(SM0->M0_CODFIL)}) ) > 0 .And. aFilsCalc[nPosFil,1]
			Aadd(aSM0,{SM0->M0_CODIGO,SM0->M0_CODFIL,SM0->M0_FILIAL,SM0->M0_NOME,SM0->M0_CGC,SM0->M0_INSC})
		Endif
	Else
		Aadd(aSM0,{SM0->M0_CODIGO,SM0->M0_CODFIL,SM0->M0_FILIAL,SM0->M0_NOME,SM0->M0_CGC,SM0->M0_INSC})
	Endif
	SM0->(DbSkip ())
EndDo

aSM0 := ASort(aSM0,,,{|x,y| x[5] < y[5] })

For n0 := 1 to Len(aSM0)

	SM0->(msseek (aSM0[n0][1]+aSM0[n0][2]))

	cFilAnt		:=	FWGETCODFILIAL
	cMVCODMUN	:= SuperGetMv("MV_CODMUN")
	cMVCODDP	:= Alltrim(GetNewPar("MV_CODDP", "1004"))
	cMVEstado	:= SuperGetMV("MV_ESTADO",,"SP")
	cCodMunX	:= GetNewPar ("MV_CODMUN", "X")

	//������������������������������������������������������������?
	//?Le valores das Apuracoes .IC?                             ?
	//������������������������������������������������������������?
	aApuracao := A970ArqIC(.F.)

	//Atualiza a cada volta do SIGAMAT e verifica se o campo em MV_MUNA2 existe na tabela SA2.
	lMV_MUNA2	:= .F.
	If (GetNewPar("MV_MUNA2", "X")<>"X")
		lMV_MUNA2  := SA2->(FieldPos(AllTrim (SuperGetMv ("MV_MUNA2"))))>0
	EndIF

	If Type("cVLayOut")<>"U" .And. ( cVLayOut=="0207" .OR. cVLayOut=="0208" .OR. cVLayOut=="0209" .OR. cVLayOut=="0210")
		cCNAE		:=	"0000000"	//tratamento desta nova versao
	Else
		cCNAE		:=	If(Len(Alltrim(SM0->M0_CNAE))==7,SM0->M0_CNAE,Alltrim(SM0->M0_CNAE)+Replicate("00",7-Len(alltrim(SM0->M0_CNAE))))
	EndIf

	//��������������������������������������Ŀ
	//�Cabecalho do documento Fiscal - CR=05 ?
	//����������������������������������������
	cRefIni	:=	if(nRegime == 2 ,strzero(nAnoIni,4)+strzero(nMesIni,2),"000000")
	//
	#IFDEF TOP
		If TcSrvType() <> "AS/400"
			cAliasSF3:= "a972MontTrab"
			lQuery    := .T.
			aStruSF3  := SF3->(dbStruct())
			If !lRelDIPAM .and. !lTms
				//Se n�o for relat�rio da Dipam, os campos ser�o tratados de forma agrupada
				cQuery := "SELECT SF3.F3_FILIAL,SF3.F3_ENTRADA,SF3.F3_DTCANC, SF3.F3_CREDST, SF3.F3_TIPO,SF3.F3_CFO,SF3.F3_ESTADO,"
				cQuery += "SF3.F3_CLIEFOR,SF3.F3_LOJA,SF3.F3_EMISSAO, SF3.F3_TIPO,SF3.F3_ESPECIE,"
				cQuery += "SA1.A1_TIPO,SA1.A1_MUN ,SA1.A1_INSCR,"
				cQuery += "SA2.A2_INSCR,SA2.A2_TIPO,SA2.A2_TIPORUR,SA2.A2_MUN,"
				If	lGerCR26 .Or. lGerCR27
					cQuery +="SF3.F3_NFISCAL,"
				EndIf
				cQuery += "SUM(SF3.F3_VALCONT) AS F3_VALCONT,SUM(SF3.F3_BASEICM) AS F3_BASEICM,SUM(SF3.F3_VALICM) AS F3_VALICM,"
				cQuery += "SUM(SF3.F3_ISENICM) AS F3_ISENICM,SUM(SF3.F3_OUTRICM) AS F3_OUTRICM,SUM(SF3.F3_ICMSRET) AS F3_ICMSRET,"
				cQuery += "SUM(SF3.F3_VALIPI) AS F3_VALIPI,SUM(SF3.F3_IPIOBS) AS F3_IPIOBS, SUM(SF3.F3_VALANTI) AS F3_VALANTI,SUM(SF3.F3_TRFICM) AS F3_TRFICM "
				cQuery += "FROM "
				cQuery += RetSqlName("SF3") + " SF3 "
				cQuery += " LEFT JOIN " + RetSqlName("SA1") + " SA1 ON (SA1.A1_FILIAL='"+xFilial("SA1")+"' AND SA1.A1_COD=SF3.F3_CLIEFOR AND SA1.A1_LOJA = SF3.F3_LOJA AND SA1.D_E_L_E_T_='')  "
				cQuery += " LEFT JOIN " + RetSqlName("SA2") + " SA2 ON (SA2.A2_FILIAL='"+xFilial("SA2")+"' AND SA2.A2_COD=SF3.F3_CLIEFOR AND SA2.A2_LOJA = SF3.F3_LOJA AND SA2.D_E_L_E_T_='')  "
			Else
				//Se relat�rio da dipam ent�o os campos n�o ser�o tratados de forma agrupada.
				cQuery := "SELECT SF3.F3_FILIAL,SF3.F3_ENTRADA,SF3.F3_DTCANC,SF3.F3_CREDST,SF3.F3_ESPECIE, "
				cQuery += "SF3.F3_TIPO,SF3.F3_CFO,SF3.F3_ESTADO,SF3.F3_VALCONT,SF3.F3_BASEICM, "
				cQuery += "SF3.F3_VALICM,SF3.F3_ISENICM,SF3.F3_OUTRICM,SF3.F3_ICMSRET, "
				cQuery += "SF3.F3_CLIEFOR,SF3.F3_LOJA,SF3.F3_NFISCAL,SF3.F3_EMISSAO, "
				cQuery += "SF3.F3_SERIE, SF3.F3_VALIPI, SF3.F3_IPIOBS, SF3.F3_IDENTFT, "
				cQuery += "SA1.A1_TIPO,SA1.A1_MUN ,SA1.A1_INSCR,"
				cQuery += "SA2.A2_INSCR,SA2.A2_TIPO,SA2.A2_TIPORUR,SA2.A2_MUN "
				cQuery += IIf(SF3->(FieldPos("F3_TRFICM"))>0,",SF3.F3_TRFICM "," ")
				cQuery += Iif(lAntiICM,",SF3.F3_VALANTI "," ")
				cQuery += "FROM "
				cQuery += RetSqlName("SF3") + " SF3 "
				cQuery += " LEFT JOIN " + RetSqlName("SA1") + " SA1 ON (SA1.A1_FILIAL='"+xFilial("SA1")+"' AND SA1.A1_COD=SF3.F3_CLIEFOR AND SA1.A1_LOJA = SF3.F3_LOJA AND SA1.D_E_L_E_T_='')  "
				cQuery += " LEFT JOIN " + RetSqlName("SA2") + " SA2 ON (SA2.A2_FILIAL='"+xFilial("SA2")+"' AND SA2.A2_COD=SF3.F3_CLIEFOR AND SA2.A2_LOJA = SF3.F3_LOJA AND SA2.D_E_L_E_T_='')  "
			EndIF
			cQuery += "WHERE "
			cQuery += "SF3.F3_FILIAL = '"+xFilial("SF3")+"' AND "
			If nGeraTransp == 1 .And. lF3TRFICM
				cQuery	+= " ((SF3.F3_ENTRADA >= '"+DTOS(dDtIni)+"' AND SF3.F3_ENTRADA <= '"+DTOS(dDtFim)+"'"
				cQuery	+= " AND SF3.F3_CFO NOT IN ('1601','1602','1605','5601','5602','5605') )
				If SuperGetMv('MV_ESTADO')=='PR'
					cQuery	+= " OR (SF3.F3_ENTRADA >= '"+DTOS(dDtIni+5)+"' AND SF3.F3_ENTRADA <= '"+DTOS(dDtFim+5)+"'"
				Else
					cQuery	+= " OR (SF3.F3_ENTRADA >= '"+DTOS(dDtIni+9)+"' AND SF3.F3_ENTRADA <= '"+DTOS(dDtFim+9)+"'"
				EndIf
				cQuery	+= " AND SF3.F3_CFO IN ('1601','1602','1605','5601','5602','5605') )) AND "
			Else
				cQuery += "SF3.F3_ENTRADA >= '"+DTOS(dDtIni)+"' AND "
				cQuery += "SF3.F3_ENTRADA <= '"+DTOS(dDtFim)+"' AND "
				cQuery += "SF3.F3_CFO NOT IN ('1601','1602','1605','5601','5602','5605') AND "
			EndIf
			If cNrLivro <> "*"
				cQuery += "F3_NRLIVRO ='"+ cNrLivro +"' AND "
			EndIf
			If lCodRSEF
				cQuery += "SF3.F3_CODRSEF NOT IN('102','110','204','205','206','301','302','303','304','305','306') AND "
			Endif
			cQuery += "F3_DTCANC =' ' AND "
			cQuery += "SF3.D_E_L_E_T_ = ' ' "
			IF !lRelDIPAM .AND. !lTms
				cQuery += "GROUP BY SF3.F3_FILIAL,SF3.F3_ENTRADA,SF3.F3_DTCANC, SF3.F3_CREDST, SF3.F3_TIPO,SF3.F3_CFO,SF3.F3_ESTADO,"
				cQuery += "SF3.F3_CLIEFOR,SF3.F3_LOJA,SF3.F3_EMISSAO, SF3.F3_ESPECIE, "
				cQuery += "SA1.A1_TIPO,SA1.A1_MUN ,SA1.A1_INSCR,"
				cQuery += "SA2.A2_INSCR,SA2.A2_TIPO,SA2.A2_TIPORUR,SA2.A2_MUN "
				If lGerCR26 .Or. lGerCR27
					cQuery +=", SF3.F3_NFISCAL"
				EndIf
			EndIF
			cQuery := ChangeQuery(cQuery)
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSF3,.T.,.T.)
			For nSF3 := 1 To Len(aStruSF3)
				If aStruSF3[nSF3][2] <> "C" .and. FieldPos(aStruSF3[nSF3][1]) > 0
					TcSetField(cAliasSF3,aStruSF3[nSF3][1],aStruSF3[nSF3][2],aStruSF3[nSF3][3],aStruSF3[nSF3][4])
				EndIf
			Next nSF3

		Else
	#ENDIF
			dbSelectArea(cAliasSF3)
			cIndSF3	:=	CriaTrab(NIL,.F.)
			cChave	:=	IndexKey()
			cFiltro	:=	"F3_FILIAL=='"+xFilial()+"'"
			If nGeraTransp == 1 .And. lF3TRFICM
				cFiltro	+= " .And. ((DTOS(F3_ENTRADA)>='"+Dtos(dDtIni)+"' .And. DTOS(F3_ENTRADA)<='"+Dtos(dDtFim)+"'"
				cFiltro	+= " .And. !(F3_CFO $ '1601/1602/1605/5601/5602/5605') ) "
				cFiltro	+= " .Or. (DTOS(F3_ENTRADA)>='"+Dtos(dDtIni+9)+"' .And. DTOS(F3_ENTRADA)<='"+Dtos(dDtFim+9)+"'"
				cFiltro	+= " .And. (F3_CFO $ '1601/1602/1605/5601/5602/5605') )) "
			Else
				cFiltro	+= " .And. DTOS(F3_ENTRADA)>='"+DTOS(dDtIni)+"' .AND. DTOS(F3_ENTRADA)<='"+DTOS(dDtFim)+"'"
				cFiltro	+= " .And. !(F3_CFO $ '1601/1602/1605/5601/5602/5605') "
			EndIf
			If !(cNrLivro=="*")
				cFiltro+='.And. F3_NRLIVRO$"'+cNrLivro+'"'
			Endif
			cFiltro+='.And. Empty(F3_DTCANC) '
			IndRegua(cAliasSF3,cIndSF3,cChave,,cFiltro,STR0008) //"Selec.Notas fiscais..."
	#IFDEF TOP
		Endif
	#ENDIF

	#IFNDEF TOP
		If ProcName(1) == "R972IMP"
			SetRegua((cAliasSF3)->(LastRec()))
		Else
			ProcRegua((cAliasSF3)->(LastRec()))
		Endif
	#ENDIF

	If Type("nTipoReg") == "U"
		nTipoReg := 0
	EndIf

	If !lAglFil .Or. ((cPJIEAnt)<>SubStr(SM0->M0_CGC,1,8)+SM0->M0_INSC)

		cPJIEAnt := SubStr(SM0->M0_CGC,1,8)+SM0->M0_INSC
		nTipoReg++

		If !lRelDIPAM
			RecLock(cArqCabec,.T.)
				(cArqCabec)->IE			:=	SM0->M0_INSC					//Inscricao Estadual
				(cArqCabec)->CNPJ		:=	SM0->M0_CGC						//CNPJ
				(cArqCabec)->CNAE		:=	cCNAE 							//Classficacao Nacional da Atividade Economica
				(cArqCabec)->REGTRIB	:=	strzero(nRegime,2)			//Regime Tributario
				(cArqCabec)->REF		:=	strzero(nAno,4)+strzero(nMes,2)//Referencia(Ano e Mes da GIA)
				(cArqCabec)->REFINIC	:=	cRefIni							//Referencia Inicial( Ano e Mes)
				(cArqCabec)->TIPO		:=	strzero(nTipoGia,2)			//Tipo da GIA
				(cArqCabec)->MOVIMEN	:=	if(nMoviment==1,"1","0")	//GIA com Movimento?
				(cArqCabec)->TRANSMI	:=	if(nTransmit==1,"1","0")	//GIA ja transmitida?
				(cArqCabec)->SALDO		:=	aApuracao[09]					//Saldo Credor do periodo anterior
				(cArqCabec)->SALDOST	:=	If(nRegime == 4,0.00,nSaldoST)	//Saldo Credor do Per.Ant. Substituicao Tributaria
				(cArqCabec)->ORIGSOF	:=	"53113791000122"				//CNPJ do Fabricande do sofwtare( Totvs )
				(cArqCabec)->ORIGARQ	:=	"0"								//0-Gerado pelo sistama de informacao contabil
				(cArqCabec)->ICMSFIX	:=	if(nRegime==2,nICMSFIX,0.00)//ICMS Fixado para o periodo( Apenas para regime RES)
				(cArqCabec)->TIPOREG	:=  StrZero(nTipoReg,6)
			MSUnlock()
		EndIf
	EndIf
	SA1->(dbSetOrder(1))
	SA2->(dbSetOrder(1))
	SD1->(dbSetOrder(1))
	SD2->(dbSetOrder(3))
	SF4->(dbSetOrder(1))
	SFT->(dbSetOrder(3))
	EE9->(dbSetOrder(3))
	While (cAliasSF3)->(!Eof()) .and. xFilial("SF3")==(cAliasSF3)->F3_FILIAL
		If !lQuery
			If ProcName(1) == "R972IMP"
				IncRegua()
			else
				IncProc()
			EndIf
		EndIf

		If  nGeraTransp == 1 .And. (cAliasSF3)->F3_EMISSAO>dDataFim .And. lF3TRFICM.And. (cAliasSF3)->F3_TRFICM == 0
			(cAliasSF3)->(dbSkip())
			Loop
		EndIf

		/*
		Para evitar de fazer substr todos os itens diversas vezes, ser?efetuado somente uma vez e ir?utilizar
		a vari�vel j?preenchida.
		*/
		nValCFOP	:= Val((cAliasSF3)->F3_CFO)
		cCfop1		:=	SubStr((cAliasSF3)->F3_CFO,1,1)
		cCfop2		:= 	SubStr((cAliasSF3)->F3_CFO,1,2)
		cCfop3		:=	SubStr((cAliasSF3)->F3_CFO,1,3)
		cCfop4		:=	SubStr((cAliasSF3)->F3_CFO,1,4)

		If ((cAliasSF3)->F3_TIPO=="S" ) .OR. (cCfop3 $"000#999") .Or. (cCfop4 $"1601#1602#1605#5601#5602#5605")
			//����������������������������������������?
			//�Grava arquivo temporario CR=25 (cArqIE)?
			//����������������������������������������?
			If !lRelDIPAM .And. (cCfop3 $"000#999" .Or. cCfop4 $"1601#1602#1605#5601#5602#5605")
				IF lF3TRFICM
					a972TmpIE(cAliasSF3)
				EndIF
			Endif
			(cAliasSF3)->(dbSkip())
			Loop
		EndIf

		If	lGerCR26 .And. (cCfop4 $"5603#6603") //NOTA FISCAL DE RESSARCIMENTO
			//����������������������������������������?
			//�Grava arquivo temporario CR=26 (cArqIeST)?
			//����������������������������������������?
			If !lRelDIPAM
				a972TmIeST(cAliasSF3)
			Endif
		EndIf

		If	lGerCR27 .And. (cCfop4 $"1603#2603") //NOTA FISCAL DE RESSARCIMENTO
			//����������������������������������������?
			//�Grava arquivo temporario CR=27 (cArqIeSD)?
			//����������������������������������������?
			If !lRelDIPAM
				a972TmIeSD(cAliasSF3)
			Endif
		EndIf

		If !lRelDIPAM .And. nRegime == 4 .And. ;
			((cRef<="200212" .And. !(Alltrim((cAliasSF3)->F3_CFO)$"171/172/173/174/175/176/177/178/179/196/571/572/573/574/575/576/577/578/579" .Or. cCfop2=="99")) .Or. ;
			(cRef>"200212" .And. cRef<="200312" .And. !(Alltrim((cAliasSF3)->F3_CFO)$"1401/1403/1406/1407/1408/1409/1410/1411/1414/1415/5401/5402/5403/5405/5408/5409/5410/5411/5412/5413/5414/5415" .Or. Left((cAliasSF3)->F3_CFO,2)$"19/59")) .Or. ;
			(cRef>"200312" .And. cRef <= "200412" .And. !(Alltrim((cAliasSF3)->F3_CFO)$"1401/1403/1406/1407/1408/1409/1410/1411/1414/1415/1651/1652/1653/1658/1659/1660/1661/1662/1663/1664/5401/5402/5403/5405/5408/5409/5410/5411/5412/5413/5414/5415/5651/5652/5653/5654/5655/5656/5657/5658/5659/5660/5661/5662/5663/5664/5665/5666" .Or. cCfop2 $ "19/59")) .Or.;
			(cRef>"200412" .And. !(Alltrim((cAliasSF3)->F3_CFO)$"1401/1403/1406/1407/1408/1409/1410/1411/1414/1415/1651/1652/1653/1658/1659/1660/1661/1662/1663/1664/5359/5401/5402/5403/5405/5408/5409/5410/5411/5412/5413/5414/5415/5651/5652/5653/5654/5655/5656/5657/5658/5659/5660/5661/5662/5663/5664/5665/5666/" .Or. cCfop2 $ "19/59")) .Or.;
			(cRef>"200712" .And. cRef <= "200804" .And. !(Alltrim((cAliasSF3)->F3_CFO)$"1360/1401/1403/1406/1407/1408/1409/1410/1411/1414/1415/1651/1652/1653/1658/1659/1660/1661/1662/1663/1664/5359/5360/5401/5402/5403/5405/5408/5409/5410/5411/5412/5413/5414/5415/5651/5652/5653/5654/5655/5656/5657/5658/5659/5660/5661/5662/5663/5664/5665/5666/" .Or. cCfop2 $ "19/59")) .or.;
			(cRef>"200804" .And. !(Alltrim((cAliasSF3)->F3_CFO)$"1360/1401/1403/1406/1407/1408/1409/1410/1411/1414/1415/1651/1652/1653/1658/1659/1660/1661/1662/1663/1664/5359/5360/6360/5401/5402/5403/5405/5408/5409/5410/5411/5412/5413/5414/5415/5651/5652/5653/5654/5655/5656/5657/5658/5659/5660/5661/5662/5663/5664/5665/5666/" .Or. cCfop2 $ "19/59")))
			(cAliasSF3)->(dbSkip())
			Loop
		EndIf
		cUF	:= A972CodUF((cAliasSF3)->F3_ESTADO)
		If cMvUF == "SP"
			If (substr(alltrim((cAliasSF3)->F3_CFO),2,2) == "99") .Or. (substr(alltrim((cAliasSF3)->F3_CFO),2,2) == "94" .And. Len(Alltrim((cAliasSF3)->F3_CFO))=4)
				If !substr(alltrim((cAliasSF3)->F3_CFO),4,1)==""
					If (strzero(nAno,4)+strzero(nMes,2)) > "200012" .and. (!(substr(alltrim((cAliasSF3)->F3_CFO),4,1)$ "19") .And. Len(Alltrim((cAliasSF3)->F3_CFO))=3)
						(cAliasSF3)->(dbSkip())
						Loop
					EndIf
				Endif
			EndIf
			If cCfop1 $"26" .and. cUF$cCodUf
				(cAliasSF3)->(dbSkip())
				Loop
			EndIf
		EndIf

		If lTop .And. !lRelDIPAM
			cAliasSA1	:= cAliasSF3
			cAliasSA2	:= cAliasSF3
		Else
			(cAliasSA1)->(msseek(xFilial("SA1")+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA,.F.))
			(cAliasSA2)->(msseek(xFilial("SA2")+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA,.F.))
		EndIF

		If !lRelDIPAM

			//Encerra a movimentacao caso o parametro mv_par04 seja == 2.
			//Alterada a posicao do If no fonte para que o registro CR=05 seja executado independente do parametro, mv_par04.
			If nMoviment == 2
				Return
			EndIf
			//����������������������Ŀ
			//�Detalhes CFOPs CR=10  ?
			//������������������������
			If (cArqCFO)->(!msseek((cAliasSF3)->F3_CFO+StrZero(nTipoReg,6)))
				RecLock(cArqCabec,.f.)
				(cArqCabec)->Q10	+=	1			//quantidade de registro tipo CR-10
				MSUnLock()

				RecLock(cArqCFO,.T.)
				(cArqCFO)->CFOP		:=	(cAliasSF3)->F3_CFO			//CFOP
			Else
				RecLock(cArqCFO,.F.)
			EndIf
			(cArqCFO)->VALCONT	+=	(cAliasSF3)->F3_VALCONT		//Valor Contabil
			(cArqCFO)->BASEICM	+=	(cAliasSF3)->F3_BASEICM		//Base de Calculo
			(cArqCFO)->VALTRIB	+=	(cAliasSF3)->F3_VALICM		//Valor do imposto creditado
			(cArqCFO)->ISENTA	+=	(cAliasSF3)->F3_ISENICM		//Isenta e nao tributada
			(cArqCFO)->OUTRAS	+=	(cAliasSF3)->F3_OUTRICM		//Outras Operacoes
			(cArqCFO)->IMPOSTO	+=	(cAliasSF3)->F3_VALCONT-(cAliasSF3)->(F3_BASEICM+F3_ISENICM+F3_OUTRICM+F3_ICMSRET) //Outros impostos
			If cRef >= "200201"
				(cArqCFO)->RETIDO   += 0
			Else
				If (cAliasSF3)->F3_VALANTI == 0
					(cArqCFO)->RETIDO	+=	(cAliasSF3)->F3_ICMSRET		//Imposto retido por Substituicao Tributaria
				EndIf
			EndIf
			
			lStSb		:=	.F.
			If	(cVValid == "0700" .and. cVLayOut == "0200") .Or. (cVValid == "0710" .and. cVLayOut == "0201") .or. (cVValid == "0720" .and. cVLayOut == "0202") .Or.;
				(cVValid == "0730" .and. cVLayOut == "0203") .Or. (cVValid == "0740" .and. cVLayOut == "0204") .Or. (cVValid == "0750" .and. cVLayOut == "0205") .Or.;
				(cVValid == "0760" .and. cVLayOut == "0206") .Or. (cVValid == "0770" .and. cVLayOut == "0207") .Or. (cVValid == "0780" .and. cVLayOut == "0208") .Or.;
				(cVValid == "0790" .and. cVLayOut == "0209") .Or. (cVValid >= "0800" .and. cVLayOut >= "0210") .Or. (cVValid >= "0801" .and. cVLayOut >= "0210")
				If (cRef<="200212")
					If (cCfop1 $ "56")
						If (((cCfop3 >="571") .And. (cCfop3 <="579")) .Or.;
							(cCfop3 =="597") .Or.;
							((cCfop3 >="671") .And. (cCfop3<="679")) .Or.;
							(cCfop3=="697") .Or.;
							(cCfop3=="99"))

							(cArqCFO)->RtStSt := 0
							(cArqCFO)->RtSbSt := 0

						Else
							If (cAliasSF3)->F3_VALANTI == 0
								(cArqCFO)->RtStSt += (cAliasSF3)->F3_ICMSRET
								lStSb		:=	.T.
							Endif
						EndIf
					ElseIf (cCfop1$"12")
						If (((cCfop3>="171") .And. (cCfop3<="179")) .Or.;
							((cCfop3>="271") .And. (cCfop3<="279")) .Or.;
							(cCfop3=="196") .Or.;
							(cCfop3=="296") .Or.;
							(SubStr ((cAliasSF3)->F3_CFO, 2, 2)=="99"))

							(cArqCFO)->RtStSt := 0
							(cArqCFO)->RtSbSt := 0

						Else
							If (cAliasSF3)->F3_VALANTI == 0
								(cArqCFO)->RtSbSt += (cAliasSF3)->F3_ICMSRET
								lStSb		:=	.T.
							Endif
						EndIf
					EndIf

				ElseIf (cRef>"200212" .And. cRef<="200312")
					If (cCfop1$"56")
						If (((nValCFOP>=5401) .And. (nValCFOP<=5449)) .Or.;
							((nValCFOP>=6401) .And. (nValCFOP<=6449)) .Or.;
							(cCfop2=="59") .Or.;
							(cCfop2=="69"))

							(cArqCFO)->RtStSt := 0
							(cArqCFO)->RtSbSt := 0

						Else
							If (cAliasSF3)->F3_VALANTI == 0
								(cArqCFO)->RtStSt += (cAliasSF3)->F3_ICMSRET
								lStSb		:=	.T.
							Endif
						EndIf

					ElseIf (cCfop1$"12")
						If (((nValCFOP>=1401) .And. (nValCFOP<=1449)) .Or.;
							((nValCFOP>=2401) .And. (nValCFOP<=2449)) .Or.;
							(cCfop2=="19") .Or.;
							(cCfop2=="29"))

							(cArqCFO)->RtStSt := 0
							(cArqCFO)->RtSbSt := 0

						Else
							If (cAliasSF3)->F3_VALANTI == 0
								(cArqCFO)->RtSbSt += (cAliasSF3)->F3_ICMSRET
								lStSb		:=	.T.
							Endif
						EndIf
					EndIf

				ElseIf	(cRef>"200312" .And. cRef<="200712")
					If (cCfop1$"56")
						If (((nValCFOP>=5401) .And. (nValCFOP<=5449)) .Or.;
							((nValCFOP>=5651) .And. (nValCFOP<=5699)) .Or.;
							((nValCFOP>=6401) .And. (nValCFOP<=6449)) .Or.;
							((nValCFOP>=6651) .And. (nValCFOP<=6699)) .Or.;
							(cCfop2=="59") .Or.;
							(cCfop2=="69"))

							(cArqCFO)->RtStSt := 0
							(cArqCFO)->RtSbSt := 0

						Else
							If (cAliasSF3)->F3_VALANTI == 0
								(cArqCFO)->RtStSt += (cAliasSF3)->F3_ICMSRET
								lStSb		:=	.T.
							Endif
						EndIf

					ElseIf (cCfop1$"12")
						If (((nValCFOP>=1401) .And. (nValCFOP<=1449)) .Or.;
							((nValCFOP>=1651) .And. (nValCFOP<=1699)) .Or.;
							((nValCFOP>=2401) .And. (nValCFOP<=2449)) .Or.;
							((nValCFOP>=2651) .And. (nValCFOP<=2699)) .Or.;
							(cCfop2=="19") .Or.;
							(cCfop2=="29"))

							(cArqCFO)->RtStSt := 0
							(cArqCFO)->RtSbSt := 0

						Else
							If (cAliasSF3)->F3_TIPO <> "D"	//Devolucao
								If (cAliasSF3)->F3_VALANTI == 0
									(cArqCFO)->RtSbSt += (cAliasSF3)->F3_ICMSRET
									lStSb		:=	.T.
								Endif
							Else
								If (cAliasSF3)->F3_VALANTI == 0
									(cArqCFO)->RtStSt += (cAliasSF3)->F3_ICMSRET
									lStSb		:=	.T.
								Endif
							Endif
						EndIf
					EndIf

				ElseIf	(cRef>"200712" .And. cRef<="200804")
					If (cCfop1$"56")
						If (((nValCFOP>=5401) .And. (nValCFOP<=5449)) .Or.;
							((nValCFOP>=5651) .And. (nValCFOP<=5699)) .Or.;
							((nValCFOP>=6401) .And. (nValCFOP<=6449)) .Or.;
							((nValCFOP>=6651) .And. (nValCFOP<=6699)) .Or.;
							(nValCFOP==5360)) .Or.;
							(cCfop2=="69")

							(cArqCFO)->RtStSt := 0
							(cArqCFO)->RtSbSt := 0

						Else
							If (cAliasSF3)->F3_TIPO <> "D"	//Devolucao
								If (cAliasSF3)->F3_VALANTI == 0
									(cArqCFO)->RtSbSt += (cAliasSF3)->F3_ICMSRET
									lStSb		:=	.T.
								Endif
							Else
								If (cAliasSF3)->F3_VALANTI == 0
									(cArqCFO)->RtStSt += (cAliasSF3)->F3_ICMSRET
									lStSb		:=	.T.
								Endif
							Endif
						Endif

					ElseIf (cCfop1$"12")
						If (((nValCFOP<>1360) .And. (nValCFOP>=1401) .And. (nValCFOP<=1449)) .Or.;
							((nValCFOP>=1651) .And. (nValCFOP<=1699)) .Or.;
							((nValCFOP>=2401) .And. (nValCFOP<=2449)) .Or.;
							((nValCFOP>=2651) .And. (nValCFOP<=2699)) .Or.;
							(cCfop2=="19") .Or.;
							(cCfop2=="29"))

							(cArqCFO)->RtStSt := 0
							(cArqCFO)->RtSbSt := 0

						Else
							If (cAliasSF3)->F3_VALANTI == 0
								(cArqCFO)->RtSbSt += (cAliasSF3)->F3_ICMSRET
								lStSb		:=	.T.
							Endif
						EndIf

					EndIf

				Else //(cRef>"200804")
					If (cCfop1$"56")
						If (((nValCFOP>=5401) .And. (nValCFOP<=5449)) .Or.;
							((nValCFOP>=5651) .And. (nValCFOP<=5699)) .Or.;
							((nValCFOP>=6401) .And. (nValCFOP<=6449)) .Or.;
							((nValCFOP>=6651) .And. (nValCFOP<=6699)) .Or.;
							((nValCFOP==5360)) .Or.;
							((nValCFOP==6360)) .Or.;
							(cCfop2=="59").Or.;
							(cCfop2=="69"))

							If (cAliasSF3)->F3_VALANTI == 0
								// Aplicado o conceito dos parametros MV_STUF e MV_STUFS, assim como eh feito nos Speds e Apuracao de ICMS				
								If	(cAliasSF3)->F3_CREDST $ " 23" .And.;
									!cCfop4 $ "6109|6110|6119" .And.;
									(( Empty( cMv_StUfS ) .Or. ( cAliasSF3 )->F3_ESTADO $ cMv_StUfS ) .Or.;
									(  Empty( cMv_StUf  ) .Or. ( cAliasSF3 )->F3_ESTADO $ cMv_StUf ))

									(cArqCFO)->RtStSt += (cAliasSF3)->F3_ICMSRET
									lStSb		:=	.T.

								ElseIf (cAliasSF3)->F3_CREDST == "4" .And. !cCfop4 $ "6109|6110|6119"
									(cArqCFO)->RtSbSt += (cAliasSF3)->F3_ICMSRET
									lStSb		:=	.T.
								EndIf
							Endif
						Else
							(cArqCFO)->RtStSt += 0
							(cArqCFO)->RtSbSt += 0
						EndIf

					ElseIf (cCfop1$"12")
						If (((nValCFOP<>1360) .And. (nValCFOP>=1401) .And. (nValCFOP<=1449)) .Or.;
							((nValCFOP>=1651) .And. (nValCFOP<=1699)) .Or.;
							((nValCFOP>=2401) .And. (nValCFOP<=2449)) .Or.;
							((nValCFOP>=2651) .And. (nValCFOP<=2699)) .Or.;
							((nValCFOP>=2401) .And. (nValCFOP<=2949)) .And. (nValCFOP<>1603) .And. (nValCFOP<>2603) .And. (nValCFOP<>2203) .And. (nValCFOP<>2204) .Or.;
							(cCfop2=="19") .Or.;
							(cCfop2=="29"))
							If (cAliasSF3)->F3_VALANTI == 0
								If	(cAliasSF3)->F3_CREDST $ "12 "
									(cArqCFO)->RtStSt += (cAliasSF3)->F3_ICMSRET
									lStSb		:=	.T.
								ElseIf (cAliasSF3)->F3_CREDST == "4"
									(cArqCFO)->RtSbSt += (cAliasSF3)->F3_ICMSRET
									lStSb		:=	.T.
								EndIf
							Endif
						Else
							(cArqCFO)->RtStSt += 0
							(cArqCFO)->RtSbSt += 0
						EndIf
					EndIf
				EndIf
			Endif

			//����������������������������������������������������������?
			//�Tratamento para PIS/COFINS agregado no total da Nota     ?
			//����������������������������������������������������������?
			cTipoNf=Iif(cCfop1<"4","E","S")
			// Verificar caso seja entrada.
			//Somente ir?processar este trecho para consiadmiderar PIS e COFINS no campo (cArqCFO)->IMPOSTO somente se for ambiente DBF.
			//Para ambiente TOP o tratamento deste trecho ?feito logo ap�s o final da query principal
			//pois este la�o da SF3 em ambiente TOP ?de maneira agrupada, e desta manera n�o temos como chegar no n�vel de item
			//esta altera��o foi devida altera��o de melhoria de performance.
			IF !lTop
				If cTipoNf="E"
					// Posiciona no primeiro item da NF
					If SD1->(MsSeek(xFilial("SD1")+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA))
						// Verifica em cada item da NF a existencia de PIS/COFINS
						Do While SD1->D1_FILIAL==xFilial("SD1") .And. SD1->D1_DOC==(cAliasSF3)->F3_NFISCAL .And. SD1->D1_SERIE==(cAliasSF3)->F3_SERIE .And. ;
							SD1->D1_FORNECE==(cAliasSF3)->F3_CLIEFOR .And. SD1->D1_LOJA==(cAliasSF3)->F3_LOJA
							// Verifica caso seja a mesma CFOP
							If SD1->D1_CF==(cAliasSF3)->F3_CFO
								If SF4->(MsSeek(xFilial("SF4")+SD1->D1_TES))
									// Soma o valor de PIS/COFINS
									IF SF4->F4_AGRPIS $ "1S"
										(cArqCFO)->IMPOSTO += SD1->D1_VALIMP6
									Endif
									If SF4->F4_AGRCOF $ "1S"
										(cArqCFO)->IMPOSTO += SD1->D1_VALIMP5
									Endif
									If SF4->F4_INCIDE $ "N"
										(cArqCFO)->IMPOSTO += SD1->D1_VALIPI
									Endif
								Endif
							Endif
							SD1->( DbSkip() )
						EndDo
					EndIf
				Else
					If SD2->(MsSeek(xFilial("SD2")+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA))
						// Verifica em cada item da NF a existencia de PIS/COFINS
						Do While SD2->D2_FILIAL==xFilial("SD2") .And. SD2->D2_DOC==(cAliasSF3)->F3_NFISCAL .And. SD2->D2_SERIE==(cAliasSF3)->F3_SERIE .And. ;
							SD2->D2_CLIENTE==(cAliasSF3)->F3_CLIEFOR .And. SD2->D2_LOJA==(cAliasSF3)->F3_LOJA
							// Verifica caso seja a mesma CFOP
							If SD2->D2_CF==(cAliasSF3)->F3_CFO
								If SF4->(MsSeek(xFilial("SF4")+SD2->D2_TES))
									// Soma o valor de PIS/COFINS
									IF SF4->F4_AGRPIS $ "1S"
										(cArqCFO)->IMPOSTO += SD2->D2_VALIMP6
									Endif
									If SF4->F4_AGRCOF $ "1S"
										(cArqCFO)->IMPOSTO += SD2->D2_VALIMP5
									Endif
									If SF4->F4_INCIDE $ "N"
										(cArqCFO)->IMPOSTO += SD2->D2_VALIPI
									Endif
								Endif
							Endif
							SD2->( DbSkip() )
						EndDo
					Endif
				EndIf
			EndIF
			(cArqCFO)->TIPOREG	:=  StrZero(nTipoReg,6)
			(cArqCFO)->(MSUnlock())

			If !lRelDIPAM .And. nRegime <> 4
				//������������������������������?
				//�Detalhes Interestaduais CR=14?
				//������������������������������?
				If (cCfop1$"26" .and. cMvUF <> "SP") .or. (cCfop1$"26" .and. !(cUF$cCodUf) .and. cMvUF == "SP")
					If cCfop1=="2"
						cInscr	:= If((cAliasSF3)->F3_TIPO$"DB",(cAliasSA1)->A1_INSCR,(cAliasSA2)->A2_INSCR)
						cTipo  	:= If((cAliasSF3)->F3_TIPO$"DB",(cAliasSA1)->A1_TIPO,(cAliasSA2)->A2_TIPO)
					ElseIf cCfop1=="6"
						cInscr	:= If((cAliasSF3)->F3_TIPO$"DB",(cAliasSA2)->A2_INSCR,(cAliasSA1)->A1_INSCR)
						cTipo  	:= If((cAliasSF3)->F3_TIPO$"DB",(cAliasSA2)->A2_TIPO,(cAliasSA1)->A1_TIPO)
					EndIf
					If !(cArqInt)->(msseek((cAliasSF3)->F3_CFO+cUF+StrZero(nTipoReg,6)))
						If (cArqCFO)->(msseek((cAliasSF3)->F3_CFO+StrZero(nTipoReg,6)))
							RecLocK(cArqCFO,.f.)
							(cArqCFO)->Q14	+=	1						//Quantidade de Registros CR=14
							MsUnlock()
						EndIf

						RecLock(cArqInt,.T.)
						(cArqInt)->CFOP  :=	(cAliasSF3)->F3_CFO				//CFOP
						(cArqInt)->UF	 :=	cUF								//Unidade da Federacao
						(cArqInt)->TIPOREG	:=  StrZero(nTipoReg,6)
					Else
						RecLock(cArqInt,.F.)
					EndIf

					If cCfop1=="2"
						(cArqInt)->VALCONT	+=	(cAliasSF3)->F3_VALCONT		//Valor Contabil de Contribuinte
						(cArqInt)->BASECON	+=	(cAliasSF3)->F3_BASEICM   	//Base de Calculo de Contribuinte
					ElseIf (nAno<2003 .And. cCfop3$"618/619/645/653") .Or. (nAno>=2003 .And. cCfop4$"6107/6108/5307/6307") .or. "ISENT" $Upper(cInscr) .or. (empty(cInscr) .and. cTipo != "L" .and. cCfop1=="6")
						//����������������??
						//�Nao Contribuinte?
						//����������������??
						(cArqInt)->VALNCON	+=	(cAliasSF3)->F3_VALCONT		//Valor Contabil de NAO Contribuinte
						(cArqInt)->BASENCO	+=	(cAliasSF3)->F3_BASEICM 		//Base de Calculo de NAO Contribuinte
					Else
						(cArqInt)->VALCONT	+=	(cAliasSF3)->F3_VALCONT		//Valor Contabil de Contribuinte
						(cArqInt)->BASECON	+=	(cAliasSF3)->F3_BASEICM   	//Base de Calculo de Contribuinte
					EndIf
					If (cRef >= "200201")
						(cArqInt)->IMPOSTO	+=	(cAliasSF3)->F3_VALICM      //Imposto Creditado e Debitado
					Else
						(cArqInt)->IMPOSTO	+=	0      //Imposto Creditado e Debitado
					EndIf
					(cArqInt)->OUTRAS	+=	(cAliasSF3)->F3_OUTRICM        	//Outras operacoes
					(cArqInt)->ISENTA	+=	(cAliasSF3)->F3_ISENICM        	//Isentas/nao tributadas

					If	(cVValid == "0700" .and. cVLayOut == "0200") .or. (cVValid == "0710" .and. cVLayOut == "0201") .or. (cVValid == "0720" .and. cVLayOut == "0202") .Or.;
						(cVValid == "0730" .and. cVLayOut == "0203") .or. (cVValid == "0740" .and. cVLayOut == "0204") .Or. (cVValid == "0750" .and. cVLayOut == "0205") .Or.;
						(cVValid == "0760" .and. cVLayOut == "0206") .Or. (cVValid == "0770" .and. cVLayOut == "0207") .Or. (cVValid == "0780" .and. cVLayOut == "0208") .Or.;
						(cVValid == "0790" .and. cVLayOut == "0209") .Or. (cVValid >= "0800" .and. cVLayOut >= "0210")

						If (cRef<="200212")
							If (cCfop1$"56")
								If (((cCfop1>="571") .And. (cCfop3<="579")) .Or.;
									(cCfop3=="597") .Or.;
									((cCfop3>="671") .And. (cCfop3<="679")) .Or.;
									(cCfop3=="697") .Or.;
									(cCfop3=="99"))

									(cArqInt)->RETIDO	+=	0

								Else
									If (cAliasSF3)->F3_VALANTI == 0
										(cArqInt)->RETIDO	+=	(cAliasSF3)->F3_ICMSRET		//ICMS cobrado por Substituicao Tributaria
									Endif
								EndIf
							ElseIf (cCfop1$"12")
								If (((cCfop3>="171") .And. (cCfop3<="179")) .Or.;
									((cCfop3>="271") .And. (cCfop3<="279")) .Or.;
									(cCfop3=="196") .Or.;
									(cCfop3=="296") .Or.;
									(cCfop3=="99"))

									(cArqInt)->OUTPROD	+=	0							//Outros produtos quando Substituicao Tributaria

								Else
									If (cAliasSF3)->F3_VALANTI == 0
										(cArqInt)->OUTPROD	+=	(cAliasSF3)->F3_ICMSRET		//Outros produtos quando Substituicao Tributaria
									Endif
								EndIf
							EndIf

						ElseIf (cRef>"200212" .And. cRef<="200312")
							If (cCfop1$"56")
								If (((nValCFOP>=5401) .And. (nValCFOP<=5449)) .Or.;
									((nValCFOP>=6401) .And. (nValCFOP<=6449)) .Or.;
									(cCfop2=="59") .Or.;
									(cCfop2=="69"))

									(cArqInt)->RETIDO	+= 0

								Else
									If (cAliasSF3)->F3_VALANTI == 0
										(cArqInt)->RETIDO	+=	(cAliasSF3)->F3_ICMSRET	 	//ICMS cobrado por Substituicao Tributaria
									Endif
								EndIf
							ElseIf (cCfop1$"12")
								If (((nValCFOP>=1401) .And. (nValCFOP<=1449)) .Or.;
									((nValCFOP>=2401) .And. (nValCFOP<=2449)) .Or.;
									(cCfop2=="19") .Or.;
									(cCfop2=="29"))

									(cArqInt)->OUTPROD	+= 0

								Else
									If  (cAliasSF3)->F3_VALANTI == 0
										(cArqInt)->OUTPROD	+=	(cAliasSF3)->F3_ICMSRET		//Outros produtos quando Substituicao Tributaria
									Endif

								EndIf
							EndIf

						ElseIf (cRef>"200312" .And. cRef<="200712")
							If (cCfop1$"56")
								If (((nValCFOP>=5401) .And. (nValCFOP<=5449)) .Or.;
									((nValCFOP>=5651) .And. (nValCFOP<=5699)) .Or.;
									((nValCFOP>=6401) .And. (nValCFOP<=6449)) .Or.;
									((nValCFOP>=6651) .And. (nValCFOP<=6699)) .Or.;
									(cCfop2=="59") .Or.;
									(cCfop2=="69"))

									(cArqInt)->OUTPROD	+= 0

								Else
									If (cAliasSF3)->F3_VALANTI == 0
										(cArqInt)->OUTPROD	+=	(cAliasSF3)->F3_ICMSRET		//Outros produtos quando Substituicao Tributaria
									Endif

								EndIf
							ElseIf (cCfop1$"12")
								If (((nValCFOP>=1401) .And. (nValCFOP<=1449)) .Or.;
									((nValCFOP>=1651) .And. (nValCFOP<=1699)) .Or.;
									((nValCFOP>=2401) .And. (nValCFOP<=2449)) .Or.;
									((nValCFOP>=2651) .And. (nValCFOP<=2699)) .Or.;
									(cCfop2=="19") .Or.;
									(cCfop2=="29"))

									(cArqInt)->OUTPROD	+= 0

								Else
									If (cAliasSF3)->F3_VALANTI == 0
										(cArqInt)->OUTPROD	+=	(cAliasSF3)->F3_ICMSRET		//Outros produtos quando Substituicao Tributaria
									Endif
								EndIf
							EndIf
						ElseIf	(cRef>"200712" .And. cRef<="200804")
							If (cCfop1$"56")
								If (((nValCFOP>=5401) .And. (nValCFOP<=5449)) .Or.;
									((nValCFOP>=5651) .And. (nValCFOP<=5699)) .Or.;
									((nValCFOP>=6401) .And. (nValCFOP<=6449)) .Or.;
									((nValCFOP>=6651) .And. (nValCFOP<=6699)) .Or.;
									(nValCFOP==5360)) .Or.;
									(cCfop2=="69")

									(cArqInt)->OUTPROD	+= 0

								Else
									If (cAliasSF3)->F3_VALANTI == 0
										(cArqInt)->OUTPROD	+=	(cAliasSF3)->F3_ICMSRET		//Outros produtos quando Substituicao Tributaria
									Endif
								EndIf
							ElseIf (cCfop1$"12")
								If (((nValCFOP<>1360) .And. (nValCFOP>=1401) .And. (nValCFOP<=1449)) .Or.;
									((nValCFOP>=1651) .And. (nValCFOP<=1699)) .Or.;
									((nValCFOP>=2401) .And. (nValCFOP<=2449)) .Or.;
									((nValCFOP>=2651) .And. (nValCFOP<=2699)) .Or.;
									(cCfop2=="19") .Or.;
									(cCfop2=="29"))

									(cArqInt)->OUTPROD	+= 0

								Else
									If (cAliasSF3)->F3_VALANTI == 0
										(cArqInt)->OUTPROD	+=	(cAliasSF3)->F3_ICMSRET		//Outros produtos quando Substituicao Tributaria
									Endif
								EndIf
							EndIf
						Else //(cRef>"200804")
							If (cCfop1$"56")
								If (((nValCFOP>=5401) .And. (nValCFOP<=5449)) .Or.;
									((nValCFOP>=5651) .And. (nValCFOP<=5699)) .Or.;
									((nValCFOP>=6401) .And. (nValCFOP<=6449)) .Or.;
									((nValCFOP>=6651) .And. (nValCFOP<=6699)) .Or.;
									((nValCFOP==5360)) .Or.;
									((nValCFOP==6360)) .Or.;
									(cCfop2=="59").Or.;
									(cCfop2=="69"))
									If (cAliasSF3)->F3_VALANTI == 0 .And. nValCFOP<>6107 .And. nValCFOP<>6109 .And. nValCFOP<>6110 .And. nValCFOP<>6119
										(cArqInt)->RETIDO	+=	(cAliasSF3)->F3_ICMSRET		//Outros produtos quando Substituicao Tributaria
									Endif
								Else
									(cArqInt)->RETIDO	+= 0
								EndIf

							ElseIf (cCfop1$"12")
								If (((nValCFOP<>1360) .And. (nValCFOP>=1401) .And. (nValCFOP<=1449)) .Or.;
									((nValCFOP>=1651) .And. (nValCFOP<=1699)) .Or.;
									((nValCFOP>=2401) .And. (nValCFOP<=2449)) .Or.;
									((nValCFOP>=2651) .And. (nValCFOP<=2699)) .Or.;
									(cCfop2=="19") .Or.;
									(cCfop2=="29"))
									If  (cAliasSF3)->F3_VALANTI == 0
										(cArqInt)->OUTPROD	+=	(cAliasSF3)->F3_ICMSRET		//Outros produtos quando Substituicao Tributaria
									Endif
								Else
									(cArqInt)->OUTPROD	+= 0
								EndIf
							EndIf
						EndIf
					EndIf
					MsUnlock()
					//����������������������������������������������������Ŀ
					//�Zona Franca de Manaus /Areas de Livre Comercio CR=18?
					//������������������������������������������������������
					//Tratamento em DBF para gera��o do Registro CR=18. O tratamento em ambiente TOP ser?tratado posteriormente
					//devido uma altera��o de melhoria de processamento, pois quando o processamento ?e top,
					//o loop da SF3 ?feito de forma agrupada, e como este registro necessito de informa��es no n�vel
					//de item, por este morivo est?sendo tratado posteriormente.
					If !lTop .AND. cCfop1=="6" .and. (cAliasSF3)->F3_ESTADO $ "AC/AP/AM/RO/RR/" .and. (cAliasSF3)->F3_ISENICM > 0
						cCGC		:=	""
						cCodMun		:=	""
						lZFranca	:= .T.
						//��������������������������������������������������������������Ŀ
						//?Verifica se Cliente X Fornecedor e pega Insc. Estadual       ?
						//����������������������������������������������������������������
						If (cAliasSF3)->F3_TIPO$"BD"
							cCGC	:=	(cAliasSA2)->A2_CGC
							If lA2_CODMUN
								cCodMun	:=	(cAliasSA2)->A2_CODMUN
							Endif
						Else
							If lTms
								//����������������������������������������������������Ŀ
								//?Integracao com TMS                                 ?
								//������������������������������������������������������
								PosTms ((cAliasSF3)->F3_NFISCAL, (cAliasSF3)->F3_SERIE)
								//
								If Empty ((cAliasSA1)->A1_SUFRAMA) .Or. (cAliasSA1)->A1_CALCSUF=="N"
									lZFranca	:= .F.
								Endif
								//
								cCGC	:=	(cAliasSA1)->A1_CGC
								//
								If lA2_CODMUN
									cCodMun	:=	(cAliasSA1)->A1_CODMUN
								Endif
							Else
								If Empty((cAliasSA1)->A1_SUFRAMA) .Or. (cAliasSA1)->A1_CALCSUF=="N"
									lZFranca	:= .F.
								Endif
								cCGC	:=	(cAliasSA1)->A1_CGC
								If lA2_CODMUN
									cCodMun:=(cAliasSA1)->A1_CODMUN
								Endif

							EndIf
						Endif
						//��������������������������������������������������������������Ŀ
						//?Valida codigo do municipio                                   ?
						//����������������������������������������������������������������
						If SX5->(!msseek(xFilial()+"S1"+cCodMun))
							lZFranca	:= .F.
						EndIf
						If lZFranca
							RECLOCK(cArqZFM,.T.)
							(cArqZFM)->CFOP		:=	(cAliasSF3)->F3_CFO	 //CFOP
							(cArqZFM)->UF		:=	cUF //Unidade de Federacao
							(cArqZFM)->NFISCAL	:=	(cAliasSF3)->F3_NFISCAL	//Nota Fiscal
							(cArqZFM)->EMISSAO	:=	(cAliasSF3)->F3_EMISSAO	//Data da Emissao
							(cArqZFM)->VALOR	:=	(cAliasSF3)->F3_VALCONT //Valor da nota fiscal
							(cArqZFM)->CNPJDES	:=	cCGC	//CGC do destinatario
							(cArqZFM)->MUNICIP	:=	cCodMun	//Codigo do Municipio
							(cArqZFM)->TIPOREG	:=	StrZero(nTipoReg,6)
							MSUnlock()

							//������������������������������������������������������?
							//�Indica no Registro Detalhes Interestaduais que existe?
							//�operacoes beneficiadas por Isencao do ICMS.          ?
							//������������������������������������������������������?
							If (cArqInt)->(msseek((cAliasSF3)->F3_CFO+cUF+StrZero(nTipoReg,6)))
								RecLock(cArqInt,.F.)
								If Alltrim((cAliasSF3)->F3_CFO)<>"6107" .And. Alltrim((cAliasSF3)->F3_CFO)<>"6108"
									(cArqInt)->BENEF	:= "1"
									(cArqInt)->Q18	+=	1
								Endif
								MsUnlock()
							EndIf
						EndIf
					EndIf //Zona Franca
				EndIf //Detalhes interestaduais
			EndIf
		Endif

		If lRelDIPAM .OR. nRegime <> 4
			//��������������?
			//�DIPAM B CR=30?
			//��������������?
			If lMA972MUN //-- CODIGO DE MUNICIPIO do cliente na geracao da Nova Gia, no quadro DIPAM B, CR = 30
				cCod_Mun := ExecBlock("MA972MUN",.F.,.F.,{cAliasSF3})
			Else
				cCod_Mun := A972RetMun (cAliasSf3, lTms, cMvEstado, cMVCODDP, cMVCODMUN, lA1CODMUN,cCodMunX)
			EndIf
			//--
			If ( Year(dDtFim) >= 2001 )
				If cCfop1 > "5"
					If	lTms
						cCodMunDp := StrZero(val(Alltrim(cCod_Mun)),5,0)
					Else
						If lMA972MUN .And. Alltrim(cCod_Mun)<>''
							cCodMunDp := StrZero(val(Alltrim(cCod_Mun)),5,0)
						Else
							cCodMunDp := StrZero(val(Alltrim(GetNewPar("MV_CODDP", "1004"))),5,0)
						EndIf
					EndIf
				Elseif cCfop1< "5"
					If lMV_MUNA2
						If SA2->(msseek(xFilial()+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA,.F.))
							cCodMunDp	:= StrZero(Val(Alltrim(SA2->(FieldGet(FieldPos(SuperGetMv("MV_MUNA2")))))),5,0)
						EndIF
					Else
						cCodMunDp	:= "00000"
					EndIf

				Else
					cCodMunDp := StrZero(val(Alltrim(cCod_Mun)),5,0)
				EndIf
				Do Case
					Case (cVLayOut=="0208" .And. Alltrim(SM0->M0_CNAE)=='5620101') .Or. ; //tratamento para CNAE de Refeicoes fora do Municipio
					     (cCnae$"5620101/5131400/5146201/5241804/5524701") .And. ;
					     ( (nAno<2003  .And. cCfop3$"511/512/514/515") .Or. ;
					       (nAno>=2003 .And. cCfop4$"5101/5102/5103/5104") )
						If ( (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM > 0 )
							dbSelectArea(cArqDipam)
							dbSetOrder(1)
							If !lRelDIPAM
								If msseek("22"+cCodMunDp+StrZero(nTipoReg,6))
									RecLock(cArqDipam,.F.)
								Else
									RecLock(cArqCabec,.F.)
									(cArqCabec)->Q30	+=	1
									MsUnLock()
									RecLock(cArqDipam,.T.)
									CODDIP := "22"
									MUNICIP:= cCodMunDp
									(cArqDipam)->TIPOREG	:=  StrZero(nTipoReg,6)
								EndIf
								VALOR  += (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
								MsUnLock()
							Else
								RecLock(cArqDipam,.T.)
								FILIAL		:= (cAliasSF3)->F3_FILIAL
								CFOP		:= (cAliasSF3)->F3_CFO
								ENT_SAI 	:= "S"
								TIPO		:= (cAliasSF3)->F3_TIPO 	//Tipo da NF: N-Normal, D-Devolucao, B-Beneficiamento
								SERIE		:= (cAliasSF3)->F3_SERIE
								NOTA		:= (cAliasSF3)->F3_NFISCAL
								CLIFOR		:= (cAliasSF3)->F3_CLIEFOR
								LOJA		:= (cAliasSF3)->F3_LOJA
								ESTADO 		:= (cAliasSF3)->F3_ESTADO
								MUNICIP		:= Substr((cAliasSA1)->A1_MUN,1,26)
								CODDIP 		:= "22"
								VALOR  		:= (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
								MsUnLock()
							Endif
						EndIf
					Case ( (nAno<2003 .And. cCfop3$"561/562/563/661/662/663/761") .Or. (nAno>=2003 .And. cCfop4$"5351/5352/5353/5354/5355/5356/5357/5358/5359/5360/6351/6352/6353/6354/6355/6356/6357/6358/6359/6360/7358" .Or. (cCfop4$"1351/2351/3355" .and. !lRelDIPAM)))
						If ( (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM > 0 )
							dbSelectArea(cArqDipam)
							dbSetOrder(1)
							n23Ent := 0
							n23Sai := 0
							If !lRelDIPAM
								If cCfop4$"1351/2351/3355"
									n23Ent += (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
								Else
									n23Sai += (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
								Endif
								If msseek("23"+cCodMunDp+StrZero(nTipoReg,6))
									RecLock(cArqDipam,.F.)
								Else
									RecLock(cArqCabec,.F.)
									(cArqCabec)->Q30	+=	1
									MsUnLock()
									RecLock(cArqDipam,.T.)
									CODDIP := "23"
									MUNICIP:= cCodMunDp
									(cArqDipam)->TIPOREG	:=  StrZero(nTipoReg,6)
								EndIf
								/* REALIZADO TRATAMENTO PARA PONTO DE ENTRADA MA972VLR
								Sera ignorada todas as notas de sa�da que ponto de entrada altere valor para 1.

								Quando ponto de entrada retornar todas as sa�das de determinado munic�pio que se enquadre nas regras dos registros 2.3,2.4 e 2.5, registro ser?preenchido com valor um real (R$ 1,00) no arquivo da Nova Gia na CR30.
								*/
								If n23ent > 0
									VALORENT += n23ent
								Else
									If lMA972VLR
										nValor := ExecBlock("MA972VLR",.F.,.F.,{'23',cAliasSF3,n23sai})
										If ValType(nValor)<>"N"
											nValor := 0
										Endif
										If nValor == 1
											aadd(aDipamB23,{'23',cCodMunDp}) /*adiciono array para verificar no fim das notas se este 
																			municipio n�o possui outras saidas que ponto n�o alterou*/
										Else
											VALOR += n23sai  // somente ?somavo valor no cArqDipam quando ponto n�o alterou seu valor para 1.
										Endif
									Else
										VALOR += n23sai
									Endif
								Endif
								MsUnLock()
							Else
								RecLock(cArqDipam,.T.)
								FILIAL		:= (cAliasSF3)->F3_FILIAL
								CFOP		:= (cAliasSF3)->F3_CFO
								ENT_SAI 	:= "S"
								TIPO		:= (cAliasSF3)->F3_TIPO 	//Tipo da NF: N-Normal, D-Devolucao, B-Beneficiamento
								SERIE		:= (cAliasSF3)->F3_SERIE
								NOTA		:= (cAliasSF3)->F3_NFISCAL
								CLIFOR		:= (cAliasSF3)->F3_CLIEFOR
								LOJA		:= (cAliasSF3)->F3_LOJA

								If lTms .And. lRelDIPAM
									If DT6->(MsSeek(xFilial("DT6")+(cAliasSF3)->(F3_FILIAL+F3_NFISCAL+F3_SERIE)))
										If DUY->(MsSeek(XFilial("DUY")+DT6->DT6_CDRORI))
											ESTADO := DUY->DUY_EST
											MUNICIP:= DUY->DUY_DESCRI
										EndIf
									EndIf
								Else
									ESTADO	:= (cAliasSF3)->F3_ESTADO
									MUNICIP	:= Substr((cAliasSA1)->A1_MUN,1,26)
								EndIf

								CODDIP 		:= "23"
								VALOR  		:= (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
								MsUnLock()
							Endif
						EndIf
					Case (nAno<2003 .And. cCfop3$"551/552/553") //.Or. (nAno>2003 .And. cCfop4$"5301/5302/5303/5304/5305/5306/5307/6301/6302/6303/6304/6305/6306/7301"))
						dbSelectArea(cArqDipam)
						dbSetOrder(1)
						If !lRelDIPAM
							n24Sai += (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
							If msseek("24"+cCodMunDp+StrZero(nTipoReg,6))
								RecLock(cArqDipam,.F.)
							Else
								RecLock(cArqCabec,.F.)
								(cArqCabec)->Q30	+=	1
								MsUnLock()
								RecLock(cArqDipam,.T.)
								CODDIP := "24"
								MUNICIP:= cCodMunDp
								(cArqDipam)->TIPOREG	:=  StrZero(nTipoReg,6)
							EndIf
							VALOR  += (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
							MsUnLock()
						Else
							RecLock(cArqDipam,.T.)
							FILIAL		:= (cAliasSF3)->F3_FILIAL
							CFOP		:= (cAliasSF3)->F3_CFO
							ENT_SAI 	:= "S"
							TIPO		:= (cAliasSF3)->F3_TIPO 	//Tipo da NF: N-Normal, D-Devolucao, B-Beneficiamento
							SERIE		:= (cAliasSF3)->F3_SERIE
							NOTA		:= (cAliasSF3)->F3_NFISCAL
							CLIFOR		:= (cAliasSF3)->F3_CLIEFOR
							LOJA		:= (cAliasSF3)->F3_LOJA

							If lTms .And. lRelDIPAM
								If DT6->(MsSeek(xFilial("DT6")+(cAliasSF3)->(F3_FILIAL+F3_NFISCAL+F3_SERIE)))
									If DUY->(MsSeek(XFilial("DUY")+DT6->DT6_CDRORI))
										ESTADO := DUY->DUY_EST
										MUNICIP:= DUY->DUY_DESCRI
									EndIf
								EndIf
							Else
								ESTADO	:= (cAliasSF3)->F3_ESTADO
								MUNICIP	:= Substr((cAliasSA1)->A1_MUN,1,26)
							EndIf

							CODDIP 		:= "24"
							VALOR  		:= (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
							MsUnLock()
						Endif
					Case ( (nAno<2003 .And. cCfop3$"541/542/543/544/545/546/641/642/643/644/645/646") .Or. (nAno>=2003 .And. cCfop4$"5251/5252/5253/5254/5255/5256/5257/5258/6251/6252/6253/6254/6255/6256/6257/6258/7251") )
						dbSelectArea(cArqDipam)
						dbSetOrder(1)
						If !lRelDIPAM
							If msseek("25"+cCodMunDp+StrZero(nTipoReg,6))
								RecLock(cArqDipam,.F.)
							Else
								RecLock(cArqCabec,.F.)
								(cArqCabec)->Q30	+=	1
								MsUnLock()
								RecLock(cArqDipam,.T.)
								CODDIP := "25"
								MUNICIP:= cCodMunDp 
								(cArqDipam)->TIPOREG	:=  StrZero(nTipoReg,6)
							EndIf
							n25Sai  := (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
							/* REALIZADO TRATAMENTO PARA PONTO DE ENTRADA MA972VLR
							Sera ignorada todas as notas de sa�da que ponto de entrada altere valor para 1.

							Quando ponto de entrada retornar todas as sa�das de determinado munic�pio que se enquadre nas regras dos registros 2.3,2.4 e 2.5, registro ser?preenchido com valor um real (R$ 1,00) no arquivo da Nova Gia na CR30.								
							*/
							If lMA972VLR
								nValor := ExecBlock("MA972VLR",.F.,.F.,{'25',cAliasSF3,n25Sai})
								If ValType(nValor)<>"N"
									nValor := 0
								Endif
								If nValor == 1
									aadd(aDipamB25,{'25',cCodMunDp})/*adiciono array para verificar no fim das notas se este
																	municipio n�o possui outras saidas que ponto n�o alterou*/
								Else // somente ?somavo valor no cArqDipam quando ponto n�o alterou seu valor para 1.
									VALOR += n25Sai
								Endif
							Else
								VALOR += n25Sai
							Endif
							MsUnLock()
						Else
							RecLock(cArqDipam,.T.)
							FILIAL		:= (cAliasSF3)->F3_FILIAL
							CFOP		:= (cAliasSF3)->F3_CFO
							ENT_SAI 	:= "S"
							TIPO		:= (cAliasSF3)->F3_TIPO 	//Tipo da NF: N-Normal, D-Devolucao, B-Beneficiamento
							SERIE		:= (cAliasSF3)->F3_SERIE
							NOTA		:= (cAliasSF3)->F3_NFISCAL
							CLIFOR		:= (cAliasSF3)->F3_CLIEFOR
							LOJA		:= (cAliasSF3)->F3_LOJA

							If lTms .And. lRelDIPAM
								If DT6->(MsSeek(xFilial("DT6")+(cAliasSF3)->(F3_FILIAL+F3_NFISCAL+F3_SERIE)))
									If DUY->(MsSeek(XFilial("DUY")+DT6->DT6_CDRORI))
										ESTADO := DUY->DUY_EST
										MUNICIP:= DUY->DUY_DESCRI
									EndIf
								EndIf
							Else
								ESTADO	:= (cAliasSF3)->F3_ESTADO
								MUNICIP	:= Substr((cAliasSA1)->A1_MUN,1,26)
							EndIf

							CODDIP 		:= "25"
							VALOR  		:= (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
							MsUnLock()
						Endif
					//Compra Escriturada de Mercadorias de Produtores Agropecuarios
					Case cCfop1=="1" .And. !Empty((cAliasSA2)->A2_TIPORUR) .And. Alltrim((cAliasSF3)->F3_CFO)$cDip11
						dbSelectArea(cArqDipam)
						dbSetOrder(1)
						If !lRelDIPAM
							If msseek("11"+cCodMunDp+StrZero(nTipoReg,6))
								RecLock(cArqDipam,.F.)
							Else
								RecLock(cArqCabec,.F.)
								(cArqCabec)->Q30	+=	1
								MsUnLock()
								RecLock(cArqDipam,.T.)
								CODDIP := "11"
								MUNICIP:= cCodMunDp
								(cArqDipam)->TIPOREG	:=  StrZero(nTipoReg,6)
							EndIf
							VALOR  += (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
							MsUnLock()
						Else
							RecLock(cArqDipam,.T.)
							FILIAL		:= (cAliasSF3)->F3_FILIAL
							CFOP		:= (cAliasSF3)->F3_CFO
							ENT_SAI 	:= "E"
							TIPO		:= (cAliasSF3)->F3_TIPO 	//Tipo da NF: N-Normal, D-Devolucao, B-Beneficiamento
							SERIE		:= (cAliasSF3)->F3_SERIE
							NOTA		:= (cAliasSF3)->F3_NFISCAL
							CLIFOR		:= (cAliasSF3)->F3_CLIEFOR
							LOJA		:= (cAliasSF3)->F3_LOJA
							ESTADO 		:= (cAliasSF3)->F3_ESTADO
							MUNICIP		:= Substr((cAliasSA2)->A2_MUN,1,26)
							CODDIP 		:= "11"
							VALOR  		:= (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
							MsUnLock()
						Endif
					//Recebimento por Cooperativa de Mercadoria remetida por Produtores Agropecuarios
					Case cCfop1=="1" .And. !Empty((cAliasSA2)->A2_TIPORUR) .And. Alltrim((cAliasSF3)->F3_CFO)$cDip13
						dbSelectArea(cArqDipam)
						dbSetOrder(1)
						If !lRelDIPAM
							If msseek("13"+cCodMunDp+StrZero(nTipoReg,6))
								RecLock(cArqDipam,.F.)
							Else
								RecLock(cArqCabec,.F.)
								(cArqCabec)->Q30	+=	1
								MsUnLock()
								RecLock(cArqDipam,.T.)
								CODDIP := "13"
								MUNICIP:= cCodMunDp
								(cArqDipam)->TIPOREG	:=  StrZero(nTipoReg,6)
							EndIf
							VALOR  += (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
							MsUnLock()
						Else
							RecLock(cArqDipam,.T.)
							FILIAL		:= (cAliasSF3)->F3_FILIAL
							CFOP		:= (cAliasSF3)->F3_CFO
							ENT_SAI 	:= "E"
							TIPO		:= (cAliasSF3)->F3_TIPO 	//Tipo da NF: N-Normal, D-Devolucao, B-Beneficiamento
							SERIE		:= (cAliasSF3)->F3_SERIE
							NOTA		:= (cAliasSF3)->F3_NFISCAL
							CLIFOR		:= (cAliasSF3)->F3_CLIEFOR
							LOJA		:= (cAliasSF3)->F3_LOJA
							ESTADO 		:= (cAliasSF3)->F3_ESTADO
							MUNICIP		:= Substr((cAliasSA2)->A2_MUN,1,26)
							CODDIP 		:= "13"
							VALOR  		:= (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
							MsUnLock()
						Endif
					Case ((nAno>=2003 .And. (cCfop4$"5301/5302/5303/5304/5305/5306/5307/6301/6302/6303/6304/6305/6306/6307/7301") .OR. cCfop4$"1301/2301/3301"))
						dbSelectArea(cArqDipam)
						dbSetOrder(1)
						If !lRelDIPAM
							n24Ent:=0
							n24Sai:=0
							If cCfop4$"1301/2301/3301"
								n24Ent += (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
							Else
								n24Sai += (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
							Endif
							If msseek("24"+cCodMunDp+StrZero(nTipoReg,6))
								RecLock(cArqDipam,.F.)
							Else
								RecLock(cArqCabec,.F.)
								(cArqCabec)->Q30	+=	1
								MsUnLock()
								RecLock(cArqDipam,.T.)
								CODDIP := "24"
								MUNICIP:= cCodMunDp
								(cArqDipam)->TIPOREG	:=  StrZero(nTipoReg,6)
							EndIf
							/* REALIZADO TRATAMENTO PARA PONTO DE ENTRADA MA972VLR
							Sera ignorada todas as notas de sa�da que ponto de entrada altere valor para 1.

							Quando ponto de entrada retornar todas as sa�das de determinado munic�pio que se enquadre nas regras dos registros 2.3,2.4 e 2.5, registro ser?preenchido com valor um real (R$ 1,00) no arquivo da Nova Gia na CR30.								
							*/
							If n24ent > 0
								VALORENT += n24ent
							Else
								If lMA972VLR
									nValor := ExecBlock("MA972VLR",.F.,.F.,{'24',cAliasSF3,n24sai})
									If ValType(nValor)<>"N"
										nValor := 0
									Endif
									If nValor == 1
										aadd(aDipamB24,{'24',cCodMunDp}) /*adiciono array para verificar no fim das notas se este
																			municipio n�o possui outras saidas que ponto n�o alterou*/
									Else	// somente ?somavo valor no cArqDipam quando ponto n�o alterou seu valor para 1.
										VALOR += n24Sai
									Endif
								Else
									VALOR += n24Sai
								Endif
							Endif
							MsUnLock()
						Else
							RecLock(cArqDipam,.T.)
							FILIAL		:= (cAliasSF3)->F3_FILIAL
							CFOP		:= (cAliasSF3)->F3_CFO
							ENT_SAI 	:= "S"
							TIPO		:= (cAliasSF3)->F3_TIPO 	//Tipo da NF: N-Normal, D-Devolucao, B-Beneficiamento
							SERIE		:= (cAliasSF3)->F3_SERIE
							NOTA		:= (cAliasSF3)->F3_NFISCAL
							CLIFOR		:= (cAliasSF3)->F3_CLIEFOR
							LOJA		:= (cAliasSF3)->F3_LOJA
							ESTADO 		:= (cAliasSF3)->F3_ESTADO
							MUNICIP		:= Substr((cAliasSA1)->A1_MUN,1,26)
							CODDIP 		:= "24"
							VALOR  		:= (cAliasSF3)->F3_BASEICM + (cAliasSF3)->F3_ISENICM + (cAliasSF3)->F3_OUTRICM
							MsUnLock()
						Endif
				EndCase
			EndIf

			//��������������������Ŀ
			//�Reg Exportacao CR=31?
			//����������������������
			//Aqui ser�o tratados opera��es de exporta��es caso o ambiene seja DBF, caso for TOP, ser?tratado em uma query separada,
			//para que o tratamento das notas possam ser gerados se forma agrupada.
			If !lTop .AND. !lRelDIPAM .And. lD2_Re
				lGeraExp := .T.
				If	((cVValid == "0740" .and. cVLayOut == "0204") .And. (cRef<="200112")) .Or.;
					((cVValid == "0750" .and. cVLayOut == "0205") .And. (cRef<="200112")) .Or.;
					((cVValid == "0760" .and. cVLayOut == "0206") .And. (cRef<="200112")) .Or.;
					((cVValid == "0770" .and. cVLayOut == "0207") .And. (cRef<="200112")) .Or.;
					((cVValid == "0780" .and. cVLayOut == "0208") .And. (cRef<="200112")) .or.;
					((cVValid == "0790" .and. cVLayOut == "0209") .And. (cRef<="200112")) .Or.;
					((cVValid >= "0800" .and. cVLayOut >= "0210") .And. (cRef<="200112"))
					lGeraExp := .F.
				Endif
				If lGeraExp
					If SD2->(msseek(xFilial("SD2")+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE))
						While SD2->(!Eof()) .and. (cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE == SD2->D2_DOC+SD2->D2_SERIE .and.;
								(xFilial("SD2") == (cAliasSF3)->F3_FILIAL)
							dbSelectArea(cArqExpt)
							dbSetOrder(1)
							nT  		:= 0
							//Se tiver integra��o para com EEC e o campo nao estiver criado, emitir aviso e retornar.
							If SD2->(FieldPos(cD2_Re))==0 .and. SuperGetMV("MV_EECFAT")
								Aviso("Integra��o com o m�dulo SIGAEEC Habilitada ","Por favor crie o campo " + cD2_Re + " via configurador.",{"Ok"}) //N�o foi possivel excluir a nota, pois a mesma j?foi transmitida e encotra-se bloqueada. Ser?necess�rio realizar a primeiro a classifica��o da nota e posteriormente a exclus�o!"
								return
							EndIf
							If lD2_Re .And. "D2_"$cD2_Re
								cRe := SD2->&cD2_Re
							Endif
							For nT:=33 to 255
								If (nT >= 33 .and. nT <= 47) .or. (nT >= 58 .and. nT <= 64) .or. (nT >= 91 .and. nT <= 96) .or. (nT >= 123 .and. nT <= 255)
									If (at(CHR(nT),cRe)) > 0
										cRe := StrTran(cRe,CHR(nT),"")
									EndIf
								EndIf
							Next nT
							cRe := If(Empty(cRe),cRe,Strzero(val(Alltrim(cRe)),15,0))

							If !Empty(cRe) .And. (cArqExpt)->(!msseek(cRe))
								RecLock(cArqExpt,.T.)
								(cArqExpt)->RE := cRe
								(cArqExpt)->TIPOREG	:=  StrZero(nTipoReg,6)
								MsUnLock()
								RecLock(cArqCabec,.F.)
								(cArqCabec)->Q31	+=	1
								MsUnLock()
							EndIf

							SD2->(dbSkip())
						EndDo
					EndIf
				EndIf
			//��������������������Ŀ
			//�Reg Exportacao CR=31?
			//����������������������
			Elseif !lTop  .AND. !lRelDIPAM .And. !lD2_Re
				lGeraExp := .T.
				If	((cVValid == "0740" .and. cVLayOut == "0204") .And. (cRef<="200112")) .Or.;
					((cVValid == "0750" .and. cVLayOut == "0205") .And. (cRef<="200112")) .Or.;
					((cVValid == "0760" .and. cVLayOut == "0206") .And. (cRef<="200112")) .Or.;
					((cVValid == "0770" .and. cVLayOut == "0207") .And. (cRef<="200112")) .Or.;
					((cVValid == "0780" .and. cVLayOut == "0208") .And. (cRef<="200112")) .or.;
					((cVValid == "0790" .and. cVLayOut == "0209") .And. (cRef<="200112")) .Or.;
					((cVValid >= "0800" .and. cVLayOut >= "0210") .And. (cRef<="200112"))
					lGeraExp := .F.
				Endif

				If lGeraExp
					If SD2->(msseek(xFilial("SD2")+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE))

						dbSelectArea(cArqExpt)
						dbSetOrder(1)

						If EE9->(msseek(xFilial("EE9")+SD2->D2_PREEMB))

						//������������������������������������������������������������������������������������������������Ŀ
						//�Processamento da funcao da Average que retorna os avisos de embarque conforme regras do SIGAEEC ?
						//|Conforme solicitado nos Chamados: THMQEB e THMOIB, he necess�rio as datas de RE e DSE para o R31|
						//|                     FUNCAO DISPONIBILIZADA PELA AVEGARE - FONTE AVGERAL.PRW                    |
						//��������������������������������������������������������������������������������������������������
							acRe := EasySpedRes(cValToChar(Month(EE9->EE9_DTAVRB)),cValToChar(Year(EE9->EE9_DTAVRB)))
							If Len(acRe) > 0
								If aScan(acRebk,{|aX|aX==acRe[1][2]})==0
									For nx:= 1 to Len(acRe)
										cRe := Strzero(val(Alltrim(acRe[nx][2])),15,0)
										RecLock(cArqExpt,.T.)
										(cArqExpt)->RE := cRe
										(cArqExpt)->TIPOREG	:=  StrZero(nTipoReg,6)
										MsUnLock()
										RecLock(cArqCabec,.F.)
										(cArqCabec)->Q31 +=	 1
										MsUnLock()
									Next nx
									Aadd(acRebk,acRe[1][2])
								EndIf
							EndIf
						Endif
					EndIf
				EndIf
			EndIf
		Endif
		(cAliasSF3)->( dbSkip() )
	End

	//��������������������������Ŀ
	//Tratar aqui ZF e Exporta��o
	//��������������������������Ŀ

	//este trecho do zona franca ?realizado aqui fora do loop da SF3, pois trata de informa��o a n�vel de documento
	//por efeito de performance o trecho do loop da SF3 foi alterado para que seja processado de forma agrupada, por este
	//motivo este trecho foi separado e ser?tratado aqui especificamente quando ambiente TOP, para ambiente 
	//DBF o processamento ser?mantido anterior.
	If lTop .AND. !lRelDIPAM

		cSlctSFT	:= "%SF3.F3_CLIEFOR, SF3.F3_LOJA, SF3.F3_TIPO, SF3.F3_NFISCAL, SF3.F3_SERIE, SF3.F3_CFO, SF3.F3_EMISSAO, SF3.F3_VALCONT, SF3.F3_ESTADO%"
		cFiltro := "%SF3.F3_FILIAL = '"+xFilial("SF3")+"' AND "
		cFiltro += "SF3.F3_ENTRADA >= '"+DTOS(dDtIni)+"' AND "
		cFiltro += "SF3.F3_ENTRADA <= '"+DTOS(dDtFim)+"' AND "
		cFiltro += "SUBSTRING(SF3.F3_CFO,1,1) = '6' AND SF3.F3_ESTADO IN ('AC','AP', 'AM' ,'RO' ,'RR') and SF3.F3_ISENICM > 0 AND "
		If cNrLivro <> "*"
			cFiltro += "F3_NRLIVRO ='"+ cNrLivro +"' AND "
		EndIf
		cFiltro += "SF3.F3_DTCANC =' ' AND %"

		cAliasF3	:=	GetNextAlias()
		BeginSql Alias cAliasF3

			SELECT
			%Exp:cSlctSFT%

			FROM
			%Table:SF3% SF3
			WHERE
			%Exp:cFiltro%
			SF3.%NotDel%
		EndSql

		TcSetField(cAliasF3,"F3_EMISSAO","D",8,0)

		Do While !(cAliasF3)->(EOF())
			cCGC		:=	""
			cCodMun	:=	""
			lZFranca	:= .T.
			cUF := A972CodUF((cAliasF3)->F3_ESTADO)

			SA1->(msseek(xFilial("SA1")+(cAliasF3)->F3_CLIEFOR+(cAliasF3)->F3_LOJA,.F.))
			SA2->(msseek(xFilial("SA2")+(cAliasF3)->F3_CLIEFOR+(cAliasF3)->F3_LOJA,.F.))

			//��������������������������������������������������������������Ŀ
			//?Verifica se Cliente X Fornecedor e pega Insc. Estadual       ?
			//����������������������������������������������������������������
			If (cAliasF3)->F3_TIPO$"BD"
				cCGC	:=	SA2->A2_CGC
				If lA2_CODMUN
					cCodMun	:=	SA2->A2_CODMUN
				Endif
			Else
				If lTms
					//����������������������������������������������������Ŀ
					//?Integracao com TMS                                 ?
					//������������������������������������������������������
					PosTms ((cAliasF3)->F3_NFISCAL, (cAliasF3)->F3_SERIE)
					//
					If Empty (SA1->A1_SUFRAMA) .Or. SA1->A1_CALCSUF=="N"
						lZFranca	:= .F.
					Endif
					//
					cCGC	:=	SA1->A1_CGC
					//
					If lA2_CODMUN
						cCodMun	:=	SA1->A1_CODMUN
					Endif
				Else
					If Empty(SA1->A1_SUFRAMA) .Or. SA1->A1_CALCSUF=="N"
						lZFranca	:= .F.
					Endif
					cCGC	:=	SA1->A1_CGC
					If lA2_CODMUN
						cCodMun:=SA1->A1_CODMUN
					Endif
				EndIf
			Endif
			//��������������������������������������������������������������Ŀ
			//?Valida codigo do municipio                                   ?
			//����������������������������������������������������������������
			If SX5->(!msseek(xFilial()+"S1"+cCodMun))
				lZFranca	:= .F.
			EndIf
			If lZFranca
				RECLOCK(cArqZFM,.T.)
				(cArqZFM)->CFOP		:=	(cAliasF3)->F3_CFO	 //CFOP
				(cArqZFM)->UF			:=	cUF //Unidade de Federacao
				(cArqZFM)->NFISCAL	:=	(cAliasF3)->F3_NFISCAL	//Nota Fiscal
				(cArqZFM)->EMISSAO	:=	(cAliasF3)->F3_EMISSAO	//Data da Emissao
				(cArqZFM)->VALOR		:=	(cAliasF3)->F3_VALCONT //Valor da nota fiscal
				(cArqZFM)->CNPJDES	:=	cCGC	//CGC do destinatario
				(cArqZFM)->MUNICIP	:=	cCodMun	//Codigo do Municipio
				(cArqZFM)->TIPOREG	:=  StrZero(nTipoReg,6)
				MSUnlock()

				//������������������������������������������������������?
				//�Indica no Registro Detalhes Interestaduais que existe?
				//�operacoes beneficiadas por Isencao do ICMS.          ?
				//������������������������������������������������������?
				If (cArqInt)->(msseek((cAliasF3)->F3_CFO+cUF+StrZero(nTipoReg,6)))
					RecLock(cArqInt,.F.)
					If Alltrim((cAliasF3)->F3_CFO)<>"6107" .And. Alltrim((cAliasF3)->F3_CFO)<>"6108"
						(cArqInt)->BENEF	:= "1"
						(cArqInt)->Q18	+=	1
					Endif
					MsUnlock()
				EndIf
			EndIf
			(cAliasF3)->(DBSKIP())
		EndDo
		DbSelectArea (cAliasF3)
		(cAliasF3)->(DbCloseArea ())

		//��������������������Ŀ
		//�Reg Exportacao CR=31?
		//����������������������
		//Aqui ser�o tratados opera��es de exporta��es caso o ambiene seja DBF, caso for TOP, ser?tratado em uma query separada,
		//para que o tratamento das notas possam ser gerados se forma agrupada.

		lGeraExp := .T.
		If	((cVValid == "0740" .and. cVLayOut == "0204") .And. (cRef<="200112")) .Or.;
			((cVValid == "0750" .and. cVLayOut == "0205") .And. (cRef<="200112")) .Or.;
			((cVValid == "0760" .and. cVLayOut == "0206") .And. (cRef<="200112")) .Or.;
			((cVValid == "0770" .and. cVLayOut == "0207") .And. (cRef<="200112")) .Or.;
			((cVValid == "0780" .and. cVLayOut == "0208") .And. (cRef<="200112")) .or.;
			((cVValid == "0790" .and. cVLayOut == "0209") .And. (cRef<="200112")) .Or.;
			((cVValid >= "0800" .and. cVLayOut >= "0210") .And. (cRef<="200112"))
			lGeraExp := .F.
		Endif

		IF lGeraExp
			If lD2_Re
				//Se tiver integra��o para com EEC e o campo nao estiver criado, emitir aviso e retornar.
				If SD2->(FieldPos(cD2_Re))==0 .and. SuperGetMV("MV_EECFAT")
					Aviso("Integra��o com o m�dulo SIGAEEC Habilitada ","Por favor crie o campo " + cD2_Re + " via configurador.",{"Ok"}) //N�o foi possivel excluir a nota, pois a mesma j?foi transmitida e encotra-se bloqueada. Ser?necess�rio realizar a primeiro a classifica��o da nota e posteriormente a exclus�o!"
					return
				EndIf
				cSlctSFT	:= "%SD2." + cD2_Re + "%"
			Else
				cSlctSFT	:= "%SD2.D2_PREEMB, SD2.D2_EMISSAO%"
			EndIF

			cFiltro := "%SF3.F3_FILIAL = '"+xFilial("SF3")+"' AND "
			cFiltro += "SF3.F3_ENTRADA >= '"+DTOS(dDtIni)+"' AND "
			cFiltro += "SF3.F3_ENTRADA <= '"+DTOS(dDtFim)+"' AND "
			If cNrLivro <> "*"
				cFiltro += "F3_NRLIVRO ='"+ cNrLivro +"' AND "
			EndIf
			cFiltro += "SF3.F3_DTCANC =' ' AND "

			If lD2_Re
				cFiltro += "SD2." + cD2_Re + " <> '' AND %"
			Else
				cFiltro += "SD2.D2_PREEMB <> '' AND %"
			EndIF

			cAliasF3	:=	GetNextAlias()
			BeginSql Alias cAliasF3
				SELECT
				%Exp:cSlctSFT%
				FROM
				%Table:SF3% SF3
				JOIN %Table:SD2% SD2 ON(SD2.D2_FILIAL=%xFilial:SD2% AND SD2.D2_DOC=SF3.F3_NFISCAL and SD2.D2_SERIE=SF3.F3_SERIE and SD2.D2_CLIENTE=SF3.F3_CLIEFOR AND SD2.D2_LOJA=SF3.F3_LOJA  AND SD2.%NotDel%)
				WHERE
				%Exp:cFiltro%
				SF3.%NotDel%
			EndSql

			IF !lD2_Re
				TcSetField(cAliasF3,"D2_EMISSAO","D",8,0)
			EndIF

			If  lD2_Re
				dbSelectArea(cArqExpt)
				dbSetOrder(1)
				Do While !(cAliasF3)->(EOF())
					nT  		:= 0
					cRe := (cAliasF3)->&cD2_Re

					For nT:=33 to 255
						If (nT >= 33 .and. nT <= 47) .or. (nT >= 58 .and. nT <= 64) .or. (nT >= 91 .and. nT <= 96) .or. (nT >= 123 .and. nT <= 255)
							If (at(CHR(nT),cRe)) > 0
								cRe := StrTran(cRe,CHR(nT),"")
							EndIf
						EndIf
					Next nT
					cRe := If(Empty(cRe),cRe,Strzero(val(Alltrim(cRe)),15,0))

					If !Empty(cRe) .And. (cArqExpt)->(!msseek(cRe))
						RecLock(cArqExpt,.T.)
						(cArqExpt)->RE := cRe
						(cArqExpt)->TIPOREG	:=  StrZero(nTipoReg,6)
						MsUnLock()
						RecLock(cArqCabec,.F.)
						(cArqCabec)->Q31	+=	1
						MsUnLock()
					EndIf

					(cAliasF3)->(DBSKIP())
				EndDo
			ElseIf SuperGetMV("MV_EECFAT")

				dbSelectArea(cArqExpt)
				dbSetOrder(1)

				//������������������������������������������������������������������������������������������������Ŀ
				//�Processamento da funcao da Average que retorna os avisos de embarque conforme regras do SIGAEEC ?
				//|Conforme solicitado nos Chamados: THMQEB e THMOIB, he necess�rio as datas de RE e DSE para o R31|
				//|                     FUNCAO DISPONIBILIZADA PELA AVEGARE - FONTE AVGERAL.PRW                    |
				//��������������������������������������������������������������������������������������������������
				acRe := EasySpedRes(strzero(Month(dDtIni),2),cValToChar(Year(dDtIni)),2)
				If Len(acRe) > 0
					If aScan(acRebk,{|aX|aX==acRe[1][2]})==0
						For nx:= 1 to Len(acRe)
							cRe := Strzero(val(Alltrim(acRe[nx][2])),15,0)
							RecLock(cArqExpt,.T.)
							(cArqExpt)->RE := cRe
							(cArqExpt)->TIPOREG	:=  StrZero(nTipoReg,6)
							MsUnLock()
							RecLock(cArqCabec,.F.)
							(cArqCabec)->Q31 +=	 1
							MsUnLock()
						Next nx
						Aadd(acRebk,acRe[1][2])
					EndIf
				Endif
			EndIf
			DbSelectArea (cAliasF3)
			(cAliasF3)->(DbCloseArea())
		EndIF

	EndIF

	//������������������?
	//�Ocorrencias CR=20?
	//������������������?
	If !lRelDIPAM
		aApuICM := FisApur("IC",nAno,nMes,2,0,"*",.F.,{},1,.F.,"")
		aApuST  := FisApur("ST",nAno,nMes,2,0,"*",.F.,{},1,.F.,"")
		For nX := 1 to len(aApuICM)

			//lOcorrGen -> Variavel que indica um registro de ocorrencia generica (99)
			//Nesse caso, o validador permite que seja utilizado o sexto caracter de subitem para diferenciar
			//as ocorrencias, portanto devo verificar ateh o sexto caracter para segregar as informacoes do arquivo
			//Exemplo:	007.991 -> Legislacao 1
			//			007.992 -> Legislacao 2
			//Arquivo:	20007990000000000200000Legislacao 1
			//			20007990000000000200000Legislacao 2
			//Teoricamente seriam linhas duplicadas, porem o validador permite para os codigos genericos
			lOcorrGen := .F.

			If alltrim(aApuICM[nX][1])$"002#003#006#007#012" .and. aApuICM[nX][3] > 0
				cSubCod := RetChar(alltrim(aApuICM[nX][4]),.F.,.F.,.F.,.T.,.F.,6,.F.)

				//Verifico se eh sub codigo generico
				If SubStr( cSubCod , 4 , 2 ) <> "99"
					cSubCod := SubStr( cSubCod , 1 , 5 )
				Else
					cSubCod		:= Alltrim( cSubCod )
					lOcorrGen	:= .T.
				Endif

				dbSelectArea(cArqOcor)
				If !(cSubCod$"00200#00300#00600#00700#01200")
					If (cArqOcor)->( msseek( PadR( cSubCod , Len( (cArqOcor)->SUBITEM ) ) + "0" ) )
						RecLock(cArqOcor,.F.)
					Else
						//������������������������������������������������������������������������?
						//�Caso existam codigos duplicados na apuracao, ira criar apenas uma linha?
						//�no CR=20, acumulando os valores.                                       ?
						//������������������������������������������������������������������������?
						// Isaac Silva 16/12/09
						RecLock(cArqOcor,.T.)
						(cArqOcor)->SUBITEM := cSubCod
						(cArqOcor)->PRO_ST  := "0"
						If lOcorrGen
							(cArqOcor)->FLEGAL  := If(!Empty(alltrim(aApuICM[nX][2])),alltrim(aApuICM[nX][2]),"OUTRAS HIPOTESES")
							(cArqOcor)->OCORREN := If(!Empty(alltrim(aApuICM[nX][2])),alltrim(aApuICM[nX][2]),"OUTRAS HIPOTESES")
						Else
							(cArqOcor)->FLEGAL  := Space(100)
							(cArqOcor)->OCORREN := Space(300)
						EndIf
						(cArqOcor)->CODAUTO := alltrim(aApuICM[nX][2])

						nQtdQ20:=aScan(aQ20,{|x| x[1] == "20"+Alltrim((cArqOcor)->SUBITEM)+Alltrim((cArqOcor)->PRO_ST)})
						If nQtdQ20==0
							aAdd(aQ20,{"20"+Alltrim((cArqOcor)->SUBITEM)+Alltrim((cArqOcor)->PRO_ST)})
							RecLock(cArqCabec,.f.)
							(cArqCabec)->Q20	+=	1
							(cArqOcor)->TIPOREG	:=  StrZero(nTipoReg,6)
							(cArqCabec)->(MsUnlock())
						Endif
					Endif
					(cArqOcor)->VALOR   += aApuICM[nX][3]
					If (cArqCabec)->REF >= "201004"
						If cSubCod $ "00220|00221|00740|00741"
							If (cCredAcum)->(msseek( PadR( cSubCod , Len( (cArqOcor)->SUBITEM ) ) +alltrim(aApuICM[nX][2])))
								RecLock(cCredAcum,.F.)
								(cCredAcum)->VALOR   += aApuICM[nX][3]
							Else
								RecLock(cCredAcum,.T.)
								(cCredAcum)->SUBITEM := cSubCod
								(cCredAcum)->CODAUTO := alltrim(aApuICM[nX][2])
								(cCredAcum)->VALOR   := aApuICM[nX][3]
								(cCredAcum)->TIPOREG :=  StrZero(nTipoReg,6)
								(cArqOcor)->Q28		+= 1
								(cArqOcor)->TIPOREG	:=  StrZero(nTipoReg,6)
							EndIf
							(cCredAcum)->(MsUnlock())
						Endif
					Endif

					If (cArqCabec)->REF >= "201201"
						If cSubCod $ "00223|00744|00745"
							If (cCredAcum)->(msseek( PadR( cSubCod , Len( (cArqOcor)->SUBITEM ) ) +alltrim(aApuICM[nX][2])))
								RecLock(cCredAcum,.F.)
								(cCredAcum)->VALOR	+= aApuICM[nX][3]
							Else
								RecLock(cCredAcum,.T.)
								(cCredAcum)->SUBITEM := cSubCod
								(cCredAcum)->CODAUTO := alltrim(aApuICM[nX][2])
								(cCredAcum)->VALOR   := aApuICM[nX][3]
								(cCredAcum)->TIPOREG :=  StrZero(nTipoReg,6)
								(cArqOcor)->Q28		+= 1
								(cArqOcor)->TIPOREG	:=  StrZero(nTipoReg,6)
							EndIf
							(cCredAcum)->(MsUnlock())
						Endif
					Endif
					(cArqOcor)->(MsUnlock())
				EndIf
			EndIf
		Next nX

		For nY := 1 to len(aApuST)
			If alltrim(aApuST[nY][1])$"002#003#007#008" .and. aApuST[nY][3] > 0
				cSubCod := RetChar(alltrim(aApuST[nY][4]),.T.,.F.,.F.,.T.,.F.,5,.F.)
				If !(cSubCod$"00200#00300#00700#00800")
					dbSelectArea(cArqOcor)
					If (cArqOcor)->(msseek(cSubCod+"1"))
						RecLock(cArqOcor,.F.)
					Else
						RecLock(cArqOcor,.T.)
						(cArqOcor)->SUBITEM := cSubCod
						(cArqOcor)->PRO_ST  := "1"
						If Substr(cSubCod,4,5) == "99"
							(cArqOcor)->FLEGAL  := If(!Empty(alltrim(aApuST[nY][2])),alltrim(aApuST[nY][2]),"OUTRAS HIPOTESES")
							(cArqOcor)->OCORREN := If(!Empty(alltrim(aApuST[nY][2])),alltrim(aApuST[nY][2]),"OUTRAS HIPOTESES")
						Else
							(cArqOcor)->FLEGAL  := Space(100)
							(cArqOcor)->OCORREN := Space(300)
						EndIf
						(cArqOcor)->CODAUTO := alltrim(aApuST[nY][2])
						nQtdQ20:=aScan(aQ20,{|x| x[1] == "20"+Alltrim((cArqOcor)->SUBITEM)+Alltrim((cArqOcor)->PRO_ST)})
						If nQtdQ20==0
							aAdd(aQ20,{"20"+Alltrim((cArqOcor)->SUBITEM)+Alltrim((cArqOcor)->PRO_ST)})
							RecLock(cArqCabec,.f.)
							(cArqCabec)->Q20	+=	1
							(cArqOcor)->TIPOREG	:=  StrZero(nTipoReg,6)
							MsUnlock()
						Endif
					EndIf
					(cArqOcor)->VALOR   += aApuST[nY][3]
					MsUnlock()
				EndIf
			EndIf
		Next nY
	Endif
	//
	If FWModeAccess("SF3",3)=="C"
		Exit
	//Else
	//	SM0->(dbSkip())
	Endif

	//SM0->(DbSkip ())
	//
	If lQuery
		dbSelectArea(cAliasSF3)
		dbCloseArea()
		Ferase(cIndSF3+OrdBagExt())
		dbSelectArea("SF3")
		RetIndex("SF3")
	Endif

Next(n0) //Next da SM0 para a mesma EMPRESA


If !lRelDIPAM
	dbSelectArea(cArqDipam)
	If (cArqDipam)->(msseek("23"))
		While !((cArqDipam)->(Eof())) .and. (cArqDipam)->CODDIP=="23"
			// verifica se arquivo temporario (cArqDipam) possui municipios que ponto de entrada processou
			// Quando PE alterar valor p campo (cArqDipam)->VALOR sera 0 
			lAchou23:=.F.
			If VALOR == 0 .and. (aScan(aDipamB23,{|x| x[1] == (cArqDipam)->CODDIP .and. x[2]==(cArqDipam)->MUNICIP})) > 0
				lAchou23:= .T.
			Endif
			RecLock(cArqDipam,.F.)
			If !lAchou23  // caso n�o encontre altera��es do PE, mantem valor gravado no temporario.
				if  (VALOR - VALORENT) > 0
					VALOR := VALOR - VALORENT
				Else
					DBDelete()
					RecLock(cArqCabec,.F.)
					(cArqCabec)->Q30	-=	1
					MsUnLock()
				Endif
			Else
				VALOR:=1
			Endif
			dbSelectArea(cArqDipam)
			(cArqDipam)->(dbSkip())
			MsUnLock()
		EndDo
	Endif
	If (cArqDipam)->(msseek("24"))
		While !((cArqDipam)->(Eof())) .and. (cArqDipam)->CODDIP=="24"
			// verifica se arquivo temporario (cArqDipam) possui municipios que ponto de entrada processou
			// Quando PE alterar valor p campo (cArqDipam)->VALOR sera 0
			lAchou24:=.F.
			If VALOR == 0 .and. (aScan(aDipamB24,{|x| x[1] == (cArqDipam)->CODDIP .and. x[2]==(cArqDipam)->MUNICIP}))  > 0
				lAchou24:= .T.
			Endif
			RecLock(cArqDipam,.F.)
			If !lAchou24 // caso n�o encontre altera��es do PE, mantem valor gravado no temporario.
				if  (VALOR - VALORENT)  > 0
					VALOR := VALOR - VALORENT
				Else
					DBDelete()
					RecLock(cArqCabec,.F.)
					(cArqCabec)->Q30	-=	1
					MsUnLock()
				Endif
			Else
				VALOR:=1
			Endif
			dbSelectArea(cArqDipam)
			(cArqDipam)->(dbSkip())
			MsUnLock()
		EndDo
	Endif
	If (cArqDipam)->(msseek("25")) .and. (cArqDipam)->CODDIP=="25"
		While !((cArqDipam)->(Eof()))
			// verifica se arquivo temporario (cArqDipam) possui municipios que ponto de entrada processou
			// Quando PE alterar valor p campo (cArqDipam)->VALOR sera 0
			lAchou25:=.F.
			If VALOR == 0 .and. (ascan(aDipamB25,{|x| x[1] == (cArqDipam)->CODDIP .and. x[2]==(cArqDipam)->MUNICIP}))  > 0
				lAchou25:= .T.
			Endif
			If lAchou25 // caso n�o encontre altera��es do PE, mantem valor gravado no temporario.
				RecLock(cArqDipam,.F.)
				VALOR:=1
				MsUnLock()
			Endif
			dbSelectArea(cArqDipam)
			(cArqDipam)->(dbSkip())
		EndDo
	Endif
Endif

//-- Alias das tabelas temporarias
aAlias := {cArqCabec,cArqCFO,cArqInt,cArqZFM,cArqOcor,cArqIE,cArqIeSt,cArqIeSd,cArqDIPAM,cCredAcum,cArqExpt}

RestArea(aAreaSm0)
cFilAnt := FWGETCODFILIAL

If lRelDIPAM
	Return(cArqDipam)
Endif

Return

/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Funcao  �a972CriaTemp�Autor  �Andreia dos Santos  ?Data ? 26/06/00   ��?
�������������������������������������������������������������������������͹�?
���Desc.   �Cria todos os arquivos temporarios necessarios a geracao da   ��?
��?       �GIA                                                           ��?
�������������������������������������������������������������������������͹�?
���Uso     ?MATA972                                                      ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/

Static Function a972CriaTemp(lRelDIPAM)

Local aCampos	:= {}
Local cAlias	:= Alias()
Local aTam		:= TAMSX3("F3_CFO")

Default lRelDIPAM := .F.

If !lRelDIPAM
	//����������������������������������������Ŀ
	//�Arquivo do Cabecalho do Doc.Fiscal CR=05?
	//������������������������������������������
	AADD(aCampos,{"IE"		,"C"	,012,0})
	AADD(aCampos,{"CNPJ"	,"C"	,014,0})
	AADD(aCampos,{"CNAE"	,"C"	,007,0})
	AADD(aCampos,{"REGTRIB"	,"C"	,002,0})
	AADD(aCampos,{"REF"		,"C"	,006,0})
	AADD(aCampos,{"REFINIC"	,"C"	,006,0})
	AADD(aCampos,{"TIPO"	,"C"	,002,0})
	AADD(aCampos,{"MOVIMEN"	,"C"	,001,0})
	AADD(aCampos,{"TRANSMI"	,"C"	,001,0})
	AADD(aCampos,{"SALDO"	,"N"	,015,2})
	AADD(aCampos,{"SALDOST"	,"N"	,015,2})
	AADD(aCampos,{"ORIGSOF"	,"C"	,014,0})
	AADD(aCampos,{"ORIGARQ"	,"C"	,001,0})
	AADD(aCampos,{"ICMSFIX"	,"N"	,015,2})
	AADD(aCampos,{"Q07"		,"N"	,004,0})
	AADD(aCampos,{"Q10"		,"N"	,004,0})
	AADD(aCampos,{"Q20"		,"N"	,004,0})
	AADD(aCampos,{"Q30"		,"N"	,004,0})
	AADD(aCampos,{"Q31"		,"N"	,004,0})
	AADD(aCampos,{"TIPOREG"	,"C"	,006,0})
	cArqCabec	:=	CriaTrab(aCampos)
	dbUseArea(.T.,__LocalDriver,cArqCabec,cArqCabec,.T.,.F.)

	//����������������������������Ŀ
	//�Arquivo Detalhes CFOPs CR=10?
	//������������������������������
	aCampos	:=	{}
	AADD(aCampos,{"CFOP"    ,"C"	,aTam[1],0})
	AADD(aCampos,{"VALCONT" ,"N"	,015,2})
	AADD(aCampos,{"BASEICM"	,"N"	,015,2})
	AADD(aCampos,{"VALTRIB"	,"N"	,015,2})
	AADD(aCampos,{"ISENTA"	,"N"	,015,2})
	AADD(aCampos,{"OUTRAS"	,"N"	,015,2})
	AADD(aCampos,{"RETIDO"	,"N"	,015,2})
	AADD(aCampos,{"RtStSt"	,"N"	,015,2})
	AADD(aCampos,{"RtSbSt"	,"N"	,015,2})
	AADD(aCampos,{"IMPOSTO"	,"N"	,015,2})
	AADD(aCampos,{"Q14"		,"N"	,004,0})
	AADD(aCampos,{"TIPOREG" ,"C"	,006,0})

	cArqCFO	:=	CriaTrab(aCampos)
	dbUseArea(.T.,__LocalDriver,cArqCFO,cArqCFO,.T.,.F.)
	IndRegua(cArqCFO,cArqCFO,"CFOP+TIPOREG",,,STR0009) //"Indexando Detalhes de CFOP"

	//��������������������������������������?
	//�Arquivo Detalhes interestaduais CR=14?
	//��������������������������������������?
	aCampos	:=	{}
	AADD(aCampos,{"CFOP"   	,"C"	,aTam[1],0})
	AADD(aCampos,{"UF"   	,"C"	,002,0})
	AADD(aCampos,{"VALCONT" ,"N"	,015,2})
	AADD(aCampos,{"BASECON"	,"N"	,015,2})
	AADD(aCampos,{"VALNCON"	,"N"	,015,2})
	AADD(aCampos,{"BASENCO"	,"N"	,015,2})
	AADD(aCampos,{"ISENTA"	,"N"	,015,2})
	AADD(aCampos,{"IMPOSTO"	,"N"	,015,2}) //Imposto creditado ou debitado
	AADD(aCampos,{"OUTRAS"	,"N"	,015,2})
	AADD(aCampos,{"RETIDO"	,"N"	,015,2})
	AADD(aCampos,{"PETROL"	,"N"	,015,2})
	AADD(aCampos,{"OUTPROD"	,"N"	,015,2})
	AADD(aCampos,{"BENEF"	,"C"	,001,2})
	AADD(aCampos,{"Q18"		,"N"	,004,0})
	AADD(aCampos,{"TIPOREG" ,"C"	,006,0})

	cArqInt	:=	CriaTrab(aCampos)
	dbUseArea(.T.,__LocalDriver,cArqInt,cArqInt,.T.,.F.)
	IndRegua(cArqInt,cArqInt,"CFOP+UF+TIPOREG",,,STR0010) //"Indexando Operacoes interestaduais"

	//����������������?
	//�Arquivo ZFM/ALC?
	//����������������?
	aCampos	:=	{}
	AADD(aCampos,{"CFOP"   	,"C"	,aTam[1],0})
	AADD(aCampos,{"UF"   	,"C"	,002,0})
	AADD(aCampos,{"NFISCAL" ,"C"	,TamSX3("F2_DOC")[1],0})
	AADD(aCampos,{"EMISSAO" ,"D"	,008,0})
	AADD(aCampos,{"VALOR"	,"N"	,015,2})
	AADD(aCampos,{"CNPJDES"	,"C"	,014,0})
	AADD(aCampos,{"MUNICIP"	,"C"	,005,0})
	AADD(aCampos,{"TIPOREG" ,"C"	,006,0})

	cArqZFM	:=	CriaTrab(aCampos)
	dbUseArea(.T.,__LocalDriver,cArqZFM,cArqZFM,.T.,.F.)
	IndRegua(cArqZFM,cArqZFM,"CFOP+UF+TIPOREG",,,STR0011) //"Indexando ZFM/ALC"

	//����������������������������Ŀ
	//�Arquivo de Ocorrencias CR=20?
	//������������������������������
	aCampos	:=	{}
	AADD(aCampos,{"SUBITEM" ,"C"	,006,0})
	AADD(aCampos,{"VALOR"	,"N"	,015,2})
	AADD(aCampos,{"PRO_ST"	,"C"	,001,0})
	AADD(aCampos,{"FLEGAL"	,"C"	,100,0})
	AADD(aCampos,{"OCORREN"	,"C"	,300,0})
	AADD(aCampos,{"Q25"    	,"N"	,004,0})
	AADD(aCampos,{"Q26"    	,"N"	,004,0})
	AADD(aCampos,{"Q27"    	,"N"	,004,0})
	AADD(aCampos,{"Q28"    	,"N"	,004,0})
	AADD(aCampos,{"CODAUTO"	,"C"	,012,0})
	AADD(aCampos,{"TIPOREG" ,"C"	,006,0})

	cArqOcor	:=	CriaTrab(aCampos)
	dbUseArea(.T.,__LocalDriver,cArqOcor,cArqOcor,.T.,.F.)
	IndRegua(cArqOcor,cArqOcor,"SUBITEM+PRO_ST+TIPOREG",,,STR0012)  //"Indexando Ocorrencias"

	//����������������������������?
	//�Arquivo de Remetentes CR=25?
	//����������������������������?
	aCampos	:=	{}
	AADD(aCampos,{"SUBITEM"	,"C"	,005,0})
	AADD(aCampos,{"IE"		,"C"	,012,0})
	AADD(aCampos,{"VALOR"	,"N"	,015,2})
	AADD(aCampos,{"TIPOREG" ,"C"	,006,0})

	cArqIE	:=	CriaTrab(aCampos)
	dbUseArea(.T.,__LocalDriver,cArqIE,cArqIE,.T.,.F.)
	IndRegua(cArqIE,cArqIE,"SUBITEM+IE",,,STR0013) //"Indexando Remetentes"
Endif

//����������������������?
//�Arquivo DIPAM-B CR=30?
//����������������������?

aCampos	:=	{}
If lRelDIPAM
	AADD(aCampos,{"FILIAL"	,"C"	,008,0})   						// Filial
	AADD(aCampos,{"CFOP"	,"C"	,aTam[1],0})   					// CFOP
	AADD(aCampos,{"ENT_SAI"	,"C"	,001,0})   						// [E]ntradas / [S]Saidas
	AADD(aCampos,{"SERIE"	,"C"	,003,0})						// Serie
	AADD(aCampos,{"NOTA"	,"C"	,TamSX3("F2_DOC")[1],0})		// Numero da Nota
	AADD(aCampos,{"CLIFOR"	,"C"	,TAMSX3("F3_CLIEFOR")[1],0}) 	// Cliente / Fornecedor
	AADD(aCampos,{"LOJA"	,"C"	,TAMSX3("F3_LOJA")[1],0})		// Loja
	AADD(aCampos,{"MUNICIP" ,"C"	,026,0}) 						// Municipio
	AADD(aCampos,{"CODDIP"	,"C"	,002,0})						// Codigo da Dipam
	AADD(aCampos,{"VALOR"	,"N"	,018,2})						// Valor da Nota
	AADD(aCampos,{"TIPO"	,"C"	,001,0})						// Tipo da NF
	AADD(aCampos,{"ESTADO"	,"C"	,002,0})						// Estado
Else
	AADD(aCampos,{"CODDIP"	,"C"	,002,0})
	AADD(aCampos,{"MUNICIP"	,"C"	,005,0})
	AADD(aCampos,{"VALOR"	,"N"	,015,2})
	AADD(aCampos,{"TIPOREG" ,"C"	,006,0})
	AADD(aCampos,{"VALORENT","N"	,015,2})
Endif

cArqDIPAM	:=	CriaTrab(aCampos)
dbUseArea(.T.,__LocalDriver,cArqDIPAM,cArqDIPAM,.T.,.F.)
If lRelDIPAM
	IndRegua(cArqDipam,cArqDipam,"FILIAL")
Else
	IndRegua(cArqDipam,cArqDipam,"CODDIP+MUNICIP+TIPOREG")
Endif
dbSelectArea(cAlias)

If !lRelDIPAM
	//������������������������������Ŀ
	//�Arquivo de IE_SUBSTITUTO CR=26?
	//��������������������������������
	aCampos	:=	{}
	AADD(aCampos,{"SUBITEM"	,"C"	,005,0})
	AADD(aCampos,{"IE"		,"C"	,012,0})
	AADD(aCampos,{"NF"		,"C"	,TamSX3("F2_DOC")[1],0})
	AADD(aCampos,{"Dataini"	,"C"	,006,0})
	AADD(aCampos,{"DataFim"	,"C"	,006,0})
	AADD(aCampos,{"Valor"	,"N"	,015,2})

	cArqIeSt	:=	CriaTrab(aCampos)
	dbUseArea(.T.,__LocalDriver,cArqIeSt,cArqIeSt,.T.,.F.)
	IndRegua(cArqIeSt,cArqIeSt,"SUBITEM+IE+NF",,,STR0016) //"Indexando Ie_Substitutos"

	//��������������������������������?
	//�Arquivo de IE_SUBSTITUIDO CR=27?
	//��������������������������������?
	aCampos	:=	{}
	AADD(aCampos,{"SUBITEM"	,"C"	,005,0})
	AADD(aCampos,{"IE"		,"C"	,012,0})
	AADD(aCampos,{"NF"		,"C"	,TamSX3("F2_DOC")[1],0})
	AADD(aCampos,{"Valor"	,"N"	,015,2})
	cArqIeSd	:=	CriaTrab(aCampos)
	dbUseArea(.T.,__LocalDriver,cArqIeSd,cArqIeSd,.T.,.F.)
	IndRegua(cArqIeSd,cArqIeSd,"IE+NF",,,STR0017) //"Indexando Ie_Substituidos"

	//����������������?
	//�CredAcum CR=28 ?
	//����������������?
	aCampos	:=	{}
	AADD(aCampos,{"SUBITEM"	,"C"	,005,0})
	AADD(aCampos,{"CODAUTO"	,"C"	,012,0})
	AADD(aCampos,{"VALOR"	,"N"	,015,2})
	AADD(aCampos,{"TIPOREG" ,"C"	,006,0})

	cCredAcum	:=	CriaTrab(aCampos)
	dbUseArea(.T.,__LocalDriver,cCredAcum,cCredAcum,.T.,.F.)
	IndRegua(cCredAcum,cCredAcum,"SUBITEM+CODAUTO")

	//������������������������Ŀ
	//�Arquivo EXPORTACAO CR=31?
	//��������������������������
	aCampos	:=	{}
	AADD(aCampos,{"RE"	,"C"	,015,0})
	AADD(aCampos,{"TIPOREG" ,"C"	,006,0})

	cArqExpt	:=	CriaTrab(aCampos)
	dbUseArea(.T.,__LocalDriver,cArqExpt,cArqExpt,.T.,.F.)
	IndRegua(cArqExpt,cArqExpt,"RE+TIPOREG")

Endif
dbSelectArea(cAlias)

Return


/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Function�A972GeraTXT �Autor  �Microsiga           ?Data ? 07/03/00   ��?
�������������������������������������������������������������������������͹�?
���Desc.   �Gera Arquivo texto para GIA                                   ��?
�������������������������������������������������������������������������͹�?
���Uso     �MATA972                                                       ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972GeraTxt(lAutomato)

Local aOcorr	:= {}
Local aRemetent	:= {}
Local aCR26		:= {}
Local aCR27		:= {}
Local aCR30		:= IIF(ExistBlock("MA972C30"),ExecBlock("MA972C30"),{})
Local cPath		:= ""
Local cDisco	:= Alltrim(Upper(mv_par17))
Local cRef		:= strzero(nAno,4)+strzero(nMes,2)
Local n20		:= 0
Local n25		:= 0
Local n26		:= 0
Local n27		:= 0
Local n28		:= 0
Local nX		:= 0
Local nPos20	:= 0
Local nPos25	:= 0
Local nPos26	:= 0
Local nPos27	:= 0
Local nPos28	:= 0
Local nCR26 	:= 0
Local nCR27 	:= 0
Local nRemetent := 0

Default lAutomato := .F.

Private aCredAcum := {}

If !lHtml
	If !Empty(cDisco)
		//Trata Diretorio
		If Len(cDisco) == 1
			cDisco += ':\'
		ElseIf (SubStr (cDisco, Len (cDisco), 1)<>"\")
			cDisco += "\"
		EndIf
		cPath := cDisco
	Else
		cPath:=""
	Endif
Else
	cPath := AllTrim( GetSrvProfString( "StartPath" , "" ) )
EndIf

cNomeArq := cPath+cNomeArq

If File(cNomeArq)
	Ferase(cNomeArq)
Endif

nHandle := MsFCreate(cNomeArq)

//����������������������?
//�Registro Mestre CR=01?
//����������������������?
a972Mestre(lAutomato)

If ProcName(1) == "R972IMP"
	setregua((cArqCFO)->(LastRec()))
else
	PROCREGUA((cArqCFO)->(LastRec()))
endIf

DbSelectArea(cArqCFO)

nr07 := 0
nr20 := 0
nr30 := 0
nr31 := 0
n20  := 1

dbSelectArea(cArqCabec)
IndRegua(cArqCabec,cArqCabec,"IE",,,"")
(cArqCabec)->( dbGoTop())
While (cArqCabec)->(!eof())

	nr10 := 0

	(cArqCFO)->( DbGoTop())
	While (cArqCFO)->(!Eof())
		If AllTrim((cArqCabec)->TIPOREG) == AllTrim((cArqCFO)->TIPOREG)
			nr10++
		EndIf
		(cArqCFO)->(DbSkip())
	EndDo

	If cRef >= "201201"
		nr07 := (cArqCabec)->Q07
	EndIf

	nr20 := (cArqCabec)->Q20

	nr30 := (cArqCabec)->Q30

	If Valtype(aCR30) == "A"
		nr30 += Len(aCR30)
	EndIf

	nr31 := (cArqCabec)->Q31

	a972Cabec(nr10,nr20,nr30,nr31,/*1,*/nr07)

	(cArqCFO)->( dbGoTop())
	While (cArqCFO)->(!eof())

		If AllTrim((cArqCabec)->TIPOREG) <> AllTrim((cArqCFO)->TIPOREG)
			(cArqCFO)->(DbSkip())
			Loop
		EndIf

		if ProcName(1) == "R972IMP"
			IncRegua()
		else
			#IFNDEF WINDOWS
				IncProc(17,4)
			#ELSE
				IncProc()
			#ENDIF
		EndIf
		//��������������������Ŀ
		//�Detalhes CFOPs CR=10?
		//����������������������
		a972CFOP()

		if (cArqInt)->(msseek((cArqCFO)->CFOP))
			//������������������������������?
			//�Detalhes Interestaduais CR=14?
			//������������������������������?
			While (cArqInt)->(!eof()) .and. (cArqInt)->CFOP==(cArqCFO)->CFOP
				If AllTrim((cArqCFO)->TIPOREG) <> AllTrim((cArqInt)->TIPOREG)
					(cArqInt)->(DbSkip())
					Loop
				EndIf
				a972Estados()
				if (cArqZFM)->(msseek((cArqInt)->CFOP+(cArqInt)->UF+(cArqInt)->TIPOREG))
					//����������������������������������������������������Ŀ
					//�Zona Franca de Manaus /Areas de Livre Comercio CR=18?
					//������������������������������������������������������
					While (cArqZFM)->(!eof()) .and.(cArqZFM)->CFOP+(cArqZFM)->UF == (cArqInt)->CFOP+(cArqInt)->UF
						If AllTrim((cArqZFM)->TIPOREG) <> AllTrim((cArqInt)->TIPOREG)
							(cArqZFM)->(DbSkip())
							Loop
						EndIf
						If !Empty((cArqInt)->BENEF)
							If (cArqInt)->BENEF == "1"
								A972ZFranca()
							EndIf
						EndIf
						(cArqZFM)->(dbSkip())
					EndDo
				EndIf
				(cArqInt)->(dbSkip())
			EndDo
		Endif
		(cArqCFO)->(dbSkip())
	EndDo

	(cArqOcor)->( dbGoTop())
	While (cArqOcor)->(!eof())
		if ProcName(1) == "R972IMP"
			IncRegua()
		else
			#IFNDEF WINDOWS
				IncProc(17,4)
			#ELSE
				IncProc()
			#ENDIF
		EndIf
		//������������������?
		//�Ocorrencias CR=20?
		//������������������?
		//a972Ocorrencia()   
		//01.Chave(Codigo do registro+Codigo do SubItem)
		//02.Codigo do Subitem
		//03.Valor associado ao subitem
		//04.Indica se a operacao e propria ou Substituicao Tributaria
		//05.Fundamento legal associada ao Subitem
		//06.Descricao da ocorrencia associada ao Subitem
		//07.Quantidade de registro CR=25
		//08.Quantidade de registro CR=26
		//09.Quantidade de registro CR=27
		//10.Quantidade de registro CR=28
		If AllTrim((cArqCabec)->TIPOREG) <> AllTrim((cArqOcor)->TIPOREG)
			(cArqOcor)->(DbSkip())
			Loop
		EndIf
		nPosQ20:=aScan(aOcorr,{|x| x[1] == "20"+Alltrim((cArqOcor)->SUBITEM)+Alltrim((cArqOcor)->PRO_ST)})
		If nPosQ20==0
			aAdd(aOcorr,{"20"+Alltrim((cArqOcor)->SUBITEM),(cArqOcor)->SUBITEM,(cArqOcor)->VALOR,(cArqOcor)->PRO_ST,(cArqOcor)->FLEGAL,(cArqOcor)->OCORREN,(cArqOcor)->Q25,(cArqOcor)->Q26,(cArqOcor)->Q27,(cArqOcor)->Q28})
		Else
			aOcorr[nPosQ20][3]+=(cArqOcor)->VALOR
		Endif
		//����������������������������������������������������������������������������������������������������������������?
		//�IES remetentes CR=25                                                                                           ?
		//����������������������������������������������������������������������������������������������������������������?
		//Os registros desse tipo detalham informacoes lancadas em um registro-pai do tipo Ocorrencias cujo campo         ?
		//CodSubItem>=00704 e CodSubItem<=00707.                                                                          ?
		//����������������������������������������������������������������������������������������������������������������?
		If cRef > "200112"
			//01.Chave(Codigo do registro+Codigo do SubItem)
			//02.Inscricao estadual do remetente
			//03.Valor associado ao IE do Remetente
			If alltrim((cArqOcor)->SUBITEM)$ "00218|00729|00704|00705|00225|00747|00226|00748"
				//(cArqIE)->(dbGoTop())
				//a972Remetentes()
				aAdd(aRemetent,{"20"+Alltrim((cArqOcor)->SUBITEM),(cArqIE)->IE,(cArqOcor)->VALOR})
				(cArqIE)->(dbskip())
				nRemetent += 1
				If nPosQ20==0
					aOcorr[Len(aOcorr)][7]:=1
				Else
					aOcorr[nPosQ20][7]+=1
				Endif
			ElseIf alltrim((cArqOcor)->SUBITEM)$ "|00219|00730|"
				(cArqIE)->(dbGoTop())
				nRemetent := 0
				While !(cArqIE)->(Eof())
					IF (alltrim((cArqOcor)->SUBITEM)$'|00219|' .AND. SUBSTR((cArqIE)->SUBITEM,1,4) $ '5601/1605') .OR. (alltrim((cArqOcor)->SUBITEM)$'|00730|' .AND. SUBSTR((cArqIE)->SUBITEM,1,4) $ '1601/1602')
						aAdd(aRemetent,{"20"+Alltrim((cArqOcor)->SUBITEM),(cArqIE)->IE,(cArqIE)->VALOR})
						nRemetent += 1
					EndIf
					(cArqIE)->(dbskip())
				EndDo
				If nPosQ20==0
					aOcorr[Len(aOcorr)][7]:=1
				Else
					aOcorr[nPosQ20][7]+=1
				Endif
			Endif
		Endif

		//����������������������������������������������������������������������������������������������������������������?
		//�CR=26 - IESubstituto                                                                                           ?
		//����������������������������������������������������������������������������������������������������������������?
		//Os registros desse tipo detalham informa��es lan�adas em um registro pai do tipo Ocorr�ncias CR=20, que possua  ?
		//no campo C�dSubItem, um dos seguintes valores: 00210 ou 00211 e campo Pr�priaOuST=0.                            ?
		//����������������������������������������������������������������������������������������������������������������?
		If cRef > "200112"
			If alltrim((cArqOcor)->SUBITEM)$ "|00210|00211|" .AND. (cArqOcor)->PRO_ST  == "0"
				(cArqIeST)->(dbGoTop())
				nCR26 := 0
				While !(cArqIeST)->(Eof())
					IF (alltrim((cArqOcor)->SUBITEM)$'|00210|00211|' .AND. SUBSTR((cArqIeST)->SUBITEM,1,4) $ '5603|6603')
						aAdd(aCR26,{"20"+Alltrim((cArqOcor)->SUBITEM),Alltrim((cArqIeST)->IE), IIf (alltrim((cArqOcor)->SUBITEM)$'00211','000000000' ,Alltrim((cArqIeST)->NF)), (cArqIeST)->DataIni, (cArqIeST)->DataFim, (cArqIeST)->VALOR})
						nCR26 += 1
					EndIf
					(cArqIeST)->(dbskip())
				EndDo
				If nPosQ20==0
					aOcorr[Len(aOcorr)][8]:=1
				Else
					aOcorr[nPosQ20][8]+=1
				Endif
			Endif
		Endif

		//����������������������������������������������������������������������������������������������������������������?
		//�CR=27 - IESubstitu�do                                                                                           ?
		//����������������������������������������������������������������������������������������������������������������?
		//Os registros desse tipo detalham informa��es lan�adas em um registro pai do tipo Ocorr�ncias CR=20, que possua  ?
		//no campo C�dSubItem, um dos seguintes valores: 00701 ou 00702 e campo Pr�priaOuST=1.                            ?
		//����������������������������������������������������������������������������������������������������������������?
		If cRef > "200112"
			If alltrim((cArqOcor)->SUBITEM)$ "|00701|00702|" .AND. (cArqOcor)->PRO_ST  == "1"
				(cArqIeSD)->(dbGoTop())
				nCR27 := 0
				While !(cArqIeSD)->(Eof())
					IF (alltrim((cArqOcor)->SUBITEM)$'|00701|00702|' .AND. SUBSTR((cArqIeSD)->SUBITEM,1,4) $ '1603|2603')
						aAdd(aCR27,{"20"+Alltrim((cArqOcor)->SUBITEM),Alltrim((cArqIeSD)->IE), IIf (alltrim((cArqOcor)->SUBITEM)$'00702','000000000' ,Alltrim((cArqIeSD)->NF)), (cArqIeSD)->VALOR})
						nCR27 += 1
					EndIf
					(cArqIeSD)->(dbskip())
				EndDo
				If nPosQ20==0
					aOcorr[Len(aOcorr)][9]:=1
				Else
					aOcorr[nPosQ20][9]+=1
				Endif
			Endif
		Endif

		cRegistro	:=a972Fill("20"+a972Fill(aOcorr[n20][2],005)+a972Fill(Num2Chr(aOcorr[n20][3],15,2),015)+a972Fill(aOcorr[n20][4],001)+;
		a972Fill(aOcorr[n20][5] ,100)+a972Fill(aOcorr[n20][6] ,300)+a972Fill(Num2Chr(nRemetent,4,0),04)  +;
		a972Fill(Num2Chr(nCR26,4,0),04)+a972Fill(Num2Chr(nCR27,4,0),04)+a972Fill(Num2Chr(aOcorr[n20][10],4,0),04),439)
		a972Grava( cRegistro )
		nRemetent := 0
		nCR26 := 0
		nCR27 := 0

		nPos25:=0
		If Len(aRemetent)>0
			nPosQ25:=aScan(aRemetent,{|x| x[1] == Alltrim(aOcorr[n20][1])})
			If nPosQ25>0
				For n25:=nPosQ25 To Len(aRemetent)
					cRegistro	:=a972Fill("25"+a972Fill(aRemetent[n25][2],12)+a972Fill(Num2Chr(aRemetent[n25][3],15,2),15),29)
					a972Grava( cRegistro )
				Next
			Endif
		Endif

		If Len(aCR26)>0
			nPosQ26:=aScan(aCR26,{|x| x[1] == Alltrim(aOcorr[n20][1])})
			If nPosQ26>0
				For n26:=1 To Len(aCR26)
					cRegistro	:=a972Fill("26"+a972Fill(aCR26[n26][2],12)+a972Fill(aCR26[n26][3],9)+a972Fill(aCR26[n26][4],6)+a972Fill(aCR26[n26][5],6)+a972Fill(Num2Chr(aCR26[n26][6],15,2),15),50)
					a972Grava( cRegistro )
				Next
			Endif
		Endif

		If Len(aCR27)>0
			nPosQ27:=aScan(aCR27,{|x| x[1] == Alltrim(aOcorr[n20][1])})
			If nPosQ27>0
				For n27:=1 To Len(aCR27)
					cRegistro	:=a972Fill("27"+a972Fill(aCR27[n27][2],12)+a972Fill(aCR27[n27][3],9)+a972Fill(Num2Chr(aCR27[n27][4],15,2),15),38)
					a972Grava( cRegistro )
				Next
			Endif
		Endif

		//����������������������������������������������������������������������������������������������������������������?
		//�CredAcum. CR=28                                                                                                ?
		//����������������������������������������������������������������������������������������������������������������?
		//Os registros desse tipo detalham informacoes lancadas em um registro-pai do tipo Ocorrencias que possua no campo*
		//CodSubItem,um dos seguintes valores 00220,00221,00740 ou 00741                                                  *
		//����������������������������������������������������������������������������������������������������������������?
		If cRef >= "201004"
			If (cCredAcum)->(msseek(Alltrim((cArqOcor)->SUBITEM)))
				//01.Chave(Codigo do registro+Codigo do SubItem)
				//03.Codigo de Autorizacao
				//03.Valor
				while  (cCredAcum)->(!Eof()).And. (Alltrim(((cCredAcum)->SUBITEM))==Alltrim((cArqOcor)->SUBITEM))
					cRegistro:=a972Fill("28"+Lower(a972Fill((cCredAcum)->CODAUTO,12))+a972Fill(Num2Chr((cCredAcum)->VALOR,15,2),15),29)
					a972Grava( cRegistro )
					(cCredAcum)->(DbSkip ())
				EndDo

			Endif
		Endif
		n20++
		(cArqOcor)->(dbSkip())
	EndDo

	//��������������?
	//�DIPAM B CR=30?
	//��������������?
	If Valtype(aCR30) == "A"
		dbSelectArea(cArqDipam)
		(cArqDipam)->( dbGoTop())
		For nX := 1 To Len(aCR30)
			RecLock(cArqDipam,.T.)
			(cArqDipam)->CODDIP	 := aCR30[nX,1]
			(cArqDipam)->MUNICIP := aCR30[nX,2]
			(cArqDipam)->VALOR	 := aCR30[nX,3]
			(cArqDipam)->TIPOREG := StrZero(aCR30[nX,4],6)
			(cArqDipam)->(MSUnlock())
		Next
	Endif

	(cArqDipam)->( dbGoTop())
	While (cArqDipam)->(!Eof())
		If AllTrim((cArqCabec)->TIPOREG) <> AllTrim((cArqDipam)->TIPOREG)
			(cArqDipam)->(DbSkip())
			Loop
		EndIf
		a972DIPAM()
		(cArqDipam)->(DbSkip())
	EndDo

	//��������������������Ŀ
	//�Reg.Exportacao CR=31?
	//����������������������
	(cArqExpt)->( dbGoTop())
	While(cArqExpt)->(!eof())
		If AllTrim((cArqCabec)->TIPOREG) <> AllTrim((cArqExpt)->TIPOREG)
			(cArqExpt)->(DbSkip())
			Loop
		EndIf
		a972Expot()
		dbSelectArea(cArqExpt)
		dbSkip()
	EndDo
	(cArqCabec)->(dbSkip())
EndDo

dbSelectArea(cArqOcor)
(cArqOcor)->( dbGoTop())
if ProcName(1) == "R972IMP"
	setregua((cArqOcor)->(LastRec()))
else
	ProcRegua((cArqOcor)->(LastRec()))
endIf

return
/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Function  �a972Mestre�Autor  �Andreia dos Santos  ?Data ? 19/06/00   ��?
�������������������������������������������������������������������������͹�?
���Desc.     �Armazena informacoes no arquivo texto para armazenar infor- ��?
��?         �macoes do registro mestre. CR=01                            ��?
�������������������������������������������������������������������������͹�?
���Uso       ?mata972                                                    ��?
�������������������������������������������������������������������������͹�?
���Tamanho   ?32 Bytes                                                   ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972Mestre(lAutomato)

Local cRegistro
Default lAutomato := .F.

cRegistro 	:=	"01"                        //01.Deve ser igual a  01 para indicar que ?Registro Mestre
cRegistro	+=	"01"						//02.Tipo do documento
cRegistro	+=	If(!lAutomato,dtos(dDataBase),"00000000")		     	//03.Data de geracao do Arq.Pre-formatado
cRegistro	+=	If(!lAutomato,substr(Time(),1,2)+substr(Time(),4,2)+substr(Time(),7,2),"000000") //04. Hora da Geracao
cRegistro	+=	"0000"   					//05.Versao do sistema NOVA GIA
cRegistro	+=	mv_par16					//06.Versao do Layout do pre-formatado
cRegistro	+=	StrZero(nTipoReg,4)			//07.Quantidade de registro CR=05

cRegistros	:= a972Fill(cRegistro,30)
a972Grava(cRegistro)

Return
/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Function  �a972Cabec �Autor  �Andreia dos Santos  ?Data ? 19/06/00   ��?
�������������������������������������������������������������������������͹�?
���Desc.     �Cabecalho do documento fiscal.							  ��?
��?         �Contem informacoes sobre o contribuinte e informacoes gerais��?
��?         �sobre o documento fiscal. CR=05							  ��?
�������������������������������������������������������������������������͹�?
���Uso       ?Mata972                                                    ��?
�������������������������������������������������������������������������͹�?
���Tamanho   ?127 Bytes                                                  ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972Cabec(nr10,nr20,nr30,nr31,/*nOpc,*/nr07)
Local cRegistro

cRegistro	:=	"05"     											//01.Codigo do registro
cRegistro	+=	a972Fill((cArqCabec)->IE,12)						//02.Inscricao Estadual
cRegistro	+=	a972Fill((cArqCabec)->CNPJ,14)						//03.CNPJ
cRegistro	+=	a972Fill((cArqCabec)->CNAE,07)						//04.CNAE
cRegistro	+=	a972Fill((cArqCabec)->REGTRIB,02)					//05.Regime Tributario
cRegistro	+=	a972Fill((cArqCabec)->REF,06)						//06.Referencia( Ano e Mes da Gia)
cRegistro	+=	a972Fill((cArqCabec)->REFINIC,06)					//07.Referencia Inicial
cRegistro	+=	a972Fill((cArqCabec)->TIPO,02)						//08.Tipo da GIA
cRegistro	+=	a972Fill((cArqCabec)->MOVIMEN,01)					//09.Indica se houve movimento
cRegistro	+=	a972Fill((cArqCabec)->TRANSMI,01)	  				//10.Indica se o documento ja foi transmitido
cRegistro	+=	a972Fill(Num2Chr((cArqCabec)->SALDO,15,2),15)		//11.Saldo Credor do periodo anterior
cRegistro	+=	a972Fill(Num2Chr((cArqCabec)->SALDOST,15,2),15)	//12.Saldo Credor do Periodo anteiro para ST.
cRegistro	+=	a972Fill((cArqCabec)->ORIGSOF,14)					//13.Identificacao do fabricante do Software que gerou o arquivo pre formatado
cRegistro	+=	a972Fill((cArqCabec)->ORIGARQ,01) 					//14.Indica se o arquivo foi gerado por algum sistema de informacao contabil
cRegistro	+=	a972Fill(Num2Chr((cArqCabec)->ICMSFIX,15,2),15)	//15.ICMS fixado para o periodo
cRegistro   +=  a972Fill(REPLICATE("0",32),32)						//No caso em que o Pr?formatado-NG ?gerado por algum sistema de informa��o cont�bil, deixar este campo com ZEROS
If cVLayOut == "0209" .Or. cVLayOut == "0210"
	cRegistro	+=	a972Fill(Num2Chr(nr07,4,0),04)					//19.Quantidade de Registro tipo CR=07
Endif
cRegistro	+=	a972Fill(Num2Chr(nr10,4,0),04)						//16.Quantidade de registro tipo CR=10
cRegistro	+=	a972Fill(Num2Chr(nr20,4,0),04)		//17.Quantidade de Registro tipo CR=20

cRegistro	+=	a972Fill(Num2Chr(nr30,4,0),04)		//18.Quantidade de Registro tipo CR=30
If strzero(nAno,4)+strzero(nMes,2) < "200101"
	cRegistro	+= "0000"
Else
	cRegistro	+=	a972Fill(Num2Chr(nr31,4,0),04)	//19.Quantidade de Registro tipo CR=31
Endif

If cVLayOut == "0209" .Or. cVLayOut == "0210"
	cRegistro	:= a972Fill(cRegistro,165)
Else
	cRegistro	:= a972Fill(cRegistro,161)
EndIf
a972Grava( cRegistro )

Return

/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Function  �a972CFOP()�Autor  �Andreia dos Santos  ?Data ? 19/06/00   ��?
�������������������������������������������������������������������������͹�?
���Desc.     �Detalhes CFOPs.                                             ��?
��?         �Contem lancamentos de valores totalizados por CFOPs.Cada re ��?
��?         �gistro do tipo Detalhes CFOPs pertence a um unico registro  ��?
��?         �do tipo Cabecalho do Documento Fiscal. CR=10                ��?
�������������������������������������������������������������������������͹�?
���Uso       ?MATA972 										 	          ��?
�������������������������������������������������������������������������͹�?
���Tamanho   ?119 bytes   								 	              ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972CFOP()
LOCAL cRegistro

cRegistro	:=	"10"											  									//01.Codigo do Registro
cRegistro	+=	a972Fill(alltrim((cArqCFO)->CFOP)+repli("0",6-len(alltrim((cArqCFO)->CFOP))),06)	//02.Codigo Fiscal de Operacao e Prestacao
cRegistro	+=	a972Fill(Num2Chr((cArqCFO)->VALCONT,15,2),15)										//03.Valor Contabil
cRegistro	+=	a972Fill(Num2Chr(NoRound((cArqCFO)->BASEICM,2),15,2),15)							//04.Base de Calculo
cRegistro	+=	a972Fill(Num2Chr((cArqCFO)->VALTRIB,15,2),15)										//05.Imposto
cRegistro	+=	a972Fill(Num2Chr((cArqCFO)->ISENTA,15,2),15)										//06.Isentas e Nao tributadas
cRegistro	+=	a972Fill(Num2Chr((cArqCFO)->OUTRAS,15,2),15)										//07.Outras
cRegistro	+=	a972Fill(Num2Chr((cArqCFO)->RETIDO,15,2),15)										//08.Imposto Retido por Substituicao Tributaria
cRegistro	+=  a972Fill(Num2Chr((cArqCFO)->RtStSt,15,2),15)          								//Substituto
cRegistro	+=	a972Fill(Num2Chr((cArqCFO)->RtSbSt,15,2),15)          								//Substituido
cRegistro	+=	a972Fill(Num2Chr((cArqCFO)->IMPOSTO,15,2),15)		    							//09.Outros Impostos
cRegistro	+=	a972Fill(Num2Chr((cArqCFO)->Q14,4,0),04)											//10.Quantidade de Registros CR=14
cRegistro	:=	a972Fill(cRegistro,147)
a972Grava( cRegistro )

Return

/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Function �a972Estados�Autor  �Andreia dos Santos  ?Data ? 19/06/00   ��?
�������������������������������������������������������������������������͹�?
���Desc.    �Detalhes Interestaduais.CR=14	                              ��?
��?        �Contem informacoes relativas as entradas interestaduais e/ou ��?
��?        �saidas interestaduais agrupadas por estados. Registros deste ��?
��?        �tipo irao existir sempre que existir registros Detalhes CFOPS��?
��?        �com valor do campo CFOP =2XX ou 6XX.                         ��?
�������������������������������������������������������������������������͹�?
���Uso      ?AP5          	                                              ��?
�������������������������������������������������������������������������͹�?
���Tamanho  ?131 Bytes 	                                              ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972Estados()
LOCAL cRegistro

cRegistro	:=	"14"												//01.Codigo do registro
cRegistro	+=	a972Fill((cArqInt)->UF,02)							//02.Unidade da Federacao
cRegistro	+=	a972Fill(Num2Chr((cArqInt)->VALCONT,15,2),15)		//03.Valor Contabil de contribuinte
cRegistro	+=	a972Fill(Num2Chr((cArqInt)->BASECON,15,2),15)		//04.Base de Calculo de contribuinte
cRegistro	+=	a972Fill(Num2Chr((cArqInt)->VALNCON,15,2),15)		//05.Valor Contabil de Nao contribuinte
cRegistro	+=	a972Fill(Num2Chr((cArqInt)->BASENCO,15,2),15)		//06.Base de calculo de nao contribuinte
cRegistro	+=	a972Fill(Num2Chr((cArqInt)->IMPOSTO,15,2),15)		//Imposto creditado ou debitado
cRegistro	+=	a972Fill(Num2Chr((cArqInt)->OUTRAS,15,2),15)		//07.Outras
cRegistro	+=	a972Fill(Num2Chr((cArqInt)->RETIDO,15,2),15)		//08.ICMS cobrado por Substituicao Tributaria
cRegistro	+=	a972Fill(Num2Chr((cArqInt)->PETROL,15,2),15)		//09.Petroleo e Energia quando ICMS cobrado por Substituicao Tributaria
cRegistro	+=	a972Fill(Num2Chr((cArqInt)->OUTPROD,15,2),15)		//10.Outros produtos
cRegistro	+=	a972Fill(if((cArqInt)->BENEF=="1",(cArqInt)->BENEF,"0"),01)//11.Indica se ha alguma operacao beneficiada por isencao de ICMS(ZFM/ALC)
cRegistro	+=	a972Fill(Num2Chr((cArqInt)->Q18,04,0),04)			//12.Quantidade de registros CR=18
cRegistro	:=	a972Fill(cRegistro,144)
a972Grava( cRegistro )

return

/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Function �A972ZFranca�Autor  �Andreia dos Santos  ?Data ? 19/06/00   ��?
�������������������������������������������������������������������������͹�?
���Desc.    �ZFM/ALC. CR=18                                               ��?
��?        �Neste registro detalham-se as informacoes relativas as saidas��?
��?        �interestaduais, quando houver lancamentos de CFOPs do grupo  ��?
��?        ?.XX e a operacao permitir o beneficio da isencao devido aos ��?
��?        �municipios destinos pertencentes a Zona Franca de Manaus ou  ��?
��?        �Areas de Livre Comercio. Nao possui registros filhos         ��?
�������������������������������������������������������������������������͹�?
���Uso      ?AP5                                                         ��?
�������������������������������������������������������������������������͹�?
���Tamanho  ?52 bytes	                                                  ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972ZFranca()
LOCAL cRegistro

cRegistro	:=	"18"              								//01.Codigo do registro
cRegistro	+=  Strzero(Val((cArqZFM)->NFISCAL),09) 			//02.Numero da Nota Fiscal
cRegistro	+=	a972Fill(dtos((cArqZFM)->EMISSAO),08)			//03.Data de emissao da Nota Fiscal
cRegistro	+=	a972Fill(Num2Chr((cArqZFM)->VALOR,15,2),15)	//04.Valor da Nota Fiscal
cRegistro	+=	a972Fill((cArqZFM)->CNPJDES,14)					//05.CNPJ do destinatario
cRegistro	+=	a972Fill((cArqZFM)->MUNICIP,05)					//06.Codigo do municipio do destinatario

cRegistro	:=	a972Fill(cRegistro,53)
a972Grava( cRegistro )
Return

/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Funcao  �a972Ocorrencia�Autor  �Andreia dos Santos?Data ? 20/06/00   ��?
�������������������������������������������������������������������������͹�?
���Desc.   �Ocorrencias. CR=20                                            ��?
��?       �Detalham informacoes correspondentes aos campos 052-Outros De-��?
��?       �bitos, 053-Estorno de Cr�ditos, 057(Outros Cr�ditos),058(Estor��?
��?       �no de Debitos),064-Deducoes(RPA/DISPENSADO) e 064-Outras(RES) ��?
��?       ?necess�rias para Apuracao do ICMS para Operacoes Proprias e  ��?
��?       �Apuracao do ICMS-ST-11              						  ��?
�������������������������������������������������������������������������͹�?
���Uso     ?AP5                                                          ��?
�������������������������������������������������������������������������͹�?
���Tamanho ?429 bytes.                                                   ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972Ocorrencia(nCR25)
LOCAL cRegistro

cRegistro	:=	"20"											//01.Codigo de registro
cRegistro	+=	a972Fill((cArqOcor)->SUBITEM,005) 				//02.Codigo do Subitem
cRegistro	+=	a972Fill(Num2Chr((cArqOcor)->VALOR,15,2),015)	//03.Valor associado ao subitem
cRegistro	+=	a972Fill((cArqOcor)->PRO_ST,001)				//04.Indica se a operacao e propria ou Substituicao Tributaria
cRegistro	+=	a972Fill((cArqOcor)->FLEGAL,100)				//05.Fundamento legal associada ao Subitem
cRegistro	+=	a972Fill((cArqOcor)->OCORREN,300)				//06.Descricao da ocorrencia associada ao Subitem
cRegistro	+=	a972Fill(Num2Chr((cArqOcor)->Q25,4,0),04)		//07.Quantidade de registro CR=25
cRegistro	+=	a972Fill(Num2Chr((cArqOcor)->Q26,4,0),04)		//Quantidade de registro CR=26
cRegistro	+=	a972Fill(Num2Chr((cArqOcor)->Q27,4,0),04)		//Quantidade de registro CR=27
cRegistro	+=	a972Fill(Num2Chr((cArqOcor)->Q28,4,0),04)		//Quantidade de registro CR=28
cRegistro	:=	a972Fill(cRegistro,439)
a972Grava( cRegistro )
Return

/*
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������ͻ��
���Function �a972Remetentes�Autor  �Andreia dos Santos ?Data ? 20/06/00  ��?
��������������������������������������������������������������������������͹��
���Desc.    �IEs Remetentes. CR=25										   ��?
��?        �Os registros desse tipo detalham informacoes lancadas em um   ��?
��?        �registro-pai do tipo Ocorrencias cujo campo CodSubItem>=00704 ��?
��?        ?e CodSubItem<=00707.                                         ��?
��������������������������������������������������������������������������͹��
���Uso      ?AP5          	                                               ��?
��������������������������������������������������������������������������͹��
���Tamanho  ?31 Bytes     	                                               ��?
��������������������������������������������������������������������������ͼ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
*/
Static Function a972Remetentes()
LOCAL cRegistro
cRegistro	:=	"25"										//01.Codigo de Registro
cRegistro	+=	a972Fill((cArqIE)->IE,12)					//02.Inscricao estadual do remetente
cRegistro	+=	a972Fill(Num2Chr((cArqIE)->VALOR,15,2),15)	//03.Valor associado ao IE do Remetente

cRegistro	:=	a972Fill( cRegistro,29)
a972Grava( cRegistro )
return

/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Function  �a972FILL  �Autor  �Andreia dos Santos  ?Data ? 19/06/00   ��?
�������������������������������������������������������������������������͹�?
���Desc.     ?Encaixa conteudo no espaco especificado.                   ��?
�������������������������������������������������������������������������͹�?
���Uso       ?Mata972                                                    ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972Fill(cConteudo,nTam)

cConteudo	:=	If(cConteudo==NIL,"",cConteudo)
If Len(cConteudo)>nTam
	cRetorno	:=	Substr(cConteudo,1,nTam)
Else
	cRetorno	:=	cConteudo+Space(nTam-Len(cConteudo))
Endif

Return (cRetorno)

/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Funcao    �a972Grava �Autor  �Andreia dos Santos  ?Data ? 26/06/00   ��?
�������������������������������������������������������������������������͹�?
���Desc.     �Grava Registro no arquivo texto e acrescenta marca de final ��?
��?         �de registro                                                 ��?
�������������������������������������������������������������������������͹�?
���Uso       ?MATA972                                                    ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972Grava(cConteudo)

cConteudo += Chr(13)+Chr(10)

If !lEnd
	FWrite(nHandle,cConteudo,Len(cConteudo))
Endif

Return

/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Funcao  	 �A972CodUF �Autor  �Andreia dos Santos  ?Data ? 12/07/00   ��?
�������������������������������������������������������������������������͹�?
���Desc.     �Converte as unidades de federacao para um codigo aceito no  ��?
��?         �programa NOVA GIA da Secretaria da fazenda                  ��?
�������������������������������������������������������������������������͹�?
���Uso       ?mata972                                                    ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function A972CodUF(cUF)
cCOD := "01"

Do Case
	Case cUF == "AC"
		cCOD	:= "01"
	Case cUF == "AL"
		cCOD	:= "02"
	Case cUF == "AP"
		cCOD	:= "03"
	Case cUF == "AM"
		cCOD	:= "04"
	Case cUF == "BA"
		cCOD	:= "05"
	Case cUF == "CE"
		cCOD	:= "06"
	Case cUF == "DF"
		cCOD	:= "07"
	Case cUF == "ES"
		cCOD	:= "08"
	Case cUF == "GO"
		cCOD	:= "10"
	Case cUF == "MA"
		cCOD	:= "12"
	Case cUF == "MT"
		cCOD	:= "13"
	Case cUF == "MS"
		cCOD	:= "28"
	Case cUF == "MG"
		cCOD	:= "14"
	Case cUF == "PA"
		cCOD	:= "15"
	Case cUF == "PB"
		cCOD	:= "16"
	Case cUF == "PR"
		cCOD	:= "17"
	Case cUF == "PE"
		cCOD	:= "18"
	Case cUF == "PI"
		cCOD	:= "19"
	Case cUF == "RJ"
		cCOD	:= "22"
	Case cUF == "RN"
		cCOD	:= "20"
	Case cUF == "RS"
		cCOD	:= "21"
	Case cUF == "RO"
		cCOD	:= "23"
	Case cUF == "RR"
		cCOD	:= "24"
	Case cUF == "SC"
		cCOD	:= "25"
	Case cUF == "SP"
		cCOD	:= "26"
	Case cUF == "SE"
		cCOD	:= "27"
	Case cUF == "TO"
		cCOD	:= "29"
EndCase

Return(cCOD )
/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Funcao    �a972Dipam �Autor  �Andreia dos Santos  ?Data ? 26/06/00   ��?
�������������������������������������������������������������������������͹�?
���Desc.     �Grava os registros referentes a DIPAM-B. CR=30              ��?
��?         ?                                                           ��?
�������������������������������������������������������������������������͹�?
���Uso       ?MATA972                                                    ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972Dipam()

cRegistro	:=	"30"													//01.Codigo de Registro
cRegistro	+=	a972Fill((cArqDipam)->CODDIP,2)							//02.Codigo da DIPI
cRegistro   +=  a972Fill((cArqDipam)->MUNICIP,5)						//03.Codigo do Municipio
cRegistro	+=	a972Fill(Num2Chr((cArqDipam)->VALOR,15,2),15)			//04.Codigo do Municipio

a972Grava( cRegistro )

Return(.T.)
/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Funcao    �a972Expot �Autor  �Eduardo Jose Zanardo?Data ? 08/02/02   ��?
�������������������������������������������������������������������������͹�?
���Desc.     �Grava os registros referentes a exportacao CR=31            ��?
��?         ?                                                           ��?
�������������������������������������������������������������������������͹�?
���Uso       ?MATA972                                                    ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972Expot()

cRegistro	:=	"31"												//01.Codigo de Registro
cRegistro	+=	a972Fill((cArqExpt)->RE,15)							//02.Registro de Importacao

a972Grava( cRegistro )

Return(.T.)

/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Funcao    �a972TmpIE ?Autor �Sergio S. Fuzinaka  ?Data ? 26/05/03   ��?
�������������������������������������������������������������������������͹�?
���Desc.     �Grava os registros referentes a IE CR=25, somente movimenta-��?
��?         �cao de transferencia ( F3->TRFICM > 0 )                     ��?
�������������������������������������������������������������������������͹�?
���Uso       �MATA972                                                     ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972TmpIE(cAlias)

Local cIE := ""
Local aSA1 := {}
Local aSA2 := {}
local lDevBen	:= .F.
Local cTab		:= ''

If (cAlias)->F3_TRFICM > 0	//Houve transferencia de Credito ou Debito

	lDevBen := (cAlias)->F3_TIPO $ "DB"

	If Left((cAlias)->F3_CFO,1) >= "5"
		cTab := Iif(lDevBen,'A2','A1')
	Else
		cTab := Iif(lDevBen,'A1','A2')
	EndIF

	If cTab == 'A1'
		aSA1 := SA1->(GetArea())
		SA1->(dbSetOrder(1))
		SA1->(msSeek(xFilial("SA1")+(cAlias)->F3_CLIEFOR+(cAlias)->F3_LOJA,.F.))
		cIE := Alltrim(SA1->A1_INSCR)
		RestArea(aSA1)
	Else
		aSA2 := SA2->(GetArea())
		SA2->(dbSetOrder(1))
		SA2->(msSeek(xFilial("SA2")+(cAlias)->F3_CLIEFOR+(cAlias)->F3_LOJA,.F.))
		cIE := Alltrim(SA2->A2_INSCR)
		RestArea(aSA2)
	EndIF
	If (cArqIE)->(msseek(PADR((cAlias)->F3_CFO,5,' ')+cIE))
		RecLock((cArqIE),.F.)
		(cArqIE)->IE 		:= cIE
		(cArqIE)->VALOR += (cAlias)->F3_TRFICM
	Else
		RecLock((cArqIE),.T.)
		(cArqIE)->SUBITEM	:= (cAlias)->F3_CFO
		(cArqIE)->IE 		:= cIE
		(cArqIE)->VALOR		:= (cAlias)->F3_TRFICM
	Endif
	MsUnlock()
Endif

Return Nil

/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Funcao    �a972TmIeST ?Autor �Diego Dias          ?Data ? 28/07/16  ��?
�������������������������������������������������������������������������͹�?
���Desc.     �Grava os registros referentes a IE Substituto CR=26         ��?
��?         ?                                                           ��?
�������������������������������������������������������������������������͹�?
���Uso       �MATA972                                                     ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972TmIeST(cAlias)

Local cIE := ""
Local aSA1 := {}
Local aSA2 := {}
local lDevBen	:= .F.

lDevBen := (cAlias)->F3_TIPO $ "DB"

If	lDevBen
	aSA2 := SA2->(GetArea())
	SA2->(dbSetOrder(1))
	SA2->(msSeek(xFilial("SA2")+(cAlias)->F3_CLIEFOR+(cAlias)->F3_LOJA,.F.))
	cIE := Alltrim(SA2->A2_INSCR)
	RestArea(aSA2)
Else
	aSA1 := SA1->(GetArea())
	SA1->(dbSetOrder(1))
	SA1->(msSeek(xFilial("SA1")+(cAlias)->F3_CLIEFOR+(cAlias)->F3_LOJA,.F.))
	cIE := Alltrim(SA1->A1_INSCR)
	RestArea(aSA1)
EndIF

RecLock((cArqIeST),.T.)
(cArqIeST)->SUBITEM	:= (cAlias)->F3_CFO
(cArqIeST)->IE 		:=	cIE
(cArqIeST)->NF 		:=	Strzero(Val((cAlias)->F3_NFISCAL),09)
(cArqIeST)->Dataini	:=	AnoMes(dDtIni)
(cArqIeST)->DataFim	:=	AnoMes(dDtFim)
(cArqIeST)->VALOR 	:= (cAlias)->F3_VALCONT

MsUnlock()
Return Nil

/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Funcao    �a972TmIeSD ?Autor �Diego Dias          ?Data ? 28/07/16  ��?
�������������������������������������������������������������������������͹�?
���Desc.     �Grava os registros referentes a IE Substitu�do CR=27        ��?
��?         ?                                                           ��?
�������������������������������������������������������������������������͹�?
���Uso       �MATA972                                                     ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function a972TmIeSD(cAlias)

Local cIE := ""
Local aSA1 := {}
Local aSA2 := {}
local lDevBen	:= .F.

lDevBen := (cAlias)->F3_TIPO $ "DB"

If	lDevBen
	aSA1 := SA1->(GetArea())
	SA1->(dbSetOrder(1))
	SA1->(msSeek(xFilial("SA1")+(cAlias)->F3_CLIEFOR+(cAlias)->F3_LOJA,.F.))
	cIE := Alltrim(SA1->A1_INSCR)
	RestArea(aSA1)
Else
	aSA2 := SA2->(GetArea())
	SA2->(dbSetOrder(1))
	SA2->(msSeek(xFilial("SA2")+(cAlias)->F3_CLIEFOR+(cAlias)->F3_LOJA,.F.))
	cIE := Alltrim(SA2->A2_INSCR)
	RestArea(aSA2)
EndIF

RecLock((cArqIeSD),.T.)
(cArqIeSD)->SUBITEM	:= (cAlias)->F3_CFO
(cArqIeSD)->IE 		:=	cIE
(cArqIeSD)->NF 		:=	Strzero(Val((cAlias)->F3_NFISCAL),09)
(cArqIeSD)->VALOR 	:= (cAlias)->F3_VALCONT

MsUnlock()

Return Nil

/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Function�A972RetMun  �Autor  �Gustavo G. Rueda    ?Data ? 28/09/2004 ��?
�������������������������������������������������������������������������͹�?
���Desc.   �Verifica se existe integracao com o TMS, e caso exista retorna��?
��?       ?o codigo do municipio da tabela DUE ou DUL. Caso contrario   ��?
��?       ?retorno do cadastro de cliente posicionado anteriormente.    ��?
�������������������������������������������������������������������������͹�?
���Paramet.�ExpC -> Indica o alias da tabela SF3 a ser utilizada.         ��?
��?       �ExpL -> Integracao com o TMS.                                 ��?
�������������������������������������������������������������������������͹�?
���Uso     ?MATA972                                                      ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function A972RetMun (cAliasSf3, lTms, cMvUF, cMVCODDP, cMVCODMUN, lA1CODMUN, cCodMunX )
Local		cCod_Mun 	 :=	""
Local		aArea		 :=	GetArea ()
Local		aCodMun	 := {}

If lTms
	//����������������������������������������������������Ŀ
	//?Integracao com TMS                                 ?
	//������������������������������������������������������
	aCodMun := TMSInfSol((cAliasSf3)->F3_FILIAL,(cAliasSf3)->F3_NFISCAL,(cAliasSf3)->F3_SERIE,(cAliasSf3)->F3_CLIEFOR,(cAliasSf3)->F3_LOJA,.T.)
	If Substr((cAliasSF3)->F3_CFO,1,1) >= "5"
		If Len(aCodMun) > 0
			//-- SIGATMS: para remetente SP e CFOP interestadual.
			If aCodMun[8] == cMvUF
				cCod_Mun := aCodMun[11]
			Else
				cCod_Mun := StrZero(val(CMVCODDP),5,0)
			EndIf
		EndIf
	EndIf
EndIf
//Alterado para quando n�o houver integra��o com TMS, traga o c�digo de municipio, para n�o apresentar erro na valida��o.
If Empty(cCod_Mun)
	SA1->(msseek(xFilial("SA1")+(cAliasSf3)->F3_CLIEFOR+(cAliasSf3)->F3_LOJA,.F.))
	If (cCodMunX<>"X") .And. !(SA1->(Eof ())) //GetNewPar ("MV_CODMUN", "X")
		If (SA1->(FieldPos(AllTrim(cMVCODMUN)))>0)
			cCod_Mun	:=	SA1->(FieldGet (FieldPos(cMVCODMUN)))
		Else
			cCod_Mun	:=	""
		EndIf
	Else
		cCod_Mun	:=	""
	EndIf
	//
	If lA1CODMUN .And. (Empty (cCod_Mun)) .And. !(SA1->(Eof ()))
		cCod_Mun	:=	SA1->A1_COD_MUN
	EndIf
EndIf
RestArea (aArea)
Return (cCod_Mun)

//-------------------------------------------------------------------
/*/{Protheus.doc} BannerTAF

Funcao responsabel em existir a mensagem de obrigatoriedade de uso do TAF para gerar as obriga��es fiscais a partir de uma determinada data.
Ela utiliza um jpg desenvolvido por MKT ( banner_taf.jpg ).
Se existir compilado o resource de Banner (.jpg) no reposit�rio, ele utiliza uma apresentacao mais elaborada. Pode acontecer do programa 
n�o estar no RPO, por isso faz um tratamento com getResArray.

@param Nil

@return Nil

@author Gustavo G. Rueda
@since 09/09/2016
/*/
//-------------------------------------------------------------------
Static Function BannerTAF()
Local	nLin	as	numeric
Local	ncol	as	numeric
Local	oDlg	as	object
Local	oLayer	as	object
Local	oSay	as	object
Local	bClick	as	codeblock
Local	oFont 	as	object
Local	cImg	as	char
Local	cTxt	as	char
Local	aRes	as	array

cImg			:=	'banner_taf'
aRes			:=	getResArray( cImg + '.jpg' )
cTxt			:=	''
oFont 			:= 	TFont():New('Arial',,-12,.T.)
oLayer 			:= 	FWLayer():New()
bClick			:=	{|| ShellExecute("open","http://tdn.totvs.com.br/pages/viewpage.action?pageId=268587913","","",1)}
nLin			:=	0
nCol			:=	820

If !( len( aRes ) > 0 )
	cTxt	:=	'<b>Prezado cliente,</b><br><br>'+ CRLF + CRLF
	cTxt	+=	'Sabemos que o cotidiano do profissional da �rea de tributos ?bastante din�mico e exige um controle detalhado de todas as atividades que envolvem obriga��es fiscais.<br><br>'
	cTxt	+=	'Pensando nisso, a TOTVS desenvolveu o <b>TAF - TOTVS Automa��o Fiscal</b>, que ?uma solu��o especialista em consolida��o de informa��es e converg�ncia fiscal.<br><br>'
	cTxt	+=	'Ao utilizar essa solu��o, voc?ganha <b>desempenho</b> na gera��o de obriga��es fiscais, <b>velocidade na implementa��o, suporte t�cnico personalizado e consultoria tribut�ria.</b><br><br>'
	cTxt	+=	'A partir de Fevereiro de 2017, algumas obriga��es fiscais na linha Microsiga Protheus passar�o a ser atendidas somente atrav�s do TAF.<br><br>'
EndIf

if !Empty( cTxt ) //quando o resoruce ( banner ) n�o estiver no rpo
	nLin	:=	470
else
	//foi necess�rio aumentar a tela de 520 para 570 e 420 para 470 devido a um problema de lib onde o bot�o (X) que fecha a tela
	//n�o est?aparecendo na vers�o 12. Ajustar ap�s corre��o do fw.
	nLin	:=	570
endif

//foi necess�rio comentar o "nOr( WS_VISIBLE, WS_POPUP )" devido a um problema de lib onde o bot�o (X) que fecha a tela do objeto FWLayer
//n�o est?aparecendo na vers�o 12. Descomentar ap�s corre��o do fw.
oDlg := MsDialog():New( 0, 0, nLin, nCol, "",,,, /*nOr( WS_VISIBLE, WS_POPUP )*/,,,,, .T.,,,, .F. )
oLayer:Init( oDlg, .T. )
oLayer:AddLine( "LINE01", 100 )
oLayer:AddCollumn( "BOX01", 100,, "LINE01" )
oLayer:AddWindow( "BOX01", "PANEL01", 'IMPORTANTE...', 100, .F.,,, "LINE01" )

If !Empty( cTxt )
	oSay	:=	TSay():New(10,10,{|| cTxt },oLayer:GetWinPanel ( 'BOX01' , 'PANEL01', 'LINE01' ),,oFont,,,,.T.,,,380,nLin,,,,,,.T.)
	oSay:lWordWrap = .T.
	TButton():New( 155, 335, "SAIBA MAIS",oLayer:GetWinPanel ( 'BOX01' , 'PANEL01', 'LINE01' ), bClick, 50,20,,,.F.,.T.,.F.,,.F.,,,.F. )
Else
	TBitmap():New(0,0,nLin,nCol,cImg,,.T.,oLayer:GetWinPanel ( 'BOX01' , 'PANEL01', 'LINE01' ),bClick,bClick,,.F.,,,,,.T.)
EndIf

oDlg:Activate(,,,.T.)

Return
