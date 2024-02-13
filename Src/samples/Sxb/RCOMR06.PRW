#include "rwmake.ch"

User Function Rcomr06()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CDESC1,CDESC2,CDESC3,CSTRING,LEND,TITULO")
SetPrvt("ARETURN,NOMEPROG,ALINHA,NLASTKEY,CPERG,TAMALHO")
SetPrvt("WNREL,NTIPO,NCONTADOR,NTOTG,CARQ,CFILTRO")
SetPrvt("CARQ1,LI,CCHAVE,NVALOR,CABEC1,CABEC2")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    #DEFINE PSAY SAY
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cDesc1 :="Este programa tem a fun‡„o de emitir os borderos de pagamen-"
cDesc2 :="tos."
cDesc3 :=""
cString:="SEA"
lEnd   := .F. 

titulo   := "Emiss„o de Borderos de Pagamentos"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "RFINR06"
aLinha   := { }
nLastKey := 0
cPerg    := "FIN710"
tamalho  := "P"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("FIN710",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros                        ³
//³ mv_par01                            // Do Bordero           ³
//³ mv_par02                            // At‚ o Bordero        ³
//³ mv_par03                            // Data para d‚bito     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia a data para debito com a data base do sistema         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SX1")
If dbSeek ("FIN710"+"03")  // Busca a pergunta para mv_par03
   Reclock("SX1",.F.)
   Replace X1_CNT01 With "'"+dtoc(dDataBase)+"'"
   MsUnlock()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "RFINR06"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
   Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

#IFDEF WINDOWS
   RptStatus({|| Fa710Imp()})// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    RptStatus({|| Execute(Fa710Imp)})
   Return
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    Function Fa710Imp
Static Function Fa710Imp()
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para Impress„o do Cabe‡alho e Rodap‚    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nTipo     := aReturn[4]
nContador := 0
nTotG     := 0

dbSelectArea("SEA")
cARQ    := CriaTrab("",.F.)
cFiltro := "EA_NUMBOR >= mv_par01 .and. EA_NUMBOR <= mv_par02 "
IndRegua("SEA",cArq,"EA_NUMBOR+EA_FORNECE+EA_LOJA+EA_NOMINAL",cFiltro,,"Selecionando Registros...")

dbSelectArea("SE2")
cARQ1   := CriaTrab("",.F.)
cFiltro := "E2_NUMBOR >= mv_par01 .and. E2_NUMBOR <= mv_par02 "
IndRegua("SE2",cArq1,"E2_NUMBOR+E2_FORNECE+E2_LOJA+E2_CODNOMI",cFiltro,,"Selecionando Registros...")

SetRegua(RecCount())

li := 3
@ li,30 PSAY "CASA DAS COECAS LTDA"
li := li + 4
@ li,0 PSAY "Ao"
li := li + 2
@ li,0 PSAY "BANCO SAFRA S/A"
li := li + 6

If Alltrim(SEA->EA_MODELO) == "03"
   @   li,00 PSAY "ref-docNA C/C  "   + SEA->EA_NUMCON
Else
   @   li,00 PSAY "ref-deb-NA C/C  "  + SEA->EA_NUMCON
Endif

li := li + 4

Cabeca()

DbSelectArea("SEA")
//DbSeek(xFilial("SEA")+mv_par01,.T.)

While !Eof()   //.And. EA_NUMBOR >= mv_par01 .And. EA_NUMBOR <= mv_par02
      IncRegua()
      cChave := SEA->EA_NUMBOR+SEA->EA_FORNECE+SEA->EA_LOJA+SEA->EA_NOMINAL
      DbSelectArea("SE2")
      nValor := 0
      Dbseek(cChave)
      While !Eof() .And. SE2->E2_NUMBOR+SE2->E2_FORNECE+SE2->E2_LOJA+SE2->E2_CODNOMI == cChave
            @ li,00 PSAY SE2->E2_FORNECE
            @ li,10 PSAY SE2->E2_NOMINAL
            @ li,50 PSAY SE2->E2_NUM
            @ li,77 PSAY Transform(SE2->E2_VALOR,"@E 999,999.99")
            li := li + 1
            nValor := nValor + SE2->E2_VALOR
            If Alltrim(SEA->EA_MODELO) == "03"
               If !Empty(SE2->E2_CODNOMI)
                  SZ1->(DbSeek(xFilial()+SE2->E2_FORNECE+SE2->E2_LOJA+SE2->E2_CODNOMI))
               Else
                  SA2->(DbSeek(xFilial()+SE2->E2_FORNECE+SE2->E2_LOJA+SE2->E2_CODNOMI))
               Endif
            Endif
            DbSkip()
            IF li > 60
               eject
               @ li,30 PSAY "CASA DAS COECAS LTDA"
               li := li + 1
               cabeca()
            EndIF
      End-While
      nTotG := nTotG + nValor
      DbSelectArea("SEA")
      DbSkip()
      SubTot()
End-While
TotGeral()
Set Device To Screen
dbSelectArea("SE2")
RetIndex("SE1")
dbSetOrder(1)
dbSelectArea("SED")
RetIndex("SED")
dbSetOrder(1)

If aReturn[5] == 1
   Set Printer TO
   dbCommitAll()
   Ourspool(wnrel)
Endif
MS_FLUSH()
Return 
/**************************************************************************/
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function Cabeca
Static Function Cabeca()

Cabec1   :=  "Fornecedor                                      Doc.Num                Valor  "
Cabec2   :=  "============================================    =========              ================="
li := 17
@ li,00 PSAY Cabec1
li := li + 1
@ li,00 PSAY Cabec2
li := li + 1
Return(nil)

/*************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function SubTot
Static Function SubTot()

@ li,00 PSAY REPLICATE("-",70)
@ li,77 PSAY Transform(nvalor,"@E 999,999.99")
li := li + 1
If Alltrim(SEA->EA_MODELO) == "03"
   IF !EMPTY(SE2->E2_CODNOMI)
      @ li,00 PSAY "Banco: " + SZ1->Z1_BCO + "Agencia: " + SZ1->Z1_AGENCIA + "Conta: " + SZ1->Z1_CONTA
   Else
      @ li,00 PSAY "Banco: " + SA2->A2_BANCO + "Agencia: " + SA2->A2_AGENCIA + "Conta: " + SA2->A2_NUMCON
   Endif
Else
   @ li,00 PSAY " "
Endif
li := li +1
@ li,00 PSAY REPLICATE("-",80)
li := li + 1

Return(nil)
/***************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> function TotGeral
Static function TotGeral()

IF li > 60
   eject
   @ li,30 PSAY "CASA DAS CUECAS LTDA"
   li := li + 1
   cabeca()
EndIF

@ li,00 PSAY REPLICATE("-",80)
li := li + 5
@ li,00 PSAY REPLICATE("-",80)
li := li + 1
@ li,00 PSAY "Valor Total em Moeda Corrente a Pagar -> " + Transform(nTotG,"@E 99,999,999.99")
@ li,00 PSAY "Valor Total em Moeda Corrente a Pagar -> " + Transform(nTotG,"@E 99,999,999.99")
li := li + 1
@ li,00 PSAY REPLICATE("-",80)
Return(nil)

