#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

//-------------------------------------------------------------------
/*/{Protheus.doc} COMP026_MVC
Exemplo de montagem da modelo e interface uma estrutura pai/filho
em MVC com a criacao de campos na estrutura diretamente no fonte
simulando marcacao

@author Ernani Forastieri e Rodrigo Antonio Godinho
@since 05/10/2009
@version P10
/*/
//-------------------------------------------------------------------
User Function COMP026_MVC()
Local oBrowse

oBrowse := FWmBrowse():New()
oBrowse:SetAlias( 'ZA1' )
oBrowse:SetDescription( 'Musicas' )
oBrowse:Activate()

Return NIL


//-----------------------------------------------------------------------------
Static Function MenuDef()
Local aRotina := {}

ADD OPTION aRotina Title 'Pesquisar'  Action 'PesqBrw'             OPERATION 1 ACCESS 0
ADD OPTION aRotina Title 'Visualizar' Action 'VIEWDEF.COMP026_MVC' OPERATION 2 ACCESS 0
ADD OPTION aRotina Title 'Incluir'    Action 'VIEWDEF.COMP026_MVC' OPERATION 3 ACCESS 0
ADD OPTION aRotina Title 'Alterar'    Action 'VIEWDEF.COMP026_MVC' OPERATION 4 ACCESS 0
ADD OPTION aRotina Title 'Excluir'    Action 'VIEWDEF.COMP026_MVC' OPERATION 5 ACCESS 0
ADD OPTION aRotina Title 'Imprimir'   Action 'VIEWDEF.COMP026_MVC' OPERATION 8 ACCESS 0
ADD OPTION aRotina Title 'Copiar'     Action 'VIEWDEF.COMP026_MVC' OPERATION 9 ACCESS 0
ADD OPTION aRotina TITLE 'Autor'      ACTION 'VIEWDEF.COMP011_MVC' OPERATION 3 ACCESS 0

Return aRotina


//-----------------------------------------------------------------------------
Static Function ModelDef()
Local oStruZA1 := FWFormStruct( 1, 'ZA1', /*bAvalCampo*/, /*lViewUsado*/ )
Local oStruZA2 := FWFormStruct( 1, 'ZA2', /*bAvalCampo*/, /*lViewUsado*/ )
Local oModel


oStruZA1:AddField( ;                      // Ord. Tipo Desc.
AllTrim( 'Exemplo 1' )           , ;      // [01]  C   Titulo do campo
AllTrim( 'Campo Exemplo 1' )     , ;      // [02]  C   ToolTip do campo
'ZA1_XEXEM1'                     , ;      // [03]  C   Id do Field
'C'                              , ;      // [04]  C   Tipo do campo
1                                , ;      // [05]  N   Tamanho do campo
0                                , ;      // [06]  N   Decimal do campo
FwBuildFeature( STRUCT_FEATURE_VALID,"Pertence('12')"), ;    // [07]  B   Code-block de valida��o do campo
NIL                              , ;      // [08]  B   Code-block de valida��o When do campo
{'1=Sim','2=Nao'}                , ;      // [09]  A   Lista de valores permitido do campo
.T.                              , ;      // [10]  L   Indica se o campo tem preenchimento obrigat�rio
FwBuildFeature( STRUCT_FEATURE_INIPAD, "'2'" )       , ;      // [11]  B   Code-block de inicializacao do campo
NIL                              , ;      // [12]  L   Indica se trata-se de um campo chave
NIL                              , ;      // [13]  L   Indica se o campo pode receber valor em uma opera��o de update.
.T.                              )        // [14]  L   Indica se o campo � virtual

oStruZA1:AddField( ;                      // Ord. Tipo Desc.
AllTrim( 'Exemplo 2' )           , ;      // [01]  C   Titulo do campo
AllTrim( 'Campo Exemplo 2' )     , ;      // [02]  C   ToolTip do campo
'ZA1_XEXEM2'                     , ;      // [03]  C   Id do Field
'C'                              , ;      // [04]  C   Tipo do campo
6                                , ;      // [05]  N   Tamanho do campo
0                                , ;      // [06]  N   Decimal do campo
FwBuildFeature( STRUCT_FEATURE_VALID,"ExistCpo('SA1', M->ZA0_XEXEM2,1)") , ;  // [07]  B   Code-block de valida��o do campo
FwBuildFeature( STRUCT_FEATURE_WHEN,"INCLUI" )                           , ;  // [08]  B   Code-block de valida��o When do campo
NIL                              , ;      // [09]  A   Lista de valores permitido do campo
NIL                              , ;      // [10]  L   Indica se o campo tem preenchimento obrigat�rio
NIL                              , ;      // [11]  B   Code-block de inicializacao do campo
NIL                              , ;      // [12]  L   Indica se trata-se de um campo chave
NIL                              , ;      // [13]  L   Indica se o campo pode receber valor em uma opera��o de update.
.T.                              )        // [14]  L   Indica se o campo � virtual

