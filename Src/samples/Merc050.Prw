#include "rwmake.ch" 

User Function Merc050()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CSAVSCR1,CAREA,AAREA,CNUMORC,CRODATXT,NCNTIMPR")
SetPrvt("TAMANHO,TITULO,CDESC1,CDESC2,CDESC3,CSTRING")
SetPrvt("NTIPO,NOMEPROG,NTOTREGS,NMULT,NPOSANT,NPOSATU")
SetPrvt("NPOSCNT,LCONTINUA,ARETURN,NLASTKEY,LI,M_PAG")
SetPrvt("CNOMARQ,WNREL,NDESC,NTOTAL,LCABEC,ACONDICOES")
SetPrvt("AFORMAPGTO,CDESC01,CDESC02,PULA,CALIASTMP,NSE1ORD")
SetPrvt("NSE1REG,NMAIATR,NTITATR,NSA1ORD,NSA1REG,CENDCLI")
SetPrvt("CBAICLI,CCIDCLI,CESTCLI,NLIMITE,NSALDO,DULTCOM")
SetPrvt("NMATRA,CCGCCLI,CINSCLI,CCGC,CINSCR,NITVALID")
SetPrvt("NMEDDESC,NVALPAG,CLOCALIZ,")

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Rotina   ³ Merc050  ³ Autor ³ Ionai Morais do Carmo ³ Data ³ 24.03.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impressao do Orcamento                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Orcamento Balcao                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Alterado ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
cArea    := Alias()
aArea    := GetArea()
cNumOrc  := SL1->L1_NUM

IF UPPER(Subs(cUsuario , 7 , 2)) # "AT"

cRodaTxt := ""
nCntImpr := 0
cTam     := "P"
titulo   := "Emissao de Orcamentos"
cDesc1   := "O objetivo deste relatorio e' exibir detalhadamente os orcamentos"
cDesc2   := ""
cDesc3   := ""
cString  := "SL1"
nTipo    := 0
nomeprog := "ORCAM"

dbSelectArea("SL1")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis para controle do cursor de progressao do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTotRegs := 0 ;nMult := 1 ;nPosAnt := 4 ;nPosAtu := 4 ;nPosCnt := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lContinua := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis tipo Private padrao de todos os relatorios         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aReturn  := { "Zebrado", 1, "Vendas", 1, 1, 1,"",1 }
nLastKey := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li    := 80
m_pag := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cNomArq:=""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel:=SetPrint("SL1",NomeProg,,titulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,cTam,,,, "EPSON.DRV",.T.)

If LastKey() == 27 .or. nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If LastKey() == 27 .or. nLastKey == 27
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aArea      := GetArea()  // Grava a area atual
	li         := nDesc:=nTotal:=0
	lCabec     := .T.
	aCondicoes := {}
	aFormaPgto := {}


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona no arquivo cabe‡alho                                                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "SL1" )
	dbSeek( xFilial("SL1")+cNumOrc )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona no arquivo de Clientes                                                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "SA1" )
	dbSeek( xFilial("SA1")+SL1->L1_CLIENTE )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona no arquivo de Vendedores                                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "SA3" )
	dbSeek( xFilial("SA3")+SL1->L1_VEND )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Array da Condi‡„o de Pagamento                                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aCondicoes := lj010Cond( )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta Array com tipo de Forma de Pagamento                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "SX5" )
	dbSeek( xFilial("SX5")+"06" )

	While !Eof() .and. SX5->X5_FILIAL == xFilial("SX5") .and. SX5->X5_TABELA = "06"
 
		 If Trim(SX5->X5_CHAVE) == "CC"
		    SAE->(DbSeek(xFilial("SX5")+Chr(0),.T.))
		 EndIf
		 
		 If SX5->X5_CHAVE != "CC" .or. !SAE->(Eof())
		    Aadd( aFormaPgto, SubStr( SX5->X5_DESCRI, 1, 13 ) + SubStr(SX5->X5_CHAVE , 1, 3 ) )
		 EndIf
		 
		 dbSkip()
		 
	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona no arquivo de Itens                                                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "SL2" )
	dbSeek( xFilial("SL2")+cNumOrc+"01" )

	While !Eof() .and. SL2->L2_NUM == SL1->L1_NUM

//          If SL2->L2_VENDIDO == "S"
//             dbSkip()
//             Loop
//          EndIf

	  If li > 60
	     lCabec := .T.
	  EndIf

	  If lCabec
		  setprc(0,0)
		  @ 00,00 PSAY CHR(15)
