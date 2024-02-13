#INCLUDE "FWMBROWSE.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MATA110_MVC
Manutenção de Solicitação de Compras

@author Eduardo Souza
@since 02/03/2009
@version 1.0
/*/
//-------------------------------------------------------------------
Function MATA110_MVC()
Local oMBrowse

DEFINE FWMBROWSE oMBrowse ALIAS "SC1" PARAM {|| Pergunte("MTA110",.T.)}
	//-------------------------------------------------------------------
	// Adiciona legendas no Browse
	//-------------------------------------------------------------------
	ADD LEGEND DATA "C1_FLAGGCT=='1'" COLOR "BROWN" TITLE "SC Totalmente Atendida pelo SIGAGCT" OF oMBrowse
	ADD LEGEND DATA "C1_TIPO==2" COLOR "WHITE" TITLE "Solicitacao de Importacao" OF oMBrowse
	ADD LEGEND DATA "!Empty(C1_RESIDUO)" COLOR "BLACK" TITLE "SC Eliminada por Residuo" OF oMBrowse
	ADD LEGEND DATA "C1_QUJE==0.And.C1_COTACAO==Space(Len(C1_COTACAO)).And.C1_APROV$' ,L'" COLOR "GREEN" TITLE "SC em Aberto" OF oMBrowse
	ADD LEGEND DATA "C1_QUJE==0.And.C1_COTACAO==Space(Len(C1_COTACAO)).And.C1_APROV='R'" COLOR "GREEN" TITLE "SC Rejeitada" OF oMBrowse
	ADD LEGEND DATA "C1_QUJE==0.And.C1_COTACAO==Space(Len(C1_COTACAO)).And.C1_APROV='B'" COLOR "GRAY" TITLE "SC Bloqueada" OF oMBrowse
	ADD LEGEND DATA "C1_QUJE==C1_QUANT" COLOR "RED" TITLE "SC com Pedido Colocado" OF oMBrowse
	ADD LEGEND DATA "C1_QUJE>0" COLOR "YELLOW" TITLE "SC com Pedido Colocado Parcial" OF oMBrowse
	ADD LEGEND DATA "C1_QUJE==0.And.C1_COTACAO<>Space(Len(C1_COTACAO)).And. C1_IMPORT <>'S'" COLOR "BLUE" TITLE "SC em Processo de Cotacao" OF oMBrowse
	ADD LEGEND DATA "C1_QUJE==0.And.C1_COTACAO<>Space(Len(C1_COTACAO)).And. C1_IMPORT =='S'" COLOR "PINK" TITLE "SC com Produto Importado" OF oMBrowse
ACTIVATE FWMBROWSE oMBrowse

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} MenuDef
Menu Funcional

@return aRotina - Estrutura
			[n,1] Nome a aparecer no cabecalho
			[n,2] Nome da Rotina associada
			[n,3] Reservado
			[n,4] Tipo de Transação a ser efetuada:
				1 - Pesquisa e Posiciona em um Banco de Dados
				2 - Simplesmente Mostra os Campos
				3 - Inclui registros no Bancos de Dados
				4 - Altera o registro corrente
				5 - Remove o registro corrente do Banco de Dados
				6 - Alteração sem inclusão de registros
				7 - Cópia
			[n,5] Nivel de acesso
			[n,6] Habilita Menu Funcional

@author Eduardo Souza
@since 02/03/2009
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function MenuDef()
Local aRotina := {}

ADD OPTION aRotina TITLE "Pesquisar"  ACTION "PesqBrw"             OPERATION 1 ACCESS 0 DISABLE MENU
ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.MATA110_MVC" OPERATION 2 ACCESS 0
ADD OPTION aRotina TITLE "Incluir"    ACTION "VIEWDEF.MATA110_MVC" OPERATION 3 ACCESS 0
ADD OPTION aRotina TITLE "Alterar"    ACTION "VIEWDEF.MATA110_MVC" OPERATION 4 ACCESS 143
ADD OPTION aRotina TITLE "Excluir"    ACTION "VIEWDEF.MATA110_MVC" OPERATION 5 ACCESS 144
ADD OPTION aRotina TITLE "Imprimir"   ACTION "VIEWDEF.MATA110_MVC" OPERATION 8 ACCESS 0

Return aRotina

//-------------------------------------------------------------------
/*/{Protheus.doc} ModelDef
Modelo de dados da Solicitação de Compras

@author Eduardo Riera
@since 02/03/2009
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function ModelDef()

