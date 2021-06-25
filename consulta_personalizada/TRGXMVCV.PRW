#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"

// -------------------------------------------------------------------
/*/{Protheus.doc} TRGXMVCV
Montagem do formulário a partir das definições da Consulta

@author Wagner Mobile Costa
@since 27/01/2019
@version P12
/*/
// -------------------------------------------------------------------
User Function TRGMVCEX(nAction)

Local oModelAct := FwModelActive(), oModel
Local lRet		:= .F.

If nAction <> 1 .And. ! Empty(M->PQ6_ACTIVA)
	__EXIT := .F.
	U_ExcAdvpl(M->PQ6_ACTIVA)
	If __EXIT
		Return
	EndIf
EndIf

oModel := FwLoadModel(Alltrim(CPF->CPF_MODEL))
oModel:GetModel(Alltrim(CPF->CPF_MODEL)):bLoad := { || &("U_TRGMVCV(" + AllTrim(Str(nAction)) + ")") }
oModel:SetOperation(nAction)
oModel:Activate()

FWExecView(	aQuery[1][2]:cCadastro,"TRGXMVCV", nAction, , { || lRet := .T. },,,,,,, oModel )

FwModelActive(oModelAct)

Return

User Function TRGMVCV(nAction)

Local aArea   	:= GetArea()
Local oView
Local oModel
Local aCardData
Local lModel     := IsInCallStack("U_TRGMVCEX")
Local nData	     := 0
Local nFields    := 0
Local cField     := ""
Local aValues    := {}
Local lView		 := .F.
Local lRet		 := .F.

oView := FwLoadView('TRGXMVCV')
oView:oModel:SetOperation(nAction)
oView:oModel:Activate()

oModel := oView:oModel:GetModel('TRGXMVCV')

If ! lModel
	aCardData := FWViewCardData(oView)
Else
	oStruct	:= oModel:GetStruct()
	aCampos	:= aClone(oStruct:GetFields())

	For nFields := 1 To Len(aCampos)
		Aadd(aValues, oModel:GetValue(aCampos[nFields][MODEL_FIELD_IDFIELD]))
	Next
	aCardData := {AClone(aValues),0}
EndIf

RestArea(aArea)

Return aCardData

// -------------------------------------------------------------------
/*/{Protheus.doc} ModelDef
Modelo - Welcome Call (Bem Vindo) Clientes Bemacash

@author Wagner Mobile Costa
@since 17/11/2015
@version P12
/*/
// -------------------------------------------------------------------
Static Function ModelDef

Local oStru  	:= Nil
Local oModel 	:= MPFormModel():New('TRGMMVCV',, { |oModel| TRGValid(oModel) }, { |oModel| TRGCommit(oModel) } )
Local cTitulo	:= aQuery[1][2]:cCadastro
Local aKey		:= {}
Local nQuery	:= 1

//Adiciona ao Modelo uma estrutura
oModel:AddFields('TRGXMVCV',, DefStrModel( aQuery[1][2] ))
oModel:SetPrimaryKey(StrTokArr( aQuery[1][2]:aIndTrb[1][2], '+' ))
aQuery[nQuery][6] := oModel:GetModel('TRGXMVCV') 

// Adiciona ao modelo uma estrutura de formulário de edição por grid
For nQuery := 2 To Len(aQuery)
	oModel:AddGrid( 'TRGXMVCV_' + aQuery[nQuery][1], 'TRGXMVCV', DefStrModel( aQuery[nQuery][2] ), /*bLinePre*/, /*bCommit*/, /*bPreVal*/, /*bPosVal*/,;
					{ |oGrid,lCopy| TRGLoad(oGrid) } /*BLoad*/ )
	// Faz relacionamento entre os compomentes do model
	aQuery[nQuery][6] := oModel:GetModel('TRGXMVCV_' + aQuery[nQuery][1])
	aQuery[nQuery][6]:SetOptional(.t.)
	aQuery[nQuery][6]:SetDescription(aQuery[nQuery][2]:cCadastro)
Next						

//Adiciona a Descrição do Modelo
oModel:SetDescription(cTitulo)

//Adiciona a Descricao do Componente
oModel:GetModel('TRGXMVCV'):SetDescription(cTitulo)

Return oModel

// -------------------------------------------------------------------
/*/{Protheus.doc} ViewDef
Visualização - Welcome Call (Bem Vindo) Clientes Bemacash

@author Wagner Mobile Costa
@since 17/11/2015
@version P12
/*/
// -------------------------------------------------------------------
Static Function ViewDef

Local oModel := FWLoadModel('TRGXMVCV')
Local oView	 := FWFormView():New()
Local nQuery := 1

oView:SetModel(oModel)
oView:AddField('VIEW_' + aQuery[1][2]:cId, DefStrView( aQuery[1][2] ), 'TRGXMVCV')
oView:EnableTitleView('VIEW_' + aQuery[1][2]:cId, aQuery[1][2]:cCadastro)

