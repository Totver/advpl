#INCLUDE "TOTVS.CH"
#INCLUDE "APWIZARD.CH"

Static MV_FCIVE  := GetNewPar("MV_FCIVE","'6107','6101','6103','6105','6109','6111','6113','6116','6118','6122','6124','6125','6401','6402','6403','6404'")
Static MV_FCIVSP := GetNewPar("MV_FCIVSP","'5101','5118','5122'")
Static MV_FCICL  := GetNewPar("MV_FCICL","'100','110','120','170','190','200','210','220','270','290','300','310','320','370','390','500','510','520','570','590'")

User Function CFISA010
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para manutenÁ„o do cadastro conte˙do de importaÁ„o (CFD)
<Data> : 05/03/2014
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : M
<Autor> : Wagner Mobile Costa
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local aBkp 	 := { 	If(Type("cOkFunc") = "C", cOkFunc, Nil), If(Type("cDelFunc") = "C", cDelFunc, Nil), If(Type("aParam") = "A", aParam, Nil),;
				   	If(Type("xAuto") = "A", xAuto, Nil), If(Type("aNewBtn") = "A", aNewBtn, Nil), If(Type("aRotina") = "A", AClone(aRotina), Nil),;
					If(Type("aMemos") = "A", aMemos, Nil) }
Local bPre   := {|| .T.}
Local bOk    := {|| .T.}
Local bTTS   := {|| .T.}
Local bNoTTS := {|| .T.}

Private aRotina   := { 	{ "Pesquisar","AxPesqui", 0, 1},;
				      	{ "Visualizar","AxCadVis", 0, 2},;
				      	{ "Incluir","AxCadInc", 0, 3},;
				        { "Alterar","U_AxAltCFD", 0, 4},;
						{ "Excluir","AxCadDel", 0, 5},;
						{ "Simular FCI","U_GerCFD(.T.)", 0, 3},;
						{ "Gerar FCI","U_GerCFD(.F.)", 0, 3},;
						{ "Gerar TXT","U_FISA061(1)", 0, 3 },;
						{ "Importar TXT","U_FISA061(2)", 0, 3 } }
Private cOkFunc   := Nil
Private cDelFunc  := "U_VLDCFD('exclus„o')"
Private aParam    := {bPre,bOK,bTTS,bNoTTS}
Private xAuto     := Nil
Private aNewBtn   := Nil
Private cCadastro := "ManutenÁ„o do FCI"

mBrowse( 6, 1,22,75, "CFD")

cOkFunc  := aBkp[1]
cDelFunc := aBkp[2]

aParam := Nil
If ValType(aBkp[3]) = "A"
   aParam := AClone(aBkp[3])
EndIf

xAuto := Nil
If ValType(aBkp[4]) = "A"
   xAuto := AClone(aBkp[4])
EndIf

aNewBtn := Nil
If ValType(aBkp[5]) = "A"
   aNewBtn := AClone(aBkp[5])
EndIf

aRotina := Nil
If ValType(aBkp[6]) = "A"
   aRotina := AClone(aBkp[6])
EndIf

Return

User Function AxAltCFD
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para manutenÁ„o da tabela CFD
<Data> : 05/03/2014
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : M
<Autor> : Wagner Mobile Costa
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

If ! U_VLDCFD("alteraÁ„o")
   Return .F.
EndIF

AxAltera("CFD", CFD->(Recno()), 4)

Return

User Function VLDCFD(cOpcao)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Valida manutenÁ„o de registro na tabela CFD
<Data> : 05/03/2014
<Parametros> : cOpcao = AÁ„o em execuÁ„o
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : M
<Autor> : Wagner Mobile Costa
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local lRet := .T., aArea := GetArea()

If Empty(CFD->CFD_FCICOD)
	Return .T.
EndIf

cQuery := "SELECT COUNT(*) AS COUNT "
cQuery +=  "FROM " + RetSqlName("SD2") + " "
cQuery += "WHERE D_E_L_E_T_ = ' ' AND D2_FILIAL = '" + xFilial("SD2") + "' AND D2_FCICOD = '" + CFD->CFD_FCICOD + "'"

cQuery := ChangeQuery(cQuery)
dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery),"QRY", .F., .T.)
lRet := QRY->COUNT == 0

If ! lRet
	MsgAlert( "Existe(m) " + AllTrim(Str(QRY->COUNT)) + " notas fiscais que utilizaram esta ficha de FCI ! A " + cOpcao + " n„o È permitida !")
EndIf
DbCloseArea()
RestArea(aArea)

Return lRet

User Function GERCFD(lConsulta)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para confirmaÁ„o dos parametros para geraÁ„o da tabela CFD
<Data> : 05/03/2014
<Parametros> : lConsulta = Indica execuÁ„o para consulta do resultado
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : M
<Autor> : Wagner Mobile Costa
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nLinha   	:= 25, lFinish := lUpdate := .F., oFont, oWizard
Local dDataREF 	:= dDataFim := dDataBase, nB9_CM1 := 0, cTexto := cArq := cSX3_CAMPO := ""
Local cMarca  	:= GetMark()	                               		// Marca da MsSelect
Local aCpoBrw 	:= {}, aColsIni := {}, aSeek := {}, aIndex := {}	// Campos da tabela SD2 que serao exibidos na MsSelect
Local aStru     := { { "CFD_OK", "C", 2, 0 } }, nPos := 1
					
DEFINE FONT oFont NAME "Verdana" SIZE 8, 10 BOLD

//-- Parametros
M->B1_COD_I := Space(Len(SB1->B1_COD))
M->B1_COD_F := Repl("Z", Len(SB1->B1_COD))

BuscaCus(dDataRef, @nB9_CM1)

