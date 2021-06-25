#INCLUDE "TOTVS.CH"

Static cSIXTMP := Nil
Static cSX2TMP := Nil
Static cSX3TMP := Nil
Static __SX2   := "_AA"
Static __TMP   := {}

User Function TCQuery()
Return

CLASS TCQuery
	Data cID
	Data lJob
	Data cAlias
	Data cPQ1_SX2
	Data cPQ1_SQL
	Data cPQ1_MARK
	Data cPQ1_GSQL
	Data cPQ1_FILTER
	Data cPQ1_FORM
	Data cPQ1_OPTIO
	Data cPQ1_VIEW
	Data nPQ1_WIDTH
	Data cPQ1_KEYMD2
	Data cPQ1_AUTOIN
	Data cPQ1_IDPar
	Data cArqTRB
	Data aIndTrb
	Data lSX3
	Data aSX3
	Data aIniPar
	Data cQuery
	Data cQueryD
	Data cProcD
	Data cProcDic
	Data oOwner
	Data lOpt
	Data cCadastro
	Data lDebug
	Data lChangeQry
	           
	Method New(cId) CONSTRUCTOR
	Method Activate()
	Method CpySXS()
	Method OpenAlias()
	Method ExcluiTrb()
	Method TelaParms()
	Method RunTrb()
	Method InsTrb()
	Method Refresh()
	Method xAnalise()
	Method Destroy()
	Method Alias()
ENDCLASS

Method New(cId,lDebug) CLASS TCQuery

Local cChaveID := xFilial("PQ1")+cId, cTpCPO := cX2_ARQUIVO := ""
Local cUsado   := Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160)
Local cNUsado  := 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'	// N„o Usado
Local nPos     := 0, aStruct := {}

Self:cId  := cId
Self:aSX3 := {}
Self:lJob := .F.

DbSelectArea("PQ1")
DbSetOrder(1)
DbSeek(cChaveID)

Self:lOpt        := PQ1->PQ1_OPT == "1"
Self:cCadastro   := Capital(AllTrim(PQ1->PQ1_NOME))
Self:cPQ1_SX2    := PQ1->PQ1_SX2
Self:cPQ1_SQL    := PQ1->PQ1_SQL
Self:cPQ1_MARK   := PQ1->PQ1_MARK
Self:cPQ1_GSQL   := PQ1->PQ1_GSQL
Self:cPQ1_FILTER := AllTrim(PQ1->PQ1_FILTER)
Self:cPQ1_FORM   := AllTrim(PQ1->PQ1_FORM)
Self:cPQ1_OPTIO  := PQ1->PQ1_OPTIO
Self:cPQ1_VIEW   := PQ1->PQ1_VIEW
Self:nPQ1_WIDTH  := PQ1->PQ1_WIDTH
Self:cPQ1_KEYMD2 := AllTrim(PQ1->PQ1_KEYMD2)
Self:cPQ1_AUTOIN := AllTrim(PQ1->PQ1_AUTOIN)
Self:lChangeQry  := PQ1->PQ1_CHGQ == "1"
Self:lDebug	 	 := lDebug 

DbSelectArea("PQ2")
DbSetOrder(1)
DbSeek(cChaveID)

if !Found() .And. ! Empty(PQ1->PQ1_SQL)
	Alert("Campos n„o configurados para consulta [" + cId + "] !")
	Break
endif

if Empty(PQ1->PQ1_SQL) .And. Empty(PQ1->PQ1_SX2)
	Alert("Consulta [" + Self:cId + "] sem definiÁ„o SQL ou tabela base !")
	Break
endif

SX3->(dbSetOrder(2))

