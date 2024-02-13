#include 'rwmake.ch'
#include 'protheus.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ MPFATCLOS บAutor ณCristian Verneque    บ Data ณ  05/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Faturamento por Cliente ( em formato grafico )             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Financeiro                                                 บฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ MOTIVO                                          บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MPFATCLOS()
Private	lEnd		:= .f.
Private	aAreaZA1	:= SZ1->(GetArea())
Private	cPerg		:= PADR("MPFT010002",10)
Private nPag        := 0
Private MVPAR01     := ''
Private MVPAR02     := ''
Private MVPAR03     := ''
Private MVPAR04     := ''
Private MVPAR05     := ''
Private MVPAR06     := ''
Private MVPAR07     := ''
Private MVPAR08     := ''
Private MVPAR09     := ''
Private MVPAR10     := ''
//Private MVPAR11     := ''

Private MVPAR01_2    := ''
Private MVPAR08_2    := ''
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณAjusta os parametros.ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
CriaSX1(cPerg)

If	( ! Pergunte(cPerg,.T.) )
	Return
EndIf
MVPAR01     := MV_PAR01
MVPAR02     := MV_PAR02
MVPAR03     := MV_PAR03
MVPAR04     := MV_PAR04
MVPAR05     := MV_PAR05
MVPAR06     := MV_PAR06
MVPAR07     := MV_PAR07
MVPAR08     := MV_PAR08
MVPAR09     := MV_PAR09
MVPAR10     := MV_PAR10
//MVPAR11     := MV_PAR11

MVPAR08_2 := ''

If !Empty(MVPAR08)
	For _xVar := 1 to Len(MV_PAR08) step 1
		MVPAR08_2 += "'"+SubStr(MVPAR08,_xVar,1)+"'"
		If ( Len(MVPAR08) - _xVar ) >= 1 .And. !Empty(SubStr(MVPAR08,_xVar,1))
			MVPAR08_2 += ","
		EndIf
	Next
EndIf


If MVPAR01 == MVPAR02
		CriaSX1_2("MPFT040001")
	                                                                      
	If	( ! Pergunte("MPFT040001",.T.) )
		Return
	EndIf
	MVPAR01_2 := ''
	
	If !Empty(MV_PAR01)
		For _xVar := 1 to Len(MV_PAR01) step 6
			MVPAR01_2 += "'"+SubStr(MV_PAR01,_xVar,6)+"'"
			If ( Len(MV_PAR01) - _xVar ) > 6
				MVPAR01_2 += ","
			EndIf
		Next
	EndIf
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณExecuta a rotina de impressao ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Processa({ |lEnd| xPrintRel(),OemToAnsi('Gerando o relat๓rio.')}, OemToAnsi('Aguarde...'))

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณRestaura a area anterior ao processamento. !ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
RestArea(aAreaZA1)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ xPrintRelบAutor ณCristian Verneque    บ Data ณ  05/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprimir os chamados de acordo com os parametros           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Funcao Principal                                           บฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ MOTIVO                                          บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function xPrintRel()

Local oMainWnd := Nil

Private cQuery
Private TRB010 := GetNextAlias()
Private lRet1 := .F.
Private	oPrint := TMSPrinter():New(OemToAnsi('Faturamento por cliente'))
//Private	oPrint := FWMsPrinter(): New ( cperg, ,.T., [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF], [ nQtdCopy] )


Private nRGBColor := CLR_BLACK

oBrush		:= TBrush():New(,4)  
oPen 		:= TPen():New(,150,nRGBColor,oMainWnd)
cFileLogo	:= GetSrvProfString('Startpath','') + 'LGRL01.BMP'
oArial18N	:= TFont():New("Arial",18,18,,.T.,,,,.T.,.F.)		//negrito
oArial14N	:= TFont():New("Arial",14,14,,.T.,,,,.T.,.F.)		//negrito
oArial10N	:= TFont():New("Arial",10,10,,.T.,,,,.T.,.F.)		//negrito
oArial10	:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)		//Normal s/negrito
oArial08	:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)		//Normal s/negrito

Private	nLinha	:= 3000	// Controla a linha por extenso
Private nColIni := 0100 // coluna 01 - inicio da pagina
Private nColFin := 2300 // coluna final da pagina
Private nLinIni := 0315 // Linha inicial da pagina
Private nLinFin := 3000 // Linha final da pagina

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefine as variaveis de dos box         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
_nPosBox1  := Round(nColIni+(nColFin-nColIni)*0.350,0)
_nPosBox2  := Round(_nPosBox1+(nColFin-nColIni)*0.200,0)
_nPosBox3  := Round(_nPosBox2+(nColFin-nColIni)*0.150,0)
_nPosBox4  := Round(_nPosBox3+(nColFin-nColIni)*0.150,0)

// detalhes dos reportes
_nPosBox21  := Round(nColIni+(nColFin-nColIni)*0.10,0)
_nPosBox22  := Round(_nPosBox21+(nColFin-nColIni)*0.10,0)
_nPosBox23  := Round(_nPosBox22+(nColFin-nColIni)*0.20,0)
_nPosBox24  := Round(_nPosBox23+(nColFin-nColIni)*0.10,0)
_nPosBox25  := Round(_nPosBox24+(nColFin-nColIni)*0.10,0)
_nPosBox26  := Round(_nPosBox25+(nColFin-nColIni)*0.10,0)
_nPosBox27  := Round(_nPosBox26+(nColFin-nColIni)*0.10,0)
_nPosBox28  := Round(_nPosBox27+(nColFin-nColIni)*0.10,0)

// detalhes dos projetos
_nPosBox31  := Round(nColIni+(nColFin-nColIni)*0.30,0)
_nPosBox32  := Round(nColIni+(nColFin-nColIni)*0.75,0)
_nPosBox33  := Round(nColIni+(nColFin-nColIni)*0.30,0)


Private lFirst  := .t.  // garante que e a primeira pagina ... assim nao imprime folhas desnecessarias

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefine as variaveis de controle        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Private _cCodCli := Space(06)
Private _cCodLoj := Space(02)
Private _aCliAna := {} // array com os analistas que atenderam aquele cliente
Private _aCliCor := {} // array com os cordenadores que atenderam aquele cliente


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefine que a impressao deve ser RETRATOณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oPrint:SetPortrait()
oPrint:Setup()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMonta query !ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤู
_cQuery := "SELECT SZ1.Z1_FILIAL, SZ1.Z1_CLIENTE, SZ1.Z1_LOJA, SA1.A1_NOME, SZ1.Z1_DESCPRO, SZ1.Z1_HINI, SZ1.Z1_HFIM,"+Chr(13)
_cQuery += "SZ1.Z1_HDESC, SZ1.Z1_USUARIO, SZ1.Z1_CODUSR, SZ1.Z1_NUM, SZ1.Z1_TOTHN, SZ1.Z1_TOTHE, SZ1.Z1_TOTHE2, SZ3.Z3_CARGO, SZ1.Z1_DATAO,SZ3.Z3_NIVEL,SZ2.Z2_VLHANA2,"+Chr(13)
_cQuery += "SZ2.Z2_VLHANA, SZ2.Z2_VLHCOR, SZ1.Z1_HPRO, SZ1.Z1_TOTHN, SZ1.Z1_PROJETO, SZ2.Z2_DESC, SZ2.Z2_XHRSFEC "+Chr(13)
_cQuery += "FROM "+RetSqlName('SZ1')+" SZ1, "+RetSqlName('SA1')+ " SA1, "+RetSqlName('SZ3')+ " SZ3, "+RetSqlName('SZ2')+ " SZ2"+Chr(13)
_cQuery += "WHERE SZ1.Z1_FILIAL = '"+xFilial("SZ1")+"'"+Chr(13)
_cQuery += "AND SZ1.Z1_CLIENTE BETWEEN '"+MVPAR01+"' AND '"+MVPAR02+"'"+Chr(13)

