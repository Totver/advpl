#INCLUDE "PROTHEUS.CH"
#Include "FWMVCDef.CH"

STATIC aForms 	:= { { 	"" /* Tabela */, "" /* DescriÁ„o */, .F. /* SetOptional */, .F.  /* SetOnlyView */, { } /* Relation */,;
						"" /* Fields Modelo 1 */, /* AutoIncremento */ "", 0 /* Area do Componente */, {} /* Unique Line */ } }
Static __PQ6   	:= {}

User Function TRGC020(CID, cDebug, cFilter)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Tela de ExibiÁ„o Consultas Personalizadas
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local aArea := {}, cPerg := "", bSetKeyF12 := Nil, nPos := 1
Local _oBrowse    := If(Type("oBrowse") == "U", Nil, oBrowse) 
Local _oCQuery    := If(Type("oCQuery") == "U", Nil, oCQuery) 
Local _aQuery     := If(Type("aQuery") == "U", Nil, AClone(aQuery)) 
Local lRet		  := .F.
Local nPar		  := 1

Private oBrowse, oCQuery, aQuery := {}, aCols := {}, aHeader := {}, N := 1, __QUERY := Nil

For nPar := 1 To 30
	&("mv_par" + StrZero(nPar, 2)) := ""
Next

PQ1->(DbSetOrder(1))
PQ1->(DbSeek(xFilial() + CID))
aArea := PQ1->(GetArea())
__PQ1_ID    := CID
__PQ1_PRSQL := ""

Private cCadastro := cTitulo := Capital(AllTrim(PQ1->PQ1_NOME))

M->PQ1_ID := PQ1->PQ1_ID
cPerg  := AllTrim(PQ1->PQ1_SX1)
aForms := {}
If ! Empty(PQ1->PQ1_SX2)
	aForms := { PQ1->PQ1_SX2, cTitulo }
EndIf

If ! Empty(cPerg)
	Pergunte(cPerg, .F.)

	bSetKeyF12 := SetKey(VK_F12,{|| Pergunte(cPerg, .T.)})
EndIf

MsAguarde({|| lRet := MontaForm(cId,cDebug,cFilter) },"Aguarde...","Montando Consulta [" + cTitulo + "]")

PQ6->(DbSeek(xFilial() + cID))
RecLock("PQ1",.F.)
PQ1->PQ1_UTILIZ++
PQ1->(MsUnlock())

For nPos := 1 To Len(aQuery)
	aQuery[nPos][2]:Destroy()
Next
SetKey(VK_F12,bSetKeyF12)

//-- Restaura variaveis referente a consulta
If _oBrowse <> Nil
	oBrowse := _oBrowse
EndIf
If _oCQuery <> Nil
	oCQuery := _oCQuery
EndIf
If _aQuery <> Nil
	aQuery := AClone(_aQuery)
EndIf

Return

Static Function MontaForm(cId, cDebug, cFilter)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Montagem do formulario da consulta personalizada
<Data> : 31/07/2017
<Parametros> : cId = Id do formulario e cFilter = Filtro a ser aplicado no formulario
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local oFWLayer  := FWLayer():New() 
Local oPnlCapa, oDlg
Local aFolder   := {}, aId := {}, aJoin := {}
Local nPos      := 1
Local cQuery	:= ""
Local aSize     := {}

cQuery := "SELECT PQ7.PQ7_IDSUB, PQ1.PQ1_NOME, PQ7.PQ7_JOIN, PQ7.PQ7_IDPAR "
cQuery +=   "FROM " + RETSQLNAME("PQ7")+" PQ7 "
cQuery +=   "JOIN " + RETSQLNAME("PQ1")+" PQ1 ON PQ1.D_E_L_E_T_ = ' ' AND PQ1.PQ1_FILIAL = PQ7.PQ7_FILIAL AND PQ1.PQ1_ID = PQ7.PQ7_IDSUB "
cQuery +=  "WHERE PQ7.D_E_L_E_T_ = ' ' AND PQ7.PQ7_FILIAL='"+xFilial("PQ7")+"' AND PQ7.PQ7_ID = '" + PQ1->PQ1_ID + "' "  
cQuery +=  "ORDER BY PQ7.PQ7_ORDEM"

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"QRY",.F.,.T.)

