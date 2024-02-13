#include "rwmake.ch"   

User Function Ecoma04c()
 
//***********************************************************************
//* Declaracao de variaveis utilizadas no programa atraves da funcao    *
//* SetPrvt, que criara somente as variaveis definidas pelo usuario,    *
//* identificando as variaveis publicas do sistema utilizadas no codigo *
//* Incluido pelo assistente de conversao do AP5 IDE                    *
//***********************************************************************

SetPrvt("LCONTINUA,CSEQCAD ,CGRD    ,CNGRD    ,CSGRD   ,CDESC"  )
SetPrvt("CUN      ,CNUN    ,CGRP    ,CSGRP    ,CCGRP   ,CTECIDO")
SetPrvt("CPADRAOT ,CMANGA  ,CGRIFE  ,CMERCAD  ,CDESCREF,CNGRP"  )
SetPrvt("CNSGRP   ,CNCGRP  ,CTECIDOD,CPADRAOTD,CMANGAD ,CGRIFED")
SetPrvt("CMERCADD ,CINVERNO,LRET    ,A        ,_CSEQ   ,CCOD"   )
SetPrvt("CCOD1    ,CCPAGTO ,CSALDO  ,CPEDABE  ,CVENDAS ,CUPRC"  )


//****************************************************************************
//**³Programa  ³RCOMA04   ³ Autor ³ Emerson Augusto       ³ Data ³ 22/09/99 ³*
//**³Descri‡…o ³ Pedido de Compras                                          ³*
//**³Uso       ³ Especifico para Casa das Cuecas                            ³*
//****************************************************************************


lContinua := .T.
While lContinua
      fLanProd()
End-While


Return(nil)        

/***********************************************************************/
Static Function fLanProd()

cSEQCAD  := Space( 6)
cGrd     := Space( 2)
cNGRD    := Space(20)
cSGRD    := SPACE(60) 
cDesc    := Space(40)
cUN      := "PC"
cNUN     := SPACE(20)
cGrp     := Space( 3)
cSGrp    := Space( 3)
cCGrp    := Space( 3)
cTecido  := Space( 3)
cPadraoT := Space( 3)
cManga   := Space( 3)
cGrife   := Space( 3)
cMercad  := Space( 3)
cDescRef := Space(20)
cNGRP    := SPACE(20)
cNSGRP   := SPACE(20)
cNCGRP   := SPACE(20)
cTecidoD := Space(20)
cPadraoTD:= Space(20)
cMangaD  := Space(20)
cGrifeD  := Space(20)
cMercadD := Space(20)
cInverno := "N"

//***********************************************************************
//* Criacao da Interface                                                *
//***********************************************************************

@ 125,05 To 550,600 Dialog Dialog1 Title OemToAnsi("Cadastro Base Para Produtos - (ECOMA04C)")
@ 000,010  To 205,290 Title OemToAnsi("Inclusao de Novos Produtos Para o Fornecedor")
@ 010,015  Say OemToAnsi("Referenc.")  Size 53,10
@ 025,015  Say OemToAnsi("COD.GRD.")   Size 53,10
@ 050,015  Say OemToAnsi("DESCRICAO")  Size 53,10
@ 065,015  Say OemToAnsi("UNIDADE")    Size 53,10
@ 080,015  Say OemToAnsi("Grupo")      Size 53,10
@ 095,015  Say OemToAnsi("Sub-Grupo")  Size 53,10
@ 105,015  Say OemToAnsi("Comport.")   Size 53,10
@ 115,015  Say OemToAnsi("Tecidos")    Size 53,10
@ 125,015  Say OemToAnsi("Padrao Tec.")Size 53,10
@ 135,015  Say OemToAnsi("Tipo Manga") Size 53,10
@ 145,015  Say OemToAnsi("Griffe")     Size 53,10
@ 155,015  Say OemToAnsi("Mercadoria") Size 53,10
@ 165,015  Say OemToAnsi("Inverno")    Size 53,10