aAdd(aCpoBrw,{"CFD_OK"		,," "	 ," "})
aAdd(aCpoBrw,{"CFD_COD" 	,,"Produto"," "})
aAdd(aCpoBrw,{"B1_DESC"		,,"DescriÁ„o"," "})
aAdd(aCpoBrw,{"CFD_ORIGEM"	,,"Nova Origem"," "})
aAdd(aCpoBrw,{"B1_ORIGEM"	,,"Origem Atual"," "})
aAdd(aCpoBrw,{"CFD_PERVEN"	,,RetTitle("CFD_PERVEN"),PesqPict("CFD","CFD_PERVEN")})
aAdd(aCpoBrw,{"CFD_VPARIM"	,,RetTitle("CFD_VPARIM"),PesqPict("CFD","CFD_VPARIM")})
aAdd(aCpoBrw,{"CFD_VSAIIE"	,,RetTitle("CFD_VSAIIE"),PesqPict("CFD","CFD_VSAIIE")})
aAdd(aCpoBrw,{"CFD_CONIMP"	,,RetTitle("CFD_CONIMP"),PesqPict("CFD","CFD_CONIMP")})
aAdd(aCpoBrw,{"FATURADO"	,,"Faturado ?",""})

SX3->(DbSetOrder(2))
For nPos := 2 To Len(aCpoBRW)
	If aCpoBRW[nPos][1] == "CFD_ORIGEM"
		AADD(aStru,{"CFD_ORIGEM","C",1,0})
	ElseIf aCpoBRW[nPos][1] == "FATURADO"
		AADD(aStru,{"FATURADO","C",3,0})
	Else
		If Len(aCpoBRW[nPos]) > 4
			SX3->(DbSeek(Left(aCpoBRW[nPos][5] + Space(Len(SX3->X3_CAMPO)), Len(SX3->X3_CAMPO))))
		Else
			SX3->(DbSeek(Left(aCpoBRW[nPos][1] + Space(Len(SX3->X3_CAMPO)), Len(SX3->X3_CAMPO))))
		EndIf
		AADD(aStru,{aCpoBRW[nPos][1],SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	EndIf
Next

cArq := Criatrab(aStru,.T.)
DbUseArea(.t.,, cArq, "TRB")

DEFINE WIZARD oWizard ;
	TITLE cCadastro;
	HEADER If(lConsulta, "HistÛrico da Ficha de Conteudo de ImportaÁ„o", "GeraÁ„o da Ficha de Conteudo de ImportaÁ„o");
	MESSAGE "";
	TEXT 	"Esta rotina tem como objetivo a geraÁ„o das fichas de conte˙do de importaÁ„o." + Chr(13) + Chr(10) +;
			"Ser· utilizada a data de referencia informada como base para: " + Chr(13) + Chr(10) +;
			"a) Produtos que j· tenham vendas realizadas fora do estado ser„o consideradas todas as notas fiscais" + Chr(13) + Chr(10) +;
			"realizadas no penultimo mÍs;" + Chr(13) + Chr(10) +;
			"b) Produtos que j· tenham vendas realizadas dentro do estado ser„o consideradas todas as notas" + Chr(13) + Chr(10) +;
			"fiscais realizadas no mes da data de referencia;" + Chr(13) + Chr(10) +;
			"c) Produtos que ainda n„o tenha nenhuma venda realizada ser„o considerado os pedidos com CFOPS" + Chr(13) + Chr(10) +;
			"acima incluidos no mÍs da data de referencia." + Chr(13) + Chr(10) +;
			Chr(13) + Chr(10) +; 
			"Somente ser„o geradas fichas de produtos com variaÁ„o entre 40% a 70%;" + Chr(13) + Chr(10) +;
			"Para produtos que j· tenham uma ficha anterior gerada, ser· gerada novamente qunado a variaÁ„o do " + Chr(13) + Chr(10) +;
			"conte˙do de importaÁ„o for superior ou inferior em 5% da ficha existente." + Chr(13) + Chr(10) +;
			Chr(13) + Chr(10) +; 
			"Cfops Fora : " + Chr(13) + Chr(10) +StrTran(MV_FCIVE, "'", "") + Chr(13) + Chr(10) +; 
			"Cfops Dentro: " + Chr(13) + Chr(10) +StrTran(MV_FCIVSP, "'", "");	
	NEXT {|| .T. };
	FINISH {|| .F. }

CREATE PANEL oWizard  ;
	HEADER "SeleÁ„o dos parametros para geraÁ„o das FICHAS";
	MESSAGE "";
	BACK {|| .T. } ;
	NEXT {|| (If(lUpdate .Or. lConsulta, MsAguarde({|| QryTrb(dDataREF, dDataFIM, nB9_CM1, lUpdate, lConsulta)},cCadastro, "Selecionando os produtos. Aguarde....", .T.),;
										 oWizard:SetPanel(3)), .T.) };
	FINISH {|| .F. }
	oWizard:GetPanel(2)
	
	If lConsulta
		@ nLinha + 00,010 	SAY "Data Inicial e Final" 	FONT oFont PIXEL OF oWizard:oMPanel[2]
		@ nLinha - 05,080 	MSGET oDataREF   	        VAR dDataREF SIZE 40, 15 PIXEL OF oWizard:oMPanel[2] PICTURE "@D";
							VALID BuscaCus(dDataRef, @nB9_CM1)
		@ nLinha - 05,120 	MSGET oDataFIM   	        VAR dDataFIM SIZE 40, 15 PIXEL OF oWizard:oMPanel[2] PICTURE "@D";
							VALID dDataFim >= dDataRef
	Else
		@ nLinha + 00,010 	SAY "Data Referencia"      	FONT oFont PIXEL OF oWizard:oMPanel[2]
		@ nLinha - 05,080 	MSGET oDataREF   	        VAR dDataREF SIZE 50, 15 PIXEL OF oWizard:oMPanel[2] PICTURE "@D";
							VALID BuscaCus(dDataRef, @nB9_CM1)
	EndIf
	@ nLinha + 00,165 	SAY "Custo MP Importada"   	FONT oFont PIXEL OF oWizard:oMPanel[2]
	@ nLinha - 05,240 	MSGET oB9_CM1    	        VAR nB9_CM1 SIZE 50, 15 PIXEL OF oWizard:oMPanel[2] PICTURE PesqPict("SB9","B9_CM1")
	nLinha += 25

	@ nLinha + 00,010 	SAY "Produto Inicial"      	FONT oFont PIXEL OF oWizard:oMPanel[2]
	@ nLinha - 05,080 	MSGET oB1_COD_I 	        VAR M->B1_COD_I PIXEL OF oWizard:oMPanel[2] PICTURE PesqPict("SB1","B1_COD") F3 "SB1"

	nLinha += 25

	@ nLinha + 00,010 	SAY "Produto Final" 	    FONT oFont PIXEL OF oWizard:oMPanel[2]
	@ nLinha - 05,080 	MSGET oB1_COD_F   	      	VAR M->B1_COD_F PIXEL OF oWizard:oMPanel[2] PICTURE PesqPict("SB1","B1_COD") F3 "SB1"
	nLinha += 25

	@ nLinha,020  		SAY "Atualizar a origem do produto baseado no calculo do percentual da importaÁ„o ?";
						OF oWizard:GetPanel(2) PIXEL
	@ nLinha,010  		CHECKBOX oUpdate VAR lUpdate;
						SIZE 8,8 PIXEL OF oWizard:GetPanel(2) 

CREATE PANEL oWizard  ;
	HEADER If(lConsulta, "HistÛrico de calculo para FCI", "AtualizaÁ„o da Origem do Produto");
	MESSAGE "";
	BACK {|| .T. } ;
	NEXT {|| .T. };
	FINISH {|| .F. }
	oWizard:GetPanel(3)

	DbSelectArea("TRB")
	If .F. // MBrowse
		// Colunas
		For nPos := 2 To Len(aCpoBrw)
			If aCpoBRW[nPos][1] == "CFD_ORIGEM"
				cSX3_CAMPO := "B1_ORIGEM"
			Else
				cSX3_CAMPO := aCpoBRW[nPos][If(Len(aCpoBRW[nPos]) > 4, 5, 1)]
			EndIf
		
			SX3->(DbSeek(Left(cSX3_CAMPO + Space(Len(SX3->X3_CAMPO)), Len(SX3->X3_CAMPO))))
			Aadd(aColsIni, { SX3->X3_TITULO, SX3->X3_CAMPO, SX3->X3_TIPO, SX3->X3_TAMANHO,SX3->X3_DECIMAL, SX3->X3_PICTURE })
		Next 

		Aadd( aSeek, { 	AllTrim(aColsIni[2][1])+' + '+AllTrim(aColsIni[6][1]),;
						{ 	{"",aColsIni[2][3],aColsIni[2][4],aColsIni[2][5],aColsIni[2][1],,} ,;
							{"",aColsIni[6][3],aColsIni[6][4],aColsIni[2][6],aColsIni[6][1],,} },1  } )
		Aadd( aSeek, { 	AllTrim(aColsIni[6][1])+' + '+AllTrim(aColsIni[2][1]),;
						{ 	{"",aColsIni[6][3],aColsIni[6][4],aColsIni[2][6],aColsIni[6][1],,},;
							{"",aColsIni[2][3],aColsIni[2][4],aColsIni[2][5],aColsIni[2][1],,} },1  } )
		Aadd( aIndex, "CFD_PERVEN + CFD_COD" )
		Aadd( aIndex, "CFD_COD + CFD_PERVEN" )

		// Cria o arquivo de indice para a tabela temporaria
		For nPos := 1 to len(aIndex)
		  IndRegua("TRB", cArq + Str(nPos, 1), aIndex[nPos],,,'...')
		Next nI

		dbClearIndex()

		For nPos := 1 to len(aIndex)
		  dbSetIndex(cArq + Str(nPos, 1) + OrdBagExt())
		Next nI

		oBrowse := FWMBrowse():New()
		oBrowse:SetOwner(oWizard:GetPanel(3))
		oBrowse:SetAlias("TRB")
	
		oBrowse:SetQueryIndex(aIndex)
	   	oBrowse:SetTemporary(.T.)
	   	oBrowse:SetSeek(,aSeek)
	
		oBrowse:SetFields(aColsIni)
		oBrowse:SetProfileID('1')
		oBrowse:DisableDetails()
		oBrowse:SetFixedBrowse(.T.)
		oBrowse:SetDescription("HistÛrico")
		oBrowse:ForceQuitButton()
		oBrowse:SetWalkThru(.F.)
		oBrowse:SetAmbiente(.F.)
		
		oBrowse:Activate()
	Else
		Aadd( aIndex, "CFD_COD + CFD_PERVEN" )

		// Cria o arquivo de indice para a tabela temporaria
		For nPos := 1 to len(aIndex)
		  IndRegua("TRB", cArq + Str(nPos, 1), aIndex[nPos],,,'...')
		Next nI

		dbClearIndex()

		For nPos := 1 to len(aIndex)
		  dbSetIndex(cArq + Str(nPos, 1) + OrdBagExt())
		Next nI

		oMark := MsSelect():New("TRB","CFD_OK",,aCpoBrw,.F.,@cMarca,{05,02,135,295},"TRB->(DbGotop())","TRB->(DbGoBottom())",oWizard:GetPanel(3))
		oMark:bAval := {|| CFDMark(@cMarca) }					//Funcao de execucao quando marca ou desmarca
		oMark:oBrowse:bAllMark := {|| CFDMarkAll(cMarca)}
		oMark:oBrowse:lhasMark    := .T.
	EndIf

CREATE PANEL oWizard  ;
	HEADER "GeraÁ„o das fichas de conte˙do de importaÁ„o";
	MESSAGE "";
	BACK {|| (oWizard:SetPanel(If(! lUpdate .And. ! lConsulta, 3, 4)), .T.) } ;
	NEXT {|| .F. };
	FINISH {|| lFinish := .T. }
	oWizard:GetPanel(4)

	If lConsulta
		cTexto := "A tela anterior apresentou o resultado do histÛrico de calculo dos produtos informados para visualizaÁ„o" + Chr(13) + Chr(10) +;
				  "de resultados para o FCI. "
	Else
		cTexto := "De acordo com os parametros selecionados na tela anterior, ser„o geradas as fichas. " + Chr(13) + Chr(10) +;
			   	  "Favor clicar no bot„o FINALIZAR para que o processamento seja iniciado ... "
	EndIf
	
	@ 010,010 GET cTexto MEMO SIZE 270, 115 READONLY PIXEL OF oWizard:oMPanel[4]

ACTIVATE WIZARD oWizard CENTERED

If lFinish .And. lUpdate 
	DbSelectArea("TRB")
	Set Filter To ! Empty(CFD_ORIGEM)
	DbGotop()
	If ! TRB->(Eof()) .And. MsgYesNo("Confirma a atualizaÁ„o da origem dos produtos selecionados ?")
		MsAguarde({|| UpdSB1(cMarca)},cCadastro, "Atualizando origem do Produto. Aguarde....", .T.)
	EndIf

	Set Filter To
	DbGoTop()
EndIf

TRB->(DbCloseArea())
Iif(File(cArq + GetDBExtension()),FErase(cArq  + GetDBExtension()) ,Nil)

If ! lConsulta
	If lFinish
		MsAguarde({|| SelFCI(dDataREF, nB9_CM1)},cCadastro, "Selecionando os produtos. Aguarde....", .T.)
	EndIf
EndIf

Return

Static Function BuscaCus(dDataRef, nB9_CM1)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para busca do custo da materia prima
<Data> : 07/03/2014
<Parametros> : dDataREF = DataBase para processamento e nB9_CM1 = Variavel com o custo do produto importado
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : M
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local dData := FirstDay(dDataRef) - 1, cB9_COD := SuperGetMV("ES_MPFCIP", ,"00000000001"), cB9_LOCAL := SuperGetMV("ES_MPFCIL", ,"01")

SB9->(DbSeek(xFilial() + Left(cB9_COD + Space(Len(SB9->B9_COD)), Len(SB9->B9_COD)) + cB9_LOCAL + Dtos(dData), .T.))
If SB9->B9_COD <> cB9_COD
	SB9->(DbSkip(-1))
EndIf

If SB9->B9_COD = cB9_COD .AND. SB9->B9_DATA < dDataRef
	nB9_CM1 := SB9->B9_CM1
EndIf								

Return .T.

Static Function UpdSB1(cMark)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para atualizaÁ„o da origem do produto
<Data> : 05/03/2014
<Parametros> : cMark = IdentificaÁ„o de marcaÁ„o do registro
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : M
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nUpd := 0

DbSelectArea("TRB")
TRB->(DbGoTop())

While ! TRB->(Eof())
	If TRB->CFD_OK = cMark
		SB1->(DbSeek(xFilial() + TRB->CFD_COD))
		SB1->(RecLock("SB1", .F.))
		SB1->B1_ORIGEM := TRB->CFD_ORIGEM
		SB1->(MsUnLock())

		nUpd ++
	EndIf
	
	TRB->(DbSkip())
EndDo

MsgInfo("Foram atualizado(s) " + AllTrim(Str(nUpd)) + " origem(s) de produto(s) !")

Return

Static Function SelFCI(dDataREF, nB9_CM1)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para geraÁ„o da tabela CFD
<Data> : 05/03/2014
<Parametros> : dDataREF = DataBase para processamento e nB9_CM1 = Custo da Materia Prima Importada
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : M
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local aArea := GetArea(), nGerados := 0
Local cConImpSQL := "and " + ConImpSQL() + " > 40 and " + ConImpSQL() + " < 70.01"

QryFCI(dDataREF, Ctod(""), nB9_CM1, .F., cConImpSQL)

While ! Eof()
	MsProcTxt("Gerando FCI do produto [" + QRY->CFD_COD + "] ...")
	ProcessMessage()

	BeginTran()
	RecLock("CFD", .T.)
	CFD->CFD_FILIAL  := xFilial("CFD")
	CFD->CFD_PERCAL  := StrZero(Month(dDataRef), 2) + StrZero(Year(dDataRef), 4)
	CFD->CFD_PERVEN  := QRY->CFD_PERVEN
	CFD->CFD_COD     := QRY->CFD_COD
	CFD->CFD_VPARIM  := QRY->CFD_VPARIM
	CFD->CFD_VSAIIE  := QRY->CFD_VSAIIE
	CFD->CFD_CONIMP  := If(QRY->CFD_CONIMP > 100, 100, QRY->CFD_CONIMP)
	If CFD->(FieldPos("CFD_ORIGEM")) > 0
		CFD->CFD_ORIGEM  := QRY->CFD_ORIGEM
	EndIf
    CFD->CFD_FILOP   := xFilial("CFD")   
    CFD->(MsUnLock())
	EndTran()    

	nGerados ++
	DbSelectArea("QRY")
	DbSkip()
EndDo

DbCloseArea()
RestArea(aArea)

If nGerados > 0
	MsgInfo("Foram gerado(s) " + AllTrim(Str(nGerados)) + " com sucesso !")
Else 
	MsgInfo("N„o existe nenhum FCI a ser gerado com os parametros informados !")
EndIf

Return

Static Function QryFCI(dDataREF, dDataFim, nB9_CM1, lConsulta, cCplQuery)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Seleciona fichas de FCI a serem geradas
<Data> : 12/03/2014
<Parametros> : dDataREF = Data de referencia para geraÁ„o das fichas, dDataFim = Data Final para consulta da FCI, nB9_CM1 = Variavel com o custo do produto
               importado, lConsulta = OpÁ„o de simulaÁ„o do calculo do FCI e cCplQuery = Query complementar de acordo com a chamada
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : M
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local cQuery     := "", dFirstDay := FirstDay(dDataREF), dLastDay := LastDay(dDataREF)
Local dPerFCI    := MonthSub(dFirstDay, 2)
Local dPerFCII   := FirstDay(dPerFCI), dPerFCIF := LastDay(dPerFCI)
Local cD2_SAISQL := "(SUM((SD2.D2_PRCVEN - (SD2.D2_PRCVEN * (SD2.D2_PICM / 100)) - (SD2.D2_PRCVEN * (SD2.D2_IPI / 100)))) / COUNT(*))"
Local cCustoSQL  := "MIN((SB1.B1_YPPECA * (SB1.B1_YQTDAG / 100)) * " + AllTrim(Str(nB9_CM1)) + ")"
Local cPERVENSQL := "case when SD2.VENDAS > 0 " + Chr(13) + Chr(10) +;
                    "then case when SD2_U.CFD_VSAIIE > 0 then SD2_U.CFD_PERVEN else SD2_P.CFD_PERVEN end " + Chr(13) + Chr(10) +;
                    "else SC6_V.CFD_PERVEN end"
Local cVPARIMSQL := "case when SD2.VENDAS > 0 AND " + cPERVENSQL + " > 0 " + Chr(13) + Chr(10) +;
                    "then case when SD2_U.CFD_VSAIIE > 0 then SD2_U.CFD_VPARIM else SD2_P.CFD_VPARIM end " + Chr(13) + Chr(10) +;
                    "else SC6_V.CFD_VPARIM end"
Local cVSAIIESQL := "case when SD2.VENDAS > 0 " + Chr(13) + Chr(10) +;
                    "then case when SD2_U.CFD_VSAIIE > 0 then SD2_U.CFD_VSAIIE else SD2_P.CFD_VSAIIE end " + Chr(13) + Chr(10) +;
                    "else case when SC6_V.CFD_VSAIIE > 0 then SC6_V.CFD_VSAIIE / SC6_V.CFD_QSAIIE else SC6_V.CSP_VSAIIE / SC6_V.CSP_QSAIIE end end"
Local cCONIMPSQL := ConImpSQL()

MsProcTxt("Selecionando os produtos [" + StrZero(Month(dDataRef), 2) + "/" + StrZero(Year(dDataRef), 4) + "]...")
ProcessMessage()

If lConsulta
	dFirstDay := FirstDay(dDataREF)
	dLastDay  := LastDay(dDataREF)
	dPerFCII  := FirstDay(dDataREF)
	dPerFCIF  := LastDay(dDataREF)
EndIf

cQuery := "select SB1.B1_COD AS CFD_COD, SB1.B1_DESC, SB1.B1_ORIGEM AS CFD_ORIGEM, "
cQuery += 		  "CASE WHEN COALESCE(SD2_U.CFD_VSAIIE, 0) + COALESCE(SD2_P.CFD_VSAIIE, 0) > 0 THEN 'Sim' ELSE 'Nao' END AS FATURADO, "
cQuery += 		  cPERVENSQL + " as CFD_PERVEN, " + cVPARIMSQL + " as CFD_VPARIM, " + cVSAIIESQL + " as CFD_VSAIIE, " 
cQuery += 		  cCONIMPSQL + " as CFD_CONIMP " 
cQuery +=   "from " + RetSqlName("SB1") + " SB1 " + Chr(13) + Chr(10)
cQuery +=   "left join (select SD2.D2_COD, count(*) as VENDAS from " + RetSqlName("SD2") + " SD2 " + Chr(13) + Chr(10)
cQuery +=   "join " + RetSqlName("SB1") + " SB1 on SB1.D_E_L_E_T_ = ' ' and SB1.B1_FILIAL = '" + xFilial("SB1") + "' " + Chr(13) + Chr(10)
cQuery +=    "and SB1.B1_COD = SD2.D2_COD and SB1.B1_COD BETWEEN '" + M->B1_COD_I + "' AND '" + M->B1_COD_F + "' " + Chr(13) + Chr(10)
cQuery +=    "and SB1.B1_ORIGEM + '00' in (" + MV_FCICL + ") and SB1.B1_YPPECA > 0 and SB1.B1_YQTDAG > 0 " + Chr(13) + Chr(10)
cQuery +=  "where SD2.D_E_L_E_T_ = ' ' and SD2.D2_FILIAL = '" + xFilial("SD2") + "' " + Chr(13) + Chr(10)
cQuery +=    "and SD2.D2_COD BETWEEN '" + M->B1_COD_I + "' and '" + M->B1_COD_F + "' " + Chr(13) + Chr(10)
cQuery +=    "and SD2.D2_CLASFIS in (" + MV_FCICL + ") and (SD2.D2_CF in (" + MV_FCIVE + ") " + Chr(13) + Chr(10)
cQuery +=                                               "or SD2.D2_CF in (" + MV_FCIVSP + ")) " + Chr(13) + Chr(10)
cQuery += "group by SD2.D2_COD) SD2 on SD2.D2_COD = SB1.B1_COD " + Chr(13) + Chr(10)
cQuery +=   "left join (select SD2.D2_COD, SUBSTRING(SD2.D2_EMISSAO, 5, 2) + SUBSTRING(SD2.D2_EMISSAO, 1, 4) AS CFD_PERVEN, " + Chr(13) + Chr(10)
cQuery +=                     "ROUND(" + cCustoSQL + ", 2) AS CFD_VPARIM, " + Chr(13) + Chr(10)
cQuery +=                     "ROUND(" + cD2_SAISQL + ", 2) AS CFD_VSAIIE, " + Chr(13) + Chr(10)
cQuery +=                     "ROUND(((" + cCustoSQL + ") / (" + cD2_SAISQL + ")) * 100, 2) AS CFD_CONIMP " + Chr(13) + Chr(10)
cQuery +=                "from " + RetSqlName("SD2") + " SD2 " + Chr(13) + Chr(10)
cQuery +=                "join " + RetSqlName("SB1") + " SB1 on SB1.D_E_L_E_T_ = ' ' and SB1.B1_FILIAL = '" + xFilial("SB1") + "' " + Chr(13) + Chr(10)
cQuery +=                 "and SB1.B1_COD = SD2.D2_COD and SB1.B1_COD BETWEEN '" + M->B1_COD_I + "' AND '" + M->B1_COD_F + "' " + Chr(13) + Chr(10)
cQuery +=                 "and SB1.B1_ORIGEM + '00' in (" + MV_FCICL + ") and SB1.B1_YPPECA > 0 and SB1.B1_YQTDAG > 0 " + Chr(13) + Chr(10)
cQuery +=               "where SD2.D_E_L_E_T_ = ' ' and SD2.D2_FILIAL = '" + xFilial("SB1") + "' and SD2.D2_COD BETWEEN '" + M->B1_COD_I + "' and '" + M->B1_COD_F + "' " + Chr(13) + Chr(10)
cQuery +=                 "and SD2.D2_CLASFIS in (" + MV_FCICL + ") and SD2.D2_CF in (" + MV_FCIVE + ") " + Chr(13) + Chr(10)
cQuery +=                 "and SD2.D2_EMISSAO BETWEEN '" + Dtos(dPerFCII) + "' and '" + Dtos(dPerFCIF) + "' " + Chr(13) + Chr(10)
cQuery +=               "group by SD2.D2_COD, SUBSTRING(SD2.D2_EMISSAO, 5, 2) + SUBSTRING(SD2.D2_EMISSAO, 1, 4)) SD2_U on SD2_U.D2_COD = SB1.B1_COD " + Chr(13) + Chr(10)
cQuery +=   "left join (select SD2.D2_COD, SUBSTRING(SD2.D2_EMISSAO, 5, 2) + SUBSTRING(SD2.D2_EMISSAO, 1, 4) AS CFD_PERVEN, " + Chr(13) + Chr(10)
cQuery +=                     "ROUND(" + cCustoSQL + ", 2) AS CFD_VPARIM, " + Chr(13) + Chr(10)
cQuery +=                     "ROUND(" + cD2_SAISQL + ", 2) AS CFD_VSAIIE, " + Chr(13) + Chr(10)
cQuery +=                     "ROUND(((" + cCustoSQL + ") / (" + cD2_SAISQL + ")) * 100, 2) AS CFD_CONIMP " + Chr(13) + Chr(10)
cQuery +=                "from " + RetSqlName("SD2") + " SD2 " + Chr(13) + Chr(10)
cQuery +=                "join " + RetSqlName("SB1") + " SB1 on SB1.D_E_L_E_T_ = ' ' and SB1.B1_FILIAL = '" + xFilial("SB1") + "' " + Chr(13) + Chr(10)
cQuery +=                 "and SB1.B1_COD = SD2.D2_COD and SB1.B1_COD BETWEEN '" + M->B1_COD_I + "' AND '" + M->B1_COD_F + "' " + Chr(13) + Chr(10)
cQuery +=                 "and SB1.B1_ORIGEM + '00' in (" + MV_FCICL + ") and SB1.B1_YPPECA > 0 and SB1.B1_YQTDAG > 0 " + Chr(13) + Chr(10)
cQuery +=               "where SD2.D_E_L_E_T_ = ' ' and SD2.D2_FILIAL = '" + xFilial("SB1") + "' and SD2.D2_COD BETWEEN '" + M->B1_COD_I + "' and '" + M->B1_COD_F + "' " + Chr(13) + Chr(10)
cQuery +=                 "and SD2.D2_CLASFIS in (" + MV_FCICL + ") and SD2.D2_CF in (" + MV_FCIVSP + ") " + Chr(13) + Chr(10)
cQuery +=                 "and SD2.D2_EMISSAO BETWEEN '" + Dtos(dFirstDay) + "' and '" + Dtos(dLastDay) + "' " + Chr(13) + Chr(10)
cQuery +=               "group by SD2.D2_COD, SUBSTRING(SD2.D2_EMISSAO, 5, 2) + SUBSTRING(SD2.D2_EMISSAO, 1, 4)) SD2_P on SD2_P.D2_COD = SB1.B1_COD " + Chr(13) + Chr(10)
cQuery +=   "left join (select SC6.C6_PRODUTO, SUBSTRING(SC5.C5_EMISSAO, 5, 2) + SUBSTRING(SC5.C5_EMISSAO, 1, 4) AS CFD_PERVEN, "  + Chr(13) + Chr(10)
cQuery +=                     "ROUND(" + cCustoSQL + ", 2) AS CFD_VPARIM, " + Chr(13) + Chr(10)
cQuery +=               "ROUND(SUM(CASE WHEN SC6.C6_CF in (" + MV_FCIVE + ") THEN SC6.C6_VALOR ELSE 0 END), 2) AS CFD_VSAIIE, " + Chr(13) + Chr(10)
cQuery +=               "ROUND(SUM(CASE WHEN SC6.C6_CF in (" + MV_FCIVE + ") THEN SC6.C6_QTDVEN ELSE 0 END), 2) AS CFD_QSAIIE, " + Chr(13) + Chr(10)
cQuery +=                   "COUNT(CASE WHEN SC6.C6_CF in (" + MV_FCIVE + ") THEN 1 ELSE NULL END) AS CFD_QTDIMP, " + Chr(13) + Chr(10)
cQuery +=               "ROUND(MIN((SB1.B1_YPPECA * (SB1.B1_YQTDAG / 100)) * " + AllTrim(Str(nB9_CM1)) + "), 2) AS CSP_VPARIM, " + Chr(13) + Chr(10)
cQuery +=               "ROUND(SUM(CASE WHEN SC6.C6_CF in (" + MV_FCIVSP + ") THEN SC6.C6_VALOR ELSE 0 END), 2) AS CSP_VSAIIE, " + Chr(13) + Chr(10)
cQuery +=               "ROUND(SUM(CASE WHEN SC6.C6_CF in (" + MV_FCIVSP + ") THEN SC6.C6_QTDVEN ELSE 0 END), 2) AS CSP_QSAIIE, " + Chr(13) + Chr(10)
cQuery +=                   "COUNT(CASE WHEN SC6.C6_CF in (" + MV_FCIVSP + ") THEN 1 ELSE NULL END) AS CSP_QTDIMP " + Chr(13) + Chr(10)
cQuery +=                "from " + RetSqlName("SC6") + " SC6 " + Chr(13) + Chr(10)
cQuery +=                "join " + RetSqlName("SC5") + " SC5 on SC5.D_E_L_E_T_ = ' ' and SC5.C5_FILIAL = SC6.C6_FILIAL and SC5.C5_NUM = SC6.C6_NUM " + Chr(13) + Chr(10)
cQuery +=                 "and SC5.C5_EMISSAO BETWEEN '" + Dtos(dFirstDay) + "' and '" + Dtos(dLastDay) + "' " + Chr(13) + Chr(10)
cQuery +=                "join " + RetSqlName("SB1") + " SB1 on SB1.D_E_L_E_T_ = ' ' and SB1.B1_FILIAL = '" + xFilial("SB1") + "' " + Chr(13) + Chr(10)
cQuery +=                 "and SB1.B1_COD = SC6.C6_PRODUTO and SB1.B1_COD BETWEEN '" + M->B1_COD_I + "' AND '" + M->B1_COD_F + "' " + Chr(13) + Chr(10)
cQuery +=                 "and SB1.B1_ORIGEM + '00' in (" + MV_FCICL + ") and SB1.B1_YPPECA > 0 and SB1.B1_YQTDAG > 0 " + Chr(13) + Chr(10)
cQuery +=               "where SC6.D_E_L_E_T_ = ' ' and SC6.C6_FILIAL = '" + xFilial("SB1") + "' and SC6.C6_PRODUTO BETWEEN '" + M->B1_COD_I + "' and '" + M->B1_COD_F + "' " + Chr(13) + Chr(10)
cQuery +=                 "and SC6.C6_CLASFIS in (" + MV_FCICL + ") and (SC6.C6_CF in (" + MV_FCIVE + ") " + Chr(13) + Chr(10)
cQuery +=                                                            "or SC6.C6_CF in (" + MV_FCIVSP + ")) " + Chr(13) + Chr(10)
cQuery +=               "group by SC6.C6_PRODUTO, SUBSTRING(SC5.C5_EMISSAO, 5, 2) + SUBSTRING(SC5.C5_EMISSAO, 1, 4)) SC6_V on SC6_V.C6_PRODUTO = SB1.B1_COD " + Chr(13) + Chr(10)
If ! lConsulta
	cQuery +=   "left join " + RetSqlName("CFD") + " CFD on CFD.D_E_L_E_T_ = ' ' and CFD.CFD_FILIAL = '" + xFilial("CFD") + "' " + Chr(13) + Chr(10)
	cQuery +=    "and CFD.CFD_PERCAL = '" + StrZero(Month(dDataRef), 2) + StrZero(Year(dDataRef), 4) + "' " + Chr(13) + Chr(10)
	cQuery +=    "and CFD.CFD_PERVEN = COALESCE(SD2_U.CFD_PERVEN, SD2_P.CFD_PERVEN, SC6_V.CFD_PERVEN) " + Chr(13) + Chr(10)
	cQuery +=    "and CFD.CFD_COD = SB1.B1_COD " + Chr(13) + Chr(10)
	cQuery +=   "left join (select CFD.CFD_COD, CFD.CFD_CONIMP from " + RetSqlName("CFD") + " CFD " + Chr(13) + Chr(10)
	cQuery +=                "join " + RetSqlName("SB1") + " SB1 on SB1.D_E_L_E_T_ = ' ' and SB1.B1_FILIAL = '" + xFilial("SB1") + "' " + Chr(13) + Chr(10)
	cQuery +=                 "and SB1.B1_COD = CFD.CFD_COD and SB1.B1_COD BETWEEN '" + M->B1_COD_I + "' AND '" + M->B1_COD_F + "' " + Chr(13) + Chr(10)
	cQuery +=                 "and SB1.B1_ORIGEM + '00' in (" + MV_FCICL + ") and SB1.B1_YPPECA > 0 and SB1.B1_YQTDAG > 0 " + Chr(13) + Chr(10)
	cQuery +=               "where CFD.D_E_L_E_T_ = ' ' and CFD.CFD_FILIAL = '" + xFilial("CFD") + "' " + Chr(13) + Chr(10)
	cQuery +=                 "and CFD.CFD_COD BETWEEN '" + M->B1_COD_I + "' and '" + M->B1_COD_F + "' " + Chr(13) + Chr(10)
	cQuery +=                 "and CFD.CFD_COD + SUBSTRING(CFD.CFD_PERCAL, 3, 4) + SUBSTRING(CFD.CFD_PERCAL, 1, 2) + " + Chr(13) + Chr(10)
	cQuery +=                                   "SUBSTRING(CFD.CFD_PERVEN, 3, 4) + SUBSTRING(CFD.CFD_PERVEN, 1, 2) in (" + Chr(13) + Chr(10)
	cQuery +=               "select MAX(CFD_COD + SUBSTRING(CFD_PERCAL, 3, 4) + SUBSTRING(CFD_PERCAL, 1, 2) + " + Chr(13) + Chr(10)
	cQuery +=                                    "SUBSTRING(CFD_PERVEN, 3, 4) + SUBSTRING(CFD_PERVEN, 1, 2)) from " + RetSqlName("CFD") + " " + Chr(13) + Chr(10)
	cQuery +=                "where D_E_L_E_T_ = ' ' and CFD_FILIAL = '" + xFilial("CFD") + "' and CFD_COD = CFD.CFD_COD " + Chr(13) + Chr(10)
	cQuery +=                  "and SUBSTRING(CFD_PERCAL, 3, 4) + SUBSTRING(CFD_PERCAL, 1, 2) <= '" + StrZero(Year(dDataRef), 4) + StrZero(Month(dDataRef), 2) + "' " + Chr(13) + Chr(10)
	cQuery +=                  "and SUBSTRING(CFD_PERVEN, 3, 4) + " + Chr(13) + Chr(10)
	cQuery +=                      "SUBSTRING(CFD_PERVEN, 1, 2) <= '" + StrZero(Year(dDataRef), 4) + StrZero(Month(dDataRef), 2) + "')) CFD_U on CFD_U.CFD_COD = SB1.B1_COD " + Chr(13) + Chr(10)
EndIf
cQuery += "where SB1.D_E_L_E_T_ = ' ' and SB1.B1_FILIAL = '" + xFilial("SB1") + "' and SB1.B1_COD BETWEEN '" + M->B1_COD_I + "' and '" + M->B1_COD_F + "' " + Chr(13) + Chr(10)
cQuery +=   "and SB1.B1_ORIGEM + '00' in (" + MV_FCICL + ") and SB1.B1_YPPECA > 0 and SB1.B1_YQTDAG > 0 " + Chr(13) + Chr(10)
If ! lConsulta
	cQuery += "and CFD.CFD_FILIAL is null " + Chr(13) + Chr(10)
	cQuery += "and (coalesce(CFD_U.CFD_CONIMP, 0) = 0 or " + cCONIMPSQL + " < CFD_U.CFD_CONIMP - 5 or " + cCONIMPSQL + " > CFD_U.CFD_CONIMP + 5) " + Chr(13) + Chr(10)
EndIf
cQuery += "and " + cCONIMPSQL + " > 0 " + Chr(13) + Chr(10)
cQuery += cCplQuery
cQuery += "order by SB1.B1_COD" + Chr(13) + Chr(10)

dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), "QRY", .F., .T.)

