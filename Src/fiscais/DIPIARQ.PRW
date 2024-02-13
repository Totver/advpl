#Include "Protheus.ch"

User Function DIPIARQ
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Ponto de Entrada para geraÁ„o do movimento de entrada e saÌda para DIPJ
<Autor> : Wagner Mobile Costa
<Data> : 22/05/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Especifico GT Brasil - Livros Fiscais
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : P
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/                                                          

Local cArqTemp := cQuery := "", aCampos := {}, aTam := TAMSX3("F3_CFO")

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Cria arquivo para armazenar movimentacoes≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
AADD(aCampos,{"TIPOMOV"		,"C"	,01	,0	})	// "E"ntradas / "S"aidas
AADD(aCampos,{"NOTA"		,"C"	,TamSX3("F2_DOC")[1]	,0	})	// Numero da Nota
AADD(aCampos,{"SERIE"		,"C"	,03	,0	})	// Serie
AADD(aCampos,{"ITEM"		,"C"	,02	,0	})	// Item da Nota
AADD(aCampos,{"TIPO"		,"C"	,01	,0	})	// Tipo da Nota
AADD(aCampos,{"DT_ENTRADA"	,"D"	,08	,0	})	// Data de Entrada
AADD(aCampos,{"DT_EMISSAO"	,"D"	,08	,0	})	// Data de Emissao	
AADD(aCampos,{"CLIFOR"		,"C"	,06	,0	})	// Cod do Cliente/Fornecedor
AADD(aCampos,{"LOJA"		,"C"	,TamSX3("F3_LOJA")[1]	,0	})	// Loja
AADD(aCampos,{"NOME"		,"C"	,50	,0	})	// Razao social
AADD(aCampos,{"CGC"			,"C"	,18	,0	})	// CGC
AADD(aCampos,{"UF"			,"C"	,02	,0	})	// UF	
AADD(aCampos,{"TIPOCLIFOR"	,"C"	,01	,0	})	// Tipo do Cliente/Fornecedor
AADD(aCampos,{"PRODUTO"		,"C"	,15	,0	})	// Cod do Produto
AADD(aCampos,{"DESCPROD"	,"C"	,50	,0	})	// Descricao do Produto
AADD(aCampos,{"NBM"			,"C"	,12	,0	})	// Codigo NBM
AADD(aCampos,{"TES"			,"C"	,03	,0	})	// TES
AADD(aCampos,{"CFO"			,"C"	,aTAM[1],0})	// CFO
AADD(aCampos,{"VALMERC"		,"N"	,14	,2	})	// Valor da Mercadoria
AADD(aCampos,{"VALIPI"		,"N"	,14	,2	})	// Valor do IPI
AADD(aCampos,{"VMERCAD"		,"N"	,14	,2	})	// Valor da Mercadoria
cArqTemp	:=	CriaTrab(aCampos)
dbUseArea(.T.,,cArqTemp,cArqTemp,.T.,.F.)
IndRegua(cArqTemp,cArqTemp,"TIPOMOV+SERIE+NOTA+CLIFOR+LOJA",,,"Ordenando ...")

