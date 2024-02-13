  /*---------------------------------------------------------------------------------------------------
		Titulo								Impressão Boleto Bancario FACS
		Nome Programa					FACFI50_AP5.prw
		Descricao							Imprime Boletos Bancarios para titulos a receber previamente incluidos em 
													Borderos.
		Autor									Monica Moura - Microsiga Salvador	
		Dt criacao						16/nov/2000
		Revisao								Sergio Silverfox - Microsiga Salvador 14/dez/2000
													Humberto Fernandes - Microsiga Salvador 14/dez/2000
		Cliente								FACS S/C
		Indices especif.			
		Prog. relacionados		Nenhum
		Observacoes						Este programa está previsto para atender apenas aos bancos com os quais
													o cliente tem  cobranca e CNAB configurados no momento de sua criação:
													BRADESCO, BANDEIRANTES, ITAU.
													        
------------------------------------------------------------------------------------------------------*/
// composicao de nosso numero invalida no bradesco 

#include "rwmake.ch"     
#include "topconn.ch"
#IFNDEF WINDOWS
  DEFINE PSAY SAY
#ENDIF
User Function FACFI50()    

SetPrvt("CSTRING,CDESC1,CDESC2,CDESC3,TAMANHO,WNREL") 
SetPrvt("ARETURN,NOMEPROG,ALINHA,NLASTKEY,LEND,TITULO")
SetPrvt("CABEC1,CABEC2,CCANCEL,M_PAG,CPERG")
SetPrvt("NLIN,_cArea,")


cPerg  :="FACS50"
ValidPerg()

_cNros			:=	''		// ----- Sequencia de Numeros para calculo de digito verificador
_cDV				:=	''		// ----- Digito verificador calculado
_cDvConta		:=	''    // ----- digito Verificador da conta
_cCtaLimpa	:=	''    // ----- Conta sem pontos e tracos
_cArea			:= 	''		// ----- Area de trabalho
dt					:=	ctod('07/10/1997')  //----- DataBase Definida
fator				:= "1000"//----- Fator Vencto
     //MSGBOX(FATOR)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Boleto     ³ Autor ³ Monica Moura Bomfim   ³ Data ³ 16.11.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Boleto Bancario Itau                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  


cString:="SX5"
cDesc1:= OemToAnsi("Este programa tem como objetivo imprimir boleto de ")
cDesc2:= OemToAnsi("acordo com os parametros informados pelo usuario.")
cDesc3:= ""
tamanho:="P"
wnrel:="BOLETO"            //Nome Default do relatorio em Disco
aReturn := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog:="BOLETO"
aLinha  := { }
nLastKey := 0
lEnd := .f.
titulo      :="Boleto Bancário"
cabec1      :=""
cabec2      :=""
cCancel := "***** CANCELADO PELO OPERADOR *****"

m_pag := 0  //Variavel que acumula numero da pagina


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


Wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

If nLastKey == 27
    Set Filter To
    Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
    Set Filter To
    Return
Endif

 
//DbSelectArea("SE1")

     RptStatus({|| RodeBoleto() })// Substituido pelo assistente de conversao do AP5 IDE em 16/11/00 ==>         RptStatus({|| Execute(RptDetail) })
       
     Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³RptDetail ³ Autor ³ M“nica Moura Bomfim   ³ Data ³ 04.09.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Impressao do corpo do relatorio                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  

// Substituido pelo assistente de conversao do AP5 IDE em 16/11/00 ==> Function RptDetail

Static Function RodeBoleto()


//----- Parametros
//  Qual o Banco       ?,"C",3,0,mv_par01
//  Do Curso           ?,"C",3,0,mv_par02
//  Ate o Curso        ?,"C",3,0,mv_par03
//  Da Matricula       ?,"C",9,0,mv_par04
//  Ate Matricula      ?,"C",9,0,mv_par05
//  Do Vencimento      ?,"D",8,0,mv_par06
//  Ate Vencimento     ?,"D",8,0,mv_par07
//  Imp.Aluno em Debito?,"N",1,0,mv_par08
pergunte(cPerg,.F.)

_mvpar01 := mv_par01
_mvpar02 := mv_par02
_mvpar03 := mv_par03
_mvpar04 := mv_par04
_mvpar05 := mv_par05
_mvpar06 := mv_par06
_mvpar07 := mv_par07
_mvpar08 := mv_par08



Private oFont, cCode
nHeight:=15
lBold:= .F.
lUnderLine:= .F.

lPixel:= .T.
lPrint:=.F.

oFont	:= TFont():New( "Arial",,nHeight,,lBold,,,,,lUnderLine )
oFont5	:= TFont():New( "Arial",,5,,.f.,,,,,.f. )
oFont6	:= TFont():New( "Arial",,6,,.f.,,,,,.f. ) 
oFont7	:= TFont():New( "Arial",,7,,.f.,,,,,.f. ) 
oFont8	:= TFont():New( "Arial",,8,,.t.,,,,,.f. )
oFont9	:= TFont():New( "Arial",,9,,.f.,,,,,.f. )
oFont9b	:= TFont():New( "Arial",,9,,.t.,,,,,.f. )
oFont10b:= TFont():New( "Arial",,10,,.t.,,,,,.f.)
oFont10	:= TFont():New( "Arial",,10,,.t.,,,,,.f. )
oFont102:= TFont():New( "Arial",,10,,.f.,,,,,.f.)
oFont10i:= TFont():New( "Arial",,10,,.t.,,,,.t.,.f. )
oFont12	:= TFont():New( "Arial",,12,,.t.,,,,,.f. )
oFont12i:= TFont():New( "Arial",,12,,.t.,,,,.t.,.f. )
oFont122:= TFont():New( "Arial",,12,,.t.,,,,,.f. )
oFont14	:= TFont():New( "Arial",,14,,.f.,,,,,.f. )
oFont142:= TFont():New( "Arial Narrow",,14,,.T.,,,,,.f. )
oFont152:= TFont():New( "Arial",,15,,.T.,,,,,.f. )
oFont16	:= TFont():New( "Arial Narrow",,16,,.f.,,,,,.f. )
oFont162:= TFont():New( "Arial Narrow",,14,,.T.,,,,,.f. )
oFont18	:= TFont():New( "Arial",,18,,.f.,,,,,.f. )
oFont20	:= TFont():New( "Arial",,20,,.f.,,,,,.f. )
oFont22	:= TFont():New( "Arial",,22,,.f.,,,,,.f. )


//		t1	:= 	8
//		t2	:= 	10
//		t3	:= 	12
//		t4	:= 	16
//		t5	:=	18
//		t6	:=	24
//		t7	:= 	36

t1	 := 6
t15  := 8
t2	 := 10
t3	 := 12
t4	 := 16
t5	 :=	18
t6	 :=	24
t7	 := 36



//----- Nomes de fonte
Cour	:=	"Courier New"


oFt1 := TFont():New( "Arial"  ,,t1 ,,.t.,,,,,.f. )
oFt15:= TFont():New( Cour ,,t15,,.t.,,,,,.f. )
oFt2 := TFont():New( Cour ,,t2 ,,.f.,,,,,.f. )
oFt3 := TFont():New( Cour ,,t3 ,,.f.,,,,,.f. )
oFt4 := TFont():New( Cour ,,t4 ,,.f.,,,,,.f. )
oFt5 := TFont():New( Cour ,,t5 ,,.f.,,,,,.f. )
oFt6 := TFont():New( Cour ,,t6 ,,.f.,,,,,.f. )
oFt7 := TFont():New( Cour ,,t7 ,,.f.,,,,,.f. )
oFt1b:= TFont():New( Cour ,,t1 ,,.t.,,,,,.f. )
oFt2b:= TFont():New( Cour ,,t2 ,,.t.,,,,,.f. )
oFt3b:= TFont():New( Cour ,,t3 ,,.t.,,,,,.f. )
oFt4b:= TFont():New( Cour ,,t4 ,,.t.,,,,,.f. )
oFt5b:= TFont():New( Cour ,,t5 ,,.t.,,,,,.f. )
oFt6b:= TFont():New( Cour ,,t6 ,,.t.,,,,,.f. )
oFt7b:= TFont():New( Cour ,,t7 ,,.t.,,,,,.f. )



oPrn 		:= TMSPrinter():New()

//----- Direciona para Funçao de acordo com o banco selecionado	
	Do Case
	  Case _mvpar01=="341"
	     BoletoItau()
	  Case _mvpar01=="237"
	     BoletoBradesco()
	  Case _mvpar01=="230"
	     BoletoBandeirantes()
	EndCase
	        
	
oPrn:Setup() // para configurar impressora
oPrn:Preview()
//oPrn:Print() // descomentar esta linha para imprimir

MS_FLUSH()

Return



Static Function BoletoItau()
//-----  Impressao do Boleto Itau

pergunte( cperg, .f.) 
MontaQuery()
dbSelectArea("QRY")
SetRegua(RecCount('QRY'))
dbGoTop()

