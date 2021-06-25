#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "TRGC030.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} TRGC030B

Cadastro de paineis da nova Área de Trabalho do SIGATRG  

@sample	TRGC030B( uRotAuto, nOpcAuto )

@param		oDlgWA   - Objeto da Janela 
			nOpcAuto - Numero de identificacao da operacao
			aAOHMaster - Array com os valores do cabeçalho
			aAOIDetail - Array com os valores do detalhe
			nOpcAuto - Numero de identificacao da operacao
			
@return	ExpL - Verdadeiro / Falso  

@author 	Thiago Tavares
@since 		09/05/2014
@version	P12
/*/
//-------------------------------------------------------------------
User Function TRGC030B( nOpcAuto, aAOHMaster, aAOIDetail )

Local oBrowse  		:= Nil
Local cFiltro  		:= ""
Local aAutoRot 		:= {}

Private lMsErroAuto := .F.
Private aRotina     := MenuDef()

Default aAOHMaster 	:= Nil 
Default aAOIDetail 	:= Nil 
Default nOpcAuto   	:= Nil

If aAOHMaster == Nil .AND. nOpcAuto == Nil

	oBrowse := FWMBrowse():New()
	oBrowse:SetCanSaveArea(.T.) 
	oBrowse:SetAlias( "AOH" ) 
	oBrowse:SetDescription( STR0088 )		// "Cadastro de Paineis da Área de Trabalho"     	  

	oBrowse:Activate()
	
Else

	aAdd(aAutoRot,{"AOHMASTER",aAOHMaster})
	
	If aAOIDetail <> Nil
		aAdd(aAutoRot,{"AOIDETAIL",aAOIDetail})
	EndIf	

	FWMVCRotAuto( ModelDef(), "AOH", nOpcAuto, aAutoRot, /*lSeek*/, .T. )
  	
  	If lMsErroAuto  
 		MostraErro()
  	EndIf
  	 
EndIf

Return !( lMsErroAuto )

//-------------------------------------------------------------------
/*/{Protheus.doc} ModelDef

Definição do modelo de Dados

@sample	ModelDef()

@param		Nenhum
			
@return	ExpO - Objeto do modelo de dados  

@author 	Thiago Tavares
@since 		09/05/2014
@version	P12
/*/
//-------------------------------------------------------------------
Static Function ModelDef()

Local oModel		:= Nil
Local oStructAOH	:= FWFormStruct( 1, "AOH", /*bAvalCampo*/,  /*lViewUsado*/ )
Local oStructAOI	:= FWFormStruct( 1, "AOI", /*bAvalCampo*/, /*lViewUsado*/ ) 
Local bCommit		:= { | oModel | TRG030BCmm( oModel ) }		// Efetua a  validacao

oModel := MPFormModel():New( "TRGM030B", /*bPreValidacao*/, /*bPosValidacao*/, bCommit, /*bCancel*/ )
oModel:AddFields( "AOHMASTER",  /*cOwner*/, oStructAOH, /*bPreValidacao*/, /*bPosValidacao*/, /*bCarga*/ )
oModel:AddGrid( "AOIDETAIL", "AOHMASTER", oStructAOI, /*bLinePre*/, /*bLinePost*/, /*bPreVal*/, /*bPosVal*/, /*bLoad*/)
oModel:GetModel("AOIDETAIL"):SetNoDeleteLine(.T.)
oModel:SetRelation( "AOIDETAIL", { { "AOI_FILIAL", "xFilial('AOI')" }, {"AOI_CODIGO","AOH_CODIGO"} }, AOI->( IndexKey( 1 ) ) )		// AOI_FILIAL+AOI_CODIGO+AOI_ITEM
oModel:SetPrimaryKey( { "AOH_FILIAL", "AOH_CODIGO" } )
oModel:SetDescription( STR0088 )		// "Cadastro de Paineis da Área de Trabalho"

Return( oModel )

//-------------------------------------------------------------------
/*/{Protheus.doc} ViewDef

Definição do interface

@sample	ViewDef()

@param		Nenhum
			
@return	ExpO - Objeto do modelo da interface  

@author 	Thiago Tavares
@since 		09/05/2014
@version	P12
/*/
//-------------------------------------------------------------------
Static Function ViewDef()

Local oView      := Nil
Local oModel     := FWLoadModel( "TRGC030B" )
Local oStructAOH := FWFormStruct( 2, "AOH", /*bAvalCampo*/, /*lViewUsado*/ )
Local oStructAOI := FWFormStruct( 2, "AOI", /*bAvalCampo*/, /*lViewUsado*/ )  

oStructAOH:RemoveField( "AOH_PADRAO" )
oStructAOH:SetProperty( "*" , MVC_VIEW_CANCHANGE, .F. )
oStructAOI:SetProperty( "*" , MVC_VIEW_CANCHANGE, .F. )  

oView := FWFormView():New()
oView:SetModel( oModel, "AOHMASTER" )
oView:AddField( "VIEW_AOH" , oStructAOH, "AOHMASTER" )
oView:CreateHorizontalBox( "ALL", 20)
oView:SetOwnerView( "VIEW_AOH", "ALL" )