While !PQ2->(EOF()) .AND. PQ2->(PQ2_FILIAL+PQ2_ID) == cChaveID
	if PQ2->PQ2_SX3 == "S"
		if SX3->(MsSeek(PQ2->PQ2_NOME))
			Aadd(Self:aSX3, { 	AllTrim(SX3->X3_CAMPO),;
							SX3->X3_TIPO,;
							SX3->X3_TAMANHO,;
							SX3->X3_DECIMAL,;
							PQ2->PQ2_ORDEM,;
							Alltrim(SX3->X3_TITULO),;
							Alltrim(SX3->X3_PICTURE),;
							SX3->X3_CBOX,;
							Val(PQ2->PQ2_NIVEL),;
							If(PQ2->PQ2_BROWSE == "2", "N", "S"),;
							cUsado,;
							SX3->X3_F3,;
							SX3->X3_INIBRW,;
							PQ2->PQ2_PROPRI == "1",;
							PQ2->PQ2_OBRIG == "1",;
							AllTrim(PQ2->PQ2_WHEN),;
							AllTrim(PQ2->PQ2_VALID),;
							PQ2->PQ2_EDIT == "1" } )
		else
			MsgInfo("Campo '"+Alltrim(PQ2->PQ2_NOME)+"' n„o encontrado no dicion·rio de dados!")
			break
		endif
		PQ2->(DBSKIP())
		Loop
	endif
	
	Do Case
		case PQ2->PQ2_TIPO == "1"
			cTpCPO := "C"
		case PQ2->PQ2_TIPO == "2"
			cTpCPO := "N"
		case PQ2->PQ2_TIPO == "3"
			cTpCPO := "L"
		case PQ2->PQ2_TIPO == "4"
			cTpCPO := "D"
		case PQ2->PQ2_TIPO == "5"
			cTpCPO := "M"
	End Case
	
	Aadd(Self:aSX3, { 	AllTrim(PQ2->PQ2_NOME),;
					cTpCPO,;
					PQ2->PQ2_TAM,;
					PQ2->PQ2_TAMDEC,;         
					PQ2->PQ2_ORDEM,;
					Alltrim(PQ2->PQ2_TITULO),;
					Alltrim(PQ2->PQ2_PIC),;
					PQ2->PQ2_EXPRESS,;
					Val(PQ2->PQ2_NIVEL),;
					If(PQ2->PQ2_BROWSE == "2", "N", "S"),;
					cUsado,;
					PQ2->PQ2_F3,;
					PQ2->PQ2_RELACA,;
					PQ2->PQ2_PROPRI == "1",;
					PQ2->PQ2_OBRIG = "1",;
					AllTrim(PQ2->PQ2_WHEN),;
					AllTrim(PQ2->PQ2_VALID),;
					PQ2->PQ2_EDIT == "1" } )

	PQ2->(DBSKIP())
End
SX3->(dbSetOrder(1))

Self:lSX3 := .F.
Self:cAlias := If(! Empty(PQ1->PQ1_SX2), AllTrim(PQ1->PQ1_SX2), AllTrim(PQ1->PQ1_ID) + "QRY")
	
Self:aIndTrb := {}

PQ3->(DbSeek(xFilial("PQ3")+cId))
While !PQ3->(EOF()) .AND. PQ3->(PQ3_FILIAL+PQ3_ID) == cChaveID
	Aadd(Self:aIndTrb,{ PQ3->PQ3_ORDEM, Alltrim(PQ3->PQ3_CHAVE), Capital(PQ3->PQ3_DESCR), CriaTrab(Nil,.F.), PQ3->PQ3_INVERT})

	PQ3->(DBSKIP())
End

If ! Empty(PQ1->PQ1_SX2) .And. Len(Self:aIndTrb) == 0
	SIX->(DbSetOrder(1))
	SIX->(DbSeek(PQ1->PQ1_SX2))
	While SIX->INDICE == PQ1->PQ1_SX2 .And. ! SIX->(Eof())
		Aadd(Self:aIndTrb,{ SIX->ORDEM, Alltrim(SIX->CHAVE), Capital(SIX->DESCRICAO), CriaTrab(Nil,.F.), "N"})
  		SIX->(DbSkip())
	EndDo
EndIf

Return

Method OpenAlias() CLASS TCQuery
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Abertura do alias de apresentaÁ„o do grid
<Data> : 24/03/2014
<Parametros> : 
<Retorno> : 
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nPos := 0, aStruct := {}
Local nI   := 0

