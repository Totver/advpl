#INCLUDE "TOTVS.CH"

Static nReg	:= 0

/*/{Protheus.doc} TGCTUGEN
Rotina para emissão do relatorio de estruturas .

@type function
@since 24/11/2023
@version 1.0
@return ${return}, ${return_description}
@example
(examples)
@see (links_or_references)
@Author Washington Miranda Leão
/*/
User Function TGCTEST()

	Local aParamBox	:= {}
	Local aRet		:= {}
	Local cTitulo   := "Rotina para impresao do relatorio de estruturas"
	Local cComp     := Subs(Dtos(Date()), 5, 2) + Left(Dtos(Date()), 4)

	Private oExcel      := FWMSEXCEL():New()
	Private oExcel2     := FWMSEXCEL():New()
	Private oExcel6     := FWMSEXCEL():New()
	Private cLog	    := 'UPDPSV'+dtos(date()) + strtran(time(),':','')+'.XML'

	MyOpenSM0()

	AADD(aParamBox,{1,"Competencia", cComp, "@R 99/9999", "NaoVazio()",,, 30, .T.})

	If !ParamBox(aParamBox, cTitulo, @aRet,,,,,,,, .F.) 
		Return
	EndIf

	mv_par01 := Right(mv_par01, 4) + Left(mv_par01, 2)

	cLog := 'UPDCHURN'+dtos(date()) + strtran(time(),':','')+'.XML'
	oProcess := MsNewProcess():New({|lEnd| Processa() }, cTitulo, "Aguarde ...", .T.)
	oProcess:Activate()
	
	cTitulo   := "Geração do relatorio de  estruturas"
	cLog := 'PSESTRUC'+dtos(date()) + strtran(time(),':','')+'.XML'
	oProcess := MsNewProcess():New({|lEnd| Process2() }, cTitulo, "Aguarde ...", .T.)
	oProcess:Activate()

	MsgFimAju(cTitulo, "Rotinas executadas." + Chr(13) + Chr(10) + "Logs gerados em [c:\temp\]")

Return

Static Function Processa()

	Local cTitulo := "Resumo-" + Right(mv_par01, 2) + "-" + Left(mv_par01, 4)

	GrLog("Selecionando Registros Estruturas de Produtos!")
      
BeginSQL Alias "QRY"

SELECT '1' as NIVEL, G1.G1_COD, G1.G1_QUANT, G1.G1_COMP, A5.A5_NOMPROD,
SB.B1_DESC, A5.A5_SITU, A5.A5_FORNECE, A5.A5_NOMEFOR, A5.A5_XXPNUM, A5.A5_CODPRF, A5.A5_FABR
FROM %table:SG1% G1
INNER JOIN %table:SA5% A5 ON G1.G1_COD = A5.A5_PRODUTO
INNER JOIN %table:SB1% SB ON G1.G1_COMP = SB.B1_COD
WHERE G1.G1_COD = 'PA20020420' AND G1.D_E_L_E_T_ <> '*'
UNION
SELECT '2' as NIVEL, G2.G1_COD, G2.G1_QUANT, G2.G1_COMP, A5.A5_NOMPROD, SB.B1_DESC, A5.A5_SITU,
A5.A5_FORNECE, A5.A5_NOMEFOR, A5.A5_XXPNUM, A5.A5_CODPRF, A5.A5_FABR
FROM %table:SG1% G2
INNER JOIN %table:SA5% A5 ON G2.G1_COD = A5.A5_PRODUTO
INNER JOIN %table:SB1% SB ON G2.G1_COMP = SB.B1_COD
WHERE G2.G1_COD IN
(SELECT DISTINCT G1_COMP FROM %table:SG1% WHERE G1_COD = 'PA20020420' AND D_E_L_E_T_ <> '*' AND SUBSTRING(G1_COMP, 1, 2) <> 'MO') AND G2.D_E_L_E_T_ <> '*'
UNION
SELECT '3' as NIVEL, G3.G1_COD, G3.G1_QUANT, G3.G1_COMP, A5.A5_NOMPROD, SB.B1_DESC, A5.A5_SITU, A5.A5_FORNECE, A5.A5_NOMEFOR, A5.A5_XXPNUM, A5.A5_CODPRF, A5.A5_FABR
FROM %table:SG1% G3
INNER JOIN %table:SA5% A5 ON G3.G1_COD = A5.A5_PRODUTO
INNER JOIN %table:SB1% SB ON G3.G1_COMP = SB.B1_COD
WHERE G3.G1_COD IN
(SELECT DISTINCT G1_COMP FROM %table:SG1% WHERE G1_COD IN
(SELECT DISTINCT G1_COMP FROM %table:SG1% WHERE G1_COD = 'PA20020420' AND D_E_L_E_T_ <> '*' AND SUBSTRING(G1_COMP, 1, 2) <> 'MO') AND G3.D_E_L_E_T_ <> '*')
UNION
SELECT '4' as NIVEL, G4.G1_COD, G4.G1_QUANT, G4.G1_COMP, A5.A5_NOMPROD, SB.B1_DESC, A5.A5_SITU, A5.A5_FORNECE, A5.A5_NOMEFOR, A5.A5_XXPNUM, A5.A5_CODPRF, A5.A5_FABR
FROM %table:SG1% G4
INNER JOIN %table:SA5% A5 ON G4.G1_COD = A5.A5_PRODUTO
INNER JOIN %table:SB1% SB ON G4.G1_COMP = SB.B1_COD
WHERE G4.G1_COD IN
(SELECT DISTINCT G1_COMP FROM %table:SG1% WHERE G1_COD IN
(SELECT DISTINCT G1_COMP FROM %table:SG1% WHERE G1_COD IN
(SELECT DISTINCT G1_COMP FROM %table:SG1% WHERE G1_COD IN
(SELECT DISTINCT G1_COMP FROM %table:SG1% WHERE G4.D_E_L_E_T_ <> '*' AND G4.G1_COD = 'PA20020420' AND SUBSTRING(G1_COMP, 1, 2) <> 'MO')))) AND G4.D_E_L_E_T_ <> '*'
ORDER BY NIVEL, G1.G1_COD,G1.G1_COMP