If Empty(MVPAR01_2)
	_cQuery += "AND SZ1.Z1_PROJETO >= '"+MVPAR09+"' AND SZ1.Z1_PROJETO <= '"+MVPAR10+"'"+Chr(13)
Else
	_cQuery += "AND SZ1.Z1_PROJETO IN ("+MVPAR01_2+")"+Chr(13)
EndIf

If Empty(MVPAR08_2)
	_cQuery += "AND SZ1.Z1_STATUS = 'I'"+Chr(13)
Else
	_cQuery += "AND SZ1.Z1_STATUS IN ("+MVPAR08_2+")"+Chr(13)
EndIf

_cQuery += "AND SZ1.Z1_LOJA BETWEEN '"+MVPAR03+"' AND '"+MVPAR04+"'"+Chr(13)
_cQuery += "AND SZ1.Z1_DATAO BETWEEN '"+DtoS(MVPAR05)+"' AND '"+DtoS(MVPAR06)+"'"+Chr(13)
_cQuery += "AND SZ1.D_E_L_E_T_ <> '*'
_cQuery += "AND SA1.A1_FILIAL = '"+xFilial("SA1")+"'"+Chr(13)
_cQuery += "AND SA1.A1_COD = SZ1.Z1_CLIENTE"+Chr(13)
_cQuery += "AND SA1.A1_LOJA = SZ1.Z1_LOJA"+Chr(13)
_cQuery += "AND SA1.D_E_L_E_T_ <> '*'"+Chr(13)
_cQuery += "AND SZ3.Z3_FILIAL = '"+xFilial("SZ3")+"'"+Chr(13)
_cQuery += "AND UPPER(SZ3.Z3_NOME) = UPPER(SZ1.Z1_USUARIO)"+Chr(13)
_cQuery += "AND SZ3.D_E_L_E_T_ <> '*'"+Chr(13)
_cQuery += "AND SZ2.Z2_FILIAL = '"+xFilial("SZ3")+"'"+Chr(13)
_cQuery += "AND SZ2.Z2_COD = SZ1.Z1_PROJETO"+Chr(13)
_cQuery += "AND SZ2.Z2_CLIENTE = SZ1.Z1_CLIENTE"+Chr(13)
_cQuery += "AND SZ2.Z2_LOJA = SZ1.Z1_LOJA"+Chr(13)
_cQuery += "AND SZ2.D_E_L_E_T_ <> '*'"+Chr(13)
_cQuery += "ORDER BY SZ1.Z1_CLIENTE, SZ1.Z1_LOJA, SZ3.Z3_CARGO DESC, SZ1.Z1_USUARIO, SZ1.Z1_DATAO"+Chr(13)     
//MemoWrite( "MPFATCLOS.sql", _cQuery )

__nContRes := U_MontaView(_cQuery, "SZ1TRB" )

SZ1TRB->(dbGoTop())
dbSelectArea("SZ0")
SZ0->(dbSetOrder(1)) // filial+numero OS+item
While SZ1TRB->(!Eof())
	_aCliAna := {} // array com os analistas que atenderam aquele cliente
	_aCliCor := {} // array com os cordenadores que atenderam aquele cliente
	_aProjeto:= {} // array com os projetos do cliente
	
	_cCodCli := SZ1TRB->Z1_CLIENTE
	_cCodLoj := SZ1TRB->Z1_LOJA
	_cNomCli := SZ1TRB->A1_NOME
//	_cCodAn  := SZ1TRB->Z1_CODUSR
//	cCodCli1  := SZ1TRB->Z1_CLIENTE
	_aOSCli  := {}
	xVerPag()
	
	// trazer as despesas dos analistas
		cQuery := " SELECT SUM(Z7_VALOR) AS Z7_VALOR,Z1_PROJETO,Z1_CODUSR, Z6_DESCDES,Z1_CLIENTE FROM SZ7010 SZ7 " + CRLF
		cQuery += " INNER JOIN SZ1010 SZ1 ON Z1_NUM = Z7_NUMOS AND SZ1.D_E_L_E_T_ ='' " + CRLF
		cQuery += " INNER JOIN SZ6010 SZ6 ON Z7_CODDESP = Z6_CODDESP " + CRLF 
		cQuery += " WHERE Z7_DATA BETWEEN '"+DtoS(MVPAR05)+"' AND '"+DtoS(MVPAR06)+"'"+  CRLF    
		cQuery += " AND SZ7.D_E_L_E_T_ = '' " + CRLF
		cQuery += " GROUP BY Z1_PROJETO,Z1_CODUSR,Z6_DESCDES,Z1_CLIENTE " + CRLF
			
		MsAguarde({|| dbUseArea(.T.,'TOPCONN', TCGenQry(,,cQuery), "TRB010",.F.,.T.)}, "Selecionando Registros ...")

