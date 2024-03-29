#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 22/03/00
#include 'MsOle.ch'

User Function Prjr240()        // incluido pelo assistente de conversao do AP5 IDE em 22/03/00

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CDT1,CDT2,CDT3,NCONTADOR,CTEXTO1,CTEXTO2")
SetPrvt("CTEXTO3,CTEXTO4,CTEXTO5,CTEXTO6,CMEMO,NLINES")
SetPrvt("NVALOR1,NVALOR2,NVALOR3,NVALOR4,NVALOR5,CVENC1")
SetPrvt("CVENC2,CVENC3,CVENC4,CVENC5,CTYPE")
SetPrvt("CARQUIVO,HWORD,")

// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 22/03/00 ==> #include 'MsOle.ch'
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    � ATFA240  � Autor � Frank Zwarg Fuga      � Data � 10.03.00 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o � Relatorio orcamento              - VIA WORD ( MICROSIGA )  낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Especifico SigaProj                                        낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴눙�
굇� Revis꼘  �                                          � Data �          낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Parametros usados na rotina                   �
//� mv_par01         numero do orcamento          �
//� mv_par02         numero de vias               �
//� mv_par03         comentarios fax              �
//� mv_par04         enviado por                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
Pergunte("PRJWOR",.F.)

@ 96,012 TO 250,400 DIALOG oDlg TITLE OemToAnsi("Integracao com MS-Word")
@ 08,005 TO 048,190
@ 18,010 SAY OemToAnsi("Esta rotina ira imprimir os orcamentos conforme os parametros digitados.")

@ 56,100 BMPBUTTON TYPE 5 ACTION Pergunte("PRJWOR",.T.)
@ 56,130 BMPBUTTON TYPE 1 ACTION WordImp()// Substituido pelo assistente de conversao do AP5 IDE em 22/03/00 ==> @ 56,130 BMPBUTTON TYPE 1 ACTION Execute(WordImp)
@ 56,160 BMPBUTTON TYPE 2 ACTION Close(oDlg)

ACTIVATE DIALOG oDlg CENTERED

Return

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    � WORDIMP  � Autor � Frank Zwarg Fuga      � Data � 10.03.00 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o � Relatorio orcamento               - VIA WORD ( MICROSIGA ) 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Especifico - Sigaproj                                      낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴눙�
굇� Revis꼘  �                                          � Data �          낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 22/03/00 ==> Function WordImp
Static Function WordImp()

Local nTotal := 0

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Busca o orcamento conforme parametro �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
dbSelectArea("SCJ")
dbSetOrder(1)
dbSeek(xFilial()+MV_PAR01)
If Eof()
   MsgStop(OemToAnsi("Or놹mento nao encontrado"))
   Return Nil
EndIf

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Pesquisar no arquivo de clientes �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
dbSelectArea("SA1")
dbSetOrder(1)
dbSeek(xFilial() + SCJ->CJ_CLIENTE)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Preparacao para a data do orcamento �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

cDt1 := AllTrim(Str(Day(SCJ->CJ_EMISSAO)))
cDt2 := Month(SCJ->CJ_EMISSAO)

If cDt2 == 1
   cDt2 := "Janeiro"
Elseif cDt2 == 2
   cDt2 := "Fevereiro"
Elseif cDt2 == 3
   cDt2 := "Marco"
Elseif cDt2 == 4
   cDt2 := "Abril"
Elseif cDt2 == 5
   cDt2 := "Maio"
Elseif cDt2 == 6
   cDt2 := "Junho"
Elseif cDt2 == 7
   cDt2 := "Julho"
Elseif cDt2 == 8
   cDt2 := "Agosto"
Elseif cDt2 == 9
   cDt2 := "Setembro"
Elseif cDt2 == 10
   cDt2 := "Outubro"
Elseif cDt2 == 11
   cDt2 := "Novembro"
Elseif cDt2 == 12
   cDt2 := "Dezembro"
Else
   cDt2 := ""
EndIF

cDt3    := Str(Year(SCJ->CJ_EMISSAO))
cTexto1 :=" "
cTexto2 :=" "
cTexto3 :=" "
cTexto4 :=" "
cTexto5 :=" "
cTexto6 :=" "
nValor1 :=0
nValor2 :=0
nValor3 :=0
nValor4 :=0
nValor5 :=0
cVenc1  :=" "
cVenc2  :=" "
cVenc3  :=" "
cVenc4  :=" "
cVenc5  :=" "

dbSelectArea("SCK")
dbSetOrder(1)
DbSeek(xFilial() + MV_PAR01)
While CK_NUM == MV_PAR01 .And. ! Eof()
	nTotal += CK_VALOR
	DbSkip()
Enddo


If MsgYesNo("Procura arquivo")
   cArquivo := cGetFile("Documentos  (*.DO*)        | *.DO* | ",;
    			         	 "Dialogo de Selecao de Arquivos")
Else
	cArquivo := "C:\Siga\Ap5\Imagens\SigaProj.Dot"
Endif	


//旼컴컴컴컴컴컴컴�
//� Inicia o Word �
//읕컴컴컴컴컴컴컴�

