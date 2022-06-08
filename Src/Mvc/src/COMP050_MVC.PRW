#Include "Protheus.ch"

Static __aMark := {}

//--------------------------------------------------------
// Browse para tidos de dados ARRAY
//--------------------------------------------------------
User Function COMP050_MVC()
Local oDlg
Local oFWBrowse
Local oPanel

Local nI
Local nSubNivel := 1

Local aColumns  := {}
Local aFields   := {}
Local aSeek     := {}
Local aStruct   := {}

Local aItemDoubleClick := {}
Local bActionLocate := { |oLocate,oBrowse| Locate(oLocate,oBrowse) }
Local bActionSeek   := { |oSeek,oBrowse| SeekArray(oSeek,oBrowse) }
Local bDelete       := { |oBrowse| Delete(oBrowse) }
Local bDelOk        := { |oBrowse| DelOk(oBrowse) }
Local blDblClick    := { || Alert("Duplo Clique") }
Local bSuperDel     := { |oBrowse| SuperDel(oBrowse) }
Local bValidEdit    := { |lCancel,oBrowse| ValidEdit(lCancel,oBrowse) }
Local bAllOk        := { |oBrowse| AllOK(oBrowse)  }
Local bChange       := { |oBrowse| Change(oBrowse) }
Local bLineOk       := { |oBrowse| LineOK(oBrowse) }
Local bGroup        := { |oBrowse| Group(oBrowse) }
Local bPicture      := { |oBrowse| If(Mod(oBrowse:nAt,2)==0,"@!","") }

Local bStatus       := { |oBrowse| If(StatusArray(oBrowse),'BR_VERDE','BR_VERMELHO' ) }
Local bDblClkStatus := { |oBrowse| DblClickStatus(oBrowse) }

Local bMark         := { |oBrowse| If(MarkArray(oBrowse),'LBOK','LBNO') }
Local bDblClkMark   := { |oBrowse| DblClickMark(oBrowse) }

//-- Define as colunas do Brwose
Aadd( aColumns, { "Conta"    ,{ || CT1_CONTA  },"C","",,20,0,.T.,,.F.,,"CT1_CONTA" })
Aadd( aColumns, { "Descricao",{ || CT1_DESC01 },"C","",,40,0,.T.,,.F.,,"CT1_DESC01"})

//-- Define as ações do duplo clique
Aadd(aItemDoubleClick, { "Ação 1", { |oBrowse| DoubleClick(oBrowse,"1") } } )
Aadd(aItemDoubleClick, { "Ação 2", { |oBrowse| DoubleClick(oBrowse,"2") } } )

//-- Campos utilizados no filtro
aStruct := CT1->(DbStruct())
For nI := 1 To Len(aStruct)
	//-- Campo
	//-- Título
	//-- Tipo
	//-- Tamanho
	//-- Decimal
	//-- Picture
	Aadd( aFields, { aStruct[nI,1],"T "+aStruct[nI,1],aStruct[nI,2],aStruct[nI,3],aStruct[nI,4],"@!"} )
Next nI

//-- Chave de Pesquisa
// 1 - Chave
// 2 - Tipo de cada chave
// 3 - Tamanho de cada chave
Aadd( aSeek, { "Conta" , { "C" }, { Len(CT1->CT1_CONTA) } } )

DEFINE MSDIALOG oDlg FROM 0, 0 TO 600,800 PIXEL

@00,00 MSPANEL oPanel SIZE 15,15 OF oDlg
oPanel:Align := CONTROL_ALIGN_ALLCLIENT

