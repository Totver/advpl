/*
+-----------------------------------------------------------------------+
¦Programa  ¦RelCesDi   ¦ Autor ¦ Alecio Ferreira       ¦Data ¦05.10.2000¦
+----------+------------------------------------------------------------¦
¦Descriçào ¦ Contrato de Cessao de Direitos                             ¦
+----------+------------------------------------------------------------¦
¦ Uso      ¦ ESPECIfICO PARA TEndA                                      ¦
+-----------------------------------------------------------------------¦
¦           ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL            ¦
+-----------------------------------------------------------------------¦
¦PROGRAMADOR ¦ DATA   ¦ MOTIVO DA ALTERACAO                             ¦
+------------+--------+-------------------------------------------------¦
¦            ¦        ¦                                                 ¦
+-----------------------------------------------------------------------+
*/
#INCLUDE "rwmake.ch"
#Define CONDENSA CHR(27)+CHR(45)+CHR(48)+CHR(27)+CHR(87)+CHR(48)

User Function RelCesDi()

Private CbTxt     := ""
Private CbCont    := ""
Private nOrdem    := 0
Private Alfa      := 0
Private Z         := 0
Private M         := 0
Private tamanho   := "P"
Private limite    := 80 
Private titulo    := "Contrato de cessao de direitos"
Private cDesc1    := "Impressao Contrato de cessao de direitos"
Private cDesc2    := ""
Private cDesc3    := ""
Private aReturn   := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
Private nomeprog  := "RELCESDI"
Private nLastKey  := 0
Private lContinua := .T.
Private nLin      := 0
Private wnrel     := "RELCESDI"
Private cCabec1   := ""
Private cCabec2   := ""
Private lTestConf := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private cbtxt      := SPACE(10)
Private cbcont     := 0
Private m_pag      := 1
Private nMaxiLinh  := 59
Private nContLinh  := 60

Private nLastKey   := 0
Private aStru      := {}
Private cArq       := ""
Private cPerg      := ""
//Private aPerg      := {} 

Private cString    := "SZ6"
Private cString    := "SA1"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//Aadd(aPerg,{cPerg,"Contrato ?","C",06,0,"G","","SZ5","","","","",""})

//ExecBlock("TestSX1",.F.,.F.,{cPerg,aPerg})

//Pergunte(cPerg,.F.)

If (nLastKey == 27)
   Return
EndIf
                                                                      
wnrel := SetPrint(cString,wnrel,,Titulo,cDesc1,cDesc2,cDesc3,.F.) //,,.T.,tamanho)

If nLastKey == 27
   Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica Posicao do Formulario na Impressora                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                              ³
//³ Inicio do Processamento da Impressao                         ³
//³                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cCabecalho := "Impressao do Contrato de Cessao de Direitos"
cMsgRegua  := "Processando "

//   Processa( {|| Execute(FGravArq)} ,cCabecalho,cMsgRegua )
RptStatus( {||FImprime()} )

Set Device To Screen
dbCommitAll()
If aReturn[5] == 1
   Set Printer To
   ourspool(wnrel)
Endif

FT_PFLUSH()

RETURN


Static Function FImprime()
Local cEstCiv := ""

/*

dbSelectArea("SZ1") //Empreendimentos
dbSetOrder(1)
dbSeek(xFilial("SZ1")+SZ9->Z9_CodEmpr)

dbSelectArea("SA1") //Clientes
dbSetOrder(1)
dbSeek(xFilial("SA1")+SZ9->Z9_ClieAtu+SZ9->Z9_LojaAtu)

Do Case
	Case A1_EstCiv == "C"
		cEstCiv := "Casado(a)"
	Case A1_EstCiv == "D"
		cEstCiv := "Divorciado(a)"
	Case A1_EstCiv == "S"
		cEstCiv := "Solteiro(a)"
EndCase

dbSelectArea("SZ6") //Contratos
dbSetOrder(2)
dbSeek(xFilial("SZ6")+SZ9->Z9_ClieAtu+SZ9->Z9_LojaAtu+SZ9->Z9_CodEmpr+SZ9->Z9_CodBloc+SZ9->Z9_CodUnid)

dbSelectArea("SZ2")
dbSetOrder(1)
dbSeek(xFilial("SZ2")+SZ6->Z6_CodEmpr+SZ6->Z6_CodBloc)

*/

cEstCiv := "Casado"

For xCo := 1 To 1 //2
   nLin := 06
