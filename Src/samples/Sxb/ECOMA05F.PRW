#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Ecoma05f()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_TOTLIQ,_TOTITEM,_TOTVEN,_CSTMED,_CNCOND,TOTF")
SetPrvt("C,CCAMPO,_TOTF,CFIL,CARQ1,_CITEMP")
SetPrvt("_CITEMD,_CSEQ,CPEDIDO,_CONTATO,_TEL,_OBS")
SetPrvt("CNUMPED,_ALTPED,_CPATH,_CFIL,_CPRODUTO,")


//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±³Programa  ³ECOMA05F  ³ Autor ³ Emerson Augusto       ³ Data ³ 08/12/99 ³±±
//±±³Descri‡…o ³ Pedido de Compras - Finaliazacao de Alteracao              ³±±
//±±³Uso       ³ Especifico para Casa das Cuecas                            ³±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

Close(odlg6)

_Totliq := 0
_TotiTem:= 0
_TotVen := 0
_CstMed := 0
_cNcond := TP2->TP_CONDH

_CalcZ4()

_CalcTot()

@ 130,005 To 300,600 Dialog _Odlg5 Title OemToAnsi("Finalizacao da Alteracao do Pedido"+_cNUMPED)
@ 000,010 To 035,290 Title OemToAnsi("Totais / Cond. Pagto")
@ 10,15  Say OemToAnsi("Liquido") Size 53,10
@ 10,65  Say _Totliq Picture "@E 999,999,999.99" SIZE 70,10
@ 10,145 Say OemToAnsi("TT Itens ") Size 53,10
@ 10,185 Say _Totitem Picture "@E 999,999,999.99" SIZE 70,10
@ 25,15  Say OemToAnsi("Vendas ") Size 53,10
@ 25,65  Say _Totven Picture "@E 999,999,999.99" SIZE 70,10
@ 25,145 Say OemToAnsi("Cst Medio ") Size 53,10
@ 25,185 Say _CstMed Picture "@E 999,999,999.99" SIZE 70,10
@ 40,100 SAY _cNCond size 100,10
@ 60,210 Bmpbutton Type 6 action _Imprime()
@ 60,250 Bmpbutton Type 1 action _Volta()
Activate Dialog _oDlg5

Return(nil) 

/***********************************************************************/
Static Function _Calctot()

Dbselectarea("SZ4")
Dbsetorder(2)
DbSeek(xfilial("SZ4")+_cNumped,.T.)

While _cNumped == SZ4->Z4_NUMPED
      Totf:=0
      _Rpt:=0
      For C := 1 to 20
//          cCampo:="SZ4->Z4_FIL"+Strzero(C,2)
          IF !Empty(SZ4->(FieldGet(FieldPos("Z4_RPT"+Strzero(C,2)))))
             Totf:=totf+1
             _Rpt := _Rpt + Val(SZ4->(FieldGet(FieldPos("Z4_RPT"+Strzero(C,2)))))
          Endif
      Next C
//             _Totf   := SZ4->Z4_QGRTOT * Val(SZ4->(FieldGet(FieldPos("Z4_RPT"+Strzero(C,2)))))
      _Totf   := SZ4->Z4_QGRTOT * Totf
      _Totitem:= _Totitem + _Totf
      _Totliq := _Totliq + (SZ4->Z4_PRCLIQ * _Totf)
      _Totven := _Totven + (SZ4->Z4_PRCVEN * _Totf)
      _Cstmed := _Totliq / _Totitem
      _cNCond := SZ4->Z4_CONDH
      Dbskip()

End-While
Return
/************************************************************************/
Static Function _CalcZ4()
DbselectArea("SZ4")
Dbsetorder(2)
Dbseek(xfilial("SZ4")+_cNumped,.t.)
While SZ4->Z4_NUMPED == _cNumped
      For C := 1 to 20
          cCampo:="SZ4->Z4_FIL"+Strzero(C,2)
          IF !Empty(&cCampo)
             cfil:=&cCampo
             IF SZ4->Z4_SIT #"A"
//                Abrefil()
                Apagac7()
//                Fechafil()
             Endif
          Endif
      Next c
      dbSelectArea("SZ4")
      RecLock("SZ4",.F.)
      Dbdelete()
      MsUnLock()
      Dbselectarea("SZ4")
      Dbskip()
End-While

Dbselectarea("TP2")
cArq1 := CriaTrab(nil,.F.)
IndRegua("TP2",cArq1,"TP_SEQ+TP_REFER+TP_COR+TP_FILIAL",,,"Selecionando Registros...")
Dbgotop()

_cItemp:=0
_cItemd:=0

WHILE !EOF()

      _cItemp :=_cItemp + 1
      _cItemd :=0
      _cSEQ   :=TP2->TP_SEQ
      Cpedido :=TP2->TP_PEDIDO

      While _Cseq == TP2->TP_SEQ

            Dbselectarea("SZ4")
            Dbsetorder(4)