@ 010,065  Get cSeqcad                 Size  30,10 F3 "Z2" VALID _SEQ()
@ 010,100  Get cDescRef                Size 100,10 WHEN .F.
@ 025,065  Get cGrd 				   SIZE  20,10 F3("SZ2") VALID _GRD()
@ 025,100  Get Cngrd                   Size 130,08 WHEN .F.
@ 035,100  Get Csgrd                   Size 130,08 WHEN .F.
@ 050,065  Get cDesc                   Size 150,10 Valid !Empty(cDesc)
@ 065,065  Get cUN                     Size  20,10 F3 "62" VALID _UN()
@ 065,100  Get cNUN                    Size 100,10 WHEN .F.
@ 080,065  Get cGRP                    Size  20,10 F3 "SZA"  VALID _GRP()
@ 080,100  GET cnGRP                   Size 100,10  WHEN .F.
@ 095,065  Get cSGRP                   Size  20,10 F3 "SZB"  VALID _CSGRP()
@ 095,100  GET cnSGRP                  Size 100,10  WHEN .F.
@ 105,065  Get cCGRP                   Size  20,10 F3 "SZC"  VALID _CGRP()
@ 105,100  GET cnCGRP                  Size 100,10  WHEN .F.
@ 115,065  Get cTecido                 Size  20,10 F3 "Z7"  VALID _Z7()
@ 115,100  GET cTecidoD                Size 100,10  WHEN .F.
@ 125,065  Get cPadraoT                Size  20,10 F3 "Z6"  VALID _Z6()
@ 125,100  GET cPadraoTD               Size 100,10  WHEN .F.
@ 135,065  Get cManga                  Size  20,10 F3 "Z8"  VALID _Z8()
@ 135,100  GET cMangaD                 Size 100,10  WHEN .F.
@ 145,065  Get cGrife                  Size  20,10 F3 "ZA"  VALID _ZA()
@ 145,100  GET cGrifeD                 Size 100,10  WHEN .F.
@ 155,065  Get cMercad                 Size  20,10 F3 "Z9"  VALID _Z9()
@ 155,100  GET cMercadD                Size 100,10  WHEN .F.
@ 165,065  Get cInverno                Size  20 ,10 Valid cInverno $ "SN"
@ 185,050  BmpButton Type 1 Action _Grava()
@ 185,120  Bmpbutton Type 2 action _Fiminc()
Activate Dialog Dialog1
Return

/********************************************************************/
Static Function _Grava()

  Dbselectarea("SB1")
  DbSetOrder(1)
  DbSeek(xFilial("SB1")+cSeqCad+Replicate(" ",Len(SB1->B1_COD)-6))
  If Eof()
     Reclock("SB1",.T.)
  Else
     Reclock("SB1",.F.)
  EndIf   
  SB1->B1_FILIAL := xFilial("SB1")
  SB1->B1_COD    := cSeqCad
  SB1->B1_DESC   := Cdesc
  SB1->B1_cGRD   := cGRD
  SB1->B1_cSEQ   := cSEQCAD
  SB1->B1_REF    := cSeqCad
  SB1->B1_GRPMAR := cGRP
  SB1->B1_SGRPMAR:= cSGRP
  SB1->B1_CLASSE := cCGRP
  SB1->B1_TIPO   := "PA"
  SB1->B1_UM     := cUN
  SB1->B1_PROC   := cFornece
  SB1->B1_LOJPROC:= "01"
  SB1->B1_LOCPAD := "01"
  SB1->B1_TE     := "001"
  SB1->B1_TS     := "501"
  SB1->B1_GRADE  := "S"
  SB1->B1_TECIDO := cTecido
  SB1->B1_PADRAOT:= cPadraoT
  SB1->B1_MANGA  := cManga
  SB1->B1_GRIFFE := cGrife
  SB1->B1_MERCAD := cMercad
  SB1->B1_INVERNO:= cInverno
  SB1->B1_FABRIC := cFornece
  MsUnLock()     
  Campos()
  Close(Dialog1)
