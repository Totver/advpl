#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Ecoma05q()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CGRADE,_CQUANT,CSGRD,C,A,B")
SetPrvt("_CFILIAL,_CPRODUTO,_CCOR,_CREFER,_CTOT,NCOL")

//±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
//±±³Programa  ³ECOMA05Q  ³ Autor ³ Emerson Augusto       ³ Data ³ 08/12/99 ³±±
//±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
//±±³Descri‡…o ³ Pedido de Compras - Alteracao De Quantidade                ³±±
//±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
//±±³Uso       ³ Especifico para Casa das Cuecas                            ³±±
//±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±

Close(odlg6)
_cTitul:={}
_cGRADE:={}
_cQuant:={}

Dbselectarea("TP2")

Dbselectarea("SZ2")
Dbsetorder(1)
Dbseek(xFILIAL("SZ2")+TP2->TP_CGRD)
csGRD:=SZ2->Z2_GRADE
C    :=""
A    :=LEN(csgrd)
For B:= 1 TO A
    IF Subs(csgrd,B,1) $ "/ "
       IF !Empty(C)
          AAdd(_cTitul," ")
          AAdd(_cGrade,C)
          AAdd(_cQuant,0)
          C:=""
       EndIf
    Else
       C:=C+Subs(csgrd,B,1)
    EndIf
Next B
A:=LEN(_cGrade)
For B:= A+1 TO 13
    AAdd(_cTitul,"")
    AAdd(_cGrade,"")
    AAdd(_cQuant,0)
Next B

Dbselectarea("TP2")
_cFilial   := TP2->TP_FILIAL+"-"+TP2->TP_DFIL
_cProduto  := TP2->TP_SEQ   +"-"+TP2->TP_DESC
_cCor      := TP2->TP_DCOR
_cRefer    := TP2->TP_Refer
For _n := 1 To Len(_cGrade)
    _cGrade[_n] := TP2->(FieldGet(FieldPos("TP_Grade"+StrZero(_n,Iif(_n<10,1,2)))))
//    MsgStop(_cGrade[_n]+Str(_n,3)+"-"+Str(Len(_cGrade),3))
    DbSelectArea("SX5")
    DbSeek(xFilial("SX5")+"Z1"+_cGrade[_n])
    _cTitul[_n] := Trim(SX5->X5_DESCRI)
    _cQuant[_n] := TP2->(FieldGet(FieldPos("TP_QUANT"+StrZero(_n,Iif(_n<10,1,2)))))
Next _n    
_cTot      := TP2->TP_QGRTOT

@ 030,005 To  300,600 Dialog _Odlg5 Title OemToAnsi("Alteracao De Quantidade - ECOMA05Q  -  Pedido Numero -> " +_Cnumped)
@ 006,010 Say OemToAnsi("Filial")       Size 75,10
@ 006,065 Say _cFilial SIZE 200,10
@ 018,010 Say OemToAnsi("Produto")      Size 75,8
@ 018,065 Say _cProduto SIZE 200,8
@ 031,010 Say OemToAnsi("Referencia")   Size 75,8
@ 031,065 Say _cRefer   SIZE 150,8
@ 043,010 Say OemToAnsi("Cor")          Size 45,8
@ 043,065 Say _cCor     SIZE 100,8
@ 055,003 To 105,290 Title OemToAnsi("Itens Grade")
nCol := 15
@ 62,nCol SAY _cTitul[1]                Size 15,08
//@ 62,nCol SAY _cGrade[1]                Size 15,08
nCol := nCol + 45
@ 62,nCol SAY _cTitul[2]                Size 15,08
//@ 62,nCol SAY _cGrade[2]                Size 15,08
nCol := nCol + 40
@ 62,nCol SAY _cTitul[3] Size 15,08
//@ 62,nCol SAY _cGrade[3] Size 15,08
nCol := nCol + 40
@ 62,nCol SAY _cTitul[4] Size 15,08
//@ 62,nCol SAY _cGrade[4] Size 15,08
nCol := nCol + 40
@ 62,nCol SAY _cTitul[5] Size 15,08
//@ 62,nCol SAY _cGrade[5] Size 15,08
nCol := nCol + 40
@ 62,nCol SAY _cTitul[6] Size 15,08
//@ 62,nCol SAY _cGrade[6] Size 15,08
nCol := nCol + 40
@ 62,nCol SAY _cTitul[7] Size 15,08
//@ 62,nCol SAY _cGrade[7] Size 15,08
nCOL := 15
@ 82,nCol SAY _cTitul[8] Size 15,08
//@ 82,nCol SAY _cGrade[8] Size 15,08
nCol := nCol + 45
@ 82,nCol SAY _cTitul[9] Size 15,08
//@ 82,nCol SAY _cGrade[9] Size 15,08
nCol := nCol + 40
@ 82,nCol SAY _cTitul[10] Size 15,08
//@ 82,nCol SAY _cGrade[10] Size 15,08
nCol := nCol + 40
@ 82,nCol SAY _cTitul[11] Size 15,08
//@ 82,nCol SAY _cGrade[11] Size 15,08
nCol := nCol + 40
@ 82,nCol SAY _cTitul[12] Size 15,08
//@ 82,nCol SAY _cGrade[12] Size 15,08
nCol := nCol + 40
@ 82,nCol SAY _cTitul[13] Size 15,08
//@ 82,nCol SAY _cGrade[13] Size 15,08
nCol := nCol + 40
@ 82,nCol SAY "TOTAL" Size 30,07
IF A+1 > 1
   @ 69,011 GET _cQuant[1]   Picture "@E 9999" SIZE 23,10  VALID _Ftot()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    @ 69,011 GET _cQuant[1]  Picture "@E9999" SIZE 23,10  VALID Execute(_Ftot)
