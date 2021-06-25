#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWIZARD.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "TRGC030.CH"
#INCLUDE "FWTABLEATTACH.CH"

#DEFINE ROOT 				1
#DEFINE FOLDER 				2
#DEFINE CONTENT				3
#DEFINE CUSTON_CONTENT		4

#DEFINE TREE_TYPE			1 
#DEFINE TREE_ID				2
#DEFINE TREE_DESCRIPTION	3
#DEFINE TREE_FUNCTION		4
#DEFINE TREE_CHILDREN		5
#DEFINE TREE_OPERATION		6
#DEFINE TREE_ALIAS			7

#DEFINE DESCRIPTION_ID		1
#DEFINE FUNCTION_ID			2
#DEFINE ROTNAME_ID			3
#DEFINE OPERATION_ID		4
#DEFINE ALIAS_ID			5

//------------------------------------------------------------------------------
/*/{Protheus.doc} TRGC030A

Wizard do configurador do painel da area de trabalho

@sample		TRGC030A( cCodUser )

@param			cCodUser - Código do Usuário

@return		Nenhum

@author		Thiago Tavares
@since			24/04/2014
@version		P12
/*/
//------------------------------------------------------------------------------
User Function TRGC030A( cCodUser )

Local oBmp       := Nil
Local nX         := 0
Local nY         := 0
Local nIdxCols   := 1
Local nLayout    := 0
Local cWizTitle  := STR0042			// "Configurador da Área de Trabalho"
Local cHMsg      := STR0043			// "Wizard utilizado para a configuração customizada da Área de Trabalho."
Local cTitle     := STR0044			// "Configuração da Área de Trabalho"
Local cText      := "" 
Local aSize      := FWGetDialogSize( oMainWnd )
Local aColunas   := { {1, 1}, {1, 2}, {2, 1, 1}, {2, 1}, {2, 2}, {2, 1, 2} }		// array para controle do número de colunas das linhas dos layouts
Local bVldNext3  := { || IIF( Empty( AllTrim( cNomLayout ) ), TRG030AMAle( 1 ), ( oWizard:SeTPanel( aScan( aChkLayout, { |x| x == .T. } ) + 1 ), .T. ) ) } 
Local bVldBack   := { || oWizard:SeTPanel( 3 ), .T. }
Local lFinish    := .F.

Local oLayout1 := Nil		
Local oLayout2 := Nil		
Local oLayout3 := Nil		
Local oLayout4 := Nil		
Local oLayout5 := Nil		
Local oLayout6 := Nil		

Local lChkLay1	:= .T.
Local lChkLay2	:= .F.
Local lChkLay3	:= .F.
Local lChkLay4	:= .F.
Local lChkLay5	:= .F.
Local lChkLay6	:= .F.
Local lMnuCont	:= SuperGetMV("MV_TRGWKMC",,.T.)

Private oBold      := Nil
Private aChkLayout := { lChkLay1, lChkLay2, lChkLay3, lChkLay4, lChkLay5, lChkLay6 } 
Private aOLayouts  := { oLayout1, oLayout2, oLayout3, oLayout4, oLayout5, oLayout6 } 
Private cStyle     := "Q3Frame{ border-style:solid; border-width:1px; border-color:#000000 }"
Private lEntrou    := .F.
Private aControl   := {}
Private oNomLayout := Nil	
Private cNomLayout := Space( 50 )	
Private oTree      := Nil
Private lMnuContPd := .T.

// --------------------- VARIAVEIS TELA 1 ---------------------- 
Private oLMainT1   := Nil	 		
Private oLInteT1   := Nil	 
Private oColFULLT1 := Nil
Private aOLinesT1  := {}			// array de objetos LINHA
Private aNLinesT1  := {}			// array de nome LINHA
Private aOLayersT1 := {}			// array de objetos LAYERS
Private aOColsT1   := {}			// array de objetos COLUNAS/BOX
Private aNColsT1   := {}			// array de nome COLUNAS/BOX
Private aOPnlRdT1  := {}			// array de objetos PANEL OPCOES
Private aOPnlAuxT1 := {}			// array de objetos PANEL AUX
Private aOCboxET1  := {}			// array de objetos COMBOBOX ALIAS 
Private aOCboxOpT1 := {}			// array de objetos COMBOBOX OPCOES
Private aOCboxVwT1 := {}			// array de objetos COMBOBOX VISOES
Private aOCboxChT1 := {}			// array de objetos COMBOBOX GRAFICOS/CHARTS
Private aOURLsT1   := {}			// array dos objetos dos GET's das URL's   (OPCAO WEBBROWSER)
Private aCtrolV1T1 := Nil
Private aCtrolV2T1 := Nil
Private aOCtrolVT1 := { aCtrolV1T1, aCtrolV2T1 }
Private aCtrolC1T1 := Nil
Private aCtrolC2T1 := Nil
Private aOCtrolCT1 := { aCtrolC1T1, aCtrolC2T1 }

// --------------------- VARIAVEIS TELA 2 ---------------------- 
Private oLMainT2   := Nil	 		
Private oLInteT2   := Nil	 
Private oColFULLT2 := Nil
Private aOLinesT2  := {} 			// array de objetos LINHA
Private aNLinesT2  := {} 			// array de nome LINHA
Private aOLayersT2 := {}			// array de objetos LAYERS
Private aOColsT2   := {}			// array de objetos COLUNAS/BOX
Private aNColsT2   := {}			// array de nome COLUNAS/BOX
Private aOPnlRdT2  := {}			// array de objetos PANEL OPCOES
Private aOPnlAuxT2 := {}			// array de objetos PANEL AUX
Private aOCboxET2  := {}			// array de objetos COMBOBOX ALIAS 
Private aOCboxOpT2 := {}			// array de objetos COMBOBOX OPCOES
Private aOCboxVwT2 := {}			// array de objetos COMBOBOX VISOES
Private aOCboxChT2 := {}			// array de objetos COMBOBOX GRAFICOS/CHARTS
Private aOURLsT2   := {}			// array dos objetos dos GET's das URL's   (OPCAO WEBBROWSER)
Private cURL1T2    := Space(150)
Private cURL2T2    := Space(150)
Private cURL3T2    := Space(150)
Private aURLsT2    := { cURL1T2, cURL2T2, cURL3T2 }					// array dos GET's das URL's   (OPCAO WEBBROWSER)
Private aCtrolV1T2 := Nil
Private aCtrolV2T2 := Nil
Private aCtrolV3T2 := Nil
Private aOCtrolVT2 := { aCtrolV1T2, aCtrolV2T2, aCtrolV3T2 }		// array das VISOES
Private aCtrolC1T2 := Nil
Private aCtrolC2T2 := Nil
Private aCtrolC3T2 := Nil
Private aOCtrolCT2 := { aCtrolC1T2, aCtrolC2T2, aCtrolC3T2 }		// arrays dos GRAFICOS

// --------------------- VARIAVEIS TELA 3 ---------------------- 
Private oLMainT3   := Nil	 		
Private oLInteT3   := Nil	 
Private oColFULLT3 := Nil
Private aOLinesT3  := {} 			// array de objetos LINHA
Private aNLinesT3  := {} 			// array de nome LINHA
Private aOLayersT3 := {}			// array de objetos LAYERS
Private aOColsT3   := {}			// array de objetos COLUNAS/BOX
Private aNColsT3   := {}			// array de nome COLUNAS/BOX
Private aOPnlRdT3  := {}			// array de objetos PANEL OPCOES
Private aOPnlAuxT3 := {}			// array de objetos PANEL AUX
Private aOCboxET3  := {}			// array de objetos COMBOBOX ALIAS 
Private aOCboxOpT3 := {}			// array de objetos COMBOBOX OPCOES
Private aOCboxVwT3 := {}			// array de objetos COMBOBOX VISOES
Private aOCboxChT3 := {}			// array de objetos COMBOBOX GRAFICOS/CHARTS
Private aOURLsT3   := {}			// array dos objetos dos GET's das URL's   (OPCAO WEBBROWSER)
Private cURL1T3    := Space(150)
Private cURL2T3    := Space(150)
Private cURL3T3    := Space(150)
Private cURL4T3    := Space(150)
Private aURLsT3    := { cURL1T3, cURL2T3, cURL3T3, cURL4T3 }						// array dos GET's das URL's   (OPCAO WEBBROWSER)
Private aCtrolV1T3 := Nil
Private aCtrolV2T3 := Nil
Private aCtrolV3T3 := Nil
Private aCtrolV4T3 := Nil
Private aOCtrolVT3 := { aCtrolV1T3, aCtrolV2T3, aCtrolV3T3, aCtrolV4T3 }			// array das VISOES
Private aCtrolC1T3 := Nil
Private aCtrolC2T3 := Nil
Private aCtrolC3T3 := Nil
Private aCtrolC4T3 := Nil
Private aOCtrolCT3 := { aCtrolC1T3, aCtrolC2T3, aCtrolC3T3, aCtrolC4T3 }			// array dos GRAFICOS

// --------------------- VARIAVEIS TELA 4 ---------------------- 
Private oLMainT4   := Nil	 		
Private oLInteT4   := Nil	 
Private oColFULLT4 := Nil
Private aOLinesT4  := {} 			// array de objetos LINHA
Private aNLinesT4  := {} 			// array de nome LINHA
Private aOLayersT4 := {}			// array de objetos LAYERS
Private aOColsT4   := {}			// array de objetos COLUNAS/BOX
Private aNColsT4   := {}			// array de nome COLUNAS/BOX
Private aOPnlRdT4  := {}			// array de objetos PANEL OPCOES
Private aOPnlAuxT4 := {}			// array de objetos PANEL AUX
Private aOCboxET4  := {}			// array de objetos COMBOBOX ALIAS 
Private aOCboxOpT4 := {}			// array de objetos COMBOBOX OPCOES
Private aOCboxVwT4 := {}			// array de objetos COMBOBOX VISOES
Private aOCboxChT4 := {}			// array de objetos COMBOBOX GRAFICOS/CHARTS
Private aOURLsT4   := {}			// array dos objetos dos GET's das URL's   (OPCAO WEBBROWSER)
Private cURL1T4    := Space(150)
Private cURL2T4    := Space(150)
Private cURL3T4    := Space(150)
Private aURLsT4    := { cURL1T4, cURL2T4, cURL3T4 }					// array dos GET's das URL's   (OPCAO WEBBROWSER)
Private aCtrolV1T4 := Nil
Private aCtrolV2T4 := Nil
Private aCtrolV3T4 := Nil
Private aOCtrolVT4 := { aCtrolV1T4, aCtrolV2T4, aCtrolV3T4 }		// array das VISOES
Private aCtrolC1T4 := Nil
Private aCtrolC2T4 := Nil
Private aCtrolC3T4 := Nil
Private aOCtrolCT4 := { aCtrolC1T4, aCtrolC2T4, aCtrolC3T4 }		// array dos GRAFICOS

// --------------------- VARIAVEIS TELA 5 ---------------------- 
Private oLMainT5   := Nil	 		
Private oLInteT5   := Nil	 
Private oColFULLT5 := Nil
Private aOLinesT5  := {} 			// array de objetos LINHA
Private aNLinesT5  := {} 			// array de nome LINHA
Private aOLayersT5 := {}			// array de objetos LAYERS
Private aOColsT5   := {}			// array de objetos COLUNAS/BOX
Private aNColsT5   := {}			// array de nome COLUNAS/BOX
Private aOPnlRdT5  := {}			// array de objetos PANEL OPCOES
Private aOPnlAuxT5 := {}			// array de objetos PANEL AUX
Private aOCboxET5  := {}			// array de objetos COMBOBOX ALIAS 
Private aOCboxOpT5 := {}			// array de objetos COMBOBOX OPCOES
Private aOCboxVwT5 := {}			// array de objetos COMBOBOX VISOES
Private aOCboxChT5 := {}			// array de objetos COMBOBOX GRAFICOS/CHARTS
Private aOURLsT5   := {}			// array dos objetos dos GET's das URL's   (OPCAO WEBBROWSER)
Private cURL1T5    := Space(150)
Private cURL2T5    := Space(150)
Private cURL3T5    := Space(150)
Private cURL4T5    := Space(150)
Private aURLsT5    := { cURL1T5, cURL2T5, cURL3T5, cURL4T5 }					// array dos GET's das URL's   (OPCAO WEBBROWSER)
Private aCtrolV1T5 := Nil
Private aCtrolV2T5 := Nil
Private aCtrolV3T5 := Nil
Private aCtrolV4T5 := Nil
Private aOCtrolVT5 := { aCtrolV1T5, aCtrolV2T5, aCtrolV3T5, aCtrolV4T5 }		// arrys das VISOES
Private aCtrolC1T5 := Nil
Private aCtrolC2T5 := Nil
Private aCtrolC3T5 := Nil
Private aCtrolC4T5 := Nil
Private aOCtrolCT5 := { aCtrolC1T5, aCtrolC2T5, aCtrolC3T5, aCtrolC4T5 }		// arrays dos GRAFICOS

// --------------------- VARIAVEIS TELA 6 ---------------------- 
Private oLMainT6   := Nil	 		
Private oLInteT6   := Nil	 
Private oColFULLT6 := Nil
Private aOLinesT6  := {} 			// array de objetos LINHA
Private aNLinesT6  := {} 			// array de nome LINHA
Private aOLayersT6 := {}			// array de objetos LAYERS
Private aOColsT6   := {}			// array de objetos COLUNAS/BOX
Private aNColsT6   := {}			// array de nome COLUNAS/BOX
Private aOPnlRdT6  := {}			// array de objetos PANEL OPCOES
Private aOPnlAuxT6 := {}			// array de objetos PANEL AUX
Private aOCboxET6  := {}			// array de objetos COMBOBOX ALIAS 
Private aOCboxOpT6 := {}			// array de objetos COMBOBOX OPCOES
Private aOCboxVwT6 := {}			// array de objetos COMBOBOX VISOES
Private aOCboxChT6 := {}			// array de objetos COMBOBOX GRAFICOS/CHARTS
Private aOURLsT6   := {}			// array dos objetos dos GET's das URL's   (OPCAO WEBBROWSER)
Private cURL1T6    := Space(150)
Private cURL2T6    := Space(150)
Private cURL3T6    := Space(150)
Private cURL4T6    := Space(150)
Private cURL5T6    := Space(150)
Private aURLsT6    := { cURL1T6, cURL2T6, cURL3T6, cURL4T6, cURL5T6 }						// array dos GET's das URL's   (OPCAO WEBBROWSER)
Private aCtrolV1T6 := Nil
Private aCtrolV2T6 := Nil
Private aCtrolV3T6 := Nil
Private aCtrolV4T6 := Nil
Private aCtrolV5T6 := Nil
Private aOCtrolVT6 := { aCtrolV1T6, aCtrolV2T6, aCtrolV3T6, aCtrolV4T6, aCtrolV5T6 }	// array das VISOES
Private aCtrolC1T6 := Nil
Private aCtrolC2T6 := Nil
Private aCtrolC3T6 := Nil
Private aCtrolC4T6 := Nil
Private aCtrolC5T6 := Nil
Private aOCtrolCT6 := { aCtrolC1T6, aCtrolC2T6, aCtrolC3T6, aCtrolC4T6, aCtrolC5T6 }	// array dos GRAFICOS

Default cCodUser	:= RetCodUsr()	

cText := STR0045 + Chr( 10 ) + Chr( 10 )		// "Como Configurar a Área de Trabalho."
cText += STR0102 + Chr( 10 ) 					// "A Área de Trabalho permite que você reúna dados de diferentes entidades em uma única tela. Assim, é possível concentrar todas as informações"
cText += STR0076 + Chr( 10 ) + Chr( 10 )		// "pertinentes à sua rotina de trabalho, evitando a navegação por múltiplas telas do sistema."
cText += STR0103 + Chr( 10 ) + Chr( 10 )		// "Este assistente auxiliará na formatação da sua área de trabalho. Escolha um layout de sua preferência e adicione gráficos e tabelas para cada divisão do layout." 
cText += STR0104 + Chr( 10 )					// "As divisões podem receber os seguintes componentes:"
cText += STR0105 + Chr( 10 )					// "      Tabela: fornece informações detalhadas dos registros."
cText += STR0106 + Chr( 10 )					// "      Gráfico: viabiliza a representação gráfica dos dados."
cText += STR0107 + Chr( 10 )					// "      WebBrowser: disponibiliza um página da internet." 
cText += STR0108 + Chr( 10 ) + Chr( 10 )		// "      Calendário: disponibiliza um calendário com seus compromissos." 
If lMnuCont// "Verifica se habilita o Menu de Contexto"
cText += STR0059 + Chr( 10 )					// "Menu de Contexto"
cText += STR0113 + Chr( 10 )					// "      O menu contextual, localizado à esquerda da área de trabalho, permite o acesso direto às rotinas do módulo de forma ágil, rápida e intuitiva."
cText += STR0114 + Chr( 10 ) + Chr( 10 )		// "      Este assistente também permite a alteração dos itens do menu contextual, selecionando aqueles que atendam as suas análises e atividades."
EndIf
cText += STR0115 + Chr( 10 )					// "Após a finalização do assistente, transforme-o em padrão ( através do cadastro de layout's no menu do Protheus) para vê-lo sempre que abrir a " 
cText += STR0078									//	"Área de Trabalho. Depois de personalizar, é possível compartilhar a sua formatação com outros usuários." 

// ------------------------------------------------ WIZARD - TELA 1 --------------------------------------------
oWizard := ApWizard():New( cWizTitle, cHMsg, cTitle, cText, { || .T. }, { || .T. }, .T., /*cResHead*/, /*bExecute*/, .F., { aSize[1]*0.80, aSize[2]*0.90, aSize[3]*0.90, aSize[4]*0.80 } )

oWizard:newPanel( cWizTitle, STR0046, { || .T. }, bVldNext3, { ||.F.}, .T., { ||.T.} )		// "Escolha do Layout:"
oWizard:newPanel( cWizTitle, STR0047, bVldBack, { || IIF( TRG030AVFIM( 1, aColunas[1] ), ( oWizard:SeTPanel( 8 ), .T. ), .F. ) }, { ||.F.}, .T., { ||.T.} )   		// "Opção de layout escolhida: Layout 1" 
oWizard:newPanel( cWizTitle, STR0048, bVldBack, { || IIF( TRG030AVFIM( 2, aColunas[2] ), ( oWizard:SeTPanel( 8 ), .T. ), .F. ) }, { ||.F.}, .T., { ||.T.} )   		// "Opção de layout escolhida: Layout 2" 
oWizard:newPanel( cWizTitle, STR0049, bVldBack, { || IIF( TRG030AVFIM( 3, aColunas[3] ), ( oWizard:SeTPanel( 8 ), .T. ), .F. ) }, { ||.F.}, .T., { ||.T.} )   		// "Opção de layout escolhida: Layout 3" 
oWizard:newPanel( cWizTitle, STR0050, bVldBack, { || IIF( TRG030AVFIM( 4, aColunas[4] ), ( oWizard:SeTPanel( 8 ), .T. ), .F. ) }, { ||.F.}, .T., { ||.T.} )   		// "Opção de layout escolhida: Layout 4" 
oWizard:newPanel( cWizTitle, STR0051, bVldBack, { || IIF( TRG030AVFIM( 5, aColunas[5] ), ( oWizard:SeTPanel( 8 ), .T. ), .F. ) }, { ||.F.}, .T., { ||.T.} )   		// "Opção de layout escolhida: Layout 5" 
oWizard:newPanel( cWizTitle, STR0052, bVldBack, { || IIF( TRG030AVFIM( 6, aColunas[6] ), ( oWizard:SeTPanel( 8 ), .T. ), .F. ) }, { ||.F.}, .T., { ||.T.} )   		// "Opção de layout escolhida: Layout 6" 
If lMnuCont  // "Verifica se habilita o Menu de Contexto"
	oWizard:newPanel( cWizTitle,STR0116,{ || ( oWizard:SeTPanel( aScan( aChkLayout, { |x| x == .T. } ) + 3 ), .T. ) },{ || IIF( !lMnuContPd, IIF( C030VdTree( oTree:Cargo ), ( IIF( Len( aControl) < 8, aAdd( aControl, U_TRG030ACXml( oTree:Cargo ) ), aControl[8] := U_TRG030ACXml( oTree:Cargo ) ), .T. ), ( TRG030AMAle( 6 ), .F. ) ), ( IIF( Len( aControl ) < 8, aAdd( aControl, U_TRG030ACXml() ), aControl[8] := U_TRG030ACXml() ), .T. ) ) },{ || .F.},.T., { ||.T.} )		// "Criação do Menu de Contexto"		         		 
	oWizard:newPanel( STR0085, STR0086, { ||.T.},  { ||.F.},  { || lFinish := .T. },  .T.,  { ||.T.} )		// "Pronto!"      "Para concluir a configuração clique em Finalizar" 
Else

oWizard:newPanel( STR0085,STR0086,  { || ( oWizard:SeTPanel( aScan( aChkLayout, { |x| x == .T. } ) + 3 ), .T. ) },{ ||.F.},{ || lFinish := .T., IIF( !lMnuContPd, IIF( C030VdTree( oTree:Cargo ), ( IIF( Len( aControl) < 8, aAdd( aControl, U_TRG030ACXml( oTree:Cargo ) ), aControl[8] := U_TRG030ACXml( oTree:Cargo ) ), .T. ), ( TRG030AMAle( 6 ), .F. ) ), ( IIF( Len( aControl ) < 8, aAdd( aControl, U_TRG030ACXml() ), aControl[8] := U_TRG030ACXml() ), .T. ) ) },.T.,{ ||.T.} )		// "Pronto!"      "Para concluir a configuração clique em Finalizar"         		 

EndIf     		 

// ------------------------------------------------ TELA 2 -----------------------------------------------------
oPnlPos := oWizard:GeTPanel( 2 )
oLayerMain := FWLayer():New()								// instanciado layer principal
oLayerMain:Init( oPnlPos, .F. )								// inicializado layer principal
oLayerMain:AddCollumn( "BOX_FULL", 100, .F. ) 				// adicionado box esquerdo 

oColFULL := oLayerMain:getColPanel( "BOX_FULL",  Nil )		// instanciado box esquerdo
oColFULL:Align := CONTROL_ALIGN_ALLCLIENT

// campo para digitar o nome do layout
DEFINE FONT oBold NAME "Arial" SIZE 0, -11 BOLD 
@ oColFULL:nTop+60,oColFULL:nLeft+145 SAY STR0053 FONT oBold OF oColFULL PIXEL SIZE 80,10				// "Digite o nome do Layout:"
oNomLayout := TGet():New( oColFULL:nTop+58, oColFULL:nLeft+215, { |u| If( PCount() > 0, cNomLayout := u, cNomLayout ) }, oColFULL, 130, 10, "@!", , , , , .F., , .T., , .F., , .F., .F., , .F., .F., , cNomLayout )

// opçoes de layout 1
@ oColFULL:nTop+80, oColFULL:nLeft+145 CHECKBOX aOLayouts[1] VAR aChkLayout[1] PROMPT "" SIZE 65,20 ON CLICK { || TRG030AChkL( oColFULL, aOLayouts, @aChkLayout, 1 )/*, aChkLayout[1] := !( aChkLayout[1] )*/ } PIXEL OF oColFULL  
oBmp := TBitmap():New( oColFULL:nTop+80, oColFULL:nLeft+155, 30, 30, "WACRMLAY1B", "", .F. , oColFULL, , , , .T., , , , , .T. )

// opçoes de layout 2
@ oColFULL:nTop+140, oColFULL:nLeft+145 CHECKBOX aOLayouts[2] VAR aChkLayout[2] PROMPT "" SIZE 65,20 ON CLICK { || TRG030AChkL( oColFULL, aOLayouts, @aChkLayout, 2 )/*, aChkLayout[2] := !( aChkLayout[2] )*/ } PIXEL OF oColFULL 
oBmp := TBitmap():New( oColFULL:nTop+140, oColFULL:nLeft+155, 30, 30, "WACRMLAY2B", "", .F. , oColFULL, , , , .T., , , , , .T. )

// opçoes de layout 3
@ oColFULL:nTop+80, oColFULL:nLeft+225 CHECKBOX aOLayouts[3] VAR aChkLayout[3] PROMPT "" SIZE 65,20 ON CLICK { || TRG030AChkL( oColFULL, aOLayouts, @aChkLayout, 3 )/*, aChkLayout[3] := !( aChkLayout[3] )*/ } PIXEL OF oColFULL 
oBmp := TBitmap():New( oColFULL:nTop+80, oColFULL:nLeft+235, 30, 30, "WACRMLAY3B", "", .F. , oColFULL, , , , .T., , , , , .T. )

// opçoes de layout 4
@ oColFULL:nTop+140, oColFULL:nLeft+225 CHECKBOX aOLayouts[4] VAR aChkLayout[4] PROMPT "" SIZE 65,20 ON CLICK { || TRG030AChkL( oColFULL, aOLayouts, @aChkLayout, 4 )/*, aChkLayout[4] := !( aChkLayout[4] )*/ } PIXEL OF oColFULL  
oBmp := TBitmap():New( oColFULL:nTop+140, oColFULL:nLeft+235, 30, 30, "WACRMLAY4B", "", .F. , oColFULL, , , , .T., , , , , .T. )

// opçoes de layout 5
@ oColFULL:nTop+80, oColFULL:nLeft+305 CHECKBOX aOLayouts[5] VAR aChkLayout[5] PROMPT "" SIZE 65,20 ON CLICK { || TRG030AChkL( oColFULL, aOLayouts, @aChkLayout, 5 )/*, aChkLayout[5] := !( aChkLayout[5] )*/ } PIXEL OF oColFULL 
oBmp := TBitmap():New( oColFULL:nTop+80, oColFULL:nLeft+315, 30, 30, "WACRMLAY5B", "", .F. , oColFULL, , , , .T., , , , , .T. )

// opçoes de layout 6
@ oColFULL:nTop+140, oColFULL:nLeft+305 CHECKBOX aOLayouts[6] VAR aChkLayout[6] PROMPT "" SIZE 65,20 ON CLICK { || TRG030AChkL( oColFULL, aOLayouts, @aChkLayout, 6 )/*, aChkLayout[6] := !( aChkLayout[6] )*/ } PIXEL OF oColFULL 
oBmp := TBitmap():New( oColFULL:nTop+140, oColFULL:nLeft+315, 30, 30, "WACRMLAY6B", "", .F. , oColFULL, , , , .T., , , , , .T. )

// ------------------------------------------------ TELA 3 -----------------------------------------------------
oPnlPos := oWizard:GeTPanel( 3 )
TRG030AMT1( oPnlPos , aColunas[1] )

// ------------------------------------------------ TELA 4 -----------------------------------------------------
oPnlPos := oWizard:GeTPanel( 4 )
TRG030AMT2( oPnlPos , aColunas[2] )

// ------------------------------------------------ TELA 5 -----------------------------------------------------
oPnlPos := oWizard:GeTPanel( 5 )
TRG030AMT3( oPnlPos , aColunas[3] )

// ------------------------------------------------ TELA 6 -----------------------------------------------------
oPnlPos := oWizard:GeTPanel( 6 )
TRG030AMT4( oPnlPos , aColunas[4] )

// ------------------------------------------------ TELA 7 -----------------------------------------------------
oPnlPos := oWizard:GeTPanel( 7 )
TRG030AMT5( oPnlPos , aColunas[5] )

// ------------------------------------------------ TELA 8 -----------------------------------------------------
oPnlPos := oWizard:GeTPanel( 8 )
TRG030AMT6( oPnlPos , aColunas[6] )

If lMnuCont
// ------------------------------------------------ TELA 9 -----------------------------------------------------
oPnlPos := oWizard:GeTPanel( 9 )
TRG030AMTree( oPnlPos, @lMnuContPd )

// ------------------------------------------------ TELA 10 ----------------------------------------------------

oPnlPos := oWizard:GeTPanel( 10 )
@ 10,10 SAY STR0130 FONT oBold OF oPnlPos PIXEL SIZE 200,10		// "A configuração da Área de Trabalho foi finalizada com sucesso !"
@ 20,10 SAY STR0131 FONT oBold OF oPnlPos PIXEL SIZE 400,20		// "Acesse a Área de Trabalho personalizada e utilize-a para gerenciar suas atividades diárias e visualizar informações, conforme o layout criado."

