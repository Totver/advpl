#Include "Protheus.Ch"

User Function MaLCache()
Return &("StaticCall(MATXFISU,MALOADCACHE)")

User Function MFsFound(cCampo,nItem)

__cCampo := cCampo
__nItem  := nItem
Return &("StaticCall(MATXFISU,MAFISFOUND,__cCampo,__nItem)")

User Function MFsSave()
Return &("StaticCall(MATXFISU,MaFisSave)")

User Function MFsRestore()
Return &("StaticCall(MATXFISU,MAFISRESTORE)")

User Function MaFisClear()
Return &("StaticCall(MATXFISU,MAFISCLEAR)")

User Function MFsEnd(lRodape)
__lRodape := lRodape
Return &("StaticCall(MATXFISU,MAFISEND,__lRodape)")

User Function MFsNFCab()
Return &("StaticCall(MATXFISU,MAFISNFCAB)")

User Function MFsIni(cCodCliFor,;	// 1-Codigo Cliente/Fornecedor
	cLoja,;			// 02-Loja do Cliente/Fornecedor
	cCliFor,;		// 03-C:Cliente , F:Fornecedor
	cTipoNF,;		// 04-Tipo da NF( "N","D","B","C","P","I" )
	cTpCliFor,;		// 05-Tipo do Cliente/Fornecedor
	aRelImp,;		// 06-Relacao de Impostos que suportados no arquivo
	cTpComp,;		// 07-Tipo de complemento
	lInsere,;		// 08-Permite Incluir Impostos no Rodape .T./.F.
	cAliasP,;		// 09-Alias do Cadastro de Produtos - ("SBI" P/ Front Loja)
	cRotina,;		// 10-Nome da rotina que esta utilizando a funcao
	cTipoDoc,;		// 11-Tipo de documento
	cEspecie,;		// 12-Especie do documento
    cCodProsp,;		// 13-Codigo e Loja do Prospect
    cGrpCliFor,;	// 14-Grupo Cliente
    cRecolheISS,;	// 15-Recolhe ISS
    cCliEnt,;   	// 16-Codigo do cliente de entrega na nota fiscal de saida
    cLojEnt,;   	// 17-Loja do cliente de entrega na nota fiscal de saida
    aTransp,;		// 18-Informacoes do transportador [01]-UF,[02]-TPTRANS
	lEmiteNF,;		// 19-Se esta emitindo nota fiscal ou cupom fiscal (Sigaloja)
	lCalcIPI,;      // 20-Define se calcula IPI (SIGALOJA)
	cPedido,;       // 21-Pedido de Venda
	cCliFat,;	    // 22-Cliente do faturamento ( cCodCliFor é passado como o cliente de entrega, pois é o considerado na maioria das funções fiscais, exceto ao gravar o clinte nas tabelas do livro)
	cLojCFat,;     // 23-Loja do cliente do faturamento
	nTotPed,;		// 24-Total do Pedido
	dDtEmiss,;		// 25-Data de emissão do documento inicialmente só é diferente de dDataBase nas notas de entrada (MATA103 e MATA910)
	cTpFrete)       // 26- Tipo de Frete informado no pedido

__cCodCliFor := cCodCliFor
__cLoja      := cLoja
__cCliFor    := cCliFor
__cTipoNF    := cTipoNF
__cTpCliFor  := cTpCliFor
__aRelImp    := aRelImp
__cTpComp    := cTpComp
__lInsere    := lInsere
__cAliasP    := cAliasP
__cRotina    := cRotina
__cTipoDoc   := cTipoDoc
__cEspecie   := cEspecie
__cCodProsp  := cCodProsp
__cGrpCliFor := cGrpCliFor
__cRecolheISS := cRecolheISS
__cCliEnt    := cCliEnt
__cLojEnt    := cLojEnt
__aTransp    := aTransp
__lEmiteNF   := lEmiteNF
__lCalcIPI   := lCalcIPI
__cPedido    := cPedido
__cCliFat    := cCliFat
__cLojCFat   := cLojCFat
__nTotPed    := nTotPed
__dDtEmiss   := dDtEmiss
__cTpFrete   := cTpFrete

Return &("StaticCall(MATXFISU,MAFISINI,__cCodCliFor,__cLoja,__cCliFor,__cTipoNF,__cTpCliFor,__aRelImp,__cTpComp,__lInsere,__cAliasP,__cRotina," +;
					 				  "__cTipoDoc,__cEspecie,__cCodProsp,__cGrpCliFor,__cRecolheISS,__cCliEnt,__cLojEnt,__aTransp,__lEmiteNF," +;
									  "__lCalcIPI,__cPedido,__cCliFat,__cLojCFat,__nTotPed,__dDtEmiss,__cTpFrete)")