// @ nLin,000 PSAY CHR(27)+CHR(45)+CHR(48)+CHR(27)+CHR(87)+CHR(48) 

   //CHR(27)+CHR(040)+CHR(115)+CHR(052)+CHR(083)+CHR(115)

   @ nLin,025 PSAY "CONTRATO DE CESSAO DE DIREITOS"
   @ nLin,000 PSAY Replicate("-",80)
   nLin += 2
   @ ++nLin,000 PSAY "Contrato de Cessao de Direitos que fazem de um lado, como:"
   @ ++nLin,000 PSAY "Cedente:     "
   @   nLin,015 PSAY SA1->A1_Nome  // +"          "+SZ9->Z9_ClieAtu
   @ ++nLin,015 PSAY cEstCiv // SA1->A1_Nascio+"  -  "+cEstCiv+"   -   "+SA1->A1_Car
	@ ++nLin,015 PSAY "Identidade: "+SA1->A1_Rg+"    CPF: "+SA1->A1_Cgc
	@ ++nLin,015 PSAY "Endereco  : "+SA1->A1_End
	@ ++nLin,015 PSAY "            "+Alltrim(SA1->A1_Bairro)+"  -  "+Alltrim(SA1->A1_Mun)+ " - "+SA1->A1_Est
	nLin+=2
	@ ++nLin,000 PSAY "e do outro lado, como:"
	@ ++nLin,000 PSAY "Cessionario: "

// dbSelectArea("SA1")
// dbSeek(xFilial("SA1")+SZ9->Z9_ClieNov+SZ9->Z9_LojaNov)

   @   nLin,015 PSAY SA1->A1_Nome //  +"          "+SZ9->Z9_ClieAtu
   @ ++nLin,015 PSAY cEstCiv // SA1->A1_Nascio+"  -  "+cEstCiv+"   -   "+SA1->A1_Car
	@ ++nLin,015 PSAY "Identidade: "+SA1->A1_Rg+"    CPF: "+SA1->A1_Cgc
	@ ++nLin,015 PSAY "Endereco  : "+SA1->A1_End
	@ ++nLin,015 PSAY "            "+Alltrim(SA1->A1_Bairro)+"  -  "+Alltrim(SA1->A1_Mun)+ " - "+SA1->A1_Est
	nLin++
   @ ++nLin,000 PSAY "tendo como Interveniente: CONSTRUTORA TENDA S/A, com endereço  nesta  capital  a"
   @ ++nLin,000 PSAY "Av.  Nossa  Senhora  do  Carmo,  900 -  Bairro  Sion,  inscrito  no CNPJ 71.476."
   @ ++nLin,000 PSAY "527/00001-35, de acordo com as cláusulas e condições que mutuamente estipulam  e"
   @ ++nLin,000 PSAY "as outorgam:"
	nLin+=2
	@ ++nLin,032 PSAY "CLAUSULA PRIMEIRA"
	nLin+=1                              
	@ ++nLin,000 PSAY "O presente contrato tem por objetivo a cessão dos direitos e obrigações, aquisi-"
	@ ++nLin,000 PSAY "tivos e correlatos, de promessa de compra e venda, de forma definitiva e irrevo-"
	@ ++nLin,000 PSAY "gável e irretratável  sem  cláusula  de  arrependimento,  relativos  ao Contrato"
	@ ++nLin,000 PSAY "Particular de Promessa de Compra  e  Venda,  tendo  como  Promitente  Vendedora:"
	@ ++nLin,000 PSAY "CONSTRUTORA TENDA S/A, como legítima proprietária, possuidora livre e desembara-"
	@ ++nLin,000 PSAY "çada de quaisquer ônus ou gravames, mesmo hipotecários, do apartamento 1, " // +SZ9->Z9_CodUnid+","
	@ ++nLin,000 PSAY "Bloco 1 "// +SZ9->Z9_CodBloc+", "+Alltrim(SZ1->Z1_DesEmpr)+", Situado a "+Alltrim(SZ1->Z1_EndEmpr)+", " 
//	@ ++nLin,000 PSAY Alltrim(SZ1->Z1_BaiEmpr)+", "+Alltrim(SZ1->Z1_MunEmpr)+" - "+SZ1->Z1_EstEmpr+"."
	nLin+=2
	@ ++nLin,033 PSAY "CLAUSULA SEGUNDA"
	nLin+=1                              
	@ ++nLin,000 PSAY "Os direitos e obrigações do Cedente são  oriundos  do  Contrato  Particular   de"
	@ ++nLin,000 PSAY "Promessa de Compra e Venda, realizado entre o Cedente e a  Promitente Vendedora,"