If ! Empty(Self:cPQ1_SQL)
	Self:cArqTRB := CriaTrab(aStruct,.F.)

	If .F. // Self:cPQ1_GSQL == "1"
		// lCpy := .T.
	Else
		For nPos := 1 To Len(Self:aSX3)
			Aadd(aStruct, { Self:aSX3[nPos][1], Self:aSX3[nPos][2], Self:aSX3[nPos][3], Self:aSX3[nPos][4] })
		Next
	
		If .T. //-- Top Connect
			MsErase(Self:cArqTRB)
			MsCreate(Self:cArqTRB, aStruct, 'TOPCONN' )
			dbUseArea( .T., 'TOPCONN', Self:cArqTRB, Self:cAlias, .T., .F. )
			For nPos := 1 To Len(Self:aSX3)
				If Self:aSX3[nPos][2] $ "D,L,N"
					TCSetField(Self:cAlias, Self:aSX3[nPos][1], Self:aSX3[nPos][2], Self:aSX3[nPos][3], Self:aSX3[nPos][4])
				Endif
			Next
			
			For nI := 1 To Len(Self:aIndTrb)
				INDEX ON &(Self:aIndTrb[nI][2]) TO &(Self:aIndTrb[nI][4])
			Next
			
			If Len(Self:aIndTrb) == 1
				SET Index To 	(Self:aIndTrb[1][4])	
			ElseIf Len(Self:aIndTrb) == 2
				SET Index To 	(Self:aIndTrb[1][4]), (Self:aIndTrb[2][4])
			ElseIf Len(Self:aIndTrb) == 3
				SET Index To 	(Self:aIndTrb[1][4]), (Self:aIndTrb[2][4]), (Self:aIndTrb[3][4])
			ElseIf Len(Self:aIndTrb) == 4
				SET Index To 	(Self:aIndTrb[1][4]), (Self:aIndTrb[2][4]), (Self:aIndTrb[3][4]), (Self:aIndTrb[4][4])
			ElseIf Len(Self:aIndTrb) == 5
				SET Index To 	(Self:aIndTrb[1][4]), (Self:aIndTrb[2][4]), (Self:aIndTrb[3][4]), (Self:aIndTrb[4][4]), (Self:aIndTrb[5][4])
			ElseIf Len(Self:aIndTrb) == 6
				SET Index To 	(Self:aIndTrb[1][4]), (Self:aIndTrb[2][4]), (Self:aIndTrb[3][4]), (Self:aIndTrb[4][1]), (Self:aIndTrb[5][4]),;
								(Self:aIndTrb[6][4])
			ElseIf Len(Self:aIndTrb) == 7
				SET Index To 	(Self:aIndTrb[1][4]), (Self:aIndTrb[2][4]), (Self:aIndTrb[3][4]), (Self:aIndTrb[4][4]), (Self:aIndTrb[5][4]),; 
								(Self:aIndTrb[6][4]), (Self:aIndTrb[7][4])
			ElseIf Len(Self:aIndTrb) == 8
				SET Index To 	(Self:aIndTrb[1][4]), (Self:aIndTrb[2][4]), (Self:aIndTrb[3][4]), (Self:aIndTrb[4][4]), (Self:aIndTrb[5][4]),; 
								(Self:aIndTrb[6][4]), (Self:aIndTrb[7][4]), (Self:aIndTrb[8][4])
			ElseIf Len(Self:aIndTrb) == 9
				SET Index To 	(Self:aIndTrb[1][4]), (Self:aIndTrb[2][4]), (Self:aIndTrb[3][4]), (Self:aIndTrb[4][4]), (Self:aIndTrb[5][4]),; 
								(Self:aIndTrb[6][4]), (Self:aIndTrb[7][4]), (Self:aIndTrb[8][4]), (Self:aIndTrb[9][4])
			ElseIf Len(Self:aIndTrb) == 10
				SET Index To 	(Self:aIndTrb[1][4]), (Self:aIndTrb[2][4]), (Self:aIndTrb[3][4]), (Self:aIndTrb[4][4]), (Self:aIndTrb[5][4]),; 
								(Self:aIndTrb[6][4]), (Self:aIndTrb[7][4]), (Self:aIndTrb[8][4]), (Self:aIndTrb[9][4]), (Self:aIndTrb[10][4])
			EndIf
		Else
			Self:cArqTRB := CriaTrab(aStruct,.T.)
		
			// Disponibiliza a tabela tempor·ria para uso pelo programa
			dbUseArea(.T.,,Self:cArqTRB,Self:cAlias,.F.)
		
			// Cria o arquivo de indice para a tabela temporaria
			For nI := 1 to len(Self:aIndTrb)
			  IndRegua(Self:cAlias, Self:aIndTrb[nI][4], Self:aIndTrb[nI][2],,,'...')
			Next nI
		
			dbClearIndex()
		
			For nI := 1 to len(Self:aIndTrb)
			  dbSetIndex(Self:aIndTrb[nI][4] + OrdBagExt())
			Next nI
		EndIf
		DbSetOrder(1) 
	EndIf
EndIf

DbSelectArea(Self:cAlias)

Return

Method Activate() CLASS TCQuery

if ! Self:TelaParms(.T.)
	Self:Destroy()
	Return .F.
endif

Return .T.

Method Destroy() CLASS TCQuery

Self:ExcluiTrb()

Return

Method ExcluiTrb() CLASS TCQuery

If Select(Self:cAlias) > 0
	DbSelectArea(Self:cAlias)
	DbCloseArea()