dbSelectArea("TRB010")
TRB010->(dbGoTop()) 
	
		
	// alimentar array para saber quem atendeu o cliente no periodo escolhido
	While SZ1TRB->(!Eof() .And. Z1_CLIENTE == _cCodCli .And. Z1_LOJA == _cCodLoj)
		If SZ1TRB->Z3_CARGO == 'A' // Analista
			nPos := Ascan(_aCliAna, {|x| x[1] == Capital(Alltrim(UsrFullName(SZ1TRB->Z1_CODUSR)))} )
			If nPos == 0
			
				//SZ1TRB->(AADD(_aCliAna,{Capital(Alltrim(UsrFullName(SZ1TRB->Z1_CODUSR))), SZ1TRB->Z1_TOTHN, Z1_TOTHE, Z1_TOTHE2, IF(Z3_NIVEL == "2",Z2_VLHANA2,Z2_VLHANA)}))
				
				While TRB010->(!Eof())
		_cCodAn  := TRB010->Z1_CODUSR		
		cCodCli1 := TRB010->Z1_CLIENTE
				If TRB010->Z7_VALOR > 0
					While TRB010->(!Eof() .And. TRB010->Z1_CLIENTE == cCodCli1 .And. TRB010->Z1_CODUSR == _cCodAn)
						SZ1TRB->(AADD(_aCliAna,{Capital(Alltrim(UsrFullName(SZ1TRB->Z1_CODUSR))), SZ1TRB->Z1_TOTHN, Z1_TOTHE, Z1_TOTHE2, Z2_VLHANA,Z1_PROJETO,TRB010->Z7_VALOR }))
						TRB010->(dbSkip())
					ENDDO
					Else
					SZ1TRB->(AADD(_aCliAna,{Capital(Alltrim(UsrFullName(SZ1TRB->Z1_CODUSR))), SZ1TRB->Z1_TOTHN, Z1_TOTHE, Z1_TOTHE2, Z2_VLHANA,Z1_PROJETO}))
				lRet1 := .T.
				ENDIF
				TRB010->(dbSkip())
				ENDDO
					
				//SZ1TRB->(AADD(_aCliAna,{Capital(Alltrim(UsrFullName(SZ1TRB->Z1_CODUSR))), SZ1TRB->Z1_TOTHN, Z1_TOTHE, Z1_TOTHE2, Z2_VLHANA,Z1_PROJETO,TRB010->Z7_VALOR }))
			Else
				_aCliAna[nPos][2] += SZ1TRB->Z1_TOTHN // horas produtivas
				_aCliAna[nPos][3] += SZ1TRB->Z1_TOTHE
				_aCliAna[nPos][4] += SZ1TRB->Z1_TOTHE2
			EndIf
			
		Else // coordenador
			nPos := Ascan(_aCliCor, {|x| x[1] == Capital(Alltrim(UsrFullName(SZ1TRB->Z1_CODUSR)))} )
			If nPos == 0
			
			// alterado por Fabio Batista = Incluido o projeto do analista
			   	//SZ1TRB->(AADD(_aCliCor,{Capital(Alltrim(UsrFullName(SZ1TRB->Z1_CODUSR))), SZ1TRB->Z1_TOTHN, Z1_TOTHE, Z1_TOTHE2, Z2_VLHCOR,Z1_PROJETO}))
				SZ1TRB->(AADD(_aCliCor,{Capital(Alltrim(UsrFullName(SZ1TRB->Z1_CODUSR))), SZ1TRB->Z1_TOTHN, Z1_TOTHE, Z1_TOTHE2, Z2_VLHCOR,Z1_PROJETO,TRB010->Z7_VALOR}))
			Else
				_aCliCor[nPos][2] += SZ1TRB->Z1_TOTHN // horas produtivas
				_aCliCor[nPos][3] += SZ1TRB->Z1_TOTHE
				_aCliCor[nPos][4] += SZ1TRB->Z1_TOTHE2
			EndIf
			
		EndIf
		// Guardando os numeros das OSs deste cliente
		nPos := Ascan(_aOSCli, {|x| x[1]+x[2] == SZ1TRB->(Z1_FILIAL+Z1_NUM)} )
		If nPos == 0
			SZ1TRB->(AADD(_aOSCli,{Z1_FILIAL, Z1_NUM, Z1_DATAO, SubStr(Capital(Alltrim(UsrFullName(SZ1TRB->Z1_CODUSR))),1,24), Z1_HINI, Z1_HFIM,  Z1_TOTHN, Z1_TOTHE, Z1_TOTHE2, Val(Alltrim(Z1_HDESC)),Z1_PROJETO,TRB010->Z7_VALOR}))
		EndIf
		
		// Guardando os projetos do cliente
		nPos := Ascan(_aProjeto, {|x| x[1] == SZ1TRB->Z1_PROJETO} )
		If nPos == 0
			SZ1TRB->(AADD(_aProjeto,{Z1_PROJETO, Z2_DESC,SZ1TRB->Z1_TOTHN + SZ1TRB->Z1_TOTHE + SZ1TRB->Z1_TOTHE2,Z2_XHRSFEC}))
		Else
			_aProjeto[nPos][3] += SZ1TRB->Z1_TOTHN + SZ1TRB->Z1_TOTHE + SZ1TRB->Z1_TOTHE2 //SomaHoras(SZ1TRB->Z1_TOTHN,_aProjeto[nPos][3])
		EndIf
		
		SZ1TRB->(dbSkip())
	EndDo
	// Imprimir -> Acumulado por especialista ( analista/coordenador)
	fPrtEsp(_aCliCor, _aCliAna)
	
	// Imprimir detalhamento dos projetos
	fPrtPrjt(_aProjeto)
	
	// Imprimir detalhamento das OS deste cliente
	fPrtDtRp(_aOSCli)
	nPag++
	xRodape(nPag)
	nLinha := 3010
