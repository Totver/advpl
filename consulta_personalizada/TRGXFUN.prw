#Include 'TOTVS.ch'
#Include 'REPORT.ch'

Static aSQL := {}

User Function FillHeader(cAlias, cCpos, cNaoMostra)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Monta aHeader a partir do alias
<Data> : 02/09/2013
<Parametros> : cAlias = Tabela do dicion·rio a ser iniciada
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

aHeader := {}
nUsado  := 0

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek(cAlias)
While !Eof() .and. SX3->X3_ARQUIVO == cAlias

	if At("_FILIAL",X3_CAMPO)>0
		cCpoFilial := X3_CAMPO
	endif

	lCampo := .F.

	if Empty(cCPOs)
		lCampo := (X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL .and. !(ALLTRIM(SX3->X3_CAMPO) $ cNaoMostra))
	else
		lCampo := (ALLTRIM(SX3->X3_CAMPO) $ cCPOs)
	endif

	If lCampo
        nUsado++
        Aadd(aHeader,{Trim(X3Titulo()),;	//01
                      SX3->X3_CAMPO,;		//02
                      SX3->X3_PICTURE,;		//03
                      SX3->X3_TAMANHO,;		//04
                      SX3->X3_DECIMAL,;		//05
                      SX3->X3_VALID,;		//06
                      SX3->X3_USADO,;		//07
                      SX3->X3_TIPO,;		//08
        			  SX3->X3_F3,;			//09
					  SX3->X3_CONTEXT,;		//10
					  SX3->X3_CBOX,;		//11
					  SX3->X3_RELACAO})		//12
		                  
	EndIf
	DbSkip()
End

Return

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Montagem do relatÛrio a partir do dicion·rio de dados da consulta personalizada

@author Wagner Mobile Costa
@version P12
@since 05/05/2015
/*/
//-----------------------------------------------------------------------------
User Function QRYXREP(cPQ1_ID)

Local aArea := GetArea(), aAreaPQ1 := PQ1->(GetArea())

If cPQ1_ID = Nil .Or. ValType(cPQ1_ID) <> "C"
	Alert("AtenÁ„o. O Id do relatÛrio n„o foi enviado !")
	Return
EndIf

PQ1->(DbSeek(xFilial() + Left(cPQ1_ID + Space(Len(PQ1->PQ1_ID)), Len(PQ1->PQ1_ID))))
cPerg   := AllTrim(PQ1->PQ1_SX1)
aOrd    := {}
cTitulo	:= Capital(AllTrim(PQ1->PQ1_NOME))
cDescri := AllTrim(PQ1->PQ1_HELP)

If ! Empty(cPerg)
	Pergunte(cPerg, .F.)
EndIf

oReport := ReportDef()
oReport:PrintDialog()

PQ1->(RestArea(aAreaPQ1))
RestArea(aArea) 

Return


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ LockByFl  ∫ Autor ≥ Fernando Salvatori ∫ Data ≥ 10/09/2013 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ Realiza um Lock via Arquivo                                ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ ACCSTA13                                                   ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
User Function LockByFl( cLockName )
Local nHdlLck  := 0
Static aHdlLck := {} //Para ser usada no UnLockByTDI

MakeDir("\semaforo\")

nHdlLck := FCreate( "\semaforo\"+cLockName+".lck" )

If nHdlLck > 0
	AAdd( aHdlLck, {cLockName,nHdlLck} )
EndIf

Return !(nHdlLck < 0)

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥UnLockByFl ∫ Autor ≥ Fernando Salvatori ∫ Data ≥ 10/09/2013 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ Realiza UnLock via Arquivo                                 ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ ACCSTA13                                                   ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
User Function UnLockByFl( cLockName )
Local nScan := 0

nScan := aScan( aHdlLck, {|x| x[1] == cLockName} )

If nScan > 0
	FClose( aHdlLck[nScan,2] )
	aDel(aHdlLck,nScan)
	aSize(aHdlLck,Len(aHdlLck)-1)
EndIf

Return Nil

// Integracoes Rest

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Rotina para geraÁ„o de integraÁ„o com Rest a partir de formul·rio da consulta

@author Wagner Mobile Costa
@version P12
@since 09/05/2018
/*/
//-----------------------------------------------------------------------------
User Function TGERREST(cPN2_CINTEG, cPN4_PROCESS, cPQ1_ID, cEMP)

Local nPar 		:= 1
Local nStru		:= 0
Local nData		:= 0
Local cToKenExt	:= ""
Local cRetWsErro:= ""
Local cMsgVld 	:= ""
Local cRetWsPad := ""
Local cRetWsErro:= ""
Local oCQueryBkp:= Nil 
Local aStruJson := {}
Local aJson		:= {}
Local aData		:= {}
Local xConteudo := Nil
Local lContinua := .F.
Local cAlias    := ""
Local aJoin		:= ""
Local cFilter	:= ""

Local cPNE_ID     := ""
Local cPNE_TAGPRC := ""
Local cPNE_ORDPRC := ""
Local cPNE_OWNER  := ""

DEFAULT cEmp := cNumEmp

If Select("SM0") == 0
	RpcSetType(3)
	RpcSetEnv(cEmp, "01",,,'PMS')
EndIf

__cUserID := "000000"

cPQ1_ID := Left(cPQ1_ID + Space(Len(PQ1->PQ1_ID)), Len(PQ1->PQ1_ID))
If PQ1->PQ1_ID <> cPQ1_ID
	PQ1->(DbSetOrder(1))
	PQ1->(DbSeek(xFilial() + cPQ1_ID))
EndIf

For nPar := 1 To 30
	&("mv_par" + StrZero(nPar, 2)) := ""
Next

PQ1->(DbSetOrder(1))
PQ1->(DbSeek(xFilial() + cPQ1_ID))
aArea := PQ1->(GetArea())
__PQ1_ID    := cPQ1_ID
__PQ1_PRSQL := ""

Private cCadastro := cTitulo := Capital(AllTrim(PQ1->PQ1_NOME))

M->PQ1_ID := PQ1->PQ1_ID
cPerg := AllTrim(PQ1->PQ1_SX1)

If Type("oCQuery") = "O"
	oCQueryBkp := oCQuery
EndIf

PN4->(DbSetOrder(1))
PN4->(DbSeek(xFilial() + cPN4_PROCESS))
 
//Montagem do Json
BeginSQL Alias "QRY"
	SELECT R_E_C_N_O_ AS PNE_RECNO 
	  FROM %Table:PNE%
	 WHERE PNE_FILIAL = %Exp:xFilial("PNE")% AND PNE_CINTEG = %Exp:cPN2_CINTEG% AND PNE_PROCES = %Exp:cPN4_PROCESS%  
	   AND %NotDel%   
	 ORDER BY PNE_ORDPRC, PNE_ORDEM
EndSql
aStruJSon := {}
cPNE_ORDPRC := ""
cPNE_TAGPRC := ""
While ! QRY->(Eof())
	PNE->(DbGoTo(QRY->PNE_RECNO))
	If Empty(PNE->PNE_ID)
		QRY->(DbSkip())
		Loop
	EndIf
	
	If 	PNE->PNE_ID <> cPNE_ID .Or.;
		PNE->PNE_ORDPRC <> cPNE_ORDPRC .Or. cPNE_TAGPRC <> PNE->PNE_TAGPRC .Or. cPNE_OWNER  <> PNE->PNE_OWNER
		Aadd(aStruJson, { AllTrim(PNE->PNE_TAGPRC), PNE->PNE_ORDPRC, FindQry(AllTrim(PNE->PNE_ID)),;
						  FindQry(AllTrim(PNE->PNE_OWNER)), PNE->PNE_ID, PNE->PNE_OWN_TG, {} } )
	EndIf 
	Aadd(aStruJson[Len(aStruJson)][7], { AllTrim(PNE->PNE_JSON), AllTrim(PNE->PNE_CAMPO), AllTrim(PNE->PNE_ADVPL) })
	cPNE_ID     := PNE->PNE_ID
	cPNE_ORDPRC := PNE->PNE_ORDPRC
	cPNE_TAGPRC := PNE->PNE_TAGPRC  
	cPNE_OWNER  := PNE->PNE_OWNER
	QRY->(DbSkip())
EndDo
QRY->(DbCloseArea())

If oCQuery:cId <> cPQ1_ID
	oCQuery := TCQuery():New(cPQ1_ID)
	Aadd(aQuery, { cPQ1_ID, oCQuery, {}, Nil, "" })
	If ! oCQuery:Activate()
		Return .F.
	EndIf
EndIf
DbSelectArea(ocQuery:cAlias)
DbGoTop()

While ! (oCQUERY:cAlias)->(Eof())
	cJson := ""
	If ( lOk := U_TGtTknAqds( cPN2_CINTEG, cPN4_PROCESS, @cToKenExt , @cRetWsErro ) )
		aBody  := {}
		For nStru := 1 To Len(aStruJson)
			lContinua := .T.
			cAlias := aStruJson[nStru][3]:cAlias
			If aStruJson[nStru][4] <> Nil
				DbSelectArea(cAlias)
				/*
				cFilter := "A1_COD = '" + ((aQuery[1][2]:cAlias)->A1_COD) + "' .And. " +;
						   "A1_LOJA = '" + ((aQuery[1][2]:cAlias)->A1_LOJA) + "'"
				*/
				
				aJoin := FindJoin(aStruJson[nStru][5])
				cFilter := ""
				For nData := 1 To Len(aJoin)
					If ! Empty(cFilter)
						cFilter += " .And. "
					EndIf
					cFilter += aJoin[nData][1] + " " + aJoin[nData][3] + " '" +;
							  &((aStruJson[nStru][4]:cAlias) + "->" + aJoin[nData][2]) + "'"
				Next
				
				dbSetFilter(&("{|| "+cFilter +" }"), cFilter)
				DbGoTop()
				If ! Empty(aStruJson[nStru][6])
					Aadd( aBody[Len(aBody)], { { aStruJson[nStru][1], {} }	} )
				Else
					Aadd( aBody, { { aStruJson[nStru][1], {} }	} )
				EndIf
				lContinua := ! (cAlias)->(Eof())
			EndIf
			
			While lContinua
				aJson := {}
				For nData := 1 To Len(aStruJson[nStru][7])
					aData := AClone(aStruJson[nStru][7][nData])
					If ! Empty(aData[3])
						xConteudo := U_ADVPL(aData[3])
					Else
						xConteudo := &(cAlias + "->" + aData[2])
					EndIf
					Aadd(aJson, { aData[1], xConteudo })
				Next
				lContinua := .f.

				If aStruJson[nStru][4] <> Nil 
					(cAlias)->(DbSkip())
					lContinua := ! (cAlias)->(Eof())
					If ! Empty(aStruJson[nStru][6])
						Aadd( aBody[Len(aBody)][Len(aBody[Len(aBody)])][1][2], AClone(aJson))
					Else
						Aadd( aBody[Len(aBody)][1][2], AClone(aJson))
					EndIf
				ElseIf ! Empty(aStruJson[nStru][1])
					Aadd( aBody, { aStruJson[nStru][1], AClone(aJson) } )
				ElseIf Empty(aStruJson[nStru][1])
					Aadd( aBody, AClone(aJson)	)
				EndIf
			EndDo

			If aStruJson[nStru][4] <> Nil
				DbClearFilter()
				DbGoTop()
			EndIf
		Next
		
		cJson := U_TAqRtJson({}, aBody)
		//---------------------------------
		//Consome o WS
		//---------------------------------
		lOk := U_FCsmWSAdq( oCQUERY:cAlias, cJson , cPN2_CINTEG, cPN4_PROCESS, /*cComplURL*/ , @cMsgVld, cToKenExt,;
							@cRetWsPad, @cRetWsErro , /*aHeadAPI*/ )

	EndIf

	(oCQUERY:cAlias)->(DbSkip())