EndIf

If ! Empty(Self:cQuery) .And. ValType(Self:cArqTrb) = "C"
	MsErase(Self:cArqTRB)
EndIf

Return .T.

//Tela de Parametros
Method TelaParms(lTela, _aQuery, nQuery) CLASS TCQuery

Local nP, n1, n2, nIt, nOpca := nExec := 0
Local oDlgP, oScrollP, oMemoP, oSayP, oGetP, cTituloP
Local cPictP, oColorP, nLinha1P, nLiina2P
Local cKeyADVPL 	:= cKeySQL := cContdIni := "", cFilPQ4 := xFilial("PQ4"), cMemo := Space(10)
Local aParams   	:= {}, aNewGets 	:= {}
Local nOrdem    	:= 1, cTagSQL 	:= cParam := ""
Local nPos			:= 0
Local cIDParam      := ""
Local lGrv			:= .T.
Local xVar			:= ""

DbSelectArea("PQ1")
DbSetOrder(1)
DbSeek(xFilial("PQ1")+Self:cId)

Self:cQuery := Self:cQueryD  := PQ1->PQ1_SQL
Self:cProcD := Self:cProcDic := PQ1->PQ1_PROCED

cIDParam := If(! Empty(Self:cPQ1_IDPar), Self:cPQ1_IDPar, Self:cId)
If ! Empty(Self:cPQ1_IDPar) .And. Len(aQuery) > 1
	lTela := .F.
	lGrv  := .F.
EndIf

DbSelectArea("PQ4")
DbSetorder(1)
DbSeek(xFilial() + cIDParam, .T.)
cMemo := PQ4_HELP

PQ5->(DBSETORDER(1))
cChavPQ5 := xFilial("PQ5")+ cIDParam + __cUserID

While !PQ4->(EOF()) .AND. PQ4->(PQ4_FILIAL+PQ4_ID) == cFilPQ4+cIDParam
	
	//Parametro por usuario
	if ! Self:lJob .And. PQ5->(DBSEEK(cChavPQ5+PQ4->PQ4_NOME))
		cContdIni := PQ5->PQ5_INI
	else
		cContdIni := PQ4->PQ4_INI
	endif
	
	Aadd(aNewGets,{nil,;  						 //01
	PQ4_ORDEM,;        							 //02
	PQ4_NOME,;         							 //03
	PQ4_TITULO,;       							 //04
	PQ4_TIPO,;         							 //05
 	    IIF(PQ4->PQ4_TIPO=="5",8000,PQ4->PQ4_TAM),; //06
	PQ4_TAMDEC,;       							 //07
	cContdIni,;        							 //08
	PQ4_F3,;           							 //09
	PQ4_LISTA,;        							 //10
	PQ4_OBRIG,;        							 //11
	PQ4_PIC,;          							 //12
	PQ4_HELP,;         							 //13
	PQ4_VALID})		 							 //14
	PQ4->(DBSkip())
end

If Self:aIniPar == Nil
	Self:aIniPar := {}
EndIf

if Len(Self:aIniPar) > 0
	For nP := 1 to Len(Self:aIniPar)
		aNewGets[nP,8] := Self:aIniPar[nP]
	Next nP
endif

For n1 := 1 to Len(aNewGets)
	_cCampo  := "_" + aNewGets[n1,3]

	if Empty(aNewGets[n1,8])
		Do Case
			Case aNewGets[n1,5]=="1"
				_cIniCpo := Space( aNewGets[n1,6] )
				cPictP := "@!"
			Case aNewGets[n1,5]=="2"
				_cIniCpo := 0
				cPictP := "@E 999,999,999.99"
			Case aNewGets[n1,5]=="3"
				_cIniCpo := .F.
				cPictP := ""
			Case aNewGets[n1,5]=="4"
				_cIniCpo := CTOD("  /  /  ")
				cPictP := "@D"
			Case aNewGets[n1,5]=="5"
				_cIniCpo := Space(8000)
				cPictP := ""
		Endcase
	else
		_cIniCpo := Eval(&("{|| "+aNewGets[n1,8]+"}"))
	endif

	&_cCampo := _cIniCpo
Next n1

