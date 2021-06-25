#Include "TOTVS.CH"
#Include "FWMVCDEF.CH"

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Regras de Montagem do Modelo integrado com as consultas personalizadas

@author Wagner Mobile Costa
@version P12
@since 01/04/2015
@return oModel
/*/
//-----------------------------------------------------------------------------
Static Function ModelDef()

Local oModel, bActivate, bPreValid, bPosValid, bCommit  
Local oStruct  := Nil, nForms := 1, cTable := cView := ""
Local aForms   := AClone(aFormsMVC), bAvaField := Nil
Local cFunName := FunName(), lModelo1 := .F.

If IsPreValid(cFunName, "PREVALID")
	bPreValid := { |oModel| PreValid(cFunName, "PREVALID", oModel) }
EndIf

If IsPosValid(cFunName, "POSVALID")
	bPosValid := { |oModel| PosValid(cFunName, "POSVALID", oModel) }
EndIf

//-- Modelo 1
If (lModelo1 := ! Empty(aForms[1][6]))
	Aadd(aForms, AClone(aForms[1]))
	
	bAvaField := {|cCampo| FieldsCab(AllTrim(cCampo), aForms[1][6], nForms == 1) }
EndIf

If IsCommit()
	bCommit := { |oModel| Commit(oModel) }
ElseIf lModelo1
	bCommit := { |oModel| befCommit(oModel) .And. AftCommit(oModel) }
EndIf

If IsActivate()
	bActivate := { |oModel| Activate(oModel) }
EndIf

oModel := MPFormModel():New(Left(cFunName, 3) + "V" + Subs(cFunName, 5, Len(cFunName)), bPreValid, bPosValid, bCommit)
If bActivate <> Nil
	oModel:SetVldActivate(bActivate)
EndIf

For nForms := 1 To Len(aForms)
	cTable  := aForms[nForms][1]
	cView   := cTable
    oStruct := FWFormStruct(1, cTable, bAvaField)
    If nForms > 1 .And. ! Empty(aForms[nForms][6])
    	cView += AllTrim(Str(nForms))
    EndIf 

    If nForms == 1   //-- Cabecalho
       	oModel:AddFields(cTable,, oStruct )
		oModel:SetPrimaryKey({})
    Else             //-- Detalhes
		bPreValid := Nil
	   	If IsPreValid(cFunName, "PREVLD" + cTable)
			bPreValid := { |oModel| PreValid(cFunName, "PREVLD" + cTable, oModel) }
		EndIf
	
		bPosValid := Nil
	    If IsPosValid(cFunName, "POSVLD" + cTable)
			bPosValid := { |oModel| PosValid(cFunName, "POSVLD" + cTable, oModel) }
		EndIf

       	oModel:AddGrid( cView, aForms[1][1], oStruct, bPreValid, bPosValid )

       	oModel:SetRelation(cView, aForms[nForms][5], (cTable)->(IndexKey(1)))
       	oModel:GetModel(cView):SetDescription(aForms[nForms][2])
       	If aForms[nForms][3]	// Indica se o modelo é opcional
			oModel:GetModel(cView):SetOptional( .T. )
       	EndIf
	    If ! Empty(aForms[nForms][9])		// Indica validação de linha unica
			oModel:GetModel(cView):SetUniqueLine(aForms[nForms][9])
    	EndIf
    EndIf
    If aForms[nForms][4]		// Indica se o modelo é somente par visualização
		oModel:GetModel(cView):SetOnlyView( .T. )
    EndIf
Next

Return oModel

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Verifica existencia de pré-validação no modelo

@author Wagner Mobile Costa
@version P12
@since 05/04/2015
@return oModel
/*/
//-----------------------------------------------------------------------------
Static Function IsPreValid(cFunName, cFuncao)

Return ValType(PreValid(cFunName, cFuncao)) = "L"

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Executa função de pré-validação no modelo

@author Wagner Mobile Costa
@version P12
@since 05/04/2015
@return lExecute = Execução do PréValid
/*/
//-----------------------------------------------------------------------------
Static Function PreValid(cFunName, cFuncao, oModel)

_oModel := oModel

Return &("StaticCall(" + cFunName + ", " + cFuncao + ", _oModel)") 

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Verifica existencia de pós-validação no modelo

@author Wagner Mobile Costa
@version P12
@since 05/04/2015
@return oModel
/*/
//-----------------------------------------------------------------------------
Static Function IsPosValid(cFunName, cFuncao)

Return ValType(PosValid(cFunName, cFuncao)) = "L"

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Executa função de pós-validação no modelo

