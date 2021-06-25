#INCLUDE "PROTHEUS.CH" 
#INCLUDE "TRGXFUN.CH"
#INCLUDE "TRGDEF.CH"  
#INCLUDE "TRGC030.CH" 
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "FWTABLEATTACH.CH"
#INCLUDE "FWCALENDARWIDGET.CH"

#DEFINE SETA_TEMA 15

Static __cCodPanel		:= ""	//Codigo do Painel definido na area de trabalho
Static __aWidgets		:= {}		//Array de objetos com os Widgets ativos.
Static __lWKSelect		:= .F.
Static __lWKCreate		:= .F.
Static __lIsBrwInChg	:= .F.	
Static __nOptBrwRot		:= 1
Static __aWgtArea		:= {}

//------------------------------------------------------------------------------
/*/{Protheus.doc} TRGC030 

Abertura da Área de Trabalho TRG 

@sample	TRGC030()

@param		Nenhum

@return	Nenhum

@author	Anderson Silva
@since		05/12/2015
@version	P12
/*/
//------------------------------------------------------------------------------
User Function TRGC030()

Local cCodUser	:= RetCodUsr()
Local cTemp		:= GetNextAlias()
Local cCodPanel	:= ""
Local bRun 		:= {|| TRG030Run( cCodPanel ) } 	
Local cQuery 	:= ""
Local lOpenWA	:= .T.

DBSelectArea("AO4")

If lOpenWA
	FwMsgRun(,bRun,Nil,STR0179) //"Aguarde, inicializando..."
EndIf

While ( __lWKSelect .Or. __lWKCreate	)
	If __lWKSelect
		If ConPad1( , , , "AOH", , , .F. )
			If !Empty( AOH->AOH_CODIGO ) 
				cCodPanel := AOH->AOH_CODIGO
				__lWKSelect	:= .F.
				__cCodPanel	:= ""
				__aWidgets	:= {}	
				FwMsgRun(,bRun,Nil,STR0179) //"Aguarde, inicializando..."
			EndIf
		Else
			__lWKSelect	:= .F.
			If MsgYesNo(STR0195) //"Deseja reabrir a área de trabalho anterior?"
				cCodPanel	:= __cCodPanel
				__aWidgets	:= {}	
				FwMsgRun(,bRun,Nil,STR0179) //"Aguarde, inicializando..."
			EndIf	 
		EndIf
	ElseIf __lWKCreate
		__lWKCreate	:= .F.
		__cCodPanel	:= "" 
		__aWidgets	:= {}	
		U_TRGC030A() 
	EndIf     	
End

//-------------------------------------------------------------------------
// Reinicia as variaveis estaticas.
//--------------------------------------------------------------------------
__cCodPanel	:= "" 

//----------------------------------------
// Destroi os objetos criados nos Widgets 
//----------------------------------------		
__aWidgets	:= {}	

Return Nil

//------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030Run()

Àrea de Trabalho TRG

@sample	TRG030Run()

@param		lDefPaper, logico, Indica que o usuario logado definiu um papel antes da abertura da Area de Trabalho.

@return	Nenhum

@author	Anderson Silva
@since		05/12/2015
@version	P12
/*/
//------------------------------------------------------------------------------
Static Function TRG030Run( cCodPanel )
	
Local aAreaAO3		:= AO3->( GetArea() )
Local aAreaAOH		:= AOH->( GetArea() )
Local lPEOpen		:= ExistBlock("TRG030OPEN")
Local lContinua		:= .T. 

Default cCodPanel	:= ""
	
Private cCadastro 	:= STR0162 //"Abertura da Área de Trabalho"

//------------------------------------------------
// Verifica se existe ponto de entrada e executa
//------------------------------------------------
If lPEOpen
	lContinua := ExecBlock("TRG030OPEN")
	If ValType( lContinua ) <> "L"
		lContinua := .F.
	EndIf
EndIf

//-----------------------------
// Carrega Área de  Trabalho
//-----------------------------
If lContinua
	
	//Posiciona no usuario logado.
	DbSelectArea( "AO3" )
	AO3->( DbSetOrder(1) )
		
	If ! AO3->( MsSeek( xFilial("AO3") + RetCodUsr() ) )
		AO3->(RecLock("AO3", .T.))
		AO3->AO3_FILIAL := xFilial("AO3") 
		AO3->AO3_CODUSR := RetCodUsr()
		AO3->(MsUnLock())
	EndIf
		
		If ( !__lWKSelect .And. Empty( cCodPanel ) ) 	
			If !Empty( AO3->AO3_ATPRD )
				//---------------------------------
				// Posiciona na talbea de painéis
				//---------------------------------
				DbSelectArea( "AOH" )			// painéis da Área de Trabalho
				AOH->( DbSetOrder( 1 ) ) 		// AOH_FILIAL+AOH_CODIGO
				If AOH->( MsSeek( xFilial("AOH") + AO3->AO3_ATPRD ) )	
					cCodPanel := AOH->AOH_CODIGO
				EndIf
			Else
				If TRG030ExtPanel() .And. MsgYesNo(STR0196) //"Deseja selecionar um painel para abertura da Área de Trabalho?"
					If ConPad1( , , , "AOH", , , .F. )
						If !Empty( AOH->AOH_CODIGO ) 
							cCodPanel := AOH->AOH_CODIGO
						EndIf
					EndIf
				EndIf	
			EndIf

		EndIf
	
		TRG030WAInit( AO3->AO3_CODUSR, AO3->AO3_MSBLQL, cCodPanel )  //"Inicializando a Área de Trabalho..."
	
	//Else
	//	ApMsgAlert( STR0183 ) //"Não foi possível identificar este usuario como Usuário do CRM!"
	//EndIf	
			
EndIf

RestArea( aAreaAOH )
RestArea( aAreaAO3 )
	
Return Nil

//------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030WAInit

Inicializa o Área de Trabalho do usuario selecionado no browse de usuários.

@sample 	TRG030WAInit( cCodUser, cMSBLQL, cSeqPaper, cCodPanel  )

@param		cCodUser	, caracter		, Código do Usuário.
			cMSBLQL	, caracter		, Usuario bloqueado.
			cCodPanel	, caracter		, Codigo do Painel que será utilizado para abertura da Área de Trabalho.
			
@return   	Nenhum

@author	Anderson Silva
@since		01/12/2015
@version	P12.1.7
/*/
//------------------------------------------------------------------------------
Static Function TRG030WAInit( cCodUser, cMSBLQL, cCodPanel  )
	
Local lRet	:= .T.

Default cCodUser	:= ""
Default cMSBLQL		:= "1"
Default cCodPanel	:= ""

If ! ( cMSBLQL == "1" )
	U_TRGC030WA( cCodUser, cCodPanel )
Else
	ApMsgAlert(STR0175+Chr(10)+STR0176) //"Não será possível acessar Área de Trabalho."#"Usuário bloqueado!" 
	lRet := .F.
EndIf
	
Return( lRet )

//------------------------------------------------------------------------------
/*/{Protheus.doc} TRGC030WA

Monta a área de trabalho

@sample		TRGC030WA( cCodUser, cCodPanel, aControl )

@param			aDlgWA - Objeto onde será criada a workarea
				aControle - Array com as informações da tela a ser montada definida no configurador
					1 - Tela
					2 - Array das opções selecionadas para as telas  ( 2=Tabela   3=Gráfico    4=WebBrowser    5=Calendário ) 
					3 - Array dos Alias das telas
					4 - Array com o IDX das Visoes Iniciais   
					5 - Array com o IDX dos Graficos Iniciais   
					6 - Array com as URL's caso opção 3=WebBrowser
					7 - Array com os Fontes dos Alias das telas
					8 - XML com o Menu
				lRecria - Indica que a workarea deve ser recriada a partir do configurador
				cCodNewPanel - Caracter com código do novo painel criado
					
@return		Nenhum

@author		Thiago Tavares
@since			15/04/2014
@version		P12
/*/
//------------------------------------------------------------------------------
User Function TRGC030WA( cCodUser, cCodPanel, aControl )

Local aAreaAO3			:= AO3->( GetArea() )
Local oDlgWA			:= Nil
Local oPnlAux    		:= Nil
Local cMenuItem  		:= Nil
Local oMenu      		:= Nil
Local oTIBrwsr1  		:= Nil
Local oTIBrwsr2 		:= Nil
Local oTIBrwsr3 		:= Nil
Local oTIBrwsr4  		:= Nil
Local oTIBrwsr5  		:= Nil
Local oWorkArea  		:= Nil
Local aSize      		:= FWGetDialogSize( oMainWnd )
Local aOTIBrowse 		:= { oTIBrwsr1, oTIBrwsr2, oTIBrwsr3, oTIBrwsr4, oTIBrwsr5 }
Local aColunas   		:= { {1, 1}, {1, 2}, {2, 1, 1}, {2, 1}, {2, 2}, {2, 1, 2} }		// array para controle do número de colunas das linhas dos layouts
Local nX         		:= 0
Local nY         		:= 0
Local nIdxCols   		:= 0
Local lMenuPE	 		:= ExistBlock("TRG030MPNL")
Local lCriaMenu			:= .T.
Local lWADefault		:= .F.
Local aButtons			:= {}
Local lDefaultMenu		:= SuperGetMV( "MV_TRGMNDA" , , .F. ) //"Identifica se deve ser utilizado, em todos os acessos do usuário à  área de trabalho, o menu de contexto padrão."  
Local lDefaultXML		:= ExistBlock("CA030MNUXML")
Local cContextMenu		:= ""

Default cCodUser 		:= RetCodUsr()
Default cCodPanel		:= ""
Default aControl 		:= {}

//Se o cadastro de clientes for convertido para MVC excluir essas variaveis private.
Private INCLUI     := .T.
Private la061Auto  := .F.
Private aAutoCab   := {}
Private aAutoItens := {}
Private cMark      := ""
Private aRotina  
Private aRotAuto 