// Criar um "box" horizontal para receber algum elemento da view
oView:CreateHorizontalBox( 'SUPERIOR', aQuery[1][2]:nPQ1_WIDTH )
If Len(aQuery) == 2
	oView:CreateHorizontalBox( 'INFERIOR', aQuery[2][2]:nPQ1_WIDTH )
EndIf

oView:SetOwnerView('VIEW_' + aQuery[1][2]:cId, 'SUPERIOR' )
For nQuery := 2 To Len(aQuery)
	oView:AddGrid('VIEW_' + aQuery[nQuery][2]:cId, DefStrView( aQuery[nQuery][2] ), 'TRGXMVCV_' + aQuery[nQuery][2]:cId )
	//oModel:GetModel( 'VIEW_' + aQuery[nQuery][2]:cId ):SetNoInsertLine( .T. )
	//oModel:GetModel( 'VIEW_' + aQuery[nQuery][2]:cId ):SetNoDeleteLine( .T. )
	oView:SetOwnerView( 'VIEW_' + aQuery[nQuery][2]:cId, 'INFERIOR' )
	oView:EnableTitleView('VIEW_' + aQuery[nQuery][2]:cId, aQuery[nQuery][2]:cCadastro)
Next

Return oView

//------------------------------------------------------------------------------
/*/	{Protheus.doc} DefStrModel

Monta estrutura do model.

@sample		DefStrModel( cQuery )

@param		ExpO1 - Objeto com dados da tabela 

@return		ExpL  - Verdadeiro / Falso

@author		Mobile
@since		27/01/2019
@version	12.0
/*/
//------------------------------------------------------------------------------

Static Function DefStrModel( oQuery )
Local nI
Local aArea     := GetArea()
Local aAreaSX3  := SX2->( GetArea() )
Local aAreaSIX  := SX3->( GetArea() )
Local aAreaSX2  := SIX->( GetArea() )
Local bValid    := {|| .T.}
Local bWhen     := {|| .T.}
Local bRelac    := NIL
Local aAux      := {}
Local cX3_CAMPO := cX3_DESCRI := cX3_TITULO := ""
Local cType
Local nSize
Local nDecimal
Local nFields := 0
Local aCBOX	  := {}

oStruct := FWFormModelStruct():New()

//-------------------------------------------------------------------
// Tabela
//-------------------------------------------------------------------
oStruct:AddTable(	oQuery:cAlias		                	,;  // [01] Alias da tabela
					StrTokArr( oQuery:aIndTrb[1][2], '+' )	,;  // [02] Array com os campos que correspondem a primary key
					oQuery:cCadastro    )                   // [03] Descrição da tabela

//-------------------------------------------------------------------
// Campos
//-------------------------------------------------------------------
SX3->( dbSetOrder( 2 ) )

