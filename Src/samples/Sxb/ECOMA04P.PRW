#include "rwmake.ch"     

User Function Ecoma04p()

//***********************************************************************
//* Declaracao de variaveis utilizadas no programa atraves da funcao    *
//* SetPrvt, que criara somente as variaveis definidas pelo usuario,    *
//* identificando as variaveis publicas do sistema utilizadas no codigo *
//* Incluido pelo assistente de conversao do AP5 IDE                    *
//***********************************************************************

SetPrvt("_CLOSE2,_DBENEF  ,A       ,CPRODUTO,CSGRD    ,C"     )
SetPrvt("B,CDESC,_CCONTROL,NCOL    ,_CTOT"           )
SetPrvt("LRET   ,_FLI    ,_ALTERA ,_CDESCO  ,_ALTER , _cConsulta")   //incluido _cConsulta  24/07/00
SetPrvt("_VAL   ,_CPRCLQ  ,PL      ,Z       ,Y        ,K"     )
SetPrvt("PV     ,_CPRCVE2 ,_CPRCVE1,_CMARGE ,LCONTINUA,"      )
SetPrvt("ASTRU   ,CARQ    ,_TZ4    ,FIL     ,C       ,CCAMPO"  )
SetPrvt("CFIL    ,ACPOS   , _CCUSTO ,_CIPI   ,_CDESCO1")
SetPrvt("_CDESCO2,_CDESCO3,_CDESCO4,_CDESCO5,_CDESCO6,_CDESCO7")
SetPrvt("_CACRES ,_CACRESC,_CPRCLQ ,_CPRCVE ,_CMARGE ,_CCOR"   )
SetPrvt("_CITEMP ,_CITEMD ,_SEQ    ,CGRD    ,CDESC   ,CCOD"    )
SetPrvt("_CGRADE ,_CQUANT ,_CFIL   ,_CENT   ,X       ,_CTOT"   )
SetPrvt("_CNCOR  ,CPRODUTO,CPARE   ,LRET    ,_CITEM  ,_cICMS"  )
Public _cTitul

_cTitul := {}

//*****************************************************************************
//**³Fun‡„o    ³ ECOMA04P ³ Autor ³ Emerson Augusto       ³ Data ³ 20.09.99 ³**
//**³Descri‡„o ³ Pedido de Compra com grade                                 ³**
//**³Uso       ³ Exclusivo Casa das Cuecas                                  ³**
//*****************************************************************************

SetKey(113,{||""})
SetKey(120,{|| Volta()})
//SetKey(118,{|| _Filial()})
SetKey(119,{|| ExecBlock("Ecoma04T",.F.,.F.)})
SetKey(116,{|| _Finaliz()})

// Inicializa variaves que deram problemas.

