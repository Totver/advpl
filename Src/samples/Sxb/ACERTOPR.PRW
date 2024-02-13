#include "rwmake.ch"        

User Function AcertoPr()    

SetPrvt("_Reg,_Chave,_Campos,_Registro,_n")

DbSelectArea("SB1")
DbSetOrder(1)
DbGoTop()
_Campos:={"B1_FILIAL" ,"B1_COD"    ,"B1_DESC"  ,"B1_cGRD"  ,"B1_CSEQ"   ,"B1_REF"   ,;
          "B1_GRPMAR" ,"B1_SGRPMAR","B1_CLASSE","B1_TIPO"  ,"B1_UM"     ,"B1_PROC"  ,;
          "B1_LOJPROC","B1_LOCPAD" ,"B1_TE"    ,"B1_TS"    ,"B1_GRADE"  ,"B1_TECIDO",;
          "B1_PADRAOT","B1_MANGA"  ,"B1_GRIFFE","B1_MERCAD","B1_INVERNO","B1_FABRIC"}
          
While !Eof()
      _Reg := Recno()
      _Registro:={}
      For _n := 1 to Len(_Campos)
          AaDd(_Registro,SB1->(FieldGet(FieldPos(_Campos[_n]))))
      Next _n    
      _Chave := SubStr(SB1->B1_COD,1,6)+Replicate(" ",Len(SB1->B1_COD)-6)
      
      If !DbSeek(xFilial("SB1")+_Chave)
         _Registro[2]:=_Chave
         Reclock("SB1",.T.)
         For _n := 1 To Len(_Campos)
             FieldPut(FieldPos(_Campos[_n]),_Registro[_n])
         Next _n    
         MsUnLock()

      EndIf

      DbGoTo(_Reg)
      DbSkip()
End-While       

MsgStop("Final da Rotina")

Return()