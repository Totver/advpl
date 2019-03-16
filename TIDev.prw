#Include 'Protheus.ch'


Static aRet__Func := {}
Static aRet__Class:= {}
Static cErroA	:= ""
Static __nBuffer := 40

User Function Afterlogin()

    SetKey(K_ALT_S, {|| U_TIDev() })

Return

/*{Protheus.doc} TIDev
Ferramentas úteis ao desenvolvimento.
@author Alex Sandro
@since 18/01/2018
@version 1.0
*/
User Function TIDev()
	   
	If Type("OMAINWND") != "O"

		Private oShortList
        Private oMainWnd
        Private oFont
		Private lLeft     := .F.
		Private cVersao   := GetVersao()
		Private dDataBase := MsDate()
		Private cUsuario  := "TOTVS"

		DEFINE FONT oFont NAME "MS Sans Serif" SIZE 0, -9

		DEFINE WINDOW oMainWnd FROM 0,0 TO 0,0 TITLE "TIDev"
		oMainWnd:oFont := oFont
		oMainWnd:SetColor(CLR_BLACK,CLR_WHITE)
		oMainWnd:Cargo := oShortList
		oMainWnd:nClrText := 0
		oMainWnd:lEscClose := .F.
		oMainWnd:ReadClientCoors()

		ACTIVATE WINDOW oMainWnd MAXIMIZED ON INIT (MainDevApp(.T.) , oMainWnd:End())
	Else
		MainDevApp()
	EndIf

Return

/*{Protheus.doc} MainDevApp
Função Principal.
@author Alex Sandro
@since 18/06/2014
@version 1.0
@param lInit, logico, indica se inicializa o ambiente automaticamente
*/
Static Function MainDevApp(lInit)
    Local oDlg
    Local oRect
    Local oSize
    Local oFol
    Local oFolQry
    Local oFolDic
    
	Local aEmpExQr  := {}
	Local aFolder   := {'Query', 'Dicionário', 'Inspeção de Funções/Comandos', 'Linha de Comando','Html', 'File Explorer'}
    Local aSFolder  := {"Query #1", "Query #2", "Query #3", "Query #4", "Query #5"}
    Local aSFolder2 := {"Tabela #1", "Tabela #2", "Tabela #3", "Tabela #4", "Tabela #5"}
    Local nSF := 0
    Local oKf6
    Local lOk:= .F.
    Local lSetAnt := Set(11)
    
	Static oFolBMP := LoadBitmap( GetResources(), "F5_AMAR") 
	Static oFilBMP := LoadBitmap( GetResources(), "LBNO")
	Static cMaskArq := "*.*"

	Private lSqlExec  := .F.
    Private lReadOnly := .T.
    Private lDeleON   := .T.
	Private cUsrFs   := Space(25)  //"Administrador"
	Private cPswFS   := Space(25)
	Private aQryHst  := {{},{},{},{},{}}
	Private aCmdHst  := {}
	Private aDicBrw  :=Array(5)
    Private aAliasDic:= Array(5)
    Private aQryBrw  :=Array(5)
    
    
    Private oInfBrw
	       
    Private lDic
	Private lRPO := lClasse := lADVPL := .T.

    LoadJson()

    Set(11,"on")

	SetFolder(1)

	oSize := FwDefSize():New(.F.)
	oSize:AddObject( "PANEL" , 100, 100, .T., .T. )
	
    If lInit
		oSize:aWorkArea := {0,25,oMainWnd:nRight-15,oMainWnd:nBottom-100}
		cEmpAnt := ''
		cFilAnt := ''
		oRect := TRect():New(7,-1,oMainWnd:nBottom-17,oMainWnd:nRight-7)
	Else
		oRect := TRect():New(0,0,oMainWnd:nBottom-17,oMainWnd:nRight-7)
		oSize:aWorkArea := {0,25,oMainWnd:nRight-15,oMainWnd:nBottom-37}
	EndIF
	oSize:lProp := .T.
	oSize:Process()

    oKf6 := SetKey(VK_F6 ,{|| lSqlExec := ! lSqlExec}) // SqlExec
	
	DEFINE MSDIALOG oDlg FROM 0,0 TO 0,0 TITLE  "Ferramenta de desenvolvimento"

	    oDlg:SetCoors(oRect)
		oFol := TFolder():New(, , aFolder, aFolder, oDlg, , , , .T., .F.)
	    oFol:bSetOption:= {|n| SetFolder(n), .T.}
	    oFol:Align := CONTROL_ALIGN_ALLCLIENT


        oFolQry := TFolder():New(, , aSFolder, aSFolder, oFol:aDialogs[1], , , , .T., .F.)
	    oFolQry:Align := CONTROL_ALIGN_ALLCLIENT
        //--Folder Query
        For nSF := 1 to 5 //len(aSFolder)
            FolderQry(oFolQry:aDialogs[nSF], oSize, nSF)
        Next
        
        oFolDic := TFolder():New(, , aSFolder2, aSFolder2, oFol:aDialogs[2], , , , .T., .F.)
	    oFolDic:Align := CONTROL_ALIGN_ALLCLIENT
        //--Folder Dicionario
        For nSF := 1 to 5 //len(aSFolder)
            FolderDic(oFolDic:aDialogs[nSF], oSize, nSF)
        Next

        //--Folder Inspeção de Funções/Comandos
        FolderInsp(oFol:aDialogs[3], oSize)

    	//--Folder Comandos
        FolderCmd(oFol:aDialogs[4], oSize)

	    //--Folder Html
        FolderHtm(oFol:aDialogs[5], oSize)
	
        //--Folder File Explorer
        FolderExp(oFol:aDialogs[6], oSize)
    
        

	If lInit
		DEFINE MESSAGE BAR oMsgBar OF oDLG PROMPT "TIDev " COLOR RGB(116,116,116) FONT oFont
		DEFINE MSGITEM oMsgIt of oMsgBar PROMPT "Empresa/Filial: ["+cEmpAnt+"/"+cFilAnt+"] " SIZE 100 
        DEFINE MSGITEM oMsgIt2 of oMsgBar PROMPT GetEnvServer() SIZE 100 
        ACTIVATE MSDIALOG oDlg /*VALID If(! lOk, .T., MsgYesNo("Deseja realmente fechar?","Fechar aplicação"))*/ ON INIT (lOk:= InitEmp(aEmpExQr, oMsgIt, .T., oDlg ))
	Else
		ACTIVATE MSDIALOG oDlg /*VALID MsgYesNo("Deseja realmente fechar?","Fechar aplicação")*/ //CENTERED
	EndIf
	SetKey(VK_F6 , oKf6)
	If lInit
		RpcClearEnv()
	EndIf

    
    Set(11,If(lSetAnt,"on","off"))
    
Return

Static Function FolderQry(oFol1, oSize, np)
    Local nLin:= 02
    Local nCol:= 02
    Local cQrySup1  := ""
    Local cQrySup2  := ""
    Local nM := 3
	Local nT := oSize:GetDimension("PANEL","LININI")
	Local nL := oSize:GetDimension("PANEL","COLINI")
	Local nB := oSize:GetDimension("PANEL","LINEND")
	Local nR := oSize:GetDimension("PANEL","COLEND")
	Local nWm := (nR - nL)/2
	Local nHm := (nB - nT)/2
    Local cAliasExqr := GetNextAlias()
    Local cAliasTst := GetNextAlias()
    Local oBut1
    Local oBut2
    Local oBut3
    Local oBut4
    Local oBut5
    Local oBut6
    Local oBut7
    Local oBut8
    Local oBut9
    Local oButE
    Local oButF
    Local oButG    
    Local oPnlQrySup1
    Local oTxtQrySup1
    Local oPnlQrySup2
    Local oTxtQrySup2
    Local oPnlQryI
    Local oCheck
    Local oPanelS
    Local oPanelM1
    Local oPanelM2
    Local oPanelM3
    Local oSplitH
    Local oSplitV
    
    Local oTime
    Local cTime		:= "00:00:00 "
    Local oQtd
    Local cQtd      := ""
    
    oPanelS := TPanelCss():New(,,,oFol1)
    oPanelS :SetCoors(TRect():New( 0,0, nB * 0.4, nR))
    oPanelS :Align :=CONTROL_ALIGN_ALLCLIENT

        oPnlQrySup1:= TPanelCss():New(,,,oPanelS)
        oPnlQrySup1:SetCoors(TRect():New( 0,0, nB * 0.4 , nR * 0.5))
        oPnlQrySup1:Align :=CONTROL_ALIGN_ALLCLIENT

            oPanelM1 := TPanelCss():New(,,,oPnlQrySup1)
            oPanelM1 :SetCoors(TRect():New( 0,0, 25, 25))
            oPanelM1 :Align := CONTROL_ALIGN_TOP
                @ nLin, nCol	 BUTTON oBut1 PROMPT '&Executar'     SIZE 045,010 ACTION ApQry2Run(cQrySup1, cAliasExqr, cAliasTst, oPnlQryI, np, oTime, oQtd)                         OF oPanelM1 PIXEL ; oBut1:nClrText :=0  
                @ nLin, nCol+=50 BUTTON oBut2 PROMPT 'Abrir'         SIZE 045,010 ACTION FileQry(.T., @cQrySup1)                    OF oPanelM1 PIXEL ; oBut2:nClrText :=0
                @ nLin, nCol+=50 BUTTON oBut3 PROMPT 'Salvar'        SIZE 045,010 ACTION FileQry(.F., @cQrySup1)                    OF oPanelM1 PIXEL ; oBut3:nClrText :=0
                @ nLin, nCol+=50 BUTTON oBut4 PROMPT 'Change Query'  SIZE 045,010 ACTION cQrySup1 := ChangeQuery(cQrySup1)          OF oPanelM1 PIXEL ; oBut4:nClrText :=0
                @ nLin, nCol+=50 BUTTON oBut5 PROMPT 'SQL to ADVPL'  SIZE 045,010 ACTION cQrySup2 := SQL2ADVPL(@cQrySup1)           OF oPanelM1 PIXEL ; oBut5:nClrText :=0
                @ nLin, nCol+=50 BUTTON oBut8 PROMPT 'Format SQL'    SIZE 045,010 ACTION cQrySup1 := Format(cQrySup1)               OF oPanelM1 PIXEL ; oBut8:nClrText :=0
                @ nLin, nCol+=50 BUTTON oBut9 PROMPT 'Histórico'     SIZE 045,010 ACTION Tools(@cQrySup1, oBut9, np)                OF oPanelM1 PIXEL ; oBut9:nClrText :=0
            
            oTxtQrySup1 := NewMemo(@cQrySup1,oPnlQrySup1)

        oPnlQrySup2:= TPanelCss():New(,,,oPanelS)
        oPnlQrySup2:SetCoors(TRect():New( 0,0, nB * 0.4, (nR * 0.5)-4))
        oPnlQrySup2:Align :=CONTROL_ALIGN_RIGHT
        oPnlQrySup2:lVisibleControl:= .F.

        @ 000,000 BUTTON oSplitV PROMPT "*" SIZE 4,4 OF oPanelS PIXEL    
        oSplitV:cToolTip := "Habilita e desabilita Advpl-SQL"
        oSplitV:bLClicked := {|| oPnlQrySup2:lVisibleControl := !oPnlQrySup2:lVisibleControl }
        //oSplitV:bLClicked := {|| AjustaTela(oPnlQrySup2, oSize, oPnlQrySup1, oSplitV ) }
        oSplitV:Align := CONTROL_ALIGN_RIGHT
        
            oPanelM2 := TPanelCss():New(,,,oPnlQrySup2)
            oPanelM2 :SetCoors(TRect():New( 0,0, 25, 25))
            oPanelM2 :Align:= CONTROL_ALIGN_TOP
                @ nLin, 02 BUTTON oBut6 PROMPT 'ADVPL to SQL' SIZE 045,010 ACTION cQrySup1 := ADVPL2SQL(@cQrySup2)           OF oPanelM2 PIXEL ; oBut6:nClrText :=0
                @ nLin, 52 BUTTON oBut7 PROMPT 'Trim ADVPL'   SIZE 045,010 ACTION cQrySup2 := QryTrim(cQrySup2)              OF oPanelM2 PIXEL ; oBut7:nClrText :=0
            oTxtQrySup2 := NewMemo(@cQrySup2,oPnlQrySup2)

    oPnlQryI := TPanelCss():New(,,,oFol1)
    oPnlQryI :SetCoors(TRect():New( 0,0, nB * 0.6, nR))
    oPnlQryI :Align :=CONTROL_ALIGN_BOTTOM

        //oPnlQryI := NewPanel(nB * 0.4 + nM, nL + nM, nB - nM - 60, nR - nM, oFol1)
        oPanelM3 := TPanelCss():New(,,,oPnlQryI)
        oPanelM3 :SetCoors(TRect():New( 0,0, 25, 25))
        oPanelM3 :Align:= CONTROL_ALIGN_TOP
            @ nLin, 002	 BUTTON oButE PROMPT 'CSV'    SIZE 045,010 ACTION ExportCSV(cAliasTst)  OF oPanelM3 PIXEL ; oButE:nClrText :=0 
            @ nLin, 052	 BUTTON oButF PROMPT 'Excel'  SIZE 045,010 ACTION ExportExcel(cAliasTst)  OF oPanelM3 PIXEL ; oButF:nClrText :=0 
            @ nLin, 102	 BUTTON oButG PROMPT 'Count'  SIZE 045,010 ACTION CountQuery(cQrySup1, oQtd)  OF oPanelM3 PIXEL ; oButG:nClrText :=0 
            
            @ nLin, nWm - 200 SAY "Quantidade: "       SIZE 030,010 OF oPanelM3 PIXEL 
            @ nLin, nWm - 150 SAY oQtd VAR cQtd        SIZE 040,010 OF oPanelM3 PIXEL             
            @ nLin, nWm - 100 SAY "Run Time: "   SIZE 030,010 OF oPanelM3 PIXEL 
            @ nLin, nWm - 75 SAY oTime VAR cTime SIZE 070,010 OF oPanelM3 PIXEL
            
    @ 000,000 BUTTON oSplitH PROMPT "*" SIZE 5,5 OF oFol1 PIXEL    
    oSplitH:cToolTip := "Habilita e desabilita browser"
    oSplitH:bLClicked := {|| oPnlQryI:lVisibleControl 	:= !oPnlQryI:lVisibleControl}
    oSplitH:Align := CONTROL_ALIGN_BOTTOM  

