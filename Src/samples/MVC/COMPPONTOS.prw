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
MODELPRE - Antes da alteração de qualquer campo do modelo. (requer retorno lógico)
MODELPOS - Na validação total do modelo (requer retorno lógico)

FORMPRE - Antes da alteração de qualquer campo do formulário. (requer retorno lógico)
FORMPOS - Na validação total do formulário (requer retorno lógico)

FORMLINEPRE - Antes da alteração da linha do formulário GRID. (requer retorno lógico)
FORMLINEPOS - Na validação total da linha do formulário GRID. (requer retorno lógico)

MODELCOMMITTTS - Apos a gravação total do modelo e dentro da transação
MODELCOMMITNTTS - Apos a gravação total do modelo e fora da transação

FORMCOMMITTTSPRE - Antes da gravação da tabela do formulário
FORMCOMMITTTSPOS - Apos a gravação da tabela do formulário

FORMCANCEL - No cancelamento do botão.

Parametros passados para os pontos de entrada:
PARAMIXB[1] - objeto do formulário ou model, conforme o caso.
PARAMIXB[2] - Id do local de execução do ponto de entrada
PARAMIXB[3] - Id do formulário

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
	cMsg := 'Chamada na validação total do modelo.' + CRLF
	cMsg += 'ID '  + cIdModel + CRLF
	
	xRet := ApMsgYesNo( cMsg + 'Continua ?' )
	
	//ElseIf cIdPonto ==  'MODELPRE'
	
	//ElseIf cIdPonto ==  'FORMPRE'
	
ElseIf cIdPonto ==  'FORMPOS'
	cMsg := 'Chamada na validação total do formulário.' + CRLF
	cMsg += 'ID '  + cIdModel + CRLF
	
	If      cClasse == 'FWFORMGRID'
		cMsg += 'É um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) + ' linha(s).' + CRLF
		cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha     ) ) + CRLF
	ElseIf cClasse == 'FWFORMFIELD'
		cMsg += 'É um FORMFIELD' + CRLF
	EndIf
	
	xRet := ApMsgYesNo( cMsg + 'Continua ?' )
	
ElseIf cIdPonto ==  'FORMLINEPRE'     
	If aParam[5] == 'DELETE'
		cMsg := 'Chamada na pre validação da linha do formulário. ' + CRLF
		cMsg += 'Onde esta se tentando deletar a linha' + CRLF
		cMsg += 'ID '  + cIdModel + CRLF
		cMsg += 'É um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) + ' linha(s).' + CRLF
		cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha     ) ) + CRLF
		xRet := ApMsgYesNo( cMsg + 'Continua ?' )
	EndIf
	
ElseIf cIdPonto ==  'FORMLINEPOS'
	cMsg := 'Chamada na validação da linha do formulário.' + CRLF
	cMsg += 'ID '  + cIdModel + CRLF
	cMsg += 'É um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) + ' linha(s).' + CRLF
	cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha     ) ) + CRLF
	xRet := ApMsgYesNo( cMsg + 'Continua ?' )
	
ElseIf cIdPonto ==  'MODELCOMMITTTS'
	ApMsgInfo('Chamada apos a gravação total do modelo e dentro da transação.')
	
ElseIf cIdPonto ==  'MODELCOMMITNTTS'
	ApMsgInfo('Chamada apos a gravação total do modelo e fora da transação.')
	
	//ElseIf cIdPonto ==  'FORMCOMMITTTSPRE'
	
ElseIf cIdPonto ==  'FORMCOMMITTTSPOS'
	ApMsgInfo('Chamada apos a gravação da tabela do formulário.')
	
ElseIf cIdPonto ==  'MODELCANCEL'
	cMsg := 'Deseja Realmente Sair ?'
	xRet := ApMsgYesNo( cMsg )
	
EndIf

Return xRet

