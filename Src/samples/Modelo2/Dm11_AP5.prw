#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 27/06/00

User Function Dm11()        // incluido pelo assistente de conversao do AP5 IDE em 27/06/00

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("NOPCX,_NPROP,_NUM,_NNORM,_NESPE,_SALIAS")
SetPrvt("_SREC,NUSADO,AHEADER,ACOLS,_NI,_CTIPO")
SetPrvt("_NQUANT,_CMOD,CTITULO,AC,_DDATA,AR")
SetPrvt("ACGD,CLINHAOK,CTUDOOK,LRETMOD2,_CPROD,_NQTDE")
SetPrvt("_L,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿛rograma  � DISMAQ   � Autor � Ricardo Cavalini      � Data � 24/07/99 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Distribuicao da maquinacao no arquivo SZ0.                 낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Opcao de acesso para o Modelo 2                              �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza

nOpcx  := 3
_nProp := 0
_nUm   := 0
_nNorm := 0
_nEspe := 0
_sAlias := Alias()
_sRec   := Recno()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Montando aHeader                                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
dbSelectArea("SX3")
dbSetOrder(1)
dbSeek("SZ0")
nUsado :=0
aHeader:={}
While !Eof() .And. (x3_arquivo == "SZ0")
    If AllTrim(X3_CAMPO)=="Z0_FILIAL".Or. AllTrim(X3_CAMPO)=="Z0_MAQ" .Or. AllTrim(X3_CAMPO)=="Z0_DATA"
        dbSkip()
        Loop
    Endif
    If X3USO(x3_usado) .AND. cNivel >= x3_nivel
    	nUsado:=nUsado+1
        AADD(aHeader,{ TRIM(x3_titulo), AllTrim(x3_campo), x3_picture,;
            x3_tamanho, x3_decimal,x3_valid,x3_usado, x3_tipo, x3_arquivo, x3_context } )
    Endif
    dbSkip()
Enddo

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Montando aCols                                               �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
aCols:={Array(nUsado+1)}
aCols[1,nUsado+1]:=.F.
For _ni:=1 to nUsado
	aCols[1,_ni]:=CriaVar(aHeader[_ni,2])
Next

// aCOLS[1][nUsado+1] := .F. 
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis do Cabecalho do Modelo 2                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
_cTIPO   := SPACE(10)
_nQUANT  := 0 
_cMOD    := DATE()
IF  Len(aCols) > 0
   //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
   //� Titulo da Janela                                             �
   //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
   cTitulo:="Distribuicao da Maquinacao"
   //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
   //� Array com descricao dos campos do Cabecalho do Modelo 2      �
   //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
   aC := {}
   // aC[n,1] = Nome da Variavel Ex.:"cCliente"
   // aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
   // aC[n,3] = Titulo do Campo
   // aC[n,4] = Picture
   // aC[n,5] = Validacao
   // aC[n,6] = F3
   // aC[n,7] = Se campo e' editavel .t. se nao .f.
// _ddata  := ddatabase
   AADD( aC,{ "_CTIPO"  , {20,30}  , "Nr. da Maq."                    ,,,"SB1", .T. })
   AADD( aC,{ "_NQUANT" , {20,180} , "Quantidade ","@E 99,999,999.999",,     ,.T. })
   AADD( aC,{ "_CMOD"   , {40,30}  , "Data       ",                   ,,     ,.T. })
   //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
   //� Array com descricao dos campos do Rodape do Modelo 2         �
   //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
   aR:={}
   //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
   //� Array com coordenadas da GetDados no modelo2                 �
   //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
   aCGD := { 52,15,120,305 }
   //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
   //� Validacoes na GetDados da Modelo 2                           �
   //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
   cLinhaOk := "If(Empty(aCols[n,1]) .And. !aCols[n,nUsado+1] ,.F.,.T.)"
   cTudoOk  := "AllWaysTrue()"
   //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
   //� Chamada da Modelo2                                           �
   //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
   lRetMod2 := Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)

   _cPROD := Ascan(aHeader,{|x| x[2]=="Z0_PRODUTO"})
   _nQTDE := Ascan(aHeader,{|x| x[2]=="Z0_QUANT"})

   If lRetMod2
      dbSelectArea("SZ0")
      For _l := 1 To Len(aCols)
            dbSelectArea("SZ0")
            RecLock("SZ0",.T.)
             SZ0->Z0_FILIAL  := XFILIAL()
             SZ0->Z0_MAQ     := _CTIPO
             SZ0->Z0_DATA    := _CMOD
             SZ0->Z0_PRODUTO := aCols[_l,_cPROD]
             SZ0->Z0_QUANT   := aCols[_l,_nQTDE]
            MsUnLock()
      Next _l
   ENDIF
Endif
RETURN

