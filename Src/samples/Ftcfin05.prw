#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 16/05/00
#include "topconn.ch" 

User Function Ftcfin05()        // incluido pelo assistente de conversao do AP5 IDE em 16/05/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("LI,CTEXTO,CARQFIN,CARQFIN1,IMPORTA,_CNUMERO")
SetPrvt("_CPARCELA,_CMATRIC,_DDTEMISS,_DDTVENC,_DDTVALID,_NVALOR")
SetPrvt("_DDTMOVI,_NVALPG,_CTIPO,_NMULTA,_NJUROS,_CSITUAC")
SetPrvt("_CLOCPGT,_CBENEF,_NDESCONT,_CNOME,_CCLIENTE,_CLOJA")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³FUNCAO    ³ FTCFIN05 ³ AUTOR ³ FLAVIA SA             ³ DATA ³ 15/05/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRI‡…O ³ PROGRAMA DE CONVERSAO DO BANCO DE DADOS SQL DO FINESCO     ³±±
±±³          ³ PARA A BASE DE DADOS SIGA - Titulos a Receber SE1          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³USO       ³ ESPECIFICO - FTC                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
LI := 0

msgbox("Iniciando processo de conversao...")

SET CENT ON

CTEXTO:="ESTA ROTINA TEM POR OBJETIVO IMPORTAR OS DADOS PARA O MICROSIGA, COMPATIBILIZANDO AS INFORMACOES. CONTINUA PROCESSO? "

If ! MSGYESNO(CTEXTO)
    Return
End

CARQFIN := '\DADOSADV\PARCELA.DBF'
CARQFIN1:= '\DADOSADV\BENEFICI.DBF'

If ! File(CARQFIN)
    HELP("",1,"NOFileIMP")
    Return
Else
    USE &CARQFIN Exclusive Alias "DADOS" NEW 
    dbSelectArea("DADOS")
    INDEX ON MATRICULA TO INDFIN
End

If ! File(CARQFIN1)
    HELP("",1,"NOFileIMP")
    Return
Else
    USE &CARQFIN1 Exclusive Alias "DADOS1" NEW
    dbSelectArea("DADOS1")
    INDEX ON MATRICULA+NUM_PARC TO INDFIN1
End


PROCESSA( {|| INCDADOS()} )// Substituido pelo assistente de conversao do AP5 IDE em 16/05/00 ==> PROCESSA( {|| EXECUTE(INCREG)},,"Incluindo registros na base de dados... ")


/*/
ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿
³FUN‡…O    ³ INCREG   ³ AUTOR ³ ALESSANDRO TAKI       ³ DATA ³ 05/02/99 ³
ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´
³INCLUI REGISTROS NA BASE DE DADOS SIGAADV                              ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 16/05/00 ==> FUNCTION INCREG
Static FUNCTION INCDADOS()       

_nDescont   := 0.00

dbSelectArea("DADOS")
ProcRegua(LastRec())
dbGoTop()

While ! EOF()
    importa := 1
    IncProc()
    _cNumero := "0"+DADOS->NOSSO_NUM
    _cParcela:= DADOS->NUM_PARC
    _cMatric := DADOS->MATRICULA
    _dDtVenc := DADOS->DATA_VENC
    _dDtValid:= DATAVALIDA(_dDtVenc)
    _nValor  := DADOS->VALOR_PARC
    _dDtMovi := DADOS->DATA_PAGT
    _nValpg  := DADOS->VALOR_PAGT  
    _cTipo   := DADOS->TIPO_PARC
    _nMulta  := DADOS->MULTA    
    _nJuros  := DADOS->JUROS
    _cSituac := DADOS->FLG_SITUA
    _cLocPgt := DADOS->FLG_LOCPGT 
    _cContrato:=DADOS->CONTRATO   
    _cBenef  := "" 
    _nDescont:= 0.00
    _cNome   := ""     
    _cCliente:= ""     

    dbSelectArea("DADOS1")
    dbSetOrder(1)
    DbGoTop()               

    If DBSeek(_cMatric+_cParcela,.F.)
     _cBenef   := DADOS1->COD_BENEF  
     _nDescont := DADOS1->VALOR
    Endif

// busca de dados dos alunos
    dbSelectArea("SA1")
    dbSetOrder(5)
    DbGoTop()                      
    
    If DBSeek(xFILIAL()+_cMatric,.F.)
     _cNome   := SA1->A1_NREDUZ
     _cCliente:= SA1->A1_COD
    Endif

   If importa == 1
    //Gravando SE1 - Titulos a Receber
    dbSelectArea("SE1")
    RecLock("SE1",.T.)
    SE1->E1_FILIAL  := "01"
    SE1->E1_PREFIXO := "FTC"    
    SE1->E1_NUM     := _cNumero
    SE1->E1_NUMPARC := _cParcela 
    SE1->E1_TIPO    := "DP"
    SE1->E1_CLIENTE := _cCliente
    SE1->E1_LOJA    := "01"  
    SE1->E1_VENCTO  := _dDtVenc
    SE1->E1_EMISSAO := SE1->E1_VENCTO - 10  
    SE1->E1_VENCREA := _dDtValid   
    SE1->E1_VALOR   := _nValor
    SE1->E1_VLCRUZ  := _nValor
//    SE1->E1_VLRREAL := _nValor
    SE1->E1_MOEDA   := 1  
    SE1->E1_VENCORI := _dDtVenc
    SE1->E1_EMIS1   := SE1->E1_VENCTO - 10
    SE1->E1_NOMCLI  := _cNome
    SE1->E1_MATRIC  := _cMatric
    SE1->E1_TIPOPAR := _cTipo
    SE1->E1_SITPARC := _cSituac
    SE1->E1_BENEF   := _cBenef
    SE1->E1_DESCONT := _nDescont
    SE1->E1_CONTR   := _cContrato
    SE1->E1_FLUXO   :=  "S"
    SE1->E1_OCORREN := "01" 
    SE1->E1_NATUREZ := "3102      "
    SE1->E1_ORIGEM  := "FINA040 "  
    se1->e1_situaca := "0"
  // Tratamento Forma/Local de Pagamento da Parcela
/*/    
  Do Case
   Case _cLocPgt == "1"
    SE1->E1_SITUACA := "0"
   Case _cLocPgt == "2"
    SE1->E1_SITUACA := "1"
   Case _cLocPgt == "4"
    SE1->E1_SITUACA := "0"
  Endcase  
