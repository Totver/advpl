#INCLUDE "protheus.ch"

User Function TRGA010()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : ManutenÁ„o do cadastro de consultas personalizadas
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local cVldAlt  := "U_TRG010Vl()"  //Adicionado por Eduardo em 02/02/11
Local cVldExc  := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.
Local aRotAdic := {}

Private cString := "PQ1"

dbSelectArea("PQ1")
dbSetOrder(1)

Aadd(aRotAdic, { "Sub-Formularios"	, "U_TRG060Rt"	, 0 , 3 } )
Aadd(aRotAdic, { "Rotinas"			, "U_TRG010Rt"	, 0 , 3 } )
Aadd(aRotAdic, { "Campos"			, U_T030_Mnu(), 0 , 4 } )
Aadd(aRotAdic, { "Parametros"		, U_T020_Mnu(), 0 , 4 } )
Aadd(aRotAdic, { "Indices"			, U_T040_Mnu(), 0 , 4 } )
Aadd(aRotAdic, { "Exportar"			, "U_TRG10Exp()", 0 , 3 } )
Aadd(aRotAdic, { "Importar"			, "U_TRG10Imp()", 0 , 3 } )

AxCadastro(cString,"Cadastro de Consultas Personalizadas",cVldExc,cVldAlt,aRotAdic)

Return  

User Function TRG010Rt()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : ManutenÁ„o das rotinas vinculadas a uma consulta
<Data> : 01/09/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local aBkp 	 := { cOkFunc, cDelFunc, aParam, xAuto, aNewBtn, AClone(aRotina) }
Local bPre   := {|| .T.}
Local bOk    := {|| .T.}
Local bTTS   := {|| .T.}
Local bNoTTS := {|| .T.}

Private cCadastro := "Rotinas - Consulta [" + AllTrim(PQ1->PQ1_NOME) + "]"
Private aRotina   := { 	{ "Pesquisar","AxPesqui", 0, 1},;
						{ "Visualizar","AxCadVis", 0, 2},;
						{ "Incluir","AxInclui", 0, 3},;
						{ "Alterar","AxCadAlt", 0, 4},;
						{ "Excluir","AxCadDel", 0, 5} }
Private cOkFunc  := Nil
Private cDelFunc := Nil
Private aParam   := {bPre,bOK,bTTS,bNoTTS}
Private xAuto    := Nil
Private aNewBtn  := Nil

DbSelectArea("PQ6")
Set Filter To PQ6_FILIAL == xFilial() .And. PQ6_ID == PQ1->PQ1_ID
DbGoTop()

mBrowse( 6, 1,22,75,"PQ6")

DbSelectArea("PQ6")
Set Filter To

cOkFunc  := aBkp[1]
cDelFunc := aBkp[2]

aParam := Nil
If ValType(aBkp[3]) = "A"
   aParam := AClone(aBkp[3])
EndIf

xAuto := Nil
If ValType(aBkp[4]) = "A"
   xAuto := AClone(aBkp[4])
EndIf

aNewBtn := Nil
If ValType(aBkp[5]) = "A"
   aNewBtn := AClone(aBkp[5])
EndIf

aRotina := Nil
If ValType(aBkp[6]) = "A"
   aRotina := AClone(aBkp[6])
EndIf

U_TRGZPQ6()

Return

User Function TRG010Vl()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : ValidaÁ„o do cadastro de consultas personalizadas
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Return .T.

User Function XColHeader(aCols,aHeader,xAlias,lRecno,cNaoMostra,xOpc,xFiltro,xOrdem,cCpos,lProc)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : ValidaÁ„o do cadastro de consultas personalizadas
<Data> : 02/08/2013
<Parametros> : aCols   - Passar como referencia (@aCols)                  
               aHeader - Passar como referencia (@aCols)                 
               xAlias  - Alias do arquivo a ser montado                  
               lRecno  - Se habilita coluna do registro do arquivo       
               cNaoMostra - Campos a nao serem mostrados no aHeader/Acols
               xOpc    - 3-Inclusao/4-Alteracao                          
               xFiltro - Filtro em SQL                                   
               cCPOs - Campos a serem exibidos, se informando o parametro
                       cNaoMostra e' ignorado! 						     
               lProc - Se utiliza o incproc no while                    
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local aOldArea := GetArea()
Local aOldSX3 := SX3->(GetArea())
Local cNewAlias := GetNextAlias()
Local cFields := ""
Local nUsado := 0
Local cCpoFilial := ""
Local nI		 := 0
Local n1		 := 0
Local nH		 := 0

