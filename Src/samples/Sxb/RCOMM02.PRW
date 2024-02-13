#include "rwmake.ch"       

User Function Rcomm02()    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CFILT,_CPATHE,_CPATH,ATEMP,_X,CARQ")
SetPrvt("C,_CFIL,_CFILA,CCAMPO,CCAMPO1,_CPRODUTO")

//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±³Fun‡ao    ³ RCOMM02  ³ Autor ³ Emerson Augusto       ³ Data ³ 17/01/00 ³±±
//±±³Descri‡…o ³ Programa para gerar Integracao de LOJA  / COMPRAS          ³±±
//±±³ Uso      ³ Casa das Cuecas                                            ³±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

@ 96,42 TO 323,505 DIALOG oDlg5 TITLE "Atualiza dados Enviados Pelas Lojas"
@ 8,10 TO 84,222
@ 91,168 BMPBUTTON TYPE 1 ACTION _Rotina()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 91,168 BMPBUTTON TYPE 1 ACTION Execute(_Rotina)
@ 91,196 BMPBUTTON TYPE 2 ACTION Close(oDlg5)
@ 23,14 SAY "Este programa Atualiza dados  Compras / Estoque "
@ 43,14 SAY "Conforme dados Enviados das Lojas "
ACTIVATE DIALOG oDlg5
Return nil
/***********************************************************************/
Static Function _Rotina()

Processa({|lEnd| cApSN1()})

dbSelectArea("SZ4")
dbSetOrder(1)
dbSelectArea("SB1")
dbSetOrder(1)
dbSelectArea("SA2")
dbSetOrder(1)
Return
/************************************************************************/
Static Function cApSN1()
_cFilt:={}
Dbselectarea("SM0")
Dbgotop()
While !Eof()
   AADD(_cFILt,SM0->M0_CODIGO)
   Dbskip()
Enddo

_CPATHE:="\DADOSADV\ESC\"
_CPATH:="\DADOSADV\"

// CRIA TEMPORORARIO POR FILIAL

aTemp:={}
AADD(atemp,{"TP_Filial" ,"C", 2,0})
AADD(atemp,{"TP_Numped" ,"C", 6,0})
AADD(atemp,{"TP_FORNECE","C", 6,0})
AADD(atemp,{"TP_LOJA"   ,"C", 2,0})
AADD(atemp,{"TP_Entreg" ,"D", 8,0})
AADD(atemp,{"TP_Emissao","D", 8,0})
AADD(atemp,{"TP_COR"    ,"C", 3,0})
AADD(atemp,{"TP_DESC"   ,"C",30,0})
AADD(atemp,{"TP_Refer"  ,"C",20,0})
AADD(atemp,{"TP_SEQ"    ,"C", 6,0})
AADD(atemp,{"TP_CGrd"   ,"C", 2,0})
AADD(atemp,{"TP_CUSTO"  ,"N",14,2})
AADD(atemp,{"TP_PrcLq"  ,"N", 6,2})
AADD(atemp,{"TP_Prcve"  ,"N", 6,2})
AADD(atemp,{"TP_QTDE"   ,"N", 6,0})
For _x := 1 To 13
    AADD(atemp,{"TP_Grade"+StrZero(_x,2),"C", 2,0})
    AADD(atemp,{"TP_Quant"+StrZero(_x,2),"N", 4,0})
Next _x
AADD(atemp,{"TP_NOTA"   ,"C", 6,0})
AADD(atemp,{"TP_SERIE"  ,"C", 3,0})
AADD(atemp,{"TP_EMISNF" ,"D", 8,0})
AADD(atemp,{"TP_VALNF"  ,"N",14,2})
cArq := CriaTrab(atemp,.T.)
dbUseArea(.T.,"DBFCDX",cArq,"TP2")

