#Include 'Protheus.ch'
#INCLUDE "REPORT.CH"


/*/{Protheus.doc} F0180101
Função de Relatório de Acerto de Contas (Subcontratado)

@Author Wanderley Ramos Neto
@Since 18/09/2014
@Version P11
@Project MAN00000180401_EF_801
@Menu SIGATMS\Relatórios\Subcontratada\Acerto de Contas
/*/
User Function F0180101()

Local oReport	:= Nil

oReport:= ReportDef()
oReport:PrintDialog()

Return

/*/{Protheus.doc} ReportDef
Função responsavel por definir a estrutura do relatorio com
suas seções, colunas, etc.

@Author Wanderley Ramos Neto
@Since 18/09/2014
@Version P11
@Project MAN00000180401_EF_801
@Return oReport objeto contendo as definiçoes do relatorio
@History - 05/11/2014 - Ajuste SetHeaderSection e SetAutoSize do oSection3, resolucao do problema espacamento
/*/
Static Function ReportDef()

Local oReport, oSection1, oSection2, oSection3
Local cDesc		:= "Relatório de Acerto de Contas (Subcontratado)"
Local cTitulo		:= "Acerto de Contas (Subcontratado)"
Local cAlias 		:= GetNextAlias()
Local cAliasJus	:= GetNextAlias()
Local oBrkForn    := Nil
Local oBrkServ    := Nil

Private cPerg		:= "FSW0180101"

// Define Perguntas utilizadas no Relatorio
CriaSX1(cPerg)
Pergunte(cPerg,.T.)


// Definição padrão do relatório TReport
DEFINE REPORT oReport NAME "F01801" TITLE cTitulo /*PARAMETER cPerg */ACTION {|oReport| PrintReport(oReport,cAlias)} DESCRIPTION cDesc TOTAL IN COLUMN
oReport:SetLandscape()
//oReport:nFontBody := 5

// Seção de Fornecedor
DEFINE SECTION oSection1 OF oReport TITLE "Fornecedor" TABLES cAlias
	TRCell():New(oSection1,"Fornecedor",	cAlias,"Fornecedor"		,PesqPict("SA2","A2_COD") ,TamSx3("A2_COD")[1],/*lPixel*/,{|| (cAlias)->A2_COD }) 
	TRCell():New(oSection1,"Razão Social",	cAlias,"Razão Social"	,PesqPict("SA2","A2_NOME") ,TamSx3("A2_NOME")[1],/*lPixel*/,{|| (cAlias)->A2_NOME })
