#Include "TOTVS.ch"
#Include "FWMVCDEF.ch"

User function CadOrc(aHeader, aItems, nOpr)
	Local oBrowse := NIL
	Local aArea   := GetArea()

    Private aRotina := MenuDef()

	If (aHeader == NIL)
		oBrowse := BrowseDef()
	Else
		FwMVCRotAuto(ModelDef(), "SZO", nOpr, {{"SZOMASTER", aHeader}, {"SZIDETAIL", aItems}})
	EndIf

	RestArea(aArea)
Return (NIL)

Static Function BrowseDef()
    Local oBrowse := NIL

    oBrowse := FwMBrowse():New()
	oBrowse:SetAlias("SZO")
	oBrowse:SetDescription("Cadastro de Orçamento")
	oBrowse:Activate()
Return (oBrowse)

Static Function MenuDef()
	Local aRotina := FwMVCMenu("CadOrc")
Return (aRotina)

Static Function ModelDef()
	Local oModel    := NIL
	Local oStruSZO  := FwFormStruct(1, "SZO")
	Local oStruSZI  := FwFormStruct(1, "SZI")
    Local aRelation := {}

	oModel := MPFormModel():New("CDORC")

	SZOStruDef(@oStruSZO)
	SZIStruDef(@oStruSZI)

	oModel:AddFields("SZOMASTER", /*cOwner*/, oStruSZO)
	oModel:AddGrid("SZIDETAIL", "SZOMASTER", oStruSZI)

	AAdd(aRelation, {"ZI_FILIAL", "FwXFilial('SZO')"})
	AAdd(aRelation, {"ZI_NUMORC", "ZO_NUMORC"})

	oModel:SetRelation("SZIDETAIL", aRelation, SZI->(IndexKey(1)))
	oModel:SetPrimaryKey({"ZO_NUMORC"})

	oModel:GetModel("SZIDETAIL"):SetUniqueLine({"ZI_CODPROD"})

	oModel:SetDescription("Cadastro de Orçamento")
	oModel:GetModel("SZOMASTER"):SetDescription("Cabeçalho do Orçamento")
	oModel:GetModel("SZIDETAIL"):SetDescription("Itens do Orçamento")
Return (oModel)

Static Function ViewDef()
	Local oView    := NIL
	Local oModel   := FwLoadModel("CadOrc")
	Local oStruSZO := FwFormStruct(2, "SZO")
	Local oStruSZI := FwFormStruct(2, "SZI")

	oView := FwFormView():New()
	oView:SetModel(oModel)

	oStruSZI:RemoveField("ZI_NUMORC")
	oStruSZO:RemoveField("ZO_VALIDOR")

	oView:AddField("VIEW_SZO", oStruSZO, "SZOMASTER")
	oView:AddGrid("VIEW_SZI", oStruSZI, "SZIDETAIL")

	oView:CreateHorizontalBox("HEADER", 35)
	oView:CreateHorizontalBox("GRID", 65)

	oView:SetOwnerView("VIEW_SZO", "HEADER")
	oView:SetOwnerView("VIEW_SZI", "GRID")

	oView:EnableTitleView("VIEW_SZO", "Cabeçalho do Orçamento")
	oView:EnableTitleView("VIEW_SZI", "Itens do Orçamento")

	oView:AddIncrementField("VIEW_SZI", "ZI_ITEM")
	oView:SetViewAction("DELETELINE", {|| U_CalcTotGer(FwModelActive())})
Return (oView)

Static Function SZOStruDef(oStruSZO)
	SZOInitPad(@oStruSZO)
	SZOWhen(@oStruSZO)
	SZORequired(@oStruSZO)
	SZOValid(@oStruSZO)
	SZOTrigger(@oStruSZO)
Return (NIL)

Static Function SZIStruDef(oStruSZI)
	SZIInitPad(@oStruSZI)
	SZIWhen(@oStruSZI)
	SZIRequired(@oStruSZI)
	SZIValid(@oStruSZI)
    SZITrigger(@oStruSZI)
Return (NIL)

Static Function SZOInitPad(oStruSZO)
	oStruSZO:SetProperty("ZO_NUMORC", MODEL_FIELD_INIT, {|| InitNumOrc()})
	oStruSZO:SetProperty("ZO_EMISSAO", MODEL_FIELD_INIT, {|| dDataBase})
Return (NIL)

Static Function SZIInitPad(oStruSZI)
	oStruSZI:SetProperty("ZI_FILIAL", MODEL_FIELD_INIT, {|| FwXFilial("SZI")})
Return (NIL)

Static Function SZOWhen(oStruSZO)
	oStruSZO:SetProperty("ZO_NUMORC", MODEL_FIELD_WHEN, {|| .F.})
	// oStruSZO:SetProperty("ZO_TOTGER", MODEL_FIELD_WHEN, {|| .F.})
	oStruSZO:SetProperty("ZO_NOME", MODEL_FIELD_WHEN, {|| .F.})
Return (NIL)

Static Function SZIWhen(oStruSZI)
	oStruSZI:SetProperty("ZI_NUMORC", MODEL_FIELD_INIT, {|| InitNumOrc()})
	// oStruSZI:SetProperty("ZI_ITEM", MODEL_FIELD_WHEN, {|| .F.})
	// oStruSZI:SetProperty("ZI_VALOR", MODEL_FIELD_WHEN, {|| .F.})
	oStruSZI:SetProperty("ZI_DESC", MODEL_FIELD_WHEN, {|| .F.})
Return (NIL)

