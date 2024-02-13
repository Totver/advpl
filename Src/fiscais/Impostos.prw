Function U_Impostos

M->A1_COD   := "000003"
M->A1_LOJA  := "01"
M->C6_COD   := Left("001" + Space(Len(SB1->B1_COD)), Len(SB1->B1_COD))
M->C6_QUANT := 1
M->C6_VUNIT := 1000
M->C6_TES   := "501"

U_MFsSave()
U_MFsEnd()
U_MFsIni( M->A1_COD,M->A1_LOJA, "C", "N", ,,,.T.,,"MATA410")
// U_MFsAlt("NF_NATUREZA", SuperGetMV("MV_2DUPNAT",.F.,"") )

U_MFsAdd( M->C6_COD,;	// 1-Codigo do Produto ( Obrigatorio )
M->C6_TES,;		 			// 2-Codigo do TES ( Opcional )
M->C6_QUANT,;		 	// 3-Quantidade ( Obrigatorio )
M->C6_VUNIT,;			// 4-Preco Unitario ( Obrigatorio )
0,;		  	 			// 5-Valor do Desconto ( Opcional )
"",;           			// 6-Numero da NF Original ( Devolucao/Benef )
"",;           			// 7-Serie da NF Original ( Devolucao/Benef )
0,;			 			// 8-RecNo da NF Original no arq SD1/SD2
0,;			 			// 9-Valor do Frete do Item ( Opcional )
0,;			 			// 10-Valor da Despesa do item ( Opcional )
0,;			 			// 11-Valor do Seguro do item ( Opcional )
0,;			 			// 12-Valor do Frete Autonomo ( Opcional )
(M->C6_QUANT * M->C6_VUNIT),;  	 // 13-Valor da Mercadoria ( Obrigatorio )
0,;			 		// 14-Valor da Embalagem ( Opiconal )
Nil,; 		 		// 15-RecNo do SB1
Nil)			 	// 16-RecNo do SF4

aRetImp := U_MFsNFCab()

U_MFsEnd()     	
U_MFsRestore()

Return