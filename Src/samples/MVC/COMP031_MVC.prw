#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

//-------------------------------------------------------------------
User Function COMP031_MVC()
Local   aSay     := {}
Local   aButton  := {}
Local   nOpc     := 0
Local   Titulo   := 'IMPORTACAO DE COMPOSITORES'
Local   cDesc1   := 'Esta rotina fara a importacao de compositores/interpretes'
Local   cDesc2   := 'conforme layout.'
Local   cDesc3   := ''
Local   lOk      := .T.

aAdd( aSay, cDesc1 )
aAdd( aSay, cDesc2 )
aAdd( aSay, cDesc3 )

aAdd( aButton, { 1, .T., { || nOpc := 1, FechaBatch() } } )
aAdd( aButton, { 2, .T., { || FechaBatch()            } } )

FormBatch( Titulo, aSay, aButton )

If nOpc == 1
	
	Processa( { || lOk := Runproc() },'Aguarde','Processando...',.F.)
	
	If lOk
		ApMsgInfo( 'Processamento terminado com sucesso.', 'ATENÇÃO' )
		
	Else
		ApMsgStop( 'Processamento realizado com problemas.', 'ATENÇÃO' )
		
	EndIf
	
EndIf

Return NIL


//-------------------------------------------------------------------
Static Function Runproc()
Local lRet    := .T.
Local aCampos := {}


aCampos := {}
aAdd( aCampos, { 'ZA0_CODIGO', '000100'    } )
aAdd( aCampos, { 'ZA0_NOME' , 'Vila Lobos' } )
aAdd( aCampos, { 'ZA0_NOTAS', 'Observacoes...' } )
aAdd( aCampos, { 'ZA0_TIPO' , 'C' } )

If !Import( 'ZA0', aCampos )
	lRet := .F.
EndIf



aCampos := {}
aAdd( aCampos, { 'ZA0_CODIGO', '000102'    } )
aAdd( aCampos, { 'ZA0_NOME'  , 'Tom Jobim' } )
aAdd( aCampos, { 'ZA0_NOTAS' , 'Observacoes...' } )
aAdd( aCampos, { 'ZA0_TIPO'  , 'C' } )

If !Import( 'ZA0', aCampos )
	lRet := .F.
EndIf



aCampos := {}
aAdd( aCampos, { 'ZA0_CODIGO', '000104'    } )
aAdd( aCampos, { 'ZA0_NOME' , 'Emilio Santiago' } )
aAdd( aCampos, { 'ZA0_NOTAS', 'Observacoes...' } )
aAdd( aCampos, { 'ZA0_TIPO' , 'I' } )

If !Import( 'ZA0', aCampos )
	lRet := .F.
EndIf



aCampos := {}
aAdd( aCampos, { 'ZA0_NOME' , 'Maria Rita'      } )
aAdd( aCampos, { 'ZA0_NOTAS', 'Observacoes...' } )
aAdd( aCampos, { 'ZA0_TIPO' , 'I' } )

If !Import( 'ZA0', aCampos )
	lRet := .F.
EndIf



aCampos := {}
aAdd( aCampos, { 'ZA0_NOME' , 'Zizi Possi' } )
aAdd( aCampos, { 'ZA0_NOTAS', 'Observacoes...' } )
aAdd( aCampos, { 'ZA0_TIPO' , 'I' } )

If !Import( 'ZA0', aCampos )
	lRet := .F.
EndIf



aCampos := {}
aAdd( aCampos, { 'ZA0_NOME' , 'Forca Erro' } )
aAdd( aCampos, { 'ZA0_NOTAS', 'Observacoes...' } )
aAdd( aCampos, { 'ZA0_TIPO' , 'X' } )

If !Import( 'ZA0', aCampos )
	lRet := .F.
EndIf

Return lRet


//-------------------------------------------------------------------
Static Function Import( cAlias, aCampos )
Local  oModel, oAux, oStruct
Local  nI        := 0
Local  nPos      := 0
Local  lRet      := .T.
Local  aAux	     := {}

dbSelectArea( cAlias )
dbSetOrder( 1 )

oModel := FWLoadModel( 'COMP011_MVC' )
oModel:SetOperation( 3 )
oModel:Activate()

oAux    := oModel:GetModel( cAlias + 'MASTER' )
oStruct := oAux:GetStruct()
aAux	:= oStruct:GetFields()

For nI := 1 To Len( aCampos )
	If ( nPos := aScan( aAux, { |x| AllTrim( x[3] ) ==  AllTrim( aCampos[nI][1] ) } ) ) > 0
		If !( lAux := oModel:SetValue( cAlias + 'MASTER', aCampos[nI][1], aCampos[nI][2] ) )
			lRet    := .F.
			Exit
		EndIf
	EndIf
Next

If lRet
	If ( lRet := oModel:VldData() )
		oModel:CommitData()
	EndIf
EndIf

If !lRet
	aErro   := oModel:GetErrorMessage()
	
	//[1] Id do formulário de origem
	//[2] Id do campo de origem
	//[3] Id do formulário de erro
	//[4] Id do campo de erro
	//[5] Id do erro
	//[6] mensagem do erro
	//[7] mensagem da solução
	//[8] Valor atribuido
	//[9] Valor anterior
	
	AutoGrLog( "Id do formulário de origem:" + ' [' + AllToChar( aErro[1]  ) + ']' )
	AutoGrLog( "Id do campo de origem:     " + ' [' + AllToChar( aErro[2]  ) + ']' )
	AutoGrLog( "Id do formulário de erro:  " + ' [' + AllToChar( aErro[3]  ) + ']' )
	AutoGrLog( "Id do campo de erro:       " + ' [' + AllToChar( aErro[4]  ) + ']' )
	AutoGrLog( "Id do erro:                " + ' [' + AllToChar( aErro[5]  ) + ']' )
	AutoGrLog( "Mensagem do erro:          " + ' [' + AllToChar( aErro[6]  ) + ']' )
	AutoGrLog( "Mensagem da solução:       " + ' [' + AllToChar( aErro[7]  ) + ']' )
	AutoGrLog( "Valor atribuido:           " + ' [' + AllToChar( aErro[8]  ) + ']' )
	AutoGrLog( "Valor anterior:            " + ' [' + AllToChar( aErro[9]  ) + ']' )
	MostraErro()
	
EndIf

oModel:DeActivate()

Return lRet