/************************************************************************/
If Paramixb   // Se parametro for verdadeiro é alteracao caso contrario inlcusao.

   //*****************************************************************************
   //**³Fun‡„o    ³ ECOMA04A ³ Autor ³ Emerson Augusto       ³ Data ³ 24.09.99 ³**
   //**³Descri‡„o ³ Pedido de Compra com grade                                 ³**
   //**³Uso       ³ Exclusivo Casa das Cuecas                                  ³**
   //*****************************************************************************

   IF _TZ4 == .T.
      Dbselectarea("TZ4")
      Dbclosearea("TZ4")
   Endif
   aStru := {}
   AADD(aStru,{"T4_ITEMD" ,"C", 2,0})
   AADD(aStru,{"T4_ITEMP" ,"C", 2,0})
   AADD(aStru,{"T4_SEQ"   ,"C", 6,0})
   AADD(aStru,{"T4_REF"   ,"C",15,0})
   AADD(aStru,{"T4_COR"   ,"C",10,0})
   AADD(aStru,{"T4_DESC"  ,"C",30,0})
   AADD(aStru,{"T4_PEDIDO","C", 8,0})
   AADD(aStru,{"T4_QGRTOT","N", 6,0})
   AADD(aStru,{"T4_FILD"  ,"C",80,0})
  
   cArq := CriaTrab(aStru,.T.)
   dbUseArea(.T.,,cArq,"TZ4",.T.,.F.)
   IndRegua("TZ4",cArq,"T4_ITEMP+T4_ITEMD",,,"Selecionando Registros...")
   _TZ4 := .T.
 
   dbSelectArea("SZ4")
   dbSetOrder(1)
   dbSeek(xFilial("SZ4")+cPedido,.T.)
   IF !EOF()
 
      While !Eof() .And. SUBS(SZ4->Z4_PEDIDO,1,8)==cPedido

            Dbselectarea("SZ3")
            Dbsetorder(1)
            Dbseek(Xfilial("SZ3")+SZ4->Z4_COR)
    
            Reclock("TZ4",.T.)
            TZ4->T4_ITEMP :=SZ4->Z4_ITEMP
            TZ4->T4_ITEMD :=SZ4->Z4_ITEMD
            TZ4->T4_REF   :=SZ4->Z4_REF
            TZ4->T4_SEQ   :=SZ4->Z4_SEQ
            TZ4->T4_COR   :=SUBS(SZ3->Z3_DESC,1,10)
            TZ4->T4_DESC  :=SZ4->Z4_DESC
            TZ4->T4_QGRTOT:=SZ4->Z4_QGRTOT
            TZ4->T4_QGRTOT:=SZ4->Z4_QGRTOT
            Fil := ""
            For C := 1 to 20
                cCampo:="Z4_FIL"+Strzero(C,2)
                IF !Empty(SZ4->(FieldGet(FieldPos(cCampo))))   
                
                   cFil:=SZ4->(FieldGet(FieldPos(cCampo)))+SPACE(4)
                   
                   Dbselectarea("SX5")
                   dbsetorder(1)
                   Dbseek(xFILIAL("SX5")+"AA"+cFil)
                   FIL:=FIL+ALLTRIM(SX5->X5_DESCRI)+" / "
                   
                Endif
            Next C
            TZ4->T4_FILD  :=FIL
            Msunlock()
            Dbselectarea("SZ4")
            Dbskip()
      End-While
   Else
      MsgStop("Nao existem itens ja Distribuidos para Alteracao")
      Dbselectarea("TZ4")
      Dbclosearea("TZ4")
      _TZ4:=.F.
      mSunlock()
//      Close(oDlgalt)
      Return
   Endif
  
   dbSelectArea("TZ4")
   dbGotop()
     
   aCpos:={}
   AADD(aCpos,{ "T4_ITEMP"  ,"Item Ped"                         })
   AADD(aCpos,{ "T4_ITEMD"  ,"Item Distr"                       })
   AADD(aCpos,{ "T4_SEQ"    ,"Codigo"                           })
   AADD(aCpos,{ "T4_REF"    ,"Ref"                              })
   AADD(aCpos,{ "T4_COR"    ,"Seq"                              })
   AADD(aCpos,{ "T4_DESC"   ,"Descricao"                        })
   AADD(aCpos,{ "T4_QGRTOT" ,"Total Pedido"                     })
   AADD(aCpos,{ "T4_FILD"   ,"Filias Selecionadas para Entrega" })
 
   @ 130,030 To 400,570 Dialog OdLGALT Title OemToAnsi("Alteracao / Exclusao ==> Itens - (ECOMA04P)")
   @ 025,005 TO 130,280 BROWSE "TZ4" FIELDS aCpos
   @   7,  5 Bmpbutton Type 1 Action _Volta()
   @   7, 50 Bmpbutton Type 2 Action _Fecha()
   @   7,100 Button "_Exclui" Size 30,10 action _Exclui()
   Activate DIALOG oDLGalt

Else
   Produto()
EndIf 

Return

/**************************************************************************/
Static Function Produto()
// Volta para a rotina anterior ( Padrao)
If _altera == .T.
   A:=LEN(_cGrade)
   cProduto := _SEQ + " - "+cDESC
   