// Entradas
cQuery := "select ENT.A2_COD, ENT.A2_LOJA, ENT.A2_CGC, ENT.A2_NOME, ENT.A2_TIPO, ENT.A2_EST, ENT.B1_POSIPI, ENT.D1_TIPO, ENT.D1_CF, "
cQuery +=        "MIN(ENT.B1_COD) AS B1_COD, MIN(ENT.B1_DESC) AS B1_DESC, SUM(ENT.D1_TOTAL) AS D1_TOTAL, SUM(ENT.D1_VALIPI) AS D1_VALIPI "
cQuery += "  from "
cQuery += "(select SA2.A2_COD, SA2.A2_LOJA, SA2.A2_CGC, SA2.A2_NOME, SA2.A2_TIPO, SA2.A2_EST, SB1.B1_POSIPI, SD1.D1_TIPO, SD1.D1_CF, "
cQuery +=         "MIN(SB1.B1_COD) AS B1_COD, MIN(SB1.B1_DESC) AS B1_DESC, "
cQuery += "        SUM(CASE WHEN SD1.D1_TIPO IN ('I', 'P') "
cQuery += "                 THEN SD1.D1_VALFRE + SD1.D1_DESPESA + SD1.D1_SEGURO "
cQuery += "                 ELSE SD1.D1_TOTAL - SD1.D1_VALDESC + SD1.D1_VALFRE + SD1.D1_DESPESA + SD1.D1_SEGURO + "
cQuery += "                      CASE WHEN SF4.F4_AGREG IN ('I', 'A') THEN SD1.D1_VALICM ELSE 0 END "
cQuery += "                  END) AS D1_TOTAL, "
cQuery += "        SUM(SD1.D1_VALIPI) AS D1_VALIPI "
cQuery += "   from " + RetSQLName("SD1") + " SD1 "
cQuery += "   join " + RetSQLName("SA2") + " SA2 on SA2.D_E_L_E_T_ = ' ' AND SA2.A2_COD = SD1.D1_FORNECE AND SA2.A2_LOJA = SD1.D1_LOJA "
cQuery += "   join " + RetSQLName("SB1") + " SB1 on SB1.D_E_L_E_T_ = ' ' AND SB1.B1_FILIAL = SD1.D1_FILIAL and SB1.B1_COD = SD1.D1_COD "
cQuery += "   join " + RetSQLName("SF4") + " SF4 on SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SD1.D1_FILIAL and SF4.F4_CODIGO = SD1.D1_TES "
cQuery += "  where SD1.D_E_L_E_T_ = ' ' AND SD1.D1_FILIAL = '" + xFilial("SD1") + "' and SD1.D1_DTDIGIT between '" + StrZero(mv_par03, 4) + StrZero(mv_par01, 2) + "01' and '" + StrZero(mv_par03, 4) + StrZero(mv_par02, 2) + "31' "
cQuery += "    and SD1.D1_TIPO in ('I', 'C', 'N') "
cQuery += "  group by SA2.A2_COD, SA2.A2_LOJA, SA2.A2_CGC, SA2.A2_NOME, SA2.A2_TIPO, SA2.A2_EST, SB1.B1_POSIPI, SD1.D1_TIPO, SD1.D1_CF "
cQuery += "  union "
cQuery += "select SA1.A1_COD, SA1.A1_LOJA, SA1.A1_CGC, SA1.A1_NOME, SA1.A1_TIPO, SA1.A1_EST, SB1.B1_POSIPI, SD1.D1_TIPO, SD1.D1_CF, "
cQuery +=         "MIN(SB1.B1_COD) AS B1_COD, MIN(SB1.B1_DESC) AS B1_DESC, "
cQuery += "       SUM(CASE WHEN SD1.D1_TIPO IN ('I', 'P') "
cQuery += "                THEN SD1.D1_VALFRE + SD1.D1_DESPESA + SD1.D1_SEGURO "
cQuery += "                ELSE SD1.D1_TOTAL - SD1.D1_VALDESC + SD1.D1_VALFRE + SD1.D1_DESPESA + SD1.D1_SEGURO + "
cQuery += "                     CASE WHEN SF4.F4_AGREG IN ('I', 'A') THEN SD1.D1_VALICM ELSE 0 END "
cQuery += "                 END) AS D1_TOTAL, "
cQuery += "        SUM(SD1.D1_VALIPI) AS D1_VALIPI "
cQuery += "   from " + RetSQLName("SD1") + " SD1 "
cQuery += "   join " + RetSQLName("SA1") + " SA1 on SA1.D_E_L_E_T_ = ' ' AND SA1.A1_COD = SD1.D1_FORNECE AND SA1.A1_LOJA = SD1.D1_LOJA "
cQuery += "   join " + RetSQLName("SB1") + " SB1 on SB1.D_E_L_E_T_ = ' ' AND SB1.B1_FILIAL = SD1.D1_FILIAL and SB1.B1_COD = SD1.D1_COD "
cQuery += "   join " + RetSQLName("SF4") + " SF4 on SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SD1.D1_FILIAL and SF4.F4_CODIGO = SD1.D1_TES "
cQuery += "  where SD1.D_E_L_E_T_ = ' ' AND SD1.D1_FILIAL = '" + xFilial("SD1") + "' and SD1.D1_DTDIGIT between '" + StrZero(mv_par03, 4) + StrZero(mv_par01, 2) + "01' and '" + StrZero(mv_par03, 4) + StrZero(mv_par02, 2) + "31' "
cQuery += "    and SD1.D1_TIPO in ('B', 'D') "
cQuery += " group by SA1.A1_COD, SA1.A1_LOJA, SA1.A1_CGC, SA1.A1_NOME, SA1.A1_TIPO, SA1.A1_EST, SB1.B1_POSIPI, SD1.D1_TIPO, SD1.D1_CF) ENT "
cQuery += "group by ENT.A2_COD, ENT.A2_LOJA, ENT.A2_CGC, ENT.A2_NOME, ENT.A2_TIPO, ENT.A2_EST, ENT.B1_POSIPI, ENT.D1_TIPO, ENT.D1_CF "
cQuery += "order by ENT.A2_COD, ENT.A2_LOJA, ENT.A2_CGC, ENT.A2_NOME, ENT.A2_TIPO, ENT.A2_EST, ENT.B1_POSIPI, ENT.D1_TIPO, ENT.D1_CF"

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"QRY",.T.,.T.)
TcSetField("QRY","DT_ENTRADA","D",8,0)
TcSetField("QRY","DT_EMISSAO","D",8,0)

