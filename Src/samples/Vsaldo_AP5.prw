#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 29/08/00
        
User Function Vsaldo        // incluido pelo assistente de conversao do AP5 IDE em 29/08/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("TROCA,P_ACOLS,P_AHEADER,CCADASTRO,AROTINA,A")
SetPrvt("AHEADER,ACOLS,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³  VSALDO  º Autor ³ Rusevel M. Andrade Jr  º Data ³ 30/09/99º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³EXECBLOCK DO L2_PRODUTO                                     º±±
±±º          ³Verifica estneg do produto na venda balcao                  º±±
±±º          ³e monta tela de consulta de produtos.                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º USO      ³ Espec¡fico                      RA - ProTean  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

DbSelectArea("SB1")
DbSetOrder(3)

TROCA:=.F.

P_aCols   := aRotina
P_aHeader := aHeader

cCadastro:="Consulta Produtos"
//aRotina:={{"Pesquisar","AxPesqui",0,1}}
aRotina:={{"Pesquisar",'EXECBLOCK("PESQPRO")',0,1}}
A:={{"Codigo do Produto","B1_COD"},{"Descricao","B1_DESC"},{"Preco Unitario","B1_PRV1"},{"UM","B1_UM"}}
MBROWSE( 6, 1, 22, 75, "SB1",A)

DbSetOrder(1)

aRotina := P_aCols
aHeader := P_aHeader


ACOLS[N][4]:=SB1->B1_PRV1
ACOLS[N][5]:=SB1->B1_PRV1
ACOLS[N][16]:=SB1->B1_PRV1

// Substituido pelo assistente de conversao do AP5 IDE em 29/08/00 ==> __Return(ALLTRIM(SB1->B1_COD))
Return(SB1->B1_COD)        // incluido pelo assistente de conversao do AP5 IDE em 29/08/00






User Function Pesqpro()        // incluido pelo assistente de conversao do AP5 IDE em 26/08/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("P_DESCP,ACOLS,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PESQPRO  º Autor ³ Rusevel M. Andrade Jr  º Data ³ 11/10/99º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³EXECBLOCK DO VSALDO._IW E DO TROCA._IW                      º±±
±±º          ³Faz a pesquisa de produto pela descrisao no MBrowse da      º±±
±±º          ³consulta de produtos na Venda Balcao.                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º USO      ³ Espec¡fico                                   RA - ProTean  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

p_descp:=Space(40)
@ 001,001 TO 70,500 DIALOG oDlg TITLE "Digite a Descricao do Produto"
@ 10,13 get p_descp picture "@!"
@ 10,100 BMPBUTTON TYPE 01 ACTION Close(oDlg)
ACTIVATE DIALOG oDlg CENTERED

DbSelectArea("SB1")
DbSetOrder(3)
DBSEEK(xFilial("SB1")+p_descp,.T.)

IF TROCA==.F.
   ACOLS[N][4]:=SB1->B1_PRV1
   ACOLS[N][5]:=SB1->B1_PRV1
   ACOLS[N][16]:=SB1->B1_PRV1
ENDIF

// Substituido pelo assistente de conversao do AP5 IDE em 26/08/00 ==> __RETURN()
Return()        // incluido pelo assistente de conversao do AP5 IDE em 26/08/00

