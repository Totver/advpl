
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT410TOK  ºAutor  ³Microsiga           º Data ³  25/10/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Permite incluir uma linha do SC6(ITEM)automaticamente       º±±
±±º          ³quando verificado que qtdven > qtdDispo                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico Anhembiborrachas                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/





/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄgrav¸?¸?¿
//³Foi criado o Ponto de Entrada MT410TOK, para garantir que a                ³
//³quantidade a ser solicitada para fabrica produzir seja a correta           ³
//³EX: Saldo disponivel  do produto X  370                                    ³
//³Caso seja digitado 371, o sistema vai incluir uma linha com                ³
//³a quantidade de uma unidade 1  com  estatus F(Fabrica), e uma outra        ³
//³linha com a quantidade de 370 unidades com estatus M(EstoqueMatriz)        ³
//³                                                                           ³
//³Obs: Caso seja digitado uma quantidade  Menor ou Igual ao                  ³
//³saldo disponivel, o sistema gravara somente uma linha na                   ³
//³tabela de Itens (SC6), indicando que o saldo no estoque foi suficiente.    ³
//³                                                                           ³
//³25/10/2014                                                                 ³
//³                                                                           ³
//³By Washington Miranda Leão                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄgravÙ
ENDDOC*/



User Function MT410TOK()

Local aArea      := GetArea()
Local lRet       := .T.
Local nPosRequi  := GDFIELDPOS("C6_XOP")
Local nPosItem   := GDFIELDPOS("C6_ITEM")
Local nPosProd   := GDFIELDPOS("C6_PRODUTO")
Local nPosLocal  := GDFIELDPOS("C6_LOCAL")
Local nPosQtdven := GDFIELDPOS("C6_QTDVEN")
Local nPosPrcven := GDFIELDPOS("C6_PRCVEN")
Local nPosTES    := GDFIELDPOS("C6_TES")
Local nPosCF     := GDFIELDPOS("C6_CF")
Local nPosDisp   := GDFIELDPOS("C6_XSALDOA")
Local nposStatu  := GDFIELDPOS("C6_XSTATUS")
Local nx  := 0
_cCodProd := aCols[n][nPosProd]
_Armazem  := aCols[n][nPosLocal]
_nQtdven  := aCols[n][nPosQtdven]

Alert("PONTO DE ENTRADA MT410TOK- ENTROU!")

dbSelectArea("SB2")
dbSeek(xFilial("SB2")+_cCodProd+_Armazem)

_nDispo :=(SaldoSb2())
if  nPosItem = 0 .AND.nPosProd = 0 .AND. nPosLocal = 0.AND. nPosRequi = 0 .AND. nPosDisp = 0 .AND.nPosStatu = 0 ;
	.AND. nPosQTDVEN = 0 .AND. nPosPRCVEN = 0 .AND. nPosTES = 0 .AND. nPosCF = 0
	Alert("Campos não localizados !")
	Return .T.
EndIf




For nx := 1 To Len(aCols)
	If nX = Len(aCols)
		If _nDispo >0
			Alert("SALDO DISPONIVEL MAIOR QUE ZERO PARA ESTE PRODUTO")
			If _nQtdven >_nDispo
				Alert("QUANTIDADE DIGITADA MAIOR QUE O SALDO DISPONIVEL PARA ESTE PRODUTO")
				aCols[nx][nPosQTDVEN]=_nDispo //Alimenta a quantidade da segunda linha do acols
				aCols[nx][nposStatu] = "M"
				Aadd(aCols, AClone(aCols[Len(aCols)]))
				
				aCols[Len(aCols)][nPosItem]  := soma1( acols[Len(acols)-1][GDFIELDPOS("C6_ITEM")])
				aCols[Len(aCols)][nPosRequi]  := soma1( acols[Len(acols)-1][GDFIELDPOS("C6_XOP")])
				nResult:=_nQtdven-_nDispo
				aCols[nx][nPosQTDVEN]= nResult
				aCols[nx][nPosDisp ]:= 0 // nResult
				aCols[nx][nposStatu]  = "F"
			
				
			ElseIf _nQtdven <=_nDispo
				Alert("QUANTIDADE DIGITADA MENOR OU IGUAL AO SALDO DISPONIVEL")
				nResult:=_nDispo - _nQtdven
				aCols[nx][nPosDisp ]:= nResult
				aCols[nx][nposStatu] :="M"
				Loop
				
			EndIf
		ElseIf _nDispo <=0
			ALERT("SALDO DISPONIVEL MENOR OU IGUAL A ZERO")
		      //	nResult:=_nQtdven-_nDispo
			//	aCols[nx][nPosQTDVEN]= nResult
				aCols[nx][nPosDisp ]:= 0 // nResult
				aCols[nx][nposStatu]  = "F"
			
		
			
		EndIf
		
	Endif
Next  nX

RestArea(aArea)

RETURN .T.
