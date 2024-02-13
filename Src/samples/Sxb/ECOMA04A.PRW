#include "rwmake.ch"        

User Function Ecoma04a()    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("ASTRU   ,CARQ    ,_TZ4    ,FIL     ,C       ,CCAMPO"  )
SetPrvt("CFIL    ,ACPOS   ,_ALTERA ,_CCUSTO ,_CIPI   ,_CDESCO1")
SetPrvt("_CDESCO2,_CDESCO3,_CDESCO4,_CDESCO5,_CDESCO6,_CDESCO7")
SetPrvt("_CACRES ,_CACRESC,_CPRCLQ ,_CPRCVE ,_CMARGE ,_CCOR"   )
SetPrvt("_CITEMP ,_CITEMD ,_SEQ    ,CGRD    ,CDESC   ,CCOD"    )
SetPrvt("_CGRADE ,_CQUANT ,_CFIL   ,_CENT   ,X       ,_CTOT"   )
SetPrvt("_CNCOR  ,CPRODUTO,CPARE   ,LRET    ,_CITEM  ,_cICMS"  )



//*****************************************************************************
//**³Fun‡„o    ³ ECOMA04A ³ Autor ³ Emerson Augusto       ³ Data ³ 24.09.99 ³**
//**³Descri‡„o ³ Pedido de Compra com grade                                 ³**
//**³Uso       ³ Exclusivo Casa das Cuecas                                  ³**
//*****************************************************************************

IF _TZ4 == .T.
   Dbselectarea("TZ4")
   Dbclosearea("TZ4")
Endif
aStru := {}
AADD(aStru,{"T4_ITEMD" ,"C", 2,0})
AADD(aStru,{"T4_ITEMP" ,"C", 2,0})
AADD(aStru,{"T4_SEQ"   ,"C", 6,0})
AADD(aStru,{"T4_REF"   ,"C",15,0})
AADD(aStru,{"T4_COR"   ,"C",10,0})
AADD(aStru,{"T4_DESC"  ,"C",30,0})
AADD(aStru,{"T4_PEDIDO","C", 8,0})
AADD(aStru,{"T4_QGRTOT","N", 6,0})
AADD(aStru,{"T4_FILD"  ,"C",80,0})

cArq := CriaTrab(aStru,.T.)
dbUseArea(.T.,,cArq,"TZ4",.T.,.F.)
IndRegua("TZ4",cArq,"T4_ITEMP+T4_ITEMD",,,"Selecionando Registros...")
_TZ4 := .T.

dbSelectArea("SZ4")
dbSetOrder(1)
dbSeek(xFilial("SZ4")+cPedido,.T.)
IF !EOF()

   While !Eof() .And. SUBS(SZ4->Z4_PEDIDO,1,8)==cPedido

         Dbselectarea("SZ3")
         Dbsetorder(1)
         Dbseek(Xfilial("SZ3")+SZ4->Z4_COR)

         Reclock("TZ4",.T.)
         TZ4->T4_ITEMP :=SZ4->Z4_ITEMP
         TZ4->T4_ITEMD :=SZ4->Z4_ITEMD
         TZ4->T4_REF   :=SZ4->Z4_REF
         TZ4->T4_SEQ   :=SZ4->Z4_SEQ
         TZ4->T4_COR   :=SUBS(SZ3->Z3_DESC,1,10)
         TZ4->T4_DESC  :=SZ4->Z4_DESC
         TZ4->T4_QGRTOT:=SZ4->Z4_QGRTOT
         TZ4->T4_QGRTOT:=SZ4->Z4_QGRTOT
         Fil:=""
         For C := 1 to 20
             cCampo:="Z4_FIL"+Strzero(C,2)
             IF !Empty(SZ4->(FieldGet(FieldPos(cCampo))))
                cFil:=SZ4->(FieldGet(FieldPos(cCampo)))+SPACE(4)
                Dbselectarea("SX5")
                dbsetorder(1)
                Dbseek(xFILIAL("SX5")+"AA"+cFil)
                FIL:=FIL+ALLTRIM(SX5->X5_DESCRI)+" / "
             Endif
         Next C
         TZ4->T4_FILD  :=FIL
         Msunlock()
         Dbselectarea("SZ4")
         Dbskip()
   End-While
Else
   Alert("Nao existem itens ja Distribuidos para Alteracao")
   Dbselectarea("TZ4")
   Dbclosearea("TZ4")
   _TZ4:=.F.
   mSunlock()
   Close(oDlgalt)
   Return
Endif

dbSelectArea("TZ4")
dbGotop()
   
aCpos:={}
AADD(aCpos,{ "T4_ITEMP"  ,"Item Ped"                         })
AADD(aCpos,{ "T4_ITEMD"  ,"Item Distr"                       })
AADD(aCpos,{ "T4_SEQ"    ,"Codigo"                           })
AADD(aCpos,{ "T4_REF"    ,"Ref"                              })
AADD(aCpos,{ "T4_COR"    ,"Seq"                              })
AADD(aCpos,{ "T4_DESC"   ,"Descricao"                        })
AADD(aCpos,{ "T4_QGRTOT" ,"Total Pedido"                     })
AADD(aCpos,{ "T4_FILD"   ,"Filias Selecionadas para Entrega" })

