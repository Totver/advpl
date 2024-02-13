/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ DATA   ³ BOPS ³Progr. ³						ALTERACAO 							³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³30.03.98³      ³Pilar  ³Tratamento para Pre-lancamentos                 ³±±
±±³23.04.98³      ³Pilar  ³Incluido parametro MV_DIGVER p/ imprimir o digi ³±±
±±³        ³      ³       ³to de controle ou nao junto … conta contabil    ³±±
±±³24.04.98³      ³Ale    ³Desmembra Lanc X em debito e credito?			  	³±±
±±³03.06.98³      ³Alice  ³Usar a funcao RetTitle nos str0019 e str0022    ³±±
±±³10.07.98³      ³Pilar  ³Criar arq. temporario quando for TOP CONNECT    ³±±
±±³27.07.98³      ³Pilar  ³Incluir no. do item                             ³±±
±±³24.09.98³      ³Andreia³Acerto no lay-out                               ³±±
±±³24.09.98³      ³Andreia³Acerto na Impressao do total informado          ³±±
±±³28.09.98³      ³Andreia³Acerto na Impressao do rodape                   ³±±
±±³27.07.98³      ³Pilar  ³Incluir no. do item                             ³±±
±±³18.01.99³      ³Pilar  ³Imprimir subtotal por documento                 ³±±
±±³03.03.99³ SBPS ³Julio  ³Acrescentar cod. Historico Padrao na Impressao  ³±±
±±³30.03.99³ META ³Julio  ³Verificar Parametros de Tamanho do  Relatorio.  ³±±
±±³02.08.99³ xxxxx³Pilar  ³Aumentar conta para 20 no arq. temporario - TOP ³±±
±±³05.08.99³23209A³Pilar  ³Aumentar I2_HIST p/ 40 quando !lItem e !lCusto  ³±±
±±³16.08.99³WAGNER³Julio  ³N„o truncar hist¢rico na Impress„o.             ³±±
±±³28.10.99³xxxxxx³Pilar  ³Acerto da indregua quando TOP                   ³±±
±±³09.11.99³24111A³Alice  ³Acerto na "Dif. Deb/Cred"                       ³±±
±±³10.11.99³24111A³Alice  ³Colocar se Dif. e a Debito ou Credito           ³±±
±±³17.11.99³19303A³Alice  ³Imprimir Total a Debito T e Total Informado     ³±±
±±³30.11.99³      ³Alice  ³ dbSelectArea("cArqTmp")                        ³±±
±±³30.12.99³XXXXXX³Julio W³Arquivo de Trabalho p/ TOP em EXCLUSIVO         ³±±
±±³13.01.00³002023³Pilar  ³Aumentar tam do campo I2_PERIODO qdo arq temp.  ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
#Include "Conr120.Ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Conr120	³ Autor ³ Wagner Xavier			  ³ Data ³ 14.12.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rela‡„o de Lotes														  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ Conr120(void)											 				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico													  				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ConR120()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis 											 			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cDesc1:= OemToAnsi(STR0001) //"Este programa tem o objetivo de emitir a rela‡„o de lotes "
LOCAL cDesc2:= OemToAnsi(STR0002) //"digitados. Poder  ser emitido de forma Anal¡tica (todos lan-"
LOCAL cDesc3:= OemToAnsi(STR0003) //"‡amentos) ou Sint‚tica (Apenas os totais do lote). "
LOCAL wnrel
LOCAL cString:="SI2"
Local cMoeda
Local Tamanho := "M"
PRIVATE aReturn := { OemToAnsi(STR0004), 1,OemToAnsi(STR0005), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE nomeprog:="CONR120"
PRIVATE aLinha := { },nLastKey := 0
PRIVATE cPerg	:="COR120"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li 	 := 80
m_pag  := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas 							 	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("COR120",.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros						 		  ³
//³ mv_par01	  // do lote									 			  ³
//³ mv_par02	  // at‚ o lote									 		  ³
//³ mv_par03	  // da data									 			  ³
//³ mv_par04	  // ate a data									 		  ³
//³ mv_par05	  // Cod Conta ou Reduzido 						 	  ³
//³ mv_par06	  // Moeda										 			  ³
//³ mv_par07	  // Tipo do Relatorio (Analitico ou Sintetico)   ³
//³ mv_par08	  // Salta pagina por lote 						 	  ³
//³ mv_par09	  // Imprime? Lancamento / Pre-Lancamento		 	  ³
//³ mv_par10	  // Desmembra ?                            	  	  ³
//³ mv_par11	  // Totaliza Documento?                    	  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas no arquivo SIGACONR.INI ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cMoeda := GetMv("MV_MOEDA"+Str(mv_par06,1))
If mv_par09 == 1
	PRIVATE titulo   :=OemToAnsi(STR0006)+cMoeda  //"Relacao de Lotes em "
Else
	PRIVATE titulo   :=OemToAnsi(STR0021)+cMoeda  //"Relacao de Lotes, Pre-Lancamentos em "
EndIf	
	
PRIVATE cabec1
PRIVATE cabec2   :=" "
PRIVATE cCancel  :=OemToAnsi(STR0007)  //"***** CANCELADO PELO OPERADOR *****"

If mv_par09 == 1
	cString := "SI2"
Else
	cString := "SIC"
EndIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT 						 	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="CONR120"            //Nome Default do relatorio em Disco
WnRel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey == 27
	Set Filter To
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter To
	Return
Endif

If mv_par09 == 1
	#IFDEF WINDOWS
		RptStatus({|lEnd| Cr120Imp(@lEnd,wnRel,cString)},Titulo)
	#ELSE
		Cr120Imp(.f.,Wnrel,cString)
	#ENDIF
Else
	#IFDEF WINDOWS
		RptStatus({|lEnd| Cr120Imp1(@lEnd,wnRel,cString)},Titulo)
	#ELSE
		Cr120Imp1(.f.,Wnrel,cString)
	#ENDIF
EndIF	

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o	  ³ Cr120Imp ³ Autor ³ Wagner Xavier		 	³ Data ³ 05/11/93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Relacao de Lotes														   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³ Cr120Imp(lEnd,wnRel,cString) 							   		³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		  ³ SIGACON 												   				³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ lEnd - A‡Æo do Codeblock								   			³±±
±±³			  ³ wnRel	- T¡tulo do relat¢rio							   		³±±
±±³			  ³ cString - Mensagem										   			³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Cr120Imp(lEnd,WnRel,cString)
LOCAL limite := 132
LOCAL nTotDeb,nTotCrd,nTotDig,nTotDebDoc,nTotCrdDoc,nTotNoDesm
LOCAL nTotTInf:=nTotTDeb:=nTotTCred:=nTotTDig:=nTotTDif:=nTotTDif1:=0
LOCAL nValLanc,nDifDbCr:=0,dDataAtu  //INC
Local cPer, cPeriodoI2, cPeriodo    //INC
LOCAL CbTxt
LOCAL cbcont
Local nTotRdDeb := 0
LOCAL nTotRdCrd := 0
LOCAL nTotDias := 0
LOCAL nTotHist := 0
LOCAL cResDeb
LOCAL cResCrd
LOCAL lCusto	:= .f.
LOCAL lItem	 	:= .f.
Local lReplica := .f.
Local cDigVer	:= GetMv("MV_DIGVER")
Local dData, cDebito, cCredito
Local cIndex, nIndex
Local cFiltro, cFilterUser, lArqTmp
Local cRestoHist:=""

PRIVATE cMoeda
PRIVATE cMesAtu17
PRIVATE cabecAna

PRIVATE tamanho:="M"
PRIVATE cArqTmp, cArqInd

cbtxt  := SPACE(10)
cbcont	 := 0

If ! DataMoeda(mv_par06, @cMesAtu17, mv_par03)
	#IFNDEF	WINDOWS
		Set Device To Screen
	#ENDIF
	Help(" ",1,"MESINVALID")
	Set Filter To
	Return
End
If ! DataMoeda(mv_par06, @cMesAtu17, mv_par04)
	#IFNDEF	WINDOWS
		Set Device To Screen
	#ENDIF
	Help(" ",1,"MESINVALID")
	Set Filter To
	Return
End

// Se a moeda escolhida, nao esta em uso -> sai do programa.
If Empty(GetMv("MV_MOEDA"+Str(mv_par06,1)))
	Set Filter To
	Return
End

dbSelectArea("SX3")
dbSetOrder(2)
dbSeek("I2_CCD")
If X3Uso(X3_USADO)
	lCusto := .t.
End
dbSeek("I2_ITEMD")
If X3Uso(X3_USADO)
	lItem := .t.
End
dbSetOrder(1)

IF mv_par10 == 2				// Nao desmembra lancamento tipo X
	If !lItem .and. !lCusto
		cabecAna	:=	OemToAnsi(STR0019)
	ElseIf lItem .And. !lCusto
		cabecAna	:=	OemToAnsi(STR0019)+Space(22)+RetTitle("I2_ITEMD",09)+" "+;
						RetTitle("I2_ITEMC",09)
	ElseIf !lItem .And. lCusto
		cabecAna	:=	OemToAnsi(STR0019)+Space(22)+RetTitle("I2_CCD",09)+" "+;
						RetTitle("I2_CCC",09)
	Else
		cabecAna	:=	OemToAnsi(STR0019)+Space(32)+RetTitle("I2_ITEMD",09)+" "+;
						RetTitle("I2_ITEMC",09)+" "+RetTitle("I2_CCD",09)+" "+;
						RetTitle("I2_CCC",09)
		tamanho := "G"
	EndIf	
	//"Doc    Li Tp Ct Debito            Ct Credito            Valor            HP. Historico"
	// 01234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^67890
	//           1         2         3         4         5         6         7         8         9         0         1         2         3         4
	
ELSE      //DESMEBRA LANCTO
	If !lItem .And. !lCusto
		cabecAna	:=	OemToAnsi(STR0022)+" "+Space(8)+"  "+Space(15)+;
						OemToAnsi(STR0023)
	ElseIf lItem .And. !lCusto
		cabecAna	:=	OemToAnsi(STR0022)+" "+RetTitle("I4_ITEM",08)+"  "+;
						Space(15)+OemToAnsi(STR0023)
	ElseIf !lITem .And. lCusto
		cabecAna	:=	OemToAnsi(STR0022)+" "+Space(8)+"  "+;
						RetTitle("I3_CUSTO",15)+OemToAnsi(STR0023)
	Else
		cabecAna	:=	OemToAnsi(STR0022)+" "+RetTitle("I4_ITEM",08)+;
						"  "+RetTitle("I3_CUSTO",15)+OemToAnsi(STR0023)
	EndIf
	//"Doc   Li Tp Conta           "                       "Valor Debito     Valor Credito HP. Historico"
	// 01234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^67890
	//           1         2         3         4         5         6         7         8         0         1         2         3
ENDIF

IF mv_par07 == 1				// Relatorio Analitico
	titulo += OemToAnsi(STR0015)  //" - Analitico"
	cabec1:=cabecAna
Else								// Relatorio Sintetico
	titulo += OemToAnsi(STR0017)  //" - Sintetico"
	cabec1:=OemToAnsi(STR0018)  //"Lote  Mes                    Total Informado          Total Debito          Total Credito          Total Digitado          Diferenca"
	Tamanho:= "M"
End

dbSelectArea("SI2")
#IFDEF TOP
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria Arquivo Temporario p/ TOP CONNECT					 		  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Cr120CriaSI2()
	lArqTmp := .T.
#ELSE
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria indice temporario para os demais						 		  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cIndex := CriaTrab(nil,.f.)
	cFiltro 	:= 'I2_LOTE >= '+'"'+mv_par01+'"'+;
					'.And. I2_LOTE <= '+ '"'+ mv_par02+; 
					'"'+ '.And. DTOS(I2_DATA) >= '+ '"'+ DTOS(mv_par03)+;
					'"'+ '.And. DTOS(I2_DATA) <= '+ '"'+ DTOS(mv_par04)+'"'
	IndRegua("SI2",cIndex,"I2_FILIAL+I2_LOTE+DTOS(I2_DATA)+I2_DOC",,cFiltro,OemToAnsi(STR0020))
	nIndex := RetIndex("SI2")
	dbSelectArea("SI2")
	dbSetIndex(cIndex+OrdBagExt())
	dbSetOrder(nIndex+1)
	dbGoTop()
	lArqTmp := .F.
	cFilterUser := aReturn[7]
#ENDIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza Lancamento inicial									 		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSeek(xFilial("SI2")+mv_par01,.T.)

SetRegua(RecCount())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis									              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTotDeb		:= 0
nTotCrd		:= 0
nTotDig		:= 0
nTotRdDeb 	:= 0
nTotRdCrd 	:= 0
nTotDias  	:= 0
nTotHist  	:= 0

While ( !Eof() .And. I2_FILIAL==xFilial("SI2") )

	#IFNDEF WINDOWS
		Inkey()
		If Lastkey() == K_ALT_A
			lEnd := .T.
		EndIf
	#ENDIF

	IF lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	EndIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cFilterUser).and.!(&cFilterUser)
		dbSkip()
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime cabecalho e indicador de Lote + Data                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF li > 50
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
		li--
		lReplica := .T.
	ElseIf mv_par08 == 1 								// quebra por lote
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
		li--
		lReplica := .T.
	EndIF
	If mv_par07 == 1				// Relatorio Analitico
		If !lReplica
			li++
			@li,00 PSay	Replicate("-",132)
		EndIf	
		li++
		cR120Impr(OemToAnsi(STR0024)+I2_LOTE+OemToAnsi(STR0025)+;
					DtoC(I2_DATA),li,00,mv_par07)
		li++
		lReplica := .F.	
	EndIf	

	cLote 		:= I2_LOTE
	dData 		:= I2_DATA
	cPeriodo		:= I2_PERIODO
   cDoc			:= I2_DOC
	nTotDebDoc	:= 0
	nTotCrdDoc	:= 0
	nTotNoDesm	:= 0
	While !Eof() .and. I2_FILIAL==xFilial("SI2") .and.;
		DTOS(I2_DATA) == DTOS(dData) .and. cLote==I2_LOTE
		
		IncRegua()

		#IFNDEF WINDOWS
			Inkey()
			If Lastkey() == K_ALT_A
				lEnd := .T.
			EndIf
		#ENDIF
	
		IF lEnd
			@Prow()+1,0 PSAY cCancel
			Exit
		EndIF

		If mv_par11 == 1  .And. MV_PAR07 == 1          // Totaliza por documento?
			If cDoc != I2_DOC
				Exit
			EndIf
		EndIf		

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro do usuario                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFilterUser).and.!(&cFilterUser)
			dbSkip()
			Loop
		Endif

      cAlias := Alias()
		
		If Substr(I2_MOEDAS,Mv_Par06,1) != "S" .And. I2_DC != "-"
			dbSkip()
			Loop
		End

		IF mv_par07 == 1					// Relatorio Analitico
			li++
		EndIF

		IF li > 50
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			cR120Impr(OemToAnsi(STR0024)+cLote+OemToAnsi(STR0025)+;
						DtoC(I2_DATA)+OemToAnsi(STR0026),li,00,mv_par07)
			li+=2
		EndIF

		cR120Impr(I2_DOC	,li,00,mv_par07)
		cR120Impr(I2_LINHA,li,07,mv_par07)
		If mv_par10 == 2					// Nao Desmembra Lancamento X
			cR120Impr(I2_DC,li,10,mv_par07)
		Else									// Desmembra
			cr120Impr(IIF(I2_DC == "X","D",I2_DC),li,10,mv_par07)
		EndIf			

		cResDeb := " "
		cResCrd := " "

		IF mv_par05 == 2					// Codigo Reduzido da Conta
			IF !Empty(I2_DEBITO)
				cDebito := I2_DEBITO
				dbSelectArea("SI1")
				dbSeek(xFilial("SI1")+cDebito)
				cResDeb := SI1->I1_RES
				cDebito := SI1->I1_RES
			EndIf	
			If !lArqTmp
				DbSelectArea("SI2")
			Else
				DbSelectArea("cArqTmp")
			EndIf
			If !Empty(I2_CREDITO)	
				cCredito := I2_CREDITO
				dbSelectArea("SI1")
				dbSeek(xFilial("SI1")+cCredito)
				cResCrd := SI1->I1_RES
				cCredito:= SI1->I1_RES
			EndIF	
			If !lArqTmp
				DbSelectArea("SI2")
			Else
				DbSelectArea("cArqTmp")
			EndIf
		Else
			cDebito := Alltrim(I2_DEBITO)+I2_DCD
			cCredito:= Alltrim(I2_CREDITO)+I2_DCC
			cResDeb := I2_DEBITO+I2_DCD
			cResCrd := I2_CREDITO+I2_DCC
		EndIF
	
		IF mv_par10 == 2				// Nao Desmembra Lancamento X
			If !Empty(I2_DEBITO)
				cR120Impr(cDebito,li,13,mv_par07)
			EndIf
			If !Empty(I2_CREDITO)
				cR120Impr(cCredito,li,34,mv_par07)
			EndIf	
		Else								// Desmembra Lancamento X
			If !Empty(I2_DEBITO)
				cR120Impr(cDebito,li,12,mv_par07)
			EndIf	
			If !Empty(I2_CREDITO) .And. I2_DC == "C"
				cR120Impr(cCredito,li,12,mv_par07)
			EndIf	
		EndIf
		cResDeb := I2_DEBITO+I2_DCD
		cResCrd := I2_CREDITO+I2_DCC

		If !lArqTmp
			DbSelectArea("SI2")
		Else
			DbSelectArea("cArqTmp")
		EndIf	

		cMoeda:=Str(Mv_Par06,1)
		nValLanc:=Iif(Mv_Par06==1,I2_VALOR,I2_VLMOED&cMoeda)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ QUANDO NAO DESMEMBRA LANCAMENTO X, O LAYOUT MUDA             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par10 == 2
			If I2_DC != "-"
				cR120Impr(nValLanc,li,56,mv_par07,tm(nValLanc,16))
			EndIf			
			If lItem .And. lCusto
				cR120Impr(I2_HP,li,73,mv_par07)
				cR120Impr(trim(SubStr(I2_HIST,1,40)),li,77,mv_par07)
				cR120Impr(I2_ITEMD,li,118,mv_par07)
				cR120Impr(I2_ITEMC,li,128,mv_par07)
				cR120Impr(I2_CCD,li,138,mv_par07)
				cR120Impr(I2_CCC,li,148,mv_par07)
			ElseIf lItem .And. !lCusto
				cR120Impr(I2_HP,li,73,mv_par07)
				cR120Impr(Trim(SubStr(I2_HIST,1,30)),li,77,mv_par07)
				cR120Impr(I2_ITEMD,li,108,mv_par07)
				cR120Impr(I2_ITEMC,li,118,mv_par07)
				cRestoHist:=Substr(Trim(I2_HIST),31)
				IF !empty(cRestoHist) .and. mv_par07 == 1
					li++
					cR120Impr(cRestoHist,li,77,mv_par07)
				Endif
			ElseIf !lItem .And. lCusto
				cR120Impr(I2_HP,li,73,mv_par07)
				cR120Impr(Trim(SubStr(I2_HIST,1,30)),li,77,mv_par07)
				cR120Impr(I2_CCD,li,108,mv_par07)
				cR120Impr(I2_CCC,li,118,mv_par07)
				cRestoHist:=Substr(Trim(I2_HIST),31)
				IF !empty(cRestoHist) .and. mv_par07 == 1
					li++
					cR120Impr(cRestoHist,li,77,mv_par07)
				Endif
			Else
				cR120Impr(I2_HP,li,73,mv_par07)
				cR120Impr(Trim(SubStr(I2_HIST,1,40)),li,77,mv_par07)
			EndIf	
		Else						// DESMEMBRA LANCAMENTO
			If lItem
				If !Empty(I2_ITEMD)
					cR120Impr(I2_ITEMD,li,29,mv_par07)
				EndIf
				If !Empty(I2_ITEMC) .And. I2_DC == "C"
					cR120Impr(I2_ITEMC,li,29,mv_par07)
				EndIf	
			EndIf
			If lCusto
				If !Empty(I2_CCD)
					cR120Impr(I2_CCD,li,39,mv_par07)
				EndIf
				If !Empty(I2_CCC) .And. I2_DC == "C"
					cR120Impr(I2_CCC,li,39,mv_par07)
				EndIf	
			EndIf
			If I2_DC != "-"
				If I2_DC == "D" .Or. I2_DC == "X"
					cR120Impr(nValLanc,li,50,mv_par07,tm(nValLanc,16))
				ElseIf I2_DC == "C"
					cR120Impr(nValLanc,li,68,mv_par07,tm(nValLanc,16))
				EndIf	
			EndIf			
			cR120Impr(I2_HP   ,li,85,mv_par07)
			cR120Impr(Trim(SubStr(I2_HIST,1,40)),li,89,mv_par07)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime a Linha de Credito no desmembramento de lctos. part. ³
			//³ dobrada.  																	  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			If mv_par10 == 1 .And. I2_DC == "X"
				li += if( mv_par07 == 1,1,0)
				cR120Impr(I2_DOC	,li,00,mv_par07)
				cR120Impr(I2_LINHA,li,07,mv_par07)
				cr120Impr("C",li,10,mv_par07)
				IF mv_par05 == 2 									// Imprime codigo reduzido
					cCredito := I2_CREDITO
					dbSelectArea( "SI1" )
					dbSeek( xFilial("SI1") + cCredito )
					cResCrd := SI1->I1_RES
					cR120Impr( I1_RES, li, 12, mv_par07 )
					If !lArqTmp
						DbSelectArea("SI2")
					Else
						DbSelectArea("cArqTmp")
					EndIf	
				Else
					cR120Impr(Alltrim(I2_CREDITO)+I2_DCC, li, 12, mv_par07 )
				EndIF
				If lItem
					cR120Impr(I2_ITEMC,li,29,mv_par07)	
				EndIf	
				If lCusto
					cR120Impr(I2_CCC,li,39,mv_par07)
				EndIf

				cR120Impr(nValLanc,li,68,mv_par07,tm(nValLanc,16))
				cR120Impr(I2_HP   ,li,85,mv_par07)
				cR120Impr(Trim(SubStr(I2_HIST,1,40)),li,89,mv_par07)
			EndIf
		EndIf
			
		IF I2_DC $ "DX"
			nTotDeb		+= nValLanc
			nTotDebDoc	+= nValLanc
			If I2_DC == "D"
				nTotNoDesm	+= nValLanc
			EndIf
			If !Empty(cResDeb)
				nTotRdDeb := nTotRdDeb + Val(cResDeb)
			Endif
		EndIF
		
		IF I2_DC $ "CX"
			nTotCrd		+= nValLanc
			nTotCrdDoc	+= nValLanc
			If I2_DC == "C"
				nTotNoDesm	+= nValLanc
			EndIf
			If !Empty(cResCrd)
				nTotRdCrd := nTotRdCrd + Val(cResCrd)
			Endif
		EndIF

		If I2_DC == "X"			
			If GetMv("MV_SOMA") == 2
				nTotNoDesm	+= (nValLanc*2)
			Else
				nTotNoDesm 	+= nValLanc
			EndIf
		EndIf	

		nTotDias := nTotDias+IIF(I2_DC$"DCX",Day(I2_DATA),0)
		nTotHist := nTotHist+Val(I2_HP)	
		nTotDig  +=IIF(GetMv("MV_SOMA")==1 .Or. I2_DC=="C" .Or. I2_DC=="D",;
						 nValLanc,nValLanc*2)
		dbSkip( )
	End

	If nTotDeb + nTotCrd > 0
		IF mv_par07 == 1				// Relatorio Analitico
			li+=2
			If ( li > 52 )
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
				cR120Impr(OemToAnsi(STR0024)+cLote+OemToAnsi(STR0025)+;
						DtoC(dData)+OemToAnsi(STR0026),li,00,mv_par07)
				li+=2
			End
			If mv_par11 == 1 							// Totaliza por Documento
				@li,0   PSAY Subs(OemToAnsi(STR0008),1,5)+" -->"
				If mv_par10 == 1
					@li,050 PSAY nTotDebDoc    Picture tm(nTotDebDoc,16)
					@li,068 PSAY nTotCrdDoc    Picture tm(nTotCrdDoc,16)
					li+=2
				Else
					@li,045 PSAY nTotNoDesm		Picture tm(nTotNoDesm,16)
					li+=2
				EndIf
				
				// Imprime Total do Lote
				If (cFilial+cLote+Dtos(dData)) <>;
					(SI2->I2_FILIAL+SI2->I2_LOTE+Dtos(SI2->I2_DATA)) .Or. Eof()
					dbSelectArea("SI6")
					dbSetOrder(2)
					dbSeek(xFilial()+cLote+Dtos(dData))    //cPeriodo))

					@li, 0 PSAY OemToAnsi(STR0008)  //Total Informado
					@li,21 PSAY SI6->I6_INF	Picture tm(SI6->I6_INF,16)
					@li,40 PSAY OemtoAnsi(STR0009)  //"Total Debito"
					@li,54 PSAY nTotDeb   Picture tm(nTotDeb,17)
					li++

					@li, 0 PSAY OemToAnsi(STR0010)  //"Total Digitado  :"
					@li,21 PSAY nTotDig	 Picture tm(nTotDig,17)
					@li,40 PSAY OemToAnsi(STR0011)  //"Total Credito:"
					@li,54 PSAY nTotCrd   Picture tm(nTotCrd,17)
					If mv_par06 == 1							
						@li, 80 PSAY OemToAnsi(STR0012)  //"Diferenca Total:"	
						@li,104 PSAY Abs((nTotDig-SI6->I6_INF))  Picture tm(Abs(nTotDig-SI6->I6_INF),15)
						If Round(nTotDeb,2) != Round(nTotCrd,2)
							li++
							@li, 80 PSAY OemToAnsi(STR0013)  //"Dif Debito/Credito:"
							@li,104 PSAY Abs((nTotDeb-nTotCrd)) 	 Picture tm(Abs(nTotDeb-nTotCrd),15)
						End
					End
					li++
					@ li,0	PSAY OemToAnsi(STR0027)			//"Total Cta.Deb.  : "
					@ li,21	PSAY nTotRdDeb Picture tm(nTotRdDeb,17)
					@ li,40	PSAY OemToAnsi(STR0028)			//"Total Cta.Crd:"
					@ li,54	PSAY nTotRdCrd Picture tm(nTotRdCrd,17)
					li++
					@ li,0	PSAY OemToAnsi(STR0029)			//"Total Dias      : "
					@ li,21	PSAY nTotDias Picture tm(nTotDias,17)
					@ li,40	PSAY OemToAnsi(STR0030)			//"Total Hist.  :"
					@ li,54	PSAY nTotHist Picture tm(nTotHist,17)
					li++
	            //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	            //³ Inicializa variaveis                                         ³
	            //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   	         nTotDeb     := 0
	            nTotCrd     := 0
	            nTotDig     := 0
	            nTotRdDeb   := 0
	            nTotRdCrd   := 0
	            nTotDias    := 0
	            nTotHist    := 0
				EndIf	
			Else	
				If (cFilial+cLote+Dtos(dData)) <>;
					(SI2->I2_FILIAL+SI2->I2_LOTE+Dtos(SI2->I2_DATA)) .Or. Eof()
					SI6->(dbSeek(xFilial()+cLote+Dtos(dData)))  //cPeriodo))

					@li, 0 PSAY OemToAnsi(STR0008)  //Total Informado
					@li,21 PSAY SI6->I6_INF	Picture tm(SI6->I6_INF,16)
					@li,40 PSAY OemtoAnsi(STR0009)  //"Total Debito"
					@li,54 PSAY nTotDeb   Picture tm(nTotDeb,17)
					li++

					@li, 0 PSAY OemToAnsi(STR0010)  //"Total Digitado  :"
					@li,21 PSAY nTotDig	 Picture tm(nTotDig,17)
					@li,40 PSAY OemToAnsi(STR0011)  //"Total Credito:"
					@li,54 PSAY nTotCrd   Picture tm(nTotCrd,17)
					If mv_par06 == 1							
						@li, 80 PSAY OemToAnsi(STR0012)  //"Diferenca Total:"	
						@li,104 PSAY Abs((nTotDig-SI6->I6_INF))  Picture tm(Abs(nTotDig-SI6->I6_INF),15)
						If Round(nTotDeb,2) != Round(nTotCrd,2)
							li++
							@li, 80 PSAY OemToAnsi(STR0013)  //"Dif Debito/Credito:"
							@li,104 PSAY Abs((nTotDeb-nTotCrd)) 	 Picture tm(Abs(nTotDeb-nTotCrd),15)
						End
					End
					li++
					@ li,0	PSAY OemToAnsi(STR0027)			//"Total Cta.Deb.  : "
					@ li,21	PSAY nTotRdDeb Picture tm(nTotRdDeb,17)
					@ li,40	PSAY OemToAnsi(STR0028)			//"Total Cta.Crd:"
					@ li,54	PSAY nTotRdCrd Picture tm(nTotRdCrd,17)
					li++
					@ li,0	PSAY OemToAnsi(STR0029)			//"Total Dias      : "
					@ li,21	PSAY nTotDias Picture tm(nTotDias,17)
					@ li,40	PSAY OemToAnsi(STR0030)			//"Total Hist.  :"
					@ li,54	PSAY nTotHist Picture tm(nTotHist,17)
					li++
	            //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	            //³ Inicializa variaveis                                         ³
	            //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   	         nTotDeb     := 0
	            nTotCrd     := 0
	            nTotDig     := 0
	            nTotRdDeb   := 0
	            nTotRdCrd   := 0
	            nTotDias    := 0
	            nTotHist    := 0
				EndIf	
          Endif
		Else							// Relatorio Sintetico
			@li, 0 PSAY cLote
			@li, 6 PSAY SubStr(cPeriodo,5,2)
			SI6->(dbSeek(xFilial()+cLote+cPeriodo))			
			@li,10 PSAY SI6->I6_INF     Picture tm(SI6->I6_INF,17)
			@li,30 PSAY nTotDeb			 Picture tm(nTotDeb,17)
			@li,50 PSAY nTotCrd			 Picture tm(nTotCrd,17)
			@li,70 PSAY nTotDig			 Picture tm(nTotDig,17)
			nTotTInf += SI6->I6_INF
			nTotTDeb += nTotDeb
			nTotTCred+= nTotCrd
			nTotTDig += nTotDig
			If Mv_Par06 == 1				// Diferenca entre tot dig e tot Inf Moeda 1
				@li,90 PSAY Abs((nTotDig-SI6->I6_INF))  Picture tm(Abs(nTotDig-SI6->I6_INF),16)
				nTotTDif += Abs((nTotDig-SI6->I6_INF))
			Endif
			@li,111 PSAY Abs((nTotDeb-nTotCrd))  Picture tm(Abs(nTotDeb-nTotCrd),17)
			If Val(Alltrim(Str(nTotDeb))) > Val(Alltrim(Str(nTotCrd)))
				@li, pcol()+1 pSay "D"
			ElseIf Val(Alltrim(Str(nTotDeb))) < Val(Alltrim(Str(nTotCrd)))
				@li, pcol()+1 pSay "C"
			EndIf
			nTotTDif1 += (nTotDeb-nTotCrd)
			li++
         //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
         //³ Inicializa variaveis                                         ³
         //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
         nTotDeb     := 0
         nTotCrd     := 0
         nTotDig     := 0
         nTotRdDeb   := 0
         nTotRdCrd   := 0
         nTotDias    := 0
         nTotHist    := 0
		End
	End
