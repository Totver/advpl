#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

//-------------------------------------------------------------------
/*/{Protheus.doc} COMP031_MVC
Exemplo de importacao de dados para unma tabela simples
para um rotina desenvolvida em MVC

@author Ernani Forastieri e Rodrigo Antonio Godinho
@since 05/10/2009
@version P10
/*/
//-------------------------------------------------------------------
User Function COMP031_MVC()
Local   aSay     := {}
Local   aButton  := {}
Local   nOpc     := 0
Local   Titulo   := 'IMPORTACAO DE AUTORES'
Local   cDesc1   := 'Esta rotina fara a importacao de Autores/interpretes'
Local   cDesc2   := 'conforme layout.'
Local   cDesc3   := ''
Local   lOk      := .T.

aAdd( aSay, cDesc1 )
aAdd( aSay, cDesc2 )
aAdd( aSay, cDesc3 )

aAdd( aButton, { 1, .T., { || nOpc := 1, FechaBatch() } } )
aAdd( aButton, { 2, .T., { || FechaBatch()            } } )

FormBatch( Titulo, aSay, aButton )

If nOpc == 1

	Processa( { || lOk := Runproc() },'Aguarde','Processando...',.F.)

	If lOk
		ApMsgInfo( 'Processamento terminado com sucesso.', 'ATEN��O' )

	Else
		ApMsgStop( 'Processamento realizado com problemas.', 'ATEN��O' )

	EndIf

EndIf

Return NIL


//-------------------------------------------------------------------
Static Function Runproc()
Local lRet    := .T.
Local aCampos := {}

// Criamos um vetor com os dados para facilitar o manuseio dos dados
aCampos := {}
aAdd( aCampos, { 'ZA0_CODIGO', '000100'         } )
aAdd( aCampos, { 'ZA0_NOME'  , 'Vila Lobos'     } )
aAdd( aCampos, { 'ZA0_NOTAS' , 'Observacoes...' } )
aAdd( aCampos, { 'ZA0_TIPO'  , '1'              } )

If !Import( 'ZA0', aCampos )
	lRet := .F.
EndIf


// Importamos outro registro
aCampos := {}
aAdd( aCampos, { 'ZA0_CODIGO', '000102'    } )
aAdd( aCampos, { 'ZA0_NOME'  , 'Tom Jobim' } )
aAdd( aCampos, { 'ZA0_NOTAS' , 'Observacoes...' } )
aAdd( aCampos, { 'ZA0_TIPO'  , '1' } )

If !Import( 'ZA0', aCampos )
	lRet := .F.
EndIf


// Importamos outro registro
aCampos := {}
aAdd( aCampos, { 'ZA0_CODIGO', '000104'    } )
aAdd( aCampos, { 'ZA0_NOME' , 'Emilio Santiago' } )
aAdd( aCampos, { 'ZA0_NOTAS', 'Observacoes...' } )
aAdd( aCampos, { 'ZA0_TIPO' , '2' } )

If !Import( 'ZA0', aCampos )
	lRet := .F.
EndIf


// Importamos outro registro
aCampos := {}
aAdd( aCampos, { 'ZA0_CODIGO', '000105'    } )
aAdd( aCampos, { 'ZA0_NOME' , 'Maria Rita'      } )
aAdd( aCampos, { 'ZA0_NOTAS', 'Observacoes...' } )
aAdd( aCampos, { 'ZA0_TIPO' , '2' } )

If !Import( 'ZA0', aCampos )
	lRet := .F.
EndIf


// Importamos outro registro
aCampos := {}
aAdd( aCampos, { 'ZA0_CODIGO', '000106'    } )
aAdd( aCampos, { 'ZA0_NOME' , 'Zizi Possi' } )
aAdd( aCampos, { 'ZA0_NOTAS', 'Observacoes...' } )
aAdd( aCampos, { 'ZA0_TIPO' , '2' } )

If !Import( 'ZA0', aCampos )
	lRet := .F.
EndIf


// Importamos outro registro
aCampos := {}
aAdd( aCampos, { 'ZA0_NOME' , 'Forca Erro' } )
aAdd( aCampos, { 'ZA0_NOTAS', 'Observacoes...' } )
aAdd( aCampos, { 'ZA0_TIPO' , 'X' } )

If !Import( 'ZA0', aCampos )
	lRet := .F.
EndIf