User Function MFsIniLoad(nItem,aLoad,lEstorno)

__nItem    := nItem
__aLoad    := aLoad
__lEstorno := lEstorno

Return &("StaticCall(MATXFISU,MAFISINILOAD,__nItem,__aLoad,__lEstorno)")

User Function MFsLoad(cCampo,nValor,nItem)

__cCampo := cCampo
__nValor := nValor
__nItem  := nItem
Return &("StaticCall(MATXFISU,MAFISLOAD,__cCampo,__nValor,__nItem)")

User Function MFsAdd(cProduto,;   	// 1-Codigo do Produto ( Obrigatorio )
cTes,;	   	// 2-Codigo do TES ( Opcional )
nQtd,;	   	// 3-Quantidade ( Obrigatorio )
nPrcUnit,;  // 4 -Preco Unitario ( Obrigatorio )
nDesconto,; // 5 -Valor do Desconto ( Opcional )
cNFOri,;	// 6 -Numero da NF Original ( Devolucao/Benef )
cSEROri,;	// 7 -Serie da NF Original ( Devolucao/Benef )
nRecOri,;	// 8 -RecNo da NF Original no arq SD1/SD2
nFrete,;	// 9 -Valor do Frete do Item ( Opcional )
nDespesa,;	// 10-Valor da Despesa do item ( Opcional )
nSeguro,;	// 11-Valor do Seguro do item ( Opcional )
nFretAut,;	// 12-Valor do Frete Autonomo ( Opcional )
nValMerc,;	// 13-Valor da Mercadoria ( Obrigatorio )
nValEmb,;	// 14-Valor da Embalagem ( Opiconal )
nRecSB1,;	// 15-RecNo do SB1
nRecSF4,;	// 16-RecNo do SF4
cNItem,;    // 17-Item
nDesNTrb,;  // 18-Despesas nao tributadas - Portugal
nTara,;		// 19-Tara - Portugal
cCfo,; 		// 20-CFO
aNfOri,;    // 21-Array para o calculo do IVA Ajustado (opcional)
cConcept,;	// 22-Concepto
nBaseVeic,;	// 23-Base Veiculo
nPLote,; 	// 24-Lote Produto
nPSubLot,;	// 25-Sub-Lote Produto
nAbatIss,;	// 26-Valor do Abatimento ISS
cCodISS,; 	// 27-Codigo ISS
cClasFis,;	// 28-Classificação Fiscal
cProdFis,;	// 29-Cod. do Produto Fiscal
nRecPrdF,;	// 30-Recno do Produto Fiscal
cNcmFiscal) // 31-NCM do produto Fiscal

__cProduto  := cProduto
__cTes		:= cTes
__nQtd		:= nQtd
__nPrcUnit  := nPrcUnit
__nDesconto := nDesconto
__cNFOri    := cNFOri
__cSEROri   := cSEROri
__nRecOri   := nRecOri
__nFrete    := nFrete
__nDespesa  := nDespesa
__nSeguro   := nSeguro
__nFretAut  := nFretAut
__nValMerc  := nValMerc
__nValEmb   := nValEmb
__nRecSB1   := nRecSB1
__nRecSF4   := nRecSF4
__cNItem    := cNItem
__nDesNTrb  := nDesNTrb
__nTara     := nTara
__cCfo      := cCfo
__aNfOri    := aNfOri
__cConcept  := cConcept
__nBaseVeic := nBaseVeic 
__nPLote    := nPLote
__nPSubLot  := nPSubLot
__nAbatIss  := nAbatIss
__cCodISS   := cCodISS
__cClasFis  := cClasFis
__cProdFis  := cProdFis
__nRecPrdF  := nRecPrdF
__cNcmFiscal := cNcmFiscal

Return &("StaticCall(MATXFISU,MAFISADD,__cProduto,__cTes,__nQtd,__nPrcUnit,__nDesconto,__cNFOri,__cSEROri,__nRecOri,__nFrete,__nDespesa,__nSeguro," +;
                                      "__nFretAut,__nValMerc,__nValEmb,__nRecSB1,__nRecSF4,__cNItem,__nDesNTrb,__nTara,__cCfo,__aNfOri,__cConcept," +;
                                      "__nBaseVeic,__nPLote,__nPSubLot,__nAbatIss,__cCodISS,__cClasFis,__cProdFis,__nRecPrdF,__cNcmFiscal)")

