#INCLUDE "Protheus.ch"
#DEFINE MAXGETDAD 99999
#DEFINE OK         1
#DEFINE CANCELA    2 

User Function TRGA030()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Cadastro de Campos de Consultas Personalizadas
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock
Private cString := "PQ1"
Private cCadastro :="Cadastro de Campos da consulta Personalizada"
Private aRotina := MenuDef()

dbSelectArea(cString)  
dbSetOrder(1)
mBrowse( 6,1,22,75,cString)
Return

User Function TRGA030T(xOpc)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para manutenÁ„o de Campos de Consultas Personalizadas
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local oDlg, oPanel
Local nX        := 0
Local aArea     := GetArea()
Local nSaveSx8  := GetSx8Len()
Local cSeek     := ""
Local cWhile    := ""
Local aCposNao  := {}
Local bOk       := {}
Local bCancel   := {|| nOpcA := CANCELA, oDlg:End()}
Local nStyle    := GD_INSERT + GD_UPDATE + GD_DELETE
Default xOpc 	:= 2 //Visualizar

Private oGetD
Private aCols   := {}   
Private aHeader := {}
Private cFilPQ2 := xFilial("PQ2")
Private Inclui  := .F. 
Private cDescrC := PQ1->PQ1_NOME
Private cCodC   := PQ1->PQ1_ID
Private nOpc := xOpc

bOk := {|| (TRGA030Grv(), oDlg:End()) }	
        
if nOpc == 2 
	nStyle := 0
	bOk := {|| If(oGetd:TudoOk(), oDlg:End(),)}
elseif nOpc == 5
	nStyle := 0
endif	
            
cFiltroR := "PQ2_ID = '"+cCodC+"'"           
cCpoNao := "PQ2_FILIAL/PQ2_ID"

U_XColHeader(@aCols,@aHeader,"PQ2",.T.,cCpoNao,nOpc,cFiltroR,"PQ2_ORDEM")

oMainWnd:ReadClientCoords()

DEFINE MSDIALOG oDlg TITLE cCadastro From oMainWnd:nTop+125,oMainWnd:nLeft+5 To oMainWnd:nBottom-80,oMainWnd:nRight-30 of oDlg PIXEL
oDlg:lMaximized := .T.

oPanel := TPanel():New(0,0,'',oDlg, oDlg:oFont, .T., .T.,, ,21,21,.T.,.T. )
oPanel:Align := CONTROL_ALIGN_TOP

@ 08,05 say "Consulta: " Size 070,08 color CLR_HBLUE Of oPanel Pixel
@ 07,30 msget cCodC  when .F. size 040,08 of oPanel pixel
@ 07,70 msget cDescrC  PICTURE "@!" when .F. size 150,08 of oPanel pixel

oGetD:=MsNewGetDados():New(33,1,299,399,nStyle,"U_TRGA030LOk","AlwaysTrue",,/*acpos*/,/*freeze*/,MAXGETDAD,/*fieldok*/,/*superdel*/,/*delok*/,oDlg,@aHeader,@aCols)
oGetD:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg, bOk, bCancel,,) Centered

RETURN(.t.)

User Function TRGA030LOk()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para validaÁ„o da linha
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nX     	:= 0
Local lRet   	:= .T.
Local nPNome 	:= aScan(aHeader,{|x| AllTrim(X[2]) == "PQ2_NOME"}) 
Local nPOrdem 	:= aScan(aHeader,{|x| AllTrim(X[2]) == "PQ2_ORDEM"}) 
Local nCHeader 	:= Len(aHeader)
Local cNewOrd 	:= "00"
Local cOldOrd 	:= ""
Local lRefOrd 	:= .F.

If !oGetD:aCols[oGetD:nAt][Len(oGetD:aCols[oGetD:nAt])]
	cChaveSZ9 := oGetD:aCols[oGetD:nAt][nPNome]
	cOldOrd := oGetD:aCols[oGetD:nAt][nPOrdem]

	For nX := 1 to Len(aCols)
		if nX <> oGetD:nAt 
			if oGetD:aCols[nX][nPNome] == cChaveSZ9 .and. !oGetD:aCols[nX][Len(oGetD:aCols[nX])]
				MsgInfo("Nome fÌsico de campo, j· existe para este grupo!")
				lRet := .F.
				Exit       
			endif	
			if oGetD:aCols[nX][nPOrdem] == cOldOrd
				lRefOrd := .T.
			endif			
		endif	
	Next nX
	
	if lRefOrd .and. MsgYesNo("Deseja refazer a ordem dos campos?","AtenÁao!")
		cNewOrd := "01"				
		For nX := 1 to Len(aCols)
			if nX <> oGetD:nAt .and. !oGetD:aCols[nX][Len(oGetD:aCols[nX])]
			
				if cNewOrd == cOldOrd
					cNewOrd := Soma1(cNewOrd)		    	
				endif					
				
	    		oGetD:aCols[nX][nPOrdem] := cNewOrd				
				cNewOrd := Soma1(cNewOrd)		    	
		    	
			endif	
		Next nX
		                
		aSort(oGetD:aCols,,,{|x,y| x[nPOrdem] < y[nPOrdem]})
		oGetD:oBrowse:Refresh()
	endif
EndIF            

Return(lRet)

