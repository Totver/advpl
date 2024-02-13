#include "rwmake.ch"          

User Function F200Var()

SetPrvt("_CALIAS,_NORD,_NREC,_CKEY,_CNSNUM,CNUMTIT")
SetPrvt("CESPECIE")
Public arEspecie

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³  F200VAR ³ Autor ³ Christian              ³ Data ³ 16.07.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Baixa o titulo na recep‡Æo banc ria usando o NOSSO NUMERO   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

If MV_PAR06 == "033" 

// _cAlias := Alias()
// _nOrd   := IndexOrd()
// _cKey   := IndexKey()
// _nRec   := Recno()

	_cNsNum := cNsNum+Space(Len(se1->e1_numbco)-Len(cNsnum))  // MEXIDO COM MAURICIO
	DbSelectArea("SE1")
	DbSetOrder(nIndex + 1)               // Ordem criada no sindex para o campo E1_NUMBCO

   If DbSeek(xFilial() + _cNsNum )
      cNumTit   := SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA
//    cEspecie  := SE1->E1_TIPO
      arEspecie := SE1->E1_TIPO
    Endif

//  DbSelectArea(_cAlias)
//  DbSetOrder(_nOrd)
//	 DbGoto(_nRec)
	
Endif
 
/*/
dbSelectArea("SZ3")
dbSetOrder(3)
If dbSeek(xFilial() + cNumTit)
  While !Eof()
     If cNumTit <> SZ3->Z3_PREFIXO + SZ3->Z3_NUM + SZ3->Z3_PARCELA
       Exit       
     EndIF   
     RecLock("SZ3")
     SZ3->Z3_BAIXA := dBaixa
     MsUnlock()
     dbSelectArea("SZ3")
     dbSkip()
  EndDo
EndIf
/*/

Return()

User Function fa200Pos()        // incluido pelo assistente de conversao do AP5 IDE em 28/07/00

cEspecie := arEspecie 

// nValRec  := nValrec + nDespes - Utilize o campo EE_DESPCRD = "S"

Return()

User Function F380Reco

Alert("Ponto F380Reco")

Return .T.

User Function SigaFin

Static lAcessou := .F.

If ! lAcessou
	Alert("Ponto Generico - SigaFin")
	lAcessou := .T.
Endif	

Return .T.

User Function FA280Fil

Alert("Ponto Fa280Fil")

Return ""

User Function Fa080Chk

Alert("Ponto FA080Chk")

Return .T.

User Function Fa080Tit

Alert("Ponto FA080Tit")

Return .T.