Local oStructCab := Nil
Local oStructSC1 := Nil
Local oModel     := Nil
//-----------------------------------------
//Monta a estrutura do formulário com base no dicionário de dados
//-----------------------------------------
oStructCab := FWFormStruct(1,"SC1",{|cCampo| AllTrim(cCampo)+"|" $ "C1_NUM|C1_SOLICIT|C1_EMISSAO|C1_UNIDREQ|C1_CODCOMP|C1_FILENT|C1_NATUREZ|"})
oStructSC1 := FWFormStruct(1,"SC1",{|cCampo| !AllTrim(cCampo)+"|" $ "C1_NUM|C1_SOLICIT|C1_EMISSAO|C1_UNIDREQ|C1_CODCOMP|C1_FILENT|C1_NATUREZ|"})
oStructSC1:RemoveField( "C1_TIPO" )
oStructSC1:RemoveField( "C1_PRECO" )
oStructSC1:RemoveField( "C1_TOTAL" )

//-----------------------------------------
//Monta o modelo do formulário
//-----------------------------------------
oModel:= MPFormModel():New("MATA110", {|| Dummy(oModel),.T.} /*Pre-Validacao*/,/*Pos-Validacao*/,/*Commit*/,/*Cancel*/)
oModel:AddFields("MATA110_CAB", Nil/*cOwner*/, oStructCab ,/*Pre-Validacao*/,/*Pos-Validacao*/,/*Carga*/)
oModel:GetModel("MATA110_CAB"):SetDescription("Solicitação de compra")
oModel:AddGrid("MATA110_SC1", "MATA110_CAB"/*cOwner*/, oStructSC1 , ,{|x| A110LinOk(x)}/*bLinePost*/,/*bPre*/,{|x| A110TudOk(x)}/*bPost*/,/*Carga*/)
oModel:GetModel("MATA110_SC1"):SetUseOldGrid()
oModel:GetModel("MATA110_SC1"):SetUniqueLine({"C1_ITEM"})
oModel:SetPrimaryKey({"C1_NUM"})
oModel:SetRelation("MATA110_SC1",{{"C1_FILIAL",'xFilial("SC1")'},{"C1_NUM","C1_NUM"}},SC1->(IndexKey()))

//VARIAVEIS DO PROGRAMA MATA110
Public lGatilha := .T.
Public lGrade   := .F.
Public l110Auto := .F.
Public aRatAFG  := {}
Public lCopia   := .F.
Public lVldHead	:= GetNewPar( "MV_VLDHEAD",.T. )
Public l110Alt  := .T.
Public lProjM711:= .F.

Return(oModel)


Static Function Dummy(oModel)

Public dA110Data   := oModel:GetValue("MATA110_CAB","C1_EMISSAO")
Public cCodNatu	   := ""
Public cCCusto     := ""
Public cUnidReq    := ""
Public cCodCompr   := ""
Public cA110Num    := oModel:GetValue("MATA110_CAB","C1_NUM")

//-------------------------------------------------------------------
/*/{Protheus.doc} ViewDef
Visualizador de dados da Solicitação de Compras

@author Eduardo Souza
@since 02/03/2009
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function ViewDef()
Local oView
Local oStructCAB
Local oStructSC1
Local oModel     := FWLoadModel("MATA110_MVC")

oStructCab := FWFormStruct(2,"SC1",{|cCampo| AllTrim(cCampo)+"|" $ "C1_NUM|C1_SOLICIT|C1_EMISSAO|C1_UNIDREQ|C1_CODCOMP|C1_FILENT|C1_NATUREZ|"})
oStructSC1 := FWFormStruct(2,"SC1",{|cCampo| !AllTrim(cCampo)+"|" $ "C1_NUM|C1_SOLICIT|C1_EMISSAO|C1_UNIDREQ|C1_CODCOMP|C1_FILENT|C1_NATUREZ|"})
oStructSC1:RemoveField("C1_TIPO")
oStructSC1:RemoveField("C1_PRECO")
oStructSC1:RemoveField("C1_TOTAL")

oView := FWFormView():New()
oView:SetUseCursor(.F.)
oView:SetModel(oModel)
oView:AddField( "MATA110_CAB",oStructCab)   
oView:CreateHorizontalBox("CABEC",10)
oView:SetOwnerView( "MATA110_CAB","CABEC")
oView:EnableControlBar(.T.)

oView:AddGrid("MATA110_SC1",oStructSC1)
oView:AddIncrementField("MATA110_SC1","C1_ITEM")
oView:CreateHorizontalBox("GRID",90)
oView:SetOwnerView( "MATA110_SC1","GRID")

Return oView