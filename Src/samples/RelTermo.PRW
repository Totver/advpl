/*
+-----------------------------------------------------------------------+
¦Programa  ¦RelTermo   ¦ Autor ¦ Alecio Ferreira       ¦Data ¦04.10.2000¦
+----------+------------------------------------------------------------¦
¦Descriçào ¦ Termo de recebimento do imovel                             ¦
+----------+------------------------------------------------------------¦
¦ Uso      ¦ ESPECIfICO PARA TEndA                                      ¦
+-----------------------------------------------------------------------¦
¦           ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL            ¦
+-----------------------------------------------------------------------¦
¦PROGRAMADOR ¦ DATA   ¦ MOTIVO DA ALTERACAO                             ¦
+------------+--------+-------------------------------------------------¦
¦            ¦        ¦                                                 ¦
+-----------------------------------------------------------------------+
*/
#INCLUDE "rwmake.ch"
#Define CONDENSA CHR(27)+CHR(45)+CHR(48)+CHR(27)+CHR(87)+CHR(48)

User Function RelTermo()

Private CbTxt     := ""
Private CbCont    := ""
Private nOrdem    := 0
Private Alfa      := 0
Private Z         := 0
Private M         := 0
Private tamanho   := "P"
Private limite    := 80 
Private titulo    := "Termo de recebimento do imovel"
Private cDesc1    := "Impressao do temo de recebimento do imovel"
Private cDesc2    := ""
Private cDesc3    := ""
Private aReturn   := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
Private nomeprog  := "RELTERMO"
Private nLastKey  := 0
Private lContinua := .T.
Private nLin      := 0
Private wnrel     := "RELTERMO"
Private cCabec1   := ""
Private cCabec2   := ""
Private lTestConf := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private cbtxt      := SPACE(10)
Private cbcont     := 0
Private m_pag      := 1
Private nMaxiLinh  := 59
Private nContLinh  := 60

Private nLastKey   := 0
Private aStru      := {}
Private cArq       := ""
Private cPerg      := ""
//Private aPerg      := {} 

Private cString := "SZ6"
Private cString := "Sa1"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//Aadd(aPerg,{cPerg,"Contrato ?","C",06,0,"G","","SZ5","","","","",""})

//ExecBlock("TestSX1",.F.,.F.,{cPerg,aPerg})

//Pergunte(cPerg,.F.)

If (nLastKey == 27)
   Return
EndIf
                                                                      
wnrel := SetPrint(cString,wnrel   ,      ,Titulo ,cDesc1,cDesc2,cDesc3,.F.) //,,.T.,tamanho)
//wnrel := SetPrint(cString,NomeProg,cPerg ,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
   Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica Posicao do Formulario na Impressora                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                              ³
//³ Inicio do Processamento da Impressao                         ³
//³                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cCabecalho := "Impressao do Termo de recebimento do imovel"
cMsgRegua  := "Processando "

//   Processa( {|| Execute(FGravArq)} ,cCabecalho,cMsgRegua )

//RptStatus( {|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
//turn

RptStatus( {|| FImprime()},Titulo )

Set Device To Screen
dbCommitAll()
If aReturn[5] == 1
   Set Printer To
   ourspool(wnrel)
Endif

FT_PFLUSH()

Return


Static Function FImprime()

/*

dbSelectArea("SZ1")
dbSetOrder(1)
dbSeek(xFilial("SZ1")+SZ6->Z6_CodEmpr)

dbSelectArea("SZ2")
dbSetOrder(1)
dbSeek(xFilial("SZ2")+SZ6->Z6_CodEmpr+SZ6->Z6_CodBloc)

*/

