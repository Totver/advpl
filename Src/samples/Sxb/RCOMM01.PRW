#include "rwmake.ch"       

User Function Rcomm01()    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("C       ,CCAMPO  ,CCAMPO1,CCAMPO2  ,CFIL    ,ATEMP"  )
SetPrvt("_N      ,CARQ    ,_CPATH ,_CFIL    ,_CFILA  ,_CFORN" )
SetPrvt("_CLOJA  ,_CNUMPED,ITEMP  ,_CPRODUTO,_ASTRU  ,_AEVAL" )
SetPrvt("_NI     ,_CPATHF ,CDESC  ,CGRD     ,CSEQCAD ,CGRP"   )
SetPrvt("CSGRP   ,CCGRP   ,CTIPO  ,CUN      ,CFORNECE,CTECIDO")
SetPrvt("CPADRAOT,CMANGA  ,CGRIFE ,CMERCAD  ,CINVERNO,CFABRIC")
SetPrvt("_CODPROD,_TABELAS,_VAR,")

Public cArq
Public cCampo
Public cCampo1
Public cCampo2

//*****************************************************************************
//**³Fun‡ao    ³ RCOMM01  ³ Autor ³ Emerson Augusto       ³ Data ³ 31/12/99 ³**
//**³Descri‡…o ³ Programa para gerar Integracao de Compras / loja           ³**
//**³ Uso      ³ Especifico Casa das Cuecas                                 ³**
//*****************************************************************************

@ 96,42 TO 323,505 DIALOG oDlg5 TITLE "Atualiza dados de Compras e Prapara Dados Para lojas"
@ 8,10 TO 84,222
@ 91,168 BMPBUTTON TYPE 1 ACTION _Rotina()
@ 91,196 BMPBUTTON TYPE 2 ACTION Close(oDlg5)
@ 23,14 SAY "Este programa Atualiza dados para Compras / Estoque"
@ 43,14 SAY "e Prepara dados para serem enviados "
@ 63,14 SAY "as LOJAS"
ACTIVATE DIALOG oDlg5
Return nil
/******************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _Rotina
Static Function _Rotina()

Processa({|lEnd| cApSN1()})// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Processa({|lEnd| Execute(cApSN1)})

dbSelectArea("SZ4")
dbSetOrder(1)
dbSelectArea("SB1")
dbSetOrder(1)
dbSelectArea("SB0")
dbSetOrder(1)
dbSelectArea("SA2")
dbSetOrder(1)
dbSelectArea("SZ2")
dbSetOrder(1)
dbSelectArea("SZ3")
dbSetOrder(1)
Return
/***********************************************************************/
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function cApSN1
Static Function cApSN1()

Montatmp()

Dbselectarea("SZ4")
Dbsetorder(5)
Dbseek(xFilial("SZ4"),.T.)
Procregua(Reccount())

While !EOF() .AND. EMPTY(SZ4->Z4_SIT)
      Dbselectarea("SZ4")
      Reclock("SZ4",.F.)
      Dbdelete()
      MsUnLock()
      Dbskip()
End-While

Dbselectarea("SZ4")
Dbsetorder(5)
Dbseek(xFilial("SZ4"),.T.)
Procregua(Reccount())

WHILE !EOF() .and. SZ4->Z4_SIT == "A"

      Incproc("VERIFICANDO PEDIDOS")

      For C := 1 to 20
          cCampo :="Z4_FIL"+Strzero(C,2)
          cCampo1:="Z4_ENT"+Strzero(C,2)
          cCampo2:="Z4_RPT"+StrZero(c,2)
          IF !Empty(SZ4->(FieldGet(FieldPos(cCampo))))
             cFil:= SZ4->(FieldGet(FieldPos(cCampo)))+SPACE(4)
             Dbselectarea("TP2")
             Reclock("TP2",.T.)
             TP2->TP_FILIAL   := SZ4->(FieldGet(FieldPos(cCampo )))
             TP2->TP_ENTREG   := SZ4->(FieldGet(FieldPos(cCampo1)))
             TP2->TP_REPETE   := SZ4->(FieldGet(FieldPos(cCampo2)))
             TP2->TP_FORNECE  := SZ4->Z4_Fornece
             TP2->TP_DESC     := SZ4->Z4_DESC
             TP2->TP_LOJA     := SZ4->Z4_LOJA
             TP2->TP_NUMPED   := SZ4->Z4_NUMPED
             TP2->TP_COR      := SZ4->Z4_COR
             TP2->TP_Refer    := SZ4->Z4_REF
             TP2->TP_SEQ      := SZ4->Z4_SEQ
             TP2->TP_CGrd     := SZ4->Z4_CGRD
             TP2->TP_CUSTO    := SZ4->Z4_PRCCST
             TP2->TP_PrcLq    := SZ4->Z4_PRCLIQ
             TP2->TP_Prcve    := SZ4->Z4_PRCVEN
             TP2->TP_Grade01  := SZ4->Z4_IGRD01
             For _n := 1 to 13
                 TP2->(FieldPut(FieldPos("TP_QUANT"+StrZero(_n,2)),SZ4->(FieldGet(FieldPos("Z4_QGRD"+StrZero(_n,2))) * Val(FieldGet(FieldPos(cCampo2))) ) ))
                 TP2->(FieldPut(FieldPos("TP_GRADE"+StrZero(_n,2)),SZ4->(FieldGet(FieldPos("Z4_IGRD"+StrZero(_n,2))) )))
             Next _n      
             