Else
// ------------------------------------------------ TELA 9 ----------------------------------------------------
oPnlPos := oWizard:GeTPanel( 9 )
@ 10,10 SAY STR0130 FONT oBold OF oPnlPos PIXEL SIZE 200,10		// "A configuração da Área de Trabalho foi finalizada com sucesso !"
@ 20,10 SAY STR0131 FONT oBold OF oPnlPos PIXEL SIZE 400,20		// "Acesse a Área de Trabalho personalizada e utilize-a para gerenciar suas atividades diárias e visualizar informações, conforme o layout criado."
EndIf
oWizard:Activate( .T. , { ||.T.} )

If lFinish 
	If MsgYesNo( STR0087 )
		TRG030AGrva( cCodUser, oWizard:GeTPanel( 9 ), aControl, aChkLayout, aColunas, @oNomLayout, @cNomLayout, lMnuContPd, IIF( !lMnuContPd, aControl[8], "") )
	Else
		FWMsgRun(/*oComponent*/,{ || U_TRGC030WA( cCodUser, /*cCodPanel*/, aControl ) }, Nil, STR0100 )		// "Aguarde"		"Carregando Área de Trabalho..."  
	EndIf
EndIf

Return

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AMT1

Função para montar a o LAYOUT 1   

@sample	TRG030AMT1( oPanel, aCols )

@param		oPanel - Objeto panel do layout 1
			aCols - Array que traz a quantidade de colunas de cada linha do layout 1

@return	Nenhum 

@author	Thiago Tavares
@since		24/04/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030AMT1( oPanel, aCols )

Local aArea      := GetArea()
Local aAreaAO2   := AO2->( GetArea() )
Local nX         := 0
Local nLinhas    := Len( aCols )
Local cCbxAlias1 := ""
Local cCbxAlias2 := ""
Local cCbxViews1 := ""
Local cCbxViews2 := ""
Local cCbxChart1 := ""
Local cCbxChart2 := ""
Local cCbxOpcs1  := ""
Local cCbxOpcs2  := ""
Local cURL1      := Space(150)
Local cURL2      := Space(150)
Local oBtnOk1    := Nil
Local oBtnOk2    := Nil
Local aOSayAlias := {} 
Local aOSayURLs  := {}
Local aOSayView  := {} 
Local aOSayChart := {} 
Local aItnsVws   := {}
Local aItnsChts  := {}
Local aItnsAlias := { STR0054 }		// ".: Selecione"
Local aItnsOpcs  := { STR0054, STR0055, STR0056, STR0057, STR0058 }		// ".: Selecione"   "Tabela"   "Gráfico"    "WebBrowser"    "Calendário"
Local bChange    := { || .T. }
Local bAction    := { || .T. }

// montando o array das entidades com visao
DbSelectArea( "AO2" )		// controle de entidades
AO2->( DbGoTop() ) 
While !AO2->( EOF() )
	If AO2->AO2_WAVIEW == "1"
		aAdd( aItnsAlias, AO2->AO2_ENTID + " - " + AllTrim( Posicione( "SX2", 1, AO2->AO2_ENTID, "X2NOME()" ) ) )
	EndIf
	AO2->( DbSkip() )
End

oLMainT1 := FWLayer():New()									// instanciado layer principal
oLMainT1:Init( oPanel, .F. )								// inicializado layer principal
oLMainT1:AddCollumn( "BOX_FULL", 100, .F. ) 				// adicionado box principal 
oColFULLT1 := oLMainT1:getColPanel( "BOX_FULL", Nil )		// instanciado box principal

oLInteT1 := FWLayer():New()									// instanciado layer interno
oLInteT1:Init( oColFULLT1, .F. )							// inicializado layer interno a partir do box principal

