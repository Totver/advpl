#INCLUDE "RWMAKE.CH" 
#INCLUDE "MSOLE.CH"
#INCLUDE "GPEWORD.CH"
/*
зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©
ЁPrograma  Ё GpeWord  Ё Autor ЁMarinaldo de Jesus     Ё Data Ё05/07/2000Ё
цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢
ЁDescri┤└o Ё Impressao de Documentos tipo Word                          Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁSintaxe   Ё Chamada padr└o para programas em RdMake.                   Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁUso       Ё Generico                                                   Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
ЁObs.:     Ё                                                            Ё
цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё         ATUALIZACOES SOFRIDAS DESDE A CONSTRU─AO INICIAL.             Ё
цддддддддддддбддддддддддбддддддбдддддддддддддддддддддддддддддддддддддддд╢
ЁProgramador ЁData      Ё BOPS ЁMotivo da Alteracao                     Ё
цддддддддддддеддддддддддеддддддедддддддддддддддддддддддддддддддддддддддд╢
Ё            ЁDD/MM/AAAAЁ      Ё                                        Ё 
юддддддддддддаддддддддддаддддддадддддддддддддддддддддддддддддддддддддддды*/
User Function GpeWord()

Local	oDlg	:= NIL
Private	cPerg	:= "GPWORD"
Private aInfo	:= {}

@ 096,042 TO 323,505 DIALOG oDlg TITLE OemToAnsi(STR0001)												
@ 008,010 TO 084,222
@ 018,020 SAY OemToAnsi(STR0002)						 												
@ 030,020 SAY OemToAnsi(STR0003)																		
@ 095,042 BMPBUTTON TYPE 5 					   ACTION Eval( { || fPerg_Word() , Pergunte(cPerg,.T.) } )	
@ 095,072 BUTTON OemToAnsi(STR0004) SIZE 55,13 ACTION Eval( { || fPerg_Word() , fVarW_Imp() } )         
@ 095,130 BUTTON OemToAnsi(STR0005) SIZE 55,13 ACTION Eval( { || fPerg_Word() , Pergunte(cPerg,.F.) , fWord_Imp() } )
@ 095,187 BMPBUTTON TYPE 2 ACTION Close(oDlg)
ACTIVATE DIALOG oDlg CENTERED

Return( NIL )

