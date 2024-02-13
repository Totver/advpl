#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Ecoma05v()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("ARADIO,_CBENEF1,A,CSEQC,CFILC,FILC")
SetPrvt("_CSEQ,_CPRODUTO,_CCOR,_CREFER,_CPRCVE1,_CPRCVE2")
SetPrvt("_CCUSTO,_CPRCLQ,_CBENEF,_NRADIO,_CMARGE,PL")
SetPrvt("_DBENEF,Z,Y,K,PV,")

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ECOMA05V  ³       ³ Emerson Augusto       ³ Data ³ 12/12/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pedido de Compras - Alteracao De Preco DE Venda            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Casa das Cuecas                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
aRADIO   := {}
_cBenef1 := ""
A        := ""
dbSelectArea("SZ8")
dbSetOrder(1)
dbSeek(xFilial("SZ8")+"XX")

A:="CURVA A"+" - "+ALLTRIM(STR(SZ8->Z8_MARGEMA))+" %"
AAdd(aRADIO,A)
A:="CURVA B"+" - "+ALLTRIM(STR(SZ8->Z8_MARGEMB))+" %"
AAdd(aRADIO,A)
A:="CURVA C"+" - "+ALLTRIM(STR(SZ8->Z8_MARGEMC))+" %"
AAdd(aRADIO,A)
Cseqc:={}
CFilc:={}

Dbselectarea("TP2")
Dbgotop()
While !EOF()
      If Ascan(cSeqc,TP2->TP_SEQ)==0
         AADD(cFILc,TP2->TP_FILIAL)
         AADD(cSEQc,TP2->TP_SEQ)
      Endif
      Dbselectarea("TP2")
      Dbskip()
End-While
FILC:=0

For FILC:= 1 TO LEN(cSEQc)
    Dbselectarea("TP2")
    Dbseek(cFilc[FILC]+cSEQC[FILC],.T.)
    _cSeq      :=TP2->TP_SEQ
    _cProduto  :=TP2->TP_SEQ+"-"+TP2->TP_DESC
    _cCor      :=TP2->TP_DCOR
    _cRefer    :=TP2->TP_Refer
    _cPrcVe1   :=TP2->TP_Prcve
    _cPrcVe2   :=TP2->TP_Prcve
    _cCusto    :=TP2->TP_Custo
    _cPrclq    :=TP2->TP_Prclq
    _cBenef    :=TP2->TP_Benef
    _NRadio    :=TP2->TP_cBenef
    _cBenef1   :=space(1)
    _cMarge    :=TP2->TP_MARGE
  
    @ 030,005 To  280,600 Dialog _Odlg5 Title OemToAnsi("Alteracao Preco de VENDA - ECOMA05V  -  Pedido Numero -> " +_Cnumped)
    @ 010,010 Say OemToAnsi("Produto")      Size 75,8
    @ 010,065 Say _cProduto SIZE 200,8
    @ 022,010 Say OemToAnsi("Referencia") Size 75,8
    @ 022,065 Say _cRefer   SIZE 150,8
    @ 033,010 Say OemToAnsi("Cor") Size 45,8
    @ 033,065 Say _cCor     SIZE 100,8
    @ 045,010 Say OemToAnsi("Prc.Custo") Size 45,10
    @ 045,065 Say _cCusto   SIZE 40,10
    @ 045,110 Say TP2->TP_CONDH  Size 200,10
    @ 060,010 Say OemToAnsi("Prc.Liquido") Size 45,10
    @ 060,065 Say _cPrclq   SIZE 40,10
    @ 060,200 Say OemToAnsi("Margem %") Size 75,10
    @ 075,010 Say OemToAnsi("Prc Venda") Size 75,8
    @ 060,110 Get _cBenef1 Picture "@!" Size 005,003 VALID _Benefe()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>     @ 060,110 Get _cBenef1 Picture "@!" Size 005,003 VALID EXECUTE(_Benefe)
    @ 075,060 Get _cPrcVe1 Picture "@E 99,999.99" Size 040,008 Valid _Margem()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>     @ 075,060 Get _cPrcVe1 Picture "@E 99,999.99" Size 040,008 Valid Execute(_Margem)
    @ 075,120 Get _cPrcVe2 Picture "@E 99,999.99" Size 040,008 Valid _cPrcve2 == _cPrcve1
    @ 075,210 Say _cMarge Picture "@E 9999.99" Size 040,008
    @ 090,065 Bmpbutton Type 1 action _GRAVA()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>     @ 090,065 Bmpbutton Type 1 action Execute(_GRAVA)
    Activate Dialog _oDlg5
Next Filc
Return
/***********************************************************************/
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _GRAVA
Static Function _GRAVA()

   Dbselectarea("TP2")
   Dbgotop()
   While !Eof()
         IF _cSeq == TP2->TP_SEQ

            PL:=TP2->TP_PRCLQ
            SET DECIMALS TO 8
            _cMarge:=SZ8->Z8_CONSTA3 - (100 * PL) / (K * _cPrcve1)
            SET DECIMALS TO 2
            _cMarge:=Round(_cMARGE,2)
            Reclock("TP2",.F.)
            TP2->TP_PRCVE  := _cPrcVe1
            TP2->TP_CBENEF := _NRadio
            TP2->TP_BENEF  := _cBenef
            TP2->TP_MARGE  := 0
//            TP2->TP_MARGE  := _cMarge
            mSunlock()
         Endif
         Dbselectarea("TP2")
         Dbskip()
   End-While
   Close(_odlg5)
Return
/************************************************************************/
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _Benefe
Static Function _Benefe()
_Dbenef:=.T.
@ 160,185 To 280,406 Dialog benef Title OemToAnsi("Beneficio")
@   5,  7 Say OemToAnsi("Beneficio.:") Size 34,10
@   6, 47 Get _cBenef Size 43,10 Picture "@E 999.99"
@  23,  9 Radio aRADIO Var _nRADIO
@  46, 77 Bmpbutton Type 1 action _fPrcve()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @  46, 77 Bmpbutton Type 1 action Execute(_fPrcve)
Activate Dialog benef
Return
/*************************************************************************/
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _fPrcve
Static Function _fPrcve()
IF _dBENEF == .T.
   close(benef)
Endif
Dbselectarea("SZ8")
Dbsetorder(1)
Dbseek(xFILIAL("SZ8")+"XX")
PL:=_cPrclq
Z := _cBenef
Y :=SZ8->Z8_MARGEMA / 100

Do case
Case _nRadio == 2
     Y:=SZ8->Z8_MARGEMB / 100
Case _nRadio == 3
     Y:=SZ8->Z8_MARGEMC / 100
End Case

SET DECIMALS TO 6
K :=(1 + (SZ8->Z8_INFL/100)) ** SZ8->Z8_CONSTA2
K :=(K ** Z)
PV:=(PL / K)
PV:= PV / (1 - (Y + SZ8->Z8_CONSTA1))
SET DECIMALS TO 2
PV:=Round(PV,2)
_cPrcve2:=PV
_cPrcve1:=PV - INT(PV)
IF _cPrcve1 > 0.50
   _cPrcve1 := INT(PV) + 0.99
Else
   _cPrcve1 :=(INT(PV) - 1) + 0.99
Endif
_Margem()
Dbselectarea("TP2")
Return
/************************************************************************/
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _Margem
Static Function _Margem()

SET DECIMALS TO 6
_cMarge:=SZ8->Z8_CONSTA3 - (100 * PL) / (K * _cPrcve1)
SET DECIMALS TO 2
_cMarge:=Round(_cMARGE,2)
Return

