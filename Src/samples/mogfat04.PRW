#INCLUDE "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MOGFAT04  ºAutor  ³Denise Dinucci      º Data ³  08/01/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gatilho para armazenar o valor correto do frete ao preco    º±±
±±º          ³unitario.                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ESPECIFICO PARA MOINHO PACIFICO                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Mogfat04()

SetPrvt("_nPosFl,_cProduto,_nPreco,_nFrete,_cArea,_cOrdem,_nRec")

_cArea:=Alias()
_cOrdem:=IndexOrd()
_nRec:=Recno()  
_nPosFl := aScan(aHeader,{|x| UPPER(AllTrim(x[2]))=="C6_PRODUTO" })
_cProduto:=aCols[n,_nPosFl]
_nPosFl := aScan(aHeader,{|x| UPPER(AllTrim(x[2]))=="C6_PRCVEN" })
If ReadVar()=="M->C6_PRCVEN"
 	If M->C5_TIPO=="N"
   	If UPPER(substr(cUsuario,7,8))=="TERENCE "  .OR. UPPER(substr(cUsuario,7,8))=='ADMINIST'
      	_nPreco:=aCols[n,_nPosFl]
      	Return(_nPreco)
   	ElseIf UPPER(substr(cUsuario,7,8))=="MARCIA  " .AND. Left(_cProduto,4) $ '0814,0815'
      	_nPreco:=aCols[n,_nPosFl]
      	Return(_nPreco)
   	Else
      	MSGBOX("Usuario nao tem permissao para alterar preco !!!","Mensagem","INFO")
      	If Altera
         	_nPreco:=SC6->C6_PRCVEN //aCols[n,nPos]
         	Return(_nPreco)
      	Endif
   	Endif 
 	Else // para devolucao de compras
   	_nPreco:=aCols[n,_nPosFl]
   	Return(_nPreco)
 	Endif  
Endif  

_nFrete:=0
_nPreco:=0
DbSelectArea("SA1")
DbSeek(XFilial("SA1")+M->C5_CLIENTE+M->C5_LOJACLI)

If .F. // Found()
 	DbSelectArea("SZ1")
 	DbSeek(XFilial("SZ1")+SA1->A1_ZONATRA)
 	If Found()
  		_nFrete:=Z1_VALOR
 	Else
  		_nFrete:=0
 	Endif   
Endif   

If Inclui  // para nao acumular o valor do frete, busca novamente o preco unitario
 	If M->C5_TABELA="1"
  		DbSelectArea("SB1")
  		DbSeek(XFilial("SB1")+_cProduto)
  		_nPosFl := aScan(aHeader,{|x| UPPER(AllTrim(x[2]))=="C6_PRCVEN" })     
  		aCols[n,_nPosFl]:=B1_PRV1
 	Else   
  		DbSelectArea("SB5")
  		DbSeek(XFilial("SB5")+_cProduto)
  		_nPosFl := aScan(aHeader,{|x| UPPER(AllTrim(x[2]))=="C6_PRCVEN" })     
  		If M->C5_TABELA="2"
   		aCols[n,_nPosFl]:=B5_PRV2
		ElseIf M->C5_TABELA="3" 
   		aCols[n,_nPosFl]:=B5_PRV3
  		ElseIf M->C5_TABELA="4" 
   		aCols[n,_nPosFl]:=B5_PRV4
  		ElseIf M->C5_TABELA="5" 
   		aCols[n,_nPosFl]:=B5_PRV5
  		ElseIf M->C5_TABELA="6" 
   		aCols[n,_nPosFl]:=B5_PRV6
  		ElseIf M->C5_TABELA="7" 
   		aCols[n,_nPosFl]:=B5_PRV7
  		Endif   
	Endif 
Endif

If Altera .and. _cProduto==SC6->C6_Produto
 	aCols[n,_nPosFl]:=aCols[n,_nPosFl]-_nFrete
endif

_nPreco := aCols[n,_nPosFl]                                        
If M->C5_TPFRETE<>"C"
 	_nPosFl := aScan(aHeader,{|x| UPPER(AllTrim(x[2]))=="C6_PRUNIT" })
 	aCols[n,_nPosFl]:=_nPreco
 	DbSelectArea(_cArea)
 	DbSetOrder(_cOrdem)
 	DbGoto(_nRec)
 	Return(_nPreco)
Endif   

_nPreco:=_nPreco+_nFrete
_nPosFl := aScan(aHeader,{|x| UPPER(AllTrim(x[2]))=="C6_PRUNIT" })
aCols[n,_nPosFl]:=_nPreco 
DbSelectArea(_cArea)     
DbSetOrder(_cOrdem)
DbGoto(_nRec)

Return(_nPreco)