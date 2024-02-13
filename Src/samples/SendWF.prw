User Function SendProcWF( cMailTo, cCopyTo, cSubject, cHtmlFile, aParams  )

Local lRet		:= .T.
Local oHtmlLink
Local cDirHTML	:= GetMv("TI_GCVW001",,"\WEB\TGCVW001_TEMPLATES\")
Local nLoop		:= 0
Local cFile		:= cDirHTML+'Envio_'+DtoS(Date())+StrTran(Time(),":","")+".htm"
Local cHTML		:= ''
Local lAut		:= GetMV("MV_RELAUTH")
Local cWFRedir	:= GetSrvProfString( "WFEmailRedirect", "" )
Local cCopyCST	:= GetMv("TI_GCVW002",,"solange.koch@totvs.com.br;lucilene.serrao@totvs.com.br")
Local cLinha	:= ''

cDirHTML := If( Right( Alltrim(cDirHTML), 1 ) <> "\", Alltrim(cDirHTML)+"\", Alltrim(cDirHTML) )

//Cria o HTML para envio por e-mail (link de acesso)
//oHtmlLink := TWFHtml():New( cDirHTML + cHtmlFile )
//cHTML := DecodeUTF8(MemoRead(cDirHTML + cHtmlFile))

FT_FUSE(cDirHTML + cHtmlFile)
FT_FGOTOP()
While 	!FT_FEOF()
		cLinha := FT_FReadLn()
		If	!Empty(cLinha)
			cHTML += DecodeUTF8(AllTrim(cLinha))
		EndIf
FT_FSKIP()
EndDo


For nLoop := 1 To Len(aParams)
/*
	If ChkHtmlVar(oHtmlLink, aParams[nLoop][1])
	//Cabeçalho (envio link)
		oHtmlLink:ValByName( aParams[nLoop][1], aParams[nLoop][2] )
	EndIf
*/
	cHTML := StrTran(cHTML,aParams[nLoop][1], AllTrim(aParams[nLoop][2]))

Next nLoop

//cHTML := oHtmlLink:HTMLCode()	
	
//oHtmlLink:Savefile(cFile)

MemoWrite(cFile,cHTML)

//cHTML := WFLoadFile(cFile)


//Verifica redirecionamento de email
If !Empty(cWFRedir)

	cMailTo := StrTran(cWFRedir,",",";")
	cCopyTo := ' '

EndIf

lRet := U_xSendMail(cMailTo,cSubject,cHTML,,.T.,cCopyTo,,lAut,.T.,cCopyCST)

If File(cFile)
	FErase(cFile)
EndIf

Return lRet