While !EOF()
     IncRegua()
    
    
    While !EOF() .AND. Empty(QRY->E1_BAIXA) .AND. QRY->E1_VENCTO< DTOS(dDATABASE) .AND. STR(_mvpar08,1)=="2"  
      DBSKIP()
      IncRegua()
    ENDDO
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif       
   
     cAgencia:=alltrim(QRY->EA_AGEDEP)
     cConta:=alltrim(QRY->EA_NUMCON)
     
     // Calculo do Fator de vencimento
     dt:=ctod('07/10/1997')
     vencto:=SubStr(QRY->E1_VENCTO,7,2)+"/"+ SubStr(QRY->E1_VENCTO,5,2)+"/"+SubStr(QRY->E1_VENCTO,1,4) 
     vencto1:= ctod("'"+vencto+"'")    
     fator:= str(vencto1 - dt) 
     //MSGBOX(FATOR)
     
     // cContem armazena o conteudo do cod. de barras sem o seu DAC. 
     
      cContem:= alltrim(QRY->EA_PORTADO)+'9'+ alltrim(fator)+ alltrim(STRZERO(int(QRY->E1_VALOR*100),10))+ alltrim(QRY->E1_NUMBCO)+ alltrim(QRY->E1_NUMDV)+ alltrim(QRY->EA_AGEDEP)+alltrim(SUBSTR(QRY->EA_NUMCON,1,2))+alltrim(SUBSTR(QRY->EA_NUMCON,4,3))+alltrim(SUBSTR(QRY->EA_NUMCON,8,1))+'000'
    
    // Cálculo do DAC do cod. de barras

     K:=0 
     J:=4
     FOR I:=1 TO Len(cContem)
       if j==1
         j:=9
       endif
       K:=K+val(SUBSTR(cContem,I,1))*J
       j:=j-1
     NEXT  
     //     msgbox(str(k))
     
     resto:= MOD(K,11)
     //MSGBOX(STR(RESTO))
     DACCB  := 11-RESTO 
     DACCB 	:= IIF( DACCB==11, 1, DACCB )
		 DACCB 	:= IIF( DACCB==10, 1, DACCB )
		 DACCB 	:= IIF( DACCB== 1, 1, DACCB )
		 DACCB 	:= IIF( DACCB== 0, 1, DACCB )
	
     
     // Sequencia completa do código de barras (com o DAC)
    
     SeqCB:= alltrim(QRY->EA_PORTADO)+'9'+alltrim(str(DACCB))+ alltrim(fator)+ alltrim(STRZERO(int(QRY->E1_VALOR*100),10))+alltrim(QRY->E1_NUMBCO)+alltrim(QRY->E1_NUMDV)+alltrim(QRY->EA_AGEDEP)+alltrim(SUBSTR(QRY->EA_NUMCON,1,2))+alltrim(SUBSTR(QRY->EA_NUMCON,4,3))+alltrim(SUBSTR(QRY->EA_NUMCON,8,1))+'000'
 //    msgbox("sqcb: "+ seqcb)  
    
     //Formação  da representação numérica do código de barras
          
     //                                     campo1         campo2       campo3      4      campo5
     //Formato da representação númerica AAABC.CCDDX   DDDDD.DEFFFY   FGGGG.GGHHHZ  K  UUUUVVVVVVVVVV 
     
     AAA:= alltrim(QRY->EA_PORTADO)     //Variável que armazena o codigo do banco p/ compor a repres. númerica do cód. de barras
     B:=   "9"      //Variável que armazena o codigo da MOEDA p/ compor a repres. númerica do cód. de barras
     CCC:= SUBSTR(QRY->E1_NUMBCO,1,3)   //Variável que armazena o codigo da Carteira p/ compor a repres. númerica do cód. de barras
     DD:=  SUBSTR(QRY->E1_NUMBCO,4,2)    // Variável que armazena os dois prim. digitos do nosso numero p/ compor a repres. númerica do cód. de barra/
        
     // Calculo do DAC da representação Numérica do campo 1
     
     dig1:=VAL(SUBSTR(AAA,1,1))*2
     if dig1 >9
       dig1:=val(SUBSTR(str(dig1,2),1,1))+val(SUBSTR(str(dig1,2),2,1))
     EndIF   
    
     dig3:=VAL(SUBSTR(AAA,3,1))*2
     if dig3>9
       dig3:=val(SUBSTR(str(dig3,2),1,1))+val(SUBSTR(str(dig3,2),2,1))
     EndIF

     dig5:=VAL(SUBSTR(CCC,1,1))*2
     if dig5>9
       dig5:=val(SUBSTR(str(dig5,2),1,1))+val(SUBSTR(str(dig5,2),2,1))
     EndIF
     
     dig7:=VAL(SUBSTR(CCC,3,1))*2
     if dig7>9
       dig7:=val(SUBSTR(str(dig7,2),1,1))+val(SUBSTR(str(dig7,2),2,1))
     EndIF
   
     dig9:=VAL(SUBSTR(DD,2,1))*2
     if dig9>9
       dig9:=val(SUBSTR(str(dig9,2),1,1))+val(SUBSTR(str(dig9,2),2,1))
     EndIF
   
     DACSomaX:= dig9 +VAL(SUBSTR(DD,1,1))*1+dig7+VAL(SUBSTR(CCC,2,1))*1+dig5+VAL(B)*1+dig3+VAL(SUBSTR(AAA,2,1))*1+dig1
     DACDivX:= MOD(DACSomaX,10)
     DACX:= 10-DACDivX
     DACX 	:= IIF( DACX==10, 0, DACX )

     X:=STR(DACX) //Variável que armazena o DAC que amarra o campo 1
     
     DDDDDD:= SUBSTR(QRY->E1_NUMBCO,6,6)  
     E:= QRY->E1_NUMDV
     FFF:= SUBSTR(QRY->EA_AGEDEP,1,3)

     // Calculo do DAC da representação Numérica do campo 2
     
     dig2:= VAL(SUBSTR(DDDDDD,2,1))*2
     if dig2>9
       dig2:=val(SUBSTR(str(dig2,2),1,1))+val(SUBSTR(str(dig2,2),2,1))
     EndIF
     
     dig4:= VAL(SUBSTR(DDDDDD,4,1))*2
     if dig4 > 9
       dig4:=val(SUBSTR(str(dig4,2),1,1))+val(SUBSTR(str(dig4,2),2,1))
     EndIF
     
     dig6:= VAL(SUBSTR(DDDDDD,6,1))*2
     if dig6>9
        dig6:=val(SUBSTR(str(dig6,2),1,1))+val(SUBSTR(str(dig6,2),2,1))
     EndIF
    
     dig8:= VAL(SUBSTR(FFF,1,1))*2
     if dig8>9
       dig8:=val(SUBSTR(str(dig8,2),1,1))+val(SUBSTR(str(dig8,2),2,1))
     EndIF

     dig10:=VAL(SUBSTR(FFF,3,1))*2
     if dig10>9
       dig10:=val(SUBSTR(str(dig10,2),1,1))+val(SUBSTR(str(dig10,2),2,1))
     EndIF
     
     DACSomaY:= dig10+VAL(SUBSTR(FFF,2,1))*1+ dig8 +VAL(E)*1+ dig6 +VAL(SUBSTR(DDDDDD,5,1))*1+ dig4 +VAL(SUBSTR(DDDDDD,3,1))*1+ dig2 +VAL(SUBSTR(DDDDDD,1,1))*1
     DACDivY:= MOD(DACSomaY,10)
     DACY:= 10-DACDivY
     DACY 	:= IIF( DACY==10, 0, DACY )
     
     Y:= STR(DACY)  //Variável que armazena o DAC que amarra o campo 2
     
     //Campo3
     
     F:=SUBSTR(QRY->EA_AGEDEP,4,1)
     GGGGGG:=SUBSTR(QRY->EA_NUMCON,1,2)+SUBSTR(QRY->EA_NUMCON,4,3)+SUBSTR(QRY->EA_NUMCON,8,1)
     HHH:= '000'
     
     // Calculo do DAC da representação Numérica do campo 3
     
     dg2:=VAL(SUBSTR(GGGGGG,1,1))*2
     if dg2>9
       dg2:=val(SUBSTR(str(dg2,2),1,1))+val(SUBSTR(str(dg2,2),2,1))
     EndIF
     
     dg4:=VAL(SUBSTR(GGGGGG,3,1))*2
     if dg4>9
       dg4:=val(SUBSTR(str(dg4,2),1,1))+val(SUBSTR(str(dg4,2),2,1))
     EndIF
 
     dg6:=VAL(alltrim(SUBSTR(GGGGGG,5,1)))*2
     
    // msgbox("tam"+str(len(dg6)))
     if dg6 > 9
     //  msgbox("dg6"+str(dg6)) 
       um:=str(dg6,2)
     //  msgbox("um"+um)
    //   MSGBOX(SUBSTR(um,1,1))  
   //    MSGBOX(SUBSTR(um,2,1))
       dg6:=val(SUBSTR(str(dg6,2),1,1))+val(SUBSTR(str(dg6,2),2,1))
   //    msgbox("dg6 SOMA DIG:"+str(dg6)) 
     EndIF
     
     dg8:=VAL(SUBSTR(HHH,1,1))*2
     if dg8>9
       dg8:=val(SUBSTR(str(dg8,2),1,1))+val(SUBSTR(str(dg8,2),2,1))
     EndIF
     
     dg10:=VAL(SUBSTR(HHH,3,1))*2
     if dg10>9
       dg10:=val(SUBSTR(str(dg10,2),1,1))+val(SUBSTR(str(dg10,2),2,1))
     EndIF              
     
     DACSomaZ:= dg10+VAL(SUBSTR(HHH,2,1))*1+dg8+VAL(SUBSTR(GGGGGG,6,1))*1+dg6+VAL(SUBSTR(GGGGGG,4,1))*1+dg4+VAL(SUBSTR(GGGGGG,2,1))*1+dg2+VAL(F)*1
  //   msgbox("soma:"+str(dacsomaz))
     DACDivZ:= MOD(DACSomaZ,10)
  //   msgbox("resto da div/10:"+str(dacdivz))
     DACZ:= 10-DACDivz
 //    msgbox("subtr:10-resto"+str(dacz))
     DACZ 	:= IIF( DACZ==10, 0, DACZ )

     Z:= STR(DACZ)
    // msgbox("z"+Z)
     // campo4
    
     K:= str(DACCB)  
     
     // campo5
     
     UUUU:= fator
     VVVVVVVVVV:= STRZERO(int(QRY->E1_VALOR*100),10)

     // Formação da sequência da representação númerica
     
     SeqRN:= AAA + B + SUBSTR(CCC,1,1)+"."+SUBSTR(CCC,2,2)+DD+alltrim(X)+"  "+SUBSTR(DDDDDD,1,5)+"."+SUBSTR(DDDDDD,6,1)+E+FFF+alltrim(Y)+"  "+F+SUBSTR(GGGGGG,1,4)+"."+SUBSTR(GGGGGG,5,2)+HHH+alltrim(Z)+"  "+ alltrim(K)+"  "+alltrim(UUUU)+alltrim(VVVVVVVVVV)
     //msgbox("seqrn: "+seqrn)
     
	 //----- Monta Variaveis para impressao no Boleto
    _nTotAbat := 0
    _nSaldo		:=	QRY->E1_SALDO	 
		_cLocPag1:=	"ATÉ O VENCIMENTO PAGÁVEL EM QUALQUER BANCO"
		_cLocPag2:=	"APÓS O VENCIMENTO PAGÁVEL APENAS NO BANCO ITAÚ"
     
		_cCedente	:=	Alltrim(SM0->M0_NOMECOM)+'   CGC: '+SUBSTR(SM0->M0_CGC,1,2)+"."+SUBSTR(SM0->M0_CGC,3,3)+"."+SUBSTR(SM0->M0_CGC,6,3)+"/"+SUBSTR(SM0->M0_CGC,9,4)+"-"+SUBSTR(SM0->M0_CGC,13,2)
		_cVencto   	:=SubStr(QRY->E1_VENCTO,7,2)+"/"+ SubStr(QRY->E1_VENCTO,5,2)+"/"+SubStr(QRY->E1_VENCTO,1,4)
     
		_cDtDoc    	:=SubStr(QRY->E1_EMISSAO,7,2)+"/"+ SubStr(QRY->E1_EMISSAO,5,2)+"/"+SubStr(QRY->E1_EMISSAO,1,4)
		_cDtProc   	:=SubStr(QRY->E1_EMISSAO,7,2)+"/"+ SubStr(QRY->E1_EMISSAO,5,2)+"/"+SubStr(QRY->E1_EMISSAO,1,4)
		_cNumdoc	:=	QRY->E1_PREFIXO+'-'+QRY->E1_NUM+'-'+QRY->E1_PARCELA
		_cEspDoc	:=	'MF'
		_cAceite	:=	'N'   
		_nValjur	:=	QRY->E1_VALJUR
		//_nMulta		:=	_nSaldo * GetMV('MV_MULTFAC')
		_cSacado	:=	QRY->E1_MAT+'  '+QRY->A1_COD+'-'+QRY->A1_LOJA+'  '+QRY->A1_NOME
		_cCGCCedente	:=	SUBSTR(SM0->M0_CGC,1,2)+"."+SUBSTR(SM0->M0_CGC,3,3)+"."+SUBSTR(SM0->M0_CGC,6,3)+"/"+SUBSTR(SM0->M0_CGC,9,4)+"-"+SUBSTR(SM0->M0_CGC,13,2)
    _cCartDoc	:=	'173'
   	_cEspMoeda	:=	'R$'

     
     // Configuracao das Mensagens
     
  		_cMsg1		:= 'MENS.'+SUBS(QRY->E1_EMISSAO,5,2)+'/'+SUBS(QRY->E1_EMISSAO,1,4)
  		_cMsg2      := '.'
		_cMsg3      := IIF(	QRY->E1_VALJUR>0, 'ACRESCIMO POR DIA DE ATRASO R$'+ALLTRIM(STR(QRY->E1_VALJUR,17,2)), '')
		//_cMsg4		:= 'MULTA POR ATRASO R$'+ALLTRIM(STR((GETMV('MV_MULTFAC')*(QRY->E1_SALDO-EXECBLOCK('FACFI20')))/100, 17,2))
		_cMsg5		:= MsgAbat()// EXECBLOCK('FACFI25', .F.,.F.)
		
		_nMulta		:=(	_nSaldo - _nTotAbat) * GetMV('MV_MULTFAC') / 100
		_cMsg4		:= 'MULTA POR ATRASO R$'+ALLTRIM(STR(_nMulta, 17,2))
     // Impressão do Boleto
    
  	 oPrn:StartPage()

    
     cBitMap:="LogoItau.Bmp"
     oPrn:SayBitmap(048,085,cBitMap,070,080)
     oPrn:Box( 066, 729,131,730)
     oPrn:Box( 066, 939,131,940)
     
     oPrn:Say( 105, 070, Repli('_',280),oFont7,100)  

     oPrn:Box( 130, 1650,815,1651)

     
     oPrn:Say( 203, 070, Repli('_',280),oFont7,100)  
     
     
     oPrn:Say( 271, 070, Repli('_',280),oFont7,100)  

     oPrn:Box( 296, 330,365,331)
     oPrn:Box( 296, 750,365,751)
     oPrn:Box( 296, 970,365,971)
     oPrn:Box( 296, 1175,440,1176)
     oPrn:Say( 344, 070, Repli('_',280),oFont7,100)  
     oPrn:Box( 369,390,440,391)
     oPrn:Box( 369,610,440,611)
     oPrn:Box( 369,780,440,781)
     oPrn:Say( 416, 070, Repli('_',280),oFont7,100)                          
 
     oPrn:Say( 491,1650,Repli('_',082),oFont7,100)
     

    
     
     oPrn:Say( 565,1650,Repli('_',082),oFont7,100)
     

     oPrn:Say( 647,1650,Repli('_',082),oFont7,100)
     oPrn:Say( 715,1650,Repli('_',082),oFont7,100)
     oPrn:Say( 790, 070, Repli('_',280),oFont7,100)

     
     oPrn:Say( 885, 070, Repli('_',280),oFont7,100)  
     
     
     oPrn:Say( 980,000,Repli('-',195),oFont12,100)
     
 //************************************************************   
// 2ª faixa do boleto

     cBitMap:="LogoItau.Bmp"
     oPrn:SayBitmap( 1050,085,cBitMap,070,080)
     oPrn:Box( 1069, 729,1134,730)
     oPrn:Box( 1069, 939,1134,940)
     
     
     oPrn:Say( 1110, 070, Repli('_',280),oFont7,100)  

     oPrn:Box( 1135, 1650,1820,1651)



     oPrn:Say( 1208, 070, Repli('_',280),oFont7,100)  
     
     
     oPrn:Say( 1276, 070, Repli('_',280),oFont7,100)  

     oPrn:Box( 1301, 330,1375,331)
     oPrn:Box( 1301, 750,1375,751)
     oPrn:Box( 1301, 970,1375,971)
     oPrn:Box( 1301, 1175,1445,1176)


     oPrn:Say( 1349, 070, Repli('_',280),oFont7,100)  
     
     oPrn:Box( 1374, 390,1445,391)
     oPrn:Box( 1374, 610,1445,611)
     oPrn:Box( 1374, 780,1445,781)


     oPrn:Say( 1421, 070, Repli('_',280),oFont7,100)                          
 
     oPrn:Say( 1496,1650,Repli('_',082),oFont7,100)

    
     
     oPrn:Say( 1570,1650,Repli('_',082),oFont7,100)

     oPrn:Say( 1652,1650,Repli('_',082),oFont7,100)
     oPrn:Say( 1720,1650,Repli('_',082),oFont7,100)
     oPrn:Say( 1795, 070, Repli('_',280),oFont7,100)  

     
     oPrn:Say( 1890, 070, Repli('_',280),oFont7,100)  
     
     oPrn:Say( 2150,000,Repli('-',195),oFont12,100)
     
//************************************************************   
// 3ª faixa do boleto

     cBitMap:="LogoItau.Bmp"        //col  lin
     oPrn:SayBitmap( 2198,085,cBitMap,070,080)
     oPrn:Box( 2219, 729,2285,730)
     oPrn:Box( 2219, 939,2285,940)
     
     oPrn:Say( 2260, 070, Repli('_',280),oFont7,100)  

     oPrn:Box( 2285, 1650,2967,1651)


     oPrn:Say( 2358, 070, Repli('_',280),oFont7,100)  
     
     
     oPrn:Say( 2426, 070, Repli('_',280),oFont7,100)  

     oPrn:Box( 2451, 330,2524,331)
     oPrn:Box( 2451, 750,2524,751)
     oPrn:Box( 2451, 970,2524,971)
     oPrn:Box( 2451, 1175,2595,1176)

     oPrn:Say( 2499, 070, Repli('_',280),oFont7,100)  
     
     oPrn:Box( 2524, 390,2595,391)
     oPrn:Box( 2524, 610,2595,611)
     oPrn:Box( 2524, 780,2595,781)
     
     oPrn:Say( 2571, 070, Repli('_',280),oFont7,100)                          
 
     oPrn:Say( 2646,1650,Repli('_',082),oFont7,100)
    
     
     oPrn:Say( 2720,1650,Repli('_',082),oFont7,100)
     oPrn:Say( 2802,1650,Repli('_',082),oFont7,100)
     oPrn:Say( 2870,1650,Repli('_',082),oFont7,100)
     oPrn:Say( 2945,070, Repli('_',280),oFont7,100)  

     oPrn:Say( 3040, 070, Repli('_',280),oFont7,100)
     


     // ------- textos
     
     
     oPrn:Say( 20, 20, " ",oFont,100 )
     oPrn:Say( 060,735, "341-7",oFt5b,100)
     oPrn:Say( 085,220, "Banco Itaú S.A.",oFt2b,100)
     oPrn:Say( 080,1840, "Recibo do Sacado",oFt3b,100)
     
     

     oPrn:Say( 132,085,"Local de Pagamento",oFont7,100)

     oPrn:Say( 132,1672,"Vencimento",oFont7,100)
     oPrn:Say( 165,100,_cLocPag1,oFt2b,100)
     oprn:Say( 194,100,_cLocPag2,oFt2b,100)
     oPrn:Say( 185,1950,_cVencto,oFt2b,100)

     
     oPrn:Say( 229,085,"Cedente",oFont7,100)

     oPrn:Say( 229,1672,"Agencia/Código Cedente",oFont7,100)
     oPrn:Say( 255,085,_cCedente,oFt2b,100)
     //oPrn:Say( 255,380,"CGC",oFt2b,100)
     //oPrn:Say( 255,460,SUBSTR(SM0->M0_CGC,1,2)+"."+SUBSTR(SM0->M0_CGC,3,3)+"."+SUBSTR(SM0->M0_CGC,6,3)+"/"+SUBSTR(SM0->M0_CGC,9,4)+"-"+SUBSTR(SM0->M0_CGC,13,2),oFt2b,100)
     oPrn:Say( 255,1800,cAgencia+"/"+cConta,oFt2b,100)
     

     oPrn:Say( 296,085,"Data do Documento",oFont7,100)
     oPrn:Say( 296,360,"Número Documento",oFont7,100)
     oPrn:Say( 296,790,"Espécie Doc.",oFont7,100)
     oPrn:Say( 296,998,"Aceite",oFont7,100)
     oPrn:Say( 296,1200,"Data de processamento",oFont7,100)
     oPrn:Say( 296,1672,"Nosso Número",oFont7,100)            
     oPrn:Say( 330,100,_cDtDoc,oFt2b,100)

     oPrn:Say( 330,415,_cNumdoc,oFt2b,100)

     oPrn:Say( 330,860,_cEspDoc,oFt2b,100)

     oPrn:Say( 330,1025,_cAceite,oFt2b,100)

     oPrn:Say( 330,1325,_cDtProc,oFt2b,100)  

     oPrn:Say( 330,1830,SUBSTR(QRY->E1_NUMBCO,1,3)+"/"+SUBSTR(QRY->E1_NUMBCO,4,8)+"-"+QRY->E1_NUMDV,oFt2b,100) 

     
     oPrn:Say( 369,085,"Uso do Banco",oFont7,100) 
     oPrn:Say( 369,415,"Carteira",oFont7,100)
     oPrn:Say( 369,660,"Espécie",oFont7,100)
     oPrn:Say( 369,810,"Quantidade",oFont7,100)

     oPrn:Say( 369,1200,"Valor",oFont7,100)        
     oPrn:Say( 369,1672," (=) Valor do Documento",oFont7,100) 
     oPrn:Say( 394,452,_cCartdoc,oFt2b,100)
     oPrn:Say( 394,685,_cEspMoeda,oFt2b,100)     
     oPrn:Say( 394,1830,Trans(_nSaldo,"@E@R 999,999,999.99"),oFt2b,100) 


 
     oPrn:Say( 442,085,"Instruções(Todas informações deste boleto são de exclusiva responsabilidade do cedente)",oFont7,100)        
     oPrn:Say( 442,1672," (-) Desconto /Abatimento",oFont7,100)
     

    
     
     oPrn:Say( 595,1672," (+) Mora/Multa",oFont7,100)
     
     // Mensagens
     
     oPrn:Say( 585,150,_cMsg1,oFt2b,100)
     oPrn:Say( 615,150,_cMsg2,oFt2b,100)
     oPrn:Say( 645,150,_cMsg3,oFt2b,100)          
     oPrn:Say( 675,150,_cMsg4,oFt2b,100)     
     oPrn:Say( 705,150,_cMsg5,oFt2b,100)          

     //oPrn:Say( 584,150,"Acréscimo por dia de atraso",oFt2b,100)
     //oPrn:Say( 587,550,Trans(QRY->E1_VALJUR,"@E@R 999,999,999.99"),oFt2b,100)  //PICTURE "@E@R 999,999,999.99"
     //oPrn:Say( 615,150,"Multa por atraso",oFt2b,100)
     //oPrn:Say( 630,550,Trans(QRY->E1_MULTA,"@E@R 999,999,999.99"),oFt2b,100)   //PICTURE "@E@R 999,999,999.99"
     //oPrn:Say( 669,150,"MENS."+SubStr(QRY->E1_VENCTO,5,2)+"/"+SubStr(QRY->E1_VENCTO,1,4),oFt2b,100)
     
     oPrn:Say( 745,1672," (=) Valor Cobrado",oFont7,100)     

     //oPrn:Say( 780,150,"("+ALLTRIM(QRY->A1_CURSO)+ " - "+SUBSTR(QRY->E1_MAT,3,2)+"/"+SUBSTR(QRY->E1_MAT,5,1)+" - "+ALLTRIM(QRY->Z3_DESC)+ ")",oFont7,100)

     oPrn:Say( 815,085,"Sacado",oFont7,100)
     oPrn:Say( 835,200,_cSacado,oFt3b,100)
     //oPrn:Say( 835,500,+"-  "+QRY->A1_NOME,oFt3b,100)
     oPrn:Say( 880,085,"Sacador/Avalista",oFont7,100)
     oPrn:Say( 880,1840,"Código de Baixa",oFont7,100)
     
     
     oPrn:Say( 918,1650,"Autenticação Mecânica",oFont7,100)
     
     oPrn:Say( 1008,082,"CORTE AQUI",oFont5,100)
     
 //************************************************************   
