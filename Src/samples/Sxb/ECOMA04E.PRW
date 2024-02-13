#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Ecoma04e()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//***********************************************************************
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//***********************************************************************

SetPrvt("_TOTLIQ,_TOTITEM,_TOTVEN,_CSTMED,_CCOND,_CNCOND")
SetPrvt("_CCOMPL,CNUMPED,_RETURN,TOTF,C,CCAMPO")
SetPrvt("_TOTF,_CONTATO,_TEL,_OBS,LCONTPED,")

//*****************************************************************************
//**³Programa  ³ECOMA04E  ³ Autor ³ Emerson Augusto       ³ Data ³ 10/10/99 ³±±
//**³Descri‡…o ³ Pedido de Compras                                          ³±±
//**³Uso       ³ Especifico para Casa das Cuecas                            ³±±
//*****************************************************************************

_CalcTot()
IF _TotiTem < 1
   MsgBox("PEDIDO NAO TEM ITENS CONFIRMADOS")
   Return
Endif
Dbselectarea("SZ4")
Dbsetorder(1)
DbSeek(xfilial("SZ4")+cPedido,.T.)

IF Empty(SZ4->Z4_NUMPED)
   cNumped:=GetSX8Num("SC7")
   ConfirmSX8("SC7",cNumped)
   MsgBox("GERADO  PEDIDO  NUMERO  "+ cNUMPED ,"ATENCAO","ALERT")
Else
   cNumped:=SZ4->Z4_NUMPED
   MsgBox("ALTERADO PEDIDO  NUMERO  "+ cNUMPED ,"ATENCAO","ALERT")
Endif
Dbselectarea("SZ4")
Dbsetorder(1)
DbSeek(xfilial("SZ4")+cPedido,.t.)

While cPEDIDO == SZ4->Z4_PEDIDO
      Reclock("SZ4",.F.)
      SZ4->Z4_NUMPED:=cNumped
      SZ4->Z4_DATA:=dDatabase
      SZ4->Z4_SIT:="A"  // incluso
      Msunlock()
      Dbskip()
End-While

@ 130,005 To  300,600 Dialog _Odlg5 Title OemToAnsi("Finalizacao Pedido - (ECOMA04E) ")
@ 000,010 To  035,290 Title OemToAnsi("Totais / Cond. Pagto")
@  10, 15 Say OemToAnsi("Liquido") Size 53,10
@  10, 65 Say _Totliq Picture "@E 999,999,999.99" SIZE 70,10
@  10,145 Say OemToAnsi("TT Itens ") Size 53,10
@  10,185 Say _Totitem Picture "@E 999,999,999.99" SIZE 70,10
@  25, 15 Say OemToAnsi("Vendas ") Size 53,10
@  25, 65 Say _Totven Picture "@E 999,999,999.99" SIZE 70,10
@  25,145 Say OemToAnsi("Cst Medio ") Size 53,10
@  25,185 Say _CstMed Picture "@E 999,999,999.99" SIZE 70,10
@  40, 15 Say OemToAnsi("Cond.Pagto") Size 20,10
@  40, 65 Get _cCond  SIZE  20,10 F3("SE4") VALID _Cond()
@  40,150 SAY _cNCond size 180,10
//@  60, 15 Say OemToAnsi("Complemento ") Size 53,10
//@  60, 65 Get _cComPL SIZE 20,10
@  60,210 Bmpbutton Type 6 action _Finali()
@  60,250 Bmpbutton Type 2 action cLOSE(_oDLG5)
Activate Dialog _oDlg5
/*************************************************************************/
Static Function _Cond()
        _Return := .T.
        DbSelectArea("SE4")
        DbSetOrder(1)
        If DbSeek(xFilial("SE4")+_cCond)
           _cNCond := SE4->E4_DESCRI
        Else
           _cNCond := Space(Len(SE4->E4_DESCRI))
           _Return := .F.
        EndIf
//         _cNCond:=Alltrim(_Ccond)+" DD "+alltrim(_cDESCO)
Return(_Return)
/*************************************************************************/
Static Function _Calctot()

Dbselectarea("SZ4")
Dbsetorder(1)
DbSeek(xfilial("SZ4")+cPedido,.T.)

While cPEDIDO == SZ4->Z4_PEDIDO
      Totf:=0
      For C := 1 to 20
          cCampo:="Z4_FIL"+Strzero(C,2)
          IF !Empty(SZ4->(FieldGet(FieldPos(cCampo))))
             Totf:=totf+1
          Endif
      Next C
      _Totf   := SZ4->Z4_QGRTOT * Totf
      _Totitem:= _Totitem + _Totf
      _Totliq := _Totliq + (SZ4->Z4_PRCLIQ * _Totf)
      _Totven := _Totven + (SZ4->Z4_PRCVEN * _Totf)
      _Cstmed := _Totliq / _Totitem
      _cCond  := SZ4->Z4_COND
      _cNCond := SZ4->Z4_CONDH
      _cCompl := SZ4->Z4_COMPL
      Dbskip()
End-While

Return
/************************************************************************/
Static Function _Finali()

_Contato:=SA2->A2_REPRES
_Tel    :=SA2->A2_REPRTEL
_Obs    :=SZ4->Z4_OBS
@ 210,050 To 380,500 Dialog _CONTA Title OemToAnsi("Dados Representante")
@  10,  5 Say OemToAnsi("Representante.:") Size 34,10
@  30,  5 Say OemToAnsi("Telefone......:") Size 34,10
@  50,  5 Say OemToAnsi("Observacoes...:") Size 34,10
@  10, 50 Get _Contato Size 100,10
@  30, 50 Get _Tel     Size  50,10
@  50, 50 Get _Obs     Size 150,10
@  70, 77 Bmpbutton Type 1 action _FConta()
Activate Dialog _Conta
Return

/*************************************************************************/
Static Function _FConta()
Dbselectarea("SA2")
Reclock("SA2",.F.)
SA2->A2_Repres :=_Contato
SA2->A2_Reprtel:=_Tel
Msunlock()
CLOSE(_Conta)
Dbselectarea("SZ4")
Dbsetorder(1)
DbSeek(xfilial("SZ4")+cPedido,.t.)

While cPEDIDO == SZ4->Z4_PEDIDO    

      Reclock("SZ4",.F.)
      SZ4->Z4_COND  := _cCond
      SZ4->Z4_CONDH := _cNCond
      SZ4->Z4_COMPL := _cCompl
      SZ4->Z4_DATA  := dDatabase
      SZ4->Z4_OBS   := _Obs
      Msunlock()
      Dbskip()
End-While

Dbselectarea("SZ4")
DbsetoRder(1)
Execblock("ECOMA04I",.F.,.F.)
IF Msgyesno("Pedido Esta Correto ?, Encerra Processo ?","Escolha")
   Lcontped:=.F.
   Dbselectarea("SZ4")
   Dbsetorder(1)
   CLOSE(_oDLG5)
Else
   CLOSE(_oDLG5)
Endif
Return