End

IF mv_par07 == 2 .And. !lEnd
	ImpTot120(nTotTInf,nTotTDeb,nTotTCred,nTotTDig,nTotTDif,nTotTDif1)
Endif

if li != 80
	roda(cbcont,cbtxt,Tamanho)
endif	
Set Filter To
#IFNDEF WINDOWS
	Set Device To Screen
#ENDIF
dbSetOrder(1)
If aReturn[5] = 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif

If !lArqTmp
	dbSelectArea("SI2")
	Set Filter To
	RetIndex("SI2")
	Ferase(cIndex+OrdBagExt())
Else
	dbSelectArea("cArqTmp")
	Set Filter To
	dbCloseArea("cArqTmp")
	FErase(cArqTmp+".DBF")
	FErase("cArqInd"+OrdBagExt())
	dbselectArea("SI2")
EndIf	

MS_FLUSH()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ cR120Impr³ Autor ³ Erick Nori Barbosa	  ³ Data ³ 14.12.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime uma determinada linha do relat¢rio de Lotes		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ cR120Impr(ExpC1,ExpN1,ExpN2,ExpN3,ExpC2)						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso	 	 ³ Conr120																	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function cR120Impr(cTexto,nLin,nCol,nTipo,cPicture)
If nTipo == 1
	IF !Empty(cPicture)
		@ nLin,nCol PSAY cTexto Picture cPicture
	Else
		@ nLin,nCol PSAY cTexto Picture "@!"
	End
