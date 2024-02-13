#include 'Ap5Mail.ch'

User Function MEmail()

Local cServer   := "servidor" // substituir por servidor de e-mail
Local cAccount  := 'conta'    // substituir por conta de e-mail
Local cEnvia    := 'email@microsiga.com.br' // substituir por quem envia o e-mail
Local cRecebe   := 'email@microsiga.com.br' // substituir por quem recebe o e-mail
Local cPassword := 'senha'    // substituir pela senha da conta
Local aFiles    := {}
Local nI        := 1
Local cMensagem := ''
Local cTos
Local CRLF      := Chr(13) + Chr(10)

cMensagem := 'Teste de mensagem, com arquivo anexo.' + CRLF +;
             'Segunda Linha'
 
CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword Result lConectou

If lConectou
	Alert("Conectado com servidor de E-Mail - " + cServer)
Endif

aFiles := { "\SigaAdv\SigaFat.Mnu", "\SigaAdv\SigaFin.Mnu" }

If MsgYesNo("Envia Atachado")
   SEND MAIL FROM cEnvia;
	     TO cRecebe;
	     SUBJECT 'Email pelo Protheus' ;
	     BODY cMensagem ;
        ATTACHMENT aFiles[1], aFiles[2];
	     RESULT lEnviado
Else	     
	SEND MAIL FROM cEnvia;
	     TO cRecebe;
	     SUBJECT 'Email pelo Protheus';
	     BODY cMensagem;
	     RESULT lEnviado
Endif	     

If lEnviado
	Alert("Enviado E-Mail")
Else
	cMensagem := ""
	GET MAIL ERROR cMensagem 
	Alert(cMensagem)
Endif
   
DISCONNECT SMTP SERVER Result lDisConectou

If lDisConectou
	Alert("Desconectado com servidor de E-Mail - " + cServer)
Endif

Return
