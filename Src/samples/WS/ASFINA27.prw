#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE 'APWEBSRV.CH' 
#INCLUDE 'FWCOMMAND.CH'

//-----------------------------------------------------------------------
/*/{Protheus.doc} ASFINA27()

WS Client para retornar a chave primária do título a receber do Protheus, 
via WS 
RealizarConsultaSQL

Chamada pela rotina ASFINA13

Exemplo: U_ASFINA27( '101', '01', '000101', '03193024660', '1', '1', '1', .T. )

@param		cEMPREENDI = Empreendimento - Z28_EMPREEN
			cQUADRA = Quadra (unidade) - Z28_BLOCO
			cLOTE = Lote (subunidade) - Z28_UNIDADE
			cCPFCNPJ = CPF/CNPJ do cliente - Z28_CPFCNPJ
			cPARCELA = Parcela - Z28_PARCELA
			cCOMPONENT = Componente  - Z28_COMPONE
			cGRUPO = Grupo - Z8_GRUPO
			lSilencio = Exibe ou nao mensagens
@return		cRET = Chave primária do Protheus
			E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
@author 	Fabio Cazarini
@since 		02/07/2016
@version 	1.0
@project	MAN0000001 - Aguassanta - Integra
/*/
//-----------------------------------------------------------------------
USER FUNCTION ASFINA27( cEMPREENDI, cQUADRA, cLOTE, cCPFCNPJ, cPARCELA, cCOMPONENT, cGRUPO, lSilencio )
	LOCAL cRET 		:= ""
	LOCAL oWsdl
	LOCAL oResult	
	LOCAL cResult	:= ""
	LOCAL xRet
	LOCAL lRet		:= .T.
	LOCAL cMsg		:= ""
	LOCAL cErro    	:= ""
	LOCAL cAviso   	:= ""
	LOCAL aSimple	:= {}
	LOCAL nX		:= 0
	LOCAL cParseURL	:= SuperGetMv("AS_RMURLWS",.T.,"http://localhost:8051") + "/wsConsultaSQL/MEX?wsdl" 
	LOCAL cUserTOP	:= SuperGetMv("AS_RMUWS",.T.,"mestre") 
	LOCAL cPassTOP	:= SuperGetMv("AS_RMPWS",.T.,"totvs")
	
	DEFAULT lSilencio := .T.
	//cParseURL := "http://172.18.63.34:8055/TOTVSBusinessConnect/wsConsultaSQL.asmx?wsdl"
	
	//-----------------------------------------------------------------------
	// Cria o objeto da classe TWsdlManager
	//-----------------------------------------------------------------------
	oWsdl := TWsdlManager():New()

	//-----------------------------------------------------------------------
	// Faz o parse de uma URL
	//-----------------------------------------------------------------------
	IF lRet
		xRet := oWsdl:ParseURL( cParseURL )
		IF xRet == .F.
			cRETSend 	:=  "Erro ao executar o ParseURL no endereço (" + cParseURL + "): " + oWsdl:cError 
			lRet 		:= .F.
		ENDIF
	ENDIF

	//-----------------------------------------------------------------------
	// Autenticacao
	//-----------------------------------------------------------------------
	IF lRet
		xRet := oWsdl:SetAuthentication( cUserTOP, cPassTOP )
		IF !xRet
			cRETSend 	:= "Não foi possível autenticar o usuário (" + cUserTOP + ") no serviço RM TOP: " + oWsdl:cError 
			lRet 		:= .F.
		ENDIF
	ENDIF
	//-----------------------------------------------------------------------
	// Define a operação
	//-----------------------------------------------------------------------
	IF lRet
		xRet := oWsdl:SetOperation( "RealizarConsultaSQL" )
		IF !xRet
			cRETSend 	:= "Não foi possível definir a operação: " + oWsdl:cError 
			lRet 		:= .F.
		ENDIF		
	ENDIF
	
	//-----------------------------------------------------------------------
	// Define os parametros
	//-----------------------------------------------------------------------
	IF lRet
//		aSimple := oWsdl:SimpleInput()

