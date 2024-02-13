#Include "RwMake.Ch"

User Function IndRegua

Local nIndice := SI2->(IndexOrd())

DbSelectArea("SI2")
cIndex := CriaTrab(Nil, .F.)
IndRegua("SI2", cIndex, "I2_NUM + I2_ORIGEM",, "LEFT(I2_NUM, 1) # '" +;
		      Space(1) + '' + ". And. I2_FILIAL = '" + xFilial() + "'",;
		      "Selecionando Lancamentos...")
nIndex := RetIndex("SI2")
dbSelectArea("SI2")
#IFNDEF TOP
 	 DbSetIndex(cIndex+OrdBagExt())
#ENDIF
DbSetOrder(nIndex+1)
DbGoTop()

@ 200,1 TO 400,600 DIALOG oDlg7 TITLE "Consulta SI2 com IndRegua usando SUBS"

@ 6,5 TO 93,250 BROWSE "SI2" FIELDS { { "I2_NUM"   , "Numero" },;
                                       { "I2_ORIGEM", "Origem" } }
                     
@ 70,258 BUTTON "_Ok" SIZE 40,15 ACTION Close(oDlg7)
ACTIVATE DIALOG oDlg7 CENTERED

RetIndex("SI2")
dbSetOrder(nIndice)
Set Filter to
Ferase(cIndex+OrdBagExt())

Return .T.