#Include "RwMake.Ch"
#Include "TbiConn.Ch"

/*/
����������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������Ŀ��
���Rotina    � Rpc        � Autor �Wagner Mobile Costa            � Data �05/03/2001���
�����������������������������������������������������������������������������������Ĵ��
���Descri��o � Faz gravacao em outra environment                                    ���
�����������������������������������������������������������������������������������Ĵ��
���          �                                                                  	   ���
������������������������������������������������������������������������������������ٱ�
���������������������������������������������������������������������������������������
����������������������������������������������������������������������������������������
/*/

User Function Rpc

Local oServer, aGravar

CREATE RPCCONN oServer ON SERVER "LocalHost";
  		 PORT 1024 ENVIRONMENT "Environment";
		 EMPRESA "01" FILIAL "01"

PREPARE ENVIRONMENT IN SERVER oServer EMPRESA cEmpresa FILIAL cFilialC;
		  TABLES SD2, SF2

DbSelectArea("SF2")
DbGoTop()
aGravar := Array(FCount())
For nIndice := 1 To FCount()
	aGravar[nIndice] := { FieldName(nIndice), FieldGet(nIndice) }
Next

oServer:CallProc("U_GrvOutEnv", aGravar)

RESET ENVIRONMENT IN SERVER oServer
CLOSE RPCCONN oServer

Return .T.

/*/
�����������������������������������������������������������������������������������������
����������������������������������������������������������������������������������������
������������������������������������������������������������������������������������Ŀ��
���Rotina    � GrvOutEnv  � Autor �Wagner Mobile Costa       	    � Data �05/03/2001���
������������������������������������������������������������������������������������Ĵ��
���Descri��o � Faz a gravacao dos dados na base de replica                           ���
������������������������������������������������������������������������������������Ĵ��
���Sintaxe   � GrvOutEnv(ParA2)                                                      ���
������������������������������������������������������������������������������������Ĵ��
���Parametros� ParA1 - Matriz contendo os dados a serem gravados                     ���
���          � { { Nome do campo, conteudo a ser gravado }, ... }           		    ���
������������������������������������������������������������������������������������Ĵ��
���Observacao� DEVE ESTAR COMPILADO no REPOSITORIO onde os DADOS SERAO GRAVADOS      ���
�������������������������������������������������������������������������������������ٱ�
����������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������
/*/

User Function GrvOutEnv(aGravar)

Local nCampos, nGravar

DbSelectArea("SF2")
RecLock("SF2", .T.)

For nCampos := 1 To Len(aGravar)
	Replace &(aGravar[nCampos][1]) With aGravar[nCampos][2]
Next

DbCommit()

Return .T.