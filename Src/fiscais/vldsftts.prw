#Include "Protheus.Ch"

User Function VLDSFTTS()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para validar a alteraÁ„o da TES da nova tes nos livros fiscal
<Data> : 12/07/2014
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : V
<Autor> : Wagner Mobile Costa
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local cError := ""

If (oCQuery:cAlias)->(FT_TIPOMOV) == "E"
	If M->D1_XTES > "500" .And. ! Empty(M->D1_XTES)
		MsgInfo("AtenÁ„o. SÛ podem ser selecionadas TES de entrada para esta operaÁ„o !")
		Return .F.		
	EndIf
	M->F4_COD_N := M->D1_XTES
Else
	If M->D2_XTES < "500" .And. ! Empty(M->D2_XTES)
		MsgInfo("AtenÁ„o. SÛ podem ser selecionadas TES de saÌda para esta operaÁ„o !")
		Return .F.		
	EndIf

	M->F4_COD_N := M->D2_XTES
EndIf

If Empty(M->F4_COD_N)
	Return .T.
EndIf

SF4->(DbSetOrder(1))
SF4->(DbSeek(xFilial() + M->F4_COD_N))

M->F4_DUPLIC  := SF4->F4_DUPLIC
M->F4_ESTOQUE := SF4->F4_ESTOQUE
M->F4_PODER3  := SF4->F4_PODER3
M->F4_ATUTEC  := SF4->F4_ATUTEC
M->F4_ATUATF  := SF4->F4_ATUATF

SF4->(DbSetOrder(1))
SF4->(DbSeek(xFilial() + (oCQuery:cAlias)->F4_CODIGO))

If M->F4_DUPLIC <> SF4->F4_DUPLIC
	cError += "GeraÁ„o de Duplicata"
EndIf

If M->F4_ESTOQUE <> SF4->F4_ESTOQUE
	If ! Empty(cError)
		cError += "/"
	EndIf
	cError += "AtualizaÁ„o de Estoque"
EndIf

If M->F4_PODER3 <> SF4->F4_PODER3
	If ! Empty(cError)
		cError += "/"
	EndIf
	cError += "Estoque de Terceiros"
EndIf

If M->F4_ATUTEC <> SF4->F4_ATUTEC
	If ! Empty(cError)
		cError += "/"
	EndIf
	cError += "Assistencia TÈcnica"
EndIf

If M->F4_ATUATF <> SF4->F4_ATUATF
	If ! Empty(cError)
		cError += "/"
	EndIf
	cError += "AtualizaÁ„o do ativo"
EndIf

If ! Empty(cError)
	MsgInfo("AtenÁ„o. A Tes selecionada n„o tem os mesmos controles da tes anterior do(s) campo(s) [" + cError + "] e n„o pode ser selecionada !")
EndIf

If Empty(cError) .And. ! MsgYesNo("Confirma a alteraÁ„o da TES para o documento [" + AllTrim((oCQuery:cAlias)->FT_NFISCAL) + "] ?")
	cError := "ERROR"
EndIf

Return Empty(cError)

User Function RepNfTes()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para reprocessar a nota com a nova tes
<Data> : 12/07/2014
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : V
<Autor> : Wagner Mobile Costa
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

MsAguarde({|| ExecRep() }, "Reprocessamento","Executando o reprocessamento. Aguarde ...",.T.)

Return

Static Function ExecRep()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para reprocessar a nota com a nova tes
<Data> : 12/07/2014
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : V
<Autor> : Wagner Mobile Costa
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nUpd := 0

DbSelectArea(oCQuery:Alias())
DbSetOrder(2)		// FT_TIPOMOV+FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA+FT_ITEM
DbGoTop()
M->FT_DTDIGIT := Ctod("")

