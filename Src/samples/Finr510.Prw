/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ DATA   ³ BOPS ³Prograd.³ALTERACAO                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³24.12.97³xxxxxx³Eduardo ³Adicionada pergunta Natureza de/ate.           ³±±
±±³17.02.98³xxxxxx³Adriano ³Inclusao do Tipodoc LJ                         ³±±
±±³21.05.98³xxxxxx³Mauricio³Inclusao do Tipodoc M2                         ³±±
±±³29.06.98³xxxxxx³Mauricio³Nro titulo com 12 posicoes                     ³±±
±±³02.07.98³xxxxxx³Mauricio³Alinhar relatorio                              ³±±
±±³14.10.98³xxxxxx³Andreia ³Alteracao no lay-out para ativar set century   ³±±
±±³18.12.98³xxxxxx³Andreia ³Tratamento de baixas estornadas                ³±±
±±³12.01.99³xxxxxx³Wagner  ³Tratamento para faturas                        ³±±
±±³10.03.99³20001A³Julio   ³Desconsiderar registro gerado pela juncao de   ³±±
±±³        ³      ³        ³cheques para PA.        								³±±
±±³30.03.99³META  ³Julio   ³Verificacao de Parametros de Tamanho  do Rel.  ³±±
±±³07.04.99³20987A³Mauricio³Tratar NCC como adiantamento.                  ³±±
±±³27.04.99³21224A³Julio   ³Correcao na interpreta‡„o do PA                ³±±
±±³29.07.99³META  ³Julio   ³Interpretar MV_CRNEG e MV_CPNEG                ³±±
±±³03.12.99³xxxxxx³Mauricio³Otimizacao utilizando TCQuery                  ³±±
±±³06.12.99³25471A³Mauricio³Correcao da impressao do Rodape do relatorio   ³±±
±±³21.12.99³MELHOR³Julio W.³Impress„o do Termo de Abert/Encerr p/ Windows  ³±±
±±³22.12.99³xxxxxx³Pilar   ³Variable does not Exist - CCOND                ³±±
±±³13.01.00³002018³Mauricio³Corrigir relatorio no SQL                      ³±±
±±³19.01.00³XXXXXX³Julio W.³Carregar vari veis do SX1 para Impressao       ³±±
±±³20.01.00³Melhor³Jeremias³Correcao da utilizacao das datas para a filtra-³±±
±±³        ³      ³        ³gem dos dados, utilizando o E1_EMISSAO ou      ³±±
±±³        ³      ³        ³E2_EMIS1.                                      ³±±
±±³22.02.00³xxxxxx³Leonardo³Desconsiderar E5_TIPO="EF" quando E5_ORDREC es-³±±
±±³        ³      ³        ³tiver preenchido. Localizacoes.                ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

#INCLUDE "FINR510.CH"
#IFDEF WINDOWS
	#Include "Fw192.Ch"
	#Include "Std.Ch"
#ELSE
	#Include "InKey.Ch"
	#Include "SetCurs.Ch"
	#Include "Siga.Ch"
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ FINR510	³ Autor ³ Wagner Xavier 		  ³ Data ³ 25.11.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Diario Auxiliar Clientes / Fornecedores						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FINR510(void)															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FinR510()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis 														  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cDesc1 := OemToAnsi(STR0001)  //"Este programa ir  emitir o Diario Auxiliar de Clientes ou Fornecedores."
LOCAL cDesc2 := OemToAnsi(STR0002)  //"Poder  imprimir os valores financeiros, ou demonstrar somente os valo-"
LOCAL cDesc3 := OemToAnsi(STR0003)  //"res originais."
LOCAL wnrel
LOCAL limite := 132
LOCAL cString:="SE1"
LOCAL Tamanho:="M"

