#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'


//-------------------------------------------------------------------
User Function COMP011M()  
Return Verifica()

//-------------------------------------------------------------------
User Function COMP021M()
Return Verifica()    

//-------------------------------------------------------------------
User Function COMP022M()  
Return Verifica()

//-------------------------------------------------------------------
User Function COMP023M()  
Return Verifica()

/*
MODELPRE - Antes da altera��o de qualquer campo do modelo. (requer retorno l�gico)
MODELPOS - Na valida��o total do modelo (requer retorno l�gico)

FORMPRE - Antes da altera��o de qualquer campo do formul�rio. (requer retorno l�gico)
FORMPOS - Na valida��o total do formul�rio (requer retorno l�gico)

FORMLINEPRE - Antes da altera��o da linha do formul�rio GRID. (requer retorno l�gico)
FORMLINEPOS - Na valida��o total da linha do formul�rio GRID. (requer retorno l�gico)

MODELCOMMITTTS - Apos a grava��o total do modelo e dentro da transa��o
MODELCOMMITNTTS - Apos a grava��o total do modelo e fora da transa��o

FORMCOMMITTTSPRE - Antes da grava��o da tabela do formul�rio
FORMCOMMITTTSPOS - Apos a grava��o da tabela do formul�rio

FORMCANCEL - No cancelamento do bot�o.

Parametros passados para os pontos de entrada:
PARAMIXB[1] - objeto do formul�rio ou model, conforme o caso.
PARAMIXB[2] - Id do local de execu��o do ponto de entrada
PARAMIXB[3] - Id do formul�rio

Se for uma FORMGRID
PARAMIXB[4] - Linha da Grid
PARAMIXB[5] - Acao da Grid

*/




//-------------------------------------------------------------------
Static Function Verifica()
Local aParam     := PARAMIXB
Local xRet       := .T.
Local oObj       := aParam[1]
Local cIdPonto   := aParam[2]
Local cIdModel   := oObj:GetId()
Local cClasse    := oObj:ClassName()

Local nLinha     := 0
Local nQtdLinhas := 0
Local cMsg       := ''

If cClasse == 'FWFORMGRID'
	nQtdLinhas := oObj:GetQtdLine()
	nLinha     := oObj:nLine
EndIf

If     cIdPonto ==  'MODELPOS'
	cMsg := 'Chamada na valida��o total do modelo.' + CRLF
	cMsg += 'ID '  + cIdModel + CRLF
	
	xRet := ApMsgYesNo( cMsg + 'Continua ?' )
	
	//ElseIf cIdPonto ==  'MODELPRE'
	
	//ElseIf cIdPonto ==  'FORMPRE'
	
ElseIf cIdPonto ==  'FORMPOS'
	cMsg := 'Chamada na valida��o total do formul�rio.' + CRLF
	cMsg += 'ID '  + cIdModel + CRLF
	
	If      cClasse == 'FWFORMGRID'
		cMsg += '� um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) + ' linha(s).' + CRLF
		cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha     ) ) + CRLF
	ElseIf cClasse == 'FWFORMFIELD'
		cMsg += '� um FORMFIELD' + CRLF
	EndIf
	
	xRet := ApMsgYesNo( cMsg + 'Continua ?' )
	
ElseIf cIdPonto ==  'FORMLINEPRE'     
	If aParam[5] == 'DELETE'
		cMsg := 'Chamada na pre valida��o da linha do formul�rio. ' + CRLF
		cMsg += 'Onde esta se tentando deletar a linha' + CRLF
		cMsg += 'ID '  + cIdModel + CRLF
		cMsg += '� um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) + ' linha(s).' + CRLF
		cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha     ) ) + CRLF
		xRet := ApMsgYesNo( cMsg + 'Continua ?' )
	EndIf
	
ElseIf cIdPonto ==  'FORMLINEPOS'
	cMsg := 'Chamada na valida��o da linha do formul�rio.' + CRLF
	cMsg += 'ID '  + cIdModel + CRLF
	cMsg += '� um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) + ' linha(s).' + CRLF
	cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha     ) ) + CRLF
	xRet := ApMsgYesNo( cMsg + 'Continua ?' )
	
ElseIf cIdPonto ==  'MODELCOMMITTTS'
	ApMsgInfo('Chamada apos a grava��o total do modelo e dentro da transa��o.')
	
ElseIf cIdPonto ==  'MODELCOMMITNTTS'
	ApMsgInfo('Chamada apos a grava��o total do modelo e fora da transa��o.')
	
	//ElseIf cIdPonto ==  'FORMCOMMITTTSPRE'
	
ElseIf cIdPonto ==  'FORMCOMMITTTSPOS'
	ApMsgInfo('Chamada apos a grava��o da tabela do formul�rio.')
	
ElseIf cIdPonto ==  'MODELCANCEL'
	cMsg := 'Deseja Realmente Sair ?'
	xRet := ApMsgYesNo( cMsg )
	
EndIf

Return xRet

