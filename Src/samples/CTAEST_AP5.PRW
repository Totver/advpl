#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 16/10/00

User Function CtaEst()        // incluido pelo assistente de conversao do AP5 IDE em 16/10/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CDPROD,_CONTA,")

_CDPROD := SD1->D1_COD

_CONTA:= SPACE(20)

IF (SUBST(_CDPROD,1,2)$"01 02")
   _CONTA := "1124010"
ENDIF

IF (SUBST(_CDPROD,1,2)$"03 04")
   _CONTA := "1124036"
ENDIF

IF (SUBST(_CDPROD,1,2)=="05")
   _CONTA := "1124044"
ENDIF

IF (SUBST(_CDPROD,1,2)=="07")
   _CONTA := "1124028"
ENDIF

IF (SUBST(_CDPROD,1,2)=="09")
   _CONTA := "1124052"
ENDIF

// Substituido pelo assistente de conversao do AP5 IDE em 16/10/00 ==> __RETURN(_CONTA)

Return(_CONTA)        // incluido pelo assistente de conversao do AP5 IDE em 16/10/00