oStruZA1:AddField( ;                      // Ord. Tipo Desc.
AllTrim( 'Exemplo 3' )           , ;      // [01]  C   Titulo do campo
AllTrim( 'Campo Exemplo 3' )     , ;      // [02]  C   ToolTip do campo
'ZA1_XEXEM3'                     , ;      // [03]  C   Id do Field
'L'                              , ;      // [04]  C   Tipo do campo
1                                , ;      // [05]  N   Tamanho do campo
0                                , ;      // [06]  N   Decimal do campo
NIL                              , ;      // [07]  B   Code-block de valida��o do campo
NIL                              , ;      // [08]  B   Code-block de valida��o When do campo
NIL                              , ;      // [09]  A   Lista de valores permitido do campo
NIL                              , ;      // [10]  L   Indica se o campo tem preenchimento obrigat�rio
{ ||  .T. }                      , ;      // [11]  B   Code-block de inicializacao do campo
NIL                              , ;      // [12]  L   Indica se trata-se de um campo chave
NIL                              , ;      // [13]  L   Indica se o campo pode receber valor em uma opera��o de update.
.T.                              )        // [14]  L   Indica se o campo � virtual


oStruZA2:AddField( ;                      // Ord. Tipo Desc.
AllTrim( 'Marca' )               , ;      // [01]  C   Titulo do campo
AllTrim( 'Campo de Marcacao' )   , ;      // [02]  C   ToolTip do campo
'ZA2_XMARCA'                     , ;      // [03]  C   Id do Field
'L'                              , ;      // [04]  C   Tipo do campo
1                                , ;      // [05]  N   Tamanho do campo
0                                , ;      // [06]  N   Decimal do campo
NIL                              , ;      // [07]  B   Code-block de valida��o do campo
NIL                              , ;      // [08]  B   Code-block de valida��o When do campo
NIL                              , ;      // [09]  A   Lista de valores permitido do campo
NIL                              , ;      // [10]  L   Indica se o campo tem preenchimento obrigat�rio
FwBuildFeature( STRUCT_FEATURE_INIPAD,'.T.' )         , ;      // [11]  B   Code-block de inicializacao do campo
NIL                              , ;      // [12]  L   Indica se trata-se de um campo chave
NIL                              , ;      // [13]  L   Indica se o campo pode receber valor em uma opera��o de update.
.T.                              )        // [14]  L   Indica se o campo � virtual

 
oModel := MPFormModel():New( 'COMP026M', /*bPreValidacao*/, { | oMdl | COMP026POS( oMdl ) } , /*bCommit*/, /*bCancel*/ )

oModel:AddFields( 'ZA1MASTER', /*cOwner*/, oStruZA1 )
oModel:AddGrid( 'ZA2DETAIL', 'ZA1MASTER', oStruZA2, /*bLinePre*/, /*bLinePos*/, /*bPreVal*/, /*bPosVal*/ )
oModel:AddGrid( 'ZA2DETAIL', 'ZA1MASTER', oStruZA2, /*bLinePre*/,  { | oMdlG | COMP026LPOS( oMdlG ) } , /*bPreVal*/, /*bPosVal*/ )

oModel:SetRelation( 'ZA2DETAIL', { { 'ZA2_FILIAL', 'xFilial( "ZA2" )' }, { 'ZA2_MUSICA', 'ZA1_MUSICA' } }, ZA2->( IndexKey( 1 ) ) )

oModel:GetModel( 'ZA2DETAIL' ):SetUniqueLine( { 'ZA2_AUTOR' } )

oModel:SetDescription( 'Modelo de Musicas' )

oModel:GetModel( 'ZA1MASTER' ):SetDescription( 'Dados da Musica' )
oModel:GetModel( 'ZA2DETAIL' ):SetDescription( 'Dados do Autor Da Musica'  )

Return oModel


//-----------------------------------------------------------------------------
Static Function ViewDef()
Local oStruZA1 := FWFormStruct( 2, 'ZA1' )
Local oStruZA2 := FWFormStruct( 2, 'ZA2' )
Local oModel   := FWLoadModel( 'COMP026_MVC' )
Local oView
Local cOrdem   := aTail( oStruZA1:aFields )[2]

