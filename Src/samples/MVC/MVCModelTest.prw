#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

//-------------------------------------------------------------------
User Function ModelTest

Local cModel := Space( 30 )
Local cDir   := Space( 60 )
Local cPK    := Space( 60 )
Local aCheck := {}
Local aTestes := {}
Local oDlg

If Select( 'SM0' ) == 0
	SET DELE ON
	RpcSetEnv( '01', '00' )
EndIf

SetCompP10( .T. )

Define MsDialog oDlg Title 'Model Test'  From 000, 000 To 400, 600 Pixel
@ 010, 008 Say 'Fonte do Modelo' Size 035, 010 	OF oDlg Pixel
@ 010, 055 MSGET cModel          Size 136, 010 	OF oDlg Pixel

@ 025, 008 Say 'Chave de busca'  Size 040, 010 	OF oDlg Pixel
@ 025, 055 MSGET cPK             Size 136, 010 	OF oDlg Pixel

@ 040, 008 Say 'Diretório'       Size 035, 010 	OF oDlg Pixel
@ 040, 055 MSGET cDir            Size 136, 010 	OF oDlg Pixel

@ 075, 005 Button 'Sair'         Size 040, 012 Font oDlg:oFont Action oDlg:End() When .T. Pixel
@ 075, 055 Button 'Ler XML'      Size 040, 012 Font oDlg:oFont Action MtBtn01( cModel, cDir, aTestes )      When !Empty( cModel ) .AND. !Empty( cDir ) Pixel
@ 075, 105 Button 'Gerar XML'    Size 040, 012 Font oDlg:oFont Action MtBtn02( cModel, cDir, aTestes, cPK ) When !Empty( cModel ) .AND. !Empty( cDir ) Pixel
@ 075, 155 Button 'Gerar XSD'    Size 040, 012 Font oDlg:oFont Action MtBtn03( cModel, cDir, aTestes )      When !Empty( cModel ) .AND. !Empty( cDir ) Pixel

aAdd( aTestes, .F. )
aAdd( aCheck, TCheckBox():New( 050, 010, 'Atualizações', bSetGet( aTestes[1] ) , oDlg, 100, 210,,,,,,,, .T.,,, ) )
aAdd( aTestes, .F. )
aAdd( aCheck, TCheckBox():New( 060, 010, 'Impressão'   , bSetGet( aTestes[2] ) , oDlg, 100, 210,,,,,,,, .T.,,, ) )

Activate MsDialog oDlg Centered



//-------------------------------------------------------------------
Static Function MtBtn01( cModel, cDir, aTestes )

Local oModel  := FWLoadModel( AllTrim( cModel ) )
Local oReport
Local aDir    := Directory( AllTrim( cDir ) + '*.xml' )
Local aPk     := {}
Local nX      := 0
Local nY      := 0
Local nIndice := 0
Local cPK     := ''
Local cFile   := ''
Local cMsg    := ''
Local cString := ''
Local cAlias  := ''
Local lFilial := .F.
Local lOk     := .F.