Default lRecno := .F.
Default cNaoMostra := ""
Default xFiltro := ""
Default xOrdem := "" 
Default cCPOs := ""
Default lProc := .F.

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek(xAlias)
While !Eof() .and. SX3->X3_ARQUIVO == xAlias

	if At("_FILIAL",X3_CAMPO)>0  
		cCpoFilial := X3_CAMPO
	endif                                       

	lCampo := .F.
		
	if Empty(cCPOs)
		lCampo := (X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL .and. !(ALLTRIM(SX3->X3_CAMPO) $ cNaoMostra))
	else		
		lCampo := (ALLTRIM(SX3->X3_CAMPO) $ cCPOs)
	endif	
	
	If lCampo
	
	        nUsado++
	        Aadd(aHeader,{Trim(X3Titulo()),;	//01
	                      SX3->X3_CAMPO,;		//02
	                      SX3->X3_PICTURE,;		//03
	                      SX3->X3_TAMANHO,;		//04
	                      SX3->X3_DECIMAL,;		//05
	                      SX3->X3_VALID,;		//06
	                      SX3->X3_USADO,;		//07
	                      SX3->X3_TIPO,;		//08
	        			  SX3->X3_F3,;			//09
						  SX3->X3_CONTEXT,;		//10
						  SX3->X3_CBOX,;		//11
						  SX3->X3_RELACAO})		//12
			                  
	EndIf
	DbSkip()
End

if xOpc == 3
	Aadd(aCols,Array(nUsado+1))	
	For nI := 1 To nUsado
    	aCols[1][nI] := CriaVar(aHeader[nI][2])
	Next
	aCols[1][nUsado+1] := .F.
else         
  
	For n1 := 1 to Len(aHeader)  
		if aHeader[n1,10] <> "V" 
			if Empty(cFields)
				cFields := Alltrim(aHeader[n1,2])
			else
				cFields += ","+Alltrim(aHeader[n1,2])
			endif	
		endif
	Next	                
	
	if lRecno
		cFields += ", R_E_C_N_O_ AS REG "
		nUsado += 1
	else
		cFields += " "
	endif	
	    
	cQuery := "Select "+ cFields + " FROM " +RETSQLNAME(xAlias) + " WHERE "
	if !Empty(cCpoFilial)	
		cQuery += cCPoFilial+"='"+xFilial(xAlias)+"' AND "
	endif	  
	if !Empty(xFiltro)
		cQuery += xFiltro
	endif
	cQuery += " AND D_E_L_E_T_=''"			                        
	if !Empty(xOrdem)
		cQuery += " ORDER BY "+xOrdem
	endif		
	
	dbUseArea(.T., "TOPCONN", TCGenQry(,,ChangeQuery(cQuery)), cNewAlias, .F., .T.)	
	For nH := 1 to Len(aHeader)
		If aHeader[nH,8] $ "D,L,N"
			TcSetField(cNewAlias, aHeader[nH,2], aHeader[nH,8], aHeader[nH,4], aHeader[nH,5])
		EndIf
	Next nH			

	
	if !(cNewAlias)->(EOF())
	
		if lProc             
		    nRegProc := 0
			nCount := 0
			(cNewAlias)->(DbEval({|| nCount++},,))
		    ProcRegua(nCount)
		    cCount := "/"+Alltrim(Str(nCount))
			(cNewAlias)->(DBGOTOP())		    
	    endif
		
		While !(cNewAlias)->(EOF())
		
			if lProc     
				nRegProc++
				IncProc("Registros processados: "+Alltrim(Str(nRegProc))+cCount)
			endif                                                               
			
			Aadd(aCols,Array(nUsado+1))	
			nLn := Len(aCols)
			aCols[nLn][nUsado+1] := .F.
			
			if lRecno                   
				aCols[nLn][nUsado] := (cNewAlias)->REG
			endif	
			
			For nI := 1 To Len(aHeader)
				if aHeader[nI,10] <> "V" .and. aHeader[nI,8] <> "M"
					aCols[nLn,nI] := (cNewAlias)->&(aHeader[nI,2])
				endif                    
				if aHeader[nI,8] == "M"
					(xAlias)->(DBGOTO((cNewAlias)->REG))
					aCols[nLn,nI] := (xAlias)->&(aHeader[nI,2])
				endif
			Next nI	  
			
			(cNewAlias)->(DbSkip())
		End	
	else     
	                  
		if lRecno
			nUsado := nUsado - 1
		endif	
		
		Aadd(aCols,Array(nUsado+1))	
		For nI := 1 To nUsado
    		aCols[1][nI] := CriaVar(aHeader[nI][2])
		Next
		aCols[1][nUsado+1] := .F.
	endif
	(cNewAlias)->(DBCLOSEAREA())	
