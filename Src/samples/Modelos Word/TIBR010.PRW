#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'MSOLE.CH'

Static cRootPath   := AllTrim(GetPvProfString(GetEnvServer(), 'RootPath', 'ERROR', GetADV97()) + If(Right(AllTrim(GetPvProfString(GetEnvServer(), 'RootPath', 'ERROR', GetADV97())), 1) == '\', '', '\'))
Static cStartPath  := AllTrim(GetPvProfString(GetEnvServer(), 'StartPath', 'ERROR', GetADV97()) + If(Right(AllTrim(GetPvProfString(GetEnvServer(), 'StartPath', 'ERROR', GetADV97())), 1) == '\', '', '\'))
Static cPathFisico := Left(cRootPath, Len(cRootPath) - 1) + If(Left(cStartPath, 1) <> '\', '\', '') + cStartPath

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³PROGRAMA  ³TIBR010   ³Autor  ³Totvs Ibirapuera                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³Impressao grafica do orcamento de vendas                    ³±±
±±³          ³Associar o programa TIBR010 ao parametro MV_PCOMPRA         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TIBR010()
Local lOk        := .F.
Local aSays      := {}
Local aButtons   := {}
Local aKeySX1    := {}
Local cPerg      := 'TIBR010'

//-- Ajusta Dicionario de Dados:
AjustSX1(cPerg)
Pergunte(cPerg, .F.,,,, .F.)

//-- Trata a chamada do relatorio a partir
//-- da rotina de manutencao de Orcamentos:
If IsInCallStack('MATA121')
	aKeySX1 := {	{cPerg, '01', SC7->C7_NUM}				, {cPerg, '02', SC7->C7_NUM},;
					{cPerg, '03', DtoC(SC7->C7_EMISSAO)}	, {cPerg, '04', DtoC(SC7->C7_EMISSAO)},;
					{cPerg, '05', SC7->C7_FORNECE} 			, {cPerg, '06', SC7->C7_LOJA},;
					{cPerg, '07', SC7->C7_FORNECE} 			, {cPerg, '08', SC7->C7_LOJA} }

	//-- Atribui os valores do Orcamento selecionado
	//-- aos parametros do relatorio:
	HS_PosSX1(aKeySX1)
	MV_PAR01 := SC7->C7_NUM
	MV_PAR02 := SC7->C7_NUM
	MV_PAR03 := SC7->C7_EMISSAO
	MV_PAR04 := SC7->C7_EMISSAO
	MV_PAR05 := SC7->C7_FORNECE
	MV_PAR06 := SC7->C7_LOJA
	MV_PAR07 := SC7->C7_FORNECE
	MV_PAR08 := SC7->C7_LOJA
EndIf

// -----------------------------------------------------
// Dialogo principal para parametrizacao
// -----------------------------------------------------
AAdd(aSays, 'Este programa tem por objetivo realizar a impressao do Pedido de Compra ')
AAdd(aSays, 'utilizando a integracao com o Microsoft Word. O modelo para impressão deverá')
AAdd(aSays, 'estar disponível na pasta: ' + cStartPath + 'MODELOS\')
AAdd(aButtons, {5, .T., {|| Pergunte(cPerg,.T.,,,,.F.)}})
AAdd(aButtons, {1, .T., {|o| lOk := .T.,o:oWnd:End()}})
AAdd(aButtons, {2, .T., {|o| o:oWnd:End()}})

FormBatch('Impressão de Pedido de Compra', aSays, aButtons,,, 650)

If lOk
	Processa({|lEnd| TIBR010Prc(@lEnd)}, 'Aguarde...', 'Realizando a impressao do documento...', .T.)
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TIBR010Prc ³ Autor ³V.RASPA                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Realiza a impressao do Pedido de Compra                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function TIBR010Prc(lEnd)
Local cArqModel  := ''
Local cExtension := ''
Local cPathDest  := ''
Local cArqTemp   := ''
Local cQuery     := ''
Local cAliasQry  := ''
Local cNewFile   := ''
Local nItem      := 0
Local nValTot    := 0
Local nValIPI    := 0
Local cObserv    := ''
Local cMVMoeda   := ''
Local cMoeda     := ''
Local nPos       := 0
Local oWord      := NIL
Local lContinua  := .T.

// --------------------------------------------
// TRATA A VERSAO DO MS WORD
// --------------------------------------------
If MV_PAR11 == 1
	cArqModel := cPathFisico + 'MODELOS\TIBR010.dot'
	//-- Se a versao do Ms Word for a 97/2003 nao permite
	//-- a saida do relatorio em PDF
	If MV_PAR10 == 1
		Aviso('ATENÇÃO', 'Não é possível realizar a geração do documento no formato "PDF" para versao 97/2003 do Microsoft Word. O formato do documento será reajustado para "DOC"', {'OK'}, 2)
		MV_PAR10 := 2
	EndIf
Else
	cArqModel   := cPathFisico + 'MODELOS\TIBR010.dotm'
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
	cQuery := "SELECT SC7.C7_NUM, SC7.C7_FORNECE, SC7.C7_LOJA, SC7.C7_EMISSAO, SC7.C7_COND, SC7.C7_MOEDA, "
	cQuery += "       SA2.A2_NOME, SA2.A2_CONTATO, SA2.A2_CGC, SA2.A2_INSCR, SA2.A2_END, SA2.A2_BAIRRO, "
	cQuery += "       SA2.A2_MUN, SA2.A2_CEP, SA2.A2_EST, SA2.A2_DDD, SA2.A2_TEL, SA2.A2_FAX "
	cQuery += "   FROM " + RetSQLTab('SC7')
	cQuery += "   JOIN " + RetSQLTab('SA2')
	cQuery += "     ON SA2.A2_FILIAL = '" + xFilial('SA2') + "' "
	cQuery += "    AND SA2.A2_COD = SC7.C7_FORNECE "
	cQuery += "    AND SA2.A2_LOJA = SC7.C7_LOJA "
	cQuery += "    AND SA2.D_E_L_E_T_ = ' ' "
	cQuery += "  WHERE SC7.C7_FILIAL = '" + xFilial("SC7") + "' "
	cQuery += "    AND SC7.C7_NUM BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
	cQuery += "    AND SC7.C7_EMISSAO BETWEEN '" + DtoS(MV_PAR03) + "' AND '" + DtoS(MV_PAR04) + "' "
	cQuery += "    AND SC7.C7_FORNECE BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR07 + "' "
	cQuery += "    AND SC7.C7_LOJA BETWEEN '" + MV_PAR06 + "' AND '" + MV_PAR08 + "' "
	cQuery += "    AND SC7.D_E_L_E_T_ = ' '"
	cQuery += "  GROUP BY SC7.C7_NUM, SC7.C7_FORNECE, SC7.C7_LOJA, SC7.C7_EMISSAO, SC7.C7_COND, SC7.C7_MOEDA, "
	cQuery += "        SA2.A2_NOME, SA2.A2_CONTATO, SA2.A2_CGC, SA2.A2_INSCR, SA2.A2_END, SA2.A2_BAIRRO, "
	cQuery += "        SA2.A2_MUN, SA2.A2_CEP, SA2.A2_EST, SA2.A2_DDD, SA2.A2_TEL, SA2.A2_FAX "
	cQuery += "  ORDER BY SC7.C7_NUM "

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
			cMVMoeda   := 'MV_SIMB' + AllTrim(Str((cAliasQry)->C7_MOEDA ,2))
			cMoeda     := AllTrim(GetMV(cMVMoeda))

			//-- Arquivo que sera gerado:
			cNewFile := cPathDest + If(Right(cPathDest, 1) == '\', '', '\') + (cAliasQry)->C7_NUM + '_' + DtoS(dDataBase) + '_' + StrTran(Time(), ':', '') + '_TIBR010' + StrTran(cExtension, '*', '')

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
				OLE_SetDocumentVar(oWord, 'cNumPed'			, (cAliasQry)->C7_NUM)
				OLE_SetDocumentVar(oWord, 'cEmissao'		, Right((cAliasQry)->C7_EMISSAO,2) + ' de ' + MesExtenso(Month(StoD((cAliasQry)->C7_EMISSAO))) + ' de ' + Left((cAliasQry)->C7_EMISSAO, 4))
				OLE_SetDocumentVar(oWord, 'cRazaoSocial'	, SM0->M0_NOMECOM)
				OLE_SetDocumentVar(oWord, 'cEndCob'			, AllTrim(SM0->M0_ENDCOB) + ' - ' + Alltrim(SM0->M0_BAIRCOB) + ' - ' + AllTrim(SM0->M0_CIDCOB) + ' - ' + SM0->M0_ESTCOB)
				OLE_SetDocumentVar(oWord, 'cEndEntr'		, AllTrim(SM0->M0_ENDENT) + ' - ' + Alltrim(SM0->M0_BAIRENT) + ' - ' + AllTrim(SM0->M0_CIDENT) + ' - ' + SM0->M0_ESTENT)
				OLE_SetDocumentVar(oWord, 'cCEP'			, Transform(SM0->M0_CEPCOB, "@R 99999-999"))
				OLE_SetDocumentVar(oWord, 'cFone'			, SM0->M0_TEL)
				OLE_SetDocumentVar(oWord, 'cCNPJ'			, Transform(SM0->M0_CGC, "@R 99.999.999/9999-99"))
				OLE_SetDocumentVar(oWord, 'cFornece'		, AllTrim((cAliasQry)->A2_NOME))
				OLE_SetDocumentVar(oWord, 'cEndereco'		, AllTrim((cAliasQry)->A2_END))
				OLE_SetDocumentVar(oWord, 'cBairro'			, AllTrim((cAliasQry)->A2_BAIRRO))
				OLE_SetDocumentVar(oWord, 'cCidade'			, AllTrim((cAliasQry)->A2_MUN))
				OLE_SetDocumentVar(oWord, 'cUF'				, AllTrim((cAliasQry)->A2_EST))
				OLE_SetDocumentVar(oWord, 'cCEP'			, Transform((cAliasQry)->A2_CEP, "@R 99999-999"))
				OLE_SetDocumentVar(oWord, 'cFone'			, (cAliasQry)->A2_TEL)
				OLE_SetDocumentVar(oWord, 'cCNPJ'			, Transform((cAliasQry)->A2_CGC, "@R 99.999.999/9999-99"))
				OLE_SetDocumentVar(oWord, 'cMoeda'			, cMoeda)

				// ---------------------------------------------
				// TRATAMENTO DOS ITENS DO PEDIDO
				// ---------------------------------------------
				nItem   := 0
				nValTot := 0
				nValImp := 0
				cObserv := ''

				SC7->(DbSetOrder(1)) //--C7_FILIAL+C7_NUM+C7_ITEM+C7_SEQUEN
				SC7->(DbSeek(xFilial('SC7')+(cAliasQry)->C7_NUM))
				While !SC7->(Eof()) .And. SC7->(C7_FILIAL+C7_NUM) == xFilial('SC7')+(cAliasQry)->C7_NUM
					nItem++
					OLE_SetDocumentVar(oWord, 'cItem' + AllTrim(Str(nItem))		, SC7->C7_ITEM)
					OLE_SetDocumentVar(oWord, 'cCodPro' + AllTrim(Str(nItem))	, AllTrim(SC7->C7_PRODUTO))
					OLE_SetDocumentVar(oWord, 'cDescPro' + AllTrim(Str(nItem))	, AllTrim(SC7->C7_DESCRI))
					OLE_SetDocumentVar(oWord, 'cUM' + AllTrim(Str(nItem))		, SC7->C7_UM)
					OLE_SetDocumentVar(oWord, 'dDtEntr' + AllTrim(Str(nItem))	, DtoC(SC7->C7_DATPRF))
					OLE_SetDocumentVar(oWord, 'nQtde' + AllTrim(Str(nItem))		, Transform(SC7->C7_QUANT, PesqPict('SC7', 'C7_QUANT')))
					OLE_SetDocumentVar(oWord, 'nValUnit' + AllTrim(Str(nItem))	, Transform(SC7->C7_PRECO, PesqPict('SC7', 'C7_PRECO')))
					OLE_SetDocumentVar(oWord, 'nTotItem' + AllTrim(Str(nItem))	, Transform(SC7->C7_TOTAL, PesqPict('SC7', 'C7_TOTAL')))


					nValTot += SC7->C7_TOTAL
					nValIPI += SC7->C7_VALIPI

					If !Empty(SC7->C7_OBS)
						cObserv += '[Item ' + SC7->C7_ITEM + '] ' + AllTrim(SC7->C7_OBS) + Chr(10) + Chr(13)
					EndIf

					SC7->(DbSkip())
				End

				OLE_SetDocumentVar(oWord, 'nItens', AllTrim(Str(nItem)))
				OLE_ExecuteMacro(oWord, "mcrItens")

				// --------------------------------------------------
				// TRATA TOTAIS, CONDICAO DE PAGAMENTO E OBSERVACOES
				// --------------------------------------------------
				OLE_SetDocumentVar(oWord, 'nValTot'	, Transform(nValTot, PesqPict('SC7', 'C7_TOTAL')))

				//-- Valor dos Impostos:
				OLE_SetDocumentVar(oWord, 'nValImp'	, Transform(nValIPI, PesqPict('SC7', 'C7_TOTAL')))

				//-- Totaliza o Orcamento:
				OLE_SetDocumentVar(oWord, 'nTotal'	, Transform(nValTot + nValIPI, PesqPict('SC7', 'C7_TOTAL')))

				//-- Condicao de Pagamento
				SE4->(DbSetOrder(1))
				SE4->(DbSeek(xFilial('SE4')+(cAliasQry)->C7_COND))
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

aHelp := {'Informe codigo inicial do Pedido'}
PutSx1(cPerg, '01', 'Pedido Compra De ?' , '', '', 'MV_CH1', 'C', TamSX3('C7_NUM')[1], 0, 0,;
		'G', '', 'SC7', '', '', 'MV_PAR01', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe codigo final do Pedido'}
PutSx1(cPerg, '02', 'Pedido Compra Ate?' , '', '', 'MV_CH2', 'C', TamSX3('C7_NUM')[1], 0, 0,;
		'G', '', 'SC7', '', '', 'MV_PAR02', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe data inicial de emissao dos pedi_', 'dos de compra.'}
PutSx1(cPerg, '03', 'Emissão De?' , '', '', 'MV_CH3', 'D', 8, 0, 0,;
		'G', '', '', '', '', 'MV_PAR03', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp,{}, {})

aHelp := {'Informe a data final de emissao dos pedi_', 'dos de compra'}
PutSx1(cPerg, '04', 'Emissão Até?' , '', '', 'MV_CH4', 'D', 8, 0, 0,;
		'G', '', '', '', '', 'MV_PAR04', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe codigo inicial do fornecedor'}
PutSx1(cPerg, '05', 'Fornecedor De ?', '', '', 'MV_CH5', 'C', TamSX3('A2_COD')[1], 0, 0,;
		'G', '', 'SA2', '', '', 'MV_PAR05', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe a loja inicial do', 'Fornecedor'}
PutSx1(cPerg, '06', 'Loja De ?', '', '', 'MV_CH6', 'C', TamSX3('A2_LOJA')[1], 0, 0,;
		'G', '', '', '', '', 'MV_PAR06', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe codigo final do fornecedor'}
PutSx1(cPerg, '07', 'Fornecedor Ate ?', '', '', 'MV_CH7', 'C', TamSX3('A2_COD')[1], 0, 0,;
		'G','', 'SA2', '', '', 'MV_PAR07', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe a loja final do fornecedor'}
PutSx1(cPerg, '08', 'Loja Ate ?', '', '', 'MV_CH8', 'C', TamSX3('A2_LOJA')[1], 0, 0,;
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