//             TP2->TP_Quant01  := SZ4->Z4_QGRD01 * Val(SZ4->(FieldGet(FieldPos(cCampo2))))
//             TP2->TP_Grade02  := SZ4->Z4_IGRD02
//             TP2->TP_Quant02  := SZ4->Z4_QGRD02 * Val(SZ4->(FieldGet(FieldPos(cCampo2))))
//             TP2->TP_Grade03  := SZ4->Z4_IGRD03
//             TP2->TP_Quant03  := SZ4->Z4_QGRD03 * Val(SZ4->(FieldGet(FieldPos(cCampo2))))
//             TP2->TP_Grade04  := SZ4->Z4_IGRD04
//             TP2->TP_Quant04  := SZ4->Z4_QGRD04 * Val(SZ4->(FieldGet(FieldPos(cCampo2))))
//             TP2->TP_Grade05  := SZ4->Z4_IGRD05
//             TP2->TP_Quant05  := SZ4->Z4_QGRD05 * Val(SZ4->(FieldGet(FieldPos(cCampo2))))
//             TP2->TP_Grade06  := SZ4->Z4_IGRD06
//             TP2->TP_Quant06  := SZ4->Z4_QGRD06 * Val(SZ4->(FieldGet(FieldPos(cCampo2))))
//             TP2->TP_Grade07  := SZ4->Z4_IGRD07
//             TP2->TP_Quant07  := SZ4->Z4_QGRD07 * Val(SZ4->(FieldGet(FieldPos(cCampo2))))
//             TP2->TP_Grade08  := SZ4->Z4_IGRD08
//             TP2->TP_Quant08  := SZ4->Z4_QGRD08 * Val(SZ4->(FieldGet(FieldPos(cCampo2))))
//             TP2->TP_Grade09  := SZ4->Z4_IGRD09
//             TP2->TP_Quant09  := SZ4->Z4_QGRD09 * Val(SZ4->(FieldGet(FieldPos(cCampo2))))
//             TP2->TP_Grade10  := SZ4->Z4_IGRD10
//             TP2->TP_Quant10  := SZ4->Z4_QGRD10 * Val(SZ4->(FieldGet(FieldPos(cCampo2))))
//             TP2->TP_Grade11  := SZ4->Z4_IGRD11
//             TP2->TP_Quant11  := SZ4->Z4_QGRD11 * Val(SZ4->(FieldGet(FieldPos(cCampo2))))
//             TP2->TP_Grade12  := SZ4->Z4_IGRD12
//             TP2->TP_Quant12  := SZ4->Z4_QGRD12 * Val(SZ4->(FieldGet(FieldPos(cCampo2))))
//             TP2->TP_Grade13  := SZ4->Z4_IGRD13
//             TP2->TP_Quant13  := SZ4->Z4_QGRD13 * Val(SZ4->(FieldGet(FieldPos(cCampo2))))
             TP2->TP_EMISSAO  := SZ4->Z4_DATA
             TP2->TP_COND     := SZ4->Z4_COND
             TP2->TP_CONDH    := SZ4->Z4_CONDH
             TP2->TP_IPI      := SZ4->Z4_IPI     // PERC IPI
             TP2->TP_ICMS     := SZ4->Z4_ICMS    // PERC ICMS
             Msunlock()
             Dbselectarea("SZ4")
          ELSE
             C:=20
             Dbselectarea("SZ4")
          Endif
      Next C
      Dbselectarea("SZ4")
      Reclock("SZ4",.F.)
      SZ4->Z4_DTATU:=DDATABASE
      MsUnLock()
      Dbskip()
