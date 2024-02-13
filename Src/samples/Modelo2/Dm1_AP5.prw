#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 27/06/00
#IFNDEF WINDOWS
   #DEFINE PSAY SAY
#ENDIF

User Function Dm1()        // incluido pelo assistente de conversao do AP5 IDE em 27/06/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("AROTINA,CARQF3,CCAMPOF3,XCONTEUDO,CSAVCUR6,CSAVROW6")
SetPrvt("CSAVCOL6,CSAVCOR6,CSAVSCR6,CSAVSCR61,CCADASTRO,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa:#³ CACRDM      ³ Respons vel: ³ Ricardo Cavalini              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao:³ Contagem Cega == MENU                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 27/06/00 ==>    #DEFINE PSAY SAY
#ENDIF

aRotina   := { {"Pesquisa","AxPesqui"		 , 0 , 1},;
                { "Inclui" ,'EXECBLOCK("DM11")', 0 , 3} }
//          { "Visual"  ,'EXECBLOCK("DMV11")', 0 , 2},;
//          { "Altera"  ,'EXECBLOCK("DMA11")', 0 , 4, 20 },;
//          { "Exclui"  ,'EXECBLOCK("DME11")', 0 , 5, 21 }}

cConsulta := "1"
cProduto  := "1" + Space(14)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqF3   := "SZ0"
cCampoF3 := "Z0_MAQ"
xConteudo:= "" 
// SetKey( 114, {|a,b,c,d,e| ConPadF3(a,b,c,cArqF3,cCampoF3)} )
cSavCur6 :=""
cSavRow6 :=""
cSavCol6 :=""
cSavCor6 :="" 
cSavScr6 :=""
cSavScr61:=""
CCADASTRO:="SZ0"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salva a Integridade dos dados de Entrada                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSavCur6 := SetCursor(0)
//cSavRow6 := ROW()
//cSavCol6 := COL()
cSavCor6 := SetColor("bg+/b,,,")
//cSavScr6 := SaveScreen(3,0,24,79)
SetColor("b/w,,,")

dbSelectArea("SZ0")
dbSetOrder(1)  

mBrowse( 6, 1,22,76,"SZ0",,"Z0_MAQ")

dbSelectArea("SZ0")
dbSetOrder(1)  

Return
