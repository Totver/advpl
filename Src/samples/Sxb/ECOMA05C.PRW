#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Ecoma05c()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("ARADIO,_CBENEF1,A,_CSEQ,_CPRODUTO,_CCOR")
SetPrvt("_CREFER,_CCUSTO,_CPRCLQ,_CIPI,_CDESCO1,_CDESCO2")
SetPrvt("_CDESCO3,_CDESCO4,_CDESCO5,_CDESCO6,_CDESCO7,_CACRES")
SetPrvt("_CACRESC,_CPRCVE1,_CPRCVE2,_CBENEF,_NRADIO,_CMARGE")
SetPrvt("PL,Z,K,_VAL,_DBENEF,Y")
SetPrvt("PV,_OBS")

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±³Programa  ³ECOMA05C  ³ Autor ³ Emerson Augusto       ³ Data ³ 09/12/99 ³±±
±±³Descri‡…o ³ Pedido de Compras - Alteracao De Custo/Venda               ³±±
±±³Uso       ³ Especifico para Casa das Cuecas                            ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Close(odlg6)
aRADIO:= {}
_cBenef1 :=""
A        :=""
dbSelectArea("SZ8")
dbSetOrder(1)
dbSeek(xFilial("SZ8")+"XX")

A:="CURVA A"+" - "+ALLTRIM(STR(SZ8->Z8_MARGEMA))+" %"
AAdd(aRADIO,A)
A:="CURVA B"+" - "+ALLTRIM(STR(SZ8->Z8_MARGEMB))+" %"
AAdd(aRADIO,A)
A:="CURVA C"+" - "+ALLTRIM(STR(SZ8->Z8_MARGEMC))+" %"
AAdd(aRADIO,A)

Dbselectarea("TP2")
_cSeQ	   :=TP2->TP_SEQ
_cProduto  :=TP2->TP_SEQ+"-"+TP2->TP_DESC
_cCor	   :=TP2->TP_DCOR
_cRefer    :=TP2->TP_Refer
_cCusto    :=TP2->TP_Custo
_cPrclq    :=TP2->TP_Prclq
_cIpi	   :=TP2->TP_IPI
_cDesco1   :=TP2->TP_Desco1
_cDesco2   :=TP2->TP_Desco2
_cDesco3   :=TP2->TP_Desco3
_cDesco4   :=TP2->TP_Desco4
_cDesco5   :=TP2->TP_Desco5
_cDesco6   :=TP2->TP_Desco6
_cDesco7   :=TP2->TP_Desco7
_cAcres    :=TP2->TP_Acres
_cAcresC   :=TP2->TP_AcresC
_cPrcVe1   :=TP2->TP_Prcve
_cPrcVe2   :=TP2->TP_Prcve
_cPrclq    :=TP2->TP_Prclq
_cBenef    :=TP2->TP_Benef
_NRadio    :=TP2->TP_cBenef
_cBenef1   :=space(1)
_cMarge    :=TP2->TP_MARGE  
_Obs       :=TP2->TP_OBS
PL         :=_cPrclq
Z          :=_cBenef

@ 030,005 To  300,600 Dialog _Odlg5 Title OemToAnsi("Alteracao Preco de Custo - ECOMA05C  -  Pedido Numero -> " +_Cnumped)
@ 010,010 Say OemToAnsi("Produto")      Size 75,10
@ 010,065 Say _cProduto SIZE 200,10
@ 023,010 Say OemToAnsi("Referencia") Size 75,10
@ 023,065 Say _cRefer	SIZE 150,10
@ 035,010 Say OemToAnsi("Cor") Size 45,10
@ 035,065 Say _cCor 	SIZE 100,10
@ 055,010 Say OemToAnsi("Custo") Size 45,8
@ 055,065 GET _cCusto   Picture "@E 999,999.99"	SIZE 40,8  Valid _FLIQ()
@ 055,110 Say TP2->TP_CONDH  Size 145,8
@ 075,010 Say OemToAnsi("Prc.Liquido") Size 45,8
@ 075,065 Say _cPrclq	SIZE 40,8
@ 075,200 Say OemToAnsi("Margem %") Size 75,8
@ 095,010 Say OemToAnsi("Prc Venda") Size 75,8
@ 075,110 Get _cBenef1 Picture "@!" Size 005,003 VALID _Benefe()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 075,110 Get _cBenef1 Picture "@!" Size 005,003 VALID EXECUTE(_Benefe)
@ 095,060 Get _cPrcVe1 Picture "@E 99,999.99" Size 040,008 Valid _Margem()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 095,060 Get _cPrcVe1 Picture "@E 99,999.99" Size 040,008 Valid Execute(_Margem)
@ 095,120 Get _cPrcVe2 Picture "@E 99,999.99" Size 040,008 Valid _cPrcve2 == _cPrcve1
@ 095,210 Say _cMarge Picture "@E 999.99" Size 040,008
@ 110,65  Bmpbutton Type 1 action _GRAVA()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 110,65  Bmpbutton Type 1 action Execute(_GRAVA)
@ 110,130  Bmpbutton Type 2 action cLOSE(_oDLG5)
Activate Dialog _oDlg5

