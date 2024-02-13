#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TrsnfPrd  º Autor ³ Itacolomy Mariano   Data ³  11/09/00    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP5 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function Transfprd

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de diretivas para Impressao                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


#define DET_SIZE  10
#define DET_OPER   1
#define DET_FL     2
#define DET_CODE1  3
#define DET_DESC1  4
#define DET_ALMX1  5
#define DET_QTDS   6
#define DET_DOC    7
#define DET_DAT    8
#define DET_TM     9
#define DET_KEYV  10

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private cString
cInd := ""
//Local aOrd := {}
Private CbTxt := ""
      cDesc1  := "Emite Relacao de Transferencias de Produtos para Produtos."
      cDesc2  := "informando quantidade Saida do Produto Origem e Quantidade"
      cDesc3  := "entrada no Produto Destino.           "
      cPict   := ""
Private lEnd  := .F.
Private lAbortPrint := .F.
Private limite  := 132
Private tamanho := "M"
Private nomeprog:= "TRANSFPRD" //Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo   := 15
Private aReturn := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey:= 0
Private cPerg := "TRANSF"
       titulo:= "Transferencias de Produto para Produto"
       nLin := 80

			     //        10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
			     //1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
			     //01  01 000101 5965TM0100119  CELULAR DIGITAL NOKIA 6120I        02   999,999,999,999  5965TM0100201  CELULAR DIGITAL NOKIA 6120TEST   03    999,999,999,999
      //Cabec1:= "Ope Fl NumDoc Cod.Prod.Orig. Descricao do Produto Origem      Alm.Or      Qtd. Saida  Cod.Prod Dest. Descricao Produto Destino     Alm.De      Qtd. Entrada"
      //Cabec2:= ""
      Cabec1 :="teste1"
      Cabec2 := ""
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
      imprime      := .T.
Private wnrel      := "TRANSFPR" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString := "SD3"
aOrd     := {" Por Operadora      "," Por Codigo         "," Por Data          "," Por Filial       "," Por Almoxarifado   " }

cInd := CriaTrab(NIL,.F.)
dbSelectArea("SD3")
IndRegua(cString,cInd,"D3_DOC+DTOS(D3_EMISSAO)+D3_COD",,,"Selecionando Registros...")


ValidPerg()

pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP5 IDE            º Data ³  11/09/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

nOrdem := ""

dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//SetRegua(RecCount())
SetRegua(LastRec())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posicionamento do primeiro registro e loop principal. Pode-se criar ³
//³ a logica da seguinte maneira: Posiciona-se na filial corrente e pro ³
//³ cessa enquanto a filial do registro for a filial corrente. Por exem ³
//³ plo, substitua o dbGoTop() e o While !EOF() abaixo pela sintaxe:    ³
//³                                                                     ³
//³ dbSeek(xFilial())                                                   ³
//³ While !EOF() .And. xFilial() == A1_FILIAL                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ O tratamento dos parametros deve ser feito dentro da logica do seu  ³
//³ relatorio. Geralmente a chave principal e a filial (isto vale prin- ³
//³ cipalmente se o arquivo for um arquivo padrao). Posiciona-se o pri- ³
//³ meiro registro pela filial + pela chave secundaria (codigo por exem ³
//³ plo), e processa enquanto estes valores estiverem dentro dos parame ³
//³ tros definidos. Suponha por exemplo o uso de dois parametros:       ³
//³ mv_par01 -> Indica o codigo inicial a processar                     ³
//³ mv_par02 -> Indica o codigo final a processar                       ³
//³                                                                     ³
//³ dbSeek(xFilial()+mv_par01,.T.) // Posiciona no 1o.reg. satisfatorio ³
//³ While !EOF() .And. xFilial() == A1_FILIAL .And. A1_COD <= mv_par02  ³
//³                                                                     ³
//³ Assim o processamento ocorrera enquanto o codigo do registro posicio³
//³ nado for menor ou igual ao parametro mv_par02, que indica o codigo  ³
//³ limite para o processamento. Caso existam outros parametros a serem ³
//³ checados, isto deve ser feito dentro da estrutura de laço (WHILE):  ³
//³                                                                     ³
//³ mv_par01 = DO PRODUTO                                               ³
//³ mv_par02 = ATE O PRODUTO                                            ³
//³ mv_par03 = DA DATA                                                  ³
//³ mv_par04 = ATE A DATA                                               ³
//³ mv_par05 = DO ALMOXARIFADO                                          ³
//³ mv_par06 = ATE O ALMOXARIFADO                                       ³
//³ mv_par07 = CONS.PARAMET.ABAIXO? - SIM/NAO                           ³
//³ mv_par08 = TIPO DE PRODUTO /Acessorio/Cartao/Handset Novo/Handset Usado/Kit Pre-pago ³
//³ mv_par09 = Selecione as Teles                                       ³
//³ mv_par10 = TELECEARA - SIM/NAO                                      ³
//³ mv_par11 = TELPE     - SIM/NAO                                      ³
//³ mv_par12 = TELERN    - SIM/NAO                                      ³
//³ mv_par13 = TELASA    - SIM/NAO                                      ³
//³ mv_par14 = TELPA     - SIM/NAO                                      ³
//³ mv_par15 = TELEPISA  - SIM/NAO                                      ³
//³                                                                     ³
//³ dbSeek(xFilial()+mv_par01,.T.) // Posiciona no 1o.reg. satisfatorio ³
//³ While !EOF() .And. xFilial() == A1_FILIAL .And. A1_COD <= mv_par02  ³
//³                                                                     ³
//³     If A1_EST <> mv_par03                                           ³
//³         dbSkip()                                                    ³
//³         Loop                                                        ³
//³     Endif                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declara Arquivo Temporario definindo Estrutura...                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aCampos := { { "OPERAD","C",02,00 },;  //Operadora
	   { "FILIAL","C",02,00 },;    //Filial
	       { "DOCUME","C",06,00 },;    //Documento que Registrou a Movimentacao
	       { "CODPR1","C",15,00 },;    //Codigo do Prod. Origem
	       { "DESPR1","C",30,00 },;    //Descricao do Prod. Origem
	       { "ALMPR1","C",02,00 },;    //Almoxarifado do Prod. Origem
	       { "QTDSAI","N",15,00 },;    //Quantidade Saida do Prod. Origem - Picture 999,999,999,999
	       { "DATAMV","D",08,00 },;    //Data que Realizou-se a Movimentacao
	   { "TIPOMV","C",03,00 } }    //Tipo de Movimentacao - 499:Entrada ou 999:Saida
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Indice do Arquivo Temporario                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//{" Por Operadora      "," Por Codigo         "," Por Data          "," Por Filial       "," Por Almoxarifado   " }
If aReturn[ 8 ] == 1
  cIndxKEY := "OPERAD+FILIAL+DOCUME+DATAMV"
ElseIf aReturn[ 8 ] == 2
  cIndxKEY := "CODPR1+OPERAD+FILIAL+DOCUME+DATAMV"
ElseIf aReturn[ 8 ] == 3
  cIndxKEY := "DATAMV+OPERAD+FILIAL+DOCUME"
ElseIf aReturn[ 8 ] == 4
  cIndxKEY := "FILIAL+OPERAD+FILIAL+DOCUME+DATAMV"
ElseIf aReturn[ 8 ] == 5
  cIndxKEY := "ALMPR1+CODPR1+OPERAD+FILIAL+DOCUME+DATAMV"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria, Abre e Indexa  Arquivo Temporario...                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cFileTRB := CriaTrab(aCampos,.T.)                                //Cria
DbUseArea(.F.,,cFileTRB,cFileTRB,.F.,.F.)                        //Abre
IndRegua( cFileTRB,cFileTRB,cIndxKEY,,,"Organizando Arquivo...") //Indexa

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Varre Dados da Teleceara ...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


