#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 18/08/00

User Function Facfi91()        // incluido pelo assistente de conversao do AP5 IDE em 18/08/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CSTRING,CDESC1,CDESC2,CDESC3,TAMANHO,CPERG")
SetPrvt("ARETURN,NOMEPROG,ALINHA,NLASTKEY,NLIN,TITULO")
SetPrvt("CABEC1,CABEC2,CCANCEL,M_PAG,WNREL,CARQTXT")
SetPrvt("_LARQTXT,NTAMLIN,CARQ,NHDL,CBUFFER,NBYTES")
SetPrvt("_ASTRU,_CARQTRAB,NVALOR,NVLRJU,NVLRMU,NVLRLI")
SetPrvt("_NCNTTIT,_NCNTMOV,_LSEMCLASS,_LSEMMAT,_LSEMVALOR,_LSEMDTFAT")
SetPrvt("_LSEMDTVEN,_LEXISTALU,_LEXISTCUR,_LEXISTTIT,_LTITOK,CNATUREZ")
SetPrvt("CCC,CCODCLI,CLOJCLI,CNOMCLI,_CINCONSIST,NREG")
SetPrvt("NABATI,AAREA")

/*/
--------------------------------------------------------------------
  T¡tulo:         FACFI91.prw
  Descricao:      Integracao SIGA
  DtCriacao:      16,Ago.2000
  DtUltAtl:       16,Ago.2000
--------------------------------------------------------------------
/*/

//_______Relatorio de inconsistencias_______________________________________

cString     :="SE1"
cDesc1      :=OemToAnsi("Este programa emite o relatorio de inconsistencias da ")
cDesc2      :=OemToAnsi("importacao dos titulos a receber.")
cDesc3      :=OemToAnsi("Especifico UNIFACS ")
tamanho     :="M"
cPerg       :="FAC003"
aReturn     :={"Zebrado",1,"Administracao",1,2,1,"",1}
nomeprog    :="FACFI91"
aLinha      := {}
nLastKey    := 0
nLin        := 0
titulo      :="RELATORIO DE INCONSISTENCIAS DA IMPORTACAO DE TITULOS"
cabec1      :="INCONSISTENCIA                            MATRICULA    LINHA DO TXT "
***************123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
cabec2      :=""
cCancel     :="####### CANCELADO PELO OPERADOR ###########"
m_pag       :=  1           // Variavel que acumula numero da pagina.
wnrel       := "FACFI91"    // Nome Default deste Relatorio em disco.
_nCntTit    := 0
_nCntMov    := 0

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"",.f.,tamanho)

  If nLastkey == 27 .or. LastKey() == 27
       Set Filter to
       Return
  EndIf

  Pergunte(cPerg,.F.)
  //  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  //  ³   Variaveis carregadas pelo Pergunte    FAC003         ³
  //  ³   mv_par01        Arquivo de Origem       ?     C,30,0 ³
  //  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  SetDefault(aReturn,cString)

  If nLastkey == 27 .or. LastKey() == 27
       Set Filter to
       Return
  EndIf

//__Verifica se existe o Arquivo no Path____________________________________

cArqtxt := Alltrim(MV_PAR01)

