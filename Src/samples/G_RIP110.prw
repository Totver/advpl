#include "rwmake.ch"       

User Function G_RIP110()

Private _cCtaCont  := ""  ,;
        _lContinua := .T. ,;
        _cCodLin   := ""  ,;
        _cCtaCont  := ""  ,;
        _cNomeArq  := ""  ,;
         cQuery    := ""  

_cAlias := Alias()
_nOrder := dbSetOrder()

dbSelectArea("SZZ")
dbSetOrder(1)  
dbGotop()

If Eof()
	MsgBox("Nao Existem registros no Cadastro de Parametrizacao do RIP 110")
	dbSelectArea(_cAlias)            
	dbSetOrder(_nOrder)
	Return
Endif		

Processa({|| CriaQuery()}, "Criando Query de seleção dos registros ... ")

DbSelectArea("SI1")

Return


// Função para a mostrar o INCPROC na criação da Query                 

Static Function CriaQuery()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria array para gerar arquivo de trabalho                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCampos := {}

AADD(aCampos,{"TB_LINHA"  ,"C",003,0})      /// Código da Linha da Planilha
AADD(aCampos,{"TB_ATE1ANO","N",017,2})      /// Valor Até 1 Ano 
AADD(aCampos,{"TB_APS1ANO","N",017,2})      /// Valor Após 1 Ano
AADD(aCampos,{"TB_AT30DIA","N",017,2})      /// Valor Até 30 Dias
AADD(aCampos,{"TB_AT60DIA","N",017,2})      /// Valor Até 60 Dias
AADD(aCampos,{"TB_AT90DIA","N",017,2})      /// Valor Até 90 Dias
AADD(aCampos,{"TB_MAI90DI","N",017,2})      /// Valor com Mais de 90 Dias

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_cNomeArq := CriaTrab(aCampos,.T.)
dbUseArea(.T.,, _cNomeArq,"TRB", .T. , .F. )  
_cNomArq1 := Subs(_cNomeArq,1,8)
IndRegua("TRB",_cNomArq1,"TB_LINHA",,,"Selecionando Registros...")
//dbClearIndex()
//dbSetIndex(_cNomArq1+OrdBagExt())

cQuery := "SELECT COUNT(SZZ.ZZ_CODLIN) AS SOMA "
cQuery := cQuery + " FROM     " + RetSqlName("SZZ") + " SZZ "
cQuery := cQuery + " WHERE    SZZ.ZZ_FILIAL  BETWEEN '  ' AND 'ZZ' "
cQuery := cQuery + " AND      SZZ.D_E_L_E_T_ <> '*' "

dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),"TMP", .F., .T.)
_nTotSZZ := (TMP->SOMA)
dbCloseArea()

dbSelectArea("SZZ")
dbSetOrder(1)

ProcRegua(_nTotSZZ)

While ! Eof()
    ProcessMessages()
	IncProc()
	_cCodLin  := Alltrim(SZZ->ZZ_CODLIN)+" "
	_cCtaCont := ""  

	For _nLinha := 1 to 12
		_cCtAtual := "SZZ->ZZ_CCONT" + StrZero(_nLinha,2)
        If &_cCtAtual <> " "
			_cCtaCont  := _cCtaCont + "'" + Alltrim(&_cCtAtual) + "'"        
		Else
			_lContinua := .F.
		Endif
		If _lContinua 
			_cCtaCont  := _cCtaCont + " ,"
		Else
			Exit
		EndIf
	Next

	cQuery := "SELECT '" + _cCodLin + "' TB_LINHA, "
	cQuery := cQuery + " SUM( CASE WHEN (DATEDIFF(DAY,SE2.E2_VENCREA,CAST(GETDATE() AS DATETIME)) BETWEEN 0 AND 365) THEN "
	cQuery := cQuery + "                SE2.E2_VALOR "
	cQuery := cQuery + "           END) TB_ATE1ANO, "
	cQuery := cQuery + " SUM( CASE WHEN (DATEDIFF(DAY,SE2.E2_VENCREA,CAST(GETDATE() AS DATETIME)) > 365) THEN "
	cQuery := cQuery + "                SE2.E2_VALOR "
	cQuery := cQuery + "           END) TB_APS1ANO, "
	cQuery := cQuery + " SUM( CASE WHEN (DATEDIFF(DAY,SE2.E2_VENCREA,CAST(GETDATE() AS DATETIME)) BETWEEN 0 AND 30) THEN "
	cQuery := cQuery + "                SE2.E2_VALOR "
	cQuery := cQuery + "           END) TB_AT30DIA, "
	cQuery := cQuery + " SUM( CASE WHEN (DATEDIFF(DAY,SE2.E2_VENCREA,CAST(GETDATE() AS DATETIME)) BETWEEN 0 AND 60) THEN "
	cQuery := cQuery + "                SE2.E2_VALOR "
	cQuery := cQuery + "           END) TB_AT60DIA, "
	cQuery := cQuery + " SUM( CASE WHEN (DATEDIFF(DAY,SE2.E2_VENCREA,CAST(GETDATE() AS DATETIME)) BETWEEN 0 AND 90) THEN "
	cQuery := cQuery + "                SE2.E2_VALOR "
	cQuery := cQuery + "           END) TB_AT90DIA, "
	cQuery := cQuery + " SUM( CASE WHEN (DATEDIFF(DAY,SE2.E2_VENCREA,CAST(GETDATE() AS DATETIME)) > 90) THEN "
	cQuery := cQuery + "                SE2.E2_VALOR "
	cQuery := cQuery + "           END) TB_MAI90DI "
	cQuery := cQuery + " FROM     " + RetSqlName("SE2") + " SE2 "
	cQuery := cQuery + " WHERE    SE2.E2_FILIAL  BETWEEN '  ' AND 'ZZ' "
//	cQuery := cQuery + " AND      SE2.E2_X_CONTA IN ('112011','121011') "
	cQuery := cQuery + " AND      SE2.D_E_L_E_T_ <> '*' "
	
	cQuery := cQuery + " ORDER BY TB_LINHA "
	DbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),"TMP", .F., .T.)

	dbGoTop()

	ProcRegua(RecCount())

	While ! Eof()      
		IncProc()
		ProcessMessages()
		
		_cLinha    := TMP->TB_LINHA
		_nAte1Ano  := TMP->TB_ATE1ANO
		_nApos1Ano := TMP->TB_APS1ANO
		_nAte30Dia := TMP->TB_AT30DIA
		_nAte60Dia := TMP->TB_AT60DIA
		_nAte90Dia := TMP->TB_AT90DIA
		_nMais90Di := TMP->TB_MAI90DI	

		RecLock("TRB",.T.)
		
		TRB->TB_LINHA   := _cLinha     
		TRB->TB_ATE1ANO := _nAte1Ano  
		TRB->TB_APS1ANO := _nApos1Ano  
		TRB->TB_AT30DIA := _nAte30Dia  
		TRB->TB_AT60DIA := _nAte60Dia  
		TRB->TB_AT90DIA := _nAte90Dia  
		TRB->TB_MAI90DI := _nMais90Di  	
		MsUnlock()	

		_cLinha    := ""
		_nAte1Ano  := 0
		_nApos1Ano := 0
		_nAte30Dia := 0
		_nAte60Dia := 0
		_nAte90Dia := 0
		_nMais90Di := 0

		dbSelectArea("TMP")	  
		dbSkip()  
	EndDo		
	DbSelectArea("TMP")
	dbCloseArea()
Enddo

DbSelectArea("TRB")
dbCloseArea()

Return