EndIf
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ImpTot120 ³ Autor ³ Erick Nori Barbosa	  ³ Data ³ 01.06.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³IMPRIMIR TOTAL DO RELATORIO											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpTot120() 											  				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 														  	  				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso	 	 ³ Conr120												  	  				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpTot120(nTot1,nTot2,nTot3,nTot4,nTot5,nTot6)
li++
If ( li > 55 )
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
End

@li,000 PSAY OemToAnsi(STR0014)  //"TOTAL GERAL -->"
@li,010 PSAY nTot1		 Picture TM(nTot1,17)
@li,030 PSAY nTot2		 Picture TM(nTot2,17)
@li,050 PSAY nTot3		 Picture TM(nTot3,17)
@li,070 PSAY nTot4		 Picture TM(nTot4,17)
@li,090 PSAY nTot5		 Picture TM(nTot5,17)
If nTot6 < 0
	@li,111 PSAY Abs(nTot6)  Picture TM(nTot6,17) + " C"
Else
	@li,111 PSAY nTot6       Picture TM(nTot6,17) + IIf(nTot6 <> 0," D","")
Endif
li++
Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o	  ³ Cr120Imp1³ Autor ³ Pilar S. Albaladejo	³ Data ³ 05/11/93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Relacao de Lotes - PARA PRE-LANCAMENTOS						   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³ Cr120Imp1(lEnd,wnRel,cString) 							   		³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		  ³ SIGACON 												   				³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ lEnd - A‡Æo do Codeblock								   			³±±
±±³			  ³ wnRel	- T¡tulo do relat¢rio							   		³±±
±±³			  ³ cString - Mensagem										   			³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Cr120Imp1(lEnd,WnRel,cString)