While ! Eof()
	dbSelectArea(cArqTemp)
	RecLock(cArqTemp,.T.)
	(cArqTemp)->TIPOMOV 		:= "E"
	(cArqTemp)->NOTA			:= ""
	(cArqTemp)->SERIE			:= ""
	(cArqTemp)->ITEM			:= ""
	(cArqTemp)->TIPO			:= QRY->D1_TIPO
	(cArqTemp)->DT_ENTRADA		:= Ctod("31/12/2012")
	(cArqTemp)->DT_EMISSAO		:= Ctod("31/12/2012")
	(cArqTemp)->CLIFOR			:= QRY->A2_COD
	(cArqTemp)->LOJA			:= QRY->A2_LOJA
	(cArqTemp)->CGC				:= QRY->A2_CGC
	(cArqTemp)->NOME			:= QRY->A2_NOME
	(cArqTemp)->TIPOCLIFOR		:= QRY->A2_TIPO
	(cArqTemp)->UF				:= QRY->A2_EST
	(cArqTemp)->PRODUTO			:= QRY->B1_COD
	(cArqTemp)->DESCPROD		:= QRY->B1_DESC
	(cArqTemp)->NBM				:= QRY->B1_POSIPI
	(cArqTemp)->TES				:= ""
	(cArqTemp)->CFO				:= QRY->D1_CF
	(cArqTemp)->VALMERC			:= QRY->D1_TOTAL
	(cArqTemp)->VMERCAD			:= QRY->D1_TOTAL
	(cArqTemp)->VALIPI			:= QRY->D1_VALIPI

	MsUnlock()
	DbSelectArea("QRY")
	DbSkip()	
EndDo
DbCloseArea()