// 2ª faixa do boleto

     cBitMap:="LogoItau.Bmp"
     oPrn:SayBitmap( 1050,085,cBitMap,070,080)
     oPrn:Say( 1065,730, "341-7",oFt5b,100)
     oPrn:Say( 1090,220, "Banco Itaú S.A.",oFt2b,100)
     oPrn:Say( 1085,1840, "Ficha de Caixa",oFt3b,100)
     
     


     oPrn:Say( 1137,085,"Local de Pagamento",oFont7,100)

     oPrn:Say( 1137,1672,"Vencimento",oFont7,100)
     oPrn:Say( 1170,100,_cLocPag1,oFt2b,100)
     oprn:Say( 1199,100,_cLocPag2,oFt2b,100)
     oPrn:Say( 1190,1950,_cVencto,oFt2b,100)

     
     oPrn:Say( 1234,085,"Cedente",oFont7,100)

     oPrn:Say( 1234,1672,"Agencia/Código Cedente",oFont7,100)
     oPrn:Say( 1260,085,_cCedente,oFt2b,100)
     //oPrn:Say( 1260,380,"CGC",oFt2b,100)
     //oPrn:Say( 1260,460,SUBSTR(SM0->M0_CGC,1,2)+"."+SUBSTR(SM0->M0_CGC,3,3)+"."+SUBSTR(SM0->M0_CGC,6,3)+"/"+SUBSTR(SM0->M0_CGC,9,4)+"-"+SUBSTR(SM0->M0_CGC,13,2),oFt2b,100)
     oPrn:Say( 1260,1800,cAgencia+"/"+cConta,oFt2b,100)
     

     oPrn:Say( 1301,085,"Data do Documento",oFont7,100)
     oPrn:Say( 1301,360,"Número Documento",oFont7,100)
     oPrn:Say( 1301,790,"Espécie Doc.",oFont7,100)
     oPrn:Say( 1301,998,"Aceite",oFont7,100)
     oPrn:Say( 1301,1200,"Data de processamento",oFont7,100)
     oPrn:Say( 1301,1672,"Nosso Número",oFont7,100)            
     oPrn:Say( 1335,100,_cDtDoc,oFt2b,100)

     oPrn:Say( 1335,415,_cNumdoc,oFt2b,100) 

     oPrn:Say( 1335,860,_cEspDoc,oFt2b,100)

     oPrn:Say( 1335,1025,_cAceite,oFt2b,100)

     oPrn:Say( 1335,1325,_cDtProc,oFt2b,100)  

     oPrn:Say( 1335,1830,SUBSTR(QRY->E1_NUMBCO,1,3)+"/"+SUBSTR(QRY->E1_NUMBCO,4,8)+"-"+QRY->E1_NUMDV,oFt2b,100) 

     
     oPrn:Say( 1374,085,"Uso do Banco",oFont7,100) 
     oPrn:Say( 1374,415,"Carteira",oFont7,100)
     oPrn:Say( 1374,660,"Espécie",oFont7,100)
     oPrn:Say( 1374,810,"Quantidade",oFont7,100)

     oPrn:Say( 1374,1200,"Valor",oFont7,100)        
     oPrn:Say( 1374,1672," (=) Valor do Documento",oFont7,100) 
     oPrn:Say( 1399,452,_cCartDoc,oFt2b,100)
     oPrn:Say( 1399,685,_cEspMoeda,oFt2b,100)     
     oPrn:Say( 1399,1830,Trans(_nSaldo,"@E@R 999,999,999.99"),oFt2b,100) 


 
     oPrn:Say( 1447,085,"Instruções(Todas informações deste boleto são de exclusiva responsabilidade do cedente)",oFont7,100)        
     oPrn:Say( 1447,1672," (-) Desconto /Abatimento",oFont7,100)

     oPrn:Say( 1600,1672," (+) Mora/Multa",oFont7,100)
     
     // Mensagens
     
     oPrn:Say( 1580,150,_cMsg1,oFt2b,100)
     oPrn:Say( 1610,150,_cMsg2,oFt2b,100)
     oPrn:Say( 1640,150,_cMsg3,oFt2b,100)
     oPrn:Say( 1670,150,_cMsg4,oFt2b,100)
     oPrn:Say( 1700,150,_cMsg5,oFt2b,100)
     
     
     //oPrn:Say( 1570,150,"Acréscimo por dia de atraso",oFt2b,100)
     //oPrn:Say( 1570,550,Trans(QRY->E1_VALJUR,"@E@R 999,999,999.99"),oFt2b,100) 
     //oPrn:Say( 1616,150,"Multa por atraso",oFt2b,100)
     //oPrn:Say( 1632,550,Trans(QRY->E1_MULTA,"@E@R 999,999,999.99"),oFt2b,100)  
     //oPrn:Say( 1675,150,"MENS."+SubStr(QRY->E1_VENCTO,5,2)+"/"+SubStr(QRY->E1_VENCTO,1,4),oFt2b,100)
     
     oPrn:Say( 1750,1672," (=) Valor Cobrado",oFont7,100)     

     //oPrn:Say( 1780,150,"("+ALLTRIM(QRY->A1_CURSO)+ " - "+SUBSTR(QRY->E1_MAT,3,2)+"/"+SUBSTR(QRY->E1_MAT,5,1)+" - "+ALLTRIM(QRY->Z3_DESC)+ ")",oFont7,100)

     oPrn:Say( 1820,085,"Sacado",oFont7,100)
     oPrn:Say( 1840,200,_cSacado ,oFt3b,100)
     //oPrn:Say( 1840,500,+"-   "+QRY->A1_NOME,oFt3b,100)
     oPrn:Say( 1885,085,"Sacador/Avalista",oFont7,100)     
     oPrn:Say( 1885,1840,"Código de Baixa",oFont7,100) 
     
     
     oPrn:Say( 1923,1650,"Autenticação Mecânica",oFont7,100)

     oPrn:Say( 2127,082,"CORTE AQUI",oFont5,100)
     
//************************************************************   
// 3ª faixa do boleto

     oPrn:Say( 2215,735, "341-7",oFt5b,100)
     oPrn:Say( 2240,220, "Banco Itaú S.A.",oFt2b,100)
     oPrn:Say( 2230,970, SeqRN,oFont142,100)
  
     

     oPrn:Say( 2287,085,"Local de Pagamento",oFont7,100)

     oPrn:Say( 2287,1672,"Vencimento",oFont7,100)
     oPrn:Say( 2320,100,_cLocPag1,oFt2b,100)
     oprn:Say( 2349,100,_cLocPag2,oFt2b,100)
     oPrn:Say( 2340,1950,_cVencto,oFt2b,100)

     
     oPrn:Say( 2384,085,"Cedente",oFont7,100)

     oPrn:Say( 2384,1672,"Agencia/Código Cedente",oFont7,100)
     oPrn:Say( 2410,085,_cCedente,oFt2b,100)
     //oPrn:Say( 2410,380,"CGC",oFt2b,100)
     //oPrn:Say( 2410,460,SUBSTR(SM0->M0_CGC,1,2)+"."+SUBSTR(SM0->M0_CGC,3,3)+"."+SUBSTR(SM0->M0_CGC,6,3)+"/"+SUBSTR(SM0->M0_CGC,9,4)+"-"+SUBSTR(SM0->M0_CGC,13,2),oFt2b,100)
     oPrn:Say( 2410,1800,cAgencia+"/"+cConta,oFt2b,100)
     

     oPrn:Say( 2451,085,"Data do Documento",oFont7,100)
     oPrn:Say( 2451,360,"Número Documento",oFont7,100)
     oPrn:Say( 2451,790,"Espécie Doc.",oFont7,100)
     oPrn:Say( 2451,998,"Aceite",oFont7,100)
     oPrn:Say( 2451,1200,"Data de processamento",oFont7,100)
     oPrn:Say( 2451,1672,"Nosso Número",oFont7,100)            
     oPrn:Say( 2485,100,_cDtDoc,oFt2b,100)
     oPrn:Say( 2485,415,_cNumDoc,oFt2b,100) 
     oPrn:Say( 2485,860,_cEspDoc,oFt2b,100)
     oPrn:Say( 2485,1025,_cAceite,oFt2b,100)
     oPrn:Say( 2485,1325,_cDtProc,oFt2b,100)  
     oPrn:Say( 2485,1830,SUBSTR(QRY->E1_NUMBCO,1,3)+"/"+SUBSTR(QRY->E1_NUMBCO,4,8)+"-"+QRY->E1_NUMDV,oFt2b,100) 

     
     oPrn:Say( 2524,085,"Uso do Banco",oFont7,100) 
     oPrn:Say( 2524,415,"Carteira",oFont7,100)
     oPrn:Say( 2524,660,"Espécie",oFont7,100)
     oPrn:Say( 2524,810,"Quantidade",oFont7,100)
     oPrn:Say( 2524,1200,"Valor",oFont7,100)        
     oPrn:Say( 2524,1672," (=) Valor do Documento",oFont7,100) 
     oPrn:Say( 2549,452,_cCartdoc,oFt2b,100)
     oPrn:Say( 2549,685,_cEspMoeda,oFt2b,100)     
     oPrn:Say( 2549,1830,Trans(_nSaldo ,"@E@R 999,999,999.99"),oFt2b,100)
     
 
     oPrn:Say( 2597,085,"Instruções(Todas informações deste boleto são de exclusiva responsabilidade do cedente)",oFont7,100)        
     oPrn:Say( 2597,1672," (-) Desconto /Abatimento",oFont7,100)
     oPrn:Say( 2750,1672," (+) Mora/Multa",oFont7,100)
    
     // Mensagens
     
     oPrn:Say( 2720,150,_cMsg1,oFt2b,100)
     oPrn:Say( 2750,150,_cMsg2,oFt2b,100)
     oPrn:Say( 2780,150,_cMsg3,oFt2b,100)
     oPrn:Say( 2810,150,_cMsg4,oFt2b,100)
     oPrn:Say( 2840,150,_cMsg5,oFt2b,100)     
 
     
     //oPrn:Say( 2720,150,"Acréscimo por dia de atraso",oFt2b,100)
     //oPrn:Say( 2720,550,Trans(QRY->E1_VALJUR,"@E@R 999,999,999.99"),oFt2b,100)
     //oPrn:Say( 2766,150,"Multa por atraso",oFt2b,100)
     //oPrn:Say( 2782,550,Trans(QRY->E1_MULTA,"@E@R 999,999,999.99"),oFt2b,100) 
     
    //Prn:Say( 625,1600," (+) Outros Acréscimos",oFont7,100)
     //oPrn:Say( 2824,150,"MENS."+SubStr(QRY->E1_VENCTO,5,2)+"/"+SubStr(QRY->E1_VENCTO,1,4),oFt2b,100)
     oPrn:Say( 2900,1672," (=) Valor Cobrado",oFont7,100)     
    // oPrn:Say( 748,1600,Repli('_',400),oFont7,100)
     //oPrn:Say( 2915,150,"("+ALLTRIM(QRY->A1_CURSO)+ " - "+SUBSTR(QRY->E1_MAT,3,2)+"/"+SUBSTR(QRY->E1_MAT,5,1)+" - "+ALLTRIM(QRY->Z3_DESC)+ ")",oFont7,100)

     oPrn:Say( 2970,085,"Sacado",oFont7,100)
     oPrn:Say( 2990,150,_cSacado,oFt3b,100)
     //oPrn:Say( 2990,500,+"-   "+QRY->A1_NOME,oFt3b,100)
     oPrn:Say( 3035,085,"Sacador/Avalista",oFont7,100)     
     oPrn:Say( 3035,1840,"Código de Baixa",oFont7,100) 
     
     
     oPrn:Say( 3073,1650,"Autenticação Mecânica - FICHA DE COMPENSAÇÃO",oFont7,100)
     
     MSBAR("INT25",27,1,SeqCB,oPrn,NIL,NIL,.t.,,1.3,NIL,NIL,NIL,lPrint)

     oPrn:EndPage()


     
     DbSelectArea("QRY")
     DbSkip()
                 
EndDo

DbSelectArea("QRY")
DbCloseArea()   
//-----  Término Boleto Itau

Return




Static Function BoletoBradesco()
//-----  Início Boleto Bradesco

pergunte( cperg, .f.) 
MontaQuery()
dbSelectArea("QRY")
SetRegua(RecCount('QRY'))
dbGoTop()

