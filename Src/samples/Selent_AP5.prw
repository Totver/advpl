#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 23/08/00

User Function Selent()        // incluido pelo assistente de conversao do AP5 IDE em 23/08/00

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//�����������������������������������������������������������������������

SetPrvt("CRET,ASTRU,CARQTRAB,CARQTRAB1,ACAMPOS,")

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � SELENT   � Autor �Judson Rezende Goulart � Data � 28/06/00 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Selecao de tipos de entrada com base na tabela verdade     ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico para Linear Equipamentos Eletronicos            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

//Este programa permite que por meio de um browse sejam selecionadas
//as entradas(SZA) que estejam associadas ao um determinado Super Grupo, Grupo
//e Sub Grupo conforme cadastro de amarracao ModeloxCod. Comercial (SZ9) e 
//conforme preenchimento dos campos CK_SUPGRP, CK_GPO e CK_SUPGRP.
//Ativado por tecla F3 no SCK (Campo:CK_ENTRADA).

cRet:={}
aStru := {}
AADD(aStru,{ "ENTRADA", "C", 8, 0})
cArqTrab := CriaTrab(aStru, .T.)
FERASE("Trb.Cdx") // Caso utilize indregua isto nao e' necessario
USE &cArqTrab alias TRB new
If .F. // Com IndRegua
   IndRegua(Alias(), cArqTrab, "ENTRADA",,, "Indexando registros...")
   dbSetIndex(cArqTrab+OrdBgExt())
Else
   INDEX ON ENTRADA TO TRB
   DbsetIndex("Trb")
Endif

DBSELECTAREA("SZ9")
DBSEEK(xFilial("SZ9") + TMP1->CK_CODCOM)
	
WHILE Z9_MODELO = TMP1->CK_CODCOM .And. ! Eof()
	RECLOCK("TRB",.T.)
	TRB->ENTRADA := SZ9->Z9_ENTRADA
	DBUNLOCK()
	DBSELECTAREA("SZ9")
	dbskip(1)
ENDDO

aStru := {}
AADD(aStru,{ "ENTRADA", "C", 8, 0})
AADD(aStru,{ "DESCRICAO", "C", 30, 0})
cArqTrab1 := CriaTrab(aStru, .T.)
USE &cArqTrab1 alias TRB1 new

DBSELECTAREA("TRB")
DBSETORDER(1)
DBGOTOP()

WHILE !EOF()
	IF DBSEEK(SZA->ZA_CODIGO)
		DbSelectArea("TRB1")
		RECLOCK("TRB1",.T.)
		TRB1->ENTRADA   := SZA->ZA_CODIGO
		TRB1->DESCRICAO := SZA->ZA_DESC
		MsUnLock()
		DbSelectArea("SZA")
	ENDIF
ENDDO

aCampos := {}
	
AADD(aCampos,{"ENTRADA","Entrada"})
AADD(aCampos,{"DESCRICAO","Descricao"})
DBSELECTAREA("TRB1")
DBGOTOP()
      
@ 1,1 TO 200,300 DIALOG oDlg2 TITLE "Modelos"
@ 6,5 TO 95,120 BROWSE "TRB1" FIELDS aCampos 
@ 6,120 BMPBUTTON TYPE 01 ACTION CLOSE(oDlg2)

ACTIVATE DIALOG oDlg2 CENTERED

cRet := TRB1->ENTRADA

dbselectarea("TRB1") 
close TRB1
cArqTrab1:=cArqTrab1+".dbf"
FERASE(cArqTrab1)

dbselectarea("TRB") 
close TRB
cArqTrab:=cArqTrab+".dbf"
FERASE(cArqTrab)
FERASE("Trb.Cdx") // Caso utilize indregua isto nao e' necessario

Return cRet
