#Include "RwMake.Ch"

User Function Paralela

Local cImpressao := ""

If MsgYesNo("Inicia direto na porta")
	cImpressao := "Impressao com Set Device"
   Set( 24, "LPT1", .F. ) // Set Printer To Lpt1 e' a mesma coisa
	PrinterWin(.F.) // Impressao Dos/Windows
	PreparePrint(.F., "", .F., "LPT1") // Prepara a impressao na porta especificada
	InitPrint(1) // Inicia Cliente/Servidor
Else

// Caracteres graficos para impressora SigTron

/* cImpressao := 	Chr(27)+Chr(94)+Chr(29)+Chr(0)+Chr(2)+Chr(2)+Chr(0)+;
	          	  	Chr(0)+Chr(14)+Chr(14)+Chr(0)+Chr(0)+Chr(178)+Chr(0)+;
	          		Chr(0)+Chr(105)+Chr(210)+Chr(0)+Chr(0)+Chr(73)+Chr(146)+;
             		Chr(0)+Chr(0)+Chr(74)+Chr(148)+Chr(0)+Chr(0)+Chr(84)+;
             		Chr(168)+Chr(0)+Chr(0)+Chr(66)+Chr(66)+Chr(0)+Chr(0)+;
             		Chr(12)+Chr(12)+Chr(0)+Chr(0)+Chr(88)+Chr(176)+Chr(0)+;
             		Chr(0)+Chr(104)+Chr(208)+Chr(0)+Chr(0)+Chr(76)+Chr(152)+;
             		Chr(0)+Chr(0)+Chr(74)+Chr(148)+Chr(0)+Chr(0)+Chr(81)+;
             		Chr(162)+Chr(0)+Chr(0)+Chr(64)+Chr(64) */
             
	cImpressao := "Impressao com Set Print"
	aReturn 	  := { "Especial", 1,"Administracao", 1, 3, 1,"",1 }
	nLastKey   := 0

	// Informe no 15. parametro o nome do .DRV utilizado para esta impressora, caso nao
	// seja passado tal parametro e enviado impressao via windows
	// 16. Parametro para nao abrir a caixa para escolha da impressora

	SetPrint("SA1", "Paralela",, "", "", "", "", .F., " ", .F., "G",,,,;
					    "HPLJ4.DRV", .F.)
					    
	If nLastKey = 27
		Return
	Endif					    
	
	SetDefault(aReturn, "SA1")
Endif	

@ 2,0 PSay cImpressao + " x-x-x-x-x " + cImpressao

Ms_Flush()

Return .T.
