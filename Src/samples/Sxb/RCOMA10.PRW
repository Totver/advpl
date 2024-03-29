#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

User Function Rcomc10()        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("_CAREA,_NREC,_CIND,CPERG,AITEMS,CCOMBO")
SetPrvt("BCOMUM,BCFIL,BCGRP,BCSGRP,BCCLASSE,BCPRODUTO")
SetPrvt("CNOMEDBF,CNOMECDX,CTITULO,_ACPOS,_NNIVEL,_SALIAS")
SetPrvt("AREGS,I,J,")

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � RCOMRC10 � Autor � GILBERTO A.DE OLIVEIRA� Data � 11.01.00 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Consulta em tela.                                          낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿌rgumentos�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Especifico Casa das Cuecas                                 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞olicitan.�                                                            낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/

_cArea     := Alias()
_nRec      := Recno()
_cInd      := IndexOrd()
cPerg      :="RCMC10"
_ValidPerg()

Pergunte(cPerg)

@ 0,0 TO 250,400 DIALOG oDlg1 TITLE "CONSULTA EM TELA"
@ 20,020 TO 060,170 TITLE "Verifique os Parametros"
@ 35,025 BMPBUTTON TYPE 5 ACTION Pergunte("RCMC10")
@ 35,075 BMPBUTTON TYPE 1 ACTION ConsultaBasica()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 35,075 BMPBUTTON TYPE 1 ACTION Execute(ConsultaBasica)
@ 35,125 BMPBUTTON TYPE 2 ACTION Close(oDlg1)
@ 75,020 TO 115,170
@ 080,025 SAY "Esta rotina tem por consultar dados de estoque, vendas"
@ 090,025 SAY "e pedidos das mais diversas filiais ou de modo geral, "
@ 100,025 SAY "fornecendo totais de por grupo, sub-grupo ou classe.  "
ACTIVATE DIALOG oDlg1 CENTER

If File(alltrim(cNomeDBF)+".DBF")
   TRAB->( dbClearInd() )
   TRAB->( dbCloseArea() )
   FErase( ALLTRIM(cNomeDBF)+".DBF" )
   FErase( ALLTRIM(cNomeCDX)+".CDX" )

Endif

DbSelectArea(_cArea)
DbSetOrder(_cInd)
DbGoto(_nRec)

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> __Return( .T. )
Return( .T. )        // incluido pelo assistente de conversao do AP5 IDE em 08/05/00

/*
旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
� CONSULTA BASICA (INICIAL)                                                 �
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION ConsultaBasica
Static FUNCTION ConsultaBasica()

aItems:={"Grupo","Sub-Grupo","Classe","Fornecedor","Produtos"}
cCombo:="Grupo"


bComum:={|| ZD_CODFIL >= MV_PAR03.And.SZD->ZD_CODFIL <= MV_PAR04 }

bCFil :={||!Empty(SZD->ZD_CODFIL).And.;
            Empty(SZD->ZD_GRPMAR+SZD->ZD_SGRPMAR+;
                  SZD->ZD_CLASSE+SZD->ZD_CODFOR)   }

bCGrp :={|| Empty(SZD->ZD_CODFIL).And.;
           !Empty(SZD->ZD_GRPMAR).And.;
            Empty(SZD->ZD_SGRPMAR)      }

bCSGrp:={||  (Empty(ZD_CODFIL).And.!Empty(ZD_SGRPMAR).And.Empty(ZD_CLASSE));
             .Or.(Empty(ZD_CODFIL).And.!Empty(ZD_GRPMAR).And.Empty(ZD_SGRPMAR);
                  .And.Empty(ZD_CLASSE) ) }

bCClasse :={|| Empty(ZD_CODFIL).AND.;
              !EMPTY(ZD_GRPMAR).AND.;
              !EMPTY(ZD_SGRPMAR).AND.;
              !EMPTY(ZD_CLASSE) }

bCProduto:={|| Empty(ZD_CODFIL).AND.;
              !EMPTY(ZD_GRPMAR).AND.;
              !EMPTY(ZD_SGRPMAR).AND.;
              !EMPTY(ZD_CLASSE).AND.;
              !EMPTY(ZD_CODPROD) }

cNomeDbf:= CriaTrab(NIL, .F. )
cNomeCdx:= CriaTrab(NIL, .F. )
cTitulo := ""
_aCpos  := {}
_nNivel := 0

DbSelectArea("SZD")

Chamada()

Return
/*
�袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴敲
� Monta BROWSE de Consulta conforme matrizes pre-estabelecidas...           �
훤袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
*/
// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION MontaTela
Static FUNCTION MontaTela()