Do Case
	
	Case !Empty( oModel )
		
		For nX := 1 To Len( aDir )
			
			cFile := AllTrim( cDir ) + aDir[nX][01]
			cMsg  := 'Arquivo: ' + cFile + CRLF
			
			If File( cFile )
				cMsg += 'LoadXML ( INI ): ' + Time() + CRLF
				cString := MemoRead( cFile )
				
				lOk      := .T.
				lFilial  := .F.

				aPK := oModel:LoadXMLPK( cString )
				cPK := ''				  
				
				//--------------------------------------------------------------------
				//Identifica a chave-primaria e posiciona
				//--------------------------------------------------------------------
				If !Empty( aPK ) .AND. !Empty( aPK[MODELO_PK_KEYS] ) .AND. aPK[MODELO_PK_OPERATION] <> MODEL_OPERATION_INSERT

					//--------------------------------------------------------------------					
					//Verifica o Alias da tabela
					//--------------------------------------------------------------------
					nY := At( '_', aPK[MODELO_PK_KEYS][1][MODELO_PK_IDFIELD] )
					If nY > 0
						cAlias := SubStr( aPK[MODELO_PK_KEYS][1][MODELO_PK_IDFIELD], 1, nY-1 )
						If Len( cAlias ) == 2
							cAlias := 'S' + Upper( cAlias )
						Else
							cAlias := Upper( cAlias )
						EndIf
					EndIf

					
					//--------------------------------------------------------------------
					//Encontra o melhor indice da chave primaria
					//--------------------------------------------------------------------
					
					dbSelectArea( 'SX2' )
					dbSetOrder( 1 )
					
					MsSeek( cAlias )
					
					If Empty( SX2->X2_UNICO )
						nIndice := 1
						
					Else
						nY := 0
						
						dbSelectArea( 'SIX' )
						dbSetOrder( 1 )
						
						MsSeek( cAlias )
						
						While !EOF() .AND. cAlias == SIX->INDICE
							
							nY++
							
							If AllTrim( SX2->X2_UNICO ) $ SIX->CHAVE
								nIndice := nY
								Exit
							EndIf
							
							dbSelectArea( 'SIX' )
							dbSkip()
							
						EndDo
						
						nIndice := Max( nIndice, 1 )
						
					EndIf
					
					
					//--------------------------------------------------------------------
					//Monta a chave de busca
					//--------------------------------------------------------------------
					
					For nY := 1 To Len( aPK[MODELO_PK_KEYS] )
						
						If '_FILIAL' $ aPK[MODELO_PK_KEYS][nY][MODELO_PK_IDFIELD]
							lFilial := .T.
						EndIf
						
						cPK += aPK[MODELO_PK_KEYS][nY][MODELO_PK_VALUE]
						
					Next nY
					
					dbSelectArea( cAlias )
					dbSetOrder( nIndice )
					
					If !lFilial .AND. '_FILIAL' $ ( cAlias )->( IndexKey() )
						cPK := xFilial( cAlias ) + RTrim( cPK )
						
					Else
						
						cPk := RTrim( cPK )
					EndIf
					
					
					//--------------------------------------------------------------------
					//Posiciona pela chave busca
					//--------------------------------------------------------------------
					dbSelectArea( cAlias )
					dbSetOrder( nIndice )
					
					If MsSeek( cPK )
						oModel:SetOperation( MODEL_OPERATION_UPDATE )  
						INCLUI := .F.
						ALTERA := .T.
					Else	                                         
						oModel:SetOperation( MODEL_OPERATION_INSERT )
						INCLUI := .T.
						ALTERA := .F.

						//cMsg += 'Primary key ( ' + cPK + ' ) not Found!' + CRLF
						//lOk  := .F.
					EndIf
					
				EndIf
				
				If lOk
					
					Do Case
						
						Case !oModel:GetId() $ cString
							MsgAlert( 'Erro na carga do arquivo ' + cFile )
							
						Case !oModel:LoadXmlData( cString )
							MsgAlert( oModel:GetErrorMessage()[6] + '/' + oModel:GetErrorMessage()[7] )
							
						OtherWise
							cMsg += 'LoadXML ( FIM ): ' + Time() + CRLF
							  
							//
							// Atualização
							//
							If aTestes[1]
								
								cMsg += 'VldData ( INI ): ' + Time() + CRLF
								
								If oModel:VldData()
									cMsg += 'VldData ( FIM ): ' + Time() + CRLF
									cMsg += 'Commit ( INI ): ' + Time() + CRLF
									oModel:CommitData()
									cMsg += 'Commit ( FIM ): ' + Time() + CRLF
									
								Else
									MsgAlert( VarInfo( 'ErrorMessage', oModel:GetErrorMessage() ) )
									
								EndIf
								
							EndIf
							  
							//
							// Impressao
							//
							If aTestes[2]
								cMsg += 'Impressao ( INI ): ' + Time() + CRLF
								oReport := oModel:ReportDef()
								oReport:PrintDialog()
								cMsg += 'Impressao ( INI ): ' + Time() + CRLF
							EndIf
							
							MsgInfo( cMsg )
							
					EndCase
					
				Else
					MsgAlert( cMsg )
					
				EndIf
				  
				//
				// Fim
				//
				oModel:DeActivate()
				
			EndIf
			
		Next nX
		
	Case Empty( aDir )
		MsgAlert( 'Não há dados!' )
		
	OtherWise
		MsgAlert( 'Modelo não encontrado' )
		
