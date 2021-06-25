#include "totvs.CH"
                     
User Function TRGC010
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Tela de seleÁ„o Consultas Personalizadas
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local cArqTrb
Local cIndTrb
Local cIndTrbI
Local cIndTrbN
Local cIndTrbO
Local aStruct := {}
Local cTrb1 := GetNextAlias()
Local cTRG1 := GetNextAlias()
Local oSelect, oDlg
Local cMarca := "XX" 
Local oCBox, aCBox, cCBox
Local cBusca := Space(30)
Local nOpca := 0
Local cId   := ""
Local cDebug:= ""
Local cMemo := ""
Local oMemo
Local nColum1 := 0
Local nLinha1 := 0
Local aCampos := {}

cCBox := "Ordem"
aCBox := {"Ordem","Modulo + Nome da Consulta","ID","Nome da Consulta"}

aStruct := {;
{"PQ1_ID"     ,"C",06,0},;
{"PQ1_NOME"   ,"C",50,0},;
{"PQ1_MODULO" ,"C",06,0},;
{"PQ1_MODLNM" ,"C",30,0},;
{"PQ1_ORDER"  ,"C",02,0},;
{"PQ8_DEBUG"  ,"C",01,0},;
{"PQ1_OK"     ,"C",02,0}}

cArqTRB := CriaTrab(aStruct,.T.)
cIndTRB := CriaTrab(Nil,.F.)    
cIndTRBI := CriaTrab(Nil,.F.)                    
cIndTRBN := CriaTrab(Nil,.F.)            
cIndTRBO := CriaTrab(Nil,.F.)            

dbUseArea( .T.,, cArqTRB, cTrb1, .F., .F. )
IndRegua(cTrb1,cIndtrbO,"PQ1_ORDER",,,"Selecionando Registros...")
IndRegua(cTrb1,cIndtrbI,"PQ1_ID",,,"Selecionando Registros...")
IndRegua(cTrb1,cIndtrb,"PQ1_MODLNM+PQ1_NOME",,,"Selecionando Registros...")
IndRegua(cTrb1,cIndtrbN,"PQ1_NOME",,,"Selecionando Registros...")
dbClearIndex()
dbSetIndex(cIndTRBO + OrdBagExt()) 
dbSetIndex(cIndTRB + OrdBagExt()) 
dbSetIndex(cIndTRBI + OrdBagExt()) 
dbSetIndex(cIndTRBN + OrdBagExt()) 
dbSetOrder(1)
MsgRun("          Analizando Acessos, Aguarde . . .  ","Aguarde . . .",{|| RunSql(cTrb1,cTRG1,aStruct)})                      

aCampos := {;
{"PQ1_OK"         ,cTrb1,"  "           },;//01
{"PQ1_ORDER"      ,cTrb1,"Ordem"       },;//02
{"PQ1_MODLNM"     ,cTrb1,"Modulo"       },;//03
{"PQ1_ID"         ,cTrb1,"ID"           },;//04
{"PQ1_NOME"       ,cTrb1,"Consulta"     }}//05

DbSelectarea(cTrb1)
DbSetOrder(1)
(cTrb1)->(DBGOTOP())

While .T.
	nOpca := 0
	DEFINE MSDIALOG oDlg TITLE OemToAnsi("Consultas Personalizadas") From 0,0 To 480,600 of oDlg PIXEL 
	oOrder := TPanel():New(000,000, ,oDlg, , , , , , 0, 20, .F.,.F. )
	oOrder:align := CONTROL_ALIGN_TOP

	@ 005,005 COMBOBOX oCBOX VAR cCBox items aCBox Size 100,010 OF oOrder PIXEL ON CHANGE MudaOrdem(oCBox,cTrb1,@oSelect)
	@ 005,107 MSGET cBusca Size 110,008 OF oOrder PIXEL
	@ 005,222 BUTTON oBtn PROMPT "&BUSCAR" SIZE 38,10 OF oOrder PIXEL ACTION (BuscaCons(cBusca,cTrb1,@oSelect), BuscaMemo(cTrb1,@oMemo,@cMemo)) 

	oPesquisa := TPanel():New(010,000, ,oDlg, , , , , , 0, 0, .F.,.F. )
	oPesquisa:align := CONTROL_ALIGN_ALLCLIENT

	oSelect:=MsSelect():New(cTrb1,"PQ1_OK",,aCampos,.f.,cMarca,{000,10,100,100},,,oPesquisa)
	oSelect:oBrowse:align := CONTROL_ALIGN_ALLCLIENT	   
	oSelect:bAval:={|| SelMark(cTrb1,@oSelect,cMarca)}
	oSelect:oBrowse:bChange := {|| BuscaMemo(cTrb1,@oMemo,@cMemo)}

	oRodape := TPanel():New(000,000, ,oDlg, , , , , , 0, 30, .F.,.F. )
	oRodape:align := CONTROL_ALIGN_BOTTOM
	
  	@ 00,002 GET oMemo VAR cMemo MEMO SIZE (oDlg:nWidth-10)/2, 32 READONLY PIXEL OF oRodape
	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| nOpca := 1, oDlg:End()},{||oDlg:End()}) CENTERED
	
	if nOpca == 1
		(cTrb1)->(dbGoTop())
	  	While !(cTrb1)->(EOF())
	    	if (cTrb1)->PQ1_OK == cMarca
	       		cId := (cTrb1)->PQ1_ID
	       		cDebug := (cTrb1)->PQ8_DEBUG
	       		Exit
	    	endif        
	    	(cTrb1)->(DbSkip()) 
	  	end
	endif  
	
	If nOpca == 0
		Exit
	EndIf
	
	if nopca == 1 .and. !Empty(cId)
		U_TRGC020(cId,cDebug)
	elseif nopca == 1 .and. Empty(cId)
	  	Alert("Marque a consulta do qual deseja executar, com duplo clique do mouse, depois confirme!")
	  	U_TRGC010()
	endif 