// ++nLin,000 PSAY "datado de "+Dtoc(SZ6->Z6_DtVenda)+"."
	@ ++nLin,000 PSAY "datado de "+Dtoc(dDataBase)+"."
	nLin+=2
	@ ++nLin,032 PSAY "CLAUSULA TERCEIRA"
	nLin+=1                              
	@ ++nLin,000 PSAY "Fica o Cessionário sub-rogado em todos os direitos e  obrigações  outorgados  ao" 
	@ ++nLin,000 PSAY "Cedente através do Contrato Particular de Promessa de Compra e Venda  datado  de"
// @ ++nLin,000 PSAY Dtoc(SZ6->Z6_DtVenda)+", inclusive quanto a ivicção.Fica o Cessionário sub-rogado em todos"
   @ ++nLin,000 PSAY Dtoc(dDataBase)+", inclusive quanto a ivicção.Fica o Cessionário sub-rogado em todos"
	@ ++nLin,000 PSAY "os direitos e obrigações outorgados ao Cedente através do Contrato Particular de"
	@ ++nLin,000 PSAY "Promessa de Compra e Venda datado de "+Dtoc(dDataBase)+", inclusive quanto a ivicção."
// @ ++nLin,000 PSAY "Promessa de Compra e Venda datado de "+Dtoc(SZ6->Z6_DtVenda)+", inclusive quanto a ivicção."
	nLin+=2
	@ ++nLin,033 PSAY "CLAUSULA QUARTA"
	nLin+=1                              
	@ ++nLin,000 PSAY "As benfeitorias que figuram no imóvel são aqui negociadas  ao  estado em  que se"
	@ ++nLin,000 PSAY "encontram atualmente, e que são do conhecimento do Cessionário."
	nLin+=2
	@ ++nLin,033 PSAY "CLAUSULA QUINTA"
	nLin+=1                              
	@ ++nLin,000 PSAY "O presente contrato de cessão de direitos obriga as partes em todo o  tempo  por"
	@ ++nLin,000 PSAY "si seus herdeiros e/ou sucessores pelas cláusulas  aqui  estipuladas,  bem  como"
	@ ++nLin,000 PSAY "aquelas constantes no Contrato Particular de Promessa de Compra e Venda, do qual"
	@ ++nLin,000 PSAY "este faz parte integrante."
	nLin+=2
	@ ++nLin,033 PSAY "CLAUSULA SEXTA"
	nLin+=1                              
	@ ++nLin,000 PSAY "Elegem o foro da comarca de  Belo  Horizonte,  para  dirimir  quaisquer  dúvidas"
	@ ++nLin,000 PSAY "oriundas deste contrato."
	nLin+=2
	@ ++nLin,000 PSAY "E por estarem assim, justas e contratadas, assinam inclusive os herdeiros, o pre"
	@ ++nLin,000 PSAY "sente instrumento em 02(Duas) vias de igual valor e teor."
   nLin+=2
   @ ++nLin,000 PSAY "Belo Horizonte, "+Str(Day(dDataBase),2)+" de "+MesExtenso(Month(dDataBase))+ " de "+Str(Year(dDataBase),4)
	nLin+=3

// dbSelectArea("SA1")
// dbSeek(xFilial("SA1")+SZ9->Z9_ClieAtu+SZ9->Z9_LojaAtu)

	@ ++nLin,000 PSAY "Cedente:        ________________________________"
	@ ++nLin,000 PSAY "                   "+SA1->A1_Nome
	nLin+=3

// dbSelectArea("SA1")
// dbSeek(xFilial("SA1")+SZ9->Z9_ClieNov+SZ9->Z9_LojaNov)

	@ ++nLin,000 PSAY "Cessionario:    ________________________________"	
	@ ++nLin,000 PSAY "                   "+SA1->A1_Nome		
	nLin+=3
	@ ++nLin,000 PSAY "Interveniente:  ________________________________"	
	@ ++nLin,000 PSAY "                    CONTRUTORA TENDA S/A"
	nLin+=3	
	@ ++nLin,000 PSAY "Testemunhas:"
	nLin+=2			
	@ ++nLin,000 PSAY "___________________________________          ___________________________________"
	@ ++nLin,000 PSAY "       Peterson Rosa Querino                            Ricardo Guedes
	__Eject()
Next

Return
