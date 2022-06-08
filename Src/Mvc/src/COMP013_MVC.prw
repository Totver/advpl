#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

//-------------------------------------------------------------------
User Function COMP013_MVC()
Local oBrowse

oBrowse := FWMBrowse():New()
oBrowse:SetAlias('ZA0')
oBrowse:SetDescription('Cadastro de Autor/Interprete')
//oBrowse:AddLegend( "ZA0_TIPO=='C'", "YELLOW", "Autor"  )
//oBrowse:AddLegend( "ZA0_TIPO=='I'", "BLUE"  , "Interprete"  )
//oBrowse:SetFilterDefault( "ZA0_TIPO=='C'" )
//oBrowse:SetFilterDefault( "Empty(ZA0_DTAFAL)" )
oBrowse:DisableDetails()

oBrowse:Activate()

Return NIL

//-------------------------------------------------------------------
Static Function MenuDef()
Local aRotina := {}

ADD OPTION aRotina TITLE 'Pesquisar'  ACTION 'PesqBrw'             OPERATION 1 ACCESS 0
ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.COMP013_MVC' OPERATION 2 ACCESS 0
ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.COMP013_MVC' OPERATION 3 ACCESS 0
ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.COMP013_MVC' OPERATION 4 ACCESS 0
ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.COMP013_MVC' OPERATION 5 ACCESS 0
ADD OPTION aRotina TITLE 'Imprimir'   ACTION 'VIEWDEF.COMP013_MVC' OPERATION 8 ACCESS 0
ADD OPTION aRotina TITLE 'Copiar'     ACTION 'VIEWDEF.COMP013_MVC' OPERATION 9 ACCESS 0
Return aRotina


//-------------------------------------------------------------------
Static Function ModelDef()
Local oStruZA0 := FWFormStruct( 1, 'ZA0', /*bAvalCampo*/,/*lViewUsado*/ )
Local oModel

oStruZA0:AddField( ;                      // Ord. Tipo Desc.
AllTrim( 'Exemplo 1'    )        , ;      // [01]  C   Titulo do campo
AllTrim( 'Campo Exemplo 1' )     , ;      // [02]  C   ToolTip do campo
'ZA0_XEXEM1'                     , ;      // [03]  C   Id do Field
'C'                              , ;      // [04]  C   Tipo do campo
1                                , ;      // [05]  N   Tamanho do campo
0                                , ;      // [06]  N   Decimal do campo
FwBuildFeature( STRUCT_FEATURE_VALID,"Pertence('12')"), ;    // [07]  B   Code-block de validação do campo
NIL                              , ;      // [08]  B   Code-block de validação When do campo
{'1=Sim','2=Nao'}                , ;      // [09]  A   Lista de valores permitido do campo
NIL                              , ;      // [10]  L   Indica se o campo tem preenchimento obrigatório
FwBuildFeature( STRUCT_FEATURE_INIPAD, "'2'" )       , ;      // [11]  B   Code-block de inicializacao do campo
NIL                              , ;      // [12]  L   Indica se trata-se de um campo chave
NIL                              , ;      // [13]  L   Indica se o campo pode receber valor em uma operação de update.
.T.                              )        // [14]  L   Indica se o campo é virtual

oStruZA0:AddField( ;                      // Ord. Tipo Desc.
AllTrim( 'Exemplo 2'    )        , ;      // [01]  C   Titulo do campo
AllTrim( 'Campo Exemplo 2' )     , ;      // [02]  C   ToolTip do campo
'ZA0_XEXEM2'                     , ;      // [03]  C   Id do Field
'C'                              , ;      // [04]  C   Tipo do campo
6                                , ;      // [05]  N   Tamanho do campo
0                                , ;      // [06]  N   Decimal do campo
FwBuildFeature( STRUCT_FEATURE_VALID,"ExistCpo('SA1', M->ZA0_XEXEM2,1)") , ;      // [07]  B   Code-block de validação do campo
FwBuildFeature( STRUCT_FEATURE_WHEN,"INCLUI" )                           , ;      // [08]  B   Code-block de validação When do campo
NIL                              , ;      // [09]  A   Lista de valores permitido do campo
.T.                              , ;      // [10]  L   Indica se o campo tem preenchimento obrigatório
NIL                              , ;      // [11]  B   Code-block de inicializacao do campo
NIL                              , ;      // [12]  L   Indica se trata-se de um campo chave
NIL                              , ;      // [13]  L   Indica se o campo pode receber valor em uma operação de update.
.T.                              )        // [14]  L   Indica se o campo é virtual

