#include "protheus.ch"

User Function M410LIOK  
	Local lRet 		:= .T.
	Local nPosCodPro:=  aScan(aHeader,{|x| AllTrim(x[2]) == "C7_PRODUTO"})
	Local cProduto	:= aCols[N, nPosCodPro]
	Local nAchou	:= aScan(aCols,{|x| x[nPosCodPro] == cProduto})
	
	
	If nAchou <> N .AND. nAchou > 0 .AND. !aCols[N, Len(aHeader)+1]  
		Alert("Este produto j� foi incluido neste pedido ","Aten��o!")         	
		lRet := .F.
		
	EndIf	
	
	
Return lRet