For c := 1 To len(_CfilT)

    _cFIL:= _cFilt[C]+"0"

    If File("_cPathE+'SZL'+_cFIL+'.DBF'" )
       dbUseArea( .T. ,"DBFCDX", _cPathE+"SZL"+_cFIL,"_SZL", .F. , .F. )
       Dbselectarea("_SZL")
       Dbgotop()
       While !eof()
             Dbselectarea("TP2")
             Reclock("TP2",.T.)
             TP2->TP_FILIAL   := _SZL->ZL_FILIAL
             TP2->TP_ENTREG   := _SZL->ZL_DATA
             TP2->TP_FORNECE  := _SZL->ZL_Fornece
             TP2->TP_LOJA     := "01" //_SZL->ZL_LOJA
             TP2->TP_NUMPED   := _SZL->ZL_PEDIDO
             TP2->TP_COR      := Subs(_SZL->ZL_PRODUTO,10,3)
             TP2->TP_Refer    := _SZL->ZL_REFER
             TP2->TP_SEQ      := Subs(_SZL->ZL_PRODUTO,1,6)
             TP2->TP_CGrd     := _SZL->ZL_CGRD
             For _n := 1 to 13
                 FieldPut(FiedlPos("TP_GRADE"+StrZero(_n,2)),_SZL->(FieldGet(FieldPos("ZL_IGRD"+StrZero(_n,2)))))
                 FieldPut(FiedlPos("TP_QUANT"+StrZero(_n,2)),_SZL->(FieldGet(FieldPos("ZL_QGRD"+StrZero(_n,2)))))
             Next _n         
//             TP2->TP_Grade01  := _SZL->ZL_IGRD01
//             TP2->TP_Quant01  := _SZL->ZL_QGRD01
//             TP2->TP_Grade02  := _SZL->ZL_IGRD02
//             TP2->TP_Quant02  := _SZL->ZL_QGRD02
//             TP2->TP_Grade03  := _SZL->ZL_IGRD03
//             TP2->TP_Quant03  := _SZL->ZL_QGRD03
//             TP2->TP_Grade04  := _SZL->ZL_IGRD04
//             TP2->TP_Quant04  := _SZL->ZL_QGRD04
//             TP2->TP_Grade05  := _SZL->ZL_IGRD05
//             TP2->TP_Quant05  := _SZL->ZL_QGRD05
//             TP2->TP_Grade06  := _SZL->ZL_IGRD06
//             TP2->TP_Quant06  := _SZL->ZL_QGRD06
//             TP2->TP_Grade07  := _SZL->ZL_IGRD07
//             TP2->TP_Quant07  := _SZL->ZL_QGRD07
//             TP2->TP_Grade08  := _SZL->ZL_IGRD08
//             TP2->TP_Quant08  := _SZL->ZL_QGRD08
//             TP2->TP_Grade09  := _SZL->ZL_IGRD09
//             TP2->TP_Quant09  := _SZL->ZL_QGRD09
//             TP2->TP_Grade10  := _SZL->ZL_IGRD10
//             TP2->TP_Quant10  := _SZL->ZL_QGRD10
//             TP2->TP_Grade11  := _SZL->ZL_IGRD11
//             TP2->TP_Quant11  := _SZL->ZL_QGRD11
//             TP2->TP_Grade12  := _SZL->ZL_IGRD12
//             TP2->TP_Quant12  := _SZL->ZL_QGRD12
//             TP2->TP_Grade13  := _SZL->ZL_IGRD13
//             TP2->TP_Quant13  := _SZL->ZL_QGRD13
             TP2->TP_NOTA     := _SZL->ZL_NOTA
             TP2->TP_SERIE    := _SZL->ZL_SERIE
             TP2->TP_EMISNF   := _SZL->ZL_EMISNF
             TP2->TP_VALNF    := _SZL->ZL_VALOR
             TP2->TP_QTDE     := _SZL->ZL_QTDE
             Msunlock()
             Dbselectarea("_SZL")
             Dbskip()
       End-While
       Dbselectarea("_SZL")
       Zap
       _SZL->(DbClosearea())
    Endif
Next C

// COMECA ATUALIZAR FILIAS

Dbselectarea("TP2")
IndRegua("TP2",cArq,"TP_FILIAL+TP_NUMPED",,,"Selecionando Pedidos (Geral)...")
Dbgotop()
Procregua(Reccount())

While !Eof()

      _Cfila:=TP2->TP_FILIAL

      //BUSCA FIL (ARQUIVOS)

