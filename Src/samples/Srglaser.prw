#IFDEF Protheus
#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 31/10/00
#IFNDEF WINDOWS        
  #DEFINE  PSAY SAY
#ENDIF

User Function Srglaser()        // incluido pelo assistente de conversao do AP5 IDE em 31/10/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("TITULO,CDESC,WNREL,AORD,ARETURN,CSTRING")
SetPrvt("CPERG,NTAMANHO,NLASTKEY,NLIN,LEND,AROTOP")
SetPrvt("LIMPRT,LIMITE,CBCONT,NQUANTITEM,CDESCRI,NLIMITE")
SetPrvt("NQUANT,NOMEPROG,NTIPO,CQTD,CBTXT,ESC")
SetPrvt("NULL,PRINTER,HEIGHT,SMALL_BAR,WIDE_BAR,DPL")
SetPrvt("NB,WB,NS,WS,CHAR25,_CFIXO1")
SetPrvt("_CFIXO2,_CFIXO3,_BARCOD,NSOMAGER,NI,CCALCDV")
SetPrvt("_CBLOCO,NSOMA1,NSOMA2,NSOMA3,_FIXVAR,_NRES")
SetPrvt("CSOMA1,CSOMA2,CSOMA3,NSOMANN,_VARFIX,CCALCDVNN")
SetPrvt("_CODE,_CBAR,_NX,_NNRO,_CBARX,_NY")
SetPrvt("_JRS,_CNUMERO,_CNN1,_CDIGITO,_NOSSONUM,_SALIAS")
SetPrvt("AREGS,I,J,")
#Endif

#IFNDEF WINDOWS        
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 31/10/00 ==>   #DEFINE  PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³  CODBAR  º Autor ³ SANDRO                 º Data ³ 01/09/99º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Emissao de C¢digos de Barras em Impressora Laser           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºObservacao³ Somente para Default Windows e SIGAWIN                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Titulo   := OemToAnsi("Boletos Bancarios")
cDesc    := OemToAnsi("Este programa ira imprimir Boletos Bancarios")
wnrel    := "BOLSREG"
aOrd     := {}
aReturn  := { "Zebrado", 1,"Administracao", 2, 2, 1, "",2 }
cString  := "SE1"
cPerg    := "DSFI02"
nTamanho := ""
nLastKey := 0
nLin     := 0
lEnd     := .F.
aRotOP   := {}
lImpRt   := .F.  // Flag para impressao do Roteiro de Operacao
limite   := 80
nLastKey :=0
// Tamanho  := "P" pode ser criado a variavel conteudo P/M/L
// P - Retrato - M - Retrato/Paisagem - L - LandScape

ValidPerg()
Pergunte(cPerg,.f.)
wnrel    :=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc,"","",.F.,"",.F.,"P",.F.)
// O problema estava no parametro 12, está sendo passado tamanho como branco
// P indica portrait o boleto não estava sendo impresso corretamente pois estava
// sendo tentado imprimir como landscape
	
nLastKey :=IIf(LastKey()==27,27,nLastKey)
If nLastKey == 27
	Return
Endif
SetDefault(aReturn,cString)
@ nLin,000 PSAY aValImp(Limite)

*************** Compatibilizacao para Windows e DOS ***********************
#IFDEF WINDOWS
	#IFDEF PROTHEUS
	   RptStatus( {|| Imprime() }, Titulo )// Substituido pelo assistente de conversao do AP5 IDE em 31/10/00 ==> RptStatus( {|| Execute(Imprime) }, Titulo )
		Return
		Static Function Imprime
  	#ELSE
  	   RptStatus( {|| Execute(Imprime) }, Titulo )
  		Return
  		Function Imprime
  	#ENDIF
#ENDIF

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Imprime   ³ Autor ³ Jaime Ranulfo Leite F ³ Data ³ 29/12/99 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  

CbCont     := ""
nQuantItem := 0
cDescri    := ""
nlimite    := 150 //80
nQuant     := 1
nomeprog   := "OPSIS"
nTipo      := 18
cQtd       := ""
cbtxt      := SPACE(10)
cbcont     := 0