While ! Eof()
	MsProcTxt('Lendo a nota fiscal [' + (oCQuery:Alias())->FT_NFISCAL + '] ...')
	ProcessMessage()
	
	If ! Empty((oCQuery:Alias())->F4_COD_N) .And. oBrowse:cMark == (oCQuery:Alias())->FT_OK
		If (oCQuery:Alias())->FT_TIPOMOV == "E"
			DbSelectArea("SD1")
			DbGoto((oCQuery:Alias())->D_RECNO)
			
			If SD1->D1_TES <> (oCQuery:Alias())->F4_COD_N
				RecLock("SD1", .F.)
				SD1->D1_TES := (oCQuery:Alias())->F4_COD_N
				MsUnLock()
				M->FT_DTDIGIT := SD1->D1_DTDIGIT
				nUpd ++
			EndIf
		Else
			DbSelectArea("SD2")
			DbGoto((oCQuery:Alias())->D_RECNO)
			If SD2->D2_TES <> (oCQuery:Alias())->F4_COD_N
				RecLock("SD2", .F.)
				SD2->D2_TES := (oCQuery:Alias())->F4_COD_N
				MsUnLock()
				M->FT_DTDIGIT := SD2->D2_EMISSAO
				nUpd ++
			EndIf
		EndIf
	EndIf
	
	M->FT_TIPOMOV := (oCQuery:Alias())->FT_TIPOMOV
	M->FT_SERIE   := (oCQuery:Alias())->FT_SERIE
	M->FT_NFISCAL := (oCQuery:Alias())->FT_NFISCAL
	M->FT_CLIEFOR := (oCQuery:Alias())->FT_CLIEFOR
	M->FT_LOJA    := (oCQuery:Alias())->FT_LOJA

	DbSelectArea(oCQuery:Alias())
	DbSkip()

	If 	M->FT_TIPOMOV <> (oCQuery:Alias())->FT_TIPOMOV .Or. M->FT_SERIE <> (oCQuery:Alias())->FT_SERIE .Or.;
		M->FT_NFISCAL <> (oCQuery:Alias())->FT_NFISCAL .Or. M->FT_CLIEFOR <> (oCQuery:Alias())->FT_CLIEFOR .Or.;
		M->FT_LOJA    <> (oCQuery:Alias())->FT_LOJA
		If nUpd > 0
			If M->FT_TIPOMOV == "E"
				Processa( { || Mata930(.T., { 	Dtoc(M->FT_DTDIGIT), Dtoc(M->FT_DTDIGIT), 1, M->FT_NFISCAL, M->FT_NFISCAL, M->FT_SERIE, M->FT_SERIE,;
												M->FT_CLIEFOR, M->FT_CLIEFOR, M->FT_LOJA, M->FT_LOJA }) }) 
	    	Else
				Processa( { || Mata930(.T., { 	Dtoc(M->FT_DTDIGIT), Dtoc(M->FT_DTDIGIT), 2, M->FT_NFISCAL, M->FT_NFISCAL, M->FT_SERIE, M->FT_SERIE,;
												M->FT_CLIEFOR, M->FT_CLIEFOR, M->FT_LOJA, M->FT_LOJA }) })
			EndIf
		EndIf
		nUpd := 0
    EndIf
	DbSelectArea(oCQuery:Alias())
EndDo 

__REFRESH := .T.

Return

User Function xTesSFT()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Transfere a TES do arquivo tempor·rio para a tabela SD1 ou SD2
<Data> : 13/07/2014
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : V
<Autor> : Wagner Mobile Costa
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local cQuery := ""

// D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM
If M->FT_TIPOMOV == "E"
   cQuery := "UPDATE " + RetSqlName("SD1") + " SET D1_XTES = '" + M->F4_COD_N + "' " +;
              "WHERE D_E_L_E_T_ = ' ' AND D1_FILIAL = '" + xFilial("SD1") + "' AND D1_DOC = '" + Right(M->FT_NFISCAL, Len(SD1->D1_DOC)) + "' " +;
                "AND D1_SERIE = '" + M->FT_SERIE + "' AND D1_FORNECE = '" + M->FT_CLIEFOR + "' AND D1_LOJA = '" + M->FT_LOJA + "' " +;
                "AND D1_ITEM = '" + M->FT_ITEM + "'"

// D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
Else
   cQuery := "UPDATE " + RetSqlName("SD2") + " SET D2_XTES = '" + M->F4_COD_N + "' " +;
              "WHERE D_E_L_E_T_ = ' ' AND D2_FILIAL = '" + xFilial("SD2") + "' AND D2_DOC = '" + Right(M->FT_NFISCAL, Len(SD2->D2_DOC)) + "' " +;
                "AND D2_SERIE = '" + M->FT_SERIE + "' AND D2_CLIENTE = '" + M->FT_CLIEFOR + "' AND D2_LOJA = '" + M->FT_LOJA + "' " +;
                "AND D2_ITEM = '" + M->FT_ITEM + "'"
EndIf

If TcSqlExec(cQuery) <> 0
   	Alert(TcSQLError())
Else
	nImp ++
EndIf

Return