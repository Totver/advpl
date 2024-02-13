#INCLUDE "rwmake.ch"

User Function Logo()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus( {|| ImprimeLogo()})

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP5 IDE            º Data ³  06/05/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ImprimeLogo()

Private oFont, cCode

nHeight    := 15
lBold      := .F.
lUnderLine := .F.
lPixel     := .T.

Cour		  := "Courier New"
oFont      := TFont():New( "Arial",,nHeight,,lBold,,,,,lUnderLine )
oFontTexto := TFont():New( "Times New Roman",,28,,.t.,,,,,.t. )
oFt1b		  := TFont():New( Cour ,, 6 ,,.t.,,,,,.f. )

oPrn := TMSPrinter():New()

If MsgYesNo("Deseja imprimir Codigo de Barra ?")
	MsBar("CODE128",2,15, "000001",oPrn,NIL,NIL,NIL,NIL,NIL,NIL,NIL,"A", .F.)
// MsBar("EAN13", 3, 3,"123456789012",oPrn,NIL,NIL,NIL,NIL,NIL,.T.,NIL,NIL)
Else
   oPrn:SayBitmap( 400,400, "LogoSigB.Bmp",1300,900 )
   oPrn:Say( 20, 20, " ",oFont,100 ) // startando a impressora
   oPrn:Box( 030, 2900, 750,4600 )
   oPrn:Say( 045, 3000, "Impressao de Logo", oFontTexto, 100)
   oPrn:Say( 200, 230, Repli('_',161), oFontTexto,100)   
   oPrn:Say( 320, 230, Repli('_',161), oFt1b,100)
Endif
oPrn:EndPage()
oPrn:StartPage()

// oPrn:Setup() // para configurar impressora
oPrn:Preview()
// oPrn:Print() // Para enviar impressao sem visualizar 

Ms_flush()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºExecblock ³EFABA03 Autor³ Douglas de OLiveira     º Data ³  06/05/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP5 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function PedidoBmp()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("SC9")

RptStatus({|| RunReport()})

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP5 IDE            º Data ³  06/05/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport()

Private oFont, cCode
nHeight:=15
lBold:= .F.
lUnderLine:= .F.
lPixel:= .T.
lPrint:=.F.
nSedex := 1

oFont:= TFont():New( "Arial",,nHeight,,lBold,,,,,lUnderLine )
oFont3:= TFont():New( "Arial",,12,,.t.,,,,,.f. )
oFont5:= TFont():New( "Arial",,10,,.f.,,,,,.f. )
oFont9:= TFont():New( "Arial",,8,,.f.,,,,,.f. )

oFont1:= TFont():New( "Times New Roman",,28,,.t.,,,,,.t. )
oFont2:= TFont():New( "Times New Roman",,14,,.t.,,,,,.f. )
oFont4:= TFont():New( "Times New Roman",,20,,.t.,,,,,.f. )
oFont7:= TFont():New( "Times New Roman",,18,,.t.,,,,,.f. )
oFont11:=TFont():New( "Times New Roman",,18,,.t.,,,,,.t. )

oFont6:= TFont():New( "HAETTENSCHWEILLER",,10,,.t.,,,,,.f. )

oFont8:=  TFont():New( "Free 3 of 9",,44,,.t.,,,,,.f. )
oFont10:= TFont():New( "Free 3 of 9",,38,,.t.,,,,,.f. )

oPrn := TMSPrinter():New()

_cPedOld := ""

DbSelectArea("SC9")
DbGoTop()
SetRegua(RecCount())

While !EOF()
	
	IncRegua()
	