PRIVATE titulo := OemToAnsi(STR0004)  //"Diario Auxiliar de Clientes/Fornecedores"
PRIVATE cabec1
PRIVATE cabec2
PRIVATE aReturn := { OemToAnsi(STR0005), 1,OemToAnsi(STR0006), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE nomeprog:= "FINR510"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg	 := "FIN510"
PRIVATE cTipos  := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas 								  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("FIN510",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros								 ³
//³ mv_par01			// A partir de 									 ³
//³ mv_par02			// Ate a data										 ³
//³ mv_par03			// Cliente / Fornecedor 						 ³
//³ mv_par04			// Do Codigo										 ³
//³ mv_par05			// Ate o Codigo									 ³
//³ mv_par06			// Pagina Inicial 								 ³
//³ mv_par07			// Pagina Final									 ³
//³ mv_par08			// Abertura/Encerramento/Nenhum				 ³
//³ mv_par09			// So o termo										 ³
//³ mv_par10			// Imprime valores financeiros?				 ³
//³ mv_par11			// Imprime (Todos / Normais / Adiant.) 	 ³
//³ mv_par12			// Prefixo de										 ³
//³ mv_par13			// Prefixo ate 									 ³
//³ mv_par14			// Lista Por 1 - Filial 		 2 -Empresa  ³
//³ mv_par15			// Seleciona Tipos?								 ³
//³ mv_par16			// Natureza de  ?                          ³
//³ mv_par17			// Natureza ate ?                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT 							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "FINR510"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,Tamanho,"",.F.)
If nLastKey == 27
	Return
Endif
SetDefault(aReturn,cString)
If nLastKey == 27
	Return
Endif

#IFDEF WINDOWS
	RptStatus({|lEnd| Fa510Imp(@lEnd,wnRel,cString)},Titulo)
#ELSE
	fa510Imp(.f.,Wnrel,cString)
#ENDIF
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ FA510Imp ³ Autor ³ Wagner Xavier 		  ³ Data ³ 25.11.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Diario Auxiliar Clientes / Fornecedores						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA510Imp(lEnd,wnRel,cString)										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FA510Imp(lEnd,wnRel,cString)

LOCAL CbCont,CbTxt
LOCAL tamanho:="M"
LOCAL cCodigo,lTermo:=.T.
LOCAL cNome,cIdent,aCampos:={},aTam:={},cNomeArq,nCompress,nC,nQuebra:=0
LOCAL nTotTit:=0,nTotDeb:=0,nTotCrd:=0
LOCAL nGerTit:=0,nGerDeb:=0,nGerCrd:=0
LOCAL dEmissao,dVencto,dDtDigit
LOCAL nRec,nPrim,cPrefixo,cNumero,cParcela,cTipo,cNaturez,nValliq
LOCAL nAnterior:=0,cRecPag,cFornece,nRec1, nIndex,cLoja
LOCAL aInd:={}
LOCAL cCondE1:=cCondE2:=cCondE5:=""
LOCAL cIndE1 :=cIndE2 :=cIndE5 :=""
LOCAL nTamNro
LOCAL	nRegSe1Atu := SE1->(RecNo())
LOCAL	nOrdSe1Atu := SE1->(IndexOrd())
LOCAL lBaixa     := .F.
LOCAL	nRegSe2Atu := SE2->(RecNo())
LOCAL	nOrdSe2Atu := SE2->(IndexOrd())
LOCAL cChaveSe1
LOCAL cChaveSe2
LOCAL aStru := SE1->(dbStruct()), ni
LOCAL cAlias510 := Alias()
LOCAL aVariaveis := {}, aSavSet := {}, Limite := 132
Private nDecs	:=	GetMv("MV_CENT")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt 	:= SPACE(10)
cbcont	:= 0
li 		:= 80

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impress„o dos Termos (Abertura / Encerramento)               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par08 != 3
	lImprimiu := .F.
	cArqAbert:=SubStr(cArqRel,1,7)+"A.TRM"
	cArqEncer:=SubStr(cArqRel,1,7)+"E.TRM"
	aVariaveis := {}
	dbSelectArea("SM0")
	For i:=1 to FCount()	
		If FieldName(i)=="M0_CGC"
			AADD(aVariaveis,{FieldName(i),Transform(FieldGet(i),"@R 99.999.999/9999-99")})
		Else
			If FieldName(i)=="M0_NOME"
				Loop
			Endif
			AADD(aVariaveis,{FieldName(i),FieldGet(i)})
		Endif
	Next
	SX1->(dbSeek("FIN51001"))
	While SX1->X1_GRUPO=="FIN510"
		If !empty(SX1->X1_VAR01)
			AADD(aVariaveis,{Rtrim(Upper(SX1->X1_VAR01)),&("MV_PAR"+SX1->X1_ORDEM)})
		Endif
		SX1->(dbSkip())
	EndDo
	If mv_par08 == 1	// Termo de Abertura
		aSavSet:=__SetSets()
		cArqAbert:=CFGX024(cArqAbert,STR0004) //"Diario Auxiliar de Clientes/Fornecedores"
		__SetSets(aSavSet)
		Set(24,Set(24),.t.)
		lImprimiu := ImpTerm(cArqAbert,aVariaveis,AvalImp(Limite))
	ElseIf mv_par08 == 2	// Termo de Encerramento
		aSavSet:=__SetSets()
		cArqEncer:=CFGX024(cArqEncer,STR0004)  //"Diario Auxiliar de Clientes/Fornecedores"
		__SetSets(aSavSet)
		Set(24,Set(24),.t.)
		lImprimiu := ImpTerm(cArqEncer,aVariaveis,AvalImp(Limite))
	Endif
	If lImprimiu
		Eject
	Endif
	If mv_par09 == 1	// Impress„o apenas dos termos
		Set Device To Screen
		If lImprimiu
			If aReturn[5] = 1
				Set Printer To
				Commit
				ourspool(wnrel)
				MS_FLUSH()
			Endif
		Endif
		Return
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se seleciona tipos											³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par15 == 1
	finRTipos()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ For‡a ser por filial quando exista somente 1 filial,indepen- ³
//³ dente da resposta                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
mv_par14 := Iif(SM0->(Reccount())==1,1,mv_par14)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos												  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo:= OemToAnsi(STR0007)   +IIF(mv_par03==1,OemToAnsi(STR0008),OemToAnsi(STR0009))  //"DIARIO AUXILIAR DE C/C "###"CLIENTES"###"FORNECEDORES"

m_pag := mv_par06

IF mv_par03==1
	cNome :=OemToAnsi(STR0010)  //"NOME DO CLIENTE              "
	cIdent:=OemToAnsi(STR0011)  //"CLIENTE"
Else
	cNome :=OemToAnsi(STR0012)  //"NOME DO FORNECEDOR            "
	cIdent:=OemToAnsi(STR0013)  //"FORNEC "
Endif

nCompress:=aReturn[4]
cabec1 := OemToAnsi(STR0014)+cNome+ OemToAnsi(STR0015)   //"  DATA   PREF  NUM  PC CODIGO "###" DT EMIS  VENCTO   HISTORICO                DEBITO         CREDITO"
cabec2 := "                              "+cIdent+"                                  REAL"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera arquivo de Trabalho												  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:=TamSX3("E1_CLIENTE")
AADD(aCampos,{"CODIGO"  ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("E1_LOJA")
AADD(aCampos,{"LOJA"    ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("E1_EMISSAO")
AADD(aCampos,{"DATAX"   ,"D",aTam[1],aTam[2]})
AADD(aCampos,{"NUMERO"  ,"C",16,0})
aTam:=TamSX3("E1_EMISSAO")
AADD(aCampos,{"EMISSAO" ,"D",aTam[1],aTam[2]})
aTam:=TamSX3("E1_VENCREA")
AADD(aCampos,{"VENCREA","D",aTam[1],aTam[2]})
aTam:=TamSX3("E1_VLCRUZ")
AADD(aCampos,{"VALOR"   ,"N",aTam[1],aTam[2]})
AADD(aCampos,{"HISTOR"  ,"C",40,0})
AADD(aCampos,{"DC"      ,"C",1,0})
cNomeArq:=CriaTrab(aCampos)
dbUseArea( .T.,, cNomeArq, "cNomeArq", if(.F. .OR. .F., !.F., NIL), .F. )
IndRegua("cNomeArq",cNomeArq,"Dtos(DataX)+Numero+Codigo+DC",,,OemToAnsi(STR0016))  //"Selecionando Registros..."

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza e grava titulos a receber dentro dos parametros	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par03 == 1
	dbSelectArea("SE1")
	dbSetOrder(6)
	#IFDEF TOP
		If TcSrvType() != "AS/400"
			cCondE1:=".T."
			cQuery := "SELECT * FROM " + RetSqlName("SE1") + " WHERE"
			cIndE1	:=IndexKey()

			If mv_par14 = 1
				cQuery += " E1_FILIAL = '" + xFilial("SE1") + "' AND "
			else
				cIndE1 :=Right(cIndE1,Len(cIndE1)-10)
			Endif
			cIndE1 := SqlOrder(cIndE1)

			dbSelectArea("SE1")
			dbCloseArea()
			dbSelectArea("SA1")

			cQuery += " E1_CLIENTE BETWEEN '" + mv_par04 + "' AND '" + mv_par05 + "'"
			cQuery += " AND E1_EMISSAO <= '" + DTOS(mv_par02)  + "'"
			cQuery += " AND E1_EMISSAO <= '" + DTOS(dDataBase) + "'"
			cQuery += " AND E1_TIPO NOT LIKE 'PR%'"
			cQuery += " AND E1_PREFIXO BETWEEN '" + mv_par12 + "' AND '" + mv_par13 + "'"
			cQuery += " AND E1_NATUREZ BETWEEN '" + mv_par16 + "' AND '" + mv_par17 + "'"
			cQuery += " AND D_E_L_E_T_ <> '*'"
			cQuery += " ORDER BY " + cIndE1

			cQuery := ChangeQuery(cQuery)
			dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SE1', .F., .T.)

			For ni := 1 to Len(aStru)
				If aStru[ni,2] != 'C'
					TCSetField('SE1', aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
				Endif
			Next
		else
	#ENDIF
		If mv_par14 = 1
			dbSeek(xFilial(),.t.)
			cCondE1:="xFilial()==E1_FILIAL .and. E1_EMISSAO<=mv_par02"
		Else
			cArqTrab :=CriaTrab(NIL,.F.)
			AADD(aInd,cArqTrab)
			cIndE1	:=IndexKey()
			cIndE1	:=Right(cIndE1,Len(cIndE1)-10)
			IndRegua("SE1",cArqTrab,cIndE1,,cCondE1,OemToAnsi(STR0016))  //"Selecionando Registros..."
			cCondE1:="E1_EMISSAO<=mv_par02"
			dbCommit()
			nIndex:=RetIndex("SE1")
			dbSelectArea("SE1")
			#IFNDEF TOP
				dbSetIndex(cArqTrab+OrdBagExt())
			#ENDIF

			dbSetOrder(nIndex+1)
			dbGotop()
		Endif

		#IFDEF TOP
		Endif
		#ENDIF

	dbSelectArea("SE1")

	While !Eof() .and. &(cCondE1)

		IF SE1->E1_CLIENTE < mv_par04 .or. SE1->E1_CLIENTE > mv_par05
			dbskip()
			Loop
		Endif
		IF SE1->E1_TIPO=="PR "
			dbskip()
			Loop
		Endif
		If mv_par11 == 2 .and. E1_TIPO $ "RA /"+MV_CRNEG
			dbskip()
			Loop
		Endif

		If mv_par11 == 3 .and. !(E1_TIPO $ "RA /"+MV_CRNEG)
			dbskip()
			Loop
		Endif
		If !Empty( mv_par12 )
			If SE1->E1_PREFIXO < mv_par12
				dbskip()
				Loop
			Endif
		Endif

		If !Empty( mv_par13 )
			If SE1->E1_PREFIXO > mv_par13
				dbskip()
				Loop
			Endif
		Endif
		If ! Inside(SE1->E1_TIPO)
			dbskip()
			Loop
		Endif

		If SE1->E1_EMISSAO >= mv_par01
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava debito no arquivo de trabalho - Emiss„o					  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Reclock("cNomeArq",.T.)
			Replace CODIGO 	With SE1->E1_CLIENTE
			Replace LOJA		With SE1->E1_LOJA
			Replace DATAX		With SE1->E1_EMISSAO
			Replace NUMERO 	With SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA
			Replace EMISSAO	With SE1->E1_EMISSAO
			Replace VALOR		With SE1->E1_VLCRUZ
			Replace HISTOR 	With Iif(Empty(SE1->E1_HIST),"Emissao de Titulo",SE1->E1_HIST)
			Replace VENCREA	With SE1->E1_VENCREA

			IF Substr(SE1->E1_TIPO,3,1) != "-" .and. ! ( SE1->E1_TIPO $"RA /"+MV_CRNEG )
				Replace DC		With "D"
			Else
				Replace DC		With "C"    //Abatimentos/RA/NCC
			Endif
			MsUnlock()
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se foi gerada fatura, faz o tratamento para considerar os    ³
		//³ os titulos baixados independente do periodo selecionado      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se houve a substituicao do NF -> DP					  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(SE1->E1_DTFATUR) .and. SE1->E1_BAIXA >= mv_par01 .and. SE1->E1_BAIXA <= mv_par02
			Reclock("cNomeArq",.t.)
			Replace CODIGO  With SE1->E1_CLIENTE
			Replace LOJA	 With SE1->E1_LOJA
			Replace DATAX	 With SE1->E1_DTFATUR
			Replace NUMERO  With SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA
			Replace HISTOR  With "Baixa Emissao Fatura"
			Replace EMISSAO With SE1->E1_EMISSAO
			Replace VALOR	 With SE1->E1_VALLIQ
			Replace VENCREA With SE1->E1_VENCREA
			IF Substr(SE1->E1_TIPO,3,1) != "-" .and. Substr(SE1->E1_TIPO,1,2) != "RA" .And. SE1->E1_TIPO != "NCC"
				Replace DC		With "C"
			Else
				Replace DC		With "D"    //Abatimentos/RA/NCC
			Endif
			MsUnlock()
		Endif
		dbSelectArea("SE1")
		dbSkip()
	Enddo
	#IFDEF TOP
		If TcSrvType() != "AS/400"
			DBSelectArea("SE1")
			DbCloseArea()
			ChkFile("SE1")
		Endif
	#ENDIF
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza e grava titulos a pagar dentro dos parametros		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
if mv_par03 == 2
	aStru := SE2->(dbStruct())
	dbSelectArea("SE2")
	#IFDEF TOP
		If TcSrvType() != "AS/400"
			cCondE2:=".T."

			cQuery := "SELECT * FROM " + RetSqlName("SE2") + " WHERE"
			cIndE2	:=IndexKey()
			If mv_par14 = 1
				cQuery += " E2_FILIAL = '" + xFilial("SE2") + "' AND "
			else
				cIndE2 :=Right(cIndE2,Len(cIndE2)-10)
			Endif
			cIndE2 := SqlOrder(cIndE2)

			dbSelectArea("SE2")
			dbCloseArea()
			dbSelectArea("SA1")

			cQuery += " E2_FORNECE BETWEEN '" + mv_par04 + "' AND '" + mv_par05 + "'"
			cQuery += " AND E2_EMIS1 <= '" + DTOS(mv_par02)  + "'"
			cQuery += " AND E2_EMIS1 <= '" + DTOS(dDataBase) + "'"
			cQuery += " AND E2_PREFIXO BETWEEN '" + mv_par12 + "' AND '" + mv_par13 + "'"
			cQuery += " AND E2_NATUREZ BETWEEN '" + mv_par16 + "' AND '" + mv_par17 + "'"
			cQuery += " AND D_E_L_E_T_ <> '*'"
			cQuery += " ORDER BY " + cIndE2

			cQuery := ChangeQuery(cQuery)
			dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SE2', .F., .T.)

			For ni := 1 to Len(aStru)
				If aStru[ni,2] != 'C'
					TCSetField('SE2', aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
				Endif
			Next
		Else
	#ENDIF
		If mv_par14 = 1
			dbSetOrder(7)
			dbSeek(xFilial(),.T.)
			cCondE2:="xFilial()==E2_FILIAL .and. E2_EMIS1<=mv_par02"
		Else
			cArqTrab:=CriaTrab(NIL,.F.)
			AADD(aInd,cArqTrab)
         cIndE2:="Dtos(E2_EMIS1)+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE"
         IndRegua("SE2",cArqTrab,cIndE2,,,OemToAnsi(STR0016)) //"Selecionando Registros..."
			cCondE2:="E2_EMIS1<=mv_par02"
			dbCommit()
			nIndex:=RetIndex("SE2")
			dbSelectArea("SE2")
			#IFNDEF TOP
				dbSetIndex(cArqTrab+OrdBagExt())
			#ENDIF
			dbSetOrder(nIndex+1)
			dbGotop()
		Endif
		#IFDEF TOP
		Endif
		#ENDIF

	While !Eof() .and. &(cCondE2)
		IF SE2->E2_FORNECE < mv_par04 .or. SE2->E2_FORNECE > mv_par05
			dbskip()
			Loop
		Endif

		If mv_par03 == 1 .or. SubStr(SE2->E2_TIPO,1,2)=="PR"
			dbskip()
			Loop
		Endif

		If mv_par11 == 2 .and. (E2_TIPO $ "PA /"+MV_CPNEG)
			dbskip()
			Loop
		Endif

		If mv_par11 == 3 .and. ! ( E2_TIPO $ "PA /"+MV_CPNEG)
			dbskip()
			Loop
		Endif

		If !Empty( mv_par12 )
			If SE2->E2_PREFIXO < mv_par12
				dbskip()
				Loop
			Endif
		Endif

		If !Empty( mv_par13 )
			If SE2->E2_PREFIXO > mv_par13
				dbskip()
				Loop
			Endif
		Endif

		If ( SE2->E2_NATUREZ < MV_PAR16 .Or. SE2->E2_NATUREZ > MV_PAR17 )
			dbskip()
			Loop
		Endif

		If !Inside(SE2->E2_TIPO)
			dbskip()
			Loop
		Endif

		If SE2->E2_EMIS1 >= mv_par01
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava credito no arquivo de trabalho	- Emiss„o              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Reclock("cNomeArq",.T.)
			Replace CODIGO  With SE2->E2_FORNECE
			Replace LOJA	 With SE2->E2_LOJA
			Replace DATAX	 With SE2->E2_EMIS1
			Replace NUMERO  With SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA
			Replace EMISSAO With SE2->E2_EMIS1
			Replace VALOR	 With SE2->E2_VLCRUZ
			Replace HISTOR  With Iif(Empty(SE2->E2_HIST),"Emissao de Titulo",SE2->E2_HIST)
			Replace VENCREA With SE2->E2_VENCREA

			If Substr(SE2->E2_TIPO,3,1) != "-" .and. ! ( SE2->E2_TIPO $ "PA /"+MV_CPNEG)
				Replace DC	With "C"
			Else
				Replace DC	With "D"    //Abatimentos
			Endif
			MsUnlock()
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se houve Substituicao de NF -> DP						  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(SE2->E2_DTFATUR) .and. SE2->E2_BAIXA >= mv_par01 .and. SE2->E2_BAIXA <= mv_par02
			Reclock("cNomeArq",.t.)
			Replace CODIGO  With SE2->E2_FORNECE
			Replace LOJA	 With SE2->E2_LOJA
			Replace DATAX   With SE2->E2_DTFATUR
			Replace NUMERO  With SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA
			Replace EMISSAO With SE2->E2_EMIS1
			Replace HISTOR  With "Baixa Emissao Fatura"
			Replace VALOR	 With SE2->E2_VALLIQ
			Replace VENCREA With SE2->E2_VENCREA

			IF Substr(SE2->E2_TIPO,3,1) != "-" .and. SE2->E2_TIPO != "PA " .and. SE2->E2_TIPO != "NDF"
				Replace DC		With "D"
			Else
				Replace DC		With "C"    //Abatimentos
			Endif
			MsUnlock( )
		Endif
		dbSelectArea("SE2")
		dbSkip()
	Enddo

	#IFDEF TOP
		If TcSrvType() != "AS/400"
			DBSelectArea("SE2")
			DbCloseArea()
			ChkFile("SE2")
		Endif
	#ENDIF
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza na movimenta‡„o banc ria, os titulos do periodo	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE5")
dbSetOrder(4)

#IFDEF TOP
	If TcSrvType() != "AS/400"
		aStru := SE5->(dbStruct())
		cCondE5:=".T."
		cQuery := "SELECT * FROM " + RetSqlName("SE5") + " WHERE"
		cIndE5	:=IndexKey()
		If mv_par14 = 1
			cQuery += " E5_FILIAL = '" + xFilial("SE5") + "' AND "
		else
			cIndE5 :=Right(cIndE5,Len(cIndE5)-10)
		Endif
		cIndE5 := SqlOrder(cIndE5)

		dbSelectArea("SE5")
		dbCloseArea()
		dbSelectArea("SA1")

		cQuery += " E5_DTDIGIT BETWEEN '" + DTOS(mv_par01) + "' AND '" + DTOS(mv_par02) + "'"
		cQuery += " AND E5_NUMERO <> '" +space(6)+"'"
		cQuery += " AND E5_SITUACA <> 'C'"
		cQuery += " AND E5_DTDIGIT <= '"+DTOS(dDataBase)+ "'"
		cQuery += " AND E5_CLIFOR BETWEEN '" + mv_par04 + "' AND '" + mv_par05 + "'"
		cQuery += " AND E5_PREFIXO BETWEEN '" + mv_par12 + "' AND '" + mv_par13 + "'"
		cQuery += " AND E5_NATUREZ BETWEEN '" + mv_par16 + "' AND '" + mv_par17 + "'"
		cQuery += " AND D_E_L_E_T_ <> '*'"
		If (mv_par03 == 1)
			cQuery += " AND (E5_RECPAG = 'R'"
			cQuery += " OR (E5_TIPODOC = 'ES' AND E5_RECPAG = 'P')"
			cQuery += " OR (E5_TIPO IN ('RA ','"+MV_CRNEG+"') AND E5_RECPAG = 'P'))"
		Endif
		If (mv_par03 == 2)
			cQuery += " AND (E5_RECPAG = 'P'"
			cQuery += " OR (E5_TIPODOC = 'ES' AND E5_RECPAG = 'R')"
			cQuery += " OR (E5_TIPO IN ('PA ','"+MV_CPNEG+"') AND E5_RECPAG = 'R'))"
		Endif

		cQuery += " ORDER BY " + cIndE5

		cQuery := ChangeQuery(cQuery)
		memowrit("finr510.sql",cquery)
		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SE5', .F., .T.)

		For ni := 1 to Len(aStru)
			If aStru[ni,2] != 'C'
				TCSetField('SE5', aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
			Endif
		Next
	Else
#ENDIF
	If mv_par14 = 1
		dbSeek(xFilial(),.T.)
		cCondE5:="xFilial()==E5_FILIAL"
	Else
		cArqTrab :=CriaTrab(NIL,.F.)
		AADD(aInd,cArqTrab)
		cIndE5	:=IndexKey()
		cIndE5	:=Right(cIndE5,Len(cIndE5)-10)
		IndRegua("SE5",cArqTrab,cIndE5,,,OemToAnsi(STR0016))  //"Selecionando Registros..."
		cCondE5:=".T."
		dbCommit()
		nIndex:=RetIndex("SE5")
		dbSelectArea("SE5")
		#IFNDEF TOP
			dbSetIndex(cArqTrab+ordBagExt())
		#ENDIF
		dbSetOrder(nIndex+1)
		dbGoTop()
	Endif

	#IFDEF TOP
	Endif
	#ENDIF

If mv_par14 == 2
	If mv_par03 == 1
		// SE1
		dbSelectArea("SE1")
		dbSetOrder(1)
		cArqTrab :=CriaTrab(NIL,.F.)
		AADD(aInd,cArqTrab)
		cIndE1	:=IndexKey()
		cIndE1	:=Right(cIndE1,Len(cIndE1)-10)
		IndRegua("SE1",cArqTrab,cIndE1,,,OemToAnsi(STR0016)) //"Selecionando Registros..."
		dbCommit()
		nIndex:=RetIndex("SE1")
		dbSelectArea("SE1")
		#IFNDEF TOP
			dbSetIndex(cArqTrab+OrdBagExT())
		#ENDIF
		dbSetOrder(nIndex+1)
		dbGotop()
	Endif
	If mv_par03 == 2
		// SE2
		dbSelectArea("SE2")
		dbSetOrder(1)
		cArqTrab :=CriaTrab(NIL,.F.)
		AADD(aInd,cArqTrab)
		cIndE2	:=IndexKey()
		cIndE2	:=Right(cIndE2,Len(cIndE2)-10)
		IndRegua("SE2",cArqTrab,cIndE2,,,OemToAnsi(STR0016) )  //"Selecionando Registros..."
		dbCommit()
		nIndex:=RetIndex("SE2")
		dbSelectArea("SE2")
		#IFNDEF TOP
			dbSetIndex(cArqTrab+OrdBagExt())
		#ENDIF
		dbSetOrder(nIndex+1)
		dbGoTop()
	Endif
Endif

dbSelectArea("SE5")

While !Eof() .and. &(cCondE5)

	IF (Empty(E5_NUMERO)) .or. ;
			(E5_SITUACA = "C") .or. ;
			(E5_DTDIGIT > mv_par02)
		dbskip()
		Loop
	Endif

	#IFDEF TOP			
		If TcSrvType() == "AS/400"
			If	!SE5->E5_TIPODOC $ "VLüBAüCPüV2üLJüES"
				SE5->(dbSkip())
				Loop
			Endif
		Endif
	#ELSE
		If	!SE5->E5_TIPODOC $ "VLüBAüCPüV2üLJüES"
			SE5->(dbSkip())
			Loop
		Endif
	#ENDIF

	If	SE5->E5_TIPO == "RA ".and. SE5->E5_TIPODOC == "ES" .and. mv_par03 == 1
		dbSelectArea("SE1")
		If mv_par14 = 1
			SE1->(dbSetOrder(1))
			SE1->(dbSeek(xFilial()+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)))
		Else
			SE1->(dbSeek(SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)))
		Endif
		If !(Found())
			dbSelectArea("SE5")
			SE5->(dbSkip())
			Loop
		Endif
	Endif

	If	SE5->E5_TIPO == "PA " .and. SE5->E5_TIPODOC == "ES"  .and. mv_par03 == 2
		dbSelectArea("SE2")
		If mv_par14 = 1
			SE2->(dbSetOrder(1))
			SE2->(dbSeek(xFilial()+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)))
		Else
			SE2->(dbSeek(SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)))
		Endif
		If !(Found())
			dbSelectArea("SE5")
			SE5->(dbSkip())
			Loop
		Endif
	Endif
	dbSelectArea("SE5")

	IF E5_DTDIGIT < mv_par01 .or. E5_DTDIGIT > mv_par02 //ok
		dbskip()
		Loop
	Endif

	IF E5_CLIFOR < mv_par04  .or. E5_CLIFOR > mv_par05 //ok
		dbskip()
		Loop
	Endif

	If !Empty( mv_par12 )											 //ok
		If SE5->E5_PREFIXO < mv_par12
			dbskip()
			Loop
		Endif
	Endif

	If !Empty( mv_par13 )
		If SE5->E5_PREFIXO > mv_par13									  //ok
			dbskip()
			Loop
		Endif
	Endif
	If ( SE5->E5_NATUREZ < MV_PAR16 .Or. SE5->E5_NATUREZ > MV_PAR17 ) //ok
		dbskip()
		Loop
	Endif

	If SE5->E5_RECPAG == "R" .and. mv_par03 == 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica quais serao impressos										  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par11 == 2 .and. (E5_TIPO $ "RA /"+MV_CRNEG) // So'Normais
			dbskip()
			Loop
		Endif

		If mv_par11 == 3 .and. !(E5_TIPO $ "RA /"+MV_CRNEG)  //So'Adiantamentos
			dbskip()
			Loop
		Endif

	ElseIf SE5->E5_RECPAG == "P" .and. mv_par03 == 2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica quais serao impressos										  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par11 == 2 .and. (E5_TIPO $ "PA /"+MV_CPNEG) // So'Normais
			dbskip()
			Loop
		Endif
		If mv_par11 == 3 .and. !(E5_TIPO $ "PA /"+MV_CPNEG) //So'Adiantamentos
			dbskip()
			Loop
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Ignora PA's pagos com Junta de Cheque                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If E5_TIPO=="PA " .and. E5_TIPODOC == "BA" .and. !empty(E5_NUMCHEQ)
			dbskip()
			Loop
		Endif
	Endif

	If mv_par03 == 1 .and. SE5->E5_RECPAG == "R" .and. SE5->E5_TIPODOC =="ES" .and. SE5->E5_TIPO <> "RA "
		dbskip()
		loop
	Elseif mv_par03 == 2 .and. SE5->E5_RECPAG == "P" .and. SE5->E5_TIPODOC =="ES"  .and. SE5->E5_TIPO <> "PA "
		dbskip()
		loop
	Endif

	IF mv_par03 == 1 .and. SE5->E5_RECPAG != "R"
		If (!(SE5->E5_TIPO $ "RA /"+MV_CRNEG ) .AND. SE5->E5_TIPODOC !="ES") .or. ; //Baixa de RA
			(SE5->E5_TIPO $ "PA /"+MV_CPNEG .AND. SE5->E5_TIPODOC =="ES")  //Estorno da Baixa de PA
			SE5->(dbSkip())
			Loop
		Endif
	Endif
	IF mv_par03 == 2 .and. SE5->E5_RECPAG != "P"
		If (!( SE5->E5_TIPO $ "PA /"+MV_CPNEG ) .AND. SE5->E5_TIPODOC !="ES") .or.;   //Baixa de PA
			(SE5->E5_TIPO $ "RA /"+MV_CRNEG .AND. SE5->E5_TIPODOC =="ES")  //Estorno da Baixa de RA
			SE5->(dbSkip())
			Loop
		Endif
	Endif

	If mv_par03 == 1 		 // Se for baixa de adiantamentos
		If SE5->E5_RECPAG == "R" .and. E5_TIPO $ "PA /"+MV_CPNEG .AND. SE5->E5_TIPODOC $ "VL/BA"
			dbskip()
			LOOP
		Endif
	Endif

	If mv_par03 == 2			// Se for baixa de adiantamentos
		If SE5->E5_RECPAG == "P" .and. E5_TIPO $ "RA /"+MV_CRNEG .AND. SE5->E5_TIPODOC $ "VL/BA"
			dbskip()
			LOOP
		Endif
	Endif

	If cPaisLoc<>"BRA" .and. E5_TIPO=="EF " .and. !Empty(E5_ORDREC)
		dbskip()
		Loop
	Endif

	If ! Inside(SE5->E5_TIPO)
		dbskip()
		Loop
	Endif

	nRec	:= SE5->(Recno())

	nPrim := 0
	cPrefixo := E5_PREFIXO
	cNumero	:= E5_NUMERO
	cParcela := E5_PARCELA
	cTipo 	:= E5_TIPO
	cNaturez := E5_NATUREZ
	nValliq	:= 0
	cFornece := E5_CLIFOR
	dDtDigit := E5_DTDIGIT
	cRecPag	:= E5_RECPAG
	cLoja 	:= E5_LOJA

	#IFNDEF TOP
		If mv_par03 == 1
			If nAnterior = 0
				nAnterior := 1
				If mv_par14 = 1
					dbSeek(xFilial()+cNaturez+cPrefixo+cNumero+cParcela+cTipo+Dtos(dDtDigit)+cRecPag)
				Else
					dbSeek(cNaturez+cPrefixo+cNumero+cParcela+cTipo+Dtos(dDtDigit)+cRecPag)
				Endif
			Endif
		Elseif mv_par03 == 2
			If nAnterior = 0
				nAnterior := 1
				If mv_par14 = 1
					dbSeek(xFilial()+cNaturez+cPrefixo+cNumero+cParcela+cTipo+Dtos(dDtDigit)+cRecPag+cFornece+cLoja)
				Else
					dbSeek(cNaturez+cPrefixo+cNumero+cParcela+cTipo+Dtos(dDtDigit)+cRecPag+cFornece+cLoja)
				Endif
			Endif
		Endif
	#ELSE
		If TcSrvType() == "AS/400"
			dbSelectArea("SE5")
			If mv_par03 == 1
				If nAnterior = 0
					nAnterior := 1
					If mv_par14 = 1
						dbSetOrder(4)
						dbSeek(xFilial()+cNaturez+cPrefixo+cNumero+cParcela+cTipo+Dtos(dDtDigit)+cRecPag)
					Else
						dbSeek(cNaturez+cPrefixo+cNumero+cParcela+cTipo+Dtos(dDtDigit)+cRecPag)
					Endif
				Endif
			Elseif mv_par03 == 2
				If nAnterior = 0
					nAnterior := 1
					If mv_par14 = 1
						dbSetOrder(4)
						dbSeek(xFilial()+cNaturez+cPrefixo+cNumero+cParcela+cTipo+Dtos(dDtDigit)+cRecPag+cFornece+cLoja)
					Else
						dbSeek(cNaturez+cPrefixo+cNumero+cParcela+cTipo+Dtos(dDtDigit)+cRecPag+cFornece+cLoja)
					Endif
				Endif
			Endif
		Endif
	#ENDIF

	While !Eof() .and. E5_PREFIXO == cPrefixo .and. ;
			E5_NUMERO == cNumero	.and. ;
			E5_PARCELA == cParcela .and. ;
			E5_TIPO == cTipo 		.and. ;
			E5_NATUREZ == cNaturez .and. ;
			E5_DTDIGIT == dDtDigit .and. ;
			E5_RECPAG	== cRecPag

		If mv_par03 == 2 .and. E5_CLIFOR+E5_LOJA != cFornece+cLoja
			Exit
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Devera' ser considerado o valor liquido da baixa          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IF Empty(E5_NUMERO) .or. E5_SITUACA = "C"
			dbSkip()
			Loop
		Endif

		IF E5_DTDIGIT < mv_par01 .or. E5_DTDIGIT > mv_par02
			dbSkip()
			Loop
		Endif

		IF E5_CLIFOR < mv_par04 .or. E5_CLIFOR > mv_par05
			dbSkip()
			Loop
		Endif

		IF mv_par03 == 1 .and. SE5->E5_RECPAG != "R"
			If (!(SE5->E5_TIPO $ "RA /"+MV_CRNEG ) .AND. SE5->E5_TIPODOC !="ES") .or. ; //Baixa de RA
				(SE5->E5_TIPO $ "PA /"+MV_CPNEG .AND. SE5->E5_TIPODOC =="ES")  //Estorno da Baixa de PA
				SE5->(dbSkip())
				Loop
			Endif
		Endif
		
		IF mv_par03 == 2 .and. SE5->E5_RECPAG != "P"
			If (!( SE5->E5_TIPO $ "PA /"+MV_CPNEG ) .AND. SE5->E5_TIPODOC !="ES") .or.;   //Baixa de PA
				(SE5->E5_TIPO $ "RA /"+MV_CRNEG .AND. SE5->E5_TIPODOC =="ES")  //Estorno da Baixa de RA
				SE5->(dbSkip())
				Loop
			Endif
		Endif
		If mv_par03 == 1        // Se for baixa de adiantamentos
			If SE5->E5_RECPAG == "R" .and. E5_TIPO $ "PA /"+MV_CPNEG .AND. SE5->E5_TIPODOC $ "VL/BA"
				dbSkip()
				LOOP
			Endif
		Endif
	
		If mv_par03 == 2        // Se for baixa de adiantamentos
			If SE5->E5_RECPAG == "P" .and. E5_TIPO $ "RA /"+MV_CRNEG .AND. SE5->E5_TIPODOC $ "VL/BA"
				dbSkip()
				LOOP
			Endif
		Endif

		IF nPrim == 0
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Localiza o cliente ou fornecedor								  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cCarteira := E5_RECPAG
			If E5_RECPAG == "R"
				If ( E5_TIPO$ "PA /"+MV_CPNEG).and.E5_TIPODOC $ "BAüVL" .and. !Empty(E5_BANCO);
						.OR. E5_TIPODOC =="ES"
					cCarteira := "P"        //Baixa de adiantamento (inverte)
				Endif
				IF	(E5_TIPO$ "RA /"+MV_CRNEG)
					cCarteira := "R"		  //Cancelamento da Baixa Adiantamento
				Endif
			Endif

			If E5_RECPAG == "P"
				If (E5_TIPO$"RA /"+MV_CRNEG).and.E5_TIPODOC $ "BAüVL" .and.!Empty(E5_BANCO);
						.OR. E5_TIPODOC =="ES"
					cCarteira := "R"        //Baixa de adiantamento (inverte)
				Endif
				IF	(E5_TIPO$ "PA /"+MV_CPNEG)
					cCarteira := "P"		  //Cancelamento da Baixa Adiantamento
				Endif
			Endif

			dbSelectArea("SE5")
			IF cCarteira == "R"
				If mv_par14 = 1
					SE1->(dbSetOrder(1))
					SE1->(dbSeek(xFilial()+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)))
				Else
					SE1->(dbSeek(SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)))
				Endif
			Else
				If mv_par14 = 1
					SE2->(dbSetOrder(1))
					SE2->(dbSeek(xFilial()+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)))
				Else
					SE2->(dbSeek(SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)))
				Endif
			Endif
			IF cCarteira == "R"
				dEmissao:=SE1->E1_EMISSAO
				dVencto :=SE1->E1_VENCREA
			Else
				dEmissao:=SE2->E2_EMISSAO
				dVencto :=SE2->E2_VENCREA
			Endif
			nPrim++
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta Array com dados do titulo Pai. Usado apenas quando for       ³
		//³ TOP, nÆo AS/400, e NÆo imprimir valores financeiros (mv_par10 = 2) ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		#IFDEF TOP
			If TcSrvType() != "AS/400" .and. mv_par10 == 2
				aDadosSe5 := TrabDados()
			Endif
		#ENDIF
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ A fun‡Æo TRABDADOS() ‚ utilizada para montar array com os da-³
		//³ dos necessarios do SE5 para a grava‡Æo no arquivo de trabalho³
		//³ Isto se deve ao fato de no SQL, quando mv_par10 = 2 (nÆo im- ³
		//³ prime valores financeiros), a Query est  sempre um registro  ³
		//³ posterior a montagem dos valores e nÆo ser possivel reposi-  ³
		//³ cionar no registro devido                                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IF E5_TIPODOC $ "VL/LJ/ES"
			nValliq+=E5_VALOR
			IIF(mv_par10==1,GRAVATRAB("B",dEmissao,dVencto,,TrabDados()),NIL)
		ElseIF E5_TIPODOC $ "BA/V2/CP"
			nValliq+=E5_VALOR
			IIF(mv_par10==1,GRAVATRAB("B",dEmissao,dVencto,,TrabDados()),NIL)
		ElseIF E5_TIPODOC $ "DC/D2"
			nValliq+=E5_VALOR
			IIF(mv_par10==1,GRAVATRAB("D",dEmissao,dVencto,,TrabDados()),NIL)
		Elseif E5_TIPODOC $ "MT/JR/J2/M2"
			IIF(mv_par10==1,GRAVATRAB("M",dEmissao,dVencto,,TrabDados()),NIL)
			nValliq-=E5_VALOR
		Elseif E5_TIPODOC $ "CM/C2/CX"
			IIF(mv_par10==1,GRAVATRAB("C",dEmissao,dVencto,,TrabDados()),NIL)
			nValLiq-=E5_VALOR
		Endif
		If cPaisLoc	# "BRA".And. !Empty(SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA)
			SA6->(DbSetOrder(1))
			SA6->(DbSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
			nValLiq	:=	Round(xMoeda(nValLiq,Max(SA6->A6_MOEDA,1),1,SE5->E5_DATA,nDecs+1),nDecs)
		Endif			
		dbSkip()
	Enddo
	#IFNDEF TOP
		nRec1 := SE5->(Recno())
		dBGoto(nRec)
	#ENDIF

	IF mv_par10==2 .and. nValLiq != 0
		#IFDEF TOP
			If TcSrvType() != "AS/400"
				GravaTrab("B",dEmissao,dVencto,nValLiq,aDadosSE5)
			Else
		#ENDIF
				GravaTrab("B",dEmissao,dVencto,nValLiq,TrabDados())
		#IFDEF TOP
			Endif
		#ENDIF
	Endif
	#IFNDEF TOP
		dbGoto(nRec1)
	#ENDIF
	nAnterior := 0
Enddo
#IFDEF TOP
	If TcSrvType() != "AS/400"
		DBSelectArea("SE5")
		DbCloseArea()
		ChkFile("SE5")
	Endif
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia rotina de impressao											  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("cNomeArq")
dbGoTop()

SetRegua(RecCount())

While !Eof()

	#IFNDEF WINDOWS
		Inkey()
		If LastKey() = K_ALT_A
			lEnd := .t.
		Endif
	#ENDIF

	IF lEnd
		@PROW()+1,0 PSAY OemToAnsi(STR0017)  //"Cancelado pelo Operador"
		Exit
	Endif

	IF li > 58
		IF m_pag == mv_par07
			m_pag := 2
		Endif
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(nCompress==1,15,18))
	Endif

	IF nQuebra == 0
		dData := DATAX
		nTotTit := 0
		nTotDeb := 0
		nTotCrd := 0
		nQuebra := 1
	Endif

	IF dData != DATAX
		SubTot510(dData,nTotTit,nTotDeb,nTotCrd)
		nGerTit += nTotTit
		nGerDeb += nTotDeb
		nGerCrd += nTotCrd
		nQuebra := 0
		li ++; li ++
		Loop
	Endif
	nTamNro:= IIf(GetMV("MV_PAISLOC")=="ARG",12,6)
	IncRegua()
	@li,	0 PSAY DATAX
	@li, 11 PSAY Substr(NUMERO,1,3)+"-"+Substr(NUMERO,4,nTamNro)
	@li, 28 PSAY Substr(NUMERO,nTamNro+4,1)
	@li, 30 PSAY CODIGO

	IF mv_par03 == 1
		dbSelectArea("SA1")
	Else
		dbSelectArea("SA2")
	Endif
	dbSeek(xFilial()+cNomeArq->CODIGO+cNomeArq->LOJA)
	@li,37 PSAY IIF(mv_par03==1,Substr(SA1->A1_NOME,1,21),Substr(SA2->A2_NOME,1,21))
	Select cNomeArq
	@li,59 PSAY EMISSAO
	@li,70 PSAY VENCREA
	@li,81 PSAY SubStr(HISTOR, 1, 22)
	nC := IIF( DC = "D",103,118)
	@li,nC PSAY VALOR 	Picture tm(VALOR,14,nDecs)
	If Len(AllTrim(HISTOR)) > 22
		li++
		@li,81 PSAY SubStr(HISTOR,22,17)
	Endif
	nTotTit ++
	IF DC == "D"
		nTotDeb += VALOR
	Else
		nTotCrd += VALOR
	Endif
	li ++
	dbSkip()
Enddo

If li != 80
	If li > 58
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(nCompress==1,15,18))
	Endif
	SubTot510(dData,nTotTit,nTotDeb,nTotCrd)
	nGerTit += nTotTit
	nGerDeb += nTotDeb
	nGerCrd += nTotCrd
	li += 2
	@li,000 PSAY OemToAnsi(STR0018)  //"T O T A L  G E R A L ->"
	@li,026 PSAY nGerTit		Picture "999999"
	@li,035 PSAY OemToAnsi(STR0019)  //"Movimentacoes"
	@li,103 PSAY nGerDeb		Picture tm(nGerDeb,14,nDecs)
	@li,118 PSAY nGerCrd		Picture tm(nGerCrd,14,nDecs)
	roda(cbcont,cbtxt,Tamanho)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Apaga arquivo e indice temporario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("cNomeArq")
