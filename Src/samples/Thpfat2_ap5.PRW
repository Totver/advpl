#INCLUDE "rwmake.ch"
#include "ap5mail.ch"
#include 'MsOle.ch'

User Function Thpfat2()

SetPrvt("_NUMPC_OBSITEM,_MOTIVO,_ITEM,_PRODUTO,_DESCR,_QTDE,_PESO,_MEDIDA1,_MEDIDA2,_COMPR,_UM,_UNITARIO,_TOTAL,_ALMOX,_TES")
SetPrvt("NOPCX,NUSADO,AHEADER,ACOLS,_CDOCU,_CITEM,_RET")
SetPrvt("_NVEND,_DCOND,_ATEND,_NORC,_DATA,_TIPO,_DTEN,_NFAN,_CCLI,_MUNI,_COND,_TRANS,_CON,_CTEXTO,_OBS1,_OBS2")
SetPrvt("_CPROD,_DDATA,_NPERC,_NQTDIT,_NTOTAL,CTITULO,AC,_CCLIENE")
SetPrvt("AR,ACGD,CLINHAOK,CTUDOOK,LRETMOD2,_LVALID,_nMed2,cTOPO,cBOT")
SetPrvt("CARQUIVO,HWORD,_LVALID1,_CPECA,_CFICHA,NCONT,_CTEST,_NTHVALOR")
SetPrvt("_NTHCOBAL,_CTHCORRI,_CTHDUREZ,_CTHOPROD,_NVALOR,_REC")
Public AHEADER,ACOLS,_norc,_atend,_rec,_tipo,_data,_dten,_nfan,_ccli,_razao,_muni,_cond,_dcond,_trans,_con,_ctexto,_obs1,_obs2,_nqtdit,_ntotal
Public _cEmail,_cContato,_cFax,_nOpc,_nVend,obsitem,_motivo

_nOpc:= .f.
_norc := 0
_atend  := subs(cusuario,7,15) 
_rec    := Recno()
_data   := date()
_dent   := date()
_nfan   := space(10)
_ccli   := space(3)
_razao  := space(20)
_muni   := space(10)
_cond   := space(3)
_dcond  := space(10)
_trans  := space(3)
_con    := space(10)
_cTexto := space(256)
_obs1   := space(50)
_obs2   := space(50)
_cTel   := space(15)
_nQtdIt := 0
_ntotal := 0
_nVend := space(6)
cTitulo := "Sistema de Orcamento"

Processa( {|| f_num() } )// recebe o nr. do orcamento

SetKey( 117, { || _itCli(_ccli) } ) // f6 Clientes
SetKey( 119, { || _memo() } ) // f8
SetKey( 120, { ||  _itPedidos(_ccli) } ) // pedidos //f9
SetKey( 121, { ||  _itEst() }) // estoque //f10   

nOpcx  := 3

_Item      := space(2)
_produto := space(10)
_descr     := space(20)
_qtde      := 0
_peso      := 0
_medida1:= 0
_medida2:= 0
_compr	:= 0
_um 		:= "  "
_unitario  := 0
_total		:= 0
_almox	:= space(2)
_tes 		:= space(3)
_obsitem := space(50)
_motivo   := " "       
//_numpc := space(7)
nUsado   := 15
AHEADER  := {}
ACOLS      := Array(1,16)    

ACOLS[1][16] := .F. 