// If SC9->C9_OK!=cMark
//    SC9->( dbSkip() )
//    Loop
// endIf
	
	nLin  := 0
	ImpCabPed()  // impressao do cabeçalho
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	_cPedOld := UPPER( SC9->C9_PEDIDO )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa While no mesmo pedido³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	n := 1 // somente imprimir 10 items por pick list
   nPeso    := 0
	aEsteira := {}
	nEsteira := 0
	lContrato := .t.  // preciso saber se neste pedido existe algum produto que nao seja nem livro nem CD
	
	// tratamento para saber qual contrato do correio pegar
	// se for somente livro - a4_contr3 e a4_contr4 ( 2 )
	// se for somente cd ou grupo de cartucho/brinquedo - a4_contr5 e a4_contr6 ( 3 )
	// qq outro a4_contr1 e a4_contr2 ( 1 )
	DbselectArea("SB1")
	DbSetOrder(1)
	DbSeek(xFilial("SB1")+SC9->C9_PRODUTO,.F.)

   If .F. // Inicio de tratamentos especificos

	If ALLTRIM( SB1->B1_DEPTO ) == "05"  // Livros
		lSedex    :=  2  // que identifica como livros
	ElseIf ALLTRIM( SB1->B1_DEPTO ) $ "03.04" .OR. ALLTRIM( SB1->B1_GRPROD ) =="061002" // CD.DVD.VHS.CARTUCHO GAMES
		lSedex    :=  3  // que identifica como CD.DVD.VHS.CARTUCHO GAMES
	Else
		lSedex    :=  1  // qq
	ENDIF
	
   Endif // Fim de tratamentos especificos

	dbSelectArea("SC9")
	While SC9->C9_PEDIDO == _cPedOld
		
		If n > 10  // Salto de Página. Neste caso o formulario com 10 itens...
			ImpRoda()  // ao final de cada pedido imprimir o rodape
			oPrn:EndPage()
			oPrn:StartPage()
			ImpCabPed()
			nPeso := 0
			nLin  := 0
			n     := 0
		Endif
		ImpDetped()
		
		DbSelectArea("SC9")
		DbSkip()
		n++
	Enddo
	
	// alimentando o label de esteiras
	aEsteira := aSort(aEsteira,,,{|x,y| x[1] < y[1]})
	cEsteira := ""
	for i := 1 to len(aEsteira)
		cEsteira += aEsteira[i,1]+if( i <> len(aEsteira), "/","" )
	Next
	
	oPrn:Say( 915, 2950, "Esteira: "+cEsteira,oFont1,100  )
	
	ImpRoda()  // ao final de cada pedido imprimir o rodape
	
// if SC9->( !eof() )
		oPrn:EndPage()
		oPrn:StartPage()
// EndIf
   DbSkip()
	
EndDo

//oPrn:Setup() // para configurar impressora
oPrn:Preview()
//oPrn:Print() // descomentar esta linha para imprimir

MS_FLUSH()

If MsgBox ("Impressao realizada com sucesso?","Atencao","YESNO")
	DbSelectArea("SC9")
	DbGoTop()
   While .F. // !EOF()
		RecLock("SC9",.F.)
      SC9->C9_IMPPCK := "S"
		// SC9->C9_OK    := Space(2)
		MsUnlock()
		DbSelectArea("SC9")
		DbSkip()
	Enddo
	DbGoTop()
Endif

Return

*********************************************
Static Function ImpCabPed()

DbSelectArea("SC5")
DbSetOrder(1)
DbSeek(xFilial("SC5")+SC9->C9_PEDIDO,.F.)
DbSelectArea("SA4")
DbSetOrder(1)
DbSeek(xFilial("SA4")+SC5->C5_TRANSP,.F.)
DbSelectArea("SC9")

cBitMap:= "\Imagens\LogoSiga.Bmp"

oPrn:SayBitmap( 400,400,cBitMap,1300,900 )
oPrn:Say( 20, 20, " ",oFont,100 ) // startando a impressora
oPrn:Box( 030, 2900, 750,4600 )
oPrn:Say( 045, 3000, "PEDIDO: "+SC9->C9_PEDIDO,oFont1,100  )

MSBAR("CODE128",2,15,SC9->C9_PEDIDO,oPrn,NIL,NIL,NIL,NIL,NIL,NIL,NIL,"A",lPrint )

oPrn:Box( 900, 2900, 1250,4600 )

oPrn:Say( 1400, 100, "TRANSPORTADORA : ",oFont4,100)
//oPrn:Say( 1400, 2950, Alltrim( SA4->A4_NOME ),oFont1,100)
oPrn:Say( 1350, 1700, SubStr( SA4->A4_NOME,1,25 ),oFont1,100)

oPrn:Box( 1700, 100, 1705,4600 )
oPrn:Say( 1750, 100, "It", oFont,100)
oPrn:Say( 1750, 250, "Produto", oFont,100)
oPrn:Say( 1750, 900, "Qtd.", oFont,100)
oPrn:Say( 1750, 1150, "Depto.", oFont,100)
oPrn:Say( 1750, 2000, "Descricao Produto", oFont,100)
oPrn:Say( 1750, 3600, "Numero de Serie", oFont,100)
oPrn:Box( 1900, 100, 1905,4600 )
Return


//********************************************************************************
//³FUNCAO: ImpDetPed() - Responsavel Pela Impressão dos Itens³
//********************************************************************************