EndDo

If Type("oCQueryBkp") = "O"
	oCQuery:Destroy()
	oCQuery := oCQueryBkp
EndIf

Return


//-----------------------------------------------------------
/*/{Protheus.doc} TAqRtJson
Monta o Json, para o response, com base no header e nos
dados passados para montar o array

@type function
@author Hermes
@since 14/04/2017
@version 1.0
/*/
//-----------------------------------------------------------
User Function TAqRtJson( aHdResp , aBody )
	
	Local lRet      	:= .T.
	Local nC			:= 0
	Local nI			:= 0
	Local nP			:= 0
	Local nY			:= 0
	Local nW			:= 0
	Local nX			:= 0
	Local aAux			:= {}
	Local aDados		:= {}
	Local cBody			:= ''
	Local lExtHead		:= .F.
	Local lClsChv 		:= .F.
	Local aHdAux		:= {}
	
	Default aBody   := {}
	
	If Len( aHdResp ) > 0 .Or. Len(aBody) > 0
		cBody += '{ '
	EndIf
				
	If Len( aHdResp ) > 0
	
		For nC := 1 To Len( aHdResp )
			
			aAux := aClone( aHdResp[nC][2] )
			
			If !Empty(aHdResp[nC][1])
				cBody += '	"'+aHdResp[nC][1]+'" :{ '
			EndIf
			
			For nI := 1 To Len(aAux) 
				
				Do Case
				Case ValType( aAux[ nI ][ 02 ] ) == 'C'
					cBody += ' "'+ RTrim( aAux[ nI ][ 01 ] ) +'" : "'+ StrTran( RTrim( aAux[ nI ][ 02 ] ) ,'"',"")  +'" '
				Case ValType( aAux[ nI ][ 02 ] ) == 'N'
					cBody += ' "'+ RTrim( aAux[ nI ][ 01 ] ) +'" : '+cvaltochar( aAux[ nI ][ 02 ] )  +' '
				Case ValType( aAux[ nI ][ 02 ] ) == 'D'
					cBody += ' "'+ RTrim( aAux[ nI ][ 01 ] ) +'" : "'+ RTrim( Dtos( aAux[ nI ][ 02 ] ) ) +'" '
				OtherWise
					cBody += ' "'+ RTrim( aAux[ nI ][ 01 ] ) +'" : "" '
				EndCase
				
				If nI < Len( aAux )
					cBody += ','
				EndIf
				
			Next nI
			
			If !Empty(aHdResp[nC][1])
				cBody +='}'
			EndIf
			
			If nC < Len( aHdResp )
				cBody += ','
			EndIf

		Next nC
		
		lExtHead	:= .T.
		 
	EndIf
		
	If Len(aBody) > 0
		
		If lExtHead
			
			cBody += ','

		EndIf
			
		For nP := 1 To Len( aBody )
			
			If nP > 1
				cBody += ','
			EndIf
			
			If ValType( aBody[ nP ][ 01 ] ) == 'C' .And. ValType( aBody[ nP ][ 02 ] ) == 'A'
				cBody += ' "' + aBody[ nP ][ 01 ] + '": {'	
				MontyBody(@cBody, aBody[ nP ][ 02 ])
				
				If Len(aBody[nP]) > 2
					cBody += ','
				EndIf				
				For nC := 3 To Len(aBody[ nP ])
					MontyBody(@cBody, aBody[ nP ][ nC ])
				Next 						
				cBody += '}'
				Loop
			EndIf
			
			aDados := aBody[nP] 
			
			For nC := 1 To Len (aDados)
			
				Do Case
				Case ValType( aDados[ nC ][ 02 ] ) == 'C'
					cBody += ' "'+ RTrim( aDados[ nC ][ 01 ] ) +'" : "'+ StrTran( RTrim( aDados[ nC ][ 02 ] ) ,'"',"")  +'" '
				Case ValType( aDados[ nC ][ 02 ] ) == 'N'
					cBody += ' "'+ RTrim( aDados[ nC ][ 01 ] ) +'" : '+cvaltochar( aDados[ nC ][ 02 ] )  +' '
				Case ValType( aDados[ nC ][ 02 ] ) == 'D'
					cBody += ' "'+ RTrim( aDados[ nC ][ 01 ] ) +'" : "'+ RTrim( Dtos( aDados[ nC ][ 02 ] ) ) +'" '
					
				Case ValType( aDados[ nC ][ 02 ] ) == 'A'
					
					aAux := aClone( aDados[ nC ][ 02 ] )

					cBody += ' "'+aDados[ nC ][ 01 ] +'" :[ '
										
					For nI := 1 To Len( aAux )
						cBody += '{'	
						For nY :=  1 To Len( aAux[ nI ] )
						 	
							Do Case
							Case ValType( aAux[ nI ][ nY ][ 02 ] ) == 'C'
								cBody += ' "'+ RTrim( aAux[ nI ][ nY ][ 01 ] ) +'" : "'+ StrTran(RTrim( aAux[ nI ][ nY ][ 02 ] ) ,'"',"") +'" '
							Case ValType( aAux[ nI ][ nY ][ 02 ] ) == 'N'
								cBody += ' "'+ RTrim( aAux[ nI ][ nY ][ 01 ] ) +'" : '+cvaltochar( aAux[ nI ][ nY ][ 02 ] )  +' '
							Case ValType( aAux[ nI ][ nY ][ 02 ] ) == 'D'
								cBody += ' "'+ RTrim( aAux[ nI ][ nY ][ 01 ] ) +'" : "'+ RTrim( Dtos( aAux[ nI ][ nY ][ 02 ] ) ) +'" '
							Case ValType( aAux[ nI ][ nY ][ 02 ] ) == 'A'
								aAudDet := aClone( aAux[ nI ][ nY ][ 02 ] )
								cBody += ' "'+ aAux[ nI ][ nY ][ 01 ] +'" :[ '							
													
								For nW := 1 To Len( aAudDet )
									cBody += '{'	
									For nX :=  1 To Len( aAudDet[ nW ] )
										
										Do Case
										Case ValType( aAudDet[ nW ][ nX ][ 02 ] ) == 'C'
											cBody += ' "'+ RTrim( aAudDet[ nW ][ nX ][ 01 ] ) +'" : "'+ StrTran(RTrim( aAudDet[ nW ][ nX ][ 02 ] ) ,'"',"")  +'" '
										Case ValType( aAudDet[ nW ][ nX ][ 02 ] ) == 'N'
											cBody += ' "'+ RTrim( aAudDet[ nW ][ nX ][ 01 ] ) +'" : '+cvaltochar( aAudDet[ nW ][ nX ][ 02 ] )  +' '
										Case ValType( aAudDet[ nW ][ nX ][ 02 ] ) == 'D'
											cBody += ' "'+ RTrim( aAudDet[ nW ][ nX ][ 01 ] ) +'" : "'+ RTrim( Dtos( aAudDet[ nW ][ nX ][ 02 ] ) ) +'" '
										OtherWise
											cBody += ' "'+ RTrim( aAudDet[ nW ][ nX ][ 01 ] ) +'" : "" '
										EndCase						
				
										If nX < Len( aAudDet[ nW ] )
											cBody += ','
										EndIf
										
									Next nX
									
									cBody += '}'

									If nW < Len( aAudDet  )
										cBody += ','
									EndIf
								Next nW
								
								cBody += ']'							
							
							OtherWise
								cBody += ' "'+ RTrim( aAux[ nI ][ nY ][ 01 ] ) +'" : "" '
							EndCase						
	
							If nY < Len( aAux[ nI ] )
								cBody += ','
							EndIf
							
						Next nY
						
						cBody += '}'

						If nI < Len( aAux  )
							cBody += ','
						EndIf
					Next nI
					
					cBody += ']'					
				OtherWise
					cBody += ' "'+ RTrim( aDados[ nC ][ 01 ] ) +'" : "" '
				EndCase

				If nC < Len( aDados )
					cBody += ','
				EndIf
			
			Next nC
		
		Next nP
					
	EndIf

	If Len( aHdResp ) > 0 .Or. Len(aBody) > 0
		cBody += '}'
	EndIf
		
	If Empty( cBody )
		
		cBody += '{ '
		cBody += '	"DADOS" :{'
		cBody += '		"StatusWS":"3" , ' 
		cBody += '		"Mensagem":"Erro ao Realizar o Response JSON"'
		cBody += '	}'
		cBody += '}'
		
	EndIf
	
	cBody := FwNoAccent(cBody)
	cBody := StrTran(cBody,Chr(9)," ")
	
	If Left( Alltrim( cBody ) , 1) <> "{" .And. Right( Alltrim( cBody ) , 1) <> "}"
		cBody := "{" + Alltrim( cBody ) +"}"
	EndIf
	
Return cBody

Static Function MontyBody(cBody, aAux)

Local nI		:= 0
Local aAuxDet	:= {}
Local aAudDet	:= {}

