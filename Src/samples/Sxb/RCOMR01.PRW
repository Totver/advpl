#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Rcomr01()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//***********************************************************************
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//***********************************************************************

SetPrvt("CBTXT,TITULO,CDESC1,CDESC2,CDESC3,TAMANHO")
SetPrvt("LIMITE,CSTRING,NVALOR1,CARACTER,NVALOR2,NVALOR3")
SetPrvt("ARETURN,NOMEPROG,ALINHA,NLASTKEY,CPERG,CTABTES")
SetPrvt("LI,NTIPO,WNREL,LEND,CBCONT,CABEC1")
SetPrvt("CABEC2,CPICT,M_PAG,AGRD,AQTD,AQTDP")
SetPrvt("AQTDT,_TOTLIQ,_TOTCST,_TOTITEM,_TOTF,CIND1")
SetPrvt("CCHAVE1,AFILIAIS,TOTANT,A,CFIL,COL")
SetPrvt("CITEMP,FLAGP,_BENEF,C,CCAMPO,CCAMPO1")
SetPrvt("GR,NPRCT,NPRCL,NQTDT,ASTRU,CARQ")
SetPrvt("TOTF,ASVALIAS,CNFOR,I,J,AREGISTROS")

/*/
*****************************************************************************
**³Fun‡…o    ³ ECOMA04I ³ Autor ³ Emerson Augusto	³ Data ³ 11/10/99     ³**
**³Descri‡…o ³ Impressao de pedido  de compra				              ³**
**³USO       ³ Casa das Cuecas                                            ³**
*****************************************************************************
/*/

//****************************************************************
//* Define Variaveis						                     *
//****************************************************************
CbTxt    := ""
titulo   := "PEDIDO DE COMPRA"
cDesc1   := "Este relatorio emitir  Pedido de Compras "
cDesc2   := "conf. Parametros "
cDesc3   := ""
tamanho  := "G"
limite   := 80
cString  := "SZ4"
nValor1  := 0
Caracter := 15
nValor2  := 0
nValor3  := 0
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog :="RCOMR01"
aLinha   := { }
nLastKey := 0
cPerg    :="COMR01"
cTabTes  :=""

//^***************************************************************
//* Variaveis utilizadas para Impressao do Cabecalho e Rodape	 *
//****************************************************************
cbtxt	 := SPACE(10)
li       := 90

//****************************************************************
//* Verifica as perguntas selecionadas				             *
//****************************************************************
_ValidPerg()
pergunte("COMR01",.T.)
//****************************************************************
//* Variaveis utilizadas para parametros			             *
//* mv_par01	      // do Pedido				                 *
//****************************************************************

nTipo    := IIF(aReturn[4]==1,15,18)

//****************************************************************
//* Envia controle para a funcao SETPRINT			             *
//****************************************************************
wnrel    := "RCOMR01"
wnrel    := SetPrint(cString,wnrel,,titulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho)

SetDefault(aReturn,cString)

If nLastKey==27
   Set Filter to
   Return
Endif

lEnd := .F.