//Se o cadastro de pedido de venda for convertido para MVC excluir essas variaveis private.
Private lOnUpdate  := .T.	
Private l410Auto   := .F.
Private aParamAuto := {}
	
Private aRatCTBPC  := {}
Private aAdtPC     := {}
Private nAutoAdt   := 0

If ( cPaisLoc != "BRA" )
	Private aArrayAE :={}
	Private lImpMsg  :=.T.
EndIf

Private aHeadLEA 		:={} //Template GEM - Solidarios
Private aColsLEA 		:={} //Template GEM - Solidarios
Private lShowOpc 		:= .T.
Private aMemoSC6 		:= { { 'C6_CODINF', 'C6_INFAD' } }
Private lPlanRaAtv		:= .F.	//LOGICO PARA VALIDACAO DA PLANILHA
Private cFilAux	   		:= cFilAnt // Variavel utilizada no FINC010	

Private lExAutoDPR	:= .F.	
Private aColsHist 	:= {}            
Private aColsCCust	:= {}
Private aBkpAgg	  	:= {}   

PtInternal( SETA_TEMA, "TRG_12" )
SetStyle( 5 )

__lWKSelect := .F.

//-------------------------------------------------------------
// Carrega variável estática na criação de um novo painel
//-------------------------------------------------------------
If ! Empty( cCodPanel )
	aControl := TRG030Control(cCodPanel)
	If !Empty( aControl )
		__cCodPanel := cCodPanel //Codigo do painel utilizado para abrir a area de trabalho.
	EndIf
ElseIf Empty( aControl )
	lWADefault := .T.
EndIf

//--------------------------------------
// Area de Trabalho - Nome do Usuário.
//--------------------------------------
If !Empty( cCodUser ) 
		
	cCadastro := STR0001
	cCadastro += " - " + AllTrim( UsrFullName( cCodUser ) )
	
	oDlgWA := MSDialog():New( aSize[1], aSize[2], aSize[3], aSize[4], STR0001, , , , nOr( WS_VISIBLE, WS_POPUP ), , , , , .T., , , , .F. )    // "Área de Trabalho"
	
	oWorkArea := FWUIWorkArea():New( oDlgWA )
	oWorkArea:SetMenuWidth( 200 )
	
	oMenu := FWMenu():New()
	oMenu:Init()
	
	//-------------------------------------------------
	// Verifica se existe ponte de entrada e executa
	//-------------------------------------------------
	If lMenuPE
		lCriaMenu := ExecBlock("TRG030MPNL")
		If ValType(lCriaMenu) <> "L"
			lCriaMenu := .F.
		EndIf
	EndIf
	
	//---------------------
	// Monta menu padrão
	//---------------------
	cMenuItem := oMenu:AddFolder(STR0154, "A") 									//"Painel"
	oMenuItem := oMenu:GetItem( cMenuItem )
	oMenuItem:AddContent( STR0194, "E", "TRG030WGTR()" )  						//"Atualizar" 
	If lCriaMenu
		oMenuItem:AddContent( STR0099 , "E", {|| TRG030SelPanel(oDlgWA)  } )	//"Selecionar Painel"		
		oMenuItem:AddContent( STR0002 , "E", {|| TRG030CWK(oDlgWA) } )			//"Criar Painel"
		oMenuItem:AddContent( STR0169 , "E", "U_TRG030PnPrd()" )					//"Definir como Padrão"
	EndIf
	
	// Área de Trabalho Padrão.
	If lWADefault
		TRG030MMenu( oMenu, U_TRG030GXML() )		// Função que monta o menu
		oWorkArea:SetMenu( oMenu )
		
		oWorkArea:CreateHorizontalBox( "LINE01", 500, .T. )
		oWorkArea:SetBoxCols( "LINE01", { "WDGT01", "WDGT02" } )
		
		oWorkArea:CreateHorizontalBox( "LINE02", 500, .T. )
		oWorkArea:SetBoxCols( "LINE02", { "WDGT03" } )
		
		oWorkArea:CreateHorizontalBox( "LINE03", 500, .T. )
		oWorkArea:SetBoxCols( "LINE03", { "WDGT04", "WDGT05" } )
		
		oWorkArea:Activate()
			
		aAdd(__aWidgets, TRG030CWGT( oWorkArea:GetPanel( "WDGT01" ), "AD1", "FATA300", /*nViewIni*/, /*nChartIni*/, 2 ) )	//GRAFICO OPORTUNIDADES EM ABERTO
		aAdd(__aWidgets, TRG030CWGT( oWorkArea:GetPanel( "WDGT02" ), "SC5", "MATA410", /*nViewIni*/, /*nChartIni*/, 2 ))	//GRAFICO PEDIDO DE VENDA
		aAdd(__aWidgets, TRG030CWGT( oWorkArea:GetPanel( "WDGT03" ), "AD1", "FATA300", /*nViewIni*/, /*nChartIni*/, 1 ))	//GRID OPORTUNIDADES
		aAdd(__aWidgets, TRG030Calend( oWorkArea:GetPanel( "WDGT04" ) ) )															//CALENDARIO
		aAdd(__aWidgets, TRG030CWGT( oWorkArea:GetPanel( "WDGT05" ), "AD1", "FATA300", /*nViewIni*/, /*nChartIni*/, 2 ))	//GRAFICO DO FUNIL DE VENDAS
	Else
		If ( lDefaultMenu )
			cContextMenu := U_TRG030GXML()
		Else
			// aControl
			// [1] - Tela
			// [2] - Array das opções selecionadas para a tela   ( 2=Tabela   3=Gráfico    4=WebBrowser    5=Calendário )
			// [3] - Array dos Alias da tela
			// [4] - Array com o IDX das Visoes Iniciais
			// [5] - Array com o IDX dos Graficos Iniciais
			// [6] - Array com as URL's caso opção 3=WebBrowser
			// [7] - Array com os Fontes dos Alias das telas
			// [8] - XML com o Menu
			cContextMenu := aControl[8]
		EndIf
		
		TRG030MMenu( oMenu, cContextMenu )	// Função que monta o menu a partir do menu criado pelo usuário
		oWorkArea:SetMenu( oMenu )
		
		Do Case
			Case aControl[1] == 1
				oWorkArea:CreateHorizontalBox( "LINE01", 500, .T. )
				oWorkArea:SetBoxCols( "LINE01", { "WDGT01" } )
				
				oWorkArea:CreateHorizontalBox( "LINE02", 500, .T. )
				oWorkArea:SetBoxCols( "LINE02", { "WDGT02" } )
				
			Case aControl[1] == 2
				
				oWorkArea:CreateHorizontalBox( "LINE01", 500, .T. )
				oWorkArea:SetBoxCols( "LINE01", { "WDGT01" } )
				
				oWorkArea:CreateHorizontalBox( "LINE02", 500, .T. )
				oWorkArea:SetBoxCols( "LINE02", { "WDGT02", "WDGT03" } )
				
			Case aControl[1] == 3
				
				oWorkArea:CreateHorizontalBox( "LINE01", 500, .T. )
				oWorkArea:SetBoxCols( "LINE01", { "WDGT01", "WDGT02" } )
				
				oWorkArea:CreateHorizontalBox( "LINE02", 500, .T. )
				oWorkArea:SetBoxCols( "LINE02", { "WDGT03" } )
				
				oWorkArea:CreateHorizontalBox( "LINE03", 500, .T. )
				oWorkArea:SetBoxCols( "LINE03", { "WDGT04" } )
				
			Case aControl[1] == 4
				
				oWorkArea:CreateHorizontalBox( "LINE01", 500, .T. )
				oWorkArea:SetBoxCols( "LINE01", { "WDGT01", "WDGT02" } )
				
				oWorkArea:CreateHorizontalBox( "LINE02", 500, .T. )
				oWorkArea:SetBoxCols( "LINE02", { "WDGT03" } )
				
			Case aControl[1] == 5
				
				oWorkArea:CreateHorizontalBox( "LINE01", 500, .T. )
				oWorkArea:SetBoxCols( "LINE01", { "WDGT01", "WDGT02" } )
				
				oWorkArea:CreateHorizontalBox( "LINE02", 500, .T. )
				oWorkArea:SetBoxCols( "LINE02", { "WDGT03", "WDGT04" } )
				
			Case aControl[1] == 6
				
				oWorkArea:CreateHorizontalBox( "LINE01", 500, .T. )
				oWorkArea:SetBoxCols( "LINE01", { "WDGT01", "WDGT02" } )
				
				oWorkArea:CreateHorizontalBox( "LINE02", 500, .T. )
				oWorkArea:SetBoxCols( "LINE02", { "WDGT03" } )
				
				oWorkArea:CreateHorizontalBox( "LINE03", 500, .T. )
				oWorkArea:SetBoxCols( "LINE03", { "WDGT04", "WDGT05" } )
				
		EndCase
		
		oWorkArea:Activate()
		
		// calculando a qtde de colunas da tela
		For nX := 1 To Len( aColunas[aControl[1]] )
			If aColunas[aControl[1], nX] > 1
				For nY := 1 To aColunas[aControl[1], nX]
					nIdxCols++
				Next nY
			Else
				nIdxCols++
			EndIf
		Next nX

		For nX := 1 To nIdxCols
		
			oPnlAux := oWorkArea:GetPanel( "WDGT0" + AllTrim( Str( nX ) ) )
				
			// validar os tipos
			Do Case
				Case aControl[2, nX] == 2			// tabela
					aAdd(__aWidgets, TRG030CWGT( oPnlAux, aControl[3, nX], /*cFonte*/, aControl[4, nX], aControl[5, nX], 1 ) )
				Case aControl[2, nX] == 3			// grafico
					aAdd(__aWidgets,  TRG030CWGT( oPnlAux, aControl[3, nX], /*cFonte*/, aControl[4, nX], aControl[5, nX], 2 ) )
				Case aControl[2, nX] == 4			// webbrowser
					
					If TRG030IsTIBrw()
						aOTIBrowse[nX]:= TIBrowser():New( 0, 0, oPnlAux:nWidth, oPnlAux:nHeight, aControl[6, nX], oPnlAux )
						aOTIBrowse[nX]:Align := CONTROL_ALIGN_ALLCLIENT
					Else
						TRG030MBlock( oPnlAux, STR0094 ) // "Navegador de Internet indisponível para seu SmartClient!"
					EndIf
					
				Case aControl[2, nX] == 5			// calendario
					aAdd(__aWidgets , TRG030Calend( oPnlAux ) )
					
			EndCase
		Next nX
		
	EndIf
		
	oDlgWA:Activate( , , , , , , EnchoiceBar( oDlgWA, {||}, { || oDlgWA:End() }, ,aButtons, , , , , .F., .F. ) ) //ativa a janela criando uma enchoicebar