oStruZA0:AddField( ;                      // Ord. Tipo Desc.
AllTrim( 'Exemplo 3'    )        , ;      // [01]  C   Titulo do campo
AllTrim( 'Campo Exemplo 3' )     , ;      // [02]  C   ToolTip do campo
'ZA0_XEXEM3'                     , ;      // [03]  C   Id do Field
'L'                              , ;      // [04]  C   Tipo do campo
1                                , ;      // [05]  N   Tamanho do campo
0                                , ;      // [06]  N   Decimal do campo
NIL                              , ;      // [07]  B   Code-block de validação do campo
NIL                              , ;      // [08]  B   Code-block de validação When do campo
NIL                              , ;      // [09]  A   Lista de valores permitido do campo
NIL                              , ;      // [10]  L   Indica se o campo tem preenchimento obrigatório
FwBuildFeature( STRUCT_FEATURE_INIPAD,'.T.' ), ;      // [11]  B   Code-block de inicializacao do campo
NIL                              , ;      // [12]  L   Indica se trata-se de um campo chave
NIL                              , ;      // [13]  L   Indica se o campo pode receber valor em uma operação de update.
.T.                              )        // [14]  L   Indica se o campo é virtual

oModel := MPFormModel():New('COMP013M', /*bPreValidacao*/, /*bPosValidacao*/, /*bCommit*/, /*bCancel*/ )
//oModel := MPFormModel():New('COMP013M', /*bPreValidacao*/, { |oMdl| COMP013POS( oMdl ) }, /*bCommit*/, /*bCancel*/ )

oModel:AddFields( 'ZA0MASTER', /*cOwner*/, oStruZA0, /*bPreValidacao*/, /*bPosValidacao*/, /*bCarga*/ )

oModel:SetDescription( 'Modelo de Dados de Autor/Interprete' )

oModel:GetModel( 'ZA0MASTER' ):SetDescription( 'Dados de Dados de Autor/Interprete' )

//oModel:SetVldActive( { |oModel| COMP013ACT( oModel ) } )

Return oModel


//-------------------------------------------------------------------
Static Function ViewDef()
Local oModel   := FWLoadModel( 'COMP013_MVC' )
Local oStruZA0 := FWFormStruct( 2, 'ZA0' )
Local oView
Local cOrdem   := '00'

aEval( oStruZA0:aFields, { |aX| aX[2] := Soma1( aX[2] ), aX[2] := Soma1( aX[2] ), aX[2] := Soma1( aX[2] ) } )

cOrder := Soma1( cOrdem )
oStruZA0:AddField( ;                        // Ord. Tipo Desc.
'ZA0_XEXEM1'                       , ;      // [01]  C   Nome do Campo
cOrder                             , ;      // [02]  C   Ordem
AllTrim( 'Exemplo 1'    )          , ;      // [03]  C   Titulo do campo
AllTrim( 'Campo Exemplo 1' )       , ;      // [04]  C   Descricao do campo
{ 'Exemplo de Campo de Manual 1' } , ;      // [05]  A   Array com Help
'C'                                , ;      // [06]  C   Tipo do campo
'@!'                               , ;      // [07]  C   Picture
NIL                                , ;      // [08]  B   Bloco de Picture Var
''                                 , ;      // [09]  C   Consulta F3
.T.                                , ;      // [10]  L   Indica se o campo é alteravel
NIL                                , ;      // [11]  C   Pasta do campo
NIL                                , ;      // [12]  C   Agrupamento do campo
{'1=Sim','2=Nao'}                  , ;      // [13]  A   Lista de valores permitido do campo (Combo)
NIL                                , ;      // [14]  N   Tamanho maximo da maior opção do combo
NIL                                , ;      // [15]  C   Inicializador de Browse
.T.                                , ;      // [16]  L   Indica se o campo é virtual
NIL                                , ;      // [17]  C   Picture Variavel
NIL                                )        // [18]  L   Indica pulo de linha após o campo


oStruZA0:AddField( ;                        // Ord. Tipo Desc.
'ZA0_XEXEM2'                       , ;      // [01]  C   Nome do Campo
cOrder                             , ;      // [02]  C   Ordem
AllTrim( 'Exemplo 2'    )          , ;      // [03]  C   Titulo do campo
AllTrim( 'Campo Exemplo 2' )       , ;      // [04]  C   Descricao do campo
{ 'Exemplo de Campo de Manual 2' } , ;      // [05]  A   Array com Help
'C'                                , ;      // [06]  C   Tipo do campo
'@!'                               , ;      // [07]  C   Picture
NIL                                , ;      // [08]  B   Bloco de Picture Var
'CLI'                              , ;      // [09]  C   Consulta F3
.T.                                , ;      // [10]  L   Indica se o campo é alteravel
NIL                                , ;      // [11]  C   Pasta do campo
NIL                                , ;      // [12]  C   Agrupamento do campo
NIL                                , ;      // [13]  A   Lista de valores permitido do campo (Combo)
NIL                                , ;      // [14]  N   Tamanho maximo da maior opção do combo
NIL                                , ;      // [15]  C   Inicializador de Browse
.T.                                , ;      // [16]  L   Indica se o campo é virtual
NIL                                , ;      // [17]  C   Picture Variavel
NIL                                )        // [18]  L   Indica pulo de linha após o campo