Static function ImpDetPed()

DbselectArea("SB1")
DbSetOrder(1)
DbSeek(xFilial("SB1")+SC9->C9_PRODUTO,.F.)

If .F. // Inicio de tratamentos especificos

If SB1->B1_DEPTO == "99" .or. SubStr(SB1->B1_COD,1,2)= "99"  // suporte a informatica ou produto de consumo interno
	n--
	Return
EndIf

If !EMPTY(SB1->B1_DEPTO)
	_cDpto :=Alltrim(Tabela("ZX",SB1->B1_DEPTO))
	_cDpto := Left(_cDpto,15)
ENDIF

If !ALLTRIM( SB1->B1_DEPTO ) $ "03.05"  // 03 - Cd's e 05 - Livros
	lContrato := .f.
	// se qq produto for diferente de 03.05 o nr. do contrato da inter couriers devera ser diferente
EndIf

If SA4->A4_TPETIQ == "000001" .and. lSedex <> 1 // se for correio e nao for qq
	
	If ALLTRIM( SB1->B1_DEPTO ) == "05"  // Livros
		lSedex    :=  2  // que identifica como livros
	ElseIf ALLTRIM( SB1->B1_DEPTO ) $ "03.04" .OR. ALLTRIM( SB1->B1_GRPROD ) =="061002" // CD.DVD.VHS.CARTUCHO GAMES
		lSedex    :=  3  // que identifica como CD.DVD.VHS.CARTUCHO GAMES
	Else
		lSedex    :=  1  // qq
	ENDIF
	
EndIf

dbSelectArea("SX5")
dbSeek(xFilial("SX5")+"ZN")

while SX5->X5_TABELA == "ZN"
	If ALLTRIM( SB1->B1_DEPTO ) $ SX5->X5_DESCRI  // este produto esta sendo embalado nesta esteira
		if ascan( aEsteira, {|x| x[1] == ALLTRIM( SX5->X5_CHAVE ) } ) == 0
			Aadd( aEsteira, {ALLTRIM( SX5->X5_CHAVE ) } )
		EndIf
	EndIf
	SX5->( dbskip() )
endDo

Endif // Fim de tratamentos especificos

DbSelectArea("SC9")
nLin += 150
oPrn:Say( 1900+nLin, 100, SC9->C9_ITEM,oFont5,100  )
oPrn:Say( 1900+nLin, 250, SC9->C9_PRODUTO,oFont5,100  )
oPrn:Say( 1900+nLin, 900, STRZERO(SC9->C9_QTDLIB,3),oFont5,100  )
If .F. .And. !Empty(SB1->B1_DEPTO)
	oPrn:Say( 1900+nLin, 1150, Left( _cDpto, 15 ),oFont5,100  )
Endif
oPrn:Say( 1900+nLin, 2000, Left(SB1->B1_DESC,30),oFont5,100  )
if .F. .And. SB1->B1_COLETSN == "S"
	oPrn:Say( 1900+nLin, 3600, Repli('_',25),oFont5,100  )
EndIf
// nPeso += SB1->B1_PESOB

Return

//********************************************************************************
//³FUNCAO: ImpRoda - Responsavel Pela Impressão do Rodapé
//********************************************************************************

Static function ImpRoda()

cPed := SubStr(_cPedOld,1,1)
cContrato := ""
nSedexI   := ""

If .F. // Inicio de tratamentos especificos