RptStatus({|| C590Imp()},Titulo)// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>     RptStatus({|| Execute(C590Imp)},Titulo)
Return
/**********************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>     Function C590Imp
Static Function C590Imp()

CbTxt  := ""
CbCont := ""
cabec1 := ""
cabec2 := ""
limite := 80
cPict  := "@E) 999,999,999,999.99"
nTipo  := IIF(aReturn[4]==1,15,18)

//****************************************************************
//* Variaveis utilizadas para Impressao do Cabecalho e Rodape	 *
//****************************************************************
cbtxt   := SPACE(10)
cbcont  := 00
li      := 90
M_pag   := 0
aGRD    := {}
aQTD    := {}
aQTDP   := {}
aQTDT   := {}
_TOTLIQ := 0
_TOTCST := 0
_TOTITEM:= 0
_TOTF   := 0

Montaped()

aSort(aGRD)

cInd1  :=CriaTrab("",.F.)
cChave1:="STR(DD_TOTAL)+DD_FILIAL"
Dbselectarea("DDD")
IndRegua("DDD",cInd1,cChave1,,,"Selecionando Registros...")
Dbgotop()
Setregua(Reccount())

While !EOF()

      If lEnd
         @Prow()+1,001 PSAY "CANCELADO PELO OPERADOR"
         Exit
      Endif

      afiliais:={}
      ToTant:=DDD->DD_TOTAL

      While !EOF() .AND. DDD->DD_TOTAL == ToTanT

            AADD(aFiliais,DDD->DD_FILIAL)
            Dbskip()
      End-While

      For a:= 1 to len(aFILIAIS)

          incregua()

          IF li > 80
             Marcab()
          Endif

          cFil:=aFILIAIS[A]+SPACE(4)

          Dbselectarea("SX5")
          dbsetorder(1)
          Dbseek(xFILIAL("SX5")+"AA"+cFil)
          li:=li+1
          IF a == 1
             @ LI,00 PSAY "Dados Abaixo Referem-se a(s) filial(ais) "
          Endif
          @ lI,46  PSAY aFiliais[A] +" - "
          @ LI,53  PSAY  SX5->X5_DESCRI
      Next a
      Li:=li+1
      @ Li,00 PSAY REPLICATE("-",132)
      li:=li+1
      @ LI,43 PSAY "GRADE ->"
      col:=56
      For a := 1 to Len(aGRD)
          @ li,col PSAY aGrd[a]
          Col:=col+4
      Next a

      Dbselectarea("PED")
      Dbseek(Afiliais[1],.t.)

      While !EOF() .AND. PED->PD_FILIAL == aFiliais[1]

            cITEMP :=PED->PD_ITEMP+PED->PD_COD
            Flagp:=.F.
 
            While !EOF() .AND. PED->PD_ITEMP+PED->PD_COD == cITEMP   .AND. PED->PD_FILIAL == aFiliais[1]

                  Dbselectarea("SZ4")
                  Dbsetorder(2)
                  Dbseek(xFILIAL("SZ4")+PED->PD_PEDIDO+PED->PD_ITEMP+PED->PD_ITEMD)
 
                  IF Flagp == .F.
                     LI:=LI+1
                     @ LI,01 PSAY SZ4->Z4_SEQ
                     @ LI,05 PSAY SZ4->Z4_DESC
                     flagp:=.t.
                  Endif
                  Do Case
                  Case SZ4->Z4_CBENEF == 1
                       _Benef:="A"
                  Case SZ4->Z4_CBENEF == 2
                       _Benef:="B"
                  Case SZ4->Z4_CBENEF == 3
                       _Benef:="C"
                  End Case
                  For c := 1 to 14
                      cCampo :="Z4_IGRD"+Strzero(C,2)
                      cCampo1:="Z4_QGRD"+Strzero(C,2)
                      IF !Empty(SZ4->(FieldGet(FieldPos(cCampo))))
                         GR      :=aScan(aGrd,SZ4->(FieldGet(FieldPos(cCampo))))
                         aQTD[GR]:=SZ4->(FieldGet(FieldPos(cCampo1)))
                      Endif
                  Next c
                  nPRCT:=SZ4->Z4_PRCCST
                  nPRCL:=SZ4->Z4_PRCLIQ
                  nQTDT:=SZ4->Z4_QGRTOT
                  li:=li+1
                  IF li > 80
                     Marcab()
                  Endif
                  Dbselectarea("SZ3")
                  Dbsetorder(1)
                  Dbseek(Xfilial("SZ3")+SZ4->Z4_COR)
                  @ LI,05 PSAY SUBS(SZ4->Z4_REF,1,20)+" - "+SUBS(SZ3->Z3_DESC,1,10)+"  "+"("+_benef+")"
                  col:=53
                  For a := 1 to Len(aQTD)
                      IF aQTD[A] > 0
                         @ li,col PSAY aQTD[A] PICTURE "@E 999"
                      Endif
                      aQTdP[A]:= aQTDP[A] + aQTD[A]
                      aQtd[A] :=0
                      Col:=col+4
                  Next a
                  @ LI,111 PSAY nQtdt PICTURE "@E 9999"
                  @ LI,117 PSAY nPrct PICTURE "@E 999.99"
                  @ LI,125 PSAY nPrcL PICTURE "@E 999.99"
                  Dbselectarea("PED")
                  Dbskip()
            End-While
            IF PED->PD_FILIAL #aFiliais[1]
               li :=li+1
               @ li,00 PSAY Replicate("-",132)
               li :=li+1
               @ LI,32 PSAY "Total Parcial -"
               col :=53
               nQTdt:=0
               For a := 1 to Len(aQTDP)
                   IF aQTDP[A] > 0
                      @ li,col PSAY aQTDP[a] PICTURE "@E 999"
                   EndIf
                   nQTdt   := nQTDT + aQTDP[A]
                   aQTDT[A]:= aQTDT[A] + (aQTDP[A] * LEN(aFILIAIS))
                   aQTDP[A]:= 0
                   Col     := col+4
               Next a
               @ LI,111 PSAY nQTDT PICTURE "@E 9999"
               IF li > 80
                  Marcab()
               Endif
               li:=li+1
               @ li,00 PSAY Replicate("==",66)
            Endif
            Dbselectarea("PED")
      End-While
      Dbselectarea("DDD")
End-While
li:=li+1
IF li > 80
   Marcab()
Endif
@ LI,27 PSAY "Total das Grades  -"
col   :=53
nQTDT :=0
For a := 1 to Len(aQtdt)
    IF aQTDT[A] > 0
       @ li,col PSAY aQTDT[a] PICTURE "@E 999"
    Endif
    nQTdt    := nQTDT + aQTDT[A]
    Col      := col+4
    aQTDT[A] := 0
Next a
li := li+1
@ li,00 PSAY Replicate("==",66)
li := li+1
@ li,00 PSAY "CONDICOES DE PAGAMENTO                  COMPLEMENTO           IPI       QTDE TOTAL DO PEDIDO          VALOR LIQUIDO TOTAL DO PEDIDO"
li := li+1
@ Li,001 PSAY  SZ4->Z4_CONDH
@ Li,045 PSAY  SZ4->Z4_COMPL
@ LI,055 PSAY  SZ4->Z4_IPI
@ LI,080 PSAY  nQTDT PICTURE "@E 9999"
@ LI,119 PSAY _TOTLIQ PICTURE "@E 99,999,999.99"
li := li+1
@ li,00 PSAY Replicate("-",132)
li := li+1
@ LI,30 PSAY "***  CASA DAS CUECAS TEL.: (0XX11) XXX-XXXX - FAX: (0XX11) XXX-XXXX ***"
li := li+1
@ LI,50 PSAY "            ***  NAO PAGAMOS FRETE   ***"
li := li+1
@ li,00 PSAY SA2->A2_REPRES
li := li+1
@ li,00 PSAY SA2->A2_REPRTEL
li := li+2
@ li,00 PSAY "OBS.: "+ALLTRIM(SZ4->Z4_OBS)+Replicate("_",122 - LEN(ALLTRIM(SZ4->Z4_OBS)))
li := li+4
@ li,00 PSAY "       ----------------------                                                                   -------------------------"
li := li+1
@ li,00 PSAY "             FORNECEDOR                                                                                  COMPRADOR "
//****************************************************************
//* Restaura a integridade dos dados				             *
//****************************************************************
dbSelectArea("SZ4")
Set Filter To
dbSetOrder(1)
dbSelectArea("DDD")
dbClosearea("DDD")
dbSelectArea("PED")
dbClosearea("PED")

Set Device To Screen

If aReturn[5] == 1
   Set Printer TO "XX"
   dbCommitAll()
   ourspool(wnrel)
Endif

MS_FLUSH()
Return
/**************************************************************************/
Static Function Montaped()

