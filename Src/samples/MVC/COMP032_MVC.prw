#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

//-------------------------------------------------------------------
User Function COMP032_MVC()
Local   aSay     := {}
Local   aButton  := {}
Local   nOpc     := 0
Local   Titulo   := 'IMPORTACAO DE MUSICAS'
Local   cDesc1   := 'Esta rotina fara a importacao de musicas'
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
Local lRet     := .T.
Local aCposCab := {}
Local aCposDet := {}
Local aAux     := {}

aCposCab := {}
aCposDet := {}
aAdd( aCposCab, { 'ZA1_TITULO' , 'LA, LA, LA,' } )
aAdd( aCposCab, { 'ZA1_DATA', Date() } )

aAux := {}
aAdd( aAux, { 'ZA2_ITEM' , '01'             } )
aAdd( aAux, { 'ZA2_AUTOR', '000100'         } )
aAdd( aCposDet, aAux )

aAux := {}
aAdd( aAux, { 'ZA2_ITEM' , '02'             } )
aAdd( aAux, { 'ZA2_AUTOR', '000104'         } )
aAdd( aCposDet, aAux )

If !Import( 'ZA1', 'ZA2', aCposCab, aCposDet )
	lRet := .F.
EndIf



aCposCab := {}
aCposDet := {}
aAdd( aCposCab, { 'ZA1_TITULO' , 'BLA, BLA, BLA' } )
aAdd( aCposCab, { 'ZA1_DATA', Date() } )

aAux := {}
aAdd( aAux, { 'ZA2_ITEM' , '01'             } )
aAdd( aAux, { 'ZA2_AUTOR', '000102'         } )
aAdd( aCposDet, aAux )

aAux := {}
aAdd( aAux, { 'ZA2_ITEM' , '02'             } )
aAdd( aAux, { 'ZA2_AUTOR', '000104'         } )
aAdd( aCposDet, aAux )

If !Import( 'ZA1', 'ZA2', aCposCab, aCposDet )
	lRet := .F.
EndIf



aCposCab := {}
aCposDet := {}
aAdd( aCposCab, { 'ZA1_TITULO' , 'ZAP, ZAP, ZAP' } )
aAdd( aCposCab, { 'ZA1_DATA', Date() } )

aAux := {}
aAdd( aAux, { 'ZA2_ITEM' , '01'             } )
aAdd( aAux, { 'ZA2_AUTOR', '000100'         } )
aAdd( aCposDet, aAux )

aAux := {}
aAdd( aAux, { 'ZA2_ITEM' , '02'             } )
aAdd( aAux, { 'ZA2_AUTOR', '000102'         } )
aAdd( aCposDet, aAux )

If !Import( 'ZA1', 'ZA2', aCposCab, aCposDet )
	lRet := .F.
EndIf




Return lRet


//-------------------------------------------------------------------
Static Function Import(  cMaster, cDetail, aCpoMaster, aCpoDetail )
Local  oModel, oAux, oStruct
Local  nI        := 0
Local  nJ        := 0
Local  nPos      := 0
Local  lRet      := .T.
Local  aAux	     := {}
Local  aC  	     := {}
Local  aH        := {}
Local  nItErro   := 0
Local  lAux      := .T.

dbSelectArea( cDetail )
dbSetOrder( 1 )

dbSelectArea( cMaster )
dbSetOrder( 1 )

oModel := FWLoadModel( 'COMP021_MVC' )

oModel:SetOperation( 3 )
oModel:Activate()

oAux    := oModel:GetModel( cMaster + 'MASTER' )
oStruct := oAux:GetStruct()
aAux	:= oStruct:GetFields()

If lRet
	For nI := 1 To Len( aCpoMaster )
		If ( nPos := aScan( aAux, { |x| AllTrim( x[3] ) ==  AllTrim( aCpoMaster[nI][1] ) } ) ) > 0
			If !( lAux := oModel:SetValue( cMaster + 'MASTER', aCpoMaster[nI][1], aCpoMaster[nI][2] ) )
				lRet    := .F.
				Exit
			EndIf
		EndIf
	Next
EndIf


If lRet
	oAux     := oModel:GetModel( cDetail + 'DETAIL' )
	oStruct  := oAux:GetStruct()
	aAux	 := oStruct:GetFields()
	nItErro  := 0
	
	For nI := 1 To Len( aCpoDetail )
		If nI > 1
			If  ( nItErro := oAux:AddLine() ) <> nI
				lRet    := .F.
				Exit
			EndIf
		EndIf
		
		For nJ := 1 To Len( aCpoDetail[nI] )
			If ( nPos := aScan( aAux, { |x| AllTrim( x[3] ) ==  AllTrim( aCpoDetail[nI][nJ][1] ) } ) ) > 0
				If !( lAux := oModel:SetValue( cDetail + 'DETAIL', aCpoDetail[nI][nJ][1], aCpoDetail[nI][nJ][2] ) )
					lRet    := .F.
					nItErro := nI
					Exit
				EndIf
			EndIf
		Next
		
		If !lRet
			Exit
		EndIf
		
	Next
	
EndIf

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
	
	If nItErro > 0
		AutoGrLog( "Erro no Item:              " + ' [' + AllTrim( AllToChar( nItErro  ) ) + ']' )
	EndIf
	
	MostraErro()
	
EndIf

oModel:DeActivate()

Return lRet
