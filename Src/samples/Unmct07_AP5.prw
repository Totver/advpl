#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 28/09/00

User Function Unmct07()        // incluido pelo assistente de conversao do AP5 IDE em 28/09/00
SetPrvt("aSX1,cPerg,")
SetPrvt("_cContaDe,_cContaAte,_dTransfer,_nPer,_nSld1")                         
SetPrvt("_lDigita,_lAglutina,_cPadrao,_lPadrao, _nHdlPrv,_cLote, _nCont, _nTotal, _nValor,")

/*-----------------------------------------------------------------------------
	NomePrograma:	UnmCT07.prw	
	Autor				:	Sergio Silverfox-MicrosigaSalvador
	DtCriacao		:	28/set/2000
	Pto	Lancto	:	Menu-Miscelanea/Rotinas Unime/Transf.Diferido
	Descricao 		:	Calcula Saldo das Contas 3 e 4 e transfere para Diferido
	Indices			:
	Observacoes 	:	
------------------------------------------------------------------------------*/

AjustaSX1()

cPerg:= "UNCT07"

//----- Caixa de Diálogo Inicial 
@ 96,42 TO 323,505 DIALOG oDlg1 TITLE"UNMCT07_AP5 - Transferencia de saldo para Diferido"
@ 8,10 TO 84,222
@ 91,139 BMPBUTTON TYPE 5 ACTION Pergunte( cPerg, .T. )
@ 91,168 BMPBUTTON TYPE 1 ACTION OkProc()
@ 91,196 BMPBUTTON TYPE 2 ACTION Close(oDlg1)
@ 23,14 SAY "Este programa e uma rotina especifica UNIME, visa transferir o saldo das contas"  		SIZE 200,10
@ 33,14 SAY "de Receitas/Gastos para as contas do Diferido, em fase pre-operacional."					SIZE 200,10
@ 73,14 SAY "Microsiga Salvador - Out/2000"    SIZE 200,08
ACTIVATE DIALOG oDlg1

return()

STATIC FUNCTION OkProc()

	Close(oDlg1)                                                     
	//----- Declaracao de aRotina
	aRotina					:=	{{"UNMCT07","Unmct07",0,3 }}
	//----- Recupera valores dos parâmetros
	Pergunte(cPerg, .f. )
	//----- Grupo UNCT07
	_cContaDe			:=	mv_par01 
	_cContaAte		:=	mv_par02
	_dTransfer     	:=	mv_par03

	//----- Variaveis contabilizacao
	_cPadrao 		:= "001"
	_lPadrao 			:= VerPadrao( _cPadrao )
	_cArquivo 		:=	NIL     
	_cLote					:=	"8899"     
	_lDigita				:=	.T.
	_lAglutina		:=	.F.
	_nCont				:=	0
	_nTotal				:=	0
	_nValor				:=	0
	_nPer 					:= Val( Subs( Periodo( _dTransfer, 1 ),5))
	
	//----- Calcula Saldo
	MsgBox( "Periodo  "+Str(_nPer),"UNMCT07-02 - Periodo encontrado ")
  _nHdlPrv 	:=	HeadProva( _cLote, "UNMCT07", Substr(cUsuario,7,6), @_cArquivo)
	DbSelectArea("SI1")
	DbSetOrder(1)
	DbSeek( xFilial()+_cContaDe )
	While !Eof() .and. SI1->I1_CODIGO <= _cContaAte
		_nSld1		:= CalcSaldo( _nPer, 1, .T. )  //----- Calcula Saldo com base no periodo, moeda 1, Considerando SaldoInicial
		MsgBox( "Conta "+SI1->I1_CODIGO+"   "+Str( _nSld1  ),"UNMCT07-01a - Saldo resultante  CalcSaldo()" )
		If _nSld1 # 0 
			_cDC					:=	"X"
			If	_nSld1		< 0  
				//----- Casos de Saldo a Debito
				_cDebito		:=	SI1->I1_CTDIFER
				_cCredito		:=	SI1->I1_CODIGO
			Else 
				//----- Casos de Saldo a Credito
				_cDebito		:=	SI1->I1_CODIGO
				_cCredito		:=	SI1->I1_CTDIFER
			Endif
			_cHist				:=	"Transf. para Diferido conf. Item V art 179 da Lei das S.A"
			_nValor			:=	IIF( _nSld1 < 0, ( _nSld1 * -1), _nSld1 )

			_nTotal			:=	_nTotal + DetProva( _nHdlPrv, _cPadrao, "UNMCT07", _cLote)
			 		 
		Endif		

		DbSkip()
	End

	RodaProva( _nHdlPrv, _nTotal )
	CA100Incl( _cArquivo, _nHdlPrv, 3, _cLote, .T., .T. )