For xCo := 1 To 1 //2
    nLin := 06
   @ nLin,000 PSAY Padc("TERMO DE RECEBIMENTO DE IMOVEL E GARANTIA DO IMOVEL",80)
   @ nLin,67 PSAY "Cliente/Numero do Contrato" // SZ6->Z6_CodClie+"/"+SZ6->Z6_NumCont
   nLin += 2
	@   nLin,000 PSAY "Termo de recebimento de imovel que entre si fazem de um  lado  como   PROMITENTE"
	@ ++nLin,000 PSAY "VENDEDORA: CONSTRUTORA TENDA S/A.  neste ato representada  de  conformidade  com"
	@ ++nLin,000 PSAY "seus instrumentos sociais; e de outro lado como PROMISSARIO(A) COMPRADOR(A) ...."
   @ ++nLin,000 PSAY "Nome do Cliente." // Alltrim(SZ6->Z6_NomClie)+"."
   nLin ++
   @ ++nLin,000 PSAY "1. DESCRICAO DO IMOVEL"
   @ ++nLin,000 PSAY "     Empreendimento: " // +Alltrim(SZ6->Z6_DesEmpr)+Iif(SZ2->Z2_Classif="C","Casa: ","Apto: ")+SZ6->Z6_CodUnid+" Bloco: "+SZ6->Z6_CodBloc
   @ ++nLin,000 PSAY "                     " // +Alltrim(SZ1->Z1_EndEmpr)+ " - " + SZ1->Z1_BaiEmpr
   @ ++nLin,000 PSAY "                     " // +Alltrim(SZ1->Z1_MunEmpr)+ " - " + SZ1->Z1_EstEmpr

   @ ++nLin,000 PSAY "2. OBJETO DO TERMO: Entrega das chaves do  imovel  descrito,  caracterizado  e"
   @ ++nLin,000 PSAY "determinado no item 01 deste termo."
   @ ++nLin,000 PSAY "3. DISPOSICOES CONDOMINIAIS: O(A) PROMISSARIO(A) COMPRADOR(A) se  obriga,  por"
   @ ++nLin,000 PSAY "si e por seus dependentes, empregados  ou visitantes, a cumprir, as regras  da"
   @ ++nLin,000 PSAY "convencao de condominio, posto que concorda expressamente com  todos  os  seus"
   @ ++nLin,000 PSAY "termos, sem excecao ou disposicao de qualquer especie ou natureza."
   @ ++nLin,000 PSAY "4.  NORMAS  DE  MANUTENCAO  E  CONSERVACAO  DO   IMOVEL:  O(A)  PROMISSARIO(A)"
   @ ++nLin,000 PSAY "COMPRADOR(A)  se  obriga  a  sempre  zelar,  conservar  e manter a unidade e o"
   @ ++nLin,000 PSAY "predio, promovendo o que se fizer necessario,  e  respondendo  pelas omissoes,"
   @ ++nLin,000 PSAY "excessos ou pelos  da nos que causar  a  unidade  a  qualquer  titulo,  dentre"
   @ ++nLin,000 PSAY "outros, os seguintes pontos:"
   @ ++nLin,000 PSAY "4.1 Conservar as esquadrias da unidade (para evitar danos a sua durabilidade e" 
   @ ++nLin,000 PSAY "prevenir infiltracoes), fazendo revisao a cada 3  (treis)  meses,  devidamente"
   @ ++nLin,000 PSAY "comprovada;"
   @ ++nLin,000 PSAY "4.2 Nao ferir a camada impermeabilizante dos boxes dos banheiros, sanitarios e"
   @ ++nLin,000 PSAY "cozinha abaixo do revestimento  do  piso,assim como a camada impermeabilizante"
   @ ++nLin,000 PSAY "das fachadas  do  predio,  que  deverao  ser  reconstituidas  com  manutencoes"
   @ ++nLin,000 PSAY "frequentes, periodicas e comprovadas por pessoas habilitadas;"
   @ ++nLin,000 PSAY "4.3  Rever  atraves  do  condominio,  as  fachadas,  revestimentos, repondo os"
   @ ++nLin,000 PSAY "rejuntes e reparando as fissuras que por ventura vierem ocorrer em decorrencia"
   @ ++nLin,000 PSAY "da acao do tempo (sol, chuva, vento) ou outros fatores devidamente por pessoas"
   @ ++nLin,000 PSAY "habilitadas e comprovado;"
   @ ++nLin,000 PSAY "4.4 Rever a cada 4 (quatro) meses atraves do condominio, a coberta  do predio,"
   @ ++nLin,000 PSAY "a fim de repor danos derivados da acao  do tempo (sol, chuva, vento) ou outros"
   @ ++nLin,000 PSAY "fatores decorrentes a manutencao. Fica sob inteira responsabilidade do sindico"
   @ ++nLin,000 PSAY "o  acesso, manutencao e instalacao de possiveis equipamentos  e/ou  acessorios" 
   @ ++nLin,000 PSAY "em toda area de cobertura a partir  da  entrega das chaves;"
   @ ++nLin,000 PSAY "4.5 Rever frequentemente e atraves do condominio, a laje impermeabilizante dos"
   @ ++nLin,000 PSAY "pavimentos de utilizacao comum;"
   @ ++nLin,000 PSAY "4.6 Caixas hidraulicas pluviais, de esgoto e gordura devem ser limpas e visto-"
   @ ++nLin,000 PSAY "riadas a cada 3 (treis) meses, em sua estrutura e revestimentos internos,  por"
   @ ++nLin,000 PSAY "pessoas habilitadas e devidamente comprovado;"
   @ ++nLin,000 PSAY "4.7 Reparar de imediato e dar manutencoes em qualquer anomalia nas instalacoes"
   @ ++nLin,000 PSAY "eletricas, hidraulicas e telefonicas  que"
   @ ++nLin,000 PSAY "por ventura se fizerem necessarios ou que comprometam a  terceiros  ou  a  boa"
   @ ++nLin,000 PSAY "funcionalidade do mesmo por pessoas devidamente habilitadas e comprovado;"
   @ ++nLin,000 PSAY "4.8 Zelar, conservar e manter todos os equipamentos e acessorios da unidade  e"
   @ ++nLin,000 PSAY "das partes comuns do predio,  promovendo  o seu  uso  adequado  e  fazendo  os"
   @ ++nLin,000 PSAY "necessarios reparos atraves de assistencia tecnica direta dos fabricantes."
   @ ++nLin,000 PSAY "5. VISTORIA: A vistoria do imovel e das partes comuns do edificio foi realiza-"
   @ ++nLin,000 PSAY "da previamente, conforme termo de vistoria anexo, assinado  pelas  partes con-"
   @ ++nLin,000 PSAY "tratantes, e que faz parte integrante deste documento."
   nLin := 05
   @ ++nLin,000 PSAY "6. O cliente recebe neste  ato, juntamente com este  documento,  o  manual  de"
   @ ++nLin,000 PSAY "garantia do objeto em questao."
   @ ++nLin,000 PSAY REPL("-",80)
   @ ++nLin,000 PSAY "Outorgamos o poder especial e especifico de rubricar e assinar as demais  vias" 
   @ ++nLin,000 PSAY "integrantes  deste  documento,  conforme  termo  de  compromisso  assinado  em"
   @ ++nLin,000 PSAY "03/08/99, a PETERSON ROSA QUERINO, brasileiro,  solteiro,  Ger.  Pos-Venda, CI"
   @ ++nLin,000 PSAY "M.5.615.870, CPF: 942.128.486-00, residente e domiciliado  a Rua  Laranjeiras,"
   @ ++nLin,000 PSAY "16, Leblon - Belo Horizonte."
   @ ++nLin,000 PSAY REPL("-",80)
   nLin++
   @ ++nLin,000 PSAY "Belo Horizonte, ______ de ________________  de _________"
   @ ++nLin,000 PSAY REPL("-",80)
   nLin+=3

   @   nLin,000 PSAY "______________________________            ____________________________________"
   @ ++nLin,000 PSAY "   CONSTRUTORA TENDA S/A                          GERENTE DE POS-VENDA"

   nLin+=3

   @   nLin,000 PSAY "                  _____________________________________"
   @ ++nLin,000 PSAY "                       PROMISSARIO(A) COMPRADOR(A)"

   nLin := 06
   @   nLin,000 PSAY PADC("A GARANTIA",80)
   @   nLin,67 PSAY "Cliente/Numero do Contrato" // SZ6->Z6_CodClie+"/"+SZ6->Z6_NumCont
   nLin += 3

   @ ++nLin,000 PSAY "Seu imovel foi construido dentro dos melhores  padroes de engenharia,  visando"
   @ ++nLin,000 PSAY "proporcionar seguranca e conforto aos  moradores. Todas as pecas e  equipamen-"
   @ ++nLin,000 PSAY "tos utilizados foram adquiridos dos  melhores  fabricantes.  O   contrato   de"
   @ ++nLin,000 PSAY "garantia  de construcao estabelece as condicoes de atendimento da  Construtora"
   @ ++nLin,000 PSAY "Tenda S/A."
   nLin++
   @ ++nLin,000 PSAY "1.  OBJETO DA GARANTIA: Objeto da presente garantia e'  a  respectiva  unidade"
   @ ++nLin,000 PSAY "imobiliaria autonoma, bem como as partes comuns do condominio, a que se refere"
   @ ++nLin,000 PSAY "este manual, cuja construcao foi executada por CONSTRUTORA TENDA S/A."
   @ ++nLin,000 PSAY "2.  TERMO INICIAL E FINAL DA GARANTIA."
   @ ++nLin,000 PSAY "2.1 O termo do inicial (inicio da garantia) para os  prazos  aqui  fixados  se"
   @ ++nLin,000 PSAY "conta a partir da entrega do imovel."
   @ ++nLin,000 PSAY "2.2 O termo final (fim da garantia) coincidira  com  a  expiracao  dos  prazos"
   @ ++nLin,000 PSAY "indicados para cada caso, conforme disposto no item 3 (tres)."
   @ ++nLin,000 PSAY "3.  PRAZOS DE GARANTIA"
   @ ++nLin,000 PSAY "3.1 Por 5 (cinco) anos a partir da entrega do imovel (Defeitos que comprometam" 
   @ ++nLin,000 PSAY "a solidez e a seguranca da obra)."
   @ ++nLin,000 PSAY "3.2 Por 6 (seis)  meses  a  partir  da  entrega  do  imovel (Defeitos  ocultos"  
   @ ++nLin,000 PSAY "existentes no imovel e que nao forem passiveis de constatacao no termo de vis-"
	@ ++nLin,000 PSAY "toria ou recebimento)."
   @ ++nLin,000 PSAY "4.  REGULAMENTACAO LEGAL DOS PRAZOS DE GARANTIA"
   @ ++nLin,000 PSAY "4.1 O prazo de 5 (cinco) anos a que se refere o item 3.1,  que  tem  inicio  a"
   @ ++nLin,000 PSAY "partir da entrega do  imovel,  encontra-se   previsto  no  ART. 1245 do Codigo"
   @ ++nLin,000 PSAY "Civil Brasileiro, que abrange qualquer defeito de construcao que venha  afetar"
   @ ++nLin,000 PSAY "a solidez e a segurança da obra."
   @ ++nLin,000 PSAY "4.2 O prazo  de  6  (seis)  meses  de  garantia  para  os  vicios  ocultos  ou"
   @ ++nLin,000 PSAY "redibitorios sera contado a partir da entrega do imovel, conforme estabelecido"
   @ ++nLin,000 PSAY "pelo ART. 178   5o, IV, do Codigo Civil Brasileiro."
   @ ++nLin,000 PSAY "5.  PROCEDIMENTO PARA SOLICITACAO DA ASSISTENCIA TECNICA"
   @ ++nLin,000 PSAY "5.1 Toda e qualquer solicitacao de vistoria e reparos sera feita com o  maximo"
   @ ++nLin,000 PSAY "de informacoes possiveis por escrito,  via  fax  ou  telefone  sempre  para  a"
   @ ++nLin,000 PSAY "Central de Atendimento ao Cliente que ira analisar e, no caso  de   reclamacao"
   @ ++nLin,000 PSAY "procedente, ira encaminhar para o setor da Assistencia Tecnica."
   @ ++nLin,000 PSAY "5.2 Estando a solicitacao dentro  dos  prazos  de  garantia  e  o  Promissario"
   @ ++nLin,000 PSAY "comprador adimplente  com a  CONSTRUTORA  TENDA  S/A  um  dos  engenheiros  ou"
   @ ++nLin,000 PSAY "tecnicos do departamento de  Assistencia Tecnica  fara  a  visita  em  horario"
   @ ++nLin,000 PSAY "marcado."
   @ ++nLin,000 PSAY "5.3 Feita a vistoria e sendo a reclamacao  procedente,  a  Construtora  tomara"
   @ ++nLin,000 PSAY "todas as providencias para sanar as falhas encontradas seguindo uma  programa-"
   @ ++nLin,000 PSAY "cao de servicos."
   @ ++nLin,000 PSAY "5.4 O proprietario assinara  ao  fim  dos  trabalhos  o  aceite  dos  servicos"
   @ ++nLin,000 PSAY "realizados constantes na  respectiva  solicitacao de servicos."
   @ ++nLin,000 PSAY "5.5 Para casos em que o cliente, apos a conclusao do servico nao quiser ou nao"
   @ ++nLin,000 PSAY "for contactado para assinar a solicitacao por outros motivos que nao envolva a"
   @ ++nLin,000 PSAY "qualidade do mesmo, o engenheiro responsavel assinara, apos  descricao escrita"
   @ ++nLin,000 PSAY "do historico ocorrido, e encaminhara para o  escritorio  como  concluido  para"
   @ ++nLin,000 PSAY "arquivamento."
	nLin := 05
   @ ++nLin,000 PSAY "6   CONDICOES DE CANCELAMENTO DA GARANTIA"
   @ ++nLin,000 PSAY "6.1 A  realizacao,  pelo  adquirente  do  imovel,  de  modificacao  na   parte"
   @ ++nLin,000 PSAY "estrutural e nas instalacoes do apartamento, pisos, impermeabilizacao,  esqua-"
   @ ++nLin,000 PSAY "drias, benfeitorias ou quaisquer outras modificacoes  em  sua   unidade,   sem"
   @ ++nLin,000 PSAY "previa  anuencia  da CONSTRUTORA TENDA S/A."
   @ ++nLin,000 PSAY "6.2 A utilizacao inadequada da unidade em suas formas  pre-dimendionais,  tais" 
   @ ++nLin,000 PSAY "como, sobrecargas estruturais  e  eletricas nao convencionais, e descaracteri-"
   @ ++nLin,000 PSAY "zacao das instalacoes projetadas, dentre outras."
   @ ++nLin,000 PSAY "6.3 Falta de manutencao periodica de responsabilidade do adquirinte do imovel,"
   @ ++nLin,000 PSAY "inadequada utilizacao ou ma conservacao."
   @ ++nLin,000 PSAY "6.4 Inadimplencia do adquirente(s)."
   @ ++nLin,000 PSAY "7.  CONDICOES GERAIS"
   @ ++nLin,000 PSAY "7.1 Cabera ao proprietario fazer prova de que o defeito ocorreu nos prazos  de" 
   @ ++nLin,000 PSAY "garantia aqui indicados e previstos no Codigo Civil Brasileiro."
   @ ++nLin,000 PSAY "7.2 O termo de vistoria precedera a entrega do imovel e,  nele,  o  adquirente" 
   @ ++nLin,000 PSAY "devera fazer constar  qualquer  defeito  ou observacao referente ao bem visto-"
   @ ++nLin,000 PSAY "riado. O recebimento da obra  sem  qualquer  ressalva  no  termo  da  vistoria"
   @ ++nLin,000 PSAY "implicara em sua aceitacao como boa e perfeita, inviabilizando qualquer recla-"
   @ ++nLin,000 PSAY "macao posterior relativa a eventuais vicios aparentes."
   @ ++nLin,000 PSAY "7.3 O construtor nao e' responsavel por defeitos decorrentes de  acidentes  de"
   @ ++nLin,000 PSAY "qualquer natureza, caso fortuito, de forca maior ou causados por instalacoes e"
   @ ++nLin,000 PSAY "servicos executados por terceiros."
   @ ++nLin,000 PSAY "7.4 A presente garantia nao cobre  os  danos  causados  as  benfeitorias  e/ou"
   @ ++nLin,000 PSAY "objetos, moveis, roupas e elementos decorativos instalados na unidade."