AADD(AHEADER,{"ITEM"                    , "ck_item   "    , "99"      ,02,0,,, "C",, } )
AADD(AHEADER,{"CODIGO"              , "ck_produto" , "@!"      ,10,0,"ExecBlock('thpfat2a',.f.,.f.)",, "C","SB1", } )
AADD(AHEADER,{"DESCRICAO"       , "ck_descri "   , "@!"      ,20,0,,, "C", , } )
AADD(AHEADER,{"MEDIDA1"            , "ck_thmedi1" , "9999.999",08,3,"ExecBlock('thpfat2b',.f.,.f.)",, "N", "SZ1", } )
AADD(AHEADER,{"MEDIDA2"            , "ck_thmedi2" , "9999.999",08,3,,, "N", "SZ1", } )
AADD(AHEADER,{"COMPRIMENTO", "ck_thcompr", "9999.999"   ,05,0,"ExecBlock('thpfat2b',.f.,.f.)",, "N",, } )
AADD(AHEADER,{"QTDE"    			     , "ck_thquant" , "999.99"     ,03,0,"ExecBlock('thpfat2b',.f.,.f.)",, "N", , } )
AADD(AHEADER,{"PESO"    				, "ck_qtdven"  , "999.99"     ,03,0,,, "N", , } )
AADD(AHEADER,{"UN"      				, "ck_um"        , "@!"      ,02,0,"ExecBlock('thpfat2c',.f.,.f.)",, "C",, } )
AADD(AHEADER,{"UNITARIO"			, "ck_prunit"    , "9999.99",08,3,"ExecBlock('thpfat2c',.f.,.f.)",, "N",, } )
AADD(AHEADER,{"TOTAL"    			, "ck_valor"     , "9999.99",08,3,"ExecBlock('thpfat2c',.f.,.f.)",, "N",, } )
//AADD(AHEADER,{"NUMPECA"			, "ck_thnumpc" , "9999999",07,0,,, "C",, } )
AADD(AHEADER,{"ALMOX."  			, "ck_local"     , "@!"      ,02,0,,, "C",,  } )
AADD(AHEADER,{"TES"     				, "ck_tes"        , "@!"      ,03,0,,, "C",, } )
AADD(AHEADER,{"OBSERVACAO"   , "ck_thobs"    , "@!"      ,50,0,,, "C",, } )
AADD(AHEADER,{"PERCA"     			, "ck_thmotiv" , "9"      ,1,0,"ExecBlock('thpfat2d',.f.,.f.)",, "C",, } )


_Item       := aScan(AHEADER,{|x| x[2]=="ck_item"})
_produto  := aScan(AHEADER,{|x| x[2]=="ck_produto"})
_descr      := aScan(AHEADER,{|x| x[2]=="ck_descri"})
_medida1  := aScan(AHEADER,{|x| x[2]=="ck_thmedi1"})
_medida2  := aScan(AHEADER,{|x| x[2]=="ck_thmedi2"})
_compr     := aScan(AHEADER,{|x| x[2]=="ck_thcompr"})
_qtde        := aScan(AHEADER,{|x| x[2]=="ck_thquant"})
_peso       := aScan(AHEADER,{|x| x[2]=="ck_qtdven"})	
_um          := aScan(AHEADER,{|x| x[2]=="ck_um"})
_unitario    := aScan(AHEADER,{|x| x[2]=="ck_prcven"})
_total        := aScan(AHEADER,{|x| x[2]=="ck_valor"})
//_numpc    := aScan(AHEADER,{|x| x[2]=="ck_thnumpc"})
_almox      := aScan(AHEADER,{|x| x[2]=="ck_local"})                 
_tes          := aScan(AHEADER,{|x| x[2]=="ck_tes"})	
_obsitem   := aScan(AHEADER,{|x| x[2]=="ck_thobs"})
_motivo     := aScan(AHEADER,{|x| x[2]=="ck_thmotiv"})		

ACOLS[1][01] := space(02)
ACOLS[1][02] := space(15)
ACOLS[1][03] := space(30)
ACOLS[1][04] := 0
ACOLS[1][05] := 0
ACOLS[1][06] := 0
ACOLS[1][07] := 0
ACOLS[1][08] := 0
ACOLS[1][09] := space(02)
ACOLS[1][10] := 0
ACOLS[1][11] := 0
//ACOLS[1][12] := space(07)
ACOLS[1][12] := "  "
ACOLS[1][13] := "   "
ACOLS[1][14] := space(50)
ACOLS[1][15] := " "
aC:={}

AADD(aC,{"strzero(_norc,6)" , {15,002} , "Orcamento Nr:" ,"@!",,,.F.})
AADD(aC,{"_atend"               , {15,095} , "Atendente:" ,"@!",,,.F.})
AADD(aC,{"dtoc(_data)"        , {15,215} , "Data emissao:" ,"@!",,,.F.})
AADD(aC,{"_nfan"     , {27,002} , "Nome:" ,"@S10","ExecBlock('thpfat2e',.f.,.f.)" ,"SA1",})
AADD(aC,{"_ccli"	      	  	   , {27,85} , "Codigo:" ,"@!", ,,.T.})
AADD(aC,{"_muni"	   , {27,140} , "Municipio:" ,"@!", ,,.F.})
AADD(aC,{"_nVend" 		   , {27,230} , "Vendedor:" ,"@!", ,,.F.})
AADD(aC,{"_cond" 			   , {39,002} , "Pagamento:" ,"999", ,"SE4",.T.}) 
AADD(aC,{"_trans"			   , {39,105} , "Transportadora:" ,"999", ,"SA4",.T.})
AADD(aC,{"_con" 			   , {39,205} , "Contato:" ,"@!", ,,.f.})
AADD(aC,{"_obs1"			   , {51,002} , "Obs Faturamento:" ,"@S50", ,,.t.})
AADD(aC,{"_obs2" 			   , {63,002} , "Obs Producao:" ,"@S50", ,,.t.})

