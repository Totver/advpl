#include "rwmake.ch"     

User Function Rcoma04()  

//***********************************************************************
//* Declaracao de variaveis utilizadas no programa atraves da funcao    *
//* SetPrvt, que criara somente as variaveis definidas pelo usuario,    *
//* identificando as variaveis publicas do sistema utilizadas no codigo *
//* Incluido pelo assistente de conversao do AP5 IDE                    *
//***********************************************************************

SetPrvt("_DATAE  ,_TZ4      ,_CDESCO  ,ATEMP    ,CARQ    ,ARADIO"  )
SetPrvt("_NRADIO ,_CBENEF1  ,A        ,NLASTKEY ,FLANFOR ,_INCLUI" )
SetPrvt("CSALDO  ,CPEDABE   ,CVENDAS  ,_ALTERA  ,_ALTER  ,_REF"    )
SetPrvt("CCOD    ,CDESC     ,_SEQ     ,CGRD     ,CCOD1   ,CCPAGTO" )
SetPrvt("CUPRC   ,_CEST     ,ACPOS    ,LCONTINUA,LDISTR  ,CFORANT" )
SetPrvt("_CLOSE2 ,_CITEMD   ,_CITEMP  ,_CTOT    ,_CCONPG ,_CCUSTO" )
SetPrvt("_CPRCLQ ,_CQTOT    ,PV       ,_CPRCVE1 ,_CPRCVE2,_CMARGE" )
SetPrvt("_CGRADE ,_CQUANT   ,_CCOR    ,_CNCOR   ,_CREFER ,_CFIL"   )
SetPrvt("_CENT   ,ASVALIAS  ,ASTRU    ,_CFORN   ,LCONTPED,CREF"    )
SetPrvt("CREFANT ,CPARE     ,CPEDIDO  ,CFORNECE ,CNFOR   ,_CIPI"   )
SetPrvt("_CDESCO1,_CDESCO2  ,_CDESCO3 ,_CDESCO4 ,_CDESCO5,_CDESCO6")
SetPrvt("_CDESCO7,_CACRES   ,_CACRESC ,_CBENEF  ,_SIT    ,C"       )
SetPrvt("CLOJA   ,_cICMS"                                          )

            
//****************************************************************************
//**³Programa  ³RCOMA04   ³ Autor ³ Emerson Augusto       ³ Data ³ 22/11/99 **
//**³Descri‡…o ³ Pedido de Compras                                          ³*
//**³Uso       ³ Especifico para Casa das Cuecas                            ³*
//****************************************************************************

SetKey(113,{|| _FimFor()})
Public _cFIL   := {}
Public _cEnt   := {}
Public _cRpt   := {}
Public _cItemP := 0
Public _Totliq :=0
Public _TotiTem:=0
Public _TotVen :=0
Public _CstMed :=0
Public _cCond  :=Space(03)
Public _cNcond :=SPACE(70)
Public _cCompl :=SPACE(10)
Public aFilial:= {}
Public _Close2:=.T.
Public _Dbenef:=.F.
Public pl     := 0    
Public _fli   := .t.
Public _cItemP:= 1
Public _cItemD:= 1
Public _cQuant:= {}
Public _cRefer:= Space(30)
Public _cCor  := Space(03)
Public _cNCor := Space(30)
Public _cPrcLq:= 0
Public _Benef1:= 0
Public _Prcve1:= 0
Public _Prcve2:= 0
Public _cIcms := 0

