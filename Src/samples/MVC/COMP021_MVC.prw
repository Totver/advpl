#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

Static aRotina := {}   

User Function COMP021_MVC()
Private oBrowse
Private oStruZA1
Private oStruZA2
Private oModel 
Private oStruVZA1
Private oStruVZA2
Private oModel
Private oView

oBrowse := FWmBrowse():New()
//oBrowse:EXECUTE("VIEWDEF.COMP011_MVC",              3,             0,"AUTOR" )
oBrowse:SetAlias( 'ZA1' )
oBrowse:SetDescription( 'Musicas' )
oBrowse:Activate()

Return NIL


//-------------------------------------------------------------------
Static Function MenuDef()


ADD OPTION aRotina Title 'Pesquisar'  Action 'PesqBrw'             OPERATION 1 ACCESS 0
ADD OPTION aRotina Title 'Visualizar' Action 'VIEWDEF.COMP021_MVC' OPERATION 2 ACCESS 0
ADD OPTION aRotina Title 'Incluir'    Action 'VIEWDEF.COMP021_MVC' OPERATION 3 ACCESS 0
ADD OPTION aRotina Title 'Alterar'    Action 'VIEWDEF.COMP021_MVC' OPERATION 4 ACCESS 0
ADD OPTION aRotina Title 'Excluir'    Action 'VIEWDEF.COMP021_MVC' OPERATION 5 ACCESS 0
ADD OPTION aRotina Title 'Imprimir'   Action 'VIEWDEF.COMP021_MVC' OPERATION 8 ACCESS 0
ADD OPTION aRotina TITLE 'Autor'      ACTION 'VIEWDEF.COMP011_MVC' OPERATION 3 ACCESS 0

Return aRotina


//-------------------------------------------------------------------
Static Function ModelDef()

oStruZA1 := FWFormStruct( 1, 'ZA1', /*bAvalCampo*/, /*lViewUsado*/ )
oStruZA2 := FWFormStruct( 1, 'ZA2', /*bAvalCampo*/, /*lViewUsado*/ )

oModel := MPFormModel():New( 'COMP021MODEL', /*bPreValidacao*/, /*bPosValidacao*/, /*bCommit*/, /*bCancel*/ )
//oModel := MPFormModel():New( 'COMP021M', /*bPreValidacao*/, { | oMdl | COMP021POS( oMdl ) } , /*bCommit*/, /*bCancel*/ )

oModel:AddFields( 'ZA1MASTER', /*cOwner*/, oStruZA1 )

oModel:AddGrid( 'ZA2DETAIL', 'ZA1MASTER', oStruZA2, /*bLinePre*/, /*bLinePost*/,{ | oMdlG | COMP021LPOS( oMdlG ) } /*bPreVal*/,{ | oMdlG | COMP021LPOS( oMdlG ) } /*bPosVal*/, /*BLoad*/ )
//oModel:AddGrid( 'ZA2DETAIL', 'ZA1MASTER', oStruZA2, /*bLinePre*/,  { | oMdlG | COMP021LPOS( oMdlG ) } , /*bPreVal*/, /*bPosVal*/ )

oModel:SetRelation( 'ZA2DETAIL', { { 'ZA2_FILIAL', 'xFilial( "ZA2" ) ' } , { 'ZA2_MUSICA', 'ZA1_MUSICA' } } , 'ZA2_FILIAL + ZA2_MUSICA' )

oModel:GetModel( 'ZA2DETAIL' ):SetUniqueLine( { 'ZA2_AUTOR' } )

oModel:SetDescription( 'Modelo de Musicas' )

oModel:GetModel( 'ZA1MASTER' ):SetDescription( 'Dados da Musica' )
oModel:GetModel( 'ZA2DETAIL' ):SetDescription( 'Dados do Autor'  )

Return oModel


//-------------------------------------------------------------------
Static Function ViewDef()
oModel   := FWLoadModel( 'COMP021_MVC' ) 