For nI := 1 To Len( aAux )
	If nI > 1
		cBody += ','
	EndIf
	Do Case
	Case ValType( aAux[ nI ][ 02 ] ) == 'C'
		cBody += ' "'+ RTrim( aAux[ nI ][ 01 ] ) +'" : "'+ StrTran(RTrim( aAux[ nI ][ 02 ] ) ,'"',"") +'" '
	Case ValType( aAux[ nI ][ 02 ] ) == 'N'
		cBody += ' "'+ RTrim( aAux[ nI ][ 01 ] ) +'" : '+cvaltochar( aAux[ nI ][ 02 ] )  +' '
	Case ValType( aAux[ nI ][ 02 ] ) == 'D'
		cBody += ' "'+ RTrim( aAux[ nI ][ 01 ] ) +'" : "'+ RTrim( Dtos( aAux[ nI ][ 02 ] ) ) +'" '
	Case ValType( aAux[ nI ][ 02 ] ) == 'A'
		
		aAuxDet := aClone( aAux[ nI ][ 02 ] )

		cBody += ' "'+aAux[ nI ][ 01 ] +'" :[ '
							
		For nI := 1 To Len( aAuxDet )
			If nI > 1
				cBody += ','
			EndIf
			cBody += '{'	
			For nY :=  1 To Len( aAuxDet[ nI ] )
			 	
				Do Case
				Case ValType( aAuxDet[ nI ][ nY ][ 02 ] ) == 'C'
					cBody += ' "'+ RTrim( aAuxDet[ nI ][ nY ][ 01 ] ) +'" : "'+ StrTran(RTrim( aAuxDet[ nI ][ nY ][ 02 ] ) ,'"',"") +'" '
				Case ValType( aAuxDet[ nI ][ nY ][ 02 ] ) == 'N'
					cBody += ' "'+ RTrim( aAuxDet[ nI ][ nY ][ 01 ] ) +'" : '+cvaltochar( aAuxDet[ nI ][ nY ][ 02 ] )  +' '
				Case ValType( aAuxDet[ nI ][ nY ][ 02 ] ) == 'D'
					cBody += ' "'+ RTrim( aAuxDet[ nI ][ nY ][ 01 ] ) +'" : "'+ RTrim( Dtos( aAuxDet[ nI ][ nY ][ 02 ] ) ) +'" '
				Case ValType( aAuxDet[ nI ][ nY ][ 02 ] ) == 'A'
					
					aAudDet := aClone( aAuxDet[ nI ][ nY ][ 02 ] )
					cBody += ' "'+ aAuxDet[ nI ][ nY ][ 01 ] +'" :[ '		
										
					For nW := 1 To Len( aAudDet )
						If nW > 1
							cBody += ','
						EndIf
						cBody += '{'	
						For nX :=  1 To Len( aAudDet[ nW ] )
							
							Do Case
							Case ValType( aAudDet[ nW ][ nX ][ 02 ] ) == 'C'
								cBody += ' "'+ RTrim( aAudDet[ nW ][ nX ][ 01 ] ) +'" : "'+ StrTran(RTrim( aAudDet[ nW ][ nX ][ 02 ] ) ,'"',"")  +'" '
							Case ValType( aAudDet[ nW ][ nX ][ 02 ] ) == 'N'
								cBody += ' "'+ RTrim( aAudDet[ nW ][ nX ][ 01 ] ) +'" : '+cvaltochar( aAudDet[ nW ][ nX ][ 02 ] )  +' '
							Case ValType( aAudDet[ nW ][ nX ][ 02 ] ) == 'D'
								cBody += ' "'+ RTrim( aAudDet[ nW ][ nX ][ 01 ] ) +'" : "'+ RTrim( Dtos( aAudDet[ nW ][ nX ][ 02 ] ) ) +'" '
							OtherWise
								cBody += ' "'+ RTrim( aAudDet[ nW ][ nX ][ 01 ] ) +'" : "" '
							EndCase						
	
							If nX < Len( aAudDet[ nW ] )
								cBody += ','
							EndIf
							
						Next nX
						
						cBody += '}'
					Next nW
					
					cBody += ']'							
				
				OtherWise
					cBody += ' "'+ RTrim( aAuxDet[ nI ][ nY ][ 01 ] ) +'" : "" '
				EndCase						

				If nY < Len( aAuxDet[ nI ] )
					cBody += ','
				EndIf
				
			Next nY
			
			cBody += '}'
		Next nI
		
		cBody += ']'					
	OtherWise
		cBody += ' "'+ RTrim( aAux[ nI ][ 01 ] ) +'" : "" '
	EndCase						
Next

Return

//------------------------------------------------------------------
/*/{Protheus.doc} TGetPN4Cnf
Retorna as configuraÁıes para consumo da API do MarketPlace

@type function
@author Hermes
@since 26/06/2017
@version 1.0
/*/
//------------------------------------------------------------------
User Function TGetPN4Cnf( cEmpAdq , cProcesso , cUrl, cMetodo , cTpMtd , aHeadAPI)
	
	Local lRet		:= .F.
	
	Default cUrl	:= ""
	Default cMetodo	:= ""
	Default cTpMtd 	:= ""
	Default aHeadApi := {}
	
	dbSelectArea( "PN4" )
	PN4->( dbSetOrder(1) ) //PN4_FILIAL+PN4_CINTEG+PN4_PROCES+PN4_TPMETO
	If PN4->( dbSeek( FWxFilial("PN4") + Padr( cEmpAdq , TamSx3("PN4_CINTEG")[1] ) + Padr( cProcesso , TamSx3("PN4_PROCES")[1] ) ) )
	
		cUrl	:= Alltrim( PN4->PN4_URLWS ) 
		cMetodo	:= U_Advpl(Alltrim( PN4->PN4_METODO ))
		cTpMtd	:= Alltrim( PN4->PN4_TPMETO )
		lRet	:= .T.
		
		If "OAUTH2" $ Upper(cUrl)
			cToken := LoadToken(PN4->PN4_TAGRET, "acess_token")
			If ! Empty(cToken)
				aadd( aHeadAPI , "Authorization: Bearer " + cToken)
			EndIf
		Else
			If PN4->(FieldPos("PN4_AUTENF")) > 0 .And. !Empty( PN4->PN4_AUTENF )
				aadd( aHeadAPI , StrTran(PN4->PN4_AUTENF,CRLF,"") )
			EndIf
		EndIf
	EndIf

Return lRet

//-----------------------------------------------------------------------------
/*/{Protheus.doc} TGtTknAqds
Get o Token do Acesso Externo, para consumir o WS externo, enviando o PUT 
(
Request)
@type function
@author Hermes
@since 12/05/2017
@version 1.0
@param cEmpAdq, character, Empresa de IntegraÁ„o
@param cProcesso, character, Codigo do Processo para consumir
@param cToken, character, Token de retorno
/*/
//-----------------------------------------------------------------------------
User Function TGtTknAqds( cEmpAdq , cProcesso , cToken , cRetWsErro )
	
	Local lRet 		:= .T.
	Local cUrl		:= "" 
	Local cMetodo	:= ""
	Local cProcTk	:= ""
	Local cRet		:= ""
	Local lToken	:= .F.
	Local cJson		:= ""
	Local aRest		:= {}
	Local oJson		:= Nil
	Local aHeadApi  := {}
	Local cTpMtd    := ""
	Local cTpMtdRq  := ""
	Local lOAUTH2   := .F.
	Local cBasic    := ""
	Local cCode 	:= ""
	
	Default cToken 	:= ""
	Default cRetWsErro := ""

	dbSelectArea( "PN4" )
	PN4->( dbSetOrder(1) ) //PN4_FILIAL+PN4_CINTEG+PN4_PROCES+PN4_TPMETO
	
	//-----------------------------------------------------------------------
	// Verifica se o Metodo a Ser consumido precisa de autenticaÁ„o
	//-----------------------------------------------------------------------
	If PN4->( dbSeek( FWxFilial("PN4") + Padr( cEmpAdq , TamSx3("PN4_CINTEG")[1] ) + Padr( cProcesso , TamSx3("PN4_PROCES")[1] ) ) )
	
		If PN4->PN4_RTOKEN == '1'

			cProcTk	:= Alltrim( PN4->PN4_PTOKEN )
			
			If !Empty(cProcTk)
				//------------------------------------------------------------------------------
				// Localiza o metodos para gerar o Token de acesso ao Metodo a ser consumido
				//------------------------------------------------------------------------------
				If U_TGetPN4Cnf( cEmpAdq , cProcTk , @cUrl, @cMetodo , @cTpMtd , @aHeadAPI)
				
					lToken := .T.
					If Len(aHeadApi) > 0
						cToken := aHeadApi[1] 
					EndIf
					
					If !Empty(PN4->PN4_USRWSE)
						AADD( aRest ,  Alltrim( PN4->PN4_USRWSE ) )
					EndIf
					If !Empty(PN4->PN4_PSWWSE)
						AADD( aRest ,  Alltrim( PN4->PN4_PSWWSE ) )
					EndIf
	
				EndIf
			Else

				If !Empty(PN4->PN4_USRWSE)
					cToken += Alltrim(PN4->PN4_USRWSE)
				EndIf
				If !Empty(PN4->PN4_PSWWSE)
					cToken += Alltrim(PN4->PN4_PSWWSE)
				EndIf
							
			EndIf
			
		EndIf
	
	Else

		lRet :=  .F.	
		cRetWsErro := "Nao configurado o endereco e metodo WS para envio das informacoes."

	EndIf

	If lToken

		cJson 	:= FMontJsGet( aRest )
		
		//-----------------------------------------------------
		//Consulta o metodo para Retorno do Token
		//-----------------------------------------------------
		cTpMtdRq := cTpMtd
		If "OAUTH2" $ Upper(cUrl)
			oRest := FWRest():New( cMetodo )
			cTpMtd := "1"
			lOAUTH2 := .T.  
		Else
			oRest := FWRest():New( cUrl + cMetodo )
		EndIf

		oRest:setPath( cJson )

		If cTpMtd == "1"
			Aadd( aHeadApi, 'Content-Type: application/json' )
			lRet := oRest:Get(aHeadApi)
		ElseIf cTpMtd == "3"
			lRet := oRest:Post(aHeadAPI)
		EndIf
		
		If ! lRet .And. lOAUTH2
			cRefresh := LoadToken(PN4->PN4_TAGRET, "refresh_token")
			cBasic := LoadToken(PN4->PN4_TAGRET, "basic")
			cCode  := LoadToken(PN4->PN4_TAGRET, "code")
			
			// Refresh Token
			If ! Empty(cRefresh) .And. ! Empty(cBasic)
				aHeadApi := {}
				Aadd( aHeadApi, 'Content-Type: application/json' )
				Aadd( aHeadApi, "Authorization: Basic " + cBasic)
				cMetodo := "/token?grant_type=refresh_token&refresh_token=" + cRefresh
				oRest := FWRest():New( cUrl)
				oRest:SetPath( cMetodo )
				lRet := oRest:Post(aHeadAPI)
			EndIf
			
			// GeraÁ„o do Token
			If ! lRet .And. ! Empty(cCode) .And. ! Empty(cBasic)
				aHeadApi := {}
				Aadd( aHeadApi, 'Content-Type: application/json' )
				Aadd( aHeadApi, "Authorization: Basic " + cBasic)
				cMetodo := "/token?grant_type=authorization_code&redirect_uri=" +; 
							GetMv("ES_URLRST",, "http://services.conceitho.com:9090/rest/OAUTHCALLBACK") +;
							"&code=" + cCode
				oRest := FWRest():New( cUrl)
				oRest:SetPath( cMetodo )
				lRet := oRest:Post(aHeadAPI)
			EndIf
			
			If lRet
				FWJsonDeserialize(oRest:GetResult(),@oJSon)
				cToken := "Authorization: Bearer " + oJson:access_token
				PN4->(RecLock('PN4', .F.))
				PN4->PN4_AUTENF := cToken 
				PN4->PN4_TAGRET := "code:" + cCode + ";basic:"+cBasic + ";" +;
								   "acess_token:" + oJson:access_token + ";refresh_token:"+oJson:refresh_token
				PN4->(MsUnLock())
			EndIf
		EndIf
						
		If lRet
			If cTpMtd == "1" .And. ! lOAUTH2 
				cToken := Alltrim( oRest:GetResult() )
				cToken := 'token : ' + StrTran(Alltrim(cToken),'"',"")
			EndIf
		Else
		
			cRetWsErro := oRest:GetLastError()
			
		EndIf

	EndIf
	
	lRet := .T.