aR        :={}
_ckey1 := ""
AADD(aR,{"_nQtdIt " , {125,010} , "Qtd. de Itens" ,"@E 999",,,.F.})
AADD(aR,{"_ntotal "  , {125,250} , "Total" ,"@E 99999.99",,,.F.})
AADD(aR,{"_ckey1"  , {125,70} , " [F6] Clientes  [F8] Historico  [F9] Pedidos   [F10]  Estoque " ,"@!",,,.F.})

aCGD := {70,05,124,315}

cLinhaOk:="ExecBlock('thpfat2f',.F.,.F.)"
cTudoOk:="ExecBlock('thpfat2g',.f.,.f.)"

lRetMod2:=Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)

If lRetMod2
	if empty(ACOLS[n][2]) .or. empty(ACOLS[n][4]) .or. empty(ACOLS[n][10]) .or. empty(ACOLS[n][11])
          if !msgbox("Os dados necessarios dos itens nao foram incluidos corretamente, gravar a cotacao","Fechamento da cotacao","YESNO")
			return
		endif
	endif
//	_ccli := sa1->a1_cod
    For _l := 1 To  Len(ACOLS)
        If !ACOLS[_l,16]
            dbSelectArea("SCK")
            RecLock("SCK",.T.)
            sck->ck_FILIAL        := xFilial()
            sck->ck_LOJA           := "01"                      
            sck->ck_ITEM           := ACOLS[_l,01]            
            sck->ck_PRODUTO  := ACOLS[_l,02]
            sck->ck_DESCRI       := ACOLS[_l,03]
            sck->ck_THMEDI1    := ACOLS[_l,04]
            sck->ck_THMEDI2    := ACOLS[_l,05]
            sck->ck_THCOMPR  := ACOLS[_l,06]            
            sck->ck_THQUANT  := ACOLS[_l,07]
            sck->ck_QTDVEN     := ACOLS[_l,08]
  	       sck->ck_UM              := ACOLS[_l,09]
            sck->ck_PRCVEN     := ACOLS[_l,10]
            sck->ck_VALOR       := ACOLS[_l,11]
//            sck->ck_THNUMPC := ACOLS[_l,12]            
            sck->ck_LOCAL       := ACOLS[_l,12]
            sck->ck_TES    		  := ACOLS[_l,13]            
            sck->ck_THOBS        := ACOLS[_l,14]                        
            sck->ck_THMOTIV	  := ACOLS[_l,15]                        
            if empty(sa1->a1_cod) // se nao é cliente cadastrado            
	            sck->ck_CLIENTE    := _ccli
            else
     	       sck->ck_CLIENTE    := sa1->a1_cod            
            endif
  	       sck->ck_NUM           := strzero(_norc,6)	    

            MsUnLock()

        Else
            dbSelectArea("SCK")
            dbSetOrder(1)
            If dbSeek(xFilial("SCK")+strzero(_norc,6)+ACOLS[_l,01]+ACOLS[_l,02])
                RecLock("SCK",.F.)
                dbDelete()
                MsUnLock()
            Endif
        EndIf
    Next _l
    	       dbSelectArea("SCJ")
            RecLock("SCJ",.T.)
            scj->cj_filial         := xFilial()
            scj->cj_LOJA     := "01"          
            scj->cj_tabela      := "1"            
    	       scj->cj_num         := strzero(_norc,6)	    
     	  scj->cj_thatend    := _atend
		  scj->cj_emissao   := _data
		  scj->cj_thdtent     := _data		  
            if empty(sa1->a1_cod) // se nao é cliente cadastrado                        		  
			  scj->cj_thnocli     := _nfan
			  scj->cj_cliente     := _ccli
		  else
			  scj->cj_thnocli     := sa1->a1_nreduz
			  scj->cj_cliente     := sa1->a1_cod
		  endif		  
		  scj->cj_condpag := _cond
       	  scj->cj_thdcond  := _dcond				  
		  scj->cj_thhisto    := _cTexto 
		  scj->cj_thobsft    := _obs1
		  scj->cj_thobspr   := _obs2