If mv_par10 == 1 // Se a Teleceara foi escolhida para o Relatorio.
  
   SetRegua(LastRec())

  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  //³ Seleciona Registros do SD3_CE                                       ³
  //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   nSD3_CE := SELECT("SD3_CE")
   IF nSD3_CE == 0
      If Tccanopen("SD3010")              //Ita - Testa se existe a tabela na instancia do Banco de Dados. Retorna .T. ou .F.
	 DBUSEAREA(.T.,"TOPCONN","SD3010","SD3_CE",.T.,.F.) //Ita - Abre a tabela do Banco de Dados passando parametros de compartilhado e acesso p/ leitura/gravacao.
      EndIf
      // DBSETINDEX("\DADOSADV\SD3010.CDX")
   ENDIF

  dbSelectArea("SD3_CE")
  cFile   := CriaTrab(NIL,.F.)
  cInd    := "SD3_CE->D3_DOC + DTOS(SD3_CE->D3_EMISSAO) + SD3_CE->D3_COD"
  cFiltro := SD3_CE->D3_TRANSPR == "S" .AND. SD3_CE->D3_COD >= mv_par01 .And. SD3_CE->D3_COD <= mv_par02 .And. SD3_CE->D3_EMISSAO >= mv_par03 .And. SD3_CE->D3_EMISSAO <= mv_par04
  IndRegua([SD3_CE],cFile,cInd,,cFiltro,"Selecionando Transferencias de Produtos - MultiFilial")
  dbGoTop()

  //dbGoTop()
  
  While SD3_CE->(!EOF())

     IncRegua() //Incrementa Regua de Impressao

     If SD3_CE->D3_TRANSPR == "S"
     
       DbSelectArea(cFileTRB)
       DbAppend()
     
	  FIELD->OPERAD := "01"
	      FIELD->FILIAL := SD3_CE->D3_FILIAL
	      FIELD->DOCUME := SD3_CE->D3_DOC 
	      FIELD->CODPR1 := SD3_CE->D3_COD
	      FIELD->DESPR1 := SD3_CE->D3_YDESPRO
	      FIELD->ALMPR1 := SD3_CE->D3_LOCAL
	      FIELD->QTDSAI := SD3_CE->D3_QUANT
	      FIELD->DATAMV := SD3_CE->D3_EMISSAO
	      FIELD->TIPOMV := SD3_CE->D3_TM
   
       DbCommit()
       DbUnLock()

     EndIf
     
     dbSkip() // Avanca o ponteiro do registro no arquivo
  
  EndDo

EndIf  // Finaliza Dados da Teleceara

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Varredura da Teleceara                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Varre Dados da Telpe ...                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par11 == 1 // Se a Telpe foi escolhida para o Relatorio.
  
   SetRegua(LastRec())

  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  //³ Seleciona Registros do SD3                                          ³
  //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

  dbSelectArea("SD3")
  cFile   := CriaTrab(NIL,.F.)
  cInd    := "SD3->D3_DOC + DTOS(SD3->D3_EMISSAO) + SD3->D3_COD"
  cFiltro := SD3->D3_TRANSPR == "S" .AND. SD3->D3_COD >= mv_par01 .And. SD3->D3_COD <= mv_par02 .And. SD3->D3_EMISSAO >= mv_par03 .And. SD3->D3_EMISSAO <= mv_par04
  IndRegua([SD3],cFile,cInd,,cFiltro,"Selecionando Transferencias de Produtos - MultiFilial")
  dbGoTop()

  //dbGoTop()
  
  While SD3->(!EOF())

     IncRegua() //Incrementa regua de impressao
     
     If SD3->D3_TRANSPR == "S" 

	DbSelectArea(cFileTRB)
	DbAppend()
    
	    FIELD->OPERAD := "02"
	    FIELD->FILIAL := SD3->D3_FILIAL
	    FIELD->DOCUME := SD3->D3_DOC 
	    FIELD->CODPR1 := SD3->D3_COD
	    FIELD->DESPR1 := SD3->D3_YDESPRO
	    FIELD->ALMPR1 := SD3->D3_LOCAL
	    FIELD->QTDSAI := SD3->D3_QUANT
	    FIELD->DATAMV := SD3->D3_EMISSAO
	    FIELD->TIPOMV := SD3->D3_TM

	DbCommit()
	DbUnLock()
     
     EndIf
     
     dbSkip() // Avanca o ponteiro do registro no arquivo
  
  EndDo