End-While

dbselectarea("TP2")
IndRegua("TP2",cArq,"TP_FILIAL+TP_NUMPED+TP_SEQ",,,"Selecionando Registros...")
_Atualiz()

Dbselectarea("SZ4")
Dbsetorder(6)
Dbseek(xFilial("SZ4")+DTOS(DDATABASE))
While !Eof() .AND. SZ4->Z4_DTATU == DDATABASE
      Reclock("SZ4",.F.)
      SZ4->Z4_SIT := "B"
      MsUnLock()
      DbskiP()
End-While
close(oDlg5)
Return
/*******************************************************************/
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function MontaTmp
Static Function MontaTmp()
aTemp:={}
AADD(atemp,{"TP_Filial"   ,"C", 2,0})
AADD(atemp,{"TP_Numped"   ,"C", 6,0})
AADD(atemp,{"TP_FORNECE"  ,"C", 6,0})
AADD(atemp,{"TP_LOJA"     ,"C", 2,0})
AADD(atemp,{"TP_Entreg"   ,"D", 8,0})
AADD(atemp,{"TP_Emissao"  ,"D", 8,0})
AADD(atemp,{"TP_COR"      ,"C", 3,0})
AADD(atemp,{"TP_DESC"     ,"C",30,0})
AADD(atemp,{"TP_Refer"    ,"C",20,0})
AADD(atemp,{"TP_REF"      ,"C", 6,0})
AADD(atemp,{"TP_SEQ"      ,"C", 6,0})
AADD(atemp,{"TP_CGrd"     ,"C", 2,0})
AADD(atemp,{"TP_CUSTO"    ,"N",14,2})
AADD(atemp,{"TP_PrcLq"    ,"N", 6,2})
AADD(atemp,{"TP_Prcve"    ,"N", 6,2})
AADD(atemp,{"TP_REPETE"   ,"C", 2,0})
For _n := 1 to 13
    AADD(atemp,{"TP_Grade"+StrZero(_n,2)  ,"C", 2,0})
    AADD(atemp,{"TP_Quant"+StrZero(_n,2)  ,"N", 4,0})
Next _n
AADD(atemp,{"TP_COND"     ,"C", 3,0})
AADD(atemp,{"TP_CONDH"    ,"C",70,0})
AADD(atemp,{"TP_IPI"      ,"N", 6,2})
AADD(atemp,{"TP_ICMS"     ,"N", 6,2})

cArq := CriaTrab(atemp,.T.)
dbUseArea(.T.,"DBFCDX",cArq,"TP2")

// ABRE B1 / B0 /A2 /Z2 /Z3 /C7 PARA ENVIAR AS FILIAIS

_CPATH := "\DADOSADV\FIL\"    
_Padrao:= "\SIGAADV"
_cFIL  := "010"   

If !File(Trim(_cPath+'SB1'+_cFIL+'.DBF' ) )
   MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SB0"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
   Return .F.
Endif

//Set Path TO &_Padrao

If !File(_cPath+'SB0'+_cFIL+'.DBF' )
   MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SB0"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
   Return .F.
Endif
If !File(_cPath+'SA2'+_cFIL+'.DBF' )
   MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SA2"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
   Return .F.
Endif
If !File(_cPath+'SZ2'+_cFIL+'.DBF' )
   MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SZ2"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
   Return .F.
Endif
If !File(_cPath+'SZ3'+_cFIL+'.DBF' )
   MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SZ3"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
   Return .F.
Endif