Else
	ApMsgAlert(STR0180) //"Usuário não identificado!"
EndIf

//----------------------------------------
// Destroi os objetos criados nos Widgets 
//----------------------------------------		
__aWidgets	:= {}	
	
Return Nil

//---------------------------------------------------------------------------
/*/{Protheus.doc} TRG030Calend 

Monta o Calendário

@sample	TRG030Calend( oPanel )       

@param		oPanel 		,Objeto ,Objeto onde será montada o Calendário.
			
@return	oCalend	,Objeto ,Widget do Calendário.

@author	Thiago Tavares
@since		02/05/2014
@version	P12
/*/
//---------------------------------------------------------------------------
Static Function TRG030Calend( oPanel )

Local oCalend := Nil

oCalend := FWCalendarWidget():New( oPanel )
oCalend:SetbNewActivity( { | dDate, cTimeIni, cTimeFin | TRG030AdTsk( dDate, cTimeIni, cTimeFin ) } )
oCalend:SetbClickActivity( { | oItem | TRG030AtAct( oItem:cId, 4 ) } )
oCalend:SetbRefresh( { | dDate | TRG030SkTsk( dDate ) } )
oCalend:SetbRightClick( { | oItem | TRG030RClick( oItem ) } )		
oCalend:Activate()

Return oCalend

//---------------------------------------------------------------------------
/*/{Protheus.doc} U_TRG030Mnu

Realiza a chamada das rotinas do menu em MVC 

@sample	U_TRG030Mnu( cRotina, cFonte )

@param		cRotina ,Caracter ,Nome da rotina 
			cFonte	 ,Caracter	,Nome do fonte da rotina 

@return	Nenhum

@author	Thiago Tavares
@since		03/04/2014
@version	P12
/*/
//---------------------------------------------------------------------------
User Function TRG030Mnu( cRotina, cFonte, cAlias )

Default cRotina := ""
Default cFonte  := ""
Default cAlias  := ""

If !Empty( cRotina ) .And. !Empty( cFonte )
	
	If Empty( cAlias )
		Do Case
			Case cFonte $ "TMKA260|TRGC700" 
				cAlias := "SUS"
			Case cFonte == "FATA300|TRGC110" 
				cAlias := "AD1"
			Case cFonte == "FATA020"
				cAlias := "AC3"
			Case cFonte == "FATA310|TRGC330" 
				cAlias := "AD5"
			Case cFonte == "TMKA310" 	
				cAlias := "SUO"	
			Case cFonte == "TRGC180" 	
				cAlias := "AOF"	
			Case cFonte == "MATA030"
				cAlias	:= "SA1"
			Case cFonte == "TMKA070|TRGC470"
				cAlias	:= "SU5"
		EndCase
	EndIf
		
	If !Empty( cAlias ) 
		DbSelectArea( cAlias )
		(cAlias)->( DBSetOrder( 1 ) )
	EndIf
	
	FWExecView( cRotina, cFonte, MODEL_OPERATION_INSERT, , { || .T. } )

EndIf

Return Nil

//---------------------------------------------------------------------------
/*/{Protheus.doc} TRG030CWGT

Cria Widget 

@sample	TRG030CWGT( ooPanel, cAliasEnt, cFonte, nViewIni, nChartIni, nType )        

@param		oPanel		,Objeto 	,Objeto onde será montada a GRID
			cAliasEnt	,Caracter	,Entidade para qual sera montada a grid
			cFonte		,Caracter	,Fonte responsavel pelo Widget.
			nViewIni	,Numerico	,Numero da Visao inicial
			nchartIni	,Numerico	,Numero do Grafico inicial
			nType		,Numerico	,Tipo 1=Tabela -> MODE_BROWSE 2=Grafico -> MODE_VIEW_CHART

@return	oWidget 	,Objeto 	,Widget1

@author	Thiago Tavares
@since		02/05/2014
@version	P12
/*/
//---------------------------------------------------------------------------
Static Function TRG030CWGT( oPanel, cAliasEnt, cFonte, nViewIni, nChartIni, nType )

Local aArea        	:= GetArea()
Local aAreaSX2     	:= SX2->( GetArea() )
Local oWidget      	:= Nil
Local oTableAttach 	:= Nil
Local aVisions     	:= {}
Local aCharts      	:= {}
Local aTotal       	:= {}
Local cFonte       	:= ""
Local oMBrowse		:= Nil
Local bStaticCall	:= {||  }

Default oPanel		:= Nil
Default cAliasEnt	:= ""
Default cFonte		:= ""
Default nViewIni	:= 0
Default nChartIni	:= 0
Default nType		:= 0

If !Empty( cAliasEnt )
	
	DbSelectArea( "SX2" )
	DbSetOrder( 1 )
	
	If SX2->( DbSeek ( cAliasEnt ) )
		cFonte := Alltrim( SX2->X2_SYSOBJ )
	EndIf
	
	If !Empty( cFonte )
		
		If MPUserHasAccess( cFonte, Nil, RetCodUsr(), .F. ) 	// Avaliação de privilégios do usuário
			
			aRotina := Nil
			
			DbSelectArea(cAliasEnt)
			(cAliasEnt)->(DbSetOrder(1))
			
			aTotal		:= U_TRG030ARVC( cAliasEnt )
			aVisions	:= aTotal[1]
			aCharts		:= aTotal[2]
			
			//Permite criar widget do tipo browse sem as visões.
			//Mas para widget do tipo grafico é graficos é obrigatorio.
			If ( nType == 1  .Or. !Empty(aCharts) )
				
				aRotina	:= FwLoadMenuDef( cFonte )
				oWidget	:= FWTableAttachWidget():New()
				
				oMBrowse := oWidget:GetBrowse()
				oMBrowse:SetMenuDef( cFonte )
				oMBrowse:SetMainProc( cFonte )
				oMBrowse:SetProfileID( cFonte )
				oMBrowse:SetIgnoreARotina(.T.)
				oMBrowse:SetCanSaveArea(.T.)
				oMBrowse:SetChange( {|| IIF(__lIsBrwInChg , ( __lIsBrwInChg := .F.,  TRG030RestFil( __nOptBrwRot, oMBrowse:GetAlias() ), oMBrowse:SetFocus() ) ,Nil) } )
				oMBrowse:llDBLClick := .F.
				
				oWidget:SetAlias( cAliasEnt )
				
				If !Empty(aVisions)
					If ( nViewIni == 0 .Or. nViewIni > Len(aVisions) )
						nViewIni := 1
					EndIf
					oWidget:SetVisions( aVisions )
					oWidget:SetVisionDefault( aVisions[ nViewIni ] )
				EndIf
				
				If !Empty(aCharts)
					If ( nChartIni == 0 .Or. nChartIni > Len(aCharts) )
						nChartIni := 1
					EndIf
					oWidget:SetCharts( aCharts )
					oWidget:SetChartDefault( aCharts[ nChartIni ] )
					oWidget:SetOpenChart( .T. )
				EndIf
				
				oWidget:SetDisplayMode( IIF( nType == 1, MODE_BROWSE, MODE_VIEW_CHART ) )
				oWidget:SetOwner( oPanel )
				
				bStaticCall := {||  &( "StaticCall( " + cFonte + ", BROWSEDEF, oMBrowse  ) " ) }
				
				Eval( bStaticCall )
				
				oWidget:Activate()
			
			EndIf
			
		Else
			TRG030MBlock( oPanel, STR0161, cAliasEnt )
		EndIf
		
	EndIf
	
EndIf

RestArea( aAreaSX2 )
RestArea( aArea )

Return( oWidget )



//---------------------------------------------------------------------------
/*/{Protheus.doc} TRG030Control

Carrega os arrays de controle para abertura da Área de Trabalho

@sample	TRG030Control( cCodPanel ) 

@param		cCodPanel, Caracter, Codigo do Painel que será utilizado para abertura da Área de Trabalho.
			
@return	Nenhum 

@author	Anderson Silva
@since		05/12/2015
@version	P12
/*/
//---------------------------------------------------------------------------
Static Function TRG030Control( cCodPanel )

Local aArea     := GetArea()
Local aAreaAOH  := AOH->( GetArea() )
Local cAliasTmp := GetNextAlias()
Local aControl 	:= {}
Local aAlias    := {}
Local aOpcoes   := {}
Local aViewPad  := {}
Local aChartPad := {}
Local aUrls     := {}
Local aFontes   := {}
Local cMenu     := ""
Local nNumLay   := 1
Local cOperador := "%" + IIf(Trim(Upper(TcGetDb())) $ "ORACLE,POSTGRES,DB2,INFORMIX","||","+") + "%"

Default cCodPanel := ""

//---------------------------------
// Posiciona na tabela de painéis
//---------------------------------
AOH->( DbSetOrder( 1 ) )	// AOH_FILIAL+AOH_CODIGO

