#Include "RwMake.CH"
#Include "Fw192.CH"

#define STR0001 "Pesquisar"
#define STR0002 "Visualizar"
#define STR0003 "Produtos"
#define STR0004 "PASSE O LEITOR"
#define STR0005 "NÆo existe hist¢rico para este produto"
#define STR0006 "Consulta Estoque"
#define STR0007 "C¢digo"
#define STR0008 "Descri‡Æo de Produto"
#define STR0009 "Pre‡o"
#define STR0010 "Produto NÆo Cadastrado!"
#define STR0011 "DE CODIGO DE BARRAS"


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ DATA   ³ BOPS ³Prograd.³ALTERACAO                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³05.08.99³PROTH ³Julio W.³ TIMER no Protheus deve ser anexado ao di logo³±±
±±³05.08.99³PROTH ³Julio W.³ N„o precisa de oTimer:end() no Protheus      ³±±
±±³09.08.99³PROTH ³Julio W.³ Substituir GetSysColor() para oDlg:nClrPane  ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ lojc060	³ Autor ³ Pilar S. Albaladejo   ³ Data ³ 08.08.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Consulta de Precos													  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SigaLoja 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LojC060

  // Pesquisar / Visualizar
	PRIVATE aRotina := { { STR0001 ,"AxPesqui", 0 , 1},;
								{ STR0002,'ExecBlock("lj060Vis", .F., .F.)', 0 , 4} }
    Private lLojc060      := (ExistBlock("Lojc060"))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define o cabe‡alho da tela de atualiza‡”es						  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PRIVATE cCadastro := OemToAnsi(STR0003) // Produtos
	PRIVATE oBmp

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Endereca a funcao de BROWSE											  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	mBrowse( 6, 1,22,75,"SB1" )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Recupera a Integridade dos dados									  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	msUnlockAll( )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ lj060Vis ³ Autor ³ Pilar S. Albaladejo   ³ Data ³ 08.08.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Consulta de Precos (Usuario Final)								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ lj060Vis(ExpC1,ExpN1,ExpN2)										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Alias do arquivo											  ³±±
±±³			 ³ ExpN1 = Numero do registro 										  ³±±
±±³			 ³ ExpN2 = Opcao selecionada											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function lj060Vis( cAlias,nReg,nOpcx )

Local oDlg
Local oFnt
Local oCod
Local oMens
Local oTimer
Local oBtn
Local oButton
Local oDesc
Local oFnt1
Local oFnt2
Local oFnt3
Local oTexto
Local oPreco
Local cCod
Local cDesc
Local cPreco
Local cTexto
Local cMens := OemToAnsi(STR0004)  // PASSE O LEITOR
Local nCont := 1

Private cProd
Private cCodAux

cProd  := SB1->B1_COD
cCodAux:= cProd
cCod	 := cProd
cDesc  := Alltrim(SB1->B1_DESC)
cPreco := lj060Pr_1()
dbSelectArea("SB5")
dbSetOrder(1)
If dbSeek(xFilial("SB5")+SB1->B1_COD)
	cTexto := OemTOAnsi(Capital(SB5->B5_CEME))
Else
	cTexto := OemTOAnsi(STR0005) // NÆo existe hist¢rico para este produto
EndIf

DEFINE FONT oFnt	NAME "Arial" SIZE 25,35
DEFINE FONT oFnt1 NAME "Arial" SIZE 15,20
DEFINE FONT oFnt2 NAME "Arial" SIZE 8,14
DEFINE FONT oFnt3 NAME "Ms Sans Serif" BOLD