User Function TRGA030Seq()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para sugest„o da prÛxima sequencia
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nX     	:= 0
Local nPOrdem 	:= 0 
Local cNewOrd 	:= "00"
   
if ValType(oGetD) <> "U" 
	nPOrdem := aScan(aHeader,{|x| AllTrim(X[2]) == "PQ2_ORDEM"}) 
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

Static Function TRGA030Grv
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para gravaÁ„o dos campos
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local lRet      := .t.
Local nPNome 	:= aScan(aHeader,{|x| AllTrim(X[2]) == "PQ2_NOME"}) 
Local nPOrdem 	:= aScan(aHeader,{|x| AllTrim(X[2]) == "PQ2_ORDEM"}) 
Local nCHeader 	:= Len(aHeader)
Local nC		:= 0
Local nID		:= 0

PQ2->( DbSetOrder(1)) 
//----------------------------------------------------
// Grava as linhas nao deletadas do aCols
//----------------------------------------------------

BeginTran()

if nOpc == 3 .or. nOpc == 4  //Inclusao ou alteracao
	For nId := 1 to len(oGetD:aCols)
	
	     	//Busco pelo recno, caso exista na coluna	     	
	     	lAchou := .F.
	     	if Len(oGetD:aCols[nId])>(nCHeader+1)
	     		PQ2->(DBGOTO(oGetD:aCols[nId][nCHeader+1]))
	     		lAchou := .T.
	     	endif
     	
			If !oGetD:aCols[nId][Len(oGetD:aCols[nId])]
			
		        PQ2->(RecLock("PQ2",!lAchou))
		        
		        For nC := 1 to Len(oGetD:aHeader)
					If aHeader[nC][10] <> "V"
						PQ2->(FieldPut(FieldPos(oGetD:aHeader[nC][2]),oGetD:aCols[nId][nC]))
					EndIf
		        Next nC		
		        
		        if !lAchou
			        PQ2->PQ2_ORDEM := oGetD:aCols[nId,nPOrdem]
			        PQ2->PQ2_FILIAL := cFilPQ2
			        PQ2->PQ2_ID := cCodC
		        endif
		        
    	        PQ2->(MsUnLock())      
    	        
			Elseif lAchou 
				PQ2->(RecLock("PQ2",.F.,.T.))					            
				PQ2->(dbDelete())
				PQ2->(MSUNLOCK())
	        EndIf
	        
	Next nId
elseif nOpc == 5 //Exclusao
	cChavePQ2 := cFilPQ2 + cCodC 
	PQ2->(DbSeek(cChavePQ2))
	While !PQ2->(EOF()) .AND. PQ2->(PQ2_FILIAL+PQ2_ID) == cChavePQ2	
		RECLOCK("PQ2",.F.,.T.)
		PQ2->(DBDELETE())
		PQ2->(MSUNLOCK())
		PQ2->(DBSKIP())
	End
endif		

EndTran()

Return(lRet)                       

User Function TRGA030G(cCpo,cValCpo)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para execuÁ„o dos gatilhos dos campos de consulta
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nPSX3 := aScan(aHeader,{|x| AllTrim(X[2]) == "PQ2_SX3"}) 
Local nPNome := aScan(aHeader,{|x| AllTrim(X[2]) == "PQ2_NOME"}) 
Local nPTitulo := aScan(aHeader,{|x| AllTrim(X[2]) == "PQ2_TITULO"}) 
Local nPTipo := aScan(aHeader,{|x| AllTrim(X[2]) == "PQ2_TIPO"}) 
Local nPTam := aScan(aHeader,{|x| AllTrim(X[2]) == "PQ2_TAM"}) 
Local nPTamDec := aScan(aHeader,{|x| AllTrim(X[2]) == "PQ2_TAMDEC"}) 
Local nPPic := aScan(aHeader,{|x| AllTrim(X[2]) == "PQ2_PIC"}) 
Local nPNivel := aScan(aHeader,{|x| AllTrim(X[2]) == "PQ2_NIVEL"}) 
Default cValCPO := &(ReadVar())

if cCpo == "PQ2_NOME"
	if aCols[n,nPSX3] == "S"
		SX3->(DBSETORDER(2))
		if SX3->(DBSEEK(cValCpo))
			aCols[n,nPTitulo] := SX3->X3_TITULO
			Do Case
				Case SX3->X3_TIPO == "C"
					aCols[n,nPTipo] := "1"
				Case SX3->X3_TIPO == "N"
					aCols[n,nPTipo] := "2"
				Case SX3->X3_TIPO == "L"
					aCols[n,nPTipo] := "3"
				Case SX3->X3_TIPO == "D"
					aCols[n,nPTipo] := "4"
			End Case		
			aCols[n,nPTam] := SX3->X3_TAMANHO
			aCols[n,nPTamDec] := SX3->X3_DECIMAL
			aCols[n,nPPic] := SX3->X3_PICTURE
			aCols[n,nPNivel] := Alltrim(Str(SX3->X3_NIVEL,2,0))
		endif
	endif
endif	   
		
Return cValCpo

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

Local aRotina := { 	{"Pesquisar","AxPesqui",0,1} ,;
					{"Visualizar","U_TRGA030T(2)",0,2} ,;
					{"Manutencao","U_TRGA030T(4)",0,4} ,;
					{"Excluir","U_TRGA030T(5)",0,5}}

Return aRotina

User Function T030_Mnu()

Return MenuDef()