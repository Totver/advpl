#Include 'Protheus.ch'

Static __nHeight   := NIL
Static __nWidth    := NIL
Static __cSeqTmp   := "000"
Static __aQryBrw   := Array(5)
Static __aAliasExp := Array(5)
Static __aAliasTst := Array(5)
Static __aDicBrw   := Array(5)
Static __aNewBrw   := Array(5)
Static __aDicTst   := Array(5)

Static __abTelQry   := Array(5)
Static __bTelRpo  
Static __bTelExp  
Static __bTelErro  

Static __lReadOnly := .T.
Static __lDeleON   := .T.
Static __aHstQry   := {{}, {}, {}, {}, {}}
Static __aHstCmd   := {}
Static __aHstBase  := {}
Static __aHstHtm   := {}
Static __aHstFil   := {}
Static __aHstCmp   := {}
Static __aHstMacro := {{},{},{}}
Static __nBuffer   := 40
Static __cErroA	   := ""
Static __cMaskArq  := "*.*"
Static __cErroP    := ""
Static __cListaEmp := ""
Static __oTimer 

Static __lRPO  := .T.
Static __lSx3  := .F.
Static __lSx6  := .F.
Static __lSx7  := .F.
Static __lSXb  := .F.
Static __lMnu  := .F.
Static __lAdmin:= .F.
Static __cUser := ""
Static __cNome := ""

User Function CALLCHGXNU() //Afterlogin()

    SetKey(K_ALT_S, {|| U_TIDev() })

Return Paramixb[5]



User Function TIDev()
            
    If Type("OMAINWND") != "O"
        TIDevMan()
    Else 
        TIDevChild()
    EndIf 

Return 


Static Function TIDevMan()
    Local cEmp     := ""
    Local cFil     := ""
    Local lRet     := .F.
    Local oMsgBar  
    Local oMsgIt
    Local oMsgIt2
    Private oMsgIt3
    Private oMsgIt4
    Private oMsgIt5
    Private oMsgIt6
    Private oSelWnd
    Private oMainWnd
    Private oFont
    Private lLeft     := .F.
    Private cVersao   := GetVersao()
    Private dDataBase := MSDate()
    Private cUsuario  := "TOTVS"
    Private __cInterNet := NIL
    Private lmshelpauto := .F.

    Private oFWLayer

    Set(11,"on")
    set epoch to 1980
    set century on

    OpenSm0()
    dbSelectArea("SM0")

    //DEFINE FONT oFont NAME "MS Sans Serif" SIZE 0, -9
    oFont := TFont():New('Arial',, -11, .T., .T.)

    DEFINE WINDOW oSelWnd FROM 0,0 TO 1000, 1000 TITLE "TIDev - Ferramenta de desenvolvimento"
        oSelWnd:oFont := oFont
        oSelWnd:SetColor(CLR_BLACK,CLR_WHITE)
        oSelWnd:nClrText := 0
        oSelWnd:ReadClientCoors()

    ACTIVATE WINDOW oSelWnd MAXIMIZED ON INIT (lRet := SelEmp(@cEmp, @cFil, oSelWnd ) , oSelWnd:End())

    If  ! lRet
        Return .F.
    Endif

    __cInterNet := Nil
    lmshelpauto := .F.
    TIDesMon( "### TOTVS TI DEVELOPER ###" )
    //
    
    
    DEFINE WINDOW oMainWnd FROM 0,0 TO 1000, 1000 TITLE "TIDev - Ferramenta de desenvolvimento"
        oMainWnd:oFont := oFont
        oMainWnd:SetColor(CLR_BLACK,CLR_WHITE)
        oMainWnd:nClrText := 0
        
        oMainWnd:nBottom := 976
        oMainWnd:nHeight := 976
        oMainWnd:nRight  := 1910

        Tela(oMainWnd) 

        DEFINE MESSAGE BAR oMsgBar OF oMainWnd PROMPT "TIDev " COLOR RGB(116,116,116) FONT oFont
        DEFINE MSGITEM oMsgIt of oMsgBar PROMPT "Empresa: " + cEmpAnt + " Filial: " + cFilAnt  SIZE 100  ACTION InitEmp(oMsgIt)
        DEFINE MSGITEM oMsgIt2 of oMsgBar PROMPT GetEnvServer() SIZE 100
        DEFINE MSGITEM oMsgIt3 of oMsgBar PROMPT "Dele On" SIZE 100
        DEFINE MSGITEM oMsgIt4 of oMsgBar PROMPT __cNome SIZE 200
        DEFINE MSGITEM oMsgIt5 of oMsgBar PROMPT UsrRetName(__cUserId) SIZE 200
        DEFINE MSGITEM oMsgIt6 of oMsgBar PROMPT __cUserId SIZE 100

    ACTIVATE WINDOW oMainWnd MAXIMIZED 
    
    LimpaQry()

    RpcClearEnv()

Return 


Static Function TIDevChild()
    Local oDlg 
    
    If ! IsUsrAdmin() 
        __lAdmin := .f. 
        FWAlertWarning("Opção disponivel para administrador!")
        Return 
    ElseIf UsrRetName(__cUserId)  == "ATENDCONSULTA" .or. UsrRetName(__cUserId)  == "SYSTEM"
        __lAdmin := .f. 
        FWAlertWarning("Opção disponivel para administrador!")
        Return     
    Else 
        __lAdmin := .t.     
    EndIf 
    
    If __nHeight == NIL
        __nHeight := oMainWnd:nHeight - 100
    EndIf 
    __nWidth  := oMainWnd:nWidth - 20

    DEFINE MSDIALOG oDlg FROM 0,0 TO oMainWnd:nHeight - 100, oMainWnd:nWidth  - 20  Pixel TITLE  "TIDev - Ferramenta de desenvolvimento"
        oDlg:lEscClose := .F.

        Tela(oDlg)

    ACTIVATE MSDIALOG oDlg CENTERED

    Set(11,"on")

Return  


Static Function Tela(oDlg)
    Local aFolder  := {'Query','Tabelas', 'RPO', 'Linha de Comando','Html', 'Arquivos',"Monitor","Serviço","Erro"}
    Local oFol 
    
    Local aFolQry  := {"Query #1", "Query #2", "Query #3", "Query #4", "Query #5"}
    Local oFolQry 

    Local aFolDic  := {"Tabela #1", "Tabela #2", "Tabela #3", "Tabela #4", "Tabela #5"}
    Local oFolDic

    Local nSF
    Local oP0
    
    oDlg:nLeft := 0
    oDlg:nTop  := 0


    GetEmps() // atualiza a variavel static __cListaEmp
    
    oP0:= TPanelCss():New(,,, oDlg)
    oP0:SetCoors(TRect():New(0, 0, 10, 10))
    oP0:Align :=CONTROL_ALIGN_ALLCLIENT

    oFol := TFolder():New(, , aFolder, aFolder, oP0, , , , .T., .F.)
    oFol:Align := CONTROL_ALIGN_ALLCLIENT
    oFol:bSetOption:= {|n| SetFolder(n, oFol, oFolQry), .T.}
    
    //--Folder Query
    oFolQry := TFolder():New(, , aFolQry, aFolQry, oFol:aDialogs[1], , , , .T., .F.)
    oFolQry:Align := CONTROL_ALIGN_ALLCLIENT
    oFolQry:bSetOption:= {|n| SetFolQry(n, oFol), .T.}
    For nSF := 1 to 5 
        FolderQry(oFolQry:aDialogs[nSF], nSF)
    Next

    //--Folder Dicionario
    oFolDic := TFolder():New(, , aFolDic, aFolDic, oFol:aDialogs[2], , , , .T., .F.)
    oFolDic:Align := CONTROL_ALIGN_ALLCLIENT
  
    For nSF := 1 to 5 
        FolderDic(oFolDic:aDialogs[nSF], nSF)
    Next

    FolderRpo(oFol:aDialogs[3])        //--Folder Inspeção de Funções/Comandos
    FolderCmd(oFol:aDialogs[4])        //--Folder Comandos
    FolderHtm(oFol:aDialogs[5])	       //--Folder Html
    FolderExp(oFol:aDialogs[6])        //--Folder File Explorer
    FolderMon(oFol:aDialogs[7], oDlg)
    FolderServ(oFol:aDialogs[8])
    FolderErro(oFol:aDialogs[9])        //--Folder Error

Return 

Static Function SetFolder(nFolder, oFol, oFolQry)

    If __oTimer == NIL
        Return
    EndIf
  
    If nFolder == 7
        __oTimer:Activate()
    Else
        __oTimer:DeActivate()
    EndIf
    If nFolder == 1
        Eval(__abTelQry[oFolQry:nOption]) 
    ElseIf nFolder == 3 // RPO
        Eval(__bTelRpo)
    ElseIf nFolder == 6 // Explore
        Eval(__bTelExp)
    ElseIf nFolder == 9 // Erro
        Eval(__bTelErro)
    EndIf 
   
Return

Static Function SetFolQry(nFolder, oFol)

    Eval(__abTelQry[nFolder])    

Return

Static Function GetEmps()
    Local aAux    := FWLoadSM0()
    Local nx      := 1
    Local cCodEmp := ""

    For nx := 1 to len(aAux)
		cCodEmp := aAux[nx, 1]
        __cListaEmp += cCodEmp + "0,"
    Next 
    

Return 


Static Function SelEmp(cEmp, cFil, oWnd, lLogin)
    Local oModal
    Local oCbxEmp
    Local oFont
    Local cEmpAtu			:= ""
    Local lOk				:= .F.
    Local aCbxEmp			:= {}
    Local npB
    Local npT
    Local lRet

    Local aAux      := FWLoadSM0()
    Local nx        := 0
    Local cCodEmp   := ""
    Local cFilEmp   := ""
    Local cNomEmp   := ""
    Local cNomFil   := ""
    Local cRemType  := cValToChar(GetRemoteType())
        
    Default lLogin  := .t.

    oFont := TFont():New('Arial',, -11, .T., .T.)

    If __nHeight == NIL
        If oMainWnd == NIL
            oMainWnd := oWnd
        EndIf 
        __nHeight := oMainWnd:nHeight - 100
        __nWidth  := oMainWnd:nWidth - 30
    EndIf 

    If IsLogin() .AND. cRemType $ "0*1*2" //Windows, Linux ou MacOS
        Final("Uso permitido apenas pelo cofre de senhas!") 
    EndIf

    If lLogin .And. IsLogin()
        Login(cEmp, cFil, oWnd)
    EndIf 

    For nx := 1 to len(aAux)
		cCodEmp := aAux[nx, 1]
		cFilEmp := aAux[nx, 2]
        cNomEmp := aAux[nx, 6]
        cNomFil := aAux[nx, 7]
        Aadd(aCbxEmp, cCodEmp + '/' + cFilEmp + ' - ' + Alltrim(cNomEmp) + ' / ' + cNomFil)
	Next 

    oModal  := FWDialogModal():New()       
    oModal:SetEscClose(.f.)
    oModal:setTitle("TIDEV - Seleção de empresa")
    oModal:setSize(100, 200)
    oModal:createDialog()
    oModal:AddButton("OK"      , {|| lOk := .T. , oModal:DeActivate()}     , "OK",,.T.,.F.,.T.,)
	oModal:AddButton("Cancelar", {|| lOk := .F., oModal:DeActivate()}     , "Cancelar",,.T.,.F.,.T.,)

    @ 010,005 Say "Empresa:" PIXEL of oModal:getPanelMain()  FONT oFont 
    @ 018,005 MSCOMBOBOX oCbxEmp VAR cEmpAtu ITEMS aCbxEmp SIZE 190,10 OF oModal:getPanelMain() PIXEL
    
    oModal:Activate()
		
    If lOk
        npB     := at("/", cEmpAtu)
        cEmp    := Left(cEmpAtu, npB - 1)
        cEmpAtu := Subs(cEmpAtu, npB + 1)
        npT     := at("-", cEmpAtu)
        cFil    := Left(cEmpAtu, npT - 2)
        
        RpcClearEnv()
        RpcSetType(3)

        Processa({||lRet := RpcSetEnv(cEmp, cFil,,,,,) }, "Aguarde...", "Montando Ambiente. Empresa [" + cEmp + "] Filial [" + cFil +"]."  )
        If !lRet
            FWAlertWarning("Não foi possível montar o ambiente selecionado. " )
            Return .F.
        Else 
            If lLogin .and.  ! IsLogin()
                __lAdmin    := .T.
                __lReadOnly := .T. 
                __cUserId   := "000000"
                __cNome     := "Administrador"
            Else 
                __cUserId := __cUser
            Endif
        EndIf
    EndIf 

Return lOk

Static Function IsLogin()
    Local cEnvServer:= GetEnvServer() 
    Local cServerIP := PegaIP()

    
    If (Upper(cEnvServer) == "#TOTVS12" .or. Upper(cEnvServer) == "#TOTVS12_MI")
        Return .t. 
    EndIf 

    If Left(cServerIP, 9) == "172.24.24" .or. Left(cServerIP, 9) == "172.24.21"
        Return .t. 
    EndIf 

Return .f.

Static Function Login(cEmp, cFil, oWnd)
    Local oModal
    Local oFont
    Local lOk				:= .F.
    Local cUserName := Space(100)
    Local cSenha    := Space(250)
    Local cUserID   := ""
  
    oFont := TFont():New('Arial',, -11, .T., .T.)

    oModal  := FWDialogModal():New()       
    oModal:SetEscClose(.f.)
    oModal:setTitle("TIDEV - Autenticação")
    oModal:setSize(100, 140)
    oModal:createDialog()
    oModal:AddButton("OK", {|| lOk := VldLogin(cUserName, cSenha, @cUserID),  IF(lOk, oModal:DeActivate(), NIL)}     , "OK",,.T.,.F.,.T.,)
	oModal:AddButton("Cancelar",{|| lOk := .F., oModal:DeActivate()}     , "Cancelar",,.T.,.F.,.T.,)

    @ 010,005 Say "Usuario:" PIXEL of oModal:getPanelMain()   FONT oFont 
    @ 018,005 GET oUsuario  VAR cUserName  SIZE 130, 9 OF oModal:getPanelMain() PIXEL FONT oFont

    @ 032,005 Say "Senha:" PIXEL of oModal:getPanelMain()  FONT oFont 
    @ 040,005 GET oSenha VAR cSenha PASSWORD  SIZE 130, 9 OF oModal:getPanelMain() PIXEL FONT oFont
        
    oModal:Activate()
		
    If lOk
        __cUserId := cUserID
    Else 
        Final()
    EndIf 

Return lOk

Static Function VldLogin(cUser, cSenha, cUserID)
    Local lRet    := .F.
    Local aUser   := {}
    Local nRetPsw := 0
    __lAdmin := .F.
    
    cUser     := Alltrim(cUser)
    cSenha    := Alltrim(cSenha)
    nRetPsw   := PswAdmin(cUser, cSenha)

    If nRetPsw == 0 .and. ! cUser $ "ATENDCONSULTA,SYSTEM"   //usuario admin
        lRet     := .T.
        __lAdmin := .T.
    Elseif nRetPsw == 2  //senha invalida 
        FWAlertWarning("Senha e/ou usuario invalidos!")
        lRet:= .F.
    Elseif nRetPsw == 1 .or. cUser == "ATENDCONSULTA" .Or. cUser == "SYSTEM"  // usuario não admin
        FWAlertWarning('O usuário não é admin!')
        lRet        := .F.
    Endif

    If lRet 
        aUser	:= PswRet()
        cUserID := aUser[1, 1]
        __cNome := aUser[1, 4]
        __cUser := cUserID
    EndIf 

Return lRet 








Static Function InitEmp(oTMsgItem)
    Local cAliasExqr 
    Local cAliasTst
    Local np  
    Local cEmpNew := ""
    Local cFilNew := ""
        

    If ! FWAlertYesNo("Confirma a mudança de Empresa e/ou Filial?") 
        Return  
    EndIf 

    For np:= 1 to 5
        cAliasExqr := __aAliasExp[np]
        cAliasTst  := __aAliasTst[np]

        //fechando os browsers da querys
        If Valtype(__aQryBrw[np])=='O'
            __aQryBrw[np]:Hide()
            __aQryBrw[np]:FreeChildren()
            FreeObj(__aQryBrw[np])
            __aQryBrw[np]:= NIL 
        EndIf
        If Select(cAliasExqr) > 0
            (cAliasExqr)->(DbCloseArea())
        EndIf
        If Select(cAliasTst) > 0
            (cAliasTst)->(DbCloseArea())
        EndIf

        //fechando os browses da tabelas
        cAliasTst  := __aDicTst[np]
        If ValType(__aDicBrw[np])=='O'
            __aDicBrw[np]:Hide()
            __aDicBrw[np]:FreeChildren()
            FreeObj(__aDicBrw[np])
            __aDicBrw[np]:= NIL 
        EndIf
        If Select(cAliasTst) > 0
            (cAliasTst)->(DbCloseArea())
        EndIf
    Next 
    

    If !SelEmp(@cEmpNew, @cFilNew, , .F.)
        Return .F.
    Endif

    __cInterNet := Nil
    lmshelpauto := .F.

   TIDesMon( "### TOTVS TI DEVELOPER ###" )
    oTMsgItem:SetText("Empresa: " + cEmpAnt + " Filial: " + cFilAnt)
    oTMsgItem:Refresh()

Return .T.


/*
#################################################################################################################################
Aba de query
#################################################################################################################################

*/

Static Function FolderQry(oDlg, np)
    Local oPS
    Local oBPS1
    Local oBPS2
    Local oBPS3
    Local oBPS4
    Local oBPS5
    Local oBPS6
    Local oBPS7
    Local oBPS8
    Local oBPS9
    Local oBPS10
    Local oBPS11
    
    Local oPSL
    Local oPSLB
    Local oFQry
    Local oMemoL
    Local cMemoL  := ""
    Local oPSR
    Local oPSRB 
    Local oMemoR
    Local cMemoR  := ""    
    Local oMemoR2
    Local cMemoR2 := ""    
    Local oSV

    Local oPI
    Local oPIB
    Local oBPI1
    Local oBPI2
    Local oBPI3
    Local oBPI4
    Local oBPI5
    Local oPIL
    Local oPIM
    
    Local oMsg
    Local cMsg := ""
    
    Local oSH
    Local oFont  := TFont():New("Consolas",, 20,, .F.,,,,, .F., .F.)
    Local oFontB := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)

    __aAliasExp[np] := MyNextAlias()
    __aAliasTST[np] := MyNextAlias()

    oPS:= TPanelCss():New(,,, oDlg)
    oPS:SetCoors(TRect():New(0, 0, __nHeight * 0.4, __nWidth))
    oPS:Align :=CONTROL_ALIGN_ALLCLIENT
    
        oPSL:= TPanelCss():New(,,, oPS)
        oPSL:SetCoors(TRect():New(0, 0, __nHeight * 0.4, __nWidth * 0.5 ))
        oPSL:Align :=CONTROL_ALIGN_ALLCLIENT
            oPSLB:= TPanelCss():New(,,, oPSL)
            oPSLB:SetCoors(TRect():New(0, 0, 30, __nWidth))
            oPSLB:Align :=CONTROL_ALIGN_TOP

                oBPS1  := THButton():New(002, 002, "Executar"   , oPSLB, {|| QryRun(@cMemoL, oPIL, np, oMsg)   }, 50, 10, oFontB, "Executa as linhas com macro") 
                oBPS2  := THButton():New(002, 052, "Abrir"      , oPSLB, {|| FileLoad(@cMemoL)                }, 40, 10, oFontB, "Abrir arquivo sql") 
                oBPS3  := THButton():New(002, 092, "Salvar"     , oPSLB, {|| FileSave(cMemoL)                 }, 40, 10, oFontB, "Salvar arquivo sql") 
                oBPS4  := THButton():New(002, 132, "ChangeQuery", oPSLB, {|| cMemoL := ChangeQuery(cMemoL)    }, 60, 10, oFontB, "Aplicar Change Query") 
                oBPS5  := THButton():New(002, 192, "SqlToAdvpl" , oPSLB, {|| cMemoR := Sql2Advpl(cMemoL, oPSR), cMemoR2 := Sql2Embed(cMemoL, oPSR)}, 60, 10, oFontB, "Gerar código Advpl") 
                oBPS6  := THButton():New(002, 252, "Format"     , oPSLB, {|| cMemoL := FormatSql(cMemoL)      }, 40, 10, oFontB, "Formatar Query") 
                oBPS7  := THButton():New(002, 292, "Histórico"  , oPSLB, {|| MenuQuery(@cMemoL, oBPS7, np)    }, 50, 10, oFontB, "Lista com o histórico") 
                oBPS8  := THButton():New(002, 332, "Limpar"     , oPSLB, {|| cMemoL := ""                     }, 50, 10, oFontB, "Limpa memo da query") 
                                
            oMemoL := tMultiget():new(,, bSETGET(cMemoL), oPSL)
            oMemoL:Align := CONTROL_ALIGN_ALLCLIENT
            oMemoL:oFont:=oFont

        oPSR:= TPanelCss():New(,,, oPS)
        oPSR:SetCoors(TRect():New(0, 0, __nHeight * 0.4, __nWidth * 0.5 ))
        oPSR:Align :=CONTROL_ALIGN_RIGHT
        oPSR:lVisibleControl := .F.
            oPSRB:= TPanelCss():New(,,, oPSR)
            oPSRB:SetCoors(TRect():New(0, 0, 30, __nWidth))
            oPSRB:Align :=CONTROL_ALIGN_TOP

                oBPS9  := THButton():New(002, 002, "AdvplToSql"      , oPSRB, {|| cMemoL := Advpl2Sql(@cMemoR)     }, 60, 10, oFontB, "Gera código Sql") 
                oBPS10 := THButton():New(002, 062, "Embedded"        , oPSRB, {|| cMemoR2:= ToEmbedded(@cMemoR)    }, 80, 10, oFontB, "Converte Advpl (cQuery) para o formato Embedded") 
                oBPS11 := THButton():New(002, 142, "cQuery"          , oPSRB, {|| cMemoR := TocQuery(@cMemoR2)      }, 80, 10, oFontB, "Converte Embedded para o formato Advpl (cQuery)") 

            oFQry := TFolder():New(, , {"cQuery", "Embedded"}, {"cQuery", "Embedded"}, oPSR, , , , .T., .F.)
            oFQry:Align := CONTROL_ALIGN_ALLCLIENT
            
            oMemoR := tMultiget():new(,, bSETGET(cMemoR), oFQry:aDialogs[1])
            oMemoR:Align := CONTROL_ALIGN_ALLCLIENT
            oMemoR:oFont:=oFont

            oMemoR2 := tMultiget():new(,, bSETGET(cMemoR2), oFQry:aDialogs[2])
            oMemoR2:Align := CONTROL_ALIGN_ALLCLIENT
            oMemoR2:oFont:=oFont

    


        @ 000,000 BUTTON oSV PROMPT "*" SIZE 4,4 OF oPS PIXEL
        oSV:cToolTip := "Habilita e desabilita Advpl-SQL " // sql sandro
        oSV:bLClicked := {|| oPSR:lVisibleControl := !oPSR:lVisibleControl }
        oSV:Align := CONTROL_ALIGN_RIGHT
        oSV:nClrText :=0

    oPI:= TPanelCss():New(,,, oDlg)
    oPI:SetCoors(TRect():New(0, 0, __nHeight * 0.6, __nWidth))
    oPI:Align :=CONTROL_ALIGN_BOTTOM

        oPIB:= TPanelCss():New(,,, oPI)
        oPIB:SetCoors(TRect():New(0, 0, 30, __nWidth))
        oPIB:Align :=CONTROL_ALIGN_TOP
            oBPI1  := THButton():New(002, 002, "CSV"         ,oPIB, {|| ExportCSV(nP, oMsg)      }, 40, 10, oFontB, "Salva query no formato CSV") 
            oBPI2  := THButton():New(002, 042, "XML"         ,oPIB, {|| ExportXml(nP, oMsg)      }, 40, 10, oFontB, "Salva query utilizando FWMSEXCEL formato XML") 
            oBPI3  := THButton():New(002, 082, "Excel"       ,oPIB, {|| ExportExcel(nP, oMsg)    }, 40, 10, oFontB, "Salva query utilizando TIExcel formato XLS (DBF4)")
            If __lAdmin  
                oBPI4  := THButton():New(002, 122, "Exec Macro"  ,oPIB, {|| ExecRotQry(np, cMemoL)           }, 40, 10, oFontB, "Executa a macro para cada linha do browse") 
            EndIf 
            oBPI5  := THButton():New(002, 162, "Count"       ,oPIB, {|| CountQuery(cMemoL, oMsg) }, 40, 10, oFontB, "Retorna a quantidade de linhas da query") 
            

        oPIL:= TPanelCss():New(,,, oPI)
        oPIL:SetCoors(TRect():New(0, 0, 30, __nWidth))
        oPIL:Align :=CONTROL_ALIGN_ALLCLIENT


        oPIM:= TPanelCss():New(,,, oPI)
        oPIM:SetCoors(TRect():New(0, 0, 30, __nWidth))
        oPIM:Align :=CONTROL_ALIGN_BOTTOM
            @ 002, 002 SAY oMsg VAR cMsg SIZE 600,010 OF oPIM PIXEL FONT oFont

    @ 000,000 BUTTON oSH PROMPT "*" SIZE 5,5 OF oDlg PIXEL
    oSH :cToolTip := "Habilita e desabilita browser"
    oSH:bLClicked := {|| oPI:lVisibleControl 	:= !oPI:lVisibleControl}
    oSH:Align := CONTROL_ALIGN_BOTTOM
    oSH:nClrText :=0

    __abTelQry[np] := {|| AtuFolQry(oPI, oPSR)}
   

Return 

Static Function AtuFolQry(oPI, oPSR)
    oMainWnd:ReadClientCoors()

    __nHeight := oMainWnd:nHeight - 100
    __nWidth  := oMainWnd:nWidth - 20

    oPI:SetCoors(TRect():New(0, 0, __nHeight * 0.6, __nWidth))
    oPSR:SetCoors(TRect():New(0, 0, __nHeight * 0.6, __nWidth * 0.5 ))

Return 



Static Function FileSave(cMemoL)
    Local cFile := ''

    cFile := MyGetFile("Arquivos query (*.query) |*.query|","Informe o arquivo", 0, "C:\", .F., GETF_LOCALHARD + GETF_LOCALFLOPPY + GETF_NETWORKDRIVE)
    If ! empty(cFile)
        If Right(Upper(cFile), 6) <> ".QUERY"
            cFile += ".query"
        EndIf
        MemoWrit(cFile, cMemoL)
    EndIf

Return

Static Function FileLoad(cMemoL)
    Local cFile := ''

    cFile := MyGetFile( "Arquivos query (*.query) |*.query|" , "Selecione o arquivo", 1, "C:\", .T., GETF_LOCALHARD + GETF_LOCALFLOPPY + GETF_NETWORKDRIVE )
    If ! empty(cFile)

        cMemoL:= MemoRead(cFile)
    EndIf

Return

Static Function Sql2Advpl(cQuery, oPSR)
    Local aQry   := StrTokArr(cQuery, CRLF)
    Local nX     := 0
    Local cLinha := ""
    Local cRet   := ""
    cRet:= 'cQuery := " "'+CRLF

    For nX:= 1 to Len(aQry)
        cLinha := aQry[nX] + Space(1)
        If Empty(cLinha)
            Loop 
        EndIf 

        cLinha := TrataNome(cLinha, .t.)
        cLinha := TrataFilial(cLinha, .t.)

        cRet += 'cQuery += " '+(cLinha)+' " '+CRLF
        
    Next
    oPSR:lVisibleControl := .T.
Return cRet

Static Function TrataNome(cLinha, lQuery)
    Local nx    := 0
    Local cWord := ""
    Local cByte := ""
    Local aFiliais := {{"000"},{"010"}, {"020"}, {"030"}, {"040"}, {"050"}, {"060"}, {"070"}, {"080"}, {"090"}, {"099"}}

    For nx:= 1 to Len(cLinha)
        cByte := Upper(Substr(cLinha, nx, 1))
        If Upper(cByte) $ "_ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
            cWord += cByte
            Loop 
        EndIf 
        If Len(cWord) != 6
            cWord :=''
            Loop 
        EndIf 
        If ! (Left(Upper(cWord), 1) $ "ABCDEFGHIJKLMNOPQRSTUVWXYZ" .and. Subs(Upper(cWord), 2, 1) $ "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
            cWord :=''
            Loop 
        EndIf 
        If AScan(aFiliais,{|x| x[1] ==  Right(cWord, 3)}) > 0
            If lQuery
                cWord  := '" + RetSQLName("' + Upper(Left(cWord,3)) + '") + "'
            Else 
                cWord := " %table:" + Upper(Left(cWord, 3)) + "%"
            EndIf 
            cLinha :=  Left(cLinha, nx - 7) + cWord + Substr(cLinha, nx)
        EndIf 
        cWord :=''
    Next

Return cLinha



Static Function TrataFilial(cLinha, lQuery)
    Local nx     := 0
    Local cWord  := ""
    Local cByte  := ""
    Local cAlQry := ""
    Local lAspas := .F. 
    Local cAux   := ""
    Local cByte2 := ""
    Local ny     := 0
    Local cSufix := ""
    Local nIAspas:= 0
    
    
    For nx:= 1 to Len(cLinha)
        cByte := Upper(Substr(cLinha, nx, 1))
        If Upper(cByte) $ "_ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
            cWord += cByte
            Loop 
        EndIf 
        If Right(cWord, 7) != "_FILIAL"
            cWord :=''
            Loop 
        EndIf 
        cAlQry := Left(cWord, At("_", cWord) - 1)
        If Len(cAlQry) == 2
            cAlQry := "S" + cAlQry
        EndIf 
        lAspas := .f.
         
        cAux := Subs(cLinha, nx)

        For ny := 1 to len(cAux)
            cByte2 := Upper(Substr(cAux, ny, 1))
            If ! cByte2 $ " ='" + '"'
                Exit 
            EndIf 
            If cByte2 $ "'" + '"' .and. ! lAspas
                nIAspas := ny
                lAspas := .t. 
            ElseIf cByte2 $ "'" + '"' .and. lAspas
                If lQuery
                    cSufix := "'" + '" + FwxFilial("' + cAlQry + '") + "' + "'"   
                Else 
                    cSufix := "%xfilial:" + cAlQry + "%" 
                EndIf 
                cLinha := Left(cLinha, nx + nIAspas - 2) + cSufix + Substr(cLinha, nx + ny)
                lAspas := .f.     
            EndIf  
        Next
        cWord :=''
    Next

Return cLinha

Static Function TrataDelete(cLinha)
    cLinha := StrTran(cLinha, "D_E_L_E_T_ = ' '", "%notDel%")
    cLinha := StrTran(cLinha, "D_E_L_E_T_=' '"  , "%notDel%")
    cLinha := StrTran(cLinha, "D_E_L_E_T_= ' '" , "%notDel%")
    cLinha := StrTran(cLinha, "D_E_L_E_T_ =' '" , "%notDel%")
Return cLinha


Static Function Sql2Embed(cQuery, oPSR)
    Local aQry := StrTokArr(cQuery, CRLF)
    Local nX := 0
    Local cLinha   := ""
    Local cRet     := ""
    
    cRet:= "BEGINSQL ALIAS 'ALIASTEMP'" + CRLF

    For nX:= 1 to Len(aQry)
        cLinha := aQry[nX] + Space(1)
        If empty(cLinha)
            Loop 
        EndIf 

        cLinha := TrataNome(cLinha, .f.)
        cLinha := TrataFilial(cLinha, .f.)
        cLinha := TrataDelete(cLinha)
        cRet += "    " + (cLinha) + CRLF
    
    Next
    cRet+= "ENDSQL" + CRLF
    If oPSR != NIL 
        oPSR:lVisibleControl := .T.
    EndIf
Return cRet

Static Function TrocaEmbb(cFormat)
    Local aQry   := StrTokArr(cFormat, CRLF)
    Local nX     := 0
    Local cLinha := ""
    Local cRet   := ""

    For nX:= 1 to Len(aQry)
        cLinha := aQry[nX] + Space(1)
        If Empty(cLinha)
            Loop 
        EndIf 

        cLinha := TrocaNome(cLinha)
        cRet += cLinha + CRLF
        
    Next
Return cRet

Static Function TrocaNome(cLinha)
    Local nx    := 0
    Local cWord := ""
    Local cByte := ""
    Local nLen  := 0
    
    
    While nx <= len(cLinha)
        nx++ 
        cByte := Upper(Substr(cLinha, nx, 1))
        If Upper(cByte) $ "_ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890%:"
            cWord += cByte
            Loop 
        EndIf 
       
        If Left(cWord, 7) == "%TABLE:"
            nLen  :=  len(cWord)
            cWord := Subs(cWord, 8)
            cWord := Left(cWord, len(cWord) - 1)
            cWord  := RetSQLName(Upper(cWord))
            
            cLinha :=  Left(cLinha, nx - nLen - 1) + cWord + Substr(cLinha, nx)
        EndIf 
        If Left(cWord, 9) == "%XFILIAL:"
            nLen  :=  len(cWord)
            cWord := Subs(cWord, 10)
            cWord := Left(cWord, len(cWord) - 1)
            cWord  := "'" + xFilial(cWord) + "'"
            
            cLinha :=  Left(cLinha, nx - nLen - 1) + cWord + Substr(cLinha, nx)
        EndIf   
        If cWord == "%NOTDEL%"
            nLen  :=  len(cWord)
            cWord  := "D_E_L_E_T_ = ' '"
            cLinha :=  Left(cLinha, nx - nLen - 1) + cWord + Substr(cLinha, nx)
        EndIf               
        If cWord == "%RECNO%"
            nLen  :=  len(cWord)
            cWord  := "R_E_C_N_O_"
            cLinha :=  Left(cLinha, nx - nLen - 1) + cWord + Substr(cLinha, nx)
        EndIf               

        cWord :=''
    End 

Return cLinha




Static Function FormatSql(cFormat)
    Local cQry := ""
    Local cAux := ""
    Local cWord:= ""
    Local aQry := {}
    Local nX   := 0
    Local cLinha:= ''
    Local cByte:= ""
    Local nSelect:= 0

    cFormat := TrocaEmbb(cFormat)
    cFormat := ChangeQuery(cFormat)

    aQry := StrTokArr(cFormat, CRLF)
    For nx := 1 to len(aQry)
        cLinha := aQry[nx]
        cLinha := StrTran(cLinha, CHR(9) , " ")
        cLinha := Alltrim(cLinha)
        cLinha := Upper(cLinha)
        cQry += cLinha+" "
    Next

    cAux := ""
    aQry := {}
    For nX:= 1 to len(cQry)
        cByte := Subs(cQry, nX    , 1)
        cByte2:= Subs(cQry, nX + 1, 1)
        cByte3:= Subs(cQry, nX + 2, 1)

        If Upper(cByte) $ "_ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
            cWord += cByte
        Else
            If len(cword) > 0 .and.  ;
                    (" " + cWord + "#"        $ " SELECT# FROM# WHERE#" .or.;
                    " " + cWord + cByte + "#"  $ " AND # OR # NOT # INNER # LEFT # RIHGT # ON #"   .or.;
                    " " + cWord + cByte + cByte2 + cByte3 + "#" $ " ORDER BY#" .or.;
                    " " + cWord + cByte + cByte2 + cByte3 + "#" $ " GROUP BY#" )

                cLinha:= Left(cAux, len(cAux) - len(cWord))
                If ! Empty(cLinha)
                    aadd(aQry, cLinha)
                EndIf

                cAux := cWord

            EndIf
            cWord:= ""
        EndIf
        cAux += cByte
        If nX==len(cQry) .and. ! Empty(cAux)
            cLinha:= cAux
            If ! Empty(cLinha)
                aadd(aQry, cLinha)
            EndIf
        EndIf
    Next

    nSelect := -1
    For nx := 1 to len(aQry)
        cLinha := aQry[nx]
        If "SELECT " $ cLinha
            nSelect++
        EndIf
        cLinha := Alltrim(cLinha) + " "
        cLinha := Upper(cLinha)

        cLinha := If(Left(cLinha, 4) == "AND "," " + cLinha, cLinha)
        cLinha := If(Left(cLinha, 3) == "OR " ," " + cLinha, cLinha)
        cLinha := If(Left(cLinha, 3) == "ON " ," " + cLinha, cLinha)
        cLinha := If(Left(cLinha, 4) == "NOT "," " + cLinha, cLinha)

        //cLInha := StrTran(cLinha, "SELECT " ,  "SELECT ")
        cLinha := StrTran(cLinha, "FROM "   ,  "FROM   ")
        cLinha := StrTran(cLinha, "WHERE "  ,  "WHERE ")
        cLinha := StrTran(cLinha, " AND "   , "       AND ")
        cLinha := StrTran(cLinha, " OR "    , "        OR ")
        cLinha := StrTran(cLinha, " ON "    , "        ON ")
        cLinha := StrTran(cLinha, " NOT "   , "       NOT ")
        cLinha := Repl(" ", Max(nSelect * 7, 0) ) + cLinha
        aQry[nx] := cLinha
        If "WHERE " $ cLinha
            nSelect--
        EndIf
    Next

    cQry := ""
    For nx:=1 to len(aQry)
        cQry += aQry[nx] + CRLF
    Next

Return cQry

Static Function MenuQuery(cCMD, oOwner, np)
    Local nX := 0
    Local oMenu
    
    Local cAux    := ''
    Local bBlock  :={||}
    Local cSufix  := ""
    default np := 1

    cSufix := "query" + Str(np, 1)
    
    LeHst(__aHstQry[np], cSufix)

    oMenu := tMenu():new(0, 0, 0, 0, .T., , oOwner)
    oMenu:Add(tMenuItem():new(oMenu, "Excluir"         , , , , {|| If(FWAlertYesNo("Confirma a exclusão?")            , (GrvHst(__aHstQry[np], cSufix, cCMD, .F., .T. ), .t. ), .t.) }, , , , , , , , , .T.))
    oMenu:Add(tMenuItem():new(oMenu, "Limpar Histórico", , , , {|| If(FWAlertYesNo("Confirma a limpeza do histórico?"), (GrvHst(__aHstQry[np], cSufix, ""  , .T., .F. ), .t. ), .t.) }, , , , , , , , , .T.))

    For nX := Len(__aHstQry[np]) To 1 Step -1
        cAux := cValToChar(nX)+ ". " + Left( Alltrim (__aHstQry[np, nX]), 120)
        bBlock:=&('{|| cCMD:= __aHstQry[' + Str(np) +'][' + str(nX) + ']}')
        oMenu:Add(tMenuItem():new(, cAux, , , , bBlock, , , , , , , , , .T.))
    Next
    oMenu:Activate(NIL, 21, oOwner)

Return


Static Function Advpl2Sql(cTrb)
    Local aQry := StrTokArr(QryTrim(cTrb), CRLF)
    Local nX := 0
    Local xAux :=""
    Local cBrkLine:=""
    Local cRet :=""
    Local bErroA

    bErroA	:= ErrorBlock( { |oErro| ChkErr( oErro , .T. ) } )
    Begin Sequence

        for nX:= 1 to Len(aQry)
            If !empty(aQry[nX])
                aQry[nX]:= Alltrim(aQry[nX])
                If Right(aQry[nX], 1)== ';'
                    cBrkLine += SubStr(aQry[nX], 1, len(aQry[nX]) - 1)
                    loop
                EndIf
                xAux := &(cBrkLine + aQry[nX])
                cBrkLine := ''
                If Valtype(xAux) == 'C'
                    cRet := xAux
                EndIf
            EndIf
        next
    End Sequence
    ErrorBlock( bErroA )

    If ! Empty(__cErroA)
        If ":=" $ __cErroA
            If  ! __cErroA $ cTrb
                cTrb := __cErroA + cTrb
            Endif
            cRet := ""
        Else
            cRet := __cErroA
        EndIf
        __cErroA :=""
    EndIf

    cRet := FormatSql(cRet)

Return cRet

Static Function QryTrim(cQuery)
    Local cA := ""
    Local nx := 0
    Local aQry := StrTokArr(cQuery, CRLF)
    Local cLinha := ""

    For nx:=1 to len(aQry)
        cLinha :=aQry[nx]
        cLinha := StrTran(cLinha, chr(9), "")
        cLinha := StrTran(cLinha, "+CRLF", "")
        cLinha := StrTran(cLinha, "+ CRLF", "")
        cLinha := Alltrim(cLinha)
        cA += cLinha + CRLF
    Next
    cQuery := cA

Return cA



Static Function ToEmbedded(cTrb)
    Local cSQL := ""

    cSQL := Advpl2Sql(@cTrb)

    cSQL := Sql2Embed(cSQL)
    
Return cSQL



Static Function TocQuery(cQuery)
    Local aQry   := StrTokArr(cQuery, CRLF)
    Local nX     := 0
    Local cLinha := ""
    Local cRet   := ""
    Local cAlSql := ""
    Local cSqlName := ""
    Local cSufix   := ""
         
    cRet:= 'cQuery := " "' + CRLF

    For nX:= 1 to Len(aQry)
        cLinha := aQry[nX] + Space(1)
        If Empty(cLinha)
            Loop 
        EndIf 
        cLinha := StrTran(cLinha, chr(9), "")
        If Left(Alltrim(Upper(cLinha)), 8) == "BEGINSQL"
            Loop 
        EndIf 
        If Left(Alltrim(Upper(cLinha)), 6) == "ENDSQL"
            Loop 
        EndIf 

        // TRATAR O NOME        
        While .t.
            np := At(Upper("%table:"), Upper(cLinha) ) 
            If np ==0 
                Exit 
            EndIf 
            cAlSql    := subs(cLinha, np + 7, 3)
            cSqlName  := '" + RetSQLName("' + Upper(Left(cAlSql, 3)) + '") + "'
            cLinha    := Left(cLinha, np - 1) + cSqlName + subs(cLinha, np + 11 )  
        End 

        // TRATAR O FILIAL        
        While .t.
            np := At(Upper("%xfilial:"), Upper(cLinha) ) 
            If np ==0 
                Exit 
            EndIf 
            cAlSql    := subs(cLinha, np + 9, 3)
            cSufix    := "'" + '" + FwxFilial("' + cAlSql + '") + "' + "'"
            cLinha    := Left(cLinha, np - 1) + cSufix + subs(cLinha, np + 13 )  
        End 

        //trata expressao %exp:cPrefixo%
        While .t.
            np := At(Upper("%exp:"), Upper(cLinha) ) 
            If np ==0 
                Exit 
            EndIf 
            cAux      := subs(cLinha, np + 5)
            np2 := At("%", cAux)
            If np2 ==0 
                Exit 
            EndIf 
            cVarExp   := Left(cAux, np2 - 1)
            cLinha    := Left(cLinha, np - 1) + cVarExp + subs(cLinha, np + np2 + 5 )  
        End

        cLinha := StrTran(cLinha, "%notDel%", "D_E_L_E_T_ = ' '")

        cLinha  := 'cQuery += " '+ (cLinha)
        If Right(Alltrim(cLinha) , 1) != '"'
            cLinha += ' " ' 
        EndIf 
        cRet += cLinha + CRLF
        
    Next

Return cRet



Static Function QryRun(cMemoL, oPSR, np, oMsg)

    cMemoL:= TrocaEmbb(cMemoL)

    MsgRun("Executando query...","Aguarde..." , {|| PQryRun(cMemoL, oPSR, np, oMsg) } )

Return

Static Function PQryRun(cQuery, oPSR, np, oMsg)
    Local nX := 0

    Local aStruct:= {}
    Local bErroA
    Local cErro:= ''

    Local aArea := {}
    Local nSec1 := 0
    Local nSec2 := 0
    Local cMsgT := ""
    Local cComando:=""
    Local aComando:={}
    Local cNoSelect:= ""
    Local cDir
    Local aEstruAux := {}
    Local cAliasExqr := __aAliasExp[np]
    Local cAliasTst  := __aAliasTst[np]
    Local cSufix := "query" + Str(np, 1)
    Local oFont := TFont():New('Arial',, -11, .T., .T.)

    Local cCampo := ""
    Local cTipo  := ""
    Local nTam   := 0
    Local nDec   := 0
    Local cPict  := ""
    Local aTamSx3:= {}
    Local cFCria := ""
    Local cQryBKP := cQuery

    cQuery:= QryUpper(cQuery)

    oMsg:SetText("")
    oMsg:Refresh()
    ProcessMessage()
    
    If Empty(cQuery)
        oMsg:SetText("Query branco!!!")
        Return 
    EndIf 
    
    LimpaTmp()

    cComando := Left(cQuery, At(" ",cQuery) -1)

    If ! cComando == "SELECT" 
        If ! __lAdmin
           FWAlertWarning("Acesso somente de leitura!")
           Return
        EndIf 
        If ! FWAlertNoYes('Confirma a execução do ' + cComando + ' no banco?','Atenção')
            Return
        EndIf 

        If "TIDEVLOG" $ cQuery
           FWAlertWarning("Não é permitido manipular a tabela TIDEVLOG!")
           Return
        EndIf 
        
    EndIf

    GrvHst(__aHstQry[np], cSufix, cQuery)

    aArea := GetArea()
    If Valtype(__aQryBrw[np])=='O'
        __aQryBrw[np]:Hide()
        __aQryBrw[np]:FreeChildren()
        FreeObj(__aQryBrw[np])
        __aQryBrw[np]:= NIL 
    EndIf

    If Select(cAliasExqr) > 0
        (cAliasExqr)->(DbCloseArea())
    EndIf

    If Select(cAliasTst) > 0
        (cAliasTst)->(DbCloseArea())
    EndIf

    __cErroA :=""
    bErroA	:= ErrorBlock( { |oErro| ChkErr( oErro ) } )
    Begin Sequence
        If ! cComando == "SELECT"
            cNoSelect := strtran(cQuery,CRLF,'')
            cNoSelect := AllTrim(cNoSelect)
            If Right(cNoSelect,1) == ";"
                cNoSelect := left(cNoSelect,Len(cNoSelect) - 1)
            EndIf
            
            nSec1 := Seconds()
            aComando := StrTokArr(cNoSelect, ";")
            For nx:= 1 to len(aComando)
                If TcSqlExec(aComando[nx]) < 0
                    __cErroA:="TCSQLError() " + TCSQLError()
                    Break
                EndIf
            Next
            TcSQLExec( "COMMIT" )
            nSec2 := Seconds()

            If nSec2 >= nSec1 
                cMsgT :=  "Tempo de Execução: " + APSec2Time(nSec2 - nSec1) + " (" + Alltrim(Str(nSec2 - nSec1)) + " segs.)"
            EndIf 
            oMsg:SetText(cMsgT +  " | Query Executada! | Quantidade de comandos processados: " + AllTrim(Str(len(aComando))))
            FWAlertSuccess("Query executada!")

            
            IncLog("QUERY", "", cQryBKP)

        Else
         
            nSec1 := Seconds()
            dbUseArea(.T.,'TOPCONN', TCGenQry(,, cQuery), cAliasTst, .F., .T.)
            //DBUseArea(.T., "TOPCONN", TCGenQry2(NIL,NIL, cQuery, {} ), cAliasTst , .F., .T. ) // NÃO MUDOU NADA A PERFORMACE
            nSec2 := Seconds()

          
            If nSec2 >= nSec1 
                cMsgT :=  "Tempo de Execução: " + APSec2Time(nSec2 - nSec1) + " (" + Alltrim(Str(nSec2 - nSec1)) + " segs.)"
            EndIf 
            oMsg:SetText(cMsgT)

            aStruct := (cAliasTst)->(dbStruct())
            For nx:= 1 to len(aStruct)
                If aStruct[nx,2] == "N"
                    aStruct[nx,3] := 30
                    aStruct[nx,4] := 4
                EndIf
            Next

            cDir := "system\tidev\"
            If ! ExistDir(cDir)
                MakeDir(cDir)
            Endif

            For nx:= 1 to len(aStruct)
                aadd(aEstruAux, {"Cmp"+StrZero(nx, 3) , aStruct[nx, 2], aStruct[nx, 3], aStruct[nx, 4]}  )
            Next
            cFCria := "db" + "Create"
            &(cFCria)(cDir + cAliasExqr, aEstruAux )

            dbUseArea( .T., "DBF" + "CDX", cDir + cAliasExqr, cAliasExqr, .F., .F. )

            __aQryBrw[np] := MsBrGetDBase():New(1, 1, __DlgWidth(oPSR)-1, __DlgHeight(oPSR) - 1,,,, oPSR,,,,,,, oFont ,,, ,         , .F. , cAliasExqr, .T.,, .F.,,,)
            
            For nX:=1 To (cAliasExqr)->(FCount())
                cCampo := aStruct[nx, 1]
                aTamSx3 := TamSX3(cCampo)
                If ! Empty(aTamSx3)
                    cTipo  := aTamSx3[3]
                    nTam   := aTamSx3[1]
                    nDec   := aTamSx3[2]
                Else 
                    cTipo  := aEstruAux[nx, 2]
                    nTam   := aEstruAux[nx, 3]
                    nDec   := aEstruAux[nx, 4]
                EndIf 
                If cCampo == "R_E_C_N_O_" .OR. cCampo == "R_E_C_D_E_L_"
                    nDec := 0
                EndIf 

                If cTipo == "N"
                    cPict  := ""
                    If nDec > 0
                        cPict := Repl("9", nTam - nDec + 1)  + "." + Repl("9", nDec) 
                    Else
                        cPict := Repl("9", nTam ) 
                    EndIf 
                    
                    __aQryBrw[np]:AddColumn( TCColumn():New( (cAliasTst)->(Field(nx)) , &("{ || " + cAliasExqr + "->" + (cAliasExqr)->(FieldName(nX)) + "}"), cPict,,,, "RIGHT"))
                ElseIf cTipo == "L"
                    __aQryBrw[np]:AddColumn( TCColumn():New( aStruct[nx, 1], &("{ || " + cAliasExqr + "->" + (cAliasExqr)->(FieldName(nX)) + "}"), "@!",,,, "LEFT"))
                ElseIf cTipo == "C"     
                    __aQryBrw[np]:AddColumn( TCColumn():New( aStruct[nx, 1], &("{ || " + cAliasExqr + "->" + (cAliasExqr)->(FieldName(nX)) + "}"), "@!",,,, "LEFT"))
                ElseIf cTipo == "D"
                    If Valtype((cAliasExqr)->(FieldGet(nX))) == "D"
                        __aQryBrw[np]:AddColumn( TCColumn():New( aStruct[nx, 1], &("{ || " + cAliasExqr + "->" + (cAliasExqr)->(FieldName(nX)) + "}"), "@E",,,, "CENTER") )
                    Else 
                        __aQryBrw[np]:AddColumn( TCColumn():New( aStruct[nx, 1], &("{ || Stod(" + cAliasExqr + "->" + (cAliasExqr)->(FieldName(nX)) + ")}"), "@E",,,, "CENTER") )
                    EndIf 
                ElseIf cTipo == "M"
                    __aQryBrw[np]:AddColumn( TCColumn():New( aStruct[nx, 1], { || "Memo" },,,,,.F.) )
                EndIf 
            Next nX

            Query2Tmp(cAliasTst, cAliasExqr)

            __aQryBrw[np]:lColDrag	 := .T.
            __aQryBrw[np]:lLineDrag	 := .T.
            __aQryBrw[np]:lJustific	 := .T.
            __aQryBrw[np]:nColPos	 := 1
            __aQryBrw[np]:Cargo		 := {|| __NullEditcoll()}
            __aQryBrw[np]:bSkip		 := &("{|N| Query2Tmp('"+cAliasTst+"', '"+cAliasExqr+"', N), "+cAliasExqr+"->(_DBSKIPPER(N))}")
            __aQryBrw[np]:Align      := CONTROL_ALIGN_ALLCLIENT
            __aQryBrw[np]:bLDblClick := {|| AltReg(__aQryBrw[np], cAliasExqr, .t.) }
            __aQryBrw[np]:bChange    := {|| AtuQry(__aQryBrw[np]) }

        EndIf

    End Sequence
    ErrorBlock( bErroA )

    If ! Empty(__cErroA)
        cErro := __cErroA
        AutoGrLog("")
        FErase(NomeAutoLog())
        AutoGrLog(cErro)
        MostraLog()
        __cErroA :=""
        oMsg:SetText("Erro de execução da query!!!")
    EndIf
    RestArea(aArea)
Return

Static Function LimpaTmp()
    Local cDir1 := "system\tidev\"
    Local cDir2:= "system\tidev\ctreeint\"
    Local nx 
    Local aDir1 := Directory(cDir1 + "*.*")
    Local aDir2 := Directory(cDir2 + "*.*")
    Local cFile := ""
    Local dData := ctod("")
    Local nHr1  := 0
    Local nHr2  := 0

    For nx:= 1 to len(aDir1)
        cFile := aDir1[nx, 1]
        dData := aDir1[nx, 3]
        nHr1  := Val(Left(aDir1[nx, 4], 2))
        nHr2  := Val(Left(Time(), 2))
        
        If dData == Date()
            If (nHr2 - nHr1) > 3
                FErase(cDir1 + cFile)
            EndIf 
        Else 
            FErase(cDir1 + cFile)
        EndIf 
    Next 

    For nx:= 1 to len(aDir2)
        cFile := aDir2[nx,1]

        FErase(cDir2 + cFile)

    Next 

Return  

Static Function LimpaQry()
    Local np
    Local cAliasExqr
    Local cDir := "system\tidev\"
     
    For np:= 1 to 5
        cAliasExqr := __aAliasExp[np]

        //fechando os browsers da querys
        If Valtype(__aQryBrw[np])=='O'
            __aQryBrw[np]:Hide()
            __aQryBrw[np]:FreeChildren()
            FreeObj(__aQryBrw[np])
            __aQryBrw[np]:= NIL 
        EndIf
        If Select(cAliasExqr) > 0
            (cAliasExqr)->(DbCloseArea())
        EndIf

        FErase(cDir + cAliasExqr + ".dtc") 

    Next 


Return 


Static Function QryUpper(cQuery)
    Local cQryUpper := ""
    Local cByte     := ""
    Local lUpper    := .T.
    Local nx        := 0

    cQuery := Alltrim(cQuery)

    For nx:= 1 to len(cQuery)

        cByte := subs(cQuery, nx, 1)

        If cByte == "'" 
            If  lUpper
                lUpper := .F. 
            Else 
                lUpper := .T.  
            EndIf 
        EndIf 

        If lUpper 
            cByte := Upper(cByte)
        EndIf 

        cQryUpper += cByte 
    Next 

Return cQryUpper

Static Function MyNextAlias()

    __cSeqTmp := Soma1(__cSeqTmp)

Return  "TI" + Strzero(ThreadId(), 6) + __cSeqTmp

Static Function Query2Tmp(cSource, cTarget, n)
    Local nX
    Local nI		:= 1
    Local nRecno	:= (cTarget)->(Recno())
    Local aFields
    Local nFields

    Default n := __nBuffer

    If (cSource)->(Eof()) .Or. !( n > 0 .And. ( n + (cTarget)->(Recno()) > (cTarget)->(RecCount()) - __nBuffer ) )
        Return
    EndIf

    aFields := (cTarget)->(dbStruct())
    nFields := Len(aFields)

    While (cSource)->(!Eof()) .And. nI <= __nBuffer
        (cTarget)->(dbAppend())
        For nX:=1 To nFields
            If aFields[nX][2] == "N"
                (cTarget)->(fieldput(nX, val(str((cSource)->(Fieldget(nX)), aFields[nX][3], aFields[nX][4]))))
            Else
                (cTarget)->(FieldPut(nX, (cSource)->(Fieldget(nX))))
            EndIf
        Next nX
        nI += 1
        (cSource)->(dbSkip())
    End
    (cTarget)->(dbCommit())
    (cTarget)->(dbGoto(nRecno))
Return

Static Function AtuQry(oBrow)
    //oBrow:Refresh()
    oBrow:callRefresh()
Return 

Static Function ExportCSV(np, oMsg)
    Local cFile := ""
    Local cAliasTst := __aAliasTst[np]
    Local cMsg := ""
    Local nSec1 := 0
    Local nSec2 := 0
    Local cMsgT := ""
    Private lAbortPrint := .F.


    If Select(cAliasTst) == 0
        FWAlertWarning("Execute uma query!!")
        Return .F.
    EndIf

    cFile := MyGetFile("Arquivos (*.csv) |*.csv|","Informe o arquivo", 0, "C:\", .F., GETF_LOCALHARD + GETF_LOCALFLOPPY + GETF_NETWORKDRIVE)

    

    If Empty(cFile)
        Return .F.
    Endif

    If ! Lower(Right(cFile, 4)) == ".csv"
        cFile += ".csv"
    EndIf
    If File(cFile)
        If ! FWAlertYesNo("Confirma a substituição do arquivo?")
            Return .F.
        EndIf
        FErase(cFile)
    EndIF
    
    oMsg:SetText("")
    oMsg:Refresh()
    ProcessMessage()

    nSec1 := Seconds()

    Processa({|| ProcCSV(cAliasTst, cFile)},,,.T.)

    nSec2 := Seconds()

    If nSec2 >= nSec1 
       cMsgT :=  "Tempo de Execução: " + APSec2Time(nSec2 - nSec1) + " (" + Alltrim(Str(nSec2 - nSec1)) + " segs.)"
    EndIf 

    If lAbortPrint
        cMsg := "Geração interrompida, planilha csv com conteudo parcial!"
    Else
        cMsg := "Geração concluida!"
    EndIf
    FWAlertSuccess(cMsg)
    oMsg:SetText(cMsgT + " |Arquivo: " + cFile + " |" + cMsg )
    
    ShellExecute("open", cFile, "", "C:\", 1)

Return

Static Function MyGetFile(cMascara, cTitulo, nMascpadrao, cDirinicial, lSalvar, nOpcoes, lArvore, lKeepCase)
    Local cRet := ""
    Local cGF  := "cGetFile"

    cRet := &(cGF)(cMascara, cTitulo, nMascpadrao, cDirinicial, lSalvar, nOpcoes, lArvore, lKeepCase)

    //cRet := TFileDialog("Arquivos (*.csv)","Informe o arquivo",0,"C:\",.F.)

Return cRet

Static Function ProcCSV(cAliasCSV, cArquivo)
    Local nRec := (cAliasCSV)->(Recno())
    Local nReg := 0

    
    (cAliasCSV)->(GrvCabCSV(cArquivo))

    ProcRegua(1)

    (cAliasCSV)->(DbGoTop())
    While (cAliasCSV)->(! Eof())
        IncProc("Processando linha: " + Alltrim(Str(++nReg, 8)))
        ProcessMessage()
        If lAbortPrint
            Return
        EndIf

        (cAliasCSV)->(GrvLinCSV(cArquivo))

        (cAliasCSV)->(DbSkip())
    End
    (cAliasCSV)->(DbGoTo(nRec))

Return

Static Function GrvCabCSV(cArquivo)
    Local cCab  := ""
    Local aFields := dbStruct()
    Local nFields := Len(aFields)
    Local nx    := 0

    For nx:= 1 to nFields
        cCab +=  aFields[nx, 1] + ";"
    Next
    GrvArq(cArquivo, cCab)
Return 

Static Function GrvLinCSV(cArquivo)
    Local aFields := dbStruct()
    Local nFields := Len(aFields)
    Local cLinha  := "" 
    Local nx      := 0
    
    Default cArquivo := __Export 

    cLinha := ""
    For nx:= 1 to nFields
        If aFields[nX][2] == "N"
            cLinha += StrTran(Padl(cValToChar(FieldGet(nx)) ,20), ".", ",")
        ElseIf aFields[nX][2] == "C"
            cLinha += Fieldget(nX)
        ElseIf aFields[nX][2] == "D"
            cLinha += Dtoc(Fieldget(nX))
        ElseIf aFields[nX][2] == "L"
            cLinha += If(Fieldget(nX), "TRUE","FALSE")
        Else
            cLinha += cValToChar(FieldGet(nx))
        EndIf
        cLinha += ";"
    Next
    GrvArq(cArquivo, cLinha)

Return  

Static Function ExportXml(np, oMsg)
    Local cFile := ""
    Local oExcel
    Local cAliasTst := __aAliasTst[np]
    Local cMsg := ""
    Local nSec1 := 0
    Local nSec2 := 0
    Local cMsgT := ""
    Private lAbortPrint := .F.

    If Select(cAliasTst) == 0
        FWAlertWarning("Execute uma query!!")
        Return .F.
    EndIf

    cFile := MyGetFile("Arquivos query (*.xml) |*.xml|","Informe o arquivo", 0, "C:\", .F., GETF_LOCALHARD + GETF_LOCALFLOPPY + GETF_NETWORKDRIVE)
    If Empty(cFile)
        Return .F.
    Endif

    If ! Lower(Right(cFile, 4)) == ".xml"
        cFile += ".xml"
    EndIf
    If File(cFile)
        If ! FWAlertYesNo("Confirma a substituição do arquivo?")
            Return .F.
        EndIf
        FErase(cFile)
    EndIF

    oMsg:SetText("")
    oMsg:Refresh()
    ProcessMessage()

    nSec1 := Seconds()

    oExcel:= FWMSEXCEL():New()
    
    Processa({|| oExcel := ProcXml(oExcel, cAliasTst)},,,.T.)
    
    oExcel:Activate()
    oExcel:GetXMLFile(cFile)
    oExcel := FreeObj(oExcel)

    If lAbortPrint
        cMsg := "Geração interrompida, planilha xml com conteudo parcial!"
    Else
        cMsg := "Geração concluida!"
    EndIf

    nSec2 := Seconds()
    If nSec2 >= nSec1 
       cMsgT :=  "Tempo de Execução: " + APSec2Time(nSec2 - nSec1) + " (" + Alltrim(Str(nSec2 - nSec1)) + " segs.)"
    EndIf 
    FWAlertSuccess(cMsg)
    oMsg:SetText(cMsgT + " |Arquivo: " + cFile + " |" + cMsg )
    
    ShellExecute("open", cFile, "", "C:\", 1)

Return
    
Static Function ProcXml(oExcel, cAliasCSV)
    Local nReg    := 0
    Local nRec    := (cAliasCSV)->(Recno())

    (cAliasCSV)->(CabXml(oExcel))
   
    ProcRegua(1)
    (cAliasCSV)->(DbGoTop())
    While (cAliasCSV)->(! Eof())
        IncProc("Processando linha: " + Alltrim(Str(++nReg, 8)))
        ProcessMessage()
        If lAbortPrint
            Return oExcel
        EndIf

        (cAliasCSV)->(LinXml(oExcel))

        (cAliasCSV)->(DbSkip())
    End
    (cAliasCSV)->(DbGoTo(nRec))

Return oExcel

Static Function CabXml(oExcel)
    Local nx      := 0
    Local aFields := dbStruct()
    Local nFields := Len(aFields)
    Local cPlan   := "Query"
    Local cTit    := "Tabela"
    Local nAlign  := 0
    Local nFormat := 0
    Local lTotal  := .F.

    
    oExcel:AddworkSheet(cPlan)
    oExcel:AddTable (cPlan, cTit)

    For nx:= 1 to nFields
        lTotal  := .F.
        If aFields[nx, 2] == "D"
            nAlign 	:= 2
            nFormat	:= 4
        ElseIf aFields[nx, 2] == "N"
            nAlign 	:= 3
            nFormat	:= 2
            lTotal  := .T.
        Else
            nAlign 	:= 1
            nFormat	:= 1
        EndIf
        //< cWorkSheet >, < cTable >, < cColumn >, < nAlign > //1-Left,2-Center,3-Right, < nFormat > //1-General,2-Number,3-Monetário,4-DateTime, < lTotal >
        oExcel:AddColumn(cPlan, cTit, aFields[nX, 1], nAlign, nFormat, lTotal)
    Next

Return 

Static Function LinXml(oExcel)
    Local nx      := 0
    Local aFields := dbStruct()
    Local nFields := Len(aFields)
    Local cPlan   := "Query"
    Local cTit    := "Tabela"
    Local aLinha := {}

    DEFAULT oExcel := __Export

    aLinha:= {}
    For nx:= 1 to nFields
        aadd(aLinha, FieldGet(nx)) 
    Next
    oExcel:AddRow(cPlan, cTit, aLinha)

Return 


Static Function LinExel(lInit)
    Local nx      := 0
    Local aFields := dbStruct()
    Local nFields := Len(aFields)
    Local oDBF    

    If lInit <> Nil 
        Return 
    EndIf 

    oDBF:= __Export
    oDBF:Insert()
    For nx:= 1 to nFields
        oDBF:FieldPut(nx, FieldGet(nx))
    Next
    oDBF:Update()

Return 

Static Function LinDB(lInit)
    Local nx      := 0
    Local aFields := dbStruct()
    Local nFields := Len(aFields)
    Local cAlias  := Alias()

    If lInit <> Nil 
        Return 
    EndIf  
   
    (__Export)->(RecLock(__Export, .T.))
    For nx:= 1 to nFields
        (__Export)->(FieldPut(nx, (cAlias)->(FieldGet(nx))))
    Next
    (__Export)->(DbUnlock())
    (__Export)->(dbCommit())

Return 


Static Function ExportExcel(np, oMsg)
    Local cFile := ""
    Local cAliasTst := __aAliasTst[np]
    Local cMsg := ""
    Local nSec1 := 0
    Local nSec2 := 0
    Local cMsgT := ""
    Local cErro := ""
    Private lAbortPrint := .F.

    If Select(cAliasTst) == 0
        FWAlertWarning("Execute uma query!!")
        Return .F.
    EndIf

    cFile := MyGetFile("Arquivos query (*.xls) |*.xls|","Informe o arquivo", 0, "C:\", .F., GETF_LOCALHARD + GETF_LOCALFLOPPY + GETF_NETWORKDRIVE)
    If Empty(cFile)
        Return .F.
    Endif

    If ! Lower(Right(cFile, 4)) == ".xls"
        cFile += ".xls"
    EndIf
    If File(cFile)
        If ! FWAlertYesNo("Confirma a substituição do arquivo?")
            Return .F.
        EndIf
        FErase(cFile)
    EndIF

    oMsg:SetText("")
    oMsg:Refresh()
    ProcessMessage()

    nSec1 := Seconds()

    Processa({|| cErro := GeraExcel(cAliasTst, cFile) },,, .T.) 

    If lAbortPrint
        cMsg := "Geração interrompida, planilha Excel com conteudo parcial!"
    Else
        cMsg := "Geração Excel concluida!"
    EndIf
    If ! Empty(cErro)
        cMsg := cErro
    EndIf 

    nSec2 := Seconds()
    If nSec2 >= nSec1 
       cMsgT :=  "Tempo de Execução: " + APSec2Time(nSec2 - nSec1) + " (" + Alltrim(Str(nSec2 - nSec1)) + " segs.)"
    EndIf 
    FWAlertSuccess(cMsg)
    oMsg:SetText(cMsgT + " |Arquivo: " + cFile + " |" + cMsg )

    ShellExecute("open", cFile, "", "C:\", 1)

Return


Static Function GeraExcel(cAlias, cArqXLS)
    Local oDBF
    Local cDirXls := ""
    Local cNomXlS := ""
    Local cNomTmp := ""
    Local np      := 0
    Local cTmpDbf := "\TIDBF\"
    Local cErro   := ""

    nP := Rat("\", cArqXlS) 
    If nP > 0
        cDirXls := Left(cArqXlS, nP)
        cNomXls := Subs(cArqXlS, nP + 1)
    EndIf 
    // Trata os caminho e nome de arquivo no Server
    If ! ExistDir(cTmpDbf)
        MakeDir(cTmpDbf)
    EndIf 
    cNomTmp := "TMP" + FWTimeStamp() + ".xls"

    cFile  := cTmpDbf + cNomTmp
    If File(cFile)
        FErase(cFile)
    EndIf 
    ProcRegua(1)
    IncProc("Gerando arquivo Excel no servidor...")
    ProcessMessage()

    oDBF:= TIDBF():New(cFile)
    oDBF:CreateFrom(cAlias, .t.)
    oDBF:Close()
    FreeObj(oDBF)

    IncProc("Tranferindo arquivo Excel para maquina local...")
    ProcessMessage()

    If CpyS2T(cFile, cDirXls)
        Ferase(cFile)
    EndIf
    If FRename(cDirXls + cNomTmp,  cDirXls + cNomXlS) = -1
        cErro := "Não foi possivel renomear o arquivo " + cDirXls + cNomTmp 
    EndIf 

Return cErro

Static Function CountQuery(cQuery, oMsg)
    Local cTst := ''
    Local bErroA
    Local cErro:= ''
    Local aArea := GetArea()
    Local cAliasCount := "TMPCOUNT"
    Local nQtde := 0
    Local cBco := Upper(TCGETDB())

    Local nSec1  := 0
    Local nSec2  := 0
    Local cMsgT  := ""

    If empty(cQuery)
        Return
    EndIf

    If empty(cFilAnt) .or. empty(cEmpAnt)
        FWAlertInfo("Ambiente Não Inicializado")
        Return
    EndIf

    cQuery:= UPPER(ALLTRIM(cQuery))
    cQuery:= "SELECT COUNT(*) QTDE FROM ("+cQuery+") " + Iif(cBco=="MSSQL","AS TMP","")
    If Select(cAliasCount) > 0
        (cAliasCount)->(DbCloseArea())
    EndIf

    __cErroA :=""
    bErroA	:= ErrorBlock( { |oErro| ChkErr( oErro ) } )
    Begin Sequence
        cTst := cQuery
        nSec1 := Seconds()
        dbUseArea(.T.,'TOPCONN', TCGenQry(,,cTst),cAliasCount, .F., .T.)
        
        nSec2 := Seconds()
        If nSec2 >= nSec1 
           cMsgT :=  "Tempo de Execução: " + APSec2Time(nSec2 - nSec1) + " (" + Alltrim(Str(nSec2 - nSec1)) + " segs.)"
        EndIf 

        If (cAliasCount)->(! Eof())
            nQtde := (cAliasCount)->QTDE
        EndIf
    End Sequence
    ErrorBlock( bErroA )

    If Select(cAliasCount) > 0
        (cAliasCount)->(DbCloseArea())
    EndIf
    RestArea(aArea)

    If ! Empty(__cErroA)
        cErro := __cErroA
        AutoGrLog("")
        FErase(NomeAutoLog())
        AutoGrLog(cErro)
        MostraLog()
        __cErroA :=""
        oMsg:SetText("Erro de execução query!!!")
    Else
        oMsg:SetText(cMsgT + " |Quantidade de linhas: " + Alltrim(Transform(nQtde,"@E 999,999,999")))    
    EndIf
Return



/*
#################################################################################################################################
Aba de dicionario
#################################################################################################################################
*/
Static Function FolderDic(oDlg, np) 
    Local cAliasDic := Space(20)

    Local oDeleOn
    Local oReadOnly
    
    Local oIndice
    Local aIndice := {"SEM INDICE"}
    Local cIndice := Space(250)
    Local cPesquisa := Space(250)

    Local oP1 
    Local oP2
    Local oP3
    
    Local oMsg 
    Local cMsg   := ""
    Local oMsg2 
    Local cMsg2  := ""
    Local oFont:= TFont():New("Consolas",, 20,, .F.,,,,, .F. )
    Local oFontB := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)

    __aDicTst[np] := MyNextAlias()
  
    oP1:= TPanelCss():New(,,, oDlg)
    oP1:SetCoors(TRect():New(0, 0, 75, __nWidth))
    oP1:Align :=CONTROL_ALIGN_TOP

        //@ 007, 005 SAY "Tabela"  of oP1 SIZE 025, 10 PIXEL FONT oFontB
        THButton():New(006, 005, "Tabela"      , oP1, {|| DicBrowse(@cAliasDic, oP2, np, oIndice, oMsg, oMsg2, .T.) }, 20, 10, oFontB, "Click aqui para abrir arquivo DTC") 
        @ 005, 030 GET cAliasDic of oP1 SIZE 040, 09 PIXEL PICTURE "@!" VALID DicBrowse(cAliasDic, oP2, np, oIndice, oMsg, oMsg2)
        @ 007, 075 SAY "Indice "   of oP1 SIZE 030, 10 PIXEL FONT oFontB
        @ 005, 105 MSCOMBOBOX oIndice VAR cIndice ITEMS aIndice SIZE 235,10 OF oP1 PIXEL VALID MudaOrdem(cAliasDic, oIndice, np, @cPesquisa) 
        
        
        THButton():New(020, 005, "Fechar"      , oP1, {|| CloseTab(@cAliasDic, np, oIndice) }, 20, 10, oFontB, "Fecha tabela") 
        THButton():New(020, 070, "Pesquisa"    , oP1, {|| }, 30, 10, oFontB, "Para empresa compartilhada, não informar a filial!!!") 
        @ 020, 105 GET cPesquisa   of oP1 SIZE 235, 09 PIXEL VALID Posiciona(cAliasDic, cPesquisa, np )  PICTURE "@!"  when oIndice:nat > 1
        
        @ 005, 350 CHECKBOX oDeleOn   VAR __lDeleOn	   PROMPT "Dele ON"	 SIZE 040,010 OF oP1 PIXEL font oFontB  VALID  DelOn(np) ;oDeleOn:bChange := {|| DelOn(np) }
        @ 020, 350 CHECKBOX oReadOnly VAR __lReadOnly  PROMPT "Leitura"	 SIZE 040,010 OF oP1 PIXEL font oFontB  WHEN __lAdmin
        
        THButton():New(005, 390, "Incluir   " , oP1, {|| TelaInc(cAliasDic, np)  }, 40, 10, oFontB, "Incluir registro")    
        THButton():New(020, 390, "Edit Reg  " , oP1, {|| TelaEdit(cAliasDic, np)  }, 40, 10, oFontB, "Edita os campos")

        THButton():New(005, 430, "Copy Reg  " , oP1, {|| TelaCopy(cAliasDic, np)  }, 40, 10, oFontB, "Edita os campos")     
        THButton():New(020, 430, "Filter    " , oP1, {|| FilterTab(cAliasDic, np)  }, 40, 10, oFontB, "Aplica filtro da tabela") 

        THButton():New(005, 470, "Replace   " , oP1, {|| ReplaceTab(cAliasDic, np) }, 40, 10, oFontB, "Altera registros da tabela")  
        THButton():New(020, 470, "Locate    " , oP1, {|| LocateTab(cAliasDic, np)  }, 40, 10, oFontB, "Localiza registro conforme expressão")

        THButton():New(005, 510, "Goto      " , oP1, {|| GotoTab(cAliasDic, np)    }, 40, 10, oFontB, "Posiciona no recno") 
        THButton():New(020, 510, "Delete    " , oP1, {|| DeleteTab(cAliasDic, np, .T.)  }, 40, 10, oFontB, "Deleta registros da tabela")
 
        THButton():New(005, 550, "Recall    " , oP1, {|| DeleteTab(cAliasDic, np, .F.)  }, 40, 10, oFontB, "Recupera registros deletados")       
        THButton():New(020, 550, "Import    " , oP1, {|| ImportTab(cAliasDic, np)  }, 40, 10, oFontB, "Importa registros de outra tabela") 

        THButton():New(005, 590, "Export    " , oP1, {|| ExportTab(cAliasDic, np)  }, 40, 10, oFontB, "Exporta registros para outra tabela") 
        THButton():New(020, 590, "Estrutura " , oP1, {|| Estrutura(cAliasDic, np) }, 40, 10, oFontB, "Mostra a estrutura da tabela") 

        THButton():New(005, 630, "Colunas   " , oP1, {|| ReorgColu(cAliasDic, oP2, np, oIndice, oMsg , oMsg2)  }, 40, 10, oFontB, "Reorganize as colunas") 
        THButton():New(020, 630, "Compara SX" , oP1, {|| CompSX(cAliasDic, np)    }, 40, 10, oFontB, "Compara estrutura da tabela com o dicionario") 

        THButton():New(005, 670, "Conta Reg." , oP1, {|| ContaReg(cAliasDic,  np)  }, 40, 10, oFontB, "Conta a quantidade de registros") 
        If __lAdmin 
            THButton():New(020, 670, "Exec Macro" , oP1, {|| ExecRot(cAliasDic,  np)  }, 40, 10, oFontB, "Executa a macro para cada linha do browse") 
            THButton():New(005, 730, "Sync SX3  " , oP1, {|| SincSX3(cAliasDic,  np)  }, 40, 10, oFontB, "Altera estrutura da tabela conforme estrutura do dicionario SX3") 
            THButton():New(020, 730, "Drop Index" , oP1, {|| DropInd(cAliasDic,  np)  }, 40, 10, oFontB, "Apaga os indices") 
        EndIf 
        

    oP2:= TPanelCss():New(,,, oDlg)
    oP2:SetCoors(TRect():New(0, 0, __nHeight * 0.5, __nWidth))
    oP2:Align :=CONTROL_ALIGN_ALLCLIENT

        

    oP3:= TPanelCss():New(,,, oDlg)
    oP3:SetCoors(TRect():New(0, 0, 60, __nWidth))
    oP3:Align :=CONTROL_ALIGN_BOTTOM
        @ 003, 002 SAY oMsg  VAR cMsg SIZE 1000,010 OF oP3 PIXEL FONT oFont
        @ 016, 002 SAY oMsg2 VAR cMsg2 SIZE 1000,010 OF oP3 PIXEL FONT oFont
     
Return 

Static Function DicBrowse(cAliasDic, oP2, np, oIndice, oMsg, oMsg2, lBut, lReorg)
    Local nX        := 0
    Local cAliasTst := __aDicTst[np]
    Local aArea     := GetArea()
    Local aAreaSX2  := SX2->(GetArea())
    Local cAlign    := ""
    Local cPict     := ""
    Local cTipo     := ""
    Local nTam      := 0 
    Local nDec      := 0
    Local aStruct   := {}
    Local cNomTab   := ""
    Local cNomInd   := ""
    Local nOrd      := 0
    Local aIndice   := {"SEM INDICE"}
    Local lDTC      := .F.
    Local lSX       := .F.
    Local cAux      := ""
    Local aColuna   := {}
    Local npos      := 0
    Local aAux      := {}
    Default lBut    := .F.
    Default lReorg  := .F.
 

    If lBut 
        cNomTab := MyGetFile("Arquivos DTC|*.dtc|","Escolha o arquivo dtc.", 1, , .T., GETF_NETWORKDRIVE + GETF_ONLYSERVER)        
        If Empty(cNomTab)
            Return .F.
        EndIf 
        If "\" $ cNomTab
            cAliasDic := Alltrim(Subs(cNomTab, Rat("\",cNomTab) + 1))
        Else 
            cAliasDic := Alltrim(cNomTab)
        EndIf 
        If Upper(Right(cNomTab, 4)) == ".DTC" 
            cNomTab := Left(cNomTab, len(cNomTab) - 4)
        EndIf
        lDTC := .T.
    Else 
        If Empty(cAliasDic)
            Return
        EndIf
        If Upper(Right(AllTrim(cAliasDic), 4)) == ".DTC"     
            Return 
        EndIf
        cNomTab := Alltrim(cAliasDic)
    EndIf 

    If Left(AllTrim(cAliasDic), 3)  + "," $ "SIX,SX1,SX2,SX3,SX6,SX7,SXA,SXB,SXE,SXF,SXG," .AND. ;
        AllTrim(Subs(cAliasDic, 4)) + "," $ __cListaEmp 
        lSX  := .T. 
        cAux := Alltrim(cAliasDic)
        If len(cAux) == 3
            cAux += cEmpAnt + "0"
        EndIf 

        If MsFile(cAux,, "TOPCONN")
            lDTC := .F.
        Else
            lDTC := .T.
        EndIf 
    EndIf 

    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Hide()
        __aDicBrw[np]:FreeChildren()
        FreeObj(__aDicBrw[np])
        __aDicBrw[np]:= NIL 
    EndIf

    If ! lReorg
        If Select(cAliasTst) > 0 
            (cAliasTst)->(DbCloseArea())
        EndIf
        
        If lDTC 
            If lSX .and. len(Alltrim(cAliasDic)) == 3
                cNomTab := Alltrim(cAliasDic) + cEmpAnt + "0"
            EndIf 
            DbUseArea(.T., "DBF" + "CDX", cNomTab, cAliasTst, .T., .F.)
            If NetErr()
                FWAlertWarning("Erro de abertura do arquivo!")
                RestArea(aArea)
                Return .F.
            EndIf
            If Right(lower(cNomTab), 11) == "sigamat.emp"
                cNomInd := Left(cNomTab, len(cNomTab) - 4) + ".IND"
            Else 
                cNomInd := cNomTab + ".CDX"
            EndIf 
            If File(cNomInd)
                OrdListadd(cNomInd)
            EndIf
        Else
            If lSX .and. len(Alltrim(cAliasDic)) == 3   
                cNomTab := Alltrim(cAliasDic) + cEmpAnt + "0"
            Else 
                If len(Alltrim(cAliasDic)) == 3   // BUSCA POR ALIAS
                    SX2->(DbSetOrder(1))
                    If SX2->(DbSeek(Alltrim(cAliasDic)))
                        cNomTab := Alltrim(SX2->(FieldGet(FieldPos("X2_ARQUIVO"))))
                    EndIf 
                    RestArea(aAreaSX2)
                EndIf             
            EndIf

            If ! MsFile(cNomTab,, "TOPCONN")
                FWAlertWarning("Arquivo " + cNomTab + " não existe no banco!")
                RestArea(aArea)
                Return .F. 
            EndIf                

            DbUseArea(.T., "TOPCONN", cNomTab, cAliasTst, .T., .F.)
            If NetErr()
                FWAlertWarning("Erro de abertura do arquivo!")
                Return .F.
            EndIf

            While nOrd <= 36 
                cNomInd := cNomTab + RetAsc(Str(nOrd += 1), 1, .T.)
                If TcCanOpen(cNomTab, cNomInd)
                OrdListadd(cNomInd)
                EndIf
            End
        EndIf 
        
        If Select(cAliasTst) == 0
            FWAlertWarning("Não foi possivel abrir a tabela!!!")
            Return .F.
        EndIf 

        // carrega a aIndice
        nQtdInd := 1
        While .t.
            cKey := (cAliasTst)->(IndexKey(nQtdInd))
            If Empty(cKey)
                Exit 
            EndIf 
            aadd(aIndice, AllTrim(cKey))
            nQtdInd++
        End
        oIndice:SetItems(aIndice)
        If Len(aIndice) > 1
            oIndice:nat := 2
        EndIf 
        oIndice:Refresh()
    EndIf 

    aStruct  := (cAliasTst)->(dbStruct())

    __aDicBrw[np] := MsBrGetDBase():New(1, 1, __DlgWidth(oP2)-1, __DlgHeight(oP2) - 1,,,, oP2,,,,,,,,,,,, .F., cAliasTst, .T.,, .F.,,,)
    For nX:=1 To (cAliasTst)->(FCount())
        cTipo  := aStruct[nx, 2]
        nTam   := aStruct[nx, 3]
        nDec   := aStruct[nx, 4]
        cAlign := "LEFT"
        cPict  := ""

        If cTipo != "M"
            If cTipo == "N"
                cAlign := "RIGHT"
                If nDec > 0
                    cPict := Repl("9", nTam - nDec + 1)  + "." + Repl("9", nDec) 
                Else
                    cPict := Repl("9", nTam ) 
                EndIf 
            EndIf 
            aadd(aColuna,{(cAliasTst)->(Field(nx)), &("{ || " + cAliasTst + "->" + (cAliasTst)->(FieldName(nX)) + "}"), cPict, cAlign })
        Else
            aadd(aColuna,{(cAliasTst)->(Field(nx)), { || "Memo" }, "", cAlign })
        EndIf 
    Next nX

    If ! lReorg
        __aNewBrw[np] := {}
        LeHst(aAux, "campo" + Alltrim(cAliasDic))
        If len(aAux) > 0
            __aNewBrw[np] := aClone(Separa(aAux[len(aAux)], ","))
        EndIf 
        For nx:= 1 to Len(aStruct)
            npos := Ascan(__aNewBrw[np], {|x| x == aStruct[nx, 1]})
            If ! Empty(npos)
                Loop 
            EndIf
            aadd(__aNewBrw[np], aStruct[nx, 1])
        Next 
    EndIf 

    For nx:= 1 to len(__aNewBrw[np])
        npos := Ascan(aColuna, {|x| x[1] == __aNewBrw[np, nx]})
        If Empty(npos)
            Loop 
        EndIf 
        __aDicBrw[np]:AddColumn( TCColumn():New( aColuna[npos, 1] , aColuna[npos, 2], aColuna[npos, 3],,,, aColuna[npos, 4]))
    Next 

    __aDicBrw[np]:lColDrag	 := .T.
    __aDicBrw[np]:lLineDrag	 := .T.
    __aDicBrw[np]:lJustific	 := .T.
    __aDicBrw[np]:nColPos	 := 1
    __aDicBrw[np]:Cargo	  	 := {|| __NullEditcoll()}
    __aDicBrw[np]:Align      := CONTROL_ALIGN_ALLCLIENT
    __aDicBrw[np]:bChange    := {|| (cAliasTst)->(AtuMsg(__aDicBrw[np], oMsg, oMsg2)) }
    __aDicBrw[np]:bLDblClick := {|| AltReg(__aDicBrw[np], __aDicTst[np], , np) }
    __aDicBrw[np]:bDelOk	 := {|| DelRecno(nP)     }
    __aDicBrw[np]:bSuperDel	 := {|| DelRecno(nP, .F.)}
    __aDicBrw[np]:bAdd       := {|| AddRecno(nP)     } 
    __aDicBrw[np]:bGotFocus  := {|| DelOn(np)  }
    __aDicBrw[np]:SetBlkColor({|| If((cAliasTst)->(Deleted()),CLR_WHITE,CLR_BLACK)})
    __aDicBrw[np]:SetBlkBackColor({|| If((cAliasTst)->(Deleted()),CLR_LIGHTGRAY,CLR_WHITE)})
    __aDicBrw[np]:Refresh()
    __aDicBrw[np]:SetFocus()

    (cAliasTst)->(AtuMsg(__aDicBrw[np], oMsg, oMsg2))

Return .T. 




Static Function MudaOrdem(cAlias, oIndice, np, cPesquisa)
    Local nOrdem := oIndice:nat -1
    Local cAliasTst := __aDicTst[np]

    If Empty(cAlias)
        Return  
    EndIf 

    If Select(cAliasTst) == 0
        Return 
    EndIf 

    (cAliasTst)->(DBSetOrder(nOrdem))

    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Refresh()
        __aDicBrw[np]:SetFocus()
        eval(__aDicBrw[np]:bChange)
    EndIf
    cPesquisa := Space(250)

Return

Static Function Posiciona(cAlias, cPesquisa, np)
    Local aArea := GetArea()
    Local cAliasTst := ""
    Local aAreaTMP  := ""
    Local aAreaSX2  := SX2->(GetArea("SX2"))
    Local cAliasSX2 := ""

    If Empty(cPesquisa)
        Return .t.
    EndIf 

    cAliasTst := __aDicTst[np]

    If Select(cAliasTst) == 0
        Return .F.
    EndIf 

    aAreaTMP  := (cAliasTst)->(GetArea(cAlias))

    
    If ! AllTrim(cAlias) + "," $ "SIX,SX1,SX2,SX3,SX6,SX7,SXA,SXB,SXE,SXF,SXG,"
        SX2->(DbSetOrder(2))
        If SX2->(DbSeek(Alltrim(cAlias)))
            cAliasSX2 := SX2->(FieldGet(FieldPos("X2_CHAVE")))
            If Empty(xFilial(cAliasSX2))
                cPesquisa := xFilial(cAliasSX2) + Alltrim(cPesquisa)
            EndIf     
        EndIf 
        RestArea(aAreaSX2)
    EndIf 

    If ! (cAliasTst)->(DBSeek(Rtrim(cPesquisa)))
        FWAlertWarning("Não encontrado!!!")
        RestArea(aAreaTMP)
        RestArea(aArea)
    EndIf  
    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Refresh()
        __aDicBrw[np]:SetFocus()
        eval(__aDicBrw[np]:bChange)
    EndIf
Return

Static Function CloseTab(cAliasDic, np, oIndice)
    Local cAliasTst  := __aDicTst[np]
    
    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Hide()
        __aDicBrw[np]:FreeChildren()
        FreeObj(__aDicBrw[np])
        __aDicBrw[np]:= NIL 
    EndIf
    If Select(cAliasTst) > 0
        (cAliasTst)->(DbCloseArea())
    EndIf
    cAliasDic := Space(20)
    oIndice:nat := 1

Return 

Static Function TelaInc(cAliasDic, np)
    
    Local cAliasTst := __aDicTst[np]
    Local lReadOnly := .F.
    Local lCopia    := .F.
    Local lInclui   := .T.
    
    cAliasDic := Alltrim(cAliasDic)

    If Empty(cAliasDic)
        Return
    EndIf 

    If __lReadOnly
        FWAlertWarning("Somente leitura!!")
        Return
    EndIf 

    If TIEnchoice(cAliasTst, cAliasDic, lReadOnly, lCopia, lInclui)
        If ValType(__aDicBrw[np])=='O'
            __aDicBrw[np]:Refresh()
            __aDicBrw[np]:SetFocus()
            eval(__aDicBrw[np]:bChange)
        EndIf
    EndIf 

Return 


Static Function TelaEdit(cAliasDic, np)
    
    Local cAliasTst := __aDicTst[np]
    Local lReadOnly := .F.
    Local lCopia    := .F.
    Local lInclui   := .F.
    
    cAliasDic := Alltrim(cAliasDic)

    If Empty(cAliasDic)
        Return
    EndIf 

    If __lReadOnly
        FWAlertWarning("Somente leitura!!")
        lReadOnly := .T.
    EndIf 

    If TIEnchoice(cAliasTst, cAliasDic, lReadOnly, lCopia, lInclui)
        If ValType(__aDicBrw[np])=='O'
            __aDicBrw[np]:Refresh()
            __aDicBrw[np]:SetFocus()
            eval(__aDicBrw[np]:bChange)
        EndIf
    EndIf 

Return 

Static Function TelaCopy(cAliasDic, np)
    Local cAliasTst := __aDicTst[np]
    Local lReadOnly := .F.
    Local lCopia    := .T.
    Local lInclui   := .F.
    
    cAliasDic := Alltrim(cAliasDic)

    If Empty(cAliasDic)
        Return
    EndIf 

    If __lReadOnly
        FWAlertWarning("Somente leitura!!")
        Return 
    EndIf 


    If TIEnchoice(cAliasTst, cAliasDic, lReadOnly, lCopia, lInclui)
        If ValType(__aDicBrw[np])=='O'
            __aDicBrw[np]:Refresh()
            __aDicBrw[np]:SetFocus()
            eval(__aDicBrw[np]:bChange)
        EndIf
    EndIf 
    
Return 

Static Function TIEnchoice(cAlias, cTitulo, lReadOnly, lCopia, lInclui)
    Local oModal   
    Local oDlg      
    Local oScroll  
    Local nLinha     := 8
    Local nx         := 0
    Local aConteudo  := {}
    Local lSalva     := .F.
    Local cIndexKey  := ""
    Local cLog       := ""
    Local cTabela    := ""
    Default lReadOnly := .f. 

    oModal  := FWDialogModal():New()       
	oModal:SetEscClose(.T.)
    oModal:setTitle(cTitulo)
	oModal:setSize(240, 280)
    oModal:createDialog()
    
    cIndexKey := (cAlias)->(IndexKey())
    cTabela:= RetFileName((cAlias)->(DBInfo(10)))
    
    If lReadOnly 
        oModal:setTitle("Tabela " + cTitulo + " - Registro: " + Alltrim(Str((cAlias)->(RecNo()))))
        oModal:addCloseButton({|| oModal:DeActivate() }, "OK")
    Else 
        
        If Upper(cTabela) == "TIDEVLOG"
            FWAlertWarning("Não é permitido manipular a tabela TIDEVLOG")
            Return 
        EndIf 
        If lCopia
            oModal:setTitle("Tabela " + cTitulo + " - Copia do registro: " + Alltrim(Str((cAlias)->(RecNo()))))     
        ElseIf lInclui
            oModal:setTitle("Tabela " + cTitulo + " - Novo registro. " )
        Else
            oModal:setTitle("Tabela " + cTitulo + " - Alterando registro: " + Alltrim(Str((cAlias)->(RecNo()))))    
        EndIf
        oModal:AddButton("Cancelar",{|| oModal:DeActivate()}     , "Cancelar",,.T.,.F.,.T.,)
        oModal:addCloseButton({|| lSalva:= .T., oModal:DeActivate() }, "Salvar")
    EndIf 

    oDlg:= oModal:getPanelMain()
    
    oScroll := TScrollBox():New( oDlg, 8,10,104,203)
    oScroll:Align := CONTROL_ALIGN_ALLCLIENT


    aStruct := (cAlias)->(dbStruct())
  
    For nx:=1 To (cAlias)->(FCount())
        cCampo    := aStruct[nx, 1]
        cTipo     := aStruct[nx, 2]
        nTam      := aStruct[nx, 3]
        nDec      := aStruct[nx, 4]

        If lInclui
            uConteudo := Criavar(cCampo)
        Else
            uConteudo := (cAlias)->(FieldGet(nx)) 
        EndIf
        aadd(aConteudo, {cCampo, uConteudo})

        CampoSay(oScroll, nLinha, cCampo, cIndexKey)
        CampoGet(oScroll, @nLinha, cCampo, cTipo, nTam, nDec, aConteudo, nx , lReadOnly)
        
    Next 

    oModal:Activate()

    If lSalva .AND. ! lReadOnly
        
        If lCopia
            If ! FWAlertYesNo("Confirma a copia do registro " + Alltrim(Str((cAlias)->(RecNo()))) + "?")
                Return .F.
            EndIf 
            cLog += "Copia do registro " + CValToChar((cAlias)->(Recno())) + CRLF
            (cAlias)->(RecLock(cAlias, .T.))
            cLog += "Novo registro " + CValToChar((cAlias)->(Recno())) + CRLF
        ElseIf lInclui
            If ! FWAlertYesNo("Confirma inclusão de novo registro?")
                Return .F.
            EndIf
            (cAlias)->(RecLock(cAlias, .T.))
            cLog += "Novo registro " + CValToChar((cAlias)->(Recno())) + CRLF
        Else 
            If ! FWAlertYesNo("Confirma a atualização do registro " + Alltrim(Str((cAlias)->(RecNo())))+ "?")
                Return .F.
            EndIf 
            cLog += "Alteração do registro " + CValToChar((cAlias)->(Recno())) + CRLF
            (cAlias)->(RecLock(cAlias, .F.))
        EndIf 
        For nx:= 1 to (cAlias)->(FCount())
            cTipo     := aStruct[nx, 2]
            If cTipo == "L"
                aConteudo[nx, 2] := aConteudo[nx, 2] == "True"
            EndIf 
            If ! (cAlias)->(FieldGet(nx)) == aConteudo[nx, 2]
                If lCopia .or. lInclui
                    cLog += (cAlias)->(Field(nx)) + " = " + CValToChar(aConteudo[nx, 2]) + CRLF
                Else 
                    cLog += (cAlias)->(Field(nx)) + " de " + CValToChar((cAlias)->(FieldGet(nx))) + " -> " + CValToChar(aConteudo[nx, 2]) + CRLF
                EndIf 
            EndIf 
            (cAlias)->(FieldPut(nx, aConteudo[nx, 2]))
        Next 

        IncLog("TABELA", cTabela, cLog)
    EndIf 
    (cAlias)->(MsUnlock())

Return lSalva

Static Function CampoSay(oScroll, nLinha, cCampo, cIndexKey)
    Local oFonte
    Local cTextSay := ""
    Local nColor   := CLR_RED
    
    DEFINE FONT oFonte NAME "Verdana" SIZE 0, -10 BOLD

    cTextSay:= "{||'" + cCampo + "'}"

    If cCampo $ cIndexKey
        nColor   := CLR_RED
    Else                 
        nColor   := CLR_BLACK
    EndIf 
    TSay():New( nLinha, 15 , MontaBlock(cTextSay) , oScroll , ,,,,,.T., nColor,,60,,,,,,)

Return 

Static Function CampoGet(oScroll, nLinha, cCampo, cTipo, nTam, nDec, aConteudo, nx, lReadOnly)
    Local cBlKGet   := ""
    Local cBlkVld   := ""
    Local cBlkWhen  := ""
    Local nWidth    := 0
    Local aTamSx3   := {}
    Local cPict     := ""
    //Local uConteudo := aConteudo[nx, 2]
    Default lReadOnly := .F.

    cCampo := "aConteudo[" + Alltrim(Str(nx)) + ", 2]"
    
    
    cBlkGet  := "{ | u | If( PCount() == 0, " + cCampo + ", " + cCampo + ":= u ) }"

    cBlKVld  := "{ || .t. }"
    If ! lReadOnly
        cBlKWhen := "{ || .t. }"
    Else
        cBlKWhen := "{ || .f. }" 
    EndIf 

    aTamSx3 := TamSX3(cCampo)
    If ! Empty(aTamSx3)
        nTam   := aTamSx3[1]
        nDec   := aTamSx3[2]
    EndIf 
    
    If cTipo == "N"
        cPict  := ""
        If nDec > 0
            cPict := Repl("9", nTam - nDec + 1)  + "." + Repl("9", nDec) 
        Else
            cPict := Repl("9", nTam ) 
        EndIf
    EndIf 
    

    //CalcFieldSize(X3_TIPO,X3_TAMANHO,X3_DECIMAL,alltrim(X3_PICTURE),X3Titulo())
    If cTipo == "N"
        nWidth	:= CalcFieldSize(cTipo,     ,, cPict, "") + 10
    Else
        nWidth	:= CalcFieldSize(cTipo, nTam,, cPict, "") + 10
    EndIf
    If cTipo $ "CDN"
        TGet():New(nLinha, 60, &cBlKGet, oScroll, nWidth,, cPict, &(cBlkVld),,,, .T.,, .T.,, .T., &(cBlkWhen), .F., .F.,, .F., .F. ,, cCampo,,,,.T.)
        nLinha += 17
    ElseIf cTipo == "M"
        nLinha += 10

        TMultiGet():New(nLinha + 1, 15, &cBlkGet  ,oScroll, 240, 33,,,,,,.T.,, .T.,&(cBlkWhen),,,.F.,&(cBlkVld),,.T.,.F.)
        nLinha += 41
    ElseIf cTipo == "L"
        If &cCampo
           &cCampo := "True"     
        Else 
           &cCampo := "False"     
        EndIf 
        TComboBox():New(nLinha , 60, &cBlkGet ,{"True", "False"}, 60 , 10, oScroll,,,,,,.T.,,,.F.,&(cBlkWhen),.T.,,,, cCampo)
        nLinha += 17
    EndIf 

Return 



Static Function  FilterTab(cAliasDic, np)
    Local cAliasTst  := __aDicTst[np]
    Local cFiltro := ""
    Local cFiltroA:= ""

    If Select(cAliasTst) == 0 .or. Empty(cAliasDic)
        Return 
    EndIf 
    
    cFiltroA := Alltrim((cAliasTst)->(dbFilter()))
    cFiltro := TelaExpr(cAliasTst, cFiltroA )

    If !Empty(cFiltro)
        (cAliasTst)->(DbSetfilter({|| &(cFiltro)}, cFiltro))
    Else
        (cAliasTst)->(DbClearfilter())
    Endif

    (cAliasTst)->(DbGotop())
    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Refresh()
        __aDicBrw[np]:SetFocus()
        eval(__aDicBrw[np]:bChange)
    EndIf

Return Nil

Static Function TelaExpr(cAliasTst, cExpre)
    Local oFontB    := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)
    Local oDlg 
    Local oExpre
    Local oPS
    Local lOk       := .F.
    Local oCampos 
    Local aCampos   := {}
    Local cCampos   := ""
    Local oOperS
    Local aOperS    := {}
    Local cOperS    := ""
    Local uExpCmp   := NIL
    Local aStruct   := (cAliasTst)->(DbStruct())
    Local nx        := 0
    Local oBAdic
    Local oBLimp
    Local oBE   
    Local oBOu  
    Local oBPI  
    Local oBPF
    Local oBH 
    Local oModal 
    
    Default cExpre := "" 

    For nx:= 1 to len(aStruct)
        If aStruct[nx, 2] == "L" .or. aStruct[nx, 2] == "M"
            Loop 
        EndIf 
        aadd(aCampos, aStruct[nx, 1])
    Next 

    cCampos := aCampos[1]
    aOperS  := {"Igual a","Diferente de","Menor que","Menor que ou igual a", "Maior que","Maior que ou igual a","Contem a expressão", "Não contem","Está incluido em", "Não está incluido em" }
    
    oModal  := FWDialogModal():New()       
	oModal:SetEscClose(.T.)
    oModal:setTitle("Expressão para filtro")
	oModal:setSize(140, 280)
    oModal:createDialog()
    oModal:addCloseButton({|| If((cAliasTst)->(ExpreOk(cExpre)), (lOk:= .T., oModal:DeActivate()), .F.),  }, "OK")
    oModal:AddButton("Cancelar", {|| lOk:= .F., oModal:DeActivate() }     , "Cancelar",,.T.,.F.,.T.,)

    oDlg:= oModal:getPanelMain()
    
        oPS:= TPanelCss():New(,,, oDlg)
        oPS:SetCoors(TRect():New(0, 0, 75, 500))
        oPS:Align :=CONTROL_ALIGN_TOP

            @ 005, 005 SAY "Campos"      of oPS SIZE 050, 10 PIXEL FONT oFontB
            @ 005, 065 SAY "Operadores"  of oPS SIZE 050, 10 PIXEL FONT oFontB
            @ 005, 130 SAY "Expressão do campo"   of oPS SIZE 070, 10 PIXEL FONT oFontB

            @ 015, 005 MSCOMBOBOX oCampos  VAR cCampos  ITEMS aCampos   SIZE 50,09 PIXEL OF oPS VALID AtuExpCmp(cCampos, oOperS, oExpCmp, aStruct)
            @ 015, 065 MSCOMBOBOX oOperS   VAR cOperS   ITEMS aOperS    SIZE 60,09 PIXEL OF oPS VALID AtuExpCmp(cCampos, oOperS, oExpCmp, aStruct)
            @ 015, 130 Get        oExpCmp  VAR uExpCmp  of oPS SIZE 090, 09 PIXEL PICT "@!"

            AtuExpCmp(cCampos, oOperS, oExpCmp, aStruct)
    
            oBAdic:= THButton():New(016, 220, "Adiciona"        ,oPS, {|| AdicExpr(cCampos, oOperS, oExpCmp, aStruct, @cExpre) }, 35, 10, oFontB, "Adiciona na expressão final") 
            oBLimp:= THButton():New(026, 005, "Limpa Expressão" ,oPS, {|| cExpre:= ""              }, 55, 10, oFontB, "Limpa a expressão final") 
            oBH   := THButton():New(026, 060, "Histórico"       ,oPS, {|| MenuFil(@cExpre, oBH)    }, 45, 10, oFontB, "Lista com o histórico") 
            oBE   := THButton():New(026, 220, "e"               ,oPS, {|| AdicOperad(@cExpre, "e") }, 10, 10, oFontB, "Inclui o operador .and. ") 
            oBOu  := THButton():New(026, 232, "ou"              ,oPS, {|| AdicOperad(@cExpre, "ou")}, 10, 10, oFontB, "Inclui o operador .or. ") 
            oBPI  := THButton():New(026, 244, "("               ,oPS, {|| AdicParen(@cExpre, "(")  }, 10, 10, oFontB, "Abre parenteses") 
            oBPF  := THButton():New(026, 256, ")"               ,oPS, {|| AdicParen(@cExpre, ")")  }, 10, 10, oFontB, "Fecha Parenteses") 
    
        oExpre := tMultiget():new(,, bSETGET(cExpre), oDlg)
        oExpre:Align := CONTROL_ALIGN_ALLCLIENT
      
    oModal:Activate()

    If ! lOk
        cExpre := ""
    Else 
        GrvHst(__aHstfil, "filtro", cExpre)
    EndIf 

Return cExpre



Static Function AtuExpCmp(cCampo, oOperS, oExpCmp, aStruct)
    Local aOper   := {"==", "!=", "<", "<=", ">", ">=", "..", "!.", "$", "!x"}
    Local cTipo   := ""
    Local nTam    := 0
    Local nDec    := 0
    Local cOper   := aOper[oOperS:nAt]
    Local uIniCmp := NIL 
    Local cPicCmp := "@!"

    DEFAULT lFirst := .t.

    np := Ascan(aStruct, {|x| Alltrim(Upper(x[1])) == Alltrim(Upper(cCampo))})
    If Empty(np)
        Return 
    EndIf 

    cTipo := aStruct[np, 2]
    nTam  := aStruct[np, 3]
    nDec  := aStruct[np, 4]

    If cTipo == "D"
        cPicCmp := "@D"
        uIniCmp := CTOD("")
    ElseIf cTipo == "N"
        If nDec == 0
            cPicCmp := Repl("9", nTam)
        Else
            cPicCmp := Repl("9", nTam - nDec -1) + "." + Repl("9", nDec) 
        Endif 
        uIniCmp := 0
    ElseIf cTipo == "C" 
        cPicCmp := "@!"
        uIniCmp := Space(nTam)
    EndIf 
    
    If cOper $ "$|!x"
       uIniCmp   := Space(200)
       cPicCmp := "@!"
    EndIf
    
    SetFocus(oExpCmp:hWnd)
    oExpCmp:oGet:Picture := cPicCmp
    oExpCmp:oGet:Pos     := 0
    oExpCmp:cText := uIniCmp
    oExpCmp:oGet:Assign()
    oExpCmp:oGet:UpdateBuffer()
    oExpCmp:Refresh()

Return  

Static Function AdicExpr(cCampo, oOperS, oExpCmp, aStruct, cExpre)
    Local cMemo := StrTran(Alltrim(cExpre), CRLF, "")
    Local aOper   := {"==", "!=", "<", "<=", ">", ">=", "..", "!.", "$", "!x"}
    Local cOper   := aOper[oOperS:nAt]
    Local uExpCmp := oExpCmp:cText 
    Local cExpAtu := ""
    Local cTipo   := ""
    Local np      := 0

    If ! Empty(cMemo) .and. Right(Upper(cMemo), 5) <> ".AND." .and. Right(Upper(cMemo), 4) <> ".OR." .AND. Right(Upper(cMemo), 1) <> "("
        Return 
    EndIf 

    np := Ascan(aStruct, {|x| Alltrim(Upper(x[1])) == Alltrim(Upper(cCampo))})
    If Empty(np)
        Return 
    EndIf 

    cTipo := aStruct[np, 2]

    If cTipo == "C"
        If cOper == ".."     // "Conten a expressão"
            cExpAtu := "'" + Alltrim(uExpCmp) + "' $ Alltrim("+cCampo+")" 
        ElseIf cOper == "!." //"Não contem"
            cExpAtu := "! '" + Alltrim(uExpCmp) + "' $ Alltrim("+cCampo+")" 
        ElseIf cOper == "!x"
            cExpAtu := "! Alltrim(" + cCampo + ") $ '" + Alltrim(uExpCmp) + "'"
        ElseIf cOper == "$"    
            cExpAtu := "Alltrim(" + cCampo + ") $ '" + Alltrim(uExpCmp) + "'"
        Else 
            cExpAtu := cCampo + " " + cOper + " '" + uExpCmp + "'"
        EndIf 
    ElseIf cTipo == "D"
        If oOperS:nAt > 6
            FWAlertWarning("Operador não permitido!")
            Return 
        EndIf 
        cExpAtu := "DtoS(" + cCampo + ") " + cOper + " '" + DtoS(uExpCmp) + "'"
    ElseIf cTipo == "N"
        If oOperS:nAt > 6
            FWAlertWarning("Operador não permitido!")
            Return 
        EndIf 
        cExpAtu := cCampo + " " + cOper + " " + cValToChar(uExpCmp) 
    EndIf  

    cExpre := cMemo + " " + cExpAtu + " "

Return 

Static Function AdicOperad(cExpre, cOper)
    Local cMemo := StrTran(Alltrim(cExpre), CRLF, "")
    Local cExpAtu := ""

    If Empty(cMemo) 
        Return 
    EndIf 
    If ! Empty(cMemo) .and. Right(Upper(cMemo), 5) <> ".AND." .and. Right(Upper(cMemo), 4) == ".OR."
        Return 
    EndIf 
    If Right(Upper(cMemo), 5) == ".AND."
        Return 
    EndIf 
    If Right(Upper(cMemo), 4) == ".OR."
        Return 
    EndIf 
    If cOper == "e"
        cExpAtu := " .AND. "
    ElseIf cOper == "ou"
        cExpAtu := " .OR. "
    EndIf 

    cExpre := cMemo + " " + cExpAtu + " "
    
Return 

Static Function AdicParen(cExpre, cOper)
    Local cMemo := StrTran(Alltrim(cExpre), CRLF, "")
    Local cUltByte := Right(Upper(cMemo), 1)
    Local nQPar := 0
    Local nx := 0
    
    If cOper == "("
        If cUltByte == ")"
            Return 
        EndIf 
    Else 
        If cUltByte == "("
            Return 
        EndIf 
    EndIf 

    For nx:= 1 to len(cMemo)
        If Subs(cMemo, nx, 1) == "("
            nQPar++ 
        EndIf 
        If Subs(cMemo, nx, 1) == ")"
            nQPar-- 
        EndIf 
    Next 
    
    If cOper == ")"
        If Empty(nQpar)
            Return 
        EndIf 
    EndIf 
    cExpre := cMemo + " " + cOper + " "
    
Return


Static Function ExpreOk(cExp)
    Local lOk
    Local oErro 
    Local cErro:= ""

    If Empty(cExp)
        Return .t.
    EndIf 

    __cErroA:= ""
    oErro := ErrorBlock( { |oErro| ChkErr( oErro ) } ) 
    Begin Sequence
        lOk := &(cExp) <> NIL
    End Sequence
    ErrorBlock(oErro)

    If ! Empty(__cErroA)
        AutoGrLog("")
        cErro := __cErroA
        FErase(NomeAutoLog())
        AutoGrLog(cErro)
        MostraLog()
        __cErroA :=""
        lOk := .F.
    EndIf 

Return lOk 


Static Function TelaPar(cAliasTst, cTitulo)
    Local oFontB    := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)
    Local oDlg 
    Local oPS
    Local oPF 
    Local oPFS
    Local oPW
    Local oPWS
    Local oPO
    Local lOk       := .F.
    Local oCampos 
    Local aCampos   := {}
    Local cCampos   := ""
    Local oConteudo 
    Local cConteudo := '""' + Space(248)
    Local aStruct   := (cAliasTst)->(DbStruct())
    
    Local oExpF
    Local cExpF     := ""
    Local oExpW
    Local cExpW     := ""
    Local oOpcoes 
    Local aOpcoes   := {"Todos","Restantes", "Próximos"}
    Local copcoes   := "Todos"
    Local oSayProx
    Local oProximo  
    Local nProximo  := 0
    Local oFormato   
    Local aFormato  := {"Tabela", "DTC", "CSV", "XML", "XLS (DBF4)"}
    Local cFormato  := "Tabela"
    Local cArquivo  := Space(20)
    Local oArquivo   
    Local lRest     := .F.
    Local nx        := 0
    Local nAltura   := 180

    Local lReplace := cTitulo == "Replace"
    Local lLocate  := cTitulo == "Locate"
    Local lExport  := cTitulo == "Export"
    Local oModal  

   

    For nx:= 1 to len(aStruct)
        If aStruct[nx, 2] == "L" .or. aStruct[nx, 2] == "M"
            Loop 
        EndIf 
        aadd(aCampos, aStruct[nx, 1])
    Next 

    cCampos := aCampos[1]

    If lReplace .or. lExport
        nAltura:= 220
    EndIf 
    If lLocate
        nAltura:= 100
    EndIf 
    
    oModal  := FWDialogModal():New()       
	oModal:SetEscClose(.T.)
    oModal:setTitle(cTitulo)
	oModal:setSize(nAltura, 290)
    oModal:createDialog()
    oModal:addCloseButton({|| If((cAliasTst)->(ExpreOk(cExpF)) .and. (cAliasTst)->(ExpreOk(cExpW)) .and. If(lReplace, (cAliasTst)->(ExpreOk(cCampos + "==" + Alltrim(cConteudo)  )), .T.) , (lOk:= .T., oModal:DeActivate()), .F.)}, "OK")
    oModal:AddButton("Cancelar", {|| lOk:= .F., oModal:DeActivate() }     , "Cancelar",,.T.,.F.,.T.,)

    oDlg:= oModal:getPanelMain()

        If lReplace .and. ! lLocate
            oPS:= TPanelCss():New(,,, oDlg)
            oPS:SetCoors(TRect():New(0, 0, 75, 500))
            oPS:Align :=CONTROL_ALIGN_TOP

                @ 005, 005 SAY "Campos"      of oPS SIZE 050, 10 PIXEL FONT oFontB
                @ 005, 065 SAY "Conteudo Advpl"  of oPS SIZE 050, 10 PIXEL FONT oFontB
                
                @ 015, 005 MSCOMBOBOX oCampos  VAR cCampos  ITEMS aCampos   SIZE 50,09 PIXEL OF oPS 
                @ 015, 065 Get     oConteudo  VAR cConteudo  of oPS SIZE 210, 09 PIXEL PICT "@!"

        EndIf 
        If lExport 
            oPE:= TPanelCss():New(,,, oDlg)
            oPE:SetCoors(TRect():New(0, 0, 75, 500))
            oPE:Align :=CONTROL_ALIGN_TOP

                @ 005, 005 SAY "Formato"  of oPE SIZE 050, 10 PIXEL FONT oFontB
                @ 005, 065 SAY "Arquivo"  of oPE SIZE 050, 10 PIXEL FONT oFontB
                
                @ 015, 005 MSCOMBOBOX oFormato  VAR cFormato ITEMS aFormato   SIZE 50,09 PIXEL OF oPE  VALID (cArquivo :=Space(20), If(cFormato=="Tabela", oBGF:Hide(),oBGF:Show()  ) , .t.) 
                @ 015, 065 Get        oArquivo  VAR cArquivo of oPE SIZE 200, 09 PIXEL PICT "@!" WHEN oFormato:nAt == 1
                oBGF := THButton():New(015, 267, "..."        , oPE, {|| SelArquivo(cFormato, @cArquivo, "E", oModal)}, 10, 10, oFontB, "Informa o arquivo")
                oBGF:Hide()
        EndIf 
        
        oPF:= TPanelCss():New(,,, oDlg)
        oPF:SetCoors(TRect():New(0, 0, 100, 500))
        oPF:Align :=CONTROL_ALIGN_TOP
            oPFS:= TPanelCss():New(,,, oPF)
            oPFS:SetCoors(TRect():New(0, 0, 30, 500))
            oPFS:Align :=CONTROL_ALIGN_TOP
                @ 005, 005 SAY "Expressão clausula [FOR]"      of oPFS SIZE 100, 10 PIXEL FONT oFontB
                THButton():New(004, 95, "..."        , oPFS, {|| cExpF := TelaExpr(cAliasTst, cExpF ) }, 10, 10, oFontB, "Monta expressão para clausula FOR") 

            oExpF := tMultiget():new(,, bSETGET(cExpF), oPF)
            oExpF:Align := CONTROL_ALIGN_ALLCLIENT

        If lLocate
            oPF:Align :=CONTROL_ALIGN_ALLCLIENT
        Else 
            oPW:= TPanelCss():New(,,, oDlg)
            oPW:SetCoors(TRect():New(0, 0, 100, 500))
            oPW:Align :=CONTROL_ALIGN_TOP
                oPWS:= TPanelCss():New(,,, oPW)
                oPWS:SetCoors(TRect():New(0, 0, 30, 500))
                oPWS:Align :=CONTROL_ALIGN_TOP
                    @ 005, 004 SAY "Expressão clausula [WHILE]"      of oPWS SIZE 100, 10 PIXEL FONT oFontB
                    THButton():New(004, 95, "..."        , oPWS, {|| cExpW := TelaExpr(cAliasTst, cExpW ) }, 10, 10, oFontB, "Monta expressão para clausula WHILE") 

                oExpW := tMultiget():new(,, bSETGET(cExpW), oPW)
                oExpW:Align := CONTROL_ALIGN_ALLCLIENT

            oPO:= TPanelCss():New(,,, oDlg)
            oPO:SetCoors(TRect():New(0, 0, 75, 500))
            oPO:Align :=CONTROL_ALIGN_ALLCLIENT
                @ 005, 004 SAY "Opções "  of oPO SIZE 050, 10 PIXEL FONT oFontB
                @ 005, 065 SAY oSayProx  PROMPT "Próximos"  of oPO SIZE 030, 10 PIXEL FONT oFontB 

                @ 015, 005 MSCOMBOBOX oOpcoes   VAR cOpcoes ITEMS aOpcoes   SIZE 50,09 PIXEL OF oPO  VALID If( cOpcoes == "Próximos" , (oSayProx:Show(),oProximo:Show()) , (oSayProx:Hide(),oProximo:Hide()))
                @ 015, 065 Get        oProximo  VAR nProximo  of oPO SIZE 20, 09 PIXEL PICT "9999999"
            
                oSayProx:Hide()
                oProximo:Hide()
        EndIf

    oModal:Activate()

    If ! lOk
        Return {}
    EndIf 

    cConteudo := Alltrim(cConteudo)

    cExpF := Alltrim(cExpF)
    cExpF := StrTran(Alltrim(cExpF), CRLF, "")
    If Empty(cExpF)
        cExpF := NIL
    EndIf 

    cExpW := Alltrim(cExpW)
    cExpW := StrTran(Alltrim(cExpW), CRLF, "")
    If Empty(cExpW)
        cExpW := NIL
    EndIf 

    If ! cOpcoes == "Próximos"
        nProximo := NIL 

        If cOpcoes == "Restantes"
            lRest := .T.
        EndIf 
    EndIf

    If lLocate
        cExpW := " ! (" + cExpF + ") "
    EndIf 

    cArquivo := Alltrim(cArquivo)

Return {cCampos, cConteudo, cExpF, cExpW, nProximo, lRest, cFormato, cArquivo} 


Static Function SelArquivo(cFormato, cArquivo, cModo, oModal)
    Local cFile     := ""
    Local cExt      := Left(cFormato, 3)
    Local cNomArq   := ""
    Local nPos      := 0
    Local lUsaAnt   := .F.
    Local lSucesso  := .F.
    
    cFile := MyGetFile("Arquivos " + cExt + " (*." + cExt + ") |*." + cExt + "|" , "Informe o arquivo", 1, "C:\", cModo == "I", GETF_LOCALHARD + GETF_LOCALFLOPPY + GETF_NETWORKDRIVE )

    If Empty(cFile)
        Return .F.
    Endif
    If cModo == "E"  //exportação
        If ! Upper(Right(cFile, 4)) == "." + cExt 
            cFile += "." + cExt 
        EndIf
        If File(cFile)
            If ! FWAlertYesNo("Confirma a substituição do arquivo?")
                Return .F.
            EndIf
            FErase(cFile)
        EndIF
    Else
        If ! File(cFile)
            FWAlertWarning("arquivo não encontrado!")
        EndIf 
        If Subs(cfile, 2, 2) == ":\"    
            nPos := Rat("\", cFile)
            cNomArq := Subs(cFile, nPos + 1)
            
            If File("system\tidev\" + cNomArq) 
                lUsaAnt := FWAlertYesNo("Esse arquivo já existe em 'system\tidev\', deseja reutilizar o arquivo?")
                If ! lUsaAnt
                    FWAlertWarning("Será feito uma copia temporaria no servido em 'system\tidev\' para processamento!")
                    If FErase("system\tidev\" + cNomArq) == -1
                        FWAlertWarning("o arquivo em 'system\tidev' não pode ser substituido!")
                        Return .f.
                    EndIf 
                EndIf
            Else 
                FWAlertWarning("Será feito uma copia temporaria no servido em 'system\tidev\' para processamento!")
            EndIf 
            If ! lUsaAnt 
                Processa({|| lSucesso := CPYT2S(cFile, "system\tidev\", .T.) }, "Copiando arquivo para \system\tidev..")
                If ! lSucesso
                    FWAlertWarning("Erro ao copiar arquivo para 'system\tidev\'")
                    REturn .f.
                EndIf
            EndIf
            cFile := "system\tidev\" + cNomArq
        EndIf 
    EndIf 
    cArquivo := cFile

    If ! Empty(cArquivo)
        If cModo == "E" 
            oModal:setTitle("Export para " + RetFileName(cArquivo) + "." + cFormato)
        Else 
            oModal:setTitle("Import de " + RetFileName(cArquivo) + "." + cFormato )
        EndIf
        
    EndIf 

Return 



Static Function ReplaceTab(cAliasDic, np)
    Local cAliasTst  := __aDicTst[np]
    Local aRet       := {}
    Local cComando   := ""
    Local cFor       := ""
    Local cWhile     := ""
    Local nProxReg   := NIL
    Local lRest      := NIL
    Local cCampo     := ""
    Local cConteudo  := ""
    Local cLog       := ""
    Local cTabela    := ""
    

    If Select(cAliasTst) == 0 .or. Empty(cAliasDic)
        Return 
    EndIf 
    
    If __lReadOnly 
        FWAlertWarning("Somente leitura!!")
        Return 
    EndIf 

    cTabela:= RetFileName((cAliasTst)->(DBInfo(10)))
    If Upper(cTabela) == "TIDEVLOG"
        FWAlertWarning("Não é permitido manipular a tabela TIDEVLOG")
        Return 
    EndIf 

    aRet := aClone(TelaPar(cAliasTst, "Replace"))
    If Empty(aRet)
        Return 
    EndIf 

    If ! FWAlertYesNo("Confirma a alteração dos registros?")
        Return
    EndIf 

    cCampo    := aRet[1]
    cConteudo := aRet[2]
    cFor      := aRet[3]
    cWhile    := aRet[4]
    nProxReg  := aRet[5]
    lRest     := aRet[6]

    cComando := "DbrLock(), _FIELD->" + cCampo + " := " + cConteudo + ", DbUnlock(), DbCommitall() "

    
    (cAliasTst)->(TelaDbEval(cComando, cFor, cWhile, nProxReg, lRest, "Alterando registos"))

    cLog += "Alteração em bloco de campo" + CRLF
    cLog += "Tabela: " + cTabela + CRLF
    clog += "Filtro: " + (cAliasTst)->(dbFilter()) + CRLF
    clog += "Indice: " + (cAliasTst)->(IndexKey()) + CRLF + CRLF

    cLog += "COMANDO POR LINHA" + CRLF
    clog += cComando + CRLF + CRLF

    If cFor <> NIL 
        cLog += "Clausula FOR" + CRLF
        cLog += cFor + CRLF
    EndIf 
    If cWhile <> NIL 
        cLog += "Clausula FOR" + CRLF
        cLog += cWhile + CRLF
    EndIf 
    If nProxReg <> NIL 
        cLog += "Registro atual: " + cValtochar((cAliasTst)->(Recno())) + CRLF
        cLog += "Proximos registros: " + cValtochar(nProxReg) + CRLF
    EndIf 
    If lRest
        cLog += "Registro atual: " + cValtochar((cAliasTst)->(Recno())) + CRLF
        cLog += "Processado ate ultimo registro " + CRLF
    EndIf 

    IncLog("TABELA", cTabela, cLog)
    
    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Refresh()
        __aDicBrw[np]:SetFocus()
        eval(__aDicBrw[np]:bChange)
    EndIf

Return     

Static Function LocateTab(cAliasDic, np)
    Local cAliasTst  := __aDicTst[np]
    Local aRet       := {}
    Local cComando   := ""
    Local cFor       := ""
    Local cWhile     := ""
    Local nProxReg   := NIL
    Local lRest      := NIL
    Local cCampo     := ""
    Local cConteudo  := ""
    

    If Select(cAliasTst) == 0 .or. Empty(cAliasDic)
        Return 
    EndIf 
   

    aRet := aClone(TelaPar(cAliasTst, "Locate"))
    If Empty(aRet)
        Return 
    EndIf 


    cCampo    := aRet[1]
    cConteudo := aRet[2]
    cFor      := aRet[3]
    cWhile    := aRet[4]
    nProxReg  := aRet[5]
    lRest     := aRet[6]

    cComando := ""

    (cAliasTst)->(TelaDbEval(cComando, cFor, cWhile, Nil, .T., "Localizando registos", .F.))
    
    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Refresh()
        __aDicBrw[np]:SetFocus()
        eval(__aDicBrw[np]:bChange)
    EndIf

Return     

Static Function GotoTab(cAliasDic, np)
    Local cAliasTst := __aDicTst[np]
    Local nRecno    := 0
    Local oFontB    := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)
    Local lOk       := .F.
    Local oModal 
    Local oDlg
        
    If Select(cAliasTst) == 0 .or. Empty(cAliasDic)
        Return 
    EndIf 

    oModal  := FWDialogModal():New()       
	oModal:SetEscClose(.T.)
    oModal:setTitle("Posiciona no registro")
	oModal:setSize(100, 180)
    oModal:createDialog()
    oModal:addCloseButton({|| lOk:= .T., oModal:DeActivate() }, "OK")
    oModal:AddButton("Cancelar", {|| lOk:= .F., oModal:DeActivate() }     , "Cancelar",,.T.,.F.,.T.,)

    oDlg:= oModal:getPanelMain()
    
        oPS:= TPanelCss():New(,,, oDlg)
        oPS:SetCoors(TRect():New(0, 0, 75, 500))
        oPS:Align :=CONTROL_ALIGN_ALLCLIENT

            @ 023, 040 SAY "Recno"      of oPS SIZE 040, 10 PIXEL FONT oFontB
            @ 020, 070 Get oRecno  VAR nRecno  of oPS SIZE 040, 09 PIXEL PICT "999999999999"
       
    oModal:Activate()

    If ! lOk .OR. nRecno == 0
        Return 
    EndIf 

    (cAliasTst)->(DbGoto(nRecno))

    If __lDeleON .and. (cAliasTst)->(Deleted())
        FWAlertWarning("Registro deletado, desative Dele On para visualizar!")
    EndIf 
    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Refresh()
        __aDicBrw[np]:SetFocus()
        eval(__aDicBrw[np]:bChange)
    EndIf

Return 

Static Function ContaReg(cAliasDic,  np) 
    Local cAliasTst  := __aDicTst[np]
    Local cComando   := ""
    Local cFor       := ""
    Local cWhile     := ""
    Local nProxReg   := NIL
    Local lRest      := NIL
    Local cTabela    := ""
    
    If Select(cAliasTst) == 0 .or. Empty(cAliasDic)
        Return 
    EndIf 

    cTabela:= RetFileName((cAliasTst)->(DBInfo(10)))
    cComando := " AllwaysTrue() "
    (cAliasTst)->(TelaDbEval(cComando, cFor, cWhile, nProxReg, lRest, "Contando....."))
   
    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Refresh()
        __aDicBrw[np]:SetFocus()
        eval(__aDicBrw[np]:bChange)
    EndIf
    
Return 

Return 

Static Function DeleteTab(cAliasDic, np, lDelete)
    Local cAliasTst  := __aDicTst[np]
    Local aRet       := {}
    Local cComando   := ""
    Local cFor       := ""
    Local cWhile     := ""
    Local nProxReg   := NIL
    Local lRest      := NIL
    Local cLog       := ""
    Local cTabela    := ""
    

    If Select(cAliasTst) == 0 .or. Empty(cAliasDic)
        Return 
    EndIf 
    
    If __lReadOnly 
        FWAlertWarning("Somente leitura!!")
        Return 
    EndIf 

    cTabela:= RetFileName((cAliasTst)->(DBInfo(10)))
    If Upper(cTabela) == "TIDEVLOG"
        FWAlertWarning("Não é permitido manipular a tabela TIDEVLOG")
        Return 
    EndIf 

    aRet := aClone(TelaPar(cAliasTst, If(lDelete,"Delete", "Recall")))
    If Empty(aRet)
        Return 
    EndIf 

    If lDelete
        If ! FWAlertYesNo("Confirma a deleção dos registros?")
            Return
        EndIf 
    Else
        If ! FWAlertYesNo("Confirma a recuperação dos registros deletados?")
            Return
        EndIf 
    EndIf 
    cFor     := aRet[3]
    cWhile   := aRet[4]
    nProxReg := aRet[5]
    lRest    := aRet[6]

    If lDelete
        cLog += "Execução em bloco DELETE "+ CRLF
        cComando := "DbrLock(), DbDelete(), DbUnlock(), DbCommitall() "
        (cAliasTst)->(TelaDbEval(cComando, cFor, cWhile, nProxReg, lRest, "Deletando registos"))
    Else 
        cLog += "Execução em bloco RECALL "+ CRLF
        cComando := "DbrLock(), DbRecall(), DbUnlock(), DbCommitall() "
        (cAliasTst)->(TelaDbEval(cComando, cFor, cWhile, nProxReg, lRest, "Recuperando registos deletados"))
    EndIf
    
    cLog += "Tabela: " + cTabela + CRLF
    clog += "Filtro: " + (cAliasTst)->(dbFilter()) + CRLF
    clog += "Indice: " + (cAliasTst)->(IndexKey()) + CRLF + CRLF

    cLog += "COMANDO POR LINHA" + CRLF
    clog += cComando + CRLF + CRLF

    If cFor <> NIL 
        cLog += "Clausula FOR" + CRLF
        cLog += cFor + CRLF
    EndIf 
    If cWhile <> NIL 
        cLog += "Clausula FOR" + CRLF
        cLog += cWhile + CRLF
    EndIf 
    If nProxReg <> NIL 
        cLog += "Registro atual: " + cValtochar((cAliasTst)->(Recno())) + CRLF
        cLog += "Proximos registros: " + cValtochar(nProxReg) + CRLF
    EndIf 
    If lRest
        cLog += "Registro atual: " + cValtochar((cAliasTst)->(Recno())) + CRLF
        cLog += "Processado ate ultimo registro " + CRLF
    EndIf 

    IncLog("TABELA", cTabela, cLog)
   
    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Refresh()
        __aDicBrw[np]:SetFocus()
        eval(__aDicBrw[np]:bChange)
    EndIf
    
Return 

Static Function TelaDbEval(cComando, cFor, cWhile, nProxReg, lRest, cTitulo, lMsgFim, cInicio, cTermino)
    Local cMsg := ""
    Private nQtdRec  := 0
    Private lAbortPrint := .F.

    Default lMsgFim := .t.

    TIDevMsg(.t.)
    If cComando == NIl
        cComando := "TIDevMsg()" 
    Else 
        cComando += ", TIDevMsg()"
    EndIf 
    
    Processa({|| (ProcRegua(1),  TelaEval(cComando, cFor, cWhile, nProxReg, lRest, cInicio, cTermino))}, , , .T. )

    cMsg += "Total de linhas processadas: " + AllTrim(Str(nQtdRec))
    If lAbortPrint
        cMsg += CRLF + CRLF + " Execução parcial, processamento interrompido!"
    EndIf 
    If lMsgFim
        FWAlertSuccess(cMsg)
    EndIf 

Return

Static Function TIDevMsg(lInit)

    If lInit <> Nil 
        Return 
    EndIf  
    
    nQtdRec++
    IncProc("Processando linha: " + Alltrim(Str(nQtdRec, 8)))
    ProcessMessage()
    If lAbortPrint
        Break
    EndiF 

Return  NIL


Static Function TelaEval(cComando, cFor, cWhile, nProxReg, lRest, cInicio, cTermino)
    Local lOk    := .T.
    Local oErro  
    Local bBlock   := {|| .t. }
    Local bFor     := NIL 
    Local bWhile   := NIL 
    Local bInicio  := NIL
    Local bTermino := NIL
    
    __cErroA:= ""
    oErro := ErrorBlock( { |oErro| ChkErr( oErro ) } ) 
    Begin Sequence
        If cInicio != NIL
            bInicio := &("{||"+cValToChar(cInicio)+"}")
            Eval(bInicio)
        EndIf 

        If cComando != NIL
            bBlock := &("{||"+cValToChar(cComando)+"}")
        EndIf 
        If cFor != NIL .and. ! Empty(cFor)
            bFor := &("{||"+cValToChar(cFor)+"}")
        EndIf 
        If cWhile != NIl .and. ! Empty(cWhile)
            bWhile := &("{||"+cValToChar(cWhile)+"}")
        EndIf 

        DBEVAL(bBlock, bFor, bWhile, nProxReg, NIL, lRest)

        If cTermino != NIL
            bTermino := &("{||"+cValToChar(cTermino)+"}")
            Eval(bTermino)
        EndIf    
    End Sequence
    ErrorBlock(oErro)

    If ! Empty(__cErroA)
        AutoGrLog("")
        cErro := __cErroA
        FErase(NomeAutoLog())
        AutoGrLog(cErro)
        MostraLog()
        __cErroA :=""
        lOk := .F.
    EndIf 

Return lOk 




Static Function ExportTab(cAliasDic, np)
    Local cAliasTst  := __aDicTst[np]
    Local aRet       := {}
    Local cComando   := ""
    Local cFor       := ""
    Local cWhile     := ""
    Local cFormato   := ""
    Local cArquivo   := ""
    Local nProxReg   := NIL
    Local lRest      := NIL
    Local cDirTmp    := ""
    Local cNomTmp    := ""
    Local cDirRmt    := ""
    Local cNomArq    := ""
    Local cArqTmp    := ""
    Local nx 
    Local aStruct    := {}
    Local aArea      := {}
    

    Private __Export := NIL

    If Select(cAliasTst) == 0 .or. Empty(cAliasDic)
        Return 
    EndIf 
    

    aRet := aClone(TelaPar(cAliasTst, "Export"))
    If Empty(aRet)
        Return 
    EndIf 

    If ! FWAlertYesNo("Confirma a exportação dos registros?")
        Return
    EndIf 

    cFor     := aRet[3]
    cWhile   := aRet[4]
    nProxReg := aRet[5]
    lRest    := aRet[6]
    cFormato := aRet[7]
    cArquivo := aRet[8]

    //trata caminho tmp no server
    If ! cFormato == "Tabela"
        cDirTmp   := "\TIDBF\"
        cNomTmp   := "TMP" + FWTimeStamp() + "." + cFormato
        nx := Rat("\", cArquivo) 
        If nx > 0
            cDirRmt := Left(cArquivo, nx)
            cNomArq := Subs(cArquivo, nx + 1)
        Else
            cDirRmt := ""
            cNomArq := cArquivo
        EndIf 
        // Trata os caminho e nome de arquivo no Server
        If ! ExistDir(cDirTmp)
            MakeDir(cDirTmp)
        EndIf 

        cArqTmp  := cDirTmp + cNomTmp
        If File(cArqTmp)
            FErase(cArqTmp)
        EndIf 
    EndIf 

    aStruct := (cAliasTst)->(DbStruct())
    cAliasTmp := "TITMPNEW"
    aArea := GetArea()

    //cComando := "DbrLock(), DbDelete(), DbUnlock(), DbCommitall() "
    If cFormato == "Tabela"
        If TcCanopen(cArquivo)
			TcDelFile(cArquivo)
        EndIf
        Dbcreate(cArquivo, aStruct, "TOPCONN")
        DbUseArea(.T.,"TOPCONN", cArquivo, cAliasTmp,.F.,.F.)
        cComando := "LinDb() "
        __Export := cAliasTmp
    ElseIf cFormato == "DTC"
        Dbcreate(cArqTmp, aStruct, "DBF" + "CDX")
        DbUseArea(.T., "DBF" + "CDX", cArqTmp, cAliasTmp,.F.,.F.)
        LinDb(.t.)
        cComando := "LinDb() "
        __Export := cAliasTmp
    ElseIf cFormato == "CSV"
        __Export := cArqTmp
        (cAliasTst)->(GrvCabCSV(__Export))
        cComando := "GrvLinCSV() "

    ElseIf cFormato == "XML"
        __Export := FWMSEXCEL():New()
        (cAliasTst)->(CabXml(__Export))
        cComando := "LinXml() "

    ElseIf Left(cFormato, 3) == "XLS"
        __Export:= TIDBF():New(cArqTmp)
        
        If ! __Export:Create(aStruct)
            Return 
        Endif
        If !__Export:Open(.T.,.T.)
            Return .F.
        Endif
        LinExel(.t.)
        cComando := "LinExel() "

    EndIf
    
    (cAliasTst)->(TelaDbEval(cComando, cFor, cWhile, nProxReg, lRest, "Exportanto registos"))

    If cFormato == "Tabela"
        (cAliasTmp)->(DbCloseArea())
    ElseIf cFormato == "DTC"
        (cAliasTmp)->(DbCloseArea())
    ElseIf cFormato == "XML"
        __Export:Activate()
        __Export:GetXMLFile(cArqTmp)
        __Export := FreeObj(__Export)

    ElseIf Left(cFormato, 3) == "XLS"
        __Export:Close()
        FreeObj(__Export)
    EndIf

    If cFormato != "Tabela"
        If Subs(cDirRmt, 2, 2) == ":\"  // se o destino for remote
            If CpyS2T(cArqTmp, cDirRmt)
                Ferase(cArqTmp)
            EndIf
            If FRename(cDirRmt + cNomTmp,  cDirRmt + cNomArq) = -1
                FWAlertWarning("Não foi possivel renomear o arquivo " + cDirRmt + cNomTmp )
            Else
                FWAlertSuccess("Export concluido em " + cArquivo)
                If cFormato != "DTC" 
                    ShellExecute("open", cArquivo, "", "", 1)
                EndIf 
            EndIf 
        Else // se o destino for no server
            If FRename(cArqTmp,  cArquivo) = -1
                FWAlertWarning("Não foi possivel renomear o arquivo " + cDirRmt + cNomTmp )
            Else 
                FWAlertSuccess("Export concluido em " + cArquivo)
            EndIf 
        EndIf 
    EndIf 

    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Refresh()
        __aDicBrw[np]:SetFocus()
        eval(__aDicBrw[np]:bChange)
    EndIf

    RestArea(aArea)

Return     

Static Function ImportTab(cAliasDic, np)
    Local cAliasTst  := __aDicTst[np]
    Local aRet       := {}
    Local cFormato   := ""   //{"Tabela", "DTC", "CSV", "XML", "XLS"}
    Local cArquivo   := ""
    Local cAliasTmp  := "TITMPIMP"
    Local oDBF
    Local aArea      :=  GetArea()
    Local cLog       := ""
    Local cTabela    := ""
    Local nRecAntes  := 0
    Local nRecApos   := 0
    Private lAbortPrint := .F.


    If Select(cAliasTst) == 0 .or. Empty(cAliasDic)
        Return 
    EndIf 
    If __lReadOnly 
        FWAlertWarning("Somente leitura!!")
        Return 
    EndIf 
    aRet := aClone(TelaImp())
    If Empty(aRet)
        Return 
    EndIf 

    
    cTabela:= RetFileName((cAliasTst)->(DBInfo(10)))
    nRecAntes := (cAliasTst)->(RecCount())
    If Upper(cTabela) == "TIDEVLOG"
        FWAlertWarning("Não é permitido manipular a tabela TIDEVLOG")
        Return 
    EndIf 

    If ! FWAlertYesNo("Confirma a importação dos registros?")
        Return
    EndIf 

    cFormato := aRet[1]
    cArquivo := aRet[2]
 
    If Select(cAliasTmp) > 0
        (cAliasTmp)->(DbCloseArea())
    EndIf

    cLog += "Import de: " + cArquivo + " (" + cFormato + ") " + CRLF
    cLog += "para: " + cTabela + CRLF + CRLF 
    cLog += "LastRec antes do import: " + cValToChar(nRecAntes) + CRLF
    
    If cFormato == "Tabela"
        DbUseArea(.T.,"TOPCONN", cArquivo, cAliasTmp, .T., .F.)
        If NetErr()
		    FWAlertWarning("Erro de abertura de arqvivo")
            RestArea(aArea)
		    Return .F.
	    EndIf
        Processa({|| PrcImpTab(cAliasTst, cAliasTmp)}, "Importando ....","Aguarde", .t.)

        (cAliasTmp)->(DbCloseArea())        
    ElseIf cFormato == "DTC"
        DbUseArea(.T.,"DBF" + "CDX", cArquivo, cAliasTmp, .T.,.F.) 
        If NetErr()
		    FWAlertWarning("Erro de abertura de arqvivo")
            RestArea(aArea)
		    Return .F.
	    EndIf
        Processa({|| PrcImpTab(cAliasTst, cAliasTmp)}, "Importando ....","Aguarde", .t.)

        (cAliasTmp)->(DbCloseArea())
        If Left(cArquivo, 13) == "system\tidev\"
            FErase(cArquivo)
        EndIf 
    ElseIf cFormato == "CSV"
        
        Processa({|| PrcImpCSV(cArquivo, cAliasTst)}, "Importando ....","Aguarde", .t.)
        
        If Left(cArquivo, 13) == "system\tidev\"
            FErase(cArquivo)
        EndIf 

    ElseIf Left(cFormato, 3) == "XLS"
        oDBF := TIDBF():New(cArquivo)
        If !oDBF:Open(.T.,.T.)
            Return .F.
        Endif

        Processa({|| PrcImpXLS(cAliasTst, oDBF) }, "Importando ....","Aguarde", .t.)

        oDBF:Close()
        FreeObj(oDBF)
        If Left(cArquivo, 13) == "system\tidev\"
            FErase(cArquivo)
        EndIf
    EndIf
    nRecApos := (cAliasTst)->(RecCount())
    cLog += "LastRec depois do import: " + cValToChar(nRecApos) + CRLF
    IncLog("TABELA", cTabela, cLog)    

    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Refresh()
        __aDicBrw[np]:SetFocus()
        eval(__aDicBrw[np]:bChange)
    EndIf
    RestArea(aArea)
Return 


Static Function TelaImp()
    Local oFontB    := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)
    Local oDlg 
    Local oPE 
    Local lOk       := .F.

    Local oFormato   
    Local aFormato  := {"Tabela", "DTC", "CSV", "XLS (DBF4)"}
    Local cFormato  := "Tabela"
    Local cArquivo  := Space(200)
    Local oArquivo 
    Local oModal   
    
    oModal  := FWDialogModal():New()       
	oModal:SetEscClose(.T.)
    oModal:setTitle("Import")
	oModal:setSize(100, 280)
    oModal:createDialog()
    oModal:addCloseButton({|| If(!Empty(cArquivo) , (lOk:= .T., oModal:DeActivate()), .F.)}, "OK")
    oModal:AddButton("Cancelar", {|| lOk:= .F., oModal:DeActivate() }     , "Cancelar",,.T.,.F.,.T.,)

    oDlg:= oModal:getPanelMain()

        oPE:= TPanelCss():New(,,, oDlg)
        oPE:SetCoors(TRect():New(0, 0, 75, 500))
        oPE:Align :=CONTROL_ALIGN_ALLCLIENT

            @ 005, 005 SAY "Formato"  of oPE SIZE 050, 10 PIXEL FONT oFontB
            @ 005, 065 SAY "Arquivo"  of oPE SIZE 050, 10 PIXEL FONT oFontB
            
            @ 015, 005 MSCOMBOBOX oFormato  VAR cFormato ITEMS aFormato   SIZE 50,09 PIXEL OF oPE  VALID (cArquivo :=Space(20), If(cFormato=="Tabela", oBGF:Hide(),oBGF:Show()  ) , .t.) 
            @ 015, 065 Get        oArquivo  VAR cArquivo of oPE SIZE 200, 09 PIXEL PICT "@!" WHEN oFormato:nAt == 1 VALID VldArq(@cArquivo)
            oBGF := THButton():New(015, 267, "..."        , oPE, {|| SelArquivo(cFormato, @cArquivo, "I", oModal) }, 10, 10, oFontB, "Informa o arquivo")
            oBGF:Hide()

        
      oModal:Activate()

    If ! lOk
        Return {}
    EndIf 

    cArquivo := Alltrim(cArquivo)

Return {cFormato, cArquivo} 

Static Function VldArq(cArquivo)
    cArquivo := Alltrim(cArquivo)
    If Empty(cArquivo)
        FWAlertWarning("Arquivo não informado!")
        cArquivo  := Space(200)
        Return .F. 
    EndIf   

    If ! MsFile(cArquivo,, "TOPCONN")
        FWAlertWarning("Arquivo " + cArquivo + " não existe no banco!")
        cArquivo  := Space(200)
        Return .F. 
    EndIf     
Return .T.

Static Function PrcImpTab(cAliasTst, cAliasTmp )
    Local aStru    := (cAliasTst)->(DbStruct())
    Local nFields  := Len(aStru)
    Local aStruTmp := (cAliasTmp)->(DbStruct())
    Local nX 
    Local cCampo   := ""
    Local nQtdRec  := 0
    Local cMsg     := ""
    Local nPos     := 0
    

    For nx:= 1 to len(aStru)
        cCampo := aStru[nx, 1]
        nPos := Ascan(aStruTmp, {|x| Upper(x[1]) == Upper(cCampo) })
        If nPos > 0
            Exit 
        EndIf 
    Next 

    If nPos == 0 
        FWAlertWarning("Tabela de origem sem nenhum campo correspondente na tabela de destino!")
        Return 
    EndIf 

    ProcRegua(1)

    (cAliasTmp)->(DbGoTop())
    While (cAliasTmp)->(! Eof())

        nQtdRec++
        IncProc("Processando linha: " + Alltrim(Str(nQtdRec, 8)))
        ProcessMessage()
        If lAbortPrint
            Exit
        EndiF 
    
        (cAliasTst)->(RecLock(cAliasTst, .T.))
        For nx:= 1 to nFields
            cCampo := aStru[nx, 1]
            nPos := Ascan(aStruTmp, {|x| Alltrim(Upper(x[1])) == Alltrim(Upper(cCampo)) })
            If Empty(nPos)
                Loop 
            EndIf 

            (cAliasTst)->(FieldPut(nx, (cAliasTmp)->(FieldGet(nPos))))
        Next
        (cAliasTst)->(DbUnlock())
        (cAliasTst)->(dbCommit())

        (cAliasTmp)->(DbSkip())
    End
    
    cMsg += "Total de linhas processadas: " + AllTrim(Str(nQtdRec))
    If lAbortPrint
        cMsg += CRLF + CRLF + " Execução parcial, processamento interrompido!"
    EndIf 
    FWAlertSuccess(cMsg)
    

Return

Static Function PrcImpCSV(cArquivo, cAliasTst)
    Local aStru    := (cAliasTst)->(DbStruct())
    Local nFields  := Len(aStru)
    Local aCabCSV  := {}
    Local cLinha   := ""
    Local nX 
    Local cCampo   := ""
    Local cTipo    := ""
    Local nTam     := 0
    Local nDec     := 0
    Local nQtdRec  := 0
    Local uVar
    Local cMsg     := ""
    Local cSep     := ";"
    Local nPos     := 0
    Local oFile   

    oFile:= TIFileReader():New(cArquivo)
    If ! oFile:Open()
        FWAlertWarning("Não foi possivel abrir o arquivo " + cArquivo)
        Return 
    EndIf 
    
    cLinha  := oFile:GetLine()
    aCabCSV := separa(cLinha, cSep) 

    For nx:= 1 to len(aStru)
        cCampo := aStru[nx, 1]
        nPos := Ascan(aCabCSV, {|x| Upper(x) == Upper(cCampo) })
        If nPos > 0
            Exit 
        EndIf 
    Next 

    If nPos == 0 
        FWAlertWarning("Tabela de origem sem nenhum campo correspondente na tabela de destino!")
        Return 
    EndIf 

    ProcRegua(1)
    
    While ! oFile:Eof() 

        nQtdRec++
        IncProc("Processando linha: " + Alltrim(Str(nQtdRec, 8)))
        ProcessMessage()
        If lAbortPrint
            Exit
        EndiF 

        cLinha  := oFile:GetLine()
        aItemCSV := separa(cLinha, cSep)
    
        (cAliasTst)->(RecLock(cAliasTst, .T.))
        For nx:= 1 to nFields
            cCampo := aStru[nx, 1]
            cTipo  := aStru[nx, 2]
            nTam   := aStru[nx, 3]
            nDec   := aStru[nx, 4]

            nPos  := ascan(aCabCSV, { |x|  Alltrim(Upper(x)) == Alltrim(Upper(aStru[nx, 1])) })
            If Empty(nPos)
                Loop 
            EndIf 
            uVar := Alltrim(aItemCSV[nPos])
            If cTipo == "C"
                uVar := Padr(uVar, nTam)
            ElseIf cTipo== "N"
                uVar := StrTran(uVar, ",",".")
                uVar := Val(uVar)
            ElseIf cTipo == "D"
                uVar:= ctod(uVar)
            ElseIf cTipo == "M"
                uVAr :=uVar
            ElseIf cTipo == "L"
                uVar :=  "T" $ Upper(uVar) 
            EndIf 

            (cAliasTst)->(FieldPut(nx, uVar))
        Next
        (cAliasTst)->(DbUnlock())
        (cAliasTst)->(dbCommit())

        
    End
    
    cMsg += "Total de linhas processadas: " + AllTrim(Str(nQtdRec))
    If lAbortPrint
        cMsg += CRLF + CRLF + " Execução parcial, processamento interrompido!"
    EndIf 
    FWAlertSuccess(cMsg)
    
    oFile:Close()
    FreeObj(oFile)
    oFile:= NIL 

Return

Static Function PrcImpXLS(cAliasTst, oDBF)
    Local aStru    := (cAliasTst)->(DbStruct())
    Local nFields  := Len(aStru)
    Local aStruTmp := oDBF:GetStruct()
    Local nX 
    Local cCampo   := ""
    Local nQtdRec  := 0
    Local cMsg     := ""
    Local nPos     := 0
    Local uVAr
    

    For nx:= 1 to len(aStru)
        cCampo := aStru[nx, 1]
        nPos := Ascan(aStruTmp, {|x| Upper(x[1]) == Upper(cCampo) })
        If nPos > 0
            Exit 
        EndIf 
    Next 

    If Empty(nPos) 
        FWAlertWarning("Tabela de origem sem nenhum campo correspondente na tabela de destino!")
        Return 
    EndIf 

    ProcRegua(1)

    oDBF:GoTop()
    While ! oDBF:EOF()

        nQtdRec++
        IncProc("Processando linha: " + Alltrim(Str(nQtdRec, 8)))
        ProcessMessage()
        If lAbortPrint
            Exit
        EndiF 
    
        (cAliasTst)->(RecLock(cAliasTst, .T.))
        For nx:= 1 to nFields

            cCampo := aStru[nx, 1]
            nPos := Ascan(aStruTmp, {|x| Alltrim(Upper(x[1])) == Alltrim(Upper(cCampo)) })
            If Empty(nPos)
                Loop
            EndIf
            uVar := oDBF:FieldGet(nPos)
            (cAliasTst)->(FieldPut(nx, uVar))
        Next
        (cAliasTst)->(DbUnlock())
        (cAliasTst)->(dbCommit())

        oDBF:Skip()
    End
    
    cMsg += "Total de linhas processadas: " + AllTrim(Str(nQtdRec))
    If lAbortPrint
        cMsg += CRLF + CRLF + " Execução parcial, processamento interrompido!"
    EndIf 
    FWAlertSuccess(cMsg)
    

Return 


Static Function AtuMsg(oBrow, oMsg, oMsg2)
    Local cMsg  := ""
    Local cMsg2 := ""

    If Eof() 
        If Bof()
            cMsg := "Arquivo vazio"
            If ! Empty(dbFilter())
                cMsg += " | Filter: " + dbFilter()     
            EndIf 
        Else 
            cMsg := "EOF"
        EndIf 
    Else 
        cMsg  := "Recno   : " + Transform(Recno(), "@E 999,999,999" )
        cMsg2 := "RecCount: " + Transform(RecCount(), "@E 999,999,999" ) 
        cMsg  += " | Index[" + AllTrim(Str(IndexOrd())) + "]: " + IndexKey() 
        cMsg2 += " | Filter: " + dbFilter() 
        If Deleted()
            cMsg += " | Deletado "
        EndIf 
    EndIf 
    oMsg:SetText(cMsg)
    oMsg:Refresh()
    oMsg2:SetText(cMsg2)
    oMsg2:Refresh()

    oBrow:CallRefresh()
    //ProcessMessage()

Return 

Static Function DelOn(np)
    
    If type("oMsgIt3") == "O" 
        If __lDeleOn
            Set(11,"on")
            oMsgIt3:SetText("Dele On")
        Else
            Set(11,"off")
            oMsgIt3:SetText("Dele Off")
        EndIf
        oMsgIt3:Refresh()
    EndIf 

    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Refresh()
        __aDicBrw[np]:SetFocus()
        eval(__aDicBrw[np]:bChange)
    EndIf

Return .t.

Static Function DelRecno(nP, lConfirm)
    Local cAliasTst := __aDicTst[np]
    Local cTabela   := ""
    Local cLog      := ""
    Default	lConfirm := .T.

    If (cAliasTst)->(EOF())
        FWAlertWarning("Arquivo vazio")
        Return
    EndIf
    /*If __lDeleOn 
        FWAlertWarning("Para deletar desative o Dele On!")
        Return 
    EndIf
    */
    If __lReadOnly 
        FWAlertWarning("Somente leitura!!")
        Return 
    EndIf

    cTabela:= RetFileName((cAliasTst)->(DBInfo(10)))
    If Upper(cTabela) == "TIDEVLOG"
        FWAlertWarning("Não é permitido manipular a tabela TIDEVLOG")
        Return 
    EndIf 

    If lConFirm 
        If (cAliasTst)->(Deleted())
            If ! FWAlertYesNo("Recuperar registro?", "Confirma") 
                Return
            EndIf
        Else
            If ! FWAlertYesNo("Deletar registro?", "Confirma") 
                Return
            EndIf
        EndIf 
    EndIf

    If ! (cAliasTst)->(simplelock()) 
        FWAlertInfo("Registro com lock!")
        Return 
    EndIf 

    (cAliasTst)->(DbRlock())
    If (cAliasTst)->(Deleted())
        (cAliasTst)->(DbRecall())
        cLog += "Recuperado o registro recno: " +cValToChar((cAliasTst)->(Recno()))
    Else
        (cAliasTst)->(DbDelete())
        cLog += "Deletado o registro recno: " +cValToChar((cAliasTst)->(Recno()))
    EndIf
    (cAliasTst)->(DbUnlock())
    (cAliasTst)->(DbCommitAll())
    
    
    IncLog("TABELA", cTabela, cLog)

    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Refresh()
        __aDicBrw[np]:SetFocus()
        eval(__aDicBrw[np]:bChange)
    EndIf
  
Return

Static Function AddRecno(nP)
    Local cAliasTst := __aDicTst[np]
    Local cTabela   := ""
    Local cLog      := "Inclusão de registro recno: "
       
    
    If __lReadOnly 
        FWAlertWarning("Somente leitura!!")
        Return 
    EndIf 

    cTabela:= RetFileName((cAliasTst)->(DBInfo(10)))
    If Upper(cTabela) == "TIDEVLOG"
        FWAlertWarning("Não é permitido manipular a tabela TIDEVLOG")
        Return 
    EndIf 

    If ! FWAlertYesNo("Adicionar registro?", "Confirma") 
        Return
    EndIf

    (cAliasTst)->(dbAppend())
    (cAliasTst)->(DbUnlock())
    (cAliasTst)->(DbCommitAll())

    cLog += cValToChar((cAliasTst)->(Recno()))
    IncLog("TABELA", cTabela, cLog)

Return     

Static Function AltReg(oBrowse, cAliasTst, lQuery, np)
    Local oDlg
    Local oRect
    Local oGet
    Local oBtn
    Local cMacro	:= ''
    Local nRow      := oBrowse:nAt 
    Local oOwner    := oBrowse:oWnd 
    Local nLastKey
    Local cTipo
    Local cPict		:= ''
    Local aItems	:= {'.T.','.F.'}
    Local cCbx		:= '.T.'
    Local cField
    Local aStruct   := {}
    Local nCol      := oBrowse:nColPos
    Local lLeitura  := .f.
    Local oFont     := oOwner:oFont
    Local nClrFore
    Local nPos      := 0
    Local cTabela   := ""
    Local cLog      := "Alteração de registro "
    Local cAntes    := ""
    Local cDepois   := ""
    Local oModal 
    Default lQuery := .F.
     

    If __lReadOnly .or. lQuery
        lLeitura := .t.
        nClrFore := Rgb(255,0,0)
    EndIf 
    
    If !  lLeitura
        If  ! (cAliasTst)->(simplelock()) 
            FWAlertInfo("Registro com lock!")
            Return 
        EndIf
        (cAliasTst)->(RecLock(cAliasTst))
    EndIf 

    oRect	 := tRect():New(0,0,0,0)        
    oBrowse:GetCellRect(nCol,,oRect)  
    aDim  	 := {oRect:nTop, oRect:nLeft, oRect:nBottom, oRect:nRight}

    aStruct  := (cAliasTst)->(dbStruct())
    If ! lQuery
        cField   := __aNewBrw[np, nCol]
        npos     := Ascan(aStruct, {|x| x[1] == cField})
    Else 
        npos     := nCol
        cField   := aStruct[npos, 1]
    EndIf 

    cTipo := aStruct[npos, 2]
    If cTipo == "N" 
        If aStruct[npos, 4] > 0 
            cPict := Replicate("9", aStruct[npos, 3] - (aStruct[npos, 4] + 1)) + "." + Replicate("9", aStruct[npos, 4])
        Else
            cPict := Replicate("9", aStruct[npos, 3])
        EndIf
    ElseIf cTipo == "D"
        cPict := "@D"
    EndIf

    cMacro 	 := "M->CELL"+StrZero(nRow, 6)
    &cMacro	 := (cAliasTst)->(FieldGet(FieldPos(cField)))

    If cTipo == "M"


        oModal  := FWDialogModal():New()       
        oModal:SetEscClose(.T.)
        oModal:setTitle("Campo memo " + cField )
        oModal:setSize(240, 280)
        oModal:createDialog()
        nLastKey := 0
        If ! lLeitura
            oModal:addCloseButton({||  nLastKey := 13 ,oModal:DeActivate()}, "Gravar")
            oModal:AddButton("XML" , {|| (&cMacro) := XMLFormat((&cMacro))  }     , "Formata conteudo XML",,.T.,.F.,.T.,)
            oModal:AddButton("JSon", {|| (&cMacro) := JsonFormat((&cMacro)) }     , "Formata conteudo JSon",,.T.,.F.,.T.,)
            oModal:AddButton("Sair", {|| oModal:DeActivate() }     , "Sair",,.T.,.F.,.T.,)
        Else 
            oModal:AddButton("Sair", {|| oModal:DeActivate() }     , "Sair",,.T.,.F.,.T.,)
            oModal:AddButton("XML" , {|| (&cMacro) := XMLFormat((&cMacro))  }     , "Formata conteudo XML",,.T.,.F.,.T.,)
            oModal:AddButton("JSon", {|| (&cMacro) := JsonFormat((&cMacro)) }     , "Formata conteudo JSon",,.T.,.F.,.T.,)
        EndIf 
        
        oDlg:= oModal:getPanelMain()
        
            oGet := TMultiGet():New(0,0,bSetGet(&(cMacro)),oDlg,399,049,oFont,.F.,,,,.T.,,,,,, ,,,,.F.)
            oGet:cReadVar  := cMacro
            oGet:align := CONTROL_ALIGN_ALLCLIENT
            oModal:Activate()


    Else
        DEFINE MSDIALOG oDlg OF oOwner  FROM 000,000 TO 000,000 STYLE nOR( WS_VISIBLE, WS_POPUP ) PIXEL
            If cTipo == 'L' 
                cCbx := If(&(cMacro), '.T.', '.F.')
                oGet := TComboBox():New(0, 0, bSetGet(cCbx),aItems, 10, 10, oDlg,, {|| If(cCbx == '.T.', &(cMacro) := .T., &(cMacro) := .F.), oDlg:End(), nLastKey := 13},,,,.T., oFont)
                oGet:Move(-2, -2, (aDim[4] - aDim[2]) + 4, aDim[3] - aDim[1] + 4)
            Else
                oGet := TGet():New(0, 0, bSetGet(&(cMacro)), oDlg, 0, 0, cPict,,nClrFore,, oFont,,, .T.,,,,,,, /*lLeitura*/,,,,,,,, .T.)
                oGet:Move(-2,-2, (aDim[4] - aDim[2]) + 4, aDim[3] - aDim[1] + 4 )
                oGet:cReadVar  := cMacro
            EndIf
            
            @ 0, 0 BUTTON oBtn PROMPT "QQ" SIZE 0,0 OF oDlg
            oBtn:bGotFocus := {|| oDlg:nLastKey := VK_RETURN, oDlg:End()}
        ACTIVATE MSDIALOG oDlg ON INIT oDlg:Move(aDim[1], aDim[2],aDim[4] - aDim[2], aDim[3] - aDim[1])  VALID ( nLastKey := oDlg:nLastKey, .T. )

    EndIf 
    
    If ! lLeitura
        cTabela:= RetFileName((cAliasTst)->(DBInfo(10)))
        If ( nLastKey <> 0 )
            If Upper(cTabela) == "TIDEVLOG"
                FWAlertWarning("Não é permitido manipular a tabela TIDEVLOG")
                oBrowse:Refresh()
                Return 
            EndIf 
        EndIf  


        cAntes := cValToChar((cAliasTst)->(FieldGet(FieldPos(cField))))
        If ( nLastKey <> 0 )
            (cAliasTst)->(FieldPut(FieldPos(cField), (&cMacro)))
            oBrowse:nAt := nRow
            SetFocus(oBrowse:hWnd)
            cDepois := cValToChar((cAliasTst)->(FieldGet(FieldPos(cField))))
        EndIf
        (cAliasTst)->(DbUnLock())
        (cAliasTst)->(DbCommit())
        
        If ( nLastKey <> 0 ) .and. ! Alltrim(cAntes) == Alltrim(cDepois)
            cLog += cValToChar((cAliasTst)->(Recno())) + CRLF
            cLog += "Campo: " + cField + CRLF
            cLog += "De   : " + cAntes + CRLF
            cLog += "Para : " + cDepois + CRLF
            IncLog("TABELA", cTabela, cLog)
        EndIf 
        
    EndIf 
    oBrowse:Refresh()
Return


Static Function Estrutura(cAliasDic, np)
    Local oDlg
    Local oLbx
    Local aStruct
    Local cAliasTst := __aDicTst[np]
    Local oP1
    Local oOrdem
    Local aOrdem := {"Natural","Nome"}
    Local cOrdem := "Natural"
    Local cPesquisa := Space(10)
    Local oModal
    Local oFontB := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)
    Local nx

    If Empty(cAliasDic)
        FWAlertWarning("Alias não informado!!!")
        Return 
    EndIf 

    aStruct := (cAliasTst)->(DbStruct())
    For nx:= 1 to len(aStruct)
        aadd(aStruct[nx], "")
    Next 

    oModal  := FWDialogModal():New()       
	oModal:SetEscClose(.T.)
    oModal:setTitle("Estrutura: " + Alltrim(cAliasDic) + " com " + Alltrim(Str(Len(aStruct))) + " campos")
	oModal:setSize(260, 200)
    oModal:createDialog()
    oModal:addCloseButton({|| oModal:DeActivate() }, "OK")

    oDlg:= oModal:getPanelMain()
    
        oP1:= TPanelCss():New(,,, oDlg)
        oP1:SetCoors(TRect():New(0, 0, 38, 100))
        oP1:Align :=CONTROL_ALIGN_TOP

        @ 007, 002 SAY "Ordem "   of oP1 SIZE 030, 10 PIXEL font oFontB
        @ 005, 032 MSCOMBOBOX oOrdem    VAR cOrdem    ITEMS aOrdem   SIZE 40, 09 PIXEL OF oP1 VALID OrdemEstru(cOrdem, oLbx, aStruct, np)  font oFontB

        @ 007, 092 SAY "Busca"    of oP1 SIZE 030, 10 PIXEL font oFontB
        @ 005, 122 GET cPesquisa  of oP1 SIZE 060, 09 PIXEL PICT "@!" VALID BuscaEstru(oLbx, cPesquisa)  font oFontB


        @ 002, 002 LISTBOX oLbx FIELDS HEADER "Campo", "Tipo", "Tamanho", "Decimal", " " SIZE 158,095 PIXEL OF oDlg 
        oLbx:Align :=CONTROL_ALIGN_ALLCLIENT
        oLbx:SetArray( aStruct )
        oLbx:bLine := {|| Retbline(oLbx, aStruct ) }
        oLbx:SetFocus()

    oModal:Activate()

Return 



Static Function OrdemEstru(cOrdem, oLbx, aStruct, np) 
    Local cAliasTst := __aDicTst[np]
    
    If cOrdem == "Natural"
        aStruct := (cAliasTst)->(DbStruct())
    Else 
        aSort(aStruct,,, { |x,y| x[1] < y[1] })
    EndIf 
    
    oLbx:SetArray( aStruct )
    oLbx:bLine := {|| Retbline(oLbx, aStruct ) }
    oLbx:Refresh()
    oLbx:SetFocus()

Return 

Static Function BuscaEstru(oLbx, cPesquisa) 
    Local np := 0
    Local nL := len(Alltrim(cPesquisa))

    np := Ascan(oLbx:aArray, {|x| Left(x[1], nL) == Alltrim(cPesquisa) })
    If Empty(np)
        Return  
    EndIf 

    oLbx:nAt := np
    oLbx:Refresh()
    oLbx:SetFocus()

Return



Static Function ReorgColu(cAliasDic, oP2ant, np, oIndice, oMsg, oMsg2 )
    Local oDlg
    Local oLbx1
    Local oLbx2
    Local aStruct  := {}
    Local aNewStru := {}
    Local cAliasTst := __aDicTst[np]
    Local oP1
    Local oP2
    Local oModal 
    Local oOrdem
    Local aOrdem := {"Natural","Nome"}
    Local cOrdem := "Natural"
    Local cPesquisa := Space(10)
    Local cLista := Space(220)
    Local nx     := 0 

    Local oFontB := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)

    If Empty(cAliasDic)
        FWAlertWarning("Alias não informado!!!")
        Return 
    EndIf 

    aStruct := (cAliasTst)->(DbStruct())
    If __aNewBrw[np] <> NIL 
        For nx := 1 to len(__aNewBrw[np])
            If Empty(__aNewBrw[np, nx])
                Loop 
            EndIf 
            aadd(aNewStru, {__aNewBrw[np, nx]})
        Next 
    else
        aNewStru  := {{""}}    
    EndiF  

    oModal  := FWDialogModal():New()       
	oModal:SetEscClose(.T.)
    oModal:setTitle("Reorganizar colunas (visão) " + Alltrim(cAliasDic) + " com " + Alltrim(Str(Len(aStruct))) + " campos")
	oModal:setSize(260, 280)
    oModal:createDialog()
    oModal:addCloseButton({|| NewOk(oLbx2, cAliasDic, oP2ant, np, oIndice, oMsg, oMsg2), oModal:DeActivate() }, "OK")
    oModal:AddButton("Cancelar", {|| oModal:DeActivate() }     , "Cancelar",,.T.,.F.,.T.,)

    oDlg:= oModal:getPanelMain()
        
        oP1:= TPanelCss():New(,,, oDlg)
        oP1:SetCoors(TRect():New(0, 0, 76, 100))
        oP1:Align :=CONTROL_ALIGN_TOP

            @ 007, 002 SAY "Inserir lista usando , "   of oP1 SIZE 090, 10 PIXEL font oFontB
            @ 005, 090 GET cLista             of oP1 SIZE 180, 09 PIXEL PICT "@!" VALID InsLista(cLista, oLbx1, oLbx2)  font oFontB
            
            @ 025, 002 SAY "Ordem "   of oP1 SIZE 030, 10 PIXEL font oFontB
            @ 023, 032 MSCOMBOBOX oOrdem    VAR cOrdem    ITEMS aOrdem   SIZE 40, 09 PIXEL OF oP1 VALID OrdemEstru(cOrdem, oLbx1, aStruct, np) font oFontB

            @ 025, 092 SAY "Busca"    of oP1 SIZE 030, 10 PIXEL font oFontB
            @ 023, 122 GET cPesquisa  of oP1 SIZE 060, 09 PIXEL PICT "@!" VALID BuscaEstru(oLbx1, cPesquisa)  font oFontB

            oBH   := THButton():New(023, 182, "Histórico"       ,oP1, {|| MenuCmp(oLbx1, oLbx2, oBH, cAliasDic)    }, 42, 10, oFontB, "Lista com o histórico") 


        oP2:= TPanelCss():New(,,, oDlg)
        oP2:SetCoors(TRect():New(0, 0, 38, 100))
        oP2:Align :=CONTROL_ALIGN_ALLCLIENT
        
            @ 000, 000 LISTBOX oLbx1 FIELDS HEADER "Visão original" SIZE 123,200 PIXEL OF oP2 
            oLbx1:Align :=CONTROL_ALIGN_LEFT
            oLbx1:SetArray( aStruct )
            oLbx1:bLDblClick := {|| InsNew(oLbx1, oLbx2) }
            oLbx1:bLine := {|| Retbline(oLbx1, aStruct ) }
            oLbx1:SetFocus()

            oP3:= TPanelCss():New(,,, oP2)
            oP3:SetCoors(TRect():New(0, 0, 65, 65))
            oP3:Align :=CONTROL_ALIGN_LEFT

            @ 020, 10 BITMAP oBmp01 NAME "RIGHT"     SIZE 015, 015 OF oP3 PIXEL NOBORDER ON CLICK InsNew(oLbx1, oLbx2)
            @ 040, 10 BITMAP oBmp01 NAME "RIGHT_2"   SIZE 015, 015 OF oP3 PIXEL NOBORDER ON CLICK InsAllNew(oLbx1, oLbx2)
            @ 060, 10 BITMAP oBmp01 NAME "UP"        SIZE 015, 015 OF oP3 PIXEL NOBORDER ON CLICK UpNew(oLbx2)
            @ 080, 10 BITMAP oBmp01 NAME "DOWN"      SIZE 015, 015 OF oP3 PIXEL NOBORDER ON CLICK Down(oLbx2)
            @ 100, 10 BITMAP oBmp01 NAME "BMPDEL"    SIZE 015, 015 OF oP3 PIXEL NOBORDER ON CLICK DelNew(oLbx2)
            @ 120, 10 BITMAP oBmp01 NAME "SDUDRPTBL" SIZE 015, 015 OF oP3 PIXEL NOBORDER ON CLICK DelAllNew(oLbx2)


            @ 002, 002 LISTBOX oLbx2 FIELDS HEADER "Visão nova" SIZE 080,200 PIXEL OF oP2 
            oLbx2:Align :=CONTROL_ALIGN_ALLCLIENT
            oLbx2:SetArray( aNewStru )
            oLbx2:bLine := {|| Retbline(oLbx2, aNewStru ) }
            oLbx2:SetFocus()

    oModal:Activate()

    

Return 



Static Function MenuCmp(oLbx1, oLbx2, oOwner, cAliasDic)
    Local nX := 0
    Local oMenu
    Local cAux    := ''
    Local bBlock  :={||}
    
    LeHst(__aHstCmp, "campo" + Alltrim(cAliasDic))
    AtuOrg()

    oMenu := tMenu():new(0, 0, 0, 0, .T., , oOwner)

    
    //oMenu:Add(tMenuItem():new(oMenu, "Excluir"         , , , , {|| If(FWAlertYesNo("Confirma a exclusão?")            , (GrvHst(__aHstCmp, "campo" + Alltrim(cAliasDic), cCMD, .F., .T.), .t. ), .t.) }, , , , , , , , , .T.))
    oMenu:Add(tMenuItem():new(oMenu, "Limpar Histórico", , , , {|| If(FWAlertYesNo("Confirma a limpeza do histórico?"), (GrvHst(__aHstCmp, "campo" + Alltrim(cAliasDic), ""  , .T., .F.), .t. ), .t.) }, , , , , , , , , .T.))

    For nX := Len(__aHstCmp) To 1 Step -1
        cAux := cValToChar(nX)+ ". " + Left( Alltrim (__aHstCmp[nX]), 120)
        bBlock:=&('{|| cLista:= __aHstCmp[' + str(nX) + '] , AtuOrg(cLista, oLbx1, oLbx2)}')
        oMenu:Add(tMenuItem():new(, cAux, , , , bBlock, , , , , , , , , .T.))
    Next

    oMenu:Activate(NIL, 21, oOwner)

Return

Static Function AtuOrg(cLista, oLbx1, oLbx2)
    Local nx := 0
    Local aLista  := {}
    Local cCampo  := ""
    Local aNew    := {}
    Local aCampos := {}
    
    If cLista == NIL 
        Return 
    EndIf 

    cLista := Alltrim(cLista)
    If Right(cLista, 1) == ","
        cLista := Left(cLista, Len(cLista) - 1)
    EndIf 
    
    aLista := Separa(cLista,",")
    aCampos := oLbx1:aArray

    For nx:= 1 to len(aLista)
        cCampo := aLista[nx] 
        If Empty(cCampo)
            Loop 
        EndIf 
        np := Ascan(aCampos, {|x| x[1] == cCampo })
        If Empty(np)
            Loop 
        EndIf 
        aadd(aNew, {cCampo})   
    Next 
    
    For nx:= 1 to len(aCampos)
        cCampo := aCampos[nx, 1]
        If Empty(cCampo)
            Loop 
        EndIf 
        np := Ascan(aNew, {|x| x[1] == cCampo })
        If ! Empty(np)
            Loop 
        EndIf 
        aadd(aNew, {cCampo})
    Next 

    If Empty(aNew)
        aNew := {{""}}
    EndIf 


    oLbx2:SetArray(aNew)
    oLbx2:bLine := {|| Retbline(oLbx2, aNew ) }
    oLbx2:Refresh()
    oLbx1:SetFocus()



Return 

Static Function NewOk(oLbx2, cAliasDic, oP2ant, np, oIndice, oMsg, oMsg2)
    Local aNew   := oLbx2:aArray 
    Local nx     := 0
    Local cHist  := ""
    Local cHisOri:= ""
    Local aBrwAnt:= {}
    Local cCampo := ""

    aBrwAnt := aClone(__aNewBrw[np])
    __aNewBrw[np] := {}
    For nx:= 1 to len(aNew)
        cCampo := aNew[nx, 1]

        aadd(__aNewBrw[np] , cCampo)
        If nx < 20
            cHist   += cCampo + ","
            If nx <= len(aBrwAnt)
                cHisOri += aBrwAnt[nx]+","
            EndIf 
        EndIf 
    Next 
    If cHist <> cHisOri
        GrvHst(__aHstCmp, "campo" + Alltrim(cAliasDic), cHist)
        DicBrowse(cAliasDic, oP2ant, np, oIndice, oMsg, oMsg2,, .t.)
        __aDicBrw[np]:Refresh()
        __aDicBrw[np]:SetFocus()
    EndIf 

    
Return 

Static Function InsNew(oLbx1, oLbx2)
    Local nAt    := oLbx1:nAt
    Local cCampo := oLbx1:aArray[nAt, 1]
    Local aNew   := oLbx2:aArray

    np := Ascan(aNew, {|x| x[1] == cCampo })
    If ! Empty(np)
        Return  
    EndIf

    If len(aNew) == 1 .and. Empty(aNew[1, 1])
        aNew[1,1] := cCampo
    Else 
        aadd(aNew, {cCampo})   
    EndIf 
    
    oLbx2:SetArray(aNew)
    oLbx2:bLine := {|| Retbline(oLbx2, aNew ) }
    oLbx2:Refresh()
    oLbx1:SetFocus()

Return  

Static Function InsLista(cLista, oLbx1, oLbx2) 
    Local aLista := {}
    Local cCampo := {}
    Local nx     := 0
    Local np     := 0
    Local aNew   := oLbx2:aArray

    If Empty(cLista)
        Return  
    EndIf 

   
    aLista := Separa(Alltrim(cLista), ",")

    For nx:= 1 to len(aLista)
        cCampo := aLista[nx]

        np := Ascan(oLbx1:aArray, {|x| Alltrim(x[1]) == Alltrim(cCampo) })
        If Empty(np)
           Loop
        EndIf
        
        cCampo := oLbx1:aArray[np, 1]

        np := Ascan(aNew, {|x| x[1] == cCampo })
        If np > 0
            Loop 
        EndIf 
        
        If len(aNew) == 1 .and. Empty(aNew[1, 1])
            aNew[1, 1] := cCampo
        Else 
            aadd(aNew, {cCampo})   
        EndIf 

    Next 

    oLbx2:SetArray(aNew)
    oLbx2:bLine := {|| Retbline(oLbx2, aNew ) }
    oLbx2:Refresh()
    oLbx1:SetFocus()


Return 

Static Function InsAllNew(oLbx1, oLbx2)
    Local aCampos := oLbx1:aArray
    Local aNew    := oLbx2:aArray
    Local cCampo  := ""
    Local nx     := 0

    For nx:= 1 to len(aCampos)
        cCampo := aCampos[nx, 1]
        np := Ascan(aNew, {|x| x[1] == cCampo })
        If np > 0
            Loop 
        EndIf 
        If len(aNew) == 1 .and. Empty(aNew[1, 1])
            aNew[1, 1] := cCampo
        Else 
            aadd(aNew, {cCampo})   
        EndIf 
    Next 

    oLbx2:SetArray(aNew)
    oLbx2:bLine := {|| Retbline(oLbx2, aNew ) }
    oLbx2:Refresh()
    oLbx1:SetFocus()

Return  

Static Function UpNew(oLbx2)
    Local nAt     := oLbx2:nAt
    Local aNew    := oLbx2:aArray
    Local cCampo1 := ""
    Local cCampo2 := ""
    
    If nAt == 1
        Return 
    EndIf 

    cCampo1 := aNew[nAt - 1, 1]
    cCampo2 := aNew[nAt, 1]

    aNew[nAt - 1, 1] := cCampo2
    aNew[nAt, 1]     := cCampo1

    oLbx2:nAt--
    oLbx2:SetArray(aNew)
    oLbx2:bLine := {|| Retbline(oLbx2, aNew ) }
    oLbx2:Refresh()
    oLbx2:SetFocus()

Return 

Static Function Down(oLbx2)
    Local nAt     := oLbx2:nAt
    Local aNew    := oLbx2:aArray
    Local cCampo1 := ""
    Local cCampo2 := ""
    
    If nAt == len(aNew)
        Return 
    EndIf 

    cCampo1 := aNew[nAt    , 1]
    cCampo2 := aNew[nAt + 1, 1]

    aNew[nAt    , 1] := cCampo2
    aNew[nAt + 1, 1] := cCampo1

    oLbx2:nAt++
    oLbx2:SetArray(aNew)
    oLbx2:bLine := {|| Retbline(oLbx2, aNew ) }
    oLbx2:Refresh()
    oLbx2:SetFocus()

Return 

Static Function DelNew(oLbx2)
    Local nAt    := oLbx2:nAt
    Local aNew   := oLbx2:aArray

    If len(aNew) == 1 .and. Empty(aNew[1, 1])
        Return 
    EndIf 

    If len(aNew) == 1
        aNew := {{""}}
    Else 
        aDel(aNew, nAt)
        aSize(aNew, len(aNew) - 1)
    EndIf 
    
    oLbx2:SetArray(aNew)
    oLbx2:bLine := {|| Retbline(oLbx2, aNew ) }
    oLbx2:Refresh()

Return  

Static Function DelAllNew(oLbx2)
    Local aNew   := oLbx2:aArray
 

    aNew := {{""}}
    oLbx2:SetArray(aNew)
    oLbx2:bLine := {|| Retbline(oLbx2, aNew ) }
    oLbx2:Refresh()

Return


Static Function CompSX(cAliasDic, np)
    Local nX := 0
    Local uValue
    Local cValue
    Local aArea     := GetArea()
    Local aAreaSx3  := SX3->(GetArea("SX3"))
    Local aAreaSx2  := Sx2->(GetArea("SX2"))
    Local cResult   := ""
    Local aEstru
    Local cAux      :=""
    Local nRecSx3   := SX3->(Recno())
    Local cAliasTst := __aDicTst[np]

    cAliasDic := Alltrim(cAliasDic)

    If Empty(cAliasDic)
        Return
    EndIf 

    If AllTrim(cAliasDic) + "," $ "SIX,SX1,SX2,SX3,SX6,SX7,SXA,SXB,SXE,SXF,SXG,"
        Return 
    EndIf 

    If Upper(Right(cAliasDic, 4)) == ".DTC"
        Return  
    EndIf

    cAliasDic := Left(cAliasDic, 3)
    SX2->(DbSetOrder(1))
    If ! SX2->(DbSeek(cAliasDic))
        RestArea(aAreaSx2)
        RestArea(aArea)
        Return 
    EndIf 
    
    SX3->(dbSetOrder(1))
    If ! SX3->(DbSeek(cAliasDic))
        RestArea(aAreaSx3)
        SX3->(DbGoto(nRecSx3))
        Return
    EndIf

    SX3->(dbSetOrder(2))
    aEstru := (cAliasTst)->(dbStruct())

    cResult += " *** Comparação de estrutura do banco com SX3 ***" + CRLF

    For nx:=1 to len(aEstru)
        cResult += "Campo: " + aEstru[nx,1]
        cAux := ""
        If ! SX3->(DbSeek(aEstru[nx, 1]))
            cResult +=  CRLF + "    Não cadastrado SX3 com Tipo [" + aEstru[nx, 2] + "] Tamanho ["+ Str(aEstru[nx, 3]) +"] Decimal ["+ Str(aEstru[nx, 4]) +"] " + CRLF
            Loop
        EndIf
        If ! SX3->(FieldGet(FieldPos("X3_TIPO"))) == aEstru[nx, 2]
            cAux += CRLF + "    Tipo diferente: DB [" + aEstru[nx, 2] + "] SX3 [" +SX3->(FieldGet(FieldPos("X3_TIPO"))) + "]"
        Endif
        If ! SX3->(FIELDGET(FIELDPOS("X3_TAMANHO"))) == aEstru[nx, 3]
            cAux += CRLF + "    Tamanho diferente: DB [" + Str(aEstru[nx, 3]) + "] SX3 [" + Str(SX3->(FIELDGET(FIELDPOS("X3_TAMANHO"))), 3) + "]"
        Endif
        If ! SX3->(FIELDGET(FIELDPOS("X3_DECIMAL"))) == aEstru[nx, 4]
            cAux += CRLF + "    Decimal diferente:  DB [" + Str(aEstru[nx, 4]) + "] SX3 [" + Str(SX3->(FIELDGET(FIELDPOS("X3_DECIMAL"))), 3) + "]"
        Endif
        If Empty(cAux)
            cResult += " OK" + CRLF
        Else
            cResult += cAux + CRLF
        EndIf
    Next

    cResult += "*** Verificando campos não criados no DB ***" + CRLF
    cAux := ""
    SX3->(dbSetOrder(1))
    SX3->(DbSeek(cAliasDic))
    While   SX3->(! Eof() .and. X3_ARQUIVO == cAliasDic)
        
        If SX3->(FieldGet(FieldPos("X3_CONTEXT"))) == 'V'
            SX3->(dbSkip())
            Loop
        EndIf

        If Ascan(aEstru, {|x| Alltrim(x[1]) == SX3->(Alltrim(FieldGet(FieldPos("X3_CAMPO")))) }) > 0
            SX3->(dbSkip())
            Loop
        EndIf

        cAux += "Campo " + SX3->(Alltrim(FieldGet(FieldPos("X3_CAMPO")))) + ":"+ CRLF
        For nX:= 1 to SX3->(fcount())
            SX3->(uValue:= &(field(nx)))
            If ValType(uValue) != 'C'
                cValue:= str(uValue)
            Else
                cValue := uValue
            EndIf
            cAux += SX3->(field(nx)) + " = " + cValue + CRLF
        Next

        SX3->(DbSkip())
    EndDo

    If Empty(cAux)
        cResult += "  OK - Todos os campos do SX3 estão criados no DB." + CRLF
    Else
        cResult += "Relação de inexistencia:" + CRLF
        cResult += cAux + CRLF
    EndIf
    cResult += CRLF + CRLF + CRLF

    AutoGrLog("")
    FErase(NomeAutoLog())
    AutoGrLog(cResult)
    MostraLog()

    RestArea(aAreaSx2)
    RestArea(aAreaSx3)
    RestArea(aArea)
    SX3->(DbGoto(nRecSx3))

Return

Static Function SincSX3(cAliasDic,  np)
    Local cMsg:=""
    Local cAliasTst := __aDicTst[np]
    Local aArea     := GetArea()
    Local aAreaSx2  := Sx2->(GetArea("SX2"))
    Local cTabela   := ""


    cAliasDic := Alltrim(cAliasDic)

    If Empty(cAliasDic)
        Return
    EndIf 

    If AllTrim(cAliasDic) + "," $ "SIX,SX1,SX2,SX3,SX6,SX7,SXA,SXB,SXE,SXF,SXG,"
        Return 
    EndIf 

    If Upper(Right(cAliasDic, 4)) == ".DTC"
        Return  
    EndIf

    If len(Alltrim(cAliasDic)) == 3
        cAliasDic := Left(cAliasDic, 3)
        SX2->(DbSetOrder(1))    
        If ! SX2->(DbSeek(cAliasDic))
            FWAlertWarning("Tabela não encontrada no SX2")
            RestArea(aAreaSx2)  
            RestArea(aArea)
            Return 
        EndIf 
    Else
        SX2->(DbSetOrder(2))    
        If ! SX2->(DbSeek(Alltrim(cAliasDic)))
            FWAlertWarning("Tabela não encontrada no SX2")
            RestArea(aAreaSx2)  
            RestArea(aArea)
            Return 
        EndIf 
        cAliasDic := SX2->(FieldGet(FieldPos("X2_CHAVE")))
    EndIf 
    RestArea(aAreaSx2)  
    RestArea(aArea)
    If ! FWAlertYesNo("Confirma o sincronismo entre o SX3 e o banco?")
        return
    EndIf
    
    cTabela:= RetFileName((cAliasTst)->(DBInfo(10)))
    If Select(cAliasTst) > 0
        (cAliasTst)->(DbCloseArea())
    EndIf

    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Hide()
        __aDicBrw[np]:FreeChildren()
        FreeObj(__aDicBrw[np])
        __aDicBrw[np]:= NIL 
    EndIf


    cMsg := StartJob("u_TIDEVX31",GetEnvServer(),.T., SM0->M0_CODIGO, Alltrim(SM0->M0_CODFIL), cAliasDic)

    AutoGrLog("")
    FErase(NomeAutoLog())
    AutoGrLog(cMsg)
    IncLog("TABELA", cTabela, cMsg)
    MostraLog()

Return



User Function TIDEVX31(cEmp, cFil, cAlias)
    Local cMsg:= ""

    RpcSetType(3)
    RpcSetEnv(cEmp, cFil,,,,,)

   TIDesMon( "Atualizando tabela:" + cAlias +  " Empresa:" + cEmp)

    __SetX31Mode(.F.)

    X31UpdTable(cAlias)

    If __GetX31Error()
        cMsg :=__GetX31Trace()
    Else
        cMsg:= "Atualização do alias ["+cAlias+"] realizada com sucesso! "
    EndIf

Return cMsg


Static Function DropInd(cAliasDic, np)
    Local cMsg:=""
    Local cAliasTst := __aDicTst[np]
    Local aArea     := GetArea()
    Local aAreaSx2  := Sx2->(GetArea("SX2"))
    Local cFile     := ""
    Local cFileIdx  := ""
    Local nOrd      := 0
    Local ni        := 0
    Local aDelKeys  := {}

    cAliasDic := Alltrim(cAliasDic)

    If Empty(cAliasDic)
        Return
    EndIf 

    If AllTrim(cAliasDic) + "," $ "SIX,SX1,SX2,SX3,SX6,SX7,SXA,SXB,SXE,SXF,SXG,"
        Return 
    EndIf 

    If Upper(Right(cAliasDic, 4)) == ".DTC"
        Return  
    EndIf


    If len(Alltrim(cAliasDic)) == 3
        cAliasDic := Left(cAliasDic, 3)
        SX2->(DbSetOrder(1))    
        If ! SX2->(DbSeek(cAliasDic))
            FWAlertWarning("Tabela não encontrada no SX2")
            RestArea(aAreaSx2)  
            RestArea(aArea)
            Return 
        EndIf 
    Else
        SX2->(DbSetOrder(2))    
        If ! SX2->(DbSeek(Alltrim(cAliasDic)))
            FWAlertWarning("Tabela não encontrada no SX2")
            RestArea(aAreaSx2)  
            RestArea(aArea)
            Return 
        EndIf 
        cAliasDic := SX2->(FieldGet(FieldPos("X2_CHAVE")))
    EndIf 
    RestArea(aAreaSx2)  
    RestArea(aArea)
    If ! FWAlertYesNo("Confirma a exclusão de todos os indices da tabela  " + cAliasDic + "?")
        return
    EndIf

    If Select(cAliasTst) > 0
        (cAliasTst)->(DbCloseArea())
    EndIf

    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Hide()
        __aDicBrw[np]:FreeChildren()
        FreeObj(__aDicBrw[np])
        __aDicBrw[np]:= NIL 
    EndIf

    cFile := Alltrim(SX2->(FieldGet(FieldPos("X2_ARQUIVO"))))

    If ! MsFile(cFile,,"TOPCONN")
        Return "Arquivo não existe!"
    EndIf    
    
    While nOrd <= 36 
        cFileIdx := cFile + RetAsc(Str(nOrd+=1), 1, .T.)
        If TcCanOpen(cFile, cFileIdx)
            Aadd(aDelKeys, cFile+'|'+cFileIdx)
        EndIf
    End

    For ni := 1 To Len(aDelKeys) 
        cMsg += "Apagado o indice: " + aDelKeys[ni] +CRLF
        TcInternal(60, aDelKeys[ni])
    Next
    TcRefresh(cFile)
    
    AutoGrLog("")
    FErase(NomeAutoLog())
    AutoGrLog(cMsg)
    IncLog("TABELA", cFile, cMsg)
    MostraLog()

    
    
Return 

Static Function ExecRotQry(np, cMemoL)
    Local cAliasTst := __aAliasTst[np]
 
    Local cFor     := Nil
    Local cWhile   := Nil
    Local nProxReg := NIL
    Local lRest    := .f.

    Local aExec    := {}
    Local cInicio  := ""
    Local cComando := ""
    Local cTermino := ""
    Local cLog     := ""
    
    If Select(cAliasTst) == 0
        FWAlertWarning("Execute uma query!!")
        Return .F.
    EndIf

    aExec := PegaCMD(cAliasTst)
    If Empty(aExec)
        Return  
    EndIf
    
    cInicio  := aExec[1]
    cComando := aExec[2]
    cTermino := aExec[3]

    If Empty(cComando)
        Return 
    EndIf 

    If ! FWAlertYesNo("Confirma a execução bloco:" + cComando + " em cada registro?")
        Return
    EndIf

    cFor     := Nil
    cWhile   := Nil
    nProxReg := NIL
    lRest    := .f.
        
    (cAliasTst)->(TelaDbEval(cComando, cFor, cWhile, nProxReg, lRest, "Processando registos..", .F., cInicio, cTermino))

    cLog += "Execução macro em Query" + CRLF
    clog += "Query:"+ CRLF
    clog += cMemoL + CRLF + CRLF 

    cLog += "Bloco macro INICIO" + CRLF
    clog += cInicio + CRLF +  CRLF
    cLog += "Bloco macro COMANDO POR LINHA" + CRLF
    clog += cComando + CRLF + CRLF
    cLog += "Bloco macro TERMINO" + CRLF
    clog += cTermino + CRLF + CRLF
    IncLog("QUERY", , cLog)

Return 



Static Function ExecRot(cAliasDic, np)
    Local cAliasTst := __aDicTst[np]
    Local cFor     := Nil
    Local cWhile   := Nil
    Local nProxReg := NIL
    Local lRest    := .f.
    Local aExec    := {}
    Local cInicio  := ""
    Local cComando := ""
    Local cTermino := ""
    Local cTabela  := ""
    Local cLog     := ""
    
    If Empty(cAliasDic)
        FWAlertWarning("Alias não informado!!!")
        Return 
    EndIf 

    aExec := PegaCMD(cAliasTst)
    If Empty(aExec)
        Return  
    EndIf
    
    cInicio  := aExec[1]
    cComando := aExec[2]
    cTermino := aExec[3]

    If Empty(cComando)
        Return 
    EndIf 

    cTabela:= RetFileName((cAliasTst)->(DBInfo(10)))
    If Upper(cTabela) == "TIDEVLOG"
        FWAlertWarning("Não é permitido manipular a tabela TIDEVLOG")
        Return 
    EndIf 

    If ! FWAlertYesNo("Confirma a execução bloco: " + cComando + " em cada registro?")
        Return
    EndIf


    cFor     := Nil
    cWhile   := Nil
    nProxReg := NIL
    lRest    := .f.
    
    (cAliasTst)->(TelaDbEval(cComando, cFor, cWhile, nProxReg, lRest, "Processando registos..", .F., cInicio, cTermino))

    cLog += "Execução macro em bloco" + CRLF
    cLog += "Tabela: " + cTabela + CRLF
    clog += "Filtro: " + (cAliasTst)->(dbFilter()) + CRLF + CRLF
    cLog += "Bloco macro INICIO" + CRLF
    clog += cInicio + CRLF +  CRLF
    cLog += "Bloco macro COMANDO POR LINHA" + CRLF
    clog += cComando + CRLF + CRLF
    cLog += "Bloco macro TERMINO" + CRLF
    clog += cTermino + CRLF + CRLF
    IncLog("TABELA", cTabela, cLog)

    If ValType(__aDicBrw[np])=='O'
        __aDicBrw[np]:Refresh()
        __aDicBrw[np]:SetFocus()
        eval(__aDicBrw[np]:bChange)
    EndIf

Return 

Static Function PegaCMD(cAlias)
    Local oFontB    := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)
    Local oP1 
    Local oP2
    Local oP3 
    Local oP1S
    Local oP2S
    Local oP3S

    Local lOk       := .F.
    Local oExp1
    Local cExp1     := ""
    Local oExp2
    Local cExp2     := ""    
    Local oExp3
    Local cExp3     := ""
    Local oBut1
    Local oBut2
    Local oBut3

    Local oModal  
    Local oDlg 
    
    oModal  := FWDialogModal():New()       
	oModal:SetEscClose(.T.)
    oModal:setTitle("Execução Macro - alias: " + cAlias)
	oModal:setSize(220, 290)
    oModal:createDialog()
    oModal:addCloseButton({||  lOk:= .T., oModal:DeActivate()}, "OK")
    oModal:AddButton("Cancelar", {|| lOk:= .F., oModal:DeActivate() }     , "Cancelar",,.T.,.F.,.T.,)

    oDlg:= oModal:getPanelMain()

        oP1:= TPanelCss():New(,,, oDlg)
        oP1:SetCoors(TRect():New(0, 0, 100, 500))
        oP1:Align :=CONTROL_ALIGN_TOP
            oP1S:= TPanelCss():New(,,, oP1)
            oP1S:SetCoors(TRect():New(0, 0, 30, 500))
            oP1S:Align :=CONTROL_ALIGN_TOP
                @ 005, 005 SAY "Codigo MACRO Inicio"      of oP1S SIZE 100, 10 PIXEL FONT oFontB
                oBut1 := THButton():New(002, 140,"Histórico"        ,oP1S  , {|| MenuMacro(@cExp1, oBut1, 1)                          }, 45, 10, oFontB, "Lista com o historico") 
            oExp1 := tMultiget():new(,, bSETGET(cExp1), oP1)
            oExp1:Align := CONTROL_ALIGN_ALLCLIENT

        oP2:= TPanelCss():New(,,, oDlg)
        oP2:SetCoors(TRect():New(0, 0, 100, 500))
        oP2:Align :=CONTROL_ALIGN_ALLCLIENT
            oP2S:= TPanelCss():New(,,, oP2)
            oP2S:SetCoors(TRect():New(0, 0, 30, 500))
            oP2S:Align :=CONTROL_ALIGN_TOP
                @ 005, 005 SAY "Codigo MACRO por linha"      of oP2S SIZE 100, 10 PIXEL FONT oFontB
                oBut2 := THButton():New(002, 140,"Histórico"        ,oP2S  , {|| MenuMacro(@cExp2, oBut2, 2)                          }, 45, 10, oFontB, "Lista com o historico") 
            oExp2 := tMultiget():new(,, bSETGET(cExp2), oP2)
            oExp2:Align := CONTROL_ALIGN_ALLCLIENT


        oP3:= TPanelCss():New(,,, oDlg)
        oP3:SetCoors(TRect():New(0, 0, 100, 500))
        oP3:Align :=CONTROL_ALIGN_BOTTOM
            oP3S:= TPanelCss():New(,,, oP3)
            oP3S:SetCoors(TRect():New(0, 0, 30, 500))
            oP3S:Align :=CONTROL_ALIGN_TOP
                @ 005, 004 SAY "Codigo MACRO Termino"      of oP3S SIZE 100, 10 PIXEL FONT oFontB
                oBut3 := THButton():New(002, 140,"Histórico"        ,oP3S  , {|| MenuMacro(@cExp3, oBut3, 3)                          }, 45, 10, oFontB, "Lista com o historico") 
            oExp3 := tMultiget():new(,, bSETGET(cExp3), oP3)
            oExp3:Align := CONTROL_ALIGN_ALLCLIENT
  

    oModal:Activate()

    If ! lOk
        Return {}
    EndIf 

    GrvHst(__aHstMacro[1], "macro1", cExp1)
    GrvHst(__aHstMacro[2], "macro2", cExp2)
    GrvHst(__aHstMacro[3], "macro3", cExp3)

    cExp1 := TrataCMD(cExp1)
    cExp2 := TrataCMD(cExp2)
    cExp3 := TrataCMD(cExp3)
   
Return {cExp1, cExp2, cExp3} 

Static Function TrataCMD(cMemo)
    Local cLinha := ""
    Local cRet   := ""
    Local nx 
    Local np 

    For nx:= 1 to MlCount(cMemo)
        cLinha := MemoLine(cMemo, 254, nx)

        // tira o comentario
        nP := at("//", cLinha)
        If ! Empty(nP)
            cLinha := Left(cLinha, nP - 1)
        EndIf
        
        cLinha := Alltrim(cLinha)
        If empty(cLinha)
            Loop
        EndIf
        cRet += cLinha 

        If Right(cRet, 1) == ";"
            cRet := Left(cRet, len(cRet) - 1)
            Loop
        EndIf
        If nx < MlCount(cMemo)
            cRet += ","
        EndIf 
    Next

Return cRet







/*
#################################################################################################################################
Aba de Inspeção de fontes
#################################################################################################################################
*/

Static __aFunc := {}   
Static __aClass:= {}

Static Function FolderRPO(oDlg)
    Local oBut
    LOcal oP1
    Local oPL
    Local oPR

    Local oTipo
    Local aTipo := {"Fonte", "Função/Classe"}
    Local cTipo := "Fonte"   
    Local cChave := Space(100)

    Local oLbx   
    Local aLista := {{"","","","","","",""}}
    Local oMemo2
    Local cMemo2 :=""
    Local oFont  := TFont():New("Consolas",, 20,, .F.,,,,, .F. )
    Local oFontB := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)
    Local oRPO 
    Local oSX3
    Local oSX6
    Local oSX7
    Local oSXB
    Local oMNU

    
    
    oP1 := TPanelCss():New(,,,oDlg)
    oP1 :SetCoors(TRect():New( 0,0, 40, __nWidth))
    oP1 :Align := CONTROL_ALIGN_TOP

    @ 005, 004 MSCOMBOBOX oTipo    VAR cTipo    ITEMS aTipo   SIZE 60,09 PIXEL OF oP1 VALID SelTipo(cTipo, oRPO, oSX3, oSX6, oSX7, oSXB, oMNU ) 
    @ 005, 070 Get cChave of oP1 SIZE 200, 08 PIXEL PICT "@!"
    oBut  := THButton():New(005, 274,"Pesquisar" ,oP1, {|| PesqRpo(cTipo, cChave, aLista, oLbx, @cMemo2) }, 45, 10, oFontB, "Busca o conteudo no RPO conforme o tipo!") 

    @ 005, 400 CHECKBOX oRPO VAR __lRPO  PROMPT "RPO"	 SIZE 025,010 OF oP1 PIXEL font oFontB  
    @ 005, 430 CHECKBOX oSX3 VAR __lSx3  PROMPT "SX3"	 SIZE 025,010 OF oP1 PIXEL font oFontB 
    @ 005, 460 CHECKBOX oSX6 VAR __lSx6  PROMPT "SX6"	 SIZE 025,010 OF oP1 PIXEL font oFontB 
    @ 005, 490 CHECKBOX oSX7 VAR __lSx7  PROMPT "SX7"	 SIZE 025,010 OF oP1 PIXEL font oFontB 
    @ 005, 520 CHECKBOX oSXB VAR __lSxb  PROMPT "SXB"	 SIZE 025,010 OF oP1 PIXEL font oFontB 
    @ 005, 550 CHECKBOX oMNU VAR __lMnu  PROMPT "MNU"	 SIZE 025,010 OF oP1 PIXEL font oFontB 

    oRPO:Hide()
    oSX3:Hide()
    oSX6:Hide()
    oSX7:Hide()
    oSXB:Hide()     
    oMNU:Hide()     

    oPL:= TPanelCss():New(,,,oDlg)
    oPL:SetCoors(TRect():New( 0,0, __nHeight * 0.4 , __nWidth * 0.5))
    oPL:Align :=CONTROL_ALIGN_ALLCLIENT

        oLbx := MsBrGetDBase():New(1, 1, __DlgWidth(oPL)-1, __DlgHeight(oPL) - 1,,,, oPL ,,,,,,,,,,,, .F., "", .T.,, .F.,,,)

        oLbx:align := CONTROL_ALIGN_ALLCLIENT
        oLbx:SetArray( aLista )

        oLbx:addColumn( TCColumn():new( "Fonte"         , { || oLbx:aArray[oLbx:nAt, 1] },,,, "LEFT" , 100, .F., .F.,,,, .F. ) )
        oLbx:addColumn( TCColumn():new( "Data"          , { || oLbx:aArray[oLbx:nAt, 2] },,,, "LEFT" , 040, .F., .F.,,,, .F. ) )
        oLbx:addColumn( TCColumn():new( "Hora"          , { || oLbx:aArray[oLbx:nAt, 3] },,,, "LEFT" , 040, .F., .F.,,,, .F. ) )
        oLbx:addColumn( TCColumn():new( "Função/Classe" , { || oLbx:aArray[oLbx:nAt, 4] },,,, "LEFT" , 100, .F., .F.,,,, .F. ) )
        oLbx:addColumn( TCColumn():new( "Linha"         , { || oLbx:aArray[oLbx:nAt, 5] },,,, "RIGHT", 040, .F., .F.,,,, .F. ) )
        oLbx:addColumn( TCColumn():new( "Tipo"          , { || oLbx:aArray[oLbx:nAt, 6] },,,, "LEFT" , 040, .F., .F.,,,, .F. ) )
        
        
        oLbx:bLDblClick := {|| BuscaPar(aLista, oLbx:nAt, @cMemo2, oMemo2) }
        oLbx:Refresh()

    oPR:= TPanelCss():New(,,,oDlg)
    oPR:SetCoors(TRect():New( 0,0, __nHeight * 0.4, __nWidth * 0.5))
    oPR:Align :=CONTROL_ALIGN_RIGHT

        oMemo2 := tMultiget():new(,, bSETGET(cMemo2), oPR)
        oMemo2:Align := CONTROL_ALIGN_ALLCLIENT
        oMemo2:oFont:=oFont

    __bTelRpo:= {|| AtuFolRpo(oPR) }

Return

Static Function SelTipo(cTipo, oRPO, oSX3, oSX6, oSX7, oSXB, oMNU) 
    
    If cTipo == "Fonte"
        oRPO:Hide()
        oSX3:Hide()
        oSX6:Hide()
        oSX7:Hide()
        oSXB:Hide()
        oMNU:Hide()
    Else 
        oRPO:Show()
        oSX3:Show()
        oSX6:Show()
        oSX7:Show()
        oSXB:Show()
        oMNU:Show()
    EndIf 
    
Return .t.

Static Function AtuFolRPO(oPR)
    oMainWnd:ReadClientCoors()

    __nHeight := oMainWnd:nHeight - 100
    __nWidth  := oMainWnd:nWidth - 20
    oPR:SetCoors(TRect():New( 0,0, __nHeight * 0.4, __nWidth * 0.5))
    
Return 

Static Function RetbLine(oLbx, aLista)
    Local nx
    Local aRet	:= {}

    If oLbx:nAt == 0 
        Return aclone(aRet)
    EndIf 
    If Empty(aLista)
        Return aclone(aRet)
    EndIf 

    For nX := 1 to len(aLista[oLbx:nAt])
        aadd(aRet,aLista[oLbx:nAt,nX])
    Next
Return aclone(aRet)

Static Function PesqRpo(cTipo, cChave, aLista, oLbx, cMemo2)
    Private lAbortPrint := .F.
  
    If Empty(cChave)
        Return 
    EndIf 

    If oLbx == NIL
        Return
    EndIf

    aLista := {}
    cChave  := Alltrim(cChave)

    If cTipo == "Fonte"
        Processa({|| PesqPrg(cChave, aLista)}, "Varrendo RPO ....","Aguarde", .t.)
    Else
        If __lRPO .and. ! lAbortPrint
            Processa({|| PesqFunc(cChave, aLista)}, "Varrendo RPO ....","Aguarde", .t.)
        EndIf 
        If __lSx3 .and. ! lAbortPrint
            Processa({|| PesqFSX3(cChave, aLista)}, "Varrendo SX3 ....","Aguarde", .t.)
        EndIf
        If __lSx6 .and. ! lAbortPrint
            Processa({|| PesqFSX6(cChave, aLista)}, "Varrendo SX6 ....","Aguarde", .t.)
        EndIf
        If __lSx7 .and. ! lAbortPrint
            Processa({|| PesqFSX7(cChave, aLista)}, "Varrendo SX7 ....","Aguarde", .t.)
        EndIf
        If __lSxb .and. ! lAbortPrint
            Processa({|| PesqFSXB(cChave, aLista)}, "Varrendo SXB ....","Aguarde", .t.)
        EndIf        
        If __lMnu .and. ! lAbortPrint
            Processa({|| PesqFMNU(cChave, aLista)}, "Varrendo MNU ....","Aguarde", .t.)
        EndIf
    EndIf 

    If Empty(aLista)
        FWAlertWarning("Não encontrado!")
        aLista := {{"","","","","","",""}}
    EndIf 

    oLbx:SetArray(aLista)
    oLbx:Refresh()

Return 

Static Function PesqFunc(cChave, aLista)
    Local aType  := {}
    Local aFile  := {}
    Local aLine  := {}
    Local aDate  := {}
    Local aTime  := {}
    Local aFuns  := {}
    Local nx     := 0
    Local lComMask := .F.
    Local aChave := {}
    Local ny     := 0

    If Empty(__aFunc)
        __aFunc:= __FunArr()
    EndIf

    If Empty(__aClass)
        __aClass:= __ClsArr()
    EndIf

    If ! "," $ cChave 
        aChave := {cChave}
    Else 
        aChave := Separa(cChave, ",", .T.)
    EndIf 

    For ny := 1 to len(aChave)
        cChave := aChave[ny]

        aType  := {}
        aFile  := {}
        aLine  := {}
        aDate  := {}
        aTime  := {}
        aFuns  := {}

        aFuns := GetFuncArray(cChave, aType, aFile, aLine, aDate, aTime)
    
        ProcRegua(Len(aFuns))

    
        For nx := 1 To Len(aFuns)
            IncProc()
            ProcessMessage()
            If lAbortPrint
                FWAlertWarning("Busca interrompida!!!")
                Return 
            EndIf

            AAdd(aLista, { aFile[nx], aDate[nx], aTime[nx], aFuns[nx], aLine[nx], aType[nx], "" } )
        Next
        
        lComMask := '*'$ cChave

        cChave := StrTran(cChave, "*","")
        cChave := Upper(AllTrim(cChave))

        If lComMask
            AEval(__aFunc ,{|x,y|If(Empty(cChave) .Or. cChave $ Upper(x[1]), AAdd(aLista, {"", "", "", x[1], "", "ADVPL" , ""}),Nil)})
            AEval(__aClass,{|x,y|If(Empty(cChave) .Or. cChave $ Upper(x[1]), AAdd(aLista, {"", "", "", x[1], "", "Classe", ""}),Nil)})
        Else
            If (np := AScan(__aFunc ,{|x| cChave == Upper(x[1])})) > 0
                AAdd(aLista, { "", "", "", __aFunc[nP, 1], "", "ADVPL" , ""} )
            EndIf
        
            If (np := AScan(__aClass,{|x| cChave == Upper(x[1])})) > 0
                AAdd(aLista, { "", "", "", __aClass[nP, 1], "", "Classe" , ""} )
            EndIf
        EndIf
    Next 
Return 

Static Function PesqPrg(cChave, aLista)
    Local aType  := {}
    Local aFile  := {}
    Local aLine  := {}
    Local aDate  := {}
    Local aTime  := {}
    Local aFuns  := {}
    Local aChave := {}
    Local nx     := 0
    Local ny     := 0
 
    cChave := Upper(Alltrim(StrTran(cChave, "*", "")))

    If "," $ cChave
        aChave := Separa(cChave, ",", .T.)
    Else 
        aChave := {cChave}
    EndIf 

    If Empty(__aFunc)
        __aFunc:= __FunArr()
    EndIf

    If Empty(__aClass)
        __aClass:= __ClsArr()
    EndIf

    
    aFuns := GetFuncArray("*", aType, aFile, aLine, aDate, aTime)
    
    ProcRegua(Len(aFuns))

    For nx := 1 To Len(aFuns)
        IncProc()
        ProcessMessage()
        For ny := 1 to len(aChave)
            cChave := aChave[ny]
        
            If lAbortPrint
                FWAlertWarning("Busca interrompida!!!")
                Return 
            EndIf
            If Left(cChave, len(cChave)) == Left(aFile[nx], len(cChave) )
                AAdd(aLista, { aFile[nx], aDate[nx], aTime[nx], aFuns[nx], aLine[nx], aType[nx], "" } )
            EndIf 
        Next
    Next

Return 

Static Function PesqFSX3(cChave, aLista)
    Local nRec    := SX3->(Recno())
    Local cFunCla := ""
    Local aChave  := {}
    Local ny      := 0

    cChave := Upper(Alltrim(cChave))

    If "," $ cChave
        aChave := Separa(cChave, ",", .T.)
    Else 
        aChave := {cChave}
    EndIf

    ProcRegua(SX3->(LastRec()))
    SX3->(DbGotop())
    While SX3->(! Eof() )
        IncProc()
        ProcessMessage()
        If lAbortPrint
            FWAlertWarning("Busca interrompida!!!")
            Exit
        EndIf
        
        For ny := 1 to len(aChave)
            cFunCla := aChave[ny]
            
            If Upper(cFunCla) + "(" $ Upper(SX3->(FieldGet(FieldPos("X3_VALID"))))
                AAdd(aLista, {SX3->(FieldGet(FieldPos("X3_CAMPO"))), "", "", cFunCla, "", "X3_VALID" } )
            EndIf 
            If Upper(cFunCla) + "(" $ Upper(SX3->(FieldGet(FieldPos("X3_RELACAO"))))
                AAdd(aLista, {SX3->(FieldGet(FieldPos("X3_CAMPO"))), "", "", cFunCla, "", "X3_RELACAO" } )
            EndIf
            If Upper(cFunCla) + "(" $ Upper(SX3->(FieldGet(FieldPos("X3_VLDUSER"))))
                AAdd(aLista, {SX3->(FieldGet(FieldPos("X3_CAMPO"))), "", "", cFunCla, "", "X3_VLDUSER" } )
            EndIf 
            If Upper(cFunCla) + "(" $ Upper(SX3->(FieldGet(FieldPos("X3_WHEN"))))
                AAdd(aLista, {SX3->(FieldGet(FieldPos("X3_CAMPO"))), "", "", cFunCla, "", "X3_WHEN" } )
            EndIf
            If Upper(cFunCla) + "(" $ Upper(SX3->(FieldGet(FieldPos("X3_INIBRW"))))
                AAdd(aLista, {SX3->(FieldGet(FieldPos("X3_CAMPO"))), "", "", cFunCla, "", "X3_INIBRW" } )
            EndIf                       
        Next 
        SX3->(DbSkip())
    End
    SX3->(DbGoto(nRec))

Return 

Static Function PesqFSX6(cChave, aLista)
    Local nRec    := SX6->(Recno())
    Local cFunCla := ""
    Local aChave  := {}
    Local ny      := 0

    cChave := Upper(Alltrim(cChave))

    If "," $ cChave
        aChave := Separa(cChave, ",", .T.)
    Else 
        aChave := {cChave}
    EndIf

    ProcRegua(SX6->(LastRec()))
    SX6->(DbGotop())
    While SX6->(! Eof() )
        IncProc()
        ProcessMessage()
        If lAbortPrint
            FWAlertWarning("Busca interrompida!!!")
            Exit
        EndIf
        
        For ny := 1 to len(aChave)
            cFunCla := aChave[ny]
            If Upper(cFunCla) + "(" $ Upper(SX6->(FieldGet(FieldPos("X6_CONTEUD"))))
                AAdd(aLista, {SX6->(FieldGet(FieldPos("X6_VAR"))), "", "", cFunCla, "", "X6_CONTEUD" } )
            EndIf 
        Next 
        SX6->(DbSkip())
    End
    SX6->(DbGoto(nRec))

Return 

Static Function PesqFSX7(cChave, aLista)
    Local nRec    := SX7->(Recno())
    Local cFunCla := ""
    Local aChave  := {}
    Local ny      := 0

    cChave := Upper(Alltrim(cChave))

    If "," $ cChave
        aChave := Separa(cChave, ",", .T.)
    Else 
        aChave := {cChave}
    EndIf

    ProcRegua(SX7->(LastRec()))
    SX7->(DbGotop())
    While SX7->(! Eof() )
        IncProc()
        ProcessMessage()
        If lAbortPrint
            FWAlertWarning("Busca interrompida!!!")
            Exit
        EndIf
        
        For ny := 1 to len(aChave)
            cFunCla := aChave[ny]
            If Upper(cFunCla) + "(" $ Upper(SX7->(FieldGet(FieldPos("X7_CHAVE"))))
                AAdd(aLista, {SX7->(FieldGet(FieldPos("X7_CAMPO")) + FieldGet(FieldPos("X7_SEQUENC")) ), "", "", cFunCla, "", "X7_CHAVE" } )
            EndIf 
            If Upper(cFunCla) + "(" $ Upper(SX7->(FieldGet(FieldPos("X7_CONDIC"))))
                AAdd(aLista, {SX7->(FieldGet(FieldPos("X7_CAMPO")) + FieldGet(FieldPos("X7_SEQUENC")) ), "", "", cFunCla, "", "X7_CONDIC" } )
            EndIf 
        Next 
        SX7->(DbSkip())
    End
    SX7->(DbGoto(nRec))

Return 

Static Function PesqFSXB(cChave, aLista)
    Local nRec    := SXB->(Recno())
    Local cFunCla := ""
    Local aChave  := {}
    Local ny      := 0

    cChave := Upper(Alltrim(cChave))

    If "," $ cChave
        aChave := Separa(cChave, ",", .T.)
    Else 
        aChave := {cChave}
    EndIf

    ProcRegua(SXB->(LastRec()))
    SXB->(DbGotop())
    While SXB->(! Eof() )
        IncProc()
        ProcessMessage()
        If lAbortPrint
            FWAlertWarning("Busca interrompida!!!")
            Exit
        EndIf
        
        For ny := 1 to len(aChave)
            cFunCla := aChave[ny]
            If Upper(cFunCla) + "(" $ Upper(SXB->(FieldGet(FieldPos("XB_CONTEM"))))
                AAdd(aLista, {SXB->(FieldGet(FieldPos("XB_ALIAS"))), "", "", cFunCla, "", "XB_CONTEM" } )
            EndIf 
        Next 
        SXB->(DbSkip())
    End
    SXB->(DbGoto(nRec))

Return 

Static Function PesqFMNU(cChave, aLista)
    Local cQuery    := ""
    Local cTMP      := GetNextAlias()
    Local aArea     := GetArea()
    Local ny        := 0
    Local aChave    := {}
    
    cChave := Upper(Alltrim(cChave))

    If "," $ cChave
        aChave := Separa(cChave, ",", .T.)
    Else 
        aChave := {cChave}
    EndIf
    
    For ny := 1 to len(aChave)
        cChave := aChave[ny]
        If Left(cChave, 2) == "U_"
            cChave := Subs(cChave, 3)
        EndIf 

        cQuery := " "
        cQuery += " SELECT DISTINCT M_NAME, F_FUNCTION    " 
        cQuery += " FROM   MPMENU_FUNCTION FUNC   " 
        cQuery += " INNER JOIN MPMENU_ITEM ITM ON I_ID_FUNC = F_ID   " 
        cQuery += "        AND ITM.D_E_L_E_T_ = ' '   " 
        cQuery += " INNER JOIN MPMENU_MENU MENU ON M_ID = I_ID_MENU   " 
        cQuery += "        AND MENU.D_E_L_E_T_ = ' '   " 
        cQuery += " WHERE  F_FUNCTION LIKE '%"+ cChave +"%'   " 
        cQuery += "        AND FUNC.D_E_L_E_T_ = ' '   " 

    
        DbUseArea(.T., "TOPCONN", TcGenQry(NIL, NIL, cQuery), cTMP, .T., .F.)
        If (cTMP)->(Eof())		
            (cTMP)->(DbCloseArea())
            Loop
        EndIf
        
        ProcRegua(1)
        While  (cTMP)->(! Eof())
            IncProc((cTMP)->M_NAME)
            ProcessMessage()
            If lAbortPrint
                FWAlertWarning("Busca interrompida!!!")
                Exit
            EndIf
            If "BKP" $ (cTMP)->M_NAME
                (cTMP)->(DbSkip())
                Loop 
            EndIf     

            (cTMP)->(AAdd(aLista, {M_NAME, "", "", F_FUNCTION, "", "MENU" } )) 
            (cTMP)->(DbSkip())
        End
        (cTMP)->(DbCloseArea())
        
    Next 

    RestArea(aArea) 
Return     

Static Function BuscaPar(aLista, nAt, cMemo2, oMemo2)
    Local cRet    := ""
    Local cRetPar := ""
    Local cPar    := ""
    Local nX  := 0
    Local nY := 0
    Local nZ := 0
    Local aRet2   := {}
    Local cNomeFunc := aLista[nAt, 4] 
    Local lAdvpl    := aLista[nAt, 6] == "ADVPL"
    Local lClasse   := aLista[nAt, 6] == "Classe"
    Local cChamada := cNomeFunc+'('

    If lClasse
        nX := ascan(__aClass,{|x|cNomeFunc $ x[1]})
        cRetPar += 'Classe:' + __aClass[nx, 1]+CRLF
        If !empty(__aClass[nx, 2])
            cRetPar += 'Herdada de: ' + __aClass[nx, 2]+CRLF
        EndIf

        If !empty(__aClass[nx, 3])
            cRetPar += CRLF
            cRetPar += 'Variáveis: '+CRLF
            for nY:= 1 to Len(__aClass[nx, 3])
                cRetPar += "   "+__aClass[nx, 3, nY, 1]+CRLF
            next
        EndIf

        If !empty(__aClass[nx, 4])
            cRetPar += CRLF
            cRetPar += 'Métodos: '+ CRLF
            for nY := 1 to Len(__aClass[nx, 4])
                cRetPar += "   " + __aClass[nx, 4, nY, 1] + CRLF

                If !empty(__aClass[nx, 4, nY, 2])
                    cRetPar += "    " + "Parâmetros:" + CRLF

                    For nZ := 1 to len(__aClass[nx, 4, nY, 2]) step 2
                        cPar := SubStr(__aClass[nx, 4, nY, 2], nZ, 2)
                        Do Case
                        Case Left(cPar, 1) == '*'
                            cRet := 'xExp' + strZero((nZ + 1) / 2, 2) + ' - variavel'
                        Case Left(cPar, 1) == 'C'
                            cRet := 'cExp' + strZero((nZ + 1) / 2, 2) + ' - caracter'
                        Case Left(cPar, 1) == 'N'
                            cRet := 'nExp' + strZero((nZ + 1) / 2, 2) + ' - numerico'
                        Case Left(cPar, 1) == 'A' 
                            cRet := 'aExp' + strZero((nZ + 1) / 2, 2) + ' - array'
                        Case Left(cPar, 1) == 'L'
                            cRet := 'lExp' + strZero((nZ + 1) / 2, 2) + ' - logico'
                        Case Left(cPar, 1) == 'B'
                            cRet := 'bExp' + strZero((nZ + 1) / 2, 2) + ' - bloco de codigo'
                        Case Left(cPar, 1) == 'O'
                            cRet := 'oExp' + strZero((nZ + 1) / 2, 2) + ' - objeto'
                        EndCase
                        If Right(cPar, 1) == 'R'
                            cRet += ' [obrigatorio]'
                        ElseIf Right(cPar,1)=='O'
                            cRet += ' [opcional]'
                        EndIf
                        cRetPar += "       "+cRet+CRLF
                    Next nZ
                EndIf
                cRetPar += CRLF
            next
        EndIf
    ElseIf lAdvpl
        nX := ascan(__aFunc, {|x|cNomeFunc $ x[1]})
        If nX>0
            For nY := 1 to len(__aFunc[nX, 2]) step 2
                cPar := SubStr(__aFunc[nX, 2], nY, 2)

                If Right(cPar,1) == 'R'
                    cRet := Chr(9) + ' [obrigatorio]'
                ElseIf Right(cPar, 1) == 'O'
                    cRet := Chr(9) + ' [opcional]'
                EndIf

                Do Case
                Case Left(cPar, 1) == '*'
                    cPar := 'xExp' + strZero((nY + 1) / 2, 2)
                    cRet := cPar +' - variavel' + cRet
                Case Left(cPar, 1) == 'C'
                    cPar := 'cExp' + strZero((nY + 1) / 2, 2)
                    cRet := cPar +' - caracter' + cRet
                Case Left(cPar, 1) == 'N'
                    cPar := 'nExp' + strZero((nY + 1) / 2, 2)
                    cRet := cPar + ' - numerico' + cRet
                Case Left(cPar, 1) == 'A'
                    cPar := 'aExp' + strZero((nY + 1) / 2, 2)
                    cRet := cPar + ' - array' + cRet
                Case Left(cPar, 1) == 'L'
                    cPar := 'lExp' + strZero((nY + 1) / 2, 2)
                    cRet := cPar + ' - logico' + cRet
                Case Left(cPar, 1) == 'B'
                    cPar := 'bExp' + strZero((nY + 1) / 2, 2)
                    cRet := cPar + ' - bloco de codigo' + cRet
                Case Left(cPar, 1) == 'O'
                    cPar := 'oExp' + strZero((nY + 1) / 2, 2)
                    cRet := cPar + ' - objeto' + cRet
                EndCase
                cChamada += cPar + ', '
                cRetPar += "    Parametro " + cValtoChar((nY + 1) / 2) + " = " + cRet + CRLF

            Next nY
        EndIf
    Else
        aRet2:= GetFuncPrm(cNomeFunc)

        for nY:= 1 to Len(aRet2)
            cPar:= aRet2[nY]
            Do Case
            Case Left(cPar, 1) == 'X'
                cRet := ' - variavel'
            Case Left(cPar, 1) == 'C'
                cRet := ' - caracter'
            Case Left(cPar, 1) == 'N'
                cRet := ' - numerico'
            Case Left(cPar, 1) == 'A'
                cRet := ' - array'
            Case Left(cPar, 1) == 'L'
                cRet := ' - logico'
            Case Left(cPar, 1) == 'D'
                cRet := ' - data'
            Case Left(cPar, 1) == 'B'
                cRet := ' - bloco de codigo'
            Case Left(cPar, 1) == 'O'
                cRet := ' - objeto'
            OtherWise
                cRet :=' - Unknown'
            EndCase
            cChamada += cPar + ', '
            cRetPar += "    Parametro " + cValtoChar(nY) + " = " + aRet2[nY] + cRet + CRLF
        Next
    EndIf

    If !lClasse
        If ','$cChamada
            cChamada := SubStr(cChamada, 1, Len(cChamada) - 2)
        EndIf
        cRetPar := cChamada + ')' + CRLF + CRLF + cRetPar
    EndIf

    cMemo2 := cRetPar
    oMemo2 :Refresh()

Return

/*
#################################################################################################################################
Aba de execução de linha de comando
#################################################################################################################################
*/

Static Function FolderCmd(oDlg)
    Local oBut
    Local oBut2
    Local oBut3
    Local oBut4
    Local oCheck
    Local lCheck := .T. 

    Local oP1 
    Local oP2
    Local oP3
    Local oP4

    Local oMemo1
    Local cMemo1 := ""
    Local oMemo2
    Local cMemo2 := ""
    Local oMsg 
    Local cMsg   := ""
    Local oFont:= TFont():New("Consolas",, 20,, .F.,,,,, .F. )
    Local oFontB := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)

  
    oP1:= TPanelCss():New(,,, oDlg)
    oP1:SetCoors(TRect():New(0, 0, 30, __nWidth))
    oP1:Align :=CONTROL_ALIGN_TOP

        oBut  := THButton():New(002, 002,"Executar"         ,oDlg  , {|| ExecMacro(cMemo1, @cMemo2, oMsg,  lCheck, oMemo2)}, 45, 10, oFontB, "Executa as linhas com macro") 
        oBut2 := THButton():New(002, 050,"Histórico"        ,oDlg  , {|| MenuCmd(@cMemo1, oBut2)                          }, 45, 10, oFontB, "Lista com o historico") 
        oBut3 := THButton():New(002, 102,"Base Conhecimento",oDlg  , {|| MenuBase(@cMemo1, oBut3)                         }, 60, 10, oFontB, "Base de conhecimento") 
        oBut4 := THButton():New(002, 170,"Limpar"           , oDlg , {|| cMemo1 := ""                                     }, 50, 10, oFontB, "Limpa memo de comandos")
        oBut5 := THButton():New(002, 222,"XML Format"       , oDlg , {|| TrataXML(cMemo1, @cMemo2)                        }, 50, 10, oFontB, "Formata xml")
        oBut6 := THButton():New(002, 272,"JSon Format"      , oDlg , {|| TrataJson(cMemo1, @cMemo2)                       }, 50, 10, oFontB, "Formata Json")
        
        @ 002, 372 CHECKBOX oCheck VAR lCheck	 PROMPT "Trata Erro"	 SIZE 055,010 OF oP1 PIXEL font oFontB 
        
    oP2:= TPanelCss():New(,,, oDlg)
    oP2:SetCoors(TRect():New(0, 0, __nHeight * 0.4, __nWidth))
    oP2:Align :=CONTROL_ALIGN_TOP
        
        oMemo1 := tMultiget():new(,, bSETGET(cMemo1), oP2)
        oMemo1:Align := CONTROL_ALIGN_ALLCLIENT
        oMemo1:oFont:=oFont


    oP3:= TPanelCss():New(,,, oDlg)
    oP3:SetCoors(TRect():New(0, 0, __nHeight * 0.5, __nWidth))
    oP3:Align :=CONTROL_ALIGN_ALLCLIENT

        oMemo2 := tMultiget():new(,, bSETGET(cMemo2), oP3)
        oMemo2:Align := CONTROL_ALIGN_ALLCLIENT
        oMemo2:oFont:=oFont
        

    oP4:= TPanelCss():New(,,, oDlg)
    oP4:SetCoors(TRect():New(0, 0, 30, __nWidth))
    oP4:Align :=CONTROL_ALIGN_BOTTOM
        @ 002, 002 SAY oMsg VAR cMsg SIZE 300,010 OF oP4 PIXEL FONT oFont
        

Return

Static Function ExecMacro(cMemo1, cMemo2, oMsg, lCheck, oMemo2) 
    Local nX     := 0
    Local xAux   := ""
    Local cRet   := ""
    Local bErroA
    Local nSec1  := 0
    Local nSec2  := 0
    Local cMsgT  := ""
    Local cLinha := ""
    Local nP     := 0
    Local lAdmin := __lAdmin
    Local lReadOnly := __lReadOnly
    Local cUser  := __cUserID 

    __cErroA :=""
    If lCheck
        bErroA   := ErrorBlock({ |oErro| ChkErr(oErro)})
    EndIf
    
    oMsg:SetText("")
    oMsg:Refresh()
    ProcessMessage()
    If Empty(cMemo1)
        oMsg:SetText("Linha de comando em branco!!!")
        Return 
    EndIf 

    GrvHst(__aHstCmd, "cmd", cMemo1)

    cMemo2 := ""
    oMemo2:Refresh()
    ProcessMessage()

    Set(11,"on")    
    
    Begin Sequence
        nSec1 := Seconds()

        For nx:= 1 to MlCount(cMemo1)
            cLinha += MemoLine(cMemo1, 254, nx)

            // tira o comentario
            nP := at("//", cLinha)
            If ! Empty(nP)
                cLinha := Left(cLinha, nP - 1)
            EndIf
            cLinha := Alltrim(cLinha)
            If empty(cLinha)
                Loop
            EndIf

            If Right(cLinha, 1) == ";"
                cLinha := Left(cLinha, len(cLinha) - 1)
                Loop
            EndIf
            xAux := &(cLinha)
            cLinha := ""

            If Valtype(xAux)=='C'
                cRet:= xAux
            Else
                If ValType(xAux)!= 'U'
                    If ValType(xAux)== 'A'
                        cRet := VarInfo('A',xAux,,.F.)
                    ElseIf ValType(xAux)== 'N'
                        cRet := Alltrim(Str(xAux))
                    ElseIf ValType(xAux)== 'B'
                        cRet := GetCbSource(xAux)
                    Else
                        cRet := AllToChar(xAux)
                    EndIf
                Else 
                    cRet := "NIL"                
                EndIf
            EndIf
            cMemo2 += Valtype(xAux) + ' -> ' + cRet + CRLF
            oMemo2:Refresh()
            ProcessMessage()
        next
        nSec2 := Seconds()

        IncLog("CMD", "", cMemo1)
    End Sequence

    If __lDeleOn
        Set(11,"on")
    Else
        Set(11,"off")
    EndIf

    If lCheck
        ErrorBlock( bErroA )
    EndIf

    

    If ! Empty(__cErroA)
        cMemo2 += __cErroA
        oMsg:SetText("Erro na linha " + AllTrim(Str(nx)))
        __cErroA:= ""
    Else
        If nSec2 >= nSec1 
            cMsgT := "Tempo de Execução: " + APSec2Time(nSec2 - nSec1) + " (" + Alltrim(Str(nSec2 - nSec1)) + " segs.)"
            oMsg:SetText(cMsgT)
        EndIf 
    EndIf
    oMsg:Refresh()
    __lAdmin    := lAdmin
    __lReadOnly := lReadOnly
    __cUserID   := cUser 

Return cRet


Static Function MenuCmd(cCMD, oOwner)

    Local nX := 0
    Local oMenu
    Local cAux    := ''
    Local bBlock  :={||}
    
    LeHst(__aHstCmd, "cmd")

    oMenu := tMenu():new(0, 0, 0, 0, .T., , oOwner)

    oMenu:Add(tMenuItem():new(oMenu, "Excluir"         , , , , {|| If(FWAlertYesNo("Confirma a exclusão?")            , (GrvHst(__aHstCmd, "cmd", cCMD, .F., .T.), .t. ), .t.) }, , , , , , , , , .T.))
    oMenu:Add(tMenuItem():new(oMenu, "Limpar Histórico", , , , {|| If(FWAlertYesNo("Confirma a limpeza do histórico?"), (GrvHst(__aHstCmd, "cmd", ""  , .T., .F.), .t. ), .t.) }, , , , , , , , , .T.))

    For nX := Len(__aHstCmd) To 1 Step -1
        cAux := cValToChar(nX)+ ". " + Left( Alltrim (__aHstCmd[nX]), 120)
        bBlock:=&('{|| cCMD:= __aHstCmd[' + str(nX) + ']}')
        oMenu:Add(tMenuItem():new(, cAux, , , , bBlock, , , , , , , , , .T.))
    Next

    oMenu:Activate(NIL, 21, oOwner)

Return


Static Function MenuBase(cCMD, oOwner)

    Local nX := 0
    Local oMenu
    Local cAux    := ''
    Local bBlock  :={||}
    
    LeHst(__aHstBase, "base")

    oMenu := tMenu():new(0, 0, 0, 0, .T., , oOwner)
    oMenu:Add(tMenuItem():new(oMenu, "Adicionar"     , , , , {|| GrvHst(__aHstBase, "base", cCMD)}, , , , , , , , , .T.))

    oMenu:Add(tMenuItem():new(oMenu, "Excluir"       , , , , {|| If(FWAlertYesNo("Confirma a exclusão?")            , (GrvHst(__aHstBase, "base", cCMD, .F., .T.), .t. ), .t.) }, , , , , , , , , .T.))
    oMenu:Add(tMenuItem():new(oMenu, "Excluir todos" , , , , {|| If(FWAlertYesNo("Confirma a exclusão de toda base"), (GrvHst(__aHstBase, "base", ""  , .T., .F.), .t. ), .t.) }, , , , , , , , , .T.))

    For nX := 1 to  Len(__aHstBase) 
        cAux := Alltrim(MemoLine(__aHstBase[nx], 254, 1))
        If left(cAux, 2) == "//"
            cAux := Subs(cAux, 3)
        EndIf 
        cAux := cValToChar(nX)+ ". " +  cAux 
        bBlock:=&('{|| cCMD:= __aHstBase[' + str(nX) + ']}')
        oMenu:Add(tMenuItem():new(, cAux, , , , bBlock, , , , , , , , , .T.))
    Next

    oMenu:Activate(NIL, 21, oOwner)

Return

Static Function MenuMacro(cCMD, oOwner, nModo)

    Local nX := 0
    Local oMenu
    Local cAux    := ''
    Local bBlock  :={||}
    Local cSufix  := ""

    cSufix := "macro" + Str(nModo, 1)
    
    LeHst(__aHstMacro[nModo], cSufix)

    oMenu := tMenu():new(0, 0, 0, 0, .T., , oOwner)

    oMenu:Add(tMenuItem():new(oMenu, "Excluir"         , , , , {|| If(FWAlertYesNo("Confirma a exclusão?")            , (GrvHst(__aHstMacro[nModo], cSufix, cCMD, .F., .T.), .t. ), .t.) }, , , , , , , , , .T.))
    oMenu:Add(tMenuItem():new(oMenu, "Limpar Histórico", , , , {|| If(FWAlertYesNo("Confirma a limpeza do histórico?"), (GrvHst(__aHstMacro[nModo], cSufix, ""  , .T., .F.), .t. ), .t.) }, , , , , , , , , .T.))

    For nX := Len(__aHstMacro[nModo]) To 1 Step -1
        cAux := cValToChar(nX)+ ". " + Left( Alltrim (__aHstMacro[nModo, nX]), 120)
        bBlock:=&('{|| cCMD:= __aHstMacro[' + Str(nModo) + '][' + str(nX) + ']}')
        oMenu:Add(tMenuItem():new(, cAux, , , , bBlock, , , , , , , , , .T.))
    Next

    oMenu:Activate(NIL, 21, oOwner)

Return

Static Function TrataXML(cMemo1, cMemo2)
    cMemo2 := XMLFormat(cMemo1)
Return 

Static Function TrataJson(cMemo1, cMemo2)
    cMemo2 := JsonFormat(cMemo1)
Return 

Static Function JsonFormat(cJson)
    Local cMsg    := ""
    Local nx      := 0
    Local nTab    := 0 
    Local cMsg2   := ""

    cMsg := FWCutOff(cJson) // Retira CRLF E TAB

    For nx:= 1 to len(cMsg)
        cChar := Subs(cMsg, nx, 1)
        If cChar $ "{["
            cMsg2   += cChar
            nTab += 4
            cMsg2 += CRLF  
            cMsg2 += Repl(" ", nTab) 
        ElseIf cChar $ "]}"
            nTab -= 4
            cMsg2 += CRLF  
            cMsg2 += Repl(" ", nTab) 
            cMsg2 += cChar
        ElseIf cChar == ","
            cMsg2 += cChar
            cMsg2 += CRLF  
            cMsg2 += Repl(" ", nTab) 
        Else 
            cMsg2   += cChar
        EndIf 
    Next 

Return cMsg2


/*
#################################################################################################################################
Aba de execução de Script HTML
#################################################################################################################################
*/
Static Function FolderHtm(oDlg)
    Local oBut
    Local oBut2

    Local oP1 
    Local oP2
    Local oP3

    Local oMemo1
    Local cMemo1 := ""
    Local oSbr
    Local oEdit
       
    Local oFont:= TFont():New("Consolas",, 20,, .F.,,,,, .F. )
    Local oFontB := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)

    oP1:= TPanelCss():New(,,, oDlg)
    oP1:SetCoors(TRect():New(0, 0, 30, __nWidth))
    oP1:Align :=CONTROL_ALIGN_TOP

        oBut  := THButton():New(002, 002,"Executar" ,oDlg,{|| ExecHtml(cMemo1, oEdit ) }, 45, 10, oFontB, "Interpreta as linhas codigos Html") 
        oBut2 := THButton():New(002, 050,"Histórico",oDlg,{|| MenuHtm(@cMemo1, oBut2)  }, 45, 10, oFontB, "Lista com o histórico") 
        
    oP2:= TPanelCss():New(,,, oDlg)
    oP2:SetCoors(TRect():New(0, 0, __nHeight * 0.4, __nWidth))
    oP2:Align :=CONTROL_ALIGN_TOP
        
        oMemo1 := tMultiget():new(,, bSETGET(cMemo1), oP2)
        oMemo1:Align := CONTROL_ALIGN_ALLCLIENT
        oMemo1:oFont:=oFont


    oP3:= TPanelCss():New(,,, oDlg)
    oP3:SetCoors(TRect():New(0, 0, __nHeight * 0.5, __nWidth))
    oP3:Align :=CONTROL_ALIGN_ALLCLIENT

        @ 0, 0 SCROLLBOX oSbr HORIZONTAL SIZE 94, 206 OF oP3 BORDER
        oSbr:Align := CONTROL_ALIGN_ALLCLIENT
        oEdit:= TSimpleEditor():New( 0, 0, oSbr, 3000, __nWidth)
        oEdit:Align := CONTROL_ALIGN_LEFT


Return

Static Function ExecHtml(cMemo1, oEdit)

    If Empty(cMemo1)
        Return 
    EndIf 

    GrvHst(__aHstHtm, "htm", cMemo1)

    oEdit:Load(cMemo1)
    oEdit:Refresh()

Return

Static Function MenuHtm(cCMD, oOwner)
    Local nX := 0
    Local oMenu
    Local cAux    := ''
    Local bBlock  :={||}
    
    LeHst(__aHstHtm, "htm")

    oMenu := tMenu():new(0, 0, 0, 0, .T., , oOwner)

    oMenu:Add(tMenuItem():new(oMenu, "Excluir"         , , , , {|| If(FWAlertYesNo("Confirma a exclusão?")            , (GrvHst(__aHstHtm, "htm", cCMD, .F., .T.), .t. ), .t.) }, , , , , , , , , .T.))
    oMenu:Add(tMenuItem():new(oMenu, "Limpar Histórico", , , , {|| If(FWAlertYesNo("Confirma a limpeza do histórico?"), (GrvHst(__aHstHtm, "htm", ""  , .T., .F.), .t. ), .t.) }, , , , , , , , , .T.))

    For nX := Len(__aHstHtm) To 1 Step -1
        cAux := cValToChar(nX)+ ". " + Left( Alltrim (__aHstHtm[nX]), 120)
        bBlock:=&('{|| cCMD:= __aHstHtm[' + str(nX) + ']}')
        oMenu:Add(tMenuItem():new(, cAux, , , , bBlock, , , , , , , , , .T.))
    Next

    oMenu:Activate(NIL, 21, oOwner)

Return

Static Function MenuFil(cFiltro, oOwner)
    Local nX := 0
    Local oMenu
    Local cAux    := ''
    Local bBlock  :={||}
    
    LeHst(__aHstFil, "filtro")

    oMenu := tMenu():new(0, 0, 0, 0, .T., , oOwner)

    oMenu:Add(tMenuItem():new(oMenu, "Excluir"         , , , , {|| If(FWAlertYesNo("Confirma a exclusão?")            , (GrvHst(__aHstFil, "filtro", cFiltro, .F., .T.), .t. ), .t.) }, , , , , , , , , .T.))
    oMenu:Add(tMenuItem():new(oMenu, "Limpar Histórico", , , , {|| If(FWAlertYesNo("Confirma a limpeza do histórico?"), (GrvHst(__aHstFil, "filtro", ""     , .T., .F.), .t. ), .t.) }, , , , , , , , , .T.))

    For nX := Len(__aHstFil) To 1 Step -1
        cAux := cValToChar(nX)+ ". " + Left( Alltrim (__aHstFil[nX]), 120)
        bBlock:=&('{|| cFiltro:= __aHstFil[' + str(nX) + ']}')
        oMenu:Add(tMenuItem():new(, cAux, , , , bBlock, , , , , , , , , .T.))
    Next

    oMenu:Activate(NIL, 21, oOwner)

Return
/*
#################################################################################################################################
Aba de execução de Script HTML
#################################################################################################################################
*/
    
Static Function FolderExp(oDlg)
    Local oList01
    Local oList02
    Local oGet1
    Local oGet2
    Local oBmp01
    Local oBmp02
    Local cPath01 := PadR("C:\",60)
    Local cPath02 := PadR("\",60)
    Local cSearch01 := Space(200)
    Local cSearch02 := Space(200)
    
    Local oFolBMP := LoadBitmap( GetResources(), "F5_AMAR")
    Local oFilBMP := LoadBitmap( GetResources(), "LBNO")

    Local oPT
    Local oPTL
    Local oPTR
    Local oPM 
    Local oPML
    Local oPMM
    Local oPMR
    Local oPB 
    Local oPBL
    Local oPBR
    Local cStyle	:= "QFrame{ border-style:solid; border-width:0px; border-color:#DCDCDC; background-image:url(rpo:layout_042.png); backgroud-repeat: repeat-y }"
    

    oPT:= TPanelCss():New(,,, oDlg)
    oPT:SetCoors(TRect():New(0, 0, 60, __nWidth))
    oPT:Align :=CONTROL_ALIGN_TOP
    oPT:setCSS(cStyle)

        oPTL:= TPanelCss():New(,,, oPT)
        oPTL:SetCoors(TRect():New(0, 0, __nHeight, __nWidth * 0.5))
        oPTL:Align :=CONTROL_ALIGN_LEFT
        

            @ 03  ,  02 MSGET  oGet1  VAR cPath01   PICTURE "@!" PIXEL SIZE 300, 009 WHEN .F.  OF oPTL
            @ 03  , 302 BITMAP oBmp01 NAME "OPEN"   SIZE 015,015 OF oPTL PIXEL NOBORDER ON CLICK (cPath01 := OpenBtn(cPath01, "T"), LeDirect(oList01, oGet1, @cPath01) )
            @ 15  ,  02 MSGET  oGet1  VAR cSearch01 PICTURE "@!" PIXEL SIZE 300, 009  OF oPTL
            @ 15  , 302 BITMAP oBmp01 NAME "LUPA"   SIZE 015,015 OF oPTL PIXEL NOBORDER ON CLICK (FAtualiz(cSearch01, oList01, 2) )

        oPTM:= TPanelCss():New(,,, oPT)
        oPTM:SetCoors(TRect():New(0, 0, 60, 60))
        oPTM:Align :=CONTROL_ALIGN_LEFT
        

        oPTR:= TPanelCss():New(,,, oPT)
        oPTR:SetCoors(TRect():New(0, 0, __nHeight, __nWidth * 0.5))
        oPTR:Align :=CONTROL_ALIGN_ALLCLIENT
        

            @ 03  ,  02 MSGET  oGet2  VAR cPath02   PICTURE "@!" PIXEL SIZE 300, 009 WHEN .F.  OF oPTR
            @ 03  , 302 BITMAP oBmp02 NAME "OPEN"   SIZE 015, 015 OF oPTR PIXEL NOBORDER ON CLICK (cPath02 := OpenBtn(cPath02,"S"), LeDirect(oList02, oGet2, @cPath02))
            @ 15  ,  02 MSGET  oGet2  VAR cSearch02 PICTURE "@!" PIXEL SIZE 300, 009  OF oPTR
            @ 15  , 302 BITMAP oBmp02 NAME "LUPA"   SIZE 015, 015 OF oPTR PIXEL NOBORDER ON CLICK (FAtualiz(cSearch02, oList02, 2))


    oPM:= TPanelCss():New(,,, oDlg)
    oPM:SetCoors(TRect():New(0, 0, 30, __nWidth))
    oPM:Align :=CONTROL_ALIGN_ALLCLIENT
    //oPM:setCSS(cStyle)

        oPML:= TPanelCss():New(,,, oPM)
        oPML:SetCoors(TRect():New(0, 0, 60, (__nWidth * 0.5) - 30))
        oPML:Align :=CONTROL_ALIGN_LEFT
        
            oList01 := MsBrGetDBase():new( 0, 0, 300, 300 ,,,, oPML,,,,,,,,,,,, .F., "", .T.,, .F.,,, )
            oList01:addColumn( TCColumn():new( " "           , { || If(oList01:aArray[oList01:nAt, 1] == "2", oFilBMP, oFolBMP) },,,, "LEFT",  05, .T., .F.,,,, .F. ) )
            oList01:addColumn( TCColumn():new( "File Name"   , { || oList01:aArray[oList01:nAt, 2] },,,, "LEFT", 185, .F., .F.,,,, .F. ) )
            oList01:addColumn( TCColumn():new( "File Size"   , { || oList01:aArray[oList01:nAt, 3] },,,, "LEFT", 035, .F., .F.,,,, .F. ) )
            oList01:addColumn( TCColumn():new( "File Date"   , { || oList01:aArray[oList01:nAt, 4] },,,, "LEFT", 030, .F., .F.,,,, .F. ) )
            oList01:addColumn( TCColumn():new( "File Hora"   , { || oList01:aArray[oList01:nAt, 5] },,,, "LEFT", 030, .F., .F.,,,, .F. ) )
            oList01:bLDblClick := {|| LeDirect(oList01, oGet1, @cPath01, .T.) }
            oList01:Align :=CONTROL_ALIGN_ALLCLIENT

        oPMM:= TPanelCss():New(,,, oPM)
        oPMM:SetCoors(TRect():New(0, 0, 60, 60))
        oPMM:Align :=CONTROL_ALIGN_LEFT
        oPMM:setCSS(cStyle)

            @ 080, 10 BITMAP oBmp01 NAME "FILTRO"  SIZE 015, 015 OF oPMM PIXEL NOBORDER ON CLICK (MaskDir(),LeDirect(oList01, oGet1, @cPath01), LeDirect(oList02, oGet2, @cPath02))
            @ 100, 10 BITMAP oBmp01 NAME "RIGHT"   SIZE 015, 015 OF oPMM PIXEL NOBORDER ON CLICK MsgRun("Copiando Arquivo...","Aguarde.",{|| FCopia(cPath01, cPath02, oList01) , LeDirect(oList01, oGet1, @cPath01),  LeDirect(oList02, oGet2, @cPath02) })
            @ 120, 10 BITMAP oBmp01 NAME "LEFT"    SIZE 015, 015 OF oPMM PIXEL NOBORDER ON CLICK MsgRun("Copiando Arquivo...","Aguarde.",{|| FCopia(cPath02, cPath01, oList02) , LeDirect(oList01, oGet1, @cPath01),  LeDirect(oList02, oGet2, @cPath02) })
            @ 140, 10 BITMAP oBmp01 NAME "RIGHT_2" SIZE 015, 015 OF oPMM PIXEL NOBORDER ON CLICK Processa({|| FCopia(cPath01, cPath02, oList01,.T.), LeDirect(oList01, oGet1, @cPath01), LeDirect(oList02, oGet2, @cPath02)}, "Copia de arquivos","Copiando", .T.)
            @ 160, 10 BITMAP oBmp01 NAME "LEFT2"   SIZE 015, 015 OF oPMM PIXEL NOBORDER ON CLICK Processa({|| FCopia(cPath02, cPath01, oList02,.T.), LeDirect(oList01, oGet1, @cPath01), LeDirect(oList02, oGet2, @cPath02)}, "Copia de arquivos","Copiando", .T.)
            


        oPMR:= TPanelCss():New(,,, oPM)
        oPMR:SetCoors(TRect():New(0, 0, 60, (__nWidth * 0.5) - 30))
        oPMR:Align :=CONTROL_ALIGN_ALLCLIENT

            oList02 := MsBrGetDBase():new( 0, 0, 300, 300 ,,,, oPMR,,,,,,,,,,,, .F., "", .T.,, .F.,,, )
            oList02:addColumn( TCColumn():new( " "           , { || If(oList02:aArray[oList02:nAt, 1] == "2", oFilBMP, oFolBMP) },,,, "LEFT",  05, .T., .F.,,,, .F. ) )
            oList02:addColumn( TCColumn():new( "File Name"   , { || oList02:aArray[oList02:nAt, 2] },,,, "LEFT", 185, .F., .F.,,,, .F. ) )
            oList02:addColumn( TCColumn():new( "File Size"   , { || oList02:aArray[oList02:nAt, 3] },,,, "LEFT", 035, .F., .F.,,,, .F. ) )
            oList02:addColumn( TCColumn():new( "File Date"   , { || oList02:aArray[oList02:nAt, 4] },,,, "LEFT", 030, .F., .F.,,,, .F. ) )
            oList02:addColumn( TCColumn():new( "File Hora"   , { || oList02:aArray[oList02:nAt, 5] },,,, "LEFT", 030, .F., .F.,,,, .F. ) )
            oList02:bLDblClick := {|| LeDirect(oList02, oGet2, @cPath02, .T.) }
            oList02:Align :=CONTROL_ALIGN_ALLCLIENT

    oPB:= TPanelCss():New(,,, oDlg)
    oPB:SetCoors(TRect():New(0, 0, 40, __nWidth ))
    oPB:Align :=CONTROL_ALIGN_BOTTOM
    oPB:setCSS(cStyle)

        oPBL:= TPanelCss():New(,,, oPB)
        oPBL:SetCoors(TRect():New(0, 0, 60, __nWidth * 0.5))
        oPBL:Align :=CONTROL_ALIGN_LEFT
    
            @ 03, 02 BITMAP oBmp01 NAME "BMPDEL"    SIZE 015, 015 OF oPBL PIXEL NOBORDER ON CLICK MsgRun("Apagando Arquivo...","Aguarde.",{|| FApaga(cPath01, oList01) , LeDirect(oList01, oGet1, @cPath01) })
            @ 03, 17 BITMAP oBmp01 NAME "SDUDRPTBL" SIZE 015, 015 OF oPBL PIXEL NOBORDER ON CLICK Processa({|| FApaga(cPath01, oList01, .T.), LeDirect(oList01, oGet1, @cPath01) }, "Exclusão de arquivos", "Excluindo", .T.)

        oPBM:= TPanelCss():New(,,, oPB)
        oPBM:SetCoors(TRect():New(0, 0, 60, 60))
        oPBM:Align :=CONTROL_ALIGN_LEFT
        oPBM:setCSS(cStyle)

        oPBR:= TPanelCss():New(,,, oPB)
        oPBR:SetCoors(TRect():New(0, 0, 60, __nWidth * 0.5))
        oPBR:Align :=CONTROL_ALIGN_ALLCLIENT

            If __lAdmin
                @ 03, 02 BITMAP oBmp01 NAME "BMPDEL"    SIZE 015,015 OF oPBR PIXEL NOBORDER ON CLICK MsgRun("Apagando Arquivo...", "Aguarde.", {|| FApaga(cPath02, oList02), LeDirect(oList02, oGet2, @cPath02)})
                @ 03, 17 BITMAP oBmp01 NAME "SDUDRPTBL" SIZE 015,015 OF oPBR PIXEL NOBORDER ON CLICK Processa({|| FApaga(cPath02, oList02, .T.), LeDirect(oList02, oGet2, @cPath02)}, "Exclusão de arquivos", "Excluindo", .T.)
            EndIf 


    LeDirect(oList01, oGet1, @cPath01)
    LeDirect(oList02, oGet2, @cPath02)

    __bTelExp:= {|| AtuFolExp(oPTL, oPML, oPBL) }

Return

Static Function AtuFolExp(oPTL, oPML, oPBL)
    oMainWnd:ReadClientCoors()

    __nHeight := oMainWnd:nHeight - 100
    __nWidth  := oMainWnd:nWidth 

    oPTL:SetCoors(TRect():New( 0,0, __nHeight, (__nWidth * 0.5) - 30))
    oPML:SetCoors(TRect():New( 0,0, __nHeight, (__nWidth * 0.5) - 30))
    oPBL:SetCoors(TRect():New( 0,0, __nHeight, (__nWidth * 0.5) - 30))
    
Return


Static Function LeDirect(oObjList, oGetInfo, cInfoPath, lClick)

    Local aRetList := {{"0","..","","",""}}
    Local aArqInfo := {}
    Local cFile := ''
    
    DEFAULT lClick := .F.

    cInfoPath := AllTrim(cInfoPath)

    If lClick
        If oObjList:aArray[oObjList:nAt, 1] == "0"
            cInfoPath := Substr(cInfoPath,1,RAT("\",Substr(cInfoPath,1,Len(cInfoPath)-1)))
        ElseIf oObjList:aArray[oObjList:nAt, 1] == "1"
            cInfoPath := cInfoPath+AllTrim(oObjList:aArray[oObjList:nAt, 2])+"\"
        Else
            If (':'$cInfoPath)
                cFile := cInfoPath+AllTrim(oObjList:aArray[oObjList:nAt, 2])
            Else
                cPathDes := GetTempPath()
                If CPYS2T(cInfoPath+oObjList:aArray[oObjList:nAt, 2],cPathDes,.T.)
                    cFile := cPathDes+oObjList:aArray[oObjList:nAt, 2]
                Else
                    FWAlertWarning("Erro ao copiar arquivo.")
                EndIf
            EndIf

            If !empty(cFile)
                ShellExecute('open','cmd.exe','/k '+cFile , "", 0)
            EndIf

            Return
        EndIf
    EndIf

    aArqInfo := Directory(cInfoPath + __cMaskArq, "D")

    If Len(aArqInfo) > 0
        AEval(aArqInfo, {|x,y| If(Left(AllTrim(x[1]), 1) != ".", AAdd(aRetList, {Iif("D"$x[5], "1", "2"), x[1], PADR(Ceiling(x[2] / 1024), 12)+' KB', x[3], x[4]}), )})
        ASort(aRetList,,, {|x,y| x[1] + x[2] < y[1] + y[2] })
    EndIf

    oObjList:SetArray(aRetList)
    
    oObjList:nAt := 1
    oObjList:Refresh()
    oGetInfo:Refresh()

Return

Static Function OpenBtn(cAtual,cOnde)
    Local cRetDir := ""
    If cOnde == "T"
        cRetDir := MyGetFile("Todos Arquivos|*.*|","Escolha o caminho dos arquivos.",0,cAtual,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_NETWORKDRIVE)
    ElseIf cOnde == "S"
        cRetDir := MyGetFile("Todos Arquivos|*.*|","Escolha o caminho dos arquivos.",0,cAtual,,GETF_RETDIRECTORY+GETF_ONLYSERVER)
    EndIf
    cRetDir := Iif(Empty(cRetDir),cAtual,cRetDir)
Return cRetDir



Static Function FCopia(cPathOri,cPathDes,oObjList,lMultCpy)
    Local aMultCopy := {}
    Private lAbortPrint := .F.

    DEFAULT lMultCpy := .F.

    If lMultCpy
        AEval(oObjList:aArray,{|x,y| If(x[1] == "2",AAdd(aMultCopy,AllTrim(x[2])),) })
        ProcRegua(Len(aMultCopy))
        If ":" $ cPathOri
            AEval(aMultCopy,{|x,y| If(!lAbortPrint, (CPYT2S(cPathOri+x,cPathDes,.T.), IncProc("Copiando "+Transform(y*100/Len(aMultCopy),"@E 99")+"% - "+x) ),) })
        Else
            AEval(aMultCopy,{|x,y| If(!lAbortPrint, (CPYS2T(cPathOri+x,cPathDes,.T.), IncProc("Copiando "+Transform(y*100/Len(aMultCopy),"@E 99")+"% - "+x) ),) })
        EndIf
    ElseIf oObjList:aArray[oObjList:nAt, 1] == "2"
        If ":" $ cPathOri
            If !CPYT2S(cPathOri+oObjList:aArray[oObjList:nAt, 2],cPathDes,.T.)
                FWAlertWarning("Erro ao copiar arquivo.")
            EndIf
        Else
            If !CPYS2T(cPathOri+oObjList:aArray[oObjList:nAt, 2],cPathDes,.T.)
                FWAlertWarning("Erro ao copiar arquivo.")
            EndIf
        EndIf
    Else
        FWAlertWarning("Não copia pastas.")
    EndIf
Return

Static Function FAtualiz(cPesq,oBox,nCol)

    Local aDados := oBox:aArray
    Local nPos   := 0

    cPesq := Alltrim(cPesq)

    If oBox:nAt < Len(aDados) .And. ( nPos := AScan(aDados,{|x| cPesq $ Alltrim(x[nCol]) },oBox:nAt+1) ) > 0
        oBox:nAt := nPos
    ElseIf ( nPos := AScan(aDados,{|x| cPesq $ Alltrim(x[nCol]) }) ) > 0
        oBox:nAt := nPos
    Else
        oBox:nAt := Len(aDados)
    EndIf

    oBox:Refresh()
    oBox:SetFocus()

Return

Static Function FApaga(cPathOri, oObjList, lEraseMult)

    Local aMultErase := {}
    Local cEraseFile := AllTrim(oObjList:aArray[oObjList:nAt, 2])

    Private lAbortPrint := .F.

    DEFAULT lEraseMult := .F.

    If lEraseMult
        AEval(oObjList:aArray, {|x,y| If(x[1] == "2",AAdd(aMultErase, AllTrim(x[2])),) })
        ProcRegua(Len(aMultErase))
        If FWAlertNoYes("Confirma a exclusao de " + AllTrim(Str(Len(aMultErase))) + " arquivos?")
            AEval(aMultErase, {|x, y| If(!lAbortPrint, (FErase(AllTrim(cPathOri) + x), IncProc("Apagando " + Transform( y * 100 / Len(aMultErase), "@E 99") + "% - " + x) ),) })
        EndIf
    ElseIf oObjList:aArray[oObjList:nAt, 1] == "2"
        If FWAlertNoYes("Apagar o arquivo [" + cEraseFile + "]?")
            FErase(AllTrim(cPathOri) + cEraseFile)
        EndIf
    Else
        FWAlertWarning("Não apaga pastas.")
    EndIf

Return


Static Function MaskDir()

    Local oDlMask,oGetMask

    __cMaskArq := Padr(__cMaskArq, 60)

    DEFINE MSDIALOG oDlMask TITLE "Informe a mascara de arquivos." FROM 0, 0 TO 30, 230 PIXEL
    @ 02, 02 MSGET oGetMask VAR __cMaskArq PICTURE "@!" PIXEL SIZE 70, 009 VALID Len(AllTrim(__cMaskArq)) >= 3 .And. "." $ __cMaskArq
    @ 02, 75 BUTTON "Ok" SIZE 037, 012 PIXEL OF oDlMask Action oDlMask:End()
    ACTIVATE MSDIALOG oDlMask CENTERED VALID Len(AllTrim(__cMaskArq)) >= 3 .And. "." $ __cMaskArq

    __cMaskArq := AllTrim(__cMaskArq)

Return

/*
#################################################################################################################################
Aba MONITOR
#################################################################################################################################
*/
    

Static Function FolderMon(oFolder, oDlg)
    Local oPS
    Local oPnlSrv
    Local oLbx

    Local cEnvServer := Padr(GetEnvserver(), 30)
    Local cServerIP  := PegaIP()
    Local nPortaTcp  := GetServerPort()

    Local aLista := SrvInfoUser(cServerIP, nPortaTcp, Alltrim(cEnvServer))
    Local oFontB := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)

    If Empty(aLista)
        aadd(aLista, {"", "",0 , "",	"",	"",	"",	"",	0 ,	0 ,	"",	"" , 0 , "" , 0, "" , ""})
    EndIf        

    oPS := TPanelCss():New(,,,oFolder)
    oPS :SetCoors(TRect():New( 0,0, 35, 35))
    oPS :Align := CONTROL_ALIGN_TOP
    @ 06,002 SAY "Ambiente"  of oPS SIZE 030,09 PIXEL
    @ 03,035 GET cEnvServer   of oPS SIZE 080,09 PIXEL PICTURE "@!"

    @ 06,120 SAY "Ip Server"  of oPS SIZE 030,09 PIXEL
    @ 03,150 GET cServerIP     of oPS SIZE 080,09 PIXEL PICTURE "@!"

    @ 06,235 SAY "Porta"   of oPS SIZE 030,09 PIXEL
    @ 03,252 GET nPortaTcp  of oPS SIZE 040,09 PIXEL PICTURE "99999"
    
    oBut  := THButton():New(004, 300, 'Finalizar todas'   , oPS, {|| DellAll( aLista, cEnvServer, cServerIP, nPortaTcp)   }, 60, 10, oFontB, "Finaliza todas a threads") 

    oPnlSrv := TPanelCss():New(,,,oFolder)
    oPnlSrv :SetCoors(TRect():New( 0,0, 1000, 1000))
    oPnlSrv :Align :=CONTROL_ALIGN_ALLCLIENT


    oLbx := MsBrGetDBase():New(1, 1, __DlgWidth(oPnlSrv)-1, __DlgHeight(oPnlSrv) - 1,,,, oPnlSrv ,,,,,,,,,,,, .F., "", .T.,, .F.,,,)
    oLbx:align := CONTROL_ALIGN_ALLCLIENT
    oLbx:SetArray( aLista )
    
    oLbx:addColumn( TCColumn():new("Usuário"                  , { || oLbx:aArray[oLbx:nAt,  1] },,,, "LEFT" , 100, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Máquina local"            , { || oLbx:aArray[oLbx:nAt,  2] },,,, "LEFT" , 040, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Thread"                   , { || oLbx:aArray[oLbx:nAt,  3] },,,, "RIGHT", 040, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Balance"                  , { || oLbx:aArray[oLbx:nAt,  4] },,,, "LEFT" , 100, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Função"                   , { || oLbx:aArray[oLbx:nAt,  5] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Ambiente"                 , { || oLbx:aArray[oLbx:nAt,  6] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Data e hora"              , { || oLbx:aArray[oLbx:nAt,  7] },,,, "LEFT" , 100, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Atividade"                , { || oLbx:aArray[oLbx:nAt,  8] },,,, "LEFT" , 040, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Instruções"               , { || oLbx:aArray[oLbx:nAt,  9] },,,, "RIGHT", 040, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Instruções em Seg."       , { || oLbx:aArray[oLbx:nAt, 10] },,,, "RIGHT", 060, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Observações"              , { || oLbx:aArray[oLbx:nAt, 11] },,,, "LEFT" , 250, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Memória (bytes)"          , { || oLbx:aArray[oLbx:nAt, 12] },,,, "RIGHT", 060, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("SID"                      , { || oLbx:aArray[oLbx:nAt, 13] },,,, "LEFT" , 040, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Identificador"            , { || oLbx:aArray[oLbx:nAt, 14] },,,, "RIGHT", 080, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Tipo"                     , { || oLbx:aArray[oLbx:nAt, 15] },,,, "LEFT" , 040, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Tempo de inatividade"     , { || oLbx:aArray[oLbx:nAt, 16] },,,, "LEFT" , 040, .F., .F.,,,, .F. ) )
    oLbx:bLDblClick 	:= { || DelThread(aLista, oLbx:nAt, cEnvServer, cServerIP, nPortaTcp) }
    oLbx:Refresh()

    DEFINE TIMER __oTimer INTERVAL 1000 ACTION AtuTela(oLbx, aLista, oDlg, cEnvServer, cServerIP, nPortaTcp) OF oDlg


Return
    
Static Function SrvInfoUser(cServerIP, nPortaTcp, cEnvServer)
    Local nTimeOut  := 10
    Local oServer
    Local aInfoThr  := {}
    Local bErroA
    Local cMyIP     := PegaIP()
    Local nMyPorta  := GetServerPort()

    If Alltrim(cServerIP) == Alltrim(cMyIP) .and. nPortaTcp == nMyPorta
        aInfoThr := GetUserInfoArray()
    Else 
        
        oServer := TRpc():New(cEnvServer)
        If ! oServer:Connect(Alltrim(cServerIP) , nPortaTcp , nTimeOut )
            FreeObj(oServer)
            Return {}
        EndIf
        
        aSize(aInfoThr, 0)
        __cErroP := ""
        bErroA   := ErrorBlock( { |oErro| ChkErrP( oErro ) } )
        Begin Sequence
            aInfoThr := aclone(oServer:CallProc("GetUserInfoArray"))
        End Sequence
        ErrorBlock( bErroA )
        oServer:Disconnect()
        FreeObj(oServer)

        bErroA := Nil

        If ! Empty(__cErroP)
            __cErroP := ""
            Return {}
        EndIf
    EndIf 

Return aInfoThr

Static Function ChkErrP(oErroArq)

    If oErroArq:GenCode > 0
        __cErroP := '(' + Alltrim( Str( oErroArq:GenCode ) ) + ') : ' + AllTrim( oErroArq:Description ) + CRLF
    EndIf

    Break
Return

Static Function DelThread(aLista, nAt, cEnvServer, cServerIP, nPortaTcp)
    Local cUserName     := aLista[nAt, 1]
    Local cComputerName := aLista[nAt, 2]
    Local nThreadId     := aLista[nAt, 3]
    Local oServer
    Local nTimeOut      := 10
    Local bErroA
    Local cMyIP     := PegaIP()
    Local nMyPorta  := GetServerPort()

    If ! FWAlertYesNo("Finalizar a thread [" + Alltrim(str(nThreadId)) + "]  do Usuario [" +cUserName + "]?")
        return
    EndIf

    If Alltrim(cEnvServer) == GetEnvserver() .and.  cServerIP  == PegaIP() .and.  nPortaTcp == GetServerPort() .and. nThreadId == ThreadId()
        FWAlertError("Essa é a sua thread e não pode ser finalizada!")
        Return
    EndIf

    If Alltrim(cServerIP) == Alltrim(cMyIP) .and. nPortaTcp == nMyPorta
        KillUser(cUserName, cComputerName, nThreadId,  cServerIP)
    Else 
        oServer := TRpc():New(cEnvServer)
        If ! oServer:Connect(Alltrim(cServerIP) , nPortaTcp , nTimeOut )
            Return
        EndIf
        __cErroP := ""
        bErroA   := ErrorBlock( { |oErro| ChkErrP( oErro ) } )
        Begin Sequence
            oServer:CallProc("KillUser", cUserName, cComputerName, nThreadId,  cServerIP )
        End Sequence
        ErrorBlock( bErroA )
        oServer:Disconnect()
        If ! Empty(__cErroP)
            __cErroP := ""
        EndIf
    EndIf 
Return


Static Function PegaIP()
    Local cIP := ""
    Local aIP := GetServerIP(.T.)  // aqui retorna um array com os ips da maquina
    Local nx  
    
    For nx := 1 to Len(aIP)
        If Left(aIP[nx, 4], 3) == "172"	
            cIP := aIP[nx, 4]
        EndIf
    Next
    If Empty(cIP)
        cIP := GetServerIP(.F.)  // retorna o ip da conexão
    EndIf 
    If Empty(cIP)
        cIP := "172.0.0.1"  // Localhost
    EndIf 

Return cIP

Static Function DellAll( aLista, cEnvServer, cServerIP, nPortaTcp)
    Local cUserName     := ""
    Local cComputerName := ""
    Local nThreadId     := ""
    Local oServer
    Local nTimeOut      := 10
    Local bErroA
    Local nx
    Local uRet

    If ! FWAlertNoYes("Finalizar todas a threads?")
        return
    EndIf

    uRet := SocketConn(Alltrim(cServerIP) , nPortaTcp, '12', nTimeOut)

    If ! Valtype(uRet) == "C"
        Return
    EndIf

    oServer := TRpc():New(cEnvServer)
    If ! oServer:Connect(Alltrim(cServerIP) , nPortaTcp , nTimeOut )
        Return
    EndIf

    __cErroP := ""
    bErroA   := ErrorBlock( { |oErro| ChkErrP( oErro ) } )
    Begin Sequence
        For nx := 1 to len(aLista)
            cUserName     := aLista[nx, 1]
            cComputerName := aLista[nx, 2]
            nThreadId     := aLista[nx, 3]
            If Alltrim(cEnvServer) == GetEnvserver() .and.  cServerIP  == PegaIP() .and.  nPortaTcp == GetServerPort() .and. nThreadId == ThreadId()
                Loop
            EndIf
            oServer:CallProc("KillUser", cUserName, cComputerName, nThreadId,  cServerIP )
        Next
    End Sequence
    ErrorBlock( bErroA )

    oServer:Disconnect()
    If ! Empty(__cErroP)
        __cErroP := ""
    EndIf


Return

Static Function AtuTela(oLbx, aLista, oDlg, cEnvServer, cServerIP, nPortaTcp)

    If __oTimer == NIL
        Return
    EndIf

    __oTimer:Deactivate()

    aLista := SrvInfoUser(cServerIP, nPortaTcp, Alltrim(cEnvServer))

    If Empty(aLista)
        aadd(aLista, {"", "",0 , "",	"",	"",	"",	"",	0 ,	0 ,	"",	"" , 0 , "" , 0, "" , ""})
    EndIf

    oLbx:SetArray( aLista )
    oLbx:Refresh()

    __oTimer:Activate()

Return

/*
#################################################################################################################################
Aba serviços
#################################################################################################################################
*/


Static Function FolderServ(oFolder)
    Local oPS
    Local oPnlSrv
    Local oLbx
    Local aLista := {{"","",""}}
    Local oFontB := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)    

    oPS := TPanelCss():New(,,,oFolder)
    oPS :SetCoors(TRect():New( 0,0, 30, 30))
    oPS :Align := CONTROL_ALIGN_TOP

    oBut  := THButton():New(002, 002, 'Atualizar' , oPS, {|| Processa({|| LeServico(oLbx)  }, "Carregando servicos", "Aguarde....", .T.)   }, 45, 10, oFontB, "Atualiza a listas de serviços") 

    
    oPnlSrv := TPanelCss():New(,,,oFolder)
    oPnlSrv :SetCoors(TRect():New( 0,0, 400, 400))
    oPnlSrv :Align :=CONTROL_ALIGN_ALLCLIENT

    oLbx := MsBrGetDBase():New(1, 1, __DlgWidth(oPnlSrv)-1, __DlgHeight(oPnlSrv) - 1,,,, oPnlSrv ,,,,,,,,,,,, .F., "", .T.,, .F.,,,)
    oLbx:align := CONTROL_ALIGN_ALLCLIENT
    oLbx:SetArray( aLista )
    
    oLbx:addColumn( TCColumn():new("Nome"        , { || oLbx:aArray[oLbx:nAt,  1] },,,, "LEFT" , 100, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Status"      , { || oLbx:aArray[oLbx:nAt,  2] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
    oLbx:addColumn( TCColumn():new("Descrição"   , { || oLbx:aArray[oLbx:nAt,  3] },,,, "LEFT" , 500, .F., .F.,,,, .F. ) )
     
    
    oLbx:bLDblClick := { || MudaServ(oLbx, oLbx:nAt)}
    oLbx:Refresh()
Return

Static Function LeServico(oLbx)

    Local aLista := {}
    Local cRoot  := GetSrvProfString("RootPath", "\undefined")
    Local cStart := GetSrvProfString("StartPath", "\undefined")
    Local cArq   := "srvtmp.tdi"
    Local cexec  := 'cmd /c powershell "Get-service | Select Name, Status, Displayname | Export-csv ' + cRoot + cStart + cArq +'"'
    Local nx     := 0
    Local aServ  := {}
    Local aCol   := {}

    waitrunsrv('cmd /c' + cexec, .T., 'c:\')

    cConteudo := MemoRead(cArq)
    FErase(cArq)

    cConteudo := StrTran(cConteudo, '"', "")
    aServ := Separa(cConteudo, CRLF, .T.)

    aLista := {}
    For nx := 3 to len(aServ)
        aCol := Aclone(Separa(aServ[nx], "," ,.T.))
        If Empty(aCol)
            exit
        EndIf
        If Alltrim(aCol[2]) == "Running"
            aCol[2] := "Em Execução"
        Else
            aCol[2] := ""
        End
        aadd(aLista, aCol)
    Next

    If Empty(aLista)
        aLista := {{"","",""}}
    EndIf

    oLbx:SetArray( aLista )
    oLbx:Refresh()

Return

Static Function MudaServ(oLbx, nAt)
    Local aLinha := oLbx:aArray[nAt]
    Local cStatus := aLinha[2]
    Local cCodigo := Alltrim(aLinha[1])

    If Empty(cStatus)
        If FWAlertYesNo("Deseja ativar o serviço [" + cCodigo  + "]?")

            Processa({|| StartServ(cCodigo), LeServico(oLbx)  }, "Ativando o serviço [" + cCodigo  + "]"  , "Aguarde....", .T.)

        EndIf
    Else
        If FWAlertYesNo("Confirma a parada do serviço [" + cCodigo  + "]?")

            Processa({|| StopServ(cCodigo), LeServico(oLbx)  }, "Parando o serviço [" + cCodigo  + "]"  , "Aguarde....", .T.)

        EndIf
    EndIf

Return

Static Function StartServ(cNome)
    Local cexec := "powershell start-service -name " + Alltrim(cNome)

    waitrunsrv('cmd /c' + cexec, .T., 'c:\')
Return

Static Function StopServ(cNome)
    Local cexec := "powershell stop-service -name " + Alltrim(cNome) + " -force"
    waitrunsrv('cmd /c' + cexec, .T., 'c:\')
Return

/*
#################################################################################################################################
Aba erro
#################################################################################################################################
*/

Static Function FolderErro(oFolder)
    Local oPS
    Local oPanelM2

    Local oPLista
    Local oFDet

    Local aFolder   := {'Pilhas', 'Variaveis Publicas', 'Tabelas'}
    Local aLstErro  := {{"","","","","","","","","", "", "", "", "", "", "", ""}}
    Local aPilha    := {{"","","","","",""}}
    Local aPilhaVar := {{"","","",""}}
    Local aVar      := {{"","","",""}}

    Local aDB       := {{"","","","","","",""}}
    Local aIdx      := {{"",""}}
    Local aCmp      := {{"","","",""}}

    Local oLbxLista
    Local oLbxPilha
    Local oLbxPiVar

    Local oLbxVar
    Local oLbxDB

    Local oLbxIdx
    Local oLbxCmp


    Local oFont
    Local oMemoErro
    Local cMemoErro := ""
    Local oLstErro
    Local nR := __nWidth
    Local nB := __nHeight
    Local oFontB := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)    


    oPS := TPanelCss():New(,,,oFolder)
    oPS :SetCoors(TRect():New( 0,0, 30, 30))
    oPS :Align := CONTROL_ALIGN_TOP

    //THButton():New(002, 002, 'Ultimo'  , oPS, {|| oLstErro := LeErro(aLstErro, oLbxLista, @cMemoErro, .T., .F.), Eval(oLbxLista:bChange)  }, 45, 10, oFontB, "Carrega o ultimo erro do erro.log") 
    THButton():New(002, 002, 'Ultimo'  , oPS, {|| Processa({|| oLstErro := LeErro(aLstErro, oLbxLista, @cMemoErro, .T., .F.), Eval(oLbxLista:bChange) }, "Carregando error.log", "Aguarde....", .T.)   }, 45, 10, oFontB, "Carrega o ultimo erro do erro.log") 
    THButton():New(002, 052, 'Todos'   , oPS, {|| Processa({|| oLstErro := LeErro(aLstErro, oLbxLista, @cMemoErro, .F., .F.), Eval(oLbxLista:bChange) }, "Carregando error.log", "Aguarde....", .T.)  }, 45, 10, oFontB, "Carrega os erros do error.log") 
    THButton():New(002, 102, 'Arquivo' , oPS, {|| Processa({|| oLstErro := LeErro(aLstErro, oLbxLista, @cMemoErro, .F., .T.), Eval(oLbxLista:bChange) }, "Carregando error.log", "Aguarde....", .T.)  }, 45, 10, oFontB, "Carrega os erros um arquivo informado") 
    THButton():New(002, 152, 'Memo'    , oPS, {|| oLstErro := TelaErro(aLstErro, oLbxLista),  Eval(oLbxLista:bChange)  }, 45, 10, oFontB, "Colar erro e processar...") 
    
    oPnlArea := TPanelCss():New(,,,oFolder)
    oPnlArea :SetCoors(TRect():New( 0,0, 400 , 400))
    oPnlArea :Align :=CONTROL_ALIGN_ALLCLIENT


    oPLista:= TPanelCss():New(,,,oPnlArea)
    oPLista:SetCoors(TRect():New( 0,0, nB * 0.20, nR))
    oPLista:Align :=CONTROL_ALIGN_TOP

        oLbxLista := MsBrGetDBase():New(00, 00, nR * 0.25, nB,,,, oPLista ,,,,,,,,,,,, .F., "", .T.,, .F.,,,)
            oLbxLista:SetArray( aLstErro )
            
            oLbxLista:addColumn( TCColumn():new("usuario"       , { || oLbxLista:aArray[oLbxLista:nAt,  1] },,,, "LEFT" , 100, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("maquina"       , { || oLbxLista:aArray[oLbxLista:nAt,  2] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("data"          , { || oLbxLista:aArray[oLbxLista:nAt,  3] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("hora"          , { || oLbxLista:aArray[oLbxLista:nAt,  4] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("build"         , { || oLbxLista:aArray[oLbxLista:nAt,  5] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("environment"   , { || oLbxLista:aArray[oLbxLista:nAt,  6] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("thread"        , { || oLbxLista:aArray[oLbxLista:nAt,  7] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("dbthread"      , { || oLbxLista:aArray[oLbxLista:nAt,  8] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("dbversion"     , { || oLbxLista:aArray[oLbxLista:nAt,  9] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("dbapibuild"    , { || oLbxLista:aArray[oLbxLista:nAt, 10] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("dbarch"        , { || oLbxLista:aArray[oLbxLista:nAt, 11] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("dbso"          , { || oLbxLista:aArray[oLbxLista:nAt, 12] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("rpodb"         , { || oLbxLista:aArray[oLbxLista:nAt, 13] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("localfiles"    , { || oLbxLista:aArray[oLbxLista:nAt, 14] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("remark"        , { || oLbxLista:aArray[oLbxLista:nAt, 15] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxLista:addColumn( TCColumn():new("threadtype"    , { || oLbxLista:aArray[oLbxLista:nAt, 16] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )

            oLbxLista:align := CONTROL_ALIGN_LEFT
            oLbxLista:bChange := {|| AtuErro(oLstErro, oLbxLista:nAt, @cMemoErro, oMemoErro, oLbxPilha, oLbxVar, oLbxDB) }
            oLbxLista:Refresh()


        DEFINE FONT oFont NAME "Consolas" SIZE 8, 15
        oMemoErro := tMultiget():new(,,bSETGET(cMemoErro), oPLista)
        oMemoErro:Align := CONTROL_ALIGN_ALLCLIENT
        oMemoErro:oFont:=oFont

    oPanelM2 := TPanelCss():New(,,,oPnlArea)
    oPanelM2 :SetCoors(TRect():New( 0,0, 10, 10))
    oPanelM2 :Align := CONTROL_ALIGN_TOP

    oFDet := TFolder():New(, , aFolder, aFolder, oPnlArea, , , , .T., .F.)
    oFDet:bSetOption:= {|n| Eval(__bTelErro), .T.}
    oFDet:Align := CONTROL_ALIGN_ALLCLIENT
        oLbxPilha := MsBrGetDBase():New(00, 00, nR, nB * 0.125,,,, oFDet:aDialogs[1] ,,,,,,,,,,,, .F., "", .T.,, .F.,,,)
            oLbxPilha:SetArray( aPilha )
            oLbxPilha:addColumn( TCColumn():new("Rotina"       , { || oLbxPilha:aArray[oLbxPilha:nAt,  1] },,,, "LEFT" , 200, .F., .F.,,,, .F. ) )
            oLbxPilha:addColumn( TCColumn():new("Fonte"        , { || oLbxPilha:aArray[oLbxPilha:nAt,  2] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxPilha:addColumn( TCColumn():new("Data"         , { || oLbxPilha:aArray[oLbxPilha:nAt,  3] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxPilha:addColumn( TCColumn():new("Hora"         , { || oLbxPilha:aArray[oLbxPilha:nAt,  4] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxPilha:align := CONTROL_ALIGN_TOP
            oLbxPilha:bChange := {|| AtuPiVar(oLstErro, oLbxLista:nAt, oLbxPilha:nAt, oLbxPiVar) }
            oLbxPilha:Refresh()

        oLbxPiVar := MsBrGetDBase():New(00, 00, nR, nB * 0.25,,,, oFDet:aDialogs[1] ,,,,,,,,,,,, .F., "", .T.,, .F.,,,)
            oLbxPiVar:SetArray( aPilhaVar )
            oLbxPiVar:addColumn( TCColumn():new("Identificação"  , { || oLbxPiVar:aArray[oLbxPiVar:nAt,  1] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxPiVar:addColumn( TCColumn():new("Variavel"       , { || oLbxPiVar:aArray[oLbxPiVar:nAt,  2] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxPiVar:addColumn( TCColumn():new("Tipo"           , { || oLbxPiVar:aArray[oLbxPiVar:nAt,  3] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxPiVar:addColumn( TCColumn():new("Conteudo"       , { || oLbxPiVar:aArray[oLbxPiVar:nAt,  4] },,,, "LEFT" , 400, .F., .F.,,,, .F. ) )
            oLbxPiVar:align := CONTROL_ALIGN_ALLCLIENT
            oLbxPiVar:Refresh()

    
    oLbxVar := MsBrGetDBase():New(00, 00, nR, nB * 0.25,,,, oFDet:aDialogs[2] ,,,,,,,,,,,, .F., "", .T.,, .F.,,,)
            oLbxVar:SetArray( aVar )
            oLbxVar:addColumn( TCColumn():new("Identificação"  , { || oLbxVar:aArray[oLbxVar:nAt,  1] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxVar:addColumn( TCColumn():new("Variavel"       , { || oLbxVar:aArray[oLbxVar:nAt,  2] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxVar:addColumn( TCColumn():new("Tipo"           , { || oLbxVar:aArray[oLbxVar:nAt,  3] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
            oLbxVar:addColumn( TCColumn():new("Conteudo"       , { || oLbxVar:aArray[oLbxVar:nAt,  4] },,,, "LEFT" , 400, .F., .F.,,,, .F. ) )
            oLbxVar:align := CONTROL_ALIGN_ALLCLIENT
            oLbxVar:Refresh()
    

    oLbxDB := MsBrGetDBase():New(00, 00, nR, nB * 0.125,,,, oFDet:aDialogs[3] ,,,,,,,,,,,, .F., "", .T.,, .F.,,,)
        oLbxDB:SetArray( aDb )
        oLbxDB:addColumn( TCColumn():new("Arquivo"      , { || oLbxDB:aArray[oLbxDB:nAt,  1] },,,, "LEFT" , 100, .F., .F.,,,, .F. ) )
        oLbxDB:addColumn( TCColumn():new("Rdd"          , { || oLbxDB:aArray[oLbxDB:nAt,  2] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
        oLbxDB:addColumn( TCColumn():new("Alias"        , { || oLbxDB:aArray[oLbxDB:nAt,  3] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
        oLbxDB:addColumn( TCColumn():new("Filtro"       , { || oLbxDB:aArray[oLbxDB:nAt,  4] },,,, "LEFT" , 200, .F., .F.,,,, .F. ) )
        oLbxDB:addColumn( TCColumn():new("Recno"        , { || oLbxDB:aArray[oLbxDB:nAt,  5] },,,, "RIGHT", 060, .F., .F.,,,, .F. ) )
        oLbxDB:addColumn( TCColumn():new("TotRec"       , { || oLbxDB:aArray[oLbxDB:nAt,  6] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
        oLbxDB:addColumn( TCColumn():new("Order"        , { || oLbxDB:aArray[oLbxDB:nAt,  7] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
        oLbxDB:align := CONTROL_ALIGN_TOP
        oLbxDB:bChange := {|| AtuTab(oLstErro, oLbxLista:nAt, oLbxDB:nAt, oLbxIdx, oLbxCmp) }
        oLbxDB:Refresh()


    oLbxIdx := MsBrGetDBase():New(00, 00, nR, nB * 0.125,,,, oFDet:aDialogs[3] ,,,,,,,,,,,, .F., "", .T.,, .F.,,,)
        oLbxIdx:SetArray( aIdx )
        oLbxIdx:addColumn( TCColumn():new("Indice"      , { || oLbxIdx:aArray[oLbxIdx:nAt,  1] },,,, "LEFT" , 100, .F., .F.,,,, .F. ) )
        oLbxIdx:addColumn( TCColumn():new("Chave"       , { || oLbxIdx:aArray[oLbxIdx:nAt,  2] },,,, "LEFT" , 600, .F., .F.,,,, .F. ) )
        oLbxIdx:align := CONTROL_ALIGN_TOP    
        oLbxIdx:Refresh()

    oLbxCmp := MsBrGetDBase():New(00, 00, nR, nB * 0.125,,,, oFDet:aDialogs[3] ,,,,,,,,,,,, .F., "", .T.,, .F.,,,)
        oLbxCmp:SetArray( aCmp )    
        oLbxCmp:addColumn( TCColumn():new("Identificação"  , { || oLbxCmp:aArray[oLbxCmp:nAt,  1] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
        oLbxCmp:addColumn( TCColumn():new("Variavel"       , { || oLbxCmp:aArray[oLbxCmp:nAt,  2] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
        oLbxCmp:addColumn( TCColumn():new("Tipo"           , { || oLbxCmp:aArray[oLbxCmp:nAt,  3] },,,, "LEFT" , 060, .F., .F.,,,, .F. ) )
        oLbxCmp:addColumn( TCColumn():new("Conteudo"       , { || oLbxCmp:aArray[oLbxCmp:nAt,  4] },,,, "LEFT" , 400, .F., .F.,,,, .F. ) )
        oLbxCmp:align := CONTROL_ALIGN_ALLCLIENT
        oLbxCmp:Refresh()

    __bTelErro:= {|| AtuFolErro(oLbxLista, oPLista, oFDet, oLbxPilha, oLbxDB, oLbxIdx) }

Return

Static Function AtuFolErro(oLbxLista, oPLista, oFDet, oLbxPilha, oLbxDB, oLbxIdx)
    oMainWnd:ReadClientCoors()

    __nHeight := oMainWnd:nHeight - 100
    __nWidth  := oMainWnd:nWidth - 20

    oLbxLista:SetCoors(TRect():New( 0,0, __nHeight , __nWidth * 0.5))
    oPLista:SetCoors(TRect():New( 0,0, __nHeight * 0.20, __nWidth))
    
    
    oLbxPilha:SetCoors(TRect():New( 0,0, __nHeight * 0.25, __nWidth))
    
    oLbxDB:SetCoors(TRect():New( 0,0, __nHeight * 0.20, __nWidth))
    oLbxIdx:SetCoors(TRect():New( 0,0, __nHeight * 0.20, __nWidth))
    
Return

Static function TelaErro(aLstErro, oLbxLista)
    Local cErro := ""
    Local oLstErro 
    Private lAbortPrint := .F.

    If Aviso("Colar o erro ", @cErro ,{"Ok","Cancelar"},3,"Conteudo do error.log" ,,,.T.) != 1
        Return oLstErro
    EndIf 

    Processa({|| oLstErro := ProcErro(cErro) }, "Carregando erro", "Aguarde....", .T.) 

    aLstErro := aClone(oLstErro:aLstErro)
    oLbxLista:SetArray( aLstErro )
    oLbxLista:nAt := 1
    oLbxLista:Refresh()

Return oLstErro

Static Function ProcErro(cErro)
    Local cArqErro := ""
    Local cConteudo:= ""
    Local oLstErro

    cArqErro := GetTempPath() + "errortmp.log"

    cConteudo := "*********************" + CRLF + cErro
    MemoWrit(cArqErro, cConteudo)

    oLstErro := TILstErro():New(cArqErro)
    oLstErro:Load()

    If lAbortPrint
        FWAlertWarning("Error incompleto, leitura do arquivo interrompida!")
    EndIf 

Return  oLstErro


Static Function LeErro(aLstErro, oLbxLista, cMemoErro, lUltimo, lGetFile)
    Local cArqErro := "error.log"
    Local oLstErro
    Private lAbortPrint := .F.

    If lGetFile
        cArqErro := MyGetFile( "Arquivos de erro (*.log) |*.log|" , "Selecione o arquivo", 1, "C:\", .T., GETF_LOCALHARD + GETF_LOCALFLOPPY + GETF_NETWORKDRIVE )
    EndIf

    If Empty(cArqErro)
        Return
    EndIf

    If Valtype(oLstErro) == "O"
        FreeObj(oLstErro)
    EndIf

    oLstErro := TILstErro():New(cArqErro)
    If lUltimo
        oLstErro:Last()
    Else
        oLstErro:Load()
    EndIf

    If lAbortPrint
        FWAlertWarning("Error incompleto, leitura do arquivo interrompida!")
    EndIf 

    aLstErro := aClone(oLstErro:aLstErro)
    oLbxLista:SetArray( aLstErro )
    oLbxLista:nAt := 1
    oLbxLista:Refresh()

    //cMemoErro := oLstErro:aMsgErro[1]

Return oLstErro


Static Function AtuErro(oLstErro, nAt, cMemoErro, oMemoErro, oLbxPilha, oLbxVar, oLbxDB)
    Local aPilha    := {}
    Local aVar      := {}
    Local aDb       := {}


    If Empty(nAt)
        Return
    EndIf
    If oLstErro == NIL
        Return
    EndIf

    cMemoErro := oLstErro:aMsgErro[nAt]
    oMemoErro:Refresh()

    aPilha := aClone(oLstErro:aObjErro[nAt]:aPilha)
    oLbxPilha:SetArray( aPilha )
    oLbxPilha:Refresh()
    Eval(oLbxPilha:bChange)

    aVar   := aClone(oLstErro:aObjErro[nAt]:oErroVar:aLstVar)
    If Empty(aVar)
        aVar      := {{"","","",""}}
    EndIf
    aVar := aSort(aVar,,,{|x,y| x[1] + x[2] < y[1]+ y[2]})
    oLbxVar:SetArray( aVar )
    oLbxVar:Refresh()

    aDB   := aClone(oLstErro:aObjErro[nAt]:aDb)
    If Empty(aDB)
        aDB       := {{"","","","","","",""}}
    EndIf
    oLbxDB:SetArray( aDB )
    oLbxDB:bLine   := {|| Retbline(oLbxDB, aDB ) }
    oLbxDB:Refresh()
    Eval(oLbxDB:bChange)


Return

Static Function AtuPiVar(oLstErro, nAtLista, nAtPilha, oLbxPiVar)
    Local aPilhaVar := {}

    If Empty(nAtLista)
        Return
    EndIf
    If Empty(nAtPilha)
        Return
    EndIf

    If oLstErro == NIL
        Return
    EndIf
    If Empty(oLstErro:aObjErro[nAtLista]:aPilha)
        aPilhaVar :=  {{"","","",""}}
    ElseIf oLstErro:aObjErro[nAtLista]:aPilha[nAtPilha, 7] == NIL
        aPilhaVar :=  {{"","","",""}}
    Else
        aPilhaVar := aClone(oLstErro:aObjErro[nAtLista]:aPilha[nAtPilha, 7]:aLstVar)
        aPilhaVar := aSort(aPilhaVar,,, {|x,y| x[1] + x[2] < y[1]+ y[2]})
    EndIf
    oLbxPiVar:SetArray( aPilhaVar )
    oLbxPiVar:bLine   := {|| Retbline(oLbxPiVar, aPilhaVar ) }
    oLbxPiVar:Refresh()

Return

Static Function AtuTab(oLstErro, nAtLista, nAtDB, oLbxIdx, oLbxCmp)
    Local aIdx := {}
    Local aCmp := {}

    If Empty(nAtLista)
        Return
    EndIf
    If Empty(nAtDB)
        Return
    EndIf

    If oLstErro == NIL
        Return
    EndIf
    If Empty(oLstErro:aObjErro[nAtLista]:aDB)
        aIdx := {{"",""}}
        aCmp := {{"","","",""}}
    ElseIf oLstErro:aObjErro[nAtLista]:aDB[nAtDB, 8] == NIL
        aIdx := {{"",""}}
        aCmp := {{"","","",""}}
    Else
        aIdx := aClone(oLstErro:aObjErro[nAtLista]:aDB[nAtDB, 8]:aIndice)
        If Empty(aIdx)
            aIdx := {{"",""}}
        EndIf
        aCmp := aClone(oLstErro:aObjErro[nAtLista]:aDB[nAtDB, 8]:aLstCampos)
        If Empty(aCmp)
            aCmp := {{"","","",""}}
        EndIf
    EndIf

    oLbxIdx:SetArray( aIdx )
    oLbxIdx:bLine   := {|| Retbline(oLbxIdx, aIdx ) }
    oLbxIdx:Refresh()

    oLbxCmp:SetArray( aCmp )
    oLbxCmp:bLine   := {|| Retbline(oLbxCmp, aCmp ) }
    oLbxCmp:Refresh()

Return

/*
#####################################
Lista de Erro
#####################################
*/

    Static __nL := 0
    Static __oFile

    Class TILstErro
        Data aObjErro
        Data cArqErro
        Data aCabErro
        Data aLstErro
        Data aMsgErro
        Data nAt
        



        Method New(cArqErro)
        Method Load()
        Method Last()
        Method ParseLine()
        Method Cabec()
        Method AdInfo(cLinha)

    EndClass

Method New(cArqErro) Class TILstErro
    ::aObjErro := {}
    ::aCabErro := {"Usuario","Maquina","Data","Hora","build","environment","thread","dbthread","dbversion", "dbapibuild", "dbarch", "dbso", "rpodb", "localfiles", "remark", "threadtype"}
    ::aLstErro := {}
    ::aMsgErro := {}
    ::nAt      := 0
    ::cArqErro := If(cArqErro==Nil, "error.log", cArqErro)

Return

Method Last() Class TILstErro
    Local nH := 0
    Local nTBytes := 0
    Local cBuffer := ""
    Local cConteudo := ""
    Local np := 0
    Local nBloco := 4000

    ::aObjErro := {}
    __nL := 0

    If ! File(::cArqErro)
        Return
    EndIf
    nh := FOpen(::cArqErro)
    While .t.
        nTBytes := fseek(nh,0,2)
        If nBloco > nTBytes
            nBloco := nTBytes
        EndIf

        fseek(nh, nBloco * -1, 1)
        cBuffer := ""
        FRead(nh, @cBuffer, nBloco)
        np := Rat("THREAD ERROR", cBuffer)
        If ! Empty(np)
            Exit
        Else
            If nBloco > nTBytes  // não achou o Thread Error e não tem mais nada para ler
                Return
            EndIf
            nBloco += 4000
        EndIf
    End
    Fclose(nh)


    cConteudo := Subs(cBuffer, np)
    ::cArqErro := GetTempPath() +"errortmp.log"
    cConteudo := "*****" + CRLF + cConteudo
    MemoWrit(GetTempPath() + "errortmp.log", cConteudo)

    ::self:Load()

Return

Method Load() Class TILstErro

    ::aObjErro := {}
    __nL := 0

    If ! File(::cArqErro)
        Return
    EndIf

    __oFile := TIFileReader():New(::cArqErro)
    If ! __oFile:Open()
        Return 
    EndIf 
    ProcRegua(1)

    While ! __oFile:Eof()  
        cLinha:= __oFile:GetLine() 
        IncProc("Linha: "+Alltrim(Str(__nL++)))
        ProcessMessage()
        
        
        If Valtype(lAbortPrint) == "l" .and. lAbortPrint
            Exit
        EndiF 

        If Empty(cLinha)
            Loop
        EndIf

        Self:ParseLine(cLinha)
        
    End
    __oFile:Close()  
    FreeObj(__oFile)
    __oFile:= NIL 
Return

Method ParseLine(cLinha) Class TILstErro
    Local oErro

    cLinha := Alltrim(cLinha)

    Self:Cabec()
    oErro := TIErro():New()
    oErro:LoadStack()
    oErro:oErroVar := TIErroVar():New()
    oErro:oErroVar:Load()
    oErro:LoadDetStack()
    oErro:LoadDB()

    aadd(::aObjErro, oErro)
    ::nAt++

Return

Method Cabec() Class TILstErro
    Local cLinha   := ""
    Local lMsg     := .t.
    Local aLista   := {}
    Local cMsg     := ""
    Local aInfo    := {}
    Local cAux     := ""
    Local aAux     := {}
    Local cUsuario := ""
    Local cMaquina := ""
    Local nx       := 0
    Local np := 0
    Local cCabColuna := ""

    
    While ! __oFile:Eof()   
        cLinha:= __oFile:GetLine()  
        IncProc("Linha: "+Alltrim(Str(__nL++)))
        ProcessMessage()

        If Left(cLinha, 1) != "[" .and. lMsg
            If Left(cLinha, 12) == "THREAD ERROR"
                caux     := Subs(cLinha, 13)
                cAux     := StrTran(cAux, " ", "")

                cHora    := Right(cAux, 8)
                cAux     := Left(cAux, len(cAux) - 8)
                cData    := Right(cAux, 10)
                cAux     := Left(cAux, len(cAux) - 10)
                cAux     := StrTran(cAux, "(", "")
                cAux     := StrTran(cAux, ")", ",")
                aAux     := Separa(cAux, ",",.T.)
                cUsuario := aAux[2]
                cMaquina := aAux[3]
                aadd(aInfo ,{"Usuario", cUsuario})
                aadd(aInfo ,{"Maquina", cMaquina})
                aadd(aInfo ,{"Data"   , cData})
                aadd(aInfo ,{"Hora"   , cHora})
            Else
                cMsg+= cLinha + CRLF
            EndIf
        ElseIf Left(cLinha, 11) == "Called from" .or. Left(cLinha, 04) == " on " .or. cLinha == '*************************************************************************'
            Exit
        Else
            lMsg := .F.
            ::AdInfo(cLinha, aInfo)
        EndIf
        
    End

    For nx:= 1 to len(::aCabErro)
        cCabColuna := ::aCabErro[nx]
        nP := aScan(aInfo, { |x| x[1] == cCabColuna  })
        If nP > 0
            aadd(aLista, aInfo[np, 2])
        Else
            aadd(aLista, "")
        EndIf
    Next

    aadd(::aLstErro, aClone(aLista) )
    aadd(::aMsgErro, cMsg)

Return

Method AdInfo(cLinha, aInfo) Class TILstErro
    Local cCampo := ""
    Local cConteudo := ""
    Local np1 := 0
    Local np2

    np1 := At(":", cLinha)
    If Empty(np1)
        Return
    EndIf
    cCampo := Subs(cLinha, 2, np1 -2)

    np2 := At("]", cLinha)
    If Empty(np2)
        Return
    EndIf
    cConteudo := Alltrim(Subs(cLinha, np1 + 1, np2 - np1 -1))

    aadd(aInfo ,{cCampo, cConteudo})

Return


/*
#####################################
Erro 
#####################################
*/


    Class TIErro
        Data aPilha
        Data aDB
        Data oErroVar

        Method New()
        Method LoadStack()
        Method ParseCall()
        Method LoadDetStack()
        Method LoadDB()


    EndClass

Method New() Class TIErro

    ::aPilha   := {}
    ::aDB      := {}

Return

Method LoadStack() Class TIErro
    Local cLinha := ""
    Local aPilha := {}
    Local cRotina := ""
    Local cFonte  := ""
    Local cData   := ""
    Local cHora   := ""
    Local cNumLin := ""



    While ! __oFile:Eof()  

        cRotina := ""
        cFonte  := ""
        cData   := ""
        cHora   := ""
        cNumLin := ""

        cLinha  := __oFile:GetLine()   
        

        IncProc("Linha: "+Alltrim(Str(__nL++)))
        ProcessMessage()

        If  Left(cLinha, 16) == "Variables in use"  .or.;
                Left(cLinha, 08) == "Publicas" .or. ;
                cLinha == '*************************************************************************'
            Exit
        EndIf

        If Left(cLinha, 11) == "Called from"
            cLinha := Subs(cLinha, 13)

            Self:ParseCall(cLinha, @cRotina, @cFonte, @cData, @cHora, @cNumLin)

            aadd(aPilha, {cRotina, cFonte, cData, cHora, cNumLin, "Called from " + cLinha, NiL})
        EndIf

        
    End
    ::aPilha := aclone(aPilha)
Return

Method ParseCall(cLinha, cRotina, cFonte, cData, cHora, cNumLin) Class TIErro
    Local np := 0

    cNumLin := ""
    If "line :" $ cLinha
        np := Rat(":", cLinha)
        cNumLin := AllTrim(Subs(cLinha, np + 1))
        cLinha := Left(cLinha, np - 7)
    EndIf

    If Subs(cLinha, len(cLinha) - 2, 1) == ":" .and. Subs(cLinha, len(cLinha) - 5, 1) == ":"
        cHora  := Subs(cLinha, len(cLinha) - 7)
        cLinha := Left(cLinha, len(cLinha) - 9)
        cData  := Subs(cLinha, len(cLinha) - 9)
        cLinha := Left(cLinha, len(cLinha) - 11)
    EndIf

    np := Rat("(", cLinha)
    If np > 0
        cFonte := Subs(cLinha, np + 1)
        cFonte := Left(cFonte, len(cFonte) - 1)
        cLinha := Left(cLinha, np -1)
    EndIf

    cRotina := cLinha
Return


Method LoadDetStack() Class TIErro
    Local cLinha   := ""
    Local np       := 0
    Local oErroVar
    Local cRotina  := ""
    Local cFonte   := ""
    Local cData    := ""
    Local cHora    := ""
    Local cNumLin  := ""

    While ! __oFile:Eof() 
        cRotina := ""
        cFonte  := ""
        cData   := ""
        cHora   := ""
        cNumLin := ""

        cLinha  := __oFile:GetLine()  

        IncProc("Linha: "+Alltrim(Str(__nL++)))
        ProcessMessage()

        If  Left(cLinha, 05) == "Files" .or. ;
                cLinha == '*************************************************************************'
            Exit
        EndIf

        If Left(cLinha, 05) == "STACK"

            cLinha := Subs(cLinha, 7)

            Self:ParseCall(cLinha, @cRotina, @cFonte, @cData, @cHora, @cNumLin)

            np := Ascan(::aPilha, {|x| Alltrim(x[1]) == Alltrim(cRotina)} )
            If np == 0
                aadd(::aPilha, {cRotina, cFonte, cData, cHora, cNumLin, cLinha + " [fora da pilha]", NiL})
                np := len(::aPilha)
            EndIf

            

            oErroVar := TIErroVar():New()
            oErroVar:Load()

            ::aPilha[np, 7] := oErroVar
        EndIf

    End

Return

Method LoadDB() Class TIErro
    Local cLinha := ""

    Local cArquivo:= ""
    Local cRdd    := ""
    Local cAlias  := ""
    Local cFiltro := ""
    Local cRecno  := ""
    Local cTotRec := ""
    Local cOrder  := ""
    Local aAux    :={}
    Local oErroDB


    While ! __oFile:Eof()  

        cArquivo:= ""
        cRdd    := ""
        cAlias  := ""
        cFiltro := ""
        cRecno  := ""
        cTotRec := ""
        cOrder  := ""

        cLinha  := __oFile:GetLine()  

        IncProc("Linha: "+Alltrim(Str(__nL++)))
        ProcessMessage()

        If  cLinha == '*************************************************************************'
            Exit
        EndIf

        If "Rdd:" $ cLinha .and. "Alias:"$ cLinha

            cLinha := Alltrim(cLinha)
            aAuX     := Separa(cLinha, ";", .T.)
            cArquivo := aAux[1]
            cRdd     := Separa(aAux[2], ":", .T.)[2]
            cAlias   := Separa(aAux[3], ":", .T.)[2]
            cFiltro  := Separa(aAux[4], ":", .T.)[2]
            cRecno   := Separa(aAux[5], ":", .T.)[2]
            cTotRec  := Separa(aAux[6], ":", .T.)[2]
            cOrder   := Separa(aAux[7], ":", .T.)[2]
            aadd(::aDB, {cArquivo, cRdd, cAlias, cFiltro, cRecno, cTotRec, cOrder, NiL})

            oErroDB := TIErroDB():New()
            oErroDB:Load()

            ::aDB[len(::aDB), 8] := oErroDB
        EndIf
    End

Return


/*
#####################################
Lista de variaveis
#####################################
*/


    Class TIErroVar
        Data aLstVar

        Method New()
        Method Load()


    EndClass

Method New() Class TIErroVar
    ::aLstVar  := {}

Return

Method Load() Class TIErroVar
    Local cLinha    := ""
    Local aLstVar   := {}
    Local cIdentifi := ""
    Local cNome     := ""
    Local cTipo     := ""
    Local aTipo     := {"Caracter","Numerico","Data","Logico","Objeto","Bloco","Array","Indefinido"}
    Local cTipoRef  := "CNDLOBAU"
    Local cDesTipo  := ""
    Local cConteudo := ""
    Local aAux      := {}
    Local np        := 0
    Local nx        := 0


    While ! __oFile:Eof() 
        cLinha := __oFile:GetLine()  

        IncProc("Linha: "+Alltrim(Str(__nL++)))
        ProcessMessage()

        If Empty(cLinha)
            Loop
        EndIf

        cLinha := Alltrim(cLinha)

        If Left(cLinha, 5) == "STACK" .or. Left(cLinha, 5) == "Files"  .or. cLinha == '*************************************************************************'
            Exit
        EndIf
        If cLinha == "Publicas"
            Loop
        EndIf


        If ! "PUBLIC"  $ Upper(cLinha) .and. ;
                ! "PARAM"   $ Upper(cLinha) .and. ;
                ! "PRIVATE" $ Upper(cLinha) .and. ;
                ! "LOCAL"   $ Upper(cLinha) .and. ;
                ! "STATIC"  $ Upper(cLinha)
            Loop
        EndIf
        cLinha +=":"
        aAux   := aClone(Separa(cLinha,":", .T.))


        cIdentifi := Left(aAux[1], At(" ", aAux[1]) -1)
        aAux[2]   := Alltrim(aAux[2])
        aAux[2]   := StrTran(aAux[2], "(", "")
        aAux[2]   := StrTran(aAux[2], ")", "")
        cNome     := Lower(Left(aAux[2], len(aAux[2]) -1))
        cTipo     := Right(aAux[2], 1)
        nP        := At(cTipo, cTipoRef)
        If Empty(nP)
            cDesTipo := "Indefinido"
        Else
            cDesTipo  := aTipo[nP]
        EndIf
        cConteudo := ""
        For nx:= 3 to len(aAux)
            cConteudo += aAux[nx]
        Next

        aadd(aLstVar, {cIdentifi, cNome, cDesTipo, cConteudo})

    End
    ::aLstVar := aclone(aLstVar)
Return


/*
#####################################
Lista de tabelas
#####################################
*/


    Class TIErroDB
        Data aIndice
        Data aLstCampos

        Method New()
        Method Load()


    EndClass

Method New() Class TIErroDB
    ::aIndice    := {}
    ::aLstCampos := {}
Return

Method Load() Class TIErroDB
    Local cLinha    := ""
    Local aLstCampos:= {}
    Local aIndice   := {}
    Local cIdentifi := ""
    Local cNome     := ""
    Local cTipo     := ""
    Local aTipo     := {"Caracter","Numerico","Data","Logico","Objeto","Bloco","Array","Indefinido"}
    Local cTipoRef  := "CNDLOBAU"
    Local cDesTipo  := ""
    Local cConteudo := ""
    Local aAux      := {}
    Local np        := 0


    While ! __oFile:Eof()  
        cLinha := __oFile:GetLine()  

        IncProc("Linha: "+Alltrim(Str(__nL++)))
        ProcessMessage()

        If Empty(cLinha)
            Loop
        EndIf

        cLinha := Alltrim(cLinha)

        If ("Rdd:" $ cLinha .and. "Alias:"$ cLinha )   .or. ;
                cLinha == '*************************************************************************'
            Exit
        EndIf

        If "Index"  == Left(cLinha, 5)
            aAux   := Separa(cLinha,":", .T.)
            aadd(aIndice, aAux)

        ElseIf  "Field" == Left(cLinha, 5)
            aAux   := Separa(cLinha,":", .T.)

            cIdentifi := Left(aAux[1], At(" ", aAux[1]) -1)
            aAux[2]   := Alltrim(aAux[2])
            aAux[2]   := StrTran(aAux[2], "(", "")
            aAux[2]   := StrTran(aAux[2], ")", "")
            cNome     := Left(aAux[2], len(aAux[2]) -1)
            cTipo     := Right(aAux[2], 1)
            nP        := At(cTipo, cTipoRef)
            cDesTipo  := aTipo[nP]
            cConteudo := aAux[3]

            aadd(aLstCampos, {cIdentifi, cNome, cDesTipo, cConteudo})


        EndIf
    End
    ::aIndice    := aClone(aIndice)
    ::aLstCampos := aClone(aLstCampos)
Return


/*
=================================================================================
Funcoes genericas 
=================================================================================
*/

Static Function ChkErr(oErroArq, lTrataVar)
    Local ni:= 0

    If lTrataVar
        If "variable does not exist " $ oErroArq:description
            __cErroA := Alltrim(SubStr(oErroArq:description,24)) + " := '' " + CRLF
        Else
            If oErroArq:GenCode > 0
                __cErroA := '(' + Alltrim( Str( oErroArq:GenCode ) ) + ') : ' + AllTrim( oErroArq:Description ) + CRLF
            EndIf
        EndIf
    Else
        If oErroArq:GenCode > 0
            __cErroA := '(' + Alltrim( Str( oErroArq:GenCode ) ) + ') : ' + AllTrim( oErroArq:Description ) + CRLF
        EndIf
        ni := 2
        While ( !Empty(ProcName(ni)) )
            __cErroA +=	Trim(ProcName(ni)) +"(" + Alltrim(Str(ProcLine(ni))) + ") " + CRLF
            ni++
        End
    EndIf
    Break
Return


Static Function LeHst(aHist, cTipo)
    Local cFile := GetTempPath() + "tidev_" + cTipo + ".json"
    Local cConteudo := ""
    Local aAux := {}

    cConteudo := MemoRead(cFile)
    If ! Empty(cConteudo)
        FWJsonDeserialize(cConteudo, @aAux)
        If Valtype(aAux) == "A"
            aHist := aClone(aAux)
        EndIf 
    EndIf
    
    If Empty(aHist) .and. cTipo == "base"
        aadd(aHist, "//Programação - Threads monitor" + CRLF + "GetUserInfoArray()")
        aadd(aHist, "//Programação - Dados de fontes no rpo" + CRLF + "cProg:= 'TIDEV.PRW', Alert(VarInfo('Info',GetAPOInfo(cProg),,.F.))")
        aadd(aHist, "//Programação - Conversão de base Encode64 / Decode64" + CRLF + "cTexto:= 'TESTE COM ENCODE64'" + CRLF + "cRetorno := Encode64(cTexto)" + CRLF+ "Decode64(cRetorno)" )
        

        aadd(aHist, "// Contrato - Pendencias de atualização " + CRLF + "U_GCVA105M()") 

        aadd(aHist, "//Proposta - Copia "                 + CRLF + "cProposta:='AADFMY'" + CRLF + "cRevProp:='01'" + CRLF + "nCopias:=1" + CRLF + "U_GCVA116C(cProposta, cRevProp, nCopias)") 
        aadd(aHist, "//Proposta - Reseta para 2 momento " + CRLF + "U_GCIIA06V()") 
        aadd(aHist, "//Proposta - Monitor 2 momento"      + CRLF + "U_TIMJobM()" ) 

        aadd(aHist, "//Cronograma Financeiro - Consulta"              + CRLF + "U_GCVC014V()")
        aadd(aHist, "//Cronograma Financeiro - Simula"                + CRLF + "U_GCVA095V()")
        aadd(aHist, "//Cronograma Financeiro - Recalculo"             + CRLF + "U_GCVA095R()")
        aadd(aHist, "//Cronograma Financeiro - Monitor das Threads"   + CRLF + "U_GCVA102M()")

        aadd(aHist, "//Intera - Ferramentas" + CRLF + "U_GCIIA06V()")

    EndIf

Return 

Static Function GrvHst(aHist, ctipo, cMemo, lExcAll, lExcItem)
    Local cFile      := GetTempPath() + "tidev_" + cTipo + ".json"
    Local cConteudo  := "" 
    Local nPos       := 0
    Local nLimite    := 40
    Local cTitulo    := ""
    DEFAULT lExcAll  := .F.
    DEFAULT lExcitem := .F.

    If cTipo == "base" .and. ! lExcAll
        cTitulo := Alltrim(MemoLine(cMemo, 254, 1))
        If left(cTitulo, 2) != "//"
            cTitulo := "//" + PegaNome(cTitulo)
            cMemo := cTitulo + CRLF + Alltrim(cMemo)
        EndIf 
    EndIf 
    
    If lExcAll
        aHist := {}
    ElseIf lExcitem  //Alltrim(cMemo)  == "#APAGARITEM#" 
        nPos := aScan(aHist, {|x| x == cMemo})
        If ! Empty(nPos)
            aDel(aHist,nPos)
            Asize(aHist, len(aHist) - 1)
        EndIf
    Else
        If Len(aHist) == nLimite
            aDel(aHist, 1)
            aHist[Len(aHist)] := cMemo
        Else 
            nPos := aScan(aHist, {|x| x == cMemo})
            If Empty(nPos)
                aAdd(aHist, cMemo)
            Else
                aDel(aHist,nPos)
                aHist[len(aHist)] := cMemo
            EndIf
        EndIf 
    EndIf

    cConteudo := FwJsonSerialize(aHist)
    MemoWrit(cFile, cConteudo )

Return 

Static Function PegaNome(cTitulo)
 
    Local oFontB    := TFont():New('Consolas',, 16,, .T.,,,,, .F., .F.)
    Local oModal 
    Local oDlg
    Local oPS

    cTitulo := Padr(cTitulo, 80)
 
    oModal  := FWDialogModal():New()       
	oModal:SetEscClose(.T.)
    oModal:setTitle("Base Conhecimento")
	oModal:setSize(100, 180)
    oModal:createDialog()
    oModal:addCloseButton({|| oModal:DeActivate() }, "OK")

    oDlg:= oModal:getPanelMain()
    
        oPS:= TPanelCss():New(,,, oDlg)
        oPS:SetCoors(TRect():New(0, 0, 75, 500))
        oPS:Align :=CONTROL_ALIGN_ALLCLIENT

            @ 023, 004 SAY "Titulo:"      of oPS SIZE 030, 10 PIXEL FONT oFontB
            @ 020, 034 Get oTitulo  VAR cTitulo   of oPS SIZE 120, 09 PIXEL 
       
    oModal:Activate()


Return Alltrim(cTitulo)

Static Function GrvArq(cArquivo,cLinha)
    If ! File(cArquivo)
        If (nHandle2 := MSFCreate(cArquivo,0)) == -1
            Return
        EndIf
    Else
        If (nHandle2 := FOpen(cArquivo,2)) == -1
            Return
        EndIf
    EndIf
    FSeek(nHandle2,0,2)
    FWrite(nHandle2,cLinha+CRLF)
    FClose(nHandle2)
Return


/*
Static function LeArquivo(cFile)
    Local oFile
    oFile := FWFileReader():New(cFile)
    if (oFile:Open())
       while (oFile:hasLine())
          Conout(oFile:GetLine())
       end
       oFile:Close()
    endif

Return
*/


Class TIFileReader
    Data nHandle
    Data cBuffer 
    Data cFile
    Data nBloco

    Data aLinha 
    Data nPLin
    Data cUltLin
    Data nTotByte
    Data nPosByte

    Method New(cFile)
    Method Open()
    Method Close()
    Method GetLine()
    Method NextBlock()
    Method Eof()

EndClass

Method New(cFile) Class TIFileReader

    ::cFile   := cFile
    ::nBloco  := 4000
    ::cBuffer := ""
    ::cUltLin := ""
    ::nPLin   := 0
    ::aLinha  := {}
    ::nTotByte:= 0
    ::nPosByte:= 0
 
Return

Method Open() Class TIFileReader

    ::nHandle := FOpen(::cFile)
    If ::nHandle == -1 
        Return .f.
    EndIF 

    ::nTotByte := fseek(::nHandle,0,2)
    fseek(::nHandle,0) 

Return .t.


Method Close() Class TIFileReader

    Fclose(::nHandle)

Return 

Method GetLine() Class TIFileReader
    Local cLinha := ""

    If ::nPLin + 1 > len(::aLinha) 
        Self:NextBlock()
    EndIf 

    ::nPLin++
    cLinha := ::aLinha[::nPLin]

Return cLinha


Method NextBlock() Class TIFileReader
    Local cBuffer := ""
    Local nx      := 0
    Local cByte   := ""
    Local aLinha  := {}
    Local cLinha  := ""

    FRead(::nHandle, @cBuffer, ::nBloco)

    ::nPosByte += len(cBuffer)

    cBuffer := ::cUltLin + cBuffer
    ::cUltLin := ""
    For nx:= 1 to len(cBuffer)
        cByte := Subs(cBuffer,nx,1)
        If cByte == chr(13)
            Loop 
        EndIf 
        If cByte == chr(10)
            aadd(aLinha, cLinha)
            cLinha:= ""
            Loop
        End
        cLinha += cByte
    Next

    If Empty(aLinha)
       aadd(aLinha, cLinha)
       cLinha := ""
    EndIf 
    ::aLinha := aClone(aLinha)
    ::cUltLin := cLinha
    ::nPLin := 0

Return 

Method Eof() Class TIFileReader
    Local lEof := .T.

    If ::nPosByte < ::nTotByte
        lEof := .F.
    EndIf 
    If ::nPLin < len(::aLinha)
        lEof := .F.
    EndIf 
    If ! Empty(::cUltLin)
        lEof := .F.
    EndIf 

Return lEof

Static Function TIDesMon(cDesc)

    FWMonitorMsg(cDesc) 
    //PTInternal(1, cDesc)

Return 

Static Function MostraLog()
    Local oDlg
    Local cMemo
    Local oMemo
    
    Local oFont:= TFont():New("Consolas",, 20,, .F.,,,,, .F. )
    Local cFileLog := NomeAutoLog()
    Local oModal 
    
    cMemo :=MemoRead(cFileLog)

    oModal  := FWDialogModal():New()       
	oModal:SetEscClose(.T.)
    oModal:setTitle(cFileLog)
	oModal:setSize(240, 280)
    oModal:createDialog()
    oModal:addCloseButton({|| oModal:DeActivate() }, "OK")
    oDlg:= oModal:getPanelMain()
        
        oMemo := tMultiget():new(,, bSETGET(cMemo), oDlg)
        oMemo:Align := CONTROL_ALIGN_ALLCLIENT
        oMemo:oFont:=oFont

        oModal:Activate()

    FErase(cFileLog)        
    
Return(cMemo)

Static Function TmpOpen(cArq,cAlias)
    Local nI, nJ
    Local cArquivo  := ""
    Local cDriver   := "TOPCONN" 
    Local cIndex    := ""
    Local aStruct   := {}
    Local aTables   := {}
    Local aStruDB   := {}
    DEFAULT cAlias  := cArq

    If cArq == "TIDEVLOG" //-- 
        aStruct := {}
        Aadd(aStruct,{"LOGTSTMP" ,"C",	14, 0})
        Aadd(aStruct,{"LOGDATE"  ,"D",	 8, 0})
        Aadd(aStruct,{"LOGTIME"  ,"C",	 8, 0})
        Aadd(aStruct,{"LOGUID"   ,"C",	 6, 0})
        Aadd(aStruct,{"LOGUSER"  ,"C",	25, 0})
        Aadd(aStruct,{"LOGNAME"  ,"C",	80, 0})
        Aadd(aStruct,{"LOGTHR"   ,"N",	 6, 0})
        Aadd(aStruct,{"LOGUMACH" ,"C",	30, 0})
        Aadd(aStruct,{"LOGMACHI" ,"C",	30, 0})
        Aadd(aStruct,{"LOGIP"    ,"C",	13, 0})
        Aadd(aStruct,{"LOGPORT"  ,"C",	04, 0})
        Aadd(aStruct,{"LOGENV"   ,"C",	80, 0})
        Aadd(aStruct,{"LOGTIPO"  ,"C",	10, 0})
        Aadd(aStruct,{"LOGTAB"   ,"C",	10, 0})
        Aadd(aStruct,{"LOGOBS"   ,"M",	10, 0})


        Aadd( aTables, {cArq, cAlias, {"LOGTSTMP+LOGUID"}, aClone(aStruct) } )
    EndIf	

    For nI := 1 To Len(aTables)
        cAlias  := aTables[nI, 2]
        aStruct := aClone(aTables[nI, 4])
        cArquivo := RetArq(cDriver, cArq, .T.)

        If ! MsFile(cArquivo,,cDriver)
            DbCreate(cArquivo, aStruct, cDriver)
        EndIf

        If MsOpenDbf(.T.,cDriver, cArquivo, cAlias,.T.,.F.,.F.,.F.)
            DbSelectArea(cAlias)
            aStruDB :=  DbStruct()
            If IsStruDif(aStruct, aStruDB) 
                DbCloseArea()
                If ! TcAlter(cArquivo, aStruDB, aStruct)
                    //Final("Não foi possivel atualizar " + cArquivo)
                EndIf
                MsOpenDbf(.T.,cDriver, cArquivo, cAlias,.T.,.F.,.F.,.F.)
            EndIf 
            
            lReOpen := ! MsFile(cArquivo,cArquivo+"1",cDriver)
            For nJ := 1 To Len(aTables[nI,3])
                cIndex := cArq+Str(nJ,1)
                MsOpenIdx(cIndex,aTables[nI,3,nJ],.T.,.F.,,cArquivo)
            Next nJ

            If lReOpen
                DbCloseArea()
                MsOpenDbf(.T.,cDriver,cArquivo,cAlias,.T.,.F.,.F.,.F.)
                DbSelectArea(cAlias)
                For nJ := 1 To Len(aTables[nI,3])
                    cIndex := cArq+Str(nJ,1)
                    MsOpenIdx(cIndex,aTables[nI,3,nJ],.T.,.F.,,cArquivo)
                Next nJ
            EndIf
            DbSetOrder(1)
        EndIf

    Next nI

Return .t.

Static Function IncLog(cTipo, cTabela, cLog)
    Local aArea     := GetArea()
    Local cUserLocal:= ""
    Local cMaqLocal := ""
    
    TmpOpen("TIDEVLOG")

    RetUser(@cUserLocal, @cMaqLocal)

    TIDEVLOG->(RecLock("TIDEVLOG", .T.))
    TIDEVLOG->LOGTSTMP := FWTimeStamp()
    TIDEVLOG->LOGDATE  := Date()    
    TIDEVLOG->LOGTIME  := Time()    
    TIDEVLOG->LOGUID   := __cUserId
    TIDEVLOG->LOGUSER  := UsrRetName(__cUserId)    
    TIDEVLOG->LOGNAME  := UsrFullName(__cUserId)    
    TIDEVLOG->LOGTHR   := ThreadId() 
    If TIDEVLOG->(FieldPos("LOGUMACH")) > 0
        TIDEVLOG->LOGUMACH := cUserLocal
        TIDEVLOG->LOGMACHI := cMaqLocal
    EndIf 
    TIDEVLOG->LOGIP    := PegaIP()      
    TIDEVLOG->LOGPORT  := cValToChar(GetServerPort())
    TIDEVLOG->LOGENV   := GetEnvserver()
    TIDEVLOG->LOGTIPO  := cTipo
    TIDEVLOG->LOGTAB   := cTabela     
    TIDEVLOG->LOGOBS   := cLog
 
    TIDEVLOG->(MsUnlock())
    RestArea(aArea)  

Return 

Static Function RetUser(cUserLocal, cMaqLocal)
    Local nx := 0
    Local aUser := GetUserInfoArray()

    cUserLocal := ""
    cMaqLocal  := ""

    For nx:= 1 to len(aUser)
        If aUser[nx, 3] == ThreadId()
            cUserLocal :=  aUser[nx, 1]
            cMaqLocal  :=  aUser[nx, 2]
        EndIf 
    Next 

Return 



Static Function IsStruDif(aStruPrg, aStruDB)
    Local lDif := .F.

    Local nx     := 0
    Local np     := 0

    Local cCampo := ""
    Local cTipo  := ""
    Local nTam   := 0
    Local nDec   := 0
    
    Local cTipoDB  := ""
    Local nTamDB   := 0
    Local nDecDB   := 0

    If len(aStruDB) > LEN(aStruPrg)
        Return .F.
    EndIf 

    For nx:= 1 to len(aStruPrg)
        cCampo := Alltrim(aStruPrg[nx, 1])
        cTipo  := aStruPrg[nx, 2]
        nTam   := aStruPrg[nx, 3]
        nDec   := aStruPrg[nx, 4]

        nP := Ascan(aStruDB, { |x| AllTrim(x[1]) == cCampo})
        If Empty(np)
            lDif := .T.
            Exit 
        EndIf 
        cTipoDB  := aStruDB[np, 2]
        nTamDB   := aStruDB[np, 3]
        nDecDB   := aStruDB[np, 4]

        If cTipo != cTipoDB 
            lDif := .T. 
            Exit 
        Else 
            If nTam != nTamDB
                lDif := .T. 
                Exit 
            Else 
                If nDec != nDecDB
                    lDif := .T. 
                    Exit 
                EndIf 
            EndIf 
        EndIf 

    Next 

    If lDif 
        Return  lDif
    EndIf 

    For nx := 1 to len(aStruDB)
        cCampoDB := Alltrim(aStruDB[nx, 1])

        nP := Ascan(aStruPrg, { |x| AllTrim(x[1]) == cCampoDB})
        If Empty(np)
            lDif := .T.
            Exit 
        EndIf 
    Next 


Return lDif


//https://tdn.totvs.com/display/tec/ManualJob
//https://tdn.totvs.com/display/framework/FWExecStatement
//https://tdn.totvs.com/display/framework/MPSysOpenQuery
//https://tdn.totvs.com/display/public/framework/FWTemporaryTable
//https://tdn.engpro.totvs.com.br/display/public/framework/FWBulk

/*
FWAlertError: Mostra uma mensagem com um círculo vermelho e um x no meio
FWAlertExitPage: Mostra uma pergunta com 3 opções (Continuar editando, Salvar, Sair da Página)
FWAlertHelp: Mostra uma mensagem de help e solução
FWAlertInfo: Mensagem informativa com um círculo azul e um i no meio
FWAlertNoYes: Mensagem que tem 2 opções (Não e Sim)
FWAlertSuccess: Mostra uma mensagem com um círculo verde e um ícone de check
FWAlertWarning: Mostra uma mensagem com um triângulo amarelo e uma exclamação no meio
FWAlertYesNo: Mensagem que tem 2 opções (Sim e Não)
aCoors := FWGetDialogSize( oMainWnd )
TFileDialog("Arquivos (*.csv)","Informe o arquivo",0,"C:\",.F.)  // subititui o cGetFile
FWLoadSM0()  // Carrega a empresas
FWGetSx5()
XMLFormat(cMsg)
FWCutOff()  // retira crlf e tab
*/


