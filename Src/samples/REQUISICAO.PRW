#INCLUDE "RWMAKE.CH"
#include "TbiConn.ch"
#include "TbiCode.ch"
#INCLUDE "AP5MAIL.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FONT.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³RCOMR01   ³ Autor ³                       ³ Data ³06.08.2014³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao de Requisição Por Pedidos - TmsPrinter            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³Especifico ANHEMBIBORRACHA                                  ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function RFATR05()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL oDlg := NIL
PRIVATE titulo 	:= ""
PRIVATE nLastKey:= 0
PRIVATE cPerg	:= "FATR11"
PRIVATE nomeProg:= FunName()
Private nTotal	:= 0
Private nSubTot	:= 0
Private nSldaPreq:=0
Private nQuant:=  0
Private nPosald:= 0
Private  nvezez:=0
AjustaSx1()
If ! Pergunte(cPerg,.T.)
	Return
Endif





//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					  		³
//³ mv_par01				// Numero da Requisicao DE       		³
//³ mv_par02				// Numero da Requisicao ATE      		³
//³ mv_par03				// FILIAL OU MATRIZ                 	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := FunName()            //Nome Default do relatorio em Disco

PRIVATE cTitulo := "Impressão de Requisição por Pedido  de Vendas"
PRIVATE oPrn    := NIL
PRIVATE oFont1  := NIL
PRIVATE oFont2  := NIL
PRIVATE oFont3  := NIL
PRIVATE oFont4  := NIL
PRIVATE oFont5  := NIL
PRIVATE oFont6  := NIL
//Private cPerg := "FATR05"
Private nLastKey := 0
Private nLin := 1650 // Linha de inicio da impressao da Requisicao
Private QRY := GetNextAlias()


DEFINE FONT oFont1 NAME "Times New Roman" SIZE 0,20 BOLD  OF oPrn
DEFINE FONT oFont2 NAME "Times New Roman" SIZE 0,14 BOLD OF oPrn
DEFINE FONT oFont3 NAME "Times New Roman" SIZE 0,14 OF oPrn
DEFINE FONT oFont4 NAME "Times New Roman" SIZE 0,14 ITALIC OF oPrn
DEFINE FONT oFont5 NAME "Times New Roman" SIZE 0,14 OF oPrn
DEFINE FONT oFont6 NAME "Courier New" BOLD