*******************************************************************************************
**** Preparacao Inicio
******************************************************************************
esc       := CHR(27)
null      := ""
PRINTER   := "L"
height    := 2.5  && 2
small_bar := 4.2                               && number of points per bar  3
wide_bar  := ROUND(small_bar * 2.25,0)         && 2.25 x small_bar
dpl       := 50                                && dots per line 300dpi/6lpi = 50dpl
nb := esc+"*c"+TRANSFORM(small_bar,'99')+"a"+Alltrim(STR(height*dpl))+"b0P"+esc+"*p+"+TRANSFORM(small_bar,'99')+"X"
wb := esc+"*c"+TRANSFORM(wide_bar,'99')+"a"+Alltrim(STR(height*dpl))+"b0P"+esc+"*p+"+TRANSFORM(wide_bar,'99')+"X"
ns := esc+"*p+"+TRANSFORM(small_bar,'99')+"X"
ws := esc+"*p+"+TRANSFORM(wide_bar,'99')+"X"
char25 := {}
AADD(char25,"10001")       && "1"
AADD(char25,"01001")       && "2"
AADD(char25,"11000")       && "3"
AADD(char25,"00101")       && "4"
AADD(char25,"10100")       && "5"
AADD(char25,"01100")       && "6"
AADD(char25,"00011")       && "7"
AADD(char25,"10010")       && "8"
AADD(char25,"01010")       && "9"
AADD(char25,"00110")       && "0"
_cFixo1   := "4329876543298765432987654329876543298765432"
_cFixo2   := "21212121212121212121212121212"
_cFixo3   := "3298765432"
******************************************************************************
* Preparacao Fim
******************************************************************************
DbSelectArea("SE1")
DbSetOrder(1)
DbSeek(xFilial("SE1")+MV_PAR01+MV_PAR03,.T.)
Set Century On
SetRegua(RecCount())
Do While SE1->E1_FILIAL+SE1->E1_PREFIXO+SE1->E1_NUM <= ;
	 xFilial("SE1")+MV_PAR02+MV_PAR04 .AND. !Eof()
	  
   IncRegua()

   NOSSONUM()  // Calcula e grava Nosso Numero 
   
* Filtro  ********************************************************************
   If SE1->E1_EMISSAO < MV_PAR05 .Or. SE1->E1_EMISSAO > MV_PAR06 .Or.;
      SE1->E1_VENCTO  < MV_PAR07 .Or. SE1->E1_VENCTO  > MV_PAR08 .Or.;
      SE1->E1_CLIENTE < MV_PAR09 .Or. SE1->E1_CLIENTE > MV_PAR11 .Or.;
      SE1->E1_LOJA    < MV_PAR10 .Or. SE1->E1_LOJA    > MV_PAR12 .Or.;
      Empty(SE1->E1_NUMBCO)             // E necessario o "Nosso Numero" informado.
      DbSkip()
      Loop
   EndIf

* Montagem do Codigo de Barras ***********************************************
   _BarCod := "409"                                      && Banco
   _BarCod := _BarCod + "9"                              && Moeda (no banco)
   _BarCod := _BarCod + StrZero((SE1->E1_VALOR*100),14)  && Valor
   _BarCod := _BarCod + Left(SE1->E1_NUMBCO,10)          && Nosso Numero
   _BarCod := _BarCod + "0352"                           && Agenciasa
   _BarCod := _BarCod + "003"                            && Uso do Banco
   _BarCod := _BarCod + "100877-5"                       && Nro.Conta Corrente    //Utiliza o "-" c/ o digito ??

* Calculo do DV Geral ********************************************************
   nSomaGer := 0
   For nI := 1 to 43
       nSomaGer := nSomaGer + ;
       (Val(Substr(_BarCod,nI,1))*Val(Substr(_cFixo1,nI,1)))
   Next
   If (11-(nSomaGer%11)) > 9
      cCalcDv := "1"
   Else
      cCalcDv := Str(11-(nSomaGer%11),1)
   Endif
   _BarCod := Left(_BarCod ,4) + cCalcDv + Right(_BarCod,39)
 
* Monta sequencia de codigos para o topo do boleto ***************************
   _cBloco := Left(_BarCod,4) + Substr(_BarCod,20,5) +;
	      Substr(_BarCod,25,10) + Substr(_BarCod,35,10)

   nSoma1 := 0
   nSoma2 := 0
   nSoma3 := 0
 
