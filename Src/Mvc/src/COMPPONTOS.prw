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
IDs dos Pontos de Entrada
-------------------------

MODELPRE 			Antes da altera��o de qualquer campo do modelo. (requer retorno l�gico)
MODELPOS 			Na valida��o total do modelo (requer retorno l�gico)

FORMPRE 			Antes da altera��o de qualquer campo do formul�rio. (requer retorno l�gico)
FORMPOS 			Na valida��o total do formul�rio (requer retorno l�gico)

FORMLINEPRE 		Antes da altera��o da linha do formul�rio GRID. (requer retorno l�gico)
FORMLINEPOS 		Na valida��o total da linha do formul�rio GRID. (requer retorno l�gico)

MODELCOMMITTTS 		Apos a grava��o total do modelo e dentro da transa��o
MODELCOMMITNTTS 	Apos a grava��o total do modelo e fora da transa��o

FORMCOMMITTTSPRE 	Antes da grava��o da tabela do formul�rio
FORMCOMMITTTSPOS 	Apos a grava��o da tabela do formul�rio

FORMCANCEL 			No cancelamento do bot�o.

BUTTONBAR 			Para acrescentar botoes a ControlBar

MODELVLDACTIVE 		Para validar se deve ou nao ativar o Model

Parametros passados para os pontos de entrada:
PARAMIXB[1] - Objeto do formul�rio ou model, conforme o caso.
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
	nQtdLinhas := oObj:Length()
	nLinha     := oObj:nLine
EndIf

If     cIdPonto ==  'MODELPOS'
	cMsg := 'Chamada na valida��o total do modelo (MODELPOS).' + CRLF
	cMsg += 'ID '  + cIdModel + CRLF
	
	If !( xRet := ApMsgYesNo( cMsg + 'Continua ?' ) )
		Help( ,, 'Help',, 'O MODELPOS retornou .F.', 1, 0 )
	EndIf
	
	
	//ElseIf cIdPonto ==  'MODELPRE'
	
	//ElseIf cIdPonto ==  'FORMPRE'
	
ElseIf cIdPonto ==  'FORMPOS'
	cMsg := 'Chamada na valida��o total do formul�rio (FORMPOS).' + CRLF
	cMsg += 'ID '  + cIdModel + CRLF
	
	If      cClasse == 'FWFORMGRID'
		cMsg += '� um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) + ' linha(s).' + CRLF
		cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha     ) ) + CRLF
	ElseIf cClasse == 'FWFORMFIELD'
		cMsg += '� um FORMFIELD' + CRLF
	EndIf
	
	If !( xRet := ApMsgYesNo( cMsg + 'Continua ?' ) )
		Help( ,, 'Help',, 'O FORMPOS retornou .F.', 1, 0 )
	EndIf
	
ElseIf cIdPonto ==  'FORMLINEPRE'
	If aParam[5] == 'DELETE'
		cMsg := 'Chamada na pre valida��o da linha do formul�rio (FORMLINEPRE).' + CRLF
		cMsg += 'Onde esta se tentando deletar uma linha' + CRLF
		cMsg += '� um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) + ' linha(s).' + CRLF
		cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha     ) ) + CRLF
		cMsg += 'ID '  + cIdModel + CRLF
		
		If !( xRet := ApMsgYesNo( cMsg + 'Continua ?' ) )
			Help( ,, 'Help',, 'O FORMLINEPRE retornou .F.', 1, 0 )
		EndIf
	EndIf
	
ElseIf cIdPonto ==  'FORMLINEPOS'
	cMsg := 'Chamada na valida��o da linha do formul�rio (FORMLINEPOS).' + CRLF
	cMsg += 'ID '  + cIdModel + CRLF
	cMsg += '� um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) + ' linha(s).' + CRLF
	cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha     ) ) + CRLF
	
	If !( xRet := ApMsgYesNo( cMsg + 'Continua ?' ) )
		Help( ,, 'Help',, 'O FORMLINEPOS retornou .F.', 1, 0 )
	EndIf
	
ElseIf cIdPonto ==  'MODELCOMMITTTS'
	ApMsgInfo('Chamada apos a grava��o total do modelo e dentro da transa��o (MODELCOMMITTTS).' + CRLF + 'ID '  + cIdModel )
	
ElseIf cIdPonto ==  'MODELCOMMITNTTS'
	ApMsgInfo('Chamada apos a grava��o total do modelo e fora da transa��o (MODELCOMMITNTTS).'  + CRLF + 'ID '  + cIdModel)
	
	//ElseIf cIdPonto ==  'FORMCOMMITTTSPRE'
	
ElseIf cIdPonto ==  'FORMCOMMITTTSPOS'
	ApMsgInfo('Chamada apos a grava��o da tabela do formul�rio (FORMCOMMITTTSPOS).'  + CRLF + 'ID '  + cIdModel)
	
ElseIf cIdPonto ==  'MODELCANCEL'
	cMsg := 'Chamada no Bot�o Cancelar (MODELCANCEL).' + CRLF + 'Deseja Realmente Sair ?'
	
	If !( xRet := ApMsgYesNo( cMsg ) )
		Help( ,, 'Help',, 'O MODELCANCEL retornou .F.', 1, 0 )
	EndIf
	
ElseIf cIdPonto ==  'BUTTONBAR'
	ApMsgInfo('Adicionando Botao na Barra de Botoes (BUTTONBAR).' + CRLF + 'ID '  + cIdModel )
	xRet := { {'Salvar', 'SALVAR', { || Alert( 'Salvou' ) }, 'Este botao Salva' } }
	
	
ElseIf cIdPonto ==  'MODELVLDACTIVE'
	cMsg := 'Chamada na valida��o da ativa��o do Model.' + CRLF + 'Continua ?'
	
	If !( xRet := ApMsgYesNo( cMsg ) )
		Help( ,, 'Help',, 'O MODELVLDACTIVE retornou .F.', 1, 0 )
	EndIf
	
EndIf

Return xRet