if ! Self:lJob .And. lTela .And. Len(aNewGets) > 0
	DEFINE FONT oFont NAME "Arial" SIZE 0, -11 bold

	DEFINE MSDIALOG oDlgP TITLE "Par‚metros: " + Capital(AllTrim(PQ1->PQ1_NOME)) From 0,0 To 340,500 of oDlgP PIXEL
	nLinha1P := (oDlgP:nHeight-118)/2
	nLiina2P := 7
	nColun1 := (oDlgP:nWidth-14)/2
	oScrollP := TScrollBox():New( oDlgP, 002,002,nLinha1P,ncolun1)
	lExecuta := .F.

	For n1 := 1 to Len(aNewGets)
		aItens := {}
		nTam := (aNewGets[n1,6]+aNewGets[n1,7])*4

		if nTam < 40
			nTam := 40
		endif

		cTituloP := "{|| OemToAnsi('"+aNewGets[n1,4]+"')}"
		oColorP := iif(aNewGets[n1,11] == "S",CLR_HBLUE,CLR_BLACK)
		oSayP :=  TSay():New( nLiina2P, 15,        &cTituloP,oScrollP, ,oFont, , , , .T.,oColorP          , , , , , , )
		cTituloP := oSayP:cCaption

		_cCampo  := "_"+Alltrim(aNewGets[n1,3])
		cValidP := aNewGets[n1,14]

		if !Empty(cValidP)
			For n2 := 1 to Len(aNewGets)
				_cCampo1 := Alltrim(aNewGets[n2,3])
				cValidP := StrTran(cValidP,"M->"+_cCampo1,"_"+_cCampo1)
			Next n2
		endif

		if aNewGets[n1,11] == "S"
			cBlKVld := "{|| NaoVazio("+_cCampo+")"+IIF(!Empty(cValidP)," .AND. "+alltrim(cValidP),"")+"}"
		else
			cBlKVld := "{|| "+IIF(!Empty(cValidP),alltrim(cValidP),".T.")+"}"
		endif

		cF3 := iif(Empty(aNewGets[n1,09]),nil,aNewGets[n1,09])
		cPictP:= iif(Empty(aNewGets[n1,12]),cPictP,aNewGets[n1,12])
		cHelpCpo := "{|| cMemo:='"+Alltrim(StrTran(aNewGets[n1,13],chr(13)+chr(10)," "))+"',oMemoP:Refresh()}"
		cBlkGet := "{|u| If( PCount() == 0, "+_cCampo+","+_cCampo+":= u ) }"

		if Empty(cF3) .and. !Empty(aNewGets[n1,10])
			cItens := aNewGets[n1,10]
			cItens := StrTran(cItens,";","','")
			cItens := "'"+Alltrim(cItens)+"'"
			aItens := &("{"+cItens+"}")
			nTam := 0
			For nIt := 1 to Len(aItens)
				if nTam < Len(aItens[nIt])
					nTam := Len(aItens[nIt])
				endif
			Next
			nTam := (nTam * 4) + 4
		endif

		if Len(aItens) == 0 .and. aNewGets[n1,5] # "3"
			oGetP := TGet():New( nLiina2P, 100  ,&cBlKGet,oScrollP,nTam,8  ,cPictP, &(cBlkVld),,,, .F.,, .T.,, .F.,,.F., .F.,, .F., .F.,cF3,(_cCampo),,,,.T.)
		elseif Len(aItens) > 0 .and. aNewGets[n1,5] # "3"
			oGetP := TComboBox():New(nLiina2P,100, &cBlKGet,aItens,nTam,10,oScrollP,,,&(cBlkVld),,,.T.)
		elseif aNewGets[n1,5] == "3"
			oGetP := TCheckBox():New (nLiina2P,100,"", &cBlKGet, oScrollP, 10, 10,,,,, CLR_BLUE,,,.T.)
		endif

		oGetP:bGotFocus := &cHelpCpo
		nLiina2P += 15
	Next n1

	nLinha1P+= 4
	@ nLinha1P,002 GET oMemoP VAR cMemo MEMO SIZE 170, 39 READONLY PIXEL OF oDlgP
	nLinha1P+= 27
	DEFINE SBUTTON FROM nLinha1P,185 TYPE 1  ACTION (nOpca := 1,oDlgP:End()) ENABLE PIXEL OF oDlgP
	DEFINE SBUTTON FROM nLinha1P,220 TYPE 2  ACTION (oDlgP:End()) ENABLE PIXEL OF oDlgP
	ACTIVATE MSDIALOG oDlgP CENTERED

	Self:aIniPar := {}
	For nP := 1 to Len(aNewGets)
		Aadd(Self:aIniPar, aNewGets[nP,8])
	Next nP
else
	nOpca := 1
endif

