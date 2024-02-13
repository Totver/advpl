#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Ecoma05d()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CIPI,_CDESCO1,_CDESCO2,_CDESCO3,_CDESCO4,_CDESCO5")
SetPrvt("_CDESCO6,_CDESCO7,_CACRES,_CACRESC,_CCOND,_CNCOND")
SetPrvt("_CCOMPL,_CDESCO,_RETURN,_VAL,_CPRCLQ,_REGISTRO")   

//Public _val,_cprclq

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±³Programa  ³ECOMA05D  ³ Autor ³ Emerson Augusto       ³ Data ³ 07/12/99 ³±±
±±³Descri‡…o ³ Pedido de Compras - Alteracao Descontos /prazos            ³±±
±±³Uso       ³ Especifico para Casa das Cuecas                            ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Close(odlg6)
Dbselectarea("TP2")
_Registro  :=TP2->(Recno())
_cIpi      :=TP2->TP_IPI
_cDesco1   :=TP2->TP_Desco1
_cDesco2   :=TP2->TP_Desco2
_cDesco3   :=TP2->TP_Desco3
_cDesco4   :=TP2->TP_Desco4
_cDesco5   :=TP2->TP_Desco5
_cDesco6   :=TP2->TP_Desco6
_cDesco7   :=TP2->TP_Desco7
_cAcres    :=TP2->TP_Acres
_cAcresC   :=TP2->TP_AcresC
_cCond	   :=TP2->TP_COND
_cNcond    :=TP2->TP_CONDH
_cCompl    :=TP2->TP_COMPL

@ 030,005 To  240,600 Dialog _Odlg5 Title OemToAnsi("Alteracao Desconto/Condicao de Pagamento  - ECOMA05D  -  Pedido Numero -> " +_Cnumped)
@ 010,010 Say OemToAnsi("Descontos")      Size 75,8
@ 030,010 Say OemToAnsi("Acrescimo Fin.") Size 75,8
@ 050,010 Say OemToAnsi("Cond.Pagto") Size 45,10
@ 070,010 Say OemToAnsi("Complemento ") Size 53,10
@ 010,060 Get _cDesco1	Picture "@E 999.99" Size 020,008
@ 010,090 Get _cDesco2	Picture "@E 999.99" Size 020,008 When !empty(_cDesco1)
@ 010,120 Get _cDesco3	Picture "@E 999.99" Size 020,008 When !empty(_cDesco2)
@ 010,150 Get _cDesco4	Picture "@E 999.99" Size 020,008 When !empty(_cDesco3)
@ 010,180 Get _cDesco5	Picture "@E 999.99" Size 020,008 When !empty(_cDesco4)
@ 010,210 Get _cDesco6	Picture "@E 999.99" Size 020,008 When !empty(_cDesco5)
@ 010,240 Get _cDesco7	Picture "@E 999.99" Size 020,008 When !empty(_cDesco6)
@ 030,060 Get _cAcres   Picture "@E 999.99" Size 020,008
@ 030,090 Get _cAcresC  Picture "@E 9"      Size 015,008
@ 050,65  Get _cCond Picture "!!!"          SIZE 70,10 F3("SE4") VALID _Cond()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 050,65  Get _cCond Picture "!!!"          SIZE 70,10 F3("SE4") VALID Execute(_Cond)
@ 050,150 SAY _cNCond size 200,10
@ 070,65  Get _cComPL SIZE 20,10
@ 090, 65 Bmpbutton Type 1 action _GRAVA()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 090, 65 Bmpbutton Type 1 action Execute(_GRAVA)
@ 090,120 Bmpbutton Type 2 action cLOSE(_oDLG5)
Activate Dialog _oDlg5

Return(nil)        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