Return lRet


Static Function LoadToken(cToken, cAction)

Local cReturn := ""
Local nPos    := 0

If (nPos := At(cAction, cToken)) > 0
	cReturn := Subs(cToken, At(cAction, cToken), Len(cToken))
	If At(";", cReturn) > 0
		cReturn := Left(cReturn, At(";", cReturn) - 1)
	EndIf
	cReturn := AllTrim(StrTran(cReturn, cAction + ":", "" ))
EndIf

Return cReturn

//----------------------------------------------------------------------
/*/{Protheus.doc} FMontJsGet
Monta o jSon para o consumo de WS Rest Get/Post, parametros

@type function
@author Hermes
@since 17/05/2017
@version 1.0
@param aRest, array, (DescriÁ„o do par‚metro)
@return ${return}, ${return_description}
@example
(examples)
@see (links_or_references)
/*/
//----------------------------------------------------------------------
Static Function FMontJsGet( aRest )

	Local nC 	:= 0
	Local cRet	:= ""
	
	If Len( aRest ) > 0
		cRet := "?"
		For nC := 1 To Len( aRest )

			cRet += IIf(nC == 1 ,"" ,"&") + Alltrim( aRest[nC] )

		Next nC 

	EndIf
	
Return cRet



//---------------------------------------------------------------------------------------
/*/{Protheus.doc} FCsmWSAdq
Consome o WS da Empresa Adquirida (Bematech), de acordo com a URL configurada e o tipo
do Metodo

@type function
@author Hermes
@since 25/04/2017
@version 1.0

@param xParam, character, string Json para o WS Rest / Ou Array de parametros do Rest
@param cCodEmp, character, Codigo da empresa de integracao
@param cProcess, character, Codigo do processo, para identificar o WS para consumo
@param cComplURL, character, complemento para a URL
@param cMsgVld, character, Msg de validaÁ„o, caso ocorra erros
@param cToKenExt ,  character, Token para adicionar no Header
@param cRetWsPad ,  character, Retorno do FWREst - GetResult
@param cRetWsErro ,  character, Retorno do FWRest - GetLasError
@param aHeadAPI, array , Arary com parametros para complementar o Header da requisiÁ„o
@return lRet , Booleam, True ou false
/*/
//---------------------------------------------------------------------------------------
User Function FCsmWSAdq(cAlias, xParam, cCodEmp, cProcesso, cComplURL, cMsgVld, cToKenExt, cRetWsPad, cRetWsErro, aHeadAPI,;
 						cEnvio)
	
	Local lRet			:= .T.
	Local oRest			:= Nil
	Local aHeader		:= {}
	Local cHeader		:= ""
	Local aRest			:= {}
	Local cRet			:= ""
	Local cUrl			:= ""
	Local cMetodo		:= ""
	Local cTpMtd		:= ""
	Local cJson			:= ""
	Local cIDRetExt		:= ""
	Local cHead			:= ""
	Local nC			:= 0
	Local lInsert		:= .F.
	Local cConsumo		:= "Get"
		
	Default cMsgVld		:= ""
	Default cComplURL	:= ""
	Default aHeadAPI	:= {}
	
	Private oJSon		:= Nil
	cRetWsPad	:= ""
	cRetWsErro	:= ""

	U_TGetPN4Cnf( cCodEmp , cProcesso, @cUrl, @cMetodo , @cTpMtd , @aHeadAPI )
	
	If Empty( cUrl ) .And. Empty( cMetodo )
		
		lRet	:= .F.
		cMsgVld := "Nao configurado o endereco e metodo WS para envio das informacoes."
		cRetWsErro := cMsgVld
		  		
	Else
	
		If !Empty(cComplURL)
			cMetodo += cComplURL
		EndIf
	
		If cTpMtd == "1"
			
			// Para o metodo GET, deve enviar o xParam como Array
			aRest	:= aClone( xParam )	
			cJson 	:= FMontJsGet( aRest )

			oRest	:= FWRest():New( cUrl + cMetodo )
			oRest:setPath( cJson )
			
			//----------------------------------------------------
			// tratamento para o Header da API
			//----------------------------------------------------
			Aadd( aHeader, 'Content-Type: application/json' ) 

			If !Empty( cToKenExt )
				Aadd( aHeader, cToKenExt )
				lRet 	:= oRest:Get(aHeader)
			Else
				lRet 	:= oRest:Get()
			EndIf

		Else

			oRest 	:= FWREST():New( cUrl ) 
			oRest:SetPath( cMetodo )

			//----------------------------------------------------
			// tratamento para o Header da API
			//----------------------------------------------------
			Aadd( aHeader, 'Content-Type: application/json' ) 

			If !Empty( cToKenExt )
				Aadd( aHeader, cToKenExt )
			EndIf
			If Len(aHeadAPI) > 0
				For nC  := 1 To Len(aHeadAPI)
					
					Aadd( aHeader, aHeadAPI[ nC ] )
					
				Next nC
			EndIf
			
			For nC := 1 To Len(aHeader)
				If ! Empty(cHeader)
					cHeader += Chr(13) + Chr(10)
				EndIF
				cHeader += aHeader[nC]
			Next
						
			If cTpMtd == "2" // Para o metodo PUT, deve enviar o xParam como String JSON
				
				cJson 	:= xParam
				lRet 	:= oRest:Put(aHeader,cJson)
				cConsumo := "Put"
				 
			ElseIf cTpMtd == "3" // Para o metodo POST, deve enviar o xParam como String JSON

				cJson 	:= xParam
				oRest:SetPostParams( cJson )
				lRet 	:= oRest:Post(aHeader)
				cConsumo := "Post"
				 
			ElseIf cTpMtd == "4" // Para o metodo DELETE, deve enviar o xParam como String JSON

				// Para o metodo DELETE, deve enviar o xParam como String JSON
				//lRet 	:= oRest:Delete(aRest,cJson)
				cConsumo := "Delete"

			ElseIf cTpMtd == "5" // Para o metodo PATCH, ( Metodo PATCH n„o implementado no FWRest ainda )
				
				cJson	:= xParam
				
				cRet	:= HTTPQuote( cUrl + cMetodo ,;
										"PATCH",;
										Nil,;
										cJson,;
										Nil,;
										aHeader,;
										@cHead)		
				cConsumo := "Patch"
			EndIf 
			
		EndIf

		If cTpMtd <> "5" // Metodo PATCH n„o implementado no FWRest ainda
		
			cRetWsPad	:= IIF( Valtype(oRest:GetResult()) <> "U", oRest:GetResult() , "")
			cRetWsErro	:= oRest:GetLastError()
		EndIf
			
		If Valtype( cRetWsPad ) == "U"
		
			lRet := .F.
			cRetWsPad 	:= ""
			cRetWsErro	:= "Sem retorno na requisicao PATCH, verifique disponibilidade do servico"
		
		Else
			FWJsonDeserialize(cRetWsPad,@oJSon)
		EndIf
		
		If Empty(cAlias)
			Return lRet
		EndIf

		PN1->(RecLock("PN1", .T.))
		PN1->PN1_FILIAL := xFilial("PN1")
		PN1->PN1_CINTEG := PN4->PN4_CINTEG
		PN1->PN1_ALIAS  := PN4->PN4_ALIAS
		PN1->PN1_FLTAB  := &((cAlias) + "->(" + AllTrim(PN4->PN4_FLTAB) + ")")
		PN1->PN1_TPEXIM := PN4->PN4_TPEXIM 
		PN1->PN1_CHAVE  := &((cAlias) + "->(" + AllTrim(PN4->PN4_CHAVE) + ")")
		PN1->PN1_RECNO  := &((cAlias) + "->RECNO")
		PN1->PN1_TPMNT  := PN4->PN4_TPMNT
		PN1->PN1_DTMNT	:= dDataBase
		PN1->PN1_HRMNT	:= Time()
		PN1->PN1_DTINTE := dDataBase
		PN1->PN1_HRINTE := Time()
		PN1->PN1_STATUS := If(lRet, "4", "2")
		cEnvio := cUrl + cMetodo + " (" + cConsumo + ")" + Chr(13) + Chr(10) + cHeader + Chr(13) + Chr(10) + cJson
		PN1->PN1_ENVIO	:= cEnvio
		PN1->PN1_RETURN := cRetWsPad + If(!Empty(cRetWsPad), Chr(13) + Chr(10), "") + cRetWsErro
		PN1->(MsUnLock())  

		PMV->(DbSetOrder(2))
		lInsert := ! PMV->(DbSeek(xFilial() + PN4->(PN4_CINTEG + PN4_ALIAS) + PN1->PN1_FLTAB + PN1->PN1_CHAVE ))
		PMV->(RecLock("PMV", lInsert))
		PMV->PMV_FILIAL := xFilial("PMV")
		PMV->PMV_CINTEG := PN1->PN1_CINTEG 
		PMV->PMV_ALIAS 	:= PN1->PN1_ALIAS 
		PMV->PMV_FLTAB 	:= PN1->PN1_FLTAB 
		PMV->PMV_CHAVE 	:= PN1->PN1_CHAVE 
		PMV->PMV_RECNO 	:= PN1->PN1_RECNO
		If oJson <> Nil .And. ! Empty(AllTrim(PN4->PN4_CVJSON)) .And. Type("oJson:" + AllTrim(PN4->PN4_CVJSON)) = "C"
			PMV->PMV_IDESTR := &("oJson:" + AllTrim(PN4->PN4_CVJSON))
		EndIf
		PMV->(MsUnLock())  
	EndIf