While !EOF()
    IncRegua()               
  	While !eof() .and. Empty(QRY->E1_BAIXA) .AND. QRY->E1_VENCTO < DTOS(dDATABASE) .AND. STR(_mvpar08,1)=="2" 
    	DBSKIP()
    	IncRegua()
   	ENDDO                  
    
		//----- Verifica o cancelamento pelo usuario...
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif       
   
   
		//----- Busca informacoes para linha digitavel e codigo de barras
    DbSelectArea('SEE')
    DbSetOrder(1)
    Dbseek( xFilial()+'237'+QRY->EA_AGEDEP+QRY->EA_NUMCON )
		_cConta		:=	QRY->EA_NUMCON
		fLimpaConta()                                          
		_cConta		:= StrZero(val(_cCtaLimpa),7)             
		

    _cAgConv	:= 	Strzero(val(QRY->EA_AGEDEP),4)
    _cNossoNum:=	Alltrim(QRY->E1_NUMBCO)
    _cNumDv		:=	QRY->E1_NUMDV
    _nTotAbat := 0
    _nSaldo		:=	QRY->E1_SALDO                 
    _cCarteira:=	'09'      
    
    _cFatorVct:= FatorVencto(QRy->E1_VENCTO)  // Calcula Fator de Vencimento

		dbSelectArea("QRY")
		//----- Montagem do Codigo de Barras
		//  		Usando Faixa Livre, conf. Manual Banco Bandeirantes 
		//      Versao 3.0  Nov/1998  Adequado ao Ano 2000

    //----- Codigo de Barras
    //  		237MXVVVVVVVVVVVVVVAAAACCaaNNNNNNNNNccccccc0
    //      onde: 
    //			237		= fixo
    //			M			= codigo da moeda 9(Real)
    //			X			= dac 5 o mesmo calculado para o codigo de barras
    //			V			= valor do documento  9(12)V9(2)
    //			A			= agencia cedente
    //			C			= carteira
    //			a			= ano do nosso numero
    //			N			= numero do nosso numero
    //			c			= conta do cedente
    //			0			= zeros 

    _cCodBar			:=	'237'+'9'+_cFatorVct+strzero(int(_nSaldo*100),10)+_cAgConv+_cCarteira+_cNossoNum+_cConta+'0'
		_cNros 				:= _cCodBar
		CalcMod11()
		_cDVCodBar 		:=	_cDV
    //---- Inserindo DAC 5 no Codigo de Barras
		_cCodBar			:=	subs(_cCodBar,1,4)+ _cDvCodBar + Subs(_cCodBar,5)
		//Msgbox( _cCodBar, 'Codigo de Barras')
    //----- Montagem da Representacao Numerica (Linha Digitavel)     
		//  		Usando Faixa Livre, conf. Manual Banco Bandeirantes 
		//      Versao 3.0  Nov/1998  Adequado ao Ano 2000

    //----- Linha digitavel 
    //  		b230M9.99AADbACCCC.CNNNNDbbNNNNN.NNNN0DbbXbbVVVVVVVVVVVVVV
    //       ==========D ===========D  ===========D 
    //        campo 1      campo 2       campo3
    //      onde: 
    //			b			= branco
    //			237		= fixo
    //			M			= codigo da moeda 9(Real)
    //			A			= agencia cedente
    //			C			= carteira
    //			a			= ano do nosso numero
    //			N			= numero do nosso numero
    //			c			= conta do cedente
    //			0			= zeros 
    //			X			= dac 5 o mesmo calculado para o codigo de barras
    //			V			= valor do documento
    //			.			= ponto separador
    //			D			= Digito calculado pelo modulo 10


		_cLinDig	:=	'237'+'9'+_cAgConv+_cCarteira+_cNossoNum+_cConta+'0'
    _cCampo1	:=	Subs(_cLinDig,1,9)
    _cCampo2	:=	Subs(_cLindig,10,10)
    _cCampo3	:=	subs(_cLindig,20,10)
                                                                   
	  //----- Calcula digitos do campos 1, 2, 3
		_cNros :=		_cCampo1
		CalcMod10()
		_cDvCpo1	:= _cDV
		
		_cNros :=		_cCampo2
		CalcMod10()
		_cDvCpo2	:= _cDV
		
		_cNros :=		_cCampo3
		CalcMod10()
		_cDvCpo3	:= _cDV

    //  		b230M9.99AADbACCCC.CNNNNDbbNNNNN.NNNN0DbbXbbVVVVVVVVVVVVVV
		_cLinDig	:=           ' '+subs(_cCampo1,1,5)+'.'+subs(_cCampo1,6,4)+_cDvCpo1+' '
		_cLinDig 	:= _cLinDig     +subs(_cCampo2,1,5)+'.'+subs(_cCampo2,6,5)+_cDvCpo2+'  ' 
		_cLinDig 	:= _cLinDig     +subs(_cCampo3,1,5)+'.'+subs(_cCampo3,6,5)+_cDvCpo3+'  '
		_cLinDig 	:= _cLinDig     +_cDvCodBar+'  '
		_cLinDig 	:= _cLinDig     +_cFatorVct+strzero(int(_nSaldo*100),10)

		//----- Monta Variaveis para impressao no Boleto
		_cLocalPagt	:=	"Pagável preferencialmente em qualquer agência Bradesco"
     
		_cCedente		:=	Alltrim(SM0->M0_NOMECOM)+'   CGC: '+SUBSTR(SM0->M0_CGC,1,2)+"."+SUBSTR(SM0->M0_CGC,3,3)+"."+SUBSTR(SM0->M0_CGC,6,3)+"/"+SUBSTR(SM0->M0_CGC,9,4)+"-"+SUBSTR(SM0->M0_CGC,13,2)
		_cVencto    :=SubStr(QRY->E1_VENCTO,7,2)+"/"+ SubStr(QRY->E1_VENCTO,5,2)+"/"+SubStr(QRY->E1_VENCTO,1,4)
     
		_cCIP				:=	'263'
		_cCense			:=	'8650'
		_cMoeda			:=	'REAL'
		_cDtDoc     :=SubStr(QRY->E1_EMISSAO,7,2)+"/"+ SubStr(QRY->E1_EMISSAO,5,2)+"/"+SubStr(QRY->E1_EMISSAO,1,4)
		_cDtProc    :=SubStr(QRY->E1_EMISSAO,7,2)+"/"+ SubStr(QRY->E1_EMISSAO,5,2)+"/"+SubStr(QRY->E1_EMISSAO,1,4)
		_cNumdoc		:=	QRY->E1_PREFIXO+'-'+QRY->E1_NUM+'-'+QRY->E1_PARCELA
		_cEspDoc		:=	'99'
		_cAceite		:=	'N'   
		_nValjur		:=	QRY->E1_VALJUR
		//_nMulta			:=	_nSaldo * GetMV('MV_MULTFAC')
		_cSacado		:=	QRY->E1_MAT+'  '+QRY->A1_COD+'-'+QRY->A1_LOJA+'  '+QRY->A1_NOME
		

		_cMsg1			:= 'MENS.'+SUBS(QRY->E1_EMISSAO,5,2)+'/'+SUBS(QRY->E1_EMISSAO,1,4)
		_cMsg2      := IIF(	QRY->E1_VALJUR>0, 'ACRESCIMO POR DIA DE ATRASO R$'+ALLTRIM(STR(QRY->E1_VALJUR,17,2)), '')
		//_cMsg3			:=	'MULTA POR ATRASO R$'+ALLTRIM(STR((GETMV('MV_MULTFAC')*(QRY->E1_SALDO-EXECBLOCK('FACFI20')))/100, 17,2))
		_cMsg4			:=	MsgAbat()// EXECBLOCK('FACFI25', .F.,.F.)
		
		_nMulta			:=	(_nSaldo - _nTotAbat) * GetMV('MV_MULTFAC') / 100
  	_cMsg3			:=	'MULTA POR ATRASO R$'+ALLTRIM(STR(_nMulta, 17,2))
	
    /*/ TESTAIMP()            
    
     DbSkip()
   //  oPrn:EndPage()            
EndDo
DbCloseArea()      
	return
      
static function lixo()    
   /*/   
   //---------------------------------------------------------- 
     
     
     // Inicio da impressao do boleto
     // Primeira parte - Recibo do Sacado


     oPrn:StartPage()

		 //----- Boxes 1ª parte do boleto
     oPrn:Box( 160,870,260,871)
     oPrn:Box( 160,1085,260,1086)                          
     oPrn:Box( 260, 230,825,2330)
     oPrn:Box( 265,1190,345,1191)
     oPrn:Box( 265,1540,320,1541)
     oPrn:Box( 265,2090,345,2091)
     oPrn:Say( 320, 230, Repli('_',161),oFt1b,100)
     oPrn:Box( 345, 1865,825,1866)
     oPrn:Box( 345,415,415,416)
     oPrn:Box( 345,540,415,541)
     oPrn:Box( 345,800,415,801)
     oPrn:Box( 345,1090,415,1091)
     oPrn:Box( 321,1540,415,1541)
     oPrn:Say( 393,230, Repli('_',161),oFt1b,100)
     oPrn:Box( 422,500,495,501)
     oPrn:Box( 422,1090,495,1091)
     oPrn:Box( 422,1390,495,1391)
     oPrn:Box( 422,1540,495,1541)
     oPrn:Say( 470, 230, Repli('_',161),oFt1b,100)
     oPrn:Say( 530,1871,Repli("_",043),oFt1b,100) 
     oPrn:Say( 605,1871,Repli("_",043),oFt1b,100)
     oPrn:Say( 680,230, Repli('_',161),oFt1b,100) 
     oPrn:Say( 910,230, Repli('- ',176),oFt1b,100)
      

		 //----- Boxes 2ª parte do boleto

     oPrn:Box( 1160,870,1260,871)
     oPrn:Box( 1160,1085,1260,1086)                          
     oPrn:Box( 1260, 230,2075,2330)
     oPrn:Say( 1320, 230, Repli('_',161),oFt1b,100)
     oPrn:Say( 1410,230, Repli('_',161),oFt1b,100)
     oPrn:Box( 1260,1870,1960,1871)
     oPrn:Box( 1435,495,1515,496)
     oPrn:Box( 1435,780,1515,781)
     oPrn:Box( 1435,1190,1515,1191)
     oPrn:Box( 1435,1540,1515,1541)
     oPrn:Say( 1490,230, Repli('_',161),oFt1b,100) 
     oPrn:Box( 1515,415,1620,416)
     oPrn:Box( 1515,540,1620,541)
     oPrn:Box( 1515,800,1620,801)
     oPrn:Box( 1515,1090,1620,1091)
     oPrn:Box( 1515,1540,1620,1541)
     oPrn:Say( 1595,230, Repli('_',161),oFt1b,100)
     oPrn:Say( 1665,1871,Repli("_",043),oFt1b,100)
     oPrn:Say( 1735,1871, Repli('_',043),oFt1b,100)
     oPrn:Say( 1800,1871,Repli("_",043),oFt1b,100)
     oPrn:Say( 1865,1871,Repli("_",043),oFt1b,100)
     oPrn:Say( 1940,230, Repli('_',161),oFt1b,100) 
     oPrn:Say( 2180,230, Repli('- ',150),oFt1b,100) 

		 //----- Boxes 3ª parte do boleto

     oPrn:Box( 2260,820,2360,821)
     oPrn:Box( 2260,1035,2360,1036)                          
     oPrn:Box( 2360, 230,3180,2330)
     oPrn:Say( 2420, 230, Repli('_',161),oFt1b,100)
     oPrn:Say( 2510,230, Repli('_',161),oFt1b,100)
     oPrn:Box( 2360,1870,3075,1871)
     oPrn:Box( 2538,495,2614,496)
     oPrn:Box( 2538,780,2614,781)
     oPrn:Box( 2538,1190,2614,1191)
     oPrn:Box( 2538,1540,2614,1541)
     oPrn:Say( 2590,230, Repli('_',161),oFt1b,100) 
     oPrn:Box( 2620,415,2705,416)
     oPrn:Box( 2620,540,2705,541)
     oPrn:Box( 2620,800,2705,801)
     oPrn:Box( 2620,1090,2705,1091)
     oPrn:Box( 2620,1540,2705,1541)
     oPrn:Say( 2680,230, Repli('_',161),oFt1b,100)
     oPrn:Say( 2755,1871,Repli("_",043),oFt1b,100)
     oPrn:Say( 2825,1871, Repli('_',043),oFt1b,100)
     oPrn:Say( 2890,1871,Repli("_",043),oFt1b,100)
     oPrn:Say( 2960,1871,Repli("_",043),oFt1b,100)
     oPrn:Say( 3050,230, Repli('_',161),oFt1b,100)








     //----- texto 1ª parte do boleto
        
     oPrn:Say( 145,890, "Banco",oFt1b,100)
     oPrn:Say( 175,245, "BRADESCO",oFt5b,100)
     oPrn:Say( 205,580, " CGC 60.746.948",oFt15,100)        
     oPrn:Say( 175,890, "237-2",oFt5b,100)
     oPrn:Say( 200,1900, "Recibo do Sacado",oFt3b,100)
     oPrn:Say( 270,240,"Cedente/Sacador",oFt1,100)
     oPrn:Say( 270,1200,"  Agencia/Código Cedente",oFt1,100)
     oPrn:Say( 305,280,_cCedente,oFt2b,100)
     oPrn:Say( 305,1220,_cAgConv+"/"+_cConta+"-"+_cDvConta,oFt2b,100)
     oPrn:Say( 270,1550,"  Nosso Número",oFt1,100)            
     oPrn:Say( 305,1620,_cCarteira+'/'+_cNossoNum+"-"+_cNumDv,oFt2b,100) 
     oPrn:Say( 270,2100,"  Vencimento",oFt1,100)
     oPrn:Say( 305,2105,_cVencto,oFt2b,100)
     oPrn:Say( 350,240,"Cip",oFt1,100)
     oPrn:Say( 380,290,_cCip,oFt2b,100) 
     oPrn:Say( 350,425,"Cense",oFt1,100)
     oPrn:Say( 380,445,_cCense,oFt2b,100)
     oPrn:Say( 350,550,"Carteira",oFt1,100)
     oPrn:Say( 380,620,_cCarteira,oFt2b,100)
     oPrn:Say( 350,820,"Moeda",oFt1,100)
     oPrn:Say( 380,860,_cMoeda,oFt2b,100)
     oPrn:Say( 350,1100," Quantidade",oFt1,100)
     oPrn:Say( 350,1550,"Valor",oFt1,100)        
     oPrn:Say( 370,1532,"X",oFt1,100)        
     oPrn:Say( 350,1885,"= Valor do Documento",oFt1,100)
     oPrn:Say( 380,1930,Trans(_nSaldo, "@E@R 999,999,999.99"),oFt2b,100)
     oPrn:Say( 425,240,"Data do Documento",oFt1,100)
     oPrn:Say( 455,270,_cDtDoc,oFt2b,100)
     oPrn:Say( 425,505," Número Documento",oFt1,100)
     oPrn:Say( 455,520,_cNumDoc,oFt2b,100) 
     oPrn:Say( 425,1100," Espécie Documento",oFt1,100)
     oPrn:Say( 455,1150,_cEspDoc,oFt2b,100) 
     oPrn:Say( 425,1400," Aceite",oFt1,100)
     oPrn:Say( 455,1450,_cAceite,oFt2b,100) 
     oPrn:Say( 425,1550," Data de processamento",oFt1,100)
     oPrn:Say( 455,1600,_cDtProc,oFt2b,100)  
     oPrn:Say( 425,1885,"(-) Outras deduções",oFt1,100)
     oPrn:Say( 500,240,"Instruções",oFt1,100)        
     oPrn:Say( 500,1885,"(-) Desconto",oFt1,100)

     //-----  Mensagens

     oPrn:Say( 540,310,_cMsg1,oFt2b,100)
     oPrn:Say( 570,310,_cMsg2,oFt2b,100)
     oPrn:Say( 600,310,_cMsg3,oFt2b,100)
     oPrn:Say( 630,310,_cMsg4,oFt2b,100)


     //oPrn:Say( 580,310,"Acréscimo por dia de atraso",oFt2b,100)
     //oPrn:Say( 580,700,Trans(_nValJur, "@E@R 999,999,999.99"),oFt2b,100) // PICTURE("@E@R 999,999,999.99")
     oPrn:Say( 565,1880,"(+) Mora/Multa",oFt1,100)
     //oPrn:Say( 625,310,"Multa por atraso",oFt2b,100)
     //oPrn:Say( 630,700,Trans(_nMulta, "@E@R 999,999,999.99"),oFt2b,100)// PICTURE "@E@R 999,999,999.99"
     oPrn:Say( 630,1880,"(+) Outros Acréscimos",oFt1,100)
    // oPrn:Say( 666,310,"("+ALLTRIM(QRY->A1_CURSO)+ " - "+SUBSTR(QRY->E1_MAT,3,2)+"/"+SUBSTR(QRY->E1_MAT,5,1)+" - "+ALLTRIM(QRY->Z3_DESC)+ ")",oFt1,100) 
     oPrn:Say( 710,1880,"(=) Valor Cobrado",oFt1,100)      
     oPrn:Say( 710,240,"Sacado",oFt1,100)
     oPrn:Say( 737,300,_cSacado,oFt3b,100)
     oPrn:Say( 795,240,"Sacador Cedente",oFt1,100)     
     oPrn:Say( 940,230,"CORTE AQUI",oFt1,100)      
     oPrn:Say( 940,1550,"Autenticação Mecânica",oFt1,100)           
 
     
		//---- 2ª parte textos do boleto


     oPrn:Say( 1145,890, "Banco",oFt1b,100)
     oPrn:Say( 1175,245, "BRADESCO",oFt5b,100)
     oPrn:Say( 1205,580, " CGC 60.746.948",oFt15,100)
     oPrn:Say( 1175,890, "237-2",oFt5b,100)
     oPrn:Say( 1200,1930, "Ficha de Caixa",oFt3b,100)
     oPrn:Say( 1270,240,"Local de Pagamento",oFt1,100)
     oPrn:Say( 1305,270,	_cLocalPagt,oFt2b,100)
     oPrn:Say( 1270,1885,"  Vencimento",oFt1,100)
     oPrn:Say( 1305,1910,_cVencto,oFt2b,100)
     oPrn:Say( 1350,240,"Cedente/Sacador",oFt1,100)
     oPrn:Say( 1350,1880,"  Agencia/Código Cedente",oFt1,100)
     oPrn:Say( 1380,280,_cCedente,oFt2b,100)
     oPrn:Say( 1380,1900,_cAgConv+"/"+_cConta+"-"+_cDvConta,oFt2b,100)
     oPrn:Say( 1440,240,"Data do Documento",oFt1,100)
     oPrn:Say( 1470,270,_cDtDoc,oFt2b,100)
     oPrn:Say( 1440,505," Número Documento",oFt1,100)
     oPrn:Say( 1470,520,_cNumDoc,oFt2b,100) 
     oPrn:Say( 1440,790," Espécie Documento",oFt1,100)
     oPrn:Say( 1470,800,_cEspDoc,oFt2b,100) 
     oPrn:Say( 1440,1200," Aceite",oFt1,100)
     oPrn:Say( 1470,1250,_cAceite,oFt2b,100) 
     oPrn:Say( 1440,1550," Data de processamento",oFt1,100)
     oPrn:Say( 1470,1600,_cDtProc,oFt2b,100)  
     oPrn:Say( 1440,1885,"Nosso Número",oFt1,100)            
     oPrn:Say( 1470,1900,_cCarteira+'/'+_cNossoNum+"-"+_cNumDv,oFt2b,100) 
     oPrn:Say( 1530,240,"Cip",oFt1,100)
     oPrn:Say( 1560,290,_cCip,oFt2b,100) 
     oPrn:Say( 1530,425,"Cense",oFt1,100)
     oPrn:Say( 1560,445,_cCense,oFt2b,100)
     oPrn:Say( 1530,550,"Carteira",oFt1,100)
     oPrn:Say( 1560,620,_cCarteira,oFt2b,100)
     oPrn:Say( 1530,820,"Moeda",oFt1,100)
     oPrn:Say( 1560,860,_cMoeda,oFt2b,100)
     oPrn:Say( 1530,1100," Quantidade",oFt1,100)
     oPrn:Say( 1530,1550,"Valor",oFt1,100)        
     oPrn:Say( 1530,1885," = Valor do Documento",oFt1,100)             
     oPrn:Say( 1560,1900,Trans(_nSaldo, "@E@R 999,999,999.99"),oFt2b,100)
     oPrn:Say( 1630,240,"Instruções",oFt1,100)        
     oPrn:Say( 1630,1885,"(-) Desconto",oFt1,100)
     oPrn:Say( 1700,1885," (-) Outras deduções",oFt1,100)
     oPrn:Say( 1765,1885," (+) Mora/Multa",oFt1,100) 
     oPrn:Say( 1830,1880," (+) Outros Acréscimos",oFt1,100)
     oPrn:Say( 1895,1880," (=) Valor Cobrado",oFt1,100)      
     oPrn:Say( 1970,240,"Sacado",oFt1,100)
     oPrn:Say( 2000,300,_cSacado,oFt3b,100)
     oPrn:Say( 2040,240,"Sacador Cedente",oFt1,100)     
     oPrn:Say( 2090,1550,"Autenticação Mecânica",oFt1,100)           

     //-----  Mensagens

     oPrn:Say( 1730,310,_cMsg1,oFt2b,100)
     oPrn:Say( 1760,310,_cMsg2,oFt2b,100)
     oPrn:Say( 1790,310,_cMsg3,oFt2b,100)
     oPrn:Say( 1820,310,_cMsg4,oFt2b,100)

   
     
			//----- 3ª parte do boleto


     oPrn:Say( 2245,890, "Banco",oFt1b,100)
     oPrn:Say( 2275,245, "BRADESCO",oFt5b,100)
     oPrn:Say( 2305,530, " CGC 60.746.948",oFt15,100)
     oPrn:Say( 2275,840, "237-2",oFt5b,100)
     oPrn:Say( 2300,1050,_cLinDig ,oFt2b,100)
     oPrn:Say( 2370,240,"Local de Pagamento",oFt1,100)
     oPrn:Say( 2405,270,_cLocalPagt,oFt2b,100)
     oPrn:Say( 2370,1885,"  Vencimento",oFt1,100)
     oPrn:Say( 2405,1930,_cVencto,oFt2b,100)
     oPrn:Say( 2450,240,"Cedente/Sacador",oFt1,100)
     oPrn:Say( 2450,1880,"  Agencia/Código Cedente",oFt1,100)
     oPrn:Say( 2480,280,_cCedente,oFt2b,100)
     oPrn:Say( 2480,1900,_cAgConv+"/"+_cConta+"-"+_cDvConta,oFt2b,100)
     oPrn:Say( 2540,240,"Data do Documento",oFt1,100)
     oPrn:Say( 2570,270,_cDtDoc,oFt2b,100)
     oPrn:Say( 2540,505," Número Documento",oFt1,100)
     oPrn:Say( 2570,520,_cNumDoc,oFt2b,100) 
     oPrn:Say( 2540,790," Espécie Documento",oFt1,100)
     oPrn:Say( 2570,800,_cEspDoc,oFt2b,100) 
     oPrn:Say( 2540,1200," Aceite",oFt1,100)
     oPrn:Say( 2570,1250,_cAceite,oFt2b,100) 
     oPrn:Say( 2540,1550," Data de processamento",oFt1,100)
     oPrn:Say( 2570,1600,_cDtProc,oFt2b,100)  
     oPrn:Say( 2540,1885,"Nosso Número",oFt1,100)            
     oPrn:Say( 2570,1900,_cCarteira+'/'+_cNossoNum+"-"+_cNumDv,oFt2b,100) 
     oPrn:Say( 2620,240,"Cip",oFt1,100)
     oPrn:Say( 2650,290,_cCip,oFt2b,100) 
     oPrn:Say( 2620,425,"Cense",oFt1,100)
     oPrn:Say( 2650,445,_cCense,oFt2b,100)
     oPrn:Say( 2620,550,"Carteira",oFt1,100)
     oPrn:Say( 2650,620,_cCarteira,oFt2b,100)
     oPrn:Say( 2620,820,"Moeda",oFt1,100)
     oPrn:Say( 2650,860,_cMoeda,oFt2b,100)
     oPrn:Say( 2620,1100," Quantidade",oFt1,100)
     oPrn:Say( 2620,1550,"Valor",oFt1,100)        
     oPrn:Say( 2620,1885," = Valor do Documento",oFt1,100)             
     oPrn:Say( 2650,1900,Trans(_nSaldo, "@E@R 999,999,999.99"),oFt2b,100)
     oPrn:Say( 2710,240,"Instruções",oFt1,100)        
     oPrn:Say( 2710,1885,"(-) Desconto",oFt1,100)
     oPrn:Say( 2785,1885," (-) Outras deduções",oFt1,100)
     oPrn:Say( 2855,1885," (+) Mora/Multa",oFt1,100) 
     oPrn:Say( 2925,1880," (+) Outros Acréscimos",oFt1,100)
     oPrn:Say( 2995,1880," (=) Valor Cobrado",oFt1,100)
     oPrn:Say( 3080,240,"Sacado",oFt1,100)
     oPrn:Say( 3100,300,_cSacado,oFt3b,100)
     oPrn:Say( 3145,240,"Sacador Cedente",oFt1,100)     
     oPrn:Say( 3200,1850,"Autenticação Mecânica",oFt1b,100)           
     oPrn:Say( 3230,1700,"Ficha de Compensação",oFt3b,100)           

     //-----  Mensagens

     oPrn:Say( 2840,310,_cMsg1,oFt2b,100)
     oPrn:Say( 2870,310,_cMsg2,oFt2b,100)
     oPrn:Say( 2900,310,_cMsg3,oFt2b,100)
     oPrn:Say( 2930,310,_cMsg4,oFt2b,100)
     
     MSBAR("INT25",27.6,2.4,_cCodBar,oPrn,,,.t.,0.028,1.3,nil,nil,nil,.f.)
		 //---- impressao do conteudo do codigo de barras bradesco 
     oPrn:Say( 3145,640,_cCodBar,oFt1b,100)
 


     DbSelectArea('QRY')
     DbSkip()
     oPrn:EndPage()            