if nOpca == 1
	Self:Destroy()
	//Gravacao do parametros por usuario
	If lGrv .And. ! Self:lJob
		For n1 := 1 to Len(aNewGets)
			if !PQ5->(DBSEEK(cChavPQ5+aNewGets[n1,3]))
				RECLOCK("PQ5",.T.)
				PQ5->PQ5_ID := cIDParam
				PQ5->PQ5_USERID := __cUserID
				PQ5->PQ5_NMPAR := aNewGets[n1,3]
			else
				RECLOCK("PQ5",.F.)
			endif
	
			if aNewGets[n1,5] == "1"
				PQ5->PQ5_INI := "'"+StrTran(Substr(&("_"+aNewGets[n1,3]),1,aNewGets[n1,6]),"'","")+"'"
			elseif aNewGets[n1,5] == "2"
				PQ5->PQ5_INI := Alltrim( Str(&("_"+aNewGets[n1,3]),aNewGets[n1,6],aNewGets[n1,7]) )
			elseif aNewGets[n1,5] == "3"
				PQ5->PQ5_INI := if(&("_"+aNewGets[n1,3]),".T.",".F.")
			elseif aNewGets[n1,5] == "4"
				PQ5->PQ5_INI := "CTOD('"+DtoC(&("_"+aNewGets[n1,3]))+"')"
			endif
			Self:aIniPar[n1] := PQ5->PQ5_INI
			aNewGets[n1,8] := PQ5->PQ5_INI
	
			PQ5->(MSUNLOCK())
		Next
	EndIf
	
	//MacroSubstituicao Query
	n1    := 0
	n2    := 0
	nExec := 0
	cLinha := ""

	//MacroSubstituicao Procedure
	n1     := 0
	n2     := 0
	nExec  := 0
	cLinha := ""

	Self:cProcD := Self:cProcDic
	Do While .T.
		n1 := At("<ADVPL>",SubString(Self:cProcD,1,Len(Self:cProcD)))
		if n1 == 0
			Exit
		endif

		n2 := At("</ADVPL>",SubString(Self:cProcD,n1,Len(Self:cProcD)))
		if n2 == 0 .and. n1 > 0
			Alert("Pre-SQL [" + Self:cProcD + "] Estrutura sem a tag </ADVPL>!")
			break
		endif

		cLinha := SubString(Self:cProcD,n1+7,n2-8)
		cParam := cLinha

		_xSQL(@cLinha)

		if ValType(cLinha) == "C"
			Self:cProcD := SubString(Self:cProcD,1,n1-1)+cLinha+SubString(Self:cProcD,n2+7+n1,Len(Self:cProcD))
			nExec ++
		ElseIf nExec > 1
			Alert("AtenÁ„o. O parametro [" + cParam + "] n„o est· sendo substituido na Pre-SQL [" + Self:cProcD + "] ")
			Break
		endif
	EndDo

	Self:cQuery := Self:cQueryD
	For n1 := 1 to Len(aNewGets)
		cKeyADVPL := "#"+Alltrim(aNewGets[n1,3])+"#"
		cTagSQL   := "@"+Alltrim(aNewGets[n1,3])+"@"
		cMvPar    := "mv_par"+Alltrim(Str(n1))

		if aNewGets[n1,5] == "1"
			xVar := Substr(&("_"+aNewGets[n1,3]),1,aNewGets[n1,6])
			cKeySQL := "'"+xVar+"'"
		elseif aNewGets[n1,5] == "2"
			xVar := StrTran( Alltrim( Str(&("_"+aNewGets[n1,3]),aNewGets[n1,6],aNewGets[n1,7]) ) ,",",".")
			cKeySQL := xVar
		elseif aNewGets[n1,5] == "3"
			xVar := aNewGets[n1,3]
			cKeySQL := if(&("_"+aNewGets[n1,3]),"'.T.'","'.F.'")
		elseif aNewGets[n1,5] == "4"
			xVar := Dtos(&("_"+aNewGets[n1,3]))
			cKeySQL := "'"+xVar+"'"
		endif
		
		&("MV_PAR" + StrZero(n1, 2)) := xVar

		Aadd(aParams,cKeySQL)

		Self:cQuery := StrTran(Self:cQuery, cKeyADVPL, cKeySQL)
		Self:cQuery := StrTran(Self:cQuery, cTagSQL, cKeySQL)

		if ! Empty(Self:cProcD)
			Self:cProcD := StrTran(Self:cProcD, cKeyADVPL, cKeySQL)
			Self:cProcD := StrTran(Self:cProcD, cTagSQL, cKeySQL)
		endif
	Next

   If Self:cId == __PQ1_ID
	   __PQ1_PRSQL := Self:cProcD
		Self:cProcD := Self:cProcDic := ""
	EndIf

	Do While .T.
		n1 := At("<ADVPL>",SubString(Self:cQuery,1,Len(Self:cQuery)))
		if n1 == 0
			Exit
		endif
		n2 := At("</ADVPL>",SubString(Self:cQuery,n1,Len(Self:cQuery)))

		if n2 == 0 .and. n1 > 0
			Alert("Query [" + Self:cQuery + "] Estrutura sem a tag </ADVPL>!")
			break
		endif

		cLinha := SubString(Self:cQuery,n1+7,n2-8)
		cParam := cLinha

		_xSQL(@cLinha)

		if ValType(cLinha) == "C"
			Self:cQuery := SubString(Self:cQuery,1,n1-1)+cLinha+SubString(Self:cQuery,n2+7+n1,Len(Self:cQuery))
			nExec ++
		ElseIf nExec > 1
			Alert("AtenÁ„o. O parametro [" + cParam + "] n„o est· sendo substituido na instruÁ„o [" + Self:cQuery + "] ")

			break
		endif
	EndDo

   	If Self:cId == __PQ1_ID
	   __PQ1_PRSQL := Self:cQuery
	EndIf

	DbSelectArea("PQ1")
	If Self:lJob
		Self:RunTrb()
	Else
		MsAguarde({|| Self:RunTrb() },"Consulta Personalizada","Executando Consulta, Aguarde ...",.T.)
	EndIf