//            Dbseek(xFILIAL("SZ4")+TP2->TP_NUMPED+TP2->TP_SEQ+TP2->TP_REFER+TP2->TP_COR+STR(TP2->TP_QGRTOT)+STR(TP2->TP_CUSTO))
            Dbseek(xFILIAL("SZ4")+TP2->TP_NUMPED+TP2->TP_SEQ+TP2->TP_REFER+TP2->TP_COR)
            IF EOF()
               _cItemD:=_cItemD + 1
               DbSelectArea("SZ4")
               DbSetOrder(1)
               DbSeek(xFilial("SZ4")+TP2->TP_FORNECE+TP2->TP_LOJA)
               
               Reclock("SZ4",.T.)
               SZ4->Z4_DATA         := dDatabase
               SZ4->Z4_Fornece      := TP2->TP_FORNECE
               SZ4->Z4_LOJA         := TP2->TP_LOJA
               SZ4->Z4_NOMFOR       := SA2->A2_NREDUZ
               SZ4->Z4_Pedido       := TP2->TP_PEDIDO
               SZ4->Z4_ITEMP        := Strzero(_cItemP,2)
               SZ4->Z4_COR          := TP2->TP_COR
               SZ4->Z4_ITEMD        := Strzero(_cItemD,2)
               SZ4->Z4_REF          := TP2->TP_Refer
               SZ4->Z4_SEQ          := TP2->TP_SEQ
               SZ4->Z4_DESC         := TP2->TP_DESC
               SZ4->Z4_CGRD         := TP2->TP_CGrd
               SZ4->Z4_PRCCST       := TP2->TP_CUSTO
               SZ4->Z4_IPI          := TP2->TP_IPI
               SZ4->Z4_DESCO1       := TP2->TP_Desco1
               SZ4->Z4_DESCO2       := TP2->TP_Desco2
               SZ4->Z4_DESCO3       := TP2->TP_Desco3
               SZ4->Z4_DESCO4       := TP2->TP_Desco4
               SZ4->Z4_DESCO5       := TP2->TP_Desco5
               SZ4->Z4_DESCO6       := TP2->TP_Desco6
               SZ4->Z4_DESCO7       := TP2->TP_Desco7
               SZ4->Z4_ACRFIN       := TP2->TP_Acres
               SZ4->Z4_ACRFINC      := TP2->TP_AcresC
               SZ4->Z4_PRCLIQ       := TP2->TP_PrcLq
               SZ4->Z4_PRCVEN       := TP2->TP_Prcve
               SZ4->Z4_MARGEM       := TP2->TP_Marge
               For _n := 1 to 13
                   SZ4->(FieldPut(FieldPos("Z4_IGRD"+StrZero(_n,2)),TP2->(FieldGet(FieldPos("TP_GRADE"+StrZero(_n,Iif(_n<10,1,2)))))))
                   SZ4->(FieldPut(FieldPos("Z4_QGRD"+StrZero(_n,2)),TP2->(FieldGet(FieldPos("TP_QUANT"+StrZero(_n,Iif(_n<10,1,2)))))))
               next _n
               SZ4->Z4_QGRTOT       := TP2->TP_QGRTOT
               SZ4->Z4_DBENEF       := TP2->TP_BENEF
               SZ4->Z4_CBENEF       := TP2->TP_CBENEF
               SZ4->Z4_FIL01        := TP2->TP_FILIAL
               SZ4->Z4_ENT01        := TP2->TP_ENTREG   
               SZ4->Z4_RPT01        := TP2->TP_REPETE
               SZ4->Z4_NUMPED       := _cNumped
               SZ4->Z4_COND         := TP2->TP_COND
               SZ4->Z4_CONDH        := TP2->TP_CONDH
               SZ4->Z4_COMPL        := TP2->TP_COMPL
               SZ4->Z4_DATA         := dDatabase
               SZ4->Z4_SIT          := "A" // Alterado
               Msunlock()
            Else
               Reclock("SZ4",.F.)
               DO Case
               Case EMPTY(SZ4->Z4_FIL02)
                    SZ4->Z4_FIL02        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT02        :=TP2->TP_ENTREG  
                    SZ4->Z4_RPT02        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL03)
                    SZ4->Z4_FIL03        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT03        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT03        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL04)
                    SZ4->Z4_FIL04        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT04        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT04        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL05)
                    SZ4->Z4_FIL05        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT05        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT05        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL06)
                    SZ4->Z4_FIL06        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT06        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT06        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL07)
                    SZ4->Z4_FIL07        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT07        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT07        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL08)
                    SZ4->Z4_FIL08        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT08        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT08        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL09)
                    SZ4->Z4_FIL09        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT09        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT09        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL10)
                    SZ4->Z4_FIL10        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT10        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT10        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL11)
                    SZ4->Z4_FIL11        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT11        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT11        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL12)
                    SZ4->Z4_FIL12    :=TP2->TP_FILIAL
                    SZ4->Z4_ENT12    :=TP2->TP_ENTREG
                    SZ4->Z4_RPT12        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL13)
                    SZ4->Z4_FIL13        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT13        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT13        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL14)
                    SZ4->Z4_FIL14        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT14        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT14        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL15)
                    SZ4->Z4_FIL15        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT15        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT15        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL16)
                    SZ4->Z4_FIL16        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT16        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT16        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL17)
                    SZ4->Z4_FIL17        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT17        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT17        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL18)
                    SZ4->Z4_FIL18        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT18        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT18        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL19)
                    SZ4->Z4_FIL19        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT19        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT19        :=TP2->TP_REPETE
               Case EMPTY(SZ4->Z4_FIL20)
                    SZ4->Z4_FIL20        :=TP2->TP_FILIAL
                    SZ4->Z4_ENT20        :=TP2->TP_ENTREG
                    SZ4->Z4_RPT20        :=TP2->TP_REPETE
               EndCase

               MSUNLOCK()
            Endif
            
            Dbselectarea("TP2")
            DbskiP()
      End-While
      Dbselectarea("TP2")