Return

Static Function ConImpSQL
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Retorna instruÁ„o para calculo do percentual da importaÁ„o em relaÁ„o as vendas
<Data> : 25/03/2014
<Parametros> : Nenhum
<Retorno> : String SQL para uso nas querys
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : M
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Return "Round(case when SD2.VENDAS > 0 " +;
             "then case when SD2_U.CFD_VSAIIE > 0 then SD2_U.CFD_CONIMP else SD2_P.CFD_CONIMP end " +;
             "else case when SC6_V.CFD_VSAIIE > 0 " +;
                       "then CASE WHEN SC6_V.CFD_VSAIIE > 0 AND SC6_V.CFD_QSAIIE > 0 AND SC6_V.CFD_VPARIM > 0 " +;
                                 "THEN (SC6_V.CFD_VPARIM / (SC6_V.CFD_VSAIIE / SC6_V.CFD_QSAIIE)) * 100 ELSE 0 END " +;
                       "else CASE WHEN SC6_V.CSP_VSAIIE > 0 AND SC6_V.CSP_QSAIIE > 0 AND SC6_V.CSP_VPARIM > 0 " +;
                                 "THEN (SC6_V.CSP_VPARIM / (SC6_V.CSP_VSAIIE / SC6_V.CSP_QSAIIE)) * 100  ELSE 0 END end end, 2)"