//                  @ 00,00 PSAY PADC(ALLTRIM(SM0->M0_NOME),59)
		  @ 01,00 PSAY "+----------------------------------------------------------+"
		  @ 02,01 PSAY "Orcamento :"
		  @ 02,13 PSAY SL1->L1_NUM
		  @ 02,23 PSAY "Emissao  :"
		  @ 02,33 PSAY SL1->L1_EMISSAO
		  @ 03,01 PSAY "Cliente   :"
		  @ 03,13 PSAY SL1->L1_CLIENTE+"  "+Left(SA1->A1_NOME,37)
		  @ 04,01 PSAY "Vendedor  :"
		  @ 04,13 PSAY SL1->L1_VEND+"  "+Left(SA3->A3_NOME,37)
		  @ 05,00 PSAY "+----------------------------------------------------------+"
		  @ 06,01 PSAY "IT DESCRICAO                       QTD      UNIT     TOTAL"
		  Li := 07
		  lCabec := .F.
	  EndIf
	  SB1->(dbSeek(xFilial("SB1")+SL2->L2_PRODUTO+SL2->L2_LOCAL))
	  cDesc01:=SB1->B1_DESC
//   cDesc02:=If(!Empty(SB1->B1_REF),"Ref."+Rtrim(SB1->B1_REF),"")
     cDesc02 := ""
//   cDesc02:=cDesc02+If(!Empty(SB1->B1_DMARCA)," - Marca:" +Rtrim(SB1->B1_DMARCA),"")
//   cDesc02:=cDesc02+" - Cod."+Rtrim(SB1->B1_COD)

	  @ li,01 PSAY SL2->L2_ITEM
      @ li,04 PSAY Substr(cDesc01,1,26)
      @ li,31 PSAY SL2->L2_QUANT   Picture "@E 99999.99"
	  @ li,40 PSAY SL2->L2_VRUNIT  Picture "@E 99,999.99"
	  @ li,49 PSAY SL2->L2_VLRITEM Picture "@E 999,999.99"
      IF SL2->L2_TABELA == "2" .AND. SL2->L2_TABELA == "9"
         @ Li,61 PSAY "P"
      ENDIF
      If Len(Alltrim(cDesc02))>1
         li:=li+1
         @ li,01 PSAY Rtrim(cDesc02)
      Endif
	  nDesc :=nDesc+SL2->L2_VALDESC
      nTotal:=nTotal+SL2->L2_VLRITEM
	  li:=li+1
	  dbSelectArea("SL2")
	  dbSkip()
	EndDo

	If !lCabec
	  @ li,00 PSAY "+----------------------------------------------------------+"
	  li:=li+1
	  @ li,00 PSAY " T O T A L .................................."
	  @ li,45 PSAY nTotal picture "@E 999,999,999.99"
	  li:=li+1
/*
	  @ li,00 PSAY " D E S C O N T O ............................"
	  @ li,45 PSAY nDesc picture "@E 999,999,999.99"
	  li:=li+1
	  @ li,00 PSAY " L I Q U I D O .............................."
	  @ li,45 PSAY (nTotal-nDesc) picture "@E 999,999,999.99"
	  li:=li+1
*/
	  @ li,00 PSAY "+----------------------------------------------------------+"
	  li:=li+1
	  @ li,00 PSAY " Cond. Pgto :"
	  If !Empty( SL1->L1_CONDPG )
		  dbSelectArea( "SE4" )
		  dbSeek( xFilial("SE4")+SL1->L1_CONDPG)
                          @li, 14 PSAY SL1->L1_CONDPG + " " + Rtrim(SE4->E4_DESCRI)
		  dbSelectArea( "SL1" )
	  EndIf
	  li:=li+1
	  @ li,00 PSAY " Validade   :"
	  @ li,14 PSAY SL1->L1_DTLIM
	  li:=li+1
	  @ li,00 PSAY " Posicao    :"
	  @ li,14 PSAY If(!Empty(SL1->L1_DOC),"Ja atendido - NF."+Trim(SL1->L1_DOC)+" / "+SL1->L1_SERIE,"Nao atendido")
	  li:=li+1
	  @ li,00 PSAY "+----------------------------------------------------------+"
	  li:=li+1
          @ li,00 PSAY "CUPOM SEM VALOR FISCAL - EXIJA SUA NOTA FISCAL"
          Pula := 1
	  While Pula < 5
          li:=li+Pula
          @ li,00 PSAY ""
          Pula:=Pula+1
	  End
	EndIf
