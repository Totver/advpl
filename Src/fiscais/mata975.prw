#INCLUDE "MATA975.ch"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATA975  ³ Autor ³ Andreia dos Santos    ³ Data ³ 30/08/99        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gera arquivo de Importacao da Declaracao de Informacoes Economico-³±±
±±³          ³ Fiscais da Pessoa Juridica( DIPJ ). Instr.Normativa 127/98.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ MATA975(void)                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Andreia       ³27/09/99³      ³criacao do ponto de entrada DIPIARQ            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
USER Function Mata975

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salva a Integridade dos dados de Entrada                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aArea	:=	GetArea()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nOpc		:=0	, oDlg
Local cTitulo	:=	""	
Local cText1	:=	""
Local cText2	:=	""
Local cText3	:=	""
Local aCAP		:=	{STR0001,STR0002,STR0003} //"Confirma"###"Abandona"###"Parƒmetros"

Private lEnd		:=.F.,lAbortPrint:=.F.
Private cMesApur 	:= "00"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para montar Get.                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aListBox	:={}
Private aMsg		:={}
Private aSel		:={}
Private aValid	    :={}
Private aConteudo   :={}
Private nLastKey    :=0
Private nValDevVen  :=0
Private cPerg	    :="MTA975"
Private aDocAbatMat	:={}  

AjustaSX1()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Janela Principal                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo	:=	"DIPJ"
cText1	:=	STR0004 //"Este programa gera arquivo pr‚-formatado para importacao da "
cText2	:=	STR0005 //"Declaracao de Informacoes Economico-Fiscais da Pessoa Juridica"
cText3	:=	STR0006 //"DIPJ, refente a pasta IPI. "

While .T.
	nOpc :=	0
	DEFINE MSDIALOG oDlg TITLE OemtoAnsi(cTitulo) FROM  165,115 TO 315,525 PIXEL OF oMainWnd 
	@ 03, 10 TO 43, 195 LABEL "" OF oDlg  PIXEL
	@ 10, 15 SAY OemToAnsi(cText1) SIZE 180, 8 OF oDlg PIXEL
	@ 20, 15 SAY OemToAnsi(cText2) SIZE 180, 8 OF oDlg PIXEL
	@ 30, 15 SAY OemToAnsi(cText3) SIZE 180, 8 OF oDlg PIXEL
	DEFINE SBUTTON FROM 50, 112 TYPE 5 ACTION (nOpc:=3,oDlg:End()) ENABLE OF oDlg
	DEFINE SBUTTON FROM 50, 141 TYPE 1 ACTION (nOpc:=1,oDlg:End()) ENABLE OF oDlg
	DEFINE SBUTTON FROM 50, 170 TYPE 2 ACTION (nOpc:=2,oDlg:End()) ENABLE OF oDlg
	ACTIVATE MSDIALOG oDlg
	Pergunte(cPerg,.F.)
	Do Case 
		Case nOpc==1
			Processa({|lEnd| A975Processa() })
		Case nOpc==3
			Pergunte(cPerg,.t.)
			Loop
	EndCase
	Exit
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura area                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea(aArea)

Return 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ A975Processa ³ Autor ³ Andreia dos Santos³ Data ³ 30/08/99 ³±±
±±³Alteracao ³ 			    ³ Autor ³ Bruno Matos	    ³ Data ³ 12/02/14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento do MATA975                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION A975Processa()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cArqBkp	:=""
Local cMsg		:=""
Local cArqDado	:= ""
Local cArqRem	:= ""
Local cArqMerc	:= ""
Local cPrdAcum	:= ""
LOCAL nRegOri 	:= SM0->(RecNo())
Local nRegEmp	:= 0
Local cEmpOri	:= FWGrpCompany()
Local nReg19 	:= 0
Local aEmpresa	:={}
Local j := 1
Local lFirst50	:=	.T.
Local lFirst36A :=	.T.
Local lFirst37A :=	.T.
Local lFisrt39	:=	.T.
Local lFisrt49	:=	.T.
Local lFirst60	:=	.T.
Local lFirst67	:=	.T.
Local lFirst06A :=	.T.
Local lFirst07A :=	.T.
Local lFirst38 :=	.T.
Local lFirst70 :=	.T.
Local lGerouR57 := .F.

Local lFirst04A :=	.T.
Local lFirst05A :=	.T.
Local lFirst09A :=	.T.
Local lFirst11 :=	.T.
Local lFirst12A :=	.T.
Local lFirst16 :=	.T.
Local lFirst17 :=	.T.
Local lFirst14A :=	.T.

Local lFirst19 :=	.T.
Local lFirst20 := 	.T.
Local lFirst21 := 	.T.  
Local lFirst22 :=	.T.
Local nForFilial	:= 0  
Local nY			:= 1    
Local cCgcAnt 

Private cArqTemp	:=	""
Private aReturn 	:=	{STR0007, 1,STR0008, 2, 2, 1, "",1 } //"Zebrado"###"Administra‡„o"
Private Nomeprog	:=	"MATA975"
Private dDtIni
Private dDtFim
Private nHandle	:=	-1
Private cCGC 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acumuladores para resumo de creditos/debitos                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
Private nEstDeb 	:=0	//estorno de Debitos
Private nOutrCred 	:=0	//Outros Creditos
Private nEstCred 	:=0	//Estorno de Creditos
Private nRessCred	:=0 //Ressarcimento de Creditos
Private nOutrDeb	:=0	//Outros Debitos

Private cFile		:=	""
Private lLucrReal   := .T.//Indica se a forma esccolhida de tributacao sera LUCRO REAL
Private aFilsCalc	:= {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega Parametros                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ mv_par01 - Mes Inicial                                       ³
//³ mv_par02 - Mes Final                                         ³
//³ mv_par03 - Ano da apuracao                                   ³
//³ mv_par04 - Nro. Livro                                        ³
//³ mv_par05 -> Considera filiais          ? Sim/Nao             ³
//³ mv_par06 -> Da Filial                                        ³
//³ mv_par07 -> Ate a Filial                                     ³
//³ mv_par08 -> Diretorio Destino                                ³
//³ mv_par09 -> Codigo do Municipio                              |
//³ mv_par10 -> Cod. Livro Contabil 06A 						 ³
//³ mv_par11 -> Cod. Livro Contabil 07A                          |
//³ mv_par12 -> Cod. Livro Contabil 36A 						 ³
//³ mv_par13 -> Cod. Livro Contabil 37A                  	     |
//³ mv_par14 -> Cod. Livro Contabil 38                           ³
//³ mv_par15 -> Cod. Livro Contabil 39				         	 ³
//³ mv_par16 -> Cod. Livro Contabil 49							 ³
//| mv_par17 -> Cod. Livro Contabil 70  						 ³
//³ mv_par18 -> Cod. Moeda                                       ³
//³ mv_par19 -> Cod. Livro Contabil 04A 						 ³
//³ mv_par20 -> Cod. Livro Contabil 05A 						 ³
//³ mv_par21 -> Cod. Livro Contabil 09A 						 ³
//³ mv_par22 -> Cod. Livro Contabil 11 						     ³
//³ mv_par23 -> Cod. Livro Contabil 12A 						 ³
//³ mv_par24 -> Cod. Livro Contabil 16 						     ³
//³ mv_par25 -> Cod. Livro Contabil 17 						     ³ 
//³ mv_par26 -> Seleciona Filial           ? Sim/Nao             ³
//³ mv_par27 -> Aglutina CNPJ	           ? Sim/Nao             ³ 
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nMesIni		:=	mv_par01	
PRIVATE	nMesFim		:=	mv_par02	
PRIVATE	nAno		:=	mv_par03	
PRIVATE	cNrLivro	:=	mv_par04
Private nConsfil 	:=  mv_par05
Private cFilDe 		:=  mv_par06
Private cFilAte 	:=  mv_par07
Private cDir        :=  mv_par08
Private cCodMun     :=  mv_par09 
Private lSelFil  	:= Iif(mv_par26==1,.T.,.F.)
Private lAglFil		:= Iif(mv_par27==1,.T.,.F.) 
Private lAglcgc		:= .T.
Private aApurAcm 	:= Array(12,12)

If lSelFil 
   Help(" ",1,"MTA975EXC")
EndIF
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define datas Limite                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
SX1->(dbSetOrder(1))
If !SX1->(dbSeek(PadR("MTA975",Len(SX1->X1_GRUPO))+"17"))
	Alert(STR0220)
	Return  
EndIf
dDtIni	:=	CTOD("01/"+STRZERO(nMesIni,2)+"/"+STRZERO(nAno,4),"ddmmyyyy")
dDtFim	:=	CTOD("01/"+STRZERO(nMesFim,2)+"/"+STRZERO(nAno,4),"ddmmyyyy")
dDtFim	:=	UltimoDia(dDtFim)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta tela para digitacao de itens.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ( lEnd	:=	A975Inf() )
	Return
EndIf

nRegEmp	:= SM0->(Recno())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Trata filiais                                                ³
//³ Caso haja algum parametro sem ser passado ou se nao seleciona³
//³ filiais, as filiais de/ate serao igualadas a filial corrente ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lSelFil      //Seleciona Filial = Sim
	aFilsCalc := MatFilCalc( lSelFil, , ,(lSelFil .and. lAglFil), , 3 )
	If Empty( aFilsCalc )
		Return
	EndIf
	For nForFilial := 1 To Len( aFilsCalc )
		If aFilsCalc[ nForFilial, 1 ]
			aAdd(aEmpresa,{ IIf(!Empty(aFilsCalc[nForFilial][4]), aFilsCalc[nForFilial][4], Replic("0",14) ), cEmpOri, aFilsCalc[nForFilial][2] } )
			Iif (cCgcAnt<>aFilsCalc[nForFilial][4],cCgcAnt:= aFilsCalc[nForFilial][4],)    
		EndIf
		If nForFilial > 1
			Iif (lAglcgc,Iif(cCgcAnt==aFilsCalc[nForFilial][4],lAglcgc:=.T.,lAglcgc:=.F.),)   
		EndIf
	Next
Else  
	lAglcgc := .F.
	lAglFil	:= .F.		// Se não seleciona, não será aglutinada
	cFilDe	:= IIf(Empty(cFilDe), cFilAnt, cFilDe)
	cFilAte	:= IIf(Empty(cFilAte), cFilAnt, cFilAte)
	SM0->(dbSeek(cEmpAnt+cFilDe,.T.))
	nRegEmp	:= SM0->(Recno())
	While !SM0->(Eof()) .and. FWGrpCompany() == cEmpAnt .and. FWCodFil() <= cFilAte
		aAdd(aEmpresa,{ IIf(!Empty(SM0->M0_CGC),SM0->M0_CGC,Replic("0",14)), FWGrpCompany(), FWCodFil() })	
		SM0->(dbSkip())
	EndDo
Endif


SM0->(dbGoTo(nRegEmp))
aEmpresa := aSort(aEmpresa,,,{|x,y| x[1] < y[1] })

While J <=  len(aEmpresa)
	If !lAglFil .or. J == 1
		cFile :=ALLTRIM(cDir)+"DIPJ"+AllTrim(aEmpresa[j,2]+aEmpresa[j,3])+".SRF"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia registro                                              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !File(cFile)
			nHandle:=MsFCreate(cFile)
		Else
			cArqBkp:=StrTran(cFile,".SRF",".#SR")
			cMsg := STR0009 + cFile + STR0010              //"O arquivo "###" ja existe,"
			cMsg += STR0011+cArqBkp                        //"o sistema gera um Backup "
			nOpcB:=Aviso("Drive",cMsg,{STR0012,STR0013}) //"Abandonar"###"Continuar"
			If nOpcB==1.Or.nLastKey==27
				lEnd:=.T.
				Exit
			Else
				If File(cArqBkp)
					Ferase(cArqBkp)
				Endif
				FRename(cFile,cArqBkp)
				nHandle:=MSFCREATE(cFile)
			Endif
		Endif
	
	EndIf
	
	Iif(!lAglcgc,SM0->(dbSeek(aEmpresa[j,2]+aEmpresa[j,3],.F.)),cFilAnt:= aEmpresa[j,3] )

	cCGC := IIf(!Empty(aEmpresa[j,1]), aEmpresa[j,1], Replic("0",14))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apura registro Tipo 1.                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			A975Header()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apura registro Tipo R01.                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			A975R01()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apura registro Tipo 2.                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			A975R02()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apura registro Tipo R03 e Tipo R04                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			A975R03()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apura Ficha R04A - Custo dos Bens e Serviços Vendidos - Com Atividade Rural - PJ em Geral  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc()
	If !empty(mv_par19) .And. !empty(mv_par18) .And. lFirst04A
			A975R04A(aEmpresa)
        	lFirst04A := .F.    
		Endif 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apura Ficha R05A - Despesas Operacionais - Com Atividade Rural - PJ em Geral               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc()
	If !empty(mv_par20) .And. !empty(mv_par18) .And. lFirst05A
			A975R05A(aEmpresa)
        	lFirst05A := .F.    
		Endif 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apura Ficha R06A - Demonstração do Resultado - Com Atividade Rural - PJ em Geral ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc()
	If !empty(mv_par10) .And. !empty(mv_par18) .And. lFirst06A
			A975R06A(aEmpresa)
        	lFirst06A := .F.    
		Endif 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apura Ficha R07A - Demonstração do Resultado -Criterios em 31.12.2007 - Com Atividade Rural - PJ em Geral³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc()
	If !empty(mv_par11) .And. !empty(mv_par18) .And. lFirst07A
			A975R07A(aEmpresa)
        	lFirst07A := .F.    
		Endif         
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apura Ficha R09A - Demonstração do Lucro Real - Com Atividade Rural - PJ em Geral          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc()
	If !empty(mv_par21) .And. !empty(mv_par18) .And. lFirst09A
			A975R09A(aEmpresa)
        	lFirst09A := .F.    
		Endif 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apura Ficha R11 - Cálculo do Imposto de Renda Mensal por Estimativa                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc()
	If !empty(mv_par22) .And. !empty(mv_par18) .And. lFirst11
			A975R11(aEmpresa)
        	lFirst11 := .F.    
		Endif 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apura Ficha R12A - Cálculo do Imposto de Renda sobre o Lucro Real - PJ em Geral            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc()
	If !empty(mv_par23) .And. !empty(mv_par18) .And. lFirst12A
			A975R12A(aEmpresa)
        	lFirst12A := .F.    
		Endif 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apura Ficha R14A -  - PJ em Geral            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc()
		If !lEnd .And. !empty(mv_par26) .And. !empty(mv_par18) .And. lFirst14A
			A975R14A(aEmpresa)
        	lFirst14A := .F.    
		Endif 		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apura Ficha R16 - Cálculo da Contribuição Social sobre o Lucro Líquido Mensal por Estimativa ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc()
	If !empty(mv_par24) .And. !empty(mv_par18) .And. lFirst16
			A975R16(aEmpresa)
        	lFirst16 := .F.    
		Endif 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apura Ficha R17 - Cálculo da Contribuição Social sobre o Lucro Líquido - Com Atividade Rural ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc()
	If !empty(mv_par25) .And. !empty(mv_par18) .And. lFirst17
			A975R17(aEmpresa)
        	lFirst17 := .F.    
		Endif 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ A Partir daqui pode ter varias filiais			 		     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While Iif(lAglcgc, nY <=  len(aEmpresa),!SM0->(Eof()) .and. FWGrpCompany() == cEmpAnt )
		
		Iif(lAglcgc, cFilAnt := aEmpresa[nY,3],cFilAnt := FWCodFil() ) 	// Mudar filial atual temporariamente
			cCGC1 	:= if(!empty(SM0->M0_CGC),SM0->M0_CGC,replic("0",14))
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inicializa regua.  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			ProcRegua(11,17,4)

			nReg19 ++
			nEstDeb 	:=0	//estorno de Debitos	
			nOutrCred 	:=0	//Outros Creditos
			nEstCred 	:=0	//Estorno de Creditos
			nRessCred	:=0   //Ressarcimento de Creditos
			nOutrDeb	:=0	//Outros Debitos
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Busca informacoes das Apuracoes de IPI.                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
			if !lEnd
				cArqTemp	:=	A975Apura(nMesIni,nMesFim)
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Busca itens de Demonstrativos de Cred./Debito                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
			if !lEnd
				If (existblock("DIPIARQ"))
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Este ponto de entrada tera que retornar um arquivo de trabalho	³
					//³ com a seguinte estrutura:                     		            ³
					//³ "TIPOMOV"	,	"C"	,	1	,0 		// "E"ntradas / "S"aidas	³
					//³ "NOTA"   	,	"C"	,	TamSX3("F2_DOC")[1]	,0	//Numero da Nota³
					//³ "SERIE"		,	"C"	,	3	,0			// Serie				³
					//³ "ITEM"		,	"C"	,	2	,0			// Item da Nota			³
					//³ "TIPO"		,	"C"	,	1	,0			// Tipo da Nota			³
					//³ "DT_ENTRADA",	"D"	,	8	,0			// Data de Entrada		³
					//³ "DT_EMISSAO",	"D"	,	8	,0			// Data de Emissao		³
					//³ "CLIFOR"	,	"C"	,	6	,0			// Cod do Cliente/Forn.	³
					//³ "LOJA"		,	"C"	,	2	,0			// Loja					³
					//³ "NOME"		,	"C"	,	50	,0			// Razao social			³
					//³ "CGC"		,	"C"	,	18	,0			// CGC					³
					//³ "UF"		,	"C"	,	2	,0			// UF					³
					//³ "TIPOCLIFOR",	"C"	,	1	,0			// Tipo do Cliente/Forn.³
					//³ "PRODUTO"	,	"C"	,	15	,0			// Cod do Produto		³
					//³ "DESCPROD"	,	"C"	,	50	,0			// Descricao do Produto	³
					//³ "NBM"		,	"C"	,	12	,0			// Codigo NBM			³
					//³ "TES"		,	"C"	,	3	,0			// TES					³
					//³ "CFO"		,	"C"	,	3	,0			// CFO					³
					//³ "VALMERC"	,	"N"	,	14	,2			// Valor da Mercadoria	³
					//³ "VALIPI"	,	"N"	,	14	,2			// Valor do IPI			³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					cArqDado	:= ExecBlock("DIPIARQ",.F.,.F.)
				Else	
					cArqDado	:= A975Moviment(nMesIni,nMesFim,cNrLivro,dDtIni,dDtFim,lAbortPrint)
				EndIf
				cArqRem		:= a975CriaRem()
				cArqMerc	:= a975CriaMerc()
				cPrdAcum	:= a975PrdAcum()  
			endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 19 - Estab. industriais ou equiparados           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
		If AllTrim(aConteudo[23]) == "1" .And. Iif(lAglcgc,lFirst19,.T.)
				A975R19(nReg19)
			lFirst19 := .F.
			Endif				
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 20 - Apuracao do Saldo do IPI                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
		If AllTrim(aConteudo[23]) == "1" .And. Iif(lAglcgc,lFirst21,.T.) 
		   If lAglcgc
		   
			   If !lFirst20	
			      A975R20(lFirst20,aApurAcm,lAglcgc)  
			      lFirst21:= .F.      
			      Loop
			   EndIF
			   
			   If nY == Len(aEmpresa) .And. lFirst20
			      A975R20(lFirst20,aApurAcm,lAglcgc)
			      lFirst20 := 	.F.   
			      Loop
			   Else 
			      A975R20(lFirst20,aApurAcm,lAglcgc)          
			      nY ++
			      Loop
			   EndIf          
		   
		   Else 
		   		A975R20()
		   EndIf	 
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 21 - Entradas e Creditos e                       ³
			//³ Apura Ficha 22 - Saidas e Debitos                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
		If AllTrim(aConteudo[23]) == "1" .And. Iif(lAglcgc,lFirst22,.T.) 
			If 	lAglcgc
		   		A975R21e22(cArqDado,cArqRem,cArqMerc,cPrdAcum)  
				lFirst22:= .F.      
			Else
				A975R21e22(cArqDado,cArqRem,cArqMerc,cPrdAcum)
			EndIF 
		Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 23 - Remetentes de Insumos/Mercadorias           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
				A975R23(cArqRem)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 24 - Entradas de Insumos/Mercadorias             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
				A975R24(cPrdAcum)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 25 -Destinatarios de Produtos/Mercadorias/Insumos³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
				A975R25(cArqRem)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 26 - Saidas de Produtos/Mercadorias/Insumos      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
				A975R26(cPrdAcum)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Apura Ficha 29A - Operacoes com Exterior - Pessoa Vinculada/Interposta/Pais com Trib. Favorecida ³
			//³Apura Ficha 29B - Operacoes com Exterior - Pessoa Nao Vinc./Nao Interposta/Pais s/ Trib. Favorec.³
			//³Apura Ficha 30  - Operacoes com o Exterior - Exportacoes (Entradas Divisas)                      ³
			//³Apura Ficha 31  - Operacoes com o Exterior - Contratantes das Exportacoes                        ³
			//³Apura Ficha 32  - Operacoes com o Exterior - Importacoes (Saidas de Divisas)                     ³
			//³Apura Ficha 33  - Operacoes com o Exterior - Contratantes das Importacoes                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
			IncProc()
				A975R29a33()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 36A - Ativo - Balanço Patrimonial ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		 
			IncProc()
		If !empty(mv_par12) .And. !empty(mv_par18) .And. lFirst36A
				A975R36A(aEmpresa)
            lFirst36A := .F.    
			Endif			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 37A - Passivo - Balanço Patrimonial ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			 
			IncProc()
		If !empty(mv_par13) .And. !empty(mv_par18) .And. lFirst37A           				
				A975R37A(aEmpresa)
				lFirst37A := .F.
			Endif			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha R38 - Demonstração dos Lucros ou Prejuízos Acumulados ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
		If !empty(mv_par14) .And. !empty(mv_par18) .And. lFirst38
				A975R38(aEmpresa)
            lFirst38 := .F.    
			Endif			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 39 - Origem e Aplicacao de Recursos ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				                                                    
  			IncProc()
		If !empty(mv_par15) .And. !empty(mv_par18) .And. lFisrt39            				
				A975R39(aEmpresa)
				lFisrt39 := .F.
			Endif 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 49 - Polo Industrial de Manaus e Amazonia Ocidental ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
		If !empty(mv_par16) .And. !empty(mv_par18) .And. lFisrt49            				
				A975R49(aEmpresa)
				lFisrt49 := .F.
			Endif 			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Ficha 54 - Discriminação da Receita de Vendas dos Estabelecimentos por Atividade Econômica    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
				A975R54(cArqMerc)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Ficha 55 - Vendas a Comercial Exportadora com Fim Específico de Exportação    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
				A975R55(cArqMerc)                            		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Ficha 56 - Detalhamento das Exportações da Comercial Exportadora    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
				A975R56(cArqMerc)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 57 - IR e CSLL Retido na Fonte ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
			if !lGerouR57
					If FWModeAccess("SE1",3)=="C" .And. SE1->(FieldPos("E1_MSFIL"))>0		//Tratamento pelo campo MSFIL
						MTA97550(aEmpresa)
					ElseIf FWModeAccess("SE1",3)=="C" .And. !SE1->(FieldPos("E1_MSFIL"))>0 .And. lFirst50	//Caso nao exista o MSFIL e a tabela for compartilhada, processo uma unica vez para nao duplicar valores.
						MTA97550(aEmpresa)
						lFirst50  :=.F.
					Else
						MTA97550(aEmpresa)
					EndIf					
				lGerouR57 := .t.
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 60 - Identificacao do socio ou titular			 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
		If lFirst60
				A975R60()
				lFirst60 := .F.
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 67A - Outras Informacoes						 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
		If lLucrReal .And. lFirst67
				A975R67A(aEmpresa)
				lFirst67 := .F.
			Endif		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apura Ficha 70 - Informacoes previdenciarias ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
		If !empty(mv_par17) .And. !empty(mv_par18) .And. lFirst70
				A975R70(aEmpresa)
                lFirst70 := .F.    
			Endif	           
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apaga arquivos temporarios                                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If File(cArqTemp+GetDBExtension())
				dbSelectArea(cArqTemp)
				dbCloseArea()
				Ferase(cArqTemp+GetDBExtension())
				Ferase(cArqTemp+OrdBagExt())
			Endif

			If File(cArqDado+GetDBExtension())
				dbSelectArea(cArqDado)
				dbCloseArea()
				Ferase(cArqDado+GetDBExtension())
				If File(cArqDado+OrdBagExt())
					Ferase(cArqDado+OrdBagExt())
				Endif
			Endif

			If File(cArqRem+GetDBExtension())
				dbSelectArea(cArqRem)
				dbCloseArea()
				Ferase(cArqRem+GetDBExtension())
				Ferase(Padr(cArqRem,7)+"A"+OrdBagExt())
				Ferase(Padr(cArqRem,7)+"B"+OrdBagExt())
				Ferase(Padr(cArqRem,7)+"C"+OrdBagExt())
			Endif

			If File(cArqMerc+GetDBExtension())
				dbSelectArea(cArqMerc)
				dbCloseArea()
				Ferase(cArqMerc+GetDBExtension())
				Ferase(padr(cArqMerc,7)+"D"+OrdBagExt())
				Ferase(padr(cArqMerc,7)+"E"+OrdBagExt())
			Endif           
			If File(cPrdAcum+GetDBExtension())
				dbSelectArea(cPrdAcum)
				dbCloseArea()
				Ferase(cPrdAcum+GetDBExtension())
				Ferase(Padr(cPrdAcum,7)+"F"+OrdBagExt())
				Ferase(padr(cPrdAcum,7)+"G"+OrdBagExt())
			Endif

			J++
		If J > Len(aEmpresa) .or. !lAglFil
				exit
			endif
		endDo
		cFilAnt := FWCodFil()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Registro TRAILLER                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			A975TRAILLER()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Fecha arquivo texto                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
		If nHandle >= 0
			FClose(nHandle)
		Endif
	If lAglFil
			exit
		EndIf	
	Enddo	

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³   A975Inf    ³ Autor ³ Andreia dos Santos³ Data ³ 03/09/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Monta Gets p/digitacao de informacoes para DIPJ            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION A975Inf()

LOCAL cMsg	:=	""
LOCAL cValid:=	""	
Local i		:=1
LOCAL oListBox
LOCAL nOpcA	:=	2	
LOCAL oDlgGet
LOCAL lRet	:=.F.

AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")
AADD(aListBox,STR0014)  ; AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") //"CAMPOS REFERENTES A DIPJ 2013"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ficha 01 - Dados Iniciais              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aListBox,STR0015); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") 
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")

cMsg:=STR0016
AADD(aListBox,STR0017); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid(,'01')") //" 0105 - Ano Calendario "

cMsg:=STR0018 //"Declaracao Retificadora 0-Sim/1-Nao"
AADD(aListBox,STR0019); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid(,'01')") //" 0106 - Declaracao Retificadora"

cMsg:=STR0020 //"Digite o Numero do Recibo caso a Declaracao seja Retificadora"
AADD(aListBox,STR0021); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','RECIBO')") //" 0107 - Numero do Recibo da DIPJ a ser Retificada "

cMsg:=STR0022 //"0-Nao se aplica,1-Extincao,2-Fusao,3-Incorp./Incorporada,4-Incorp./Incorporadora,5-Cisao Total,6-Cisao Parcial"
AADD(aListBox,STR0023); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','SITUACAO')") //" 0108 - Situacao Especial  "

cMsg:=STR0024 //"Caso a Situacao Especial se aplique digite a Data do Evento no formato (DDMM)"
AADD(aListBox,STR0025); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','EVENTO')") //" 0109 - Data do Evento "

cMsg:=STR0026 //"Preencha com 0-Nao Optante ou 1-Para Optante"
AADD(aListBox,STR0027); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid(,'01')") //" 0112 - Optante REFIS"

cMsg:=STR0062 //"Preencha com 0-Nao ou 1-Sim"
AADD(aListBox,STR0040); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid(,'01')") //" 0113 - Part. Permanente Coligadas/Controladas"

cMsg:=STR0062 //"Preencha com 0-Nao ou 1-Sim"
AADD(aListBox,STR0041); AADD(aSel,.t.); AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid(,'01')") //" 0114 - Com. Eletronico e Tec. Informacao"

cMsg:=STR0062 //"Preencha com 0-Nao ou 1-Sim"
AADD(aListBox,STR0042); AADD(aSel,.t.); AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid(,'01')") //" 0115 - Royalties recebidos Brasil/Exterior"

cMsg:=STR0062 //"Preencha com 0-Nao ou 1-Sim"
AADD(aListBox,STR0043); AADD(aSel,.t.); AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid(,'01')") //" 0116 - Royalties pagos a ben. Brasil/Exterior"

cMsg:=STR0062 //"Preencha com 0-Nao ou 1-Sim"
AADD(aListBox,STR0044); AADD(aSel,.t.); AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid(,'01')") //" 0117 - Rend. de servicos, juros e dividendos a ben. Brasil/Exterior"

cMsg:=STR0062 //"Preencha com 0-Nao ou 1-Sim"
AADD(aListBox,STR0045); AADD(aSel,.t.); AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid(,'01')") //" 0118 - Pagtos/remes. a tit. de servicos, juros e dividendos a ben. Brasil/Exterior"

/*
NAO POSSUI - 0119, 0120 e 0121
*/

cMsg:=STR0046 //"Preencha com 1-Real,2-Presumido,3-Arbitrado,4-Real/Arbitrado,5-Presumido/Arbitrado,6-Imune do IRPJ,7-Isenta do IRPJ,8-Presumido Real e 9-Presumido/Real/Arbitrado"
AADD(aListBox,STR0047); AADD(aSel,.t.); AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','123456789')") //" 0122 - Forma de Tributacao"

cMsg:=STR0048 //"Preencha com 0-Nao se Aplica,1-PJ em Geral,2-PJ Componente do Sistema Financeiro,3-Sociedade Seguradora e 4-Corretora Autonoma de Seguros"
AADD(aListBox,STR0049); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','QUALIFICACAO')") //" 0123 - Qualificacao da Pessoa Juridica "

cMsg:=STR0050 //"Preencha com 0-Nao se Aplica, 1-Anual,2-Trimestral e 3-Desobrigada"
AADD(aListBox,STR0051); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','0123')") //" 0124 - Apuracao do IRPJ e da CSLL (Apuracao da CSLL para Imunes ou Isentas)"

cMsg:=STR0052 //"Indicar o trimestre que foi arbitrado"
AADD(aListBox,STR0053); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid," ") //" 0125 - Trimestres de Lucro Arbitrado"

cMsg:=STR0054 //"Preencha com 0-Nao se Aplica, 1-Real/Estimativa,2-Real/Trimestral,3-Presumido,4-Arbitrado"
AADD(aListBox,STR0055); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01234')") //" 0126 - Apuracao do IRPJ e da CSLL por Trimestre"

cMsg:=STR0056 //"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0057); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 0127 - Apuracao e Informacoes de IPI no Periodo"

cMsg:=STR0058	//Preencha com 0-Decendial, 1-Quinzenal, 2-Mensal
AADD(aListBox,STR0059); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','02')") //" 0128 - Tipo Apuração do IPI"

/*
0129 - NAO POSSUI 
*/

cMsg:=STR0062 //"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0063); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 0130 - Administradora de Fundos e Clubes de Investimento"

cMsg:=STR0064 //"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0065); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 0131 - Ativos no Exterior"

cMsg:=STR0066 //"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0067); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 0132 - Operacoes com o Exterior"

cMsg:=STR0068 //"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0069); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 0133 - Oper.c/pessoa vinculada/Interposta Pessoa/..."

cMsg:=STR0070 //"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0071); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 0134 - Participacoes no Exterior"

cMsg:=STR0074 //"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0075); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 0136 - Lucro da Exploracao"

cMsg:=STR0076 //"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0077); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 0137 - Isencao e Reducao do Imposto"

cMsg:=STR0078 //"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0079); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 0138 - Atividade Rural"

cMsg:=STR0080	//"Preencha conforme Tabela de Tipo de Entidade da DIPJ 2013. Exemplo : 00-Nao se aplica"
AADD(aListBox,STR0081); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,STR0082) //" 0139 - Tipo de Entidade "###"U_A975Valid('N','TIPO')"

cMsg:=STR0083 //"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0084); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 0140 - Desenquadramento"

cMsg:=STR0085 //"Se houver desenquadramento, informe a data"
AADD(aListBox,STR0086); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('D')") //" 0141 - Data do Desenquadramento"

cMsg:=STR0150	//"Optante pelo PAES - Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0151); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N', '01')") //" 0142 - Optante pelo PAES"

cMsg:=STR0154	//"Finor/Finam/Funres - Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0155); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //"0148 - Finor/Finam/Funres"

cMsg:=STR0164	//" PJ Comercial Exportadora - Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0161); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 0154 - PJ Comercial Exportadora"

cMsg:=STR0165	//" PJ Efetuou Vendas a Comercial Exportadora - Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0162); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 0155 - PJ Efetuou Vendas a Empresa Comercial Exportadora"

cMsg:=STR0056	//"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0156); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')")	//" 0149 - Inovacao Tecnologica e Desenvolvimento Tecnologico"

cMsg:=STR0056	//"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0157); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')")	//" 0150 - Capacitacao de Informatica e Inclusao Digital"

cMsg:=STR0056	//"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0158); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')")	//" 0151 - PJ Habilitada no Repes ou Recap"

cMsg:=STR0056	//"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0159); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')")	//" 0152 - Polo Industrial de Manaus e Amazonia Ocidental"

cMsg:=STR0056	//"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0160); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')")	//" 0153 - Doacoes a Campanhas Eleitorais"

cMsg:=STR0166	//"Preencha com 0-Nao Marcado, 1-Sim, 2-Nao"
AADD(aListBox,STR0167); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','012')")	//" 0156 - PJ Sujeita a Aliquota da CSLL 15%"

cMsg:=STR0170	//"Indicar o trimestre que foi arbitrado quando a forma de de tributação igual a 5"
AADD(aListBox,STR0169); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"") // "0158 - Indicar o trimestre que foi arbitrado quando a forma de de tributação igual a 5"

cMsg:=STR0056	//"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0171); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')")	//" 0159 - Participacao em consorcio de empresas"

cMsg:=STR0056	//"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0172); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')")	//" 0160 - Rendimentos recebidos do exterior ou de nao residentes"

cMsg:=STR0056	//"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0173); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')")	//" 0161 - Pagamentos ao exterior ou a nao residentes"

cMsg:=STR0056	//"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0174); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')")	//" 0162 - Zonas de processamento de exportacao"

cMsg:=STR0056	//"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0175); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')")	//" 0163 - Areas de livre comercio"

cMsg:=STR0222	//"Preencha com 0-Nao Marcado, 1-Livro-Caixa, 2-Contabil"
AADD(aListBox,STR0221); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','012')")	//" 0164 - Forma de Escrituração"

cMsg:=STR0166	//"Preencha com 0-Nao Marcado, 1-Sim, 2-Nao"
AADD(aListBox,STR0223); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','012')")	//" 0165 - Regras de Preços de Transferência"

AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ficha 02 - Dados Cadastrais            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aListBox,STR0087); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") //"  Ficha 02 - Dados Cadastrais "
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")

cMsg:=STR0088 //"Digite apenas o DDD do Telefone"
AADD(aListBox,STR0089); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','DDD')") //" 0216 - DDD Telefone "

cMsg:=STR0090 //"Digite apenas o Numero do Telefone sem o DDD"
AADD(aListBox,STR0091); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','FONE')") //" 0217 - Telefone "

cMsg:=STR0092 //"Digite apenas o DDD do Fax"
AADD(aListBox,STR0093); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','DDD')") //" 0218 - DDD do Fax "

cMsg:=STR0094 //"Digite apenas o Numero do Fax sem o DDD"
AADD(aListBox,STR0095); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','FONE')") //" 0219 - Fax "

cMsg:=STR0096 //""Digite o Numero da Caixa Postal"
AADD(aListBox,STR0097); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N')") //" 0220 - Caixa Postal "

cMsg:=STR0098 //"Digite a UF da Caixa Postal"
AADD(aListBox,STR0099); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,".T.") //" 0221 - UF da Caixa Postal "

cMsg:=STR0100 //"Digite o CEP da Caixa Postal"
AADD(aListBox,STR0101); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N')") //" 0222 - CEP da Caixa Postal "

cMsg:=STR0102 //"Digite o Correio Eletronico (e-mail)"
AADD(aListBox,STR0103); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,".T.") //" 0223 - Correio Eletronico "

cMsg:=STR0152 //" 0224 - Tipo de Logradouro - 01=Aeroporto, 02-Alameda, etc..."
AADD(aListBox,STR0153); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,".T.") //" 0224 - Tipo de Logradouro - 01=Aeroporto, 02-Alameda, etc..."
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ficha 03 - Dados do Repres. e do Representante ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aListBox,STR0104); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") //"  Ficha 03 - Dados do Repres. e do Responsavel"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")