Return

Static nCtrl := 1
Static cSentido:= "C"
Static Function AjustaTela(oPnlQrySup2, oSize, oPnlQrySup1, oSplitV )
    Local nR := oSize:GetDimension("PANEL","COLEND")
    Local nParte := nR/4
    Local aPos := {0.25, 0.5, 0.75, 1}
    
    If cSentido == "C"
        nCtrl++
        If nCtrl == 5
            nCtrl := 3
            cSentido := "B"
        EndIf
    Else
        nCtrl--
        If Empty(nCtrl)
            nCtrl := 2
            cSentido := "C"
        EndIf
    EndIF
    oPnlQrySup1:nRight := (nR * aPos[nCtrl]) - 4
    
    oSplitV:nLeft      := (nR * aPos[nCtrl]) - 3
    oSplitV:nRight     := (nR * aPos[nCtrl]) + 3
    
    oPnlQrySup2:nLeft  := (nR * aPos[nCtrl]) + 4
    oPnlQrySup2:nRight := nR

    oPnlQrySup2:Refresh()
    oPnlQrySup1:Refresh()
    
Return

Static Function FolderDic(oFol2, oSize, np)
    Local nLin:= 02
    Local nCol:= 02
    Local nM := 3
	Local nT := oSize:GetDimension("PANEL", "LININI")
	Local nL := oSize:GetDimension("PANEL", "COLINI")
	Local nB := oSize:GetDimension("PANEL", "LINEND")
	Local nR := oSize:GetDimension("PANEL", "COLEND")
	Local cAliasDic := Space(3)
    Local oPnlDicSup
    Local oPnlDicI
    
    Local oBut
    Local oBut1
    Local oBut2
    Local oBut3
    Local oCheck
    Local oCheck2
    Local oPanelM1

    oPanelM1 := TPanelCss():New(,,,oFol2)
    oPanelM1 :SetCoors(TRect():New( 0,0, 30, 30))
    oPanelM1 :Align := CONTROL_ALIGN_TOP

        @ 05,002 SAY "Alias:"  of oPanelM1 SIZE 030,09 PIXEL
        @ 02,025 GET cAliasDic of oPanelM1 SIZE 015,09 PIXEL PICTURE "@!"
        nCol := 50
        @ nLin, nCol     BUTTON oBut  PROMPT '&Executar'      SIZE 045,010 ACTION DicQry(cAliasDic, oPnlDicI, np) OF oPanelM1 PIXEL; oBut:nClrText :=0
        @ nLin, nCol+=50 BUTTON oBut1 PROMPT 'Validar Sx'    SIZE 045,010 ACTION DicTst(cAliasDic, oPnlDicI) OF oPanelM1 PIXEL WHEN cAliasDic <> "SX3"; oBut1:nClrText :=0 
        @ nLin, nCol+=50 BUTTON oBut2 PROMPT 'Sync SX3 = DB' SIZE 045,010 ACTION AtuSX3toDB(cAliasDic, oPnlDicI, np) OF oPanelM1 PIXEL WHEN cAliasDic <> "SX3"; oBut2:nClrText :=0 
        @ nLin, nCol+=50 BUTTON oBut3 PROMPT 'Estrutura'      SIZE 045,010 ACTION Estru(cAliasDic, oPnlDicI, np) OF oPanelM1 PIXEL WHEN cAliasDic <> "SX3"; oBut3:nClrText :=0 
        @ nLin, nCol+=50 CHECKBOX oCheck2 VAR lDeleOn	 PROMPT 'Dele ON'	   SIZE 055,010 OF oPanelM1 PIXEL VALID  DelOn(np)
        @ nLin, nCol+=50 CHECKBOX oCheck VAR lReadOnly	 PROMPT 'Somente Leitura'	 SIZE 055,010 OF oPanelM1 PIXEL
    	
	oPnlDicI := TPanelCss():New(,,,oFol2)
    oPnlDicI :SetCoors(TRect():New( 0,0, nB , nR))
    oPnlDicI :Align :=CONTROL_ALIGN_ALLCLIENT
	

Return

Static Function DelOn(np)

    If lDeleOn
        Set(11,"on")
    Else
        Set(11,"off")
    EndIf

    If ValType(aDicBrw[np])=='O'
		aDicBrw[np]:Refresh()
	EndIf

Return .t.    

Static Function FolderInsp(oFol3, oSize)
    Local nLin:= 02
    Local nCol:= 02
    Local nM := 3
	Local nT := oSize:GetDimension("PANEL", "LININI")
	Local nL := oSize:GetDimension("PANEL", "COLINI")
	Local nB := oSize:GetDimension("PANEL", "LINEND")
	Local nR := oSize:GetDimension("PANEL", "COLEND")
	Local nWm := (nR - nL)/2
	Local nHm := (nB - nT)/2
    Local oBut
    Local oBut2
    LOcal oPanelM1
    Local oCheck
    Local oPnlInfI
    Local oPnlInfI2
    Local cFunInf := Space(30)
    Local cObjInf := Space(255)

    oPanelM1 := TPanelCss():New(,,,oFol3)
    oPanelM1 :SetCoors(TRect():New( 0,0, 60, 60))
    oPanelM1 :Align := CONTROL_ALIGN_TOP
    
	
	@ 003, 002 SAY "Função:" of oPanelM1 SIZE 030, 09 PIXEL
	@ 003, 025 GET cFunInf   of oPanelM1 SIZE 060, 08 PIXEL
    @ 003, 090 BUTTON   oBut				PROMPT 'Pesquisar' SIZE 045,010 ACTION PesqFunc(cFunInf, oPnlInfI, oPnlInfI2) OF oPanelM1 PIXEL ; oBut:nClrText :=0
    @ 003, 150 CHECKBOX oCheck VAR lRPO	    PROMPT 'RPO'	   SIZE 030,010 OF oPanelM1 PIXEL
	@ 003, 180 CHECKBOX oCheck VAR lADVPL	PROMPT 'ADVPL'     SIZE 030,010 OF oPanelM1 PIXEL
	@ 003, 210 CHECKBOX oCheck VAR lClasse  PROMPT 'CLASSE'    SIZE 030,010 OF oPanelM1 PIXEL

	@ 18, 002 SAY "Objeto:" of oPanelM1 SIZE 030, 09 PIXEL
	@ 18, 025 GET  cObjInf  of oPanelM1 SIZE 255, 08 PIXEL
    @ 18, 290 BUTTON   oBut2				 PROMPT 'Pesquisar' SIZE 045,010 ACTION ObjInfo(cObjInf, oPnlInfI2)  OF oPanelM1 PIXEL           ; oBut2:nClrText :=0

	oPnlInfI:= TPanelCss():New(,,,oFol3)
    oPnlInfI:SetCoors(TRect():New( 0,0, nB * 0.4 , nR * 0.5))
    oPnlInfI:Align :=CONTROL_ALIGN_ALLCLIENT
    
    oPnlInfI2:= TPanelCss():New(,,,oFol3)
    oPnlInfI2:SetCoors(TRect():New( 0,0, nB * 0.4, nR * 0.5))
    oPnlInfI2:Align :=CONTROL_ALIGN_RIGHT
    
Return

Static Function FolderCmd(oFol4, oSize)
    Local nLin:= 02
    Local nCol:= 02
    Local nM := 3
	Local nT := oSize:GetDimension("PANEL", "LININI")
	Local nL := oSize:GetDimension("PANEL", "COLINI")
	Local nB := oSize:GetDimension("PANEL", "LINEND")
	Local nR := oSize:GetDimension("PANEL", "COLEND")
	Local nWm := (nR - nL)/2
	Local nHm := (nB - nT)/2
    Local oBut
    Local oBut2
	Local cPnlCmdSup:=""
	Local oPnlCmdSup
    Local oPnlCmdI
    Local oTime
    Local cTime		:= "00:00:00 "
    Local oTxtCmdSup
    Local oPnlCmdSup

	@ nLin, nCol BUTTON oBut PROMPT '&Executar' SIZE 045,010 ACTION ExecMacro(cPnlCmdSup, oPnlCmdI, oTime) OF oFol4 PIXEL; oBut:nClrText :=0
    @ nLin, nCol+=50 BUTTON oBut2 PROMPT 'Histórico'     SIZE 045,010 ACTION Tools2(@cPnlCmdSup, oBut2)   OF oFol4 PIXEL ; oBut2:nClrText :=0
    @ nLin, nWm - 100 SAY "Run Time: "   SIZE 030,010 OF oFol4 PIXEL 
    @ nLin, nWm - 75 SAY oTime VAR cTime SIZE 070,010 OF oFol4 PIXEL

	oPnlCmdSup := NewPanel(nT + nM, nL + nM, nHm - nM, nR - nM, oFol4)
	oTxtCmdSup := NewMemo(@cPnlCmdSup, oPnlCmdSup)

	oPnlCmdI := NewPanel(nHm + nM, nL + nM, nB - nM- 60, nR - nM, oFol4)