DbUseArea(.T.,,cNomeDbf,"TRAB",.F.)
DbGoTop()

@ 020,05 To 400,550 Dialog oDlgFil Title OemToAnsi(cTitulo)
@ 005,05 To 030,270

@ 040,005 TO 180,275 BROWSE "TRAB" FIELDS _aCpos
@ 013,015 COMBOBOX cCombo ITEMS aItems SIZE 50,60

@ 012,175 BUTTON "_Confirma" SIZE 30,15 ACTION CHAMADA()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> @ 012,175 BUTTON "_Confirma" SIZE 30,15 ACTION Execute(CHAMADA)
@ 012,220 BUTTON "_Sair"     SIZE 30,15 ACTION Close(oDlgFil)

Activate DIALOG oDlgFil

LIMPA()
DbSelectArea("SZD")

//@ 012,008 BUTTON "_Grupo"      SIZE 30,15 ACTION CHAMAGRUPO()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> //@ 012,008 BUTTON "_Grupo"      SIZE 30,15 ACTION Execute(CHAMAGRUPO)
//@ 012,048 BUTTON "_Sub-Grupo"  SIZE 30,15 ACTION CHAMASGRUPO()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> //@ 012,048 BUTTON "_Sub-Grupo"  SIZE 30,15 ACTION Execute(CHAMASGRUPO)
//@ 012,085 BUTTON "_Classe"     SIZE 30,15 ACTION CHAMACLASSE()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> //@ 012,085 BUTTON "_Classe"     SIZE 30,15 ACTION Execute(CHAMACLASSE)
//@ 012,135 BUTTON "_Fornec."    SIZE 30,15 ACTION CHAMAFORN()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> //@ 012,135 BUTTON "_Fornec."    SIZE 30,15 ACTION Execute(CHAMAFORN)
//@ 012,175 BUTTON "_Produtos"   SIZE 30,15 ACTION CHAMAPROD()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> //@ 012,175 BUTTON "_Produtos"   SIZE 30,15 ACTION Execute(CHAMAPROD)
//@ 012,220 BUTTON "_Fechar"     SIZE 30,15 ACTION Close(oDlgFil)


Return

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION CHAMADA
Static FUNCTION CHAMADA()

LIMPA()
cNomeDbf:= CriaTrab(NIL, .F. )
cNomeCdx:= CriaTrab(NIL, .F. )
DbSelectArea( "SZD" )
DbGotop()

DO CASE
   CASE aItems[1] == cCombo
        CHAMAGRUPO()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>         EXECUTE(CHAMAGRUPO)
   CASE aItems[2] == cCombo
        CHAMASGRUPO()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>         EXECUTE(CHAMASGRUPO)
   CASE aItems[3] == cCombo
        CHAMACLASSE()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>         EXECUTE(CHAMACLASSE)
   CASE aItems[4] == cCombo
        CHAMAFORN()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>         EXECUTE(CHAMAFORN)
   CASE aItems[5] == cCombo
        CHAMAPROD()// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==>         EXECUTE(CHAMAPROD)
   OTHERWISE
        Return
ENDCASE

MONTATELA()

Return

/*
�袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴敲
� Faz chamada a nova consulta a partir da consulta atual...                 �
훤袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
*/

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION CHAMAFILIAL
Static FUNCTION CHAMAFILIAL()

         SORT To &cNomeDbf On ZD_CODFIL For Eval(bComum).And.Eval(bCFil)
         cTitulo := "Consulta pelo Total de Cada Filial"
         _aCpos:= {}
         AADD(_aCpos,{ "ZD_CODFIL" ,"FILIAL"  })
         AADD(_aCpos,{ "ZD_ESTOQUE","Estoque"    })
         AADD(_aCpos,{ "ZD_VENDAS" ,"Vendas"     })
         AADD(_aCpos,{ "ZD_PEDABER","Ped.Abertos"})