EndSQL

	//	Criando as planilhas no pasta
	oExcel:AddworkSheet(cTitulo)

	//	Criando os nomes das tabelas
	oExcel:AddTable (cTitulo,"Itens")

	// Criando as colunas
	oExcel:AddColumn(cTitulo,"Itens","Codigo do Produto", 1, 1)
	oExcel:AddColumn(cTitulo,"Itens","Quantidade do Componente", 1, 1)
	oExcel:AddColumn(cTitulo,"Itens","Codigo do Componente", 1, 1)
	oExcel:AddColumn(cTitulo,"Itens","Nome do Produto", 1, 1)
	oExcel:AddColumn(cTitulo,"Itens","Descricao do Produto", 1, 1)
	oExcel:AddColumn(cTitulo,"Itens","Classe Situacao Forn/Prod", 1, 1)
	oExcel:AddColumn(cTitulo,"Itens","Codigo do Fornecedor", 1, 1)
	oExcel:AddColumn(cTitulo,"Itens","Nome do Fornecedor", 1, 1)
	oExcel:AddColumn(cTitulo,"Itens","A5_XXPNUM nao achei este campo", 1, 1)
	oExcel:AddColumn(cTitulo,"Itens","Codigo do Produto No Fornecedor", 3, 2)
	oExcel:AddColumn(cTitulo,"Itens","Codigo do Fabricante", 1, 1)
	
	GrLog("Iniciando a geração da Planilha excel! ")
	
	While ! QRY->(Eof())
		
		
			oExcel:AddRow(	cTitulo,"Itens",;
						{	Codigo do Produto,;
							Quantidade do Componente,;
							Codigo do Componente,;
							Nome do Produto,;
							Descricao do Produto,;
							Classe Situacao Forn/Prod,;
							Codigo do Fornecedor,;
							Nome do Fornecedor,;
							A5_XXPNUM nao achei este campo,;
							Codigo do Produto No Fornecedor,;
							Codigo do Fabricante })
		

		QRY->(DbSkip())
	EndDo  
	QRY->(DbCloseArea())

	oExcel:Activate()
	oExcel:GetXMLFile("\TEMP\"+cLog)
	__Copyfile("\TEMP\"+cLog, "c:\TEMP\"+cLog)	

	GrLog("Finalizando a gravação dos dados na  Planilha")

Return

//--------------------------------------------------------------------------
/*/{Protheus.doc} InitLog
GeraÃ§Ã£o do texto de log com hora de execuÃ§Ã£o

@since  13/09/2015
@param  cLog = Texto para chamada da funÃ§Ã£o AutoGrLog
@return Nil

/*/
//-------------------------------------------------------------------------
Static Function GrLog(cLog)

	FwLogMsg("INFO", /*cTransactionId*/, "TGCESTRU", FunName(), "", "01", Dtoc(dDataBase) + "-" + Time() + "-" + cLog)

Return

//--------------------------------------------------------------------------
/*/{Protheus.doc} MyOpenSM0
Abertura do arquivo SIGAMAT.EMP quando necessÃ¡rio

@since  24/11/2023
@param  Nil
@return Nil

/*/
//-------------------------------------------------------------------------
Static Function MyOpenSM0()

If Select("SM0") > 0
	Return
EndIf

	OpenSM0()

	RpcSetType( 3 )
	DbGoTop()
	RpcSetEnv( SM0->M0_CODIGO, SM0->M0_CODFIL )

Return

/*/{Protheus.doc} MsgFimAju
@since 24/11/2023
@version undefined
@type function
/*/
Static Function MsgFimAju(cTitulo, cMensagem)

	Local oGroup1
	Local oSay1
	Local oSButton1
	Local oSButton2
	Local oFont
	Local oDlg
	Local lOk := .F.
	default cMensagem := "Processamento realizado com sucesso."
	
	oFont := TFont():New( "Courier New",,14,,.T.,,,,,.F. )
	
	DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000, 000  TO 105, 510 COLORS 0, 16777215 PIXEL
	
	@ 000, 003 GROUP oGroup1 TO 033, 246 OF oDlg PIXEL
	
	@ 008, 015 SAY oSay1 VAR cMensagem SIZE 220, 020 OF oDlg PIXEL FONT oFont
	
	DEFINE SBUTTON oSButton1 FROM 035, 179 TYPE 01 OF oDlg ENABLE ACTION ( lOk := .T., oDlg:End() )
	DEFINE SBUTTON oSButton2 FROM 035, 219 TYPE 02 OF oDlg ENABLE ACTION ( lOk := .F., oDlg:End() )
	
	ACTIVATE MSDIALOG oDlg CENTERED
	
Return lOk