User Function MFsEndLoad(nItem,nTipo)
Return MaFisEndLoad(nItem,nTipo)

User Function MFsRet(nItem,cCampo)
Return MaFisRet(nItem,cCampo)

User Function MFsRef(cReferencia,cProg,xValor)
Return MaFisRef(cReferencia,cProg,xValor)

User Function MCsToFis(aHeader,aCols,nItem,cProg,lRecalc,lVisual,lDel,lSoItem)
Return MaColsToFis(aHeader,aCols,nItem,cProg,lRecalc,lVisual,lDel,lSoItem)

User Function MFsToCols(aHeader,aCols,nItem,cProg)
Return MaFisToCols(aHeader,aCols,nItem,cProg)

User Function MFsSXRef(cAlias)
Return MaFisSXRef(cAlias)

User Function MFsRelImp(cProg,aAlias)
Return MaFisRelImp(cProg,aAlias)

User Function MFsDel(nItem,lDelete)
Return MaFisDel(nItem,lDelete)

User Function MFsAlt(cCampo,nValor,nItem,lNoCabec,nItemNao,lDupl,cRotina,lRecal)
Return MaFisAlt(cCampo,nValor,nItem,lNoCabec,nItemNao,lDupl,cRotina,lRecal)

User Function MFsRecal(cCampo,nItem)
Return MaFisRecal(cCampo,nItem)

User Function MFsTes(cTes,nRecnoSF4,nItemTes)
Return MaFisTes(cTes,nRecnoSF4,nItemTes)

User Function MFsWrite(nOpc,cArea,nItem,lImpostos,lRemito)
Return MaFisWrite(nOpc,cArea,nItem,lImpostos,lRemito)

User Function MFsAtuSF3(nCaso, cTpOper, nRecNF, cAlias, cPDV, cCNAE, cFunOrig, nCD2, cCodSef)
Return MaFisAtuSF3(nCaso, cTpOper, nRecNF, cAlias, cPDV, cCNAE, cFunOrig, nCD2, cCodSef)

User Function MFsIniNF(nTipoNF,nRecSF,aOtimizacao,cAlias,lReprocess,cFunOrig, lHistFis, cAlsItem2)
Return MaFisIniNF(nTipoNF,nRecSF,aOtimizacao,cAlias,lReprocess,cFunOrig, lHistFis, cAlsItem2)

User Function MFsBrwLivro(oWnd,aPosWnd,lVisual,aRecSF3,lOpcVisual)
Return MaFisBrwLivro(oWnd,aPosWnd,lVisual,aRecSF3,lOpcVisual)

User Function MFsRodape(nTipo,;		// Quebra : 1 Imposto+Aliquota,  2-Imposto
	oJanela,;		// Janela onde sera montado
	aImpostos,;	// Relacao de Impostos que deverao aparecer ( Codigo )
	aPos,;			// Array contendo Posicao e Tamanho
	bValidPrg,;	// Validacao executada na Edicao dop Campo
	lVisual,; // So para visualizacao
	cFornIss,; //Fornecedor do ISS
	cLojaIss,; //Loja do Fornecedor do ISS
	aRecSE2,;
	cDirf,;
	cCodRet,;
	oCodRet,;
	nCombo,;
	oCombo,;
	dVencIss,; 	//Vencimento ISS
	aCodR,;
	cRecIss,;	//Informa se recolhe o ISS ou nao
	oRecIss,;
	lEditImp) //Edicao de impostos dos Docs.Fiscais operacao de Inclusao, MV_EDITIMP ativado, Form.Proprio N e Especie NF/NCP/NDP/NDE/NCE (LOCALIZADO)

Return MaFisRodape(nTipo,;		// Quebra : 1 Imposto+Aliquota,  2-Imposto
	oJanela,;		// Janela onde sera montado
	aImpostos,;	// Relacao de Impostos que deverao aparecer ( Codigo )
	aPos,;			// Array contendo Posicao e Tamanho
	bValidPrg,;	// Validacao executada na Edicao dop Campo
	lVisual,; // So para visualizacao
	cFornIss,; //Fornecedor do ISS
	cLojaIss,; //Loja do Fornecedor do ISS
	aRecSE2,;
	cDirf,;
	cCodRet,;
	oCodRet,;
	nCombo,;
	oCombo,;
	dVencIss,; 	//Vencimento ISS
	aCodR,;
	cRecIss,;	//Informa se recolhe o ISS ou nao
	oRecIss,;
	lEditImp) //Edicao de impostos dos Docs.Fiscais operacao de Inclusao, MV_EDITIMP ativado, Form.Proprio N e Especie NF/NCP/NDP/NDE/NCE (LOCALIZADO)