EndIf  // Finaliza Dados da Telpe

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Varredura da Telpe                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Varre Dados da Telern ...                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par12 == 1 // Se a Telern foi escolhida para o Relatorio.
  
  SetRegua(LastRec())

  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  //³ Seleciona Registros do SD3_RN                                       ³
  //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   nSD3_RN= SELECT("SD3_RN")
   IF nSD3_RN == 0
      If Tccanopen("SD3030")              //Ita - Testa se existe a tabela na instancia do Banco de Dados. Retorna .T. ou .F.
	 DBUSEAREA(.T.,"TOPCONN","SD3030","SD3_RN",.T.,.F.) //Ita - Abre a tabela do Banco de Dados passando parametros de compartilhado e acesso p/ leitura/gravacao.
      EndIf
      // DBSETINDEX("\DADOSADV\SD3030.CDX")
   ENDIF

  dbSelectArea("SD3_RN")
  cFile   := CriaTrab(NIL,.F.)
  cInd    := "SD3_RN->D3_DOC + DTOS(SD3_RN->D3_EMISSAO) + SD3_RN->D3_COD"
  cFiltro := SD3_RN->D3_TRANSPR == "S" .AND. SD3_RN->D3_COD >= mv_par01 .And. SD3_RN->D3_COD <= mv_par02 .And. SD3_RN->D3_EMISSAO >= mv_par03 .And. SD3_RN->D3_EMISSAO <= mv_par04
  IndRegua([SD3_RN],cFile,cInd,,cFiltro,"Selecionando Transferencias de Produtos - MultiFilial")
  dbGoTop()

  //dbGoTop()
  
  While SD3_RN->(!EOF())

     IncRegua() //Incremente Regua de Impressao
     
     If SD3_RN->D3_TRANSPR == "S"
     
	DbSelectArea(cFileTRB)
	DbAppend()
     
	FIELD->OPERAD := "01"
	FIELD->FILIAL := SD3_RN->D3_FILIAL
	    FIELD->DOCUME := SD3_RN->D3_DOC 
	    FIELD->CODPR1 := SD3_RN->D3_COD
	    FIELD->DESPR1 := SD3_RN->D3_YDESPRO
	    FIELD->ALMPR1 := SD3_RN->D3_LOCAL
	    FIELD->QTDSAI := SD3_RN->D3_QUANT
	    FIELD->DATAMV := SD3_RN->D3_EMISSAO
	    FIELD->TIPOMV := SD3_RN->D3_TM
 
	DbCommit()
	DbUnLock()
     
     EndIf
     
     dbSkip() // Avanca o ponteiro do registro no arquivo
  
  EndDo

EndIf  // Finaliza Dados da Telern


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Varredura da Telern                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Varre os dados da Telasa ...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par13 == 1 // Se a Telasa foi escolhida para o Relatorio.
  
  SetRegua(LastRec())

  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  //³ Seleciona Registros do SD3_AL                                       ³
  //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   nSD3_AL := SELECT("SD3_AL")
   IF nSD3_AL == 0
      If Tccanopen("SD3040")              //Ita - Testa se existe a tabela na instancia do Banco de Dados. Retorna .T. ou .F.
	 DBUSEAREA(.T.,"TOPCONN","SD3040","SD3_AL",.T.,.F.) //Ita - Abre a tabela do Banco de Dados passando parametros de compartilhado e acesso p/ leitura/gravacao.
      EndIf
      // DBSETINDEX("\DADOSADV\SD3040.CDX")
   ENDIF

  dbSelectArea("SD3_AL")
  cFile   := CriaTrab(NIL,.F.)
  cInd    := "SD3_AL->D3_DOC + DTOS(SD3_AL->D3_EMISSAO) + SD3_AL->D3_COD"
  cFiltro := SD3_AL->D3_TRANSPR == "S" .AND. SD3_AL->D3_COD >= mv_par01 .And. SD3_AL->D3_COD <= mv_par02 .And. SD3_AL->D3_EMISSAO >= mv_par03 .And. SD3_AL->D3_EMISSAO <= mv_par04
  IndRegua([SD3_AL],cFile,cInd,,cFiltro,"Selecionando Transferencias de Produtos - MultiFilial")
  dbGoTop()

  //dbGoTop()
  
  While SD3_AL->(!EOF())

     IncRegua() // Incrementa Regua de Impressao
     
     If SD3_AL->D3_TRANSPR == "S"
     
	DbSelectArea(cFileTRB)
	DbAppend()
    
	    FIELD->OPERAD := "01"
	    FIELD->FILIAL := SD3_AL->D3_FILIAL
	    FIELD->DOCUME := SD3_AL->D3_DOC 
	    FIELD->CODPR1 := SD3_AL->D3_COD
	    FIELD->DESPR1 := SD3_AL->D3_YDESPRO
	    FIELD->ALMPR1 := SD3_AL->D3_LOCAL
	    FIELD->QTDSAI := SD3_AL->D3_QUANT
	    FIELD->DATAMV := SD3_AL->D3_EMISSAO
	    FIELD->TIPOMV := SD3_AL->D3_TM

	DbCommit()
	DbUnLock()
     
     EndIf
     
     dbSkip() // Avanca o ponteiro do registro no arquivo
  
  EndDo