@ 130,030 To 400,570 Dialog OdLGALT Title OemToAnsi("Alteracao / Exclusao ==> Itens - (ECOMA04A)")
@ 025,005 TO 130,280 BROWSE "TZ4" FIELDS aCpos
@   7,  5 Bmpbutton Type 1 Action _Volta()
@   7, 50 Bmpbutton Type 2 Action _Fecha()
@   7,100 Button "_Exclui" Size 30,10 action _Exclui()
Activate DIALOG oDLGalt

/**********************************************************************/
Static Function _Volta()

_Altera:=.t.                    

Dbselectarea("SZ4")
Dbsetorder(1)
DbSEEK(xFILIAL("SZ4")+cPedido+TZ4->T4_ITEMP+TZ4->T4_ITEMD)
_cCusto     := SZ4->Z4_PRCCST
_cIPI       := SZ4->Z4_IPI
_cICMS      := SZ4->Z4_ICMS
_cDesco1    := SZ4->Z4_DESCO1
_cDesco2    := SZ4->Z4_DESCO2
_cDesco3    := SZ4->Z4_DESCO3
_cDesco4    := SZ4->Z4_DESCO4
_cDesco5    := SZ4->Z4_DESCO5
_cDesco6    := SZ4->Z4_DESCO6
_cDesco7    := SZ4->Z4_DESCO7
_cAcres     := SZ4->Z4_ACRFIN
_cAcresC    := SZ4->Z4_ACRFINC
_cPrcLq     := SZ4->Z4_PRCLIQ
_cPrcve     := SZ4->Z4_PRCVEN
_cMarge     := SZ4->Z4_MARGEM
_cCOR       := SZ4->Z4_COR
_cITEMP     := VAL(SZ4->Z4_ITEMP)
_cITEMD     := VAL(SZ4->Z4_ITEMD)
_SEQ        := SZ4->Z4_REF
_SEQ        := SZ4->Z4_SEQ
cGRD        := cGrd
cDESC       := SZ4->Z4_DESC
cCod        := _SEQ
_cGrade     := {}
_cQuant     := {}

For _n := 1 to 13
   If !Empty(SZ4->(FieldGet(FieldPos("Z4_IGRD"+StrZero(_n,2)))))
      AAdd(_cGrade,SZ4->(FieldGet(FieldPos("Z4_IGRD"+StrZero(_n,2)))))
      AAdd(_cQuant,SZ4->(FieldGet(FieldPos("Z4_QGRD"+StrZero(_n,2)))))
   Endif
Next _n

_cFIL:={}
_cEnt:={}
_cRpt:={}

FOR X:= LEN(_cFIL) TO 20
    AADD(_cfIL,""      )
    AADD(_cRpt,""      )
    AADD(_cENT,Ctod(""))
Next X    
_cTot      :=SZ4->Z4_QGRTOT 
For _n := 1 to Len(_cFil)
    _cFil[_n] := SZ4->(FieldGet(FieldPos("Z4_FIL"+StrZero(_n,2))))
    _cRpt[_n] := SZ4->(FieldGet(FieldPos("Z4_RPT"+StrZero(_n,2))))
    _cEnt[_n] := SZ4->(FieldGet(FieldPos("Z4_ENT"+StrZero(_n,2))))
Next _n

Dbselectarea("SZ3")
Dbsetorder(1)
Dbseek(Xfilial("SZ3")+_cCor)
IF !Eof()
   _cNcor:=SZ3->Z3_DESC
Endif
cProduto := _SEQ+" - "+Alltrim(SZ4->Z4_DESC)

Dbselectarea("TZ4")
Dbclosearea("TZ4")
_TZ4 :=.F.
MsUnLock()
Close(oDlgalt)
Return
/***********************************************************************/
Static Function _Fecha()

_ALTERA:=.F.

Dbselectarea("TZ4")
Dbclosearea("TZ4")
MsUnLock()
_TZ4:=.F.
cPare:=.t.
Close(oDlgalt)
Return
/************************************************************************/
Static Function _Exclui()
lret:= MsgBox("Confirma Exclusao de Item?","Confima","YESNO")
If lret == .F.
   Return
End
Dbselectarea("SZ4")
Dbsetorder(1)
DbSEEK(xFILIAL("SZ4")+cPedido+TZ4->T4_ITEMP+TZ4->T4_ITEMD)
Reclock("SZ4",.F.)
Dbdelete()
Msunlock()

Dbselectarea("SZ4")
Dbsetorder(1)
DbSEEK(xFILIAL("SZ4")+cPedido,.T.)
_cITEM:=0
While SZ4->Z4_PEDIDO == cPEDIDO
      _cItem        := _cITEM + 1
      Reclock("SZ4",.F.)
      SZ4->Z4_ITEMP := STRZERO(_cITEM,2)
      mSunlock()
      Dbskip()
End-While

Dbselectarea("SZ4")
Dbsetorder(1)
MsUnLock()

Dbselectarea("TZ4")
Dbclosearea("TZ4")
_TZ4    :=.F.
MsUnLock()
cPare   :=.t.
_Altera :=.F.
Close(oDlgalt)
Return