oFWBrowse := FWBrowse():New(oPanel)					//-- Habilita o Browse para atualização das propriedades
oFWBrowse:SetGroup(bGroup)							//-- Define o agrupamento das informações
oFWBrowse:AddMarkColumns(bMark,bDblClkMark)			//-- Cria coluna de Marca e Desmarca
oFWBrowse:AddStatusColumns(bStatus,bDblClkStatus)	//-- Cria coluna de Status
oFWBrowse:SetColumns(aColumns)						//-- Define as colunas do Browse
oFWBrowse:SetDataTable()							//-- Define que sera utilizado dados de uma tabela
oFWBrowse:SetAlias("CT1")							//-- Define que sera utilizado dados de uma tabela
oFWBrowse:SetDoubleClick(blDblClick)				//-- Define o duplo clique do item
oFWBrowse:SetAllOk(bAllOk)							//-- Define a validação de todas linhas do browse
oFWBrowse:SetChange(bChange)						//-- Define a ação executada após a mudança de linha do browse
oFWBrowse:SetDelete(.T.,bDelete)					//-- Habilita a exclusão de registros DEL
oFWBrowse:SetDelOk(bDelOk)							//-- Define a validação da exclusão de registros
oFWBrowse:SetEditCell(.T.,bValidEdit)				//-- Habilita a edição de células
oFWBrowse:SetFieldFilter(aFields)					//-- Define os campos que serão utilizados no filtro
oFWBrowse:SetUseFilter()							//-- Habilita Filtro de dados
//oFWBrowse:SetInsert(.T.)							//-- Habilita a inclusão de registros
oFWBrowse:SetItemDoubleClick(aItemDoubleClick)		//-- Define as ações do duplo clique
oFWBrowse:SetItemHeaderClick(aItemDoubleClick)		//-- Define as ações do clique no header
oFWBrowse:SetLineOk(bLineOk)						//-- Define a validação de mudança de linha
oFWBrowse:SetLocate(bActionLocate)					//-- Habilita localizador de palavras
oFWBrowse:SetSeek(bActionSeek,aSeek)	 			//-- Habilita pesquisa de dados
oFWBrowse:SetSuperDel(bSuperDel)					//-- Habilita a exclusão de registros CTRL+DEL
oFWBrowse:Activate()								//-- Exibe o Browse

ACTIVATE MSDIALOG oDlg CENTERED

Return

//--------------------------------------------------------
// Seek nos registros
//--------------------------------------------------------
Static Function SeekArray(oSeek,oBrowse)
Local cSeek  := ""
Local nOrder := 1

If ValType(oSeek) == "O"
	cSeek  := AllTrim(oSeek:GetSeek())
	nOrder := oSeek:GetOrder()
	(oBrowse:cAlias)->(DbSetOrder(nOrder))
	If !(oBrowse:cAlias)->(DbSeek(cSeek))
		(oBrowse:cAlias)->(DbGotop())
	EndIf
EndIf

Return (oBrowse:cAlias)->(Recno())

//--------------------------------------------------------
// Status dos registros
//--------------------------------------------------------
Static Function StatusArray(oBrowse)
Local lRet := .F.

If Mod(oBrowse:nAt,2) == 0
	lRet := .T.
EndIf

Return lRet

//--------------------------------------------------------
// Executa duplo clique no Status
//--------------------------------------------------------
Static Function DblClickStatus(oBrowse)
Local oDlg

DEFINE MSDIALOG oDlg FROM 0, 0 TO 30,100 PIXEL STYLE nOR(WS_VISIBLE,WS_POPUP)

@ 05,05 BITMAP RESOURCE 'BR_VERDE' SIZE 8,8 OF oDlg PIXEL
@ 05,20 SAY 'Em Aberto'  OF oDlg PIXEL

@ 15,05 BITMAP RESOURCE 'BR_VERMELHO' SIZE 8,8 OF oDlg PIXEL
@ 15,20 SAY 'Finalizado' OF oDlg PIXEL

ACTIVATE MSDIALOG oDlg CENTERED

Return

//--------------------------------------------------------
// Marca dos Registros
//--------------------------------------------------------
Static Function MarkArray(oBrowse)
Local nPos := 0

If (nPos := Ascan(__aMark, { |x| x[1] == oBrowse:nAt } )) == 0
	Aadd( __aMark, { oBrowse:nAt, .F. } )
	nPos := Len(__aMark)
EndIf

Return __aMark[nPos,2]

//--------------------------------------------------------
// Executa duplo clique no Mark
//--------------------------------------------------------
Static Function DblClickMark(oBrowse)

If (nPos := Ascan(__aMark, { |x| x[1] == oBrowse:nAt } )) > 0
	__aMark[nPos,2] := !__aMark[nPos,2]
EndIf

Return

//--------------------------------------------------------
// Executa a localização do registro
//--------------------------------------------------------
Static Function Locate(oLocate,oBrowse)
Local cLocate    := ""
Local nAt        := 0
Local nI         := 0
Local nRecno     := 0
Local lGoNext    := .F.
Local lLocate    := .F.
Local lSensitive := .F.

