#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 07/09/00
#IFNDEF WINDOWS
    #DEFINE PSay Say
#ENDIF

User Function viam03()        // incluido pelo assistente de conversao do AP5 IDE em 07/09/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CTITULO,CDESC1,CDESC2,CDESC3,CSTRING,AORD")
SetPrvt("WNREL,ARETURN,TAMANHO,LIMITE,CRODATXT,CBCONT")
SetPrvt("LI,NLASTKEY,M_PAG,CPERG,CABEC1,CABEC2")
SetPrvt("ASTRU,CARQTRAB,ENTREI,XPESO,XCUSTO,XDOC")
SetPrvt("XSERIE,XFORNECE,A,CARQNTX,CINDICE,NREGS")
SetPrvt("IMPFOR,A_C10,D_C10,A_ENF,D_ENF,REC")
SetPrvt("DATA,ADRIVER,LEND,ASX1,X1,Z")

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    : VIEM03   ³ Autor : Alexandre Felipe      ³ Data : 07/01/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao: Relacao das ultimas compras Produto / Fornecedor           ³±±
±±³                                                                       ³±±
±±³ Arquivos : SA2 - SB1 -SD1 - SE2                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

CAMPOS: B1_LUCRO 
        D1_ACRESC
*/

CriaSx1()

cTitulo  := "Planilha de Formacao de Precos - Filial 08"
cDesc1   := "Este programa tem por objetivo fornecer os custos dos produtos"
cDesc2   := "e preco sugerido."
cDesc3   := ""
cString  := "SD1"
aOrd     := {"Data"}
wnrel    := "VIAM03"
aReturn  := {"132 Colunas", 1,"Vianense", 2, 2, 1, "",1}
Tamanho  := "G"
Limite   := 220
cRodaTxt := ""
CbCont   := 1
Li       := 80
nLastKey := 0
m_pag    := 0
cPerg    := "VIEM03"
cabec1   := "PRODUTOS       DESCRICAO                      Quantidade     CUSTO NOTA ACRES/DESC   FRETE  ICM FRETE  DIF.ICMS     IPI ICMS/IPI TRANSFERENCIA PRC CUSTO  LUCRO SUGERIDO PRC ATUAL DEFINITIVO"
cabec2   := ""
v_Ok := .t.

v_Ok  := Pergunte(cPerg,.T.)

If !v_Ok
   Return
Endif

 wnrel:=SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)
If (nLastKey == 27)
   Return
Endif

 SetDefault(aReturn,cString)
If (nLastKey == 27)
   Return
Endif

#IFDEF WINDOWS
    RptStatus({|| Imprime()})// Substituido pelo assistente de conversao do AP5 IDE em 07/09/00 ==>     RptStatus({|| Execute(Imprime)})
#ENDIF
Static Function Imprime()
aStru := {}
AADD(aStru,{"COD    ","C",15,0,})
AADD(aStru,{"FORNECE","C", 6,0,}) 
AADD(aStru,{"LOJA   ","C", 2,0,})
AADD(aStru,{"DESCRI ","C",30,0,}) // 30
AADD(astru,{"FATOR  ","N", 7,3,})
AADD(aStru,{"QUANT  ","N", 11,2,})
AADD(aStru,{"UM     ","C", 2,0,})
AADD(aStru,{"SEGUM  ","C", 2,0,})
AADD(aStru,{"ACRESC ","N", 6,2,})
AADD(aStru,{"DESC   ","N", 6,2,})
AADD(aStru,{"QTSEGUM","N", 11,3,})
AADD(aStru,{"SERIE  ","C", 3,0,})
AADD(aStru,{"DOC    ","C", 6,0,})
AADD(aStru,{"CUSTO  ","N",11,3,})
AADD(aStru,{"FRETE  ","N", 4,2,})
AADD(aStru,{"ICMFRET","N", 5,3,})
AADD(aStru,{"DIFICM ","N", 11,3,})
AADD(aStru,{"VALIPI ","N", 7,3,})
AADD(aStru,{"ICM "   ,"N", 7,3,})
AADD(aStru,{"ALICM " ,"N", 5,2,})
AADD(aStru,{"ICMSIPI","N", 7,3,})
AADD(aStru,{"TRANSFE","N", 11,3,})
AADD(aStru,{"ICMR","N",7,3,})
AADD(aStru,{"PRCCUST","N", 11,3,})
AADD(aStru,{"LUCRO  ","N", 5,2,})
AADD(aStru,{"PRCSUGE","N", 11,3,})
AADD(aStru,{"PRCATUA","N", 6,3,})
AADD(aStru,{"DTDIGIT","D", 7,0,})
AADD(aStru,{"CGC    ","C",14,0,})
AADD(aStru,{"NOME   ","C",40,0,})
AADD(aStru,{"PESO   ","N",11,4,})