/***********************************************************************/
Static Function _Cond()
   _Cdesco:=""
   _Return := .T.
   DbSelectArea("SE4")
   DbSetOrder(1)
   If DbSeek(xFilial("SE4")+_cCond)
      _cNCond := SE4->E4_DESCRI
   Else
      _cNCond := Space(Len(SE4->E4_DESCRI))
      _Return := .F.
   EndIf
   IF !empty(_cDesco1)
      _cDesco:=ALLTRIM(str(_cDesco1,6,2))+" % "
   Endif
   IF !empty(_cDesco2)
      _cDesco:=ALLTRIM(_cDesco)+" + "+ALLTRIM(str(_cDesco2,6,2))+" % "
   EndIf
   IF !empty(_cDesco3)
      _cDesco:=ALLTRIM(_cDesco)+" + "+ALLTRIM(str(_cDesco3,6,2))+"+ % "
   EndIf
   IF !empty(_cDesco4)
      _cDesco:=ALLTRIM(_cDesco)+" + "+ALLTRIM(str(_cDesco4,6,2))+"+ % "
   EndIf
   IF !empty(_cDesco5)
      _cDesco:=ALLTRIM(_cDesco)+" + "+ALLTRIM(str(_cDesco5,6,2))+"+ % "
   EndIf
   IF !empty(_cDesco6)
      _cDesco:=ALLTRIM(_cDesco)+" + "+ALLTRIM(str(_cDesco6,6,2))+"+ % "
   EndIf
   IF !empty(_cDesco7)
      _cDesco:=ALLTRIM(_cDesco)+" + "+ALLTRIM(str(_cDesco7,6,2))+"+ % "
   EndIf
   IF !empty(_cAcres)
      _cDesco:=ALLTRIM(_cDesco)+" + "+ALLTRIM(str(_cAcres,6,2))+" % AC "
   EndIf
   _cNCond:=Alltrim(_cNCond)+" / "+alltrim(_cDESCO)
Return(_Return)
/***********************************************************************/
Static Function _GRAVA()
Dbselectarea("TP2")
DbgotoP()
While !EOF()
      _Fliq()
      Reclock("TP2",.F.)
      TP2->TP_Desco1:=_cDesco1
      TP2->TP_Desco2:=_cDesco2
      TP2->TP_Desco3:=_cDesco3
      TP2->TP_Desco4:=_cDesco4
      TP2->TP_Desco5:=_cDesco5
      TP2->TP_Desco6:=_cDesco6
      TP2->TP_Desco7:=_cDesco7
      TP2->TP_Acres :=_cAcres
      TP2->TP_AcresC:=_cAcresC
      TP2->TP_Cond  := _cCOND
      TP2->TP_CONDH :=_cnCOND
      TP2->TP_PRCLQ :=_CPrclq
      mSunlock()
      Dbselectarea("TP2")
      Dbskip()
End-While
Close(_odlg5)
DbSelectArea("TP2")
DbGoTo(_Registro)
Execblock("ECOMA05C",.F.,.F.)
Return
/************************************************************************/
Static Function _Fliq()
_Val:=0
_cPrclq:=TP2->TP_CUSTO
IF !empty(_cIpi)
   _Val:=(_cPrclq * _cIPI) / 100
   _cPrclq:=_cPrclq - _Val
Endif
IF !Empty(_cAcres)
   IF _cAcresc == 0
      _Val:=(_cPrclq * _cAcres) / 100
      _cPrclq:=_cPrclq + _Val
   Endif
Endif
IF !empty(_cDesco1)
   _Val:=(_cPrclq * _cDesco1) / 100
   _cPrclq:=_cPrclq - _Val
Endif
IF !empty(_cDesco2)
   _Val:=(_cPrclq * _cDesco2) / 100
   _cPrclq:=_cPrclq - _Val
Endif
IF !empty(_cDesco3)
   _Val:=(_cPrclq * _cDesco3) / 100
   _cPrclq:=_cPrclq - _Val
Endif
IF !empty(_cDesco4)
   _Val:=(_cPrclq * _cDesco4) / 100
   _cPrclq:=_cPrclq - _Val
Endif
IF !empty(_cDesco5)
   _Val:=(_cPrclq * _cDesco5) / 100
   _cPrclq:=_cPrclq - _Val
Endif
IF !empty(_cDesco6)
   _Val:=(_cPrclq * _cDesco6) / 100
   _cPrclq:=_cPrclq - _Val
Endif
IF !empty(_cDesco7)
   _Val:=(_cPrclq * _cDesco7) / 100
   _cPrclq:=_cPrclq - _Val
Endif
IF !Empty(_cAcres)
   IF _cAcresc == 1
      _Val:=(_cPrclq * _cAcres) / 100
      _cPrclq:=_cPrclq + _Val
   Endif
Endif
Return

