#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Rcoma05()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CNUMPED,ATEMP,CARQ,CNFOR,C,CCAMPO")
SetPrvt("CCAMPO1,CFIL,_CONDH,ASVALIAS,I,J")
SetPrvt("AREGISTROS,")


//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±³Fun‡ao    ³ RCOMA05  ³ Autor ³ Emerson Augusto       ³ Data ³ 07/12/99 ³±±
//±±³Descri‡…o ³ Alteracao de Pedido de Compras Por Grade                   ³±±
//±±³ Uso      ³ SIGACOM                                                    ³±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß


_ValidPerg()
If !pergunte("COMA05",.T.)
   Return
EndIf

_cNumped:=MV_PAR01

aTemp:={}
AADD(atemp,{"TP_Filial"  ,"C", 2,0})
AADD(atemp,{"TP_Repete"  ,"C", 2,0})
AADD(atemp,{"TP_Dfil"    ,"C",10,0})
AADD(atemp,{"TP_Numped"  ,"C", 6,0})
AADD(atemp,{"TP_Pedido"  ,"C", 8,0})
AADD(atemp,{"TP_FORNECE" ,"C", 6,0})
AADD(atemp,{"TP_LOJA"    ,"C", 2,0})
AADD(atemp,{"TP_Entreg"  ,"D", 8,0})
AADD(atemp,{"TP_EJentr"  ,"D", 8,0})
AADD(atemp,{"TP_DATR"    ,"C", 2,0})
AADD(atemp,{"TP_Emissao" ,"D", 8,0})
AADD(atemp,{"TP_DCOR"    ,"C",10,0})
AADD(atemp,{"TP_COR"     ,"C", 3,0})
AADD(atemp,{"TP_ItemP"   ,"C", 2,0})
AADD(atemp,{"TP_ItemD"   ,"C", 2,0})
AADD(atemp,{"TP_Refer"   ,"C",20,0})
AADD(atemp,{"TP_SEQ"     ,"C", 6,0})
AADD(atemp,{"TP_DESC"    ,"C",30,0})
AADD(atemp,{"TP_CGrd"    ,"C", 2,0})
AADD(atemp,{"TP_CUSTO"   ,"N",14,2})
AADD(atemp,{"TP_IPI"     ,"N", 6,2})
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
AADD(atemp,{"TP_QGRTOT"  ,"N", 6,0})
AADD(atemp,{"TP_QGRENT"  ,"N", 6,0})
AADD(atemp,{"TP_QGRFAL"  ,"N", 6,0})
AADD(atemp,{"TP_BENEF"   ,"N", 6,2})
AADD(atemp,{"TP_CBENEF"  ,"N", 1,0})
AADD(atemp,{"TP_CONDH"   ,"C",70,0})
AADD(atemp,{"TP_COND"    ,"C",15,0})
AADD(atemp,{"TP_COMPL"   ,"C", 4,0})
AADD(atemp,{"TP_SIT"     ,"C", 1,0})
AADD(atemp,{"TP_OBS"     ,"C",240,0})

cArq := CriaTrab(atemp,.T.)
dbUseArea(.T.,,cArq,"TP2")

Dbselectarea("SZ4")
DbsetoRder(2)
Dbseek(xFilial("SZ4")+_cNUMPED,.T.)