Else
   dbselectarea("SZ2")
   dbsetorder(1)
   Dbseek(xFILIAL("SZ2")+TB1->T1_CGRD)
   csGRD:=SZ2->Z2_GRADE
   C    :=""
   A    :=LEN(csgrd)
   For B:= 1 TO A
       IF Subs(csgrd,B,1) $ "/ "
          IF !Empty(C)
             DbSelectArea("SX5")
             DbSeek(xFilial("SX5")+"Z1"+C)
             AAdd(_cTitul,Trim(SX5->X5_DESCRI))
             AAdd(_cGrade,C)
             AAdd(_cQuant,0)
             C := ""
          EndIf
       Else
          C:=C+Subs(csgrd,B,1)
       EndIf
   Next B
   A:=LEN(_cGrade)
   For B:= A TO 13
       AAdd(_cTitul,"")
       AAdd(_cGrade,"")
       AAdd(_cQuant,0)
   Next B
   Dbselectarea("TB1")
   Msunlock()
   Dbselectarea("SZ4")
   Msunlock()
   cProduto := TB1->T1_COD + " - "+Alltrim(TB1->T1_DESC)
   cDESC    := TB1->t1_desc     
EndIF

While lContinua
      _cControl:=" ==> ALTERACAO"
      IF _Altera == .f.
         Dbselectarea("TP1")
         Dbgotop()
         _cITEMD:=0
         While !eof()
               _cITEMD:= _cITEMD +1
               Dbskip()
         End-While
         _cControl:=" ==> INCLUSAO"
         _cItemD:= _cItemD + 1
      EndIf
      fLanIped()
End-While

Return

/************************************************************************/
Static Function fLanIped()
//***********************************************************************
//* Criacao da Interface                                                *
//***********************************************************************
_cConsulta := SUBSTR(cProduto,1,6)      //Incluido 24/07/00
@ 030,001 To 430,600 Dialog _Odlg2 Title OemToAnsi("ECOMA04P  - Produto / Grade -> Fornecedor "+ cFornece+" - "+ cNfor)
@ 005,010 Say OemToAnsi("Produto")                        Size 75,8
@ 005,045 Say cProduto                                    Size 230,10
@ 017,010 Say Oemtoansi("Ultimo Custo e Cond. Pagto ->")  SIZE 100,8
@ 018,110 Say STR(TB1->T1_UPRC)+" - "+TB1->T1_CPAGTO      size 230,8
@ 030,010 Say OemToAnsi("Referencia")                     Size 75,8
@ 030,180 Say STRZERO(_cItemP,2)+"/"+Strzero(_cITEMD,2)   SIZE 80,8
@ 030,200 SAY _cControl                                   SIZE 80,8
@ 045,010 Say OemToAnsi("Cor")                            Size 75,8
@ 115,010 Say OemToAnsi("Preco de Custo")                 Size 75,8
@ 115,130 Say OemToAnsi("Perc Ipi")                       Size 75,8
@ 115,200 Say OemToAnsi("Perc ICMS")                      Size 75,8
@ 130,010 Say OemToAnsi("Descontos")                      Size 75,8
@ 145,010 Say OemToAnsi("Acrescimo Fin.")                 Size 75,8
@ 160,010 Say OemToAnsi("Preco Liquido")                  Size 75,8
@ 175,010 Say OemToAnsi("Preco Venda")                    Size 75,8
@ 160,200 Say OemToAnsi("Margem %")                       Size 75,10
@ 190,010 Say "F5->FINALIZA PEDIDO // F8->SCROLL // F9->RETORNA - PRODUTO  " Size 220,10
@ 030,050 Get _cRefer                                     Size 90,8
@ 045,050 Get _cCor                                       Size 15,8  F3 "SZN" Valid _Cor()  //ALTERADO
@ 045,080 Get _cNcor                                      Size 90,8 WHEN .F.
@ 055,003 To 105,290 Title OemToAnsi("Itens Grade")
nCol := 15
	@ 62,nCol SAY _cTitul[1] Size 15,08
//	@ 62,nCol SAY _cGrade[1] Size 15,08
	nCol := nCol + 45
	@ 62,nCol SAY _cTitul[2] Size 15,08
//	@ 62,nCol SAY _cGrade[2] Size 15,08
	nCol := nCol + 40
	@ 62,nCol SAY _cTitul[3] Size 15,08