LOCAL limite := 132
LOCAL nTotDeb,nTotCrd,nTotDig,nTotDebDoc,nTotCrdDoc,nTotNoDesm
LOCAL nTotTInf:=nTotTDeb:=nTotTCred:=nTotTDig:=nTotTDif:=nTotTDif1:=0
LOCAL nValLanc
Local cPer, cPeriodoIC, cPeriodo
LOCAL CbTxt
LOCAL cbcont
Local nTotRdDeb := 0
LOCAL nTotRdCrd := 0
LOCAL nTotDias := 0
LOCAL nTotHist := 0
LOCAL cResDeb
LOCAL cResCrd
LOCAL lCusto	:= .f.
Local cDigVer	:= GetMv("MV_DIGVER")
LOCAL lItem	 	:= .f.
Local lReplica := .f.
Local dData, cDebito, cCredito
Local cIndex, nIndex
Local cFiltro, cFilterUser

PRIVATE cMesAtu17

PRIVATE tamanho:="M"

cbtxt  := SPACE(10)
cbcont	 := 0

If ! DataMoeda(mv_par06, @cMesAtu17, mv_par03)
	#IFNDEF	WINDOWS
		Set Device To Screen
	#ENDIF
	Help(" ",1,"MESINVALID")
	Set Filter To
	Return