_DATAE  := CTOD("")
_TZ4    := .F.
_cDesco := ""
aTemp   := {}
cFornece:= Space(6)  
cLoja   := Space(2)
cNFor   := Space(50)
cPedido := Space(8)    
_cDesco2:= 0
_cDesco3:= 0
_cDesco4:= 0
_cDesco5:= 0
_cDesco6:= 0
_cDesco7:= 0
_cAcres := 0
_cAcresc:= 0    
_cBenef := 0
_cGrade := {}
AADD(atemp,{"TP_Pedido"  ,"C", 8,0})
AADD(atemp,{"TP_DCOR"    ,"C",10,0})
AADD(atemp,{"TP_REF"     ,"C", 6,0})
AADD(atemp,{"TP_COR"     ,"C", 3,0})
AADD(atemp,{"TP_Item"    ,"C", 2,0})
AADD(atemp,{"TP_DESC"    ,"C",30,0})
AADD(atemp,{"TP_Refer"   ,"C",15,0})
AADD(atemp,{"TP_SEQ"     ,"C", 6,0})
AADD(atemp,{"TP_Grd"     ,"C", 2,0})
AADD(atemp,{"TP_CUSTO"   ,"N", 6,2})
AADD(atemp,{"TP_IPI"     ,"N", 6,2})
AADD(atemp,{"TP_ICMS"    ,"N", 6,2})
AADD(atemp,{"TP_Desco1"  ,"N", 6,2})
AADD(atemp,{"TP_Desco2"  ,"N", 6,2})
AADD(atemp,{"TP_Desco3"  ,"N", 6,2})
AADD(atemp,{"TP_Desco4"  ,"N", 6,2})
AADD(atemp,{"TP_Desco5"  ,"N", 6,2})
AADD(atemp,{"TP_Desco6"  ,"N", 6,2})
AADD(atemp,{"TP_Desco7"  ,"N", 6,2})
AADD(atemp,{"TP_Acres"   ,"N", 6,2})
AADD(atemp,{"TP_AcresC"  ,"N", 1,0})
AADD(atemp,{"TP_PrcLq"   ,"N", 6,2})
AADD(atemp,{"TP_Prcve"   ,"N", 6,2})
AADD(atemp,{"TP_Marge"   ,"N", 6,2})
For _n := 1 to 13
    AADD(atemp,{"TP_Grade"+StrZero(_n,Iif(_n<10,1,2))  ,"C", 2,0})
    AADD(atemp,{"TP_Quant"+StrZero(_n,Iif(_n<10,1,2))  ,"N", 4,0})
Next _n
AADD(atemp,{"TP_Tot"     ,"N", 4,0})

cArq := CriaTrab(atemp,.T.)
DbUseArea(.T.,,cArq,"TP1")
IndRegua("TP1",cArq,"TP_ITEM+TP_SEQ",,,"Selecionando Registros...")

aRADIO   := {}
_nRADIO  := 1
_cBenef1 := ""
A        := ""

DbSelectArea("SZ8")
DbSetOrder(1)
DbSeek(xFilial("SZ8")+"XX")

A:="CURVA A"+" - "+ALLTRIM(STR(SZ8->Z8_MARGEMA))+" %"
AAdd(aRADIO,A)
A:="CURVA B"+" - "+ALLTRIM(STR(SZ8->Z8_MARGEMB))+" %"
AAdd(aRADIO,A)
A:="CURVA C"+" - "+ALLTRIM(STR(SZ8->Z8_MARGEMC))+" %"
AAdd(aRADIO,A)
nLastKey := 0
Flanfor  := .t.
While Flanfor
      If !Montaini()
         fLanFor  := .F.
         Lcontped := .F.
         DbselectArea("SZ4")
         Dbsetorder(1)
         DbselectArea("TB1")
         Dbclosearea("TB1")
         DbselectArea("TP1")
         Dbclosearea("TP1")
         Exit
      EndIf
      FLANPED()
End-While
Return
/**************************************************************************/
Static Function fLanPED()

