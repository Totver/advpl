#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 29/08/00
        
User Function Vsaldo        // incluido pelo assistente de conversao do AP5 IDE em 29/08/00

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("TROCA,P_ACOLS,P_AHEADER,CCADASTRO,AROTINA,A")
SetPrvt("AHEADER,ACOLS,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴敲굇
굇튡rograma  �  VSALDO  � Autor � Rusevel M. Andrade Jr  � Data � 30/09/99볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴묽�
굇튒escri뇙o 쿐XECBLOCK DO L2_PRODUTO                                     볍�
굇�          쿣erifica estneg do produto na venda balcao                  볍�
굇�          쿮 monta tela de consulta de produtos.                       볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇� USO      � Espec죉ico                      RA - ProTean  볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
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

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("P_DESCP,ACOLS,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴敲굇
굇튡rograma  � PESQPRO  � Autor � Rusevel M. Andrade Jr  � Data � 11/10/99볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴묽�
굇튒escri뇙o 쿐XECBLOCK DO VSALDO._IW E DO TROCA._IW                      볍�
굇�          쿑az a pesquisa de produto pela descrisao no MBrowse da      볍�
굇�          쿬onsulta de produtos na Venda Balcao.                       볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇� USO      � Espec죉ico                                   RA - ProTean  볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
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

