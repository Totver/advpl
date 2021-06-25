#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "AP5MAIL.CH"

//-----------------------------------------------
/*/{Protheus.doc} TRGXEJOB
Execução dos JOBs de Integrações, chamada pela tela de cadastros da Rotina

@type function
@author Hermes
@since 11/01/2018
@version 1.0
/*/
//-----------------------------------------------
User Function TRGXEJOB()

    If !IsBlind()
        ApMsgInfo( 'Serão executados somentes os Jobs cadastrados no ambiente logado: ' + Upper(AllTrim(GetEnvServer())) , 'Atenção' )
        FWMsgRun( ,{|| StartJob( "U_TRGXJOB" , GetEnvServer(), .T.)   },"Executando Jobs...","Aguarde...") 
    Else
        StartJob( "U_TRGXJOB" , GetEnvServer(), .T.)
    EndIf

Return

//-----------------------------------------------
/*/{Protheus.doc} TRGXJOB
Execução dos JOBs da tabela PNM, chamada do OnStart

@type function
@author Hermes
@since 11/01/2018
@version 1.0
/*/
//-----------------------------------------------
User Function TRGXJOB()

    Local lOk       := .T.
    Local cMsg      := ""
    Local cChvLock  := "TRGXJOB"
    Local cDirLck   := "\semaforo\"
    Local cThread   := ""
    Local cEnvAmb   := ""
    Local lAlone    := Select("SM0") == 0

    If ! U_OpenSM0()
        cMsg := " TRGXJOB - ERRO - Nao foi possivel iniciar a empresa!"
        PtInternal(1, cMsg)
        Conout(cMsg)
        lOk := .F.
        
    EndIf

    If lOk
    
        cThread     := Alltrim(Str(Threadid()))
        cEnvAmb     := Upper(AllTrim(GetEnvServer()))

        cChvLock += "_"+StrTran(cEnvAmb,"#","")

        Conout("Iniciando U_TRGXJOB: " + cChvLock + " - " + cThread)

        If U_LockByFl( cChvLock )

            Conout("Job U_TRGXJOB executando " + cChvLock + " - " + cThread) 

            U_FJbsQuery( cEnvAmb )

        	U_UnLockByFl( cChvLock  )
		FErase( cDirLck + cChvLock + ".lck")

            Conout("o Job U_TRGXJOB liberado UnLockByFl " + cChvLock + " - " + cThread) 
        
        Else

            Conout("o Job U_TRGXJOB ja está em executacao - LockByFl " + cChvLock + " - " + cThread) 

        EndIf
    EndIf

    Conout("Fim U_TRGXJOB" + cChvLock + " - " + cThread)
    If lAlone
       RPCClearEnv()
    EndIf

Return Nil


//-----------------------------------------------
/*/{Protheus.doc} FJbsQuery
Query para identificar os JOBS que deverão ser
executados, e disparo das threads com 
a execução de cada Função

@type function
@author Hermes
@since 11/01/2018
@version 1.0
/*/
//-----------------------------------------------
User Function FJbsQuery( cEnvAmb )

    Local cSql      := ""
    Local clAlias   := GetNextAlias()
    Local nThrDis   := 0
    Local nMaxThr   := 5

    dbSelectArea("PNM")

    cSql := " SELECT PNM.R_E_C_N_O_  AS PNMRECNO "
    cSql +=    "FROM " + RetSqlName("PNM")+ " PNM "
    cSql +=   "WHERE PNM_FILIAL = '"+ FWxFilial("PNM") + "' "
    cSql +=     "AND PNM_STATUS = '1' AND PNM_AMBIEN = '"+ cEnvAmb +"' "
    cSql +=     "AND PNM.D_E_L_E_T_= ' '"
    cSql +=   "ORDER BY PNM_CINTEG, PNM_ROTINA"

    dbUseArea( .T., __cRdd, TcGenQry( ,, cSql ), clAlias, .T., .F. )
	dbSelectArea(clAlias)
	(clAlias)->( dbGoTop() )

	If (clAlias)->( ! Eof() )

        While (clAlias)->( ! Eof() )

            PNM->(dbGoTo( (clAlias)->PNMRECNO ))

            U_TIntXJOBEx( .F. , @nThrDis , cEnvAmb )

            If nThrDis == nMaxThr
                Sleep(120000) // Aguarda 3 minutos para dispara a proxima sequencia
                nThrDis := 0
            EndIf

            (clAlias)->( dbSkip() )
        EndDo

    EndIf

    (clAlias)->( dbCloseArea() )

Return


