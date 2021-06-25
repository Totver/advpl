#INCLUDE "rwmake.ch"
#INCLUDE "PROTHEUS.ch"

User Function TRGA050()
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Cadastro de Usuarios/Grupos da Consultas Personalizadas
<Data> : 02/08/2013
<Parametros> : Nenhum
<Retorno> : Nenhum
<Processo> : Consultas Personalizadas
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.
Private cCadastro 	:= "Cadastro de Usu·rios/Grupos da Consulta Personalizada"
Private aRotina := {	{"Pesquisar" 	,"AxPesqui",0,1} ,;
						{"Visualizar"	,"U_CADPQ8",0,2} ,;
             		 	{"Incluir"		,"U_CADPQ8",0,3} ,;
             		 	{"Alterar"		,"U_CADPQ8",0,4} ,;	             		 	
             		 	{"Excluir"		,"U_CADPQ8",0,5} }
             		 	
Private cString := "PQ8"

dbSelectArea(cString)
dbSetOrder(1)

//AxCadastro(cString,"Cadastro de Usu·rios/Grupos da Consulta Personalizada",cVldExc,cVldAlt)

mBrowse( 6, 1,22,75,cString,,,,,,,,,,,,,,)

Return

User Function CADPQ8(x,y,nOpc)

	Local cAlias1		:= "PQ8"
	Local cAlias2		:= ""
	Local oPQ8Ench
	Local xOpc			:= 0
	Local nRec1		:= PQ8->( Recno() )
	Local nlPosDel
	
	Private oDlg
	Private aBotoes	:= {}
	Private bOk		:= {|| IIF(vldOk(),(xOpc:=1,oDlg:End()),Nil) }
	Private bCancel 	:= {|| xOpc:=0,oDlg:End() }	
	
	Private aSize    	:= MsAdvSize()
	Private aObjects 	:= {}
	Private aInfo    	:= {aSize[1],aSize[2],aSize[3],aSize[4],3,3}
	Private aPosObj  	:= {}
	Private aPosGet  	:= {}
	Private aGets	 	:= {}
	Private aCposE1	:= { "NOUSER", "PQ8_ID", "PQ8_GRUSER","PQ8_GRNOME", "PQ8_USER", "PQ8_USNOME"}
	Private aAltE1	:= {"PQ8_ID", "PQ8_GRUSER", "PQ8_USER"}
	Private aPosE1
	Private aPosE2
	Private apHeader	:= {}
	Private apCols	:= {}
	Private oGetd
		
	Private lVisualiza:= IIF( nOpc == 2 , .T. , .F. )
	Private lInclui	:= IIF( nOpc == 3 , .T. , .F. )
	Private lAltera	:= IIF( nOpc == 4 , .T. , .F. )
	Private lExclui	:= IIF( nOpc == 5 , .T. , .F. )

	AADD( aObjects, { 100, 100, .t., .t. } )
	AADD( aObjects, { 100, 100, .t., .t. } )
				
	aPosObj 	:= MsObjSize(aInfo,aObjects)	
	aPosE1		:= { aPosObj[1,1]+10, aPosObj[1,2]+3, aPosObj[1,3]-2, aPosObj[1,4]-3 }
	aPosE2		:= { aPosObj[2,1]+10, aPosObj[2,2]+3, aPosObj[2,3]-2, aPosObj[2,4]-3 }
		
	oDlg := TDialog():New(aSize[7],0,((aSize[6]/100)*98),((aSize[5]/100)*99),cCadastro,,,,,,,,oMainWnd,.T.)
	
		RegToMemory(cAlias1, iif(lInclui,.T.,.F.))
		
		@ 000, 000 MSPANEL oPanTop SIZE 000, 050 OF oDlg RAISED
		oPanTop:Align	:= CONTROL_ALIGN_TOP
		
		oEncCab	:= MsmGet():New("PQ8", nRec1, nOpc,,,, aCposE1,aPosE1,aAltE1, 3,,,, oPanTop,, .T.)
		oEncCab:oBox:Align	:= CONTROL_ALIGN_ALLCLIENT
		
		apHeader	:= getHeadPQ9()
		apCols		:= getColsPQ9(M->PQ8_ID, M->PQ8_USER, apHeader )
		
		getDridDat()
			
	oDlg:Activate(,,,,,,{||EnchoiceBar(oDlg,bOk,bCancel,,aBotoes)},,)
		
	if xOpc == 1 
		updateDat()
	endif