EndDo


DbCloseArea()      

Return


Static Function BoletoBandeirantes()
	//----- Impressao do Boleto Bandeirantes

  
	pergunte( cperg, .f.) 
	MontaQuery()

	dbSelectArea("QRY")
	SetRegua(RecCount("QRY"))
	dbGoTop()

	While !EOF()            
	  IncRegua()
    //----- Só Considera Titulos Abertos e ainda não vencidos e alunos Sem Debito             
  	WHILE ! EOF() .AND. EMPTY(QRY->E1_BAIXA) .AND. QRY->E1_VENCTO < DTOS(dDATABASE) .AND. STR(_mvpar08,1)=="2" 
     	DbSkip()
     	IncRegua()
	  EndDO
    
		//----- Verifica o cancelamento pelo usuario...                             ³
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif       
    //----- Busca informacoes para linha digitavel e codigo de barras
    DbSelectArea('SEE')
    DbSetOrder(1)
    Dbseek( xFilial()+'230'+QRY->EA_AGEDEP+QRY->EA_NUMCON )
    _cFxConv	:=	StrZero(Val(Alltrim(SEE->EE_CODEMP)),5)
    _cAgConv	:= 	Strzero(val(QRY->EA_AGEDEP),3)
    _cNossoNum:=	Alltrim(QRY->E1_NUMBCO)
    _cNumDv		:=	QRY->E1_NUMDV
    _nTotAbat := 0
    _nSaldo		:=	QRY->E1_SALDO
		dbSelectArea("QRY")
		//----- Montagem do Codigo de Barras
		//  		Usando Faixa Livre, conf. Manual Banco Bandeirantes 
		//      Versao 3.0  Nov/1998  Adequado ao Ano 2000

    //----- Codigo de Barras
    //  		230MXVVVVVVVVVVVVV999AAACCCCCNNNNNNNNNNNNN0
    //      onde: 
    //			230		= fixo
    //			M			= codigo da moeda 9(Real)
    //			V			= valor do documento  9(12)V9(2)
    //			999		= fixo
    //			A			= codigo da agencia
    //			C			= codigo do cliente (faixa de convenio)
    //			N			= nosso numero
    //			X			= dac 5 o mesmo calculado para o codigo de barras
    //			0			= zeros 

    _cCodBar			:=	'230'+'9'+strzero(int(_nSaldo*100),14)+'999'+_cAgConv+_cFxConv+_cNossoNum+_cNumDv+'0'
		_cNros 				:= _cCodBar
		CalcMod11()
		_cDVCodBar 		:=	_cDV
    //---- Inserindo DAC 5 no Codigo de Barras
		_cCodBar			:=	subs(_cCodBar,1,4)+ _cDvCodBar + Subs(_cCodBar,5)
		
    //----- Montagem da Representacao Numerica (Linha Digitavel)     
		//  		Usando Faixa Livre, conf. Manual Banco Bandeirantes 
		//      Versao 3.0  Nov/1998  Adequado ao Ano 2000

    //----- Linha digitavel 
    //  		b230M9.99AADbACCCC.CNNNNDbbNNNNN.NNNN0DbbXbbVVVVVVVVVVVVVV
    //       ==========D ===========D  ===========D 
    //        campo 1      campo 2       campo3
    //      onde: 
    //			b			= branco
    //			230		= fixo
    //			M			= codigo da moeda 9(Real)
    //			999		= fixo
    //			.			= ponto separador
    //			D			= Digito calculado pelo modulo 10
    //			0			= zeros 
    //			A			= codigo da agencia
    //			C			= codigo do cliente (faixa de convenio)
    //			N			= nosso numero
    //			V			= valor do documento
    //			X			= dac 5 o mesmo calculado para o codigo de barras

		_cLinDig	:=	'230'+'9'+'999'+_cAgConv+_cFxConv+_cNossoNum+_cNumDv+'0'
    _cCampo1	:=	Subs(_cLinDig,1,9)
    _cCampo2	:=	Subs(_cLindig,10,10)
    _cCampo3	:=	subs(_cLindig,20,10)
                                                                   
		// MsgBox( _cLinDig, "facfi50_ap5-01 _cLinDig")
		// MsgBox( _cCampo1, "facfi50_ap5-02 _cCampo1")
		// MsgBox( _ccampo2, "facfi50_ap5-03 _cCampo2")
		// MsgBox( _ccampo3, "facfi50_ap5-04 _cCampo3")
  
    //----- Calcula digitos do campos 1, 2, 3
		_cNros :=		_cCampo1
		CalcMod10()
		_cDvCpo1	:= _cDV
		
		_cNros :=		_cCampo2
		CalcMod10()
		_cDvCpo2	:= _cDV
		
		_cNros :=		_cCampo3
		CalcMod10()
		_cDvCpo3	:= _cDV


		// MsgBox( _cCampo1+'-'+_cDvCpo1, "facfi50_ap5-05 _cCampo1")
		// MsgBox( _ccampo2+'-'+_cDvCpo2, "facfi50_ap5-06 _cCampo2")
		// MsgBox( _ccampo3+'-'+_cDvCpo3, "facfi50_ap5-07 _cCampo3")

    //  		b230M9.99AADbACCCC.CNNNNDbbNNNNN.NNNN0DbbXbbVVVVVVVVVVVVVV
		_cLinDig	:=           ' '+subs(_cCampo1,1,5)+'.'+subs(_cCampo1,6,4)+_cDvCpo1+' '
		_cLinDig 	:= _cLinDig     +subs(_cCampo2,1,5)+'.'+subs(_cCampo2,6,5)+_cDvCpo2+'  ' 
		_cLinDig 	:= _cLinDig     +subs(_cCampo3,1,5)+'.'+subs(_cCampo3,6,5)+_cDvCpo3+'  '
		_cLinDig 	:= _cLinDig     +_cDvCodBar+'  '
		_cLinDig 	:= _cLinDig     +Alltrim(str(int(_nSaldo*100)))


		//----- Monta Variaveis para impressao no Boleto
		_cLocalPagt	:=	"PAGÁVEL EM QUALQUER BANCO ATÉ O VENCIMENTO"
     
		_cCedente		:=	Alltrim(SM0->M0_NOMECOM)+'   CGC: '+SUBSTR(SM0->M0_CGC,1,2)+"."+SUBSTR(SM0->M0_CGC,3,3)+"."+SUBSTR(SM0->M0_CGC,6,3)+"/"+SUBSTR(SM0->M0_CGC,9,4)+"-"+SUBSTR(SM0->M0_CGC,13,2)
		_cVencto    :=SubStr(QRY->E1_VENCTO,7,2)+"/"+ SubStr(QRY->E1_VENCTO,5,2)+"/"+SubStr(QRY->E1_VENCTO,1,4)
     
		_cDtDoc     :=SubStr(QRY->E1_EMISSAO,7,2)+"/"+ SubStr(QRY->E1_EMISSAO,5,2)+"/"+SubStr(QRY->E1_EMISSAO,1,4)
		_cDtProc    :=SubStr(QRY->E1_EMISSAO,7,2)+"/"+ SubStr(QRY->E1_EMISSAO,5,2)+"/"+SubStr(QRY->E1_EMISSAO,1,4)
		_cNumdoc		:=	QRY->E1_PREFIXO+'-'+QRY->E1_NUM+'-'+QRY->E1_PARCELA
		_cEspDoc		:=	'01'
		_cAceite		:=	'N'   
		_nValjur		:=	QRY->E1_VALJUR
		//_nMulta			:=	_nSaldo * GetMV('MV_MULTFAC')
		_cSacado		:=	QRY->E1_MAT+'  '+QRY->A1_COD+'-'+QRY->A1_LOJA+'  '+QRY->A1_NOME
		_cCGCCedente:=	SUBSTR(SM0->M0_CGC,1,2)+"."+SUBSTR(SM0->M0_CGC,3,3)+"."+SUBSTR(SM0->M0_CGC,6,3)+"/"+SUBSTR(SM0->M0_CGC,9,4)+"-"+SUBSTR(SM0->M0_CGC,13,2)
    _cCartDoc		:=	'1'
    _cEspMoeda	:=	'R$'
		_cMsg1			:= 'MENS.'+SUBS(QRY->E1_EMISSAO,5,2)+'/'+SUBS(QRY->E1_EMISSAO,1,4)
    _cMsg2			:=	'.'
		_cMsg3      := IIF(	QRY->E1_VALJUR>0, 'ACRESCIMO POR DIA DE ATRASO R$'+ALLTRIM(STR(QRY->E1_VALJUR,17,2)), '')
		//_cMsg4			:=	'MULTA POR ATRASO R$'+ALLTRIM(STR((GETMV('MV_MULTFAC')*(QRY->E1_SALDO-EXECBLOCK('FACFI20')))/100, 17,2))
		_cMsg5			:=	MsgAbat()// EXECBLOCK('FACFI25', .F.,.F.)

    _nMulta			:=	(_nSaldo - _nTotAbat) * GetMV('MV_MULTFAC')		/ 100
    _cMsg4			:=	'MULTA POR ATRASO R$'+ALLTRIM(STR(_nMulta, 17,2))
    