Return
/**********************************************************************/
Static Function _GRD()
 Lret  := ExistCpo("SZ2",cGrd)
 cnGRD := SZ2->Z2_DESC
 csGRD := SZ2->Z2_GRADE
Return(lret)
/**********************************************************************/
Static Function _UN()
 Lret := Existcpo("SX5","62"+cUN)
 cNUN := SX5->X5_DESCRI
Return(lret)
/**********************************************************************/
Static Function _Z7()
 Lret     := Existcpo("SX5","Z7"+cTecido)
 cTecidoD := SX5->X5_DESCRI
Return(lret)
/**********************************************************************/
Static Function _Z6()
 Lret     :=Existcpo("SX5","Z6"+cPadraoT)
 cPadraoTD:=SX5->X5_DESCRI
Return(lret)
/**********************************************************************/
Static Function _Z8() 
 If Empty(cManga)
    lRet    := .t.
    cMangaD := Space(20)
 Else   
    Lret    :=Existcpo("SX5","Z8"+cManga)
    cMangaD :=SX5->X5_DESCRI
 EndIf   
Return(lret)
/**********************************************************************/
Static Function _ZA()
 If Empty(cGrife)
    lRet   := .t.
    cGrifeD:=Space(20)
 Else
    Lret   :=Existcpo("SX5","ZA"+cGrife)
    cGrifeD:=SX5->X5_DESCRI
 EndIf   
Return(lret)
/**********************************************************************/
Static Function _Z9()
 Lret     := Existcpo("SX5","Z9"+cMercad)
 cMercadD := SX5->X5_DESCRI
Return(lret)
/***********************************************************************/
Static Function _GRP()
 Lret  := Existcpo("SZA",cGRP)
 cNGRP := SZA->ZA_DESC
Return(lret)
/***********************************************************************/
Static Function _CSGRP()
 Lret   := Existcpo("SZB",cSGRP)
 cNSGRP := SZB->ZB_DESC
Return(lret)
/***********************************************************************/
Static Function _CGRP()
 Lret   := Existcpo("SZC",cCGRP)
 cNCGRP := SZC->ZC_DESC
Return(lret)
/**********************************************************************/
Static Function _SEQ()
 Lret     := Existcpo("SX5","Z2"+cSeqCad)
 cDescRef := SX5->X5_DESCRI
 If !Empty(cSeqCad)
    DbSelectArea("SB1")
    DbSetOrder(1)
    DbSeek(xFilial("SB1")+cSeqCad+Replicate(" ",Len(SB1->B1_COD)-6))
    if !Eof()
       MsgStop("Atencao ja existe esta referencia. Referencia ja cadastrada.")
       lRet := .f.
    EndIf
    DbSelectArea("SB1")
    DbSetOrder(7)
    DbSeek(xFilial("SB1")+cFornece+cSeqCad)
    if !Eof()
       MsgStop("Atencao ja existe esta referencia ja cadastrada para este fornecedor.")
       lRet := .F.
    EndIf
 EndIf
Return(lret)

/*********************************************************************************/
Static Function _Fiminc()