While ! QRY->(Eof())
	Aadd(aId, { QRY->PQ7_IDSUB, QRY->PQ7_IDPAR } )
	Aadd(aFolder, AllTrim(Capital(QRY->PQ1_NOME)) )
	Aadd(aJoin, AllTrim(QRY->PQ7_JOIN) )
	QRY->(DbSkip())
EndDo
QRY->(DbCloseArea())

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Calcula as dimensoes dos objetos                                          ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
aSize := MsAdvSize()

DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSize[7],00 TO aSize[6],aSize[5] OF oMainWnd PIXEL

oFWLayer:Init(oDlg,.F.)

oFWLayer:AddLine( 'UP', If(Len(aFolder) > 0, 45, 100), .F.)
oFWLayer:AddCollumn( 'ALLUP', 100, .T., 'UP')
oPnlCapa := oFWLayer:GetColPanel ('ALLUP', 'UP')

If ! CreateBrowse(oPnlCapa, M->PQ1_ID, cDebug, "", cFilter, "")
	Return .F.
EndIF

oCQuery := aQuery[1][2]
oBrowse := aQuery[1][4]

oBrowse:SetProfileID(cID + '1')
oBrowse:ForceQuitButton()

If Len(aFolder) > 0
	// Define painel Detail
	oFWLayer:AddLine( 'DOWN', 55, .F.)
	oPnlDetail := oFWLayer:GetLinePanel ('DOWN')

	oFolder := TFolder():New( 0, 0, aFolder, aFolder, oPnlDetail,,,, .T.,,oPnlDetail:NCLIENTWIDTH/2,(oPnlDetail:NCLIENTHEIGHT/2))

	For nPos := 1 To Len(aId)
		If ! CreateBrowse(oFolder:aDialogs[nPos], aId[nPos][1], cDebug, aJoin[nPos], "", aId[nPos][2])
			Return .F.
		EndIf

		aQuery[nPos + 1][4]:SetProfileID(cID + AllTrim(Str(nPos + 1)))
	Next
EndIf

For nPos := 1 To Len(aQuery)
	aQuery[nPos][4]:Activate()
	If aQuery[nPos][4]:cClassName = "FWBROWSE" .And. aQuery[nPos][4]:oPanelBrowse <> Nil
		aQuery[nPos][4]:oPanelBrowse:Align := CONTROL_ALIGN_ALLCLIENT
	EndIf

	If nPos > 1 .And. ! Empty(aQuery[nPos][5])
		oRelation := FWBrwRelation():New()
		oRelation:AddRelation( oBrowse, aQuery[nPos][4], aQuery[nPos][5] )
		oRelation:Activate()
	EndIf
Next

aQuery[1][4]:oBrowse:SetFocus()

Activate MsDialog oDlg

Return

Static Function CreateBrowse(oOwner, cPQ1_ID, cDebug, cJoin, cFilter, cPQ1_IDPAR)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Montagem de menu padr„o para manutenÁ„o da consulta
<Data> : 21/03/2014
<Parametros> : oQuery = Objeto com as propriedades da consulta personalizada, oOwner = Objeto para criaÁ„o e cPQ1_ID = Id da consulta personalizada
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local oQuery, nPos := 1, oBrowse, aColsIni := {}, aSeek := {}, aIndex := {}, aObj := {}
Local aRotina := U_MntRtZAD(cPQ1_ID, PQ9->(DbSeek(xFilial() + cPQ1_ID + RetCodUsr())))
Local lMark   := .F.

oQuery := TCQuery():New(cPQ1_ID, cDebug == "1")
oCQuery := oQuery
oQuery:cPQ1_IDPAR := cPQ1_IDPAR
cAlias := oQuery:Alias()
If ! oQuery:Activate()
	Return .F.
EndIf

If PQ1->PQ1_ID <> cPQ1_ID
	PQ1->(DbSetOrder(1))
	PQ1->(DbSeek(xFilial() + cPQ1_ID))
EndIf

If PQ1->PQ1_MARK == "1"
	oBrowse := FWMarkBrowse():New()
	oBrowse:SetFieldMark( PQ1->PQ1_FLDMRK )
	oBrowse:SetAllMark( {|| MarkAll(oQuery:Alias(), oBrowse)} )
	lMark := .T.