While Lcontped

      _Inclui := .T.
      cSaldo  := 0
      cPedAbe := 0
      cVendas := 0
      _Altera := .F.
      _Alter  := .F.

      DbSelectArea("SB1")
      DbSetOrder(7)
      DbSeek(xFilial("SB1")+cFornece)
      While !Eof() .and. cFornece == SB1->B1_PROC

            _Ref := SB1->B1_REF
            dbSelectArea("TB1")
            dBseek(_Ref)
            IF EOF()
               cCOD   := SUBS(SB1->B1_COD,1,6)
               cDESC  := SB1->B1_DESC
               _Seq   := SB1->B1_REF
               cGRD   := SB1->B1_cGRD
               cCOD1  := SB1->B1_COD
               cCpagto:= SB1->B1_CPAGTO
               cSaldo := SB1->B1_SALDO
               cPedabe:= SB1->B1_PEDABE
               cVendas:= SB1->B1_VENDAS
               cUPRC  := SB1->B1_UPRC

               RecLock("TB1",.T.)
               TB1->T1_COD     := cCOD
               TB1->T1_SEQ     := _Seq
               TB1->T1_DESC    := cDESC
               TB1->T1_CGRD    := cGrd
               TB1->T1_Fornece := cFornece
               TB1->T1_SALDO   := cSaldo
               TB1->T1_VENDAS  := cVendas
               TB1->T1_PEDABE  := cPedabe
               TB1->T1_UPRC    := cUPRC
               TB1->T1_CPAGTO  := cCPAGTO
               MsUnLock()
            Endif

            DbSelectArea("SB1")
            DbSkip()
      End-While

      _cEST    := .T.
      dbSelectArea("TB1")
      dbGotop()

      aCpos:={}
      AADD(aCpos,{"T1_SEQ"   ,"Referencia"        })
      AADD(aCpos,{"T1_DESC"  ,"Descricao Produto" })
      AADD(aCpos,{"T1_SALDO" ,"Estoque"           })
      AADD(aCpos,{"T1_VENDAS","Vendas"            })
      AADD(aCpos,{"T1_PEDABE","Pedido"            })

      @ 20,005 To 430,650 Dialog _oDLG1 Title OemToAnsi("Produtos do Fornecedor - RCOMA04")
      @ 05, 15 Say OemToAnsi("Fornecedor")          Size 53,10
      @ 05, 60 SAY cFornece                         SIZE 30,10
      @ 05,100 SAY Cnfor                            Size 150,10
      @ 13,220 SAY "F2->Fornecedor"                 Size 50,10
      @ 40, 05 TO 200,280 BROWSE "TB1" FIELDS aCpos
      @ 25,010 Bmpbutton Type 1 action _Incluip()   
      @ 25,050 Button "_Altera "                    SIZE 30,10  Action _AlteraP()
      @ 25,100 Button "_Finaliza "                  SIZE 30,10  Action Execblock("Ecoma04E",.F.,.F.)
//      @ 25,140 Button "_Cad.Produto"                SIZE 47,10  Action Execblock("Axinclui",.F.,.F.)
      @ 25,140 Button "_Cad.Produto"                SIZE 47,10  Action Execblock("Ecoma04C",.F.,.F.)
      @ 25,200 Bmpbutton Type 2 action _FimPed()
      @ 25,230 Button "For_nec" SIZE 40,10  Action _FimFor()
      Activate Dialog _oDlg1
End-While

Return

/**********************************************************************/
Static Function _Incluip()

_Altera   := .F.
_Alter    := .F.
lContinua := .T.
lDistr    := .F.
cForant   := Cfornece
_Close2   := .T.
_cITemD   := 0
_cITemP   := 0
_cTot     := 0
_cConPg   := " "
_cCusto   := 0
_cPrcLq   := 0
_cQtot    := 0
PV        := 0
_cPrcVe1  := 0
_cPrcVe2  := 0
_cMarge   := 0
_cGRade   := {}
_cQuant   := {}
_cCOR     := Space( 3)
_cnCOR    := Space(30)
_cRefer   := Space(20)
_SEQ      := TB1->T1_SEQ
cDESC     := TB1->T1_DESC
cGRD      := TB1->T1_CGRD

Dbselectarea("TP1")
Dbgotop()

If LastRec() > 0

   IF Msgyesno("Mantem Itens Ja Elaborados Anteriormente ?","Escolha")
      Dbselectarea('TP1')
      Dbgotop()
   Else
      Dbselectarea('TP1')
      DbGoTop()
      While !Eof()
            RecLock("TP1",.F.)
            DbDelete()
            MsUnLock()
      End-While
      _cFiL:={}
      _cRpt:={}
      _cENT:={}
   Endif

Endif
A:=0

DbselectArea("SZ4")
Dbsetorder(1)
Dbseek(xFILIAL("SZ4")+cPedido+"01")
While cPEDIDO == SZ4->Z4_PEDIDO
      _cITEMP := VAL(SZ4->Z4_ITEMP)
      Dbskip()
End-While

_cITEMP := _cITEMP + 1
_cITEMD := 0

DbSelectArea("TP1")
dbgotop()
While !eof()
      _cITEMD := _cITEMD +1
      Dbskip()
End-While