//-----------------------------------------------
/*/{Protheus.doc} TIntXJOBEx
Execução dos Jobs e atualização do processamento

@type function
@author Hermes
@since 11/01/2018
@version 1.0
/*/
//-----------------------------------------------
User Function TIntXJOBEx( lWait , nThrDis , cEnvAmb )

    Local cParam    := ""
    Local aParam    := {}
    Local xParam1   := Nil
    Local xParam2   := Nil
    Local xParam3   := Nil
    Local xParam4   := Nil
    Local xParam5   := Nil
    Local xParam6   := Nil
    Local xParam7   := Nil
    Local xParam8   := Nil
    Local xParam9   := Nil
    Local xParam10  := Nil
    Local xParam11  := Nil
    Local xParam12  := Nil
    Local xParam13  := Nil
    Local xParam14  := Nil
    Local xParam15  := Nil
    Local nC        := 0
    Local lExc      := .T.
    Local nVsExec   := 0
    Local cMsg      := ""

    Default lWait       := .F.
    Default nThrDis     := 0
    Default cEnvAmb     := Upper(AllTrim(GetEnvServer()))

    If !(Alltrim(PNM->PNM_AMBIEN) == Alltrim(cEnvAmb) )
        lExc := .F.
        cMsg := "Para realizar a execução deste Job, é necessário executar acessando o ambiente: " + Alltrim(PNM->PNM_AMBIEN) 
    ElseIf PNM->PNM_STATUS <> "1"
        lExc := .F.
        cMsg := "Somente JOBs com status de ativos podem ser executados."
    EndIf

    If lExc

        aParam := Separa( PNM->PNM_PARAME ,  "|" )

        If Len(aParam) <= 15

            //Se tiver quantidade de Execuções por Dia
            If PNM->PNM_QTDXDI > 0

                If PNM->PNM_DTULTE == MsDate()

                    // Se a quantidade executa no dia for Maior ou igual ao maximo por dia, não executa
                    If PNM->PNM_QTDEXC >= PNM->PNM_QTDXDI

                        // Se for Job, se for execução via tela, deixa processar
                        If IsBlind() 
                            lExc := .F.
                        EndIf

                    EndIf

                    If lExc
                        
                        If ElapTime( PNM->PNM_HRULT , TIME() ) < PNM->PNM_INTERV

                            // Se for Job, se for execução via tela, deixa processar
                            If IsBlind() 
                                lExc := .F.
                            EndIf

                        EndIf

                    EndIf

                EndIf

            EndIf


            If lExc
            
                For nC := 1 To Len( aParam )

                    If nC == 1
                        xParam1 :=  &(aParam[ nC ])
                    ElseIf nC == 2
                        xParam2 :=  &(aParam[ nC ])
                    ElseIf nC == 3
                        xParam3 :=  &(aParam[ nC ])
                    ElseIf nC == 4
                        xParam4 :=  &(aParam[ nC ])
                    ElseIf nC == 5
                        xParam5 :=  &(aParam[ nC ])
                    ElseIf nC == 6
                        xParam6 :=  &(aParam[ nC ])
                    ElseIf nC == 7
                        xParam7 :=  &(aParam[ nC ])
                    ElseIf nC == 8
                        xParam8 :=  &(aParam[ nC ])
                    ElseIf nC == 9
                        xParam9 :=  &(aParam[ nC ])
                    ElseIf nC == 10
                        xParam10 := &(aParam[ nC ])
                    ElseIf nC == 11
                        xParam11 := &(aParam[ nC ])
                    ElseIf nC == 12
                        xParam12 := &(aParam[ nC ])
                    ElseIf nC == 13
                        xParam13 := &(aParam[ nC ])
                    ElseIf nC == 14
                        xParam14 := &(aParam[ nC ])
                    ElseIf nC == 15
                        xParam15 := &(aParam[ nC ])
                    EndIf
                
                Next nC

                nThrDis++
                Conout(" Disparando JOB - " + PNM->PNM_CINTEG +" - "+ PNM->PNM_ROTINA )
                StartJob( PNM->PNM_ROTINA , GetEnvServer(), lWait , xParam1 , xParam2 , xParam3 , xParam4 , xParam5 , xParam6 , xParam7 , xParam8 , xParam9 , xParam10 , xParam11 , xParam12 , xParam13 , xParam14 , xParam15 )
                Sleep(2000) // 2 segundos

                // Verifica se é a primeira vez do Dia
                If PNM->PNM_DTULTE == MsDate()
                    nVsExec := PNM->PNM_QTDEXC
                Else
                    nVsExec := 0
                EndIf

                // Atualiza que houve processamento
                If PNM->( RecLock("PNM" , .F. ) )
                    PNM->PNM_DTULTE := MsDate()
                    PNM->PNM_HRULT  := Time()
                    PNM->PNM_QTDEXC := ++nVsExec
                    PNM->(MsUnLock())
                EndIf
            
            EndIf

        EndIf
    
    EndIf

    If !IsBlind()
        ApMsgStop( cMsg , 'Atenção' )
    EndIf

Return