Else
	oBrowse := FWMBrowse():New()
EndIf

oBrowse:SetOwner(oOwner)
oBrowse:SetAlias(oQuery:Alias())

If Len(oQuery:aSX3) > 0
	For nPos := 1 To Len(oQuery:aSX3)
		If oQuery:aSX3[nPos][10] == "N"
			Loop
		EndIf
		//Filial do Sistema
		AAdd(aColsIni,FWBrwColumn():New())
		nLinha := Len(aColsIni)
		If ! Empty(oQuery:aSX3[nPos][13])
			aColsIni[nLinha]:SetData(&(	"{|| " + AllTrim(oQuery:aSX3[nPos][13]) + " }"))
		Else
			aColsIni[nLinha]:SetData(&(	"{|| " + oQuery:Alias() + "->" + AllTrim(oQuery:aSX3[nPos][1]) + " }"))
		EndIf
		aColsIni[nLinha]:SetTitle(oQuery:aSX3[nPos][6])
		aColsIni[nLinha]:SetSize(oQuery:aSX3[nPos][3])
		aColsIni[nLinha]:SetDecimal(oQuery:aSX3[nPos][4])
		If ! Empty(oQuery:aSX3[nPos][8])
			aColsIni[nLinha]:SetOptions(Separa(oQuery:aSX3[nPos][8], ";"))
		EndIf
		If oQuery:aSX3[nPos][7] == "@BMP"
			aColsIni[nLinha]:SetImage(.T.)
		Else
			aColsIni[nLinha]:SetPicture(oQuery:aSX3[nPos][7])
		EndIf
	Next
	
	For nPos := 1 To Len(oQuery:aIndTrb)
		Aadd( aSeek, { AllTrim(oQuery:aIndTrb[nPos][3]), RetFldIdx(AllTrim(oQuery:aIndTrb[nPos][2])), 1 } )
		Aadd( aIndex, AllTrim(oQuery:aIndTrb[nPos][2]) )
	Next
	
	oBrowse:SetColumns(aColsIni)
	If ! lMark
		oBrowse:SetQueryIndex(aIndex)
	EndIf
  	oBrowse:SetSeek(,aSeek)
EndIf
oBrowse:SetProfileID(cPQ1_ID)
oBrowse:SetMenuDef(cPQ1_ID)

Aadd(aRotina, { "Atualizar", "aQuery[" + AllTrim(Str(Len(aQuery) + 1)) + "][2]:TelaParms(.T., aQuery, " + AllTrim(Str(Len(aQuery) + 1)) + ")", 0, 3 } )

For nPos := 1 To Len(aRotina)
	oBrowse:AddButton(aRotina[nPos][1],aRotina[nPos][2],, aRotina[nPos][4], aRotina[nPos][3],, aRotina[nPos][4] )
Next

Aadd(aQuery, { cPQ1_ID, oQuery, AClone(aRotina), oBrowse, RetJoin(cJoin), Nil })

If ! Empty(cFilter)
	If ! Empty(oQuery:cPQ1_FILTER)
		oQuery:cPQ1_FILTER += '+ " .And. " +'
	EndIf
	oQuery:cPQ1_FILTER += '"' + cFilter + '"'
EndIf

If ! Empty(oQuery:cPQ1_FILTER)
	oBrowse:AddFilter("FILTRO", cFilter := &(oQuery:cPQ1_FILTER),.T.,.T.,oQuery:cPQ1_SX2)
	oBrowse:SetFilterDefault(cFilter)
EndIf

//-- Filtro padr„o ativo ou inativos
If FieldPos(oQuery:Alias() + "_MSBLQL") > 0
	oBrowse:SetAttach( .T. )
	oTableAtt := TableAttDef(oQuery)

	If oTableAtt <> Nil
		oBrowse:SetViewsDefault(oTableAtt:aViews)
	EndIf
	oBrowse:SetOpenChart( .F. )
EndIf

oBrowse:DisableDetails()

Return .T.

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Regras de Montagem do Modelo

@author Wagner Mobile Costa
@version P12
@since 06/04/2015
@return oModel
/*/
//-----------------------------------------------------------------------------
Static Function ModelDef()

aFormsMVC := AClone(aForms)
SetFunName(M->PQ1_ID)

Return &("StaticCall(TRGXMVC,MODELDEF)")

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Regras de ApresentaÁ„o do Modelo

@author Wagner Mobile Costa
@version P12
@since 06/04/2015
@return oModel
/*/
//-----------------------------------------------------------------------------
Static Function ViewDef()