//	@ 62,nCol SAY _cGrade[3] Size 15,08
	nCol := nCol + 40
	@ 62,nCol SAY _cTitul[4] Size 15,08
//	@ 62,nCol SAY _cGrade[4] Size 15,08
	nCol := nCol + 40
	@ 62,nCol SAY _cTitul[5] Size 15,08
//	@ 62,nCol SAY _cGrade[5] Size 15,08
	nCol := nCol + 40
	@ 62,nCol SAY _cTitul[6] Size 15,08
//	@ 62,nCol SAY _cGrade[6] Size 15,08
	nCol := nCol + 40
	@ 62,nCol SAY _cTitul[7] Size 15,08
//	@ 62,nCol SAY _cGrade[7] Size 15,08
	nCOL := 15
	@ 82,nCol SAY _cTitul[8] Size 15,08
//	@ 82,nCol SAY _cGrade[8] Size 15,08
	nCol := nCol + 45
	@ 82,nCol SAY _cTitul[9] Size 15,08
//	@ 82,nCol SAY _cGrade[9] Size 15,08
	nCol := nCol + 40
	@ 82,nCol SAY _cTitul[10] Size 15,08
//	@ 82,nCol SAY _cGrade[10] Size 15,08
	nCol := nCol + 40
	@ 82,nCol SAY _cTitul[11] Size 15,08
//	@ 82,nCol SAY _cGrade[11] Size 15,08
	nCol := nCol + 40
	@ 82,nCol SAY _cTitul[12] Size 15,08
//	@ 82,nCol SAY _cGrade[12] Size 15,08
	nCol := nCol + 40
	@ 82,nCol SAY _cTitul[13] Size 15,08
//	@ 82,nCol SAY _cGrade[13] Size 15,08
	nCol := nCol + 40
	@ 82,nCol SAY "TOTAL" Size 30,08

IF A+1 > 1
   @ 69,011 GET _cQuant[1]  Picture "@E 9999" SIZE 23,10  VALID _Ftot()
EndIf
IF A+1 > 2
   @ 69,051 GET _cQuant[2]  Picture "@E 9999" SIZE 23,10  VALID _Ftot()
EndIf
IF A+1 > 3
   @ 69,091 GET _cQuant[3]  Picture "@E 9999"  SIZE 23,10  VALID _Ftot()
EndIf
IF A+1 > 4
   @ 69,131 GET _cQuant[4]  Picture "@E 9999" SIZE 23,10 VALID _Ftot()
EndIf
IF A+1 > 5
   @ 69,171 GET _cQuant[5] SIZE 23,10  Picture "@E 9999" VALID _Ftot()
EndIf
IF A+1 > 6
   @ 69,211 GET _cQuant[6]  Picture "@E 9999" SIZE 23,10 VALID _Ftot()
EndIf
IF A+1 > 7
   @ 69,251 GET _cQuant[7]  Picture "@E 9999" SIZE 23,10 VALID _Ftot()
EndIf
IF A+1 > 8
   @ 92,011 GET _cQuant[8]  Picture "@E 9999" SIZE 23,10 VALID _Ftot()
EndIf
IF A+1 > 9
   @ 92,051 GET _cQuant[9]  Picture "@E 9999" SIZE 23,10 VALID _Ftot()
EndIf
IF A+1 > 10
   @ 92,091 GET _cQuant[10] Picture "@E 9999" SIZE 23,10 VALID _Ftot()
EndIf
IF A+1 > 11
   @ 92,131 GET _cQuant[11] Picture "@E 9999" SIZE 23,10 VALID _Ftot()
EndIf
IF A+1 > 12
   @ 92,171 GET _cQuant[12] Picture "@E 9999" SIZE 23,10 VALID _Ftot()
EndIf
IF A+1 > 13
   @ 92,211 GET _cQuant[13] Picture "@E 9999" SIZE 23,10 VALID _Ftot()
