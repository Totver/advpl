#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Rcome01()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CAREA,_NREC,_CIND,_LT,CPERG,_NFILAT")
SetPrvt("_CFILAT,_LFILIAL,_CFILIAIS,_CPATH,_LARQNOTFOUND,NTOTGEMP1")
SetPrvt("NTOTGEMP2,NTOTGEMP3,_CFIL,VERARQS,_AT,_IN")
SetPrvt("CCODGRP,CCODSGRP,CCODCLAS,CCODFORN,CCODPROD,NTOTPED")
SetPrvt("NTOTVEN,NTOTSAL,_CCHAVE1,_CCHAVE2,_CCHAVE2A,_CCHAVE3")
SetPrvt("_CCHAVE3A,_CCHAVE4,_CCHAVE4A,_CCHAVE5,_CCHAVE5A,N_DATACSAL")
SetPrvt("N_SALDOATU,_SALIAS,AREGS,I,J,")


//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±³Fun‡…o    ³ RCOME01  ³ Autor ³ GILBERTO A.DE OLIVEIRA³ Data ³ 11.01.00 ³±±
//±±³Descri‡…o ³ Gravacao de dados para consulta em tela.                   ³±±
//±±³Argumentos³                                                            ³±±
//±±³Uso       ³ Especifico Casa das Cuecas                                 ³±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß


_cArea := Alias()
_nRec  := Recno()
_cInd  := IndexOrd()
_lT    := 1

DbSelectArea("SM0")
cPerg := "RCME01"
_ValidPerg()

@ 00,000 TO 250,400 DIALOG oWin1 TITLE "PREPARA CONSULTA EM TELA"
@ 20,020 TO 060,170              TITLE "Verifique os Parametros"
@ 75,020 TO 115,170
@ 35,025 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg)
@ 35,075 BMPBUTTON TYPE 1 ACTION Abertura()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 35,075 BMPBUTTON TYPE 1 ACTION Execute(Abertura)
@ 35,125 BMPBUTTON TYPE 2 ACTION Close(oWin1)
@ 080,025 SAY "Esta rotina tem por objetivo preparar os dados   "
@ 090,025 SAY "que serao exibidos na rotina de consulta em tela."

ACTIVATE DIALOG oWin1 CENTER

dbSelectArea(_cArea)
dbSetOrder(_cInd)
dbGoto(_nRec)

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> __Return( .T. )
Return( .T. )        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00
/***************************************************************************/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION Abertura
Static FUNCTION Abertura()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Abre Filiais para Acumular Os Dados                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbSelectArea("SM0")                  // Arquivo de empresas

_nFilAt  := Recno()                  // Guarda filial atual do sistema antes de seguir regras de leitura
_cFilAt  := SM0->M0_CODFIL
_lFilial := .T.
_cFiliais:= Space(0)
_cPath   := "\SIGA\DADOSADV\"
_lArqNotFound := .F.
nTotGEmp1:= 0
nTotGEmp2:= 0
nTotGEmp3:= 0
DbGotop()