//		  scj->cj_status      := "A"
		  scj->cj_thvend    := _nvend
            MsUnLock()
           Processa( {|| palink(scj->cj_num,scj->cj_cliente) } )       
/*/
		    if msgbox("Deseja imprimir o orcamento","Imprimir","YESNO")
		       Processa( {|| Pcampos() } )       
		    elseif msgbox("Deseja enviar o orcamento para o fax do cliente ","Envio","YESNO")
		       Processa( {|| _cDadosfax() } )              
		    else
	        _nOpc := msgbox("Deseja enviar o orcamento para o e-mail do cliente ","Envio","YESNO")    
	        if _nOpc
		           Processa( {|| _cDadosmail() } )                
	        endif        
	    endif   
	   /*/ 
Endif
SetKey( 117, Nil)
SetKey( 119, Nil)
SetKey( 120, Nil)
SetKey( 121, Nil)

dbSelectArea("SCJ")
dbGoto(_rec)     

Return

//=================

Static  Function _itEst( )

if empty(ACOLS[n][2])  
	alert("O codigo do produto nao foi incluido corretamente")
	return
endif

cAlias := Alias()
cIndex := IndexOrd()
nRec   := Recno()
_lValid := .T.

cCadastro := "Informacoes do Estoque"
aac:={"Abandona","Confirma"}
aRotina   := { { "Pesquisar"   ,"AxPesqui" , 0, 1},{ "Visualizar"   ,"AxVisual" , 0, 2}}
lAltera :=.f.
cdelfunc:=".f."
acampos:={{"PRODUTO","Z1_THPRODU"},;
          {"MEDIDA1","Z1_THMEDI1"},;
          {"MEDIDA2","Z1_THMEDI2"},;
          {"COMPRIMENTO", "Z1_THCOMPR"},;          
          {"PESO",   "Z1_THPESO"},;
          {"FORNEC", "Z1_THFORNE"},;
          {"COMPRA", "Z1_THDATAE"}}

_nMed2  := 205

dbSelectArea("SZ1")
dbsetorder(3)                                                                
cTopo := 'xFilial("SZ1")+acols[n][2]' //+Str(acols[n][4],8,3)'
//cTopo := 'xFilial("SZ1")+acols[n][2]' +padl(alltrim(Str(acols[n][4],8,3)))'
cBot    := 'xFilial("SZ1")+acols[n][2]'//+Str(_nMed2,8,3)'

mBrowse( 0,0,5,75,"SZ1",acampos,,,,,,cTopo,cBot) 
set filter to
dbSelectArea( cAlias )
dbSetOrder( cIndex )
dbGoto( nRec )
Return(_lValid)        

//===============
Static  Function _itCli(_codc)

if empty(_codc)
  alert("Codigo do cliente nao informado")
  return                                         
elseif _codc == "999999"
  alert("Nao ha dados do cliente para exibir")
  return                                           
endif 

cAlias := Alias()
cIndex := IndexOrd()
nRec   := Recno()
_lValid := .T.

DadosCliente(_codc)

dbSelectArea( cAlias )
dbSetOrder( cIndex )
dbGoto( nRec )
Return(_lValid)        

//=================
Static  Function _itPedidos(_codc)               
if empty(_codc)
  alert("Codigo do cliente nao informado")
  return
elseif _codc == "999999"
  alert("Nao ha dados do cliente para exibir")
  return                                             
endif 

a_aheader := aheader
a_acols     := acols
cAlias := Alias()
cIndex := IndexOrd()
nRec   := Recno()
_lValid := .T.

cCadastro := "Informacoes dos Pedidos"
aac:={"Abandona","Confirma"}

aRotina   := { { "Pesquisar"   ,"AxPesqui" , 0, 1},{ "Visualizar"   ,'ExecBlock("thpfat2h")' , 0, 2}}

lAltera :=.f.
cdelfunc:=".f."
dbSelectArea("SC5")  
dbsetorder(3)
dbSeek(xfilial("SC5")+_codc)
if eof()
	alert("Esse cliente nao tem pedido cadastrado")
	return
