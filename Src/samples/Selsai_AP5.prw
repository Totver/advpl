#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 23/08/00

User Function Selsai()        // incluido pelo assistente de conversao do AP5 IDE em 23/08/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CRET,ASTRU,CARQTRAB,CARQTRAB1,ACAMPOS,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ SELSAI   ³ Autor ³Paulo Jose de Sousa       ³ Data ³ 28/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Selecao de tipos de entrada com base na tabela verdade     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Linear Equipamentos Eletronicos            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

//Este programa permite que por meio de um browse sejam selecionadas
//as entradas(SZA) que estejam associadas ao um determinado Super Grupo, Grupo
//e Sub Grupo conforme cadastro de amarracao ModeloxCod. Comercial (SZ9) e 
//conforme preenchimento dos campos CK_SUPGRP, CK_GPO e CK_SUPGRP.
//Ativado por tecla F3 no SCK (Campo:CK_ENTRADA).

cRet:={}
aStru := {}
AADD(aStru,{ "SAIDA", "C", 8, 0})
cArqTrab := CriaTrab(aStru, .T.)
FERASE("Trb.Cdx") // Caso utilize indregua isto nao e' necessario
USE &cArqTrab alias TRB new
If .F. // Com IndRegua
   IndRegua(Alias(), cArqTrab, "SAIDA",,, "Indexando registros...")
   dbSetIndex(cArqTrab+OrdBgExt())
Else
   INDEX ON SAIDA TO TRB
   DbsetIndex("Trb")
Endif

DBSELECTAREA("SZ9")
DBSETORDER(1)
DBSEEK(xFilial("SZ9") + TRIM(TMP1->CK_CODCOM))
	
WHILE Z9_MODELO == TMP1->CK_CODCOM .And. ! Eof()
	RECLOCK("TRB",.T.)
	TRB->SAIDA := SZ9->Z9_SAIDA
	DBUNLOCK()
	DBSELECTAREA("SZ9")
	dbskip(1)
ENDDO

aStru := {}
AADD(aStru,{ "SAIDA", "C", 8, 0})
AADD(aStru,{ "DESCRICAO", "C", 30, 0})
cArqTrab1 := CriaTrab(aStru, .T.)
USE &cArqTrab1 alias TRB1 new

DBSELECTAREA("TRB")
DBSETORDER(1)
DBGOTOP()

WHILE !EOF()
	IF DBSEEK(SZB->ZB_CODIGO)
		DbSelectArea("TRB1")
		RECLOCK("TRB1",.T.)
		TRB1->SAIDA	     := SZB->ZB_CODIGO
		TRB1->DESCRICAO := SZB->ZB_DESC
		DbSelectArea("SZB")
		DBUNLOCK()
	ENDIF
ENDDO

aCampos := {}
	
AADD(aCampos,{"SAIDA","Saida"})
AADD(aCampos,{"DESCRICAO","Descricao"})
DBSELECTAREA("TRB1")
DBGOTOP()
      
@ 1,1 TO 200,300 DIALOG oDlg2 TITLE "Modelos"
@ 6,5 TO 95,120 BROWSE "TRB1" FIELDS aCampos 
@ 6,120 BMPBUTTON TYPE 01 ACTION CLOSE(oDlg2)

ACTIVATE DIALOG oDlg2 CENTERED

cRet := TRB1->SAIDA

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
