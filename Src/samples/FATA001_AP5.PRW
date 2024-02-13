#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 18/10/00

User Function FATA001()        // incluido pelo assistente de conversao do AP5 IDE em 18/10/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CCAMINHO,CARQ,CBUSCA,")

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ FATA001  ³ Autor ³Claudia Mecenero       ³ Data ³ 12/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SigaFAT                                                    ³±±
±±³Empresa   ³ Siga Campinas                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

@ 96,42 TO 323,505 DIALOG oDlg5 TITLE "Atualizacao do Cadastro de Clientes e Tecnicos PCI"
@ 08,10 TO 84,222
@ 91,168 BMPBUTTON TYPE 1 ACTION BasePCI()// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==> @ 91,168 BMPBUTTON TYPE 1 ACTION Execute(BasePCI)
@ 91,196 BMPBUTTON TYPE 2 ACTION Close(oDlg5)
@ 23,14 SAY "Este programa vai atualizar a base de Clientes e Tecnicos do"
@ 33,14 SAY "SigaPCI."
@ 43,14 SAY ""
ACTIVATE DIALOG oDlg5
Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³          ³ Autor ³Claudia Mecenero       ³ Data ³ 12/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  

// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==> Function BasePCI
Static Function BasePCI()
Close(oDlg5)
Processa( {|| AltBase() } )// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==> Processa( {|| Execute(AltBase) } )
dbSelectArea("SA1")
dbSetOrder(1)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³AltBase   ³ Autor ³Claudia Mecenero       ³ Data ³ 12/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  

// Substituido pelo assistente de conversao do AP5 IDE em 18/10/00 ==> Function AltBase
Static Function AltBase()

  cArq := "\507\DADOSADV\SA11209"   //Alltrim(cCaminho)+"SA1ZZ0"

  dbUseArea(.T.,"DBFCDX",cArq,"SA1PCI",.T.)
  dbSetIndex(cArq)                                                            
  dbSetOrder(1)

  dbSelectArea("SA1")
  dbSetOrder(1)
  dbGoTop()

//  SetRegua(100000)

  While !EOF()

     IncProc()

     cBusca := "  "+SA1->A1_COD+SA1->A1_LOJA

     dbSelectArea("SA1PCI")
     dbSetOrder(1)
     If ! dbSeek(cBusca)
        RecLock("SA1PCI",.T.)
     Else
        RecLock("SA1PCI",.F.)
     Endif

     SA1PCI->A1_COD             := SA1->A1_COD
     SA1PCI->A1_LOJA            := SA1->A1_LOJA
     
