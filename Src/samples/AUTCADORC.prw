#Include "TOTVS.ch"

User Function AutCadOrc()
    Local nOpr    := 3
    Local aArea   := {}
    Local aHeader := {}
    Local aItems  := {}
    Local aLine   := {}

    Private lMsErroAuto := .F.
    Private lMsHelpAuto := .T.
    Private aRotina := {}

    RPCSetEnv("99", "01", NIL, NIL, "COM", NIL, {"SZO", "SZI"})
        aArea := GetArea()

        GetEnvInfo("CADORC.PRW")

        // BEGIN: INCLUDE //
        If (nOpr == 3)
            AAdd(aHeader, {"ZO_CODCLI",    "CLT006"})
            AAdd(aHeader, {"ZO_LOJA",      "10"})
            AAdd(aHeader, {"ZO_TOTGER",    671.65})

            AAdd(aLine, {"ZI_ITEM",       "001"})
            AAdd(aLine, {"ZI_CODPROD",    "PRDT0023"})
            AAdd(aLine, {"ZI_UNIT",       671.65})
            AAdd(aLine, {"ZI_QTDE",       1})

            AAdd(aItems, aLine)
        EndIf
        // END: INCLUDE //

        aRotina := FwLoadMenuDef("CADORC")
        FwMVCRotAuto(FwLoadModel("CadOrc"), "SZO", nOpr, {{"SZOMASTER", aHeader}, {"SZIDETAIL", aItems}})

		If (lMsErroAuto == .T.)
			MostraErro()

			ConOut(Repl("-", 80))
			ConOut(PadC("CADORC automatic routine ended with error ", 80))
			ConOut(PadC("Ends at: " + Time(), 80))
			ConOut(Repl("-", 80))
		Else
			ConOut(Repl("-", 80))
			ConOut(PadC("CADORC automatic routine successfully ended", 80))
			ConOut(PadC("Ends at: " + Time(), 80))
			ConOut(Repl("-", 80))
		EndIf

        RestArea(aArea)
    RPCClearEnv()
Return (NIL)

/*----------------------------------------------------------*\
| DESCRIPTION: This function returns environment and routine |
| information without GUI use.                               |
|------------------------------------------------------------|
| AUTHOR: Guilherme Bigois       |      MODIFIED: 2018/05/23 |
\*----------------------------------------------------------*/

Static Function GetEnvInfo(cRoutine)
	Local aRPO := {}
    Default cRoutine := ""

    aRPO := GetApoInfo(cRoutine)

    If (Empty(aRPO) == .F.)
        ConOut(Repl("-", 80))
        ConOut(PadC("Routine: " + aRPO[1], 80))
        ConOut(PadC("Date: " + DToC(aRPO[4]) + " " + aRPO[5], 80))
        ConOut(Repl("-", 80))
        ConOut(PadC("SmartClient: " + GetBuild(.T.), 80))
        ConOut(PadC("AppServer: " + GetBuild(.F.), 80))
        ConOut(PadC("DbAccess: " + TCAPIBuild() + "/MSSQL" , 80))
		ConOut(Repl("-", 80))
        ConOut(PadC("Started at: " + Time(), 80))
        ConOut(Repl("-", 80))
    Else
        ConOut(Repl("-", 80))
        ConOut(PadC("An error occurred while searching routine data with GetEnvInfo()", 80))
        ConOut(Repl("-", 80))
    EndIf
Return (NIL)
