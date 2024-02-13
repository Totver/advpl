#include "rwmake.ch"        
#IFNDEF WINDOWS
   #DEFINE PSAY SAY
#ENDIF

User Function mt130wf()        

SetPrvt("CALIAS,NORDER,WNREL,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CABEC1,CABEC2,CSTRING,LEND")
SetPrvt("LIMITE,CBCONT,TAMANHO,ARETURN,NOMEPROG,NLASTKEY")
SetPrvt("NBEGIN,ALINHA,CEXT,ATAMVAL,NTIPO,LI")
SetPrvt("M_PAG,_CSOLCIT,_CFORNECE,_CCOTACAO,_CCONTATO,_CSOLICIT")

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Pto.Entrad³MT130WF   ³ Autora³ Cintia Costa Monteiro ³ Data ³ 04.04.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime Cotacao p/ Fornecedor                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Compras                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ armazena informacoes referente ao posicionamento do arquivo  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nCotacao := paramixb[1]
cAlias := Alias()
nOrder := Dbsetorder()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel     := "MT130WF"
titulo    := Upper(SM0->M0_NOMECOM)
cDesc1    := "Este programa ir  imprimir a Cotacao de Fornecedores"
cDesc2    := "e Recebimentos curto prazo - Sintetico" 
cDesc3    := ""
cabec1    := ""
cabec2    := ""
cString   := "SC8"
lEnd      := .F.
limite    := 132
cbcont    := 0