// Saidas
cQuery := "select SAI.A1_COD, SAI.A1_LOJA, SAI.A1_CGC, SAI.A1_NOME, SAI.A1_TIPO, SAI.A1_EST, SAI.B1_POSIPI, SAI.D2_TIPO, SAI.D2_CF, "
cQuery += "       MIN(SAI.B1_COD) AS B1_COD, MIN(SAI.B1_DESC) AS B1_DESC, "
cQuery += "       SUM(SAI.D2_TOTAL) AS D2_TOTAL, SUM(SAI.D2_VALIPI) AS D2_VALIPI "
cQuery += "  from "
cQuery += "(select SA1.A1_COD, SA1.A1_LOJA, SA1.A1_CGC, SA1.A1_NOME, SA1.A1_TIPO, SA1.A1_EST, SB1.B1_POSIPI, SD2.D2_TIPO, SD2.D2_CF, "
cQuery += "        MIN(SB1.B1_COD) AS B1_COD, MIN(SB1.B1_DESC) AS B1_DESC, "
cQuery += "        SUM(CASE WHEN SD2.D2_TIPO IN ('I', 'P') "
cQuery += "                 THEN SD2.D2_VALFRE + SD2.D2_DESPESA + SD2.D2_SEGURO "
cQuery += "                 ELSE SD2.D2_TOTAL - SD2.D2_DESCON + SD2.D2_VALFRE + SD2.D2_DESPESA + SD2.D2_SEGURO "
cQuery += "                  END) AS D2_TOTAL, "
cQuery += "        SUM(SD2.D2_VALIPI) AS D2_VALIPI "
cQuery += "   from " + RetSQLName("SD2") + " SD2 "
cQuery += "   join " + RetSQLName("SA1") + " SA1 on SA1.D_E_L_E_T_ = ' ' AND SA1.A1_COD = SD2.D2_CLIENTE AND SA1.A1_LOJA = SD2.D2_LOJA "
cQuery += "   join " + RetSQLName("SB1") + " SB1 on SB1.D_E_L_E_T_ = ' ' AND SB1.B1_FILIAL = SD2.D2_FILIAL and SB1.B1_COD = SD2.D2_COD "
cQuery += "   join " + RetSQLName("SF4") + " SF4 on SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SD2.D2_FILIAL and SF4.F4_CODIGO = SD2.D2_TES "
cQuery += "  where SD2.D_E_L_E_T_ = ' ' AND SD2.D2_FILIAL = '" + xFilial("SD2") + "' and SD2.D2_EMISSAO between '" + StrZero(mv_par03, 4) + StrZero(mv_par01, 2) + "01' and '" + StrZero(mv_par03, 4) + StrZero(mv_par02, 2) + "31' "
cQuery += "    and SD2.D2_TIPO in ('I', 'C', 'N') "
cQuery += "  group by SA1.A1_COD, SA1.A1_LOJA, SA1.A1_CGC, SA1.A1_NOME, SA1.A1_TIPO, SA1.A1_EST, SB1.B1_POSIPI, SD2.D2_TIPO, SD2.D2_CF "
cQuery += "  union "
cQuery += "select SA2.A2_COD, SA2.A2_LOJA, SA2.A2_CGC, SA2.A2_NOME, SA2.A2_TIPO, SA2.A2_EST, SB1.B1_POSIPI, SD2.D2_TIPO, SD2.D2_CF, "
cQuery += "       MIN(SB1.B1_COD) AS B1_COD, MIN(SB1.B1_DESC) AS B1_DESC, "
cQuery += "       SUM(CASE WHEN SD2.D2_TIPO IN ('I', 'P') "
cQuery += "                THEN SD2.D2_VALFRE + SD2.D2_DESPESA + SD2.D2_SEGURO "
cQuery += "                ELSE SD2.D2_TOTAL - SD2.D2_DESCON + SD2.D2_VALFRE + SD2.D2_DESPESA + SD2.D2_SEGURO "
cQuery += "                 END) AS D2_TOTAL, SUM(SD2.D2_VALIPI) AS D2_VALIPI "
cQuery += "   from " + RetSQLName("SD2") + " SD2 "
cQuery += "   join " + RetSQLName("SA2") + " SA2 on SA2.D_E_L_E_T_ = ' ' AND SA2.A2_COD = SD2.D2_CLIENTE AND SA2.A2_LOJA = SD2.D2_LOJA "
cQuery += "   join " + RetSQLName("SB1") + " SB1 on SB1.D_E_L_E_T_ = ' ' AND SB1.B1_FILIAL = SD2.D2_FILIAL and SB1.B1_COD = SD2.D2_COD "
cQuery += "   join " + RetSQLName("SF4") + " SF4 on SF4.D_E_L_E_T_ = ' ' AND SF4.F4_FILIAL = SD2.D2_FILIAL and SF4.F4_CODIGO = SD2.D2_TES "
cQuery += "  where SD2.D_E_L_E_T_ = ' ' AND SD2.D2_FILIAL = '" + xFilial("SD2") + "' and SD2.D2_EMISSAO between '" + StrZero(mv_par03, 4) + StrZero(mv_par01, 2) + "01' and '" + StrZero(mv_par03, 4) + StrZero(mv_par02, 2) + "31' "
cQuery += "    and SD2.D2_TIPO in ('B', 'D') "
cQuery += " group by SA2.A2_COD, SA2.A2_LOJA, SA2.A2_CGC, SA2.A2_NOME, SA2.A2_TIPO, SA2.A2_EST, SB1.B1_POSIPI, SD2.D2_TIPO, SD2.D2_CF) SAI "
cQuery += "group by SAI.A1_COD, SAI.A1_LOJA, SAI.A1_CGC, SAI.A1_NOME, SAI.A1_TIPO, SAI.A1_EST, SAI.B1_POSIPI, SAI.D2_TIPO, SAI.D2_CF "
cQuery += "order by SAI.A1_COD, SAI.A1_LOJA, SAI.A1_CGC, SAI.A1_NOME, SAI.A1_TIPO, SAI.A1_EST, SAI.B1_POSIPI, SAI.D2_TIPO, SAI.D2_CF"

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"QRY",.T.,.T.)
TcSetField("QRY","DT_ENTRADA","D",8,0)
TcSetField("QRY","DT_EMISSAO","D",8,0)