dbCloseArea()
Ferase(cNomeArq+".DBF")
Ferase(cNomeArq+OrdBagExt())
Set Device To Screen

#IFDEF TOP
	If TcSrvType() != "AS/400"
		dbSelectArea("SE1")
		dbCloseArea()
		ChKFile("SE1")
		dbSelectArea("SE1")
		dbSetOrder(1)

		dbSelectArea("SE2")
		dbCloseArea()
		ChKFile("SE2")
		dbSelectArea("SE2")
		dbSetOrder(1)

		dbSelectArea("SE5")
		dbCloseArea()
		ChKFile("SE5")
		dbSelectArea("SE5")
		dbSetOrder(1)
	Else
#ENDIF
	dbSelectArea("SE1")
	RetIndex("SE1")
	dbSetOrder(1)
	Set Filter To

	dbSelectArea("SE2")
	RetIndex("SE2")
	dbSetOrder(1)
	Set Filter To

	dbSelectArea("SE5")
	RetIndex("SE5")
	dbSetOrder(1)
	Set Filter To
	#IFDEF TOP
	Endif
	#ENDIF

For nI:=1 to Len(aInd)
	if File(aInd[nI]+OrdBagExt())
		Ferase(aInd[nI]+OrdBagExt())
	Endif
Next

If aReturn[5] = 1
	Set Printer TO
	dbCommitall()
	ourspool(wnrel)