hWord := OLE_CreateLink()   
// OLE_SetPropertie( hWord, oleWdPrintBack, .F.)
// OLE_SetPropertie( hWord, oleWdVisible, .T.)
// OLE_NewFile(hWord, cArquivo)   
OLE_OpenFile(hWord, cArquivo)   
OLE_SetDocumentVar(hWord, 'adv_Var0001', SA1->A1_CONTATO)
OLE_SetDocumentVar(hWord, 'Adv_Var0002', SA1->A1_NOME)
OLE_SetDocumentVar(hWord, 'Adv_Var0003', SA1->A1_END)
OLE_SetDocumentVar(hWord, 'Adv_Var0004', SA1->A1_MUN)
OLE_SetDocumentVar(hWord, 'Adv_Var0005', SA1->A1_TEL)
OLE_SetDocumentVar(hWord, 'Adv_Var0006', SA1->A1_FAX)
OLE_SetDocumentVar(hWord, 'Adv_Var0007', STRZERO(VAL(SA1->A1_COD),6,0) + " - " + SA1->A1_NOME)
OLE_SetDocumentVar(hWord, 'Adv_Var0008', Transform(nTotal, "@E 999,999,999.99"))
OLE_SetDocumentVar(hWord, 'Adv_Var0009', " ")
OLE_SetDocumentVar(hWord, 'Adv_Var0010', 0)
OLE_SetDocumentVar(hWord, 'Adv_Var0011', 0)
OLE_SetDocumentVar(hWord, 'Adv_Var0012', "Nao se aplica")
OLE_SetDocumentVar(hWord, 'Adv_Var0013', Dtoc(Date()))
If !Empty(MV_PAR03)
   OLE_SetDocumentVar(hWord, 'Adv_Var0014', MV_PAR03)
Else
   OLE_SetDocumentVar(hWord, 'Adv_Var0014', " ")
EndIf
If !Empty(cDt1)
   OLE_SetDocumentVar(hWord, 'Adv_Var0015', cDt1)
Else
   OLE_SetDocumentVar(hWord, 'Adv_Var0015', " ")
EndIF
If !Empty(cDt2)
   OLE_SetDocumentVar(hWord, 'Adv_Var0016', cDt2)
Else
   OLE_SetDocumentVar(hWord, 'Adv_Var0016', " ")
EndIF
If !Empty(cDt3)
   OLE_SetDocumentVar(hWord, 'Adv_Var0017', cDt3)
Else
   OLE_SetDocumentVar(hWord, 'Adv_Var0017', " ")
EndIF
If !Empty(MV_PAR04)
   OLE_SetDocumentVar(hWord, 'Adv_Var0018', MV_PAR04)
Else
   OLE_SetDocumentVar(hWord, 'Adv_Var0018', " ")
EndIF
OLE_SetDocumentVar(hWord, 'Adv_Var0019', SCJ->CJ_NUM)
OLE_SetDocumentVar(hWord, 'Adv_Var0020', cTexto1)
OLE_SetDocumentVar(hWord, 'Adv_Var0021', cTexto2)
OLE_SetDocumentVar(hWord, 'Adv_Var0022', cTexto3)
OLE_SetDocumentVar(hWord, 'Adv_Var0023', cTexto4)
OLE_SetDocumentVar(hWord, 'Adv_Var0024', cTexto5)
OLE_SetDocumentVar(hWord, 'Adv_Var0025', cTexto6)

If nValor1 > 0
   OLE_SetDocumentVar(hWord, 'Adv_Var0026', "R$ " +;
   		   Transform(nValor1, "@E 999,999.99"))
Else
   OLE_SetDocumentVar(hWord, 'Adv_Var0026', " ")
EndIF
If nValor2 > 0
   OLE_SetDocumentVar(hWord, 'Adv_Var0027', "R$ " +;
   		   Transform(nValor2, "@E 999,999.99"))
Else
   OLE_SetDocumentVar(hWord, 'Adv_Var0027'," ")
EndIF
If nValor3 > 0
   OLE_SetDocumentVar(hWord, 'Adv_Var0028', "R$ " +;
   		 Transform(nValor3,"@E 999,999.99"))
Else
   OLE_SetDocumentVar(hWord, 'Adv_Var0028'," ")
EndIF
If nValor4 > 0
   OLE_SetDocumentVar(hWord, 'Adv_Var0029', "R$ " +;
   		   Transform(nValor4,"@E 999,999.99"))
Else
   OLE_SetDocumentVar(hWord, 'Adv_Var0029'," ")
EndIF
If nValor5 > 0
   OLE_SetDocumentVar(hWord, 'Adv_Var0030', "R$ " +;
   		   Transform(nValor5,"@E 999,999.99"))
Else
   OLE_SetDocumentVar(hWord, 'Adv_Var0030'," ")
EndIF
OLE_SetDocumentVar(hWord, 'Adv_Var0031', cVenc1)
OLE_SetDocumentVar(hWord, 'Adv_Var0032', cVenc2)
OLE_SetDocumentVar(hWord, 'Adv_Var0033', cVenc3)
OLE_SetDocumentVar(hWord, 'Adv_Var0034', cVenc4)
OLE_SetDocumentVar(hWord, 'Adv_Var0035', cVenc5)
OLE_SetDocumentVar(hWord, 'Adv_Var0036', Transform(0, "999999"))
OLE_SetDocumentVar(hWord, 'Adv_Var0037', Transform(nTotal,"@E 999,999.99"))
OLE_SetDocumentVar(hWord, 'Adv_Var0038', Dtoc(Date()))
OLE_SetDocumentVar(hWord, 'Adv_Var0039', "")
OLE_UpdateFields( hWord )

//旼컴컴컴컴컴컴컴커
//� Qtde de Copias �
//읕컴컴컴컴컴컴컴켸
    
If MsgYesNo("Imprime o Orcamento ?")
	OLE_PrintFile( hWord, 'PART', 1, 1, mv_par02)
Endif	
If MsgYesNo("Fecha o Word e Corta o Link ?")
	OLE_CloseFile( hWord )
	OLE_CloseLink( hWord )
Endif	

Close(oDlg)

Return