dbUseArea( .T. ,"DBFCDX", _cPath+"SB0"+_cFIL,"_SB0", .F. , .F. )
IndRegua("_SB0",  _cPath+"SB0"+_cFIL,"B0_COD",,,"Selecionando Registros...")
dbUseArea( .T. ,"DBFCDX", _cPath+"SB1"+_cFIL,"_SB1", .F. , .F. )
IndRegua("_SB1",  _cPath+"SB1"+_cFIL,"B1_COD",,,"Selecionando Registros...")
dbUseArea( .T. ,"DBFCDX", _cPath+"SA2"+_cFIL,"_SA2", .F. , .F. )
IndRegua("_SA2",  _cPath+"SA2"+_cFIL,"A2_COD",,,"Selecionando Registros...")
dbUseArea( .T. ,"DBFCDX", _cPath+"SZ2"+_cFIL,"_SZ2", .F. , .F. )
IndRegua("_SZ2",  _cPath+"SZ2"+_cFIL,"Z2_COD",,,"Selecionando Registros...")
dbUseArea( .T. ,"DBFCDX", _cPath+"SZ3"+_cFIL,"_SZ3", .F. , .F. )
IndRegua("_SZ3",  _cPath+"SZ3"+_cFIL,"Z3_COD",,,"Selecionando Registros...")

Dbselectarea('_SB0')
Zap
Dbselectarea('_SB1')
Zap
Dbselectarea('_SA2')
Zap
Dbselectarea('_SZ2')
Zap
Dbselectarea('_SZ3')
Zap
Return
/***************************************************************************/
Static Function _Atualiz()
Dbselectarea("TP2")
Dbgotop()
Procregua(Reccount())

While !Eof()

      _Cfila:=TP2->TP_FILIAL
      Abrefil()
      While _Cfila == TP2->TP_FILIAL

            _cForn  := TP2->TP_FORNECE
            _cLojA  := TP2->TP_LOJA
            _cNumped:= TP2->TP_NUMPED

            Dbselectarea("SC7")
            Dbsetorder(1)
            Dbseek(TP2->TP_FILIAL+TP2->TP_Numped,.t.)

            While SC7->C7_NUM == TP2->TP_Numped
                  Reclock("SC7",.F.)
                  Dbdelete()
                  Msunlock()
                  Dbskip()
            End-While

            ITEMP:=0
            Dbselectarea("TP2")
            While _Cfila == TP2->TP_FILIAL .And. TP2->TP_NUMPED == _cNumped

                  Incproc("ATUALIZANDO DADOS -> "+_CfILa+" "+_cNumped)
                  For C := 1 to 13
                      cCampo :="TP_GRADE"+Strzero(C,2)
                      cCampo1:="TP_QUANT"+Strzero(C,2)
                      IF !Empty(TP2->(FieldGet(FieldPos(cCampo))))
                         _cProduto :=TP2->TP_SEQ+Subs(TP2->TP_COR,1,3)+SUBS(TP2->(FieldGet(FieldPos(cCampo))),1,2)
                         GrvProd()
                      Endif
                      IF !Empty(TP2->(FieldGet(FieldPos(cCampo1))))
                         ITEMP:=ITEMP+1
                         // Posiciona primeiro no Cadastro do Produto.
                         DbSelectArea("SB1")
                         DbSetOrder(1)
                         DbSeek(xFilial("SB1")+_cProduto)
                         // Depois Grava o Pedido de Compra
                         Reclock("SC7",.T.)
                         SC7->C7_FILIAL  := TP2->TP_FILIAL
                         SC7->C7_TIPO    := 1
                         SC7->C7_ITEM    := STRZERO(ITEMP,2)
                         SC7->C7_PRODUTO := _cPRODUTO
                         SC7->C7_REFER   := TP2->TP_REFER
                         SC7->C7_UM      := SB1->B1_UM
                         SC7->C7_QUANT   := TP2->(FieldGet(FieldPos(cCampo1)))
                         SC7->C7_PRECO   := TP2->TP_PRCLQ
                         SC7->C7_TOTAL   := TP2->TP_PRCLQ * TP2->(FieldGet(FieldPos(cCampo1)))
                         SC7->C7_DATPRF  := TP2->TP_ENTREG
                         SC7->C7_LOCAL   := SB1->B1_LOCPAD
                         SC7->C7_FORNECE := TP2->TP_FORNECE
                         SC7->C7_LOJA    := TP2->TP_LOJA
                         SC7->C7_COND    := TP2->TP_COND
                         SC7->C7_FILENT  := TP2->TP_FILIAL
                         SC7->C7_EMISSAO := TP2->TP_EMISSAO
                         SC7->C7_NUM     := TP2->TP_NUMPED
                         SC7->C7_EMITIDO := "S"
                         SC7->C7_DESCRI  := TP2->TP_DESC
                         SC7->C7_ORIGEM  := "RCOMM01"
                         SC7->C7_IPI     := TP2->TP_IPI
                         SC7->C7_TPFRETE := "F"
                         Msunlock()

                         Dbselectarea("SC7")
                         _aStru := dbStruct()
                         _aEVal  := {}
                         For _nI:=1 to Len(_aStru)
                             Aadd(_aEVal,FieldGet(_nI))
                         Next _nI

                         Reclock("_TC7",.T.)
                            For _nI:=1 to Len(_aStru)
                                FieldPut(_nI,_aEVal[_nI])
                            Next _nI
                         Msunlock()
                      Endif
                  Next C
                  Dbselectarea("TP2")
                  Dbskip()
            End-While
            Dbselectarea("_SA2")
            IF !Dbseek(_cForn+_cloja)
               Dbselectarea("SA2")
               Dbsetorder(1)
               Dbseek(xFilial("SA2")+_cForn+_cLoja)
               _aStru := dbStruct()
               _aEVal  := {}
               For _nI:=1 to Len(_aStru)
                   Aadd(_aEVal,FieldGet(_nI))
               Next
               Dbselectarea("_SA2")
               Reclock("_SA2",.T.)
                  For _nI:=1 to Len(_aStru)
                      FieldPut(_nI,_aEVal[_nI])
                  Next
               Msunlock()
            Endif
      End-While
      Fechafil()
      Dbselectarea("TP2")