* Calcula o DV do primeiro Bloco *********************************************
   _FixVar := Right(_cFixo2,9)
   For nI := 1 to 9
       _nRes := Val(Substr(_cBloco,nI,1))*Val(Substr(_cFixo2,nI,1))
       If _nRes > 9
	  _nRes := 1 + (_nRes-10)
       Endif
       nSoma1 := nSoma1 + _nRes
   Next
 
* Calcula o DV do segundo bloco **********************************************
   _FixVar := Right(_cFixo2,10)
   For nI := 10 to 19
       _nRes := Val(Substr(_cBloco,nI,1))*Val(Substr(_cFixo2,nI,1))
       If _nRes > 9
	  _nRes := 1 + (_nRes-10)
       Endif
       nSoma2 := nSoma2 + _nRes 
   Next

******************************************************************************
** Calcula o DV do terceiro Bloco
******************************************************************************
   _FixVar := Right(_cFixo2,10)
   For nI := 20 to 29
       _nRes := Val(Substr(_cBloco,nI,1))*Val(Substr(_cFixo2,nI,1))
       If _nRes > 9
	  _nRes := 1 + (_nRes-10)
       Endif
       nSoma3 := nSoma3 + _nRes
   Next
   cSoma1 := Right(StrZero(10-(nSoma1%10),2),1)
   cSoma2 := Right(StrZero(10-(nSoma2%10),2),1)
   cSoma3 := Right(StrZero(10-(nSoma3%10),2),1) 
 
******************************************************************************
**  Monta sequencia de codigos para o topo do boleto com os dvs e o valor
******************************************************************************
   _cBloco := Left(_BarCod,4) + Substr(_BarCod,20,5) + cSoma1 +;
	      Substr(_BarCod,25,10) + cSoma2+ Substr(_BarCod,35,10)+ cSoma3 +;
	      cCalcDv + AllTrim(Str((SE1->E1_VALOR*100),14))

**** Calcula o DAC do Nosso N£mero *******************************************
   nSomaNN := 0
   _VarFix := Right(_cFixo1,10)
   For nI := 1 to 10
       nSomaNN := nSomaNN + ;
       (Val(Substr(SE1->E1_NUMBCO,nI,1))*Val(Substr(_VarFix,nI,1)))
   Next
   If (11-(nSomaNN%11)) > 9
      cCalcDvNN := "0"
   Else
      cCalcDvNN := Str(11-(nSomaNN%11),1)
   Endif

*********** Monta String do codigo de barras propriamente dito ***************
_code := ""
_cBar := _BarCod
For _nX := 1 to 43 Step 2 && 44 porque o meu cod.possue 44 numeros
	 _nNro := VAl(Substr(_cBar,_nx,1))
	 If _nNro == 0
	    _nNro := 10
	 EndIf
	 _cBarx := char25[_nNro]
	 _nNro := VAl(Substr(_cBar,_nx+1,1))
	 If _nNro == 0
	    _nNro := 10
	 EndIf
	 _cBarx := _cBarx + char25[_nNro]
	 For _nY := 1 to 5
	     If Substr(_cBarx,_nY,1) == "0"
		// Uso Barra estreita
		_code := _code + nb
	     Else
		// Uso Barra larga
		_code := _code + wb
	     EndIf
	     If Substr(_cBarx,_nY+5,1) == "0"
		// Uso Espaco estreito
		_code := _code + ns
	     Else
		// Uso Espaco Largo
		_code := _code + ws
	     EndIf
	 Next
Next
_code := nb+ns+nb+ns+_code+wb+ns+nb

