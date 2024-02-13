#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 15/09/00

User Function Impfor2()        // incluido pelo assistente de conversao do AP5 IDE em 15/09/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_NAREAANT,_NRECANT,_NORDANT,_CCOD,_CTEL,_CFAX")
SetPrvt("_TCGC,_TINS,")

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³IMPFOR2   ³ Autor ³ Henio Brasil Claudino ³ Data ³ 23.09.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Importa‡ao de base de Dados de Cadastro de Fornecedores     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³RDMake <Programa.Ext> -w                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Cliente  ³Especifico SEMP TOSHIBA INFORMATICA                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#IFDEF WINDOWS
    Processa( {|| Gera() } )// Substituido pelo assistente de conversao do AP5 IDE em 15/09/00 ==>     Processa( {|| Execute(Gera) } )
#ELSE
    Gera()
#ENDIF
Return

//----------------------------------------------------------
// Substituido pelo assistente de conversao do AP5 IDE em 15/09/00 ==> Function GERA
Static Function GERA()


_nAreaAnt := Alias()
_nRecAnt  := recno()
_nOrdAnt  := indexord()

If ! File("CadFor.Dbf")
   DbCreate("CadFor", { { "Cod_For", "C", 06, 0},;
                        { "Nom_For", "C", 30, 0},;
                        { "Cgc_For", "C", 14, 0},;
                        { "Ins_For", "C", 20, 0},;
                        { "End_For", "C", 50, 0},;
                        { "Bai_For", "C", 50, 0},;
                        { "Cid_For", "C", 50, 0},;
                        { "Est_For", "C", 50, 0},;
                        { "Cep_For", "C", 50, 0},;
                        { "Tel_Fon", "C", 08, 0},;
                        { "Tel_Fax", "C", 08, 0},;
                        { "Con_Tat", "C", 50, 0},;
                        { "Cod_Con", "C", 20, 0} })
   Use CADFOR alias CAD Exclusive new
   RecLock("CAD", .T.)
   Replace Cod_For With "1",;
           Nom_For With "Nome",;
           Cgc_For With "99999999999962"
   MsUnLock()
   DbCloseArea()                                              
Endif

IF .F.
   Use CADFOR alias CAD Exclusive new
   Index on cod_for to Forcodi
   DbSelectArea("CAD") 
   Dbgotop()
Endif

Do While .F. // !eof()
   _cCod := strzero( val(CAD->cod_for),6 )
   _tCgc := if(!empty(CAD->cgc_for), left(CAD->cgc_for,2)+subs(CAD->cgc_for,4,3) + ;
            subs(CAD->cgc_for,8,3)+subs(CAD->cgc_for,12,4)+right(CAD->cgc_for,2), space(14))

   _tIns := if(!empty(CAD->ins_for), left(CAD->ins_for,3)+subs(CAD->ins_for,5,3) + ;
            subs(CAD->ins_for,8,3)+subs(CAD->ins_for,9,3)+right(CAD->ins_for,3), space(18))

   DbselectArea("SA2")
   DbSetOrder(1) 

   Reclock("SA2",.T.)
   Replace A2_COD     with  _cCod
   Replace A2_LOJA    with  "01"  
   Replace A2_NOME    with  CAD->nom_for
   Replace A2_NREDUZ  with  left(CAD->nom_for,20) 
   Replace A2_TIPO    with  "J" 
   Replace A2_END     with  CAD->end_for
   Replace A2_MUN     with  left(CAD->cid_for,15) 
   Replace A2_EST     with  CAD->est_for
   Replace A2_BAIRRO  with  CAD->bai_for
   Replace A2_CEP     with  CAD->cep_for
   Replace A2_TEL     with  CAD->tel_fon
   Replace A2_FAX     with  CAD->tel_fax
   Replace A2_CONTATO with  CAD->con_tat
   Replace A2_CGC     with  _tCgc
   Replace A2_INSCR   with  _tIns
   Replace A2_CONTA   with  CAD->cod_con
   Msunlock()

   DbSelectArea("CAD")
   Dbskip() 