Return lRet


//-------------------------------------------------------------------
Static Function Import(  cMaster, aCpoMaster  )
Local  oModel, oAux, oStruct
Local  nI        := 0
Local  nJ        := 0
Local  nPos      := 0
Local  lRet      := .T.
Local  aAux	     := {}
Local  aC  	     := {}
Local  aH        := {}
Local  nItErro   := 0
Local  lAux      := .T.

dbSelectArea( cMaster )
dbSetOrder( 1 )

// Aqui ocorre o instanciamento do modelo de dados (Model)
// Neste exemplo instanciamos o modelo de dados do fonte COMP022_MVC
// que � a rotina de manuten��o de musicas
oModel := FWLoadModel( 'COMP011_MVC' )

// Temos que definir qual a opera��o deseja: 3 � Inclus�o / 4 � Altera��o / 5 - Exclus�o
oModel:SetOperation( 3 )

// Antes de atribuirmos os valores dos campos temos que ativar o modelo
oModel:Activate()

// Instanciamos apenas a parte do modelo referente aos dados de cabe�alho
oAux    := oModel:GetModel( cMaster + 'MASTER' )

// Obtemos a estrutura de dados do cabe�alho
oStruct := oAux:GetStruct()
aAux	:= oStruct:GetFields()

If lRet
	For nI := 1 To Len( aCpoMaster )
		// Verifica se os campos passados existem na estrutura do cabe�alho
		If ( nPos := aScan( aAux, { |x| AllTrim( x[3] ) ==  AllTrim( aCpoMaster[nI][1] ) } ) ) > 0

			// � feita a atribuicao do dado aos campo do Model do cabe�alho
			If !( lAux := oModel:SetValue( cMaster + 'MASTER', aCpoMaster[nI][1], aCpoMaster[nI][2] ) )
				// Caso a atribui��o n�o possa ser feita, por algum motivo (valida��o, por exemplo)
				// o m�todo SetValue retorna .F.
				lRet    := .F.
				Exit
			EndIf
		EndIf
	Next
EndIf


If lRet
	// Faz-se a valida��o dos dados, note que diferentemente das tradicionais "rotinas autom�ticas"
	// neste momento os dados n�o s�o gravados, s�o somente validados.
	If ( lRet := oModel:VldData() )
		// Se o dados foram validados faz-se a grava��o efetiva dos dados (commit)
		lRet := oModel:CommitData()
	EndIf
EndIf

If !lRet
	// Se os dados n�o foram validados obtemos a descri��o do erro para gerar LOG ou mensagem de aviso
	aErro   := oModel:GetErrorMessage()
	// A estrutura do vetor com erro �:
	//  [1] Id do formul�rio de origem
	//  [2] Id do campo de origem
	//  [3] Id do formul�rio de erro
	//  [4] Id do campo de erro
	//  [5] Id do erro
	//  [6] mensagem do erro
	//  [7] mensagem da solu��o
	//  [8] Valor atribuido
	//  [9] Valor anterior

	AutoGrLog( "Id do formul�rio de origem:" + ' [' + AllToChar( aErro[1]  ) + ']' )
	AutoGrLog( "Id do campo de origem:     " + ' [' + AllToChar( aErro[2]  ) + ']' )
	AutoGrLog( "Id do formul�rio de erro:  " + ' [' + AllToChar( aErro[3]  ) + ']' )
	AutoGrLog( "Id do campo de erro:       " + ' [' + AllToChar( aErro[4]  ) + ']' )
	AutoGrLog( "Id do erro:                " + ' [' + AllToChar( aErro[5]  ) + ']' )
	AutoGrLog( "Mensagem do erro:          " + ' [' + AllToChar( aErro[6]  ) + ']' )
	AutoGrLog( "Mensagem da solu��o:       " + ' [' + AllToChar( aErro[7]  ) + ']' )
	AutoGrLog( "Valor atribuido:           " + ' [' + AllToChar( aErro[8]  ) + ']' )
	AutoGrLog( "Valor anterior:            " + ' [' + AllToChar( aErro[9]  ) + ']' )

	If nItErro > 0
		AutoGrLog( "Erro no Item:              " + ' [' + AllTrim( AllToChar( nItErro  ) ) + ']' )
	EndIf

	MostraErro()

EndIf

// Desativamos o Model
oModel:DeActivate()

Return lRet
