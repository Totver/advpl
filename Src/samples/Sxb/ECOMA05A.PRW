#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Ecoma05a()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("DESC,SEQ,FIL,DFIL,_DATR,_CONDH")
SetPrvt("_ALTPED,ACPOS,")


//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±³Fun‡„o    ³ ECOMA05A ³ Autor ³ Emerson Augusto       ³ Data ³ 07/12/99 ³±±
//±±³Descri‡„o ³ Pedido de Compra com grade  - Tela para Alteracao          ³±±   
//±±³Uso       ³ Exclusivo Casa das Cuecas                                  ³±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

Desc  := ""
SEQ   := ""
FIL   := ""
DFIL  := ""
_DATR := Space(2)

Dbselectarea("TP2")
IndRegua("TP2",cArq,"TP_FILIAL+TP_SEQ+TP_ITEMP+TP_ITEMD",,,"Selecionando Registros...")
Dbgotop()
While !eof()

      _CONDH := TP2->TP_CONDH
      IF TP2->TP_ENTREG < DDATABASE
         _Datr := str(dDATABASE - TP2->TP_ENTREG,2)
      Endif

      cRpt  := TP2->TP_REPETE
      IF Seq == TP2->TP_SEQ
//         Desc  :=""
      Else
         Seq   := TP2->TP_SEQ
         Desc  := TP2->TP_DESC
      Endif

      IF FIL == TP2->TP_FILIAL
         DFIL  := ""
      Else
         FIL   := TP2->TP_FILIAL     
         DFIL  := TP2->TP_DFIL
      Endif

      Reclock("TP2",.F.)
      TP2->TP_DFIL   := dFIL
      TP2->TP_DATR   := _Datr
      TP2->TP_DESC   := DESC
      TP2->TP_REPETE := cRpt
      MsUnLock()

      Dbselectarea("TP2")
      Dbskip()
End-While

_aLTPED:=.T.

While _altped
      Dbselectarea("TP2")
      Dbgotop()

      aCpos:={}
      AADD(aCpos,{ "TP_FILIAL" ,"FILIAL"     })
      AADD(aCpos,{ "TP_DFIL"   ,"Nome Fil"   })
      AADD(aCpos,{ "TP_REPETE" ,"Repete"     })
      AADD(aCpos,{ "TP_SEQ"    ,"Referencia1"})
      AADD(aCpos,{ "TP_REFER"  ,"Referencia" })
      AADD(aCpos,{ "TP_DCOR"   ,"Cor"        })
      AADD(aCpos,{ "TP_DESC"   ,"Descricao"  })
      AADD(aCpos,{ "TP_QGRTOT" ,"QT Ped."    })
      AADD(aCpos,{ "TP_QGRENT" ,"QT Ent."    })
      AADD(aCpos,{ "TP_QGRFAL" ,"QT Pend."   })
      AADD(aCpos,{ "TP_CUSTO"  ,"Custo"      })
      AADD(aCpos,{ "TP_PRCLQ"  ,"Liquido"    })
      AADD(aCpos,{ "TP_PRCVE"  ,"Venda"      })
      AADD(aCpos,{ "TP_MARGE"  ,"Marg %"     })
      AADD(aCpos,{ "TP_ENTREG" ,"Prv Entr"   })
      AADD(aCpos,{ "TP_EJENTR" ,"dat Entr"   })
      AADD(aCpos,{ "TP_DATR"   ,"Dia Atr"    })

      @ 075,010 TO 400,600 DIALOG oDlg6 TITLE "PEDIDO DE COMPRAS (ALTERACAO) - ECOMA05A "
      @ 05,15   Say OemToAnsi("Pedido ->")   Size  53,10
      @ 05,55   SAY +_Cnumped                size  50,12
      @ 17,15   Say OemToAnsi("Fornecedor")  Size  53,10
      @ 17,55   SAY Cnfor                    size 150,10
      @ 29,15   Say OemToAnsi("Prz/Desc")    Size  53,10
      @ 29,55   SAY TP2->TP_CONDH            size 200,10
      @ 055,000 TO 160,300 BROWSE "TP2" FiELDS aCpos
      @ 041,001 BUTTON " _Desc/Prazo"         SIZE 40,10 ACTION ExecBlock("ECOMA05D",.F.,.F.)
      @ 041,051 BUTTON " _Quantidade"         SIZE 40,10 ACTION ExecBlock("ECOMA05Q",.F.,.F.)
      @ 041,101 BUTTON " _Custo/Venda"        SIZE 40,10 ACTION ExecBlock("ECOMA05C",.F.,.F.)
      @ 041,151 BUTTON " _Finaliza"           SIZE 30,10 ACTION ExecBlock("ECOMA05F",.F.,.F.)
      @ 041,201 BUTTON " _Exclui  "           SIZE 30,10 ACTION ExecBlock("ECOMA05E",.F.,.F.)
      @ 041,251 BUTTON " _Sair"               SIZE 40,10 ACTION _FimPed()
      ACTIVATE DIALOG oDlg6
End-While


Return(nil)        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

/**********************************************************************/
Static Function _Fimped() 
 _AltPed := .f.
 Close(oDlg6)
Return
