#include "protheus.ch"
#include "atf.ch"

#define ATF_LAST_UPDATED		"03/11/2014"

#DEFINE X3_USADO_EMUSO 			"ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ†"
#DEFINE X3_USADO_NAOUSADO 		"ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
#DEFINE X3_USADO_OBRIGATO 		"ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ∞"   
#DEFINE X3_NAOOBRIGAT 			"¡Ä" 
#DEFINE X3_RESER 				   "˛¿"  
#DEFINE X3_RESEROBRIG 			"ÉÄ"  
#DEFINE X3_RESER_NUMERICO 		"¯«" 
#DEFINE X3_RES					"ÄÄ" 
#DEFINE SIMPLES Char( 39 )
#DEFINE DUPLAS  Char( 34 )
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ UPDATF01 ≥ Autor ≥ --------------------- ≥ Data ≥ 23/05/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÑo ≥ Executa as funcoes de atualizacao do ambiente SIGAATF      ≥±±                
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Sintaxe   ≥ UPDFATF    - PARA EXECUCAO PELA TELA DE ABERTURA DO REMOTE ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Parametros≥ Nenhum                                                     ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/

Main Function UPDATF01()
	SIGATF01()
Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ UPDATF   ≥ Autor ≥ --------------------- ≥ Data ≥ 23/05/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÑo ≥ Executa as funcoes de atualizacao do ambiente SIGAATF      ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Sintaxe   ≥ UPDFATF    - PARA EXECUCAO PELA TELA DE ABERTURA DO REMOTE ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Parametros≥ Nenhum                                                     ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
// Compatibilizacao necess·ria devido a alteraÁıes no Build do Protheus
User Function UPDATF01()
	SIGATF01()
Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥UPDSIGAATF≥ Autor ≥ --------------------- ≥ Data ≥ 23/05/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÑo ≥ Executa as funcoes de atualizacao do ambiente SIGAATF      ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Sintaxe   ≥ UPDSIGAATF - PARA EXECUCAO PELA TELA DE ABERTURA DO REMOTE ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Parametros≥ Nenhum                                                     ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
Static Function SIGATF01()

cArqEmp := "SigaMat.Emp"
nModulo		:= 44
__cInterNet := Nil     

PRIVATE cMens := STR0001 + CRLF +; // //"Atencao !"
					STR0002 + CRLF +; // //"Esta rotina ira atualizar os dicionarios de dados"
					STR0003 + CRLF +; // //"para a utilizacao das novas funcionalidades do SIGAATF."
					STR0004 // //"Nao deve existir usuarios utilizando o sistema durante a atualizacao!"

PRIVATE cMessage
PRIVATE aArqUpd	 := {}
PRIVATE aREOPEN	 := {}
PRIVATE __lPyme  := .F.

#IFDEF TOP
	TCInternal(5,'*OFF') //-- Desliga Refresh no Lock do Top
#ENDIF

Set Dele On

ATFOpenSm0()
DbGoTop()

lHistorico 	:= MsgYesNo(STR0048 + ATF_LAST_UPDATED + "? "+ CRLF + cMens, STR0001)  //"Deseja efetuar a atualizacao do Dicionario do SIGAATF v."###"AtenÁ„o"
lEmpenho	:= .F.
lAtuMnu		:= .F.

DEFINE WINDOW oMainWnd FROM 0,0 TO 01,1 TITLE STR0049 //"Atualizacao do Dicionario"

ACTIVATE WINDOW oMainWnd ICONIZED;
ON INIT If(lHistorico,(Processa({|lEnd| ATFProc(@lEnd)},STR0010,STR0011,.F.) , oMainWnd:End()),oMainWnd:End()) //### //"Processando"###"Aguarde , processando preparacao dos arquivos"


Return
/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ ATFPROC  ≥ Autor ≥ --------------------- ≥ Data ≥ 23/05/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Funcao de processamento da gravacao dos arquivos           ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ATFProc(lEnd)
Local cTexto	:= ""
Local cFile		:= ""
Local cMask		:= STR0012 //"Arquivos Texto (*.TXT) |*.txt|"
Local cCodigo	:= "DM"
Local nRecno	:= 0
Local nX		:= 0
Local nRecAtu	:= 0
Local aAreaSM0	:= {}    
Local lRet		:= .T.
Local aRetorno  := {}
Local aChkHelp  := {}   
Local cEmpX     := ""

Local nInc		:= 0
Local aSM0		:= AdmAbreSM0()

ProcRegua(1)
IncProc(STR0013) //"Verificando integridade dos dicionarios.... "

OpenSm0Excl()

For nInc := 1 To Len( aSM0 )
	RpcSetType(3)
	RpcSetEnv( aSM0[nInc][1], aSM0[nInc][2] )
	
	RpcClearEnv()
	OpenSm0Excl()
Next

For nInc := 1 To Len( aSM0 )
	RpcSetType(3)
	RpcSetEnv( aSM0[nInc][1], aSM0[nInc][2] )
	
	If aSM0[nInc][1] != cEmpX
		cEmpX := aSM0[nInc][1]
	Else
		RpcClearEnv()
		Loop 
	EndIf 
	
	If !VdlAtf01(@cTexto)
		Exit
	EndIf   

	cTexto += Replicate("-",128)+CRLF
	cTexto += STR0014 + aSM0[nInc][1] + " " + STR0015 + aSM0[nInc][2] + "-" + aSM0[nInc][6] + CRLF //"Empresa : "###" Filial : "
	ProcRegua(8)
    
	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Atualiza as perguntes de relatorios.≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	IncProc(STR0073) // //"Analisando Grupo de Campos..."
	cTexto += ATFAtuSXG()
	
	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Atualiza o dicionario de arquivos.≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	IncProc(STR0017) // //"Analisando Dicionario de Arquivos..."
	cTexto += ATFAtuSX2()
	
	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Atualiza o dicionario de dados.≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	IncProc(STR0018) // //"Analisando Dicionario de Dados..."
	aRetorno := ATFAtuSX3()
	aAdd(aChkHelp, {"SX3",aRetorno[1]})
	cTexto += aRetorno[2]

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Atualiza os parametros.≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	IncProc(STR0019) // // //"Analisando Tabelas..."
	cTexto += ATFAtuSX5()

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Atualiza os parametros.≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	IncProc(STR0020) // //"Analisando Parametros..."
	cTexto += ATFAtuSX6()

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Atualiza os gatilhos.≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	IncProc(STR0021) // //"Analisando Gatilhos..."
	cTexto += ATFAtuSX7()

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Atualiza os folder's de cadastro.≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	IncProc(STR0022) //"Analisando Folder de Cadastro..."
	cTexto += ATFAtuSXA()

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Atualiza as consultas padroes.≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	IncProc(STR0023) // //"Analisando Consultas Padroes..."
	cTexto += ATFAtuSXB()

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Atualiza helps de campos.      ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	IncProc(STR0057) // //"Atualizando helps de campos..."
	cTexto += ATFAtuHlp(aChkHelp)
	
	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Atualiza relacionamento        ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	IncProc(STR0076) //"Atualizando relacionamento de tabelas" 
	cTexto += ATFAtuSX9()


	__SetX31Mode(.F.)
	For nX := 1 To Len(aArqUpd)
		IncProc(STR0025+aArqUpd[nx]+"]") //"Atualizando estruturas. Aguarde... ["
		If Select(aArqUpd[nx])>0
			dbSelecTArea(aArqUpd[nx])
			dbCloseArea()
		EndIf
		X31UpdTable(aArqUpd[nx])
		If __GetX31Error()
			Alert(__GetX31Trace())
			Aviso(STR0001,STR0027+ aArqUpd[nx] + STR0028,{STR0029},2) //"Atencao!"###"Ocorreu um erro desconhecido durante a atualizacao da tabela : "###". Verifique a integridade do dicionario e da tabela."###"Continuar"
			cTexto += STR0030+aArqUpd[nx] +CRLF //"Ocorreu um erro desconhecido durante a atualizacao da estrutura da tabela : "
		EndIf
	Next nX

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Atualiza os indices.							 ≥
	//|Neste ponto garante que os campos necessarios |
	//|aos indices existem na base de dados          |
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	ProcRegua(2)
	IncProc(STR0024) // //"Analisando Indices..."
	cTexto += ATFAtuSIX()

	__SetX31Mode(.F.)
	For nX := 1 To Len(aArqUpd)
		IncProc(STR0025+aArqUpd[nx]+"]") //"Atualizando estruturas. Aguarde... ["
		If Select(aArqUpd[nx])>0
			dbSelecTArea(aArqUpd[nx])
			dbCloseArea()
		EndIf
		X31UpdTable(aArqUpd[nx])
		If __GetX31Error()
			Alert(__GetX31Trace())
			Aviso(STR0001,STR0027+ aArqUpd[nx] + STR0028,{STR0029},2) //"Atencao!"###"Ocorreu um erro desconhecido durante a atualizacao da tabela : "###". Verifique a integridade do dicionario e da tabela."###"Continuar"
			cTexto += STR0030+aArqUpd[nx] +CRLF //"Ocorreu um erro desconhecido durante a atualizacao da estrutura da tabela : "
		EndIf
	Next nX

	If FindFunction("ATFXTabela") 
		IncProc()
		ATFXTabela()
	EndIf
	
	// Realiza a compatibilizaÁ„o dos indice de depreciaÁ„o antigo
	IncProc()
	FNICompat()

	RpcClearEnv()
	OpenSm0Excl()
Next

RpcSetEnv( aSM0[1][1], aSM0[1][2],,,,, { "AE1" } )

cTexto := STR0031+CRLF+cTexto //"Log da atualizacao "
__cFileLog := MemoWrite(Criatrab(,.f.)+".LOG",cTexto)
DEFINE FONT oFont NAME "Mono AS" SIZE 5,12   //6,15
DEFINE MSDIALOG oDlg TITLE STR0032 From 3,0 to 340,417 PIXEL //"Atualizacao concluida."
@ 5,5 GET oMemo  VAR cTexto MEMO SIZE 200,145 OF oDlg PIXEL
oMemo:bRClicked := {||AllwaysTrue()}
oMemo:oFont:=oFont

DEFINE SBUTTON  FROM 153,175 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg PIXEL //Apaga
DEFINE SBUTTON  FROM 153,145 TYPE 13 ACTION (cFile:=cGetFile(cMask,""),If(cFile="",.t.,MemoWrite(cFile,cTexto))) ENABLE OF oDlg PIXEL //Salva e Apaga //"Salvar Como..."


ACTIVATE MSDIALOG oDlg CENTER


Return(.T.)

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ATFAtuSIX ≥ Autor ≥ --------------------- ≥ Data ≥ 23/05/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Funcao de processamento da gravacao do SIX                 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ATFAtuSIX()

//INDICE ORDEM CHAVE DESCRICAO DESCSPA DESCENG PROPRI F3 NICKNAME
Local cTexto 	:= ''
Local lSIX  	:= .F.
Local lNew   	:= .F.
Local aSIX   	:= {}
Local aEstrut	:= {}
Local i      	:= 0
Local j      	:= 0
Local cAlias 	:= ''

If (cPaisLoc == "BRA")
	aEstrut:= {"INDICE","ORDEM","CHAVE","DESCRICAO","DESCSPA","DESCENG","PROPRI","F3","NICKNAME","SHOWPESQ"}
Else
	aEstrut:= {"INDICE","ORDEM","CHAVE","DESCRICAO","DESCSPA","DESCENG","PROPRI","F3","NICKNAME","SHOWPESQ"}
EndIf

aAdd( aSIX, { 'SN1', '9', 'N1_FILIAL+N1_PROJETO+N1_PROJREV+N1_PROJETP+N1_PROJITE+N1_CBASE+N1_ITEM', 'Cod. Projeto + Rev. Projeto + Etapa Prj + Item projeto + Cod. do Bem +', 'Cod Proyecto + Rev.Proyecto + Etapa Proyec + Item proyect + Cod. de Bi', 'Project Code + Project Rev. + Proj. Stage + Proj. Item + Asset cd + It', 'S', '', '','N' } )

//
// Tabela FNB
//
aAdd( aSIX, {'FNB','1','FNB_FILIAL+FNB_CODPRJ+FNB_REVIS','Codigo + Revisao','Codigo + Revision','Code + Revision','','','','S'} ) 
aAdd( aSIX, {'FNB','2','FNB_FILIAL+FNB_CBASE+FNB_CODPRJ+FNB_REVIS','Cod Base ATF + Codigo + Revisao','Cod Base ATF + Codigo + Revision','F.A.BaseCode + Code + Revision','','','','S'} )

//
// Tabela FNC
//
aAdd( aSIX, {'FNC','1','FNC_FILIAL+FNC_CODPRJ+FNC_REVIS+FNC_ETAPA','Projeto + Revisao + Etapa','Proyecto + Revision + Etapa','Project + Review + Stage','','','','S'} )

//
// Tabela FND
//
aAdd( aSIX, {'FND','1','FND_FILIAL+FND_CODPRJ+FND_REVIS+FND_ETAPA+FND_ITEM','Projeto + Revisao + Etapa + Item','Proyecto + Revision + Etapa + Item','Project + Revision + Stage + Item','','','','S'} )

//
// Tabela FNE
//
aAdd( aSIX, {'FNE','1','FNE_FILIAL+FNE_CODPRJ+FNE_REVIS+FNE_ETAPA+FNE_ITEM+FNE_LINHA','Projeto + Revisao + Etapa + Item Etapa + Linha','Proyecto + Revision + Etapa + Item Etapa + Linea','Project + Revision + Stage + Stage Item + Line','','','','S'} )
aAdd( aSIX, {'FNE','2','FNE_FILIAL+FNE_CODPRJ+FNE_REVIS+FNE_ETAPA+FNE_ITEM+FNE_TPATF+FNE_TPSALD','Projeto + Revisao + Etapa + Item Etapa + Tipo ATF + Tipo Saldo','Proyecto + Revision + Etapa + Item Etapa + Tipo ATF + Tipo Saldo','Project + Revision + Stage + Stage Item + FA Type + Balance Type','','','','S'} )

//
// Tabela FNJ
//
aAdd( aSIX, {'FNJ','1','FNJ_FILIAL+FNJ_CODPRJ+FNJ_REVIS+FNJ_ETAPA+FNJ_ITEM+FNJ_LINHA+FNJ_TAFPRJ+FNJ_SLDPRJ+FNJ_ITRELA','Projeto + Revisao + Etapa + Item Etapa + Linha + Tipo ATF Prj + Tipo S','Proyecto + Revision + Etapa + Item Etapa + Linea + Tipo ATF Pry + Tipo','Project + Review + Stage + Stage Item + Row + Prj Asset Tp + Prj Bal T','S','','','S'} )
aAdd( aSIX, {'FNJ','2','FNJ_FILIAL+FNJ_CODPRJ+FNJ_REVIS+FNJ_ETAPA+FNJ_ITEM+FNJ_LINHA+FNJ_TAFPRJ+FNJ_SLDPRJ+FNJ_CBAEXE+FNJ_ITEXE+FNJ_TAFEXE+FNJ_SLDEXE','Projeto + Revisao + Etapa + Item Etapa + Linha + Tipo ATF Prj + Tipo S','Proyecto + Revision + Etapa + Item Etapa + Linea + Tipo ATF Pry + Tipo','Project + Review + Stage + Stage Item + Row + Prj Asset Tp + Prj Bal T','S','','','S'} )
aAdd( aSIX, {'FNJ','3','FNJ_FILIAL+FNJ_CBAEXE+FNJ_ITEXE+FNJ_TAFEXE+FNJ_SLDEXE+FNJ_CODPRJ+FNJ_REVIS+FNJ_ETAPA+FNJ_ITEM+FNJ_LINHA+FNJ_TAFPRJ+FNJ_SLDPRJ','C Base Exec + Item Exec + Tipo ATF Exe + Tipo SLD Exe + Projeto + Revisao + Etap','C Base Ejec + Item Ejec + Tipo ATF Eje + Tipo SLD Eje + Proyecto + Revision + Eta','Exec Base C + Exec Item + Exe Asset Tp + Exec Bal Tp + Project + Review + Stage','S','','','S'} )


//AVP - ATIVO
//
//Tabela FNF - Processos de AVP
//
aAdd( aSIX, {'FNF','1','FNF_FILIAL+FNF_CBASE+FNF_ITEM+FNF_TIPO+FNF_SEQ+FNF_TPSALD+FNF_REVIS+FNF_SEQAVP+FNF_MOEDA+DTOS(FNF_DTAVP)','Cod.Ativo+Item Ativo+Tipo ATF+Sequencia+Tipo Saldo+Revisao+Sequencia AVP+Moeda+Data AVP','Cod. de Bien + Item + Tipo Bien + Sec.Item ACT + Tp Sld Item + Revisio','Asset Code + Item + Asset Type + ATF ItemSequ + AsstBalancTp + Revisio','S','','','S'} )
aAdd( aSIX, {'FNF','2','FNF_FILIAL+FNF_CBASE+FNF_ITEM+FNF_TIPO+FNF_SEQ+FNF_TPSALD+FNF_MOEDA+FNF_TPMOV+FNF_STATUS','Cod.Base+Item+Tipo+Sequencia+Tipo Saldo+Revisao+Moeda+Tp.Movto Avp+Status Movto','Cod. de Bien + Item + Tipo Bien + Sec.Item ACT + Tp Sld Item + Moneda','Asset Code + Item + Asset Type + ATF ItemSequ + AsstBalancTp + AVP Cur','S','','','S'} )
aAdd( aSIX, {'FNF','3','FNF_FILIAL+FNF_IDPROC+FNF_TPMOV+FNF_STATUS','Id. Processo+Tipo Movto+Status','Id.Proc.AVP + Tp. Movto. + Estatus','AVP ProcID + TransctnType + Status','S','','','S'} )
aAdd( aSIX, {'FNF','4','FNF_FILIAL+FNF_CBASE+FNF_ITEM+FNF_TPMOV+FNF_STATUS','Cod.Ativo+Item Ativo+Tipo Movto+Status','Cod. de Bien + Item + Tp. Movto. + Estatus','Asset Code + Item + TransctnType + Status','S','','','S'} )
aAdd( aSIX, {'FNF','5','FNF_FILIAL+FNF_IDMVAF+FNF_CBASE+FNF_ITEM+FNF_TPSALD+FNF_TPMOV+FNF_STATUS','Id.Movt.ATF + Cod. do Bem + Item + Tp Sld Item + Tp. Movto. + Status  ','Id.Movt.ATF + Cod. de Bien + Item + Tp Sld Item + Tp. Movto. + Estatus','ATF Trsn. ID + Asset Code + Item + AsstBalancTp + TransctnType + Statu','S','','','S'} )
aAdd( aSIX, {'FNF','6','FNF_FILIAL+FNF_IDPROC+FNF_CBASE+FNF_ITEM+FNF_TPSALD+FNF_TPMOV+FNF_STATUS','Id. Processo+Cod.Ativo+Item Ativo+Tipo Saldo+Tipo Movto+Status','Id. Processo + Cod. de Bien + Item + Tp Sld Item + Tp. Movto. + Estatus','Process ID + Asset Code + Item + AsstBalancTp + TransctnType + Statu','S','','','S'} )

//
// Tabela SN3	
//
aAdd( aSIX, {'SN3','B','N3_FILIAL+N3_CBASE+N3_ITEM+N3_TIPO+N3_BAIXA+N3_TPSALDO+N3_SEQ+N3_SEQREAV','Cod Base Bem + Codigo Item + Tipo Ativo + Ocor Baixa + Tipo Saldo + Seq Aquisic + Seq Reaval.','Base de Bien + Codigo Item + Tipo Activo + Ocur Baja + Tipo Saldo + Sec Adquis + Sec Reaval.','Asset Bs.Cd. + Item Code + Asset Type + Wr/off Event + Tp.Balance + Acq.Sequence + ReevaluSeqnc','S','','','S'} )

//
//Tabela FNP - Processamento de apropriacao de AVP (Cabecalho)
//
aAdd( aSIX, {'FNP','1','FNP_FILIAL+DTOS(FNP_DTPROC)+FNP_IDPROC','Data Processo+ID Processo','Fecha Proc + Id.Proc.AVP','ProcssngDate + AVP Proc ID','S','','','S'} )
aAdd( aSIX, {'FNP','2','FNP_FILIAL+FNP_IDPROC','ID Processo','Id.Proc.AVP','AVP Proc ID','S','','','S'} )

//INDICE DA TABELA FNI
Aadd(aSIX,{"FNI","1","FNI_FILIAL+FNI_CODIND+FNI_REVIS","Cod.Indice + Revisao","Cod.Indice + Revision","Index Code + Review","S","","","S"})


//INDICES DA TABELA FNT //INCLUIDO DIA 20/09/11
Aadd(aSIX,{"FNT","1","FNT_FILIAL+FNT_CODIND+FNT_REVIS+DTOS(FNT_DATA)","CÛdigo do Õndice+Revisao+Data","Cod.Indice + Rev.Ts.Ind. + Fch.Ts.Ind.","Index Code + Ind.Rate Rev + IndxRateDate","S","","","S"})
Aadd(aSIX,{	"FNT","2","FNT_FILIAL+DTOS(FNT_DATA)+FNT_CODIND+FNT_REVIS","Data+CÛdigo do Õndice+Revisao","Fch.Ts.Ind. + Cod.Indice + Rev.Ts.Ind.","IndxRateDate + Index Code + Ind.Rate Rev","S","","","S"})
AADD(aSIX,{"FNT","3","FNT_FILIAL+FNT_CODIND+DTOS(FNT_DATA)+FNT_REVIS","Cod.Õndice + Dt.Tx.Ind. + Rev.Tx.Ind.","Cod.Indice + Fch.Ts.Ind. + Rev.Ts.Ind.","Index Code + IndxRateDate + Ind.Rate Rev","S","","","S" })

//Tabela CV8 - Log de processamento
Aadd(aSIX,{	"CV8","4","CV8_FILIAL+CV8_PROC+CV8_SBPROC+CV8_USER+DTOS(CV8_DATA)+CV8_HORA","Processo + Sub Processo + Usuario + Data + Hora","Proceso + Sub Proceso + Usuario + Fecha + Hora","Process + Subprocess + User + Date + Occur.Time","S","","","S"})
Aadd(aSIX,{	"CV8","5","CV8_FILIAL+CV8_IDMOV", "ID Movtos","ID Movtos","Transctns ID","S","","","S"})	

//
//Tabela FNH - OperaÁıes com controle de aprovaÁ„o
//
aAdd( aSIX, {'FNH','1','FNH_FILIAL+FNH_ROTINA+FNH_OPER','Rotina + OperaÁ„o','Rutina + Operacion','Routine + Operation','S','','','S'} )

//
//Tabela FNK - Alcadas de aprovacao por operacao
//
aAdd( aSIX, {'FNK','1','FNK_FILIAL+FNK_ROTINA+FNK_REVIS','Rotina + Revis„o','Rutina + Revision','Routine + Revision','S','','','S'} )

//
//Tabela FNL - Itens alcada de aprovacao por operacao
//
aAdd( aSIX, {'FNL','1','FNL_FILIAL+FNL_ROTINA+FNL_REVIS+FNL_OPER+FNL_CODAPR','Rotina + Revis„o + OperaÁ„o + Aprovador','Rutina + Revision + Operacion + Aprobador','Routine + Revision + Operation + Approver','S','','','S'} )
aAdd( aSIX, {'FNL','2','FNL_FILIAL+FNL_ROTINA+FNL_OPER+FNL_STATUS','Rotina + OperaÁ„o + Status','Rutina + Operacion + Estatus','Routine + Operation + Status','S','','','S'} )
//
//Tabela FNM - Movimentos de aprovaÁ„o e histÛricos de alteraÁıes
//
aAdd( aSIX, {'FNM','1','FNM_FILIAL+FNM_IDMOV','ID Movimen.','ID Movimien.','TransactnsID','S','','','S'} )
aAdd( aSIX, {'FNM','2','FNM_FILIAL+FNM_ROTINA+FNM_REVIS+FNM_OPER+DTOS(FNM_DATA)+FNM_IDMOV','Rotina + Revis„o + OperaÁ„o + Data movimen + ID Movimen.','Rutina + Revision + Operacion + Fecha movimi + ID Movimien.','Routine + Revision + Operation + TransctnDate + TransactnsID','S','','','S'} )
aAdd( aSIX, {'FNM','3','FNM_FILIAL+DTOS(FNM_DATA)+FNM_ROTINA+FNM_OPER+FNM_REVIS+FNM_IDMOV','Data movimen + Rotina + OperaÁ„o + Revis„o + ID Movimen.','Fecha movimi + Rutina + Operacion + Revision + ID Movimien.','TransctnDate + Routine + Operation + Revision + TransactnsID','S','','','S'} )
aAdd( aSIX, {'FNM','4','FNM_FILIAL+FNM_CODSOL+FNM_ROTINA+FNM_OPER+FNM_REVIS+DTOS(FNM_DATA)+FNM_IDMOV','Solicitante + Rotina + OperaÁ„o + Revis„o + Data movimen + ID Movimen.','Solicitante + Rutina + Operacion + Revision + Fecha movimi + ID Movimi','Requester + Routine + Operation + Revision + TransctnDate + Transactns','S','','','S'} )
aAdd( aSIX, {'FNM','5','FNM_FILIAL+FNM_CODAPR+FNM_ROTINA+FNM_OPER+FNM_REVIS+DTOS(FNM_DATA)+FNM_IDMOV','Aprovador + Rotina + OperaÁ„o + Revis„o + Data movimen + ID Movimen.','Aprobador + Rutina + Operacion + Revision + Fecha movimi + ID Movimien','Approver + Routine + Operation + Revision + TransctnDate + TransactnsI','S','','','S'} )
aAdd( aSIX, {'FNM','6','FNM_FILIAL+FNM_TABORI+FNM_IDMOV'                                             ,'Tabe. Origem + ID Movimen.'                                            ,'Tab. Origen + ID Movimien.'                                            ,'Origin Table + TransactnsID'                                           ,'S','','','S'} )
//
//Tabela FNN - Processo Constituicao Provisorio
//
aAdd( aSIX, {'FNN','1','FNN_FILIAL+DTOS(FNN_DTPROC)+FNN_IDPROC','Data Proc. + Processo','Fecha Proc + Proceso','Proc. Date + Process','S','','','S'} )
aAdd( aSIX, {'FNN','2','FNN_FILIAL+FNN_IDPROC','Processo','Proceso','Process','S','','','S'} )
//
	//Tabela FNO - Movto. Constituicao Provis„o
//
aAdd( aSIX, {'FNO','1','FNO_FILIAL+FNO_IDPROC+FNO_CBASE+FNO_ITEM+FNO_BASESP+FNO_ITEMSP','Processo + Cod.Base Prv + Item Prv + Cod.base Sup + Item Sup.','Proceso + Cod.Base Prv + Item Prv + Cod.base Sup + Item Sup.','Process + Prv Base Cd + Prov. Item + Sup.Base Cod + Sup. Item','S','','','S'} )
aAdd( aSIX, {'FNO','2','FNO_FILIAL+FNO_IDMVAF+FNO_BASESP+FNO_ITEMSP','Id.Movt.ATF + Cod.base Sup + Item Sup.','Id.Movt.ATF + Cod.base Sup + Item Sup.','ATF Trans.ID + Sup.Base Cod + Sup. Item','S','','','S'} )
aAdd( aSIX, {'FNO','3','FNO_FILIAL+FNO_BASESP+FNO_ITEMSP','Cod.base Sup + Item Sup.','Cod.base Sup + Item Sup.','Sup.Base Cod + Sup. Item','S','','','S'} )


//Tabela FNQ - Cadastro de regras de margem gerencial
Aadd(aSIX,{"FNQ","1","FNQ_FILIAL+FNQ_COD+FNQ_REV","CÛdigo Margem+Revisao","CÛdigo Margem+Revisao","CÛdigo Margem+Revisao","S","","","S"})
Aadd(aSIX,{"FNQ","2","FNQ_FILIAL+FNQ_COD+FNQ_STATUS","CÛdigo Margem+Status","CÛdigo Margem+Status","CÛdigo Margem+Status","S","","","S"})

//
// Tabela FN1
//
aAdd( aSIX, {'FN1','1','FN1_FILIAL+FN1_PROC','Cod Processo','Cod Proceso','Process Cd','S','','','S'} )
aAdd( aSIX, {'FN1','2','FN1_FILIAL+DTOS(FN1_DATA)+FN1_PROC','Data Proc + Cod Processo','Fc Proc + Cod Proceso','Proc Date + Process Cd','S','','','S'} )
aAdd( aSIX, {'FN1','3','FN1_FILIAL+FN1_DESC','Descricao','Descripcion','Description','S','','','S'} )
//
// Tabela FN2
//
aAdd( aSIX, {'FN2','1','FN2_FILIAL+FN2_PROC+FN2_LINHA','Cod Processo + Linha','Cod Proceso + Linea','Process Cd + Line','S','','','S'} )
//
// Tabela FN3
//
aAdd( aSIX, {'FN3','1','FN3_FILIAL+FN3_PROC+FN3_LINHA','Cod Processo + Linha','Cod Proceso + Linea','Process Cd + Line','S','','','S'} )
//
// Tabela FN4
//
aAdd( aSIX, {'FN4','1','FN4_FILIAL+FN4_PROC+FN4_LINHA','Cod Processo + Linha','Cod Proceso + Linea','Process Cd + Line','S','','','S'} )
//
// Tabela FN5
//
aAdd( aSIX, {'FN5','1','FN5_FILIAL+FN5_PROC+FN5_LINHA','Cod Processo + Linha','Cod Proceso + Linea','Process Cd + Line','S','','','S'} )
aAdd( aSIX, {'FN5','2','FN5_FILIAL+FN5_CBAORI+FN5_ITEORI+FN5_CBACEM+FN5_ITECEM+FN5_PROC+FN5_LINHA','C Base Orig + Item Origem + C Base Emp + Item Cust Em + Cod Processo +','C Base Orig + Item Origen + C Base Emp + Item Cost Em + Cod Proceso +','Orig Base C + Origin Item + Comp Base C +  + Process Cd + Line','S','','','S'} )
aAdd( aSIX, {'FN5','3','FN5_FILIAL+FN5_CBACEM+FN5_ITECEM+FN5_CBAORI+FN5_ITEORI+FN5_PROC+FN5_LINHA','C Base Emp + Item Cust Em + C Base Orig + Item Origem + Cod Processo +','C Base Emp + Item Cost Em + C Base Orig + Item Origen + Cod Proceso +','Comp Base C +  + Orig Base C + Origin Item + Process Cd + Line','S','','','S'} )
aAdd( aSIX, {'FN5','4','FN5_FILIAL+FN5_CBAORI+FN5_ITEORI+FN5_TIPORI+FN5_SLDORI','C Base Orig + Item Origem + Tipo de orig + Tp Sld Ori','C Base Orig + Item Origen + Tipo de orig + Tp Sld Ori ','Orig Base C + Origin Item + Orig type + Ori. Bal. Tp','S','','','S'} )
aAdd( aSIX, {'FN5','5','FN5_FILIAL+FN5_CBACEM+FN5_ITECEM+FN5_TIPEMP+FN5_SLDEMP','C Base Emp + Item Cust Em + Tipo C Emp + Tp Sld Emp','C Base Emp + Item Cost Em + Tipo C Emp + Tp Sld Emp ','Comp Base C + Emp.Cos.Item + Comp C Type + Emp. Bal. Tp','S','','','S'} )
//
// Tabela FNU - Controle de Provis„o
//
aAdd( aSIX, {'FNU','1','FNU_FILIAL+FNU_COD+FNU_REV','CÛdigo + Revis„o','Codigo + Revision','Code + Review','S','','','S'} )
//
// Tabela FNV - Item da Provis„o
//
aAdd( aSIX, {'FNV','1','FNV_FILIAL+FNV_COD+FNV_REV+FNV_ITEM','CÛd. Provis. + Rev. Provis. + Item','Cod. Provis. + Rev. Provis. + Item','Provis. Code + Provis. Rev. + Item','S','','','S'} )
aAdd( aSIX, {'FNV','2','FNV_FILIAL+FNV_COD+FNV_REV+DTOS(FNV_DTFIN)','CÛd. Provis. + Rev. Provis. + Data Final','Cod. Provis. + Rev. Provis. + Fecha Final','Provis. Code + Provis. Rev. + End Date','S','','','S'} )
//
// Tabela FNW - Movimentos da Provis„o
//
aAdd( aSIX, {'FNW','1','FNW_FILIAL+FNW_COD+FNW_REV+FNW_PERIOD+FNW_OCOR','CÛdigo + Revis„o + Periodo + OcorrÍncia','Codigo + Revision + Periodo + Ocurrencia','Code + Review + Period + Occurrence','S','','','S'} )
aAdd( aSIX, {'FNW','2','FNW_FILIAL+FNW_COD+FNW_REV+DTOS(FNW_DTMOV)+FNW_OCOR','CÛdigo + Revis„o + Dt. Movto. + OcorrÍncia','Codigo + Revision + Fc Mov. + Ocurrencia','Code + Review + Trans. Dt. + Occurrence','S','','','S'} )
aAdd( aSIX, {'FNW','3','FNW_FILIAL+FNW_IDMOV','Id. Movto.','Id. Mov.','Trans. Id.','S','','','S'} )
//
// Tabela FNX - RealizaÁ„o da Provis„o
//
aAdd( aSIX, {'FNX','1','FNX_FILIAL+FNX_COD+FNX_REV+DTOS(FNX_DTMOV)','CÛdigo + Revis„o + Dt. Movto.','Codigo + Revision + Fc. Mov.','Code + Review + Trans. Dt.','S','','','S'} )
aAdd( aSIX, {'FNX','2','FNX_FILIAL+FNX_CBASE+FNX_ITEM+FNX_TIPO+FNX_TPSALD+FNX_FILATF','CÛdigo Base + Item + Tipo + Tipo Saldo','Codigo Base + Item + Tipo + Tipo Saldo','Base Code + Item + Type + Balance Type','S','','','S'} )
aAdd( aSIX, {'FNX','3','FNX_FILIAL+FNX_COD+FNX_REV+FNX_LINHA+FNX_CBASE+FNX_ITEM+FNX_TIPO+FNX_TPSALD+FNX_FILATF','CÛdigo + Revis„o + Linha + CÛdigo Base + Item + Tipo + Tipo Saldo','Codigo + Revision + Linea + Codigo Base + Item + Tipo + Tipo Saldo','Code + Review + Line + Base Code + Item + Type + Balance Type','S','','','S'} )
aAdd( aSIX, {'FNX','4','FNX_FILIAL+FNX_COD+FNX_REV+DTOS(FNX_DTCONT)','CÛdigo + Revis„o + Data Efetiva ','Codigo + Revision + Fecha Efect.','Code + Review + Confirm. Dt.','S','','','S'} )

//
// Atualizando dicion·rio
//

dbSelectArea("SIX")
dbSetOrder(1)
ProcRegua(Len(aSIX))
IncProc(STR0052) // // "Apagando Indices atualizados..."
cTabOk	:= ""

For i := 1 To Len( aSIX )
	If SIX->( MsSeek( aSIX[i,1] + aSIX[i,2] ) ) .and. !( aSIX[i,1] $ cTabOk ) .and. SX2->( MsSeek( aSIX[i,1] ) )
		cTabOk += aSIX[i,1] + "/"
		cArquivo := AllTrim( SX2->X2_PATH ) + AllTrim( SX2->X2_ARQUIVO )
	
		// Abrindo as tabelas em modo Exclusivo
		If Select( aSIX[i,1] ) > 0
			(aSIX[i,1])->( DbCloseArea() )
		EndIf
			// Acrescenta na lista de atualizacoes
		if ASCAN( aArqUpd, aSIX[i,1] ) == 0
			aAdd( aArqUpd, aSIX[i,1] )
		endif
			ChkFile( aSIX[i,1], .T., aSIX[i,1] )
		dbSelectArea( aSIX[i,1] )
		X31IndErase( aSIX[i,1], cArquivo, __cRdd )
		DbCloseArea()
	EndIf
Next i

// Atualizando o Dicionario de Indices
ProcRegua( Len( aSIX ) )
SIX->( dbSetOrder( 1 ) )
For i := 1 To Len( aSIX )
	If !Empty( aSIX[i,1] )
		lNew := !SIX->( MsSeek( aSIX[i,1] + aSIX[i,2] ) )
		// Acrescenta na lista de atualizacoes
		if ASCAN( aArqUpd, aSIX[i,1] ) == 0
			aAdd( aArqUpd, aSIX[i,1] )
		endif
		lSIX := .T.
		If !(aSIX[i,1] $ cAlias)
			cAlias += aSIX[i,1] + "/"
		EndIf

		RecLock( "SIX", lNew )
		For j := 1 To Len( aSIX[i] )
			If FieldPos( aEstrut[j] ) > 0
				FieldPut( FieldPos(aEstrut[j] ), aSIX[i,j] )
			EndIf
		Next j
		dbCommit()
		MsUnLock()
		IncProc(STR0033) // //"Atualizando Indices..."
	EndIf
Next i

If lSIX
	cTexto += STR0034+cAlias+CRLF //"Indices atualizados  : "
EndIf

Return cTexto
/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ATFAtuSX2 ≥ Autor ≥ --------------------- ≥ Data ≥ 23/05/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Funcao de processamento da gravacao do SX2                 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ATFAtuSX2()
//X2_CHAVE X2_PATH X2_ARQUIVOC,X2_NOME,X2_NOMESPAC X2_NOMEENGC X2_DELET X2_MODO X2_TTS X2_ROTINA
Local aSX2   := {}
Local aEstrut:= {}
Local i      := 0
Local j      := 0
Local cTexto := ''
Local lSX2	 := .F.
Local cAlias := ''
Local cPath		:= ""
Local cNome		:= ""
Local cEmpr     := ''
Local cFilSN3	:= ""
Local cUniSN3	:= ""
Local cEmpSN3	:= ""

aEstrut:= {"X2_CHAVE","X2_PATH","X2_ARQUIVO","X2_NOME","X2_NOMESPA","X2_NOMEENG","X2_DELET","X2_MODO","X2_TTS","X2_ROTINA","X2_PYME","X2_UNICO","X2_MODOUN","X2_MODOEMP","X2_MODULO","X2_SYSOBJ"}

// Busca o compartilhamento da tabela SN3 para as novas tabelas terem o mesmo compartilhamento
dbSelectArea("SX2")
dbSetOrder(1)
MsSeek("SN1")
cFilSN3	:= SX2->X2_MODO
cPath	:= SX2->X2_PATH
If SX2->(FieldPos("X2_MODOUN")) > 0
	cUniSN3	:= SX2->X2_MODOUN
EndIf
If SX2->(FieldPos("X2_MODOEMP")) > 0
	cEmpSN3	:= SX2->X2_MODOEMP
EndIf
//
// Tabela FNB
//
aAdd( aSX2, {"FNB","\DADOSADV\",'FNB990','Projetos de imobilizado','Proyectos de inmovilizado','Fixed asset projects',0,cFilSN3,'','','S','FNB_FILIAL+FNB_CODPRJ+FNB_REVIS',cUniSN3,cEmpSN3,1} )
	
//
// Tabela FNC
//
aAdd( aSX2, {"FNC","\DADOSADV\",'FNC990','Etapas do projeto','Etapas del proyecto','Stages of project',0,cFilSN3,'','','S','FNC_FILIAL+FNC_CODPRJ+FNC_REVIS+FNC_ETAPA',cUniSN3,cEmpSN3,1} )
//
// Tabela FND
//
aAdd( aSX2, {"FND","\DADOSADV\",'FND990','Itens das etapas do projeto','Items de etapas del proyecto','Project stage items',0,cFilSN3,'','','S','FND_FILIAL+FND_CODPRJ+FND_REVIS+FND_ETAPA+FND_ITEM',cUniSN3,cEmpSN3,1} )
//
// Tabela FNE
//
aAdd(aSX2,{'FNE',"\DADOSADV\",'FNE990','Config ctb de projetos atf','Config ctb de proyectos ATF','ATF project accounting config.',0,cFilSN3,'','','S','FNE_FILIAL+FNE_CODPRJ+FNE_REVIS+FNE_ETAPA+FNE_ITEM+FNE_LINHA',cUniSN3,cEmpSN3,1} )
//
// Tabela FNJ
//
aAdd(aSX2,{ 'FNJ', '\DADOSADV\ ' , 'FNJ990','Item de Etapa X Ativo ExecuÁ„o','Item Etapa vs Activo Ejecucion','Stage Item X Execution Asset',0,cFilSN3,'','','S','FNJ_FILIAL+FNJ_CODPRJ+FNJ_REVIS+FNJ_ETAPA+FNJ_ITEM+FNJ_LINHA+FNJ_TAFPRJ+FNJ_SLDPRJ+FNJ_ITRELA',cUniSN3,cEmpSN3} )
//
// Tabela FNF
//
aAdd( aSX2, {'FNF',"\DADOSADV\",'FNF990','MOVIMENTOS AVP DO ATIVO FIXO','MOVIMIENTOS AVP DE ACTIVO FIJO','Fixed Asset AVP Transactions',0,cFilSN3,'','','S','FNF_FILIAL+FNF_CBASE+FNF_ITEM+FNF_TIPO+FNF_SEQ+FNF_TPSALD+FNF_REVIS+FNF_SEQAVP+FNF_MOEDA+DTOS(FNF_DTAVP)',cUniSN3,cEmpSN3,1} )
//
// Tabela FNP
//
aAdd( aSX2, {'FNP',"\DADOSADV\",'FNP990','PROCESSAMENTO APROPRIA«√O AVP','PROCESAMIENTO APROPRAC.AVP','AVP APPROPRIATION PROCESSING',0,cFilSN3,'','','S','FNP_FILIAL+FNP_IDPROC',cUniSN3,cEmpSN3,1} )

//Tabela FNI
aAdd( aSX2, {'FNI',"\DADOSADV\",'FNI990','Indices calculo de depreciaÁ„o','Indices de calculo de deprecia','Depreciation calculatn indices',0,'C','','','S','FNI_FILIAL+FNI_CODIND+FNI_REVIS','C','C',1,'ATFA005'} )

//Tabela FNT
AADD( aSX2, {'FNT',"\DADOSADV\",'FNT990','Taxas de Ìndices depreciaÁ„o','Tasas de indices de depreciac.','Depreciation rate indices',0,'C','','','S','FNT_FILIAL+FNT_CODIND+FNT_REVIS+DTOS(FNT_DATA)','C','C'} )

//
//Tabela FNH - OperaÁıes com controle de aprovaÁ„o
//
aAdd( aSX2, {'FNH',"\DADOSADV\",'FNH990','Opera. com controle de aprova.','Opera. con control de aproba. ','Operation w/ approval control ',0,'E','','','S','FNH_FILIAL+FNH_ROTINA+FNH_OPER','E','E',1} )
//
//Tabela FNK - Alcadas aprovacao por operacao
//
aAdd( aSX2, {'FNK',"\DADOSADV\",'FNK990','AlÁadas aprovacao por operacao','Jurisdic. aprob. por operacion','Jurisdictn approval by opertn ',0,cFilSN3,'','','S','FNK_FILIAL+FNK_ROTINA+FNK_REVIS',cUniSN3,cEmpSN3,1} )
//
//Tabela FNL - Itens alcada de aprovacao por operacao
//
aAdd( aSX2, {'FNL',"\DADOSADV\",'FNL990','Itens AlÁada Aprov. por operac','Items Alcance Aprob. por oper','Jursdctn apprvl by oper. items',0,cFilSN3,'','','S','FNL_FILIAL+FNL_ROTINA+FNL_REVIS+FNL_OPER',cUniSN3,cEmpSN3,1} )
//
//FNM - Movimentos de aprovaÁ„o e histÛricos de alteraÁıes
//
aAdd( aSX2, {'FNM',"\DADOSADV\",'FNM990','Movimen. de aprova. por opera.','Movimen. de aproba. por opera.','Apprvl by operatn transaction ',0,'E','','','S','FNM_FILIAL+FNM_IDMOV','E','E',1} )
//
//Tabela FNN - Processo Constitucao provisao
//
aAdd( aSX2, {'FNN',"\DADOSADV\",'FNN990','Processo Constitucao Provisao','Proceso Constitucion Provision','Provision Const. Process',0,cFilSN3,'','','S','FNN_FILIAL+DTOS(FNN_DTPROC)+FNN_IDPROC',cUniSN3,cEmpSN3,1} )
//
//Tabela FNO - Movto. Constituicao Provis„o
//
aAdd( aSX2, {'FNO',"\DADOSADV\",'FNO990','Movtos. ConstituiÁ„o Provis„o','Movtos. Constitucion Provision','Provision Const. Transactions',0,cFilSN3,'','','S','FNO_FILIAL+FNO_IDPROC+FNO_CBASE+FNO_ITEM+FNO_BASESP+FNO_ITEMSP',cUniSN3,cEmpSN3,1} )
//
//Tabela FNQ - Margem Gerencial
//
aAdd( aSX2, {'FNQ',"\DADOSADV\",'FNQ990','Margem Gerencial','Margen Gerencial','Management Margin',0,cFilSN3,'','','S','FNQ_FILIAL+FNQ_COD+FNQ_REV',cUniSN3,cEmpSN3,1} )

//
// Tabela FN1
//
aAdd( aSX2, {'FN1',cPath,'FN1'+cEmpr,'Proc. Custo Emprestimo','Proc. Costo Prestamo','Loan Cost Proc.',0,cFilSN3,'','','S','FN1_FILIAL+FN1_PROC',cUniSN3,cEmpSN3,1} )
//
// Tabela FN2
//
aAdd( aSX2, {'FN2',cPath,'FN2'+cEmpr,'Contrato e Juros','Contrato e Intereses','Contract and Interest',0,cFilSN3,'','','S','FN2_FILIAL+FN2_PROC+FN2_LINHA',cUniSN3,cEmpSN3,1} )
//
// Tabela FN3
//
aAdd( aSX2, {'FN3',cPath,'FN3'+cEmpr,'Custos de TransaÁ„o','Costos de Transaccion','Transaction Costs',0,cFilSN3,'','','S','FN3_FILIAL+FN3_PROC+FN3_LINHA',cUniSN3,cEmpSN3,1} )
//
// Tabela FN4
//
aAdd( aSX2, {'FN4',cPath,'FN4'+cEmpr,'Rendimentos Custo Emprestimo','Rendimientos Costo Prestamo','Loan Cost Incomes',0,cFilSN3,'','','S','FN4_FILIAL+FN4_PROC+FN4_LINHA',cUniSN3,cEmpSN3,1} )
//
// Tabela FN5
//
aAdd( aSX2, {'FN5',cPath,'FN5'+cEmpr,'Fichas do Custo Emprestimo','Fichas de Costo Prestamo','Loan Cost Forms',0,cFilSN3,'','','S','FN5_FILIAL+FN5_PROC+FN5_LINHA',cUniSN3,cEmpSN3,1} )
//
// Tabela FNU - Controle de Provis„o
//
aAdd( aSX2, {'FNU',cPath,'FNU990','Controle de Provis„o','Control de Provision','Provision Control',0,cFilSN3,'','','N','FNU_FILIAL+FNU_COD+FNU_REV',cUniSN3,cEmpSN3,1} )
//
// Tabela FNV - Item da Provis„o
//
aAdd( aSX2, {'FNV',cPath,'FNV990','Item da Provis„o','Item de la Provision','Provision Item',0,cFilSN3,'','','N','FNV_FILIAL+FNV_COD+FNV_REV+FNV_ITEM',cUniSN3,cEmpSN3,1} )
//
// Tabela FNW - Movimentos da Provis„o
//
aAdd( aSX2, {'FNW',cPath,'FNW990','Movimentos de Provis„o','Movimientos de Provision','Provision Movements',0,cFilSN3,'','','N','FNW_FILIAL+FNW_IDMOV',cUniSN3,cEmpSN3,1} )
//
// Tabela FNX - RealizaÁ„o da Provis„o
//
aAdd( aSX2, {'FNX',cPath,'FNX990','RealizaÁ„o da Provis„o','Realizacion de la Provision','Provision Made',0,cFilSN3,'','','N','FNX_FILIAL+FNX_COD+FNX_REV+FNX_LINHA+FNX_CBASE+FNX_ITEM+FNX_TIPO+FNX_TPSALD+FNX_FILATF',cUniSN3,cEmpSN3,1} )

//
// Atualizando dicion·rio
//

dbSelectArea( 'SX2' )
SX2->( dbSetOrder( 1 ) )
SX2->( dbGoTop() )
cPath := SX2->X2_PATH
cEmpr := Substr( SX2->X2_ARQUIVO, 4 )
ProcRegua(Len(aSX2))

dbSelectArea("SX2")
dbSetOrder(1)
MsSeek("AK1")
cPath := SX2->X2_PATH
cNome := Substr(SX2->X2_ARQUIVO,4,5)

For i:= 1 To Len(aSX2)
	If !Empty(aSX2[i][1])
		lGrava := SX2->(!MsSeek(aSX2[i,1]))
		lSX2	:= .T.
		If !(aSX2[i,1]$cAlias)
			cAlias += aSX2[i,1]+"/"
		EndIf
		RecLock("SX2",lGrava)
		For j:=1 To Len(aSX2[i])
			If FieldPos(aEstrut[j]) > 0
				If lGrava
					FieldPut(FieldPos(aEstrut[j]),aSX2[i,j])
				ElseIf !(aEstrut[j] $ 'X2_MODO/X2_MODOUN/X2_MODOEMP')
					FieldPut(FieldPos(aEstrut[j]),aSX2[i,j])
				EndIf
			EndIf
		Next j
		SX2->X2_PATH    := cPath
		SX2->X2_ARQUIVO := aSX2[i,1]+cNome
		dbCommit()
		MsUnLock()
		IncProc(STR0037) //"Atualizando Dicionario de Arquivos..."
	EndIf
Next i



If lSX2
	cTexto += STR0077+CRLF+"  "+cAlias+CRLF//"Incluidas as novas tabelas(SX2):"
EndIf

Return cTexto

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ATFAtuSX3 ≥ Autor ≥ --------------------- ≥ Data ≥ 23/05/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Funcao de processamento da gravacao do SX3                 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ATFAtuSX3()
//	X3_ARQUIVO X3_ORDEM   X3_CAMPO   X3_TIPO    X3_TAMANHO X3_DECIMAL X3_TITULO  X3_TITSPA  X3_TITENG
//  X3_DESCRIC X3_DESCSPA X3_DESCENG X3_PICTURE X3_VALID   X3_USADO   X3_RELACAO X3_F3      X3_NIVEL
//  X3_RESERV  X3_CHECK   X3_TRIGGER X3_PROPRI  X3_BROWSE  X3_VISUAL  X3_CONTEXT X3_OBRIGAT X3_VLDUSER
//  X3_CBOX    X3_CBOXSPA X3_CBOXENG X3_PICTVAR X3_WHEN    X3_INIBRW  X3_GRPSXG  X3_FOLDER

/*
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!									ATEN«√O									!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! Ao criar novos campos na tabela SN3, È necess·rio adicionar o campo ao array aN3matriz na !!
!! funÁ„o ATFORDESN3																	     !!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/

Local aSX3   	:= {}
Local aSX3Del  	:= {}
Local aEstrut	:= {}
Local aSX3Ordem	:= {}
Local i      	:= 0
Local j      	:= 0
Local lSX3		:= .F.
Local cTexto 	:= ''
Local cAlias 	:= ''
Local nI		:= 0 
Local aArea  	:= GetArea()
Local aAreaSX3	:= {}  
Local aSX3Alter := {}
Local nTamFil 	:= AtfTamSXG( "033", TamSX3( "E2_FILIAL" )[1] )[1]
Local nTamLocBem:= AtfTamSXG( "058", 6)[1]
Local nTamCodInd:= AtfTamSXG( "060", 2)[1]
Local nTamConta:= AtfTamSXG( "003", 20)[1]
Local nTamCCusto:= AtfTamSXG( "004", 9)[1]
Local nTamITCtb:= AtfTamSXG( "005", 9)[1]
Local nTamClVlr:= AtfTamSXG( "006", 9)[1]
Local aSX3Copia	:= {}
Local cNewOrdem	:= ""
Local aSX3Campos:= {}

// Campos do SX3 a terem copiados o X3_USADO e X3_RESERV
aSX3Copia := {	{"CT5_FILIAL"}, {"N1_CBASE"}, {"CT5_HIST"}, {"CTS_CODPLA"}, {"CTS_CTASUP"} ,{"N3_HISTOR"}}
/*
aSX3Copia[1] 	= Filial
aSX3Copia[2]	= Campo chave obrigatÛrio usado
aSX3Copia[3]	= Campo n„o obrigatÛrio usado
aSX3Copia[4]	= Campo chave obrigatÛrio n„o usado
aSX3Copia[5]	= Campo n„o obrigatÛrio n„o usado
aSX3Copia[6]	= Campo obrigatÛrio usado
*/

SX3->( DbSetOrder(2) )
For i := 1 to Len( aSX3Copia )
	SX3->( DbSeek(aSX3Copia[i,1]) )
	Aadd( aSX3Copia[i], SX3->X3_USADO )
	Aadd( aSX3Copia[i], SX3->X3_RESERV )
Next

aEstrut:= { "X3_ARQUIVO","X3_ORDEM"  ,"X3_CAMPO"  ,"X3_TIPO"   ,"X3_TAMANHO","X3_DECIMAL","X3_TITULO" ,"X3_TITSPA" ,"X3_TITENG" ,;
"X3_DESCRIC","X3_DESCSPA","X3_DESCENG","X3_PICTURE","X3_VALID"  ,"X3_USADO"  ,"X3_RELACAO","X3_F3"     ,"X3_NIVEL"  ,;
"X3_RESERV" ,"X3_CHECK"  ,"X3_TRIGGER","X3_PROPRI" ,"X3_BROWSE" ,"X3_VISUAL" ,"X3_CONTEXT","X3_OBRIGAT","X3_VLDUSER",;
"X3_CBOX"   ,"X3_CBOXSPA","X3_CBOXENG","X3_PICTVAR","X3_WHEN"   ,"X3_INIBRW" ,"X3_GRPSXG" ,"X3_FOLDER","X3_PYME"}

/* Identificando os campos do SX3 na matriz aEstrut
01-X3_ARQUIVO  02-X3_ORDEM	  03-X3_CAMPO    04-X3_TIPO     05-X3_TAMANHO  06-X3_DECIMAL  07-X3_TITULO  08-X3_TITSPA
09-X3_TITENG   10-X3_DESCRIC  11-X3_DESCSPA  12-X3_DESCENG  13-X3_PICTURE  14-X3_VALID    15-X3_USADO   16-X3_RELACAO
17-X3_F3       18-X3_NIVEL    19-X3_RESERV   20-X3_CHECK    21-X3_TRIGGER  22-X3_PROPRI   23-X3_BROWSE  24-X3_VISUAL
25-X3_CONTEXT  26-X3_OBRIGAT  27-X3_VLDUSER  28-X3_CBOX     29-X3_CBOXSPA  30-X3_CBOXENG  31-X3_PICTVAR 32-X3_WHEN
33-X3_INIBRW   34-X3_GRPSXG   35-X3_FOLDER   36-X3_PYME
*/

//
// Tabela FNB
//
aAdd( aSX3Alter, {'FNB','01','FNB_FILIAL','C',nTamFil   ,0,'Filial'      ,'Sucursal'    ,'Branch'      ,'Filial do Sistema'        ,'Sucursal del sistema'     ,'Branch of System'         ,'@!',''                                            ,aSX3Copia[1][2],''            ,''   ,1,aSX3Copia[1][3],'','','S','N','' ,'' ,'' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'','033','','S'} )
aAdd( aSX3Alter, {'FNB','02','FNB_CODPRJ','C',10        ,0,'Codigo'      ,'Codigo'      ,'Code'        ,'Codigo do Projeto'        ,'Codigo del proyecto'      ,'Code of Project'          ,'@!','ExistChav("FNB",M->FNB_CODPRJ+M->FNB_REVIS )',aSX3Copia[2][2],'AF430INCOD()',''   ,1,aSX3Copia[2][3],'','','S','S','A','R','Ä','',''                                                                                     ,''                                                                                               ,''                                                                                 ,'','INCLUI'     ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','03','FNB_REVIS' ,'C',4         ,0,'Revisao'     ,'Revision'    ,'Revision'    ,'Revisao de Projeto'       ,'Revision del proyecto'    ,'Revision of Project'      ,'@!',''                                            ,aSX3Copia[2][2],'AF430INREV()',''   ,1,aSX3Copia[2][3],'','','S','S','V','R','Ä','',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','04','FNB_DESC'  ,'C',40        ,0,'Descricao'   ,'Descripcion' ,'Description' ,'Descricao do Projeto'     ,'Descripcion del proyecto' ,'Description of Project'   ,'@!',''                                            ,aSX3Copia[6][2],''            ,''   ,1,aSX3Copia[6][3],'','','S','S','A','R','Ä','',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','05','FNB_TIPO'  ,'C',1         ,0,'Tipo'        ,'Tipo'        ,'Type'        ,'Tipo do Projeto'          ,'Tipo del proyecto'        ,'Type of Project'          ,'@!','Pertence("12") '                             ,aSX3Copia[6][2],"'2'"         ,''   ,1,aSX3Copia[6][3],'','','S','S','V','R','Ä','','1=Receita;2=Despesa'                                                                  ,'1=Ingreso;2=Gasto'                                                                              ,'1=Income;2=Expense'                                                               ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','06','FNB_SBTIPO','C',1         ,0,'Sub-Tipo'    ,'Subtipo'     ,'Subtype'     ,'Sub-Tipo do projeto'      ,'Subtipo del proyecto'     ,'Project subtype'          ,'@!','Pertence("1234")'                            ,aSX3Copia[6][2],'"1"'         ,''   ,1,aSX3Copia[6][3],'','','S','S','A','R','Ä','','1=Imobilizado;2=Intangivel;3=Diferido;4=OrÁamento Prov'                              ,'1=Act. Fijo;2=Intangible;3=Prorrogado;4=Presupuesto Aprov.'                                      ,'1=Fixed;2=Intangible;3=Deferred;4=Prov Budget'                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','07','FNB_INDAVP','C',2         ,0,'Indice AVP'  ,'Indice AVP'  ,'AVP Index'   ,'Indice para calculo AVP'  ,'Indice para calculo AVP'  ,'Index for AVP calculation','@!','Vazio() .or. ExistCpo("FIT")'                ,aSX3Copia[3][2],''            ,'FIT',1,aSX3Copia[3][3],'','','S','N','A','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','08','FNB_MRGREC','C',1         ,0,'Margem Rec.?','øMargem Ing?','RevenueMargn','Controla margem receita?' ,'øControla margen ingreso?','Control revenue margin?'  ,'@!','Pertence("12")'                              ,aSX3Copia[3][2],"'2'"         ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','' ,'','1=Sim;2=Nao'                                                                          ,'1=Si;2=No'                                                                                      ,'1=Yes;2=No'                                                                       ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','09','FNB_MOEDA' ,'C',2         ,0,'Moeda'       ,'Moneda'      ,'Currency'    ,'Moeda de controle do prj.','Moneda de control del Pro','Project control currency' ,'@!','ExistCPO("CTO")'                             ,aSX3Copia[6][2],'"01"'        ,'CTO',1,aSX3Copia[6][3],'','','S','S','V','R','Ä','',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','10','FNB_CBASE' ,'C',10        ,0,'Cod Base ATF','Cod Base ATF','F.A.BaseCode','Codigo base dos Ativos'   ,'Codigo base de Activos'   ,'Base Code of Assets'      ,'@!','AF430CBASE()'                                ,aSX3Copia[3][2],''            ,''   ,1,aSX3Copia[3][3],'','','S','S','A','R','Ä','',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','11','FNB_DTINIC','D',8         ,0,'Inicio Prj'  ,'Inicio Pry'  ,'Prj Start'   ,'Data de Inicio do Projeto','Fecha de Inicio del Proye','Project Start Date'       ,''  ,''                                            ,aSX3Copia[6][2],''            ,''   ,1,aSX3Copia[6][3],'','','S','N','A','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','12','FNB_STATUS','C',1         ,0,'Status'      ,'Estatus'     ,'Status'      ,'Status do projeto'        ,'Estatus del proyecto'     ,'Project Status'           ,'@!',''                                            ,aSX3Copia[6][2],"'0'"         ,''   ,1,aSX3Copia[6][3],'','','S','N','V','R','Ä','','#AF430STAT()'                                                                         ,'#AF430STAT()'                                                                                   ,'#AF430STAT()'                                                                     ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','13','FNB_MSBLQL','C',1         ,0,'Bloqueado?'  ,'øBloqueado?' ,'Blocked?'    ,'Registro bloqueado'       ,'Registro bloqueado'       ,'Record blocked'           ,'@!',''                                            ,aSX3Copia[3][2],"'2'"         ,''   ,1,aSX3Copia[3][3],'','','S','N','A','R','' ,'','1=Sim;2=N„o'                                                                          ,'1=Si;2=No'                                                                                      ,'1=Yes;2=No'                                                                       ,'','AF430BLQW()','',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','14','FNB_CODPMS','C',10        ,0,'Projeto PMS' ,'Proyecto PMS','PMS Project' ,'Codigo do projeto PMS'    ,'Codigo del proyecto PMS'  ,'PMS project code'         ,'@!','ExistCPO("AF8")'                             ,aSX3Copia[5][2],''            ,'AF8',1,aSX3Copia[5][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','15','FNB_EDTPMS','C',12        ,0,'EDT PMS'     ,'EDT PMS'     ,'EDT PMS'     ,'EDT do projeto PMS'       ,'EDT del proyecto PMS'     ,'EDT of PMS project'       ,'@!','ExistCPO("AF9",M->FNB_CODPMS+M->FNB_EDTPMS)' ,aSX3Copia[5][2],''            ,'AF9',1,aSX3Copia[5][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'','014','','S'} )
aAdd( aSX3Alter, {'FNB','16','FNB_DTENCR','D',8         ,0,'Dt Encerram' ,'Fch. Cierre' ,'Closing date','Data de encerramento'     ,'Fecha de cierre'          ,'Closing date'             ,''  ,''                                            ,aSX3Copia[3][2],''            ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','17','FNB_LOCPRJ','C',nTamLocBem,0,'Local Prj'   ,'Local Proy'   ,'Prj Location','Local do Projeto'        ,'Local del Proyecto'      ,'Project Location'         ,'@!','Vazio() .Or. ExistCpo("SNL")'                ,aSX3Copia[3][2],''            ,'SNL',1,aSX3Copia[3][3],'','','S','N','A','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'','058','','S'} )
aAdd( aSX3Alter, {'FNB','18','FNB_DTREV' ,'D',8         ,0,'Dt Revisao'  ,'Fc Revision' ,'Review Dt' ,'Data de revis„o'          ,'Fecha de revision'        ,'Review Date'              ,''  ,''                                            ,aSX3Copia[3][2],''            ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','19','FNB_DTPROV','D',8         ,0,'Inicio Prov' ,'Inicio Prov' ,'Start Prov'  ,'Data de Inicio da Prov'   ,'Fecha de Inicio de Provis','Prov Start Date'          ,''  ,''                                            ,aSX3Copia[3][2],''            ,''   ,1,aSX3Copia[3][3],'','','S','N','A','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','20','FNB_PRVEXC','D',8         ,0,'Dt.Prev.Exec','Fc.Prev.Ejec','Ex.Plan.Dt.' ,'Data de previsao de exec' ,'Fecha de Prevision de Eje','Exec Planned Date'        ,''  ,''                                            ,aSX3Copia[3][2],''            ,''   ,1,aSX3Copia[3][3],'','','S','N','A','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNB','21','FNB_TPAVP' ,'C',1         ,0,'Tipo AVP'    ,'Tipo AVP'    ,'AVP Type'    ,'Tipo de AVP'              ,'Tipo de AVP'              ,'AVP Type'              ,'@!','Pertence("12")'                              ,aSX3Copia[3][2],'"1"'         ,''   ,1,aSX3Copia[3][3],'','','S','N','A','R','' ,'','1=Total;2=Parcela'                                                                    ,'1=Total;2=Cuota'                                                                                ,'1=Total;2=Installment'                                                            ,'',''           ,'',''   ,'','S'} )
//
// Tabela FNC
//
aAdd( aSX3Alter, {'FNC','01','FNC_FILIAL','C',nTamFil,0,'Filial'      ,'Sucursal'    ,'Branch'      ,'Filial do Sistema'       ,'Sucursal del sistema'     ,'Branch of System'        ,'@!',''                                             ,aSX3Copia[1][2],''           ,''   ,1,aSX3Copia[1][3],'','','S','N','' ,'' ,'' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'','033','','S'} )
aAdd( aSX3Alter, {'FNC','02','FNC_CODPRJ','C',10     ,0,'Projeto'     ,'Proyecto'    ,'Project'     ,'Codigo do Projeto'       ,'Codigo del proyecto'      ,'Code of Project'         ,'@!',''                                             ,aSX3Copia[3][2],''           ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNC','03','FNC_REVIS' ,'C',4      ,0,'Revisao'     ,'Revision'    ,'Review'      ,'Revisao do projeto'      ,'Revision del proyecto'    ,'Review of project'       ,'@!',''                                             ,aSX3Copia[3][2],''           ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNC','04','FNC_ETAPA' ,'C',3      ,0,'Etapa'       ,'Etapa'       ,'Stage'       ,'Etapa do projeto'        ,'Etapa del proyecto'       ,'Stage of project'        ,'@!',''                                             ,aSX3Copia[6][2],''           ,''   ,1,aSX3Copia[6][3],'','','S','N','V','R','Ä','',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNC','05','FNC_DSCETP','C',40     ,0,'Desc Etapa'  ,'Desc Etapa'  ,'StageDescrip','Descricao da etapa'      ,'Descripcion de la etapa  ','Description of Stage'    ,'@!',''                                             ,aSX3Copia[6][2],''           ,''   ,1,aSX3Copia[6][3],'','','S','N','A','R','Ä','',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNC','06','FNC_TIPO'  ,'C',1      ,0,'Tipo'        ,'Tipo'        ,'Type'        ,'Tipo do Item da etapa'   ,'Tipo del item de la etapa','Stage Item Type'         ,'@!','Pertence("12") '                              ,aSX3Copia[6][2],'AF430RTP()' ,''   ,1,aSX3Copia[6][3],'','','S','N','V','R','' ,'','1=Receita;2=Despesa'                                                                  ,'1=Ingreso;2=Gasto'                                                                              ,'1=Income;2=Expense'                                                               ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNC','07','FNC_SBTIPO','C',1      ,0,'Sub-Tipo'    ,'Subtipo'     ,'Subtype'     ,'Sub-Tipo da Etapa'       ,'Subtipo de la etapa'      ,'Stage Subtype'           ,'@!','Pertence("1234")'                             ,aSX3Copia[6][2],'AF430RSTP()',''   ,1,aSX3Copia[6][3],'','','S','N','A','R','Ä','','1=Imobilizado;2=Intangivel;3=Diferido;4=OrÁamento Prov.'                              ,'1=Activo fijo;2=Intangible;3=Diferido;4=Presupuesto Prov.'                                      ,'1=Fixed;2=Intangible;3=Deferred;4=Prov Budget'                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNC','08','FNC_INDAVP','C',2      ,0,'Indice AVP'  ,'Indice AVP'  ,'AVP Index'   ,'Indice AVP da Etapa'     ,'Indice AVP de la etapa'   ,'AVP Index of Stage'      ,'@!','Vazio() .or. ExistCpo("FIT")'                 ,aSX3Copia[3][2],'AF430RIND()','FIT',1,aSX3Copia[3][3],'','','S','N','A','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNC','09','FNC_MSBLQL','C',1      ,0,'Bloqueado?'  ,'øBloqueado?' ,'Blocked?'    ,'Registro bloqueado'      ,'Registro bloqueado'       ,'Register blocked'          ,''  ,''                                             ,aSX3Copia[3][2],"'2'"        ,''   ,1,aSX3Copia[3][3],'','','S','N','A','R','' ,'','1=Sim;2=N„o'                                                                          ,'1=Si;2=No'                                                                                      ,'1=Yes;2=No'                                                                       ,'','AF430BLQW()','',''   ,'','S'} )
aAdd( aSX3Alter, {'FNC','10','FNC_CODPMS','C',10     ,0,'Projeto PMS' ,'Proyecto PMS','PMS Project' ,'Codigo do projeto PMS'   ,'Codigo del proyecto PMS'  ,'PMS project code'        ,'@!','ExistCpo("AF8")'                              ,aSX3Copia[5][2],''           ,'AF8',1,aSX3Copia[5][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNC','11','FNC_EDTPMS','C',12     ,0,'EDT PMS'     ,'EDT PMS'     ,'EDT PMS'     ,'EDT do projeto PMS'      ,'EDT del proyecto PMS'     ,'EDT of PMS project'      ,'@!','ExistCpo("AF9",M->FNC_CODPMS + M->FNC_EDTPMS)',aSX3Copia[5][2],''           ,'AF9',1,aSX3Copia[5][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'','014','','S'} )
aAdd( aSX3Alter, {'FNC','12','FNC_STATUS','C',1      ,0,'Status'      ,'Estatus'     ,'Status'      ,'Status da Etapa'         ,'Estatus de la etapa'      ,'Stage Status'            ,'@!',''                                             ,aSX3Copia[3][2],"'0'"        ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','' ,'','#AF430STAT()','#AF430STAT()','#AF430STAT()','',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNC','13','FNC_DTENCR','D',8      ,0,'Dt Encerram' ,'Fc Cierre'  ,'Closing Dt','Data de encerramento'    ,'Fecha de cierre'          ,'Closing date'            ,''  ,''                                             ,aSX3Copia[3][2],''           ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNC','14','FNC_DTPROV','D',8      ,0,'Inicio Prov' ,'Inicio Prov' ,'Start Prov'  ,'Data de Inicio da Provis','Fecha de Inicio de Provis','Prov Start Date'         ,''  ,''                                             ,aSX3Copia[3][2],'AF430RDPR()',''   ,1,aSX3Copia[3][3],'','','S','N','A','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNC','15','FNC_PRVEXC','D',8      ,0,'Dt.Prev.Exec','Fc.Prev.Ejec','Ex.Plan.Dt.' ,'Data de previsao de exec','Fecha de Prevision de Eje','Exec Planned Date'       ,''  ,''                                             ,aSX3Copia[3][2],''           ,''   ,1,aSX3Copia[3][3],'','','S','N','A','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNC','16','FNC_TPAVP' ,'C',1      ,0,'Tipo AVP'    ,'Tipo AVP'    ,'AVP Type'    ,'Tipo de AVP'             ,'Tipo de AVP'              ,'AVP Type'               ,'@!','Pertence("12")'                               ,aSX3Copia[3][2],'"1"'        ,''   ,1,aSX3Copia[3][3],'','','S','N','A','R','' ,'','1=Total;2=Parcela'                                                                    ,'1=Total;2=Cuota'                                                                                ,'1=Total;2=Installment'                                                            ,'',''           ,'',''   ,'','S'} )
//
// Tabela FND
//
aAdd( aSX3Alter, {'FND','01','FND_FILIAL','C',nTamFil,0,'Filial'      ,'Sucursal'    ,'Branch'      ,'Filial do Sistema'        ,'Sucursal del sistema'     ,'Branch of System'         ,'@!'                     ,''                                             ,aSX3Copia[1][2],''           ,''   ,1,aSX3Copia[1][3],'','','S','N','' ,'' ,'' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'','033','','S'} )
aAdd( aSX3Alter, {'FND','02','FND_CODPRJ','C',10     ,0,'Projeto'     ,'Proyecto'    ,'Project'     ,'Codigo do Projeto'        ,'Codigo del proyecto'      ,'Code of Project'          ,'@!'                     ,''                                             ,aSX3Copia[3][2],''           ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','03','FND_REVIS' ,'C',4      ,0,'Revisao'     ,'Revision'    ,'Revision'    ,'Revisao do projeto'       ,'Revision del proyecto'    ,'Revision of Project'      ,'@!'                     ,''                                             ,aSX3Copia[3][2],''           ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','04','FND_ETAPA' ,'C',3      ,0,'Etapa'       ,'Etapa'       ,'Stage'       ,'Etapa do projeto'         ,'Etapa del proyecto'       ,'Stage of project'         ,'@!'                     ,''                                             ,aSX3Copia[3][2],''           ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','05','FND_ITEM'  ,'C',3      ,0,'Item'        ,'Item'        ,'Item'        ,'Item da etapa'            ,'Item de la etapa'         ,'Item of Stage'            ,'@!'                     ,''                                             ,aSX3Copia[6][2],''           ,''   ,1,aSX3Copia[6][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','06','FND_DSCITE','C',40     ,0,'Desc.Item'   ,'Desc.Item'   ,'ItemDescript','Descricao item da etapa'  ,'Descripcion item de etapa','Description of Stage Item','@!'                     ,''                                             ,aSX3Copia[6][2],''           ,''   ,1,aSX3Copia[6][3],'','','S','N','A','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','07','FND_TIPO'  ,'C',1      ,0,'Tipo'        ,'Tipo'        ,'Type'        ,'Tipo do item da etapa'    ,'Tipo del item de la etapa','Type of stage item'       ,'@!'                     ,'Pertence("12")'                               ,aSX3Copia[6][2],'AF430RTP()' ,''   ,1,aSX3Copia[6][3],'','','S','N','V','R','' ,'','1=Receita;2=Despesa'                                                                  ,'1=Ingreso;2=Gasto'                                                                              ,'1=Income;2=Expense'                                                               ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','08','FND_CTRATF','C',1      ,0,'Contrl Atf'  ,'Contrl Act'  ,'Contr Asset?','Controla Ativo?'          ,'Controla Activo'          ,'Control Asset?'           ,'@!'                     ,'Pertence("12")'                               ,aSX3Copia[3][2],"'1'"        ,''   ,1,aSX3Copia[3][3],'','','S','N','A','R','' ,'','1=Sim;2=N„o'                                                                          ,'1=Si;2=No'                                                                                      ,'1=Yes;2=No'                                                                       ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','09','FND_SBTIPO','C',1      ,0,'Sub-tipo'    ,'Subtipo'     ,'Subtype'     ,'Sub-tipo do item da etapa','Subtipo del item de etapa','Stage Item Subtype'       ,'@!'                     ,'Pertence("1234")'                             ,aSX3Copia[6][2],'AF430RSTP()',''   ,1,aSX3Copia[6][3],'','','S','N','A','R','' ,'','1=Imobilizado;2=Intangivel;3=Diferido;4=OrÁamento Prov.'                              ,'1=Activo fijo;2=Intangible;3=Diferido;4=Presupuesto Prov.'                                     ,'1=Fixed;2=Intangible;3=Deferred;4=Prov Budget'                             ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','10','FND_DTPROV','D',8      ,0,'Inicio Prov' ,'Inicio Prov' ,'Prov Start'  ,'Data de Inicio da Provis' ,'Fecha de Inicio de Provis','Provision Start Date'     ,''                       ,''                                             ,aSX3Copia[6][2],'AF430RDPR()',''   ,1,aSX3Copia[6][3],'','','S','N','A','R','Ä','',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','11','FND_PERINI','D',8      ,0,'Periodo ini' ,'Periodo Inic','Initial Per.','Periodo inicial do item'  ,'Periodo inicial del item' ,'Initial period of item'   ,''                       ,''                                             ,aSX3Copia[6][2],''           ,''   ,1,aSX3Copia[6][3],'','','S','N','A','R','Ä','',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','12','FND_PERFIM','D',8      ,0,'Periodo fim' ,'Periodo Fin.','Final per.'  ,'Periodo final do item'   ,'Periodo final del item'   ,'Final period of stage'    ,''                       ,''                                             ,aSX3Copia[6][2],''           ,''   ,1,aSX3Copia[6][3],'','','S','N','A','R','Ä','',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','13','FND_PRVEXC','D',8      ,0,'Dt.Prev.Exec','Fch.Prev.Eje','ExeForecstDt','Data de previsao de exec' ,'Fecha de prevision ejerci','Execution forecast date'  ,''                       ,'AF430VDTP()'                                  ,aSX3Copia[6][2],''           ,''   ,1,aSX3Copia[6][3],'','','S','N','A','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','14','FND_INDAVP','C',2      ,0,'Indice AVP'  ,'Indice AVP'  ,'AVP Index'   ,'Indice de AVP do item'    ,'Indice de AVP del item'   ,'Item AVP Index'           ,'@!'                     ,'Vazio() .or. ExistCpo("FIT")'                 ,aSX3Copia[3][2],'AF430RIND()','FIT',1,aSX3Copia[3][3],'','','S','N','A','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','15','FND_VLRPLN','N',16     ,2,'Vlr. Planej' ,'Val. Planif.','Planned Valu','Valor planejado do item'  ,'Val. planificado del item','Planned value of item'    ,'@E 9,999,999,999,999.99','Positivo()'                                   ,aSX3Copia[3][2],''           ,''   ,1,aSX3Copia[3][3],'','','S','N','A','R','Ä','',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','16','FND_MSBLQL','C',1      ,0,'Bloqueado?'  ,'øBloqueado?' ,'Blocked?'    ,'Registro bloqueado'       ,'Registro bloqueado'       ,'Record blocked'           ,''                       ,''                                             ,aSX3Copia[3][2],"'2'"        ,''   ,1,aSX3Copia[3][3],'','','S','N','A','R','' ,'','1=Sim;2=N„o'                                                                          ,'1=Si;2=No'                                                                                      ,'1=Yes;2=No'                                                                       ,'','AF430BLQW()','',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','17','FND_CODPMS','C',10     ,0,'Projeto PMS' ,'Proyecto PMS','PMS Project' ,'Codigo do projeto PMS'    ,'Codigo del proyecto PMS'  ,'Code of PMS project'      ,'@!'                     ,'ExistCpo("AF8")'                              ,aSX3Copia[5][2],''           ,'AF8',1,aSX3Copia[5][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','18','FND_EDTPMS','C',12     ,0,'EDT PMS'     ,'EDT PMS'     ,'EDT PMS'     ,'EDT do projeto PMS'       ,'EDT del proyecto PMS'     ,'EDT of PMS project'       ,'@!'                     ,'ExistCpo("AF9",M->FND_CODPMS + M->FND_EDTPMS)',aSX3Copia[5][2],''           ,'AF9',1,aSX3Copia[5][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'','014','','S'} )
aAdd( aSX3Alter, {'FND','19','FND_DTENCR','D',8      ,0,'Dt.Encerram' ,'Fc.Finalizac','Closing date','Data de encerramento'     ,'Fecha de cierre'          ,'Closing date'             ,''                       ,''                                             ,aSX3Copia[3][2],''           ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','20','FND_STATUS','C',1      ,0,'Status'      ,'Estatus'     ,'Status'      ,'Status Item da Etapa'     ,'Estatus Item de la etapa' ,'Stage Item Status'        ,'@!'                     ,''                                             ,aSX3Copia[3][2],"'0'"        ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','' ,'','#AF430STAT()','#AF430STAT()','#AF430STAT()','',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FND','21','FND_TPAVP' ,'C',1      ,0,'Tipo AVP'    ,'Tipo AVP'    ,'AVP Type'    ,'Tipo de AVP'              ,'Tipo de AVP'              ,'AVP Type'                 ,'@!'                     ,'Pertence("12")'                               ,aSX3Copia[3][2],'"1"'        ,''   ,1,aSX3Copia[3][3],'','','S','N','A','R','' ,'','1=Total;2=Parcela'                                                                    ,'1=Total;2=Cuota'                                                                                ,'1=Total;2=Installment'                                                            ,'',''           ,'',''   ,'','S'} )

//Exclus„o do Campo
aAdd( aSX3Del  , {'FND','16','FND_VLRRLZ','N',16     ,2,'Vlr. Realiz' ,'Val. Realiz' ,'RealizedValu','Valor realizado do item'  ,'Valor realizado del item' ,'Realized value of item'   ,'@E 9,999,999,999,999.99','Positivo()'                                   ,aSX3Copia[3][2],''           ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )

//
// Tabela FNE
//                             
aAdd( aSX3Alter, {'FNE','01','FNE_FILIAL','C',nTamFil   ,0,'Filial'      ,'Sucursal'    ,'Branch'       ,'Filial do Sistema'        ,'Sucursal del sistema'      ,'Branch of System'         ,'@!'                     ,''                                                                                                            ,aSX3Copia[1][2],''                        ,''   ,1,aSX3Copia[1][3],'','','S' ,'N','' ,'' ,'' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'','033','','S' } )
aAdd( aSX3Alter, {'FNE','02','FNE_CODPRJ','C',10        ,0,'Projeto'     ,'Proyecto'    ,'Project'      ,'Codigo do Projeto'        ,'Codigo del proyecto'       ,'Project Code'             ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                        ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','03','FNE_REVIS' ,'C',4         ,0,'Revisao'     ,'Revision'    ,'Revision'     ,'Revisao do projeto'       ,'Revision del proyecto'     ,'Revision of Project'      ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                        ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','04','FNE_ETAPA' ,'C',3         ,0,'Etapa'       ,'Etapa'       ,'Stage'        ,'Etapa do projeto'         ,'Etapa del proyecto'        ,'Stage of project'         ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                        ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','05','FNE_ITEM'  ,'C',3         ,0,'Item Etapa'  ,'Item Etapa'  ,'Stage Item'   ,'Item Etapa'               ,'Item Etapa'                ,'Stage Item'               ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                        ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','06','FNE_ITVIRT','C',3         ,0,'Item'        ,'Item'        ,'Item'         ,'Item Virtual'             ,'Item Virtual'              ,'Virtual item'             ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],'A430IItVir()'            ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','V','V','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','07','FNE_LINHA' ,'C',3         ,0,'Linha'       ,'Linea'       ,'Line'         ,'Linha configuracao Etapa' ,'Linea config. Etapa'       ,'Stage configuration line' ,'@!'                     ,''                                                                                                            ,aSX3Copia[6][2],''                        ,''   ,1,aSX3Copia[6][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','08','FNE_TPCLAS','C',1         ,0,'Tipo Classif','Tipo Clasif' ,'Classif.Type' ,'Tipo da classificacao'    ,'Tipo de clasificacion'     ,'Classification Type'      ,'@!'                     ,'Pertence("123")'                                                                                             ,aSX3Copia[6][2],"'2'"                     ,''   ,1,aSX3Copia[6][3],'','','S' ,'N','V','R','' ,'','1=RECEITA;2=DESPESA;3=MARG.RECEITA'         ,'1=INGRESO;2=GASTO;3=MARG.INGRESO'           ,'1=INCOME;2=EXPENSE;3=INCOME MARGIN'               ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','09','FNE_TPATF' ,'C',2         ,0,'Tipo ATF'    ,'Tipo ATF'    ,'FA Type'      ,'Tipo de ativo'            ,'Tipo de activo'            ,'Type of Asset'            ,'@!'                     ,'Pertence("01|10") .And. AF430AVTIP() '                                                                       ,aSX3Copia[6][2],'"01"'                    ,''   ,1,aSX3Copia[6][3],'','','S' ,'N','A','R','Ä','','01=DEPR. FISCAL;10=DEPR. CONTABIL'          ,'01=DEPR. FISCAL;10=DEPR. CONTABLE'          ,'01=TAX DEPR;10=ACCOUNTING DEPR.','','AF430WTPCL()'                  ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','10','FNE_TPSALD','C',1         ,0,'Tipo Saldo'  ,'Tipo Saldo'  ,'Balance Type' ,'Tipo de Saldo'            ,'Tipo de Saldo'             ,'Balance Type'             ,'@!'                     ,'VldTpSald( M->FNE_TPSALD ) .And. AF430AVTIP()'                                                               ,aSX3Copia[6][2],"'1'"                     ,''   ,1,aSX3Copia[6][3],'','','S' ,'N','A','R','Ä','','#AdmCBGener(xFilial("SX5"),"SX5","SL","01")','#AdmCBGener(xFilial("SX5"),"SX5","SL","01")','#AdmCBGener(xFilial("SX5"),"SX5","SL","01")'      ,'','AF430WTPCL()'                  ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','11','FNE_TPDEPR','C',1         ,0,'Tipo Deprec' ,'Tipo Deprec' ,'Deprec. Type' ,'Metodo de depreciacao'    ,'Metodo de depreciacion'    ,'Method of Depreciation'   ,'@!'                     ,'AF430AVTIP()'                                                                                                ,aSX3Copia[6][2],"'1'"                     ,''   ,1,aSX3Copia[6][3],'','','S' ,'N','A','R','Ä','','#AdmCBGener(xFilial("SN0"),"SN0","04","01")','#AdmCBGener(xFilial("SN0"),"SN0","04","01")','#AdmCBGener(xFilial("SN0"),"SN0","04","01")'      ,'','AF430WTPCL()'                  ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','12','FNE_DINDEP','D',8         ,0,'Dt In Deprec','Fc In Deprec','Depre St Dt'  ,'Data de Inicio Deprec'    ,'Fecha de inicio Deprec'    ,'Depreciation Start Date'  ,''                       ,''                                                                                                            ,aSX3Copia[6][2],'AF430IDEP()'             ,''   ,1,aSX3Copia[6][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','13','FNE_VORIG' ,'N',16        ,2,'Vlr.Original','Vlr.Original','OriginalValu' ,'Valor original do item'   ,'Valor original del item'   ,'Original value of item'   ,'@E 9,999,999,999,999.99','Positivo()'                                                                                                  ,aSX3Copia[3][2],'AF430IVORI()'            ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','14','FNE_VRDACM','N',16        ,2,'Vlr. Dep Acm','Vlr. Dep Acm','AccmDeprValu' ,'Valor Dep Acm do item'    ,'Valor Dep Acm del item'    ,'Item Accum. Depr. Value'  ,'@E 9,999,999,999,999.99','Positivo() .AND. AF430VDP()'                                                                                 ,aSX3Copia[3][2],''                        ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','15','FNE_AVPPLN','N',16        ,2,'AVP Planejad','AVP Planif.' ,'Planned AVP'  ,'AVP planejado do item'    ,'AVP planificado del item'  ,'Item Planned AVP'         ,'@E 9,999,999,999,999.99','Positivo() .AND. AF430AVPPL()'                                                                                                            ,aSX3Copia[3][2],''                        ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','16','FNE_AVPRLZ','N',16        ,2,'AVP Realiz'  ,'AVP Realiz'  ,'Accomp AVP'   ,'AVP realizado do item'    ,'AVP realizado del item'    ,'Item Accomplished AVP'    ,'@E 9,999,999,999,999.99','Positivo() .AND. AF430AVPRZ()'                                                                                                            ,aSX3Copia[3][2],''                        ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','17','FNE_VLRRLZ','N',16        ,2,'Vlr. Realiz' ,'Vlr. Realiz' ,'Value assum.','Valor realizado do item'  ,'Valor realizado del item'   ,'Value assumed for item'   ,'@E 9,999,999,999,999.99','Positivo()'                                   ,aSX3Copia[3][2],''           ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','' ,'',''                                                                                     ,''                                                                                               ,''                                                                                 ,'',''           ,'',''   ,'','S'} )
aAdd( aSX3Alter, {'FNE','18','FNE_GRPBEM','C',4         ,0,'Grupo Bem'   ,'Grupo Bien'  ,'Asset Group'  ,'Grupo de bens'            ,'Grupo de bienes'           ,'Asset group'              ,'@!'                     ,'Vazio() .Or. ExistCPO("SNG") '                                                                               ,aSX3Copia[3][2],'AF430GRPIN()'            ,'SNG',1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','AF430GRPW()'                   ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','19','FNE_ENT01B','C',nTamConta ,0,'Conta Bem'   ,'Cuenta Bien' ,'AssetAccount' ,'Entidade do bem conta'    ,'Entidad de bien cuenta'    ,'Asset entity account'     ,'@!'                     ,'Vazio() .Or.  CTB105CTA()'                                                                                   ,aSX3Copia[3][2],'AF430CTBIN("NG_CCONTAB")','CT1',1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'','003','','S' } )
aAdd( aSX3Alter, {'FNE','20','FNE_ENT02B','C',nTamCCusto,0,'C Custo Bem' ,'C Costo Bem' ,'Asset C.Cntr' ,'Entidade do bem c.custo'  ,'Entidad de bien c costo'   ,'Asset entity cost center' ,'@!'                     ,'Vazio() .Or. CTB105CC()'                                                                                     ,aSX3Copia[3][2],'AF430CTBIN("NG_CUSTBEM")','CTT',1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','CtbMovSaldo("CTT")'            ,'','004','','S' } )
aAdd( aSX3Alter, {'FNE','21','FNE_ENT03B','C',nTamITCtb ,0,'Item Ctb Bem','Item Ctb Bie','AssetAc.Item' ,'Entidade do bem item ctb' ,'Entidad de bien item ctb'  ,'Asset entity acctg. item' ,'@!'                     ,'Vazio() .Or. CTB105Item()'                                                                                   ,aSX3Copia[3][2],'AF430CTBIN("NG_SUBCCON")','CTD',1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','CtbMovSaldo("CTD")'            ,'','005','','S' } )
aAdd( aSX3Alter, {'FNE','22','FNE_ENT04B','C',nTamClVlr ,0,'Class Vl Bem','Clase Vl Bie','Asset Class'  ,'Entidade do bem classe'   ,'Entidad de bien clase'     ,'Entity of asset class'    ,'@!'                     ,'Vazio() .Or. CTB105CLVL()'                                                                                   ,aSX3Copia[3][2],'AF430CTBIN("NG_CLVLCON")','CTH',1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','CtbMovSaldo("CTH")'            ,'','006','','S' } )
aAdd( aSX3Alter, {'FNE','23','FNE_ENT01D','C',nTamConta ,0,'Conta Desp'  ,'Cuenta Gasto','ExpenseAcct.' ,'Entidade despesa conta'   ,'Ente gasto cuenta'         ,'Account expense entity'   ,'@!'                     ,'Vazio() .Or. CTB105CTA()'                                                                                    ,aSX3Copia[3][2],'AF430CTBIN("NG_CDEPREC")','CT1',1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'','003','','S' } )
aAdd( aSX3Alter, {'FNE','24','FNE_ENT02D','C',nTamCCusto,0,'C Custo Desp','CCosto Desp' ,'Exp Cost Cen' ,'Entidade despesa c.cust'  ,'Entidad Gasto CCosto'      ,'Expense Cost C Entity'    ,'@!'                     ,'Vazio() .Or. CTB105CC()'                                                                                     ,aSX3Copia[3][2],'AF430CTBIN("NG_CCDESP")' ,'CTT',1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','CtbMovSaldo("CTT")'            ,'','004','','S' } )
aAdd( aSX3Alter, {'FNE','25','FNE_ENT03D','C',nTamITCtb ,0,'It Ctb Desp' ,'It Ctb Desp' ,'ItemExpEntty' ,'Entidade despesa item'    ,'Ente gasto item'           ,'Item expense entity'      ,'@!'                     ,'Vazio() .Or. CTB105Item()'                                                                                   ,aSX3Copia[3][2],'AF430CTBIN("NG_SUBCDEP")','CTD',1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','CtbMovSaldo("CTD")'            ,'','005','','S' } )
aAdd( aSX3Alter, {'FNE','26','FNE_ENT04D','C',nTamClVlr ,0,'Classe Desp' ,'Clase Gasto' ,'ClassExpense' ,'Entidade despesa classe'  ,'Ente gasto clase'          ,'Class expense entity'     ,'@!'                     ,'Vazio() .Or. CTB105CLVL()'                                                                                   ,aSX3Copia[3][2],'AF430CTBIN("NG_CLVLDEP")','CTH',1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','CtbMovSaldo("CTH")'            ,'','006','','S' } )
aAdd( aSX3Alter, {'FNE','27','FNE_ENT01A','C',nTamConta ,0,'Conta Dep Ac','Cuenta GasAc','AccmDeprAcct' ,'Entidade depr.acm conta'  ,'Ente depr.acm cuenta'      ,'Entity of Accum.Depr.Acct','@!'                     ,'Vazio() .Or. CTB105CTA()'                                                                                    ,aSX3Copia[3][2],'AF430CTBIN("NG_CCDEPR")' ,'CT1',1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'','003','','S' } )
aAdd( aSX3Alter, {'FNE','28','FNE_ENT02A','C',nTamCCusto,0,'CC Dep Acm'  ,'CC Gas Acm'  ,'AccmDeprCC'   ,'Entidade depr.acm c.custo','Ente depr.acm c.costo'     ,'Accum.Depr.CostCtr Entity','@!'                     ,'Vazio() .Or. CTB105CC()'                                                                                     ,aSX3Copia[3][2],'AF430CTBIN("NG_CCCDEP")' ,'CTT',1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','CtbMovSaldo("CTT")'            ,'','004','','S' } )
aAdd( aSX3Alter, {'FNE','29','FNE_ENT03A','C',nTamITCtb ,0,'Item Dep Acm','Item Dep Acm','AccmDeprItem' ,'Entidade depr.acm item'   ,'Ente depr.acm item'        ,'Entity of Accum.Depr.Item','@!'                     ,'Vazio() .Or. CTB105Item()'                                                                                   ,aSX3Copia[3][2],'AF430CTBIN("NG_SUBCCDE")','CTD',1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','CtbMovSaldo("CTD")'            ,'','005','','S' } )
aAdd( aSX3Alter, {'FNE','30','FNE_ENT04A','C',nTamClVlr ,0,'Cl Vl Dep Ac','Cl Vl Dep Ac','AccmDeprClss' ,'Entidade depr.acm classe' ,'Ente depr.acm clase'       ,'Accum.Depr.Class Entity'  ,'@!'                     ,'Vazio() .Or. CTB105CLVL()'                                                                                   ,aSX3Copia[3][2],'AF430CTBIN("NG_CLVLCDE")','CTH',1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','CtbMovSaldo("CTH")'            ,'','006','','S' } )
aAdd( aSX3Alter, {'FNE','31','FNE_CALCDE','C',1         ,0,'Calc.Depr.'  ,'Calc.Depr.'  ,'Depr. Calc.'  ,'Periodicidade do calculo' ,'Periodicidad del calculo'  ,'Calculation periodicity'  ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],'AF430CLDPR()'            ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'','0=MENSAL;1=ANUAL'                           ,'0=MENSUAL;1=ANUAL'                          ,'0=MONTHLY;1=YEARLY'                               ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','32','FNE_PERDEP','N',4         ,0,'Per. Depr.'  ,'Per. Depr.'  ,'Depr.Periods' ,'Periodos de Depreciacao'  ,'Periodos de Depreciacion'  ,'Depreciation Periods'     ,'@E 9,999'               ,'Positivo() '                                                                                                 ,aSX3Copia[3][2],'AF430CTBIN("PERDEP")'    ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','AF430WTPCL() .AND. AF430WCTD(1)','',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','33','FNE_TAXA'  ,'N',6         ,2,'Tx. Depr.'   ,'Ts. Depr.'   ,'Depr. Rate'   ,'Taxa anual de depreciacao','Tasa anual depreciacion'   ,'Annual Depreciation Rate' ,'@E 999.99'              ,'Positivo()'                                                                                                  ,aSX3Copia[3][2],'AF430CTBIN("NG_TXDEPR")' ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','AF430WTPCL() .AND. AF430WCTD(1)','',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','34','FNE_CRIDEP','C',1         ,0,'Crit. Depr.' ,'Crit. Depr.' ,'Depr. Crit.'  ,'Criterio de Depreciacao'  ,'Criterio de Depreciacion'  ,'Depreciation criterion'   ,'@!'                     ,"ExistCpo('SN0','05'+M->FNE_CRIDEPR) .and. VldDeprec() .AND. Iif(FindFunction('AF010VLAEC'),AF010VLAEC(),.t.)",aSX3Copia[5][2],''                        ,''   ,1,aSX3Copia[5][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'','AF430WTPCL()'                  ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','35','FNE_CALDEP','C',15        ,0,'Calendario'  ,'Calendario'  ,'Calendar'     ,'Calendario de depreciacao','Calendario depreciacion'   ,'Depreciation calendar'    ,'@!'                     ,"ExistCpo('SN0','06'+M->FNE_CALDEPR) .AND. Iif(FindFunction('AF010VLAEC'),AF010VLAEC(),.t.)"                  ,aSX3Copia[5][2],''                        ,''   ,1,aSX3Copia[5][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'','AF430WTPCL() .AND. AF430WCTD()','',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','36','FNE_MOEDRF','C',2         ,0,'Moeda Ref.'  ,'Moneda Ref.' ,'Ref.Currency' ,'Moeda de referencia'      ,'Moneda de referencia'      ,'Currency of reference'    ,'@!'                     ,'AF430VMDRF()'                                                                                                ,aSX3Copia[3][2],'AF430RMDF()'             ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','37','FNE_VLMXDP','N',16        ,2,'Vlr Max Dep' ,'Vlr Max Dep' ,'MaxDeprcValu' ,'Valor maximo de deprec'   ,'Valor maximo de deprec'    ,'Maximum Depreciatn Value ','@E 9,999,999,999,999.99','Positivo() .And. AF430VLTDP()'                                                                               ,aSX3Copia[3][2],''                        ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','AF430WTPCL()'                  ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','38','FNE_VLSALV','N',16        ,2,'V Salvamento','V Salvamient','SaveValue'    ,'Valor de salvamento'      ,'Valor de salvamiento'      ,'Saving Value'             ,'@E 9,999,999,999,999.99','Positivo() .And. AF430VLTDP()'                                                                               ,aSX3Copia[3][2],''                        ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','AF430WTPCL() '                 ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNE','39','FNE_PRDEST','N',16        ,2,'Prd Estimada','Prd Estimada','EstimatdProd' ,'Producao estimada'        ,'Produccion estimada'       ,'Estimated Production'     ,'@E 9,999,999,999,999.99','Positivo() .And. AF430VLTDP()'                                                                               ,aSX3Copia[3][2],''                        ,''   ,1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'','AF430WTPCL()'                  ,'',''   ,'','S' } )
aAdd( aSx3Alter, {'FNE','40','FNE_CODIND','C',nTamCodInd,0,'Õnd.calculo' ,'Ind.calculo' ,'Calc. Index'  ,'Codigo do indice de depr.','Codigo de indice de depr.' ,'Depr. Index Code'         ,'@!','ExistCPO("FNI")  .And. AF430VLTDP() ',aSX3Copia[3][2],'','FNI',1,aSX3Copia[3][3],'','','S','N','A','R','','','','','','','AF430WTPCL()','','060','','S'} )
aAdd( aSx3Alter, {'FNE','41','FNE_USRAVP','C',20        ,0,'Usu·rio AVP' ,'Usuario AVP' ,'AVP User'     ,'Usu·rio alteracao AVP ','Usuario modif. AVP ' ,'AVP change user','@!','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )

//
// Tabela FNJ 
//                             
aAdd( aSX3Alter, {'FNJ','01','FNJ_FILIAL','C',nTamFil   ,0,'Filial'        ,'Sucursal'      ,'Branch'         ,'Filial do Sistema'        ,'Sucursal del Sistema'      ,'System Branch'            ,'@!'                     ,''                                                                                                            ,aSX3Copia[1][2],''                      ,''     ,1,aSX3Copia[1][3],'','','S' ,'N','' ,'' ,'' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'','033','','S' } )
aAdd( aSX3Alter, {'FNJ','02','FNJ_CODPRJ','C',10        ,0,'Projeto'       ,'Proyecto'      ,'Project'        ,'Codigo do Projeto'        ,'Codigo del proyecto'       ,'Project Code'             ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                      ,''     ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNJ','03','FNJ_REVIS' ,'C',4         ,0,'Revisao'       ,'Revision'      ,'Review'         ,'Revisao do Projeto'       ,'Revision del proyecto'     ,'Review of the project'    ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                      ,''     ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNJ','04','FNJ_ETAPA' ,'C',3         ,0,'Etapa'         ,'Etapa'         ,'Stage'          ,'Etapa do projeto'         ,'Etapa del proyecto'        ,'Stage of the project'     ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                      ,''     ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNJ','05','FNJ_ITEM'  ,'C',3         ,0,'Item Etapa'    ,'Item Etapa'    ,'Stage Item'     ,'Item da etapa'            ,'Item de la Etapa'          ,'Item of the Stage'        ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                      ,''     ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNJ','06','FNJ_LINHA' ,'C',3         ,0,'Linha'         ,'Linea'         ,'Row'            ,'Linha configuracao Etapa' ,'Linea Configuracion Etapa' ,'Stage configuration row'  ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                      ,''     ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNJ','07','FNJ_TAFPRJ','C',2         ,0,'Tipo ATF Prj'  ,'Tipo ATF Pry'  ,'Prj Asset Tp'   ,'Tipo de ativo Projeto'    ,'Tipo de activo Proyecto'   ,'Project asset type'       ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                      ,''     ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNJ','08','FNJ_SLDPRJ','C',1         ,0,'Tipo Sld Prj'  ,'Tipo Sld Pry'  ,'Prj Bal Tp  '   ,'Tipo de Saldo Projeto'    ,'Tipo de Saldo Proyecto'    ,'Project Balance Type'     ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                      ,''     ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNJ','09','FNJ_ITRELA','C',3         ,0,'Item Relac  '  ,'Item Relac  '  ,'Rela. Item'     ,'Item do Relacionamento'   ,'Item de Relacion'          ,'Relationship Item'        ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                      ,''     ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNJ','10','FNJ_CBAEXE','C',10        ,0,'C Base Exec '  ,'C Base Ejec '  ,'Exec Base C '   ,'CÛdigo Base  ExecuÁ„o'    ,'Codigo Base Ejecucion'     ,'Execution Base Code   '   ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                      ,'SN302',1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                      ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNJ','11','FNJ_ITEXE' ,'C',4         ,0,'Item Exec   '  ,'Item Ejec   '  ,'Exec Item   '   ,'Item ExecuÁ„o        '    ,'Item Ejecucion'            ,'Execution Item          ' ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                      ,''     ,1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNJ','12','FNJ_TAFEXE','C',2         ,0,'Tipo ATF Exe'  ,'Tipo ATF Eje'  ,'Exe Asset Tp'   ,'Tipo de ativo ExecuÁ„o'   ,'Tipo de activo Ejecucion'  ,'Execution asset type'     ,'@!'                     ,''                                                                                                            ,aSX3Copia[3][2],''                      ,''     ,1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'','01=DEPR. FISCAL;10=DEPR. CONTABIL'          ,'01=DEPR. FISCAL;10=DEPR. CONTABLE'          ,'01=TAX DEPR.;10=ACCOUNTING DEPR.'                  ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNJ','13','FNJ_SLDEXE','C',1         ,0,'Tipo SLD Exe'  ,'Tipo SLD Eje'  ,'Exec Bal Tp '   ,'Tipo de Saldo ExecuÁ„o'   ,'Tipo de Saldo Ejecucion'   ,'Execution Balance Type'   ,'@!'                     ,'AF430VLBEX()'                                                                                                ,aSX3Copia[3][2],''                      ,''     ,1,aSX3Copia[3][3],'','','S' ,'N','A','R','' ,'','#AdmCBGener(xFilial("SX5"),"SX5","SL","01")','#AdmCBGener(xFilial("SX5"),"SX5","SL","01")','#AdmCBGener(xFilial("SX5"),"SX5","SL","01")'      ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNJ','14','FNJ_VLREXE','N',16        ,2,'Valor Exec  '  ,'Valor Ejec  '  ,'Exec Value  '   ,'Valor ExecuÁ„o'           ,'Valor Ejecucion'           ,'Execution Value'          ,'@E 9,999,999,999,999.99',''                                                                                                            ,aSX3Copia[3][2],''                      ,''     ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
aAdd( aSX3Alter, {'FNJ','15','FNJ_DTCONT','D',8         ,0,'Data Contab '  ,'Fecha Contab'  ,'Accoun. Date'   ,'Data ContabilizaÁ„o'      ,'Fecha Contabilizacion'     ,'Accounting Date'          ,''                       ,''                                                                                                            ,aSX3Copia[3][2],''                      ,''     ,1,aSX3Copia[3][3],'','','S' ,'N','V','R','' ,'',''                                           ,''                                           ,''                                                 ,'',''                              ,'',''   ,'','S' } )
//
// Tabela FNF - AVP
//
aAdd( aSx3Alter, {'FNF','01','FNF_FILIAL','C',nTamFil   ,0,'Filial'      ,'Sucursal'     ,'Branch'        ,'Filial do Sistema'        ,'Sucursal del Sistema'     ,'Branch of System'        ,''                       ,''                                                 ,aSX3Copia[1][2],''         ,''      ,1,aSX3Copia[1][3],'','','S','N','V','R','','',''                                                                                  ,''                                                                                          ,''                                                                                 ,'',''                                       ,'','033','','S'} )
aAdd( aSx3Alter, {'FNF','02','FNF_CBASE','C',10,0,'Cod. do Bem','Cod. de Bien','Asset Code','Codigo Base do Bem','Codigo Base del Bien','Asset Base Code','@!','ExistCpo("SN1", M->FNF_CBASE)',aSx3Copia[2][2],'','SN1APT',1,	aSX3Copia[2][3],'','','S','S','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','03','FNF_ITEM','C',4,0,'Item','Item','Item','Numero do Item','Numero del Item','Item Number','@!','ExistCpo("SN1", M->(FNF_CBASE + FNF_ITEM))',aSx3Copia[2][2],'','',1,	aSX3Copia[2][3],'','','S','S','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','04','FNF_TIPO','C',2,0,'Tipo Bem','Tipo Bien','Asset Type','Tipo de Bem','Tipo de Bien','Type of Asset','@!','',aSx3Copia[2][2],"'10'",'',1,	aSX3Copia[2][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','05','FNF_SEQ','C',3,0,'Seq.Item ATF','Sec.Item ACT','ATF ItemSequ','Sequenc. do Item do Ativo','Secuenc. Item del Activo','Asset Item Sequence','@!','',aSx3Copia[2][2],'','',1,	aSX3Copia[2][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','06','FNF_TPSALD','C',1,0,'Tp Sld Item','Tp Sld Item','AsstBalancTp','Tipo Saldo Item do Ativo','Tipo Saldo Item de Activo','Asset Item Balance Type','@!','VLDTPSALD(M->FNF_TPSALD)',aSx3Copia[2][2],'','SLD',1,	aSX3Copia[2][3],'','','S','S','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','07','FNF_REVIS' ,'C',4         ,0,'Revisao'     ,'Revision'     ,'Review'        ,'Revisao do AVP'           ,'Revision del AVP'         ,'AVP Review'              ,'@!'                     ,''                                                 ,aSx3Copia[2][2],"'0001'"   ,''      ,1,aSX3Copia[2][3],'','','S','S','V','R','','',''                                                                                  ,''                                                                                          ,''                                                                                 ,'',''                                       ,'',''   ,'','S'} )
aAdd( aSx3Alter, {'FNF','08','FNF_SEQAVP','C',4,0,'Sequencia','Secuencia','Sequence','Sequencia do AVP','Secuencia de AVP','AVP Sequence','@!','',aSx3Copia[2][2],'','',1,aSX3Copia[2][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','09','FNF_TPMOV','C',1,0,'Tp. Movto.','Tp. Movto.','TransctnType','Tipo Movto. AVP','Tipo Movto. AVP','AVP Transaction Type','@!',"Pertence('12345678')",aSx3Copia[6][2],"'1'",'',1,	aSX3Copia[6][3],'','','S','S','V','R','','','#AdmCBGener(xFilial("SN0"),"SN0","14","01")','#AdmCBGener(xFilial("SN0"),"SN0","14","01")','#AdmCBGener(xFilial("SN0"),"SN0","14","01")','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','10','FNF_DTAVP','D',8,0,'Data Movto','Fecha Movto','TransctnDate','Data do Movimento','Fecha del Movimiento','Date of Transaction','','',aSx3Copia[2][2],'dDatabase','',1,	aSX3Copia[2][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','11','FNF_INDAVP','C',2,0,'Indice AVP','Indice AVP','AVP Index','Indice do Movto AVP','Indice de Movto AVP','AVP Transaction Index','@!','ExistCpo("FIT")',aSx3Copia[6][2],'','FIT',1,	aSX3Copia[6][3],'','S','S','S','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','12','FNF_PERIND','C',1         ,0,'Periodic.'   ,'Periodic.'    ,'IndexPerdct'   ,'Periodicidade do Indice'  ,'Periodicidad del Indice'  ,'Index Periodicity'       ,'@!'                     ,'Pertence("12345")'                                ,aSx3Copia[6][2],''         ,''      ,1,aSX3Copia[6][3],'','','S','S','V','R','','','1=Diaria;2=Mensal;3=Trimestral;4=Semestral;5=Anual' ,'1=Diaria;2=Mensual;3=Trimestral;4=Semestral;5=Anual'  ,'1=Daily;2=Monthly;3=Quarterly;4=Biannually;5=Annually'                        ,'',''                                       ,'',''   ,'','S'} )
aAdd( aSx3Alter, {'FNF','13','FNF_TAXA','N',14,8,'Taxa Indice','Tasa Indice','Index Rate','Taxa do indice','Tasa del indice','Index Rate','@E 99,999.99999999','Positivo() .and. NaoVazio()',aSx3Copia[6][2],'','',1,	aSX3Copia[6][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','14','FNF_VALOR','N',16,2,'Valor Movto','Valor Movto','TransctnValu','Valor do Movimento','Valor del movimiento','Transaction Value','@E 9,999,999,999,999.99','Positivo() .and. NaoVazio()',aSx3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','15','FNF_BASE','N',16,2,'Base Calculo','Base Calculo','CalculusBase','Base de calculo do Movto.','Base de calculo de Movto.','Transactn calculatn base','@E 9,999,999,999,999.99','Positivo()',aSx3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','16','FNF_ENT01' ,'C',nTamConta ,0,'Cta. Bem'    ,'Cta. Bien'    ,'AssetAccount'  ,'Conta contabil do bem'    ,'Cuenta contable del bien' ,'Ledger account of asset' ,'@!'                     ,'ExistCpo("CT1")'                                  ,aSx3Copia[6][2],''         ,'CT1'   ,1,aSX3Copia[6][3],'','','S','S','V','R','','',''                                                                                  ,''                                                                                          ,''                                                                                 ,'',''                                       ,'','003','','S'} )
aAdd( aSx3Alter, {'FNF','17','FNF_ENT02','C',nTamCCusto,0,'C.Custo Bem','C.Costo Bien','AssetCostCtr','Centro de Custo do bem','Centro de Costo del bien','Cost Center of Asset','@!','ExistCpo("CTT")',aSx3Copia[3][2],'','CTT',1,	aSX3Copia[3][3],'','','S','S','V','R','','','','','','','','','004','','S'} )
aAdd( aSx3Alter, {'FNF','18','FNF_ENT03','C',nTamITCtb,0,'Item Cta.Bem','Item Cta.Bie','AsstAcctItm','Item Contabil do Bem','Item Contable del Bien','Accounting Item of Asset','@!','ExistCpo("CTD")',aSx3Copia[3][2],'','CTD',1,	aSX3Copia[3][3],'','','S','S','V','R','','','','','','','','','005','','S'} )
aAdd( aSx3Alter, {'FNF','19','FNF_ENT04','C',nTamClVlr,0,'CLVL Bem','CLVL Bien','AssetValClss','Classe de valor do bem','Clase de valor del bien','Asset value class','@!','ExistCpo("CTH")',aSx3Copia[3][2],'','CTH',1,	aSX3Copia[3][3],'','','S','S','V','R','','','','','','','','','006','','S'} )
aAdd( aSx3Alter, {'FNF','20','FNF_STATUS','C',1,0,'Status','Estatus','Status','Status da config. AVP','Estatus de config. AVP','AVP config. status','@!',"Pertence('012789')",aSx3Copia[6][2],"'0'",'',1,	aSX3Copia[6][3],'','','S','N','A','R','','','0=Gerado;1=Ativo;2=Encerrado;7=Bloqueado - Rev;8=Bloqueado - Apr;9=Bloqueado - Usr','0=Generado;1=Activo;2=Encerrado;7=Bloqueado - Rev;8=Bloqueado - Apr;9=Bloqueado - Usr','0=Generated;1=Asset;2=Closed;7=Blocked - Rev;8=Blocked - Apr;9=Blocked - Usr','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','21','FNF_MSBLQL','C',1,0,'Bloqueado','Bloqueado','Blocked','Bloqueia configuracao','Bloquea configuracion','Blocks configuration','@!',"Pertence('12')",aSx3Copia[6][2],"'2'",'',1,	aSX3Copia[6][3],'','','S','S','V','R','','','1=Sim;2=Nao','1=Si;2=No','1=Yes;2=No','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','22','FNF_MOEDA','C',2,0,'Moeda AVP','Moneda AVP','AVP Currency','Moeda do AVP','Moneda do AVP','AVP Currency','@!','',aSX3Copia[2][2],"'01'",'',1,	aSX3Copia[2][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','23','FNF_DTCONT','D',8,0,'Dt.Contabil','Fc.Contable','Booking Date','Data Contabilizacao','Fecha Contabilizacion','Booking Date','','',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','24','FNF_ACMAVP','N',16,2,'AVP Acumulad','AVP Acumulad','Accum. AVP','AVP Acumulado','AVP Acumulado','Accumulated AVP','@E 9,999,999,999,999.99','Positivo()',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','25','FNF_AVPVLP','N',16,2,'Vlr.Presente','Vlr.Presente','Present Value','Valor presente do bem','Valor presente del bien','Present value of asset','@E 9,999,999,999,999.99','Positivo()',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','26','FNF_IDPROC','C',20        ,0,'Id.Proc.AVP' ,'Id.Proc.AVP'  ,'AVP ProcID'    ,'ID do processo de AVP'    ,'ID del proceso de AVP'    ,'ID of AVP process'       ,'@!'                     ,''                                                 ,aSX3Copia[3][2],''         ,''      ,1,aSX3Copia[3][3],'','','S','N','V','R','','',''                                                                                  ,''                                                                                          ,''                                                                                 ,'',''                                       ,'',''   ,'','S'} )
aAdd( aSx3Alter, {'FNF','27','FNF_IDPRCP','C',20,0,'Id.Proc.Pai','Id.Proc.Prin','ParntProcID','ID do processo pai de AVP','ID de proceso prin de AVP','ID of AVP parent process','@!','',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','28','FNF_IDMVAF','C',10,0,'Id.Movt.ATF','Id.Movt.ATF','ATF Trsn. ID','ID do movimento ATF','ID del movimiento ATF','ID of ATF transaction','@!','',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNF','29','FNF_DTEXEC','D',8         ,0,'Dt. Execucao','Fch. Ejec.'   ,'Execution Dt'  ,'Data Prevista de Execucao','Fecha prevista de Ejecuc.','Estimated Execution Date',''                       ,'If(FindFunction("FA440VldAvp"),FA440VldAvp(),.T.)',aSx3Copia[6][2],''         ,''      ,1,aSX3Copia[6][3],'','','S','S','A','R','','',''                                                                                  ,''                                                                                          ,''                                                                                 ,'','If(FindFunction("FA440VldAvp"),.T.,.F.)','',''   ,'','S'} )
//
// Tabela SN1
//
aAdd( aSX3Alter, {'SN1',ProxSX3('SN1','N1_PATRIM' ),'N1_PATRIM' ,'C',1 ,0,'Classificac.','Clasific.'    ,'Classif.'      ,'Classificacao'            ,'Clasificacion'            ,'Classification'          ,'@!'                ,"Vazio().Or.IIf(FindFunction('AF010AVCLS'),AF010AVCLS(),.T.)"          ,aSX3Copia[3][2],'"N"'          ,''     ,1,aSX3Copia[3][3],'','' ,'S','N','' ,'' ,'','','#AdmCBGener(xFilial("SN0"),"SN0","07","N")','#AdmCBGener(xFilial("SN0"),"SN0","07","N")','#AdmCBGener(xFilial("SN0"),"SN0","07","N")','',''                                   ,'','','1','S'} )
aAdd( aSX3Alter, {'SN1',ProxSX3('SN1','N1_PROJETO'),'N1_PROJETO','C',10,0,'Cod. Projeto','Cod. Proyect' ,'Project Code'  ,'Codigo do Projeto'        ,'Codigo del Proyecto'      ,'Project Code'            ,''                  ,"IIf(FindFunction('AF010VLPRJ'),AF010VLPRJ(1),.T.)"                    ,aSX3Copia[3][2],''             ,'FNB02',1,aSX3Copia[3][3],'','' ,'S','N','A','R','','',''                                          ,''                                          ,''                                          ,'','IIf(FindFunction("AF010UPRJ"),AF010UPRJ(),.F.)' ,'','','9','S'} )
aAdd( aSX3Alter, {'SN1',ProxSX3('SN1','N1_PROJREV'),'N1_PROJREV','C',4 ,0,'Rev. Projeto','Rev.Proyecto' ,'Project Rev.'  ,'Revisao do projeto'       ,'Revision del proyecto'    ,'Review of project'       ,'@!'                ,''                                                                     ,aSX3Copia[3][2],''             ,''     ,1,aSX3Copia[3][3],'','' ,'S','N','V','R','','',''                                          ,''                                          ,''                                          ,'',''                                   ,'','','9','S'} )
aAdd( aSX3Alter, {'SN1',ProxSX3('SN1','N1_PROJETP'),'N1_PROJETP','C',3 ,0,'Etapa Prj'   ,'Etapa Proyec' ,'Proj. Stage'   ,'Etapa do projeto'         ,'Etapa del proyecto'       ,'Stage of project'        ,'@!'                ,''                                                                     ,aSX3Copia[3][2],''             ,''     ,1,aSX3Copia[3][3],'','' ,'S','N','V','R','','',''                                          ,''                                          ,''                                          ,'',''                                   ,'','','9','S'} )
aAdd( aSX3Alter, {'SN1',ProxSX3('SN1','N1_PROJITE'),'N1_PROJITE','C',3 ,0,'Item projeto','Item proyect' ,'Proj. Item'    ,'Item da etapa do projeto' ,'Item de etapa del proyect','Item of project stage'   ,'@!'                ,''                                                                     ,aSX3Copia[3][2],''             ,''     ,1,aSX3Copia[3][3],'','' ,'S','N','V','R','','',''                                          ,''                                          ,''                                          ,'',''                                   ,'','','9','S'} )
aAdd( aSx3Alter, {'SN1',ProxSX3('SN1','N1_INIAVP') ,'N1_INIAVP' ,'D',8 ,0,'Dt. Ini AVP' ,'Fc Ini AVP'  ,'AVP Start Dt'  ,'Data Inicio AVP'           ,'Fecha Inico AVP'          ,'AVP Start Date'          	,''                  ,'A010VInAVP()'                                               ,aSx3Copia[3][2],'M->N1_AQUISIC',''   ,1,aSX3Copia[3][3],'','','S','N','A','R','','',''                                          ,''                                          ,''                                          ,'',''                                  ,'','','8','S'} )
aAdd( aSx3Alter, {'SN1',ProxSX3('SN1','N1_DTAVP')  ,'N1_DTAVP'  ,'D',8 ,0,'Dt. Execucao','Fc. Ejecucio' ,'Execution Dt'  ,'Data Prevista de Execucao','Fecha Prevista Ejecucion' ,'Estimated Execution Date',''                  ,'FA010VldAvp(M->N1_DTAVP, M->N1_INDAVP)'                      ,aSx3Copia[3][2],''             ,''   ,1,aSX3Copia[3][3],'','','S','N','A','R','','',''                                          ,''                                          ,''                                          ,'',''                                  ,'','','8','S'} )
aAdd( aSx3Alter, {'SN1',ProxSX3('SN1','N1_INDAVP') ,'N1_INDAVP' ,'C',2 ,0,'Indice AVP'  ,'Indice AVP'   ,'AVP Index'     ,'Indice AVP do Bem'        ,'Indice AVP de Bien'       ,'AVP Index of Asset'      ,'@!'                ,'FA010VldAvp(M->N1_DTAVP, M->N1_INDAVP)'                      ,aSx3Copia[3][2],''             ,'FIT',1,aSX3Copia[3][3],'','','S','N','A','R','','',''                                          ,''                                          ,''                                          ,'',"If(FindFunction('A010AvpWhen'),A010AvpWhen(),.T.)"                                  ,'','','8','S'} )
aAdd( aSx3Alter, {'SN1',ProxSX3('SN1','N1_TAXAVP') ,'N1_TAXAVP' ,'N',14,8,'Taxa Indice' ,'Tasa Indice'  ,'Index Rate'    ,'Taxa do indice'           ,'Tasa de indice'           ,'Rate of Index'           ,'@E 99,999.99999999','Positivo()'                                                 ,aSx3Copia[3][2],''             ,''   ,1,aSX3Copia[3][3],'','','S','N','V','R','','',''                                          ,''                                          ,''                                          ,'',''                                  ,'','','8','S'} )
aAdd( aSX3Alter, {'SN1',ProxSX3('SN1','N1_TPAVP')  ,'N1_TPAVP'  ,'C',1 ,0,'Tipo AVP'    ,'Tipo AVP'     ,'AVP Type'      ,'Tipo de AVP'              ,'Tipo de AVP'              ,'AVP Type'             	,'@!'                ,'Pertence("12") .and. Iif(FindFunction("AF010TPAVP"),AF010TPAVP(),.T.)',aSX3Copia[3][2],'"1"'    ,''   ,1,aSX3Copia[3][3],'','','S','N','A','R','','','1=Total;2=Parcela'                         ,'1=Total;2=Cuota'                           ,'1=Total;2=Installment'                     ,'',''                                  ,'','','8','S'} )
aAdd( aSX3Alter, {'SN1',ProxSX3('SN1','N1_MARGEM') ,'N1_MARGEM' ,'C',6 ,0,'Cod. Margem' ,'Cod. Margen' ,'Margin Code'  ,'Codigo Margem GerenciaL'    ,'Codigo Margen Gerenc'	 ,'Management Margin Code'	,"@!","FA010MrgVld(M->N1_MARGEM, M->N1_REVMRG)",aSX3Copia[3][2],''       ,'FNQ',1,aSX3Copia[3][3],'','' ,'S','N','A','R','','',''                                          ,''                                          ,''                                          ,'',"If(FindFunction('A010MrgWhen'),A010MrgWhen(),.F.)" ,'','','1','S'} )
aAdd( aSX3Alter, {'SN1',ProxSX3('SN1','N1_REVMRG') ,'N1_REVMRG','C',4 ,0,'Rev. Margem  ','Rev. Margen' ,'Margin Rev.'  ,'Revisao da Margem'       	 ,'Revision del margen'      ,'Margin Review'           ,'@!','FA010MrgVld(M->N1_MARGEM, M->N1_REVMRG)',aSX3Copia[3][2],''       ,''   ,1,aSX3Copia[3][3],'','' ,'S','N','V','R','','',''                                          ,''                                          ,''                                          ,'',''                                   ,'','','1','S'} )

//
// Tabela FNP - AVP
//
aAdd( aSx3Alter, {'FNP','01','FNP_FILIAL','C',nTamFil,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal del Sistema','System Branch','','',aSX3Copia[1][2],'','',1,	aSX3Copia[1][3],'','','S','N','V','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FNP','02','FNP_DTPROC','D',8,0,'Data Proc.','Fecha Proc','ProcssngDate','Data do Processamento','Fecha de Procesamiento','Date of Processing','','',aSx3Copia[2][2],'dDatabase','',1,	aSX3Copia[2][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNP','03','FNP_IDPROC','C',20,0,'Id.Proc.AVP','Id.Proc.AVP','AVP Proc ID','ID do processo de AVP','ID de proceso de AVP','AVP Process ID','@!','',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNP','04','FNP_STATUS','C',1      ,0,'Status'      ,'Estatus'     ,'Status'      ,'Status do processo'   ,'Estatus del proceso'   ,'Status of process' ,'@!',"Pertence('12')",aSX3Copia[6][2],"'1'"      ,'',1,aSX3Copia[6][3],'','','S','S','V','R','','','1=Realizado;2=Cancelado','1=Realizado;2=Anulado','1=Executed;2=Canceled','','','',''   ,'','S'} )
aAdd( aSx3Alter, {'FNP','05','FNP_USERGI','C',17,0,'Log de Inclu','Log de Inclu','Addition Log','Log de Inclusao','Log de Inclusion','Addition Log','','',aSX3Copia[1][2],'','',9,	aSX3Copia[1][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNP','06','FNP_USERGA','C',17     ,0,'Log de Alter','Log de Modif','Change Log'  ,'Log de Alteracao'     ,'Log de Modificacion'   ,'Modification Log'  ,''  ,''              ,aSX3Copia[1][2],''         ,'',9,aSX3Copia[1][3],'','','S','N','V','R','','',''                       ,''                      ,''                      ,'','','',''   ,'','S' } )

//criacao de campos de acordo com o requisito: P11-5_CTR_150-10: Ativo Fixo: AdequaÁ„o ao ICPC 01?? Contratos de Concess„o
aAdd( aSx3Alter, {'FNI','01','FNI_FILIAL','C',nTamFil,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal del sistema','Branch of System','@!',      ''     ,aSX3Copia[1][2],'',           '',         1,	  aSX3Copia[1][3],'','','','N','V','','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FNI','02','FNI_CODIND','C',nTamCodInd,0,'Cod.Õndice','Cod.Indice','Index Code','CÛdigo do Õndice','Codigo del indice','Code of Index','@!','ExistChav("FNI",M->(FNI_CODIND+FNI_REVIS))',aSX3Copia[6][2],'','',1,	aSX3Copia[6][3],'','','S','S','A','R','','','','','','','INCLUI','','060','','S'} )
aAdd( aSx3Alter, {'FNI','03','FNI_REVIS','C',4,0,'Revisao','Revision','Review','Revisao do Indice','Revision del Indice','Index Review','@!','',aSX3Copia[2][2],"'0001'",'',1,	aSX3Copia[2][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNI','04','FNI_DSCIND','C',20,0,'DescriÁ„o','Descripcion','Description','DescriÁ„o do Ìndice','Descripcion del indice','Description of Index','@!','',aSX3Copia[6][2],'','',1,	aSX3Copia[6][3],'','','S','S','A','R','','','','','','','INCLUI .OR. ALTERA','','','','S'} )
aAdd( aSx3Alter, {'FNI','05','FNI_PERIOD','C',1,0,'PerÌodo','Periodo','Period','Periodicidade do Õndice','Periodicidad del indice','Index Periodicity','@!','Pertence ("12345")',aSX3Copia[6][2],'','',1,	aSX3Copia[6][3],'','','S','S','A','R','','','1=Di·ria;2=Mensal;3=Trimestral;4=Semestral;5=Anual','1=Diaria;2=Mensual;3=Trimestral;4=Semestral;5=Anual','1=Daily;2=Monthly;3=Quarterly;4=Semiannually;5=Annually','','INCLUI','','','','S'} )
aAdd( aSx3Alter, {'FNI','06','FNI_MSBLQL','C',1,0,'Bloqueado','Bloqueado','Blocked','Registro bloqueado','Registro bloqueado','Blocked Record','@!','Pertence("12")',aSX3Copia[3][2],'"2"','',1,	aSX3Copia[3][3],'','','S','N','A','R','','','1=Sim;2=N„o','1=Si;2=No','1=Yes;2=No','','INCLUI','','','','S'} )
aAdd( aSX3Alter, {'FNI','07','FNI_TIPO','C',1,0,'Tipo','Tipo','Type','Tipo do Indice','Tipo del indice','Index Type','','',aSX3Copia[3][2],'"1"','',1,	aSX3Copia[3][3],'','','','S','A','R','','','1=Informado;2=Calculado','1=Informado;2=Calculado','1=Informed;2=Calculated','','','','','','S'})

//criacao de campos de acordo com o requisito: M12.0CTR01 1407.1: Ativo Fixo: Adequacao ao ICPC 01?? Contratos de Concessao
aAdd( aSx3Alter, {'FNI','08','FNI_CURVIN','D',8,0,'Ini Curva'      ,'Ini Curva','Curve St' ,'Inicio Curva Demanda','Inicio Curva Demanda','Demand Curve Start','','',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','N','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNI','09','FNI_CURVFI','D',8,0,'Fim Curva'      ,'Fin Curva','Curve End','Fim Curva Demanda','Fin Curva Demanda','Demand Curve End','','',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','N','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNI','10','FNI_DTREV' ,'D',8,0,'Dt Revis'       ,'Fc Revis' ,'Rev Dt'   ,'Data Revis Curva Demanda ','Fecha Revis Curva Demanda','Demand Curve Review Dt','','',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','N','A','R','','','','','','','','','','','S'} )
aAdd( aSX3Alter, {'FNI','11','FNI_STATUS','C',1,0,'Status'         ,'Estatus'  ,'Status'   ,'Status do Indice Deprec','Estatus del Indice Deprec','Deprec Index Status','','',aSX3Copia[3][2],"'1'",'',1,	aSX3Copia[3][3],'','','S','N','V','R','','','1=Ativo;2=Bloq Revisao','1=Activo;2=Bloq Revision','1=Active;2=Block Review','','','','','','S'})

//Inclus√£o do campo C√≥digo de Indice 
aAdd( aSx3Alter, {'SN3',ProxSX3("SN3","N3_CODIND"),'N3_CODIND','C',nTamCodInd,0,'Õnd.c·lculo','Ind calculo','Calc Index','CÛdigo do Ìndice de depr.','Codigo del indie de depr','Deprec index code','@!','( Vazio() .Or. ExistCPO("FNI") ) ',aSX3Copia[3][2],'','FNI',1,aSX3Copia[3][3],'','','S','N','A','R','','','','','','','IIF(GDFieldGet("N3_TPDEPR") == "A", .T.,.F.) ','','060','','S'} )

//Ativo Custo/Provisao
aAdd( aSx3Alter, {'SN3',ProxSX3("SN3","N3_ATFCPR") ,'N3_ATFCPR' ,'C' ,1 ,0,'Atf.Custo/Pr'      ,'Ac.Fj.Cos/Pr'     ,'Atf.Custo/Pr','Ativo de Custo/Provisao','Activo de costo/Provision','','@!',"Pertence(' |1|2')",aSX3Copia[3][2],"'2'" ,'' ,1,aSX3Copia[3][3],'','' ,'S','S','A','R','','','1=Sim;2=N„o','1=Si;2=No','1=Yes;2=No','','If(FindFunction("AFXAtCsPrv"),AFXAtCsPrv(),.F.)','','','','S'} )
aAdd( aSx3Alter, {'FNG',ProxSX3("FNG","FNG_ATFCPR"),'FNG_ATFCPR','C' ,1 ,0,'Atf.Custo/Pr'      ,'Ac.Fj.Cos/Pr'     ,'Atf.Custo/Pr','Ativo de Custo/Provisao','Activo de costo/Provision','','@!',"Pertence(' |1|2')",aSX3Copia[3][2],"'2'" ,'' ,1,aSX3Copia[3][3],'','' ,'S','S','A','R','','','1=Sim;2=N„o','1=Si;2=No','1=Yes;2=No','','If(FindFunction("AFXAtCsPrv"),AFXAtCsPrv(),.F.)','','','','S'} )

FINX3Field( "N3_TXDEPR1"	,	"X3_WHEN"	,	"IIf(FindFunction('AF010ATXDP'),AF010ATXDP(),.T.)"	)
FINX3Field( "N3_TXDEPR2"	,	"X3_WHEN"	,	"IIf(FindFunction('AF010ATXDP'),AF010ATXDP(),.T.)"	)
FINX3Field( "N3_TXDEPR3"	,	"X3_WHEN"	,	"IIf(FindFunction('AF010ATXDP'),AF010ATXDP(),.T.)"	)
FINX3Field( "N3_TXDEPR4"	,	"X3_WHEN"	,	"IIf(FindFunction('AF010ATXDP'),AF010ATXDP(),.T.)"	)
FINX3Field( "N3_TXDEPR5"	,	"X3_WHEN"	,	"IIf(FindFunction('AF010ATXDP'),AF010ATXDP(),.T.)"	)

FINX3Field( "N3_TXDEPR1"	,	"X3_TITENG"	,	"An.Dep.Rt.1"	)
FINX3Field( "N3_TXDEPR2"	,	"X3_TITENG"	,	"An.Depr.Rt 2"	)
FINX3Field( "N3_TXDEPR3"	,	"X3_TITENG"	,	"An.Depr.Rt 3"	)
FINX3Field( "N3_TXDEPR4"	,	"X3_TITENG"	,	"An.Depr.Rt 4"	)
FINX3Field( "N3_TXDEPR5"	,	"X3_TITENG"	,	"An.Depr.Rt 5"	)

FINX3Field( "N3_TXDEPR1"	,	"X3_DESCSPA"	,	"Tasa Anual Depreciacion 1"	)
FINX3Field( "N3_TXDEPR1"	,	"X3_TRIGGER"	,	"S"	)

FINX3Field( "N3_TXDEPR1"	,	"X3_DESCENG"	,	"Annual Deprec. Rate 1"	)
FINX3Field( "N3_TXDEPR2"	,	"X3_DESCENG"	,	"Annual Deprec. Rate 2"	)
FINX3Field( "N3_TXDEPR3"	,	"X3_DESCENG"	,	"Annual Deprec. Rate 3"	)
FINX3Field( "N3_TXDEPR4"	,	"X3_DESCENG"	,	"Annual Deprec. Rate 4"	)
FINX3Field( "N3_TXDEPR5"	,	"X3_DESCENG"	,	"Annual Deprec. Rate 5"	)

//campos da tabela FNT
aAdd( aSx3Alter, {'FNT','01','FNT_FILIAL','C',nTamFil,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal del sistema','Branch of System','@!',      ''     ,aSX3Copia[1][2],'',           '',         1,	  aSX3Copia[1][3],'','','','N','V','','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FNT','02','FNT_CODIND','C',nTamCodInd,0,'Cod.Õndice','Cod.Indice','Index Code','CÛdigo do Õndice','Codigo del indice','Index Code','@!','ExistCPO("FNI")',aSX3Copia[2][2],'','',1,	aSX3Copia[2][3],'','','S','S','A','R','','','','','','','','','060','','S'} )
aAdd( aSx3Alter, {'FNT','03','FNT_REVIS','C',4,0,'Rev.Tx.Ind.','Rev.Ts.Ind.','Ind.Rate Rev','Revis„o da taxa do Õndice','Revision tasa del indice','Index Rate Revision','@!','',aSX3Copia[2][2],"'0001'",'',1,	aSX3Copia[2][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNT','04','FNT_DATA','D',8,0,'Dt.Tx.Ind.','Fch.Ts.Ind.','IndxRateDate','Data da taxa do Ìndice','Fecha tasa del indice','Date of Index Rate','','AF006VlDt()',aSX3Copia[2][2],'dDatabase','',1,	aSX3Copia[2][3],'','','S','S','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNT','05','FNT_TAXA','N',14,8,'Taxa Ìndice','Tasa indice','Index Rate','Taxa do Ìndice','Tasa del indice','Index Rate','@E 99,999.99999999','Positivo()',aSX3Copia[3][2],"",'',1,	aSX3Copia[3][3],'','','S','S','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNT','06','FNT_TIPO','C',1,0,'Tipo da taxa','Tipo de tasa','Rate Type','Tipo da taxa','Tipo de tasa','Type of Rate','@!','Pertence("12")',aSX3Copia[5][2],'"2"','',1, aSX3Copia[5][3],'','','S','N','V','R','','','1=Prevista;2=Efetiva','1=Prevista;2=Efectiva','1=Estimated;2=Actual','','','','','','S'} )
aAdd( aSx3Alter, {'FNT','07','FNT_STATUS','C',1,0,'Status','Estatus','Status','Status da taxa','Estatus de tasa','Rate Status','@!','',aSX3Copia[3][2],'"1"','',1,	aSX3Copia[3][3],'','','S','N','V','R','','','1=Ativo;2=Encerrado;3=Pendente-ImportaÁ„o;4=Rejeitado-ImportaÁ„o;7=Bloqueado-Rev;8=Bloqueado-Apr;9=Bloqueado-Usr','1=Activo;2=Finalizado;3=Pendiente-Importacion;4=Rechazado-Importacion;7=Bloqueado-Rev;8=Bloqueado-Apr;9=Bloqueado-Usr','1=Active;2=Closed;3=Pending-Import;4=Rejected-Import;7=Blocked-Rev;8=Blocked-Apr;9=Blocked-Usr','','','','','','S'} )
aAdd( aSx3Alter, {'FNT','08','FNT_MSBLQL','C',1,0,'Bloqueado?','øBloqueado?','Blocked?','Registro bloqueado','Registro bloqueado','Blocked Record','@!','',aSX3Copia[3][2],'"2"','',1,	aSX3Copia[3][3],'','','N','N','A','R','','','1=Sim;2=Nao','1=Si;2=No','1=Yes;2=No','','','','','','S'} )
aAdd( aSx3Alter, {'FNT','09','FNT_DTVLDF','D',8,0,'Dt.Valid. Tx','Fc.Valid. Ts','RateValidity','Data de Validade da Taxa','Fecha de validez de Tasa','Date of Rate Validity','','',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )

//criacao de campos de acordo com o requisito: M12.0CTR01 1407.1: Ativo Fixo: Adequacao ao ICPC 01?? Contratos de Concessao
aAdd( aSX3Alter, {'FNT','10','FNT_CURVA','N',16,2,'Curva','Curva','Curve','Curva de Demanda','Curva de Demanda','Demand Curve','@E 9,999,999,999,999.99','Positivo()',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','','S','A','R','','','','','','','','','','','S'})



aAdd( aSx3Alter, {'CV8',ProxSX3('CV8','CV8_SBPROC') ,'CV8_SBPROC','C',15,0,'Sub Processo','Sub Proceso','Subprocess','Sub Processo','Sub Proceso','Subprocess','@!','',aSx3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','S','V','R','','','','','','','','','','','S'} )
AADD( aSx3Alter, {'CV8',ProxSX3('CV8','CV8_IDMOV')  ,'CV8_IDMOV' ,"C",10,0,"ID Movtos","ID Movtos","Transctns ID","ID Movimentos","ID Movimientos","ID of Transactions","@!",'',aSx3Copia[5][2],'','',1,aSX3Copia[5][3],'','','S','S','V','R','','','','','','','','','','','S'} )
//
//Tabela FNH - OperaÁıes com controle de aprovaÁ„o
// 
aAdd( aSx3Alter, {'FNH','01','FNH_FILIAL','C',nTamFil,0,'Filial'      ,'Sucursal'    ,'Branch'      ,'Filial do Sistema'       ,'Sucursal del Sistema'     ,'Branch of System'                        ,''  ,''                                  ,aSX3Copia[1][2],''                                                                                   ,''     ,1,aSX3Copia[1][3],'','' ,'S','N','V','R','','',''                           ,''                        ,''                    ,'','',''                                                                   ,'033','','S'} )
aAdd( aSx3Alter, {'FNH','02','FNH_ROTINA','C',10     ,0,'Rotina'      ,'Rutina'      ,'Routine'     ,'Rotina do ambiente'      ,'Rutina del entorno'       ,'Routine of environment'  ,'@!',"ExistCpo('SN0','20'+M->FNH_ROTINA)",aSX3Copia[2][2],''                                                                                   ,'SN020',1,aSX3Copia[2][3],'','S','S','S','V','R','','',''                           ,''                        ,''                    ,'','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNH','03','FNH_DESCRT','C',20,0,'Desc. Rotina','Desc. Rutina','Routine Desc','DescriÁ„o da rotina','Descripcion de la rutina','Routine Description','@!','', aSX3Copia[2][2],"If(!INCLUI,Posicione('SN0',1,xFilial('SN0')+'20'+FNH->FNH_ROTINA ,'N0_DESC01'),' ')",'',1,aSX3Copia[2][3],'','','S','S','V','V','','','','','','','',"Posicione('SN0',1,xFilial('SN0')+'20'+FNH->FNH_ROTINA ,'N0_DESC01')",'','','S'} )
aAdd( aSx3Alter, {'FNH','04','FNH_OPER'  ,'C',2      ,0,'OperaÁ„o'    ,'Operacion'   ,'Operation'   ,'OperaÁ„o da rotina'      ,'Operacion de rutina'      ,'Routine Operation'       ,'@!',"ExistCpo('SN0','21'+M->FNH_OPER)"  ,aSX3Copia[2][2],''                                                                                   ,'SN021',1,aSX3Copia[2][3],'','S','S','S','V','R','','',''                           ,''                        ,''                    ,'','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNH','05','FNH_DESCOP','C',20     ,0,'Desc. Opera.','Desc. Opera.','Oper. Desc.' ,'DescriÁ„o da operaÁ„o'   ,'Descripcion de operacion' ,'Operation Description'   ,'@!',''                                  ,aSX3Copia[2][2],"If(!INCLUI,Posicione('SN0',1,xFilial('SN0')+'21'+FNH->FNH_OPER ,'N0_DESC01'),' ')"  ,''     ,1,aSX3Copia[2][3],'','' ,'S','S','V','V','','',''                           ,''                        ,''                    ,'','',"Posicione('SN0',1,xFilial('SN0')+'21'+FNH->FNH_OPER ,'N0_DESC01')"  ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNH','06','FNH_STATUS','C',1      ,0,'Status'      ,'Estatus'     ,'Status'      ,'Status controle operaÁ„o','Estatus control operacion','Operation Control Status','@!',"Pertence('1|2')"                   ,aSX3Copia[6][2],"'2'"                                                                                ,''     ,1,aSX3Copia[6][3],'','' ,'S','S','A','R','','','1=Habilitado;2=Desabilitado','1=Activado;2=Desactivado','1=Enabled;2=Disabled','','',''                                                                   ,''   ,'','S'} )

//
//Tabela FNK - Alcadas aprovacao por operacao
//
aAdd( aSx3Alter, {'FNK','01','FNK_FILIAL','C',nTamFil ,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal do Sistema','Branch','','',aSX3Copia[1][2],'','',1,	aSX3Copia[1][3],'','','S','N','V','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FNK','02','FNK_ROTINA','C',10     ,0,'Rotina'     ,'Rutina'      ,'Routine'     ,'Rotina do ambiente'      ,'Rutina del entorno'       ,'Routine of environment'  ,'@!','ExistCpo("SN0","20"+M->FNK_ROTINA) .AND. ExistChav("FNK",M->FNK_ROTINA+M->FNK_REVIS)',aSx3Copia[2][2],"If(FindFunction('AF003INROT'),AF003INROT(),'')" ,'SN020',1,aSX3Copia[2][3],'','' ,'S','S','A','R','','',''                           ,''                        ,''                           ,'','',''                                                                                 ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNK','03','FNK_DESCRT','C',20,0,'Desc.Rotina','Desc.Rutina','RoutinDescr','DescriÁ„o da rotina','Descripcion de rutina','Description of Routine','@!','',aSx3Copia[6][2],"If(FindFunction('AF003INIC'),AF003INIC('1'),'')",'',1,	aSX3Copia[6][3],'','','S','S','V','V','','','','','','','','Posicione("SN0",1,xFilial("SN0")+"20"+FNK->FNK_ROTINA ,"SUBSTR(N0_DESC01,1,20)") ','','','S'} )
aAdd( aSx3Alter, {'FNK','04','FNK_REVIS' ,'C',4 ,0,'Revis„o','Revision','Revision','Revis„o da alÁada','Revision de pertinencia','Revision of jurisdiction','@!','',aSx3Copia[2][2],"If(FindFunction('AF003INREV'),AF003INREV(),'')",'',1,	aSX3Copia[2][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNK','05','FNK_STATUS','C',1 ,0,'Status','Estatus','Status','Status controle operacao','Estatus control operacion','Operation Control Status','@!',"Pertence('12')",aSx3Copia[6][2],"'1'",'',1,aSX3Copia[6][3],'','','S','S','A','R','','','1=Habilitado;2=Desabilitado','1=Activado;2=Desactivado','1=Enabled;2=Disabled','','','','','','S'} )
//
//Tabela FNL - Itens alcada de aprovacao por operacao
//
aAdd( aSx3Alter, {'FNL','01','FNL_FILIAL','C',nTamFil ,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal do Sistema','Branch of System','','',aSX3Copia[1][2],'','',1,	aSX3Copia[1][3],'','','S','N','V','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FNL','02','FNL_ROTINA','C',10      ,0,'Rotina','Rutina','Routine','Rotina do ambiente','Rutina del entorno','Routine of environment','@!',"ExistCpo('SN0','20'+M->FNL_ROTINA)",aSx3Copia[6][2],'','SN020',1,	aSX3Copia[6][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNL','03','FNL_REVIS' ,'C',4       ,0,'Revis„o','Revision','Revision','Revis„o da alÁada','Revision de pertinencia','Revision of jurisdiction','@!','',aSx3Copia[6][2],'','',1,	aSX3Copia[6][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNL','04','FNL_STATUS','C',1       ,0,'Status','Estatus','Status','Status controle operacao','Estatus control operacion','Operation Control Status','@!',"Pertence('12')",aSx3Copia[6][2],"'1'",'',1,aSX3Copia[6][3],'','','S','N','A','R','','','1=Habilitado;2=Desabilitado','1=Activado;2=Desactivado','1=Enabled;2=Disabled','','','','','','S'} )
aAdd( aSx3Alter, {'FNL','05','FNL_OPER'  ,'C',2       ,0,'OperaÁ„o'    ,'Operacion'   ,'Operation'   ,'OperaÁ„o da rotina'      ,'Operacion de la rutina','Operation of routine'        ,'@!'                     ,"ExistCpo('FNH',M->FNK_ROTINA+M->FNL_OPER)"  ,aSx3Copia[6][2],''                                               ,'FNH01',1,aSX3Copia[6][3],'','','S','N','A','R','','',''                                        ,''                                           ,''                                                ,'',''                                             ,''                                                                              ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNL','06','FNL_DESCOP','C',20      ,0,'Desc.Oper.' ,'Desc.Oper.','OperatnDescr','DescriÁ„o da operaÁ„o'   ,'DescriÁ„o de operacion' ,'Description of Operation'    ,'@!'                     ,''                                  ,aSx3Copia[6][2],"If(FindFunction('AF003INIC'),AF003INIC('2'),'')",''     ,1,aSX3Copia[6][3],'','','S','N','V','V','','',''                                        ,''                                           ,''                                                ,'',''                                             ,'Posicione("SN0",1,xFilial("SN0")+"21"+FNL->FNL_OPER,"Substr(N0_DESC01,1,20)") ',''   ,'','S'} )
aAdd( aSx3Alter, {'FNL','07','FNL_TIPO'  ,'C',1       ,0,'Tipo AlÁada','Tipo Pertin.','JurisdcnType','Tipo controle de alÁada','Tipo control pertinencia','Jurisdiction Control Type','@!','',aSx3Copia[5][2],"'1'",'',1,	aSX3Copia[5][3],'','','S','N','V','R','','','1=Simples;2=Valor','1=Simple;2=Valor','1=Simple;2=Value','','','','','','S'} )
aAdd( aSx3Alter, {'FNL','08','FNL_CODAPR','C',6       ,0,'Aprovador'   ,'Aprobador'   ,'Approver'    ,'Codigo do Aprovador'     ,'Codigo de Aprobador'      ,'Approver Code'            ,'@!'                     ,'UsrExist(M->FNL_CODAPR)'           ,aSx3Copia[6][2],''                                               ,'USR'  ,1,aSX3Copia[6][3],'','','S','N','A','R','','',''                                        ,''                                           ,''                                                ,'',''                                             ,''                                                                              ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNL','09','FNL_NOMAPR','C',25      ,0,'Nome Aprov','Nom Aprob.','ApproverName','Nome do aprovador','Nombre de aprobador','Name of approver','@!','',aSx3Copia[3][2],"If(FindFunction('AF003GNAP'),AF003GNAP(),'')",'',1,aSX3Copia[3][3],'','','S','N','V','V','','','','','','','','UsrRetName(FNL->FNL_CODAPR)','','','S'} )
aAdd( aSx3Alter, {'FNL','10','FNL_PERIOD','C',1       ,0,'Per.AlÁada','Per.Pertinen','JurisdPeriod','Periodicidade da alÁada','Periodicidad Pertinencia','Jurisdiction periodicity','@!',"Pertence('0123')",aSx3Copia[5][2],"'0'",'',1,aSX3Copia[5][3],'','','S','N','A','R','','','0=N„o controla;1=Di·rio;2=Mensal;3=Anual','0=No controla;1=Diario;2=Mensual;3=Anual','0=Does not control;1=Daily;2=Monthly;3=Yearly','','FWFLDGET("FNL_TIPO") == "2"','','','','S'} )
aAdd( aSx3Alter, {'FNL','11','FNL_VALOR' ,'N',16      ,2,'Valor'       ,'Valor'       ,'Value'       ,'Valor da AlÁada'         ,'Valor de pertinencia'     ,'Jurisdiction Value'       ,'@E 9,999,999,999,999.99','Positivo()'                        ,aSx3Copia[5][2],''                                               ,''     ,1,aSX3Copia[5][3],'','','S','N','A','R','','',''                                        ,''                                           ,''                                                ,'',"If(FindFunction('AF003BLQV'),AF003BLQV(),.F.)",''                                                                              ,''   ,'','S'} )
//
//Tabela FNM - Movimentos de aprovaÁ„o e histÛricos de alteraÁıes
//
aAdd( aSx3Alter, {'FNM','01','FNM_FILIAL','C',nTamFil,0,'Filial'      ,'Sucursal'    ,'Branch'      ,'Filial do Sistema'        ,'Sucursal del Sistema'     ,'Branch of System'        ,''                       ,''                                  ,aSX3Copia[1][2],''                                                                                   ,''     ,1,aSX3Copia[1][3],'','' ,'S','N','V','R','','',''                                 ,'','','','',''                                                                   ,'033','','S'} )
aAdd( aSx3Alter, {'FNM','02','FNM_IDMOV' ,'C',10     ,0,'ID Movimen.' ,'ID Movimien.','TransactnsID','ID Movimentos'            ,'ID Movimientos'           ,'ID of Transactions'      ,'@!'                     ,''                                  ,aSX3Copia[2][2],"GetSxeNum('FNM','FNM_IDMOV')"                                                       ,''     ,1,aSX3Copia[2][3],'','' ,'S','S','V','R','','',''                                 ,'','','','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','03','FNM_ROTINA','C',10     ,0,'Rotina'      ,'Rutina'      ,'Routine'     ,'Rotina do ambiente'       ,'Rutina del entorno'       ,'Routine of Environment'  ,'@!'                     ,"ExistCpo('SN0','20'+M->FNM_ROTINA)",aSX3Copia[2][2],''                                                                                   ,'SN020',1,aSX3Copia[2][3],'','S','S','S','V','R','','',''                                 ,'','','','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','04','FNM_DESCRT','C',20     ,0,'Desc. Rotina','Desc. Rutina','Routine Desc','DescriÁ„o da rotina'      ,'Descripcion de rutina'    ,'Routine Description'     ,'@!'                     ,''                                  ,aSX3Copia[3][2],"IF(!INCLUI,POSICIONE('SN0',1,XFILIAL('SN0')+'20'+FNM->FNM_ROTINA ,'N0_DESC01'),' ')",''     ,1,aSX3Copia[3][3],'','' ,'S','S','V','V','','',''                                 ,'','','','',"Posicione('SN0',1,xFilial('SN0')+'20'+FNM->FNM_ROTINA ,'N0_DESC01')",''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','05','FNM_REVIS' ,'C',4      ,0,'Revis„o'     ,'Revision'    ,'Revision'    ,'Revis„o da alÁada'        ,'Revision de pertinencia'  ,'Revision of Jurisdiction','@!'                     ,''                                  ,aSX3Copia[2][2],''                                                                                   ,''     ,1,aSX3Copia[2][3],'','' ,'S','S','V','R','','',''                                 ,'','','','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','06','FNM_OPER'  ,'C',2      ,0,'OperaÁ„o'    ,'Operacion'   ,'Operation'   ,'OperaÁ„o da rotina'       ,'Operacion de la rutina'   ,'Routine Operation'       ,'@!'                     ,"ExistCpo('SN0','21'+M->FNM_OPER)"  ,aSX3Copia[2][2],''                                                                                   ,'SN021',1,aSX3Copia[2][3],'','S','S','S','V','R','','',''                                 ,'','','','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','07','FNM_DESCOP','C',20     ,0,'Desc. Opera.','Desc. Opera.','Oper. Desc.' ,'DescriÁ„o da operaÁ„o'    ,'Descripcion de operacion' ,'Operation Description'   ,'@!'                     ,''                                  ,aSX3Copia[3][2],"If(!INCLUI,Posicione('SN0',1,xFilial('SN0')+'21'+FNM->FNM_OPER ,'N0_DESC01'),' ')"  ,''     ,1,aSX3Copia[3][3],'','' ,'S','S','V','V','','',''                                 ,'','','','',"Posicione('SN0',1,xFilial('SN0')+'21'+FNM->FNM_OPER ,'N0_DESC01')"  ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','08','FNM_DATA'  ,'D',8      ,0,'Data movimen','Fecha movimi','TransctnDate','Data da movimentaÁ„o'     ,'Fecha de movimiento'      ,'Transaction Date'        ,''                       ,''                                  ,aSX3Copia[2][2],''                                                                                   ,''     ,1,aSX3Copia[2][3],'','' ,'S','S','V','R','','',''                                 ,'','','','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','09','FNM_CODSOL','C',6      ,0,'Solicitante' ,'Solicitante' ,'Requester'   ,'CÛdigo do solicitante'    ,'Codigo del solicitante'   ,'Requester Code'          ,'@!'                     ,'UsrExist(M->FNM_CODSOL)'           ,aSX3Copia[2][2],''                                                                                   ,'USR'  ,1,aSX3Copia[2][3],'','S','S','S','V','R','','',''                                 ,'','','','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','10','FNM_NOMSOL','C',25     ,0,'Nome solici.','Nombre solic','RequstrName' ,'Nome do solicitante'      ,'Nombre de solicitante'    ,'Requester Name'          ,'@!'                     ,''                                  ,aSX3Copia[3][2],'UsrRetName(M->FNM_CODSOL)'                                                          ,''     ,1,aSX3Copia[3][3],'','' ,'S','S','V','V','','',''                                 ,'','','','','UsrRetName(FNM->FNM_CODSOL)'                                        ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','11','FNM_CODAPR','C',6      ,0,'Aprovador'   ,'Aprobador'   ,'Approver'    ,'CÛdigo do aprovador'      ,'Codigo de aprobador'      ,'Approver Code'           ,'@!'                     ,'UsrExist(M->FNM_CODAPR)'           ,aSX3Copia[2][2],''                                                                                   ,'USR'  ,1,aSX3Copia[2][3],'','S','S','S','V','R','','',''                                 ,'','','','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','12','FNM_NOMAPR','C',25     ,0,'Nome aprova.','Nombre aprob','Apprvr Name' ,'Nome do aprovador'        ,'Nombre de aprobador'      ,'Name of Approver'        ,'@!'                     ,''                                  ,aSX3Copia[3][2],'UsrRetName(M->FNM_CODAPR)'                                                          ,''     ,1,aSX3Copia[3][3],'','' ,'S','S','V','V','','',''                                 ,'','','','','UsrRetName(FNM->FNM_CODAPR)'                                        ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','13','FNM_MOEDA' ,'C',2      ,0,'Moeda'       ,'Moneda'      ,'Currency'    ,'Moeda da operaÁ„o'        ,'Moneda de operacion'      ,'Operation Currency'      ,'@!'                     ,"ExistCpo('CTO',,1)"                ,aSX3Copia[2][2],''                                                                                   ,'CTO'  ,1,aSX3Copia[2][3],'','' ,'S','S','V','R','','',''                                 ,'','','','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','14','FNM_VALOR' ,'N',16     ,2,'Valor'       ,'Valor'       ,'Value'       ,'Valor da operaÁ„o'        ,'Valor de operacion'       ,'Operation Value'         ,'@E 9,999,999,999,999.99','Positivo()'                        ,aSX3Copia[3][2],''                                                                                   ,''     ,1,aSX3Copia[3][3],'','' ,'S','S','V','R','','',''                                 ,'','','','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','15','FNM_STATUS','C',1      ,0,'Status'      ,'Estatus'     ,'Status'      ,'Status da solicitaÁ„o'    ,'Estatus de solicitud'     ,'Request Status'          ,'@!'                     ,"Pertence('1|2|3')"                 ,aSX3Copia[6][2],"'1'"                                                                                ,''     ,1,aSX3Copia[6][3],'','' ,'S','S','A','R','','','1=Pendente;2=Aprovado;3=Reprovado','1=Pendiente;2=Aprobado;3=Reprobado','1=Pending;2=Approved;3=Rejected','','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','16','FNM_MEMSOL','M',10     ,0,'Jus. Soli.'  ,'Jus. Soli.'  ,'Reqstr.Justf','Justificativa solicitante','Justificativa solicitante','Requester justification' ,'@!'                     ,''                                  ,aSX3Copia[2][2],''                                                                                   ,''     ,1,aSX3Copia[2][3],'','' ,'S','N','V','R','','',''                                 ,'','','','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','17','FNM_MEMAPR','M',10     ,0,'Jus. aprova.','Jus. aproba.','Apprvr.Justf','Justificativa aprovador'  ,'Justificativa aprobador'  ,'Approver justification'  ,'@!'                     ,'NaoVazio()'                        ,aSX3Copia[6][2],''                                                                                   ,''     ,1,aSX3Copia[6][3],'','' ,'S','N','A','R','','',''                                 ,'','','','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','18','FNM_ORIGEM','C',10     ,0,'Origem'      ,'Origen'      ,'Origin'      ,'Rotina de origem'         ,'Rutina de origen'         ,'Origin Routine'          ,'@!'                     ,''                                  ,aSX3Copia[2][2],''                                                                                   ,''     ,1,aSX3Copia[2][3],'','' ,'S','N','V','R','','',''                                 ,'','','','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','19','FNM_TABORI','C',3      ,0,'Tabe. Origem','Tab. Origen' ,'Origin Table','Alias da tabela de origem','Alias de tabla de origen' ,'Alias of origin table'   ,'@!'                     ,''                                  ,aSX3Copia[2][2],''                                                                                   ,''     ,1,aSX3Copia[2][3],'','' ,'S','N','V','R','','',''                                 ,'','','','',''                                                                   ,''   ,'','S'} )
aAdd( aSx3Alter, {'FNM','20','FNM_RECORI','N',16     ,0,'Recno Origem','Recno Origen','Origin Recno','Recno do registro de orig','Recno de registro de orig','Recno of origin record'  ,'@E 9999999999999999'    ,''                                  ,aSX3Copia[2][2],''                                                                                   ,''     ,1,aSX3Copia[2][3],'','' ,'S','N','V','R','','',''                                 ,'','','','',''                                                                   ,''   ,'','S'} )
//
// Tabela FNN - Processo Constituicao Provisao
//
aAdd( aSx3Alter, {'FNN','01','FNN_FILIAL','C',nTamFil,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal del Sistema','System Branch','','',aSX3Copia[1][2],'','',1,	aSX3Copia[1][3],'','','S','N','V','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FNN','02','FNN_DTPROC','D',8,0,'Data Proc.','Fecha Proc','Proc. Date','Data do Processamento','Fecha del Procesamiento','Processing Date','','',aSx3Copia[2][2],'dDatabase','',1,	aSX3Copia[2][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNN','03','FNN_IDPROC','C',10,0,'Processo','Proceso','Process','Identificador do Processo','Identificador del Proceso','Process Identifier','@!','',aSX3Copia[6][2],'','',1,	aSX3Copia[6][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNN','04','FNN_STATUS','C',1,0,'Status','Estatus','Status','Status do processo','Estatus del proceso','Process Status','@!',"Pertence('12')",aSX3Copia[6][2],"'1'",'',1,	aSX3Copia[6][3],'','','S','N','V','R','','','1=Realizado;2=Cancelado','1=Realizado;2=Anulado','1=Completed;2=Canceled','','','','','','S'} )
aAdd( aSx3Alter, {'FNN','05','FNN_USERGI','C',17,0,'Log de Inclu','Log de Inclu','Inclus Log','Log de Inclusao','Log de Inclusion','Inclusion Log','','',aSX3Copia[1][2],'','',9,	aSX3Copia[1][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNN','06','FNN_USERGA','C',17,0,'Log de Alter','Log de Modif','Change Log','Log de Alteracao','Log de Modificacion','Change Log','','',aSX3Copia[1][2],'','',9,	aSX3Copia[1][3],'','','S','N','V','R','','','','','','','','','','','S'} )
//
// Tabela FNO - Movtos. Constituicao Provisao       
//
aAdd( aSx3Alter, {'FNO','01','FNO_FILIAL','C',nTamFil,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal del Sistema','System Branch','','',aSX3Copia[1][2],'','',1,	aSX3Copia[1][3],'','','S','N','V','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FNO','02','FNO_IDPROC','C',10,0,'Processo','Proceso','Process','Identificador do Processo','Identificador del Proceso','Process Identifier','@!','',aSX3Copia[6][2],'','',1,	aSX3Copia[6][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNO','03','FNO_DTPROC','D',8 ,0,'Data Proc.','Fecha Proc.','Proc. Date','Data de Processamento','Fecha de Procesamiento','Processing Date','','',aSx3Copia[6][2],'','',1,aSX3Copia[6][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNO','04','FNO_CBASE' ,'C',10,0,'Cod.Base Prv','Cod.Base Prv','Prv Base Cd','Codigo Base Provisao','Codigo Base Provision','Provision Base Code','@!','',aSx3Copia[6][2],'','',1,	aSX3Copia[6][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNO','05','FNO_ITEM'  ,'C',4 ,0,'Item Prv','Item Prv','Prov. Item','Item Provisao','Item Provision','Provision Item','@!','',aSx3Copia[6][2],'','',1,	aSX3Copia[6][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNO','06','FNO_BASESP','C',10,0,'Cod.Base Sup','Cod.Base Sup','Sup.Base Cod','Codigo Base Superior','Codigo Base Superior','Superior Base Code','@!','',aSx3Copia[6][2],'','',1,	aSX3Copia[6][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNO','07','FNO_ITEMSP','C',4 ,0,'Item Sup.','Item Sup.','Sup. Item','Item Superior','Item Superior','Superior Item','@!','',aSx3Copia[6][2],'','',1,	aSX3Copia[6][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNO','08','FNO_MSG'   ,'M',10,0,'Mensag.Proc.','Mensaj.Proc.','Proc Msg','Mensagem Proc','Mensaje Proc','Proc Message','@!','',aSX3Copia[6][2],'','',1,	aSX3Copia[6][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNO','09','FNO_STATUS','C',1,0,'Status','Estatus','Status','Status do processo','Estatus del proceso','Process Status','@!',"Pertence('12')",aSX3Copia[6][2],"'1'",'',1,	aSX3Copia[6][3],'','','S','N','V','R','','','1=Realizado;2=Cancelado','1=Realizado;2=Anulado','1=Performed;2=Canceled','','','','','','S'} )
aAdd( aSx3Alter, {'FNO','10','FNO_IDMVAF','C',10,0,'Id.Movt.ATF','Id.Movt.ATF','ATF Trans.ID','ID do movimento ATF','ID del movimiento ATF','ATF Transaction ID','@!','',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
//
// Tabela FNQ - Margem Gerencial
//
aAdd( aSx3Alter, {'FNQ','01','FNQ_FILIAL' ,'C',nTamFil,0,'Filial'			,'Sucursal'		,'Branch'		,'Filial do Sistema'	,'Sucursal del Sistema'		,'System Branch','','',aSX3Copia[1][2],'','',1,	aSX3Copia[1][3],'','','S','N','A','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FNQ','02','FNQ_COD'    ,'C',6	,0,'Codigo'			,'Codigo'		,'Code'			,'Codigo da Margem'		,'Codigo de Margen'			,'Margin Code','@!',"ExistChav('FNQ',M->FNQ_COD)",aSX3Copia[2][2],'','',1,	aSX3Copia[2][3],'','','S','S','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNQ','03','FNQ_REV'	  ,'C',4	,0,'Revisao'		,'Revision'		,'Review'		,'Revisao da Margem'	,'Revision del Margen'		,'Margin Review','@!','',aSX3Copia[2][2],"AF470INREV()",'',1,	aSX3Copia[2][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNQ','04','FNQ_DESC'	  ,'C',40	,0,'Descricao'		,'Descripcion'	,'Description'	,'Descricao da Margem'	,'Descripcion de Margen'	,'Margin Description','@!','',aSX3Copia[6][2],'','',1,	aSX3Copia[6][3],'','','S','S','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNQ','05','FNQ_TIPO'	  ,'C',1 	,0,'Tipo Margem'	,'Tipo Margen'	,'Margin Type'	,'Tipo de Margem'		,'Tipo de Margen'			,'Margin Type','@!','Pertence("12 ")',aSX3Copia[6][2],"'1'",'',1,	aSX3Copia[6][3],'','','S','S','A','R','','','1=Percentual;2=Valor Fixo','1=Porcentual;2=Valor Fijo','1=Percentage;2=Fixed Value','','','','','','S'} )
aAdd( aSx3Alter, {'FNQ','06','FNQ_VLRFIX' ,'N',16	,2,'Valor Fixo'		,'Valor Fijo'	,'Fixed Value'	,'Valor Fixo Margem'	,'Valor Fijo Margen'		,'Margin Fixed Value','@E 9,999,999,999,999.99','Positivo()',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','','S','A','R','','','','','','','Af470When(2)','','','','S'} )
aAdd( aSx3Alter, {'FNQ','07','FNQ_PERCEN' ,'N',7	,2,'Percentual'		,'Porcentaje'	,'Percentage'	,'Percentual da Margem'	,'Porcentaje del Margen'	,'Margin Percentage','@E 9,999.99','Positivo()',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','S','A','R','','','','','','','Af470When(1)','','','','S'} )
aAdd( aSx3Alter, {'FNQ','08','FNQ_STATUS' ,'C',1	,0,'Status'			,'Estatus'		,'Status'		,'Status de Margem'		,'Estatus de Margen'		,'Margin Status','@!','',aSX3Copia[3][2],"'1'",'',1,	aSX3Copia[3][3],'','','S','N','V','R','','','1=Ativa;2=Revisada','1-Activa;2=Revisada','1=Active;2=Reviewed','','','','','','S'} )
aAdd( aSx3Alter, {'FNQ','09','FNQ_MSBLQL' ,'C',1	,0,'Bloqueado?'		,'Bloqueado'	,'Blocked?'		,'Registro bloqueado'	,'Registro bloqueado'		,'Blocked record','@!','',aSX3Copia[3][2],"'2'",'',1,	aSX3Copia[3][3],'','','S','N','A','R','','','1=Sim;2=N„o','1=Si;2=No','1=Yes;2=No','','','','','','S'} )

//
// Tabela FN1
//
aAdd( aSx3Alter, {'FN1','01','FN1_FILIAL' ,'C',nTamFil,0,'Filial','Sucursal','System','Filial do Sistema','Suc. del Sistema','System Branch','','',aSX3Copia[1][2],'','',1,	aSX3Copia[1][3],'','','','N','A','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FN1','02','FN1_PROC','C',10,0,'Cod Processo','Cod Proceso','Process Cd','Codigo do Processo','Codigo de Proceso','Process Cd','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(176),'"0000000001"','',1,	Chr(133) + Chr(128),'','','','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN1','03','FN1_DATA','D',8,0,'Data Proc','Fc Proc','Proc Date','Data do processamento','Fecha de procesam.','Processing Date','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN1','04','FN1_DESC','C',40,0,'Descricao','Descripcion','Description','Descricao do processo','Descripcion de Proceso','Process Description','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,	Chr(128) + Chr(128),'','','','S','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN1','05','FN1_STATUS','C',1,0,'Status','Estatus','Status','Status do Processo','Estatus del Proceso','Process Status','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','1=Efetivado;2=Estornado','1=Efectuado;2=Retornado','1=Effective;2=Reversed','','','','','','S'} )
aAdd( aSx3Alter, {'FN1','06','FN1_USERGI','C',17,0,'Log de Inclu','Log de Inclu','Incl. Log','Log de Inclusao','Log de Inclusion','Inclusion Log','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,	Chr(128) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN1','07','FN1_USERGA','C',17,0,'Log de Alter','Log de Alter','Editing Log','Log de Alteracao','Log de Alteracion','Editing Log','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,	Chr(128) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN1','08','FN1_TIPO','C',1,0,'Tipo','Tipo','Type','Tipo do calculo','Tipo del proceso','Process Type','9','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','','N','V','R','','','1=Automatico;2=Manual','1=Automatico;2=Manual','1=Automatic;2=Manual','','','','','','S'} )

//
// Tabela FN2
//
aAdd( aSx3Alter, {'FN2','01','FN2_FILIAL','C',8,0,'Filial','Sucursal','System','FIlial do Sistema','Suc. del Sistema','System Branch','','',aSX3Copia[1][2],'','',1,	aSX3Copia[1][3],'','','','N','A','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FN2','02','FN2_PROC','C',10,0,'Cod Processo','Cod Proceso','Process Cd','Codigo do processamento','Codigo de procesamiento','Processing Code','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(144),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN2','03','FN2_LINHA','C',6,0,'Linha','Linea','Line','Linha de Conf Contrato','Linea de Verif Contrato','Contract Conf Line','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(176),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN2','04','FN2_IDCONT','C',20,0,'ID Contrato','ID Contrato','Contract ID','Identificador Contrato','Identificador Contrato','Contract Identifier','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN2','05','FN2_DESC','C',40,0,'Descricao','Descripcion','Description','Descricao Contrato','Descripcion contrato','Contract Description','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN2','06','FN2_VLRCON','N',16,2,'Vlr Contrato','Vlr Contrato','Contract Vl','Valor do Contrato','Valor del Contrato','Contract Value','@E 9,999,999,999,999.99','Positivo()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN2','07','FN2_VLRSAL','N',16,2,'Saldo Cont','Saldo Cont','Contract Bl.','Saldo do Contrato','Saldo del Contrato','Contract Balance','@E 9,999,999,999,999.99','Positivo()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN2','08','FN2_JURCOM','N',16,2,'Juros Compet','Interes Comp','Cur.Interest','Juros Competencia','Interes Competencia','Current Interest','@E 9,999,999,999,999.99','Positivo()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','A','R','','','','','','','','','','','S'} )
//
// Tabela FN3
//
aAdd( aSx3Alter, {'FN3','01','FN3_FILIAL','C',8,0,'Filial','Sucursal','System','Filial do Sistema','Suc. del Sistema','System Branch','','',aSX3Copia[1][2],'','',1,	aSX3Copia[1][3],'','','','N','A','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FN3','02','FN3_PROC','C',10,0,'Cod Processo','Cod Proceso','Process Cd','Codigo do processamento','Codigo de Procesamiento','Processing Code','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(144),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN3','03','FN3_LINHA','C',6,0,'Linha','Linea','Line','Linha Conf Transac','Linea Verif Transac','Transaction Conf Line','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,	Chr(128) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN3','04','FN3_CBASE','C',10,0,'C Base Trans','C Base Trans','Trans Base C','C Base Custo Transacao','C Base Costo Transaccion','Transaction Cost Base C','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN3','05','FN3_ITEM','C',4,0,'Item Transac','Item Transac','Transac.Item','Item Custo Transacao','Item Costo Transaccion','Transaction Cost Item','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN3','06','FN3_TIPO','C',2,0,'Tipo','Tipo','Type','Tipo de Bem','Tipo de Bien','Asset Type','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN3','07','FN3_TPSALD','C',1,0,'Tipo Saldo','Tipo Saldo','Balance Type','Tipo de Saldo','Tipo de Saldo','Balance Type','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSX3Alter, {'FN3','08','FN3_DESC','C',40,0,'Descricao','Descripcion','Description','Descricao da Amortizacao','Descripcion de Amortizac','Amortization Description','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','','N','A','R','','','','','','','','','','',''} )
aAdd( aSx3Alter, {'FN3','09','FN3_AMORT','N',16,2,'Vlr Amort','Vlr Amort','Amortiz. Vl','Valor AmortizaÁ„o','Valor Amortizacion','Amortization Value','@E 9,999,999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(254) + Chr(192),'','','','N','A','R','','','','','','','','','','','S'} )
//
// Tabela FN4
//
aAdd( aSx3Alter, {'FN4','01','FN4_FILIAL','C',8,0,'Filial','Sucursal','System','Filial do Sistema','Suc. del Sistema','System Branch','','',aSX3Copia[1][2],'','',1,	aSX3Copia[1][3],'','','','N','A','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FN4','02','FN4_PROC','C',10,0,'Cod Processo','Cod Proceso','Process Cd','Codigo do Processo','Codigo de Proceso','Process Code','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(144),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN4','03','FN4_LINHA','C',6,0,'Linha','Linea','Line','Linha Cfg Rendimento','Linea Cfg Rendimiento','Income Cfg Line','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(176),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN4','04','FN4_DESC','C',40,0,'Descricao','Descripcion','Description','Descricao Rendimento','Descrip. rendimiento','Income Description','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN4','05','FN4_VALOR','N',16,2,'Valor Rendim','Valor Rendim','Income Value','Valor do Rendimento','Valor del Rendimiento','Income Value','@E 9,999,999,999,999.99','Positivo()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','A','R','','','','','','','','','','','S'} )
//
// Tabela FN5
//
aAdd( aSx3Alter, {'FN5','01','FN5_FILIAL','C',8,0,'Filial','Sucursal','System','Filial do Sistema','Suc. del Sistema','System Branch','','',aSX3Copia[1][2],'','',1,	aSX3Copia[1][3],'','','','N','A','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FN5','02','FN5_PROC','C',10,0,'Cod Processo','Cod Proceso','Process Cd','Codigo do Processamento','Codigo de Procesamiento','Processing Code','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(144),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN5','03','FN5_LINHA','C',6,0,'Linha','Linea','Line','Linha Conf Fichas Custo','Linea con Fichas Costo','Cost Forms Conf Line','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(176),'','',1,	Chr(133) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN5','04','FN5_CBAORI','C',10,0,'C Base Orig','C Base Orig','Orig Base C','CÛdigo Base Origem','Codigo Base Origen','Origin Base Code','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN5','05','FN5_ITEORI','C',4,0,'Item Origem','Item Origen','Origin Item','Item Origem','Item Origen','Origin Item','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN5','06','FN5_TIPORI','C',2,0,'Tipo de orig','Tipo de orig','Orig type','Tipo Atf Original','Tipo Atf Original','Original Atf Type','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN5','07','FN5_SLDORI','C',1,0,'Tp Sld Ori','Tp Sld Ori','Ori. Bal. Tp','Tipo de saldo Original','Tipo de saldo Original','Original Balance Type','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN5','08','FN5_VLRORI','N',16,2,'Valor Origem','Valor Origen','Origin Value','Valor Original Moeda 01','Valor Original Moneda 01','Currency 01 Original Vl.','@E 9,999,999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN5','09','FN5_CBACEM','C',10,0,'C Base Emp','C Base Emp','Comp Base C','Cod Base do Custo de Emp','Cod Base do Costo de Emp','Comp Cost Base Code','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN5','10','FN5_ITECEM','C',4,0,'Item Cust Em','Item Cost Em','Emp.Cos.Item','Item do Custo de Emp','Item de Costo de Emp','Emp. Cost Item','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN5','11','FN5_TIPEMP','C',2,0,'Tipo C Emp','Tipo C Emp','Comp C Type','Tipo da ficha de custo','Tipo da ficha de coto','Cost form type','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN5','12','FN5_SLDEMP','C',1,0,'Tp Sld Emp','Tp Sld Emp','Emp. Bal. Tp','Tp saldo do custo emp','Tp saldo do costo mp','Emp. Cost Balance Tp.','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN5','13','FN5_GRPCEM','C',4,0,'Grupo','Grupo','Group','Grupo Custo Emp','Grupo Costo Emp','Comp Cost Group','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN5','14','FN5_TXCAP' ,'N',12,8,'Taxa Cap','Tasa Cap','Approp Value','Taxa de capitalizaÁ„o','Tasa de Capitalizacion','Capitalization Rate','@E 999.99999999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FN5','15','FN5_VLRAPR','N',16,2,'Valor Aprop','Valor Aprop','Approp Value','Valor da Apropriacao','Valor de Apropiacion','Appropriation Value','@E 9,999,999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,	Chr(132) + Chr(128),'','','','N','V','R','','','','','','','','','','','S'} )

//
// Tabela FNU - Controle de Provis„o
//
aAdd( aSx3Alter, {'FNU','01','FNU_FILIAL'	,'C',nTamFil 		,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal del Sistema','System Branch','','',aSX3Copia[1][2],'','',1,aSX3Copia[1][3],'','','S','N','V','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FNU','02','FNU_COD'		,'C',10      		,0,'CÛdigo','Codigo','Code','CÛdigo da Provis„o','Codigo de Provision','Provision Code','@!','ExistChav("FNU",M->FNU_COD)',aSX3Copia[6][2],'AF490INCOD()','',1,	aSX3Copia[6][3],'','','S','S','A','R','','','','','','','INCLUI','','','','S'} )
aAdd( aSx3Alter, {'FNU','03','FNU_REV'		,'C',4       		,0,'Revis„o','Revision','Review','Revis„o da Provis„o','Revision de Provision','Provision Review','@!','',aSX3Copia[6][2],"AF490INREV()",'',1,aSX3Copia[6][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNU','04','FNU_DESCR'	,'C',40			,0,'DescriÁ„o','Descripcion','Description','DescriÁ„o da Provis„o','Descripcion de Provision','Provision Description','@!','',aSX3Copia[6][2],'','',1,aSX3Copia[6][3],'','','S','S','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNU','05','FNU_DTINI'	,'D',8			    ,0,'Dt Reconhec','Fc. Reconoc.','Recog. Dt','Data Reconhecimento','Fecha reconocimento','Recognition Date','','',aSX3Copia[6][2],'','',1,aSX3Copia[6][3],'','','S','S','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNU','06','FNU_INIPRJ'	,'D',8			    ,0,'Dt Ini Proj','Fch Ini Proy','Proj.Sta.Dt.','Data InÌcio Projeto','Fecha inicial proyecto','Project Start Date','','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','S','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNU','07','FNU_DTAVP'   ,'D',8				,0,'Data Ref AVP','Fech.Ref.AVP','AVP Ref Date','Data de Referencia AVP','Fechaa de referencia AVP','AVP Reference Date','','',aSX3Copia[6][2],'','',1,	aSX3Copia[6][3],'','','','N','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNU','08','FNU_TPCALC'	,'C',1			    ,0,'Tipo Calculo','Tipo Calculo','Calc. Type','Tipo do C·lculo Provis„o','Tipo del Calculo Provisio','Provision Calculation Tp','@!','',aSX3Copia[6][2],'"1"','',1,aSX3Copia[6][3],'','','S','N','V','R','','','#AdmCBGener(xFilial("SN0"),"SN0","16","01")','#AdmCBGener(xFilial("SN0"),"SN0","16","01")','#AdmCBGener(xFilial("SN0"),"SN0","16","01")','','','','','','S'} )
aAdd( aSx3Alter, {'FNU','09','FNU_INDICE'	,'C',nTamCodInd	,0,'Ind. Curva','Ind. Curva','Curve Ind.','Indice de curva','Indice de curva','Curve index','@!','AFA490ICrv()',aSX3Copia[3][2],'','FNI',1,aSX3Copia[3][3],'','','S','N','A','R','','','','','','','','','060','','S'} )
aAdd( aSx3Alter, {'FNU','10','FNU_INDAVP'	,'C',2			    ,0,'Indice AVP','Indice AVP','AVP Index','Indice AVP Provis„o','Indice AVP Provision','Provision AVP Index','@!','AFA490IAVP()',aSX3Copia[6][2],'','FIT',1,aSX3Copia[6][3],'','','S','N','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNU','11','FNU_TAXAVP'	,'N',14			,8,'Taxa AVP','Tasa AVP','AVP Rate','Taxa de AVP Provis„o','Tasa de AVP Provision','Provision AVP Rate','@E 99,999.99999999','Positivo()',aSX3Copia[6][2],'','',1,aSX3Copia[6][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNU','12','FNU_CONTA'	,'C',nTamConta	,0,'Conta Contab','Cta Contable','Ledger Acc.','Conta cont·bil provis„o','Cuenta Contable provision','Provision ledger account','@!','Vazio() .Or.  CTB105CTA()',aSX3Copia[3][2],'','CT1',1,aSX3Copia[3][3],'','','','N','A','R','','','','','','','','','003','','S'} )
aAdd( aSx3Alter, {'FNU','13','FNU_CUSTO'	,'C',nTamCCusto	,0,'C.Custo','C.Costo','Cost C.','Centro de Custo Provis„o','Centro de Costo Provision','Provision Cost Center','@!','Vazio() .Or. CTB105CC()',aSX3Copia[3][2],'','CTT',1,aSX3Copia[3][3],'','','S','N','A','R','','','','','','','','','004','','S'} )
aAdd( aSx3Alter, {'FNU','14','FNU_ITEM'    ,'C',nTamITCtb	,0,'Item Contab.','Item Contab.','Acc. Item','Item Contabil Provis„o','Item Contable Provision','Provision Accounting Item','@!','Vazio() .Or. CTB105Item()',aSX3Copia[3][2],'','CTD',1,aSX3Copia[3][3],'','','S','N','A','R','','','','','','','','','005','','S'} )
aAdd( aSx3Alter, {'FNU','15','FNU_CLVL'    ,'C',nTamClVlr	,0,'Classe Valor','Clase Valor','Value Class','Classe Valor Provis„o','Clase Valor Provision','Provision Value Class','@!','Vazio() .Or. CTB105CLVL()',aSX3Copia[3][2],'','CTH',1,aSX3Copia[3][3],'','','S','N','A','R','','','','','','','','','006','','S'} )
aAdd( aSx3Alter, {'FNU','16','FNU_TPSALD'	,'C',1			    ,0,'Tipo Saldo'  ,'Tipo Saldo'  ,'Balance Type','Tipo de Saldo da Provis„o','Tipo Saldo de Provision','Provision Balance Type','@!','AF490VLDTS()',aSX3Copia[6][2],"'1'",'',1,aSX3Copia[6][3],'','','S','N','A','R','','','#AdmCBGener(xFilial("SX5"),"SX5","SL","01")','#AdmCBGener(xFilial("SX5"),"SX5","SL","01")','#AdmCBGener(xFilial("SX5"),"SX5","SL","01")','','','','','','S'} )
aAdd( aSX3Alter, {'FNU','17','FNU_DTREV' 	,'D',8             ,0,'Dt. Revis„o'  ,'Fc.Revision' ,'Review Dt.' ,'Data de revis„o','Fecha de revision','Review Date','','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','' ,'','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNU','18','FNU_STATUS'	,'C',1			    ,0,'Status','Estatus','Status','Status Controle Provis„o','Estatus Control Provision','Provision Control Status','@!','',aSX3Copia[3][2],"'0'",'',1,aSX3Copia[3][3],'','','S','N','V','R','','','#AF490STAT()','#AF490STAT()','#AF490STAT()','','','','','','S'} )
aAdd( aSx3Alter, {'FNU','19','FNU_MSBLQL'	,'C',1			    ,0,'Bloqueado','Bloqueado','Blocked','Registro bloqueado','Registro bloqueado','Blocked register','@!',"Pertence('12')",aSX3Copia[3][2],"'2'",'',1,aSX3Copia[3][3],'','','S','N','A','R','','','1=Sim;2=N„o','1=Si;2=No','1=Yes;2=No','','AF490BLQW()','','','','S'} )
aAdd( aSx3Alter, {'FNU','20','FNU_VLRBRT'	,'N',16			,2,'Total Bruto','Total Bruto','Gross Total','Valor Bruto Total','Valor Bruto Total','Total Gross Value','@E 9,999,999,999,999.99','Positivo()',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNU','21','FNU_VLRPRE'	,'N',16			,2,'Tot.Presente','Tot.Presente','Present Tot.','Valor Presente Total','Valor Presente Total','Total Present Value','@E 9,999,999,999,999.99','Positivo()',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )  

//
// Tabela FNV - Item da Provis„o
//
aAdd( aSx3Alter, {'FNV','01','FNV_FILIAL'	,'C',nTamFil,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal del Sistema','System Branch','','',aSX3Copia[1][2],'','',1,aSX3Copia[1][3],'','','','N','V','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FNV','02','FNV_COD'		,'C',10		,0,'CÛd. Provis.','Cod. Provis.','Provis. Code','CÛdigo da Provis„o','Codigo de Provision','Provision Code','@!','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNV','03','FNV_REV'		,'C',4		,0,'Rev. Provis.','Rev. Provis.','Provis. Rev.','Revis„o da Provis„o','Revision de Provision','Provision Review','@!','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNV','04','FNV_ITEM'		,'C',3		,0,'Item','Item','Item','Item da Provis„o','Item de Provision','Provision Item','@!','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNV','05','FNV_DTFIN'	,'D',8		,0,'Data Final','Fecha Final','End Date','Data Final da Provis„o','Fecha Final de Provision','Provision End Date','','AF490VDTI()',aSX3Copia[6][2],'','',1,aSX3Copia[6][3],'','','S','N','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNV','06','FNV_VLRBRT'	,'N',16		,2,'Valor Bruto','Valor Bruto','Gross Value','Valor Bruto do Item','Valor Bruto del Item','Item Gross Value','@E 9,999,999,999,999.99','Positivo()',aSX3Copia[6][2],'','',1,aSX3Copia[6][3],'','','S','S','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNV','07','FNV_VLRPRE'	,'N',16		,2,'Vlr Presente','Vlr Presente','Present Vl.','Valor Presente do Item','Valor Presente del Item','Item Present Value','@E 9,999,999,999,999.99','',aSX3Copia[3][2],'','',1,	aSX3Copia[3][3],'','','S','S','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNV','08','FNV_RLZEFT'	,'C',1		,0,'Rlz.Efetivad','Real Efect.','Rlz.Effect.','RealizaÁ„o Efetivada','Realizacion Efectuada','Realization Effective','@!','Pertence("12")',aSX3Copia[3][2],'"2"','',1,aSX3Copia[3][3],'','','S','N','V','R','','','1=Sim;2=N„o','1=Si;2=No','1=Yes;2=No','','','','','','S'} )
//
// Tabela FNW - Movimentos da Provis„o
//
aAdd( aSx3Alter, {'FNW','01','FNW_FILIAL'	,'C',nTamFil,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal del Sistema','System Branch','','',aSX3Copia[1][2],'','',1,aSX3Copia[1][3],'','','S','N','V','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FNW','02','FNW_COD'		,'C',10		,0,'CÛdigo','Codigo','Code','CÛdigo da Provis„o','Codigo de Provision','Provision Code','@!','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNW','03','FNW_REV'		,'C',4		,0,'Revis„o','Revision','Review','Revis„o da Provis„o','Revision de Provision','Provision Review','@!','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNW','04','FNW_PERIOD'	,'C',6		,0,'Periodo','Periodo','Period','Periodo do movimento','Periodo de movimiento','Transaction Period','@9999-99','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNW','05','FNW_DTMOV'	,'D',8		,0,'Dt. Movto.','Fc Mov.','Trans. Dt.','Data do Movimento','Fecha de Movimiento','Transaction Date','','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNW','06','FNW_OCOR'		,'C',2		,0,'OcorrÍncia','Ocurrencia','Occurrence','Ocorrencia do movimento','Ocurrencia de movimiento','Transaction Occurrence','@!','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','#AdmCBGener(xFilial("SN0"),"SN0","15","01")','#AdmCBGener(xFilial("SN0"),"SN0","15","01")','#AdmCBGener(xFilial("SN0"),"SN0","15","01")','','','','','','S'} )
aAdd( aSx3Alter, {'FNW','07','FNW_VALOR'	,'N',16		,2,'Valor','Valor','Value','Valor do movimento','Valor del movimiento','Transaction Value','@E 9,999,999,999,999.99','Positivo()',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNW','08','FNW_LA'		,'C',1		,0,'Ident. Lanc.','Ident. Asto.','Entry Ident.','Identificador Contabil','Identificador Contable','Accounting Identifier','@!','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNW','09','FNW_IDMOV'	,'C',10		,0,'Id. Movto.','Id. Mov.','Trans. Id.','Identificador movimentos','Identificador movimientos','Transaction Identifier','@!','',aSX3Copia[5][2],'','',1,aSX3Copia[5][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNW','10','FNW_PRAZO'	,'C',1		,0,'Tipo Prazo','Tipo Plazo','Term Type','Tipo de Prazo Movimento','Tipo de Plazo Movimiento','Transaction Term Type','@!',"Pertence('12')",aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','1=Longo Prazo;2=Curto Prazo','1=Largo Plazo;2=Corto Plazo','1=Long Term;2=Short Term','','','','','','S'} )
aAdd( aSx3Alter, {'FNW','11','FNW_DTEFET'	,'D',8		,0,'Data Efetiva','Fecha Efect.','Confirm. Dt.','Data da EfetivaÁ„o','Fecha de Efectivizac.','Confirmation Date','','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
//
//Tabela FNX - Bens de execucao
//
aAdd( aSx3Alter, {'FNX','01','FNX_FILIAL'	,'C',nTamFil,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal del Sistema','System Branch','','',aSX3Copia[1][2],'','',1,aSX3Copia[1][3],'','','S','N','V','R','','','','','','','','','033','','S'} )
aAdd( aSx3Alter, {'FNX','02','FNX_COD'		,'C',10		,0,'CÛdigo','Codigo','Code','CÛdigo da Provis„o','Codigo de Provision','Provision Code','@!','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNX','03','FNX_REV'		,'C',4		,0,'Revis„o','Revision','Review','Revis„o da Provis„o','Revision de Provision','Provision Review','@!','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNX','04','FNX_LINHA'	,'C',3		,0,'Linha','Linea','Line','Linha de RealizaÁ„o','Linea de Realizacion','Completion Line','@!','',aSX3Copia[3][2],"'001'",'',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNX','05','FNX_DTMOV'	,'D',8		,0,'Dt. Movto.','Fc. Mov.','Trans. Dt.','Data do Movimento','Fecha del Movimiento','Transaction Date','','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNX','06','FNX_CBASE'	,'C',10	    ,0,'CÛdigo Base','Codigo Base','Base Code','CÛdigo Base do Ativo','Codigo Base de Activo','Asset Base Code','@!','AF490VLATF()',aSX3Copia[3][2],'','SN303',1,aSX3Copia[3][3],'','','S','N','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNX','07','FNX_ITEM'	,'C',4		,0,'Item','Item','Item','Item do Ativo de ExecuÁ„o','Item del Activo de Ejecuc','Execution Asset Item','@!','AF490VLATF()',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','A','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNX','08','FNX_TIPO'	,'C',2		,0,'Tipo','Tipo','Type','Tipo do Ativo de ExecuÁ„o','Tipo de Activo de Ejecuc.','Execution Asset Type','@!','',aSX3Copia[3][2],"'10'",'',1,aSX3Copia[3][3],'','','S','N','V','R','','','10=Depr. Cont·bil ','10=Depr. Contable','10=Accounting Depr.' ,'','','','','','S' } )
aAdd( aSx3Alter, {'FNX','09','FNX_TPSALD'	,'C',1		,0,'Tipo Saldo'  ,'Tipo Saldo'   ,'Balance Type','Tipo de Saldo do Ativo','Tipo de Saldo de Activo','Asset Balance Type','@!','AF490VLBEX()',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','#AdmCBGener(xFilial("SX5"),"SX5","SL","01")','#AdmCBGener(xFilial("SX5"),"SX5","SL","01")','#AdmCBGener(xFilial("SX5"),"SX5","SL","01")','','','','','','S'} )
aAdd( aSx3Alter, {'FNX','10','FNX_VALOR'	,'N',16		,2,'Valor Exec.','Valor Ejec.','Exec. Value','Valor da ExecuÁ„o','Valor de la Ejecucion','Execution Value','@E 9,999,999,999,999.99','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNX','11','FNX_DTCONT'	,'D',8		,0,'Data Efetiva','Fecha Efect.','Confirm. Dt.','Data da EfetivaÁ„o','Fecha de Efectivizac.','Confirmation Date','','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','','','S'} )
aAdd( aSx3Alter, {'FNX','12','FNX_FILATF'	,'C',nTamFil ,0,'Filial ATF','Filial ATF','Filial ATF','Filial do Ativo','Filial do Ativo','Filial do Ativo','','',aSX3Copia[3][2],'','',1,aSX3Copia[3][3],'','','S','N','V','R','','','','','','','','','033','','S'} )
//
// Tabela SN1
//
aAdd( aSx3Alter, {'SN1',ProxSX3('SN1','N1_PROVIS'),'N1_PROVIS','C',10,0,'Provis„o','Provision','Provision','CÛdigo da Provis„o','Codigo de Provision','Provision Code','@!','FA010PrvVld(M->N1_PROVIS)',aSX3Copia[3][2],'','FNU',1,aSX3Copia[3][3],'','','S','N','A','R','','','','','','',"If(FindFunction('A010PrvWhen'),A010PrvWhen(),.F.)",'','','1','S'} )



//
// Atualizando dicion·rio
//
dbSelectArea("SX3")
dbSetOrder(2)   

aSort(aSx3,,,{|x,y| x[1]+x[2] < y[1]+y[2]})
ProcRegua(Len(aSX3))

For i:= 1 To Len(aSX3)
	If !Empty(aSX3[i][1])
		If !dbSeek(aSX3[i,3])
			If Ascan(aSX3Campos,aSX3[i,3]) == 0
				aAdd( aSX3Campos ,aSX3[i,3])
			EndIf
			lSX3	:= .T.
			If !(aSX3[i,1]$cAlias)
				cAlias += aSX3[i,1]+"/"
				If Ascan(aArqUpd,aSX3[i,1]) == 0
					aAdd(aArqUpd,aSX3[i,1])
				EndIf
			EndIf
			RecLock("SX3",.T.)
			For j:=1 To Len(aSX3[i])		
				If FieldPos(aEstrut[j])>0
					FieldPut(FieldPos(aEstrut[j]),aSX3[i,j])
				EndIf
			Next j
			dbCommit()        
			MsUnLock()
			IncProc(STR0038) //"Atualizando Dicionario de Dados..."
		EndIf
	EndIf
Next i

cAlias := ''
aSort(aSX3Alter,,,{|x,y| x[1]+x[2] < y[1]+y[2]})
ProcRegua(Len(aSX3Alter))

For i:= 1 To Len(aSX3Alter)
	If !Empty(aSX3Alter[i][1])
		If !dbSeek(aSX3Alter[i,3])
			If Ascan(aSX3Campos,aSX3Alter[i,3]) == 0
				aAdd( aSX3Campos ,aSX3Alter[i,3])
			EndIf
			lSX3	:= .T.
			If !(aSX3Alter[i,1]$cAlias)
				cAlias += aSX3Alter[i,1]+"/"
				If Ascan(aArqUpd,aSX3Alter[i,1]) == 0
					aAdd(aArqUpd,aSX3Alter[i,1])
				EndIf
			EndIf
			RecLock("SX3",.T.)
			For j:=1 To Len(aSX3Alter[i])
				If FieldPos(aEstrut[j])>0
					FieldPut(FieldPos(aEstrut[j]),aSX3Alter[i,j])
				EndIf
			Next j
			dbCommit()
			MsUnLock()
			IncProc(STR0038) //"Atualizando Dicionario de Dados..."

		Else // Tratamento de alteracao para campos j· existentes
		
			If Ascan(aSX3Campos,aSX3Alter[i,3]) == 0
				aAdd( aSX3Campos ,aSX3Alter[i,3])
			EndIf
			lSX3	:= .T.
			If !(aSX3Alter[i,1]$cAlias)
				cAlias += aSX3Alter[i,1]+"/"
				If Ascan(aArqUpd,aSX3Alter[i,1]) == 0
					aAdd(aArqUpd,aSX3Alter[i,1])
				EndIf
			EndIf

			RecLock("SX3",.F.)
			For j:=1 To Len(aSX3Alter[i])
				If FieldPos(aEstrut[j])>0 .And. !(aEstrut[j] $ "X3_VLDUSER/X3_NIVEL")
					FieldPut(FieldPos(aEstrut[j]),aSX3Alter[i,j])
				EndIf
			Next j
			
			dbCommit()
			MsUnLock()
			IncProc(STR0038) //"Atualizando Dicionario de Dados..."
			
		EndIf
	EndIf
Next i

cAlias := ''
// Exclusao de Campos 
For i := 1 To Len( aSX3Del )
	If !Empty( aSX3Del[i][1] )
		If dbSeek( aSX3Del[i,3] )
			lSX3	:= .T.
			If !( aSX3Del[i,1] $ cAlias )
				cAlias += aSX3Del[i,1]+"/"
				If Ascan(aArqUpd,aSX3Del[i,1]) == 0
					aAdd(aArqUpd,aSX3Del[i,1])
				EndIf
			EndIf

			RecLock("SX3")
			SX3->( dbDelete() )
			dbCommit()
			SX3->( MsUnLock() )
			IncProc(STR0038) //"Atualizando Dicionario de Dados..."
		EndIf
	EndIf
Next i


If lSX3
	cTexto := STR0039+cAlias+CRLF //'Tabelas atualizadas : '
EndIf

Return {aSX3Campos,cTexto}
/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ATFAtuSX5 ≥ Autor ≥ --------------------- ≥ Data ≥ 23/05/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Funcao de processamento da gravacao do SX5                 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ATFAtuSX5()
//  "X5_FILIAL","X5_TABELA","X5_CHAVE","X5_DESCRI","X5_DESCSPA","X5_DESCENG"

Local aSX5   := {}
Local aSX5Alter   := {}
Local aEstrut:= {}
Local i      := 0
Local j      := 0
Local lSX5	 := .F.
Local cTexto := ""	

If (cPaisLoc == "BRA")
	aEstrut:= { "X5_FILIAL","X5_TABELA","X5_CHAVE","X5_DESCRI","X5_DESCSPA","X5_DESCENG"}
Else
	aEstrut:= { "X5_FILIAL","X5_TABELA","X5_CHAVE","X5_DESCRI","X5_DESCSPA","X5_DESCENG"}
EndIf

aAdd(aSX5Alter,{xFilial("SX5"),"G1","13","Adiantamento Gerencial","Anticipo Gerencial","Management Advance"})
aAdd(aSX5Alter,{xFilial("SX5"),"G1","14","AVP de imobilizado","AVP de imobilizado","AVP of Assets"})
aAdd(aSX5Alter,{xFilial("SX5"),"G1","15","Margem Gerencial","Margen Gerencial",""})

aAdd(aSX5Alter,{xFilial("SX5"),"16","20","REVISAO DE PROJETO","REVISION DE PROYECTO","PROJECT REVIEW"})
aAdd(aSX5Alter,{xFilial("SX5"),"16","21","ENCERRAMENTO DE PROJETO","FINALIZACION DE PROYECTO","CLOSING OF PROJECT"})
aAdd(aSX5Alter,{xFilial("SX5"),"16","22","REVISAO DO AJUSTE A VALOR PRESENTE","REVISION DEL AJUSTE A VALOR PRESENTE","REVISION OF PRESENT VALUE ADJUSTMENT"})

ProcRegua(Len(aSX5))

dbSelectArea("SX5")
dbSetOrder(1)
For i:= 1 To Len(aSX5)
	If !Empty(aSX5[i][2])
		If !MsSeek(aSX5[i,1]+aSX5[i,2]+aSX5[i,3])
    		
    		lSX5 := .T.
			RecLock("SX5",.T.)
			
			For j:=1 To Len(aSX5[i])
				If !Empty(FieldName(FieldPos(aEstrut[j])))
					FieldPut(FieldPos(aEstrut[j]),aSX5[i,j])
				EndIf
			Next j
			
			dbCommit()
			MsUnLock()
			IncProc(STR0040) // //"Atualizando Tabelas..."
		EndIf
	EndIf
Next i

For i:= 1 To Len(aSX5Alter)
	If !Empty(aSX5Alter[i][2])
		lGrava := !(MsSeek(aSX5Alter[i,1]+aSX5Alter[i,2]+aSX5Alter[i,3]))
		
		lSX5 := .T.
		RecLock("SX5",lGrava)
		
		For j:=1 To Len(aSX5Alter[i])
			If !Empty(FieldName(FieldPos(aEstrut[j])))
				FieldPut(FieldPos(aEstrut[j]),aSX5Alter[i,j])
			EndIf
		Next j
		
		dbCommit()
		MsUnLock()
		IncProc(STR0040) // //"Atualizando Tabelas..."
	EndIf
Next i


If lSX5
	cTexto := STR0054+CRLF //'Arquivo de tabelas (SX5) atualizado.'
EndIf

Return cTexto


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ATFAtuSX7 ≥ Autor ≥ --------------------  ≥ Data ≥ 23/05/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Funcao de processamento da gravacao do SX7                 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ATFAtuSX7()
//  X7_CAMPO X7_SEQUENC X7_REGRA X7_CDOMIN X7_TIPO X7_SEEK X7_ALIAS X7_ORDEM X7_CHAVE X7_PROPRI X7_CONDIC

Local aSX7   := {}
Local aSX7Del:= {}
Local aEstrut:= {}
Local i      := 0
Local j      := 0
Local cTexto := ''
Local cAlias := ''
Local lSX7	 := .F.

If (cPaisLoc == "BRA")
	aEstrut:= {"X7_CAMPO","X7_SEQUENC","X7_REGRA","X7_CDOMIN","X7_TIPO","X7_SEEK","X7_ALIAS","X7_ORDEM","X7_CHAVE","X7_PROPRI","X7_CONDIC"}
Else
	aEstrut:= {"X7_CAMPO","X7_SEQUENC","X7_REGRA","X7_CDOMIN","X7_TIPO","X7_SEEK","X7_ALIAS","X7_ORDEM","X7_CHAVE","X7_PROPRI","X7_CONDIC"}
EndIf

//Exemplo
//Aadd(aSX7,{"AJ8_PROJPM","001","SPACE(LEN(M->AJ8_EDTPMS))","AJ8_EDTPMS","P","","",0,"","S",""})

//
// Campo FNF_INDAVP
//
aAdd( aSX7, {'FNF_INDAVP','001','FIT->FIT_PERIOD','FNF_PERIND','P','S','FIT',1,"xFilial('FIT')+M->FNF_INDAVP",'S',''} )
aAdd( aSX7, {'FNF_INDAVP','002','FIU->FIU_INDICE','FNF_TAXA','P','S','FIU',1,"xFilial('FIU')+M->(FNF_INDAVP)+DTOS(M->FNF_DTAVP)",'S',''} )

//
//FNH
//
aAdd( aSX7, {'FNH_OPER','001','SN0->N0_DESC01','FNH_DESCOP','P','S','SN0',1,"xFilial('SN0')+'21'+ M->FNH_OPER",'S',''} )
aAdd( aSX7, {'FNH_ROTINA','001','SN0->N0_DESC01','FNH_DESCRT','P','S','SN0',1,"xFilial('SN0')+'20'+ M->FNH_ROTINA",'S',''} )

//
//FNM
//
aAdd( aSX7, {'FNM_CODAPR','001','UsrRetName(M->FNM_CODAPR )','FNM_NOMAPR','P','N','',0,'','S',''} )
aAdd( aSX7, {'FNM_CODSOL','001','UsrRetName(M-> FNM_CODSOL)','FNM_NOMSOL','P','N','',0,'','S',''} )
aAdd( aSX7, {'FNM_OPER','001','SN0->N0_DESC01','FNM_DESCOP','P','S','SN0',1,"xFilial('SN0')+'21'+ M->FNM_OPER",'S',''} )
aAdd( aSX7, {'FNM_ROTINA','001','SN0->N0_DESC01','FNM_DESCRT','P','S','SN0',1,"xFilial('SN0')+'20'+M->FNM_ROTINA",'S',''} )

//SN1
aAdd( aSX7, {'N1_AQUISIC','001','M->N1_AQUISIC','N1_INIAVP','P','N','',0,"",'S',''} )

ProcRegua(Len(aSX7))

dbSelectArea("SX7")
dbSetOrder(1)
// Inclusao de Gatilhos
For i:= 1 To Len(aSX7)
	If !Empty(aSX7[i][1])
		lGrava := SX7->(!DBSeek(Padr( aSX7[i,1] , 10 ) +aSX7[i,2]))
		lSX7 := .T.
		If !(aSX7[i,1]$cAlias)
			cAlias += aSX7[i,1]+"/"
		EndIf
		RecLock("SX7",lGrava)
		
		For j:=1 To Len(aSX7[i])
			If !Empty(FieldName(FieldPos(aEstrut[j])))
				FieldPut(FieldPos(aEstrut[j]),aSX7[i,j])
			EndIf
		Next j
		
		dbCommit()
		MsUnLock()
		IncProc(STR0043) // //"Atualizando Gatilhos..."
	EndIf
Next i

// Exclusao de Gatilhos
For i:= 1 To Len( aSX7Del )
	If !Empty( aSX7Del[i][1] )
		If MsSeek( aSX7Del[i,1] + aSX7Del[i,2] )
			lSX7 := .T.
			If !( aSX7Del[i,1] $ cAlias )
				cAlias += aSX7Del[i,1] + "/"
			EndIf
			RecLock( "SX7" )
			SX7->( dbDelete() )
			dbCommit()
			SX7->( MsUnLock() )
			IncProc(STR0043) // //"Atualizando Gatilhos..."
		EndIf
	EndIf
Next i


If lSX7
	cTexto := STR0045+cAlias+CRLF //'Gatilhos atualizados : '
EndIf

Return cTexto

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ATFAtuSXA ≥ Autor ≥ --------------------  ≥ Data ≥ 23/05/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Funcao de processamento da gravacao do SXA                 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ATFAtuSXA()
//"XA_ALIAS","XA_ORDEM","XA_DESCRIC","XA_DESCSPA","XA_DESCENG","XA_PROPRI"

Local aSXA   := {}
Local aEstrut:= {}
Local i      := 0
Local j      := 0
Local aSX3	 := {}
Local nX	 := 0
Local lSXA	 := .F.
Local cAlias := ''
Local cTexto := ""

If (cPaisLoc == "BRA")
	aEstrut:= {"XA_ALIAS","XA_ORDEM","XA_DESCRIC","XA_DESCSPA","XA_DESCENG","XA_PROPRI"}
Else
	aEstrut:= {"XA_ALIAS","XA_ORDEM","XA_DESCRIC","XA_DESCSPA","XA_DESCENG","XA_PROPRI"}
EndIf

/*EXEMPLO PARA ALTERAR PASTAS
aSXA:= 	{	{"AF1","3","Codigo Estruturado","Codigo Estruturado","Structured Number","S"},;
{"AF8","5","Codigo Estruturado","Codigo Estruturado","Structured Number","S"},;
{"AFF","2","Contratos","Contratos","Contratos","S"}	}
*/

aAdd( aSXA, {'SN1','9','Projeto Imobilizado','Proyecto activo fijo','Immobilized Project','S'} )
aAdd( aSXA, {'SN1','8','AVP','AVP','AVP','S'} )

ProcRegua(Len(aSXA))

dbSelectArea("SXA")
dbSetOrder(1)
For i:= 1 To Len(aSXA)
	If !Empty(aSXA[i][1])
		If !MsSeek(aSXA[i,1]+aSXA[i,2])
			lSXA := .T.
			
			If !(aSXA[i,1]$cAlias)
				cAlias += aSXA[i,1]+"/"
			EndIf
			
			RecLock("SXA",.T.)
			For j:=1 To Len(aSXA[i])
				If !Empty(FieldName(FieldPos(aEstrut[j])))
					FieldPut(FieldPos(aEstrut[j]),aSXA[i,j])
				EndIf
			Next j
			
			dbCommit()
			MsUnLock()
			IncProc(STR0044) // //"Atualizando Folder de Cadastro..."
		EndIf
	EndIf
Next i

aSX3 := {}

dbSelectArea("SX3")
dbSetOrder(2)
For nx := 1 to Len(aSX3)
	If MsSeek(aSX3[nx][1])
		RecLock("SX3",.F.)
		SX3->X3_FOLDER := aSX3[nx][2]
		MsUnlock()
	EndIf
Next

If lSXA
	cTexto := STR0055+cAlias+CRLF //'Atualizado arquivos de folders (SXA).'
EndIf

Return cTexto

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ATFAtuSXB ≥ Autor ≥ --------------------- ≥ Data ≥ 23/05/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Funcao de processamento da gravacao do SXB                 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ATFAtuSXB()
//  XB_ALIAS XB_TIPO XB_SEQ XB_COLUNA XB_DESCRI XB_DESCSPA XB_DESCENG XB_CONTEM

Local aSXB   := {}
Local aEstrut:= {}
Local i      := 0
Local j      := 0
Local cTexto := ''
Local cAlias := ''
Local lSXB   := .F.
Local lAtual := .F.

If (cPaisLoc == "BRA")
	aEstrut:= {"XB_ALIAS","XB_TIPO","XB_SEQ","XB_COLUNA","XB_DESCRI","XB_DESCSPA","XB_DESCENG","XB_CONTEM"}
Else
	aEstrut:= {"XB_ALIAS","XB_TIPO","XB_SEQ","XB_COLUNA","XB_DESCRI","XB_DESCSPA","XB_DESCENG","XB_CONTEM"}
EndIf
/*EXEMPLO AJUSTE SXB
Aadd(aSXB,{"AJ8","1","01","DB","Consulta Gerencial","Consulta Gerencial","Consulta Gerencial","AJ8"})
Aadd(aSXB,{"AJ8","2","01","03","Codigo+Entidade Superior","Codigo+Entidade Superior","Codigo+Entidade Superior",""})
Aadd(aSXB,{"AJ8","4","01","01","Codigo","Codigo","Codigo","AJ8_CODPLA"})
Aadd(aSXB,{"AJ8","4","01","02","Codigo da Entidade","Codigo da Entidade","Codigo da Entidade","AJ8_CONTAG"})
Aadd(aSXB,{"AJ8","5","","","","","","AJ8->AJ8_CONTAG"})
Aadd(aSXB,{"AJ8","6","01","01","","","","PmsAJ8F3()"})
*/
/*
ou assim quando for para ajustar somente um campo
aAdd(aAjSXB, {"AL1","4","01","03",{"XB_CONTEM", "AL1_DESCRI"}})
*/

//
// Consulta FNB
//
aAdd( aSXB, {'FNB','1','01','DB','Projeto Imobilizado','Proyecto activo fijo','Immobilized Project ','FNB'} )
aAdd( aSXB, {'FNB','2','01','01','Codigo+revisao','Codigo+revision','Code+revision',''} )
aAdd( aSXB, {'FNB','4','01','01','Codigo','Codigo','Code','FNB_CODPRJ'} )
aAdd( aSXB, {'FNB','4','01','02','Revisao','Revision','Revision','FNB_REVIS'} )
aAdd( aSXB, {'FNB','4','01','03','Descricao','Descripcion','Description','FNB_DESC'} )
aAdd( aSXB, {'FNB','5','01','','','','','FNB->FNB_CODPRJ'} )
aAdd( aSXB, {'FNB','5','02','','','','','FNB->FNB_REVIS'} )
aAdd( aSXB, {'FNB','6','01','','','','','FNB->FNB_MSBLQL == "2"'} )

//
// Consulta FNB01
//
aAdd( aSXB, {'FNB01','1','01','DB','Projeto Imobilizado','Proyecto Inmoviliza','Fixed Project','FNB'} )
aAdd( aSXB, {'FNB01','2','01','01','Codigo+revisao','Codigo+revision','Code + Review',''} )
aAdd( aSXB, {'FNB01','4','01','01','Codigo','Codigo','Code','FNB_CODPRJ'} )
aAdd( aSXB, {'FNB01','4','01','02','Revisao','Revision','Review','FNB_REVIS'} )
aAdd( aSXB, {'FNB01','4','01','03','Descricao','Descripcion','Description','FNB_DESC'} )
aAdd( aSXB, {'FNB01','5','01','','','','','FNB->FNB_CODPRJ'} )

//
// Consulta FNB02
//
aAdd( aSXB, {'FNB02','1','01','DB','Projeto Imobilizado','Proyecto Inmovilizad','Fixed Project','FNB'} )
aAdd( aSXB, {'FNB02','2','01','01','Codigo+revisao','Codigo+revision','Code+review',''} )
aAdd( aSXB, {'FNB02','4','01','01','Codigo','Codigo','Code','FNB_CODPRJ'} )
aAdd( aSXB, {'FNB02','4','01','02','Revisao','Revision','Review','FNB_REVIS'} )
aAdd( aSXB, {'FNB02','4','01','03','Descricao','Descripcion','Description','FNB_DESC'} )
aAdd( aSXB, {'FNB02','5','01','','','','','FNB->FNB_CODPRJ'} )
aAdd( aSXB, {'FNB02','6','01','','','','','FNB->FNB_MSBLQL == "2" .and. FNB->FNB_STATUS == "1" '} )

//
// Consulta FNC
//
aAdd( aSXB, {'FNC','1','01','DB','Etapas Prj Imob.'    ,'Etapas Proy Act fijo','Immob.Projct Stages' ,'FNC'                    } )
aAdd( aSXB, {'FNC','2','01','01','Projeto+revisao+etap','Proyecto+revis+etapa','Projc+revision+stage',''                       } )
aAdd( aSXB, {'FNC','4','01','01','Projeto'             ,'Proyecto'            ,'Project'             ,'FNC_CODPRJ'             } )
aAdd( aSXB, {'FNC','4','01','02','Revisao'             ,'Revision'            ,'Revision'            ,'FNC_REVIS'              } )
aAdd( aSXB, {'FNC','4','01','03','Etapa'               ,'Etapa'               ,'Stage'               ,'FNC_ETAPA'              } )
aAdd( aSXB, {'FNC','4','01','04','Desc Etapa'          ,'Desc Etapa'          ,'Stage Discount'      ,'FNC_DSCETP'             } )
aAdd( aSXB, {'FNC','5','01','','','','','FNC->FNC_CODPRJ'} )
aAdd( aSXB, {'FNC','5','02','','','','','FNC->FNC_REVIS'} )
aAdd( aSXB, {'FNC','5','03','','','','','FNC->FNC_ETAPA'} )
aAdd( aSXB, {'FNC','6','01','','','','','FNC->FNC_MSBLQL == "2" '} )

//
// Consulta FND
//
aAdd( aSXB, {'FND','1','01','DB','Item Etp Proj Imob.' ,'Item Etp Proy Ac.Fij','ImmobProjctStageItem','FND'                    } )
aAdd( aSXB, {'FND','2','01','01','Projeto+revisao+etap','Proyecto+revis+etapa','Projc+revision+stage',''                       } )
aAdd( aSXB, {'FND','4','01','01','Projeto'             ,'Proyecto'            ,'Project'             ,'FND_CODPRJ'             } )
aAdd( aSXB, {'FND','4','01','02','Revisao'             ,'Revision'            ,'Revision'            ,'FND_REVIS'              } )
aAdd( aSXB, {'FND','4','01','03','Etapa'               ,'Etapa'               ,'Stage'               ,'FND_ETAPA'              } )
aAdd( aSXB, {'FND','4','01','04','Item','Item','Item','FND_ITEM'} )
aAdd( aSXB, {'FND','4','01','05','Desc.Item'           ,'Desc.Item'           ,'Item Discount'       ,'FND_DSCITE'             } )
aAdd( aSXB, {'FND','5','01','','','','','FND->FND_CODPRJ'} )
aAdd( aSXB, {'FND','5','02','','','','','FND->FND_REVIS'} )
aAdd( aSXB, {'FND','5','03','','','','','FND->FND_ETAPA'} )
aAdd( aSXB, {'FND','5','04','','','','','FND->FND_ITEM'} )
aAdd( aSXB, {'FND','6','01','','','','','FND->FND_MSBLQL == "2" '} )

// Exclui consulta FNI se encontrar no ambiente o tipo '3' criado.
AjSXBFNI()

// Consulta FNI
aAdd( aSXB, {'FNI','1','01','DB',"Õndices depreciaÁ„o","Indices depreciacion","Depreciation Indices",'FNI'                   } )
aAdd( aSXB, {'FNI','2','01','01',"CÛdigo do Ìndice"   ,"Codigo del indice"   ,"Index Code"          ,'01'                    } )
aAdd( aSXB, {'FNI','4','01','01',"CÛdigo"             ,"Codigo"              ,"Code"                ,'FNI_CODIND'            } )
aAdd( aSXB, {'FNI','4','01','02',"DescriÁ„o"          ,"Descripcion"         ,"Description"         ,'FNI_DSCIND'            } )
aAdd( aSXB, {'FNI','4','01','03',"PerÌodo"            ,"Periodo"             ,"Period"              ,'FNI_PERIOD'            } )
aAdd( aSXB, {'FNI','5','01','',"", "", "",'FNI->FNI_CODIND'} )
aAdd( aSXB, {'FNI','6','01','',"", "", "",'FNI->FNI_MSBLQL != "1" .And. FNI->FNI_STATUS == "1" '} )

//
//Consulta FNH - OperaÁıes com controle de aprovaÁ„o
//
aAdd( aSXB, {'FNH','1','01','DB','Cad. de operaÁıes','Arc. de operaciones','Operations Register','FNH'                       } )
aAdd( aSXB, {'FNH','2','01','01','CÛdigo da rotina' ,'Codigo de rutina'   ,'Routine Code'       ,''                          } )
aAdd( aSXB, {'FNH','4','01','01','Rotina','Rutina','Routine','FNH_ROTINA'} )
aAdd( aSXB, {'FNH','4','01','02','OperaÁ„o'         ,'Operacion'          ,'Operation'          ,'FNH_OPER'                  } )
aAdd( aSXB, {'FNH','4','01','03','Status'           ,'Estatus'            ,'Status'             ,'FNH_STATUS'                } )
aAdd( aSXB, {'FNH','5','01','','','','','FNH->(FNH_ROTINA+FNH_OPER)'} )

//
// Consulta FNH01 - OperaÁıes com controle de aprovaÁ„o
//
aAdd( aSXB, {'FNH01','1','01','DB','Cad. de operaÁıes','Cad. de operaciones','Operation Record','FNH'                                                             } )
aAdd( aSXB, {'FNH01','2','01','01','CÛdigo da rotina' ,'Codigo de rutina'   ,'Routine Code'    ,''                                                                } )
aAdd( aSXB, {'FNH01','4','01','01','Rotina'           ,'Rutina'             ,'Routine'         ,'FNH_ROTINA'                                                      } )
aAdd( aSXB, {'FNH01','4','01','02','OperaÁ„o'         ,'Operacion'          ,'Operation'       ,'FNH_OPER'                                                        } )
aAdd( aSXB, {'FNH01','4','01','03','Desc. Opera.'     ,'Desc. Opera.'       ,'Oper. Desc.'     ,'Posicione("SN0",1,xFilial("SN0")+"21"+FNH->FNH_OPER,"N0_DESC01")'} )
aAdd( aSXB, {'FNH01','4','01','04','Status'           ,'Estatus'            ,'Status'          ,'FNH_STATUS'                                                      } )
aAdd( aSXB, {'FNH01','5','01',''  ,''                 ,''                   ,''                ,'FNH->FNH_OPER'                                                   } )
aAdd( aSXB, {'FNH01','6','01',''  ,''                 ,''                   ,''                ,"FNH->FNH_ROTINA == FWFLDGET('FNK_ROTINA')"                       } )

//
// Consulta SN0 - Tabela GenÈrica "20"
//
aAdd( aSXB, {'SN020','1','01','DB','Tabela generica "20"','Tabla generica "20"','Generic Table "20"','SN0'                             } )
aAdd( aSXB, {'SN020','2','01','01','Tabela + Chave'      ,'Tabla + Clave'      ,'Table + Key'       ,''                                } )
aAdd( aSXB, {'SN020','4','01','01','Tabela'              ,'Tabla'              ,'Table'             ,'N0_TABELA'                       } )
aAdd( aSXB, {'SN020','4','01','02','Chave'               ,'Clave'              ,'Key'               ,'N0_CHAVE'                        } )
aAdd( aSXB, {'SN020','4','01','03','Descric M1'          ,'Descric M1'         ,'Desc M1'           ,'ALLTRIM(N0_DESC01)'              } )
aAdd( aSXB, {'SN020','5','01','','','','','SN0->N0_CHAVE'} )
aAdd( aSXB, {'SN020','6','01','','','','',"ALLTRIM(SN0->N0_TABELA)  == '20'"} )

//
// Consulta SN0 - Tabela GenÈrica "21"
//
aAdd( aSXB, {'SN021','1','01','DB','Tabela generica "21"','Tabla generica "21"','Generic Table "21"','SN0'                             } )
aAdd( aSXB, {'SN021','2','01','01','Tabela + Chave'      ,'Tabla + Clave'      ,'Table + Key'       ,''                                } )
aAdd( aSXB, {'SN021','4','01','01','Tabela'              ,'Tabla'              ,'Table'             ,'N0_TABELA'                       } )
aAdd( aSXB, {'SN021','4','01','02','Chave'               ,'Clave'              ,'Key'               ,'N0_CHAVE'                        } )
aAdd( aSXB, {'SN021','4','01','03','Descric M1'          ,'Descric M1'         ,'Desc M1'           ,'ALLTRIM(N0_DESC01)'              } )
aAdd( aSXB, {'SN021','5','01','','','','','SN0->N0_CHAVE'} )
aAdd( aSXB, {'SN021','6','01','','','','',"ALLTRIM(SN0->N0_TABELA)  == '21'"} )
//
// Consulta SN302
//
aAdd( aSXB, {'SN302','1','01','RE','Valores do Ativo','Valores del Activo','Asset Values','SN3'} )
aAdd( aSXB, {'SN302','2','01','01','','','','FNJSxbFilt()'} )
aAdd( aSXB, {'SN302','5','01',''  ,'','','','FNJSxbRFlt(1)'} )
aAdd( aSXB, {'SN302','5','02',''  ,'','','','FNJSxbRFlt(2)'} )
aAdd( aSXB, {'SN302','5','03',''  ,'','','','FNJSxbRFlt(3)'} )
aAdd( aSXB, {'SN302','5','04',''  ,'','','','FNJSxbRFlt(4)'} )
//
// Consulta FNQ - Margem Gerencial
//
aAdd( aSXB, {'FNQ','1','01','DB','Margem Gerencial'	,'Margen Gerencial'	,'Management Margin'	,'FNQ'			} )
aAdd( aSXB, {'FNQ','2','01','01','Codigo + Revisao'	,'Codigo + Revision'	,'Code + Review'		,''				} )
aAdd( aSXB, {'FNQ','4','01','01',"Codigo"				,"Codigo"					,"Code"					,'FNQ_COD'	} )
aAdd( aSXB, {'FNQ','4','01','02','Revisao'				,'revision'         	,'Review'					,'FNQ_REV'	} )
aAdd( aSXB, {'FNQ','4','01','03',"DescriÁ„o"			,"Descripcion"     		,"Description"			,'FNQ_DESC'	} )
aAdd( aSXB, {'FNQ','5','01',''  ,''						,''							,''							,'FNQ->FNQ_COD'} )
aAdd( aSXB, {'FNQ','5','02',''  ,''						,''							,''							,'FNQ->FNQ_REV'} )
aAdd( aSXB, {'FNQ','6','01',''  ,''						,''							,''							,'(FNQ->FNQ_MSBLQL == "2" .AND. FNQ->FNQ_STATUS == "1")'} )
//
// Consulta FN1
//
aAdd( aSXB, {'FN1','1','01','DB','Proc. Custo Empres.','Proc. Costo Empres.','Loan Cost Proc.','FN1'} )
aAdd( aSXB, {'FN1','2','01','01','Cod Processo','Cod Proceso','Process Code',''} )
aAdd( aSXB, {'FN1','4','01','01','Cod Processo','Cod Proceso','Process Code','FN1_PROC'} )
aAdd( aSXB, {'FN1','4','01','02','Data Proc','Fecha Proc','Proc. Date','FN1_DATA'} )
aAdd( aSXB, {'FN1','4','01','03','Descricao','Descripcion','Description','FN1_DESC'} )
aAdd( aSXB, {'FN1','5','01','','','','','FN1->FN1_PROC'} )
//
// Consulta SN303 - Valor de Ativo II
//
aAdd( aSXB, {'SN303','1','01','RE','Valores do Ativo II','Valores del Activo II','Asset Values II','SN3'} )
aAdd( aSXB, {'SN303','2','01','01','','','','FNXSxbFilt()'} )
aAdd( aSXB, {'SN303','5','01',''  ,'','','','FNXSxbRFlt(2)'} )
aAdd( aSXB, {'SN303','5','02',''  ,'','','','FNXSxbRFlt(3)'} )
aAdd( aSXB, {'SN303','5','03',''  ,'','','','FNXSxbRFlt(4)'} )
aAdd( aSXB, {'SN303','5','04',''  ,'','','','FNXSxbRFlt(5)'} )

//
// Consulta FNU - Controle de Provisao
//
aAdd( aSXB, {'FNU','1','01','DB','Controle de Provis„o'	,'Control de Provision' ,'Provision Control'	,'FNU'			} )
aAdd( aSXB, {'FNU','2','01','01','Codigo + Revisao'		,'Codigo + Revision'	,'Code + Review'		,''				} )
aAdd( aSXB, {'FNU','4','01','01',"Codigo"				,"Codigo"				,"Code"					,'FNU->FNU_COD'	} )
aAdd( aSXB, {'FNU','4','01','02','Revis„o'				,'Revision'         	,'Review'				,'FNU->FNU_REV'	} )
aAdd( aSXB, {'FNU','4','01','03',"DescriÁ„o"			,"Descripcion"     		,"Description"			,'FNU->FNU_DESCR'	} )
aAdd( aSXB, {'FNU','5','01',''  ,''						,''						,''						,'FNU->FNU_COD'} )
aAdd( aSXB, {'FNU','6','01',''  ,''						,''						,''						,'(FNU->FNU_MSBLQL == "2" .AND. !(FNU->FNU_STATUS $ "0/3"))'} )

//
// Atualizando dicion·rio
//

ProcRegua(Len(aSXB))

dbSelectArea("SXB")
dbSetOrder(1)
For i:= 1 To Len(aSXB)
	If !Empty(aSXB[i][1])
			
		lAtual := !MsSeek(Padr(aSXB[i,1], Len(SXB->XB_ALIAS))+aSXB[i,2]+aSXB[i,3]+aSXB[i,4])
			
			lSXB := .T.
			If !(aSXB[i,1]$cAlias)
				cAlias += aSXB[i,1]+"/"
			EndIf
		
		RecLock("SXB",lAtual)
			
			For j:=1 To Len(aSXB[i])
				If !Empty(FieldName(FieldPos(aEstrut[j])))
					FieldPut(FieldPos(aEstrut[j]),aSXB[i,j])
				EndIf
			Next j
			
			dbCommit()
			MsUnLock()
			IncProc(STR0046) // //"Atualizando Consultas Padroes..."
		EndIf
Next i

If lSXB
	cTexto := STR0047+cAlias+CRLF //'Consultas Padroes Atualizadas : '
EndIf

Return cTexto

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ATFOpenSM0≥ Autor ≥ --------------------- ≥ Data ≥ 23/05/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Realiza abertura do SIGAMAT.EMP de forma exclusiva         ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ATFOpenSM0()

Local nLoop := 0

For nLoop := 1 To 20
	dbUseArea(.T., , "SIGAMAT.EMP", "SM0", .T., .F.)
	If !Empty(Select("SM0"))
		lOpen := .T.
		dbSetIndex("SIGAMAT.IND")
		Exit
	EndIf
	Sleep(500)
Next nLoop

If !lOpen
	Aviso( STR0001, STR0050 , {STR0051}, 2)		//"Atencao!"###"Nao foi possivel a abertura da tabela de empresas de forma exclusiva!"###"Finalizar"
EndIf

Return lOpen


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ ProxSX3  ≥ Autor ≥ --------------------- ≥ Data ≥ 23/05/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Retorna a prÛxima ordem disponivel no SX3 para o ALIAS     ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ProxSX3(cAlias,cCpo)
Local aArea 	:= GetArea()
Local aAreaSX3 	:= SX3->(GetArea())
Local nOrdem	:= 0
Local nPosOrdem	:= 0

Static aOrdem	:= {}

Default cCpo	:= ""

IF !Empty(cCpo)
	SX3->(DbSetOrder(2))
	IF SX3->(MsSeek(cCpo))
		nOrdem := Val(RetAsc(SX3->X3_ORDEM,3,.F.))
	ENDIF
ENDIF

IF Empty(cCpo) .OR. nOrdem == 0

	IF (nPosOrdem := aScan(aOrdem, {|aLinha| aLinha[1] == cAlias})) == 0
	
		SX3->(dbSetOrder(1))
		SX3->(MsSeek(cAlias))
		WHILE SX3->(!EOF()) .AND. SX3->X3_ARQUIVO == cAlias
			nOrdem++
			SX3->(dbSkip())
		END	
		nOrdem++
		AADD(aOrdem,{cAlias,nOrdem})
	
	ELSE
    	aOrdem[nPosOrdem][2]++
    	nOrdem := aOrdem[nPosOrdem][2]
    ENDIF

ENDIF

RestArea(aAreaSX3)
RestArea(aArea)
Return RetAsc(Str(nOrdem),2,.T.)

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunÁ„o    ≥ ATFAtuHlp ≥ Autor ≥ Eduardo Nunes Cirqueira ≥ Data ≥ 16/07/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Funcao de processamento da atualizacao dos helps de campos    ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                           ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ATFAtuHlp(aChkHelp)
Local aHlpPor	:= {}
Local aHlpEng	:= {}
Local aHlpSpa	:= {}

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Adicionar aqui as tabelas atualizadas≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
Local cAlias	:= ""

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Atualiza Help                   ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
aHlpPor := {"N„o È possÌvel revisar"," o ajuste a valor presente para"," o Ìndice informado.     "}
aHlpSpa := {"No se puede revisar el"," ajuste a valor presente para"," el indice que se informo."}
aHlpEng := {"The present value adjustment"," cannot be revised for"," the index entered.			"}
SetHelp(    "PAFA440NORE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Informe um Ìndice cujo c·lculo"," do novo ajuste a valor"," presente seja igual ou ","superior a depreciaÁ„o ","acumulada do bem								"}
aHlpSpa := {"Informe un indice cuyo calculo"," del nuevo ajuste a"," valor presente sea igual o"," superior a la depreciacion ","acumulada del bien						"}
aHlpEng := {"Enter an index whose calculation"," of new present value adjustment"," is equal to or ","higher than the asset ","accumulated depreciation."}
SetHelp(    "SAFA440NORE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Campo Ind.calculo (N3_CODIND)"," n„o preenchido. "}
aHlpSpa := {"Campo Ind.calculo (N3_CODIND)"," no rellenado.  	"}
aHlpEng := {"Field Ind.calculation ","(N3_CODIND) not filled"," out.  "}
SetHelp(    "PAF010CODIN", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Para o tipo de depreciaÁ„o"," c·lculo por Ìndice È necess·rio"," informar o cÛdigo do ","Ìndice (N3_CODIND).   	"}
aHlpSpa := {"Para el tipo de depreciacion"," calculo por indice es necesario"," informar el codigo"," del indice (N3_CODIND). "}
aHlpEng := {"For the type of the ","calculation depreciation"," by index, enter"," the index code ","(N3_CODIND).   "}
SetHelp(    "SAF010CODIN", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"N„o existe(m) taxa(s) ","v·lida(s) para o Ìndice ","e perÌodo da depreciaÁ„o.    			"}
aHlpSpa := {"No existe(n) tasa(s) ","valida(s) para el indice"," y periodo de depreciacion.       		"}
aHlpEng := {"There is/are no valid"," rate(s) for depreciation"," index and period.   "}
SetHelp(    "PATFNOTAXIN", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Cadastre a(s) taxa(s) para ","o Ìndice e perÌodo a depreciar.		"}
aHlpSpa := {"Registre la(s) tasa(s) para ","el indice y periodo por depreciar."}
aHlpEng := {"Register the rate(s) for"," index and period to depreciate."}
SetHelp(    "SATFNOTAXIN", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Dicion·rio de dados desatualizado.	"}
aHlpSpa := {"Diccionario de datos desactualizado"}
aHlpEng := {"Data dictionary is out of date.  "}
SetHelp(    "PAFA440FNF", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Atualize o dicion·rio de dados.		"}
aHlpSpa := {"Actualizar el diccionario de datos."}
aHlpEng := {"Update data dictionary."}
SetHelp(    "SAFA440FNF", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"N„o È possÌvel revisar","constituiÁıes encerradas ou ","bloqueadas por revis„o."}
aHlpSpa := {"No es posible revisar ","constituciones finalizadas"," o bloqueadas por revision"}
aHlpEng := {"You cannot review ","constitutions closed"," or blocked due ","to review."}
SetHelp(    "PAFA440ENCE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"A revis„o do ajuste a ","valor presente somente pode ser ","realizada para as constituiÁıes"," ativas ou bloqueadas por aprovaÁ„o."}
aHlpSpa := {"La revision del ajuste ","a valor presente puede realizarse ","para las constituciones activas ","o bloqueadas por aprobacion.		"}
aHlpEng := {"Present value adjustment"," can only be reviewed for ","active constitutions or for"," the ones blocked ","due to approval."}
SetHelp(    "SAFA440ENCE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"N„o È possÌvel realizar"," revisıes em data igual ","ou inferior a data do ","˙ltimo c·lculo de ","depreciaÁ„o.        "}
aHlpSpa := {"No es posible realizar"," revisiones en fecha igual"," o inferior a la fecha"," del ultimo calculo"," de depreciacion. "}
aHlpEng := {"You cannot carry out ","reviews on a date equal ","to or before the last"," calculation of depreciation.     "}
SetHelp(    "PAFA440DEPR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Realize a revis„o apÛs a"," data do ˙ltimo c·lculo"," de depreciaÁ„o.				"}
aHlpSpa := {"Realice la revision luego","de la fecha del ultimo ","calculo de depreciacion	"}
aHlpEng := {"Carry out a review after"," the last calculation of ","depreciation."}
SetHelp(    "SAFA440DEPR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"N„o È possÌvel realizar"," a revis„o em data inferior"," a aquisiÁ„o do bem.				"}
aHlpSpa := {"No es posible realizar"," la revision en fecha inferior"," a la adquisicion del bien.	"}
aHlpEng := {"You cannot carry out"," reviews on a date before"," the asset ","acquisition."}
SetHelp(    "PAFA440AQUI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Realize a revis„o em ","data igual ou superior"," a aquisiÁ„o do bem.					"}
aHlpSpa := {"Realice la revision"," en fecha igual o superior ","a la adquisicion del bien.		"}
aHlpEng := {"Carry out a review ","on a date equal to ","or after the asset"," acquisition.	"}
SetHelp(    "SAFA440AQUI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
																														
aHlpPor := {"Dicion·rio de dados desatualizado.	"}
aHlpSpa := {"Diccionario de datos desactualizado"}
aHlpEng := {"Data dictionary is out of date."}
SetHelp(    "PAFA002DIC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Atualize o dicion·rio de dados.		"}
aHlpSpa := {"Actualizar el diccionario de datos."}
aHlpEng := {"Update data dictionary."}
SetHelp(    "SAFA002DIC	", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Dicion·rio de dados desatualizado.	"}
aHlpSpa := {"Diccionario de datos desactualizado"}
aHlpEng := {"Data dictionary is out of date."}
SetHelp(    "PAFA004DIC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Atualize o dicion·rio de dados.		"}
aHlpSpa := {"Actualizar el diccionario de datos."}
aHlpEng := {"Update data dictionary."}
SetHelp(    "SAFA004DIC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Usu·rio sem permiss„o"," para aprovar/rejeitar"," o movimento de aprovaÁ„o.        "}
aHlpSpa := {"Usuario sin permiso ","para aprobar/rechazar el"," movimiento de aprobacion.       "}
aHlpEng := {"User not allowed to ","approve/reject the ","approval operation.    "}
SetHelp(    "PAFA004NAPR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
																																	
aHlpPor := {"Somente o usu·rio aprovador"," poder· aprovar/rejeitar"," o movimento de aprovaÁ„o.		"}
aHlpSpa := {"Solamente el usuario ","aprobador podra aprobar/rechazar"," el movimiento de aprobacion.	"}
aHlpEng := {"Only the approver user"," can approve/reject the"," approval operation."}
SetHelp(    "SAFA004NAPR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"O movimento de aprovaÁ„o ","somente pode ser aprovado ","ou rejeitado."}
aHlpSpa := {"El movimiento de aprobacion"," solamente se puede ","aprobar o rechazar."}
aHlpEng := {"The approval operation can"," only be approved or rejected."}
SetHelp(    "PAFA004STAT", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"O movimento de aprovaÁ„o","deve ser aprovado ou rejeitado."," Para mantÍ-lo pendente,"," cancele a operaÁ„o."}
aHlpSpa := {"El movimiento de aprobacion"," debe aprobarse o rechazarse. ","Para mantÍ-lo pendente, ","cancele a operaÁ„o.	"}
aHlpEng := {"The approval operation must"," be approved or rejected. To"," keep it pending, cancel"," the operation."}
SetHelp(    "SAFA004STAT", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Movimento de aprovaÁ„o"," j· aprovado/rejeitado."}
aHlpSpa := {"Movimiento de aprobacion"," ya aprobado/rechazado."}
aHlpEng := {"Approval operation already"," approved/rejected."}
SetHelp(    "PAFA004NOK", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Somente movimentos de ","aprovaÁ„o pendentes podem"," ser aprovados/rejeitados."}
aHlpSpa := {"Solamente movimientos"," de aprobacion pendientes"," pueden aprobarse/rechazarse.	"}
aHlpEng := {"Only pending approval"," operations can be ","approved/rejected."}
SetHelp(    "SAFA004NOK", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
// Helps Tabela FNB
//
aHlpPor := {"Filial do Sistema"}
aHlpSpa := {"Sucursal del Sistema"}
aHlpEng := {"System Branch"}
SetHelp(    "PFNB_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"IdentificaÁ„o do"," movimento ou processo"}
aHlpSpa := {"Identificacion del"," movimiento o proceso	"}
aHlpEng := {"Identification of ","the transaction or process."}
SetHelp(    "PFNB_IDMOV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Indice Financeiro para ","o calculo do AVP do Projeto"}
aHlpSpa := {"Indice Financiero para ","el calculo del AVP del Proyecto"}
aHlpEng := {"Financial Ratio for AVP"," of Project calculation"}
SetHelp(    "PFNB_INDAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Local do projeto, corresponde"," ao campo Local da ficha ","do imobilizado "}
aHlpSpa := {"Local del proyecto, corresponde"," al campo Local de la ","ficha del fijo "}
aHlpEng := {"Project place corresponds to the ","filed Place of the ","fixed asset form "}
SetHelp(    "PFNB_LOCPRJ", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Moeda da movimentaÁ„o"}
aHlpSpa := {"Moneda del movimiento"}
aHlpEng := {"Transaction currency"}
SetHelp(    "PFNB_MOEDA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Indica se o projeto de ","imobilizado controla margem ","de receita na apropriaÁ„o"," dos custos"}
aHlpSpa := {"Indica si el proyecto ","de inmovilizado controla margen","de ingreso en la apropiacion ","de los costos"}    
aHlpEng := {"Indicates whether the ","fixed assets project controls ","revenue margin in cost"," allocation.  "}
SetHelp(    "PFNB_MRGREC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Indica se o projeto"," est· bloqueado"}
aHlpSpa := {"Indica si el proyecto","esta bloqueado"}
aHlpEng := {"Indicates whether project"," is blocked."}
SetHelp(    "PFNB_MSBLQL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"N˙mero da revis„o do"," projeto de Imobilizado"}
aHlpSpa := {"Numero de la revision ","del proyecto de Inmovilizado"}
aHlpEng := {"Fixed Assets Project"," Review Number"}
SetHelp(    "PFNB_REVIS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Sub-Tipo do projeto"}
aHlpSpa := {"Sub-Tipo del proyecto"}
aHlpEng := {"Project Sub-Type"}
SetHelp(    "PFNB_SBTIPO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Status do projeto de"," Imobilizado"}
aHlpSpa := {"Estatus del proyecto"," de Inmovilizado"}
aHlpEng := {"Fixed Assets Project ","Status"}
SetHelp(    "PFNB_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo do Projeto de"," Imobilizado"}
aHlpSpa := {"Tipo del Proyecto de ","Inmovilizado"}
aHlpEng := {"Fixed Assets Project"," Type"}
SetHelp(    "PFNB_TIPO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo base das fichas de ","ativo que ser„o geradas"," vinculadas ao projeto"," de imobilizado"}
aHlpSpa := {"Codigo base de las fichas ","de activo que se generaran"," vinculadas al proyecto"," de inmovilizado"}
aHlpEng := {"Base code of assets forms"," that are generated linked ","to the fixed asset"," project."}
SetHelp(    "PFNB_CBASE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Codigo do projeto do PMS"," ao qual o projeto de"," imobilizado est·"," vinculado	"}
aHlpSpa := {"Codigo del proyecto del"," PMS al que el proyecto ","de inmovilizado ","esta vinculado"}
aHlpEng := {"PMS project code to which"," the fixed assets project"," is linked."}
SetHelp(    "PFNB_CODPMS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Codigo do Projeto ","de Imobilizado	"}
aHlpSpa := {"Codigo del Proyecto ","de Inmovilizado"}
aHlpEng := {"Fixed Assets Project"," Code	"}
SetHelp(    "PFNB_CODPRJ", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Descricao resumida"," do Projeto de imobilizado	"}
aHlpSpa := {"Descripcion resumida ","del Proyecto de inmovilizado	"}
aHlpEng := {"Summarized description ","of Fixed Assets Project"}
SetHelp(    "PFNB_DESC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data na qual o ","projeto foi encerrado"}
aHlpSpa := {"Fecha en que el"," proyecto se concluyo"}
aHlpEng := {"Date when project"," was closed."}
SetHelp(    "PFNB_DTENCR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data de inicio do projeto,"," essa data ser· a data de ","aquisiÁ„o da ficha"," do Imobilizado"}
aHlpSpa := {"Fecha de inicio del proyecto, ","esa fecha sera la fecha ","de adquisicion de"," ficha del fijo"}
aHlpEng := {"Project initial date. This ","date is the fixed asset ","acquisition "}
SetHelp(    "PFNB_DTINIC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data de Revis„o do projeto 	"}
aHlpSpa := {"Fecha de Revision del proyecto "}
aHlpEng := {"Product Review Date   	"}
SetHelp(    "PFNB_DTREV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo da EDT do projeto ","do PMS ao qual o projeto ","de imobilizado esta"," vinculado"}
aHlpSpa := {"Codigo de la EDT del ","proyecto del PMS al que el ","proyecto de inmovilizado"," esta vinculado"}
aHlpEng := {"EDT code of the PMS ","project code to which the ","fixed assets project is ","linked."}
SetHelp(    "PFNB_EDTPMS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data de Inicio da Provis„o,"," essa data ser· a data de inicio"," do AVP, e a data de inicio da"," depreciaÁ„o da ficha do"," Imobilizado"}  
aHlpSpa := {"Fecha de Inicio de la ","Disposicion, esa fecha sera la"," fecha de inicio del AVP,"," y la feha de inicio de la"," depreciacion de la ficha del Fijo"}
aHlpEng := {"Provision Start Date, ","this date is the AVP start date"," of the depreciation of ","fixed asset form. "}
SetHelp(    "PFNB_DTPROV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
 
aHlpPor := {"Determina qual o tipo de apropriaÁ„o ","do AVP: Total ir· constituir o ","AVP na ficha do imobilizado. ","Parcela ir· constituir AVP","nas fichas de provis„o geradas"," pela rotina de apropriaÁ„o ","de provis„o "}
aHlpSpa := {"Determina que tipo de apropiacion ","de AVP: El Total constituira el AVP"," en la ficha del fijo La ","cuota se constituira AVP en las"," fichas de provision generadas"," por la rutina de apropiacion"," de provision "}
aHlpEng := {"Defines the AVP appropriation type. ","Total will constitute the AVP in ","the fixed asset form. Installment"," will constitute AVP in"," the provision forms generated ","by the routine of provision ","appropriation."}
SetHelp(    "PFNB_TPAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Data prevista para ","execuÁ„o da etapa do ","projeto."}
aHlpSpa := {" Fecha prevista para ","ejecucion del ","proyecto	"}
aHlpEng := {" Planned date for the ","execution of the project ","stage."}
SetHelp(    "PFNB_PRVEXC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
 
//
// Helps Tabela FNC 
//                  
aHlpPor := {"Filial do Sistema"}
aHlpSpa := {"Sucursal del Sistema"}
aHlpEng := {"System Branch"}
SetHelp(    "PFNC_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Indica se o projeto"," est· bloqueado"}
aHlpSpa := {"Indica si el proyecto"," esta bloqueado"}
aHlpEng := {"Indicates whether ","project is blocked."}
SetHelp(    "PFNC_MSBLQL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" CÛdigo do projeto do ","PMS ao qual a etapa ","do projeto de imobilizado"," est· vinculada"}
aHlpSpa := {" Codigo del proyecto ","del PMS al que la etapa ","del proyecto de ","inmovilizado esta ","vinculada	"}
aHlpEng := {" PMS project code to"," which the stage of ","fixed assets project is"," linked."}
SetHelp(    "PFNC_CODPMS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Codigo do Projeto de ","imobilizado ao qual ","a etapa pertence"}
aHlpSpa := {" Codigo del Proyecto ","de inmovilizado al que"," la etapa pertenece"}
aHlpEng := {" Fixed Assets Project ","to which this stage"," belongs to."}
SetHelp(    "PFNC_CODPRJ", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Descricao da etapa ","do projeto"}
aHlpSpa := {"Descripcion da etapa ","del proyecto"}
aHlpEng := {"Project sate description"}
SetHelp(    "PFNC_DSCETP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data na qual a etapa ","do projeto foi ","encerrada"}
aHlpSpa := {"Fecha en que la etapa ","del proyecto"," se concluyo"}
aHlpEng := {"Data in which the"," project stage was","closed."}
SetHelp(    "PFNC_DTENCR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo da EDT do ","projeto do PMS ao ","qual a etapa do o projeto"," de imobilizado ","est· vinculada"}
aHlpSpa := {"Codigo de la EDT ","del proyecto de PMS ","al que la etapa del ","proyecto de inmovilizado"," esta vinculada"}
aHlpEng := {"EDT code of the"," PMS project code to ","which the stage of fixed ","assets project is ","linked."}
SetHelp(    "PFNC_EDTPMS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Etapa do projeto"}
aHlpSpa := {"Etapa del proyecto"}
aHlpEng := {"Project stage"}
SetHelp(    "PFNC_ETAPA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Indice para c·lculo de AVP"," da etapa do projeto.","Este Indice pode ser ","diferente do Ìndice ","geral do projeto."," Caso cont·rio ser· ","utilizado definido ","do cabeÁalho ","do projeto"}
aHlpSpa := {"Indice para calculo de AVP"," de la etapa del proyecto."," Este Indice puede ","ser diferente del"," indice general del ","proyecto. De lo ","contrario se utilizara"," definido del encabezado"," del proyecto"}  
aHlpEng := {"AVP calculation index of ","project stage. This index"," may be different of ","the project general"," index. Otherwise,"," the one defined ","in the project header"," is used."}
SetHelp(    "PFNC_INDAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Revisao do projeto de"," imobilizado ao qual ","a etapa pertence"}
aHlpSpa := {"Revision del proyecto"," de inmovilizado al que"," la etapa pertenece"}
aHlpEng := {"Fixed Assets Project ","review to which this ","stage belongs to. "}
SetHelp(    "PFNC_REVIS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Sub-Tipo de imobilizado"," do item da etapa ","do projeto"}
aHlpSpa := {"Sub-tipo de inmovilizado"," del item de la etapa ","del proyecto"}
aHlpEng := {"Sub-Type of fixed assets"," of project stage ","item."}
SetHelp(    "PFNC_SBTIPO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Indica o status da ","etapa do projeto"}
aHlpSpa := {"Indica el estatus ","de la etapa del proyecto"}
aHlpEng := {"Indicates the project"," stage status."}
SetHelp(    "PFNC_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
																																							
aHlpPor := {"Tipo de classificaÁ„o ","de imobilizado do item da ","etapa do projeto"}
aHlpSpa := {"Tipo de clasificacion"," de inmovilizado del item de ","la etapa del proyecto"}
aHlpEng := {"Type of fixed assets ","classification of project ","stage item."}
SetHelp(    "PFNC_TIPO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)  

aHlpPor := {"Data de Inicio da Provis„o,"," essa data ser· a data de"," inicio do AVP, e a data de"," inicio da depreciaÁ„o da ","ficha do Imobilizado"}
aHlpSpa := {"Fecha de Inicio de la Disposicion,"," esa fecha sera la fecha de ","inicio del AVP, y la fecha"," de inicio de la depreciacion ","de la ficha del Fijo"}
aHlpEng := {"Provision Start Date, this ","date is the AVP start date of"," the depreciation of fixed ","asset form."}
SetHelp(    "PFNC_DTPROV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Determina qual o tipo ","de apropriaÁ„o do AVP:","Total ir· constituir o AVP na"," ficha do imobilizado."," Parcela ir· constituir"," AVP nas fichas ","de provis„o geradas"," pela rotina de apropriaÁ„o"," de provis„o"}
aHlpSpa := {"Determina que tipo de ","apropiacion de AVP:","El Total constituira el AVP en"," la ficha del fijo La ","cuota se constituira AVP"," en las fichas ","de provision generadas"," por la rutina de apropiacion ","de provision"}
aHlpEng := {"Defines the AVP ","appropriation type. ","Total will constitute"," the AVP in the ","fixed asset form. ","Installment will ","constitute AVP in the ","provision forms generated"," by the routine of"," provision appropriation."}
SetHelp(    "PFNC_TPAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data prevista para ","execuÁ„o da etapa"," do projeto."}
aHlpSpa := {"Fecha prevista para"," ejecucion de la ","etapa del proyecto."}
aHlpEng := {"Planned date for the ","execution of the ","project stage."}
SetHelp(    "PFNC_PRVEXC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
// Helps Tabela FND
//
aHlpPor := {" Filial do Sistema"}
aHlpSpa := {" Sucursal del Sistema"}
aHlpEng := {" System Branch"}
SetHelp(    "PFND_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Indica se o projeto ","est· bloqueado"}
aHlpSpa := {"Indica si el proyecto ","esta bloqueado"}
aHlpEng := {"Indicates whether ","project is blocked."}
SetHelp(    "PFND_MSBLQL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo do projeto do"," PMS ao qual a etapa do"," projeto de imobilizado"," est· vinculada"}
aHlpSpa := {"Codigo del proyecto ","del PMS al que la etapa"," del proyecto de inmovilizado ","esta vinculada"}
aHlpEng := {"PMS project code to ","which the stage of fixed"," assets project is linked."}
SetHelp(    "PFND_CODPMS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo do projeto de ","imobilizado ao qual a"," etapa pertence"}
aHlpSpa := {"Codigo del proyecto"," de inmovilizado al que"," la etapa pertenece"}
aHlpEng := {"Fixed assets project ","code to which this ","stage belongs to."}
SetHelp(    "PFND_CODPRJ", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo da EDT do ","projeto do PMS ao"," qual a etapa do o projeto"," de imobilizado"," est· vinculada  "}
aHlpSpa := {"Codigo de la EDT ","del proyecto de PMS"," al que la etapa del ","proyecto de inmovilizado"," esta vinculada    "}
aHlpEng := {"EDT code of the ","PMS project code to"," which the stage of ","fixed assets project is ","linked. "}
SetHelp(    "PFND_EDTPMS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Etapa do projeto"}
aHlpSpa := {"Etapa del proyecto"}
aHlpEng := {"Project stage"}
SetHelp(    "PFND_ETAPA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Revis„o do projeto de"," imobilizado ao qual ","a etapa pertence"}
aHlpSpa := {"Revision del proyecto"," de inmovilizado al que ","la etapa pertenece"}
aHlpEng := {"Fixed Assets Project ","review to which this ","stage belongs to."}
SetHelp(    "PFND_REVIS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Indica item da ","etapa ir· gerar ficha"," do ativo imobilizado"}
aHlpSpa := {"Indica item de la"," etapa generara ficha ","del activo fijo"}
aHlpEng := {"Indicates stage ","item that generates the"," fixed asset form"}
SetHelp(    "PFND_CTRATF", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"DescriÁ„o do item"," da etapa do projeto"}
aHlpSpa := {"Descripcion del ","item de la etapa"," del proyecto"}
aHlpEng := {"Item description ","of project stage"}
SetHelp(    "PFND_DSCITE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data na qual o ","item da etapa ","do projeto ","foi encerrado"}
aHlpSpa := {"Fecha en que el ","item etapa ","del proyecto"," se concluyo"}
aHlpEng := {"Data in which the"," project stage item was","closed."}
SetHelp(    "PFND_DTENCR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data de Inicio da Provis„o,"," essa data ser· a data de inicio"," do AVP, e a data de inicio da"," depreciaÁ„o da ficha do ","Imobilizado"}
aHlpSpa := {"Fecha de Inicio de la Disposicion,"," esa fecha sera la fecha de"," inicio del AVP, y la feha de ","inicio de la depreciacion de ","la ficha del Fijo"}
aHlpEng := {"Provision Initial date, this date"," will the AVP initial date and"," the the fixed asset initial"," date."}
SetHelp(    "PFND_DTPROV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Õndice para c·lculo de AVP ","do item da etapa do projeto."," Este Ìndice pode ","ser diferente ","do Ìndice geral do projeto."," Caso contr·rio ser·"," utilizado definido","do cabeÁalho do ","projeto."}
aHlpSpa := {"Indice para calculo de AVP"," del item de la etapa del"," proyecto. Este indice","puede ser diferente"," del indice general del ","proyecto. De lo ","contrario se utilizara ","definido del ","encabezado del proyecto."}
aHlpEng := {"Index for AVP calculation ","of project stage item. ","This index may be ","different of the project"," general index. Otherwise,"," the one defined ","in the project header"," is used."}
SetHelp(    "PFND_INDAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Item da etapa do projeto"}
aHlpSpa := {"Item de la etapa del proyecto"}
aHlpEng := {"Project stage description"}
SetHelp(    "PFND_ITEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"PerÌodo final do"," item etapa ","do projeto"}
aHlpSpa := {"Periodo final del"," item etapa"," del proyecto"}
aHlpEng := {"Final period of"," item stage"," description"}
SetHelp(    "PFND_PERFIM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"PerÌodo inicial do item da ","etapa do projeto"}
aHlpSpa := {"Periodo inicial del item de"," la etapa del proyecto"}
aHlpEng := {"Initial period of project ","stage item"}
SetHelp(    "PFND_PERINI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data prevista"," para execuÁ„o"," do item da etapa"," do projeto."}
aHlpSpa := {"Fecha prevista para ejecucion"," del item etapa del proyecto"}
aHlpEng := {"Estimated date for project ","stage item execution."}
SetHelp(    "PFND_PRVEXC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Sub-tipo de imobilizado"," do item da etapa ","do projeto"}
aHlpSpa := {"Sub-tipo de inmovilizado ","del item de la etapa ","del proyecto"}
aHlpEng := {"Sub-type of fixed assets"," of project stage item."}
SetHelp(    "PFND_SBTIPO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Indica o status da"," etapa ou do item da ","etapa do projeto"}
aHlpSpa := {"Indica el estatus de"," la etapa o del item de ","la etapa del proyecto"}
aHlpEng := {"Indicates the stage ","status or of the project"," stage item."}
SetHelp(    "PFND_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo de classificaÁ„o"," de imobilizado do item ","da etapa do projeto"}
aHlpSpa := {"Tipo de clasificacion"," de inmovilizado del item"," de la etapa del proyecto"}
aHlpEng := {"Type of fixed assets"," classification of project ","stage item."}
SetHelp(    "PFND_TIPO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor planejado do item"," da etapa do projeto ","na moeda especificada"," para controle"," do projeto."}
aHlpSpa := {"Valor planeado del item ","de la etapa del ","proyecto en la moneda ","especificada para ","control del proyecto."}
aHlpEng := {"Planned value of the"," project stage item in"," the currency specified ","for project"," control."}
SetHelp(    "PFND_VLRPLN", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Determina qual o tipo"," de apropriaÁ„o do AVP: ","Total ir· constituir"," o AVP na ficha do ","imobilizado. Parcela ir· ","contituir AVP nas fichas ","de provis„o geradas ","pela rotina de apropriaÁ„o"," de provis„o  "}
aHlpSpa := {"Determina el tipo de"," imputacion del AVP: El ","total constituira el ","AVP en la ficha del ","activo fijo. La cuota ","contituira el AVP en las"," fichas de provision ","generadas por la rutina de"," imputacion de ","provision."}
aHlpEng := {"Defines the AVP appropriation"," type. Total will ","constitute the AVP ","in the fixed asset"," form. Installment will ","constitute AVP in the ","provision forms generated"," by the routine of","provision appropriation."}
SetHelp(    "PFND_TPAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)


//
// Helps Tabela FNE
//   
aHlpPor := {"Filial do Sistema"}
aHlpSpa := {"Sucursal del Sistema"}
aHlpEng := {"System Branch"}
SetHelp(    "PFNE_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo do projeto"," de imobilizado"}
aHlpSpa := {"Codigo del proyecto ","de inmovilizado"}
aHlpEng := {"Fixed Assets Project"," Code"}
SetHelp(    "PFNE_CODPRJ", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"AVP planejado para ","o item da etapa na moeda ","especificada no ","controle do projeto"}
aHlpSpa := {"AVP planifiacdo para"," el item de la etapa en ","la moneda especificada ","en el control del proyecto"}
aHlpEng := {"Planned AVP for stage"," item in specified"," currency in project ","control."}
SetHelp(    "PFNE_AVPPLN", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"AVP realizado para o ","item da etapa na "," moeda especificada no"," controle do projeto"}
aHlpSpa := {"AVP planificado para ","el item de la etapa ","en la moneda especificada ","en el control ","del proyecto"}
aHlpEng := {"Planned AVP for stage"," item in specified"," currency in project"," control."}
SetHelp(    "PFNE_AVPRLZ", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Periodicidade do c·lculo ","de depreciaÁ„o em funÁ„o"," do par‚metro MV_CALCDEP,"," aonde 0=Mensal e ","1=Anual."}
aHlpSpa := {"Periodicidad del calculo"," de depreciacion en funcion ","del parametro MV_CALCDEP,"," donde 0=Mensual ","y 1=Anual."}
aHlpEng := {"Periodicity of depreciation"," calculation according"," to parameter MV_CALCDEP,"," where 0=Monthly"," e 1=Annual."}
SetHelp(    "PFNE_CALCDE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Calend·rio de depreciaÁ„o ","em funÁ„o do critÈrio de"," inÌcio de depreciaÁ„o ","definido que necessite de ","calend·rio, tal como ","exercÌcio completo ","e prÛximo trimestre.     "}
aHlpSpa := {"Calendario de depreciacion"," en funcion del criterio"," de inicio de depreciacion ","definido que necesite"," de calendario, tal ","como ejercicio completo"," y proximo trimestre. "}
aHlpEng := {"Depreciation calendar ","according to criterion"," of depreciation start if ","calendar is needed,"," such as full fiscal ","year  and next quarter."}
SetHelp(    "PFNE_CALDEP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo do Indice de ","depreciaÁ„o utilizado"," pelo mÈtodo de depreciaÁ„o"," Õndice de depreciaÁ„o "}
aHlpSpa := {"Codigo del Indice de"," depreciacion utilizado ","por el metodo de depreciacion ","Indice de depreciacion "}
aHlpEng := {"Depreciation index ","code used by the ","depreciation method"," depreciation index "}
SetHelp(    "PFNE_CODIND", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CritÈrio para inÌcio ","do c·lculo de  ","depreciaÁ„o "}
aHlpSpa := {"Criterio para inicio ","del calculo de ","depreciacion "}
aHlpEng := {"Criterion for the start ","of depreciation ","calculation"}
SetHelp(    "PFNE_CRIDEP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Entidade cont·bil de ","depreciaÁ„o acumulada"," do bem 01: conta ","cont·bil  "}
aHlpSpa := {"Ente contable de"," depreciacion acumulada del ","bien 01: cuenta ","contable "}
aHlpEng := {"Accounting entity ","of accrued depreciation ","of asset 01: Ledger ","account  "}
SetHelp(    "PFNE_ENT01A", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Entidade cont·bil do ","bem 01: conta cont·bil "}
aHlpSpa := {"Ente contable del bien ","01: cuenta contable "}
aHlpEng := {"Accounting entity of ","asset 01: Ledger account"}
SetHelp(    "PFNE_ENT01B", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Entidade cont·bil de ","despesa do bem 01: ","conta cont·bil  "}
aHlpSpa := {"Ente contable de gasto"," del bien 01: ","cuenta contable"}
aHlpEng := {"Accounting entity of ","asset 01: Ledger ","account "}
SetHelp(    "PFNE_ENT01D", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Entidade cont·bil de ","depreciaÁ„o acumulada ","do bem 02: centro de custo"}
aHlpSpa := {"Ente contable de ","depreciacion acumulada del"," bien 02: centro de costo"}
aHlpEng := {"Accounting entity ","of accrued depreciation ","of asset 02: Cost Center"}
SetHelp(    "PFNE_ENT02A", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Entidade cont·bil do"," bem 02: centro de custo "}
aHlpSpa := {"Ente contable del bien ","02: centro de costo "}
aHlpEng := {"Accounting entity of ","asset 02: Cost Center"}
SetHelp(    "PFNE_ENT02B", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Entidade ","cont·bil de ","despesa do bem 02: ","centro de custo"}
aHlpSpa := {"Ente contable del bien"," 02: centro de costo"}
aHlpEng := {"Accounting entity of ","asset 02: Cost Center"}
SetHelp(    "PFNE_ENT02D", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Entidade cont·bil de ","depreciaÁ„o acumulada do ","bem 03: item cont·bil   "}
aHlpSpa := {"Ente contable de"," depreciacion acumulada del ","bien 03: item contable "}
aHlpEng := {"Accounting entity ","of accrued depreciation of ","asset 03: Accounting item.  "}
SetHelp(    "PFNE_ENT03A", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Entidade cont·bil do ","bem 03: item cont·bil "}
aHlpSpa := {"Ente contable del bien"," 03: item contable"}
aHlpEng := {"Accounting entity of ","asset 03: Accounting item. "}
SetHelp(    "PFNE_ENT03B", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Entidade cont·bil de ","despesa do bem 03: ","item cont·bil"}
aHlpSpa := {"Ente contable de gasto ","del bien 03: Item"," contable"}
aHlpEng := {"Accounting entity of ","asset 03: Accounting"," item."}
SetHelp(    "PFNE_ENT03D", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Entidade cont·bil de ","depreciaÁ„o acumulada"," do bem 04: ","classe de valor "}
aHlpSpa := {"Ente contable de ","depreciacion acumulada"," del bien 04: ","clase de valor "}
aHlpEng := {"Accounting entity ","of accrued depreciation"," of asset 04: ","Value class. "}
SetHelp(    "PFNE_ENT04A", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Entidade cont·bil do ","bem 04: classe de valor  "}
aHlpSpa := {"Ente contable del bien ","04: clase de valor "}
aHlpEng := {"Accounting entity of"," asset 04: Value class. "}
SetHelp(    "PFNE_ENT04B", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Entidade cont·bil de ","despesa do bem 04",": classe de valor "}
aHlpSpa := {"Ente contable de gasto ","del bien 04",": clase de valor"}
aHlpEng := {"Accounting entity of"," asset 04",": Value class. "}
SetHelp(    "PFNE_ENT04D", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Etapa do projeto de ","imobilizado a qual as"," configuraÁıes est„o vinculadas. "}
aHlpSpa := {"Etapa del proyecto de"," inmovilizado al que las ","configuraciones estan vinculadas."}
aHlpEng := {"Fixed Assets Project ","stage to which these configurations"," are linked to. "}
SetHelp(    "PFNE_ETAPA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Grupo de bens"}
aHlpSpa := {"Grupo de bienes"}
aHlpEng := {"Group of Assets"}
SetHelp(    "PFNE_GRPBEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Item da etapa do ","projeto ao qual as"," configuraÁıes est„o","vinculadas"}
aHlpSpa := {"Item de la etapa"," del proyecto al que ","las configuraciones"," estan vinculadas"}
aHlpEng := {"Project stage item ","to which these ","configurations are ","linked to."}
SetHelp(    "PFNE_ITEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Item da etapa do ","projeto ao qual as ","configuraÁıes est„o"," vinculadas"}
aHlpSpa := {"Item de la etapa ","del proyecto al que ","las configuraciones"," estan vinculadas  "}
aHlpEng := {"Project stage ","item to which these ","configurations are ","linked to. "}
SetHelp(    "PFNE_ITETP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Item da etapa do ","projeto ao qual ","as configuraÁıes ","est„o vinculadas  "}
aHlpSpa := {"Item de la etapa ","del proyecto al","cual las configuraciones"," estan vinculadas"}
aHlpEng := {"Project stage ","item to which these ","configurations are ","linked to."}
SetHelp(    "PFNE_ITVIRT", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Linha de configuraÁ„o cont·bil"}
aHlpSpa := {"Linea de configuracion contable"}
aHlpEng := {"Line of accounting configuration."}
SetHelp(    "PFNE_LINHA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Moeda de referÍncia"," para o preenchimento dos"," campos de Valor ","M·ximo de depreciaÁ„o"," e Valor de Salvamento."}
aHlpSpa := {"Moneda de referencia ","para el rellenado de los ","campos de Valor"," Maximo de depreciacion"," y Valor de Grabacion."}
aHlpEng := {"Reference currency to ","fill out the fields ","Maximum Value of"," depreciation and ","Saving Value."}
SetHelp(    "PFNE_MOEDRF", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"PerÌodo em meses ou ","anos para c·lculo de","depreciaÁ„o em funÁ„o"," do par‚metro MV_CALCDEP ,"," aonde 0=Mensal e 1=Anual. "}
aHlpSpa := {"Periodo en meses o"," anos para calculo de"," depreciacion en funcion"," del parametro MV_CALCDEP ,"," donde 0=Mensual y 1=Anual."}
aHlpEng := {"Period in months or"," years for depreciation"," calculation according ","to parameter MV_CALCDEP ,"," where 0=Monthly e 1=Annual.  "}
SetHelp(    "PFNE_PERDEP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"ProduÁ„o total estimada"," para o item de ativo, ","quando o mÈtodo de depreciaÁ„o ","envolver apontamentos"," de horas trabalhadas,","unidades produzidas ou","apontamentos de produÁ„o."}
aHlpSpa := {"Produccion total estimada"," para el item de activo,"," cuando el metodo de ","depreciacion envuelve ","apuntamientos de horas","trabajadas, unidades producidas o ","apuntamientos de produccion."}
aHlpEng := {"Estimated total production"," for asset item when"," depreciation method"," involves working hours ","annotation, produced units"," or production annotations."}
SetHelp(    "PFNE_PRDEST", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Revis„o do projeto ","de imobilizado ao qual as ","informaÁıes est„o"," vinculadas  "}
aHlpSpa := {"Revision del proyecto ","de inmovilizado al que ","las informaciones"," estan vinculadas  "}
aHlpEng := {"Fixed Assets Project"," review to which this ","information is"," linked to."}
SetHelp(    "PFNE_REVIS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Taxa anual de depreciaÁ„o"}
aHlpSpa := {"Tasa anual de depreciacion"}
aHlpEng := {"Depreciation annual rate"}
SetHelp(    "PFNE_TAXA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo da classificaÁ„o do"," item de ativo a ","ser gerado"}
aHlpSpa := {"Tipo de la clasificacion ","del item de activo que ","se generara"}
aHlpEng := {"Item classification type"," to be generated."}
SetHelp(    "PFNE_TPATF", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo da classificaÁ„o cont·bil"}
aHlpSpa := {"Tipo de la clasificacion contable"}
aHlpEng := {"Accounting classification type"}
SetHelp(    "PFNE_TPCLAS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"MÈtodo de depreciaÁ„o ","do item de ativo a ","ser gerado.     "}
aHlpSpa := {"Metodo de depreciacion"," del item de activo"," que se generara. "}
aHlpEng := {"Depreciation method of"," the asset type to be"," generated.  "}
SetHelp(    "PFNE_TPDEPR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo de saldo para ","geraÁ„o do item ","de ativo"}
aHlpSpa := {"Tipo de saldo para"," generacion del ","item de activo  "}
aHlpEng := {"Balance type to ","generate the asset"," item "}
SetHelp(    "PFNE_TPSALD", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor m·ximo de depreciaÁ„o,"," informado em funÁ„o da seleÁ„o ","do mÈtodo de depreciaÁ„o:"," depreciaÁ„o linear com ","valor m·ximo de","depreciaÁ„o."}
aHlpSpa := {"Valor maximo de depreciacion,"," informado en funcion de la ","seleccion del metodo de depreciacion:"," depreciacion linear"," con valor maximo ","de depreciacion."}
aHlpEng := {"Maximum value of depreciation ","indicated according to selection ","of depreciation method: ","linear depreciation ","with maximum value ","of depreciation.	"}
SetHelp(    "PFNE_VLMXDP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Valor realizado do item ","da etapa do projeto na"," moeda especificada para ","controle do projeto."}
aHlpSpa := {" Valor realizado del item ","de la etapa del proyecto ","en la moneda especificada ","para control ","del proyecto."}
aHlpEng := {" Received value of the ","project stage item in the ","currency specified for ","project control."}
SetHelp(    "PFNE_VLRRLZ", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor de salvamento do bem,","  informado em funÁ„o da ","seleÁ„o do mÈtodo ","de depreciaÁ„o:"," reduÁ„o de saldos.  "}
aHlpSpa := {"Valor de grabacion del bien,"," informado en funcion de"," la seleccion del"," metodo de depreciacion:"," reduccion de saldos. "}
aHlpEng := {"Asset saving value indicated"," according to selection ","of depreciation method:"," balance reduction.","  "}
SetHelp(    "PFNE_VLSALV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor Original ","do Ativo Fixo"}
aHlpSpa := {"Valor Original"," del Activo Fijo"}
aHlpEng := {"Original value"," of Fixed Asset"}
SetHelp(    "PFNE_VORIG", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"DepreciaÁ„o Acumulada do Ativo"}
aHlpSpa := {"Depreciacion Acumulada del Activo"}
aHlpEng := {"Asset Accrued Depreciation"}
SetHelp(    "PFNE_VRDACM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data de inÌcio da depreciaÁ„o.","Indica a partir de qual ","data o bem dever· ","sofrer depreciaÁ„o."}
aHlpSpa := {"Fecha de inicio de"," la depreciacion."," Indica a partir de ","que fecha el bien ","debera sufrir ","depreciacion."}
aHlpEng := {"Depreciation start date. ","Indicates from which date the ","asset must be ","depreciated."}
SetHelp(    "PFNE_DINDEP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo do usu·rio que informou"," o AVP planejado,caso o ","AVP planejado seja calculado"," pelo sistema, esse"," campo ficar· em branco"}
aHlpSpa := {"Codigo del usuario que informo"," el AVP planeado. Si el ","calcula el AVP planeado,"," ese campo se quedara"," en blanco. "}
aHlpEng := {"Code of user that entered the"," AVP planned, if the AVP"," planned is calculated by ","the system, this field ","will be blank."}
SetHelp(    "PFNE_USRAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//FNJ 

aHlpPor := {" CÛdigo Base do Ativo ","de ExecuÁ„o para contabilizacao ","da baixa da provis„o"}
aHlpSpa := {" Codigo Base del Activo"," de Ejecucion para contabilizacion","de la baja de la provision"}
aHlpEng := {" Base Code of the Execution"," Asset for the accounting ","of provision write-off" }
SetHelp(    "PFNJ_CBAEXE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" CÛdigo do Projeto"," do Imobilizado"}
aHlpSpa := {" Codigo del Proyecto"," del Fijo"}
aHlpEng := {" Project Code of ","the Fixed"}
SetHelp(    "PFNJ_CODPRJ", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Data de Contabilizacao ","do movimento"}
aHlpSpa := {" Fecha de Contabilizacion"," del movimiento"}
aHlpEng := {" Date of transaction"," accouting"}
SetHelp(    "PFNJ_DTCONT", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Etapa do projeto"}
aHlpSpa := {" Etapa del proyecto."}
aHlpEng := {" Project Stage	"}
SetHelp(    "PFNJ_ETAPA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Filial do Sistema"}
aHlpSpa := {" Sucursal del Sistema"}
aHlpEng := {" System Branch	"}
SetHelp(    "PFNJ_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Item da Etapa do"," projeto"}
aHlpSpa := {" Item de la Etapa"," del proyecto"}
aHlpEng := {" Project Stage ","Item "}
SetHelp(    "PFNJ_ITEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Item do Ativo de ExecuÁ„o"," para contabilizacao"," da baixa da provis„o"}
aHlpSpa := {" Item del Activo de ","Ejecucion para contabilizacion","de la baja de la provision"}
aHlpEng := {" Item of the Execution"," Asset for accounting of the ","privision write-off	"}
SetHelp(    "PFNJ_ITEXE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Item do Relacionamento"}
aHlpSpa := {" Item de la Relacion "}
aHlpEng := {" Relationship Item	"}
SetHelp(    "PFNJ_ITRELA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Linha configuracao cont·bil"," do item da etapa"}
aHlpSpa := {" Linea configuracion contable"," del item de la etapa"}
aHlpEng := {" Line of accounting ","configuration of ","the stage item	"}
SetHelp(    "PFNJ_LINHA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Revisao do projeto"}
aHlpSpa := {" Revision del proyecto."}
aHlpEng := {" Project Review	"}
SetHelp(    "PFNJ_REVIS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Tipo de saldo do Ativo de"," ExecuÁ„o para contabilizacao"," da baixa da provis„o"}
aHlpSpa := {" Tipo de saldo del Activo"," de Ejecucion para contabilizacion ","de la baja de la provision"}
aHlpEng := {" Balance type of the ","Execution Asset for accounting"," of the provision write-off	"}
SetHelp(    "PFNJ_SLDEXE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Tipo de Saldo do"," Item da Etapa"}
aHlpSpa := {" Tipo de Saldo del"," Item de la Etapa"}
aHlpEng := {" Balance type of ","the Stage Item	"}
SetHelp(    "PFNJ_SLDPRJ", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Tipo do Ativo de ExecuÁ„o"," para contabilizacao da"," baixa da provis„o"}
aHlpSpa := {" Tipo del Activo de Ejecucion"," para contabilizacion de la ","baja de la provision"}
aHlpEng := {" Type of Execution Asset for"," accounting of the provision"," write-off	"}
SetHelp(    "PFNJ_TAFEXE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Tipo de ativo da linha ","de configuraÁ„o contabil ","do Item da Etapa"}
aHlpSpa := {" Tipo de activo de la ","linea de configuracion contable"," del item de la Etapa"}
aHlpEng := {" Asset type of line of ","accounting configuration"," of the Stage Item	"}
SetHelp(    "PFNJ_TAFPRJ", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Valor do Ativo de ExecuÁ„o ","para contabilizacao da"," baixa da provis„o"}
aHlpSpa := {" Valor del Activo de Ejecucion"," para contabilizacion de ","la baja de la provision"}
aHlpEng := {" Value of the Execution Asset"," for accounting of the ","provision write-off	"}
SetHelp(    "PFNJ_VLREXE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//FNF
aHlpPor := {" Filial do Sistema"}
aHlpSpa := {" Sucursal del Sistema"}
aHlpEng := {" System Branch"}
SetHelp(    "PFNF_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
																																													
aHlpPor := {" Valor acumulado de ","apropriaÁıes do AVP   "}
aHlpSpa := {" Valor acumulado de ","apropiaciones del AVP."}
aHlpEng := {" Accumulated value"," of AVP appropriations	"}
SetHelp(    "PFNF_ACMAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Valor presente do bem ","na constituiÁ„o ou ","apropriaÁ„o do AVP       "}
aHlpSpa := {" Valor presente del bien"," en la constitucion"," o apropiacion del AVP. "}
aHlpEng := {" Present value of asset"," in AVP constitution"," or appropriation			"}
SetHelp(    "PFNF_AVPVLP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Base de c·lculo do movimento   "}
aHlpSpa := {" Base de calculo del movimiento."}
aHlpEng := {" Turnover calculation base		"}
SetHelp(    "PFNF_BASE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" CÛdigo base da ficha de ","ativo aos quais os movimentos"," de AVP est„o vinculados           "}
aHlpSpa := {" Codigo base de la ficha"," de activo a los que se vinculan"," los movimientos de AVP.         "}
aHlpEng := {" Base code of asset file"," to which AVP transactions are"," linked										"}
SetHelp(    "PFNF_CBASE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Data do movimento de ","AVP da ficha de imobilizado         "}
aHlpSpa := {" Fecha del movimiento ","de AVP de la ficha de inmovilizado. "}
aHlpEng := {" Fixed asset file AVP ","transaction date							"}
SetHelp(    "PFNF_DTAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Data de ContabilizaÁ„o"," do movimento de AVP   "}
aHlpSpa := {" Fecha de contabilidad"," del movimiento de AVP.	"}
aHlpEng := {" AVP transaction ","accounting date					"}
SetHelp(    "PFNF_DTCONT", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Data prevista de"," execuÁ„o do imobilizado."}
aHlpSpa := {" Fecha prevista de"," ejecucion del activo fijo."}
aHlpEng := {" Planned execution ","date of the asset."}
SetHelp(    "PFNF_DTEXEC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Entidade cont·bil de nÌvel 01,"," comumente usada"," para a Conta Cont·bil "}
aHlpSpa := {" Ente contable de nivel 01,"," en general usado para ","la Cuenta Contable. "}
aHlpEng := {" Level 01 accounting entity,"," commonly used for the"," Ledger Account		"}
SetHelp(    "PFNF_ENT01", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Entidade contabil de nÌvel 02,"," comumente usada para ","o Centro de Custo"}
aHlpSpa := {" Ente contable de nivel 02, en"," general usado para el"," Centro de Costo. "}
aHlpEng := {" Level 02 accounting entity, ","commonly used for the ","Cost Center			"}
SetHelp(    "PFNF_ENT02", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Entidade cont·bil de nÌvel 03,"," comunente usada para"," o Item da Conta Cont·bil	"}
aHlpSpa := {" Ente contable de nivel 03,"," en general usado para el"," Item de la Cuenta Contable."}
aHlpEng := {" Level 03 accounting entity,"," commonly used for the ","Ledger Account Item				"}
SetHelp(    "PFNF_ENT03", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Entidade contabil de nÌvel 04,"," comumente usada para ","a Classe de Valor da Conta  "}
aHlpSpa := {" Ente contable de nivel 04,"," en general usado para la ","Clase de Valor de la Cuenta."}
aHlpEng := {" Level 04 accounting entity, ","commonly used for the"," Value Class of the Account	"}
SetHelp(    "PFNF_ENT04", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Identificador do movimento"," do imobilizado (valor do"," N4_IDMOV quando for o caso) 			"}
aHlpSpa := {" Identificador del movimiento"," del inmovilizado (valor"," del N4_IDMOV, cuando es el caso). 	"}
aHlpEng := {" Identifier of the fixed asset"," transaction (N4_IDMOV value ","when applicable). 	"}
SetHelp(    "PFNF_IDMVAF", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Identificador do processo ","criador do movimento de ","constituiÁ„o de AVP que estava"," ativo no momento da geraÁ„o do ","movimento periÛdico de ajuste"," a valor presente das fichas de ","imobilizado. Esta informaÁ„o ","ser· utilizada para ","cancelamentos de movimento AVP.           "}          
aHlpSpa := {" Identificador del proceso ","creador del movimiento de"," constitucion de AVP, que estaba"," activo en el momento de generar"," el movimiento periodico de ","ajuste a valor presente de las ","fichas de inmovilizado. Esta"," informacion se utilizara ","para anulaciones de movimiento AVP. "}          
aHlpEng := {" Identifier of AVP constitution"," transaction creating ","process active when the fixed ","asset periodic present value ","adjustment transaction was generated."," This information is used ","for AVP transaction cancelations."}
SetHelp(    "PFNF_IDPRCP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Identificador do processo"," periÛdico de ajuste a valor ","presente das fichas"," de imobilizado.     "}
aHlpSpa := {" Identificador del proceso"," periodico de ajuste a valor","presente de las fichas"," de inmovilizado. "}
aHlpEng := {" Identifier of the fixed ","asset periodic present value"," adjustment process								"}
SetHelp(    "PFNF_IDPROC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Õndice financeiro utilizado"," para c·lculo do AVP da"," ficha de imobilizado       "}
aHlpSpa := {" Indice financiero utilizado"," para calcular el AVP de"," la ficha de inmovilizado.	"}
aHlpEng := {" Financial index utilized to"," calculate the fixed ","asset AVP								"}
SetHelp(    "PFNF_INDAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Item da ficha de ativo aos"," quais os movimentos de"," AVP est„o vinculados  "}
aHlpSpa := {" Item de la ficha de activo"," a los que se vinculan"," los movimientos de AVP."}
aHlpEng := {" Asset file item to which ","AVP transactions are"," linked							"}
SetHelp(    "PFNF_ITEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Moeda do movimento AVP     "}
aHlpSpa := {" Moneda del movimiento AVP. "}
aHlpEng := {" AVP transaction currency		"}
SetHelp(    "PFNF_MOEDA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Indica se a configuraÁ„o"," est· bloqueada  "}
aHlpSpa := {" Indica si la configuracion"," esta bloqueada. "}
aHlpEng := {" Indicates whether the ","configuration is blocked"}
SetHelp(    "PFNF_MSBLQL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Periodicidade de atualizaÁ„","o do Ìndice         "}
aHlpSpa := {" Periodicidad de actualizacion"," del indice.      "}
aHlpEng := {" Index update periodicity								"}
SetHelp(    "PFNF_PERIND", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Controle interno do sistema"," para determinar qual ","o cÛdigo da revis„o"," ativa do cadastro de AVP"," da ficha de ativo.      "}
aHlpSpa := {" Control interno del sistema"," para determinar el ","codigo de la revision"," activa del archivo de AVP ","de la ficha de activo. "}
aHlpEng := {" Internal control of system"," to determine the active"," revision code of"," the asset file AVP register"}
SetHelp(    "PFNF_REVIS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Sequencia do item da ","ficha de ativo aos"," quais os movimentos de AVP"," est„o vinculados    "}
aHlpSpa := {" Sequencia del item de ","la ficha de activo"," a los que se vinculan los"," movimientos de AVP. "}
aHlpEng := {" Asset file item ","sequence to which AVP"," transactions are linked"}
SetHelp(    "PFNF_SEQ", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Sequencia dos movimentos"," de AVP da ficha de ","imobilizado       		"}
aHlpSpa := {" Secuencia de los movimientos"," de AVP de la ficha ","de inmovilizado.  "}
aHlpEng := {" Fixed asset file AVP ","transaction sequence									"}
SetHelp(    "PFNF_SEQAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Status da configuraÁ„o de AVP      "}
aHlpSpa := {" Estatus de la configuracion de AVP."}
aHlpEng := {" AVP configuration status				"}
SetHelp(    "PFNF_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Taxa do Ìndice de acordo ","com a periodicidade do mesmo"}
aHlpSpa := {" Tasa del indice, de acuerdo"," con su periodicidad.     "}
aHlpEng := {" Index rate according to its"," periodicity					"}
SetHelp(    "PFNF_TAXA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Tipo do item da ficha ","de ativo aos quais os"," movimentos de AVP ","est„o vinculados         "}
aHlpSpa := {" Tipo del item de la "," ficha de activo a los ","que se vinculan los ","movimientos de AVP.     "}
aHlpEng := {" Type of asset file item ","to which the AVP ","transactions are linked"}
SetHelp(    "PFNF_TIPO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Tipo dos movimentos ","de AVP da ficha de imobilizado		"}
aHlpSpa := {" Tipo de movimientos ","de AVP de la ficha de inmovilizado."}
aHlpEng := {" Type of fixed asset ","file AVP transaction					"}
SetHelp(    "PFNF_TPMOV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Tipo de saldo do item da ","ficha de ativo aos quais ","os movimentos de AVP"," est„o vinculados    "}
aHlpSpa := {" Tipo de saldo del item de"," la ficha de activo a los"," que se vinculan los"," movimientos de AVP. "}
aHlpEng := {" Type of asset file item"," balance to which the AVP"," transactions are"," linked							"}
SetHelp(    "PFNF_TPSALD", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Valor do movimento    "}
aHlpSpa := {" Valor del movimiento. "}
aHlpEng := {" Value of transaction	"}
SetHelp(    "PFNF_VALOR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
// Tabela SN1 - CAMPOS AVP
//
aHlpPor := {" ClassificaÁ„o patrimonial ","da ficha de imobilizado "}
aHlpSpa := {" Clasificacion patrimonial ","de la ficha de fijo"}
aHlpEng := {" Equity classification of ","the fixed asset form"}
SetHelp(    "PN1_PATRIM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {'Poder· ser feita associaÁ„o de um bem a','um determinado projeto, afins de se ','obter informaÁˆes referentes ao ','projeto.	'}
aHlpSpa := {'Se puede asociar un bien a un ','determinado proyecto, a fin de obtener','informaciones referentes al proyecto.'}
aHlpEng := {'It is possible to make an association ','between an asset and a specific ','project,in order to obtain information','referringto the project.'}      
SetHelp(    "PN1_PROJETO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)


aHlpPor := {" CÛdigo da revis„o do projeto ao ","qual a ficha de imobilizado","est· vinculada  "}
aHlpSpa := {" Codigo de la revision del proyecto"," al cual esta vinculada la ","ficha de activo fijo. "}
aHlpEng := {" Code of project review ","with which fixed asset form ","is associated."}
SetHelp(    "PN1_PROJREV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo da etapa do projeto ao qual"," a ficha de imobilizado ","est· vinculada  "}
aHlpSpa := {"Codigo de la ","etapa del proyecto al"," cual esta vinculada la"," ficha de activo fijo. "}
aHlpEng := {"Project stage code to which the ","fixed assets record is bound.  "}
SetHelp(    "PN1_PROJETP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo do item da"," etapa do projeto a qual"," a ficha de imobilizado"," est· vinculada"}
aHlpSpa := {"Codigo del item de"," la etapa del proyecto"," al cual esta vinculada"," la ficha de activo fijo."}
aHlpEng := {"Project stage item"," code to which the fixed ","assets record is"," bound."}
SetHelp(    "PN1_PROJITE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Data Inicio de ExecuÁ„o"," do AVP imobilizado.   	"}
aHlpSpa := {" Fecha Inicio de Ejecucion ","del AVP fijo.    "}
aHlpEng := {" Fixed AVP run initial"," date.      "}
SetHelp(    "PN1_INIAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Data Prevista de ","ExecuÁ„o do imobilizado  			"}
aHlpSpa := {" Fecha Prevista de"," Ejecucion del inmovilizado   "}
aHlpEng := {" Estimated date for"," fixed assets.      "}
SetHelp(    "PN1_DTAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" CÛdigo do Ìndice utilizado"," para o processo de"," AVP do imobilizado."}
aHlpSpa := {" Codigo del indice utilizado","para el proceso de AVP"," de inmovilizado.      "}
aHlpEng := {" Code of the index used for ","AVP process of ","fixed assets.   "}
SetHelp(    "PN1_INDAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Taxa do Ìndice de acordo"," com a periodicidade"," do mesmo    "}
aHlpSpa := {" Tasa del indice de acuerdo"," con la periodicidad del mismo   "}
aHlpEng := {" Index rate according to"," its periodicity"}
SetHelp(    "PN1_TAXAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Determina qual o tipo de apropriaÁ„o do","AVP: Total ir· constituir"," o AVP na ","ficha do imobilizado."," Parcela ir· ","constituir AVP nas fichas de provis„o ","geradas pela rotina de apropriaÁ„o de ","provis„o."}
aHlpSpa := {"Determina que tipo de apropiacion de ","AVP:El Total constituira el ","AVP en la ficha del fijoLa cuota"," se constituira AVP en las ","fichas de provision ","generadas por la rutina"," de apropiacion de provision"}
aHlpEng := {"Defines the AVP appropriation type."," Total will constitute the AVP"," in the fixed asset form and ","installment will constitute ","AVP in the provision ","generated by the routine"," of provision appropriation. "}
SetHelp(    "PN1_TPAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo da Margem Gerencial a ser ","aplicada ao imobilizado"}
aHlpSpa := {"Codigo de la Margen Gerencial que se ","aplica al inmovilizado"}
aHlpEng := {"Code of Management Margin to be applied","to fixed asset"}
SetHelp(    "PN1_MARGEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Revis„o do cadastro do cÛdigo da Margem","Gerencial a ser aplicada ao imobilizado."}
aHlpSpa := {"Revision del registro del codigo de la ","Margen Gerencial que se aplicara al ","inmovilizado."}
aHlpEng := {"Review of code record of code of ","Management Margin to be applied to ","fixed asset"}
SetHelp(    "PN1_REVMRG", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo do controle de provis„o ao qual ","o imobilizado est· relacionado como bem"," de execuÁ„o"}
aHlpSpa := {"CÛdigo del control de provision al cual","el inmovilizado est· relacionado con el"," bien de ejecuciÛn."}
aHlpEng := {"Code of provision control to which the ","fixed asset is relates as execution ","asset."}
SetHelp(    "PN1_PROVIS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)


//
//FNP - Processoamento de apropriacao de AVP
//
aHlpPor := {" Filial do Sistema"}
aHlpSpa := {" Sucursal del Sistema"}
aHlpEng := {" System Branch"}
SetHelp(    "PFNP_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
																																								
aHlpPor := {" Data do processamento"," de apropriacao de ","AVP de imobilizado"}														
aHlpSpa := {" Fecha del procesamiento"," de apropiacion de"," AVP del fijo"}
aHlpEng := {" Date of the appropriation"," process of fixed ","asset AVP."}
SetHelp(    "PFNP_DTPROC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Identificador do processo ","periÛdico de  ajuste a valor"," presente das fichas de ","imobilizado.    "}							
aHlpSpa := {" Identificador del proceso"," periodico de ajuste a valor ","presente de las fichas"," de inmovilizado. "}
aHlpEng := {" Identifier of the periodic ","process of present value"," adjustment of fixed"," asset forms. "}
SetHelp(    "PFNP_IDPROC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Status do processo ","de apropriacao de AVP      "}																    
aHlpSpa := {" Estatus del proceso ","de apropiacion de AVP"}  
aHlpEng := {" Status of AVP appropriation"," process. "}
SetHelp(    "PFNP_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Log de AlteraÁ„o     "}																
aHlpSpa := {" Log de modificacion 	"}
aHlpEng := {" Log of Change  "}
SetHelp(    "PFNP_USERGA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Log de Inclus„o  "}																
aHlpSpa := {" Log de inclusion "}
aHlpEng := {" Inclusion Log"}
SetHelp(    "PFNP_USERGI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//SN3
aHlpPor := {" Codigo do indice de depr." }
aHlpSpa := {" Codigo del indice de depr. "}
aHlpEng := {" Depreciation Index code  "}
SetHelp(    "PN3_CODIND", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Indica se o ativo"," È classificado"," como um ativo de Custo/Provis„o" }
aHlpSpa := {"Indica si el activo"," se clasifica"," como un activo de Costo/Provision."}
aHlpEng := {"Indicates if the"," asset is classified"," as a Cost/Provision asset "}
SetHelp(    "PN3_ATFCPR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//FNG
aHlpPor := {"Indica se o ativo È ","classificado como um ativo ","de Custo/Provis„o " }
aHlpSpa := {"Indica si el activo se"," clasifica como un activo"," de Costo/Provision."}
aHlpEng := {"Indicates if the asset"," is classified as a ","Cost/Provision asset"}
SetHelp(    "PFNG_ATFCPR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//ATFA005
aHlpPor := {" Filial do Sistema"}
aHlpSpa := {" Sucursal del Sistema"}
aHlpEng := {" System Branch"}
SetHelp(    "PFNI_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
																																								
aHlpPor := {" CÛdigo do Ìndice ","de c·lculo de depreciaÁ„o"," / amortizaÁ„o			"}
aHlpSpa := {" Codigo del indice de ","calculo de depreciacion ","/ amortizacion."}
aHlpEng := {" Calculation Index of ","Depreciation/","Amortization code"}
SetHelp(    "PFNI_CODIND", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" DescriÁ„o do Ìndice ","de c·lculo			"}
aHlpSpa := {" Descripcion del ","indice de calculo."}
aHlpEng := {" Calculation Index"," description	"}
SetHelp(    "PFNI_DSCIND", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Permite o bloqueio do Ìndice,"," impossibilitando sua amarraÁ„o ","a fichas de ativo e ","sua utilizaÁ„o em c·lculos"," de depreciaÁ„o e ","amortizaÁ„o."}    
aHlpSpa := {" Permite el bloqueo del indice,"," impidiendo su vinculo a las"," fichas de activo y su ","utilizacion en calculos de"," depreciacion y ","amortizacion."}    
aHlpEng := {" Allows index block, making its"," tiding to asset records and ","its use in depreciation/","amortization calculation ","not possible."}
SetHelp(    "PFNI_MSBLQL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Periodicidade de ","atualizaÁ„o do"," Ìndice "}
aHlpSpa := {" Periodicidad de ","actualizacion del ","indice.	"}
aHlpEng := {" Periodicity of ","index update "}
SetHelp(    "PFNI_PERIOD", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo do Indice para o Calculo da","Depreciacao","1 ñ Informado: O usuario ira informar","manualmente o indice de depreciacao ","2 - Calculado: O sistema ira calcular o "," indice a partir das curvas de demandas"," cadastradas pelo usuario" }
aHlpSpa := {"Tipo del indice para calcular", "la Depreciacion.","1 - Informado: El usuario informara", "manualmente el indice de depreciacion. ","2 - Calculado: El sistema calculara"," el indice a  partir de las"," curvas de demandas que el usuario"," registro."}
aHlpEng := {"Index Type to calculate de Depreciation","1 - Informed: user manually informs the","depreciation index","2 - Calculated: user calculates index ","based on the demand curves"," registered by user"}
SetHelp(    "PFNI_TIPO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
aHlpPor := {"Revis„o do Indice de ","depreciaÁ„o. Utilizado para"," identificar alteraÁıes"," do cadastro de Ìndice"," de depreciaÁ„o" }
aHlpSpa := {"Revision del Indice de"," depreciacion. Utilizado"," para identificar ","modificaciones ","del archivo de ","indice de depreciacion"}
aHlpEng := {"Depreciation Index Review"," Used to identify changes ","of depreciation"," index file"}
SetHelp(    "PFNI_REVIS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Inicio da Curva de"," Demanda para Ìndices"," do tipo"," Calculado" }
aHlpSpa := {"Inicio de la Curva"," de Demanda para"," indices del"," tipo Calculado"}
aHlpEng := {"Start of Demand"," Curve for indexes"," of calculated"," type"}
SetHelp(    "PFNI_CURVIN", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Final da Curva de ","Demanda para Ìndices ","do tipo Calculado" }
aHlpSpa := {"Final de la Curva ","de Demanda para"," indices del"," tipo Calculado"}
aHlpEng := {"End of Demand Curve ","for indexes of ","calculated type"}
SetHelp(    "PFNI_CURVFI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data de revis„o"," da curva de ","demanda" }
aHlpSpa := {"Fecha de revision"," de la curva ","de demanda"}
aHlpEng := {"Review date of"," demand curve "}
SetHelp(    "PFNI_DTREV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Status do ","Indice de ","DepreciaÁ„o" }
aHlpSpa := {"Estatus del"," Indice de ","Depreciacion"}
aHlpEng := {"Depreciation"," Index Status"}
SetHelp(    "PFNI_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)






//ATFA006
aHlpPor := {" Filial do Sistema"}
aHlpSpa := {" Sucursal del Sistema"}
aHlpEng := {" System Branch"}
SetHelp(    "PFNT_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
																																								
aHlpPor := {" CÛdigo do Ìndice"," de c·lculo de ","depreciaÁ„o"," / amortizaÁ„o			"}
aHlpSpa := {" Codigo del indice"," de calculo de depreciacion ","/ amortizacion."}
aHlpEng := {" Calculation Index"," of Depreciation/Amortization"," code"}
SetHelp(    "PFNT_CODIND", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Data da taxa do ","Ìndice de c·lculo"," de depreciaÁ„o /"," amortizaÁ„o				"}
aHlpSpa := {" Fecha de la tasa"," del indice de calculo"," de depreciacion /"," amortizacion."}
aHlpEng := {" Calculation Index ","of Depreciation/Amortization ","rate date."}
SetHelp(    "PFNT_DATA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Data de Validade"," final da Taxa       "}
aHlpSpa := {" Fecha de Validez ","final de la Tasa "}
aHlpEng := {" Date AWB final ","validity.    	"}
SetHelp(    "PFNT_DTVLDF", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Permite o bloqueio da"," taxa do Ìndice, impossibilitando"," sua utilizaÁ„o ","em c·lculos de ","depreciaÁ„o e amortizaÁ„o.  "}
aHlpSpa := {" Permite el bloqueo de ","la tasa del indice, impidiendo"," su utilizacion en"," calculos de depreciacion"," y amortizacion. "}
aHlpEng := {" Allows the index rate ","block, making its use not ","possible in depreciation/","amortization ","calculation. "}
SetHelp(    "PFNT_MSBLQL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Controle interno ","do sistema para determinar"," qual o cÛdigo da ","revis„o ativa da taxa.	"}
aHlpSpa := {" Control interno del"," sistema para determinar ","el codigo de la revision"," activa de la tasa."}
aHlpEng := {" Internal control of"," the system to determine"," the code of rate active"," review."}
SetHelp(    "PFNT_REVIS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Status da taxa"," perante aos controles"," do sistema			"}
aHlpSpa := {" Estatus de la"," tasa frente a ","los controles del ","sistema."}
aHlpEng := {" Rate status ","before the system"," controls"}
SetHelp(    "PFNT_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Taxa do Ìndice"," de acordo com a ","periodicidade do mesmo	"}
aHlpSpa := {" Tasa del indice ","de acuerdo con su","periodicidad."}
aHlpEng := {" Index rate ","according to its"," periodicity"}
SetHelp(    "PFNT_TAXA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Determina o tipo da taxa,"," para permitir o controle"," da referÍncia utilizada"," no momento do"," c·lculo.	"}
aHlpSpa := {" Determina el tipo de tasa,"," para permitir el control"," de la referencia utilizada"," en el momento"," del calculo."}
aHlpEng := {" Determines the rate type"," to allow the reference control"," used at the moment of ","calculation."}
SetHelp(    "PFNT_TIPO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Curva de demanda para calculo do indice "," de depreciacao "}
aHlpSpa := {"Curva de demanda para calcular el indice ","de depreciacion."}
aHlpEng := {"Demand curve to calculate the"," depreciation index."}
SetHelp(    "PFNT_CURVA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
//FNK
//
aHlpPor := {" Filial do Sistema"}
aHlpSpa := {" Sucursal del Sistema"}
aHlpEng := {" System Branch"}
SetHelp(    "PFNK_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
																								
aHlpPor := {" DescriÁ„o da rotina			"}
aHlpSpa := {" Descripcion de la rutina   	"}
aHlpEng := {" Routine description  "}
SetHelp(    "PFNK_DESCRT", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Controle interno do"," sistema para determinar ","qual o cÛdigo da revis„o"," ativa do cadastro de"," alÁada."}
aHlpSpa := {"Control interno del ","sistema para determinar"," el codigo de la revision ","activa del registro de ","pertinencia."}
aHlpEng := {"Internal control of ","the system to determine"," the code of the active"," review of jurisdiction ","register."}
SetHelp(    "PFNK_REVIS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Rotina do ambiente	"}
aHlpSpa := {" Rutina del entorno	"}
aHlpEng := {" Module routine   	"}
SetHelp(    "PFNK_ROTINA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Status do controle"," da operaÁ„o	 "}
aHlpSpa := {" Estatus del control"," de la operacion.   "}
aHlpEng := {" Operation control"," status   "}
SetHelp(    "PFNK_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
//FNL
aHlpPor := {" Filial do Sistema"}
aHlpSpa := {" Sucursal del Sistema"}
aHlpEng := {" System Branch"}
SetHelp(    "PFNL_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" DescriÁ„o da operaÁ„o			"}
aHlpSpa := {" Descripcion de la operacion. 	"}
aHlpEng := {" Operation description 		"}
SetHelp(    "PFNL_DESCOP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" OperaÁ„o da rotina	"}
aHlpSpa := {" Operacion de la rutina "}
aHlpEng := {" Routine operation "}
SetHelp(    "PFNL_OPER", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Controle interno do ","sistema para determinar ","qual o cÛdigo da revis„o"," ativa do cadastro de ","alÁada. "}
aHlpSpa := {" Control interno del"," sistema para determinar"," el codigo de la revision ","activa del registro"," de pertinencia."}
aHlpEng := {" Internal control of ","the system to determine"," the code of the active"," review of jurisdiction"," register.  "}
SetHelp(    "PFNL_REVIS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Rotina do ambiente	"}
aHlpSpa := {" Rutina del entorno   "}
aHlpEng := {" Module routine	"}
SetHelp(    "PFNL_ROTINA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Status do controle"," da operaÁ„o	 "}
aHlpSpa := {" Estatus del control"," de la operacion. "}
aHlpEng := {" Operation control ","status"}
SetHelp(    "PFNL_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
   
aHlpPor := {" Usu·rio que realizar· ","a aprovaÁ„o da operaÁ„o 		"}
aHlpSpa := {" Usuario que realizara ","la aprobacion de la operacion   "}
aHlpEng := {" User that approves the ","operation 					"}
SetHelp(    "PFNL_CODAPR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Nome do usu·rio que ","realizar· a aprovaÁ„o"," da operaÁ„o "}
aHlpSpa := {" Nombre del usuario ","que realizara la ","aprobacion de la operacion   "}          
aHlpEng := {" Name of user that"," approves the"," operation.  "}
SetHelp(    "PFNL_NOMAPR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Periodicidade para"," controle do saldo"," da alÁada do usu·rio    "}
aHlpSpa := {" Periodicidad para"," control del saldo"," da pertinencia del usuario    "}
aHlpEng := {" Frequency to control"," the user jurisdiction"," balance  "}
SetHelp(    "PFNL_PERIOD", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Tipo do controle de alÁada      "}
aHlpSpa := {" Tipo del control de pertinencia   "}
aHlpEng := {" Type of jurisdiction control.			"}
SetHelp(    "PFNL_TIPO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor da alÁada do ","aprovador em funÁ„o"," da periodicidade definida           "}
aHlpSpa := {"Valor de pertinencia","del  aprobador en funcion"," de la periodicidad"," definida      "}
aHlpEng := {"Value of the approver"," jurisdiction based on the ","frequency defined.  "}
SetHelp(    "PFNL_VALOR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
//
//FNH
//
aHlpPor := {" Filial do Sistema"}
aHlpSpa := {" Sucursal del Sistema"}
aHlpEng := {" System Branch"}
SetHelp(    "PFNH_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
																								
aHlpPor := {" DescriÁ„o da operaÁ„o			"}
aHlpSpa := {" Descripcion de la operacion	"}
aHlpEng := {" Description of Operation		"}
SetHelp(    "PFNH_DESCOP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" DescriÁ„o da rotina			"}
aHlpSpa := {" Descripcion de la rutina		"}
aHlpEng := {" Description of the routine	"}
SetHelp(    "PFNH_DESCRT", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" OperaÁ„o da rotina	"}
aHlpSpa := {" Operacion de la rutina"}
aHlpEng := {" Operation of the routine	"}
SetHelp(    "PFNH_OPER", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Rotina do ambiente	"}
aHlpSpa := {" Rutina del entorno.	"}
aHlpEng := {" Routine environment	"}
SetHelp(    "PFNH_ROTINA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Status do controle"," da operaÁ„o	 "}
aHlpSpa := {" Estatus de control"," de operacion "}
aHlpEng := {" Status of the ","operation control "}
SetHelp(    "PFNH_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)


//
//FNM
//
aHlpPor := {" Filial do Sistema			"}
aHlpSpa := {" Sucursal del Sistema		"}
aHlpEng := {" System Branch				"}
SetHelp(    "PFNM_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" DescriÁ„o da operaÁ„o			"}
aHlpSpa := {" Descripcion de la operacion	"}
aHlpEng := {" Operation description		"}
SetHelp(    "PFNM_DESCOP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" OperaÁ„o da rotina	"}
aHlpSpa := {" Operacion de la rutina"}
aHlpEng := {" Operation of the routine	"}
SetHelp(    "PFNM_OPER", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" DescriÁ„o da rotina			"}
aHlpSpa := {" Descripcion de la rutina	"}
aHlpEng := {" Routine description	"}
SetHelp(    "PFNM_DESCRT", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" OperaÁ„o da rotina	"}
aHlpSpa := {" Operacion de la rutina"}
aHlpEng := {" Routine operation	"}
SetHelp(    "PFNM_OPER", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Controle interno do"," sistema para determinar"," qual o cÛdigo da revis„o"," ativa do cadastro"," de alÁada."}
aHlpSpa := {"Control interno del"," sistema para determinar ","el codigo de la revision activa ","del registro de"," pertinencia."}
aHlpEng := {"Internal control of ","the system to determine ","the code of the active review of ","jurisdiction"," register."}
SetHelp(    "PFNM_REVIS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Rotina do ambiente	"}
aHlpSpa := {" Rutina del entorno.	"}
aHlpEng := {" Module routine	"}
SetHelp(    "PFNM_ROTINA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Status do controle"," da operaÁ„o	 "}
aHlpSpa := {" Estatus del control ","de la operacion. "}
aHlpEng := {" Operation control ","status "}
SetHelp(    "PFNM_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Usu·rio que realizar·","  a aprovaÁ„o da operaÁ„o			"}
aHlpSpa := {" Usuario que realizara"," la aprobacion de la"," operacion	"}
aHlpEng := {" User that approves the ","operation					"}
SetHelp(    "PFNM_CODAPR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Usu·rio que realizou","  a operaÁ„o	"}
aHlpSpa := {" Usuario que realizo"," la operacion	"}
aHlpEng := {" User who carried ","out the operation.	"}
SetHelp(    "PFNM_CODSOL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Data da movimentaÁ„o"}
aHlpSpa := {" Fecha de Movimiento"}
aHlpEng := {" Date of transaction		"}
SetHelp(    "PFNM_DATA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Identificador ˙nico","  dos movimentos		"}
aHlpSpa := {" Identificador unico"," de los movimientos	"}
aHlpEng := {" Single identifier ","of transactions	"}
SetHelp(    "PFNM_IDMOV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Justificativa do aprovador","  para aprovaÁ„o ou reprovaÁ„o	"}
aHlpSpa := {" Justificativa del aprobador"," para aprobacion o reprobacion	"}
aHlpEng := {" Approver justification for"," approval or rejection.		"}
SetHelp(    "PFNM_MEMAPR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Justificativa do","  solicitante para aprovaÁ„o	"}
aHlpSpa := {" Justificativa del ","solicitante para aprobacion	"}
aHlpEng := {" Requester justification"," for approval.			"}
SetHelp(    "PFNM_MEMSOL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Moeda na qual a "," operaÁ„o foi realizada			"}
aHlpSpa := {" Moneda en que la ","operacion se realizo			"}
aHlpEng := {" Currency used in ","the operation.	"}
SetHelp(    "PFNM_MOEDA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Nome do usu·rio que","  realizar· a aprovaÁ„o","  da operaÁ„o				 "}
aHlpSpa := {" Nombre del usuario que ","realizara la aprobacion ","de la operacion	 "}
aHlpEng := {" Name of user that approves"," the operation. "}
SetHelp(    "PFNM_NOMAPR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Nome do usu·rio que","  realizou a operaÁ„o		"}
aHlpSpa := {" Nombre del usuario ","que realizo la operacion"}
aHlpEng := {" Name of user who ","carried out the operation"}
SetHelp(    "PFNM_NOMSOL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" CÛdigo da rotina que","  gerou a solicitaÁ„o		"}
aHlpSpa := {" Codigo de la rutina ","que genero la solicitud	"}
aHlpEng := {" Code of the routine"," that generated the request."}
SetHelp(    "PFNM_ORIGEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Recno do registro de origem	"}
aHlpSpa := {" Recno del registro de origen"}
aHlpEng := {" Recno of source record."}
SetHelp(    "PFNM_RECORI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Alias da tabela de "," origem da solicitaÁ„o		"}
aHlpSpa := {" Alias de la tabla de ","origen de la solicitud	"}
aHlpEng := {" Alias of request ","source table.	"}
SetHelp(    "PFNM_TABORI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {" Valor da operaÁ„o "," realizada em funÁ„o "," da moeda				"}
aHlpSpa := {" Valor de la operacion"," realizada en funcion"," de la moneda	"}
aHlpEng := {" Value of the operation"," carried out based on ","the currency"}
SetHelp(    "PFNM_VALOR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
// Tabela FNN - Processo Constituicao Provisao
//
aHlpPor := {"Filial do Sistema"}
aHlpSpa := {"Sucursal del Sistema"}
aHlpEng := {"System Branch"}
SetHelp(    "PFNN_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
																																								
aHlpPor := {"data do processamento    "}														
aHlpSpa := {"Fecha del procesamiento.  "}
aHlpEng := {"processing date "}
SetHelp(    "PFNN_DTPROC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Identificador do processo."}
aHlpSpa := {"Identificador del proceso.  "}
aHlpEng := {"Process Identifier "}
SetHelp(    "PFNN_IDPROC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Status do processo: ","1 = Realizado ","2 = Cancelado"}
aHlpSpa := {"Estatus del proceso: ","1 = Realizado ","2 = Anulado"}
aHlpEng := {"Process Status:","1 = Performed ","2 = Canceled"}
SetHelp(    "PFNN_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Log de AlteraÁ„o     "}																
aHlpSpa := {"Log de modificacion. 	"}
aHlpEng := {"Editing Log  		"}
SetHelp(    "PFNN_USERGA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Log de Inclus„o  "}																
aHlpSpa := {"Log de inclusion. "}
aHlpEng := {"Addition Log  	"}
SetHelp(    "PFNN_USERGI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
// Tabela FNO - Movtos. Constituicao Provisao       
//
aHlpPor := {"Filial do Sistema "}
aHlpSpa := {"Sucursal del sistema."}
aHlpEng := {"System Branch."}
SetHelp(    "PFNO_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Identificador do processo"," de apropriaÁ„o de provis„o"}
aHlpSpa := {"Identificador del proceso"," de imputacion de provision."}
aHlpEng := {"Provision appropriation"," process identifier."}
SetHelp(    "PFNO_IDPROC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data do processamento da"," apropriaÁ„o de provis„o"}														
aHlpSpa := {"Fecha del procesamiento ","de la imputacion de ","la provision."}
aHlpEng := {"Provision appropriation"," process date."}
SetHelp(    "PFNO_DTPROC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Codigo base da provis„o ","gerada pela"," apropriaÁ„o   "}
aHlpSpa := {"Codigo base de la ","provision generada ","por la imputacion.      "}
aHlpEng := {"Provision base code ","generated by the ","appropriation     "}
SetHelp(    "PFNO_CBASE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Item da provis„o ","gerada pela apropriaÁ„o   "}
aHlpSpa := {"Item de la provision"," generada por la imputacion. "}
aHlpEng := {"Provision item generated"," by the appropriation "}
SetHelp(    "PFNO_ITEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Codigo base da ficha de ","origem da provis„o gerada ","pela apropriaÁ„o   "}
aHlpSpa := {"Codigo base de la ficha","de origen de la provision generada"," por la imputacion. "}
aHlpEng := {"Origin Form base code ","generated by the ","appropriation  "}
SetHelp(    "PFNO_BASESP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Item da ficha de origem"," da provis„o gerada"," pela apropriaÁ„o.  "}
aHlpSpa := {"Item de la ficha de ","origen de la provision ","generada por la"," imputacion.  "}
aHlpEng := {"Origin Form item"," generated by the ","appropriation "}
SetHelp(    "PFNO_ITEMSP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Mensagem do processamento ","da apropriaÁ„o de ","provis„o        "}
aHlpSpa := {"Mensaje del procesamiento"," de la imputacion de ","la provision.        "}
aHlpEng := {"Message of the provision"," appropriation ","processing"}
SetHelp(    "PFNO_MSG", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Status do processo ","de apropriacao de AVP    "}																    
aHlpSpa := {"Estatus del proceso ","de atribucion de AVP  "}  
aHlpEng := {"Status of AVP ","appropriation process. "}
SetHelp(    "PFNO_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Identificador do"," movimento do imobilizado"," (valor do N4_IDMOV ","quando for o caso)   "}
aHlpSpa := {"Identificador del ","movimiento del activo"," fijo (valor del N4_IDMOV"," si fuera el caso) "}
aHlpEng := {"Identifier of the"," fixed asset transaction ","(N4_IDMOV value"," when applicable)."}
SetHelp(    "PFNO_IDMVAF", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
// Tabela FNQ - Regras de Margem Gerencial
//
aHlpPor := {"CÛdigo da Margem que ser· utilizada no ","cadastro de ativo fixo"}
aHlpSpa := {"Codigo del Margen que se utilizara en ","el archivo de activo fijo"}
aHlpEng := {"Margin Code to be used in fixed asset ","file"}
SetHelp(    "PFNQ_COD", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"DescriÁ„o da Margem Gerencial"}
aHlpSpa := {"Descripcion de Margen de Gestion"}
aHlpEng := {"Management Margin Description"}
SetHelp(    "PFNQ_DESC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Filial do Sistema "}
aHlpSpa := {"Sucursal del sistema."}
aHlpEng := {"System Branch."}
SetHelp(    "PFNQ_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Bloqueia o Registro?","1 = Sim","2 = Nao"}
aHlpSpa := {"øBloquea el registro?","1 = Si","2 = No"}
aHlpEng := {"Block the Register?","1 = Yes","2 = No"}
SetHelp(    "PFNQ_MSBLQL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Percentual da Margem para calculo, caso","o tipo seja percentual"}
aHlpSpa := {"Porcentaje del Margen para calculo, ","cuando el tipo sea porcentaje"}
aHlpEng := {"Margin Percentage for calculation, if ","the type is percentage"}
SetHelp(    "PFNQ_PERCEN", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Revis„o da Margem Gerencial"}
aHlpSpa := {"Revision de Margen de Gestion"}
aHlpEng := {"Management Margin Review"}
SetHelp(    "PFNQ_REV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Status do cadastro de Margem"}
aHlpSpa := {"Estatus del archivo de Margen"}  
aHlpEng := {"Status of Margin file"}
SetHelp(    "PFNQ_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo de calculo da Margem Gerencial.","1 = Percentual: A Margem ser· calculada"," pelo valor do tipo gerencial "," multiplicado pelo percentual","2= Valor Fixo: A Margem ser· o valor ","fixo informado no cadastro."}
aHlpSpa := {"Tipo de calculo de Margen de Gestion.","1 = Porcentaje: La Margen se calculara"," por el valor del tipo de gestion "," multiplicado por el porcentaje","2= Valor Fijo: La Margen sera el valor "," fijo informado en el registro."}
aHlpEng := {"Type of management margin calculation.","1=Percentage: The Margin will be "," calculated through the value of "," management type multiplied by the "," percentage","2= Fixed Value: The Margin will be the"," fixed value entered in the file."}
SetHelp(    "PFNQ_TIPO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor fixo da Margem Gerencial"}
aHlpSpa := {"Valor fijo del Margen de Gestion"}
aHlpEng := {"Fixed Value of the Management Margin"}
SetHelp(    "PFNQ_VLRFIX", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
// Help Tabela FN1
//
aHlpPor := {"Data do Processamento"}
aHlpSpa := {"Fecha del Procesamiento"}
aHlpEng := {"Processing date"}
SetHelp(    "PFN1_DATA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"DescriÁ„o do processamento"}
aHlpSpa := {"Descripcion del procesamiento"}
aHlpEng := {"Processing Description"}
SetHelp(    "PFN1_DESC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Filial do Sistema"}
aHlpSpa := {"Sucursal del Sistema."}
aHlpEng := {"System Branch"}
SetHelp(    "PFN1_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo do processo de custo de"," emprÈstimo"}
aHlpSpa := {"Codigo del proceso de costo de"," prestamo"}
aHlpEng := {"Code of cost process of loan"}
SetHelp(    "PFN1_PROC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Status do processamento","1= Efetivado","2= Estornado"}
aHlpSpa := {"Estatus del procesamiento","1= Efectivado","2= Extornado"}
aHlpEng := {"Process Status","1 = Effective","2 = Reversed"}
SetHelp(    "PFN1_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Log de alteracao do processamento"}
aHlpSpa := {"Log de modificacion del procesamiento"}
aHlpEng := {"Processing editing log"}
SetHelp(    "PFN1_USERGA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Log de processamento de Inclus„o"}
aHlpSpa := {"Log de procesamiento de Inclusion"}
aHlpEng := {"Inclusion processing log"}
SetHelp(    "PFN1_USERGI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Informa se o calculo do valor Amortizado ser·","(1) Automatico ou (2) manual."}
aHlpSpa := {"Informa si el calculo del valor amortizado sera","(1) Automatico o (2) Manual."}
aHlpEng := {"Enters if the calculation of Amortization will be","(1) Automatic or (2) Manual."}
SetHelp(    "PFN1_TIPO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
// Tabela FN2
//

aHlpPor := {"DescriÁ„o do contrato financeiro"}
aHlpSpa := {"Descripcion del contrato financiero"}
aHlpEng := {"Financial contract description"}
SetHelp(    "PFN2_DESC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Filial do Sistema"}
aHlpSpa := {"Sucursal del Sistema"}
aHlpEng := {"System Branch"}
SetHelp(    "PFN2_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Identificador do Contrato de ","financiamento. Esse È um dado da ","entidade financeira, sendo utilizada no","sistema para fins informativos."}
aHlpSpa := {"Identificador del Contrato de","financiacion. Este es un dato de la ","entidad financiera, que se utiliza en ","el sistema para fines informativos."}
aHlpEng := {"Financing contract identifier. This is","a data from the financing entity, used","in the system for information purposes."}
SetHelp(    "PFN2_IDCONT", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Juros da competÍncia do processamento"}
aHlpSpa := {"Interes de la vigencia del ","procesamiento"}
aHlpEng := {"Processing accrual interest"}
SetHelp(    "PFN2_JURCOM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Linha de configuraÁ„o do contrato de ","financiamento"}
aHlpSpa := {"Linea de configuracion del contrato de ","financiacion"}
aHlpEng := {"Configuration line of financing ","contract"}
SetHelp(    "PFN2_LINHA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Codigo do processamento de custo de ","emprestimo"}
aHlpSpa := {"Codigo del procesamiento de costo del ","prestamo"}
aHlpEng := {"Code of cost processing of loan"}
SetHelp(    "PFN2_PROC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor do Contrato."}
aHlpSpa := {"Valor del Contrato."}
aHlpEng := {"Contract Value."}
SetHelp(    "PFN2_VLRCON", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor do Saldo do Contrato"}
aHlpSpa := {"Valor del Saldo del Contrato"}
aHlpEng := {"Contract Balance Value"}
SetHelp(    "PFN2_VLRSAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
// Tabela FN3
//
aHlpPor := {"Valor de amortizaÁ„o do custo de ","transaÁ„o"}
aHlpSpa := {"Valor de amortizacion del costo de ","transaccion"}
aHlpEng := {"Amortization value of transaction cost"}
SetHelp(    "PFN3_AMORT", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo Base da ficha de custo de ","transaÁ„o "}
aHlpSpa := {"Codigo Base de la ficha de costo de","transaccion"}
aHlpEng := {"Base code of transaction cost form"}
SetHelp(    "PFN3_CBASE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Filial do Sistema"}
aHlpSpa := {"Sucursal del Sistema"}
aHlpEng := {"System Branch"}
SetHelp(    "PFN3_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Item da ficha de custo de transaÁ„o"}
aHlpSpa := {"Item de la ficha de costo de ","transaccion"}
aHlpEng := {"Item of transaction cost form"}
SetHelp(    "PFN3_ITEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Linha de configuraÁ„o do custo de ","transaÁ„o do processamento"}
aHlpSpa := {"Linea de configuracion del costo de ","transaccion del procesamiento"}
aHlpEng := {"Configuration line of processing ","transaction cost"}
SetHelp(    "PFN3_LINHA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo do Processamento "}
aHlpSpa := {"Codigo del Procesamiento"}
aHlpEng := {"Processing Code"}
SetHelp(    "PFN3_PROC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo da ficha de custo de transaÁ„o"}
aHlpSpa := {"Tipo de la ficha de costo de ","transaccion"}
aHlpEng := {"Type of transaction cost form"}
SetHelp(    "PFN3_TIPO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo de Saldo da ficha de custo de ","transaÁ„o"}
aHlpSpa := {"Tipo del Saldo de la ficha de costo de","transaccion "}
aHlpEng := {"Balance type of transaction cost form "}
SetHelp(    "PFN3_TPSALD", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Informe a descriÁ„o do valor da amortizaÁ„o","do custo da transaÁ„o."}
aHlpSpa := {"Informe la descripcion del valor de la"," amortizacion del costo de la transaccion."}
aHlpEng := {"Inform the description of amortization value for","transaction cos"}
SetHelp(    "PFN3_DESC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)
 
//
// Tabela FN4
//

aHlpPor := {"DescriÁ„o do rendimento"}
aHlpSpa := {"Descripcion del rendimiento"}
aHlpEng := {"Income Description"}
SetHelp(    "PFN4_DESC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Filial do Sistema"}
aHlpSpa := {"Sucursal del Sistema"}
aHlpEng := {"System Branch"}
SetHelp(    "PFN4_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Linha de configuraÁ„o do rendimento"}
aHlpSpa := {"Linea de configuracion del rendimiento"}
aHlpEng := {"Income configuration line"}
SetHelp(    "PFN4_LINHA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Codigo do processamento de custo de ","emprestimo"}
aHlpSpa := {"Codigo del procesamiento de costo del","prestamo"}
aHlpEng := {"Code of cost processing of loan"}
SetHelp(    "PFN4_PROC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor do Rendimento"}
aHlpSpa := {"Valor del Rendimiento"}
aHlpEng := {"Income value"}
SetHelp(    "PFN4_VALOR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
// Tabela FN5
//

aHlpPor := {"CÛdigo Base da ficha de custo de ","emprÈstimo"}
aHlpSpa := {"Codigo Base de la ficha de costo de"," prestamo"}
aHlpEng := {"Base code of loan cost form"}
SetHelp(    "PFN5_CBACEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo base do ativo apropriado"}
aHlpSpa := {"Codigo base del activo apropiado"}
aHlpEng := {"Appropriated asset base code"}
SetHelp(    "PFN5_CBAORI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Filial do Sistema"}
aHlpSpa := {"Sucursal del Sistema"}
aHlpEng := {"System Branch"}
SetHelp(    "PFN5_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Grupo de bens que contem a configuraÁ„o","cont·bil da ficha de custo de ","emprÈstimo"}
aHlpSpa := {"Grupo de bienes que contiene la ","configuracion contable de la ficha de ","costo de prestamo"}
aHlpEng := {"Group of goods that contain the ","accounting configuration of the loan ","cost form"}
SetHelp(    "PFN5_GRPCEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Item do custo de emprÈstimo"}
aHlpSpa := {"Item del costo de prestimo"}
aHlpEng := {"Loan cost item"}
SetHelp(    "PFN5_ITECEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Item do ativo apropriado"}
aHlpSpa := {"Item del activo apropiado"}
aHlpEng := {"Appropriated asset item"}
SetHelp(    "PFN5_ITEORI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Linha de configuraÁ„o da ficha de custo","criada pelo processamento"}
aHlpSpa := {"Linea de configuracion de la ficha de ","costo creada por el procesamiento"}
aHlpEng := {"Configuration line of cost form created","by processing"}
SetHelp(    "PFN5_LINHA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Codigo do processamento de custo de ","emprestimo"}
aHlpSpa := {"Codigo del procesamiento de costo del","prestamo"}
aHlpEng := {"Code of cost processing of loan"}
SetHelp(    "PFN5_PROC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo de saldo da ficha de custo de ","emprÈstimo"}
aHlpSpa := {"Tipo del Saldo de la ficha de costo de"," prestamo"}
aHlpEng := {"Balance type of loan cost form"}
SetHelp(    "PFN5_SLDEMP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo de saldo do ativo original"}
aHlpSpa := {"Tipo de saldo del activo original"}
aHlpEng := {"Balance type of the original asset"}
SetHelp(    "PFN5_SLDORI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo da ficha de custo de emprestimo"}
aHlpSpa := {"Tipo de la ficha de costo de prestamo"}
aHlpEng := {"Type of loan cost form"}
SetHelp(    "PFN5_TIPEMP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo original da ficha de ativo"}
aHlpSpa := {"Tipo original de la ficha de activo"}
aHlpEng := {"Original type of the asset form"}
SetHelp(    "PFN5_TIPORI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Taxa de capitalizaÁ„o utilizada na ","determinaÁ„o do montante dos custos de ","emprÈstimo elegÌvel ‡ capitalizaÁ„o"}
aHlpSpa := {"Tasa de capitalizacion utilizada en la ","determinacion del monto de los costos ","de prestamo elegible a la ","capitalizacion "}
aHlpEng := {"Capitalization rate used for ","determining the cost amount of loan ","eligible to capitalization"}
SetHelp(    "PFN5_TXCAP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor da apropriaÁ„o do custo de ","emprÈstimo"}
aHlpSpa := {"Valor de la apropiacion del costo de","prestamo"}
aHlpEng := {"Value of loan cost appropriation"}
SetHelp(    "PFN5_VLRAPR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor do ativo original na moeda 01"}
aHlpSpa := {"Valor del activo original en la moneda ","01"}
aHlpEng := {"Original asset value in currency 01"}
SetHelp(    "PFN5_VLRORI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)


//
// Tabela FNU - Controle de Provis„o
//
aHlpPor := {"Classe de valor da provis„o."}
aHlpSpa := {"Clase de valor de la provision."}
aHlpEng := {"Provision value class."}
SetHelp(    "PFNU_CLVL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo da provis„o"}
aHlpSpa := {"Codigo de la provision"}
aHlpEng := {"Provision code"}
SetHelp(    "PFNU_COD", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Conta cont·bil da provis„o"}
aHlpSpa := {"Cuenta contable de la provision"}
aHlpEng := {"Provision ledger account"}
SetHelp(    "PFNU_CONTA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Centro de Custo da provis„o"}
aHlpSpa := {"Centro de costo de la provision"}
aHlpEng := {"Provision Cost Center"}
SetHelp(    "PFNU_CUSTO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"DescriÁ„o da provis„o"}
aHlpSpa := {"Descripcion de la provision"}
aHlpEng := {"Provision description"}
SetHelp(    "PFNU_DESCR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data de reconhecimento"," da provis„o."," Campo respons·vel"," para calcular"," a quantidade de dias para"," o AVP, determinaÁ„o da taxa de ","desconto para a provis„o e o"," inÌcio dos movimentos"," da provis„o."}
aHlpSpa := {"Fecha de inicio de la provision."}
aHlpEng := {"Provision initial date"}
SetHelp(    "PFNU_DTINI", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data de InÌcio do ","Projeto. Esse campo"," determinar· a data"," de referÍncia para o ","c·lculo da"," distribuiÁ„o."}
aHlpSpa := {"Fecha de inicio del"," proyecto. Ese campo ","determinara la fecha"," de referencia para ","calcular la ","distribucion."}
aHlpEng := {"Project Start Date."," This field determines ","the reference date"," for distribution"," calculation."}
SetHelp(    "PFNU_INIPRJ", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data de referencia de AVP.","Essa data ser· utilizada"," para localizar a taxa"," atual de AVP e o ","inÌcio do calculo de ","AVP da provis„o"}
aHlpSpa := {"Fecha de referencia de AVP.","Esta fecha se utilizara"," para ubicar la tasa"," actual de AVP y el ","inicio del calculo de ","AVP de la provision."}
aHlpEng := {"AVP reference date.","This date will be used to ","locate the current AVP ","rate and the start of ","the AVP provision"," calculation"}
SetHelp(    "PFNU_DTAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data da revis„o do cadastro de provis„o."}
aHlpSpa := {"Fecha de la revision del archivo de ","provision"}
aHlpEng := {"Review date of provision file."}
SetHelp(    "PFNU_DTREV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Filial do Sistema"}
aHlpSpa := {"Sucursal del sistema."}
aHlpEng := {"System Branch"}
SetHelp(    "PFNU_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo do Ìndice de AVP utilizado para ","provis„o"}
aHlpSpa := {"Codigo del indice de AVP que se utiliza","para la provision"}
aHlpEng := {"Code of AVP index used for provision"}
SetHelp(    "PFNU_INDAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Indice da curva de demanda aplicada a ","provis„o"}
aHlpSpa := {"Indice de la curva de demanda que se ","aplica a la provision"}
aHlpEng := {"Index of the demand curve applied to ","the provision"}
SetHelp(    "PFNU_INDICE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Item Cont·bil da provis„o"}
aHlpSpa := {"Item contable de la provision"}
aHlpEng := {"Provision ledger account"}
SetHelp(    "PFNU_ITEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Controle de bloqueio do cadastro de ","controle de provis„o."}
aHlpSpa := {"Control de bloqueo del archivo de ","control de provision."}
aHlpEng := {"Lock control of the provision control ","register."}
SetHelp(    "PFNU_MSBLQL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Revis„o da provis„o"}
aHlpSpa := {"Revision de la provision"}
aHlpEng := {"Provision review"}
SetHelp(    "PFNU_REV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Status da revis„o do controle de ","provis„o atual."}
aHlpSpa := {"Estatus de la revision del control de","provision actual."}
aHlpEng := {"Revision status of the current ","provision control."}
SetHelp(    "PFNU_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Taxa do indice de AVP para a provis„o"}
aHlpSpa := {"Tasa del indice de AVP para la","provision"}
aHlpEng := {"Rate of AVP index used for provision"}
SetHelp(    "PFNU_TAXAVP", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo de c·lculo da provis„o"}
aHlpSpa := {"Tipo de calculo de la provision."}
aHlpEng := {"Provision calculation type"}
SetHelp(    "PFNU_TPCALC", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo de saldo considerado para ","realizaÁ„o do controle  de provis„o.","Apenas imobilizados com este tipo de ","saldo poder„o ser relacionados ao ","controle de provis„o como bem de ","execuÁ„o."}
aHlpSpa := {"Tipo de saldo que se considera para ","realizar el control de provision.","Solo los inmovilizados con este tipo de","saldo podran vincularse al control de ","provision como bien de ejecucion."}
aHlpEng := {"Balance type considered to perform the","provision control.","Only fixed assets with this balance ","type can be related to the provision ","control as execution asset."}              	
SetHelp(    "PFNU_TPSALD", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"SomatÛrio do valor bruto dos itens do","controle de provis„o"}
aHlpSpa := {"Suma del valor bruto de los items del","control de provision."}
aHlpEng := {"Sum of the gross value of the provision","control items"}
SetHelp(    "PFNU_VLRBRT", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"SomatÛrio do valor presente dos itens","do controle de provis„o"}
aHlpSpa := {"Suma del valor presente de los items ","del control de provision."}
aHlpEng := {"Sum of the present value of the","provision control items"}
SetHelp(    "PFNU_VLRPRE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
// Tabela FNV - Itens de Provis„o
//
aHlpPor := {"CÛdigo da provis„o"}
aHlpSpa := {"Codigo de la provision."}
aHlpEng := {"Provision code"}
SetHelp(    "PFNV_COD", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data final  da provis„o"}
aHlpSpa := {"Fecha final de la provision."}
aHlpEng := {"Guarantee final date"}
SetHelp(    "PFNV_DTFIN", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Filial do Sistema"}
aHlpSpa := {"Sucursal del sistema."}
aHlpEng := {"System Branch"}
SetHelp(    "PFNV_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Item da provis„o"}
aHlpSpa := {"Item de la provision."}
aHlpEng := {"Provision item"}
SetHelp(    "PFNV_ITEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Revis„o da provis„o"}
aHlpSpa := {"Revision de la provision."}
aHlpEng := {"Provision review"}
SetHelp(    "PFNV_REV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Indica se a realizaÁ„o da provis„o foi ","efetivada para este periodo."}
aHlpSpa := {"Indica si la realizacion de la ","provision ya se efectuo para este ","periodo."}
aHlpEng := {"Indicates if provision realization was ","executed for this period."}
SetHelp(    "PFNV_RLZEFT", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor bruto do item da provis„o"}
aHlpSpa := {"Valor bruto del item de la provision"}
aHlpEng := {"Gross value of provision item"}
SetHelp(    "PFNV_VLRBRT", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor presente do item da provis„o"}
aHlpSpa := {"Valor presente del item de la ","provision."}
aHlpEng := {"Current value of provision item"}
SetHelp(    "PFNV_VLRPRE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
// Tabela FNW - Movimentos de Provis„o
//
aHlpPor := {"CÛdigo da provis„o"}
aHlpSpa := {"Codigo de la provision"}
aHlpEng := {"Provision code"}
SetHelp(    "PFNW_COD", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data do movimento"}
aHlpSpa := {"Fecha del movimiento"}
aHlpEng := {"Transaction date"}
SetHelp(    "PFNW_DTMOV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Filial do Sistema"}
aHlpSpa := {"Sucursal del sistema."}
aHlpEng := {"System Branch"}
SetHelp(    "PFNW_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Identificador dos movimentos"}
aHlpSpa := {"Identificador de los movimientos"}
aHlpEng := {"Identifier of transactions"}
SetHelp(    "PFNW_IDMOV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Identificador de LanÁamento Cont·bil.","O sistema identifica se j· foi efetuada","a rotina de lanÁamento cont·bil para o ","registro.","Conte˙dos possiveis:","<em branco> = N„o contabilizado ","'1' = Contabilizado","'2' = Revisado"}
aHlpSpa := {"Identificador de asiento contable.","El sistema identifica si se efectuo la ","rutina de asiento contable para el ","registro.","Contenidos posibles:","<Vacio> = No contabilizado","'1' = Contabilizado","'2' = Revisado"}
aHlpEng := {"Accounting Entry Identifier.","The system identifies if the accounting","entry routine was already executed for ","the register.","Possible content:","<Blank> = Not accounted","'1' = Accounted","'2' = Reviewed"}
SetHelp(    "PFNW_LA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo da ocorrÍncia referente ao ","movimento de provis„o "}
aHlpSpa := {"Codigo dela ocurrencia referente al","movimiento de provision"}
aHlpEng := {"Event code regarding the provision ","transaction"}
SetHelp(    "PFNW_OCOR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Periodo (ano-mÍs) a que se refere o ","movimento de provis„o"}
aHlpSpa := {"Periodo (ano-mes) al que se refiere el","movimiento de provision"}
aHlpEng := {"Period (year-month) to which the ","provision transaction refers"}
SetHelp(    "PFNW_PERIOD", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Identificador do prazo do movimento,","indicando se o mesmo È de curto ou ","longo prazo"}
aHlpSpa := {"Identificador del plazo del movimiento,","indicando sie le mismo es de corto o ","largo plazo   "}
aHlpEng := {"Identifier of the transaction term, ","indicating if it is short or long term."}
SetHelp(    "PFNW_PRAZO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Revis„o da provis„o"}
aHlpSpa := {"Revision de la provision"}
aHlpEng := {"Provision review"}
SetHelp(    "PFNW_REV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor do movimento de provis„o"}
aHlpSpa := {"Valor del movimiento de provision"}
aHlpEng := {"Provision transaction value"}
SetHelp(    "PFNW_VALOR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data de registro da ocorrÍncia da ","movimentaÁ„o do controle de ","provis„o."}
aHlpSpa := {"Fecha de registro de la ocurrencia"," del movimiento del control de provision."}
aHlpEng := {"Registration date of occurrence of"," provision control transaction."}
SetHelp(    "PFNW_DTEFET", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

//
// Tabela FNX - Realizacao de Provis„o
//
aHlpPor := {"CÛdigo Base do Ativo de ExecuÁ„o para ","realizaÁ„o da provis„o"}
aHlpSpa := {"Codigo Base del Activo de Ejecucion para realizacion de la provision"}
aHlpEng := {"Base Code of Execution Asset for ","provision realization"}
SetHelp(    "PFNX_CBASE", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"CÛdigo do controle de provis„o"}
aHlpSpa := {"Codigo del control de prevision"}
aHlpEng := {"Provision control code"}
SetHelp(    "PFNX_COD", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data da efetivaÁ„o da realizaÁ„o ","relacionada a uma provis„o"}
aHlpSpa := {"Fecha de efectivizacion de la","realizacion relacionada con una","provision"}
aHlpEng := {"Effective date of the realization ","related to a provision."}
SetHelp(    "PFNX_DTCONT", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Data do movimento de realizaÁ„o."}
aHlpSpa := {"Fecha del movimiento de realizacion."}
aHlpEng := {"Realization movement date."}
SetHelp(    "PFNX_DTMOV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Filial do Sistema"}
aHlpSpa := {"Sucursal del sistema."}
aHlpEng := {"System Branch"}
SetHelp(    "PFNX_FILIAL", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Item do Ativo de ExecuÁ„o para ","realizaÁ„o da provis„o"}
aHlpSpa := {"Item del Activo de Ejecucion para","realizacion de la provision"}
aHlpEng := {"Item of Execution Asset for provision ","realization"}
SetHelp(    "PFNX_ITEM", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Linha da realizaÁ„o de provis„o"}
aHlpSpa := {"Linea de la realizacion de provision"}
aHlpEng := {"Provision realization line"}
SetHelp(    "PFNX_LINHA", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Revis„o do controle de provis„o"}
aHlpSpa := {"Revision del control de prevision"}
aHlpEng := {"Provision control review"}
SetHelp(    "PFNX_REV", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo do Ativo de ExecuÁ„o para ","realizaÁ„o da provis„o"}
aHlpSpa := {"Tipo del Activo de Ejecucion para","realizacion de la provision"}
aHlpEng := {"Type of Execution Asset for provision ","realization"}
SetHelp(    "PFNX_TIPO", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Tipo de saldo do Ativo de ExecuÁ„o para"," realizaÁ„o da provis„o"}
aHlpSpa := {"Tipo del saldo del Activo de Ejecucion","para realizacion de la provision"}
aHlpEng := {"Balance type of Execution Asset for ","provision realization"}
SetHelp(    "PFNX_TPSALD", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)

aHlpPor := {"Valor de execuÁ„o para realizaÁ„o da ","provis„o "}
aHlpSpa := {"Valor de ejecucion para realizacion de","la provision"}
aHlpEng := {"Execution value of provision ","realization"}
SetHelp(    "PFNX_VALOR", aHlpPor, aHlpEng, aHlpSpa, .T., @cAlias)


cTexto := STR0078+cAlias+CRLF//"Atualizados os helps de campos das tabelas: "
Return cTexto
         
/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥AdmAbreSM0≥ Autor ≥ Orizio                ≥ Data ≥ 22/01/10 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥Retorna um array com as informacoes das filias das empresas ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ Generico                                                   ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
Static Function AdmAbreSM0()
	Local aArea			:= SM0->( GetArea() )
	Local aAux			:= {}
	Local aRetSM0		:= {}
	Local lFWLoadSM0	:= FindFunction( "FWLoadSM0" )
	Local lFWCodFilSM0 	:= FindFunction( "FWCodFil" )

	If lFWLoadSM0
		aRetSM0	:= FWLoadSM0()
	Else
		DbSelectArea( "SM0" )
		SM0->( DbGoTop() )
		While SM0->( !Eof() )
			aAux := { 	SM0->M0_CODIGO,;
						IIf( lFWCodFilSM0, FWGETCODFILIAL, SM0->M0_CODFIL ),;
						"",;
						"",;
						"",;
						SM0->M0_NOME,;
						SM0->M0_FILIAL }

			aAdd( aRetSM0, aClone( aAux ) )
			SM0->( DbSkip() )
		End
	EndIf

	RestArea( aArea )
Return aRetSM0

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÑo	 ≥AtfTamSXG ≥ Autor ≥ Totvs                 ≥ Data ≥ 03/02/10 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Funcao para obter o tamanho padrao do campo conforme SXG.  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ Implantacao ATF                                            ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function AtfTamSXG( cGrupo, nTamPad )
Local aRet

DbSelectArea( "SXG" )
DbSetOrder( 1 )

If DbSeek( cGrupo )
	nTamPad := SXG->XG_SIZE
	aRet := { nTamPad, "@!", nTamPad, nTamPad }
Else
	aRet := { nTamPad, "@!", nTamPad, nTamPad }
EndIf

Return aRet

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫ Programa ≥ ATFAtuSX9 ∫ Autor ≥ Microsiga          ∫ Data ≥  19/05/10   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫ Descricao≥ Funcao de processamento da gravacao do SX9 - Relacionament  ≥±±
±±∫          ≥                                                             ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±≥ Uso      ≥ AtuSX9ACD                                                   ≥±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ATFAtuSX9( )
Local aEstrut   := {}
Local aSX9      := {}
Local cAlias    := ''
Local nI        := 0
Local nJ        := 0
Local nTamSeek  := Len( SX9->X9_DOM )
Local cTexto		:= ""

cTexto += STR0079 + CRLF//'Atualizacao dos Relacionamentos(SX9):'

aEstrut := { 'X9_DOM'   , 'X9_IDENT'  , 'X9_CDOM'   , 'X9_EXPDOM', 'X9_EXPCDOM' ,'X9_PROPRI', ;
             'X9_LIGDOM', 'X9_LIGCDOM', 'X9_CONDSQL', 'X9_USEFIL', 'X9_ENABLE' }


AADD(aSX9, { 'FNB'   , '001', 'FNC' , 'FNB_CODPRJ+FNB_REVIS' , 'FNC_CODPRJ+FNC_REVIS','S','1', 'N', '', 'S', 'S' })
AADD(aSX9, { 'FNC'   , '001', 'FND' , 'FNC_CODPRJ+FNC_REVIS+FNC_ETAPA', 'FND_CODPRJ+FND_REVIS+FND_ETAPA' ,'S','1', 'N', '', 'S', 'S' })
AADD(aSX9, { 'FND'   , '001', 'FNE' , 'FND_CODPRJ+FND_REVIS+FND_ETAPA+FND_ITEM', 'FNE_CODPRJ+FNE_REVIS+FNE_ETAPA+FNE_ITEM'  ,'S','1', 'N', '', 'S', 'S' })
AADD(aSX9, { 'FND'   , '002', 'SN1' , 'FND_CODPRJ+FND_REVIS+FND_ETAPA+FND_ITEM','N1_PROJETO+N1_PROJREV+N1_PROJETP+N1_PROJITE'  ,'S','1', '1', '', 'S', 'S' })

//AVP
AADD(aSX9, { 'SN1'   , '001', 'FNF'  , 'N3_CBASE + N3_ITEM + N3_TIPO + N3_SEQ + N3_TPSALDO','FNF_CBASE + FNF_ITEM + FNF_TIPO + FNF_SEQ + FNF_TPSALD '  ,'S','1', 'N', '', 'S', 'S' })
AADD(aSX9, { 'FNF'   , '001', 'FNP'  , 'FNP_IDPROC', 'FNF_IDPROC' ,'S','1', 'N', '', 'S', 'S' })

//AlÁada de aprovaÁ„o
AADD(aSX9, { 'FNL'   , '001', 'FNK'  , 'FNK_ROTINA + FNK_REVIS', 'FNL_ROTINA + FNL_REVIS' ,'S','1', 'N', '', 'S', 'S' })
//
// Dominio FNH
//
aAdd( aSX9, {'FNH','001','FNL','FNH_ROTINA+FNH_OPER','FNL_ROTINA+FNL_OPER','S','1','N','','','S'} )
aAdd( aSX9, {'FNH','002','FNM','FNH_ROTINA','FNM_ROTINA','S','1','N','','','S'} )

//DOMINIO FNI
Aadd(aSX9,{"FNI"	,"001"	,"FNT"			,"FNI_CODIND"			,"FNT_CODIND"			,"S"			,"1"			,"N"			,""				,"S"			,"S"			})


DbSelectArea( 'SX9' )

For nI := 1 To Len( aSX9 )
	DbSetOrder( 2 )   
	If !SX9->( dbSeek( PadR( aSX9[nI][3], nTamSeek)+PadR( aSX9[nI][1], nTamSeek)))
		If !( aSX9[nI][1] $ cAlias )
			cAlias += aSX9[nI][1] + '/'
			cTexto += '  ' + aSX9[nI][1] +'/'+ aSX9[nI][3] + CRLF
		EndIf
		RecLock( 'SX9', .T. )
	Else
		If !( aSX9[nI][1] $ cAlias )
			cAlias += aSX9[nI][1] + '/'
			cTexto += '  ' + aSX9[nI][1] +'/'+ aSX9[nI][3] + CRLF
		EndIf
		RecLock( 'SX9', .F. )
	EndIf

	For nJ := 1 To Len( aSX9[nI] )
		If FieldPos( aEstrut[nJ] ) > 0
			FieldPut( FieldPos( aEstrut[nJ] ), aSX9[nI][nJ] )
		EndIf
	Next nJ

	dbCommit()
	MsUnLock()

Next nI

Return cTexto 

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥VdlAtf01  ∫Autor  ≥Microsiga           ∫ Data ≥  11/22/11   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Realiza a validaÁ„o do dicionario de dados                  ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ AP                                                        ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function VdlAtf01(cTexto)
Local lRet 		:= .T.
Local aArea		:= GetArea()
Local aAreaSIX	:= SIX->(GetArea())
Local nX			:= 0
Local aIndices := {}

SIX->(dbSetOrder(1)) //INDICE+ORDEM

aAdd(aIndices,{"SN1","8"})
aAdd(aIndices,{"SN3","A"})   
aAdd(aIndices,{"CV8","3"})   

For nX := 1 to Len(aIndices)
	If !SIX->(MsSeek(aIndices[nX][1] + aIndices[nX][2]))
		lRet := .F.
		cTexto := STR0080 +CRLF//"Indices da tabela de dados desatualizado, por favor executar os seguintes atualizadores:"
		cTexto += STR0081 +CRLF//"    U_UPDATF - Ativo Fixo - com data igual a superior 24/11/2011 " 
		cTexto += STR0082 +CRLF//"    U_UPDCTB - Contabilidade Gerencial -com data igual a superior 13/11/2011 " 
		Exit
	EndIf  
Next nX

RestArea(aAreaSIX)
RestArea(aArea)
Return lRet


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥SetHelp   ∫Autor  ≥Reynaldo Miyashita  ∫ Data ≥  30/11/2011 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ Inclui o help de campo/pergunte e grava log na variavel    ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ AP                                                        ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function SetHelp(cCampo ,aHlpPor, aHlpEng, aHlpSpa, lLogic, cTexto)

	cCampo := allTrim(cCampo)
	
	If left(cCampo,2) == "P." .OR. left(cCampo,2) == "S." 
		PutSX1Help( cCampo, aHlpPor, aHlpEng, aHlpSpa, lLogic )
		cCampo := right(cCampo ,Len(cCampo)-2)
		
	Else
		PutSX1Help( cCampo, aHlpPor, aHlpEng, aHlpSpa, lLogic )
		cCampo := Right(cCampo ,Len(cCampo)-1)
		
	EndIf
	cTexto += cCampo+"/ "
	
Return .T.

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ATFAtuSXG ≥ Autor ≥ --------------------- ≥ Data ≥ 18/06/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Funcao de processamento da gravacao do SXG                 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ATFAtuSXG()
Local aSXG   := {}
Local aEstrut:= {}
Local i      := 0
Local j      := 0
Local cTexto := ''
Local cAlias := ''
Local lSXG   := .F.

aEstrut:= { "XG_GRUPO","XG_DESCRI","XG_DESSPA","XG_DESENG","XG_SIZEMAX","XG_SIZEMIN","XG_SIZE","XG_PICTURE"}
			
AADD(aSXG,{"060","Codigo Indice depreciacao","Codigo indice depreciacion","Depreciation Index code",8,2,2,"@!"})

ProcRegua(Len(aSXG))


dbSelectArea("SXG")
dbSetOrder(1) // FUNCAO
For i:= 1 To Len(aSXG)
	If !Empty(aSXG[i][1])
		If !MsSeek(Padr(aSXG[i,1],Len(SXG->XG_GRUPO)))
			lSXG := .T.
			If !(aSXG[i,1]$cAlias)
				cAlias += aSXG[i,1]+"/"
			EndIf
			
			RecLock("SXG",.T.)
			
			For j:=1 To Len(aSXG[i])
				If !Empty(FieldName(FieldPos(aEstrut[j])))
					FieldPut(FieldPos(aEstrut[j]),aSXG[i,j])
				EndIf
			Next j
			
			dbCommit()
			MsUnLock()
			IncProc(STR0074)//"Atualizando grupo de campos"
		EndIf
	EndIf
Next i

If lSXG
	cTexto := STR0075+cAlias+CRLF //"Grupo de campos atualizados: "
EndIf

Return cTexto


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ATFAtuSX6 ≥ Autor ≥ --------------------- ≥ Data ≥ 23/05/07 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Funcao de processamento da gravacao do SX6                 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ATFAtuSX6()
//  X6_FIL   X6_VAR     X6_TIPO    X6_DESCRIC X6_DSCSPA  X6_DSCENG  X6_DESC1 X6_DSCSPA1 X6_DSCENG1
//  X6_DESC2 X6_DSCSPA2 X6_DSCENG2 X6_CONTEUD X6_CONTSPA X6_CONTENG X6_PROPRI

Local aSX6			:= {}
Local aSX6Alter		:= {}
Local aEstrut		:= {}
Local i				:= 0
Local j				:= 0
Local lSX6			:= .F.
Local cTexto 		:= ''
Local cAlias 		:= ''
Local nTamFilial 	:= AtfTamSXG( "033", TamSX3( "E2_FILIAL" )[1] )[1]

aEstrut:= { "X6_FIL","X6_VAR","X6_TIPO",;
			"X6_DESCRIC","X6_DSCSPA","X6_DSCENG",;
			"X6_DESC1","X6_DSCSPA1","X6_DSCENG1",;
			"X6_DESC2","X6_DSCSPA2","X6_DSCENG2",;
			"X6_CONTEUD","X6_CONTSPA","X6_CONTENG","X6_PROPRI","X6_PYME","X6_DEFPOR","X6_DEFSPA","X6_DEFENG"}



//Aceleracao da depreciacao em lote	
aAdd( aSX6, {SPACE(nTamFilial),'MV_ATFPROV','N','Quantidade de dias em relacao ao fim da provisao','Cant. de dias en relacion al fin de provision','Amount of days regarding the end of provision','para considerar o movimento de curto prazo.','para considerar movimiento a corto plazo','to consider the short term transaction','','','','365','365','365','S','S'} )																	 

//Ativo Custo/Provisao
aAdd( aSX6, {SPACE(nTamFilial),'MV_ATFSPRO','C','Considerar ativos de depreciaÁ„o gerencial','øConsidera los activos depreciacion de gestion','Consider management depreciation assets related to','relacionados a provisıes nos saldos cont·beis de','vinculados a provisiones en los saldos contables','provision in asset accounting balance?','ativos? (1- Sim/2-N„o)','en los saldos contables de activos? (1- Si/2-No)','(1- Yes/2-No)','1','1','1','S','S'} )
ProcRegua(Len(aSX6))

dbSelectArea("SX6")
dbSetOrder(1)
For i:= 1 To Len(aSX6)
	If !Empty(aSX6[i][2])
		If !MsSeek(aSX6[i,1]+aSX6[i,2])
			lSX6	:= .T.
			If !(aSX6[i,2]$cAlias)
				cAlias += aSX6[i,2]+"/"
			EndIf
			RecLock("SX6",.T.)
			For j:=1 To Len(aSX6[i])
				If !Empty(FieldName(FieldPos(aEstrut[j])))
					FieldPut(FieldPos(aEstrut[j]),aSX6[i,j])
				EndIf
			Next j
			
			dbCommit()
			MsUnLock()
			IncProc(STR0041) // //"Atualizando Parametros..."
		Else 
			// Altera apenas descriÁ„o de parametro
			lSX6	:= .T.
			RecLock("SX6",.F.)
			For j:=1 To Len(aSX6[i])
				If !Empty(FieldName(FieldPos(aEstrut[j])))				
					If Alltrim(aEstrut[j]) $ "X6_DESCRIC/X6_DSCSPA/X6_DSCENG/X6_DESC1/X6_DSCSPA1/X6_DSCENG1/X6_DESC2/X6_DSCSPA2/X6_DSCENG2" 
						FieldPut(FieldPos(aEstrut[j]),aSX6[i,j])
					EndIf
				EndIf
			Next j
			
			dbCommit()
			MsUnLock()
			IncProc(STR0041) // //"Atualizando Parametros..."		
		EndIf
	EndIf
Next i

For i:= 1 To Len(aSX6Alter)
	If !Empty(aSX6Alter[i][2])
		// N„o encontrou, ent„o inclui normalmente		
		If !dbSeek(aSX6Alter[i,1]+aSX6Alter[i,2])
			lSX6	:= .T.
			If !(aSX6Alter[i,2]$cAlias)
				cAlias += aSX6[i,2]+"/"
			EndIf
			RecLock("SX6",.T.)
			For j:=1 To Len(aSX6Alter[i])
				If !Empty(FieldName(FieldPos(aEstrut[j])))
					FieldPut(FieldPos(aEstrut[j]),aSX6Alter[i,j])
				EndIf
			Next j
			dbCommit()
			MsUnLock()
			IncProc(STR0041) // //"Atualizando Parametros..."
		Else // Encontrou, ent„o procede com a atualizacao
			lSX6	:= .T.
			If !(aSX6Alter[i,2]$cAlias)
				cAlias += aSX6[i,2]+"/"
			EndIf
			RecLock("SX6",.F.)
			For j:=1 To Len(aSX6Alter[i])
				If !Empty(FieldName(FieldPos(aEstrut[j])))
					FieldPut(FieldPos(aEstrut[j]),aSX6Alter[i,j])
				EndIf
			Next j
			dbCommit()
			MsUnLock()
			IncProc(STR0041) // //"Atualizando Parametros..."
		EndIf
	EndIf
Next i


If lSX6
	cTexto := STR0042+cAlias+CRLF //'Incluidos novos parametros. Verifique as suas configuracoes e funcionalidades : '
EndIf

Return cTexto

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥FNICompat ≥ Autor ≥Alvaro Camillo Neto      Data ≥ 08/11/12 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Realiza a compatibilizaÁ„o dos indice de depreciacao antigo≥±±
±±≥DescriáÖo ≥ complementando com a revis„o 0001 os indices antigos       ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function FNICompat()
Local aArea := GetArea()

If AliasInDic("FNI")
	dbSelectArea("FNI")
	If FNI->(FieldPos("FNI_REVIS")) > 0 .And. FNI->(FieldPos("FNI_STATUS")) > 0 
		FNI->(dbGotop())
		While FNI->(!EOF())
			If Empty(FNI->FNI_REVIS)
				RecLock("FNI",.F.)
					FNI->FNI_REVIS := "0001"
				MsUnLock()
			EndIf
			If Empty(FNI->FNI_STATUS)
				RecLock("FNI",.F.)
					FNI->FNI_STATUS := "1"
				MsUnLock()
			EndIf
			FNI->(dbSkip())
		EndDo
	EndIf
EndIf

RestArea(aArea)
Return

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥AjSXBFNI ≥ Autor≥ Raphael Rodrigues Ventura Data ≥ 06/12/13 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Verficar se a inclus„o est· habilitada na consulta padr„o  ≥±±
±±≥DescriáÖo ≥ "FNI" (tipo '3') no ambiente. Se estiver, a consulta ser·  ≥±±
±±≥DescriáÖo ≥ apagada para ser criada novamente.                         ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ ATUALIZACAO SIGAATF                                        ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function AjSXBFNI()

Local aArea := GetArea()
Local cAliFNI := PadR("FNI", 6)

DbSelectArea("SXB")
If SXB->(DbSeek(cAliFNI+"3"))
	SXB->(DbGoTop())
	SXB->(DbSeek(cAliFNI))
	Do While SXB->(!Eof()) .And. SXB->XB_ALIAS == cAliFNI
		RecLock("SXB",.F.)
		DbDelete() 
		MsUnLock()
		DbSkip()
	EndDo
EndIf

RestArea(aArea)

Return
