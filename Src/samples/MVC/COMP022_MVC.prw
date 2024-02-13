#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

User Function COMP022_MVC()
Local oBrowse

oBrowse := FWmBrowse():New()
oBrowse:SetAlias( 'ZA1' )
oBrowse:SetDescription( 'Musicas' )
oBrowse:Activate()

Return( NIL )


//-------------------------------------------------------------------
Static Function MenuDef()
Local aRotina := {}
/*
ADD OPTION aRotina Title 'Pesquisar'  Action 'PesqBrw'             OPERATION 1 ACCESS 0
ADD OPTION aRotina Title 'Visualizar' Action 'VIEWDEF.COMP022_MVC' OPERATION 2 ACCESS 0
ADD OPTION aRotina Title 'Incluir'    Action 'VIEWDEF.COMP022_MVC' OPERATION 3 ACCESS 0
ADD OPTION aRotina Title 'Alterar'    Action 'VIEWDEF.COMP022_MVC' OPERATION 4 ACCESS 0
ADD OPTION aRotina Title 'Excluir'    Action 'VIEWDEF.COMP022_MVC' OPERATION 5 ACCESS 0
ADD OPTION aRotina Title 'Imprimir'   Action 'VIEWDEF.COMP022_MVC' OPERATION 8 ACCESS 0
*/
aAdd( aRotina, { 'Pesquisar' , 'PesqBrw'            , 0, 1, 0, .T. } ) 
aAdd( aRotina, { 'Visualizar', 'VIEWDEF.COMP022_MVC', 0, 2, 0, NIL } )
aAdd( aRotina, { 'Incluir'   , 'VIEWDEF.COMP022_MVC', 0, 3, 0, NIL } ) 
aAdd( aRotina, { 'Alterar'   , 'VIEWDEF.COMP022_MVC', 0, 4, 0, NIL } ) 
aAdd( aRotina, { 'Excluir'   , 'VIEWDEF.COMP022_MVC', 0, 5, 0, NIL } ) 
aAdd( aRotina, { 'Imprimir'  , 'VIEWDEF.COMP022_MVC', 0, 8, 0, NIL } )

Return aRotina


//-------------------------------------------------------------------
Static Function ModelDef()
Local oStruZA1 := FWFormStruct( 1, 'ZA1', /*bAvalCampo*/, /*lViewUsado*/ )
Local oStruZA2 := FWFormStruct( 1, 'ZA2', /*bAvalCampo*/, /*lViewUsado*/ )
Local oModel

oModel := MPFormModel():New( 'COMP022M', /*bPreValidacao*/, /*bPosValidacao*/, /*bCommit*/, /*bCancel*/ )
//oModel := MPFormModel():New( 'COMP022M', /*bPreValidacao*/, /*bPosValidacao*/, { |oMdl| COMP022CM2( oMdl ) }, /*bCancel*/ )
oModel:AddFields( 'ZA1MASTER', NIL, oStruZA1 )

oModel:AddGrid( 'ZA2DETAIL', 'ZA1MASTER', oStruZA2, /*bLinePre*/, /*bLinePost*/, /*bPreVal*/, /*bPosVal*/, /*BLoad*/ )
oModel:SetRelation( 'ZA2DETAIL', { { 'ZA2_FILIAL', 'xFilial( "ZA2" ) ' } , { 'ZA2_MUSICA', 'ZA1_MUSICA' } } , 'ZA2_FILIAL + ZA2_MUSICA' )

oModel:GetModel( 'ZA2DETAIL' ):SetUniqueLine( { 'ZA2_AUTOR' } )

oModel:SetDescription( 'Modelo de Musicas' )

oModel:GetModel( 'ZA1MASTER' ):SetDescription( 'Dados da Musica' )
oModel:GetModel( 'ZA2DETAIL' ):SetDescription( 'Dados do Autor'  )

oModel:AddCalc( 'COMP022CALC1', 'ZA1MASTER', 'ZA2DETAIL', 'ZA2_AUTOR', 'ZA2__TOT01', 'COUNT', { | oFW | COMP022CAL( oFW, .f. ) } )
//oModel:AddCalc( 'COMP022CALC2', 'ZA1MASTER', 'ZA2DETAIL', 'ZA2_NOME' , 'ZA2__TOT02', 'COUNT', { | oFW | COMP022CAL( oFW, .t. ) } )

Return oModel


//-------------------------------------------------------------------
Static Function ViewDef()
Local oStruZA1 := FWFormStruct( 2, 'ZA1' )
Local oStruZA2 := FWFormStruct( 2, 'ZA2' )
Local oModel   := FWLoadModel( 'COMP022_MVC' )
Local oView
Local oCalc

oCalc1 := FWFormViewStruct():New()
oCalc1:AddField( 'ZA2__TOT01', '01', 'Qtd.Aut.Par'  , 'Qtd.Aut.Par'  , GetHlpSoluc( 'ZA2_AUTOR' ) , 'N', '9999', Nil, '', .T., '', '', {} , 0, '' )
//oCalc2 := FWFormViewStruct():New()
//oCalc2:AddField( 'ZA2__TOT02', '02', 'Qtd.Aut.Impar', 'Qtd.Aut.Impar', GetHlpSoluc( 'ZA2_AUTOR' ) , 'N', '9999', Nil, '', .T., '', '', {} , 0, '' )

