// Defines

#command SET SOFTSEEK <x:ON,OFF,&>      =>  Set( _SET_SOFTSEEK, <(x)> )
#command SET SOFTSEEK (<x>)             =>  Set( _SET_SOFTSEEK, <x> )

#define STR0001  "Por Data"
#define STR0002  "Por Banco"
#define STR0003  "Por Natureza"
#define STR0004  "Alfabetica"
#define STR0005  "Dt.Digitacao"
#define STR0006  "Este programa ir  emitir a rela‡„o dos titulos baixados."
#define STR0007  "Poder  ser emitido por data, banco, natureza ou alfab‚tica"
#define STR0008  "de cliente ou fornecedor e data da digita‡„o."
#define STR0009  "Relacao de Baixas"
#define STR0010  "Zebrado"
#define STR0011  "Relacao dos Titulos Recebidos em "
#define STR0012  "Prf Numero       P TP  Client Nome Cliente       Natureza   Vencto     Historico          Dt Baixa   Valor Original  Tx Permanen        Multa     Correcao    Descontos  Abatimentos     Total Rec. Bco Dt Digit.  Mot.Baixa"
#define STR0013  "Relacao dos Titulos Pagos em "
#define STR0014  "Prf Numero       P TP  Fornec Nome Fornecedor    Natureza   Vencto     Historico          Dt Baixa   Valor Original  Tx Permanen        Multa     Correcao    Descontos  Abatimentos     Total Pago Bco Dt Digit.  Mot.Baixa"
#define STR0015  " por data de pagamento"
#define STR0016  " por Banco"
#define STR0017  " por Natureza"
#define STR0018  "Selecionando Registros..."
#define STR0019  " Por Data de Digitacao"
#define STR0020  " Alfabetica"
#define STR0021  "CANCELADO PELO OPERADOR"
#define STR0022  "NORMAL"
#define STR0023  "DEVOLUCAO"
#define STR0024  "DACAO"
#define STR0025  "VENDOR"
#define STR0026  "COMPENSAC"
#define STR0027  "COMP CART"
#define STR0028  "Baixados"
#define STR0029  "Total Geral : "
#define STR0030  "Administracao"
#define STR0031  "Mov.Fin."
#define STR0032  "Nro. Titulo"
#define STR0033  "LIQUIDAC."
#define STR0034  "DEBITO CC"
#define STR0035  " Nro. dos Titulos"
#define STR0036  " Por Lote"
#define STR0037  "Compens."
#define STR0038  "Moviment. Financeiras Manuais "

#Include "RwMake.Ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FINR190  ³ Autor ³ Wagner Xavier         ³ Data ³ 05.10.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Rela‡„o das baixas                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FINR190(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Program   ³ Data   ³ BOPS ³  Motivo da Alteracao                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Mauricio ³06/02/98³XXXXXX³ Tratamento de MotBx = LIQ  (liquidacao)	  ³±±
±±³ Mauricio ³17/02/98³XXXXXX³ Tratamento de impressao de Forn/Cliente p/ ³±±
±±³          ³        ³      ³  Movimenta‡„o Financeira Manual            ³±±
±±³ Mauricio ³07/05/98³14720A³ Acertar Totaliza‡oes Pagos/Mov.Financeira  ³±±
±±³ Mauricio ³28/05/98³XXXXXX³ Acertos Gerais no relatorio                ³±±
±±³ Mauricio ³29/05/98³XXXXXX³ Corr.impressao data vencto. mov.fin.manual ³±±
±±³ Mauricio ³17/06/98³16706A³ Corr.data vencto. mov.fin.manual qdo cheque³±±
±±³ Mauricio ³18/06/98³xxxxxx³ Corr.impressao data vencto. de titulos     ³±±
±±³ Mauricio ³18/06/98³xxxxxx³ Criada var. cRecPag p/ guardar carteira    ³±±
±±³ Mauricio ³28/06/98³xxxxxx³ Nro do titulo com 12 posicoes              ³±±
±±³ Andreia  ³31/08/98³xxxxxx³ Ordenacao por Lote                         ³±±
±±³ Mauricio ³17/09/98³16885A³ Nao listar movimento de cheque pre         ³±±
±±³ Andreia  ³13/10/98³xxxxx ³ Alteracao no lay-out p/ativar set century  ³±±
±±³ Mauricio ³30/10/98³xxxxxx³ Corrigido Historico de Mov.Financ.Manual   ³±±
±±³ Andreia  ³14/12/98³xxxxx ³ Verificacao se existe baixa estornada 	  ³±±
±±³          ³        ³      ³ ( TemBxCanc()).         		     			  ³±±
±±³          ³        ³      ³ Verificacao se o motivo da baixa movimenta ³±±
±±³          ³        ³      ³ banco ( MovBcoBx())          			     ³±±
±±³ Julio    ³20/01/99³13186a³ Inserido tratamento Loja de/Ate no         ³±±
±±³          ³        ³      ³ relatorio.                                 ³±±
±±³ Julio    ³20/01/99³xxxxxx³ Fechar NewSE5 quando cancela relatorio.    ³±±
±±³ Julio    ³04/02/99³19706A³ Corrigir Impressao Benef. qdo Bx=Manual    ³±±
±±³ Julio    ³19/02/99³META  ³ Convers„o aMotBx -> ReadMotBx()            ³±±
±±³ Mauricio ³09/04/99³xxxxxx³ S¢ procurar p/abatimentos quando for baixa ³±±
±±³ Mauricio ³07/07/99³22431A³ Corrigir filtragem                         ³±±
±±³ Mauricio ³14/09/99³xxxxxx³ Corrigir reposicionamento de filiais       ³±±
±±³ Julio W  ³20.09.99³23958A³ Interpretar parƒmetro "Consid.Mov.Financ"  ³±±
±±³          ³        ³      ³ quando selecionado "Imprime Baixas Normais"³±±
±±³ Mauricio ³09/11/99³24946A³ Imprimir nome do banco no sub-total quando ³±±
±±³          ³        ³      ³ relatorio em ordem de bancos               ³±±
±±³ Mauricio ³24.11.99³xxxxxx³Corrigir tratamento Filial De/Ate           ³±±
±±³ Julio W. ³03.12.99³25516A³Corrigir montagem do Rel. nas ordens 4 e 5  ³±±
±±³ Mauricio ³15.12.99³25531A³Corrigir impressao de sub-total filial      ³±±
±±³ Mauricio ³21/12/99³226636³ Corrigir impressÆo do fornecedor no subto- ³±±
±±³          ³        ³      ³ tal das Mov. Bancarias Manuais quando rela-³±±
±±³          ³        ³      ³ torio em ordem alfab‚tica.                 ³±±
±±³ Mauricio ³03.01.00³xxxxxx³Corrigir salto na impressao sub-total filial³±±
±±³ Mauricio ³31.01.00³xxxxxx³Corrigir tratamento Filial De/Ate           ³±±
±±³ Jeremias ³07.02.00³Melhor³Corrigir o posicionamento do SE5 quando da  ³±±
±±³          ³        ³      ³utilizacao da TemBxCanc com SQL.            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function FinR190()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local wnrel
Local aOrd:={OemToAnsi(STR0001),OemToAnsi(STR0002),OemToAnsi(STR0003),OemToAnsi(STR0004),OemToAnsi(STR0032),OemToAnsi(STR0005),OemToAnsi(STR0036)}  //"Por Data"###"Por Banco"###"Por Natureza"###"Alfabetica"###"Nro. Titulo"###"Dt.Digitacao"###"Por Lote"
Local cDesc1 :=OemToAnsi(STR0006)  //"Este programa ir  emitir a rela‡„o dos titulos baixados."
Local cDesc2 :=OemToAnsi(STR0007)  //"Poder  ser emitido por data, banco, natureza ou alfab‚tica"
Local cDesc3 :=OemToAnsi(STR0008)  //"de cliente ou fornecedor e data da digita‡„o."
Local tamanho:="G"
Local limite := 220
Local cString:="SE5"

