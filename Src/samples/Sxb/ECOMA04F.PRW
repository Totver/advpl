#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Ecoma04f()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//***********************************************************************
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//***********************************************************************

SetPrvt("AHEADER,ACOLS    ,AFILIAL,X     ,F      ,_LINHA")
SetPrvt("_X     ,_CFIL    ,_CQTD  ,_DATAE ,_CITEMP")
SetPrvt("_N     ,LCONTINUA,_ALTER ,LDISTR,_CITEMD,")


//*****************************************************************************
//±±³Programa  ³ECOMA04F  ³ Autor ³ Emerson Augusto       ³ Data ³ 22/11/99 ³±±
//±±³Descri‡…o ³ Pedido de Compras                                          ³±±
//±±³Uso       ³ Especifico para Casa das Cuecas                            ³±±
//*****************************************************************************

//Function _Filiais

aHeader:= {}
aCols  := {}

AAdd(aHeader,{"Filial"     ,"Filial"     , "@!",  2, 0, , , "C", , } )
AAdd(aHeader,{"Desc"       ,"Descricao"  , "@!", 10, 0, , , "C", , } )
AAdd(aHeader,{"OK"         ,"Ok"         , "99",  2, 0, , , "C", , } )
AAdd(aHeader,{"ENTREGA"    ,"ENTREGA"    ,""   ,  8, 0, , , "D", , } )

dbSelectArea("SX5")
dbSetOrder(1)
dbSeek(xFilial("SX5")+"AA",.T.)

While !Eof() .and. SX5->X5_TABELA == "AA"
      AAdd(aCols,{ALLTRIM(SX5->X5_CHAVE),SUBS(SX5->X5_DESCRI,1,10),"  ",CTOD("")})
      dbSkip()
End-While

For X:=len(Acols)+1 to 20
    AADD(Acols,{"  ",,"  ",,})
Next X

For X := 1 TO Len(aCOLS)
    For F := 1 TO LEN(_cFIL)
        IF aCOLS[X][1] == _CFIL[F]
           aCols[X][3] := "  "
           aCols[X][4] := Ctod(" ")
        EndIf
    Next f
Next x

@ 500,  1 TO 935,410 DIALOG _oDlg3 TITLE "Filiais para Entrega  - Data-> "+DTOC(_DATAE)
_Linha := 05
For _x := 1 to Len(aCols)
    @ _Linha, 10 SAY aCols[_x][1] SIZE 20,8
    @ _Linha, 30 SAY aCols[_x][2] SIZE 70,8
    _Linha := _Linha + 10
