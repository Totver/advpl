#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Rcoma02()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//***********************************************************************
//* Declaracao de variaveis utilizadas no programa atraves da funcao    *
//* SetPrvt, que criara somente as variaveis definidas pelo usuario,    *
//* identificando as variaveis publicas do sistema utilizadas no codigo *
//* Incluido pelo assistente de conversao do AP5 IDE                    *
//***********************************************************************

SetPrvt("LCONTINUA,CFORANT ,CFORNECE,CNFOR  ,CSEQCAD,CGRD" )
SetPrvt("CNGRD    ,CSGRD   ,CCOR    ,CNCOR  ,CDESC  ,CUN"  )
SetPrvt("CNUN     ,CGRP    ,CNGRP   ,NVALPRC,C      ,A"    )
SetPrvt("B        ,LRET    ,ASVALIAS,ASTRU  ,CARQ   ,CQATU")
SetPrvt("CQPEDVEN ,CSALPEDI,CCHAVE  ,CCOD   ,CSEQ   ,CCOD1")
SetPrvt("ACPOS    ,")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 08/05/00 ==>   #DEFINE PSAY SAY
#ENDIF
/*
*****************************************************************************
**³Programa  ³RCOMA02   ³ Autor ³ Emerson Augusto       ³ Data ³ 27/07/99 ³**
**³Descri‡…o ³ Cadastro de Produtos                                       ³**
**³Uso       ³ Especifico para                                            ³**
*****************************************************************************
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetKey(115,{|| fprod()})// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> SetKey(115,{|| Execute(fprod)})
lContinua := .T.
cForant   :=sPace(6)

While lContinua
   fLanProd()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>    Execute(fLanProd)
End-While

Return

/********************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function fLanProd
Static Function fLanProd()

cFornece  := cForant
cForant   := sPace( 6)
cNFOR     := SPACE(30)
cSEQCAD   := Space( 3)
cGrd      := Space( 2)
cNGRD     := Space(20)
cSGRD     := SPACE(60) 
cCOR      := Space( 2)
cNCOR     := Space(20)
cDesc     := Space(30)
cUN       := Space( 2)
cNUN      := SPACE(20)
cGrp      := Space( 4)
cNGRP     := SPACE(20)
nValprc   := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Interface                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

@100, 22 To 500,613 Dialog Dialog1 Title OemToAnsi("Cadastro Base Para Produtos")
@  0,  1 To 91,257 Title OemToAnsi("PRODUTOS INCLUSAO")
@ 95,  1 To 190,257 Title OemToAnsi("Informacoes Complementares")
@ 10,  5 Say OemToAnsi("FORNECEDOR") Size 53,13
@ 30,  5 Say OemToAnsi("COD.COR.")   Size 53,13
@ 50,  5 Say OemToAnsi("COD.SEQ.")   Size 53,13
@ 50,120 say OemtoAnsi("Digite (P) P/ NOVO Codigo")
@ 70,  5 Say OemToAnsi("COD.GRD.")   Size 53,13
@105,  5 Say OemToAnsi("DESCRICAO")  Size 53,13
@125,  5 Say OemToAnsi("UNIDADE")    Size 53,13
@145,  5 Say OemToAnsi("GRUPO")      Size 53,13
@165,  5 Say OemToAnsi("PRC.VENDA")  Size 53,13
@ 10, 65 Get cFornece  F3("SA2") VALID _FOR() SIZE 20,13 // Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 10,65  Get cFornece  F3("SA2") VALID EXECUTE(_FOR) SIZE 20,13 
@ 10,100 Get Cnfor size 150,13  WHEN .F.
@ 30, 65 Get cCOR Size 15,13  F3 "70" VALID _COR()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 30,65  Get cCOR Size 15,13  F3 "70" VALID EXECUTE(_COR)
@ 30,100 Get Cncor Size 150,13 WHEN .F.
@ 50, 65 Get cSEQCAD Size 30,13 VALID _SEQ()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 50,65  Get cSEQCAD Size 30,13 VALID EXECUTE(_SEQ)
@ 70, 65 Get cGrd F3("SZ2") VALID _GRD() SIZE 20,13 // Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 70,65  Get cGrd F3("SZ2") VALID EXECUTE(_GRD) SIZE 20,13 
@ 70,100 Get Cngrd Size 150,13 WHEN .F.
@ 80,100 Get Csgrd Size 150,13 WHEN .F.
@ 105,65 Get cDesc Size 184,13 Valid !Empty(cDesc)
@ 125,65 Get cUN Size 20,13 F3 "62" VALID _UN()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 125,65 Get cUN Size 20,13 F3 "62" VALID EXECUTE(_UN)
@125,100 Get cNUN Size 150,13 WHEN .F.
@ 145,65 Get cGRP Size 20,13 F3 "03"  VALID _GRP()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 145,65  Get cGRP Size 20,13 F3 "03"  VALID EXECUTE(_GRP)
@145,100 GET cnGRP Size 150,13  WHEN .F.
@165, 65 GET nValPrc Picture "@E 999,999.99" Size 50,13
@ 70,265  BmpButton Type 1 Action _Grava() // Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 70,265  BmpButton Type 1 Action Execute(_Grava) 
@ 100,265 Bmpbutton Type 2 action if(cLOSE(dIALOG1) == .t.,LcONTINUA,LcONTINUA:=.f.)
@ 10,265 Button "Consulta" SIZE 35,20 Action fprod()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 10,265 Button "Consulta" SIZE 35,20 Action Execute(fprod)
Activate Dialog Dialog1
Return

/**********************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _Grava
Static Function _Grava()

Close(Dialog1)
C:=""
A:=LEN(csgrd)
 For B:= 1 TO A
     IF Subs(csgrd,B,1) $ "/ "   
        IF !Empty(C)
           Dbselectarea("SB1")
           Reclock("SB1",.T.)
           SB1->B1_COD     :=Subs(cFORNECE,1,6)+Subs(cSEQCAD,1,3)+Subs(cCOR,1,2)+C
           SB1->B1_DESC    :=Cdesc
           SB1->B1_cCOR    :=cCOR
           SB1->B1_cGRD    :=cGRD
           SB1->B1_cSEQ    :=cSEQCAD
           SB1->B1_GRUPO   :=cGRP
           SB1->B1_TIPO    :="PA"
           SB1->B1_UM      :=cUN
           SB1->B1_PROC    :=cFornece
           SB1->B1_LOJPROC :="01"
           SB1->B1_LOCPAD  :="01"
           SB1->B1_TE      :="001"
           SB1->B1_TS      :="501"       
           SB1->B1_CODBAR  :=SB1->B1_COD
           SB1->B1_GRADE   :="S"
//           SB1->B1_PRV1    :=nValPRC
//           If !Empty(nValPRC)
//               SB1->B1_DTREFP1 := DDATABASE
//           End
           Msunlock()
           Dbcommit()
           C:=""
        End
     Else
        C:=C+Subs(csgrd,B,1) 
     End
  Next B
Dbselectarea("SB1")
Dbsetorder(1)
Return

/********************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _FOR
Static Function _FOR()
 lret  :=ExistCpo("SA2",cFornece)
 cNFOR :=SA2->A2_NOME
Return(lret)

/********************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _COR
Static Function _COR()
 lret  := Existcpo("SX5","70"+cCOR)
 cNcor := SX5->X5_DESCRI
Return(lret)

/********************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _GRD
Static Function _GRD()
 Lret  := ExistCpo("SZ2",cGrd)
 cnGRD := SZ2->Z2_DESC
 csGRD := SZ2->Z2_GRADE
Return(lret)

/********************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _UN
Static Function _UN()
 Lret:=Existcpo("SX5","62"+cUN)
 cNUN:=SX5->X5_DESCRI
Return(lret)

/********************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _GRP
Static Function _GRP()
 Lret :=Existcpo("SX5","03"+cGRP)
 cNGRP:=SX5->X5_DESCRI
Return(lret)

/********************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _SEQ
Static Function _SEQ()
Lret:=.F.
IF !Empty(cSeqCad)
   IF Alltrim(cSEQCAD) == "P"
      Dbselectarea("SB1")
//      Mudar Order sb1
      dbsetorder(7)
      Dbseek(xFILIAL("SB1")+Subs(cFornece,1,6)+Subs(cCOR,1,2))
      IF EOF()
         cSEQCAD:="001"
         lret:=.T.
      Else
         While SB1->B1_PROC+SB1->B1_cCOR == Subs(cFornece,1,6)+Subs(cCOR,1,2)
               cSEQCAD:=SB1->B1_cSEQ
               Dbskip()
         End-While
         cSEQCAD:=VAL(cSEQCAD)+1
         cSEQCAD:=STRZERO(cSEQCAD,3) 
         lret   :=.T.
      EndIf
   Else 
      Dbselectarea("SB1")
//      Mudar Order sb1 P/ 8
      dbsetorder(6)
      Dbseek(xFILIAL("SB1")+Subs(cFornece,1,6)+Subs(cCOR,1,2)+Subs(cSeqcad,1,3))
      IF EOF()
         lret:= MsgBox("Codigo NAO Existe, CRIA NESTE Codigo ?","Escolha","YESNO")
         If lret == .F.
            cSeqcad:=""
         EndIf
      Else
         Monta()
      EndIf
   EndIf
Endif
Return(lret)

/********************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function MONTA
Static Function MONTA()
close(Dialog1)
cGrd   :=SB1->B1_cGRD
cUN    :=SB1->B1_UM
cGRP   :=SB1->B1_GRUPO
cDESC  :=SB1->B1_DESC
ExistCpo("SZ2",cGrd)
cnGRD  :=SZ2->Z2_DESC
csGRD  :=SZ2->Z2_GRADE
Existcpo("SX5","62"+cUN)
cNUN   :=SX5->X5_DESCRI
Existcpo("SX5","03"+cGRP)
cNGRP  :=SX5->X5_DESCRI
nValprc:= SB1->B1_PRV1

@ 100,22 To 500,613 Dialog Dialog1 Title OemToAnsi("Cadastro Base Para Produtos")
@ 0,1  To  91,257 Title OemToAnsi("PRODUTOS EXCLUSAO")
@ 95,1 To 190,257 Title OemToAnsi("Informacoes Complementares")
@ 10,5    Say OemToAnsi("FORNECEDOR") Size 53,13
@ 30,5    Say OemToAnsi("COD.COR.")   Size 53,13
@ 50,5    Say OemToAnsi("COD.SEQ.")   Size 53,13
@ 70,5    Say OemToAnsi("COD.GRD.")   Size 53,13
@ 105,5   Say OemToAnsi("DESCRICAO")  Size 53,13
@ 125,5   Say OemToAnsi("UNIDADE")    Size 53,13
@ 145,5   Say OemToAnsi("GRUPO")      Size 53,13
@ 165,5   Say OemToAnsi("PRC.VENDA")  Size 53,13
@ 10,65   Get cFornece WHEN .F.
@ 10,100  GET cNFOR    Size 150,13 WHEN .F.
@ 30,65   Get cCOR     Size  15,13 WHEN .F.
@ 30,100  GET cNCOR    Size 150,13 WHEN .F.
@ 50,65   Get cSEQCAD  Size  30,13 WHEN .F.
@ 70,65   Get cGrd     SIZE  20,13 WHEN .F.
@ 70,100  GET cNGRD    Size 150,13 WHEN .F.
@ 80,100  GET cSGRD    Size 150,13 WHEN .F.
@ 105,65  Get cDesc    Size 184,13 WHEN .F.
@ 125,65  Get cUN      Size  20,13 WHEN .F.
@ 125,100 Get cNUN     Size 150,13 WHEN .F.
@ 145,65  Get cGRP     Size  20,13 WHEN .F.
@ 145,100 GET cnGRP    Size 150,13 WHEN .F.
@ 165,65  GET nValPrc Picture "@E 999,999.99" Size 50,13  WHEN .F.
@ 70,265  BmpButton Type 3 Action _Exclui() // Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 70,265  BmpButton Type 3 Action Execute(_Exclui) 
@ 100,265 Bmpbutton Type 2 action if(cLOSE(dIALOG1) == .t.,LcONTINUA,LcONTINUA:=.T.)
Activate Dialog Dialog1
Return

/********************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _Exclui
Static Function _Exclui()
   close(Dialog1)
   Dbselectarea("SB1")
//      Mudar Order sb1 P/ 8
   dbsetorder(6)
   Dbseek(xFILIAL("SB1")+Subs(cFornece,1,6)+Subs(cCOR,1,2)+Subs(cSeqcad,1,3))
   While SB1->B1_PROC+SB1->B1_cCOR+SB1->B1_CSEQ == Subs(cFornece,1,6)+Subs(cCOR,1,2)+Subs(cSeqcad,1,3)
         Dbselectarea("SB1")
         Reclock("SB1",.F.)
         Dbdelete()
         Msunlock()
         Dbcommit()
         Dbskip()
   End-While
Return
Dbselectarea("SB1")
Dbsetorder(1)
Return

/********************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function fprod
Static Function fprod()

aSvAlias:={Alias(),IndexOrd(),Recno()}

IF !empty(cFornece)
   aStru := {}
   AADD(aStru,{"TR_SEQ","C",03,0})
   AADD(aStru,{"TR_COR","C",10,0})
   AADD(aStru,{"TR_COD","C",15,0})
   AADD(aStru,{"TR_DESC","C",30,0})
   AADD(aStru,{"TR_DGRD","C",25,0})
   AADD(aStru,{"TR_QATU","N",6,0})
   AADD(aStru,{"TR_SALPEDI","N",6,0})
   cArq := CriaTrab(aStru,.T.)
   dbUseArea(.T.,,cArq,"TB1",.F.,.F.)
 
   cQatu   :=0
   cQpedVen:=0
   cSalPedi:=0

   dbSelectArea("SB1")
   // Mudar para order 7
   dbSetOrder(6)
   dbSeek(xFilial()+cFornece,.T.)

   While !Eof() .And. SUBS(B1_COD,1,6)==cFornece

         cChave:=SUBS(B1_COD,1,11)
         cCOD  := SUBS(SB1->B1_COD,1,11)
         cDESC := SB1->B1_DESC
         cCor  := SB1->B1_CCOR
         cSEQ  := SB1->B1_cSEQ
         cGRD  := SB1->B1_cGRD
         cCOD1 := SB1->B1_COD

         Dbselectarea("SZ2")
         Dbseek(Xfilial("SZ2")+cGrd)
         cnGRD :=SZ2->Z2_DESC

         Dbselectarea("SX5")
         Dbseek(Xfilial("SX5")+"70"+cCOR)
         cNcor :=SX5->X5_DESCRI

        dbSelectArea("SB1")

        While !Eof() .And. SUBS(B1_COD,1,11)==cChave

              dbSelectArea("SB2")
              dbSetOrder(1)
              dbSeek(xFilial("SB2")+SB1->B1_COD)

              cQATU    := cQatu    + SB2->B2_QATU
              cSALPEDI := cSalpedi + SB2->B2_SALPEDI

              dbSelectArea("SB1")
              dbSkip()
        End-While

        dbSelectArea("TB1")
        RecLock("TB1",.T.)
        TB1->TR_COD     := cCOD1
        TB1->TR_SEQ     := cSEQ
        TB1->TR_DESC    := cDESC
        TB1->TR_DGRD    := cnGRD
        TB1->TR_COR     := Subs(alltrim(cNCor),1,10) 
        TB1->TR_QATU    := cQATU
        TB1->TR_SALPEDI := cSALPEDI
        MsUnLock()

        dbSelectArea("SB1")

   End-While

   @170,20 To 400,700 Dialog oDlg2 Title OemToAnsi("Consulta Produtos do Fornecedor")

   dbSelectArea("TB1")
   IndRegua("TB1",cArq,"TR_COD",,,"Selecionando Registros...")
   dbGotop()

   aCpos:={}
   AADD(aCpos,{ "TR_DESC","Descricao Produto" })
   AADD(aCpos,{ "TR_SEQ","Seq" })
   AADD(aCpos,{ "TR_COR","Cor" })
   AADD(aCpos,{ "TR_Dgrd","Descricao Grade" })
   AADD(aCpos,{ "TR_QATU","Estoque Atual" })
   AADD(aCpos,{ "TR_SALPEDI","Pedidos Abertos" })
   
   @ 6,5 TO 100,350 BROWSE "TB1" FIELDS aCpos
   @ 170,120 BUTTON "_Ok" SIZE 20,15 ACTION Close(oDlg2)
   ACTIVATE DIALOG oDlg2 

   dbSelectArea("TB1")
   dbClosearea("TB1")
Endif
DbselectArea(aSvAlias[1])
Dbsetorder(aSvAlias[2])
Dbgoto(aSvAlias[3])
Close(Dialog1)
cForant := Cfornece
Return 