Static Function SZORequired(oStruSZO)
	oStruSZO:SetProperty("ZO_NUMORC", MODEL_FIELD_OBRIGAT, .T.)
	oStruSZO:SetProperty("ZO_CODCLI", MODEL_FIELD_OBRIGAT, .T.)
	oStruSZO:SetProperty("ZO_LOJA", MODEL_FIELD_OBRIGAT, .T.)
	oStruSZO:SetProperty("ZO_NOME", MODEL_FIELD_OBRIGAT, .T.)
	oStruSZO:SetProperty("ZO_EMISSAO", MODEL_FIELD_OBRIGAT, .T.)
Return (NIL)

Static Function SZIRequired(oStruSZI)
	oStruSZI:SetProperty("*", MODEL_FIELD_OBRIGAT, .T.)
Return (NIL)

Static Function SZOValid(oStruSZO)
	oStruSZO:SetProperty("ZO_CODCLI", MODEL_FIELD_VALID, {|oStruSZO| ExistCpo("SA1", oStruSZO:GetValue("ZO_CODCLI"))})
	oStruSZO:SetProperty("ZO_LOJA", MODEL_FIELD_VALID, {|oStruSZO| ExistCpo("SA1", oStruSZO:GetValue("ZO_CODCLI") + oStruSZO:GetValue("ZO_LOJA"))})
	oStruSZO:SetProperty("ZO_CONDPAG", MODEL_FIELD_VALID, {|oStruSZO| ExistCpo("SE4", oStruSZO:GetValue("ZO_CONDPAG"))})
Return (NIL)

Static Function SZIValid(oStruSZI)
	oStruSZI:SetProperty("ZI_CODPROD", MODEL_FIELD_VALID, {|oStruSZI| ExistCpo("SB1", oStruSZI:GetValue("ZI_CODPROD"))})
Return (NIL)

Static Function SZOTrigger(oStruSZO)
	Local aTrigger := FwStruTrigger("ZO_LOJA",;
	                                "ZO_NOME",;
									"SA1->A1_NOME",;
									.T.,;
									"SA1",;
									1,;
									"FwXFilial('SA1') + M->ZO_CODCLI + M->ZO_LOJA")

	oStruSZO:AddTrigger(aTrigger[1], aTrigger[2], aTrigger[3], aTrigger[4])

	aTrigger := {}
	aTrigger := FwStruTrigger("ZO_CODCLI",;
	                          "ZO_NOME",;
							  "SA1->A1_NOME",;
							  .T.,;
							  "SA1",;
							  1,;
							  "FwXFilial('SA1') + M->ZO_CODCLI + M->ZO_LOJA")

	oStruSZO:AddTrigger(aTrigger[1], aTrigger[2], aTrigger[3], aTrigger[4])
Return (NIL)

Static Function SZITrigger(oStruSZI)
	Local aTrigger := FwStruTrigger("ZI_CODPROD",;
	                                "ZI_DESC",;
									"SB1->B1_DESC",;
									.T.,;
									"SB1",;
									1,;
									"FwXFilial('SB1') + M->ZI_CODPROD")

	oStruSZI:AddTrigger(aTrigger[1], aTrigger[2], aTrigger[3], aTrigger[4])

	aTrigger := {}
	aTrigger := FwStruTrigger("ZI_UNIT",;
	                          "ZI_VALOR",;
							  "M->ZI_VALOR := M->ZI_UNIT * M->ZI_QTDE",;
							  .F.,;
							  "",;
							  0,;
							  "",;
							  NIL,;
							  "01")

	oStruSZI:AddTrigger(aTrigger[1], aTrigger[2], aTrigger[3], aTrigger[4])

	aTrigger := {}
	aTrigger := FwStruTrigger("ZI_QTDE",;
	                          "ZI_VALOR",;
							  "M->ZI_VALOR := M->ZI_UNIT * M->ZI_QTDE",;
							  .F.,;
							  "",;
							  0,;
							  "",;
							  NIL,;
							  "01")

	oStruSZI:AddTrigger(aTrigger[1], aTrigger[2], aTrigger[3], aTrigger[4])

	aTrigger := {}
	aTrigger := FwStruTrigger("ZI_VALOR",;
	                          "ZI_VALOR",;
							  "U_CalcTotGer(FwModelActive())",;
							  .F.,;
							  "",;
							  0,;
							  "",;
							  NIL,;
							  "01")

	oStruSZI:AddTrigger(aTrigger[1], aTrigger[2], aTrigger[3], aTrigger[4])
Return (NIL)

Static Function InitNumOrc()
	Local cInit  := ""
	Local cAlias := GetNextAlias()
	Local cQuery := "SELECT MAX(ZO_NUMORC) AS MAX FROM SZO990"

	DbUseArea(.T., "TOPCONN", TcGenQry(NIL, NIL, cQuery), cAlias, .T., .T.)

	cInit := (cAlias)->(MAX)

	If (Empty(cInit) == .T.)
		cInit := StrZero(1, TamSX3("ZO_NUMORC")[1])
	EndIf

	cInit := Soma1(cInit)

	(cAlias)->(DbCloseArea())
Return (cInit)

User Function CalcTotGer(oModel)
	Local nSum    := 0
	Local oSubMdl := oModel:GetModel("SZIDETAIL")
	Local nLines  := oSubMdl:Length()

	For nX := 1 To nLines
		If (oSubMdl:IsDeleted(nX) == .T. .Or. oSubMdl:IsFieldUpdated("ZI_UNIT", nX) == .T. .Or. oSubMdl:IsFieldUpdated("ZI_QTDE", nX) == .T.)
			If (oSubMdl:IsDeleted(nX) == .F.)
				nSum += FwFldGet("ZI_VALOR", nX)
			EndIf
		EndIf

		FwFldPut("ZO_TOTGER", nSum, 0, FwModelActive(), .T., .T.)
	Next nX
Return (.T.)

// CadOrc