******************************************************************************
**  Impressao
******************************************************************************
   @ 00,000 PSAY "E"
   @ 00,000 PSAY "(12U(s1p30v1s3b4168T" +  "  UNIBANCO"
   @ 00,000 PSAY "(12U(s1p10v1s3b4168T" +  "                                                                                                                                       RECIBO DO SACADO"
   @ 01,000 PSAY "(12U(s1p5v1s3b4168T" +  "                              UNIBANCO"
   @ 02,000 PSAY "(12U(s1p18v1s3b4168T" +  "                                                                             "
   @ 03,000 PSAY "(s0p20h6v0s0b3T"+Chr(38)+"l12D"
   @ 03,000 PSAY ""
   @ 03,003 PSAY "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ "
   @ 04,003 PSAY "³ Cedente:           MULLER MARTINI BRASIL COM. E REPRES. LTDA   ³  Sacado "
   @ 04,082 PSAY SA1->A1_NOME
   @ 04,149 PSAY "³"
   @ 05,003 PSAY "³ Ag./Conta Corrente: 0352/100877-5                              ³                                                                                ³"
   @ 06,003 PSAY "³ Data do Documento:"
   @ 06,025 PSAY SE1->E1_EMISSAO
   @ 06,068 PSAY "³  Endere‡o : " + SA1->A1_END
   @ 06,149 PSAY "³"
   @ 07,003 PSAY "³ Nosso N£mero:       "+AllTrim(SE1->E1_NUMBCO)+"-"+cCalcDvNN
   @ 07,068 PSAY "³"
   @ 07,082 PSAY SA1->A1_BAIRRO
   @ 07,149 PSAY "³"
   @ 08,003 PSAY "³ N.do Documento:     "+SE1->E1_NUM+If(!Empty(SE1->E1_PARCELA),"-"+SE1->E1_PARCELA,"")
   @ 08,068 PSAY "³  CEP :      "+ SA1->A1_CEP
   @ 08,149 PSAY "³"
   @ 09,003 PSAY "³ Esp‚cie Doc.:       OU"
   @ 09,068 PSAY "³"
   @ 09,149 PSAY "³"
   @ 10,003 PSAY "³ Carteira :          SR"
   @ 10,068 PSAY "³  Cidade :   "+AllTrim(SA1->A1_MUN)+ " - "+SA1->A1_EST
   @ 10,149 PSAY "³"
   @ 11,003 PSAY "³ Aceite :            N"
   @ 11,068 PSAY "³"
   @ 11,149 PSAY "³"
   @ 12,003 PSAY "³ Esp‚cie :           R$"
   @ 12,068 PSAY "³"
   @ 12,149 PSAY "³"
   @ 13,003 PSAY "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ "
   @ 14,003 PSAY "³ Texto de responsabilidade do cedente:"
   @ 14,149 PSAY "³"
   @ 15,003 PSAY "³   Nao Receber apos 15 dias"
   @ 15,149 PSAY "³"
   @ 16,003 PSAY "³   Apos vencimento cobrar multa de 2%"
   @ 16,149 PSAY "³"
   @ 17,003 PSAY "³   Apos 5 dias cobrar mora de 0,134% ao dia"
   @ 17,149 PSAY "³"
   @ 18,003 PSAY "³"
   @ 18,149 PSAY "³"
   @ 19,003 PSAY "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ "
   @ 20,003 PSAY "³ Vencimento :"
   @ 20,018 PSAY SE1->E1_VENCTO
   @ 20,034 PSAY "Valor do Documento :"
   @ 20,055 PSAY SE1->E1_VALOR PICTURE "@E 999,999.99"
   @ 20,068 PSAY "³   AUTENTICA€ÇO MEC¶NICA                                                        ³"
   @ 21,003 PSAY "³"
   @ 21,068 PSAY "³"
   @ 21,149 PSAY "³"
   @ 22,003 PSAY "³"
   @ 22,068 PSAY "³"
   @ 22,149 PSAY "³"
   @ 23,003 PSAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
   @ 25,003 PSAY " .....................................................................................................................Recortar Aqui..............."
   @ 29,005 PSAY "(12U(s1p20v1s3b4168T" +  "  UNIBANCO"
   @ 29,005 PSAY "(12U(s1p18v1s3b4168T" +  "                         |  409     |"
   @ 29,000 PSAY "(12U(s1p10v1s3b4113T"
   @ 29,120 PSAY _cBloco Picture "@R 99999.99999 99999.999999 99999.999999 9 9999999"
   @ 29,000 PSAY "(s0p20h6v0s0b3T"+Chr(38)+"l12D"
   @ 30,005 PSAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 31,005 PSAY "Local de Pagamento                                                                                             ³ Vencimento                    "
   @ 32,005 PSAY "                                                                                              "
   @ 32,116 PSAY "³"
   @ 32,130 PSAY SE1->E1_VENCTO
   @ 33,005 PSAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 34,005 PSAY "Cedente                                                                                                        ³ Agˆncia/C¢digo Cedente        "
   @ 35,005 PSAY "MULLER MARTINI BRASIL COM. E REPRES. LTDA                                                                      ³ 0352/100877-5                 "
   @ 36,005 PSAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 37,005 PSAY "Data do Documento  ³Nø do Documento            ³Esp‚cie Doc³Aceite      ³Data de Processamento                 ³ Nosso N£mero                  "
   @ 38,009 PSAY SE1->E1_EMISSAO
   @ 38,024 PSAY "³ "+SE1->E1_NUM+If(!Empty(SE1->E1_PARCELA),"-"+SE1->E1_PARCELA,"")
   @ 38,052 PSAY "³   OU      ³   N        ³"
   @ 38,083 PSAY SE1->E1_EMISSAO
   @ 38,116 PSAY "³"
   @ 38,118 PSAY AllTrim(SE1->E1_NUMBCO)+"-"+cCalcDvNN
   @ 39,005 PSAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 40,005 PSAY "Uso do Banco       ³Carteira ³Esp‚cie          ³Quantidade              ³Valor                                 ³ (" + CHR(61) + ") Valor do Documento      "
   @ 41,005 PSAY "                   ³   SR    ³  R$             ³                        ³                                      ³"
   @ 41,125 PSAY SE1->E1_VALOR PICTURE "@E 9,999,999.99"
   @ 42,005 PSAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 43,005 PSAY "Texto de responsabilidade do cedente :                                                                         ³ (" + CHR(61) + ") Desconto                  "
   @ 44,116 PSAY "³                               "