cArqTrab:=CriaTrab(aStru,.T.)
Use &cArqTrab Alias TR1 New

// DbSelectArea("SZ4")
// DbSetOrder(2)  // Filial + Ndoc + Serie

DbSelectArea("SD1")
DbSetOrder(1) // Filial + Flag + Doc + Serie

Set SoftSeek On
DbSeek (xFilial())
Set SoftSeek Off

// While SD1->D1_FLAG == " "  .and. !eof() .and. xFilial() == SD1->D1_FILIAL
While xFilial() == SD1->D1_FILIAL
      DbSelectArea("SF1")
      DbSetOrder(1) // Filial + Doc + Serie + Fornece + Loja
      DbSeek(xFilial()+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA)

      DbSelectArea("SA2")                          
      DbSetOrder(1) // Filial + Fornecedor
      DbSeek(xFilial()+SD1->D1_FORNECE)
      
      DbSelectArea("SB1")
      DbSetOrder(1)  // Filial + Codigo
      DbSeek(xFilial()+SD1->D1_COD)

      Entrei:=.t.
      xPESO:=0
      xCUSTO:=0
      xDOC     := SD1->D1_DOC
      xSERIE   := SD1->D1_SERIE
      xFORNECE := SD1->D1_FORNECE

      While SD1->D1_DOC == xDOC .and. SD1->D1_SERIE == xSERIE .and. SD1->D1_FORNECE == xFORNECE 

        DbSelectArea("SB1")
        DbSetOrder(1)
        DbSeek(xFilial()+SD1->D1_COD)
        DbSelectArea("TR1")
        Reclock("TR1",.T.)
        if entrei ==.t.
           entrei:=.f.
           a:=recno()
        endif
        TR1->COD    := SD1->D1_COD
        TR1->QUANT  := SD1->D1_QUANT
        TR1->FATOR  := 0.00 // SD1->D1_FAEMB
        TR1->QTSEGUM:= SD1->D1_QTSEGUM
        TR1->FORNECE:= SD1->D1_FORNECE
        TR1->SERIE  := SD1->D1_SERIE
        TR1->DOC    := SD1->D1_DOC
        TR1->ACRESC := 0.00 // SD1->D1_ACRESC/SD1->D1_FAEMB
        TR1->DESC   := SD1->D1_VALDESC/SD1->D1_QUANT
        TR1->VALIPI := (SD1->D1_VALIPI /SD1->D1_QUANT)
        TR1->DTDIGIT:= SD1->D1_DTDIGIT
        TR1->FRETE  := SD1->D1_VAFRETE/SD1->D1_QUANT
        TR1->PESO   := SB1->B1_PESO*SD1->D1_QUANT
        xPESO       := xPESO+TR1->PESO
        TR1->LUCRO  := SB1->B1_LUCRO
        TR1->DESCRI := SB1->B1_DESC
        DbSelectArea("SAH")
        DbSetOrder(1)
        DbSeek(xFilial("SAH")+SB1->B1_UM)
        DbSelectArea("TR1")
        TR1->UM     := SAH->AH_DESCPO
        TR1->SEGUM  := SB1->B1_SEGUM
 //       DbSelectArea("SZ5")
 //       DbSeek(xFilial("SZ5")+SB1->B1_CODCLAS)
 //       DbSelectArea("TR1")
 //       TR1->ALICM  := SZ5->Z5_PERCCLA  // SB1->B1_PICM
        TR1->ICMR   := SD1->D1_ICMSRET/SD1->D1_QUANT

        xCUSTO := SD1->D1_TOTAL / SD1->D1_QUANT

        TR1->CUSTO  :=  xCUSTO + TR1->ACRESC - TR1->ICMR - TR1->DESC

        TR1->TRANSFE:= TR1->CUSTO+TR1->VALIPI
        TR1->ICM    :=SD1->D1_PICM
            DbSelectArea("SF4")
            DbSetOrder(1)
            DbSeek(xFilial()+SD1->D1_TES)

            DbSelectArea("SF7")
            DbSetOrder(1)
            DbSeek(xFilial()+SB1->B1_GRTRIB)

            IF SF1->F1_EST == "RJ" .OR. SF4->F4_LFICM == "I" .OR. SF4->F4_LFICM == "O"
               TR1->DIFICM :=TR1->CUSTO * 0.04
            ElseIf EOF()
               TR1->DIFICM := TR1->CUSTO * 0.10
            ELSE
               TR1->DIFICM := TR1->CUSTO * ((SF7->F7_ALIQINT-SF7->F7_ALIQEXT1+4)/100)
               IF TR1->DIFICM < 0.04
                  TR1->DIFICM := TR1->CUSTO * 0.04
               ENDIF
            ENDIF
            TR1->ICMSIPI := TR1->VALIPI* 0.18
            
            DbSelectArea("SB0") // SB5
            DbSetOrder(1)
            DbSeek(xFilial()+SB1->B1_COD)
            
            DbSelectArea("TR1")
            TR1->PRCATUA:= SB0->B0_PRV2  // SB5->B5_PRV2 (Alterei)
            TR1->CGC    := SA2->A2_CGC
            TR1->NOME   := SA2->A2_NOME
            TR1->LOJA   := SD1->D1_LOJA

            MsunLock()
            DbSelectArea("SD1")
            DbSkip()
      End

      DbSelectArea("TR1")
      Go A

      While !EOF()
        RECLOCK("TR1",.F.)
        TR1->ICMFRET:= TR1->FRETE*.18
        TR1->PRCCUST:= TR1->CUSTO + TR1->DIFICM+TR1->VALIPI+TR1->ICMSIPI+;
                       TR1->FRETE + (TR1->FRETE*(TR1->ICM/100))+TR1->ICMFRET+TR1->ICMR
        If SB1->B1_TIPO $ "PR|MP"
           TR1->PRCSUGE:= TR1->PRCCUST+(TR1->PRCCUST * (TR1->LUCRO /100)) //+0.005
        Else
           TR1->PRCSUGE:= 0
        EndIf
        MsunLock()
        DBSKIP()
      End
      DbSelectArea("SD1")
 End

