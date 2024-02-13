
 /*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Programa ³ LJENV001 ³ Autor ³    Alexandro Dias     ³ Data ³ 09.03.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Envio de arquivos.                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/   
User Function LJENV001()

Processa( {|| U_GeraArq() } )

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ GeraArq  ³ Autor ³    Alexandro Dias     ³ Data ³ 09.03.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Gera as movimentacoes dos arquivos contidos na tabela H1.  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function GeraArq()
Local cPre := "XX"
Local _cPath      		:=  Alltrim(GetMv("MV_LJENVIA"))
Local _cLjSeq     		
Local cArjArq 	:= ''
Local cComando 	:= ''

dbSelectArea("SX6")
dbSetOrder(1)
If dbSeek("  MV_LJSEQ  ", .t.)                           
	_cLjSeq     	:=  SubStr(SM0->M0_CODFIL,1,1) + AllTrim(SX6->X6_CONTEUD)
	RecLock("SX6", .F.)
	SX6->X6_CONTEUD := StrZero( Val(SubStr(_cLjSeq,2,5)) + 1, 5)
	MsUnLock()
End

do case
   	Case SM0->M0_CODFIL	== "01"
   		cPre := 	"MZ"
   	Case SM0->M0_CODFIL	== "11"	         
		cPre := 	"P1"    	
	Case SM0->M0_CODFIL	== "22"	         
		cPre := 	"P2"    				
	Case SM0->M0_CODFIL	== "33"	         
		cPre := 	"P3"    		
	Case SM0->M0_CODFIL	== "44"	         
		cPre := 	"MC"    		
	Case SM0->M0_CODFIL	== "55"	         
		cPre := 	"OR"    				
	Otherwise
	 	cPre :=		"XX"
Endcase 	

//cArjArq 	:=_cPath+cPre+strzero(day(date()),2)+strzero(month(date()),2)+substr(strzero(year(date()),4),3,2)+'.ARJ'

cArjArq 	:=_cPath+cPre+_cLjSeq+".arj"

If File(cArjArq)
	If SimNao("Transferencia ja' realizada hoje ! Continua ?",,,,,"Atencao") # "S" 
		Return
	Endif
Endif     

DbSelectArea("SX5")
DbSetOrder(1)      
Set SoftSeek On
DbSeek(xFilial("SX5")+"H1")
Set Softseek OFF

ProcRegua(Len(SX5->X5_DESCRI)/2)

_aTabAlias := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ 1 - Alias do Arquivo             ³
//³ 2 - Descricao do Arquivo         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Alimenta _aTabAlias com os arquivos a serem processados.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   While !Eof() .and. SX5->X5_FILIAL == xFilial("SX5") .and.  SX5->X5_TABELA == "H1"

         SX2->( DbSetOrder(1) )
         SX2->( DbSeek(Alltrim(SX5->X5_CHAVE)) )

         AAdd( _aTabAlias,{ Alltrim(SX5->X5_CHAVE) ,SX2->X2_NOME } )

         IncProc("Armazenando Tabelas...")

     DbSkip()

   EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processa a geracao dos arquivos contidos em _aTabAlias       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   For _xCnt := 1 to Len(_aTabAlias)

        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³ Inicializacao das variaveis.                                 ³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        
          _xRegua     		:=  0
          _Msg        		:=  _aTabAlias[_xCnt,1]+" - "+Substr(_aTabAlias[_xCnt,2],1,1)+Lower(Substr(_aTabAlias[_xCnt,2],2,Len(_aTabAlias[_xCnt,2])))
          _xAliasSiga 		:=  _aTabAlias[_xCnt,1]
          _cArqDbfTmp 		:=  "TMP"+_xAliasSiga+SM0->M0_CODFIL
          _cArqNtxTmp 		:=  CriaTrab(Nil,.F.)
                  
          IF "S" == Substr(_xAliasSiga,1,1)
             _cCpoLGI  := Substr(_xAliasSiga,2,2) + "_USERLGI"
             _cCpoLGA  := Substr(_xAliasSiga,2,2) + "_USERLGA"
             _cIndCond := Substr(_xAliasSiga,2,2) + "_FILIAL"
          Else
             _cCpoLGI    := _xAliasSiga + "_USERLGI"
             _cCpoLGA    := _xAliasSiga + "_USERLGA"
             _cIndCond   := _xAliasSiga + "_FILIAL"
          EndIF
        
          Ferase(_cPath+_cArqDbfTmp+".DBF")
          DbSelectArea(_xAliasSiga)
       //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
       //³ Cria campo para identificar os registros deletados.                               ³
       //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
          _aStruct := DbStruct()
          AAdd(_aStruct,{"DELETADO","C",1,0})
       //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
       //³ Avalia se o arquivo em questao tem os campos de controle de inclusao e alteracao. ³
       //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
          _xOkLGI := aScan( _aStruct,{ |x| Alltrim(x[1]) == Alltrim(_cCpoLGI) } )
          _xOkLGA := aScan( _aStruct,{ |x| Alltrim(x[1]) == Alltrim(_cCpoLGA) } )
       //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
       //³ So processa os arquivos caso o mesmo tenha os campos de controle                  ³
       //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
          IF _xOkLGI != 0 .and. _xOkLGA != 0

                ProcRegua(200)

                DbCreate(_cPath+_cArqDbfTmp,_aStruct)
                DbUseArea(.T.,,_cPath+_cArqDbfTmp,_cArqDbfTmp,.F.,.F.)
               //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
               //³ Permite visualizar inclusive os registros deletados do arquivo.                   ³
               //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                DbSelectArea(_xAliasSiga)
                Set(11,"OFF")
              //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
              //³ Filtra os registros alterados ou incluidos.                  ³
              //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                _cCond  :=	' ('+_cCpoLGI+' != "'+Space(17)+'" .or. '+_cCpoLGA+' != "'+Space(17)+'") .And. '+;
                			substr(_xAliasSiga,2,2)+'_filial = xfilial("'+ _xAliasSiga +'")'
                IndRegua(_xAliasSiga,_cArqNtxTmp,_cIndCond,,_cCond,"Seleciona tabela, "+_Msg)
                DbGoTop()

                While !Eof()                               
                

                      DbSelectArea(_cArqDbfTmp)
                    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                    //³ Inclui os registro no arquivo temporario, inclusive os deletados. ³
                    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					  RecLock(_cArqDbfTmp,.T.)

                          _xRegDelet := ""

                          For _xCampo := 1 to Len(_aStruct)

                            DbSelectArea(_xAliasSiga)
                            _xConteudo := FieldGet(_xCampo)

                            IF Deleted()
                               _xRegDelet := "S"
                            EndIF

                            DbSelectArea(_cArqDbfTmp)
                            FieldPut(FieldPos(_aStruct[_xCampo][1]),_xConteudo )

                          Next

                        FieldPut(FieldPos(_aStruct[Len(_aStruct)][1]),_xRegDelet)

                      MsUnLock()
      
                    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                    //³ Limpa os campos que identifica se os registros foram alterados ou incluidos. ³
                    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                      DbSelectArea(_xAliasSiga)
                      RecLock(_xAliasSiga,.F.)
                         FieldPut(FieldPos(_cCpoLGI),"" )
                         FieldPut(FieldPos(_cCpoLGA),"" )
                      MsUnLock()

                      DbSkip()
 
                    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                    //³ Atualiza regua de processamemnto.                 ³
                    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                      IncProc( _Msg )
                      _xRegua := _xRegua + 1

                      IF _xRegua >= 199
                         ProcRegua(200)
                         _xRegua := 0
                      EndIF

                EndDo

                DbClearFilter()

                DbSelectArea(_cArqDbfTmp)
                DbCloseArea()
          Else
              MsgAlert("Nao existe os campos de controle da tabela, "+_Msg,"Aten‡Æo","INFO")
          EndIF

        Ferase(_cArqNtxTmp+OrdBagExt())

   Next
 //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 //³ Restaura os indices dos arquivos.                    ³
 //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    ProcRegua( Len(_aTabAlias) )
    For _xCnt := 1 to Len(_aTabAlias)
        DbSelectArea( _aTabAlias[_xCnt,1] )
        Set(11,"ON")
        RetIndex( _aTabAlias[_xCnt,1] )
        _Msg := _aTabAlias[_xCnt,1]+" - "+Substr(_aTabAlias[_xCnt,2],1,1)+Lower(Substr(_aTabAlias[_xCnt,2],2,Len(_aTabAlias[_xCnt,2])))
        IncProc("Reindexando "+ _Msg )
    Next               
    cComando :=	'ARJ M P:\AP5'+cArjarq+' P:\AP5'+_cPath+'TMP???'+SM0->M0_CODFIL+'.* -jm' 		
    WinExec(cComando)
    cTexto	:= "Transferencia - OK"+chr(13)+chr(13)+"Arquivos Atualizados :"+chr(13)
    For n:=1	to Len(_aTabAlias)
    	cTexto += "TMP"+_aTabAlias[n,1]+SM0->M0_CODFIL+".DBF "+_aTabAlias[n,2]+chr(13)
    Next
    cTexto += chr(13)+"Arquivo para transferencia : \AP5"+cArjArq+chr(13)	
    MsgAlert(cTexto)
  
Return

