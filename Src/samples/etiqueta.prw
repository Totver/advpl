#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 20/09/00
#IFNDEF WINDOWS
#DEFINE PSAY SAY
#ENDIF

User Function Etiqueta()        // incluido pelo assistente de conversao do AP5 IDE em 20/09/00

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("LEND,TITULO,CDESC1,CDESC2,CDESC3,CSTRING")
SetPrvt("WNREL,AORD,ARETURN,NLASTKEY,CPERG,TAMANHO")
SetPrvt("NTIPO,CORD,_NLIN,_NCOL,LI,LIMITE")
SetPrvt("_NQUANT,_NETIQ,_NCONT,OPR,")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 20/09/00 ==> #DEFINE PSAY SAY
#ENDIF
/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � ETIQUETA � Autor � Murilo M. Tavares     � Data � 01.10.00 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o 쿐tiquetas com codigo de barra                               낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis                                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
lEnd     :=.F.
titulo   := "Etiquetas para Inventario"
cDesc1   := "Este programa ira emitir etiquetas para produtos,"
cDesc2   := "com codigo de barras."
cDesc3   := ""
cString  := "SB1"
wnrel    := "MATR270"
aOrd     := {" Por Codigo         "}

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis tipo Private padrao de todos os relatorios         �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nLastKey := 0
cPerg    := "MTR270"
Tamanho  := "P"
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica as perguntas selecionadas                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis utilizadas para parametros                         �
//� mv_par01     // Almox. de                                    �
//� mv_par02     // Almox. ate                                   �
//� mv_par03     // Produto de                                   �
//� mv_par04     // Produto ate                                  �
//� mv_par05     // Quantidade                                   �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
pergunte(cPerg,.F.)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Envia controle para a funcao SETPRINT                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho)

If nLastKey == 27
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	Return
Endif

#IFDEF WINDOWS
RptStatus({|| C270Imp()},titulo)// Substituido pelo assistente de conversao do AP5 IDE em 20/09/00 ==> RptStatus({|| Execute(C270Imp)},titulo)
Return
// Substituido pelo assistente de conversao do AP5 IDE em 20/09/00 ==> Function C270Imp
Static Function C270Imp()
#ENDIF

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    �          � Autor �                       � Data �          낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Chamada do Relatorio                                       낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      �                                                            낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis locais exclusivas deste programa                   �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
nTipo := 0
cOrd  := ""
_nLin := 0.5
_nCol := 2.5


//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Contador de linha                                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
li      := 80
limite  := 80

_nQuant := 4 // &(mv_par05)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Faz manualmente porque nao chama a funcao Cabec()                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
@ 0,0 PSAY AvalImp(Limite)


dbSelectArea("SB1")
dbsetorder(1)
SetRegua(LastRec())
      
DBSEEK(xFILIAL()+MV_PAR03, .T.)

  oPr :=ReturnPrtObj()


  While SB1->B1_COD <= MV_PAR04

//     ALERT("PASSEI")
	
	  #IFNDEF WINDOWS
	  If LastKey() == 286    //ALT_A
	     lLEnd := .t.
	  EndIf
	  #ENDIF
	
	If lEnd
		@ PROW()+1,001 PSAY "CANCELADO PELO OPERADOR"
		Exit
	EndIf
	
	IncRegua()
	
	If B1_COD < mv_par03 .Or. B1_COD > mv_par04
		Skip
		Loop
	EndIf
	
        _nEtiq := 0
        _nCont :=0

        while  _nCont <= _nQuant

              MSBAR("EAN8"  , _nLin , _nCol ,ALLTRIM(SB1->B1_COD),oPr,NIL,NIL,NIL,NIL,1,NIL,NIL, .F.)
              
              _nEtiq := _nEtiq + 1
              _nCont := _nCont + 1

              MSBAR("EAN8" , _nLin , _nCol+5 ,ALLTRIM(SB1->B1_COD),oPr,NIL,NIL,NIL,NIL,1,NIL,NIL, .F.)
              _nEtiq := _nEtiq + 1
              _nCont := _nCont + 1

              MSBAR("EAN8"  ,_nLin , _nCol+09 ,ALLTRIM(SB1->B1_COD),oPr,NIL,NIL,NIL,NIL,1,NIL,NIL, .F.)
              _nEtiq := _nEtiq + 1
              _nCont := _nCont + 1

              MSBAR("EAN8"  ,_nLin , _nCol+13 ,ALLTRIM(SB1->B1_COD),oPr,NIL,NIL,NIL,NIL,1,NIL,NIL, .F.)
              _nEtiq := _nEtiq + 1
              _nCont := _nCont + 1

              If _nEtiq >= 4
                _nLin := _nLin + 1
                _nEtiq := 0
              endif
                
*              @ SAY _nLIN, _nCOL    SB1->B1_DESC
*              @ SAY _nLIN, _nCOL+5  SB1->B1_DESC
*              @ SAY _nLIN, _nCOL+9  SB1->B1_DESC
*              @ SAY _nLIN, _nCOL+13 SB1->B1_DESC
              
              If _nEtiq >= 4
                _nLin := _nLin + 2
                _nEtiq := 0
              endif
        End
	
	dbskip()

        If _nLin > 66
           eject()
        Endif

  EndDo

oPr:Print()
Ms_Flush()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Devolve a condicao original do arquivo principal             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
dbSelectArea(cString)
Set Filter To
Set Order To 1                                                                                                   

Return .T.