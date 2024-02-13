#Include "RwMake.Ch"

User Function Say(lInscricao)

lInscricao := If(lInscricao == Nil, .F., lInscricao)

DbCloseAll()

H_WebDemo()

@ 200,01 TO 400,600 DIALOG oDlg TITLE If(lInscricao, "Inscricao", "Mostra Dados na Tela")

If lInscricao
	cInscricao := Space(14)
	cEstado	  := Space(2)
	@ 006,005 Say "Inscricao" 	
	@ 006,040 Get cInscricao 	Pict "@R 999.999.999.999-!!" Size 65,10
	@ 006,090 Say "Uf"		    	
	@ 006,105 Get cEstado		Pict "!!"
Else
	dGet := Date()
	@ 006,05 Say "Say com Aspas Simples" 
	If MsgYesNo("Mostra aspas simples ?")
		@ 006,50 Say "'"
	Endif
	
	@ 030,05 Say "Data " 
	@ 030,40 Get dGet Size 60,10
Endif	

@ 70,258 BUTTON "_Ok" SIZE 40,15 ACTION Close(oDlg)

ACTIVATE DIALOG oDlg CENTERED

Return If(lInscricao, { cInscricao, cEstado }, .T.)