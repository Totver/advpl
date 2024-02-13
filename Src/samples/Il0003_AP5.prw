#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/08/00
#IFNDEF WINDOWS
   #DEFINE PSAY SAY
#ENDIF

User Function Il0003()        // incluido pelo assistente de conversao do AP5 IDE em 25/08/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("ACOPIA,_LIMP,I,_LACHEI,_CALIAS1,_CALIAS")
SetPrvt("_ASTRSA1,_CARQSA1,WARQ1,_CARQ1,CINDSA1,NREC")
SetPrvt("_CCHASA1,_VENCLC,_PRICOM,_ULTCOM,_ULTVIS,_DTULTIT")
SetPrvt("_DTULCHQ,_DTNASC,_ASTRSA2,_CARQSA2,_CARQ2,CINDSA2")
SetPrvt("_CCHASA2,_DTAVA,_DTVAL,_ASTRSA6,_CARQSA6,_CARQ3")
SetPrvt("CINDSA6,_CCHASA6,_DATAABR,_DATAFCH,_ASTRSB1,_CARQSB1")
SetPrvt("_CARQ4,CINDSB1,_CCHASB1,_UCOM,_DATREF,_UREV")
SetPrvt("_DTREFP1,_CONINI,_ASTRSI1,_CARQSI1,_CARQ6,CINDSI1")
SetPrvt("_CCHASI1,_ASTRSA4,_CARQSA4,_CARQ7,CINDSA4,_CCHASA4")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/08/00 ==>    #DEFINE PSAY SAY
#ENDIF

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IL0003   ³ Autor ³ Alexandro da Silva    ³ Data ³ 20.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Programa Especifico para integracao dos Cadastros          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico Irmaos Lopes   -                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

@ 0,0 TO 200,400 DIALOG oDlg TITLE "Integracao dos Principais Cadastros!!!"
@15,10 TO 60,155

@ 15,160 BMPBUTTON TYPE 01 ACTION ImpCad()// Substituido pelo assistente de conversao do AP5 IDE em 25/08/00 ==> @ 15,160 BMPBUTTON TYPE 01 ACTION Execute(ImpCad)
@ 45,160 BMPBUTTON TYPE 02 ACTION Close(oDlg)
@ 75,160 BMPBUTTON TYPE 05 ACTION Pergunte("IL0003")
@ 20,14 SAY "Este programa faz a integracao dos Principais"
@ 33,14 SAY "Cadastros Gerados pelo Sistema RMS"
@ 43,14 SAY "   -Programa IL0003.PRW"

ACTIVATE DIALOG oDlg  CENTERED


Return(nil)        // incluido pelo assistente de conversao do AP5 IDE em 25/08/00

// Substituido pelo assistente de conversao do AP5 IDE em 25/08/00 ==> Function Impcad
Static Function Impcad()
Close(oDlg)

Pergunte("IL0003",.F.)

If LastKey() == 27 
   Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01            // Arquivos a serem integrados           ³
//³ mv_par02            // Integra ja cadastrado                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
Processa({|lend| intcad()},"Importando Cadastro...!")// Substituido pelo assistente de conversao do AP5 IDE em 25/08/00 ==> Processa({|lend| execute(intcad)},"Importando Cadastro...!")

If _limp
   MsgInfo("Importacao Efetuada com Sucesso")
Else
   MsgInfo("Nenhum Arquivo Importado!!!!!!!")
Endif

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ INTCAD   ³ Autor ³ Alexandro da Silva    ³ Data ³ 20.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Programa Especifico para integracao dos Cadastros          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico Irmaos Lopes   -                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 25/08/00 ==> Function IntCad
Static Function IntCad()
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array c/ nomes de arquivos para backup                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCopia := {{"SA1"},{"SA2"},{"SA4"},{"SA6"},{"SB1"},{"SI1"}}
   
_lImp   := .F.
For i:=1 To Len(aCopia)
   
  _lAchei  := .T.
  _cAlias1 := space(3)
  _cAlias  := aCopia[i,1]
   
  If !(_cAlias) $ mv_par01
     Loop
  Endif   


  If _cAlias == "SA1"

      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
      //³ Criando Estrutura do cadastro de Clientes                    ³
      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
   
      _aStrSA1:={}
      AADD(_aStrSA1,{"ACAMPA1","C",1185,0})
      _cArqSA1:=CriaTrab(_aStrSA1,.T.)
      DbCreate(_cArqSA1,_aStrSA1)
      DbUseArea(.T.,,_cArqSA1,"CLI",.F.,.F.)

      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
      //³ Abre Arquivo de Importacao                                   ³
      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

      dbSelectArea("CLI")
      WARQ1:="\SIGA\SIGAADV\SA1010.TXT"
      IF !FILE(WARQ1)

         dbSelectArea("CLI")
         dbCloseArea("CLI")                 
         MSGSTOP("Arquivo de Clientes nao Existe!")
         Return
      Endif

      APPEND FROM &WARQ1 SDF
      DBGOTOP()
   
      dbSelectArea("CLI")
     _cArq1 := CriaTrab("",.f.)
     //               FILIAL                  COD                       LOJA  
     cIndSA1 := "SUBS(CLI->ACAMPA1,1,2)+SUBS(CLI->ACAMPA1,3,6)+SUBS(CLI->ACAMPA1,9,2)"   

     IndRegua("CLI",_cArq1,cIndSA1,,,"Selecionando Arquivo de Clientes...")
  
     dbSelectArea("CLI")
     nrec:=LastRec()
     ProcRegua(nrec)

     While !Eof() 
      
        IncProc()
        
        _lAchei := .F.
        _cChaSA1 := SUBS(CLI->ACAMPA1,1,2)+SUBS(CLI->ACAMPA1,3,6)+SUBS(CLI->ACAMPA1,9,2)   
        
        If SUBSTR(CLI->ACAMPA1,1185,1) $ "A/E"
           
           dbSelectArea("SA1")
           dbsetOrder(1)
           If dbSeek(_cChaSA1)
              _lAchei := .T.
              _cAlias1:= _cAlias              
              dbSelectarea("SA1")
              RecLock("SA1",.F.)
                dbDelete()
              MsUnlock()  
           Endif   
        Else
           If SUBSTR(CLI->ACAMPA1,1185,1) == "I"
               
              dbSelectArea("SA1")
              dbsetOrder(1)
              If dbSeek(_cChaSA1)
                 dbSelectarea("CLI")
                 dbSkip()
                 Loop
              Endif      
           Endif
        Endif
        
