#include "rwmake.ch"        

User Function Rcoma06()     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CNUMPED,_CENTREG,_CNFOR,LRET,CFORNECE,_NNUM")
SetPrvt("ACAMPOS,CFILESZ4,_NNUMVELHO,_AZ4STRU,_AZ4VAL,_NI")

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³RCOMA06   ³ Autor ³ Emerson Augusto       ³ Data ³ 30/11/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pedido de Compras - Duplicacao                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Casa das Cuecas                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_cNumped := Space(6)
_cEntreg := CTOD("")
_cNfor:=Space(30)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Interface                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 70,11 To 373,598 Dialog _ODLG1 Title OemToAnsi("DUPLICA  PEDIDO DE COMPRAS")
@ 24,11 To 86,247 Title OemToAnsi("Pedido")
@ 99,11 To 149,250 Title OemToAnsi("ATENCAO")
@ 40,28 Say OemToAnsi("Numero do Pedido") Size 60,15
@ 70,28 Say OemToAnsi("Data para Entrega") Size 55,16
@ 112,16 Say OemToAnsi("ESTE PROGRAMA IRA  DUPLICAR  O PEDIDO ACIMA E GERAR NOVO, NA DATA DE ENTREGA  DIGITADA") Size 218,22
@ 40,96  Get _cNumped F3("SZ4") VAlid cped() Size 42,12// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 40,96  Get _cNumped F3("SZ4") VAlid Execute(cped) Size 42,12
@ 55,96  SAY _cNFor  Size 100,12
@ 70,96  Get _cEntreg Size 43,12 VALID !EMPTY(_cENTREG)
@ 55,200 Bmpbutton Type 1 action _Duplica()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 55,200 Bmpbutton Type 1 action Execute(_Duplica)
@ 70,200 Bmpbutton Type 2 action cLOSE(_odLg1)
Activate Dialog _ODLG1
Return
/**************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function Cped
Static Function Cped()
 Lret:=.f.
 DbselectArea("SZ4")
 Dbsetorder(2)
 Dbseek(xfilial("SZ4")+_cNumped,.T.)
 IF !EOF()
	 cFornece:=SZ4->Z4_FORNECE
	 Lret:=.t.
	 DbselectArea("SA2")
	 Dbsetorder(1)
	 Dbseek(xfilial("SA2")+cFornece+"01")
	 IF !EOF()
		_cNFOR:=SA2->A2_NOME
	 Endif
 Endif
Return(lret)
/**************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _Duplica
Static Function _Duplica()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Arquivo de Trabalho de duplicados ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 _nNum := GetSX8Num("SC7")
 ConfirmSX8()
 dbSelectArea("SZ4")
 aCampos:=dbStruct()
 cFileSZ4 := CriaTrab(aCampos,.T.)
 dbUseArea(.T.,,cFileSZ4,"TZ4",.T.,.F.)
 DbselectArea("SZ4")
 Dbsetorder(2)
 Dbseek(xfilial("SZ4")+_cNumped,.T.)
  _nNumVelho:= SZ4->Z4_NUMPED
 // Pega os campos do Z4
While SZ4->Z4_Numped == _nNumvelho
 _aZ4Stru := dbStruct()
 _aZ4Val  := {}
  For _nI:=1 to Len(_aZ4Stru)
    Aadd(_aZ4Val,FieldGet(_nI))
  Next
  // Grava novo registro
     RecLock("TZ4",.T.)
     For _nI:=1 to Len(_aZ4Stru)
       FieldPut(_nI,_aZ4Val[_nI])
     Next
     TZ4->Z4_NUMPED  := _nNum
     TZ4->Z4_DATA:=dDatabase
     TZ4->Z4_SIT:="A"
     TZ4->Z4_DTATU:=CTOD("")
 IF !Empty(TZ4->Z4_ENT01)
   TZ4->Z4_ENT01:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT02)
   TZ4->Z4_ENT02:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT03)
   TZ4->Z4_ENT03:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT04)
   TZ4->Z4_ENT04:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT05)
   TZ4->Z4_ENT05:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT06)
   TZ4->Z4_ENT06:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT07)
   TZ4->Z4_ENT07:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT08)
   TZ4->Z4_ENT08:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT09)
   TZ4->Z4_ENT09:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT10)
   TZ4->Z4_ENT10:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT11)
    TZ4->Z4_ENT11:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT12)
   TZ4->Z4_ENT12:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT13)
   TZ4->Z4_ENT13:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT14)
   TZ4->Z4_ENT14:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT15)
   TZ4->Z4_ENT15:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT16)
   TZ4->Z4_ENT16:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT17)
   TZ4->Z4_ENT17:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT18)
   TZ4->Z4_ENT18:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT19)
   TZ4->Z4_ENT19:=_cENTREG
 Endif
 IF !Empty(TZ4->Z4_ENT20)
   TZ4->Z4_ENT20:=_cENTREG
 Endif
 MsUnLock()
 Dbselectarea("SZ4")
 Dbskip()
Enddo
 Dbselectarea("SZ4")
 Append from &cFileSZ4
 Dbselectarea("TZ4")
 DbClosearea("TZ4")
MsgBox("GERADO  PEDIDO  NUMERO  "+ _nNum ,"ATENCAO","ALERT")
If File(cFileSZ4)
   FErase(cFileSZ4)
EndIf
cLOSE(_odLg1)
RETURN