DbSelectArea("TR1")
cArqNtx := CriaTrab(NIL,.F.)
cIndice := 'DTOs(DTDIGIT)+DOC+SERIE+FORNECE+DESCRI'       //********
IndRegua("TR1",cArqNtx,cIndice,,,'Selecionando Registros...')

DbGoTop()
nRegs := RecCount()
SetRegua( nRegs )

IMPFOR:=.f.

//Comandos de ImpressÆo de Relat¢rios "Comprimido a 10cpp"//
//A_c10 := chr(27)+chr(77)+chr(15)
//D_c10 := chr(27)+chr(77)+chr(18)

// Comandos de ImpressÆo de Relat¢rios "Enfatizado a 

//A_enf :=chr(27)+chr(69)
//D_enf :=chr(27)+chr(70)

// Rec := chr(27)+chr(64)

Data    := DTOC(Ddatabase)
//aDriver := ReadDriver() // era comentario
//@ 0,0 PSay &Adriver[5]  // era comentario
//@ 0,0 PSay CHR(27)+CHR(64)
//@ 0,0 PSay a_c10

While !Eof()

       IncRegua()

       #IFNDEF WINDOWS
           If LastKey() == 286
               lEnd := .T.
           EndIf
       #ENDIF

       If lEnd
           @ Prow()+1,001 PSay "CANCELADO PELO OPERADOR"
           Exit
       EndIf

    If Li >= 56
       m_pag:= m_pag+1
       Li:=1
       @ Li,000 PSay   "*"
       @ Li,001 PSay   Replicate("-",135)
       @ Li,136 PSay   "*"
       Li:=Li+1
       @ Li,000 PSay   "*"
       @ Li,002 PSay   "Supermercados Vianense Ltda - Filial 08"
       @ Li,118 PSay "Emissao: "
       @ Li,127 PSay   Data
       @ Li,136 PSay   "*"
       Li:=Li+1
       @ Li,000 PSay   "*"
       @ Li,002 PSay   "Programa: Viam03.prx"
       @ Li,055 PSay "Planilha de Formacao de Precos"
       @ Li,118 PSay "Pagina : "+Str(m_pag,2)
       @ Li,136 PSay "*"
       Li:=Li+1
       @ Li,000 PSay "*"
       @ Li,001 PSay   Replicate("-",135)
       @ Li,136 PSay   "*"
       Li:=Li+2
       // @ Li,001 PSay "Produto  Descricao               Quant  Custo Nf  Dif.ICMS  IPI  ICMS/IPI  Transf  Pco Custo  %Lucro Sugerido  Pco Atual  Final"


       @ Li,001 PSay "Produto  Descricao                           Quant     UM    Custo NF"   
