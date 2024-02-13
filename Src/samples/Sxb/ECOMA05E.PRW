#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Ecoma05e()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CPRODUTO,_CCOR,_CREFER,_CTOT,")

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±³Programa  ³ECOMA05E  ³ Autor ³ Emerson Augusto       ³ Data ³ 14/12/99 ³±±
±±³Descri‡…o ³ Pedido de Compras - Exclusao de Item / Filial              ³±±
±±³Uso       ³ Especifico para Casa das Cuecas                            ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Close(odlg6)

Dbselectarea("TP2")
Dbselectarea("TP2")

_cProduto  :=TP2->TP_SEQ+"-"+TP2->TP_DESC
_cCor      :=TP2->TP_DCOR
_cRefer    :=TP2->TP_Refer
_cTot      :=TP2->TP_QGRTOT

@ 030,005 To  300,600 Dialog _Odlg5 Title OemToAnsi("EXCLUSAO de Item  - ECOMA05E  -  Pedido Numero -> " +_Cnumped)
@ 010,010 Say OemToAnsi("Produto")      Size 75,8
@ 010,065 Say _cProduto SIZE 200,8
@ 025,010 Say OemToAnsi("Referencia") Size 75,8
@ 025,065 Say _cRefer   SIZE 150,8
@ 040,010 Say OemToAnsi("Cor") Size 45,8
@ 040,065 Say _cCor     SIZE 100,8
@ 060,010 Say OemToAnsi("Total Grade") Size 45,8
@ 060,065 Say _cTot   Picture "@E 999999" Size 30,10
@ 110, 65 Bmpbutton Type 1 action _GRAVA()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 110, 65 Bmpbutton Type 1 action Execute(_GRAVA)
@ 110,120 Bmpbutton Type 2 action cLOSE(_oDLG5)
Activate Dialog _oDlg5
Return 
/**************************************************************************/
Static Function _GRAVA()
IF Msgyesno("Exclui Grade Para todas Filiais com Mesmo Codigo / Referencia ?","Escolha")
   DbSelectArea("SZ4")
   DbSetOrder(1)
   DbSeek(xFilial("SZ4")+_cNumPed)
   If !Eof() .and. SZ4->Z4_SIT <> "A"
      MsgStop("Nao posso excluir o pedido por esta opcao devido ao mesmo ja estar distribuido.")
      Close(_odlg5)
      Return
   EndIf
   Dbselectarea("TP2")
   DbgotoP()
   While !EOF()
         IF _cProduto == TP2->TP_SEQ+"-"+TP2->TP_DESC .AND.;
            _cCor     == TP2->TP_DCOR .AND.;
            _cRefer   == TP2->TP_Refer
            Reclock("TP2",.F.)
            Dbdelete()
            mSunlock()
         Endif
         Dbskip()
   End-While
Else
   Dbselectarea("TP2")
   Reclock("TP2",.F.)
   Dbdelete()
   mSunlock()
Endif
Close(_odlg5)
Return