//        If MV_PAR02 == 2 .and. _lAchei 
//           dbSelectArea("CLI")
//           dbSkip()
//           Loop
//        Endif
        
        dbSelectArea("SA1")
        RecLock("SA1",.T.)
           SA1->A1_FILIAL  := SUBSTR(CLI->aCampA1,1,2)
           SA1->A1_COD     := SUBSTR(CLI->aCampA1,3,6)
           SA1->A1_LOJA    := SUBSTR(CLI->aCampA1,9,2)
           SA1->A1_NOME    := SUBSTR(CLI->aCampA1,11,40)
           SA1->A1_NREDUZ  := SUBSTR(CLI->aCampA1,51,30)
           SA1->A1_TIPO    := SUBSTR(CLI->aCampA1,81,1)        
           SA1->A1_END     := SUBSTR(CLI->aCampA1,82,40)        
           SA1->A1_MUN     := SUBSTR(CLI->aCampA1,122,20)
           SA1->A1_EST     := SUBSTR(CLI->aCampA1,142,2)        
           SA1->A1_NATUREZ := SUBSTR(CLI->aCampA1,144,10)                
           SA1->A1_BAIRRO  := SUBSTR(CLI->aCampA1,154,30)
           SA1->A1_CEP     := SUBSTR(CLI->aCampA1,184,8)        
           SA1->A1_ATIVIDA := SUBSTR(CLI->aCampA1,192,5)                       
           SA1->A1_TEL     := SUBSTR(CLI->aCampA1,197,15)
           SA1->A1_TELEX   := SUBSTR(CLI->aCampA1,212,10)        
           SA1->A1_FAX     := SUBSTR(CLI->aCampA1,222,15)                                 
           SA1->A1_CONTATO := SUBSTR(CLI->aCampA1,237,15)                       
           SA1->A1_ENDCOB  := SUBSTR(CLI->aCampA1,252,40)
           SA1->A1_ENDENT  := SUBSTR(CLI->aCampA1,292,40)        
           SA1->A1_ENDREC  := SUBSTR(CLI->aCampA1,332,40)                                          
           SA1->A1_CGC     := SUBSTR(CLI->aCampA1,372,14)                                 
           SA1->A1_INSCR   := SUBSTR(CLI->aCampA1,386,18)                       
           SA1->A1_INSCRM  := SUBSTR(CLI->aCampA1,404,18)
           SA1->A1_VEND    := SUBSTR(CLI->aCampA1,422,6)        
           SA1->A1_COMIS   := VAL(SUBSTR(CLI->aCampA1,428,5))
           SA1->A1_REGIAO  := SUBSTR(CLI->aCampA1,433,3)                                 
           SA1->A1_CONTA   := SUBSTR(CLI->aCampA1,436,20)                       
           SA1->A1_BCO1    := SUBSTR(CLI->aCampA1,456,3)
           SA1->A1_BCO2    := SUBSTR(CLI->aCampA1,459,3)          
           SA1->A1_BCO3    := SUBSTR(CLI->aCampA1,462,3)
           SA1->A1_BCO4    := SUBSTR(CLI->aCampA1,465,3)                    
           SA1->A1_BCO5    := SUBSTR(CLI->aCampA1,468,3)        
           SA1->A1_TRANSP  := SUBSTR(CLI->aCampA1,471,6)          
           SA1->A1_TPFRET  := SUBSTR(CLI->aCampA1,477,1)                    
           SA1->A1_COND    := SUBSTR(CLI->aCampA1,478,3)        
           SA1->A1_DESC    := VAL(SUBSTR(CLI->aCampA1,481,2))
           SA1->A1_PRIOR   := SUBSTR(CLI->aCampA1,483,1)
           SA1->A1_RISCO   := SUBSTR(CLI->aCampA1,484,1)          
           SA1->A1_LC      := VAL(SUBSTR(CLI->aCampA1,485,14))
           _VENCLC         := CTOD(SUBSTR(CLI->ACAMPA1,505,2)+"\"+SUBSTR(CLI->ACAMPA1,503,2)+"\"+ SUBSTR(CLI->ACAMPA1,501,2))              
           SA1->A1_VENCLC     := _VENCLC                
           SA1->A1_CLASSE  := SUBSTR(CLI->aCampA1,507,1)
           SA1->A1_MCOMPRA := VAL(SUBSTR(CLI->aCampA1,508,17))
           SA1->A1_METR    := VAL(SUBSTR(CLI->aCampA1,525,7))
           SA1->A1_MSALDO  := VAL(SUBSTR(CLI->aCampA1,532,17))
           SA1->A1_NROCOM  := VAL(SUBSTR(CLI->aCampA1,549,4))
           _PRICOM         := CTOD(SUBSTR(CLI->ACAMPA1,559,2)+"\"+SUBSTR(CLI->ACAMPA1,557,2)+"\"+ SUBSTR(CLI->ACAMPA1,555,2))
           SA1->A1_PRICOM     := _PRICOM
           _ULTCOM         := CTOD(SUBSTR(CLI->ACAMPA1,567,2)+"\"+SUBSTR(CLI->ACAMPA1,565,2)+"\"+ SUBSTR(CLI->ACAMPA1,563,2))
           SA1->A1_ULTCOM     := _ULTCOM
           SA1->A1_TEMVIS  := VAL(SUBSTR(CLI->aCampA1,569,3))
           _ULTVIS         := CTOD(SUBSTR(CLI->ACAMPA1,578,2)+"\"+SUBSTR(CLI->ACAMPA1,576,2)+"\"+ SUBSTR(CLI->ACAMPA1,574,2))
           SA1->A1_ULTVIS     := _ULTVIS
           SA1->A1_MENSAGE    := SUBSTR(CLI->aCampA1,580,3)
           SA1->A1_NROPAG     := VAL(SUBSTR(CLI->aCampA1,583,4))
           SA1->A1_SALDUP     := VAL(SUBSTR(CLI->aCampA1,587,17))
           SA1->A1_SALPEDL    := VAL(SUBSTR(CLI->aCampA1,604,17))
           SA1->A1_SUFRAMA    := SUBSTR(CLI->aCampA1,621,12)
           SA1->A1_TRANSF     := SUBSTR(CLI->aCampA1,633,1)
           SA1->A1_ATR        := VAL(SUBSTR(CLI->aCampA1,634,17))
           SA1->A1_VACUM      := VAL(SUBSTR(CLI->aCampA1,651,17))
           SA1->A1_SALPED     := VAL(SUBSTR(CLI->aCampA1,668,17))
           SA1->A1_TITPROT    := VAL(SUBSTR(CLI->aCampA1,685,3))
           _DTULTIT           := CTOD(SUBSTR(CLI->ACAMPA1,694,2)+"\"+SUBSTR(CLI->ACAMPA1,692,2)+"\"+ SUBSTR(CLI->ACAMPA1,690,2))
           SA1->A1_DTULTIT    := _DTULTIT
           SA1->A1_CHQDEVO    := VAL(SUBSTR(CLI->aCampA1,696,3))
           _DTULCHQ           := CTOD(SUBSTR(CLI->ACAMPA1,705,2)+"\"+SUBSTR(CLI->ACAMPA1,703,2)+"\"+ SUBSTR(CLI->ACAMPA1,701,2))
           SA1->A1_DTULCHQ    := _DTULCHQ
           SA1->A1_MATR       := VAL(SUBSTR(CLI->aCampA1,707,4))
           SA1->A1_MAIDUPL    := VAL(SUBSTR(CLI->aCampA1,711,17))
           SA1->A1_TABELA     := SUBSTR(CLI->aCampA1,728,1)
           SA1->A1_INCISS     := SUBSTR(CLI->aCampA1,729,1)
           SA1->A1_SALTEMP    := VAL(SUBSTR(CLI->aCampA1,730,17))
           SA1->A1_SALDUPM    := VAL(SUBSTR(CLI->aCampA1,747,17))
           SA1->A1_PAGATR     := VAL(SUBSTR(CLI->aCampA1,764,17))
           SA1->A1_CARGO1     := SUBSTR(CLI->aCampA1,781,15)
           SA1->A1_CONTAT2    := SUBSTR(CLI->aCampA1,796,15)
           SA1->A1_CARGO2     := SUBSTR(CLI->aCampA1,811,15)
           SA1->A1_CONTAT3    := SUBSTR(CLI->aCampA1,826,15)
           SA1->A1_CARGO3     := SUBSTR(CLI->aCampA1,841,15)
           SA1->A1_SUPER      := SUBSTR(CLI->aCampA1,856,6)
           SA1->A1_RTEC       := SUBSTR(CLI->aCampA1,862,6)
           SA1->A1_ALIQIR     := VAL(SUBSTR(CLI->aCampA1,868,5))
           SA1->A1_OBSERV     := SUBSTR(CLI->aCampA1,873,40)
           SA1->A1_CALCSUF    := SUBSTR(CLI->aCampA1,913,1)
           SA1->A1_RG         := SUBSTR(CLI->aCampA1,914,15)
           _DTNASC            := CTOD(SUBSTR(CLI->ACAMPA1,935,2)+"\"+SUBSTR(CLI->ACAMPA1,933,2)+"\"+ SUBSTR(CLI->ACAMPA1,931,2))
           SA1->A1_DTULTIT    := _DTNASC
           SA1->A1_SALPEDB    := VAL(SUBSTR(CLI->aCampA1,937,17))
           SA1->A1_CLIFAT     := SUBSTR(CLI->aCampA1,954,6)
           SA1->A1_GRPTRIB    := SUBSTR(CLI->aCampA1,960,3)
           SA1->A1_BAIRROC    := SUBSTR(CLI->aCampA1,963,20)
           SA1->A1_CEPC       := SUBSTR(CLI->aCampA1,983,8)
           SA1->A1_MUNC       := SUBSTR(CLI->aCampA1,991,15)
           SA1->A1_ESTC       := SUBSTR(CLI->aCampA1,1006,2)
           SA1->A1_BAIRROE    := SUBSTR(CLI->aCampA1,1008,20)
           SA1->A1_CEPE       := SUBSTR(CLI->aCampA1,1028,8)
           SA1->A1_MUNE       := SUBSTR(CLI->aCampA1,1036,15)
           SA1->A1_ESTE       := SUBSTR(CLI->aCampA1,1051,2)
           SA1->A1_SATIV1     := SUBSTR(CLI->aCampA1,1053,1)
           SA1->A1_SATIV2     := SUBSTR(CLI->aCampA1,1054,1)
           SA1->A1_SATIV3     := SUBSTR(CLI->aCampA1,1055,1)
           SA1->A1_SATIV4     := SUBSTR(CLI->aCampA1,1056,1)
           SA1->A1_SATIV5     := SUBSTR(CLI->aCampA1,1057,1)
           SA1->A1_SATIV6     := SUBSTR(CLI->aCampA1,1058,1)
           SA1->A1_SATIV7     := SUBSTR(CLI->aCampA1,1059,1)
           SA1->A1_SATIV8     := SUBSTR(CLI->aCampA1,1060,1)
           SA1->A1_EMAIL      := SUBSTR(CLI->aCampA1,1061,30)
           SA1->A1_HPAGE      := SUBSTR(CLI->aCampA1,1091,30)
           SA1->A1_DPMATV     := SUBSTR(CLI->aCampA1,1121,5)
           SA1->A1_CODMUN     := SUBSTR(CLI->aCampA1,1126,5)
           SA1->A1_AGREG      := SUBSTR(CLI->aCampA1,1131,4)
//           SA1->A1_HISTMK     := SUBSTR(CLI->aCampA1,1135,35)
           SA1->A1_CODHIST    := SUBSTR(CLI->aCampA1,1170,6)
           SA1->A1_PAIS       := SUBSTR(CLI->aCampA1,1176,3)
           SA1->A1_TMPSTD     := SUBSTR(CLI->aCampA1,1179,5)
           SA1->A1_RECINSS    := SUBSTR(CLI->aCampA1,1184,1)
        MsUnlock() 
        
        _lImp := .t.
        dbSelectArea("CLI")
        dbSkip()
     EndDo   
     dbCloseArea("CLI")
  Else
     If _cAlias == "SA2"     
        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³ Criando Estrutura do cadastro de Fornecedores                ³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
        _aStrSA2:={}
        AADD(_aStrSA2,{"ACAMPA2","C",1097,0})
        _cArqSA2:=CriaTrab(_aStrSA2,.T.)
        DbCreate(_cArqSA2,_aStrSA2)
        DbUseArea(.T.,,_cArqSA2,"FORNECE",.F.,.F.)

        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³ Abre Arquivo de Importacao                                   ³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

        dbSelectArea("FORNECE")
        WARQ1:="\SIGA\SIGAADV\SA2010.TXT"
        IF !FILE(WARQ1)

           dbSelectArea("FORNECE")
           dbCloseArea("FORNECE")
           MSGSTOP("Arquivo de Fornecedores nao Existe!")
           Return
        Endif

        APPEND FROM &WARQ1 SDF
        DBGOTOP()   
     
        dbSelectArea("FORNECE")
        _cArq2 := CriaTrab("",.f.)
        //               FILIAL              COD                 LOJA           
        cIndSA2 := "SUBS(ACAMPA2,1,2) + SUBS(ACAMPA2, 3, 6) + SUBS(ACAMPA2, 9, 2)"   

        IndRegua("FORNECE",_cArq2,cIndSA2,,,"Selecionando Arquivo de Fornecedores...")
     
        dbSelectArea("FORNECE")
        nrec:=LastRec()
        ProcRegua(nrec)
        
        While !Eof() 
      
           IncProc()
           _lAchei := .F.
           _cChaSA2 := SUBS(ACAMPA2,1,2) + SUBS(ACAMPA2,3,6) + SUBS(ACAMPA2, 9, 2)   
        
           If SUBSTR(ACAMPA2,1097,1) $ "A/E"
           
              dbSelectArea("SA2")
              dbsetOrder(1)
              If dbSeek(_cChaSA2)
                 _lAchei := .T.
                 _cAlias1:= _cAlias                 
                 dbSelectarea("SA2")
                 RecLock("SA2",.F.)
                   dbDelete()
                 MsUnlock()  
              Endif   
           Else
              If SUBSTR(ACAMPA2,1097,1) == "I"
               
                 dbSelectArea("SA2")
                 dbsetOrder(1)
                 If dbSeek(_cChaSA2)
                    dbSelectarea("FORNECE")
                    dbSkip()
                    Loop
                 Endif      
              Endif
           Endif
           
           dbSelectArea("SA2")
           RecLock("SA2",.T.)
           
              SA2->A2_FILIAL  := SUBSTR(FORNECE->aCampA2,1,2)     
              SA2->A2_COD     := SUBSTR(FORNECE->aCampa2,3,6)
              SA2->A2_LOJA    := SUBSTR(FORNECE->aCampa2,9,2)
              SA2->A2_NOME    := SUBSTR(FORNECE->aCampa2,11,40)
              SA2->A2_NREDUZ  := SUBSTR(FORNECE->aCampa2,51,30)
              SA2->A2_END     := SUBSTR(FORNECE->aCampa2,81,40)        
              SA2->A2_NR_END  := SUBSTR(FORNECE->aCampa2,121,6)                      
              SA2->A2_BAIRRO  := SUBSTR(FORNECE->aCampa2,127,20)              
              SA2->A2_MUN     := SUBSTR(FORNECE->aCampa2,147,20)
              SA2->A2_EST     := SUBSTR(FORNECE->aCampa2,167,2)        
              SA2->A2_ESTADO  := SUBSTR(FORNECE->aCampa2,169,20)                      
              SA2->A2_CEP     := SUBSTR(FORNECE->aCampa2,189,8)                      
              SA2->A2_CX_POST := SUBSTR(FORNECE->aCampa2,197,5)                
              SA2->A2_CGC     := SUBSTR(FORNECE->aCampa2,202,14)
              SA2->A2_TIPO    := SUBSTR(FORNECE->aCampa2,216,1)           
              SA2->A2_TEL     := SUBSTR(FORNECE->aCampa2,217,50)              
              SA2->A2_TELEX   := SUBSTR(FORNECE->aCampa2,267,10)                      
              SA2->A2_FAX     := SUBSTR(FORNECE->aCampa2,277,15)                                 
              SA2->A2_INSCR   := SUBSTR(FORNECE->aCampa2,292,18)                                     
              SA2->A2_INSCRM  := SUBSTR(FORNECE->aCampa2,310,18)           
              SA2->A2_CONTATO := SUBSTR(FORNECE->aCampa2,328,15)                       
              SA2->A2_BANCO   := SUBSTR(FORNECE->aCampa2,343,3)           
              SA2->A2_AGENCIA := SUBSTR(FORNECE->aCampa2,346,5)                 
              SA2->A2_AGENCIA := SUBSTR(FORNECE->aCampa2,351,30)                      
              SA2->A2_CONTA   := SUBSTR(FORNECE->aCampa2,381,20)
              SA2->A2_NATUREZ := SUBSTR(FORNECE->aCampa2,401,10) 
              SA2->A2_TRANSP  := SUBSTR(FORNECE->aCampa2,411,6)                        
              SA2->A2_PRIOR   := SUBSTR(FORNECE->aCampa2,417,1)
              SA2->A2_RISCO   := SUBSTR(FORNECE->aCampa2,418,3)          
              SA2->A2_COND    := SUBSTR(FORNECE->aCampa2,421,3)                   
              SA2->A2_LC      := SUBSTR(FORNECE->aCampa2,424,14)
              SA2->A2_MATR    := VAL(SUBSTR(FORNECE->aCampa2,438,4))                       
              SA2->A2_MCOMPRA := VAL(SUBSTR(FORNECE->aCampa2,442,17))
              SA2->A2_METR    := VAL(SUBSTR(FORNECE->aCampa2,459,5))                    
              SA2->A2_MSALDO  := VAL(SUBSTR(FORNECE->aCampa2,464,17))                              
              SA2->A2_NROCOM  := VAL(SUBSTR(FORNECE->aCampa2,481,6))              
              _PRICOM         := CTOD(SUBSTR(FORNECE->aCampa2,493,2) + "\" +;
              							      SUBSTR(FORNECE->aCampa2,491,2) + "\" +;
              							      SUBSTR(FORNECE->aCampa2,489,2))              
              SA2->A2_PRICOM  := _PRICOM                                  
              _ULTCOM         := CTOD(SUBSTR(FORNECE->aCampa2,501,2) + "\" +;
              								   SUBSTR(FORNECE->aCampa2,499,2) + "\" +;
              								   SUBSTR(FORNECE->aCampa2,497,2))              
              SA2->A2_ULTCOM  := _ULTCOM                                            
              SA2->A2_SALDUP  := VAL(SUBSTR(FORNECE->aCampa2,503,17))
              SA2->A2_DESVIO  := VAL(SUBSTR(FORNECE->aCampa2,520,6))              
              SA2->A2_SALDUPM := VAL(SUBSTR(FORNECE->aCampa2,526,17))                                             
              SA2->A2_NUMCON  := SUBSTR(FORNECE->aCampa2,543,10)                        
              SA2->A2_TIPORUR := SUBSTR(FORNECE->aCampa2,553,1)                                   
              SA2->A2_RECISS  := SUBSTR(FORNECE->aCampa2,554,1)
              SA2->A2_PAIS    := SUBSTR(FORNECE->aCampa2,555,3)                              
              SA2->A2_DEPTO   := SUBSTR(FORNECE->aCampa2,558,30)                                          
              SA2->A2_ID_FBFN := SUBSTR(FORNECE->aCampa2,588,7)
              SA2->A2_STATUS  := SUBSTR(FORNECE->aCampa2,595,1)        
              SA2->A2_GRUPO   := SUBSTR(FORNECE->aCampa2,596,3)
              SA2->A2_ATIVIDA := SUBSTR(FORNECE->aCampa2,599,5)                                 
              SA2->A2_ORIG_1  := SUBSTR(FORNECE->aCampa2,604,3)
              SA2->A2_ORIG_2  := SUBSTR(FORNECE->aCampa2,607,3)
              SA2->A2_ORIG_3  := SUBSTR(FORNECE->aCampa2,610,3)
              SA2->A2_VINCULA := SUBSTR(FORNECE->aCampa2,613,1)          
              SA2->A2_REPRES  := SUBSTR(FORNECE->aCampa2,614,52)
              SA2->A2_REPCONT := SUBSTR(FORNECE->aCampa2,666,50)                    
              SA2->A2_REPRTEL := SUBSTR(FORNECE->aCampa2,716,50)       
              SA2->A2_REPRFAX := SUBSTR(FORNECE->aCampa2,766,30)                  
              SA2->A2_REPR_CO := SUBSTR(FORNECE->aCampa2,796,10)         
              SA2->A2_REPR_EN := SUBSTR(FORNECE->aCampa2,806,52)                     
              SA2->A2_REPBAIR := SUBSTR(FORNECE->aCampa2,858,30)                   
              SA2->A2_REPRMUN := SUBSTR(FORNECE->aCampa2,888,30)                              
              SA2->A2_REPREST := SUBSTR(FORNECE->aCampa2,918,2)
              SA2->A2_REPRCEP := SUBSTR(FORNECE->aCampa2,920,8)
              SA2->A2_REPPAIS := SUBSTR(FORNECE->aCampa2,928,3)           
              SA2->A2_ID_REPR := SUBSTR(FORNECE->aCampa2,931,1)                      
              SA2->A2_REPR_BA := SUBSTR(FORNECE->aCampa2,932,3)                                 
              SA2->A2_REPR_AG := SUBSTR(FORNECE->aCampa2,935,5)                                            
              SA2->A2_REPR_EM := SUBSTR(FORNECE->aCampa2,940,30)                                                       
              SA2->A2_REPRCGC := SUBSTR(FORNECE->aCampa2,970,14)        
              SA2->A2_RET_PAI := SUBSTR(FORNECE->aCampa2,984,1)
              SA2->A2_COMI_SO := SUBSTR(FORNECE->aCampa2,985,1)
              SA2->A2_EMAIL   := SUBSTR(FORNECE->aCampa2,986,30)                
              SA2->A2_HPAGE   := SUBSTR(FORNECE->aCampa2,1016,30)              
              SA2->A2_DPMATV  := SUBSTR(FORNECE->aCampa2,1046,5)                                      
              SA2->A2_CODMUN  := SUBSTR(FORNECE->aCampa2,1051,5)              
              SA2->A2_CONTCOM := SUBSTR(FORNECE->aCampa2,1056,15)                 
              SA2->A2_FATAVA  := VAL(SUBSTR(FORNECE->aCampa2,1071,6))
              _DTAVA          := CTOD(SUBSTR(FORNECE->aCampa2,1083,2) + "\" +;
              								   SUBSTR(FORNECE->aCampa2,1081,2) + "\" +;
              								   SUBSTR(FORNECE->aCampa2,1079,2))              
              SA2->A2_DTAVA   := _DTAVA        
              _DTVAL          := CTOD(SUBSTR(FORNECE->aCampa2,1091,2) + "\" +;
              						  		   SUBSTR(FORNECE->aCampa2,1089,2) + "\" +;
              						  		   SUBSTR(FORNECE->aCampa2,1087,2))              
              SA2->A2_DTAVA   := _DTAVA                      
              SA2->A2_OK      := SUBSTR(FORNECE->aCampa2,1093,2)     
              SA2->A2_ORCAD   := SUBSTR(FORNECE->aCampa2,1095,1)                                                                         
              SA2->A2_RECINSS := SUBSTR(FORNECE->aCampa2,1096,1)                                                                           
              
           MsUnlock()  
           _lImp := .t.
           
           dbSelectArea("FORNECE")
           dbSkip()
        EndDo   
        dbCloseArea("FORNECE")
     Else     
        If _cAlias == "SA6"          
     
           //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
           //³ Criando Estrutura do cadastro de Bancos                      ³
           //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ      
   
           _aStrSA6:={}
           AADD(_aStrSA6,{"ACAMPA6","C",1026,0})
           _cArqSA6:=CriaTrab(_aStrSA6,.T.)
           DbCreate(_cArqSA6,_aStrSA6)
           DbUseArea(.T.,,_cArqSA6,"BAN",.F.,.F.)

           //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
           //³ Abre Arquivo de Importacao                                   ³
           //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

           dbSelectArea("BAN")
           WARQ1:="\SIGA\SIGAADV\SA6010.TXT"
           IF !FILE(WARQ1)

              dbSelectArea("BAN")
              dbCloseArea("BAN")                 
              MSGSTOP("Arquivo de Bancos nao Existe!")
              Return
           Endif

           APPEND FROM &WARQ1 SDF
           DBGOTOP()
    
           dbSelectArea("BAN")
           _cArq3 := CriaTrab("",.f.)
           //               FILIAL                  COD                    AGENCIA                CONTA
           cIndSA6 := "SUBS(BAN->ACAMPA6,1,2)+SUBS(BAN->ACAMPA6,3,3)+SUBS(BAN->ACAMPA6,6,5)+SUBS(BAN->ACAMPA6,51,10)"

           IndRegua("BAN",_cArq3,cIndSA6,,,"Selecionando Arquivo de Bancos...")
  
           dbSelectArea("BAN")
           nrec:=LastRec()
           ProcRegua(nrec)
 
           While !Eof() 
      
              IncProc()
              
              _lAchei := .F.
              _cChaSA6 := SUBS(BAN->ACAMPA6,1,2)+SUBS(BAN->ACAMPA6,3,3)+SUBS(BAN->ACAMPA6,6,5)+SUBS(BAN->ACAMPA6,51,10)
         
              If SUBSTR(BAN->ACAMPA6,1026,1) $ "A/E"
           
                 dbSelectArea("SA6")
                 dbsetOrder(1)
                 If dbSeek(_cChaSA6)
                    _lAchei := .T.
                    _cAlias1:= _cAlias                    
                    dbSelectarea("SA6")
                    RecLock("SA6",.F.)
                      dbDelete()
                    MsUnlock()  
                 Endif   
              Else
                 If SUBSTR(BAN->ACAMPA6,1026,1) == "I"
               
                    dbSelectArea("SA6")
                    dbsetOrder(1)
                    If dbSeek(_cChaSA6)
                       dbSelectarea("BAN")
                       dbSkip()
                       Loop
                    Endif      
                 Endif
              Endif               
              
//              If MV_PAR02 == 2 .and. _lAchei 
//                 dbSelectArea("BAN")
//                 dbSkip()
//                 Loop
//              Endif
              dbSelectArea("SA6")
              RecLock("SA6",.T.)
                 SA6->A6_FILIAL  := SUBSTR(BAN->aCampA6,1,2)
                 SA6->A6_COD     := SUBSTR(BAN->aCampA6,3,3)
                 SA6->A6_AGENCIA := SUBSTR(BAN->aCampA6,6,5)
                 SA6->A6_NOMEAGE := SUBSTR(BAN->aCampA6,11,40)
                 SA6->A6_NUMCON  := SUBSTR(BAN->aCampA6,51,10)
                 SA6->A6_NOME    := SUBSTR(BAN->aCampA6,61,40)                      
                 SA6->A6_NREDUZ  := SUBSTR(BAN->aCampA6,101,15)
                 SA6->A6_END     := SUBSTR(BAN->aCampA6,116,40)
                 SA6->A6_BAIRRO  := SUBSTR(BAN->aCampA6,156,20)
                 SA6->A6_MUN     := SUBSTR(BAN->aCampA6,176,15)
                 SA6->A6_CEP     := SUBSTR(BAN->aCampA6,191,8)
                 SA6->A6_EST     := SUBSTR(BAN->aCampA6,199,2)
                 SA6->A6_TEL     := SUBSTR(BAN->aCampA6,201,15)
                 SA6->A6_FAX     := SUBSTR(BAN->aCampA6,216,15)               
                 SA6->A6_TELEX   := SUBSTR(BAN->aCampA6,231,10)               
                 SA6->A6_CONTATO := SUBSTR(BAN->aCampA6,241,15)
                 SA6->A6_DEPTO   := SUBSTR(BAN->aCampA6,256,15)
                 SA6->A6_RETENCA := VAL(SUBSTR(BAN->aCampA6,271,2))
                 SA6->A6_RETDESC := VAL(SUBSTR(BAN->aCampA6,273,2))               
                 SA6->A6_SALANT  := VAL(SUBSTR(BAN->aCampA6,275,16))
                 SA6->A6_SALATU  := VAL(SUBSTR(BAN->aCampA6,291,16))                              
                 SA6->A6_TXCOBSI := VAL(SUBSTR(BAN->aCampA6,307,10))
                 SA6->A6_TXCOBDE := VAL(SUBSTR(BAN->aCampA6,317,10))               
                 SA6->A6_TAXADES := VAL(SUBSTR(BAN->aCampA6,327,5))
                 SA6->A6_LAYOUT  := SUBSTR(BAN->aCampA6,332,28) 
                 SA6->A6_CONTA   := SUBSTR(BAN->aCampA6,360,20)                              
                 SA6->A6_BOLETO  := SUBSTR(BAN->aCampA6,380,100) 
                 SA6->A6_MENSAGE := SUBSTR(BAN->aCampA6,480,240)
                 SA6->A6_LAYIPMF := SUBSTR(BAN->aCampA6,720,30) 
                 SA6->A6_IMPFISC := SUBSTR(BAN->aCampA6,750,1)               
                 SA6->A6_GAVETA  := SUBSTR(BAN->aCampA6,751,1)                              
                 SA6->A6_DINHEIR := VAL(SUBSTR(BAN->aCampA6,752,14))               
                 SA6->A6_CHEQUES := VAL(SUBSTR(BAN->aCampA6,766,14))
                 SA6->A6_CARTAO  := VAL(SUBSTR(BAN->aCampA6,780,14))                              
                 SA6->A6_CONVENI := VAL(SUBSTR(BAN->aCampA6,794,14))
                 SA6->A6_VALES   := VAL(SUBSTR(BAN->aCampA6,808,14))               
                 SA6->A6_FINANC  := VAL(SUBSTR(BAN->aCampA6,822,14))               
                 SA6->A6_OUTROS  := VAL(SUBSTR(BAN->aCampA6,836,14))                              
                 SA6->A6_VLRDEBI := VAL(SUBSTR(BAN->aCampA6,850,14))
                 SA6->A6_OK      := SUBSTR(BAN->aCampA6,864,2)               
                 SA6->A6_FLUXCAI := SUBSTR(BAN->aCampA6,866,1)                              
                 SA6->A6_DIASCOB := VAL(SUBSTR(BAN->aCampA6,867,2))               
                 _DATAABR        := CTOD(SUBSTR(BAN->aCampa6,875,2)+"\"+SUBSTR(BAN->aCampa6,873,2)+"\"+ SUBSTR(BAN->aCampa6,871,2))              
                 SA6->A6_DATAABR := _DATAABR                                     
                 _DATAFCH        := CTOD(SUBSTR(BAN->aCampa6,883,2)+"\"+SUBSTR(BAN->aCampa6,881,2)+"\"+ SUBSTR(BAN->aCampa6,879,2))              
                 SA6->A6_DATAFCH := _DATAABR                                                    
                 SA6->A6_HORAFCH := SUBSTR(BAN->aCampA6,885,5)                                             
                 SA6->A6_HORAABR := SUBSTR(BAN->aCampA6,890,5)                                                            
                 SA6->A6_TEF     := SUBSTR(BAN->aCampA6,895,1)                                 
                 SA6->A6_LIMCRED := VAL(SUBSTR(BAN->aCampA6,896,16))                              
                 SA6->A6_UNIDFED := SUBSTR(BAN->aCampA6,912,30)                                                
                 SA6->A6_COD_P   := SUBSTR(BAN->aCampA6,942,3) 
//                 SA6->A6_DESCPAI := SUBSTR(BAN->aCampA6,945,15)                
                 SA6->A6_TAXA    := VAL(SUBSTR(BAN->aCampA6,960,14))                                             
                 SA6->A6_CMC7    := SUBSTR(BAN->aCampA6,974,1)                               
                 SA6->A6_FLSERV  := SUBSTR(BAN->aCampA6,975,1)                                              
                 SA6->A6_MOEDA   := VAL(SUBSTR(BAN->aCampA6,976,2))
                 SA6->A6_SALANT2 := VAL(SUBSTR(BAN->aCampA6,978,16))
                 SA6->A6_CONTABI := SUBSTR(BAN->aCampA6,994,10)
                 SA6->A6_SALATU2 := VAL(SUBSTR(BAN->aCampA6,1004,16))
                 SA6->A6_COD_BC  := SUBSTR(BAN->aCampA6,1020,5)               
                 SA6->A6_REMOTO  := SUBSTR(BAN->aCampA6,1025,1)               
              MsUnlock()  
              _lImp := .t.
              
              dbSelectArea("BAN")
              dbSkip()
           EndDo 
           dbCloseArea("BAN")  
        Else     
           If _cAlias == "SB1"             
   
              //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿           
              //³ Criando Estrutura do cadastro de Produtos                    ³
              //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
   
              _aStrSB1:={}
              AADD(_aStrSB1,{"ACAMPB1","C",892,0})
              _cArqSB1:=CriaTrab(_aStrSB1,.T.)
              DbCreate(_cArqSB1,_aStrSB1)
              DbUseArea(.T.,,_cArqSB1,"PRO",.F.,.F.)

              //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
              //³ Abre Arquivo de Importacao                                   ³
              //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

              dbSelectArea("PRO")
              WARQ1:="\SIGA\SIGAADV\SB1010.TXT"
              IF !FILE(WARQ1)

                 dbSelectArea("PRO")
                 dbCloseArea("PRO")                 
                 MSGSTOP("Arquivo de Produtos nao Existe!")
                 Return
              Endif

              APPEND FROM &WARQ1 SDF
              DBGOTOP()
   
              dbSelectArea("PRO")
              _cArq4 := CriaTrab("",.f.)
              //               FILIAL                  COD                       LOJA  
              cIndSB1 := "SUBS(PRO->ACAMPB1,1,2)+SUBS(PRO->ACAMPB1,3,15)"   

              IndRegua("PRO",_cArq4,cIndSB1,,,"Selecionando Arquivo de Produtos...")
  
              dbSelectArea("PRO")
              nrec:=LastRec()
              ProcRegua(nrec)
 
              While !Eof() 
      
                 IncProc()
                 _lAchei := .F.
                 _cChaSB1 := SUBS(PRO->ACAMPB1,1,2)+SUBS(PRO->ACAMPB1,3,15)   
        
                 If SUBSTR(PRO->ACAMPB1,892,1) $ "A/E"
           
                    dbSelectArea("SB1")
                    dbsetOrder(1)
                    If dbSeek(_cChaSB1)
                       _lAchei := .T.
                       _cAlias1:= _cAlias                       
                       dbSelectarea("SB1")
                       RecLock("SB1",.F.)
                         dbDelete()
                       MsUnlock()  
                    Endif   
                 Else
                    If SUBSTR(PRO->ACAMPB1,892,1) == "I"
               
                       dbSelectArea("SB1")
                       dbsetOrder(1)
                       If dbSeek(_cChaSB1)
                          dbSelectarea("PRO")
                          dbSkip()
                          Loop
                       Endif      
                    Endif
                 Endif                                
                 
//                 If MV_PAR02 == 2 .and. _lAchei 
//                    dbSelectArea("PRO")
//                    dbSkip()
//                    Loop
//                 Endif
                 dbSelectArea("SB1")
                 RecLock("SB1",.T.)
                    SB1->B1_FILIAL  := SUBSTR(PRO->aCampB1,1,2)
                    SB1->B1_COD     := SUBSTR(PRO->aCampB1,3,15)
                    SB1->B1_DESC    := SUBSTR(PRO->aCampB1,18,40)
                    SB1->B1_TIPO    := SUBSTR(PRO->aCampB1,58,2)   
                    SB1->B1_UM      := SUBSTR(PRO->aCampB1,60,2)      
                    SB1->B1_LOCPAD  := SUBSTR(PRO->aCampB1,62,2)         
                    SB1->B1_GRUPO   := SUBSTR(PRO->aCampB1,64,4)         
                    SB1->B1_PICM    := VAL(SUBSTR(PRO->aCampB1,68,5))
                    SB1->B1_IPI     := VAL(SUBSTR(PRO->aCampB1,73,5))
                    SB1->B1_POSIPI  := SUBSTR(PRO->aCampB1,78,10)
                    SB1->B1_EX_NCM  := SUBSTR(PRO->aCampB1,88,3)
                    SB1->B1_EX_NBM  := SUBSTR(PRO->aCampB1,91,3)
                    SB1->B1_ALIQISS := VAL(SUBSTR(PRO->aCampB1,94,2))
                    SB1->B1_CODISS  := SUBSTR(PRO->aCampB1,96,8)
                    SB1->B1_TE      := SUBSTR(PRO->aCampB1,104,3)                    
                    SB1->B1_TS      := SUBSTR(PRO->aCampB1,107,3)                                        
                    SB1->B1_PICMRET := VAL(SUBSTR(PRO->aCampB1,110,5))
                    SB1->B1_PICMENT := VAL(SUBSTR(PRO->aCampB1,115,5))                    
                    SB1->B1_IMPZFRC := SUBSTR(PRO->aCampB1,120,1)
                    SB1->B1_BITMAP  := SUBSTR(PRO->aCampB1,121,8)
                    SB1->B1_SEGUM   := SUBSTR(PRO->aCampB1,129,2)
                    SB1->B1_CONV    := VAL(SUBSTR(PRO->aCampB1,131,5))                                        
                    SB1->B1_TIPCONV := SUBSTR(PRO->aCampB1,136,1)                                        
                    SB1->B1_ALTER   := SUBSTR(PRO->aCampB1,137,15)
                    SB1->B1_QE      := VAL(SUBSTR(PRO->aCampB1,152,9))
                    SB1->B1_PRV1    := VAL(SUBSTR(PRO->aCampB1,161,12))                    
                    SB1->B1_EMIN    := VAL(SUBSTR(PRO->aCampB1,173,12))                    
                    SB1->B1_CUSTD   := VAL(SUBSTR(PRO->aCampB1,185,12))                    
                    SB1->B1_UPRC    := VAL(SUBSTR(PRO->aCampB1,197,12))                    
                    _UCOM           := CTOD(SUBSTR(PRO->aCampB1,215,2)+"\"+SUBSTR(PRO->aCampB1,213,2)+"\"+ SUBSTR(PRO->aCampB1,211,2))              
                    SB1->B1_UCOM    := _UCOM
                    SB1->B1_PESO    := VAL(SUBSTR(PRO->aCampB1,217,11))                    
                    SB1->B1_ESTSEG  := VAL(SUBSTR(PRO->aCampB1,228,12))                    
                    SB1->B1_ESTFOR  := SUBSTR(PRO->aCampB1,240,3)                    
                    SB1->B1_FORPRZ  := SUBSTR(PRO->aCampB1,243,3)
                    SB1->B1_PE      := VAL(SUBSTR(PRO->aCampB1,246,5))
                    SB1->B1_TIPE    := SUBSTR(PRO->aCampB1,251,1)
                    SB1->B1_LE      := VAL(SUBSTR(PRO->aCampB1,252,12))                    
                    SB1->B1_LM      := VAL(SUBSTR(PRO->aCampB1,264,12))
                    SB1->B1_CONTA   := SUBSTR(PRO->aCampB1,276,20)
                    SB1->B1_TOLER   := VAL(SUBSTR(PRO->aCampB1,296,3))
                    SB1->B1_CC      := SUBSTR(PRO->aCampB1,299,9)
                    SB1->B1_FAMILIA := SUBSTR(PRO->aCampB1,308,1)
                    SB1->B1_PROC    := SUBSTR(PRO->aCampB1,309,6)
                    SB1->B1_LOJPROC := SUBSTR(PRO->aCampB1,315,2)                    
                    SB1->B1_QB      := VAL(SUBSTR(PRO->aCampB1,317,7))
                    SB1->B1_APROPRI := SUBSTR(PRO->aCampB1,324,1)                                        
                    SB1->B1_FANTASM := SUBSTR(PRO->aCampB1,325,1)
                    SB1->B1_TIPODEC := SUBSTR(PRO->aCampB1,326,1)                    
                    SB1->B1_ORIGEM  := SUBSTR(PRO->aCampB1,327,2)     
                    SB1->B1_CLASFIS := SUBSTR(PRO->aCampB1,329,2)     
                    _DATREF         := CTOD(SUBSTR(PRO->aCampB1,337,2)+"\"+SUBSTR(PRO->aCampB1,335,2)+"\"+ SUBSTR(PRO->aCampB1,333,2))
                    SB1->B1_DATREF  := _DATREF
                    SB1->B1_RASTRO  := SUBSTR(PRO->aCampB1,339,1)
                    _UREV           := CTOD(SUBSTR(PRO->aCampB1,346,2)+"\"+SUBSTR(PRO->aCampB1,344,2)+"\"+ SUBSTR(PRO->aCampB1,342,2))
                    SB1->B1_UREV    := _UREV                    
                    SB1->B1_FORAEST := SUBSTR(PRO->aCampB1,348,1)     
                    SB1->B1_COMIS   := VAL(SUBSTR(PRO->aCampB1,349,5)) 
                    SB1->B1_MONO    := SUBSTR(PRO->aCampB1,354,1)     
                    SB1->B1_MRP     := SUBSTR(PRO->aCampB1,355,1)     
                    SB1->B1_PERINV  := VAL(SUBSTR(PRO->aCampB1,356,3))                     
                    _DTREFP1        := CTOD(SUBSTR(PRO->aCampB1,365,2)+"\"+SUBSTR(PRO->aCampB1,363,2)+"\"+ SUBSTR(PRO->aCampB1,361,2))
                    SB1->B1_DTREFP1 := _DTREFP1                                       
                    SB1->B1_GRTRIB  := SUBSTR(PRO->aCampB1,367,3)     
                    SB1->B1_NOTAMIN := VAL(SUBSTR(PRO->aCampB1,370,1))
                    SB1->B1_PRVALID := VAL(SUBSTR(PRO->aCampB1,371,3))     
                    SB1->B1_NUMCOP  := VAL(SUBSTR(PRO->aCampB1,374,5))                         
                    SB1->B1_CONTSOC := SUBSTR(PRO->aCampB1,379,1)     
                    _CONINI         := CTOD(SUBSTR(PRO->aCampB1,386,2)+"\"+SUBSTR(PRO->aCampB1,384,2)+"\"+ SUBSTR(PRO->aCampB1,382,2))
                    SB1->B1_CONINI  := _CONINI                                                           
                    SB1->B1_IRRF    := SUBSTR(PRO->aCampB1,388,1)   
                    SB1->B1_CODBAR  := SUBSTR(PRO->aCampB1,389,15)   
                    SB1->B1_GRADE   := SUBSTR(PRO->aCampB1,404,1)   
                    SB1->B1_FORMLOT := SUBSTR(PRO->aCampB1,405,3)   
                    SB1->B1_LOCALIZ := SUBSTR(PRO->aCampB1,408,1)     
                    SB1->B1_OPERPAD := SUBSTR(PRO->aCampB1,409,2)                       
                    SB1->B1_CONTRAT := SUBSTR(PRO->aCampB1,411,1)                       
                    SB1->B1_DESC_P  := SUBSTR(PRO->aCampB1,412,6)                       
                    SB1->B1_FPCOD   := SUBSTR(PRO->aCampB1,418,2)                       
                    SB1->B1_DESC_I  := SUBSTR(PRO->aCampB1,420,6)                       
                    SB1->B1_VLREFUS := VAL(SUBSTR(PRO->aCampB1,426,15))
                    SB1->B1_DESC_GI := SUBSTR(PRO->aCampB1,441,6)                         
                    SB1->B1_IMPORT  := SUBSTR(PRO->aCampB1,447,1)                                              
//                    SB1->B1_VM_I    := SUBSTR(PRO->aCampB1,448,36)                                             
//                    SB1->B1_VM_GI   := SUBSTR(PRO->aCampB1,484,48)                                             
//                    SB1->B1_VM_P    := SUBSTR(PRO->aCampB1,532,36)                                                                 
                    SB1->B1_ANUENTE := SUBSTR(PRO->aCampB1,568,1)                                                                 
                    SB1->B1_OPC     := SUBSTR(PRO->aCampB1,569,80)                                                                                     
                    SB1->B1_CODOBS  := SUBSTR(PRO->aCampB1,649,6)                                                                                     
//                    SB1->B1_OBS     := SUBSTR(PRO->aCampB1,655,60)                                                                                     
                    SB1->B1_SITPROD := SUBSTR(PRO->aCampB1,715,2)
                    SB1->B1_OPAUTOM := SUBSTR(PRO->aCampB1,717,1)                    
                    SB1->B1_FABRIC  := SUBSTR(PRO->aCampB1,718,20)
                    SB1->B1_MODELO  := SUBSTR(PRO->aCampB1,738,15)
                    SB1->B1_SETOR   := SUBSTR(PRO->aCampB1,753,2)
                    SB1->B1_BALANCA := SUBSTR(PRO->aCampB1,755,1)
                    SB1->B1_TECLA   := SUBSTR(PRO->aCampB1,756,3)
                    SB1->B1_PRODPAI := SUBSTR(PRO->aCampB1,759,15)
                    SB1->B1_TIPOCQ  := SUBSTR(PRO->aCampB1,774,1)
                    SB1->B1_SOLICIT := SUBSTR(PRO->aCampB1,775,1)
                    SB1->B1_GRUPCOM := SUBSTR(PRO->aCampB1,776,6)
                    SB1->B1_NUMCQPR := VAL(SUBSTR(PRO->aCampB1,782,3))
                    SB1->B1_CONTCQP := VAL(SUBSTR(PRO->aCampB1,785,3))  
                    SB1->B1_REVATU  := SUBSTR(PRO->aCampB1,788,3)  
                    SB1->B1_INSS    := SUBSTR(PRO->aCampB1,791,1)
                    SB1->B1_ESPECIF := SUBSTR(PRO->aCampB1,792,80)
                    SB1->B1_MAT_PRI := SUBSTR(PRO->aCampB1,872,20)
                 MsUnlock()  
                 _lImp := .t.
                 
                 dbSelectArea("PRO")
                 dbSkip()
              EndDo   
              dbCloseArea("PRO")
           Else     
              If _cAlias == "SI1"                                 

                 //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                 //³ Criando Estrutura do cadastro de Clientes                    ³
                 //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
   
                 _aStrSI1:={}
                 AADD(_aStrSI1,{"ACAMPI1","C",861,0})
                 _cArqSI1:=CriaTrab(_aStrSI1,.T.)
                 DbCreate(_cArqSI1,_aStrSI1)
                 DbUseArea(.T.,,_cArqSI1,"PLAN",.F.,.F.)

                 //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                 //³ Abre Arquivo de Importacao                                   ³
                 //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

                 dbSelectArea("SI1")
                 WARQ1:="\SIGA\SIGAADV\SI1010.TXT"
                 IF !FILE(WARQ1)

                    dbSelectArea("SI1")
                    dbCloseArea("SI1")                 
                    MSGSTOP("Arquivo de Plano de Contas nao Existe!")
                    Return
                 Endif

                 APPEND FROM &WARQ1 SDF
                 DBGOTOP()
   
                 dbSelectArea("PLAN")
                 _cArq6 := CriaTrab("",.f.)
                 //                FILIAL                  COD                       LOJA  
                 cIndSI1 := "SUBS(PLAN->ACAMPI1,1,2)+SUBS(PLAN->ACAMPI1,3,20)"

                 IndRegua("PLAN",_cArq6,cIndSI1,,,"Selecionando Plano de Contas...")
  
                 dbSelectArea("PLAN")
                 nrec:=LastRec()
                 ProcRegua(nrec)
                 
                 While !Eof() 
      
                    IncProc()
                    _lAchei := .F.
                    _cChaSI1 := SUBS(PLAN->ACAMPI1,1,2)+SUBS(PLAN->ACAMPI1,3,20)
        
                    If SUBSTR(PLAN->ACAMPI1,861,1) $ "A/E"
           
                       dbSelectArea("SI1")
                       dbsetOrder(1)
                       If dbSeek(_cChaSI1)
                          _lAchei := .T.
                          _cAlias1:= _cAlias                          
                          dbSelectarea("SI1")
                          RecLock("SI1",.F.)
                            dbDelete()
                          MsUnlock()  
                       Endif   
                    Else
                       If SUBSTR(PLAN->ACAMPI1,861,1) == "I"
               
                          dbSelectArea("SI1")
                          dbsetOrder(1)
                          If dbSeek(_cChaSI1)
                             dbSelectarea("PLAN")
                             dbSkip()
                             Loop
                          Endif      
                       Endif
                    Endif                                                    
                    
//                    If MV_PAR02 == 2 .and. _lAchei 
//                       dbSelectArea("CLI")
//                       dbSkip()
//                       Loop
//                    Endif
                    dbSelectArea("SI1")
                    RecLock("SI1",.T.)
                       SI1->I1_FILIAL  := SUBSTR(PLAN->aCampI1,1,2)
                       SI1->I1_CODIGO  := SUBSTR(PLAN->aCampI1,3,20)
                       SI1->I1_DESC    := SUBSTR(PLAN->aCampI1,23,25)              
                       SI1->I1_CLASSE  := SUBSTR(PLAN->aCampI1,48,1)              
                       SI1->I1_NIVEL   := SUBSTR(PLAN->aCampI1,49,1)                            
                       SI1->I1_RES     := SUBSTR(PLAN->aCampI1,50,10)                                  
                       SI1->I1_NORMAL  := SUBSTR(PLAN->aCampI1,60,1)                                                          
                       SI1->I1_ESTADO  := VAL(SUBSTR(PLAN->aCampI1,61,1))
                       SI1->I1_DC      := SUBSTR(PLAN->aCampI1,62,1)
                       SI1->I1_HP      := SUBSTR(PLAN->aCampI1,63,3)
                       SI1->I1_CTAVM   := SUBSTR(PLAN->aCampI1,66,20)
                       SI1->I1_NCUSTO  := VAL(SUBSTR(PLAN->aCampI1,86,1))
                       SI1->I1_SALVISU := VAL(SUBSTR(PLAN->aCampI1,91,17))                       
                       SI1->I1_CC      := SUBSTR(PLAN->aCampI1,686,9)
                       SI1->I1_CCOBRIG := SUBSTR(PLAN->aCampI1,695,1)
                       SI1->I1_CTARED  := SUBSTR(PLAN->aCampI1,696,20)
                       SI1->I1_DESCEST := SUBSTR(PLAN->aCampI1,716,25)
                       SI1->I1_CODINV  := SUBSTR(PLAN->aCampI1,741,20)
                       SI1->I1_CTASUP  := SUBSTR(PLAN->aCampI1,761,20)
                       SI1->I1_ACITEM  := SUBSTR(PLAN->aCampI1,781,1)                       
                       SI1->I1_ACCUSTO := SUBSTR(PLAN->aCampI1,782,1)
                       SI1->I1_CTAVMC  := SUBSTR(PLAN->aCampI1,783,20)                       
                       SI1->I1_PERLP   := SUBSTR(PLAN->aCampI1,803,6)                       
                       SI1->I1_VLRLPD  := VAL(SUBSTR(PLAN->aCampI1,809,17))                                              
                       SI1->I1_VLRLPC  := VAL(SUBSTR(PLAN->aCampI1,826,17))                                              
                       SI1->I1_ESTOUR  := SUBSTR(PLAN->aCampI1,843,1)                                              
                       SI1->I1_SALANT  := VAL(SUBSTR(PLAN->aCampI1,844,17))                                                                     
                    MsUnlock()  
                    _lImp := .t.
                    
                    dbSelectArea("PLAN")
                    dbSkip()
                 EndDo   
                 dbCloseArea("PLAN")
              Else     
                 If _cAlias == "SA4"                                   
      
                    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                    //³ Criando Estrutura do cadastro de Clientes                    ³
                    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
   
                    _aStrSA4:={}
                    AADD(_aStrSA4,{"ACAMPA4","C",293,0})
                    _cArqSA4:=CriaTrab(_aStrSA4,.T.)
                    DbCreate(_cArqSA4,_aStrSA4)
                    DbUseArea(.T.,,_cArqSA4,"TRANS",.F.,.F.)

                    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                    //³ Abre Arquivo de Importacao                                   ³
                    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

                    dbSelectArea("TRANS")
                    WARQ1:="\SIGA\SIGAADV\SA4010.TXT"
                    IF !FILE(WARQ1)

                       dbSelectArea("TRANS")
                       dbCloseArea("TRANS")                 
                       MSGSTOP("Arquivo de Transportadora nao Existe!")
                       Return
                    Endif

                    APPEND FROM &WARQ1 SDF
                    DBGOTOP()
   
                    dbSelectArea("TRANS")
                    _cArq7 := CriaTrab("",.f.)
                    //               FILIAL                  COD             
                    cIndSA4 := "SUBS(TRANS->ACAMPA4,1,2)+SUBS(TRANS->ACAMPA4,3,6)"

                    IndRegua("TRANS",_cArq7,cIndSA4,,,"Selecionando Arquivo de Transportadora...")
  
                    dbSelectArea("TRANS")
                    nrec:=LastRec()
                    ProcRegua(nrec)
 
                    While !Eof() 
      
                       IncProc()
                       _lAchei := .F.
                       _cChaSA4 := SUBS(TRANS->ACAMPA4,1,2)+SUBS(TRANS->ACAMPA4,3,6)
        
                       If SUBSTR(TRANS->ACAMPA4,293,1) $ "A/E"
             
                          dbSelectArea("SA4")
                          dbsetOrder(1)
                          If dbSeek(_cChaSA4)
                             dbSelectarea("SA4")
                             RecLock("SA4",.F.)
                               dbDelete()
                             MsUnlock()  
                          Endif   
                       Else
                          If SUBSTR(TRANS->ACAMPA4,293,1) == "I"
               
                             dbSelectArea("SA4")
                             dbsetOrder(1)
                             If dbSeek(_cChaSA4)
                                dbSelectarea("TRANS")
                                dbSkip()
                                Loop
                             Endif      
                          Endif
                       Endif                                                                           
                       
//                       If MV_PAR02 == 2 .and. _lAchei 
  //                        dbSelectArea("TRANS")
    //                      dbSkip()
      //                    Loop
        //               Endif
                       dbSelectArea("SA4")
                       RecLock("SA4",.T.)
                          SA4->A4_FILIAL  := SUBSTR(TRANS->aCampA4,1,2)
                          SA4->A4_COD     := SUBSTR(TRANS->aCampA4,3,6)  
                          SA4->A4_NOME    := SUBSTR(TRANS->aCampA4,9,40)  
                          SA4->A4_NREDUZ  := SUBSTR(TRANS->aCampA4,49,30)  
                          SA4->A4_VIA     := SUBSTR(TRANS->aCampA4,79,15)  
                          SA4->A4_END     := SUBSTR(TRANS->aCampA4,94,40)  
                          SA4->A4_MUN     := SUBSTR(TRANS->aCampA4,134,20)  
                          SA4->A4_CEP     := SUBSTR(TRANS->aCampA4,154,8)  
                          SA4->A4_EST     := SUBSTR(TRANS->aCampA4,162,2)  
                          SA4->A4_CGC     := SUBSTR(TRANS->aCampA4,164,14)  
                          SA4->A4_TEL     := SUBSTR(TRANS->aCampA4,178,15)                          
                          SA4->A4_TELEX   := SUBSTR(TRANS->aCampA4,193,10)                            
                          SA4->A4_CONTATO := SUBSTR(TRANS->aCampA4,203,15)                          
                          SA4->A4_INSEST  := SUBSTR(TRANS->aCampA4,218,15)
                          SA4->A4_EMAIL   := SUBSTR(TRANS->aCampA4,233,30)                          
                          SA4->A4_HPAGE   := SUBSTR(TRANS->aCampA4,263,30)                          
                       MsUnlock()  
                       _lImp := .t.
          
                       dbSelectArea("TRANS")
                       dbSkip()
                    EndDo         
                    dbCloseArea("TRANS")        
                 Endif
              Endif                  
           Endif
        Endif       
     Endif 
  Endif     
Next

Return