For nX := 1 To nLinhas

	aAdd( aNLinesT1, "LN" + AllTrim( Str( nX ) ) )
	oLInteT1:AddLine( aNLinesT1[nX], Round( 100 / nLinhas, 0), .F., Nil ) 
	aAdd( aOLinesT1, oLInteT1:getLinePanel( aNLinesT1[nX] ) )
	
	aAdd( aOLayersT1, FWLayer():New() )	
	aOLayersT1[nX]:Init( aOLinesT1[nX], .T. )		 
	
	aAdd( aNColsT1, "BOX1_LN" + AllTrim( Str( nX ) ) )				
	aOLayersT1[nX]:AddCollumn( aNColsT1[nX], 100, .F. ) 	 
	aAdd( aOColsT1, aOLayersT1[nX]:GetColPanel( aNColsT1[nX], Nil ) )

	aAdd( aOPnlRdT1, TPanelCss():New( 02, 02, "", aOColsT1[nX], , .F. , .F. , , , aOColsT1[nX]:nWidth, aOColsT1[nX]:nHeight, .T., .F. ) )
	aOPnlRdT1[nX]:Align := CONTROL_ALIGN_ALLCLIENT    
	aOPnlRdT1[nX]:setCSS( cStyle )

	@ 10,10 SAY STR0060 FONT oBold OF aOPnlRdT1[nX] PIXEL SIZE 80,10			// "Opção:"

	aAdd( aOPnlAuxT1, TPanel():New( 20, 1, "", aOPnlRdT1[nX], , , , , , aOPnlRdT1[nX]:nWidth-1, aOPnlRdT1[nX]:nHeight-20, .F., .F. ) )

	If nX == 1
		
		bChange := { || ( aOSayURLs[1]:Hide(), aOURLsT1[1]:Hide(), oBtnOk1:Hide(), aOSayAlias[1]:Hide(), aOCboxET1[1]:Hide(), aOCboxET1[1]:nAt := 1, aOSayView[1]:Hide(), aOCboxVwT1[1]:Hide(), aOCboxVwT1[1]:nAt := 1, aOSayChart[1]:Hide(), aOCboxChT1[1]:Hide(), aOCboxChT1[1]:nAt := 1, ;
						  IIF( aOCboxOpT1[1]:nAt == 4, ;
						  	  ( aOSayURLs[1]:Show(), aOURLsT1[1]:Show(), oBtnOk1:Show(), .T. ), ; 
						  	  IIF( aOCboxOpT1[1]:nAt == 3 .Or. aOCboxOpT1[1]:nAt == 2, ; 
						  	  	  ( aOSayAlias[1]:Show(), aOCboxET1[1]:Show(), .T. ), .T. ) ) ) }
		aAdd( aOCboxOpT1, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs1 := u, cCbxOpcs1 ) }, aItnsOpcs, 50, 10, aOPnlRdT1[1], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs1" ) )			 										        
		
		aAdd( aOSayURLs, TSay():Create( aOPnlAuxT1[1], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
		aOSayURLs[1]:Hide()
		aAdd( aOURLsT1, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL1 := u, cURL1 ) }, aOPnlAuxT1[1], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL1 ) )
		aOURLsT1[1]:Hide()
		
		bAction := { || IIF( TRG030AVldUrl( cURL1 ), .T., .F. ) } 
		oBtnOk1 := TButton():New( 09, 195, STR0067, aOPnlAuxT1[1], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
		oBtnOk1:Hide()
	
		bChange := { || ( aOCboxVwT1[1]:SetItems( { "" } ), aOCboxChT1[1]:SetItems( { "" } ), ;
						    IIF( aOCboxOpT1[1]:nAt == 2, ; 
							( aOCboxVwT1[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT1[1]:Show(), .T. ), ;
							IIF( aOCboxOpT1[1]:nAt == 3 , ;
								( aOCboxVwT1[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT1[1]:Show(), ;
								  aOCboxChT1[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 2 ) ) ), aOSayChart[1]:Show(), aOCboxChT1[1]:Show(), .T. ), .T. ) ) ) }
		aAdd( aOSayAlias, TSay():Create( aOPnlAuxT1[1], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
		aOSayAlias[1]:Hide()
		aAdd( aOCboxET1, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias1 := u, cCbxAlias1 ) }, aItnsAlias, 100, 10, aOPnlAuxT1[1], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias1" ) )
		aOCboxET1[1]:Hide()
	
		aAdd( aOSayView, TSay():Create( aOPnlAuxT1[1], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
		aOSayView[1]:Hide()
		aAdd( aOCboxVwT1, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews1 := u, cCbxViews1 ) }, { "" }, 100, 10, aOPnlAuxT1[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews1" ) )
		aOCboxVwT1[1]:Hide()

		aAdd( aOSayChart, TSay():Create( aOPnlAuxT1[1], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
		aOSayChart[1]:Hide()
		aAdd( aOCboxChT1, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart1 := u, cCbxChart1 ) }, { "" }, 140, 10, aOPnlAuxT1[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart1" ) )
		aOCboxChT1[1]:Hide()

	Else

		bChange := { || ( aOSayURLs[2]:Hide(), aOURLsT1[2]:Hide(), oBtnOk2:Hide(), aOSayAlias[2]:Hide(), aOCboxET1[2]:Hide(), aOCboxET1[2]:nAt := 1, aOSayView[2]:Hide(), aOCboxVwT1[2]:Hide(), aOCboxVwT1[2]:nAt := 1, aOSayChart[2]:Hide(), aOCboxChT1[2]:Hide(), aOCboxChT1[2]:nAt := 1, ;
						  IIF( aOCboxOpT1[2]:nAt == 4, ;
						  	  ( aOSayURLs[2]:Show(), aOURLsT1[2]:Show(), oBtnOk2:Show(), .T. ), ; 
						  	  IIF( aOCboxOpT1[2]:nAt == 3 .Or. aOCboxOpT1[2]:nAt == 2, ; 
						  	  	  ( aOSayAlias[2]:Show(), aOCboxET1[2]:Show(), .T. ), .T. ) ) ) }
		aAdd( aOCboxOpT1, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs2 := u, cCbxOpcs2 ) }, aItnsOpcs, 50, 10, aOPnlRdT1[2], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs2" ) )			 										        
		
		aAdd( aOSayURLs, TSay():Create( aOPnlAuxT1[2], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
		aOSayURLs[2]:Hide()
		aAdd( aOURLsT1, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL2 := u, cURL2 ) }, aOPnlAuxT1[2], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL2 ) )
		aOURLsT1[2]:Hide()
		
		bAction := { || IIF( TRG030AVldUrl( cURL2 ), .T., .F. ) } 
		oBtnOk2 := TButton():New( 09, 195, STR0067, aOPnlAuxT1[2], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
		oBtnOk2:Hide()
	
		bChange := { || ( aOCboxVwT1[2]:SetItems( { "" } ), aOCboxChT1[2]:SetItems( { "" } ), ;
							IIF( aOCboxOpT1[2]:nAt == 2, ; 
							( aOCboxVwT1[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT1[2]:Show(), .T. ), ;
							IIF( aOCboxOpT1[2]:nAt == 3 , ;
								( aOCboxVwT1[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT1[2]:Show(), ;
								  aOCboxChT1[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 2 ) ) ), aOSayChart[2]:Show(), aOCboxChT1[2]:Show(), .T. ), .T. ) ) ) }
		aAdd( aOSayAlias, TSay():Create( aOPnlAuxT1[2], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
		aOSayAlias[2]:Hide()
		aAdd( aOCboxET1, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias2 := u, cCbxAlias2 ) }, aItnsAlias, 100, 10, aOPnlAuxT1[2], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias2" ) )
		aOCboxET1[2]:Hide()
	
		aAdd( aOSayView, TSay():Create( aOPnlAuxT1[2], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
		aOSayView[2]:Hide()
		aAdd( aOCboxVwT1, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews2 := u, cCbxViews2 ) }, { "" }, 100, 10, aOPnlAuxT1[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews2" ) )
		aOCboxVwT1[2]:Hide()

		aAdd( aOSayChart, TSay():Create( aOPnlAuxT1[2], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
		aOSayChart[2]:Hide()
		aAdd( aOCboxChT1, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart2 := u, cCbxChart2 ) }, { "" }, 140, 10, aOPnlAuxT1[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart2" ) )
		aOCboxChT1[2]:Hide()

	EndIf

	aOPnlRdT1[nX]:Refresh()
Next nX

RestArea( aAreaAO2 )
RestArea( aArea )

Return

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AMT2

Função para montar a o LAYOUT 2   

@sample		TRG030AMT2( oPanel, aCols )

@param		oPanel - Objeto panel do layout 2
			aCols - Array que traz a quantidade de colunas de cada linha do layout 2

@return		Nenhum 

@author		Thiago Tavares
@since		24/04/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030AMT2( oPanel, aCols )

Local aArea		 := GetArea()
Local aAreaAO2   := AO2->( GetArea() )
Local nX, nY     := 0
Local nLinhas    := Len( aCols )
Local nIdxCols   := 1
Local cCbxAlias1 := ""
Local cCbxAlias2 := ""
Local cCbxAlias3 := ""
Local cCbxViews1 := ""
Local cCbxViews2 := ""
Local cCbxViews3 := ""
Local cCbxChart1 := ""
Local cCbxChart2 := ""
Local cCbxChart3 := ""
Local cCbxOpcs1  := ""
Local cCbxOpcs2  := ""
Local cCbxOpcs3  := ""
Local cURL1      := Space(150)
Local cURL2      := Space(150)
Local cURL3      := Space(150)
Local oBtnOk1    := Nil
Local oBtnOk2    := Nil
Local oBtnOk3    := Nil
Local aOSayAlias := {} 
Local aOSayURLs  := {}
Local aOSayView  := {} 
Local aOSayChart := {} 
Local aItnsVws   := {}
Local aItnsChts  := {}
Local aItnsAlias := { STR0054 }		// ".: Selecione"
Local aItnsOpcs  := { STR0054, STR0055, STR0056, STR0057, STR0058 }		// ".: Selecione"   "Tabela"   "Gráfico"    "WebBrowser"    "Calendário"
Local bChange    := { || .T. }
Local bAction    := { || .T. }

// montando o array das entidades com visao
DbSelectArea( "AO2" )		// controle de entidades
AO2->( DbGoTop() ) 
While !AO2->( EOF() )
	If AO2->AO2_WAVIEW == "1"
		aAdd( aItnsAlias, AO2->AO2_ENTID + " - " + AllTrim( Posicione( "SX2", 1, AO2->AO2_ENTID, "X2NOME()" ) ) )
	EndIf
	AO2->( DbSkip() )
End

oLMainT2 := FWLayer():New()										// instanciado layer principal
oLMainT2:Init( oPanel, .F. )									// inicializado layer principal
oLMainT2:AddCollumn( "BOX_FULL", 100, .F. ) 					// adicionado box principal 
oColFULLT2 := oLMainT2:getColPanel( "BOX_FULL", Nil )			// instanciado box principal

oLInteT2 := FWLayer():New()										// instanciado layer interno
oLInteT2:Init( oColFULLT2, .F. )								// inicializado layer interno a partir do box principal

For nX := 1 To nLinhas

	aAdd( aNLinesT2, "LN" + AllTrim( Str( nX ) ) )
	oLInteT2:AddLine( aNLinesT2[nX], Round( 100 / nLinhas, 0), .F., Nil ) 
	aAdd( aOLinesT2, oLInteT2:getLinePanel( aNLinesT2[nX] ) )
	
	aAdd( aOLayersT2, FWLayer():New() )	
	aOLayersT2[nX]:Init( aOLinesT2[nX], .T. )		 

	// se a linha tiver mais de um coluna, criar os BOX
	If aCols[nX] > 1
		For nY := 1 To aCols[nX]  
			
			aAdd( aNColsT2, "BOX" + AllTrim( Str( nY ) ) + "_LN" + AllTrim( Str( nX ) ) )
			aOLayersT2[nX]:AddCollumn( aNColsT2[nIdxCols], Round( 100 / aCols[nX], 0), .F. ) 	 
			aAdd( aOColsT2, aOLayersT2[nX]:GetColPanel( aNColsT2[nIdxCols], Nil ) )

			aAdd( aOPnlRdT2, TPanelCss():New( 02, 02, "", aOColsT2[nIdxCols], , .F. , .F. , , , aOColsT2[nIdxCols]:nWidth, aOColsT2[nIdxCols]:nHeight, .T., .F. ) )
			aOPnlRdT2[nIdxCols]:Align := CONTROL_ALIGN_ALLCLIENT    
			aOPnlRdT2[nIdxCols]:setCSS( cStyle )

			@ 10,10 SAY STR0060 FONT oBold OF aOPnlRdT2[nIdxCols] PIXEL SIZE 80,10			// "Opção:"

			aAdd( aOPnlAuxT2, TPanel():New( 20, 1, "", aOPnlRdT2[nIdxCols], , , , , , aOPnlRdT2[nIdxCols]:nWidth-1, aOPnlRdT2[nIdxCols]:nHeight-20, .F., .F. ) )
		
			If nIdxCols == 1

				// combobox opções
				bChange := { || ( aOSayURLs[1]:Hide(), aOURLsT2[1]:Hide(), oBtnOk1:Hide(), aOSayAlias[1]:Hide(), aOCboxET2[1]:Hide(), aOCboxET2[1]:nAt := 1, aOSayView[1]:Hide(), aOCboxVwT2[1]:Hide(), aOCboxVwT2[1]:nAt := 1, aOSayChart[1]:Hide(), aOCboxChT2[1]:Hide(), aOCboxChT2[1]:nAt := 1, ;
								  IIF( aOCboxOpT2[1]:nAt == 4, ;
								  	  ( aOSayURLs[1]:Show(), aOURLsT2[1]:Show(), oBtnOk1:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT2[1]:nAt == 3 .Or. aOCboxOpT2[1]:nAt == 2, ; 
								  	  	  ( aOSayAlias[1]:Show(), aOCboxET2[1]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT2, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs1 := u, cCbxOpcs1 ) }, aItnsOpcs, 50, 10, aOPnlRdT2[1], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs1" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT2[1], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[1]:Hide()
				aAdd( aOURLsT2, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL1 := u, cURL1 ) }, aOPnlAuxT2[1], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL1 ) )
				aOURLsT2[1]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL1 ), .T., .F. ) } 
				oBtnOk1 := TButton():New( 09, 195, STR0067, aOPnlAuxT2[1], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk1:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT2[1]:SetItems( { "" } ), aOCboxChT2[1]:SetItems( { "" } ), ;
									IIF( aOCboxOpT2[1]:nAt == 2, ; 
									( aOCboxVwT2[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT2[1]:Show(), .T. ), ;
									IIF( aOCboxOpT2[1]:nAt == 3 , ;
										( aOCboxVwT2[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT2[1]:Show(), ;
										  aOCboxChT2[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 2 ) ) ), aOSayChart[1]:Show(), aOCboxChT2[1]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT2[1], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[1]:Hide()
				aAdd( aOCboxET2, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias1 := u, cCbxAlias1 ) }, aItnsAlias, 100, 10, aOPnlAuxT2[1], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias1" ) )
				aOCboxET2[1]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT2[1], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[1]:Hide()
				aAdd( aOCboxVwT2, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews1 := u, cCbxViews1 ) }, { "" }, 100, 10, aOPnlAuxT2[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews1" ) )
				aOCboxVwT2[1]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT2[1], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[1]:Hide()
				aAdd( aOCboxChT2, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart1 := u, cCbxChart1 ) }, { "" }, 140, 10, aOPnlAuxT2[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart1" ) )
				aOCboxChT2[1]:Hide()

			ElseIf nIdxCols == 2

				// combobox opções
				bChange := { || ( aOSayURLs[2]:Hide(), aOURLsT2[2]:Hide(), oBtnOk2:Hide(), aOSayAlias[2]:Hide(), aOCboxET2[2]:Hide(), aOCboxET2[2]:nAt := 1, aOSayView[2]:Hide(), aOCboxVwT2[2]:Hide(), aOCboxVwT2[2]:nAt := 1, aOSayChart[2]:Hide(), aOCboxChT2[2]:Hide(), aOCboxChT2[2]:nAt := 1, ;
								  IIF( aOCboxOpT2[2]:nAt == 4, ;
								  	  ( aOSayURLs[2]:Show(), aOURLsT2[2]:Show(), oBtnOk2:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT2[2]:nAt == 3 .Or. aOCboxOpT2[2]:nAt == 2, ; 
								  	  	  ( aOSayAlias[2]:Show(), aOCboxET2[2]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT2, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs2 := u, cCbxOpcs2 ) }, aItnsOpcs, 50, 10, aOPnlRdT2[2], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs2" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT2[2], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[2]:Hide()
				aAdd( aOURLsT2, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL2 := u, cURL2 ) }, aOPnlAuxT2[2], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL2 ) )
				aOURLsT2[2]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL2 ), .T., .F. ) } 
				oBtnOk2 := TButton():New( 09, 195, STR0067, aOPnlAuxT2[2], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk2:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT2[2]:SetItems( { "" } ), aOCboxChT2[2]:SetItems( { "" } ), ;
									IIF( aOCboxOpT2[2]:nAt == 2, ; 
									( aOCboxVwT2[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT2[2]:Show(), .T. ), ;
									IIF( aOCboxOpT2[2]:nAt == 3 , ;
										( aOCboxVwT2[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT2[2]:Show(), ;
										  aOCboxChT2[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 2 ) ) ), aOSayChart[2]:Show(), aOCboxChT2[2]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT2[2], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[2]:Hide()
				aAdd( aOCboxET2, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias2 := u, cCbxAlias2 ) }, aItnsAlias, 100, 10, aOPnlAuxT2[2], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias2" ) )
				aOCboxET2[2]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT2[2], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[2]:Hide()
				aAdd( aOCboxVwT2, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews2 := u, cCbxViews2 ) }, { "" }, 100, 10, aOPnlAuxT2[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews2" ) )
				aOCboxVwT2[2]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT2[2], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[2]:Hide()
				aAdd( aOCboxChT2, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart2 := u, cCbxChart2 ) }, { "" }, 140, 10, aOPnlAuxT2[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart2" ) )
				aOCboxChT2[2]:Hide()

			Else

				// combobox opções
				bChange := { || ( aOSayURLs[3]:Hide(), aOURLsT2[3]:Hide(), oBtnOk3:Hide(), aOSayAlias[3]:Hide(), aOCboxET2[3]:Hide(), aOCboxET2[3]:nAt := 1, aOSayView[3]:Hide(), aOCboxVwT2[3]:Hide(), aOCboxVwT2[3]:nAt := 1, aOSayChart[3]:Hide(), aOCboxChT2[3]:Hide(), aOCboxChT2[3]:nAt := 1, ;
								  IIF( aOCboxOpT2[3]:nAt == 4, ;
								  	  ( aOSayURLs[3]:Show(), aOURLsT2[3]:Show(), oBtnOk3:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT2[3]:nAt == 3 .Or. aOCboxOpT2[3]:nAt == 2, ; 
								  	  	  ( aOSayAlias[3]:Show(), aOCboxET2[3]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT2, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs3 := u, cCbxOpcs3 ) }, aItnsOpcs, 50, 10, aOPnlRdT2[3], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs3" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT2[3], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[3]:Hide()
				aAdd( aOURLsT2, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL3 := u, cURL3 ) }, aOPnlAuxT2[3], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL3 ) )
				aOURLsT2[3]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL3 ), .T., .F. ) } 
				oBtnOk3 := TButton():New( 09, 195, STR0067, aOPnlAuxT2[3], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )			// "&Validar"
				oBtnOk3:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT2[3]:SetItems( { "" } ), aOCboxChT2[3]:SetItems( { "" } ), ;
									IIF( aOCboxOpT2[3]:nAt == 2, ; 
									( aOCboxVwT2[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOSayView[3]:Show(), aOCboxVwT2[3]:Show(), .T. ), ;
									IIF( aOCboxOpT2[3]:nAt == 3 , ;
										( aOCboxVwT2[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOSayView[3]:Show(), aOCboxVwT2[3]:Show(), ;
										  aOCboxChT2[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 2 ) ) ), aOSayChart[3]:Show(), aOCboxChT2[3]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT2[3], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[3]:Hide()
				aAdd( aOCboxET2, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias3 := u, cCbxAlias3 ) }, aItnsAlias, 100, 10, aOPnlAuxT2[3], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias3" ) )
				aOCboxET2[3]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT2[3], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[3]:Hide()
				aAdd( aOCboxVwT2, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxViews3 ) }, { "" }, 100, 10, aOPnlAuxT2[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews3" ) )
				aOCboxVwT2[3]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT2[3], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[3]:Hide()
				aAdd( aOCboxChT2, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart3 := u, cCbxChart3 ) }, { "" }, 140, 10, aOPnlAuxT2[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart3" ) )
				aOCboxChT2[3]:Hide()

			EndIf
			
			aOPnlRdT2[nIdxCols]:Refresh()
			nIdxCols++
		Next nY
	Else	
		aAdd( aNColsT2, "BOX1_LN" + AllTrim( Str( nX ) ) )				
		aOLayersT2[nX]:AddCollumn( aNColsT2[nIdxCols], 100, .F. ) 	 
		aAdd( aOColsT2, aOLayersT2[nX]:GetColPanel( aNColsT2[nIdxCols], Nil ) )

		aAdd( aOPnlRdT2, TPanelCss():New( 02, 02, "", aOColsT2[nIdxCols], , .F. , .F. , , , aOColsT2[nIdxCols]:nWidth, aOColsT2[nIdxCols]:nHeight, .T., .F. ) )
		aOPnlRdT2[nIdxCols]:Align := CONTROL_ALIGN_ALLCLIENT    
		aOPnlRdT2[nIdxCols]:setCSS( cStyle )
	
		@ 10,10 SAY STR0060 FONT oBold OF aOPnlRdT2[nIdxCols] PIXEL SIZE 80,10			// "Opção:"

		aAdd( aOPnlAuxT2, TPanel():New( 20, 1, "", aOPnlRdT2[nIdxCols], , , , , , aOPnlRdT2[nIdxCols]:nWidth-1, aOPnlRdT2[nIdxCols]:nHeight-20, .F., .F. ) )

		If nIdxCols == 1

			// combobox opções
			bChange := { || ( aOSayURLs[1]:Hide(), aOURLsT2[1]:Hide(), oBtnOk1:Hide(), aOSayAlias[1]:Hide(), aOCboxET2[1]:Hide(), aOCboxET2[1]:nAt := 1, aOSayView[1]:Hide(), aOCboxVwT2[1]:Hide(), aOCboxVwT2[1]:nAt := 1, aOSayChart[1]:Hide(), aOCboxChT2[1]:Hide(), aOCboxChT2[1]:nAt := 1, ;
							  IIF( aOCboxOpT2[1]:nAt == 4, ;
							  	  ( aOSayURLs[1]:Show(), aOURLsT2[1]:Show(), oBtnOk1:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT2[1]:nAt == 3 .Or. aOCboxOpT2[1]:nAt == 2, ; 
							  	  	  ( aOSayAlias[1]:Show(), aOCboxET2[1]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT2, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs1 := u, cCbxOpcs1 ) }, aItnsOpcs, 50, 10, aOPnlRdT2[1], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs1" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT2[1], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[1]:Hide()
			aAdd( aOURLsT2, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL1 := u, cURL1 ) }, aOPnlAuxT2[1], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL1 ) )
			aOURLsT2[1]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL1 ), .T., .F. ) } 
			oBtnOk1 := TButton():New( 09, 195, STR0067, aOPnlAuxT2[1], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk1:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT2[1]:SetItems( { "" } ), aOCboxChT2[1]:SetItems( { "" } ), ;
								IIF( aOCboxOpT2[1]:nAt == 2, ; 
								( aOCboxVwT2[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT2[1]:Show(), .T. ), ;
								IIF( aOCboxOpT2[1]:nAt == 3 , ;
									( aOCboxVwT2[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT2[1]:Show(), ;
									  aOCboxChT2[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 2 ) ) ), aOSayChart[1]:Show(), aOCboxChT2[1]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT2[1], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[1]:Hide()
			aAdd( aOCboxET2, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias1 := u, cCbxAlias1 ) }, aItnsAlias, 100, 10, aOPnlAuxT2[1], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias1" ) )
			aOCboxET2[1]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT2[1], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[1]:Hide()
			aAdd( aOCboxVwT2, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews1 := u, cCbxViews1 ) }, { "" }, 100, 10, aOPnlAuxT2[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews1" ) )
			aOCboxVwT2[1]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT2[1], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[1]:Hide()
			aAdd( aOCboxChT2, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart1 := u, cCbxChart1 ) }, { "" }, 140, 10, aOPnlAuxT2[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart1" ) )
			aOCboxChT2[1]:Hide()

		ElseIf nIdxCols == 2

			// combobox opções
			bChange := { || ( aOSayURLs[2]:Hide(), aOURLsT2[2]:Hide(), oBtnOk2:Hide(), aOSayAlias[2]:Hide(), aOCboxET2[2]:Hide(), aOCboxET2[2]:nAt := 1, aOSayView[2]:Hide(), aOCboxVwT2[2]:Hide(), aOCboxVwT2[2]:nAt := 1, aOSayChart[2]:Hide(), aOCboxChT2[2]:Hide(), aOCboxChT2[2]:nAt := 1, ;
							  IIF( aOCboxOpT2[2]:nAt == 4, ;
							  	  ( aOSayURLs[2]:Show(), aOURLsT2[2]:Show(), oBtnOk2:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT2[2]:nAt == 3 .Or. aOCboxOpT2[2]:nAt == 2, ; 
							  	  	  ( aOSayAlias[2]:Show(), aOCboxET2[2]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT2, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs2 := u, cCbxOpcs2 ) }, aItnsOpcs, 50, 10, aOPnlRdT2[2], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs2" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT2[2], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[2]:Hide()
			aAdd( aOURLsT2, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL2 := u, cURL2 ) }, aOPnlAuxT2[2], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL2 ) )
			aOURLsT2[2]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL2 ), .T., .F. ) } 
			oBtnOk2 := TButton():New( 09, 195, STR0067, aOPnlAuxT2[2], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk2:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT2[2]:SetItems( { "" } ), aOCboxChT2[2]:SetItems( { "" } ), ;
								IIF( aOCboxOpT2[2]:nAt == 2, ; 
								( aOCboxVwT2[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT2[2]:Show(), .T. ), ;
								IIF( aOCboxOpT2[2]:nAt == 3 , ;
									( aOCboxVwT2[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT2[2]:Show(), ;
									  aOCboxChT2[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 2 ) ) ), aOSayChart[2]:Show(), aOCboxChT2[2]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT2[2], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[2]:Hide()
			aAdd( aOCboxET2, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias2 := u, cCbxAlias2 ) }, aItnsAlias, 100, 10, aOPnlAuxT2[2], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias2" ) )
			aOCboxET2[2]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT2[2], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[2]:Hide()
			aAdd( aOCboxVwT2, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews2 := u, cCbxViews2 ) }, { "" }, 100, 10, aOPnlAuxT2[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews2" ) )
			aOCboxVwT2[2]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT2[2], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[2]:Hide()
			aAdd( aOCboxChT2, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart2 := u, cCbxChart2 ) }, { "" }, 140, 10, aOPnlAuxT2[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart2" ) )
			aOCboxChT2[2]:Hide()

		Else

			// combobox opções
			bChange := { || ( aOSayURLs[3]:Hide(), aOURLsT3[3]:Hide(), oBtnOk3:Hide(), aOSayAlias[3]:Hide(), aOCboxET2[3]:Hide(), aOCboxET2[3]:nAt := 1, aOSayView[3]:Hide(), aOCboxVwT2[3]:Hide(), aOCboxVwT2[3]:nAt := 1, aOSayChart[3]:Hide(), aOCboxChT2[3]:Hide(), aOCboxChT2[3]:nAt := 1, ;
							  IIF( aOCboxOpT2[3]:nAt == 4, ;
							  	  ( aOSayURLs[3]:Show(), aOURLsT3[3]:Show(), oBtnOk3:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT2[3]:nAt == 3 .Or. aOCboxOpT2[3]:nAt == 2, ; 
							  	  	  ( aOSayAlias[3]:Show(), aOCboxET2[3]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT2, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs3 := u, cCbxOpcs3 ) }, aItnsOpcs, 50, 10, aOPnlRdT2[3], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs3" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT2[3], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[3]:Hide()
			aAdd( aOURLsT2, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL3 := u, cURL3 ) }, aOPnlAuxT2[3], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL3 ) )
			aOURLsT2[3]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL3 ), .T., .F. ) } 
			oBtnOk3 := TButton():New( 09, 195, STR0067, aOPnlAuxT2[3], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk3:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT2[3]:SetItems( { "" } ), aOCboxChT2[3]:SetItems( { "" } ), ;
								IIF( aOCboxOpT2[3]:nAt == 2, ; 
								( aOCboxVwT2[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOSayView[3]:Show(), aOCboxVwT2[3]:Show(), .T. ), ;
								IIF( aOCboxOpT2[3]:nAt == 3 , ;
									( aOCboxVwT2[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOSayView[3]:Show(), aOCboxVwT2[3]:Show(), ;
									  aOCboxChT2[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 2 ) ) ), aOSayChart[3]:Show(), aOCboxChT2[3]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT2[3], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[3]:Hide()
			aAdd( aOCboxET2, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias3 := u, cCbxAlias3 ) }, aItnsAlias, 100, 10, aOPnlAuxT2[3], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias3" ) )
			aOCboxET2[3]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT2[3], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[3]:Hide()
			aAdd( aOCboxVwT2, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxViews3 ) }, { "" }, 100, 10, aOPnlAuxT2[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews3" ) )
			aOCboxVwT2[3]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT2[3], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[3]:Hide()
			aAdd( aOCboxChT2, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart3 := u, cCbxChart3 ) }, { "" }, 140, 10, aOPnlAuxT2[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart3" ) )
			aOCboxChT2[3]:Hide()

		EndIf
		
		aOPnlRdT2[nIdxCols]:Refresh()
		nIdxCols++
	EndIf
	
Next nX

RestArea( aAreaAO2 )
RestArea( aArea )

Return Nil

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AMT3

Função para montar a o LAYOUT 3   

@sample		TRG030AMT3( oPanel, aCols )

@param		oPanel - Objeto panel do layout 3
			aCols - Array que traz a quantidade de colunas de cada linha do layout 3

@return		Nenhum 

@author		Thiago Tavares
@since		24/04/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030AMT3( oPanel, aCols )

Local aArea	   	 := GetArea()
Local aAreaAO2   := AO2->( GetArea() )
Local nX, nY     := 0
Local nLinhas    := Len( aCols )
Local nIdxCols   := 1
Local cCbxAlias1 := ""
Local cCbxAlias2 := ""
Local cCbxAlias3 := ""
Local cCbxAlias4 := ""
Local cCbxViews1 := ""
Local cCbxViews2 := ""
Local cCbxViews3 := ""
Local cCbxViews4 := ""
Local cCbxChart1 := ""
Local cCbxChart2 := ""
Local cCbxChart3 := ""
Local cCbxChart4 := ""
Local cCbxOpcs1  := ""
Local cCbxOpcs2  := ""
Local cCbxOpcs3  := ""
Local cCbxOpcs4  := ""
Local cURL1      := Space(150)
Local cURL2      := Space(150)
Local cURL3      := Space(150)
Local cURL4      := Space(150)
Local oBtnOk1    := Nil
Local oBtnOk2    := Nil
Local oBtnOk3    := Nil
Local oBtnOk4    := Nil
Local aOSayAlias := {} 
Local aOSayURLs  := {}
Local aOSayView  := {} 
Local aOSayChart := {} 
Local aItnsVws   := {}
Local aItnsChts  := {}
Local aItnsAlias := { STR0054 }		// ".: Selecione"
Local aItnsOpcs  := { STR0054, STR0055, STR0056, STR0057, STR0058 }		// ".: Selecione"   "Tabela"   "Gráfico"    "WebBrowser"    "Calendário"
Local bChange    := { || .T. }
Local bAction    := { || .T. }

// montando o array das entidades com visao
DbSelectArea( "AO2" )		// controle de entidades
AO2->( DbGoTop() ) 
While !AO2->( EOF() )
	If AO2->AO2_WAVIEW == "1"
		aAdd( aItnsAlias, AO2->AO2_ENTID + " - " + AllTrim( Posicione( "SX2", 1, AO2->AO2_ENTID, "X2NOME()" ) ) )
	EndIf
	AO2->( DbSkip() )
End

oLMainT3 := FWLayer():New()														// instanciado layer principal
oLMainT3:Init( oPanel, .F. )													// inicializado layer principal
oLMainT3:AddCollumn( "BOX_FULL", 100, .F. ) 									// adicionado box principal 
oColFULLT3 := oLMainT3:getColPanel( "BOX_FULL", Nil )						// instanciado box principal

oLInteT3 := FWLayer():New()														// instanciado layer interno
oLInteT3:Init( oColFULLT3, .F. )												// inicializado layer interno a partir do box principal

For nX := 1 To nLinhas

	aAdd( aNLinesT3, "LN" + AllTrim( Str( nX ) ) )
	oLInteT3:AddLine( aNLinesT3[nX], Round( 100 / nLinhas, 0), .F., Nil ) 
	aAdd( aOLinesT3, oLInteT3:getLinePanel( aNLinesT3[nX] ) )
	
	aAdd( aOLayersT3, FWLayer():New() )	
	aOLayersT3[nX]:Init( aOLinesT3[nX], .T. )		 
	
	// se a linha tiver mais de um coluna, criar os BOX
	If aCols[nX] > 1
		For nY := 1 To aCols[nX]  
			
			aAdd( aNColsT3, "BOX" + AllTrim( Str( nY ) ) + "_LN" + AllTrim( Str( nX ) ) )
			aOLayersT3[nX]:AddCollumn( aNColsT3[nIdxCols], Round( 100 / aCols[nX], 0), .F. ) 	 
			aAdd( aOColsT3, aOLayersT3[nX]:GetColPanel( aNColsT3[nIdxCols], Nil ) )

			aAdd( aOPnlRdT3, TPanelCss():New( 02, 02, "", aOColsT3[nIdxCols], , .F. , .F. , , , aOColsT3[nIdxCols]:nWidth, aOColsT3[nIdxCols]:nHeight, .T., .F. ) )
			aOPnlRdT3[nIdxCols]:Align := CONTROL_ALIGN_ALLCLIENT    
			aOPnlRdT3[nIdxCols]:setCSS( cStyle )

			@ 10,10 SAY STR0060 FONT oBold OF aOPnlRdT3[nIdxCols] PIXEL SIZE 80,10			// "Opção:"
	
			aAdd( aOPnlAuxT3, TPanel():New( 20, 1, "", aOPnlRdT3[nIdxCols], , , , , , aOPnlRdT3[nIdxCols]:nWidth-1, aOPnlRdT3[nIdxCols]:nHeight-20, .F., .F. ) )
	
			If nIdxCols == 1
			
				// combobox opções
				bChange := { || ( aOSayURLs[1]:Hide(), aOURLsT3[1]:Hide(), oBtnOk1:Hide(), aOSayAlias[1]:Hide(), aOCboxET3[1]:Hide(), aOCboxET3[1]:nAt := 1, aOSayView[1]:Hide(), aOCboxVwT3[1]:Hide(), aOCboxVwT3[1]:nAt := 1, aOSayChart[1]:Hide(), aOCboxChT3[1]:Hide(), aOCboxChT3[1]:nAt := 1, ;
								  IIF( aOCboxOpT3[1]:nAt == 4, ;
								  	  ( aOSayURLs[1]:Show(), aOURLsT3[1]:Show(), oBtnOk1:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT3[1]:nAt == 3 .Or. aOCboxOpT3[1]:nAt == 2, ; 
								  	  	  ( aOSayAlias[1]:Show(), aOCboxET3[1]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT3, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs1 := u, cCbxOpcs1 ) }, aItnsOpcs, 50, 10, aOPnlRdT3[1], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs1" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT3[1], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[1]:Hide()
				aAdd( aOURLsT3, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL1 := u, cURL1 ) }, aOPnlAuxT3[1], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL1 ) )
				aOURLsT3[1]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL1 ), .T., .F. ) } 
				oBtnOk1 := TButton():New( 09, 195, STR0067, aOPnlAuxT3[1], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk1:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT3[1]:SetItems( { "" } ), aOCboxChT3[1]:SetItems( { "" } ), ;
									IIF( aOCboxOpT3[1]:nAt == 2, ; 
									( aOCboxVwT3[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT3[1]:Show(), .T. ), ;
									IIF( aOCboxOpT3[1]:nAt == 3 , ;
										( aOCboxVwT3[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT3[1]:Show(), ;
										  aOCboxChT3[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 2 ) ) ), aOSayChart[1]:Show(), aOCboxChT3[1]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT3[1], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[1]:Hide()
				aAdd( aOCboxET3, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias1 := u, cCbxAlias1 ) }, aItnsAlias, 100, 10, aOPnlAuxT3[1], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias1" ) )
				aOCboxET3[1]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT3[1], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[1]:Hide()
				aAdd( aOCboxVwT3, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews1 := u, cCbxViews1 ) }, { "" }, 100, 10, aOPnlAuxT3[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews1" ) )
				aOCboxVwT3[1]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT3[1], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[1]:Hide()
				aAdd( aOCboxChT3, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart1 := u, cCbxChart1 ) }, { "" }, 140, 10, aOPnlAuxT3[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart1" ) )
				aOCboxChT3[1]:Hide()
	
			ElseIf nIdxCols == 2

				// combobox opções
				bChange := { || ( aOSayURLs[2]:Hide(), aOURLsT3[2]:Hide(), oBtnOk2:Hide(), aOSayAlias[2]:Hide(), aOCboxET3[2]:Hide(), aOCboxET3[2]:nAt := 1, aOSayView[2]:Hide(), aOCboxVwT3[2]:Hide(), aOCboxVwT3[2]:nAt := 1, aOSayChart[2]:Hide(), aOCboxChT3[2]:Hide(), aOCboxChT3[2]:nAt := 1, ;
								  IIF( aOCboxOpT3[2]:nAt == 4, ;
								  	  ( aOSayURLs[2]:Show(), aOURLsT3[2]:Show(), oBtnOk2:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT3[2]:nAt == 3 .Or. aOCboxOpT3[2]:nAt == 2, ; 
								  	  	  ( aOSayAlias[2]:Show(), aOCboxET3[2]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT3, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs2 := u, cCbxOpcs2 ) }, aItnsOpcs, 50, 10, aOPnlRdT3[2], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs2" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT3[2], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[2]:Hide()
				aAdd( aOURLsT3, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL2 := u, cURL2 ) }, aOPnlAuxT3[2], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL2 ) )
				aOURLsT3[2]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL2 ), .T., .F. ) } 
				oBtnOk2 := TButton():New( 09, 195, STR0067, aOPnlAuxT3[2], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk2:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT3[2]:SetItems( { "" } ), aOCboxChT3[2]:SetItems( { "" } ), ;
									IIF( aOCboxOpT3[2]:nAt == 2, ; 
									( aOCboxVwT3[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT3[2]:Show(), .T. ), ;
									IIF( aOCboxOpT3[2]:nAt == 3 , ;
										( aOCboxVwT3[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT3[2]:Show(), ;
										  aOCboxChT3[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 2 ) ) ), aOSayChart[2]:Show(), aOCboxChT3[2]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT3[2], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[2]:Hide()
				aAdd( aOCboxET3, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias2 := u, cCbxAlias2 ) }, aItnsAlias, 100, 10, aOPnlAuxT3[2], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias2" ) )
				aOCboxET3[2]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT3[2], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[2]:Hide()
				aAdd( aOCboxVwT3, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews2 := u, cCbxViews2 ) }, { "" }, 100, 10, aOPnlAuxT3[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews2" ) )
				aOCboxVwT3[2]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT3[2], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[2]:Hide()
				aAdd( aOCboxChT3, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart2 := u, cCbxChart2 ) }, { "" }, 140, 10, aOPnlAuxT3[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart2" ) )
				aOCboxChT3[2]:Hide()

			ElseIf nIdxCols == 3

				// combobox opções
				bChange := { || ( aOSayURLs[3]:Hide(), aOURLsT3[3]:Hide(), oBtnOk3:Hide(), aOSayAlias[3]:Hide(), aOCboxET3[3]:Hide(), aOCboxET3[3]:nAt := 1, aOSayView[3]:Hide(), aOCboxVwT3[3]:Hide(), aOCboxVwT3[3]:nAt := 1, aOSayChart[3]:Hide(), aOCboxChT3[3]:Hide(), aOCboxChT3[3]:nAt := 1, ;
								  IIF( aOCboxOpT3[3]:nAt == 4, ;
								  	  ( aOSayURLs[3]:Show(), aOURLsT3[3]:Show(), oBtnOk3:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT3[3]:nAt == 3 .Or. aOCboxOpT3[3]:nAt == 2, ; 
								  	  	  ( aOSayAlias[3]:Show(), aOCboxET3[3]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT3, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs3 := u, cCbxOpcs3 ) }, aItnsOpcs, 50, 10, aOPnlRdT3[3], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs3" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT3[3], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[3]:Hide()
				aAdd( aOURLsT3, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL3 := u, cURL3 ) }, aOPnlAuxT3[3], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL3 ) )
				aOURLsT3[3]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL3 ), .T., .F. ) } 
				oBtnOk3 := TButton():New( 09, 195, STR0067, aOPnlAuxT3[3], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk3:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT3[3]:SetItems( { "" } ), aOCboxChT3[3]:SetItems( { "" } ), ;
									IIF( aOCboxOpT3[3]:nAt == 2, ; 
									( aOCboxVwT3[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOSayView[3]:Show(), aOCboxVwT3[3]:Show(), .T. ), ;
									IIF( aOCboxOpT3[3]:nAt == 3 , ;
										( aOCboxVwT3[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOCboxVwT3[3]:Select( 1 ), aOSayView[3]:Show(), aOCboxVwT3[3]:Show(), ;
										  aOCboxChT3[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 2 ) ) ), aOCboxChT3[3]:Select( 1 ), aOSayChart[3]:Show(), aOCboxChT3[3]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT3[3], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[3]:Hide()
				aAdd( aOCboxET3, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias3 := u, cCbxAlias3 ) }, aItnsAlias, 100, 10, aOPnlAuxT3[3], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias3" ) )
				aOCboxET3[3]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT3[3], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[3]:Hide()
				aAdd( aOCboxVwT3, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxViews3 ) }, { "" }, 100, 10, aOPnlAuxT3[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews3" ) )
				aOCboxVwT3[3]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT3[3], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[3]:Hide()
				aAdd( aOCboxChT3, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxChart3 ) }, { "" }, 140, 10, aOPnlAuxT3[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart3" ) )
				aOCboxChT3[3]:Hide()

			Else

				// combobox opções
				bChange := { || ( aOSayURLs[4]:Hide(), aOURLsT3[4]:Hide(), oBtnOk4:Hide(), aOSayAlias[4]:Hide(), aOCboxET3[4]:Hide(), aOCboxET3[4]:nAt := 1, aOSayView[4]:Hide(), aOCboxVwT3[4]:Hide(), aOCboxVwT3[4]:nAt := 1, aOSayChart[4]:Hide(), aOCboxChT3[4]:Hide(), aOCboxChT3[4]:nAt := 1, ;
								  IIF( aOCboxOpT3[4]:nAt == 4, ;
								  	  ( aOSayURLs[4]:Show(), aOURLsT3[4]:Show(), oBtnOk4:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT3[4]:nAt == 3 .Or. aOCboxOpT3[4]:nAt == 2, ; 
								  	  	  ( aOSayAlias[4]:Show(), aOCboxET3[4]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT3, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs4 := u, cCbxOpcs4 ) }, aItnsOpcs, 50, 10, aOPnlRdT3[4], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs4" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT3[4], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[4]:Hide()
				aAdd( aOURLsT3, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL4 := u, cURL4 ) }, aOPnlAuxT3[4], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL4 ) )
				aOURLsT3[4]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL4 ), .T., .F. ) } 
				oBtnOk4 := TButton():New( 09, 195, STR0067, aOPnlAuxT3[4], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk4:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT3[4]:SetItems( { "" } ), aOCboxChT3[4]:SetItems( { "" } ), ;
									IIF( aOCboxOpT3[4]:nAt == 2, ; 
									( aOCboxVwT3[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 1 ) ) ), aOSayView[4]:Show(), aOCboxVwT3[4]:Show(), .T. ), ;
									IIF( aOCboxOpT3[4]:nAt == 3 , ;
										( aOCboxVwT3[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 1 ) ) ), aOSayView[4]:Show(), aOCboxVwT3[4]:Show(), ;
										  aOCboxChT3[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 2 ) ) ), aOSayChart[4]:Show(), aOCboxChT3[4]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT3[4], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[4]:Hide()
				aAdd( aOCboxET3, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias4 := u, cCbxAlias4 ) }, aItnsAlias, 100, 10, aOPnlAuxT3[4], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias4" ) )
				aOCboxET3[4]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT3[4], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[4]:Hide()
				aAdd( aOCboxVwT3, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews4 := u, cCbxViews4 ) }, { "" }, 100, 10, aOPnlAuxT3[4], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews4" ) )
				aOCboxVwT3[4]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT3[4], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[4]:Hide()
				aAdd( aOCboxChT3, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart4 := u, cCbxChart4 ) }, { "" }, 140, 10, aOPnlAuxT3[4], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart4" ) )
				aOCboxChT3[4]:Hide()

			EndIf
			
			aOPnlRdT3[nIdxCols]:Refresh()
			nIdxCols++
		Next nY
	Else	
		aAdd( aNColsT3, "BOX1_LN" + AllTrim( Str( nX ) ) )				
		aOLayersT3[nX]:AddCollumn( aNColsT3[nIdxCols], 100, .F. ) 	 
		aAdd( aOColsT3, aOLayersT3[nX]:GetColPanel( aNColsT3[nIdxCOls], Nil ) )

		aAdd( aOPnlRdT3, TPanelCss():New( 02, 02, "", aOColsT3[nIdxCols], , .F. , .F. , , , aOColsT3[nIdxCols]:nWidth, aOColsT3[nIdxCols]:nHeight, .T., .F. ) )
		aOPnlRdT3[nIdxCols]:Align := CONTROL_ALIGN_ALLCLIENT    
		aOPnlRdT3[nIdxCols]:setCSS( cStyle )

		@ 10,10 SAY STR0060 FONT oBold OF aOPnlRdT3[nIdxCols] PIXEL SIZE 80,10			// "Opção:"

		aAdd( aOPnlAuxT3, TPanel():New( 20, 1, "", aOPnlRdT3[nIdxCols], , , , , , aOPnlRdT3[nIdxCols]:nWidth-1, aOPnlRdT3[nIdxCols]:nHeight-20, .F., .F. ) )
	
		If nIdxCols == 1
			
			// combobox opções
			bChange := { || ( aOSayURLs[1]:Hide(), aOURLsT3[1]:Hide(), oBtnOk1:Hide(), aOSayAlias[1]:Hide(), aOCboxET3[1]:Hide(), aOCboxET3[1]:nAt := 1, aOSayView[1]:Hide(), aOCboxVwT3[1]:Hide(), aOCboxVwT3[1]:nAt := 1, aOSayChart[1]:Hide(), aOCboxChT3[1]:Hide(), aOCboxChT3[1]:nAt := 1, ;
							  IIF( aOCboxOpT3[1]:nAt == 4, ;
							  	  ( aOSayURLs[1]:Show(), aOURLsT3[1]:Show(), oBtnOk1:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT3[1]:nAt == 3 .Or. aOCboxOpT3[1]:nAt == 2, ; 
							  	  	  ( aOSayAlias[1]:Show(), aOCboxET3[1]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT3, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs1 := u, cCbxOpcs1 ) }, aItnsOpcs, 50, 10, aOPnlRdT3[1], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs1" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT3[1], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[1]:Hide()
			aAdd( aOURLsT3, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL1 := u, cURL1 ) }, aOPnlAuxT3[1], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL1 ) )
			aOURLsT3[1]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL1 ), .T., .F. ) } 
			oBtnOk1 := TButton():New( 09, 195, STR0067, aOPnlAuxT3[1], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk1:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT3[1]:SetItems( { "" } ), aOCboxChT3[1]:SetItems( { "" } ), ;
								IIF( aOCboxOpT3[1]:nAt == 2, ; 
								( aOCboxVwT3[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT3[1]:Show(), .T. ), ;
								IIF( aOCboxOpT3[1]:nAt == 3 , ;
									( aOCboxVwT3[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT3[1]:Show(), ;
									  aOCboxChT3[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 2 ) ) ), aOSayChart[1]:Show(), aOCboxChT3[1]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT3[1], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[1]:Hide()
			aAdd( aOCboxET3, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias1 := u, cCbxAlias1 ) }, aItnsAlias, 100, 10, aOPnlAuxT3[1], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias1" ) )
			aOCboxET3[1]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT3[1], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[1]:Hide()
			aAdd( aOCboxVwT3, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews1 := u, cCbxViews1 ) }, { "" }, 100, 10, aOPnlAuxT3[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews1" ) )
			aOCboxVwT3[1]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT3[1], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[1]:Hide()
			aAdd( aOCboxChT3, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart1 := u, cCbxChart1 ) }, { "" }, 140, 10, aOPnlAuxT3[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart1" ) )
			aOCboxChT3[1]:Hide()

		ElseIf nIdxCols == 2

			// combobox opções
			bChange := { || ( aOSayURLs[2]:Hide(), aOURLsT3[2]:Hide(), oBtnOk2:Hide(), aOSayAlias[2]:Hide(), aOCboxET3[2]:Hide(), aOCboxET3[2]:nAt := 1, aOSayView[2]:Hide(), aOCboxVwT3[2]:Hide(), aOCboxVwT3[2]:nAt := 1, aOSayChart[2]:Hide(), aOCboxChT3[2]:Hide(), aOCboxChT3[2]:nAt := 1, ;
							  IIF( aOCboxOpT3[2]:nAt == 4, ;
							  	  ( aOSayURLs[2]:Show(), aOURLsT3[2]:Show(), oBtnOk2:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT3[2]:nAt == 3 .Or. aOCboxOpT3[2]:nAt == 2, ; 
							  	  	  ( aOSayAlias[2]:Show(), aOCboxET3[2]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT3, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs2 := u, cCbxOpcs2 ) }, aItnsOpcs, 50, 10, aOPnlRdT3[2], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs2" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT3[2], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[2]:Hide()
			aAdd( aOURLsT3, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL2 := u, cURL2 ) }, aOPnlAuxT3[2], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL2 ) )
			aOURLsT3[2]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL2 ), .T., .F. ) } 
			oBtnOk2 := TButton():New( 09, 195, STR0067, aOPnlAuxT3[2], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk2:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT3[2]:SetItems( { "" } ), aOCboxChT3[2]:SetItems( { "" } ), ;
								IIF( aOCboxOpT3[2]:nAt == 2, ; 
								( aOCboxVwT3[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT3[2]:Show(), .T. ), ;
								IIF( aOCboxOpT3[2]:nAt == 3 , ;
									( aOCboxVwT3[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT3[2]:Show(), ;
									  aOCboxChT3[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 2 ) ) ), aOSayChart[2]:Show(), aOCboxChT3[2]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT3[2], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[2]:Hide()
			aAdd( aOCboxET3, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias2 := u, cCbxAlias2 ) }, aItnsAlias, 100, 10, aOPnlAuxT3[2], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias2" ) )
			aOCboxET3[2]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT3[2], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[2]:Hide()
			aAdd( aOCboxVwT3, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews2 := u, cCbxViews2 ) }, { "" }, 100, 10, aOPnlAuxT3[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews2" ) )
			aOCboxVwT3[2]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT3[2], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[2]:Hide()
			aAdd( aOCboxChT3, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart2 := u, cCbxChart2 ) }, { "" }, 140, 10, aOPnlAuxT3[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart2" ) )
			aOCboxChT3[2]:Hide()

		ElseIf nIdxCols == 3

			// combobox opções
			bChange := { || ( aOSayURLs[3]:Hide(), aOURLsT3[3]:Hide(), oBtnOk3:Hide(), aOSayAlias[3]:Hide(), aOCboxET3[3]:Hide(), aOCboxET3[3]:nAt := 1, aOSayView[3]:Hide(), aOCboxVwT3[3]:Hide(), aOCboxVwT3[3]:nAt := 1, aOSayChart[3]:Hide(), aOCboxChT3[3]:Hide(), aOCboxChT3[3]:nAt := 1, ;
							  IIF( aOCboxOpT3[3]:nAt == 4, ;
							  	  ( aOSayURLs[3]:Show(), aOURLsT3[3]:Show(), oBtnOk3:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT3[3]:nAt == 3 .Or. aOCboxOpT3[3]:nAt == 2, ; 
							  	  	  ( aOSayAlias[3]:Show(), aOCboxET3[3]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT3, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs3 := u, cCbxOpcs3 ) }, aItnsOpcs, 50, 10, aOPnlRdT3[3], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs3" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT3[3], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[3]:Hide()
			aAdd( aOURLsT3, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL3 := u, cURL3 ) }, aOPnlAuxT3[3], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL3 ) )
			aOURLsT3[3]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL3 ), .T., .F. ) } 
			oBtnOk3 := TButton():New( 09, 195, STR0067, aOPnlAuxT3[3], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk3:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT3[3]:SetItems( { "" } ), aOCboxChT3[3]:SetItems( { "" } ), ;
								IIF( aOCboxOpT3[3]:nAt == 2, ; 
								( aOCboxVwT3[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOSayView[3]:Show(), aOCboxVwT3[3]:Show(), .T. ), ;
								IIF( aOCboxOpT3[3]:nAt == 3 , ;
									( aOCboxVwT3[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOCboxVwT3[3]:Select( 1 ), aOSayView[3]:Show(), aOCboxVwT3[3]:Show(), ;
									  aOCboxChT3[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 2 ) ) ), aOCboxChT3[3]:Select( 1 ), aOSayChart[3]:Show(), aOCboxChT3[3]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT3[3], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[3]:Hide()
			aAdd( aOCboxET3, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias3 := u, cCbxAlias3 ) }, aItnsAlias, 100, 10, aOPnlAuxT3[3], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias3" ) )
			aOCboxET3[3]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT3[3], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[3]:Hide()
			aAdd( aOCboxVwT3, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxViews3 ) }, { "" }, 100, 10, aOPnlAuxT3[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews3" ) )
			aOCboxVwT3[3]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT3[3], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[3]:Hide()
			aAdd( aOCboxChT3, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxChart3 ) }, { "" }, 140, 10, aOPnlAuxT3[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart3" ) )
			aOCboxChT3[3]:Hide()

		Else

			// combobox opções
			bChange := { || ( aOSayURLs[4]:Hide(), aOURLsT3[4]:Hide(), oBtnOk4:Hide(), aOSayAlias[4]:Hide(), aOCboxET3[4]:Hide(), aOCboxET3[4]:nAt := 1, aOSayView[4]:Hide(), aOCboxVwT3[4]:Hide(), aOCboxVwT3[4]:nAt := 1, aOSayChart[4]:Hide(), aOCboxChT3[4]:Hide(), aOCboxChT3[4]:nAt := 1, ;
							  IIF( aOCboxOpT3[4]:nAt == 4, ;
							  	  ( aOSayURLs[4]:Show(), aOURLsT3[4]:Show(), oBtnOk4:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT3[4]:nAt == 3 .Or. aOCboxOpT3[4]:nAt == 2, ; 
							  	  	  ( aOSayAlias[4]:Show(), aOCboxET3[4]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT3, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs4 := u, cCbxOpcs4 ) }, aItnsOpcs, 50, 10, aOPnlRdT3[4], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs4" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT3[4], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[4]:Hide()
			aAdd( aOURLsT3, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL4 := u, cURL4 ) }, aOPnlAuxT3[4], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL4 ) )
			aOURLsT3[4]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL4 ), .T., .F. ) } 
			oBtnOk4 := TButton():New( 09, 195, STR0067, aOPnlAuxT3[4], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk4:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT3[4]:SetItems( { "" } ), aOCboxChT3[4]:SetItems( { "" } ), ;
								IIF( aOCboxOpT3[4]:nAt == 2, ; 
								( aOCboxVwT3[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 1 ) ) ), aOSayView[4]:Show(), aOCboxVwT3[4]:Show(), .T. ), ;
								IIF( aOCboxOpT3[4]:nAt == 3 , ;
									( aOCboxVwT3[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 1 ) ) ), aOSayView[4]:Show(), aOCboxVwT3[4]:Show(), ;
									  aOCboxChT3[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 2 ) ) ), aOSayChart[4]:Show(), aOCboxChT3[4]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT3[4], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[4]:Hide()
			aAdd( aOCboxET3, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias4 := u, cCbxAlias4 ) }, aItnsAlias, 100, 10, aOPnlAuxT3[4], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias4" ) )
			aOCboxET3[4]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT3[4], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[4]:Hide()
			aAdd( aOCboxVwT3, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews4 := u, cCbxViews4 ) }, { "" }, 100, 10, aOPnlAuxT3[4], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews4" ) )
			aOCboxVwT3[4]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT3[4], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[4]:Hide()
			aAdd( aOCboxChT3, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart4 := u, cCbxChart4 ) }, { "" }, 140, 10, aOPnlAuxT3[4], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart4" ) )
			aOCboxChT3[4]:Hide()

		EndIf
		
		aOPnlRdT3[nIdxCols]:Refresh()
		nIdxCols++
	EndIf
	