Return

Static Function getDridDat()

	Local alFieldAlt	:= {"PQ9_ACESSO"}
	Local clVldDel	:= "AllwaysFalse"
	
	oGetd := MsNewGetDados():New(000, 000, 100, 100, GD_UPDATE+GD_INSERT+GD_DELETE,,, "+PQ9_LINHA", alFieldAlt,, Len(apCols),,,clVldDel, oDlg, apHeader, apCols)
	oGetd:oBrowse:Align	:= CONTROL_ALIGN_ALLCLIENT
	oGetd:oBrowse:Refresh()
	
	if lVisualiza
		oGetd:Disable()
	endif

Return

Static Function updateDat()

	Local nlx
	Local nly
	Local nlPos
	Local alCols

	if lInclui .Or. lAltera
	
		Begin Transaction
		
			if RecLock("PQ8", lInclui)
			
				for nlx := 1 To Len( aCposE1 )
				
					if !( aCposE1[nlx] == "NOUSER" )
						PQ8->&( aCposE1[nlx] ) := M->&( aCposE1[nlx] ) 
					endif
				
				next nlx
			
				PQ8->( MsUnLock() )
			endif
			
			dbSelectArea("PQ9")
			
			if !Empty( M->PQ8_USER ) 
			
				if !deleteDat()
					DisarmTransaction()
					
				else
				
					alCols	:= oGetd:aCols
				
					for nlx := 1 To Len( alCols )
					
						if !Empty( alCols[nlx][ASCAN(apHeader,{|x| AllTrim(x[2]) == "PQ9_ROTINA" } )] )
					
							if RecLock("PQ9", .T.)
							
								PQ9->PQ9_ID	:= M->PQ8_ID
								PQ9->PQ9_USER	:= M->PQ8_USER
							
								for nly := 1 To Len( apHeader )
								
									clField	:= apHeader[nly][2]
									nlPos		:= ASCAN(apHeader,{|x| AllTrim(x[2]) == clField } )
									PQ9->&( clField ) := alCols[nlx][nlPos]
								
								next nly
						
								PQ9->( MsUnLock() )
							endif
							
						endif
						
					next nlx
					
				endif
				
			endif
		
		End Transaction
		
	elseif lExclui
	
		Begin Transaction
		
			if RecLock("PQ8", .F., .T.)			
				PQ8->( dbDelete() )
				PQ8->( MsUnLock() )
			endif
			
			if !deleteDat()
				DisarmTransaction()
			endif
		
		End Transaction
	
	endif

Return

Static Function deleteDat(clIdCons, clIdUsr)

	Local llRet := .T.

	Default clIdCons	:= M->PQ8_ID
	Default clIdUsr	:= M->PQ8_USER
	
	if TcSQLExec(	"UPDATE " + RetSQLName("PQ9") +; 
							" SET D_E_L_E_T_ = '*' " +;
							" WHERE D_E_L_E_T_ = ' ' " +;
							" AND PQ9_ID = '" + clIdCons + "' " +;
							" AND PQ9_USER = '" + clIdUsr + "' " ) < 0
							
		Aviso("Erro de integridade de dados", TcSQLError(), {"Ok"}, 3)
		llRet := .F.
				
	endif

Return llRet

Static Function vldOk()

	Local llRet := .T.
	
	if Empty( M->PQ8_ID )
		Alert(GetSX3Cache("PQ8_ID", "X3_TITULO") + " deve ser preenchido!")
		llRet := .F.
	endif
	
	if Empty( M->PQ8_USER ) .And. Empty( M->PQ8_GRUSER )
		Alert( AllTrim( GetSX3Cache("PQ8_USER", "X3_TITULO") ) + " ou " + AllTrim( GetSX3Cache("PQ8_GRUSER", "X3_TITULO") ) + " deve ser preenchido!")
		llRet := .F.
	endif

