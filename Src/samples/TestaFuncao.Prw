#Include "RwMake.Ch"

User Function Funcao

DbSelectArea("Sa1")
DbGoTop()
Alert(FunName())

ChamaFuncao(1, 2, 3, 4, 5)

Dbseek(xFilial("SA1") + "7")

@ 200,1 TO 400,600 DIALOG oDlg7 TITLE "Mostra Dados na Tela"

@ 006,05 Say "Cliente " 
@ 006,13 Say "Nome do Cliente com Aspas Simples - '"

@ 70,258 BUTTON "_Ok" SIZE 40,15 ACTION Close(oDlg7)
ACTIVATE DIALOG oDlg7 CENTERED
      
Return .T.

Static Function ChamaFuncao(nPar1, nPar2, nPar3, nPar4, nPar5) 

Alert("Chama Funcao")

Return .T.

User Function Valor

Return 50