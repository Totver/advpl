#Include "RwMake.Ch"
#Include "TbiConn.Ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Rotina    ³ CarOutEnv  ³ Autor ³Wagner Mobile Costa       	    ³ Data ³05/03/2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Inicializa objeto para replica entre enviroment's                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CarOutEnv(ParA1, ParA2, ParC3, ParC4, ParN5, ParC6, ParC7) 				 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ParA1 - Matriz c/ tabelas envolvidas na copia { { "SA1", "SA2" }.. }  ³±±
±±³          ³ ParA2 - Matriz com tres posicoes  												 ³±±
±±³          ³ { { Indice a ser utilizado, chave de indice, chave de busca }, .. }   ³±±
±±³          ³ ParC3 - Enviroment para replica    												 ³±±
±±³          ³ ParC4 - Server onde esta a environment	a ser utilizada					 ³±±
±±³          ³ ParC5 - Porta para conexao TCP/IP                        		 		 ³±±
±±³          ³ ParC6 - Empresa onde sera feita a replicacao dos dados   		 		 ³±±
±±³          ³ ParC7 - Filial onde sera feita a replicacao dos dados   		 		    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CarOutEnv(aTabelas, aChaves, cEnv, cServer, nPorta, cEmpresa, cFilialC)

Local oServer, aGravar := {}, nTabelas

If cEnv = Nil
	U_CarregaRpc(@cEnv, @cServer, @nPorta, @cEmpresa, @cFilialC)
Endif

CREATE RPCCONN oServer ON SERVER cServer;
  		 PORT nPorta ENVIRONMENT cEnv;
		 EMPRESA cEmpresa FILIAL cFilialC

If Len(aTabelas) = 1
	PREPARE ENVIRONMENT IN SERVER oServer EMPRESA cEmpresa FILIAL cFilialC;
			  TABLES aTabelas[1]
ElseIf Len(aTabelas) = 2
	PREPARE ENVIRONMENT IN SERVER oServer EMPRESA cEmpresa FILIAL cFilialC;
			  TABLES aTabelas[1], aTabelas[2]
ElseIf Len(aTabelas) = 3
	PREPARE ENVIRONMENT IN SERVER oServer EMPRESA cEmpresa FILIAL cFilialC;
			  TABLES aTabelas[1], aTabelas[2], aTabelas[3]
ElseIf Len(aTabelas) = 4
	PREPARE ENVIRONMENT IN SERVER oServer EMPRESA cEmpresa FILIAL cFilialC;
			  TABLES aTabelas[1], aTabelas[2], aTabelas[3], aTabelas[4]
ElseIf Len(aTabelas) = 5
	PREPARE ENVIRONMENT IN SERVER oServer EMPRESA cEmpresa FILIAL cFilialC;
			  TABLES aTabelas[1], aTabelas[2], aTabelas[3], aTabelas[4], aTabelas[5]
ElseIf Len(aTabelas) = 6
	PREPARE ENVIRONMENT IN SERVER oServer EMPRESA cEmpresa FILIAL cFilialC;
			  TABLES aTabelas[1], aTabelas[2], aTabelas[3], aTabelas[4], aTabelas[5],;
			         aTabelas[6]
ElseIf Len(aTabelas) = 7
	PREPARE ENVIRONMENT IN SERVER oServer EMPRESA cEmpresa FILIAL cFilialC;
			  TABLES aTabelas[1], aTabelas[2], aTabelas[3], aTabelas[4], aTabelas[5],;
			         aTabelas[6], aTabelas[7]
ElseIf Len(aTabelas) = 8
	PREPARE ENVIRONMENT IN SERVER oServer EMPRESA cEmpresa FILIAL cFilialC;
			  TABLES aTabelas[1], aTabelas[2], aTabelas[3], aTabelas[4], aTabelas[5],;
			         aTabelas[6], aTabelas[7], aTabelas[8]
