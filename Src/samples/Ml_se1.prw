#include "rwmake.ch"

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma  Ё ML_SE1   Ё Autor Ё Evandro Mugnol        Ё Data Ё 09/11/00 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao Ё Atualizacao da base de dados com arquivo texto gerado      Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
User Function ML_SE1()

_acampos  := {"E1_FILIAL","E1_PREFIXO","E1_NUM"    ,"E1_PARCELA","E1_TIPO"   ,;
             "E1_NATUREZ","E1_PORTADO","E1_AGEDEP" ,"E1_CLIENTE","E1_LOJA"   ,;
             "E1_NOMCLI" ,"E1_EMISSAO","E1_VENCTO" ,"E1_VENCREA","E1_VALOR"  ,;
             "E1_IRRF"   ,"E1_ISS"    ,"E1_NUMBCO" ,"E1_INDICE" ,"E1_BAIXA"  ,;
             "E1_NUMBOR" ,"E1_DATABOR","E1_EMIS1"  ,"E1_HIST"   ,"E1_LA"     ,;
             "E1_LOTE"   ,"E1_MOTIVO" ,"E1_MOVIMEN","E1_OP"     ,"E1_SITUACA",;
             "E1_CONTRAT","E1_SALDO"  ,"E1_SUPERVI","E1_VEND1"  ,"E1_VEND2"  ,;
             "E1_VEND3"  ,"E1_VEND4"  ,"E1_VEND5"  ,"E1_COMIS1" ,"E1_COMIS2" ,;
             "E1_COMIS3" ,"E1_COMIS4" ,"E1_COMIS5" ,"E1_DESCONT","E1_MULTA"  ,;
             "E1_JUROS"  ,"E1_CORREC" ,"E1_VALLIQ" ,"E1_VENCORI","E1_CONTA"  ,;
             "E1_VALJUR" ,"E1_PORCJUR","E1_MOEDA"  ,"E1_BASCOM1","E1_BASCOM2",;
             "E1_BASCOM3","E1_BASCOM4","E1_BASCOM5","E1_FATPREF","E1_FATURA" ,;
             "E1_OK"     ,"E1_PROJETO","E1_CLASCOM","E1_VALCOM1","E1_VALCOM2",;
             "E1_VALCOM3","E1_VALCOM4","E1_VALCOM5","E1_OCORREN","E1_INSTR1" ,;
             "E1_INSTR2" ,"E1_PEDIDO" ,"E1_DTVARIA","E1_VARURV" ,"E1_VLCRUZ" ,;
             "E1_DTFATUR","E1_NUMNOTA","E1_SERIE"  ,"E1_STATUS" ,"E1_ORIGEM" ,;
             "E1_IDENTEE","E1_NUMCART","E1_FLUXO"  ,"E1_DESCFIN","E1_DIADESC",;
             "E1_CARTAO" ,"E1_CARTVAL","E1_CARTAUT","E1_ADM"    ,"E1_VLRREAL",;
             "E1_TRANSF" ,"E1_BCOCHQ" ,"E1_AGECHQ" ,"E1_CTACHQ" ,"E1_NUMLIQ" ,;
             "E1_ORDPAGO","E1_INSS"   ,"E1_FILORIG","E1_TIPOFAT","E1_TIPOLIQ",;
             "E1_CSLL"   ,"E1_COFINS" ,"E1_PIS"    ,"E1_FLAGFAT"}

_nrec     := Recno()
cCadastro := "Contas a Receber"
_result   := axAltera("SE1",_nrec,4,_acampos)
_cArquivo := "\IMPORTA\"+"SE1I.TXT"   // ParamIxb
_cOk      := .T.

If _result == 1       // Confirmacao
   If !File(_cArquivo)
      _cOk := .F.
      MsgAlert("Arquivo "+_cArquivo+" Nao Localizado")
   Endif
   If _cOk == .T.     // Status Encerrado
      Atualiza()
   Endif
Endif

//cDelArq1 := _cArquivo
//FERASE(cDelArq1)

