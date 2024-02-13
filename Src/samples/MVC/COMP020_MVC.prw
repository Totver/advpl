#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

User Function COMP020_MVC()
Local oBrowse

NEW MODEL TYPE 3 DESCRIPTION "Musicas" BROWSE oBrowse MENUDEF "COMP020_MVC" MASTER "ZA1" DETAIL "ZA2" RELATION {"ZA2_FILIAL",'xFilial("ZA2")'},{"ZA2_MUSICA","ZA1_MUSICA"} ORDERKEY "ZA2_FILIAL+ZA2_MUSICA" AUTO INCREMENT "ZA2_ITEM" UNIQUE LINE "ZA2_AUTOR"

Return(Nil)


//-------------------------------------------------------------------
Static Function MenuDef()
Local aRotina := {}

ADD OPTION aRotina TITLE "Pesquisar"  ACTION "PesqBrw"            OPERATION 1 ACCESS 0
ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.COMP020_MVC" OPERATION 2 ACCESS 0
ADD OPTION aRotina TITLE "Incluir"    ACTION "VIEWDEF.COMP020_MVC" OPERATION 3 ACCESS 0
ADD OPTION aRotina TITLE "Alterar"    ACTION "VIEWDEF.COMP020_MVC" OPERATION 4 ACCESS 0
ADD OPTION aRotina TITLE "Excluir"    ACTION "VIEWDEF.COMP020_MVC" OPERATION 5 ACCESS 0
ADD OPTION aRotina TITLE "Copiar"     ACTION "VIEWDEF.COMP020_MVC" OPERATION 7 ACCESS 0
ADD OPTION aRotina TITLE "Imprimir"   ACTION "VIEWDEF.COMP020_MVC" OPERATION 8 ACCESS 0

Return aRotina


User Function C20Autor()

Local aArea    := GetArea()
Local lRetorno := .T.
Local oModel   := FwModelActivate()
Local cAutor   := oModel:GetValue("COMP020_MVC_ZA2","ZA2_AUTOR")

DbSelectArea("ZA0")
DbSetOrder(1)
MsSeek(xFilial("ZA0")+cAutor)

If ZA0->ZA0_TIPO == "I"

	Help("",1,"",,"Este não pode!",1,0)
	lRetorno := .F.
	
EndIf
RestArea(aArea)               
Return(lRetorno)