If SA4->A4_TPETIQ == "000001" // Se Correio
	
	If Empty( SC5->C5_SEDEX ) // não é reimpressão
		
		// se for somente livro - a4_contr03 e a4_CONTR04 ( 2 )
		// se for somente cd ou grupo de cartucho/brinquedo - a4_CONTR05 e a4_CONTR06 ( 3 )
		// qq outro a4_CONTR01 e a4_CONTR02 ( 1 )
		
		If lSedex == 1
			nSedexI := Alltrim( SA4->A4_CONTR01 )
			nSedexF := Alltrim( SA4->A4_CONTR02 )
		ElseIf lSedex == 2
			nSedexI := Alltrim( SA4->A4_CONTR03 )
			nSedexF := Alltrim( SA4->A4_CONTR04 )
		Else
			nSedexI := Alltrim( SA4->A4_CONTR05 )
			nSedexF := Alltrim( SA4->A4_CONTR06 )
		EndIf
		
		nSedexI := StrZero( Val( nSedexI )+ 1, 8 )
		If nSedexI > nSedexF
			MsgBox ("Não existe mais número disponível no contrato do Correio. Este processo será abortado","Atençao","ALERT")
			Return
		EndIf
		
		// calculo do digito verificador do correio
		aDigit := {8, 6, 4, 2, 3, 5, 9, 7}
		nControle := 0
		for i := 1 to 8
			nControle += Val( subStr(nSedexI,i,1) )*aDigit[i]
		next
		
		nControle := nControle%11              // resto da divisao da soma por 11
		If nControle >1
			// se o resto da divisao for 1 ou zero tera um tratamento diferenciado
			nControle := 11 - nControle  // o que sobrou eu subtraio 11 para obter o valor do digito
		Else
			// se o resto for 1 o digito de controle sera 0 caso contrario 5
			nControle := if( nControle ==1, 0, 5 )
		EndIf
		cContrato := "*SE"+nSedexI+Str( nControle,1 )+"BR*" // composicao do numero do contrato
		
	else
		cContrato := "*"+ALLTRIM(SC5->C5_SEDEX)+"*"
	EndIf
ElseIf SA4->A4_TPETIQ == "000002" // Inter Couriers
	
	//SedexI   := ""
	If !Empty( SC5->C5_SEDEX ) // não é reimpressão
		nSedexI := Alltrim( SC5->C5_SEDEX )
	EndIf
	//se ja existir um numero do contrato dentro do SC5 somente o reimprimo
	//se nao existir vou buscar do cadastro de transportadora
	
	If cPed == "M" // pedido da MicroSite
		If lcontrato // só tem livros ou Cds
			nSedexI   := if( Empty(nSedexI),StrZero(Val( ALLTRIM( SA4->A4_CONTR03 ))+1,6), nSedexI )
			cContrato := ConvAlfa( nSedexI+cPed+"C"+_cPedOld )
		Else
			nSedexI   := if( Empty(nSedexI),StrZero(Val( ALLTRIM( SA4->A4_CONTR04 ))+1,6), nSedexI )
			cContrato := ConvAlfa( nSedexI+cPed+"O"+_cPedOld )
		EndIf
	ElseIf cPed == "F" // qq outra emrpesa nao me interessa
		If lcontrato // só tem livros ou Cds
			nSedexI   := if( Empty(nSedexI),StrZero(Val( ALLTRIM( SA4->A4_CONTR01 ))+1,6), nSedexI )
			cContrato := ConvAlfa( nSedexI+cPed+"C"+_cPedOld )
		Else
			nSedexI   := if( Empty(nSedexI),StrZero(Val( ALLTRIM( SA4->A4_CONTR02 ))+1,6), nSedexI )
			cContrato := ConvAlfa( nSedexI+cPed+"O"+_cPedOld )
		EndIf
	EndIf
	
	cContrato := TrackNumber( cContrato )
ElseIf SA4->A4_TPETIQ == "000003" // Speed Cargo
	cContrato := _cPedOld
EndIf // Se Correio

oPrn:Say( 4150, 470, PADC(SA4->A4_DESC1ET,45),oFont6,100)
oPrn:Say( 4250, 880, PADC(SA4->A4_DESC2ET,45),oFont6,100)
oPrn:Say( 4350, 750, cContrato,oFont7,100)
If SA4->A4_TPETIQ == "000001" // correio - sedex
	MSBAR("CODE128",19.7,3.5,cContrato,oPrn,NIL,NIL,NIL,NIL,NIL,NIL,NIL,"A",lPrint )
	oPrn:Say( 5020, 420, cContrato,oFont8,400)
ElseIf SA4->A4_TPETIQ $ "000002.000003" // inter couriers
	//      MSBAR("CODE3_9",19.7,3,cContrato,oPrn,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,lPrint )
	oPrn:Say( 4700, 300, "*"+cContrato+"*",oFont10,400)
EndIf

Endif // Fim de tratamentos especificos

oPrn:Say( 5300, 550,"Pedido: "+SC5->C5_NUM+"   Peso : " +;
                     Trans(nPeso + 0.1, "@e 999.999")+" Kg",oFont5,100)

// remetente
oPrn:Say( 5410, 550, "Remetente",oFont3,100)
oPrn:Say( 5520, 550,Alltrim( SM0->M0_NOMECOM)+"  ( Fone 0800-176661 )",oFont9,100)
oPrn:Say( 5600, 550,ALLTRIM(SM0->M0_ENDCOB)+" - "+ALLTRIM(SM0->M0_BAIRCOB),oFont9,100)
oPrn:Say( 5680, 550,Substr(SM0->M0_CEPCOB,1,5)+"-"+Substr(SM0->M0_CEPCOB,6,3)+" - "+Alltrim(SM0->M0_CIDCOB)+" - "+(SM0->M0_ESTCOB),oFont9,100)