Return llRet

User Function vldPQ8( nlOpc )

	Local uRet

	Do Case
		
		Case nlOpc == 1
			uRet := refreshPQ9()
			
	EndCase

Return uRet

Static Function refreshPQ9( clIdCons, clIdUsr )

	Default clIdCons	:= M->PQ8_ID
	Default clIdUsr	:= M->PQ8_USER
	
	apCols	:= getColsPQ9( clIdCons, clIdUsr )
	getDridDat()
	oDlg:Refresh()
	
	
Return .T.

Static Function getHeadPQ9()

	Local alHeader	:= {}
	Local nlx

	AADD(alHeader, {"", "PQ9_LINHA"		, "", 0, 0, "", "", "", "", "", "", ""})
	AADD(alHeader, {"", "PQ9_ROTINA"	, "", 0, 0, "", "", "", "", "", "", ""})
	AADD(alHeader, {"", "PQ9_ACESSO"	, "", 0, 0, "", "", "", "", "", "", ""})
	
	dbSelectArea("SX3")
	dbSetOrder(2)
	
	for nlx := 1 To Len(alHeader)
	
		if dbSeek(alHeader[nlx, 2], .f.)
			alHeader[nlx, 01]	:= Alltrim(SX3->X3_TITULO)
			alHeader[nlx, 03]	:= SX3->X3_PICTURE
			alHeader[nlx, 04]	:= SX3->X3_TAMANHO
			alHeader[nlx, 05]	:= SX3->X3_DECIMAL
			alHeader[nlx, 06]	:= SX3->X3_VALID
			alHeader[nlx, 07]	:= SX3->X3_USADO
			alHeader[nlx, 08]	:= SX3->X3_TIPO
			alHeader[nlx, 09]	:= SX3->X3_F3
			alHeader[nlx, 10]	:= SX3->X3_CONTEXT
			alHeader[nlx, 11]	:= SX3->X3_CBOX
			alHeader[nlx, 12]	:= SX3->X3_RELACAO
		endif
		
	next nlx

Return alHeader

Static Function getColsPQ9( clIdConsul, clIdUsr, alHeader )

	Local alCols	:= {}
	Local clAlias	:= GetNextAlias()
	Local nlPosDel:= 0
	Local nlx	
	
	Default alHeader	:= apHeader
	nlPosDel:= ( Len(alHeader) + 1)
	
	if Empty( clIdConsul )
	
		AADD(alCols, Array( nlPosDel ) )
		alCols[1][1]	:= StrZero(1, TamSX3("PQ9_LINHA")[1])
		for nlx := 2 To Len( apHeader )
			alCols[1][nlx]	:= CriaVar(apHeader[nlx][2])
		next nlx		
		alCols[1][nlPosDel] := .F.
	
	else
		
		BEGINSQL ALIAS clAlias
		
			SELECT 
				PQ6_ORDEM, PQ6_DESCRI, COALESCE(PQ9_ACESSO, 'S') AS PQ9_ACESSO 
			
			FROM 
				%TABLE:PQ6% PQ6
				
			LEFT JOIN
				%TABLE:PQ9% PQ9 ON
				PQ9.%NOTDEL%
				AND PQ9_ID = PQ6_ID
				AND PQ9_USER = %EXP:clIdUsr%
				AND PQ9_LINHA = PQ6_ORDEM
				
			WHERE 
				PQ6.%NOTDEL% 
				AND PQ6_ID = %EXP:clIdConsul%
				
			ORDER BY PQ6_ORDEM
			
		ENDSQL
		
		While !( clAlias )->( Eof() )
			
			AADD(alCols, Array(nlPosDel) )
			
			alCols[Len(alCols), 1]	:= ( clAlias )->PQ6_ORDEM
			alCols[Len(alCols), 2]	:= ( clAlias )->PQ6_DESCRI
			alCols[Len(alCols), 3]	:= ( clAlias )->PQ9_ACESSO
			
			alCols[Len(alCols), nlPosDel]	:= .F.
			
			( clAlias )->( dbSkip() )
			
		EndDo
		( clAlias )->( dbCloseArea() )
		
	endif

Return alCols