cMsg:=STR0105 //"Digite o Nome do Representante"
AADD(aListBox,STR0106); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,".T.") //" 0306 - Nome do Representante"
cMsg:=STR0107 //"Digite o CPF do Representante"
AADD(aListBox,STR0108); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N')") //" 0307 - CPF do Representante"
cMsg:=STR0109 //"Digite apenas o DDD do Representante"
AADD(aListBox,STR0110); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N')") //" 0308 - DDD do Representante "
cMsg:=STR0111 //"Digite apenas o Numero do Telefone sem o DDD"
AADD(aListBox,STR0112); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N')") //" 0309 - Telefone do Representante "
cMsg:=STR0113 //"Digite o Ramal do Representante"
AADD(aListBox,STR0114); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N')") //" 0310 - Ramal "
cMsg:=STR0115 //"Digite apenas o DDD do Fax"
AADD(aListBox,STR0116); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N')") //" 0311 - DDD do Fax do Representante "
cMsg:=STR0117 //"Digite apenas o Numero do Fax sem o DDD"
AADD(aListBox,STR0118); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N')") //" 0312 - Fax do Representante "
cMsg:=STR0119 //"Digite o Correio Eletronico do Representante"
AADD(aListBox,STR0120); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,".T.") //" 0313 - Correio Eletronico do Representante "
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")
cMsg:=STR0121 //"Digite o Nome do Responsavel"
AADD(aListBox,STR0122); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,".T.") //" 0314 - Nome do Responsavel "
cMsg:=STR0123 //"Digite o CPF do Responsavel"
AADD(aListBox,STR0124); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N')") //" 0315 - CPF do Responsavel "
cMsg:=STR0125 //"Digite o CRC do Responsavel"
AADD(aListBox,STR0126); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,".T.") //" 0316 - CRC do Responsavel "
cMsg:=STR0127 //"Digite a UF do Responsavel"
AADD(aListBox,STR0128); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,".T.") //" 0317 - UF do Responsavel "
cMsg:=STR0129 //"Digite apenas o DDD do Responsavel"
AADD(aListBox,STR0130); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N')") //" 0318 - DDD do Responsavel "
cMsg:=STR0131 //"Digite apenas o Numero do Telefone sem o DDD"
AADD(aListBox,STR0132); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N')") //" 0319 - Tel. Responsavel "
cMsg:=STR0133 //"Digite o Ramal do Responsavel"
AADD(aListBox,STR0134); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N')") //" 0320 - Ramal "
cMsg:=STR0135 //"Digite apenas o DDD do Fax"
AADD(aListBox,STR0136); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N')") //" 0321 - DDD do Fax do Responsavel "
cMsg:=STR0137 //"Digite apenas o Numero do Fax sem o DDD"
AADD(aListBox,STR0138); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N')") //" 0322 - Fax do Responsavel "
cMsg:=STR0139 //"Digite o Correio Eletronico do Responsavel"
AADD(aListBox,STR0140); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,".T.") //" 0323 - Correio Eletronico do Responsavel "
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")              

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ficha R04A, R05A, R09A, R11, R12A, R14A - Pasta IRPJ ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
AADD(aListBox,STR0207); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") //"Fichas Referentes a Pasta IRPJ"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") 
cMsg:=STR0209//" Prencher com 00-Anual, 01-1ºTrim, 02-2ºTrim, 03-3ºTrim, 04-4ºTrim"
AADD(aListBox,STR0208); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N'),'0001020304'") //"0603 - Trimestre"
cMsg:=STR0211//Prencher com 01-Atividade em Geral AG, 02-Atividade Rural AR
AADD(aListBox,STR0210); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N'),'0102'") //"0604 - Coluna"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ficha R16, R17 - Pasta CSLL  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
AADD(aListBox,STR0212); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") //"Fichas Referentes a Pasta CSLL"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") 
cMsg:=STR0214//" Prencher com 00-Anual, 01-1ºTrim, 02-2ºTrim, 03-3ºTrim, 04-4ºTrim"
AADD(aListBox,STR0213); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N'),'0001020304'") //"0703 - Trimestre"
cMsg:=STR0216//Prencher com 01-Atividade em Geral AG, 02-Atividade Rural AR
AADD(aListBox,STR0215); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N'),'0102'") //"0704 - Coluna"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ficha 23 - Remetente de Insumos/Mercadorias ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aListBox,STR0201); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") 
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")
cMsg:=STR0078 // Preencher com 0-Nao ou 1-Sim
AADD(aListBox,STR0202); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')")   //2311 -Ha relacao de Interdependencia
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ficha 25 - Destinatarios de Produtos/Mercadorias/Insumos    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aListBox,STR0203); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") 
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")
cMsg:=STR0078 // Preencher com 0-Nao ou 1-Sim
AADD(aListBox,STR0204); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')")   //2511 -Ha relacao de Interdependencia
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ficha 32 - Operacoes com o Exterior - Importacoes (Saidas de Divisas)  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aListBox,STR0181); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") //" Ficha 32 - Operacaoes com Exterior - Importacoes (Saidas de Divisas)"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")

cMsg:=STR0182 // "Preencher com 0-2012 e 1-2013"
AADD(aListBox,STR0183); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 3205 - Ano Calendario "

cMsg:=STR0184 //"Preencher com 0-Declaracao Original ou 1-Declaracao Retificadora"
AADD(aListBox,STR0185); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 3206 - Declaracao Retificadora"

cMsg:=STR0186 //"Preencha com 1-Bens, 2-Servicos, 3-Direitos, 4-Op. Financeiras, 5-Nao Especificadas" 
AADD(aListBox,STR0187); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','12345')") //" 3207 - Importacoes"  

cMsg:=STR0188 //"Preencha com 0-Não se Aplica, 1-PIC, 2-PRL - 20%, 3-PRL - 30%, 4-PRL - 40%, 5-PRL - 60%, 6-CPL, 7-PCI " 
AADD(aListBox,STR0189); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01234567')") //" 3214 - Metodo"  

AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ficha 33 - Operacoes com o Exterior - Contratantes das Importacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aListBox,STR0190); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") //" Ficha 33 - Operacaoes com Exterior - Importacoes (Saidas de Divisas)"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")

cMsg:=STR0191 // "Preencher com 0-2012 e 1-2013"
AADD(aListBox,STR0192); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 3305 - Ano Calendario "

cMsg:=STR0193 //"Preencher com 0-Declaracao Original ou 1-Declaracao Retificadora"
AADD(aListBox,STR0194); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','01')") //" 3306 - Declaracao Retificadora"

cMsg:=STR0195 //"Preencher com 1-Considerada Vinculada, 2-Interposta Pessoa - Transacao com Vinculada, 3-Residente/Domiciliada em Pais com Tributacao Favorecida"
AADD(aListBox,STR0196); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N','123')") //" 3310 - Condição da Pessoa Envolvida na Operacao"

AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ficha 36A - Ativo - Balanco Patrimonial  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
AADD(aListBox,STR0198); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") //" Ficha 36A - Ativo - Balanço Patrimonial"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") 
cMsg:=STR0199//" Coluna 01-Ultimo Balanco do Ano Imendiatamente Anterior ou 02-Ultimo Balanco do Ano da Declaracao"
AADD(aListBox,STR0200); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N'),'0102'") //"3604 - Coluna"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ficha 37A - Passivo - Balanco Patrimonial  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
AADD(aListBox,STR0205); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") //" Ficha 37A - Passivo - Balanço Patrimonial"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") 
cMsg:=STR0199//" Coluna 01-Ultimo Balanco do Ano Imendiatamente Anterior ou 02-Ultimo Balanco do Ano da Declaracao"
AADD(aListBox,STR0206); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N'),'0102'") //"3704 - Coluna"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ficha 67 - Outras informacoes				      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aListBox,STR0176); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") //" Ficha 67 - Outras informacoes"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")

cMsg:=STR0177 //"Preencha com 0-Nao preenchido, 1-Nao, 2-Sim"
AADD(aListBox,STR0179); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N'),'012'") //" 6702 - Alteracao de capital"
cMsg:=STR0177 //"Preencha com 0-Nao preenchido, 1-Nao, 2-Sim"
AADD(aListBox,STR0180); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N'),'012'") //" 6703 - Opcao escrit. no ativo, da base de calculo negativa da CSLL"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ficha R70 - Informacoes previdenciarias³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
AADD(aListBox,STR0217); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") // Ficha 70 - Informacoes previdenciarias"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"") 

cMsg:=STR0219//" Prencher com 0 - Não Preenchido, 1 - Sim, 2 - Não"
AADD(aListBox,STR0218); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N'),'012'") //"7008 - Entidade Imune/Isentade Contribuição Previdenciária"
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")                      
cMsg:=STR0056	//"Preencha com 0-Nao, 1-Sim"
AADD(aListBox,STR0224); AADD(aSel,.t.) ; AADD(aMsg,cMsg) ; AADD(aValid,"U_A975Valid('N'),'012'") //"7009 - PJ sujeita a contribuição previdenciaria
AADD(aListBox," "); AADD(aSel,.f.) ; AADD(aMsg,"") ; AADD(aValid,"")   

For i:=1 to Len(aListBox)
	aListBox[i]:=OemToAnsi(aListBox[i])
	aMsg[i]:=OemToAnsi(aMsg[i])
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Le informacoes do arquivo de configuracao DIPJ.CFP           	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
A975LoadIni("DIPJ.CFP")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa ListBox com opcoes para o array da configuracao          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlgGet TITLE OemtoAnsi(STR0141) FROM  180,110 TO 450,520 PIXEL OF oMainWnd //"DIPI"
@ 10, 20 SAY Oemtoansi(STR0142) SIZE 300, 07 OF oDlgGet PIXEL //"Itens de Configuracao"
@ 26, 18 TO 112, 188 LABEL "" OF oDlgGet PIXEL

@ 33,22 LISTBOX oListBox VAR cVar FIELDS HEADER "" ON DBLCLICK (A975GetList(oListBox)) SIZE 164,76 PIXEL

oListBox:SetArray(aListBox)
oListBox:bLine := { ||{aListBox[oListBox:nAt]}}

DEFINE SBUTTON FROM 115, 132 TYPE 1 ACTION (nOpca:=1,oDlgGet:End()) ENABLE OF oDlgGet
DEFINE SBUTTON FROM 115, 160 TYPE 2 ACTION (nOpca:=2,oDlgGet:End()) ENABLE OF oDlgGet
	
ACTIVATE MSDIALOG oDlgGet
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava itens no arquivo de configuracao DIPJ.CFP	          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOpcA==1
	A975GravaIt("DIPJ.CFP")
Else
	lRet	:=	.T.
Endif

Return(lRet)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975GetList ³Autor³ Juan Jose Pereira     ³ Data ³ 27.03.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ativa Get para edicao de Elemento relacionado ao ListBox    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³MATA975                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION A975GetList(oListBox)

Local oDlgGet2
Local nOpcaGet	:=	2
Local lUpdated	:=	.F.
Local bValid
Private cCampo	:=	"cCpoItem"

nAt	:=	oListBox:nAt

Private cValid	:=	"{||"+aValid[nAt]+"}"

If aSel[nAt]
	&cCampo	:=	aConteudo[nAt]
	bValid	:=	&(cValid)
	DEFINE MSDIALOG oDlgGet2 TITLE aMsg[nAt] FROM  300,100 TO 400,620 PIXEL OF oListBox
	@ 08, 20 TO 27, 237 LABEL "" OF oDlgGet2 PIXEL

	@ 15, 24 MSGET &cCampo PICTURE "@!" VALID Eval(bValid) SIZE 210, 08 OF oDlgGet2 PIXEL

	DEFINE SBUTTON FROM 032, 182 TYPE 1 ACTION (lUpdated:=.t.,oDlgGet2:End()) ENABLE OF oDlgGet2
	DEFINE SBUTTON FROM 032, 210 TYPE 2 ACTION (lUpdated:=.f.,oDlgGet2:End()) ENABLE OF oDlgGet2

	ACTIVATE MSDIALOG oDlgGet2
	If lUpdated
		aConteudo[nAt]	:=	StrTran(&cCampo,'"',"'")
	Endif
Endif

RETURN
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ A975GravaIt  ³ Autor ³ Juan Jose Pereira ³ Data ³ 27.07.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava arquivo de configuracao .CFP                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION A975GravaIt(ArqIni)

LOCAL cArqBkp
LOCAL aGravar	:=	{}
LOCAL i

cArqBkp	:=	StrTran(ArqIni,".CFP",".#CF")
If File(cArqBkp)
	Ferase(cArqBkp)
Endif
FRename(ArqIni,cArqBkp)
nHandle	:=	MSFCREATE(ArqIni)

For i	:=	1 to Len(aListBox)
	If IsDigit(Substr(aListBox[i],2,4))
		AADD(aGravar,"["+Substr(aListBox[i],2,4)+"]="+Rtrim(aConteudo[i])+Chr(13)+Chr(10))
	EndIf
Next
For i	:=	1 to Len(aGravar)
	FWrite(nHandle,aGravar[i],Len(aGravar[i]))
Next
FClose(nHandle)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975LoadIni ³Autor³     Marcos Simidu     ³ Data ³ 27.03.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Carrega conteudo do arquivo DIPJ.CFP 	                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³MATA975                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION A975LoadIni(ArqIni)

Local i	:=	0
Local cConteudo :=	""

If File(ArqIni)
	For i	:=	1 to Len(aListBox)
		cConteudo	:=	""
		If IsDigit(Substr(aListBox[i],2,4))
			cConteudo	:=	A975LeDIPI(Substr(aListBox[i],2,4))
			If Len(cConteudo)<254
				cConteudo	:=	cConteudo+Space(254-Len(cConteudo))
			EndIf
		Endif
		AADD(aConteudo,cConteudo)
	Next
Else
	For i:=1 to Len(aListBox)
		AADD(aConteudo,Space(254))
	Next
Endif

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ A975LeDIPI() ³ Autor ³ Juan Jose Pereira ³ Data ³ 27.07.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Le Arquivo DIPJ.CFP 	                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975LeDIPI(cCPO,lEnd)

Local cIni		:=	""
LOCAL cArqIni	:=	"DIPJ.CFP"
LOCAL cConteudo:=	""	
LOCAL	i:=0

lEnd	:=	If(lEnd==NIL,.F.,lEnd)
cCPO	:=	"["+cCPO+"]="

If !File(cArqIni)
	Help(" ",1,"DIPJ.CFP")
	lContinua:=	.f.
	lEnd		:=	.T.
	Return(cIni)
Else
	cConteudo	:=	MemoRead(cArqIni)
	nLinhas		:=	MlCount(cConteudo,254)
	For i:=1 to nLinhas
		cLinha	:=	AllTrim(MemoLine(cConteudo,254,i))
		If cCPO$cLinha
			cIni	:=	Substr(cLinha,8)
			Exit
		Endif
	Next
Endif

Return(cIni)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³  U_A975Valid() ³ Autor ³Andreia dos Santos ³ Data ³ 08.09.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida itens do ListBox.                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Function U_A975Valid(cTipo,cCampo)
Local lRet	:=.T.
LOCAL	cConteudo	:=	&(ReadVar())
Local n	:=	1

cConteudo	:=	Alltrim(cConteudo)
cCampo		:=	(If(cCampo==NIL," ",cCampo))
cTipo			:=	(If(cTipo==NIL," ",cTipo))

If cTipo=="N"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Avalia valores numericos                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For n:=1 To Len(cConteudo)
		If !Isdigit(Subs(cConteudo,n,1))
			lRet:=.F.
			Exit
		Endif
	Next
ElseIf cTipo=="D"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Retira "/" da Data   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cConteudo :=STRTRAN(cConteudo,"/","")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Avalia datas.                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	If Len(cConteudo)>10
	   lRet:=.f.
	Endif
endif

If cCampo=="SITUACAO"
	If !(cConteudo$"0123456").Or.Len(Alltrim(cConteudo))>1
		lRet:=.F.
	Endif
ElseIf cCampo=="EVENTO"
	If !(substr(cConteudo,1,2) <="31").and. !(substr(cConteudo,1,2) <="12");
													.Or.(Len(Alltrim(cConteudo))>4 .Or. Len(Alltrim(cConteudo))<4 .And. Len(Alltrim(cConteudo))<> 0)
		lRet:=.F.
	Endif
ElseIf cCampo=="TRIBUTACAO"
	If !(cConteudo$"1234567").Or.Len(Alltrim(cConteudo))>1
		lRet:=.F.
	Endif
ElseIf cCampo=="QUALIFICACAO"
	If !(cConteudo$"01234").Or.Len(Alltrim(cConteudo))>1
		lRet:=.F.
	Endif
ElseIf cCampo=="TIPO"
	If !(cConteudo$"00/01/02/03/04/05/06/07/08/09/10/11/99").Or.Len(Alltrim(cConteudo))>2;
																				.Or.Len(Alltrim(cConteudo))<2 
		lRet:=.F.
	Endif
ElseIf cCampo=="APURACAO"
	If cConteudo > "12" .Or.Len(Alltrim(cConteudo))>2 .OR. Len(Alltrim(cConteudo))<2
		lRet:=.F.
	Endif
ElseIf cCampo=="01"
	If !(cConteudo$"01").Or.Len(Alltrim(cConteudo))>1
		lRet:=.F.
	Endif
ElseIf cCampo=="DDD"
	If Len(Alltrim(cConteudo))>4
		lRet:=.F.
	Endif
ElseIf cCampo=="FONE"
	If Len(Alltrim(cConteudo))>9
		lRet:=.F.
	Endif
ElseIf cCampo=="CNAE"
	If Len(Alltrim(cConteudo))>7
		lRet:=.F.
	Endif
ElseIf cCampo=="ESTABELECIMENTO"
	If !(cConteudo$"01/02/03/04/05/10/11/12/13").Or.Len(Alltrim(cConteudo))>2;
																.Or.Len(Alltrim(cConteudo))<2 
		lRet:=.F.
	Endif
ElseIf cCampo=="0123"
	If !(cConteudo$"0123").Or.Len(Alltrim(cConteudo))>1
		lRet:=.F.
	Endif
ElseIf cCampo=="RECIBO"
	If Len(Alltrim(cConteudo))>12
		lRet:=.F.
	Endif
Endif

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³  R975Apura ³Autor³   Andreia dos Santos  ³ Data ³ 10.09.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cria Arquivo de trabalho com apuracoes de IPI               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975Apura(nMesIni,nMesFim)
Local aCampos	:=	{}
LOCAL	cArqTemp	
LOCAL	i,j,w
LOCAL	cMeses	:=	"ABCDEFGHIJKL"
LOCAL	cArqApur
LOCAL	cConteudo
LOCAL	cLinha
LOCAL cDesc
Local cCodigo
LOCAL	cValor
LOCAL	nValor
LOCAL aCodigos
LOCAL nDevVen := 0
LOCAL nDevCom := 0	
Local	nPos
Local	nApuracao
Local	nTpApur
Local	aOutrApur	:=	{}
Local	nPosX		:=	0
Local	nApurCfp
Local	lAchou	:=	.F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo para armazenar apuracoes   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aCampos,{"PERIODO"		,"C"	,02	,0	})
AADD(aCampos,{"_001"		,"N"	,14	,2	})
AADD(aCampos,{"_002"		,"N"	,14	,2	})
AADD(aCampos,{"_003"		,"N"	,14	,2	})
AADD(aCampos,{"_004"		,"N"	,14	,2	})
AADD(aCampos,{"_005"		,"N"	,14	,2	})
AADD(aCampos,{"_006"		,"N"	,14	,2	})
AADD(aCampos,{"_007"		,"N"	,14	,2	})
AADD(aCampos,{"_008"		,"N"	,14	,2	})
AADD(aCampos,{"_009"		,"N"	,14	,2	})
AADD(aCampos,{"_010"		,"N"	,14	,2	})
AADD(aCampos,{"_011"		,"N"	,14	,2	})
AADD(aCampos,{"_012"		,"N"	,14	,2	})
AADD(aCampos,{"_013"		,"N"	,14	,2	})
AADD(aCampos,{"_014"		,"N"	,14	,2	})
AADD(aCampos,{"_015"		,"N"	,14	,2	})
AADD(aCampos,{"_016"		,"N"	,14	,2	})
AADD(aCampos,{"_017"		,"N"	,14	,2	})
AADD(aCampos,{"MES"			,"C"	,02	,0	})
cArqTemp	:=	CriaTrab(aCampos)
dbUseArea(.T.,,cArqTemp,cArqTemp,.T.,.F.)
IndRegua(cArqTemp,cArqTemp,"MES+PERIODO",,,STR0083) //"Indexando apura‡”es"
//
nPos        := Ascan(aListBox,{|x| "0128"$x })	//Tipo de apuracao = 0-Decendial, 1-Quinzenal, 2-Mensal, 3-Semestral e 4-Anual
nApurCfp	:= Val (aConteudo[nPos])
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Estrutura do array aOutrApur:                                                              ³
//³1->Mes                                                                                     ³
//³2 em diante Arquivos de apuracao. Caso possua 1 eh Mensal, 2 eh Quinzenal e 3 eh Decendial.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//TRATO TANTO NORMAL E POR NCM
For i := nMesIni to nMesFim
	lAchou	:=	.F.
	//
	//Decendial por NCM
	cArqApur	:=	NmArqApur("IP", nAno, i, 1, 3,"*", .T.)		//Se for apuracao decendial
	If File (cArqApur)	
		aAdd (aOutrApur, {})
		nPos	:=	Len (aOutrApur)
		aAdd (aOutrApur[nPos], i)
		//
		cArqApur	:=	NmArqApur ("IP", nAno, i, 1, 1,"*", .T.)
		aAdd (aOutrApur[nPos], cArqApur)
		//
		cArqApur	:=	NmArqApur ("IP", nAno, i, 1, 2,"*", .T.)
		aAdd (aOutrApur[nPos], cArqApur)
		//
		cArqApur	:=	NmArqApur ("IP", nAno, i, 1, 3,"*", .T.)
		aAdd (aOutrApur[nPos], cArqApur)
		//
		lAchou	:=	.T.
	EndIf
	//
	//Decendial Normal
	If !(lAchou)	//Se nao Achou decendial por NCM
		cArqApur	:=	NmArqApur("IP", nAno, i, 1, 3,"*", .F.)		//Se for apuracao decendial
		If File (cArqApur)	
			aAdd (aOutrApur, {})
			nPos	:=	Len (aOutrApur)
			aAdd (aOutrApur[nPos], i)
			//
			cArqApur	:=	NmArqApur ("IP", nAno, i, 1, 1,"*", .F.)
			aAdd (aOutrApur[nPos], cArqApur)
			//
			cArqApur	:=	NmArqApur ("IP", nAno, i, 1, 2,"*", .F.)
			aAdd (aOutrApur[nPos], cArqApur)
			//
			cArqApur	:=	NmArqApur ("IP", nAno, i, 1, 3,"*", .F.)
			aAdd (aOutrApur[nPos], cArqApur)
			//
			lAchou	:=	.T.
		EndIf
	EndIf
	//
	//Quinzenal por NCM
	If !(lAchou)	//Se nao Achou decendial Normal ou Por Ncm
		cArqApur	:=	NmArqApur ("IP", nAno, i, 2, 2,"*", .T.)	//Se for Quinzenal
		If File (cArqApur)
			aAdd (aOutrApur, {})
			nPos	:=	Len (aOutrApur)
			aAdd (aOutrApur[nPos], i)
			//
			cArqApur	:=	NmArqApur("IP", nAno, i, 2, 1,"*", .T.)
			aAdd (aOutrApur[nPos], cArqApur)
			//
			cArqApur	:=	NmArqApur("IP", nAno, i, 2, 2,"*", .T.)
			aAdd (aOutrApur[nPos], cArqApur)
			//
			lAchou	:=	.T.
		EndIf
	EndIf
	//
	//Quinzenal Normal
	If !(lAchou)	//Se nao Achou decendial Normal ou Por Ncm, nem Quinzenal por NCM
		cArqApur	:=	NmArqApur ("IP", nAno, i, 2, 2,"*", .F.)	//Se for Quinzenal
		If File (cArqApur)
			aAdd (aOutrApur, {})
			nPos	:=	Len (aOutrApur)
			aAdd (aOutrApur[nPos], i)
			//
			cArqApur	:=	NmArqApur("IP", nAno, i, 2, 1,"*", .F.)
			aAdd (aOutrApur[nPos], cArqApur)
			//
			cArqApur	:=	NmArqApur("IP", nAno, i, 2, 2,"*", .F.)
			aAdd (aOutrApur[nPos], cArqApur)
			//
			lAchou	:=	.T.
		EndIf				
	EndIf
	//
	//Mensal por NCM
	If !(lAchou)	//Se nao Achou decendial Normal ou Por Ncm, nem Quinzenal por NCM ou Normal
		cArqApur	:=	NmArqApur ("IP", nAno, i, 3, 1,"*", .T.)	//Se for mensal
		If File (cArqApur)
			aAdd (aOutrApur, {})
			nPos	:=	Len (aOutrApur)
			aAdd (aOutrApur[nPos], i)
			//
			cArqApur	:=	NmArqApur("IP", nAno, i, 3, 1,"*", .T.)
			aAdd (aOutrApur[nPos], cArqApur)
		EndIf
	EndIf
	//
	//Mensal Normal
	If !(lAchou)	//Se nao Achou decendial Normal ou Por Ncm, nem Quinzenal por NCM ou Normal e nem Menal por NCM
		cArqApur	:=	NmArqApur ("IP", nAno, i, 3, 1,"*", .F.)	//Se for mensal
		If File (cArqApur)
			aAdd (aOutrApur, {})
			nPos	:=	Len (aOutrApur)
			aAdd (aOutrApur[nPos], i)
			//
			cArqApur	:=	NmArqApur("IP", nAno, i, 3, 1,"*", .F.)
			aAdd (aOutrApur[nPos], cArqApur)
		EndIf
	EndIf
Next (i)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Busca dados em arquivos de apuracao     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For i:=	nMesIni to nMesFim
	//
	If Interrupcao(@lEnd)
		Exit
	Endif
	//
	nPosX	:=	aScan (aOutrApur, {|x| x[1]==i})
	If nPosX==0
		nTpApur	:=	Iif (nApurCfp==2, 1, Iif (nApurCfp==1, 2, 3))
	Else
		nTpApur	:=	Len (aOutrApur[nPosX])-1
	EndIf
	//
	//Se tudo estiver ok ateh aqui inicio o processamento da apuracao.
	For j:=1 to nTpApur
		//Crio TRB Zerado
		RecLock(cArqTemp,.T.)
			MES	:=	StrZero (i, 2)
			//
			If (nTpApur==3)	//Decendial
				PERIODO	:=	StrZero (j, 2)
				nApuracao	:=	0
			ElseIf (nTpApur==2)	//Quinzenal
				PERIODO	:=	StrZero (j+3, 2)
				nApuracao	:=	1
			ElseIf (nTpApur==1)	//Mensal
				PERIODO	:=	"00"
				nApuracao	:=	2
			EndIf
		MsUnLock ()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta nome do arquivo do periodo        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (nPosX==0)
			Loop
		Else
			cArqApur	:=	aOutrApur[nPosX][j+1]
		EndIf
		//		
		//Inicio a atribuicao de valores no TRB zerado.
		(cArqTemp)->(dbSeek(StrZero(i,2)+Iif (nApuracao==2, "00", Iif (nApuracao==1, StrZero (j+3, 2), StrZero(j,2)))))
		RecLock(cArqTemp,.F.)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Carrega e Grava valores                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nDevCom	:= 0
		nDevVen	:= 0
		cConteudo:=	MemoRead(cArqApur)
		aCodigos	:=	{"001","002","003","004","005","006","007","008","009","010","011","012","013","014","015","016","017","018"}
		For w:=1 to MlCount(cConteudo,132)
			cLinha	:=	MemoLine(cConteudo,132,w)
			cDesc		:= substr(cLinha,5,20)
			cCodigo	:=	Trim(Substr(cLinha,1,3))
			if (cCodigo == "010" .and. upper(alltrim(cDesc))=="DEVOLUCOES DE COMPRA") .or.;
				(cCodigo == "004" .and. upper(alltrim(cDesc))=="DEVOLUCOES DE VENDA")
				cValor	:=	Trim(Substr(cLinha,52,18))
				cValor	:=	StrTran(cValor,".")
				cValor	:=	StrTran(cValor,",",".") 
				nValor	:=	Val(cValor)              
				if cCodigo =="010"
					nDevCom	:= nValor
				elseIf cCodigo =="004"	
					nDevVen	:= nValor
				endif
			EndIf	
			nPos		:=	Ascan(aCodigos,{|x|x==cCodigo})
			If nPos==0
				Loop
			Else
				aCodigos[nPos]:="..."
			Endif
			cValor	:=	Trim(Substr(cLinha,52,18))
			cValor	:=	StrTran(cValor,".")
			cValor	:=	StrTran(cValor,",",".")
			nValor	:=	Val(cValor)
			FieldPut(nPos+1,nValor)
		Next w
		(cArqTemp)->_010	-=nDevCom
		(cArqTemp)->_004	-=nDevVen
		MsUnlock()  
	Next j
Next i

Return(cArqTemp)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ A975CriaRem  ³Autor ³Andreia dos Santos    ³Data³ 13/08/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cria Arquivo de trabalho com dados do remetente    	     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975CriaRem()
Local aCampos
LOCAL cArqRem
LOCAL cIndA
LOCAL cIndB
LOCAL cIndC

aCampos:={}
AADD(aCampos,{"TIPO"		,	"C"	,	01	,	0	})
AADD(aCampos,{"CGC"			,	"C"	,	18	,	0	})
AADD(aCampos,{"CODIGO"		,	"C"	,	06	,	0	})
AADD(aCampos,{"LOJA"		,	"C"	,	02	,	0	})
AADD(aCampos,{"NOME"		,	"C"	,	50	,	0	})
AADD(aCampos,{"VALOR"		,	"N"	,	14	,	2	})
AADD(aCampos,{"AUXILIAR"	,	"C"	,	20	,	0	})

cArqRem	:=	CriaTrab(aCampos)
dbUseArea(.T.,,cArqRem,cArqRem,.F.,.F.)
cIndA	:=	Padr(cArqRem,7)+"A"
cIndB	:=	Padr(cArqRem,7)+"B"
cIndC	:=	Padr(cArqRem,7)+"C"
IndRegua(cArqRem,cIndA,"TIPO+CODIGO+LOJA",,,STR0086) //"Indexando remetentes..."
IndRegua(cArqRem,cIndB,"TIPO+AUXILIAR","D",,STR0086) //"Indexando remetentes..."
IndRegua(cArqRem,cIndC,"TIPO+CGC",,,STR0086) //"Indexando remetentes..."
dbClearIndex()
OrdListAdd(cIndA+OrdBagExt())
OrdListAdd(cIndB+OrdBagExt())
OrdListAdd(cIndC+OrdBagExt())
dbSetOrder(1)

Return(cArqRem)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ A975CriaMerc ³Autor ³Andreia dos Santos    ³Data³ 14/08/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cria Arquivo de trabalho com dados da Mercadoria           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975CriaMerc()
Local aCampos
LOCAL cArqMerc
LOCAL cIndA
LOCAL cIndB

aCampos:={}
AADD(aCampos,{"TIPO"		,	"C"	,	01	,	0	})
AADD(aCampos,{"NBM"			,	"C"	,	12	,	0	})
AADD(aCampos,{"EX"			,	"C"	,	03	,	0	})
AADD(aCampos,{"CODIGO"		,	"C"	,	15	,	0	})
AADD(aCampos,{"MERCAD"		,	"C"	,	55	,	0	})
AADD(aCampos,{"VALOR"		,	"N"	,	14	,	2	})
AADD(aCampos,{"AUXILIAR"	,	"C"	,	20	,	0	})
AADD(aCampos,{"CFO"  		,	"C"	,	05	,	0	})
AADD(aCampos,{"NOTA"		,	"C"	,	TamSX3("F2_DOC")[1]	, 0	})	// Numero da Nota
AADD(aCampos,{"SERIE"		,	"C"	,	03		,0	})	// Serie
AADD(aCampos,{"CLIFOR"		,	"C"	,	TamSX3("F3_CLIEFOR")[1]	,0	})	// Cod do Cliente/Fornecedor
AADD(aCampos,{"LOJA"		,	"C"	,	TamSX3("F3_LOJA")[1]	,0	})	// Loja
AADD(aCampos,{"CGC"	   		,	"C"	,	18	,	0	})
                                                
cArqMerc	:=	CriaTrab(aCampos)
dbUseArea(.T.,,cArqMerc,cArqMerc,.F.,.F.)
cIndA	:=	Padr(cArqMerc,7)+"D"
cIndB	:=	Padr(cArqMerc,7)+"E"
IndRegua(cArqMerc,cIndA,"TIPO+NBM+MERCAD",,,STR0087) //"Indexando Apuracoes..."
IndRegua(cArqMerc,cIndB,"TIPO+AUXILIAR",,,STR0087) //"Indexando Apuracoes..."

dbClearIndex()
OrdListAdd(cIndA+OrdBagExt())
OrdListAdd(cIndB+OrdBagExt())

dbSetOrder(1)

Return(cArqMerc)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ A975PrdAcum  ³Autor ³Mauro A. Goncalves    ³Data³ 22/06/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cria Arquivo com dados da Mercadoria Acumulado Produto     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975PrdAcum()
Local aCampos
LOCAL cPrdAcum
LOCAL cIndA
LOCAL cIndB
Local lMVQBPROD	:= GetNewPar("MV_QBPROD",.F.)

aCampos:={}
AADD(aCampos,{"TIPO"	  		,	"C"	,	01	,	0	})
AADD(aCampos,{"NBM"			,	"C"	,	12	,	0	})
AADD(aCampos,{"CODIGO"		,	"C"	,	15	,	0	})
AADD(aCampos,{"MERCAD"		,	"C"	,	55	,	0	})
AADD(aCampos,{"VALOR"		,	"N"	,	14	,	2	})
AADD(aCampos,{"CGC"	  		,	"C"	,	18	,	0	})
AADD(aCampos,{"EX"			,	"C"	,	03	,	0	})
AADD(aCampos,{"AUXILIAR"	,	"C"	,	20	,	0	})
                                                
cPrdAcum	:=	CriaTrab(aCampos)
dbUseArea(.T.,,cPrdAcum,cPrdAcum,.F.,.F.)
cIndA	:=	Padr(cPrdAcum,7)+"F"	//usado para acumular
cIndB	:=	Padr(cPrdAcum,7)+"G" 	//usado para gerar/imprimir por codigo ou descricao
IndRegua(cPrdAcum,cIndA,"TIPO+NBM+MERCAD",,,STR0087) //"Indexando Apuracoes..."
If lMVQBPROD
	IndRegua(cPrdAcum,cIndB,"TIPO+AUXILIAR+MERCAD","D",,STR0087) //"Indexando Apuracoes..."
Else	
	IndRegua(cPrdAcum,cIndB,"TIPO+AUXILIAR+NBM+CODIGO","D",,STR0087) //"Indexando Apuracoes..."
Endif
dbClearIndex()
OrdListAdd(cIndA+OrdBagExt())
OrdListAdd(cIndB+OrdBagExt())

dbSetOrder(1)

Return(cPrdAcum)         
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³  A975Grava   ³Autor ³     Marcos Simidu    ³Data³ 10/02/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava registro no arquivo texto.                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975Grava(cConteudo)

cConteudo += Chr(13)+Chr(10)

If !lEnd
	FWrite(nHandle,cConteudo,Len(cConteudo))
Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975HEADER   ³Autor ³ Andreia dos Santos  ³ Data ³ 30/08/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Grava registro Header da Declaracao                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975Header()
Local cRegistro

cRegistro   := A975Fill("DIPJ",04)
cRegistro   += a975Fill(SPACE(04),04)                         
cRegistro   += A975Fill(Str(2014,4),04)
cRegistro   += A975Fill(SPACE(362),362)
cRegistro 	:= a975Fill(cRegistro,374)
a975Grava(cRegistro)
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975R01      ³Autor ³ Andreia dos Santos  ³ Data ³ 30/08/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Grava Ficha 01 - Dados Iniciais - Tipo R01                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975R01()
Local 	cRegistro   := ""
Local 	cReg0158    := ""
Local	nPos 		:= 0
Local 	cSitEsp		:= ""
Local	cAno		:= ""
Local	cConteudo	:= ""
Local	cDecRet		:= ""	//Declaracao Retificadora
Local	cOptRefis	:= ""	//Optante pelo Refis
Local	cFormTrib	:= ""	//Forma de Tributacao
Local	cQualifPJ	:= ""	//Qualificacao da Pessoa Juridica
Local	cOperEx		:= ""	//Operacoes com o Exterior
Local   cDtEvent    := ""   //Data do Evento
nPos        := Ascan(aListBox,{|x| "0106"$x })
cDecRet		:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
nPos        := Ascan(aListBox,{|x| "0112"$x })
cOptRefis	:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
nPos		:= Ascan(aListBox,{|x| "0122"$x })
cFormTrib   := a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
If !cFormTrib$"1|4"
	lLucrReal:=.F.
Endif
nPos		:= Ascan(aListBox,{|x| "0123"$x })
cQualifPJ   := a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
nPos		:= Ascan(aListBox,{|x| "0132"$x })
cOperEx		:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
cRegistro   := a975Fill("R01",03)                          		// TIPO
cRegistro   += a975Fill(,01)	                          		// RESERVADO
cRegistro   += a975Fill("0000",04)                          	// RESERVADO
cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)     	// CNPJ da Matriz
	