aStru := {}
AADD(aStru,{"PD_FILIAL","C", 2,0})
AADD(aStru,{"PD_ENTREG","D", 8,0})
AADD(aStru,{"PD_PEDIDO","C", 6,0})
AADD(aStru,{"PD_ITEMP" ,"C", 2,0})
AADD(aStru,{"PD_ITEMD" ,"C", 2,0})
AADD(aStru,{"PD_COD"   ,"C", 3,0})
AADD(aStru,{"PD_TOTAL" ,"N",10,2})
cArq := CriaTrab(aStru,.T.)

dbUseArea(.T.,,cArq,"PED")
IndRegua("PED",cArq,"PD_FILIAL+PD_ITEMP+PD_COD+PD_ITEMD",,,"Selecionando Registros...")

aStru := {}
AADD(aStru,{"DD_FILIAL","C", 2,0})
AADD(aStru,{"DD_TOTAL" ,"N",10,2})
cArq := CriaTrab(aStru,.T.)

dbUseArea(.T.,,cArq,"DDD")
IndRegua("DDD",cArq,"DD_FILIAL",,,"Selecionando Registros...")

Dbselectarea("SZ4")
Dbsetorder(2)
Dbseek(Xfilial("SZ4")+SUBS(MV_PAR01,1,6),.T.)
Setregua(Reccount())