EndIf
IF A+1 > 2
   @ 69,051 GET _cQuant[2]   Picture "@E 9999" SIZE 23,10  VALID _Ftot()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    @ 69,051 GET _cQuant[2]  Picture "@E9999" SIZE 23,10  VALID Execute(_Ftot)
EndIf
IF A+1 > 3
   @ 69,091 GET _cQuant[3]   Picture "@E 9999"  SIZE 23,10  VALID _Ftot()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    @ 69,091 GET _cQuant[3]  Picture "@E9999"  SIZE 23,10  VALID Execute(_Ftot)
EndIf
IF A+1 > 4
   @ 69,131 GET _cQuant[4]   Picture "@E 9999" SIZE 23,10 VALID _Ftot()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    @ 69,131 GET _cQuant[4]  Picture "@E9999" SIZE 23,10 VALID Execute(_Ftot)
EndIf
IF A+1 > 5
   @ 69,171 GET _cQuant[5]   Picture "@E 9999" SIZE 23,10 VALID _Ftot()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    @ 69,171 GET _cQuant[5]  Picture "@E9999" SIZE 23,10 VALID Execute(_Ftot)
EndIf
IF A+1 > 6
   @ 69,211 GET _cQuant[6]   Picture "@E 9999" SIZE 23,10 VALID _Ftot()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    @ 69,211 GET _cQuant[6]  Picture "@E9999" SIZE 23,10 VALID Execute(_Ftot)
EndIf
IF A+1 > 7
   @ 69,251 GET _cQuant[7]   Picture "@E 9999" SIZE 23,10 VALID _Ftot()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    @ 69,251 GET _cQuant[7]  Picture "@E9999" SIZE 23,10 VALID Execute(_Ftot)
EndIf
IF A+1 > 8
   @ 92,011 GET _cQuant[8]   Picture "@E 9999" SIZE 23,10  VALID _Ftot()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    @ 92,011 GET _cQuant[8]  Picture "@E9999" SIZE 23,10  VALID Execute(_Ftot)
EndIf
IF A+1 > 9
   @ 92,051 GET _cQuant[9]   Picture "@E 9999" SIZE 23,10  VALID _Ftot()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    @ 92,051 GET _cQuant[9]  Picture "@E9999" SIZE 23,10  VALID Execute(_Ftot)
EndIf
IF A+1 > 10
   @ 92,091 GET _cQuant[10]  Picture "@E 9999" SIZE 23,10 VALID _Ftot()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    @ 92,091 GET _cQuant[10]      Picture "@E9999" SIZE 23,10 VALID Execute(_Ftot)
EndIf
IF A+1 > 11
   @ 92,131 GET _cQuant[11]  Picture "@E 9999" SIZE 23,10 VALID _Ftot()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    @ 92,131 GET _cQuant[11]      Picture "@E9999" SIZE 23,10 VALID Execute(_Ftot)
EndIf
IF A+1 > 12
   @ 92,171 GET _cQuant[12]  Picture "@E 9999" SIZE 23,10 VALID _Ftot()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    @ 92,171      GET _cQuant[12]  Picture "@E9999" SIZE 23,10 VALID Execute(_Ftot)
EndIf
IF A+1 > 13
   @ 92,211 GET _cQuant[13]  Picture "@E 9999" SIZE 23,10 VALID _Ftot()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    @ 92,211 GET _cQuant[13]      Picture "@E9999" SIZE 23,10 VALID Execute(_Ftot)
EndIf
@ 092,250 Get _cTot   Picture "@E 999999" Size 30,10 when .F.
@ 110,65  Bmpbutton Type 1 action _GRAVA()
@ 110,120 Bmpbutton Type 2 action cLOSE(_oDLG5)
Activate Dialog _oDlg5
Return
/************************************************************************/
Static Function _GRAVA()
IF Msgyesno("Altera Grades Para todas Filiais com Mesmo Codigo / Referencia ?","Escolha")
   Dbselectarea("TP2")
   DbgotoP()
   While !EOF()
         IF _cProduto == TP2->TP_SEQ+"-"+TP2->TP_DESC .AND.;
            _cCor     == TP2->TP_DCOR .AND.;
            _cRefer   == TP2->TP_Refer
            Reclock("TP2",.F.)
            For _i := 1 to 13
                FieldPut(FieldPos("TP_GRADE"+StrZero(_i,Iif(_i<10,1,2))),_cGrade[_i])
                FieldPut(FieldPos("TP_QUANT"+StrZero(_i,Iif(_i<10,1,2))),_cQuant[_i])
            Next _i    
            TP2->TP_QGRTOT:= _cTot
            TP2->TP_QGRFAL:= _cTot
            mSunlock()
         Endif
         Dbskip()
   End-While
Else
   Dbselectarea("TP2")
   Reclock("TP2",.F.)
   For _i := 1 to 13
       FieldPut(FieldPos("TP_GRADE"+StrZero(_i,Iif(_i<10,1,2))),_cGrade[_i])
       FieldPut(FieldPos("TP_QUANT"+StrZero(_i,Iif(_i<10,1,2))),_cQuant[_i])
   Next _i
   TP2->TP_QGRTOT:= _cTot
   mSunlock()
Endif
Close(_odlg5)
Return
/************************************************************************/
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _Ftot
Static Function _Ftot()
_cTOT:=0
For B:= 1 TO A
    _cTOT:=_cTOT + _cQuant[B]
Next B
Return