oView:AddGrid( "VIEW_AOI", oStructAOI, "AOIDETAIL" )
oView:CreateHorizontalBox( "GRID", 80)
oView:SetOwnerView( "VIEW_AOI", "GRID" )

Return( oView )

//-------------------------------------------------------------------
/*/{Protheus.doc} MenuDef

Definição das rotinas do Menu

@sample	MenuDef()

@param		Nenhum
			
@return	ExpA - Array de rotinas   

@author	Thiago Tavares
@since		09/05/2014
@version	P12
/*/
//-------------------------------------------------------------------
Static Function MenuDef()

Local aRotina := {}

ADD OPTION aRotina Title STR0089 ACTION "VIEWDEF.TRGC030B" 	OPERATION 2 ACCESS 0	// "Visualizar"				
ADD OPTION aRotina Title STR0001 ACTION "U_TRG030BLoad()"     OPERATION 7 ACCESS 0	// "Área de Trabalho"				
ADD OPTION aRotina Title STR0090 ACTION "TRGC030A"         	OPERATION 3 ACCESS 0	// "Incluir"			
ADD OPTION aRotina Title STR0092 ACTION "VIEWDEF.TRGC030B" 	OPERATION 5 ACCESS 0	// "Excluir"		
ADD OPTION aRotina Title STR0096 ACTION "TRGC200('AOH')"  	OPERATION 8 ACCESS 0	// "Privilégios"		

Return( aRotina )

//------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030BCmm

Bloco de commit do modelo

@sample 	TRG030BCmm( oModel )

@param		oModel - Modelo de dados do sistema

@return   	ExpL - Verdadeiro

@author	Thiago Tavares
@since		15/05/2012
@version	P12
/*/
//------------------------------------------------------------------------------
Static Function TRG030BCmm( oModel )

Local aArea		:= GetArea()
Local lCommit	:= .F.

lCommit := FWFormCommit(oModel)

RestArea( aArea )

Return( lCommit )

//------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030BLoad

Carrega os dados do painel posicionado e chama a área de trabalho    

@sample 	TRG030BLoad()

@param		Nenhum

@return   	Nenhum

@author	Thiago Tavares
@since		15/05/2012
@version	P12
/*/
//------------------------------------------------------------------------------
User Function TRG030BLoad()
Local aArea	  	:= GetArea()	
Local cAliasTmp	:= GetNextAlias()
Local aControl	:= {}
Local aAlias    := {}
Local aOpcoes   := {}
Local aViewPad  := {}
Local aChartPad := {}
Local aUrls     := {}
Local aFontes   := {}
Local cMenu     := ""
Local nMunLay   := 1

nNumLay := AOH->AOH_NUMLAY 
cMenu   := AOH->AOH_MENU 
	
BeginSql Alias cAliasTmp
	SELECT AOI.AOI_OPCAO, AOI.AOI_ALIAS, AOI.AOI_URL, AOI.AOI_FONTE, AOI.AOI_VDFLT, AOI.AOI_GDFLT 
	FROM %Table:AOI% AOI WHERE AOI.AOI_CODIGO = %Exp:AOH->AOH_CODIGO% ORDER BY AOI.AOI_ITEM
EndSql
	
If !( cAliasTmp )->( Eof() )
	While !( cAliasTmp )->( Eof() )    
		
		aAdd( aOpcoes, Val( ( cAliasTmp )->AOI_OPCAO ) )
		aAdd( aAlias, ( cAliasTmp )->AOI_ALIAS )
		aAdd( aViewPad, ( cAliasTmp )->AOI_VDFLT )
		aAdd( aChartPad, ( cAliasTmp )->AOI_GDFLT )
		aAdd( aUrls, AllTRim( ( cAliasTmp )->AOI_URL ) )
		aAdd( aFontes, AllTRim( ( cAliasTmp )->AOI_FONTE ) )
		
		( cAliasTmp )->( DbSkip() )
	End
EndIf
( cAliasTmp )->( DbCloseArea() )

aAdd( aControl, nNumLay )				// 1 - Tela
aAdd( aControl, aClone( aOpcoes ) )		// 2 - Array das opções selecionadas para a tela   ( 2=Tabela   3=Gráfico    4=WebBrowser    5=Calendário )
aAdd( aControl, aClone( aAlias ) )		// 3 - Array dos Alias da tela
aAdd( aControl, aClone( aViewPad) ) 	// 4 - Array com o IDX das Visoes Iniciais
aAdd( aControl, aClone( aChartPad ) )	// 5 - Array com o IDX dos Graficos Iniciais
aAdd( aControl, aClone( aUrls ) ) 		// 6 - Array com as URL's caso opção 3=WebBrowser
aAdd( aControl, aClone( aFontes) ) 		// 7 - Array com os Fontes dos Alias das telas	 
aAdd( aControl, cMenu )					// 8 - XML com o Menu

RestArea(aArea)

FWMsgRun(/*oComponent*/, { || TRGC030WA( /*cCodUser*/, /*cCodPanel*/, aControl) }, Nil, STR0098 )

Return( .T. )