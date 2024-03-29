#include "rwmake.ch"

User Function RepPed()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("NOPCX,AHEADER,ACOLS,NUSADO,J,LFIRST")
SetPrvt("NB2_QATU,NB2_RESERVA,NC9_QTDLIB,CPEDIDO,CNOME,COBS")
SetPrvt("CTITULO,AC,AR,ACGD,CLINHAOK,CTUDOOK")
SetPrvt("LRETMOD2,LRETORNO,")

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튡rograma  쿝EPARTE_AP5튍utor  쿘icrosiga           � Data �  07/17/00   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒esc.     �                                                            볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � AP5                                                        볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Opcao de acesso para o Modelo 2                              �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza
nOpcx:=6

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Montando aHeader                                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

aHeader := {}
AADD(aHeader,{'Cod. Produto' , 'C6_PRODUTO', '@!'                , 15, 0, 'ExistCpo("SB1").or.vazio()'   , '�','C','SC6' })
AADD(aHeader,{'Ped. Cliente' , 'C6_PEDCLI' , '@!'                , 9 , 0, 'AllWaysTrue()'                , '�','C','SC6' })
AADD(aHeader,{'Pedido'       , 'C6_QTDVEN' , '@E 999999.99'      , 9 , 2, 'AllWaysTrue()'                , '�','N','SC6' })
AADD(aHeader,{'Atendido'     , 'C9_QTDLIB' , '@E 999999.99'      , 9 , 2, 'AllWaysTrue()'                , '�','N','SC9' })
AADD(aHeader,{'Pendente'     , 'C6_QTDLIB' , '@E 999999.99'      , 9 , 2, 'AllWaysTrue()'                , '�','N','SC6' })
AADD(aHeader,{'Estoque'      , 'B2_QATU'   , '@E 999,999,999.99' , 12, 2, 'AllWaysTrue()'                , '�','N','SB2' })
AADD(aHeader,{'Reparte'      , 'B2_RESERVA', '@E 999999.99'      , 9 , 2, 'CalcReparte()'                , '�','N','SB2' })

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Cria aCOLS de acordo com Tamanho do Arquivo enviado  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
aCols := {}
nUsado := 7
AADD(aCols,Array(nUsado+1))
nUsado := 0
For j:=1 To 7
       nUsado := nUsado + 1
       IF aHeader[j][8] == "C"
              aCols[1][nUsado] := Space(aHeader[j][4])
       Else
              aCols[1][nUsado] := 0
       EndIf
Next j
aCols[1][nUsado+1] := .F.

lFirst := .T.

dbSelectArea("SC6")
dbSetOrder(1)
If dbSeek(xFilial("SC6")+SC5->C5_NUM)
	Do While !Eof() .and. SC6->C6_NUM == SC5->C5_NUM
		nB2_QATU    := 0
		nB2_RESERVA := 0
		nC9_QTDLIB  := 0

		dbSelectArea("SB2")
		dbSetOrder(1)
      If dbSeek(xFilial("SB2")+SC6->C6_PRODUTO+SC6->C6_LOCAL)
        	nB2_QATU    := SB2->B2_QATU
        	nB2_RESERVA := SB2->B2_RESERVA
      Endif
                
      dbSelectArea("SC9")
      dbSetOrder(1)
      If dbSeek(xFilial("SC9"+SC6->C6_NUM))
        	Do While !Eof() .And. SC9->C9_PEDIDO == SC6->C6_NUM
        		If SC9->C9_PRODUTO == SC6->C6_PRODUTO
        			nC9_QTDLIB := nC9_QTDLIB + SC9->C9_QTDLIB
        		Endif
        		dbSkip()
        	EndDo
  		EndIf
        
      If lFirst
      	aCols[1][1] := SC6->C6_PRODUTO
        	aCols[1][2] := SC6->C6_PEDCLI
        	aCols[1][3] := SC6->C6_QTDVEN
        	aCols[1][4] := nC9_QTDLIB
        	aCols[1][5] := SC6->C6_QTDVEN - nC9_QTDLIB
        	aCols[1][6] := nB2_QATU - nB2_RESERVA
        	aCols[1][7] := 0
        	lFirst := .F.
      Else
        	aAdd( aCols, { SC6->C6_PRODUTO, SC6->C6_PEDCLI, SC6->QTDVEN, nC9_QTDLIB, ;
        	               SC6->C6_QTDVEN - nC9_QTDLIB, nB2_QATU - nB2_RESERVA, 0 } )
      Endif
		dbSelectArea("SC6")
		dbSkip()
	EndDo
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis do Cabecalho do Modelo 2                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
cPedido  := SC5->C5_NUM
If SC5->C5_TIPO $ "N,C,I,P"
	cNome := Posicione("SA1",1,xFilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJA,"SA1->A1_NOME")
Else
	cNome := Posicione("SA2",1,xFilial("SA2")+SC5->C5_CLIENTE+SC5->C5_LOJA,"SA2->A2_NOME")
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis do Rodape do Modelo 2                              �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
cObs := SC5->C5_MENREP

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Titulo da Janela                                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
cTitulo := "Manual de Faturamento - Produtos do Pedido"

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Array com descricao dos campos do Cabecalho do Modelo 2      �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.
aC:={}
AADD(aC,{"cPedido"   ,{25,10}  ,"Pedido"     ,"@!",,,.F.})
AADD(aC,{"cNome"     ,{25,150} ,"Nome"       ,"@!",,,.F.})

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Array com descricao dos campos do Rodape do Modelo 2         �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.
aR:={}
AADD(aR,{"cObs"      ,{120,10},"Observacoes"    ,"@!",,,.F.})

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Array com coordenadas da GetDados no modelo2                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
aCGD:={44,5,118,315}

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Validacoes na GetDados da Modelo 2                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
cLinhaOk:= "AllwaysTrue()"
cTudoOk := "AllWaysTrue()"

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Chamada da Modelo2                                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
// lRetMod2 = .t. se confirmou 
// lRetMod2 = .f. se cancelou

lRetMod2 := Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)
If lRetMod2
	MsgStop("Confirma Operacao")
Else
   	MsgStop("Cancela Operacao")
Endif
Return


/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튡rograma  쿝EPARTE_AP5튍utor  쿘icrosiga           � Data �  08/14/00   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒esc.     �                                                            볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � AP5                                                        볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/
// Substituido pelo assistente de conversao do AP5 IDE em 14/08/00 ==> Function CalcReparte()
Static Function CalcReparte()

lRetorno := .T.

If aCols[n][3] <= aCols[n][7]
	aCols[n][4] := aCols[n][4] + aCols[n][7]
	aCols[n][5] := aCols[n][5] - aCols[n][4]
Else
	MsgStop("Valor Inv�lido")
	lRetorno := .F.
Endif

// Substituido pelo assistente de conversao do AP5 IDE em 14/08/00 ==> __return(lRetorno)
Return(lRetorno)        // incluido pelo assistente de conversao do AP5 IDE em 14/08/00
