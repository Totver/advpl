#include "rwmake.ch"

User Function TesteEXC()        // incluido pelo assistente de conversao do AP5 IDE em 19/11/99

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_cCAMPO,")

_cCAMPO := Space(30)

//¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
//¦ Criacao da Interface                                                ¦
//¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦

@ 108,33 To 288,310 Dialog TelaAlerta Title OemToAnsi("Tela da Parametros do programa TESTE")
@ 001,04 To 071,135 Title "Parametros"
@ 21,010 Say OemToAnsi("Informe o Texto a ser levado para Planilha EXCEL") Size 160,08
@ 41,010 Get _cCAMPO picture "@!" Object oCampo

@ 75,080 BmpButton Type 1 Action _Inicia()
@ 75,108 BmpButton Type 2 Action Close(TelaAlerta)

Activate Dialog TelaAlerta CENTER

RETURN(_cCAMPO)

Static Function _Inicia()

Close(TelaAlerta)

Return(_cCAMPO)        