endif          

RestArea(aOldSX3)
RestArea(aOldArea)

Return

Static Function CriaVar( cCampo, lInitPad, cLado, lCriaPub )

Local aArea     := GetArea()
Local aAreaSX3  := SX3->(GetArea())
Local cTipo
Local nTamanho
Local xConteudo
Local lInicializador

DEFAULT lCriaPub := .T.
DEFAULT cLado    := "L"
DEFAULT lInitPad := .T.

If At( ">", cCampo ) != 0
	cCampo := AllTrim(SubStr( cCampo, 1+At( ">", cCampo) , 10 ) )
EndIf
cCampo := PadR(cCampo,10)
cTipo     := GetSx3Cache(cCampo,"X3_TIPO")
nTamanho  := GetSx3Cache(cCampo,"X3_TAMANHO")

If cTipo == Nil
	Help(" ", 1, "NOCPOSX3",,"Field -> "+cCampo,5,0)
	RestArea(aAreaSX3)
	RestArea(aArea)
	Return("")
EndIf

Do Case
	Case cTipo == "C"
		xConteudo := Space( nTamanho )
	Case cTipo == "N"
		xConteudo :=	0
	Case cTipo == "D"
		xConteudo := CtoD("  /  /  ")
	Case cTipo == "L"
		xConteudo := .F.
	Case cTipo == "M"
		xConteudo := ""
EndCase
If lInitPad
	lInicializador := ExistIni( cCampo , .F.)
	If lInicializador
		xConteudo := InitPad( GetSx3Cache(cCampo,"X3_RELACAO") , cCampo )
		If cTipo == "C"
			xConteudo += Space( nTamanho - Len ( xConteudo ) )
			Do Case
				Case cLado == "L"
					xConteudo := PadL( xConteudo, nTamanho )
				Case cLado == "C"
					xConteudo := PadC( xConteudo, nTamanho )
				OtherWise
					xConteudo := PadR( xConteudo, nTamanho )
			EndCase
		EndIf
	EndIf
EndIf
If GetSx3Cache(cCampo,"X3_CONTEXT") == "V"
	cVar := 'M->'+cCampo
	If lCriaPub
		Public &cVar := xConteudo
	EndIf
EndIf
RestArea(aAreaSX3)
RestArea(aArea)
Return(xConteudo)

Static Function InitPad(xForm,cTitulo)

Local bBlock:=ErrorBlock()
Local bErro := errorBlock( { |e| InitErr(e) } )
Local xRet

DEFAULT cTitulo := X3Titulo()

If "FORMULA"$xForm
	If !('"'$xForm)
		xForm := Substr(xForm,1,8)+'"'+Substr(xForm,9,3)+'")'
	EndIf
EndIf

BEGIN SEQUENCE
xRet := &xForm
End SEQUENCE
ErrorBlock(bBlock)
//If "FORMULA"$xForm
If xRet == nil
	HELP(" ",1,"INITERR",, cTitulo,4,2)