Next

nLin := 02
@ nLin,000 PSAY  Padc("TERMO DE VISTORIA",80)
@ nLin,067 PSAY "Cliente/Numero do Contrato" // SZ6->Z6_CodClie+"/"+SZ6->Z6_NumCont
nLin += 1
@ ++nLin,000 PSAY "IMOVEL: "//+SZ6->Z6_DesEmpr + "  " +Iif(SZ2->Z2_Classif="C","Casa: ","Apto: ")+SZ6->Z6_CodUnid+" Bloco: "+SZ6->Z6_CodBloc
@ ++nLin,000 PSAY "PROMISSARIO COMPRADOR(A): Nome Do Cliente"//+SZ6->Z6_NomClie
nLin++
@ ++nLin,000 PSAY "DATA: _____________________ de ________________  de _________"

@ ++nLin,000 PSAY "Termo  de  vistoria  que  entre  si  fazem  Promissario  Comprador  e Promitente"
@ ++nLin,000 PSAY "Vendedora, este representada por seu funcionariorio,  abaixo  assinado,  com  as"
@ ++nLin,000 PSAY "seguintes observacoes:"
nLin += 6
@ ++nLin,000 PSAY "O recebimento da obra sem  qualquer  ressalva  neste  termo  implicara   em  sua"
@ ++nLin,000 PSAY "aceitacao como boa e perfeita,   inviabilizando  qualquer  reclamacao  posterior"
@ ++nLin,000 PSAY "relativa a eventuais vicios aparentes."
@ ++nLin,000 PSAY "Estando todos os itens do imovel em perfeito estado de funcionalidade,  o imovel" 
@ ++nLin,000 PSAY "e declarado vistoriado e  o  Promissario Comprador  de  pleno  acordo  com  este"
@ ++nLin,000 PSAY "termo."
nLin += 2
@ ++nLin,000 PSAY "_______________________________________"
@ ++nLin,000 PSAY "     PROMISSARIO(A) COMPRADOR(A)"
nLin++
@ ++nLin,000 PSAY REPL("-",80)
@ ++nLin,053 PSAY "2a  VISTORIA"
@ ++nLin,000 PSAY "IMOVEL: "//+SZ6->Z6_DesEmpr
@ ++nLin,000 PSAY "PROMISSARIO COMPRADOR(A): Nome Do Cliente"//+SZ6->Z6_NomClie
nLin++
@ ++nLin,000 PSAY "DATA: _____________________ de ________________  de _________"
@ ++nLin,000 PSAY "Tendo sido observadas irregularidades no imovel, serve este termo para confirmar"
@ ++nLin,000 PSAY "que nesta data foi realizada a 2a vistoria e  que  Promitente  Vendedora  e Pro-"
@ ++nLin,000 PSAY "missario Comprador(a) declaram estar o imovel em perfeitas condicoes  nada  mais"
@ ++nLin,000 PSAY "sendo observado como vicios ou defeitos."
nLin += 2
@ ++nLin,000 PSAY "_______________________________________"
@ ++nLin,000 PSAY "     PROMISSARIO(A) COMPRADOR(A)"
nLin++
@ ++nLin,000 PSAY "O(a) Promissario(a) Comprador(a) recebe, nesta data atraves  deste  instrumento," 
@ ++nLin,000 PSAY "as chaves do imovel supra descrito e previamente vistoriado nao podendo o  mesmo"
@ ++nLin,000 PSAY "reclamar,  em  juizo  ou  fora  dele  acerca  das  especificacoes  de  materiais"
@ ++nLin,000 PSAY "contratados e sobre o perfeito estado do imovel ora entregue."
@ ++nLin,000 PSAY "E por estarem assim justas e contratadas, firmam  o  presente  instrumento  em 2" 
@ ++nLin,000 PSAY "(duas) vias de igual teor e forma para um so efeito juntamente  as  duas  teste-"
@ ++nLin,000 PSAY "munhas presentes para que se produzam todos os seus efeitos."
//    @ ++nLin,008 PSAY "Outorgamos o poder especial e especifico de rubricar  e assinar as demais vias integrante deste documento, bem"
//    @ ++nLin,008 PSAY "como o termo de recebimento, garantia e vistoria do imovel a "+XOR_GVEN+","
//    @ ++nLin,008 PSAY XOR_NAC+", "+XOR_ESTCIV+", "+XOR_PROFIS+", CI "+XOR_IDENT+", "+XOR_TIPO+", CPF: "+XOR_CPF
nLin += 2
@ ++nLin,000 PSAY "Belo Horizonte, ______ de ________________  de _________"
nLin += 2
@ ++nLin,000 PSAY Padc("____________________________________",80)
@ ++nLin,000 PSAY Padc("PROMISSARIO(A) COMPRADOR(A)",80)
nLin++
@ ++nLin,000 PSAY "TESTEMUNHA:"
nLin++
@ ++nLin,000 PSAY Padc("________________________________________",80)
@ ++nLin,000 PSAY Padc("RICARDO GUEDES e/ou",80)
@ ++nLin,000 PSAY Padc("WAGNER SANTOS AMORIM",80)

Return