Execblock("Ecoma04P",.F.,.F.,.F.)

IF lcontped == .t.
   Close(_ODLG1)
Else
   _Fimped()
Endif

Return

/**********************************************************************/
Static Function Montaini()
aSvAlias:={Alias(),IndexOrd(),Recno()}
_cFiL := {}
_cENT := {}

aStru := {}
AADD(aStru,{"T1_SEQ"    ,"C",06,0})
AADD(aStru,{"T1_COD"    ,"C",06,0})
AADD(aStru,{"T1_CGRD"   ,"C",02,0})
AADD(aStru,{"T1_DESC"   ,"C",30,0})
AADD(aStru,{"T1_DGRD"   ,"C",30,0})
AADD(aStru,{"T1_FORNECE","C", 6,0})
AADD(aStru,{"T1_SALDO"  ,"N", 5,0})
AADD(aStru,{"T1_VENDAS" ,"N", 5,0})
AADD(aStru,{"T1_PEDABE" ,"N", 5,0})
AADD(aStru,{"T1_CPAGTO" ,"C",20,0})
AADD(aStru,{"T1_UPRC"   ,"N", 6,2})
AADD(aStru,{"T1_TECIDO" ,"C", 3,0})
AADD(aStru,{"T1_PADRAOT","C", 3,0})
AADD(aStru,{"T1_MANGA"  ,"C", 3,0})
AADD(aStru,{"T1_GRIFE"  ,"C", 3,0})
AADD(aStru,{"T1_MERCAD" ,"C", 3,2})
AADD(aStru,{"T1_INVERNO","C", 1,0})

cArq     := CriaTrab(aStru,.T.)
DbUseArea(.T.,,cArq,"TB1",.T.,.F.)
IndRegua("TB1",cArq,"T1_SEQ",,,"Selecionando Registros...")
_Altera  := .F.
_cForn   := .T.
lContped := .T.
cForant  := Space(6)
cRef     := Space(6)
cRefAnt  := Space(6)
cPare    := .f.
cPedido  := Space(8)
cPedido  := subs(cArq,1,8)
_cest    := .F.
cFornece := cForant
cForant  := Space(6)
cNfor    := Space(50)
_cIpi    := 0
_cICMS   := 0
_cDesco1 := 0
_cDesco2 := 0
_cDesco3 := 0
_cDesco4 := 0
_cDesco5 := 0
_cDesco6 := 0
_cDesco7 := 0
_cAcres  := 0
_cAcres  := 0
_cAcresC := 0
_cBenef  := 0
_SIT     := SPACE(10)

DbselectArea("SA2")
Dbgotop()
c        := Conpad1("","","","FOR")
cFornece := SA2->A2_COD
cLOJA    := SA2->A2_LOJA
cNFOR    := SA2->A2_NOME
Return(c)

/**********************************************************************/
Static Function _Fimped()
 fLanFor  := .F.
 Lcontped := .F.
 DbselectArea("SZ4")
 Dbsetorder(1)
 DbselectArea("TB1")
 Dbclosearea("TB1")
 DbselectArea("TP1")
 Dbclosearea("TP1")
 Close(_odlg1)
Return
/**********************************************************************/
Static Function _FimFor()

 Lcontped    := .F.
 DbselectArea("SZ4")
 Dbsetorder(1)
 DbselectArea("TB1")
 Dbclosearea("TB1")
 DbselectArea("TP1")
 DbGotop()
 While !Eof()
       RecLock("TP1",.F.)
       DbDelete()
       MsUnLock()
       DbSkip()
 End-While      
 Close(_odlg1)

Return

/**********************************************************************/
Static Function _AlteraP()
_cFiL   := {}    
_cRpt   := {}
_cENT   := {}

//Execblock("Ecoma04A",.F.,.F.)
_Altera := .t.
if _Altera == .T.
   _Alter    := .T.
   lcontinua := .T.
   DbSelectArea("TB1")
   DbSeek(_SEQ)
   DbselectArea('TP1')  
   DbGotop()
   While !Eof()
         RecLock("TP1",.F.)
         DbDelete()
         MsUnLock()
         DbSkip()
   End-While      
   Execblock("Ecoma04P",.F.,.F.,.T.)
Endif

Return