EndIf
//EndIf
Return xRet

User FUNCTION xNoAcento(cString)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : FunÁ„o para retirar acentos de uma string
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local cChar  := ""
Local nX     := 0
Local nY     := 0
Local cVogal := "aeiouAEIOU"
Local cAgudo := "·ÈÌÛ˙"+"¡…Õ”⁄"
Local cCircu := "‚ÍÓÙ˚"+"¬ Œ‘€"
Local cTrema := "‰ÎÔˆ¸"+"ƒÀœ÷‹"
Local cCrase := "‡ËÏÚ˘"+"¿»Ã“Ÿ"
Local cTio   := "„ı"
Local cCecid := "Á«"
Default cString := ""
                     
if ValType(cString) == "O"
	cString := "Image"
	Return cString
elseif ValType(cString) <> "C"	
	Return cString
endif	

For nX:= 1 To Len(cString)
	cChar:=SubStr(cString, nX, 1)
	IF cChar$cAgudo+cCircu+cTrema+cCecid+cTio+cCrase
		nY:= At(cChar,cAgudo)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cCircu)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cTrema)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cCrase)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cTio)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr("ao",nY,1))
		EndIf
		nY:= At(cChar,cCecid)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr("cC",nY,1))
		EndIf
	Endif
Next         

For nX:=1 To Len(cString)
	cChar:=SubStr(cString, nX, 1)
	If Asc(cChar) < 32 .Or. Asc(cChar) > 123 .Or. cChar $ '&'
		cString:=StrTran(cString,cChar,".")
	Endif
Next nX           
cString := _NoTags(cString)
Return cString

User Function GeraXls(cNomArq,cNewAlias,cPath,lTela,lDeleta)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : FunÁ„o para geraÁ„o de um XML a partir de um DBF
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/
Local cArq   := " "
Local oDlg1
Local nOpcXY := 0 
Local nRecOld := 0 
Default cNewAlias := "TRB"
Default cPath := ""
Default lTela := .F.
Default lDeleta := .F.

nRecOld := (cNewAlias)->(Recno())

