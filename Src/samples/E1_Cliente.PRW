#Include "RwMake.Ch"
                   
User Function E1_Cliente

Local aArea

DbSelectArea("Sa1")

aArea := GetArea()
DbSetOrder(5)
DbSeek(xFilial() + M->E1_MAT)

M->E1_CLIENTE := SA1->A1_COD
M->E1_LOJA	   := SA1->A1_LOJA
M->E1_NOMCLI  := SA1->A1_NREDUZ

RestArea(aArea)

Return .T.