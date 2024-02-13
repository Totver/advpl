#INCLUDE "APWEBSRV.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

#DEFINE CRLF Chr(13) + Chr(10) 

//-------------------------------------------------------------------
/*/
Função para requisição do xml no WS NFeDistribuicaoDFe
@author     Rafael Quaresma
@since      23/02/2019
@version
/*/
//-------------------------------------------------------------------
User Function consultNFE()

Local cGzip
Local cMsgRet   :=  ""  
Local cSoap     :=  ""
Local cUrl      :=  "https://www1.nfe.fazenda.gov.br/NFeDistribuicaoDFe/NFeDistribuicaoDFe.asmx?WSDL"
Local aOps      :=  {}
Local lRet      :=  .F.
Local lRetSOAP  :=  .F.
local oWsdl     :=  nil

//Instanciando a classe TWsdlManager
oWsdl := TWsdlManager():New()

//Propriedades da classe pra poder informar os dados de certificado
oWsdl:cSSLCACertFile    := "\"
oWsdl:cSSLCertFile      := "\"
oWsdl:cSSLKeyFile       := "\"
oWsdl:cSSLKeyPwd        := ""

//Realizo o parse através do método parseURL
lRet := oWsdl:parseURL(cUrl)

if !lRet
    conout("*******deu merda*******" + oWsdl:cError)
EndiF

aOps := oWsdl:ListOPerations()

if Len(aOps) == 0
    conout("***"+oWsdl:cError+"***")
EndiF

//ops disponíveis no ws
varinfo("**",aOps)

// Define a operação o método é [nfeDistDFeInteresse] 
lRet := oWsdl:SetOperation("nfeDistDFeInteresse")

//caso de merda
If !lRet
    conout("Erro SetOperation: " + oWsdl:cError)
    return
EndIf

//Tentei fazer a consulta pela chave da nf porém deu rejeicao 641 - NF-e indisponivel para o emitente, Nao sei se e pq a nota só fica disponivel por 90 dias...

/*
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:nfed="http://www.portalfiscal.inf.br/nfe/wsdl/NFeDistribuicaoDFe">
   <soap:Header/>
   <soap:Body>
      <nfed:nfeDistDFeInteresse>
         <!--Optional:-->
         <nfed:nfeDadosMsg>
		<distDFeInt xmlns="http://www.portalfiscal.inf.br/nfe" versao="1.01">
		<tpAmb>1</tpAmb>
		<cUFAutor>35</cUFAutor>
		<CNPJ>52099983000169</CNPJ>
		<consChNFe>  
    		<chNFe>35180752099983000169550010001018971006015658</chNFe>  
  		</consChNFe>		
		</distDFeInt>
         </nfed:nfeDadosMsg>
      </nfed:nfeDistDFeInteresse>
   </soap:Body>
</soap:Envelope>    
*/

// XML de requisição: SOAP 1.2
//Realizei a cossulta através da solicitação por NSU
cSoap := '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:nfed="http://www.portalfiscal.inf.br/nfe/wsdl/NFeDistribuicaoDFe">' + CRLF
cSoap += '   <soap:Header/>' + CRLF
cSoap += '   <soap:Body>' + CRLF
cSoap += '      <nfed:nfeDistDFeInteresse>' + CRLF
cSoap += '         <!--Optional:-->' + CRLF
cSoap += '         <nfed:nfeDadosMsg>' +CRLF
cSoap += '		<distDFeInt xmlns="http://www.portalfiscal.inf.br/nfe" versao="1.00">' + CRLF
cSoap += '		<tpAmb>1</tpAmb>' + CRLF
cSoap += '		<cUFAutor>35</cUFAutor>' + CRLF
cSoap += '		<CNPJ>52099983000169</CNPJ>' + CRLF
cSoap += '		<consNSU>' + CRLF
cSoap += '		<NSU>000000000075418</NSU>' + CRLF
cSoap += '		</consNSU>' + CRLF
cSoap += '		</distDFeInt>' + CRLF
cSoap += '        </nfed:nfeDadosMsg>' + CRLF
cSoap += '      </nfed:nfeDistDFeInteresse>' + CRLF
cSoap += '   </soap:Body>' + CRLF
cSoap += '</soap:Envelope>' + CRLF

// Envia uma mensagem SOAP personalizada ao servidor
lRetSOAP := oWsdl:SendSoapMsg(cSoap)

If !lRet
    conout( "Erro SendSoapMsg: " + oWsdl:cError )
    //Essa propriedade recebe o retorno do server
    conout( "Erro SendSoapMsg FaultCode: " + oWsdl:cFaultCode )
    Return
EndIf

//Esse cara recebe o retorno do WS
cMsgRet := oWsdl:GetSoapResponse()

conout(cMsgRet)

//Chamada da rotina para pegar o gZip
xParseXML(cMsgRet,@cGzip)
conout(cGzip)

//Após fazer o parse gera o arquivo
xDescomp(cGzip) 


    

return 

//-------------------------------------------------------------------
/*/
Realiza o parser do xml retornado por consultNFE
@author     Rafael Quaresma
@since      23/02/2019
@version
@parm  
/*/
//-------------------------------------------------------------------
Static function xParseXML(cMsgRet,cgZip)


Local cError    := ""
Local cWarning  := ""
Local lParse    := NIL
Local oXml      := NIL
 
//Gera o Objeto XML
oXml := XmlParser( cMsgRet  , "", @cError, @cWarning )

If (oXml == NIL )    
  conout("Falha ao gerar Objeto XML : "+cError+" / "+cWarning)
Endif
 
//gravo o conteúdo da propriedade do objeto ref ao Gzip
cGzip :=  oxml:_SOAP_ENVELOPE:_SOAP_BODY:_NFEDISTDFEINTERESSERESPONSE:_NFEDISTDFEINTERESSERESULT:_RETDISTDFEINT:_LOTEDISTDFEINT:_DOCZIP:TEXT

Return 


//-------------------------------------------------------------------
/*/
Funcao para descompactar o gzip devolvido pelo Sefaz
@author     Rafael Quaresma
@since      23/02/2019
@version
/*/
//-------------------------------------------------------------------
Static function xDescomp(cGzip)

Local lRet :=.F.
Local cComp :=""
Local cUncomp :=""
Local nLenComp :=0
Local nLenUncomp :=0

cComp := (cGzip)
cDecode64 := Decode64(cComp)
nLenComp := Len( cComp )

cUncomp := ""
nLenUncomp := 0

lRet := GzStrDecomp( cDecode64, nLenComp, @cUncomp )

nLenUncomp := Len( cUncomp )
nHandle := FCreate( "\string.txt" )
FWrite( nHandle, cUncomp, nLenUncomp )
FClose( nHandle )


return