@author Wagner Mobile Costa
@version P12
@since 05/04/2015
@return oModel
/*/
//-----------------------------------------------------------------------------
Static Function PosValid(cFunName, cFuncao, oModel)

_oModel := oModel

Return &("StaticCall(" + cFunName + ", " + cFuncao + ", _oModel)") 

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Verifica existencia de ativação no modelo

@author Wagner Mobile Costa
@version P12
@since 05/04/2015
@return oModel
/*/
//-----------------------------------------------------------------------------
Static Function IsActivate()

Return ValType(Activate()) = "L"

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Executa função de ativação no modelo

@author Wagner Mobile Costa
@version P12
@since 05/04/2015
@return oModel
/*/
//-----------------------------------------------------------------------------
Static Function Activate(oModel)

_oModel := oModel

Return &("StaticCall(" + FunName() + ", ACTIVATE, _oModel)") 

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Verifica existencia de ativação no modelo

@author Wagner Mobile Costa
@version P12
@since 05/04/2015
@return oModel
/*/
//-----------------------------------------------------------------------------
Static Function IsCommit()

Return ValType(Commit()) = "L"

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Executa procedimentos antes do procedimento de commit

@author Wagner Mobile Costa
@version P12
@since 28/04/2015
@return lCommit = Retorna logico indicando se o commit foi realizado
/*/
//-----------------------------------------------------------------------------
Static Function BefCommit(oModel)

BeginTran()

FwFormCommit(oModel)  // Grava o Modelo

Return .T.

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Executa função de gravação no modelo

@author Wagner Mobile Costa
@version P12
@since 05/04/2015
@return lCommit = Retorna logico indicando se o commit foi realizado
/*/
//-----------------------------------------------------------------------------
Static Function Commit(oModel)

_oModel := oModel

Return &("StaticCall(" + FunName() + ", COMMIT, _oModel)") 

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Executa procedimentos após do procedimento de commit

@author Wagner Mobile Costa
@version P12
@since 28/04/2015
@return lCommit = Retorna logico indicando se o commit foi realizado
/*/
//-----------------------------------------------------------------------------
Static Function AftCommit(oModel)

Local oModelTab, oStruTab, aFields := {}, cSQL := "", nFields := 1

If oModel:GetOperation() = MODEL_OPERATION_UPDATE
	oModelTab := oModel:GetModel( aFormsMVC[1][1] )
	oStruTab  := oModelTab:GetStruct()
	aFields   := oStruTab:GetFields()
	For nFields := 1 To Len(aFields)
		If ! aFields[nFields][MODEL_FIELD_VIRTUAL]
			If Empty(cSQL)
				cSQL := "update " + RetSqlName(aFormsMVC[1][1]) + " set "
			Else
				cSQL += ","
			EndIf
			cSQL += aFields[nFields][MODEL_FIELD_IDFIELD] + " = "
			If aFields[nFields][MODEL_FIELD_TIPO] = "D"
				cSQL += "'" + Dtos(oModelTab:GetValue(aFields[nFields][MODEL_FIELD_IDFIELD])) + "'"
			Else
				cSQL += "'" + oModelTab:GetValue(aFields[nFields][MODEL_FIELD_IDFIELD]) + "'"
			EndIf
		EndIf
	Next
	
	If ! Empty(cSQL)
		cSQL += " where D_E_L_E_T_ = ' ' "
		For nFields := 1 To Len(aFormsMVC[1][5])
			cSQL += " and " + aFormsMVC[1][5][nFields][1] + " = '"
			If At("(", aFormsMVC[1][5][nFields][2])
				cSQL += &(aFormsMVC[1][5][nFields][2]) 
			Else
				cSQL += oModelTab:GetValue(aFormsMVC[1][5][nFields][1])
			EndIf
			cSQL += "'"
		Next

		If (nError := TCSQLExec(cSQL)) <> 0
   			Help(,, "AFTCOMMIT:" + aFormsMVC[1][1],, AllTrim(Str(nError)) + "-" + TCSQLError(), 1, 0)
   			DisarmTran()
   			Return .F.
		EndIf
	EndIf
EndIf

EndTran()

Return .T.


//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Regras de Apresentação do Modelo integrado com as consultas personalizadas

@author Wagner Mobile Costa
@version P12
@since 01/04/2015
@return oModel
/*/
//-----------------------------------------------------------------------------
Static Function ViewDef()

Local oView   	:= FWFormView():New()
Local oModel  	:= FWLoadModel('TCTTXMVC')
Local oStruct 	:= Nil, nForms := 1, nTam := 0
Local aForms  	:= AClone(aFormsMVC), cView := cOwner := ""
Local bAvaField := Nil
Local bPreValid, bPosValid
Local cFunName 	:= FunName()
Local lFolder	:= Len(aFormsMVC) > 2

oView:SetModel(oModel)