End
If ! DataMoeda(mv_par06, @cMesAtu17, mv_par04)
	#IFNDEF	WINDOWS
		Set Device To Screen
	#ENDIF
	Help(" ",1,"MESINVALID")
	Set Filter To
	Return
End

// Se a moeda escolhida, nao esta em uso -> sai do programa.
If Empty(GetMv("MV_MOEDA"+Str(mv_par06,1)))
	Set Filter To
	Return
End

dbSelectArea("SX3")
dbSetOrder(2)
dbSeek("IC_CCD")
If X3Uso(X3_USADO)
	lCusto := .t.
End
dbSeek("IC_ITEMD")
If X3Uso(X3_USADO)
	lItem := .t.
End
dbSetOrder(1)

IF mv_par10 == 2				// Nao desmembra lancamento tipo X
	If !lItem .and. !lCusto
		cabecAna	:=	OemToAnsi(STR0019)
	ElseIf lItem .And. !lCusto
		cabecAna	:=	OemToAnsi(STR0019)+Space(22)+RetTitle("IC_ITEMD",09)+" "+;
						RetTitle("IC_ITEMC",09)
	ElseIf !lItem .And. lCusto
		cabecAna	:=	OemToAnsi(STR0019)+Space(22)+RetTitle("IC_CCD",09)+" "+;
						RetTitle("IC_CCC",09)
	Else
		cabecAna	:=	OemToAnsi(STR0019)+Space(32)+RetTitle("IC_ITEMD",09)+" "+;
						RetTitle("IC_ITEMC",09)+" "+RetTitle("IC_CCD",09)+" "+;
						RetTitle("IC_CCC",09)
		tamanho := "G"
		//"Doc    Li Tp Ct Debito            Ct Credito            Valor            HP. Historico"                               ITEMD     ITEMC     CCUSTOD   CCUSTOC
		// xxxxxx 99 DC XXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX 99,999,999,999.99 xxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx XXXXXXXXX XXXXXXXXX XXXXXXXXX XXXXXXXXX
		// 01234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^6789012
		//           1         2         3         4         5         6         7         8         9         0         1         2         3         4     
	EndIf	

ELSE    // Desmembra lancamento tipo X
	If !lItem .And. !lCusto
		cabecAna	:=	OemToAnsi(STR0022)+Space(34)+;
						OemToAnsi(STR0023)
	ElseIf lItem .And. !lCusto
		cabecAna	:=	OemToAnsi(STR0022)+" "+Space(05)+RetTitle("I4_ITEM",08)+"  "+;
						Space(18)+OemToAnsi(STR0023)
	ElseIf !lITem .And. lCusto
		cabecAna	:=	OemToAnsi(STR0022)+" "+Space(15)+RetTitle("I3_CUSTO",08)+" "+;
						Space(09)+OemToAnsi(STR0023)
					//	"Doc    Li Tp Conta               "CCUSTO               "    Valor Debito    Valor Credito HP. Historico"
					//  xxxxxx 99 DC xxxxxxxxxxxxxxxxxxxx XXXXXXXXX XXXXXXXXX      9,999,999,999.99 9,999,999,999.99 999 xxxxxxxxxxxxxxxxxxxxxxxxx
					//  01234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^67890
					//            1         2         3         4         5         6         7         8         9         0         1         2         3
	Else
		cabecAna	:=	OemToAnsi(STR0022)+" "+Space(5)+RetTitle("I4_ITEM",08)+;
						"  "+RetTitle("I3_CUSTO",15)+Space(3)+OemToAnsi(STR0023)
					// "Doc    Li Tp Conta               "
					//	"Doc    Li Tp Conta               "ITEM CONT CCUSTO        "    Valor Debito    Valor Credito HP. Historico"
					//  xxxxxx 99 DC xxxxxxxxxxxxxxxxxxxx XXXXXXXXX XXXXXXXXX      9,999,999,999.99 9,999,999,999.99 999 xxxxxxxxxxxxxxxxxxxxxxxxx
					//  01234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^678901234^67890
					//            1         2         3         4         5         6         7         8         9         0         1         2         3
	EndIf
ENDIF

IF mv_par07 == 1				// Relatorio Analitico
	titulo += OemToAnsi(STR0015)  //" - Analitico"
	cabec1:=cabecAna
Else								// Relatorio Sintetico
	titulo += OemToAnsi(STR0017)  //" - Sintetico"
	cabec1 := OemToAnsi(STR0018)  //"Lote  Mes                    Total Informado          Total Debito          Total Credito          Total Digitado          Diferenca"
	Tamanho:= "M"
End

dbSelectArea("SIC")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria indice temporario                 				 		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cIndex := CriaTrab(nil,.f.)
cFiltro 	:= 'IC_LOTE >= '+'"'+mv_par01+'"'+;
				'.And. IC_LOTE <= '+ '"'+ mv_par02+; 
				'"'+ '.And. DTOS(IC_DATA) >= '+ '"'+ DTOS(mv_par03)+;
				'"'+ '.And. DTOS(IC_DATA) <= '+ '"'+ DTOS(mv_par04)+'"'
IndRegua("SIC",cIndex,"IC_FILIAL+IC_LOTE+DTOS(IC_DATA)+IC_DOC",,cFiltro,OemToAnsi(STR0020))
nIndex := RetIndex("SIC")
dbSelectArea("SIC")
#IFNDEF TOP
	dbSetIndex(cIndex+OrdBagExt())
#ENDIF	
dbSetOrder(nIndex+1)
dbGoTop()
cFilterUser := aReturn[7]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza Lancamento inicial									 		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSeek(xFilial("SIC")+mv_par01,.T.)

