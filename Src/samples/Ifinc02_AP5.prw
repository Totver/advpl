#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 05/07/00
#INCLUDE "TOPCONN.CH"

User Function Ifinc02()        // incluido pelo assistente de conversao do AP5 IDE em 05/07/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CQUAL,CTIPO,AITEMS,AOP,CQUERY,NLIST")
SetPrvt("CROT2,AROTINA,NPOS,ASTRU,ACAMPOS,CARQTRAB")
SetPrvt("CCADASTRO,CMARCA,UU,NREG,COP,CITEM")
SetPrvt("CNOMQ,CPRODF,NQTDE,CKIT,CNKIT,DENTR")

// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 05/07/00 ==> #INCLUDE "TOPCONN.CH"
cQual := ""
cTipo := ""
aItems := Array(0)
aOP := Array(0)
dbSelectArea("SC2")
dbSetOrder(1)
// SetRegua(Reccount())
#IFDEF WINDOWS
    Processa({|| ImpFlu()})// Substituido pelo assistente de conversao do AP5 IDE em 05/07/00 ==>     Processa({|| Execute(ImpFlu)})
    Return
// Substituido pelo assistente de conversao do AP5 IDE em 05/07/00 ==>     Function ImpFlu
//Static Function ImpFlu()
  Static Function ImpFlu()
#ENDIF
cQuery :="SELECT DISTINCT C2_FILIAL, C2_PRODUTO, B1_DESC"
cQuery := cQuery + " FROM " + RetSQLName( "SC2" ) + "," + RetSQLName( "SB1" )
cQuery := cQuery + " WHERE B1_FILIAL  = '"+xFilial("SB1")+"' And C2_FILIAL='" + xFilial("SC2") + "' AND"
// cQuery := cQuery + " Substr(C2_PRODUTO,1,3) IN ('141','142','143','144','145','149','146') AND"
// cQuery := cQuery + " C2_SEQUEN = '002' AND"
cQuery := cQuery + " C2_QUJE = 0 AND"
// cQuery := cQuery + " C2_CORRIDA = '      ' AND"
cQuery := cQuery + " C2_PRODUTO = B1_COD"
// cQuery := cQuery + RetSQLName("SB1") + ".D_E_L_E_T_ <> '*' AND "
// cQuery := cQuery + RetSQLName("SC2") + ".D_E_L_E_T_ <> '*'"
cQuery := cQuery + " ORDER BY C2_PRODUTO"
cQuery := ChangeQuery( cQuery )
TCQUERY cQuery NEW ALIAS "TMP"
DbSelectArea("TMP")
dbGotop()
While !Eof()
   aadd(aItems,TMP->C2_PRODUTO + " - " +Alltrim(TMP->B1_DESC))
   dbSkip()
End
DbSelectArea("TMP")
dbCloseArea()
nlist := Len(aItems)
If nList == 0
   @ 000,000 TO 155,383 DIALOG _oDlg1 TITLE "Geracao Corrida"
   @ 010,005 Say "Ja foram geradas todas as corridas"
   @ 060,075 BMPBUTTON TYPE 2 ACTION Close(_oDlg1)
   ACTIVATE DIALOG _oDlg1 CENTERED
   Return
Endif

cRot2   := "ExecBlock('GeraCor',.f.,.f.)"
aRotina := { { "Gerar Corrida", &cRot2, 0 , 1} }
nPos    := "1"

@ 000,000 TO 155,400 DIALOG _oDlg2 TITLE "Gera Numero Corrida"
@ 030,005 Say "Tipo Cafe : "
@ 030,045 COMBOBOX cQual ITEMS aItems SIZE 150,50
@ 060,055 BMPBUTTON TYPE 1 ACTION Confirm()// Substituido pelo assistente de conversao do AP5 IDE em 05/07/00 ==> @ 060,055 BMPBUTTON TYPE 1 ACTION Execute(Confirm)
@ 060,085 BMPBUTTON TYPE 2 ACTION Close(_oDlg2)
ACTIVATE DIALOG _oDlg2 CENTERED
If nPos == "1" .or. Empty(cQual)
   Return