If AOH->( DbSeek( xFilial("AOH") + cCodPanel ) )
	
	nNumLay	:= AOH->AOH_NUMLAY
	cMenu 	:= AOH->AOH_MENU
	
	BeginSql Alias cAliasTmp
		SELECT AOI.AOI_OPCAO, AOI.AOI_ALIAS, AOI.AOI_URL, AOI.AOI_FONTE, AOI.AOI_VDFLT, AOI.AOI_GDFLT
		FROM %Table:AOI% AOI WHERE AOI.AOI_FILIAL = %xFilial:AOI% AND AOI.AOI_CODIGO = %Exp:cCodPanel% AND AOI.%NotDel% ORDER BY AOI.AOI_ITEM
	EndSql
	
	If !( cAliasTmp )->( Eof() )
		While !( cAliasTmp )->( Eof() )
			aAdd( aOpcoes, Val( ( cAliasTmp )->AOI_OPCAO ) )
			aAdd( aAlias, ( cAliasTmp )->AOI_ALIAS )
			aAdd( aViewPad, ( cAliasTmp )->AOI_VDFLT )
			aAdd( aChartPad, ( cAliasTmp )->AOI_GDFLT )
			aAdd( aUrls, AllTrim( ( cAliasTmp )->AOI_URL ) )
			aAdd( aFontes, AllTrim( ( cAliasTmp )->AOI_FONTE ) )
			
			( cAliasTmp )->( DbSkip() )
		End
	EndIf
	
	( cAliasTmp )->( DbCloseArea() )
	
	aAdd( aControl, nNumLay )				// 1 - Tela
	aAdd( aControl, aClone( aOpcoes ) )	// 2 - Array das opções selecionadas para a tela   ( 2=Tabela   3=Gráfico    4=WebBrowser    5=Calendário )
	aAdd( aControl, aClone( aAlias ) )	// 3 - Array dos Alias da tela
	aAdd( aControl, aClone( aViewPad) ) 	// 4 - Array com o IDX das Visoes Iniciais
	aAdd( aControl, aClone( aChartPad ) )	// 5 - Array com o IDX dos Graficos Iniciais
	aAdd( aControl, aClone( aUrls ) ) 	// 6 - Array com as URL's caso opção 3=WebBrowser
	aAdd( aControl, aClone( aFontes) ) 	// 7 - Array com os Fontes dos Alias das telas
	aAdd( aControl, cMenu )					// 8 - XML com o Menu
	
EndIf

RestArea( aAreaAOH )
RestArea( aArea )

Return( aControl )

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AGXML 

Função que gera o XML com os itens disponíveis para o menu     

@sample	TRG030AGXML()

@param		Nenhum
				
@return	Nenhum 

@author	Thiago Tavares
@since		13/05/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
User Function TRG030GXML()

Local cXml 		:= "" 
Local cPEXml	:= ""
Local lPEXml	:= ExistBlock("CA030MNUXML")
Local nTipo  	:= MODEL_OPERATION_INSERT

cXml := "<?xml version='1.0' encoding='ISO-8859-1'?>"
cXml += "<MenuContent>"
cXml += "	<Folder>"
cXml += "		<Description>" + STR0003 + "</Description>"													// Atividades
cXml += "		<Content>"
cXml += "			<Description>" + STR0004 + "</Description>"												// + Criar Atividade   
cXml += "			<Function>CRMA180( , , , 3 )</Function>"												// Atividades
cXml += "			<RotName>CRMA180</RotName>"
cXml += "			<Operation>3</Operation>"
cXml += "			<Alias>AOF</Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0140 +"</Description>"												// Minhas Atividades    
cXml += "			<Function>CRMA180WAATI()</Function>"													// Atividades
cXml += "			<RotName>CRMA180</RotName>"
cXml += "			<Operation>3</Operation>"
cXml += "			<Alias>AOF</Alias> "	
cXml += "		</Content>"
cXml += "	</Folder>"
cXml += "	<Folder>"
cXml += "		<Description>" + STR0007 + "</Description>"													// Contas 
cXml += "		<Content>"
cXml += "			<Description>" + STR0008 + "</Description>"												// + Criar Prospect  
cXml += "			<Function>U_TRG030Mnu( '" + STR0068 + "', 'VIEWDEF.TMKA260', 'SUS' )</Function>"					// Prospect
cXml += "			<RotName>TMKA260</RotName>"
cXml += "			<Operation>3</Operation>"
cXml += "			<Alias>SUS</Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0009 + "</Description>"												// + Criar Cliente   
cXml += "			<Function>( cCadastro := '" + STR0137 + "', aRotina := FwLoadMenuDef( 'MATA030' ),ALTERA := .F. , A030Inclui( 'SA1', , 3 ) )</Function>"			// Cliente
cXml += "			<RotName>MATA030</RotName>"
cXml += "			<Operation>3</Operation>"
cXml += "			<Alias>SA1</Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0010 + "</Description>"												// Meus Clientes    
cXml += "			<Function>CRMA070( 'DSMyCliAt')</Function>"
cXml += "			<RotName>CRMA070</RotName>"
cXml += "			<Operation>3</Operation>"
cXml += "			<Alias>SA1</Alias> "														
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0159 + "</Description>"												// Meus Prospects   
cXml += "			<Function>CRMA700( 'DSMyCliAt')</Function>"
cXml += "			<RotName>CRMA700</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>SUS</Alias> "													
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0011 + "</Description>"												// Contas Compartilhadas   
cXml += "			<Function>CRMA070( 'DSMyCliCo')</Function>"
cXml += "			<RotName>CRMA070</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>SA1</Alias> "													
cXml += "		</Content>"
cXml += "	</Folder>"
cXml += "	<Folder>"
cXml += "		<Description>" + STR0012 + "</Description>"													// Contatos
cXml += "		<Content>"
cXml += "			<Description>" + STR0013 + "</Description>"												// + Criar Contato   
cXml += "			<Function>( cCadastro := '" + STR0136 + "', aRotina := FwLoadMenuDef( 'TMKA070' ), A70Inclui() )</Function>"	//Contatos
cXml += "			<RotName>TMKA070</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>SU5</Alias> "												
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0014 + "</Description>"												// Contatos Ativos   
cXml += "			<Function>CRMA470( 'Ativos' )</Function>"	
cXml += "			<RotName>CRMA470</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>SU5</Alias> "	
cXml += "		</Content>"
cXml += "	</Folder>"
cXml += "	<Folder>"
cXml += "		<Description>" + STR0015 + "</Description>"													// Vendas 
cXml += "		<Content>"
cXml += "			<Description>" + STR0016 + "</Description>"												// + Criar Oportunidade    
cXml += "			<Function>U_TRG030Mnu( '" + STR0070 + "', 'VIEWDEF.FATA300', 'AD1' )</Function>"					// Oportunidade
cXml += "			<RotName>FATA300</RotName>"
cXml += "			<Operation>3</Operation>"
cXml += "			<Alias>AD1</Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0145 + "</Description>"												    
cXml += "			<Function>FWExecModalView( '" + STR0145 + "', 'FATA300',"+ str(nTipo) +", { || .T. }, { || .T. }, ,600 )</Function>" //Oportunidade Rapida
cXml += "			<RotName>FATA300</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>AD1</Alias> "		
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0017 + "</Description>"												// Minhas Oportunidades   
cXml += "			<Function>CRMA110( 'DSMyAbert' )</Function>"	
cXml += "			<RotName>CRMA110</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>AD1</Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0018 + "</Description>"												// Oportunidades Compartilhadas    
cXml += "			<Function>CRMA110( 'DSMyCompa' )</Function>"	
cXml += "			<RotName>CRMA110</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>AD1</Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0138 + "</Description>"					                        	// Desb. Proposta Comercial 							 
cXml += "			<Function>A600TRGDPC(RetCodUsr())</Function>"		
cXml += "			<RotName>A600TRGDPC</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>ADY</Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0019 + "</Description>"												// + Criar Concorrente    
cXml += "			<Function>U_TRG030Mnu( '" + STR0071 + "', 'VIEWDEF.FATA020', 'AC3' )</Function>"					// Concorrente 
cXml += "			<RotName>FATA020</RotName>"
cXml += "			<Operation>3</Operation>"		
cXml += "			<Alias>AC3</Alias> "		
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0020 + "</Description>"												// Concorrentes   
cXml += "			<Function>CRMA490()</Function>"	
cXml += "			<RotName>CRMA490</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>AC3</Alias> "		 		
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0021 + "</Description>"												// + Criar Apontamento   
cXml += "			<Function>U_TRG030Mnu( '" + STR0072 + "', 'VIEWDEF.FATA310', 'AD5' )</Function>"					// Apontamento 
cXml += "			<RotName>FATA310</RotName>"
cXml += "			<Operation>3</Operation>"
cXml += "			<Alias>AD5</Alias> "			
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0022 + "</Description>"												// Meus Apontamentos   
cXml += "			<Function>CRMA330( 'MyApont' )</Function>"		
cXml += "			<RotName>CRMA330</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>AD5</Alias> "		 		
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0023 + "</Description>"												// Minhas Metas   
cXml += "			<Function>CRMA480( 'DSMyMetas' )</Function>"	
cXml += "			<RotName>CRMA480</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>SCT</Alias> "			 		
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0024 + "</Description>"												// Meus Pedidos    
cXml += "			<Function>CRMA310( 'DSMyPedid' )</Function>"	
cXml += "			<RotName>CRMA310</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>SC5</Alias> "			 		
cXml += "		</Content>"
cXml += "	</Folder>"
cXml += "	<Folder>"
cXml += "		<Description>" + STR0025 + "</Description>"													// Marketing
cXml += "		<Content>"
cXml += "			<Description>" + STR0026 + "</Description>"												// + Criar Lista de Marketing    
cXml += "			<Function>( cCadastro := '" + STR0135 + "', aRotina := FwLoadMenuDef( 'TMKA061' ),ALTERA := .T., cMark := GetMark(), Tk061Tela( 'SU4', , 3) )</Function>"				// "Listas de Marketing"		
cXml += "			<RotName>CRMA310</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>SU4</Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0027 + "</Description>"												// Minhas Listas de Marketing   
cXml += "			<Function>CRMA530( 'DSMyLists' )</Function>"	
cXml += "			<RotName>CRMA530</RotName>"
cXml += "			<Operation>3</Operation>"		
cXml += "			<Alias>SU4</Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0030 + "</Description>"												// + Criar Campanha   
cXml += "			<Function>U_TRG030Mnu( '" + STR0075 + "', 'VIEWDEF.TMKA310', 'SUO' )</Function>"					// Campanha
cXml += "			<RotName>TMKA310</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>SUO</Alias> "		
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0031 + "</Description>"												// Minhas Campanhas   
cXml += "			<Function>CRMA360( 'MyCamp' )</Function>"	
cXml += "			<RotName>CRMA360</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias>SUO</Alias> "	
cXml += "		</Content>"
cXml += "	</Folder>"
cXml += "	<Folder>"
cXml += "		<Description>" + STR0033 + "</Description>"													// Consultas
cXml += "		<Content>"
cXml += "			<Description>" + STR0034 + "</Description>"												// Perfil da Contato    
cXml += "			<Function>CRMA010()</Function>"		
cXml += "			<RotName>CRMA010</RotName>"
cXml += "			<Operation>3</Operation>"	
cXml += "			<Alias></Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0035 + "</Description>"												// Análise Gerencial da Conta   
cXml += "			<Function>CRMA390()</Function>"		
cXml += "			<RotName>CRMA390</RotName>"
cXml += "			<Operation></Operation>"
cXml += "			<Alias></Alias> "	
cXml += "		</Content>"
cXml += "		<Content>" 
cXml += "			<Description>" + STR0036 + "</Description>"												// Funil de Venda    
cXml += "			<Function>CRMA080()</Function>"		
cXml += "			<RotName>CRMA080</RotName>"
cXml += "			<Operation></Operation>"
cXml += "			<Alias></Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0037 + "</Description>"												// Previsão de Venda   
cXml += "			<Function>CRMA010()</Function>"		
cXml += "			<RotName>CRMA010</RotName>"
cXml += "			<Operation></Operation>"
cXml += "			<Alias></Alias> "	
cXml += "		</Content>"
cXml += "	</Folder>" 
cXml += "	<Folder>"
cXml += "		<Description>" + STR0038 + "</Description>"													// Relatórios
cXml += "		<Content>"
cXml += "			<Description>" + STR0039 + "</Description>"												// Despesas de Visitas 
cXml += "			<Function>CRMA430()</Function>"		
cXml += "			<RotName>CRMA430</RotName>"
cXml += "			<Operation></Operation>"
cXml += "			<Alias></Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0040 + "</Description>"												// Meta x Realizado    
cXml += "			<Function>FATR050()</Function>"	
cXml += "			<RotName></RotName>"
cXml += "			<Operation></Operation>"
cXml += "			<Alias></Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0041 + "</Description>"												// Oportunidades por Processo de Venda    
cXml += "			<Function>CRMA450()</Function>"	
cXml += "			<RotName>CRMA450</RotName>"
cXml += "			<Operation></Operation>"	
cXml += "			<Alias></Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description>" + STR0143 + "</Description>"												// Relatório de Pré-Escopo    
cXml += "			<Function>FATR110()</Function>"		
cXml += "			<RotName>FATR110</RotName>"
cXml += "			<Operation></Operation>"	
cXml += "			<Alias></Alias> "	
cXml += "		</Content>"
cXml += "		<Content>"
cXml += "			<Description><![CDATA[" + STR0144 + "]]></Description>"									// Relatório horas orçadas x projeto oficial   
cXml += "			<Function>FATR090()</Function>"		
cXml += "			<RotName>FATR090</RotName>"
cXml += "			<Operation></Operation>"	
cXml += "			<Alias></Alias> "	
cXml += "		</Content>"
cXml += "	</Folder>"
cXml += "</MenuContent>"