oStruVZA1 := FWFormStruct( 2, 'ZA1' )
oStruVZA2 := FWFormStruct( 2, 'ZA2' )

oView := FWFormView():New()

oView:SetModel( oModel )

oView:AddField( 'VIEW_ZA1', oStruVZA1, 'ZA1MASTER' )

oView:AddGrid(  'VIEW_ZA2', oStruVZA2, 'ZA2DETAIL' )

oView:CreateHorizontalBox( 'SUPERIOR', 15 )
oView:CreateHorizontalBox( 'INFERIOR', 85 )

oView:SetOwnerView( 'VIEW_ZA1', 'SUPERIOR' )
oView:SetOwnerView( 'VIEW_ZA2', 'INFERIOR' )

oView:AddIncrementField( 'VIEW_ZA2', 'ZA2_ITEM' )

oView:AddUserButton( 'Botao', 'CLIPS', {| oView | COMP021BUT() } )

Alert("1")
Return oView


//-------------------------------------------------------------------
Static Function COMP021LPOS( oModelGrid )
Local lRet       := .T.
Local oModel     := oModelGrid:GetModel( 'ZA2DETAIL' )
Local nOperation := oModel:GetOperation()

If nOperation == 3 .OR. nOperation == 4
	
	If Mod( Val( FwFldGet( 'ZA2_AUTOR' )  ) , 2 )  <> 0
		Help( ,, 'Help',, 'So sao permitidos codigos pares', 1, 0 )
		lRet := .F.
	EndIf
	
EndIf

Return lRet


//-------------------------------------------------------------------
Static Function COMP021POS( oModel )
Local lRet       := .T.
Local aArea      := GetArea()
Local aAreaZA0   := ZA0->( GetArea() )
Local nOperation := oModel:GetOperation()
Local oModelZA2  := oModel:GetModel( 'ZA2DETAIL' )
Local nI         := 0
Local lAchou     := .F.

ZA0->( dbSetOrder( 1 ) )

If nOperation == 3 .OR. nOperation == 4
	
	For nI := 1 To Len( oModelZA2:aCols )
		
		oModelZA2:GoLine( nI )
		
		If !oModelZA2:IsDeleted()
			If ZA0->( dbSeek( xFilial( 'ZA0' ) + FwFldGet( 'ZA2_AUTOR' ) ) ) .AND. ZA0->ZA0_TIPO == 'I'
				lAchou := .T.
				Exit
			EndIf
		EndIf
		
	Next nI
	
	If !lAchou
		Help( ,, 'Help',, 'Deve haver pelo menos 1 interprete', 1, 0 )
		lRet := .F.
	EndIf
	
EndIf

RestArea( aAreaZA0 )
RestArea( aArea )

Return lRet


//-------------------------------------------------------------------
Static Function COMP021BUT()
Local lOk        := .F.
Local oModel     := FWModelActive()
Local nOperation := oModel:GetOperation()
Local aArea      := GetArea()
Local aAreaZA0   := ZA0->( GetArea() )

//FWExecView( /*cTitulo*/, /*cFonteModel*/, /*nAcao*/, /*bOk*/ )

If     nOperation == 3 // Inclusao
	FWExecView('Inclusao por FWExecView','COMP011_MVC', nOperation, , { || lOk := .T., lOk } )
	
ElseIf nOperation == 4
	
	ZA0->( dbSetOrder( 1 ) )
	If ZA0->( dbSeek( xFilial( 'ZA0' ) + FwFldGet( 'ZA2_AUTOR' ) ) )
		FWExecView('Alteracao por FWExecView','COMP011_MVC', nOperation, , { || lOk := .T., lOk } )
	EndIf
Else
	
EndIf

If lOk
	Alert( 'Foi confirmada a inclusao do Autor' )
EndIf

RestArea( aAreaZA0 )
RestArea( aArea )

Return lOk