User Function MFsVldAlt(cReferencia,nItem)
Return MaFisVldAlt(cReferencia,nItem)

User Function MFsLine(oList,aTemp,nTipo)
Return MaFisLine(oList,aTemp,nTipo)

User Function MFsInsereImp(oList,bValidPrg,nTipo)
Return MaFisInsereImp(oList,bValidPrg,nTipo)

User Function MFsEditCell(nValor,oBrowse,cPict,nCol,cValidCpo)
Return MaFisEditCell(nValor,oBrowse,cPict,nCol,cValidCpo)

User Function MFsRRefresh(oList,nTipo,oFornISS,cFornISS,oLojaISS,cLojaISS,oRecISS,cRecISS)
Return MaFisRRefresh(oList,nTipo,oFornISS,cFornISS,oLojaISS,cLojaISS,oRecISS,cRecISS)

User Function MaAtuCdR(cCodRet,aCodR,oList,oCodRet,oCombo,nCombo,aOpcoes)
Return MaAtuCdR(cCodRet,aCodR,oList,oCodRet,oCombo,nCombo,aOpcoes)

User Function MFsScan(cCampo,lErro)
Return MaFisScan(cCampo,lErro)

User Function MFsGetRF(cValid)
Return MaFisGetRF(cValid)

User Function MaIniRef()
Return MaIniRef()

User Function MFsVTot(nItem)
Return MaFisVTot(nItem)

User Function MaFisCFO(nItem,cAuxCF,aDados)
Return MaFisCFO(nItem,cAuxCF,aDados)

User Function MRtIncIV(nItem,cOpc)
Return MaRetIncIV(nItem,cOpc)

User Function NCpoImpVar(xCpoLiv)
Return NumCpoImpVar(xCpoLiv)

User Function MFsCalAl(nImposto,nItem)
Return MaFisCalAl(nImposto,nItem)

User Function MRtBasT(cNumImp,nItem,nAliq,llTot)
Return MaRetBasT(cNumImp,nItem,nAliq,llTot)

User Function MAliqISS(nItem)
Return MaAliqISS(nItem)

User Function MTbIrfPF(nBaseIRF,nTotIrf,lSE2,cFornece,cLoja,dVencReal,cPessoa)
Return MaTbIrfPF(nBaseIRF,nTotIrf,lSE2,cFornece,cLoja,dVencReal,cPessoa)

User Function MSBCampo(cNome)
Return MaSBCampo(cNome)

User Function MaRecIR(dVencReal)
Return MaRecIR(dVencReal)

User Function MFsAddIT(cCampo,xValor,nItem,lZer)
Return MaFisAddIT(cCampo,xValor,nItem,lZer)

User Function CdSitTri()
Return CodSitTri()

User Function Dcrt5602(nVlItem,cNCM,cCodNat)
Return Decret5602(nVlItem,cNCM,cCodNat)

User Function MaFisGet(cReferencia)
Return MaFisGet(cReferencia)

User Function MFsOrdem(cReferencia)
Return MaFisOrdem(cReferencia)

User Function MAvalTes(cOperacao,cTes)
Return MaAvalTes(cOperacao,cTes)

User Function MFsRefLd(cAlias,cTipo)
Return MaFisRefLd(cAlias,cTipo)

User Function MFsLdImp()
Return MaFisLdImp()

User Function MFsImpLd(cAlias,cTipo,cCursor)
Return MaFisImpLd(cAlias,cTipo,cCursor)

User Function MaFisCDA(nItem,nTipo,lExclui,cChaveSF,cFormul,cAlias)
Return MaFisCDA(nItem,nTipo,lExclui,cChaveSF,cFormul,cAlias)

User Function MFsIniPC(cPedido,cItem,cSequen,cFiltro)
Return MaFisIniPC(cPedido,cItem,cSequen,cFiltro)

User Function MFsLojSF3(nLjOpcao,xVariavel,nXItem,cFunOrig,cAlias)
Return MaFisLojSF3(nLjOpcao,xVariavel,nXItem,cFunOrig,cAlias)