ELSE
   Li := 1
   lCabec     := .T.
   aCondicoes := {}
   aFormaPgto := {}
	
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Monta Array da Condi‡„o de Pagamento                                                                  ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   aCondicoes := lj010Cond( )
	
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³Monta Array com tipo de Forma de Pagamento                                             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   InitPrint()
   dbSelectArea( "SX5" )
   dbSeek( xFilial("SX5")+"06" )
	
   While !Eof() .and. SX5->X5_FILIAL == xFilial("SX5") .and. SX5->X5_TABELA = "06"
		 
         If Trim(SX5->X5_CHAVE) == "CC"
            SAE->(DbSeek(xFilial("SX5")+Chr(0),.T.))
         EndIf
         If SX5->X5_CHAVE != "CC" .or. !SAE->(Eof())
            Aadd( aFormaPgto, SubStr( SX5->X5_DESCRI, 1, 13 ) + SubStr(SX5->X5_CHAVE , 1, 3 ) )
         EndIf
         dbSkip()
   EndDo
   SetPrc(0,0)
   cAliasTmp := Alias()
   dbSelectArea("SE1")
   nSE1Ord := IndexOrd()
   nSE1Reg := RecNo()
   dbSetOrder(8)
   nMaiAtr := 0
   ntitAtr := 0
   dbSeek(xFilial("SE1")+cCliente)
   While !Eof() .And. E1_CLIENTE == cCliente .And. E1_STATUS #"B"
       IF dDatabase > E1_VENCTO
           nTitAtr := nTitAtr + 1
           IF nMaiAtr < (dDataBase - E1_VENCTO)
               nMaiAtr := (dDataBase - E1_VENCTO)
           ENDIF
       ENDIF
       dbSkip()
   End
   dbSetOrder(nSE1Ord)
   dbGoTo(nSE1Reg)
   dbSelectArea("SA1")
   nSA1Ord := IndexOrd()
   nSA1Reg := RecNo()
   dbSetOrder(1)
   dbSeek(xFilial("SA1") + cCliente)
   cEndCli := A1_END
   cBaiCli := A1_BAIRRO
   cCidCli := A1_MUN
   cEstCli := A1_EST
   nLimite := A1_LC
   nSaldo  := A1_SALDUP
   dUltCom := A1_ULTCOM
   nMAtra  := A1_MATR
   cCGCCli := TRANSFORM(A1_CGC,"@R 99.999.999/9999-99")
   cInsCli := IIf("."$A1_INSCR,A1_INSCR,TRANSFORM(A1_INSCR,"@R 999.999.999.999") )
   dbGoTo(nSA1Reg)
   dbSetOrder(nSA1Ord)
   dbSelectArea(cAliasTmp)
   @ 00,000 PSAY CHR(15)
   @ 00,000 PSAY REPLICATE("-",132)
   @ 01,000 PSAY (ALLTRIM(SM0->M0_NOMECOM) + " - " + ALLTRIM(SM0->M0_NOME))
   @ 01,115 PSAY "No. " + cNum
   cCGC :=TRANSFORM(SM0->M0_CGC,"@R 99.999.999/9999-99")
   cInscr  :=IIf("."$SM0->M0_INSC,SM0->M0_INSC,TRANSFORM(SM0->M0_INSC,"@R 999.999.999.999") )
   @ 02,000 PSAY "C.G.C.: " + cCGC + "    Insc: " + cInscr
   @ 02,115 PSAY "Hora: " + Time()
   @ 03,000 PSAY SUBS(SM0->M0_ENDCOB,1,30)
   @ 03,115 PSAY "Data: " + Dtoc(dDataBase)
   @ 04,000 PSAY REPLICATE("-",132)
   @ 05,060 PSAY "P E D I D O"
   @ 06,000 PSAY REPLICATE("-",132)
   @ 07,000 PSAY "Cliente : " + Subs(cNome,1,27) + " " + cCliente
   @ 08,000 PSAY "Endereco: " + cEndCli
   @ 08,045 PSAY "Bairro: " + cBaiCli
   @ 08,090 PSAY "Cidade: " + Alltrim(cCidCli) + " " + cEstCli
   @ 09,000 PSAY "C.G.C   : " + cCGCCli
   @ 09,039 PSAY "Ins. Estadual: " + cInsCli
   @ 10,000 PSAY REPLICATE("-",132)
   @ 11,000 PSAY "Dp Codigo Descricao                 Referencia                   Un  Quantidade Prc. Venda %Desc  Vlr.Desc   Vlr. Total   Localiz."
            //    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
            //              1         2         3         4         5         6         7         8         9         10        11        12        13                          
   @ 12,000 PSAY REPLICATE("-",132)
   Li := 13
   nItValid := 0
   nMedDesc := 0
   nValPag  := 0
   dbSelectArea( "SL2" )
   dbSetOrder(1)
   dbSeek( xFilial("SL2")+cNumOrc+"01" )

   While !Eof() .And. SL2->L2_NUM == SL1->L1_NUM
             nItValid := nItValid + 1
             SB1->(dbSeek(xFilial("SB1")+SL2->L2_PRODUTO))
             cLocaliz := SPACE(10)
             IF SB2->(dbSeek(xFilial("SB2")+SL2->L2_PRODUTO+"01"))
                 cLocaliz := SB2->B2_LOCALIZ
             ENDIF
             @ li,000 PSAY "01"
             @ LI,003 PSAY Subs(SB1->B1_COD,1,6)
             @ LI,010 PSAY Subs(SB1->B1_DESC,1,25)