PRIVATE titulo:=OemToAnsi(STR0009)  //"Relacao de Baixas"
PRIVATE cabec1
PRIVATE cabec2
PRIVATE cNomeArq
PRIVATE aReturn := { OemToAnsi(STR0010), 1,OemToAnsi(STR0030), 1, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE nomeprog:="FINR190"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg   :="FIN190"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Abre o SE5 com outro alias para ser filtrado porque a funcao³
//³ TemBxCanc() utilizara o SE5 sem filtro.							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
if !( ChkFile("SE5",.F.,"NEWSE5") )
	Return
EndIf

AjustaSx1()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("FIN190",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                     ³
//³ mv_par01            // da data da baixa                  ³
//³ mv_par02            // at‚ a data da baixa               ³
//³ mv_par03            // do banco                          ³
//³ mv_par04            // at‚ o banco                       ³
//³ mv_par05            // da natureza                       ³
//³ mv_par06            // at‚ a natureza                    ³
//³ mv_par07            // do c¢digo                         ³
//³ mv_par08            // at‚ o c¢digo                      ³
//³ mv_par09            // da data de digita‡„o              ³
//³ mv_par10            // ate a data de digita‡„o           ³
//³ mv_par11            // Tipo de Carteira (R/P)            ³
//³ mv_par12            // Moeda                             ³
//³ mv_par13            // Hist¢rico: Baixa ou Emiss„o       ³
//³ mv_par14            // Imprime Baixas Normais / Todas    ³
//³ mv_par15            // Situacao                          ³
//³ mv_par16            // Cons Mov Fin                      ³
//³ mv_par17            // Cons filiais abaixo               ³
//³ mv_par18            // da filial                         ³
//³ mv_par19            // ate a filial                      ³
//³ mv_par20            // Do Lote                           ³
//³ mv_par21            // Ate o Lote                        ³
//³ mv_par22            // da loja                           ³
//³ mv_par23            // Ate a loja                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a fun‡„o SETPRINT                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "FINR190"            //Nome Default do relat¢rio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastKey == 27
	dbSelectArea("NEWSE5")
	dbCloseArea()
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	dbSelectArea("NEWSE5")
	dbCloseArea()
	Return
Endif

cFilterUser := aReturn[7]

RptStatus({|lEnd| Fa190Imp(@lEnd,wnRel,cString)},Titulo)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FA190Imp ³ Autor ³ Wagner Xavier         ³ Data ³ 05.10.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Rela‡„o das baixas                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA190Imp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - A‡Æo do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FA190Imp(lEnd,wnRel,cString)

Local CbTxt,CbCont
Local nValor:=0,nDesc:=0,nJuros:=0,nCM:=0,nMulta:=0,dData,nVlMovFin:=0
Local nTotValor:=0,nTotDesc:=0,nTotJuros:=0,nTotMulta:=0,nTotCm:=0,nTotOrig:=0,nTotBaixado:=0,nTotMovFin:=0,nTotComp:=0
Local nGerValor:=0,nGerDesc:=0,nGerJuros:=0,nGerMulta:=0,nGerCm:=0,nGerOrig:=0,nGerBaixado:=0,nGerMovFin:=0,nGerComp:=0
Local nFilOrig:=0,nFilJuros:=0,nFilMulta:=0,nFilCM:=0,nFilDesc:=0
Local nFilAbat:=0,nFilValor:=0,nFilBaixado:=0,nFilMovFin:=0,nFilComp:=0
Local cBanco,cNatureza,cAnterior,cCliFor,nCT:=0,dDigit,cLoja
Local lContinua:=.T.
Local lBxTit:=.F.
Local tamanho:="G"
Local aCampos := {},cNomArq1:="",nVlr,cLinha,lOriginal:=.T.
Local nAbat := 0
Local nTotAbat := 0
Local nGerAbat := 0
Local cMotBxImp := " "
Local cHistorico
Local lManual := .f.
Local cTipodoc
Local nRecSe5 := 0
Local nRecAtu:= 0
Local dDtMovFin
Local cRecPag
Local nRecEmp := SM0->(Recno())
Local nTimes  := 0
Local aMotBx  := ReadMotBx()
Local	cMotBaixa := CRIAVAR("E5_MOTBX")
Local cFilNome := Space(15)
Local cCliFor190 := ""
Local nDecs				:= GetMv("MV_CENT"+(IIF(mv_par12 > 1 , STR(mv_par12,1),""))) 
Local nMoedaBco		:=	1
Local lCarteira
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para Impress„o do Cabe‡alho e Rodap‚    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1
nOrdem 	:= aReturn[8]
cSuf		:= Str(mv_par12,1)
cMoeda	:= MV_MOEDA&cSuf

cCond3 	:= ".T."

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Defini‡„o dos cabe‡alhos       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par11 == 1
	titulo := OemToAnsi(STR0011)  + cMoeda  //"Relacao dos Titulos Recebidos em "
	cabec1 := OemToAnsi(STR0012)  //"Prf Numero       P TP Client Nome Cliente       Natureza    Vencto  Historico       Dt Baixa  Valor Original    Tx Permanen         Multa      Correcao     Descontos     Abatimentos    Total Rec. Bco Dt Digit. Mot. Baixa"
Else
	titulo := OemToAnsi(STR0013)  + cMoeda  //"Relacao dos Titulos Pagos em "
	cabec1 := OemToAnsi(STR0014)  //"Prf Numero       P TP Fornec Nome Fornecedor    Natureza    Vencto  Historico       Dt Baixa  Valor Original    Tx Permanen         Multa      Correcao     Descontos     Abatimentos    Total Pago Bco Dt Digit. Mot. Baixa"
Endif
cabec2 := ""

dbSelectArea("NEWSE5")
cFilSE5 := 'E5_RECPAG=='+IIF(mv_par11 == 1,'"R"','"P"')+'.and.'
cFilSE5 += 'DTOS(E5_DATA)>='+'"'+dtos(mv_par01)+'"'+'.and.DTOS(E5_DATA)<='+'"'+dtos(mv_par02)+'".and.'
cFilSE5 += 'E5_NATUREZ>='+'"'+mv_par05+'"'+'.and.E5_NATUREZ<='+'"'+mv_par06+'".and.'
cFilSE5 += 'E5_CLIFOR>='+'"'+mv_par07+'"'+'.and.E5_CLIFOR<='+'"'+mv_par08+'".and.'
cFilSE5 += 'DTOS(E5_DTDIGIT)>='+'"'+dtos(mv_par09)+'"'+'.and.DTOS(E5_DTDIGIT)<='+'"'+dtos(mv_par10)+'".and.'
cFilSE5 += 'E5_LOTE>='+'"'+mv_par20+'"'+'.and.E5_LOTE<='+'"'+mv_par21+'".and.'
cFilSE5 += 'E5_LOJA>='+'"'+mv_par22+'"'+'.and.E5_LOJA<='+'"'+mv_par23+'"'
Set Softseek On

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define array para arquivo de trabalho    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aCampos,{"LINHA","C",80,0 } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo de Trabalho   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cNomArq1 := CriaTrab(aCampos)
dbUseArea( .T.,, cNomArq1, "Trb", if(.F. .OR. .F., !.F., NIL), .F. )
IndRegua("TRB",cNomArq1,"LINHA",,,OemToAnsi(STR0018))  //"Selecionando Registros..."

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atribui valores as variaveis ref a filiais                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par17 == 2
	cFilDe := cFilAnt
	cFilAte:= cFilAnt
ELSE
	cFilDe := mv_par18	// Todas as filiais
	cFilAte:= mv_par19
Endif

dbSelectArea("SM0")
dbSeek(cEmpAnt+cFilDe,.T.)

While !Eof() .and. M0_CODIGO == cEmpAnt .and. M0_CODFIL <= cFilAte

	cFilAnt := SM0->M0_CODFIL
	cFilNome:= SM0->M0_FILIAL

	nTimes++

	dbSelectArea("NEWSE5")

// Inicio da alteracao

	IF nOrdem == 1
		cCondicao:= "E5_DATA >= mv_par01 .and. E5_DATA <= mv_par02"
		cCond2   := "E5_DATA"
		If nTimes == 1
			titulo   += OemToAnsi(STR0015)  //" por data de pagamento"
			#IFDEF TOP
				MsFilter(cFilSE5)
			#ENDIF
		Endif
		dbSetOrder(1)
		dbSeek(xFilial("SE5")+Dtos(mv_par01))

	Elseif nOrdem == 2
		cCondicao	:= "E5_BANCO >= mv_par03 .and. E5_BANCO <= mv_par04"
		cCond2		:= "E5_BANCO"
		If nTimes == 1
         cNomeArq := CriaTrab(Nil,.F.) 
         DbSelectArea("NEWSE5") 
         DbSetOrder(3)
         cChave := IndexKey() 
			titulo   += OemToAnsi(STR0016) // " por Banco"
			#IFDEF TOP
				MsFilter(cFilSE5)
         #ELSE 
            DbSetOrder(0) 
            IndRegua("NEWSE5",cNomeArq,cChave,,cFilSE5,OemToAnsi(STR0018))  //"Selecionando Registros..." 
			#ENDIF
		Endif
		dbSeek(xFilial("SE5")+mv_par03)
	Elseif nOrdem == 3
		cCondicao:= "E5_NATUREZ >= mv_par05 .and. E5_NATUREZ <= mv_par06"
		cCond2   := "E5_NATUREZ"
		titulo   += OemToAnsi(STR0017)  //" por Natureza"
		
		If nTimes == 1
         DbSetOrder(4)                 
         cNomeArq := CriaTrab(Nil,.F.) 
         DbSelectArea("NEWSE5")        
         cChave := IndexKey()          
			#IFDEF TOP
				MsFilter(cFilSE5)
         #ELSE 
            DbSetOrder(0) 
            IndRegua("NEWSE5",cNomeArq,cChave,,cFilSE5,OemToAnsi(STR0018))  //"Selecionando Registros..." 
			#ENDIF
		Endif
		dbSeek(xFilial("SE5")+mv_par05)

	Elseif nOrdem == 4
		cCondicao:=".T."
		cCond2   :="E5_CLIFOR+E5_LOJA"
		If nTimes == 1
			titulo+= OemToAnsi(STR0020)  //" Alfabetica"
			cNomeArq:=CriaTrab("",.f.)
			dbSelectArea("NEWSE5")
		Endif
		If nTimes == 1
			dbSetOrder(0)
			#IFNDEF TOP
				IndRegua("NEWSE5",cNomeArq,"E5_FILIAL+E5_BENEF+DTOS(E5_DATA)+E5_PREFIXO+E5_NUMERO+E5_PARCELA",,,OemToAnsi(STR0018))  //"Selecionando Registros..."
			#ELSE
				IndRegua("NEWSE5",cNomeArq,"E5_FILIAL+E5_BENEF+DTOS(E5_DATA)+E5_PREFIXO+E5_NUMERO+E5_PARCELA",,cFilSE5,OemToAnsi(STR0018))  //"Selecionando Registros..."
			#ENDIF
		Endif
		dbSeek(xFilial("SE5"),.T.)
	Elseif nOrdem == 5
		cCondicao:=".T."
		cCond2   :="E5_NUMERO"
		If nTimes == 1
			titulo+=OemToAnsi(STR0035) //" Nro. dos Titulos"
			cNomeArq:=CriaTrab("",.f.)
		Endif
		dbSelectArea("NEWSE5")
		If nTimes == 1
			dbSetOrder(0)
			#IFNDEF TOP
				IndRegua("NEWSE5",cNomeArq,"E5_FILIAL+E5_NUMERO+E5_PARCELA+E5_PREFIXO+DTOS(E5_DATA)",,,OemToAnsi(STR0018))  //"Selecionando Registros..."
			#ELSE
				IndRegua("NEWSE5",cNomeArq,"E5_FILIAL+E5_NUMERO+E5_PARCELA+E5_PREFIXO+DTOS(E5_DATA)",,cFilSE5,OemToAnsi(STR0018))  //"Selecionando Registros..."
			#ENDIF
		Endif
		dbSeek(xFilial("SE5"),.T.)
	Elseif nOrdem == 6	//Ordem 6 (Digitacao)
		cCondicao:=".T."
		cCond2   :="E5_DTDIGIT"
		If nTimes == 1
			titulo+=OemToAnsi(STR0019)  //" Por Data de Digitacao"
			cNomeArq:=CriaTrab("",.f.)
         DbSetOrder(0) 
			#IFNDEF TOP
				IndRegua("NEWSE5",cNomeArq,"E5_FILIAL+DTOS(E5_DTDIGIT)+E5_PREFIXO+E5_NUMERO+E5_PARCELA+DTOS(E5_DATA)",,,OemToAnsi(STR0018))  //"Selecionando Registros..."
			#ELSE
				IndRegua("NEWSE5",cNomeArq,"E5_FILIAL+DTOS(E5_DTDIGIT)+E5_PREFIXO+E5_NUMERO+E5_PARCELA+DTOS(E5_DATA)",,cFilSE5,OemToAnsi(STR0018))  //"Selecionando Registros..."
			#ENDIF
		Endif
		dbSelectArea("NEWSE5")
		dbSeek(xFilial("SE5"),.T.)

	Else			// por Lote
		cCondicao:= "E5_LOTE >= mv_par20 .and. E5_LOTE <= mv_par21"
		cCond2   := "E5_LOTE"
		titulo   += OemToAnsi(STR0036)  //" por Lote"
		
		If nTimes == 1
         cNomeArq:=CriaTrab("",.f.) 
         DbSelectArea("NEWSE5")  
         DbSetOrder(5)          
         cChave := IndexKey()   
		
			#IFDEF TOP
				MsFilter(cFilSE5)
         #ELSE 
            DbSetOrder(0) 
            IndRegua("NEWSE5",cNomeArq,cChave,,cFilSE5,OemToAnsi(STR0018))  //"Selecionando Registros..." 
			#ENDIF
		Endif
		dbSeek(xFilial("SE5")+mv_par20)

	Endif

// Fim da alteracao

	dbSelectArea("NEWSE5")
	SetRegua(RecCount())

	While NEWSE5->(!Eof()) .And. NEWSE5->E5_FILIAL==xFilial("SE5") .And. &cCondicao .and. lContinua

		IF lEnd
			@PROW()+1,001 PSAY OemToAnsi(STR0021)  //"CANCELADO PELO OPERADOR"
			lContinua:=.F.
			Exit
		Endif

		IncRegua()

		IF NEWSE5->E5_SITUACA == "C" .or. NEWSE5->E5_TIPODOC $ "TR#TE" .or.;
				(NEWSE5->E5_TIPODOC == "CD" .and. NEWSE5->E5_VENCTO > NEWSE5->E5_DATA)
			NEWSE5->(dbSkip())
			Loop
		Endif

		If (NEWSE5->E5_RECPAG == "R" .and. ! (NEWSE5->E5_TIPO $ "PA /"+MV_CPNEG )) .or. ;	//Titulo normal
			(NEWSE5->E5_RECPAG == "P" .and.   (NEWSE5->E5_TIPO $ "RA /"+MV_CRNEG )) 	//Adiantamento
			lCarteira := "R"
		Else
			lCarteira := "P"
		Endif

		IF mv_par11 == 1 .and. lCarteira == "P" 	//Nao ‚ recebimento
			NEWSE5->( dbSkip())
			Loop
		Endif

		IF mv_par11 == 2 .and. lCarteira == "R"  //Nao eh pagamento
			NEWSE5->( dbSkip() )
			Loop
		EndIF

		If Empty(NEWSE5->E5_TIPODOC) .and. mv_par16 == 2
			NEWSE5->( dbSkip() )
			Loop
		Endif

		If Empty(NEWSE5->E5_NUMERO) .and. mv_par16 == 2
			NEWSE5->( dbSkip() )
			Loop
		Endif

		If NEWSE5->E5_RECPAG == "R"
			If (NEWSE5->E5_TIPO == "RA " .or. ;
					NEWSE5->E5_TIPO == MV_CRNEG .and. mv_par24 == 2 ) .and.;
					NEWSE5->E5_MOTBX == "CMP"
				NEWSE5->( dbSkip() )
				LOOP
			EndIF
		EndIF

		If NEWSE5->E5_RECPAG == "P"
			If (NEWSE5->E5_TIPO == "PA " .or. ;
					NEWSE5->E5_TIPO == MV_CPNEG .and. mv_par24 == 2 ) .and.;
					NEWSE5->E5_MOTBX == "CMP"
				NEWSE5->( dbSkip() )
				LOOP
			EndIF
		EndIF
		cAnterior 	:= &cCond2
		nTotValor	:= 0
		nTotDesc		:= 0
		nTotJuros	:= 0
		nTotMulta	:= 0
		nTotCM		:= 0
		nCT			:= 0
		nTotOrig		:= 0
		nTotBaixado	:= 0
		nTotAbat  	:= 0
		nTotMovFin	:= 0
		nTotComp		:= 0

		While NEWSE5->(!EOF()) .and. &cCond2=cAnterior .and. NEWSE5->E5_FILIAL=xFilial("SE5") .and. lContinua

			lManual := .f.

			IF NEWSE5->E5_SITUACA == "C" .or. NEWSE5->E5_TIPODOC == "TR" .or. ;
					( NEWSE5->E5_TIPODOC == "CD" .and. NEWSE5->E5_VENCTO > NEWSE5->E5_DATA )
				NEWSE5->(dbSkip())
				Loop
			Endif

			IF lEnd
				@PROW()+1,001 PSAY OemToAnsi(STR0021)  //"CANCELADO PELO OPERADOR"
				lContinua:=.F.
				Exit
			EndIF

			If Empty(NEWSE5->E5_TIPODOC) .and. mv_par16 == 2
				NEWSE5->( dbSkip() )
				Loop
			Endif

			If Empty(NEWSE5->E5_NUMERO) .and. mv_par16 == 2
				NEWSE5->( dbSkip() )
				Loop
			Endif

			If Empty(NEWSE5->E5_TIPODOC) .And. mv_par16 == 1
				lManual := .t.
			Endif

			If Empty(NEWSE5->E5_NUMERO) .And. mv_par16 == 1
				lManual := .t.
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Na versao TOP reposiciona o SE5 porque a TemBXCanc utiliza o     ³
			//³ SE5 posicionado para a montagem da query.                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			SET SOFTSEEK OFF	

			#IFDEF TOP
				dbselectarea("SE5")
				dbsetorder(7)
				dbseek(xFilial("SE5")+NEWSE5->E5_PREFIXO+NEWSE5->E5_NUMERO+;
					NEWSE5->E5_PARCELA+NEWSE5->E5_TIPO	+;
					NEWSE5->E5_CLIFOR+NEWSE5->E5_LOJA+NEWSE5->E5_SEQ)
				dbSelectArea("NEWSE5")
			#ENDIF

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se existe estorno para esta baixa                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// Inicio da alteracao

			If ! Empty(NEWSE5->E5_PREFIXO+NEWSE5->E5_NUMERO+NEWSE5->E5_PARCELA+;
						   NEWSE5->E5_TIPO	+NEWSE5->E5_CLIFOR+NEWSE5->E5_LOJA) .And.;
			   TemBxCanc(NEWSE5->E5_PREFIXO+NEWSE5->E5_NUMERO+;
						    NEWSE5->E5_PARCELA+NEWSE5->E5_TIPO	+;
					       NEWSE5->E5_CLIFOR+NEWSE5->E5_LOJA+NEWSE5->E5_SEQ)
				dbSelectArea("NEWSE5")
				NEWSE5->( dbSkip() )
				Loop
			EndIf

// Fim da alteracao

			dbSelectArea("NEWSE5")
			cNumero    	:= NEWSE5->E5_NUMERO
			cPrefixo   	:= NEWSE5->E5_PREFIXO
			cParcela   	:= NEWSE5->E5_PARCELA
			dBaixa     	:= NEWSE5->E5_DATA
			cBanco     	:= NEWSE5->E5_BANCO
			cNatureza  	:= NEWSE5->E5_NATUREZ
			cCliFor    	:= NEWSE5->E5_BENEF
			cLoja      	:= NEWSE5->E5_LOJA
			cSeq       	:= NEWSE5->E5_SEQ
			cNumCheq   	:= NEWSE5->E5_NUMCHEQ
			cRecPag 		:= NEWSE5->E5_RECPAG
			cMotBaixa	:= NEWSE5->E5_MOTBX
			If !Empty(NEWSE5->E5_NUMERO)
				If (NEWSE5->E5_RECPAG == "R" .and. !(NEWSE5->E5_TIPO $ "PA /"+MV_CPNEG)) .or. ;
						(NEWSE5->E5_RECPAG == "P" .and. NEWSE5->E5_TIPO $ "RA /"+MV_CRNEG)
					dbSelectArea( "SA1")
					DbSetOrder(1)
					If dbSeek(xFilial("SA1")+NEWSE5->E5_CLIFOR+NEWSE5->E5_LOJA)
						cCliFor := SA1->A1_NREDUZ
					EndIF
				Else
					dbSelectArea( "SA2")
					DbSetOrder(1)
					If dbSeek(xFilial("SA2")+NEWSE5->E5_CLIFOR+NEWSE5->E5_LOJA)
						cCliFor := SA2->A2_NREDUZ
					EndIF
				EndIF
			EndIF
			SET SOFTSEEK ON
			dbSelectArea("NEWSE5")
			cCheque    := NEWSE5->E5_NUMCHEQ
			cTipo      := NEWSE5->E5_TIPO
			cFornece   := NEWSE5->E5_CLIFOR
			cLoja      := NEWSE5->E5_LOJA
			dDigit     := NEWSE5->E5_DTDIGIT
			lBxTit	  := .F.

			If (NEWSE5->E5_RECPAG == "R" .and. ! (NEWSE5->E5_TIPO $ "PA /"+MV_CPNEG )) .or. ;	//Titulo normal
				(NEWSE5->E5_RECPAG == "P" .and.   (NEWSE5->E5_TIPO $ "RA /"+MV_CRNEG )) 	//Adiantamento
				dbSelectArea("SE1")
				DbSetOrder(1)
				lBxTit := dbSeek(cFilial+cPrefixo+cNumero+cParcela+cTipo)
				lCarteira := "R"
				dDtMovFin := IIF (lManual,CTOD("//"), DataValida(SE1->E1_VENCTO,.T.))
				While SE1->(!Eof()) .and. SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO==cPrefixo+cNumero+cParcela+cTipo
					If SE1->E1_CLIENTE == cFornece .And. SE1->E1_LOJA == cLoja	// Cliente igual, Ok
						Exit
					Endif
					SE1->( dbSkip() )
				EndDo
				cCond3:="E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+DtoS(E5_DATA)+E5_SEQ+E5_NUMCHEQ==cPrefixo+cNumero+cParcela+cTipo+DtoS(dBaixa)+cSeq+cNumCheq"
				Store 0 To nDesc,nJuros,nValor,nMulta,nCM,nVlMovFin

			Else
				dbSelectArea("SE2")
				DbSetOrder(1)
				lBxTit := dbSeek(cFilial+cPrefixo+cNumero+cParcela+cTipo+cFornece+cLoja)
				dDtMovFin := IIF(lManual,CTOD("//"),DataValida(SE2->E2_VENCTO,.T.))
				lCarteira := "P"
				cCond3:="E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+DtoS(E5_DATA)+E5_SEQ+E5_NUMCHEQ==cPrefixo+cNumero+cParcela+cTipo+cFornece+DtoS(dBaixa)+cSeq+cNumCheq"
				Store 0 To nDesc,nJuros,nValor,nMulta,nCM,nVlMovFin
				cCheque    := Iif(Empty(NEWSE5->E5_NUMCHEQ),SE2->E2_NUMBCO,NEWSE5->E5_NUMCHEQ)
			Endif
			dbSelectArea("NEWSE5")
			IncRegua()
			While NEWSE5->( !Eof()) .and. &cCond3 .and. lContinua

				cTipodoc   := NEWSE5->E5_TIPODOC

				cHistorico := Space(40)

				IF lEnd
					@PROW()+1,001 PSAY OemToAnsi(STR0021)  //"CANCELADO PELO OPERADOR"
					lContinua:=.F.
					Exit
				EndIF

				IncRegua()

				If NEWSE5->E5_SITUACA == "C" .or. NEWSE5->E5_LOJA != cLoja
					NEWSE5->( dbSkip() )
					Loop
				EndIF

				If Empty(NEWSE5->E5_TIPODOC) .and. mv_par16 == 2
					NEWSE5->( dbSkip() )
					Loop
				Endif

				If NEWSE5->E5_TIPODOC == "TR"
					NEWSE5->( dbSkip() )
					Loop
				Endif

				If mv_par11 == 1 .and. !lManual .and.  ;
						(NEWSE5->E5_RECPAG == "R" .and. !(NEWSE5->E5_TIPO $ "PA /"+MV_CPNEG))
					If !(SE1->E1_SITUACA $ mv_par15)
						NEWSE5->( dbSkip() )
						Loop
					Endif
				Endif

				IF mv_par11 == 1 .and. lCarteira == "P" 	//Nao ‚ recebimento
					NEWSE5->( dbSkip())
					Loop
				Endif

				IF mv_par11 == 2 .and. lCarteira == "R"  //Nao eh pagamento
					NEWSE5->( dbSkip() )
					Loop
				EndIF
				
				If NEWSE5->E5_RECPAG == "R"
					If (NEWSE5->E5_TIPO == "RA " .or. ;
							NEWSE5->E5_TIPO == MV_CRNEG .and. mv_par24 == 2 ) .and.;
							NEWSE5->E5_MOTBX == "CMP"
						NEWSE5->( dbSkip() )
						LOOP
					EndIF
				EndIF

				If NEWSE5->E5_RECPAG == "P"
					If (NEWSE5->E5_TIPO == "PA " .or. ;
							NEWSE5->E5_TIPO == MV_CPNEG .and. mv_par24 == 2 ) .and.;
							NEWSE5->E5_MOTBX == "CMP"
						NEWSE5->( dbSkip() )
						LOOP
					EndIF
				EndIF

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Se escolhido o parƒmetro "baixas normais", apenas imprime as baixas  ³
				//³que gerarem movimenta‡„o banc ria e as movimenta‡”es financeiras     ³
				//³manuais, se consideradas.                                            ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par14 == 1 .and. !MovBcoBx(NEWSE5->E5_MOTBX) .and. !lManual
					NEWSE5->( dbSkip() )
					Loop
				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Na versao TOP reposiciona o SE5 porque a TemBXCanc utiliza o     ³
				//³ SE5 posicionado para a montagem da query.                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				#IFDEF TOP
					dbselectarea("SE5")
					dbsetorder(7)
					dbseek(xFilial("SE5")+NEWSE5->E5_PREFIXO+NEWSE5->E5_NUMERO+;
						NEWSE5->E5_PARCELA+NEWSE5->E5_TIPO	+;
						NEWSE5->E5_CLIFOR+NEWSE5->E5_LOJA+NEWSE5->E5_SEQ)
					dbSelectArea("NEWSE5")
				#ENDIF
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se existe estorno para esta baixa                       ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// Inicio da alteracao


            If  ! Empty(NEWSE5->E5_PREFIXO+NEWSE5->E5_NUMERO+NEWSE5->E5_PARCELA+;
							   NEWSE5->E5_TIPO	+NEWSE5->E5_CLIFOR+NEWSE5->E5_LOJA) .And.;
				   TemBxCanc(NEWSE5->E5_PREFIXO+NEWSE5->E5_NUMERO+;
				        	    NEWSE5->E5_PARCELA+NEWSE5->E5_TIPO	+;
						       NEWSE5->E5_CLIFOR+NEWSE5->E5_LOJA+NEWSE5->E5_SEQ)
					dbSelectArea("NEWSE5")
					NEWSE5->( dbSkip() )
					Loop
				EndIf

// Fim da alteracao

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se est  dentro dos parƒmetros       ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				IF NEWSE5->E5_DATA   < mv_par01 .Or. NEWSE5->E5_DATA    > MV_PAR02 .Or. ;
						NEWSE5->E5_BANCO  < mv_par03 .Or. NEWSE5->E5_BANCO   > MV_PAR04 .Or. ;
						NEWSE5->E5_NATUREZ< mv_par05 .Or. NEWSE5->E5_NATUREZ > MV_PAR06 .Or. ;
						NEWSE5->E5_CLIFOR < mv_par07 .Or. NEWSE5->E5_CLIFOR  > MV_PAR08 .Or. ;
						NEWSE5->E5_DTDIGIT< mv_par09 .Or. NEWSE5->E5_DTDIGIT > MV_PAR10 .Or. ;
						NEWSE5->E5_LOTE   < mv_par20 .Or. NEWSE5->E5_LOTE    > MV_PAR21
					NEWSE5->(dbSkip())
					Loop
				EndIF

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Considera filtro do usuario                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea("NEWSE5")
				If !Empty(cFilterUser).and.!(&cFilterUser)
					NEWSE5->(dbSkip())
					Loop
				Endif

				dBaixa     	:= NEWSE5->E5_DATA
				cBanco     	:= NEWSE5->E5_BANCO
				cNatureza  	:= NEWSE5->E5_NATUREZ
				cCliFor    	:= NEWSE5->E5_BENEF
				cLoja      	:= NEWSE5->E5_LOJA
				cSeq       	:= NEWSE5->E5_SEQ
				cNumCheq   	:= NEWSE5->E5_NUMCHEQ
				cRecPag 		:= NEWSE5->E5_RECPAG
				cMotBaixa	:= NEWSE5->E5_MOTBX
				cTipo190		:= NEWSE5->E5_TIPO

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Obter moeda da conta no Banco.                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If cPaisLoc	# "BRA".And.!Empty(NEWSE5->E5_BANCO+NEWSE5->E5_AGENCIA+NEWSE5->E5_CONTA)
					SA6->(DbSetOrder(1))
					SA6->(DbSeek(xFilial()+NEWSE5->E5_BANCO+NEWSE5->E5_AGENCIA+NEWSE5->E5_CONTA))
					nMoedaBco	:=	Max(SA6->A6_MOEDA,1)
				Else
					nMoedaBco	:=	1
				Endif

				dbSelectArea("SM2")
				dbSetOrder(1)
				dbSeek(NEWSE5->E5_DATA)
				dbSelectArea("NEWSE5")
				nRecSe5:=Recno()

				Do Case
				Case NEWSE5->E5_TIPODOC $ "DC/D2"
					nDesc+=Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VALOR,xMoeda(NEWSE5->E5_VALOR,nMoedaBco,mv_par12,NEWSE5->E5_DATA))
				Case NEWSE5->E5_TIPODOC $ "JR/J2/TL"
					nJuros+=Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VALOR,xMoeda(NEWSE5->E5_VALOR,nMoedaBco,mv_par12,NEWSE5->E5_DATA))
				Case NEWSE5->E5_TIPODOC $ "VL/V2/BA/RA/PA/CP"
					cHistorico := NEWSE5->E5_HISTOR
					nValor+=Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VALOR,xMoeda(NEWSE5->E5_VALOR,nMoedaBco,mv_par12,NEWSE5->E5_DATA))
				Case NEWSE5->E5_TIPODOC $ "MT/M2"
					nMulta+=Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VALOR,xMoeda(NEWSE5->E5_VALOR,nMoedaBco,mv_par12,NEWSE5->E5_DATA))
				Case NEWSE5->E5_TIPODOC $ "CM/C2"
					nCM+=Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VALOR,xMoeda(NEWSE5->E5_VALOR,nMoedaBco,mv_par12,NEWSE5->E5_DATA))
				OtherWise
					nVlMovFin+=Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VALOR,xMoeda(NEWSE5->E5_VALOR,nMoedaBco,mv_par12,NEWSE5->E5_DATA))
					cHistorico := Iif(Empty(NEWSE5->E5_HISTOR),"MOV FIN MANUAL",NEWSE5->E5_HISTOR)
					cNatureza  	:= NEWSE5->E5_NATUREZ
				EndCase

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se o proximo tambem ‚ mov banc manu-³
				//³ al e caso positivo, deixa o la‡o.            ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nRegAtu := RecNo()
				If Empty(NEWSE5->E5_TIPODOC)
					NEWSE5->( dbSkip() )
					If Empty(NEWSE5->E5_TIPODOC)
						dbGoto(nRegAtu)
						Exit
					Endif
				Endif
				dbGoto(nRegAtu)
				dbSkip()
			EndDO

			If (nDesc+nValor+nJuros+nCM+nMulta+nVlMovFin) > 0
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ C lculo do Abatimento        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lCarteira == "R"
					dbSelectArea("SE1")
					nRecno := Recno()
					nAbat := SomaAbat(cPrefixo,cNumero,cParcela,"R",mv_par12,,cFornece,cLoja)
					dbSelectArea("SE1")
					dbGoTo(nRecno)
				Else
					dbSelectArea("SE2")
					nRecno := Recno()
					nAbat :=	SomaAbat(cPrefixo,cNumero,cParcela,"P",mv_par12,,cFornece,cLoja)
					dbSelectArea("SE2")
					dbGoTo(nRecno)
				EndIF

				If li > 55
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
				EndIF

				@li, 0 PSAY cPrefixo
				@li, 4 PSAY cNumero
				@li,17 PSAY cParcela
				@li,19 PSAY cTipo

				If !lManual
					dbSelectArea("TRB")
					lOriginal := .T.
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Baixas a Receber             ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If lCarteira=="R"
						cCliFor190 := SE1->E1_CLIENTE+SE1->E1_LOJA
						nVlr:= SE1->E1_VLCRUZ
						If mv_par12 > 1
							nVlr := xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,mv_par12,SE1->E1_EMISSAO)
						EndIF
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Baixa de PA                  ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					Else
						cCliFor190 := SE2->E2_FORNECE+SE2->E2_LOJA
						nVlr:= SE2->E2_VLCRUZ
						If mv_par12 > 1
							nVlr := xMoeda(SE2->E2_VALOR,SE2->E2_MOEDA,mv_par12,SE2->E2_EMISSAO)
						Endif
					Endif

					IF DbSeek( cPrefixo+cNumero+cParcela+cCliFor190+cTipo)
						nVlr:=0
						nAbat:=0
						lOriginal := .F.
					Else
						nVlr:=NoRound(nVlr)
						RecLock("TRB",.T.)
						Replace linha With cPrefixo+cNumero+cParcela+cCliFor190+cTipo
						MsUnlock()
					EndIF
				Else
					dbSelectArea("NEWSE5")
					dbgoto(nRecSe5)
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Obter moeda da conta no Banco.                               ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If cPaisLoc	# "BRA".And.!Empty(NEWSE5->E5_BANCO+NEWSE5->E5_AGENCIA+NEWSE5->E5_CONTA)
						SA6->(DbSetOrder(1))
						SA6->(DbSeek(xFilial()+NEWSE5->E5_BANCO+NEWSE5->E5_AGENCIA+NEWSE5->E5_CONTA))
						nMoedaBco	:=	Max(SA6->A6_MOEDA,1)
					Else
						nMoedaBco	:=	1
					Endif
					nVlr := xMoeda(NEWSE5->E5_VALOR,nMoedaBco,mv_par12,NEWSE5->E5_DATA)
					nAbat:= 0
					lOriginal := .t.
					NEWSE5->( dbSkip() )
					nRecSe5:=Recno()
					dbSelectArea("TRB")
				Endif
				IF lCarteira == "R"
					If ( !lManual )
						If mv_par13 == 1  // Utilizar o Hist¢rico da Baixa ou Emiss„o
							cHistorico := Iif(Empty(cHistorico), SE1->E1_HIST, cHistorico )
						Else
							cHistorico := Iif(Empty(SE1->E1_HIST), cHistorico, SE1->E1_HIST )
						Endif
					EndIf
					If lBxTit
						@li, 23 PSAY SE1->E1_CLIENTE
					Endif
					If ( !lManual )
						@li, 30 PSAY SubStr(cCliFor,1,18)
					EndIf
					@li, 49 PSAY cNatureza
					If Empty( dDtMovFin ) .or. dDtMovFin == Nil
						dDtMovFin := CtoD("  /  /  ")
					Endif
					@li, 60 PSAY IIf(lManual,dDtMovFin,DataValida(SE1->E1_VENCTO,.T.))
					@li, 71 PSAY SubStr( cHistorico ,1,18)
					@li, 90 PSAY dBaixa
					IF nVlr > 0
						@li,101 PSAY nVlr  Picture tm(nVlr,14,nDecs)
					Endif

				Elseif !lManual
					If ( !lManual )
						If mv_par13 == 1  // Utilizar o Hist¢rico da Baixa ou Emiss„o
							cHistorico := Iif(Empty(cHistorico), SE2->E2_HIST, cHistorico )
						Else
							cHistorico := Iif(Empty(SE2->E2_HIST), cHistorico, SE2->E2_HIST )
						Endif
					EndIf
					If lBxTit .And. !lManual
						@li, 23 PSAY SE2->E2_FORNECE
					Endif
					If ( !lManual )
						@li, 30 PSAY SubStr(cCliFor,1,18)
					EndIf
					@li, 49 PSAY cNatureza
					If Empty( dDtMovFin ) .or. dDtMovFin == Nil
						dDtMovFin := CtoD("  /  /  ")
					Endif
					@li, 60 PSAY IIf(lManual,dDtMovFin,DataValida(SE2->E2_VENCTO,.T.))
					If !Empty(cCheque)
						@li, 71 PSAY SubStr(ALLTRIM(cCheque)+"/"+Trim(cHistorico),1,18)
					Else
						@li, 71 PSAY SubStr(ALLTRIM(cHistorico),1,18)
					EndIf
					@li, 90 PSAY dBaixa
					IF nVlr > 0
						@li,101 PSAY nVlr Picture tm(nVlr,14,nDecs)
					Endif
				Endif
				nCT++
				@li,116 PSAY nJuros     PicTure tm(nJuros,12,nDecs)
				@li,129 PSAY nMulta     PicTure tm(nMulta,12,nDecs)
				@li,142 PSAY nCM        PicTure tm(nCM ,12,nDecs)
				@li,155 PSAY nDesc      PicTure tm(nDesc,12,nDecs)
				@li,168 PSAY nAbat  		Picture tm(nAbat,12,nDecs)
				If nVlMovFin > 0
					@li,181 PSAY nVlMovFin     PicTure tm(nVlMovFin,14,nDecs)
				Else
					@li,181 PSAY nValor			PicTure tm(nValor,14,nDecs)
				Endif
				@li,196 PSAY cBanco
				@li,200 PSAY dDigit

				nPos := Ascan(aMotBx, {|x| Substr(x,1,3) == Upper( cMotBaixa) })
				If nPos > 0
					cMotBxImp := Substr(aMotBx[nPos],07,09)
				ElseIf cMotBaixa == "CMP"
					cMotBxImp := OemToAnsi(STR0026)  //"COMPENSAC"
				ElseIf cMotBaixa == "CEC"
					cMotBxImp := OemToAnsi(STR0027)  //"COMP CART"
				ElseIf cMotBaixa == "LIQ"
					cMotBxImp := OemToAnsi(STR0033)  //"LIQUIDAC."
				ElseIf empty(cMotBaixa)
					cMotBxImp := OemToAnsi(STR0022) //"NORMAL"
				Endif

				@li,211 PSAY cMotBxImp
				nTotOrig   += Iif(lOriginal,nVlr,0)
				nTotBaixado+= Iif(cTipodoc == "CP",0,nValor)		// n„o soma, j  somou no principal
				nTotDesc   += nDesc
				nTotJuros  += nJuros
				nTotMulta  += nMulta
				nTotCM     += nCM
				nTotAbat   += nAbat
				nTotValor  += IIF( nVlMovFin <> 0, nVlMovFin , Iif(MovBcoBx(cMotBaixa),nValor,0))
				nTotMovFin += nVlMovFin
				nTotComp	  += Iif(cTipodoc == "CP",nValor,0)
				Store 0 To nDesc,nJuros,nValor,nMulta,nCM,nAbat, nVlMovFin
				li++
			Endif
			dbSelectArea("NEWSE5")
		Enddo

		If (nTotValor+nDesc+nJuros+nCM+nTotMulta+nTotOrig+nTotMovFin+nTotComp)>0
			li++
			IF li > 55
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
			Endif
			If nCT > 0
				IF nOrdem == 1 .or. nOrdem == 6
					@li, 0 PSAY "Sub Total : " + DTOC(cAnterior)
				Elseif nOrdem == 2 .or. nOrdem == 4 .or. nOrdem == 7
					@li, 0 PSAY "Sub Total : "+cAnterior
					If nOrdem == 4
						If (mv_par11 == 1 .and. (cRecpag == "R" .and. !(cTipo190 $ "PA /"+MV_CPNEG))) .or. ;
								(cRecpag == "P" .and. cTipo190 $ "RA /"+MV_CRNEG)

							dbSelectArea("SA1")
							DbSetOrder(1)
							If !Empty(cAnterior)
								dbSeek(cFilial+cAnterior)
								cLinha:=TRIM(A1_NOME)+"  "+A1_CGC
							Else
								cLinha:= OemToAnsi(STR0038)  //"Moviment. Financeiras Manuais "
							Endif

						ElseIF (mv_par11 == 2 .and. (cRecpag == "P" .and. !(cTipo190 $ "RA /"+MV_CRNEG))) .or.;
								(cRecpag == "R" .and. cTipo190 $ "PA /"+MV_CPNEG)

							dbSelectArea("SA2")
							DbSetOrder(1)
							If !Empty(cAnterior)
								dbSeek(cFilial+cAnterior)
								cLinha:=TRIM(A2_NOME)+"  "+A2_CGC
							Else
								cLinha:= OemToAnsi(STR0038)  //"Moviment. Financeiras Manuais "
							Endif
						Endif
						@li,20 PSAY cLinha
					Elseif nOrdem == 2
						dbSelectArea("SA6")
						DbSetOrder(1)
						dbSeek(cFilial+cAnterior)
						cLinha:=TRIM(A6_NOME)
						@li,20 PSAY cLinha
					Endif
				Elseif nOrdem == 3
					dbSelectArea("SED")
					DbSetOrder(1)
					dbSeek(cFilial+cAnterior)
					@li, 0 PSAY "SubTotal : " + cAnterior + " "+ED_DESCRIC
				Endif
				If nOrdem != 5
					@li,101 PSAY nTotOrig     PicTure tm(nTotOrig,14,nDecs)
					@li,116 PSAY nTotJuros    PicTure tm(nTotJuros,12,nDecs)
					@li,129 PSAY nTotMulta    PicTure tm(nTotMulta,12,nDecs)
					@li,142 PSAY nTotCM       PicTure tm(nTotCM ,12,nDecs)
					@li,155 PSAY nTotDesc     PicTure tm(nTotDesc,12,nDecs)
					@li,168 PSAY nTotAbat     Picture tm(nTotAbat,12,nDecs)
					@li,181 PSAY nTotValor    PicTure tm(nTotValor,14,nDecs)
					If (nTotValor != nTotBaixado) .or. (nTotMovFin > 0)
						@li,197 PSAY OemToAnsi(STR0028)  //"Baixados"
						@li,206 PSAY nTotBaixado  PicTure tm(nTotBaixado,14,nDecs)
						li++
						@li,197 PSAY OemToAnsi(STR0031)   //"Mov Fin."
						@li,206 PSAY nTotMovFin   PicTure tm(nTotMovFin,14,nDecs)
					Endif
					If nTotComp > 0
						li++
						@li,197 PSAY STR0037  //"Compens."
						@li,206 PSAY nTotComp     PicTure tm(nTotComp,14,nDecs)
					Endif
					li+=2
				Endif
				dbSelectArea("NEWSE5")
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Incrementa Totais Gerais ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nGerOrig		+= nTotOrig
		nGerValor	+= nTotValor
		nGerDesc		+= nTotDesc
		nGerJuros	+= nTotJuros
		nGerCM		+= nTotCM
		nGerMulta	+= nTotMulta
		nGerAbat		+= nTotAbat
		nGerBaixado += nTotBaixado
		nGerMovFin	+= nTotMovFin
		nGerComp		+= nTotComp
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Incrementa Totais Filial ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nFilOrig		+= nTotOrig
		nFilValor	+= nTotValor
		nFilDesc		+= nTotDesc
		nFilJuros	+= nTotJuros
		nFilCM		+= nTotCM
		nFilMulta	+= nTotMulta
		nFilAbat		+= nTotAbat
		nFilBaixado += nTotBaixado
		nFilMovFin	+= nTotMovFin
		nFilComp		+= nTotComp
	Enddo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprimir TOTAL por filial somente quan-³
	//³ do houver mais do que 1 filial.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	if mv_par17 == 1 .and. SM0->(Reccount()) > 1
		@li,  0 PSAY "FILIAL : " +  cFilAnt + " - " + cFilNome
		@li,101 PSAY nFilOrig       PicTure tm(nFilOrig,14,nDecs)
		@li,116 PSAY nFilJuros      PicTure tm(nFilJuros,12,nDecs)
		@li,129 PSAY nFilMulta      PicTure tm(nFilMulta,12,nDecs)
		@li,142 PSAY nFilCM         PicTure tm(nFilCM ,12,nDecs)
		@li,155 PSAY nFilDesc       PicTure tm(nFilDesc,12,nDecs)
		@li,168 PSAY nFilAbat       PicTure tm(nFilAbat,12,nDecs)
		@li,181 PSAY nFilValor      PicTure tm(nFilValor,14,nDecs)
		If (nFilValor != nFilBaixado) .or. (nFilMovFin != 0)
			@li,197 PSAY OemToAnsi(STR0028) // "Baixados"
			@li,206 PSAY nFilBaixado    PicTure tm(nFilBaixado,14,nDecs)
			li++
			@li,197 PSAY OemToAnsi(STR0031)   //"Mov Fin."
			@li,206 PSAY nFilMovFin   PicTure tm(nFilMovFin,14,nDecs)
		Endif
		If nFilComp > 0
			li++
			@li,197 PSAY STR0037  //"Compens."
			@li,206 PSAY nFilComp     PicTure tm(nFilComp,14,nDecs)
		Endif
		li+=2
		If Empty(xFilial("SE5"))
			Exit
		Endif

		Store 0 TO nFilOrig,nFilJuros,nFilMulta,nFilCM,nFilDesc,nFilAbat,nFilValor
		Store 0 TO nFilBaixado,nFilMovFin, nFilComp
	Endif
	dbSelectArea("SM0")
	dbSkip()
