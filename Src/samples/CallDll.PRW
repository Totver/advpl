#Include "RwMake.Ch"

User Function CallDll

Local cDll := "CarregaDll.Dll", aInscricao

Static hDll

hDll := ExecInDllOpen(cDll)
    			         	 
If hDll = -1
   MsgAlert("Nao foi possivel abrir " + cDll + ".")
Else	
	aInscricao := U_Say(.T.)                
	If ValType(nRet := (ExecInDLLRun(hDll, 1, aInscricao[1] + "," + aInscricao[2]))) = "C"
		nRet := Val(nRet)
	   If nRet = 0
	       Alert('Inscri��o v�lida')
   	ElseIf nRet = 1
	       Alert('Inscri��o inv�lida')
		Else
	       Alert('Par�metros inv�lidos')
		Endif
	Endif		
	ExecInDLLRun(hDll, 2, "")
   ExecInDllClose(hDll)
Endif

Return .T.