If lPEXml
	cPEXml := ExecBlock("CA030MNUXML", .F., .F., { cXml })
	If ValType(cPEXml) == "C"
		cXml := cPEXml 
	EndIf
EndIf

Return ( cXml )

//-------------------------------------------------------------------*/
/*/{Protheus.doc} TRG030MMenu
Função que monta o menu a partir do XML   

@param		cXML, caracter, Expressão retornada pelo FWFilterEdit. 
@return	Nenhum

@author	Jonatas Martins
@version	P12.1.7
@since		14/10/2015 
/*/
//-------------------------------------------------------------------
Static Function TRG030MMenu( oMenu, cXml )

Local cRotina	:= ""
Local oXML 		:= TXMLManager():New()
Local aFolders	:= {}
Local aItens	:= {}
Local aFuctions	:= {}
Local nFolder	:= 0
Local nItens	:= 0
Local nFunction	:= 0

Default oMenu		:= Nil
Default cXml		:= ""

//-------------------------------------------------------------------
// Parseia o XML.  
//-------------------------------------------------------------------	
If ( ! Empty( cXML ) .And. ( oXML:Read( cXML,,"ISO-8859-1" ) ) ) 
	//-------------------------------------------------------------------
	// Recupera os menus principais do XML  
	//-------------------------------------------------------------------		
	aFolders := oXML:XPathGetChildArray("/MenuContent")
			
	For nFolder := 1 To Len(aFolders)
		//-------------------------------------------------------------------
		// Recupera os submenus do XML 
		//-------------------------------------------------------------------
		aItens := oXML:XPathGetChildArray( aFolders[nFolder][2] )

		//-------------------------------------------------------------------
		// Cria menus principais no objeto do menu  
		//-------------------------------------------------------------------
		cMenuItem := oMenu:AddFolder( aItens[1][3], "E" ) //Descrição do Menu principal
		oMenuItem := oMenu:GetItem( cMenuItem )
			
		For nItens := 1 To Len(aItens)	
			If aItens[nItens][1]   == "Content" 
				//-------------------------------------------------------------------
				// monta a string com a expressão da rotina para execução no menu 
				//-------------------------------------------------------------------
				cRotina := TRG030Format(	oXML:XPathGetNodeValue( aItens[nItens][2] + "/Function"  ) ,;
											oXML:XPathGetNodeValue( aItens[nItens][2] + "/RotName"   ) ,;
											oXML:XPathGetNodeValue( aItens[nItens][2] + "/Operation" ) ,;
											oXML:XPathGetNodeValue( aItens[nItens][2] + "/Alias" )	)
				//-------------------------------------------------------------------
				// Coloca rotina no objeto do menu  
				//-------------------------------------------------------------------					
				oMenuItem:AddContent( oXML:XPathGetNodeValue( aItens[nItens][2] +"/Description" ), "E", cRotina  )				
			EndIf
		Next nItens
		
	Next nFolder
EndIf 

If oXML <> Nil
	FreeObj( oXML )
EndIf

Return Nil

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030Format 

Função que monta a string com a expressão da rotina para execução no menu da área de trabalho    

@sample	TRG030Format( cBFunction )

@param		cBFunction, caracter, String com nome da rotina a ser utilizada no bloco de execução
				
@return	Nenhum 

@author	Jonatas Martins
@since		05/10/2015
@version	P12.1.6
/*/
//------------------------------------------------------------------------------------
Static Function TRG030Format( cFunction, cRotName, uOperation, cAlias )

Local cExpRot			:= ""

Default cFunction		:= ""
Default cRotName		:= ""
Default uOperation		:= ""
Default cAlias			:= ""

If !Empty( cFunction )
	If Len(uOperation) > 1 .Or. cRotName $ "(|)"
		uOperation	:= ""
		cRotName	:= "" 
	EndIf  
	cExpRot := "U_TRGC030RFun({|| " + cFunction + " }, '" + cRotName + "', " + uOperation + ", '" + cAlias + "' )"
EndIf
	
Return( cExpRot )

//------------------------------------------------------------------------------
/*/{Protheus.doc} TRGC030RFun 

Rotina que controle as operações da rotina conforme os privilégios do usuário    

@sample	TRGC030RFun( cBFunction )

@param		cFunction	, caracter		, Nome da função
			cCodUser	, caracter		, Código do usuário
			nOperation	, numerico		, Tipo da operação	 
				
@return	Nenhum 

@author	Jonatas Martins
@since		05/10/2015
@version	P12.1.6
/*/
//------------------------------------------------------------------------------
User Function TRGC030RFun(bFunction, cRotName, nOperation, cAlias)

Local lMsg 	 		:= .T.
Local cCodUser 		:= RetCodUsr() 

Default bFunction	:= {|| }
Default cRotName	:= ""
Default nOperation	:= Nil
Default cAlias		:= "" 

If MPUserHasAccess(cRotName, nOperation, cCodUser, lMsg)
	
	If nOperation == Nil
		nOperation := 0
	EndIf
	
	TRG030ClrFil(nOperation,/*lObserver*/,/*cSourceName*/) 
	Eval( bFunction )	
	TRG030RestFil(nOperation, cAlias) 
	
EndIf

Return Nil 

//-------------------------------------------------------------------
/*/{Protheus.doc} TRG030ClrFil
Limpa os filtros dos Widgets.

@param		nOperation		, numerico	, Tipo de operação
			lObserver		, logico	, Rotina foi chamada pelo Observer?
			cSourceName	, caracter	, Nome da rotina que observer está controlando.

@return	Nenhum

@author 	Squad TRG / FAT
@version	12.1.17 / Superior
@since		12/06/2017 
/*/
//-------------------------------------------------------------------
Static Function TRG030ClrFil(nOperation,lObserver,cSourceName)

Local nX				:= 0
Local nLenWidget		:= 0
Local cClassName		:= ""
Local cAliasPos 		:= ""
Local oMBrowse			:= Nil