EndIf
@ 092,250 Get _cTot     Picture "@E 999999"    Size 30,10   when .F.
@ 115,060 Get _cCusto   Picture "@E 99,999.99" Size 040,008 Valid _Fliq()
@ 115,160 Get _cIpi     Picture "@E 999.99"    Size 020,008 Valid _Fliq()
@ 115,250 Get _cICMS    Picture "@E 999.99"    Size 020,008 Valid _Fliq()
@ 130,060 Get _cDesco1  Picture "@E 999.99"    Size 020,008
@ 130,090 Get _cDesco2  Picture "@E 999.99"    Size 020,008 When !empty(_cDesco1)
@ 130,120 Get _cDesco3  Picture "@E 999.99"    Size 020,008 When !empty(_cDesco2)
@ 130,150 Get _cDesco4  Picture "@E 999.99"    Size 020,008 When !empty(_cDesco3)
@ 130,180 Get _cDesco5  Picture "@E 999.99"    Size 020,008 When !empty(_cDesco4)
@ 130,210 Get _cDesco6  Picture "@E 999.99"    Size 020,008 When !empty(_cDesco5)
@ 130,240 Get _cDesco7  Picture "@E 999.99"    Size 020,008 When !empty(_cDesco6)
@ 145,060 Get _cAcres   Picture "@E 999.99"    Size 020,008
@ 145,090 Get _cAcresC  Picture "@E 9"         Size 015,008 Valid _Fliq()
@ 145,110 Say "(0) Antes Desconto -- (1) Pos descontos" Size 100,012
@ 160,060 Say _cPrcLq Picture "@E 99,999.99"   Size 050,012
@ 160,110 Get _cBenef1 Picture "@!"            Size 005,003 VALID _Benefe()
@ 175,060 Get _cPrcVe1 Picture "@E 99,999.99"  Size 040,008 Valid _Margem()
@ 175,120 Get _cPrcVe2 Picture "@E 99,999.99"  Size 040,008 Valid _cPrcve2 == _cPrcve1
@ 175,200 Say _cMarge Picture "@E 999.99"      Size 040,008
@ 145,250 Bmpbutton Type 1             action Montarr()
@ 160,250 Bmpbutton Type 2             action Volta()
@ 185,250 Button "_Filiais" SIZE 30,10 ACTION _filial()
Activate Dialog _oDLG2
Return
/***********************************************************************/
Static Function _Ftot()
_cTOT:=0
For B:= 1 TO A
    _cTOT:=_cTOT + _cQuant[B]
Next B
Return

/************************************************************************/
Static Function _Cor()
lret:=.F.
Dbselectarea("SZ3")			   // ALTERAR ?
Dbsetorder(1)
Dbseek(Xfilial("SZ3")+_cCor)             
IF !Eof()
   _cNcor:=SZ3->Z3_DESC                        
   _fli:=.T.
   lret:=.T.
Endif
Msunlock()
Return(lret)

/************************************************************************/
Static Function _Benefe()
_Dbenef:=.T.
@ 260,185 To 380,406 Dialog benef Title OemToAnsi("Beneficio")
@   5,  7 Say OemToAnsi("Beneficio.:") Size 34,10
@   6, 47 Get _cBenef Size 43,10 Picture "@E 99999.99"
@  23,  9 Radio aRADIO Var _nRADIO
@  46, 77 Bmpbutton Type 1 action _fPrcve()
Activate Dialog benef

IF _dBENEF == .T.
   close(benef)
Endif

Return
/*************************************************************************/
Static Function Montarr()