oStruZA0:AddField( ;                        // Ord. Tipo Desc.
'ZA0_XEXEM3'                       , ;      // [01]  C   Nome do Campo
cOrder                             , ;      // [02]  C   Ordem
AllTrim( 'Exemplo 3'    )          , ;      // [03]  C   Titulo do campo
AllTrim( 'Campo Exemplo 3' )       , ;      // [04]  C   Descricao do campo
{ 'Exemplo de Campo de Manual 3' } , ;      // [05]  A   Array com Help
'L'                                , ;      // [06]  C   Tipo do campo
'@!'                               , ;      // [07]  C   Picture
NIL                                , ;      // [08]  B   Bloco de Picture Var
NIL                                , ;      // [09]  C   Consulta F3
.T.                                , ;      // [10]  L   Indica se o campo é alteravel
NIL                                , ;      // [11]  C   Pasta do campo
NIL                                , ;      // [12]  C   Agrupamento do campo
NIL                                , ;      // [13]  A   Lista de valores permitido do campo (Combo)
NIL                                , ;      // [14]  N   Tamanho maximo da maior opção do combo
NIL                                , ;      // [15]  C   Inicializador de Browse
.T.                                , ;      // [16]  L   Indica se o campo é virtual
NIL                                , ;      // [17]  C   Picture Variavel
NIL                                )        // [18]  L   Indica pulo de linha após o campo

aSort( oStruZA0:aFields,,, { |aX,aY| aX[2] < aY[2] } )

oView := FWFormView():New()

oView:SetModel( oModel )
oView:AddField( 'VIEW_ZA0', oStruZA0, 'ZA0MASTER' )

oView:CreateHorizontalBox( 'TELA' , 100 )
oView:SetOwnerView( 'VIEW_ZA0', 'TELA' )

Return oView


//-------------------------------------------------------------------
Static Function COMP013POS( oModel )
Local nOperation := oModel:GetOperation()
Local lRet       := .T.

If nOperation == 4
	If Empty( oModel:GetValue( 'ZA0MASTER', 'ZA0_DTAFAL' ) )
		Help( ,, 'HELP',, 'Informe a data', 1, 0)
		lRet := .F.
	EndIf
EndIf

Return lRet

//-------------------------------------------------------------------
Static Function COMP013ACT( oModel )  // Passa o model sem dados
Local aArea      := GetArea()
Local cQuery     := ''
Local cTmp       := ''
Local lRet       := .T.
Local nOperation := oModel:GetOperation()

If nOperation == 5 .AND. lRet

	cTmp    := GetNextAlias()

	cQuery  := ""
	cQuery  += "SELECT ZA0_CODIGO FROM " + RetSqlName( 'ZA0' ) + " ZA0 "
	cQuery  += " WHERE EXISTS ( "
	cQuery  += "       SELECT 1 FROM " + RetSqlName( 'ZA2' ) + " ZA2 "
	cQuery  += "        WHERE ZA2_AUTOR = ZA0_CODIGO"
	cQuery  += "          AND ZA2.D_E_L_E_T_ = ' ' ) "
	cQuery  += "   AND ZA0_CODIGO = '" + ZA0->ZA0_CODIGO  + "' "
	cQuery  += "   AND ZA0.D_E_L_E_T_ = ' ' "

	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ) , cTmp, .F., .T. )

	lRet := (cTmp)->( EOF() )

	(cTmp)->( dbCloseArea() )

	If lRet
		cQuery  := ""
		cQuery  += "SELECT ZA0_CODIGO FROM " + RetSqlName( 'ZA0' ) + " ZA0 "
		cQuery  += " WHERE EXISTS ( "
		cQuery  += "       SELECT 1 FROM " + RetSqlName( 'ZA5' ) + " ZA5 "
		cQuery  += "        WHERE ZA5_INTER = ZA0_CODIGO"
		cQuery  += "          AND ZA5.D_E_L_E_T_ = ' ' ) "
		cQuery  += "   AND ZA0_CODIGO = '" + ZA0->ZA0_CODIGO  + "' "
		cQuery  += "   AND ZA0.D_E_L_E_T_ = ' ' "

		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ) , cTmp, .F., .T. )

		lRet := (cTmp)->( EOF() )

		(cTmp)->( dbCloseArea() )

	EndIf

	If !lRet
		Help( ,, 'HELP',, 'Este Autor/interprete nao pode ser excluido.', 1, 0)
	EndIf

EndIf

RestArea( aArea )

Return lRet