endif
_ccliente:= _codc
cTopo := 'xFilial("SC5")+_ccliente'  
cBot    := 'xFilial("SC5")+_ccliente' 
mBrowse( 0,0,5,75,"SC5",,,,,,,cTopo,cBot)
set filter to
aheader := a_aheader 
acols := a_acols

dbSelectArea( cAlias )
dbSetOrder( cIndex )
dbGoto( nRec )
Return(_lValid)        

//=================
static function DadosCliente(c_codigo)

@ 6,6 TO 160,600 DIALOG Dcli TITLE OemToAnsi("Dados Cadastrais")

dbSelectArea("SA1")
dbSetOrder(1)
dbSeek(xFilial("SA1")+c_codigo)

@10,10   say "Codigo"
@10,40   get c_codigo             Size  20,1 When .F.
@10,105 say "Nome:"
@10,130 get sa1->a1_nome    Size  150,1 When .F.
@20,10   say "N. Fantasia "
@20,40   get sa1->a1_nreduz  Size  50,1 When .F.
@20,105 say "Contato: "
@20,130 get sa1->a1_contato Size  50,1 When .F.
@30,10   say "Municipio"
@30,40   get sa1->a1_mun      Size  50,1 When .F.
@30,105 say "Endereco"
@30,130 get sa1->a1_end       Size  150,1 When .F.
@40,10   say "Telefone"
@40,40   get sa1->a1_tel         Size  50,1 When .F.
@40,105 say "Estado"
@40,130 get sa1->a1_est        Size  20,1 When .F.

@ 60,10 BMPBUTTON TYPE 1 ACTION Close(Dcli)
ACTIVATE DIALOG Dcli 
Return

static function f_num()

dbselectarea("SCJ")  
dbGotop()
while ! eof()
   dbskip()
   if eof()
      dbskip(-1)
      _nm := val(cj_num)+1
      _norc := _nm
      dbskip()
   endif
end
return
         
//=============       
static function _memo()
Public _ctexto
@ 210,230 To 360,620 Dialog DMemo Title "Historico"
@ 015,015 Get _cTexto   Size 140,050  MEMO                 Object oMemo
@ 040,160 BmpButton Type 1 Action Close(DMemo)
Activate Dialog DMemo
Return


static function _CDadosfax()

@ 96,012 TO 250,400 DIALOG oDlg TITLE OemToAnsi("DADOS DO CLIENTE")
@ 08,005 TO 048,190

dbSelectArea("SA1")
dbSetOrder(1)
dbSeek(xFilial("SA1")+_ccli+"01")

_cEmail := sa1->a1_email
_cFax := sa1->a1_fax
_cContato := sa1->a1_contato
@18,10 say "Contato "     
@28,10 say "Fax     "
@18,40 get _cContato
@28,40 get _cFax

//	@ 56,100 BMPBUTTON TYPE 5 ACTION Pergunte("PRJWOR",.T.)
@ 56,130 BMPBUTTON TYPE 1 ACTION WordImp()// Substituido pelo assistente de conversao do AP5 IDE em 22/03/00 ==> @ 56,130 BMPBUTTON TYPE 1 ACTION Execute(WordImp)
@ 56,160 BMPBUTTON TYPE 2 ACTION Close(oDlg)
ACTIVATE DIALOG oDlg CENTERED

Return

//============

static function _cDadosmail()

@ 96,012 TO 250,400 DIALOG dglmail TITLE OemToAnsi("DADOS DO CLIENTE")
@ 08,005 TO 048,190

dbSelectArea("SA1")
dbSetOrder(1)
dbSeek(xFilial("SA1")+_ccli)

_cEmail := sa1->a1_email
_cContato := sa1->a1_contato
@18,10 say "Contato "     
@38,10 say "E-mail  "
@18,40 get _cContato 
@38,40 get _cEmail 

//	@ 56,100 BMPBUTTON TYPE 5 ACTION Pergunte("PRJWOR",.T.)
@ 56,130 BMPBUTTON TYPE 1 ACTION i_mail()// Substituido pelo assistente de conversao do AP5 IDE em 22/03/00 ==> @ 56,130 BMPBUTTON TYPE 1 ACTION Execute(WordImp)
@ 56,160 BMPBUTTON TYPE 2 ACTION Close(dglmail)
ACTIVATE DIALOG dglmail CENTERED

Return