/* 
    
     SA1PCI->A1_CODSP           := SA1->A1_CODSP
     SA1PCI->A1_CODCP           := SA1->A1_CODCP
     SA1PCI->A1_NOME            := SA1->A1_NOME
     SA1PCI->A1_NREDUZ          := SA1->A1_NREDUZ
     SA1PCI->A1_TIPOPED         := SA1->A1_TIPOPED
     SA1PCI->A1_HRTRANS         := SA1->A1_HRTRANS
     SA1PCI->A1_KMPAD           := SA1->A1_KMPAD
     SA1PCI->A1_PEDAG1          := SA1->A1_PEDAG1
     SA1PCI->A1_QTDPED1         := SA1->A1_QTDPED1
     SA1PCI->A1_PEDAG2          := SA1->A1_PEDAG2
     SA1PCI->A1_QTDPED2         := SA1->A1_QTDPED2
     SA1PCI->A1_PEDAG3          := SA1->A1_PEDAG3
     SA1PCI->A1_QTDPED3         := SA1->A1_QTDPED3
     SA1PCI->A1_TIPO            := SA1->A1_TIPO
     SA1PCI->A1_SITUAC          := SA1->A1_SITUAC
     SA1PCI->A1_TPFRET          := SA1->A1_TPFRET
     SA1PCI->A1_AGREG           := SA1->A1_AGREG
     SA1PCI->A1_FRCAMP          := SA1->A1_FRCAMP
     SA1PCI->A1_END             := SA1->A1_END
     SA1PCI->A1_BAIRRO          := SA1->A1_BAIRRO
     SA1PCI->A1_CEP             := SA1->A1_CEP
     SA1PCI->A1_PAIS            := SA1->A1_PAIS
     SA1PCI->A1_EMAIL           := SA1->A1_EMAIL
     SA1PCI->A1_MUN             := SA1->A1_MUN
     SA1PCI->A1_EST             := SA1->A1_EST
     SA1PCI->A1_TEL             := SA1->A1_TEL
     SA1PCI->A1_TELEX           := SA1->A1_TELEX
     SA1PCI->A1_FAX             := SA1->A1_FAX
     SA1PCI->A1_CONTATO         := SA1->A1_CONTATO
     SA1PCI->A1_CARGO1          := SA1->A1_CARGO1
     SA1PCI->A1_ATIVIDA         := SA1->A1_ATIVIDA
     SA1PCI->A1_CONTAT2         := SA1->A1_CONTAT2
     SA1PCI->A1_CARGO2          := SA1->A1_CARGO2
     SA1PCI->A1_CONTAT3         := SA1->A1_CONTAT3
     SA1PCI->A1_CARGO3          := SA1->A1_CARGO3
     SA1PCI->A1_CGC             := SA1->A1_CGC
     SA1PCI->A1_INSCR           := SA1->A1_INSCR
     SA1PCI->A1_INSCRM          := SA1->A1_INSCRM
     SA1PCI->A1_TEMCONT         := SA1->A1_TEMCONT
     SA1PCI->A1_REGIAO          := SA1->A1_REGIAO
     SA1PCI->A1_NATUREZ         := SA1->A1_NATUREZ
     SA1PCI->A1_CONTA           := SA1->A1_CONTA
     SA1PCI->A1_TABELA          := SA1->A1_TABELA
     SA1PCI->A1_BCO1            := SA1->A1_BCO1
     SA1PCI->A1_BCO2            := SA1->A1_BCO2
     SA1PCI->A1_BCO3            := SA1->A1_BCO3
     SA1PCI->A1_BCO4            := SA1->A1_BCO4
     SA1PCI->A1_BCO5            := SA1->A1_BCO5
     SA1PCI->A1_TRANSP          := SA1->A1_TRANSP
     SA1PCI->A1_COND            := SA1->A1_COND
     SA1PCI->A1_ALIQIR          := SA1->A1_ALIQIR
     SA1PCI->A1_SUPER           := SA1->A1_SUPER
     SA1PCI->A1_RTEC            := SA1->A1_RTEC
     SA1PCI->A1_DESC            := SA1->A1_DESC
     SA1PCI->A1_VEND            := SA1->A1_VEND
     SA1PCI->A1_PRIOR           := SA1->A1_PRIOR
     SA1PCI->A1_COMIS           := SA1->A1_COMIS
     SA1PCI->A1_PRICOM          := SA1->A1_PRICOM
     SA1PCI->A1_MCOMPRA         := SA1->A1_MCOMPRA
     SA1PCI->A1_ULTCOM          := SA1->A1_ULTCOM
     SA1PCI->A1_NROCOM          := SA1->A1_NROCOM
     SA1PCI->A1_VACUM           := SA1->A1_VACUM
     SA1PCI->A1_SALPED          := SA1->A1_SALPED
     SA1PCI->A1_SALPEDL         := SA1->A1_SALPEDL
     SA1PCI->A1_RISCO           := SA1->A1_RISCO
     SA1PCI->A1_LC              := SA1->A1_LC
     SA1PCI->A1_VENCLC          := SA1->A1_VENCLC
     SA1PCI->A1_NROPAG          := SA1->A1_NROPAG
     SA1PCI->A1_MSALDO          := SA1->A1_MSALDO
     SA1PCI->A1_SALDUP          := SA1->A1_SALDUP
     SA1PCI->A1_MAIDUPL         := SA1->A1_MAIDUPL
     SA1PCI->A1_SALDUPM         := SA1->A1_SALDUPM
     SA1PCI->A1_MENSAGE         := SA1->A1_MENSAGE
     SA1PCI->A1_PAGATR          := SA1->A1_PAGATR
     SA1PCI->A1_METR            := SA1->A1_METR
     SA1PCI->A1_MATR            := SA1->A1_MATR
     SA1PCI->A1_ATR             := SA1->A1_ATR
     SA1PCI->A1_TITPROT         := SA1->A1_TITPROT
     SA1PCI->A1_DTULTIT         := SA1->A1_DTULTIT
     SA1PCI->A1_CHQDEVO         := SA1->A1_CHQDEVO
     SA1PCI->A1_DTULCHQ         := SA1->A1_DTULCHQ
     SA1PCI->A1_TEMVIS          := SA1->A1_TEMVIS
     SA1PCI->A1_ULTVIS          := SA1->A1_ULTVIS
     SA1PCI->A1_SUFRAMA         := SA1->A1_SUFRAMA
     SA1PCI->A1_SALTEMP         := SA1->A1_SALTEMP
     SA1PCI->A1_OBSERV          := SA1->A1_OBSERV
     SA1PCI->A1_CALCSUF         := SA1->A1_CALCSUF
     SA1PCI->A1_RG              := SA1->A1_RG
     SA1PCI->A1_DTNASC          := SA1->A1_DTNASC
     SA1PCI->A1_SALPEDB         := SA1->A1_SALPEDB
     SA1PCI->A1_ENDREC          := SA1->A1_ENDREC
     SA1PCI->A1_CLIFAT          := SA1->A1_CLIFAT
     SA1PCI->A1_ENDENT          := SA1->A1_ENDENT
     SA1PCI->A1_BAIRENT         := SA1->A1_BAIRENT
     SA1PCI->A1_CEPENT          := SA1->A1_CEPENT
     SA1PCI->A1_GRPTRIB         := SA1->A1_GRPTRIB
     SA1PCI->A1_MUNENT          := SA1->A1_MUNENT
     SA1PCI->A1_ENDCOB          := SA1->A1_ENDCOB
     SA1PCI->A1_BAIRCOB         := SA1->A1_BAIRCOB
     SA1PCI->A1_CEPCOB          := SA1->A1_CEPCOB
     SA1PCI->A1_MUNCOB          := SA1->A1_MUNCOB
     SA1PCI->A1_INCISS          := SA1->A1_INCISS
     SA1PCI->A1_TRANSF          := SA1->A1_TRANSF
     SA1PCI->A1_BASE            := SA1->A1_BASE
     SA1PCI->A1_HPAGE           := SA1->A1_HPAGE
     SA1PCI->A1_DPMATV          := SA1->A1_DPMATV
     SA1PCI->A1_BAIRROC         := SA1->A1_BAIRROC
     SA1PCI->A1_CODMUN          := SA1->A1_CODMUN
     SA1PCI->A1_CEPC            := SA1->A1_CEPC
     SA1PCI->A1_MUNC            := SA1->A1_MUNC
     SA1PCI->A1_ESTC            := SA1->A1_ESTC
     SA1PCI->A1_BAIRROE         := SA1->A1_BAIRROE
     SA1PCI->A1_CEPE            := SA1->A1_CEPE
     SA1PCI->A1_MUNE            := SA1->A1_MUNE
     SA1PCI->A1_ESTE            := SA1->A1_ESTE
     SA1PCI->A1_SATIV1          := SA1->A1_SATIV1
     SA1PCI->A1_SATIV2          := SA1->A1_SATIV2
     SA1PCI->A1_SATIV3          := SA1->A1_SATIV3
     SA1PCI->A1_SATIV4          := SA1->A1_SATIV4
     SA1PCI->A1_SATIV5          := SA1->A1_SATIV5
     SA1PCI->A1_SATIV6          := SA1->A1_SATIV6
     SA1PCI->A1_SATIV7          := SA1->A1_SATIV7
     SA1PCI->A1_SATIV8          := SA1->A1_SATIV8
     SA1PCI->A1_ENTRPAR         := SA1->A1_ENTRPAR
     SA1PCI->A1_USERLGI         := SA1->A1_USERLGI
     SA1PCI->A1_USERLGA         := SA1->A1_USERLGA
     SA1PCI->A1_PACK            := SA1->A1_PACK

*/ 

     msUnlock()

     dbSelectArea("SA1")
     dbSkip()

  Enddo

  dbSelectArea("SA1PCI")
  dbCloseArea()

