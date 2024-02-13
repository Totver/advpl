#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMBROWSE.CH"
#INCLUDE "TBICONN.CH"

Function OMSA010_MVC()
Local oMBrowse

DEFINE FWMBROWSE oMBrowse ALIAS "DA0"
ACTIVATE FWMBROWSE oMBrowse 

Return
                
Static Function MenuDef()
Local aRotina := {}

ADD OPTION aRotina TITLE "Pesquisar"  ACTION "PesqBrw"             OPERATION 1 ACCESS 0 DISABLE MENU
ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.OMSA010_MVC" OPERATION 2 ACCESS 0
ADD OPTION aRotina TITLE "Incluir"    ACTION "VIEWDEF.OMSA010_MVC" OPERATION 3 ACCESS 0
ADD OPTION aRotina TITLE "Alterar"    ACTION "VIEWDEF.OMSA010_MVC" OPERATION 4 ACCESS 143
ADD OPTION aRotina TITLE "Excluir"    ACTION "VIEWDEF.OMSA010_MVC" OPERATION 5 ACCESS 144
ADD OPTION aRotina TITLE "Imprimir"   ACTION "VIEWDEF.OMSA010_MVC" OPERATION 8 ACCESS 0

Return aRotina

Static Function ModelDef()

Local oStructDA0 := Nil
Local oStructDA1 := Nil
Local oModel     := Nil
//-----------------------------------------
//Monta a estrutura do formulário com base no dicionário de dados
//-----------------------------------------
oStructDA0 := FWFormStruct(1,"DA0")
oStructDA1 := FWFormStruct(1,"DA1")
oStructDA1:RemoveField( "DA1_CODTAB" )
//-----------------------------------------
//Monta o modelo do formulário
//-----------------------------------------
oModel:= MpFormModel():New("OMSA010", /*Pre-Validacao*/, /*Pos-Validacao*/, /*Commit*/, /*Cancel*/)
oModel:AddFields("OMSA010_DA0", /*cOwner*/, oStructDA0 , /*Pre-Validacao*/,/*Pos-Validacao*/,/*Carga*/)
oModel:AddGrid("OMSA010_DA1", "OMSA010_DA0"/*cOwner*/, oStructDA1 , /*bLinePre*/,{|x|Oms010Lok()}/*bLinePost*/,/*bPre*/,{|x|Oms010Tok()}/*bPost*/,/*bLoad*/)
oModel:GetModel("OMSA010_DA1"):SetUseOldGrid()
oModel:GetModel("OMSA010_DA1"):SetUniqueLine({"DA1_ITEM"})
oModel:SetRelation("OMSA010_DA1",{{"DA1_FILIAL",'xFilial("DA1")'},{"DA1_CODTAB","DA0_CODTAB"}},DA1->(IndexKey()))

Return(oModel)

Static Function ViewDef()

Local oModel     := FwLoadModel("OMSA010_MVC") //Passar para o EduSouza
Local oStructDA0
Local oStructDA1
Local oView

//--------------------------------------------------------------
//Montagem da interface via dicionario de dados
//--------------------------------------------------------------
oStructDA0 := FWFormStruct(2,"DA0")
oStructDA1 := FWFormStruct(2,"DA1")
oStructDA1:RemoveField( "DA1_CODTAB" )    
oStructDA1:RemoveField( "DA1_DESTAB" )      
//--------------------------------------------------------------
//Montagem do View normal se Container
//--------------------------------------------------------------
oView := FWFormView():New()
oView:SetModel(oModel)
oView:AddField( "OMSA010_DA0" , oStructDA0 )
oView:EnableControlBar(.T.)          
oView:AddGrid(  "OMSA010_DA1" , oStructDA1 )
oView:AddIncrementField("OMSA010_DA1","DA1_ITEM")	
oView:createHorizontalBox("FORMFIELD",20)
oView:SetOwnerView( "OMSA010_DA0","FORMFIELD")
oView:createHorizontalBox("GRID",80)
oView:SetOwnerView( "OMSA010_DA1","GRID")

