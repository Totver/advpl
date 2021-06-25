#INCLUDE "Protheus.ch"
#DEFINE MAXGETDAD 99999
#DEFINE OK         1
#DEFINE CANCELA    2 

User Function TRGA020(lQuery)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Cadastro de Parametros Consultas Personalizadas
<Data> : 02/08/2013
<Parametros> : lQuery = Indica chamada a partir da tela de consultas
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock
Private cString := "PQ1"
Private cCadastro :="Cadastro de Parametros da consulta Personalizada"
Private aRotina := MenuDef()

dbSelectArea(cString)  
dbSetOrder(1)
mBrowse( 6,1,22,75,cString)

Return

User Function TRGA020T(xOpc)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para manunteÁ„o dos parametros das Consultas Personalizadas
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local oDlg
Local nX        := 0
Local aArea     := GetArea()
Local nSaveSx8  := GetSx8Len()
Local cSeek     := ""
Local cWhile    := ""
Local aCposNao  := {}
Local bOk       := {}
Local bCancel   := {|| nOpcA := CANCELA, oDlg:End()}
Local nStyle    := GD_INSERT + GD_UPDATE + GD_DELETE
Local nLinha    := 0
Local nItem     := 0
Default xOpc 	:= 2 //Visualizar

Private oGetD
Private aCols   := {}   
Private aHeader := {}
Private cFilPQ4 := xFilial("PQ4")
Private Inclui  := .F. 
Private cDescrC := PQ1->PQ1_NOME
Private cCodC   := PQ1->PQ1_ID
Private nOpc := xOpc

bOk := {|| (TRGa020Grv(), oDlg:End()) }	
        
if nOpc == 2 
	nStyle := 0
	bOk := {|| If(oGetd:TudoOk(), oDlg:End(),)}
elseif nOpc == 5
	nStyle := 0
endif	
            
//----------------------------------------------------
// Campos da tabela PQ4 que n„o devem ser mostrados
//----------------------------------------------------
aAdd(aCposNao,"PQ4_FILIAL")                                                             
aAdd(aCposNao,"PQ4_ID")                                                             

cSeek  := cFilPQ4 + cCodC
cWhile := "PQ4->PQ4_FILIAL+PQ4->PQ4_ID"
//----------------------------------------------------
// Preenche acols e aheader	
//----------------------------------------------------
FillGetDados(4,"PQ4",1,cSeek,{|| &cWhile },,aCposNao,,,,,,aHeader,aCols,,,,"PQ4")

Inclui := .T.
//----------------------------------------------------
// Elimina colunas colacadas pela funcao FillGetDados
//----------------------------------------------------
For nLinha := 1 to Len(aCols)
	For nItem := Len(aCols[nLinha])-2 to Len(aCols[nLinha])-1
		aDel(aCols[nLinha],Len(aCols[nLinha])-2)
	Next nItem
	aSize(aCols[nLinha],Len(aCols[nLinha])-2)
Next nLinha

For nItem := Len(aHeader)-1 to Len(aHeader)
	aDel(aHeader,Len(aHeader)-1)
Next                         

aSize(aHeader,Len(aHeader)-2)
                                          
aButtons := {}
Aadd(aButtons,{"FERRAM",{|| xOrdPQ4()},"Refazer a Ordem"})

oMainWnd:ReadClientCoords()

DEFINE MSDIALOG oDlg TITLE cCadastro From oMainWnd:nTop+125,oMainWnd:nLeft+5 To oMainWnd:nBottom-80,oMainWnd:nRight-30 of oDlg PIXEL
oDlg:lMaximized := .T.

oPanel := TPanel():New(0,0,'',oDlg, oDlg:oFont, .T., .T.,, ,21,21,.T.,.T. )
oPanel:Align := CONTROL_ALIGN_TOP

@ 08,05 say "Consulta: " Size 070,08 color CLR_HBLUE Of oPanel Pixel
@ 07,30 msget cCodC  when .F. size 040,08 of oPanel pixel
@ 07,70 msget cDescrC  PICTURE "@!" when .F. size 150,08 of oPanel pixel

oGetD:=MsNewGetDados():New(33,1,299,399,nStyle,"U_TRGA020LOk","AlwaysTrue",,/*acpos*/,/*freeze*/,MAXGETDAD,/*fieldok*/,/*superdel*/,/*delok*/,oDlg,@aHeader,@aCols)
oGetD:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg, bOk, bCancel,,aButtons) Centered

RETURN(.t.)

User Function TRGA020LOk()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para validaÁ„o da mudanÁa de linha nos parametros
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nX     := 0
Local lRet   := .T.
Local nPNome := aScan(aHeader,{|x| AllTrim(X[2]) == "PQ4_NOME"}) 
Local cNewOrd := "00"