Return

Static Function FolderHtm(oFol5, oSize)
    Local nLin:= 02
    Local nCol:= 02
    Local nM := 3
	Local nT := oSize:GetDimension("PANEL", "LININI")
	Local nL := oSize:GetDimension("PANEL", "COLINI")
	Local nB := oSize:GetDimension("PANEL", "LINEND")
	Local nR := oSize:GetDimension("PANEL", "COLEND")
	Local nWm := (nR - nL)/2
	Local nHm := (nB - nT)/2
    Local oBut
    Local oBut2
	Local cPnlCmdSup:=""
	Local oPnlCmdSup
    Local oPnlCmdI
    Local oTxtCmdSup
    Local oPnlCmdSup
    Local oEdit

	@ nLin, nCol BUTTON oBut PROMPT '&Executar' SIZE 045,010 ACTION ExecHtml(cPnlCmdSup, oEdit ) OF oFol5 PIXEL; oBut:nClrText :=0
    //@ nLin, nCol+=50 BUTTON oBut2 PROMPT 'Histórico'     SIZE 045,010 ACTION Tools2(@cPnlCmdSup, oBut2)   OF oFol5 PIXEL ; oBut2:nClrText :=0
    
	oPnlCmdSup := NewPanel(nT + nM, nL + nM, nHm - nM, nR - nM, oFol5)
	oTxtCmdSup := NewMemo(@cPnlCmdSup, oPnlCmdSup)

	oPnlCmdI := NewPanel(nHm + nM, nL + nM, nB - nM- 60, nR - nM, oFol5)
    @ 0,0 SCROLLBOX oSbr HORIZONTAL SIZE 94,206 OF oPnlCmdI BORDER
    oSbr:Align := CONTROL_ALIGN_ALLCLIENT
    oEdit:= TSimpleEditor():New( 0,0,oSbr,3000,184 )
    oEdit:Align := CONTROL_ALIGN_LEFT
    
Return

Static Function ExecHtml(cTrb, oEdit)

    oEdit:Load(cTrb)
	oEdit:Refresh()

Return 

Static Function FolderExp(oFol6, oSize)
    Local nLin:= 02
    Local nCol:= 02
    Local nM := 3
	Local nT := oSize:GetDimension("PANEL", "LININI")
	Local nL := oSize:GetDimension("PANEL", "COLINI")
	Local nB := oSize:GetDimension("PANEL", "LINEND")
	Local nR := oSize:GetDimension("PANEL", "COLEND")
	Local nWm := (nR - nL)/2
	Local nHm := (nB - nT)/2
    Local nS1 := 0
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

    /*

    oPnlFExp := TPanelCss():New(,,, oFol6)
	oPnlFExp:Align := CONTROL_ALIGN_ALLCLIENT
*/
    oPnlFExp := oFol6
    nS1:= (nWm - nCol) / 2 // ao definir os pixels é necessário dividir o valor por dois

	@ nLin     , nCol     MSGET  oGet1  VAR cPath01   PICTURE "@!" PIXEL SIZE nS1-35,009 WHEN .F.  OF oPnlFExp
	@ nLin     , nS1 - 30 BITMAP oBmp01 NAME "OPEN"   SIZE 015,015 OF oPnlFExp PIXEL NOBORDER ON CLICK ( cPath01 := OpenBtn(cPath01,"T") , LeDirect(@oList01,@oGet1,@cPath01) )
	@ nLin+=12 , nCol     MSGET  oGet1  VAR cSearch01 PICTURE "@!" PIXEL SIZE nS1-35,009  OF oPnlFExp
	@ nLin     , nS1 - 30 BITMAP oBmp01 NAME "LUPA"   SIZE 015,015 OF oPnlFExp PIXEL NOBORDER ON CLICK ( FAtualiz(cSearch01,oList01,2) )

	@ nLin+=12 , nCol LISTBOX oList01 FIELDS HEADER " ","File Name","File Size","File Date","File Hour"  SIZE nS1 -15,nHm-49 OF oPnlFExp PIXEL COLSIZES 05,185,35,30,30 ;
	ON DBLCLICK LeDirect(@oList01,@oGet1,@cPath01,.T.)

	nLin:= nHm-20

	@ nLin,nCol     BITMAP oBmp01 NAME "BMPDEL"    SIZE 015,015 OF oPnlFExp PIXEL NOBORDER ON CLICK MsgRun("Apagando Arquivo...","Aguarde.",{|| FApaga(cPath01,oList01) , LeDirect(@oList01,@oGet1,@cPath01) })
	@ nLin,nCol+=15 BITMAP oBmp01 NAME "SDUDRPTBL" SIZE 015,015 OF oPnlFExp PIXEL NOBORDER ON CLICK Processa({|| FApaga(cPath01,oList01,.T.), LeDirect(@oList01,@oGet1,@cPath01) },"Exclusão de arquivos","Excluindo",.T.)

	nCol := nWm/2 - 7
	nLin := nHm/2 - 87.5

	@ nLin      , nCol BITMAP oBmp01 NAME "RIGHT"   SIZE 015,015 OF oPnlFExp PIXEL NOBORDER ON CLICK MsgRun("Copiando Arquivo...","Aguarde.",{|| FCopia(cPath01,cPath02,oList01) , LeDirect(@oList01,@oGet1,@cPath01),  LeDirect(@oList02,@oGet2,@cPath02) })
	@ nLin += 20, nCol BITMAP oBmp01 NAME "LEFT"    SIZE 015,015 OF oPnlFExp PIXEL NOBORDER ON CLICK MsgRun("Copiando Arquivo...","Aguarde.",{|| FCopia(cPath02,cPath01,oList02) , LeDirect(@oList01,@oGet1,@cPath01),  LeDirect(@oList02,@oGet2,@cPath02) })
	@ nLin += 20, nCol BITMAP oBmp01 NAME "RIGHT_2" SIZE 015,015 OF oPnlFExp PIXEL NOBORDER ON CLICK Processa({|| FCopia(cPath01,cPath02,oList01,.T.), LeDirect(@oList01,@oGet1,@cPath01), LeDirect(@oList02,@oGet2,@cPath02) },"Copia de arquivos","Copiando",.T.)
	@ nLin += 20, nCol BITMAP oBmp01 NAME "LEFT2"   SIZE 015,015 OF oPnlFExp PIXEL NOBORDER ON CLICK Processa({|| FCopia(cPath02,cPath01,oList02,.T.), LeDirect(@oList01,@oGet1,@cPath01), LeDirect(@oList02,@oGet2,@cPath02) },"Copia de arquivos","Copiando",.T.)
	@ nLin += 20, nCol BITMAP oBmp01 NAME "FILTRO"  SIZE 015,015 OF oPnlFExp PIXEL NOBORDER ON CLICK ( MaskDir() , LeDirect(@oList01,@oGet1,@cPath01), LeDirect(@oList02,@oGet2,@cPath02) )

	nLin := 02
	nCol += 20

	@ nLin    , nCol			MSGET  oGet2  VAR cPath02   PICTURE "@!" PIXEL SIZE nS1 -35,009 WHEN .F.  OF oPnlFExp
	@ nLin    , nCol+nS1-32 	BITMAP oBmp02 NAME "OPEN"   SIZE 015,015 OF oPnlFExp PIXEL NOBORDER ON CLICK ( cPath02 := OpenBtn(cPath02,"S") , LeDirect(@oList02,@oGet2,@cPath02) )
	@ nLin+=12, nCol			MSGET  oGet2  VAR cSearch02 PICTURE "@!" PIXEL SIZE nS1 -35,009  OF oPnlFExp
	@ nLin    , nCol+nS1-32 	BITMAP oBmp02 NAME "LUPA"   SIZE 015,015 OF oPnlFExp PIXEL NOBORDER ON CLICK ( FAtualiz(cSearch02,oList02,2) )

	@ nLin+=12, nCol LISTBOX oList02 FIELDS HEADER " ","File Name","File Size","File Date","File Hour" SIZE nS1 -15,nHm-49 OF oPnlFExp PIXEL COLSIZES 05,185,35,30,30 ;
	ON DBLCLICK LeDirect(@oList02,@oGet2,@cPath02,.T.) //ON CHANGE Teste()

	nLin:= nHm-20

	@ nLin,nCol     BITMAP oBmp01 NAME "BMPDEL"    SIZE 015,015 OF oPnlFExp PIXEL NOBORDER ON CLICK MsgRun("Apagando Arquivo...","Aguarde.",{|| FApaga(cPath02,oList02) , LeDirect(@oList02,@oGet2,@cPath02) }) 
	@ nLin,nCol+=15 BITMAP oBmp01 NAME "SDUDRPTBL" SIZE 015,015 OF oPnlFExp PIXEL NOBORDER ON CLICK Processa({|| FApaga(cPath02,oList02,.T.), LeDirect(@oList02,@oGet2,@cPath02) },"Exclusão de arquivos","Excluindo",.T.)  

	LeDirect(@oList01,@oGet1,@cPath01)
	LeDirect(@oList02,@oGet2,@cPath02)

Return    


Static Function SetFolder(nFolder)

	lDic := nFolder == 2
Return

Static Function ChkErr(oErroArq, lTrataVar)
    Local ni:= 0

    If lTrataVar
    	If "variable does not exist " $ oErroArq:description
	    	cErroA := Alltrim(SubStr(oErroArq:description,24)) + " := '' " + CRLF
        Else
            If oErroArq:GenCode > 0
                cErroA := '(' + Alltrim( Str( oErroArq:GenCode ) ) + ') : ' + AllTrim( oErroArq:Description ) + CRLF
            EndIf  
		EndIf
    Else
        If oErroArq:GenCode > 0
            cErroA := '(' + Alltrim( Str( oErroArq:GenCode ) ) + ') : ' + AllTrim( oErroArq:Description ) + CRLF
        EndIf 
        ni := 2
        While ( !Empty(ProcName(ni)) )
            cErroA +=	Trim(ProcName(ni)) +"(" + Alltrim(Str(ProcLine(ni))) + ") " + CRLF
            ni++
        End             
    EndIf
    Break
Return 


/*{Protheus.doc} ExecMacro
@author Izac
@since 18/06/2014
@version 1.0
@param cTrb, character
@return cRet, character
*/
Static Function ExecMacro(cTrb, oPnlCmdI, oTime)
	Local aQry := StrTokArr(cTrb,CRLF)
	Local nX := 0
	Local xAux:=''
	Local cBrkLine:=''
	Local cRet:=""
    Local cRetM:= ""
    Local bErroA   
    Local cPnlCmdI := ""
    Local oMemErr
    Local nSec1 := 0
    Local nSec2 := 0
    Local nPos
    
    cErroA :=""

    bErroA   := ErrorBlock( { |oErro| ChkErr( oErro ) } ) 
    Begin Sequence
        nSec1 := Seconds()

		for nX:= 1 to Len(aQry)
			If !empty(aQry[nX])
				aQry[nX]:= Alltrim(aQry[nX])
				If Right(aQry[nX],1)== ';'
					cBrkLine += SubStr(aQry[nX],1,len(aQry[nX])-1)
					loop
				EndIf
				xAux:= &(cBrkLine+aQry[nX])
				cBrkLine:=''
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
					EndIf
				EndIf
				cRetM += Valtype(xAux)+ ' -> ' + cRet +CRLF
			EndIf
		next
        nSec2 := Seconds()
        oTime:SetText( APSec2Time(nSec2-nSec1) + " (" + Alltrim(Str(nSec2-nSec1)) + " segs.)" )

        nPos := aScan(aCmdHst, {|x| x == cTrb}) 
        If Empty(nPos)
		    aAdd(aCmdHst, cTrb)
        Else
            aDel(aCmdHst,nPos)
            aCmdHst[len(aCmdHst)] := cTrb
	    EndIf
        SaveJson()

	End Sequence

    ErrorBlock( bErroA ) 

    If ! Empty(cErroA) 
        cPnlCmdI := cErroA
        cErroA:= ""
    Else
        cPnlCmdI := cRetM
    EndIf

	@ 0,0 GET oMemErr VAR cPnlCmdI OF oPnlCmdI MEMO size 0,0
	oMemErr:Align := CONTROL_ALIGN_ALLCLIENT
	

