#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

//-------------------------------------------------------------------
User Function COMP011_MVC()
Local oBrowse

oBrowse := FWMBrowse():New()
oBrowse:SetAlias('ZA0')
oBrowse:SetDescription('Cadastro de Compositor/Interprete')
//oBrowse:AddLegend( "ZA0_TIPO=='C'", "YELLOW", "Compositor"  )
//oBrowse:AddLegend( "ZA0_TIPO=='I'", "BLUE"  , "Interprete"  )
//oBrowse:SetFilterDefault( "ZA0_TIPO=='C'" )
//oBrowse:DisableDetails()

oBrowse:Activate()

Return NIL

//-------------------------------------------------------------------
Static Function MenuDef()
Local aRotina := {}

ADD OPTION aRotina TITLE 'Pesquisar'  ACTION 'PesqBrw'             OPERATION 1 ACCESS 0
ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.COMP011_MVC' OPERATION 2 ACCESS 0
ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.COMP011_MVC' OPERATION 3 ACCESS 0
ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.COMP011_MVC' OPERATION 4 ACCESS 0
ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.COMP011_MVC' OPERATION 5 ACCESS 0
ADD OPTION aRotina TITLE 'Imprimir'   ACTION 'VIEWDEF.COMP011_MVC' OPERATION 8 ACCESS 0

Return aRotina


//-------------------------------------------------------------------
Static Function ModelDef()
Local oStruZA0 := FWFormStruct( 1, 'ZA0', /*bAvalCampo*/,/*lViewUsado*/ )
Local oModel

oModel := MPFormModel():New('COMP011M', /*bPreValidacao*/, /*bPosValidacao*/, /*bCommit*/, /*bCancel*/ )
//oModel := MPFormModel():New('COMP011MODEL', /*bPreValidacao*/, { |oMdl| COMP011POS( oMdl ) }, /*bCommit*/, /*bCancel*/ )

oModel:AddFields( 'ZA0MASTER', /*cOwner*/, oStruZA0, /*bPreValidacao*/, /*bPosValidacao*/, /*bCarga*/ )

oModel:SetDescription( 'Modelo de Dados de Compositor/Interprete' )

oModel:GetModel( 'ZA0MASTER' ):SetDescription( 'Dados de Dados de Compositor/Interprete' )

//oModel:SetVldActive( { |oModel| COMP011ACT( oModel ) } )

Return oModel


//-------------------------------------------------------------------
Static Function ViewDef()
Local oModel   := FWLoadModel( 'COMP011_MVC' )
Local oStruZA0 := FWFormStruct( 2, 'ZA0', /*bAvalCampo*/)
Local oView

oView := FWFormView():New()

oView:SetModel( oModel )
oView:AddField( 'VIEW_ZA0', oStruZA0, 'ZA0MASTER' )

oView:CreateHorizontalBox( 'TELA' , 100 )
oView:SetOwnerView( 'VIEW_ZA0', 'TELA' )

Return oView


//-------------------------------------------------------------------
Static Function COMP011POS( oModel )
Local nOperation := oModel:GetOperation()
Local lRet       := .T.

If nOperation == 3
	If Empty( oModel:GetValue( 'ZA0MASTER', 'ZA0_DTAFAL' ) )
		Help( ,, 'HELP',, 'Informe a data', 1, 0)
		lRet := .F.
	EndIf
EndIf

Return lRet

//-------------------------------------------------------------------
Static Function COMP011ACT( oModel )  // Passa o model sem dados
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
		Help( ,, 'HELP',, 'Este compositor/interprete nao pode ser excluido.', 1, 0)		
	EndIf                                                                           
	
EndIf

RestArea( aArea )

Return lRet