Return lRet

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
DefiniÁıes da estrutura do relatÛrio

@author Wagner Mobile Costa
@version P12
@since 05/05/2015
/*/
//-----------------------------------------------------------------------------
Static Function ReportDef()

Local oReport := TReport():New(AllTrim(PQ1->PQ1_FORM), cTitulo, cPerg, {|oReport| ReportPrint(oReport, cTitulo)}, cDescri,;
								/*lLandscape*/,/*uTotalText*/,/*lTotalInLine*/,/*cPageTText*/,/*lPageTInLine*/,/*lTPageBreak*/,/*nColSpace*/ 2)
Local oSecao  := MontaSec(oReport, cTitulo, PQ1->PQ1_SX2, PQ1->PQ1_ID), aAreaPQ1 := PQ1->(GetArea())

cQuery := "SELECT PQ7.PQ7_IDSUB, PQ7.PQ7_JOIN, PQ1.R_E_C_N_O_ AS PQ1_RECNO "
cQuery +=   "FROM " + RETSQLNAME("PQ7")+" PQ7 "
cQuery +=   "JOIN " + RETSQLNAME("PQ1")+" PQ1 ON PQ1.D_E_L_E_T_ = ' ' AND PQ1.PQ1_FILIAL = PQ7.PQ7_FILIAL AND PQ1.PQ1_ID = PQ7.PQ7_IDSUB "
cQuery +=  "WHERE PQ7.D_E_L_E_T_ = ' ' AND PQ7.PQ7_FILIAL='"+xFilial("PQ7")+"' AND PQ7.PQ7_ID = '" + PQ1->PQ1_ID + "' "  
cQuery +=  "ORDER BY PQ7.PQ7_ORDEM"

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"QRY",.F.,.T.)

While ! QRY->(Eof())
	PQ1->(DbGoto(QRY->PQ1_RECNO))
	MontaSec(oSecao, Capital(PQ1->PQ1_NOME), PQ1->PQ1_SX2, QRY->PQ7_IDSUB)
	Aadd(aSQL, { PQ1->PQ1_SX2, AllTrim(PQ1->PQ1_SQL), QRY->PQ7_JOIN })
	
	QRY->(DbSkip())
EndDo
QRY->(DbCloseArea())
PQ1->(RestArea(aAreaPQ1))

Return (oReport)

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Montagem da seÁ„o do relatÛrio a partir do ID da consulta personalizada

@author Wagner Mobile Costa
@version P12
@since 15/05/2015
/*/
//-----------------------------------------------------------------------------
Static Function MontaSec(oOwner, cTitulo, cTable, cPQ1_ID)

Local oSecao := TRSection():New(oOwner, cTitulo, ( "RQRY" + cTable ))

PQ2->(DbSeek(xFilial("PQ2") + cPQ1_ID))
While PQ2->(PQ2_FILIAL + PQ2_ID) == xFilial("PQ2") + cPQ1_ID .And. ! PQ2->(Eof())
	TRCell():New(oSecao,AllTrim(PQ2->PQ2_NOME),"RQRY" + cTable,AllTrim(PQ2->PQ2_TITULO),AllTrim(PQ2->PQ2_PIC), PQ2->PQ2_TAM) 
	
	PQ2->(DbSkip())
EndDo

Return oSecao

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Impress„o da estrutura do relatÛrio

@author Wagner Mobile Costa
@version P12
@since 05/05/2015
/*/
//-----------------------------------------------------------------------------
Static Function ReportPrint(oReport)

Local oSecao := oReport:Section(1)
Local aArea	 := GetArea()
Local nSecao := 0

oSecao:BeginQuery()
oSecao:SetQuery("RQRY" + AllTrim(PQ1->PQ1_SX2), U_ParserAdv(AllTrim(PQ1->PQ1_SQL)))
oSecao:EndQuery()

Public __REPTAB1 := __REPJOI1 := ""

For nSecao := 1 To Len(oSecao:aSection)
	oSecao:aSection[nSecao]:BeginQuery()
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,U_ParserAdv(aSQL[nSecao][2])),"RQRY" + AllTrim(Str(nSecao)),.F.,.T.)
	oSecao:aSection[nSecao]:EndQuery()
	If nSecao == 1
		__REPTAB1 := "RQRY" + aSQL[nSecao][1]
		__REPJOI1 := aSQL[nSecao][3]
		oSecao:SetParentFilter({|cParam| RetFilter(__REPTAB1, __REPJOI1, .F.) == cParam },;
								 	 {|| RetFilter("RQRY" + AllTrim(PQ1->PQ1_SX2), __REPJOI1, .F.) })
	ElseIf nSecao == 2
		__REPTAB2 := "RQRY" + aSQL[nSecao][1]
		__REPJOI2 := aSQL[nSecao][3]
		oSecao:SetParentFilter({|cParam| RetFilter(__REPTAB2, __REPJOI2, .F.) == cParam },;
								 	 {|| RetFilter("RQRY" + AllTrim(PQ1->PQ1_SX2), __REPJOI1, .F.) })
	EndIf								 	 
Next

oSecao:Print()

("RQRY" + AllTrim(PQ1->PQ1_SX2))->(DbCloseArea())
For nSecao := 1 To Len(oSecao:aSection)
	If Select("RQRY" + AllTrim(Str(nSecao))) > 0
		("RQRY" + AllTrim(Str(nSecao)))->(DbCloseArea())
	EndIf
Next
RestArea(aArea)

Return

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Retorna express„o para aplicaÁ„o do filtro

@author Wagner Mobile Costa
@version P12
@param = cAlias = Alias para montagem da express„o
         cJoin = cJoin = Join no formato string como E1_CLIENTE=A1_COD;E1_LOJA=A1_LOJA 
         lMaster = Express„o de filtro para o cabecalho ou detalhe
@return = Express„o para o comando:

oSecao:SetParentFilter({|cParam| QRYPD7->(PD7_FILIAL+PD7_TURMA) == cParam }, {|| QRYPD3->(PD3_FILIAL+PD3_TURMA) })
ou seja "QRYXXX->(XXX_FIELD)"
 
@since 21/05/2015
/*/
//-----------------------------------------------------------------------------
Static Function RetFilter(cAlias, cJoin, lMaster)

Local cFilter := cAlias + "->(", aJoin := U_RetJoin(cJoin), nJoin := nPos := If(lMaster, 2, 1)

For nJoin := 1 To Len(aJoin)
	If nJoin > 1
		cFilter += "+"
	EndIf
	cFilter += aJoin[nJoin][nPos]
Next

Return cFilter + ")"

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
ExecuÁ„o de job a partir da consulta personalizada

@author Wagner Mobile Costa
@version P12
@since 09/05/2018
/*/
//-----------------------------------------------------------------------------
User Function TRGEXECJ(cPQ1_ID)

Local nPar    := 1
Local nData   := 1
Local oQuery  := Nil
Local cFilter := ""
Local aExec   := {}
Local xValue  := ""

Private aQuery := {}

U_OpenSM0()

__cUserID := "000000"

cPQ1_ID := Left(cPQ1_ID + Space(Len(PQ1->PQ1_ID)), Len(PQ1->PQ1_ID))
If PQ1->PQ1_ID <> cPQ1_ID
	PQ1->(DbSetOrder(1))
	PQ1->(DbSeek(xFilial() + cPQ1_ID))
EndIf

For nPar := 1 To 30
	&("mv_par" + StrZero(nPar, 2)) := ""
Next

PQ1->(DbSetOrder(1))
PQ1->(DbSeek(xFilial() + cPQ1_ID))
aArea := PQ1->(GetArea())
__PQ1_ID    := cPQ1_ID
__PQ1_PRSQL := ""
cPQ1_JOB := PQ1->PQ1_JOB

Private cCadastro := cTitulo := Capital(AllTrim(PQ1->PQ1_NOME))

M->PQ1_ID := PQ1->PQ1_ID
cPerg := AllTrim(PQ1->PQ1_SX1)

oCQuery := TCQuery():New(cPQ1_ID)
oCQuery:lJob := .T.
Aadd(aQuery, { cPQ1_ID, oCQuery, {}, Nil, "" })
If ! oCQuery:Activate()
	ConOut("Erro ao ativar query [" + cPQ1_ID + "]")
	Return .F.
EndIf

BeginSQL Alias "QRYPQ7"
  SELECT PQ7.PQ7_IDSUB, PQ7.PQ7_JOIN, PQ7.PQ7_IDPAR 
    FROM %Table:PQ7% PQ7 
   WHERE PQ7.D_E_L_E_T_ = ' ' AND PQ7.PQ7_FILIAL = %Exp:xFilial('PQ7')% AND PQ7.PQ7_ID = %Exp:PQ1->PQ1_ID%
   ORDER BY PQ7.PQ7_ORDEM
EndSQL

While ! QRYPQ7->(Eof())
	oQuery := TCQuery():New(QRYPQ7->PQ7_IDSUB)
	oQuery:lJob := .T.
	oCQuery := oQuery
	oQuery:cPQ1_IDPAR := QRYPQ7->PQ7_IDPAR
	If ! oQuery:Activate()
		ConOut("Erro ao ativar query [" + QRYPQ7->PQ7_IDSUB + "]")
		Return .F.
	EndIf
	
	Aadd(aQuery, { cPQ1_ID, oQuery, {}, Nil, U_RetJoin(AllTrim(QRYPQ7->PQ7_JOIN)) })
	
	QRYPQ7->(DbSkip())
EndDo
QRYPQ7->(DbCloseArea())

oCQuery := aQuery[1][2]

PQ6->(DbSeek(xFilial() + cPQ1_ID))
While PQ6->PQ6_ID == cPQ1_ID .And. ! PQ6->(Eof())
	if PQ6->PQ6_TIPO == "4"
		If cPQ1_JOB == "1"
			Aadd(aExec, { PQ6->PQ6_ORDEM, "" })
		Else
			Aadd(aExec, { PQ6->PQ6_ORDEM, AllTrim(PQ6->PQ6_SQL) })
		EndIf
	endif
	
	PQ6->(DbSkip())
EndDo

If cPQ1_JOB == "1"	// Percorre cada registro da consulta e executa aÁ„o
	U_MntRtZAD(cPQ1_ID, .F., aExec)
	
	DbSelectArea(oCQuery:cAlias)
	While ! Eof()
		For nPar := 2 To Len(aQuery)
			DbSelectArea(aQuery[nPar][2]:cAlias)
			
			U_FilJoin(nPar, aQuery)
		Next
	
		For nPar := 1 To Len(aExec)
			U_ExecMemo(cPQ1_ID, aExec[nPar][1], .F.)
		Next
		
		For nPar := 2 To Len(aQuery)
			DbSelectArea(aQuery[nPar][2]:cAlias)
			DbClearFilter()
			DbGoTop()
		Next

		DbSelectArea(oCQuery:cAlias)
		DbSkip()
	EndDo