EndDo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณImprime em Video, e finaliza a impressao. !ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oPrint:Preview()
Return(nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ xCabec() บAutor ณLuis Henrique Robustoบ Data ณ  25/10/04   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime o Cabecalho do relatorio...                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Funcao Principal                                           บฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function xCabec()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณImprime o cabecalho da empresa. !ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oPrint:SayBitmap(050,100,cFileLogo,700,200)
//oPrint:Say(050,1000,AllTrim(Upper(SM0->M0_NOMECOM))+'Faturamento por Cliente',oArial18N)
oPrint:Say(050,1000,'Faturamento por Cliente',oArial18N)
nLinFin := 3000
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณTitulo do Relatorioณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oPrint:Box( nLinIni, nColIni, nLinFin,nColFin,oPen ) // box da margem externa
oPrint:Box( nLinIni, nColIni, 550,nColFin-300,oPen ) // box do texto Cliente
oPrint:Box( nLinIni, nColFin-300, 550,nColFin,oPen ) // box do codigo do cliente
oPrint:Say(nLinIni+10,nColIni+10,OemToAnsi('Cliente: '+Capital(_cNomCli)),oArial14N)
oPrint:Say(nLinIni+10,(nColFin-300)+10,OemToAnsi(_cCodCli+'-'+_cCodLoj),oArial14N)
oPrint:Say(nLinIni+70,nColIni+10,OemToAnsi('Periodo: '+DtoC(MVPAR05)+' ate '+DtoC(MVPAR06)),oArial14N)

nLinha := 650
If !lFirst
	fPrtBox(2) // desenhar o box
	fPrtBlin(2, 'Dia', 'Ident.', 'Especilista', 'Inicio', 'Fim', 'Desconto', 'Normal','Despesas','Projeto')
	nLinha += 40
	oPrint:Say(nLinha,nColIni+(nColFin-nColIni)/2,'Descricao',oArial10N)
	nLinha += 40
	oPrint:Line(nLinha,nColIni,nLinha,nColFin)
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ xVerPag()บAutor ณCristian Verneque    บ Data ณ  05/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Verifica se deve ou nao saltar pagina...                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Funcao Principal                                           บฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function xVerPag()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicia a montagem da impressao.ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If	( nLinha >= 3000 )
	
	If !lFirst
		nPag++
		xRodape(nPag)
		oPrint:EndPage()
	EndIf
	nLinha:= 450
	
	oPrint:StartPage()
	xCabec()
	lFirst  := .f. // desligando o semaforo
	
EndIf


Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CriaSx1  บ Autor ณ Cristian Verneque  บ Data ณ  03/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Cria as perguntas no SX1 caso nao existam.                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico - CSU                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function CriaSx1()
Local nX := 0
Local nY := 0
Local aAreaAnt := GetArea()
Local aAreaSX1 := SX1->(GetArea())
Local aReg := {}

aAdd(aReg,{cPerg,"01","Cliente de            ","mv_ch1","C", 6,0,0,"G","","mv_par01","","","","","","","","","","","","","","","SA1CL1"})
aAdd(aReg,{cPerg,"02","Cliente ate           ","mv_ch2","C", 6,0,0,"G","","mv_par02","","","","","","","","","","","","","","","SA1CL1"})
aAdd(aReg,{cPerg,"03","Loja de               ","mv_ch3","C", 2,0,0,"G","","mv_par03","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"04","Loja ate              ","mv_ch4","C", 2,0,0,"G","","mv_par04","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"05","Data OS de            ","mv_ch5","D", 8,0,0,"G","","mv_par05","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"06","Data OS Ate           ","mv_ch6","D", 8,0,0,"G","","mv_par06","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"07","Percentual Imposto    ","mv_ch7","N",12,4,0,"G","","mv_par07","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"08","Status                ","mv_ch8","C",10,0,0,"C","U_fStatOS()","mv_par08","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"09","Projeto de            ","mv_ch9","C", 6,0,0,"G","","mv_par09","","","","","","","","","","","","","","","SZ2X"})
aAdd(aReg,{cPerg,"10","Projeto ate           ","mv_cha","C", 6,0,0,"G","","mv_par10","","","","","","","","","","","","","","","SZ2X"})
//aAdd(aReg,{cPerg,"11","So OSs confirmadas    ","mv_chb","C",16,0,0,"C","","mv_par11","SIM","","","","","NAO","","","","","","","","",""})
aAdd(aReg,{"X1_GRUPO","X1_ORDEM","X1_PERGUNT","X1_VARIAVL","X1_TIPO","X1_TAMANHO","X1_DECIMAL","X1_PRESEL","X1_GSC","X1_VALID","X1_VAR01","X1_DEF01","X1_CNT01","X1_VAR02","X1_DEF02","X1_CNT02","X1_VAR03","X1_DEF03","X1_CNT03","X1_VAR04","X1_DEF04","X1_CNT04","X1_VAR05","X1_DEF05","X1_CNT05","X1_F3"})

dbSelectArea("SX1")
dbSetOrder(1)
For ny:=1 to Len(aReg)-1
	If !dbSeek(aReg[ny,1]+aReg[ny,2])
		RecLock("SX1",.T.)
		For j:=1 to Len(aReg[ny])
			FieldPut(FieldPos(aReg[Len(aReg)][j]),aReg[ny,j])
		Next j
		MsUnlock()
	EndIf
Next ny
RestArea(aAreaSX1)
RestArea(aAreaAnt)

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CriaSx1  บ Autor ณ Cristian Verneque  บ Data ณ  03/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Cria as perguntas no SX1 caso nao existam.                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico - CSU                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function CriaSx1_2(cPerg)
Local nX := 0
Local nY := 0
Local aAreaAnt := GetArea()
Local aAreaSX1 := SX1->(GetArea())
Local aReg := {}

aAdd(aReg,{cPerg,"01","Projetos              ","mv_ch1","C",80,0,0,"G","U_fProjCli()","mv_par01","","","","","","","","","","","","","","",""})
aAdd(aReg,{"X1_GRUPO","X1_ORDEM","X1_PERGUNT","X1_VARIAVL","X1_TIPO","X1_TAMANHO","X1_DECIMAL","X1_PRESEL","X1_GSC","X1_VALID","X1_VAR01","X1_DEF01","X1_CNT01","X1_VAR02","X1_DEF02","X1_CNT02","X1_VAR03","X1_DEF03","X1_CNT03","X1_VAR04","X1_DEF04","X1_CNT04","X1_VAR05","X1_DEF05","X1_CNT05","X1_F3"})

dbSelectArea("SX1")
dbSetOrder(1)
For ny:=1 to Len(aReg)-1
	If !dbSeek(aReg[ny,1]+aReg[ny,2])
		RecLock("SX1",.T.)
		For j:=1 to Len(aReg[ny])
			FieldPut(FieldPos(aReg[Len(aReg)][j]),aReg[ny,j])
		Next j
		MsUnlock()
	EndIf
Next ny
RestArea(aAreaSX1)
RestArea(aAreaAnt)

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณMontaWiew บAutor  ณSergio Oliveira     บ Data ณ  Jan/2005   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Esta funcao cria a area de trabalho e faz a contagem de    บฑฑ
ฑฑบ          ณ registros.                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ<ExpC1>    : Instrucao que sera montada a query.            บฑฑ
ฑฑบ          ณ<ExpC2>    : Alias para uso no programa da area de trabalho.บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ<ExpN1> : Nro de Registros no arquivo de trabalho.          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MontaView( cSql, cAliasTRB )

Local nCnt := 0
Local cSql := ChangeQuery( cSql )

If Select(cAliasTRB) > 0           // Verificar se o Alias ja esta aberto.
	DbSelectArea(cAliasTRB)        // Se estiver, devera ser fechado.
	DbCloseArea(cAliasTRB)
EndIf

DbUseArea( .T., "TOPCONN", TcGenQry(,,cSql), cAliasTRB, .T., .F. )
DbSelectArea(cAliasTRB)
DbGoTop()

DbEval( {|| nCnt++ })              // Conta quantos sao os registros retornados pelo Select.

Return( nCnt )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPFATCLOS บAutor  ณMicrosiga           บ Data ณ  02/16/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fPrtEsp(_aCliCor, _aCliAna )
Local _i
_nAcmNCO := 0 // TOTALIZADOR DE HORAS COORDENADOR
_nAcmNor := 0 // acumulado normal/produtivo
_nAcm050 := 0 // acumulado 50%
_nAcm100 := 0 // acumulado 100%
_nTVlrOs := 0 // valor total das OS por cliente
_nVlrOS  := 0 // valor da OS

If Len(_aCliCor) > 0
	_nAcmNor := 0
	_nAcm050 := 0
	_nAcm100 := 0
	_nDespco := 0
	oPrint:Say(nLinha,nColIni+10,'Acumulado por especialista',oArial10N)
	fPrtBox(1) // desenhar o box para titulo 
	
	// Campo vlr desp colocar despesa por analista
	fPrtBlin(1, 'Especialista', 'Valor Hora', 'Quant Horas', 'Vlr. Desp', '')
	For _i := 1 to Len(_aCliCor)
		fPrtBox(1) // desenhar o box para itens
		
	// Alterado por Fabio Batista trazer no array o projeto do coordenador
//fPrtBlin(1, Capital(_aCliCor[_i][1]), Transform(_aCliCor[_i][5],'@e 999,999,999.99'), Transform(_aCliCor[_i][2],'@e 999,999,999.99'), Transform(_aCliCor[_i][3],'@e 999,999,999.99'), Transform(_aCliCor[_i][4],'@e 999,999,999.99'))
fPrtBlin(1, Capital(_aCliCor[_i][1]), Transform(_aCliCor[_i][5],'@e 999,999,999.99'), Transform(_aCliCor[_i][2],'@e 999,999,999.99'), Transform(_aCliCor[_i][7],'@e 999,999,999.99'), '')

		_nAcmNor += _aCliCor[_i][2]
		_nAcm050 += _aCliCor[_i][3]
		_nAcm100 += _aCliCor[_i][4]
		_nVlrOS  := _aCliCor[_i][5]
		_nTVlrOS += (_aCliCor[_i][2] * _nVlrOS) + (_aCliCor[_i][3] * (_nVlrOS*1.5)) + (_aCliCor[_i][4] * (_nVlrOS*2))
	
_nAcmNCO += _nAcmNor 	
_nDespco += _aCliCor[_i][7]
	Next
	//Alterado por Fabio Batista comentei a linha 565,567,569,576,577 e 578 
	//fPrtBox(1) // desenhar o box
//	fPrtBlin(1, 'Total', '', Transform(_nAcmNor,'@e 999,999,999.99'), Transform(_nAcm050,'@e 999,999,999.99'), Transform(_nAcm100,'@e 999,999,999.99'))
		_nTVlrOS += (_nAcmNor * _nVlrOS) + (_nAcm050 * _nVlrOS) + (_nAcm100 * _nVlrOS)
//	nLinha += 60
EndIf
If Len(_aCliAna) > 0
	_nVltot  := 0
	_nAcmNor := 0
	_nAcm050 := 0
	_nAcm100 := 0
	_nDespan := 0
//	oPrint:Say(nLinha,nColIni+10,'Acumulado por especialista',oArial10N)
//	fPrtBox(1) // desenhar o box
//	fPrtBlin(1, 'Especialista', 'Valor Hora', 'Normal', '50%', '100%')
	For _i := 1 to Len(_aCliAna)
		fPrtBox(1) // desenhar o box
		// Alterado por Fabio Batista = inclui projeto do analista 
		//fPrtBlin(1,Capital(_aCliAna[_i][1]), Transform(_aCliAna[_i][5],'@e 999,999,999.99'), Transform(_aCliAna[_i][2],'@e 999,999,999.99'), Transform(_aCliAna[_i][3],'@e 999,999,999.99'), Transform(_aCliAna[_i][4],'@e 999,999,999.99'))
		// para escrever os itens do analista 

If lRet1 == .T.
		fPrtBlin(1,Capital(_aCliAna[_i][1]), Transform(_aCliAna[_i][5],'@e 999,999,999.99'), Transform(_aCliAna[_i][2],'@e 999,999,999.99'), Transform(_aCliAna[_i][7],'@e 999,999,999.99'),'')
		Else
		fPrtBlin(1,Capital(_aCliAna[_i][1]), Transform(_aCliAna[_i][5],'@e 999,999,999.99'), Transform(_aCliAna[_i][2],'@e 999,999,999.99'), '','')
ENDIF	
	
//		fPrtBlin(1,Capital(_aCliAna[_i][1]), Transform(_aCliAna[_i][5],'@e 999,999,999.99'), Transform(_aCliAna[_i][2],'@e 999,999,999.99'), Transform(_aCliAna[_i][7],'@e 999,999,999.99'),'')
		
		_nAcmNor += _aCliAna[_i][2]
		_nAcm050 += _aCliAna[_i][3]
		_nAcm100 += _aCliAna[_i][4]
		_nVlrOS  := _aCliAna[_i][5]
		_nTVlrOS += (_aCliAna[_i][2] * _nVlrOS) + (_aCliAna[_i][3] * (_nVlrOS*1.5)) + (_aCliAna[_i][4] * (_nVlrOS*2))
		_nDespan +=_aCliAna[_i][7]// totalizadore despesa analista
	Next
	fPrtBox(1) // desenhar o box
	
	//totalizadores 
_nAcmNCO += _nAcmNor // totalizador de horas	
_nTotDes := _nDespan+_nDespco 
// alterado por Fabio Batista comentei a linha 593,594,596 e 599 
// aten็ใo o ultimo paraetro nใo pode deixar em branco tem que passar com aspas 
	fPrtBlin(1, 'Total', '', Transform(_nAcmNCO,'@e 999,999,999.99'), Transform(_nTotDes,'@e 999,999,999.99'), '')
//	fPrtBlin(1, 'Total', '', Transform(_nAcmNor,'@e 999,999,999.99'), Transform(_nAcm050,'@e 999,999,999.99'), Transform(_nAcm100,'@e 999,999,999.99'))
	//	_nTVlrOS += (_nAcmNor * _nVlrOS) + (_nAcm050 * (_nVlrOS*1.5)) + (_nAcm100 * (_nVlrOS*2))
	nLinha += 60
EndIf

//fPrtBox(1) // desenhar o box
fPrtBox(1) // desenhar o box

/*IF _nTVlrOS > 0
	
	fPrtBlin(1, 'Valor Total', Transform(_nTVlrOS,'@e 999,999,999.99'), '', '', '')
	
ELSE
*/	
	X:= 1
	Y:= 2
	VLFECHA := _nTVlrOS
	
	WHILE !X > LEN(MVPAR01_2)/8
		
		IF "P" $ substr(MVPAR01_2,Y,6)
		   VLFECHA+= Posicione("SZ2",1,xFilial("SZ2")+substr(MVPAR01_2,Y,6),"Z2_VLFECHA")
		ENDIF
		
		Y+= 9
		X+= 1
	ENDDO

fPrtBlin(1, 'Valor Total', Transform(VLFECHA,'@e 999,999,999.99'), '', '', '')	
//ENDIF


nLinha += 30

//fPrtBox(1) // desenhar o box
//fPrtBlin(1, 'Total com imposto', Transform(_nTVlrOS/MVPAR07,'@e 999,999,999.99'), '', '', '')
//fPrtBox(1) // desenhar o box
//fPrtBlin(1, 'Total de imposto', Transform(_nTVlrOS/MVPAR07 - _nTVlrOS,'@e 999,999,999.99'), '', '', '')

Return(nil)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfPrtDtRp บAutor  ณCristian Werneck    บ Data ณ  02/23/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprimir detalhes dos reportes                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParamentroณ Array contendo as OS do cliente                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static function fPrtDtRp(_aOSCli)
Local _aAreas := GetArea()

nLinha += 80
oPrint:Say(nLinha,nColIni+10,'Detalhes dos Reportes',oArial10N)
fPrtBox(2) // desenhar o box
fPrtBlin(2, 'Dia', 'Ident.', 'Especilista', 'Inicio', 'Fim', 'Desconto', 'Quant Horas','Despesas','Projeto')
nLinha += 40
oPrint:Say(nLinha,nColIni+(nColFin-nColIni)/2,'Descricao',oArial10N)
nLinha += 40
oPrint:Line(nLinha,nColIni,nLinha,nColFin)
nLinha += 40
xVerPag()
For _i := 1 to Len(_aOSCli)
	If SZ0->(DbSeek(_aOSCli[_i][1]+_aOSCli[_i][2]))	 // Filial+nr da OS
		fPrtBox(2) // desenhar o box
		//		SZ1TRB->(AADD(_aOSCli,{Z1_FILIAL, Z1_NUM, Z1_DATAO, Z1_USUARIO, Z1_HINI, Z1_HFIM, Z1_TOTHN, Z1_TOTHE, Z1_TOTHE2}))
		fPrtBlin(2, DtoC(StoD(_aOSCli[_i][3])), _aOSCli[_i][2], Capital(_aOSCli[_i][4]), _aOSCli[_i][5], _aOSCli[_i][6], Transform(_aOSCli[_i][10],'@e 999,999,999.99'), Transform(_aOSCli[_i][7],'@e 999,999,999.99'), Transform(_aOSCli[_i][8],'@e 999,999,999.99'), _aOSCli[_i][11], Transform(_aOSCli[_i][12],'@e 999,999,999.99'))
		//fPrtBlin(2, DtoC(StoD(_aOSCli[_i][3])), _aOSCli[_i][2], Capital(_aOSCli[_i][4]), _aOSCli[_i][5], _aOSCli[_i][6], Transform(_aOSCli[_i][10],'@e 999,999,999.99'), Transform(_aOSCli[_i][7],'@e 999,999,999.99'), Transform(_aOSCli[_i][8],'@e 999,999,999.99'), Transform(_aOSCli[_i][9],'@e 999,999,999.99'))
		nLinha += 40
		xVerPag()
		While SZ0->(!Eof() .And. Z0_FILIAL == _aOSCli[_i][1] .And. Z0_NUM == _aOSCli[_i][2] )
			_cTexto := SZ0->Z0_ITEM
			If Len(Alltrim(SZ0->Z0_TIPO)) == 1 // Tarefas
				Do Case
					Case Alltrim(SZ0->Z0_TIPO) == 'D'
						_cTexto += ' - Desenvolvimento'
					Case Alltrim(SZ0->Z0_TIPO) == 'A'
						_cTexto += ' - Alteracao'
					Case Alltrim(SZ0->Z0_TIPO) == 'C'
						_cTexto += ' - Correcao'
					Case Alltrim(SZ0->Z0_TIPO) == 'O'
						_cTexto += ' - Documentacao'
					Case Alltrim(SZ0->Z0_TIPO) == 'L'
						_cTexto += ' - Levantamento'
					Case Alltrim(SZ0->Z0_TIPO) == 'P'
						_cTexto += ' - Apresentacao'
					Case Alltrim(SZ0->Z0_TIPO) == 'R'
						_cTexto += ' - Coordenacao'
					Case Alltrim(SZ0->Z0_TIPO) == 'I'
						_cTexto += ' - Capacitacao'
					Case Alltrim(SZ0->Z0_TIPO) == 'T'
						_cTexto += ' - Treinamento'
					Case Alltrim(SZ0->Z0_TIPO) == 'U'
						_cTexto += ' - Ausencia'
					Case Alltrim(SZ0->Z0_TIPO) == 'M'
						_cTexto += ' - Almo็o'
					OtherWise
						_cTexto += ' - Indefinido'
				EndCase
			Else
				_cTexto := Posicione("SZ4", 1, xFilial("SZ4")+SZ0->Z0_TIPO, "Z4_DESCTAR")
			EndIf
			_cMensg := SZ0->Z0_DESCRI
			
			oPrint:Say(nLinha,nColIni+10,Capital(StrTran(_cTexto, '"', '')),oArial10)
			_nLinhas := mlcount(_cMensg,125)
			//			nLinha += 20
			// impressao do resto da descricao da observacao
			for _nVezLinha := 1 to _nLinhas
				oPrint:Say(nLinha,nColIni+370,memoline(_cMensg,125,_nVezLinha,,.T.),oArial08)
				nLinha += 40
				xVerPag()
			Next
			SZ0->(dbSkip())
		EndDo
		
	EndIf
Next
RestArea(_aAreas)
Return(nil)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfPrtDtRp บAutor  ณCristian Werneck    บ Data ณ  02/23/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprimir projetos dos reportes                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParamentroณ Array contendo os projetos do cliente                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static function fPrtPrjt(_aProjeto)

nLinha += 80
oPrint:Say(nLinha,nColIni+10,'Projetos utilizados',oArial10N)
fPrtBox(3) // desenhar o box
fPrtBlin(4, 'Projeto', 'Descricao','Qtd. Horas','Tot. Horas')
//nLinha += 40
//oPrint:Line(nLinha,nColIni,nLinha,nColFin)
//nLinha += 40
xVerPag()
For _i := 1 to Len(_aProjeto)
	fPrtBox(3) // desenhar o box
	fPrtBlin(3, _aProjeto[_i][1],  _aProjeto[_i][2],Transform(_aProjeto[_i][3],'@e 999,999,999.99'),Transform(_aProjeto[_i][4],'@e 999,999,999.99'))
	//		nLinha += 40
	xVerPag()
Next
Return(nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPFATCLOS บAutor  ณMicrosiga           บ Data ณ  02/16/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fPrtBox(n)
nLinha += 40
nLinFin := nLinha+80
Do Case
	Case n == 1 // acmulado por especialista
		oPrint:Box( nLinha, nColIni, nLinFin,_nPosBox1 ) // box nr 1
		oPrint:Box( nLinha, _nPosBox1, nLinFin,_nPosBox2 ) // box nr 2
		oPrint:Box( nLinha, _nPosBox2, nLinFin,_nPosBox3 ) // box nr 3
		oPrint:Box( nLinha, _nPosBox3, nLinFin,_nPosBox4 ) // box nr 4
		oPrint:Box( nLinha, _nPosBox4, nLinFin,nColFin ) // box nr 5
		
	Case n == 2 // detalhes dos reportes
		oPrint:Box( nLinha, nColIni, nLinFin,_nPosBox21 ) // box nr 21
		oPrint:Box( nLinha, _nPosBox21, nLinFin,_nPosBox22 ) // box nr 22
		oPrint:Box( nLinha, _nPosBox22, nLinFin,_nPosBox23 ) // box nr 23
		oPrint:Box( nLinha, _nPosBox23, nLinFin,_nPosBox24 ) // box nr 24
		oPrint:Box( nLinha, _nPosBox24, nLinFin,_nPosBox25 ) // box nr 25
		oPrint:Box( nLinha, _nPosBox25, nLinFin,_nPosBox26 ) // box nr 26
		oPrint:Box( nLinha, _nPosBox26, nLinFin,_nPosBox27 ) // box nr 27
		oPrint:Box( nLinha, _nPosBox27, nLinFin,_nPosBox28 ) // box nr 27
		oPrint:Box( nLinha, _nPosBox28, nLinFin,nColFin ) // box nr 28
		
	Case n == 3 // detalhes dos projetos
		oPrint:Box( nLinha, nColIni, nLinFin,_nPosBox31 ) // box nr 31
		oPrint:Box( nLinha, _nPosBox31, nLinFin,nColFin ) // box nr 28
		oPrint:Box( nLinha, _nPosBox32, nLinFin,nColFin ) // box nr 28 
		oPrint:Box( nLinha, _nPosBox33, nLinFin,nColFin ) // box nr 28

EndCase
nLinha += 40
Return(nil)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPFATCLOS บAutor  ณMicrosiga           บ Data ณ  02/16/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fPrtBlin(n,_cPar1, _cPar2, _cPar3, _cPar4, _cPar5, _cPar6, _cPar7, _cpar8, _cPar9)

do Case
	Case n == 1 // acumulado por especialista
		oPrint:Say(nLinha,nColIni+10,_cPar1,oArial10N)
		oPrint:Say(nLinha,_nPosBox1+10,_cPar2,oArial10N)
		oPrint:Say(nLinha,_nPosBox2+10,_cPar3,oArial10N)
		oPrint:Say(nLinha,_nPosBox3+10,_cPar4,oArial10N)
		oPrint:Say(nLinha,_nPosBox4+10,_cPar5,oArial10N)
		//oPrint:Say(nLinha,_nPosBox5+10,_cPar6,oArial10N)
		
	Case n == 2 // Detalhes dos reportes
		oPrint:Say(nLinha,nColIni+10,_cPar1,oArial10N)
		oPrint:Say(nLinha,_nPosBox21+10,_cPar2,oArial10N)
		oPrint:Say(nLinha,_nPosBox22+10,_cPar3,oArial10N)
		oPrint:Say(nLinha,_nPosBox23+10,_cPar4,oArial10N)
		oPrint:Say(nLinha,_nPosBox24+10,_cPar5,oArial10N)
		oPrint:Say(nLinha,_nPosBox25+10,_cPar6,oArial10N)
		oPrint:Say(nLinha,_nPosBox26+10,_cPar7,oArial10N)
		oPrint:Say(nLinha,_nPosBox27+10,_cPar8,oArial10N)
		oPrint:Say(nLinha,_nPosBox28+10,_cPar9,oArial10N)
		
	Case n == 3 // Detalhes dos projetos
		oPrint:Say(nLinha,nColIni+10,_cPar1,oArial10N)
		oPrint:Say(nLinha,_nPosBox31+10,_cPar2,oArial10N)
		oPrint:Say(nLinha,_nPosBox32+10,_cPar3,oArial10N)
		oPrint:Say(nLinha,_nPosBox33+10,_cPar4,oArial10N)

EndCase

Return(nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ xRodape()บAutor ณLuis Henrique Robustoบ Data ณ  25/10/04   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime o Rodape do Relatorio....                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Funcao Principal                                           บฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ  MOTIVO                                         บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function xRodape(nPag)

//oPrint:Line(3100,nColD01,3100,2300)
oPrint:Say(3120,1050,"Pagina: "+StrZero(nPag,3),oArial10)
//oPrint:Line(3200,nColD01,3200,2300)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPFATCLOS บAutor  ณMicrosiga           บ Data ณ  07/27/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function fProjCli(l1Elem,lTipoRet)

Local cTitulo := "Projetos do Cliente"
Local MvPar
Local MvParDef:=""

Private aCat:={}
DEFAULT lTipoRet := .T.

l1Elem := If (l1Elem = Nil , .F. , .T.)

cAlias := Alias() 					 // Salva Alias Anterior

IF lTipoRet
	MvPar:= &(Alltrim(ReadVar()))		 // Carrega Nome da Variavel do Get em Questao
	mvRet:= Alltrim(ReadVar())			 // Iguala Nome da Variavel ao Nome variavel de Retorno
EndIF

_aAreas := GetArea()
SZ2->(dbSetOrder(3))
SZ2->(dbSeek(xFilial("SZ2")+MVPAR02))
//CursorWait()
While SZ2->( !Eof() .And. Z2_CLIENTE == MVPAR02 )
	
	If SZ2->Z2_STATUS == 'A'
		Aadd(aCat,Left(SZ2->Z2_COD,6) + " - " + Alltrim(SZ2->Z2_DESC))
		MvParDef += Left(SZ2->Z2_COD,6)
	EndIf
	
	SZ2->(dbSkip())
Enddo
//CursorArrow()

IF lTipoRet
	IF f_Opcoes(@MvPar,cTitulo,aCat,MvParDef,12,49,l1Elem,6,500)  // Chama funcao f_Opcoes    VITOR
		&MvRet := mvpar										 // Devolve Resultado
	EndIF
EndIF

RestArea(_aAreas)

Return( IF( lTipoRet , .T. , MvParDef ) )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPFATCLOS บAutor  ณMicrosiga           บ Data ณ  07/27/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function fStatOS(l1Elem,lTipoRet)

Local cTitulo := "Status da Ordem de Servico"
Local MvPar
Local MvParDef:=""

Private aCat:={}

DEFAULT lTipoRet := .T.

l1Elem := If (l1Elem = Nil , .F. , .T.)

cAlias := Alias() 					 // Salva Alias Anterior

IF lTipoRet
	MvPar:= &(Alltrim(ReadVar()))		 // Carrega Nome da Variavel do Get em Questao
	mvRet:= Alltrim(ReadVar())			 // Iguala Nome da Variavel ao Nome variavel de Retorno
EndIF

Aadd(aCat, "I - Incluida" )
Aadd(aCat, "C - Confirmada" )
Aadd(aCat, "F - Faturada" )

For I := 1 to Len(aCat)
	MvParDef += Left(aCat[I],1)
Next
//CursorArrow()

IF lTipoRet
	IF f_Opcoes(@MvPar,cTitulo,aCat,MvParDef,12,49,l1Elem,1)  // Chama funcao f_Opcoes
		&MvRet := mvpar										 // Devolve Resultado
	EndIF
EndIF

Return( IF( lTipoRet , .T. , MvParDef ) )


Static function  resufin
oPrint:Say( nLin, 060,"TOTAIS:",oFont16N)
nLin := nLin + 150

oPrint:Say( nLin, 080,"COD. PROJETO        DESC. PROJETO                     TIPO         HRS. PROJETO       REALIZADO     SALDO    ",oFont12N)
//rint:Say( nLin, 080,"Cod.Projeto        Descri็ใo                                   Hrs Projeto                 Realizado      Saldo    ",oFont12N)
nLin := nLin + 50
oPrint:Say( nLin, 1550,"           NO MสS     DO PROJETO    ",oFont12N)
//oPrint:Say( nLin, 1510,"             No mes     Do Projeto    ",oFont12N)
nLin := nLin + 80
                       
_nTotInv := 0
_nTotFat := 0
/*
For _i := 1 to Len(_aProjeto)
	fPrtBox(3) // desenhar o box
	fPrtBlin(3, _aProjeto[_i][1],  _aProjeto[_i][2] )
	//		nLinha += 40
	xVerPag()
Next
*/
_aVetTot := _aProjeto
For i:=1 To Len(_aVetTot)
	oPrint:Say( nLin, 150,_aVetTot[I][1],oFont12N)
	
	DbSelectArea("SZ2")
	DbSetOrder(1)
	If DbSeek(xFilial()+SA1->A1_COD+SA1->A1_LOJA+_aVetTot[I][1]) 
		oPrint:Say( nLin,480,SZ2->Z2_DESCPRJ,oFont12N)
		If SZ2->Z2_TIPO == "F"
			oPrint:Say( nLin,1050,"FECHADO",oFont12N)
		Else
			oPrint:Say( nLin,1050,"ABERTO",oFont12N)
		EndIf
	Else                                              
		oPrint:Say( nLin,480,"DIVERSOS",oFont12N)
	EndIF                                          
	
	IF VALTYPE(_aVetTot[I][2]) == "C"
		IF AT(":",_aVetTot[I][2] ) > 0 // VERIFICA SE POSSUI :
			_aVetTot[I][2] := Val(SUBSTR(_aVetTot[I][2] ,1,AT(":",_aVetTot[i][2] )-1)+"."+SUBSTR(_aVetTot[I][2] ,AT(":",_aVetTot[i][2] )+1,LEN(_aVetTot[I][2])))
		EndIf
	EndIf
		 
	oPrint:Say(nLin,1350,transform(SZ2->Z2_QTDHORA,"@E 9,999.99"),oFont12N)
	
	//Print:Say(nLin,1530,transform(SZ2->Z2_SALDO,"@E 9,999.99"),oFont12N)
	oPrint:Say(nLin,1680,transform(_aVetTot[I][2],"@E 9,999.99"),oFont12N)
	
	IF SZ2->Z2_TIPO == "A"
		oPrint:Say(nLin,2010,"-",oFont12N)
	Else
		oPrint:Say(nLin,1960,transform(SUBHORAS(SZ2->Z2_QTDHORA,SZ2->Z2_SALDO),"@E 9,999.99"),oFont12N)
	EndIf
	
	
	_nTotInv := SOMAHORAS(_nTotInv,_aVetTot[i][3])
	_nTotFat := SOMAHORAS(_nTotFat,_aVetTot[i][2])
	nLin := nLin + 50

Next i

nLin := nLin + 50
oPrint:Line(nLin, 30, nLin, 2320 )
nLin := nLin + 50

oPrint:Say( nLin, 085,"Total Horas Faturadas......:",oFont12)
oPrint:Say(nLin, 600,transform(_nTotFat,"@R 9,999.99"),oFont12N)
nLin := nLin + 50

If !Empty(_nTotInv)                                
	oPrint:Say( nLin, 085,"Total Horas Investimento...:",oFont12)
	oPrint:Say(nLin, 600,transform(_nTotInv,"@R 9,999.99"),oFont12N)
	nLin := nLin + 50
EndIf	

oPrint:Say( nLin, 085,"Total Horas Confirmadas....:",oFont12)
oPrint:Say(nLin, 600,transform(_nTotFat+_nTotInv,"@E 9,999.99"),oFont12N)

nLin := nLin + 80
oPrint:Line(nLin, 30, nLin, 2320 )
nLin := nLin + 25
oPrint:Say( nLin, 050,"Faturamento conforme horas realizadas nas OSดs descriminadas acima!",oFont12)
nLin := nLin + 50
oPrint:Line(nLin, 30, nLin, 2320 )
nLin := nLin + 25                                  
_cVencimento := "Informa็๕es Financeiras - Vencimento: " + Dtoc(MV_PAR05)
oPrint:Say( nLin, 050,_cVencimento,oFont12)
nLin := nLin + 50
oPrint:Line(nLin, 30, nLin, 2320 )
nLin := nLin + 80


If (MV_PAR03 $ ("000030/000032")  ) = .F.
	oPrint:Say( nLin, 050,"Banco Itau S/A",oFont12N)
	nLin := nLin + 50
	oPrint:Say( nLin, 050,"Agencia: 0648 C/C 45047-6",oFont12N)
	nLin := nLin + 50
	oPrint:Say( nLin, 050,"G3Systems Consultoria e Solu็ใo",oFont12N)
	nLin := nLin + 70
EndIf

oPrint:Say( nLin, 050,"VALOR HORA.................:",oFont12N)
oPrint:Say( nLin, 550,TRANSFORM(SA1->A1_XVLHRCL,"@E 999,999.99"),oFont12N)
nLin := nLin + 50
oPrint:Say( nLin, 050,"TOTAL DE HORAS FATURADAS...:",oFont12N)
oPrint:Say(nLin, 750,transform(_nTotFat,"@E 9,999.99"),oFont12N)
nLin := nLin + 50
oPrint:Say( nLin, 050,"TOTAL GERAL................:",oFont12N)
_nTotSF:=int(val(transform(_nTotFat,"@e 999.99"))) + (((val(transform(_nTotFat,"@r 999.99")) - int(val(transform(_nTotFat,"@r 999.99")))) * 100)/60) 
oPrint:Say(nLin, 650,transform(SA1->A1_XVLHRCL*_nTotSF,"@E 99,999.99"),oFont12N)
_cExtenso := "(" + Alltrim(Extenso(SA1->A1_XVLHRCL*_nTotSF)) + ")"
oPrint:Say(nLin, 870,_cExtenso,oFont10)
nLin := nLin + 50
oPrint:Line(nLin, 30, nLin, 2320 )

oPrint:EndPage() // Finaliza a pagina
                                      
Return Nil
      
/*
======================================================================================
****************             CABECALHO            ***********************************                       
======================================================================================
*/

Static Function ImpCabec()

oPrint:StartPage() 		// Inicia uma nova pagina

nLin := 740

If (MV_PAR03 $ ("000030/000032")  ) = .F.
	oPrint:SayBitmap(90,50,cFigura,450,270) 
EndIf

oPrint:Say( 200, 750,"Relat๓rio Detalhado de Visitas a Clientes",oFont16N)

// BOX DADOS DO CLIENTE / RELATORIO
oPrint:Box( 0380, 30,0660, 2320 )
oPrint:Box( 0381, 31,0661, 2321 )

oPrint:Say( 420, 0050,"Cliente:",oFont14)
oPrint:Say( 420, 0250,_cCliente,oFont14N)
//oPrint:Say( 460, 0050,"Projeto:",oFont14)
//oPrint:Say( 460, 0250,_cProjeto,oFont14N)
oPrint:Say( 490, 0050,"Contato:",oFont14)
oPrint:Say( 490, 0250,_cContato,oFont14N)
oPrint:Say( 560, 0050,"Periodo:",oFont14)
oPrint:Say( 560, 0250,_cPeriodo,oFont14N)
          
_nPag ++      

oPrint:Say( 3360, 2230,"Pag.",oFont08)
oPrint:Say( 3360, 2290,Alltrim(str(_nPag)),oFont08N)
      
//Box Dados do Cliente
oPrint:Box( 0690, 30,3400, 2320 )
oPrint:Box( 0691, 31,3401, 2321 )

Return                      