End-While
Dbselectarea("TP2")
Dbclosearea("TP2")
Return
/*****************************************************************/
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function AbreFil
Static Function AbreFil()

_CPATH:="\DADOSADV\"
_CPATHF:="\DADOSADV\FIL\"

_cFil := "010"              // _cFIL:= TP2->TP_FILIAL+"0"

//****************************************
//Eliminado para trabalhar apenas com 01 empresa e varias filiais
//If !File(_cPath+"SC7"+_cFIL+".DBF" )
//   MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SC7"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
//   Return .F.
//Endif
//If !File(_cPath+"SB2"+_cFIL+".DBF" )
//   MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SB2"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
//   Return .F.
//Endif
//****************************************
//If !File(_cPathF+"SC7"+_cFIL+".DBF" )
//   MsgStop( "Problemas ! Arquivo "+Right(_cPathF+"SC7"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
//   Return .F.
//Endif

//dbUseArea( .T. ,, _cPath+"SC7"+_cFIL,"_SC7", .F. , .F. )
//dbSetIndex(_cPath+"SC7"+_cFIL)
//dbUseArea( .T. ,, _cPath+"SB2"+_cFIL,"_SB2", .F. , .F. )
//dbSetIndex(_cPath+"SB2"+_cFIL)
dbUseArea( .T. ,"DBFCDX", _cPathF+"SC7"+_cFIL,"_TC7", .F. , .F. )
Dbselectarea('_TC7')
Zap
Return
/***********************************************************************/
Static Function FechaFil()
Dbselectarea("SC7")
Dbsetorder(1)
Dbselectarea("SB2")
Dbsetorder(1)
Dbselectarea("_TC7")
_TC7->( DbCloseArea())
Return
/********************************************************************/
Static Function GrvProd()

Dbselectarea("SB1")
//      Mudar Order sb1 para 7
Dbsetorder(7)
//MsgStop(xFILIAL("SB1")+_cForn+TP2->TP_SEQ)
Dbseek(xFILIAL("SB1")+_cForn+TP2->TP_SEQ)
If !Eof()
   Cdesc    := SB1->B1_DESC
   cGRD     := SB1->B1_cGRD
   cSEQCAD  := SB1->B1_cSEQ
   cSeqCad  := SB1->B1_REF
   cGRP     := SB1->B1_GRPMAR
   cSGRP    := SB1->B1_SGRPMAR
   cCGRP    := SB1->B1_CLASSE
   cTipo    := SB1->B1_TIPO
   cUN      := SB1->B1_UM
   cFornece := SB1->B1_PROC
   cTecido  := SB1->B1_TECIDO
   cPadraoT := SB1->B1_PADRAOT
   cManga   := SB1->B1_MANGA
   cGrife   := SB1->B1_GRIFFE
   cMercad  := SB1->B1_MERCAD
   cInverno := SB1->B1_INVERNO
   cFabric  := SB1->B1_PROC

   Reclock("SB1",.F.)
   REPLACE B1_PEDABE WITH SB1->B1_PEDABE+ TP2->(FieldGet(FieldPos(cCampo1)))
   REPLACE B1_CPAGTO WITH TP2->TP_CONDH
   MsUnLock()
   