Else
	For nPar := 1 To Len(aExec)
		U_ExecSQL(aExec[nPar][2])
	Next
EndIf

oCQuery:Destroy()

Return

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Rotina para importaÁ„o de arquivo CSV e inserÁ„o via SQL, RecLock ou Rotina Automatica

@author Wagner Mobile Costa
@version P12
@since 16/05/2018
/*/
//-----------------------------------------------------------------------------
User Function TRGXLCSV()
Local aRet	  := {}
Local aSay    := {}
Local aButton := {}
Local nOpc    := 0
Local cDir	  := ""
Local cTitulo := ""
Local cDesc1  := "Esta rotina permite a importaÁ„o de arquivo no formato CSV para o banco de dados"
Local cDesc2  := "… obrigatÛrio escolher a pasta para leitura no bot„o [Parametros]."
Local cArqDes := CriaTrab(nil, .f.) + ".txt"
Local cMsg    := cTime := ""
Local nReg	  := 0
Local aArea	  := GetArea()

Private _cArquivo := ""

aAdd( aSay, cDesc1 )
aAdd( aSay, cDesc2 )

aAdd( aButton, { 5, .T., {|| _cArquivo := SelArq()    }} )
aAdd( aButton, { 1, .T., {|| nOpc := 1, FechaBatch() }} )
aAdd( aButton, { 2, .T., {|| FechaBatch()            }} )

FormBatch( cTitulo, aSay, aButton )

If nOpc <> 1
	Return
Endif

If Empty(_cArquivo)
	Aviso("AtenÁ„o", "A pasta com os arquivos a serem importados n„o foi escolhido !", {"Fechar"}, 3)
	Return
EndIf

IF !":\" $ _cArquivo
	Aviso("AtenÁ„o", "O arquivo selecionado deve estar em um drive existente na m·quina local." + CRLF + CRLF + ;
		"N„o ser· possÌvel a importaÁ„o de arquivos a partir do servidor!", {"Fechar"}, 3)
ELSEIF !File(_cArquivo)
	Aviso("AtenÁ„o", "O arquivo selecionado n„o pÙde ser localizado!", {"Fechar"})
ELSEIF !__CopyFile(Alltrim(_cArquivo), cArqDes)
	Aviso("AtenÁ„o", "Falha ao copiar o arquivo para o servidor!", {"Fechar"})
ELSE
	Processa({|| RunProc(cArqDes)})
	FErase(cArqDes)
ENDIF

RestArea(aArea)

Return

Static Function RunProc(cArqDes)

Local _nCt    := nRegTot := 0
Local cTime   := Time()
Local aFields := {}
Local nInsert := 0
Local cSQL    := cInsert := cValues := ""
Local cFields := ""
Local cFileLog:= ""
Local nLinha  := 0
Local lFound  := .F.

// nTypeImp -> 1. Sql, 2. RecLock e 3. Rotina Automatica
If Type("aFldCsv") = "U"
    aFldCsv := {}
EndIf

If Type("nTypeImp") = "U"
	nTypeImp := 1
EndIf

If Type("lChkFields") = "U"
   lChkFields := .T.
EndIf

If Type("lNumVir") = "U"
   lNumVir := .F.
EndIf

SX3->(DbSetOrder(2))
ConOut("TRGXCVSQ: Inicio: " + Time())
FT_FUSE(cArqDes)
FT_FGOTOP()
ProcRegua(nRegTot := FT_FLASTREC())
ProcessMessage()

aLinha := WfTokenChar(StrTran(FReadLine(), CRLF), ";")
FT_FSKIP()

For nLinha := 1 To Len(aLinha)
	cCampo := AllTrim(aLinha[nLinha])
    If (_nCt := Ascan(aFldCsv, {|x| x[2] == cCampo} )) > 0
    	cCampo := aFldCsv[_nCt][1] 
    EndIf
	BeginSQL Alias "QRY"
		SELECT PQ2_NOME, PQ2_TIPO, PQ2_TAM
		  FROM %Table:PQ2%
		 WHERE PQ2_FILIAL = %Exp:xFilial("PQ2")% AND PQ2_NOME = %Exp:cCampo% AND PQ2_ID = %Exp:oCQuery:cId% AND %NotDel%   
	EndSql

	lFound := ! Empty(QRY->PQ2_NOME)
	If Empty(QRY->PQ2_NOME)
		cCampo := Left(cCampo + Space(Len(SX3->X3_CAMPO)), Len(SX3->X3_CAMPO))
		lFound := SX3->(DbSeek(cCampo))
	EndIF
	
	If ! lFound
		If lChkFields 
			If ! Empty(cFields)
				cFields += ","
			EndIf 
			cFields += cCampo
		EndIf
		aadd(aFields, { "", "", 0 } )
	ElseIf Empty(QRY->PQ2_NOME)
		Do Case
			case SX3->X3_TIPO == "C"
				cX3_TIPO := "1"
			case SX3->X3_TIPO == "N"
				cX3_TIPO := "2"
			case SX3->X3_TIPO == "L"
				cX3_TIPO := "3"
			case SX3->X3_TIPO == "D"
				cX3_TIPO := "4"
			case SX3->X3_TIPO == "M"
				cX3_TIPO := "5"
		End Case
		aadd(aFields, { cCampo, cX3_TIPO, SX3->X3_TAMANHO } )
	Else
		aadd(aFields, { cCampo, QRY->PQ2_TIPO, QRY->PQ2_TAM } )
	EndIf

	IF ! Empty(cInsert)
		cInsert += ","
	EndIf
	QRY->(DbCloseArea())
	cInsert += cCampo
Next

If nTypeImp == 1	// SQL
	cInsert := "INSERT INTO " + __TABLE + " (" + cInsert + ")"
EndIf

If ! Empty(cFields)
	MsgInfo("AtenÁ„o. O(s) campo(s) [" + cFields + "] n„o foram localizados no dicion·rio do formul·rio [" +;
			oCQuery:cID + "]. Favor corrigir o CSV para reeimportar !")
	Return
EndIf

While !FT_FEOF()
	_nCt++
	
	aLinha := WfTokenChar(StrTran(FReadLine(), CRLF), ";")

	cValues := ""
	If nTypeImp == 2	//-- RecLock
		RecLock(__ALIAS, .T.)
	EndIf
	For nLinha := 1 to Len(aFields)
		If Empty(aFields[nLinha, 1])
			Loop
		EndIf
		
		_xDado := ""
		If nLinha <= Len(aLinha)
			_xDado := TRIM(aLinha[nLinha])
		EndIf
		_xDado := StrTran(_xDado, '"', '')

		// 1=Caracter;2=Numerico;3=Logico;4=data;5=Memo
		If At("<ADVPL>", _xDado)
			_xDado := U_ParserADV(_xDado)
		ElseIf aFields[nLinha, 2] $ "2,3"
			If lNumVir
				_xDado := StrTran(_xDado, ".", "")
				_xDado := StrTran(_xDado, ",", ".")
			EndIf
			_xDado := VAL(StrTran(StrTran(_xDado, ",", ""), "%",""))
		ElseIf aFields[nLinha, 2] == "4"
			_xDado := CTOD(_xDado)
			If nTypeImp == 1 	//-- Sql
				_xDado := "'" + DTOS(_xDado) + "'"
			EndIf
		ElseIf aFields[nLinha, 2] $ "1,5"
			_xDado := Left(_xDado + Space(aFields[nLinha, 3]), aFields[nLinha, 3])
			If nTypeImp == 1 	//-- Sql
				xDado += "'" + _xDado + "'"  
			EndIf
		EndIf

		IF ! Empty(cValues)
			cValues += ","
		EndIf
		If nTypeImp == 1		//-- SQL
			cValues += _xDado
		ElseIf nTypeImp == 2	//-- RecLock
			&(__ALIAS + "->" + aFields[nLinha, 1]) := _xDado 
		EndIf
	Next
	If nTypeImp == 1
		cValues += ")"
		
		cSQL := cInsert + " VALUES (" + cValues + ")"
	
		nExec := TcSqlExec(cSQL)
		cError := TcSqlError()
		IF ! Empty(cError)
			If Empty(cFileLog)
				cFileLog := CriaTrab(nil, .f.) + ".log"
			EndIf
			AutoGrLog("Linha: " + AllTrim(Str(_nCt)) + "-InstruÁ„o " + cSql + " - Erro: " + cError)
		EndIf
	ElseIf nTypeImp == 2	//-- RecLock
		(__ALIAS)->(MsUnLock())
	EndIf
		
	ConOut("TRGXCVSQ: Registro: " + AllTrim(Str(_nCt)))
	IncProc("Registro " + AllTrim(Str(_nCt)) + "/" + AllTrim(Str(nRegTot)) + "...")
	ProcessMessage()

	FT_FSKIP()
EndDo

If ! Empty(cFileLog)
	MostraErro("", cFileLog)
Else
	MsgInfo("ImportaÁ„o realizada com sucesso: Inicio: " + cTime + " - Fim: " + Time())
EndIf

ConOut("TRGXCVSQ: Final: " + Time())

FT_FUSE()

Return _nCt

Static Function SelArq()

Private _cExtens := "Arquivo Texto (*.CSV) |*.CSV|"

Return AllTrim(cGetFile(_cExtens,"Selecione o Arquivo",,,.F.,GETF_NETWORKDRIVE+GETF_LOCALFLOPPY+GETF_LOCALHARD))

Static Function MyOpenSM0()

If Select("SM0") > 0
	Return
EndIf

	dbUseArea( .T., , 'SIGAMAT.EMP', 'SM0', .T., .F. )
	dbSetIndex( 'SIGAMAT.IND' )

	DbGoTop()

	RpcSetType( 3 )
	RpcSetEnv( SM0->M0_CODIGO, SM0->M0_CODFIL )

Return

User Function Advpl(cStmt)

Local cParam := cLinha := ""
Local nExec  := 0

	cStmt := StrTran(cStmt, "<advpl>", "<ADVPL>")
	cStmt := StrTran(cStmt, "</advpl>", "</ADVPL>")
	Do While .T.
		n1 := At("<ADVPL>",SubString(cStmt,1,Len(cStmt)))
		if n1 == 0
			Exit
		endif

		n2 := At("</ADVPL>",SubString(cStmt,n1,Len(cStmt)))
		if n2 == 0 .and. n1 > 0
			Alert("InstruÁ„o Advpl [" + cStmt + "] Estrutura sem a tag </ADVPL>!")
			break
		endif

		cLinha := SubString(cStmt,n1+7,n2-8)
		cParam := cLinha

		_xSQL(@cLinha)

		if ValType(cLinha) == "C"
			cStmt := SubString(cStmt,1,n1-1)+cLinha+SubString(cStmt,n2+7+n1,Len(cStmt))
			nExec ++
		ElseIf nExec > 1
			Alert("AtenÁ„o. O parametro [" + cParam + "] n„o est· sendo substituido na Pre-SQL [" + cStmt + "] ")
			Break
		endif
	EndDo
	
Return cStmt	

Static Function _xSQL(cLinha)

cLinha := &(cLinha)

Return

Static Function FindQry(cID)

Local nQuery := 1
Local oQuery := Nil

For nQuery := 1 To Len(aQuery)
	If aQuery[nQuery][2]:cId == cID
		oQuery := aQuery[nQuery][2] 
	EndIf
Next

Return oQuery

Static Function FindJoin(cID)

Local nQuery := 1
Local aJoin  := {}

For nQuery := 1 To Len(aQuery)
	If aQuery[nQuery][2]:cId == cID
		aJoin := aQuery[nQuery][5] 
	EndIf
Next

Return aJoin

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Rotina para importaÁ„o de arquivo texto para tabela PN1

@author Wagner Mobile Costa
@version P12
@since 21/01/2019
/*/
//-----------------------------------------------------------------------------
User Function TRGTXTPN1(cPN1_CINTEG, cCab, cIte)
Local aRet	  := {}
Local aSay    := {}
Local aButton := {}
Local nOpc    := 0
Local cDir	  := ""
Local cTitulo := ""
Local cDesc1  := "Esta rotina permite a importaÁ„o de arquivo texto"
Local cDesc2  := "… obrigatÛrio escolher a pasta para leitura no bot„o [Parametros]."
Local cArqDes := CriaTrab(nil, .f.) + ".txt"
Local cMsg    := cTime := ""
Local nReg	  := 0
Local aArea	  := GetArea()