SetRegua(RecCount())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis									              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTotDeb		:= 0
nTotCrd		:= 0
nTotDig		:= 0
nTotRdDeb 	:= 0
nTotRdCrd 	:= 0
nTotDias  	:= 0
nTotHist  	:= 0

While ( !Eof() .And. IC_FILIAL==xFilial("SIC") )

	#IFNDEF WINDOWS
		Inkey()
		If Lastkey() == K_ALT_A
			lEnd := .T.
		EndIf
	#ENDIF

	IF lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	EndIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cFilterUser).and.!(&cFilterUser)
		dbSkip()
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime cabecalho e indicador de Lote + Data                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF li > 50
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
		li--
		lReplica := .T.
	ElseIf mv_par08 == 1 								// quebra por lote
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
		li--
		lReplica := .T.
	EndIF
	If mv_par07 == 1				// Relatorio Analitico
		If !lReplica
			li++
			@li,00 PSay	Replicate("-",132)
		EndIf	
		li++
		cR120Impr(OemToAnsi(STR0024)+IC_LOTE+OemToAnsi(STR0025)+;
					DtoC(IC_DATA),li,00,mv_par07)
		li++
		lReplica := .F.	
	EndIf	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa variaveis									              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTotDebDoc  := 0.00
	nTotCrdDoc  := 0.00
	cLote 		:= IC_LOTE
	dData 		:= IC_DATA
	cPeriodo		:= IC_PERIODO
	cDoc			:= IC_DOC
	nTotNoDesm	:= 0
	
	While !Eof() .and. IC_FILIAL==xFilial("SIC") .and.;
		DTOS(IC_DATA) == DTOS(dData) .and. cLote==IC_LOTE
		
		IncRegua()

		#IFNDEF WINDOWS
			Inkey()
			If Lastkey() == K_ALT_A
				lEnd := .T.
			EndIf
		#ENDIF
	
		IF lEnd
			@Prow()+1,0 PSAY cCancel
			Exit
		EndIF

		If mv_par11 == 1 .And. MV_PAR07 == 1           // Totaliza por documento?
			If cDoc != IC_DOC
				Exit
			EndIf
		EndIf		

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro do usuario                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFilterUser).and.!(&cFilterUser)
			dbSkip()
			Loop
		Endif

		If Substr(IC_MOEDAS,Mv_Par06,1) != "S" .And. IC_DC != "-"
			dbSkip()
			Loop
		End

		IF mv_par07 == 1					// Relatorio Analitico
			li++
		EndIF

		IF li > 50
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			cR120Impr(OemToAnsi(STR0024)+cLote+OemToAnsi(STR0025)+;
						DtoC(IC_DATA)+OemToAnsi(STR0026),li,00,mv_par07)
			li+=2
		EndIF

		cR120Impr(IC_DOC	,li,00,mv_par07)
		cR120Impr(IC_LINHA,li,07,mv_par07)
		If mv_par10 == 2					// Nao Desmembra Lancamento X
			cR120Impr(IC_DC,li,10,mv_par07)
		Else									// Desmembra
			cr120Impr(IIF(IC_DC == "X","D",IC_DC),li,10,mv_par07)
		EndIf			

		cResDeb := " "
		cResCrd := " "

		IF mv_par05 == 2
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime Codigo Reduzido da Conta                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IF !Empty(IC_DEBITO)
				cDebito := IC_DEBITO
				dbSelectArea("SI1")
				dbSeek(xFilial("SI1")+cDebito)
				cResDeb := SI1->I1_RES
				cDebito := SI1->I1_RES
			EndIf	
			DbSelectArea("SIC")
			If !Empty(IC_CREDITO)	
				cCredito := IC_CREDITO
				dbSelectArea("SI1")
				dbSeek(xFilial("SI1")+cCredito)
				cResCrd := SI1->I1_RES
				cCredito:= SI1->I1_RES
			EndIF	
			DbSelectArea("SIC")
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime Codigo Normal da Conta                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cDebito := Alltrim(IC_DEBITO)+IC_DCD
			cCredito:= Alltrim(IC_CREDITO)+IC_DCC
			cResDeb := IC_DEBITO+IC_DCD
			cResCrd := IC_CREDITO+IC_DCC
		EndIF
	
		IF mv_par10 == 2				// ************* Nao Desmembra Lancamento X
			If !Empty(IC_DEBITO)
				cR120Impr(cDebito,li,13,mv_par07)
			EndIf
			If !Empty(IC_CREDITO)
				cR120Impr(cCredito,li,34,mv_par07)
			EndIf	
		Else								// *************  Desmembra Lancamento X
			If !Empty(IC_DEBITO)
				cR120Impr(cDebito,li,13,mv_par07)
			EndIf	
			If !Empty(IC_CREDITO) .And. IC_DC == "C"
				cR120Impr(cCredito,li,13,mv_par07)
			EndIf	
		EndIf
		cResDeb := IC_DEBITO+IC_DCD
		cResCrd := IC_CREDITO+IC_DCC

		DbSelectArea("SIC")
		cMoeda:=Str(Mv_Par06,1)
		nValLanc:=Iif(Mv_Par06==1,IC_VALOR,IC_VLMOED&cMoeda)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ QUANDO NAO DESMEMBRA LANCAMENTO X, O LAYOUT MUDA             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par10 == 2
			If IC_DC != "-"
				cR120Impr(nValLanc,li,55,mv_par07,tm(nValLanc,16))
			EndIf			
			If lItem .And. lCusto
				cR120Impr(IC_HP,li,73,mv_par07)
				cR120Impr(Trim(SubStr(IC_HIST,1,40)),li,77,mv_par07)
				cR120Impr(IC_ITEMD,li,118,mv_par07)
				cR120Impr(IC_ITEMC,li,128,mv_par07)
				cR120Impr(IC_CCD,li,138,mv_par07)
				cR120Impr(IC_CCC,li,148,mv_par07)
			ElseIf lItem .And. !lCusto
				cR120Impr(IC_HP,li,73,mv_par07)
				cR120Impr(Trim(SubStr(IC_HIST,1,30)),li,77,mv_par07)
				cR120Impr(IC_ITEMD,li,108,mv_par07)
				cR120Impr(IC_ITEMC,li,118,mv_par07)
			ElseIf !lItem .And. lCusto
				cR120Impr(IC_HP,li,73,mv_par07)
				cR120Impr(Trim(SubStr(IC_HIST,1,30)),li,77,mv_par07)			
				cR120Impr(IC_CCD,li,108,mv_par07)
				cR120Impr(IC_CCC,li,118,mv_par07)
			Else
				cR120Impr(IC_HP,li,73,mv_par07)
				cR120Impr(Trim(SubStr(IC_HIST,1,40)),li,77,mv_par07)			
			EndIf	
		Else	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³  DESMEMBRA LANCAMENTO										³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lItem
				If !Empty(IC_ITEMD)
					cR120Impr(IC_ITEMD,li,34,mv_par07)
				EndIf
				If !Empty(IC_ITEMC) .And. IC_DC == "C"
					cR120Impr(IC_ITEMC,li,34,mv_par07)
				EndIf	
			EndIf
			If lCusto
				If !Empty(IC_CCD)
					cR120Impr(IC_CCD,li,44,mv_par07)
				EndIf
				If !Empty(IC_CCC) .And. IC_DC == "C"
					cR120Impr(IC_CCC,li,44,mv_par07)
				EndIf	
			EndIf
			If IC_DC != "-"
				If IC_DC == "D" .Or. IC_DC == "X"
					cR120Impr(nValLanc,li,59,mv_par07,tm(nValLanc,16))
				ElseIf IC_DC == "C"
					cR120Impr(nValLanc,li,76,mv_par07,tm(nValLanc,16))
				EndIf	
			EndIf			
			cR120Impr(IC_HP   ,li,93,mv_par07)
			cR120Impr(Trim(SubStr(IC_HIST,1,40)),li,97,mv_par07)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime a Linha de Credito no desmembramento de lctos. part. ³
			//³ dobrada.																	  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
			If mv_par10 == 1 .And. IC_DC == "X"
				li += if( mv_par07 == 1,1,0)
				cR120Impr(IC_DOC	,li,00,mv_par07)
				cR120Impr(IC_LINHA,li,07,mv_par07)
				cr120Impr("C",li,10,mv_par07)
				IF mv_par05 == 2 									// Imprime codigo reduzido
					cCredito := IC_CREDITO
					dbSelectArea( "SI1" )
					dbSeek( xFilial("SI1") + cCredito )
					cResCrd := SI1->I1_RES
					cR120Impr( I1_RES, li, 13, mv_par07 )
					DbSelectArea("SIC")
				Else
					cR120Impr(Alltrim(IC_CREDITO)+IC_DCC, li, 13, mv_par07 )
				EndIF
				If lItem
					cR120Impr(IC_ITEMC,li,34,mv_par07)	
				EndIf	
				If lCusto
					cR120Impr(IC_CCC,li,44,mv_par07)
				EndIf
			
				cR120Impr(nValLanc,li,76,mv_par07,tm(nValLanc,16))
				cR120Impr(Trim(SubStr(IC_HIST,1,40)),li,97,mv_par07)
			EndIf
		EndIf
			
		IF IC_DC $ "DX"
			nTotDeb		+= nValLanc
         nTotDebDoc	+= nValLanc			
			If IC_DC == "D"
				nTotNoDesm	+= nValLanc
			EndIf
			If !Empty(cResDeb)
				nTotRdDeb := nTotRdDeb + Val(cResDeb)
			Endif
		EndIF
		
		IF IC_DC $ "CX"
			nTotCrd		+= nValLanc
         nTotCrdDoc	+= nValLanc
			If IC_DC == "C"
				nTotNoDesm	+= nValLanc
			EndIf
			If !Empty(cResCrd)
				nTotRdCrd := nTotRdCrd + Val(cResCrd)
			Endif
		EndIF
		
		If IC_DC == "X"			
			If GetMv("MV_SOMA") == 2
				nTotNoDesm	+= (nValLanc*2)
			Else
				nTotNoDesm 	+= nValLanc
			EndIf
		EndIf	

		nTotDias := nTotDias+IIF(IC_DC$"DCX",Day(IC_DATA),0)
		nTotHist := nTotHist+Val(IC_HP)
		nTotDig  +=IIF(GetMv("MV_SOMA")==1 .Or. IC_DC=="C" .Or. IC_DC=="D",;
						 nValLanc,nValLanc*2)
		dbSkip( )

	End

	If nTotDeb + nTotCrd > 0
		IF mv_par07 == 1				// Relatorio Analitico
			li+=2
			If ( li > 52 )
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
				cR120Impr(OemToAnsi(STR0024)+cLote+OemToAnsi(STR0025)+;
						DtoC(dData)+OemToAnsi(STR0026),li,00,mv_par07)
				li+=2
			End
			
			If mv_par11 == 1 							// Totaliza por Documento
				@li,0   PSAY Subs(OemToAnsi(STR0008),1,5)+" -->"
				If mv_par10 == 1
					@li,050 PSAY nTotDebDoc     Picture tm(nTotDebDoc,16)
					@li,068 PSAY nTotCrdDoc     Picture tm(nTotCrdDoc,16)
					li+=2
				Else
					@li,045 PSAY nTotNoDesm		Picture tm(nTotNoDesm,16)
					li+=2
				EndIf	

				// Imprime Total do Lote
				If	(cFilial+cLote+Dtos(dData)) <>;
					(SIC->IC_FILIAL+SIC->IC_LOTE+Dtos(SIC->IC_DATA)) .Or. Eof()
					SI6->(dbSeek(xFilial()+cLote+cPeriodo))

					@li, 0 PSAY OemToAnsi(STR0008)  //Total Informado
					@li,21 PSAY SI6->I6_INF	Picture tm(SI6->I6_INF,16)
					@li,40 PSAY OemtoAnsi(STR0009)  //"Total Debito"
					@li,54 PSAY nTotDeb   Picture tm(nTotDeb,17)
					li++

					@li, 0 PSAY OemToAnsi(STR0010)  //"Total Digitado  :"
					@li,21 PSAY nTotDig	 Picture tm(nTotDig,17)
					@li,40 PSAY OemToAnsi(STR0011)  //"Total Credito:"
					@li,54 PSAY nTotCrd   Picture tm(nTotCrd,17)
					If mv_par06 == 1				
						@li, 80 PSAY OemToAnsi(STR0012)  //"Diferenca Total:"
						@li,104 PSAY Abs((nTotDig-SI6->I6_PREDIG))  Picture tm(Abs(nTotDig-SI6->I6_PREDIG),15)
						If Round(nTotDeb,2) != Round(nTotCrd,2)
							li++
							@li, 80 PSAY OemToAnsi(STR0013)  //"Dif Debito/Credito:"
							@li,104 PSAY Abs((nTotDeb-nTotCrd)) 	 Picture tm(Abs(nTotDeb-nTotCrd),15)
						End
					End
					li++
					@ li,0	PSAY OemToAnsi(STR0027)				// "Total Cta.Deb.  : "
					@ li,21	PSAY nTotRdDeb Picture tm(nTotRdDeb,17)
					@ li,40	PSAY OemToAnsi(STR0028)				// "Total Cta.Crd:"
					@ li,54	PSAY nTotRdCrd Picture tm(nTotRdCrd,17)
					li++
					@ li,0	PSAY OemToAnsi(STR0029)				// "Total Dias      : "
					@ li,21	PSAY nTotDias Picture tm(nTotDias,17)
					@ li,40	PSAY OemToAnsi(STR0030)				// "Total Hist.  :"
					@ li,54	PSAY nTotHist Picture tm(nTotHist,17)
					li++
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Inicializa variaveis                                                  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nTotDeb     := 0
					nTotCrd     := 0
					nTotDig     := 0
					nTotRdDeb   := 0
					nTotRdCrd   := 0
					nTotDias    := 0
					nTotHist    := 0
				EndIf	
			Endif
			If mv_par11 == 2
				If (cFilial+cLote+Dtos(dData)) <>;
					(SIC->IC_FILIAL+SIC->IC_LOTE+Dtos(SIC->IC_DATA)) .Or. Eof()
					SI6->(dbSeek(xFilial()+cLote+cPeriodo))

					@li, 0 PSAY OemToAnsi(STR0008)  //Total Informado
					@li,21 PSAY SI6->I6_INF	Picture tm(SI6->I6_INF,16)
					@li,40 PSAY OemtoAnsi(STR0009)  //"Total Debito"
					@li,54 PSAY nTotDeb   Picture tm(nTotDeb,17)
					li++

					@li, 0 PSAY OemToAnsi(STR0010)  //"Total Digitado  :"
					@li,21 PSAY nTotDig	 Picture tm(nTotDig,17)
					@li,40 PSAY OemToAnsi(STR0011)  //"Total Credito:"
					@li,54 PSAY nTotCrd   Picture tm(nTotCrd,17)
					If mv_par06 == 1				
						@li, 80 PSAY OemToAnsi(STR0012)  //"Diferenca Total:"
						@li,104 PSAY Abs((nTotDig-SI6->I6_PREDIG))  Picture tm(Abs(nTotDig-SI6->I6_PREDIG),15)
						If Round(nTotDeb,2) != Round(nTotCrd,2)
							li++
							@li, 80 PSAY OemToAnsi(STR0013)  //"Dif Debito/Credito:"
							@li,104 PSAY Abs((nTotDeb-nTotCrd)) 	 Picture tm(Abs(nTotDeb-nTotCrd),15)
						End
					End
					li++
					@ li,0	PSAY OemToAnsi(STR0027)				// "Total Cta.Deb.  : "
					@ li,21	PSAY nTotRdDeb Picture tm(nTotRdDeb,17)
					@ li,40	PSAY OemToAnsi(STR0028)				// "Total Cta.Crd:"
					@ li,54	PSAY nTotRdCrd Picture tm(nTotRdCrd,17)
					li++
					@ li,0	PSAY OemToAnsi(STR0029)				// "Total Dias      : "
					@ li,21	PSAY nTotDias Picture tm(nTotDias,17)
					@ li,40	PSAY OemToAnsi(STR0030)				// "Total Hist.  :"
					@ li,54	PSAY nTotHist Picture tm(nTotHist,17)
					li++
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Inicializa variaveis                                                  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nTotDeb     := 0
					nTotCrd     := 0
					nTotDig     := 0
					nTotRdDeb   := 0
					nTotRdCrd   := 0
					nTotDias    := 0
					nTotHist    := 0
				EndIf	
			EndIf	
		Else							// Relatorio Sintetico
			@li, 0 PSAY cLote
			@li, 6 PSAY SubStr(cPeriodo,5,2)
			SI6->(dbSeek(xFilial()+cLote+cPeriodo))
			@li,10 PSAY SI6->I6_PREDIG  Picture tm(SI6->I6_PREDIG,17)
			@li,30 PSAY nTotDeb			 Picture tm(nTotDeb,17)
			@li,50 PSAY nTotCrd			 Picture tm(nTotCrd,17)
			@li,70 PSAY nTotDig			 Picture tm(nTotDig,17)
			nTotTInf += SI6->I6_PREDIG
			nTotTDeb += nTotDeb
			nTotTCred+= nTotCrd
			nTotTDig += nTotDig
			If Mv_Par06 == 1				// Diferenca entre tot dig e tot Inf Moeda 1
				@li,90 PSAY Abs((nTotDig-SI6->I6_PREDIG))  Picture tm(Abs(nTotDig-SI6->I6_PREDIG),16)
				nTotTDif += Abs((nTotDig-SI6->I6_PREDIG))
			Endif
			@li,111 PSAY Abs((nTotDeb-nTotCrd))  Picture tm(Abs(nTotDeb-nTotCrd),17)
			If Val(Alltrim(Str(nTotDeb))) > Val(Alltrim(Str(nTotCrd)))
				@li, pcol()+1 pSay "D"
			ElseIf Val(Alltrim(Str(nTotDeb))) < Val(Alltrim(Str(nTotCrd)))
				@li, pcol()+1 pSay "C"
			EndIf
			nTotTDif1 += (nTotDeb-nTotCrd)
			li++
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inicializa variaveis                                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nTotDeb     := 0
			nTotCrd     := 0
			nTotDig     := 0
			nTotRdDeb   := 0
			nTotRdCrd   := 0
			nTotDias    := 0
			nTotHist    := 0
		EndIf
	End