tamanho   := "M"
aReturn   := { "Zebrado", 1,"Administracao", 1, 2, 1, "",0 }
NomeProg  := "MT130WF"
nLastKey  := 0
nBegin    := 0
aLinha    := { }
cExt      := ""
aTamVal   := {16,2}
nTipo     := 18 
li        := 56
m_pag     := 1
_csolicit := space(10)
_cfornece := space(06)
_ccotacao := space(06)
_ccontato := space(15)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetPrint(cString,wnrel,"Sem Perguntas",Titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey == 27
   Return( .T. )
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return( .T. )
Endif

#IFDEF WINDOWS
	RptStatus({|| I010Imp()})
	Return

Static Function I010Imp()
#ENDIF

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
 ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿  
 ³              inicio da impressao                                      ³  
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

dbSelectArea("SC1")
DbSetOrder(1)
Public cFiltro := DbFilter() // Salvo o filtro atual para restaura-lo
DbClearFil()

dbSelectArea("SC8")
Dbgotop()
DbsetOrder(1)
Dbseek(xfilial("SC8") + nCotacao)
SetRegua(Reccount())
While !Eof() .And. SC8->C8_FILIAL == xFilial("SC8");
      .And. SC8->C8_NUM == nCotacao

      IncRegua()

      #IFNDEF WINDOWS
	      If LastKey() == 286    //ALT_A
		 lEnd := .t.
	      End
      #ENDIF

      IF lEnd
         @Prow()+1,001 PSAY "CANCELADO PELO OPERADOR"
         Exit
      Endif

      If !Empty(SC8->C8_NUMPED)
         Dbselectarea("SC8")
         Dbskip()
         Loop
      Endif

      IF _cfornece<> SC8->C8_FORNECE .Or. _ccotacao <> SC8->C8_NUM
         IF !Empty(_cfornece) .Or. !Empty(_ccotacao)
             RodHF()
         Endif
         _cfornece:=SC8->C8_FORNECE
         _ccotacao:=SC8->C8_NUM
      Endif
      
      If li > 55
         _cSolicit := ""
		 	If SC1->(DbSeek(xFilial()+SC8->C8_NUMSC+SC8->C8_ITEMSC))
	         _csolicit:=Substr(SC1->C1_SOLICIT,1,10)
	   	Endif

         cabec1:= space(5) + "Cotacao: " + SC8->C8_NUM + space(5) + "Solicitante: " + _csolicit + space(5) + "S.C.: " + SC8->C8_NUMSC + space(5) + "Prefixo: " + Substr(SC8->C8_OBS,1,30) + space(5) + "VENCTO.: " + Dtoc(SC8->C8_VALIDA)
         cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
         CabHF()
         CorpoHF()
      Endif

      li:=li+2
      @ li,000 PSAY SC8->C8_ITEM
      @ li,004 PSAY SC8->C8_PRODUTO

      dbSelectArea("SB5")
      Dbgotop()
      DbsetOrder(1)
      If Dbseek(xfilial("SB5")+SC8->C8_PRODUTO) 
         @ li,020 PSAY Substr(SB5->B5_CEME,1,30)
      Else
         dbSelectArea("SB1")
         Dbgotop()
         DbsetOrder(1)
         If Dbseek(xfilial("SB1")+SC8->C8_PRODUTO) 
            @ li,020 PSAY Substr(SB1->B1_DESC,1,30)
         Endif
      Endif

      @ li,051 PSAY SC8->C8_QUANT Picture "@E 999,999.99"
      @ li,062 PSAY SC8->C8_UM
      @ li,117 PSAY dtoc(SC8->C8_DATPRF)

      Dbselectarea("SC8")
      Dbskip()
End
RodHF()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se em disco, desvia para Spool                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Set Device To Screen
If aReturn[5] == 1    // Se Saida para disco, ativa SPOOL
   Set Printer TO
   dbCommitAll()
   ourspool(wnrel)
Endif

MS_FLUSH()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ retorna ambiente anterior                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC1")
Set Filter To &cFiltro // Restaura o filtro atual 
DbGoTop()

Dbselectarea(cAlias)
Dbsetorder(nOrder)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
 ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿  
 ³                           F U N C O E S                               ³  
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ CABECALHO (HF)                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function CabHF()

         _ccontato:=space(15)

         @ li,000 PSAY "PREZADOS SENHORES:"
         @ li,060 PSAY "|"
         @ li,065 PSAY "Por favor queira referenciar-se este numero p/ quaisquer"

         dbSelectArea("SA2")
         Dbgotop()
         DbsetOrder(1)
         If Dbseek(xfilial("SA2")+SC8->C8_FORNECE+SC8->C8_LOJA)
            li:= li+1
            @ li,000 PSAY SA2->A2_NOME 
            @ li,045 PSAY "(" + SC8->C8_FORNECE + "-" + SC8->C8_LOJA + ")"
            @ li,060 PSAY "|"
            @ li,065 PSAY "troca de informacoes referentes a esta cotacao."

            li:= li+1
            @ li,000 PSAY Substr(SA2->A2_END,1,35) + "-" + Substr(SA2->A2_BAIRRO,1,20)
            @ li,060 PSAY "|"
            @ li,085 PSAY "Atenciosamente."

            li:= li+1
            @ li,000 PSAY "Fone:" + SA2->A2_TEL
            @ li,060 PSAY "|"

            li:= li+1
            @ li,000 PSAY "FAX :" + SA2->A2_FAX
            @ li,060 PSAY "|"
            @ li,065 PSAY SM0->M0_NOMECOM

            li:= li+1
            @ li,060 PSAY "|"
            @ li,065 PSAY SM0->M0_ENDENT 

            li:= li+1
            @ li,000 PSAY "Solicitamos de V.Sas. cotacao de precos para os produtos"
            @ li,060 PSAY "|"
            @ li,065 PSAY SM0->M0_COMPENT + "-" + SM0->M0_CIDENT + "-" + SM0->M0_ESTENT  

            li:= li+1
            @ li,000 PSAY "discriminados conforme os padroes abaixo estabelecidos:"
            @ li,060 PSAY "|"
            @ li,065 PSAY "Fax: " + SM0->M0_FAX
            _ccontato:=Substr(SA2->A2_CONTATO,1,15)
         Endif
Return Nil

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ CORPO (HF)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function CorpoHF()

      li:= li+1
      @ li,000 PSAY Replicate("-",limite-1)

      li:= li+1
      @ li,000 PSAY "IT"
      @ li,004 PSAY "CODIGO"
      @ li,020 PSAY "DESCRICAO"
      @ li,051 PSAY "QTDE."
      @ li,062 PSAY "UN"
      @ li,065 PSAY "VL. UNITARIO"
      @ li,081 PSAY "VL. TOTAL"
      @ li,096 PSAY "IPI"
      @ li,101 PSAY "VL. IPI"
      @ li,117 PSAY "DT. ENTREGA"

      li:= li+1
      @ li,000 PSAY Replicate("-",limite-1)
Return Nil

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ RODAPE (HF)                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function RodHF()

         li:= 58
         @ li,000 PSAY Replicate("-",limite-1)

         li:= li+1
         @ li,000 PSAY "Local Entrega:" 
         @ li,050 PSAY "|"
         @ li,055 PSAY "Sub Total"
         @ li,090 PSAY "|"
         @ li,095 PSAY "Condicao de Pagamento"

         li:= li+1
         @ li,000 PSAY SM0->M0_ENDENT 
         @ li,050 PSAY "|"
         @ li,055 PSAY "Descontos"
         @ li,090 PSAY "|"

         li:= li+1
         @ li,050 PSAY "|"
         @ li,055 PSAY "Total do IPI"
         @ li,090 PSAY "|"

         li:= li+1
         @ li,000 PSAY "Local de Pagamento:"
         @ li,050 PSAY "|"
         @ li,055 PSAY "Frete"
         @ li,090 PSAY "|"
         @ li,095 PSAY "Condicao de Reajuste"

         li:= li+1
         @ li,000 PSAY SM0->M0_ENDCOB
         @ li,050 PSAY "|"
         @ li,055 PSAY Replicate("-",20)
         @ li,090 PSAY "|"

         li:= li+1
         @ li,000 PSAY "Contato no Fornecedor: " + _ccontato
         @ li,050 PSAY "|"
         @ li,055 PSAY "TOTAL DO PEDIDO"
         @ li,070 PSAY Replicate(".",10)
         @ li,090 PSAY "|"

         li:= li+1
         @ li,000 PSAY Replicate("-",limite-1)

         li:= li+1
         @ li,000 PSAY "Alcada 1"
         @ li,050 PSAY "|"
         @ li,055 PSAY "Alcada 2"
         @ li,095 PSAY "Emitido em:"
         @ li,120 PSAY Dtoc(SC8->C8_EMISSAO)

         li:= li+1
         @ li,000 PSAY Replicate("-",limite-1)
         
Return Nil

User Function Mata103

Alert("Ponto Mata103")

Return .T.