While ! Eof()
	dbSelectArea(cArqTemp)
	RecLock(cArqTemp,.T.)
	(cArqTemp)->TIPOMOV 		:= "S"
	(cArqTemp)->NOTA			:= ""
	(cArqTemp)->SERIE			:= ""
	(cArqTemp)->ITEM			:= ""
	(cArqTemp)->TIPO			:= QRY->D2_TIPO
	(cArqTemp)->DT_ENTRADA		:= Ctod("31/12/" + StrZero(mv_par03, 4))
	(cArqTemp)->DT_EMISSAO		:= Ctod("31/12/" + StrZero(mv_par03, 4))
	(cArqTemp)->CLIFOR			:= QRY->A1_COD
	(cArqTemp)->LOJA			:= QRY->A1_LOJA
	(cArqTemp)->CGC				:= QRY->A1_CGC
	(cArqTemp)->NOME			:= QRY->A1_NOME
	(cArqTemp)->TIPOCLIFOR		:= QRY->A1_TIPO
	(cArqTemp)->UF				:= QRY->A1_EST
	(cArqTemp)->PRODUTO			:= QRY->B1_COD
	(cArqTemp)->DESCPROD		:= QRY->B1_DESC
	(cArqTemp)->NBM				:= QRY->B1_POSIPI
	(cArqTemp)->TES				:= ""
	(cArqTemp)->CFO				:= QRY->D2_CF
	(cArqTemp)->VALMERC			:= QRY->D2_TOTAL
	(cArqTemp)->VMERCAD			:= QRY->D2_TOTAL
	(cArqTemp)->VALIPI			:= QRY->D2_VALIPI

	MsUnlock()
	DbSelectArea("QRY")
	DbSkip()
EndDo
DbCloseArea()

dbSelectArea(cArqTemp)
Return (cArqTemp)