oPrn:Say( 5750, 550, "Destino",oFont11,100)
cAlias := Alias()
dbSelectArea( "SA1" )
SA1->( dbSeek( xFilial("SA1")+SC5->C5_CLIENTE ) )

vbai    := AllTrim(SA1->A1_BAIRRO)
vbai    := If(!EMPTY(vbai),vbai+", ","")
cEndere := Subs(AllTrim(SA1->A1_END),1,47)+" - " + vBai
vCidEst := Alltrim(SA1->A1_MUN)+" - " +SA1->A1_EST
vcep    := SA1->A1_CEP
vcep    := Substr(vcep, 1, 5) + "-" + If(Val(Substr(vcep, 6, 3)) = 0, "000", Substr(vcep, 6, 3))

oPrn:Say( 5900, 550, SA1->A1_NOME,oFont5,100)
oPrn:Say( 6000, 550, SubStr( cEndere, 1, 45 ),oFont5,100)
oPrn:Say( 6100, 550, vcep+" - "+vCidEst,oFont5,100)

If .F. .And. SA4->A4_TPETIQ == "000001" // correio - sedex
	MSBAR("CODE128",26.7,4.2,"*"+SA1->A1_CEP+"*",oPrn,NIL,NIL,NIL,NIL,NIL,NIL,NIL,"B",lPrint )
EndIf

dbSelectArea( cAlias )
// Se Transportadora - ainda nao definido - 29/Maio/2000

oPrn:Say( 4400, 3200, "Data.: "+DTOC(dDataBase), oFont4, 100)
oPrn:Say( 4600, 3200, "Hora.: "+TIME(),oFont4,100)
oPrn:Box( 5000, 3200, 5700, 4500 )
oPrn:Say( 5050, 3250, "Visto Conferente",oFont4,100)

oPrn:Say( 5400, 3250, "________________",oFont4,100)

// atualizando o arquivo de parametros com o novo valor de nSedexI

cAlias := Alias()

If .F. // Inicio de tratamentos especificos
   RecLock("SA4", .f.)
   If SA4->A4_TPETIQ == "000001" .and. !Empty(nSedexI)// Correio
      If lSedex == 1
         SA4->A4_CONTR01 := nSedexI
      ElseIf lSedex == 2
         SA4->A4_CONTR03 := nSedexI
      Else
         SA4->A4_CONTR05 := nSedexI
      EndIf
   EndIf
   MsUnlock()
   // gravando o numero do contrato do correio no SC5
   // SC5 já está posiocionado em cima
   RecLock("SC5", .f.)
   If SA4->A4_TPETIQ == "000001" // Sedex
      SC5->C5_SEDEX := SubStr(cContrato,2,13)
   ElseIf SA4->A4_TPETIQ $ "000002.000003" // Inter Couriers ou Speed
      SC5->C5_SEDEX := cContrato
   EndIf
   MsUnlock()
Endif

dbSelectArea(cAlias)

Return

*********
Static Function ConvAlfa( cString )

i := 0
n := 0
cTexto := ""
cstring := ALLTRIM( UPPER( cString ) )
aAlfa := {}
Aadd( aAlfa, {"A","1"} )
Aadd( aAlfa, {"B","2"} )
Aadd( aAlfa, {"C","3"} )
Aadd( aAlfa, {"D","4"} )
Aadd( aAlfa, {"E","5"} )
Aadd( aAlfa, {"F","6"} )
Aadd( aAlfa, {"G","7"} )
Aadd( aAlfa, {"H","8"} )
Aadd( aAlfa, {"I","9"} )
Aadd( aAlfa, {"J","0"} )
Aadd( aAlfa, {"K","1"} )
Aadd( aAlfa, {"L","2"} )
Aadd( aAlfa, {"M","3"} )
Aadd( aAlfa, {"N","4"} )
Aadd( aAlfa, {"O","5"} )
Aadd( aAlfa, {"P","6"} )
Aadd( aAlfa, {"Q","7"} )
Aadd( aAlfa, {"R","8"} )
Aadd( aAlfa, {"S","9"} )
Aadd( aAlfa, {"T","0"} )
Aadd( aAlfa, {"U","1"} )
Aadd( aAlfa, {"V","2"} )
Aadd( aAlfa, {"W","3"} )
Aadd( aAlfa, {"X","4"} )
Aadd( aAlfa, {"Y","5"} )
Aadd( aAlfa, {"Z","6"} )