/* 

  cArq := "\DADOSPCI\SA9ZZ0"   

  dbUseArea(.T.,"DBFCDX",cArq,"SA9PCI",.T.)
  dbSetIndex(cArq)
  dbSetOrder(1)

  dbSelectArea("SA9")
  dbSetOrder(1)
  dbGoTop()

  While !EOF()

     IncProc()

     cBusca := "  "+SA9->A9_TECNICO

     dbSelectArea("SA9PCI")
     dbSetOrder(1)
     If ! dbSeek(cBusca)
        RecLock("SA9PCI",.T.)
     Else
        RecLock("SA9PCI",.F.)
     Endif

     SA9PCI->A9_TECNICO := SA9->A9_TECNICO
     SA9PCI->A9_NOME    := SA9->A9_NOME
     SA9PCI->A9_NOMETEC := SA9->A9_NOMETEC
     SA9PCI->A9_TIPO    := SA9->A9_TIPO
     SA9PCI->A9_COORD   := SA9->A9_COORD
     SA9PCI->A9_LOCAL   := SA9->A9_LOCAL
     SA9PCI->A9_EMAIL   := SA9->A9_EMAIL
     SA9PCI->A9_CODANT  := SA9->A9_CODANT
     SA9PCI->A9_END     := SA9->A9_END
     SA9PCI->A9_TELBIP  := SA9->A9_TELBIP
     SA9PCI->A9_NUMBIP  := SA9->A9_NUMBIP
     SA9PCI->A9_MUN     := SA9->A9_MUN
     SA9PCI->A9_FONE    := SA9->A9_FONE
     SA9PCI->A9_TELCONT := SA9->A9_TELCONT
     SA9PCI->A9_ATIVO   := SA9->A9_ATIVO

     msUnlock()

     dbSelectArea("SA9")
     dbSkip()
  Enddo

  dbSelectArea("SA9PCI")
  dbCloseArea()
  
*/  

Return