Default nOperation		:= 0
Default lObserver		:= .F.
Default cSourceName		:= ""

If lObserver
	__nOptBrwRot := nOperation
EndIf

If ( !__lIsBrwInChg .And. Str(nOperation,1) $ "0|3|4|5|9" )
	
	If lObserver
		__lIsBrwInChg := .T. 
	EndIf
	
	nLenWidget	:= Len( __aWidgets )
	__aWgtArea	:= {}

	For nX := 1 To nLenWidget
	
		If !Empty( __aWidgets[nX] )	
			
			cClassName := GetClassName(__aWidgets[nX])	
			
			If cClassName == "FWTABLEATTACHWIDGET"
				
				If ( __aWidgets[nX]:cMode == MODE_BROWSE .Or. __aWidgets[nX]:cMode == MODE_BRW_CHART )	
					
					oMBrowse := __aWidgets[nX]:GetBrowse()
					
					If lObserver .And. oMBrowse:GetProfileId() == cSourceName
						//Alias do browse para deixar posicionado caso o usuario clica direto no botão do browse sem posicionar na linha.
						cAliasPos := oMBrowse:GetAlias()
					EndIf
					
					aAdd( __aWgtArea, (__aWidgets[nX]:cAlias)->( GetArea() ) )
					
					oMBrowse:ClearFilter(2, Nil)
				EndIf
					 
			EndIf
			
		EndIf
	
	Next nX
	
	If !Empty( cAliasPos )
		DBSelectArea( cAliasPos )
	EndIf	
	
EndIf

Return Nil

//-------------------------------------------------------------------------
/*/{Protheus.doc} RM030RestFil
Restaura os filtros dos Widgets, caso o mesmo foram limpos anteriormente.

@param		nOperation		, numerico	, Tipo de operação
			cAlias			, caracter  , Alias da tabela
@return	Nenhum

@author 	Squad TRG / FAT
@version	12.1.17 / Superior
@since		12/06/2017 
/*/
//-------------------------------------------------------------------------
Static Function TRG030RestFil(nOperation, cAlias) 

Local nX			:= 0
Local nLenWidget	:= 0
Local cClassName	:= ""
Local oMBrowse		:= Nil
Local nPosArea		:= 0
Local lRefresh		:= .T.
Default nOperation	:= 0
Default cAlias		:= ""

If ( !__lIsBrwInChg .And. Str(nOperation,1) $ "0|3|4|5|9" ) 
	
	CursorWait()
	
	nLenWidget := Len( __aWidgets )

	For nX := 1 To nLenWidget

		If !Empty( __aWidgets[nX] )
			
			cClassName := GetClassName(__aWidgets[nX])
			
			If cClassName == "FWTABLEATTACHWIDGET" 
				
				If ( __aWidgets[nX]:cMode == MODE_BROWSE .Or. __aWidgets[nX]:cMode == MODE_BRW_CHART )
							
					nPosArea := aScan( __aWgtArea, {|x| x[1] == __aWidgets[nX]:cAlias } )
					
					If nPosArea > 0
						oMBrowse := __aWidgets[nX]:GetBrowse()
						oMBrowse:SetFocus()
						oMBrowse:RestoreFilter(2, Nil, 0)
						If nOperation == 5 .And. __aWidgets[nX]:cAlias == cAlias
							lRefresh := .T.
						Else
							RestArea( __aWgtArea[nPosArea] )
							oMBrowse:GoTo(__aWgtArea[nPosArea][3],.T.)
							lRefresh := .F.
						EndIf
					
					EndIf

				EndIf
				
			EndIf

			If lRefresh 
				__aWidgets[nX]:Refresh()	
			EndIf
			
		EndIf

		lRefresh := .T.
	Next nX
		
	CursorArrow()

EndIf

Return Nil

//------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030WGTR

Função que faz o refresh do WidGets

@sample 	TRG030WGTR

@param		Nenhum

@return   	Nenhum

@author	Anderson Silva
@since		10/08/2015
@version	P12.1.7
/*/
//------------------------------------------------------------------------------
Static Function TRG030WGTR() 
Local nX	:= 0

CursorWait()	
For nX := 1 To Len(__aWidgets)
	If !Empty( __aWidgets[nX] )
		__aWidgets[nX]:Refresh()
	EndIf	
Next nX
CursorArrow()

Return Nil

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030Funcs 

Função que retorna as rotinas do menu de contexto da área de trabalho      

@sample	TRG030Funcs()

@param		Nenhum 
				
@return	ExpA - Array de rotinas  

@author	Thiago Tavares
@since		05/05/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
User Function TRG030Funcs()

Local aFunctions	:= {}
Local aPEFuncs		:= {}
Local lPEFuncs		:= ExistBlock("QA030FUNC")
Local nTipo      	:= MODEL_OPERATION_INSERT

aAdd( aFunctions, { STR0021, "U_TRG030Mnu( '" + STR0072 + "', 'VIEWDEF.FATA310', 'AD5' )", "FATA310", "","AD5"  } ) 									// "+ Criar Apontamento"	"Apontamento"
aAdd( aFunctions, { STR0004, "TRGC180(,,,3)", "TRGC180", "3", "AOF" } )																				// "+ Criar Atividade"		"Atividades"
aAdd( aFunctions, { STR0030, "U_TRG030Mnu( '" + STR0075 + "', 'VIEWDEF.TMKA310', 'SUO' )", "FATA310", "","SUO" } ) 									// "+ Criar Campanha"		"Campanha"
aAdd( aFunctions, { STR0009, "( cCadastro := '" + STR0137 + "', " + ;	                            												// "Clientes"
							    "aRotina := FwLoadMenuDef( 'MATA030' ), ALTERA := .F. ," + ;
							    "A030Inclui( 'SA1', , 3 ) )", "MATA030", "", "SA1" } ) 																// "+ Criar Cliente"		"Cliente"
aAdd( aFunctions, { STR0019, "U_TRG030Mnu( '" + STR0071 + "', 'VIEWDEF.FATA020', 'AC3' )", "FATA020", "","AC3" } ) 									// "+ Criar Concorrente"	"Concorrente"
aAdd( aFunctions, { STR0013, "( cCadastro := '"+STR0136+"' , " + ;																					// "Contatos"
								 "aRotina := FwLoadMenuDef( 'TMKA070' ), A70Inclui() )", "TMKA070", "", "SU5" } )									// "+ Criar Contato"					
aAdd( aFunctions, { STR0026, "( cCadastro := '"+STR0135+"', " + ;                                   												// "Lista de Marketing"
								 "aRotina := FwLoadMenuDef( 'TMKA061' ), Tk061Tela( , , 3 ) )", "TMKA061", "","SU4" } )								// "+ Criar Lista de Marketing"		
aAdd( aFunctions, { STR0016, "U_TRG030Mnu( '" + STR0070 + "', 'VIEWDEF.FATA300', 'AD1' )", "FATA300","","AD1" } ) 									// "+ Criar Oportunidade"	"Oportunidade"
aAdd( aFunctions, { STR0145, "FWExecModalView( '" + STR0153 + "', 'FATA300',"+ str(nTipo) +", { || .T. }, { || .T. },,600 )", "FATA300", "","AD1" } ) 	// Oportunidade Rápida 		
aAdd( aFunctions, { STR0008, "U_TRG030Mnu( '" + STR0068 + "', 'VIEWDEF.TMKA260', 'SUS' )", "TMKA260", "","SUS" } ) 									// "+ Criar Prospect" "Prospect"
aAdd( aFunctions, { STR0035, "TRGC390()", "TRGC390", "","" } ) 																						// "Análise Gerencial da Conta"
aAdd( aFunctions, { STR0020, "FATA020()","FATA020","","AC3" } ) 																					// "Concorrentes"
aAdd( aFunctions, { STR0011, "TRGC070( 'DSMyCliCo', 'DSProComp' )", "TRGC070", "","SA1" } ) 														// "Contas Compartilhadas"
aAdd( aFunctions, { STR0014, "TRGC470( 'Ativos' )", "TRGC470", "","SU5" } ) 																		// "Contatos Ativos"
aAdd( aFunctions, { STR0039, "TRGC430()", "TRGC430", "",""  }) 																						// "Despesas de Visitas"
aAdd( aFunctions, { STR0036, "TRGC080()", "TRGC080", "","" } ) 																						// "Funil de Venda"
aAdd( aFunctions, { STR0040, "FATR050()", "FATR050", "","" } ) 																						// "Meta x Realizado"
aAdd( aFunctions, { STR0022, "TRGC330( 'MyApont' )", "TRGC030", "","AD5" } ) 																		// "Meus Apontamentos"
aAdd( aFunctions, { STR0024, "TRGC310( 'DSMyPedid' )", "TRGC310", "","SU5" } ) 																		// "Meus Pedidos"
aAdd( aFunctions, { STR0140, "TRGC180WAATI()", "TRGC180", "","AOF"  })																				// "Minhas Atividades"
aAdd( aFunctions, { STR0031, "TRGC360( 'MyCamp' )", "TRGC360", "","SUO" } )																			// "Minhas Campanhas"
aAdd( aFunctions, { STR0010, "TRGC070( 'DSMyCliAt', 'DSMyAbert' )", "TRGC070", "","SA1"  } )														// "Minhas Contas"
aAdd( aFunctions, { STR0159, "TRGC700( 'DSMyProAt', 'DSMyAbert' )", "TRGC700", "","SUS" } ) 														// "Meus Prospects"
aAdd( aFunctions, { STR0017, "TRGC110( 'DSMyAbert' )", "TRGC110", "","AD1" } ) 																		// "Minhas Oportunidades"
aAdd( aFunctions, { STR0027, "TRGC530( 'DSMyLists' )", "TRGC530", "","SU4" } ) 																		// "Minhas Listas de Marketing"
aAdd( aFunctions, { STR0023, "TRGC480( 'DSMyMetas' )", "TRGC480", "","SCT" } ) 																		// "Minhas Metas"
aAdd( aFunctions, { STR0018, "TRGC110( 'DSMyCompa' )", "TRGC110", "","AD1" } ) 																		// "Oportunidades Compartilhadas"
aAdd( aFunctions, { STR0041, "TRGC450()", "TRGC450", "","" } ) 																						// "Oportunidades por Processo de Venda"
aAdd( aFunctions, { STR0138, "A600TRGDPC(RetCodUsr())", "A600TRGDPC", "","" } ) 																	// "Previsão de Venda"
aAdd( aFunctions, { STR0034, "TMKC010()", "TMKC010", "","" } ) 																						// "Perfil da Contato"
aAdd( aFunctions, { STR0037, "TRGC010()", "TRGC010", "","" } ) 																						// "Previsão de Venda"
aAdd( aFunctions, { STR0141, "TRGC020B()", "TRGC020B", "","" } )																					// "Solicitação e Pesquisas de Contas"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
aAdd( aFunctions, { STR0142, "TRGC030()", "TRGC030", "","" } ) 											           									// "Log de Transferência"
aAdd( aFunctions, { STR0143, "FATR110()", "FATR110", "","" } ) 											           									//"Relatório de Pré-Escopo"
aAdd( aFunctions, { STR0144, "FATR090()", "FATR090", "","" } ) 											            								//"Relatório horas orçadas x projeto oficial" 

If lPEFuncs 
	aPEFuncs := ExecBlock("QA030FUNC", .F., .F., { aFunctions })
	If ValType(aPEFuncs) == "A"
		aFunctions := aClone( aPEFuncs )
	EndIf
EndIf

Return ( aFunctions )

//---------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AdTsk

Funcao que realiza a chamada da rotina de inclusao de atividades 

@sample	TRG030AdTsk( dDate, cTimeIni, cTimeFim )

@param		dDate 		,Data		,Dia da atividade  
			cTimeIni 	,Caractere	,Hora inicial da atividade  
			cTimeFim 	,Caracter	,Hora final da atividade  

@return	Nenhum

@author	Thiago Tavares
@since		03/05/2014
@version	P12
/*/
//---------------------------------------------------------------------------
STATIC Function TRG030AdTsk( dDate, cTimeIni, cTimeFim )