oFont08	 := TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont08N := TFont():New("Arial",08,08,,.T.,,,,.T.,.F.)
oFont10	 := TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFont11  := TFont():New("Arial",11,11,,.F.,,,,.T.,.F.)
oFont14	 := TFont():New("Arial",14,14,,.F.,,,,.T.,.F.)
oFont16	 := TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFont10N := TFont():New("Arial",10,10,,.T.,,,,.T.,.F.)
oFont12  := TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFont12N := TFont():New("Arial",10,10,,.T.,,,,.T.,.F.)
oFont16N := TFont():New("Arial",16,16,,.T.,,,,.T.,.F.)
oFont14N := TFont():New("Arial",14,14,,.T.,,,,.T.,.F.)
oFont06	 := TFont():New("Arial",06,06,,.F.,,,,.T.,.F.)
oFont06N := TFont():New("Arial",06,06,,.T.,,,,.T.,.F.)
oFont18N := TFont():New("Arial",18,18,,.T.,,,,.T.,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tela de Entrada de Dados - Parametros                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLastKey  := IIf(LastKey() == 27,27,nLastKey)

If nLastKey == 27
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio do lay-out / impressao                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oPrn := TMSPrinter():New(cTitulo)
oPrn:Setup()
oPrn:SetLandsCape()//SetPortrait()
oPrn:StartPage()
Imprimir()
oPrn:EndPage()
oPrn:End()


DEFINE MSDIALOG oDlg FROM 264,182 TO 441,613 TITLE cTitulo OF oDlg PIXEL
@ 004,010 TO 082,157 LABEL "" OF oDlg PIXEL

@ 015,017 SAY "Esta rotina tem por objetivo imprimir"	OF oDlg PIXEL Size 150,010 FONT oFont6 COLOR CLR_HBLUE
@ 030,017 SAY "o impresso customizado:"					OF oDlg PIXEL Size 150,010 FONT oFont6 COLOR CLR_HBLUE
@ 045,017 SAY "Requisição por Pedido de Venda" 						OF oDlg PIXEL Size 150,010 FONT oFont6 COLOR CLR_HBLUE

@ 06,167 BUTTON "&Imprime" 		SIZE 036,012 ACTION oPrn:Print()   	OF oDlg PIXEL
@ 28,167 BUTTON "Pre&view" 		SIZE 036,012 ACTION oPrn:Preview() 	OF oDlg PIXEL
@ 49,167 BUTTON "Sai&r"    		SIZE 036,012 ACTION oDlg:End()     	OF oDlg PIXEL

ACTIVATE MSDIALOG oDlg CENTERED

oPrn:End()


Return

/*
_____________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Funçào    ¦ IMPRIMIR  ¦ Autor ¦ Washington Leao      ¦ Data ¦06.08.2014¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Descriçào ¦ Impressao Requiscao por Pedido de Venda                    ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Uso       ¦ ANHEMBIBORRACHA                                            ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/

STATIC FUNCTION Imprimir()

Reqtdval()

Ms_Flush()
Return

/*/
_____________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Funçào    ¦ ORCAMENTO ¦ Autor ¦ Washington Leao      ¦ Data ¦06.08.2014¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Descriçào ¦ Impressao 										          ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Uso       ¦ ANHEMBIBORRACHA                                            ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
/*/

STATIC FUNCTION Reqtdval()

cWhere := ""

If Upper(MV_PAR03)=="M"
   cWhere := "C6_XSTATUS IN ('M','F')"
ElseIf Upper(MV_PAR03)=="F"
   cWhere := "C6_XSTATUS IN ('F')"

Endif 

Alert(cWhere)

BeginSql Alias QRY
	
	
	SELECT	C5_FILIAL,C5_CLIENTE,C5_NUM,C5_EMISSAO,C6_FILIAL,C6_CLI,C6_NUM,C6_XOP,
	C6_XQATU,C6_QTDVEN,C6_XOBSAD,C6_PRCVEN,C6_PRODUTO,C6_PEDCLI,C6_XSTATUS,C6_XSALDOA,
	B1_COD,B1_DESC,B1_XCCOB,B1_PESBRU,B1_PESO,B1_LOCPAD,B2_COD,B2_QATU,B2_QFIM,B2_LOCAL,
	B2_QEMP,B2_RESERVA,B2_QPEDVEN,A1_COD,A1_LOJA,A1_PESSOA,A1_NOME,A1_EST,A1_MUN,A1_BAIRRO,A1_CEP,A1_CGC
	FROM %Table:SC5% SC5,%Table:SC6% SC6,%Table:SA1% SA1,%Table:SB1% SB1,%Table:SB2% SB2
	WHERE SC5.C5_FILIAL = %xFilial:SC6% AND %Exp:cWhere% AND
	SC5.C5_EMISSAO BETWEEN %Exp:Dtos(MV_PAR01)% AND %Exp:Dtos(MV_PAR02)% AND
	SC5.C5_NUM =SC6.C6_NUM AND
	SC5.C5_CLIENTE = SA1.A1_COD AND
	SC5.C5_LOJACLI = SA1.A1_LOJA AND
	SC6.C6_PRODUTO = SB1.B1_COD  AND
	SC6.C6_PRODUTO = SB2.B2_COD  AND
	SC5.%notdel% AND SC6.%notdel% AND SA1.%notdel% AND SB1.%notdel% AND SB2.%notdel%
	
	ORDER BY C5_CLIENTE,C5_NUM,C5_EMISSAO
	
EndSql
Alert(cWhere)

/*
cWhere := ""

If Upper(MV_PAR03)=="M"
   cWhere := "C6_XSTATUS IN ('M')"
ElseIf Upper(MV_PAR03)=="F"
   cWhere := "C6_XSTATUS IN ('F')"
Endif

  */




cEmissao :=(QRY)->C5_EMISSAO
//    DIA                  MES                  ANO
cDataImpressao:=Substr(cEmissao,7,2)+"/"+Substr(cEmissao,5,2)+"/"+Substr(cEmissao,1,4)



//GetLastQuery()[2] comando para transformar a query para testar no APSDU ou SQL.


While (QRY)->(!Eof())
	
	
	oPrn:StartPage()
	cBitMap := "P:\Logo1.Bmp"
	oPrn:SayBitmap(1200,1200,cBitMap,2400,1700)			// Imprime logo da Empresa: comprimento X altura
	
	oPrn:Say(0030,0100,SM0->M0_NOMECOM,oFont14N)// Imprime o nome da Empresa
	
	
	
	
	
	
	// IMPRESSÃO DA REQUISIÇÃO COM 2 COPIAS.
	// A PRIMEIRA COM QUANTIDADE E VALOR QUE FICA COM A PAULA(VENDAS)
	// A SEGUNDA COM QUANTIDADE  E SEM VALOR QUE FICA COM O PESSOAL DO ESTOQUE
	
	// Verifica  se Imprime Matriz  se o Saldo apos Requisição(Pedido Liberado)é menor igual a quantidade atual do estoque
	
//	IF UPPER(mv_par03)=="M" .OR. mv_par03=="m".And.(QRY)->C6_XSTATUS=="M".Or.(QRY)->C6_XSTATUS=="F".And.MV_PAR02>=MV_PAR01
		
		
		
		
		
		oPrn:Say(0030,0100,SM0->M0_NOMECOM,oFont14N)// Imprime o nome da Empresa
		
		oPrn:Box(0180,0050,0830,2960)// Box das informações requisição
		
		// Impressão da requisição com quantidade e valor
		//	oPrn:Box(0030,2105,0130,2300)// Box das informações do codigo do pedido de venda
		// Impressão do numero do pedido de venda
		oPrn:Say(0030,1264, "PEDIDO DE VENDA PROTHEUS Nº",oFont14N)
		oPrn:Say(0037,2108,OemToAnsi((QRY)->C5_NUM),oFont14N)
		// Impressão do numero da requisição do produto para o almoxarifado e ou fabrica
		oPrn:Say(0200,0100,"REQUISICAO DE PRODUTO No:",oFont14N)
		oPrn:Say(0200,0900,OemToAnsi((QRY)->C6_XOP),oFont18N)
		// Impressão da data do Movimento.
		oPrn:Say(0200,1500,"MOVIMENTO:",oFont14N)
		oPrn:Say(0200,1830,OemToAnsi(cDataImpressao),oFont14)
		//Impressão do Nome do cliente+Codigo(Washington Miranda Leão 00001)
		oPrn:Say(0300,0100,"CLIENTE:",oFont14N)
		oPrn:Say(0300,0330,OemToAnsi(SUBST((QRY)->A1_NOME,1,47)),oFont14)
		// Impressão do Codigo do Cliente no Protheus
		oPrn:Say(0300,1260,((QRY)->A1_COD),oFont14N)
		// Impressao da Loja do Cliente
		oPrn:Say(0300,1400,((QRY)->A1_LOJA),oFont14N)
		
		//Impressão do Nome da Cidade do cliente
		//	oPrn:Say(0300,1440,"CIDADE:",oFont14N)
		cCidade:=(QRY)->A1_MUN
		oPrn:Say(0300,1447,OemToAnsi(cCidade),oFont14)
		
		// Impressão do Estado do cliente
		oPrn:Say(0300,2152,"UF:",oFont14N)
		cUF:=(QRY)->A1_EST
		oPrn:Say(0300,2210,OemToAnsi(cUF),oFont14)
		
		// Impressão do CNPJ do Cliente
		
		oPrn:Say(0300,2270,"CNPJ:",oFont14N)
		cCNPJ:=(QRY)->A1_CGC
		oPrn:Say(0300,2377,OemToAnsi(cCNPJ),oFont14)
		
		
		// Impressão do codigo do produto a ser vendido para o cliente
		oPrn:Say(0390,0100,"Nº.AB:",oFont14N)
		IF empty((QRY)->C6_PRODUTO)// Se este campo estiver vazio pego do campo B1_XCCOB(Codigo do produto no sistema COBOL)
			
			oPrn:Say(0390,0280,OemToAnsi((QRY)->B1_XCCOB),oFont14)
		Else // Caso o campo C6_PRODUTO estiver preenchido o sistema pega o codigo do campo C6_PRODUTO
			
			oPrn:Say(0390,0280,OemToAnsi((QRY)->C6_PRODUTO),oFont14)
		Endif
		// Impressão da descrição do complemento do produto
		oPrn:Say(0390,0680,"Compl:"	,oFont14N)
		oPrn:Say(0390,0880,OemToAnsi((QRY)->C6_XSTATUS ),oFont14)
		
		//Impressão da descrição da formula do produto
		oPrn:Say(0390,1400,"Formula:",oFont14N)
		oPrn:Say(0390,1615,OemToAnsi("30 /75"),oFont14)
		//Impressão da descrição do modelo do produto
		oPrn:Say(0390,2240,"Modelo:",oFont14N)
		cModelo:="R-10/R-6"
		oPrn:Say(0390,2430,OemToAnsi(cModelo),oFont14)
		//Impresssão do Numero da Cavidade do produto
		oPrn:Say(0450,0100,"Nº.Cavidades:"	,oFont14N)
		oPrn:Say(0450,0435,OemToAnsi(" 1"),oFont14)
		//Impressão do Numero do pedido do cliente
		oPrn:Say(0450,1000,"Nº.Pedido Cliente:" ,oFont14N)
		oPrn:Say(0450,1435,OemToAnsi("4500323110"),oFont14)
		//Impressão do Valor do produto a ser vendido
		oPrn:Say(0450,1900,"Valor:" ,oFont14N)
		oPrn:Say(0450,1990,Transform((QRY)->C6_PRCVEN,"@E 9,999,999.99",),oFont14)
		//Impressão da Quantidade do produto
		oPrn:Say(0540,0100,"Quantidade:"	,oFont14N)
		oPrn:Say(0540,0300,Transform((QRY)->C6_QTDVEN,"@E 9,999,999.99"),		oFont14)
		
		// Impressao do  Peso
		oPrn:Say(0540,0560,"Peso(KG):"	,oFont14N)
		nPesBrut:= Posicione("SB1",1,xFilial("SB1")+(QRY)->C6_PRODUTO,"B1_PESBRU")
		oPrn:Say(0540,0800,Transform(nPesBrut,"@E 9,999,999.99"),oFont14N)
		
		// Impressao do Volume
		oPrn:Say(0540,1150,"Volumes...:"	,oFont14N)
		oPrn:Say(0540,1380,"_________",oFont14)
		
		// Data informada pelo Almoxarifado/farica
		oPrn:Say(0540,1650,"Data...:"	,oFont14N)
		oPrn:Say(0540,1780,"___/____/____",oFont14)
		
		// Observacoes Adicionais
		oPrn:Say(0640,0100,"Observacoes Adicionais_:"	,oFont14N)
		//	oPrn:Say(0640,0500,((QRY)->C6_XOBSAD),oFont14)
		
		
		// Qauantidade de Estoque apos Requisicao
		oPrn:Say(0740,0100,"Estoque Apos Requisicao:"	,oFont14N)
		oPrn:Say(0740,0655,Transform((QRY)->C6_XSALDOA,"@E 9,999,999.99"),oFont14)
		
		// Status que indica se o produto sera produzido ou pego no estoque de São Paulo
		//	oPrn:Say(0740,0955,"Estoque Atendido/Fabricado:"	,oFont14N)
		
		If (QRY)->C6_XSTATUS=="F"
			oPrn:Say(0740,0955,OemToAnsi((QRY)->C6_XSTATUS),oFont14)
			oPrn:Say(0740,1075,OemToAnsi("(A Quantidade sera produzida pela Fabrica)"),oFont14)
			
		ElseIf (QRY)->C6_XSTATUS=="M"
			oPrn:Say(0740,0955,OemToAnsi((QRY)->C6_XSTATUS),oFont14)
			oPrn:Say(0740,1075,OemToAnsi("(A Quantidade sera atendida pelo Estoque de São Paulo)"),oFont14)
			
			
			
		Endif
		
		
		
		
		
		
		
		// Impressão da Requisição sem valor e  somente quantidade
		
		
		
		
		oPrn:Box(1200,0050,1930,2960)// Box dos dados da Requisicao
		
		oPrn:Say(1010,0100,SM0->M0_NOMECOM,oFont14N)// Imprime o nome da Empresa
		//Impressão do Numero do pedido de vendas no protheus
		oPrn:Say(1010,1270, "PEDIDO DE VENDA PROTHEUS Nº",oFont14N)
		oPrn:Say(1010,2103,OemToAnsi((QRY)->C5_NUM),oFont14N)
		//Impressão do numero da requisição do produto para o almoxarifado e ou fabrica
		oPrn:Say(1300,0100,"REQUISICAO DE PRODUTO No:",oFont14N)
		oPrn:Say(1300,0900,OemToAnsi((QRY)->C6_XOP),oFont18N)
		//Imprime a data do Movimento
		oPrn:Say(1300,1500,"MOVIMENTO:",oFont14N)
		oPrn:Say(1300,1830,OemToAnsi(cDataImpressao),oFont14)
		//Imprime o Nome +codigo do cliente
		oPrn:Say(1390,0100,"CLIENTE:",oFont14N)
		oPrn:Say(1390,0332,OemToAnsi(SUBST((QRY)->A1_NOME,1,47)),oFont14)
		// Impressao do Codigo do Cliente
		oPrn:Say(1390,1243,((QRY)->A1_COD),oFont14N)
		
		// Impressao da Loja do Cliente
		oPrn:Say(1390,1400,((QRY)->A1_LOJA),oFont14N)
		
		//Imprime o Nome da Cidade do Cliente
		cCidade:=(QRY)->A1_MUN
		oPrn:Say(1390,1447,OemToAnsi(cCidade),oFont14)
		//Imprime o Estado do Cliente
		oPrn:Say(1390,2152,"UF:",oFont14N)
		cUF:=(QRY)->A1_EST
		oPrn:Say(1390,2210,OemToAnsi(cUF),oFont14)
		// Impressão do CNPJ do Cliente
		oPrn:Say(1390,2270,"CNPJ:",oFont14N)
		cCNPJ:=(QRY)->A1_CGC
		oPrn:Say(1390,2377,OemToAnsi(cCNPJ),oFont14)
		
		
		
		
		//Imprime o codigo do Produto
		oPrn:Say(1480,0100,"Nº.AB:",oFont14N)
		
		IF empty((QRY)->C6_PRODUTO)//Se o campo C6_Produto estiver vazio eu pego o codigo do campo B1_XCCOB
			
			oPrn:Say(0390,0280,OemToAnsi((QRY)->B1_XCCOB),oFont14)
		Else // Caso o campo C6_PRODUTO não estiver vazio eu pego o codigo do produto do campo C6_PRODUTO
			
			oPrn:Say(0390,0280,OemToAnsi((QRY)->C6_PRODUTO),oFont14)
		Endif
		//Imprime o complemento do produto
		oPrn:Say(1480,0680,"Compl:"	,oFont14N)
		oPrn:Say(1480,0880,OemToAnsi((QRY)->C6_XSTATUS),oFont14)
		//Imprime o codigo da formula do produto
		oPrn:Say(1480,1400,"Formula:",oFont14N)
		oPrn:Say(1480,1615,OemToAnsi("30 /75"),oFont14)
		//Imprime o codigo do modelo do produto
		oPrn:Say(1480,2240,"Modelo:",oFont14N)
		cModelo:="R-10/R-6"
		oPrn:Say(1480,2430,OemToAnsi(cModelo),oFont14)
		//Imprime o codigo da cavidade do produto
		oPrn:Say(1540,0100,"Nº.Cavidades:"	,oFont14N)
		oPrn:Say(1540,0435,OemToAnsi(" 1"),oFont14)
		//Imprime o codigo do pedido do cliente
		oPrn:Say(1540,1000,"Nº.Pedido Cliente:" ,oFont14N)
		oPrn:Say(1540,1435,OemToAnsi("4500323110"),oFont14)
		//Imprime o valor do produto da requisição
		oPrn:Say(1540,1900,"Valor:" ,oFont14N)
		nValor:=0
		oPrn:Say(1540,1990,Transform(nvalor,"@E 9,999,999.99",),oFont14)
		//Imprime a quantidade do produto na requisição
		oPrn:Say(1630,0100,"Quantidade:"	,oFont14N)
		oPrn:Say(1630,0300,Transform((QRY)->C6_QTDVEN,"@E 9,999,999.99"),		oFont14)
		
		// Impressao do  Peso
		oPrn:Say(1630,0560,"Peso(KG):"	,oFont14N)
		nPesBrut:= Posicione("SB1",1,xFilial("SB1")+(QRY)->C6_PRODUTO,"B1_PESBRU")
		oPrn:Say(1630,0800,Transform(nPesBrut,"@E 9,999,999.99"),oFont14N)
		
		// Impressao do Volume
		oPrn:Say(1630,1150,"Volumes...:"	,oFont14N)
		oPrn:Say(1630,1380,"_________",oFont14)
		
		// Data informada pelo Almoxarifado/fabrica
		oPrn:Say(1630,1650,"Data...:"	,oFont14N)
		oPrn:Say(1630,1780,"___/____/____",oFont14)
		
		
		
		// Observacoes Adicionais
		oPrn:Say(1730,0100,"Observacoes Adicionais_:"	,oFont14N)
		//	oPrn:Say(1730,0500,OemToAnsi((QRY)->C6_XOBSAD),oFont14)
		
		nPosald:=Posicione("SB2",1,xFilial("SB2")+(QRY)->C6_PRODUTO,"B2_QATU")
		// Qauantidade de Estoque apos Requisicao
		oPrn:Say(1830,0100,"Estoque Apos Requisicao:"	,oFont14N)
		oPrn:Say(1830,0655,Transform((QRY)->C6_XSALDOA,"@E 9,999,999.99"),	oFont14)
		// Status que indica se o produto sera produzido ou pego no estoque de São Paulo
		//	oPrn:Say(1830,0955,"Estoque Atendido/Fabricado:"	,oFont14N)
		
		If (QRY)->C6_XSTATUS=="F"
			oPrn:Say(1830,0955,OemToAnsi((QRY)->C6_XSTATUS),oFont14)
			oPrn:Say(1830,1075,OemToAnsi("(A Quandidade sera produzida pela Fabrica)"),oFont14)
			
		ElseIf (QRY)->C6_XSTATUS=="M"
			oPrn:Say(1830,0955,OemToAnsi((QRY)->C6_XSTATUS),oFont14)
			oPrn:Say(1830,1075,OemToAnsi("(A Quantidade sera atendida pelo Estoque de São Paulo)"),oFont14)
			
			
			
		Endif
		
		
		
		
  //	Endif	
	
			
			
			
			
			
			oPrn:EndPage()
		// Next
		
		
		
		
//  ENDIF
	
	
	
	
	(QRY)->(DbSkip())
	
	
EndDo
dbcloseArea("QRY")
BeginSql Alias QRY
	
	
	SELECT	C5_FILIAL,C5_CLIENTE,C5_NUM,C5_EMISSAO,C6_FILIAL,C6_CLI,C6_NUM,C6_XOP,
	C6_XQATU,C6_QTDVEN,C6_XOBSAD,C6_PRCVEN,C6_PRODUTO,C6_VALOR,C6_DESCRI,C6_ITEM,C6_PEDCLI,C6_XSTATUS,C6_XSALDOA,
	B1_COD,B1_DESC,B1_XCCOB,B1_PESBRU,B1_PESO,B1_LOCPAD,B2_COD,B2_QATU,B2_QFIM,B2_LOCAL,
	B2_QEMP,B2_RESERVA,B2_QPEDVEN,A1_COD,A1_LOJA,A1_PESSOA,A1_NOME,A1_EST,A1_MUN,A1_BAIRRO,A1_CEP,A1_CGC
	FROM %Table:SC5% SC5,%Table:SC6% SC6,%Table:SA1% SA1,%Table:SB1% SB1,%Table:SB2% SB2
	WHERE SC5.C5_FILIAL = %xFilial:SC6% AND
	SC5.C5_EMISSAO BETWEEN %Exp:Dtos(MV_PAR01)% AND %Exp:Dtos(MV_PAR02)% AND
	SC5.C5_NUM =SC6.C6_NUM AND
	SC5.C5_CLIENTE = SA1.A1_COD AND
	SC5.C5_LOJACLI = SA1.A1_LOJA AND
	SC6.C6_PRODUTO = SB1.B1_COD  AND
	SC6.C6_PRODUTO = SB2.B2_COD AND
	SC5.%notdel% AND SC6.%notdel% AND SA1.%notdel% AND SB1.%notdel% AND SB2.%notdel%
	
	ORDER BY C5_CLIENTE,C5_NUM,C5_EMISSAO
	
EndSql

nLin:=2000
Public cC6Num:=((QRY)->C5_NUM)
Public nC6_Valor:=0
Public nC6_Total:=0
Public nC6_Cliente:=0
Public nC6_SOMCLI:=0 //VAI TOTALIZAR O VALOR A SER SOMADO POR CLIENTE
Public nC6_PEDCLI:=0 // IRA CONTAR O NUMERO DE PEDIDOS POR CLIENTES
Public nC6_Codcli:=Space(0)
Public nItens:=0
Public nQtdest:=0
Public nC6Iten:=((QRY)->C6_ITEM)


While (QRY)->(!Eof())
	
	If nLin >1500
		oPrn:StartPage()
		nLin:=050
		oPrn:Say(nLin,0100,"IMPRIMINDO CABEÇALHO",oFont14N)
		nLin+=110
		oPrn:Say(nLin,0100,"PEDIDO"+"   "+"_DATA_ "+"  "+"CLIENTE____________________"+"    "+       "PRODUTO____________AB__CPL_FORMULA"+"  "+"QUANTIDADE"+"  "+"VAL_UNIT"+"  " +"VAL_TOTAL"+"  "+"FICHA",oFont14N)
		nLin+=110
	Endif
	oPrn:Say(nLin,0100,((QRY)->C6_PEDCLI)+"   "+((QRY)->C5_EMISSAO)+"  "+Subs((QRY)->A1_NOME,1,30)    +"  "+((QRY)->C6_DESCRI)+" "+((QRY)->C6_PRODUTO)+"  "+Transform((QRY)->C6_QTDVEN,"@E 9,999,999.99")+"       "+Transform((QRY)->C6_PRCVEN,"@E 9,999,999.99")+"       "+Transform((QRY)->C6_VALOR,"@E 9,999,999.99")+"    "+ Transform((QRY)->C6_XOP,"@E 999999"),oFont14N)
	
	
	
	
	nLin+=110
	cC6Num:=((QRY)->C5_NUM)
	nC6_Codcli:=((QRY)->C5_CLIENTE)
	nC6_Valor+=((QRY)->C6_VALOR)
	nC6_Total+=((QRY)->C6_VALOR)
	nC6_SOMCLI+=((QRY)->C6_VALOR)
	nItens++
	
	
	(QRY)->(DbSkip())
	
	If (QRY)->(Eof()).OR.cC6Num<>((QRY)->C5_NUM)
		
		oPrn:Say(nLin,1270,"Sub-Total Pedidos"+TRANS(nC6_Valor,"@E 9,999,999.99",),oFont14)
		nLin+=110
		nC6_Valor:=0 // Zero o contador para não acumular os valores de todos os pedidos , mostrando apenas de cada pedido de venda
	Endif
	
	// Verifico se não é final de arquivo e se pedido é diferente, para somar
	// na quantidade de pedidos, para todos os cliente.
	If (QRY)->(!Eof()).And.cC6Num<>((QRY)->C5_NUM)
		
		nC6_PEDCLI++  //Variavel conta o número de Pedidos por clientes
		
		
	Endif
	// If  nC6_Codcli<>((QRY)->C5_CLIENTE)
	
	If  nC6_Codcli<>((QRY)->C5_CLIENTE)
		
		IF nC6_PEDCLI > 1
			nC6_CLIENTE+=nC6_SOMCLI
		Endif
		nC6_SOMCLI:=0
		
	Endif
	
Enddo

oPrn:Say(nLin,1270,"Total Geral..:"+TRANS(nC6_Total,"@E 9,999,999.99",),oFont14)
nLin+=110
// oPrn:Say(nLin,1270,"Cliente Totalizado..:"+TRANS(nC6_CLIENTE,"@E 9,999,999.99",),oFont14)
oPrn:Say(nLin,1270,"Cliente Totalizado..:"+TRANS(nC6_SOMCLI,"@E 9,999,999.99",),oFont14)

oPrn:StartPage()
oPrn:EndPage()
nLin:=2000

Public  nC6_Totval:=0
Public  nC6_Qtdtot:=0
Public   nC6_XQTDATU:=0


(QRY)->(DBGOTOP())
While (QRY)->(!Eof())
	
	oPrn:StartPage()
	
	If nLin >1500
		oPrn:StartPage()
		nLin:=050
		
		oPrn:Say(nLin,0100,"PEDIDO DO PERIODO",oFont14N)
		oPrn:Say(nLIn,2500,"PERIODO__:",oFont14N)
		nLin+=110
		oPrn:Say(nLin,0100,"PEDIDOS/FATURAMENTO",oFont14N)
		oPrn:Say(nLin,0650,SM0->M0_NOMECOM,oFont14N)
		oPrn:Say(nLIn,2500,"EMISSAO__:",oFont14N)
		nLin+=110
		oPrn:Say(nLin,0100,"PRODDUTO_____________________________________"+"   "+"QUANTIDADE"+"  "+"VALOR TOTAL"   +"  "+"SALDO EM ESTOQUE",oFont14N)
		
	Endif
	
	nLin+=110
	oPrn:Say(nLin,0100,((QRY)->C6_PRODUTO)+" "+((QRY)->C6_DESCRI)+"                  "+Transform((QRY)->C6_QTDVEN,"@E 9,999,999.99")+"            "+Transform((QRY)->C6_VALOR,"@E 9,999,999.99")+"           "+ Transform(nQuant,"@E 9,999,999.99"),oFont14N)
	
	
	
	// Transform(nPosald ,"@E 9,999,999.99")
	//	nC6_XQTDATU+=nPosald
	nC6_Qtdtot+=((QRY)->C6_QTDVEN)
	nC6_Totval+=((QRY)->C6_VALOR)
	
	(QRY)->(DbSkip())
	
	If (QRY)->(Eof())
		nLin+=110
		oPrn:Say(nLin,1270,"TOTAIS GERAIS....:"+TRANS(nC6_Qtdtot,"@E 9,999,999.99",)+TRANS(	nC6_Total,"@E 9,999,999.99",)+TRANS(nC6_XQTDATU,"@E 9,999,999.99",),oFont14)
		nLin+=110
		nC6_Total:=0 // Zero o contador para não acumular os valores de todos os pedidos , mostrando apenas de cada pedido de venda
	Endif
	nLin+=110
	
	
Enddo






Return






/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-¿±±
±±³Fun‡…o    ³ AjustaSX1    ³Autor ³  J.Marcelino Correa  ³    03.06.2005 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-´±±
±±³Descri‡…o ³ Ajusta perguntas do SX1                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1()


Local aArea := GetArea()
PutSx1(cPerg,"01","Data Emissao De                 ?"," "," ","mv_ch1","D",8,0,0,	"G","","   ","","","mv_par01"," "," "," ","",	" "," "," "," "," "," ", " "," "," "," ",	" "," ",{"Informe A Data de Emissao"},{"Informe A Data de Emissao"},{"Informe A Data de Emissao"})
PutSx1(cPerg,"02","Data Emissao Ate                ?"," "," ","mv_ch2","D",8,0,0,	"G","","   ","","","mv_par02"," "," "," ","",	" "," "," "," "," "," ", " "," "," "," ",	" "," ",{"Informe A Data de Emissao"},{"Informe A Data de Emissao"},{"Informe A Data de Emissao"})
PutSx1(cPerg,"03","Matriz/Filial                   ?"," "," ","mv_ch3","C",1,0,0,	"G","","   ","","","mv_par03"," "," "," ","",	" "," "," "," "," "," ", " "," "," "," ",	" "," ",{"Informe <M>atriz ou<F>ilial"},{"Informe <M>atriz ou<F>ilial"},{"Informe <M>atriz ou<F>ilial"})





RestArea(aArea)

Return

//Processo para salvar relatório como imagem

aCaminho           := {"\\192.168.1.8\teste.jpg"}
filepath          := "\192.168.1.8"
nwidthpage      := 630
nheightpage     := 870

aFiles := Directory(aCaminho[1])
For i:=1 to Len(aFiles)
	fErase("\\192.168.1.8\"+aFiles[1])
Next i

oPrint:SaveAllAsJpeg(filepath,nwidthpage,nheightpage,100)   //Gera arquivos JPEG na Pasta \Protheus_data\Images\

aFiles := {}
aFiles := Directory(aCaminho[1])

//Visualizacao e finalizacao do relatorio

oPrint:Setup()
oPrint:Preview()
oPrint:EndPage()
MS_FLUSH()



Return

