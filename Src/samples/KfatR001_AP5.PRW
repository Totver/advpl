#include "rwmake.ch"
#include "common.ch"

User Function KfatR001()        // incluido pelo assistente de conversao do AP5 IDE em 12/02/01

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("WNREL,NBASEIPI,CSTRING,TAMANHO,TITULO,ARETURN")
SetPrvt("NOMEPROG,LIMITE,NPAG,NLASTKEY,NBEGIN,ALINHA")
SetPrvt("LCONTINUA,NLIN,CPERG,NDESC,NREC,NITEM")
SetPrvt("FLAG,CFOPEN,CTEXTO,MV_PAR01,ACOMBO,CDESC1")
SetPrvt("CDESC2,CDESC3,CIMPRI,CIMPRI2,CIMPRI3,CIMPRI4")
SetPrvt("CIMPRI5,CIMPRI6,CIMPRI7,CIMPRI8,CIMPRI9,NVALUNIT")
SetPrvt("NVALOR,NTOTAL,NIPI,NTOTIPI,CAUX,MCOND")
SetPrvt("II,_numjk,Oprn")
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ KFATR001 ³ Autor ³ Fabio Roberto Fachini ³ Data ³ 12.02.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao de Recibos dos Contratos                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico J.Kobara                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ANALISTA     ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³      ³                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
wnrel     := "KFATR001"
nBaseIPI  := 0
cString   := "SZ2" // arquivo de onde serao pegos os campos p/ filtro
Tamanho   := "P"
Titulo    := "Emissao de Recibos de Contratos"
aReturn   := {"Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
nomeprog  := "KFATR001"
Limite    := 132
nPag      := 1
nLastKey  := 0
nBegin    := 0
aLinha    := { }
lContinua := .T.
nLin 	  := 99
cPerg     := ""
nDesc     := 0
nRec      := recno()
nItem     := 0
flag      := .F.
_numjk    := space(6)
cFOpen    := "obs.txt"
cTexto    := memoread(cFOpen)
cCombo    := "Parcelas"
TipoRec   := {"Adiantamento","Parcelas"}
_nNumrec  := space(6)
_itemc    := space(2)
_cNumTit  := space(10)
*
do while .t.
	@ 116,090 To 516,707 Dialog mkwdlg Title OemToAnsi("Recibo de Contratos")
	@ 5,7 To 65,299 Title OemToAnsi("Dados do Contrato p/ Emissao do Recibo")
	@ 17,16  Say OemToAnsi("Contrato:") Size 35,8
	@ 17,105 Say OemToAnsi("Item:") Size 20,8
	@ 17,160 Say OemToAnsi("Recibo:") Size 35,8
	@ 29,16  Say OemToAnsi("Titulo:") Size 29,8
	@ 29,160 Say OemToAnsi("Valor:") Size 35,8
	@ 41,16  Say OemToAnsi("Cliente:") Size 35,8
	@ 53,16  Say OemToAnsi("Evento:") Size 29,8
	@ 53,100 Say OemToAnsi("Descricao:") Size 32,8
	*
	@ 17,67  Get _numjk picture '@R 9999-99' f3 "SZ2"
	@ 17,135 Get _itemc  picture '99'
	@ 17,190 Get _nNumrec Size 30,10 Picture '@R 9999-99'
	@ 29,67  Get _cNumtit picture '@!' f3 "SE1"
	*
	@ 17,263 BmpButton Type 1 Action close(mkwdlg)
	@ 39,263 BmpButton Type 2 Action oCancel()
	Activate Dialog mkwdlg centered
	*
	IF FLAG
		RETURN
	ENDIF
	*
	dbselectArea("SZ2")
	dbsetorder(1)
	dbseek(xfilial()+_numjk+_itemc)
	if !found()
		msgbox("Contrato nao encontrado !")
		loop
	endif
	*
	if SZ2->Z2_SIT == "E"
		msgbox("Contrato esta encerrado !")
		loop
	endif
	*
	_cCliente:= sz2->z2_nomecli
	_cEvento := sz2->z2_evento
	_cDescEve:= sz2->z2_desceve
	*
	dbselectArea("SE1")
	dbsetorder(1)
	dbSeek(xfilial()+_cNumTit)
	*
	if !found()
		msgbox("Titulo nao Encontrado !")
		loop
	elseif _numjk <> SE1->E1_NUMJK .or. _itemc <> SE1->E1_ITEMC
		msgbox("Titulo nao corresponde ao Contrato selecionado ! Verifique !")
		loop
	else
		_nValor  := SE1->E1_SALDO
	endif
	*
	@ 116,090 To 516,707 Dialog mkwdlg2 Title OemToAnsi("Recibo de Contratos")
	@ 5,7 To 65,299 Title OemToAnsi("Dados do Contrato p/ Emissao do Recibo")
	@ 17,16  Say OemToAnsi("Contrato:") Size 35,8
	@ 17,105 Say OemToAnsi("Item:") Size 20,8
	@ 17,160 Say OemToAnsi("Recibo:") Size 35,8
	@ 29,16  Say OemToAnsi("Titulo:") Size 29,8
	@ 29,160 Say OemToAnsi("Valor:") Size 35,8
	@ 41,16  Say OemToAnsi("Cliente:") Size 35,8
	@ 53,16  Say OemToAnsi("Evento:") Size 29,8
	@ 53,100 Say OemToAnsi("Descricao:") Size 32,8
	*
	@ 17,67  Say  _numjk picture '@R 9999-99'
	@ 17,135 Say _itemc  picture '99'
	@ 17,190 Say _nNumrec picture '@R 9999-99'
	@ 29,67  Say _cNumtit picture '@!'
	@ 29,190 Say _nValor size 40,8  Picture '@R 999,999,999.99'
	@ 41,67  Say _cCliente  Size 200,10
	@ 53,67  get _cevento Size 25,10  //F3 "74"
	@ 53,140 get _cDescEve Size 150,10
	*
	@ 075,014 Say OemToAnsi("Arquivo c/ Especificacoes: "+cFOpen+Space(100))     Object oNome
	@ 085,007 Get cTexto   Size 250,100  MEMO                 Object oMemo
	
	@ 080,263 Button OemToAnsi("_Abrir...")       Size 36,16 Action FRAbre()// Substituido pelo assistente de conversao do AP5 IDE em 12/02/01 ==> @ 045,263 Button OemToAnsi("_Abrir...")       Size 36,16 Action Execute(FRAbre)
	@ 100,263 Button OemToAnsi("_Fechar")         Size 36,16 Action FRFecha()// Substituido pelo assistente de conversao do AP5 IDE em 12/02/01 ==> @ 063,263 Button OemToAnsi("_Fechar")         Size 36,16 Action Execute(FRFecha)
	@ 120,263 Button OemToAnsi("_Salvar")         Size 36,16 Action FRSalva()// Substituido pelo assistente de conversao do AP5 IDE em 12/02/01 ==> @ 081,263 Button OemToAnsi("_Salvar")         Size 36,16 Action Execute(FRSalva)
	@ 140,263 Button OemToAnsi("_Salvar Como...") Size 36,16 Action FRSalvaComo()// Substituido pelo assistente de conversao do AP5 IDE em 12/02/01 ==> @ 099,263 Button OemToAnsi("_Salvar Como...") Size 36,16 Action Execute(FRSalvaComo)
	@ 170,263 BmpButton Type 1 Action Close(mkwDlg2)
	
	Activate Dialog mkwdlg2 centered
	exit
Enddo
*
// PARAMETROS DO RELATORIO

Titulo := PadC(OemToAnsi("Recibo de Contratos"),74)

cDesc1 := PadC(OemToAnsi("Este programa ira emitir o Recibo dos Contratos, conforme"),74)
cDesc2 := PadC(OemToAnsi("os parametros solicitados"),74)
cDesc3 := PadC(OemToAnsi("Especifico J.Kobara"),74)


//wnrel := SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,.F.,.F.,Tamanho)

If nLastKey == 27
	Return
Endif

//SetDefault(aReturn,cString)

Titulo := PadC(OemToAnsi("Recibo de Contratos"),74)

cDesc1 := PadC(OemToAnsi("Este programa ira emitir o Recibo dos Contratos, conforme"),74)
cDesc2 := PadC(OemToAnsi("os parametros solicitados"),74)
cDesc3 := PadC(OemToAnsi("Especifico J.Kobara"),74)

RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 12/02/01 ==> RptStatus({|| Execute(RptDetail)})
return

// Substituido pelo assistente de conversao do AP5 IDE em 12/02/01 ==> Function RptDetail
Static Function RptDetail()

****************************
Private Arial, cCode
nHeight    := 15
lBold      := .F.
lUnderLine := .F.
lPixel     := .T.
lPrint     := .F.
nSedex     := 1

Private Arial  := TFont():New( "Arial",,nHeight,,lBold,,,,,lUnderLine )
Private Arial08:= TFont():New( "Arial",,08,,.t.,,,,,.f. )
Private Arial10:= TFont():New( "Arial",,10,,.f.,,,,,.f. )
Private Arial12:= TFont():New( "Arial",,12,,.f.,,,,,.f. )
Private Arial14:= TFont():New( "Arial",,14,,.f.,,,,,.f. )
Private Arial16:= TFont():New( "Arial",,16,,.f.,,,,,.f. )
Private Arial20:= TFont():New( "Arial",,20,,.t.,,,,,.f. )
Private Arial28:= TFont():New( "Arial",,28,,.t.,,,,,.f. )

Private Times14 := TFont():New( "Times New Roman",,14,,.t.,,,,,.f. )
Private Times18 := TFont():New( "Times New Roman",,18,,.t.,,,,,.f. )
Private Times18T:= TFont():New( "Times New Roman",,18,,.t.,,,,,.t. )
Private Times20 := TFont():New( "Times New Roman",,20,,.t.,,,,,.f. )
Private Times28 := TFont():New( "Times New Roman",,28,,.t.,,,,,.t. )

Private HAETTEN:= TFont():New( "HAETTENSCHWEILLER",,10,,.t.,,,,,.f. )

Private Free44 := TFont():New( "Free 3 of 9",,44,,.t.,,,,,.f. )
Private Free38 := TFont():New( "Free 3 of 9",,38,,.t.,,,,,.f. )

oPrn     := TMSPrinter():New()
*******************

nLin := 1
Limite:= 80
//@ nLin,000 PSAY CHR(18)
//@ nLin,000 PSAY aValImp(Limite)

oPrn:StartPage()
implogo()
oPrn:EndPage()
*
Set Device to Screen
Set Printer To
dbCommitAll()

oprn:preview()

MS_FLUSH()

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ FRABRE   º Autor ³ Luiz Carlos Vieira º Data ³Thu  24/09/98º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Rotina para a abertura do arquivo texto na FunMEMO         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Espec¡fico para clientes Microsiga                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 12/02/01 ==> Function FRAbre
Static Function FRAbre()

cFOpen := cGetFile("Arquivos Texto|*.TXT|Todos os Arquivos|*.*",OemToAnsi("Abrir Arquivo..."))
If !Empty(cFOpen)
	cTexto := MemoRead(cFOpen)
	ObjectMethod(oMemo,"Refresh()")
	ObjectMethod(oNome,"SetText('Arquivo: '+cFOpen)")
Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ FRFECHA  º Autor ³ Luiz Carlos Vieira º Data ³Thu  24/09/98º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Rotina para fechamento do arquivo texto em FunMEMO         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Espec¡fico para clientes Microsiga                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 12/02/01 ==> Function FRFecha
Static Function FRFecha()
cTexto := ""
cFOpen := ""
ObjectMethod(oMemo,"Refresh()")
ObjectMethod(oNome,"SetText('Arquivo: <SEM NOME>')")
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ FRSALVA  º Autor ³ Luiz Carlos Vieira º Data ³Thu  24/09/98º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Rotina para salvar o arquivo texto em FunMEMO              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Espec¡fico para clientes Microsiga                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 12/02/01 ==> Function FRSalva
Static Function FRSalva()
If !Empty(cFOpen)
	MemoWrit(cFOpen,cTexto)
Endif
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³FRSALVACOMº Autor ³ Luiz Carlos Vieira º Data ³Thu  24/09/98º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Rotina para salvar arquivo texto com outro nome em FunMEMO º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Espec¡fico para clientes Microsiga                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 12/02/01 ==> Function FRSalvaComo
Static Function FRSalvaComo()
cAux   := cFOpen
cFOpen := cGetFile("Arquivos Texto|*.TXT|Todos os Arquivos|*.*",OemToAnsi("Salvar Arquivo Como..."))
If !Empty(cFOpen)
	MemoWrit(cFOpen,cTexto)
	ObjectMethod(oNome,"SetText('Arquivo: '+cFOpen)")
Else
	cFOpen := cAux
Endif
return
******************************************************
*   IMPRIME CAMPO MEMO                               *
******************************************************
// Substituido pelo assistente de conversao do AP5 IDE em 12/02/01 ==> function _memo
Static function _memo()

@ nLin,000 PSAY CHR(18)
limite := 80
*
*  verifica se a impressao sera ou nao na mesma pagina
*
mCond := cTexto
@ nlin,001 PSay MEMOLINE(mCond,76,1,,.T.)
nLin := nLin + 1
For ii := 2 To mlcount(mCond)
	@nlin,001 PSay MEMOLINE(mCond,76,ii,,.T.)
	nLin := nLin + 1
Next ii
nLin := nLin + 4
return
*
******************************************************
*   INTERROMPE PROCESSAMENTO                         *
******************************************************
// Substituido pelo assistente de conversao do AP5 IDE em 12/02/01 ==> function _memo
Static function oCancel()

FLAG := .T.
close(mkwdlg)

return
*
**********************************************************
* Funcao: Imprime Logo                                   *
**********************************************************
Static Function implogo()

			
cBitMap:= "logojk.bmp"  //If( SubStr(TRB->C6_NUM,1,1)=="M","\microsite.bmp","\fera.bmp" )

oPrn:SayBitmap( 100,100,cBitMap, 400,250 )
*                                      
cnumrec := trans(_nNumRec,'@R 9999-99')
oPrn:Say( 400, 1000 , "Recibo N. "+cnumrec,Arial20,100 )
nlin += 100
*
cValor := trans(_nvalor,"@R 999,999,999.99")
oPrn:Say( 400+nlin, 950 , "Valor R$"+cvalor,Arial20,100 )
nLin += 300
*
_cValor   := extenso(_nValor,.f.,1)
_cEstacao := sz2->z2_estacao
_cPedido  := sz2->z2_pedcli
_cnumcli  := sz2->z2_numcli
_codcli   := sz2->z2_codcli
*
dbSelectArea("SA1")
dbSetOrder(1)
dbSeek(xfilial()+_codcli)
*
_cCliente:= sa1->a1_nome
_endcli	  := alltrim(sa1->a1_end)+'  -  '+alltrim(sa1->a1_mun)+'  -  '+alltrim(sa1->a1_est) + '  -  ' + substr(SA1->A1_CEP,1,5) +'-'+substr(SA1->A1_CEP,6,3)
_cgccli   := trans(sa1->a1_cgc,'@R 99.999.999/9999-99')
_inscrcli := sa1->a1_inscr
*                                                         
oPrn:Say( 400+nlin, 300 , "Recebemos  de  " + alltrim(_cCliente) +',  estabelecida  a',Arial16,100 )
nlin += 75
oPrn:Say( 400+nlin, 100 , _endcli + ',',Arial16,100 )
nlin += 75
oPrn:Say( 400+nlin, 100 ,"CNPJ  "+_CGCCLI+"  e  Inscricao  Estadual  "+ alltrim(_inscrcli)+',  a  importancia ',Arial16,100 )
nlin += 75
oPrn:Say( 400+nlin, 100 ,"supra  de  R$  "+cvalor,Arial16,100 )
*
cRet1:= ""
cRet2:= ""
*
sepExt(_cValor,55,80,@cRet1,@cRet2)
*
cRet1 := IF( !Empty(cRet1), "(***" + cRet1 , cRet1 )
cRet1 := IF( !Empty(cRet1) .and. Len(AllTrim(cRet1)) <= 55 .and. Empty(cRet2),alltrim(cret1) + ".***).", cret1)
cRet2 := IF( !Empty(cRet2), AllTrim(cRet2) + ".***)." , cRet2 )
*
oPrn:Say( 400+nlin,  800 ,cret1,Arial16,100 )
nlin += 75
oPrn:Say( 400+nlin,  100 ,cret2,Arial16,100 )
nlin += 150

*                                           
oPrn:Say( 400+nlin, 100 ,"Contrato Cliente.....: " + _cnumcli,Arial16,100 )
nlin += 75
oPrn:Say( 400+nlin, 100 ,"Pedido de Compra.: " + _cpedido,Arial16,100 )
nlin += 75
oPrn:Say( 400+nlin, 100 ,"Estacao..................: " + _cestacao,Arial16,100 )
nlin += 75
oPrn:Say( 400+nlin, 100 ,"Evento....................: " + _cevento,Arial16,100 )
nlin += 75
oPrn:Say( 400+nlin, 100 ,"Descricao Evento....: " + _cdesceve,Arial16,100 )
nlin += 75
*
mCond := cTexto
oPrn:Say( 400+nlin, 100 , MEMOLINE(mCond,085,1,,.T.),Arial16,100  )
nLin += 75
For ii := 2 To mlcount(mCond)
	oPrn:Say( 400+nlin, 100 , MEMOLINE(mCond,085,ii,,.T.),Arial16,100  )
	nLin += 75
Next ii                                                                
*
nlin += 300
oPrn:Say( 400+nlin, 1400 ,"Taboao da Serra, " + alltrim(str(day(date())))+ " de " + mesextenso(month(date()))+" de "+ alltrim(str(year(date())))+".",Arial14,100 )
nlin += 300
*                                                                  
oPrn:Say( 400+nlin, 1400, "_________________________________________",Arial16,100  )
nLin += 75
oPrn:Say( 400+nlin, 1400, "J.KOBARA TELECOMUNICACOES LTDA",Arial16,100  )

return

********