For i := 1 to len( cString )
	n := Ascan( aAlfa, {|x| x[1] == SubStr(cString,i,1)} )
	if n == 0
		cTexto += SubStr( cString,i,1 )
	Else
		cTexto += aAlfa[n,2]
	EndIf
Next

Return( cTexto )

********
Static Function TrackNumber( cString )

// funcao que calcula os digitos de verificacao da transportadora Inter Couriers

n := 0
i := 0
cString := Alltrim( cString )
For i := 0 to Len( cString )
	n += Val( SubStr(cString,i,1) )
Next
n := Abs(n) // tirando o sinal negativo que eventualmente aparecer
n := 99 - n
n := StrZero( n, 2 )

Return( cString+Substr( n,2,1)+SubStr( n,1,1) )

*****************************************************************************
/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MSBAR       ³ Autor ³ ALEX SANDRO VALARIO ³ Data ³  06/99   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime codigo de barras                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 01 cTypeBar String com o tipo do codigo de barras          ³±±
±±³          ³             "EAN13","EAN8","UPCA" ,"SUP5"   ,"CODE128"     ³±±
±±³          ³             "INT25","MAT25,"IND25","CODABAR" ,"CODE3_9"        ³±±
±±³          ³ 02 nRow     Numero da Linha em centimentros                ³±±
±±³          ³ 03 nCol     Numero da coluna em centimentros                   ³±±
±±³          ³ 04 cCode    String com o conteudo do codigo                ³±±
±±³          ³ 05 oPr      Objeto Printer                                 ³±±
±±³          ³ 06 lcheck   Se calcula o digito de controle                ³±±
±±³          ³ 07 Cor      Numero  da Cor, utilize a "common.ch"          ³±±
±±³          ³ 08 lHort    Se imprime na Horizontal                       ³±±
±±³          ³ 09 nWidth   Numero do Tamanho da barra em centimetros      ³±±
±±³          ³ 10 nHeigth  Numero da Altura da barra em milimetros        ³±±
±±³          ³ 11 lBanner  Se imprime o linha em baixo do codigo          ³±±
±±³          ³ 12 cFont    String com o tipo de fonte                     ³±±
±±³          ³ 13 cMode    String com o modo do codigo de barras CODE128  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ImpressÆo de etiquetas c¢digo de Barras para HP e Laser    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

MSBAR("EAN13"  , 10  , 16 ,"123456789012",oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL)
MSBAR("EAN13"  , 2   , 08 ,"123456789012",oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL)
MSBAR("EAN8"   , 5   ,  8 ,"1234567"     ,oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL)
MSBAR("EAN8"   , 19  ,  1 ,"1234567"     ,oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL)
MSBAR("UPCA"   , 15  ,  1 ,"07000002198" ,oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL)
MSBAR("UPCA"   , 15  ,  6 ,"07000002198" ,oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL)
MSBAR("EAN13"  , 20  , 13 ,"123456789012",oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL)
MSBAR("EAN13"  , 16  , 13 ,"123456789012",oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL)
MSBAR("SUP5"   , 12  ,  1 ,"100441"      ,oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL)
MSBAR("SUP5"   , 12  ,  3 ,"100441"      ,oPr,NIL,NIL,.F.,NIL,NIL,NIL,NIL,NIL)
MSBAR("CODE128",  1  ,  1 ,"123456789011010" ,oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL)
MSBAR("CODE128",  3  ,  1 ,"12345678901" ,oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,"A")
MSBAR("CODE128",  5  ,  1 ,"12345678901" ,oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,"B")
MSBAR("CODE3_9",  7.5,  1 ,"12345678901" ,oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL)
MSBAR("CODABAR",  8  ,  7 ,"A12-34T"     ,oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL)
MSBAR("CODE128", 10  , 11 ,"12345678901" ,oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL)
MSBAR("CODE3_9", 17  ,  9 ,"123456789012",oPr,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL)
MSBAR("INT25"  , 21  ,  3 ,"123456789012",oPr,,,.t.)
MSBAR("MAT25"  , 23  ,  3 ,"123456789012",oPr,,,.t.)
MSBAR("IND25"  , 23  , 15 ,"123456789012",oPr,,,.t.)
*/