Next _x
@ 205, 10 SAY "Numero ->Confirma // Espaco ->Cancela // Enter ->Ignora " SIZE 200,8 
@ 005,080 GET aCols[ 1][3] Valid Empty(aCols [ 1][3]) .or. Val(aCols[ 1][3]) > 0 SIZE 10,8                           picture "99"
@ 015,080 GET aCols[ 2][3] Valid Empty(aCols [ 2][3]) .or. Val(aCols[ 2][3]) > 0 SIZE 10,8                           picture "99"
@ 025,080 GET aCols[ 3][3] Valid Empty(aCols [ 3][3]) .or. Val(aCols[ 3][3]) > 0 SIZE 10,8                           picture "99"
@ 035,080 GET aCols[ 4][3] Valid Empty(aCols [ 4][3]) .or. Val(aCols[ 4][3]) > 0 SIZE 10,8                           picture "99"
@ 045,080 GET aCols[ 5][3] Valid Empty(aCols [ 5][3]) .or. Val(aCols[ 5][3]) > 0 SIZE 10,8                           picture "99"
@ 055,080 GET aCols[ 6][3] Valid Empty(aCols [ 6][3]) .or. Val(aCols[ 6][3]) > 0 SIZE 10,8                           picture "99"
@ 065,080 GET aCols[ 7][3] Valid Empty(aCols [ 7][3]) .or. Val(aCols[ 7][3]) > 0 SIZE 10,8                           picture "99"
@ 075,080 GET aCols[ 8][3] Valid Empty(aCols [ 8][3]) .or. Val(aCols[ 8][3]) > 0 SIZE 10,8                           picture "99"
@ 085,080 GET aCols[ 9][3] Valid Empty(aCols [ 9][3]) .or. Val(aCols[ 9][3]) > 0 SIZE 10,8                           picture "99"
@ 095,080 GET aCols[10][3] Valid Empty(aCols [10][3]) .or. Val(aCols[10][3]) > 0 SIZE 10,8                           picture "99"
@ 105,080 GET aCols[11][3] Valid Empty(aCols [11][3]) .or. Val(aCols[11][3]) > 0 SIZE 10,8                           picture "99"
@ 115,080 GET aCols[12][3] Valid Empty(aCols [12][3]) .or. Val(aCols[12][3]) > 0 SIZE 10,8                           picture "99"
@ 125,080 GET aCols[13][3] Valid Empty(aCols [13][3]) .or. Val(aCols[13][3]) > 0 SIZE 10,8                           picture "99"
@ 135,080 GET aCols[14][3] Valid Empty(aCols [14][3]) .or. Val(aCols[14][3]) > 0 SIZE 10,8                           picture "99"
@ 145,080 GET aCols[15][3] Valid Empty(aCols [15][3]) .or. Val(aCols[15][3]) > 0 SIZE 10,8 picture "99" WHEN !EMPTY(aCols[15][1])
@ 155,080 GET aCols[16][3] Valid Empty(aCols [16][3]) .or. Val(aCols[16][3]) > 0 SIZE 10,8 picture "99" WHEN !EMPTY(aCols[16][1])
@ 165,080 GET aCols[17][3] Valid Empty(aCols [17][3]) .or. Val(aCols[17][3]) > 0 SIZE 10,8 picture "99" WHEN !EMPTY(aCols[17][1])
@ 175,080 GET aCols[18][3] Valid Empty(aCols [18][3]) .or. Val(aCols[18][3]) > 0 SIZE 10,8 picture "99" WHEN !EMPTY(aCols[18][1])
@ 185,080 GET aCols[19][3] Valid Empty(aCols [19][3]) .or. Val(aCols[19][3]) > 0 SIZE 10,8 picture "99" WHEN !EMPTY(aCols[19][1])
@ 195,080 GET aCols[20][3] Valid Empty(aCols [20][3]) .or. Val(aCols[20][3]) > 0 SIZE 10,8 picture "99" WHEN !EMPTY(aCols[20][1])
@ 005,100 GET aCols[ 1][4] SIZE 30,8 WHEN !EMPTY(aCols[ 1][3])
@ 015,100 GET aCols[ 2][4] SIZE 30,8 WHEN !EMPTY(aCols[ 2][3])
@ 025,100 GET aCols[ 3][4] SIZE 30,8 WHEN !EMPTY(aCols[ 3][3])
@ 035,100 GET aCols[ 4][4] SIZE 30,8 WHEN !EMPTY(aCols[ 4][3])
@ 045,100 GET aCols[ 5][4] SIZE 30,8 WHEN !EMPTY(aCols[ 5][3])
@ 055,100 GET aCols[ 6][4] SIZE 30,8 WHEN !EMPTY(aCols[ 6][3])
@ 065,100 GET aCols[ 7][4] SIZE 30,8 WHEN !EMPTY(aCols[ 7][3])
@ 075,100 GET aCols[ 8][4] SIZE 30,8 WHEN !EMPTY(aCols[ 8][3])
@ 085,100 GET aCols[ 9][4] SIZE 30,8 WHEN !EMPTY(aCols[ 9][3])
@ 095,100 GET aCols[10][4] SIZE 30,8 WHEN !EMPTY(aCols[10][3])
@ 105,100 GET aCols[11][4] SIZE 30,8 WHEN !EMPTY(aCols[11][3])
@ 115,100 GET aCols[12][4] SIZE 30,8 WHEN !EMPTY(aCols[12][3])
@ 125,100 GET aCols[13][4] SIZE 30,8 WHEN !EMPTY(aCols[13][3])
@ 135,100 GET aCols[14][4] SIZE 30,8 WHEN !EMPTY(aCols[14][3])
@ 145,100 GET aCols[15][4] SIZE 30,8 WHEN !EMPTY(aCols[15][3])
@ 155,100 GET aCols[16][4] SIZE 30,8 WHEN !EMPTY(aCols[16][3])
@ 165,100 GET aCols[17][4] SIZE 30,8 WHEN !EMPTY(aCols[17][3])
@ 175,100 GET aCols[18][4] SIZE 30,8 WHEN !EMPTY(aCols[18][3])
@ 185,100 GET aCols[19][4] SIZE 30,8 WHEN !EMPTY(aCols[19][3])
@ 195,100 GET aCols[20][4] SIZE 30,8 WHEN !EMPTY(aCols[20][3])
@ 70,132 BMPBUTTON TYPE 1  ACTION _GRAVA()
@ 95,132 BMPBUTTON TYPE 2  ACTION _FECHA()
ACTIVATE DIALOG _oDlg3 CENTERED
Return
/************************************************************************/
Static Function _Grava()
F    :=0
X    :=0
_cFiL:={}
_cQtd:={}
_cENT:={}
For F := 1 to len(aCOLS)
    IF !Empty(aCols[F][3])
       Aadd(_cfIL,aCols[F][1])
       Aadd(_cQtd,aCols[F][3])
       IF !Empty(aCols[F][4])
          Aadd(_cENT,aCols[F][4])
          _DATAE:=aCols[F][4]
       Else
          Aadd(_cENT,_DATAE)
       EndIf
    EndIf
Next F
IF LEN(_cFIL) < 1
   Alert("Nao Existem Filias INFORMADAS para entrega deste Item")
   Return
Endif
IF Empty(_dataE)
   Alert("INFORME UMA DATA PARA ENTREGA")
   Return