IF _fLI == .T. .AND. !EMPty(_cTOT) .and. _cPrcVe1 > 0

   Dbselectarea("TP1")

   IF _Altera == .T. .AND. _ALTER == .F.
      Reclock("TP1",.F.)
   Else
      Reclock("TP1",.T.)
      TP1->TP_REF :=_SEQ
      TP1->TP_SEQ :=_SEQ
      TP1->TP_DESC:=cDESC
   Endif
   TP1->TP_COR   := _cCOR             // ALTERAR ?
   TP1->TP_DCOR  := _cNcor            // Alterar ?
   TP1->TP_Item  := strzero(_cItemD,2)
   TP1->TP_Refer := _cRefer
   TP1->TP_Grd   := cGrd
   TP1->TP_CUSTO := _cCUSTO
   TP1->TP_IPI   := _cIPI
   TP1->TP_ICMS  :=_cICMS
   TP1->TP_Desco1:= _cDesco1
   TP1->TP_Desco2:= _cDesco2
   TP1->TP_Desco3:= _cDesco3
   TP1->TP_Desco4:= _cDesco4
   TP1->TP_Desco5:= _cDesco5
   TP1->TP_Desco6:= _cDesco6
   TP1->TP_Desco7:= _cDesco7
   TP1->TP_Acres := _cAcres
   TP1->TP_AcresC:= _cAcresC
   TP1->TP_PrcLq := _cPrcLq
   TP1->TP_Prcve := _cPrcve1
   TP1->TP_Marge := _cMarge
   FOR _N := 1 TO 13
       TP1->(FieldPut(FieldPos("TP_GRADE"+StrZero(_n,Iif(_n<10,1,2))),_cGrade[_n]))
       TP1->(FieldPut(FieldPos("TP_QUANT"+StrZero(_n,Iif(_n<10,1,2))),_cQuant[_n]))
   Next _n
   TP1->TP_Tot:=_cTot
   Msunlock()
   if _ALtera == .t. .AND. _ALTER == .F.
      Dbselectarea("TP1")
      Dbgotop()
      _cITEMD:=0
      While !eof()
            _cITEMD:= _cITEMD +1
            Dbskip()
      End-While
      _Altera  :=.F.
      _cControl:=" ==> INCLUSAO"
   Endif
   _Cdesco:=""
   IF !empty(_cDesco1)
      _cDesco := ALLTRIM(str(_cDesco1,6,2))+" % "
   Endif
   IF !empty(_cDesco2)
      _cDesco := ALLTRIM(_cDesco)+" + "+ALLTRIM(str(_cDesco2,6,2))+" % "
   Endif
   IF !empty(_cDesco3)
      _cDesco:=ALLTRIM(_cDesco)+" + "+ALLTRIM(str(_cDesco3,6,2))+"+ % "
   Endif
   IF !empty(_cDesco4)
      _cDesco:=ALLTRIM(_cDesco)+" + "+ALLTRIM(str(_cDesco4,6,2))+"+ % "
   Endif
   IF !empty(_cDesco5)
      _cDesco:=ALLTRIM(_cDesco)+" + "+ALLTRIM(str(_cDesco5,6,2))+"+ % "
   Endif
   IF !empty(_cDesco6)
      _cDesco:=ALLTRIM(_cDesco)+" + "+ALLTRIM(str(_cDesco6,6,2))+"+ % "
   Endif
   IF !empty(_cDesco7)
      _cDesco:=ALLTRIM(_cDesco)+" + "+ALLTRIM(str(_cDesco7,6,2))+"+ % "
   Endif
   IF !empty(_cAcres)
      _cDesco:=ALLTRIM(_cDesco)+" + "+ALLTRIM(str(_cAcres,6,2))+" % AC "
   Endif
   IF _aLter == .t.
      Execblock("ECOMA04F",.F.,.F.)
      _aLter :=.F.
      _aLterA:=.F.
   Endif
   _fLi:=.F.
   close(_oDlg2)
   Dlgrefresh(_odlg2)
Endif
Return
/************************************************************************/
Static Function _Fliq()
Lret  :=.T.
If _cCUSTO > 0
   Lret   :=.t.
   _Val   :=0
   _cPrclq:=_cCusto
   IF !Empty(_cIpi)
      _Val   :=(_cCusto * _cIPI) / 100
      _cPrclq:=_cCUSTO + _Val
   Endif
   IF !Empty(_cAcres)
      IF _cAcresc == 0
         _Val   :=(_cCusto * _cAcres) / 100
         _cPrclq:=_cCUSTO + _Val
      Endif
   Endif
   IF !empty(_cDesco1)
      _Val   :=(_cPrclq * _cDesco1) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
   IF !empty(_cDesco2)
      _Val   :=(_cPrclq * _cDesco2) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
   IF !empty(_cDesco3)
      _Val   :=(_cPrclq * _cDesco3) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
   IF !empty(_cDesco4)
      _Val   :=(_cPrclq * _cDesco4) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
   IF !empty(_cDesco5)
      _Val   :=(_cPrclq * _cDesco5) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
   IF !empty(_cDesco6)
      _Val   :=(_cPrclq * _cDesco6) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
   IF !empty(_cDesco7)
      _Val   :=(_cPrclq * _cDesco7) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
   IF !empty(_cIcms)
      _Val   :=(_cPrclq * _cIcms) / 100
      _cPrclq:=_cPrclq - _Val
   Endif
   IF !Empty(_cAcres)
      IF _cAcresc == 1
         _Val:=(_cPrclq * _cAcres) / 100
         _cPrclq:=_cPrclq + _Val
      Endif
   Endif
   _fPrcve()
