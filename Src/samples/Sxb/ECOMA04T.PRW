#include "rwmake.ch"       

User Function Ecoma04t()        

//***********************************************************************
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//***********************************************************************

SetPrvt("ACPOS   ,_ALTERA ,CDESC   ,_CSEQ   ,_CCOR   ,_CITEMD" )
SetPrvt("_CREFER ,_CGRD   ,_CCUSTO ,_CIPI   ,_CDESCO1,_CDESCO2")
SetPrvt("_CDESCO3,_CDESCO4,_CDESCO5,_CDESCO6,_CDESCO7,_CACRES" )
SetPrvt("_CACRESC,_CPRCLQ ,_CPRCVE ,_CMARGE ,_CGRADE ,_CQUANT" )
SetPrvt("_CTOT   ,CPRODUTO,_CNCOR  ,LRET    ,_cICMS"  )

//*************************************************************************
//*Funçäo    ³ ECOMA04T ³ Autor ³ Emerson Augusto       ³ Data ³ 24.09.99 *
//*Descriçäo ³ Pedido de Compra com grade                                 *
//*Uso       ³ Exclusivo Casa das Cuecas                                  *
//*************************************************************************

dbSelectArea("TP1")
dbGotop()

aCpos:={}
AADD(aCpos,{ "TP_SEQ"  ,"Codigo"     })
AADD(aCpos,{ "TP_ITEM" ,"Item"       })
AADD(aCpos,{ "TP_DESC" ,"Descricao"  })
AADD(aCpos,{ "TP_REFER","Ref"        })
AADD(aCpos,{ "TP_DCOR" ,"Cor"        })
AADD(aCpos,{ "TP_TOT"  ,"Total Grade"})

@ 130,030 To 400,570 Dialog OdLGALT Title OemToAnsi("Itens Ja Elaborados - (ECOMA04T) ")
@ 25 ,  5 TO 180,340 BROWSE "TP1" FIELDS aCpos
@ 7  ,  5 Bmpbutton Type 2 Action _Fecha()
@ 7  , 50 Button "_Duplica" Size 30,10 action _Dupli()
@ 7  ,100 Button "_Altera"  Size 30,10 action _Volta()
@ 7  ,150 Button "_Exclui"  Size 30,10 action _Exclui()
Activate DIALOG oDLGalt

Return(nil)

/*******************************************************************/
Static Function _Volta()
_Altera    :=.t.
dbSelectArea("TP1")
cDESC      :=TP1->TP_DESC
_cSEQ      :=TP1->TP_SEQ
_cCOR	   :=TP1->TP_COR
_cItemD    :=VAL(TP1->TP_Item)
_cRefer    :=TP1->TP_Refer
_cGrd	   :=TP1->TP_Grd
_cCUSTO    :=TP1->TP_CUSTO
_cIPI      :=TP1->TP_IPI   
_cIcms     :=TP1->TP_ICMS
_cDesco1   :=TP1->TP_Desco1
_cDesco2   :=TP1->TP_Desco2
_cDesco3   :=TP1->TP_Desco3
_cDesco4   :=TP1->TP_Desco4
_cDesco5   :=TP1->TP_Desco5
_cDesco6   :=TP1->TP_Desco6
_cDesco7   :=TP1->TP_Desco7
_cAcres    :=TP1->TP_Acres
_cAcresC   :=TP1->TP_AcresC
_cPrcLq    :=TP1->TP_PrcLq
_cPrcve    :=TP1->TP_Prcve
_cMarge    :=TP1->TP_Marge
For _n := 1 to 13          
    DbSelectArea("SX5")
    DbSeek(xFilial("SX5")+"Z1"+TP1->(FieldGet(FieldPos("TP_GRADE"+StrZero(Iif(_n<10,1,2))))))
    _cTitul[_n] := TRIM(SX5->X5_DESCRI)
    _cGrade[_n] := TP1->(FieldGet(FieldPos("TP_GRADE"+StrZero(Iif(_n<10,1,2)))))
    _cQuant[_n] := TP1->(FieldGet(FieldPos("TP_QUANT"+StrZero(Iif(_n<10,1,2)))))
next _n
_cTot	   := TP1->TP_Tot
cProduto   := cFORNECE+_cSEQ+" - "+cDESC

Dbselectarea("SZ3")
Dbsetorder(1)
Dbseek(Xfilial("SZ3")+_cCor)
IF !Eof()
   _cNcor:=SZ3->Z3_DESC
Endif
//cProduto := _cSEQ+" - "+Alltrim(SZ4->Z4_DESC)

Close(oDlgalt)
close(_oDlg2)
Dlgrefresh(_odlg2)
Return

/***********************************************************************/
Static Function _Dupli()
_Altera:=.F.
dbSelectArea("TP1")
Cdesc	   := TP1->TP_DESC
_cCOR	   := TP1->TP_COR
_cRefer    := TP1->TP_Refer
_cGrd	   := TP1->TP_Grd
_cCUSTO    := TP1->TP_CUSTO
_cDesco1   := TP1->TP_Desco1
_cDesco2   := TP1->TP_Desco2
_cDesco3   := TP1->TP_Desco3
_cDesco4   := TP1->TP_Desco4
_cDesco5   := TP1->TP_Desco5
_cDesco6   := TP1->TP_Desco6
_cDesco7   := TP1->TP_Desco7
_cAcres    := TP1->TP_Acres
_cAcresC   := TP1->TP_AcresC
_cPrcLq    := TP1->TP_PrcLq
_cPrcve    := TP1->TP_Prcve
_cMarge    := TP1->TP_Marge
For _n := 1 to 13
    DbSelectArea("SX5")
    DbSeek(xFilial("SX5")+"Z1"+TP1->(FieldGet(FieldPos("TP_GRADE"+StrZero(Iif(_n<10,1,2))))))
    _cTitul[_n] := TRIM(SX5->X5_DESCRI)
    _cGrade[_n] := TP1->(FieldGet(FieldPos("TP_GRADE"+StrZero(Iif(_n<10,1,2)))))
    _cQuant[_n] := TP1->(FieldGet(FieldPos("TP_QUANT"+StrZero(Iif(_n<10,1,2)))))
next _n
_cTot	   := TP1->TP_Tot
_cITEMD    := 0

Dbselectarea("TP1")
dbgotop()
While !eof()
      _cITEMD := _cITEMD +1
      Dbskip()
End-While

Dbselectarea("SZ3")
Dbsetorder(1)
Dbseek(Xfilial("SZ3")+_cCor)
IF !Eof()
   _cNcor := SZ3->Z3_DESC
Endif
//cProduto := _cSEQ+" - "+Alltrim(SZ4->Z4_DESC)
Close(oDlgalt)
close(_oDlg2)
Dlgrefresh(_odlg2)
Return
/***********************************************************************/
Static Function _Fecha()
_Altera := .F.
_cITEMD := _cItemd - 1
Close(oDlgalt)
close(_oDlg2)
Dlgrefresh(_odlg2)
Return
/***********************************************************************/
Static Function _Exclui()

lret := MsgBox("Confirma Exclusao do Item?","Confima","YESNO")
If lret == .F.
   Return
End
Dbselectarea("TP1")
Reclock("TP1",.F.)
Dbdelete()
Msunlock()
Dbselectarea("TP1")
Dbgotop()
_cItemd := 0
While !eof()
      _cITEMD := _cItemd + 1
      Reclock("TP1",.F.)
      TP1->TP_Item := StrZero(_cItemD,2)
      Msunlock()
      Dbskip()
End-While

close(oDlgalt)
close(_oDlg2)
Dlgrefresh(_odlg2)
Return