//	TRCell():New(oSection1,"M0_FILIAL","SM0","Filial"	,PesqPict("SM0","M0_FILIAL") ,TamSx3("M0_FILIAL")[1],/*lPixel*/,{|| FWFilialName(,(cAlias)->PE0_FILORI) })
	
	// Seção de Tipo de Serviço
	DEFINE SECTION oSection2 OF oSection1 TITLE "Tipo de Serviço" TABLES cAlias
		oSection2:SetLeftMargin(2)
		//oSection2:SetTotalInLine(.F.)
	
		TRCell():New(oSection2,"DT6_SERTMS",	cAlias,"Serviço"		,PesqPict("DT6","DT6_SERTMS") ,TamSx3("DT6_SERTMS")[1],/*lPixel*/,{|| (cAlias)->(DT6_SERTMS) })
		TRCell():New(oSection2,"DTC_DESSVT",	cAlias,"Descriçao"	,PesqPict("DT6","DTC_DESSVT") ,TamSx3("DTC_DESSVT")[1],/*l0Pixel*/,{|| iif((cAlias)->DT6_SERTMS == '1', 'Coleta', iif((cAlias)->DT6_SERTMS == '2','Transferencia','Entrega') ) })		
	
		oReport:FatLine()	

		// Seção de dados das Tabelas de Frete
		DEFINE SECTION oSection3 OF oSection2 TITLE "Documentos" TABLES cAlias
		oSection3:SetLeftMargin(4)
		
			oCell01 := TRCell():New( oSection3, "CTRC", 				cAlias, "CTRC", 				PesqPict("DT6","DT6_DOC"),		TamSX3("DT6_DOC")[1]		,/*lPixel*/.F.,{|| (cAlias)->DT6_DOC },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
			oCell02 := TRCell():New( oSection3, "Tipo", 				cAlias, "Tipo", 				PesqPict("PEM","PEM_TPDCNW"),	TamSX3("PEM_TPDCNW")[1]	,/*lPixel*/.F.,{|| (cAlias)->PEM_TPDCNW },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
			oCell03 := TRCell():New( oSection3, "Dt Emissao", 		cAlias, "Dt Emissao", 		PesqPict("PEM","PEM_DTEMIS"),	10							,/*lPixel*/.F.,{|| SToD((cAlias)->PEM_DTEMIS) },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
			oCell04 := TRCell():New( oSection3, "CNPJ Remetente", 	cAlias, "CNPJ Remetente",	PesqPict("SA1","A1_CGC"),		18							,/*lPixel*/.F.,{|| (cAlias)->A1_CGC     },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
			oCell05 := TRCell():New( oSection3, "Razão Social Rem",	cAlias, "Razão Social Rem",	PesqPict("SA1","A1_NOME"),		TamSX3("A1_NOME")[1]		,/*lPixel*/.F.,{|| (cAlias)->A1_NOME    },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
			oCell06 := TRCell():New( oSection3, "Mun Rem",			cAlias, "Municipio",			PesqPict("SA1","A1_MUN"), 		TamSX3("A1_MUN")[1]		,/*lPixel*/.F.,{|| (cAlias)->MUN_REM	 },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )// Municipio Destino
			oCell07 := TRCell():New( oSection3, "UF Rem",				cAlias, "UF",					PesqPict("SA1","A1_EST"), 		TamSX3("A1_EST")[1]		,/*lPixel*/.F.,{|| (cAlias)->UF_REM     },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )// UF
			oCell08 := TRCell():New( oSection3, "CNPJ Destinatario",cAlias, "CNPJ Destinatario",PesqPict("SA1","A1_CGC"), 		18							,/*lPixel*/.F.,{|| (cAlias)->A1_CGC     },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
			oCell09 := TRCell():New( oSection3, "Razão Social Des", cAlias, "Razão Social Des",	PesqPict("SA1","A1_NOME"), 		TamSX3("A1_NOME")[1]		,/*lPixel*/.F.,{|| (cAlias)->A1_NOME    },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
			oCell10 := TRCell():New( oSection3, "Mun Dest",			cAlias, "Municipio",			PesqPict("SA1","A1_MUN"), 		TamSX3("A1_MUN")[1]		,/*lPixel*/.F.,{|| (cAlias)->MUN_DES	 },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )// Municipio Destino
			oCell11 := TRCell():New( oSection3, "UF Dest",			cAlias, "UF",					PesqPict("SA1","A1_EST"), 		TamSX3("A1_EST")[1]		,/*lPixel*/.F.,{|| (cAlias)->UF_DES     },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )// UF
			oCell12 := TRCell():New( oSection3, "Dest",				cAlias, "Destino",			"@!",								TamSX3("X5_DESCRI")[1]	,/*lPixel*/.F.,{|| (cAlias)->X5_DESCRI  },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )// Dest ???
			oFornSec3 := TRCell():New(oSection3,"A2_COD",	cAlias,"Fornecedor"	,PesqPict("SA2","A2_COD") ,TamSx3("A2_COD")[1],/*lPixel*/,{|| (cAlias)->A2_COD })
			oSerTMS3 := TRCell():New(oSection3,"DT6_SERTMS",cAlias,"Serviço"		,PesqPict("DT6","DT6_SERTMS") ,TamSx3("DT6_SERTMS")[1],/*lPixel*/,{|| (cAlias)->(DT6_SERTMS) })
			oFornSec3:Hide()
			oSerTMS3:Hide()
			 
			oCell13 := TRCell():New( oSection3, "Vl. Mercado.", 		cAlias,  "Vl. Mercado.",		PesqPict("DT6","DT6_VALMER"), TamSX3("DT6_VALMER")[1],/*lPixel*/.F.,{|| (cAlias)->DT6_VALMER },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
			oCell14 := TRCell():New( oSection3, "Peso", 				cAlias,  "Peso", 				PesqPict("DT6","DT6_PESO"),   TamSX3("DT6_PESO")[1]  ,/*lPixel*/.F.,{|| (cAlias)->DT6_PESO   },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
			oCell15 := TRCell():New( oSection3, "Volumes", 			cAlias,  "Volumes", 			PesqPict("DT6","DT6_QTDVOL"), TamSX3("DT6_QTDVOL")[1],/*lPixel*/.F.,{|| (cAlias)->DT6_QTDVOL },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
			oCell16 := TRCell():New( oSection3, "Vlr. Frete", 		cAlias,  "Vlr. Frete", 		PesqPict("DT6","DT6_VALFRE"), TamSX3("DT6_VALFRE")[1],/*lPixel*/.F.,{|| (cAlias)->DT6_VALFRE },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )   
			oCell17 := TRCell():New( oSection3, "Vlr. Imposto", 		cAlias,  "Vlr. Imposto",	 	PesqPict("DT6","DT6_VALIMP"), TamSX3("DT6_VALIMP")[1],/*lPixel*/.F.,{|| (cAlias)->DT6_VALIMP },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )   
			oCell18 := TRCell():New( oSection3, "Vlr. Liquido", 		cAlias,  "Vlr. Liquido",	 	PesqPict("DT6","DT6_VALTOT"), TamSX3("DT6_VALTOT")[1],/*lPixel*/.F.,{|| (cAlias)->DT6_VALTOT },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )   
			oCell19 := TRCell():New( oSection3, "Vlr. Comissao", 	cAlias,  "Vlr. Comissao",	PesqPict("PEM","PEM_COMISS"), TamSX3("PEM_COMISS")[1],/*lPixel*/.F.,{|| (cAlias)->PEM_COMISS },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )   
	
			// Adic. por Edu em 05/11/14 p/ corrigir erro espacamento (SINTETICO)
			oSection3:SetHeaderSection(MV_PAR11 # 1)
			//oSection3:SetTotalInLine(.F.)
			//oSection3:SetAutoSize()	
			
				DEFINE SECTION oSection4 OF oSection3 TITLE "Notas Fiscais" TABLES cAlias
				oSection4:SetLeftMargin(8)
								
					TRCell():New( oSection4, "Nota Fiscal", 	cAlias, "Nota Fiscal",	PesqPict("DTC","DTC_NUMNFC"),	TamSX3("DTC_NUMNFC")[1]	,/*lPixel*/.F.,{|| (cAlias)->DTC_NUMNFC },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
					TRCell():New( oSection4, "Série",		 	cAlias, "Série",			PesqPict("DTC","DTC_SERNFC"),	TamSX3("DTC_SERNFC")[1]	,/*lPixel*/.F.,{|| (cAlias)->DTC_SERNFC },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
					TRCell():New( oSection4, "Emissão", 		cAlias, "Emissão",		PesqPict("DTC","DTC_EMINFC"),	10							,/*lPixel*/.F.,{|| SToD((cAlias)->DTC_EMINFC) },/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
				
				oSection4:SetHeaderSection(.T.)
				oSection4:SetAutoSize()	
				
		IF MV_PAR11 == 1 // Sintetico
			
			// Caso seja sintetico, oculta células dos documentos
			//  e exibe só os totais
			//oCell01:Hide()
			//oCell02:Hide()
			//oCell03:Hide()
			//oCell04:Hide()
			//oCell05:Hide()
			//oCell06:Hide()
			//oCell07:Hide()
			//oCell08:Hide()
			//oCell09:Hide()
			//oCell10:Hide()
			//oCell11:Hide()
			//oCell12:Hide()
			
			//oCell13:Hide()
			//oCell14:Hide()
			//oCell15:Hide()
			//oCell16:Hide()
			//oCell17:Hide()
			//oCell18:Hide()
			//oCell19:Hide() 
			
			//oSection3:bLineCondition:= {||.F.}
			//oSection4:bLineCondition:= {||.F.}
			
			oSection3:Hide()
			oSection4:Hide()
			
		EndIf

		//Quebra 
		oBrkServ:= TRBreak():New(oSection3,{||oSection3:Cell("A2_COD"):uPrint+oSection3:Cell("DT6_SERTMS"):uPrint},Nil,.F.) 
		
		//Adic. por Edu em 06/11/14 para totalizar pela secao 2 (tipo de servico)
		//oTotVlr2:= TRFunction():New(oSection3:Cell("Vl. Mercado."),Nil,"SUM",oBrkServ,"Vl. Mercado.",,,.T.,.F.,.F.,oSection2) 
		//oTotVol2:= TRFunction():New(oSection3:Cell("Volumes"),Nil,"SUM",oBrkServ,"Volumes",,,.T.,.F.,.F.,oSection2) 
		//oTotFre2:= TRFunction():New(oSection3:Cell("Vlr. Frete"),Nil,"SUM",oBrkServ,"Vlr. Frete",,,.T.,.F.,.F.,oSection2) 
		//oTotImp2:= TRFunction():New(oSection3:Cell("Vlr. Imposto"),Nil,"SUM",oBrkServ,"Vlr. Imposto",,,.T.,.F.,.F.,oSection2) 
		//oTotLiq2:= TRFunction():New(oSection3:Cell("Vlr. Liquido"),Nil,"SUM",oBrkServ,"Vlr. Liquido",,,.T.,.F.,.F.,oSection2) 
		//oTotCom2:= TRFunction():New(oSection3:Cell("Vlr. Comissao"),Nil,"SUM",oBrkServ,"Vlr. Comissao",,,.T.,.F.,.F.,oSection2) 
		
		//DEFINE FUNCTION FROM oSection3:Cell("Vl. Mercado.")	FUNCTION SUM NO END REPORT
		//DEFINE FUNCTION FROM oSection3:Cell("Peso")			FUNCTION SUM NO END REPORT
		//DEFINE FUNCTION FROM oSection3:Cell("Volumes")		FUNCTION SUM NO END REPORT
		//DEFINE FUNCTION FROM oSection3:Cell("Vlr. Frete")	FUNCTION SUM NO END REPORT
		//DEFINE FUNCTION FROM oSection3:Cell("Vlr. Imposto")	FUNCTION SUM NO END REPORT
		//DEFINE FUNCTION FROM oSection3:Cell("Vlr. Liquido")	FUNCTION SUM NO END REPORT
		//DEFINE FUNCTION FROM oSection3:Cell("Vlr. Comissao")	FUNCTION SUM NO END REPORT	
			
		// Seção de Justificativas
		DEFINE SECTION oSection5 OF oSection1 TITLE "Justificativa de Alteração" TABLES cAlias
			oSection5:SetLeftMargin(2)
		
			TRCell():New(oSection5,"CRTC",				cAlias,	,PesqPict("DT6","DT6_DOC") ,TamSx3("DT6_DOC")[1],/*lPixel*/,{|| (cAlias)->(DT6_DOC) })
			TRCell():New(oSection5,"Justificativa",	cAlias,	,/*PesqPict("DT6","PEM_JUSTIF")*/ ,/*TamSx3("PEM_JUSTIF")[1]*/,/*lPixel*/,{|| PEM->(dbGoTo((calias)->REGPEM)), PEM->PEM_JUSTIF })

	
Return oReport


/*/{Protheus.doc} PrintReport
Definição dos dados do relatorio

@Author Wanderley Ramos Neto
@Since 18/09/2014
@Version P11
@Param oReport Objeto que contem a estrtura do relatorio
@Param cAlias Alias gerado para conter a query que define os dados do relatorio
@Project MAN00000180401_EF_801
/*/
Static Function PrintReport(oReport,cAlias)


Local oSection1b		:= oReport:Section(1)
Local oSection2b		:= oSection1b:Section(1)
Local oSection3b		:= oSection2b:Section(1)
Local oSection4b		:= oSection3b:Section(1)
 
Local cFilDT6			:= xFilial('DT6')
Local cFilDTC			:= xFilial('DTC')
Local cFilPEM			:= xFilial('PEM')
Local cFilPEN			:= xFilial('PEN')
Local cFilSA1			:= xFilial('SA1')
Local cFilSA2			:= xFilial('SA2')
Local cFilDUL			:= xFilial('DUL')

/*
 * Seção Cabeçalho Inicial (Grupo de Produtos)
 */
BEGIN REPORT QUERY oSection1b
	
cQuery := CRLF + "SELECT "
cQuery += CRLF + "	SA2.A2_COD, "
cQuery += CRLF + "	SA2.A2_NOME, "
cQuery += CRLF + "	DT6.DT6_SERTMS, "
cQuery += CRLF + "	DT6.DT6_DOC, "
cQuery += CRLF + "	PEM.PEM_TPDCNW, "
cQuery += CRLF + "	PEM.PEM_DTEMIS, "
cQuery += CRLF + "	DTC.DTC_NUMNFC, "
cQuery += CRLF + "	DTC.DTC_SERNFC, "
cQuery += CRLF + "	DTC.DTC_EMINFC, "
cQuery += CRLF + "	A1R.A1_CGC, "
cQuery += CRLF + "	A1R.A1_NOME, "
cQuery += CRLF + "	A1R.A1_MUN  AS MUN_REM, "
cQuery += CRLF + "	A1R.A1_EST AS UF_REM, "
cQuery += CRLF + "	A1D.A1_CGC, "
cQuery += CRLF + "	A1D.A1_NOME, "	
cQuery += CRLF + "	CASE "
cQuery += CRLF + "		WHEN DTC.DTC_SQEDES = '"+Space(tamSX3("DTC_SQEDES")[1])+"'  THEN A1D.A1_MUN " 
cQuery += CRLF + "		ELSE DUL.DUL_MUN "
cQuery += CRLF + "	END AS MUN_DES, "
cQuery += CRLF + "	CASE "
cQuery += CRLF + "		WHEN DTC.DTC_SQEDES  = '"+Space(tamSX3("DTC_SQEDES")[1])+"'  THEN A1D.A1_EST " 
cQuery += CRLF + "		ELSE DUL.DUL_EST "
cQuery += CRLF + "	END AS UF_DES,"
cQuery += CRLF + "	SX5.X5_DESCRI, "
cQuery += CRLF + "	DT6.DT6_VALMER, "
cQuery += CRLF + "	DT6.DT6_PESO, "
cQuery += CRLF + "	DT6.DT6_QTDVOL, "
cQuery += CRLF + "	DT6.DT6_VALFRE, "
cQuery += CRLF + "	DT6.DT6_VALIMP, "
cQuery += CRLF + "	DT6.DT6_VALTOT, "
cQuery += CRLF + "	PEM.R_E_C_N_O_ REGPEM, "
cQuery += CRLF + "	PEM.PEM_COMISS "
	
cQuery += CRLF + " FROM "+RetSQLName('DT6')+" DT6 "

cQuery += CRLF + "INNER JOIN "+RetSQLName('SX5')+" SX5 "
cQuery += CRLF + "	ON DT6.DT6_FILDES		= SX5.X5_CHAVE "

cQuery += CRLF + "INNER JOIN "+RetSQLName('DTC')+" DTC "
cQuery += CRLF + "	ON DT6.DT6_FILDOC		= DTC.DTC_FILDOC "
cQuery += CRLF + "  AND DT6.DT6_DOC		= DTC.DTC_DOC "
cQuery += CRLF + "  AND DT6.DT6_SERIE		= DTC.DTC_SERIE "

cQuery += CRLF + "INNER JOIN "+RetSQLName('SA1')+" A1R "
cQuery += CRLF + "   ON DT6.DT6_CLIREM 	= A1R.A1_COD "
cQuery += CRLF + "  AND DT6.DT6_LOJREM		= A1R.A1_LOJA "

cQuery += CRLF + "INNER JOIN "+RetSQLName('SA1')+" A1D "
cQuery += CRLF + "   ON DT6.DT6_CLIDES 	= A1D.A1_COD "
cQuery += CRLF + "  AND DT6.DT6_LOJDES		= A1D.A1_LOJA "

cQuery += CRLF + " LEFT JOIN "+RetSQLName('PEM')+" PEM "
cQuery += CRLF + "	ON DT6.DT6_FILDOC		= PEM.PEM_FILDOC "
cQuery += CRLF + "  AND DT6.DT6_DOC		= PEM.PEM_NUMDOC "
cQuery += CRLF + "  AND DT6.DT6_SERIE		= PEM.PEM_SERDOC "
cQuery += CRLF + "  AND PEM.D_E_L_E_T_ 	= ' ' "
cQuery += CRLF + "  AND PEM.PEM_FILIAL		= '"+cFilPEM+"' "

If MV_PAR10 == 2 // a pagar
	cQuery += CRLF + "  AND PEM.PEM_STATUS		IN ('1','2') "
	
Elseif MV_PAR10 == 3 // pagos
	cQuery += CRLF + "  AND PEM.PEM_STATUS		= '3' "
		
EndIf

cQuery += CRLF + " LEFT JOIN "+RetSQLName('PEN')+" PEN "
cQuery += CRLF + "   ON PEM.PEM_NUMCOS		= PEN.PEN_NUMCON "
cQuery += CRLF + "  AND PEN.D_E_L_E_T_ 	= ' ' "
cQuery += CRLF + "  AND PEN.PEN_FILIAL		= '"+cFilPEN+"' "
cQuery += CRLF + "  AND PEN.PEN_CODFOR		BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR07+"' "
cQuery += CRLF + "  AND PEN.PEN_LJFORN		BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR08+"' "

cQuery += CRLF + " LEFT JOIN "+RetSQLName('SA2')+" SA2 "
cQuery += CRLF + "   ON PEN.PEN_CODFOR 	= SA2.A2_COD "
cQuery += CRLF + "  AND PEN.PEN_LJFORN		= SA2.A2_LOJA "
cQuery += CRLF + "  AND SA2.A2_FILIAL		= '"+cFilSA2+"' "
cQuery += CRLF + "  AND SA2.D_E_L_E_T_ 	= ' ' "

cQuery += CRLF + "LEFT JOIN "+RetSQLName('DUL')+" DUL "
cQuery += CRLF + "  ON DTC.DTC_CLIDES		= DUL.DUL_CODCLI "
cQuery += CRLF + " AND DTC.DTC_LOJDES		= DUL.DUL_LOJCLI "
cQuery += CRLF + " AND DTC.DTC_SQEDES		= DUL.DUL_SEQEND "
cQuery += CRLF + " AND DUL.DUL_FILIAL		= '"+cFilDUL+"' "
cQuery += CRLF + " AND DUL.D_E_L_E_T_ 	= ' ' "

cQuery += CRLF + "LEFT JOIN "+RetSQLName('PEO')+" PEO "
cQuery += CRLF + "  ON DT6.DT6_FILDOC		= PEO.PEO_FILDOC "
cQuery += CRLF + " AND DT6.DT6_DOC			= PEO.PEO_DOC "
cQuery += CRLF + " AND DT6.DT6_SERIE		= PEO.PEO_SERIE "
If !Empty(MV_PAR01) .And. !Empty(MV_PAR02)	// Verificando Data Geradora
	cQuery += CRLF + "  AND (	(PEO.PEO_DTINCL 	BETWEEN '"+DToS(MV_PAR01)+"' AND '"+DToS(MV_PAR02)+"') "
	cQuery += CRLF + "		 OR	(DT6.DT6_DATEMI 	BETWEEN '"+DToS(MV_PAR01)+"' AND '"+DToS(MV_PAR02)+"')) "
EndIf

cQuery += CRLF + "LEFT JOIN "+RetSQLName('PEG')+" PEG "
cQuery += CRLF + "  ON DT6.DT6_FILDOC		= PEG.PEG_FILDOC "
cQuery += CRLF + " AND DT6.DT6_DOC			= PEG.PEG_NUMDOC "
cQuery += CRLF + " AND DT6.DT6_SERIE		= PEG.PEG_SERDOC "
If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)	// Veriricando Data Vencto.
	cQuery += CRLF + " AND PEG.PEG_DTINCT	BETWEEN '"+DToS(MV_PAR03)+"' AND '"+DToS(MV_PAR04)+"' "
EndIf

cQuery += CRLF + "LEFT JOIN "+RetSQLName('DFV')+" DFV "
cQuery += CRLF + "  ON DT6.DT6_FILDOC		= DFV.DFV_FILDOC "
cQuery += CRLF + " AND DT6.DT6_DOC			= DFV.DFV_DOC "
cQuery += CRLF + " AND DT6.DT6_SERIE		= DFV.DFV_SERIE "
If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)	// Veriricando Data Vencto.
	cQuery += CRLF + " AND DFV.DFV_XDTCTC	BETWEEN '"+DToS(MV_PAR03)+"' AND '"+DToS(MV_PAR04)+"' "
EndIf

cQuery += CRLF + "LEFT JOIN "+RetSQLName('PEZ')+" PEZ "
cQuery += CRLF + "  ON DT6.DT6_FILDOC		= PEZ.PEZ_FILDOC "
cQuery += CRLF + " AND DT6.DT6_DOC			= PEZ.PEZ_NUMDOC "
cQuery += CRLF + " AND DT6.DT6_SERIE		= PEZ.PEZ_SERDOC "
If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)	// Veriricando Data Vencto.
	cQuery += CRLF + " AND PEZ.PEZ_DTINCT	BETWEEN '"+DToS(MV_PAR03)+"' AND '"+DToS(MV_PAR04)+"' "	
EndIf

cQuery += CRLF + "LEFT JOIN "+RetSQLName('PEB')+" PEB "
cQuery += CRLF + "  ON DTC.DTC_FILDOC		= PEB.PEB_FILDOC "
cQuery += CRLF + " AND DTC.DTC_NUMNFC 		= PEB.PEB_NUMNFC "
cQuery += CRLF + " AND DTC.DTC_SERNFC 		= PEB.PEB_SERNFC "
If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)	// Veriricando Data Vencto.
	cQuery += CRLF + " AND PEB.PEB_DTINCT	BETWEEN '"+DToS(MV_PAR03)+"' AND '"+DToS(MV_PAR04)+"' "
EndIf

cQuery += CRLF + "WHERE DT6.D_E_L_E_T_ 	= ' ' "
cQuery += CRLF + "  AND DTC.D_E_L_E_T_ 	= ' ' "
cQuery += CRLF + "  AND A1R.D_E_L_E_T_ 	= ' ' "
cQuery += CRLF + "  AND A1D.D_E_L_E_T_ 	= ' ' "

cQuery += CRLF + "  AND DT6.DT6_FILIAL		= '"+cFilDT6+"' "
cQuery += CRLF + "  AND DTC.DTC_FILIAL		= '"+cFilDTC+"' "
cQuery += CRLF + "  AND A1R.A1_FILIAL		= '"+cFilSA1+"' "
cQuery += CRLF + "  AND A1D.A1_FILIAL		= '"+cFilSA1+"' "

cQuery += CRLF + "  AND SX5.X5_TABELA		= 'M1' "

If MV_PAR09 <> 1
	cQuery += CRLF + "  AND DT6.DT6_SERTMS 	= '"+cValToChar(MV_PAR09)+"'"
EndIf

cQuery += CRLF + "ORDER BY "
cQuery += CRLF + "	SA2.A2_COD, "
cQuery += CRLF + "	DT6.DT6_SERTMS "

//TODO: Retirar o Aviso da query depois dos testes
Aviso(FunName(),cQuery,{"Ok"},3,"Query Executada No Banco De Dados")
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,Changequery(cQuery)),cAlias,.F.,.F.)                                      

END REPORT QUERY oSection1b

/*
 * Montagem do relacionamento na busca de dados de acordo com a quebra do
 * relatório.
 */
oSection2b:SetParentQuery()
oSection2b:SetParentFilter({|cParam| (cAlias)->A2_COD == cParam},{|| (cAlias)->A2_COD})

oSection3b:SetParentQuery()
oSection3b:SetParentFilter({|cParam| (cAlias)->A2_COD+(cAlias)->DT6_SERTMS == cParam},{|| (cAlias)->A2_COD+(cAlias)->DT6_SERTMS })

oSection4b:SetParentQuery()
oSection4b:SetParentFilter({|cParam| (cAlias)->DT6_DOC == cParam},{|| (cAlias)->DT6_DOC })


oSection1b:Print()

Return()


/*/{Protheus.doc} CriaSX1
Funcão para criação do pergunte com os parâmetros para processamento
dos dados para impressão dos Documentos de Acerto de Contas

@Author Wanderley Ramos Neto
@Since 18/09/2014
@Version P11
@Param cPerg Nome do pergunte utilizado
@Project MAN00000180401_EF_801
/*/
Static Function CriaSX1(cPerg)

PutSX1(cPerg,"01","Data Geradora De ?" 	,"","","mv_ch1","D",10,0,0,						"G","","",		"","","mv_par01","","","","","","","","","","","","","","","","",,,,"","","","","","","","")
PutSX1(cPerg,"02","Data Geradora Ate ?"	,"","","mv_ch2","D",10,0,0,						"G","","",		"","","mv_par02","","","","","","","","","","","","","","","","",,,,"","","","","","","","")
PutSX1(cPerg,"03","Data Vencimento De ?" 	,"","","mv_ch3","D",10,0,0,						"G","","",		"","","mv_par03","","","","","","","","","","","","","","","","",,,,"","","","","","","","")
PutSX1(cPerg,"04","Data Vencimento Ate ?"	,"","","mv_ch4","D",10,0,0,						"G","","",		"","","mv_par04","","","","","","","","","","","","","","","","",,,,"","","","","","","","")
PutSX1(cPerg,"05","Cod Fornecedor De ?" 	,"","","mv_ch5","C",TamSX3("A2_COD")[1],0,0,	"G","","SA2",	"","","mv_par05","","","","","","","","","","","","","","","","",,,,"","","","","","","","")
PutSX1(cPerg,"06","Loja De ?" 				,"","","mv_ch6","C",TamSX3("A2_LOJA")[1],0,0,	"G","","",		"","","mv_par06","","","","","","","","","","","","","","","","",,,,"","","","","","","","")
PutSX1(cPerg,"07","Cod Fornecedor Ate ?"	,"","","mv_ch7","C",TamSX3("A2_COD")[1],0,0,	"G","","SA2",	"","","mv_par07","","","","","","","","","","","","","","","","",,,,"","","","","","","","")
PutSX1(cPerg,"08","Loja Ate ?"				,"","","mv_ch8","C",TamSX3("A2_LOJA")[1],0,0,	"G","","",		"","","mv_par08","","","","","","","","","","","","","","","","",,,,"","","","","","","","")
PutSX1(cPerg,"09","Tipo Serviço ?"			,"","","mv_ch9","C",1,0,0,						"C","","",		"","","mv_par09","Todos","","","","Coletas/Devoluções","","","Entregas/Reentregas","","","","","","","","",,,,"","","","","","","","")
PutSX1(cPerg,"10","Status ?" 				,"","","mv_ch10","C",1,0,0,						"C","","",		"","","mv_par10","Ambos","","","","A pagar","","","Pagos","","","","","","","","",,,,"","","","","","","","")
PutSX1(cPerg,"11","Tipo ?" 					,"","","mv_ch11","C",1,0,0,						"C","","",		"","","mv_par11","Sintético","","","","Analítico","","","","","","","","","","","",,,,"","","","","","","","")                                                                                                 			

Return