cLOSE(dIALOG1)
For A := 1 to 999

   _cSEQ:=STRZERO(A,6)
   dbSelectArea("SB1")
   // MUDAR ORDER  7 
   dbSetOrder(7) 
   dbSeek(xFilial("SB1")+cFornece+_cSeq)

   IF !eof()
      cCOD    := SUBS(SB1->B1_COD,1,6)
      cDESC   := SB1->B1_DESC
      _cSEQ   := SB1->B1_cSEQ
      cGRD    := SB1->B1_cGRD
      cCOD1   := SB1->B1_COD
      cCpagto := SB1->B1_CPAGTO
      cSaldo  := SB1->B1_SALDO
      cPedabe := SB1->B1_PEDABE
      cVendas := SB1->B1_VENDAS
      cUPRC   := SB1->B1_UPRC
      cTecido := SB1->B1_TECIDO
      cPadraoT:= SB1->B1_PADRAOT
      cManga  := SB1->B1_MANGA
      cGrife  := SB1->B1_GRIFFE
      cMercad := SB1->B1_MERCAD
      cInverno:= SB1->B1_INVERNO

      dbSelectArea("TB1")
      dBseek(cFornece+_cSEQ)
      IF EOF()
         RecLock("TB1",.T.)
         TB1->T1_COD     := cCOD
         TB1->T1_SEQ     := _cSEQ
         TB1->T1_DESC    := cDESC
         TB1->T1_CGRD    := cGrd
         TB1->T1_Fornece := cFornece
         TB1->T1_SALDO   := cSaldo
         TB1->T1_VENDAS  := cVendas
         TB1->T1_PEDABE  := cPedabe
         TB1->T1_UPRC    := cUPRC
         TB1->T1_CPAGTO  := cCPAGTO
         TB1->T1_TECIDO  := cTecido 
         TB1->T1_PADRAOT := cPadraoT
         TB1->T1_MANGA   := cManga 
         TB1->T1_GRIFE   := cGrife 
         TB1->T1_MERCAD  := cMercad
         TB1->T1_INVERNO := cInverno
         TB1->T1_FABRIC  := cFornece
         MSUnLock()
      EndIf
   Else
      A := 999999
   EndIf
Next a
Lcontinua:=.F.
Return

/********************************************************************/
Static Function Campos()

_Tabelas:={}
AADD(_Tabelas,{"SZA",SB1->B1_GRPMAR      ,"ZA_DESC"  ,"B1_GRUPOP" ,"SB1"})
AaDd(_Tabelas,{"SZB",SB1->B1_SGRPMAR     ,"ZB_DESC"  ,"B1_TIPOG"  ,"SB1"})
AaDd(_Tabelas,{"SZC",SB1->B1_CLASSE      ,"ZC_DESC"  ,"B1_COMPORT","SB1"})
AaDd(_Tabelas,{"SX5","Z2"+SB1->B1_REF    ,"X5_DESCRI","B1_REFDESC","SB1"})
AaDd(_Tabelas,{"SX5","Z7"+SB1->B1_TECIDO ,"X5_DESCRI","B1_DESCTEC","SB1"})
AaDd(_Tabelas,{"SX5","Z8"+SB1->B1_MANGA  ,"X5_DESCRI","B1_MANGAD" ,"SB1"})
AaDd(_Tabelas,{"SX5","Z6"+SB1->B1_PADRAOT,"X5_DESCRI","B1_PADRAOD","SB1"})
AaDd(_Tabelas,{"SX5","ZA"+SB1->B1_GRIFFE ,"X5_DESCRI","B1_GRIFEDE","SB1"})
AaDd(_Tabelas,{"SX5","Z9"+SB1->B1_MERCAD ,"X5_DESCRI","B1_MERCADD","SB1"})
AaDd(_Tabelas,{"SZ3",SB1->B1_CODCOR      ,"Z3_DESC"  ,"B1_COR"    ,"SB1"})
AaDd(_Tabelas,{"SX5","Z1"+SB1->B1_CODTAM ,"X5_DESCRI","B1_TAMANHO","SB1"})
AaDd(_Tabelas,{"SA2",SB1->B1_PROC        ,"A2_NREDUZ","B1_NOMFOR" ,"SB1"})

For _n := 1 To Len(_Tabelas)
     
    DbSelectArea(_Tabelas[_n,1])
    DbSetOrder(1)
    DbSeek(xFilial(_Tabelas[_n,1])+_Tabelas[_n,2])
    _Var := FieldGet(FieldPos(_Tabelas[_n,3]))
    
    RecLock(_Tabelas[_n,5],.F.)
    FieldPut(FieldPos(_Tabelas[_n,4]),_Var)
    MsUnLock()

Next _n

Return