Enddo

Use supplier alias SUP Exclusive New
DbSelectArea("SUP") 
Dbgotop()
                 
_cCod:=1

Do While !eof()
   // _cCod := strzero( val(CAD->cod_for),6 )
   // _cTel := left(CAD->TEL1,6)+right(CAD->TEL1,9) 
   // _cFax := left(CAD->FAX,6)+right(CAD->FAX,9)
   // _tCgc := if(!empty(CAD->cgc_for), left(CAD->cgc_for,2)+subs(CAD->cgc_for,4,3) + ;
   //          subs(CAD->cgc_for,8,3)+subs(CAD->cgc_for,12,4)+right(CAD->cgc_for,2), space(14))
   // _tIns := if(!empty(CAD->ins_for), left(CAD->ins_for,3)+subs(CAD->ins_for,5,3) + ;
   //         subs(CAD->ins_for,8,3)+subs(CAD->ins_for,9,3)+right(CAD->ins_for,3), space(18))

   _cCod:= _cCod + 1
   _cCod:= StrZero(_cCod,6)
   
   DbselectArea("SA2")
   DbSetOrder(1) 

   Reclock("SA2",.T.)
   Replace A2_COD     with  _cCod
   Replace A2_LOJA    with  "01"  
   Replace A2_NOME    with  SUP->SP_SUPPLIE
   Replace A2_NREDUZ  with  SUP->SP_ABREVIA 
   Replace A2_TIPO    with  "X"      			// por tratar-se de importacao
   Replace A2_END     with  SUP->SP_ADDRESS
   Replace A2_MUN     with  SUP->SP_CITY 
   Replace A2_EST     with  "EX"				// Estado padrao do Siga
   Replace A2_EST_EX  with  SUP->SP_STATE   	// CRIAR - Estado Original Estrangeiro - Customizado
// Replace A2_BAIRRO  with  SUP->SP_
   Replace A2_CEP     with  SUP->SP_ZIPCOD
   Replace A2_PAIS	  with  SUP->SP_COUNTRY
   Replace A2_TEL     with  SUP->SP_PABX
   Replace A2_TEL_FRE with  SUP->SP_TOLL_FR	 	// CRIAR - Numero para 0800
   Replace A2_FAX     with  SUP->SP_FACSMIL
   Replace A2_PRODUTO with  SUP->SP_PRODUCT	    // CRIAR - Campo Memo para breve descricao dos produtos

   Replace A2_HPAGE   with  SUP->SP_WEB_PAG       
   Replace A2_EMAIL   with  SUP->SP_GENERAL

// Campos referentes ao contato
   Replace A2_CONTATO with  SUP->SP_MAIN_CO
   Replace A2_TEL_CON with  SUP->SP_PHONE   	// CRIAR - telefone contato
   Replace A2_FAX_CON with  SUP->SP_FAX     	// CRIAR - fax contato
   Replace A2_MAILCON with  SUP->SP_EMAIL 		// CRIAR - e-mail contato
  
// Replace A2_        with  SUP->SP_   
// Replace A2_        with  SUP->SP_  
// Replace A2_CGC     with  SUP->SP_
// Replace A2_INSCR   with  SUP->SP_
// Replace A2_CONTA   with  SUP->SP_

   Msunlock()

   DbSelectArea("SUP")
   Dbskip() 
Enddo 

DbselectArea("SA2")

msgstop(" Final da Importacao !") 

DbSelectArea(_nAreaAnt)    // volta … area que estava antes aberta
DbSetOrder(_nOrdAnt)
DbGoto(_nRecAnt)

// Substituido pelo assistente de conversao do AP5 IDE em 15/09/00 ==> __Return()
Return()        // incluido pelo assistente de conversao do AP5 IDE em 15/09/00