End-While
Return
/**********************************************************************/
Static Function _Imprime()
_Contato:=SA2->A2_REPRES
_Tel	:=SA2->A2_REPRTEL
_Obs	:=SZ4->Z4_OBS
@ 210,050 To 380,420 Dialog _CONTA Title OemToAnsi("Dados Representante")
@ 10,5 Say OemToAnsi("Representante.:") Size 34,10
@ 30,5 Say OemToAnsi("Telefone......:") Size 34,10
@ 50,5 Say OemToAnsi("Observacoes...:") Size 34,10
@ 10,50 Get _Contato Size 100,10
@ 30,50 Get _Tel	 Size 50,10
@ 50,50 Get _Obs	 Size 150,10
@ 70,77 Bmpbutton Type 1 action _FConta()
Activate Dialog _Conta
Return
/**********************************************************************/
Static Function _FConta()
Dbselectarea("SA2")
Reclock("SA2",.F.)
SA2->A2_Repres :=_Contato
SA2->A2_Reprtel:=_Tel
Msunlock()
CLOSE(_Conta)
MsgBox("ALTERADO PEDIDO  NUMERO  "+ _cNUMPED ,"ATENCAO","ALERT")
cNumped:=_cNumped
Dbselectarea("SZ4")
DbsetoRder(1)
Execblock("ECOMA04I",.F.,.F.)
Dbselectarea("SZ4")
Dbsetorder(1)
CLOSE(_oDLG5)
cLOSE(odLg6)
_ALTPED:=.f.
Return
/*************************************************************************/
Static Function _Volta()

MsgBox("ALTERADO PEDIDO  NUMERO  "+ _cNUMPED ,"ATENCAO","ALERT")
Dbselectarea("SZ4")
Dbsetorder(1)
CLOSE(_oDLG5)
cLOSE(odLg6)
_ALTPED:=.f.
Return
/*************************************************************************/
Static Function AbreFil()

_CPATH:="\SIGA\DADOSADV\"

_cFIL:= &cCampo+"0"

If !File(_cPath+"SC7"+_cFIL+".DBF" )
   MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SD2"+_cFIL,10)+ ;
            " nao econtrado. Impossivel Abrir ...")
   Return .F.
Endif

If !File(_cPath+"SB2"+_cFIL+".DBF" )
   MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SF4"+_cFIL,10)+ ;
            " nao econtrado. Impossivel Abrir ...")
   Return .F.
Endif

dbUseArea( .T. ,, _cPath+"SC7"+_cFIL,"SC7", .F. , .F. )
dbSetIndex(_cPath+"SC7"+_cFIL)
dbUseArea( .T. ,, _cPath+"SB2"+_cFIL,"SB2", .F. , .F. )
dbSetIndex(_cPath+"SB2"+_cFIL)
Return
/**********************************************************************/
Static Function FechaFil()
Dbselectarea("SC7")
Dbsetorder(1)
Dbselectarea("SB2")
Dbsetorder(1)
SC7->( DbClearInd())
SC7->( DbCloseArea())
SB2->( DbClearInd())
SB2->( DbCloseArea())
Return
/************************************************************************/
Static Function Apagac7()

Dbselectarea("SC7")
Dbsetorder(1)
Dbseek(cfil+_cNumped,.t.)

While SC7->C7_NUM == _cNUMPED .AND. SC7->C7_FILIAL == cFil

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
	 mSUNLOCK()
      Endif

      Dbselectarea("SC7")
      Reclock("SC7",.F.)
      Dbdelete()
      mSUNLOCK()

      Dbselectarea("SC7")
      Dbskip()
End-While
Return