Return cRet

/*/{Protheus.doc} DicQry
Consulta no Dicionário.
@author Izac
@since 18/06/2014
@version 1.0
@param cAlias, character, Alias a ser realizada
/*/
Static Function DicQry(cAlias, oPnlDicI, np)
	Local aColunas:={}
	Local nX := 0
	Local cAliasTst := GetNextAlias()
	Local aStruct:= {}
    Local bErroA 
    Local cErro := ""
    Local lTermino := .F.
    
     
    cErroA :=""

	If empty(cAlias)
		Return
	EndIf

	If empty(cFilAnt) .or. empty(cEmpAnt)
		MsgInfo("Ambiente Não Inicializado")
		Return
	EndIf

	If ValType(aDicBrw[np])=='O'
		aDicBrw[np]:DeActivate(.T.)
	EndIf
	
    If cAlias $ "SIX,SX1,SX2,SX3,SX5,SX6,SX7,SXA,SXB,SXE,SXF"
        cAliasTst := cAlias
    Else
        aAliasDic[np] := GetNextAlias()
        cAliasTst := aAliasDic[np]

        If Select(cAliasTst) > 0
		    (cAliasTst)->(DbCloseArea())
    	EndIf
        ChkFile(cAlias, .F., cAliasTst)
    EndIf        

    bErroA := ErrorBlock( { |oErro| ChkErr( oErro ) } ) 
    Begin Sequence
       
        aDicBrw[np] := FWBrowse():New(oPnlDicI)
        aDicBrw[np]:SetDataTable(.T.)
        aDicBrw[np]:SetAlias(cAliasTst)
        aDicBrw[np]:SetDescription("Dicionario")
        aDicBrw[np]:SetUpdateBrowse({||.T.})
        aDicBrw[np]:SetEditCell(.T.,{||.F.})
        aDicBrw[np]:Setdoubleclick({|o| AltReg(o, cAliasTst, .F.)})
        aDicBrw[np]:SetSeek()
        aDicBrw[np]:SetDBFFilter()
        aDicBrw[np]:SetUseFilter()
        aDicBrw[np]:SetBlkColor({|| If(Deleted()    , CLR_WHITE    , CLR_BLACK)})  // cor da fonte
        aDicBrw[np]:SetBlkBackColor({|| If(Deleted(), CLR_LIGHTGRAY,  CLR_WHITE)}) // cor do fundo

       
        aColunas := {}
        aStruct := ((cAliasTst)->(dbStruct()))
        For nX := 1 To len(aStruct)
            oCol := FWBrwColumn():New()
            oCol:SetTitle(aStruct[nX][1])
            oCol:SetType(aStruct[nX][2])
            oCol:SetSize(aStruct[nX][3])
            oCol:SetDecimal(aStruct[nX][4])
            oCol:SetData(&('{||'+ aStruct[nX][1]+'}'))
            aAdd(aColunas,oCol)
        Next

        oCol := FWBrwColumn():New()
        oCol:SetTitle('RECNO')
        oCol:SetData({||Recno()})
        aAdd(aColunas,oCol)

        aDicBrw[np]:SetColumns(aColunas)
        aDicBrw[np]:Activate()
        lTermino := .t.
    End Sequence
    ErrorBlock( bErroA )

	If ! Empty(cErroA) .and. ! lTermino
        cErro := cErroA
        AutoGrLog("")
        FErase(NomeAutoLog())
        AutoGrLog(cErro)
        MostraErro()
        cErroA :=""
	EndIf
Return
/*
Static Function DeleteRecno()
    Local lDeleted	:= Deleted()
    Local cText		:= If( lDeleted, 'Recuperar registro?', 'Deletar registro?' ) 
    
    
    If lReadOnly
        Return
    EndIf

    If lDeleOn
        Return
    EndIf


    If ( EOF() )
        MsgAlert("Arquivo vazio!")
        Return
    EndIf

    If  !APMsgNoYes(cText,'Confirma') 
        Return
    EndIf


    Begin Sequence
        DbRlock()
        If ( Deleted() )
            DbRecall()
        Else
            DbDelete()
        EndIf
        DbUnlock()
        DbCommitAll()
    End Sequence

Return
*/

/*{Protheus.doc} AltReg

@author Izac
@since 02/07/2014
@version 1.0
@param oObject, objeto
*/

Static Function AltReg(oObject, cAliasAlt, lQuery)
	Local oDlgReg
	Local nLin 
	Local nCol 
	Local cField   
	Local lRet     := .F.
	Local xValue

    If lQuery
        nLin := oObject:nat
	    nCol := oObject:ncolpos
	    cField := oObject:aColumns[nCol]:cheading
        lReadOnly := .T.
    Else
        nLin := oObject:At()
	    nCol := oObject:ColPos()
	    cField := oObject:aColumns[nCol]:cTitle
    EndIf
    xValue:= (cAliasAlt)->&(cField)

	DEFINE MSDIALOG oDlgReg FROM 0,0 TO 25,260 TITLE "Valor" PIXEL
	oGet:=TGet():New(02,02, bSETGET(xValue),oDlgReg,100,0009,,,,,,,,.T.)
	If ! lReadOnly .and. lDic
		DEFINE SBUTTON FROM 2,103 TYPE 1 OF oDlgReg ENABLE ACTION (lRet := .T.,oDlgReg:End())
	EndIf
	ACTIVATE MSDIALOG oDlgReg CENTERED

	If ! lReadOnly .and. lDic .and. lRet
		If !IsLocked(cAliasAlt)
			(cAliasAlt)->(RecLock(cAliasAlt, .F.))
			(cAliasAlt)->&(cField):= xValue
			(cAliasAlt)->(MsUnlock())
		Else
			MsgInfo("Não foi possível alterar!","Registro lockado")
		EndIf
	EndIf
Return

Static Function ApQry2Run(cQuery, cAliasExqr, cAliasTst, oPnlQryI, np, oTime, oQtd)

    MsgRun("Executando query...","Aguarde..." , {|| PApQry2Run(cQuery, cAliasExqr, cAliasTst, oPnlQryI, np, oTime, oQtd) } )

Return

Static Function PApQry2Run(cQuery, cAliasExqr, cAliasTst, oPnlQryI, np, oTime, oQtd)
	Local aColunas:={}
	Local nX := 0
	
	Local aStruct:= {}
	Local cTst := ''
    Local bErroA
    Local cErro:= ''
   
    Local aArea := {}
    Local nSec1 := 0
    Local nSec2 := 0
    Local cComando:=""
    Local nPos
    
	cQuery:= UPPER(ALLTRIM(cQuery))

	If empty(cQuery)
		Return
	EndIf

	If empty(cFilAnt) .or. empty(cEmpAnt)
		MsgInfo("Ambiente Não Inicializado")
		Return
	EndIf

    cComando := Left(cQuery, At(" ",cQuery) -1)
    
    If ! cComando == "SELECT" .and. ! MsgNoYes('Confirma a execução do ' + cComando+ ' no banco?','Atenção')
       Return
    EndIf            
    
    
    aArea := GetArea()
    If Valtype(aQryBrw[np])=='O'
		aQryBrw[np]:Hide()
        aQryBrw[np]:FreeChildren()
	EndIf

	If Select(cAliasExqr) > 0
		(cAliasExqr)->(DbCloseArea())
	EndIf

	If Select(cAliasTst) > 0
		(cAliasTst)->(DbCloseArea())
	EndIf
	
    cErroA :=""
    bErroA	:= ErrorBlock( { |oErro| ChkErr( oErro ) } )     
    Begin Sequence
        If ! cComando == "SELECT"
            nSec1 := Seconds()
            If TcSqlExec(cQuery) < 0
                cErroA:="TCSQLError() " + TCSQLError()
                Break
            EndIf
            nSec2 := Seconds()
            oTime:SetText( APSec2Time(nSec2-nSec1) + " (" + Alltrim(Str(nSec2-nSec1)) + " segs.)" )
            MsgAlert("Query executada!" + CRLF + "Tempo de processamento:" + APSec2Time(nSec2-nSec1) + " (" + Alltrim(Str(nSec2-nSec1)) + " segs.)")
        Else
            cTst := cQuery 
            nSec1 := Seconds()
            dbUseArea(.T.,'TOPCONN', TCGenQry(,,cTst),cAliasTst, .F., .T.)
            nSec2 := Seconds()
            oTime:SetText( APSec2Time(nSec2-nSec1) + " (" + Alltrim(Str(nSec2-nSec1)) + " segs.)" )
            oQtd:SetText( "" )
            aStruct := (cAliasTst)->(dbStruct())
    
            For nx:= 1 to len(aStruct)
                If aStruct[nx,2] == "N"
                    aStruct[nx,3] := 22
                EndIf
            Next

            dbCreate(cAliasExqr, aStruct)
			dbUseArea( .T., "DBFCDX", cAliasExqr, cAliasExqr, .F., .F. )
			
            aQryBrw[np] := MsBrGetDBase():New(1, 1, __DlgWidth(oPnlQryI)-1, __DlgHeight(oPnlQryI) - 1,,,, oPnlQryI,,,,,,,,,,,, .F., cAliasExqr, .T.,, .F.,,,) 
			For nX:=1 To (cAliasExqr)->(FCount())
				aQryBrw[np]:AddColumn( TCColumn():New( (cAliasExqr)->(FieldName(nX)), &("{ || " + cAliasExqr + "->" + (cAliasExqr)->(FieldName(nX)) + "}"),,,,, "LEFT") )
			Next nX
			
			ApQryPutInFile(cAliasTst, cAliasExqr)
			
			aQryBrw[np]:lColDrag	:= .T.
			aQryBrw[np]:lLineDrag	:= .T.
			aQryBrw[np]:lJustific	:= .T.
			aQryBrw[np]:nColPos		:= 1
			aQryBrw[np]:Cargo		:= {|| __NullEditcoll()}
			aQryBrw[np]:bSkip		:= &("{|N| ApQryPutInFile('"+cAliasTst+"', '"+cAliasExqr+"', N), "+cAliasExqr+"->(_DBSKIPPER(N))}")
			aQryBrw[np]:cCaption	:= APSec2Time(nSec2-nSec1)
            aQryBrw[np]:Align       := CONTROL_ALIGN_ALLCLIENT
            aQryBrw[np]:bLDblClick  := {|| AltReg(aQryBrw[np], cAliasExqr, .T.)}

        EndIf
        nPos:=aScan(aQryHst[np], {|x| x == cQuery})
        If  Empty(nPos)
		    aAdd(aQryHst[np], cQuery)
        Else            
            aDel(aQryHst[np], nPos) 
            aQryHst[np, len(aQryHst[np])] := cQuery
	    EndIf
        SaveJson()
    End Sequence
    ErrorBlock( bErroA )

    If ! Empty(cErroA) 	
        cErro := cErroA
        AutoGrLog("")
        FErase(NomeAutoLog())
        AutoGrLog(cErro)
        MostraErro()
        cErroA :=""
	EndIf
    RestArea(aArea)
Return