Endif
cQual := Substr(cQual,1,15)
aStru := {}
AADD(aStru,{"MARK","C",2, 0})
aAdd(aStru,{"COD","C",15,0})
aAdd(aStru,{"PRODUTO","C",30,0})
aAdd(aStru,{"KIT" ,"C",20,0})
aAdd(aStru,{"QTDE","N",14,2})
aAdd(aStru,{"DATA","D",8,0})
aAdd(aStru,{"PEDIDO" ,"C",06,0})
aAdd(aStru,{"ITEM" ,"C",02,0})
aAdd(aStru,{"CORRIDA" ,"C",06,0})
aCampos := { {"MARK"     ,"","Ok"        },;
             {"COD"      ,"","Qualidade"},; 
             {"PRODUTO"   ,"","Descricao"},;
             {"KIT"  ,"","Descricao"},;
             {"QTDE","","Quantidade"},;
             {"DATA"  ,"","Embarque"},;
             {"PEDIDO" ,"","Pedido" },;
             {"ITEM" ,"","Item" },;
             {"CORRIDA"  ,"","Corrida"}}
cArqTrab := CriaTrab(aStru)
USE &cArqTrab ALIAS TRB NEW
#IFDEF WINDOWS
Processa( {|| _CriaMB() })// Substituido pelo assistente de conversao do AP5 IDE em 05/07/00 ==> Processa( {|| Execute(_CriaMB) })
#ELSE
_CriaMB()
#ENDIF
cCadastro := "Corridas"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Endereca a funcao de BROWSE                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If UU == "0"
  cMarca := GetMark()
  dbSelectArea("TRB")
  dbGoTop()
  MarkBrow("TRB", "MARK",, aCampos,.F., cMarca)
Endif
dbSelectArea("TRB")
dbCloseArea("TRB")
Ferase(cArqTrab+'.DBF')
DbSelectArea("TMP")
dbCloseArea()
dbSelectArea("SC2")
dbSetOrder(1)

Return

*--------------------
// Substituido pelo assistente de conversao do AP5 IDE em 05/07/00 ==> FUNCTION _CRIAMB
Static FUNCTION _CRIAMB()
*--------------------
UU     := "0"
cQuery :="SELECT C2_PRODUTO, C2_NUM,C2_ITEM,B1_DESC"
cQuery := cQuery + " FROM " + RetSQLName( "SC2" ) + "," + RetSQLName( "SB1" )
cQuery := cQuery + " WHERE B1_FILIAL  = '"+xFilial("SB1")+"' And C2_FILIAL='"+xFilial("SC2")+"' AND"
cQuery := cQuery + " C2_PRODUTO = '" + cQual + "' AND"
// cQuery := cQuery + " C2_SEQUEN = '002' AND"
// cQuery := cQuery + " C2_QUJE = 0 AND"
// cQuery := cQuery + " C2_CORRIDA = '      ' AND"
cQuery := cQuery + " C2_PRODUTO = B1_COD"
// cQuery := cQuery + RetSQLName("SB1") + ".D_E_L_E_T_ <> '*' AND "
// cQuery := cQuery + RetSQLName("SC2") + ".D_E_L_E_T_ <> '*'"
cQuery := cQuery + " ORDER BY C2_PRODUTO"
cQuery := ChangeQuery( cQuery )
TCQUERY cQuery NEW ALIAS "TMP"
DbSelectArea("TMP")
dbGoTop()
If Eof() .and. Bof()
   @ 000,000 TO 155,383 DIALOG _oDlg1 TITLE "Qualidade Nao Encontrada"
   @ 010,005 Say "Nao foi encontrada producao para esta qualidade"
   @ 060,075 BUTTON "OK" SIZE 30,10 ACTION Close(_oDlg1)
   ACTIVATE DIALOG _oDlg1 CENTERED
   UU := "1"
   SET FILTER TO
   dbSetOrder(1)
   Return
Endif
While !Eof()
  nReg := Recno()
  cOP := TMP->C2_NUM
  cItem := TMP->C2_ITEM
  cNomQ := TMP->B1_DESC
  dbSelectArea("SC2")
  dbSetOrder(1)
  dbSeek(xFilial()+cOP+cItem)
  cProdF := SC2->C2_PRODUTO
  nQtde  := SC2->C2_QUANT
  cKit := ""
  cNKit := ""
  dbSelectArea("SG1")
  dbSeek(xFilial()+cProdF)
  While !Eof() .and. cProdF == SG1->G1_COD
    If Substr(SG1->G1_COMP,1,2) == "15"
       cKit := SG1->G1_COMP
       Exit
    Endif
    dbSkip()
  End
  If !Empty(cKit)
     dbSelectArea("SB1")
     dbSeek(xFilial()+cKit)
     cNKit := SB1->B1_DESC
  Endif
  dbSelectArea("SC6")
  dbSeek(xFilial()+cOP)
  dEntr := SC6->C6_ENTREG
  dbSelectArea("TRB")
  RecLock("TRB",.T.)
  Replace COD with SC2->C2_NUM,;
          PRODUTO with cNomQ,;
          KIT with cNKit,;
          QTDE with nQtde,;
          DATA with dEntr,;
          PEDIDO with SC2->C2_NUM,;
          ITEM with cItem,;
          CORRIDA with SC2->C2_NUM     
  MsUnLock()
  dbSelectArea("TMP")
  dbSkip()
