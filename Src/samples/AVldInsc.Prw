#Include "RwMake.Ch"

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北砇otina    � A020VlInsc � Autor 砏alter Caetano da Silva		   � Data �22/02/2001潮�
北媚哪哪哪哪呐哪哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri嚻o � Faz validacao da inscricao  estadual  carregando  DllInscE32.Dll  da 潮�
北�          � Secretaria da fazenda, porem para carga da dll foi desenvolvida  dll 潮�
北�          � CarregaDll em Delphi que faz referencia a dll acima        				潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砄bservacao� Utilizado na validacao de usuario do campo A2_INSCR e A2_EST     	   潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌
/*/

User Function A020VlInsc

Local nDll, cDll := "CarregaDll.Dll", aInscricao, lRetorno := .T.

If ! Empty(M->A2_INSCR) .And. ! Empty(M->A2_EST) // Somente valido caso inscricao e 
							  									   // estado estejam Preenchidos
	hDll := ExecInDllOpen(cDll)
    			         	 
	If hDll = -1
	   MsgAlert("Nao foi possivel abrir " + cDll + ".")
	Else	
		If ValType(nRet := (ExecInDLLRun(hDll, 1, M->A2_INSCR + "," + M->A2_EST))) = "C"
			nRet := Val(nRet)
	   	If nRet = 1
	   		lRetorno := .F.
	         Alert('Inscri玢o inv醠ida')
			Endif
		Endif		
	   ExecInDllClose(hDll)
	Endif
Endif	

Return lRetorno

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北砇otina    � A030VlInsc � Autor 砏alter Caetano da Silva		   � Data �22/02/2001潮�
北媚哪哪哪哪呐哪哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri嚻o � Faz validacao da inscricao  estadual  carregando  DllInscE32.Dll  da 潮�
北�          � Secretaria da fazenda, porem para carga da dll foi desenvolvida  dll 潮�
北�          � CarregaDll em Delphi que faz referencia a dll acima        				潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砄bservacao� Utilizado na validacao de usuario do campo A1_INSCR e A1_EST     	   潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌
/*/

User Function A030VlInsc

Local nDll, cDll := "CarregaDll.Dll", aInscricao, lRetorno := .T.

If ! Empty(M->A1_INSCR) .And. ! Empty(M->A1_EST) // Somente valido caso inscricao e 
													   		   // estado estejam Preenchidos
	hDll := ExecInDllOpen(cDll)
    			         	 
	If hDll = -1
	   MsgAlert("Nao foi possivel abrir " + cDll + ".")
	Else	
		If ValType(nRet := (ExecInDLLRun(hDll, 1, M->A1_INSCR + "," + M->A1_EST))) = "C"
			nRet := Val(nRet)
	   	If nRet = 1
	   		lRetorno := .F.
	         Alert('Inscricao invalida')
			Endif
		Endif		
	   ExecInDllClose(hDll)
	Endif
Endif	

Return lRetorno