// Consulta Estoque
DEFINE MSDIALOG oDlg FROM 1,1 TO 453,637 TITLE STR0006 PIXEL OF oMainWnd

	@  10, 05 TO  30, 85 LABEL OemToAnsi(STR0007) PIXEL OF oDlg // C¢digo

	@  19, 11 SAY oCod   VAR cCod SIZE 70,09 OF oDlg PIXEL;
   CENTER FONT oFnt2 COLOR CLR_GREEN

   @  35, 05 TO  70,135 PIXEL OF oDlg
	@  43, 10 SAY oMens  VAR cMens SIZE 120,20 OF oDlg PIXEL;
   CENTER FONT oFnt1 COLOR CLR_HRED

   @  75, 05 TO 172,135 PIXEL OF oDlg
	@  85, 10 SAY oTexto VAR cTexto SIZE 120,80 OF oDlg PIXEL;
   FONT oFnt2 COLOR CLR_HRED

	@ 177, 05 TO 215,302 LABEL OemToAnsi(STR0008) PIXEL OF oDlg // Descri‡Æo de Produto
	@ 192, 10 SAY oDesc  VAR cDesc  SIZE 280,20 OF oDlg PIXEL;
   CENTER FONT oFnt1 COLOR CLR_HRED

   @  13,142 REPOSITORY oBmp SIZE 161,130        PIXEL OF oDlg
	@ 147,142 TO 172,302 LABEL OemToAnsi(STR0009) PIXEL OF oDlg // Pre‡o

	@ 157,149 SAY oPreco VAR cPreco	 SIZE 144,15 PIXEL OF oDlg;
   RIGHT FONT oFnt1 COLOR CLR_BLUE

	#IFDEF PROTHEUS
		oBmp:SetColor(oDlg:nClrPane,oDlg:nClrPane)
	#ELSE
		oBmp:SetColor(GetSysColor(15),GetSysColor(15))
	#ENDIF
	oBmp:lStretch := .T.

	#IFDEF PROTHEUS
		DEFINE TIMER oTimer INTERVAL 900  ACTION LJ060Timer(oMens,@cMens,@nCont,oDlg) OF oDlg
	#ELSE
		DEFINE TIMER oTimer INTERVAL 900  ACTION LJ060Timer(oMens,@cMens,@nCont) OF oMainWnd
	#ENDIF
	@ 250,01 MSGET oGet VAR cProd SIZE 74,10 OF oDlg PIXEL F3 "PRL" VALID;
							  lJ060Cod(oCod,oDesc,@cCod,@cDesc,oBmp,@cTexto,oTexto) .And.;
							  lj060Pr(oPreco,@cPreco,oGet)

	DEFINE SBUTTON FROM 250,100 oButton TYPE 1 OF oDlg ENABLE
	oButton:bGotFocus := {|| oGet:SetFocus() }

ACTIVATE MSDIALOG oDlg CENTERED ON INIT ((ShowBitMap(oBmp,SB1->B1_BITMAP,"LOJAWIN")),oTimer:Activate())

#IFNDEF PROTHEUS
	oTimer:End()
#ENDIF

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³lj060Cod	³ Autor ³ Pilar S. Albaladejo   ³ Data ³ 08.08.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Exibe descricao do produto na tela								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ lj060Cod()																  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function lj060Cod(oCod,oDesc,cCod,cDesc,oBmp,cTexto,oTexto)
Local lRet := .T.

cCodAux:= Space(15)

dbSelectArea("SB1")
dbSetOrder(1)

lAchou := dbSeek(xFilial("SB1")+cProd)

If !lAchou
	dbSelectArea("SB1")
	dbSetOrder(5)
	lAchou := dbSeek(xFilial("SB1")+cProd)
	cCodAux:= SB1->B1_COD
EndIf

If lAchou
	cCod	:= cProd
	cDesc := Alltrim(B1_DESC)
	ShowBitMap(oBmp,SB1->B1_BITMAP,"LOJAWIN")

	dbSelectArea("SB5")
	dbSetOrder(1)

	If dbSeek(xFilial("SB5")+cProd)
		cTexto := OemToAnsi(Capital(SB5->B5_CEME))
	Else
	  If dbSeek(xFilial("SB5")+cCodAux)
		  cTexto := OemToAnsi(Capital(SB5->B5_CEME))
	  Else
		  cTexto := OemToAnsi(STR0005)  // NÆo existe hist¢rico para este produto
	  EndIf
	EndIf