End

IF mv_par07 == 2 .And. !lEnd
	ImpTot120(nTotTInf,nTotTDeb,nTotTCred,nTotTDig,nTotTDif,nTotTDif1)
Endif

roda(cbcont,cbtxt,Tamanho)

#IFNDEF WINDOWS
	Set Device To Screen
#ENDIF
dbSetOrder(1)
If aReturn[5] = 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif

dbSelectArea("SIC")
Set Filter To
RetIndex("SIC")
Ferase(cIndex+OrdBagExt())

MS_FLUSH()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o	  ³Cr120CriaSI2Autor ³ Pilar S. Albaladejo	³ Data ³ 05/11/93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Cria arquivo temporario quando se usa TOP CONNECT			   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³Cr120CriaSI2()                   						   		³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		  ³ SIGACON 												   				³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Cr120CriaSI2()

Local aCampos, cChave

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array contendo os Campos do Arquivo (Copia SI2)              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCampos := {{ "I2_FILIAL"	, "C", 02, 0 },;  // Filial
				{ "I2_LOTE"	 	, "C", 04, 0 },;  // Lote
				{ "I2_DATA"	 	, "D", 08, 0 },;  // Data
				{ "I2_DOC"  	, "C", 06, 0 },;  // Documento
				{ "I2_LINHA"	, "C", 02, 0 },;  // Linha
				{ "I2_DC"		, "C", 01, 0 },;  // Tipo Lancamento
				{ "I2_DEBITO"	, "C", 20, 0 },;  // Conta Debito
				{ "I2_CREDITO"	, "C", 20, 0 },;  // Conta Credito
				{ "I2_VALOR"	, "N", 17, 2 },;  // Valor do Lancamento
				{ "I2_VLMOED2"	, "N", 17, 2 },;  // Valor do Lancamento MOEDA 2
				{ "I2_VLMOED3"	, "N", 17, 2 },;  // Valor do Lancamento MOEDA 3
				{ "I2_VLMOED4"	, "N", 17, 2 },;  // Valor do Lancamento MOEDA 4
				{ "I2_VLMOED5"	, "N", 17, 2 },;  // Valor do Lancamento MOEDA 5
				{ "I2_HIST"		, "C", 40, 0 },;  // Historico
				{ "I2_HP"		, "C", 03, 0 },;  // Historico padrao
				{ "I2_EMPORIG"	, "C", 02, 0 },;  // Empresa Origem
				{ "I2_FILORIG"	, "C", 02, 0 },;  // Filial Origem
				{ "I2_CCC"		, "C", 09, 0 },;	// C Custo Credor
				{ "I2_CCD"		, "C", 09, 0 },;  // C Custo Devedor
				{ "I2_ITEMC"	, "C", 09, 0 },;	// Item Credor
				{ "I2_ITEMD"	, "C", 09, 0 },;  // Item Devedor
				{ "I2_PERIODO"	, "C", 06, 0 },;	// Periodo Contabil
				{ "I2_MOEDAS"	, "C", 05, 0 },;	// Moedas do lancamento
				{ "I2_DCC"		, "C", 01, 0 },;	// Digito Controle Credito
				{ "I2_DCD"		, "C", 01, 0 }}	// Digito Controle Debito