//   _Jrs := Round((SE1->E1_VALOR*SE1->E1_PORCJUR) / 100,2)
   @ 45,007 PSAY " NÆo Receber ap¢s 15 dias"
   @ 45,116 PSAY "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 46,007 PSAY " Ap¢s Vencimento cobrar multa de 2%"
   @ 46,116 PSAY "³ (" + CHR(61) + ") Outras Dedu‡äes/Abatimento"
   @ 47,007 PSAY " Ap¢s 5 Dias cobrar mora de 0,134% ao dia"
   @ 47,116 PSAY "³                               "
   @ 48,116 PSAY "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 49,116 PSAY "³ (+) Mora/Multa/Juros          "
   @ 50,116 PSAY "³                               "
   @ 51,116 PSAY "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 52,116 PSAY "³ (+) Outros Acr‚scimos         "
   @ 53,116 PSAY "³                               "
   @ 54,116 PSAY "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 55,116 PSAY "³ (" + CHR(61) + ") Valor Cobrado             "
   @ 56,116 PSAY "³                               "
   @ 57,005 PSAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 58,005 PSAY "Sacado:   " + SA1->A1_NOME
   @ 58,082 PSAY "CPF/CNPJ: " + Transform(Trim(SA1->A1_CGC),If(" "$SA1->A1_CGC,"999.999.999-99","99.999.999/9999-99"))
   @ 59,015 PSAY AllTrim(SA1->A1_END)+" - "+AllTrim(SA1->A1_BAIRRO)+" - "+AllTrim(SA1->A1_MUN)+" - "+AllTrim(SA1->A1_EST)+" - "+AllTrim(SA1->A1_CEP)
   @ 61,005 PSAY "Sacador/Avalista "
   @ 61,035 PSAY "(12U(s1p7v1s3b4168T"             // incluido por Andre
   @ 61,145 PSAY " Cod. Transacao CVT:    7744.5"    // INCLUIDO POR ANDRE
   @ 62,001 PSAY "(s0p20h6v0s0b3T"+Chr(38)+"l12D"   // iNCLUIDO POR ANDRE
   @ 62,005 PSAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ PROW(),10 PSAY _code
   @ 63,5 PSAY "(12U(s1p9v1s3b4168T" 
   @ 63,188 PSAY "Ficha de Compensa‡Æo"
   @ PROW()+1,0 PSAY "(12U(s1p5v1s3b4168T"
   @ PROW()+1,325 PSAY "Autentica‡Æo no Verso"
   Eject
   DbSelectArea("SE1")
   DbSkip()
EndDo
@ 00,000 PSAY "E"
Set Century Off
Set device to Screen
If aReturn[5] == 1
   Set Printer TO
   dbCommitall()
   OurSpool(wnrel)
Endif
MS_FLUSH()

Return

*****************************************************************************
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³NOSSONUM  ³ Autor ³ ANDRE LUIZ F. SHIWA   ³ Data ³ 22/08/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³CALCULA E GRAVA O "NOSSO NUMERO" NO E1_NUMBCO + DIGITO VERI ³±±
±±³          ³FICADOR CALCULADO PELO MODULO 11,CONFORME PADRAO PASSADO PE ³±±
±±³          ³LO UNIBANCO                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 31/10/00 ==> FUNCTION NOSSONUM