Return(nil)        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

/**********************************************************************/
Static Function _GRAVA()
Dbselectarea("TP2")
DbgotoP()
While !EOF()
      IF _cSeq     == TP2->TP_SEQ  .AND.;  
         _cCor	   == TP2->TP_DCOR .AND.;
         _cRefer   == TP2->TP_Refer

         Reclock("TP2",.F.)
         TP2->TP_Custo:= _cCusto
         TP2->TP_Prclq:= _cPrclq
         TP2->TP_MARGE := 0
         MsUnLock()
      EndIf
      PL := TP2->TP_PRCLQ
      k  := 1
      IF _cSeq == TP2->TP_SEQ
	 SET DECIMALS TO 8
         _cMarge := SZ8->Z8_CONSTA3 - (100 * PL) / (K * _cPrcve1)
	 SET DECIMALS TO 2
         _cMarge := Round(_cMARGE,2)
         Reclock("TP2",.F.)
//         Alert(StrZero(_cMarge,10,2))
         TP2->TP_PRCVE :=_cPrcVe1
         TP2->TP_CBENEF:=_NRadio
         TP2->TP_BENEF :=_cBenef
         TP2->TP_MARGE := 0
         MsUnLock()
      Endif
      Dbselectarea("TP2")
      Dbskip()
End-While
Close(_odlg5)
Return
/************************************************************************/
Static Function _Fliq()
_Val   := 0
If _cCUSTO > 0
   _cPrclq:=_cCusto
   IF !Empty(_cIpi)
      _Val   :=(_cCusto * _cIPI) / 100
      _cPrclq:=_cCUSTO + _Val
   Endif
   IF !Empty(_cAcres)
      IF _cAcresc == 0
         _Val   :=(_cCusto * _cAcres) / 100
         _cPrclq:=_cCUSTO + _Val
      Endif
   Endif
   IF !empty(_cDesco1)
      _Val   :=(_cPrclq * _cDesco1) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
   IF !empty(_cDesco2)
      _Val   :=(_cPrclq * _cDesco2) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
   IF !empty(_cDesco3)
      _Val   :=(_cPrclq * _cDesco3) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
   IF !empty(_cDesco4)
      _Val   :=(_cPrclq * _cDesco4) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
   IF !empty(_cDesco5)
      _Val   :=(_cPrclq * _cDesco5) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
   IF !empty(_cDesco6)
      _Val   :=(_cPrclq * _cDesco6) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
   IF !empty(_cDesco7)
      _Val   :=(_cPrclq * _cDesco7) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
//   IF !empty(_cIcms)
//      _Val   :=(_cPrclq * _cIcms) / 100
//      _cPrclq:=_cPrclq - _Val
//   Endif
   IF !Empty(_cAcres)
      IF _cAcresc == 1
         _Val:=(_cPrclq * _cAcres) / 100
         _cPrclq:=_cPrclq + _Val
      Endif
   Endif
   _fPrcve()
Endif
Return()

