#include 'protheus.ch'
#include 'parmtype.ch'

//#################
//# Programa      # APFATA08
//# Data          #   
//# Descrição     # Rotina para atualização de Moedas 
//# Desenvolvedor # Edie Carlos 
//# Empresa       # Totvs Nacoes Unidas
//# Linguagem     # eAdvpl     
//# Versão        # 12
//# Sistema       # Protheus
//# Módulo        # Faturamento
//# Tabelas       # "SZA"
//# Observação    # Usado para fazer donwload site do bacen para atualizaçãode moedas 
//#===============#
//# Atualizações  # 
//#===============#
//#################

user function APFATA08()

	Local cFile, cTexto,j, lAuto,jj := .F.
	Local cMoeda :='' 
    Local  nLinhas:=''
	If Select("SX2")==0 // Testa se está sendo rodado do menu 
		RpcClearEnv()
		RpcSetType(3)
		WFprepenv("01","01") 
		lAuto := .T. 
	EndIf 

	dDataRef := dDataBase - 1 
	cFile := DTOS(dDataRef)+".csv" 

	//cTexto := HTTPCGET("https://www4.bcb.gov.br/download/fechamento/"+cFile) 
	cTexto	:= u_DownBacen()

	nLinhas := MLCount(cTexto, 81) 
	
	If ! Empty(cTexto)

			For j := 1 to nLinhas 
				jj:=.t. 
				cLinha := Memoline(cTexto,81,j) 
				cData  := Substr(cLinha,1,10)
				cCodM  := Substr(cLinha,12,3) 
				cMoeda  := Substr(cLinha,18,3)
				cCompra := StrTran(Substr(cLinha,22,10),",",".") 
				cVenda  := StrTran(Substr(cLinha,22+11,10),",",".")
				 
	
				DbSelectArea("SZA") 
				DbSetOrder(1) 
	
					dData := CTOD(cData) 
					If DbSeek(DTOS(dData)+cMoeda) 
						Reclock("SZA",.F.) 
					Else 
						Reclock("SZA",.T.) 
						Replace ZA_DATA   With dData 
					EndIf 
					Replace ZA_CODBACE With cCodM
					Replace ZA_VLVENDA With Val(cVenda) 
					Replace ZA_VLCOMPR With Val(cCompra)
					Replace ZA_MOEDA   With cMoeda 
					MsUnlock("SZA")  

		   next 
	else 
		Alert(" Falha no processamento, verifique conexao com internet ou tente mais tarde !")       
	EndIf 

	If lAuto 
		RpcClearEnv() 
	EndIf 

Return


User Function DownBacen()
Local cRet 		:= ""
Local cURL 		:= "" 
Local nTimeOut 	:= 120 
Local aHeadOut 	:= {} 
Local cHeadRet 	:= "" 
Local cGetRet 	:= "" 
Local dData		:= (dDataBase - 1) 
cURL := "https://www4.bcb.gov.br/download/fechamento/"+DtoS(dData)+".csv"
AAdd(aHeadOut,"User-Agent: Mozilla/4.0 (compatible; Protheus "+GetBuild()+")") 

cRet := HTTPSGet(cURL,"\certs\eftec.pem","\certs\private.pem","2019","WSDL",nTimeOut, aHeadOut,@cHeadRet) 
Return cRet 