#IFDEF PROTHEUS
   Static Function NossoNum
#ELSE
   Function NossoNum
#ENDIF

//  ALERT("ENTROU NA FUNCAO NOSSONUM")

  IF EMPTY(SE1->E1_NUMBCO)

      DbSelectArea("SEE")
      DbSetOrder(1)
      DbSeek(xFilial("SEE")+MV_PAR13+MV_PAR14+MV_PAR15+MV_PAR16)

      _cNumero:= Val(subs(SEE->EE_FAXATU,1,10))

//      ALERT("FAIXA ATU: "+_cNumero)
      
      RecLock("SEE",.f.)
         SEE->EE_FAXATU := StrZERO(_cNumero+1,10)
      MsUnlock()


*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³       Gera o Nosso Numero                                     ³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

      _cNN1  :=  STRZERO(_cNumero,10)

//      ALERT("NUMERO: "+_cNN1)

      _cDigito  := MODULO11(_cNN1)
//      ALERT("DIGITO: "+_cDigito)

      IF  _cDigito == "0" .OR.;
          _cDigito == "10"
          _cDigito := "1"
      ENDIF

      _NOSSONUM := ALLTRIM(_cNN1)+ALLTRIM(_cDigito)

//      ALERT("NOSSONUM: "+ _NOSSONUM)

      DbSelectArea("SE1")
      RecLock("SE1",.F.)
         SE1->E1_NUMBCO := _NOSSONUM
      MsUnlock()

  ENDIF
  Return
  
******************************************************************************
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ValidPerg ³ Autor ³ Jaime Ranulfo Leite F ³ Data ³ 29/12/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Cria SX1                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
// Substituido pelo assistente de conversao do AP5 IDE em 31/10/00 ==> Function ValidPerg
#IFDEF PROTHEUS
   Static Function ValidPerg()
#ELSE
   Function ValidPerg
#ENDIF

_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)
aRegs:={}

// Grupo/Ordem/Pergunta        /Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3
aAdd(aRegs,{cPerg,"01","Do Prefixo             ","mv_ch1","C",03,0,0,"G","","mv_par01","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Ate o Prefixo          ","mv_ch2","C",03,0,0,"G","","mv_par02","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Do Numero              ","mv_ch3","C",06,0,0,"G","","mv_par03","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Ate o Numero           ","mv_ch4","C",06,0,0,"G","","mv_par04","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Da Emissao             ","mv_ch5","D",08,0,0,"G","","mv_par05","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","Ate a Emissao          ","mv_ch6","D",08,0,0,"G","","mv_par06","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","Do Vencimento          ","mv_ch7","D",08,0,0,"G","","mv_par07","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","Ate o Vencimento       ","mv_ch8","D",08,0,0,"G","","mv_par08","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"09","Do Cliente             ","mv_ch9","C",06,0,0,"G","","mv_par09","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"10","Da Loja                ","mv_cha","C",02,0,0,"G","","mv_par10","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"11","Ate o Cliente          ","mv_chb","C",06,0,0,"G","","mv_par11","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"12","Ate a Loja             ","mv_chc","C",02,0,0,"G","","mv_par12","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"13","Banco                  ","mv_chd","C",03,0,0,"G","","mv_par09","","","","","","","","","","","","","","","SEE"})
aAdd(aRegs,{cPerg,"14","Agencia                ","mv_che","C",05,0,0,"G","","mv_par10","","","","","","","","","","","","","","","SEE"})
aAdd(aRegs,{cPerg,"15","Conta                  ","mv_chf","C",10,0,0,"G","","mv_par11","","","","","","","","","","","","","","","SEE"})
aAdd(aRegs,{cPerg,"16","SubConta               ","mv_chg","C",03,0,0,"G","","mv_par12","","","","","","","","","","","","","","","SEE"})
//aAdd(aRegs,{cPerg,"17","Carteira               ","mv_chh","C",03,0,0,"G","","mv_par12","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
    If !dbSeek(cPerg+aRegs[i,2])
       RecLock("SX1",.T.)
       For j:=1 to FCount()
       FieldPut(j,aRegs[i,j])
       Next
       MsUnlock()
    Endif
Next

dbSelectArea(_sAlias)

Return .T.
