#INCLUDE "FWMBROWSE.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MATA030_MVC
Cadastro de Clientes

@author Eduardo Souza
@since 02/03/2009
@version 1.0
/*/
//-------------------------------------------------------------------
Function MATA030_MVC()
Local oMBrowse

DEFINE FWMBROWSE oMBrowse ALIAS "SA1" DESCRIPTION "Cadastro de Clientes"
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
				8 - Imprimir
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
ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.MATA030_MVC" OPERATION 2 ACCESS 0
ADD OPTION aRotina TITLE "Incluir"    ACTION "VIEWDEF.MATA030_MVC" OPERATION 3 ACCESS 0
ADD OPTION aRotina TITLE "Alterar"    ACTION "VIEWDEF.MATA030_MVC" OPERATION 4 ACCESS 143
ADD OPTION aRotina TITLE "Excluir"    ACTION "VIEWDEF.MATA030_MVC" OPERATION 5 ACCESS 144
ADD OPTION aRotina TITLE "Imprimir"   ACTION "VIEWDEF.MATA030_MVC" OPERATION 8 ACCESS 0

Return aRotina

//-------------------------------------------------------------------
/*/{Protheus.doc} ModelDef
Modelo de dados do Cadastro de Clientes

@author Eduardo Riera
@since 02/03/2009
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function Modeldef()

Local oStructSA1 := Nil
Local oModel     := Nil

//-----------------------------------------
//Monta o modelo do formulário
//-----------------------------------------
oModel:= MPFormModel():New("MATA030",/*Pre-Validacao*/, {|| FWFormCanDel(oModel)}/*Pos-Validacao*/, /*Commit*/,/*Cancel*/)
oModel:AddFields("MATA030_SA1", Nil , FWFormStruct(1,"SA1"),/*Pre-Validacao*/,/*Pos-Validacao*/,/*Carga*/)

Return(oModel)

//-------------------------------------------------------------------
/*/{Protheus.doc} ViewDef
Visualizador de dados do Cadastro de Clientes

@author Eduardo Souza
@since 02/03/2009
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function ViewDef()
Local oView
Local oModel := FWLoadModel("MATA030_MVC")

oView := FWFormView():New()     
oView:SetModel(oModel)
oView:AddField( "MATA030_SA1" , FWFormStruct(2,"SA1"))   
oView:CreateHorizontalBox("ALL",100)
oView:SetOwnerView("MATA030_SA1","ALL")
oView:EnableControlBar(.T.)

Return oView

//-------------------------------------------------------------------
/*/{Protheus.doc} ViewWebDef
Gera o XML para Web

@author Ricardo Mansano
@since 29/06/2009
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function ViewWebDef()
Local	oView := ViewDef()
Return( oView:GetXML2Web() )