EndIf  // Finaliza Dados da Telasa

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Varredura da Telasa                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Varre dados da Telpa ...                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par14 == 1 // Se a Telpa foi escolhida para o Relatorio.
  
  SetRegua(LastRec())
  
  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  //³ Seleciona Registros do SD3_PB                                       ³
  //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   nSD3_PB := SELECT("SD3_PB")
   IF nSD3_PB == 0
      If Tccanopen("SD3050")              //Ita - Testa se existe a tabela na instancia do Banco de Dados. Retorna .T. ou .F.
	 DBUSEAREA(.T.,"TOPCONN","SD3050","SD3_PB",.T.,.F.) //Ita - Abre a tabela do Banco de Dados passando parametros de compartilhado e acesso p/ leitura/gravacao.
      EndIf
      // DBSETINDEX("\DADOSADV\SD3050.CDX")
   ENDIF

  dbSelectArea("SD3_PB")
  cFile   := CriaTrab(NIL,.F.)
  cInd    := "SD3_PB->D3_DOC + DTOS(SD3_PB->D3_EMISSAO) + SD3_PB->D3_COD"
  cFiltro := SD3_PB->D3_TRANSPR == "S" .AND. SD3_PB->D3_COD >= mv_par01 .And. SD3_PB->D3_COD <= mv_par02 .And. SD3_PB->D3_EMISSAO >= mv_par03 .And. SD3_PB->D3_EMISSAO <= mv_par04
  IndRegua([SD3_PB],cFile,cInd,,cFiltro,"Selecionando Transferencias de Produtos - MultiFilial")
  dbGoTop()

  //dbGoTop()
  
  While SD3_PB->(!EOF())

     IncRegua() // Incrementa Regua de Impressao
     
     If SD3_PB->D3_TRANSPR == "S"
     
	DbSelectArea(cFileTRB)
	DbAppend()
     
	    FIELD->OPERAD := "01"
	    FIELD->FILIAL := SD3_PB->D3_FILIAL
	    FIELD->DOCUME := SD3_PB->D3_DOC 
	    FIELD->CODPR1 := SD3_PB->D3_COD
	    FIELD->DESPR1 := SD3_PB->D3_YDESPRO
	FIELD->ALMPR1 := SD3_PB->D3_LOCAL
	    FIELD->QTDSAI := SD3_PB->D3_QUANT
	    FIELD->DATAMV := SD3_PB->D3_EMISSAO
	    FIELD->TIPOMV := SD3_PB->D3_TM
   
	DbCommit()
	DbUnLock()
     
     EndIf
     
     dbSkip() // Avanca o ponteiro do registro no arquivo
  
  EndDo