//           @ Li,036 PSAY SB1->B1_REF
             @ Li,065 PSAY SB1->B1_UM
             @ Li,069 PSAY L2_QUANT    Picture "@E 999,999.99"
             @ Li,080 PSAY L2_PRCTAB   Picture "@E 999,999.99"
             @ li,091 PSAY L2_DESC     Picture "@E 99.99"
             @ Li,098 PSAY L2_VALDESC  Picture "@E 999999.99"
             @ Li,107 PSAY L2_VLRITEM Picture "@E 9999,999.99"
             IF SL2->L2_TABELA == "2" .AND. SL2->L2_TABELA == "9"
                 @ Li,120 PSAY "P"
             ENDIF
             @ Li,122 PSAY cLocaliz
             nMedDesc := nMedDesc + L2_DESC
             nValPag  := nValPag + L2_VLRITEM
             Li := Li + 1
             IF Li >= 53
                @ Li,005 PSAY "----------------------------------------------  // Continua // -----------------------------------------------------"
                Li := 1
             ENDIF
   eND
   Li := Li + 1
   @ Li,000 PSAY "Desconto Medio: "
   @ Li,016 PSAY (nMedDesc / nItValid) Picture "@E 99.99"
   @ Li,080 PSAY "Total do Pedido --> "
   @ Li,107 PSAY nValPag Picture "@E 99999,999.99"
   Li := Li + 1
   @ Li,000 PSAY REPLICATE("-",132)
   Li := Li + 1
   @ Li,000 PSAY "+"
   @ Li,002 PSAY REPLICATE("-",86)
   @ Li,088 PSAY "+"
   Li := Li + 1
   @ Li,000 PSAY "|"
   @ Li,015 PSAY "Analise do Cliente"
   @ lI,038 PSAY "|"
   @ Li,052 PSAY "Informacoes do Pedido"
   @ Li,088 PSAY "|"
   Li := Li + 1
   @ Li,000 PSAY "|"
   @ Li,001 PSAY "Limite de Credito: "
   @ Li,020 PSAY nLimite Picture "@E 99,999,999.99"
   @ lI,038 PSAY "|"
   @ Li,040 PSAY "Centro de Custo: 001 Atacado"
   @ Li,088 PSAY "|"
   Li := Li + 1
   @ Li,000 PSAY "|"
   @ Li,001 PSAY "Saldo Devedor    : "
   @ Li,020 PSAY nSaldo Picture "@E 99,999,999.99"
   @ lI,038 PSAY "|"
   @ Li,040 PSAY "Nat. Operacao  : "
   @ Li,088 PSAY "|"
   Li := Li + 1
   @ Li,000 PSAY "|"
   @ Li,001 PSAY "Data Ult Compra  : "
   @ Li,020 PSAY dUltCom
   @ lI,038 PSAY "|"
   @ Li,040 PSAY "Responsavel    : "
   @ Li,088 PSAY "|"
   Li := Li + 1
   @ Li,000 PSAY "|"
   @ Li,001 PSAY "Data Cadastro    : "
   @ lI,038 PSAY "|"
   @ Li,040 PSAY "Prazos         : "
   @ Li,088 PSAY "|"
   Li := Li + 1
   @ Li,000 PSAY "|"
   @ Li,001 PSAY "No.Titulos Atraso: "
   @ Li,020 PSAY nTitAtr Picture "@E 99,999"
   @ lI,038 PSAY "|"
   @ Li,040 PSAY "Qtd de Itens   : "
   @ Li,057 PSAY nItValid Picture "@E 99,999"
   @ Li,088 PSAY "|"
   Li := Li + 1
   @ Li,000 PSAY "|"
   @ Li,001 PSAY "Dias em Atraso   : "
   @ Li,020 PSAY nMaiAtr Picture "@E 99,999"
   @ Li,027 PSAY "Dias"
   @ lI,038 PSAY "|"
   @ Li,095 PSAY "__________________________________"
   @ Li,088 PSAY "|"
   Li := Li + 1
   @ Li,001 PSAY "+"
   @ Li,002 PSAY REPLICATE("-",86)
   @ Li,088 PSAY "+"
   @ Li,105 PSAY "ASSINATURA"

   lCabec := .F.

ENDIF
RestArea( aArea ) // Restaura a area atual

If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
EndIf

DbCommitAll()

Ms_FLush()

Return
