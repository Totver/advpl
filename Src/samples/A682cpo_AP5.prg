#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 24/10/00

User Function A682cpo()        // incluido pelo assistente de conversao do AP5 IDE em 24/10/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("W_CAMPOS,")

W_CAMPOS := AADD(PARAMIXB,{"H6_OP","H6_DATAINI","H6_HORAINI","H6_DATAFIN","H6_HORAFIN","H6_RECURSO","H6_FERRAM","H6_DTAPONT","H6_TEMPO","H6_MOTIVO","H6_OBSERVA","H6_OPERADO"})
// Substituido pelo assistente de conversao do AP5 IDE em 24/10/00 ==> __RETURN(W_CAMPOS)
Return(W_CAMPOS)        // incluido pelo assistente de conversao do AP5 IDE em 24/10/00