//-- Modelo 1
If ! Empty(aForms[1][6])
	Aadd(aForms, AClone(aForms[1]))

	bAvaField := {|cCampo| FieldsCab(AllTrim(cCampo), aForms[1][6], nForms == 1) }
	aForms[Len(aForms)][8] := 100 - aForms[1][8]
EndIf

For nForms := 1 To Len(aForms)
    cTable := aForms[nForms][1]
    cView  := cTable
    If nForms > 1 .And. ! Empty(aForms[nForms][6])
    	cView += AllTrim(Str(nForms))
    EndIf

	nTam := aForms[nForms][8]
	If nTam == 0
		nTam := 100 / Len(aForms)
	EndIf

	bPreValid := Nil
   	If IsPreValid(cFunName, "PREVLD" + cTable)
		bPreValid := { |oModel| PreValid(cFunName, "PREVLD" + cTable, oModel) }
	EndIf

	bPosValid := Nil
    If IsPosValid(cFunName, "POSVLD" + cTable)
		bPosValid := { |oModel| PosValid(cFunName, "POSVLD" + cTable, oModel) }
	EndIf

    oStruct := FWFormStruct(2, cTable, bAvaField)

    If nForms == 1   //-- Cabecalho
       	oView:AddField( 'VIEW_' + cTable, oStruct, cTable)
    Else
    	If lFolder .And. nForms = 2
			oView:CreateHorizontalBox( 'INFERIOR' , nTam )
			oView:CreateFolder( 'PASTAS', 'INFERIOR' )
		EndIf
		
       	//-- Detalhes
       	oView:AddGrid( 'VIEW_' + cView, oStruct, cView, bPreValid, bPosValid)
       	If ! Empty(aForms[nForms][7])
        	oView:AddIncrementField('VIEW_' + cView, aForms[nForms][7])
       	EndIf

    	If lFolder
			oView:AddSheet( 'PASTAS', 'FLD' + cTable, aForms[nForms][2] )
		Else
			oView:EnableTitleView('VIEW_' + cView, aForms[nForms][2])
    	EndIf
    EndIf
    
    If lFolder
    	cOwner := "SUPERIOR"
    	If nForms = 1
			oView:CreateHorizontalBox( 'SUPERIOR' , nTam )
    	Else
    		cOwner := 'GRID_' + cView
    		oView:CreateHorizontalBox(cOwner , 100,,, 'PASTAS', 'FLD' + cTable)
    	EndIf
	    oView:SetOwnerView( 'VIEW_' + cView, cOwner )
    Else 
    	oView:CreateHorizontalBox( 'BOX_' + cView, nTam)
	    oView:SetOwnerView( 'VIEW_' + cView, 'BOX_' + cView )
    EndIf
Next

Return oView

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Regras de Apresentação do Modelo integrado com as consultas personalizadas

@author Wagner Mobile Costa
@version P12
@since 01/04/2015
@return lUseField
/*/
//-----------------------------------------------------------------------------
Static Function FieldsCab(cField, cFieldCab, lCabec)

Local lFieldCab := .F.

If cField $ cFieldCab
	lFieldCab := .T.
EndIf

Return If((lFieldCab .And. lCabec) .Or. (! lCabec .And. ! lFieldCab), .T., .F.)

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Função para execução de inclusão via SXB

@author Wagner Mobile Costa
@version P12
@since 28/04/2015
/*/
//-----------------------------------------------------------------------------
User Function TRGXIMVC(cModel)

Local cFunName  := FunName()
Local aForms    := If(Type("aFormsMVC") = "U", Nil, AClone(aFormsMVC))
Local oModelAct := FwModelActive(), oModel

SetFunName(cModel)

oModel := FwLoadModel(cModel)
FWExecView("Inclusão",cModel, MODEL_OPERATION_INSERT, , { || .T. },,,,,,, oModel )

If aForms <> Nil
	aFormsMVC := AClone(aForms)
EndIf
SetFunName(cFunName)
FwModelActive(oModelAct)

Return

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Função para execução de visualização via SXB

@author Wagner Mobile Costa
@version P12
@since 28/04/2015
/*/
//-----------------------------------------------------------------------------
User Function TRGXVMVC(cModel)

Local cFunName  := FunName()
Local aForms    := If(Type("aFormsMVC") = "U", Nil, AClone(aFormsMVC))
Local oModelAct := FwModelActive(), oModel

SetFunName(cModel)

oModel := FwLoadModel(cModel)
FWExecView("Visualização",cModel, 1, , { || .T. },,,,,,, oModel )

If aForms <> Nil
	aFormsMVC := AClone(aForms)
EndIf
SetFunName(cFunName)
FwModelActive(oModelAct)

Return