if lTela  

  if Len(cNomArq) < 20
    cNomArq := cNomArq+Space(30-Len(cNomArq))
  endif
    
  DEFINE MSDIALOG oDlg1 TITLE OemToAnsi("Dados para geraÁ„o do Arquivo") From 0,0 To 110,260 of oMainWnd PIXEL
  @ 014,010 Say "Nome do Arquivo (Sem a extensao .xls!) ?" Size 130,010 OF oDlg1 PIXEL
  @ 023,010 MSGET cNomArq Size 080,010 PICTURE "@!" valid !Empty(cNomArq) OF oDlg1 PIXEL
  @ 040,080 BUTTON "Confirmar" SIZE 40,12 ACTION (nOpcXY := 1, oDlg1:End()) PIXEL OF oDlg1
  ACTIVATE MSDIALOG oDlg1 CENTERED

  if nOpcXY <>  1
    Return
  endif

  cNomArq := StrTran(cNomArq,"/","-")
  cNomArq := StrTran(cNomArq,"\","-")
  cNomArq := StrTran(cNomArq,"?","")
  cNomArq := StrTran(cNomArq,";","")
  cNomArq := StrTran(cNomArq,":","")
  cNomArq := StrTran(cNomArq,".","")
  cNomArq := StrTran(cNomArq,"@","")
  cNomArq := StrTran(cNomArq,"%","")
  cNomArq := StrTran(cNomArq,"*","")
  cNomArq := StrTran(cNomArq,"!","")
  cNomArq := StrTran(cNomArq,">","")
  cNomArq := StrTran(cNomArq,"<","")
  cNomArq := StrTran(cNomArq,"=","")
 
endif

//Carrego o path de onde sera gerado o arquivo em excel
if Empty(cPath) 
  cPath	:= cGetFile("","Local",0,"",.T.,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_NETWORKDRIVE)
endif    

cPath   += IIf( Right( AllTrim( cPath ), 1 ) <> '\' , '\', '' )
cARQ    := ALLTRIM(cPath)+Alltrim(cNomArq)+".XLS"
ARQUIVO := "\DATA\"+Alltrim(cNomArq)+".XLS"

//O arquivo a ser gerado pelo result set, devera ter seu alias igual a TRB como por exemplo a linha abaixo.
//TCQUERY cQuery NEW ALIAS "TRB"

DBSELECTAREA(cNewAlias)  
  
IF FILE(ARQUIVO)
   DELETE FILE(ARQUIVO) 
ENDIF

COPY TO &ARQUIVO
//direciona o arquivo para o \temp  do path c:\windows\
IF FILE(ARQUIVO)
   COPY FILE &ARQUIVO TO &cARQ
   DELETE FILE(ARQUIVO) 
ENDIF
//carrega o excel com o arquivo gerado, para isso, colocar o excel no path da maquina.

ShellExecute("open", "excel", cArq, "", 1)

//If ApOleClient( 'MsExcel' )
//  oExcelApp:= MsExcel():New()
//  oExcelApp:WorkBooks:Open(cArq)
//  oExcelApp:SetVisible(.T.)
//  oExcelApp:Destroy()
//elseIf ApOleClient( 'Excel' )
//  oExcelApp:= MsExcel():New()
//  oExcelApp:WorkBooks:Open(cArq)
//  oExcelApp:SetVisible(.T.)
//  oExcelApp:Destroy()
//ENDIF 

if lDeleta
  dbSelectArea(cNewAlias)
  DBCLOSEAREA()     
  FERASE(cArq+".DBF")
else
  (cNewAlias)->(DBGOTO(nRecOld))  
endif

Return()

User Function TRG10Exp()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para exportaÁ„o das tabelas da consulta personalizada
<Data> : 29/05/2018
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local cPath := cGetFile("","Local",0,"",.T.,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_NETWORKDRIVE)

If Empty(cPath)
	Alert("… obrigatÛrio selecionar o diretÛrio para exportaÁ„o dos arquivos !")
	Return
EndIf

__DIR := "\query\"

DbSelectArea("SX2")
DbSetOrder(1)
Set Filter to AllTrim(SX2->X2_PATH) == "\query\"

// Copia dos dados da tabela
While ! Eof()
	DbSelectArea("SX3")
	DbSeek(SX2->X2_CHAVE)

	DbSelectArea(SX2->X2_CHAVE)

	MsAguarde({|| 	FileCopy(__DIR + SX2->X2_CHAVE + "dat.dbf", "", cPath) }, "GeraÁ„o pacote de instalaÁ„o",;
						"Gerando [" + __DIR + SX2->X2_CHAVE + "dat.dbf]. Aguarde....", .T.)
	DbSelectArea("SX2")
	DbSkip()
EndDo

Return .T.

Static Function FileCopy(cFile, cFilter, cPath)

Local cRDD := RDDSetDefault()

DbGoTop()
If Eof()
	Set Filter To
	DbGoTop()
	Return .T.
EndIf

RDDSetDefault("DBFCDXADS")

If ! Empty(cFilter)
	Copy To &(cFile) For &(cFilter)
Else
	Copy To &(cFile)
EndIf

__CopyFile(cFile, StrTran(cFile, "\query\", cPath))
If File(StrTran(cFile, ".dbf", ".fpt"))
	__CopyFile(StrTran(cFile, ".dbf", ".fpt"), StrTran(StrTran(cFile, "\query\", cPath), ".dbf", ".fpt"))
EndIf

RDDSetDefault(cRdd)
Set Filter To
DbGoTop()

GerCsv(cFile,cPath)

Return

Static Function GerCSV(cFile,cPath)

Local nHdl 	 := FCreate(StrTran(cFile, ".dbf", ".txt"))
Local nField := 0
Local cCampo := ""

If ! File(cFile)
	Return .T.
EndIf

use &(cFile) new alias "CSV" via "DBFCDXADS"
While ! Eof()
	cCampo := ""
	For nField := 1 To FCount()
	   cField := FieldName(nField)

		xValue := &("CSV->" + cField)

    	If ! Empty(cCampo)
      		cCampo += ";"
    	EndIf

		If ValType(xValue) = "C" .Or. ValType(xValue) = "M"
  			cCampo += AllTrim(xValue)
		ElseIf ValType(xValue) = "N"
	   		cCampo += AllTrim(Str(xValue))
  		ElseIf ValType(xValue) = "D"
   			cCampo += Dtos(xValue)
  		ElseIf ValType(xValue) = "L"
	   		cCampo += If(xValue, ".T.", ".F.")
    	EndIf
	Next
	
	FWrite(nHdl, cCampo + Chr(13) + Chr(10))
	DbSkip()
EndDo
DbCloseArea()
FClose(nHdl)
__CopyFile(StrTran(cFile, ".dbf", ".txt"), StrTran(StrTran(cFile, ".dbf", ".txt"), "\query\", cPath))

Return

User Function TRG10Imp()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Rotina para importaÁ„o das tabelas da consulta personalizada
<Data> : 30/05/2018
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local cPath   := cGetFile("","Local",0,"",.T.,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_NETWORKDRIVE)
Local aFiles  := {}, nFiles := 1
Local cTitulo := "ImportaÁ„o Pacote Consulta Personalizada" 

If Empty(cPath)
	Alert("… obrigatÛrio selecionar o diretÛrio para importaÁ„o dos arquivos !")
	Return
EndIf

aFiles := Directory(Alltrim(cPath + "PQ*.DBF"))
__DIR  := "\query\"

//-- Atualiza conte˙do
For nFiles := 1 to Len(aFiles)
	If Upper(Left(aFiles[nFiles][1], 2)) = "PQ"
		__copyfile(cPath + aFiles[nFiles][1], __DIR + aFiles[nFiles][1])
		If !isBlind()
			MsAguarde({|| 	LoadData(StrTran(Left(aFiles[nFiles][1], 3), __DIR, ""), __DIR + aFiles[nFiles][1]) }, cTitulo,;
						"Atualizando [" + aFiles[nFiles][1] + "]. Aguarde....", .T.)
		Else
			LoadData(StrTran(Left(aFiles[nFiles][1], 3), __DIR, ""), __DIR + aFiles[nFiles][1])
			Conout("Atualizando [" + aFiles[nFiles][1] + "]. Aguarde....")
		EndIf		
	EndIf
Next

EndLog()

Return

//--------------------------------------------------------------------------
/*/{Protheus.doc} LoadData
Rotina para atualizaÁ„o dos dados da tabela

@author unknown programmer (unknown.programmer@unknown.programmer)
@since  05/02/2015
@param  Nil
@return Nil

/*/
//-------------------------------------------------------------------------

Static Function LoadData(cTab, cFile)

Local nReg   := 0
Local cUnico := ""

	DbSelectArea(cTab)

	dbUseArea( .T., "DBFCDXADS", cFile, "NEW", .F., .F.)
	If Select("NEW") = 0
		GrLog("AtenÁ„o. O arquivo [" + cFile + "] n„o pode ser aberto !")
		(cTab)->(DbCloseArea())
		Return
	EndIf
	SX2->(DbSeek(cTab))
	cUnico := AllTrim(SX2->X2_UNICO)
	
	If Empty(cUnico)
		NEW->(DbCloseArea())
		GrLog("AtenÁ„o. A chave unica da tabela [" + cTab + "] n„o foi definida !")
	
		Return
	EndIf
	
	While NEW->(!EOF())
		nReg ++
		
		If !IsBlind()
			MsProcTxt("Gravando [" + cTab + "] - Registro: " + AllTrim(Str(nReg)))
			ProcessMessage()
		EndIf		
		
		cChave := NEW->(&cUnico)

 		SaveReg(cTab, "NEW", ! (cTab)->(DbSeek(cChave)))
 		If Select("NEW") = 0
 			GrLog("Alias [NEW] n„o aberto ! Tabela [" + cTab + "] !")
 			Return	
 		EndIf

		NEW->(DbSkip())
	EndDo

	NEW->(DbCloseArea())
	(cTab)->(DbCloseArea())

Return Nil

Static Function SaveReg(cAlias, cAliasCp, lInsert, lMsUnLock)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : FunÁ„o para inserÁ„o de um registro em um alias a partir de outro
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local nField := 0, cField := ""

RecLock(cAlias, lInsert)

For nField := 1 To (cAliasCP)->(FCount())
    cField := (cAliasCP)->(FieldName(nField))
    
    //-- N„o altero o compartilhamento das tabelas existentes
    If ! lInsert .And. AllTrim(FieldName(nField)) $ "X2_MODO,X2_MODOUN,X2_MODOEMP"
    	Loop
    EndIf
    
    If (cAlias)->(FieldPos(cField)) > 0 .And. (cAliasCP)->(FieldPos(cField)) > 0 .And. ValType(&(cAliasCp + "->" + cField)) <> "M"
       &(cAlias + "->" + cField) := &(cAliasCp + "->" + cField)
    EndIf
Next

If lMsUnLock
	(cAlias)->(MsUnlock())
EndIf

Return

//--------------------------------------------------------------------------
/*/{Protheus.doc} ImpData
Rotina para importaÁ„o de arquivo .DBF para tabela

@author unknown programmer (unknown.programmer@unknown.programmer)
@since  16/02/2015
@param  Nil
@return Nil

/*/
//-------------------------------------------------------------------------
Static Function ImpData(cSX3, cFile)

Local cRDD := RDDSetDefault()

If ! File(cFile)
	Return .T.
EndIf

RDDSetDefault("DBFCDXADS")

Append From (cFile)

RDDSetDefault(cRdd)

Return .T.


//--------------------------------------------------------------------------
/*/{Protheus.doc} InitLog
InicializaÁ„o do log de procedimentos de manutenÁ„o de base de dados

@author Wagner Mobile Costa
@since  13/09/2015
@param  Nil
@return Nil

/*/
//-------------------------------------------------------------------------
Static Function InitLog()

	AutoGrLog("ImportaÁ„o Consulta Personalizada")
	AutoGrLog("---------------------------------")
	AutoGrLog("DATA INICIO - "+Dtoc(MsDate()))
	AutoGrLog("HORA - "+Time())
	AutoGrLog("ENVIRONMENT - "+GetEnvServer())
	AutoGrLog("PATCH - "+GetSrvProfString("Startpath",""))
	AutoGrLog("ROOT - "+GetSrvProfString("SourcePath",""))
	AutoGrLog("VERS√O - "+GetVersao())
	AutoGrLog("M”DULO - "+"SIGA"+cModulo)
	AutoGrLog("EMPRESA / FILIAL - "+SM0->M0_CODIGO+"/"+SM0->M0_CODFIL)
	AutoGrLog("NOME EMPRESA - "+Capital(Trim(SM0->M0_NOME)))
	AutoGrLog("NOME FILIAL - "+Capital(Trim(SM0->M0_FILIAL)))
	AutoGrLog("USU¡RIO - "+SubStr(cUsuario,7,15))
	AutoGrLog("")

Return

//--------------------------------------------------------------------------
/*/{Protheus.doc} EndLog
ApresentaÁ„o do log de inconsistencias na manutenÁ„o de base de dados

@author Wagner Mobile Costa
@since  13/09/2015
@param  Nil
@return Nil

/*/
//-------------------------------------------------------------------------
Static Function EndLog()

AutoGrLog("DATA FINAL - "+Dtoc(MsDate()))
AutoGrLog("HORA - "+Time())

If !IsBlind()		
   MostraErro("", "INSTSXDB")
EndIf

Return

//--------------------------------------------------------------------------
/*/{Protheus.doc} GrLog
GeraÁ„o do texto de log com hora de execuÁ„o

@author Wagner Mobile Costa
@since  13/09/2015
@param  cLog = Texto para chamada da funÁ„o AutoGrLog
@return Nil

/*/
//-------------------------------------------------------------------------
Static Function GrLog(cLog)

AutoGrLog(Time() + "-" + cLog)
ConOut(Time() + "-" + cLog)

Return