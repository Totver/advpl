#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

User Function COMP023_MVC() 
Local oBrowse

oBrowse := FWmBrowse():New() 
oBrowse:SetAlias( 'ZA3' ) 
oBrowse:SetDescription( 'Musicas' ) 
oBrowse:Activate() 

Return NIL


//-------------------------------------------------------------------
Static Function MenuDef() 
Local aRotina := {} 

ADD OPTION aRotina Title 'Pesquisar'  Action 'PesqBrw'             OPERATION 1 ACCESS 0
ADD OPTION aRotina Title 'Visualizar' Action 'VIEWDEF.COMP023_MVC' OPERATION 2 ACCESS 0
ADD OPTION aRotina Title 'Incluir'    Action 'VIEWDEF.COMP023_MVC' OPERATION 3 ACCESS 0
ADD OPTION aRotina Title 'Alterar'    Action 'VIEWDEF.COMP023_MVC' OPERATION 4 ACCESS 0
ADD OPTION aRotina Title 'Excluir'    Action 'VIEWDEF.COMP023_MVC' OPERATION 5 ACCESS 0
ADD OPTION aRotina Title 'Imprimir'   Action 'VIEWDEF.COMP023_MVC' OPERATION 8 ACCESS 0

Return aRotina


//-------------------------------------------------------------------
Static Function ModelDef() 
Local oStruZA3 := FWFormStruct( 1, 'ZA3', /*bAvalCampo*/, /*lViewUsado*/ ) 
Local oStruZA4 := FWFormStruct( 1, 'ZA4', /*bAvalCampo*/, /*lViewUsado*/ ) 
Local oStruZA5 := FWFormStruct( 1, 'ZA5', /*bAvalCampo*/, /*lViewUsado*/ ) 
Local oModel

oStruZA4:RemoveField( 'ZA4_ALBUM' )
oStruZA5:RemoveField( 'ZA5_ALBUM' )
oStruZA5:RemoveField( 'ZA5_MUSICA' )

oModel := MPFormModel():New( 'COMP023MODEL', /*bPreValidacao*/, /*bPosValidacao*/, /*bCommit*/, /*bCancel*/ ) 

oModel:AddFields( 'ZA3MASTER', /*cOwner*/, oStruZA3 ) 
oModel:AddGrid( 'ZA4DETAIL', 'ZA3MASTER', oStruZA4, /*bLinePre*/, /*bLinePost*/, /*bPreVal*/, /*bPosVal*/, /*BLoad*/ ) 
oModel:AddGrid( 'ZA5DETAIL', 'ZA4DETAIL', oStruZA5, /*bLinePre*/, /*bLinePost*/, /*bPreVal*/, /*bPosVal*/, /*BLoad*/ ) 

oModel:SetRelation( 'ZA4DETAIL', { { 'ZA4_FILIAL', 'xFilial( "ZA4" ) ' }, { 'ZA4_ALBUM' , 'ZA3_ALBUM'  } } , 'ZA4_MUSICA'  ) 
oModel:SetRelation( 'ZA5DETAIL', { { 'ZA5_FILIAL', 'xFilial( "ZA5" ) ' }, { 'ZA5_ALBUM' , 'ZA3_ALBUM'  }, { 'ZA5_MUSICA', 'ZA4_MUSICA' } } , 'ZA5_INTER'  ) 

oModel:GetModel( 'ZA4DETAIL' ):SetUniqueLine( { 'ZA4_MUSICA' } ) 
oModel:GetModel( 'ZA5DETAIL' ):SetUniqueLine( { 'ZA5_INTER'  } ) 

oModel:SetDescription( 'Modelo de Albuns' ) 

oModel:GetModel( 'ZA3MASTER' ):SetDescription( 'Dados do Album' ) 
oModel:GetModel( 'ZA4DETAIL' ):SetDescription( 'Dados das Musicas do Album'  ) 
oModel:GetModel( 'ZA5DETAIL' ):SetDescription( 'Interpretes das Musicas do Album'  ) 

//oModel:GetModel( 'ZA5DETAIL' ):SetNoDeleteLine()
//oModel:GetModel( 'ZA5DETAIL' ):SetNoInsertLine()
//oModel:GetModel( 'ZA5DETAIL' ):SetNoUpdateLine()

//oModel:AddRules( 'ZA3MASTER', 'ZA3_DATA', 'ZA3MASTER', 'ZA3_DESCRI', 1 )

Return oModel


//-------------------------------------------------------------------
Static Function ViewDef() 
Local oStruZA3 := FWFormStruct( 2, 'ZA3' ) 
Local oStruZA4 := FWFormStruct( 2, 'ZA4' ) 
Local oStruZA5 := FWFormStruct( 2, 'ZA5' ) 
Local oModel   := FWLoadModel( 'COMP023_MVC' ) 
Local oView

oStruZA4:RemoveField( 'ZA4_ALBUM' )
oStruZA5:RemoveField( 'ZA5_ALBUM' )
oStruZA5:RemoveField( 'ZA5_MUSICA' )

oView := FWFormView():New() 

oView:SetModel( oModel ) 

oView:AddField( 'VIEW_ZA3', oStruZA3, 'ZA3MASTER' ) 
oView:AddGrid(  'VIEW_ZA4', oStruZA4, 'ZA4DETAIL' ) 
oView:AddGrid(  'VIEW_ZA5', oStruZA5, 'ZA5DETAIL' ) 

oView:CreateHorizontalBox( 'EMCIMA' , 15 ) 
oView:CreateHorizontalBox( 'MEIO'   , 40 ) 
oView:CreateHorizontalBox( 'EMBAIXO', 45 ) 

oView:SetOwnerView( 'VIEW_ZA3', 'EMCIMA'   ) 
oView:SetOwnerView( 'VIEW_ZA4', 'MEIO'     ) 
oView:SetOwnerView( 'VIEW_ZA5', 'EMBAIXO'  ) 

Return oView


