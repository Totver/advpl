Function U_AtuSc9

dbSelectArea("SC6")
dbSetOrder(1)

dbSelectArea("SC9")
dbSetOrder(1)
DbGoTop()

While ! Eof()
   DbSelectArea("SC6")
   DbSeek(SC9->C9_FILIAL + SC9->C9_PEDIDO + SC9->C9_ITEM)
   If Empty(SC9->C9_LOCAL) .And. Found()
      dbSelectArea("SC9")
      Reclock("SC9",.F.)
      Replace C9_LOCAL With SC6->C6_LOCAL
      MsUnlock()
	EndIf
	dbSelectArea("SC9")
	dbSkip()
EndDo

Return .T.
