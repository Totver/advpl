#include "totvs.ch"
#include "fileio.ch"

User Function JobCosmo()
Local nRet
Local nI
Local sRet
Local nX		:= 0
Local cPasta    := ""
Local aArquivos	:= {}
Local nX		:= 1

Private oFTPHandle

	MyOpenSM0()

	If isblind()
		cPasta := "\COSMOS\RECEBIDOS\"
	Else
		cPasta := cGetFile( '*.csv' , 'Arquivos (CSV)', 1, "C:\COSMOS\RECEBIDOS\", .T.,;
 					nOR( GETF_LOCALHARD, GETF_LOCALFLOPPY, GETF_RETDIRECTORY ),.T., .T. )
	Endif
 
	If Empty(cPasta)
		Alert ("Cancelado pelo usuário.")
		Return
	Endif

	aArquivos := Directory(cPasta + "*.csv")

	If Len(aArquivos) == 0
		Alert("Não foram encontrados arquivos.")
		Return
	Endif

	If .T.
		StartJob( "U_IMPORTA" , GetEnvServer(), .T., cPasta, aArquivos )
	Else
		MsgRun("Aguarde, importando arquivo.","Importação",{|x,y| Importa(cPasta, aArquivos) })
	EndIf
  
Return

User Function Importa(cPasta, aArquivos)

Importa(cPasta, aArquivos)

Return

Static Function Importa(cPasta, aArquivos)
Local nX := 0
Local nY := 0 
Local aDados := {}
Local cArq := ""
Local lOk  := .F.

    ErrorBlock( { |oErro|  GravaLog( , oErro, cArq )  } )
    
    Begin Sequence
	
	For nY := 1 To Len(aArquivos)
	   cArq := cPasta + aArquivos[nY][1]
	   aDados := Arq2Arr(cArq)
	  
	   For nX := 2 To Len(aDados)
	   		RecLock("SZ7",.T.)
	   		SZ7->Z7_FILIAL		:= xFilial("SZ7")
	   		SZ7->Z7_OBJTYPE		:= aDados[nX][3] 
	   		SZ7->Z7_OBJID		:= aDados[nX][4]	   		
	   		SZ7->Z7_OBJNUM 		:= aDados[nX][5]	
	   		SZ7->Z7_ACTION 		:= aDados[nX][8]
	   		SZ7->Z7_DUEDATE		:= CTOD(aDados[nX][12])
	   		SZ7->Z7_LOCBANK		:= aDados[nX][15]
	   		SZ7->Z7_PRDID  		:= aDados[nX][23]
	   		SZ7->Z7_PARTID 		:= aDados[nX][25]
	   		SZ7->Z7_PARTNAM		:= aDados[nX][26]
	   		SZ7->Z7_PRODNAM		:= aDados[nX][24]
	   		SZ7->Z7_BENNAME		:= aDados[nX][27]
	   			   		
	   		If AllTrim(aDados[nX][34])=="CLAIMS REIMBURSEMENT"  //05/11/2018 Alterado por Washington Miranda Leao(Se For fornecedor igual a "CLAIMS REIMBURSEMENT"
	   		   SZ7->Z7_TPPID  	:= aDados[nX][35]     // Pega a posiçao 35 do arquivo .CSV TPP ID
	   		   SZ7->Z7_TPPNAME 	:= aDados[nX][37]    //  Pega a posição 37 do arquivo .CSV TPP name
	   		Else                                    //   Se o Fornecedor for diferente de "CLAIMS REIMBURSEMENT"
	   		    SZ7->Z7_SUPID  	:= aDados[nX][33]  //    Pega a posição 33 do arquivo .CSV Supplier ID
	   		    SZ7->Z7_SUPNAM 	:= aDados[nX][34] //     Pega a posição 34 do arquivo .CSV Supplier name
	   		Endif
	   		SZ7->Z7_FORAMNT		:= Val(aDados[nX][49])
	   		SZ7->Z7_FORCUR 		:= aDados[nX][50]
	   		SZ7->(MsUnlock())
	   Next nX
	   __copyfile(cArq, StrTran(cArq, "RECEBIDOS\", "SUCESSO\"))
	   fErase(cArq)
	Next nY

    End Sequence

    
Return

Static Function Arq2Arr (cArq)
Local cAux	  := ""
Local aAux	  := {}
Local aRet	  := {}
Local nHandle := FT_FUSE( cArq )

// Se houver erro de abertura abandona processamento
if nHandle = -1
    GravaLog("Erro ao abrir o arquivo [" + cArq + "]", Nil, cArq)
    return {}
endif

// Posiciona na primeria linha
FT_FGOTOP()

While !FT_FEOF()

	cAux := FT_FREADLN()
	aAux := Separa(cAux, ";")
	aAdd(aRet, aAux)
	FT_FSKIP()
End

FT_FUSE()

RETURN aRet

Static Function GravaLog(cLog,  oErro, cArq)

Local cFileLog := StrTran(UPPER(cArq), ".CSV", "_" + Dtos(Date()) + "_" + StrTran(Time(), ":", "") + ".LOG")

DEFAULT cLog  := oErro:ERRORSTACK

   __copyfile(cArq, StrTran(cArq, "RECEBIDOS\", "ERROS\"))
    cFileLog := StrTran(cFileLog, "RECEBIDOS\", "ERROS\")
    nHandle := FCreate(cFileLog)

    FWrite(nHandle,cLog)
    FClose(nHandle)
    
    FT_FUSE()
	fErase(cArq)
	
    If oErro <> Nil
       BREAK( @oErro )
	EndIf   
    
Return

Static Function MyOpenSM0()

Local aParam := {}
Private cCadastro := "Job de leitura de CSV"

If Select("SM0") > 0
	Return
EndIf

	Set Dele On
	dbUseArea( .T., , 'SIGAMAT.EMP', 'SM0', .T., .F. )
	dbSetIndex( 'SIGAMAT.IND' )
	DbGoTop()

	RpcSetType( 3 )
	RpcSetEnv( SM0->M0_CODIGO, SM0->M0_CODFIL )

	If LastRec() > 1 .And. ! IsBlind()
		Aadd(aParam, {1, "Empresa", Space(2), "@!"	, "", "SM0", "", 002, .F.})
		
		IF ! ParamBox(aParam, "Parametros da rotina",, {|| AllwaysTrue()},,,,,,, .F.)
			Return .F.
		Endif
		SM0->(DbSeek(mv_par01))
		cOEmp := SM0->M0_CODIGO
		cOFil := SM0->M0_CODFIL
		RpcClearEnv()
		RpcSetEnv( cOEmp, cOFil )
	EndIf
	
Return