Next nX

RestArea( aAreaAO2 )
RestArea( aArea )

Return Nil

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AMT4

Função para montar a o LAYOUT 4   

@sample		TRG030AMT4( oPanel, aCols )

@param		oPanel - Objeto panel do layout 4
			aCols - Array que traz a quantidade de colunas de cada linha do layout 4

@return		Nenhum 

@author		Thiago Tavares
@since		24/04/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030AMT4( oPanel, aCols )

Local aArea	   	 := GetArea()
Local aAreaAO2   := AO2->( GetArea() )
Local nX, nY     := 0
Local nLinhas    := Len( aCols )
Local nIdxCols   := 1
Local cCbxAlias1 := ""
Local cCbxAlias2 := ""
Local cCbxAlias3 := ""
Local cCbxViews1 := ""
Local cCbxViews2 := ""
Local cCbxViews3 := ""
Local cCbxChart1 := ""
Local cCbxChart2 := ""
Local cCbxChart3 := ""
Local cCbxOpcs1  := ""
Local cCbxOpcs2  := ""
Local cCbxOpcs3  := ""
Local cURL1      := Space(150)
Local cURL2      := Space(150)
Local cURL3      := Space(150)
Local oBtnOk1    := Nil
Local oBtnOk2    := Nil
Local oBtnOk3    := Nil
Local aOSayAlias := {} 
Local aOSayURLs  := {}
Local aOSayView  := {} 
Local aOSayChart := {} 
Local aItnsVws   := {}
Local aItnsChts  := {}
Local aItnsAlias := { STR0054 }		// ".: Selecione"
Local aItnsOpcs  := { STR0054, STR0055, STR0056, STR0057, STR0058 }		// ".: Selecione"   "Tabela"   "Gráfico"    "WebBrowser"    "Calendário"
Local bChange    := { || .T. }
Local bAction    := { || .T. }

// montando o array das entidades com visao
DbSelectArea( "AO2" )		// controle de entidades
AO2->( DbGoTop() ) 
While !AO2->( EOF() )
	If AO2->AO2_WAVIEW == "1"
		aAdd( aItnsAlias, AO2->AO2_ENTID + " - " + AllTrim( Posicione( "SX2", 1, AO2->AO2_ENTID, "X2NOME()" ) ) )
	EndIf
	AO2->( DbSkip() )
End

oLMainT4 := FWLayer():New()											// instanciado layer principal
oLMainT4:Init( oPanel, .F. )										// inicializado layer principal
oLMainT4:AddCollumn( "BOX_FULL", 100, .F. ) 						// adicionado box principal 
oColFULLT4 := oLMainT4:getColPanel( "BOX_FULL", Nil )			// instanciado box principal

oLInteT4 := FWLayer():New()											// instanciado layer interno
oLInteT4:Init( oColFULLT4, .F. )									// inicializado layer interno a partir do box principal