cOrder := Soma1( cOrdem )
oStruZA1:AddField( ;                        // Ord. Tipo Desc.
'ZA1_XEXEM1'                       , ;      // [01]  C   Nome do Campo
cOrder                             , ;      // [02]  C   Ordem
AllTrim( 'Exemplo 1'    )          , ;      // [03]  C   Titulo do campo
AllTrim( 'Campo Exemplo 1' )       , ;      // [04]  C   Descricao do campo
{ 'Exemplo de Campo de Manual 1' } , ;      // [05]  A   Array com Help
'C'                                , ;      // [06]  C   Tipo do campo
'@!'                               , ;      // [07]  C   Picture
NIL                                , ;      // [08]  B   Bloco de Picture Var
''                                 , ;      // [09]  C   Consulta F3
.T.                                , ;      // [10]  L   Indica se o campo � alteravel
NIL                                , ;      // [11]  C   Pasta do campo
NIL                                , ;      // [12]  C   Agrupamento do campo
{'1=Sim','2=Nao'}                  , ;      // [13]  A   Lista de valores permitido do campo (Combo)
NIL                                , ;      // [14]  N   Tamanho maximo da maior op��o do combo
NIL                                , ;      // [15]  C   Inicializador de Browse
.T.                                , ;      // [16]  L   Indica se o campo � virtual
NIL                                , ;      // [17]  C   Picture Variavel
NIL                                )        // [18]  L   Indica pulo de linha ap�s o campo


oStruZA1:AddField( ;                        // Ord. Tipo Desc.
'ZA1_XEXEM2'                       , ;      // [01]  C   Nome do Campo
cOrder                             , ;      // [02]  C   Ordem
AllTrim( 'Exemplo 2'    )          , ;      // [03]  C   Titulo do campo
AllTrim( 'Campo Exemplo 2' )       , ;      // [04]  C   Descricao do campo
{ 'Exemplo de Campo de Manual 2' } , ;      // [05]  A   Array com Help
'C'                                , ;      // [06]  C   Tipo do campo
'@!'                               , ;      // [07]  C   Picture
NIL                                , ;      // [08]  B   Bloco de Picture Var
'CLI'                              , ;      // [09]  C   Consulta F3
.T.                                , ;      // [10]  L   Indica se o campo � alteravel
NIL                                , ;      // [11]  C   Pasta do campo
NIL                                , ;      // [12]  C   Agrupamento do campo
NIL                                , ;      // [13]  A   Lista de valores permitido do campo (Combo)
NIL                                , ;      // [14]  N   Tamanho maximo da maior op��o do combo
NIL                                , ;      // [15]  C   Inicializador de Browse
.T.                                , ;      // [16]  L   Indica se o campo � virtual
NIL                                , ;      // [17]  C   Picture Variavel
NIL                                )        // [18]  L   Indica pulo de linha ap�s o campo


oStruZA1:AddField( ;                        // Ord. Tipo Desc.
'ZA1_XEXEM3'                       , ;      // [01]  C   Nome do Campo
cOrder                             , ;      // [02]  C   Ordem
AllTrim( 'Exemplo 3'    )          , ;      // [03]  C   Titulo do campo
AllTrim( 'Campo Exemplo 3' )       , ;      // [04]  C   Descricao do campo
{ 'Exemplo de Campo de Manual 3' } , ;      // [05]  A   Array com Help
'L'                                , ;      // [06]  C   Tipo do campo
'@!'                               , ;      // [07]  C   Picture
NIL                                , ;      // [08]  B   Bloco de Picture Var
NIL                                , ;      // [09]  C   Consulta F3
.T.                                , ;      // [10]  L   Indica se o campo � alteravel
NIL                                , ;      // [11]  C   Pasta do campo
NIL                                , ;      // [12]  C   Agrupamento do campo
NIL                                , ;      // [13]  A   Lista de valores permitido do campo (Combo)
NIL                                , ;      // [14]  N   Tamanho maximo da maior op��o do combo
NIL                                , ;      // [15]  C   Inicializador de Browse
.T.                                , ;      // [16]  L   Indica se o campo � virtual
NIL                                , ;      // [17]  C   Picture Variavel
NIL                                )        // [18]  L   Indica pulo de linha ap�s o campo