While !EOF() .AND. SZ4->Z4_NUMPED == _cNUMPED

      DbselectArea("SA2")
      Dbsetorder(1)
      Dbseek(xfilial("SA2")+SZ4->Z4_FORNECE+SZ4->Z4_LOJA)
      cNFOR:=SA2->A2_COD+" - "+SA2->A2_NOME+" / "+SA2->A2_NREDUZ
      Dbselectarea("SZ3")
      Dbsetorder(1)
      Dbseek(Xfilial("SZ3")+SZ4->Z4_COR)

      For C := 1 to 20
          IF !Empty(SZ4->(FieldGet(FieldPos("Z4_FIL"+StrZero(c,2)))))
             cFil:=SZ4->(FieldGet(FieldPos("Z4_FIL"+StrZero(c,2))))+SPACE(4)
             Dbselectarea("SX5")
             dbsetorder(1)
             Dbseek(xFILIAL("SX5")+"AA"+cFil)
             
             DBSELECTAREA("TP2")
             Reclock("TP2",.T.)
             TP2->TP_FILIAL  := SZ4->(FieldGet(FieldPos("Z4_FIL"+StrZero(c,2))))
             TP2->TP_ENTREG  := SZ4->(FieldGet(FieldPos("Z4_ENT"+StrZero(c,2))))
             TP2->TP_REPETE  := SZ4->(FieldGet(FieldPos("Z4_RPT"+StrZero(c,2))))
             TP2->TP_DFIL    := ALLTRIM(SX5->X5_DESCRI)
             TP2->TP_FORNECE := SZ4->Z4_Fornece
             TP2->TP_LOJA    := SZ4->Z4_LOJA
             TP2->TP_Pedido  := SZ4->Z4_Pedido
             TP2->TP_NUMPED  := SZ4->Z4_NUMPED
             TP2->TP_ITEMP   := SZ4->Z4_ITEMP
             TP2->TP_ITEMD   := SZ4->Z4_ITEMD
             TP2->TP_COR     := SZ4->Z4_COR
             TP2->TP_DCOR    := SUBS(SZ3->Z3_DESC,1,10)
             TP2->TP_OBS     := SZ4->Z4_OBS
             TP2->TP_Refer   := SZ4->Z4_REF
             TP2->TP_SEQ     := SZ4->Z4_SEQ
             TP2->TP_DESC    := SZ4->Z4_DESC
             TP2->TP_CGrd    := SZ4->Z4_CGRD
             TP2->TP_CUSTO   := SZ4->Z4_PRCCST
             TP2->TP_IPI     := SZ4->Z4_IPI
             TP2->TP_Desco1  := SZ4->Z4_DESCO1
             TP2->TP_Desco2  := SZ4->Z4_DESCO2
             TP2->TP_Desco3  := SZ4->Z4_DESCO3
             TP2->TP_Desco4  := SZ4->Z4_DESCO4
             TP2->TP_Desco5  := SZ4->Z4_DESCO5
             TP2->TP_Desco6  := SZ4->Z4_DESCO6
             TP2->TP_Desco7  := SZ4->Z4_DESCO7
             TP2->TP_Acres   := SZ4->Z4_ACRFIN
             TP2->TP_AcresC  := SZ4->Z4_ACRFINC
             TP2->TP_PrcLq   := SZ4->Z4_PRCLIQ
             TP2->TP_Prcve   := SZ4->Z4_PRCVEN
             TP2->TP_Marge   := SZ4->Z4_MARGEM
             TP2->TP_Grade1  := SZ4->Z4_IGRD01
             TP2->TP_Quant1  := SZ4->Z4_QGRD01
             TP2->TP_Grade2  := SZ4->Z4_IGRD02
             TP2->TP_Quant2  := SZ4->Z4_QGRD02
             TP2->TP_Grade3  := SZ4->Z4_IGRD03
             TP2->TP_Quant3  := SZ4->Z4_QGRD03
             TP2->TP_Grade4  := SZ4->Z4_IGRD04
             TP2->TP_Quant4  := SZ4->Z4_QGRD04
             TP2->TP_Grade5  := SZ4->Z4_IGRD05
             TP2->TP_Quant5  := SZ4->Z4_QGRD05
             TP2->TP_Grade6  := SZ4->Z4_IGRD06
             TP2->TP_Quant6  := SZ4->Z4_QGRD06
             TP2->TP_Grade7  := SZ4->Z4_IGRD07
             TP2->TP_Quant7  := SZ4->Z4_QGRD07
             TP2->TP_Grade8  := SZ4->Z4_IGRD08
             TP2->TP_Quant8  := SZ4->Z4_QGRD08
             TP2->TP_Grade9  := SZ4->Z4_IGRD09
             TP2->TP_Quant9  := SZ4->Z4_QGRD09
             TP2->TP_Grade10 := SZ4->Z4_IGRD10
             TP2->TP_Quant10 := SZ4->Z4_QGRD10
             TP2->TP_Grade11 := SZ4->Z4_IGRD11
             TP2->TP_Quant11 := SZ4->Z4_QGRD11
             TP2->TP_Grade12 := SZ4->Z4_IGRD12
             TP2->TP_Quant12 := SZ4->Z4_QGRD12
             TP2->TP_Grade13 := SZ4->Z4_IGRD13
             TP2->TP_Quant13 := SZ4->Z4_QGRD13
             TP2->TP_QGRTOT  := SZ4->Z4_QGRTOT
             TP2->TP_QGRFAL  := SZ4->Z4_QGRTOT
             TP2->TP_BENEF   := SZ4->Z4_DBENEF
             TP2->TP_CBENEF  := SZ4->Z4_CBENEF
             TP2->TP_EMISSAO := SZ4->Z4_DATA
             TP2->TP_CONDH   := SZ4->Z4_CONDH
             TP2->TP_COND    := SZ4->Z4_COND
             TP2->TP_COMPL   := SZ4->Z4_COMPL
             TP2->TP_SIT     :="A"
             Msunlock()
             _CONDH:= SZ4->Z4_CONDH
             Dbselectarea("SZ4")
          ELSE
             C:=20
             Dbselectarea("SZ4")
          Endif
      Next C
      Dbselectarea("SZ4")
      Dbskip()
End-While
ExecBLOCK("ECOMA05A",.F.,.F.)
dbselectarea("TP2")
DBClosearea("TP2")
RETURN
/**************************************************************************/
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _ValidPerg
Static Function _ValidPerg()

aSvAlias:={Alias(),IndexOrd(),Recno()}
i:=0
j:=0

aRegistros:={}
dbSelectArea("SX1")
dbSeek("COMA05")

If !Found()
    AADD(aRegistros,{"COMA05","01","Numero Pedido      ?","mv_ch1","C",6,0,0,"G","","mv_par01","","","","","","","","","","","","","","","SZ4"})
    For i:=1 to Len(aRegistros)
	RecLock("SX1",.T.)
	For j:=1 to FCount()
	    FieldPut(j,aRegistros[i,j]) 
	    Next
	MsUnlock()
    Next        
Endif
Return