// " 0105 - Ano Calendario "
nPos        := Ascan(aListBox,{|x| "0105"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
cAno        := a975Fill(aConteudo[nPos],1)

//" 0106 - Declaracao Retificadora"
cRegistro   += cDecRet

//" 0107 - Numero do Recibo da DIPJ a ser Retificada "
If cDecRet == "0"
	cRegistro	+= Replicate("0",12)
Else
	nPos		:= Ascan(aListBox,{|x| "0107"$x })
	cRegistro	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),12,0),12)
Endif

//" 0108 - Situacao Especial  "
nPos        := Ascan(aListBox,{|x| "0108"$x })
if cAno =="0"
	cRegistro   +="0"
Else
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
EndIf
cSitEsp := a975Fill(aConteudo[nPos],1)

//" 0109 - Data do Evento "
nPos        := Ascan(aListBox,{|x| "0109"$x })
cRegistro   += a975Fill( if(cSitEsp=="0","0000",aConteudo[nPos] ),04)
cDtEvent    := a975Fill(aConteudo[nPos],4)

//10. Inicio do Periodo ( DDMM )  VERIFICAR
cRegistro   += a975Fill("01"+strzero(nMesIni,2),04)

//11. Final do Periodo ( DDMM )   VERIFICAR
If !(cSitEsp == '0')
	cRegistro   += a975Fill(cDtEvent,04)
Else
	cRegistro   += a975Fill(substr(dtos(dDtFim),07,02)+substr(dTos(dDtFim),05,02),04)
EndIf	 

//" 0112 - Optante REFIS"
cRegistro	+= cOptRefis