If ValType(oLocate) == "O"
	cLocate    := oLocate:GetLocate()
	lSensitive := oLocate:Sensitive()
	lGoNext    := oLocate:GoNext()
	nAt        := oLocate:At()

	//-- Localiza a partir do ponto posicionado
	If !lGoNext
		(oBrowse:cAlias)->(DbGotop())
	Else
		(oBrowse:cAlias)->(DbGoto(nAt))
		(oBrowse:cAlias)->(DbSkip())
	EndIf

	While (oBrowse:cAlias)->(!Eof())
		For nI := 1 To Len(oBrowse:aColumns)
			If !oBrowse:aColumns[nI]:Deleted() .And. !oBrowse:aColumns[nI]:IsImage()
				cValue := ToStr(Eval(oBrowse:aColumns[nI]:GetData()))
				If lSensitive
					If At(AllTrim(cLocate),cValue) <> 0
						lLocate := .T.
					EndIf				
				Else
					If At(AllTrim(Upper(cLocate)),Upper(cValue)) <> 0
						lLocate := .T.
					EndIf				
				EndIf
				If lLocate
					Exit
				EndIf
			EndIf
		Next nI
		If lLocate
			nRecno := (oBrowse:cAlias)->(Recno())
			Exit
		EndIf
		(oBrowse:cAlias)->(DbSkip())
	EndDo
	//-- Verifica se localizou o registro
	If !lLocate
		(oBrowse:cAlias)->(DbGotop())
	EndIf
	nRecno := (oBrowse:cAlias)->(Recno())
EndIf

Return nRecno

//----------------------------------------------------------
// Converte o dado para String
//----------------------------------------------------------
Static Function ToStr(xData)

If ValType(xData) == "N"
	xData := LTrim(Str(xData))
ElseIf ValType(xData) == "D"
	xData := DTOC(xData)
ElseIf ValType(xData) == "L"
	If xData
		xData := ".T."
	Else
		xData := ".F."
	EndIf
EndIf

Return xData

//----------------------------------------------------------
// Efetua a exclusão de registros
//----------------------------------------------------------
Static Function Delete(oBrowse)

DbRLock()
DbDelete()
DbRUnlock(oBrowse:nAt)
DbSkip()

Return

//----------------------------------------------------------
// Tratamento para exclusão do registro
//----------------------------------------------------------
Static Function DelOk(oBrowse)
Local lRet := .F.

If MsgYesNo("Deseja apagar o registro : " + LTrim(Str(oBrowse:nAt)) )
	lRet := .T.
EndIf

Return lRet

//----------------------------------------------------------
// Tratamento para exclusão do registro
//----------------------------------------------------------
Static Function SuperDel(oBrowse)

Return

//----------------------------------------------------------
// Validação para troca de linha
//----------------------------------------------------------
Static Function LineOK(oBrowse)
lRet := .T.

Return lRet

//----------------------------------------------------------
// Validação de todos as linhas do Browse
//----------------------------------------------------------
Static Function AllOK(oBrowse)
Local lRet := .F.

Alert("Existem itens não informados na linha: "+LTrim(Str(oBrowse:nAt)))

Return lRet

//----------------------------------------------------------
// Ação após a mudança de linha
//----------------------------------------------------------
Static Function Change(oBrowse)

Return .T.

//----------------------------------------------------------
// Efetua a validação e a atualização do array
//----------------------------------------------------------
Static Function ValidEdit(lCancel,oBrowse)
Local lRet    := .T.

If !lCancel
	
EndIf

Return lRet

//----------------------------------------------------------
// Executa o duplo clique do usuário
//----------------------------------------------------------
Static Function DoubleClick(oBrowse,cAction)

If cAction == "1"
	Alert(oBrowse:nAt)
Else
	Alert(oBrowse:ColPos())
EndIf

Return

//----------------------------------------------------------
// Trata o agrupamento das informações
//----------------------------------------------------------
Static Function Group(oBrowse)
Local lGroup := .F.

If Empty( CT1->CT1_CTASUP )
	lGroup := .T.
EndIf

Return lGroup