End
Return
*----------------
// Substituido pelo assistente de conversao do AP5 IDE em 05/07/00 ==>  FUNCTION CONFIRM
Static FUNCTION CONFIRM()
*----------------
nPos := "2"
Close(_oDlg2)
Return
*----------------
// Substituido pelo assistente de conversao do AP5 IDE em 05/07/00 ==>  FUNCTION CONFIRM3
Static FUNCTION CONFIRM3()
*----------------
nPos := "2"
Close(_oDlg3)
Return

User Function Geracor        // incluido pelo assistente de conversao do AP5 IDE em 05/07/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CCORRIDA,DDTINI,IJ,COP,CPROXC,")

cCorrida := "000001" // GETMV("MV_CORRIDA")
dDtini := dDataBase
@ 000,000 TO 155,383 DIALOG _oDlg3 TITLE "Gera Numero Corrida"
@ 010,005 Say "Corrida : "
@ 030,005 Say "Data Inicio : "
@ 010,055 Get cCorrida 
@ 030,055 Get dDtini Picture "99/99/99"
@ 060,075 BMPBUTTON TYPE 1 ACTION Close(_oDlg3)
ACTIVATE DIALOG _oDlg3 CENTERED
dbSelectArea("TRB")
dbGoTop()
IJ := "0"
While !Eof()
  If Empty(dDtini)
     dDtini := SC2->C2_DATPRI
  Endif
  If TRB->MARK == cMarca
     cOP := TRB->PEDIDO
     dbSelectArea("SC2")
     dbSetOrder(1)
     dbSeek(xFilial()+cOP)
     While !Eof() .and. cOP == SC2->C2_NUM
       If Substr(SC2->C2_PRODUTO,1,2) == "14"
          RecLock("SC2",.F.)
          Replace C2_CORRIDA with cCorrida,;
                  C2_DATPRI with dDtini
          MsUnLock()
// Grava Corrida no SD4 - Ajuste de Empenho
          dbSelectArea("SD4")
          dbSetOrder(2)
          dbSeek(xFilial()+SC2->C2_NUM+SC2->C2_ITEM+SC2->C2_SEQUEN)
          While !Eof() .and. SD4->D4_OP == SC2->C2_NUM+SC2->C2_ITEM+SC2->C2_SEQUEN
             RecLock("SD4",.F.)
             Replace D4_CORRIDA with cCorrida
             MsUnLock()
             dbSkip()
          End
// Grava Corrida no SC1
          dbSelectArea("SC1")
          dbSetOrder(4)
          dbSeek(xFilial()+SC2->C2_NUM+SC2->C2_ITEM+SC2->C2_SEQUEN)
          While !Eof() .and. SC1->C1_OP == SC2->C2_NUM+SC2->C2_ITEM+SC2->C2_SEQUEN
              RecLock("SC1",.F.)
              Replace C1_CORRIDA with cCorrida
              MsUnLock()
             dbSkip()
          End
// Grava Proxima Corrida no SX6
          If IJ == "0"
            cProxC := Strzero(Val(Substr(cCorrida,1,3)) + 1,3)+"/"+substr(str(year(ddatabase),4),3,2)
            dbSelectArea("SX6")
            dbSeek(xFilial()+"MV_CORRIDA")
            RecLock("SX6",.F.)
            Replace X6_CONTEUD with cProxC
            MsUnLock()
            IJ := "1"
          Endif
       Endif
       dbSelectArea("SC2")
       dbSkip()
     End
  Endif
  dbSelectArea("TRB")
  dbSkip()
End
If cCorrida <> cProxC
  MsgBox("Corrida Gerada","Corrida Gerada com Sucesso")
Else
  MsgBox("Atencao","Nao foi Gerada a Corrida")
Endif
Return