ElseIf Len(aTabelas) = 9
	PREPARE ENVIRONMENT IN SERVER oServer EMPRESA cEmpresa FILIAL cFilialC;
			  TABLES aTabelas[1], aTabelas[2], aTabelas[3], aTabelas[4], aTabelas[5],;
			         aTabelas[6], aTabelas[7], aTabelas[8], aTabelas[9]
ElseIf Len(aTabelas) = 10
	PREPARE ENVIRONMENT IN SERVER oServer EMPRESA cEmpresa FILIAL cFilialC;
			  TABLES aTabelas[1], aTabelas[2], aTabelas[3], aTabelas[4], aTabelas[5],;
			         aTabelas[6], aTabelas[7], aTabelas[8], aTabelas[9], aTabelas[10]
Endif		 													
		 													
For nTabelas := 1 To Len(aTabelas)
	DbSelectArea(aTabelas[nTabelas])
	DbSetOrder(aChaves[nTabelas][1])
	ConOut('Lendo tabela ' + Alias() + ' - Chave ' + aChaves[nTabelas][2] + '.')
   While &(aChaves[nTabelas][2]) = aChaves[nTabelas][3] .And. ! Eof()
		Aadd(aGravar, Array(FCount()))
		For nIndice := 1 To FCount()
			If "_FILIAL" $  Upper(FieldName(nIndice)) .And. ! Empty(FieldGet(nIndice))
				aGravar[Len(aGravar)][nIndice] := { FieldName(nIndice), cFilialC }
			Else
				aGravar[Len(aGravar)][nIndice] := { FieldName(nIndice), FieldGet(nIndice) }
			Endif				
		Next
		DbSkip()
   EndDo
	oServer:CallProc("U_GrvOutEnv", aTabelas[nTabelas], aGravar)
	aGravar := {}
Next	

RESET ENVIRONMENT IN SERVER oServer
CLOSE RPCCONN oServer
	
Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Rotina    ³ CarregaRpc ³ Autor ³Wagner Mobile Costa       	    ³ Data ³05/03/2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Inicializa variaveis para replica entre enviroment's                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CarregaRpc(ParC1, ParC2, ParN3, ParC4, ParC5) 			   				 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ParC1 - Enviroment para replica    												 ³±±
±±³          ³ ParC2 - Server onde esta a environment	a ser utilizada					 ³±±
±±³          ³ ParC3 - Porta para conexao TCP/IP                        		 		 ³±±
±±³          ³ ParC4 - Empresa onde sera feita a replicacao dos dados   		 		 ³±±
±±³          ³ ParC5 - Filial onde sera feita a replicacao dos dados   		 		    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CarregaRpc(cEnv, cServer, nPorta, cEmpresa, cFilialC)

If GetPvProfString(GetEnvServer(), "REPENV", "", "Ap5Srv.Ini") <> Space(0)
	cEnv := GetPvProfString(GetEnvServer(), "REPENV", "", "Ap5Srv.Ini")
Else
	cEnv := GetEnvServer()
Endif	

If GetPvProfString(GetEnvServer(), "REPSERVER", "", "Ap5Srv.Ini") <> Space(0)
	cServer := GetPvProfString(GetEnvServer(), "REPSERVER", "", "Ap5Srv.Ini")
Else
	cServer := GetPvProfString("Tcp", "Server", "", "Ap5Rmt.Ini")
Endif	

If GetPvProfString(GetEnvServer(), "REPPORT", "", "Ap5Srv.Ini") <> Space(0)
	nPorta  := Val(GetPvProfString(GetEnvServer(), "REPPORT", "", "Ap5Srv.Ini"))
Else
	nPorta  := Val(GetPvProfString("Tcp", "Port"  , "", "Ap5Rmt.Ini"))
Endif	

cEmpresa := GetNewPar("MV_REPEMP", cEmpAnt)
cFilialC := GetNewPar("MV_REPFIL", cFilAnt)

Return .T.