For nX := 1 To nLinhas

	aAdd( aNLinesT4, "LN" + AllTrim( Str( nX ) ) )
	oLInteT4:AddLine( aNLinesT4[nX], Round( 100 / nLinhas, 0), .F., Nil ) 
	aAdd( aOLinesT4, oLInteT4:getLinePanel( aNLinesT4[nX] ) )
	
	aAdd( aOLayersT4, FWLayer():New() )	
	aOLayersT4[nX]:Init( aOLinesT4[nX], .T. )		 
	
	// se a linha tiver mais de um coluna, criar os BOX
	If aCols[nX] > 1
		For nY := 1 To aCols[nX]  
			
			aAdd( aNColsT4, "BOX" + AllTrim( Str( nY ) ) + "_LN" + AllTrim( Str( nX ) ) )
			aOLayersT4[nX]:AddCollumn( aNColsT4[nIdxCols], Round( 100 / aCols[nX], 0), .F. ) 	 
			aAdd( aOColsT4, aOLayersT4[nX]:GetColPanel( aNColsT4[nIdxCols], Nil ) )

			aAdd( aOPnlRdT4, TPanelCss():New( 02, 02, "", aOColsT4[nIdxCols], , .F. , .F. , , , aOColsT4[nIdxCols]:nWidth, aOColsT4[nIdxCols]:nHeight, .T., .F. ) )
			aOPnlRdT4[nIdxCols]:Align := CONTROL_ALIGN_ALLCLIENT    
			aOPnlRdT4[nIdxCols]:setCSS( cStyle )

			@ 10,10 SAY STR0060 FONT oBold OF aOPnlRdT4[nIdxCols] PIXEL SIZE 80,10			// "Opção:"
	
			aAdd( aOPnlAuxT4, TPanel():New( 20, 1, "", aOPnlRdT4[nIdxCols], , , , , , aOPnlRdT4[nIdxCols]:nWidth-1, aOPnlRdT4[nIdxCols]:nHeight-20, .F., .F. ) )
	
			If nIdxCols == 1

				// combobox opções
				bChange := { || ( aOSayURLs[1]:Hide(), aOURLsT4[1]:Hide(), oBtnOk1:Hide(), aOSayAlias[1]:Hide(), aOCboxET4[1]:Hide(), aOCboxET4[1]:nAt := 1, aOSayView[1]:Hide(), aOCboxVwT4[1]:Hide(), aOCboxVwT4[1]:nAt := 1, aOSayChart[1]:Hide(), aOCboxChT4[1]:Hide(), aOCboxChT4[1]:nAt := 1, ;
								  IIF( aOCboxOpT4[1]:nAt == 4, ;
								  	  ( aOSayURLs[1]:Show(), aOURLsT4[1]:Show(), oBtnOk1:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT4[1]:nAt == 3 .Or. aOCboxOpT4[1]:nAt == 2, ; 
								  	  	  ( aOSayAlias[1]:Show(), aOCboxET4[1]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT4, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs1 := u, cCbxOpcs1 ) }, aItnsOpcs, 50, 10, aOPnlRdT4[1], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs1" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT4[1], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[1]:Hide()
				aAdd( aOURLsT4, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL1 := u, cURL1 ) }, aOPnlAuxT4[1], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL1 ) )
				aOURLsT4[1]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL1 ), .T., .F. ) } 
				oBtnOk1 := TButton():New( 09, 195, STR0067, aOPnlAuxT4[1], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk1:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT4[1]:SetItems( { "" } ), aOCboxChT4[1]:SetItems( { "" } ), ;
									IIF( aOCboxOpT4[1]:nAt == 2, ; 
									( aOCboxVwT4[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT4[1]:Show(), .T. ), ;
									IIF( aOCboxOpT4[1]:nAt == 3 , ;
										( aOCboxVwT4[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT4[1]:Show(), ;
										  aOCboxChT4[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 2 ) ) ), aOSayChart[1]:Show(), aOCboxChT4[1]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT4[1], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[1]:Hide()
				aAdd( aOCboxET4, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias1 := u, cCbxAlias1 ) }, aItnsAlias, 100, 10, aOPnlAuxT4[1], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias1" ) )
				aOCboxET4[1]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT4[1], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[1]:Hide()
				aAdd( aOCboxVwT4, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews1 := u, cCbxViews1 ) }, { "" }, 100, 10, aOPnlAuxT4[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews1" ) )
				aOCboxVwT4[1]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT4[1], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[1]:Hide()
				aAdd( aOCboxChT4, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart1 := u, cCbxChart1 ) }, { "" }, 140, 10, aOPnlAuxT4[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart1" ) )
				aOCboxChT4[1]:Hide()

			ElseIf nIdxCols == 2

				// combobox opções
				bChange := { || ( aOSayURLs[2]:Hide(), aOURLsT4[2]:Hide(), oBtnOk2:Hide(), aOSayAlias[2]:Hide(), aOCboxET4[2]:Hide(), aOCboxET4[2]:nAt := 1, aOSayView[2]:Hide(), aOCboxVwT4[2]:Hide(), aOCboxVwT4[2]:nAt := 1, aOSayChart[2]:Hide(), aOCboxChT4[2]:Hide(), aOCboxChT4[2]:nAt := 1, ;
								  IIF( aOCboxOpT4[2]:nAt == 4, ;
								  	  ( aOSayURLs[2]:Show(), aOURLsT4[2]:Show(), oBtnOk2:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT4[2]:nAt == 3 .Or. aOCboxOpT4[2]:nAt == 2, ; 
								  	  	  ( aOSayAlias[2]:Show(), aOCboxET4[2]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT4, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs2 := u, cCbxOpcs2 ) }, aItnsOpcs, 50, 10, aOPnlRdT4[2], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs2" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT4[2], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[2]:Hide()
				aAdd( aOURLsT4, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL2 := u, cURL2 ) }, aOPnlAuxT4[2], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL2 ) )
				aOURLsT4[2]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL2 ), .T., .F. ) } 
				oBtnOk2 := TButton():New( 09, 195, STR0067, aOPnlAuxT4[2], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk2:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT4[2]:SetItems( { "" } ), aOCboxChT4[2]:SetItems( { "" } ), ;
									IIF( aOCboxOpT4[2]:nAt == 2, ; 
									( aOCboxVwT4[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT4[2]:Show(), .T. ), ;
									IIF( aOCboxOpT4[2]:nAt == 3 , ;
										( aOCboxVwT4[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT4[2]:Show(), ;
										  aOCboxChT4[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 2 ) ) ), aOSayChart[2]:Show(), aOCboxChT4[2]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT4[2], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[2]:Hide()
				aAdd( aOCboxET4, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias2 := u, cCbxAlias2 ) }, aItnsAlias, 100, 10, aOPnlAuxT4[2], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias2" ) )
				aOCboxET4[2]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT4[2], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[2]:Hide()
				aAdd( aOCboxVwT4, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews2 := u, cCbxViews2 ) }, { "" }, 100, 10, aOPnlAuxT4[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews2" ) )
				aOCboxVwT4[2]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT4[2], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[2]:Hide()
				aAdd( aOCboxChT4, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart2 := u, cCbxChart2 ) }, { "" }, 140, 10, aOPnlAuxT4[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart2" ) )
				aOCboxChT4[2]:Hide()

			Else

				// combobox opções
				bChange := { || ( aOSayURLs[3]:Hide(), aOURLsT4[3]:Hide(), oBtnOk3:Hide(), aOSayAlias[3]:Hide(), aOCboxET4[3]:Hide(), aOCboxET4[3]:nAt := 1, aOSayView[3]:Hide(), aOCboxVwT4[3]:Hide(), aOCboxVwT4[3]:nAt := 1, aOSayChart[3]:Hide(), aOCboxChT4[3]:Hide(), aOCboxChT4[3]:nAt := 1, ;
								  IIF( aOCboxOpT4[3]:nAt == 4, ;
								  	  ( aOSayURLs[3]:Show(), aOURLsT4[3]:Show(), oBtnOk3:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT4[3]:nAt == 3 .Or. aOCboxOpT4[3]:nAt == 2, ; 
								  	  	  ( aOSayAlias[3]:Show(), aOCboxET4[3]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT4, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs3 := u, cCbxOpcs3 ) }, aItnsOpcs, 50, 10, aOPnlRdT4[3], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs3" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT4[3], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[3]:Hide()
				aAdd( aOURLsT4, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL3 := u, cURL3 ) }, aOPnlAuxT4[3], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL3 ) )
				aOURLsT4[3]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL3 ), .T., .F. ) } 
				oBtnOk3 := TButton():New( 09, 195, STR0067, aOPnlAuxT4[3], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk3:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT4[3]:SetItems( { "" } ), aOCboxChT4[3]:SetItems( { "" } ), ;
									IIF( aOCboxOpT4[3]:nAt == 2, ; 
									( aOCboxVwT4[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOSayView[3]:Show(), aOCboxVwT4[3]:Show(), .T. ), ;
									IIF( aOCboxOpT4[3]:nAt == 3 , ;
										( aOCboxVwT4[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOSayView[3]:Show(), aOCboxVwT4[3]:Show(), ;
										  aOCboxChT4[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 2 ) ) ), aOSayChart[3]:Show(), aOCboxChT4[3]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT4[3], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[3]:Hide()
				aAdd( aOCboxET4, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias3 := u, cCbxAlias3 ) }, aItnsAlias, 100, 10, aOPnlAuxT4[3], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias3" ) )
				aOCboxET4[3]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT4[3], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[3]:Hide()
				aAdd( aOCboxVwT4, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxViews3 ) }, { "" }, 100, 10, aOPnlAuxT4[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews3" ) )
				aOCboxVwT4[3]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT4[3], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[3]:Hide()
				aAdd( aOCboxChT4, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart3 := u, cCbxChart3 ) }, { "" }, 140, 10, aOPnlAuxT4[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart3" ) )
				aOCboxChT4[3]:Hide()

			EndIf
			
			aOPnlRdT4[nIdxCols]:Refresh()
			nIdxCols++
		Next nY
	Else	
		aAdd( aNColsT4, "BOX1_LN" + AllTrim( Str( nX ) ) )				
		aOLayersT4[nX]:AddCollumn( aNColsT4[nIdxCols], 100, .F. ) 	 
		aAdd( aOColsT4, aOLayersT4[nX]:GetColPanel( aNColsT4[nIdxCols], Nil ) )

		aAdd( aOPnlRdT4, TPanelCss():New( 02, 02, "", aOColsT4[nIdxCols], , .F. , .F. , , , aOColsT4[nIdxCols]:nWidth, aOColsT4[nIdxCols]:nHeight, .T., .F. ) )
		aOPnlRdT4[nIdxCols]:Align := CONTROL_ALIGN_ALLCLIENT    
		aOPnlRdT4[nIdxCols]:setCSS( cStyle )

		@ 10,10 SAY STR0060 FONT oBold OF aOPnlRdT4[nIdxCols] PIXEL SIZE 80,10			// "Opção:"

		aAdd( aOPnlAuxT4, TPanel():New( 20, 1, "", aOPnlRdT4[nIdxCols], , , , , , aOPnlRdT4[nIdxCols]:nWidth-1, aOPnlRdT4[nIdxCols]:nHeight-20, .F., .F. ) )

		If nIdxCols == 1

			// combobox opções
			bChange := { || ( aOSayURLs[1]:Hide(), aOURLsT4[1]:Hide(), oBtnOk1:Hide(), aOSayAlias[1]:Hide(), aOCboxET4[1]:Hide(), aOCboxET4[1]:nAt := 1, aOSayView[1]:Hide(), aOCboxVwT4[1]:Hide(), aOCboxVwT4[1]:nAt := 1, aOSayChart[1]:Hide(), aOCboxChT4[1]:Hide(), aOCboxChT4[1]:nAt := 1, ;
							  IIF( aOCboxOpT4[1]:nAt == 4, ;
							  	  ( aOSayURLs[1]:Show(), aOURLsT4[1]:Show(), oBtnOk1:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT4[1]:nAt == 3 .Or. aOCboxOpT4[1]:nAt == 2, ; 
							  	  	  ( aOSayAlias[1]:Show(), aOCboxET4[1]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT4, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs1 := u, cCbxOpcs1 ) }, aItnsOpcs, 50, 10, aOPnlRdT4[1], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs1" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT4[1], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[1]:Hide()
			aAdd( aOURLsT4, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL1 := u, cURL1 ) }, aOPnlAuxT4[1], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL1 ) )
			aOURLsT4[1]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL1 ), .T., .F. ) } 
			oBtnOk1 := TButton():New( 09, 195, STR0067, aOPnlAuxT4[1], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk1:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT4[1]:SetItems( { "" } ), aOCboxChT4[1]:SetItems( { "" } ), ;
								IIF( aOCboxOpT4[1]:nAt == 2, ; 
								( aOCboxVwT4[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT4[1]:Show(), .T. ), ;
								IIF( aOCboxOpT4[1]:nAt == 3 , ;
									( aOCboxVwT4[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT4[1]:Show(), ;
									  aOCboxChT4[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 2 ) ) ), aOSayChart[1]:Show(), aOCboxChT4[1]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT4[1], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[1]:Hide()
			aAdd( aOCboxET4, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias1 := u, cCbxAlias1 ) }, aItnsAlias, 100, 10, aOPnlAuxT4[1], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias1" ) )
			aOCboxET4[1]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT4[1], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[1]:Hide()
			aAdd( aOCboxVwT4, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews1 := u, cCbxViews1 ) }, { "" }, 100, 10, aOPnlAuxT4[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews1" ) )
			aOCboxVwT4[1]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT4[1], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[1]:Hide()
			aAdd( aOCboxChT4, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart1 := u, cCbxChart1 ) }, { "" }, 140, 10, aOPnlAuxT4[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart1" ) )
			aOCboxChT4[1]:Hide()

		ElseIf nIdxCols == 2

			// combobox opções
			bChange := { || ( aOSayURLs[2]:Hide(), aOURLsT4[2]:Hide(), oBtnOk2:Hide(), aOSayAlias[2]:Hide(), aOCboxET4[2]:Hide(), aOCboxET4[2]:nAt := 1, aOSayView[2]:Hide(), aOCboxVwT4[2]:Hide(), aOCboxVwT4[2]:nAt := 1, aOSayChart[2]:Hide(), aOCboxChT4[2]:Hide(), aOCboxChT4[2]:nAt := 1, ;
							  IIF( aOCboxOpT4[2]:nAt == 4, ;
							  	  ( aOSayURLs[2]:Show(), aOURLsT4[2]:Show(), oBtnOk2:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT4[2]:nAt == 3 .Or. aOCboxOpT4[2]:nAt == 2, ; 
							  	  	  ( aOSayAlias[2]:Show(), aOCboxET4[2]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT4, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs2 := u, cCbxOpcs2 ) }, aItnsOpcs, 50, 10, aOPnlRdT4[2], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs2" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT4[2], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[2]:Hide()
			aAdd( aOURLsT4, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL2 := u, cURL2 ) }, aOPnlAuxT4[2], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL2 ) )
			aOURLsT4[2]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL2 ), .T., .F. ) } 
			oBtnOk2 := TButton():New( 09, 195, STR0067, aOPnlAuxT4[2], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk2:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT4[2]:SetItems( { "" } ), aOCboxChT4[2]:SetItems( { "" } ), ;
								IIF( aOCboxOpT4[2]:nAt == 2, ; 
								( aOCboxVwT4[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT4[2]:Show(), .T. ), ;
								IIF( aOCboxOpT4[2]:nAt == 3 , ;
									( aOCboxVwT4[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT4[2]:Show(), ;
									  aOCboxChT4[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 2 ) ) ), aOSayChart[2]:Show(), aOCboxChT4[2]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT4[2], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[2]:Hide()
			aAdd( aOCboxET4, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias2 := u, cCbxAlias2 ) }, aItnsAlias, 100, 10, aOPnlAuxT4[2], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias2" ) )
			aOCboxET4[2]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT4[2], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[2]:Hide()
			aAdd( aOCboxVwT4, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews2 := u, cCbxViews2 ) }, { "" }, 100, 10, aOPnlAuxT4[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews2" ) )
			aOCboxVwT4[2]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT4[2], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[2]:Hide()
			aAdd( aOCboxChT4, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart2 := u, cCbxChart2 ) }, { "" }, 140, 10, aOPnlAuxT4[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart2" ) )
			aOCboxChT4[2]:Hide()

		Else

			// combobox opções
			bChange := { || ( aOSayURLs[3]:Hide(), aOURLsT4[3]:Hide(), oBtnOk3:Hide(), aOSayAlias[3]:Hide(), aOCboxET4[3]:Hide(), aOCboxET4[3]:nAt := 1, aOSayView[3]:Hide(), aOCboxVwT4[3]:Hide(), aOCboxVwT4[3]:nAt := 1, aOSayChart[3]:Hide(), aOCboxChT4[3]:Hide(), aOCboxChT4[3]:nAt := 1, ;
							  IIF( aOCboxOpT4[3]:nAt == 4, ;
							  	  ( aOSayURLs[3]:Show(), aOURLsT4[3]:Show(), oBtnOk3:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT4[3]:nAt == 3 .Or. aOCboxOpT4[3]:nAt == 2, ; 
							  	  	  ( aOSayAlias[3]:Show(), aOCboxET4[3]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT4, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs3 := u, cCbxOpcs3 ) }, aItnsOpcs, 50, 10, aOPnlRdT4[3], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs3" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT4[3], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[3]:Hide()
			aAdd( aOURLsT4, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL3 := u, cURL3 ) }, aOPnlAuxT4[3], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL3 ) )
			aOURLsT4[3]:Hide()
				
			bAction := { || IIF( TRG030AVldUrl( cURL3 ), .T., .F. ) } 
			oBtnOk3 := TButton():New( 09, 195, STR0067, aOPnlAuxT4[3], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk3:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT4[3]:SetItems( { "" } ), aOCboxChT4[3]:SetItems( { "" } ), ;
								IIF( aOCboxOpT4[3]:nAt == 2, ; 
								( aOCboxVwT4[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOSayView[3]:Show(), aOCboxVwT4[3]:Show(), .T. ), ;
								IIF( aOCboxOpT4[3]:nAt == 3 , ;
									( aOCboxVwT4[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOSayView[3]:Show(), aOCboxVwT4[3]:Show(), ;
									  aOCboxChT4[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 2 ) ) ), aOSayChart[3]:Show(), aOCboxChT4[3]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT4[3], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[3]:Hide()
			aAdd( aOCboxET4, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias3 := u, cCbxAlias3 ) }, aItnsAlias, 100, 10, aOPnlAuxT4[3], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias3" ) )
			aOCboxET4[3]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT4[3], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[3]:Hide()
			aAdd( aOCboxVwT4, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxViews3 ) }, { "" }, 100, 10, aOPnlAuxT4[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews3" ) )
			aOCboxVwT4[3]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT4[3], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[3]:Hide()
			aAdd( aOCboxChT4, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart3 := u, cCbxChart3 ) }, { "" }, 140, 10, aOPnlAuxT4[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart3" ) )
			aOCboxChT4[3]:Hide()

		EndIf

		aOPnlRdT4[nIdxCols]:Refresh()
		nIdxCols++
	EndIf
	
Next nX

RestArea( aAreaAO2 )
RestArea( aArea )

Return Nil

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AMT5

Função para montar a o LAYOUT 5   

@sample		TRG030AMT5( oPanel, aCols )

@param		oPanel - Objeto panel do layout 5
			aCols - Array que traz a quantidade de colunas de cada linha do layout 5

@return		Nenhum 

@author		Thiago Tavares
@since		24/04/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030AMT5( oPanel, aCols )

Local aArea	     := GetArea()
Local aAreaAO2   := AO2->( GetArea() )
Local nX, nY     := 0
Local nLinhas    := Len( aCols )
Local nIdxCols   := 1
Local cCbxAlias1 := ""
Local cCbxAlias2 := ""
Local cCbxAlias3 := ""
Local cCbxAlias4 := ""
Local cCbxViews1 := ""
Local cCbxViews2 := ""
Local cCbxViews3 := ""
Local cCbxViews4 := ""
Local cCbxChart1 := ""
Local cCbxChart2 := ""
Local cCbxChart3 := ""
Local cCbxChart4 := ""
Local cCbxOpcs1  := ""
Local cCbxOpcs2  := ""
Local cCbxOpcs3  := ""
Local cCbxOpcs4  := ""
Local cURL1      := Space(150)
Local cURL2      := Space(150)
Local cURL3      := Space(150)
Local cURL4      := Space(150)
Local oBtnOk1    := Nil
Local oBtnOk2    := Nil
Local oBtnOk3    := Nil
Local oBtnOk4    := Nil
Local aOSayAlias := {} 
Local aOSayURLs  := {}
Local aOSayView  := {} 
Local aOSayChart := {} 
Local aItnsVws   := {}
Local aItnsChts  := {}
Local aItnsAlias := { STR0054 }		// ".: Selecione"
Local aItnsOpcs  := { STR0054, STR0055, STR0056, STR0057, STR0058 }		// ".: Selecione"   "Tabela"   "Gráfico"    "WebBrowser"    "Calendário"
Local bChange    := { || .T. }
Local bAction    := { || .T. }

// montando o array das entidades com visao
DbSelectArea( "AO2" )		// controle de entidades
AO2->( DbGoTop() ) 
While !AO2->( EOF() )
	If AO2->AO2_WAVIEW == "1"
		aAdd( aItnsAlias, AO2->AO2_ENTID + " - " + AllTrim( Posicione( "SX2", 1, AO2->AO2_ENTID, "X2NOME()" ) ) )
	EndIf
	AO2->( DbSkip() )
End

oLMainT5 := FWLayer():New()														// instanciado layer principal
oLMainT5:Init( oPanel, .F. )													// inicializado layer principal
oLMainT5:AddCollumn( "BOX_FULL", 100, .F. ) 									// adicionado box principal 
oColFULLT5 := oLMainT5:getColPanel( "BOX_FULL", Nil )						// instanciado box principal

oLInteT5 := FWLayer():New()														// instanciado layer interno
oLInteT5:Init( oColFULLT5, .F. )												// inicializado layer interno a partir do box principal

For nX := 1 To nLinhas

	aAdd( aNLinesT5, "LN" + AllTrim( Str( nX ) ) )
	oLInteT5:AddLine( aNLinesT5[nX], Round( 100 / nLinhas, 0), .F., Nil ) 
	aAdd( aOLinesT5, oLInteT5:getLinePanel( aNLinesT5[nX] ) )
	
	aAdd( aOLayersT5, FWLayer():New() )	
	aOLayersT5[nX]:Init( aOLinesT5[nX], .T. )		 
	
	// se a linha tiver mais de um coluna, criar os BOX
	If aCols[nX] > 1
		For nY := 1 To aCols[nX]  
			
			aAdd( aNColsT5, "BOX" + AllTrim( Str( nY ) ) + "_LN" + AllTrim( Str( nX ) ) )
			aOLayersT5[nX]:AddCollumn( aNColsT5[nIdxCols], Round( 100 / aCols[nX], 0), .F. ) 	 
			aAdd( aOColsT5, aOLayersT5[nX]:GetColPanel( aNColsT5[nIdxCols], Nil ) )

			aAdd( aOPnlRdT5, TPanelCss():New( 02, 02, "", aOColsT5[nIdxCols], , .F. , .F. , , , aOColsT5[nIdxCols]:nWidth, aOColsT5[nIdxCols]:nHeight, .T., .F. ) )
			aOPnlRdT5[nIdxCols]:Align := CONTROL_ALIGN_ALLCLIENT    
			aOPnlRdT5[nIdxCols]:setCSS( cStyle )

			@ 10,10 SAY STR0060 FONT oBold OF aOPnlRdT5[nIdxCols] PIXEL SIZE 80,10			// "Opção:"

			aAdd( aOPnlAuxT5, TPanel():New( 20, 1, "", aOPnlRdT5[nIdxCols], , , , , , aOPnlRdT5[nIdxCols]:nWidth-1, aOPnlRdT5[nIdxCols]:nHeight-20, .F., .F. ) )

			If nIdxCols == 1
			
				// combobox opções
				bChange := { || ( aOSayURLs[1]:Hide(), aOURLsT5[1]:Hide(), oBtnOk1:Hide(), aOSayAlias[1]:Hide(), aOCboxET5[1]:Hide(), aOCboxET5[1]:nAt := 1, aOSayView[1]:Hide(), aOCboxVwT5[1]:Hide(), aOCboxVwT5[1]:nAt := 1, aOSayChart[1]:Hide(), aOCboxChT5[1]:Hide(), aOCboxChT5[1]:nAt := 1, ;
								  IIF( aOCboxOpT5[1]:nAt == 4, ;
								  	  ( aOSayURLs[1]:Show(), aOURLsT5[1]:Show(), oBtnOk1:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT5[1]:nAt == 3 .Or. aOCboxOpT5[1]:nAt == 2, ; 
								  	  	  ( aOSayAlias[1]:Show(), aOCboxET5[1]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT5, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs1 := u, cCbxOpcs1 ) }, aItnsOpcs, 50, 10, aOPnlRdT5[1], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs1" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT5[1], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[1]:Hide()
				aAdd( aOURLsT5, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL1 := u, cURL1 ) }, aOPnlAuxT5[1], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL1 ) )
				aOURLsT5[1]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL1 ), .T., .F. ) } 
				oBtnOk1 := TButton():New( 09, 195, STR0067, aOPnlAuxT5[1], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk1:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT5[1]:SetItems( { "" } ), aOCboxChT5[1]:SetItems( { "" } ), ;
									IIF( aOCboxOpT5[1]:nAt == 2, ; 
									( aOCboxVwT5[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT5[1]:Show(), .T. ), ;
									IIF( aOCboxOpT5[1]:nAt == 3 , ;
										( aOCboxVwT5[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT5[1]:Show(), ;
										  aOCboxChT5[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 2 ) ) ), aOSayChart[1]:Show(), aOCboxChT5[1]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT5[1], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[1]:Hide()
				aAdd( aOCboxET5, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias1 := u, cCbxAlias1 ) }, aItnsAlias, 100, 10, aOPnlAuxT5[1], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias1" ) )
				aOCboxET5[1]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT5[1], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[1]:Hide()
				aAdd( aOCboxVwT5, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews1 := u, cCbxViews1 ) }, { "" }, 100, 10, aOPnlAuxT5[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews1" ) )
				aOCboxVwT5[1]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT5[1], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[1]:Hide()
				aAdd( aOCboxChT5, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart1 := u, cCbxChart1 ) }, { "" }, 140, 10, aOPnlAuxT5[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart1" ) )
				aOCboxChT5[1]:Hide()
	
			ElseIf nIdxCols == 2

				// combobox opções
				bChange := { || ( aOSayURLs[2]:Hide(), aOURLsT5[2]:Hide(), oBtnOk2:Hide(), aOSayAlias[2]:Hide(), aOCboxET5[2]:Hide(), aOCboxET5[2]:nAt := 1, aOSayView[2]:Hide(), aOCboxVwT5[2]:Hide(), aOCboxVwT5[2]:nAt := 1, aOSayChart[2]:Hide(), aOCboxChT5[2]:Hide(), aOCboxChT5[2]:nAt := 1, ;
								  IIF( aOCboxOpT5[2]:nAt == 4, ;
								  	  ( aOSayURLs[2]:Show(), aOURLsT5[2]:Show(), oBtnOk2:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT5[2]:nAt == 3 .Or. aOCboxOpT5[2]:nAt == 2, ; 
								  	  	  ( aOSayAlias[2]:Show(), aOCboxET5[2]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT5, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs2 := u, cCbxOpcs2 ) }, aItnsOpcs, 50, 10, aOPnlRdT5[2], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs2" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT5[2], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[2]:Hide()
				aAdd( aOURLsT5, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL2 := u, cURL2 ) }, aOPnlAuxT5[2], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL2 ) )
				aOURLsT5[2]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL2 ), .T., .F. ) } 
				oBtnOk2 := TButton():New( 09, 195, STR0067, aOPnlAuxT5[2], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk2:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT5[2]:SetItems( { "" } ), aOCboxChT5[2]:SetItems( { "" } ), ;
									IIF( aOCboxOpT5[2]:nAt == 2, ; 
									( aOCboxVwT5[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT5[2]:Show(), .T. ), ;
									IIF( aOCboxOpT5[2]:nAt == 3 , ;
										( aOCboxVwT5[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT5[2]:Show(), ;
										  aOCboxChT5[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 2 ) ) ), aOSayChart[2]:Show(), aOCboxChT5[2]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT5[2], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[2]:Hide()
				aAdd( aOCboxET5, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias2 := u, cCbxAlias2 ) }, aItnsAlias, 100, 10, aOPnlAuxT5[2], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias2" ) )
				aOCboxET5[2]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT5[2], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[2]:Hide()
				aAdd( aOCboxVwT5, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews2 := u, cCbxViews2 ) }, { "" }, 100, 10, aOPnlAuxT5[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews2" ) )
				aOCboxVwT5[2]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT5[2], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[2]:Hide()
				aAdd( aOCboxChT5, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart2 := u, cCbxChart2 ) }, { "" }, 140, 10, aOPnlAuxT5[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart2" ) )
				aOCboxChT5[2]:Hide()

			ElseIf nIdxCols == 3

				// combobox opções
				bChange := { || ( aOSayURLs[3]:Hide(), aOURLsT5[3]:Hide(), oBtnOk3:Hide(), aOSayAlias[3]:Hide(), aOCboxET5[3]:Hide(), aOCboxET5[3]:nAt := 1, aOSayView[3]:Hide(), aOCboxVwT5[3]:Hide(), aOCboxVwT5[3]:nAt := 1, aOSayChart[3]:Hide(), aOCboxChT5[3]:Hide(), aOCboxChT5[3]:nAt := 1, ;
								  IIF( aOCboxOpT5[3]:nAt == 4, ;
								  	  ( aOSayURLs[3]:Show(), aOURLsT5[3]:Show(), oBtnOk3:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT5[3]:nAt == 3 .Or. aOCboxOpT5[3]:nAt == 2, ; 
								  	  	  ( aOSayAlias[3]:Show(), aOCboxET5[3]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT5, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs3 := u, cCbxOpcs3 ) }, aItnsOpcs, 50, 10, aOPnlRdT5[3], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs3" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT5[3], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[3]:Hide()
				aAdd( aOURLsT5, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL3 := u, cURL3 ) }, aOPnlAuxT5[3], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL3 ) )
				aOURLsT5[3]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL3 ), .T., .F. ) } 
				oBtnOk3 := TButton():New( 09, 195, STR0067, aOPnlAuxT5[3], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk3:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT5[3]:SetItems( { "" } ), aOCboxChT5[3]:SetItems( { "" } ), ;
									IIF( aOCboxOpT5[3]:nAt == 2, ; 
									( aOCboxVwT5[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOSayView[3]:Show(), aOCboxVwT5[3]:Show(), .T. ), ;
									IIF( aOCboxOpT5[3]:nAt == 3 , ;
										( aOCboxVwT5[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOCboxVwT5[3]:Select( 1 ), aOSayView[3]:Show(), aOCboxVwT5[3]:Show(), ;
										  aOCboxChT5[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 2 ) ) ), aOCboxChT5[3]:Select( 1 ), aOSayChart[3]:Show(), aOCboxChT5[3]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT5[3], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[3]:Hide()
				aAdd( aOCboxET5, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias3 := u, cCbxAlias3 ) }, aItnsAlias, 100, 10, aOPnlAuxT5[3], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias3" ) )
				aOCboxET5[3]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT5[3], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[3]:Hide()
				aAdd( aOCboxVwT5, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxViews3 ) }, { "" }, 100, 10, aOPnlAuxT5[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews3" ) )
				aOCboxVwT5[3]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT5[3], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[3]:Hide()
				aAdd( aOCboxChT5, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxChart3 ) }, { "" }, 140, 10, aOPnlAuxT5[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart3" ) )
				aOCboxChT5[3]:Hide()

			Else

				// combobox opções
				bChange := { || ( aOSayURLs[4]:Hide(), aOURLsT5[4]:Hide(), oBtnOk4:Hide(), aOSayAlias[4]:Hide(), aOCboxET5[4]:Hide(), aOCboxET5[4]:nAt := 1, aOSayView[4]:Hide(), aOCboxVwT5[4]:Hide(), aOCboxVwT5[4]:nAt := 1, aOSayChart[4]:Hide(), aOCboxChT5[4]:Hide(), aOCboxChT5[4]:nAt := 1, ;
								  IIF( aOCboxOpT5[4]:nAt == 4, ;
								  	  ( aOSayURLs[4]:Show(), aOURLsT5[4]:Show(), oBtnOk4:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT5[4]:nAt == 3 .Or. aOCboxOpT5[4]:nAt == 2, ; 
								  	  	  ( aOSayAlias[4]:Show(), aOCboxET5[4]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT5, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs4 := u, cCbxOpcs4 ) }, aItnsOpcs, 50, 10, aOPnlRdT5[4], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs4" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT5[4], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[4]:Hide()
				aAdd( aOURLsT5, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL4 := u, cURL4 ) }, aOPnlAuxT5[4], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL4 ) )
				aOURLsT5[4]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL4 ), .T., .F. ) } 
				oBtnOk4 := TButton():New( 09, 195, STR0067, aOPnlAuxT5[4], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk4:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT5[4]:SetItems( { "" } ), aOCboxChT5[4]:SetItems( { "" } ), ;
									IIF( aOCboxOpT5[4]:nAt == 2, ; 
									( aOCboxVwT5[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 1 ) ) ), aOSayView[4]:Show(), aOCboxVwT5[4]:Show(), .T. ), ;
									IIF( aOCboxOpT5[4]:nAt == 3 , ;
										( aOCboxVwT5[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 1 ) ) ), aOSayView[4]:Show(), aOCboxVwT5[4]:Show(), ;
										  aOCboxChT5[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 2 ) ) ), aOSayChart[4]:Show(), aOCboxChT5[4]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT5[4], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[4]:Hide()
				aAdd( aOCboxET5, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias4 := u, cCbxAlias4 ) }, aItnsAlias, 100, 10, aOPnlAuxT5[4], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias4" ) )
				aOCboxET5[4]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT5[4], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[4]:Hide()
				aAdd( aOCboxVwT5, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews4 := u, cCbxViews4 ) }, { "" }, 100, 10, aOPnlAuxT5[4], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews4" ) )
				aOCboxVwT5[4]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT5[4], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[4]:Hide()
				aAdd( aOCboxChT5, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart4 := u, cCbxChart4 ) }, { "" }, 140, 10, aOPnlAuxT5[4], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart4" ) )
				aOCboxChT5[4]:Hide()

			EndIf
			
			aOPnlRdT5[nIdxCols]:Refresh()
			nIdxCols++
		Next nY
	Else	
		aAdd( aNColsT5, "BOX1_LN" + AllTrim( Str( nX ) ) )				
		aOLayersT5[nX]:AddCollumn( aNColsT5[nIdxCols], 100, .F. ) 	 
		aAdd( aOColsT5, aOLayersT5[nX]:GetColPanel( aNColsT5[nIdxCols], Nil ) )

		aAdd( aOPnlRdT5, TPanelCss():New( 02, 02, "", aOColsT5[nIdxCols], , .F. , .F. , , , aOColsT5[nIdxCols]:nWidth, aOColsT5[nIdxCols]:nHeight, .T., .F. ) )
		aOPnlRdT5[nIdxCols]:Align := CONTROL_ALIGN_ALLCLIENT    
		aOPnlRdT5[nIdxCols]:setCSS( cStyle )

		@ 10,10 SAY STR0060 FONT oBold OF aOPnlRdT5[nIdxCols] PIXEL SIZE 80,10			// "Opção:"

		aAdd( aOPnlAuxT5, TPanel():New( 20, 1, "", aOPnlRdT5[nIdxCols], , , , , , aOPnlRdT5[nIdxCols]:nWidth-1, aOPnlRdT5[nIdxCols]:nHeight-20, .F., .F. ) )

		If nIdxCols == 1
		
			// combobox opções
			bChange := { || ( aOSayURLs[1]:Hide(), aOURLsT5[1]:Hide(), oBtnOk1:Hide(), aOSayAlias[1]:Hide(), aOCboxET5[1]:Hide(), aOCboxET5[1]:nAt := 1, aOSayView[1]:Hide(), aOCboxVwT5[1]:Hide(), aOCboxVwT5[1]:nAt := 1, aOSayChart[1]:Hide(), aOCboxChT5[1]:Hide(), aOCboxChT5[1]:nAt := 1, ;
							  IIF( aOCboxOpT5[1]:nAt == 4, ;
							  	  ( aOSayURLs[1]:Show(), aOURLsT5[1]:Show(), oBtnOk1:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT5[1]:nAt == 3 .Or. aOCboxOpT5[1]:nAt == 2, ; 
							  	  	  ( aOSayAlias[1]:Show(), aOCboxET5[1]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT5, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs1 := u, cCbxOpcs1 ) }, aItnsOpcs, 50, 10, aOPnlRdT5[1], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs1" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT5[1], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[1]:Hide()
			aAdd( aOURLsT5, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL1 := u, cURL1 ) }, aOPnlAuxT5[1], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL1 ) )
			aOURLsT5[1]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL1 ), .T., .F. ) } 
			oBtnOk1 := TButton():New( 09, 195, STR0067, aOPnlAuxT5[1], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk1:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT5[1]:SetItems( { "" } ), aOCboxChT5[1]:SetItems( { "" } ), ;
								IIF( aOCboxOpT5[1]:nAt == 2, ; 
								( aOCboxVwT5[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT5[1]:Show(), .T. ), ;
								IIF( aOCboxOpT5[1]:nAt == 3 , ;
									( aOCboxVwT5[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT5[1]:Show(), ;
									  aOCboxChT5[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 2 ) ) ), aOSayChart[1]:Show(), aOCboxChT5[1]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT5[1], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[1]:Hide()
			aAdd( aOCboxET5, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias1 := u, cCbxAlias1 ) }, aItnsAlias, 100, 10, aOPnlAuxT5[1], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias1" ) )
			aOCboxET5[1]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT5[1], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[1]:Hide()
			aAdd( aOCboxVwT5, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews1 := u, cCbxViews1 ) }, { "" }, 100, 10, aOPnlAuxT5[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews1" ) )
			aOCboxVwT5[1]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT5[1], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[1]:Hide()
			aAdd( aOCboxChT5, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart1 := u, cCbxChart1 ) }, { "" }, 140, 10, aOPnlAuxT5[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart1" ) )
			aOCboxChT5[1]:Hide()

		ElseIf nIdxCols == 2

			// combobox opções
			bChange := { || ( aOSayURLs[2]:Hide(), aOURLsT5[2]:Hide(), oBtnOk2:Hide(), aOSayAlias[2]:Hide(), aOCboxET5[2]:Hide(), aOCboxET5[2]:nAt := 1, aOSayView[2]:Hide(), aOCboxVwT5[2]:Hide(), aOCboxVwT5[2]:nAt := 1, aOSayChart[2]:Hide(), aOCboxChT5[2]:Hide(), aOCboxChT5[2]:nAt := 1, ;
							  IIF( aOCboxOpT5[2]:nAt == 4, ;
							  	  ( aOSayURLs[2]:Show(), aOURLsT5[2]:Show(), oBtnOk2:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT5[2]:nAt == 3 .Or. aOCboxOpT5[2]:nAt == 2, ; 
							  	  	  ( aOSayAlias[2]:Show(), aOCboxET5[2]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT5, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs2 := u, cCbxOpcs2 ) }, aItnsOpcs, 50, 10, aOPnlRdT5[2], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs2" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT5[2], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[2]:Hide()
			aAdd( aOURLsT5, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL2 := u, cURL2 ) }, aOPnlAuxT5[2], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL2 ) )
			aOURLsT5[2]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL2 ), .T., .F. ) } 
			oBtnOk2 := TButton():New( 09, 195, STR0067, aOPnlAuxT5[2], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk2:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT5[2]:SetItems( { "" } ), aOCboxChT5[2]:SetItems( { "" } ), ;
								IIF( aOCboxOpT5[2]:nAt == 2, ; 
								( aOCboxVwT5[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT5[2]:Show(), .T. ), ;
								IIF( aOCboxOpT5[2]:nAt == 3 , ;
									( aOCboxVwT5[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT5[2]:Show(), ;
									  aOCboxChT5[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 2 ) ) ), aOSayChart[2]:Show(), aOCboxChT5[2]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT5[2], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[2]:Hide()
			aAdd( aOCboxET5, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias2 := u, cCbxAlias2 ) }, aItnsAlias, 100, 10, aOPnlAuxT5[2], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias2" ) )
			aOCboxET5[2]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT5[2], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[2]:Hide()
			aAdd( aOCboxVwT5, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews2 := u, cCbxViews2 ) }, { "" }, 100, 10, aOPnlAuxT5[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews2" ) )
			aOCboxVwT5[2]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT5[2], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[2]:Hide()
			aAdd( aOCboxChT5, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart2 := u, cCbxChart2 ) }, { "" }, 140, 10, aOPnlAuxT5[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart2" ) )
			aOCboxChT5[2]:Hide()

		ElseIf nIdxCols == 3

			// combobox opções
			bChange := { || ( aOSayURLs[3]:Hide(), aOURLsT5[3]:Hide(), oBtnOk3:Hide(), aOSayAlias[3]:Hide(), aOCboxET5[3]:Hide(), aOCboxET5[3]:nAt := 1, aOSayView[3]:Hide(), aOCboxVwT5[3]:Hide(), aOCboxVwT5[3]:nAt := 1, aOSayChart[3]:Hide(), aOCboxChT5[3]:Hide(), aOCboxChT5[3]:nAt := 1, ;
							  IIF( aOCboxOpT5[3]:nAt == 4, ;
							  	  ( aOSayURLs[3]:Show(), aOURLsT5[3]:Show(), oBtnOk3:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT5[3]:nAt == 3 .Or. aOCboxOpT5[3]:nAt == 2, ; 
							  	  	  ( aOSayAlias[3]:Show(), aOCboxET5[3]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT5, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs3 := u, cCbxOpcs3 ) }, aItnsOpcs, 50, 10, aOPnlRdT5[3], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs3" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT5[3], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[3]:Hide()
			aAdd( aOURLsT5, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL3 := u, cURL3 ) }, aOPnlAuxT5[3], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL3 ) )
			aOURLsT5[3]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL3 ), .T., .F. ) } 
			oBtnOk3 := TButton():New( 09, 195, STR0067, aOPnlAuxT5[3], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk3:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT5[3]:SetItems( { "" } ), aOCboxChT5[3]:SetItems( { "" } ), ;
								IIF( aOCboxOpT5[3]:nAt == 2, ; 
								( aOCboxVwT5[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOSayView[3]:Show(), aOCboxVwT5[3]:Show(), .T. ), ;
								IIF( aOCboxOpT5[3]:nAt == 3 , ;
									( aOCboxVwT5[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOCboxVwT5[3]:Select( 1 ), aOSayView[3]:Show(), aOCboxVwT5[3]:Show(), ;
									  aOCboxChT5[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 2 ) ) ), aOCboxChT5[3]:Select( 1 ), aOSayChart[3]:Show(), aOCboxChT5[3]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT5[3], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[3]:Hide()
			aAdd( aOCboxET5, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias3 := u, cCbxAlias3 ) }, aItnsAlias, 100, 10, aOPnlAuxT5[3], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias3" ) )
			aOCboxET5[3]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT5[3], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[3]:Hide()
			aAdd( aOCboxVwT5, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxViews3 ) }, { "" }, 100, 10, aOPnlAuxT5[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews3" ) )
			aOCboxVwT5[3]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT5[3], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[3]:Hide()
			aAdd( aOCboxChT5, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxChart3 ) }, { "" }, 140, 10, aOPnlAuxT5[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart3" ) )
			aOCboxChT5[3]:Hide()

		Else

			// combobox opções
			bChange := { || ( aOSayURLs[4]:Hide(), aOURLsT5[4]:Hide(), oBtnOk4:Hide(), aOSayAlias[4]:Hide(), aOCboxET5[4]:Hide(), aOCboxET5[4]:nAt := 1, aOSayView[4]:Hide(), aOCboxVwT5[4]:Hide(), aOCboxVwT5[4]:nAt := 1, aOSayChart[4]:Hide(), aOCboxChT5[4]:Hide(), aOCboxChT5[4]:nAt := 1, ;
							  IIF( aOCboxOpT5[4]:nAt == 4, ;
							  	  ( aOSayURLs[4]:Show(), aOURLsT5[4]:Show(), oBtnOk4:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT5[4]:nAt == 3 .Or. aOCboxOpT5[4]:nAt == 2, ; 
							  	  	  ( aOSayAlias[4]:Show(), aOCboxET5[4]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT5, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs4 := u, cCbxOpcs4 ) }, aItnsOpcs, 50, 10, aOPnlRdT5[4], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs4" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT5[4], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[4]:Hide()
			aAdd( aOURLsT5, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL4 := u, cURL4 ) }, aOPnlAuxT5[4], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL4 ) )
			aOURLsT5[4]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL4 ), .T., .F. ) } 
			oBtnOk4 := TButton():New( 09, 195, STR0067, aOPnlAuxT5[4], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk4:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT5[4]:SetItems( { "" } ), aOCboxChT5[4]:SetItems( { "" } ), ;
								IIF( aOCboxOpT5[4]:nAt == 2, ; 
								( aOCboxVwT5[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 1 ) ) ), aOSayView[4]:Show(), aOCboxVwT5[4]:Show(), .T. ), ;
								IIF( aOCboxOpT5[4]:nAt == 3 , ;
									( aOCboxVwT5[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 1 ) ) ), aOSayView[4]:Show(), aOCboxVwT5[4]:Show(), ;
									  aOCboxChT5[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 2 ) ) ), aOSayChart[4]:Show(), aOCboxChT5[4]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT5[4], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[4]:Hide()
			aAdd( aOCboxET5, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias4 := u, cCbxAlias4 ) }, aItnsAlias, 100, 10, aOPnlAuxT5[4], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias4" ) )
			aOCboxET5[4]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT5[4], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[4]:Hide()
			aAdd( aOCboxVwT5, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews4 := u, cCbxViews4 ) }, { "" }, 100, 10, aOPnlAuxT5[4], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews4" ) )
			aOCboxVwT5[4]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT5[4], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[4]:Hide()
			aAdd( aOCboxChT5, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart4 := u, cCbxChart4 ) }, { "" }, 140, 10, aOPnlAuxT5[4], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart4" ) )
			aOCboxChT5[4]:Hide()

		EndIf
	
		aOPnlRdT5[nIdxCols]:Refresh()
		nIdxCols++
	EndIf
	
Next nX

RestArea( aAreaAO2 )
RestArea( aArea )

Return Nil 

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AMT6

Função para montar a o LAYOUT 6   

@sample		TRG030AMT6( oPanel, aCols )

@param		oPanel - Objeto panel do layout 6
			aCols - Array que traz a quantidade de colunas de cada linha do layout 6

@return		Nenhum 

@author		Thiago Tavares
@since		24/04/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030AMT6( oPanel, aCols )

Local aArea	     := GetArea()
Local aAreaAO2   := AO2->( GetArea() )
Local nX, nY     := 0
Local nLinhas    := Len( aCols )
Local nIdxCols   := 1
Local cCbxAlias1 := ""
Local cCbxAlias2 := ""
Local cCbxAlias3 := ""
Local cCbxAlias4 := ""
Local cCbxAlias5 := ""
Local cCbxViews1 := ""
Local cCbxViews2 := ""
Local cCbxViews3 := ""
Local cCbxViews4 := ""
Local cCbxViews5 := ""
Local cCbxChart1 := ""
Local cCbxChart2 := ""
Local cCbxChart3 := ""
Local cCbxChart4 := ""
Local cCbxChart5 := ""
Local cCbxOpcs1  := ""
Local cCbxOpcs2  := ""
Local cCbxOpcs3  := ""
Local cCbxOpcs4  := ""
Local cCbxOpcs5  := ""
Local cURL1      := Space(150)
Local cURL2      := Space(150)
Local cURL3      := Space(150)
Local cURL4      := Space(150)
Local cURL5      := Space(150)
Local oBtnOk1    := Nil
Local oBtnOk2    := Nil
Local oBtnOk3    := Nil
Local oBtnOk4    := Nil
Local oBtnOk5    := Nil
Local aOSayAlias := {} 
Local aOSayURLs  := {}
Local aOSayView  := {} 
Local aOSayChart := {} 
Local aItnsVws   := {}
Local aItnsChts  := {}
Local aItnsAlias := { STR0054 }		// ".: Selecione"
Local aItnsOpcs  := { STR0054, STR0055, STR0056, STR0057, STR0058 }		// ".: Selecione"   "Tabela"   "Gráfico"    "WebBrowser"    "Calendário"
Local bChange    := { || .T. }
Local bAction    := { || .T. }

// montando o array das entidades com visao
DbSelectArea( "AO2" )		// controle de entidades
AO2->( DbGoTop() ) 
While !AO2->( EOF() )
	If AO2->AO2_WAVIEW == "1"
		aAdd( aItnsAlias, AO2->AO2_ENTID + " - " + AllTrim( Posicione( "SX2", 1, AO2->AO2_ENTID, "X2NOME()" ) ) )
	EndIf
	AO2->( DbSkip() )
End

oLMainT6 := FWLayer():New()														// instanciado layer principal
oLMainT6:Init( oPanel, .F. )													// inicializado layer principal
oLMainT6:AddCollumn( "BOX_FULL", 100, .F. ) 									// adicionado box principal 
oColFULLT6 := oLMainT6:getColPanel( "BOX_FULL", Nil )						// instanciado box principal

oLInteT6 := FWLayer():New()														// instanciado layer interno
oLInteT6:Init( oColFULLT6, .F. )												// inicializado layer interno a partir do box principal