//==========
static function i_mail()

dbSelectArea("SA1")
dbSetOrder(1)
dbSeek(xFilial("SA1")+_ccli)
if ! eof()
  RecLock("SA1",.F.)
  sa1->a1_contato := _cContato
  sa1->a1_email   := _cEmail
  MsUnlock()  
Endif 

Processa( {|| palink(scj->cj_num,scj->cj_cliente) } )                

_afiles := {"\arq\taefax.doc"}    

CONNECT SMTP SERVER "smtp.thyssen-tae.com.br" ACCOUNT "paulo@thyssen-tae.com.br" PASSWORD "paul5734"

SEND MAIL FROM "paulo@thyssen-tae.com.br" to  _cEmail  SUBJECT "Orcamento Thyssen "+strzero(_norc,6)  BODY  "Segue orcamento em anexo conforme solicitacao"   //ATTACHMENT   _afiles

DISCONNECT SMTP SERVER

return

//===========
                         
Static Function WordImp()

Processa( {|| palink(scj->cj_num,scj->cj_cliente) } )                

   

Close(oDlg)

return
//==========

Static Function paLink(_norcamento,_ccliente)

SetPrvt("CDT1,CDT2,CDT3,NCONTADOR,CTEXTO1,CTEXTO2")
SetPrvt("CTEXTO3,CTEXTO4,CTEXTO5,CTEXTO6,CMEMO,NLINES")
SetPrvt("NVALOR1,NVALOR2,NVALOR3,NVALOR4,NVALOR5,CVENC1")
SetPrvt("CVENC2,CVENC3,CVENC4,CVENC5,CEQUIPE,CTYPE")
SetPrvt("CARQUIVO,HWORD,_CCLIENTE,_NORCAMENTO")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametros usados na rotina                   ³
//³ mb_par01         numero do orcamento          ³
//³ mv_par02         numero de vias               ³
//³ mv_par03         comentarios fax              ³
//³ mv_par04         enviado por                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Pergunte("PRJWOR",.F.)

dbSelectArea("SA1")
dbSetOrder(1)
dbSeek(xFilial("SA1")+_ccliente)
/*/
IF ! EOF()
  RecLock("SA1",.F.)
  sa1->a1_contato := _cContato
  sa1->a1_fax     := _cFax
  MsUnlock()  
Endif 
/*/
dbSelectArea("SCJ")
dbSetOrder(1)
dbSeek(xFilial("SCJ")+_norcamento)
If EOF()
   MsgStop(OemToAnsi("Orcamento nao encontrado"))
   Return Nil
EndIf

cDt1 := alltrim(str(day(_DATA)))
cDt2 := month(_DATA)
If cDt2 == 1
   cDt2 := "janeiro"
Elseif cDt2 == 2
   cDt2 := "fevereiro"
Elseif cDt2 == 3
   cDt2 := "marco"
Elseif cDt2 == 4
   cDt2 := "abril"
Elseif cDt2 == 5
   cDt2 := "maio"
Elseif cDt2 == 6
   cDt2 := "junho"
Elseif cDt2 == 7
   cDt2 := "julho"
Elseif cDt2 == 8
   cDt2 := "agosto"
Elseif cDt2 == 9
   cDt2 := "setembro"
Elseif cDt2 == 10
   cDt2 := "outubro"
Elseif cDt2 == 11
   cDt2 := "novembro"
Elseif cDt2 == 12
   cDt2 := "dezembro"
Else
   cDt2 := ""
EndIF

cdt3 := str(year(_DATA))

cTexto1:=" "
cTexto2:=" "
cTexto3:=" "
cTexto4:=" "
cTexto5:=" "
cTexto6:=" "
cMemo  := msmm(scj->cj_thhisto)  //PA4->PA4_CODDET)
nLines := Mlcount(cMemo,80)
If nLines >= 1
   cTexto1 := memoline(cMemo,80,1)
EndIf
If nLines >= 2
   cTexto2 := memoline(cMemo,80,2)
EndIF
If nLines >= 3
   cTexto3 := memoline(cMemo,80,3)
EndIF
If nLines >= 4
   cTexto4 := memoline(cMemo,80,4)
EndIF
If nLines >= 5
   cTexto5 := memoline(cMemo,80,5)
EndIF
If nLines >= 6
   cTexto6 := memoline(cMemo,80,6)
EndIF