Return

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION CHAMAGRUPO
Static FUNCTION CHAMAGRUPO()

         SORT To &cNomeDbf On ZD_GRPMAR For Eval(bComum).And.Eval(bCGrp)
         cTitulo := "Consulta pelo Total Geral (GRUPO)"
         _aCpos:= {}
         AADD(_aCpos,{ "ZD_DESGRP" ,"Grupo"  })
         AADD(_aCpos,{ "ZD_ESTOQUE","Estoque"    })
         AADD(_aCpos,{ "ZD_VENDAS" ,"Vendas"     })
         AADD(_aCpos,{ "ZD_PEDABER","Ped.Abertos"})

Return

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION CHAMASGRUPO
Static FUNCTION CHAMASGRUPO()

         SORT To &cNomeDbf On (ZD_GrpMar+ZD_GRPMAR) For Eval(bComum).And.Eval(bCSGrp)
         cTitulo := "Consulta pelo Total Geral (SUB-GRUPO)"
         _aCpos:= {}
         AADD(_aCpos,{ "ZD_DESGRP" ,"Grupo"      })
         AADD(_aCpos,{ "ZD_DESSGRP","Sub-Grupo"  })
         AADD(_aCpos,{ "ZD_ESTOQUE","Estoque"    })
         AADD(_aCpos,{ "ZD_VENDAS" ,"Vendas"     })
         AADD(_aCpos,{ "ZD_PEDABER","Ped.Abertos"})

Return

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION CHAMACLASSE
Static FUNCTION CHAMACLASSE()

         SORT To &cNomeDbf On ZD_GrpMar+ZD_SGRPMAR+ZD_CLASSE For Eval(bComum).And.Eval(bCClasse)
         cTitulo := "Consulta pelo Total Geral (CLASSE)"
         _aCpos:= {}
         AADD(_aCpos,{ "ZD_DESGRP" ,"Grupo"      })
         AADD(_aCpos,{ "ZD_DESSGRP","Sub-Grupo"  })
         AADD(_aCpos,{ "ZD_DESCLA" ,"Classe"     })
         AADD(_aCpos,{ "ZD_ESTOQUE","Estoque"    })
         AADD(_aCpos,{ "ZD_VENDAS" ,"Vendas"     })
         AADD(_aCpos,{ "ZD_PEDABER","Ped.Abertos"})

Return

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION CHAMAFORN
Static FUNCTION CHAMAFORN()

         Limpa()
         cNomeDbf:= CriaTrab(NIL, .F. )
         cNomeCdx:= CriaTrab(NIL, .F. )
         DbSelectArea( "SZD" )
         DbGotop()
         SORT To &cNomeDbf On ZD_GrpMar+ZD_CODFOR For Eval(bComum).And.Eval(bCGrp)
         cTitulo := "Consulta pelo Total Geral (SUB-GRUPO)"

         _aCpos:= {}
         AADD(_aCpos,{ "ZD_DESGRP" ,"Grupo"      })
         AADD(_aCpos,{ "ZD_DESSGRP","Sub-Grupo"  })
         AADD(_aCpos,{ "ZD_DESCLAS","Classe"     })
         AADD(_aCpos,{ "ZD_DESFOR" ,"Fornecedor" })
         AADD(_aCpos,{ "ZD_ESTOQUE","Estoque"    })
         AADD(_aCpos,{ "ZD_VENDAS" ,"Vendas"     })
         AADD(_aCpos,{ "ZD_PEDABER","Ped.Abertos"})

         MontaTela()

Return

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION CHAMAPROD
Static FUNCTION CHAMAPROD()

         Limpa()
         cNomeDbf:= CriaTrab(NIL, .F. )
         cNomeCdx:= CriaTrab(NIL, .F. )
         DbSelectArea( "SZD" )
         DbGotop()
         SORT To &cNomeDbf On ZD_GrpMar+ZD_SGRPMAR+ZD_CLASSE+ZD_CODPROD For Eval(bComum).And.Eval(bCGrp)
         cTitulo := "Consulta pelo Total Geral (PRODUTOS)"

         _aCpos:= {}
         AADD(_aCpos,{ "ZD_DESGRP" ,"Grupo"      })
         AADD(_aCpos,{ "ZD_DESSGRP","Sub-Grupo"  })
         AADD(_aCpos,{ "ZD_DESCLAS","Classe"     })
         AADD(_aCpos,{ "ZD_DESPRO" ,"Produto"    })
         AADD(_aCpos,{ "ZD_ESTOQUE","Estoque"    })
         AADD(_aCpos,{ "ZD_VENDAS" ,"Vendas"     })
         AADD(_aCpos,{ "ZD_PEDABER","Ped.Abertos"})

         MontaTela()