If !oGetD:aCols[oGetD:nAt][Len(oGetD:aHeader)+1]
	cChaveSZ9 := oGetD:aCols[oGetD:nAt][nPNome]

	For nX := 1 to Len(aCols)
		if nX <> oGetD:nAt 
			if oGetD:aCols[nX][nPNome] == cChaveSZ9 .and. !oGetD:aCols[nX][Len(oGetD:aHeader)+1]
				MsgInfo("Nome fÌsico de parametro, j· existe para este grupo!")
				lRet := .F.
				Exit       
			endif	
		endif	
	Next nX
EndIF            

Return(lRet)   

User Function TRGA020Seq()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para sugest„o da prÛxima ordem do parametro
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/
Local nX     := 0
Local nPOrdem := 0 
Local cNewOrd := "00"
   
if ValType(oGetD) <> "U" 
	nPOrdem := aScan(aHeader,{|x| AllTrim(X[2]) == "PQ4_ORDEM"}) 
	if Len(oGetD:aCols) > 1 
		For nX := 1 to Len(oGetD:aCols)
			if ValType(oGetD:aCols[nX,nPOrdem]) == "C"
				cNewOrd := iif(oGetD:aCols[nX,nPOrdem]>cNewOrd,oGetD:aCols[nX,nPOrdem],cNewOrd)
			else
				Exit
			endif	
		Next		     
	endif  
endif

cNewOrd := Soma1(cNewOrd)
Return(cNewOrd)   

Static Function TRGa020Grv
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para gravaÁ„o dos parametros
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local lRet      := .t.
Local nPNome 	:= aScan(aHeader,{|x| AllTrim(X[2]) == "PQ4_NOME"}) 
Local nPOrdem 	:= aScan(aHeader,{|x| AllTrim(X[2]) == "PQ4_ORDEM"})
Local nC		:= 0 
Local nID		:= 0 

PQ4->( DbSetOrder(1)) 
//----------------------------------------------------
// Grava as linhas nao deletadas do aCols
//----------------------------------------------------
BeginTran()

if nOpc == 3 .or. nOpc == 4  //Inclusao ou alteracao
	For nId := 1 to len(oGetD:aCols)
	
	     	cChavePQ4 := cFilPQ4 + cCodC + oGetD:aCols[nId,nPOrdem]    
	     	lAchou := PQ4->(DbSeek(cChavePQ4))
     	
			If !oGetD:aCols[nId][Len(oGetD:aHeader)+1]
			
		        PQ4->(RecLock("PQ4",!lAchou))
		        
		        For nC := 1 to Len(oGetD:aHeader)
					If aHeader[nC][10] <> "V"
						PQ4->(FieldPut(FieldPos(oGetD:aHeader[nC][2]),oGetD:aCols[nId][nC]))
					EndIf
		        Next nC		
		        
		        if !lAchou
			        PQ4->PQ4_ORDEM := oGetD:aCols[nId,nPOrdem]
			        PQ4->PQ4_FILIAL := cFilPQ4
			        PQ4->PQ4_ID := cCodC
		        endif
		        
    	        PQ4->(MsUnLock())      
    	        
			Elseif lAchou 
				PQ4->(RecLock("PQ4",.F.,.T.))					            
				PQ4->(dbDelete())
				PQ4->(MSUNLOCK())
	        EndIf
	        
	Next nId
elseif nOpc == 5 //Exclusao
	cChavePQ4 := cFilPQ4 + cCodC 
	PQ4->(DbSeek(cChavePQ4))
	While !PQ4->(EOF()) .AND. PQ4->(PQ4_FILIAL+PQ4_ID) == cChavePQ4	
		RECLOCK("PQ4",.F.,.T.)
		PQ4->(DBDELETE())
		PQ4->(MSUNLOCK())
		PQ4->(DBSKIP())
	End
endif		

EndTran()

Return(lRet)                       
                        
Static Function xOrdPQ4
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para ordenaÁ„o de parametros
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nPOrdem := aScan(aHeader,{|x| AllTrim(X[2]) == "PQ4_ORDEM"}) 
Local cNewOrd := "00"
Local nC	  := 0

PQ4->(DBSETORDER(1))
For nC := 1 to Len(oGetD:aCols)
    
	cNewOrd := Soma1(cNewOrd)
	cChavePQ4 := cFilPQ4 + cCodC + oGetD:aCols[nC,nPOrdem]
	oGetD:aCols[nC,nPordem] := cNewOrd
	if PQ4->(DbSeek(cChavePQ4))
		RECLOCK("PQ4",.F.)
		PQ4->PQ4_ORDEM := cNewOrd	
		PQ4->(MSUNLOCK())
		PQ4->(DBSKIP())
	Endif
	
Next nC

Return

Static Function MenuDef()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Retorno das opÁıes de Menu de parametros
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : aRotina = Acoes do Grid
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Return 	{ 	{"Pesquisar","AxPesqui",0,1} ,;
		  	{"Visualizar","U_TRGA020T(2)",0,2} ,;
			{"Manutencao","U_TRGA020T(4)",0,4} ,;
			{"Excluir","U_TRGA020T(5)",0,5}}

User Function T020_Mnu()

Return MenuDef()