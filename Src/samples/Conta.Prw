Function U_Conta

dbSelectArea("SA1")
cKeySA1 := IndexKey(1)
cFilSA1 := ""
cArqSa1 := CriaTrab(NIL,.F.)
IndRegua("SA1", cArqSA1,cKeySA1,,cFilSA1, OemToAnsi("Selecionando Registros...") ) 
nIndex := RetIndex("SA1")
dbSelectArea("SD1")
// #IFNDEF TOP
	dbSetIndex(cArqSA1+OrdBagExt())
// #ENDIF
DbSetOrder(nIndex+1)

DbSelectArea("SZJ")
cPDbU   := ("ZJ_DEBM"+cPer)
cPCrU   := ("ZJ_CRDM"+cPer)
cSIniU  := ("ZJ_SALANT")
 
cSZJCdx := CriaTrab(,.f.)
cSZJChv := "ZJ_CCUSTO+ZJ_CODINV"
If Mv_par04 == 1
  // Somente movimento do mes
  cSZJFil := "(ZJ_CCUSTO == cCusto .and. ZJ_CLASSE == 'S') .or."
  cSZJFil := cSZJFil + "(ZJ_CCUSTO == cCusto .and. ZJ_CLASSE == 'A' .and. "
  cSZJFil := cSZJFil + &cPDbU + " <> 0 .Or. " + &cPCrU + " <> 0)"
ElseIf Mv_par04 == 2
  // Caso atualiza saldo de abertura
  cSZJFil := "(ZJ_CCUSTO == cCusto .and. ZJ_CLASSE == 'S') .or."
  cSZJFil := cSZJFil + "(ZJ_CCUSTO == cCusto .and. ZJ_CLASSE == 'A' .and. "
  cSZJFil := cSZJFil + &cPDbU + " <> 0 .or. " + &cPCrU + " <> 0 .Or. " +;
  								&cSIniU + " <> 0)"
EndIf
 
Return(A1_COD)