Local oModel	:= Nil 

DBSelectArea("AOF")
AOF->( DBSetOrder(1) )

oModel := FWLoadModel( "CRMA180" )
oModel:SetOperation( MODEL_OPERATION_INSERT )
oModel:Activate()

oModel:SetValue( "AOFMASTER","AOF_DTINIC", dDate )
oModel:SetValue( "AOFMASTER","AOF_DTFIM" , dDate )
oModel:SetValue( "AOFMASTER","AOF_HRINIC", cTimeIni )
oModel:SetValue( "AOFMASTER","AOF_HRFIM" , cTimeFim )

CRMA180( /*uRotAuto*/, /*nOpcAuto*/, /*lExecAuto*/, MODEL_OPERATION_INSERT, /*cAlias*/, /*aAnexos*/, oModel, 2 )
 	 	
Return( .T. )

//---------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AtAct

Funcao que realiza a chamada da rotina de atividades 

@sample	TRG030AtAct( cCodigo )

@param		cCodigo ,Caracter	,Codigo da atividade
			nOpc 	 ,Numerico	,Numero da acao a ser executada  

@return	Nenhum

@author	Thiago Tavares
@since		03/05/2014
@version	P12
/*/
//---------------------------------------------------------------------------
Static Function TRG030AtAct( cCodigo, nOperation )
	
Local aArea := GetArea()

Default cCodigo := ""

DBSelectArea( "AOF" )
AOF->( DbSetOrder( 1 ) )				// AOF_FILIAL+AOF_CODIGO

If nOperation == MODEL_OPERATION_UPDATE .Or. nOperation == MODEL_OPERATION_DELETE 
	If AOF->( DbSeek( xFilial( "AOF" ) + cCodigo ) )
		TRGC180( /*uRotAuto*/, /*nOpcAuto*/, /*lExecAuto*/, nOperation, /*cAlias*/, /*aAnexos*/, /*oMdlAux*/ )	
	EndIf
ElseIf nOperation  == MODEL_OPERATION_INSERT
	TRGC180( /*uRotAuto*/, /*nOpcAuto*/, /*lExecAuto*/, nOperation, /*cAlias*/, /*aAnexos*/, /*oMdlAux*/, 2)	// "Atividades"
EndIf
 
RestArea(aArea)

Return Nil

//---------------------------------------------------------------------------
/*/{Protheus.doc} CA030AdTsk

Funcao que realiza a chamada da rotina de inclusao de atividades 

@sample	CA030AdTsk( dDate, cTimeIni, cTimeFim )

@param		dDate - Dia da atividade  
			cTimeIni - Hora inicial da atividade  
			cTimeFim - Hora final da atividade  

@return	Nenhum

@author	Thiago Tavares
@since		03/05/2014
@version	P12
/*/
//---------------------------------------------------------------------------
Static Function CA030AdTsk( dDate, cTimeIni, cTimeFim )

Local oModel	:= Nil 

oModel := FWLoadModel( "CRMA180" )
oModel:SetOperation( MODEL_OPERATION_INSERT )
oModel:Activate()
oModel:SetValue( "AOFMASTER","AOF_DTINIC", dDate )
oModel:SetValue( "AOFMASTER","AOF_DTFIM" , dDate )
oModel:SetValue( "AOFMASTER","AOF_HRINIC", cTimeIni )
oModel:SetValue( "AOFMASTER","AOF_HRFIM" , cTimeFim )

CRMA180( /*uRotAuto*/, /*nOpcAuto*/, /*lExecAuto*/, MODEL_OPERATION_INSERT, /*cAlias*/, /*aAnexos*/, oModel, 2 )
 
Return ( .T. )
//---------------------------------------------------------------------------
/*/{Protheus.doc} TRG030RClick

Funcao chamada ao clicar com o botao direito

@sample	TRG030RClick( oItem )

@param		oItem	,Objeto, Item do calendário sobre o qual foi clicado com o botão direito 

@return	Nenhum

@author	Thiago Tavares
@since		03/05/2014
@version	P12
/*/
//---------------------------------------------------------------------------
Static Function TRG030RClick( oItem )

Local aMenu := {}
	
If oItem <> Nil
	//-------------------------------------------------------
	// Quando clicou com o direito sobre algum agendamento
	//-------------------------------------------------------
	aAdd( aMenu, { STR0091, "TRG030AtAct( '" + oItem:cId + "', 4 ) " } )			// "Alterar"
	aAdd( aMenu, { STR0092, "TRG030AtAct( '" + oItem:cId + "', 5 ) " } )			// "Excluir"
Else
	//-------------------------------------------------------
	// Quando clicou com o direito sobre um horário livre
	//-------------------------------------------------------
	aAdd( aMenu, { STR0004, "TRG030AtAct( /*cCodigo*/ , 3 ) "  } )					// "+ Criar Atividade"
EndIf
	
Return( aMenu )

//---------------------------------------------------------------------------
/*/{Protheus.doc} TRG030SkTsk

Funcao chamada para atualizar os dados do calendario
Essa funcao recebe uma data e deverá retornar um array de objetos do tipo  
FWCalendarActivity() com as atividades que devem ser exibidas no calendario

@sample	TRG030SkTsk( dDate )

@param		cRotina ,Caracter ,Nome da rotina 
			cFonte	 ,Caracter ,Nome do fonte da rotina 

@return	aItems	 ,Array		,Array de objetos com as ativadades.

@author	Thiago Tavares
@since		03/05/2014
@version	P12
/*/
//---------------------------------------------------------------------------
Static Function TRG030SkTsk( dDate )

Local aArea 		:= GetArea()
Local aItems 		:= {}
Local oItem			:= Nil
Local aPrior		:= { FWCALENDAR_PRIORITY_HIGH, FWCALENDAR_PRIORITY_MEDIUM, FWCALENDAR_PRIORITY_LOW }
Local nPrior		:= 0
Local cAliasTmp		:= GetNextAlias()
Local cCodUser		:= RetCodUsr() 

DbSelectArea( "AOF" )		// Atividades
AOF->( DbSetOrder( 1 ) )	// AOF_FILIAL+AOF_CODIGO

/*
Obs: é possivel definir a cor da atividade de duas formas.
1) Utilizando o metodo SetPriority(), será definida uma cor padrao de acordo com a prioridade da tarefa passada
2) Utilizando o metodo SetColor(cHexColor) e passando uma cor em hexadecimal
Se utilizar o SetColor() não utilize o SetPriority.
*/

BeginSql alias cAliasTmp		
	SELECT AOF.AOF_FILIAL, AOF.AOF_CODIGO
			
	FROM
			%Table:AOF% AOF
	WHERE
		AOF.AOF_FILIAL = %xFilial:AOF% AND
		AOF.AOF_CODUSR = %Exp:cCodUser% AND
		AOF.AOF_TIPO   = "2" AND
		( AOF.AOF_DTINIC = %Exp:dTos(dDate)% OR AOF.AOF_DTFIM = %Exp:dTos(dDate)% ) AND
		AOF.%NotDel% 
EndSql


While (cAliasTmp)->(!Eof()) 

	If AOF->(DbSeek((cAliasTmp)->AOF_FILIAL+(cAliasTmp)->AOF_CODIGO))
	
		nPrior := Val(AOF->AOF_PRIORI) 
	
		oItem := FWCalendarActivity():New()
	
		oItem:SetID(AOF->AOF_CODIGO)
		oItem:SetTitle(AOF->AOF_ASSUNT)
		oItem:SetNotes(AOF->AOF_DESCRI)
		oItem:SetPriority(aPrior[nPrior])  
		oItem:SetDtIni(AOF->AOF_DTINIC)
		oItem:SetDtFin(AOF->AOF_DTFIM)
		oItem:SetHrIni(AOF->AOF_HRINIC)
		oItem:SetHrFin(AOF->AOF_HRFIM)
			
		aAdd(aItems,oItem)
		
	EndIf
	
	(cAliasTmp)->(DbSkip())