Private _cArquivo := ""

aAdd( aSay, cDesc1 )
aAdd( aSay, cDesc2 )

aAdd( aButton, { 5, .T., {|| _cArquivo := SelPN1()    }} )
aAdd( aButton, { 1, .T., {|| nOpc := 1, FechaBatch() }} )
aAdd( aButton, { 2, .T., {|| FechaBatch()            }} )

FormBatch( cTitulo, aSay, aButton )

If nOpc <> 1
	Return
Endif

If Empty(_cArquivo)
	Aviso("AtenÁ„o", "A pasta com os arquivos a serem importados n„o foi escolhido !", {"Fechar"}, 3)
	Return
EndIf

IF !":\" $ _cArquivo
	Aviso("AtenÁ„o", "O arquivo selecionado deve estar em um drive existente na m·quina local." + CRLF + CRLF + ;
		"N„o ser· possÌvel a importaÁ„o de arquivos a partir do servidor!", {"Fechar"}, 3)
ELSEIF !File(_cArquivo)
	Aviso("AtenÁ„o", "O arquivo selecionado n„o pÙde ser localizado!", {"Fechar"})
ELSEIF !__CopyFile(Alltrim(_cArquivo), cArqDes)
	Aviso("AtenÁ„o", "Falha ao copiar o arquivo para o servidor!", {"Fechar"})
ELSE
	Processa({|| ProcPN1(_cArquivo, cPN1_CINTEG, cCab, cIte, cArqDes)})
	FErase(cArqDes)
ENDIF

RestArea(aArea)

Return

Static Function SelPN1()

Private _cExtens := "Arquivo Texto (*.TXT) |*.TXT|"

Return AllTrim(cGetFile(_cExtens,"Selecione o Arquivo",,,.F.,GETF_NETWORKDRIVE+GETF_LOCALFLOPPY+GETF_LOCALHARD))

Static Function ProcPN1(cArquivo, cPN1_CINTEG, cCab, cIte, cArqDes)

Local _nCt    := nRegTot := 0
Local cTime   := Time()
Local cFileLog:= ""
Local cChave  := ""
Local nLinha  := 0

RECLOCK("PN1", .T.)
PN1->PN1_FILIAL := xFilial("PN1")
PN1->PN1_CINTEG := cPN1_CINTEG
PN1->PN1_ALIAS  := "PN1"
PN1->PN1_TPEXIM := "I"
PN1->PN1_TPMNT  := "1"
PN1->PN1_STATUS := "1"
PN1->PN1_DTMNT  := dDataBase 
PN1->PN1_HRMNT  := cTime
PN1->PN1_CHAVE  := cCab + cArquivo
PN1->(MsUnLock())

FT_FUSE(cArqDes)
FT_FGOTOP()
ProcRegua(nRegTot := FT_FLASTREC())
ProcessMessage()

While !FT_FEOF()
	_nCt++
	
	cChave := StrTran(Ft_FReadLn(), CRLF)
	RECLOCK("PN1", .T.)
	PN1->PN1_FILIAL := xFilial("PN1")
	PN1->PN1_CINTEG := cPN1_CINTEG
	PN1->PN1_ALIAS  := "PN1"
	PN1->PN1_TPEXIM := "I"
	PN1->PN1_TPMNT  := "1"
	PN1->PN1_STATUS := "1"
	PN1->PN1_DTMNT  := dDataBase 
	PN1->PN1_HRMNT  := cTime
	PN1->PN1_CHAVE  := cIte + "00"  + cChave
	PN1->(MsUnLock())
		
	ConOut("TRGTXTPN1: Registro: " + AllTrim(Str(_nCt)))
	IncProc("Registro " + AllTrim(Str(_nCt)) + "/" + AllTrim(Str(nRegTot)) + "...")
	ProcessMessage()

	FT_FSKIP()
EndDo

If ! Empty(cFileLog)
	MostraErro("", cFileLog)
Else
	MsgInfo("ImportaÁ„o realizada com sucesso: Inicio: " + cTime + " - Fim: " + Time())
EndIf

ConOut("TRGTXTPN1: Final: " + Time())

FT_FUSE()

Return _nCt

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Rotina para processamento das requisiÁıes na PN1

@author Wagner Mobile Costa
@version P12
@since 21/01/2019
/*/
//-----------------------------------------------------------------------------
User Function TRGPN1WS(cPN1_CINTEG, cPN1_PROCES, cAlias, aJoin)

Local cFilter := ""
Local nData   := 1

LogExec("Iniciando o processamento ...")

PN4->(DbSetOrder(1))
PN4->(DbSeek(xFilial() + cPN1_CINTEG + cPN1_PROCES))

If ! U_TGtTknAqds( cPN1_CINTEG, cPN1_PROCES, "" , @cRetWsErro )
	Alert("Erro ao realizar requisiÁ„o para comunicaÁ„o")
	Return
EndIf
__CONTINUA := .T.

DbSelectArea(cAlias)
DbSetOrder(2)

cFilter := ""
For nData := 1 To Len(aJoin)
	If ! Empty(cFilter)
		cFilter += " .And. "
	EndIf
	cFilter += aJoin[nData][1] + " " + aJoin[nData][3] + " '" +;
			  &((oCQuery:cAlias) + "->" + aJoin[nData][2]) + "'"
Next

dbSetFilter(&("{|| "+cFilter +" }"), cFilter)
DbGoTop()

While ! (cAlias)->(Eof()) .And. __CONTINUA
	LogExec("Processando [" + AllTrim((cAlias)->PN1_CHAVE) + "]...")

	U_ExcAdvpl(M->PQ6_GDVPL)
	
	(cAlias)->(DbSkip())
EndDo

Return

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Rotina para exportaÁ„o de arquivo CSV a partir do retorno REST da tabela PN1

@author Wagner Mobile Costa
@version P12
@since 21/01/2019
/*/
//-----------------------------------------------------------------------------
User Function TRGPN1CSV(cAlias, aJoin, cFilter)
Local aRet	  := {}
Local aSay    := {}
Local aButton := {}
Local nOpc    := 0
Local cDir	  := ""
Local cTitulo := ""
Local cDesc1  := "Esta rotina permite a exportaÁ„o do retorno do REST para arquivo CSV"
Local cDesc2  := "… obrigatÛrio escolher a pasta para gravaÁ„o no bot„o [Parametros]."
Local cArqDes := CriaTrab(nil, .f.) + ".csv"
Local cMsg    := cTime := ""
Local nReg	  := 0
Local aArea	  := GetArea()

Private _cArquivo := ""

aAdd( aSay, cDesc1 )
aAdd( aSay, cDesc2 )

aAdd( aButton, { 5, .T., {|| _cArquivo := SelPN1CSV()    }} )
aAdd( aButton, { 1, .T., {|| nOpc := 1, FechaBatch() }} )
aAdd( aButton, { 2, .T., {|| FechaBatch()            }} )

FormBatch( cTitulo, aSay, aButton )

If nOpc <> 1
	Return
Endif

If Empty(_cArquivo) .Or. Upper(Right(_cArquivo, 4)) <> '.CSV'
	Aviso("AtenÁ„o", "Deve ser informada a pasta e o nome do arquivo CSV !", {"Fechar"}, 3)
	Return
EndIf

IF !":\" $ _cArquivo
	Aviso("AtenÁ„o", "O arquivo selecionado deve estar em um drive existente na m·quina local." + CRLF + CRLF + ;
		"N„o ser· possÌvel a importaÁ„o de arquivos a partir do servidor!", {"Fechar"}, 3)
ELSE
	MsAguarde({|| ProcCSV(_cArquivo, cArqDes, cAlias, aJoin, cFilter)  },"Aguarde...","Gerando Arquivo [" + _cArquivo + "]")
	FErase(cArqDes)
ENDIF

RestArea(aArea)

Return

Static Function SelPN1CSV()

Private _cExtens := "Arquivo Texto (*.CSV) |*.CSV|"

Return AllTrim(cGetFile(_cExtens,"Selecione o Arquivo",,,.T.,GETF_NETWORKDRIVE+GETF_LOCALFLOPPY+GETF_LOCALHARD))

Static Function ProcCSV(_cArquivo, cArqDes, cAlias, aJoin, cFilter)

Local aAox 	  := {}
Local nPos    := 1
Local cLinha  := ""
Local cEol    := CHR(13) + CHR(10)
Local cJson   := ""
Local nData   := 1

Default cFilter := ""

BeginSQL Alias "QRY"
	SELECT AOX_CAMPO, AOX_REGRA1
	  FROM %Table:AOX%
	 WHERE AOX_FILIAL = %Exp:xFilial("AOX")% AND AOX_ROTINA = 'RECWSC' AND D_E_L_E_T_ = ' '
	 ORDER BY AOX_XITEM