//                    1        10                              42           56     62                                                                                    
//                    12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                    1                  20        30        40        50        60        70        80        90        100       110       120       130
       Li:= Li+1
                                                                                                                                 
       @ Li,001 PSay "Acr/Des   Frete   IcmFrete   DifIcms     IPI   ICMS/IPI   Transf   Pco Custo   %Lucro   Sugerido   Pco Atual   Definitivo"   
//                    1        10        20        30        40       49       58         69         80        90          102         114         126      
//                    12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                    1                  20        30        40        50        60        70        80        90        100       110       120       130
       Li:= Li+1
       @ Li,000 PSay   "*"
       @ Li,001 PSay   Replicate("-",135)
       @ Li,136 PSay   "*"
       Li:=Li+2
    EndIf

    If !IMPFOR 
       @ Li,001 PSay "CGC: "+CGC+"   FORNECEDOR :  "
//       @ Li,006 PSay CGC
       @ Li,040 PSay NOME
       @ Li,100 PSay "N.F. : "+DOC
       @ Li,116 PSay "DATA : "+DTOC(DTDIGIT)
       Li:=Li+2
       IMPFOR:=.t.
       xDOC  := DOC
       xFORNECE := FORNECE
       xSERIE   := SERIE
    EndIf
    @ Li,001 PSay SubStr(COD,1,6)
    @ Li,010 PSay   DESCRI
    @ Li,042 PSay   QUANT            PICTURE "@E 999,999"   // 30
    @ Li,056 PSay   UM                                      //57
    @ Li,062 PSay   CUSTO-(DESC)   PICTURE "@E 999.999"     //68 (ACRESC)
//  @ Li,034 PSay   QTSEGUM          PICTURE "@E 999,999"     // 48

    @ Li+1,001 PSay   DESC           PICTURE "@E 999.999"     //40 ACRESC
    @ Li+1,010 PSay   FRETE            PICTURE "@E 999.99"      //50
    @ Li+1,020 PSay   ICMFRET          PICTURE "@E 999.999"     //58
    @ Li+1,030 PSay   DIFICM           PICTURE "@E 999.999"     //76
    @ Li+1,040 PSay   VALIPI           PICTURE "@E 999.99"      //84
    @ Li+1,049 PSay   ICMSIPI          PICTURE "@E 999.999"     //93
    @ Li+1,058 PSay   TRANSFE          PICTURE "@E 999.999"     //104
    @ Li+1,069 PSay   PRCCUST          PICTURE "@E 999.999"   //116
    @ Li+1,080 PSay   LUCRO            PICTURE "@E 999,99"      //127
    @ Li+1,090 PSay PRCSUGE          PICTURE "@R 999.99"
    @ Li+1,102 PSay PRCATUA          PICTURE "@R 999.99"
    @ Li+1,114 PSay PRCSUGE          PICTURE "@R 999.99"
    @ Li+1,126 PSay   "__________"
//    @ Li+1,112 PSay   "______________"

//  @ Li,056 PSay   SEGUM
//  @ Li,059 PSay   FATOR            PICTURE "@E 999,999"     

//  @ Li,072 PSay   CUSTO-(ACRESC)   PICTURE "@E 999.999"     
                              
//    @ Li,150 PSay   ICMR             PICTURE "@E 999.999"     