For nX := 1 To nLinhas

	aAdd( aNLinesT6, "LN" + AllTrim( Str( nX ) ) )
	oLInteT6:AddLine( aNLinesT6[nX], Round( 100 / nLinhas, 0), .F., Nil ) 
	aAdd( aOLinesT6, oLInteT6:getLinePanel( aNLinesT6[nX] ) )
	
	aAdd( aOLayersT6, FWLayer():New() )	
	aOLayersT6[nX]:Init( aOLinesT6[nX], .T. )		 
	
	// se a linha tiver mais de um coluna, criar os BOX
	If aCols[nX] > 1
		For nY := 1 To aCols[nX]  
			
			aAdd( aNColsT6, "BOX" + AllTrim( Str( nY ) ) + "_LN" + AllTrim( Str( nX ) ) )
			aOLayersT6[nX]:AddCollumn( aNColsT6[nIdxCols], Round( 100 / aCols[nX], 0), .F. ) 	 
			aAdd( aOColsT6, aOLayersT6[nX]:GetColPanel( aNColsT6[nIdxCols], Nil ) )

			aAdd( aOPnlRdT6, TPanelCss():New( 02, 02, "", aOColsT6[nIdxCols], , .F. , .F. , , , aOColsT6[nIdxCols]:nWidth, aOColsT6[nIdxCols]:nHeight, .T., .F. ) )
			aOPnlRdT6[nIdxCols]:Align := CONTROL_ALIGN_ALLCLIENT    
			aOPnlRdT6[nIdxCols]:setCSS( cStyle )

			@ 10,10 SAY STR0060 FONT oBold OF aOPnlRdT6[nIdxCols] PIXEL SIZE 80,10			// "Opção:"

			aAdd( aOPnlAuxT6, TPanel():New( 20, 1, "", aOPnlRdT6[nIdxCols], , , , , , aOPnlRdT6[nIdxCols]:nWidth-1, aOPnlRdT6[nIdxCols]:nHeight-20, .F., .F. ) )

			If nIdxCols == 1
			
				// combobox opções
				bChange := { || ( aOSayURLs[1]:Hide(), aOURLsT6[1]:Hide(), oBtnOk1:Hide(), aOSayAlias[1]:Hide(), aOCboxET6[1]:Hide(), aOCboxET6[1]:nAt := 1, aOSayView[1]:Hide(), aOCboxVwT6[1]:Hide(), aOCboxVwT6[1]:nAt := 1, aOSayChart[1]:Hide(), aOCboxChT6[1]:Hide(), aOCboxChT6[1]:nAt := 1, ;
								  IIF( aOCboxOpT6[1]:nAt == 4, ;
								  	  ( aOSayURLs[1]:Show(), aOURLsT6[1]:Show(), oBtnOk1:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT6[1]:nAt == 3 .Or. aOCboxOpT6[1]:nAt == 2, ; 
								  	  	  ( aOSayAlias[1]:Show(), aOCboxET6[1]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT6, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs1 := u, cCbxOpcs1 ) }, aItnsOpcs, 50, 10, aOPnlRdT6[1], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs1" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT6[1], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[1]:Hide()
				aAdd( aOURLsT6, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL1 := u, cURL1 ) }, aOPnlAuxT6[1], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL1 ) )
				aOURLsT6[1]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL1 ), .T., .F. ) } 
				oBtnOk1 := TButton():New( 09, 195, STR0067, aOPnlAuxT6[1], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk1:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT6[1]:SetItems( { "" } ), aOCboxChT6[1]:SetItems( { "" } ), ;
									IIF( aOCboxOpT6[1]:nAt == 2, ; 
									( aOCboxVwT6[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT6[1]:Show(), .T. ), ;
									IIF( aOCboxOpT6[1]:nAt == 3 , ;
										( aOCboxVwT6[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT6[1]:Show(), ;
										  aOCboxChT6[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 2 ) ) ), aOSayChart[1]:Show(), aOCboxChT6[1]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT6[1], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[1]:Hide()
				aAdd( aOCboxET6, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias1 := u, cCbxAlias1 ) }, aItnsAlias, 100, 10, aOPnlAuxT6[1], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias1" ) )
				aOCboxET6[1]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT6[1], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[1]:Hide()
				aAdd( aOCboxVwT6, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews1 := u, cCbxViews1 ) }, { "" }, 100, 10, aOPnlAuxT6[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews1" ) )
				aOCboxVwT6[1]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT6[1], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		 // "Gráfico Inicial: "
				aOSayChart[1]:Hide()
				aAdd( aOCboxChT6, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart1 := u, cCbxChart1 ) }, { "" }, 140, 10, aOPnlAuxT6[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart1" ) )
				aOCboxChT6[1]:Hide()
	
			ElseIf nIdxCols == 2

				// combobox opções
				bChange := { || ( aOSayURLs[2]:Hide(), aOURLsT6[2]:Hide(), oBtnOk2:Hide(), aOSayAlias[2]:Hide(), aOCboxET6[2]:Hide(), aOCboxET6[2]:nAt := 1, aOSayView[2]:Hide(), aOCboxVwT6[2]:Hide(), aOCboxVwT6[2]:nAt := 1, aOSayChart[2]:Hide(), aOCboxChT6[2]:Hide(), aOCboxChT6[2]:nAt := 1, ;
								  IIF( aOCboxOpT6[2]:nAt == 4, ;
								  	  ( aOSayURLs[2]:Show(), aOURLsT6[2]:Show(), oBtnOk2:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT6[2]:nAt == 3 .Or. aOCboxOpT6[2]:nAt == 2, ; 
								  	  	  ( aOSayAlias[2]:Show(), aOCboxET6[2]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT6, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs2 := u, cCbxOpcs2 ) }, aItnsOpcs, 50, 10, aOPnlRdT6[2], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs2" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT6[2], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[2]:Hide()
				aAdd( aOURLsT6, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL2 := u, cURL2 ) }, aOPnlAuxT6[2], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL2 ) )
				aOURLsT6[2]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL2 ), .T., .F. ) } 
				oBtnOk2 := TButton():New( 09, 195, STR0067, aOPnlAuxT6[2], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk2:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT6[2]:SetItems( { "" } ), aOCboxChT6[2]:SetItems( { "" } ), ;
									IIF( aOCboxOpT6[2]:nAt == 2, ; 
									( aOCboxVwT6[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT6[2]:Show(), .T. ), ;
									IIF( aOCboxOpT6[2]:nAt == 3 , ;
										( aOCboxVwT6[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT6[2]:Show(), ;
										  aOCboxChT6[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 2 ) ) ), aOSayChart[2]:Show(), aOCboxChT6[2]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT6[2], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[2]:Hide()
				aAdd( aOCboxET6, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias2 := u, cCbxAlias2 ) }, aItnsAlias, 100, 10, aOPnlAuxT6[2], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias2" ) )
				aOCboxET6[2]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT6[2], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "		
				aOSayView[2]:Hide()
				aAdd( aOCboxVwT6, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews2 := u, cCbxViews2 ) }, { "" }, 100, 10, aOPnlAuxT6[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews2" ) )
				aOCboxVwT6[2]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT6[2], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[2]:Hide()
				aAdd( aOCboxChT6, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart2 := u, cCbxChart2 ) }, { "" }, 140, 10, aOPnlAuxT6[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart2" ) )
				aOCboxChT6[2]:Hide()

			ElseIf nIdxCols == 3

				// combobox opções
				bChange := { || ( aOSayURLs[3]:Hide(), aOURLsT6[3]:Hide(), oBtnOk3:Hide(), aOSayAlias[3]:Hide(), aOCboxET6[3]:Hide(), aOCboxET6[3]:nAt := 1, aOSayView[3]:Hide(), aOCboxVwT6[3]:Hide(), aOCboxVwT6[3]:nAt := 1, aOSayChart[3]:Hide(), aOCboxChT6[3]:Hide(), aOCboxChT6[3]:nAt := 1, ;
								  IIF( aOCboxOpT6[3]:nAt == 4, ;
								  	  ( aOSayURLs[3]:Show(), aOURLsT6[3]:Show(), oBtnOk3:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT6[3]:nAt == 3 .Or. aOCboxOpT6[3]:nAt == 2, ; 
								  	  	  ( aOSayAlias[3]:Show(), aOCboxET6[3]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT6, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs3 := u, cCbxOpcs3 ) }, aItnsOpcs, 50, 10, aOPnlRdT6[3], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs3" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT6[3], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[3]:Hide()
				aAdd( aOURLsT6, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL3 := u, cURL3 ) }, aOPnlAuxT6[3], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL3 ) )
				aOURLsT6[3]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL3 ), .T., .F. ) } 
				oBtnOk3 := TButton():New( 09, 195, STR0067, aOPnlAuxT6[3], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk3:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT6[3]:SetItems( { "" } ), aOCboxChT6[3]:SetItems( { "" } ), ;
									IIF( aOCboxOpT6[3]:nAt == 2, ; 
									( aOCboxVwT6[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOSayView[3]:Show(), aOCboxVwT6[3]:Show(), .T. ), ;
									IIF( aOCboxOpT6[3]:nAt == 3 , ;
										( aOCboxVwT6[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOCboxVwT6[3]:Select( 1 ), aOSayView[3]:Show(), aOCboxVwT6[3]:Show(), ;
										  aOCboxChT6[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 2 ) ) ), aOCboxChT6[3]:Select( 1 ), aOSayChart[3]:Show(), aOCboxChT6[3]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT6[3], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[3]:Hide()
				aAdd( aOCboxET6, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias3 := u, cCbxAlias3 ) }, aItnsAlias, 100, 10, aOPnlAuxT6[3], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias3" ) )
				aOCboxET6[3]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT6[3], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[3]:Hide()
				aAdd( aOCboxVwT6, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxViews3 ) }, { "" }, 100, 10, aOPnlAuxT6[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews3" ) )
				aOCboxVwT6[3]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT6[3], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[3]:Hide()
				aAdd( aOCboxChT6, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxChart3 ) }, { "" }, 140, 10, aOPnlAuxT6[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart3" ) )
				aOCboxChT6[3]:Hide()

			ElseIf nIdxCols == 4

				// combobox opções
				bChange := { || ( aOSayURLs[4]:Hide(), aOURLsT6[4]:Hide(), oBtnOk4:Hide(), aOSayAlias[4]:Hide(), aOCboxET6[4]:Hide(), aOCboxET6[4]:nAt := 1, aOSayView[4]:Hide(), aOCboxVwT6[4]:Hide(), aOCboxVwT6[4]:nAt := 1, aOSayChart[4]:Hide(), aOCboxChT6[4]:Hide(), aOCboxChT6[4]:nAt := 1, ;
								  IIF( aOCboxOpT6[4]:nAt == 4, ;
								  	  ( aOSayURLs[4]:Show(), aOURLsT6[4]:Show(), oBtnOk4:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT6[4]:nAt == 3 .Or. aOCboxOpT6[4]:nAt == 2, ; 
								  	  	  ( aOSayAlias[4]:Show(), aOCboxET6[4]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT6, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs4 := u, cCbxOpcs4 ) }, aItnsOpcs, 50, 10, aOPnlRdT6[4], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs4" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT6[4], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[4]:Hide()
				aAdd( aOURLsT6, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL4 := u, cURL4 ) }, aOPnlAuxT6[4], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL4 ) )
				aOURLsT6[4]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL4 ), .T., .F. ) } 
				oBtnOk4 := TButton():New( 09, 195, STR0067, aOPnlAuxT6[4], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk4:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT6[4]:SetItems( { "" } ), aOCboxChT6[4]:SetItems( { "" } ), ;
									IIF( aOCboxOpT6[4]:nAt == 2, ; 
									( aOCboxVwT6[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 1 ) ) ), aOSayView[4]:Show(), aOCboxVwT6[4]:Show(), .T. ), ;
									IIF( aOCboxOpT6[4]:nAt == 3 , ;
										( aOCboxVwT6[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 1 ) ) ), aOSayView[4]:Show(), aOCboxVwT6[4]:Show(), ;
										  aOCboxChT6[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 2 ) ) ), aOSayChart[4]:Show(), aOCboxChT6[4]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT6[4], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[4]:Hide()
				aAdd( aOCboxET6, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias4 := u, cCbxAlias4 ) }, aItnsAlias, 100, 10, aOPnlAuxT6[4], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias4" ) )
				aOCboxET6[4]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT6[4], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[4]:Hide()
				aAdd( aOCboxVwT6, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews4 := u, cCbxViews4 ) }, { "" }, 100, 10, aOPnlAuxT6[4], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews4" ) )
				aOCboxVwT6[4]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT6[4], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[4]:Hide()
				aAdd( aOCboxChT6, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart4 := u, cCbxChart4 ) }, { "" }, 140, 10, aOPnlAuxT6[4], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart4" ) )
				aOCboxChT6[4]:Hide()

			Else

				// combobox opções
				bChange := { || ( aOSayURLs[5]:Hide(), aOURLsT6[5]:Hide(), oBtnOk5:Hide(), aOSayAlias[5]:Hide(), aOCboxET6[5]:Hide(), aOCboxET6[5]:nAt := 1, aOSayView[5]:Hide(), aOCboxVwT6[5]:Hide(), aOCboxVwT6[5]:nAt := 1, aOSayChart[5]:Hide(), aOCboxChT6[5]:Hide(), aOCboxChT6[5]:nAt := 1, ;
								  IIF( aOCboxOpT6[5]:nAt == 4, ;
								  	  ( aOSayURLs[5]:Show(), aOURLsT6[5]:Show(), oBtnOk5:Show(), .T. ), ; 
								  	  IIF( aOCboxOpT6[5]:nAt == 3 .Or. aOCboxOpT6[5]:nAt == 2, ; 
								  	  	  ( aOSayAlias[5]:Show(), aOCboxET6[5]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOCboxOpT6, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs5 := u, cCbxOpcs5 ) }, aItnsOpcs, 50, 10, aOPnlRdT6[5], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs5" ) )			 										        
				
				// webbrowser
				aAdd( aOSayURLs, TSay():Create( aOPnlAuxT6[5], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
				aOSayURLs[5]:Hide()
				aAdd( aOURLsT6, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL5 := u, cURL5 ) }, aOPnlAuxT6[5], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL5 ) )
				aOURLsT6[5]:Hide()
				
				bAction := { || IIF( TRG030AVldUrl( cURL5 ), .T., .F. ) } 
				oBtnOk5 := TButton():New( 09, 195, STR0067, aOPnlAuxT6[5], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
				oBtnOk5:Hide()
			
				// combobox fonte dados
				bChange := { || ( aOCboxVwT6[5]:SetItems( { "" } ), aOCboxChT6[5]:SetItems( { "" } ), ;
									IIF( aOCboxOpT6[5]:nAt == 2, ; 
									( aOCboxVwT6[5]:SetItems( aClone( TRG030ACCbx( cCbxAlias5, 1 ) ) ), aOSayView[5]:Show(), aOCboxVwT6[5]:Show(), .T. ), ;
									IIF( aOCboxOpT6[5]:nAt == 3 , ;
										( aOCboxVwT6[5]:SetItems( aClone( TRG030ACCbx( cCbxAlias5, 1 ) ) ), aOSayView[5]:Show(), aOCboxVwT6[5]:Show(), ;
										  aOCboxChT6[5]:SetItems( aClone( TRG030ACCbx( cCbxAlias5, 2 ) ) ), aOSayChart[5]:Show(), aOCboxChT6[5]:Show(), .T. ), .T. ) ) ) }
				aAdd( aOSayAlias, TSay():Create( aOPnlAuxT6[5], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
				aOSayAlias[5]:Hide()
				aAdd( aOCboxET6, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias5 := u, cCbxAlias5 ) }, aItnsAlias, 100, 10, aOPnlAuxT6[5], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias5" ) )
				aOCboxET6[5]:Hide()
			
				// combobox visoes
				aAdd( aOSayView, TSay():Create( aOPnlAuxT6[5], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
				aOSayView[5]:Hide()
				aAdd( aOCboxVwT6, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews5 := u, cCbxViews5 ) }, { "" }, 100, 10, aOPnlAuxT6[5], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews5" ) )
				aOCboxVwT6[5]:Hide()
		
				// combobox graficos
				aAdd( aOSayChart, TSay():Create( aOPnlAuxT6[5], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
				aOSayChart[5]:Hide()
				aAdd( aOCboxChT6, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart5 := u, cCbxChart5 ) }, { "" }, 140, 10, aOPnlAuxT6[5], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart5" ) )
				aOCboxChT6[5]:Hide()

			EndIf
			
			aOPnlRdT6[nIdxCols]:Refresh()
			nIdxCols++
		Next nY
	Else	
		aAdd( aNColsT6, "BOX1_LN" + AllTrim( Str( nX ) ) )				
		aOLayersT6[nX]:AddCollumn( aNColsT6[nIdxCols], 100, .F. ) 	 
		aAdd( aOColsT6, aOLayersT6[nX]:GetColPanel( aNColsT6[nIdxCols], Nil ) )

		aAdd( aOPnlRdT6, TPanelCss():New( 02, 02, "", aOColsT6[nIdxCols], , .F. , .F. , , , aOColsT6[nIdxCols]:nWidth, aOColsT6[nIdxCols]:nHeight, .T., .F. ) )
		aOPnlRdT6[nIdxCols]:Align := CONTROL_ALIGN_ALLCLIENT    
		aOPnlRdT6[nIdxCols]:setCSS( cStyle )

		@ 10,10 SAY STR0060 FONT oBold OF aOPnlRdT6[nIdxCols] PIXEL SIZE 80,10			// "Opção:"

		aAdd( aOPnlAuxT6, TPanel():New( 20, 1, "", aOPnlRdT6[nIdxCols], , , , , , aOPnlRdT6[nIdxCols]:nWidth-1, aOPnlRdT6[nIdxCols]:nHeight-20, .F., .F. ) )

		If nIdxCols == 1
		
			// combobox opções
			bChange := { || ( aOSayURLs[1]:Hide(), aOURLsT6[1]:Hide(), oBtnOk1:Hide(), aOSayAlias[1]:Hide(), aOCboxET6[1]:Hide(), aOCboxET6[1]:nAt := 1, aOSayView[1]:Hide(), aOCboxVwT6[1]:Hide(), aOCboxVwT6[1]:nAt := 1, aOSayChart[1]:Hide(), aOCboxChT6[1]:Hide(), aOCboxChT6[1]:nAt := 1, ;
							  IIF( aOCboxOpT6[1]:nAt == 4, ;
							  	  ( aOSayURLs[1]:Show(), aOURLsT6[1]:Show(), oBtnOk1:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT6[1]:nAt == 3 .Or. aOCboxOpT6[1]:nAt == 2, ; 
							  	  	  ( aOSayAlias[1]:Show(), aOCboxET6[1]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT6, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs1 := u, cCbxOpcs1 ) }, aItnsOpcs, 50, 10, aOPnlRdT6[1], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs1" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT6[1], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[1]:Hide()
			aAdd( aOURLsT6, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL1 := u, cURL1 ) }, aOPnlAuxT6[1], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL1 ) )
			aOURLsT6[1]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL1 ), .T., .F. ) } 
			oBtnOk1 := TButton():New( 09, 195, STR0067, aOPnlAuxT6[1], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk1:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT6[1]:SetItems( { "" } ), aOCboxChT6[1]:SetItems( { "" } ), ;
								IIF( aOCboxOpT6[1]:nAt == 2, ; 
								( aOCboxVwT6[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT6[1]:Show(), .T. ), ;
								IIF( aOCboxOpT6[1]:nAt == 3 , ;
									( aOCboxVwT6[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 1 ) ) ), aOSayView[1]:Show(), aOCboxVwT6[1]:Show(), ;
									  aOCboxChT6[1]:SetItems( aClone( TRG030ACCbx( cCbxAlias1, 2 ) ) ), aOSayChart[1]:Show(), aOCboxChT6[1]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT6[1], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[1]:Hide()
			aAdd( aOCboxET6, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias1 := u, cCbxAlias1 ) }, aItnsAlias, 100, 10, aOPnlAuxT6[1], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias1" ) )
			aOCboxET6[1]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT6[1], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[1]:Hide()
			aAdd( aOCboxVwT6, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews1 := u, cCbxViews1 ) }, { "" }, 100, 10, aOPnlAuxT6[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews1" ) )
			aOCboxVwT6[1]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT6[1], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[1]:Hide()
			aAdd( aOCboxChT6, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart1 := u, cCbxChart1 ) }, { "" }, 140, 10, aOPnlAuxT6[1], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart1" ) )
			aOCboxChT6[1]:Hide()

		ElseIf nIdxCols == 2

			// combobox opções
			bChange := { || ( aOSayURLs[2]:Hide(), aOURLsT6[2]:Hide(), oBtnOk2:Hide(), aOSayAlias[2]:Hide(), aOCboxET6[2]:Hide(), aOCboxET6[2]:nAt := 1, aOSayView[2]:Hide(), aOCboxVwT6[2]:Hide(), aOCboxVwT6[2]:nAt := 1, aOSayChart[2]:Hide(), aOCboxChT6[2]:Hide(), aOCboxChT6[2]:nAt := 1, ;
							  IIF( aOCboxOpT6[2]:nAt == 4, ;
							  	  ( aOSayURLs[2]:Show(), aOURLsT6[2]:Show(), oBtnOk2:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT6[2]:nAt == 3 .Or. aOCboxOpT6[2]:nAt == 2, ; 
							  	  	  ( aOSayAlias[2]:Show(), aOCboxET6[2]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT6, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs2 := u, cCbxOpcs2 ) }, aItnsOpcs, 50, 10, aOPnlRdT6[2], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs2" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT6[2], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[2]:Hide()
			aAdd( aOURLsT6, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL2 := u, cURL2 ) }, aOPnlAuxT6[2], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL2 ) )
			aOURLsT6[2]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL2 ), .T., .F. ) } 
			oBtnOk2 := TButton():New( 09, 195, STR0067, aOPnlAuxT6[2], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk2:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT6[2]:SetItems( { "" } ), aOCboxChT6[2]:SetItems( { "" } ), ;
								IIF( aOCboxOpT6[2]:nAt == 2, ; 
								( aOCboxVwT6[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT6[2]:Show(), .T. ), ;
								IIF( aOCboxOpT6[2]:nAt == 3 , ;
									( aOCboxVwT6[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 1 ) ) ), aOSayView[2]:Show(), aOCboxVwT6[2]:Show(), ;
									  aOCboxChT6[2]:SetItems( aClone( TRG030ACCbx( cCbxAlias2, 2 ) ) ), aOSayChart[2]:Show(), aOCboxChT6[2]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT6[2], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[2]:Hide()
			aAdd( aOCboxET6, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias2 := u, cCbxAlias2 ) }, aItnsAlias, 100, 10, aOPnlAuxT6[2], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias2" ) )
			aOCboxET6[2]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT6[2], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[2]:Hide()
			aAdd( aOCboxVwT6, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews2 := u, cCbxViews2 ) }, { "" }, 100, 10, aOPnlAuxT6[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews2" ) )
			aOCboxVwT6[2]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT6[2], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[2]:Hide()
			aAdd( aOCboxChT6, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart2 := u, cCbxChart2 ) }, { "" }, 140, 10, aOPnlAuxT6[2], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart2" ) )
			aOCboxChT6[2]:Hide()

		ElseIf nIdxCols == 3

			// combobox opções
			bChange := { || ( aOSayURLs[3]:Hide(), aOURLsT6[3]:Hide(), oBtnOk3:Hide(), aOSayAlias[3]:Hide(), aOCboxET6[3]:Hide(), aOCboxET6[3]:nAt := 1, aOSayView[3]:Hide(), aOCboxVwT6[3]:Hide(), aOCboxVwT6[3]:nAt := 1, aOSayChart[3]:Hide(), aOCboxChT6[3]:Hide(), aOCboxChT6[3]:nAt := 1, ;
							  IIF( aOCboxOpT6[3]:nAt == 4, ;
							  	  ( aOSayURLs[3]:Show(), aOURLsT6[3]:Show(), oBtnOk3:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT6[3]:nAt == 3 .Or. aOCboxOpT6[3]:nAt == 2, ; 
							  	  	  ( aOSayAlias[3]:Show(), aOCboxET6[3]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT6, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs3 := u, cCbxOpcs3 ) }, aItnsOpcs, 50, 10, aOPnlRdT6[3], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs3" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT6[3], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[3]:Hide()
			aAdd( aOURLsT6, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL3 := u, cURL3 ) }, aOPnlAuxT6[3], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL3 ) )
			aOURLsT6[3]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL3 ), .T., .F. ) } 
			oBtnOk3 := TButton():New( 09, 195, STR0067, aOPnlAuxT6[3], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk3:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT6[3]:SetItems( { "" } ), aOCboxChT6[3]:SetItems( { "" } ), ;
								IIF( aOCboxOpT6[3]:nAt == 2, ; 
								( aOCboxVwT6[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOSayView[3]:Show(), aOCboxVwT6[3]:Show(), .T. ), ;
								IIF( aOCboxOpT6[3]:nAt == 3 , ;
									( aOCboxVwT6[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 1 ) ) ), aOCboxVwT6[3]:Select( 1 ), aOSayView[3]:Show(), aOCboxVwT6[3]:Show(), ;
									  aOCboxChT6[3]:SetItems( aClone( TRG030ACCbx( cCbxAlias3, 2 ) ) ), aOCboxChT6[3]:Select( 1 ), aOSayChart[3]:Show(), aOCboxChT6[3]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT6[3], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[3]:Hide()
			aAdd( aOCboxET6, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias3 := u, cCbxAlias3 ) }, aItnsAlias, 100, 10, aOPnlAuxT6[3], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias3" ) )
			aOCboxET6[3]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT6[3], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[3]:Hide()
			aAdd( aOCboxVwT6, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxViews3 ) }, { "" }, 100, 10, aOPnlAuxT6[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews3" ) )
			aOCboxVwT6[3]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT6[3], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[3]:Hide()
			aAdd( aOCboxChT6, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxViews3 := u, cCbxChart3 ) }, { "" }, 140, 10, aOPnlAuxT6[3], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart3" ) )
			aOCboxChT6[3]:Hide()

		ElseIf nIdxCols == 4

			// combobox opções
			bChange := { || ( aOSayURLs[4]:Hide(), aOURLsT6[4]:Hide(), oBtnOk4:Hide(), aOSayAlias[4]:Hide(), aOCboxET6[4]:Hide(), aOCboxET6[4]:nAt := 1, aOSayView[4]:Hide(), aOCboxVwT6[4]:Hide(), aOCboxVwT6[4]:nAt := 1, aOSayChart[4]:Hide(), aOCboxChT6[4]:Hide(), aOCboxChT6[4]:nAt := 1, ;
							  IIF( aOCboxOpT6[4]:nAt == 4, ;
							  	  ( aOSayURLs[4]:Show(), aOURLsT6[4]:Show(), oBtnOk4:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT6[4]:nAt == 3 .Or. aOCboxOpT6[4]:nAt == 2, ; 
							  	  	  ( aOSayAlias[4]:Show(), aOCboxET6[4]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT6, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs4 := u, cCbxOpcs4 ) }, aItnsOpcs, 50, 10, aOPnlRdT6[4], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs4" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT6[4], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[4]:Hide()
			aAdd( aOURLsT6, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL4 := u, cURL4 ) }, aOPnlAuxT6[4], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL4 ) )
			aOURLsT6[4]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL4 ), .T., .F. ) } 
			oBtnOk4 := TButton():New( 09, 195, STR0067, aOPnlAuxT6[4], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk4:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT6[4]:SetItems( { "" } ), aOCboxChT6[4]:SetItems( { "" } ), ;
								IIF( aOCboxOpT6[4]:nAt == 2, ; 
								( aOCboxVwT6[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 1 ) ) ), aOSayView[4]:Show(), aOCboxVwT6[4]:Show(), .T. ), ;
								IIF( aOCboxOpT6[4]:nAt == 3 , ;
									( aOCboxVwT6[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 1 ) ) ), aOSayView[4]:Show(), aOCboxVwT6[4]:Show(), ;
									  aOCboxChT6[4]:SetItems( aClone( TRG030ACCbx( cCbxAlias4, 2 ) ) ), aOSayChart[4]:Show(), aOCboxChT6[4]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT6[4], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[4]:Hide()
			aAdd( aOCboxET6, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias4 := u, cCbxAlias4 ) }, aItnsAlias, 100, 10, aOPnlAuxT6[4], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias4" ) )
			aOCboxET6[4]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT6[4], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[4]:Hide()
			aAdd( aOCboxVwT6, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews4 := u, cCbxViews4 ) }, { "" }, 100, 10, aOPnlAuxT6[4], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews4" ) )
			aOCboxVwT6[4]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT6[4], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[4]:Hide()
			aAdd( aOCboxChT6, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart4 := u, cCbxChart4 ) }, { "" }, 140, 10, aOPnlAuxT6[4], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart4" ) )
			aOCboxChT6[4]:Hide()

		Else

			// combobox opções
			bChange := { || ( aOSayURLs[5]:Hide(), aOURLsT6[5]:Hide(), oBtnOk5:Hide(), aOSayAlias[5]:Hide(), aOCboxET6[5]:Hide(), aOCboxET6[5]:nAt := 1, aOSayView[5]:Hide(), aOCboxVwT6[5]:Hide(), aOCboxVwT6[5]:nAt := 1, aOSayChart[5]:Hide(), aOCboxChT6[5]:Hide(), aOCboxChT6[5]:nAt := 1, ;
							  IIF( aOCboxOpT6[5]:nAt == 4, ;
							  	  ( aOSayURLs[5]:Show(), aOURLsT6[5]:Show(), oBtnOk5:Show(), .T. ), ; 
							  	  IIF( aOCboxOpT6[5]:nAt == 3 .Or. aOCboxOpT6[5]:nAt == 2, ; 
							  	  	  ( aOSayAlias[5]:Show(), aOCboxET6[5]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOCboxOpT6, TComboBox():New( 08, 32, { |u| If( PCount() > 0, cCbxOpcs5 := u, cCbxOpcs5 ) }, aItnsOpcs, 50, 10, aOPnlRdT6[5], , bChange, , , , .T., , , , ,  , , , , "cCbxOpcs5" ) )			 										        
			
			// webbrowser
			aAdd( aOSayURLs, TSay():Create( aOPnlAuxT6[5], { || STR0065 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Digite a URL: "
			aOSayURLs[5]:Hide()
			aAdd( aOURLsT6, TGet():New( 08, 42, { |u| If( PCount() > 0, cURL5 := u, cURL5 ) }, aOPnlAuxT6[5], 150, 10, "", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cURL5 ) )
			aOURLsT6[5]:Hide()
			
			bAction := { || IIF( TRG030AVldUrl( cURL5 ), .T., .F. ) } 
			oBtnOk5 := TButton():New( 09, 195, STR0067, aOPnlAuxT6[5], bAction, 30, 10, , , .F., .T., .F., , .F., { || .T. }, , .F. )		// "&Validar"
			oBtnOk5:Hide()
		
			// combobox fonte dados
			bChange := { || ( aOCboxVwT6[5]:SetItems( { "" } ), aOCboxChT6[5]:SetItems( { "" } ), ;
								IIF( aOCboxOpT6[5]:nAt == 2, ; 
								( aOCboxVwT6[5]:SetItems( aClone( TRG030ACCbx( cCbxAlias5, 1 ) ) ), aOSayView[5]:Show(), aOCboxVwT6[5]:Show(), .T. ), ;
								IIF( aOCboxOpT6[5]:nAt == 3 , ;
									( aOCboxVwT6[5]:SetItems( aClone( TRG030ACCbx( cCbxAlias5, 1 ) ) ), aOSayView[5]:Show(), aOCboxVwT6[5]:Show(), ;
									  aOCboxChT6[5]:SetItems( aClone( TRG030ACCbx( cCbxAlias5, 2 ) ) ), aOSayChart[5]:Show(), aOCboxChT6[5]:Show(), .T. ), .T. ) ) ) }
			aAdd( aOSayAlias, TSay():Create( aOPnlAuxT6[5], { || STR0061 }, 10, 10, , oBold , , , , .T. , , , 80, 20 ) )  // "Fonte de dados:"
			aOSayAlias[5]:Hide()
			aAdd( aOCboxET6, TComboBox():New( 08, 55, { |u| If( PCount() > 0, cCbxAlias5 := u, cCbxAlias5 ) }, aItnsAlias, 100, 10, aOPnlAuxT6[5], , bChange, , , , .T., , , , ,  , , , , "cCbxAlias5" ) )
			aOCboxET6[5]:Hide()
		
			// combobox visoes
			aAdd( aOSayView, TSay():Create( aOPnlAuxT6[5], { || STR0079 }, 25, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Visão Inicial: "
			aOSayView[5]:Hide()
			aAdd( aOCboxVwT6, TComboBox():New( 23, 45, { |u| If( PCount() > 0, cCbxViews5 := u, cCbxViews5 ) }, { "" }, 100, 10, aOPnlAuxT6[5], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxViews5" ) )
			aOCboxVwT6[5]:Hide()
	
			// combobox graficos
			aAdd( aOSayChart, TSay():Create( aOPnlAuxT6[5], { || STR0080 }, 40, 10, , oBold , , , , .T. , , , 80, 20 ) )		// "Gráfico Inicial: "
			aOSayChart[5]:Hide()
			aAdd( aOCboxChT6, TComboBox():New( 38, 50, { |u| If( PCount() > 0, cCbxChart5 := u, cCbxChart5 ) }, { "" }, 140, 10, aOPnlAuxT6[5], , { || .T. }, , , , .T., , , , ,  , , , , "cCbxChart5" ) )
			aOCboxChT6[5]:Hide()

		EndIf
	
		aOPnlRdT6[nIdxCols]:Refresh()
		nIdxCols++
	EndIf
	
Next nX

RestArea( aAreaAO2 )
RestArea( aArea )

Return Nil 

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AVldUrl 

Valida a URL     

@sample		TRG030AVBox( cUrl )

@param		cUrl - URL a ser validada 

@return		ExpL - Verdadeiro / Falso 

@author		Thiago Tavares
@since		05/05/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030AVldUrl( cUrl )

Local lRetorno  := .T.
Local cResponse := ""

Default cUrl := ""

If !Empty(cUrl)
	cResponse := HTTPGet( AllTrim( cUrl ) ) 
	If ValType( cResponse ) <> "C"
		lRetorno := .F.
		MsgAlert( STR0081 )		// "Não foi possível validar a página digitada!"
	Else
		lRetorno := .F.
		MsgAlert( STR0082 )		// "Página validada com sucesso!"
	EndIf 
Else
	lRetorno := .F.
 	TRG030AMAle( 3 )
EndIf

Return ( lRetorno )

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030ACCbx

Carrega os box's de visões e gráficos       

@sample		TRG030ACCbx( cAliasOpc, nTipo )

@param		cAliasOpc - Alias selecionado
			nTipo - Tipo do array a ser retornado 1 - visoes 2 - graficos  

@return		ExpA - Array com as visoes ou graficos 

@author		Thiago Tavares
@since		14/05/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030ACCbx( cAliasOpc, nTipo )

Local aArea     := GetArea()
Local aAreaSX2  := SX2->( GetArea() )
Local cFonte    := ""
Local aRet      := {}
Local nX        := 0
Local aVisions  := {}
Local aCharts   := {}
Local aTotal    := {}
Local cAliasEnt := ""
Local aSX2		  := {}
Local cRotina	  := ""


Default cAliasOpc	:= ""
Default nTipo   	:= 1

If !Empty( cAliasOpc )
	
	cAliasEnt	:= PadL(cAliasOpc,3)
	aSX2	 	:= CRMXGetSX2(cAliasOpc)
	
	If !Empty( aSX2 ) 
		
		cRotina := AllTrim( aSX2[3] ) 
		If MPUserHasAccess(cRotina, Nil, RetCodUsr(), .T.) // Valida previlégios do usuário
		
			aTotal := U_TRG030ARVC( cAliasEnt )
			
			If !Empty(aTotal)
				aVisions := aTotal[1]
				aCharts  := aTotal[2]
				
				If nTipo == 1
					For nX := 1 To Len( aVisions ) 
						aAdd( aRet, aVisions[nX]:GetName() )
					Next nX
				Else
					For nX := 1 To Len( aCharts ) 
						aAdd( aRet, PadR( aCharts[nX]:GetName(), 50 ) )
					Next nX
				EndIf
			EndIf 
		EndIf
	
	EndIf

EndIf
	
RestArea( aAreaSX2 )
RestArea( aArea )
	
Return ( aRet )

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AMAle

Função para exibir mensagem de alerta dos blocos de validações BACK NEXT FINISH EXEC   

@sample		TRG030AMAle( cMsg )

@param		cMsg - Mensagem a ser exibida

@return		ExpL - Falso 

@author		Thiago Tavares
@since		24/04/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030AMAle( nMsg )

Local aMsgs := { STR0062, ;								 	// "Digite o nome para o layout selecionado."
				 STR0063, ;								 	// "Favor selecionar uma opção."
				 STR0064, ;								 	// "Por Favor, é preciso digitar uma URL"
				 STR0066 + Chr( 10 ) + STR0109, ;	 		// "É preciso selecionar todas as opções e fontes de "     "dados do layout selecionado.
				 STR0110, ;									// "Layout já existente, digite outro nome."
				 STR0111 + Chr( 10 ) + STR0112 }			// "Não conseguimos validar o seu menu de contexto."			"Por favor, verifique se há agrupamentos / contextos inseridos." 
				   
Msgalert( aMsgs[nMsg] )

Return ( .F. )

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AChkL

Função para manipular os objetos CHECKBOX de seleção do layout    

@sample		TRG030AChkL( oPanel, aOLayouts, aChkLayout, nIdx )

@param		oPanel - Objeto do panel 
			aOLayouts - Array de objetos dos checkbox
			aRdLayout - Array de variaveis dos checkbox
			nIdx - Numero do layout selecionado 

@return		ExpL - Verdadeiro 

@author		Thiago Tavares
@since		29/04/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030AChkL( oPanel, aOLayouts, aChkLayout, nIdx )

Local nX := 0

// zerando os checkbox
For nX := 1 To Len( aChkLayout )
	aChkLayout[nX] := .F.
	aOLayouts[nX]:Refresh() 
Next nX

aChkLayout[nIdx] := .T.  
aOLayouts[nIdx]:Refresh()
oPanel:Refresh() 
 
Return ( .T. )

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AVFim

Função para validar se todas as opções foram escolhidas ao salvar o layout    

@sample		TRG030AVFim( 1 )

@param		oTela - Numero do layout escolhido  

@return		ExpL - Verdadeiro / Falso

@author		Thiago Tavares
@since		29/04/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030AVFim( nTela, aCols )

Local nX        := 0
Local nY        := 0
Local lContinua := .T.
Local nIdxcols  := 0 
Local nLinhas   := Len( aCols )
Local aOpcoes	  := {}
Local aALias    := {} 
Local aViews    := {}
Local aCharts   := {} 
Local aUrls     := {}

// calculando a qtde de colunas da tela
For nX := 1 To nLinhas
	If aCols[nX] > 1
		For nY := 1 To aCols[nX]
			nIdxCols++
		Next nY
	Else
		nIdxCols++
	EndIf
Next nX
	
Do Case 
	Case nTela == 1 
		For nX := 1 To nIdxCols

			aAdd( aOpcoes, aOCboxOpT1[nX]:nAt )		// 2 - Opção  	

			If ( aOCboxOpT1[nX]:nAt == 1 .Or. ( aOCboxOpT1[nX]:nAt != 4 .And. aOCboxOpT1[nX]:nAt != 5 ) ) .And. aOCboxET1[nX]:nAt == 1
				lContinua := .F.
				Exit
			ElseIf aOCboxOpT1[nX]:nAt == 4 .And. Empty( aOURLsT1[nX]:cText )
				lContinua := .F.
				Exit
			Else 
				aAdd( aUrls, aOURLsT1[nX]:cText )		  	// 6 - url
				
				// verificando se opção 2=Tabela ou 3=Grafico e guardar visao e gráfico inicial 
				If aOCboxOpT1[nX]:nAt == 2 .Or. aOCboxOpT1[nX]:nAt == 3
				
					If aOCboxOpT1[nX]:nAt == 2 .And. Len( aOCboxVwT1[nX]:aItems ) == 0
						lContinua := .F.
						Exit
					ElseIf aOCboxOpT1[nX]:nAt == 3 .And. ( Len( aOCboxVwT1[nX]:aItems ) == 0 .Or. Len( aOCboxChT1[nX]:aItems ) == 0 )
						lContinua := .F.
						Exit
					EndIf				
				 
					aAdd( aAlias, PadL( aOCboxET1[nX]:aItems[aOCboxET1[nX]:nAt], 3 ) )			// 3 - alias
					aAdd( aViews, aOCboxVwT1[nX]:nAt )												// 4 - visao inicial
					
					If aOCboxOpT1[nX]:nAt == 3
						aAdd( aCharts, aOCboxChT1[nX]:nAt )			// 5 - grafico inicial
					Else
						aAdd( aCharts, 1 )
					EndIf
				Else
					aAdd( aAlias, "" )			
					aAdd( aViews, 1 )
					aAdd( aCharts, 1 )
				EndIf
			EndIf				

		Next Nx

	Case nTela == 2 
		For nX := 1 To nIdxCols

			aAdd( aOpcoes, aOCboxOpT2[nX]:nAt )		// 2 - Opção  	

			If ( aOCboxOpT2[nX]:nAt == 1 .Or. ( aOCboxOpT2[nX]:nAt != 4 .And. aOCboxOpT2[nX]:nAt != 5 ) ) .And. aOCboxET2[nX]:nAt == 1
				lContinua := .F.
				Exit
			ElseIf aOCboxOpT2[nX]:nAt == 4 .And. Empty( aOURLsT2[nX]:cText )
				lContinua := .F.
				Exit
			Else 
				aAdd( aUrls, aOURLsT2[nX]:cText )		  	// 6 - url
				
				// verificando se opção 2=Tabela ou 3=Grafico e guardar visao e gráfico inicial 
				If aOCboxOpT2[nX]:nAt == 2 .Or. aOCboxOpT2[nX]:nAt == 3 

					If aOCboxOpT2[nX]:nAt == 2 .And. Len( aOCboxVwT2[nX]:aItems ) == 0
						lContinua := .F.
						Exit
					ElseIf aOCboxOpT2[nX]:nAt == 3 .And. ( Len( aOCboxVwT2[nX]:aItems ) == 0 .Or. Len( aOCboxChT2[nX]:aItems ) == 0 )
						lContinua := .F.
						Exit
					EndIf				
				 
					aAdd( aAlias, PadL( aOCboxET2[nX]:aItems[aOCboxET2[nX]:nAt], 3 ) )			// 3 - alias
					aAdd( aViews, aOCboxVwT2[nX]:nAt )											// 4 - visao inicial
					
					If aOCboxOpT2[nX]:nAt == 3
						aAdd( aCharts, aOCboxChT2[nX]:nAt )			// 5 - grafico inicial
					Else
						aAdd( aCharts, 1 )
					EndIf
				Else
					aAdd( aAlias, "" )			
					aAdd( aViews, 1 )
					aAdd( aCharts, 1 )
				EndIf
			EndIf				

		Next Nx

	Case nTela == 3 
		For nX := 1 To nIdxCols

			aAdd( aOpcoes, aOCboxOpT3[nX]:nAt )		// 2 - Opção  	

			If ( aOCboxOpT3[nX]:nAt == 1 .Or. ( aOCboxOpT3[nX]:nAt != 4 .And. aOCboxOpT3[nX]:nAt != 5 ) ) .And. aOCboxET3[nX]:nAt == 1
				lContinua := .F.
				Exit
			ElseIf aOCboxOpT3[nX]:nAt == 4 .And. Empty( aOURLsT3[nX]:cText )
				lContinua := .F.
				Exit
			Else 
				aAdd( aUrls, aOURLsT3[nX]:cText )		  	// 6 - url
				
				// verificando se opção 2=Tabela ou 3=Grafico e guardar visao e gráfico inicial 
				If aOCboxOpT3[nX]:nAt == 2 .Or. aOCboxOpT3[nX]:nAt == 3 

					If aOCboxOpT3[nX]:nAt == 2 .And. Len( aOCboxVwT3[nX]:aItems ) == 0
						lContinua := .F.
						Exit
					ElseIf aOCboxOpT3[nX]:nAt == 3 .And. ( Len( aOCboxVwT3[nX]:aItems ) == 0 .Or. Len( aOCboxChT3[nX]:aItems ) == 0 )
						lContinua := .F.
						Exit
					EndIf				
				 
					aAdd( aAlias, PadL( aOCboxET3[nX]:aItems[aOCboxET3[nX]:nAt], 3 ) )			// 3 - alias
					aAdd( aViews, aOCboxVwT3[nX]:nAt )											// 4 - visao inicial
					
					If aOCboxOpT3[nX]:nAt == 3
						aAdd( aCharts, aOCboxChT3[nX]:nAt )			// 5 - grafico inicial
					Else
						aAdd( aCharts, 1 )
					EndIf
				Else
					aAdd( aAlias, "" )			
					aAdd( aViews, 1 )
					aAdd( aCharts, 1 )
				EndIf
			EndIf				

		Next Nx
		
	Case nTela == 4 
		For nX := 1 To nIdxCols


			aAdd( aOpcoes, aOCboxOpT4[nX]:nAt )		// 2 - Opção  	

			If ( aOCboxOpT4[nX]:nAt == 1 .Or. ( aOCboxOpT4[nX]:nAt != 4 .And. aOCboxOpT4[nX]:nAt != 5 ) ) .And. aOCboxET4[nX]:nAt == 1
				lContinua := .F.
				Exit
			ElseIf aOCboxOpT4[nX]:nAt == 4 .And. Empty( aOURLsT4[nX]:cText )
				lContinua := .F.
				Exit
			Else 
				aAdd( aUrls, aOURLsT4[nX]:cText )		  	// 6 - url
				
				// verificando se opção 2=Tabela ou 3=Grafico e guardar visao e gráfico inicial 
				If aOCboxOpT4[nX]:nAt == 2 .Or. aOCboxOpT4[nX]:nAt == 3 

					If aOCboxOpT4[nX]:nAt == 2 .And. Len( aOCboxVwT4[nX]:aItems ) == 0
						lContinua := .F.
						Exit
					ElseIf aOCboxOpT4[nX]:nAt == 3 .And. ( Len( aOCboxVwT4[nX]:aItems ) == 0 .Or. Len( aOCboxChT4[nX]:aItems ) == 0 )
						lContinua := .F.
						Exit
					EndIf				
				 
					aAdd( aAlias, PadL( aOCboxET4[nX]:aItems[aOCboxET4[nX]:nAt], 3 ) )			// 3 - alias
					aAdd( aViews, aOCboxVwT4[nX]:nAt )											// 4 - visao inicial
					
					If aOCboxOpT4[nX]:nAt == 3
						aAdd( aCharts, aOCboxChT4[nX]:nAt )										// 5 - grafico inicial
					Else
						aAdd( aCharts, 1 )
					EndIf
				Else
					aAdd( aAlias, "" )			
					aAdd( aViews, 1 )
					aAdd( aCharts, 1 )
				EndIf
			EndIf				

		Next Nx

	Case nTela == 5 
		For nX := 1 To nIdxCols


			aAdd( aOpcoes, aOCboxOpT5[nX]:nAt )		// 2 - Opção  	

			If ( aOCboxOpT5[nX]:nAt == 1 .Or. ( aOCboxOpT5[nX]:nAt != 4 .And. aOCboxOpT5[nX]:nAt != 5 ) ) .And. aOCboxET5[nX]:nAt == 1
				lContinua := .F.
				Exit
			ElseIf aOCboxOpT5[nX]:nAt == 4 .And. Empty( aOURLsT5[nX]:cText )
				lContinua := .F.
				Exit
			Else 
				aAdd( aUrls, aOURLsT5[nX]:cText )		  	// 6 - url
				
				// verificando se opção 2=Tabela ou 3=Grafico e guardar visao e gráfico inicial 
				If aOCboxOpT5[nX]:nAt == 2 .Or. aOCboxOpT5[nX]:nAt == 3 

					If aOCboxOpT5[nX]:nAt == 2 .And. Len( aOCboxVwT5[nX]:aItems ) == 0
						lContinua := .F.
						Exit
					ElseIf aOCboxOpT5[nX]:nAt == 3 .And. ( Len( aOCboxVwT5[nX]:aItems ) == 0 .Or. Len( aOCboxChT5[nX]:aItems ) == 0 )
						lContinua := .F.
						Exit
					EndIf				
				 
					aAdd( aAlias, PadL( aOCboxET5[nX]:aItems[aOCboxET5[nX]:nAt], 3 ) )			// 3 - alias
					aAdd( aViews, aOCboxVwT5[nX]:nAt )											// 4 - visao inicial
					
					If aOCboxOpT5[nX]:nAt == 3
						aAdd( aCharts, aOCboxChT5[nX]:nAt )										// 5 - grafico inicial
					Else
						aAdd( aCharts, 1 )
					EndIf
				Else
					aAdd( aAlias, "" )			
					aAdd( aViews, 1 )
					aAdd( aCharts, 1 )
				EndIf
			EndIf				

		Next Nx

	Case nTela == 6 
		For nX := 1 To nIdxCols


			aAdd( aOpcoes, aOCboxOpT6[nX]:nAt )		// 2 - Opção  	

			If ( aOCboxOpT6[nX]:nAt == 1 .Or. ( aOCboxOpT6[nX]:nAt != 4 .And. aOCboxOpT6[nX]:nAt != 5 ) ) .And. aOCboxET6[nX]:nAt == 1
				lContinua := .F.
				Exit
			ElseIf aOCboxOpT6[nX]:nAt == 4 .And. Empty( aOURLsT6[nX]:cText )
				lContinua := .F.
				Exit
			Else 
				aAdd( aUrls, aOURLsT6[nX]:cText )		  	// 6 - url
				
				// verificando se opção 2=Tabela ou 3=Grafico e guardar visao e gráfico inicial 
				If aOCboxOpT6[nX]:nAt == 2 .Or. aOCboxOpT6[nX]:nAt == 3 

					If aOCboxOpT6[nX]:nAt == 2 .And. Len( aOCboxVwT6[nX]:aItems ) == 0
						lContinua := .F.
						Exit
					ElseIf aOCboxOpT6[nX]:nAt == 3 .And. ( Len( aOCboxVwT6[nX]:aItems ) == 0 .Or. Len( aOCboxChT6[nX]:aItems ) == 0 )
						lContinua := .F.
						Exit
					EndIf				
				 
					aAdd( aAlias, PadL( aOCboxET6[nX]:aItems[aOCboxET6[nX]:nAt], 3 ) )		// 3 - alias
					aAdd( aViews, aOCboxVwT6[nX]:nAt )										// 4 - visao inicial
					
					If aOCboxOpT6[nX]:nAt == 3
						aAdd( aCharts, aOCboxChT6[nX]:nAt )									// 5 - grafico inicial
					Else
						aAdd( aCharts, 1 )
					EndIf
				Else
					aAdd( aAlias, "" )			
					aAdd( aViews, 1 )
					aAdd( aCharts, 1 )
				EndIf
			EndIf				

		Next Nx		 

EndCase

If !lContinua
	TRG030AMAle( 4 )
Else
	aAdd( aControl, nTela )							// 1 - tela
	aAdd( aControl, aClone( aOpcoes ) )				// 2 - array de opção selecionada ( 2=Tabela   3=Gráfico    4=WebBrowser    5=Calendário )
	aAdd( aControl, aClone( aAlias ) )				// 3 - array alias
	aAdd( aControl, aClone( aViews ) )				// 4 - array visoes iniciais
	aAdd( aControl, aClone( aCharts ) )				// 5 - array graficos iniciais
	aAdd( aControl, aClone( aURLs ) )				// 6 - array url's 	
	aAdd( aControl, {} )							// 7 - fontes 	
EndIf

Return ( lContinua )

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AGrva 

Função para gravar as definiçoes do layout     

@sample		TRG030AGrva( oDlgWA, oPanel, aControl, aChkLayout, aColunas, oNomLayout, cNomLayout, lMnuContPd, cXML )

@param		oDlgWA - Objeto da dialog onde a workarea foi criada
			oPanel - Objeto panel do finalizar
			aControl - Array com as informações da tela a ser gravada e montada, definida no configurador
				1 - Tela
				2 - Array das opções selecionadas para a tela   ( 2=Tabela   3=Gráfico    4=WebBrowser    5=Calendário ) 
				3 - Array dos Alias da tela
				4 - Array com o IDX das Visoes Iniciais   
				5 - Array com o IDX dos Graficos Iniciais   
				6 - Array com as URL's caso opção 3=WebBrowser
			aChkLayout - Array de checkbox que indicara o numero do layout selecionado
			aColunas - Array de definição das telas (linhas e colunas)
			oNomLayout - Objeto do nome do layout
			cNomLayout - Nome do Layout
			lMnuContPd - se verdadeiro indica para utilizar o menu padrão da área de trabalho, se falso utilizar o menu passado aqui como parâmetro
			cXML - Menu de contexto criado pelo usuário

@return		Nenhum 

@author		Thiago Tavares
@since		05/05/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030AGrva( cCodUser, oPanel, aControl, aChkLayout, aColunas, oNomLayout, cNomLayout, lMnuContPd, cXML )

Local aArea      := GetArea()
Local aAreaAOH   := AOH->( GetArea() )
Local aAreaSX2   := SX2->( GetArea() )
Local oDlg       := Nil
Local oButton    := Nil
Local aSize      := MsAdvSize()
Local nIdxCols   := 0
Local nOpcA      := 0
Local nX         := 0
local nY         := 0
Local nNumLay    := aScan( aChkLayout, { |x| x == .T. } )
Local bValid     := { || IIF( Empty( AllTrim( cNomLayout ) ), TRG030AMAle( 1 ), ( nOpcA := 1, oDlg:End() ) ) }
Local lContinua  := .T.
Local cFonte     := ""
Local aAOHMaster := {}
Local aAOIDetail := {}
Local aAutoRot   := {}

Default cCodUser   := RetCodUsr()


DbSelectArea( "AOH" )		// layout area de trabalho
AOH->( DbSetOrder( 2 ) )				// AOH_FILIAL+AOH_NOME+STR(AOH_NUMLAY)
While AOH->( DbSeek( xFilial( "AOH" ) + PadR( AllTrim( cNomLayout ), 50 ) + AllTrim( Str( nNumLay ) ) ) )

	TRG030AMAle( 5 )
	oNomLayout := Nil
	cNomLayout := Space( 50 )
	DEFINE DIALOG oDlg TITLE STR0083 FROM aSize[7],0 TO aSize[6]*0.15,aSize[5]*0.45 OF oPanel PIXEL		// "Digitar o nome do Layout"		

		@ 40,10 SAY STR0053 FONT oBold OF oDlg PIXEL SIZE 80,10				// "Digite o nome do Layout:"
		oNomLayout := TGet():New( 38, 80, { |u| If( PCount() > 0, cNomLayout := u, cNomLayout ) }, oDlg, 80, 10, "@!", ,0, , , .F., , .T., , .F., , .F., .F., , .F., .F., , cNomLayout )

	ACTIVATE DIALOG oDlg CENTERED ON INIT EnchoiceBar( oDlg, bValid, { || oDlg:End() }, , )   

End

// aControl
// [1] - Tela
// [2] - Array das opções selecionadas para a tela   ( 2=Tabela   3=Gráfico    4=WebBrowser    5=Calendário ) 
// [3] - Array dos Alias da tela
// [4] - Array com o IDX das Visoes Iniciais   
// [5] - Array com o IDX dos Graficos Iniciais   
// [6] - Array com as URL's caso opção 3=WebBrowser

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

//Field
aAdd(aAOHMaster,{"AOH_NOME"		,AllTrim( cNomLayout )				,Nil})
aAdd(aAOHMaster,{"AOH_NUMLAY"	,nNumLay							,Nil})
aAdd(aAOHMaster,{"AOH_MENU"		,IIF(!lMnuContPd,cXML,U_TRG030GXML())	,Nil})

DbSelectArea( "SX2" )	
DbSetOrder( 1 )
For nX := 1 To nIdxCols 

	cFonte := ""
	If SX2->( DbSeek ( aControl[3, nX] ) ) 
		cFonte := AllTrim( SX2->X2_SYSOBJ )
	EndIf

	//Detail
	aAdd(aAOIDetail,{	{"AOI_FILIAL"	,xFilial( "AOI" ) 					,Nil}   ,;
						{"AOI_ITEM"	,StrZero( nX,  TAMSX3( "AOI_ITEM")[1] )	,Nil}   ,;
						{"AOI_OPCAO"	,AllTrim( Str( aControl[2, nX] ) )	,Nil}   ,;
						{"AOI_ALIAS"	,aControl[3, nX] 					,Nil}   ,;
						{"AOI_FONTE"	,AllTRim( cFonte )					,Nil}   ,;
						{"AOI_VDFLT"	,aControl[4, nX]					,Nil}   ,;
						{"AOI_GDFLT"	,aControl[5, nX]					,Nil}   ,;
						{"AOI_URL"   	,aControl[6, nX]					,Nil}   })	
					
Next nX

lContinua  := U_TRGC030B( MODEL_OPERATION_INSERT, aAOHMaster, aAOIDetail )

If lContinua
	FWMsgRun(/*oComponent*/, { || U_TRGC030WA( cCodUser, AOH->AOH_CODIGO, aControl) }, Nil, STR0100 )		// "Aguarde"    //"Carregando Área de Trabalho..."   
EndIf

RestArea( aAreaSX2 )
RestArea( aAreaAOH )
RestArea( aArea )

Return Nil

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AMTree 

Função que monta a Tree para criação do menu de contexto     

@sample		TRG030AMTree()

@param		Nenhum
				
@return		Nenhum 

@author		Thiago Tavares
@since		12/05/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030AMTree( oPanel, lMnuContPd )

Local oMenu      := Nil
Local oMenuItem  := Nil
Local oPnlTop    := Nil
Local oPnlBtom   := Nil
Local oPnlLeft   := Nil    
Local oPnlRight  := Nil    
Local oChkBox    := Nil
Local aFunctions := U_TRG030Funcs()
Local oBtnAgrupa := Nil
Local oBtnContxt := Nil
Local oBtnCuston := Nil
Local oBtnRemove := Nil 

// panel superior
oPnlTop := TPanel():New( 0, 0, "", oPanel, , .T., .T., , , 100, 15, .T., .T. )
oPnlTop:Align := CONTROL_ALIGN_TOP

@05,01 CHECKBOX oChkBox VAR lMnuContPd SIZE 150,009 PROMPT STR0084 ON CHANGE( IIF( lMnuContPd, ( oPnlRight:Disable(), oTree:SetDisable() ), ( oPnlRight:Enable(), oTree:SetEnable() ) ) ) OF oPnlTop		// "Menu de contexto padrão?"

// panel inferior
oPnlBtom := TPanel():New(0,0,"",oPanel,, .T., .T.,, ,0,0,.T.,.T. )
oPnlBtom:Align := CONTROL_ALIGN_ALLCLIENT

// panel esquerdo
oPnlLeft := TPanel():New(0,1,"",oPnlBtom,, .T., .T.,, ,oPnlBtom:nWidth - 20, oPnlBtom:nHeight,.T.,.T. )
oPnlLeft:Align := CONTROL_ALIGN_LEFT

oTree := DBTree():New( 000, 000, 100, 100, oPnlBtom, { || }, { || }, .T. , .T.)
oTree:AddItem( PadR( STR0059, 100 ), "MNU001", "AVG_IPROC", "AVG_IPROC", , , 1 )// "Menu de Contexto"
oTree:Align := CONTROL_ALIGN_ALLCLIENT
oTree:Cargo := { ROOT, "MNU001", STR0059, "", {} }								// "Menu de Contexto"

MENU oMenu POPUP OF oTree
	MENUITEM STR0117 ACTION TRG030AAddNo( @oTree, aFunctions, FOLDER )			// "Novo agrupamento"
	MENUITEM STR0118 ACTION TRG030AAddNo( @oTree, aFunctions, CONTENT )			// "Novo contexto"
	MENUITEM STR0152 ACTION TRG030AAddNo( @oTree, aFunctions, CUSTON_CONTENT )	// "Rotina Customizada"
	MENUITEM STR0119 ACTION TRG030ADelNo( oTree )								// "Remover"
ENDMENU

oTree:bRClicked := { | oTree, x, y | oMenu:Activate( x-120, y-368, oTree ) } 

// panel direito
oPnlRight := TPanel():New(0,0,"",oPnlBtom,, .T., .T.,, ,70,100,.T.,.T. )
oPnlRight:Align := CONTROL_ALIGN_RIGHT
oPnlRight:Disable()

@ 10, 10 BUTTON oBtnAgrupa PROMPT STR0117 ACTION TRG030AAddNo( @oTree, aFunctions, FOLDER )  SIZE 50, 11 OF oPnlRight PIXEL 		// "Novo agrupamento"
@ 25, 10 BUTTON oBtnContxt PROMPT STR0118 ACTION TRG030AAddNo( @oTree, aFunctions, CONTENT ) SIZE 50, 11 OF oPnlRight PIXEL  		// "Novo contexto"
@ 40, 10 BUTTON oBtnCuston PROMPT STR0152 ACTION TRG030AAddNo( @oTree, aFunctions, CUSTON_CONTENT ) SIZE 50, 11 OF oPnlRight PIXEL  // "Rotina Customizada"
@ 55, 10 BUTTON oBtnRemove PROMPT STR0119 ACTION TRG030ADelNo( oTree ) SIZE 50, 11 OF oPnlRight PIXEL  								// "Remover"

Return Nil

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030AAddNo 

Adiciona um item ao tree/menu     

@sample		TRG030AAddNo( oTree, aFunctions, nType )

@param		oTree - Objeto de tree utilizado para criar o menu
			aFunctions - Rotinas do menu de contexto
			nType - Tipo do item que será adicionado
				
@return		Nenhum 

@author		Thiago Tavares
@since		13/05/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030AAddNo( oTree, aFunctions, nType )

Local cIdTree 	:= Soma1(StrZero(oTree:Total(),3))
Local nPos		:= 0
Local aRetorno	:= {}

If nType == FOLDER  
	If SubStr( oTree:GetCargo(), 1, 3) $ "MNU"  
		aRetorno := TRG030ADlg( oTree, aFunctions, nType )
		If Len( aRetorno ) > 0 
			 While oTree:TreeSeek( "FOL" + cIdTree )
			 	cIdTree := Soma1( cIdTree )
			 End

			aAdd( oTree:Cargo[TREE_CHILDREN], { FOLDER, "FOL" + cIdTree, aRetorno[DESCRIPTION_ID], aRetorno[FUNCTION_ID], {} } )	
			oTree:AddItem( Capital( aRetorno[DESCRIPTION_ID] ), "FOL" + cIdTree,"AGRUPAME", "AGRUPAME", , , 2 )
		EndIf
	Else
		MsgAlert( STR0120 + Chr(10) + STR0121 )			// "Por favor, selecione a raiz do menu de contexto"			"para adicionar um novo agrupamento."
	EndIf
ElseIf nType == CONTENT

	If SubStr( oTree:GetCargo(), 1, 3 ) == "FOL" 
	
		aRetorno := TRG030ADlg( oTree, aFunctions, nType ) 
		If Len( aRetorno ) > 0
			If  MPUserHasAccess(aRetorno[3], Nil, RetCodUsr(), .T.) // Valida privilégios do usuário
			
				nPos := aScan( oTree:Cargo[TREE_CHILDREN], { |x| AllTrim( Upper( x[TREE_ID] ) ) == AllTrim( Upper( oTree:GetCargo() ) ) } )
				If nPos > 0  
					While oTree:TreeSeek( "CON" + cIdTree )
				 		cIdTree := Soma1( cIdTree )
				 	End
	
					aAdd( oTree:Cargo[TREE_CHILDREN][nPos][TREE_CHILDREN], { CONTENT, "CON" + cIdTree, aRetorno[DESCRIPTION_ID], aRetorno[FUNCTION_ID], aRetorno[ROTNAME_ID], aRetorno[OPERATION_ID], aRetorno[ALIAS_ID] } )
					oTree:AddItem( Capital( aRetorno[DESCRIPTION_ID] ), "CON" + cIdTree, "AVG_IOPT", "AVG_IOPT", , , 2 )
				EndIf
				
			EndIf
		EndIf	
	
	Else
		MsgAlert( STR0122 )		// "Por favor, adicione um contexto apenas em agrupamentos."
	EndIf 

ElseIf nType == CUSTON_CONTENT

	If SubStr( oTree:GetCargo(), 1, 3 ) == "FOL" 
	
		aRetorno := TRG030ADlg( oTree, aFunctions, nType ) 
		
		
		If Len( aRetorno ) > 0
		
			If MPUserHasAccess(AllTrim(aRetorno[2]), Nil, RetCodUsr(), .T.) // Valida privilégios do usuário
				
				nPos := aScan( oTree:Cargo[TREE_CHILDREN], { |x| AllTrim( Upper( x[TREE_ID] ) ) == AllTrim( Upper( oTree:GetCargo() ) ) } )
				If nPos > 0  
					 While oTree:TreeSeek( "CON" + cIdTree )
				 		cIdTree := Soma1( cIdTree )
				 	 End
	
					aAdd( oTree:Cargo[TREE_CHILDREN][nPos][TREE_CHILDREN], { CONTENT, "CON" + cIdTree, aRetorno[DESCRIPTION_ID], aRetorno[FUNCTION_ID], aRetorno[ROTNAME_ID], aRetorno[OPERATION_ID], aRetorno[ALIAS_ID] } )
					oTree:AddItem( Capital( aRetorno[DESCRIPTION_ID] ), "CON" + cIdTree, "AVG_IOPT", "AVG_IOPT", , , 2 )
				EndIf
					
			EndIf		
		EndIf	
	
	Else
		MsgAlert( STR0122 )		// "Por favor, adicione um contexto apenas em agrupamentos."
	EndIf 

EndIf

Return Nil

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030ADelNo 

Adiciona um item ao tree/menu     

@sample		TRG030ADelNo( oTree )

@param		oTree - Objeto de tree utilizado para criar o menu
				
@return		Nenhum 

@author		Thiago Tavares
@since		13/05/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030ADelNo( oTree )

Local cIdTree 	:= oTree:GetCargo()
Local nX		:= 0
Local nY		:= 0
Local lDeleted	:= .F.

If SubStr( cIdTree, 1, 3 ) $ "FOL|CON"

	If oTree:TreeSeek( cIdTree )
		If SubStr( cIdTree, 1, 3 ) == "FOL"
			
			nPos := aScan( oTree:Cargo[TREE_CHILDREN], { |x| AllTrim( Upper( x[TREE_ID] ) ) == AllTrim( Upper( cIdTree ) ) } )
			
			If nPos > 0
				aDel( oTree:Cargo[TREE_CHILDREN], nPos )
				aSize( oTree:Cargo[TREE_CHILDREN], Len( oTree:Cargo[TREE_CHILDREN] )-1)
				lDeleted := .T.
			EndIf
			
		ElseIf SubStr( cIdTree, 1, 3 ) == "CON"

			For nX := 1 To Len( oTree:Cargo[TREE_CHILDREN] )
				For nY := 1 To Len( oTree:Cargo[TREE_CHILDREN][nX][TREE_CHILDREN] ) 
					If AllTrim( Upper( oTree:Cargo[TREE_CHILDREN][nX][TREE_CHILDREN][nY][TREE_ID] ) ) == AllTrim( Upper( cIdTree ) )
						
						aDel(oTree:Cargo[TREE_CHILDREN][nX][TREE_CHILDREN],nY )
						aSize( oTree:Cargo[TREE_CHILDREN][nX][TREE_CHILDREN], Len( oTree:Cargo[TREE_CHILDREN][nX][TREE_CHILDREN] ) - 1 )
						lDeleted := .T.
						Exit
						
					EndIf				
				Next nY
				If lDeleted 
					Exit
				EndIf
			Next nX
			
		EndIf
		
		If lDeleted
			oTree:DelItem()
			oTree:TreeSeek( "MNU001" )
		EndIf
		
	EndIf

Else
	MsgStop( STR0123 )		// "Não será possivel remover este agrupamento / contexto." 
EndIf

Return Nil

//------------------------------------------------------------------------------------
/*/{Protheus.doc}  C030VdTree 

Valida o array de controle do Tree.   

@sample		C030VdTree( oTree )

@param		oTree - Objeto de tree utilizado para criar o menu
				
@return		ExpL - Verdadeiro / Falso

@author		Thiago Tavares
@since		13/05/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function C030VdTree( aTree )

Local lRet := .F.
Local nX   := 0

For nX := Len( oTree:Cargo[TREE_CHILDREN] ) To 1 Step - 1 
	If Len( oTree:Cargo[TREE_CHILDREN][nX][TREE_CHILDREN] ) >= 1
		lRet := .T.
	Else
		lRet := .F. 
		Exit
	EndIf
Next nX

Return ( lRet )

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030ADlg 

Adiciona um item ao tree/menu     

@sample		TRG030ADlg( oTree, aFunctions, nType )

@param		oTree - Objeto Tree do Menu de contexto
			aFunctions - Rotinas do menu de contexto
			nType - Tipo do item que será adicionado
				
@return		ExpA - Dados do item selecionado pelo usuário

@author		Thiago Tavares
@since		13/05/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030ADlg( oTree, aFunctions, nType )
	
Local oDlg 	  		:= Nil
Local aSize     	:= MsAdvSize()																		// Dimensao da janela criada pelo Protheus.
Local cTitulo		:= IIF( nType == FOLDER, STR0117, IIF( nType == CONTENT, STR0118, STR0152) )		// "Novo agrupamento"	//	"Novo contexto" // "Rotina Customizada"
Local oNewFol		:= Nil

Local oNewDesc		:= Nil
Local oNewRot		:= Nil

Local cNewFol		:= Space( 50 )

Local cNewDesc 		:= Space( 50 )
Local cNewRot 		:= Space( 150 )
Local oPanel  		:= Nil
Local oNewOper 		:= Nil
Local cNewOper		:= Space(1)
Local oNewAlias		:= Nil
Local cNewAlias		:= Space(3)

Local oCbxCont		:= Nil
Local cCbxConSel	:= ""
Local aCbxItCon		:= {}
Local oBtnOk		:= Nil
Local aRetorno		:= {}
Local lOK			:= .F.
Local lFound 		:= .F.
Local nX			:= 0
Local nY			:= 0
Local nPos			:= 0
Local bValid		:= { || IIF( nType == FOLDER,TRG030VdFol( cNewFol, oTree:Cargo ), TRG030VdCbx( cCbxConSel, oTree:Cargo ) ) }
Local nDlgAlt		:= 0
Local nDlgLar		:= 0


If nType == FOLDER .Or. nType == CONTENT
	nDlgAlt	:= 80
	nDlgLar	:= 200
ElseIf nType == CUSTON_CONTENT
	nDlgAlt	:= 140
	nDlgLar	:= 200
EndIf

oDlg := FWDialogModal():New()
oDlg:SetTitle(cTitulo)
oDlg:SetEscClose(.T.)
oDlg:SetSize(nDlgAlt,nDlgLar) 
oDlg:EnableFormBar(.T.) 

oDlg:CreateDialog() 
oPanel := oDlg:getPanelMain()

oDlg:createFormBar()//cria barra de botoes 

oDlg:addYesNoButton()	

If nType == FOLDER  
	// Aplicando validação na Dialog	
	oDlg:SetValid({|| VldCustomG(cNewFol,"1") })
	
	@10,05 SAY STR0124 SIZE 15,9 OF oPanel PIXEL		// "Nome:" 
	@08,25 MSGET oNewFol VAR cNewFol PICTURE "@!" SIZE 125,9 OF oPanel PIXEL

ElseIf nType == CONTENT

	For nX := 1 To Len( aFunctions )
		aAdd( aCbxItCon, aFunctions[nX][1] )
	Next nX
	@10,05 SAY STR0125 SIZE 28,9 OF oPanel PIXEL		// "Contexto:"
	@08,30 COMBOBOX oCbxCont VAR cCbxConSel ITEMS aCbxItCon SIZE 125, 12  OF oPanel PIXEL	

ElseIf nType == CUSTON_CONTENT

	// Incluindo validação da Dialog.	
	oDlg:SetValid({|| IIF(!Empty(cNewDesc),VldCustomG(cNewRot,"2") , VldCustomG(cNewDesc,"1") )})
	
	@09,10 SAY STR0150 SIZE 60,9 OF oPanel PIXEL // "Descrição Rotina:"
	@17,10 MSGET oNewDesc VAR cNewDesc PICTURE "@!" SIZE 125,9 OF oPanel PIXEL VALID VldCustomG(cNewDesc,"1")
	
	@31,10 SAY STR0151 SIZE 60,9 OF oPanel PIXEL // "Rotina Customizada:"
	@38,10 MSGET oNewRot VAR cNewRot PICTURE "@!" SIZE 125,9 OF oPanel PIXEL	VALID VldCustomG(cNewRot,"2")
	
	@50,10 SAY STR0192 SIZE 60,9 OF oPanel PIXEL // "Operação:"
	@58,10 MSGET oNewOper VAR cNewOper PICTURE "@9" SIZE 125,9 OF oPanel PIXEL VALID VldCustomG(cNewOper,"3")
	
	@70,10 SAY STR0193 SIZE 60,9 OF oPanel PIXEL // "Alias:"
	@78,10 MSGET oNewAlias VAR cNewAlias PICTURE "@!" SIZE 5,9 OF oPanel PIXEL VALID VldCustomG(cNewAlias,"4") 
	
EndIf
	
oDlg:Activate() 	

If oDlg:getButtonSelected() > 0

	If nType == FOLDER
	
		aRetorno := { cNewFol, "" }
	
	ElseIf nType == CONTENT
	
		nPos := aScan( aFunctions, { |x| AllTrim( x[1] ) == AllTrim( cCbxConSel ) } )
		 
		If nPos > 0
			aRetorno := aFunctions[nPos] 
			
		EndIf 
	
	ElseIf nType == CUSTON_CONTENT
		nPos := aScan( aFunctions, { |x| AllTrim( x[3] ) == AllTrim( cNewRot ) } )
		If nPos == 0
			cNewRot	:= AllTrim( cNewRot )
			aRetorno	:= { AllTrim( cNewDesc ), cNewRot + "()", cNewRot, cNewOper, cNewAlias  }
		Else
			ApMsgAlert(STR0178) //"Rotina já existente na lista de contexto!"
		EndIf
	EndIf
EndIf

Return( aRetorno )

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030VdFol 

Função que valida se a opção de agrupamento. 

@sample		TRG030VdFol( cNewFol, aTree )

@param		cNewFol - Nome do Agrupamento 
			aTree - Array de no's do menu
				
@return		ExpL - Verdadeiro / Falso

@author		Thiago Tavares
@since		13/05/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030VdFol( cNewFol, aTree )

Local lRet	:= .T.
Local nPos	:= 0

If !Empty( cNewFol )
	nPos := aScan(aTree[TREE_CHILDREN],{|x| AllTrim(Upper(x[TREE_DESCRIPTION])) == AllTrim(Upper(cNewFol)) })
	If nPos > 0
		lRet := .F.
		MsgAlert( STR0126 )		// "Este agrupamento já está inserido no menu."
	EndIf
Else
	lRet := .F.
	MsgAlert( STR0127 )			// "Por favor, digite um nome este agrupamento."
EndIf
	
	
Return( lRet )

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030VdCbx 

Função que valida se a opção de contexto já está incluída no menu      

@sample		TRG030VdCbx( cCbxOpc, aTree )

@param		cCbxOpc - Opção de contexto selecionada
			aTree - Array de no's do menu
				
@return		ExpL - Verdadeiro / Falso

@author		Thiago Tavares
@since		13/05/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
Static Function TRG030VdCbx( cCbxOpc, aTree )

Local lRet	:= .T.
Local nX  	:= 0
Local nY 	:= 0

For nX := 1 To Len( aTree[TREE_CHILDREN] )
	For nY := 1 To Len( aTree[TREE_CHILDREN][nX][TREE_CHILDREN] ) 
		If AllTrim( Upper( aTree[TREE_CHILDREN][nX][TREE_CHILDREN][nY][TREE_DESCRIPTION] ) ) == AllTrim( Upper( cCbxOpc ) )
			lRet := .F.
			MsgStop( STR0128 )		// "Este contexto já está inserido no menu."
			Exit
		EndIf
	Next nY
	If !lRet
		Exit
	EndIf
Next nX

Return ( lRet )

//------------------------------------------------------------------------------------
/*/{Protheus.doc} U_TRG030ACXml 

Função para criação do XML do menu de contexto

@sample		U_TRG030ACXml( aTree )

@param		aTree - Array de no's do menu 
				
@return		ExpC - String do XML

@author		Thiago Tavares
@since		13/05/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
User Function TRG030ACXml( aTree )

Local cXml := ""
Local nX   := 0
Local nY   := 0	 

Default aTree := {}

If Len( aTree ) == 0
	cXml := U_TRG030GXML()
Else  

	cXml := "<?xml version='1.0' encoding='ISO-8859-1'?>"
	cXml += "<MenuContent>"
	
	For nX := 1 To Len( aTree[TREE_CHILDREN] )
	
		If aTree[TREE_CHILDREN][nX][TREE_TYPE] == FOLDER 
			cXml += "<Folder>"
			cXml += "<Description>"+AllTrim(aTree[TREE_CHILDREN][nX][TREE_DESCRIPTION])+"</Description>"
		
			For nY := 1 To Len( aTree[TREE_CHILDREN][nX][TREE_CHILDREN] ) 
				cXml += "<Content>"
				cXml += "<Description>"+AllTrim( aTree[TREE_CHILDREN][nX][TREE_CHILDREN][nY][TREE_DESCRIPTION] )+"</Description>"
				cXml += "<Function>"+AllTrim( aTree[TREE_CHILDREN][nX][TREE_CHILDREN][nY][TREE_FUNCTION] )+"</Function>"
				cXml += "<RotName>"+AllTrim( aTree[TREE_CHILDREN][nX][TREE_CHILDREN][nY][TREE_CHILDREN] )+"</RotName>"
				cXml += "<Operation>"+AllTrim( aTree[TREE_CHILDREN][nX][TREE_CHILDREN][nY][TREE_OPERATION] )+"</Operation>"
				cXml += "<Alias>"+AllTrim( aTree[TREE_CHILDREN][nX][TREE_CHILDREN][nY][TREE_ALIAS] )+"</Alias>"	
				cXml += "</Content>"
			Next nY
		
			cXml += "</Folder>"
		EndIf 
	Next nX
	
	cXml += "</MenuContent>"

EndIf

Return ( cXml )

//------------------------------------------------------------------------------------
/*/{Protheus.doc} TRG030ARVC

Funções que retorna as Views e Graficos

@sample		TRG030ARVC()

@param		cAliasOpc - Alias selecionado

@return		ExpA - Array [1] Visions 
					Array [2] Charts 

@author		Victor Bitencourt
@since		12/09/2014
@version	P12
/*/
//-------------------------------------------------------------------------------------
User Function TRG030ARVC( cAliasOpc )

Local aArea     	:= GetArea()
Local aAreaSX2  	:= SX2->( GetArea() )
Local cFonte    	:= ""
Local nX        	:= 0
Local aVisions  	:= {}
Local aCharts   	:= {}
Local oTableAttach 	:= FWTableAtt():New()
Local oTableAttUsr 	:= Nil
 
Default cAliasOpc 	:= ""

DbSelectArea( "SX2" )	
DbSetOrder( 1 )

If SX2->( DbSeek ( cAliasOpc ) ) 
	cFonte := AllTrim( SX2->X2_SYSOBJ )
EndIf

If !Empty( cFonte )
	oTableAttach := FWGetAttSrc( cFonte )
EndIf

If !Empty( cAliasOpc ) 
	oTableAttUsr := FWGetUsrAttach(cAliasOpc)
	If ValType( oTableAttach ) == "O"
	
		For nX := 1 To Len( oTableAttUsr:AViews ) 
			oTableAttach:ADDView(oTableAttUsr:AViews[nX])
		Next nX
		For nX := 1 To Len( oTableAttUsr:ACharts ) 
			oTableAttach:ADDChart(oTableAttUsr:ACharts[nX])
		Next nX
		
	ElseIf ValType( oTableAttUsr ) == "O"

		oTableAttach := oTableAttUsr 	
	EndIf
EndIf	

If ValType( oTableAttach ) == "O"
	aVisions := oTableAttach:aViews 
	aCharts  := oTableAttach:aCharts
EndIf
	
RestArea( aAreaSX2 )
RestArea( aArea )
	
Return {aVisions,aCharts}

//------------------------------------------------------------------------------------
/*/{Protheus.doc} CA030RetVC

Funções que retorna as Views e Graficos

@sample		CA030RetVC()

@param			cAliasOpc - Alias selecionado

@return		ExpA - Array [1] Visions 
						Array [2] Charts 

@author		Victor Bitencourt
@since			12/09/2014
@version		P12
/*/
//-------------------------------------------------------------------------------------
User Function CA030RetVC( cAliasOpc )

Local aArea     := GetArea()
Local aAreaSX2  := SX2->( GetArea() )
Local cFonte    := ""
Local nX        := 0
Local aVisions  := {}
Local aCharts   := {}
Local oTableAttach := FWTableAtt():New()
Local oTableAttUsr := Nil
 
Default cAliasOpc := ""

DbSelectArea( "SX2" )	
DbSetOrder( 1 )

If SX2->( DbSeek ( cAliasOpc ) ) 
	cFonte := AllTrim( SX2->X2_SYSOBJ )
EndIf

If !Empty( cFonte )
	oTableAttach := FWGetAttSrc( cFonte )
EndIf

If !Empty( cAliasOpc ) 
	oTableAttUsr := FWGetUsrAttach(cAliasOpc)
	If ValType( oTableAttach ) == "O"
	
		For nX := 1 To Len( oTableAttUsr:AViews ) 
			oTableAttach:ADDView(oTableAttUsr:AViews[nX])
		Next nX
		For nX := 1 To Len( oTableAttUsr:ACharts ) 
			oTableAttach:ADDChart(oTableAttUsr:ACharts[nX])
		Next nX
		
	ElseIf ValType( oTableAttUsr ) == "O"

		oTableAttach := oTableAttUsr 	
	EndIf
EndIf	

If ValType( oTableAttach ) == "O"
	aVisions := oTableAttach:aViews 
	aCharts  := oTableAttach:aCharts
EndIf
	
RestArea( aAreaSX2 )
RestArea( aArea )
	
Return {aVisions,aCharts}

//------------------------------------------------------------------------------------
/*/{Protheus.doc} VldCustomG

Função para validar os campos de descrição e rotina informados pelo usuário, no cadastro 
de uma Rotina customizada no area de trabalho 

@sample		VldCustomG(cTexto,cTipo)

@param		cTexto - String para ser válidada
@param		cTipo  - Tipo de validação se é uma função ou a Descrição
					cTipo == '1' Válidação da Descrição
					cTipo == '2' Válidação da Rotina	

@return		lRet - verdadeiro/falso  

@author		Victor Bitencourt
@since		04/06/2015
@version	12.1.5
/*/
//-------------------------------------------------------------------------------------
Static Function VldCustomG(cTexto,cTipo)

Local lRet 		:= .F.

Default cTexto	:= "" 
Default cTipo	:= ""

If !Empty(cTipo) 
	
	cTexto := AllTrim(cTexto)
	Do Case

		Case !Empty(cTexto) .AND. cTipo == "1"// Descrição
			lRet := .T. 	
			
		Case !Empty(cTexto) .AND. cTipo == "2"// Rotina
			// Válidando a Quandidade de parêntesis infomado no cTrexto
			If	"(" $ cTexto .AND. ")" $ cTexto 	
				MsgAlert(STR0149,STR0146)//"Parênteses inválido no campo Rotina !"//"Atenção"	
	
			Else
				//Retirando espaços da string
				cTexto := StrTran(cTexto," ","")				
			
				//Verificando a se a Rotina existe no RPO
				If !FindFunction(cTexto)
					MsgAlert(STR0148,STR0146)//"Rotina não encontrada !"//"Atenção"
								
				Else
					lRet := .T.
				EndIf				
			EndIf
			
		Case cTipo == "3"// Operação
			
			If cTexto $ " 1345"  .Or. Empty(cTexto)
				lRet := .T.
			Else
				MsgAlert(STR0190 + Chr(10) + STR0191)//"Operação inválida, digite uma das operações abaixo: "#"Em branco = Sem operação;1=Visualizar;3=Incluir;4=Alterar;5=Excluir"
			EndIf
			
		Case !Empty(cTexto) .AND. cTipo == "4"// Alias
			
			lRet := ExistCpo("SX2",AllTrim(cTexto),1)
				
		OtherWise 
			MsgAlert(STR0147,STR0146)//"Por favor, Insira um valor !"//"Atenção"
	EndCase	
EndIf

Return( lRet )