For nI := 1 To Len(oQuery:aSX3)
	If ! oQuery:aSX3[nI][18]
		Loop
	EndIf
	cX3_CAMPO	:= oQuery:aSX3[nI][1]
	cType 		:= oQuery:aSX3[nI][2]
	nSize 		:= oQuery:aSX3[nI][3]
	nDecimal 	:= oQuery:aSX3[nI][4]
	cX3_TITULO 	:= oQuery:aSX3[nI][6]
	cX3_DESCRI  := cX3_TITULO
	aCBOX 		:= {}
	If ! Empty(oQuery:aSX3[nI][8])
		aCBOX := StrTokArr( oQuery:aSX3[nI][8], ';')
	EndIf
	cX3_CONTEXT := "R"
	bWhen  		:= {|| .T.}
	If ! Empty(oQuery:aSX3[nI][16])
		bWhen := {|oModel,cField,cAction| U_MvcValid(oModel,cField,"WHEN") }
	EndIf
	bValid := {|| .T.}
	If ! Empty(oQuery:aSX3[nI][17])
		bValid := {|oModel,cField,cAction| U_MvcValid(oModel,cField,"VALID") }
	EndIf
	
	oStruct:AddField( ;
	cX3_TITULO,;              		// [01] Titulo do campo
	cX3_DESCRI,;              		// [02] ToolTip do campo
	cX3_CAMPO,;  					// [03] Id do Field
	cType,;             		 	// [04] Tipo do campo
	nSize,;             	 		// [05] Tamanho do campo
	nDecimal,;              		// [06] Decimal do campo
	bValid,;              			// [07] Code-block de validação do campo
	bWhen,;              			// [08] Code-block de validação When do campo
	AClone(aCBOX),;		// [09] Lista de valores permitido do campo
	oQuery:aSX3[nI][15],;   		// [10] Indica se o campo tem preenchimento obrigatório
	bRelac, ;              			// [11] Code-block de inicializacao do campo
	NIL, ;              			// [12] Indica se trata-se de um campo chave
	NIL, ;              			// [13] Indica se o campo pode receber valor em uma operação de update.
	( cX3_CONTEXT == 'V' ) )        // [14] Indica se o campo é virtual

	/* Exemplo tratamento inclusão de triggers
	 aAux := FwStruTrigger(;
	      "AD2_VEND" ,; // Campo Dominio
	      "AD2_NOMVEN" ,; // Campo de Contradominio
	      "SA3->A3_NOME",; // Regra de Preenchimento
	      .T. ,; // Se posicionara ou nao antes da execucao do gatilhos
	      "SA3",; // Alias da tabela a ser posicionada
	      1 ,; // Ordem da tabela a ser posicionada
	      "xFilial('SA3')+M->AD2_VEND",; // Chave de busca da tabela a ser posicionada
	      NIL ,; // Condicao para execucao do gatilho
	      "01" ) // Sequencia do gatilho (usado para identificacao no caso de erro)
	
	&((cNmVariav)):AddTrigger( ;
	      	aAux[1] , ;       // [01] Id do campo de origem
	      	aAux[2] , ;       // [02] Id do campo de destino
	      	aAux[3] , ;       // [03] Bloco de codigo de validação da execução do gatilho
	      	aAux[4] )       // [04] Bloco de codigo de execução do gatilho
	*/					
					
	// aGatilho := FwStruTrigger ( 'CNB_PRODUT' /*cDom*/, 'BM_DESC' /*cCDom*/, 'U_GV02INBM("BM_DESC",2)' /*cRegra*/, .F. /*lSeek*/, /*cAlias*/,  /*nOrdem*/, /*cChave*/, /*cCondic*/ )
	//oStruCNB:AddTrigger( aGatilho[1] /*cIdField*/, aGatilho[2] /*cTargetIdField*/, aGatilho[3] /*bPre*/, aGatilho[4] /*bSetValue*/ )


Next

RestArea( aAreaSX2 )
RestArea( aAreaSX3 )
RestArea( aAreaSIX )
RestArea( aArea )

Return oStruct

User Function MvcValid(oModel,cField,cAction)

Local lRet   := .T.
Local cExec  := ""
Local nQuery := nField := 0

For nQuery := 1 To Len(aQuery)
	If aQuery[nQuery][6]:cId == oModel:cId
		nField := Ascan(aQuery[nQuery][2]:aSX3, {|x| x[1] == cField })
		cExec  := ""
		If cAction == "WHEN" .And. nField > 0 .And. ! Empty(aQuery[nQuery][2]:aSX3[nField][16])
			cExec := aQuery[nQuery][2]:aSX3[nField][16]
		EndIF
		If cAction == "VALID" .And. nField > 0 .And. ! Empty(aQuery[nQuery][2]:aSX3[nField][17])
			cExec := aQuery[nQuery][2]:aSX3[nField][17]
		EndIF
		If ! Empty(cExec)
			lRet := &(cExec)
		EndIf
	EndIf 
Next

Return lRet

//------------------------------------------------------------------------------
/*/	{Protheus.doc} DefStrView

Monta estrutura da view. 

@sample	DefStrView( oQuery )

@param		ExpO1 - Objeto com dados da tabela 

@return		ExpL  - Verdadeiro / Falso

@author		Mobile
@since		27/01/2019
@version	12.0               
/*/
//------------------------------------------------------------------------------

Static Function DefStrView( oQuery )
Local nI
Local nJ
Local aArea     := GetArea()
Local oStruct   := FWFormViewStruct():New()
Local aCombo    := {}
Local nInitCBox := 0
Local nMaxLenCb := 0
Local aAux      := {}
Local cGSC      := ''
Local cX3_PICTVAR := ""

