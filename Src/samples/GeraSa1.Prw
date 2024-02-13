#Include "RwMake.Ch"
#Include "TopConn.Ch"

User Function GeraSA1

DbSelectArea("SA1")

cArquivo := "Arquivo"
If lQuery := (MsgYesNo("Utiliza Query ?"))
	TCQUERY "SELECT * FROM " + RetSqlname("SA1") NEW ALIAS "TMP"
Endif
Copy To &cArquivo

Use (cArquivo) NEW ALIAS "TMPSA1"

@ 200,1 TO 400,600 DIALOG oDlg7 TITLE "Consulta SA1"

@ 6,5 TO 93,250 BROWSE "TMPSA1" FIELDS { { "A1_COD"   , "Codigo" },;
                                          { "A1_NREDUZ", "Fantasia" } }
                     
@ 70,258 BUTTON "_Ok" SIZE 40,15 ACTION Close(oDlg7)
ACTIVATE DIALOG oDlg7 CENTERED

If lQuery
	DbSelectArea("TMP")
	DbCloseArea()
Endif	

DbSelectArea("TMPSA1")
DbCloseArea()

Return .T.