While SM0->( !Eof() )

      _lFilial := ( _cFilAt #SM0->M0_CODFIL )

      If ( SM0->M0_CODFIL > MV_PAR04 ) .OR. ;
         ( SM0->M0_CODFIL < MV_PAR03 )

         DbSkip()
         Loop
      EndIf

      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
      //³ Abri outras filiais que nao a atual                                                                               ³
      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

      If  ( _lFilial )
         AbreFiliais()                         // Prepara arquivos de outras filiais para serem selecionados (Filial por Filial, uma de cada vez).
         If _lArqNotFound  == .T.
            Exit
         Endif
         Processa( {|| PrepOutFil()})     // Da a Carga de dados de outras filiais no arquivo de trabalho.// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>          Processa( {|| Execute(PrepOutFil)})     // Da a Carga de dados de outras filiais no arquivo de trabalho.
         FechaFiliais()                        // Fecha os arquivos abertos de outras filiais para possibilitar o uso do mesmo alias com a proxima filial.
      Else
         Processa({||PrepAtuFil()})     // Da a Carga de dados dos arquivos da filial atual.// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>          Processa({||Execute(PrepAtuFil)})     // Da a Carga de dados dos arquivos da filial atual.
      EndIf

      DbSelectArea("SM0")
      DbSkip()

End-While

RecLock( "SZD" , .T. )
SZD->ZD_Vendas  := nTotGEmp1
SZD->ZD_PedAber := nTotGEmp2
SZD->ZD_Estoque := nTotGEmp3
MsUnlock()
DbCommit()

DbSelectAre( "SM0" )
DbGoTo( _nFilAt )

Return


//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±³Fun‡„o    ³ ABREFILIAIS ³ Autor ³ Gilberto A de Oliveira³ Data ³ 15/12/99  ³±±
//±±³Descri‡„o ³ Realiza Abertura de arquivos de outras filiais que nao a atual ³±±
//±±³          ³ de acordo com o registro em que estiver posicionado o SIGAMAT  ³±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

Static Function AbreFiliais()

     _cFIL           := Alltrim(SM0->M0_CODFIL)+"0"
     VerArqs:= {}
     AAdd( VerArqs , _cPath+"SB2"+_cFIL+".DBF" )
     AAdd( VerArqs , _cPath+"SB9"+_cFIL+".DBF" )
     AAdd( VerArqs , _cPath+"SD2"+_cFIL+".DBF" )
     AAdd( VerArqs , _cPath+"SC7"+_cFIL+".DBF" )

     For _At:= 1 to Len( VerArqs )
         If !File( VerArqs[_At] )
            MsgStop("Problemas! Arquivo "+VerArqs[_At]+" Nao Encontrado. Verifique ...")
            _lArqNotFound:= .T.
         Endif
     Next _At

     For _In:=1 to Len(VerArqs)
         If !File( StrTran( VerArqs[_In] , "DBF", "CDX") )
            MsgStop("Problemas! Arquivo "+StrTran( VerArqs[_in] , "DBF", "CDX")+" Nao Encontrado. Verifique ...")
            _lArqNotFound:= .T.
         Endif
     Next _In

     If _lArqNotFound == .F.
        dbUseArea( .T. ,, _cPath+"SB2"+_cFIL,"_SB2", .F. , .F. )
        dbSetIndex(_cPath+"SB2"+_cFIL)
        dbUseArea( .T. ,, _cPath+"SB9"+_cFIL,"_SB9", .F. , .F. )
        dbSetIndex(_cPath+"SB9"+_cFIL)
        dbUseArea( .T. ,, _cPath+"SD2"+_cFIL,"_SD2", .F. , .F. )
        dbSetIndex(_cPath+"SD2"+_cFIL)
        dbUseArea( .T. ,, _cPath+"SC7"+_cFIL,"_SC7", .F. , .F. )
        dbSetIndex(_cPath+"SC7"+_cFIL)
     Endif

     // Incluir funcao para criar indice, caso nao exista.

Return


//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±³Fun‡„o    ³ FECHAFILIAIS³ Autor ³ Gilberto A de Oliveira³ Data ³ 15/12/99  ³±±
//±±³Descri‡„o ³ Fecha arquivo da filial aberta por AbreFiliais() para que o    ³±±
//±±³          ³ mesmo de outra filial possa posteriorme ser aberto,            ³±±
//±±³          ³ possibilitando assim a utilizacao de um mesmo Alias()          ³±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

Static Function FechaFiliais()

    _SB2->( DbClearInd() )
    _SB2->( DbCloseArea())
    _SB9->( DbClearInd() )
    _SB9->( DbCloseArea())
    _SC7->( DbClearInd() )
    _SC7->( DbCloseArea())
    _SD2->( DbClearInd() )
    _SD2->( DbCloseArea())

Return

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function PrepOutFil
Static Function PrepOutFil()

***
*** Primeira etapa :
***
***         Ver Estoque, conforme parametros.
***         MV_ULMES= DATA DO ULTIMO FECHAMENTO
***         SB2-> SALDOS FISICO & FINANCEIRO
***         SB9-> SALDOS INICIAIS
***

DbSelectArea( "SB1" )
DbSetOrder(1)
DbGotop()
ProcRegua( RecCount() )

While SB1->( !EOF() )

      IncProc("Aguarde... Selecionando dados..(SB1).")

      cCodGrp := SB1->B1_GRPMAR
      cCodSGrp:= SB1->B1_SGRPMAR
      cCodClas:= SB1->B1_CLASSE
      cCodForn:= SB1->B1_PROC       /// FORNECECEDOR PADRAO DO PRODUTO
      cCodProd:= SB1->B1_COD

      SZA-> ( DbSeek(xFilial("SZA")+SB1->B1_GRPMAR)  )
      SZB-> ( DbSeek(xFilial("SZB")+SB1->B1_SGRPMAR) )
      SZC-> ( DbSeek(xFilial("SZC")+SB1->B1_CLASSE)  )

      nTotPed:= 0           /// em quantidades pendentes de pedido
      nTotVen:= 0           /// em quantidades vendidas
      nTotSal:= 0           /// em quantidades do estoque (saldo)

      DbSelectArea( "_SC7" )
	  DbSetOrder(10)
      DbSeek(SM0->M0_CODFIL+SB1->B1_COD)

      While ( SB1->B1_COD == _SC7->C7_PRODUTO)

            If _sc7->c7_emissao >= mv_par01 .and. ;
               _sc7->c7_emissao <= mv_par02 .and. ;
               _sc7->c7_quant > _sc7->c7_quje
                nTotPed:= nTotPed + ( _SC7->C7_QUANT - _SC7->C7_QUJE )
            Endif

            DbSkip()

      End-While

      nTotGEmp1:= nTotGEmp1 + nTotPed

      DbSelectArea("_SD2")
	  DbSetOrder(6)
      DbSeek(SM0->M0_CODFIL+SB1->B1_COD )

      While !Eof() .and. ( _SD2->D2_COD == SB1->B1_COD )

              If _sd2->d2_emissao < mv_par01 .or. _sd2->d2_emissao > mv_par02
				 DbSkip()
				 Loop
			  Endif

              nTotVen:= nTotVen + _SD2->D2_QUANT

			  DbSkip()

      End-While
      nTotGEmp2:= nTotGEmp2 + nTotVen
      nTotGEmp3:= 0

      TotalFiliais()
      TotalGrupos()
      TotSubGrupo()
      TotalClasses()
      TotalProdutos()

      DbSelectArea("SB1")
      DbSkip()

End-While

Return


// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function PrepAtuFil
Static Function PrepAtuFil()

***
***
***
***
*** Primeira etapa :
***
***   Ver Estoque, conforme parametros.
***   MV_ULMES= DATA DO ULTIMO FECHAMENTO
***   SB2-> SALDOS FISICO & FINANCEIRO
***   SB9-> SALDOS INICIAIS
***
***

DbSelectArea( "SB1" )
DbSetOrder(1)
DbGotop()
ProcRegua( RecCount() )
While SB1->( !EOF() )
      IncProc("Aguarde... Selecionando guardando dados...")

      cCodGrp := SB1->B1_GRPMAR
      cCodSGrp:= SB1->B1_SGRPMAR
      cCodClas:= SB1->B1_CLASSE
      cCodForn:= SB1->B1_PROC       /// FORNECECEDOR PADRAO DO PRODUTO
      cCodProd:= SB1->B1_COD

      SZA-> ( DbSeek(xFilial("SZA")+SB1->B1_GRPMAR)  )
      SZB-> ( DbSeek(xFilial("SZB")+SB1->B1_SGRPMAR) )
      SZC-> ( DbSeek(xFilial("SZC")+SB1->B1_CLASSE)  )

      nTotPed:= 0           /// em quantidades pendentes de pedido
      nTotVen:= 0           /// em quantidades vendidas
      nTotSal:= 0           /// em quantidades do estoque (saldo)

      DbSelectArea( "SC7" )
	  DbSetOrder(10)
      DbSeek( SM0->M0_CODFIL+SB1->B1_COD )

      While ( SB1->B1_COD == SC7->C7_PRODUTO)

            If sc7->c7_emissao >= mv_par01 .And.;
               sc7->c7_emissao <= mv_par02 .And.;
               sc7->c7_quant > sc7->c7_quje
               nTotPed:= nTotPed + ( SC7->C7_QUANT - SC7->C7_QUJE )
            Endif
   
            DbSkip()

      End-While
      nTotGEmp1:= nTotGEmp1 + nTotPed

      DbSelectArea("SD2")
	  DbSetOrder(6)
      DbSeek(SM0->M0_CODFIL+SB1->B1_COD )
      While !Eof() .and. (SD2->D2_COD == SB1->B1_COD)

              If ( sd2->d2_emissao < mv_par01 ).or. ;
                 ( sd2->d2_emissao > mv_par02 )
				 DbSkip()
				 Loop
			  Endif

			  DbSelectArea("SF4")
			  DbSetOrder(1)
              DbSeek(xFilial("SF4")+SD2->D2_TES)
			  If SF4->F4_Duplic <> "S"
                 DbSelectArea("SD2")
				 DbSkip()
				 Loop
			  Endif
              DbSelectArea("SD2")

              nTotVen:= nTotVen + SD2->D2_QUANT

			  DbSkip()

      End-While

      nTotGEmp2:= nTotGEmp2 + nTotVen
      nTotGEmp3:= 0

      TotalFiliais()
      TotalGrupos()
      TotSubGrupo()
      TotalClasses()
      TotalProdutos()

      DbSelectArea( "SB1" )
      DbSkip()

End-While

Return


// GERACAO DOS TOTAIS DIRETAMENTE NO ARQUIVO DE TRABALHO, ATRAVES DE BUSCA
// DE REGISTROS PLANEJADOS. ESSSA LOGICA PERDE E SIMPLES, DA-SE UM SEEK
// NO ARQUIVO DE TRABALHO, BUSCANDO-SE UM REGISTRO ESPECIFICO QUE GUARDARA
// O TOTAL PLANEJADO PARA ELE.
// EVITA-SE A UTILIZACAO DE VARIOS WHILE'S, MAS PERDE-SE UM POUCO DE TEMPO
// PARA GRAVACAO DO REGISTRO. NO ENTANTO, SEM UTILIZAR-SE DO DBCOMMIT
// ESSE TIPO DE GRAVACAO MOSTRA-SE MAIS RAPIDO DO QUE SE FOSSE UTILIZADO
// UM VETOR EM CONJUNTO COM ASCAN.


/* ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

   Gera um total geral da filial

   a ideia e gravar os valores em um registro que nao indique grupo,
   sub-grupo, classe, fornecedor ou produto.
   Dessa forma acumulo em um unico registro o total geral da filial,
   sem precisar somar mais tarde todos os valores para apresentar
   na consulta.

   ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ */

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION TotalFiliais
Static FUNCTION TotalFiliais()

_cChave1:= xFilial("SZD")+SM0->M0_CODFIL+Space(27)

DbSelectArea("SZD")
DbSetOrder(1)
If (DbSeek(_cChave1))
   RecLock( "SZD" , .F. )
   FAcumula()
Else
   RecLock( "SZD" , .T. )
   SZD->ZD_CODFIL:= SM0->M0_CODFIL
   FNovo()
Endif
MsUnlock()

Return

/* ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

   Total dos grupos, por filial e geral do escopo pedido.
   segue o mesmo raciocinio da funcao anterior, so que agora encontra-se
   o grupo sem filial, que e o registro comum para gravacao nesse grupo
   dos valores de todas as filiais e encontra-se o registro onde se tem o
   grupo por filiais, gravando-se assim os valores por filiais.

   ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ */

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION TotalGrupos
Static FUNCTION TotalGrupos()

DbSelectArea("SZD")
DbSetOrder(1)

_cChave2 := xFilial("SZD")+Space(02)+cCodGrp+Space(25)      // p/buscar grupo geral
_cChave2a:= xFilial("SZD")+SM0->M0_CODFIL+cCodGrp+Space(25) // p/buscar grupo por filial

If DbSeek(_cChave2)
   RecLock( "SZD" , .F. )
   FAcumula()
Else
   RecLock( "SZD" , .T. )
   SZD->ZD_GRPMAR:= cCodGRP
   SZD->ZD_DESGRP:= Left(SZA->ZA_DESC,15)
   FNovo()
Endif

If DbSeek(_cChave2a)
   RecLock( "SZD" , .F. )
   FAcumula()
Else
   RecLock( "SZD" , .T. )
   SZD->ZD_CODFIL:= SM0->M0_CODFIL
   SZD->ZD_GRPMAR:= cCodGRP
   SZD->ZD_DESGRP:= Left(SZA->ZA_DESC,15)
   FNovo()
Endif
MsUnlockAll()

Return

/* ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ




   ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ */

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION TotSubGrupo
Static FUNCTION TotSubGrupo()

DbSelectArea("SZD")
DbSetOrder(1)

_cChave3 := xFilial("SZD")+Space(02)+cCodGrp+cCodSgrp+Space(23)
_cChave3a:= xFilial("SZD")+SM0->M0_CODFIL+cCodGrp+cCodSgrp+Space(23)

If DbSeek( _cChave3 )
   RecLock( "SZD" , .F. )
   FAcumula()
Else
   RecLock( "SZD" , .T. )
   SZD->ZD_GRPMAR  := cCodGrp
   SZD->ZD_SGRPMAR := cCodSgrp
   SZD->ZD_DESSGRP := Left(SZB->ZB_DESC,15)
   FNovo()
Endif

If DbSeek( _cChave3a )
   RecLock( "SZD" , .F. )
   FAcumula()
Else
   RecLock( "SZD" , .T. )
   SZD->ZD_CODFIL  := SM0->M0_CODFIL
   SZD->ZD_GRPMAR  := cCodGrp
   SZD->ZD_SGRPMAR := cCodSgrp
   SZD->ZD_DESSGRP := Left(SZB->ZB_DESC,15)
   FNovo()
Endif

MsUnlockAll()

Return

/* ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ */

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION TotalClasses
Static FUNCTION TotalClasses()

DbSelectArea("SZD")
DbSetOrder(1)

_cChave4 := xFilial("SZD")+Space(02)+cCodGrp+cCodSgrp+cCodClas+Space(21)
_cChave4a:= xFilial("SZD")+SM0->M0_CODFIL+cCodGrp+cCodSgrp+cCodClas+Space(21)

If DbSeek( _cChave4 )
   RecLock( "SZD" , .F. )
   FAcumula()
Else
   RecLock( "SZD" , .T. )
   SZD->ZD_GRPMAR  := cCodGrp
   SZD->ZD_SGRPMAR := cCodSGrp
   SZD->ZD_CLASSE  := cCodClas
   SZD->ZD_DESCLA  := Left(SZC->ZC_DESC,15)
   FNovo()
Endif

If DbSeek( _cChave4a )
   RecLock( "SZD" , .F. )
   FAcumula()
Else
   RecLock( "SZD" , .T. )
   SZD->ZD_CODFIL  := SM0->M0_CODFIL
   SZD->ZD_GRPMAR  := cCodGrp
   SZD->ZD_SGRPMAR := cCodSGrp
   SZD->ZD_CLASSE  := cCodClas
   SZD->ZD_DESCLA  := Left(SZC->ZC_DESC,15)
   FNovo()
Endif

MsUnlockAll()

Return

/* ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ */

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION TotalProdutos
Static FUNCTION TotalProdutos()

DbSelectArea("SZD")
DbSetOrder(1)

_cChave5 := xFilial("SZD")+Space(02)+cCodGrp+cCodSgrp+cCodClas+cCodForn+cCodProd
_cChave5a:= xFilial("SZD")+SM0->M0_CODFIL+cCodGrp+cCodSgrp+cCodClas+cCodForn+cCodProd

If DbSeek( _cChave5 )
   RecLock( "SZD" , .F. )
   FAcumula()
Else
   RecLock( "SZD" , .T. )
   SZD->ZD_GRPMAR  := cCodGrp
   SZD->ZD_SGRPMAR := cCodSGrp
   SZD->ZD_CLASSE  := cCodClas
   SZD->ZD_DESCLA  := Left(SZC->ZC_DESC,15)
   SZD->ZD_CODPROD := cCodProd
   SZD->ZD_DESPRO  := SB1->B1_DESC
   FNovo()
Endif

If DbSeek( _cChave5a )
   RecLock( "SZD" , .F. )
   FAcumula()
Else
   RecLock( "SZD" , .T. )
   SZD->ZD_CODFIL  := SM0->M0_CODFIL
   SZD->ZD_GRPMAR  := cCodGrp
   SZD->ZD_SGRPMAR := cCodSGrp
   SZD->ZD_CLASSE  := cCodClas
   SZD->ZD_DESCLA  := Left(SZC->ZC_DESC,15)
   SZD->ZD_CODPROD := cCodProd
   SZD->ZD_DESPRO  := SB1->B1_DESC
   FNovo()
Endif
MsUnlockAll()
DbCommitAll()

Return

************************


************************

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function FAcumula
Static Function FAcumula()
SZD->ZD_Estoque := SZD->ZD_Estoque + 0       /// RESERVADO PARA SE BUSCAR O ESTOQUE
SZD->ZD_Vendas  := SZD->ZD_Vendas  + nTotVen
SZD->ZD_PedAber := SZD->ZD_PedAber + nTotPed
Return

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function FNovo
Static Function FNovo()
SZD->ZD_Estoque := 0
SZD->ZD_Vendas  := nTotVen
SZD->ZD_PedAber := nTotPed
Return

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ cSaldo1  ³ Autor ³ Antonio F.D.Filho     ³ Data ³ 23.08.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Busca Saldo do Produto                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ cSaldo1                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function CSaldo1
Static Function CSaldo1()

n_DatacSal := CTOD("01"+Subs( DTOC(MV_PAR01),3))-1 //ULTIMO DIA DO MES ANTERIOR

dbSelectArea("SB9")
dbSetOrder(1)
dbSeek(xFilial("SB9")+SB1->B1_COD+SB1->B1_LOCPAD+DTOS(n_DatacSal))

If Found()
   n_SaldoAtu := SB9->B9_QINI
Else
   n_SaldoAtu := 0
End

dbSelectArea("SD1")
dbSetOrder(5)
dbSeek(xFilial("SD1")+SB1->B1_COD,.T.)

While !Eof() .And. SD1->D1_COD == SB1->B1_COD

   If SD1->D1_DTDIGIT >= n_DatacSal .AND. SD1->D1_DTDIGIT <= MV_PAR02
      
      dbSelectArea("SF4")
      dbSetOrder(1)
      dbSeek(xFilial()+SD1->D1_TES)

      If SF4->F4_ESTOQUE == "S"
         n_SaldoAtu := n_SaldoAtu + SD1->D1_QUANT      
      End
   
      DBSELECTAREA("SD1")

   End

   DBSKIP()
      
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acumulando dados do Arquivo de Movimentacoes                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SD3")
dbSetOrder(3)
dbSeek(xFilial("SD3")+SB1->B1_COD,.T.)

While !Eof() .And. SD3->D3_COD == SB1->B1_COD

   If SD3->D3_EMISSAO >= n_DatacSal .AND. SD3->D3_EMISSAO <= MV_PAR02

      If SUBS(SD3->D3_CF,1,2) $ "PR/DE"
         n_SaldoAtu := n_SaldoAtu + SD3->D3_QUANT
      ElseIf SUBS(SD3->D3_CF,1,2) $ "RE/ER"
         n_SaldoAtu := n_SaldoAtu - SD3->D3_QUANT
      End

   End

   dbSkip()
      
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acumulando dados do Arquivo de Saidas                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SD2")
dbSetOrder(6)
dbSeek(xFilial("SD2")+SB1->B1_COD,.T.)

While !Eof() .And. SD2->D2_COD == SB1->B1_COD

   If SD2->D2_EMISSAO >= n_DatacSal .AND. SD2->D2_EMISSAO <= MV_PAR02

      dbSelectArea("SF4")
      dbSetOrder(1)
      dbSeek(xFilial()+SD2->D2_TES) 

      If SF4->F4_ESTOQUE == "S"
         n_SaldoAtu := n_SaldoAtu - SD2->D2_QUANT
      End  

      dbSelectArea("SD2")

   End  

   dbSkip()
      
End

ReTurn .t.

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ cSaldo1A ³ Autor ³ Antonio F.D.Filho     ³ Data ³ 23.08.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Busca Saldo do Produto  (PARA OUTRAS FILIAIS)              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ cSaldo1                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function CSaldo1A
Static Function CSaldo1A()

// MV_ULMES = DATA DO ULTIMO FECHAMENTO DO ESTOQUE

n_DatacSal := CTOD("01"+Subs( DTOC(MV_PAR01),3))-1 //ULTIMO DIA DO MES ANTERIOR

dbSelectArea("_SB9")
dbSetOrder(1)
dbSeek(xFilial("_SB9")+SB1->B1_COD+SB1->B1_LOCPAD+DTOS(n_DatacSal))

If Found()
   n_SaldoAtu := _SB9->B9_QINI
Else
   n_SaldoAtu := 0
End

dbSelectArea("_SD1")
dbSetOrder(5)
dbSeek(xFilial("_SD1")+SB1->B1_COD,.T.)

While !Eof() .And. _SD1->D1_COD == SB1->B1_COD

   If _SD1->D1_DTDIGIT >= n_DatacSal .AND. _SD1->D1_DTDIGIT <= MV_PAR02
      
      dbSelectArea("SF4")
      dbSetOrder(1)
      dbSeek(xFilial()+_SD1->D1_TES)

      If SF4->F4_ESTOQUE == "S"
         n_SaldoAtu := n_SaldoAtu + _SD1->D1_QUANT
      End
   
      DBSELECTAREA("_SD1")

   End

   DBSKIP()
      
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acumulando dados do Arquivo de Movimentacoes                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("_SD3")
dbSetOrder(3)
dbSeek(xFilial("_SD3")+SB1->B1_COD,.T.)

While !Eof() .And. _SD3->D3_COD == SB1->B1_COD

   If _SD3->D3_EMISSAO >= n_DatacSal .AND. _SD3->D3_EMISSAO <= MV_PAR02

      If SUBS(_SD3->D3_CF,1,2) $ "PR/DE"
         n_SaldoAtu := n_SaldoAtu + _SD3->D3_QUANT
      ElseIf SUBS(_SD3->D3_CF,1,2) $ "RE/ER"
         n_SaldoAtu := n_SaldoAtu - _SD3->D3_QUANT
      End

   End

   dbSkip()
      
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acumulando dados do Arquivo de Saidas                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("_SD2")
dbSetOrder(6)
dbSeek(xFilial("_SD2")+SB1->B1_COD,.T.)

While !Eof() .And. _SD2->D2_COD == SB1->B1_COD

   If _SD2->D2_EMISSAO >= n_DatacSal .AND. _SD2->D2_EMISSAO <= MV_PAR02

      dbSelectArea("SF4")
      dbSetOrder(1)
      dbSeek(xFilial()+_SD2->D2_TES)

      If SF4->F4_ESTOQUE == "S"
         n_SaldoAtu := n_SaldoAtu - SD2->D2_QUANT
      End  

      dbSelectArea("_SD2")

   End  

   dbSkip()
      
End

ReTurn .t.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³VALIDPERG ³ Autor ³  Luiz Carlos Vieira	³ Data ³ 16/07/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica as perguntas inclu¡ndo-as caso n„o existam		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ Espec¡fico para clientes Microsiga						  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _ValidPerg
Static Function _ValidPerg()
_sAlias := Alias()

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)
aRegs :={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

AADD(aRegs,{cPerg,"01","Apurar Periodo de  ?","mv_ch1","D",08,0,1,"G","","mv_par01","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","              ate  ?","mv_ch2","D",08,0,1,"G","","mv_par02","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Filiais de         ?","mv_ch3","C",02,0,0,"G","","mv_par03","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Filiais ate        ?","mv_ch4","C",02,0,0,"G","","mv_par04","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next
dbSelectArea(_sAlias)

Return