Endif
Return(lret)
/************************************************************************/
Static Function _fPrcve()
IF _dBENEF == .T.
   close(benef)
   _dBenef := .f.
Endif

Dbselectarea("SZ8")
Dbsetorder(1)
Dbseek(xFILIAL("SZ8")+"XX")

PL:= _cPrclq
Z := Iif(_cBenef==0,0,_cBenef)
Y := SZ8->Z8_MARGEMA / 100               

Do case
Case _nRadio == 2
     Y:=SZ8->Z8_MARGEMB / 100
Case _nRadio == 3
     Y:=SZ8->Z8_MARGEMC / 100
End Case

//SET DECIMALS TO 8
//K       :=(1 + (SZ8->Z8_INFL/100)) * SZ8->Z8_CONSTA2   
//If Z > 0 
//   K       :=(K * Z)
//EndIf   
//PV      :=(PL / K)                        
//PV      := PV / (1 - (Y + SZ8->Z8_CONSTA1))

Pv := Pl * (1 + y )
SET DECIMALS TO 2
PV      :=Round(PV,2)
_cPrcve2:=PV
_cPrcve1:=PV
_Margem()
Dbselectarea("SZ4")

Return

/*****************************************************************/
Static Function _Margem()
PV      :=_cPrcve1
SET DECIMALS TO 8
//_cMarge:=SZ8->Z8_CONSTA3 - (100 * PL) / (K * _cPrcve1)
_cMarge :=(PL / PV) * 100
SET DECIMALS TO 2
_cMarge :=Round(_cMARGE,2)
Return

/**********************************************************************/
Static Function Volta()
SetKey(116,{|| ""})
SetKey(118,{|| ""})
SetKey(119,{|| ""})
SetKey(120,{|| ""})
Lcontinua:= .F.
close(_oDlg2)
Return
/***********************************************************************/
Static Function _Filial()
//Alert("Filial")
IF _fLI == .T.
//   Alert("_FLI")
   Dbselectarea("TP1")
   Dbseek(strzero(_cItemD,2)+_cRefer)
   IF Eof()
      Montarr()
   Endif
Endif

IF _ALTERA == .T.
   Montarr()
//   Alert("alterado")
Endif
Execblock("ECOMA04F",.F.,.F.)

Return
/**************************************************************************/
Static Function _Finaliz()

Lcontinua:= .F.
close(_oDlg2)
Execblock("ECOMA04E",.F.,.F.)
Return     
/**********************************************************************/
Static Function _Volta()

_Altera:=.t.                    

Dbselectarea("SZ4")
Dbsetorder(1)
DbSEEK(xFILIAL("SZ4")+cPedido+TZ4->T4_ITEMP+TZ4->T4_ITEMD)
_cCusto     := SZ4->Z4_PRCCST
_cIPI       := SZ4->Z4_IPI
_cICMS      := SZ4->Z4_ICMS
_cDesco1    := SZ4->Z4_DESCO1
_cDesco2    := SZ4->Z4_DESCO2
_cDesco3    := SZ4->Z4_DESCO3
_cDesco4    := SZ4->Z4_DESCO4
_cDesco5    := SZ4->Z4_DESCO5
_cDesco6    := SZ4->Z4_DESCO6
_cDesco7    := SZ4->Z4_DESCO7
_cAcres     := SZ4->Z4_ACRFIN
_cAcresC    := SZ4->Z4_ACRFINC
_cPrcLq     := SZ4->Z4_PRCLIQ
_cPrcve     := SZ4->Z4_PRCVEN
_cMarge     := SZ4->Z4_MARGEM
_cCOR       := SZ4->Z4_COR                      // 
_cITEMP     := VAL(SZ4->Z4_ITEMP)
_cITEMD     := VAL(SZ4->Z4_ITEMD)
//_SEQ        := SZ4->Z4_REF
_SEQ        := SZ4->Z4_SEQ
cGRD        := cGrd
cDESC       := SZ4->Z4_DESC
cCod        := _SEQ
_cGrade     := {}
_cQuant     := {}
_cTitul     := {}
_cRefer     := SZ4->Z4_REF

