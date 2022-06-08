#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

//-------------------------------------------------------------------
/*/{Protheus.doc} EXERC04_MVC
Exemplo de montagem da modelo e interface para uma estrutura
pai/filho em MVC

@author Emerson Campos
@since 22/12/2010
@version P11.5
/*/
//-------------------------------------------------------------------
User Function EXERC04()
Local oBrowse

oBrowse := FWmBrowse():New()
oBrowse:SetAlias( 'ZB5' )
oBrowse:SetDescription( 'Turma / Aluno' )
oBrowse:Activate()

Return NIL


//-------------------------------------------------------------------
Static Function MenuDef()
Local aRotina := {}

ADD OPTION aRotina Title 'Pesquisar'   Action 'PesqBrw'         OPERATION 1 ACCESS 0
ADD OPTION aRotina Title 'Visualizar'  Action 'VIEWDEF.EXERC04' OPERATION 2 ACCESS 0
ADD OPTION aRotina Title 'Incluir'     Action 'VIEWDEF.EXERC04' OPERATION 3 ACCESS 0
ADD OPTION aRotina Title 'Alterar'     Action 'VIEWDEF.EXERC04' OPERATION 4 ACCESS 0
ADD OPTION aRotina Title 'Excluir'     Action 'VIEWDEF.EXERC04' OPERATION 5 ACCESS 0
ADD OPTION aRotina Title 'Imprimir'    Action 'VIEWDEF.EXERC04' OPERATION 8 ACCESS 0
ADD OPTION aRotina Title 'Copiar'      Action 'VIEWDEF.EXERC04' OPERATION 9 ACCESS 0
ADD OPTION aRotina TITLE 'Autor'       Action 'VIEWDEF.EXERC04' OPERATION 3 ACCESS 0

Return aRotina


//-------------------------------------------------------------------
Static Function ModelDef()
// Cria a estrutura a ser usada no Modelo de Dados
Local oStruZB5 := FWFormStruct( 1, 'ZB5', /*bAvalCampo*/, /*lViewUsado*/ )
Local oStruZB6 := FWFormStruct( 1, 'ZB6', /*bAvalCampo*/, /*lViewUsado*/ )
Local oModel

// Cria o objeto do Modelo de Dados
oModel := MPFormModel():New( 'EXERC04M', /*bPreValidacao*/, /*bPosValidacao*/, /*bCommit*/, /*bCancel*/ )
//oModel := MPFormModel():New( 'COMP021M', /*bPreValidacao*/, { | oMdl | COMP021POS( oMdl ) } , /*bCommit*/, /*bCancel*/ )

// Adiciona ao modelo uma estrutura de formulário de edição por campo
oModel:AddFields( 'ZB5MASTER', /*cOwner*/, oStruZB5 )

// Adiciona ao modelo uma estrutura de formulário de edição por grid
oModel:AddGrid( 'ZB6DETAIL', 'ZB5MASTER', oStruZB6, /*bLinePre*/, /*bLinePost*/, /*bPreVal*/, /*bPosVal*/, /*BLoad*/ )
//oModel:AddGrid( 'ZA2DETAIL', 'ZA1MASTER', oStruZA2, /*bLinePre*/,  { | oMdlG | COMP021LPOS( oMdlG ) } , /*bPreVal*/, /*bPosVal*/ )

// Faz relaciomaneto entre os compomentes do model
oModel:SetRelation( 'ZB6DETAIL', { { 'ZB6_FILIAL', 'xFilial( "ZB6" )' }, { 'ZB6_CODTUR', 'ZB5_CODTUR' } }, ZB6->( IndexKey( 1 ) ) )

// Liga o controle de nao repeticao de linha
oModel:GetModel( 'ZB5MASTER' ):SetUniqueLine( { 'ZB5_CODTUR' } )
oModel:GetModel( 'ZB6DETAIL' ):SetUniqueLine( { 'ZB6_NOME' } )

// Indica que é opcional ter dados informados na Grid
//oModel:GetModel( 'ZA2DETAIL' ):SetOptional(.T.)
//oModel:GetModel( 'ZA2DETAIL' ):SetOnlyView(.T.)     


// Adiciona a descricao do Modelo de Dados
oModel:SetDescription( 'Alunos turma' )

// Adiciona a descricao do Componente do Modelo de Dados
oModel:GetModel( 'ZB5MASTER' ):SetDescription( 'Dados da Turma / Aluno' )
oModel:GetModel( 'ZB6DETAIL' ):SetDescription( 'Dados do Alunos Turma'  )

Return oModel


//-------------------------------------------------------------------
Static Function ViewDef()
// Cria um objeto de Modelo de Dados baseado no ModelDef do fonte informado
Local oStruZB5 := FWFormStruct( 2, 'ZB5' )
Local oStruZB6 := FWFormStruct( 2, 'ZB6' )
// Cria a estrutura a ser usada na View
Local oModel   := FWLoadModel( 'EXERC04' )
Local oView

// Cria o objeto de View
oView := FWFormView():New()

// Define qual o Modelo de dados será utilizado
oView:SetModel( oModel )

//Adiciona no nosso View um controle do tipo FormFields(antiga enchoice)
oView:AddField( 'VIEW_ZB5', oStruZb5, 'ZB5MASTER' )

//Adiciona no nosso View um controle do tipo FormGrid(antiga newgetdados)
oView:AddGrid(  'VIEW_ZB6', oStruZB6, 'ZB6DETAIL' )

// Criar um "box" horizontal para receber algum elemento da view
oView:CreateHorizontalBox( 'SUPERIOR', 25 )
oView:CreateHorizontalBox( 'INFERIOR', 75 )

// Relaciona o ID da View com o "box" para exibicao
oView:SetOwnerView( 'VIEW_ZB5', 'SUPERIOR' )
oView:SetOwnerView( 'VIEW_ZB6', 'INFERIOR' )

// Define campos que terao Auto Incremento
oView:AddIncrementField( 'VIEW_ZB6', 'ZB6_ITEM' )

// Criar novo botao na barra de botoes
oView:AddUserButton( 'Inclui Autor', 'CLIPS', { |oView| COMP021BUT() } )

// Liga a identificacao do componente
oView:EnableTitleView('VIEW_ZB6')  // pega à partir do oModel:SetDescription
//oView:EnableTitleView('VIEW_ZA2','MUSICAS') 
//oView:EnableTitleView('VIEW_ZA2','MUSICAS', RGB(224,30,43)) // Para alterar a cor do texto


// Liga a Edição de Campos na FormGrid
oView:SetViewProperty( 'VIEW_ZB6', "ENABLEDGRIDDETAIL", { 60 } )

Return oView