/*/

  //Tratamento para Titulos Baixados / Aberto PS: No existem baixas parciais no Finesco

   If (_nValpg <> 0.00)      //Baixado

     SE1->E1_PORTADO:= "CX1"
     SE1->E1_STATUS := "B"
     REPLACE SE1->E1_SALDO WITH 0.00
//     SE1->E1_SALDO  := 0.00
     SE1->E1_BAIXA  := _dDtMovi
     SE1->E1_MOVIMEN:= _dDtMovi      
     REPLACE SE1->E1_VALLIQ WITH _nValor     
//     SE1->E1_VALLIQ := _nValor     
     SE1->E1_OK     := GETMARK()
     
     Dbselectarea("SE5")
     Reclock("SE5",.T.)
       SE5->E5_FILIAL  := "01"       
       SE5->E5_PREFIXO := "FTC"
       SE5->E5_NUMERO  := _cNumero   
       SE5->E5_TIPO    := "DP"
       SE5->E5_CLIFOR  := _cCliente
       SE5->E5_LOJA    := "01"      
       SE5->E5_NATUREZ := "3102      " 
       SE5->E5_DATA    := _dDtMovi
       SE5->E5_DTDISPO := _dDtMovi    
       SE5->E5_DTDIGIT := _dDtMovi    
       SE5->E5_VALOR   := _nValor
       SE5->E5_VLMOED2 := _nValor
       SE5->E5_BANCO   := "CX1"  
       SE5->E5_AGENCIA := "000  "
       SE5->E5_CONTA   := "000       "
       SE5->E5_BENEF   := _cNome
       SE5->E5_RECPAG  := "R"   
       SE5->E5_TIPODOC := "VL"
       SE5->E5_LA      := "N "   
       SE5->E5_MOTBX   := "NOR"    
       SE5->E5_SEQ     := "01"   
       SE5->E5_HISTOR  := "Valor Recebido s/ Titulo"
    Do Case
     Case _cParcela == "01"
      SE5->E5_PARCELA:= "A"
     Case _cParcela == "02"
      SE5->E5_PARCELA:= "B"
     Case _cParcela == "03"
      SE5->E5_PARCELA:= "C"
     Case _cParcela == "04"
      SE5->E5_PARCELA:= "D"
     Case _cParcela == "05"
      SE5->E5_PARCELA:= "E"
     Case _cParcela == "06"
      SE5->E5_PARCELA:= "F"
     Case _cParcela == "07"
      SE5->E5_PARCELA:= "G"
     Case _cParcela == "08"
      SE5->E5_PARCELA:= "H"
     Case _cParcela == "09"
      SE5->E5_PARCELA:= "I"
     Case _cParcela == "10"
      SE5->E5_PARCELA:= "J"
     Case _cParcela == "11"
      SE5->E5_PARCELA:= "K"
     Case _cParcela == "12"
      SE5->E5_PARCELA:= "L"
    Endcase  
   Msunlock()

   Else             //Aberto

       SE1->E1_STATUS := "A"
       REPLACE SE1->E1_SALDO  WITH _nValor
       REPLACE SE1->E1_VALLIQ WITH 0.00
    Endif       
      

// Tratamento Numero de Parcelas : De Numerico para AlfaNumerico 

    Do Case
     Case _cParcela == "01"
      SE1->E1_PARCELA:= "A"
     Case _cParcela == "02"
      SE1->E1_PARCELA:= "B"
     Case _cParcela == "03"
      SE1->E1_PARCELA:= "C"
     Case _cParcela == "04"
      SE1->E1_PARCELA:= "D"
     Case _cParcela == "05"
      SE1->E1_PARCELA:= "E"
     Case _cParcela == "06"
      SE1->E1_PARCELA:= "F"
     Case _cParcela == "07"
      SE1->E1_PARCELA:= "G"
     Case _cParcela == "08"
      SE1->E1_PARCELA:= "H"
     Case _cParcela == "09"
      SE1->E1_PARCELA:= "I"
     Case _cParcela == "10"
      SE1->E1_PARCELA:= "J"
     Case _cParcela == "11"
      SE1->E1_PARCELA:= "K"
     Case _cParcela == "12"
      SE1->E1_PARCELA:= "L"
    Endcase  


       //Tratamento de Multas ,Juros e Descontos

    If (_nValpg <> 0.00   .AND.  _nValpg > _nValor)

      SE1->E1_JUROS  := (_nValpg - _nValor)

    Endif

    msUnLock()

   Endif
   
    dbSelectArea("DADOS")
    dbSkip()
    loop
End

SET CENT OFF
MSGBOX("IMPORTACAO REALIZADA COM SUCESSO")
dbSelectArea("DADOS")
dbCloseArea()
dbSelectArea("DADOS1")
dbCloseArea()
dbSelectArea("SE1")
RetIndex("SE1")
FErase("INDFIN.CDX")
FErase("INDFIN1.CDX")
Return