For _n := 1 to 13
   
   DbSelectArea("SX5")
   DbSeek(xFilial("SX5")+"Z1"+SZ4->(FieldGet(FieldPos("Z4_IGRD"+StrZero(_n,2)))))
   AAdd(_cTitul,SX5->X5_DESCRI)
  
   If !Empty(SZ4->(FieldGet(FieldPos("Z4_IGRD"+StrZero(_n,2)))))
      AAdd(_cGrade,SZ4->(FieldGet(FieldPos("Z4_IGRD"+StrZero(_n,2)))))
      AAdd(_cQuant,SZ4->(FieldGet(FieldPos("Z4_QGRD"+StrZero(_n,2)))))
   Endif
Next _n

_cFIL:={}
_cEnt:={}
_cRpt:={}

FOR X:= LEN(_cFIL) TO 20
    AADD(_cfIL,""      )
    AADD(_cRpt,""      )
    AADD(_cENT,Ctod(""))
Next X    
_cTot      :=SZ4->Z4_QGRTOT 
For _n := 1 to Len(_cFil)
    _cFil[_n] := SZ4->(FieldGet(FieldPos("Z4_FIL"+StrZero(_n,2))))
    _cRpt[_n] := SZ4->(FieldGet(FieldPos("Z4_RPT"+StrZero(_n,2))))
    _cEnt[_n] := SZ4->(FieldGet(FieldPos("Z4_ENT"+StrZero(_n,2))))
Next _n

Dbselectarea("SZ3")          	// Alterar ?
Dbsetorder(1)
Dbseek(Xfilial("SZ3")+_cCor)    //
IF !Eof()
   _cNcor:=SZ3->Z3_DESC         //
Endif
cProduto := _SEQ+" - "+Alltrim(SZ4->Z4_DESC)

Dbselectarea("TZ4")
Dbclosearea("TZ4")
_fPrcve()    // Atualiza o campo de precos 1 e 2
_TZ4 :=.F.
MsUnLock()
Close(oDlgalt)

Produto()

Return
/***********************************************************************/
Static Function _Fecha()

_ALTERA:=.F.

Dbselectarea("TZ4")
Dbclosearea("TZ4")
MsUnLock()
_TZ4:=.F.
cPare:=.t.
Close(oDlgalt)
Return
/************************************************************************/
Static Function _Exclui()
lret:= MsgBox("Confirma Exclusao de Item?","Confima","YESNO")
If lret == .F.
   Return
End
Dbselectarea("SZ4")
Dbsetorder(1)
DbSEEK(xFILIAL("SZ4")+cPedido+TZ4->T4_ITEMP+TZ4->T4_ITEMD)
Reclock("SZ4",.F.)
Dbdelete()
Msunlock()

Dbselectarea("SZ4")
Dbsetorder(1)
DbSEEK(xFILIAL("SZ4")+cPedido,.T.)
_cITEM:=0
While SZ4->Z4_PEDIDO == cPEDIDO
      _cItem        := _cITEM + 1
      Reclock("SZ4",.F.)
      SZ4->Z4_ITEMP := STRZERO(_cITEM,2)
      mSunlock()
      Dbskip()
End-While

Dbselectarea("SZ4")
Dbsetorder(1)
MsUnLock()

Dbselectarea("TZ4")
Dbclosearea("TZ4")
_TZ4    :=.F.
MsUnLock()
cPare   :=.t.
_Altera :=.F.
Close(oDlgalt)
Return