Enddo

If li != 80
	li+=2
	@li,  0 PSAY OemToAnsi(STR0029)  //"Total Geral : "
	@li,101 PSAY nGerOrig       PicTure tm(nGerOrig,14,nDecs)
	@li,116 PSAY nGerJuros      PicTure tm(nGerJuros,12,nDecs)
	@li,129 PSAY nGerMulta      PicTure tm(nGerMulta,12,nDecs)
	@li,142 PSAY nGerCM         PicTure tm(nGerCM ,12,nDecs)
	@li,155 PSAY nGerDesc       PicTure tm(nGerDesc,12,nDecs)
	@li,168 PSAY nGerAbat       PicTure tm(nGerAbat,12,nDecs)
	@li,181 PSAY nGerValor      PicTure tm(nGerValor,14,nDecs)
	If (nGerValor != nGerBaixado) .or. (nGerMovFin != 0)
		@li,197 PSAY OemToAnsi(STR0028) // "Baixados"
		@li,206 PSAY nGerBaixado    PicTure tm(nGerBaixado,14,nDecs)
		li++
		@li,197 PSAY OemToAnsi(STR0031)   //"Mov Fin."
		@li,206 PSAY nGerMovFin   PicTure tm(nGerMovFin,14,nDecs)
	Endif
	If nGerComp > 0
		li++
		@li,197 PSAY STR0037  //"Compens."
		@li,206 PSAY nGerComp     PicTure tm(nGerComp,14,nDecs)
	Endif
	roda(cbcont,cbtxt,"G")