Return &("StaticCall(TRGXMVC,VIEWDEF)")

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
AtivaÁ„o do modelo do cadastro de Salas

@author Wagner Mobile Costa
@version P12
@since 07/04/2015
@return oModel
/*/
//-----------------------------------------------------------------------------
Static Function Activate(oModel)

Local nOperation := 0
Local aError	 := {}, cError := "", nError := 0
Local aArea		 := GetArea()

If oModel == Nil	//-- … realizada chamada com modelo nulo para verificar se a funÁ„o existe
	Return .F.
EndIf

nOperation := oModel:GetOperation()

If nOperation == MODEL_OPERATION_DELETE
EndIf

RestArea(aArea)

Return Len(aError) == 0

//------------------------------------------------------------------------------
/*/	{Protheus.doc} TableAttDef
Cria visıes padr„o
@sample	TableAttDef()
@param	Nenhum
@return	ExpO - Objetos com as Visoes
@author	Wagner Mobile Costa
@since		11/04/2015
@version	12
/*/
//------------------------------------------------------------------------------
Static Function TableAttDef(oQuery)

Local oTableAtt 	:= FWTableAtt():New()
Local aFields		:= {}
// Visıes
Local oAtivos 		:= Nil // Ativos
Local oInativo		:= Nil // Inativos
Local cAlias		:= oQuery:Alias()

oTableAtt:SetAlias(cAlias)

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek(cAlias)
While X3_ARQUIVO == cAlias .And. ! Eof()
	If X3_BROWSE == "S"
		Aadd(aFields, X3_CAMPO)
	EndIf
	DbSkip()
EndDo

// Vendedores Ativos
oDSAtivos := FWDSView():New()
oDSAtivos:SetName("Ativos")
oDSAtivos:SetID("DSAtivos")
oDSAtivos:SetOrder(1)
oDSAtivos:SetCollumns(aFields)
oDSAtivos:SetPublic( .T. )
oDSAtivos:AddFilter("Ativos", cAlias + "_MSBLQL == '2'")

oTableAtt:AddView(oDSAtivos)

// Vendedores Inativos
oDSInativ := FWDSView():New()
oDSInativ:SetName("Inativos")
oDSInativ:SetID("DSInativ")
oDSInativ:SetOrder(1)
oDSInativ:SetCollumns(aFields)
oDSInativ:SetPublic( .T. )
oDSInativ:AddFilter("Inativos", cAlias + "_MSBLQL == '1'") 

oTableAtt:AddView(oDSInativ)

Return oTableAtt

Static Function Title(cPQ1_ID)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Retorna o titulo de cada grid a partir do n˙mero da consulta
<Data> : 01/09/2013
<Parametros> : cPQ1_ID = CÛdigo da consulta
<Retorno> : cPQ1_NOME = DescriÁ„o da Consulta
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local cCadastro := "", aArea := PQ1->(GetArea())

If PQ1->PQ1_ID <> cPQ1_ID
	PQ1->(DbSetOrder(1))
	PQ1->(DbSeek(xFilial() + cPQ1_ID))
EndIf

cCadastro := Capital(AllTrim(PQ1->PQ1_NOME))       

PQ1->(RestArea(aArea))

Return cCadastro

User Function MntRtZAD(cPQ1_ID, lTemPQ9, aOrders)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Montagem das aÁıes do formul·rio a partir do n˙mero da consulta
<Data> : 01/09/2013
<Parametros> : cPQ1_ID = CÛdigo da consulta e nQuery -> 1=oCQuery, 2=oCQueryD e 3=oCQueryE
<Retorno> : cPQ1_NOME = DescriÁ„o da Consulta
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local aArea   := GetArea(), aRotina := {}
Local lInsert := .F., nOrders := 0

DEFAULT aOrders := {}

PQ6->(DbSeek(xFilial() + cPQ1_ID))
While PQ6->PQ6_ID == cPQ1_ID .And. ! PQ6->(Eof())
	If Len(aOrders) > 0
		lInsert := .F.
		For nOrders := 1 To Len(aOrders)
			If ! lInsert
				lInsert := aOrders[nOrders][1] == PQ6->PQ6_ORDEM
			EndIf
		Next
	Else
		lInsert := ! lTemPQ9 .Or. fTemPermis(PQ6->PQ6_ID, PQ6->PQ6_ORDEM)
	EndIf
	if lInsert
		If Ascan(__PQ6, { |x| x[1] == cPQ1_ID .And. x[2] == PQ6->PQ6_ORDEM }) == 0
			Aadd(__PQ6, { 	cPQ1_ID, PQ6->PQ6_ORDEM, AllTrim(PQ6->PQ6_DESCRI), PQ6->PQ6_ADVPL, PQ6->PQ6_SQL,;
							PQ6->PQ6_GDVPL, PQ6->PQ6_GSQL, PQ6->PQ6_ACTIVA })
		EndIf
		
		If Left(PQ6->PQ6_ADVPL, 7) = "VIEWDEF"
			Aadd(aRotina, { AllTrim(PQ6->PQ6_DESCRI), PQ6->PQ6_ADVPL, 0, PQ6->PQ6_ACAO } )
		Else
			Aadd(aRotina, { AllTrim(PQ6->PQ6_DESCRI),'U_ExecMemo("' + cPQ1_ID + '", "' + PQ6->PQ6_ORDEM + '")', 0, PQ6->PQ6_ACAO } )
		EndIf
		
	endif
	
	PQ6->(DbSkip())
EndDo

RestArea(aArea)
            
Return aRotina

Static Function fTemPermis( clId, clOrdem )

	Local llRet := .F.
	Local clSQL := " SELECT PQ9_ACESSO FROM " + RetSQLName("PQ9") + " WHERE D_E_L_E_T_ = ' ' AND PQ9_ID = '" + clId + "' AND PQ9_LINHA = '" + clOrdem + "' " +;
	                   "AND PQ9_USER = '" + RetCodUsr() + "' "
	Local clAlias	:= GetNextAlias()
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,clSQL),clAlias,.F.,.T.)
	
	if !( clAlias )->( Eof() ) .And. ( clAlias )->PQ9_ACESSO == 'S'
		llRet := .T.
	endif

Return  llRet

Static Function RetFldIdx(cIndice)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Retorna a lista de campos que compoem um indice
<Data> : 21/03/2014
<Parametros> : cIndice = Join no formato string como A1_COD+A1_LOJA
<Retorno> : aIndex = Formato { {"", SX3->X3_TIPO, SX3->X3_TAMANHO, SX3->X3_DECIMAL, SX3->X3_TITULO,,} }
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local aIdx := {}, aArea := SX3->(GetArea())

cIndice := AllTrim(cIndice)
If Right(cIndice, 1) <> "+"
	cIndice += "+"
EndIf

SX3->(DbSetOrder(2))

While At("+", cIndice) > 0
	SX3->(DbSeek(Left(AllTrim(Left(cIndice, At("+", cIndice) - 1)) + Space(Len(SX3->X3_CAMPO)), Len(SX3->X3_CAMPO))))
	Aadd(aIdx, {"", SX3->X3_TIPO, SX3->X3_TAMANHO, SX3->X3_DECIMAL, SX3->X3_TITULO,,})
	
	cIndice := Subs(cIndice, At("+", cIndice) + 1, Len(cIndice))
EndDo

SX3->(RestArea(aArea))

Return aIdx

User Function RetJoin(cJOIN)

Return RetJoin(cJoin) 

Static Function RetJoin(cJOIN)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Retorna a instruÁ„o para o relacionamento entre os formul·rios
<Data> : 01/09/2013
<Parametros> : cJoin = Join no formato string como E1_CLIENTE=A1_COD;E1_LOJA=A1_LOJA
<Retorno> : aJoin = Formato { { "CAMPO FK", "CAMPO PK", Operador } }
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local aJoin := {}, cFieldFK := cFieldPK := ""

cJoin := AllTrim(cJoin)
If Right(cJoin, 1) <> ";" .And. ! Empty(cJoin)
	cJoin += ";"
EndIf

While At(";", cJoin) > 0
	cFieldFK := Left(Left(cJoin, At(";", cJoin) - 1), At("=", cJoin) - 1)
	cFieldPK := Subs(Left(cJoin, At(";", cJoin) - 1), At("=", cJoin) + 1)
	Aadd(aJoin, { cFieldFK, cFieldPK, "==" })  
	
	cJoin := Subs(cJoin, At(";", cJoin) + 1, Len(cJoin))
EndDo

Return aJoin

User Function ExecMemo(cPQ1_ID, cPQ6_ORDEM, lRefresh)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Executa a instruÁ„o em formato memo
<Data> : 02/09/2013
<Parametros> : cPQ1_ID = Id da Consulta e cPQ6_ORDEM = Ordem de ExecuÁ„o
<Retorno> : 
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nExec  := Ascan(__PQ6, { |x| x[1] == cPQ1_ID .And. x[2] == cPQ6_ORDEM }), nPos := Ascan(aQuery, { |x| x[1] == cPQ1_ID })
Local nQuery := 1

DEFAULT lRefresh := .T.

If ! Empty(aQuery[nPos][2]:cPQ1_SX2) .And. aQuery[nPos][2]:cPQ1_SX2 <> aQuery[nPos][2]:cAlias
	(aQuery[nPos][2]:cPQ1_SX2)->(DbGoto((aQuery[nPos][2]:cAlias)->(Recno())))
EndIf

If nExec > 0
	cCadastro := cTitulo + " [" + __PQ6[nExec][3] + "]"

	M->PQ6_ADVPL  := __PQ6[nExec][4]
	M->PQ6_SQL    := __PQ6[nExec][5]
	M->PQ6_GDVPL  := __PQ6[nExec][6]
	M->PQ6_GSQL   := __PQ6[nExec][7]
	M->PQ6_ACTIVA := __PQ6[nExec][8]
	__QUERY       := aQuery[nPos][3]

	__REFRESH := .F.

	aRotina := AClone(aQuery[nPos][3])

	U_ExcAdvpl(M->PQ6_ADVPL)

	If __REFRESH .And. lRefresh
		For nQuery := 1 To Len(aQuery)
			aQuery[nQuery][2]:Refresh(.F., aQuery, nPos)
		Next
	EndIf
EndIf

Return

User Function ExcAdvpl(cAdvpl)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : ExecuÁ„o de Script ADVPL
<Data> : 16/09/2013
<Parametros> : cAdvpl = Script Advpl a ser executado
<Retorno> : 
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nLin := nPos := 1, aExec := {}, cExec := "", bBlock

SaveInter()
	
While Len(cAdvpl) > 0
	If Subs(cAdvpl, nLin, 2) == Chr(13) + Chr(10) .Or. Subs(cAdvpl, nLin, 2) == ";;" .Or. nLin >= Len(cAdvpl)
		nPos := Len(cAdvpl)
		If Subs(cAdvpl, nLin, 2) == ";;"
			nPos := At(";;", cAdvpl) - 1
		ElseIf Subs(cAdvpl, nLin, 2) == Chr(13) + Chr(10)
			nPos := At(Chr(13) + Chr(10), cAdvpl) - 1
		EndIf

		cExec := StrTran(Left(cAdvpl, nPos), Chr(13) + Chr(10), "")
		
		Aadd(aExec, cExec)
		
		nPos := Len(cAdvpl) + 1
		If Subs(cAdvpl, nLin, 2) == ";;"
			nPos := At(";;", cAdvpl) + 2
		ElseIf Subs(cAdvpl, nLin, 2) == Chr(13) + Chr(10)
			nPos := At(Chr(13) + Chr(10), cAdvpl) + 2
		EndIf
		
		cAdvpl := Subs(cAdvpl, nPos, Len(cAdvpl))
		nLin := 1
	EndIf
	nLin ++
EndDo

__EXIT := .F.

For nLin := 1 To Len(aExec)
	__EXEC := aExec[nLin] 
	&(__EXEC)
	
	If __EXIT
		nLin := Len(aExec) + 1 
	EndIf
Next

RestInter()

Return

User Function ExecSQL(cSQL)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : ExecuÁ„o de Script com instruÁıes SQL
<Data> : 16/09/2013
<Parametros> : cAdvpl = Script Advpl a ser executado
<Retorno> :
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nLin := nPos := nError := 1, aExec := {}, cExec := cError := "", bBlock

While Len(cSQL) > 0
	If Subs(cSQL, nLin, 2) == ";;" .Or. nLin >= Len(cSQL)
		nPos := Len(cSQL)
		If Subs(cSQL, nLin, 2) == ";;"
			nPos := At(";;", cSQL) - 1
		ElseIf Subs(cSQL, nLin, 2) == Chr(13) + Chr(10)
			nPos := At(Chr(13) + Chr(10), cSQL) - 1
		EndIf

		cExec := U_ParserADV(StrTran(Left(cSQL, nPos), Chr(13) + Chr(10), ""))

		Aadd(aExec, cExec)

		nPos := Len(cSQL) + 1
		If Subs(cSQL, nLin, 2) == ";;"
			nPos := At(";;", cSQL) + 2
		ElseIf Subs(cSQL, nLin, 2) == Chr(13) + Chr(10)
			nPos := At(Chr(13) + Chr(10), cSQL) + 2
		EndIf

		cSQL := Subs(cSQL, nPos, Len(cSQL))
		nLin := 1
	EndIf
	nLin ++
EndDo

If SuperGetMv("TI_DBGQRY",, .F.) .And. MsgYesNo("Deseja realizar a analise da instruÁ„o ?")
	cSQL := "" 
	For nLin := 1 To Len(aExec)
		cSql += aExec[nLin] + ';'
	Next
	Sql(cSQL)
Endif

BEGIN TRANSACTION
For nLin := 1 To Len(aExec)
	bBlock := ErrorBlock( { |e| ChecErro(e) } )
	BEGIN SEQUENCE
		nError := TCSQLEXEC(aExec[nLin])
		cError := TcSqlError()
		If nError <> 0 .And. ! Empty(cError)
			DisarmTran()
			Alert(AllTrim(Str(nError)) + "-" + cError)
			Return .F.
		EndIf
	RECOVER
		MsgInfo("Erro ao executar a instruÁ„o [" + aExec[nLin] + "]")
		DisarmTran()
	END SEQUENCE
	ErrorBlock(bBlock)
Next
END TRANSACTION

Return

Static Function Sql(cQuery)

Local oDlgHelp, oBtOk
Local oFont	 :=	TFont ():New ("Arial",, 15,, .F.)
Local oFontB :=	TFont ():New ("Arial",, 15,, .T.)
Local lRet := .T.

DEFINE MSDIALOG oDlgHelp FROM 000,000 TO 350, 660 TITLE "Analise da InstruÁ„o" PIXEL
@005, 005 SAY "Query" SIZE 405, 010 FONT oFontB OF oDlgHelp PIXEL COLOR CLR_RED
@015, 005 GET cQuery OF oDlgHelp MEMO SIZE 280, 145 FONT oFont PIXEL

DEFINE SBUTTON oBtOk FROM 225, 300 TYPE 1 ACTION (lRet := .T., oDlgHelp:End()) ENABLE OF oDlgHelp
ACTIVATE MSDIALOG oDlgHelp CENTERED

Return lRet

Static Function MarkAll(cAlias, oBrowse)

MsgRun( "Aguarde... Marcando Registros", "Marcar Todos", {|| EMarkAll(cAlias, oBrowse) } )

Return

Static Function EMarkAll(cAlias, oBrowse)

Local nCurrRec := oBrowse:At(), aArea := GetArea()

oBrowse:GoTop(.T.)
DbSelectArea(cAlias)
DbGoTop()

While ! (cAlias)->(Eof())
	oBrowse:MarkRec()

	DbSkip()
EndDo

oBrowse:GoTo( nCurrRec, .T. )
RestArea(aArea)

Return

User Function TCGQuery(cID)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Recupera a instruÁ„o SQL de uma consulta para reutilizaÁ„o
<Data> : 12/06/2014
<Parametros> : cID = Id da Consulta
<Retorno> :
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local aArea := GetArea(), aAreaPQ1 := PQ1->(GetArea()), cReturn := ""

PQ1->(DbSeek(xFilial() + cID))
cReturn := PQ1->PQ1_SQL
PQ1->(RestArea(aAreaPQ1))
RestArea(aArea)

Return cReturn

User Function TRGZPQ6()

__PQ6   := {}

Return