#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Rcoma08()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CNUMPED,_CNFOR,LRET,CFORNECE,C,CCAMPO")
SetPrvt("CFIL,_CPATH,_CFIL,_CPRODUTO,")

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³RCOMA08   ³ Autor ³ Emerson Augusto       ³ Data ³ 30/11/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pedido de Compras      -           Exclusao                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_cNumped := Space(6)
_cNfor:=Space(30)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Interface                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 70,11 To 373,598 Dialog _ODLG1 Title OemToAnsi("SUSPENDE / EXCLUI -> PEDIDO DE COMPRAS")
@ 24,11 To 86,247 Title OemToAnsi("Pedido")
@ 99,11 To 149,250 Title OemToAnsi("ATENCAO")
@ 40,28 Say OemToAnsi("Numero do Pedido") Size 60,15
@ 112,16 Say OemToAnsi("ESTE PROGRAMA EXCLUIR O PEDIDO ACIMA") Size 218,22
@ 40,96  Get _cNumped F3("SZ4") VAlid cped() Size 42,12// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 40,96  Get _cNumped F3("SZ4") VAlid Execute(cped) Size 42,12
@ 55,96  SAY _cNFor  Size 100,12
@ 70,200 Button  "_Exclui"  action _Exclui()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 70,200 Button  "_Exclui"  action Execute(_Exclui)
@ 90,200 Bmpbutton Type 2 action cLOSE(_odLg1)
Activate Dialog _ODLG1
Return
/**************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function Cped
Static Function Cped()
 Lret:=.f.
 DbselectArea("SZ4")
 Dbsetorder(2)
 Dbseek(xfilial("SZ4")+_cNumped)
 IF !EOF()
	 cFornece:=SZ4->Z4_FORNECE
	 Lret:=.t.
	 DbselectArea("SA2")
	 Dbsetorder(1)
	 Dbseek(xfilial("SA2")+cFornece+"01")
	 IF !EOF()
		_cNFOR:=SA2->A2_NOME
	 Endif
 Endif
Return(lret)
/**************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _Exclui
Static Function _Exclui()
Close(_odLg1)
DbselectArea("SZ4")
Dbsetorder(2)
Dbseek(xfilial("SZ4")+_cNumped,.t.)
While SZ4->Z4_NUMPED == _cNumped
  For C := 1 to 20
   cCampo:="SZ4->Z4_FIL"+Strzero(C,2)
   IF !Empty(&cCampo)
	   cfil:=&cCampo
       IF SZ4->Z4_SIT #"A"
//          Abrefil()
          Apagac7()
//          Fechafil()
       Endif
   Endif
  Next c
  dbSelectArea("SZ4")
  RecLock("SZ4",.F.)
  Dbdelete()
  MsUnLock()
  Dbselectarea("SZ4")
  Dbskip()
Enddo
MsgBox("Excluido Pedido  NUMERO  "+ _cNumped ,"ATENCAO","ALERT")
RETURN
/**************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function AbreFil
Static Function AbreFil()

_CPATH:="\SIGA\DADOSADV\"

     _cFIL:= &cCampo+"0"

	 If !File(_cPath+"SC7"+_cFIL+".DBF" )
		MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SD2"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
		Return .F.
	 Endif
	 If !File(_cPath+"SB2"+_cFIL+".DBF" )
		MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SF4"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
		Return .F.
	 Endif
	 dbUseArea( .T. ,, _cPath+"SC7"+_cFIL,"_SC7", .F. , .F. )
	 dbSetIndex(_cPath+"SC7"+_cFIL)
	 dbUseArea( .T. ,, _cPath+"SB2"+_cFIL,"_SB2", .F. , .F. )
	 dbSetIndex(_cPath+"SB2"+_cFIL)
Return
/**************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function FechaFil
Static Function FechaFil()
Dbselectarea("_SC7")
Dbsetorder(1)
Dbselectarea("_SB2")
Dbsetorder(1)
_SC7->( DbClearInd())
_SC7->( DbCloseArea())
_SB2->( DbClearInd())
_SB2->( DbCloseArea())
Return
/**************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function Apagac7
Static Function Apagac7()

Dbselectarea("SC7")
Dbsetorder(1)
Dbseek(cfil+_cNumped,.t.)
While SC7->C7_NUM == _cNUMPED
      _cProduto:=SC7->C7_PRODUTO
      Dbselectarea("SB1")
      DbSetorder(1)
      Dbseek(xfilial("SB1")+_cProduto)
      IF !EOF()
         Reclock("SB1",.F.)
         SB1->B1_PEDABE := SB1->B1_PEDABE - SC7->C7_QUANT
         mSunlock()
      Endif
      Dbselectarea("SB2")
      Dbsetorder(1)
      Dbseek(cfil+_cProduto+"01")
      if !eof()
         Reclock("SB2",.F.)
         SB2->B2_SALPEDIN:=SB2->B2_SALPEDIN - SC7->C7_QUANT
         MsUnLock()
      Endif
      Dbselectarea("SC7")
      Reclock("SC7",.F.)
         Dbdelete()
      MsUnLock()
      Dbselectarea("SC7")
      Dbskip()
End-While
Return