Return

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Atualiza a base de dados                              Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Static Function Atualiza()
_cRdmake   := "INCVETOR"
_cListMod1 := "MATA010|MATA020|MATA030|MATA040|MATA050|MATA080|MATA150|MATA240|MATA250|MATA270|MATA680|MATA681|FINA040|FINA050|ALTSB1|QIEA030|MATA520"
_cListMod2 := "MATA120|MATA140|MATA241|MATA410|MATA415|MATA416|CONA050|CFGX016|MATA110|MATA265|MATA115"
_aTxt      := {}
_nHa       := 0
_nPTxt     := 1
_cLine     := ""

CarregaTxt()
LeLinha()

_cProg := AllTrim(Left(_cLine,8) )
If ( _cProg $ _cListMod1 )
   Mod1()
Elseif ( _cProg $ _cListMod2 )
   Mod2()
EndIf

Return


//зддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chamada da Funcao aFillModelo                         Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Static Function aFillModelo()
_aModelo := {}
_nPos    := 3

// Caso passe um numero de indice
_nIndex := -1
If ( Upper(AllTrim(_aVetor[Len(_aVetor),1])) == "INDEX" )
   _nIndex := _aVetor[Len(_aVetor),2]
   aDel(_aVetor,Len(_aVetor))
   aSize(_aVetor,Len(_aVetor)-1)
