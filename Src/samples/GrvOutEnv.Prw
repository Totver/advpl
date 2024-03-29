#Include "RwMake.Ch"

/*/
�����������������������������������������������������������������������������������������
����������������������������������������������������������������������������������������
������������������������������������������������������������������������������������Ŀ��
���Rotina    � GrvOutEnv  � Autor �Wagner Mobile Costa       	    � Data �05/03/2001���
������������������������������������������������������������������������������������Ĵ��
���Descri��o � Faz a gravacao dos dados na base de replica                           ���
������������������������������������������������������������������������������������Ĵ��
���Sintaxe   � GrvOutEnv(ParC1, ParA2)                                     			 ���
������������������������������������������������������������������������������������Ĵ��
���Parametros� ParC1 - Tabela onde serao gravado os dados                         	 ���
���          � ParA2 - Matriz contendo os dados a serem gravados      					 ���
���          � { { Nome do campo, conteudo a ser gravado }, ... }           		    ���
������������������������������������������������������������������������������������Ĵ��
���Observacao� DEVE ESTAR COMPILADO no REPOSITORIO onde os DADOS SERAO GRAVADOS      ���
�������������������������������������������������������������������������������������ٱ�
����������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������
/*/

User Function GrvOutEnv(cTabela, aGravar)

Local nCampos, nGravar

DbSelectArea(cTabela)
For nGravar := 1 To Len(aGravar)
	RecLock(cTabela, .T.)

	For nCampos := 1 To Len(aGravar[nGravar])
		Replace &(aGravar[nGravar][nCampos][1]) With aGravar[nGravar][nCampos][2]
	Next
	DbCommit()
Next	

Return .T.