cArqTmp := CriaTrab(aCampos, .T.)

dbUseArea( .T.,, cArqTmp, "cArqTmp", .F., .F. )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Indice Temporario do Arquivo de Trabalho 1.             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqInd	:= CriaTrab(Nil, .F.)
cChave   := "I2_FILIAL+I2_LOTE+I2_EMPORIG+I2_FILORIG+DTOS(I2_DATA)+I2_DOC"

IndRegua("cArqTmp",cArqInd,cChave,,,OemToAnsi(STR0020))  //"Selecionando Registros..."

dbSelectArea("cArqTmp")
dbSetIndex(cArqInd+OrdBagExt())
dbSetOrder(1)

dbSelectArea("SI2")
SetRegua(Reccount())
dbSetOrder(3)
dbSeek(cFilial+Dtos(mv_par03),.T.)

While !Eof() .And. I2_FILIAL == cFilial .And. DTOS(I2_DATA) <= DTOS(mv_par04)

	IF I2_LOTE < mv_par01 .Or. I2_LOTE > mv_par02
		dbSkip( )
		Loop
	EndIF

	IF DTOS(I2_DATA) < DTOS(mv_par03) .Or. DTOS(I2_DATA) > DTOS(mv_par04)
		dbSkip()
		Loop
	EndIF
	
	If Substr(I2_MOEDAS,Mv_Par06,1) != "S" .and. I2_DC != "-"
		dbSkip()
		Loop
	End

	IncRegua()
	dbSelectArea("cArqTmp")
	DbAppend()
	cArqTmp->I2_FILIAL  	:= SI2->I2_FILIAL
	cArqTmp->I2_LOTE		:= SI2->I2_LOTE
	cArqTmp->I2_DATA		:= SI2->I2_DATA
	cArqTmp->I2_DOC		:= SI2->I2_DOC
	cArqTmp->I2_LINHA		:= SI2->I2_LINHA
	cArqTmp->I2_DC			:= SI2->I2_DC
	cArqTmp->I2_VALOR		:= SI2->I2_VALOR
	cArqTmp->I2_VLMOED2	:= SI2->I2_VLMOED2
	cArqTmp->I2_VLMOED3	:= SI2->I2_VLMOED3
	cArqTmp->I2_VLMOED4	:= SI2->I2_VLMOED4
	cArqTmp->I2_VLMOED5	:= SI2->I2_VLMOED5
	cArqTmp->I2_DEBITO	:= SI2->I2_DEBITO
	cArqTmp->I2_CREDITO	:= SI2->I2_CREDITO
	cArqTmp->I2_HIST		:= SI2->I2_HIST
	cArqTmp->I2_HP			:= SI2->I2_HP
	cArqTmp->I2_CCC		:= SI2->I2_CCC
	cArqTmp->I2_CCD		:= SI2->I2_CCD
	cArqTmp->I2_ITEMC		:= SI2->I2_ITEMC
	cArqTmp->I2_ITEMD		:= SI2->I2_ITEMD	
	cArqTmp->I2_PERIODO	:= SI2->I2_PERIODO
	cArqTmp->I2_MOEDAS	:= SI2->I2_MOEDAS
	cArqTmp->I2_DCC		:= SI2->I2_DCC
	cArqTmp->I2_DCD		:= SI2->I2_DCD
	dbSelectArea("SI2")
	dbSkip()
End
dbSelectArea("cArqTmp")
dbGotop()
Return 
