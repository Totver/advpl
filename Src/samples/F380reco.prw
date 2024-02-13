#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 05/10/00
#include "Fw192.ch"        // incluido pelo assistente de conversao do AP5 IDE em 05/10/00

User Function F380reco()        // incluido pelo assistente de conversao do AP5 IDE em 05/10/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CALIAS,XRET,CVAR,XALIQ,CPRE,CNUM")
SetPrvt("CPAR,CTIP,CCLI,CLOJ,CBAN,CAGE")
SetPrvt("CCON,NVAL,CCPMF,NVALOR,CCC,CEMPE")
SetPrvt("CDOC,CEMP,")

/*/
--------------------------------------------------------------------
  T¡tulo:         F380RECO.prw
  Descri‡Æo:      Ponto de Entrada para calcular CPMF.
  DtCriacao:      26,Jul.99
  DtUltAtl:       26,Jul.99
  Observa‡äes:
--------------------------------------------------------------------
/*/

_cAlias := Alias()

If TRB->E5_RECPAG == "P"
   
   If ! Empty(TRB->E5_RECONC)    // Geracao do CPMF

      xRET := MsgBox(" Possui CPMF ? ","Escolha","YESNO")

      If xRET

         cVar := dDataBase
         oVar := Nil
         @ 0,0 TO 100,320 DIALOG oDlg1 TITLE "Data"
         @ 20,030 Say "Compensado Em ? " Of oDlg1 Pixel
         @ 35,030 Get oVar Var cVar VALID ! Empty(cVar) Of oDlg1 Pixel Size 40,10
         @ 20,115 BMPBUTTON TYPE 1 ACTION Close(oDlg1)
         ACTIVATE DIALOG oDlg1 CENTER

         xAliq := GETMV("MV_CPMF")

         cPre  := TRB->E5_PREFIXO
         cNum  := TRB->E5_NUMERO
         cPar  := TRB->E5_PARCELA
         cTip  := TRB->E5_TIPO
         cCli  := TRB->E5_CLIFOR
         cLoj  := TRB->E5_LOJA
         cBan  := TRB->E5_BANCO
         cAge  := TRB->E5_AGENCIA
         cCon  := TRB->E5_CONTA
         nVal  := TRB->E5_VALOR

         If !Empty(cNum)
            DbSelectArea("SE2")
            DbSetOrder(1)
            DbSeek(xFilial()+cPre+cNum+cPar+cTip+cCli+cLoj,.t.)

            //If Found()
               //cCpmf := E2_CPMF
            //EndIf

            If SE2->E2_RATFIN == "S"       //.And. cCpmf == "S"
               DbSelectArea("SEZ")
               DbSetOrder(1)
               DbSeek(xFilial()+cPre+cNum+cPar+cTip+cCli+cLoj,.t.)
               Do While !EOF() .AND. EZ_PREFIXO == cPre;
                               .AND. EZ_NUM     == cNum;
                               .AND. EZ_PARCELA == cPar;
                               .AND. EZ_TIPO    == cTip;
                               .AND. EZ_CLIFOR  == cCli;
                               .AND. EZ_LOJA    == cLoj

                  nValor := ((nVal*SEZ->EZ_PORC)/100) 
                  nValor := ((nValor * xAliq) / 100)
                  cCC    := SEZ->EZ_CC
                  cEmpe  := SEZ->EZ_EMPE

                  DbSelectArea("SEY")
                  RecLock("SEY",.T.)
                    REPLACE EY_FILIAL  WITH xFILIAL()
                    REPLACE EY_PREFIXO WITH SEZ->EZ_PREFIXO
                    REPLACE EY_NUM     WITH SEZ->EZ_NUM
                    REPLACE EY_PARCELA WITH SEZ->EZ_PARCELA
                    REPLACE EY_TIPO    WITH SEZ->EZ_TIPO
                    REPLACE EY_CLIFOR  WITH SEZ->EZ_CLIFOR
                    REPLACE EY_LOJA    WITH SEZ->EZ_LOJA
                    REPLACE EY_CC      WITH cCC
                    REPLACE EY_VALOR   WITH NoRound(nValor,2)
                    REPLACE EY_NATUREZ WITH ALLTRIM(GETMV("MV_NATCPMF"))
                    REPLACE EY_EMPE    WITH cEmpe
                    REPLACE EY_DATA    WITH cVar    //dDataBase
                    REPLACE EY_BANCO   WITH cBan
                    REPLACE EY_AGENCIA WITH cAge
                    REPLACE EY_CONTA   WITH cCon
                  MsUnlock()

                  DbSelectArea("SEZ")
                  DbSkip()
               EndDo
            Else                  //If cCpmf == "S"
                nValor := (nVal * xAliq)/100
                cCC    := SE2->E2_CCUSTO
                cEmpe  := SE2->E2_EMPE
 
                DbSelectArea("SEY")
                RecLock("SEY",.T.)
                  REPLACE EY_FILIAL  WITH xFILIAL()
                  REPLACE EY_PREFIXO WITH SE2->E2_PREFIXO
                  REPLACE EY_NUM     WITH SE2->E2_NUM
                  REPLACE EY_PARCELA WITH SE2->E2_PARCELA
                  REPLACE EY_TIPO    WITH SE2->E2_TIPO
                  REPLACE EY_CLIFOR  WITH SE2->E2_FORNECE
                  REPLACE EY_LOJA    WITH SE2->E2_LOJA
                  REPLACE EY_CC      WITH cCC
                  REPLACE EY_VALOR   WITH NoRound(nValor,2)
                  REPLACE EY_NATUREZ WITH ALLTRIM(GETMV("MV_NATCPMF"))
                  REPLACE EY_EMPE    WITH cEmpe
                  REPLACE EY_DATA    WITH cVar    //dDataBase
                  REPLACE EY_BANCO   WITH cBan
                  REPLACE EY_AGENCIA WITH cAge
                  REPLACE EY_CONTA   WITH cCon
                MsUnlock()
            EndIf
         Else

            // If TRB->E5_CPMF == "S"

               nValor := (TRB->E5_VALOR * xAliq)/100
               cCC    := TRB->E5_CCUSTO
               cEmpe  := TRB->E5_EMPE
               cDOC   := TRB->E5_DOCUMEN

               DbSelectArea("SEY")
               RecLock("SEY",.T.)
                 REPLACE EY_FILIAL  WITH xFILIAL()
                 REPLACE EY_PREFIXO WITH cPre
                 REPLACE EY_NUM     WITH cNum
                 REPLACE EY_PARCELA WITH cPar
                 REPLACE EY_TIPO    WITH cTip
                 REPLACE EY_CLIFOR  WITH cCli
                 REPLACE EY_LOJA    WITH cLoj
                 REPLACE EY_CC      WITH cCC
                 REPLACE EY_VALOR   WITH NoRound(nValor,2)
                 REPLACE EY_NATUREZ WITH ALLTRIM(GETMV("MV_NATCPMF"))
                 REPLACE EY_EMPE    WITH cEmpe
                 REPLACE EY_DATA    WITH cVar    //dDataBase
                 REPLACE EY_BANCO   WITH cBan
                 REPLACE EY_AGENCIA WITH cAge
                 REPLACE EY_CONTA   WITH cCon
                 REPLACE EY_DOC     WITH cDoc
               MsUnlock()
            // EndIf

         EndIf

      EndIf

   Else                  // Cancelamento do CPMF

      cPre  := TRB->E5_PREFIXO
      cNum  := TRB->E5_NUMERO
      cPar  := TRB->E5_PARCELA
      cTip  := TRB->E5_TIPO
      cCli  := TRB->E5_CLIFOR
      cLoj  := TRB->E5_LOJA
      cBan  := TRB->E5_BANCO
      cAge  := TRB->E5_AGENCIA
      cCon  := TRB->E5_CONTA
      cDoc  := TRB->E5_DOCUMEN
      cCC   := TRB->E5_CCUSTO
      cEmp  := TRB->E5_EMPE

      If !Empty(cNum)
         DbSelectArea("SEY")
         DbSetOrder(1)
         DbSeek(xFilial()+cPre+cNum+cPar+cTip+cCli+cLoj,.t.)
         Do While !EOF() .AND. EY_PREFIXO == cPre;
                         .AND. EY_NUM     == cNum;
                         .AND. EY_PARCELA == cPar;
                         .AND. EY_TIPO    == cTip;
                         .AND. EY_CLIFOR  == cCli;
                         .AND. EY_LOJA    == cLoj

            If cBan == SEY->EY_BANCO .AND. cAge == SEY->EY_AGENCIA .AND. cCon == SEY->EY_CONTA
               RecLock("SEY",.F.)
                 DBDELETE()
               MsUnlock()
            EndIf

            DbSkip()

         EndDo
      Else
         DbSelectArea("SEY")
         DbSetOrder(2)
         DbSeek(xFilial()+cBan+cAge+cCon+cDoc+cEmp,.t.)
         If Found()
            RecLock("SEY",.F.)
              DBDELETE()
            MsUnlock()
         EndIf

      EndIf

EndIf

EndIf

DbSelectArea(_cAlias)

Return .T.
