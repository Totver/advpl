#include "totvs.ch"
#include "shell.ch"

User Function DTFINR01(cCliente, cTipMsg, cMsg, lJob)
/*/f/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
<Descricao> : Relatorio deCarta de Cobranca em PDF
<Data> : 22/04/2014
<Parametros> : aPerg, lJob
<Retorno> : Nenhum
<Processo> : Emissao Carta de Cobranca PDF
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : R
<Autor> : Eduardo Fernandes
<Obs> :
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
*/
Local oReport	:= NIL
Local cSession  := GetPrinterSession()	
Local cPathPDF  := AllTrim(GetMV("DT_PDFCART",,"/pdfcarta/")) 

Default lJob := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Valida Parametros							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Empty(cCliente) .Or.Empty(cTipMsg) .Or. Empty(cMsg)
	If IsBlind()
		Conout("Parametros não informados, Carta Cobranca PDF nao será criada")
	Else 
		Aviso("Aviso","Parametros não informados, Carta Cobranca PDF nao será criada",{'OK'})	
	Endif		
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao - Tratamento para JOB  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef(cCliente, cTipMsg, cMsg, lJob)	
oReport:cFile:= cCliente+"_"+Dtos(dDatabase)+"_"+StrTran(Time(),":","")

oReport:lPreview := .F. 
oReport:lParamReadOnly := .T.
oReport:cPrinterName:= GetProfString( cSession,"DEFAULT","",.T. )
oReport:nEnvironment := 1
oReport:nDevice := 6 //sempre PDF
oReport:Print(.F.,"", .T.)
//oReport:PrintDialog()	     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Move arquivo /SPOOL/ para /pdf_carta/ ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lJob
	MakeDir(cPathPDF)	// Caso nao exista o diretorio informado, cria-lo
	
	// Se o arquivo for copiado, apaga do diretorio origem
	lCopied := __CopyFile("\spool\"+oReport:cFile+".pdf", cPathPDF+oReport:cFile+".pdf")
	IF lCopied
		FErase("\spool\"+oReport:cFile+".pdf")
	Endif
Endif

Return

Static Function ReportDef(cCliente,cTipMsg,cMsg,lJob)
/*/f/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
<Descricao> : Definição da estrutura do relatório
<Data> : 22/04/2014
<Parametros> : cPerg - Identificação do grupo de perguntas do relatório
<Retorno> : Objeto TReport()
<Processo> : Emissao Carta de Cobranca PDF
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : R
<Autor> : Eduardo Fernandes
<Obs> :
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
*/
Local oReport	:= NIL
Local aOrdem	:= {"Por Numero","Por Produto","Por Centro de Custo","Por Prazo de Entrega"}
Local cTitle	:= "Carta de Cobranca "+IIF(cTipMsg=='1', "", "Judicial")
Local cPerg		:= "DTFINR01"
Local oSecDet   := NIL

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= TReport():New("DTFINR01",cTitle,"DTFINR01", {|oReport| ReportPrint(oReport, cCliente, cTipMsg, cMsg, lJob)},"Emissao Carta de Cobranca",.T.) 
oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
oReport:nFontBody	:= 13 // Define o tamanho da fonte.
oReport:nLineHeight	:= 50 // Define a altura da linha.

oReport:SetEdit(.f.)	// Impede a configuração pelo usuário
oReport:SetPortrait()	// Força a orientação como retrato
oReport:DisableOrientation()	// Impede a mudança na orientação da impressão (retrato / paisagem)
oReport:HideHeader()	// Não imprime o cabeçalho padrão das páginas
oReport:SetLeftMargin(5)
                              
oSecDet := TRSection():New(oReport, "Carta Cobranca", {"Z0I"}, {"Normal", "Judicial"})
TRCell():New(oSecDet, "SISFIE"	, "Z0I", "", /*Picture*/, 122 /*Val(Substr(cTamanho, 001, 3))*/	, /*lPixel*/, {|| "Sistema FIERGS Sistema FIERGS Sistema FIERGS Sistema FIERGS Sistema FIERGS Sistema FIER"}, /*cAlign*/, /*lLineBreak*/, /*cHeaderAlign*/, /*lCellBreak*/, /*03*/, .F., 10526880/*nClrBack*/, /*nClrFore*/, /*lBold*/)

Return(oReport)

Static Function ReportPrint(oReport, cCliente, cTipMsg, cMsg, lJob)
/*/f/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
<Descricao> : Função faz a impressão do relatório
<Data> : 22/04/2014
<Parametros> : oReport - Objeto TReport()
<Retorno> : oReport
<Processo> : Emissao Carta de Cobranca PDF
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : R
<Autor> : Eduardo Fernandes
<Obs> :
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
*/
Local n,nX,nI			
Local oSecDet  	:= oReport:Section(1)
Local nOrdem 	:= oSecDet:GetOrder()
Local nPosSm0	:= SM0->(RecNo())
Local cStart	:= GetSrvProfString("Startpath","")
Local cCabCarta	:= cStart + "carta_fierg.png" 	
Local cAssCtCob	:= cStart + "assinatura_cartacob.png" 	
Local cAssCtJud	:= cStart + "assinatura_cartajud.png" 	
Local nLinI		:= 0  
Local nPUltSpc  := 0
Local oFont07	:= TFont():New("Arial",07,07,,.F.,,,,.T.,.F.)
Local oFont08	:= TFont():New("Arial",08,08,,.T.,,,,.T.,.F.)		//negrito 
Local oFont10	:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
Local oFont10n	:= TFont():New("Arial",10,10,,.T.,,,,.T.,.F.)
Local oFont12	:= TFont():New("Arial",12,12,,.F.,,,,.T.,.F.)		//Normal s/negrito
Local oFont12n	:= TFont():New("Arial",12,12,,.T.,,,,.T.,.F.)		//Negrito
Local oFont13a	:= TFont():New("Arial",13,13,,.F.,,,,.T.,.F.)		//Normal s/negrito
Local oFont13n	:= TFont():New("Arial",13,13,,.T.,,,,.T.,.F.)		//Negrito
Local oFont13 	:= TFont():New("Arial",13,13,,.F.,,,,.T.,.F.)		//Negrito
Local oFont14a	:= TFont():New("Arial",14,14,,.F.,,,,.T.,.F.)		//Normal s/negrito
Local oFont14n	:= TFont():New("Arial",14,14,,.T.,,,,.T.,.F.)		//Normal s/negrito
Local oFont14	:= TFont():New("Courier New",10,10,,.F.,,,,.T.,.F.)
Local oFont15	:= TFont():New("Arial",15,15,,.T.,,,,.T.,.F.)
Local oFont21 	:= TFont():New("Arial",21,21,,.T.,,,,.T.,.T.)
Local oFont16	:= TFont():New("Arial",16,16,,.T.,,,,.T.,.F.)
Local aInfo		:= {}
Local cDesEmp	:= ""
Local cDesEnd	:= ""
Local cDesCid	:= ""
Local cUf	 	:= ""
Local cTpInsc	:= ""
Local cTelef	:= ""
Local cDesCep	:= ""
Local cCgc		:= ""
Local nPos		:= 0
Local cDatExt   := ""

Local nLinhas	:= 0
Local oBrush    := TBrush():New("",CLR_LIGHTGRAY)
Local oBrush1	:= TBrush():New( , CLR_WHITE)  
Local aEnder	:= {"A1_END", "A1_ENDCOB", "A1_BAIRRO", "A1_MUN", "A1_EST", "A1_CEP"}
Local lPdf		:= .T.

If oReport:PrintType # 1
	Aviso("Atenção", "A folha de endereço do destinatário somente será impressa se a saída escolhida for 'PDF'!" + CRLF + CRLF + ;
		"O layout de impressão dos informes de rendimentos poderá também ficar distorcido em outros tipos de saída.", {"Ok"}, 3)
	lPdf	:= .F.
Endif

oReport:SetMeter(1)
oSecDet:Init()

SA1->(dbSetOrder(1))
If SA1->(dbSeek(xFilial("SA1")+cCliente)) 
	aEnder := {SA1->A1_END, SA1->A1_ENDCOB, SA1->A1_BAIRRO, SA1->A1_MUN, SA1->A1_EST, SA1->A1_CEP}
	oReport:IncMeter()
	
	SM0->(DbSeek(cEmpAnt+cFilAnt,.F.))
	fInfo(@aInfo, cFilAnt)
	cDesEmp	:= aInfo[3]
	cDesEnd	:= aInfo[4]
	cDesCid	:= aInfo[5]
	cUf		:= aInfo[6]
	cTpInsc	:= Str(aInfo[15],1)
	cTelef	:= aInfo[10]
	cDesCep	:= ainfo[7]
	cCgc	:= IIF(SA1->A1_PESSOA=='J',Transform(Left(SA1->A1_CGC, 14), "@R 99.999.999/9999-99"),Transform(Left(SA1->A1_CGC, 11), "@R 999999999-99"))
Endif
	
// FOLHA DE ROSTO - POSTAGEM
IF lPdf
	For nI := 1 TO 63
		oSecDet:PrintLine()
	Next nI
	oReport:FillRect( {0450, 0930, 1000, 2350}, oBrush1)
			
	oReport:Box(1175, 0480, 1600, 1900)			
	oReport:FillRect( {1700, 0001, 1900, 2350}, oBrush1)
			
	PrintCep(@oReport, CalcCep(aEnder[6]), 1235, 0549)
			
	//{"A1_END", "A1_ENDCOB", "A1_BAIRRO", "A1_MUN", "A1_EST", "A1_CEP"}
	oReport:Say(1305, 0549, "DESTINATÁRIO:", oFont14a)
	oReport:Say(1350, 0549, Left(SA1->A1_NOME, 60), oFont14a)
			
	oReport:Say(1440, 0549, Left(Alltrim(aEnder[1]), 60), oFont14a)
	oReport:Say(1485, 0549, Left("BAIRRO: " + aEnder[3], 60), oFont14a)
	oReport:Say(1530, 0549, Left(Transform(aEnder[6], "@R 99999-999") + " " + Alltrim(aEnder[4]) + " " + aEnder[5], 60), oFont14a)
			
	oReport:FillRect( {2030, 0001, 2300, 2350}, oBrush1)
	oReport:Say(2050, 1000, "PARA USO DO CORREIO", oFont13n)
	oReport:Box(2080, 0105, 2080, 2310)
			
	oReport:Say(2110, 0120, "|    | Mudou-se", oFont12)
	oReport:Say(2150, 0120, "|    | Endereço insuficiente", oFont12)
	oReport:Say(2190, 0120, "|    | Não existe o número indicado", oFont12)
	oReport:Say(2230, 0120, "|    | Desconhecido", oFont12)
	oReport:Say(2270, 0120, "|    | Recusado", oFont12)
			
	oReport:Say(2110, 0700, "|    | Não procurado", oFont12)
	oReport:Say(2150, 0700, "|    | Ausente", oFont12)
	oReport:Say(2190, 0700, "|    | Falecido", oFont12)
	oReport:Say(2230, 0700, "|    | Informação escrita pelo porteiro/síndico", oFont12)
	oReport:Say(2270, 0700, "|    |", oFont12)
			
	oReport:Say(2110, 1400, "Reintegrado ao serviço postal em ____/____/____", oFont12)
	//oReport:Say(2150, 0700, "|    | Ausente", oFont12)
	oReport:Say(2190, 1400, "Visto do responsável", oFont12)
	//oReport:Say(2230, 0700, "|    | Informação escrita pelo porteiro/síndico", oFont12)
	oReport:Say(2270, 1400, "         Impresso pelo Sistema FIERGS   AJ", oFont12)
			
	//oReport:Box(1175, 0480, 1600, 1900)
	oReport:Box(2500, 0480, 2760, 1900)
	oReport:Say(2530, 0500, "REMETENTE:", oFont14a)
	oReport:Say(2580, 0500, Left(cDesEmp, 55), oFont14a)
	oReport:Say(2630, 0500, Left(cDesEnd, 55), oFont14a)
	oReport:Say(2680, 0500, Left(SM0->M0_BAIRENT, 55), oFont14a)
	oReport:Say(2730, 0500, Left(Transform(cDesCep, "@R 99999-999") + "  " + Alltrim(cDesCid) + "  " + cUf, 55), oFont14a)
			
	oReport:EndPage()
Endif
// FIM DA FOLHA DE ROSTO (POSTAGEM)

// INICIO DA FOLHA DE CARTA
 	nLin	:= 300
	nLinI	:= 180
	
	oReport:StartPage()		
	oReport:Box(nLinI, 0095, nLin + 2500, 2300) 		// box FOLHA 
	
	oReport:SayBitmap(nLin+001, 0750, cCabCarta, 1000, 0200) // Tem que estar abaixo do RootPath   
	oReport:Say(nLin+250, 0780, IIF(cTipMsg=='1',"SERVIÇO NACIONAL APRENDIZAGEM INDUSTRIAL","UNIDADE JURÍDICA DO SISTEMA FIERGS/CIERGS"), oFont14n)				//	ministerio da fazenda 

    cDatExt := "Porto Alegre, "+StrZero(Day(dDatabase),2)+" de "+cMonth(dDatabase)+" de "+AllTrim(Str(Year(dDatabase)))+"." 
	oReport:Say(nLin+375, 0200, cDatExt, oFont13)

	oReport:Say(nLin+510, 0200, "Á", oFont13n)
	oReport:Say(nLin+560, 0200, Left(SA1->A1_NOME, 60), oFont13n)
	oReport:Say(nLin+610, 0200, "CNPJ/CPF "+ cCgc, oFont13n) 
	oReport:Say(nLin+660, 0200, Left(Alltrim(aEnder[1]), 60), oFont13n) 
	oReport:Say(nLin+710, 0200, Alltrim(aEnder[3]), oFont13n) 				
    
	If cTipMsg =='2'
		oReport:Say(nLin+830, 0198, "Assunto: Cobrança Extrajudicial", oFont13)	
	Endif
	
	//BOX do MEMO
	oReport:Box(nLin+900, 0200, nLin+1900, 2200) 		// box FOLHA 
	oReport:FillRect({nLin+0905,0205,nLin+1897,2197},oBrush) //cinza  

	//Remove o CRLF  
	cMsg := StrTran(cMsg, CRLF, " ")
	   
	nDif := 0
	nLin := 1220
	For nI:= 1 to MlCount(cMsg,128,4,.T.)
		//Ajusta quebra linha MEMO
		_cTxt := MemoLine(cMsg,128-nDif,nI,4,.T.)	
	    nPUltSpc := RAT(" ",_cTxt)
		If nPUltSpc > 0 
			_cTxt := Substr(_cTxt,1,nPUltSpc)	
			nDif := IIF(nPUltSpc>0,128-nPUltSpc	,0)	
	    Endif
		oReport:Say(nLin, 220, _cTxt, oFont12)
		nLin += 40
	Next nI
	                                                  
	//Assinaturas
	If cTipMsg =='2'
		oReport:Say(2320, 0200, "Unidade Jurídica do Sistema FIERGS/CIERGS", oFont13n)	
		oReport:SayBitmap(2400, 0250, cAssCtJud, 0700, 0350) // Tem que estar abaixo do RootPath		
		
		//oReport:Say(nLin+0820, 0200, "Unidade Jurídica do Sistema FIERGS/CIERGS", oFont13n)	
		//oReport:SayBitmap(nLin+900, 0250, cAssCtJud, 0700, 0350) // Tem que estar abaixo do RootPath
    Else
		oReport:SayBitmap(2400, 0250, cAssCtCob, 0700, 0350) // Tem que estar abaixo do RootPath    
		//oReport:SayBitmap(nLin+810, 0250, cAssCtCob, 0700, 0350) // Tem que estar abaixo do RootPath    
	Endif
			
	oReport:EndPage()
	// FIM DA FOLHA DE CARTA

oSecDet:Finish()
Return

Static Function PrintCep(oReport, cCep, nLinha, nColuna)
/*/f/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
<Descricao> : Faz a impressão dos bitmaps com a representação gráfica do CEP
<Data> : 06/03/2014
<Parametros> : oReport, cCep, nLinha, nColuna
	oReport	: Objeto de impressão TReport()
	cCep	: Código do CEP a ser impresso
	nLinha	: Número da posição da linha para iniciar a impressão
	nColuna	: Número da posição da coluna para iniciar a impressão
<Retorno> : Nenhum
<Processo> : Emissao Carta de Cobranca PDF
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Autor> : Marcelo Colato
<Obs> : Existe o fonte true type dos correios com a impressão do código de barras do CEP, entretanto, não estava funcionando quando gerava PDF.
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
*/
Local aCodBar	:= {}
Local nI		:= {}
Local cCaract	:= ""
Local cStart	:= GetSrvProfString("Startpath","")

Aadd(aCodBar, cStart + "doit_zero.bmp")
Aadd(aCodBar, cStart + "doit_um.bmp")
Aadd(aCodBar, cStart + "doit_dois.bmp")
Aadd(aCodBar, cStart + "doit_tres.bmp")
Aadd(aCodBar, cStart + "doit_quatro.bmp")
Aadd(aCodBar, cStart + "doit_cinco.bmp")
Aadd(aCodBar, cStart + "doit_seis.bmp")
Aadd(aCodBar, cStart + "doit_sete.bmp")
Aadd(aCodBar, cStart + "doit_oito.bmp")
Aadd(aCodBar, cStart + "doit_nove.bmp")
Aadd(aCodBar, cStart + "doit_barra.bmp")

For nI := 1 To Len(cCep)
	cCaract	:= Substr(cCep, nI, 1)
	If cCaract $ "/\"
		oReport:SayBitmap(nLinha, nColuna, aCodBar[11], 0013, 0036)
		nColuna	+= 11
	ElseIf cCaract $ "0123456789"
		oReport:SayBitmap(nLinha, nColuna, aCodBar[Val(cCaract) + 1], 0066, 0036)
		nColuna	+= 68
	Endif
Next nI
Return

Static Function CalcCep(cCep)
/*/f/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
<Descricao> : Calcula o dígito verificador do CEP para gerar o código de barras dos correios
<Data> : 06/03/2014
<Parametros> : cCep - Código do CEP com 8 dígitos
<Retorno> : Código do CEP com 8 dígitos mais o dígito verificador e as barras de início e final do código
<Processo> : Emissao Carta de Cobranca PDF
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Autor> : Marcelo Colato (copiado de fonte da TOTVS)
<Obs> : 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
*/
Local cRet := ""
Local nDig := 0
Local nX

For nX:=1 to Len(cCep)
	nDig:=nDig+Val(SubStr(cCep,nX,1))
Next nX

nDig := Iif(nDig>9,Val(SubStr(Str(nDig),Len(Str(nDig)),1)),nDig)
nDig := ABS(Iif(nDig==0,nDig,10-nDig))
cRet := "/"+cCep+Alltrim(Str(nDig))+"\"

Return(cRet)

User Function DFINR01V()
/*/f/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
<Descricao>	 : Rotina para controle de versao
<Data>		 : 07/05/2014
<Parametros> : Nenhum
<Retorno>	 : Nenhum
<Processo>	 : Controle de versao
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Autor>		 : Doit Sistemas
<Obs>		 : 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
*/
Return "20140507"