Return

// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> FUNCTION Limpa
Static FUNCTION Limpa()

     If FILE(ALLTRIM(cNomeDBF)+".DBF")

         TRAB->( DbClearInd() )
         TRAB->( DbCloseArea() )
         Ferase(Alltrim(cNomeDBF)+".DBF")
         Ferase(Alltrim(cNomeDBF)+".CDX")
         CLOSE(oDlgFil)

     Endif


Return

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿣ALIDPERG � Autor �  Luiz Carlos Vieira   � Data � 16/07/97 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Verifica as perguntas inclu죒do-as caso n꼘 existam        낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Espec죉ico para clientes Microsiga                         낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
mv_par05  : Tipo de Classificacao,  IDENTADA, GRAU, GERAL
mv_par06  : Nivel da Classificacao,    GRUPO, SUB-GRUPO
*/


// Substituido pelo assistente de conversao do AP5 IDE em 08/05/00 ==> Function _ValidPerg
Static Function _ValidPerg()
_sAlias := Alias()

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)
aRegs :={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

AADD(aRegs,{cPerg,"01","Apurar Periodo de  ?","mv_ch1","D",08,0,1,"G","","mv_par01","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","              ate  ?","mv_ch2","D",08,0,1,"G","","mv_par02","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Filiais de         ?","mv_ch3","C",02,0,0,"G","","mv_par03","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Filiais ate        ?","mv_ch4","C",02,0,0,"G","","mv_par04","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"05","Tipo Classificacao ?","mv_ch5","N",01,0,1,"C","","mv_par05","Identada","","","Grau"    ,"","","Total "   ,"","","","","","","",""})
AADD(aRegs,{cPerg,"06","Nivel Classificacao?","mv_ch6","N",01,0,1,"C","","mv_par06","Grupo"   ,"","","SubGrupo","","","Classe","","","Fornecedor","","","Filiais","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

dbSelectArea(_sAlias)

Return





/*
NECESSARIO PARA CONSULTA EM TELA :

   1 - QUANTIDADE EM ESTOQUE (SALDO)
   2 - PEDIDOS PENDENTES ACUMULADOS
   3 - VENDAS NO PERIODO

   PERIODO :
   Selecionado pelo usuario

   COMO CONSEGUIR OS DADOS :

   1 ) Atraves da rotina cSaldo1, que ira levantar o saldo no periodo
       parametrizado.
   2 ) Leitura do SC7, no periodo parametrizado.
   3 ) Leitura do SD2, no periodo parametrizado.


   TOTALIZAR POR :

   A - Filial
   B - Grupo
   C - SubGrupo
   D - Classe
   E - Fornecedor
   F - Produto

   ARQUIVO DE TRABALHO COM :

   Todos os campos totalizadores + Pedidos Pendentes, Estoque e Vendas.

   Observacoes :
   Ler arquivo de trabalho conforme solicitado pelo usuario, ou seja,
   conforme as filiais indicadas ou total geral.
   Um unico arquivo com todos os totalizadores, da seguinte forma:

   Total Geral de Todas as Filiais :
     Tera os campos Filial, Grupo, SubGrupo, Classe, Fornecedores
     e Produtos em Branco e contara apenas com os campos de valores que
     estarao acumulados para todas as filiais.
   Total Geral por Filial (Filial por Filial) :
     Campo de Filial preenchido e o restante, foram os campos de valores,
     estara em branco.
   Total Geral por Grupo  (Todas as Filiais)   :
     Campo de Filial em Branco, Campo de Grupo preenchido e valores.
   Total Geral por SubGrupo (Todas as Filiais) :
     Campo de Filial em Branco, Campo de Grupo e SubGrupo preenchidos e
     valores

PROBLEMAS(?)

- CASO SEJA NECESSARIO GRAVAR O MES A QUE SE REFERE, ISSO IMPLICA EM
SE DISSER QUE CADA UM DOS PRODUTOS TERA PELO MENOS 12 OCORRENCIAS.
ISSO NAO TORNARIA INVIAVEL ? O ARQUIVO DE PRODUTOS POR SI S�
POSSUI MUITOS REGISTROS, O SZD (ARQUIVO DE TRABALHO) SERIA 12 VEZES
O ARQUIVO DE PRODUTOS.
*/