Else
	If lLojc060
		lRet := ExecBlock("Lojc060",.F.,.F.)
		cCod	:= cProd
		cDesc := Alltrim(B1_DESC)
		ShowBitMap(oBmp,SB1->B1_BITMAP,"LOJAWIN")

		dbSelectArea("SB5")
		dbSetOrder(1)

		If dbSeek(xFilial("SB5")+cProd)
			cTexto := OemToAnsi(Capital(SB5->B5_CEME))
		Else
		  If dbSeek(xFilial("SB5")+cCodAux)
			 cTexto := OemToAnsi(Capital(SB5->B5_CEME))
		  Else
			 cTexto := OemToAnsi(STR0005)  // NÆo existe hist¢rico para este produto
		  EndIf
		EndIf
	Else
		cDesc := Alltrim(OemToAnsi(STR0010))  // Produto NÆo Cadastrado
		cProd := Space(15)
		cCodAux:= cProd
		cCod	:= cProd
		ShowBitMap(oBmp,"LOJAWIN")
		cTexto := OemToAnsi(STR0010)          // Produto NÆo Cadastrado
	EndIf
EndIf

dbSelectArea("SB1")
dbSetOrder(1)

oDesc:Refresh()
oCod:Refresh()
oBmp:lVisible:=.t.
oBmp:Refresh()
oTexto:Refresh()

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³lj060Pr	³ Autor ³ Pilar S. Albaladejo   ³ Data ³ 08.08.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Exibe preco do produto na tela									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ lj060Pr()																  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function lj060Pr(oPreco,cPreco,oGet)

dbSelectArea("SB0")
dbSetOrder(1)

If dbSeek(xFilial("SB0")+cProd)
	cPreco := GetMv("MV_SIMB1")+ " " + Alltrim(Str(B0_PRV1,17,2))
Else
  If dbSeek(xFilial("SB0")+cCodAux)
	 cPreco := GetMv("MV_SIMB1")+ " " + Alltrim(Str(B0_PRV1,17,2))
  Else
	 cPreco := GetMv("MV_SIMB1")+ "  0,00"
  EndIf
EndIf

oPreco:Refresh()
cProd := Space(15)
oGet:Refresh()

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³lj060Pr	³ Autor ³ Pilar S. Albaladejo   ³ Data ³ 08.08.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Exibe preco do produto na tela									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ lj060Pr()																  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function lj060Pr_1()
Local cPreco

dbSelectArea("SB0")
dbSetOrder(1)

If dbSeek(cFilial+cProd)
	cPreco := GetMv("MV_SIMB1")+ " " + Alltrim(Str(B0_PRV1,17,2))
Else
  If dbSeek(cFilial+cCodAux)
	 cPreco := GetMv("MV_SIMB1")+ " " + Alltrim(Str(B0_PRV1,17,2))
  Else
	 cPreco := GetMv("MV_SIMB1")+ "  0,00"
  EndIf
Endif

Return cPreco

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³lj060Timer³ Autor ³ Fernando Godoy		  ³ Data ³ 23.07.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Mostra mensagem animada 											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ lj060Timer																  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function LJ060Timer(oMens,cMens,nCont,oLocalDlg)

If nCont == 1
	cMens := STR0004                     // PASSE O LEITOR
	nCont := 0
	#IFDEF PROTHEUS
		oMens:SetColor(CLR_HRED,oLocalDlg:nClrPane)
	#ELSE
		oMens:SetColor(CLR_HRED,GetSysColor(15))
	#ENDIF
ElseIf nCont == 0
	cMens := STR0011                     // DE CODIGO DE BARRAS
	nCont := 1
	#IFDEF PROTHEUS
		oMens:SetColor(CLR_HBLUE,oLocalDlg:nClrPane)
	#ELSE
		oMens:SetColor(CLR_HBLUE,GetSysColor(15))
	#ENDIF
EndIf

oMens:Refresh()
oGet:SetFocus()

Return .T.