//      Abrefilc()

      Dbselectarea("TP2")

      While _Cfila == TP2->TP_FILIAL
 
            Incproc("ATUALIZANDO DADOS -> "+_CfILa+" "+TP2->TP_Numped)

            For C := 1 to 13
                cCampo :="TP2->TP_GRADE"+Strzero(C,2)
                cCampo1:="TP2->TP_QUANT"+Strzero(C,2)
                IF !Empty(&cCampo1)
                   _cProduto :=Subs(TP2->TP_SEQ,1,6)+Subs(TP2->TP_COR,1,3)+SUBS(&cCampo,1,2)

                   Dbselectarea("SB1")
                   //      Mudar Order sb1 para 7
                   DbSetorder(6)
                   Dbseek(xFILIAL("SB1")+TP2->TP_FORNECE+TP2->TP_SEQ)
                   IF !EOF()
                      Reclock("SB1",.F.)
                      SB1->B1_PEDABE := SB1->B1_PEDABE - &cCampo1
                      Msunlock()
                   Endif
 
                   Dbselectarea("SB2")
                   Dbsetorder(1)
                   Dbseek(TP2->TP_FILIAL+_cProduto+"01")
                   IF !Eof()
                      Reclock("SB2",.F.)
                      SB2->B2_SALPEDIN := SB2->B2_SALPEDIN - &cCampo1
                      SB2->B2_QATU     := SB2->B2_QATU     + &cCampo1
                      Msunlock()
                   Endif

                   DbSelectarea("SC7")
                   Dbsetorder(10)
                   Dbseek(TP2->TP_Filial+TP2->TP_NUMPED+_Cproduto+TP2->TP_Refer)
                   IF !EOF()
                      Reclock("SC7",.T.)
                      SC7->C7_QJUE     := SC7->C7_QJUE + &cCampo1
                      IF SC7->C7_QJUE == SC7->C7_QUANT
                         SC7->C7_ENCER :="E"
                      Endif
                      SC7->C7_DATPRF   := TP2->TP_ENTREG
                      Msunlock()
                   Endif
 
                   Dbselectarea("SD1")
                   Dbsetorder(1)
                   Dbseek(TP2->TP_FILIAL+TP2->TP_NOTA+TP2->TP_SERIE+TP2->TP_FORNECE+_cProduto)
                   IF EOF()
                      Reclock("SD1",.T.)
                      SD1->D1_FILIAL  :=SC7->C7_FILIAL
                      SD1->D1_COD     :=SC7->C7_PRODUTO
                      SD1->D1_DESC    :=SC7->C7_DESC1  // VERIFICAR
                      SD1->D1_QUANT   := &cCampo1
                      SD1->D1_VUNIT   :=SC7->C7_PRECO
                      SD1->D1_TOTAL   := &cCampo1 * SC7->C7_PRECO
                      SD1->D1_CONTA   :=SC7->C7_CONTA
                      SD1->D1_CC      :=SC7->C7_CC
                      SD1->D1_PEDIDO  :=SC7->C7_NUM
                      SD1->D1_ITEMPC  :=SC7->C7_ITEM
                      SD1->D1_FORNECE :=SC7->C7_FORNECE
                      SD1->D1_LOJA    :=SC7->C7_LOJA
                      SD1->D1_LOCAL   :="01"
                      SD1->D1_DOC     :=TP2->TP_NOTA
                      SD1->D1_EMISSAO :=TP2->TP_EMISSAO
                      SD1->D1_DTDIGIT :=TP2->TP_DATA
                      SD1->D1_TIPO    :="N"
                      SD1->D1_SERIE   :=TP2->TP_SERIE
                  //    SD1->D1_TP      :=SB1->B1_TIPO
                  //    SD1->D1_NUMSEQ  :=ProxNum("SD1")
                      SD1->D1_ITEM    :=SC7->C7_ITEM
                      SD1->D1_BASEICM :=SD1->D1_TOTAL
                      SD1->D1_VALDESC :=SC7->C7_VLDESC
                  //    SD1->D1_CLASFIS:=SB1->B1_CLASFIS
                  //    SD1->D1_VALIPI :=nValIpi
                  //    SD1->D1_VALICM :=nValIcm
                  //    SD1->D1_TES    :=cTes
                  //    SD1->D1_CF     :=cCfo
                  //    SD1->D1_UM     := SB1->B1_UM
                      Msunlock()
                      Dbselectarea("SF1")
                      DbSetOrder(1)
                      RecLock("SF1",.T.)
                      SF1->F1_FILIAL  :=cFILIAL
                      SF1->F1_NUMSOLI :=cNum
                      SF1->F1_DOC     :=cDocum
                      SF1->F1_SERIE   :=cSERIE
                      SF1->F1_FORNECE :=cFORNECE
                      SF1->F1_LOJA    :=cLoja
                      SF1->F1_COND    :=cCond
                      SF1->F1_DUPL    :=cDocum
                      SF1->F1_EMISSAO :=dEmisdoc
                      SF1->F1_EST     :=SA2->A2_EST
                      SF1->F1_FRETE   :=nFRETE
                      SF1->F1_DESPESA :=nDESPESA
                      SF1->F1_BASEICM :=nBasicmT
                      SF1->F1_BASEIPI :=nBasipiT
                    //  SF1->F1_VALIPI  :=nVaLipiT
                    //  SF1->F1_VALICM  :=nValicmT
                      SF1->F1_VALMERC :=nValmerc
                      SF1->F1_VALBRUT :=nValmerc
                      SF1->F1_TIPO    :="N"
                      SF1->F1_DESCONT :=nValDesc
                      SF1->F1_DTDIGIT :=dDatabase
                      SF1->F1_ESPECIE :="NF"
                    //  SF1->F1_CPROVA  :="002002"
                      MsUnLock()
                      dbCommit()
                   Endif
                Endif
            Next C
            Dbselectarea("TP2")
            Dbskip()
      End-While
