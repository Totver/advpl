#include "rwmake.ch"        

User Function GatGrades()    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_Retorno,")
_Retorno := ""

If !Empty(M->Z2_TAM1)
   _Retorno := M->Z2_TAM1
EndIF

If !Empty(M->Z2_TAM2)
   _Retorno := Iif(Len(Trim(_Retorno)) > 0,_Retorno+"/","" )+M->Z2_TAM2
EndIF

If !Empty(M->Z2_TAM3)
   _Retorno := Iif(Len(Trim(_Retorno)) > 0,_Retorno+"/","" )+M->Z2_TAM3
EndIF

If !Empty(M->Z2_TAM4)
   _Retorno := Iif(Len(Trim(_Retorno)) > 0,_Retorno+"/","" )+M->Z2_TAM4
EndIF

If !Empty(M->Z2_TAM5)
   _Retorno := Iif(Len(Trim(_Retorno)) > 0,_Retorno+"/","" )+M->Z2_TAM5
EndIF

If !Empty(M->Z2_TAM6)
   _Retorno := Iif(Len(Trim(_Retorno)) > 0,_Retorno+"/","" )+M->Z2_TAM6
EndIF

If !Empty(M->Z2_TAM7)
   _Retorno := Iif(Len(Trim(_Retorno)) > 0,_Retorno+"/","" )+M->Z2_TAM7
EndIF

If !Empty(M->Z2_TAM8)
   _Retorno := Iif(Len(Trim(_Retorno)) > 0,_Retorno+"/","" )+M->Z2_TAM8
EndIF

If !Empty(M->Z2_TAM9)
   _Retorno := Iif(Len(Trim(_Retorno)) > 0,_Retorno+"/","" )+M->Z2_TAM9
EndIF

If !Empty(M->Z2_TAM10)
   _Retorno := Iif(Len(Trim(_Retorno)) > 0,_Retorno+"/","" )+M->Z2_TAM10
EndIF

If !Empty(M->Z2_TAM11)
   _Retorno := Iif(Len(Trim(_Retorno)) > 0,_Retorno+"/","" )+M->Z2_TAM11
EndIF

If !Empty(M->Z2_TAM12)
   _Retorno := Iif(Len(Trim(_Retorno)) > 0,_Retorno+"/","" )+M->Z2_TAM12
EndIF

If !Empty(M->Z2_TAM13)
   _Retorno := Iif(Len(Trim(_Retorno)) > 0,_Retorno+"/","" )+M->Z2_TAM13
EndIF

Return(_Retorno)