endif

If _aQuery <> Nil .And. ! Empty(Self:cPQ1_FILTER)
	_aQuery[nQuery][4]:CleanFilter()
	_aQuery[nQuery][4]:AddFilter("FILTRO",	cFilter := &(Self:cPQ1_FILTER),.T.,.T.,Self:cPQ1_SX2)
	_aQuery[nQuery][4]:SetFilterDefault(cFilter)
EndIf

If nQuery == 1
	For nPos := 2 To Len(_aQuery)
		_aQuery[nPos][2]:Refresh(.F., _aQuery, nPos)
	Next
EndIf

Return nOpca == 1

Method Refresh(lTela, aQuery, nQuery) CLASS TCQuery

Self:TelaParms(lTela)

If aQuery <> Nil .And. ! Empty(Self:cPQ1_FILTER)
	aQuery[nQuery][4]:CleanFilter()
	aQuery[nQuery][4]:AddFilter("FILTRO",	cFilter := &(Self:cPQ1_FILTER),.T.,.T.,Self:cPQ1_SX2)
	aQuery[nQuery][4]:SetFilterDefault(cFilter)
EndIf

Return

Method RunTrb() CLASS TCQuery

Local aGrupo := UsrRetGrp(), cCodUsr := RetCodUsr()

if Self:lDebug
	if MsgYesNo("Deseja realizar a analise da consulta?")
		if ! Self:xAnalise()
			Return .F.
		endif
	endif
endif

if ! Empty(Self:cProcD)
	If TCSQLEXEC(Self:cProcD) <> 0
		Alert(TcSqlError())
		Return .F.
	EndIf
endif

If Select(Self:cAlias) > 0
	DbSelectArea(Self:cAlias)
	DbCloseArea()
EndIf
Self:OpenAlias()

if !Empty(Self:cQuery)
	If Self:lJob
		Self:InsTrb()
	Else
		MsAguarde({|| Self:InsTrb() },"Consulta Personalizada","Gerando a Consulta, Aguarde ...",.T.)
	EndIf	
endif

Return

Method InsTrb() CLASS TCQuery

Local cSQL  := "INSERT INTO " + Self:cArqTrb + "("
Local nSX3  := 0
Local nLoop := 0 
Local nJ    := 0
Local nCountTrb := 0