//" 0142 - Optante pelo PAES"
nPos:=Ascan(aListBox,{|x| "0142"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 

//" 0122 - Forma de Tributacao"
cRegistro   += cFormTrib

//" 0123 - Qualificacao da Pessoa Juridica "
cRegistro   += cQualifPJ

//" 0124 - Apuracao do IRPJ e da CSLL (Apuracao da CSLL para Imunes ou Isentas)"
if cFormTrib $ "235"
	cRegistro += "2"      //Trimestral
elseif cFormTrib $ "89"
	cRegistro += "0"     //Desobrigada  
else
	nPos        := Ascan(aListBox,{|x| "0124"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
endif  

// "0158 - Indicar o trimestre que foi arbitrado quando a forma de de tributação igual a 5"
if cFormTrib $ "5"
	nPos:=Ascan(aListBox,{|x| "0158"$x })                       
	cReg0158 += a975Fill(aConteudo[npos],4)	
EndIf 

//" 0125 - Trimestres de Lucro Arbitrado"
if cFormTrib $ "35"
	nPos		:=	Ascan(aListBox,{|x| "0125"$x })
	if cFormTrib $ "3" .And. (Len(Alltrim(aConteudo[nPos])))==1
		aConteudo[nPos] := "1111"
		cRegistro   += a975Fill(aConteudo[npos],4)	
	ElseIf cFormTrib $ "5" .And. (Len(Alltrim(aConteudo[nPos])))==1
		aConteudo[nPos] := cReg0158
		cRegistro   += a975Fill(aConteudo[npos],4)	
	EndIf
Else
	nPos		:=	Ascan(aListBox,{|x| "0125"$x })
	aConteudo[nPos] :=If(Len(Alltrim(aConteudo[nPos]))==1,"0000",aConteudo[nPos])
	cRegistro   += a975Fill(aConteudo[npos],4)
EndIf

//" 0126 - Apuracao do IRPJ e da CSLL por Trimestre"      
cRegistro   += a975Fill("0000",04)                          	// RESERVADO

// " 0127 - Apuracao e Informacoes de IPI no Periodo"
nPos        := Ascan(aListBox,{|x| "0127"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)

//" 0130 - Administradora de Fundos e Clubes de Investimento"
nPos        := Ascan(aListBox,{|x| "0130"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)

//" 0131 - Ativos no Exterior"
nPos        := Ascan(aListBox,{|x| "0131"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)

//" 0113 - Part. Permanente Coligadas/Controladas"
nPos:=Ascan(aListBox,{|x| "0113"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 

//" 0114 - Com. Eletronico e Tec. Informacao"
nPos:=Ascan(aListBox,{|x| "0114"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 

//" 0115 - Royalties recebidos Brasil/Exterior"
nPos:=Ascan(aListBox,{|x| "0115"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 

//" 0116 - Royalties pagos a ben. Brasil/Exterior"
nPos:=Ascan(aListBox,{|x| "0116"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 

//" 0117 - Rend. de servicos, juros e dividendos a ben. Brasil/Exterior"
nPos:=Ascan(aListBox,{|x| "0117"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 

//" 0118 - Pagtos/remes. a tit. de servicos, juros e dividendos a ben. Brasil/Exterior"
nPos:=Ascan(aListBox,{|x| "0118"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 

//" 0149 - Inovacao Tecnologia e Desenvolvimento Tecnologico"
If cFormTrib $ "67"
	cRegistro += "0"
Else
	nPos:=Ascan(aListBox,{|x| "0149"$x })
	cRegistro += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
Endif

//" 0150 - Capacitacao de Informatica e Inclusao Digital"
nPos 		:= Ascan(aListBox,{|x| "0150"$x })
cConteudo	:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
If cConteudo == "1" .And. cOperEx == "1"
	cRegistro += "1"
Else
	cRegistro += "0"
Endif

//" 0151 - PJ Habilitada no Repes ou Recap"
If cFormTrib $ "67" .Or. (cFormTrib $ "25" .And. cOptRefis == "0" )
	cRegistro += "0"
Else
	nPos:=Ascan(aListBox,{|x| "0151"$x })
	cRegistro += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
Endif

//" 0152 - Polo Industrial de Manaus e Amazonia Ocidental"
If !(cFormTrib $ "1489")
	cRegistro += "0"
Else
	nPos:=Ascan(aListBox,{|x| "0152"$x })
	cRegistro += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
Endif

//" 0132 - Operacoes com o Exterior"
If cFormTrib $ "67"
	cRegistro += "0"
Else
	cRegistro += cOperEx
Endif

//" 0133 - Oper.c/pessoa vinculada/Interposta Pessoa/..."
nPos		:= Ascan(aListBox,{|x| "0133"$x })
cConteudo	:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
If cConteudo == "1" .And. cOperEx == "1"
	cRegistro += "1"
Else
	cRegistro += "0"
Endif

//" 0165 - Opcao pela Aplicação das Regras de Preços de Transferência Prevista no Artigo 52 da Lei nº 12.715/2012
nPos			:= Ascan(aListBox,{|x| "0165"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)                                   

//" 0134 - Participacoes no Exterior"
If cFormTrib $ "67" .Or. (cFormTrib $ "25" .And. cOptRefis == "0" )
	cRegistro += "0"
Else
	nPos		:= Ascan(aListBox,{|x| "0134"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
Endif

//" 0153 - Doacoes a Campanhas Eleitorais"
If !(cFormTrib $ "1489")
	cRegistro += "0"
Else
	nPos		:= Ascan(aListBox,{|x| "0153"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
Endif

//" 0136 - Lucro da Exploracao"
If !(cFormTrib $ "1489")
	cRegistro   += a975Fill("0",01)                          	// RESERVADO
Else
	nPos 		:= Ascan(aListBox,{|x| "0136"$x })
	cConteudo	:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
	If cConteudo == "1" .And. cQualifPJ =="1" .And. cFormTrib $ "1489"
		cRegistro += "1"
	Else
		cRegistro += "0"
	Endif
EndIf

//" 0137 - Isencao e Reducao do Imposto"
nPos		:= Ascan(aListBox,{|x| "0137"$x })
cConteudo	:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
If cConteudo == "1" .And. cOptRefis == "1" .And. cFormTrib $ "25" .And. cQualifPJ == "1"
	cRegistro += "1"
Else
	cRegistro += "0"
Endif

//" 0138 - Atividade Rural"
If !(cFormTrib $ "1489")
	cRegistro   += a975Fill("0",01)                          	// RESERVADO
Else
	nPos 		:= Ascan(aListBox,{|x| "0138"$x })
	cConteudo	:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
	If cConteudo == "1" .And. cQualifPJ =="1" .And. cFormTrib $ "1489" 
		cRegistro 	+= "1"
	else
		cRegistro 	+= "0"
	Endif
EndIf
//" 0148 - FINOR/FINAM/FUNRES"
If !(cFormTrib $ "1489")
	cRegistro 	+= "0"
Else
	nPos		:= Ascan(aListBox,{|x| "0148"$x })
	cRegistro	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
Endif

//" 0154 - PJ Comercial Exportadora"
nPos		:= Ascan(aListBox,{|x| "0154"$x })
cConteudo	:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
If cConteudo == "1" 
	cRegistro += "1"
Else
	cRegistro += "0"
Endif

//" 0155 - PJ Efetuou Vendas a Empresa Comercial Exportadora"
If (cFormTrib $ "67")
	cRegistro 	+= "0"
elseif !(cQualifPJ $ "1")
	cRegistro 	+= "0"
Else
	nPos		:= Ascan(aListBox,{|x| "0155"$x })
	cConteudo	:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
	If cConteudo == "1"
		cRegistro += "1"
	Else
		cRegistro += "0"
	Endif
EndIf

//" 0159 - Participacoes em consorcios de empresas
nPos		:= Ascan(aListBox,{|x| "0159"$x })
cConteudo	:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
If cConteudo == "1" 
	cRegistro += "1"
Else
	cRegistro += "0"
Endif

//" 0160 - Rend receb do exterior ou de nao residentes
nPos		:= Ascan(aListBox,{|x| "0160"$x })
cConteudo	:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
If cConteudo == "1" 
	cRegistro += "1"
Else
	cRegistro += "0"
Endif

//" 0161 - Pagamentos ao exterior ou a nao residentes
nPos		:= Ascan(aListBox,{|x| "0161"$x })
cConteudo	:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
If cConteudo == "1" 
	cRegistro += "1"
Else
	cRegistro += "0"
Endif              

//" 0162 - Zonas de processamento de exportacao
nPos		:= Ascan(aListBox,{|x| "0162"$x })
cConteudo	:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
If cConteudo == "1" 
	cRegistro += "1"
Else
	cRegistro += "0"
Endif

//" 0163 - Areas de livro comercio
If !(cFormTrib $ "67")
	cRegistro 	+= "0"
Else
	nPos		:= Ascan(aListBox,{|x| "0163"$x })
	cConteudo	:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
	If cConteudo == "1"
		cRegistro += "1"
	Else
		cRegistro += "0"
	Endif
EndIf

//" 0139 - Tipo de Entidade "                  
nPos:=Ascan(aListBox,{|x| "0139"$x })
if !(cFormTrib $ "67")
	cRegistro += "00"
else
	cRegistro += a975Fill(aConteudo[nPos],02)
Endif

//" 0140 - Desenquadramento"
nPos:=Ascan(aListBox,{|x| "0140"$x })                       
if !(cFormTrib $ "67")
	cRegistro += "0"
else
	cRegistro += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
Endif

//" 0141 - Data do Desenquadramento"
nPos        := Ascan(aListBox,{|x| "0141"$x })
if substr(cRegistro,len(cRegistro),1) =="0"
	cRegistro 	+="00000000"
else
	cRegistro	+= a975Fill(STRTRAN(aConteudo[nPos],"/",""),08)
endif

//" 0156 - Valor Total da Receita de Vendas da PJ"
//nPos		:= Ascan(aListBox,{|x| "0156"$x })
cRegistro	 	+= "00000000000000"

// 0156 - PJ Sujeita a Aliquota da CSLL 15%
nPos:=Ascan(aListBox,{|x| "0156"$x })                       
cRegistro += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 

// 0157 - Optante pelo RTT
//nPos:=Ascan(aListBox,{|x| "0157"$x })                       
//cRegistro += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 

//0164 - Forma de Escrituração
nPos:=Ascan(aListBox,{|x| "0164"$x })                       
cRegistro += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 

cRegistro   	+= a975Fill(Space (10), 10)	// Filler
cRegistro 		:= a975Fill( cRegistro, 128)

a975Grava(cRegistro)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975R02      ³Autor ³ Andreia dos Santos  ³ Data ³ 31/08/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ficha 02 - Dados Cadastrais - Tipo R02                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975R02()

Local cRegistro
Local cFaxAux	:=	SM0->M0_FAX
Local cFax		:=	""
Local n			:=	1
Local cTelAux 	:=	SM0->M0_TEL
Local cTel		:=	""
Local nPos 		:= 0
Local nVirgula	:= Rat(",",SM0->M0_ENDENT)
Local cNumero 	:= AllTrim(SubStr(SM0->M0_ENDENT,nVirgula+1))
Local nNumero 	:= Val(AllTrim(cNumero))
Local cEnderec	:= PadR(If(nNumero!=0,SubStr(SM0->M0_ENDENT,1,nVirgula-1),SM0->M0_ENDENT),34)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quando nao ha virgula no endereco procura-se o caracter branco³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ( nVirgula == 0 )
	nVirgula := Rat(" ",AllTrim(SM0->M0_ENDENT))
	cNumero 	:= AllTrim(SubStr(SM0->M0_ENDENT,nVirgula+1))
	nNumero 	:= Val(AllTrim(cNumero))
	cEnderec	:= PadR(If(nNumero!=0,SubStr(SM0->M0_ENDENT,1,nVirgula-1),SM0->M0_ENDENT),34)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retira caracteres do campo cFax                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For n:=1 To Len(cFaxAux)
	If IsDigit(Subs(cFaxAux,n,1))
		cFax+=Subs(cFaxAux,n,1)
	Endif
Next
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retira caracteres do campo cTel                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For n:=1 To Len(cTelAux)
	If IsDigit(Subs(cTelAux,n,1))
		cTel+=Subs(cTelAux,n,1)
	Endif
Next

cRegistro   := a975Fill("R02",03)                           	// Tipo
cRegistro   += a975Fill(,01)		                          	// Reservado
cRegistro   += a975Fill("0000",04)                          	// Reservado
cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)     	// CNPJ da Matriz

	//" 0105 - Ano Calendario "
nPos        := Ascan(aListBox,{|x| "0105"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
	//" 0106 - Declaracao Retificadora"
nPos        := Ascan(aListBox,{|x| "0106"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
cRegistro   += a975Fill(SM0->M0_NOMECOM,150)                //06. Nome Empresarial
cRegistro   += a975Fill(SM0->M0_NATJUR,04)                  //07. Codigo da Natureza Juridica - Obrigatorio
	//08. CNAE-2.1 - Obrigatorio 
cRegistro	+= a975Fill(SM0->M0_CNAE,07)                        
	//" 0224 - Informe o Tipo de Logradouro - 01=Aeroporto, 02-Alameda, etc..."
nPos        := Ascan(aListBox,{|x| "0224"$x })
cRegistro   += a975Fill(If(!Empty(aConteudo[nPos]),aConteudo[nPos],""), 02)
cRegistro   += a975Fill(cEnderec,150)                        //09. Logradouro
cRegistro   += a975Fill(A975Num2Chr(nNumero,6,0),06)        //10. Numero
cRegistro   += a975Fill(SM0->M0_COMPENT,50)                 //11. Complemento
cRegistro   += a975Fill(SM0->M0_BAIRENT,50)                 //12. Bairro
cRegistro   += a975Fill(SM0->M0_ESTENT,02)                  //14. UF
cRegistro   += a975Fill(cCodMun,04)  		                // Codigo de Municipio
cRegistro   += a975Fill(A975Num2Chr(Val(SM0->M0_CEPENT),8,0),08)     //15. CEP
	//" 0216 - DDD Telefone "
nPos        := Ascan(aListBox,{|x| "0216"$x })
cRegistro   += a975Fill(If(!Empty(aConteudo[nPos]),A975Num2Chr(Val(aConteudo[nPos]),4,0),""),04)
	//" 0217 - Telefone "
nPos        := Ascan(aListBox,{|x| "0217"$x })
cRegistro   += a975Fill(If(!Empty(aConteudo[nPos]),A975Num2Chr(Val(aConteudo[nPos]),9,0),""),09)
	//" 0218 - DDD do Fax "
nPos        := Ascan(aListBox,{|x| "0218"$x })
cRegistro   += a975Fill(If(!Empty(aConteudo[nPos]),A975Num2Chr(Val(aConteudo[nPos]),4,0),""),04)
	//" 0219 - Fax "
nPos        := Ascan(aListBox,{|x| "0219"$x })
cRegistro   += a975Fill(If(!Empty(aConteudo[nPos]),A975Num2Chr(Val(aConteudo[nPos]),9,0),""),09)
	//" 0220 - Caixa Postal "
nPos        := Ascan(aListBox,{|x| "0220"$x })
cRegistro   += a975Fill(If(!Empty(aConteudo[nPos]),A975Num2Chr(Val(aConteudo[nPos]),6,0),""),06)
	//" 0221 - UF da Caixa Postal "    
nPos        := Ascan(aListBox,{|x| "0221"$x })
cRegistro   += a975Fill(aConteudo[nPOs],02)
	//" 0222 - CEP da Caixa Postal "
nPos        := Ascan(aListBox,{|x| "0222"$x })
cRegistro   += a975Fill(If(!Empty(aConteudo[nPos]),A975Num2Chr(Val(aConteudo[nPos]),8,0),""),08)
	//" 0223 - Correio Eletronico "
nPos        := Ascan(aListBox,{|x| "0223"$x })
cRegistro   += a975Fill(Lower(aConteudo[nPos]),115)
cRegistro   += a975Fill(,10)                                // Filler

cRegistro := a975Fill( cRegistro,624)

a975Grava(cRegistro)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975R03      ³Autor ³ Andreia dos Santos  ³ Data ³ 15/09/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ficha 03 - Dados do Representante TIPO R03                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975R03()
Local cRegistro

cRegistro   := a975Fill("R03",03)                           // Tipo
cRegistro   += a975Fill(,01)		                          // Reservado
cRegistro   += a975Fill("0000",04)                          // Reservado
cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)     // CNPJ da Matriz
	//" 0105 - Ano Calendario "
nPos        := Ascan(aListBox,{|x| "0105"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
	//" 0106 - Declaracao Retificadora"
nPos        := Ascan(aListBox,{|x| "0106"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
	//" 0306 - Nome do Representante"
nPos        := Ascan(aListBox,{|x| "0306"$x })
cRegistro   += a975Fill(aConteudo[nPos],150)
	//" 0307 - CPF do Representante"
nPos        := Ascan(aListBox,{|x| "0307"$x })
cRegistro   += a975Fill(A975Digit(aConteudo[nPos]),11)
	//" 0308 - DDD do Representante "
nPos        := Ascan(aListBox,{|x| "0308"$x })
cRegistro   += a975Fill(aConteudo[nPos],04)
	//" 0309 - Telefone do Representante "
nPos        := Ascan(aListBox,{|x| "0309"$x })
cRegistro   += a975Fill(aConteudo[nPos],09)
	//" 0310 - Ramal "
nPos        := Ascan(aListBox,{|x| "0310"$x })
cRegistro   += a975Fill(aConteudo[nPos],05)
	//" 0311 - DDD do Fax do Representante "
nPos        := Ascan(aListBox,{|x| "0311"$x })
cRegistro   += a975Fill(aConteudo[nPos],04)
	//" 0312 - Fax do Representante "
nPos        := Ascan(aListBox,{|x| "0312"$x })
cRegistro   += a975Fill(aConteudo[nPos],09)
	//" 0313 - Correio Eletronico do Representante "
nPos        := Ascan(aListBox,{|x| "0313"$x })
cRegistro   += a975Fill(Lower(aConteudo[nPos]),115)
	//" 0314 - Nome do Responsavel "
nPos        := Ascan(aListBox,{|x| "0314"$x })
cRegistro   += a975Fill(aConteudo[nPos],150)
	//" 0315 - CPF do Responsavel "
nPos        := Ascan(aListBox,{|x| "0315"$x })
cRegistro   += a975Fill(A975Digit(aConteudo[nPos]),11)
	//" 0316 - CRC do Responsavel "
nPos        := Ascan(aListBox,{|x| "0316"$x })
cRegistro   += a975Fill(aConteudo[nPos],15)
	//" 0317 - UF do Responsavel "
nPos        := Ascan(aListBox,{|x| "0317"$x })
cRegistro   += a975Fill(aConteudo[nPos],02)
	//" 0318 - DDD do Responsavel "
nPos        := Ascan(aListBox,{|x| "0318"$x })
cRegistro   += a975Fill(aConteudo[nPos],04)
	//" 0319 - Tel. Responsavel "
nPos        := Ascan(aListBox,{|x| "0319"$x })
cRegistro   += a975Fill(aConteudo[nPos],09)
	//" 0320 - Ramal "
nPos        := Ascan(aListBox,{|x| "0320"$x })
cRegistro   += a975Fill(aConteudo[nPos],05)
	//" 0321 - DDD do Fax do Responsavel "
nPos        := Ascan(aListBox,{|x| "0321"$x })
cRegistro   += a975Fill(aConteudo[nPos],04)
	//" 0322 - Fax do Responsavel "
nPos        := Ascan(aListBox,{|x| "0322"$x })
cRegistro   += a975Fill(aConteudo[nPos],09)
	//" 0323 - Correio Eletronico do Responsavel "
nPos        := Ascan(aListBox,{|x| "0323"$x })
cRegistro   += a975Fill(Lower(aConteudo[nPos]),115)
cRegistro	:= a975Fill(cRegistro,665)
a975Grava(cRegistro)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R06A  ºAutor  ³Natalia Antonucci   º Data ³  05/08/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Demonstração do Resultado - Com Atividade Rural - PJ       º±±
±±º          ³ em Geral                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R06A(aEmpresa) 

Local cFil06A 	:= FWCodFil()
Local nPos 		:= 0
Local cRegistro   
Local aFicha06A	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg06A 	:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
    cFilAnt := aEmpresa[nX][3]
	aFicha06A := GetSldPlGer(mv_par10, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
    If lFirst     
    	aReg06A := aClone(aFicha06A)
        lFirst  := .F.
    Else    
		For nY:= 1 To Len(aFicha06A) 
	    	If  nCont <= 73
	    		AReg06A[nY][4] += aFicha06A[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next nY    
    EndIf
Next nX

If len(AReg06A) > 0
	cRegistro   := a975Fill("R06A",03) // Tipo
	cRegistro   += a975Fill("A",01) // Reservado
	nPos        := Ascan(aListBox,{|x| "0603"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos        := Ascan(aListBox,{|x| "0604"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos        := Ascan(aListBox,{|x| "0105"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos        := Ascan(aListBox,{|x| "0106"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[1][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[2][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[3][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[4][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[5][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[6][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[7][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[8][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[9][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[10][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[11][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[12][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[13][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[14][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[15][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[16][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[17][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[18][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[19][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[20][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[21][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[22][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[23][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[24][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[25][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[26][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[27][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[28][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[29][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[30][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[31][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[32][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[33][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[34][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[35][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[36][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[37][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[38][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[39][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[40][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[41][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[42][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[43][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[44][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[45][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[46][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[47][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[48][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[49][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[50][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[51][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[52][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[53][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[54][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[55][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[56][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[57][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[58][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[59][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[60][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[61][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[62][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[63][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[64][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[65][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[66][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[67][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[68][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[69][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[70][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[71][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[72][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[73][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[74][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[75][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[76][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[77][4],14),14) 
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[78][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[79][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[80][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[81][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg06A[82][4],14),14)
	cRegistro   += a975Fill(,10) 	 	
	cRegistro 	:= a975Fill( cRegistro,1182) 
	a975Grava(cRegistro)	
Endif                                     

cFilAnt := cFil06A	

Return()  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R07A  ºAutor  ³Natalia Antonucci   º Data ³  05/08/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Demonstração dos Resultado - Criterios em 31.12.2007       º±±
±±º          ³ Com Atividade Rural - PJ em Geral                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R07A(aEmpresa)

Local cFil07A 	:= FWCodFil()
Local nPos 		:= 0
Local cRegistro   
Local aFicha07A	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg07A 	:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
    cFilAnt := aEmpresa[nX][3]
	aFicha07A := GetSldPlGer(mv_par11, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
    If lFirst     
    	aReg07A := aClone(aFicha07A)
        lFirst  := .F.
    Else    
		For nY:= 1 To Len(aFicha07A) 
	    	If  nCont <= 73
	    		AReg07A[nY][4] += aFicha07A[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next nY    
    EndIf
Next nX

If len(AReg07A) > 0
	cRegistro   := a975Fill("R07A",03) // Tipo
	cRegistro   += a975Fill("A",01) // Reservado
	nPos        := Ascan(aListBox,{|x| "0703"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0703 - Trimestre
	nPos        := Ascan(aListBox,{|x| "0704"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0704 - Coluna
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos        := Ascan(aListBox,{|x| "0105"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos        := Ascan(aListBox,{|x| "0106"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[1][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[2][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[3][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[4][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[5][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[6][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[7][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[8][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[9][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[10][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[11][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[12][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[13][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[14][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[15][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[16][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[17][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[18][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[19][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[20][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[21][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[22][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[23][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[24][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[25][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[26][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[27][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[28][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[29][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[30][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[31][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[32][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[33][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[34][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[35][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[36][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[37][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[38][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[39][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[40][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[41][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[42][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[43][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[44][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[45][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[46][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[47][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[48][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[49][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[50][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[51][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[52][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[53][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[54][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[55][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[56][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[57][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[58][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[59][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[60][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[61][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[62][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[63][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[64][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[65][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[66][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[67][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[68][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[69][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[70][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[71][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[72][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[73][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[74][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[75][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[76][4],14),14) 
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[77][4],14),14)  
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[78][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[79][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[80][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[81][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg07A[82][4],14),14)
	cRegistro   += a975Fill(,10) 	 	//Filler
	cRegistro 	:= a975Fill(cRegistro,1182)	
	a975Grava(cRegistro)
Endif                                     

cFilAnt := cFil07A	

Return()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975R19      ³Autor ³ Andreia dos Santos  ³ Data ³ 31/08/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ficha 19-Estabelecimentos Industriais ou Equiparados-Tipo 19³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975R19(nReg19)

Local cRegistro
Local nPos :=0
Local dData

cRegistro   := a975Fill("R19",03)                                                                     	// Tipo
cRegistro   += a975Fill(,01)                          													// Reservado
cRegistro   += a975Fill(strzero(nReg19,4),04)                                                        	// Sequencial de Registro de Estabelecimento
cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),  14)                                           	// CNPJ do Contribuinte
nPos        := Ascan(aListBox,{|x| "0105"$x })	                                                  		//" 0105 - Ano Calendario "
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)  	
nPos        := Ascan(aListBox,{|x| "0106"$x })															//" 0106 - Declaracao Retificadora"
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
cRegistro   += a975Fill(substr(cCGC1,09,06),06)                                                    		//" 0107 - CNPJ do Estabelecimento"
cRegistro   += a975Fill(SM0->M0_TPESTAB,02)          	                                              	//" 0108 - Tipo de Estabelecimento"
cRegistro   += a975Fill(SuperGetMv("MV_ST"),01)															//" 0109 - Regime Especial de ST"
cRegistro   += a975Fill("1",01)   						                                              	//" 0110 - Escrituracao por Processamento de Dados"
cRegistro   += a975Fill("01"+strzero(nMesIni,2),04)                                                 	//" 0111 - Periodo de Atividade - Data Inicial"
cRegistro   += a975Fill(substr(dtos(dDtFim),07,02)+substr(dTos(dDtFim),05,02),04)                 	//" 0112 - Periodo de Atividade - Data Final"
cRegistro   += a975Fill(Space (10),10)
cRegistro   := a975Fill( cRegistro,52)
a975Grava(cRegistro)

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975R20      ³Autor ³ Andreia dos Santos  ³ Data ³ 31/08/99 ³±±
±±³Alteração			   ³Autor ³ Bruno Matos		    ³ Data ³ 07/02/14 ³±± 		
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ficha 20-Apuracao de Saldo do IPI - Tipo R20                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975R20(lFirst20,aApurAcm,lAglFil)

Local cRegistro
Local nTotDebito :=0
Local nTotCredito:=0
Local nMultiplic
Local nY			:=0 
Local nDebApur  	:=0
local nCredApur 	:=0

If lAglFil 

	If lFirst20		
			
		DbSelectArea(cArqTemp)
		DbGotop()
		While !Eof()  
		
		   IIF(Empty(aApurAcm[Val(MES)][1]).And. !Empty(_004),(aApurAcm[Val(MES)][1]:= _004),)/*aApurAcm[Val(MES)][1]= _004)		//004 Estorno de debitos    */                                   
		   IIF(Empty(aApurAcm[Val(MES)][2]).And. !Empty(_005),(aApurAcm[Val(MES)][2]:= _005),)/*aApurAcm[Val(MES)][2]+= _005) 	//005 Outros creditos   */
		   IIF(Empty(aApurAcm[Val(MES)][3]).And. !Empty(_006),(aApurAcm[Val(MES)][3]:= _006),)/*/*aApurAcm[Val(MES)][3]+= _006)  	//Credito*/
		   IIF(Empty(aApurAcm[Val(MES)][4]).And. !Empty(_007),(aApurAcm[Val(MES)][4]:= _007),)/*/*aApurAcm[Val(MES)][4]+= _007)  	//Saldo Credor de Periodo Anterior*/
		   IIF(Empty(aApurAcm[Val(MES)][5]).And. !Empty(_010),(aApurAcm[Val(MES)][5]:= _010),)/*/*aApurAcm[Val(MES)][5]+= _010)	//Estorno de Creditos*/
		   IIF(Empty(aApurAcm[Val(MES)][6]).And. !Empty(_011),(aApurAcm[Val(MES)][6]:= _011),)/*/*aApurAcm[Val(MES)][6]+= _011)	//Ressarcimento de Creditos*/
		   IIF(Empty(aApurAcm[Val(MES)][7]).And. !Empty(_012),(aApurAcm[Val(MES)][7]:= _012),)/*/*aApurAcm[Val(MES)][7]+= _012) 	//Outros Debitos*/
		   IIF(Empty(aApurAcm[Val(MES)][8]).And. !Empty(_013),(aApurAcm[Val(MES)][8]:= _013),)/*/*aApurAcm[Val(MES)][8]+= _013)	//Debito*/
		   IIF(Empty(aApurAcm[Val(MES)][9]).And. !Empty(_016),(aApurAcm[Val(MES)][9]:= _016),)/*/*aApurAcm[Val(MES)][9]+= _016)   	//Saldo devedor */
		   IIF(Empty(aApurAcm[Val(MES)][10]).And. !Empty(_017),(aApurAcm[Val(MES)][10]:=_017),)/*/*aApurAcm[Val(MES)][10]+= _017) 	//Saldo credor   */     
		   aApurAcm[Val(MES)][11]:= PERIODO   
		   
		DbSkip()
		EndDo                                  
	Else
		For nY:= 1 to MV_PAR02 
		
			
		    Iif(Empty(aApurAcm[nY][1]),aApurAcm[nY][1]:= 0.00,) 
		    Iif(Empty(aApurAcm[nY][2]),aApurAcm[nY][2]:= 0.00,) 
		    Iif(Empty(aApurAcm[nY][3]),aApurAcm[nY][3]:= 0.00,) 
		    Iif(Empty(aApurAcm[nY][4]),aApurAcm[nY][4]:= 0.00,) 
		    Iif(Empty(aApurAcm[nY][5]),aApurAcm[nY][5]:= 0.00,) 
		    Iif(Empty(aApurAcm[nY][6]),aApurAcm[nY][6]:= 0.00,) 
		    Iif(Empty(aApurAcm[nY][7]),aApurAcm[nY][7]:= 0.00,) 
		    Iif(Empty(aApurAcm[nY][8]),aApurAcm[nY][8]:= 0.00,) 
		    Iif(Empty(aApurAcm[nY][9]),aApurAcm[nY][9]:= 0.00,) 
		    Iif(Empty(aApurAcm[nY][10]),aApurAcm[nY][10]:= 0.00,)    
		    
		 	cRegistro   := a975Fill("R20",03)								// Tipo
			cRegistro   += a975Fill(Space (01),01)							// Reservado
			cRegistro   += a975Fill(Strzero(nY,2),02)						// Mes ( MM )
			cRegistro   += a975Fill(aApurAcm[nY][11],02)					// Periodo
			cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)       	// CNPJ da Matriz
			// " 0105 - Ano Calendario "
			nPos        := Ascan(aListBox,{|x| "0105"$x })
			cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
			// " 0106 - Declaracao Retificadora"
			nPos        := Ascan(aListBox,{|x| "0106"$x })
			cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
		
			cRegistro   += a975Fill(substr(cCGC1,09,06),06)                 // CNPJ do Estabelecimento
		
		/// aqui comeca a parte de valores.
		    nDebApur	:=  Iif(aApurAcm[nY][8]==Nil,0,aApurAcm[nY][8])
		    nCredApur	:= Iif(aApurAcm[nY][3]==Nil,0,aApurAcm[nY][3])  
			If (nDebApur + nCredApur) > 0 //aApurAcm[nY][8] + cValToChar(aApurAcm[nY][3]) > 0	//Debito + Credito > 0 indica q ha movimento no periodo.
				cRegistro   += a975Fill("1", 1)
		   	Else
				cRegistro   += a975Fill("2", 1)
			EndIf
	
			cRegistro   += a975Fill(A975Num2Chr(aApurAcm[nY][4],14,2),14)    // Saldo Credor de Periodo Anterior
			cRegistro   += a975Fill(A975Num2Chr(aApurAcm[nY][8],14,2),14)    // Debito
		    cRegistro   += a975Fill(A975Num2Chr(aApurAcm[nY][3],14,2),14)    // Credito
		
			nMultiplic:= If(aApurAcm[nY][10]>aApurAcm[nY][9],-1,1)        // Saldo Apurado
			cRegistro   += a975Fill(A975Num2Chr(((Max(aApurAcm[nY][10],aApurAcm[nY][9]))*nMultiplic),14,2),14)
		
			//Credito/Debito
			If (aApurAcm[nY][3]+aApurAcm[nY][4])-aApurAcm[nY][8]>0    // (Credito+Credito Periodo Anterior)-Debito
				cRegistro   += 		"1"
			ElseIf (aApurAcm[nY][3]+aApurAcm[nY][4])-aApurAcm[nY][8]==0
				cRegistro   += 		"0"
			Else
				cRegistro   += 		"2"
			EndIf
		
			cRegistro   += a975Fill(Space (10),10)                                   // Filler
				
			cRegistro   := a975Fill( cRegistro,98)
			A975Grava(cRegistro)
		
			nEstDeb 	+= aApurAcm[nY][1]	//estorno de Debitos
			nOutrCred 	+= aApurAcm[nY][2]	//Outros Creditos
			nEstCred 	+= aApurAcm[nY][5]	//Estorno de Creditos
			nRessCred	+= aApurAcm[nY][6]	//Ressarcimento de Creditos
			nOutrDeb	+= aApurAcm[nY][7]	//Outros Debitos
	    Next nY    
	EndIF 
Else        

dbSelectArea(cArqTemp)
dbGotop()
While !Eof()
	
	cRegistro   := a975Fill("R20",03)								// Tipo
	cRegistro   += a975Fill(Space (01),01)							// Reservado
	cRegistro   += a975Fill(MES,02)									// Mes ( MM )
	cRegistro   += a975Fill(PERIODO,02)								// Periodo
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)       	// CNPJ da Matriz
		// " 0105 - Ano Calendario "
	nPos        := Ascan(aListBox,{|x| "0105"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
		// " 0106 - Declaracao Retificadora"
	nPos        := Ascan(aListBox,{|x| "0106"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)

	cRegistro   += a975Fill(substr(cCGC1,09,06),06)                 // CNPJ do Estabelecimento
	
	If _013+_006>0	//Debito + Credito > 0 indica q ha movimento no periodo.
		cRegistro   += a975Fill("1", 1)
	Else
		cRegistro   += a975Fill("2", 1)
	EndIf

	cRegistro   += a975Fill(A975Num2Chr(_007,14,2),14)    // Saldo Credor de Periodo Anterior
	cRegistro   += a975Fill(A975Num2Chr(_013,14,2),14)    // Debito
    cRegistro   += a975Fill(A975Num2Chr(_006,14,2),14)    // Credito

	nMultiplic:= If(_017>_016,-1,1)        // Saldo Apurado
	cRegistro   += a975Fill(A975Num2Chr(((Max(_017,_016))*nMultiplic),14,2),14)

	//Credito/Debito
	If (_006+_007)-_013>0    // (Credito+Credito Periodo Anterior)-Debito
		cRegistro   += 		"1"
	ElseIf (_006+_007)-_013==0
		cRegistro   += 		"0"
	Else
		cRegistro   += 		"2"
	EndIf

	cRegistro   += a975Fill(Space (10),10)                                   // Filler
		
	cRegistro   := a975Fill( cRegistro,98)
	A975Grava(cRegistro)

	nEstDeb 	+= _004	//estorno de Debitos
	nOutrCred 	+= _005	//Outros Creditos
	nEstCred 	+= _010	//Estorno de Creditos
	nRessCred	+= _011	//Ressarcimento de Creditos
	nOutrDeb	+=	_012	//Outros Debitos

	dbSkip()
EndDo
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975R21e22   ³Autor ³ Andreia dos Santos  ³ Data ³ 31/08/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ficha 21 - Entradas e Creditos - Tipo R21                   ³±±
±±³          ³Ficha 22 - Saidas e Debitos - Tipo R22                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975R21e22(cArqDado,cArqRem,cArqMerc,cPrdAcum)

Local   cRegistro  :=""
LOCAL	cChave
LOCAL   npos	   := 0
LOCAL	i		   :=0
LOCAL	cTipoMov
LOCAL   nTotSai    :=0
LOCAL   nTotSaiG   :=0
LOCAL   nTotEnt    :=0
LOCAL   nTotEntG   :=0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com dados das Entradas/Saidas                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aEnt := {{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0}}
Local aSai := {{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0}}
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o Resumo das Entradas e Saidas                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
A975Resumo(cArqDado,cArqRem,cArqMerc,cPrdAcum,@aEnt,@aSai)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Registro R21 Entradas e Creditos                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
For i := 1 to 3
    nTotEntG    :=0
	cRegistro   := a975Fill("R21",03)                                                                     	// Tipo
	cRegistro   += a975Fill(,01)                                                                      	// Reservado
	cRegistro   += a975Fill("00",02)                                                                      	// Trimestre
	cRegistro   += a975Fill(strzero(i,2),02)                                                             	// Coluna
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)                                             	// CNPJ do Contribuinte
	nPos        := Ascan(aListBox,{|x| "0105"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)  		// " 0105 - Ano Calendario "
	nPos        := Ascan(aListBox,{|x| "0106"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)		//" 0106 - Declaracao Retificadora"
	cRegistro   += a975Fill(substr(cCGC1,09,06),06)                                                     // CNPJ do Estabelecimento

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Resumo de Entradas  Mercado Nacional  COM CREDITOS   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
	cRegistro   += a975Fill(A975Num2Chr(aEnt[1,i],14,2),14)		// 01.Entradas de Insumos do Mercado Nacional
	cRegistro   += a975Fill(A975Num2Chr(aEnt[2,i],14,2),14) 		// 02.Mercadoria para comercializacao Nacional
	cRegistro   += a975Fill(A975Num2Chr(aEnt[3,i],14,2),14)  		// 03.Industrializacao Efetuada por Outras Empresas
	cRegistro   += a975Fill(A975Num2Chr(aEnt[4,i],14,2),14)  		// 04.Devolucoes de Vendas
	cRegistro   += a975Fill(A975Num2Chr(aEnt[5,i],14,2),14)  		// 05.Outras Entradas
	cRegistro   += a975Fill(A975Num2Chr(aEnt[10,i],14,2),14)		// Total do Mercado Nacional
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Resumo de Entradas  Mercado Externo - COM CREDITOS   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
	cRegistro   += a975Fill(A975Num2Chr(aEnt[6,i],14,2),14)  				// 07.Entradas de Insumos do Mercado Externo 
	cRegistro   += a975Fill(A975Num2Chr(aEnt[7,i],14,2),14) 				// 08.Mercadoria para comercializacao Externo
	cRegistro   += a975Fill(A975Num2Chr(if(i==2,aEnt[8,i],0),14,2),14) 	// 09.Devolucao de vendas
	cRegistro   += a975Fill(A975Num2Chr(aEnt[9,i],14,2),14) 				// 10.Outras Entradas
	nTotEnt     :=(aEnt[6,i]+aEnt[7,i]+aEnt[8,i]+aEnt[9,i])
	cRegistro   += a975Fill(A975Num2Chr(aEnt[11,i],14,2),14) 				// 11.Total do Mercado Externo
    nTotEntG    :=aEnt[10,i]+aEnt[11,i]
	cRegistro   += a975Fill(A975Num2Chr(nTotEntG,14,2),14) 		       	// 12.TOTAL DAS ENTRADAS
	cRegistro   += A975Fill(A975Num2Chr(if(i==3,nEstDeb,0),14,2),14)   	//	13.Estorno de Debitos
	cRegistro   += A975Fill(A975Num2Chr(0,14,2),14) 		                // 14.Creditos Recebidos por Transferencia
	cRegistro   += A975Fill(A975Num2Chr(0,14,2),14)                        // 15.Credito Presumido de IPI
	cRegistro   += A975Fill(A975Num2Chr(if(i==3,nOutrCred,0),14,2),14)   	// 16.Outros 
	cRegistro   += A975Fill(A975Num2Chr(0,14,2),14)		                // 17.TOTAL DE OUTROS CREDITOS
	cRegistro   += A975Fill(A975Num2Chr(0,14,2),14)                       	// 18.TOTAL DO IPI CREDITADO
	cRegistro   += a975Fill(,10)                                           	// Filler
	cRegistro   := a975Fill(cRegistro,292)
	A975Grava(cRegistro)
next 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Registro R22  Saidas e Debitos                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
For i := 1 to 3
	cRegistro   := a975Fill("R22",03)                                	// Tipo
	cRegistro   += a975Fill(,01)                                    	// Reservado
	cRegistro   += a975Fill("00",02)									// Trimestre
	cRegistro   += a975Fill(strzero(i,2),02)                       	// Coluna
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)     	  	// CNPJ do Contribuinte
	nPos        := Ascan(aListBox,{|x| "0105"$x })						//" 0105 - Ano Calendario "
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
	nPos        := Ascan(aListBox,{|x| "0106"$x })						//" 0106 - Declaracao Retificadora"
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
	cRegistro   += a975Fill(substr(cCGC1,09,06),06)                 	// CNPJ do Estabelecimento

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Resumo de Saidas    Mercado Nacional IPI DEBITADO    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
	cRegistro   += a975Fill(A975Num2Chr(aSai[1,i],14,2),14)        // 01.Insumos para Industrializacao
	cRegistro   += a975Fill(A975Num2Chr(aSai[2,i],14,2),14)        // 02.Mercadorias para comercializacao
	cRegistro   += a975Fill(A975Num2Chr(aSai[3,i],14,2),14)        // 03.Industrializacao Efetuada para Outras Empresas
	cRegistro   += a975Fill(A975Num2Chr(aSai[4,i],14,2),14)        // 04.Devolucoes de Compras
	cRegistro   += a975Fill(A975Num2Chr(aSai[5,i],14,2),14)        // 05.Outras Saidas para o Mercado Nacional
	cRegistro   += a975Fill(A975Num2Chr(aSai[10,i],14,2),14)	  	  // 06.Total do Mercado Nacional
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Resumo de Saidas Mercado Externo  IPI CREDITADO      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
	cRegistro   += a975Fill(A975Num2Chr(if(i==2,aSai[6,i],0),14,2),14)			// 07.Producao do Estabelecimento
	cRegistro   += a975Fill(A975Num2Chr(if(i==2,aSai[7,i],0),14,2),14)			// 08.Mercadorias para Comercializacao
	cRegistro   += a975Fill(A975Num2Chr(if(i==2,aSai[8,i],0),14,2),14)			// 09.Devolucoes de Compras
	cRegistro   += a975Fill(A975Num2Chr(if(i==2,aSai[9,i],0),14,2),14)			// 10.Outras Saidas para o Mercado Externo
	cRegistro   += a975Fill(A975Num2Chr(if(i==2,0,0),14,2),14)					    // 11.Total do Mercado Externo
    nTotSaiG    :=aSai[10,i]+aSai[11,i]
	cRegistro   += a975Fill(A975Num2Chr(nTotSaiG,14,2),14)		            		// 12.TOTAL DAS SAIDAS
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Resumo de Saidas Outros Debitos IPI CREDITADO 		 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
	cRegistro   += a975Fill(A975Num2Chr(if(i==3,nEstCred,0),14,2),14)	    		// 13.Estorno de Creditos
	cRegistro   += a975Fill(A975Num2Chr(if(i==3,0,0),14,2),14)              		// 14.Transferencia de Creditos
	cRegistro   += a975Fill(A975Num2Chr(if(i==3,nRessCred,0),14,2),14)     		// 15.Ressarcimento de Creditos
	cRegistro   += a975Fill(A975Num2Chr(if(i==3,0,0),14,2),14)					// 16.Ressarcimento de Credito Presumido de IPI
	cRegistro   += a975Fill(A975Num2Chr(if(i==3,nOutrDeb,0),14,2),14)	    		// 17.Outros
	cRegistro   += a975Fill(A975Num2Chr(if(i==3,0,0),14,2),14)						// 18.TOTAL DE OUTROS DEBITOS
	cRegistro   += a975Fill(A975Num2Chr(if(i==3,0,0),14,2),14)						// 19.TOTAL DO IPI DEBITADO
	cRegistro   += a975Fill(,10)                                               		// Filler
	cRegistro	:= a975Fill(cRegistro,306)
	A975Grava(cRegistro)
next
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975R23      ³Autor ³ Andreia dos Santos  ³ Data ³ 13/03/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ficha 23 - Remetentes de Insumos/Mercadorias - Tipo R23     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975R23(cArqRem)

Local cRegistro
LOCAL nRemet 	:= 1
Local cSubTrib	:=SuperGetMv("MV_ST")
cSubTrib :=If(cSubTrib<>"0","1",cSubTrib)

dbSelectArea(cArqRem)
dbSetOrder(2)
dbSeek("E")

While (cArqRem)->(!eof()) .AND.(cArqRem)->TIPO =="E" .AND. nRemet <= 100
	cRegistro   := a975Fill("R23",03)                              			// Tipo
	cRegistro   += a975Fill(,01)											// Reservado	
	cRegistro   += a975Fill(strzero(nRemet,4,0),04)                		// Sequencial do Remetente
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)        		// CNPJ do Contribuinte
	nPos        := Ascan(aListBox,{|x| "0105"$x })							//" 0105 - Ano Calendario "
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
	nPos        := Ascan(aListBox,{|x| "0106"$x })							//" 0106 - Declaracao Retificadora"
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
	cRegistro   += a975Fill(a975Fill(substr(cCGC1,09,06),06),06)                         // CNPJ do Estabelecimento
	cRegistro   += a975Fill(If(Empty(A975Digit(CGC)),repl("0",14),A975Digit(CGC)),14)   // CNPJ/CPF do Remetente
	cRegistro   += a975Fill(a975Num2Chr((cArqRem)->VALOR,14,2),14)                                  // Valor
    cRegistro   += a975Fill(cSubTrib,01)          	 				                     // Regime Especial de ST      
 	nPos        := Ascan(aListBox,{|x| "2311"$x })					 					// Ha relacao de Interdependecia
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)      	 				                           
	cRegistro   += a975Fill(,10)                                                         // Filler
	cRegistro   := a975Fill(cRegistro,70)  	                                              // Delimitador de Registros
	A975Grava(cRegistro)
	dbskip()
	nRemet++
endDo
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975R24      ³Autor ³ Andreia dos Santos  ³ Data ³ 13/03/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ficha 24 - Entradas de Insumos/Mercadorias - Tipo R24       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975R24(cPrdAcum)

Local cRegistro
LOCAL nReg			:= 1
Local cNBM			:= ""
Local cCodigo		:= ""
Local cMercad		:= ""
Local cSubTrib		:= SuperGetMv("MV_ST")
Local lMVQBPROD		:= GetNewPar("MV_QBPROD",.F.) 

cSubTrib := If(cSubTrib<>"0","1",cSubTrib)

dbSelectArea(cPrdAcum)
dbSetOrder(2) //Ordem Desc de valor
dbSeek("E")
while (cPrdAcum)->(!eof()) .AND. (cPrdAcum)->TIPO == "E" .And. nReg <= 50
	if nReg > 50
		exit
	endif
	cRegistro   := a975Fill("R24",03)                              // Tipo
	cRegistro   += a975Fill(,01)									// Reservado	
	cRegistro   += a975Fill(strzero(nReg,4,0),04)                  // Sequencial da Entrada
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)        // CNPJ do Contribuinte
	nPos        := Ascan(aListBox,{|x| "0105"$x })					// " 0105 - Ano Calendario "
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
	nPos        := Ascan(aListBox,{|x| "0106"$x })					// " 0106 - Declaracao Retificadora"
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
	cRegistro	+= a975Fill(a975Fill(substr(cCGC1,09,06),06),06)  // CNPJ do Estabelecimento
	cRegistro   += a975Fill(A975Digit(NBM),08)                     // Classificacao Fiscal
	cRegistro   += a975Fill(EX,03)      	       	                // Ex
	cRegistro   += a975Fill(MERCAD,55)	            	            // Insumo/Mercadoria
	cRegistro   += a975Fill(a975Num2Chr(VALOR,14,2),14)   	        // Valor do Insumo/Mercadoria
    cRegistro   += a975Fill(cSubTrib,01)             				// Regime Especial de ST      
	cRegistro   += a975Fill(,10)                            	    // Filler
	cRegistro	:= a975Fill(cRegistro,121)
	A975Grava(cRegistro)
	nReg++
	dbskip()
Enddo
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975R25      ³Autor ³ Andreia dos Santos  ³ Data ³ 13/03/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ficha 25 - Destinatarios de Produtos/Mercadorias/Insumos    ³±±
±±³Descri‡…o ³Tipo 25                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975R25(cArqRem)

Local cRegistro
LOCAL nRemet := 1
Local cSubTrib	:=SuperGetMv("MV_ST")
cSubTrib :=If(cSubTrib<>"0","1",cSubTrib)

dbSelectArea(cArqRem)
dbSetOrder(2)
dbSeek("S")

While (cArqRem)->(!eof()) .and. (cArqRem)->TIPO =="S"
	if nRemet > 100
		exit
	endif
	cRegistro   := a975Fill("R25",03)                              // tipo
	cRegistro   += a975Fill(,01)									// Reservado	
	cRegistro   += a975Fill(strzero(nRemet,4,0),04)                // Sequencial da Entrada
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)        // CNPJ do Contribuinte
	nPos        := Ascan(aListBox,{|x| "0105"$x })					//" 0105 - Ano Calendario "
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
	nPos        := Ascan(aListBox,{|x| "0106"$x })					//" 0106 - Declaracao Retificadora"
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
	cRegistro   += a975Fill(a975Fill(substr(cCGC1,09,06),06),06)  // CNPJ do Estabelecimento
	cRegistro   += a975Fill(If(Empty(A975Digit(CGC)),repl("0",14),A975Digit(CGC)),14)  // CNPJ do Destinatario
	cRegistro   += a975Fill(a975Num2Chr(VALOR,14,2),14)         // Valor
    cRegistro   += a975Fill(cSubTrib,01)          // Regime Especial de ST      
  	nPos        := Ascan(aListBox,{|x| "2511"$x })						// Ha relacao de Interdependecia
  	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)      	      
	cRegistro   += a975Fill(,10)   	                            // Filler
	cRegistro   := a975Fill(cRegistro,70)
	A975Grava(cRegistro)
	nRemet ++
	dbskip()
EndDo
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975R26      ³Autor ³ Andreia dos Santos  ³ Data ³ 13/03/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ficha 26 - Saidas de Produtos/Mercadorias/Insumos - Tipo 26 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975R26(cPrdAcum)

Local cRegistro
LOCAL nReg 			:= 1
Local cNBM			:= ""
Local cCodigo		:= ""
Local cMercad		:= ""
Local nValor		:= 0
Local cSubTrib		:= SuperGetMv("MV_ST")

cSubTrib := If(cSubTrib<>"0","1",cSubTrib)

dbSelectArea(cPrdAcum)
dbSetOrder(2)  //Ordem Desc de valor
dbSeek("S")
While (cPrdAcum)->(!eof()) .AND. (cPrdAcum)->TIPO =="S" .And. nReg <= 50
	cRegistro   := a975Fill("R26",03)                              // Tipo
	cRegistro   += a975Fill(,01)									// Reservado	
	cRegistro   += a975Fill(strzero(nReg,4,0),04)                  // Sequencial da Entrada
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)        // CNPJ do Contribuinte
	nPos        := Ascan(aListBox,{|x| "0105"$x })					// " 0105 - Ano Calendario "
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
	nPos        := Ascan(aListBox,{|x| "0106"$x })					// " 0106 - Declaracao Retificadora"
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)

	cRegistro   += a975Fill(a975Fill(substr(cCGC1,09,06),06),06)  // CNPJ do Estabelecimento
	cRegistro   += a975Fill(A975Digit(NBM),08)                     // Classificacao Fiscal
	cRegistro   += a975Fill(EX,03)                               // EX
	cRegistro   += a975Fill(MERCAD,55)                           // Produto/Mercadoria/Insumo
	cRegistro   += a975Fill(a975Num2Chr(VALOR,14,2),14)          // Valor do Produto/Mercadoria/Insumo
    cRegistro   += a975Fill(cSubTrib,01)           // Regime Especial de ST      
	cRegistro   += a975Fill(,10)                                 // Filler
	cRegistro   := a975Fill(cRegistro,121)
	A975Grava(cRegistro)
	nReg++
	dbskip()
EndDo
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma   ³MATA975   ºAutor  ³Microsiga           º Data ³  23/12/10	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.      ³ A975R29a33 - Operacoes com Exterior							º±±
±±º           ³ 29A - Pessoa Vinculada/Interposta/Pais com Trib. Favorecida	º±±
±±º           ³ 29B - Pessoa Nao Vinc./Nao Interposta/Pais s/ Trib. Favorec	º±±
±±º           ³ 30  - Exportacoes (Entradas Divisas)						º±±
±±º           ³ 31  - Contratantes das Exportacoes							º±±
±±º           ³ 32  - Importacoes (Saidas de Divisas)						º±±
±±º           ³ 33  - Contratantes das Importacoes							º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso        ³ DIPJ                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function A975R29a33()

Local	cRegistro
Local	cImport		:= ""   
Local	cExport		:= ""   
Local	cDesc	 		:= ""  
Local	cProduto		:= "" 
Local	cFornecedor	:= ""  
Local	cCliente		:= ""  
Local	cNCM			:= ""                                 
Local	cMetod		:= ""   
Local	cUnDIPJ		:= ""  //Codigo de Unidade de Medida da DIPJ
Local	aTrbs			:= {}
Local	aTotalProd	:= {}
Local	aTotal		:= {}
Local	lRet			:= .T.    
Local	cProdProce	:= ""
Local	lExpVinc		:= .F.
Local	lExpResid	:= .F.
Local	lImpVinc		:= .F.
Local	lImpResid	:= .F.
Local	nReg	  		:= 0
Local	aFicha		:= {}                             
Local	aFicha29A	:= {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
Local	aFicha29B	:= {0,0,0,0,0,0,0,0,0,0,0}
Local	aFicha30		:= {}
Local	aFicha31		:= {}
Local	nPesVinc		:= 0 
Local	nOpeExt		:= Ascan(aListBox,{|x| "0132"$x }) 
Local lEnt			:= .f.
Local lSai			:= .f.

Static	nReg29	:= 1   
Static	nReg30	:= 1   
Static	nReg31	:= 1   
Static	nReg32	:= 1   
Static	nReg33	:= 1   

//Se não for operação com exterior não gera nenhum registro
If Val(aConteudo[nOpeExt]) <> 1	
	Return .F.
Endif	

aTrbs	:= R933CriaArq()     
    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Processa a funcao do Transfer Price para carregar as informações³
//³no registro R32 - Importacoes (Entradas).                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
R933Transfer(.F.,,,,dDtIni,dDtFim,.T.,aTotal,aTotalProd)

//Prepara Registro 29A/29B
//Exportacoes
SAI->(DbGoTop())
SAI->(DbSetOrder(2))  
lSai	:= !SAI->(Eof())
SA1->(DbSetOrder(1))                      	
While !SAI->(Eof())
	If SA1->(dbSeek(xFilial()+SAI->CLIENTE+SAI->LOJA)) .And. SA1->A1_PAIS<>"EX"
	    lExpVinc  := SA1->(FieldPos("A1_VINCULO"))>0 .And. !Empty(SA1->A1_VINCULO)
  	    lExpResid := SA1->(FieldPos("A1_TRIBFAV"))>0 .And. SA1->A1_TRIBFAV=="1"
       If Empty(SAI->CODISS)
				If lExpVinc
					aFicha29A[1] += SAI->TOTAL
				Else	
					aFicha29B[1] += SAI->TOTAL
				Endif
				If lExpResid
					aFicha29A[2] += SAI->TOTAL
				Endif
				If !(lExpVinc .And. lExpResid)
					aFicha29A[3] += SAI->TOTAL
				Endif				
			Else
				If lExpVinc
					aFicha29A[4] += SAI->TOTAL
				Else
					aFicha29B[2] += SAI->TOTAL
				Endif
				If lExpResid
					aFicha29A[5] += SAI->TOTAL
				Endif
				If !(lExpVinc .And. lExpResid)
					aFicha29A[6] += SAI->TOTAL
				Endif				
			Endif
    Endif
	SAI->(DbSkip())
Enddo			
//Importacoes
ENT->(DbGoTop())
ENT->(DbSetOrder(2))  
lEnt	:= !ENT->(Eof())
While !ENT->(Eof())
	If SA2->(dbSeek(xFilial()+ENT->FORNEC+ENT->LOJA))
	    lImpVinc  := SA2->(FieldPos("A2_VINCULO"))>0 .And. !Empty(SA2->A2_VINCULO)
  	    lImpResid := SA2->(FieldPos("A2_TRIBFAV"))>0 .And. SA2->A2_TRIBFAV=="1"
       If Empty(ENT->CODISS)
				If lImpVinc
					aFicha29A[15] += ENT->TOTAL
				Else
					aFicha29B[05] += ENT->TOTAL
				Endif
				If lImpResid
					aFicha29A[16] += ENT->TOTAL
				Endif
				If !(lImpVinc .And. lImpResid)
					aFicha29A[17] += ENT->TOTAL
				Endif				
		 Else
				If lImpVinc
					aFicha29A[18] += ENT->TOTAL
				Else
					aFicha29B[06] += ENT->TOTAL
				Endif
				If lImpResid
					aFicha29A[19] += ENT->TOTAL
				Endif
				If !(lImpVinc .And. lImpResid)
					aFicha29A[20] += ENT->TOTAL
				Endif				
		 Endif
   Endif
	ENT->(DbSkip())
Enddo	

//Prepara Registro 30 e 31
nPesVinc := Ascan(aListBox,{|x| "0133"$x }) //Pessoa vinculada
If Val(aConteudo[nPesVinc]) == 1	
	SAI->(DbGoTop())
	SAI->(DbSetOrder(2))  
	ENT->(DbSetOrder(1)) 
	SB1->(DbSetOrder(1))                      	
	SA1->(DbSetOrder(1)) 			
	SAH->(DbSetOrder(1))
	While !SAI->(Eof())   
		If SA1->(dbSeek(xFilial('SA1')+SAI->CLIENTE+SAI->LOJA)) .And. SA1->A1_EST<>"EX"
			SAI->(DbSkip())  
			Loop
		Endif		
		If !AllTrim(SAI->PRODUTO) == alltrim(cProdProce) 		
			aAdd(aFicha30,{,,,,,,,,,,,,,,,,})
			nReg		:= Len(aFicha30)
			cProdProce	:= SAI->PRODUTO
			cProduto	:= SAI->PRODUTO            			
			cCliente	:= SAI->DESCCLI
			If nReg30 == 50 
				// "3007 - Exportacoes"		
				aFicha30[nReg][01] := "5"
				// "3008 - Descricao"
				aFicha30[nReg][02] := Space(180)
				// "3009 - Total da Operacao"
				aFicha30[nReg][03] := 0
				nPosProd := aScan(aTotalProd,{|x| x[1]==Alltrim(cProduto).And. x[2]=="S"})
		   	If !cExport$"4" .And. aTotalProd[nPosProd][3] > 0
					aFicha30[nReg][03] := aTotalProd[nPosProd][4]
				Endif
				// "3010 - Codigo NCM"
				aFicha30[nReg][04] := Replicate(" ",8) 
				// "3011 - Quantidade"
				aFicha30[nReg][05] := 0
				// "3012 - Unidade de Medida - Conforme Tabela de Codigos constante na DIPJ "
	   	 		aFicha30[nReg][06] := "11"
		    	// "3013 - Reservado"
		    	aFicha30[nReg][07] := "0"
		    	// "3014 - Metodo"
    			aFicha30[nReg][08] := "0"
		    	// "3015 - Preço Parametro"
		    	aFicha30[nReg][09] := 0
		   	 	// "3016 - Preco Praticado"
    			aFicha30[nReg][10] := 0
		    	// "3017 - Valor do Ajuste"
				nPosProd			:= aScan(aTotal,{|x| AllTrim(x[1])==Alltrim(cProduto).And. x[13]=="S"})
				aFicha30[nReg][11]	:= aTotal[nPosProd][27]
				// "3018 - Juros" 
				aFicha30[nReg][12] := 0
				// "3019 - Taxa de Juros Minima"	
				aFicha30[nReg][13] := 0
				// "3020 - Taxa de Juros Maxima""
				aFicha30[nReg][14] := 0
				// "3021 - Codigo do CNC "
				aFicha30[nReg][15] := Replicate("0",5)
				// "3022 - Moeda"	
				aFicha30[nReg][16] := Replicate("0",3)
            //Sequencia 
				aFicha30[nReg][17] := nReg30
				Exit
			Else			  
				//Gera o registro R30 com as informações do relatorio Transfer Price.
				//A quantidade máxima desse regsitro varia de 0001 até  0050.        
				// " 3007 - Exportacoes"
				nPos				:= Ascan(aListBox,{|x| "3207"$x })
				cExport				:= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
				aFicha30[nReg][01]	:= cExport
				// Metodo				 
				nPos		:= Ascan(aListBox,{|x| "3214"$x })
				cMetod      := a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)  	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³O registro R30 é gerado quando o metodo informado no parametro ³
				//³for PRL - 20% - Revenda, pois, esse registro é composto pelas  ³
				//³informações do Transfer Price que utiliza para calculo o metodo³
				//³PRL - 20% Revenda.                                             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
				If !cMetod$"2"
					MsgAlert(STR0197) //"Metodo informado na ficha 30 invalido. Informar o metodo utilizado no Transfer Price."		 
					lRet := .F. 										
				Endif  
				If cMetod$"2"
					//"3008 - Descricao"                          
					If SB1->(dbSeek(xFilial("SB1")+(cProduto))) 
						cDesc := SB1->B1_DESC			                                  	
			   		If cExport$"45"
							aFicha30[nReg][02] := Space(180) 
			  			Else
				  			aFicha30[nReg][02] := a975Fill((cDesc), 180)										
				    	Endif
					Endif 		    	                       
			   	// "3009 - Total da Operacao"  
			   	aFicha30[nReg][03]	:= 0
				   nPosProd	:= aScan(aTotalProd,{|x| x[1]==Alltrim(cProduto).And. x[2]=="S"})
				   If !cExport$"4" .And. aTotalProd[nPosProd][3] > 0
						aFicha30[nReg][03] := aTotalProd[nPosProd][4]
				   Endif 		    
					// "3010 - Codigo NCM"	
					aFicha30[nReg][04] := Replicate(" ",8)   	
					If cExport$"1"  
					 	cNCM				:= SB1->B1_POSIPI
				   	aFicha30[nReg][04]	:= a975Fill(A975Digit(cNCM),08)
					Endif         
					// "3011 - Quantidade"
					aFicha30[nReg][05]	:= 0		    	
					nPosProd	 		:= aScan(aTotalProd,{|x| x[1]==Alltrim(cProduto).And. x[2]=="S"})	
				   If cExport$"1"
					  	aFicha30[nReg][05] += aTotalProd[nPosProd][3]
					Endif   		    
					// "3012 - Unidade de Medida - Conforme Tabela de Codigos constante na DIPJ" 
					aFicha30[nReg][06]	:= Space(2)
					If cExport$"1" .And. SAH->(dbSeek(xFilial("SAH")+(SB1->B1_UM))) 
					  	cUn := SAH->AH_UMRES  			    	
					  	Do Case              
							Case AllTrim(cUn) == Upper("Quilograma Liquido")
									cUnDIPJ := 10
							Case AllTrim(cUn) == Upper("Unidade")
									cUnDIPJ := 11
				      	Case AllTrim(cUn) == Upper("Mil Unidades")
									cUnDIPJ := 12 
			    	 	   Case AllTrim(cUn) == Upper("Par")
									cUnDIPJ := 13 
				    		Case AllTrim(cUn) == Upper("Metro")
									cUnDIPJ := 14
				      	Case AllTrim(cUn) == Upper("Metro Quadrado")
									cUnDIPJ := 15
							Case AllTrim(cUn) == Upper("Metro Cubico")
									cUnDIPJ := 16	
							Case AllTrim(cUn) == Upper("Litro")
									cUnDIPJ := 17
							Case AllTrim(cUn) == Upper("Megawatt Hora")
									cUnDIPJ := 18
							Case AllTrim(cUn) == Upper("Quilate")
									cUnDIPJ := 19
							Case AllTrim(cUn) == Upper("Duzia")
									cUnDIPJ := 20
							Case AllTrim(cUn) == Upper("Tonelada Metrica Liquida")
									cUnDIPJ := 21
							Case AllTrim(cUn) == Upper("Grama")	
									cUnDIPJ := 22
							Case AllTrim(cUn) == Upper("Bilhao de Unidade Internacioanal")
									cUnDIPJ := 23
							Case AllTrim(cUn) == Upper("Quilograma Bruto")
									cUnDIPJ := 24
						EndCase    			    	   
						aFicha30[nReg][06] := cUnDIPJ
					Endif
					//3013 - Operação Sujeita a Arbitramento (art. 14 da IN SRF n° 243/2002)
					If cExport$"45"
				    	aFicha30[nReg][07] := "0"
				    Else	
						aFicha30[nReg][07] := "1"
					Endif					
					// "3014 - Metodo"
					If cExport$"45"
				    	aFicha30[nReg][08] := "0"
					Else	 
						aFicha30[nReg][08] := a975Fill((cMetod),01) 
					Endif    				    
					// "3015 - Preco Parametro"  
					aFicha30[nReg][09]	:= 0
					nPosProd			:= aScan(aTotal,{|x| AllTrim(x[1])==Alltrim(cProduto).And. x[13]=="S"})
					If !cExport$"45"  
						aFicha30[nReg][09] := aTotal[nPosProd][25]
					Endif                                              	
					// "3016 - Preco Praticado"  
					aFicha30[nReg][10]	:= 0
					nPosProd			:= aScan(aTotal,{|x| AllTrim(x[1])==Alltrim(cProduto).And. x[13]=="S"})		 				
					If !cExport$"45"
						aFicha30[nReg][10] :=  aTotalProd[nPosProd][04]
					Endif
					// "3017 - Valor do Ajuste"		  
					If !cExport$"45" .And. aFicha30[nReg][07]=="0"
						aFicha30[nReg][11]	:= 0
					Else	
						nPosProd			:= aScan(aTotal,{|x| AllTrim(x[1])==Alltrim(cProduto).And. x[13]=="S"})
						aFicha30[nReg][11]	:= aTotal[nPosProd][27]
					Endif	
					// "3018 - Juros"
					If !cExport$"4"
						aFicha30[nReg][12]	:= 0
					Endif
					// "3019 - Taxa de Juros Minima"	
					If !cExport$"4"
						aFicha30[nReg][13]	:= 0
					Endif
					// "3020 - Taxa de Juros Maxima"
					If !cExport$"4"
						aFicha30[nReg][14]	:= 0
					Endif
					// "3021 - Codigo do CNC "
					If !cExport$"4"
						aFicha30[nReg][15]	:= Replicate("0",5)
					Endif
					// "3022 - Moeda"	
					If !cExport$"4"
						aFicha30[nReg][16]	:= Replicate("0",3)
					Endif
          	   //Sequencia 
					aFicha30[nReg][17] := nReg30
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Gera o registro R31 para cada R30 com as informações    ³
					//³dos contratantes das Importacoes. O quantidade máxima do³
					//³regsitro R31 varia de 001 até 0030 registros.           ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		       
					If nReg31 <= 30
						aAdd(aFicha31,{,,,,,,,,,,,,,,,})
						// " 3107 - Nome da Pessoa (Juridica/Fisica)"
						aFicha31[nReg][01]	:=  cCliente
						// " 3108- Pais"				
						aFicha31[nReg][02]	:=  SA1->A1_PAIS                 
						// " 3109 - Valor da Operacao"
						aFicha31[nReg][03]	:= Replicate("0",14)
						nPosProd			:= aScan(aTotalProd,{|x| x[1]==Alltrim(cProduto).And. x[2]=="S"})
						If !cExport$"4" .And. aTotalProd[nPosProd][3] > 0   			    			            
							aFicha31[nReg][03] := aTotalProd[nPosProd][04]
						Endif 		 
						// " 3110 - Condicao da Pessoa Envolvida na Operacao"  
						nPos       			:= Ascan(aListBox,{|x| "3310"$x })				
						aFicha31[nReg][04]	:= If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0)
                  //Sequencia
						aFicha31[nReg][05]	:= nReg31
					Endif	 			
				Endif	 			
			Endif
			nReg30++
			nReg31++
	  	Endif           
  		SAI->(DbSkip())  
 	EndDo 	 	
Endif

//Se encontrou dados no Transfer Price 
If lEnt .or. lSai
	If Val(aConteudo[nPesVinc]) == 1	
		If nReg29 == 1
			//Registro 29A
		  	cRegistro   := a975Fill("R29",03)                               // Tipo
			cRegistro   += a975Fill("A",01)									// Reservado	
			cRegistro   += a975Fill("00",02)				                // Trimestre
			cRegistro   += a975Fill("01",02)				                // Coluna
			cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)        // CNPJ do Contribuinte      
			// "06 - Ano Calendario "
			nPos        := Ascan(aListBox,{|x| "3205"$x })					
			cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
			cAno        := a975Fill(aConteudo[nPos],1)
			// "07 - Declaracao Retificadora"
			nPos        := Ascan(aListBox,{|x| "3206"$x })
			cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)  
			// "08 - PJ ENQUADRADA NOS ARTIGOS 35 OU 36 DA IN SRF Nº 243/2002"		
			cRegistro	+= "0"
			// "09 - Exportações de Bens para Pessoas Vinculadas"  
			cRegistro += a975Fill(A975Num2Chr(aFicha29A[01],14,2),14)	
	   	// "10 - Exportações de Bens para Pessoas Residentes em Países com Tributação Favorecida" 
			cRegistro += a975Fill(A975Num2Chr(aFicha29A[02],14,2),14)	
   		// "11 - Demais Exportações de Bens" 
			cRegistro += a975Fill(A975Num2Chr(aFicha29A[03],14,2),14)	
		  	// "12 - Exportações de Serviços para Pessoas Vinculadas" 
			cRegistro += a975Fill(A975Num2Chr(aFicha29A[04],14,2),14)	
		  	// "13 - Exportações de Serviços para Pessoas Residentes em Países com Tributação Favorecida" 
			cRegistro += a975Fill(A975Num2Chr(aFicha29A[05],14,2),14)	
	  	// "14 - Demais Exportações de Serviços" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[06],14,2),14)	
	  	// "15 - Exportações de Direitos para Pessoas Vinculadas" 
	  	cRegistro += a975Fill(A975Num2Chr(aFicha29A[07],14,2),14)	
	  	// "16 - Exportações de Direitos para Pessoas Residentes em Países com Tributação Favorecida" 
	  	cRegistro += a975Fill(A975Num2Chr(aFicha29A[08],14,2),14)	
	  	// "17 - Demais Exportações de Direitos" 
	  	cRegistro += a975Fill(A975Num2Chr(aFicha29A[09],14,2),14)	
	  	// "18 - Operações Não Registradas no Banco Central - Pessoas Vinculadas" 
	  	cRegistro += a975Fill(A975Num2Chr(aFicha29A[10],14,2),14)	
	  	// "19 - Operações Não Registradas no Banco Central - Pessoas Residentes em Países com Tributação Favorecida" 
	  	cRegistro += a975Fill(A975Num2Chr(aFicha29A[11],14,2),14)	
	  	// "20 - Operações Registradas no Banco Central - Pessoas Vinculadas" 
	  	cRegistro += a975Fill(A975Num2Chr(aFicha29A[12],14,2),14)	
	  	// "21 - Operações Registradas no Banco Central - Pessoas Residentes em Países com Tributação Favorecida" 
	  	cRegistro += a975Fill(A975Num2Chr(aFicha29A[13],14,2),14)	
	  	// "22 - Demais Receitas Auferidas" 
	  	cRegistro += a975Fill(A975Num2Chr(aFicha29A[14],14,2),14)	
	  	// "23 - Importações de Bens de Pessoas Vinculadas" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[15],14,2),14)	
	  	// "24 - Importações de Bens de Pessoas Residentes em Países com Tributação Favorecida" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[16],14,2),14)	
	  	// "25 - Demais Importações de Bens" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[17],14,2),14)	
	  	// "26 - Importações de Serviços de Pessoas Vinculadas" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[18],14,2),14)	
	  	// "27 - Importações de Serviços de Pessoas Residentes em Países com Tributação Favorecida" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[19],14,2),14)	
	  	// "28 - Demais Importações de Serviços" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[20],14,2),14)	
	  	// "29 - Importações de Direitos de Pessoas Vinculadas" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[21],14,2),14)	
   	// "30 - Importações de Direitos de Pessoas Residentes em Países com Tributação Favorecida" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[22],14,2),14)	
   	// "31 - Demais Importações de Direitos" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[23],14,2),14)	
   	// "32 - Operações Não Registradas no Banco Central - Pessoas Vinculadas" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[24],14,2),14)	
   	// "33 - Operações Não Registradas no Banco Central - Pessoas Residentes em Países com Tributação Favorecida" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[25],14,2),14)	
   	// "34 - Operações Registradas no Banco Central - Pessoas Vinculadas" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[26],14,2),14)	
   	// "35 - Operações Registradas no Banco Central - Pessoas Residentes em Países com Tributação Favorecida" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[27],14,2),14)	
   	// "36 - Demais Encargos Incorridos" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[28],14,2),14)	
   	// "37 - Comissões e Corretagens Incorridas na Importação de Mercadorias" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[29],14,2),14)	
   	// "38 - Seguros Incorridos na Importação de Mercadorias" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[20],14,2),14)	
   	// "39 - Royalties Incorridos na Importação de Mercadorias" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29A[31],14,2),14)	
		// Filler 
		cRegistro += a975Fill(,10)
		cRegistro := a975Fill(cRegistro,469)  			
		a975Grava(cRegistro) 
		nReg29++
		Endif
		//Registro 30         
		For nReg := 1 To Len(aFicha30) 
			cRegistro   := a975Fill("R30",03)								// Tipo
			cRegistro   += a975Fill(,01)									// Reservado	
			cRegistro   += a975Fill(StrZero(aFicha30[nReg][17],4,0),04)	// Sequencial da Entrada
			cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)		// CNPJ do Contribuinte      
			// "3005 - Ano Calendario "
			nPos        := Ascan(aListBox,{|x| "3205"$x })					
			cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
			cAno        := a975Fill(aConteudo[nPos],1)
			// "3006 - Declaracao Retificadora"
			nPos        := Ascan(aListBox,{|x| "3206"$x })				
			cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)  
			// "3007 - Importacoes"
			cRegistro	+= aFicha30[nReg][1] 	 
			// Metodo				 
			cRegistro += a975Fill((aFicha30[nReg][2]), 180)										
	   	// "3009 - Total da Operacao"  
			cRegistro += a975Fill(A975Num2Chr(aFicha30[nReg][3],14,2),14)	
		   // "3010 - Codigo NCM"	
 			cRegistro += a975Fill(A975Digit(aFicha30[nReg][4]),08)
	    	// "3011 - Quantidade"
	   	cRegistro += a975Fill(A975Num2Chr(aFicha30[nReg][5],11,2), 11)	
		   // "3012 - Unidade de Medida - Conforme Tabela de Codigos constante na DIPJ" 
			cRegistro += a975Fill(cvaltochar(aFicha30[nReg][6]),02) 
			// "3013 - Operação Sujeita a Arbitramento (art. 14 da IN SRF n° 243/2002)" 
			cRegistro += aFicha30[nReg][7]        				    
			// "3014 - Metodo"
			cRegistro += a975Fill((aFicha30[nReg][8]),01) 
			// "3015 - Preco Parametro"  
			cRegistro += a975Fill(A975Num2Chr(aFicha30[nReg][9],14,2), 14)								
			// "3016 - Preco Praticado"  
			cRegistro +=  a975Fill(A975Num2Chr(aFicha30[nReg][10],14,2), 14)		
			// "3017 - Valor do Ajuste"		  
			cRegistro += a975Fill(A975Num2Chr(aFicha30[nReg][11],14,2), 14)						
			// "3018 - Juros"
			cRegistro += a975Fill(A975Num2Chr(aFicha30[nReg][12],14,2), 14)
			// "3019 - Taxa de Juros Minima"	
			cRegistro += a975Fill(A975Num2Chr(aFicha30[nReg][13],7,2), 7)
			// "3020 - Taxa de Juros Maxima"
			cRegistro += a975Fill(A975Num2Chr(aFicha30[nReg][14],7,2), 7)
			// "3021 - Codigo do CNC "
			cRegistro += a975Fill(aFicha30[nReg][15],5)
			// "3022 - Moeda"	
			cRegistro += a975Fill(aFicha30[nReg][16],3)
			// Filler 
			cRegistro += a975Fill(,10)	
			cRegistro := a975Fill(cRegistro,330)  
			a975Grava(cRegistro) 						  	 		   						  	 		     		     						 							
			//Registro 31		 
			If Len(aFicha31) > 0 .And. nReg31 <= 30                        
				cRegistro   := a975Fill("R31",03)                               // Tipo
				cRegistro   += a975Fill(,01)									// Reservado	
				cRegistro   += a975Fill(StrZero(aFicha31[nReg][5],4,0),04)    // Sequencial da Entrada
				cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)       // CNPJ do Contribuinte      
				// " 3105 - Ano Calendario "
				nPos        := Ascan(aListBox,{|x| "3305"$x })					
				cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
				cAno        := a975Fill(aConteudo[nPos],1)
				// " 3106 - Declaracao Retificadora"
				nPos        := Ascan(aListBox,{|x| "3306"$x })				
				cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
				// " 3107 - Nome da Pessoa (Juridica/Fisica)"
				cRegistro	+=  a975Fill(aFicha31[nReg][1],150) 
				// " 3108- Pais"				
				cRegistro	+=  a975Fill(aFicha31[nReg][2],3)                 
				// " 3109 - Valor da Operacao"
		 		cRegistro	+= a975Fill(A975Num2Chr(aFicha31[nReg][3],14,2),14)	
				// " 3110 - Condicao da Pessoa Envolvida na Operacao"  
				cRegistro   += a975Fill(A975Num2Chr(aFicha31[nReg][4],1,0),01)
				// " 3111 - Sequencial da Registro do Pai" 
				cRegistro   += a975Fill(StrZero(aFicha30[nReg][17],4,0),4) 
				// Filler 
				cRegistro += a975Fill(,10)	
				cRegistro := a975Fill(cRegistro,206)  
				a975Grava(cRegistro)
			Endif	
	 	Next 	             
	   //Registro 32 e 33
	   cProdProce := ""
		ENT->(DbGoTop ())
		ENT->(DbSetOrder(2))
		SAI->(DbSetOrder(1))
		SB1->(DbSetOrder(1))
		SAH->(DbSetOrder(1))
		SA2->(DbSetOrder(1))
		While !ENT->(Eof())
			If !AllTrim(ENT->PRODUTO) == alltrim(cProdProce) 		
				cProdProce	:= ENT->PRODUTO
				cProduto	:= ENT->PRODUTO            			
				cFornecedor := ENT->DESCFOR
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄi
				//³Quando as operações exceder a 49ª serao somadas como se fossem    ³
				//³uma única e informadas como sendo a 50ª operação com a            ³
				//³rubrica "Nao Especificadas", lenvado os campos "Total da Operação"³
				//³e "Valor Ajuste".                                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄi	
				If  nReg32 == 50
				  	cRegistro   := a975Fill("R32",03)                              // Tipo
					cRegistro   += a975Fill(,01)									// Reservado	
					cRegistro   += a975Fill(strzero(nReg32,4,0),04)                  // Sequencial da Entrada
					cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)        // CNPJ do Contribuinte      
					// " 3205 - Ano Calendario "
					nPos        := Ascan(aListBox,{|x| "3205"$x })					
					cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
					cAno        := a975Fill(aConteudo[nPos],1)
					// " 3206 - Declaracao Retificadora"
					nPos        := Ascan(aListBox,{|x| "3206"$x })
					cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)  
					// "3207 - Importacoes"		
					cRegistro	+= "5"
					// "3208 - Descricao"			                       
					cRegistro += Space(180)
					// "3209 - Total da Operacao"  
					nPosProd := aScan(aTotalProd,{|x| x[1]==Alltrim(cProduto).And. x[2]=="E"})
			   	If !cImport$"4" .And. aTotalProd[nPosProd][3] > 0
						cRegistro += a975Fill(A975Num2Chr(aTotalProd[nPosProd][4],14,2),14)	
					Else
						cRegistro += Replicate("0",14) 		
					Endif		     
					// "3210 - Codigo NCM"
					cRegistro += Replicate(" ",8) 
					//" 3211 - Quantidade"	 
					cRegistro += Replicate("0",11) 
					// "3212 - Unidade de Medida - Conforme Tabela de Codigos constante na DIPJ "
	  		 		cRegistro += Space(2) 	
			    	// " 3213 - Reservado" 
			    	cRegistro += "0"     		    	
			    	// " 3214 - Metodo" 
	    			cRegistro += "0" 		    	 		    	
			    	//" 3215 - Preço Parametro" 
			    	cRegistro += Replicate("0",14)
		   	 	// " 3216 - Preco Praticado"  
	    			cRegistro += Replicate("0",14)
			    	// "3217 - Valor do Ajuste"		  
					nPosProd :=aScan(aTotal,{|x| AllTrim(x[1])==Alltrim(cProduto).And. x[2]=="E"})			
					cRegistro +=  a975Fill(A975Num2Chr(aTotal[nPosProd][27],14,2), 14)	  
					// "3218 - Juros" 
					cRegistro += Replicate("0",14)  			
					// "3219 - Taxa de Juros Minima"	
					cRegistro += Replicate("0",7)
					// "3220 - Taxa de Juros Maxima""
					cRegistro += Replicate("0",7)
					// "3221 - Codigo do CNC "
					cRegistro += Replicate("0",5)
					// "3222 - Moeda"	
					cRegistro += Replicate("0",3)
					// Filler 
					cRegistro += a975Fill(,10)
					cRegistro := a975Fill(cRegistro,330)  			
					a975Grava(cRegistro) 
					Exit
				Else			  
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
					//³Gera o registro R32 com as informações do relatorio Transfer Price.³
					//³A quantidade máxima desse regsitro varia de 0001 até  0050.        ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 	  		
					cRegistro   := a975Fill("R32",03)                              // Tipo
					cRegistro   += a975Fill(,01)									// Reservado	
					cRegistro   += a975Fill(strzero(nReg32,4,0),04)                // Sequencial da Entrada
					cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)        // CNPJ do Contribuinte      
					// " 3205 - Ano Calendario "
					nPos        := Ascan(aListBox,{|x| "3205"$x })					
					cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
					cAno        := a975Fill(aConteudo[nPos],1)
					// " 3206 - Declaracao Retificadora"
					nPos        := Ascan(aListBox,{|x| "3206"$x })				
					cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)  
					// "3207 - Importacoes"
					nPos			:= Ascan(aListBox,{|x| "3207"$x })
					cImport     := a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 				
					cRegistro	+= cImport 	 
					// Metodo				 
					nPos			:= Ascan(aListBox,{|x| "3214"$x })
					cMetod      := a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)  	
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³O registro R32 é gerado quando o metodo informado no parametro ³
					//³for PRL - 20% - Revenda, pois, esse registro é composto pelas  ³
					//³informações do Transfer Price que utiliza para calculo o metodo³
					//³PRL - 20% Revenda.                                             ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
					If !cMetod$"2"
						MsgAlert(STR0197) //"Metodo informado na ficha 32 invalido. Informar o metodo utilizado no Transfer Price."		 
						lRet 		:= .F. 										
					Endif  
					If cMetod$"2"
						//" 3208 - Descricao"                          
						If SB1->(dbSeek(xFilial("SB1")+(cProduto))) 
							cDesc := SB1->B1_DESC			                                  	
				   		If cImport$"45"
								cRegistro += Space(180) 
				  			Else
					  			cRegistro += a975Fill((cDesc), 180)										
					    	Endif
						Endif 		    	                       
				   	// "3209 - Total da Operacao"  
					   nPosProd := aScan(aTotalProd,{|x| x[1]==Alltrim(cProduto).And. x[2]=="E"})			    			   			    			    			    
					   If !cImport$"4" .And. aTotalProd[nPosProd][3] > 0   			    			            
							cRegistro += a975Fill(A975Num2Chr(aTotalProd[nPosProd][4],14,2),14)	
					   Else
							cRegistro += Replicate("0",14) 		
					   Endif 		    
				    	// "3210 - Codigo NCM"	
					   If cImport$"1"  
				    		cNCM		 := SB1->B1_POSIPI
			   	 		cRegistro += a975Fill(A975Digit(cNCM),08)
				    	Else
				    		cRegistro += Replicate(" ",8)   	
				    	Endif         
				    	// "3211 - Quantidade"
				    	nPosProd := aScan(aTotalProd,{|x| x[1]==Alltrim(cProduto).And. x[2]=="E"})	
				    	If cImport$"1"
				    		cRegistro += a975Fill(A975Num2Chr(aTotalProd[nPosProd][3],11,2), 11)	
				    	Else
							cRegistro += Replicate("0",11)		    	
				    	Endif   		    
				    	// "3212 - Unidade de Medida - Conforme Tabela de Codigos constante na DIPJ" 
						If cImport$"1"   .And.  SAH->(dbSeek(xFilial("SAH")+(SB1->B1_UM ))) 
				    		cUn := SAH->AH_UMRES  			    	
				    		Do Case              
							Case AllTrim(cUn) == Upper("Quilograma Liquido")
								cUnDIPJ := 10
							Case AllTrim(cUn) == Upper("Unidade")
								cUnDIPJ := 11
			    	   	Case AllTrim(cUn) == Upper("Mil Unidades")
								cUnDIPJ := 12 
		    	 	   	 Case AllTrim(cUn) == Upper("Par")
								cUnDIPJ := 13 
				    		Case AllTrim(cUn) == Upper("Metro")
								cUnDIPJ := 14
			    	   	Case AllTrim(cUn) == Upper("Metro Quadrado")
								cUnDIPJ := 15
							Case AllTrim(cUn) == Upper("Metro Cubico")
								cUnDIPJ := 16	
							Case AllTrim(cUn) == Upper("Litro")
								cUnDIPJ := 17
							Case AllTrim(cUn) == Upper("Megawatt Hora")
								cUnDIPJ := 18
							Case AllTrim(cUn) == Upper("Quilate")
								cUnDIPJ := 19
							Case AllTrim(cUn) == Upper("Duzia")
								cUnDIPJ := 20
							Case AllTrim(cUn) == Upper("Tonelada Metrica Liquida")
								cUnDIPJ := 21
							Case AllTrim(cUn) == Upper("Grama")	
								cUnDIPJ := 22
							Case AllTrim(cUn) == Upper("Bilhao de Unidade Internacioanal")
								cUnDIPJ := 23
							Case AllTrim(cUn) == Upper("Quilograma Bruto")
								cUnDIPJ := 24
							EndCase    			    	   
							cRegistro += a975Fill(cvaltochar(cUnDIPJ),02) 
						Else
							cRegistro += Space(2) 		    		
						Endif
						//Reservado
						cRegistro += "0"        				    
						// "3214 - Metodo"
						If cImport$"45"
					    	cRegistro += "0"
						Else	 
							cRegistro += a975Fill((cMetod),01) 
						Endif    				    
						// "3215 - Preco Parametro"  
						nPosProd := aScan(aTotal,{|x| AllTrim(x[1])==Alltrim(cProduto).And. x[2]=="E"})				
						If !cImport$"45"  
							cRegistro += a975Fill(A975Num2Chr(aTotal[nPosProd][04/*25*/],14,2), 14)								
						Else					
							cRegistro += Replicate("0",14)
						Endif
						// "3216 - Preco Praticado"  
						nPosProd :=aScan(aTotal,{|x| AllTrim(x[1])==Alltrim(cProduto).And. x[2]=="E"})		 				
						If !cImport$"45"
							cRegistro +=  a975Fill(A975Num2Chr(aTotal[nPosProd][04],14,2), 14)		
						Else
							cRegistro += Replicate("0",14)
						Endif
						// "3217 - Valor do Ajuste"		  
						nPosProd  := aScan(aTotal,{|x| AllTrim(x[1])==Alltrim(cProduto).And. x[2]=="E"})			
						cRegistro += a975Fill(A975Num2Chr(aTotal[nPosProd][27],14,2), 14)						
						//"3218 - Juros"
						If !cImport$"4"
							cRegistro += Replicate("0",14)  	
						Endif
						// "3219 - Taxa de Juros Minima"	
						If !cImport$"4"
							cRegistro += Replicate("0",7)
						Endif
						// "3220 - Taxa de Juros Maxima"
						If !cImport$"4"
							cRegistro += Replicate("0",7)
						Endif
						// "3221 - Codigo do CNC "
						If !cImport$"4"
							cRegistro += Replicate("0",5)
						Endif
						// "3222 - Moeda"	
						If !cImport$"4"
							cRegistro += Replicate("0",3)
						Endif  
						cRegistro  	+= a975Fill(,10)	// Filler 
						cRegistro   := a975Fill(cRegistro,330)  			
						a975Grava(cRegistro) 								  	 		     		     						 							
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Gera o registro R33 para cada R32 com as informações    ³
						//³dos contratantes das Importacoes. O quantidade máxima do³
						//³regsitro R33 varia de 001 até 0030 registros.           ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		       
						If nReg33 > 30
							Exit
						Endif  									
						cRegistro   := a975Fill("R33",03)								// Tipo
						cRegistro   += a975Fill(,01)									// Reservado	
						cRegistro   += a975Fill(strzero(nReg33,4,0),04)                // Sequencial da Entrada
						cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)		// CNPJ do Contribuinte      
						// " 3305 - Ano Calendario "
						nPos        := Ascan(aListBox,{|x| "3305"$x })					
						cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
						cAno        := a975Fill(aConteudo[nPos],1)
						// " 3306 - Declaracao Retificadora"
						nPos        := Ascan(aListBox,{|x| "3306"$x })				
						cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
						// " 3307 - Nome da Pessoa (Juridica/Fisica)"
						cRegistro	+=  a975Fill(cFornecedor,150) 
						// " 3308- Pais"				
						cRegistro	+=  a975Fill(SA2->A2_PAIS,3)                 
						// " 3309 - Valor da Operacao"
						nPosProd		:= aScan(aTotalProd,{|x| x[1]==Alltrim(cProduto).And. x[2]=="E"})			    			   			    			    			    
						If !cImport$"4" .And. aTotalProd[nPosProd][3] > 0   			    			            
							cRegistro += a975Fill(A975Num2Chr(aTotalProd[nPosProd][04],14,2),14)	
						Else
							cRegistro += Replicate("0",14) 		
						Endif 		 
						// " 3310 - Condicao da Pessoa Envolvida na Operacao"  
						nPos        := Ascan(aListBox,{|x| "3310"$x })				
						cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
						// " 3311 - Sequencial da Registro do Pai" 
						cRegistro   += a975Fill(strzero(nReg33,4,0),04) 
						// Filler 
						cRegistro  	+= a975Fill(,10)	
						cRegistro   := a975Fill(cRegistro,206)  
						a975Grava(cRegistro)
					Endif	 			
				Endif
				nReg32++  
				nReg33++   	    	  
		  	Endif           
  			ENT->(DbSkip())  
	 	EndDo
 	Else
		//Registro 29B
		If nReg29 == 1
	  	cRegistro   := a975Fill("R29",03)                       // Tipo
		cRegistro   += a975Fill("B",01)									// Reservado	
		cRegistro   += a975Fill("00",02)				                // Trimestre
		cRegistro   += a975Fill("01",02)				                // Coluna
		cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)        // CNPJ do Contribuinte      
		// "06 - Ano Calendario "
		nPos        := Ascan(aListBox,{|x| "3205"$x })					
		cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
		cAno        := a975Fill(aConteudo[nPos],1)
		// "07 - Declaracao Retificadora"
		nPos        := Ascan(aListBox,{|x| "3206"$x })
		cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)  
		// "08 - Reservado"
		cRegistro	+= "0"
		// "09 - Total de Exportações de Bens"  
		cRegistro += a975Fill(A975Num2Chr(aFicha29B[01],14,2),14)	
   	// "10 - Total de Exportações de Serviços" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29B[02],14,2),14)	
   	// "11 - Total de Exportações de Direitos" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29B[03],14,2),14)	
  		// "12 - Total de Receitas Auferidas de Operações Financeiras" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29B[04],14,2),14)	
  		// "13 - Total de Importações de Bens" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29B[05],14,2),14)	
  		// "14 - Total de Importações de Serviços" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29B[06],14,2),14)	
  		// "15 - Total de Importações de Direitos" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29B[07],14,2),14)	
  		// "16 - Total de Encargos Incorridos de Operações Financeiras" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29B[08],14,2),14)	
   	// "17 - Comissões e Corretagens Incorridas na Importação de Mercadorias" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29B[09],14,2),14)	
   	// "18 - Seguros Incorridos na Importação de Mercadorias" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29B[10],14,2),14)	
   	// "19 - Royalties Incorridos na Importação de Mercadorias" 
		cRegistro += a975Fill(A975Num2Chr(aFicha29B[11],14,2),14)	
   	// "20 - Reservado" 
   	cRegistro += Replicate("0",280)
   	// "21 - Reservado" 
   	cRegistro += Replicate(" ",10)
		cRegistro := a975Fill(cRegistro,469)  			
		a975Grava(cRegistro) 
		nReg29++
		Endif
   Endif                                                   	
Endif        
ENT->(dbCloseArea())
SAI->(dbCloseArea())
SA2->(dbCloseArea())
Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R36A  ºAutor  ³Natalia Antonucci   º Data ³  31/05/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ativo - Balanço Patrimonial                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R36A(aEmpresa)

Local cFil36A 	:= FWCodFil()
Local nPos 		:= 0
Local cRegistro   
Local aBalancoA := {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst 	:= .T.
Local aReg36A 	:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
    cFilAnt := aEmpresa[nX][3]
	aBalancoA := GetSldPlGer(mv_par12, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
    If lFirst     
    	aReg36A := aClone(aBalancoA)
        lFirst  := .F.
    Else    
		For nY:= 1 To Len(aBalancoA) 
	    	If  nCont <= 66
	    		AReg36A[nY][4] += aBalancoA[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next nY    
    EndIf
Next nX
					
If len(AReg36A) > 0
	cRegistro   := a975Fill("R36",03) // Tipo
	cRegistro   += a975Fill("A",01) // Reservado
	cRegistro   += a975Fill(A975Num2Chr(00,2,0),02) //Trimestre
	nPos        := Ascan(aListBox,{|x| "3604"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //"3604 - Coluna"
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos        := Ascan(aListBox,{|x| "0105"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos        := Ascan(aListBox,{|x| "0106"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[1][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[2][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[3][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[4][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[5][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[6][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[7][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[8][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[9][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[10][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[11][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[12][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[13][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[14][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[15][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[16][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[17][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[18][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[19][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[20][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[21][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[22][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[23][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[24][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[25][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[26][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[27][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[28][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[29][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[30][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[31][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[32][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[33][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[34][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[35][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[36][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[37][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[38][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[39][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[40][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[41][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[42][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[43][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[44][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[45][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[46][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[47][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[48][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[49][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[50][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[51][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[52][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[53][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[54][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[55][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[56][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[57][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[58][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[59][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[60][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[61][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[62][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[63][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[64][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[65][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[66][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[67][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[68][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[69][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[70][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[71][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[72][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[73][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[74][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[75][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[76][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[77][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[78][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[79][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[80][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg36A[81][4],14),14)
	cRegistro   += Replicate("0",336) 	//Reservado
	cRegistro   += a975Fill(,10) 	 	//Filler
	cRegistro 	:= a975Fill(cRegistro,1504)			
	a975Grava(cRegistro)
Endif                                     

cFilAnt := cFil36A

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R37A  ºAutor  ³Natalia Antonucci   º Data ³  31/05/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Passivo - Balanço Patrimonial                              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R37A(aEmpresa) 

Local cFil37A 	:= FWCodFil()
Local nPos 		:= 0
Local cRegistro   
Local aBalancoP := {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg37A 	:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
    cFilAnt := aEmpresa[nX][3]
	aBalancoP := GetSldPlGer(mv_par13, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
    If lFirst     
    	aReg37A := aClone(aBalancoP)
        lFirst  := .F.
    Else    
		For nY:= 1 To Len(aBalancoP) 
	    	If  nCont <= 47
	    		AReg37A[nY][4] += aBalancoP[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next nY    
    EndIf
Next nX

If len(AReg37A) > 0
	cRegistro   := a975Fill("R37",03) // Tipo
	cRegistro   += a975Fill("A",01) // Reservado
	cRegistro   += a975Fill(A975Num2Chr(00,2,0),02) //Trimestre
	nPos        := Ascan(aListBox,{|x| "3704"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //"3704 - Coluna" 	
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos        := Ascan(aListBox,{|x| "0105"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos        := Ascan(aListBox,{|x| "0106"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[1][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[2][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[3][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[4][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[5][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[6][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[7][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[8][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[9][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[10][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[11][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[12][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[13][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[14][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[15][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[16][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[17][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[18][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[19][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[20][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[21][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[22][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[23][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[24][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[25][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[26][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[27][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[28][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[29][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[30][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[31][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[32][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[33][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[34][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[35][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[36][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[37][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[38][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[39][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[40][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[41][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[42][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[43][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[44][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[45][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[46][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[47][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[48][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[49][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[50][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[51][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[52][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[53][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[54][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[55][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[56][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg37A[57][4],14),14)
	cRegistro   += Replicate("0",798) 	//Reservado
	cRegistro   += a975Fill(,10) 	 	//Filler
	cRegistro := a975Fill( cRegistro,1630)
	a975Grava(cRegistro)
Endif                                     

cFilAnt := cFil37A	
Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R38   ºAutor  ³Natalia Antonucci   º Data ³  05/08/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Demonstração dos Lucros ou Prejuízos Acumulados            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R38(aEmpresa) 

Local cFil38 	:= FWCodFil()
Local nPos 		:= 0
Local cRegistro   
Local aFicha38	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg38 	:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
    cFilAnt := aEmpresa[nX][3]
	aFicha38 := GetSldPlGer(mv_par14, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
    If lFirst     
    	aReg38 := aClone(aFicha38)
        lFirst  := .F.
    Else    
		For nY:= 1 To Len(aFicha38) 
	    	If  nCont <= 18
	    		AReg38[nY][4] += aFicha38[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next nY    
    EndIf
Next nX

If len(AReg38) > 0
	cRegistro   := a975Fill("R38",03) // Tipo
	cRegistro   += a975Fill(,01)     // Reservado
	cRegistro   += a975Fill("00",02) // Trimestre
	cRegistro   += a975Fill("01",02) // Coluna	
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos        := Ascan(aListBox,{|x| "0105"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos        := Ascan(aListBox,{|x| "0106"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	cRegistro   += a975Fill(A975Num2Chr(AReg38[1][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[2][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[3][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[4][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[5][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[6][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[7][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[8][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[9][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[10][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[11][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[12][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[13][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[14][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[15][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[16][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[17][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg38[18][4],14),14)
	cRegistro   += a975Fill(,10) 	 	//Filler
	cRegistro 	:= a975Fill( cRegistro,294) 
	a975Grava(cRegistro)
Endif                                     

cFilAnt := cFil38	

Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R39   ºAutor  ³Natalia Antonucci   º Data ³  31/05/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Origem e Aplicação de Recurso                              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R39(aEmpresa)
Local nPos := 0
Local cRegistro
Local aOriAplRec := {} 
Local cFil39 	:= FWCodFil()
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg39 	:= {}
Local nCont 	:= 0 

For nX := 1 To Len(aEmpresa)
    cFilAnt := aEmpresa[nX][3]
	aOriAplRec := GetSldPlGer(mv_par15, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
    If lFirst     
    	aReg39  := aClone(aOriAplRec)
        lFirst  := .F.
    Else    
		For nY:= 1 To Len(aOriAplRec) 
	    	If  nCont <= 15
	    		AReg39[nY][4] += aOriAplRec[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next nY    
    EndIf
Next nX

If len(AReg39) > 0
	cRegistro   := a975Fill("R39",03)                                                                     	// Tipo
	cRegistro   += a975Fill(,01)                                                                        	// Reservado
	cRegistro   += a975Fill("00",02)                                                                      	// Trimestre
	cRegistro   += a975Fill("01",02)                                                                    	// Coluna
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)                                             	// CNPJ do Contribuinte
	nPos        := Ascan(aListBox,{|x| "0105"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)  		// " 0105 - Ano Calendario "
	nPos        := Ascan(aListBox,{|x| "0106"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)		//" 0106 - Declaracao Retificadora"
	cRegistro   += a975Fill(A975Num2Chr(AReg39[1][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg39[2][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg39[3][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg39[4][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg39[5][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg39[6][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg39[7][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg39[8][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg39[9][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg39[10][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg39[11][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg39[12][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg39[13][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg39[14][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg39[15][4],14),14)
	cRegistro   += a975Fill(,10) 	 	//Filler
	cRegistro := a975Fill( cRegistro,244) 
	a975Grava(cRegistro)
Endif

cFilAnt := cFil39	
Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R49   ºAutor  ³Natalia Antonucci   º Data ³  31/08/2011 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Pólo Industrial de Manaus e Amazônia Ocidental             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 
Static Function A975R49(aEmpresa)  

Local nPos := 0
Local cRegistro
Local aFicha49 := {} 
Local cFil49 	:= FWCodFil()
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg49 	:= {}
Local nCont 	:= 0 

For nX := 1 To Len(aEmpresa)
    cFilAnt := aEmpresa[nX][3]
	aFicha49 := GetSldPlGer(mv_par16, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
    If lFirst     
    	aReg49  := aClone(aFicha49)
        lFirst  := .F.
    Else    
		For nY:= 1 To Len(aFicha49) 
	    	If  nCont <= 29
	    		AReg49[nY][4] += aFicha49[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next nY    
    EndIf
Next nX
If len(AReg49) > 0
	cRegistro   := a975Fill("R49",03)                                                                     	// Tipo
	cRegistro   += a975Fill(,01)                                                                        	// Reservado
	cRegistro   += a975Fill("00",02)                                                                      	// Trimestre
	cRegistro   += a975Fill("01",02)                                                                    	// Coluna
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)                                             	// CNPJ do Contribuinte
	nPos        := Ascan(aListBox,{|x| "0105"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)  		// " 0105 - Ano Calendario "
	nPos        := Ascan(aListBox,{|x| "0106"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)		//" 0106 - Declaracao Retificadora"
	cRegistro   += a975Fill(A975Num2Chr(AReg49[1][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[2][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[3][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[4][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[5][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[6][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[7][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[8][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[9][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[10][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[11][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[12][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[13][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[14][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[15][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[16][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[17][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[18][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[19][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[20][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[21][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[22][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[23][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[24][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[25][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[26][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[27][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[28][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg49[29][4],14),14)
	cRegistro   += a975Fill(,10) 	 	//Filler
	cRegistro 	:= a975Fill( cRegistro,440) 
	a975Grava(cRegistro)                   
Endif
cFilAnt := cFil49	
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R54   ºAutor  ³Natalia Antonucci   º Data ³  31/08/2011 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Discriminação da Receita de Vendas dos Estabelecimentos    º±±
±±º          ³    por Atividade Econômica 								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 
Static Function A975R54(cArqMerc)

Local	cRegistro 
Local	nPos	:= 0
Local	aReg54	:= {}
Local	Nx		:= 0
Static	nReg54	:= 0001 //Tipo static para continuar incrementando quando for outra filial
      
dbSelectArea(cArqMerc)
dbSetOrder(2)
dbSeek("S")

while (cArqMerc)->(!eof()) .AND. (cArqMerc)->TIPO == "S" 
	if nReg54 > 9999
		exit
	endif
	nPos := aScan (AReg54, {|x| x[9]==a975Fill(SM0->M0_CNAE,07)}) 
	If nPos == 0
		AADD(AReg54,{a975Fill("R54",03),;  
				a975Fill(,01),;  
				a975Fill(strzero(nReg54,4,0),04),; 
				a975Fill(A975Num2Chr(Val(cCGC),14,0),14), ;  
				a975Fill(A975Num2Chr(If(!Empty(aConteudo[Ascan(aListBox,{|x| "0105"$x })]),Val(aConteudo[Ascan(aListBox,{|x| "0105"$x })]),0),1,0),01),;
				a975Fill(A975Num2Chr(If(!Empty(aConteudo[Ascan(aListBox,{|x| "0106"$x })]),Val(aConteudo[Ascan(aListBox,{|x| "0106"$x })]),0),1,0),01),;
			    a975Fill(substr(cCGC1,09,06),06) ,;													
		   		(cArqMerc)->VALOR,;
				a975Fill(SM0->M0_CNAE,07)})   
		nReg54++
	Else
		AReg54[nPos,8] += (cArqMerc)->VALOR
	EndIf
	dbskip()	
endDo
For Nx := 1 To Len(AReg54)	
	cRegistro   := AReg54[Nx,01]	// Tipo
	cRegistro   += AReg54[Nx,02]   	//Reservado
 	cRegistro   += AReg54[Nx,03]   //Sequencial 
	cRegistro   += AReg54[Nx,04]   	//CNPJ do Contribuinte
	cRegistro   += AReg54[Nx,05] 	//0105 - Ano Calendario
	cRegistro   += AReg54[Nx,06]	//0106 - Declaracao Retificadora
    cRegistro   += AReg54[Nx,07]	//CNPJ do Estabelecimento															
	cRegistro   += a975Fill(a975Num2Chr(AReg54[Nx,08],14,2),14)	//Receita 
	cRegistro   += AReg54[Nx,09]   
	cRegistro   += a975Fill(,10) 	//Filler
	cRegistro 	:= a975Fill( cRegistro,61)
	A975Grava(cRegistro)
Next(Nx)
		
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R55   ºAutor  ³Natalia Antonucci   º Data ³  31/08/2011 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Vendas a Comercial Exportadora com Fim Específico          º±±
±±º          ³ de Exportação          							     	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 
Static Function A975R55(cArqMerc)
Local nPos := 0
Local cRegistro
Local nReg := 0001
Local aReg55 := {}
Local Nx := 0
Local cCGC2 := ""

nPos	:= Ascan(aListBox,{|x| "0155"$x })
If Val(aConteudo[nPos])==0
	Return
Endif
dbSelectArea(cArqMerc)
dbSetOrder(2)
dbSeek("S")

while (cArqMerc)->(!eof()) .AND. (cArqMerc)->TIPO == "S" 
	cCGC2 := a975Fill(A975Digit((cArqMerc)->CGC),14) 
	if nReg > 9999
		exit
	endif
   	If Alltrim((cArqMerc)->CFO)$"5501/5502/6501/6502" 
   		nPos := aScan (AReg55, {|x| x[8]==a975Fill(A975Digit((cArqMerc)->NBM),08) .AND. x[7]==cCGC2}) 
		If nPos == 0
			AADD(AReg55,{a975Fill("R55",03),;  
					a975Fill(,01),;  
					a975Fill(strzero(nReg,4,0),04),; 
					a975Fill(A975Num2Chr(Val(cCGC),14,0),14), ;  
					a975Fill(A975Num2Chr(If(!Empty(aConteudo[Ascan(aListBox,{|x| "0105"$x })]),Val(aConteudo[Ascan(aListBox,{|x| "0105"$x })]),0),1,0),01),;
					a975Fill(A975Num2Chr(If(!Empty(aConteudo[Ascan(aListBox,{|x| "0106"$x })]),Val(aConteudo[Ascan(aListBox,{|x| "0106"$x })]),0),1,0),01),;
				    cCGC2,;													
					a975Fill(A975Digit((cArqMerc)->NBM),08),; 
					(cArqMerc)->VALOR })   
			nReg++
		Else
			AReg55[nPos,9] += (cArqMerc)->VALOR
		EndIF
   	Endif
	dbskip()	
endDo
For Nx := 1 To Len(AReg55)	
	cRegistro   := AReg55[Nx,01]	// Tipo
	cRegistro   += AReg55[Nx,02]   	//Reservado
 	cRegistro   += AReg55[Nx,03]   //Sequencial 
	cRegistro   += AReg55[Nx,04]   	//CNPJ do Contribuinte
	cRegistro   += AReg55[Nx,05] 	//0105 - Ano Calendario
	cRegistro   += AReg55[Nx,06]	//0106 - Declaracao Retificadora
    cRegistro   += AReg55[Nx,07]	//CNPJ da Comercial Exportadora															
	cRegistro   += AReg55[Nx,08]   //Codigo NCM
	cRegistro   += a975Fill(a975Num2Chr(AReg55[Nx,09],14,2),14)   //Valor da Venda
	cRegistro   += a975Fill(,10) 	//Filler
	cRegistro 	:= a975Fill( cRegistro,70)
	A975Grava(cRegistro)
Next(Nx)
		
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R56   ºAutor  ³Natalia Antonucci   º Data ³  31/08/2011 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Detalhamento das Exportações da Comercial Exportadora      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975R56()
 
Local nPos := 0
Local nX        := 0
Local nRastro 	:= 0 
Local cRegistro
Local cAliasSD2	:= "SD2" 
Local nReg := 0001
Local aReg56S := {}
Local aReg56 := {}
Local aRastro := {}
Local aArea		:= GetArea(cAliasSD2)
Local aAuxLote  := {}
Local lQuery    := .F. 
Local cRecnoSD2 := 0

                       
nPos	:= Ascan(aListBox,{|x| "0154"$x })
If Val(aConteudo[nPos])==0
	RestArea(aArea)
	Return
Endif

DbSelectArea("SD2")
SD2->(DbSetOrder(3))
#IFDEF TOP
    	If (TcSrvType ()<>"AS/400")
    		lQuery    := .T.               

	   		cAliasSD2	:=	GetNextAlias()
      				  		   	
    	BeginSql Alias cAliasSD2    	
			SELECT D2_EMISSAO, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_LOTECTL, D2_TOTAL, D2_COD , D2_DOC 
			FROM %table:SD2% SD2,%table:SB1% SB1
			WHERE 
			SD2.D2_FILIAL=%xFilial:SD2% AND 
			SD2.D2_EMISSAO>=%Exp:DToS (dDtIni)% AND 
			SD2.D2_EMISSAO<=%Exp:DToS (dDtFim)% AND
			SD2.%NotDel% AND 
			SB1.B1_FILIAL = %xFilial:SB1% AND
		   SB1.B1_COD = D2_COD AND
		   SB1.%NotDel% 			               			
		EndSql 
		Else
#ENDIF
	   	cIndex	:= CriaTrab(NIL,.F.)
	    cFiltro	:= 'D2_FILIAL=="'+xFilial ("SD2")+'".And.'
	   	cFiltro += 'DToS(D2_EMISSAO)>="'+DToS(dDtIni)+'".And. DToS(D2_EMISSAO)<="'+DToS(dDtFim)+'" '
	    IndRegua (cAliasSD2, cIndex, SD2->(IndexKey ()),, cFiltro)
  		nIndex := RetIndex(cAliasSD2)
	    
		#IFNDEF TOP
			dbSetIndex(cIndex+OrdBagExt())
		#ENDIF			
		dbSelectArea(cAliasSD2)
	    dbSetOrder(nIndex+1)
	 
#IFDEF TOP
	   	Endif
#ENDIF 
	 
SA2->(dbSetOrder(1))
DbSelectArea(cAliasSD2)
(cAliasSD2)->(DbGoTop())
ProcRegua((cAliasSD2)->(RecCount ())) 
nRastro := 0
While !(cAliasSD2)->(Eof())
	
	If !lQuery
		IF SB1->(!dbSeek(xFilial("SB1")+(cAliasSD2)->D2_COD))
			(cAliasSD2)->(dbSkip())
			Loop
		EndIf
		cRecnoSD2 := (cAliasSD2)->(Recno())
	Endif
	
	aRastro:=RastroNFOr((cAliasSD2)->D2_DOC,(cAliasSD2)->D2_SERIE,(cAliasSD2)->D2_CLIENTE,(cAliasSD2)->D2_LOJA)
	
	If !lQuery
		(cAliasSD2)->(dbGoTo(cRecnoSD2))		
	EndIf
	
	nRastro++
	aAuxLote :={}
	For nX := 1 To Len(aRastro)
		nPos	:=	aScan (aAuxLote, {|x| x[1]==aRastro[Nx][3] .AND. x[2] ==aRastro[Nx][44]})
		if nPos > 0
			aAuxLote[nPos,3] += aRastro[Nx][5]
		Else
			aAdd(aAuxLote,{ aRastro[Nx][3], aRastro[Nx][44], aRastro[Nx][5]})
		Endif
	Next nx
	
	nPos	:=	aScan (aAuxLote, {|x| x[1]==(cAliasSD2)->D2_COD .AND. x[2]==(cAliasSD2)->D2_LOTECTL})
   If len(aRastro)>0 .and. SA2->(DbSeek(xFilial("SA2")+aRastro[1,8]+aRastro[1,9]))
		If alltrim(aRastro[1,34])$"7501" .and. alltrim(aRastro[1,31])$"1501/2501"
			 AADD(aReg56S,{a975Fill("R56",03),;  
					a975Fill(,01),;  
					a975Fill(A975Num2Chr(Val(cCGC),14,0),14), ;  
					a975Fill(A975Num2Chr(If(!Empty(aConteudo[Ascan(aListBox,{|x| "0105"$x })]),Val(aConteudo[Ascan(aListBox,{|x| "0105"$x })]),0),1,0),01),;
					a975Fill(A975Num2Chr(If(!Empty(aConteudo[Ascan(aListBox,{|x| "0106"$x })]),Val(aConteudo[Ascan(aListBox,{|x| "0106"$x })]),0),1,0),01),;
			   	a975Fill(a975Fill(substr(SA2->A2_CGC,01,14),14),14) ,;
					a975Fill(A975Digit(SB1->B1_POSIPI),08),;
			 aAuxLote[nPos,3],;
			 (cAliasSD2)->D2_TOTAL})
		Endif 
	Endif			
	(cAliasSD2)->(dbskip())
EndDo
	
For nX := 1 To Len(aReg56S)
	nPos	:=	aScan (aReg56, {|x| x[6]==aReg56S[nX][6] .And.  x[7] ==aReg56S[nX][7]})
	If nPos  > 0
		aReg56[npos,08] += aReg56s[nX,08]
		aReg56[npos,09] += aReg56s[nX,09]
	Else
		aAdd(aReg56, aReg56S[nX])
	Endif
Next nX

For nX := 1 To Len(aReg56)
	if nReg > 9999
		exit
	endif
	cRegistro   := aReg56[nX,01]	// Tipo
	cRegistro   += aReg56[nX,02]   	//Reservado
	cRegistro   += a975Fill(strzero(nReg,4,0),04)   //Sequencial
	cRegistro   += aReg56[nX,03]   	//CNPJ do Contribuinte
	cRegistro   += aReg56[nX,04] 	//0105 - Ano Calendario
	cRegistro   += aReg56[nX,05]	//0106 - Declaracao Retificadora
	cRegistro   += aReg56[nX,06]	//CNPJ do Produto/Vendedor
	cRegistro   += aReg56[nX,07]   //Codigo NCM
	cRegistro   += a975Fill(a975Num2Chr(AReg56[nX,08],14,2),14)  //Valor da Compra
	cRegistro   += a975Fill(a975Num2Chr(AReg56[nX,09],14,2),14)	//Valor da Exportacao
	cRegistro   += a975Fill(,10) 	//Filler
	cRegistro 	:= a975Fill( cRegistro,84)
	A975Grava(cRegistro)
	nReg++
Next nX

If !lQuery
	RetIndex("SD2")
	dbClearFilter()
	Ferase(cIndex+OrdBagExt())
Else
	dbSelectArea(cAliasSD2)
	dbCloseArea()
Endif

RestArea(aArea)
		
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R60   ºAutor  ³Juliana Taveira     º Data ³  19/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Identificacao de socios ou titular                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R60()
Local cRegistro
Local cSocio := ""
Local aSocio := {}
Local cNum   := "0001"
Local cCPFRepLeg	:= "           "
Local cQuaRepLeg	:= " "

SX6->(DbSetOrder(1))
If SX6->(DbSeek(xFilial("SX6")+"MV_REGSOC"))
	Do While !SX6->(Eof ()) .And. xFilial("SX6") == SX6->X6_FIL .And. "MV_REGSOC"$SX6->X6_VAR
		If !Empty(SX6->X6_CONTEUD)
			cSocio := AllTrim(SX6->X6_CONTEUD)
			aSocio := Iif(Len(&(cSocio)) < 6, {}, &(cSocio))          
			If len(aSocio) == 8
				cCPFRepLeg	:= aSocio[7]
				cQuaRepLeg	:= aSocio[8]
			Endif			
			If (len(aSocio) == 6) .Or. (len(aSocio) == 8)
				cRegistro   := a975Fill("R60",03) 								// Tipo
				cRegistro   += a975Fill(,01) 										// Reservado
				cRegistro   += a975Fill(cNum,04) 								// Sequencial do socio
				cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
				nPos        := Ascan(aListBox,{|x| "0105"$x })
				cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
				nPos        := Ascan(aListBox,{|x| "0106"$x })
				cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
				cRegistro   += a975Fill(A975Num2Chr(val(aSocio[1]),3,0),03) //Pais
				cRegistro   += a975Fill(A975Num2Chr(val(aSocio[2]),2,0),02) //Pessoa fisica/Juridica
				cRegistro   += a975Fill(aSocio[3],14) //CPF/CNPJ
				cRegistro   += a975Fill(aSocio[4],150) //Nome empresarial
				cRegistro   += a975Fill(A975Num2Chr(val(aSocio[5]),2,0),02) //Qualificacao
				cRegistro   += a975Fill(A975Num2Chr(val(aSocio[6]),5,2),05) //Perc s/ capital total
				cRegistro   += Replicate("0",5)  			 	//Perc s/ capital volante
				cRegistro   += a975Fill(cCPFRepLeg,11) 		//CPF representante legal
				cRegistro   += a975Fill(cQuaRepLeg,1) 	 		//Qualificacao representante legal
				cRegistro   += Replicate("0",48) 				//Reservado
				cRegistro   += a975Fill(,10) 	 					//Filler
				cRegistro := a975Fill( cRegistro,275)
			EndIf
		EndIf
		SX6->(DbSkip ())
		If !Empty(cRegistro)
			a975Grava(cRegistro)
			cNum   := Soma1(cNum)
		EndIf
	EndDo
EndIf
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R67A  ºAutor  ³Juliana Taveira     º Data ³  19/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Outras informacoes				                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R67A()

Local cRegistro

cRegistro   := a975Fill("R67",03) // Tipo
cRegistro   += a975Fill("A",01) // Reservado
cRegistro   += a975Fill(A975Num2Chr(00,2,0),02) //Trimestre
cRegistro   += a975Fill(A975Num2Chr(01,2,0),02) //Coluna
cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
nPos        := Ascan(aListBox,{|x| "0105"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
nPos        := Ascan(aListBox,{|x| "0106"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
cRegistro   += Replicate("0",14) //lei 11.196/2005 art 31
cRegistro   += Replicate("0",14) //doacao fundo da crianca e do adolescente
cRegistro   += Replicate("0",14) //Doação aos Fundos Nacional, Estaduais ou Municipais do Idoso (Lei nº 12.213/2010, art. 3º)
cRegistro   += Replicate("0",14) //base de calculo negativa CSLL - Geral
cRegistro   += Replicate("0",14) //base de calculo negativa CSLL - Rural
cRegistro   += Replicate("0",14) //Aquisicao ativo imobilizado
cRegistro   += Replicate("0",14) //baixas do ativo imobilizado
cRegistro   += Replicate("0",14) //lei 11.051/2004 - inicio periodo
cRegistro   += Replicate("0",14) //lei 11.051/2004 - fim periodo
cRegistro   += Replicate("0",14) //saldo de creditos de CSLL depreciacao - inicio periodo
cRegistro   += Replicate("0",14) //lei 10.637/2002 art 36
//cRegistro   += Replicate("0",14) //Receita e Rendimento não tributaveis ou Tributados exclusivamente na fonte
cRegistro   += Replicate("0",14) //lei 12.350/2010 art12
cRegistro   += Replicate("0",14) //lei 11.774/2008 
cRegistro   += Replicate("0",4)  //aliquota reduzida - lei 11.774/2008
cRegistro   += Replicate("0",3)  //total SCP
//nPos        := Ascan(aListBox,{|x| "6701"$x })
//cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Escrituracao em meio magnetico
nPos        := Ascan(aListBox,{|x| "6702"$x })
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Alteracao de capital conf art 22 e 23 da lei 9.249/1995
nPos        := Ascan(aListBox,{|x| "6703"$x })    	
cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Opcao pela escrituracao no ativo, da base de calculo negativa da CSLL
cRegistro   += Replicate("0",1)  //Metodo de avaliacao dos estoques
cRegistro   += a975Fill(,10)  //Filler
cRegistro 	:= a975Fill( cRegistro,226)
a975Grava(cRegistro)
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R70   ºAutor  ³Natalia Antonucci   º Data ³  05/08/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Informações Previdenciárias.                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R70(aEmpresa) 

Local cFil70 	:= FWCodFil()
Local nPos 		:= 0
Local cRegistro   
Local aFicha70	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg70 	:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
    cFilAnt := aEmpresa[nX][3]
	aFicha70 := GetSldPlGer(mv_par17, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
    If lFirst     
    	aReg70 := aClone(aFicha70)
        lFirst  := .F.
    Else    
		For nY:= 1 To Len(aFicha70) 
	    	If  nCont <= 35
	    		AReg70[nY][4] += aFicha70[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next nY    
    EndIf
Next nX

If len(AReg70) > 0
	cRegistro   := a975Fill("R70",03) // Tipo
	cRegistro   += a975Fill(,01)     // Reservado
	cRegistro   += a975Fill("00",02) // Trimestre
	cRegistro   += a975Fill("01",02) // Coluna	
	cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos        := Ascan(aListBox,{|x| "0105"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos        := Ascan(aListBox,{|x| "0106"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	nPos        := Ascan(aListBox,{|x| "7008"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Entidade
	nPos        := Ascan(aListBox,{|x| "7009"$x })
	cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //PJ sujeita a contribuição previdenciaria
	cRegistro   += a975Fill(A975Num2Chr(AReg70[1][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[2][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[3][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[4][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[5][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[6][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[7][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[8][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[9][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[10][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[11][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[12][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[13][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[14][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[15][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[16][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[17][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[18][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[19][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[20][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[21][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[22][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[23][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[24][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[25][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[26][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[27][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[28][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[29][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[30][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[31][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[32][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[33][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[34][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[35][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[36][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[37][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[38][4],14),14)
	cRegistro   += a975Fill(A975Num2Chr(AReg70[39][4],14),14)
	cRegistro   += a975Fill(,10) 	 
	cRegistro 	:= a975Fill( cRegistro,566) 
	a975Grava(cRegistro)
Endif                                     

cFilAnt := cFil70	

Return()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975TRAILLER ³Autor ³ Andreia dos Santos  ³ Data ³ 31/08/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Trailler da Declaracao - Tipo T9.                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975TRAILLER()

Local cRegistro

cRegistro   := a975Fill("T9",02)             // Tipo
cRegistro   += a975Fill(,100)                // Reservado

a975Grava(cRegistro)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975Digit ³ Autor ³     Marcos Simidu     ³ Data ³ 10.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna apenas caracteres numericos.                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975Digit(cCampo)
Local cRetorno	:=	Space(0)
LOCAL i:=1

For i:=1 To Len(cCampo)
	If IsDigit(Subs(cCampo,i,1))
		cRetorno+=Subs(cCampo,i,1)
	Endif
Next

Return(cRetorno)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975Fill     ³Autor ³ Andreia dos Santos  ³ Data ³ 30/08/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Encaixa conteudo em espaco especificado                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function a975Fill(cConteudo,nTam)

cConteudo	:=If(cConteudo==NIL,"",cConteudo)
If Len(cConteudo)>nTam
	cRetorno	:=	Substr(cConteudo,1,nTam)
Else
	cRetorno	:=	cConteudo+Space(nTam-Len(cConteudo))
Endif

Return (cRetorno)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975Num2Chr  ³Autor ³ Juan Jos‚ Pereira   ³ Data ³ 30/01/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Converte numerico para formato binario                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975Num2Chr(nValor,nTam,nDec)

Local nInteiro
LOCAL nDecimal
LOCAL cInteiro
LOCAL cDecimal
LOCAL cValor

nDec	:=	If(nDec==NIL,2,nDec)

nInteiro	:=	Int(nValor)
nDecimal	:=	Abs(nValor-nInteiro)
nDecimal    :=  Round(nDecimal,2)
cInteiro	:=	StrZero(nInteiro,nTam-nDec)
cDecimal	:=	StrZero(nDecimal*(10^nDec),nDec)

cValor	:=	cInteiro+cDecimal 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Alteracao  para quando o valor retornado for uma string e com os caracteres **  converter para numerico e formato binario.³
//³Chamado(THKZXL)                                                                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If "*" $ cValor
   nValor := Val(Alltrim(Str(nValor)))
   cValor := A975Num2Chr(nValor,nTam,nDec)
Endif 


Return (cValor)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ A975Resumo     ³ Autor ³ Andreia dos Santos³Data³ 15.03.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Monta o resumo das entradas e saidas retornando os arrays  ³±±
±±³          ³ aEnt e aSai.                                               ³±±
±±³          ³ Preenche o arquivo cArqDest com os dados dos REMETENTES/   ³±±
±±³          ³ DESTINATARIOS.                                             ³±±
±±³          ³ Preenche o arquivo cArqMerc com os dados das Mercadorias   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975Resumo(cArqDado,cArqRem,cArqMerc,cPrdAcum,aEnt,aSai,aFilsCalc)

Local cTipoMov   :=""
Local cCgcBusca  :=""
Local cAliasSF3  :=""
Local l975Filtra := (existblock("A975FILT"))	
Local cCfos      :=""	
Local cMvDipiCFO   :=SuperGetMv("MV_DIPICFO")
Local cDipiCFO     :=""
Local nCFO         :=0
Local cCfoEnt	   :=""
Local cCfoSai	   :=""
Local cAno         := StrZero(Mv_Par03,4)
Local cSeek		:= ""
Local cConcatena	:=	""

#IFDEF TOP
	Local cQuery	:=""
	Local aStruSf3	:={}
	Local nX		:=0	
#ENDIF

DbSelectArea ("SX6")
SX6->(DbSeek (xFilial ("SX6")+"MV_DIPICF0"))
Do While !SX6->(Eof ()) .And. xFilial ("SX6")==SX6->X6_FIL .And. "MV_DIPICF"$SX6->X6_VAR
	cConcatena	:=	AllTrim (SX6->X6_CONTEUD)
	If !Empty (cConcatena)
		If SubStr (cMvDipiCFO, Len (cMvDipiCFO), 1)$"\/#*"
			If SubStr (cConcatena, 1, 1)$"\/#*"
				cMvDipiCFO	+=	SubStr (cConcatena, 2)
			Else
				cMvDipiCFO	+=	cConcatena
			EndIf
		Else
			If SubStr (cConcatena, 1, 1)$"\/#*"
				cMvDipiCFO	+=	cConcatena
			Else
				cMvDipiCFO	+=	"/"+cConcatena
			EndIf
		EndIf
	EndIf
	//
	SX6->(DbSkip ())
EndDo
	
dbSelectArea(cArqDado)
dbGotop()

While (cArqDado)->(!Eof())

	cTipoMov	:=TIPOMOV	
	cChave	    :=DTOS(DT_ENTRADA)+NOTA+SERIE+CLIFOR+LOJA
    dData       :=DTOS(CTOD("//"))
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Prepara arquivo de remententes e entradas de Mercadorias     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(cArqDado)
	While !Eof().and.cTipoMov+cChave==TIPOMOV+DTOS(DT_ENTRADA)+NOTA+SERIE+CLIFOR+LOJA

        If (cArqDado)->TIPO$"D"
            dbSkip()
			Loop
		Endif

		If cAno<"2003"
	       cCfos :="111/112/113/121/122/171/172/175/176/182/185/186/193/199/211/212/"
	       cCfos +="213/221/222/271/272/275/276/285/286/293/299/311/312/394/399/511/"
	       cCfos +="512/513/514/515/516/517/521/522/525/526/571/572/573/574/575/576/"
	       cCfos +="581/585/586/587/588/589/593/596/597/599/611/612/613/614/615/616/"
	       cCfos +="617/618/619/621/622/625/626/671/672/673/674/675/676/685/686/687/"
	       cCfos +="688/689/693/696/697/699/711/712/716/717/799/174/274/197/297"
     
           cDipiCFO :=cMvDipiCFO
           For nCfo=1 TO Len(cDipiCFO)
               cCfos +="/"+Subs(cDipiCFO,AT("-",cDipiCFO)+1,3)
    	       cDipiCFO :=Subs(cDipiCFO,AT("-",cDipiCFO)+4,Len(cDipiCFO))
    	       If Empty(cDipiCFO)
    	          Exit
    	       Endif
    	   Next    

           If !(SubStr(ALLTRIM(CFO),1,3)$ cCfos)
              dbSkip()
		      Loop
		   Endif		   		   
		Else	
			//Ficha 23 - Remetentes de Insumos/Mercadorias, Ficha 24 - Entradas de Insumos/Mercadorias e Ficha 56- Detalhamento das Exportações da Comercial Exportadora
			cCfos	:=	"1101/1102/1111/1113/1116/1117/1118/1120/1121/1122/1124/1125/1126/1151/1152/1154/1401/1403/1408/1409/1410/1411/1414/1415/1501/1503/1504/1901/1902/1903/1904/1905/1906/1907/1908/1909/1910/1911/1912/1913/1914/1915/1916/1917/1918/1919/1920/1921/1922/1923/1924/1925/1926/1949/2101/2102/2111/2113/2116/2117/2118/2120/2121/2122/2124/2125/2126/2151/2152/2154/2401/2403/2408/2409/2410/2411/2414/2415/2501/2503/2504/2901/2902/2903/2904/2905/2906/2907/2908/2909/2910/2911/2912/2913/2914/2915/2916/2917/2918/2919/2920/2921/2922/2923/2924/2925/2949/3101/3102/3126/3127/3503/3949"
            //Ficha 25 - Destinatários de Produtos/Mercadorias/Insumos, Ficha 26 - Saídas de Produtos/Mercadorias/Insumos e Ficha 55 - Vendas a Comercial Exportadora com Fim Específico de Exportação 
			cCfos	+=	"5101/5102/5103/5104/5105/5106/5109/5110/5111/5112/5113/5114/5115/5116/5117/5118/5119/5120/5122/5123/5124/5125/5151/5152/5155/5156/5401/5402/5403/5405/5408/5409/5414/5415/5501/5502/5503/5901/5902/5903/5904/5905/5906/5907/5908/5909/5910/5911/5912/5913/5914/5915/5916/5917/5918/5919/5920/5921/5922/5923/5924/5925/5949/6101/6102/6103/6104/6105/6106/6107/6108/6109/6110/6111/6112/6113/6114/6115/6116/6117/6118/6119/6120/6122/6123/6124/6125/6151/6152/6155/6156/6401/6402/6403/6404/6408/6409/6501/6502/6503/6505/6901/6902/6903/6904/6905/6906/6907/6908/6909/6910/6911/6912/6913/6914/6915/6916/6917/6918/6919/6920/6921/6922/6923/6924/6925/6949/7101/7102/7105/7106/7127/7501/7949" 

			If !(SubStr(ALLTRIM(CFO),1,4)$ cCfos)
	   			If !("2100-"+SubStr(ALLTRIM(CFO),1,4)$cMvDipiCFO .Or. "2200-"+SubStr(ALLTRIM(CFO),1,4)$cMvDipiCFO)
		              dbSkip()
					  Loop
			   	Endif
			EndIf
        Endif
				
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Este ponto de entrada permite um determinado registro possa   ³
		//³ser filtrado para a geracao das pastas 25 e 26.               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		if	l975Filtra		
			if ExecBlock("A975FILT",.F.,.F.)
			   dbskip()
			   loop
			EndIf
		EndIf						   
		//REMETENTES/DESTINATARIOS
		dbSelectArea(cArqRem) 
		If (cArqDado)->TIPOCLIFOR == "X"
			cCgcBusca	:= Repl("0",14)
			cSeek		:= (cArqDado)->TIPOMOV+(cArqDado)->CLIFOR+(cArqDado)->LOJA
			dbSetOrder(1)
		Else
			cCgcBusca	:= (cArqDado)->CGC
			cSeek		:= (cArqDado)->TIPOMOV+(cArqDado)->CGC
			dbSetOrder(3)
		Endif
			
		If dbSeek(cSeek)
			RecLock(cArqRem,.F.)
		Else
			RecLock(cArqRem,.T.)		
			(cArqRem)->TIPO	:= (cArqDado)->TIPOMOV
			(cArqRem)->CGC  	:= cCgcBusca
			(cArqRem)->CODIGO:= (cArqDado)->CLIFOR
			(cArqRem)->LOJA	:= (cArqDado)->LOJA
			(cArqRem)->NOME	:= (cArqDado)->NOME
		Endif                      
		(cArqRem)->VALOR 		+= (cArqDado)->VMERCAD
		(cArqRem)->AUXILIAR 	:= StrZero(100000000000000.00-(cArqRem)->VALOR,20,2)
		MsUnlock()
		//MERCADORIAS	
		dbSelectArea(cArqMerc)  
		If dbSeek((cArqDado)->TIPOMOV + (cArqDado)->NBM + (cArqDado)->DESCPROD + (cArqDado)->CGC)
			RecLock(cArqMerc,.F.)
		Else
			RecLock(cArqMerc,.T.)	
			(cArqMerc)->TIPO		:= (cArqDado)->TIPOMOV	
			(cArqMerc)->NBM  		:= (cArqDado)->NBM
			(cArqMerc)->MERCAD 	:= (cArqDado)->DESCPROD
			(cArqMerc)->CODIGO 	:= (cArqDado)->PRODUTO
			(cArqMerc)->EX			:= ""
			(cArqMerc)->CFO		:= (cArqDado)->CFO  
			(cArqMerc)->NOTA		:= (cArqDado)->NOTA 
			(cArqMerc)->SERIE		:= (cArqDado)->SERIE 
			(cArqMerc)->CLIFOR	:= (cArqDado)->CLIFOR 
			(cArqMerc)->LOJA 		:= (cArqDado)->LOJA 
			(cArqMerc)->CGC  		:= cCgcBusca
		Endif
		(cArqMerc)->VALOR 		+= (cArqDado)->VALMERC
		(cArqMerc)->AUXILIAR 	:= StrZero(100000000000000.00-(cArqMerc)->VALOR,20,2)
		MsUnlock()                                                                    
		//MERCADORIAS ACUMULADO
		dbSelectArea(cPrdAcum)  
		If dbSeek((cArqDado)->TIPOMOV + (cArqDado)->NBM + (cArqDado)->PRODUTO + (cArqDado)->DESCPROD)
			RecLock(cPrdAcum,.F.)
		Else
			RecLock(cPrdAcum,.T.)	
			(cPrdAcum)->TIPO		:= (cArqDado)->TIPOMOV	
			(cPrdAcum)->NBM  		:= (cArqDado)->NBM
			(cPrdAcum)->MERCAD 	:= (cArqDado)->DESCPROD
			(cPrdAcum)->CODIGO 	:= (cArqDado)->PRODUTO
			(cPrdAcum)->CGC  		:= cCgcBusca
			(cPrdAcum)->EX			:= ""
		Endif
		(cPrdAcum)->VALOR 		+= (cArqDado)->VALMERC
		(cPrdAcum)->AUXILIAR 	:= StrZero(100000000000000.00-(cPrdAcum)->VALOR,20,2)
		MsUnlock()                                                                    		
		
		dbSelectArea(cArqDado)
		dbSkip()
	EndDo	
EndDo

cAliasSF3 := "AliasSF3"
aStruSF3  := SF3->(dbStruct())

cQuery    := "SELECT F3_CFO, SUM(F3_BASEIPI) AS F3_BASEIPI, SUM(F3_ISENIPI) AS F3_ISENIPI, SUM(F3_OUTRIPI) AS F3_OUTRIPI, SUM(F3_VALIPI) AS F3_VALIPI "
cQuery    +=   "FROM "+RetSqlName("SF3")+" SF3 "
cQuery    +=  "WHERE SF3.D_E_L_E_T_=' ' AND SF3.F3_FILIAL='"+xFilial("SF3")+"' AND SF3.F3_ENTRADA BETWEEN  '" + StrZero(mv_par03, 4) + StrZero(mv_par01, 2) + "01' and '" + StrZero(mv_par03, 4) + StrZero(mv_par02, 2) + "31' "
cQuery    +=    "AND SF3.F3_DTCANC = ' ' "
cQuery    += "GROUP BY F3_CFO"

cQuery    := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSF3,.T.,.T.)

For nX := 1 To Len(aStruSF3)
	If ( aStruSF3[nX][2] <> "C" )
		TcSetField(cAliasSF3,aStruSF3[nX][1],aStruSF3[nX][2],aStruSF3[nX][3],aStruSF3[nX][4])
	EndIf
Next nX

While !Eof() 

	Do Case
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 21/01.Insumos para Industrializacao                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"111/121/171/211/221/271" .OR. "2101-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"1101/1111/1116/1120/1122/1151/1401/1408/2101/2111/2116/2120/2122/2151/2401/2408/" .OR. "2101-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aEnt[1,1]	+= (cAliasSF3)->F3_BASEIPI 
			aEnt[1,2]	+= ((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)         
			aEnt[1,3]	+= (cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 21/02.Mercadoria para comercializacao                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"112/122/172/212/222/272" .OR. "2102-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"1102/1113/1117/1118/1121/1152/1403/1409/2102/2113/2117/2118/2121/2152/2403/2409/" .OR. "2102-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aEnt[2,1] 	+= (cAliasSF3)->F3_BASEIPI 
			aEnt[2,2] 	+= ((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)         
			aEnt[2,3]	+= (cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 21/03.Entradas de Mercadorias - Industrializacao Efetuada por Outras Empresas ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"113/213" .OR. "2103-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"1124/1125/2124/2125" .OR. "2103-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aEnt[3,1]	+= (cAliasSF3)->F3_BASEIPI
			aEnt[3,2]  	+= ((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)         
			aEnt[3,3]  	+= (cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 21/04.Devolucao de Vendas                                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"131/132/177/178/231/232/235/277/278" .OR. "2104-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"1201/1202/1203/1204/1208/1209/1410/1411/1918/1919/2201/2202/2203/2204/2208/2209/2410/2411/2918/2919/" .OR. "2104-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aEnt[4,1]	+= (cAliasSF3)->F3_BASEIPI
			aEnt[4,2]  	+= ((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
			aEnt[4,3]  	+= (cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³21/05. Outras entradas                                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"114/123/124/133/134/142/143/144/151/152/153/154/155/161/162/163/164/165/170/173/174/175/176/179/182/185/186/191/192/193/194/195/196/197/198/199/214/224/233/234/242/243/244/251/252/253/254/255/261/262/263/264/265/270/273/274/275/276/279/285/286/291/292/293/294/295/296/297/298/299174/274/197/297" .OR. "2105-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"1991/1999/2991/2999" .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"1126/1154/1207/1252/1256/1302/1352/1356/1406/1407/1414/1415/1452/1501/1503/1504/1505/1506/1551/1552/1553/1554/1555/1556/1557/1601/1602/1603/1653/1658/1660/1662/1901/1902/1903/1904/1905/1906/1907/1908/1909/1910/1911/1912/1913/1914/1915/1916/1917/1920/1921/1922/1923/1924/1925/1926/1949/2126/2154/2252/2256/2302/2352/2356/2406/2407/2414/2415/2501/2503/2504/2505/2506/2551/2552/2553/2554/2555/2556/2557/2651/2653/2658/2660/2662/2901/2902/2903/2904/2905/2906/2907/2908/2909/2910/2911/2912/2913/2914/2915/2916/2917/2920/2921/2922/2923/2924/2925/2949" .OR. "2105-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aEnt[5,1] 	+= (cAliasSF3)->F3_BASEIPI 
			aEnt[5,2] 	+= ((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
			aEnt[5,3]  	+= (cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³21/07. Insumos para Industrializacao                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)=="311" .OR. "2107-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"3101/3127" .OR. "2107-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aEnt[6,1]	+= (cAliasSF3)->F3_BASEIPI
			aEnt[6,2] 	+= ((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
			aEnt[6,3] 	+= (cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 21/08.Mercadoria para comercializacao                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)=="312" .OR. "2108-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)=="3102" .OR. "2108-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aEnt[7,1]  	+= (cAliasSF3)->F3_BASEIPI
			aEnt[7,2]  	+= ((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
			aEnt[7,3] 	+= (cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 21/09.Devolucao de Vendas  do mercado externo                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"321/322" .OR. "2109-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"3201/3202/3211/3503/3553" .OR. "2109-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aEnt[8,1] 	+= (cAliasSF3)->F3_BASEIPI 
			aEnt[8,2] 	+= ((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
			aEnt[8,3] 	+= (cAliasSF3)->F3_VALIPI
 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 21/10.Outras Entradas                                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"313/323/324/341/351/352/353/354/391/394/397/399" .OR. "2110-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"3126/3352/3356/3551/3556/3651/3653/3930/3949" .OR. "2110-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aEnt[9,1]  	+= (cAliasSF3)->F3_BASEIPI 
			aEnt[9,2]  	+= ((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
			aEnt[9,3]	+= (cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Saidas do Mercado Nacional                                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³22/01. Producao do estabelecimento                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"511/514/516/521/525/571/572/611/614/616/618/621/625/671/672" .OR. "2201-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"5101/5103/5105/5109/5111/5113/5116/5118/5122/5151/5155/5401/5402/5408/5501/5904/6101/6103/6105/6107/6109/6111/6113/6116/6118/6122/6151/6155/6401/6402/6408/6501/6904" .OR. "2201-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aSai[1,1]  	+= (cAliasSF3)->F3_BASEIPI 
			aSai[1,2]  	+=((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
			aSai[1,3]	+= (cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 22/02.Mercadoria adquirida ou recebida para comercializacao  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"512/515/517/522/526/573/574/612/615/617/619/622/626/673/674" .OR. "2202-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"5102/5104/5106/5110/5112/5114/5115/5117/5119/5120/5123/5152/5156/5403/5405/5409/5502/6102/6104/6106/6108/6110/6114/6115/6117/6119/6120/6123/6152/6156/6403/6404/6409/6502" .OR. "2202-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aSai[2,1]	+=	(cAliasSF3)->F3_BASEIPI 
			aSai[2,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
			aSai[2,3] 	+= (cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 22/03.Industrializacao efetuada por Outras Empresas          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"513/613" .OR. "2203-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"5124/5125/6124/6125" .OR. "2203-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aSai[3,1]	+=	(cAliasSF3)->F3_BASEIPI 
			aSai[3,2]	+=	(cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI
			aSai[3,3] 	+=	(cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 22/04.Devolucoes de compras			                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"531/532/577/578/631/632/635/677/678" .OR. "2204-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"5201/5202/5206/5207/5208/5209/5210/5410/5411/5412/5413/5503/5553/5555/5556/5918/5919/6201/6202/6206/6208/6209/6210/6410/6411/6412/6413/6503/6553/6555/6556/6918/6919" .OR. "2204-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aSai[4,1]	+=	(cAliasSF3)->F3_BASEIPI 
			aSai[4,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
			aSai[4,3] 	+=	(cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 22/05.Outras Saidas Mercado Nacional	                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"523/524/533/534/542/543/544/545/551/552/553/561/562/563/570/575/576/579/581/585/586/587/588/589/591/592/593/594/595/596/597/599/623/624/633/634/642/643/644/645/651/652/653/661/662/663/670/675/676/679/685/686/687/688/689/691/692/693/694/695/696/697/699" .OR. "2205-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"5991/5999/6991/6999" .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"5205/5252/5256/5352/5356/5414/5415/5451/5504/5505/5551/5552/5554/5557/5651/5652/5653/5654/5656/5658/5659/5660/5662/5901/5902/5903/5905/5906/5907/5908/5909/5910/5911/5912/5913/5914/5915/5916/5917/5920/5921/5922/5923/5924/5925/5926/5927/5928/5929/5949/6112/6153/6205/6207/6252/6256/6352/6356/6359/6414/6415/6504/6505/6551/6552/6554/6557/6651/6652/6653/6654/6656/6658/6659/6660/6661/6662/6901/6902/6903/6905/6906/6907/6908/6909/6910/6911/6912/6913/6914/6915/6916/6917/6920/6921/6922/6923/6924/6925/6949" .OR. "2205-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aSai[5,1]	+=	(cAliasSF3)->F3_BASEIPI
			aSai[5,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
			aSai[5,3]	+= (cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Saidas para o mercado externo                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 22/07.Producao do estabelecimento	                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"711/716" .OR. "2207-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"7101/7105/7127/7501" .OR. "2207-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aSai[6,1]	+=	(cAliasSF3)->F3_BASEIPI
			aSai[6,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
			aSai[6,3]	+= (cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 22/08.Mercadoria adquirida ou recebida para comercializacao  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"712/717" .OR. "2208-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"7102/7106" .OR. "2208-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aSai[7,1]	+=	(cAliasSF3)->F3_BASEIPI
			aSai[7,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
			aSai[7,3]	+= (cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 22/09.Devolucoes de Compras                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"731/732" .OR. "2209-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"7201/7202/7210/7211/7553/7556/7930" .OR. "2209-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aSai[8,1]	+=	(cAliasSF3)->F3_BASEIPI
			aSai[8,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
			aSai[8,3]	+= (cAliasSF3)->F3_VALIPI

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 22/10.Outras Exportacao                                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            Case (cAno<"2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$"733/734/741/751/761/799" .OR. "2210-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO) .Or. ;
            	(cAno>="2003" .And. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"7206/7207/7551/7651/7949" .OR. "2210-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO)
			aSai[9,1]	+=	(cAliasSF3)->F3_BASEIPI
			aSai[9,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
			aSai[9,3]	+= (cAliasSF3)->F3_VALIPI
	EndCase

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Totalizador                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If substr((cAliasSF3)->F3_CFO,1,1)<"5"
	   If cAno<"2003"
	      cCfoEnt :="111/121/171/211/221/271/112/122/172/212/222/272/235/277/278/"
	      cCfoEnt +="113/213/131/132/177/178/231/232/151/152/153/154/155/161/162/"
	      cCfoEnt +="114/123/124/133/134/142/143/144/179/182/185/186/191/192/193/"
	      cCfoEnt +="163/164/165/170/173/174/175/176/194/195/196/197/198/199/214/"
	      cCfoEnt +="233/234/242/243/244/251/252/253/254/255/261/262/263/264/265/"
	      cCfoEnt +="291/292/293/294/295/296/297/298/299/224/270/273/274/275/276/"
	      cCfoEnt +="279/285/286/174/274/197/297"
              IF SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cCfoEnt;
                 .OR. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"1991/1999/2991/2999";
              	 .OR. "2101-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;
              	 .OR. "2102-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;
		  	 .OR. "2103-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;
              	 .OR. "2104-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;
		  	 .OR. "2105-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;              
		  	 .OR. "2107-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;			  
		  	 .OR. "2108-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;			  
		  	 .OR. "2109-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;			  
		  	 .OR. "2110-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO			  			  
     	      	 aEnt[10,1]	+=	(cAliasSF3)->F3_BASEIPI
		  	 aEnt[10,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI) 
		  	 aEnt[10,3]	+=	(cAliasSF3)->F3_VALIPI
	   	  ELSE
  			     aEnt[11,1]	+=	(cAliasSF3)->F3_BASEIPI
		     aEnt[11,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
		     aEnt[11,3]	+=	(cAliasSF3)->F3_VALIPI
	   	  ENDIF   
	   Else
		  cCfoEnt :="1101/1111/1116/1120/1122/1151/1401/1408/2101/2111/2116/2120/2122/2151/2401/2408/"
		  cCfoEnt +="1102/1113/1117/1118/1121/1152/1403/1409/2102/2113/2117/2118/2121/2152/2403/2409/"
		  cCfoEnt +="1124/1125/2124/2125/"
		  cCfoEnt +="1201/1202/1203/1204/1208/1209/1410/1411/1918/1919/2201/2202/2203/2204/2208/2209/2410/2411/2918/2919/"
		  cCfoEnt +="1126/1154/1207/1252/1256/1302/1352/1356/1406/1407/1414/1415/1452/1501/1503/1504/1505/1506/1551/1552/1553/1554/1555/1556/1557/1601/1602/1603/1653/1658/1660/1662/1901/1902/1903/1904/1905/1906/1907/1908/1909/1910/1911/1912/1913/1914/1915/1916/1917/1920/1921/1922/1923/1924/1925/1926/1949/2126/2154/2252/2256/2302/2352/2356/2406/2407/2414/2415/2501/2503/2504/2505/2506/2551/2552/2553/2554/2555/2556/2557/2651/2653/2658/2660/2662/2901/2902/2903/2904/2905/2906/2907/2908/2909/2910/2911/2912/2913/2914/2915/2916/2917/2920/2921/2922/2923/2924/2925/2949/"
		  cCfoEnt +="3101/3127/"
		  cCfoEnt +="3102/"
		  cCfoEnt +="3201/3202/3211/3503/3553/"
		  cCfoEnt +="3126/3352/3356/3551/3556/3651/3653/3930/3949/"
              IF SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cCfoEnt;
                 .OR. "2101-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;
                 .OR. "2102-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;
		     .OR. "2103-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;
                 .OR. "2104-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;
		     .OR. "2105-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;              
		     .OR. "2107-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;			  
		     .OR. "2108-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;			  
		     .OR. "2109-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;			  
		     .OR. "2110-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO			  			  
     	         aEnt[10,1]	+=	(cAliasSF3)->F3_BASEIPI
		     aEnt[10,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI) 
		     aEnt[10,3]	+=	(cAliasSF3)->F3_VALIPI
	      ELSE
  			     aEnt[11,1]	+=	(cAliasSF3)->F3_BASEIPI
		     aEnt[11,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
		     aEnt[11,3]	+=	(cAliasSF3)->F3_VALIPI
	      ENDIF   
	   Endif
	Else                 
	   If cAno<"2003"
	  	  cCfoSai :="511/514/516/521/525/571/572/611/614/616/618/621/625/671/672/"
		  cCfoSai +="512/515/517/522/526/573/574/612/615/617/619/622/626/673/579/"
		  cCfoSai +="674/513/613/531/532/577/578/631/632/635/677/678/523/524/533/"
		  cCfoSai +="534/542/543/544/545/551/552/553/561/562/563/570/575/576/581/"
		  cCfoSai +="593/594/595/596/597/599/623/624/633/634/642/643/644/645/651/"
		  cCfoSai +="679/685/686/687/688/689/691/692/693/694/695/696/697/699/711/" 
		  cCfoSai +="712/717/731/732/733/734/741/751/761/799/585/586/587/588/589/"
		  cCfoSai +="652/653/661/662/663/670/675/676/716/591/592"
              IF ALLTRIM((cAliasSF3)->F3_CFO)$ cCfoSai;
                 .OR. SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$"5991/5999/6991/6999";
		     .OR. "2201-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;
		     .OR. "2202-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;			  
	 	     .OR. "2203-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;			  
		     .OR. "2204-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;			  
		     .OR. "2205-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;			  
		     .OR. "2207-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;			  
		     .OR. "2208-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;			  
	  	     .OR. "2209-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO;
		     .OR. "2210-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,3)$cMvDipiCFO			  
		     aSai[10,1]	+=	(cAliasSF3)->F3_BASEIPI
		     aSai[10,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
		     aSai[10,3]	+=	(cAliasSF3)->F3_VALIPI
              ELSE
		     aSai[11,1]	+=	(cAliasSF3)->F3_BASEIPI
		     aSai[11,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
		     aSai[11,3]	+=	(cAliasSF3)->F3_VALIPI
	      ENDIF  
	   Else	
		  cCfoSai :="5101/5103/5105/5109/5111/5113/5116/5118/5122/5151/5155/5401/5402/5408/5501/5904/6101/6103/6105/6107/6109/6111/6113/6116/6118/6122/6151/6155/6401/6402/6408/6501/6904/"
		  cCfoSai +="5102/5104/5106/5110/5112/5114/5115/5117/5119/5120/5123/5152/5156/5403/5405/5409/5502/6102/6104/6106/6108/6110/6114/6115/6117/6119/6120/6123/6152/6156/6403/6404/6409/6501/6502"
		  cCfoSai +="5124/5125/6124/6125/"
		  cCfoSai +="5201/5202/5206/5207/5208/5209/5210/5410/5411/5412/5413/5503/5553/5555/5556/5918/5919/6201/6202/6206/6208/6209/6210/6410/6411/6412/6413/6503/6553/6555/6556/6918/6919/"
		  cCfoSai +="5205/5252/5256/5352/5356/5414/5415/5451/5504/5505/5551/5552/5554/5557/5651/5652/5653/5654/5656/5658/5659/5660/5662/5901/5902/5903/5905/5906/5907/5908/5909/5910/5911/5912/5913/5914/5915/5916/5917/5920/5921/5922/5923/5924/5925/5926/5927/5928/5929/5949/6112/6153/6205/6207/6252/6256/6352/6356/6359/6414/6415/6504/6505/6551/6552/6554/6557/6651/6652/6653/6654/6656/6658/6659/6660/6661/6662/6901/6902/6903/6905/6906/6907/6908/6909/6910/6911/6912/6913/6914/6915/6916/6917/6920/6921/6922/6923/6924/6925/6949/"
		  cCfoSai +="7101/7105/7127/7501/"
		  cCfoSai +="7102/7106/"
		  cCfoSai +="7201/7202/7210/7211/7553/7556/7930/"
		  cCfoSai +="7206/7207/7551/7651/7949/"
              IF ALLTRIM((cAliasSF3)->F3_CFO)$ cCfoSai;
		     .OR. "2201-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;
		     .OR. "2202-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;
	 	     .OR. "2203-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;			  
		     .OR. "2204-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;			  
		     .OR. "2205-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;			  
		     .OR. "2207-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;			  
		     .OR. "2208-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;			  
	  	     .OR. "2209-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO;
		     .OR. "2210-"+SubStr(ALLTRIM((cAliasSF3)->F3_CFO),1,4)$cMvDipiCFO			  
		     aSai[10,1]	+=	(cAliasSF3)->F3_BASEIPI
		     aSai[10,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
		     aSai[10,3]	+=	(cAliasSF3)->F3_VALIPI
              ELSE
		     aSai[11,1]	+=	(cAliasSF3)->F3_BASEIPI
		     aSai[11,2]	+=	((cAliasSF3)->F3_ISENIPI+(cAliasSF3)->F3_OUTRIPI)
		     aSai[11,3]	+=	(cAliasSF3)->F3_VALIPI
	      ENDIF  
	   Endif
	EndIf	
    (cAliasSF3)->(dbSkip())
EndDo
DbCloseArea()

nValDevVen	:= aEnt[4,3]+aEnt[8,3]

return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A975Moviment³Autor³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cria Arquivo de trabalho com dados das movimentacoes        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A975Moviment(nMesIni,nMesFim,cNrLivro,dDtIni,dDtFim,lAbortPrint,aFilsCalc)

Local cArqTemp     :=""
Local cAliasSD1    :="SD1"
Local cAliasSD2    :="SD2"
Local cCliFor      :=""
Local cLoja        :=""
Local cRazao       :=""
Local cCGC         :=""
Local cTipoCliFor  :=""
Local cProduto     :=""
Local cNBM         :=""
Local cEstado      :=""
Local aTam   	   :=TAMSX3("F3_CFO")
Local aCampos      :={}
Local lIntegracao  := IF(SuperGetMv("MV_EASY")=="S",.T.,.F.)      
#IFDEF TOP
	Local cQuery		:=""
	Local aStruSD1		:={}
	Local aStruSD2		:={}
	Local nX	 		:=0	
	Local cFilBack	:= cFilAnt
	Local nForFilial:= 0
	Default aFilsCalc	:= MatFilCalc(.F.)		// Somente para os casos que não passa o parâmetro
#ENDIF

If lIntegracao
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Abre arquivo SWN apenas nesta rotina                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF !ChkFile("SWN",.F.)
		HELP(" ",1,"SWNEmUso")
		Return(.t.)
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Cria arquivo para armazenar movimentacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aCampos,{"TIPOMOV"		,"C"	,01	,0	})	// "E"ntradas / "S"aidas
AADD(aCampos,{"NOTA"		,"C"	,TamSX3("F2_DOC")[1]	,0	})	// Numero da Nota
AADD(aCampos,{"SERIE"		,"C"	,03	,0	})	// Serie
AADD(aCampos,{"ITEM"		,"C"	,02	,0	})	// Item da Nota
AADD(aCampos,{"TIPO"		,"C"	,01	,0	})	// Tipo da Nota
AADD(aCampos,{"DT_ENTRADA"	,"D"	,08	,0	})	// Data de Entrada
AADD(aCampos,{"DT_EMISSAO"	,"D"	,08	,0	})	// Data de Emissao	
AADD(aCampos,{"CLIFOR"		,"C"	,TamSX3("F3_CLIEFOR")[1] ,0	})	// Cod do Cliente/Fornecedor
AADD(aCampos,{"LOJA"		,"C"	,TamSX3("F3_LOJA")[1]    ,0	})	// Loja
AADD(aCampos,{"NOME"		,"C"	,50	,0	})	// Razao social
AADD(aCampos,{"CGC"			,"C"	,18	,0	})	// CGC
AADD(aCampos,{"UF"			,"C"	,02	,0	})	// UF	
AADD(aCampos,{"TIPOCLIFOR"	,"C"	,01	,0	})	// Tipo do Cliente/Fornecedor
AADD(aCampos,{"PRODUTO"		,"C"	,15	,0	})	// Cod do Produto
AADD(aCampos,{"DESCPROD"	,"C"	,50	,0	})	// Descricao do Produto
AADD(aCampos,{"NBM"			,"C"	,12	,0	})	// Codigo NBM
AADD(aCampos,{"TES"			,"C"	,03	,0	})	// TES
AADD(aCampos,{"CFO"			,"C"	,aTAM[1],0})	// CFO
AADD(aCampos,{"VALMERC"		,"N"	,14	,2	})	// Valor da Mercadoria
AADD(aCampos,{"VALIPI"		,"N"	,14	,2	})	// Valor do IPI
AADD(aCampos,{"VMERCAD"		,"N"	,14	,2	})	// Valor da Mercadoria
cArqTemp	:=	CriaTrab(aCampos)
dbUseArea(.T.,,cArqTemp,cArqTemp,.T.,.F.)
IndRegua(cArqTemp,cArqTemp,"TIPOMOV+SERIE+NOTA+CLIFOR+LOJA",,,STR0088) //"Indexando movimenta‡”es"

If GetNewPar("MV_SB1SFT",.T.)
	SFT->(dbSetOrder(1))
EndIf

#IFDEF TOP
// Loop de Filiais
For nForFilial := 1 to Len( aFilsCalc )
	If !aFilsCalc[ nForFilial, 1 ]
		Loop
	EndIf	
	cFilAnt := aFilsCalc[ nForFilial, 2 ]
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recebe movimentacoes de entradas        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SD1")
dbSetOrder(3)
#IFDEF TOP
    If TcSrvType()<>"AS/400"
       cAliasSD1 := "AliasSD1"
	   aStruSD1  := SD1->(dbStruct())
	   cQuery    := "SELECT * "
	   cQuery    += "FROM "+RetSqlName("SD1")+" SD1 "
	   cQuery    += "WHERE SD1.D1_FILIAL='"+xFilial("SD1")+"' AND "
	   cQuery    += "SD1.D1_DTDIGIT >= '"+DTOS(dDtIni)+"' AND "
	   cQuery    += "SD1.D1_DTDIGIT <= '"+DTOS(dDtFim)+"' AND "
	   cQuery    += "SD1.D_E_L_E_T_=' ' "
	   cQuery    += "ORDER BY "+SqlOrder(SD1->(IndexKey()))
	
	   cQuery    := ChangeQuery(cQuery)
	
	   dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD1,.T.,.T.)
	
	   For nX := 1 To Len(aStruSD1)
		   If ( aStruSD1[nX][2] <> "C" )
			  TcSetField(cAliasSD1,aStruSD1[nX][1],aStruSD1[nX][2],aStruSD1[nX][3],aStruSD1[nX][4])
		   EndIf
	   Next nX
	Else   
#ENDIF
       cAliasSD1 := "SD1"
	   dbSeek(xFilial("SD1"))
       If ProcName(1) == "MATR962" .or. ProcName(1) == "R950IMP"
	      setregua((cAliasSD1)->(LastRec()))
       else
	      ProcRegua((cAliasSD1)->(LastRec()))
       endIf
    #IFDEF TOP
	   Endif   
    #ENDIF

While (!eof().and.(cAliasSD1)->D1_FILIAL==xFilial("SD1"))
	  If Interrupcao(@lAbortPrint)
		 Exit
	  Endif
      #IFNDEF TOP
 	      if ProcName(1) == "MATR962" .or. ProcName(1) == "R950IMP"
		     IncRegua()
	      else	
		     IncProc()
	      EndIf	
	  #ENDIF   
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtragem                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (cAliasSD1)->D1_DTDIGIT<dDtIni.or.(cAliasSD1)->D1_DTDIGIT>dDtFim
		(cAliasSD1)->(dbSkip())
		Loop
	Endif
	SF4->(dbSeek(xFilial("SF4")+(cAliasSD1)->D1_TES))
	If SF4->F4_LFIPI=="N"
		(cAliasSD1)->(dbSkip())
		Loop
	Endif	
	If cNrLivro <> "*"        
		If !(SF4->F4_NRLIVRO==cNrLivro)
			(cAliasSD1)->(dbSkip())
			Loop
		Endif	
	EndIf
	SF1->(dbSetOrder(1))
	SF1->(dbSeek(xFilial("SF1")+(cAliasSD1)->D1_DOC+(cAliasSD1)->D1_SERIE+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA))
	IF lIntegracao .and. SF1->F1_IMPORT == "S" 
		dbSelectArea("SWN")
		dbSetOrder(1)
		SWN->(dbSeek(xFilial()+(cAliasSD1)->D1_DOC+(cAliasSD1)->D1_SERIE+(cAliasSD1)->D1_TEC))
		While SWN->(!EOF()) .and. SWN->WN_FILIAL==xFilial("SWN").And.;
				SWN->WN_DOC== (cAliasSD1)->D1_DOC .And. SWN->WN_SERIE == (cAliasSD1)->D1_SERIE;
						.And.(SWN->WN_TEC+SWN->WN_EX_NCM+SWN->WN_EX_NBM)==(cAliasSD1)->D1_TEC
               
			SB1->(dbSeek(xFilial()+SWN->WN_PRODUTO))
			If Empty(SB1->B1_POSIPI)
				SWN->(dbSkip())
				Loop
			Endif
			nF1Desp	:= SF1->F1_FRETE + SF1->F1_DESPESA + SF1->F1_SEGURO
			nTotDesp	:= ((SWN->WN_VALOR/SF1->F1_VALMERC )*nF1Desp)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Recebe dados do fornecedor              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cCliFor	:=	SWN->WN_FORNECE
			cLoja	:=	SWN->WN_LOJA
		
		    If (cAliasSD1)->D1_TIPO $ "DB"
				SA1->(dbSeek(xFilial()+cCliFor+cLoja))
				cRazao		:=	Alltrim(SA1->A1_NOME)
				cCGC		:=	SA1->A1_CGC
				cTipoCliFor	:=	SA1->A1_TIPO
				cEstado		:=	SA1->A1_EST
			Else
				SA2->(dbSeek(xFilial()+cCliFor+cLoja))	
				cRazao		:=	Alltrim(SA2->A2_NOME)
				cCGC		:=	SA2->A2_CGC		
				cTipoCliFor	:=	SA2->A2_TIPO
				cEstado		:=	SA2->A2_EST
			Endif
			cCGC	:=	Transform(cCGC,"@R 99.999.999/9999-99")
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Recebe dados do produto                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cProduto	:=	RetChar(Alltrim(SB1->B1_DESC))
			//Ponto de entrada para o campo NBM/NCM
			If ExistBlock("MTANCM975") 
				cNBM := ExecBlock("MTANCM975", .F., .F., {"SD1"}) 
			Else
				cNBM :=	Transform(SB1->B1_POSIPI,"@R 9999.99.9999")
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava dados                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea(cArqTemp)
			RecLock(cArqTemp,.T.)
			(cArqTemp)->TIPOMOV 	:= "E"
			(cArqTemp)->NOTA		:= SWN->WN_DOC
			(cArqTemp)->SERIE		:= SWN->WN_SERIE
			(cArqTemp)->ITEM		:= SWN->WN_ITEM
			(cArqTemp)->TIPO		:= (cAliasSD1)->D1_TIPO  
			(cArqTemp)->DT_ENTRADA	:= (cAliasSD1)->D1_DTDIGIT 
			(cArqTemp)->DT_EMISSAO	:= (cAliasSD1)->D1_EMISSAO 
			(cArqTemp)->CLIFOR		:= SWN->WN_FORNECE
			(cArqTemp)->LOJA		:= SWN->WN_LOJA
			(cArqTemp)->CGC		:= cCGC
			(cArqTemp)->NOME		:= cRazao
			(cArqTemp)->TIPOCLIFOR	:= cTipoCliFor
			(cArqTemp)->UF			:= cEstado
			(cArqTemp)->PRODUTO	:= SWN->WN_PRODUTO
			(cArqTemp)->DESCPROD	:= cProduto
			(cArqTemp)->NBM		:= cNBM
			(cArqTemp)->TES		:= (cAliasSD1)->D1_TES 
			(cArqTemp)->CFO		:= (cAliasSD1)->D1_CF
			(cArqTemp)->VALMERC	:= SWN->WN_CIF
			(cArqTemp)->VALIPI		:= SWN->WN_IPIVAL
			(cArqTemp)->VMERCAD	:= SWN->WN_CIF+SWN->WN_IIVAL+SWN->WN_IPIVAL
		
			MsUnlock()
			SWN->( dbskip())
		END	
	else 
		cNBM	:=	""
		SB1->(dbSeek(xFilial("SB1")+(cAliasSD1)->D1_COD))
		If GetNewPar("MV_SB1SFT",.T.)
			If SFT->(DbSeek(xFilial("SFT")+"E"+(cAliasSD1)->(D1_SERIE+D1_DOC+D1_FORNECE+D1_LOJA+D1_ITEM+D1_COD)))
				//Ponto de entrada para o campo NBM/NCM
				If ExistBlock("MTANCM975") 
					cNBM := ExecBlock("MTANCM975", .F., .F., {"SD1"}) 
				Else									
					cNBM	:=	SFT->FT_POSIPI
				Endif	
			EndIf
		EndIf
		
		If Empty(cNBM)
			If Empty(SB1->B1_POSIPI)
				(cAliasSD1)->(dbSkip())
				Loop
			Else
				//Ponto de entrada para o campo NBM/NCM
				If ExistBlock("MTANCM975") 
					cNBM := ExecBlock("MTANCM975", .F., .F., {"SD1"}) 
				Else										
					cNBM	:=	SB1->B1_POSIPI
				EndIf
			EndIf
		Endif
	
		nF1Desp		:= SF1->F1_FRETE + SF1->F1_DESPESA + SF1->F1_SEGURO
		nTotDesp	:= (((cAliasSD1)->D1_TOTAL/SF1->F1_VALMERC )*nF1Desp)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Recebe dados do fornecedor              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cCliFor	:=	(cAliasSD1)->D1_FORNECE
		cLoja		:=	(cAliasSD1)->D1_LOJA
	
	    If (cAliasSD1)->D1_TIPO $ "DB"
			SA1->(dbSeek(xFilial("SA1")+cCliFor+cLoja))
			cRazao		:=	Alltrim(SA1->A1_NOME)
			cCGC		:=	SA1->A1_CGC
			cTipoCliFor	:=	SA1->A1_TIPO
			cEstado		:=	SA1->A1_EST
		Else
			SA2->(dbSeek(xFilial("SA2")+cCliFor+cLoja))	
			cRazao		:=	Alltrim(SA2->A2_NOME)
			cCGC		:=	SA2->A2_CGC		
			cTipoCliFor	:=	SA2->A2_TIPO
			cEstado		:=	SA2->A2_EST
		Endif
		cCGC	:=	Transform(cCGC,"@R 99.999.999/9999-99")
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Recebe dados do produto                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cProduto	:=	RetChar(Alltrim(SB1->B1_DESC))
		cNBM		:=	Transform(cNBM,"@R 9999.99.9999")
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava dados                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cArqTemp)
		RecLock(cArqTemp,.T.)
		(cArqTemp)->TIPOMOV 		:= "E"
		(cArqTemp)->NOTA			:= (cAliasSD1)->D1_DOC
		(cArqTemp)->SERIE			:= (cAliasSD1)->D1_SERIE
		(cArqTemp)->ITEM			:= (cAliasSD1)->D1_ITEM
		(cArqTemp)->TIPO			:= (cAliasSD1)->D1_TIPO
		(cArqTemp)->DT_ENTRADA		:= (cAliasSD1)->D1_DTDIGIT
		(cArqTemp)->DT_EMISSAO		:= (cAliasSD1)->D1_EMISSAO
		(cArqTemp)->CLIFOR			:= (cAliasSD1)->D1_FORNECE
		(cArqTemp)->LOJA			:= (cAliasSD1)->D1_LOJA
		(cArqTemp)->CGC			:= cCGC
		(cArqTemp)->NOME			:= cRazao
		(cArqTemp)->TIPOCLIFOR		:= cTipoCliFor
		(cArqTemp)->UF				:= cEstado
		(cArqTemp)->PRODUTO		:= (cAliasSD1)->D1_COD
		(cArqTemp)->DESCPROD		:= cProduto
		(cArqTemp)->NBM			:= cNBM
		(cArqTemp)->TES			:= (cAliasSD1)->D1_TES
		(cArqTemp)->CFO			:= (cAliasSD1)->D1_CF
		// Notas fiscais de complemento de impostos nao devem ser somadas ao total da mercadoria
		If (cAliasSD1)->D1_TIPO $ "IP"
			(cArqTemp)->VALMERC	:= nTotDesp
			(cArqTemp)->VMERCAD	:= 0
		Else
			(cArqTemp)->VALMERC	:= ((cAliasSD1)->D1_TOTAL-(cAliasSD1)->D1_VALDESC)+nTotDesp + IIf(SF4->F4_AGREG$"IA",(cAliasSD1)->D1_VALICM,0)
			(cArqTemp)->VMERCAD	:=  ((cAliasSD1)->D1_TOTAL-(cAliasSD1)->D1_VALDESC)+nTotDesp + IIf(SF4->F4_AGREG$"IA",(cAliasSD1)->D1_VALICM,0)
		Endif
		(cArqTemp)->VALIPI			:= (cAliasSD1)->D1_VALIPI
	
		MsUnlock()
	Endif
	  dbSelectArea(cAliasSD1)
	  dbSkip()
End
#IFDEF TOP
	dbSelectArea(cAliasSD1)
	dbCloseArea()
#ELSE
    dbSetOrder(1)	
#ENDIF


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recebe movimentacoes de saidas          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SD2")
dbSetOrder(3)
#IFDEF TOP
    If TcSrvType()<>"AS/400"
       cAliasSD2 := "AliasSD2"
	   aStruSD2  := SD2->(dbStruct())
	   cQuery    := "SELECT * "
	   cQuery    += "FROM "+RetSqlName("SD2")+" SD2 "
	   cQuery    += "WHERE SD2.D2_FILIAL='"+xFilial("SD2")+"' AND "
	   cQuery    += "SD2.D2_EMISSAO >= '"+DTOS(dDtIni)+"' AND "
	   cQuery    += "SD2.D2_EMISSAO <= '"+DTOS(dDtFim)+"' AND "
	   cQuery    += "SD2.D_E_L_E_T_=' ' "
	   cQuery    += "ORDER BY "+SqlOrder(SD2->(IndexKey()))
	
	   cQuery    := ChangeQuery(cQuery)
	
	   dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD2,.T.,.T.)
	
	   For nX := 1 To Len(aStruSD2)
		   If ( aStruSD2[nX][2] <> "C" )
			  TcSetField(cAliasSD2,aStruSD2[nX][1],aStruSD2[nX][2],aStruSD2[nX][3],aStruSD2[nX][4])
		   EndIf
	   Next nX
	Else   
#ENDIF
       cAliasSD2 := "SD2"
  	   dbSeek(xFilial("SD2"))
       if ProcName(1) == "MATR962" .or. ProcName(1) == "R950IMP"
	      setregua((cAliasSD2)->(LastRec()))
       else	
	      ProcRegua((cAliasSD2)->(LastRec()))
       endIf	
    #IFDEF TOP
	   Endif   
    #ENDIF

while (!eof().and.(cAliasSD2)->D2_FILIAL==xFilial("SD2"))
	If Interrupcao(@lAbortPrint)
		Exit
	Endif
    #IFNDEF TOP
         if ProcName(1) == "MATR962" .or. ProcName(1) == "R950IMP"
  	        IncRegua()
	     else	
		    IncProc()
	     EndIf	
	#ENDIF   

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtragem                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ((cAliasSD2)->D2_EMISSAO<dDtIni.or.(cAliasSD2)->D2_EMISSAO>dDtFim)
		(cAliasSD2)->(dbSkip())
		Loop
	Endif
	SF4->(dbSeek(xFilial("SF4")+(cAliasSD2)->D2_TES))
	If SF4->F4_ISS=="S".Or.SF4->F4_LFIPI=="N"
		dbSkip()
		Loop
	Endif	 
	If cNrLivro <> "*"        
		If !(SF4->F4_NRLIVRO==cNrLivro)
			dbSkip()
			Loop
		Endif	
	Endif	
	
	cNBM	:=	""
	SB1->(dbSeek(xFilial("SB1")+(cAliasSD2)->D2_COD))
	If GetNewPar("MV_SB1SFT",.T.)
		If SFT->(DbSeek(xFilial("SFT")+"S"+(cAliasSD2)->(D2_SERIE+D2_DOC+D2_CLIENTE+D2_LOJA+PadR(D2_ITEM,TamSx3("FT_ITEM")[1])+D2_COD)))
			//Ponto de entrada para o campo NBM/NCM
			If ExistBlock("MTANCM975") 
				cNBM := ExecBlock("MTANCM975", .F., .F., {"SD2"}) 
			Else									
				cNBM	:=	SFT->FT_POSIPI
			Endif	
		EndIf
	EndIf
		
	If Empty(cNBM)
		If Empty(SB1->B1_POSIPI)
			(cAliasSD2)->(dbSkip())
			Loop
		Else
			//Ponto de entrada para o campo NBM/NCM
			If ExistBlock("MTANCM975") 
				cNBM := ExecBlock("MTANCM975", .F., .F., {"SD2"}) 
			Else											
				cNBM	:=	SB1->B1_POSIPI
			Endif	
		EndIf
	Endif
		
	SF2->(dbSetOrder(1))
	SF2->(dbSeek(xFilial("SF2")+(cAliasSD2)->D2_DOC+(cAliasSD2)->D2_SERIE+(cAliasSD2)->D2_CLIENTE+(cAliasSD2)->D2_LOJA))
	nF2Desp	:= SF2->F2_FRETE + SF2->F2_SEGURO + SF2->F2_DESPESA
	nTotDesp:= (((cAliasSD2)->D2_TOTAL/SF2->F2_VALMERC )*nF2Desp)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Recebe dados do Cliente                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCliFor	:=	(cAliasSD2)->D2_CLIENTE
	cLoja	:=	(cAliasSD2)->D2_LOJA
	cEstado	:=	(cAliasSD2)->D2_EST
	If (cAliasSD2)->D2_TIPO	$	"DB"
		SA2->(dbSeek(xFilial("SA2")+cCliFor+cLoja))
		cRazao		:=	Alltrim(SA2->A2_NOME)
		cCGC		:=	SA2->A2_CGC
		cTipoCliFor	:=	SA2->A2_TIPO
	Else
		SA1->(dbSeek(xFilial("SA1")+cCliFor+cLoja))
		cRazao		:=	Alltrim(SA1->A1_NOME)
		cCGC		:=	SA1->A1_CGC
		cTipoCliFor	:=	SA1->A1_TIPO
		cEstado		:=	SA1->A1_EST
	Endif
	cCGC	:=	Transform(cCGC,"@R 99.999.999/9999-99")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Recebe dados do produto                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cProduto	:=	RetChar(Alltrim(SB1->B1_DESC))
	cNBM		:=	Transform(cNBM,"@R 9999.99.9999")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria array com Documentos com Abatimento de ISS Material ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (cAliasSD2)->D2_ABATMAT>0 .And. (Len(Alltrim(GetNewPar("MV_CSLLEP","")))>4 .Or. Len(Alltrim(GetNewPar("MV_IREP","")))>4)
		AADD(aDocAbatMat,{(cAliasSD2)->D2_DOC,(cAliasSD2)->D2_SERIE,(cAliasSD2)->D2_CLIENTE,(cAliasSD2)->D2_LOJA})
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava dados                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(cArqTemp)
	RecLock(cArqTemp,.T.)
	(cArqTemp)->TIPOMOV 	:= "S"
	(cArqTemp)->NOTA		:= (cAliasSD2)->D2_DOC
	(cArqTemp)->SERIE		:= (cAliasSD2)->D2_SERIE
	(cArqTemp)->ITEM		:= (cAliasSD2)->D2_ITEM
	(cArqTemp)->TIPO		:= (cAliasSD2)->D2_TIPO
	(cArqTemp)->DT_ENTRADA	:= (cAliasSD2)->D2_EMISSAO
	(cArqTemp)->DT_EMISSAO	:= (cAliasSD2)->D2_EMISSAO
	(cArqTemp)->CLIFOR		:= (cAliasSD2)->D2_CLIENTE
	(cArqTemp)->LOJA		:= (cAliasSD2)->D2_LOJA
	(cArqTemp)->CGC			:= cCGC
	(cArqTemp)->NOME		:= cRazao
	(cArqTemp)->TIPOCLIFOR	:= cTipoCliFor
	(cArqTemp)->UF			:= cEstado
	(cArqTemp)->PRODUTO		:= (cAliasSD2)->D2_COD
	(cArqTemp)->DESCPROD	:= cProduto
	(cArqTemp)->NBM			:= cNBM
	(cArqTemp)->TES			:= (cAliasSD2)->D2_TES
	(cArqTemp)->CFO			:= (cAliasSD2)->D2_CF
	// Notas fiscais de complemento de impostos nao devem ser somadas ao total da mercadoria
	If (cAliasSD2)->D2_TIPO $ "IP"
		(cArqTemp)->VALMERC	:= nTotDesp
		(cArqTemp)->VMERCAD	:= 0
	Else
		(cArqTemp)->VALMERC	:= if(!empty((cAliasSD2)->D2_PEDIDO),(cAliasSD2)->D2_TOTAL,((cAliasSD2)->D2_TOTAL-(cAliasSD2)->D2_DESCON))+nTotDesp
		(cArqTemp)->VMERCAD	:= (cAliasSD2)->D2_TOTAL
	Endif
	(cArqTemp)->VALIPI		:= (cAliasSD2)->D2_VALIPI
	MsUnlock()
  	dbSelectArea(cAliasSD2)
	dbSkip()
end
#IFDEF TOP
	dbSelectArea(cAliasSD2)
	dbCloseArea()
Next
cFilAnt := cFilBack	
#ENDIF

dbSelectArea(cArqTemp)
Return (cArqTemp)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MTA97550  ³ Autor ³Gustavo G. Rueda       ³ Data ³11.08.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Utilizada para selecionar os titulos de IRPJ e CSLL Retidos ³±±
±±³          ³ para enviar na ficha 54.                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL = lAchou = .T.                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MTA97550(aEmpresa,lRelatorio)
	Local aArqSE1		:= {"SE1",""}    
	Local cDbfE1		:= ""
	Local cTopE1		:= ""
	Local	cMesFinal	:= StrZero(Day(LastDay(SToD (StrZero (MV_PAR03, 4)+StrZero (MV_PAR02, 2)+"01"))),2)
	Local	dDataDe		:=	SToD (StrZero (MV_PAR03, 4)+StrZero (MV_PAR01, 2)+"01")
	Local	dDataAte		:=	SToD (StrZero (MV_PAR03, 4)+StrZero (MV_PAR02, 2)+cMesFinal)
	Local	cMV_IRF		:=	AllTrim (&(GetNewPar ("MV_IRF",	'""')))
	Local	cMV_CSLL		:=	AllTrim (GetNewPar ("MV_CSLL",	""))
	Local	cMV_IRPJ		:=	AllTrim (GetNewPar ("MV_IRPJ",	""))
	Local	cMV_INSS		:=	AllTrim (GetNewPar ("MV_INSDIPJ",""))
	Local cMV_CSDI    := Alltrim (GetNewPar ("MV_CSLDIPJ",""))
	Local cMv_IRDI    := Alltrim (GetNewPar ("MV_IRDIPJ",""))
	Local cMv_EPCS    := Alltrim (GetNewPar ("MV_CSLLEP",""))
	Local cMv_EPIR    := Alltrim (GetNewPar ("MV_IREP",""))
	Local cMv_EPIN    := Alltrim (GetNewPar ("MV_INEP",""))	
	Local	nX				:=	0
	Local	aTrbs			:=	CriaTrb()
	Local	cRegistro   := ""
	Local	nPos			:=	0
	Local	aRet			:=	{}
	Local nValIr		:=	0.00
	Local nValCsll		:=	0.00
	Local nTotIr		:=	0.00
	Local nTotCsll		:=	0.00
	Local nTotAbImp 	:= 0
   Local nValInss    := 0.00
	Local	nY				:=	0
	Local	nSeq	    	:=	1
 
	Default	lRelatorio	:=	.F.
	
	For nY := 1 To Len(aEmpresa)
		cFilAnt := aEmpresa[nY][3] 
		// Se a tabela for compartilhada, devera ser verificado o campo
		// MSFIL, caso exista na base.
		If FWModeAccess("SE1",3)=="C" .And. SE1->(FieldPos("E1_MSFIL"))>0
			cDbfE1	:= "E1_MSFIL=='"+FWCodFil()+"' .And. DToS(E1_EMISSAO)>='"+DToS(dDataDe)+"' .And. DToS(E1_EMISSAO)<='"+DToS(dDataAte)+"' .And. !E1_TIPO$'"+MVABATIM+"/"+MVIRABT+"/"+MVINABT+"/"+MVCSABT+"/"+MVCFABT+"/"+MVPIABT+"'   "
			cTopE1	:= "E1_MSFIL='"+FWCodFil()+"' AND E1_EMISSAO>='"+DToS(dDataDe)+"' AND E1_EMISSAO<='"+DToS(dDataAte)+"' AND D_E_L_E_T_=' ' "
		Else
			cDbfE1	:= "E1_FILIAL=='"+xFilial("SE1")+"' .And. DToS(E1_EMISSAO)>='"+DToS(dDataDe)+"' .And. DToS(E1_EMISSAO)<='"+DToS(dDataAte)+"' .And. !E1_TIPO$'"+MVABATIM+"/"+MVIRABT+"/"+MVINABT+"/"+MVCSABT+"/"+MVCFABT+"/"+MVPIABT+"'   "
			cTopE1	:= "E1_FILIAL='"+xFilial("SE1")+"' AND E1_EMISSAO>='"+DToS(dDataDe)+"' AND E1_EMISSAO<='"+DToS(dDataAte)+"' AND D_E_L_E_T_=' ' "
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Processa os titulo de contas a receber            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE1")
		SE1->(dbSetOrder(10))
		FsQuery(aArqSE1,1,cTopE1,cDbfE1,SE1->(IndexKey()))
		SE1->(dbGoTop())
		Do While SE1->(!Eof())
			If AllTrim(SE1->E1_TIPO)$MVABATIM+"/"+MVIRABT+"/"+MVINABT+"/"+MVCSABT+"/"+MVCFABT+"/"+MVPIABT
				SE1->(DbSkip())
				Loop
			EndIf		
			cCliente		:= SE1->E1_CLIENTE+SE1->E1_LOJA
			cTpFatura	:= SE1->E1_TIPO
			dBaixa		:= SE1->E1_BAIXA
			cPrefixo		:= SE1->E1_PREFIXO
			cNum			:= SE1->E1_NUM
			cParcela		:= SE1->E1_PARCELA
			nValIr		:=	0.00
			nValCsll		:=	0.00
			nTotIr		:=	0.00
			nTotCsll		:=	0.00
			nValores		:=	0.00
			nTotAbImp 	:= 0
			nValInss		:=	0.00 
			//
			SumAbatRec(cPrefixo,cNum,cParcela,SE1->E1_MOEDA,"V",dBaixa,@nTotAbImp,@nValIr,@nValCsll)
			//Funcao para pegar soh o valor do INSS - 28/12/09
			SumAbatIns(cPrefixo,cNum,cParcela,SE1->E1_MOEDA,"V",dBaixa,@nTotAbImp,@nValInss)
			//Monta retencao
			If (nValIr + nValCsll + nValInss) > 0
				aRet		:=	array(3)
				aRet[1]	:=	{IIf(SE1->(FieldPos("E1_CDRETIR"))>0 .And. !Empty(SE1->E1_CDRETIR), SE1->E1_CDRETIR, IIf(!Empty(cMV_IRDI), cMV_IRDI, "1708")), nValIr}
				aRet[2]	:=	{IIf(SE1->(FieldPos("E1_CDRETCS"))>0 .And. !Empty(SE1->E1_CDRETCS), SE1->E1_CDRETCS, IIf(!Empty(cMV_CSDI), cMV_CSDI, "5952")), nValCsll}
				aRet[3]	:=	{cMV_INSS, nValInss}
				lAbatMat := .F.         
				If Len(aDocAbatMat) > 0 .And. AllTrim(cTpFatura) == "NF"
					lAbatMat := Ascan(aDocAbatMat,{|x| x[1]==SE1->E1_NUM .And. x[2]==SE1->E1_SERIE .And. x[3]==SE1->E1_CLIENTE .And. x[4]==SE1->E1_LOJA})	> 0
				Endif			  	
				For nX := 1 To 3
					If aRet[nX][2]>0
						If !TRB->(DbSeek(StrZero(Year(dDataAte),4)+SE1->E1_CLIENTE+SE1->E1_LOJA+aRet[nX][1]))
							RecLock("TRB", .T.)
							TRB->TRB_FORN		:=	SE1->E1_CLIENTE
							TRB->TRB_LOJA		:=	SE1->E1_LOJA
							TRB->TRB_ANO		:=	StrZero(Year(dDataAte),4)
							TRB->TRB_CODRET	:=	aRet[nX][1]
							TRB->TRB_ABAMAT	:=	lAbatMat		
							TRB->TRB_TIPIMP	:= nX
						Else
							RecLock ("TRB", .F.)
						EndIf
						If aRet[nX][1] == "5952"
							TRB->TRB_VLRPGO += aRet[nX][2] * 100 
						Else				  
							TRB->TRB_VLRPGO += SE1->E1_VALOR
						EndIf
						TRB->TRB_VLRRET += aRet[nX][2]
						TRB->(MsUnLock())
					Endif
				Next (nX)
			Endif
			SE1->(DbSkip())
		EndDo
		FsQuery(aArqSE1,2)
	Next	
	cFilAnt := FWCodFil()
	If !lRelatorio
		SA1->(DbSetOrder (1))
		nX := 0
		TRB->(DbGoTop ())
		While !(TRB->(Eof()))
			If (SA1->(MsSeek (xFilial ("SA1")+TRB->TRB_FORN+TRB->TRB_LOJA))) .And. SA1->A1_PESSOA=="J"
				cRegistro   := a975Fill("R57",03)											//Tipo
				cRegistro   += a975Fill("",1)												//Reservado	
				cRegistro   += a975Fill(StrZero(nSeq,4,0),4)									//Sequencial da Entrada
				cRegistro   += a975Fill(A975Num2Chr(Val(cCGC),14,0),14)        			//CNPJ do Contribuinte
				nPos        := Ascan(aListBox,{|x| "0105"$x })								//"0105 - Ano Calendario "
				cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) 
				nPos        := Ascan(aListBox,{|x| "0106"$x })								//"0106 - Declaracao Retificadora"
				cRegistro   += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01)
				cRegistro   += a975Fill(a975Fill(substr(SA1->A1_CGC,01,14),14),14)  		//CNPJ da Fonte Pagadora
				cRegistro   += a975Fill(substr(SA1->A1_NOME,01,150),150)  					//Nome Empresarial
				//Verifica parametro de Orgao Publico
			   	If SA1->A1_TPESSOA =="EP"
				   	cCodRet	:= TRB->TRB_CODRET					
					If TRB->TRB_TIPIMP==1 .And. (!Empty(cMv_EPIR) .AND. TRB->TRB_CODRET$cMv_IRDI .Or. TRB->TRB_CODRET == "1708")
						cCodRet	:= a975Fill(Iif(!Empty(cMv_EPIR), IIf(TRB->TRB_ABAMAT, Substr(cMv_EPIR,6,4), Substr(cMv_EPIR,1,4)), "6228"), 4)
					ElseIf TRB->TRB_TIPIMP==2 .And. (!Empty(cMv_EPCS) .AND. TRB->TRB_CODRET$cMv_CSDI .Or. TRB->TRB_CODRET == "5952")
						cCodRet	:= a975Fill(Iif(!Empty(cMv_EPCS), IIf(TRB->TRB_ABAMAT, Substr(cMv_EPCS,6,4), Substr(cMv_EPCS,1,4)), "6228"), 4)
					ElseIf TRB->TRB_TIPIMP==3 .And. (!Empty(cMv_EPIN) .AND. TRB->TRB_CODRET$cMv_INSS)
							cCodRet	:= a975Fill(cMv_EPIN, 4)						
	                Endif
					cRegistro   += a975Fill("1", 1)												//Orgao Publico Federal, 1=Sim, 2=Nao
					cRegistro   += a975Fill(SubStr(cCodRet, 1, 4), 4)	 					//Codigo de Receita
				Else
					cRegistro   += a975Fill("2", 1)												//Orgao Publico Federal, 1=Sim, 2=Nao				
					cRegistro   += a975Fill(SubStr(TRB->TRB_CODRET, 1, 4), 4)			//Codigo de Receita
				Endif
					
				cRegistro   += a975Fill(a975Num2Chr(TRB->TRB_VLRPGO, 14, 2), 14)			//Rendimento Bruto - Informar o valor bruto do rendimento que originou a retenção.
				
				If TRB->TRB_TIPIMP==1 // IRRF
					cRegistro   += a975Fill(a975Num2Chr (TRB->TRB_VLRRET, 14, 2), 14)	//IR Retido na Fonte  
					cRegistro   += a975Fill(a975Num2Chr (0, 14, 2), 14)				    //CSLL Retido na Fonte  
				   	cRegistro   += a975Fill(a975Num2Chr (0, 14, 2), 14)					//Contribuicao Previdenciaria Retida na Fonte

				ElseIf TRB->TRB_TIPIMP==2  // CSLL
					cRegistro   += a975Fill(a975Num2Chr (0, 14, 2), 14)					//IR Retido na Fonte  
					cRegistro   += a975Fill(a975Num2Chr (TRB->TRB_VLRRET, 14, 2), 14)	//CSLL Retido na Fonte  
				    cRegistro   += a975Fill(a975Num2Chr (0, 14, 2), 14)					//Contribuicao Previdenciaria Retida na Fonte
				Else    // INSS
					cRegistro   += a975Fill(a975Num2Chr (0, 14, 2), 14)					//IR Retido na Fonte  
					cRegistro   += a975Fill(a975Num2Chr (0, 14, 2), 14)					//CSLL Retido na Fonte  
					cRegistro   += a975Fill(a975Num2Chr (TRB->TRB_VLRRET, 14, 2), 14)	//Contribuicao Previdenciaria Retida na Fonte
				EndIf
				cRegistro   += a975Fill(,10)   	                            				//Filler
				cRegistro   := a975Fill(cRegistro,259)
				A975Grava(cRegistro)
				nSeq		+=	1
			EndIf
			TRB->(DbSkip ())
		EndDo
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Removo todos os temporarios criados pela funcao CriaTrb.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nX := 1 To Len (aTrbs)
			DbSelectArea (aTrbs[nX][1])
				(aTrbs[nX][1])->(DbCloseArea ())
			Ferase (aTrbs[nX][2]+GetDBExtension ())
			Ferase (aTrbs[nX][2]+OrdBagExt ())
		Next (nX)
	EndIf
Return aTrbs

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CriaTrb   ³ Autor ³Gustavo G. Rueda       ³ Data ³13.05.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao que trata sobre a criacao do arquivos de trabalho.   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpA = aRet = Array contendo {Alias, NomeTrb}               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CriaTrb ()
	Local	aRet		:=	{}
	Local	aTrb		:=	{}
	Local	cAliasTrb	:=	""
	//
	aTrb	:=	{}
	//
	aAdd (aTrb, {"TRB_FORN",	"C",	TamSX3("A2_COD")[1],	TamSX3("A2_COD")[2]})
	aAdd (aTrb, {"TRB_LOJA",	"C",	TamSX3("A2_LOJA")[1],	TamSX3("A2_LOJA")[2]})
	aAdd (aTrb, {"TRB_ANO",		"C",	04,	0})
	aAdd (aTrb, {"TRB_CODRET",	"C",	04,	0})
	aAdd (aTrb, {"TRB_VLRPGO",	"N",	16,	2})
	aAdd (aTrb, {"TRB_VLRRET",	"N",	16,	2})
	aAdd (aTrb, {"TRB_ABAMAT",	"L",	01,	0})	
	aAdd (aTrb, {"TRB_TIPIMP",	"N",	01,	0})	
	//
	cAliasTrb	:=	CriaTrab (aTrb)
	DbUseArea (.T., __LocalDriver, cAliasTrb, "TRB")
	IndRegua ("TRB", cAliasTrb,"TRB_ANO+TRB_FORN+TRB_LOJA+TRB_CODRET")
	//
	aAdd (aRet, {"TRB", cAliasTrb})
Return (aRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³SumAbatIns³ Autor ³ Wagner Xavier         ³ Data ³ 23/03/93                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Soma titulos de abatimento relacionado a um determinado titu               ³±±
±±³          ³lo a receber para calculo da retencao do INSS                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³SumAbatIns(), Identica a funcao SumAbatRec do MATXFUNA                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Prefixo,Numero,Parcela,Moeda,Saldo ou Valor                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³MATA975                                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function SumAbatIns( cPrefixo,cNumero,cParcela,nMoeda,cCpo,dData,nTotAbImp,nTotInAbt)
Local cAlias:=Alias(),nTotAbat:=0,nRec:=RecNo()    

DEFAULT nTotAbImp := 0
DEFAULT nTotInAbt := 0

dData :=IIF(dData==NIL,dDataBase,dData)
nMoeda:=IIF(nMoeda==NIL,1,nMoeda)

cCampo	:= IIF( cCpo == "V", "E1_VALOR" , "E1_SALDO" )

If Select("__SE1") == 0
	ChkFile("SE1",.F.,"__SE1")
Else
	dbSelectArea("__SE1")
Endif

dbSetOrder( 1 )
dbSeek( xFilial("SE1")+cPrefixo+cNumero+cParcela )

While !Eof() .And. E1_FILIAL == xFilial("SE1") .And. E1_PREFIXO == cPrefixo .And.;
		E1_NUM == cNumero .And. E1_PARCELA == cParcela
	//Inss
	If E1_TIPO $ MVINABT .And. E1_TIPO $ MVABATIM
			nTotInAbt +=xMoeda(&cCampo,E1_MOEDA, nMoeda,dData) 
	Endif
	dbSkip()
Enddo

dbSetOrder( 1 )

dbSelectArea( cAlias )
dbGoTo(nRec)
Return (NoRound(nTotAbat))


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MATA975   ºAutor  ³Microsiga           º Data ³  08/28/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ajuste de parâmetros para a rotina.                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ P11                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1()

Local aArea		:= GetArea()
Local aHelpPor	:={}
Local aHelpEng	:={}
Local aHelpSpa	:={}
Local nTamSx1Grp:=Len(SX1->X1_GRUPO)
Local aSoluPor  :={}
Local aSoluEng  :={}
Local aSoluSpa  :={}

If SX1->(dbSeek(PadR("MTA975",nTamSx1Grp)+"05")) .And. SX1->(AllTrim(X1_PERGUNT)) <> "Considera Filiais ?"
	RecLock("SX1",.F.)
	SX1->X1_PERGUNT	:=	"Considera Filiais ?"
	MsUnlock()
EndIf

If SX1->(dbSeek(PadR("MTA975",nTamSx1Grp)+"06")) .And. SX1->(AllTrim(X1_F3)<>"XM0" .Or. AllTrim(X1_GRPSXG)<>"033")
	RecLock("SX1",.F.)
	SX1->X1_F3		:=	"XM0"
	SX1->X1_GRPSXG	:=	"033"
	MsUnlock()
EndIf

If SX1->(dbSeek(PadR("MTA975",nTamSx1Grp)+"07")) .And. SX1->(AllTrim(X1_F3)<>"XM0" .Or. AllTrim(X1_GRPSXG)<>"033")
	RecLock("SX1",.F.)
	SX1->X1_F3		:=	"XM0"
	SX1->X1_GRPSXG	:=	"033"
	MsUnlock()
EndIf

aHelpEng := {}
aHelpSpa := {}
aHelpPor :=	{}	

Aadd( aHelpPor, "Determina a escolha de filiais para")
Aadd( aHelpPor, "a impressao do relatorio. Se Nao")
Aadd( aHelpPor, "apenas a filial corrente sera afetada")
	
Aadd( aHelpSpa, "Selecciona las sucursales deseadas.")
Aadd( aHelpSpa, "Si NO solamente la sucursal actual es")

Aadd( aHelpEng, "Select desired branch offices. If NO")
Aadd( aHelpEng, "only current branch office will be affected.")
    

PutSx1("MTA975","26","Seleciona filiais ?","Selecciona sucursales ?","Select branch offices ?",;
"mv_chp","N",1,0,2,"C","","","","","mv_par26","Sim","Si","Yes","",;
"Nao","No","No","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa,"")     
                                                              
aHelpPor	:=	{}
aHelpEng	:=	{}
aHelpSpa	:=	{}

Aadd( aHelpPor,	 'Aglutina a impressão do relatorio por '   )
Aadd( aHelpPor,	 'CNPJ respeitando a seleção de filiais ')
Aadd( aHelpPor,	 'realizada pelo usuario. Este tratamento'  )
Aadd( aHelpPor,	 'somente sera realizado quando utilizada'	)
Aadd( aHelpPor,	 'a pergunta de seleção de filiais.'	    )
Aadd( aHelpPor,	 'Tratamento disponivel somente para '		)
Aadd( aHelpPor,	 'ambientes DBAccess.'	                    )  

Aadd( aHelpEng,	 'Coalesces printing of the report by '     )
Aadd( aHelpEng,	 'CNPJ  respecting the selection of '		)
Aadd( aHelpEng,	 'branches held by the User. This treatment')
Aadd( aHelpEng,	 'will be performed only used when the'		)
Aadd( aHelpEng,	 'question of selecting branches.'	    	)
Aadd( aHelpEng,	 'Treatment available only for DBAccess '	)
Aadd( aHelpEng,	 'environments.'	                  		)   

Aadd( aHelpSpa,	 'Fusiona la impresión del informe de '  	)
Aadd( aHelpSpa,	 'CNPJ sobre la selección de las '		)
Aadd( aHelpSpa,	 'sucursales que tiene el usuario. Se'  	)
Aadd( aHelpSpa,	 'llevará a cabo este tratamiento sólo se'	)
Aadd( aHelpSpa,	 'utiliza cuando la cuestión de la'	    	)
Aadd( aHelpSpa,	 'selección de ramas. El tratamiento disponible ')
Aadd( aHelpSpa,	 'sólo para entornos DBAccess.'	            )
	
PutSx1("MTA975",'27','Aglutina por CNPJ','aglutinados  CNPJ',	'agglutinated CNPJ',	'mv_chq',"N",1,0,2,"C","","","","","mv_par27","Sim","Si","Yes","",;
"Nao","No","No","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa,"")    

aHelpPor	:=	{}
aHelpEng	:= 	{}
aHelpSpa	:= 	{}

Aadd( aHelpPor,	 'ATENÇÃO,  Só será possivel aglutinar as'  )
Aadd( aHelpPor,	 'informações entre filiais caso as tabelas')
Aadd( aHelpPor,	 ' Visão gerencial e Configuração de Livros' )
Aadd( aHelpPor,	 ' Contabeis estejam COMPARTILHADAS')  

Aadd( aHelpEng,	 'ATTENTION, will only be possible to bring'  )
Aadd( aHelpEng,	 'together the information between branches')
Aadd( aHelpEng,	 'if the tables Vision and configuration ' )
Aadd( aHelpEng,	 'management books are SHARED') 

Aadd( aHelpSpa,	 'ATENCION, sólo será posible reunir '  )
Aadd( aHelpSpa,	 'la información entre las ramas si el Vision ')
Aadd( aHelpSpa,	 'mesas y libros de gestión de configuración ' )
Aadd( aHelpSpa,	 'se comparten')  

Aadd( aSoluPor,	 ' Compartilhar as Tabelas CTS e CTN') 
Aadd( aSoluEng,	 ' Share Tables CTS and CTN') 
Aadd( aSoluSpa,	 ' Compartir Tablas CTS y CTN') 


PutHelp("PMTA975EXC",aHelpPor,aHelpEng,aHelpSpa,.T.)   
PutHelp("SMTA975EXC",aSoluPor,aSoluEng,aSoluSpa,.T.)
RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R04A  ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Custo dos Bens e Serviços Vendidos - Com Atividade Rural   º±±
±±º          ³ PJ em Geral                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R04A(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg	 	:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	aFicha	:= GetSldPlGer(mv_par19, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,)  
   If lFirst     
		aReg	:= aClone(aFicha)
		lFirst	:= .F.
	Else    
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
    EndIf
Next

If len(aReg) > 0
	cReg	:= a975Fill("R04A",03) // Tipo
	cReg	+= a975Fill("A",01) // Reservado
	nPos	:= Ascan(aListBox,{|x| "0603"$x })
	cReg  += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos	:= Ascan(aListBox,{|x| "0604"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos	:= Ascan(aListBox,{|x| "0105"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos	:= Ascan(aListBox,{|x| "0106"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	For nX := 1 To Len(aReg)
		cReg	+= a975Fill(A975Num2Chr(aReg[nX][4],14),14)
	Next	
	cReg  += a975Fill(,10) 	 	
	cReg 	:= a975Fill( cReg,1000) 
	a975Grava(cReg)	
Endif                      
cFilAnt := cFilAtu	
Return()  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R04D  ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Custo dos Bens e Serviços Vendidos-Critérios em 31/12/2007 º±±
±±º          ³ Com Atividade Rural - PJ em Geral                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R04D(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	aFicha	:= GetSldPlGer(mv_par19, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
	If lFirst     
		aReg		:= aClone(aFicha)
		lFirst	:= .F.
    Else    
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
    EndIf
Next

If len(aReg) > 0
	cReg	:= a975Fill("R04D",03) // Tipo
	cReg	+= a975Fill("D",01) // Reservado
	nPos	:= Ascan(aListBox,{|x| "0603"$x })
	cReg  += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos	:= Ascan(aListBox,{|x| "0604"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos	:= Ascan(aListBox,{|x| "0105"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos	:= Ascan(aListBox,{|x| "0106"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	For nX := 1 To Len(aReg)
		cReg	+= a975Fill(A975Num2Chr(aReg[nX][4],14),14)
	Next	
	cReg  += a975Fill(,10) 	 	
	cReg 	:= a975Fill( cReg,1000) 
	a975Grava(cReg)	
Endif                      

cFilAnt := cFilAtu	
Return()  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R05A  ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Despesas Operacionais - Com Atividade Rural - PJ em Geral  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R05A(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	aFicha	:= GetSldPlGer(mv_par20, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
	If lFirst     
		aReg		:= aClone(aFicha)
		lFirst	:= .F.
    Else    
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
    EndIf
Next

If len(aReg) > 0
	cReg	:= a975Fill("R05A",03) // Tipo
	cReg	+= a975Fill("A",01) // Reservado
	nPos	:= Ascan(aListBox,{|x| "0603"$x })
	cReg  += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos	:= Ascan(aListBox,{|x| "0604"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos	:= Ascan(aListBox,{|x| "0105"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos	:= Ascan(aListBox,{|x| "0106"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	For nX := 1 To Len(aReg)
		cReg	+= a975Fill(A975Num2Chr(aReg[nX][4],14),14)
	Next	
	cReg  += a975Fill(,10) 	 	
	cReg 	:= a975Fill( cReg,832) 
	a975Grava(cReg)	
Endif                      

cFilAnt := cFilAtu	
Return()  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R05D  ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Despesas Operacionais - Critérios em 31/12/2007            º±±
±±º          ³ Com Atividade Rural - PJ em Geral                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R05D(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	aFicha	:= GetSldPlGer(mv_par20, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
	If lFirst     
		aReg		:= aClone(aFicha)
		lFirst	:= .F.
    Else    
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
    EndIf
Next

If len(aReg) > 0
	cReg	:= a975Fill("R05D",03) // Tipo
	cReg	+= a975Fill("D",01) // Reservado
	nPos	:= Ascan(aListBox,{|x| "0603"$x })
	cReg  += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos	:= Ascan(aListBox,{|x| "0604"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos	:= Ascan(aListBox,{|x| "0105"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos	:= Ascan(aListBox,{|x| "0106"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	For nX := 1 To Len(aReg)
		cReg	+= a975Fill(A975Num2Chr(aReg[nX][4],14),14)
	Next	
	cReg  += a975Fill(,10) 	 	
	cReg 	:= a975Fill( cReg,832) 
	a975Grava(cReg)	
Endif                      

cFilAnt := cFilAtu	
Return()  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R09A  ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Demonstração do Lucro Real                                 º±±
±±º          ³ Com Atividade Rural - PJ em Geral                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R09A(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	aFicha	:= GetSldPlGer(mv_par21, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
	If lFirst     
		aReg		:= aClone(aFicha)
		lFirst	:= .F.
    Else    
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
    EndIf
Next
              
If len(aReg) > 0
	cReg	:= a975Fill("R09",03) // Tipo
	cReg	+= a975Fill("A",01) // Reservado
	nPos	:= Ascan(aListBox,{|x| "0603"$x })
	cReg  += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos	:= Ascan(aListBox,{|x| "0604"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos	:= Ascan(aListBox,{|x| "0105"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos	:= Ascan(aListBox,{|x| "0106"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	For nX := 1 To Len(aReg)
		cReg	+= a975Fill(A975Num2Chr(aReg[nX][4],14),14)
	Next	
	cReg  += a975Fill(,10) 	 	
	cReg 	:= a975Fill( cReg,1378) 
	a975Grava(cReg)	
Endif                      

cFilAnt := cFilAtu	
Return()  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R11   ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cálculo do Imposto de Renda Mensal por Estimativa          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R11(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local nZ   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
Local dPerIni 	:= 0 
Local dPerFim 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	For nZ := 1 To 12               
		dPerIni 	:= CTod("01/"+StrZero(nZ,2)+"/"+StrZero(Year(dDtFim),4))
		dPerFim 	:= CTod(StrZero(Day(LastDate(dPerIni)),2)+"/"+StrZero(nZ,2)+"/"+StrZero(Year(dDtFim),4))
		aFicha		:= GetSldPlGer(mv_par22, dPerIni, dPerFim, mv_par18,,,,,,,,,,,,,) 
		aReg		:= aClone(aFicha)
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
		If len(aReg) > 0
			cReg	:= a975Fill("R11",03) // Tipo
			cReg	+= a975Fill(" ",01) // Reservado
			nPos	:= Ascan(aListBox,{|x| "0603"$x })
			cReg  	+= a975Fill(A975Num2Chr(nZ,2,0),2) // 0603 - Mes
			nPos	:= Ascan(aListBox,{|x| "0604"$x })
			cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
			cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
			nPos	:= Ascan(aListBox,{|x| "0105"$x })
			cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
			nPos	:= Ascan(aListBox,{|x| "0106"$x })
			cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
			For nY := 1 To Len(aReg)
				cReg	+= a975Fill(A975Num2Chr(aReg[nY][4],14),14)
			Next	
			cReg	+= a975Fill(,10) 	 	
			cReg	:= a975Fill( cReg,231) 
			a975Grava(cReg)	
		Endif                      
	Next
Next
cFilAnt := cFilAtu	
Return()  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R12A  ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cálculo do Imposto de Renda sobre o Lucro Real             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R12A(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	aFicha	:= GetSldPlGer(mv_par23, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
	If lFirst     
		aReg		:= aClone(aFicha)
		lFirst	:= .F.
    Else    
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
    EndIf
Next

If len(aReg) > 0
	cReg	:= a975Fill("R12",03) // Tipo
	cReg	+= a975Fill("A",01) // Reservado
	nPos	:= Ascan(aListBox,{|x| "0603"$x })
	cReg  += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos	:= Ascan(aListBox,{|x| "0604"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos	:= Ascan(aListBox,{|x| "0105"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos	:= Ascan(aListBox,{|x| "0106"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	For nX := 1 To Len(aReg)
		cReg	+= a975Fill(A975Num2Chr(aReg[nX][4],14),14)
	Next	
	cReg  += a975Fill(,10) 	 	
	cReg 	:= a975Fill( cReg,384) 
	a975Grava(cReg)	
Endif                      

cFilAnt := cFilAtu	
Return()  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R14A  ºAutor  ³Mauro A. Goncalves  º Data ³  20/02/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R14A(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	aFicha	:= GetSldPlGer(mv_par26, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
	If lFirst     
		aReg		:= aClone(aFicha)
		lFirst	:= .F.
    Else    
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
    EndIf
Next

If len(aReg) > 0
	cReg	:= a975Fill("R14",03) // Tipo
	cReg	+= a975Fill("A",01) // Reservado
	nPos	:= Ascan(aListBox,{|x| "0603"$x })
	cReg  	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos	:= Ascan(aListBox,{|x| "0604"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos	:= Ascan(aListBox,{|x| "0105"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos	:= Ascan(aListBox,{|x| "0106"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	For nX := 1 To Len(aReg)
		cReg	+= a975Fill(A975Num2Chr(aReg[nX][4],14),14)
	Next	      	

	cReg  	+= a975Fill(,10) 	 	
	cReg 	:= a975Fill(cReg,1098) 
	a975Grava(cReg)	
Endif                      

cFilAnt := cFilAtu	
Return()  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R16   ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cálculo da Contribuição Social sobre o Lucro Líquido Mensalº±±
±±º          ³ por Estimativa                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R16(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local nZ   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
Local dPerIni 	:= 0 
Local dPerFim 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	For nZ := 1 To 12               
		dPerIni 	:= CTod("01/"+StrZero(nZ,2)+"/"+StrZero(Year(dDtFim),4))
		dPerFim 	:= CTod(StrZero(Day(LastDate(dPerIni)),2)+"/"+StrZero(nZ,2)+"/"+StrZero(Year(dDtFim),4))
		aFicha		:= GetSldPlGer(mv_par24, dPerIni, dPerFim, mv_par18,,,,,,,,,,,,,) 
		aReg		:= aClone(aFicha)
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
		If len(aReg) > 0
			cReg	:= a975Fill("R16",03) // Tipo
			cReg	+= a975Fill(" ",01) // Reservado
			nPos	:= Ascan(aListBox,{|x| "0603"$x })
			cReg  	+= a975Fill(A975Num2Chr(nZ,2,0),2) // 0603 - Mes
			nPos	:= Ascan(aListBox,{|x| "0604"$x })
			cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
			cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
			nPos	:= Ascan(aListBox,{|x| "0105"$x })
			cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
			nPos	:= Ascan(aListBox,{|x| "0106"$x })
			cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
			For nY := 1 To Len(aReg)
				cReg	+= a975Fill(A975Num2Chr(aReg[nY][4],14),14)
			Next	
			cReg	+= a975Fill(,10) 	 	
			cReg	:= a975Fill( cReg,203) 
			a975Grava(cReg)	
		Endif                      
    Next
Next
cFilAnt := cFilAtu	
Return()  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R17   ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cálculo da Contribuição Social sobre o Lucro Líquido       º±±
±±º          ³ Com Atividade Rural                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R17(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	aFicha	:= GetSldPlGer(mv_par25, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
	If lFirst     
		aReg		:= aClone(aFicha)
		lFirst	:= .F.
    Else    
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
    EndIf
Next

If len(aReg) > 0
	cReg	:= a975Fill("R17",03) // Tipo
	cReg	+= a975Fill(" ",01) // Reservado
	nPos	:= Ascan(aListBox,{|x| "0603"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos	:= Ascan(aListBox,{|x| "0604"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos	:= Ascan(aListBox,{|x| "0105"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos	:= Ascan(aListBox,{|x| "0106"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	For nX := 1 To Len(aReg)
		cReg	+= a975Fill(A975Num2Chr(aReg[nX][4],14),14)
	Next	
	cReg  += a975Fill(,10) 	 	
	cReg 	:= a975Fill( cReg,1280) 
	a975Grava(cReg)	
Endif                      

cFilAnt := cFilAtu	
Return()  



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R36E  ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ativo - Balanço Patrimonial - Critérios em 31/12/2007      º±±
±±º          ³ PJ em Geral                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R36E(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	aFicha	:= GetSldPlGer(mv_par28, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
	If lFirst     
		aReg		:= aClone(aFicha)
		lFirst	:= .F.
    Else    
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
    EndIf
Next

If len(aReg) > 0
	cReg	:= a975Fill("R36",03) // Tipo
	cReg	+= a975Fill("E",01) // Reservado
	nPos	:= Ascan(aListBox,{|x| "0603"$x })
	cReg  += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos	:= Ascan(aListBox,{|x| "0604"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos	:= Ascan(aListBox,{|x| "0105"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos	:= Ascan(aListBox,{|x| "0106"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	For nX := 1 To Len(aReg)
		cReg	+= a975Fill(A975Num2Chr(aReg[nX][4],14),14)
	Next	
	cReg  += a975Fill(,10) 	 	
	cReg 	:= a975Fill( cReg,1168) 
	a975Grava(cReg)	
Endif                      

cFilAnt := cFilAtu	
Return()  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R37E  ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Passivo - Balanço Patrimonial - Critérios em 31/12/2007    º±±
±±º          ³ PJ em Geral                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R37E(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	aFicha	:= GetSldPlGer(mv_par29, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
	If lFirst     
		aReg		:= aClone(aFicha)
		lFirst	:= .F.
    Else    
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
    EndIf
Next

If len(aReg) > 0
	cReg	:= a975Fill("R37",03) // Tipo
	cReg	+= a975Fill("E",01) // Reservado
	nPos	:= Ascan(aListBox,{|x| "0603"$x })
	cReg  += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos	:= Ascan(aListBox,{|x| "0604"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos	:= Ascan(aListBox,{|x| "0105"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos	:= Ascan(aListBox,{|x| "0106"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	For nX := 1 To Len(aReg)
		cReg	+= a975Fill(A975Num2Chr(aReg[nX][4],14),14)
	Next	
	cReg  += a975Fill(,10) 	 	
	cReg 	:= a975Fill( cReg,832) 
	a975Grava(cReg)	
Endif                      

cFilAnt := cFilAtu	
Return()  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R38A  ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Demonstração dos Lucros ou Prejuízos Acumulados            º±±
±±º          ³ Critérios em 31/12/2007                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R38A(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	aFicha	:= GetSldPlGer(mv_par30, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
	If lFirst     
		aReg		:= aClone(aFicha)
		lFirst	:= .F.
    Else    
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
    EndIf
Next

If len(aReg) > 0
	cReg	:= a975Fill("R38",03) // Tipo
	cReg	+= a975Fill("A",01) // Reservado
	nPos	:= Ascan(aListBox,{|x| "0603"$x })
	cReg  += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos	:= Ascan(aListBox,{|x| "0604"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos	:= Ascan(aListBox,{|x| "0105"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos	:= Ascan(aListBox,{|x| "0106"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	For nX := 1 To Len(aReg)
		cReg	+= a975Fill(A975Num2Chr(aReg[nX][4],14),14)
	Next	
	cReg  += a975Fill(,10) 	 	
	cReg 	:= a975Fill( cReg,244) 
	a975Grava(cReg)	
Endif                      

cFilAnt := cFilAtu	
Return()  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R43   ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rendimentos Relativos a Serviços, Juros e Dividendos       º±±
±±º          ³ Recebidos do Brasil e do Exterior                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R43(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	aFicha	:= GetSldPlGer(mv_par31, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
	If lFirst     
		aReg		:= aClone(aFicha)
		lFirst	:= .F.
    Else    
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
    EndIf
Next

If len(aReg) > 0
	cReg	:= a975Fill("R43",03) // Tipo
	cReg	+= a975Fill(" ",01) // Reservado
	nPos	:= Ascan(aListBox,{|x| "0603"$x })
	cReg  += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos	:= Ascan(aListBox,{|x| "0604"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos	:= Ascan(aListBox,{|x| "0105"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos	:= Ascan(aListBox,{|x| "0106"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	For nX := 1 To Len(aReg)
		cReg	+= a975Fill(A975Num2Chr(aReg[nX][4],14),14)
	Next	
	cReg  += a975Fill(,10) 	 	
	cReg 	:= a975Fill( cReg,121) 
	a975Grava(cReg)	
Endif                      

cFilAnt := cFilAtu	
Return()  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R45   ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Pagtos. ou Remessas a Título de Serviços, Juros e Divid. a º±±
±±º          ³ Benef. do Brasil e do Exterior                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R45(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	aFicha	:= GetSldPlGer(mv_par32, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
	If lFirst     
		aReg		:= aClone(aFicha)
		lFirst	:= .F.
    Else    
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
    EndIf
Next     

If len(aReg) > 0
	cReg	:= a975Fill("R45",03) // Tipo
	cReg	+= a975Fill(" ",01) // Reservado
	nPos	:= Ascan(aListBox,{|x| "0603"$x })
	cReg  += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos	:= Ascan(aListBox,{|x| "0604"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos	:= Ascan(aListBox,{|x| "0105"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos	:= Ascan(aListBox,{|x| "0106"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	For nX := 1 To Len(aReg)
		cReg	+= a975Fill(A975Num2Chr(aReg[nX][4],14),14)
	Next	
	cReg  += a975Fill(,10) 	 	
	cReg 	:= a975Fill( cReg,149) 
	a975Grava(cReg)	
Endif                      

cFilAnt := cFilAtu	
Return()  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A975R61A  ºAutor  ³Mauro A. Goncalves  º Data ³  19/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rendimentos de Dirigentes, Conselheiros, Sócios ou Titular º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DIPJ                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function A975R61A(aEmpresa) 

Local cFilAtu 	:= FWCodFil()
Local nPos 		:= 0
Local cReg   
Local aFicha	:= {}
Local nX   		:= 0
Local nY   		:= 0
Local lFirst	:= .T.
Local aReg		:= {}
Local nCont 	:= 0 
	
For nX := 1 To Len(aEmpresa)
	cFilAnt	:= aEmpresa[nX][3]
	aFicha	:= GetSldPlGer(mv_par33, dDtIni, dDtFim, mv_par18,,,,,,,,,,,,,) 
 
	If lFirst     
		aReg		:= aClone(aFicha)
		lFirst	:= .F.
    Else    
		For nY:= 1 To Len(aFicha) 
	    	If nCont <= 73
	    		aReg[nY][4] += aFicha[nY][4]
	    		nCont++
	    	Else
	    		nCont := 0
	    		Exit	
	    	EndIF	
	    Next
    EndIf
Next

If len(aReg) > 0
	cReg	:= a975Fill("R61",03) // Tipo
	cReg	+= a975Fill("A",01) // Reservado
	nPos	:= Ascan(aListBox,{|x| "0603"$x })
	cReg  += a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02) // 0603 - Trimestre
	nPos	:= Ascan(aListBox,{|x| "0604"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),2,0),02)  //0604 - Coluna
	cReg	+= a975Fill(A975Num2Chr(Val(cCGC),14,0),14) // CNPJ da Matriz
	nPos	:= Ascan(aListBox,{|x| "0105"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Ano-Calendario
	nPos	:= Ascan(aListBox,{|x| "0106"$x })
	cReg	+= a975Fill(A975Num2Chr(If(!Empty(aConteudo[nPos]),Val(aConteudo[nPos]),0),1,0),01) //Declaracao Retificadora
	For nX := 1 To Len(aReg)
		cReg	+= a975Fill(A975Num2Chr(aReg[nX][4],14),14)
	Next	
	cReg  += a975Fill(,10) 	 	
	cReg 	:= a975Fill( cReg,275) 
	a975Grava(cReg)	
Endif                      

cFilAnt := cFilAtu	
Return()  