//      Fechafil()
      Dbselectarea("TP2")
End-While
Dbselectarea("TP2")
Dbclosearea("TP2")
Return
/**********************************************************************/
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function AbreFilc
Static Function AbreFilc()

_CPATH:="\DADOSADV\"

//_cFIL:= TP2->TP_FILIAL+"0"
_cFIL:= "010"

If !File(_cPath+"SC7"+_cFIL+".DBF" )
   MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SC7"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
   Return .F.
Endif

If !File(_cPath+"SB2"+_cFIL+".DBF" )
   MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SB2"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
   Return .F.
Endif

If !File(_cPath+"SD1"+_cFIL+".DBF" )
   MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SD1"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
   Return .F.
Endif

If !File(_cPath+"SF1"+_cFIL+".DBF" )
   MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SF1"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
   Return .F.
Endif

dbUseArea( .T. ,"DBFCDX", _cPath+"SC7"+_cFIL,"_SC7", .F. , .F. )
dbSetIndex(_cPath+"SC7"+_cFIL)
dbUseArea( .T. ,"DBFCDX", _cPath+"SB2"+_cFIL,"_SB2", .F. , .F. )
dbSetIndex(_cPath+"SB2"+_cFIL)
dbUseArea( .T. ,"DBFCDX", _cPath+"SD1"+_cFIL,"_SD1", .F. , .F. )
dbSetIndex(_cPath+"SD1"+_cFIL)
dbUseArea( .T. ,"DBFCDX", _cPath+"SF1"+_cFIL,"_SF1", .F. , .F. )
dbSetIndex(_cPath+"SF1"+_cFIL)

Return
/************************************************************************/
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function FechaFilc
Static Function FechaFilc()
Dbselectarea("_SC7")
Dbsetorder(1)
Dbselectarea("_SB2")
Dbsetorder(1)
Dbselectarea("_SD1")
Dbsetorder(1)
Dbselectarea("_SF1")
Dbsetorder(1)
_SB2->( DbClearInd())
_SB2->( DbCloseArea())
_SC7->( DbClearInd())
_SC7->( DbCloseArea())
_SD1->( DbClearInd())
_SD1->( DbCloseArea())
_SF1->( DbClearInd())
_SF1->( DbCloseArea())
return
