#include "protheus.ch"

/*/{Protheus.doc} M410LIOK
~Função para não deixar incluir mais de um produto repetido
@type function
@author Fabio Batista
@since 14/03/2019
@version 1.0
/*/

User Function M410LIOK  
	Local lRet 		:= .T.
	Local nPosCodPro:=  aScan(aHeader,{|x| AllTrim(x[2]) == "C7_PRODUTO"})
	Local cProduto	:= aCols[N, nPosCodPro]
	Local nAchou	:= aScan(aCols,{|x| x[nPosCodPro] == cProduto})
	
	
	If nAchou <> N .AND. nAchou > 0 .AND. !aCols[N, Len(aHeader)+1]  
		Alert("Este produto já foi incluido neste pedido ","Atenção!")         	
		lRet := .F.
		
	EndIf	
	
	
Return lRet