EndSQL

While ! QRY->(Eof())
	//Adiciona Campos na Matriz
	aadd(aAox, { alltrim(QRY->AOX_CAMPO), alltrim(QRY->AOX_REGRA1) })

	QRY->(dbSkip())
EndDo
QRY->(DbCloseArea())

//FAZER A GRAVACAO EM CSV
nHandle := FCreate(cArqDes)
if nHandle == -1
	MsgAlert("N„o foi possivel criar o arquivo de Saida.", "AtenÁ„o")
	return
endif

//Grava os Campos de CabeÁalho
cLinha := ""
for nPos := 1 to len(aAox)
	cLinha += aAox[nPos,1] + ";"
next
cLinha += cEol

If FWRITE(nHandle, cLinha, len(cLinha)) != len(cLinha)
	MsgAlert("Ocorreu um erro na gravaÁ„o do arquivo <Csv>,", "AtenÁ„o")
	return
Endif

//Grava os Dados
DbSelectArea(cAlias)
For nData := 1 To Len(aJoin)
	If ! Empty(cFilter)
		cFilter += " .And. "
	EndIf
	cFilter += aJoin[nData][1] + " " + aJoin[nData][3] + " '" +;
			  &((oCQuery:cAlias) + "->" + aJoin[nData][2]) + "'"
Next

dbSetFilter(&("{|| "+cFilter +" }"), cFilter)
DbGoTop()

oJson := Nil
While ! Eof()
	PN1->(DbGoTo((cAlias)->PN1_RECNO))
	LogExec("Gravando CNPJ [" + AllTrim((cAlias)->PN1_CHAVE) + "]...")

	oJson := Nil
	cJson := ""
	If PN1->(FieldPos("PN1_RETURN")) > 0
		cJson := AllTrim(PN1->PN1_RETURN)
	Else
		cJson := AllTrim(PN1->PN1_OBSERR)
	EndIf
	FWJsonDeserialize(cJson,@oJSon)
	If Type("oJson:cnpj") <> "C"
		Loop
	EndIf
	cCnpj := right(StrTran(StrTran(StrTran(StrTran(oJson:cnpj,"."),"/",""),".",""),"-",""),14)

	cLinha := ""
	For nPos := 1 To Len(aAox)
		cDado := &(alltrim(aAox[nPos][2]))
		cDado := StrTran(cDado, ";", "")

		if empty(cDado)
			cDado := " "
		endif
		cLinha += cDado + ";"
	Next
	cLinha += cEol
	If FWRITE(nHandle, cLinha, len(cLinha)) != len(cLinha)
		MsgAlert("Ocorreu um erro na gravaÁ„o do arquivo <Csv>", "AtenÁ„o")
		return
	Endif
	DbSkip()
EndDo

FCLOSE(nHandle)

//Copia do Servidor Para Local
__CopyFile(cArqDes, _cArquivo)

MsgInfo("Arquivo [" + _cArquivo + "] gerado Com Sucesso! ")

Return

//--------------------------------------------------------------------------
/*/{Protheus.doc} MyOpenSM0
Abertura do arquivo SIGAMAT.EMP quando necess·rio

@author Wagner Mobile Costa
@since  29/06/2015
@param  Nil
@return Nil

/*/
//-------------------------------------------------------------------------
User Function OpenSM0()

Local aParam := {}

If Select("SM0") > 0
	Return .T.
EndIf

	Set Dele On
	dbUseArea( .T., , 'SIGAMAT.EMP', 'SM0', .T., .F. )
	dbSetIndex( 'SIGAMAT.IND' )
	DbGoTop()

	RpcSetType( 3 )
	RpcSetEnv( SM0->M0_CODIGO, SM0->M0_CODFIL )
	
	If LastRec() > 1 .And. ! IsBlind()
		Aadd(aParam, {1, "Empresa", Space(2), "@!"	, "", "SM0", "", 002, .F.})
		
		IF ! ParamBox(aParam, "SeleÁ„o da Empresa",, {|| AllwaysTrue()},,,,,,, .F.)
			Return .F.
		Endif
		SM0->(DbSeek(mv_par01))
		cOEmp := SM0->M0_CODIGO
		cOFil := SM0->M0_CODFIL
		RpcClearEnv()
		RpcSetEnv( cOEmp, cOFil )
	EndIf
	

Return .T.

Static Function LogExec(cLog)

If IsBlind()
	ConOut(cLog)
Else
	MsProcTxt(cLog)
	ProcessMessage()
EndIf

Return

User Function FilJoin(nQuery, aQuery)

Local aJoin   := aQuery[nQuery][5]
Local cFilter := ""

For nData := 1 To Len(aJoin)
	If ! Empty(cFilter)
		cFilter += " .And. "
	EndIf
	cFilter += aJoin[nData][1] + " " + aJoin[nData][3] + " "
	If At("(", aJoin[nData][2]) > 0
		cFilter += "'" + &(aJoin[nData][2]) + "'"
	Else
		xValue := &((aQuery[1][2]:cAlias) + "->" + aJoin[nData][2])
		If ValType(xValue) = "N"
			xValue := AllTrim(Str(xValue))
			cFilter += xValue
		Else
			cFilter += "'" + xValue + "'"
		EndIf
	EndIf
Next

If ! Empty(cFilter)
	dbSetFilter(&("{|| "+cFilter +" }"), cFilter)
EndIf
DbGoTop()

Return

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Rotina para execuÁ„o de select e retorno de campo

@author Wagner Mobile Costa
@version P12
@since 04/02/2019
/*/
//-----------------------------------------------------------------------------
User Function TRGetSQL(cFields, cFrom, cWhere, cSQL)

Local xConteudo := Nil 

DEFAULT cSQL := "SELECT " + cFields + " FROM " + cFrom + " WHERE " + cWhere

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cSQL),"QRYSQL",.F.,.T.)

xConteudo := FieldGet(1)
DbCloseArea()

Return xConteudo

//-------------------------------------------------------------------
/*/{Protheus.doc} FReadLine
Funcao para leitura de linhas com o tamanho superior a 1023

@author Norbert/Ernani/Mansano
@since 05/10/05
@return NIL
/*/
//-------------------------------------------------------------------
Static Function FReadLine()
Local cLinhaTmp  := ""
Local cLinhaM100 := ""
Local cLinAnt    := ""
Local cLinProx   := ""
Local cIdent     := ""

cLinhaTmp	:= FT_FReadLN()
If !Empty(cLinhaTmp)
	cIdent	:= MD5(cLinhaTmp,2)
	If Len(cLinhaTmp) < 1023
		cLinhaM100	:= cLinhaTmp
	Else
		cLinAnt		:= cLinhaTmp
		cLinhaM100	+= cLinAnt
		
		Ft_FSkip()
		cLinProx:= Ft_FReadLN()		
		If Len(cLinProx) >= 1023 .and. MD5(cLinProx,2) <> cIdent		
			While Len(cLinProx) >= 1023 .and. MD5(cLinProx,2) <> cIdent .and. !Ft_fEof()
				cLinhaM100 += cLinProx
				Ft_FSkip()
				cLinProx := Ft_fReadLn()
				If Len(cLinProx) < 1023 .and. MD5(cLinProx,2) <> cIdent
					cLinhaM100 += cLinProx
				EndIf
			Enddo
		Else
			cLinhaM100 += cLinProx
		EndIf
	EndIf
EndIf
Return cLinhaM100 

User Function RetTel(cTelefone)

If At(")", cTelefone) > 0
	cTelefone := Subs(cTelefone, At(")", cTelefone) + 1)
EndIf

If At("/", cTelefone) > 0
	cTelefone := Left(cTelefone, At("/", cTelefone) - 1)
EndIf

Return AllTrim(cTelefone)

//-----------------------------------------------------------------------------
/*/ {Protheus.doc} Function
Rotina para processamento de while em tabela

@author Wagner Mobile Costa
@version P12
@since 21/01/2019
/*/
//-----------------------------------------------------------------------------
User Function TRGWHILE(cAlias, cADVPL, aJoin)

Local cFilter := ""
Local nData   := 1

DbSelectArea(cAlias)

If Len(aJoin) > 0
	cFilter := ""
	For nData := 1 To Len(aJoin)
		If ! Empty(cFilter)
			cFilter += " .And. "
		EndIf
		cFilter += aJoin[nData][1] + " " + aJoin[nData][3] + " '" +;
				  &((oCQuery:cAlias) + "->" + aJoin[nData][2]) + "'"
	Next
	
	dbSetFilter(&("{|| "+cFilter +" }"), cFilter)
EndIf
DbGoTop()

While ! (cAlias)->(Eof()) .And. ! __EXIT
	U_ExcAdvpl(cADVPL)
	
	(cAlias)->(DbSkip())
EndDo

Return

/*/{Protheus.doc} MostraErro
Retorna conteudo da mensagem do MostraErro()
@author mobile
@since 13/08/2015
@version 1.0
/*/
User Function GetAutoErro()
Local cPath	:= GetSrvProfString("Startpath","")
Local cArq	:= "Erro_Rot_Auto_"+Dtos(dDataBase)+"_"+StrTran(Time(),":","_")+Alltrim(Str(ThreadID()))+".txt"
Local cRet	:= ""

MostraErro( cPath , cArq )
cRet	:= MemoRead(  cPath + '\' + cArq )
fErase(cArq)
Return AllTrim(cRet)

User Function MostraErro(cTitulo,cMemo)
Local oDlg
Local cMemo
Local cFile    :=""
Local cMask    := "Arquivos Texto (*.TXT) |*.txt|"
Local oFont 

DEFINE FONT oFont NAME "Courier New" SIZE 5,0   //6,15

DEFINE MSDIALOG oDlg TITLE cTitulo From 3,0 to 340,417 PIXEL

@ 5,5 GET oMemo  VAR cMemo MEMO SIZE 200,145 OF oDlg PIXEL 
oMemo:bRClicked := {||AllwaysTrue()}
oMemo:oFont:=oFont

DEFINE SBUTTON  FROM 153,175 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg PIXEL //Apaga
DEFINE SBUTTON  FROM 153,145 TYPE 13 ACTION (cFile:=cGetFile(cMask,"Salvar Como..."),If(cFile="",.t.,MemoWrite(cFile,cMemo)),oDlg:End()) ENABLE OF oDlg PIXEL //Salva e Apaga //
DEFINE SBUTTON  FROM 153,115 TYPE 6 ACTION (PrintAErr(__cFileLog,cMemo),oDlg:End()) ENABLE OF oDlg PIXEL //Imprime e Apaga

ACTIVATE MSDIALOG oDlg CENTER

Return(cMemo)