//		FOR nX := 1 TO LEN(aSimple)
//			nID		:= aSimple[nX][1]
//			cNome	:= aSimple[nX][2]
//			IF UPPER(ALLTRIM(cNome)) == "CODSENTENCA"
//				oWsdl:SetValue( 0, "ASTIN001" )
//			ENDIF
//			IF UPPER(ALLTRIM(cNome)) == "CODCOLIGADA"
//				oWsdl:SetValue( 1, "0" )
//			ENDIF
//			IF UPPER(ALLTRIM(cNome)) == "CODSISTEMA"
//				oWsdl:SetValue( 2, "X"  )
//			ENDIF
//			IF UPPER(ALLTRIM(cNome)) == "PARAMETERS"
//				oWsdl:SetValue( 3, "COMPONENTE=" + ALLTRIM(cCOMPONENT) + ";PARCELA=" + ALLTRIM(cPARCELA) + ";GRUPO=" + ALLTRIM(cGRUPO) + ";EMPREENDIMENTO=" + ALLTRIM(cEMPREENDI) + ";QUADRA=" + ALLTRIM(cQUADRA) + ";LOTE=" + ALLTRIM(cLOTE) + ";CPFCNPJ=" + ALLTRIM(cCPFCNPJ) )
//			ENDIF
//		NEXT nX

		//-----------------------------------------------------------------------
		// Pega a mensagem SOAP que será enviada ao servidor
		//-----------------------------------------------------------------------
		//cMsg := oWsdl:GetSoapMsg()
		//memowrite("wsConsultaSQL.XML",cMsg)
		
		cMsg := "<?xml version='1.0' encoding='UTF-8' standalone='no' ?>"
		cMsg += '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns1="http://www.totvs.com/">'
		cMsg += '<SOAP-ENV:Body>'
		cMsg += 	'<RealizarConsultaSQL xmlns="http://www.totvs.com/">'
		cMsg += 		'<codSentenca xmlns="http://www.totvs.com/">ASTIN001</codSentenca>'
		cMsg += 		'<codColigada xmlns="http://www.totvs.com/">0</codColigada>'
		cMsg += 		'<codSistema xmlns="http://www.totvs.com/">X</codSistema>'
		cMsg += 		'<parameters xmlns="http://www.totvs.com/">COMPONENTE=' + ALLTRIM(cCOMPONENT) + ';PARCELA=' + ALLTRIM(cPARCELA) + ';GRUPO=' + ALLTRIM(cGRUPO) + ';EMPREENDIMENTO=' + ALLTRIM(cEMPREENDI) + ';QUADRA=' + ALLTRIM(cQUADRA) + ';LOTE=' + ALLTRIM(cLOTE) + ';CPFCNPJ=' + ALLTRIM(cCPFCNPJ) + '</parameters>'
		cMsg += 	'</RealizarConsultaSQL>'
		cMsg += '</SOAP-ENV:Body>'
		cMsg += '</SOAP-ENV:Envelope>'
		
		//-----------------------------------------------------------------------
		// Envia uma mensagem SOAP personalizada ao servidor
		//-----------------------------------------------------------------------
		xRet := oWsdl:SendSoapMsg(cMsg)
		IF !xRet
			cRETSend	:= "Não foi possível enviar a mensagem ao serviço RM TOP: " + oWsdl:cError
			lRet 		:= .F.
		ENDIF
	ENDIF

	//-----------------------------------------------------------------------
	// Pega a mensagem de resposta
	//-----------------------------------------------------------------------
	IF lRet
		cXML := oWsdl:GetSoapResponse()
		cXML := STRTRAN(cXML, "&lt;", "<")
		cXML := STRTRAN(cXML, "&gt;", ">")
		cXML := STRTRAN(cXML, "&#xD;", "")
		
		IF "<IDINTEGRACAO>" $ cXML 
			oResult	:= XmlParser(cXML, "_", @cErro, @cAviso)
			IF EMPTY(cErro)
				cResult := oResult:_S_ENVELOPE:_S_BODY:_RealizarConsultaSQLResponse:_RealizarConsultaSQLResult:_NEWDATASET:_RESULTADO:_IDINTEGRACAO:TEXT				
				cRET	:= ALLTRIM(cResult)
			ELSE
				cRETSend 	:= ALLTRIM(cErro)
				
				IF lSilencio
					CONOUT("Integracao com o TIN (ASFINA27): " + cRETSend)
				ELSE
					MSGALERT( cRETSend, "Atenção" )
				ENDIF		
			ENDIF
		ENDIF
	ELSE
		IF !EMPTY(cRETSend)
			IF lSilencio
				CONOUT("Integracao com o TIN (ASFINA27): " + cRETSend)
			ELSE
				MSGALERT( cRETSend, "Atenção" )
			ENDIF	
		ENDIF
	ENDIF

RETURN cRET