/**********************************************************************
Static Function _Fliq()
_Val    := 0
_cPrclq := _cCUSTO
IF !empty(_cIpi)
   _Val    := (_cPrclq * _cIPI) / 100
   _cPrclq := _cPrclq - _Val
Endif
IF !Empty(_cAcres)
   IF _cAcresc == 0
      _Val    := (_cCusto * _cAcres) / 100
      _cPrclq := _cCUSTO + _Val
   Endif
Endif
IF !empty(_cDesco1)
   _Val     := (_cPrclq * _cDesco1) / 100
   _cPrclq  := _cPrclq - _Val
Endif
IF !empty(_cDesco2)
   _Val     := (_cPrclq * _cDesco2) / 100
   _cPrclq  := _cPrclq - _Val
Endif
IF !empty(_cDesco3)
   _Val     := (_cPrclq * _cDesco3) / 100
   _cPrclq  := _cPrclq - _Val
Endif
IF !empty(_cDesco4)
   _Val     := (_cPrclq * _cDesco4) / 100
   _cPrclq  := _cPrclq - _Val
Endif
IF !empty(_cDesco5)
   _Val     := (_cPrclq * _cDesco5) / 100
   _cPrclq  := _cPrclq - _Val
Endif
IF !empty(_cDesco6)
   _Val     := (_cPrclq * _cDesco6) / 100
   _cPrclq  := _cPrclq - _Val
Endif
IF !empty(_cDesco7)
   _Val     := (_cPrclq * _cDesco7) / 100
   _cPrclq  := _cPrclq - _Val
Endif
IF !Empty(_cAcres)
   IF _cAcresc == 1
      _Val    := (_cPrclq * _cAcres) / 100
      _cPrclq := _cPrclq + _Val
   Endif
Endif
Return
***********************************************************************/
Return

Static Function _Benefe()
_Dbenef:=.T.
@ 160,185 To 280,406 Dialog benef Title OemToAnsi("Beneficio")
@ 5,7 Say OemToAnsi("Beneficio.:") Size 34,10
@ 6,47 Get _cBenef Size 43,10 Picture "@E 999.99"
@ 23,9 Radio aRADIO Var _nRADIO
@ 46,77 Bmpbutton Type 1 action _fPrcve()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 46,77 Bmpbutton Type 1 action Execute(_fPrcve)
Activate Dialog benef
Return
/************************************************************************/
Static Function _fPrcve()
IF _dBENEF == .T.
   close(benef)
   _dBenef := .f.
Endif

Dbselectarea("SZ8")
Dbsetorder(1)
Dbseek(xFILIAL("SZ8")+"XX")

PL:= _cPrclq
Z := Iif(_cBenef==0,0,_cBenef)
Y := SZ8->Z8_MARGEMA / 100               

Do case
Case _nRadio == 2
     Y:=SZ8->Z8_MARGEMB / 100
Case _nRadio == 3
     Y:=SZ8->Z8_MARGEMC / 100
End Case

//SET DECIMALS TO 8
//K       :=(1 + (SZ8->Z8_INFL/100)) * SZ8->Z8_CONSTA2   
//If Z > 0 
//   K       :=(K * Z)
//EndIf   
//PV      :=(PL / K)                        
//PV      := PV / (1 - (Y + SZ8->Z8_CONSTA1))

Pv := Pl * (1 + y )
SET DECIMALS TO 2
PV      :=Round(PV,2)
_cPrcve2:=PV
_cPrcve1:=PV
_Margem()
Dbselectarea("SZ4")

Return
/************************************************************************
Static Function _fPrcve()
IF _dBENEF == .T.
   close(benef)
Endif
Dbselectarea("SZ8")
Dbsetorder(1)
Dbseek(xFILIAL("SZ8")+"XX")
PL := _cPrclq
Z  := _cBenef
Y  := SZ8->Z8_MARGEMA / 100
Do case
Case _nRadio == 2
     Y := SZ8->Z8_MARGEMB / 100
Case _nRadio == 3
     Y := SZ8->Z8_MARGEMC / 100
End Case
SET DECIMALS TO 6
K  := (1 + (SZ8->Z8_INFL/100)) ** SZ8->Z8_CONSTA2
K  := (K ** Z)
PV := (PL / K)
PV := PV / (1 - (Y + SZ8->Z8_CONSTA1))
SET DECIMALS TO 2
PV :=Round(PV,2)
_cPrcve2 := PV
_cPrcve1 := PV - INT(PV)
IF _cPrcve1 > 0.50
   _cPrcve1 := INT(PV) + 0.99
Else
   _cPrcve1 :=(INT(PV) - 1) + 0.99
EndIf
_Margem()
Dbselectarea("TP2")

Return

***********************************************************************
Static Function _Margem()
SET DECIMALS TO 6
_cMarge := SZ8->Z8_CONSTA3 - (100 * PL) / (K * _cPrcve1)
SET DECIMALS TO 2
_cMarge := Round(_cMARGE,2)
Return

*****************************************************************/
Static Function _Margem()
PV      :=_cPrcve1
SET DECIMALS TO 8
//_cMarge:=SZ8->Z8_CONSTA3 - (100 * PL) / (K * _cPrcve1)
_cMarge :=(PL / PV) * 100
SET DECIMALS TO 2
_cMarge :=Round(_cMARGE,2)
Return