*/
    DbSelectArea("SZ4")
    dbSetOrder(2)
    DbSeek(xFilial("SZ4")+TR1->DOC+TR1->SERIE+TR1->FORNECE+TR1->DESCRI)

    IF Found()
       Reclock("SZ4",.F.)
        SZ4->Z4_NDOC := TR1->DOC
        SZ4->Z4_FORNECE := TR1->FORNECE
        SZ4->Z4_SERIE := TR1->SERIE
        SZ4->Z4_LOJA := TR1->LOJA
        SZ4->Z4_TRANSFE := TR1->TRANSFE
        SZ4->Z4_SUGERID := TR1->PRCSUGE
        SZ4->Z4_ATUAL   := TR1->PRCATUA
        SZ4->Z4_DEFINIT := TR1->PRCSUGE
        SZ4->Z4_PCUSTO  := TR1->PRCCUST
        SZ4->Z4_QUNID   := TR1->QUANT
       MsunLock()
  Else
       Reclock("SZ4",.T.)
        SZ4->Z4_FILIAL := xFILIAL("SD1") 
        SZ4->Z4_DENTR := TR1->DTDIGIT
        SZ4->Z4_NDOC := TR1->DOC 
        SZ4->Z4_FORNECE := TR1->FORNECE
        SZ4->Z4_SERIE := TR1->SERIE
        SZ4->Z4_LOJA := TR1->LOJA
        SZ4->Z4_PRODUTO := TR1->COD     
        SZ4->Z4_DESC    := TR1->DESCRI 
        SZ4->Z4_SUGERID := TR1->PRCSUGE
        SZ4->Z4_ATUAL   := TR1->PRCATUA
        SZ4->Z4_DEFINIT := TR1->PRCSUGE
        SZ4->Z4_TRANSFE := TR1->TRANSFE
        SZ4->Z4_PCUSTO  := TR1->PRCCUST
        SZ4->Z4_QUNID   := TR1->QUANT
        MsunLock()
    EndIf */

    Li:=Li+2

    DbSelectArea("TR1")
    DbSkip()

    If DOC+FORNECE+SERIE#xDOC+xFORNECE+xSERIE
       IMPFOR:=.f.
       Li:=Li+2
    Endif
end

DbSelectArea("SZ4")
 RetIndex("SZ4")

DbSelectArea("TR1")
Use

// Roda(CbCont,cRodaTxt,Tamanho)
Eject

Set Device to Screen

If aReturn[5] == 1
   Set Printer To
   Commit //All
   OurSpool(wnrel)
Endif

Ms_Flush()

Return
****************
// Substituido pelo assistente de conversao do AP5 IDE em 07/09/00 ==> Function CriaSX1
Static Function CriaSX1()
****************

 * 01  X1_GRUPO    C  06          14  X1_VAR02  C  15
 * 02  X1_ORDEM    C  02          15  X1_DEF02  C  15
 * 03  X1_PERGUNT  C  20          16  X1_CNT02  C  30
 * 04  X1_VARIAVL  C  06          17  X1_VAR03  C  15
 * 05  X1_TIPO     C  01          18  X1_DEF03  C  15
 * 06  X1_TAMANHO  N  02          19  X1_CNT03  C  30
 * 07  X1_DECIMAL  N  01          20  X1_VAR04  C  15
 * 08  X1_PRESEL   N  01          21  X1_DEF04  C  15
 * 09  X1_GSC      C  01          22  X1_CNT04  C  30
 * 10  X1_VALID    C  60          23  X1_VAR05  C  15
 * 11  X1_VAR01    C  15          24  X1_DEF05  C  15
 * 12  X1_DEF01    C  15          25  X1_CNT05  C  30
 * 13  X1_CNT01    C  30          26  X1_F3     C  03

 aSx1 := {}

//           1          2      3                        4          5    6    7   8    9    10    11          12          13   14   15          16   17   18        19   20   21   22   23   24   25    26
 AADD(aSx1,{"VIEM03" , "01" , "Data...............?" , "mv_ch1" , "D" , 08 , 0 , 0 , "G" , "" , "mv_par01" , "       " , "" , "" , "       " , "" , "" , "     " , "" , "" , "" , "" , "" , "" , "" , "SD1" })

 DbSelectArea("SX1")
 DbSetOrder(1)

 If !DbSeek("VIEM0301")

    DbSeek("VIEM03")

    While !Eof() .And. Alltrim(SX1->X1_GRUPO) == "VIEM03"
          Reclock("SX1",.F.,.F.)
          DbDelete()
          MsunLock()
          DbSkip()
    End

    For X1:=1 to Len(aSX1)
        RecLock("SX1",.T.)
        For Z:=1 To FCount()
            FieldPut(Z,aSx1[X1,Z])
        Next
        MsunLock()
    Next

Endif

Return

/*

Lay-Out
CGC:                    FORNECE:                                          NF:               ENTRADA:                VENCIMENTO:
Produto Descricao                      Quantidade          Custo NF Acr/Des   Frete ICM Fr. Dif.ICMS     IPI ICMS/IPI Transf P.Custo  Lucro Suger. P.Atual Definitivo"
1234567 123456789-123456789-123456789- 99.999 CX 99.999 UN   999,99 999,999 999,999 999,999  999,999 999,999  999,999 999,99 999,999 999,99 999,99  999,99
1       09                             40     47 50     57   62     69      77      85       94      102      111     119    126     134    141     149         

*/