Static Function ApQryPutInFile(cSource, cTarget, n)
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
                (cTarget)->(FieldPut(nX, (cSource)->&(aFields[nX][1])))
            EndIf
        Next nX
        nI += 1
        (cSource)->(dbSkip())
    End
    (cTarget)->(dbCommit())
    (cTarget)->(dbGoto(nRecno))
Return



Static Function ExportCSV(cAliasTst)  
    Local cFile := ""
    Private lAbortPrint := .F.
    
	If Select(cAliasTst) == 0
        MsgAlert("Execute uma query!!")
        Return .F.
	EndIf

    cFile := cGetFile("Arquivos query (*.csv) |*.csv|","Informe o arquivo", 0, "C:\", .F., GETF_LOCALHARD + GETF_LOCALFLOPPY + GETF_NETWORKDRIVE)
    If Empty(cFile)
        Return .F.
    Endif

    If ! Lower(Right(cFile, 4)) == ".csv"
        cFile += ".csv"
    EndIf
    If File(cFile) 
        If ! MsgYesNo("Confirma a substituição do arquivo?")
            Return .F.
        EndIf
        FErase(cFile)
    EndIF

    Processa({|| ProcCSV(cAliasTst, cFile)},,,.T.) 

    If lAbortPrint
        MsgAlert("Geração .csv interrompida!")
    Else  
        MsgAlert("Geração .csv concluida!")
    EndIf

Return

Static Function ProcCSV(cAliasCSV, cArquivo)  
    Local cCab  := ""
    Local cLinha:= ""
    Local nx    := 0
    Local nReg  := 0
    Local aFields := (cAliasCSV)->(dbStruct())
    Local nFields := Len(aFields)
    Local nRec := (cAliasCSV)->(Recno())

    For nx:= 1 to nFields
        cCab +=  aFields[nx, 1] + ";"
    Next
    GrvArq(cArquivo, cCab)

	(cAliasCSV)->(DbGoTop())
    While (cAliasCSV)->(! Eof())
        IncProc("Processando linha: " + Alltrim(Str(++nReg,5)))
        ProcessMessage()
        If lAbortPrint
            Return
        EndIf

        cLinha := ""
        For nx:= 1 to nFields
            If aFields[nX][2] == "N"
                cLinha += StrTran(Padl(cValToChar((cAliasCSV)->(FieldGet(nx))) ,20), ".", ",")
            ElseIf aFields[nX][2] == "C"
                cLinha += (cAliasCSV)->(Fieldget(nX))
            ElseIf aFields[nX][2] == "D"                
                cLinha += Dtoc((cAliasCSV)->(Fieldget(nX)))
            ElseIf aFields[nX][2] == "D"                                
                cLinha += If((cAliasCSV)->(Fieldget(nX)), "TRUE","FALSE")
            Else
                cLinha += cValToChar((cAliasCSV)->(FieldGet(nx))) 
            EndIf
            cLinha += ";"
        Next
        GrvArq(cArquivo, cLinha)

        (cAliasCSV)->(DbSkip())
    End
    (cAliasCSV)->(DbGoTo(nRec))

Return

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

Static Function ExportExcel(cAliasTst)  
    Local cFile := ""
    Local oExcel
    Private lAbortPrint := .F.
    
	If Select(cAliasTst) == 0
        MsgAlert("Execute uma query!!")
        Return .F.
	EndIf

    cFile := cGetFile("Arquivos query (*.xls) |*.xls|","Informe o arquivo", 0, "C:\", .F., GETF_LOCALHARD + GETF_LOCALFLOPPY + GETF_NETWORKDRIVE)
    If Empty(cFile)
        Return .F.
    Endif

    If ! Lower(Right(cFile, 4)) == ".xls"
        cFile += ".xls"
    EndIf
    If File(cFile) 
        If ! MsgYesNo("Confirma a substituição do arquivo?")
            Return .F.
        EndIf
        FErase(cFile)
    EndIF

	oExcel:= FWMSEXCEL():New()
    //oExcel:SetTitleBold(.T.)
	//oExcel:SetTitleSizeFont(18)
	//oExcel:SetHeaderBold(.T.)
	//oExcel:SetHeaderSizeFont(14)
    
    //FWMsExcel():SetFontSize(< nFontSize >) //tamanho
    //FWMsExcel():SetFont(< cFont >) //nome da fonte
    //FWMsExcel():SetTitleFont(< cFont >)
    //FWMsExcel():SetTitleSizeFont(< nFontSize >)
    //FWMsExcel():SetTitleItalic(< lItalic >)
    //FWMsExcel():SetTitleBold(< lBold >)
    //FWMsExcel():SetTitleFrColor(< cColor >) //cor hexadecimal
    //FWMsExcel():SetTitleBgColor(< cColor >)-
    //FWMsExcel():SetHeaderSizeFont(< nFontSize >)
    //FWMsExcel():SetHeaderItalic(< lItalic >)
    //FWMsExcel():SetHeaderBold(< lBold >)
    //FWMsExcel():SetFrColorHeader(< cColor >)
    //FWMsExcel():SetBgColorHeader(< cColor >)
    //FWMsExcel():SetLineFont(< cFont >)
    //FWMsExcel():SetLineSizeFont(< nFontSize >)
    //FWMsExcel():SetLineBgColor(< cColor >)
    //FWMsExcel():Set2LineBgColor(< cColor >)
        
    Processa({|| oExcel := ProcExcel(oExcel, cAliasTst)},,,.T.) 

    If lAbortPrint
        MsgAlert("Geração de planilha Excel interrompida!")
    Else
        oExcel:Activate()
        oExcel:GetXMLFile(cFile)
        ShellExecute("open", cFile, "", "", 1)
        MsgAlert("Geração de planilha Excel concluida!")
    EndIf
    oExcel := FreeObj(oExcel)

Return

Static Function ProcExcel(oExcel, cAliasCSV)  
    Local nx      := 0
    Local nReg    := 0
    Local aFields := (cAliasCSV)->(dbStruct())
    Local nFields := Len(aFields)
    Local nRec    := (cAliasCSV)->(Recno())
    Local cPlan   := "Query"
    Local cTit    := "Tabela" 
    Local nAlign  := 0
    Local nFormat := 0
    Local lTotal  := .F.
    Local aLinha := {}   

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

	(cAliasCSV)->(DbGoTop())
    While (cAliasCSV)->(! Eof())
        IncProc("Processando linha: " + Alltrim(Str(++nReg,5)))
        ProcessMessage()
        If lAbortPrint
            Return oExcel
        EndIf

        aLinha:= {}
        For nx:= 1 to nFields
            aadd(aLinha, (cAliasCSV)->(FieldGet(nx)) )
        Next
        oExcel:AddRow(cPlan, cTit, aLinha)
        (cAliasCSV)->(DbSkip())
    End
    (cAliasCSV)->(DbGoTo(nRec))

Return oExcel

Static Function CountQuery(cQuery, oQtd)
	Local aColunas:={}
	Local nX := 0
	
	Local aStruct:= {}
	Local cTst := ''
    Local bErroA
    Local cErro:= ''
    Local aArea := GetArea()
    Local nSec1 := 0
    Local nSec2 := 0
    Local cAliasCount := "TMPCOUNT"
    Local nQtde := 0
    
	If empty(cQuery)
		Return
	EndIf

	If empty(cFilAnt) .or. empty(cEmpAnt)
		MsgInfo("Ambiente Não Inicializado")
		Return
	EndIf

    cQuery:= UPPER(ALLTRIM(cQuery))
    cQuery:= "SELECT COUNT(*) QTDE FROM ("+cQuery+") "
	If Select(cAliasCount) > 0
		(cAliasCount)->(DbCloseArea())
	EndIf

    cErroA :=""
    bErroA	:= ErrorBlock( { |oErro| ChkErr( oErro ) } )     
    Begin Sequence
        cTst := cQuery 
        dbUseArea(.T.,'TOPCONN', TCGenQry(,,cTst),cAliasCount, .F., .T.)
        If (cAliasCount)->(! Eof())
            nQtde := (cAliasCount)->QTDE
        EndIf
    End Sequence
    ErrorBlock( bErroA )

    If Select(cAliasCount) > 0
        (cAliasCount)->(DbCloseArea())
    EndIf

    If ! Empty(cErroA) 	
        cErro := cErroA
        AutoGrLog("")
        FErase(NomeAutoLog())
        AutoGrLog(cErro)
        MostraErro()
        cErroA :=""
    EndIf
    RestArea(aArea)
    oQtd:SetText(Alltrim(Transform(nQtde,"999,999,999")))
Return

/*/{Protheus.doc} PesqFunc
(long_description)
@author Izac
@since 04/09/2014
@version 1.0
@param cFunc, character, (Descrição do parâmetro)
@return ${return}, ${return_description}
@example
(examples)
@see (links_or_references)
/*/
Static Function PesqFunc(cFunc, oPnlInfI, oPnlInfI2)
	Local aType,aFile,aLine,aDate,aTime
	Local nCount
	Local aDados := {}
	Local aFuns  := {}
	Local aFields:= { 'Função','Tipo','Arquivo','Linha','Data','Hora'}

	If empty(cFunc)
		Return
	EndIf

	If empty(cFilAnt) .or. empty(cEmpAnt)
		MsgInfo("Ambiente Não Inicializado")
		Return
	EndIf

	If Type('oInfBrw')=='O'
		oInfBrw:DeActivate(.T.)
	EndIf
	oInfBrw := FWBrowse():New(oPnlInfI)
	oInfBrw:SetDataArray(.T.)
	oInfBrw:SetDescription("Info")
	oInfBrw:SetUpdateBrowse({||.T.})
	oInfBrw:SetEditCell(.T.,{||.F.})
	oInfBrw:SetDoubleClick({|o|BuscaPar(o, oPnlInfI2 )})
	oInfBrw:SetSeek()
	oInfBrw:SetUseFilter()
	oInfBrw:SetDBFFilter()

	aColunas := {}
	for nCount:= 1 to Len(aFields)
		oCol := FWBrwColumn():New()
		oCol:SetTitle(aFields[nCount])
		oCol:SetData(&("{|x|x:oData:aArray[x:At()]["+Str(nCount)+"]}"))
		aAdd(aColunas,oCol)
	next

	MsgRun("Buscando funções protheus.","Aguarde",{||aFuns := GetFuncArray(Alltrim(cFunc), aType, aFile, aLine, aDate, aTime)})

    If lADVPL
        For nCount := 1 To Len(aFuns)
            AAdd(aDados, { aFuns[nCount], aType[nCount], aFile[nCount], aLine[nCount], aDate[nCount], aTime[nCount]} )
        Next
    EndIf
	
	lComMask := '*'$cFunc

	cFunc := StrTran(cFunc,"*","")
	cFunc := Upper(AllTrim(cFunc))

	If Empty(aRet__Func)
		aRet__Func:= __FunArr()
	EndIf

	If Empty(aRet__Class)
		aRet__Class:= __ClsArr()
	EndIf

	If lComMask
		If lADVPL
			AEval(aRet__Func,{|x,y|If(Empty(cFunc) .Or. cFunc $ Upper(x[1]),AAdd(aDados, { x[1], "ADVPL", "", "", "", ""}),Nil)})
		EndIf
		If lClasse
			AEval(aRet__Class,{|x,y|If(Empty(cFunc) .Or. cFunc $ Upper(x[1]),AAdd(aDados, { x[1], "Classe", "", "", "", ""}),Nil)})
		EndIf
	Else
		If lADVPL
			If ( nCount := AScan(aRet__Func,{|x| cFunc == Upper(x[1])  }) ) > 0
				AAdd(aDados, { aRet__Func[nCount][1], "ADVPL", "", "", "", ""} )
			EndIf
		EndIf

		If lClasse
			If ( nCount := AScan(aRet__Class,{|x| cFunc == Upper(x[1])  }) ) > 0
				AAdd(aDados, { aRet__Class[nCount][1], "Classe", "", "", "", ""} )
			EndIf
		EndIf
	EndIf

	oInfBrw:SetColumns(aColunas)
	oInfBrw:SetArray(aDados)
	oInfBrw:Activate()
Return

/*/{Protheus.doc} BuscaPar
Busca parametros de uma função específica.
@author Carlos Alberto Gomes Junior
@since 13/02/2014
@version 1.0
@param cNomeFunc, character, Nome da função
@param lAdvpl, logico, Se a função é do Protheus ou do Advpl
@return cRetPar, Descrição dos parametros da função
/*/
Static Function BuscaPar(oObj, oPnlInfI2)

	Local cRet    := ""
	Local cRetPar := ""
	Local cPar    := ""
	Local nX  := 0
	Local nY := 0
	Local nZ := 0
	Local aRet2   := {}
	Local cNomeFunc := oObj:oData:aArray[oObj:At()][1]
	Local lAdvpl    := oObj:oData:aArray[oObj:At()][2] =="ADVPL"
	Local lClasse   := oObj:oData:aArray[oObj:At()][2] =="Classe"
	Local cChamada := 'Chamada: ' +CHR(9)+ cNomeFunc+'( '

	If lClasse
		nX := ascan(aRet__Class,{|x|cNomeFunc $ x[1]})
		cRetPar += 'Classe:' + aRet__Class[nx][1]+CRLF
		If !empty(aRet__Class[nx][2])
			cRetPar += 'Herdada de: ' + aRet__Class[nx][2]+CRLF
		EndIf

		If !empty(aRet__Class[nx][3])
			cRetPar += CRLF
			cRetPar += 'Variáveis: '+CRLF
			for nY:= 1 to Len(aRet__Class[nx][3])
				cRetPar += "   "+aRet__Class[nx][3][nY][1]+CRLF
			next
		EndIf

		If !empty(aRet__Class[nx][4])
			cRetPar += CRLF
			cRetPar += 'Métodos: '+CRLF
			for nY:= 1 to Len(aRet__Class[nx][4])
				cRetPar += "   "+aRet__Class[nx][4][nY][1]+CRLF

				If !empty(aRet__Class[nx][4][nY][2])
					cRetPar += "    "+"Parâmetros:"+CRLF

					For nZ:= 1 to len(aRet__Class[nx][4][nY][2]) step 2
						cPar:=SubStr(aRet__Class[nx][4][nY][2],nZ,2)
						Do Case
							Case Left(cPar,1)=='*'
							cRet:='xExp'+strZero((nZ+1)/2,2)+' - variavel'
							Case Left(cPar,1)=='C'
							cRet:='cExp'+strZero((nZ+1)/2,2)+' - caracter'
							Case Left(cPar,1)=='N'
							cRet:='nExp'+strZero((nZ+1)/2,2)+' - numerico'
							Case Left(cPar,1)=='A'
							cRet:='aExp'+strZero((nZ+1)/2,2)+' - array'
							Case Left(cPar,1)=='L'
							cRet:='lExp'+strZero((nZ+1)/2,2)+' - logico'
							Case Left(cPar,1)=='B'
							cRet:='bExp'+strZero((nZ+1)/2,2)+' - bloco de codigo'
							Case Left(cPar,1)=='O'
							cRet:='oExp'+strZero((nZ+1)/2,2)+' - objeto'
						EndCase
						If Right(cPar,1)=='R'
							cRet+=' [obrigatorio]'
						ElseIf Right(cPar,1)=='O'
							cRet+=' [opcional]'
						EndIf
						cRetPar += "       "+cRet+CRLF
					Next nZ

				EndIf
				cRetPar += CRLF
			next
		EndIf
	ElseIf lAdvpl
		nX := ascan(aRet__Func,{|x|cNomeFunc $ x[1]})
		If nX>0
			For nY := 1 to len(aRet__Func[nX][2]) step 2
				cPar := SubStr(aRet__Func[nX][2],nY,2)

				If Right(cPar,1)=='R'
					cRet:= Chr(9)+' [obrigatorio]'
				ElseIf Right(cPar,1)=='O'
					cRet:= Chr(9)+' [opcional]'
				EndIf

				Do Case
					Case Left(cPar,1)=='*'
					cPar:= 'xExp'+strZero((nY+1)/2,2)
					cRet:= cPar+' - variavel'+cRet
					Case Left(cPar,1)=='C'
					cPar:= 'cExp'+strZero((nY+1)/2,2)
					cRet:= cPar+' - caracter'+cRet
					Case Left(cPar,1)=='N'
					cPar:= 'nExp'+strZero((nY+1)/2,2)
					cRet:= cPar+' - numerico'+cRet
					Case Left(cPar,1)=='A'
					cPar:= 'aExp'+strZero((nY+1)/2,2)
					cRet:= cPar+' - array'+cRet
					Case Left(cPar,1)=='L'
					cPar:= 'lExp'+strZero((nY+1)/2,2)
					cRet:= cPar+' - logico'+cRet
					Case Left(cPar,1)=='B'
					cPar:= 'bExp'+strZero((nY+1)/2,2)
					cRet:= cPar+' - bloco de codigo'+cRet
					Case Left(cPar,1)=='O'
					cPar:= 'oExp'+strZero((nY+1)/2,2)
					cRet:= cPar+' - objeto'+cRet
				EndCase
				cChamada += cPar+', '
				cRetPar += "    Parametro " + cValtoChar((nY+1)/2) + " = " + cRet + CRLF

			Next nY
		EndIf
	Else
		aRet2:= GetFuncPrm(cNomeFunc)

		for nY:= 1 to Len(aRet2)
			cPar:= aRet2[nY]
			Do Case
				Case Left(cPar,1)=='X'
				cRet:=' - variavel'
				Case Left(cPar,1)=='C'
				cRet:=' - caracter'
				Case Left(cPar,1)=='N'
				cRet:=' - numerico'
				Case Left(cPar,1)=='A'
				cRet:=' - array'
				Case Left(cPar,1)=='L'
				cRet:=' - logico'
				Case Left(cPar,1)=='D'
				cRet:=' - data'
				Case Left(cPar,1)=='B'
				cRet:=' - bloco de codigo'
				Case Left(cPar,1)=='O'
				cRet:=' - objeto'
				OtherWise
				cRet:=' - Unknown'
			EndCase
			cChamada += cPar+', '
			cRetPar += "    Parametro " + cValtoChar(nY) + " = " + aRet2[nY]+cRet + CRLF
		Next
	EndIf

	If !lClasse
		If ','$cChamada
			cChamada := SubStr(cChamada,1,Len(cChamada)-2)
		EndIf
		cRetPar := cChamada +' )'+ CRLF + CRLF + cRetPar
	EndIf

	oGet:= tMultiget():new(,,bSETGET(cRetPar),oPnlInfI2)
	oGet:Align := CONTROL_ALIGN_ALLCLIENT

Return
/*/{Protheus.doc} ObjInfo
Retorna as informações do Objeto
@author Izac
@since 23/05/2014
@version 1.0
@param cObj, character, Se Informado tenta criar o objeto a partir de &(cObj+'():New()')
@param oObj, objeto, Se Informado obtém as informações do objeto
@sample U_ObjInfo('FwBrowse')
/*/
Static Function ObjInfo(cObj, oPnlInfI2)
	Local aInfo:={}
	Local nX := 0
	Local nY := 0
	Local cRet:=''
	Local oObj
	Local cObjName:=''
	Local cRetPar :=''
	Local cAux := ''
    Local bErroA := ErrorBlock( { |oErro| ChkErr( oErro ) } ) 


	Begin Sequence

		If !('('$cObj)
			oObj:= &(cObj+'():New()')
		Else
			oObj:= &(cObj)
		EndIf

        If oObj!= Nil .and. ValType(oObj)=='O'
            cObjName:= Alltrim(Upper(GetClassName(oObj)))
            cRetPar += 'Objeto: '+cObjName
            aInfo:= ClassDataArr(oObj,.T.)
            cRetPar += CRLF
            cRetPar += "    "+"Variáveis:"+CRLF

            for nX:= 1 to Len(aInfo)
                cPar:= aInfo[nX][1]
                Do Case
                    Case Left(cPar,1)=='*'
                    cRet:=' - variavel'
                    Case Left(cPar,1)=='U'
                    cRet:=' - variavel'
                    Case Left(cPar,1)=='C'
                    cRet:=' - caracter'
                    Case Left(cPar,1)=='N'
                    cRet:=' - numerico'
                    Case Left(cPar,1)=='A'
                    cRet:=' - array'
                    Case Left(cPar,1)=='L'
                    cRet:=' - logico'
                    Case Left(cPar,1)=='B'
                    cRet:=' - bloco de codigo'
                    Case Left(cPar,1)=='O'
                    cRet:=' - objeto'
                    OtherWise
                    cRet:=' - desconhecido'
                EndCase
                cRet:= "    " + strZero(nx,3)+ "= " + aInfo[nX][1]+cRet

                //			If !empty(aInfo[nX][2])
                //				cRet:= cRet + Chr(9) +" Valor Default: " +CRLF+ VarInfo(ValType(aInfo[nX][2]),aInfo[nX][2],,.F.)
                //			EndIf

                If !empty(aInfo[nX][4]) .and. Alltrim(aInfo[nX][4])!= cObjName
                    cRet:= cRet + Chr(9) + Chr(9) +" Herdado de: " + Alltrim(aInfo[nX][4])
                EndIf

                cRetPar += cRet+CRLF
            next

            aInfo:= ClassMethArr(oObj,.T.)

            for nX:= 1 to Len(aInfo)
                cRetPar += CRLF
                cRetPar += 'Método: '+aInfo[nX][1]+CRLF
                If !empty(aInfo[nX][2])
                    cRetPar += "    "+"Parâmetros:"+CRLF
                    for nY:= 1 to Len(aInfo[nX][2])
                        cPar:= aInfo[nX][2][nY]
                        Do Case
                            Case Left(cPar,1)=='*'
                            cRet:=' - variavel'
                            Case Left(cPar,1)=='U'
                            cRet:=' - variavel'
                            Case Left(cPar,1)=='C'
                            cRet:=' - caracter'
                            Case Left(cPar,1)=='N'
                            cRet:=' - numerico'
                            Case Left(cPar,1)=='A'
                            cRet:=' - array'
                            Case Left(cPar,1)=='L'
                            cRet:=' - logico'
                            Case Left(cPar,1)=='B'
                            cRet:=' - bloco de codigo'
                            Case Left(cPar,1)=='O'
                            cRet:=' - objeto'
                            OtherWise
                            cRet:=' - desconhecido'
                        EndCase
                        cRet:= "    Parametro " + strZero(nY,3)+ "= " + aInfo[nX][2][nY]+cRet
                        cRetPar += cRet+CRLF
                    next
                EndIf
            next

            //--Destroi o Objeto Criado
            FreeObj(oObj)
        Else
            cRetPar := CRLF+'Problemas na inicialização do Objeto.'+CRLF+'Objeto Invalido.'
        EndIf
    End Sequence
    ErrorBlock( bErroA ) 

    /*
    If ! Empty(cErroA)
        cRetPar := cErroA
        cErroA  := ""
    EndIf
    */
	oGet:= tMultiget():new(,,bSETGET(cRetPar), oPnlInfI2)
	oGet:Align := CONTROL_ALIGN_ALLCLIENT
Return

/*/{Protheus.doc} SQL2ADVPL

@author Izac
@since 02/07/2014
@version 1.0
@param cQuery, character
@return cRet, character,Trecho de código ADVPL
/*/
Static Function SQL2ADVPL(cQuery)
	Local aQry := StrTokArr(cQuery,CRLF)
	Local nX := 0
	Local nY := 0
	Local cAux:=''
	Local cTrb:=''
	Local cRet:=''
	Local aFiliais := {{"010"}, {"020"}, {"030"}, {"040"}, {"050"}, {"060"}, {"070"}, {"080"}, {"090"}, {"099"}}

	cRet:= 'cQuery := " "'+CRLF

	for nX:= 1 to Len(aQry)
		cAux := aQry[nX] + Space(1)
		If !empty(cAux)
			cTrb :=''
			for nY:= 1 to Len(cAux)
				If Empty(Substr(cAux,nY,1))
					If Len(cTrb) == 6 .And. ( nPos := AScan(aFiliais,{|x| x[1] $ cTrb}) ) > 0
						cTrb := '" + RetSQLName("'+Upper(SubStr(cTrb,1,3))+'") + "'
						cAux :=  Substr(cAux,1,nY-7) + cTrb + Substr(cAux,nY)
					EndIf
					cTrb :=''
					Loop
				EndIf
				cTrb += Substr(cAux,nY,1)
			next
			cRet += 'cQuery += " '+(cAux)+' " '+CRLF
		EndIf
	next
Return cRet

/*/{Protheus.doc} ADVPL2SQL
(long_description)
@author Alex Sandro
@since 05/09/2014
@version 1.0
@param cTrb, character, (Descrição do parâmetro)
@return ${return}, ${return_description}
@example
(examples)
@see (links_or_references)
/*/
Static Function ADVPL2SQL(cTrb)
	Local aQry := StrTokArr(QryTrim(cTrb),CRLF)
	Local nX := 0
	Local xAux :=""
	Local cBrkLine:=""
	Local cRet :=""
	Local bErroA
    Local cErro :=""

    bErroA	:= ErrorBlock( { |oErro| ChkErr( oErro , .T. ) } )     
	Begin Sequence

		for nX:= 1 to Len(aQry)
			If !empty(aQry[nX])
				aQry[nX]:= Alltrim(aQry[nX])
				If Right(aQry[nX],1)== ';'
					cBrkLine += SubStr(aQry[nX],1,len(aQry[nX])-1)
					loop
				EndIf
				xAux:= &(cBrkLine+aQry[nX])
				cBrkLine:=''
				If Valtype(xAux)=='C'
					cRet:= xAux
				EndIf
			EndIf
		next

	End Sequence
    ErrorBlock( bErroA )

    If ! Empty(cErroA) 	
        If ":=" $ cErroA 
            If  ! cErroA $ cTrb
                cTrb := cErroA + cTrb
            Endif
            cRet := ""
        Else
            cRet := cErroA 
        EndIf
        cErroA :=""
	EndIf

    cRet:=Format(cRet)

Return cRet

Static Function QryTrim(cQrySup2)
    Local cA := ""
    Local nx := 0
    Local aQry := StrTokArr(cQrySup2, CRLF)

    For nx:=1 to len(aQry)
        cLinha :=aQry[nx]
        cLinha := StrTran(cLinha, chr(9), "")
        cLinha := StrTran(cLinha, "+CRLF", "")
        cLinha := StrTran(cLinha, "+ CRLF", "")
        cLinha := Alltrim(cLinha)
        cA += cLinha + CRLF
    Next
    cQrySup2 := cA

Return cA

  

Static Function LeDirect(oObjList,oGetInfo,cInfoPath,lClick)

	Local aRetList := {{"0","..","","",""}}
	Local aArqInfo := {}
	Local cFile := ''

	DEFAULT lClick := .F.

	cInfoPath := AllTrim(cInfoPath)

	If lClick
		If oObjList:aArray[oObjList:nAt][1] == "0"
			cInfoPath := Substr(cInfoPath,1,RAT("\",Substr(cInfoPath,1,Len(cInfoPath)-1)))
		ElseIf oObjList:aArray[oObjList:nAt][1] == "1"
			cInfoPath := cInfoPath+AllTrim(oObjList:aArray[oObjList:nAt][2])+"\"
		Else
			If (':'$cInfoPath)
				cFile := cInfoPath+AllTrim(oObjList:aArray[oObjList:nAt][2])
			Else
				cPathDes := GetTempPath()
				If CPYS2T(cInfoPath+oObjList:aArray[oObjList:nAt][2],cPathDes,.T.)
					cFile := cPathDes+oObjList:aArray[oObjList:nAt][2]
				Else
					MsgAlert("Erro ao copiar arquivo.")
				EndIf
			EndIf

			If !empty(cFile)
				ShellExecute('open','cmd.exe','/k '+cFile , "", 0)
			EndIf

			Return
		EndIf
	EndIf

	aArqInfo := Directory(cInfoPath + cMaskArq, "D")

	If Len(aArqInfo) > 0
		AEval(aArqInfo,{|x,y| If(Left(AllTrim(x[1]),1)!=".",AAdd(aRetList,{Iif("D"$x[5],"1","2"),x[1],PADR(Ceiling(x[2]/1024),12)+' KB',x[3],x[4]}),) })
		ASort(aRetList,,,{|x,y| x[1]+x[2] < y[1]+y[2] })
	EndIf

	oObjList:SetArray(aRetList)
	oObjList:bLine := { || {Iif(aRetList[oObjList:nAt][1] == "2",oFilBMP,oFolBMP),aRetList[oObjList:nAt][2],aRetList[oObjList:nAt][3],aRetList[oObjList:nAt][4],aRetList[oObjList:nAt][5]}}

	oObjList:nAt := 1
	oObjList:Refresh()
	oGetInfo:Refresh()

Return


Static Function OpenBtn(cAtual,cOnde)
	Local cRetDir := ""
	If cOnde == "T"
		cRetDir := cGetFile("Todos Arquivos|*.*|","Escolha o caminho dos arquivos.",0,cAtual,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_NETWORKDRIVE)
	ElseIf cOnde == "S"
		cRetDir := cGetFile("Todos Arquivos|*.*|","Escolha o caminho dos arquivos.",0,cAtual,,GETF_RETDIRECTORY+GETF_ONLYSERVER)
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
	ElseIf oObjList:aArray[oObjList:nAt][1] == "2"
		If ":" $ cPathOri
			If !CPYT2S(cPathOri+oObjList:aArray[oObjList:nAt][2],cPathDes,.T.)
				MsgAlert("Erro ao copiar arquivo.")
			EndIf
		Else
			If !CPYS2T(cPathOri+oObjList:aArray[oObjList:nAt][2],cPathDes,.T.)
				MsgAlert("Erro ao copiar arquivo.")
			EndIf
		EndIf
	Else
		MsgAlert("Não copia pastas.")
	EndIf
Return

Static Function FApaga(cPathOri,oObjList,lEraseMult)

	Local aMultErase := {}
	Local cEraseFile := AllTrim(oObjList:aArray[oObjList:nAt][2])

	Private lAbortPrint := .F.

	DEFAULT lEraseMult := .F.

	If lEraseMult
		AEval(oObjList:aArray,{|x,y| If(x[1] == "2",AAdd(aMultErase,AllTrim(x[2])),) })
		ProcRegua(Len(aMultErase))
		If MsgNoYes("Confirma a exclusao de "+AllTrim(Str(Len(aMultErase)))+" arquivos?")
			AEval(aMultErase,{|x,y| If(!lAbortPrint, (FErase(AllTrim(cPathOri)+x), IncProc("Apagando "+Transform(y*100/Len(aMultErase),"@E 99")+"% - "+x) ),) })
		EndIf
	ElseIf oObjList:aArray[oObjList:nAt][1] == "2"
		If MsgNoYes("Apagar o arquivo ["+cEraseFile+"]?")
			FErase(AllTrim(cPathOri)+cEraseFile)
		EndIf
	Else
		MsgAlert("Não apaga pastas.")
	EndIf

Return


Static Function MaskDir

	Local oDlMask,oGetMask

	cMaskArq := Padr(cMaskArq,60)

	DEFINE MSDIALOG oDlMask TITLE "Informe a mascara de arquivos." FROM 0,0 TO 30,230 PIXEL
	@ 02,02 MSGET oGetMask VAR cMaskArq PICTURE "@!" PIXEL SIZE 70,009 VALID Len(AllTrim(cMaskArq)) >= 3 .And. "." $ cMaskArq
	@ 02,75 BUTTON "Ok" SIZE 037,012 PIXEL OF oDlMask Action oDlMask:End()
	ACTIVATE MSDIALOG oDlMask CENTERED VALID Len(AllTrim(cMaskArq)) >= 3 .And. "." $ cMaskArq

	cMaskArq := AllTrim(cMaskArq)

Return

Static Function DicTst(cAliasDic, oPnlDicI)
    Local nX := 0
	Local uValue
	Local cValue
    Local aAreaSx3 := SX3->(GetArea("SX3"))
    Local cResult:= ""
    Local aEstru
    Local cAux:=""
    Local nRecSx3 := SX3->(Recno())

    SX3->(dbSetOrder(1))
	If ! SX3->(DbSeek(cAliasDic))
        RestArea(aAreaSx3)
        SX3->(DbGoto(nRecSx3))
        Return 
    EndIf

    SX3->(dbSetOrder(2))
    aEstru := (cAliasDic)->(dbStruct())
    
    cResult += " *** Comparação de estrutura do banco com SX3 ***" + CRLF
    
    For nx:=1 to len(aEstru)
        cResult += "Campo: " + aEstru[nx,1] 
        cAux := ""
        If ! SX3->(DbSeek(aEstru[nx, 1]))
            cResult +=  CRLF + "    Não cadastrado SX3 com Tipo [" + aEstru[nx, 2] + "] Tamanho ["+ Str(aEstru[nx, 3]) +"] Decimal ["+ Str(aEstru[nx, 4]) +"] " + CRLF
            Loop            
        EndIf
        If ! SX3->X3_TIPO == aEstru[nx, 2]
            cAux += CRLF + "    Tipo diferente: DB [" + aEstru[nx, 2] + "] SX3 [" +SX3->X3_TIPO + "]" 
        Endif
        If ! SX3->X3_TAMANHO == aEstru[nx, 3]
            cAux += CRLF + "    Tamanho diferente: DB [" + Str(aEstru[nx, 3]) + "] SX3 [" + Str(SX3->X3_TAMANHO, 3) + "]" 
        Endif
        If ! SX3->X3_DECIMAL == aEstru[nx, 4]
            cAux += CRLF + "    Decimal diferente:  DB [" + Str(aEstru[nx, 4]) + "] SX3 [" + Str(SX3->X3_DECIMAL, 3) + "]"
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
        If ! SX3->X3_CONTEXT == 'R'
            SX3->(dbSkip())
            Loop
        EndIf

        If Ascan(aEstru, {|x| Alltrim(x[1]) == Alltrim(SX3->X3_CAMPO) }) > 0
            SX3->(dbSkip())
            Loop
        EndIf

        cAux += "Campo " + Alltrim(SX3->X3_CAMPO) + ":"+ CRLF
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
    MostraErro()

    RestArea(aAreaSx3)
    SX3->(DbGoto(nRecSx3))
	
Return

Static Function Estru(cAliasDic, oPnlDicI, np) 
	Local nCount
	Local aDados := {}
	Local aFields:= { 'CAMPO               ','TIPO','TAMANHO','DECIMAL'}

    If ValType(aDicBrw[np])=='O'
		aDicBrw[np]:DeActivate(.T.)
	EndIf
    
	aDicBrw[np] := FWBrowse():New(oPnlDicI)
	aDicBrw[np]:SetDataArray(.T.)
	aDicBrw[np]:SetDescription("Estrutura")
	aDicBrw[np]:SetUpdateBrowse({||.T.})
	aDicBrw[np]:SetEditCell(.T.,{||.F.})
	aDicBrw[np]:SetSeek()
	aDicBrw[np]:SetUseFilter()
	aDicBrw[np]:SetDBFFilter()

	aColunas := {}
	for nCount:= 1 to Len(aFields)
		oCol := FWBrwColumn():New()
		oCol:SetTitle(aFields[nCount])
		oCol:SetData(&("{|x|x:oData:aArray[x:At()]["+Str(nCount)+"]}"))
		aAdd(aColunas,oCol)
	next

    aDados := (cAliasDic)->(dbStruct())

	aDicBrw[np]:SetColumns(aColunas)
	aDicBrw[np]:SetArray(aDados)
	aDicBrw[np]:Activate()

Return



Static Function AtuSX3toDB(cAliasSX, oPnlDicI, np)
    Local cMsg:=""
    Local aArea:= GetArea()
    Local oMemErr
    Local cAliasTst

    If ! MsgYesNo("Confirma o sincronismo entre o SX3 e o banco?")
        return
    EndIf

    cAliasTst := aAliasDic[np]

    If Select(cAliasTst) > 0
	    (cAliasTst)->(DbCloseArea())
    EndIf

    __SetX31Mode(.F.)  // limpar as mensagens antigas da memoria
    If Select(cAliasSX) > 0
	    (cAliasSX)->(dbCloseArea())
	EndIf

    Begin Transaction 
        X31UpdTable(cAliasSX)
    End Transaction 
    If __GetX31Error()
        cMsg:= __GetX31Trace()
    Else
        cMsg:= "Atualização do alias ["+cAliasSX+"] realizada com sucesso! "
    EndIf         
    RestArea(aArea)

    AutoGrLog("")
    FErase(NomeAutoLog())
    AutoGrLog(cMsg)
    MostraErro()

Return


Static Function Tools(cQry,oOwner, np)

	Local nX := 0
	Local oMenu,oIte1,oIte2,oIte3,oIte4,oIte4_1
	Local cAux:= ''
	Local bBlock:={||}

	oMenu := tMenu():new(0, 0, 0, 0, .T., , oOwner)

	oMenu:Add(oIte4 := tMenuItem():new(oMenu, "Historico"		, , 		, , {|| }					, , , , , , , , , .T.))

	oIte4:Add(oIte4_1 := tMenuItem():new(oMenu, "Limpar Histórico", , , , {||  If(MsgYesNo("Confirma a limpeza do historico?"), (aQryHst[np] := {}, SaveJson()), .t.) }, , , , , , , , , .T.))

	For nX := Len(aQryHst[np]) To 1 Step -1 
		cAux := cValToChar(nX)+ ". " + Left( Alltrim(aQryHst[np, nX]), 120)
		bBlock:=&('{|| cQry:= aQryHst[' + str(np) + ',' + str(nX) + ']}')
		oIte4:Add(tMenuItem():new(oIte1, cAux, , , , bBlock, , , , , , , , , .T.))
	Next

	oMenu:Activate(NIL, 21, oOwner)

Return

Static Function Tools2(cCMD, oOwner)

	Local nX := 0
	Local oMenu,oIte1,oIte2,oIte3,oIte4,oIte4_1
	Local cAux:= ''
	Local bBlock:={||}

    If Empty(aCmdHst)
       aadd(aCmdHst, "GetUserInfoArray()")
       aadd(aCmdHst, "cProg:= 'TIDEV.PRW', Alert(VarInfo('Info',GetAPOInfo(cProg),,.F.))")
    EndIf
    
	oMenu := tMenu():new(0, 0, 0, 0, .T., , oOwner)

	oMenu:Add(oIte4 := tMenuItem():new(oMenu, "Historico"		, , 		, , {|| }					, , , , , , , , , .T.))

	oIte4:Add(oIte4_1 := tMenuItem():new(oMenu, "Limpar Histórico", , , , {|| If(MsgYesNo("Confirma a limpeza do historico?"), (aCmdHst := {}, SaveJson()), .t.) }, , , , , , , , , .T.))

    For nX := Len(aCmdHst) To 1 Step -1
		cAux := cValToChar(nX)+ ". " + Left( Alltrim (aCmdHst[nX]), 120)
		bBlock:=&('{|| cCMD:= aCmdHst[' + str(nX) + ']}')
		oIte4:Add(tMenuItem():new(oIte1, cAux, , , , bBlock, , , , , , , , , .T.))
	Next
    
	oMenu:Activate(NIL, 21, oOwner)

Return



Static Function FileQry(lOpen,cTrb)
	Local cFile := ''
    
	If lOpen
		//cFile := cGetFile("Todos Arquivos|*.*|", "Abrir Query:", 0, "C:\" , .T., GETF_LOCALHARD + GETF_LOCALFLOPPY + GETF_NETWORKDRIVE)
   		cFile := cGetFile( "Arquivos query (*.query) |*.query|" , "Selecione o arquivo", 1, "C:\", .T., GETF_LOCALHARD + GETF_LOCALFLOPPY + GETF_NETWORKDRIVE )
		If ! empty(cFile)
            
            cTrb:= MemoRead(cFile)
		EndIf
	Else
		cFile := cGetFile("Arquivos query (*.query) |*.query|","Informe o arquivo", 0, "C:\", .F., GETF_LOCALHARD + GETF_LOCALFLOPPY + GETF_NETWORKDRIVE)
		If ! empty(cFile)
            If Right(Upper(cFile), 6) <> ".QUERY"
                cFile += ".query"
            EndIf
            MemoWrit(cFile, cTrb)
		EndIf
	EndIf


Return

Static Function NewPanel(nTop,nLeft,nBottom,nRight, oOwner)
	Local oPanel

	oPanel := TPanelCss():New(,,,oOwner)
	oPanel:SetCoors(TRect():New( nTop,nLeft,nBottom,nRight))

Return  oPanel

Static Function NewMemo(cText,oOwner)
	Local oMemo
    Local oFont
	Default cText := ''

    DEFINE FONT oFont NAME "Consolas" SIZE 8, 15  
	oMemo := tMultiget():new(,,bSETGET(cText),oOwner)
	oMemo:Align := CONTROL_ALIGN_ALLCLIENT
    oMemo:oFont:=oFont

Return oMemo

Static Function InitEmp(aEmpExQr,oTMsgItem, lAuto, oDlg)
	Local lRet:= .F.
	Local nX := 1
	
    Local __cEmp
    Local __cFil

	DEFAULT lAuto := .F.

	Static cUsrFs := Space(25)//"Administrador"
	Static cPswFS := Space(40)

	lRet := lAuto

	If Empty(aEmpExQr)
        OpenSm0()
        dbSelectArea("SM0")

        If !SelEmp(@__cEmp, @__cFil)
            oDlg:End()
            Return .F.
        Endif
        RpcSetType(3)
   		MsgRun("Montando Ambiente. Empresa [" + __cEmp + "] Filial [" + __cFil +"].", "Aguarde...", {||lRet := RpcSetEnv( __cEmp, __cFil,,,,,) } )
		If !lRet
			MsgAlert("Não foi possível montar o ambiente selecionado. " )
            oDlg:End()
            Return .F.
		EndIf
        __cInterNet := Nil
		
	EndIf

	If ValType(oTMsgItem)=='O'
		oTMsgItem:SetText("Empresa/Filial: [" + __cEmp + "/" + __cFil + "] ")
	EndIf

Return lRet



Static Function SelEmp(__cEmp, __cFil)
    Local oDlgLogin, oCbxEmp,  oBtnOk, oBtnCancel, oFont
    Local cEmpAtu			:= ""
    Local lOk				:= .F.
    Local aCbxEmp			:= {}

    oFont := TFont():New('Arial',, -11, .T., .T.)

	SM0->(DbGotop())
	While ! SM0->(Eof())
		Aadd(aCbxEmp,SM0->M0_CODIGO+'/'+SM0->M0_CODFIL+' - '+Alltrim(SM0->M0_NOME)+' / '+SM0->M0_FILIAL)
		SM0->(DbSkip())
	EndDo
	
	DEFINE MSDIALOG oDlgLogin FROM  0,0 TO 210,380  Pixel TITLE "Login "
	oDlgLogin:lEscClose := .F.
    @ 010,005 Say "Selecione a Empresa:" PIXEL of oDlgLogin  FONT oFont //
	@ 018,005 MSCOMBOBOX oCbxEmp VAR cEmpAtu ITEMS aCbxEmp SIZE 180,10 OF oDlgLogin PIXEL

	TButton():New( 085,100,"&Ok"       , oDlgLogin, {|| lOk := .T.  ,oDlgLogin:End() }, 38, 14,,, .F., .t., .F.,, .F.,,, .F. ) 
	TButton():New( 085,140,"&Cancelar" , oDlgLogin, {|| lOk := .F. , oDlgLogin:End() }, 38, 14,,, .F., .t., .F.,, .F.,,, .F. ) 
	ACTIVATE MSDIALOG oDlgLogin CENTERED

    If lOk
        npB     := at("/", cEmpAtu)
        __cEmp  := Left(cEmpAtu, npB - 1)
        cEmpAtu := Subs(cEmpAtu, npB + 1)
        npT     := at("-", cEmpAtu)
        __cFil  := Left(cEmpAtu, npT - 2)
    EndIf
		
Return lOk



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



Static Function Format(cFormat)
    Local cQry := ""
    Local cAux := ""
    Local cWord:= ""
    Local aQry := {}
    Local nX   := 0
    Local cLinha:= ''
    Local cByte:= ""
    Local nSelect:= 0

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
        cByte := Subs(cQry,nX,1)
        cByte2:= Subs(cQry,nX+1,1)
        cByte3:= Subs(cQry,nX+2,1)

        If Upper(cByte) $ "_ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
            cWord += cByte 
        Else
            If len(cword) > 0 .and.  ;
               (" " + cWord + "#"        $ " SELECT# FROM# WHERE#" .or.;
                " " + cWord + cByte + "#"  $ " AND # OR # NOT # INNER # LEFT # RIHGT #"   .or.;
                " " + cWord + cByte + cByte2 + cByte3 + "#" $ " ORDER BY#" ) 

                cLinha:= Left(cAux, len(cAux)-len(cWord))
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
        cLinha := If(Left(cLinha, 4) == "NOT "," " + cLinha, cLinha)
        
      //cLInha := StrTran(cLinha, "SELECT " ,  "SELECT ")
        cLinha := StrTran(cLinha, "FROM "   ,  "FROM   ")
        cLinha := StrTran(cLinha, "WHERE "  ,  "WHERE ")
        cLinha := StrTran(cLinha, " AND "   , "       AND ")
        cLinha := StrTran(cLinha, " OR "    , "        OR ")
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

Static Function SaveJson()
    Local cFile := GetTempPath() + "tidev.json"
    Local cConteudo := ""

    cConteudo := FwJsonSerialize({aQryHst, aCmdHst })
    MemoWrit(cFile, cConteudo )

Return 

Static Function LoadJson()
    Local cFile := GetTempPath() + "tidev.json"
    Local cConteudo := ""
    Local aAux := {}

    cConteudo := MemoRead(cFile)
    If ! Empty(cConteudo)
        FWJsonDeserialize(cConteudo, @aAux)
        aQryHst := aClone(aAux[1])
        aCmdHst := aClone(aAux[2])
    EndIf

Return 