While !eof() .AND. SZ4->Z4_NUMPED == MV_PAR01

      Incregua()

      Totf:=0
      For C := 1 to 20
          cCampo  := "Z4_FIL"+Strzero(C,2)
          cCampo1 := "Z4_ENT"+Strzero(C,2)
          IF !Empty(SZ4->(FieldGet(FieldPos(cCampo))))
             Totf:=totf+1
             Dbselectarea("PED")
             Reclock("PED",.T.)
             PED->PD_PEDIDO := SZ4->Z4_NUMPED
             PED->PD_FILIAL := SZ4->(FieldGet(FieldPos(cCampo)))
             PED->PD_ENTREG := SZ4->(FieldGet(FieldPos(cCampo1)))
             PED->PD_ITEMD  := SZ4->Z4_ITEMD
             PED->PD_ITEMP  := SZ4->Z4_ITEMP
             PED->PD_COD    := SZ4->Z4_SEQ
             PED->PD_TOTAL  := SZ4->Z4_PRCLIQ * SZ4->Z4_QGRTOT
             Msunlock()
          Endif
      Next C
      For c := 1 to 14
          cCampo:="Z4_IGRD"+Strzero(C,2)
          IF !Empty(SZ4->(FieldGet(FieldPos(cCampo))))
             GR:=aScan(aGrd,SZ4->(FieldGet(FieldPos(cCampo))))
             IF GR == 0
                AADD(aGrd,SZ4->(FieldGet(FieldPos(cCampo))))
                AADD(aQTD,0)
                AADD(aQTDP,0)
                AADD(aQTDT,0)
             Endif
          Endif
      Next c
      _Totf    := SZ4->Z4_QGRTOT * Totf
      _Totitem := _Totitem + _Totf
      _Totliq  := _Totliq  + (SZ4->Z4_PRCLIQ * _Totf)
      _TotCst  := _TotCst  + (SZ4->Z4_PRCCST * _Totf)
      Dbselectarea("SZ4")
      Dbskip()
End-While

Dbselectarea("PED")
Dbgotop()
While !eof()
      Dbselectarea("DDD")
      Dbseek(PED->PD_FILIAL)
      IF Eof()
         Reclock("DDD",.T.)
         DDD->DD_FILIAL := PED->PD_FILIAL
         DDD->DD_TOTAL  := PED->PD_TOTAL
      Else
         Reclock("DDD",.F.)
         DDD->DD_TOTAL  := DDD->DD_TOTAL+PED->PD_TOTAL
      Endif  
      Dbselectarea("PED")
      Dbskip()
End-While
Return

/*/
*****************************************************************************
**³Funcao    ³ MARCAB	³ Autor ³ Emerson Augusto	³ Data ³ 23.07.99 ³    **
**³Descricao ³ Imprime Cabecalho					  ³                    **
**³ Uso      ³ Especifico Casa das Cuecas                                 ³**
*****************************************************************************
/*/

Static Function MARCAB()

aSvAlias:={Alias(),IndexOrd(),Recno()}

Dbselectarea("SZ4")
Dbsetorder(2)
Dbseek(Xfilial("SZ4")+SUBS(MV_PAR01,1,6),.T.)

Dbselectarea("SA2")
Dbsetorder(1)
Dbseek(xFILIAL("SA2")+SZ4->Z4_FORNECE)
cNFOR:=SA2->A2_NOME

M_PAG := M_PAG + 1
SetPrc(0,0)
@ 00, 00 PSAY aValimp(132)
@ 01, 00 PSAY "RCOMR01 - "+dtoc(dDatabase) +"    "+TIME()
@ 01,100 PSAY "PAGINA  : "+ STRZERO(M_PAG,3)
@ 02, 62 PSAY "P E D I D O  D E  C O M P R A"
@ 04, 00 PSAY "FORNECEDOR : "+SZ4->Z4_FORNECE+"  -  "+CnFor
@ 04, 63 PSAY "DATA DE EMISSAO "+ Dtoc(SZ4->Z4_DATA)
@ 05, 60 PSAY "  NUMERO DO PEDIDO"
@ 06, 00 PSAY "PEDIDO  "+SZ4->Z4_NUMPED
@ 06, 60 PSAY "< QUE DEVERA CONSTAR"
@ 07, 60 PSAY "  NA SUA NOTA FISCAL"
@ 08, 30 PSAY "Entrega.: "+ DTOC(SZ4->Z4_ENT01)
@ 09, 00 PSAY Replicate("-",132)
@ 10, 00 PSAY "PRODUTO           DESCRICAO                           QUANTIDADE"
@ 10,110 PSAY "TOTAL PRC.UNIT PRC.LIQ"
@ 11, 00 PSAY Replicate("-",132)
LI:=11
dbSelectArea(aSvAlias[1])
Return
/*************************************************************************/
Static Function _ValidPerg()

aSvAlias:={Alias(),IndexOrd(),Recno()}
i:=0
j:=0

aRegistros:={}
dbSelectArea("SX1")
dbSeek("COMR01")

If !Found()
    AADD(aRegistros,{"COMR01","01","Numero Pedido      ?","mv_ch1","C",6,0,0,"G","","mv_par01","","","","","","","","","","","","","","",""})
    For i:=1 to Len(aRegistros)
	RecLock("SX1",.T.)
	For j:=1 to FCount()
	    FieldPut(j,aRegistros[i,j]) 
	    Next
	MsUnlock()
    Next        
Endif


Return(nil)        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

