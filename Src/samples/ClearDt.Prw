#Include "RwMake.Ch"
#Include "Fw192.Ch"

USER Function ClearCpData(lAtu)
PRIVATE oMainWnd

DEFINE WINDOW oMainWnd FROM -1,-1 TO -1,-1
ACTIVATE WINDOW oMainWnd On INIT MyClrDt0(lAtu)

Return Nil

Static Function MyClrDt0(lAtu)
Local oDlg, oSay1, oSay2, __nConecta
Local cDataBase,cAlias,cServer,cConType
Local cInIfile := GetADV97()                               
Local cVar1 := "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
Local cVar2 := "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
Local cVar0 := "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

cDataBase := GetPvProfString("TopConnect","DataBase","ERROR",cInIfile )
cAlias	 := GetPvProfString("TopConnect","Alias","ERROR",cInIfile )
cServer	 := GetPvProfString("TopConnect","Server","ERROR",cInIfile )
cConType  := Upper(GetPvProfString("TopConnect","Contype","TCPIP",cInIfile ))
// Ajuste pelo Environment do Server
cDataBase := GetSrvProfString("TopDataBase",cDataBase)
cAlias	 := GetSrvProfString("TopAlias",cAlias)
cServer	 := GetSrvProfString("TopServer",cServer)
cConType  := Upper(GetSrvProfString("TopContype",cConType))
If !(AllTrim(cContype)$"TCPIP/Local/APPC/BRIDGE/NPIPE")
	MsgStop("Ajuste o Contype do .INI")
	TCQUIT()
	__QUIT()
EndIf
If "ERROR" $ cDataBase+cAlias+cServer
	MsgStop("Erro na Configura‡„o do arquivo .INI")
	TCQUIT()
	__QUIT()
EndIf

TCConType(cConType)
 
If (("AS" $ cAlias) .And. ("400" $ cAlias))
		__nConecta := TCLink(cDataBase,cServer)//,cUser,cPsw)
Else
		__nConecta := TCLink(cDataBase+"/"+cAlias,cServer)//,cUser,cPsw)
EndIf                               
IF __nConecta < 0
	MsgStop("Falha de Conexao com o TopCOnnect")
Endif
     
DEFAULT lAtu := .f.
Set Dele ON
dbCloseAll()
USE SIGAMAT.EMP ALIAS SM0 EXCLUSIVE NEW VIA"DBFCDX"
IF NetErr()
	MsgSTop("Este Programa deve ser rodado em ambiente Monousuario")
	TCQUIT()
	__QUIT()
Endif	
dbGotop()
DEFINE MSDIALOG oDlg From 0,0 TO 60,300 PIXEL
 @ 0,0 SAY oSay1 VAR cVar1 PIXEL
 @ 10,0 Say oSay0 VAR cVar0 PIXEL
 @ 20,0 SAY oSay2 VAR cVar2 PIXEL
 oDlg:bStart := {|| MyClrDt(oSay1,oSay2), oDlg:End()}	

ACTIVATE MSDIALOG oDLG Centered 
dbSelectArea("SM0")
dbCloseAll()             
IF !lAtu
	MSGSTOP("Processo Finalizado")
	TCQUIT()
	__QUIT()
Endif
Return Nil



Static Function MyClrDt(oSay1,oSay2)
Local cSX2, cFile, aStru, cQuery, nJ := 0
Private __cRdd := "TOPCONN"
dbSelectArea("SM0")

While !Eof()
	oSay1:SetText("Atualizando Empresa : "+M0_CODIGO)
	ProcessMessages()
	cSX2 := "SX2"+SM0->M0_CODIGO+"0"
	USE &cSX2 ALIAS SX2 Shared New VIA "DBFCDX"
	dbGotop()
	While !Eof()                     
		nJ++
 		oSay0:SetText("Table "+Str(nj,8,0)+"/"+Alltrim(Str(SX2->(RecCOunt()),8,0)))
	 	ProcessMessages()
		IF X2_CHAVE$"SH7/SH9"
			dbSkip()
			Loop
		Endif
		cFile := RetArq("TOPCONN",SX2->X2_ARQUIVO,.f.)
		IF MSFile(cFile)
			USE &cFile Alias TRB Shared NEW VIA "TOPCONN"
			aStru := dbStruct()
			dbCloseArea()
			For ni := 1 to Len(aStru)
			 IF aStru[ni,2] == "D"
			 	 oSay2:SetText("Table "+cFile+" Field "+Upper(aStru[ni,1]))
			 	 ProcessMessages()
			 	 cQuery := "UPDATE "+cFile+" SET "+Upper(aStru[ni,1])+" = '        ' WHERE "+Upper(aStru[ni,1])+" = '00000000'"
				 TCSqlExec(cQuery)
			 Endif
			Next
		Endif		
		dbSelectArea("SX2")
		dbSkip()
	End
	dbSelectArea("SX2")
	dbCloseArea()
	dbSelectArea("SM0")
	dbSkip()
End

Return Nil