// 20D2MENSAGEM 5     1622010IIF(EXECBLOCK('FACFI20',.F.,.F.)>0, 'CONCEDER DESCONTO DE  R$'+ALLTRIM(STR(EXECBLOCK('FACFI20'), 17, 2)) , ' ')                                                                                                                                                                                                                                                                                                                                                                           
// 20D2MENSAGEM 6     2022410IIF(EXECBLOCK('FACFI24',.F.,.F.)=='C','REFERENTES A CREDITO EDUCATIVO', IIF(EXECBLOCK('FACFI24',.F.,.F.)='B','REFERENTES A BOLSAS DE ESTUDO',' ' ))                                                                                                                                                                                                                                                                                                                                       
// 20D2MENSAGEM 7     2422810                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
// 20D2MENSAGEM 8     2823210                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          


  
 
     //-------------- fim calculo digitos dos campos 1,2,3 modulo 10
    cAgencia:=QRY->EA_AGEDEP
    cConta:=SUBSTR(QRY->EA_NUMCON,1,3)+SUBSTR(QRY->EA_NUMCON,5,3)+SUBSTR(QRY->EA_NUMCON,9,1)
    
    // Montagem da cadeia do codigo de barras (sem o DAC)
                //Identificacao do banco+codigo da moeda + valor do titulo +               codigo da agencia+tipo da conta+numero da conta+nosso numero e dv+ campo livre

    cCadeiaCB := alltrim(QRY->EA_PORTADO)+'9'+ STRZERO(int(QRY->E1_VALOR*100),14)+alltrim(cAgencia) +"047"+alltrim(cConta)+substr(QRY->E1_NUMBCO,4,9)+alltrim(QRY->E1_NUMDV)+'00'
    
    
    // Cálculo do DAC do cod. de barras

     K:=0 
     J:=4
     FOR I:=1 TO Len(cCadeiaCB)
       if j==1
         j:=9
       endif
       K:=K+val(SUBSTR(cCadeiaCB,I,1))*J
       j:=j-1
     NEXT  

     
     resto:= MOD(K,11)
     DAC5:= 11-RESTO 
    
     cSeqCB := alltrim(QRY->EA_PORTADO)+'9'+alltrim(str(DAC5))+ STRZERO(int(QRY->E1_VALOR*100),14)+alltrim(cAgencia)+"047"+alltrim(cConta)+SUBSTR(QRY->E1_NUMBCO,4,9)+alltrim(QRY->E1_NUMDV)+'00'


        
     //Formato da representação númerica :
     
     //                 campo1     campo2     campo3     
     //             BBBMAAATTDTCCCCCCCNNDNNNNNNNN00DXVVVVVVVVVVVVVV
    
 
     BBB:= QRY->EA_PORTADO    // Codigo do banco
     M:=   "9"     							  // Codigo da MOEDA 
     AAA:= QRY->EA_AGEDEP	  // AGENCIA	
     TT:=  "04"    							  // Dois primeiros digitos do tipo da conta 
                                                                                          
        
     dig1:=VAL(SUBSTR(TT,2,1))*2
     if dig1 >9
       dig1:=val(SUBSTR(str(dig1,2),1,1))+val(SUBSTR(str(dig1,2),2,1))
     EndIF   
    
     dig3:=VAL(SUBSTR(AAA,3,1))*2
     if dig3>9
       dig3:=val(SUBSTR(str(dig3,2),1,1))+val(SUBSTR(str(dig3,2),2,1))
     EndIF

     dig5:=VAL(SUBSTR(AAA,1,1))*2
     if dig5>9
       dig5:=val(SUBSTR(str(dig5,2),1,1))+val(SUBSTR(str(dig5,2),2,1))
     EndIF
     
     dig7:=VAL(SUBSTR(BBB,3,1))*2
     if dig7>9
       dig7:=val(SUBSTR(str(dig7,2),1,1))+val(SUBSTR(str(dig7,2),2,1))
     EndIF
   
     dig9:=VAL(SUBSTR(BBB,1,1))*2
     if dig9>9
       dig9:=val(SUBSTR(str(dig9,1),1,1))+val(SUBSTR(str(dig9,2),2,1))
     EndIF
   
     DACSomaX:= dig9+Val(SubStr(BBB,2,1))+dig7+Val(M)+dig5+Val(SubStr(AAA,2,1))+dig3+Val(SubStr(TT,1,1))+dig1
     DACDivX:= MOD(DACSomaX,10)
     DACX:= 10-DACDivX
     
     X:=STR(DACX) //Variável que armazena o DAC que amarra o campo 1   
        
        
     
     T:="7"
     ccccccc:= cConta
     NN:= SubStr(QRY->E1_NUMBCO,4,2)

     // Calculo do DAC da representação Numérica do campo 2
     
     dig2:= VAL(SUBSTR(CCCCCCC,2,1))*2
     if dig2>9
       dig2:=val(SUBSTR(str(dig2,2),1,1))+val(SUBSTR(str(dig2,2),2,1))
     EndIF
     
     dig4:= VAL(SUBSTR(CCCCCCC,4,1))*2
     if dig4 > 9
       dig4:=val(SUBSTR(str(dig4,2),1,1))+val(SUBSTR(str(dig4,2),2,1))
     EndIF
     
     dig6:= VAL(SUBSTR(CCCCCCC,6,1))*2
     if dig6>9
        dig6:=val(SUBSTR(str(dig6,2),1,1))+val(SUBSTR(str(dig6,2),2,1))
     EndIF
    

     dig8:=VAL(SUBSTR(NN,1,1))*2
     if dig8>9
       dig8:=val(SUBSTR(str(dig8,2),1,1))+val(SUBSTR(str(dig8,2),2,1))
     EndIF


     DACSomaY:=  VAL(T)*2+Val(SubStr(CCCCCCC,1,1))+dig2+VAL(SubStr(CCCCCCC,3,1))+dig4+Val(SubStr(CCCCCCC,5,1))+dig6+Val(SubStr(CCCCCCC,7,1))+dig8+Val(SubStr(NN,2,1))
     DACDivY:= MOD(DACSomaY,10)
     DACY:= 10-DACDivY
     
     Y:= STR(DACY)  //Variável que armazena o DAC que amarra o campo 2
     
     //Campo3

     NNNNNNN:=SUBSTR(QRY->E1_NUMBCO,6,7)+QRY->E1_NUMDV
     
     // Calculo do DAC da representação Numérica do campo 3

     dg2:= VAL(SUBSTR(NNNNNNN,1,1))*2
     if dg2>9
       dg2:=val(SUBSTR(str(dg2,2),1,1))+val(SUBSTR(str(dg2,2),2,1))
     EndIF
     
     dg4:= VAL(SUBSTR(NNNNNNN,3,1))*2
     if dg4 > 9
       dg4:=val(SUBSTR(str(dg4,2),1,1))+val(SUBSTR(str(dg4,2),2,1))
     EndIF
     
     dg6:= VAL(SUBSTR(NNNNNNN,5,1))*2
     if dg6>9
        dg6:=val(SUBSTR(str(dg6,2),1,1))+val(SUBSTR(str(dg6,2),2,1))
     EndIF
    

     dg8:=VAL(SUBSTR(NNNNNNN,7,1))*2
     if dg8>9
       dg8:=val(SUBSTR(str(dg8,2),1,1))+val(SUBSTR(str(dg8,2),2,1))
     EndIF

     
     DACSomaZ:= dg2+VAL(SUBSTR(NNNNNNN,2,1))+dg4+VAL(SUBSTR(NNNNNNN,4,1))+dg6+VAL(SUBSTR(NNNNNNN,6,1))+dg8+VAL(SUBSTR(NNNNNNN,8,1))
     DACDivZ:= MOD(DACSomaZ,10)
     DACZ:= 10-DACDivZ
     
     Z:= STR(DACZ)
     
   
     // Linha que sera impressa
     nValor:=STRZERO(int(QRY->E1_VALOR*100),14)                                                                                                                                                                                                         
     cLinDig:=" "+BBB+M+SUBSTR(AAA,1,1)+"."+SUBSTR(AAA,2,2)+alltrim(TT)+alltrim(X)+"  "+alltrim(T)+alltrim(CCCCCCC)+alltrim(NN)+alltrim(Y)+"  "+SUBSTR(NNNNNNN,1,5)+"."+SUBSTR(NNNNNNN,6,3)+"00"+alltrim(Z)+"  "+alltrim(str(dac5))+"  " +alltrim(nValor)     
   

     // Linha que sera passada para montar o codigo de barras
    
     cLinCB:=alltrim(BBB)+alltrim(M)+alltrim(AAA)+alltrim(TT)+alltrim(X)+alltrim(T)+alltrim(CCCCCCC)+alltrim(NN)+alltrim(Y)+alltrim(NNNNNNN)+"00"+alltrim(Z)+alltrim(nValor)

   



     
   
    // Inicio da impressao do boleto
    // Primeira parte - Recibo do Sacado


    oPrn:StartPage()
     
    cBitMap:="LogoBand.Bmp"
    oPrn:SayBitmap( 055,085,cBitMap,650,070)
    oPrn:Box( 080,730,135,731)
    oPrn:Box( 080,950,135,951)
    oPrn:Say( 112, 070, Repli('_',2000),oFont7,100)  
	  oPrn:Box( 135, 1590,793,1591)
	  oPrn:Say( 203, 070, Repli('_',1000),oFont7,100)  
    oPrn:Say( 270, 070, Repli('_',2000),oFont7,100)  
    oPrn:Box( 295,370,360,371) //300
    oPrn:Box( 295,780,360,781)     
    oPrn:Box( 295,1000,360,1001)     
    oPrn:Box( 295,1180,430,1181)
    oPrn:Say( 340, 070, Repli('_',1800),oFont7,100)  
    oPrn:Box( 365,400,430,401) //370
    oPrn:Box( 365,660,430,661)
    oPrn:Box( 365,800,430,801)
    oPrn:Say( 410, 070, Repli('_',1800),oFont7,100)                          
    oPrn:Say( 490,1590,Repli("_",200),oFont7,100)
    oPrn:Say( 560,1590,Repli("_",200),oFont7,100)
    oPrn:Say( 630,1590,Repli("_",200),oFont7,100)
    oPrn:Say( 700,1590,Repli("_",200),oFont7,100)
    oPrn:Say( 773, 070, Repli('_',2000),oFont7,100)  
    oPrn:Say( 880, 070, Repli('_',2000),oFont7,100)  
    oPrn:Say( 985,000,Repli('-',2000),oFont10,100)
    
     // Segunda parte - Ficha de Caixa
     
    oPrn:SayBitmap( 1060,085,cBitMap,650,070)
    oPrn:Box( 1050,730,1135,731)
    oPrn:Box( 1050,950,1135,951)
    oPrn:Say( 1110, 070, Repli('_',2000),oFont7,100)  
		oPrn:Box( 1131, 1590,1783,1591)
    oPrn:Say( 1203, 070, Repli('_',1000),oFont7,100)  
    oPrn:Say( 1270, 070, Repli('_',2000),oFont7,100)  
    oPrn:Box( 1295,370,1360,371) // 1300
    oPrn:Box( 1295,780,1360,781)     
    oPrn:Box( 1295,1000,1360,1001)     
    oPrn:Box( 1295,1180,1430,1181)
    oPrn:Say( 1340, 070, Repli('_',1800),oFont7,100)  
    oPrn:Box( 1360,400,1430,401)  // 1350
    oPrn:Box( 1360,660,1430,661)
    oPrn:Box( 1360,800,1430,801)
    oPrn:Say( 1410, 070, Repli('_',1800),oFont7,100)                          
    oPrn:Say( 1480,1590,Repli("_",200),oFont7,100)
    oPrn:Say( 1550,1590,Repli("_",200),oFont7,100)
    oPrn:Say( 1620,1590,Repli("_",200),oFont7,100)
    oPrn:Say( 1690,1590,Repli("_",200),oFont7,100)
    oPrn:Say( 1763, 070, Repli('_',2000),oFont7,100)  
    oPrn:Say( 1870, 070, Repli('_',2000),oFont7,100)  
    oPrn:Say( 2100,070, Repli('-',2000),oFont10,100)

    // Terceira parte - Linha digitavel
     
    oPrn:SayBitmap( 2180,085,cBitMap,650,070)
    oPrn:Box( 2190,730,2255,731 )
    oPrn:box( 2190,950,2255,951) 
    oPrn:Say( 2230, 070, Repli('_',2000),oFont7,100)  
    oPrn:Box( 2251, 1590,2900,1591)
    oPrn:Say( 2313, 070, Repli('_',1000),oFont7,100)  
    oPrn:Say( 2390, 070, Repli('_',2000),oFont7,100)  
    oPrn:Box( 2415,390,2485,391)
    oPrn:Box( 2415,820,2485,821)     
    oPrn:Box( 2415,1030,2485,1031)     
    oPrn:Box( 2415,1210,2555,1211)
    oPrn:Say( 2460, 070, Repli('_',1800),oFont7,100)  
    oPrn:Box( 2485,430,2555,431)
    oPrn:Box( 2485,690,2555,691)
    oPrn:Box( 2485,830,2555,831)
    oPrn:Say( 2530, 070, Repli('_',1800),oFont7,100)                          
    oPrn:Say( 2600,1590,Repli("_",200),oFont7,100)
    oPrn:Say( 2675,1590,Repli("_",200),oFont7,100)
    oPrn:Say( 2740,1590,Repli("_",200),oFont7,100)
    oPrn:Say( 2800,1590,Repli("_",200),oFont7,100)
    oPrn:Say( 2883, 070, Repli('_',2000),oFont7,100)  
    oPrn:Say( 2990, 070, Repli('_',2000),oFont7,100)  
     
    
    
