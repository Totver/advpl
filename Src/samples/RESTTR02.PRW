#include "rwmake.ch"        

User Function RESTTR02()        
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �RESTTR02  � Autor �Paulo Cesar            � Data � 25.07.00 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Itens do Termo de Responsabilidade                          ���
���          �                                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/                   
SetPrvt("aRotina,cCadastro,cPerg")

aRotina   := {{ "Pesquisar" , "AxPesqui" , 0 , 1 },;
              { "Visualizar", "AxVisual" , 0 , 2 },;
              { "Incluir   ", "AxInclui" , 0 , 3 },;
              { "Alterar   ", "AxAltera" , 0 , 4 },;
              { "Excluir   ", "AxDeleta" , 0 , 5 } }         

PRIVATE cCadastro := OemToAnsi("Itens do Termo de Responsabilidade")

cPerg := "TERMOR" 
Pergunte(cPerg,.T.)

dbSelectArea("SZI")
dbSetOrder(1)
mBrowse( 005, 005,093,180,"SZI",,"ZI_DTCHEG")

Return