// Pesquisa para montar os itens 
/*/
dbSelectArea("SCK")
IndRegua("SCK",CriaTrab(,.F.),"CK_NUM",,,"Selecionando SCK010...")
dbSeek(_norcamento)

aitens := {}
nContador := 0    
While !EOF() .And. _norcamento == sck->ck_num       
   AADD(aitens,{ck_descri,ck_thquant,ck_prcven,"10 dias"})
    dbSkip()
    ncontador := ncontador + 1
EndDo


ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 Pesquisa da equipe 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SX5")
dbSetOrder(1)
dbSeek(xFilial()+"SX5"+"04")
cEquipe := X5_DESCRI

/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona Arquivo Modelo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ      
//cType := "Arquivos Word|*.DOC|Todos os Arquivos|*.*"
//cType := "\\Thyssen1\ap5\arq\*.doc|Todos os Arquivos|*.*"
//cArquivo := cGetFile(cType, OemToAnsi("Selecione arquivo "))
//cType := "TAEFAX     | *.DOC"
//cArquivo := cGetFile(cType, OemToAnsi("Selecione arquivo "+Subs(cType,1,6)))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia o Word ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArquivo := "\ARQ\TAEFAX.DOC" // a pasta \arq está dentro da pasta \ap5 no servidor
hWord := OLE_CreateLink()   
//OLE_SetPropertie( hWord, oleWdPrintBack, .F.)
//OLE_SetPropertie( hWord, oleWdVisible, .T.)
//OLE_NewFile(hWord, cArquivo)                                                           
OLE_OpenFile(hWord, cArquivo)                                                           
OLE_SetDocumentVar(hWord, 'Adv_Var0001',SA1->A1_NOME)
OLE_SetDocumentVar(hWord, 'adv_Var0002',SA1->A1_CONTATO)
OLE_SetDocumentVar(hWord, 'Adv_Var0003',SA1->A1_FAX)
OLE_SetDocumentVar(hWord, 'Adv_Var0004',"2") // Nr de paginas
OLE_SetDocumentVar(hWord, 'Adv_Var0005',_ATEND)
OLE_SetDocumentVar(hWord, 'Adv_Var0006',DTOC(_DATA))
OLE_SetDocumentVar(hWord, 'Adv_Var0007',_NORCAMENTO)

//FOR I := 1 TO LEN(ACOLS)
_l := 1                                                               
OLE_SetDocumentVar(hWord, 'Adv_Var0008',alltrim(ACOLS[_l,03])) // descricao
OLE_SetDocumentVar(hWord, 'Adv_Var0009', " / "+transform(ACOLS[_l,04],"@E 9999.999")) // medida1
OLE_SetDocumentVar(hWord, 'Adv_Var00010'," x  "+transform(ACOLS[_l,05],"@E 9999.999")) // medida2
OLE_SetDocumentVar(hWord, 'Adv_Var00011',transform(ACOLS[_l,04],"@E 999.99")) // quantidade
OLE_SetDocumentVar(hWord, 'Adv_Var00012',transform(ACOLS[_l,10],"@E 9999.999")) // preco unitario
OLE_SetDocumentVar(hWord, 'Adv_Var00013',"10 dias ")
OLE_SetDocumentVar(hWord, 'Adv_Var00014',"paulo@thyssen-tae.com.br")
If !Empty(cDt1)
   OLE_SetDocumentVar(hWord, 'Adv_Var0015',cDt1)
Else
   OLE_SetDocumentVar(hWord, 'Adv_Var0015'," ")
EndIF
If !Empty(cDt2)
   OLE_SetDocumentVar(hWord, 'Adv_Var0016',cDt2)
Else
   OLE_SetDocumentVar(hWord, 'Adv_Var0016'," ")
EndIF
If !Empty(cDt3)
   OLE_SetDocumentVar(hWord, 'Adv_Var0017',cDt3)
Else
   OLE_SetDocumentVar(hWord, 'Adv_Var0017'," ")
EndIF

OLE_UpdateFields( hWord,cArquivo)
OLE_SaveFile( hWord,cArquivo)   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Qtde de Copias ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*/
if !_nOpc
   OLE_PrintFile( hWord,'PART',1,1,1) //mv_par02)
else
   OLE_SaveFile( hWord )   
endif 
OLE_CloseFile( hWord )
OLE_CloseLink( hWord )
/*/
Return