//    ----------TEXTOS
     
    oPrn:Say( 080,1730, "RECIBO DO SACADO",oFt4b,100)
    oPrn:Say( 060,740, "230-5",oFt5b,100)
    


    oPrn:Say( 138,100,"Local de Pagamento",oFont7,100)
    oPrn:Say( 138,1600,"  Vencimento",oFont7,100)
    oPrn:Say( 180,100,_cLocalPagt,oFt2b,100)
    oPrn:Say( 180,1900,_cVencto,oFt2b,100)


     
    oPrn:Say( 228,100,"Cedente",oFont7,100)
    oPrn:Say( 228,1600,"  Agencia/Codigo Cedente",oFont7,100)
    oPrn:Say( 255,100,_cCedente,oFt2b,100)
    //oPrn:Say( 255,400,"CGC",oFt2b,100)
    //oPrn:Say( 255,480,SUBSTR(SM0->M0_CGC,1,2)+"."+SUBSTR(SM0->M0_CGC,3,3)+"."+SUBSTR(SM0->M0_CGC,6,3)+"/"+SUBSTR(SM0->M0_CGC,9,4)+"-"+SUBSTR(SM0->M0_CGC,13,2),oFt2b,100)
    
    oPrn:Say( 255,1900,_cAgConv+"/"+_cFxConv,oFt2b,100)
     
     
    oPrn:Say( 295,100,"Data do Documento",oFont7,100)
    oPrn:Say( 295,380," Número Documento",oFont7,100)
    oPrn:Say( 295,790," Espécie Doc.",oFont7,100)
    oPrn:Say( 295,1010,"      Aceite",oFont7,100)
    oPrn:Say( 295,1190," Data de processamento",oFont7,100)
    oPrn:Say( 295,1590,"  Nosso Número",oFont7,100)            
    oPrn:Say( 330,115,_cDtDoc,oFt2b,100)
    oPrn:Say( 330,400,_cNumDoc,oFt2b,100) 
    oPrn:Say( 330,880,_cEspDoc,oFt2b,100)
    oPrn:Say( 330,1090,_cAceite,oFt2b,100)
    oPrn:Say( 330,1300,_cDtProc,oFt2b,100)  
    oPrn:Say( 330,1900,_cNossoNum+'-'+_cNumDv,oFt2b,100) 

    
    oPrn:Say( 365,100,"C.G.C. do Cedente",oFont7,100) 
    oPrn:Say( 365,410," Carteira",oFont7,100)
    oPrn:Say( 365,670," Espécie",oFont7,100)
    oPrn:Say( 365,810," Quantidade",oFont7,100)
    oPrn:Say( 365,1200," (x)Valor",oFont7,100)        
    oPrn:Say( 365,1590,"   (=)Valor do Documento",oFont7,100) 
    oPrn:Say( 390,100,_cCGCCedente,oFont8,100)
    oPrn:Say( 390,520,_cCartDoc,oFt2b,100)
    oPrn:Say( 390,720,_cEspMoeda,oFt2b,100)     
    oPrn:Say( 390,1900,Trans(_nSaldo, "@E@R 999,999,999.99"),oFt2b,100) //PICTURE "@E@R 999,999,999.99"


 
    oPrn:Say( 435,100,"Instruções",oFont7,100)        
    oPrn:Say( 435,1600,"  (-) Desconto /Abatimento",oFont7,100)
    oPrn:Say( 515,1600,"  (-) Outras Deduções",oFont7,100)

    oPrn:Say( 540,150,_cMsg1,oFt2b,100)
    oPrn:Say( 570,150,_cMsg2,oFt2b,100)
    oPrn:Say( 600,150,_cMsg3,oFt2b,100)
    oPrn:Say( 630,150,_cMsg4,oFt2b,100)
    oPrn:Say( 660,150,_cMsg5,oFt2b,100)

    //oPrn:Say( 590,150,"Acréscimo por dia de atraso",oFt2b,100)
    //oPrn:Say( 590,700,Trans(QRY->E1_VALJUR, "@E@R 999,999,999.99"),oFt2b,100) // PICTURE("@E@R 999,999,999.99")
    oPrn:Say( 590,1600,"  (+) Mora/Multa",oFont7,100)
    //oPrn:Say( 620,150,"Multa por atraso",oFt2b,100)
//    oPrn:Say( 620,700,Trans(QRY->E1_MULTA, "@E@R 999,999,999.99"),oFt2b,100)// PICTURE "@E@R 999,999,999.99"
    oPrn:Say( 650,1600,"  (+) Outros Acréscimos",oFont7,100)
    //oPrn:Say( 670,150,"MENS."+substr(cVencto,4,7),oFt2b,100)
    oPrn:Say( 730,1600," (=) Valor Cobrado",oFont7,100)     
    //oPrn:Say( 750,200,"("+ALLTRIM(QRY->A1_CURSO)+ " - "+SUBSTR(QRY->E1_MAT,3,2)+"/"+SUBSTR(QRY->E1_MAT,5,1)+" - "+ALLTRIM(QRY->Z3_DESC)+ ")",oFont7,100)


    oPrn:Say( 793,100,"Sacado",oFont7,100)
    oPrn:Say( 810,250,_cSacado,oFt3b,100)
//    oPrn:Say( 810,600,QRY->A1_NOME,oFt3b,100)
    oPrn:Say( 870,100,"Sacador/Avalista",oFont7,100)     
    oPrn:Say( 870,1700,"Código de Baixa",oFont7,100) 
     
     
    oPrn:Say( 910,1590,"Autenticação Mecânica",oFont7,100)
     
    oPrn:Say( 1010,080,"CORTE AQUI",oFont5,100)  
    
     // Segunda parte - Ficha de Caixa
     
    oPrn:Say( 1080,1800, "FICHA DE CAIXA",oFt4b,100)
    oPrn:Say( 1060,740, "230-5",oFt5b,100)

    oPrn:Say( 1130,100,"Local de Pagamento",oFont7,100)
    oPrn:Say( 1130,1590,"  Vencimento",oFont7,100)
    oPrn:Say( 1170,100,_cLocalPagt,oFt2b,100)
    oPrn:Say( 1170,1900,_cVencto,oFt2b,100)


     
    oPrn:Say( 1228,100,"Cedente",oFont7,100)
    oPrn:Say( 1228,1590,"  Agencia/Codigo Cedente",oFont7,100)
    oPrn:Say( 1250,100,_cCedente,oFt2b,100)
    //oPrn:Say( 1250,400,"CGC",oFt2b,100)
    //oPrn:Say( 1250,480,SUBSTR(SM0->M0_CGC,1,2)+"."+SUBSTR(SM0->M0_CGC,3,3)+"."+SUBSTR(SM0->M0_CGC,6,3)+"/"+SUBSTR(SM0->M0_CGC,9,4)+"-"+SUBSTR(SM0->M0_CGC,13,2),oFt2b,100)
    oPrn:Say( 1250,1900,_cAgConv+"/"+_cFxConv,oFt2b,100)

     
    oPrn:Say( 1295,100,"Data do Documento",oFont7,100)
    oPrn:Say( 1295,380," Número Documento",oFont7,100)
    oPrn:Say( 1295,790," Espécie Doc.",oFont7,100)
    oPrn:Say( 1295,1010,"      Aceite",oFont7,100)
    oPrn:Say( 1295,1190," Data de processamento",oFont7,100)
    oPrn:Say( 1295,1590,"  Nosso Número",oFont8,100)            
    oPrn:Say( 1320,115,_cDtDoc,oFt2b,100)
    oPrn:Say( 1320,400,_cNumDoc,oFt2b,100) 
    oPrn:Say( 1320,880,_cEspDoc,oFt2b,100)
    oPrn:Say( 1320,1090,_cAceite,oFt2b,100)
    oPrn:Say( 1320,1300,_cDtProc,oFt2b,100)  
    oPrn:Say( 1320,1900,_cNossoNum+'-'+_cNumDv,oFt2b,100) 

     
    oPrn:Say( 1365,100,"C.G.C. do Cedente",oFont7,100) 
    oPrn:Say( 1365,410," Carteira",oFont7,100)
    oPrn:Say( 1365,670," Espécie",oFont7,100)
    oPrn:Say( 1365,810," Quantidade",oFont7,100)
    oPrn:Say( 1365,1200," (x)Valor",oFont7,100)        
    oPrn:Say( 1365,1590,"   (=)Valor do Documento",oFont7,100) 
    oPrn:Say( 1390,100,_cCGCCedente,oFont8,100)
    oPrn:Say( 1390,520,_cCartDoc,oFt2b,100)
    oPrn:Say( 1390,720,_cEspMoeda,oFt2b,100)     
    oPrn:Say( 1390,1900,Trans(_nSaldo, "@E@R 999,999,999.99"),oFt2b,100) //PICTURE "@E@R 999,999,999.99"


 
    oPrn:Say( 1435,100,"Instruções",oFont7,100)        
    oPrn:Say( 1435,1600,"  (-) Desconto /Abatimento",oFont7,100)
    oPrn:Say( 1505,1600,"  (-) Outras Deduções",oFont7,100)
    //oPrn:Say( 1440,1900,Trans(QRY->E1_MULTA, "@E@R 999,999,999.99"),oFt2b,100) //PICTURE "@E@R 999,999,999.99"

    oPrn:Say( 1510,150,_cMsg1,oFt2b,100)
    oPrn:Say( 1540,150,_cMsg2,oFt2b,100)
    oPrn:Say( 1570,150,_cMsg3,oFt2b,100)
    oPrn:Say( 1600,150,_cMsg4,oFt2b,100)
    oPrn:Say( 1630,150,_cMsg5,oFt2b,100)

    //rn:Say( 1600,150,"Acréscimo por dia de atraso",oFt2b,100)
    //rn:Say( 1600,700,Trans(QRY->E1_VALJUR, "@E@R 999,999,999.99"),oFt2b,100)// PICTURE "@E@R 999,999,999.99" 
    oPrn:Say( 1590,1600,"  (+) Mora/Multa",oFont7,100)
    //rn:Say( 1630,150,"Multa por atraso",oFt2b,100)         
//    oPrn:Say( 1630,700,Trans(QRY->E1_MULTA, "@E@R 999,999,999.99"),oFt2b,100) //PICTURE "@E@R 999,999,999.99"
    oPrn:Say( 1650,1600,"  (+) Outros Acréscimos",oFont7,100)
    //rn:Say( 1670,150,"MENS."+substr(cVencto,4,7),oFt2b,100)
    oPrn:Say( 1720,1600," (=) Valor Cobrado",oFont7,100)     
    //rn:Say( 1730,200,"("+ALLTRIM(QRY->A1_CURSO)+ " - "+SUBSTR(QRY->E1_MAT,3,2)+"/"+SUBSTR(QRY->E1_MAT,5,1)+" - "+ALLTRIM(QRY->Z3_DESC)+ ")",oFont7,100)     

                
    oPrn:Say( 1783,100,"Sacado",oFont7,100)
    oPrn:Say( 1800,250,_cSacado,oFt3b,100)
    //oPrn:Say( 1800,600,QRY->A1_NOME,oFt3b,100)
    oPrn:Say( 1860,100,"Sacador/Avalista",oFont7,100)     
    oPrn:Say( 1860,1700,"Código de Baixa",oFont7,100) 
     
     
     
    oPrn:Say( 1900,1590,"Autenticação Mecânica",oFont7,100)
     
    oPrn:Say( 2130,080,"CORTE AQUI",oFont5,100)
    

    // Terceira parte - Linha digitavel
     
    oPrn:Say( 2180,740, "230-5",oFt5b,100)
    oPrn:Say( 2200,970,_cLinDig,oFont162,100)

     


    oPrn:Say( 2255,100,"Local de Pagamento",oFont7,100)
    oPrn:Say( 2255,1610,"  Vencimento",oFont7,100)
    oPrn:Say( 2300,100,_cLocalPagt,oFt2b,100)
    oPrn:Say( 2300,1900,_cVencto,oFt2b,100)


     
    oPrn:Say( 2348,100,"Cedente",oFont7,100)
    oPrn:Say( 2348,1610,"  Agencia/Codigo Cedente",oFont7,100)
    oPrn:Say( 2370,100,_cCedente,oFt2b,100)
    //oPrn:Say( 2370,400,"CGC",oFt2b,100)
    //oPrn:Say( 2370,480,SUBSTR(SM0->M0_CGC,1,2)+"."+SUBSTR(SM0->M0_CGC,3,3)+"."+SUBSTR(SM0->M0_CGC,6,3)+"/"+SUBSTR(SM0->M0_CGC,9,4)+"-"+SUBSTR(SM0->M0_CGC,13,2),oFt2b,100)
    oPrn:Say( 2370,1900,_cAgConv+"/"+_cFxConv,oFt2b,100)


    oPrn:Say( 2415,100,"Data do Documento",oFont7,100)
    oPrn:Say( 2415,400," Número Documento",oFont7,100)
    oPrn:Say( 2415,830," Espécie Doc.",oFont7,100)
    oPrn:Say( 2415,1040,"      Aceite",oFont7,100)
    oPrn:Say( 2415,1220," Data de processamento",oFont7,100)
    oPrn:Say( 2415,1610,"  Nosso Número",oFont8,100)            
    oPrn:Say( 2440,115,_cDtDoc,oFt2b,100)
    oPrn:Say( 2440,400,_cNumDoc,oFt2b,100) 
    oPrn:Say( 2440,880,_cEspDoc,oFt2b,100)
    oPrn:Say( 2440,1090,_cAceite,oFt2b,100)
    oPrn:Say( 2440,1300,_cDtProc,oFt2b,100)  
    oPrn:Say( 2440,1900,_cNossoNum+'-'+_cNumDv,oFt2b,100) 

              
    oPrn:Say( 2485,100,"C.G.C. do Cedente",oFont7,100) 
    oPrn:Say( 2485,440," Carteira",oFont7,100)
    oPrn:Say( 2485,700," Espécie",oFont7,100)
    oPrn:Say( 2485,840," Quantidade",oFont7,100)
		oPrn:Say( 2485,1220," (x)Valor",oFont7,100)        
    oPrn:Say( 2485,1610,"   (=)Valor do Documento",oFont7,100) 
    oPrn:Say( 2510,100,_cCGCCedente,oFont8,100)
    oPrn:Say( 2510,520,_cCartDoc,oFt2b,100)
    oPrn:Say( 2510,720,_cEspMoeda,oFt2b,100)     
    oPrn:Say( 2510,1900,Trans(_nSaldo, "@E@R 999,999,999.99"),oFt2b,100)    //PICTURE "@E@R 999,999,999.99"


    
    oPrn:Say( 2555,100,"Instruções",oFont7,100)        
    oPrn:Say( 2555,1610,"  (-) Desconto /Abatimento",oFont7,100)
    oPrn:Say( 2625,1610,"  (-) Outras Deduções",oFont7,100)
    //oPrn:Say( 2560,1900,Trans(QRY->E1_MULTA, "@E@R 999,999,999.99"),oFont8,100)  //PICTURE "@E@R 999,999,999.99"

    oPrn:Say( 2640,150,_cMsg1,oFt2b,100)
    oPrn:Say( 2670,150,_cMsg2,oFt2b,100)
    oPrn:Say( 2700,150,_cMsg3,oFt2b,100)
    oPrn:Say( 2730,150,_cMsg4,oFt2b,100)
    oPrn:Say( 2760,150,_cMsg5,oFt2b,100)


 // oPrn:Say( 2700,150,"Acréscimo por dia de atraso",oFt2b,100)
 // oPrn:Say( 2700,700,Trans(QRY->E1_VALJUR, "@E@R 999,999,999.99"),oFt2b,100)    //PICTURE "@E@R 999,999,999.99"
    oPrn:Say( 2710,1610,"  (+) Mora/Multa",oFont7,100)
 // oPrn:Say( 2730,150,"Multa por atraso",oFt2b,100)                                        
 // oPrn:Say( 2730,700,Trans(QRY->E1_VALJUR, "@E@R 999,999,999.99"),oFt2b,100)
    oPrn:Say( 2770,1610,"  (+) Outros Acréscimos",oFont7,100)
  //oPrn:Say( 2780,150,"MENS."+substr(cVencto,4,7),oFt2b,100)
    oPrn:Say( 2840,1610," (=) Valor Cobrado",oFont7,100)     
   //Prn:Say( 2860,200,"("+ALLTRIM(QRY->A1_CURSO)+ " - "+SUBSTR(QRY->E1_MAT,3,2)+"/"+SUBSTR(QRY->E1_MAT,5,1)+" - "+ALLTRIM(QRY->Z3_DESC)+ ")",oFont7,100)

                
    oPrn:Say( 2903,100,"Sacado",oFont7,100)
    oPrn:Say( 2920,250,_cSacado,oFt3b,100)
    oPrn:Say( 2980,100,"Sacador/Avalista",oFont7,100)     
    oPrn:Say( 2980,1700,"Código de Baixa",oFont7,100) 
     
     
    oPrn:Say( 3020,1590,"Autenticação Mecânica - Ficha de Compensação",oFont7,100)
     
    MSBAR("INT25",26.5,1.3,_cCodBar,oPrn,,,.t.,0.028,1.3,nil,nil,nil,.f.)

    
    
    DbSkip()
    oPrn:EndPage()            
	EndDo
 
	DbCloseArea()      