Static Function QryTRB(dDataREF, dDataFim, nB9_CM1, lUpdate, lConsulta)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Montagem de tabela tempor·rio com os registros a serem selecionados
<Data> : 12/03/2014
<Parametros> : dDataREF = Data de referencia para geraÁ„o das fichas, dDataFim = Data Final para consulta da FCI, nB9_CM1 = Variavel com o custo do produto 
               importado, lConsulta = OpÁ„o de simulaÁ„o do calculo do FCI e lUpdate = Indica atualizaÁ„o da Origem do Produto
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : M
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

TRB->(DbGotop())
While ! TRB->(Eof())
	TRB->(RecLock("TRB", .F.))
	TRB->(DbDelete())
	TRB->(MsUnLock())

	TRB->(DbSkip())
EndDo

If ! lUpdate .And. ! lConsulta
	Return .T.
EndIf

If ! lConsulta
	dDataFim := dDataRef
EndIf

While dDataRef <= dDataFim
	QryFCI(dDataREF, dDataRef, nB9_CM1, lConsulta, "")
	
	While ! QRY->(Eof())
		MsProcTxt("Selecionado produto [" + QRY->CFD_COD + "] ...")
		ProcessMessage()
	
		M->CFD_ORIGEM := ""
		If QRY->CFD_ORIGEM $ "1,3,5"
			If QRY->CFD_ORIGEM <> "5" .And. QRY->CFD_CONIMP <= 40		   							// - Calculo inferior a 40
				M->CFD_ORIGEM := "5"
			ElseIf QRY->CFD_ORIGEM <> "8" .And. QRY->CFD_CONIMP > 70 								// - Calculo superior a 70
				M->CFD_ORIGEM := "8"
			ElseIf QRY->CFD_ORIGEM <> "3" .And. QRY->CFD_CONIMP > 40 .And. QRY->CFD_CONIMP <= 70 	// - Calculo entre 40 e 70
				M->CFD_ORIGEM := "3"
			EndIf
		EndIf
	
		If Empty(M->CFD_ORIGEM) .And. ! lConsulta
			Qry->(DbSkip())
			Loop
		EndIf
	
		TRB->(RecLock("TRB", .T.))
		TRB->CFD_COD    := QRY->CFD_COD
		TRB->B1_DESC    := QRY->B1_DESC
		TRB->B1_ORIGEM  := QRY->CFD_ORIGEM
		TRB->CFD_ORIGEM := M->CFD_ORIGEM
		TRB->CFD_PERVEN := QRY->CFD_PERVEN
		TRB->CFD_VPARIM := QRY->CFD_VPARIM
		TRB->CFD_VSAIIE := QRY->CFD_VSAIIE
		TRB->CFD_CONIMP := If(QRY->CFD_CONIMP > 100, 100, QRY->CFD_CONIMP)
		TRB->FATURADO   := QRY->FATURADO
		TRB->(MsUnLock())
	
		Qry->(DbSkip())
	EndDo
	TRB->(DbGoTop())
	
	QRY->(DbCloseArea())
	
	dDataRef := MonthSum(dDataRef, 1)
Enddo
	
Return

Static Function CfdMarkAll(cMark)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : FunÁ„o para marcar ou desmarcar todos os registros
<Data> : 12/03/2014
<Parametros> : cMark = IndicaÁ„o de marcaÁ„o do registro
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : M
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local aArea := TRB->(GetArea())

TRB->(DbGoTop())
While ! TRB->(Eof())
	CfdMark(cMark)
	
	TRB->(DbSkip())
EndDo

TRB->(RestArea(aArea))

Return .T.

Static Function CfdMark(cMark)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : FunÁ„o para marcar ou desmarcar registro
<Data> : 12/03/2014
<Parametros> : cMark = IndicaÁ„o de marcaÁ„o do registro
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : M
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/
 
If TRB->(Eof())
	Return .T.
EndIf

RecLock("TRB",.F.)
If TRB->CFD_OK <> cMark
	REPLACE TRB->CFD_OK WITH cMark
Else                                                                                  
	REPLACE TRB->CFD_OK WITH Space(Len(TRB->CFD_OK))
Endif

TRB->(MsUnlock())

Return 