aEval( oStruZA2:aFields, { |aX| aX[2] := Soma1( aX[2] ) } )
oStruZA2:AddField( ;                        // Ord. Tipo Desc.
'ZA2_XMARCA'                       , ;      // [01]  C   Nome do Campo
'01'                               , ;      // [02]  C   Ordem
AllTrim( 'Marca'        )          , ;      // [03]  C   Titulo do campo
AllTrim( 'Marca'        )          , ;      // [04]  C   Descricao do campo
{ 'Campo de Marcacao'   }          , ;      // [05]  A   Array com Help
'L'                                , ;      // [06]  C   Tipo do campo
'@!'                               , ;      // [07]  C   Picture
NIL                                , ;      // [08]  B   Bloco de Picture Var
NIL                                , ;      // [09]  C   Consulta F3
.T.                                , ;      // [10]  L   Indica se o campo � alteravel
NIL                                , ;      // [11]  C   Pasta do campo
NIL                                , ;      // [12]  C   Agrupamento do campo
NIL                                , ;      // [13]  A   Lista de valores permitido do campo (Combo)
NIL                                , ;      // [14]  N   Tamanho maximo da maior op��o do combo
NIL                                , ;      // [15]  C   Inicializador de Browse
.T.                                , ;      // [16]  L   Indica se o campo � virtual
NIL                                , ;      // [17]  C   Picture Variavel
NIL                                )        // [18]  L   Indica pulo de linha ap�s o campo
aSort( oStruZA2:aFields,,, { |aX,aY| aX[2] < aY[2] } )


oView := FWFormView():New()

oView:SetModel( oModel )

oView:AddField( 'VIEW_ZA1', oStruZA1, 'ZA1MASTER' )

oView:AddGrid(  'VIEW_ZA2', oStruZA2, 'ZA2DETAIL' )

oView:CreateHorizontalBox( 'SUPERIOR', 30 )
oView:CreateHorizontalBox( 'INFERIOR', 70 )

oView:SetOwnerView( 'VIEW_ZA1', 'SUPERIOR' )
oView:SetOwnerView( 'VIEW_ZA2', 'INFERIOR' )

oView:AddIncrementField( 'VIEW_ZA2', 'ZA2_ITEM' )

oView:AddUserButton( 'Inclui Autor', 'CLIPS', { |oView| COMP026BUT() } )


Return oView


//-----------------------------------------------------------------------------
Static Function COMP026LPOS( oModelGrid )
Local lRet       := .T.
Local oModel     := oModelGrid:GetModel()
Local nOperation := oModel:GetOperation()

If nOperation == 3 .OR. nOperation == 4
	
	If Mod( Val( FwFldGet( 'ZA2_AUTOR' )  ) , 2 )  <> 0
		Help( ,, 'Help',, 'So sao permitidos codigos pares', 1, 0 )
		lRet := .F.
	EndIf
	
EndIf

Return lRet


//-----------------------------------------------------------------------------
Static Function COMP026POS( oModel )
Local lRet       := .T.
Local aArea      := GetArea()
Local aAreaZA1   := ZA1->( GetArea() )
Local nOperation := oModel:GetOperation()
Local oModelZA2  := oModel:GetModel()
Local nI         := 0
Local lAchou     := .F.
Local aSaveLines := FWSaveRows()

ZA1->( dbSetOrder( 1 ) )

If nOperation == 3 .OR. nOperation == 4
	
	For nI := 1 To  oModelZA2:Length() 
		
		oModelZA2:GoLine( nI )
		
		If !oModelZA2:IsDeleted()
			If ZA0->( dbSeek( xFilial( 'ZA0' ) + oModelZA2:GetValue( 'ZA2_AUTOR' ) ) ) .AND. ZA0->ZA0_TIPO == '1'
				lAchou := .T.
				Exit
			EndIf
		EndIf
		
	Next nI
	
	If !lAchou
		Help( ,, 'Help',, 'Deve haver pelo menos 1 Autor', 1, 0 )
		lRet := .F.
	EndIf
	
EndIf

FWRestRows( aSaveLines )

RestArea( aAreaZA1 )
RestArea( aArea )

Return lRet


//-----------------------------------------------------------------------------
Static Function COMP026BUT()
Local lOk        := .F.
Local oModel     := FWModelActive()
Local nOperation := oModel:GetOperation()
Local aArea      := GetArea()
Local aAreaZA1   := ZA1->( GetArea() )

//FWExecView( /*cTitulo*/, /*cFonteModel*/, /*nAcao*/, /*bOk*/ )

If     nOperation == 3 // Inclusao
	FWExecView('Inclusao por FWExecView','COMP011_MVC', nOperation, , { || lOk := .T., lOk } )
	
ElseIf nOperation == 4
	
	ZA1->( dbSetOrder( 1 ) )
	If ZA1->( dbSeek( xFilial( 'ZA1' ) + FwFldGet( 'ZA2_AUTOR' ) ) )
		FWExecView('Alteracao por FWExecView','COMP011_MVC', nOperation, , { || lOk := .T., lOk } )
	EndIf
Else
	
EndIf

If lOk
	Alert( 'Foi confirmada a inclusao do Autor' )
EndIf

RestArea( aAreaZA1 )
RestArea( aArea )

Return lOk