Endif

SM0->(dbgoto(nRecEmp))
cFilAnt := SM0->M0_CODFIL
dbSelectArea("TRB")
dbCloseArea()
Ferase(cNomArq1+".DBF")
dbSelectArea("NEWSE5")
dbCloseArea()

// Inicio da alteracao

If cNomeArq # Nil
	Ferase(cNomeArq+OrdBagExt())
Endif

// Fim da alteracao

dbSelectArea("SE5")
dbSetOrder(1)

If aReturn[5] == 1
	Set Printer to
	dbCommit()
	OurSpool(wnrel)
Endif

SET SOFTSEEK OFF

MS_FLUSH()


// Compatibiliza o SX1
STATIC FUNCTION AjustaSx1()
Local cAlias:=Alias(),aPerg:={}
Local cPerg := "FIN190"
Aadd(aPerg,{"NCC Compensados    ?","N",1})

dbSelectArea("SX1")
If !dbSeek(cPerg+"24")
	RecLock("SX1",.T.)
	Replace X1_GRUPO   	with cPerg
	Replace X1_ORDEM   	with "24"
	Replace X1_PERGUNT 	with aPerg[1][1]
	Replace X1_VARIAVL 	with "mv_chm"
	Replace X1_TIPO	 	with aPerg[1][2]
	Replace X1_TAMANHO 	with aPerg[1][3]
	Replace X1_PRESEL  	with 2
	Replace X1_GSC	   	with "C"
	Replace X1_VAR01   	with "mv_par24"
	Replace X1_DEF01   	with "Sim"
	Replace X1_DEF02   	with "Nao"
	MsUnlock()
EndIf
dbSelectArea(cAlias)

Return
