#Include "RwMake.Ch"

User Function SigaFat

Static lAcessou := .F. // Cria a variavel com este valor ao acessar pela primeira vez

If ! lAcessou // Somente executara quando for falsa
	Alert("Ponto Generico - SigaFat")
   lAcessou := .T. // O primeiro acesso troca o conteudo que nao e mais alterado
                   // Portanto somente e executado na primeira vez
Endif	

Return .T.

User Function Sx5Nota

Return Right(AllTrim(X5_CHAVE), 2) = xFilial("SF2")