/*
зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©
ЁFun┤└o    ЁfWord_Imp Ё Autor ЁMarinaldo de Jesus     Ё Data Ё05/07/2000Ё
цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢
ЁDescri┤└o ЁImpressao do Documento Word                                 Ё
юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Static Function fWord_Imp()

/*
зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
ЁCarregando mv_par para Variaveis Locais do Programa                    Ё
юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Local cFilDe		:= mv_par01
Local cFilAte		:= mv_par02
Local cCcDe			:= mv_par03
Local cCcAte		:= mv_par04
Local cMatDe		:= mv_par05
Local cMatAte		:= mv_par06
Local cNomeDe		:= mv_par07
Local cNomeAte		:= mv_par08
Local cTnoDe		:= mv_par09
Local cTnoAte		:= mv_par10
Local cFunDe		:= mv_par11
Local cFunAte		:= mv_par12
Local cSindDe		:= mv_par13
Local cSindAte		:= mv_par14
Local dAdmiDe		:= mv_par15
Local dAdmiAte		:= mv_par16
Local cSituacao		:= mv_par17
Local cCategoria	:= mv_par18
Local nCopias		:= mv_par23
Local nOrdem		:= mv_par24
Local cArqWord		:= mv_par25

/*
зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
ЁDefinindo Variaveis Locais                                             Ё
юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Local oWord			:= NIL
Local cExclui		:= ""
Local cFilAnt   	:= ""
Local aCampos		:= {}
Local nX			:= 0
Local nSvOrdem		:= 0
Local nSvRecno		:= 0

/*
зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
ЁBloco que definira a Consistencia da Parametrizacao dos Intervalos seleЁ
Ёcionados nas Perguntas De? Ate?.                                       Ё
юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
cExclui := cExclui + "{ || "
cExclui := cExclui + "(RA_FILIAL  < cFilDe     .or. RA_FILIAL  > cFilAte    ).or."
cExclui := cExclui + "(RA_MAT     < cMatDe     .or. RA_MAT     > cMatAte    ).or." 
cExclui := cExclui + "(RA_CC      < cCcDe      .or. RA_CC      > cCCAte     ).or." 
cExclui := cExclui + "(RA_NOME    < cNomeDe    .or. RA_NOME    > cNomeAte   ).or." 
cExclui := cExclui + "(RA_TNOTRAB < cTnoDe     .or. RA_TNOTRAB > cTnoAte    ).or." 
cExclui := cExclui + "(RA_CODFUNC < cFunDe     .or. RA_TNOTRAB > cFunAte    ).or." 
cExclui := cExclui + "(RA_SINDICA < cSindDe    .or. RA_SINDICA > cSindAte   ).or." 
cExclui := cExclui + "(RA_ADMISSA < dAdmiDe    .or. RA_ADMISSA > dAdmiAte   ).or." 
cExclui := cExclui + "!(RA_SITFOLH$cSituacao).or.!(RA_CATFUNC$cCategoria)"
cExclui := cExclui + " } "

/*
зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
ЁInicializa o Ole com o MS-Word 97 ( 8.0 )						        Ё
юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
oWord	:= OLE_CreateLink('TMsOleWord97') ; OLE_NewFile( oWord , cArqWord )

dbSelectArea("SRA")
nSvOrdem := IndexOrd() ; nSvRecno := Recno()
dbGotop()

/*
здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
Ё Posicionando no Primeiro Registro do Parametro               Ё
юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
IF nOrdem == 1	   							//Matricula
	dbSetOrder(nOrdem)
	dbSeek( cFilDe + cMatDe , .T. )
	cInicio := '{ || RA_FILIAL + RA_MAT }'
	cFim    := cFilAte + cMatAte
ElseIF nOrdem == 2							//Centro de Custo
	dbSetOrder(nOrdem)
	dbSeek( cFilDe + cCcDe + cMatDe , .T. )
	cInicio  := '{ || RA_FILIAL + RA_CC + RA_MAT }'
	cFim     := cFilAte + cCcAte + cMatAte
ElseIF nOrdem == 3							//Nome 
	dbSetOrder(nOrdem)
	dbSeek( cFilDe + cNomeDe + cMatDe , .T. )
	cInicio := '{ || RA_FILIAL + RA_NOME + RA_MAT }'
	cFim    := cFilAte + cNomeAte + cMatAte
ElseIF nOrdem == 4							//Turno 
	dbSetOrder(nOrdem)
	dbSeek( cFilDe + cTnoDe ,.T. )
	cInicio  := '{ || RA_FILIAL + RA_TNOTRAB } '
	cFim     := cFilAte + cCcAte + cNomeAte
EndIF

cFilialAnt := Space(02)
/*
здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
Ё Ira Executar Enquanto Estiver dentro do Escopo dos ParametrosЁ
юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
While SRA->( !Eof() .and. Eval( &(cInicio) ) <= cFim )
	
		/*
	    здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	    Ё Consiste Parametrizacao do Intervalo de Impressao            Ё
	    юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/ 
	    IF SRA->( Eval ( &(cExclui) ) )
	       dbSelectArea("SRA")
	       dbSkip()
	       Loop
	    EndIF

		/*
        здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
        Ё Carregando Informacoes da Empresa                            Ё
        юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/ 
		IF SRA->RA_FILIAL # cFilialAnt
			IF !fInfo(@aInfo,SRA->RA_FILIAL)
		  		/*
        		здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		        Ё Encerra o Loop se Nao Carregar Informacoes da Empresa        Ё
        		юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/ 
				Exit
			EndIF			
	  		/*
       		здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	        Ё Atualiza a Variavel cFilialAnt                               Ё
       		юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/ 
			dbSelectArea("SRA")
			cFilialAnt := SRA->RA_FILIAL
		EndIF	
        
		/*
   		здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
        Ё Carrega Campos Disponiveis para Edicao                       Ё
   		юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/ 
		aCampos := fCpos_Word()
   
	  /*
   		здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
        Ё Ajustando as Variaveis do Documento                          Ё
   		юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/ 
		Aeval(	aCampos																								,; 
				{ |x| OLE_SetDocumentVar( oWord, x[1]  																,;
											IF( Subst( AllTrim( x[3] ) , 4 , 2 )  == "->"          					,; 
												Transform( x[2] , PesqPict( Subst( AllTrim( x[3] ) , 1 , 3 )		,;
																			Subst( AllTrim( x[3] )  				,;
										        			         			  - ( Len( AllTrim( x[3] ) ) - 5 )	 ;	
										          								 )	  	 							 ; 
																	      )                                          ;
												         )															,; 
												Transform( x[2] , x[3] )                                     		 ;
				  	 						  ) 														 	 		 ; 
										)																			 ;
				}     																 							 	 ;
			 )
        
		/*
   		здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
        Ё Atualiza as Variaveis                                        Ё
   		юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/ 
        OLE_UpDateFields( oWord )
	
		/*
		зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		ЁImprimindo o Documento                                                 Ё
		юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
        For nX := 1 To nCopias
            OLE_SetProperty( oWord, '208', .F. ) ; OLE_PrintFile( oWord )
        Next nX
        dbSelectArea("SRA")
        dbSkip()
Enddo	
/*
зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
ЁEncerrando o Link com o Documento                                      Ё
юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
OLE_CloseLink( oWord )
 
/*
зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
ЁRestaurando dados de Entrada                                           Ё
юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
dbSelectArea('SRA')
dbSetOrder( nSvOrdem )
dbGoTo( nSvRecno )

Return( NIL )

/*
зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©
ЁFun┤фo    ЁfOpen_WordЁ Autor Ё Marinaldo de Jesus    Ё Data Ё06/05/2000Ё
цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢
ЁDescri┤фo ЁSelecionaro os Arquivos do Word.                            Ё
юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Static Function fOpen_Word()

Local cSvAlias		:= Alias()
Local lAchou		:= .F.
Local cTipo			:= STR0006														
Local cNewPathArq	:= cGetFile( cTipo , STR0007 )									

IF !Empty( cNewPathArq )
	IF Upper( Subst( AllTrim( cNewPathArq), - 3 ) ) == Upper( AllTrim( STR0008 ) )	
		Aviso( STR0009 , cNewPathArq , { STR0010 } )								
    Else
    	MsgAlert( STR0011 )															
    	Return
    EndIF
Else
    Aviso(STR0012 ,{ STR0010 } )													
    Return
EndIF

/*
зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
ЁLimpa o parametro para a Carga do Novo Arquivo                         Ё
юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
dbSelectArea("SX1")
IF lAchou := ( SX1->( dbSeek( cPerg + "25" , .T. ) ) )
	RecLock("SX1",.F.,.T.)
	SX1->X1_CNT01 := Space( Len( SX1->X1_CNT01 ) )
	mv_par25 := cNewPathArq
	MsUnLock()
EndIF	
dbSelectArea( cSvAlias )

Return( .T. )

/*
зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©
ЁFun┤└o    ЁfCpos_WordЁ Autor ЁMarinaldo de Jesus     Ё Data Ё06/07/2000Ё
цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢
ЁDescri┤└o ЁRetorna Array com as Variaveis Disponiveis para Impressao   Ё
цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
Ё          ЁaExp[x,1] - Variavel Para utilizacao no Word (Tam Max. 30)  Ё
Ё          ЁaExp[x,2] - Conteudo do Campo                (Tam Max. 49)  Ё
Ё          ЁaExp[x,3] - Campo para Pesquisa da Picture no X3 ou Picture Ё
Ё          ЁaExp[x,4] - Descricao da Variaval                           Ё
юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Static Function fCpos_Word()

Local aExp			:= {}
Local cTexto_01		:= AllTrim( mv_par19 )
Local cTexto_02		:= AllTrim( mv_par20 )
Local cTexto_03		:= AllTrim( mv_par21 )
Local cTexto_04		:= AllTrim( mv_par22 )
                                                                                       	         
aAdd( aExp, {'GPE_FILIAL'				,	SRA->RA_FILIAL 											, "SRA->RA_FILIAL"			,	STR0013	} ) 
aAdd( aExp, {'GPE_MATRICULA'			,	SRA->RA_MAT												, "SRA->RA_MAT"				,	STR0014	} ) 
aAdd( aExp, {'GPE_CENTRO_CUSTO'			,	SRA->RA_CC												, "SRA->RA_CC"				,	STR0015	} ) 
aAdd( aExp, {'GPE_DESC_CCUSTO'			,	fDesc("SI3",SRA->RA_CC,"I3_DESC")		 				, "@!"						,	STR0016	} ) 
aAdd( aExp, {'GPE_NOME'		   			,	SRA->RA_NOME											, "SRA->RA_NOME"			,	STR0017	} ) 
aAdd( aExp, {'GPE_CPF'		   			,	SRA->RA_CIC												, "SRA->RA_CIC"				,	STR0018	} ) 
aAdd( aExp, {'GPE_PIS'		   			,	SRA->RA_PIS												, "SRA->RA_PIS"				,	STR0019	} ) 
aAdd( aExp, {'GPE_RG'		   			,	SRA->RA_RG												, "SRA->RA_RG"				,	STR0020	} ) 
aAdd( aExp, {'GPE_CTPS'					,	SRA->RA_NUMCP							 				, "SRA->RA_NUMCP"			,	STR0021	} ) 
aAdd( aExp, {'GPE_SERIE_CTPS'			,	SRA->RA_SERCP							 				, "SRA->RA_SERCP"			,	STR0022	} ) 
aAdd( aExp, {'GPE_UF_CTPS'				,	SRA->RA_UFCP							 				, "SRA->RA_UFCP"			,	STR0023	} ) 
aAdd( aExp, {'GPE_CNH'   	  			,	SRA->RA_HABILIT							 				, "SRA->RA_HABILIT"			,	STR0024	} ) 
aAdd( aExp, {'GPE_RESERVISTA'			,	SRA->RA_RESERVI							 				, "SRA->RA_RESERVI"			,	STR0025	} ) 
aAdd( aExp, {'GPE_TIT_ELEITOR' 			,	SRA->RA_TITULOE							 				, "SRA->RA_TITULOE"			,	STR0026	} ) 
aAdd( aExp, {'GPE_ZONA_SECAO'  			,	SRA->RA_ZONASEC							 				, "SRA->RA_ZONASEC"			,	STR0027	} ) 
aAdd( aExp, {'GPE_ENDERECO'				,	SRA->RA_ENDEREC							 				, "SRA->RA_ENDEREC"			,	STR0028 } ) 
aAdd( aExp, {'GPE_COMP_ENDER'			,	SRA->RA_COMPLEM							 				, "SRA->RA_COMPLEM"			,	STR0029	} )	
aAdd( aExp, {'GPE_BAIRRO'				,	SRA->RA_BAIRRO							 				, "SRA->RA_BAIRRO"			,	STR0030	} ) 
aAdd( aExp, {'GPE_MUNICIPIO'			,	SRA->RA_MUNICIP							 				, "SRA->RA_MUNICIP"			,	STR0031	} )	
aAdd( aExp, {'GPE_ESTADO'				,	SRA->RA_ESTADO											, "SRA->RA_ESTADO"			,	STR0032	} )	
aAdd( aExp, {'GPE_DESC_ESTADO'			,	fDesc("SX5","12"+SRA->RA_ESTADO,"X5_DESCRI")			, "@!"						,	STR0033	} ) 
aAdd( aExp, {'GPE_CEP'		   			,	SRA->RA_CEP												, "SRA->RA_CEP"				,	STR0034	} ) 
aAdd( aExp, {'GPE_TELEFONE'	   			,	SRA->RA_TELEFON											, "SRA->RA_TELEFON"			,	STR0035	} ) 
aAdd( aExp, {'GPE_NOME_PAI'	   			,	SRA->RA_PAI												, "SRA->RA_PAI"				,	STR0036	} ) 
aAdd( aExp, {'GPE_NOME_MAE'	   			,	SRA->RA_MAE												, "SRA->RA_MAE"				,	STR0037	} ) 
aAdd( aExp, {'GPE_COD_SEXO'	   			,	SRA->RA_SEXO											, "SRA->RA_SEXO"			,	STR0038	} ) 
aAdd( aExp, {'GPE_DESC_SEXO'   			,	SRA->(IF(RA_SEXO ="M","Masculino","Feminino"))			, "@!"						,	STR0039	} ) 
aAdd( aExp, {'GPE_EST_CIVIL'  			,	SRA->RA_ESTCIVI											, "SRA->RA_ESTCIVI"			,	STR0040	} ) 
aAdd( aExp, {'GPE_COD_NATURALDADE'		,	SRA->RA_NATURAL											, "SRA->RA_NATURAL"			,	STR0041	} ) 
aAdd( aExp, {'GPE_DESC_NATURALIDADE'	,	fDesc("SX5","12"+SRA->RA_NATURAL,"X5_DESCRI")			, "@!"						,	STR0042	} ) 
aAdd( aExp, {'GPE_COD_NACIONALIDADE'	,	SRA->RA_NACIONA											, "SRA->RA_NACIONA"			,	STR0043	} ) 
aAdd( aExp, {'GPE_DESC_NACIONALIDADE'	,	fDesc("SX5","34"+SRA->RA_NACIONA,"X5_DESCRI")			, "@!"						,	STR0044	} ) 
aAdd( aExp, {'GPE_ANO_CHEGADA' 			,	SRA->RA_ANOCHEG											, "SRA->RA_ANOCHEG"			,	STR0045	} )
aAdd( aExp, {'GPE_DEP_IR'   			,	SRA->RA_DEPIR										 	, "SRA->RA_DEPIR"			,	STR0046	} )	
aAdd( aExp, {'GPE_DEP_SAL_FAM'			,	SRA->RA_DEPSF											, "SRA->RA_DEPSF"			,	STR0047 } )
aAdd( aExp, {'GPE_DATA_NASC'  			,	SRA->RA_NASC											, "SRA->RA_NASC"			,	STR0048	} )
aAdd( aExp, {'GPE_DATA_ADMISSAO'		,	SRA->RA_ADMISSA											, "SRA->RA_ADMISSA"			,	STR0049	} )
aAdd( aExp, {'GPE_DIA_ADMISSAO' 		,	StrZero( Day( SRA->RA_ADMISSA ) , 2 )					, "@!"						,	STR0050	} )
aAdd( aExp, {'GPE_MES_ADMISSAO'			,	StrZero( Month( SRA->RA_ADMISSA ) , 2 )					, "@!"						,	STR0051 } )
aAdd( aExp, {'GPE_ANO_ADMISSAO'			,	StrZero( Year( SRA->RA_ADMISSA ) , 4 )					, "@!"						,	STR0052	} )
aAdd( aExp, {'GPE_DT_OP_FGTS'  			,	SRA->RA_OPCAO											, "SRA->RA_OPCAO"			,	STR0053	} )
aAdd( aExp, {'GPE_DATA_DEMISSAO'		,	SRA->RA_DEMISSA											, "SRA->RA_DEMISSA"			,	STR0054	} ) 
aAdd( aExp, {'GPE_DATA_EXPERIENCIA'		,	SRA->RA_VCTOEXP											, "SRA->RA_VCTOEXP"			,	STR0055	} )
aAdd( aExp, {'GPE_DIA_EXPERIENCIA' 		,	StrZero( Day( SRA->RA_VCTOEXP ) , 2 )					, "@!"						,	STR0056	} )
aAdd( aExp, {'GPE_MES_EXPERIENCIA'		,	StrZero( Month( SRA->RA_VCTOEXP ) , 2 )					, "@!"						,	STR0057	} )
aAdd( aExp, {'GPE_ANO_EXPERIENCIA'		,	StrZero( Year( SRA->RA_VCTOEXP ) , 4 ) 					, "@!"						,	STR0058	} )
aAdd( aExp, {'GPE_DIAS_EXPERIENCIA'		,	StrZero(SRA->(RA_VCTOEXP-RA_ADMISSA)+1,03)				, "@!"						,	STR0059	} )
aAdd( aExp, {'GPE_DATA_EX_MEDIC'		,	SRA->RA_EXAMEDI											, "SRA->RA_EXAMEDI"			,	STR0060	} )
aAdd( aExp, {'GPE_BCO_AG_DEP_SAL'		, 	SRA->RA_BCDEPSA											, "SRA->RA_BCDEPSA"			,	STR0061	} )
aAdd( aExp, {'GPE_DESC_BCO_SAL'			, 	fDesc("SA6",SRA->RA_BCDEPSA,"A6_NOME")					, "@!"						,	STR0062	} )
aAdd( aExp, {'GPE_DESC_AGE_SAL'			, 	fDesc("SA6",SRA->RA_BCDEPSA,"A6_NOMEAGE")				, "@!"						,	STR0063	} )
aAdd( aExp, {'GPE_CTA_DEP_SAL'			,	SRA->RA_CTDEPSA											, "SRA->RA_CTDEPSA"			,	STR0064	} )
aAdd( aExp, {'GPE_BCO_AG_FGTS'			,	SRA->RA_BCDPFGT											, "SRA->RA_BCDPFGT"			,	STR0065	} )
aAdd( aExp, {'GPE_DESC_BCO_FGTS'		, 	fDesc("SA6",SRA->RA_BCDPFGT,"A6_NOME")					, "@!"						,	STR0066	} )
aAdd( aExp, {'GPE_DESC_AGE_FGTS'		, 	fDesc("SA6",SRA->RA_BCDPFGT,"A6_NOMEAGE")				, "@!"						,	STR0067	} )
aAdd( aExp, {'GPE_CTA_Dep_FGTS'			,	SRA->RA_CTDPFGT											, "SRA->RA_CTDPFGT"			,	STR0068	} )
aAdd( aExp, {'GPE_SIT_FOLHA'	  		,	SRA->RA_SITFOLH											, "SRA->RA_SITFOLH"			,	STR0069	} )
aAdd( aExp, {'GPE_DESC_SIT_FOLHA'  		,	fDesc("SX5","30"+SRA->RA_SITFOLH,"X5_DESCRI")			, "@!"						,	STR0070	} )
aAdd( aExp, {'GPE_HRS_MENSAIS'			,	SRA->RA_HRSMES											, "SRA->RA_HRSMES"			,	STR0071	} )
aAdd( aExp, {'GPE_HRS_SEMANAIS'			,	SRA->RA_HRSEMAN											, "SRA->RA_HRSEMAN"			,	STR0072	} )
aAdd( aExp, {'GPE_CHAPA'		  		,	SRA->RA_CHAPA											, "SRA->RA_CHAPA"			,	STR0073	} )
aAdd( aExp, {'GPE_TURNO_TRAB'	 		,	SRA->RA_TNOTRAB											, "SRA->RA_TNOTRAB"			,	STR0074	} )
aAdd( aExp, {'GPE_DESC_TURNO'	  		,	fDesc('SR6',SRA->RA_TNOTRAB,'R6_DESC')					, "@!"						,	STR0075	} )
aAdd( aExp, {'GPE_COD_FUNCAO'	 		,	SRA->RA_CODFUNC											, "SRA->RA_CODFUNC"			,	STR0076 } )
aAdd( aExp, {'GPE_DESC_FUNCAO'			,	fDesc('SRJ',SRA->RA_CODfUNC,'RJ_DESC')					, "@!"						,	STR0077	} )
aAdd( aExp, {'GPE_CBO'			   		,	SRA->RA_CBO												, "SRA->RA_CBO"				,	STR0078	} )
aAdd( aExp, {'GPE_CONT_SINDIC'			,	SRA->RA_PGCTSIN											, "SRA->RA_PGCTSIN"			,	STR0079	} )
aAdd( aExp, {'GPE_COD_SINDICATO'		,	SRA->RA_SINDICA											, "SRA->RA_SINDICA"			,	STR0080	} )
aAdd( aExp, {'GPE_DESC_SINDICATPO'		,	fDesc("SRX","0400"+SRA->RA_SINDICA,"RX_TXT")			, "@!"						,	STR0081	} )
aAdd( aExp, {'GPE_COD_ASS_MEDICA'		,	SRA->RA_ASMEDIC											, "SRA->RA_ASMEDIC"			,	STR0082	} )
aAdd( aExp, {'GPE_DEP_ASS_MEDICA'		,	SRA->RA_DPASSME											, "SRA->RA_DPASSME"			,	STR0083	} )
aAdd( aExp, {'GPE_ADIC_TEMP_SERVIC'		,	SRA->RA_ADTPOSE											, "SRA->RA_ADTPOSE"			,	STR0084	} )
aAdd( aExp, {'GPE_COD_CESTA_BASICA'		,	SRA->RA_CESTAB											, "SRA->RA_CESTAB"			,	STR0085 } )
aAdd( aExp, {'GPE_COD_VALE_REF' 		,	SRA->RA_VALEREF											, "SRA->RA_VALEREF"			,	STR0086	} )
aAdd( aExp, {'GPE_COD_SEG_VIDA' 		,	SRA->RA_SEGUROV											, "SRA->RA_SEGUROV"			,	STR0087	} )
aAdd( aExp, {'GPE_%PENS_ALIMENT'		,	SRA->RA_PENSALI											, "SRA->RA_PENSALI"			,	STR0088	} )
aAdd( aExp, {'GPE_%ADIANTAM'	 		,	SRA->RA_PERCADT											, "SRA->RA_PERCADT"			,	STR0089	} )
aAdd( aExp, {'GPE_CATEG_FUNC'	  		,	SRA->RA_CATFUNC											, "SRA->RA_CATFUNC"			,	STR0090	} )
aAdd( aExp, {'GPE_DESC_CATEG_FUNC'		,	fDesc("SX5","28"+SRA->RA_CATFUNC,"X5_DESCRI")			, "@!"						,	STR0091	} )
aAdd( aExp, {'GPE_POR_MES_HORA'			,	SRA->(IF(RA_CATFUNC$"H","P/Hora","P/Mes")) 				, "@!"						,	STR0092	} )
aAdd( aExp, {'GPE_TIPO_PAGTO'  			,	SRA->RA_TIPOPGT								 			, "SRA->RA_TIPOPGT"			,	STR0093	} )
aAdd( aExp, {'GPE_DESC_TIPO_PAGTO'  	,	fDesc("SX5","40"+SRA->RA_TIPOPGT,"X5_DESCRI")			, "@!"						,	STR0094	} )
aAdd( aExp, {'GPE_SALARIO'		   		,	SRA->RA_SALARIO											, "SRA->RA_SALARIO"			,	STR0095	} )
aAdd( aExp, {'GPE_SAL_BAS_DISS'			,	SRA->RA_ANTEAUM											, "SRA->RA_ANTEAUM"			,	STR0096	} )
aAdd( aExp, {'GPE_B_INSS_OUT'			,	SRA->RA_BASEINS											, "SRA->RA_BASEINS"			,	STR0097 } )
aAdd( aExp, {'GPE_INSS_OUTRAS'	 		,	SRA->RA_INSSOUT											, "SRA->RA_INSSOUT"			,	STR0098	} )
aAdd( aExp, {'GPE_HRS_PERICULO'  		,	SRA->RA_PERICUL											, "SRA->RA_PERICUL"			,	STR0099	} )
aAdd( aExp, {'GPE_HRS_INS_MINIMA'		,	SRA->RA_INSMIN											, "SRA->RA_INSMIN"			,	STR0100	} )
aAdd( aExp, {'GPE_HRS_INS_MEDIA'		,	SRA->RA_INSMED											, "@!"						,	STR0101	} )
aAdd( aExp, {'GPE_HRS_INS_MINIMA'		,	SRA->RA_INSMAX											, "SRA->RA_INSMAX"			,	STR0102	} )
aAdd( aExp, {'GPE_TIPO_ADMISSAO'		,	SRA->RA_TIPOADM											, "SRA->RA_TIPOADM"			,	STR0103	} )
aAdd( aExp, {'GPE_DESC_TP_ADMISSAO'		,	fDesc("SX5","38"+SRA->RA_TIPOADM,"X5_DESCRI")			, "@!"						,	STR0104	} )
aAdd( aExp, {'GPE_COD_AFA_FGTS'			,	SRA->RA_AFASFGT											, "SRA->RA_AFASFGT"			,	STR0105	} )
aAdd( aExp, {'GPE_DESC_AFA_FGTS'		,	fDesc("SX5","30"+SRA->RA_AFASFGT,"X5_DESCRI")			, "@!"						,	STR0106	} )
aAdd( aExp, {'GPE_VIN_EMP_RAIS'			,	SRA->RA_VIEMRAI											, "SRA->RA_VIEMRAI"			,	STR0107	} )
aAdd( aExp, {'GPE_DESC_VIN_EMP_RAIS'	,	fDesc("SX5","25"+RA_VIEMRAI,"X5_DESCRI")				, "@!"						,	STR0108	} )
aAdd( aExp, {'GPE_COD_INST_RAIS'		,	SRA->RA_GRINRAI											, "SRA->RA_GRINRAI"			,	STR0109	} )
aAdd( aExp, {'GPE_DESC_GRAU_INST'		,	fDesc("SX5","26"+SRA->RA_GRINRAI,"X5_DESCRI")			, "@!"						,	STR0110	} )
aAdd( aExp, {'GPE_COD_RESC_RAIS'		,	SRA->RA_RESCRAI											, "SRA->RA_RESCRAI"			,	STR0111	} )
aAdd( aExp, {'GPE_CRACHA'		  		,	SRA->RA_CRACHA											, "SRA->RA_CRACHA"			,	STR0112	} )
aAdd( aExp, {'GPE_REGRA_APONTA'			,	SRA->RA_REGRA											, "SRA->RA_REGRA"			,	STR0113	} )
aAdd( aExp, {'GPE_FOTO'			   		,	SRA->RA_BITMAP											, "SRA->RA_BITMAP"			,	STR0114	} )
aAdd( aExp, {'GPE_NO_REGISTRO'	 		,	SRA->RA_REGISTR											, "SRA->RA_REGISTR"			,	STR0115	} )
aAdd( aExp, {'GPE_NO_FICHA'	    		,	SRA->RA_FICHA											, "SRA->RA_FICHA"			,	STR0116	} )
aAdd( aExp, {'GPE_TP_CONT_TRAB'			,	SRA->RA_TPCONTR											, "SRA->RA_TPCONTR"			,	STR0117	} )
aAdd( aExp, {'GPE_DESC_TP_CONT_TRAB'	,	SRA->(IF(RA_TPCONTR="1","Indeterminado","Determinado"))	, "@!"						,	STR0118	} )
aAdd( aExp, {'GPE_APELIDO'		   		,	SRA->RA_APELIDO											, "SRA->RA_APELIDO"			,	STR0119	} )
aAdd( aExp, {'GPE_E-MAIL'		 		,	SRA->RA_EMAIL											, "SRA->RA_EMAIL"			,	STR0120	} )
aAdd( aExp, {'GPE_TEXTO_01'				,	cTexto_01								   				, "@!"						,	STR0121	} ) 
aAdd( aExp, {'GPE_TEXTO_02'				,	cTexto_02												, "@!"						,	STR0122	} )
aAdd( aExp, {'GPE_TEXTO_03'				,	cTexto_03												, "@!"						,	STR0123	} )
aAdd( aExp, {'GPE_TEXTO_04'				,	cTexto_04												, "@!"						,	STR0124	} )
aAdd( aExp, {'GPE_EXTENSO_SAL'			,	Extenso( SRA->RA_SALARIO , .F. , 1 )					, "@!"						,	STR0125 } )
aAdd( aExp, {'GPE_DDATABASE'			,	dDataBase                    	        				, "" 						,	STR0126	} )
aAdd( aExp, {'GPE_DIA_DDATABASE'		,	StrZero( Day( dDataBase ) , 2 )            				, "@!"						,	STR0127	} )
aAdd( aExp, {'GPE_MES_DDATABASE'		,	StrZero( Month( dDataBase ) , 2 )            			, "@!"						,	STR0128	} )
aAdd( aExp, {'GPE_ANO_DDATABASE'		,	StrZero( Year( dDataBase ) , 4 )            			, "@!"						,	STR0129	} )
aAdd( aExp, {'GPE_NOME_EMPRESA' 		,	aInfo[03]                              					, "@!"						,	STR0130	} )
aAdd( aExp, {'GPE_END_EMPRESA'			,	aInfo[04]                              					, "@!"						,	STR0131	} )
aAdd( aExp, {'GPE_CID_EMPRESA'			,	aInfo[05]                              					, "@!"						,	STR0132	} )
aAdd( aExp, {'GPE_CEP_EMPRESA'	 		,	aInfo[06]                              					, "@!" 						,	STR0133	} )
aAdd( aExp, {'GPE_CGC_EMPRESA' 			,	aInfo[08]             									, "@R ##.###.###/###-##"	,	STR0134	} )
aAdd( aExp, {'GPE_INSC_EMPRESA' 		,	aInfo[09]                              					, "@!" 						,	STR0135	} )
aAdd( aExp, {'GPE_TEL_EMPRESA'	 		,	aInfo[10]                              					, "@!" 						,	STR0136	} )
aAdd( aExp, {'GPE_BAI_EMPRESA'			,	aInfo[13]                              					, "@!" 						,	STR0137	} )
aAdd( aExp, {'GPE_DESC_RESC_RAIS'		,	fDesc("SX5","31"+SRA->RA_RESCRAI,"X5_DESCRI")			, "@!" 						,	STR0138	} )
aAdd( aExp, {'GPE_DIA_DEMISSAO'			,	StrZero( Day( SRA->RA_DEMISSA ) , 2 )					, "@!" 						,	STR0139	} )
aAdd( aExp, {'GPE_MES_DEMISSAO'			,	StrZero( Month( SRA->RA_DEMISSA ) , 2 )					, "@!" 						,	STR0140	} )
aAdd( aExp, {'GPE_ANO_DEMISSAO'			,	StrZero( Year( SRA->RA_DEMISSA ) , 4 )					, "@!" 						,	STR0141	} )
                                                                                                       
Return( aExp )

/*
зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©
ЁFun┤фo    ЁfVarW_Imp Ё Autor Ё Marinaldo de Jesus    Ё Data Ё07/05/2000Ё
цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢
ЁDescri┤фo ЁImpressao das Variaveis disponiveis para uso                Ё
юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Static Function fVarW_Imp()

/*
здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
Ё Define Variaveis Locais                                      Ё
юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Local cString	:= 'SRA'                                	     
Local aOrd		:= {STR0142,STR0143}
Local cDesc1	:= STR0144
Local cDesc2	:= STR0145                     
Local cDesc3	:= STR0146                                
Local Tamanho	:= "P"

/*
здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
Ё Define Variaveis Privates Basicas                            Ё
юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Private nomeprog	:= 'GPEWORD'
Private AT_PRG		:= nomeProg
Private aReturn		:= {STR0147, 1,STR0148, 2, 2, 1, '',1 }
Private wCabec0		:= 1
Private wCabec1		:= STR0149
Private wCabec2		:= ""
Private wCabec3		:= ""
Private nTamanho	:= "P"
Private lEnd		:= .F.
Private Titulo		:= cDesc1
Private Li			:= 0
Private ContFl		:= 1
Private cBtxt		:= ""
Private aLinha		:= {}
Private nLastKey	:= 0

/*
здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
Ё Envia controle para a funcao SETPRINT                        Ё
юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
WnRel := "WORD_VAR" 
WnRel := SetPrint(cString,Wnrel,"",Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho,,.F.)

IF nLastKey == 27
	Return( NIL )
EndIF

SetDefault(aReturn,cString)

IF nLastKey == 27
	Return( NIL )
EndIF

/*
здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
Ё Chamada do Relatorio.                                        Ё
юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
RptStatus( { |lEnd| fImpVar() } , Titulo )

Return( NIL )

/*
зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©
ЁFun┤фo    ЁfImpVar   Ё Autor Ё Marinaldo de Jesus    Ё Data Ё07/05/2000Ё
цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢
ЁDescri┤фo ЁImpressao das Variaveis disponiveis para uso                Ё
юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Static Function fImpVar()

Local nOrdem	:= aReturn[8]
Local aCampos	:= {}
Local nX		:= 0
Local cDetalhe	:= ""

/*
здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
Ё Carregando Informacoes da Empresa                            Ё
юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/ 
IF !fInfo(@aInfo,SRA->RA_FILIAL)
	Return( NIL )
EndIF			

/*
здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
Ё Carregando Variaveis                                         Ё
юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/ 
aCampos := fCpos_Word()

/*
здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
Ё Ordena aCampos de Acordo com a Ordem Selecionada             Ё
юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/        
IF nOrdem = 1
	aSort( aCampos , , , { |x,y| x[1] < y[1] } )
Else
	aSort( aCampos , , , { |x,y| x[4] < y[4] } )
EndIF

/*
здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
Ё Carrega Regua de Processamento                               Ё
юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/        
SetRegua( Len( aCampos ) )

/*
здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
Ё Impressao do Relatorio                                       Ё
юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/        
For nX := 1 To Len( aCampos )

        /*
        здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
        Ё Movimenta Regua Processamento                                Ё
        юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/        
        IncRegua()  

        /*
        здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
        Ё Cancela Impresфo                                             Ё
        юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
        IF lEnd
           @ Prow()+1,0 PSAY cCancel
           Exit
        EndIF            

		/*
        здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
        Ё Mascara do Relatorio                                         Ё
        юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
        //        10        20        30        40        50        60        70        80
        //12345678901234567890123456789012345678901234567890123456789012345678901234567890
		//Variaveis                      Descricao
		//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

		/*
        здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
        Ё Carregando Variavel de Impressao                             Ё
        юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
		cDetalhe := IF( Len( AllTrim( aCampos[nX,1] ) ) < 30 , AllTrim( aCampos[nX,1] ) + ( Space( 30 - Len( AllTrim ( aCampos[nX,1] ) ) ) ) , aCampos[nX,1] )
		cDetalhe := cDetalhe + AllTrim( aCampos[nX,4] )
      	
      	/*
        здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
        Ё Imprimindo Relatorio                                         Ё
        юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
        Impr( cDetalhe )
        
Next nX

IF aReturn[5] == 1
   Set Printer To
   dbCommit()
   OurSpool(WnRel)
EndIF

MS_FLUSH()

Return( NIL )

/*
зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©
ЁFun┤└o    ЁfPerg_WordЁ Autor ЁMarinaldo de Jesus     Ё Data Ё05/07/2000Ё
цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢
ЁDescri┤└o ЁGrava as Perguntas utilizadas no Programa no SX1            Ё
юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Static Function fPerg_Word()

Local aRegs     := {}

/*
здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
Ё           Grupo  Ordem Pergunta               Variavel Tipo Tamanho Decimal Presel  GSC Valid                             Var01        Def01     Cnt01               Var02  Def02             Cnt02 Var03  Def03    Cnt03  Var04  Def04      Cnt04 Var05 Def05        Cnt05 XF3    Ё
юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
aAdd(aRegs,{cPerg,'01' ,'Filial De          ?','mv_ch1','C'  ,02     ,0      ,0     ,'G','                                ','mv_par01','         ','                ',''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'SM0'})
aAdd(aRegs,{cPerg,'02' ,'Filial Ate         ?','mv_ch2','C'  ,02     ,0      ,0     ,'G','naovazio                        ','mv_par02','         ',REPLICATE('9',02) ,''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'SM0'})
aAdd(aRegs,{cPerg,'03' ,'Centro de Custo De ?','mv_ch3','C'  ,09     ,0      ,0     ,'G','                                ','mv_par03','         ','                ',''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'SI3'})
aAdd(aRegs,{cPerg,'04' ,'Centro de Custo Ate?','mv_ch4','C'  ,09     ,0      ,0     ,'G','naovazio                        ','mv_par04','         ',REPLICATE('Z',09) ,''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'SI3'})
aAdd(aRegs,{cPerg,'05' ,'Matricula De       ?','mv_ch5','C'  ,06     ,0      ,0     ,'G','                                ','mv_par05','         ','                ',''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'SRA'})
aAdd(aRegs,{cPerg,'06' ,'Matricula Ate      ?','mv_ch6','C'  ,06     ,0      ,0     ,'G','naovazio                        ','mv_par06','         ',REPLICATE('Z',06) ,''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'SRA'})
aAdd(aRegs,{cPerg,'07' ,'Nome De            ?','mv_ch7','C'  ,30     ,0      ,0     ,'G','                                ','mv_par07','         ','                ',''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'   '})
aAdd(aRegs,{cPerg,'08' ,'Nome Ate           ?','mv_ch8','C'  ,30     ,0      ,0     ,'G','naovazio                        ','mv_par08','         ',REPLICATE('Z',30) ,''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'   '})
aAdd(aRegs,{cPerg,'09' ,'Turno De           ?','mv_ch9','C'  ,03     ,0      ,0     ,'G','                                ','mv_par09','         ','                ',''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'SR6'})
aAdd(aRegs,{cPerg,'10' ,'Turno Ate          ?','mv_ch0','C'  ,03     ,0      ,0     ,'G','naovazio                        ','mv_par10','         ',REPLICATE('Z',03) ,''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'SR6'})
aAdd(aRegs,{cPerg,'11' ,'Fun┤ao De          ?','mv_cha','C'  ,03     ,0      ,0     ,'G','                                ','mv_par11','         ','                ',''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'SRJ'})
aAdd(aRegs,{cPerg,'12' ,'Fun┤ao Ate         ?','mv_chb','C'  ,03     ,0      ,0     ,'G','naovazio                        ','mv_par12','         ',REPLICATE('Z',03) ,''   ,'        	    ', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'SRJ'})
aAdd(aRegs,{cPerg,'13' ,'Sindicato De       ?','mv_chc','C'  ,02     ,0      ,0     ,'G','                                ','mv_par13','         ','                ',''   ,'        	    ', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'X04'})
aAdd(aRegs,{cPerg,'14' ,'Sindicato Ate      ?','mv_chd','C'  ,02     ,0      ,0     ,'G','naovazio                        ','mv_par14','         ',REPLICATE('Z',03) ,''   ,'       	    ', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'X04'})
aAdd(aRegs,{cPerg,'15' ,'Admissao De        ?','mv_che','D'  ,08     ,0      ,0     ,'G','                                ','mv_par15','         ','                ',''   ,'  		        ', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'   '})
aAdd(aRegs,{cPerg,'16' ,'Admissao Ate       ?','mv_chf','D'  ,08     ,0      ,0     ,'G','naovazio                        ','mv_par16','         ','                ',''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'   '})
aAdd(aRegs,{cPerg,'17' ,'Situa┤■es  a Impr. ?','mv_chg','C'  ,05     ,0      ,0     ,'G','fSituacao                       ','mv_par17','         ','                ',''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'   '})
aAdd(aRegs,{cPerg,'18' ,'Categorias a Impr. ?','mv_chh','C'  ,10     ,0      ,0     ,'G','fCategoria                      ','mv_par18','         ','                ',''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'   '})
aAdd(aRegs,{cPerg,'19' ,'Texto Livre 1      ?','mv_chi','C'  ,30     ,0      ,0     ,'G','                                ','mv_par19','         ','<Texto Livre 01>',''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'   '})
aAdd(aRegs,{cPerg,'20' ,'Texto Livre 2      ?','mv_chj','C'  ,30     ,0      ,0     ,'G','                                ','mv_par20','         ','<Texto Livre 02>',''   ,'        		', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'   '})
aAdd(aRegs,{cPerg,'21' ,'Texto Livre 3      ?','mv_chk','C'  ,30     ,0      ,0     ,'G','                                ','mv_par21','         ','<Texto Livre 03>',''   ,'        	    ', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'   '})
aAdd(aRegs,{cPerg,'22' ,'Texto Livre 4      ?','mv_chl','C'  ,30     ,0      ,0     ,'G','                                ','mv_par22','         ','<Texto Livre 04>',''   ,'        	    ', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'   '})
aAdd(aRegs,{cPerg,'23' ,'Nro. de Copias     ?','mv_chm','N'  ,03     ,0      ,0     ,'G','                                ','mv_par23','         ','                ',''   ,'        	    ', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'   '})
aAdd(aRegs,{cPerg,'24' ,'Ordem de Impressao ?','mv_chn','N'  ,01     ,0      ,0     ,'C','                                ','mv_par24','Matricula','                ',''   ,'Centro de Custo', ''    ,''   ,'Nome   ',''   ,''    ,'Turno  ', ''  , ''  , '          ', ''  ,'   '})
aAdd(aRegs,{cPerg,'25' ,'Arquivo do Word    ?','mv_cho','C'  ,30     ,0      ,0     ,'G','fOpen_Word()                    ','mv_par25','         ','                ',''   ,'       	    ', ''    ,''   ,'       ',''   ,''    ,'       ', ''  , ''  , '          ', ''  ,'   '})

/*
здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
Ё Carrega as Perguntas no SX1                                  Ё
юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
ValidPerg(aRegs,cPerg)

Return NIL
