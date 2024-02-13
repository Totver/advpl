#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMBROWSE.CH"
#INCLUDE 'PARMTYPE.CH'

Function MultiMBrw()
Local oDlg
Local oRelation
Local oFWLayer
Local omBrowseDown
Local omBrowseLeft
Local omBrowseRight
Local oPanelDown
Local oPanelLeft
Local oPanelRight
Local aCoors := GetDialogSize( oMainWnd )

Define MsDialog oDlg Title 'Múltiplos Microsiga Browse' From aCoors[1], aCoors[2] To aCoors[3], aCoors[4] Pixel

oFWLayer := FWLayer():New()
oFWLayer:Init( oDlg, .F., .T. )

//-- Microsiga Browse da esquerda
oFWLayer:addLine( 'UP', 50, .F. )
oFWLayer:AddCollumn( 'LEFT', 50, .T., 'UP' )
oFWLayer:AddWindow( 'LEFT', 'oPanelLeft', 'Cadastro de Clientes', 100, .F., .T.,, 'UP', { || } )
oPanelLeft := oFWLayer:GetWinPanel( 'LEFT', 'oPanelLeft', 'UP' )

Define FWmBrowse omBrowseLeft ALIAS 'SA1' MenuDef 'MATA030_MVC' NO DETAILS PROFILEID '1' Of oPanelLeft
Activate FWmBrowse omBrowseLeft

//omBrowseLeft:bChange := { || alert( 'oi' ) }

//-- Microsiga Browse da direita
oFWLayer:AddCollumn( 'RIGHT', 50, .T., 'UP' )
oFWLayer:AddWindow( 'RIGHT', 'oPanelRight', 'Cadastro de Vendedores', 100, .F., .T.,, 'UP', { || } )
oPanelRight := oFWLayer:GetWinPanel( 'RIGHT', 'oPanelRight', 'UP' )

Define FWmBrowse omBrowseRight ALIAS 'SA3' MenuDef 'MATA040_MVC' NO DETAILS PROFILEID '2' Of oPanelRight
Activate FWmBrowse omBrowseRight

/*
Define FWBrowse omBrowseRight  DATA QUERY ALIAS 'TRBSA3' QUERY 'SELECT * From SA3990 WHERE D_E_L_E_T_=' ' ORDER BY A3_FILIAL, A3_COD' FILTER SEEK ORDER { { 'Código'   , { { '', 'C', 15, 0, 'Código'   ,, } } } } Of oPanelRight
ADD COLUMN oColumn DATA { ||  A3_FILIAL  } Title 'Filial'    Size 15 Of omBrowseRight
ADD COLUMN oColumn DATA { ||  A3_COD     } Title 'Código'    Size 15 Of omBrowseRight
ADD COLUMN oColumn DATA { ||  A3_NOME    } Title 'Nome'      Size 40 Of omBrowseRight
Activate FWBrowse omBrowseRight
*/

oRelation := FWBrwRelation():New()
oRelation:AddRelation( omBrowseLeft, omBrowseRight, { { 'A3_FILIAL', 'xFilial( "SA3" )' } , { 'A3_COD', 'A1_COD', '>=' } } )
oRelation:Activate()

//-- Microsiga Browse da inferior
oFWLayer:addLine( 'DOWN', 50, .F. )
oFWLayer:AddCollumn( 'ALL', 100, .T., 'DOWN' )
oFWLayer:AddWindow( 'ALL', 'oPanelDown', 'Solicitação de Compras', 100, .F., .T.,, 'DOWN', { || } )
oPanelDown := oFWLayer:GetWinPanel( 'ALL', 'oPanelDown', 'DOWN' )

Define FWmBrowse omBrowseDown ALIAS 'SC1' MenuDef 'MATA110_MVC' NO DETAILS PROFILEID '3' Of oPanelDown
Activate FWmBrowse omBrowseDown

Activate MsDialog oDlg

Return