EndIf

Dbselectarea("SB1")
DbSetorder(1)
Dbseek(xfilial("SB1")+_cProduto)
IF EOF()

   If Len(Trim(_cProduto)) == 11
      _CodProd := Trim(_cProduto)+"0"
      _cProduto := _CodProd
   Else
      _CodProd := Trim(_cProduto)+"0"
      MsgStop("Verifique o codigo gravado no produto: "+_CodProd+" "+cDesc)
   EndIf

   Dbselectarea("SB1")
   Reclock("SB1",.T.)
   REPLACE B1_DESC    WITH cDesc                 // Descricao do produto
   Replace B1_CGRD    With cgrd                  // Grade
   Replace B1_GRPMAR  With cGRP                  // Grupo
   Replace B1_SGRPMAR With cSGRP                 // Sub-Grupo
   Replace B1_CLASSE  With cCGRP                 // Comportamento
   Replace B1_REF     With SubStr(_cProduto,1,6) // Referencia
   Replace B1_TECIDO  With cTecido
   Replace B1_MANGA   With cManga
   Replace B1_PADRAOT With cPadraoT
   Replace B1_GRIFFE  With cGrife
   Replace B1_MERCAD  With cMercad
   Replace B1_UM      With cUN
   Replace B1_TIPO    With "PA"
   Replace B1_PROC    With TP2->TP_FORNECE
   Replace B1_LOJPROC With TP2->TP_LOJA
   Replace B1_LOCPAD  With "01"
   Replace B1_TE      With "001"
   Replace B1_TS      With "501"
   Replace B1_GRADE   With "S"
   Replace B1_cSEQ    With TP2->TP_SEQ           // Referencia
   Replace B1_PEDABE  With TP2->(FieldGet(FieldPos(cCampo1)))
   Replace B1_CPAGTO  With TP2->TP_CONDH
   Replace B1_CUSTD   With TP2->TP_PRCLQ
   Replace B1_UCOM    With TP2->TP_EMISSAO
   Replace B1_UPRC    With TP2->TP_PRCLQ
   Replace B1_COD     With _cProduto
   Replace B1_UREV    With TP2->TP_EMISSAO
   Replace B1_CODCOR  With SubStr(_cProduto,7,3)
   Replace B1_CODTAM  With SubStr(_cProduto,10,2)
   Replace B1_CPAGTO  With TP2->TP_CONDH
   Replace B1_CODBAR  With _cProduto
   Replace B1_INVERNO With cInverno
   Replace B1_FABRIC  With cFabric
   MsUnLock()
   Campos()
Else
   If Len(Trim(_cProduto)) == 11
      _CodProd := Trim(_cProduto)+SubStr(SB1->B1_COD,12,1)
      _cProduto := _CodProd
   Else
      _CodProd := Trim(_cProduto)+SubStr(SB1->B1_COD,12,1)
      MsgStop("Verifique o codigo gravado no produto: "+_CodProd+" "+cDesc)
   EndIf

   Reclock("SB1",.F.)
   Replace B1_DESC    With cDesc                 // Descricao do produto
   Replace B1_CGRD    With cgrd                  // Grade
   Replace B1_GRPMAR  With cGRP                  // Grupo
   Replace B1_SGRPMAR With cSGRP                 // Sub-Grupo
   Replace B1_CLASSE  With cCGRP                 // Comportamento
   Replace B1_REF     With SubStr(_cProduto,1,6) // Referencia
   Replace B1_TECIDO  With cTecido
   Replace B1_MANGA   With cManga
   Replace B1_PADRAOT With cPadraoT
   Replace B1_GRIFFE  With cGrife
   Replace B1_MERCAD  With cMercad
   Replace B1_UM      With cUN
   Replace B1_cSEQ    With TP2->TP_SEQ           // Referencia
   Replace B1_COD     With _cProduto
   Replace B1_INVERNO With cInverno
   Replace B1_FABRIC  With cFabric
   Replace B1_DTREFP1 With TP2->TP_EMISSAO
   Replace B1_PEDABE  With SB1->B1_PEDABE + TP2->(FieldGet(FieldPos(cCampo1)))
   Replace B1_CPAGTO  With TP2->TP_CONDH
   Replace B1_UCOM    With TP2->TP_EMISSAO
   Replace B1_UPRC    With TP2->TP_PRCLQ
   MsUnLock()
   Campos()