EndDo
	
if Select(cTrb1) > 0 
	DbSelectArea(cTrb1)
  	DbCloseArea()
endif  

Ferase(cArqTrb+GetDBExtension())
Ferase(cIndTrb+OrdBagExt())
Ferase(cIndTrbI+OrdBagExt())
Ferase(cIndTrbN+OrdBagExt())
Ferase(cIndTrbO+OrdBagExt())

Return

Static function RunSql(cTrb1,cTRG1,aStruct) 
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para seleÁ„o das Consultas Personalizadas
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local cQuery
Local cCodusr := RetCodUsr() 
Local cGrupos := SQLGrupo()
Local nI	  := 0

cQuery := "SELECT PQ1_ID,PQ1_NOME, PQ1_MODULO, X5_DESCRI AS PQ1_MODLNM, PQ1_ORDER, PQ8_DEBUG, ' ' AS PQ1_OK " 
cQuery +=   "FROM " + RetSQLName("PQ1")+" PQ1 "
cQuery +=   "JOIN " + RETSQLNAME("SX5")+" SX5 ON X5_FILIAL='"+xFilial("SX5")+"' AND X5_TABELA = '_4' AND X5_CHAVE = PQ1_MODULO ""
cQuery +=    "AND SX5.D_E_L_E_T_ = ' ' " 
cQuery +=   "LEFT JOIN " + RETSQLNAME("PQ8")+" PQ8 ON PQ8_FILIAL='"+xFilial("PQ8")+"' AND PQ8_ID = PQ1_ID " 
cQuery +=    "AND PQ8.D_E_L_E_T_ = ' ' "
cQuery +=  "WHERE PQ1.D_E_L_E_T_ = ' ' AND PQ1_FILIAL='"+xFilial("PQ1")+"' AND PQ1_MSBLQL IN (' ', '2') " 
cQuery +=    "AND (PQ1_SGUSR = '2' OR (PQ8_USER = '"+cCodUsr+"'"

if !Empty(cGrupos)
	cQuery += " or PQ8_GRUSER IN ("+cGrupos + "))"
else
  	cQuery += ")"  
endif 
cQuery += ") ORDER BY PQ1_MODULO, PQ1_ORDER"

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cTRG1,.F.,.T.)

(cTRG1)->(DBGOTOP())

While !(cTRG1)->(EOF())
  if !(cTrb1)->(DBSEEK((cTRG1)->PQ1_ID))
    RECLOCK(cTrb1,.T.)
    For nI := 1 to Len(aStruct)
       (cTrb1)->&(aStruct[nI,1]) := (cTRG1)->&(aStruct[nI,1])
    Next nI
    (cTrb1)->(MSUNLOCK())
  endif
  
  (cTRG1)->(Dbskip())  
End

DbSelectarea(cTRG1)
DbCloseArea()
                       
DbSelectarea(cTrb1)
Return

Static Function SQLGrupo()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para montagem da lista de grupos que o usu·rio est· vinculado
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local aGrupo  := UsrRetGrp()
Local cGrupos := ""
Local nI	  := 0 

For nI := 1 to Len(aGrupo)
	if cGrupos == ""
    	cGrupos := "'"+aGrupo[nI]+"'"
  	else
    	cGrupos += ",'"+aGrupo[nI]+"'"
  	endif
Next nI

Return cGrupos

Static function MudaOrdem(oCBox,cTrb1,oSelect)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para escolha da ordem de apresentaÁ„o das consultas
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nRecOld := (cTrb1)->(Recno())

(cTrb1)->(DbSetorder(ocBox:nAt))
(cTrb1)->(DbGoTo(nRecOld))
oSelect:oBrowse:Refresh()

Return 

Static function BuscaCons(cBusca,cTrb1,oSelect)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para pesquisa da consulta personalizada
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nRecOld := (cTrb1)->(Recno())
if !(cTrb1)->(DbSeek(Alltrim(Upper(cBusca))))
  (cTrb1)->(DbGoTo(nRecOld))
else
  oSelect:oBrowse:Refresh()  
endif

Return

Static function SelMark(cTrb1,oSelect,cMarca)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para seleÁ„o da consulta personalizada a ser executada
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nRecOld := (cTrb1)->(Recno())
         
if (cTrb1)->PQ1_OK <> cMarca
	(cTrb1)->(dbGoTop())
  	While !(cTrb1)->(EOF())
    	if (cTrb1)->PQ1_OK == cMarca
       		RECLOCK(cTrb1,.F.)
       		(cTrb1)->PQ1_OK := "  "
       		(cTrb1)->(MSUNLOCK())
       		Exit
    	endif        
    	(cTrb1)->(DbSkip()) 
  	end
  	(cTrb1)->(DbGoTo(nRecOld))
  	RECLOCK(cTrb1,.F.)
  	(cTrb1)->PQ1_OK := cMarca
  	(cTrb1)->(MSUNLOCK())
else
  	RECLOCK(cTrb1,.F.)
  	(cTrb1)->PQ1_OK := "  "
  	(cTrb1)->(MSUNLOCK())
endif  

oSelect:oBrowse:Refresh()  

Return
                                             
Static Function BuscaMemo(cTrb1,oMemo,cMemo)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para busca do help da consulta personalizada
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local aAreaOld := PQ1->(GETAREA())

DbSelectArea("PQ1")
PQ1->(DBSETORDER(1))

if DbSeek(xFILIAL("PQ1")+(cTrb1)->PQ1_ID)
  	cMemo := PQ1->PQ1_HELP
  	oMemo:Refresh()
endif
                
RestArea(aAreaOld)

Return