EndIf
For _nX2 := 1 to Len(_aVetor)
   If ! Empty(Subs(_cLine,_nPos,_aVetor[_nX2,3]))
      _uConteudo:= Subs(_cLine,_nPos,_aVetor[_nX2,3])
      If ( _aVetor[_nX2,2] == 'N' )
         _uConteudo := val(_uConteudo)
         If (_aVetor[_nX2,4] #0)
            _uConteudo := _uConteudo / (10**_aVetor[_nX2,4])
         EndIf
      Elseif ( _aVetor[_nX2,2] == 'D' )
         _uConteudo := CtoD(Right(_uConteudo,2)+"/"+Subs(_uConteudo,5,2)+"/"+subs(_uConteudo,3,2))
      EndIf
      aadd(_aModelo,{_aVetor[_nX2,1],_uConteudo,NIL})    		
   EndIf
   _nPos := _nPos + _aVetor[_nX2,3]
Next

If ( _nIndex > 0 )
   aadd(_aModelo,{"INDEX",_nIndex})
   _nIndex := -1
EndIf

Return

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chamada da Funcao Mod1                                Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Static Function Mod1()
ProximaL()
LeLinha()

While !Left(_cLine,3) == "FIM"
   If Empty(_cLine)
      Return
   EndIf  
   If ( AllTrim(Left(_cLine,8)) $ _cListMod1 )
      _cProg:=AllTrim(Left(_cLine,8) )
      Mod1()
      Exit
   Elseif ( AllTrim(Left(_cLine,8)) $ _cListMod2 )
      _cProg:=AllTrim(Left(_cLine,8) )
      Mod2()
      Exit
   EndIf
   _nOpcao := Val(SubS(_cLine,2,1))
   If ( _nOpcao == 5 )
      _cRdmake := "DELVETOR"
   Elseif ( _nOpcao == 4 )
      _cRdmake := "ALTVETOR"
   Elseif ( _nOpcao == 3 )
      _cRdmake := "INCVETOR"
   EndIf
   _aVetor:=ExecBlock(_cRdmake,.F.,.F.,"_a"+_cProg)
   
   aFillModelo()
   
   If (_cProg == "MATA240")
      Mata240(_aModelo)
   ElseIf (_cProg == "MATA150")
      Mata150(_aModelo)
   ElseIf (_cProg == "MATA250")
      Mata250(_aModelo)
   ElseIf (_cProg == "MATA680")
      Mata680(_aModelo)
   ElseIf (_cProg == "MATA681")
      Mata681(_aModelo)
   ElseIf (_cProg == "MATA270")
      Mata270(_aModelo)
   ElseIf (_cProg == "FINA040")
      Fina040(_aModelo)
   ElseIf (_cProg == "FINA050")
      Fina050(_aModelo)	  
   ElseIf (_cProg == "MATA010")
      MATA010(_aModelo,_nOpcao)	  
   ElseIf (_cProg == "MATA020")
      MATA020(_aModelo,_nOpcao)	  		
   ElseIf (_cProg == "MATA030")
      MATA030(_aModelo,_nOpcao)
   ElseIf (_cProg == "MATA040")
      MATA040(_aModelo,_nOpcao)
   ElseIf (_cProg == "MATA050")
      MATA050(_aModelo)
   ElseIf (_cProg == "MATA080")
      MATA080(_aModelo)
   ElseIf (_cProg == "QIEA030")
      QIEA030(_aModelo)
   Elseif (_cProg == "ALTSB1")
      ExecBloc("ALTSB1",,,_aModelo)
   ElseIf (_cProg == "MATA520")
      MATA520(_aModelo) 
   Elseif (_cProg == "ALTSB1")
      ExecBloc("ALTSB1",,,_aModelo)
   EndIf
   ProximaL()
   LeLinha()
Enddo

Return
   
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chamada da Mod2                                       Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Static Function Mod2()
_aCab   := {}
_aItens := {}
_cTipo  := ""

ProximaL()
LeLinha()

While ! Left(_cLine,3) == "FIM"
   _cTipo := Left(_cLine,1)
   If Empty(_cLine) 
      Return  
   EndIf  
   _nOpcao := Val(SubS(_cLine,2,1))
   If ( _nOpcao == 5 )
      _cRdmake := "DELVETOR"
   Elseif ( _nOpcao == 4 )
      _cRdmake := "ALTVETOR"
   Elseif ( _nOpcao == 3 )
      _cRdmake := "INCVETOR"
   EndIf
   If (_cTipo == "H")
      _aVetor := ExecBlock(_cRdmake,.F.,.F.,"_a"+_cProg+"Cab")
      aFillModelo()
      _aCab := aClone(_aModelo)
   Elseif ( _cTipo == "D")
      _aVetor:=ExecBlock(_cRdmake,.F.,.F.,"_a"+_cProg+"Itens")
      aFillModelo()
      aadd(_aItens,aClone(_aModelo))
   EndIf	  

   ProximaL()
   LeLinha()
	
   If ( AllTrim(Left(_cLine,8))  $ _cListMod1 )
      _cProg:=AllTrim(Left(_cLine,8) )
      Mod1()
      Exit
   ElseIf ( AllTrim(Left(_cLine,8)) $ _cListMod2 )
      _cProg:=AllTrim(Left(_cLine,8) )
      Mod2()
      Exit
   EndIf
   If (( _cTipo == "D" .and. Left(_cLine,1) $ "HT")) .or. Left(_cLine,3) == 'FIM'
      If (_cProg == "MATA140") 
          Mata140(_aCab,_aItens)
      Elseif (_cProg == "MATA241") 	   
          Mata241(_aCab,_aItens)
      Elseif (_cProg == "MATA410") 	   
          Mata410(_aCab,_aItens)
      Elseif (_cProg == "MATA415")         
          Mata415(_aCab,_aItens)
      Elseif (_cProg == "MATA416") 	   
          Mata416(_aCab,_aItens)
      Elseif (_cProg == "CONA050") 	   
          Cona050(,_aCab,_aItens)
      Elseif (_cProg == "MATA110")
          Mata110(_aCab,_aItens) 
      Elseif (_cProg == "MATA120")
          Mata120(1,_aCab,_aItens,_nOpcao) 
      ElseIf (_cProg == "CFGX016")
          CFGX016(_aCab,_aItens)
      ElseIf (_cProg == "MATA265")
          MATA265(_aCab,_aItens,_nOpcao) 
      ElseIf (_cProg == "MATA115")
          MATA115(_aCab,_aItens)
      EndIf
      _aCab   := {}
      _aItens := {}
   EndIf
Enddo

Return


//зддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Carrega o texto                                       Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Static Function CarregaTXT()
If (_nHa := FT_FUse(AllTrim(_cArquivo))) == -1
   Help(" ",1,"NOFILEIMPOR")
   Return
EndIf

FT_FGOTOP()

While !FT_FEOF()
   AADD(_atxt,FT_FREADLN())
   FT_FSKIP()
Enddo

FT_FUSE()

Return

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chamada da Funcao ProximaL                            Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Static Function ProximaL()
_nPTxt := _nPTxt + 1                                   
_nPTxt := If(_nPtxt > Len(_aTxt),Len(_aTxt),_nPTxt)	

Return

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chamada da Funcao LeLinha                             Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Static Function LeLinha()
_cLine:= _aTxt[_nPTxt]

Return