oView := FWFormView():New()
oView:SetModel( oModel )
oView:AddField( 'VIEW_ZA1' , oStruZA1, 'ZA1MASTER'   )
oView:AddGrid(  'VIEW_ZA2' , oStruZA2, 'ZA2DETAIL'   )
oView:AddField( 'VIEW_CALC', oCalc1  , 'COMP022CALC1' )
//oView:AddField( 'VIEW_CALC', oCalc2  , 'COMP022CALC2' )

oView:CreateFolder( 'PASTAS' )
oView:AddSheet( 'PASTAS', 'ABA01', 'Cabeçalho' )
oView:AddSheet( 'PASTAS', 'ABA02', 'Item' )

oView:CreateHorizontalBox( 'GERAL'  , 100,,, 'PASTAS', 'ABA01' )
oView:CreateHorizontalBox( 'CORPO'  ,  80,,, 'PASTAS', 'ABA02' )
oView:CreateHorizontalBox( 'RODAPE1',  10,,, 'PASTAS', 'ABA02' )
oView:CreateHorizontalBox( 'RODAPE2',  10,,, 'PASTAS', 'ABA02' )

oView:SetOwnerView( 'ZA1MASTER'  , 'GERAL'  )
oView:SetOwnerView( 'ZA2DETAIL'  , 'CORPO'  )
oView:SetOwnerView( 'COMP022CALC1', 'RODAPE1' )
//oView:SetOwnerView( 'COMP022CALC2', 'RODAPE2' )

oView:AddIncrementField( 'VIEW_ZA2', 'ZA2_ITEM' )

Return oView


//-------------------------------------------------------------------
Static Function COMP022CAL( oFW, lPar )
Local lRet := .T.

If lPar
	lRet := ( Mod( Val( oFw:GetValue( 'ZA2DETAIL', 'ZA2_AUTOR' ) ) , 2 ) == 0 )
Else
	lRet := ( Mod( Val( oFw:GetValue( 'ZA2DETAIL', 'ZA2_AUTOR' ) ) , 2 ) <> 0 )
EndIf
Return lRet

//-------------------------------------------------------------------
Static Function COMP022CM1( oModel )
Local aArea      := GetArea()
Local aAreaZA0   := ZA0->( GetArea() )
Local nOperation := oModel:GetOperation()
Local nI         := 0

If     nOperation == MODEL_OPERATION_INSERT
	
	oModelZA2 := oModel:GetModel( 'ZA2DETAIL' )
	
	For nI := 1 To oModelZA2:GetQtdLine()
		
		ZA0->( dbSetOrder( 1 ) )
		
		If ZA0->( dbSeek( xFilial( 'ZA0' ) + FwFldGet( 'ZA2_AUTOR', nI ) ) )
			RecLock( 'ZA0', .F. )
			ZA0->ZA0_QTDMUS++
			MsUnlock()
		EndIf
		
	Next
	
ElseIf nOperation == MODEL_OPERATION_DELETE
	
	oModelZA2 := oModel:GetModel( 'ZA2DETAIL' )
	
	For nI := 1 To oModelZA2:GetQtdLine()
		
		ZA0->( dbSetOrder( 1 ) )
		
		If ZA0->( dbSeek( xFilial( 'ZA0' ) + FwFldGet( 'ZA2_AUTOR', nI ) ) )
			RecLock( 'ZA0', .F. )
			ZA0->ZA0_QTDMUS := Max( 0, ZA0->ZA0_QTDMUS - 1 )
			MsUnlock()
		EndIf
		
	Next
	
EndIf

FWFormCommit( oModel )

RestArea( aAreaZA0 )
RestArea( aArea )
Return NIL



//-------------------------------------------------------------------
Static Function COMP022CM2( oModel )
Local aArea      := GetArea()
Local aAreaZA0   := ZA0->( GetArea() )
Local nOperation := oModel:GetOperation()
Local nI         := 0
Local lOk        := .T.

If         nOperation == MODEL_OPERATION_INSERT
	nVal := 1
ElseIf     nOperation == MODEL_OPERATION_UPDATE
	nVal := 0
ElseIf     nOperation == MODEL_OPERATION_DELETE
	nVal := -1
EndIf

oModelZA0 := FWLoadModel( 'COMP011_MVC' )
oModelZA0:SetOperation( 4 )

oModelZA2 := oModel:GetModel( 'ZA2DETAIL' )

For nI := 1 To oModelZA2:GetQtdLine()
	
	ZA0->( dbSetOrder( 1 ) )
	
	If ZA0->( dbSeek( xFilial( 'ZA0' ) + FwFldGet( 'ZA2_AUTOR', nI, oModel ) ) )
		
		oModelZA0:Activate()
		
		If oModelZA0:SetValue( 'ZA0MASTER', 'ZA0_QTDMUS', Max( oModelZA0:GetValue( 'ZA0MASTER', 'ZA0_QTDMUS' ) + nVal, 0 ) ) // FwFldGet( 'ZA0_QTDMUS' ,, oModelZA0 )

			If ( lOk  := oModelZA0:VldData() )
				oModelZA0:CommitData()
			Else
				Help( ,, 'Help',, 'Erro ao gravar quantidade', 1, 0 )
			EndIf

		Else

			Help( ,, 'Help',, 'Erro ao atualizar quantidade', 1, 0 )
			lOk := .F.        
			oModelZA0:DeActivate()
			Exit

		EndIf

		oModelZA0:DeActivate()
		
	EndIf
	
Next



If lOk
	FWFormCommit( oModel )
EndIf

RestArea( aAreaZA0 )
RestArea( aArea )
Return NIL