//	CA100Incl( _cArquivo, _nHdlPrv, 3, _cLote, _lDigita, _lAglutina )
  MsgBox("Final")
Return

STATIC FUNCTION AjustaSX1()
	//-----  AJUSTE NO SX1  
	aSX1		:=	GetArea()
	i:=0
	j:=0

	aRegistros:={}

	AADD(aRegistros,{"UNCT07","01","Conta de           ?","mv_ch1","C",15,0,0,"G","","mv_par01","","3","","","","","","","","","","","","",""})
	AADD(aRegistros,{"UNCT07","02","Conta ate          ?","mv_ch2","C",15,0,0,"G","","mv_par02","","4ZZZZZ","","","","","","","","","","","","",""})
	AADD(aRegistros,{"UNCT07","03","Data da transfer.  ?","mv_ch3","D",8,0,0,"G","","mv_par03","","'30/08/2000'","","","","","","","","","","","","",""})

	dbSelectArea("SX1")
	If !dbSeek("UNCT07")
		For i:=1 to Len(aRegistros)
			RecLock("SX1",.T.)
			For j:=1 to FCount()
				FieldPut(j,aRegistros[i,j])	
			Next
			MsUnlock()
		Next	
	Endif

	RestArea( aSX1 )
Return 
                                                   
/*/
STATIC FUNCTION fLancto()
  //----- Variaveis para Lancamento Padrao especifico UNIME - Transf Diferido
  _cPadrao:= "001" 
  _lPadrao := VerPadrao(_cPadrao)

  //	lDigita :=  Iif(mv_par01==1,.T.,.F.)  // Mostra Lanctos ou Nao...
  //	lAglutina:= .t. //  forca aglutinar Sempre ... Iif(mv_par02==1,.T.,.F.)
  cArquivo := NIL
  If lRetMod2
         //MsgStop("Voce confirmou a operacao!")
         nCont  := 0
         nTotal := 0
         nHdlPrv :=HeadProva(_cLote,"UNMCT07",Substr(cUsuario,7,6),@cArquivo)
         For nCont := 1 To Len(aCols)
           If aCols[nCont][nUsado+1] == .F.
             // Grava apenas registros nao deletados.

              _nParcRateio := Round(SEZ->EZ_VALOR * _nFator,2)
              _nSubBruto   := _nSubBruto + _nParcRateio
              _nSubTot     := _nSubTot +SEZ->EZ_VALOR

              If nCont == Len(aCols)
                // Calcula Diferencas minimas em casos de arrededondamento
                // For‡ando a coincidencia com o valor bruto
                _nDiferenca := _nValBrut - _nSubBruto
                _nParcRateio := _nParcRateio + _nDiferenca
              Endif

              nTotal := nTotal + DetProva(nHdlPrv,_cPadrao,"FINA050",_cLote)
             MsUnlock()
           Endif

         Next

         _nParcRateio := 0
         VALOR := _nSubTot
         nTotal := nTotal + DetProva(nHdlPrv,_cPadrao,"FINA050",_cLote)

         RodaProva(nHdlPrv,nTotal)
//         lDigita:= Iif(mv_par01==1,.T.,.F.)
         Ca100Incl(cArquivo,nHdlPrv,3,_cLote,lDigita,lAglutina)
//         _lVolta := .f.
  //Else
      //_RetRat := "N"
  Endif
EndIf

Return
/*/