User Function MFsVRodape(oList,bValidPrg,nTipo,nCol)
Return MaFisVRodape(oList,bValidPrg,nTipo,nCol)

User Function MaFisLF(nItem,lRecPreSt)
Return MaFisLF(nItem,lRecPreSt)

User Function MaFisAjIt(nXX,nTipo)
Return MaFisAjIt(nXX,nTipo)

User Function RetComp(cAlOri,nRecOri)
Return RetComp(cAlOri,nRecOri)

User Function MFsReprocess(nOpc)
Return MaFisReprocess(nOpc)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±³Fun‡…o    ³CpyFieldSB    ³ Autor ³                   ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Copia estrutura de campo do SB1 para criar no SBZ          ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CpyFieldSB(aSx3,lRetCp)

Local aAreaSX3	:= {}
Local aHelp		:= {}
Local nX		:= 0
Local nY		:= 0
Local cOrdem	:= ""
Local cMensagem	:= ""
Local cRet		:= ""
//³Os campos agregados neste array serao considerados na execução do UPDFIS para replicar os campos     |
//³ do SB1 para o SBZ. E na leitura na funcao MaSBCampo, na MATXFIS, que direciona a leitura de         ³
//³ informacoes fiscais do produto para o SB1 ou SBZ dependendo da configuracao do parametro MV_ARQPROD ³
Local aCpoSBZ 	:= {	"B1_PICM"	,;
"B1_VLR_ICM",;
"B1_INT_ICM",;
"B1_PICMRET",;
"B1_PICMENT",;
"B1_IPI"	,;
"B1_VLR_IPI",;
"B1_REDPIS"	,;
"B1_REDCOF"	,;
"B1_IRRF"	,;
"B1_ORIGEM"	,;
"B1_GRTRIB"	,;
"B1_CODISS" ,;
"B1_FECP"	,;
"B1_ALIQISS",;
"B1_PIS",;
"B1_COFINS",;
"B1_CSLL",;
"B1_PCSLL",;
"B1_ALFUMAC",;
"B1_FECPBA",;
"B1_ALFECRN",;
"B1_CNAE"}

DEFAULT lRetCp	:= .F.
DEFAULT aSx3	:= {}

If lRetCp
	For nX := 1 to len(aCpoSBZ)
		cRet += aCpoSBZ[nX] + "/"
	Next nX
	Return cRet
EndIf

aAreaSX3 := SX3->(GetArea())

dbSelectArea("SX3")
dbSetOrder(2)
For nX := 1 to len(aCpoSBZ)
	If SX3->(MsSeek(PadR(aCpoSBZ[nX],10)))
		
		AADD(aSX3,{	"SBZ"			,cOrdem			,StrTran(aCpoSBZ[nX],"B1","BZ"),;
		SX3->X3_TIPO	,SX3->X3_TAMANHO,SX3->X3_DECIMAL,;
		SX3->X3_TITULO 	,SX3->X3_TITSPA ,SX3->X3_TITENG ,;
		SX3->X3_DESCRIC	,SX3->X3_DESCSPA,SX3->X3_DESCENG,;
		SX3->X3_PICTURE	,StrTran(SX3->X3_VALID,"B1_","BZ_"),SX3->X3_USADO,;
		StrTran(SX3->X3_RELACAO,"B1_","BZ_"),SX3->X3_F3     ,SX3->X3_NIVEL,;
		SX3->X3_RESERV ,SX3->X3_CHECK  	,SX3->X3_TRIGGER,;
		SX3->X3_PROPRI ,SX3->X3_BROWSE	,SX3->X3_VISUAL,;
		SX3->X3_CONTEXT,SX3->X3_OBRIGAT	,StrTran(SX3->X3_VLDUSER,"B1_","BZ_"),;
		SX3->X3_CBOX   ,SX3->X3_CBOXSPA	,SX3->X3_CBOXENG,;
		SX3->X3_PICTVAR,SX3->X3_WHEN	,SX3->X3_INIBRW,;
		SX3->X3_GRPSXG ,"2"				,SX3->X3_PYME	}	)
		
		aHelp := {}
		cMensagem := Ap5GetHelp(aCpoSBZ[nX])
		For nY := 1 to MlCount(cMensagem)
			AADD(aHelp,MemoLine(cMensagem,,nY))
		Next nY
		PutHelp("P"+StrTran(aCpoSBZ[nX],"B1","BZ"),aHelp,aHelp,aHelp,.T.)
		
	EndIf
Next nX

RestArea(aAreaSX3)

Return Nil