EndIf  // Finaliza Dados da Telpa 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Varredura da Telpa                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Varre dados da Telepisa ...                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par15 == 1 // Se a Telepisa foi escolhida para o Relatorio.
  
   SetRegua(LastRec())

  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  //³ Seleciona Registros do SD3_PI                                       ³
  //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   nSD3_PI := SELECT("SD3_PI")
   IF nSD3_PI == 0
      If Tccanopen("SD3060")              //Ita - Testa se existe a tabela na instancia do Banco de Dados. Retorna .T. ou .F.
	 DBUSEAREA(.T.,"TOPCONN","SD3060","SD3_PI",.T.,.F.) //Ita - Abre a tabela do Banco de Dados passando parametros de compartilhado e acesso p/ leitura/gravacao.
      EndIf
      // DBSETINDEX("\DADOSADV\SD3060.CDX")
   ENDIF

  dbSelectArea("SD3_PI")
  cFile   := CriaTrab(NIL,.F.)
  cInd    := "SD3_PI->D3_DOC + DTOS(SD3_PI->D3_EMISSAO) + SD3_PI->D3_COD"
  cFiltro := SD3_PI->D3_TRANSPR == "S" .AND. SD3_PI->D3_COD >= mv_par01 .And. SD3_PI->D3_COD <= mv_par02 .And. SD3_PI->D3_EMISSAO >= mv_par03 .And. SD3_PI->D3_EMISSAO <= mv_par04
  IndRegua([SD3_PI],cFile,cInd,,cFiltro,"Selecionando Transferencias de Produtos - MultiFilial")
  dbGoTop()

  //dbGoTop()
  
  While SD3_PI->(!EOF())

     IncRegua() // Incrementa Regua de Impressao

     If SD3_PI->D3_TRANSPR == "S"
     
	DbSelectArea(cFileTRB)
	DbAppend()
    
	    FIELD->OPERAD := "01"
	    FIELD->FILIAL := SD3_PI->D3_FILIAL
	    FIELD->DOCUME := SD3_PI->D3_DOC 
	    FIELD->CODPR1 := SD3_PI->D3_COD
	    FIELD->DESPR1 := SD3_PI->D3_YDESPRO
	    FIELD->ALMPR1 := SD3_PI->D3_LOCAL
	    FIELD->QTDSAI := SD3_PI->D3_QUANT
	    FIELD->DATAMV := SD3_PI->D3_EMISSAO
	    FIELD->TIPOMV := SD3_PI->D3_TM
   
	DbCommit()
	DbUnLock()
     
     EndIf
     
     dbSkip() // Avanca o ponteiro do registro no arquivo
  
  EndDo

EndIf  // Finaliza Dados da Telepisa 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Varredura da Telepisa                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis usadas durante impressao                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aPrnDET := nil

DbSelectArea(cFileTRB)
While cFileTRB->(!EOF())   
   
    If (LastKey() == 286) ; Exit ; EndIf
    If (aPrnDET == nil) 

       aPrnDET := Array( DET_SIZE )

       aPrnDET[ DET_OPER ] := FIELD->OPERAD 
       aPrnDET[ DET_FL   ] := FIELD->FILIAL 
       aPrnDET[ DET_CODE1] := FIELD->CODPR1
       aPrnDET[ DET_DESC1] := FIELD->DESPR1
       aPrnDET[ DET_ALMX1] := FIELD->ALMPR1
       aPrnDET[ DET_QTDS ] := FIELD->QTDSAI
       aPrnDET[ DET_DOC  ] := FIELD->DOCUME
       aPrnDET[ DET_DAT  ] := FIELD->DATAMV
     
       aPrnDET[ DET_KEYV ] := ""
    
    EndIf
    
    aDocMv := FIELD->DOCUME //Guarda Numero do Documento para Testar Posteriormente.
   
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

   If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif

