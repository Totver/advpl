Function U_IntegraExcell

Local nValor := 0, cString := "Texto"

DbSelectArea("SE1")
DbGoTop()
While ! Eof()
	nValor += E1_VALOR
	DbSkip()
Enddo	

Return cString