EndCase

Return NIL



//-------------------------------------------------------------------
Static Function MtBtn02( cModel, cDir, aTestes, cPK )

Local oModel   := FWLoadModel( AllTrim( cModel ) )
Local nX       := 0
Local nIndice  := 0
Local cArquivo := CriaTrab( , .F. ) + '.xml'
Local cAlias   := ''
Local lFilial  := .F.
Local lOk      := .F.
Local aStruct  := {}

If oModel <> NIL
	
	lOk      := .T.
	lFilial  := .F.
	
	//--------------------------------------------------------------------
	//Identifica a chave-primaria e posiciona
	//--------------------------------------------------------------------
	If !Empty( cPK )
		
		//--------------------------------------------------------------------
		//Verifica o Alias da tabela
		//--------------------------------------------------------------------
		aStruct := oModel:GetDependency()[1][MODEL_STRUCT_MODEL]:GetStruct():GetFields()
		
		nX := At( '_', aStruct[1][MODEL_FIELD_IDFIELD] )
		
		If nX > 0
			cAlias := SubStr( aStruct[1][MODEL_FIELD_IDFIELD], 1, nX-1 )
			
			If Len( cAlias ) == 2
				cAlias := 'S' + Upper( cAlias )
			Else
				cAlias := Upper( cAlias )
			EndIf
			
		EndIf
		
		
		//--------------------------------------------------------------------
		//Encontra o melhor indice da chave primaria
		//--------------------------------------------------------------------
		dbSelectArea( 'SX2' )
		dbSetOrder( 1 )
		
		MsSeek( cAlias )
		
		If Empty( SX2->X2_UNICO )
			nIndice := 1
			
		Else
			nX := 0
			
			dbSelectArea( 'SIX' )
			dbSetOrder( 1 )
			
			MsSeek( cAlias )
			
			While !EOF() .AND. cAlias == SIX->INDICE
				nX++
				
				If AllTrim( SX2->X2_UNICO ) $ SIX->CHAVE
					nIndice := nX
					Exit
				EndIf
				
				dbSelectArea( 'SIX' )
				
				dbSkip()
				
			EndDo
			
			nIndice := Max( nIndice, 1 )
			
		EndIf
		
		
		//--------------------------------------------------------------------
		//Posiciona pela chave busca
		//--------------------------------------------------------------------
		dbSelectArea( cAlias )
		dbSetOrder( nIndice )
		
		If !MsSeek( RTrim( cPK ) )
			MsgAlert( 'Primary key ( ' + cPK + ' ) not Found!' )
			lOk  := .F.
			
		Else
			oModel:SetOperation( MODEL_OPERATION_UPDATE )
			
		EndIf
		
	Else
		lOk := .T.
		oModel:SetOperation( MODEL_OPERATION_INSERT )
		
	EndIf
	
	If lOk
		
		cDir := AllTrim( cDir )
		
		oModel:Activate()
		
		MemoWrit( cDir + cArquivo, oModel:GetXMLDataUpDate() )
		
		oModel:DeActivate()
		
		If !Empty( cDir )
			__CopyFile( cArquivo, cDir + cArquivo )
		EndIf
		
		oModel:DeActivate()
		
		MsgInfo( 'Arquivo: ' + cDir + cArquivo + ' gerado!' )
		
	EndIf
	
Else
	MsgAlert( 'Modelo não encontrado' )
	
EndIf

Return NIL



//-------------------------------------------------------------------
Static Function MtBtn03( cModel, cDir, aTestes )

Local oModel   := FWLoadModel( AllTrim( cModel ) )
Local cArquivo := CriaTrab( , .F. ) + '.xsd'

If oModel <> NIL
	
	cDir := AllTrim( cDir )
	
	oModel:SetOperation( MODEL_OPERATION_INSERT )
	oModel:Activate()
	
	MemoWrit( cArquivo, oModel:GetXMLSchema() )
	
	If !Empty( cDir )
		__CopyFile( cArquivo, cDir + cArquivo )
	EndIf
	
	oModel:DeActivate()
	
	MsgInfo( 'Arquivo: ' + cDir + cArquivo + ' gerado!' )
	
Else
	
	MsgAlert( 'Modelo não encontrado' )
	
EndIf

Return NIL


