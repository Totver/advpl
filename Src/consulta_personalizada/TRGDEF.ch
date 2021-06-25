//----------------------------------------------------------
/*/{Protheus.doc} CRMDEF()
 
Fonte que reuni todos os Defines do modulo CRM
Criado para evitar repetiçções de define, impor um padrão para o desenvolvimento

@param	   nehnum
       
@return   verdadeiro/falso

@author   Victor Bitencourt
@since    26/02/2014
@version  12.0
/*/
//----------------------------------------------------------

// Array de informações do usuario do exchange
#DEFINE _PREFIXO    2
#DEFINE _LCRMUSR    3
#DEFINE _Usuario    1
#DEFINE _SenhaUser  2 
#DEFINE _Agenda     3
#DEFINE _DtAgeIni   4
#DEFINE _DtAgeFim   5
#DEFINE _Tarefa     6
#DEFINE _DtTarIni   7
#DEFINE _DtTarFim   8
#DEFINE _EndEmail   9
#DEFINE _Contato    10
#DEFINE _Habilita   11
#DEFINE _TipoPerAge 12
#DEFINE _TipoPerTar 13
#DEFINE _TimeMin    14
#DEFINE _BiAgenda   15
#DEFINE _BiTarefa   16
#DEFINE _BiContato  17	

//Status existentes para Atividades
#DEFINE STNAOINICIADO  "1" 
#DEFINE STEMANDAMENTO  "2"
#DEFINE STCONCLUIDO    "3"
#DEFINE STAGUADOUTROS  "4"
#DEFINE STADIADA       "5"
#DEFINE STPENDENTE     "6"
#DEFINE STENVIADO      "7"
#DEFINE STLIDO         "8"
#DEFINE STCANCELADO    "9"

//Tipos de Atividades
#DEFINE TPTAREFA       "1"
#DEFINE TPCOMPROMISSO  "2"
#DEFINE TPEMAIL        "3"

//Rotinas 
#DEFINE RESPECIFICACAO   1
#DEFINE RATIVIDADE       2
#DEFINE RCONEXAO         3
#DEFINE RANOTACOES       4
#DEFINE REMAIL           5
#DEFINE RCEMAIL          6

// Parâmetros dos Filtros 
#DEFINE ADDFIL_TITULO		1	// Título que será exibido no filtro.
#DEFINE ADDFIL_EXPR			2	// Expressão do filtro em AdvPL ou SQL ANSI.
#DEFINE ADDFIL_NOCHECK		3	// Indica que o filtro não poderá ser marcado/desmarcado.
#DEFINE ADDFIL_SELECTED		4	// Indica que o filtro deverá ser apresentado como marcado/desmarcado. 
#DEFINE ADDFIL_ALIAS		5	// Indica que o filtro é de relacionamento entre as tabelas.
#DEFINE ADDFIL_FILASK		6	// Indica se o filtro pergunta as informações na execução.
#DEFINE ADDFIL_FILPARSER	7	// Array contendo informações parseadas do filtro. 
#DEFINE ADDFIL_ID			8	// Nome do identificador do filtro.                        

//Permissionamento do Controle de Acesso
#DEFINE PERM_CODUSR		1 
#DEFINE PERM_CONTROLE_TOTAL	2
#DEFINE PERM_VISUALIZAR 	3
#DEFINE PERM_EDITAR	 	4                 
#DEFINE PERM_EXCLUIR	 	5
#DEFINE PERM_COMPARTILHAR	6


//Controle do Papel do Usuario
#DEFINE USER_PAPER_CODUSR		1
#DEFINE USER_PAPER_SEQUEN	 	2 
#DEFINE USER_PAPER_CODPAPER		3
#DEFINE USER_PAPER_CODUND	 	4
#DEFINE USER_PAPER_CODEQP	 	5
#DEFINE USER_PAPER_CODVEND	 	6
#DEFINE USER_PAPER_IDESTN	 	7
#DEFINE USER_PAPER_NVESTN	 	8

//----------------------------------------------------
//	 Defines usadas na integração do Umov.ME no CRM 
//----------------------------------------------------

// Tipos de tarefas no Umov.Me
#DEFINE _CHECKIN  "1"
#DEFINE _CHECKOUT "2"
#DEFINE _CANCELAT "3"

// Campos Padrao do Arquivo
#DEFINE _ATIV_OPER       1
#DEFINE _ATIV_IDUNICO    2
#DEFINE _ATIV_DATAHORA   5
#DEFINE _ATIV_CODENT     6
#DEFINE _ATIV_LOCAL      8
#DEFINE _ATIV_LOCALNUM   9
#DEFINE _ATIV_LATITUDE   10
#DEFINE _ATIV_LONGITUDE  11
#DEFINE _ATIV_CODUSR     12
#DEFINE _ATIV_TIPO       15


// Campos Customizados do Check-in
#DEFINE _CHKIN_DATA      20
#DEFINE _CHKIN_HORA      21
#DEFINE _CHKIN_ASSUNT    22


// Campos Customizados do Check-out
#DEFINE _CHKOUT_IDITENS  18
#DEFINE _CHKOUT_DATA     28
#DEFINE _CHKOUT_HORA     29
#DEFINE _CHKOUT_FEELING  30
#DEFINE _CHKOUT_VLPREV   31
#DEFINE _CHKOUT_DTEXPEC  32
#DEFINE _CHKOUT_NEGOBS   33
#DEFINE _CHKOUT_OBSERV   34


// Campos Customizados do Cancelar
#DEFINE _CANCEL_DATA     20
#DEFINE _CANCEL_HORA     21
#DEFINE _CANCEL_OBSERV   22


// Campos do Possivel Cliente
#DEFINE _PSSCLIENT_TIPO   20
#DEFINE _PSSCLIENT_NOME   21
#DEFINE _PSSCLIENT_DDD    22
#DEFINE _PSSCLIENT_TEL    23
#DEFINE _PSSCLIENT_EMAIL  24
#DEFINE _PSSCLIENT_ESTAD  25
#DEFINE _PSSCLIENT_MUN    26 
#DEFINE _PSSCLIENT_ENDER  27
#DEFINE _PSSCLIENT_OBS    28
#DEFINE _PSSCLIENT_FOTO   29

