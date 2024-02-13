#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/07/00
#IFNDEF WINDOWS
  #DEFINE PSAY SAY 
#ENDIF
              
User Function RFATE11()        // incluido pelo assistente de conversao do AP5 IDE em 13/07/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("MCOR,CDIRET,CFILE1,CFILE2")
SetPrvt("CSIGLA,CSIGLAC,CDIRETC,CFILE_C,CARQ")
SetPrvt("CINDEX,REGD3,MTM,CARQB1,CARQW9,TAMANHO")
SetPrvt("TITULO,CDESC1,CDESC2,CDESC3,LCONTINUA,LFIRST,wnrel")
SetPrvt("CPEDANT,ACAMPOS,ARETURN,NOMEPROG,NLASTKEY,NBEGIN,_cChave")
SetPrvt("ALINHA,LI,LIMITE,LRODAPE,NTOTQTD,NTOTVAL")
SetPrvt("NTOTFITAS,CBTXT,CBCONT,M_PAG,CTRAB,CALIAS1")
SetPrvt("CKEY,CCABEC,CABEC1,CABEC2,NTOTNF,CNUMINI")
SetPrvt("DDATAINI,CNUMFIM,DDATAFIM,ANOTAS,_RELATO,NCOL")
SetPrvt("NVEZES,I,MARJ,_cArqrel,_cArqcop,_cRelatorio")

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ RFATE11 ³ Autor ³                          ³ Data ³ 10/06/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Fazer atualizacao dos dados da COLUMBIA                      ³±±
±±³          ³ Envio dos dados da PRODUTORA COLUMBIA para a  VIDEOLAR-SAO   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico -  RFATE11.PRW                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Arquivos  ³SB2 - SB9 - SC5 - SC6 - SC9 - SD2 - SD3 - SE1 - SE3 - SF2 -SF5³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


Pergunte("COMR01")
@ 96,42 TO 323,505 DIALOG oDlg5 TITLE  "Comunicacao de Dados da VIDEOLAR (SP)"
@ 8,10 TO 84,222
@ 23,14 SAY "Este programa faz a comunicacao de dados (Faturamento/Estoque) da                                       "
@ 33,14 Say "PRODUTORA COLUMBIA para a VIDEOLAR gerando somente registros                                            "
@ 43,14 Say "necessarios de acordo com os parametros definidos.                                                      "
   
@ 53,14 SAY "Nao esqueca de informar os parametros necessarios para a sua geracao.                                   "
@ 91,139 BMPBUTTON TYPE 5 ACTION Pergunte("COMR01") 
@ 91,168 BMPBUTTON TYPE 1 ACTION OkProc()
@ 91,196 BMPBUTTON TYPE 2 ACTION Close(oDlg5)

ACTIVATE DIALOG oDlg5

Return(nil)

*--------------*
Static Function OkProc
*--------------*
Close(oDlg5)
Processa({| |FATM11P()},"Aguarde... Atualizando os Dados ",,.T.)
Return .T.


Static Function FATM11P()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ MV_PAR01             // Do Periodo                           ³
//³ MV_PAR02             // Ate a Periodo                        ³
//³ MV_PAR03             // Sequencia                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//

// Rotina para Verificar a Sequencia dos arquivos (A,B,C,D,E, etc..)
cDiret   := "\SIGAADV\"
cFile1   := "SD2"+STRZERO(DAY(dDataBase),2)+STRZERO(MONTH(dDataBase),2)

cSigla   :=STRZERO(DAY(DDATABASE),2)+STRZERO(MONTH(DDATABASE),2)+".DBF"
cSiglac  :=STRZERO(DAY(DDATABASE),2)+STRZERO(MONTH(DDATABASE),2)

cDiretc  := "\SIGAADV\X\ENVIO\"
cFile_c  := "FAT"+cSiglac+".ARJ"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tratamento para o Arq. SD2 - Itens Nota Fiscal Saída
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

mv_par01 := Ctod("01/01/2000")
mv_par02 := Ctod("31/12/2000")

dbSelectArea("SD2")
IncProc("Processando SD2"+SM0->M0_CODIGO+"0")
cArq:=CriaTrab(Nil,.F.)
Copy Stru to (cDiret+"SD2"+cSigla)
dbUseArea(.T.,,cDiret+"SD2"+cSigla,"D2M",.T.,.F.)
 
dbSelectArea("SD2")
dbSetOrder(5)
dbSeek(xFilial("SD2")+DTOS(MV_PAR01),.T.)
While !Eof() .And. D2_EMISSAO >= MV_PAR01 .And. D2_EMISSAO <= MV_PAR02

   IncProc()

   Copy To &cArq Next 1
   dbSelectArea("D2M")
   Append From &cArq
   
   dbSelectArea("SD2")
Enddo

dbSelectArea("D2M")
dbCloseArea("D2M")

dbSelectArea("SD2")

Return .T.
