#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'MSOLE.CH'

Static cRootPath   := AllTrim(GetPvProfString(GetEnvServer(), 'RootPath', 'ERROR', GetADV97()) + If(Right(AllTrim(GetPvProfString(GetEnvServer(), 'RootPath', 'ERROR', GetADV97())), 1) == '\', '', '\'))
Static cStartPath  := AllTrim(GetPvProfString(GetEnvServer(), 'StartPath', 'ERROR', GetADV97()) + If(Right(AllTrim(GetPvProfString(GetEnvServer(), 'StartPath', 'ERROR', GetADV97())), 1) == '\', '', '\'))
Static cPathFisico := Left(cRootPath, Len(cRootPath) - 1) + If(Left(cStartPath, 1) <> '\', '\', '') + cStartPath

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³PROGRAMA  ³TIBR030   ³Autor  ³Totvs Ibirapuera                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³Impressao grafica do orcamento de vendas                    ³±±
±±³          ³Associar o programa TIBR030 ao parametro MV_ORCIMPR         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TIBR030()
Local lOk        := .F.
Local aSays      := {}
Local aButtons   := {}
Local aKeySX1    := {}
Local cPerg      := 'TIBR030'

//-- Ajusta Dicionario de Dados:
AjustSX1(cPerg)
Pergunte(cPerg, .F.,,,, .F.)

//-- Trata a chamada do relatorio a partir
//-- da rotina de manutencao de Orcamentos:
If IsInCallStack('MATA415')
	aKeySX1 := {	{cPerg, '01', SCJ->CJ_NUM}				, {cPerg, '02', SCJ->CJ_NUM},;
					{cPerg, '03', DtoC(SCJ->CJ_EMISSAO)}	, {cPerg, '04', DtoC(SCJ->CJ_EMISSAO)},;
					{cPerg, '05', SCJ->CJ_CLIENTE} 			, {cPerg, '06', SCJ->CJ_LOJA},;
					{cPerg, '07', SCJ->CJ_CLIENTE} 			, {cPerg, '08', SCJ->CJ_LOJA} }

	//-- Atribui os valores do Orcamento selecionado
	//-- aos parametros do relatorio:
	HS_PosSX1(aKeySX1)
	MV_PAR01 := SCJ->CJ_NUM
	MV_PAR02 := SCJ->CJ_NUM
	MV_PAR03 := SCJ->CJ_EMISSAO
	MV_PAR04 := SCJ->CJ_EMISSAO
	MV_PAR05 := SCJ->CJ_CLIENTE
	MV_PAR06 := SCJ->CJ_LOJA
	MV_PAR07 := SCJ->CJ_CLIENTE
	MV_PAR08 := SCJ->CJ_LOJA
EndIf

// -----------------------------------------------------
// Dialogo principal para parametrizacao
// -----------------------------------------------------
AAdd(aSays, 'Este programa tem por objetivo realizar a impressao do Orcamento de venda ')
AAdd(aSays, 'utilizando a integracao com o Microsoft Word. O modelo para impressão deverá')
AAdd(aSays, 'estar disponível na pasta: ' + cStartPath + 'MODELOS\')
AAdd(aButtons, {5, .T., {|| Pergunte(cPerg,.T.,,,,.F.)}})
AAdd(aButtons, {1, .T., {|o| lOk := .T.,o:oWnd:End()}})
AAdd(aButtons, {2, .T., {|o| o:oWnd:End()}})

FormBatch('Impressão de Orçamentos de Venda', aSays, aButtons,,, 650)

If lOk
	Processa({|lEnd| TIBR030Prc(@lEnd)}, 'Aguarde...', 'Realizando a impressao do documento...', .T.)
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TIBR030Prc ³ Autor ³V.RASPA                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Realiza a impressao do Orcamento de Venda                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function TIBR030Prc(lEnd)
Local cArqModel  := ''
Local cExtension := ''
Local cPathDest  := ''
Local cArqTemp   := ''
Local cQuery     := ''
Local cAliasQry  := ''
Local cNewFile   := ''
Local nItem      := 0
Local nValTot    := 0
Local nValImp    := 0
Local cObserv    := ''
Local cMVMoeda   := ''
Local cMoeda     := ''
Local nPos       := 0
Local aImpostos  := {}
Local oWord      := NIL
Local lContinua  := .T.

// --------------------------------------------
// TRATA A VERSAO DO MS WORD
// --------------------------------------------
If MV_PAR11 == 1
	cArqModel := cPathFisico + 'MODELOS\TIBR030.dot'
	//-- Se a versao do Ms Word for a 97/2003 nao permite
	//-- a saida do relatorio em PDF
	If MV_PAR10 == 1
		Aviso('ATENÇÃO', 'Não é possível realizar a geração do documento no formato "PDF" para versao 97/2003 do Microsoft Word. O formato do documento será reajustado para "DOC"', {'OK'}, 2)
		MV_PAR10 := 2
	EndIf
Else
	cArqModel   := cPathFisico + 'MODELOS\TIBR030.dotm'
EndIf

// ---------------------------------------
// VERIFICA SE O ARQUIVO "MODELO" EXISTE
// ---------------------------------------
If !File(cArqModel)
	lContinua := .F.
	Aviso('ATENÇÃO', 'O arquivo ' + cArqModel + ' não existe! Entre em contato com o Administrador do sistema.', {'OK'}, 2)
EndIf

// ---------------------------------------
// TRATA GRAVACAO EM DISCO
// ---------------------------------------
If lContinua
	If MV_PAR09 == 2
		cExtension := If(MV_PAR10 == 1, '*.PDF', If(MV_PAR11 == 1, '*.DOC', '*.DOCX'))
		cPathDest  := Alltrim(cGetFile ('Arquivo' + cExtension + '|' + cExtension +'|' , 'Selecione a pasta para gravação.', 1, '', .T., GETF_LOCALHARD+GETF_RETDIRECTORY,.F.))
		If Empty(cPathDest)
			Aviso('ATENÇÃO', 'Processo cancelado pelo usuário!', {'OK'}, 2)
			lContinua := .F.
		Else
			lContinua := ChkPerGrv(cPathDest)
			If !lContinua
				Aviso('ATENÇÃO', 'Você não possuí permissão de gravação para pasta selecionada. Tente Selecionar outra pasta.', {'OK'}, 2)
			EndIf
		EndIf
	Endif
EndIf

// ------------------------------------------------
// TRANSFERE MODELO WORD DO SERVIDOR P/ ESTACAO
// ------------------------------------------------
If lContinua
	cArqTemp := AllTrim(GetTempPath()) + If(Right(AllTrim(GetTempPath()), 1) == '\', '', '\') + GetNextAlias() + If(MV_PAR11 == 1, '.dot', '.dotm')
	If !CpyS2TEx(cArqModel, cArqTemp)
		lContinua := .F.
		Aviso('ATENÇÃO',;
				'Não foi possível transferir o modelo Word do Servidor para sua estação de trabalho! Tente reiniciar o computador. Caso o problema persista, entre em contato com o Administrador do sistema', {'OK'}, 2)
	EndIf
EndIf

// -------------------------------------------------
// PROCESSA QUERY PARA IMPRESSAO DO ORCAMENTO
// -------------------------------------------------
If lContinua
	cQuery := "SELECT SCJ.CJ_NUM, SCJ.CJ_CLIENTE, SCJ.CJ_LOJA, SCJ.CJ_EMISSAO, SCJ.CJ_CONDPAG, SCJ.CJ_MOEDA, "
	cQuery += "       SA1.A1_NOME, SA1.A1_CONTATO, SA1.A1_CGC, SA1.A1_INSCR, SA1.A1_END, SA1.A1_BAIRRO, "
	cQuery += "       SA1.A1_MUN, SA1.A1_CEP, SA1.A1_EST, SA1.A1_DDD, SA1.A1_ENDENT, SA1.A1_ENDCOB, SA1.A1_BAIRROC, "
	cQuery += "       SA1.A1_BAIRROE, SA1.A1_TEL, SA1.A1_FAX, SCJ.CJ_CLIENT, SCJ.CJ_LOJAENT, SCJ.CJ_FRETE "
	cQuery += "   FROM " + RetSQLTab('SCJ')
	cQuery += "   JOIN " + RetSQLTab('SA1')
	cQuery += "     ON SA1.A1_FILIAL = '" + xFilial("SA1") + "' "
	cQuery += "    AND SA1.A1_COD = SCJ.CJ_CLIENTE "
	cQuery += "    AND SCJ.CJ_LOJA = SA1.A1_LOJA "
	cQuery += "    AND SA1.D_E_L_E_T_ = ' ' "
	cQuery += "  WHERE SCJ.CJ_FILIAL = '" + xFilial("SCJ") + "' "
	cQuery += "    AND SCJ.CJ_NUM BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
	cQuery += "    AND SCJ.CJ_EMISSAO BETWEEN '" + DtoS(MV_PAR03) + "' AND '" + DtoS(MV_PAR04) + "' "
	cQuery += "    AND SCJ.CJ_CLIENTE BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR07 + "' "
	cQuery += "    AND SCJ.CJ_LOJA BETWEEN '" + MV_PAR06 + "' AND '" + MV_PAR08 + "' "
	cQuery += "    AND SCJ.D_E_L_E_T_ = ' '"
	cQuery += "  ORDER BY SCJ.CJ_NUM "

	//-- Processa Query:
	cQuery    := ChangeQuery(cQuery)
	cAliasQry := GetNextAlias()
	MsgRun('Aguarde...', 'Processando a query...',;
			{|| DbUseArea(.T., "TOPCONN", TCGENQRY(,,cQuery), cAliasQry, .F., .T.)})

	If (cAliasQry)->(Eof())
		Aviso('ATENÇÃO', 'Não há dados para impressão. Verifique os parâmetros do relatório e tente novamente.', {'OK'}, 2)
	Else
		While !(cAliasQry)->(Eof())
			//-- Trata o Simbolo da Moeda do orcamento
			cMVMoeda   := 'MV_SIMB' + AllTrim(Str((cAliasQry)->CJ_MOEDA ,2))
			cMoeda     := AllTrim(GetMV(cMVMoeda))

			//-- Arquivo que sera gerado:
			cNewFile := cPathDest + If(Right(cPathDest, 1) == '\', '', '\') + (cAliasQry)->CJ_NUM + '_' + DtoS(dDataBase) + '_' + StrTran(Time(), ':', '') + '_TIBR030' + StrTran(cExtension, '*', '')

			// --------------------------------------
			// ESTABELECE COMUNICACAO COM O MS WORD
			// --------------------------------------
			oWord := OLE_CreateLink()
			OLE_SetProperty(oWord, oleWdVisible, .F.)
			if oWord == "-1"
				Aviso('ATENÇÃO', 'Não foi possível estabelecer a conexao com o MS-Word!', {'OK'}, 2)
			Else
				// -----------------------------------
				// CARREGA MODELO
				// -----------------------------------
				OLE_NewFile(oWord, Alltrim(cArqTemp))

				// -------------------------------------------
				// REALIZA O PROCESSO DE MACRO SUBSTITUICAO
				// DOS CAMPOS DO MODELO WORD
				// -------------------------------------------
				OLE_SetDocumentVar(oWord, 'cNumOrc'			, (cAliasQry)->CJ_NUM)
				OLE_SetDocumentVar(oWord, 'cRazaoSocial'	, SM0->M0_NOMECOM)
				OLE_SetDocumentVar(oWord, 'cEndCob'			, AllTrim(SM0->M0_ENDCOB) + ' - ' + Alltrim(SM0->M0_BAIRCOB) + ' - ' + AllTrim(SM0->M0_CIDCOB) + ' - ' + SM0->M0_ESTCOB)
				OLE_SetDocumentVar(oWord, 'cEndEntr'		, AllTrim(SM0->M0_ENDENT) + ' - ' + Alltrim(SM0->M0_BAIRENT) + ' - ' + AllTrim(SM0->M0_CIDENT) + ' - ' + SM0->M0_ESTENT)
				OLE_SetDocumentVar(oWord, 'cCEP'			, Transform(SM0->M0_CEPCOB, "@R 99999-999"))
				OLE_SetDocumentVar(oWord, 'cFone'			, SM0->M0_TEL)
				OLE_SetDocumentVar(oWord, 'cCNPJ'			, Transform(SM0->M0_CGC, "@R 99.999.999/9999-99"))

				OLE_SetDocumentVar(oWord, 'cCliente'		, (cAliasQry)->A1_NOME)

				If Empty((cAliasQry)->A1_ENDCOB)
					OLE_SetDocumentVar(oWord, 'cEndCliCob'	, AllTrim((cAliasQry)->A1_END) + ' - ' + AllTrim((cAliasQry)->A1_BAIRRO) + ' - ' + AllTrim((cAliasQry)->A1_MUN) + ' - ' + (cAliasQry)->A1_EST + ' (COBRANÇA)')
				Else
					OLE_SetDocumentVar(oWord, 'cEndCliCob'	, AllTrim((cAliasQry)->A1_ENDCOB) + ' - ' + AllTrim((cAliasQry)->A1_BAIRROC) + ' - ' + AllTrim((cAliasQry)->A1_MUN) + ' - ' + (cAliasQry)->A1_EST + ' (COBRANÇA)')
				EndIf

				If Empty((cAliasQry)->A1_ENDENT)
					OLE_SetDocumentVar(oWord, 'cEndCliEntr'	, AllTrim((cAliasQry)->A1_END) + ' - ' + AllTrim((cAliasQry)->A1_BAIRRO) + ' - ' + AllTrim((cAliasQry)->A1_MUN) + ' - ' + (cAliasQry)->A1_EST + ' (ENTREGA)')
				Else
					OLE_SetDocumentVar(oWord, 'cEndCliEntr'	, AllTrim((cAliasQry)->A1_ENDENT) + ' - ' + AllTrim((cAliasQry)->A1_BAIRROE) + ' - ' + AllTrim((cAliasQry)->A1_MUN) + ' - ' + (cAliasQry)->A1_EST + ' (ENTREGA)')
				EndIf

				OLE_SetDocumentVar(oWord, 'cCEPCli'			, Transform((cAliasQry)->A1_CEP, "@R 99999-999"))
				OLE_SetDocumentVar(oWord, 'cFoneCli'		, (cAliasQry)->A1_TEL)
				OLE_SetDocumentVar(oWord, 'cCNPJCli'		, Transform((cAliasQry)->A1_CGC, "@R 99.999.999/9999-99"))
				OLE_SetDocumentVar(oWord, 'cMoeda'			, cMoeda)

				// ---------------------------------------------
				// TRATAMENTO DOS ITENS DO ORCAMENTO
				// ---------------------------------------------
				nItem   := 0
				nValTot := 0
				nValImp := 0
				cObserv := ''

				SCK->(DbSetOrder(1)) //--CK_FILIAL+CK_NUM+CK_ITEM+CK_PRODUTO
				SCK->(DbSeek(xFilial('SCK')+(cAliasQry)->CJ_NUM))
				While !SCK->(Eof()) .And. SCK->(CK_FILIAL+CK_NUM) == xFilial('SCK')+(cAliasQry)->CJ_NUM
					nItem++
					OLE_SetDocumentVar(oWord, 'cItem' + AllTrim(Str(nItem))		, SCK->CK_ITEM)
					OLE_SetDocumentVar(oWord, 'cCodPro' + AllTrim(Str(nItem))	, AllTrim(SCK->CK_PRODUTO))
					OLE_SetDocumentVar(oWord, 'cDescPro' + AllTrim(Str(nItem))	, AllTrim(SCK->CK_DESCRI))
					OLE_SetDocumentVar(oWord, 'cUM' + AllTrim(Str(nItem))		, SCK->CK_UM)
					OLE_SetDocumentVar(oWord, 'dDtEntr' + AllTrim(Str(nItem))	, DtoC(SCK->CK_ENTREG))
					OLE_SetDocumentVar(oWord, 'nQtde' + AllTrim(Str(nItem))		, Transform(SCK->CK_QTDVEN, PesqPict('SCK', 'CK_QTDVEN')))
					OLE_SetDocumentVar(oWord, 'nValUnit' + AllTrim(Str(nItem))	, Transform(SCK->CK_PRCVEN, PesqPict('SCK', 'CK_PRCVEN')))
					OLE_SetDocumentVar(oWord, 'nTotItem' + AllTrim(Str(nItem))	, Transform(SCK->CK_VALOR, PesqPict('SCK', 'CK_VALOR')))

					nValTot += SCK->CK_VALOR
					If !Empty(SCK->CK_OBS)
						cObserv += '[Item ' + SCK->CK_ITEM + '] ' + AllTrim(SCK->CK_OBS) + Chr(10) + Chr(13)
					EndIf

					SCK->(DbSkip())
				End

				OLE_SetDocumentVar(oWord, 'nItens', AllTrim(Str(nItem)))
				OLE_ExecuteMacro(oWord, "mcrItens")

				// --------------------------------------------------
				// TRATA TOTAIS, CONDICAO DE PAGAMENTO E OBSERVACOES
				// --------------------------------------------------
				OLE_SetDocumentVar(oWord, 'nValTot'	, Transform(nValTot, PesqPict('SCK', 'CK_VALOR')))

				//-- Valor dos Impostos:
				aImpostos := TIBR030Imp((cAliasQry)->CJ_NUM)
				AEval(aImpostos, {|e| If(AllTrim(e[1]) == 'IPI', nValImp += e[5], NIL)})
				OLE_SetDocumentVar(oWord, 'nValImp'	, Transform(nValImp, PesqPict('SCK', 'CK_VALOR')))

				//-- Totaliza o Orcamento:
				OLE_SetDocumentVar(oWord, 'nTotal'	, Transform(nValTot + nValImp, PesqPict('SCK', 'CK_VALOR')))

				//-- Condicao de Pagamento
				SE4->(DbSetOrder(1))
				SE4->(DbSeek(xFilial('SE4')+(cAliasQry)->CJ_CONDPAG))
				OLE_SetDocumentVar(oWord, 'cCondPag'	, AllTrim(SE4->E4_DESCRI))

				//-- Observacoes
				OLE_SetDocumentVar(oWord, 'cObs'	, AllTrim(cObserv))

				//-- Atualiza os campos
				OLE_UpDateFields(oWord)

				//-- Determina a saida do relatorio:
				If MV_PAR09 == 1
					OLE_PrintFile(oWord, cNewFile,,, 1)
					Sleep(1000)
				Else
					OLE_SaveAsFile(oWord, cNewFile,,,, If(MV_PAR10 == 1, '17', NIL)) //--Parametro '17' salva em pdf
				Endif

				//--Fecha link com MS-Word
				OLE_CloseFile(oWord)
				OLE_CloseLink(oWord)
			EndIf
			(cAliasQry)->(DbSkip())
			IncProc()
		End
		//-- Exclui arquivo modelo na estacao:
		FErase(cArqTemp)
	EndIf
	//-- Fecha Query:
	(cAliasQry)->(DbCloseArea())
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TIBR030Imp ³ Autor ³V.RASPA                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Realiza o calculo dos impostos do orcamento                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function TIBR030Imp(cNumOrc)
Local nItem     := 0
Local nQtdPeso  := 0
Local nValMerc  := 0
Local nPrcLista := 0
Local nAcresFin := 0
Local nDesconto := 0
Local cTEs      := ''
Local aRet      := {}
Local aArea     := GetArea()
Local aAreaSA1  := SA1->(GetArea())


SCJ->(DbSetOrder(1)) //--CJ_FILIAL+CJ_NUM+CJ_CLIENTE+CJ_LOJA
SCJ->(DbSeek(xFilial('SCJ')+cNumOrc))

SA1->(DbSetOrder(1)) //--A1_FILIAL+A1_COD+A1_LOJA
SA1->(DbSeek(xFilial('SA1')+If(Empty(SCJ->CJ_CLIENT) .And. Empty(SCJ->CJ_LOJAENT), SCJ->(CJ_CLIENTE+CJ_LOJA), SCJ->(CJ_CLIENT+CJ_LOJAENT))))

SE4->(DbSetOrder(1)) //--E4_FILIAL+E4_CODIGO
SE4->(DbSeek(xFilial('SE4')+SCJ->CJ_CONDPAG))


MaFisSave()
MaFisEnd()
MaFisIni(If(Empty(SCJ->CJ_CLIENT), SCJ->CJ_CLIENTE, SCJ->CJ_CLIENT),;		// 1-Codigo Cliente/Fornecedor
			If(Empty(SCJ->CJ_LOJAENT), SCJ->CJ_LOJA, SCJ->CJ_LOJAENT),;	// 2-Loja do Cliente/Fornecedor
			"C",;															// 3-C:Cliente , F:Fornecedor
			"N",;															// 4-Tipo da NF
			SA1->A1_TIPO,;													// 5-Tipo do Cliente/Fornecedor
			NIL,;
			NIL,;
			NIL,;
			NIL,;
			"MATA461",;
			NIL,;
			NIL,;
			"")


SCK->(DbSetOrder(1)) //--CK_FILIAL+CK_NUM+CK_ITEM+CK_PRODUTO
SCK->(DbSeek(xFilial('SCK')+cNumOrc))
While !SCK->(Eof()) .And. SCK->(CK_FILIAL+CK_NUM) == xFilial('SCK')+cNumOrc
	nItem++

	nValMerc  := SCK->CK_VALOR
	If SCK->CK_PRUNIT == 0
		nPrcLista := A410Arred(nValMerc / SCK->CK_QTDVEN, 'CK_PRCVEN')
	Else
		nPrcLista := SCK->CK_PRUNIT
	EndIf


	nAcresFin := A410Arred((SCK->CK_PRCVEN*SE4->E4_ACRSFIN)/100, 'D2_PRCVEN')
	nValMerc  += A410Arred(nAcresFin*SCK->CK_QTDVEN, 'D2_TOTAL')
	nDesconto := A410Arred(nPrcLista*SCK->CK_QTDVEN, 'D2_DESCON') - nValMerc
	nDesconto := If(nDesconto == 0, SCK->CK_VALDESC, nDesconto)
	nDesconto := Max(0,nDesconto)
	nPrcLista += nAcresFin
	nValMerc  += nDesconto

	// ------------------------------------
	// AGREGA OS ITENS PARA A FUNCAO FISCAL
	// ------------------------------------
	MaFisAdd(	SCK->CK_PRODUTO,;  	// 1-Codigo do Produto ( Obrigatorio )
				SCK->CK_TES,;	   	// 2-Codigo do TES ( Opcional )
				SCK->CK_QTDVEN,;  	// 3-Quantidade ( Obrigatorio )
				nPrcLista,;		  	// 4-Preco Unitario ( Obrigatorio )
				nDesconto,;  		// 5-Valor do Desconto ( Opcional )
				"",;	   			// 6-Numero da NF Original ( Devolucao/Benef )
				"",;				// 7-Serie da NF Original ( Devolucao/Benef )
				0,;					// 8-RecNo da NF Original no arq SD1/SD2
				0,;					// 9-Valor do Frete do Item ( Opcional )
				0,;					// 10-Valor da Despesa do item ( Opcional )
				0,;					// 11-Valor do Seguro do item ( Opcional )
				0,;					// 12-Valor do Frete Autonomo ( Opcional )
				nValMerc,;			// 13-Valor da Mercadoria ( Obrigatorio )
				0)					// 14-Valor da Embalagem ( Opiconal )


	// ------------------------------------
	// CALCULO DO ISS
	// ------------------------------------
	SF4->(dbSetOrder(1)) //--F4_FILIAL+F4_CODIGO
	If Empty(SCK->CK_TES)
		cTES := A415TesPad()
		SF4->(DbSeek(xFilial('SF4')+cTES))
	Else
		SF4->(DbSeek(xFilial('SF4')+SCK->CK_TES))
	EndIf

	If SA1->A1_INCISS == "N"
		If SF4->F4_ISS=="S"
			nPrcLista := a410Arred(nPrcLista/(1-(MaAliqISS(nItem)/100)), 'D2_PRCVEN')
			nValMerc  := a410Arred(nValMerc/(1-(MaAliqISS(nItem)/100)), 'D2_PRCVEN')
			MaFisAlt('IT_PRCUNI', nPrcLista, nItem)
			MaFisAlt('IT_VALMERC', nValMerc, nItem)
		EndIf
	EndIf

	// ------------------------------------
	// VERIFICA O PESO P/ CALCULO DO FRETE
	// ------------------------------------
	SB1->(DbSetOrder(1)) //--B1_FILIAL+B1_COD
	SB1->(DbSeek(xFilial('SB1')+SCK->CK_PRODUTO))
	nQtdPeso := SCK->CK_QTDVEN * SB1->B1_PESO

	MaFisAlt("IT_PESO", nQtdPeso, nItem)
	MaFisAlt("IT_PRCUNI", nPrcLista, nItem)
	MaFisAlt("IT_VALMERC", nValMerc, nItem)

	SCK->(DbSkip())
End

// ------------------------------------------
// INDICA OS VALORES DO CABECALHO
// ------------------------------------------
MaFisAlt("NF_FRETE", SCJ->CJ_FRETE)
MaFisAlt("NF_SEGURO", SCJ->CJ_SEGURO)
MaFisAlt("NF_AUTONOMO", SCJ->CJ_FRETAUT)
MaFisAlt("NF_DESPESA", SCJ->CJ_DESPESA)
MaFisAlt("NF_DESCONTO", MaFisRet(,"NF_DESCONTO")+MaFisRet(,"NF_VALMERC")*SCJ->CJ_PDESCAB/100)
MaFisAlt("NF_DESCONTO", MaFisRet(,"NF_DESCONTO")+SCJ->CJ_DESCONT)
MaFisWrite(1)


aRet := MaFisRet(,"NF_IMPOSTOS")
Return(aRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ChkPerGrv ³ Autor ³V.RASPA                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Checa permissao de gravacao na pasta indicada para geracao  ³±±
±±³          ³do relatorio                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ChkPerGrv(cPath)
Local cFileTmp := CriaTrab(NIL, .F.)
Local nHdlTmp  := 0
Local lRet     := .F.

cPath   := AllTrim(cPath)
nHdlTmp := MSFCreate(cPath + If(Right(cPath, 1) <> '\', '\', '') + cFileTmp + '.TMP', 0)
If nHdlTmp <= 0
	lRet := .F.
Else
	lRet := .T.
	FClose(nHdlTmp)
	FErase(cPath + If(Right(cPath, 1) <> '\', '\', '') + cFileTmp + '.TMP')
EndIf

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³FUNCAO    ³AjustaSX1 ³AUTOR  ³Totvs ibirapuera                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³ Cria perguntas da rotina                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AjustSX1(cPerg)
Local aHelp := {}

aHelp := {'Informe codigo inicial do Orçamento'}
PutSx1(cPerg, '01', 'Orçamento Venda De ?' , '', '', 'MV_CH1', 'C', TamSX3('CJ_NUM')[1], 0, 0,;
		'G', '', '', '', '', 'MV_PAR01', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe codigo final do Orçamento'}
PutSx1(cPerg, '02', 'Orçamento Venda Ate?' , '', '', 'MV_CH2', 'C', TamSX3('CJ_NUM')[1], 0, 0,;
		'G', '', '', '', '', 'MV_PAR02', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe data inicial de emissao dos orça', 'mentos de venda.'}
PutSx1(cPerg, '03', 'Emissão De?' , '', '', 'MV_CH3', 'D', 8, 0, 0,;
		'G', '', '', '', '', 'MV_PAR03', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp,{}, {})

aHelp := {'Informe a data final de emissao dos orça', 'mentos de venda.'}
PutSx1(cPerg, '04', 'Emissão Até?' , '', '', 'MV_CH4', 'D', 8, 0, 0,;
		'G', '', '', '', '', 'MV_PAR04', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe codigo inicial do cliente'}
PutSx1(cPerg, '05', 'Cliente De ?', '', '', 'MV_CH5', 'C', TamSX3('A1_COD')[1], 0, 0,;
		'G', '', 'SA1', '', '', 'MV_PAR05', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe a loja inicial do cliente'}
PutSx1(cPerg, '06', 'Loja De ?', '', '', 'MV_CH6', 'C', TamSX3('A1_LOJA')[1], 0, 0,;
		'G', '', '', '', '', 'MV_PAR06', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe codigo final do cliente'}
PutSx1(cPerg, '07', 'Cliente Ate ?', '', '', 'MV_CH7', 'C', TamSX3('A1_COD')[1], 0, 0,;
		'G','', 'SA1', '', '', 'MV_PAR07', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe a loja final do cliente'}
PutSx1(cPerg, '08', 'Loja Ate ?', '', '', 'MV_CH8', 'C', TamSX3('A1_LOJA')[1], 0, 0,;
		'G', '', '', '', '', 'MV_PAR08', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe o destino do relatorio'}
PutSx1(cPerg, '09', 'Destino do Relatorio', '', '', 'MV_CH9', 'N', 1, 0, 0, 'C', '', '', '', '', 'MV_PAR09',;
		'Impressora', '', '', '', 'Salvar em Disco', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe o formato do documento, somente' , 'se for salvar em disco'}
PutSx1(cPerg, '10', 'Salvar Como', '', '', 'MV_CHA','N', 1, 0, 0, 'C', '', '', '', '', 'MV_PAR10',;
		'PDF', 'PDF', 'PDF', '', 'DOC', 'DOC', 'DOC', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe a versao do MS-Word'}
PutSx1(cPerg, '11', 'Versao MS-Word', '', '', 'MV_CHB','N', 1, 0, 0, 'C', '', '', '', '', 'MV_PAR11',;
		'Word 97/2003', '', '', '', 'Word 2010/2013', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

Return
