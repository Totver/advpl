#include "Rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 16/11/00

User Function C_placa        // incluido pelo assistente de conversao do AP5 IDE em 16/11/00

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CPEDIDO,CTRANSP,CPLACA,CVOLUME,CESPECI,CCOND")

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    � C_PLACA  � Autor � Antonio Sercheli Jr.  � Data � 10.08.00 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o � RDMAKE para alterar Transportadora e Placa do Pedido       낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/

cPedido := SPACE(06)
cTransp := SPACE(04)
cPlaca  := SPACE(08)
cVolume := 0
cEspeci := SPACE(10)
cCond   := "S"

@ 200,1 TO 400,450 DIALOG oDlg TITLE "              Alteracao da Transportadora e Placa do Veiculo"
@ 05,02 TO 100,224
@ 15,05 SAY "Pedido"
@ 25,05 SAY "Transportadora"
@ 35,05 SAY "Placa"
@ 45,05 SAY "Volume"
@ 55,05 SAY "Especie"

@ 15,60 GET cPedido   VALID EXISTCPO("SC5") Object oGT
@ 25,60 GET cTransp   VALID EXISTCPO("SA4") F3 "SA4"
@ 35,60 GET cPlaca    PICTURE "@!"                  
@ 45,60 GET cVolume   PICTURE "99999" 
@ 55,60 GET cEspeci   PICTURE "@!"  

@ 080,070 BMPBUTTON TYPE 1 ACTION Grava() // Substituido pelo assistente de conversao do AP5 IDE em 16/11/00 ==> @ 080,100 BMPBUTTON TYPE 1 ACTION Execute(Grava) 
@ 080,110 BMPBUTTON TYPE 2 ACTION Close (oDlg)
ACTIVATE DIALOG oDlg CENTERED

Return             // incluido pelo assistente de conversao do AP5 IDE em 16/11/00

// Substituido pelo assistente de conversao do AP5 IDE em 16/11/00 ==> Function Grava
Static Function Grava

dbSelectArea("SC5")
dbSetOrder(1)
dbSeek(xfilial()+cPedido)

         Reclock("SC5",.f.)
         SC5->C5_TRANSP         := CTRANSP
         SC5->C5_VOLUME1        := CVOLUME
         SC5->C5_ESPECI1        := CESPECI
         MsUnlock()

dbSelectArea("SA4")
dbSetOrder(1)
dbSeek(xfilial()+CTRANSP)

         Reclock("SA4",.f.)
         SA4->A4_PLACA          := CPLACA
         MsUnlock()

cPedido := SPACE(06)

ObjectMethod(oGT,"SetFocus()")

Return