End
MS_FLUSH()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ SubTot510³ Autor ³ Wagner Xavier 		  ³ Data ³ 25.11.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime subtotal do Relatorio - Diario Auxiliar				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ SubTot510() 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Data,Total de Titulos,Total Debito,Total Credito			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINR510																	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function SubTot510(dData,nTotTit,nTotDeb,nTotCrd)

li++
@li,	0 PSAY OemToAnsi(STR0027)+Dtoc(dData)  //"TOTAL DO DIA "
@li,103 PSAY nTotDeb 	Picture tm(nTotDeb,14,nDecs)
@li,118 PSAY nTotCrd 	Picture tm(nTotCrd,14,nDecs)
Return (.t.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ GravaTrab³ Autor ³ Wagner Xavier 		  ³ Data ³ 25.11.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava registro de trabalho.										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ GravaTrab() 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GravaTrab( cTipo,dEmissao,dVencto,nValor,aDados)
LOCAL cDCR,cDCP,cAlias:=Alias()
Local nMoedaBco	:=	1
If cPaisLoc	# "BRA"
	If !Empty(SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA)
		SA6->(DbSetOrder(1))
		SA6->(DbSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
		nMoedaBco	:=	Max(SA6->A6_MOEDA,1)
	EnDif
	nValor	:=	Iif( nValor=Nil,Round(xMoeda(SE5->E5_VALOR,nMoedaBco,1,SE5->E5_DATA,nDecs+1),nDecs),nValor )
Else
	nValor	:= Iif( nValor=Nil,SE5->E5_VALOR,nValor )
Endif
Do Case
Case cTipo == "B"
	cDCR="C"
	cDCP="D"
CASE cTipo == "D"
	cDCR="C"
	cDCP="D"
Case cTipo == "M"
	cDCR="D"
	cDCP="C"
OtherWise
	cDCR="D"
	cDCP="C"
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava registro no arquivo de trabalho 							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Reclock("cNomeArq",.t.)
Replace CODIGO  With aDados[1]	// SE5->E5_CLIFOR
Replace LOJA	 With aDados[2]	// SE5->E5_LOJA
Replace DATAX	 With aDados[3]	// SE5->E5_DTDIGIT
Replace NUMERO  With aDados[4]	// SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA
Replace VALOR	 With nValor
Replace EMISSAO With aDados[5]	//	SE5->E5_DATA
Replace HISTOR  With Iif(Empty(aDados[6]),"Baixa de Titulo",aDados[6])
Replace VENCREA With dVencto

IF aDados[7] = "R" 					//SE5->E5_RECPAG
	Replace DC With Iif( ! ( aDados[8] $"RA /"+MV_CRNEG) .or. ;  //SE5->E5_TIPO
		aDados[9]=="ES",cDCR,cDCP) 						 //SE5->E5_TIPODOC
Else
	Replace DC With Iif( ! ( aDados[8] $"PA /"+MV_CPNEG) .or. ;  //SE5->E5_TIPO
		aDados[9]=="ES",cDCP,cDCR)						 //SE5->E5_TIPODOC
Endif
MsUnlock()
dbSelectArea(cAlias)
Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Inside 	³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³         																	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function InSide(cTp)
IF mv_par15 != 1
	Return .t.
Else
	Return (cTp$cTipos)
Endif

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ AndaTRB	³ Autor ³ Emerson / Sandro      ³ Data ³ 20.09.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Movimenta area temporaria e reposiciona SE1 ou SE2 ou SE5  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³         																	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AndaTRB()
#IFDEF TOP
	If TcSrvType() != "AS/400"
		TRB510->(dbSkip())
		dbGoTo(TRB510->Recno)
	Else
		dbSkip()
	Endif
#ELSE
	dbSkip()
#ENDIF

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ TrabDados³ Autor ³ Mauricio Pequim Jr    ³ Data ³ 22.03.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Monta array com dados do titulo para grava‡Æo do TRB  	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ TrabDados() 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function TrabDados()
LOCAL aDados := Array(9)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava registro no array de trabalho 							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aDados[1] := E5_CLIFOR
aDados[2] := E5_LOJA
aDados[3] := E5_DTDIGIT
aDados[4] := E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA
aDados[5] := E5_DATA
aDados[6] := E5_HISTOR
aDados[7] := E5_RECPAG
aDados[8] := E5_TIPO
aDados[9] := E5_TIPODOC

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  necess rio for‡ar o historico quando for TOP, nÆo AS/400, e NÆo  ³
//³imprimir valores financeiros (mv_par10 = 2) pois os dados guardados ³
//³no array, caso o titulo sofreu desconto (por ex.), ‚ o do registro  ³
//³do desconto no SE5, o que causaria informa‡Æo de hist¢rico errado   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
	If TcSrvType() != "AS/400" .and. mv_par10 == 2 .and. ;
		(Empty(aDados[6]) .or. !(adados[9] $ "VL/BA/CP/PA/RA/ES"))
		aDados[6] := "Baixa de Titulo"
	Endif
#ENDIF

Return aDados
