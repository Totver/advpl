#include "TBICONN.CH"
#Include 'totvs.ch'
#INCLUDE "FWMVCDEF.CH" 

User Function TSOMSA010()

Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local nY     := 0
Local lOk    := .T.
PRIVATE lMsErroAuto := .F.

ConOut(Repl("-",80))
ConOut("Teste de Inclusao de 1 tabela de preco")
PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"

dbSelectArea("SB1")
dbSetOrder(1)
If !SB1->(MsSeek(xFilial("SB1")+"001"))
	lOk := .F.
	ConOut("Cadastrar produto: 001")
EndIf
If !SB1->(MsSeek(xFilial("SB1")+"002"))
	lOk := .F.
	ConOut("Cadastrar produto: 002")
EndIf
If lOk
	ConOut("Inicio: "+Time())
	For nY := 1 To 1
		aCabec := {}
		aItens := {}
		aadd(aCabec,{"DA0_DESCRI"   ,"TESTE DE TABELA",Nil})
		//aadd(aCabec,{"DA0_CONDPG"   ,"001",Nil})
		aLinha := {}
		aadd(aLinha,{"DA1_ITEM","0001"})
		aadd(aLinha,{"DA1_CODPRO","001"})
		aadd(aLinha,{"DA1_PRCVEN",10,Nil})			
		aadd(aItens,aLinha)
		aLinha := {}
		aadd(aLinha,{"DA1_ITEM","0002"})
		aadd(aLinha,{"DA1_CODPRO","002"})
		aadd(aLinha,{"DA1_PRCVEN",10,Nil})			
		aadd(aItens,aLinha)
		FWMVCRotAuto("OMSA010","DA0",3,{{"DA0MASTER",aCabec},{"DA1DETAIL",aItens}})
		If !lMsErroAuto
			ConOut("Incluido com sucesso! ")
		Else
			ConOut("Erro na inclusao!")
		EndIf
	Next nY
	ConOut("Fim  : "+Time())

	aCabec := {}
	aItens := {}
	For nY := 1 To 1
		aCabec := {}
		aItens := {}
		aadd(aCabec,{"DA0_CODTAB"   ,DA0->DA0_CODTAB,Nil})
		aadd(aCabec,{"DA0_DESCRI"   ,"TESTE DE TABELA",Nil})
		//aadd(aCabec,{"DA0_CONDPG"   ,"001",Nil})
		aLinha := {}
		aadd(aLinha,{"LINPOS","DA1_ITEM","0001"})
		aadd(aLinha,{"AUTDELETA","N",Nil})
		aadd(aLinha,{"DA1_CODPRO","001"})
		aadd(aLinha,{"DA1_PRCVEN",11,Nil})			
		aadd(aItens,aLinha)
		aLinha := {}
		aadd(aLinha,{"LINPOS","DA1_ITEM","0002"})
		aadd(aLinha,{"AUTDELETA","N",Nil})				
		aadd(aLinha,{"DA1_CODPRO","002"})
		aadd(aLinha,{"DA1_PRCVEN",11,Nil})			
		aadd(aItens,aLinha)
	Next nY
	ConOut(PadC("Teste de alteracao",80))
	ConOut("Inicio: "+Time())

	FWMVCRotAuto("OMSA010","DA0",4,{{"DA0MASTER",aCabec},{"DA1DETAIL",aItens}})
	ConOut("Fim  : "+Time())
	ConOut(Repl("-",80))

	ConOut(PadC("Teste de exclusao",80))
	ConOut("Inicio: "+Time())
	FWMVCRotAuto("OMSA010","DA0",5,{{"DA0MASTER",aCabec},{"DA1DETAIL",aItens}})
	If !lMsErroAuto
		ConOut("Exclusao com sucesso! "+DA0->DA0_CODTAB)
	Else
		ConOut("Erro na exclusao!")
	EndIf
	ConOut("Fim  : "+Time())
	ConOut(Repl("-",80))	
EndIf
RESET ENVIRONMENT
Return(.T.)