If ! Self:lOpt
	If Self:lChangeQry
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,ChangeQuery(Self:cQuery)),"QRY",.F.,.T.)
	Else
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,Self:cQuery),"QRY",.F.,.T.)
	EndIf
	
	For nJ := 1 To Len(Self:aSX3)
		If Self:aSX3[nJ][2] $ "D,L,N"
			TCSetField("QRY", Self:aSX3[nJ][1], Self:aSX3[nJ][2], Self:aSX3[nJ][3], Self:aSX3[nJ][4])
		EndIf
	Next nI
	
	nTotLn := 0
	If Self:lJob
		ConOut("TCQUERY.PRW - " + Self:cId + " - Contando registros ...")
	Else
		MsProcTxt("Contando registros ...")
	EndIf
	QRY->(DbGoTop())
	QRY->( DbEval({|| nCountTrb++ },,{|| !EOF()}) )
	QRY->(DbGoTop())
	ProcRegua(nCountTrb)
	
	aQryStru := QRY->(DbStruct())
	nCountLn := 0
	
	While ! QRY->(EOF())
		nTotLn++
		If Self:lJob
			ConOut("TCQUERY.PRW - " + Self:cId + " - Registros processados: "+Alltrim(Str(nTotLn,10,0))+"/"+Alltrim(Str(nCountTrb,10,0)))
		Else
			MsProcTxt("Registros processados: "+Alltrim(Str(nTotLn,10,0))+"/"+Alltrim(Str(nCountTrb,10,0)))
		EndIf
		ProcessMessage()

		RecLock(Self:cAlias,.T.)
		
		For nLoop := 1 To Len(aQryStru)
			(Self:cAlias)->&(aQryStru[nLoop,1]) := QRY->&(aQryStru[nLoop,1])
		Next nLoop
		
		(Self:cAlias)->(MsUnlock())
		
		QRY->(DbSkip())
	End
	
	QRY->(DbCloseArea())
Else
	For nSX3 := 1 To Len(Self:aSX3)
		cSQL += AllTrim(Self:aSX3[nSX3][1]) + ","
	Next nI

	cSQL += "R_E_C_N_O_) " + Self:cQuery

	If TCSQLEXEC(cSQL) <> 0
		Alert(TcSqlError())
		Return .F.
	EndIf
	TCRefresh(RetSqlName(Self:cAlias))
EndIf
*/

Return

Static Function _xSQL(cLinha)

Local nX
Local cRet := ""

if Upper(Alltrim(cLinha)) == "<COLUNAS>"
	For nX := 1 to Len(Self:aSX3)
		cRet += ", "+alltrim(Self:aSX3[nX,2])
	Next nX
	cLinha := SubStr(cRet,2,Len(cRet))
else
	cLinha := &(cLinha)
endif

Return

Method xAnalise() CLASS TCQuery

Local oDlgHelp, oBtOk
Local oFont	 :=	TFont ():New ("Arial",, 15,, .F.)
Local oFontB :=	TFont ():New ("Arial",, 15,, .T.)
Local lRet := .F., cAlias := RetSqlName(Self:cAlias)

DEFINE MSDIALOG oDlgHelp FROM 000,000 TO 500, 660 TITLE "Analise da Consulta" PIXEL
@005, 005 SAY "Query" SIZE 205, 010 FONT oFontB OF oDlgHelp PIXEL COLOR CLR_RED
@015, 005 GET Self:cQuery OF oDlgHelp MEMO SIZE 320, 095 FONT oFont PIXEL
@115, 005 SAY "Stored Procedure" SIZE 100, 010 FONT oFontB OF oDlgHelp PIXEL COLOR CLR_RED
@125, 005 GET Self:cProcD OF oDlgHelp MEMO SIZE 320, 095 FONT oFont PIXEL
@220, 005 SAY "Tabela" SIZE 040, 010 FONT oFontB OF oDlgHelp PIXEL COLOR CLR_RED
@230, 005 GET cAlias OF oDlgHelp SIZE 040, 010 FONT oFont PIXEL

DEFINE SBUTTON oBtOk FROM 225, 300 TYPE 1 ACTION (lRet := .T., oDlgHelp:End()) ENABLE OF oDlgHelp
ACTIVATE MSDIALOG oDlgHelp CENTERED

Return .T.

Method Alias() CLASS TCQuery

Return Self:cAlias

User Function ParserAdv(cParser)

Local cLinha := "", n1 := n2 := nExec := 0

Do While .T.
	n1 := At("<ADVPL>",SubString(cParser,1,Len(cParser)))
	if n1 == 0
		Return cParser
	endif
	n2 := At("</ADVPL>",SubString(cParser,n1,Len(cParser)))

	if n2 == 0 .and. n1 > 0
		Alert("Estrutura sem a tag </ADVPL>!")
		Break
	endif

	cLinha := SubString(cParser,n1+7,n2-8)
	cParam := cLinha

	_xSQL(@cLinha)

	if ValType(cLinha) == "C"
		cParser := SubString(cParser,1,n1-1)+cLinha+SubString(cParser,n2+7+n1,Len(cParser))
		nExec ++
	ElseIf nExec > 1
      	Alert("AtenÁ„o. O parametro [" + cParam + "] n„o est· sendo substituido na instruÁ„o [" + cParser + "] ")

		Break
	endif
EndDo

Return cParser