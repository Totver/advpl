#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Rcoma07()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("_CNUMPED,_CENTREG,_CNFOR,LRET,CFORNECE,C")
SetPrvt("CCAMPO,CFIL,_CPATH,_CFIL,")

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿛rograma  쿝COMA07   � Autor � Emerson Augusto       � Data � 30/11/99 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Pedido de Compras - Alteracao de data                      낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Especifico                                                 낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de Variaveis                                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
_cNumped := Space(6)
_cEntreg := CTOD("")
_cNfor:=Space(30)
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Criacao da Interface                                                �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
@ 70,11 To 373,598 Dialog _ODLG1 Title OemToAnsi("ALTERA DATA DE ENTREGA ->  PEDIDO DE COMPRAS")
@ 24,11 To 86,247 Title OemToAnsi("Pedido")
@ 99,11 To 149,250 Title OemToAnsi("ATENCAO")
@ 40,28 Say OemToAnsi("Numero do Pedido") Size 60,15
@ 70,28 Say OemToAnsi("NOVA data de Entrega") Size 55,16
@ 112,16 Say OemToAnsi("ESTE PROGRAMA IRA  ALTERAR  O PEDIDO ACIMA, PARA NOVA DATA DE ENTREGA  DIGITADA") Size 218,22
@ 40,96  Get _cNumped F3("SZ4") VAlid cped() Size 42,12// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 40,96  Get _cNumped F3("SZ4") VAlid Execute(cped) Size 42,12
@ 55,96  SAY _cNFor  Size 150,12
@ 70,96  Get _cEntreg Size 43,12 VALID !EMPTY(_cENTREG)
@ 55,200 Bmpbutton Type 1 action _Altera()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 55,200 Bmpbutton Type 1 action Execute(_Altera)
@ 70,200 Bmpbutton Type 2 action cLOSE(_odLg1)
Activate Dialog _ODLG1
//Return
/**************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function Cped
Static Function Cped()
 Lret:=.f.
 DbselectArea("SZ4")
 Dbsetorder(2)
 Dbseek(xfilial("SZ4")+_cNumped)
 IF !EOF()
	 cFornece:=SZ4->Z4_FORNECE
	 Lret:=.t.
	 DbselectArea("SA2")
	 Dbsetorder(1)
	 Dbseek(xfilial("SA2")+cFornece+"01")
	 IF !EOF()
        _cNFOR:=ALLTRIM(SA2->A2_NOME)+" - DATA ENTREGA ATUAL -> "+DTOC(SZ4->Z4_ENT01)
	 Endif
 Endif
Return(lret)
/**************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _Altera
Static Function _Altera()

 DbselectArea("SZ4")
 Dbsetorder(2)
 Dbseek(xfilial("SZ4")+_cNumped)
 While SZ4->Z4_NUMPED == _cNumped
       For C := 1 to 20
           cCampo:="SZ4->Z4_FIL"+Strzero(C,2)
           IF !Empty(&cCampo)
              cfil:=&cCampo
              IF SZ4->Z4_SIT #"A"
//                 Abrefil()
                 Alterc7()
//                 Fechafil()
              Endif
           Endif
        Next c
        Reclock("SZ4",.F.)
        IF !Empty(SZ4->Z4_ENT01)
           SZ4->Z4_ENT01:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT02)
           SZ4->Z4_ENT02:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT03)
           SZ4->Z4_ENT03:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT04)
           SZ4->Z4_ENT04:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT05)
           SZ4->Z4_ENT05:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT06)
           SZ4->Z4_ENT06:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT07)
           SZ4->Z4_ENT07:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT08)
           SZ4->Z4_ENT08:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT09)
           SZ4->Z4_ENT09:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT10)
           SZ4->Z4_ENT10:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT11)
           SZ4->Z4_ENT11:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT12)
           SZ4->Z4_ENT12:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT13)
           SZ4->Z4_ENT13:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT14)
           SZ4->Z4_ENT14:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT15)
           SZ4->Z4_ENT15:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT16)
           SZ4->Z4_ENT16:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT17)
           SZ4->Z4_ENT17:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT18)
           SZ4->Z4_ENT18:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT19)
           SZ4->Z4_ENT19:=_cENTREG
        Endif
        IF !Empty(SZ4->Z4_ENT20)
           SZ4->Z4_ENT20:=_cENTREG
        Endif
        MsUnLock()
        Dbselectarea("SZ4")
        Dbskip()
 End-While
 MsgBox("Alterado Pedido  NUMERO  "+ _cNumped +" Para "+ dtoC(_cENTREG),"ATENCAO","ALERT")
 cLOSE(_odLg1)
RETURN
/**************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function AbreFil
Static Function AbreFil()

_CPATH:="\SIGA\DADOSADV\"

	 _cFIL:= &cCampo+"0"

	 If !File(_cPath+"SC7"+_cFIL+".DBF" )
		MsgStop( "Problemas ! Arquivo "+Right(_cPath+"SD2"+_cFIL,10)+ " nao econtrado. Impossivel Abrir ...")
		Return .F.
	 Endif
	 dbUseArea( .T. ,, _cPath+"SC7"+_cFIL,"_SC7", .F. , .F. )
	 dbSetIndex(_cPath+"SC7"+_cFIL)
Return
/**************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function FechaFil
Static Function FechaFil()
Dbselectarea("_SC7")
Dbsetorder(1)
_SC7->( DbClearInd())
_SC7->( DbCloseArea())
Return
/**************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function AlterC7
Static Function AlterC7()

Dbselectarea("SC7")
Dbsetorder(1)
Dbseek(cfil+_cNumped,.t.)

While SC7->C7_NUM == _cNUMPED .and. cFil == SC7->C7_FILIAL
      Reclock("SC7",.F.)
      SC7->C7_DATPRF  := _cENTREG
      mSUNLOCK()
      Dbselectarea("SC7")
      Dbskip()
Enddo
Return