oView:SetUseCursor(.T.)
Return(oView)

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³MyOMSA010 ³ Autor ³ Eduardo Riera         ³ Data ³30.04.2003 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³Rotina de teste da rotina automatica do programa OMSA010     ³±±
±±³          ³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                       ³±±
±±³          ³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±³          ³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Esta rotina tem como objetivo efetuar testes na rotina de    ³±±
±±³          ³pedido de venda                                              ³±±
±±³          ³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Materiais                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MyOMSA010()

Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local nY     := 0
Local lOk    := .T.
PRIVATE lMsErroAuto := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//| Abertura do ambiente                                         |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ConOut(Repl("-",80))
ConOut(PadC("Teste de Inclusao de 1 tabela de preco",80))
PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//| Verificacao do ambiente para teste                           |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SB1")
dbSetOrder(1)
If !SB1->(MsSeek(xFilial("SB1")+"PA001"))
	lOk := .F.
	ConOut("Cadastrar produto: PA001")
EndIf
If !SB1->(MsSeek(xFilial("SB1")+"PA002"))
	lOk := .F.
	ConOut("Cadastrar produto: PA002")
EndIf
If lOk
	ConOut("Inicio: "+Time())
	For nY := 1 To 1
		aCabec := {}
		aItens := {}
		aadd(aCabec,{"DA0_DESCRI"   ,"TESTE DE TABELA",Nil})
		//aadd(aCabec,{"DA0_CONDPG"   ,"001",Nil})
		aLinha := {}
		aadd(aLinha,{"DA1_ITEM","0001"})
		aadd(aLinha,{"DA1_CODPRO","PA001"})
		aadd(aLinha,{"DA1_PRCVEN",10,Nil})			
		aadd(aItens,aLinha)
		aLinha := {}
		aadd(aLinha,{"DA1_ITEM","0002"})
		aadd(aLinha,{"DA1_CODPRO","PA002"})
		aadd(aLinha,{"DA1_PRCVEN",10,Nil})			
		aadd(aItens,aLinha)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//| Teste de Inclusao                                            |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aRotina := MenuDef()
		FWMVCRotAuto(ModelDef(),"DA0",3,{{"OMSA010_DA0",aCabec},{"OMSA010_DA1",aItens}})
		If !lMsErroAuto
			ConOut("Incluido com sucesso! ")
		Else
			ConOut("Erro na inclusao!")
		EndIf
	Next nY
	ConOut("Fim  : "+Time())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//| Teste de alteracao                                           |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aCabec := {}
	aItens := {}
	For nY := 1 To 1
		aCabec := {}
		aItens := {}
		aadd(aCabec,{"DA0_CODTAB"   ,DA0->DA0_CODTAB,Nil})
		aadd(aCabec,{"DA0_DESCRI"   ,"TESTE DE TABELA",Nil})
		//aadd(aCabec,{"DA0_CONDPG"   ,"001",Nil})
		aLinha := {}
		aadd(aLinha,{"LINPOS","DA1_ITEM","0001"})
		aadd(aLinha,{"AUTDELETA","N",Nil})
		aadd(aLinha,{"DA1_CODPRO","PA001"})
		aadd(aLinha,{"DA1_PRCVEN",11,Nil})			
		aadd(aItens,aLinha)
		aLinha := {}
		aadd(aLinha,{"LINPOS","DA1_ITEM","0002"})
		aadd(aLinha,{"AUTDELETA","N",Nil})				
		aadd(aLinha,{"DA1_CODPRO","PA002"})
		aadd(aLinha,{"DA1_PRCVEN",11,Nil})			
		aadd(aItens,aLinha)
	Next nY
	ConOut(PadC("Teste de alteracao",80))
	ConOut("Inicio: "+Time())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//| Teste de alteracao                                           |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aRotina := MenuDef()
	FWMVCRotAuto(ModelDef(),"DA0",4,{{"OMSA010_DA0",aCabec},{"OMSA010_DA1",aItens}})
	ConOut("Fim  : "+Time())
	ConOut(Repl("-",80))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//| Teste de Exclusao                                            |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ConOut(PadC("Teste de exclusao",80))
	ConOut("Inicio: "+Time())
	aRotina := MenuDef()
	FWMVCRotAuto(ModelDef(),"DA0",5,{{"OMSA010_DA0",aCabec},{"OMSA010_DA1",aItens}})
	If !lMsErroAuto
		ConOut("Exclusao com sucesso! "+DA0->DA0_CODTAB)
	Else
		ConOut("Erro na exclusao!")
	EndIf
	ConOut("Fim  : "+Time())
	ConOut(Repl("-",80))	
EndIf
RESET ENVIRONMENT
Return(.T.)