Return


/* 
Perguntas criadas no SX1
QUAL BANCO? ---------- _mvpar01 ---- C ----- 3
IMP. LOCAL PAGAMENTO?- _mvpar02 ---- C ----- 1
LOCAL PAGAMENTO?------ _mvpar03 ---- C ----- 38
DA MATRICULA?--------- _mvpar04 ---- C ----- 9
ATÉ MATRICULA?-------- _mvpar05 ---- C ----- 9

 If n > 10  // Salto de Página. Neste caso o formulario com 10 itens...
			//ImpRoda()  // ao final de cada pedido imprimir o rodape
			oPrn:EndPage()
			oPrn:StartPage()
			//ImpCabPed()
			nLin  := 0
			n     := 0
		Endif
	
 */	   



STATIC FUNCTION ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"01","Qual o Banco       ?","mv_ch1","C",3,0,0,"G","","mv_par01","","230","","","","","","","","","","","","","SA6"})
aAdd(aRegs,{cPerg,"02","Do Curso           ?","mv_ch2","C",3,0,0,"G","","mv_par02","","004","","","","","","","","","","","","","SZ3"})
aAdd(aRegs,{cPerg,"03","Ate o Curso        ?","mv_ch3","C",3,0,0,"G","","mv_par03","","004","","","","","","","","","","","","","SZ3"})
aAdd(aRegs,{cPerg,"04","Da Matricula       ?","mv_ch4","C",9,0,0,"G","","mv_par04","","049910329","","","","","","","","","","","","","FA1"})
aAdd(aRegs,{cPerg,"05","Ate Matricula      ?","mv_ch5","C",9,0,0,"G","","mv_par05","","049910329","","","","","","","","","","","","","FA1"})
aAdd(aRegs,{cPerg,"06","Do Vencimento      ?","mv_ch6","D",8,0,0,"G","","mv_par06","","'01/12/00'","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","Ate Vencimento     ?","mv_ch7","D",8,0,0,"G","","mv_par07","","'13/12/00'","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","Imp.Aluno em Debito?","mv_ch8","N",1,0,1,"C","","mv_par08","Sim","","","Nao","","","","","","","","","","",""})


For i:=1 to Len(aRegs)
    If !dbSeek(cPerg+aRegs[i,2])
        RecLock("SX1",.T.)
        For j:=1 to FCount()
            If j <= Len(aRegs[i])
                FieldPut(j,aRegs[i,j])
            Endif
        Next
        MsUnlock()
    Endif
Next

dbSelectArea(_sAlias)

Return

STATIC FUNCTION CalcMod10()
  //----- Calcula Digito Verificador usando modulo 10
	//----- Sequencia de Numeros para calculo do digito verificador

	aNros 		:= {}
  _cProdutos:= ''
  _nsoma		:= 0 
	For i := Len(_cNros) to 1 step -1
		AADD(aNros,Subs(_cNros,i,1))
	Next
	For i := 1 to Len(aNros)           
		If !( i%2 ) = 0 
			/*[ Posicao Par na Sequencia ]*/   
			_cProdutos := _cProdutos+alltrim(str(Val(aNros[i])*2	))
		Else                               
			/*[ Posicao Impar na Sequencia ]*/
			_cProdutos := _cProdutos+alltrim(str(Val(aNros[i])*1))
		Endif
	Next
	For i:= 1 to Len(_cProdutos)
		_nSoma := _nSoma+Val(Subs(_cProdutos,i,1))
	Next                 
	_nDV  := 10 - Mod(_nSoma,10) 
	_nDV 	:= IIF( _nDV==10, 0, _nDV )
	_cDv :=	 Alltrim(Str(_nDV))
Return

STATIC FUNCTION CalcMod11()

	aNros 			:= {}
	_nDivisor 	:=	2
  _nSoma			:= 	0 
  _nBaseMod11	:= 	9 // IIF(_mvpar01='237',7,9)
	For i := 1 to Len(_cNros)
		AADD(aNros,Subs(_cNros,i,1))
	Next
	For i := Len(aNros)  to  1  step -1             
		_nSoma := _nSoma+ (   Val(aNros[i]) * _nDivisor   )
		_nDivisor		:= iif( _nDivisor >= _nBaseMod11 , 2 , _nDivisor+1	)  
	Next

	//  ---- Para Banco Bandeirantes (codigo de barras)
  //msgbox(str(Len(_cNros)), 'tamanho da string')
	//mSGbOX(_cNros, 'CALCULO MOD 11 - NUMEROS')	
	//mSGbOX(str(_NsOMA), 'CALCULO MOD 11 - SOMA')	
	//mSGbOX(str(_NsOMA), 'CALCULO MOD 11 - SOMA')	
	_nDV	:=	11 -( Mod(_nSoma,11) )      
  //mSGbOX(str(_NDV), 'CALCULO MOD 11 - ndv')	
	_nDV 	:= IIF( _nDV==11, 1, _nDV )
	_nDV 	:= IIF( _nDV==10, 1, _nDV )
	_nDV 	:= IIF( _nDV== 1, 1, _nDV )
	_nDV 	:= IIF( _nDV== 0, 1, _nDV )
	
  //mSGbOX(str(_NDV), 'CALCULO MOD 11 - ndv  2')	
	
	_cDv	:=		Alltrim(Str(_nDV))



Return


STATIC FUNCTION TESTAIMP()
		
    oPrn:StartPage()
    // BANDEIRANTES 
    //cBitMap:="LogoBand.Bmp"
    //oPrn:SayBitmap( 055,085,cBitMap,650,070)
    
    oPrn:Say( 175,245, "BRADESCO",oFont142,100)
     
    oPrn:Say( 200,700,_cLinDig,oFont12,100)
    oPrn:Say( 400,700,"Codigo de Barras "+_cCodBar,oFont12,100)

    MSBAR("INT25",26.5,1,_cCodBar,oPrn,,,.t.,0.028,1.3,nil,nil,nil,.f.)
		
    oPrn:EndPage()
    
RETURN    

Static Function fLimpaConta()
	//----- Retira caracteres estranhos da conta
	//_cConta		:=	SEE->EE_CONTA
	_cCta				:= subs(_cConta,1, Len(alltrim(_cConta))-1 )   //----- Sem o digito verificador
  _cDvConta		:=subs(_cConta, Len(alltrim(_cConta)),1 )				//----- digito Verificador
	_cCtaLimpa	:=	''                                              //----- Conta sem pontos e tracos

	For i  := 1 to Len(_cCta)
		If LetterOrNum(subs(_cCta,i,1))
	  	_cCtaLimpa := _cCtaLimpa +	subs(_cCta,i,1)	       
		Endif
	Next 	

Return


STATIC FUNCTION MSGABAT()
//----- Monta mensagem de Desconto/Abatimento 
	_cArea := Alias()
	//SetPrvt("_nTotAbat,_cTipoAbat,_cRet,")          
	//SetPrvt("_CCLIENTE,_CLOJA,_CPREFIXO,_CNUM,_CPARCELA,_aSE1,")


	_cRet					:= ""
	_cTipoAbat		:= ""
	_nTotAbat     := 0
	fCalcAbat()		//----- Calcula Abatimento

	//----- Caso o titulo tenha abatimentos, monta frase de acordo com o tipo 
	//----- do abatimento (Credito ou Bolsa)
	If _nTotAbat > 0 
		_cRet 	:=		"CONCEDER DESCONTO DE R$"+Alltrim(Str(_nTotAbat,17,2))
	  DbSelectArea('SX5')
		If DbSeek(xFilial()+'83'+_cTipoAbat )
			_cRet	:=		_cRet + " REFERENTE A "+SX5->X5_DESCRI
		Endif
	Endif
	DbSelectArea(_cArea) 
Return( _cRet )
                 

STATIC FUNCTION fCalcAbat()
	//----- CALCULO ABATIMENTO

	DbSelectArea("SE1")                                
	_aSE1 :=	{ Alias(), IndexOrd(), Recno() }

	//----- carga de variaveis p/busca 

	_cCliente 		:= QRY->E1_CLIENTE
	_cLoja				:= QRY->E1_LOJA
	_cPrefixo			:= QRY->E1_PREFIXO
	_cNum					:= QRY->E1_NUM
	_cParcela			:= QRY->E1_PARCELA
	_nTotAbat			:= 0
	_cTipoAbat		:= ""

	DbGoTOP()           
	DbSelectArea("SE1")
	dbSetOrder(1)
	DbSeek( xFilial()+ _cPrefixo+_cNum+_cParcela, .T. )

	While !Eof()  .and.  SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_CLIENTE+SE1->E1_LOJA == ;
								_cPrefixo+_cNum+_cParcela+_cCliente+_cLoja
		If Right(SE1->E1_TIPO,1) = '-' 
			_nTotAbat 	:= _nTotAbat+SE1->E1_SALDO
         
			_cTipoAbat 	:=	iif(len(alltrim(_cTipoAbat))=0,SE1->E1_CLASBEN ,_cTipoAbat)
      
		Endif	 
  	DbSkip()
	End							                                 

	//----- Restaura área original 
	DbSelectarea( _aSE1[1]) 
	DbSetOrder( _aSE1[2])
	DbGoto( _aSE1[3])
	
Return




STATIC FUNCTION MontaQuery()
	//----- Monta Area de Trabalho com Query SQL 
	_cArqSA1:= retsqlname("SA1")
	_cArqSE1:= retsqlname("SE1")         
	_cArqSZ3:= retsqlname("SZ3")
	_cArqSEA:= retsqlname("SEA")

	cQuery :=      			"SELECT "
	cQuery := cQuery + 		"E1.E1_PREFIXO,E1.E1_NUM,E1.E1_PARCELA,E1.E1_CLIENTE,E1.E1_LOJA, E1.E1_MAT,E1.E1_VENCTO,E1.E1_EMISSAO,E1.E1_NUMBCO,E1.E1_NUMDV, "
	cQuery := cQuery + 		"E1.E1_SALDO,E1.E1_VALOR,E1.E1_VALJUR,E1.E1_BAIXA, EA.EA_NUMCON,EA.EA_NUMBOR, EA.EA_AGEDEP, EA.EA_PORTADO, "
	cQuery := cQuery + 		"A1.A1_NOME, A1.A1_COD, A1.A1_LOJA, A1.A1_CURSO,Z3.Z3_DESC " 
	cQuery := cQuery + 	"FROM "+ _cArqSE1 +" E1, "
	cQuery := cQuery + 		_cArqSA1  +" A1, "
	cQuery := cQuery + 		_cArqSZ3	+" Z3, "
	cQuery := cQuery + 		_cArqSEA  +" EA  "
//  Remoção do indice especifico do microsiga para melhorar performance.	
//	cQuery := cQuery + 	"FROM "+ _cArqSE1 +" E1(NOLOCK INDEX ="+ _cArqSE1+ "5), "
//	cQuery := cQuery + 		_cArqSA1  +" A1(NOLOCK INDEX="+_cArqSA1+"5), "
//	cQuery := cQuery + 		_cArqSZ3	+" Z3(NOLOCK INDEX="+_cArqSZ3+"1), "
//	cQuery := cQuery + 		_cArqSEA  +" EA(NOLOCK INDEX="+_cArqSEA+"1) "
	cQuery := cQuery + 	"WHERE A1.A1_CURSO >='" + _mvpar02 + "' AND "
	cQuery := cQuery + 		"A1.A1_CURSO <='" + _mvpar03 + "' AND "
	cQuery := cQuery + 		"E1.E1_MAT >='" + _mvpar04 + "' AND  "
	cQuery := cQuery + 		"E1.E1_MAT <='" + _mvpar05 + "' AND   "
	cQuery := cQuery + 		"E1.E1_VENCTO >='" + DtoS(_mvpar06) + "' AND "
	cQuery := cQuery + 		"E1.E1_VENCTO <='" + DtoS(_mvpar07)+ "' AND   "
	cQuery := cQuery + 		"A1.A1_COD = E1.E1_CLIENTE AND "
	cQuery := cQuery + 		"EA.EA_PORTADO ='" + _mvpar01 + "' AND "
	cQuery := cQuery + 		"LEN(E1.E1_NUMBCO) >0 AND "
	cQuery := cQuery + 		"Z3.Z3_COD = A1.A1_CURSO AND " 
	cQuery := cQuery + 		"EA_NUMBOR+EA_PREFIXO+EA_NUM+EA_PARCELA+EA_TIPO = E1_NUMBOR+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO "
	cQuery := cQuery + 	"ORDER BY A1.A1_NOME"  // Implementado por Humberto 26/12/2000
                                                         

	TCQUERY cQuery NEW ALIAS "QRY"

Return


STATIC FUNCTION FatorVencto(Vencto)

     //-->> Calculo do Fator de vencimento
     dt:=ctod('07/10/1997')  //-->> Database definida pela FEBRABAN
     vencto:=SubStr(Vencto,7,2)+"/"+ SubStr(Vencto,5,2)+"/"+SubStr(Vencto,1,4) 
     vencto1:= ctod("'"+vencto+"'")    
     fator:= strzero((vencto1 - dt),4) 

RETURN fator