Endif
IF _dataE < dDatabase
   Alert("DATA MENOR QUE DATABASE")
   Return
Endif
FOR X:= LEN(_cFIL) TO 20
    AADD(_cfIL," ")
    aadd(_cQtd,"  ")
    AADD(_cENT,Ctod(""))
Next X

IF _aLTER == .F.
   _cITEMP:=0
   Dbselectarea("SZ4")
   Dbsetorder(1)
   Dbseek(xFILIAL("SZ4")+cPedido+"01")
   IF !Eof()
      While cPEDIDO == SZ4->Z4_PEDIDO .and. !Eof()
            _cITEMP:=VAL(SZ4->Z4_ITEMP)
            Dbskip()
      End-While
   EndIf
   _cITEMP:=_cITEMP + 1
Endif

Dbselectarea("TP1")
dbgotop()
While !EOF() 
      DbSelectArea("SA2")
      DbSetOrder(1)
      DbSeek(xFilial("SA2")+cFornece+cLoja)
      IF _aLTER == .T.
         Dbselectarea("SZ4")
         Dbsetorder(1)
         Dbseek(xFILIAL("SZ4")+cPedido+STRZERO(_cITEMP,2)+STRZERO(_cITEMD,2))
         Reclock("SZ4",.F.)
      Else
         Dbselectarea("SZ4")
         Reclock("SZ4",.T.)
      Endif
      SZ4->Z4_Fornece  := cFornece
      SZ4->Z4_LOJA     := cloja
      SZ4->Z4_NOMFOR   := SA2->A2_NREDUZ
      SZ4->Z4_Pedido   := cPedido
      SZ4->Z4_ITEMP    := Strzero(_cItemP,2)
      SZ4->Z4_COR      := TP1->TP_COR
      SZ4->Z4_ITEMD    := TP1->TP_ITEM
      SZ4->Z4_REF      := TP1->TP_REFER
      SZ4->Z4_SEQ      := TP1->TP_SEQ
      SZ4->Z4_DESC     := TP1->TP_DESC
      SZ4->Z4_CGRD     := TP1->TP_Grd
      SZ4->Z4_PRCCST   := TP1->TP_CUSTO
      SZ4->Z4_IPI      := TP1->TP_IPI
      SZ4->Z4_ICMS     := TP1->TP_ICMS
      SZ4->Z4_DESCO1   := TP1->TP_Desco1
      SZ4->Z4_DESCO2   := TP1->TP_Desco2
      SZ4->Z4_DESCO3   := TP1->TP_Desco3
      SZ4->Z4_DESCO4   := TP1->TP_Desco4
      SZ4->Z4_DESCO5   := TP1->TP_Desco5
      SZ4->Z4_DESCO6   := TP1->TP_Desco6
      SZ4->Z4_DESCO7   := TP1->TP_Desco7
      SZ4->Z4_ACRFIN   := TP1->TP_Acres
      SZ4->Z4_ACRFINC  := TP1->TP_AcresC
      SZ4->Z4_PRCLIQ   := TP1->TP_PrcLq
      SZ4->Z4_PRCVEN   := TP1->TP_Prcve
      SZ4->Z4_MARGEM   := TP1->TP_Marge
      For _n := 1 to 13
          SZ4->(FieldPut(FieldPos("Z4_IGRD"+StrZero(_n,2)),TP1->(FieldGet(FieldPos("TP_GRADE"+StrZero(_n,Iif(_n<10,1,2)))))))
          SZ4->(FieldPut(FieldPos("Z4_QGRD"+StrZero(_n,2)),TP1->(FieldGet(FieldPos("TP_QUANT"+StrZero(_n,Iif(_n<10,1,2)))))))
      Next _n
      SZ4->Z4_QGRTOT   := TP1->TP_Tot
      SZ4->Z4_DBENEF   := _cBENEF
      SZ4->Z4_CBENEF   := _nRadio
      For _n := 1 to Len(_cFil)
          SZ4->(FieldPut(FieldPos("Z4_FIL"+StrZero(_n,2)),_cFil[_n]))
          SZ4->(FieldPut(FieldPos("Z4_RPT"+StrZero(_n,2)),_cQtd[_n]))
          SZ4->(FieldPut(FieldPos("Z4_ENT"+StrZero(_n,2)),_cEnt[_n]))
      Next _n
      Msunlock()
      Dbselectarea("TP1")
      DbskiP()
End-While
_Fecha()
Return
/**********************************************************************/
Static Function _Fecha()

IF _Alter == .T.
   Dbselectarea("TP1")
   If LastRec() > 0
      DbGoTop()
      While !Eof()
            RecLock("TP1",.F.)
            DbDelete()
            MsUnLock()
            DbSkip()
      End-While
   Endif
   lcontinua:=.F.
   _Alter:=.F.
Endif
lDistr  := .T.
_cItemD := _cItemD - 1
close(_oDlG3)
cLose(_Odlg2)
Return