//-------------------------------------------------------------------
// Campos
//-------------------------------------------------------------------
For nJ := 1 To Len(oQuery:aSX3)
	If ! oQuery:aSX3[nJ][18]
		Loop
	EndIf

	cX3_CAMPO	:= oQuery:aSX3[nJ][1]
	cType 		:= oQuery:aSX3[nJ][2]
	nSize 		:= oQuery:aSX3[nJ][3]
	nDecimal 	:= oQuery:aSX3[nJ][4]
	cX3_TITULO 	:= oQuery:aSX3[nJ][6]
	cX3_DESCRI  := cX3_TITULO
	cX3_PICTURE	:= oQuery:aSX3[nJ][7]
	cX3_CBOX	:= oQuery:aSX3[nJ][8]
	cX3_F3		:= oQuery:aSX3[nJ][12]
	cX3_INIBRW	:= oQuery:aSX3[nJ][13]
	cX3_CONTEXT := "R"

	bPictVar := FwBuildFeature( STRUCT_FEATURE_PICTVAR, cX3_PICTVAR )

	aCombo := {}

	If ! Empty( cX3_CBOX )
		nInitCBox := 0
		nMaxLenCb := 0

		aAux := RetSX3Box( cX3_CBOX , @nInitCBox, @nMaxLenCb, nSize )

		For nI := 1 To Len( aAux )
			aAdd( aCombo, aAux[nI][1] )
		Next nI
	EndIf

	cGSC := IIf(Empty(aCombo), IIf( cType == 'L', 'CHECK', 'GET' ) , 'COMBO' )

	oStruct:AddField( ;
	cX3_CAMPO,;                			// [01] Campo
	StrZero(nJ,3),;                		// [02] Ordem
	cX3_TITULO,;                		// [03] Titulo
	cX3_DESCRI,;                		// [04] Descricao
	NIL,;                				// [05] Help
	cGSC,;                				// [06] Tipo do campo COMBO, Get ou CHECK
	cX3_PICTURE,;                		// [07] Picture
	bPictVar,;                			// [08] PictVar
	cX3_F3,;                			// [09] F3
	oQuery:aSX3[nJ][14],;  				// [10] Editavel
	NIL,;                				// [11] Folder
	NIL,;                				// [12] Group
	aCombo,;                			// [13] Lista Combo
	nMaxLenCb,;                			// [14] Tam Max Combo
	cX3_INIBRW,;                		// [15] Inic. Browse
	( cX3_CONTEXT == 'V' ) )            // [16] Virtual
Next

RestArea( aArea )

Return oStruct

// -------------------------------------------------------------------
/*/{Protheus.doc} TRGCommit
Tratamento para commit do Formulario
	
@author Wagner Mobile Costa
@since 01/04/2017
@version P12
/*/
// -------------------------------------------------------------------
Static Function TRGCommit(oMdl)

Local aArea  	  := GetArea(), lRet := .T.
Local cUserId     := __cUserId

Private lMsErroAuto	:= .F.
Private oModel      := oMdl:GetModel('TRGXMVCV')

If ! FWFormAfter(oMdl,{ ||TRGValid(oMdl) },"FORM")
	Return .F.
EndIf

Begin Transaction
__EXIT := .F.
U_ExcAdvpl(M->PQ6_GDVPL)
lRet := ! __EXIT
End Transaction

RestArea(aArea)

__cUserId := cUserId

Return lRet

//--------------------------------------------------------------------------
/*/{Protheus.doc} TRGValid
Validações do formulario

@author Wagner Mobile Costa
@since  31/05/2017
@param  oModel,Object,Model ativo a ser validado
@return lRetorno,Logico,Retorna se o formulário é valido

/*/
//-------------------------------------------------------------------------
Static Function TRGValid(oModel)

Local lRetorno   := .T.
Local oMdl	 	 := oModel:GetModel('TRGXMVCV')

Return( lRetorno )

//--------------------------------------------------------------------------
/*/{Protheus.doc} TRGLoad
Montagem do Grid de Detalhe

@author Wagner Mobile Costa
@since  20/06/2017
@param  oModel,Object,Objeto do Model Ativo
@return aGrid,Array,Array com as informações do detalhe

/*/
//-------------------------------------------------------------------------
Static Function TRGLoad(oGrid)

Local aArea   := GetArea()
Local aGrid	  := {}
Local aLinha  := {}
Local oQuery  := Nil
Local nQuery  := 1	
Local cId     := StrTran(oGrid:cId, "TRGXMVCV_", "")
Local nIdQry  := 1

For nQuery := 1 To Len(aQuery)
	If aQuery[nQuery][1] == cId
		oQuery := aQuery[nQuery][2]
		nIdQry := nQuery
	EndIf 
Next

If oQuery == Nil
	Return aGrid
EndIf

DbSelectArea(oQuery:cAlias)
U_FilJoin(nIdQry, aQuery)

While ! Eof()
	For nFields := 1 To Len(oQuery:aSX3)
		If ! oQuery:aSX3[nFields][18]
			Loop
		EndIf
		Aadd(aLinha, &(oQuery:cAlias + "->" + oQuery:aSX3[nFields][1]))
	Next
	aAdd(aGrid,{Recno(),AClone(aLinha)})
	aLinha := {}
	DbSkip()
EndDo

RestArea(aArea)

Return aGrid

User Function VldTrigger(cTabela, nOrdem, cChave, cField, cFldDesc, oModel)

Local lRet    := .T.
Local cDescri := "" 

DbSelectArea(cTabela)
DbSetOrder(nOrdem)
lRet := DbSeek(xFilial(cTabela) + cChave)
If ! lRet
	Help(,, "INVALIDO",, "Conteudo informado no campo invalido !", 1, 0)
Else
	oModel:SetValue(cField, &(cFldDesc))
EndIf

Return lRet