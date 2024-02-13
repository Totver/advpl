#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'MSOLE.CH'

Static cRootPath   := AllTrim(GetPvProfString(GetEnvServer(), 'RootPath', 'ERROR', GetADV97()) + If(Right(AllTrim(GetPvProfString(GetEnvServer(), 'RootPath', 'ERROR', GetADV97())), 1) == '\', '', '\'))
Static cStartPath  := AllTrim(GetPvProfString(GetEnvServer(), 'StartPath', 'ERROR', GetADV97()) + If(Right(AllTrim(GetPvProfString(GetEnvServer(), 'StartPath', 'ERROR', GetADV97())), 1) == '\', '', '\'))
Static cPathFisico := Left(cRootPath, Len(cRootPath) - 1) + If(Left(cStartPath, 1) <> '\', '\', '') + cStartPath

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³PROGRAMA  ³TIBR020   ³Autor  ³Totvs Ibirapuera                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³Impressao grafica do pedido de vendas                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TIBR020()
Local lOk        := .F.
Local aSays      := {}
Local aButtons   := {}
Local aKeySX1    := {}
Local cPerg      := 'TIBR020'

//-- Ajusta Dicionario de Dados:
AjustSX1(cPerg)
Pergunte(cPerg, .F.,,,, .F.)

//-- Trata a chamada do relatorio a partir
//-- da rotina de manutencao de Orcamentos:
If IsInCallStack('MATA410')
	aKeySX1 := {	{cPerg, '01', SC5->C5_NUM}				, {cPerg, '02', SC5->C5_NUM},;
					{cPerg, '03', DtoC(SC5->C5_EMISSAO)}	, {cPerg, '04', DtoC(SC5->C5_EMISSAO)},;
					{cPerg, '05', SC5->C5_CLIENTE} 			, {cPerg, '06', SC5->C5_LOJACLI},;
					{cPerg, '07', SC5->C5_CLIENTE} 			, {cPerg, '08', SC5->C5_LOJACLI},;
					{cPerg, '09', SC5->C5_VEND1}			, {cPerg, '10', SC5->C5_VEND1} }

	//-- Atribui os valores do Orcamento selecionado
	//-- aos parametros do relatorio:
	HS_PosSX1(aKeySX1)
	MV_PAR01 := SC5->C5_NUM
	MV_PAR02 := SC5->C5_NUM
	MV_PAR03 := SC5->C5_EMISSAO
	MV_PAR04 := SC5->C5_EMISSAO
	MV_PAR05 := SC5->C5_CLIENTE
	MV_PAR06 := SC5->C5_LOJACLI
	MV_PAR07 := SC5->C5_CLIENTE
	MV_PAR08 := SC5->C5_LOJACLI
	MV_PAR09 := SC5->C5_VEND1
	MV_PAR10 := SC5->C5_VEND1
EndIf

// -----------------------------------------------------
// Dialogo principal para parametrizacao
// -----------------------------------------------------
AAdd(aSays, 'Este programa tem por objetivo realizar a impressao do Pedido de venda ')
AAdd(aSays, 'utilizando a integracao com o Microsoft Word. O modelo para impressão deverá')
AAdd(aSays, 'estar disponível na pasta: ' + cStartPath + 'MODELOS\')
AAdd(aButtons, {5, .T., {|| Pergunte(cPerg,.T.,,,,.F.)}})
AAdd(aButtons, {1, .T., {|o| lOk := .T.,o:oWnd:End()}})
AAdd(aButtons, {2, .T., {|o| o:oWnd:End()}})

FormBatch('Impressão de Pedidos de Venda', aSays, aButtons,,, 650)

If lOk
	Processa({|lEnd| TIBR020Prc(@lEnd)}, 'Aguarde...', 'Realizando a impressao do documento...', .T.)
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TIBR020Prc ³ Autor ³V.RASPA                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Realiza a impressao do Pedido de Venda                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function TIBR020Prc(lEnd)
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
Local aTpFrete   := {}
Local oWord      := NIL
Local lContinua  := .T.

// --------------------------------------------
// TRATA A VERSAO DO MS WORD
// --------------------------------------------
If MV_PAR13 == 1
	cArqModel := cPathFisico + 'MODELOS\TIBR020.dot'
	//-- Se a versao do Ms Word for a 97/2003 nao permite
	//-- a saida do relatorio em PDF
	If MV_PAR12 == 1
		Aviso('ATENÇÃO', 'Não é possível realizar a geração do documento no formato "PDF" para versao 97/2003 do Microsoft Word. O formato do documento será reajustado para "DOC"', {'OK'}, 2)
		MV_PAR12 := 2
	EndIf
Else
	cArqModel   := cPathFisico + 'MODELOS\TIBR020.dotm'
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
	If MV_PAR11 == 2
		cExtension := If(MV_PAR12 == 1, '*.PDF', If(MV_PAR13 == 1, '*.DOC', '*.DOCX'))
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
	cArqTemp := AllTrim(GetTempPath()) + If(Right(AllTrim(GetTempPath()), 1) == '\', '', '\') + GetNextAlias() + If(MV_PAR13 == 1, '.dot', '.dotm')
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
	cQuery := "SELECT SC5.C5_NUM, SC5.C5_CLIENTE, SC5.C5_LOJACLI, SC5.C5_EMISSAO, SC5.C5_CONDPAG, SC5.C5_CLIENT, SC5.C5_LOJAENT, "
	cQuery += "       SC5.C5_TPFRETE, SC5.C5_FRETE, SC5.C5_MENNOTA, SC5.C5_MENPAD, SC5.C5_MOEDA, "
	cQuery += "       SA1.A1_NOME, SA1.A1_CONTATO, SA1.A1_CGC, SA1.A1_INSCR, SA1.A1_END, SA1.A1_BAIRRO, SA1.A1_MUN, SA1.A1_CEP, SA1.A1_EST, "
	cQuery += "       SA1.A1_DDD, SA1.A1_ENDENT, SA1.A1_ENDCOB, SA1.A1_BAIRROC, SA1.A1_BAIRROE, SA1.A1_TEL, SA1.A1_FAX "
	cQuery += "   FROM " + RetSQLTab('SC5')
	cQuery += "   JOIN " + RetSQLTab('SA1')
	cQuery += "     ON SA1.A1_FILIAL = '" + xFilial("SA1") + "' "
	cQuery += "    AND SA1.A1_COD = SC5.C5_CLIENTE "
	cQuery += "    AND SA1.A1_LOJA = SC5.C5_LOJACLI "
	cQuery += "    AND SA1.D_E_L_E_T_ = ' ' "
	cQuery += "  WHERE SC5.C5_FILIAL = '" + xFilial("SC5") + "' "
	cQuery += "    AND SC5.C5_NUM BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
	cQuery += "    AND SC5.C5_EMISSAO BETWEEN '" + DtoS(MV_PAR03) + "' AND '" + DtoS(MV_PAR04) + "' "
	cQuery += "    AND SC5.C5_CLIENTE BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR07 + "' "
	cQuery += "    AND SC5.C5_LOJACLI BETWEEN '" + MV_PAR06 + "' AND '" + MV_PAR08 + "' "
	cQuery += "    AND SC5.C5_VEND1   BETWEEN '" + MV_PAR09 + "' AND '" + MV_PAR10 + "' "
	cQuery += "    AND SC5.D_E_L_E_T_ = ' '"
	cQuery += "  ORDER BY SC5.C5_NUM "

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
			cMVMoeda   := 'MV_SIMB' + AllTrim(Str((cAliasQry)->C5_MOEDA ,2))
			cMoeda     := AllTrim(GetMV(cMVMoeda))

			//-- Arquivo que sera gerado:
			cNewFile := cPathDest + If(Right(cPathDest, 1) == '\', '', '\') + (cAliasQry)->C5_NUM + '_' + DtoS(dDataBase) + '_' + StrTran(Time(), ':', '') + '_TIBR020' + StrTran(cExtension, '*', '')

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
				OLE_SetDocumentVar(oWord, 'cNumPed'			, (cAliasQry)->C5_NUM)
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
				// TRATAMENTO DOS ITENS DO PEDIDO
				// ---------------------------------------------
				nItem   := 0
				nValTot := 0
				nValImp := 0
				cObserv := ''

				SC6->(DbSetOrder(1)) //--C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
				SC6->(DbSeek(xFilial('SC6')+(cAliasQry)->C5_NUM))
				While !SC6->(Eof()) .And. SC6->(C6_FILIAL+C6_NUM) == xFilial('SC6')+(cAliasQry)->C5_NUM
					nItem++
					OLE_SetDocumentVar(oWord, 'cItem' + AllTrim(Str(nItem))		, SC6->C6_ITEM)
					OLE_SetDocumentVar(oWord, 'cCodPro' + AllTrim(Str(nItem))	, AllTrim(SC6->C6_PRODUTO))
					OLE_SetDocumentVar(oWord, 'cDescPro' + AllTrim(Str(nItem))	, AllTrim(SC6->C6_DESCRI))
					OLE_SetDocumentVar(oWord, 'cUM' + AllTrim(Str(nItem))		, SC6->C6_UM)
					OLE_SetDocumentVar(oWord, 'dDtEntr' + AllTrim(Str(nItem))	, DtoC(SC6->C6_ENTREG))
					OLE_SetDocumentVar(oWord, 'nQtde' + AllTrim(Str(nItem))		, Transform(SC6->C6_QTDVEN, PesqPict('SC6', 'C6_QTDVEN')))
					OLE_SetDocumentVar(oWord, 'nValUnit' + AllTrim(Str(nItem))	, Transform(SC6->C6_PRCVEN, PesqPict('SC6', 'C6_PRCVEN')))
					OLE_SetDocumentVar(oWord, 'nTotItem' + AllTrim(Str(nItem))	, Transform(SC6->C6_VALOR, PesqPict('SC6', 'C6_VALOR')))

					nValTot += SC6->C6_VALOR
					SC6->(DbSkip())
				End

				OLE_SetDocumentVar(oWord, 'nItens', AllTrim(Str(nItem)))
				OLE_ExecuteMacro(oWord, "mcrItens")

				// --------------------------------------------------
				// TRATA TOTAIS, CONDICAO DE PAGAMENTO E OBSERVACOES
				// --------------------------------------------------
				OLE_SetDocumentVar(oWord, 'nValTot'	, Transform(nValTot, PesqPict('SC6', 'C6_VALOR')))

				//-- Valor dos Impostos:
				aImpostos := TIBR020Imp((cAliasQry)->C5_NUM)
				AEval(aImpostos, {|e| If(AllTrim(e[1]) == 'IPI', nValImp += e[5], NIL)})
				OLE_SetDocumentVar(oWord, 'nValImp', Transform(nValImp, PesqPict('SC6', 'C6_VALOR')))

				//-- Valor do Frete:
				aTpFrete := RetSX3Box(Posicione('SX3', 2, 'C5_TPFRETE', 'X3CBox()' ),,, 1)
				If AScan(aTpFrete, {|x| x[2] == (cAliasQry)->C5_TPFRETE}) <> 0
					OLE_SetDocumentVar(oWord, 'cTpFrete', aTpFrete[AScan(aTpFrete, {|x| x[2] == (cAliasQry)->C5_TPFRETE}), 3])
				Else
					OLE_SetDocumentVar(oWord, 'cTpFrete', 'NAO INFORMADO')
				EndIf
				OLE_SetDocumentVar(oWord, 'nValFrete', Transform((cAliasQry)->C5_FRETE, PesqPict('SC5', 'C5_FRETE')))				

				//-- Totaliza o Orcamento:
				OLE_SetDocumentVar(oWord, 'nTotal', Transform(nValTot + nValImp + If((cAliasQry)->C5_TPFRETE == 'F', (cAliasQry)->C5_FRETE, 0), PesqPict('SC6', 'C6_VALOR')))

				//-- Condicao de Pagamento
				SE4->(DbSetOrder(1))
				SE4->(DbSeek(xFilial('SE4')+(cAliasQry)->C5_CONDPAG))
				OLE_SetDocumentVar(oWord, 'cCondPag'	, AllTrim(SE4->E4_DESCRI))

				//-- Observacoes
				If !Empty(SC5->C5_MENNOTA)
					cObserv += AllTrim((cAliasQry)->C5_MENNOTA) + Chr(10) + Chr(13)
				EndIf
				If !Empty((cAliasQry)->C5_MENPAD)
					cObserv += AllTrim((cAliasQry)->(Formula(C5_MENPAD)))
				EndIf

				OLE_SetDocumentVar(oWord, 'cObs'	, AllTrim(cObserv))

				//-- Atualiza os campos
				OLE_UpDateFields(oWord)

				//-- Determina a saida do relatorio:
				If MV_PAR11 == 1
					OLE_PrintFile(oWord, cNewFile,,, 1)
					Sleep(1000)
				Else
					OLE_SaveAsFile(oWord, cNewFile,,,, If(MV_PAR12 == 1, '17', NIL)) //--Parametro '17' salva em pdf
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
±±³Fun‡„o    ³TIBR020Imp ³ Autor ³V.RASPA                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Realiza o calculo dos impostos do pedido de venda           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function TIBR020Imp(cNumPed)
Local nItem     := 0
Local nQtdPeso  := 0
Local nValMerc  := 0
Local nPrcLista := 0
Local nAcresFin := 0
Local nDesconto := 0
Local aRet      := {}
Local aArea     := GetArea()
Local aAreaSA1  := SA1->(GetArea())


SC5->(DbSetOrder(1)) //--C5_FILIAL+C5_NUM
SC5->(DbSeek(xFilial('SC5')+cNumPed))

SA1->(DbSetOrder(1)) //--A1_FILIAL+A1_COD+A1_LOJA
SA1->(DbSeek(xFilial('SA1')+If(Empty(SC5->C5_CLIENT) .And. Empty(SC5->C5_LOJAENT), SC5->(C5_CLIENT+C5_LOJAENT), SC5->(C5_CLIENTE+C5_LOJACLI))))

SE4->(DbSetOrder(1)) //--E4_FILIAL+E4_CODIGO
SE4->(DbSeek(xFilial('SE4')+SC5->C5_CONDPAG))

MaFisSave()
MaFisEnd()
MaFisIni(If(Empty(SC5->C5_CLIENT), SC5->C5_CLIENTE, SC5->C5_CLIENT),;		// 1-Codigo Cliente/Fornecedor
			If(Empty(SC5->C5_LOJAENT), SC5->C5_LOJACLI, SC5->C5_LOJAENT),;	// 2-Loja do Cliente/Fornecedor
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

SC6->(DbSetOrder(1)) //--C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
SC6->(DbSeek(xFilial('SC6')+cNumPed))
While !SC6->(Eof()) .And. SC6->(C6_FILIAL+C6_NUM) == xFilial('SC6')+cNumPed
	nItem++

	nValMerc  := SC6->C6_VALOR
	If SC6->C6_PRUNIT == 0
		nPrcLista := A410Arred(nValMerc / SC6->C6_QTDVEN, 'C6_PRCVEN')
	Else
		nPrcLista := SC6->C6_PRUNIT
	EndIf


	nAcresFin := A410Arred((SC6->C6_PRCVEN*SE4->E4_ACRSFIN)/100, 'D2_PRCVEN')
	nValMerc  += A410Arred(nAcresFin*SC6->C6_QTDVEN, 'D2_TOTAL')
	nDesconto := A410Arred(nPrcLista*SC6->C6_QTDVEN, 'D2_DESCON') - nValMerc
	nDesconto := If(nDesconto == 0, SC6->C6_VALDESC, nDesconto)
	nDesconto := Max(0,nDesconto)
	nPrcLista += nAcresFin
	nValMerc  += nDesconto

	// ------------------------------------
	// AGREGA OS ITENS PARA A FUNCAO FISCAL
	// ------------------------------------
	MaFisAdd(	SC6->C6_PRODUTO,;  	// 1-Codigo do Produto ( Obrigatorio )
				SC6->C6_TES,;	   	// 2-Codigo do TES ( Opcional )
				SC6->C6_QTDVEN,;  	// 3-Quantidade ( Obrigatorio )
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
	SF4->(DbSeek(xFilial('SF4')+SC6->C6_TES))
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
	SB1->(DbSeek(xFilial('SB1')+SC6->C6_PRODUTO))
	nQtdPeso := SC6->C6_QTDVEN * SB1->B1_PESO

	MaFisAlt("IT_PESO", nQtdPeso, nItem)
	MaFisAlt("IT_PRCUNI", nPrcLista, nItem)
	MaFisAlt("IT_VALMERC", nValMerc, nItem)

	SC6->(DbSkip())
End

// ------------------------------------------
// INDICA OS VALORES DO CABECALHO
// ------------------------------------------
MaFisAlt("NF_FRETE", SC5->C5_FRETE)
MaFisAlt("NF_SEGURO", SC5->C5_SEGURO)
MaFisAlt("NF_AUTONOMO", SC5->C5_FRETAUT)
MaFisAlt("NF_DESPESA", SC5->C5_DESPESA)
MaFisAlt("NF_DESCONTO", MaFisRet(,"NF_DESCONTO")+MaFisRet(,"NF_VALMERC")*SC5->C5_PDESCAB/100)
MaFisAlt("NF_DESCONTO", MaFisRet(,"NF_DESCONTO")+SC5->C5_DESCONT)
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

aHelp := {'Informe codigo inicial do Pedido'}
PutSx1(cPerg, '01', 'Pedido Venda De ?' , '', '', 'MV_CH1', 'C', TamSX3('C5_NUM')[1], 0, 0,;
		'G', '', '', '', '', 'MV_PAR01', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe codigo final do Pedido'}
PutSx1(cPerg, '02', 'Pedido Venda Ate?' , '', '', 'MV_CH2', 'C', TamSX3('C5_NUM')[1], 0, 0,;
		'G', '', '', '', '', 'MV_PAR02', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe data inicial de emissao dos pedi_', 'dos de venda.'}
PutSx1(cPerg, '03', 'Emissão De?' , '', '', 'MV_CH3', 'D', 8, 0, 0,;
		'G', '', '', '', '', 'MV_PAR03', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp,{}, {})

aHelp := {'Informe a data final de emissao dos pedi_', 'dos de venda.'}
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

aHelp := {'Informe codigo inicial do vendedor'}
PutSx1(cPerg, '09', 'Vendedor De ?' , '', '', 'MV_CH9', 'C', TamSX3('A3_COD')[1], 0, 0,;
		'G', '', 'SA3', '', '', 'MV_PAR09', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe o codigo final do vendedor'}
PutSx1(cPerg, '10', 'Vendedor Ate ?', '', '', 'MV_CHA', 'C', TamSX3('A3_COD')[1], 0, 0,;
		'G', '', 'SA3', '', '', 'MV_PAR10', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe o destino do relatorio'}
PutSx1(cPerg, '11', 'Destino do Relatorio', '', '', 'MV_CHA', 'N', 1, 0, 0, 'C', '', '', '', '', 'MV_PAR11',;
		'Impressora', '', '', '', 'Salvar em Disco', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe o formato do documento, somente' , 'se for salvar em disco'}
PutSx1(cPerg, '12', 'Salvar Como', '', '', 'MV_CHB','N', 1, 0, 0, 'C', '', '', '', '', 'MV_PAR12',;
		'PDF', 'PDF', 'PDF', '', 'DOC', 'DOC', 'DOC', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

aHelp := {'Informe a versao do MS-Word'}
PutSx1(cPerg, '13', 'Versao MS-Word', '', '', 'MV_CHC','N', 1, 0, 0, 'C', '', '', '', '', 'MV_PAR13',;
		'Word 97/2003', '', '', '', 'Word 2010/2013', '', '', '', '', '', '', '', '', '', '', '', aHelp, {}, {})

Return