Endif

// Atualiza preco de venda do siga Loja ( Comentario Perinazzo )
//Dbselectarea("SB0")
//Dbsetorder(1)
//Dbseek(xFilial("SB0")+_cProduto)
//IF Eof()
//   Reclock("SB0",.T.)
//   SB0->B0_COD   := _cProduto
//   SB0->B0_PRV1  := TP2->TP_PRCVE
//   SB0->B0_DATA1 := TP2->TP_EMISSAO
//   Msunlock()
//Else
//   Reclock("SB0",.F.)
//   SB0->B0_PRV1  := TP2->TP_PRCVE
//   SB0->B0_DATA1 := TP2->TP_EMISSAO
//   Msunlock()
//Endif

Dbselectarea("SB2")
// Verificar se tira a atualizacao automatica do preco SB2->B2_CM1 ?
Dbsetorder(1)
Dbseek(TP2->TP_FILIAL+_cProduto+"01")
IF Eof()
   Reclock("SB2",.T.)
   SB2->B2_COD      := _cProduto
   SB2->B2_FILIAL   := TP2->TP_FILIAL
   SB2->B2_LOCAL    := "01"
   SB2->B2_SALPEDIN := TP2->(FieldGet(FieldPos(cCampo1)))
   MsUnLock()
Else
   Reclock("SB2",.F.)
   SB2->B2_SALPEDIN := SB2->B2_SALPEDIN + TP2->(FieldGet(FieldPos(cCampo1)))
   MsUnLock()
Endif

// ENVIA DADOS PARA FILIAIS

Dbselectarea("SB1")
IF !Dbseek(SB1->B1_COD)
   Dbselectarea("SB1")
   _aStru := dbStruct()
   _aEVal  := {}
   For _nI:=1 to Len(_aStru)
      Aadd(_aEVal,FieldGet(_nI))
   Next
   Dbselectarea("_SB1")
   Reclock("_SB1",.T.)
      For _nI:=1 to Len(_aStru)
          FieldPut(_nI,_aEVal[_nI])
      Next
   Msunlock()
Endif
//MsgStop("Linha 576")
Dbselectarea("_SB0")
IF !Dbseek(SB0->B0_COD)
    Dbselectarea("SB0")
    _aStru := dbStruct()
    _aEVal  := {}
    For _nI:=1 to Len(_aStru)
        Aadd(_aEVal,FieldGet(_nI))
    Next
    Dbselectarea("_SB0")
    Reclock("_SB0",.T.)
    For _nI:=1 to Len(_aStru)
        FieldPut(_nI,_aEVal[_nI])
    Next
    Msunlock()
Endif
Dbselectarea("_SZ2")
IF !Dbseek(TP2->TP_CGRD)

    Dbselectarea("SZ2")
    Dbsetorder(1)
    Dbseek(xFilial("SZ2")+TP2->TP_CGRD)

    _aStru := dbStruct()
    _aEVal  := {}
    For _nI:=1 to Len(_aStru)
        Aadd(_aEVal,FieldGet(_nI))
    Next
    Dbselectarea("_SZ2")
    Reclock("_SZ2",.T.)
    For _nI:=1 to Len(_aStru)
        FieldPut(_nI,_aEVal[_nI])
    Next
    Msunlock()
Endif
Dbselectarea("_SZ3")
IF !Dbseek(TP2->TP_COR)
    Dbselectarea("SZ3")
    Dbsetorder(1)
    Dbseek(xFilial("SZ3")+TP2->TP_COR)
    _aStru  := dbStruct()
    _aEVal  := {}
    For _nI := 1 to Len(_aStru)
        Aadd(_aEVal,FieldGet(_nI))
    Next
    Dbselectarea("_SZ3")
    Reclock("_SZ3",.T.)
    For _nI := 1 to Len(_aStru)
        FieldPut(_nI,_aEVal[_nI])
    Next
    Msunlock()
EndIf

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
    
//    DbSetOrder(_Tabelas[_n,5])
    RecLock(_Tabelas[_n,5],.F.)
    FieldPut(FieldPos(_Tabelas[_n,4]),_Var)
    MsUnLock()

Next _n

Return