If File( cArqtxt )
   RptStatus({||RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 18/08/00 ==>    RptStatus({||Execute(RptDetail)})
Else
   MsgBox("Nao foi encontrado o arquivo de importacao.","ATENCAO","ALERT")
   Set Filter To
   Return
EndIf

Return


// Substituido pelo assistente de conversao do AP5 IDE em 18/08/00 ==> Function RptDetail
Static Function RptDetail()

  DbSelectArea("SA1")
  aArea := GetArea()
  
  fLocArqs()
  If _lArqtxt := .f.
     fLocArqs()
  EndIf

  DbSelectArea("TRB")
  SetRegua(RecCount())
  nLin := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)

  fLinha()

  Index on MAT+DTOS(EMISSAO)+PRIORI  to TRB2
  //DbSetOrder(1)
  DbGoTop()
  msgbox("INICIANDO IMPORTACAO","ANTES DO WHILE","INFO")
  While !Eof()
     fInconsist()
     If _lTitOk 
        // Titulo  Ok. Sem Problemas
        fImpToSE1()
     Endif 
     DbSelectArea("TRB")
     DbSkip()
     IncRegua()
  End
  
  msgbox("TERMINANDO IMPORTACAO","DEPOIS DO WHILE","INFO")
  
  fImpTot()  // Imprime totais de titulos importados

  DbSelectArea("TRB")
  DbCloseArea()

  *****
  DELETE FILE _cArqTrab.DBF
  DELETE FILE C:\AP5\SIGAADV\TRB1.CDX
  DELETE FILE C:\AP5\SIGAADV\TRB2.CDX  
  *****

  dbSelectArea(cString)
  Roda(0,"",tamanho)     // Funcao padrao para impressao do rodape dos relatorios.
  Set Filter To
  
  DbSelectArea("SA1")
  RestArea(aArea)

  If aReturn[5] == 1
      //  Testa se o relatorio foi direcionado para disco, esvazia
      //  os Buffers e chama funcao de Spool padrao.
      Set Printer To
      Commit
      ourspool( wnrel )
  EndIf
  MS_FLUSH()      // Libera fila de relatorios em spool.
Return


// Substituido pelo assistente de conversao do AP5 IDE em 18/08/00 ==> Function fLocArqs
Static Function fLocArqs()

  //_______Importacao txt > dbf_______________________________________________
  nTamLin := 107              // Tamanho da linha no arquivo texto
  cArq    := "ORIGEM.TXT"     // Arquivo texto a importar
  nHdl    := NIL              // Handle para abertura do arquivo
  cBuffer := Space(nTamLin)   // Variavel para leitura
  nBytes  := 0                // Variavel para verificacao do fim de arquivo

  //__Busca Arquivo Origem_txt________________________________________________
  If File( cArqtxt )

      // Transporta de TXT para DBF
      _aStru:={}

      aadd(_aStru,{"FILIAL"      , "C",2 ,0  })    //      Identifica Filial - Preencher com "01"
      aadd(_aStru,{"NUM"         , "C",6 ,0  })    //      Numero do Titulo
      aadd(_aStru,{"TIPO"        , "C",3 ,0  })    //      Tipo
      aadd(_aStru,{"CLAS"       , "C",2 ,0  })    //      Classificacao
      aadd(_aStru,{"NATUREZ"     , "C",10,0  })    //      Natureza
      aadd(_aStru,{"MAT"         , "C",9 ,0  })    //      Matricula
      aadd(_aStru,{"CLIENTE"     , "C",6 ,0  })    //      Cliente
      aadd(_aStru,{"LOJA"        , "C",2 ,0  })    //      Loja
      aadd(_aStru,{"NOMCLI"      , "C",20,0  })    //      Nome do Cliente
      aadd(_aStru,{"EMISSAO"     , "D",8 ,0  })    //      Emissao
      aadd(_aStru,{"VENCTO"      , "D",8 ,0  })    //      Vencto
      aadd(_aStru,{"VENCREA"     , "D",8 ,0  })    //      Vencto Real
      aadd(_aStru,{"VALOR"       , "N",17,2  })    //      Valor Original
      aadd(_aStru,{"BAIXA"       , "D",8 ,0  })    //      Data Baixa
      aadd(_aStru,{"EMIS1"       , "D",8 ,0  })    //      
      aadd(_aStru,{"HIST"        , "C",25,0  })    //      Historico
      aadd(_aStru,{"MOVIMEN"     , "D",8 ,0  })    //      
      aadd(_aStru,{"SITUACA"     , "C",1 ,0  })    //      Situacao do titulo
      aadd(_aStru,{"SALDO"       , "N",17,2  })    //      Saldo do titulo
      aadd(_aStru,{"DESCONT"     , "N",17,2  })    //      Vlr Desconto
      aadd(_aStru,{"MULTA"       , "N",17,2  })    //      Vlr Multa
      aadd(_aStru,{"JUROS"       , "N",17,2  })    //      Vlr Juros
      aadd(_aStru,{"VALLIQ"      , "N",17,2  })    //      Vlr Liquido
      aadd(_aStru,{"VENCORI"     , "D",8 ,0  })    //      
      aadd(_aStru,{"MOEDA"       , "N",2 ,0  })    //      Moeda
      aadd(_aStru,{"OCORREN"     , "C",2 ,0  })    //      Ocorrencia
      aadd(_aStru,{"VLCRUZ"      , "N",18,2  })    //      Valor Original
      aadd(_aStru,{"STATUS"      , "C",1 ,0  })    //      Status
      aadd(_aStru,{"ORIGEM"      , "C",8 ,0  })    //      Origem
      aadd(_aStru,{"FLUXO"       , "C",1 ,0  })    //      Fluxo de Caixa
      aadd(_aStru,{"CCUSTO"      , "C",9 ,0  })    //      Centro de Custo
      aadd(_aStru,{"BANCO"       , "C",3 ,0  })    //      Banco
      aadd(_aStru,{"AGENCIA"     , "C",4 ,0  })    //      Agencia
      aadd(_aStru,{"CONTAC"      , "C",7 ,0  })    //      Conta Corrente
      aadd(_aStru,{"PRIORI"        , "C",1 ,0  })    //      Prioridade de Importacao

       _cArqTrab := CriaTrab(_aStru,.t.)
       DbUseArea(.t.,, _cArqTrab ,"TRB",.t.)
       //Index on NUM+TIPO  to TRB1
       Index on MAT+DTOS(EMISSAO)+TIPO  to TRB1

       //--------Importacao para Arquivo de Trabalho____________________
       //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
       //³ Processos iniciais...                              ³
       //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

       nHdl := fOpen(cArqtxt,2) // Abre o arquivo
       If nHdl == -1
         MSGBOX("ERRO!!!","ATENCAO","INFO")
         Return
       Endif

       nBytes := fRead(nHdl,@cBuffer,nTamLin) // Le uma linha

       // O seguinte loop permanecera executando ate que nao consigamos ler mais
       // uma linha inteira. Por isso a necessidade de que o arquivo contenha linhas
       // do mesmo tamanho.

       // Mais dois por causa das marcas de final de linha (CHR(13)+CHR(10))
       nValor := 0
       nVlrJu := 0
       nVlrMu := 0
       nVlrLi := 0
       While nBytes == nTamLin
         //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
         //³ Neste momento, ja temos uma linha lida. Gravamos os valores ³
         //³ obtidos retirando-os da linha lida.                         ³
         //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

         dbSelectArea("TRB") // Arquivo de Trabalho
         RecLock("TRB",.T.) // Inclui um registro novo e trava

            TRB->FILIAL  := "01"
            //TRB->NUM     := Substr(cBuffer,012,06)
            TRB->TIPO    := Substr(cBuffer,001,02)
            TRB->CLAS   := Substr(cBuffer,003,02)            
            TRB->MAT     := Substr(cBuffer,005,09)
            TRB->EMISSAO := CTOD("01"+"/"+Substr(cBuffer,018,02)+"/"+Substr(cBuffer,016,02))
            //dData := CTOD("01"+"/"+Substr(cBuffer,014,02)+"/"+Substr(cBuffer,016,02))
            //MSGBOX(DTOC(dData),"DT EMISSAO","INFO")
            TRB->EMIS1   := CTOD("01/"+Substr(cBuffer,018,02)+"/"+Substr(cBuffer,016,02))
            TRB->VENCTO  := CTOD(Substr(cBuffer,034,02)+"/"+Substr(cBuffer,036,02)+"/"+Substr(cBuffer,040,02))
            TRB->VENCREA := CTOD(Substr(cBuffer,034,02)+"/"+Substr(cBuffer,036,02)+"/"+Substr(cBuffer,040,02))
            TRB->VENCORI := CTOD(Substr(cBuffer,034,02)+"/"+Substr(cBuffer,036,02)+"/"+Substr(cBuffer,040,02))
            TRB->SITUACA := "0"
            TRB->FLUXO   := "S"
            TRB->ORIGEM  := "FINA040"
            TRB->MOEDA   := 1
            TRB->HIST      := Substr(cBuffer,003,02) + " REF .: " + Substr(cBuffer,018,02)+"/"+Substr(cBuffer,014,04)
            If Substr(cBuffer,003,02) == "MB" .Or. Substr(cBuffer,003,02) == "ND";
               .Or. Substr(cBuffer,003,02) == "NC"
               TRB->OCORREN := "01"
               TRB->PRIORI     := "1"
            Else
               TRB->OCORREN := "04"
               TRB->PRIORI     := "2"
            EndIf
            nValor       := VAL(Substr(cBuffer,020,14)) / 100
            //nValor       :=  
            //nValor       := INT(nValor)/100
            TRB->VALOR   := nValor
            TRB->VLCRUZ  := nValor

            nVlrJu       := VAL(Substr(cBuffer,042,14)) / 100
            If nVlrJu > 0
               //nVlrJu    := INT(nVlrJu)/100
               TRB->JUROS:= nVlrJu
            EndIf

            nVlrMu       := VAL(Substr(cBuffer,056,14)) / 100
            If nVlrMu > 0
               //nVlrMu    := INT(nVlrMu)/100
               TRB->MULTA:= nVlrMu
            EndIf

            nVlrLi       := VAL(Substr(cBuffer,070,14)) / 100
            //nVlrLi       := INT(nVlrLi)/100
            TRB->VALLIQ  := nVlrLi

            If !Empty(ALLTRIM(Substr(cBuffer,084,08)))
               TRB->BAIXA   := CTOD(Substr(cBuffer,084,02)+"/"+Substr(cBuffer,086,02)+"/"+Substr(cBuffer,090,02))
               TRB->MOVIMEN := CTOD(Substr(cBuffer,084,02)+"/"+Substr(cBuffer,086,02)+"/"+Substr(cBuffer,090,02))
               TRB->STATUS  := "B"
            Else
               TRB->SALDO   := nValor
               TRB->STATUS  := "A"
            EndIf

            If !Empty(ALLTRIM(Substr(cBuffer,084,08)))
               TRB->BANCO   := "999"
               TRB->AGENCIA := "999"
               TRB->CONTAC  := "999"
            Else
               TRB->BANCO   := Substr(cBuffer,092,03)
               TRB->AGENCIA := Substr(cBuffer,095,04)
               TRB->CONTAC  := Substr(cBuffer,099,07)
            EndIf

         MsUnLock() // Destrava o registro
         nBytes := fRead(nHdl,@cBuffer,nTamLin) // Le mais uma linha

       End

       fClose(nHdl) // Fecha o arquivo

       AcerTRB()

       //_______________________________________________________________

      _lArqtxt := .t.
   Else
     MsgBox("Nao foi encontrado o arquivo indicado.","ATENCAO","INFO")
     Pergunte(cPerg,.t.)
     _lArqtxt := .f.
  Endif
Return


// Substituido pelo assistente de conversao do AP5 IDE em 18/08/00 ==> Function fImpToSE1
Static Function fImpToSE1()

   If TRB->CLAS == "MB" .Or. TRB->CLAS == "ND" .Or. TRB->CLAS == "NC"
      cLetraSeq:= Space(1)
      cNumSeq := GETMV("MV_SEQTIT")
   Else
      cNumSeq := GETMV("MV_SEQTIT")
   EndIf
  //__Importa para SE1 - Contas a Receber __________________________________

  //__Processa Registro_____________________________________________________

   DbSelectArea("SE1")
   Reclock("SE1",.T.)

          REPLACE E1_FILIAL   WITH xFILIAL()
          
          If TRB->CLAS == "MB" .Or. TRB->CLAS == "ND" .Or. TRB->CLAS == "NC"          
             REPLACE E1_NUM      WITH cNumSeq
          Else
             cNumSeq := Substr(cNumSeq,1,1) + StrZero(Val(Substr(cNumSeq,2,5))-1,5)
             REPLACE E1_NUM      WITH cNumSeq
          EndIf
 
          //MSGBOX(TRB->TIPO,"TIPO DO TITULO","INFO")
          
          If TRB->CLAS == "MB"
             REPLACE E1_TIPO     WITH TRB->TIPO
          ElseIf TRB->CLAS == "ND"
             REPLACE E1_TIPO     WITH "NDC"
          ElseIf TRB->CLAS == "NC"
             REPLACE E1_TIPO     WITH "NCC"
          Else
             REPLACE E1_TIPO     WITH Alltrim(TRB->CLAS)+"-"
          EndIf
          
          REPLACE E1_NATUREZ  WITH TRB->NATUREZ
          REPLACE E1_MAT      WITH TRB->MAT
          REPLACE E1_CLIENTE  WITH TRB->CLIENTE
          REPLACE E1_LOJA     WITH TRB->LOJA
          REPLACE E1_NOMCLI   WITH TRB->NOMCLI
          REPLACE E1_EMISSAO  WITH TRB->EMISSAO
          REPLACE E1_VENCTO   WITH TRB->VENCTO
          REPLACE E1_VENCREA  WITH TRB->VENCREA
          REPLACE E1_VALOR    WITH TRB->VALOR
          REPLACE E1_EMIS1    WITH TRB->EMIS1
          REPLACE E1_HIST     WITH TRB->HIST
          REPLACE E1_SITUACA  WITH TRB->SITUACA
          REPLACE E1_SALDO    WITH TRB->SALDO
          REPLACE E1_DESCONT  WITH TRB->DESCONT
          REPLACE E1_MULTA    WITH TRB->MULTA
          REPLACE E1_JUROS    WITH TRB->JUROS
          REPLACE E1_HIST     WITH TRB->HIST
          
          If TRB->BAIXA <> CTOD("  /  /  ")
              REPLACE E1_BAIXA    WITH TRB->BAIXA          
              REPLACE E1_VALLIQ   WITH TRB->VALLIQ + TRB->MULTA + TRB->JUROS
              REPLACE E1_MOVIMEN  WITH TRB->MOVIMEN
          EndIf          
          
          REPLACE E1_VENCORI  WITH TRB->VENCORI
          REPLACE E1_MOEDA    WITH TRB->MOEDA
          REPLACE E1_OCORREN  WITH TRB->OCORREN
          REPLACE E1_VLCRUZ   WITH TRB->VLCRUZ
          REPLACE E1_STATUS   WITH TRB->STATUS
          REPLACE E1_ORIGEM   WITH TRB->ORIGEM
          REPLACE E1_FLUXO    WITH TRB->FLUXO
          REPLACE E1_CCUSTO   WITH TRB->CCUSTO

          If TRB->CLAS == "MB" .Or. TRB->CLAS == "ND" .Or. TRB->CLAS == "NC"

             If TRB->BAIXA <> CTOD("  /  /  ")
                fImpToSE5()
              EndIf

          EndIf

   MsUnlock()
   If TRB->CLAS == "MB" .Or. TRB->CLAS == "ND" .Or. TRB->CLAS == "NC"  
      cNumSeq := Substr(GETMV("MV_SEQTIT"),2,5)
      cNumSeq := StrZero(Val(cNumSeq)+1,5)
      cLetraSeq:= Substr(GETMV("MV_SEQTIT"),1,1)
   
      If cNumSeq == "99999"
         cNumSeq := "00000"
         If cLetraSeq == "A"
            cLetraSeq := "B"
         ElseIf cLetraSeq == "B"
            cLetraSeq := "C"
         ElseIf cLetraSeq == "C"
            cLetraSeq := "D"
         ElseIf cLetraSeq == "D"
            cLetraSeq := "E"
         ElseIf cLetraSeq == "E"
            cLetraSeq := "F"
         ElseIf cLetraSeq == "F"
            cLetraSeq := "G"
         ElseIf cLetraSeq == "G"
            cLetraSeq := "H"
         ElseIf cLetraSeq == "H"
            cLetraSeq := "I"
         ElseIf cLetraSeq == "I"
            cLetraSeq := "J"
         ElseIf cLetraSeq == "J"
            cLetraSeq := "K"
         ElseIf cLetraSeq == "K"
            cLetraSeq := "L"
         ElseIf cLetraSeq == "L"
            cLetraSeq := "M"
         ElseIf cLetraSeq == "M"
            cLetraSeq := "N"
         ElseIf cLetraSeq == "N"
            cLetraSeq := "O"
         ElseIf cLetraSeq == "O"
            cLetraSeq := "P"
         ElseIf cLetraSeq == "P"
            cLetraSeq := "Q"
         ElseIf cLetraSeq == "Q"
            cLetraSeq := "R"
         ElseIf cLetraSeq == "R"
            cLetraSeq := "S"
         ElseIf cLetraSeq == "S"
            cLetraSeq := "T"
         ElseIf cLetraSeq == "T"
            cLetraSeq := "U"
         ElseIf cLetraSeq == "U"
            cLetraSeq := "V"
         ElseIf cLetraSeq == "V"
            cLetraSeq := "W"
         ElseIf cLetraSeq == "W"
            cLetraSeq := "X"
         ElseIf cLetraSeq == "X"
            cLetraSeq := "Y"
         ElseIf cLetraSeq == "Y"
            cLetraSeq := "Z"
         EndIf
      EndIf
      cNumSeq := cLetraSeq + cNumSeq
   
      If cNumSeq == "Z99998"
         MsgBox("A Numeracao sequencial dos titulos a receber terminou !!! ","Favor entrar em contato com a Microsiga","INFO")
      EndIf
   
      RecLock("SX6",.F.)
          Replace X6_CONTEUD WITH cNumSeq
      MsUnlock()
   EndIf
   // Alimenta contador de Titulos importados
    _nCntTit := _nCntTit + 1

Return

// Substituido pelo assistente de conversao do AP5 IDE em 18/08/00 ==> Function fImpToSE5
Static Function fImpToSE5()

  //__Importa para SE5 - Movimento Bancario ________________________________

  //__Processa Registro_____________________________________________________

   DbSelectArea("SE5")
   Reclock("SE5",.T.)

          REPLACE E5_FILIAL   WITH xFILIAL()
          REPLACE E5_DATA     WITH SE1->E1_BAIXA
          REPLACE E5_TIPO     WITH SE1->E1_TIPO
          REPLACE E5_VALOR    WITH SE1->E1_VALLIQ
          REPLACE E5_NATUREZ  WITH SE1->E1_NATUREZ
          REPLACE E5_BANCO    WITH "999"
          REPLACE E5_AGENCIA  WITH "999"
          REPLACE E5_CONTA    WITH "999"
          REPLACE E5_RECPAG   WITH "R"
          REPLACE E5_HISTOR   WITH "Valor recebido s/ Titulo"
          REPLACE E5_TIPODOC  WITH "VL"
          REPLACE E5_VLMOED2  WITH SE1->E1_VALLIQ
          REPLACE E5_LA       WITH "N"
          REPLACE E5_NUMERO   WITH SE1->E1_NUM
          REPLACE E5_CLIFOR   WITH SE1->E1_CLIENTE
          REPLACE E5_LOJA     WITH SE1->E1_LOJA
          REPLACE E5_DTDIGIT  WITH SE1->E1_BAIXA
          
          REPLACE E5_DTDISPO WITH SE1->E1_BAIXA
          
          REPLACE E5_MOTBX    WITH "NOR"
          REPLACE E5_SEQ      WITH "01"
          MsUnLock()

          If SE1->E1_JUROS > 0
             DbSelectArea("SE5")
             Reclock("SE5",.T.)
               REPLACE E5_FILIAL   WITH xFILIAL()
               REPLACE E5_DATA     WITH SE1->E1_BAIXA
               REPLACE E5_TIPO     WITH SE1->E1_TIPO
               REPLACE E5_VALOR    WITH SE1->E1_JUROS
               REPLACE E5_NATUREZ  WITH SE1->E1_NATUREZ
               REPLACE E5_BANCO    WITH "999"
               REPLACE E5_AGENCIA  WITH "999"
               REPLACE E5_CONTA    WITH "999"
               REPLACE E5_RECPAG   WITH "R"
               REPLACE E5_HISTOR   WITH "Juros s/ receb. Titulo"
               REPLACE E5_TIPODOC  WITH "JR"
               REPLACE E5_VLMOED2  WITH SE1->E1_JUROS
               REPLACE E5_LA       WITH "N"
               REPLACE E5_NUMERO   WITH SE1->E1_NUM
               REPLACE E5_CLIFOR   WITH SE1->E1_CLIENTE
               REPLACE E5_LOJA     WITH SE1->E1_LOJA
               REPLACE E5_DTDIGIT  WITH SE1->E1_BAIXA
               
               REPLACE E5_DTDISPO WITH SE1->E1_BAIXA
                    
               REPLACE E5_MOTBX    WITH "NOR"
               REPLACE E5_SEQ      WITH "01"
               MsUnLock()
          EndIf
          If SE1->E1_MULTA > 0
             DbSelectArea("SE5")
             Reclock("SE5",.T.)
               REPLACE E5_FILIAL   WITH xFILIAL()
               REPLACE E5_DATA     WITH SE1->E1_BAIXA
               REPLACE E5_TIPO     WITH SE1->E1_TIPO
               REPLACE E5_VALOR    WITH SE1->E1_MULTA
               REPLACE E5_NATUREZ  WITH SE1->E1_NATUREZ
               REPLACE E5_BANCO    WITH "999"
               REPLACE E5_AGENCIA  WITH "999"
               REPLACE E5_CONTA    WITH "999"
               REPLACE E5_RECPAG   WITH "R"
               REPLACE E5_HISTOR   WITH "Multa s/ receb. Titulo"
               REPLACE E5_TIPODOC  WITH "MT"
               REPLACE E5_VLMOED2  WITH SE1->E1_MULTA
               REPLACE E5_LA       WITH "N"
               REPLACE E5_NUMERO   WITH SE1->E1_NUM
               REPLACE E5_CLIFOR   WITH SE1->E1_CLIENTE
               REPLACE E5_LOJA     WITH SE1->E1_LOJA
               REPLACE E5_DTDIGIT  WITH SE1->E1_BAIXA     
               
               REPLACE E5_DTDISPO WITH SE1->E1_BAIXA
                    
               REPLACE E5_MOTBX    WITH "NOR"
               REPLACE E5_SEQ      WITH "01"
               MsUnLock()
          EndIf

   // Alimenta contador de Movimento Bancario
      _nCntMov := _nCntMov + 1

Return


// Substituido pelo assistente de conversao do AP5 IDE em 18/08/00 ==> Function fInconsist
Static Function fInconsist()
  //__Inicio dos testes de consistencia do titulo___________________________

      _lSemCLASS      := .T.
      _lSemMAT        := .T.
      _lSemVALOR      := .T.
      _lSemDTFAT      := .T.
      _lSemDTVEN      := .T.
      _lExistALU      := .T.
      _lExistCUR      := .T.
      _lExistTIT      := .T.
      _lTitOk         := .F.
      
      cNaturez        := Space(10)
      cCC             := Space(9)
      cCodCli         := Space(6)
      cLojCli         := Space(2)
      cNomCli         := Space(20)

  //__Consiste CLASSIFICACAO  nao informada_________________________________
    If Empty(AllTrim(TRB->CLAS)) 
      _cInconsist := "CLASSIFICACAO nao informada no arquivo." 
      _lSemCLASS  := .F.
      @ nLin,01 Psay _cInconsist
      @ nLin,43 Psay TRB->MAT
      @ nLin,60 Psay STRZERO(RECNO(),7)
      _cInconsist := ""
      fLinha()
    Endif

  //__Consiste MATRICULA nao informada_____________________________________
    If Empty(AllTrim(TRB->MAT))
      _cInconsist := "MATRICULA nao informada no arquivo." 
      _lSemMAT    := .F.
      @ nLin,01 Psay _cInconsist
      @ nLin,43 Psay TRB->MAT
      @ nLin,60 Psay STRZERO(RECNO(),7)
      _cInconsist := ""
      fLinha()
    Endif

  //__Consiste VALOR nao informado________________________________________
    If TRB->VALOR <= 0
      _cInconsist := "VALOR nao informado no arquivo." 
      _lSemVALOR  := .F.
      @ nLin,01 Psay _cInconsist
      @ nLin,43 Psay TRB->MAT
      @ nLin,60 Psay STRZERO(RECNO(),7)
      _cInconsist := ""
      fLinha()
    Endif

  //__Consiste DATA FATURAMENTO nao informada____________________________
    If Empty(TRB->EMISSAO) 
      _cInconsist := "DT FATURAMENTO nao informada no arquivo." 
      _lSemDTFAT  := .F.
      @ nLin,01 Psay _cInconsist
      @ nLin,43 Psay TRB->MAT
      @ nLin,60 Psay STRZERO(RECNO(),7)
      _cInconsist := ""
      fLinha()
    Endif

  //__Consiste DATA VENCTO nao informada_________________________________
    If Empty(TRB->EMISSAO) 
      _cInconsist := "DT VENCIMENTO nao informada no arquivo." 
      _lSemDTVEN  := .F.
      @ nLin,01 Psay _cInconsist
      @ nLin,43 Psay TRB->MAT
      @ nLin,60 Psay STRZERO(RECNO(),7)
      _cInconsist := ""
      fLinha()
    Endif


  //__Consiste ALUNO ____________________________________________________
    If !Empty(ALLTRIM(TRB->MAT))
       DbSelectArea("SA1")
       DbSetOrder(5)
       DbSeek(xFilial()+ TRB->MAT ,.t.)
       If !Found()
          _cInconsist := "ALUNO nao existe no cadastro."
          _lExistALU  := .F.
          @ nLin,01 Psay _cInconsist
          @ nLin,43 Psay TRB->MAT
          @ nLin,60 Psay STRZERO(RECNO(),7)
          _cInconsist := ""
          fLinha()
       Else
          cCodCli  := SA1->A1_COD
          cLojCli  := SA1->A1_LOJA
          cNomCli  := SA1->A1_NREDUZ
          If Empty(SA1->A1_CURSO)
             _cInconsist := "ALUNO sem informacao do curso no cadastro."
             _lExistALU  := .F.
             @ nLin,01 Psay _cInconsist
             @ nLin,43 Psay TRB->MAT
             @ nLin,60 Psay STRZERO(RECNO(),7)
             _cInconsist := ""
             fLinha()
          Else
             DbSelectArea("SZ3")
             DbSetOrder(1)
             DbSeek(xFilial()+SA1->A1_CURSO,.t.)
             If !Found()
                _cInconsist := "CURSO sem informacao no cadastro."
                _lExistCUR  := .F.
                @ nLin,01 Psay _cInconsist
                @ nLin,43 Psay TRB->MAT
                @ nLin,60 Psay STRZERO(RECNO(),7)
                _cInconsist := ""
                fLinha()
             Else
                cNaturez := SZ3->Z3_NATUREZ                
                cCC       := SZ3->Z3_CC
                RecLock("TRB",.F.)
                  TRB->CLIENTE  := cCodCli
                  TRB->LOJA       := cLojCli
                  TRB->NOMCLI   := cNomCli
                  TRB->NATUREZ := cNaturez
                  TRB->CCUSTO  := cCC
                MsUnlock()
             EndIf
          EndIf
       EndIf
    Endif

  //__Consiste TITULO  __________________________________________________
    DbSelectArea("SE1")
    DbSetOrder(1)
    DbSeek(xFilial()+Space(3)+TRB->NUM+Space(1)+TRB->TIPO,.T.)
    If Found()
       _cInconsist := "TITULO ja cadastro."
       _lExistTIT  := .F.
       @ nLin,01 Psay _cInconsist
       @ nLin,43 Psay TRB->MAT
       @ nLin,60 Psay STRZERO(RECNO(),7)
       _cInconsist := ""
       fLinha()
    Endif
   
    If _lSemCLASS .And. _lSemMAT .And. _lSemVALOR .And. _lSemDTFAT .And.;
       _lSemDTVEN .And. _lExistALU .And. _lExistCUR .And.  _lExistTIT

       //MSGBOX("TITULO OK","MENSAGEM DE CONSISTENCIA","INFO")                   
       _lTitOk         := .T.

    EndIf


Return


// Substituido pelo assistente de conversao do AP5 IDE em 18/08/00 ==> Function fImpTot
Static Function fImpTot()

  //__Impressao do Total dos cadastros importados__________________________

    fLinha()
    fLinha()
    fLinha()
    @ nLin+8, 00 Psay  Repli("-",220)
    fLinha()

    @ nLin+8, 00 Psay  " RESUMO DA INTEGRACAO "
    fLinha()

    @ nLin+8, 00 Psay  Repli("-",220)
    fLinha()

    @ nLin+8, 00 Psay  "Titulos  .....: "
    @ nlin+8, 20 Psay  _nCntTit Picture "9999"
    fLinha()

    @ nLin+8, 00 Psay  "Movimento Banc: "
    @ nlin+8, 20 Psay  _nCntMov Picture "9999"

    fLinha()

    @ nLin+8, 00 Psay  Repli("-",220)
    fLinha()
Return


// Substituido pelo assistente de conversao do AP5 IDE em 18/08/00 ==> Function fLinha
Static Function fLinha()
  //__Salta Linha___________________________________________________________
  If nLin >= 55
     nLin := 0
     nLin := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
     nLin := nLin + 1
  Else
     nLin := nLin + 1
  Endif
Return


// Substituido pelo assistente de conversao do AP5 IDE em 18/08/00 ==> Function AcerTRB
Static Function AcerTRB()

nReg   := 0
nAbati := 0
DbSelectArea("TRB")
DbSetOrder(1)
DbGoTop()
While !Eof()

   If TRB->CLAS == "BU" .Or. TRB->CLAS == "BA" .Or. TRB->CLAS == "CE";
      .Or. TRB->CLAS == "CA" .Or. TRB->CLAS == "CP" .Or. TRB->CLAS == "BP"
      
      If TRB->BAIXA <> CTOD("  /  /  ")
         nReg   := Recno()
      
         nAbati := TRB->VALOR
      
         //MSGBOX(TRB->MAT+DTOS(TRB->EMISSAO)+"MB ","STRING","INFO")
        //MSGBOX(STR(nAbati),"VALOR DO ABATIMENTO","INFO")       
      
         DbSeek(TRB->MAT+DTOS(TRB->EMISSAO)+"MN ",.T.)
      
         If Found()
      
            //MSGBOX("ACHOU O TITULO ORIGINAL","INFO","INFO")
         
            RecLock("TRB",.F.)   // Trava o registro
                TRB->VALLIQ  := TRB->VALLIQ - nAbati
            MsUnLock()           // Destrava o registro
         EndIf
      
         DbGoTo(nReg)
         
      EndIf
   EndIf

   DbSkip()

End
Return