End

RestArea(aArea)

Return(aItems)

//------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030IsTIBrw

Verifica se a Navegador de Internet está configurado no SmartClient do usuario.

@sample 	TRG030IsTIBrw()

@param		Nenhum

@return   	lRetorno ,Logico ,Retorno da validação.

@author	Anderson Silva
@since		08/05/2014
@version	P12
/*/
//------------------------------------------------------------------------------ 
Static Function TRG030IsTIBrw() 

Local lRetorno 		:= .F. 
Local cClientIni	:= GetRemoteIniName()
Local cRetorno		:= "0"

cRetorno := GetPvProfString( "Config" , "BrowserEnabled" , cRetorno, cClientIni )

If cRetorno == "1"
	lRetorno := .T.
EndIf 

Return( lRetorno )

//------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030PnPrd

Função que efetua a gravação do painel padrão do usuário

@sample 	TRG030PnPrd()

@param		Nenhum

@return   	Nenhum

@author	Jonatas Martins
@since		10/08/2015
@version	P12.1.7
/*/
//------------------------------------------------------------------------------
User Function TRG030PnPrd()

Local aArea		:= GetArea()
Local aAreaAO4	:= AO4->( GetArea() )
Local aAreaAO3	:= AO3->( GetArea() )

If !Empty(__cCodPanel) 
	
	AOH->( DbSetOrder( 1 ) ) 		// AOH_FILIAL+AOH_CODIGO
	
	If AOH->( MsSeek( xFilial("AOH") + __cCodPanel ) )	
	
		AO3->( DBSetOrder( 1 ) ) 
		//--------------------------------------------------------
		// Faz gravação do código do painel na tabela de usuário
		//--------------------------------------------------------
		If AO3->( DbSeek( xFilial("AO3") + RetCodUsr() ) ) .And. AO3->AO3_ATPRD <> AOH->AOH_CODIGO
			RecLock("AO3", .F.)
			AO3->AO3_ATPRD := __cCodPanel
			AO3->( MsUnLock() )
			MsgInfo(STR0156) //"Painel definido como padrão"		 
		Else
			MsgInfo(STR0158) //"Este painel já está definido como padrão!"
		EndIf 
	Else
		MsgAlert(STR0197) //"Este painel não foi gravado para defini-lo como padrão!"
	EndIf
	
Else
	MsgAlert(STR0197) //"Este painel não foi gravado para defini-lo como padrão!"
EndIf 


RestArea(aAreaAO3)
RestArea(aAreaAO4)
RestArea(aArea)
	
Return Nil

//------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030MBlock

Função e que cria a mensagem de bloqueio

@sample 	TRG030MBlock( oPanel, cMsg, cFonte )

@param		oPanel		,Objeto		, Painel
			cMsg		,caracter	, Mensagem
			cAliasEnt	,caracter	, Nome do Fonte
			
@return   	Nenhum

@author	Jonatas Martins
@since		09/10/2015
@version	P12.1.7
/*/
//------------------------------------------------------------------------------
Static Function TRG030MBlock( oPanel, cMsg, cAliasEnt )

Local oFTIBrw	:= Nil
Local oSayTIBrw	:= Nil
Local cAlsName	:= ""

Default oPanel		:= Nil
Default cMsg		:= ""
Default cAliasEnt	:= ""

If ValType( oPanel ) == "O"

	cAlsName := TRG030AlsName( cAliasEnt )
	
	DEFINE FONT oFTIBrw NAME "Arial" SIZE 0,15 BOLD 
	@ ( ( oPanel:nHeight / 2 ) * 0.50 ),000 SAY oSayTIBrw PROMPT cMsg + cAlsName ;	// "Usuário sem acesso a rotina "
	COLOR CLR_HRED SIZE (oPanel:nWidth / 2 ),010 CENTER OF oPanel PIXEL FONT oFTIBrw	
EndIf
	
Return Nil

//------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AlsName

Função que obtem o nome da tabela

@sample 	TRG030AlsName( cAliasEnt )

@param		cAliasEnt	, caracter	, Alias atual
			
@return   	cAlsName	, caracter	, Nome da tabela

@author	Jonatas Martins 
@since		09/10/2015
@version	P12.1.7
/*/
//------------------------------------------------------------------------------
Static Function TRG030AlsName( cAliasEnt )

Local aArea		:= GetArea()
Local aAreaSX2	:= SX2->(GetArea()) 
Local cAlsName	:= ""

Default cAliasEnt := ""

If !Empty( cAliasEnt ) 
	DbSelectArea("SX2") //Tabelas 
	DbSetOrder(1)		//X2_CHAVE
	If SX2->( DbSeek( cAliasEnt ) )
		cAlsName := AllTrim(SX2->X2_NOME)
	EndIf	
EndIf

RestArea(aAreaSX2) 
RestArea(aArea)

Return( cAlsName )

//------------------------------------------------------------------------------
/*/{Protheus.doc}CA030Mnu()

Função de retrocompatibilidade para XML de Menus da antiga área de trabalho,
Endereçando antigas chamadas para o novo U_TRG030Mnu.

@sample	CA030Mnu('Prospect', 'VIEWDEF.TMKA260')

@param	cFunAlia, 		Caracter, Alias da função
		cViewFunction	Caracter, View a ser executada

@return	Nil

@author	Renato Cunha
@since		23/05/2017
@version	12.1.17
/*/
//------------------------------------------------------------------------------
User Function CA030Mnu(cFunAlias, cViewFunction)
Local cAlias			:= ""
Default cFunAlias 		:= ""
Default cViewFunction	:= "" 
If !Empty(cFunAlias) .AND. !Empty(cViewFunction)
	Do Case
		Case cViewFunction == 'VIEWDEF.TMKA260' //Prospect
				cAlias := 'SUS'
		Case cViewFunction == 'VIEWDEF.FATA300' //Oportunidade
				cAlias := 'AD1'
		Case cViewFunction == 'VIEWDEF.FATA020' //Concorrente
				cAlias := 'AC3'
		Case cViewFunction == 'VIEWDEF.FATA310' //Apontamento
				cAlias := 'AD5'
		Case cViewFunction == 'VIEWDEF.TMKA310' //Campanha
				cAlias := 'SUO'
	EndCase
	U_U_TRG030Mnu( cFunAlias, cViewFunction, cAlias )
EndIf
Return Nil

//------------------------------------------------------------------------------
/*/{Protheus.doc}TRG030CWK

Chamada para seleção de layouts.

@sample	TRG030SelPanel(oDlgWA)

@param		oDlgWK, Objeto, Dialog do Área de Trabalho
						
@return	Nenhum

@author	Squad TRG / FAT
@since		22/01/2016
@version	12.1.7
/*/
//------------------------------------------------------------------------------
Static Function TRG030SelPanel(oDlgWA)

If TRG030ExtPanel()
	__lWKSelect := .T.
	oDlgWA:End()
Else
	MsgAlert(STR0200) //"Não existe painéis para este usuário!"
EndIf

Return Nil 

//------------------------------------------------------------------------------
/*/{Protheus.doc}TRG030CWK

Chamada para criação de um nova Área de Trabalho.

@sample	TRG030CWK(oDlgWK)

@param		oDlgWK, Objeto, Dialog do Área de Trabalho
						
@return	Nenhum

@author	Squad TRG / FAT
@since		22/01/2016
@version	12.1.7
/*/
//------------------------------------------------------------------------------
Static Function TRG030CWK(oDlgWK)
If MsgYesNo(STR0198 + Chr(10) + STR0199 ) //"Área de trabalho será encerrada."#"Deseja continuar?"
	__lWKCreate := .T.
	oDlgWK:End()
EndIf
Return Nil

//------------------------------------------------------------------------------
/*/{Protheus.doc}TRG030QPanel

Verifica se existe painéis disponivel para o usuario.

@sample	TRG030GPnl()

@param		Nenhum
						
@return	lRet, logico, Retorna verdadeiro caso existir painéis disponivel.

@author	Squad TRG / FAT
@since		22/01/2016
@version	12.1.7
/*/
//------------------------------------------------------------------------------
Static Function TRG030ExtPanel()
		
Local cQuery		:= ""
Local cTypeDB		:= Upper(TcGetDb())
Local cConcat		:= "+"
Local cCodPanel		:= ""
Local cTemp			:= GetNextAlias()
Local lRet 			:= .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define o simbolo de concatenacao de acordo com o banco³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cTypeDB $ "ORACLE,POSTGRES,DB2,INFORMIX"
	cConcat := "||"
Endif
	
//Query utilizada para limpar o browse
cQuery := " SELECT "

If cTypeDB == "MSSQL"
	cQuery += " TOP 1 "
EndIf

cQuery += " AOH.AOH_CODIGO " 
cQuery += " FROM " + RetSqlName("AOH") + " AOH "

cQuery += " WHERE AOH_FILIAL = '" + xFilial("AOH") +"' AND AOH.D_E_L_E_T_ = ' ' " 

If cTypeDB == "ORACLE"
	cQuery += " AND ROWNUM = 1 "
EndIf

If cTypeDB $ "MYSQL|POSTGRES"
	cQuery += " LIMIT 1 "
EndIf

//-------------------------------------------------------------------
// Executa a instrução.
//-------------------------------------------------------------------
DBUseArea( .T., "TOPCONN", TcGenQRY(,,cQuery), cTemp, .T., .T. )

If (cTemp)->(!Eof())
	lRet := .T. 
EndIf

(cTemp)->( DBCloseArea() )
	
Return( lRet )