//        10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
//1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//01  01 000101 5965TM0100119  CELULAR DIGITAL NOKIA 6120I        02   999,999,999,999  5965TM0100201  CELULAR DIGITAL NOKIA 6120TEST   03    999,999,999,999
//Ope Fl NumDoc Cod.Prod(Orig) Descricao do Produto(Origem)     Alm(O)      Qtd. Saida  Cod.Prod(Dest) Descricao Produto(Destino)     Almo(D)    Qtd. Entrada"
   
   //Impressao do Registro do produto Destino
   
   If FIELD->TM == "499"  // Movimentacao de Entrada do Produto Destino.
   
      @ nLin, 001 Psay aPrnDET[ DET_OPER ]
      @ nLin, 001 Psay aPrnDET[ DET_FL   ]
      @ nLin, 001 Psay aPrnDET[ DET_DOC  ]
      @ nLin, 001 Psay aPrnDET[ DET_DAT  ] 
      @ nLin, 001 Psay aPrnDET[ DET_CODE1] 
      @ nLin, 001 Psay aPrnDET[ DET_DESC1]
      @ nLin, 001 Psay aPrnDET[ DET_ALMX1]
      @ nLin, 001 Psay aPrnDET[ DET_QTDS ]  Picture "@EZ 999,999,999,999"
   
   //Impressao do Registro do produto Origem
   
   ElseIf FIELD->TM == "999" .And. FIEL->DOCUME == aDocMov
   
      @ nLin, 001 Psay aPrnDET[ DET_CODE1] 
      @ nLin, 001 Psay aPrnDET[ DET_DESC1] 
      @ nLin, 001 Psay aPrnDET[ DET_ALMX1] 
      @ nLin, 001 Psay aPrnDET[ DET_QTDS ]  Picture "@EZ 999,999,999,999"

      nLin := nLin + 1 // Avanca a linha de impressao
   
   EndIf
   
   dbSkip() // Avanca o ponteiro do registro no arquivo

EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³VALIDPERG º Autor ³ AP5 IDE            º Data ³  11/09/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Verifica a existencia das perguntas criando-as caso seja   º±±
±±º          ³ necessario (caso nao existam).                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ValidPerg

 _sAlias := Alias()
 aRegs := {}
i  := ""
j  := ""

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"01","DO PRODUTO","mv_ch1","C",15,00,0,"G","","mv_par01","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","ATE O PRODUTO","mv_ch2","C",15,00,0,"G","","mv_par02","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","DA DATA","mv_ch3","D",8,00,0,"G","","mv_par03","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","ATE A DATA","mv_ch4","D",8,00,0,"G","","mv_par04","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","DO ALMOXARIFADO","mv_ch5","C",2,00,0,"G","","mv_par05","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","ATE O ALMOXARIFADO","mv_ch6","C",2,00,0,"G","","mv_par06","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","CONS.PARAMET.ABAIXO?","mv_ch7","N",1,00,0,"C","","mv_par07","SIM","","","NAO","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","TIPO DE PRODUTO","mv_ch8","N",1,00,0,"C","","mv_par08","ACESSORIO","","","CARTAO","","","HANDSET NOVO","","","HANDSET USADO","","","KIT PRE-PAGO",""})
aAdd(aRegs,{cPerg,"09","SELECIONA TELES ?","mv_ch9","N",1,00,0,"C","","mv_par09","SIM","","","NAO","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"10","TELECEARA - SIM/NAO ?","mv_cha","N",1,00,0,"C","","mv_par10","SIM","","","NAO","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"11","TELPE     - SIM/NAO ?","mv_chb","N",1,00,0,"C","","mv_par11","SIM","","","NAO","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"12","TELERN    - SIM/NAO ?","mv_chc","N",1,00,0,"C","","mv_par12","SIM","","","NAO","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"13","TELASA    - SIM/NAO ?","mv_chd","N",1,00,0,"C","","mv_par13","SIM","","","NAO","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"14","TELPA     - SIM/NAO ?","mv_che","N",1,00,0,"C","","mv_par14","SIM","","","NAO","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"15","TELEPISA  - SIM/NAO ?","mv_chf","N",1,00,0,"C","","mv_par15","SIM","","","NAO","","","","","","","","","",""})

For i:=1 to Len(aRegs)
    If !dbSeek(cPerg+aRegs[i,2])
	RecLock("SX1",.T.)
	For j:=1 to FCount()
	    If j <= Len(aRegs[i])
		FieldPut(j,aRegs[i,j])
	    Endif
	Next
	MsUnlock()
    Endif
Next

dbSelectArea(_sAlias)

Return
