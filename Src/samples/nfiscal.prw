#IFDEF PROTHEUS
#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 15/08/00
#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF

User Function Nfiscal()        // incluido pelo assistente de conversao do AP5 IDE em 15/08/00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("TAMANHO,LIMITE,TITULO,CDESC1,CDESC2,CDESC3")
SetPrvt("CNATUREZA,ARETURN,NOMEPROG,CSTRING,CPERG,NLASTKEY")
SetPrvt("LCONTINUA,NLIN,WNREL,_TOTIPI,_TOTVAL,_TOTST")
SetPrvt("_TOTBAS,_MAU,_TOT01,_TOT02,XTOTST,XTRIB")
SetPrvt("NTAMNF,LFIRST,LFIM,_LIMP,_AESTRUTURA,_CARQTMP")
SetPrvt("XESPECIE1,XMARCA,XNUM_NF,XSERIE,XEMISSAO,XTOT_FAT")
SetPrvt("XLOJA,XFRETE,XSEGURO,XDESPESA,XBASE_ICMS,XBASE_IPI")
SetPrvt("XVALOR_ICMS,XBSICMRET,XICMS_RET,XVALOR_IPI,XVALOR_MERC,XNUM_DUPLIC")
SetPrvt("XCOND_PAG,XPBRUTO,XPLIQUI,XTIPO,XVOLUME1,XESPECIE2")
SetPrvt("XVOLUME2,XESPECIE3,XVOLUME3,XTIPOCLI,CPEDATU,CITEMATU")
SetPrvt("XPED_VEND,XITEM_PED,XNUM_NFDV,XPREF_DV,XICMS,XCOD_PRO")
SetPrvt("XCOD_LOC,XQTD_PRO,XPRE_UNI,XPRE_TAB,XIPI,XVAL_IPI")
SetPrvt("XDESC,XVAL_DESC,XVAL_MERC,XVAL_RET,XVAL_BR,XTES")
SetPrvt("XCF,XICMSOL,XICM_PROD,XPESO_PROD,APESO_BRUT,XDESCRICAO")
SetPrvt("XMSGTES,XUNID_PRO,XCOD_TRIB,XCOD_FIS,XCLAS_FIS,XISS")
SetPrvt("XTIPO_PRO,XLUCRO,XCLFISCAL,XPESO_LIQUI,XPESO_BRUTO,XIMPRESSO")
SetPrvt("I,XGRUPO,_CCLASS,_CCAT,XPESOBRUTOL,XPESOLIQUIL")
SetPrvt("XPED,XPEDIDO,XCLIENTE,XTIPO_CLI,XCOD_MENS,X2COD_MENS")
SetPrvt("XMENSAGEM,XTPFRETE,XCONDPAG,XCOD_VEND,XDESC_NF,XNUM_DRF")
SetPrvt("XLOC_DRF,XNNF,XSER_NNF,XDAT_NNF,XPLACA,XEST_VEIC")
SetPrvt("XPBRUT,XPLIQ,XDESC_PAG,XPESO_PRO,XPESO_BRU,XPED_CLI")
SetPrvt("XDESC_PRO,XTES_INT,XPESO_LIQ,XPESO_BRT,XPESOBRUTOP,XPESOLIQUIP")
SetPrvt("XCOD_CLI,XNOME_CLI,XEND_CLI,XBAIRRO,XCEP_CLI,XCOB_CLI")
SetPrvt("XREC_CLI,XMUN_CLI,XEST_CLI,XCGC_CLI,XINSC_CLI,XTRAN_CLI")
SetPrvt("XTEL_CLI,XFAX_CLI,XTES_CLI,XSUFRAMA,XCALCSUF,ZFRANCA")
SetPrvt("XVENDEDOR,XNOME_TRANSP,XEND_TRANSP,XMUN_TRANSP,XEST_TRANSP,XVIA_TRANSP")
SetPrvt("XCGC_TRANSP,XTEL_TRANSP,XPARC_DUP,XVENC_DUP,XVALOR_DUP,XDUPLICATAS")
SetPrvt("XNATUREZA,CNATUREZA1,CNATUREZA2,CTES1,CTES2,CCF1")
SetPrvt("CCF2,FIRSTCF,XFOR_MENS,XMENS_TES,_CALIAS,_NREGSB2")
SetPrvt("_NA,_CMSG,CHEADER,CDETAIL,CTRAILE,CAGENCIA")
SetPrvt("CNUMCTA,NNUMSEQ,CARQUIVO,NHDLARQ,XPESOBRUTO,XPESOLIQUI")
SetPrvt("XFORNECE,XNFORI,XPESOPROD,XQUANT,XPESOL,XPESOB")
SetPrvt("XCODDI,XFAX,NOPC,CCOR,NTAMDET,J")
SetPrvt("XB_ICMS_SOL,XV_ICMS_SOL,XCOMPLICMS,NPELEM,_CAIO,_TRIB")
SetPrvt("XNAT,XEST_PAR,BB,NCOL,_TOT03,_ACHA")
SetPrvt("NTAMOBS,NAJUSTE,_NREGISTRO,")
#ENDIF

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 15/08/00 ==> 	#DEFINE PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³  NFISCAL ³ Autor ³   Sergio Franco       ³ Data ³ 29/07/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Nota Fiscal de Entrada/Saida                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Manutencao³18/04/00 - Edneia Pedroso                                   ³±±
±±³          ³           Incluido o parametro MV_PAR09 para qdo for NF    ³±±
±±³          ³           de complemento de ICMS ST, nao precisar alterar  ³±±
±±³          ³           a NF                                             ³±±
±±³Manutencao³02/05/00 - Edneia Pedroso                                   ³±±
±±³          ³           Incluida condicao de "nao imprimir nf" se produto³±±
±±³          ³           estiver com estoque negativo.                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para YPF S/A                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

tamanho  := "G"
limite   := 220
titulo   := PADC("Nota Fiscal - Nfiscal",74)
cDesc1   := PADC("Este programa ira emitir a Nota Fiscal de Entrada/Saida",74)
cDesc2   := ""
cDesc3   := PADC("da Nfiscal",74)
cNatureza:= ""
aReturn  := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
nomeprog := "nfiscal"
cString  := "SF2"
cPerg    := "NFSIGW"
nLastKey := 0
lContinua:= .T.
nLin     := 0
wnrel    := "siganf"
_TotIPI  := 0
_TotVal  := 0
_TotST   := 0
_TotBas  := 0
_Mau     := 0
_Tot01   := 0
_Tot02   := 0
xTOTST   := {}
xTRIB    := {}
nTamNf   := 72     // Apenas Informativo
lFirst   := .T.
lFim     := .F.
_lImp    := .t.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Da Nota Fiscal                       ³
//³ mv_par02             // Ate a Nota Fiscal                    ³
//³ mv_par03             // Da Serie                             ³
//³ mv_par04             // Nota Fiscal de Entrada/Saida         ³
//³ mv_par05             // Clas.ONU                             ³
//³ mv_par06             // Clas.ONU                             ³
//³ mv_par07             // Gera Txt Boleto                      ³
//³ mv_par08             // Mensagem no corpo da Nota            ³
//³ mv_par09             // Complemento de ICMS ST?              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.F.)               // Pergunta no SX1

mv_par05 := ""
mv_par06 := ""
mv_par07 := 0
mv_par08 := ""
mv_par09 := 0

wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)
If nLastKey == 27
	Return
Endif
SetDefault(aReturn,cString)
If nLastKey == 27
	Return
Endif


_aEstrutura := {}
AADD(_aEstrutura,{"PRODUTO"  ,"C",15,0})
AADD(_aEstrutura,{"DESCRICAO","C",30,0})
AADD(_aEstrutura,{"CF"       ,"C",03,0})
AADD(_aEstrutura,{"CLASSIF"  ,"C",10,0})
AADD(_aEstrutura,{"TRIB"     ,"C",02,0})
AADD(_aEstrutura,{"UNID"     ,"C",02,0})
AADD(_aEstrutura,{"QTDE"     ,"N",14,2})
AADD(_aEstrutura,{"PRECO"    ,"N",14,4})
AADD(_aEstrutura,{"VALOR"    ,"N",14,2})
AADD(_aEstrutura,{"ICM"      ,"N",05,2})
AADD(_aEstrutura,{"IPI"      ,"N",05,2})
AADD(_aEstrutura,{"VALIPI"   ,"N",14,2})
AADD(_aEstrutura,{"VALST"    ,"N",14,2})
AADD(_aEstrutura,{"BASEST"   ,"N",14,2})
_cArqTmp := CriaTrab(_aEstrutura,.t.)
dbUseArea(.T.,,_cArqTmp,"TRB",.F.,.F.)
dbSelectArea("TRB")
IndRegua("TRB",_cArqTmp,"TRIB+PRODUTO",,,"Criando Indice...")
dbGotop()

VerImp()
#IFDEF WINDOWS
   #IFDEF PROTHEUS
      RptStatus({|| RptDetail()},Alltrim(Titulo))
   #ELSE
      RptStatus({|| Execute(RptDetail)},Alltrim(Titulo))
   #ENDIF
	Return
#ENDIF
#IFDEF PROTHEUS
   Static Function RptDetail()
#ELSE
   Function RptDetail
#ENDIF

If mv_par04 == 2
	dbSelectArea("SF2")                // * Cabecalho da Nota Fiscal Saida
	dbSetOrder(1)
	dbSeek(xFilial("SF2")+mv_par01+mv_par03,.t.)
Else
	dbSelectArea("SF1")                // * Cabecalho da Nota Fiscal Entrada
	DbSetOrder(1)
	dbSeek(xFilial("SF1")+mv_par01+mv_par03,.t.)
Endif
SetRegua(Val(mv_par02)-Val(mv_par01))
If mv_par04 == 2
	dbSelectArea("SF2")
	While !eof() .and. SF2->F2_DOC <= mv_par02 .and. SF2->F2_SERIE == mv_par03 .and. lContinua
		If SF2->F2_SERIE <> mv_par03    // Se a Serie do Arquivo for Diferente
			DbSkip()                    // do Parametro Informado !!!
			Loop
		Endif
		#IFNDEF WINDOWS
			IF LastKey()==286
				@ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
				lContinua := .F.
				Exit
			Endif
		#ELSE
			IF lAbortPrint
				@ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
				lContinua := .F.
				Exit
			Endif
		#ENDIF
		xESPECIE1   := ""
		xMARCA      := ""
		xNUM_NF     := SF2->F2_DOC             // Numero
		xSERIE      := SF2->F2_SERIE           // Serie
		xEMISSAO    := SF2->F2_EMISSAO         // Data de Emissao
		xTOT_FAT    := SF2->F2_VALFAT          // Valor Total da Fatura
		If xTOT_FAT == 0
			xTOT_FAT := SF2->F2_VALMERC+SF2->F2_VALIPI+SF2->F2_SEGURO+SF2->F2_FRETE+SF2->F2_ICMSRET
		EndIf
		xLOJA       := SF2->F2_LOJA            // Loja do Cliente
		xFRETE      := SF2->F2_FRETE           // Frete
		xSEGURO     := SF2->F2_SEGURO          // Seguro
		xDESPESA    := SF2->F2_DESPESA         // Despesas Acessorias
		xBASE_ICMS  := SF2->F2_BASEICM         // Base   do ICMS
		xBASE_IPI   := SF2->F2_BASEIPI         // Base   do IPI
		xVALOR_ICMS := SF2->F2_VALICM          // Valor  do ICMS
		xBSICMRET   := SF2->F2_BRICMS          // Base   do ICMS Retido
        xICMS_RET   := SF2->F2_ICMSRET         // Valor  do ICMS Retido

        xVALOR_IPI  := SF2->F2_VALIPI          // Valor  do IPI
		xVALOR_MERC := SF2->F2_VALMERC         // Valor  da Mercadoria
		xNUM_DUPLIC := SF2->F2_DUPL            // Numero da Duplicata
		xCOND_PAG   := SF2->F2_COND            // Condicao de Pagamento
		//      xPBRUTO     := SF2->F2_PBRUTO          // Peso Bruto
		//      xPLIQUI     := SF2->F2_PLIQUI          // Peso Liquido
		xTIPO       := SF2->F2_TIPO            // Tipo da Nota
		xESPECIE1   := SF2->F2_ESPECI1         // Especie 1 no Pedido
		//      xVOLUME1    := SF2->F2_VOLUME1         // Volume 1 no Pedido
		xESPECIE2   := SF2->F2_ESPECI2         // Especie 2 no Pedido
		xVOLUME2    := SF2->F2_VOLUME2         // Volume 2 no Pedido
		xESPECIE3   := SF2->F2_ESPECI3         // Especie 3 no Pedido
		xVOLUME3    := SF2->F2_VOLUME3         // Volume 3 no Pedido
		xTIPOCLI    := SF2->F2_TIPOCLI         // Tipo do Cliente
		dbSelectArea("SD2")                   // * Itens de Venda da N.F.
		dbSetOrder(3)
		dbSeek(xFilial("SD2")+xNUM_NF+xSERIE)
		cPedAtu  := SD2->D2_PEDIDO
		cItemAtu := SD2->D2_ITEMPV
		xPED_VEND := {}                         // Numero do Pedido de Venda
		xITEM_PED := {}                         // Numero do Item do Pedido de Venda
		xNUM_NFDV := {}                         // Numero quando houver devolucao
		xPREF_DV  := {}                         // Serie  quando houver devolucao
		xICMS     := {}                         // Porcentagem do ICMS
		xCOD_PRO  := {}                         // Codigo  do Produto
		xCOD_LOC  := {}                         // Almoxarifado usado pelo produto
		xQTD_PRO  := {}                         // Peso/Quantidade do Produto
		xPRE_UNI  := {}                         // Preco Unitario de Venda
		xPRE_TAB  := {}                         // Preco Unitario de Tabela
		xIPI      := {}                         // Porcentagem do IPI
		xVAL_IPI  := {}                         // Valor do IPI
		xDESC     := {}                         // Desconto por Item
		xVAL_DESC := {}                         // Valor do Desconto
		xVAL_MERC := {}                         // Valor da Mercadoria
		xVAL_RET  := {}                         // Valor do ICMS Retido
		xVAL_BR   := {}                         // Valor da Base de ICMS Retido
		xTES      := {}                         // TES
		xCF       := {}                         // Classificacao quanto natureza da Operacao
		xICMSOL   := {}                         // Base do ICMS Solidario
		xICM_PROD := {}                         // ICMS do Produto
		While !eof() .and. SD2->D2_DOC == xNUM_NF .and. SD2->D2_SERIE == xSERIE
			If SD2->D2_SERIE <> mv_par03        // Se a Serie do Arquivo for Diferente
				DbSkip()                   // do Parametro Informado !!!
				Loop
			Endif
			
			AADD(xPED_VEND ,SD2->D2_PEDIDO)
			AADD(xITEM_PED ,SD2->D2_ITEMPV)
			AADD(xNUM_NFDV ,IIF(Empty(SD2->D2_NFORI),"",SD2->D2_NFORI))
			AADD(xPREF_DV  ,SD2->D2_SERIORI)
			AADD(xICMS     ,IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM))
			AADD(xCOD_PRO  ,SD2->D2_COD)
			AADD(xCOD_LOC  ,SD2->D2_LOCAL)
			AADD(xQTD_PRO  ,SD2->D2_QUANT)     // Guarda as quant. da NF
			AADD(xPRE_UNI  ,SD2->D2_PRCVEN)
			AADD(xPRE_TAB  ,SD2->D2_PRUNIT)
			AADD(xIPI      ,IIF(Empty(SD2->D2_IPI),0,SD2->D2_IPI))
			AADD(xVAL_IPI  ,SD2->D2_VALIPI)
			AADD(xDESC     ,SD2->D2_DESC)
			AADD(xVAL_MERC ,SD2->D2_TOTAL)
			AADD(xTES      ,SD2->D2_TES)
			AADD(xVAL_RET  ,SD2->D2_ICMSRET)
			AADD(xVAL_BR   ,SD2->D2_BRICMS)
			AADD(xCF       ,SD2->D2_CF)
			
			If xTIPOCLI == "S" .and. xFilial("SD2")=="02"
				AADD(xICM_PROD , 0)
			Else
				AADD(xICM_PROD ,IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM))
			EndIf
			dbSkip()
		EndDo
		dbSelectArea("SB1")                        // * Desc. Generica do Produto
		dbSetOrder(1)
		xPESO_PROD := {}                           // Peso Liquido
		aPESO_BRUT := {}                           // Peso Bruto
		xDESCRICAO := {}                           // Descricao do Produto
		xMSGTES    := {}                           // Mensagem de acordo com o TES
		xUNID_PRO  := {}                           // Unidade do Produto
		xCOD_TRIB  := {}                           // Codigo de Tributacao
		xCOD_FIS   := {}                           // Cogigo Fiscal
		xCLAS_FIS  := {}                           // Classificacao Fiscal
		xISS       := {}                           // Aliquota de ISS
		xTIPO_PRO  := {}                           // Tipo do Produto
		xLUCRO     := {}                           // Margem de Lucro p/ ICMS Solidario
		xCLFISCAL  := {}
		xPESO_LIQUI  := 0
		xPESO_BRUTO  := 0
		xIMPRESSO  := {}                          // Flag de Impressao
		For I := 1 to Len(xCOD_PRO)
			dbSeek(xFilial("SB1")+xCOD_PRO[I])
			AADD(xUNID_PRO,Tabela("97",SB1->B1_UM,.f.))
			If !empty(SB1->B1_ORIGEM)
				dbSelectArea("SF4")
				dbSetOrder(1)
				dbSeek(xFilial("SF4") + xTES[I])
				If Found()
					AADD(xCOD_TRIB , Substr(SB1->B1_ORIGEM,1,1) + If(.T., "", Substr(SF4->F4_TRIBUT,2,1)))
				EndIf
			Else
				dbSelectArea("SF4")
				dbSetOrder(1)
				dbSeek(xFilial("SF4") + xTES[I])
				If Found()
					AADD(xCOD_TRIB, If(.T., "", SF4->F4_TRIBUT))
				EndIf
			Endif
			dbSelectArea("SB1")
			AADD(xPESO_PROD , SB1->B1_PESO   * xQTD_PRO[I])
			AADD(aPESO_BRUT , SB1->B1_PESO   * xQTD_PRO[I]) // SB1->B1_PESBRT * xQTD_PRO[I])
			AADD(xDESCRICAO , SB1->B1_DESC)
			AADD(xCLAS_FIS  , SB1->B1_POSIPI)
			AADD(xTIPO_PRO  , SB1->B1_TIPO)
			AADD(xLUCRO     , SB1->B1_PICMRET)
			xPESO_LIQUI := xPESO_LIQUI + xPESO_PROD[I]
			xPESO_BRUTO := xPESO_BRUTO + aPESO_BRUT[I]
			xGRUPO  := SB1->B1_GRUPO
			_cClass := "" // AllTrim(SB1->B1_CLASONU)
			_cCat   := "" // AllTrim(SB1->B1_CATONU)
			
			If SB1->B1_ALIQISS > 0
				AADD(xISS ,SB1->B1_ALIQISS)
			Endif
		EndFor
		
		xPESOBRUTOL := xPESO_BRUTO
		xPESOLIQUIL := xPESO_LIQUI
		
		dbSelectArea("SC5")                            // * Pedidos de Venda
		dbSetOrder(1)
		xPED        := {}
		xPEDIDO     := Space(6)
		For I := 1 to Len(xPED_VEND)
			dbSeek(xFilial("SC5")+xPED_VEND[I])
			If ASCAN(xPED,xPED_VEND[I]) == 0
				dbSeek(xFilial("SC5")+xPED_VEND[I])
				xPEDIDO     := SC5->C5_NUM
				xCLIENTE    := SC5->C5_CLIENTE            // Codigo do Cliente
				xTIPO_CLI   := SC5->C5_TIPOCLI            // Tipo de Cliente
				xCOD_MENS   := SC5->C5_MENPAD             // Codigo da Mensagem Padrao
				x2COD_MENS  := "" // SC5->C5_MENPAD2       // Codigo da Mensagem Padrao2
				xMENSAGEM   := SC5->C5_MENNOTA            // Mensagem para a Nota Fiscal
				xTPFRETE    := SC5->C5_TPFRETE            // Tipo de Entrega
				xCONDPAG    := SC5->C5_CONDPAG            // Condicao de Pagamento
				xCOD_VEND   :={SC5->C5_VEND1,;            // Codigo do Vendedor 1
					SC5->C5_VEND2,;            // Codigo do Vendedor 2
					SC5->C5_VEND3,;            // Codigo do Vendedor 3
					SC5->C5_VEND4,;            // Codigo do Vendedor 4
					SC5->C5_VEND5}             // Codigo do Vendedor 5
				xDESC_NF    :={SC5->C5_DESC1,;            // Desconto Global 1
					SC5->C5_DESC2,;            // Desconto Global 2
					SC5->C5_DESC3,;            // Desconto Global 3
					SC5->C5_DESC4}             // Desconto Global 4
				xFRETE      := SC5->C5_FRETE
				xNUM_DRF    := "" // SC5->C5_NUMDRF
				xLOC_DRF    := "" // SC5->C5_LOCDRF
				xNNF        := "" // SC5->C5_NNF
				xSER_NNF    := "" // SC5->C5_SERNNF
				xDAT_NNF    := "" // SC5->C5_DATNNF
				xPLACA      := "" // SC5->C5_PLACA
				xEST_VEIC   := "" // SC5->C5_ESTVEIC
				xPBRUT      := SC5->C5_PBRUTO
				xPLIQ       := SC5->C5_PESOL
				AADD(xPED,xPED_VEND[I])
			Endif
		EndFor
		dbSelectArea("SE4")                    // Condicao de Pagamento
		dbSetOrder(1)
		dbSeek(xFilial("SE4")+xCONDPAG)
		xDESC_PAG := SE4->E4_DESCRI
		
		dbSelectArea("SC6")                    // * Itens de Pedido de Venda
		dbSetOrder(1)
		xPESO_PRO := {}                          // Peso Liquido
		xPESO_BRU := {}                          // Peso Bruto
		xPED_CLI  := {}                          // Numero de Pedido
		xDESC_PRO := {}                          // Descricao aux do produto
		xTES_INT  := {}
		xPESO_LIQ := 0
		xPESO_BRT := 0
		
		For I := 1 to Len(xPED_VEND)
			dbSeek(xFilial("SC6")+xPED_VEND[I]+xITEM_PED[I])
			AADD(xPED_CLI ,SC6->C6_PEDCLI)
			AADD(xDESC_PRO,SC6->C6_DESCRI)
			AADD(xVAL_DESC,SC6->C6_VALDESC)
			AADD(xTES_INT , Space(3)) // SC6->C6_INTEL
			AADD(xPESO_PRO, 0) // SC6->C6_PESO
			AADD(xPESO_BRU, 0) // SC6->C6_PESOBRT
			xPESO_LIQ := xPESO_LIQ + xPESO_PRO[I]
			xPESO_BRT := xPESO_BRT + xPESO_BRU[I]
		EndFor
		
		xPESOBRUTOP := xPESO_BRT
		xPESOLIQUIP := xPESO_LIQ
		
		If xTIPO == 'N' .OR. xTIPO == 'C' .OR. xTIPO == 'P' .OR. xTIPO == 'I' .OR.;
				xTIPO == 'S' .OR. xTIPO == 'T' .OR. xTIPO == 'O'
			
			dbSelectArea("SA1")                // * Cadastro de Clientes
			dbSetOrder(1)
			dbSeek(xFilial("SA1")+xCLIENTE+xLOJA)
			xCOD_CLI  := SA1->A1_COD             // Codigo do Cliente
			xNOME_CLI := SA1->A1_NOME            // Nome
			xEND_CLI  := SA1->A1_END             // Endereco
			xBAIRRO   := SA1->A1_BAIRRO          // Bairro
			xCEP_CLI  := SA1->A1_CEP             // CEP
			xCOB_CLI  := SA1->A1_ENDCOB          // Endereco de Cobranca
			xREC_CLI  := SA1->A1_ENDENT          // Endereco de Entrega
			xMUN_CLI  := SA1->A1_MUN             // Municipio
			xEST_CLI  := SA1->A1_EST             // Estado
			xCGC_CLI  := SA1->A1_CGC             // CGC
			xINSC_CLI := SA1->A1_INSCR           // Inscricao estadual
			xTRAN_CLI := SA1->A1_TRANSP          // Transportadora
			xTEL_CLI  := SA1->A1_TEL             // Telefone
			xFAX_CLI  := SA1->A1_FAX             // Fax
			xTES_CLI  := Space(3)					  // SA1->A1_TES - TES do Cliente
			xSUFRAMA  := SA1->A1_SUFRAMA         // Codigo Suframa
			xCALCSUF  := SA1->A1_CALCSUF         // Calcula Suframa
			// Alteracao p/ Calculo de Suframa
			If !empty(xSUFRAMA) .and. xCALCSUF == "S"
				IF XTIPO == 'D' .OR. XTIPO == 'B'
					zFranca := .F.
				Else
					zFranca := .T.
				Endif
			Else
				zFranca := .F.
			Endif
		Else
			zFranca:=.F.
			dbSelectArea("SA2")                // * Cadastro de Fornecedores
			dbSetOrder(1)
			dbSeek(xFilial("SA2")+xCLIENTE+xLOJA)
			xCOD_CLI  := SA2->A2_COD             // Codigo do Fornecedor
			xNOME_CLI := SA2->A2_NOME            // Nome Fornecedor
			xEND_CLI  := SA2->A2_END             // Endereco
			xBAIRRO   := SA2->A2_BAIRRO          // Bairro
			xCEP_CLI  := SA2->A2_CEP             // CEP
			xCOB_CLI  := ""                      // Endereco de Cobranca
			xREC_CLI  := ""                      // Endereco de Entrega
			xMUN_CLI  := SA2->A2_MUN             // Municipio
			xEST_CLI  := SA2->A2_EST             // Estado
			xCGC_CLI  := SA2->A2_CGC             // CGC
			xINSC_CLI := SA2->A2_INSCR           // Inscricao estadual
			xTRAN_CLI := SA2->A2_TRANSP          // Transportadora
			xTEL_CLI  := SA2->A2_TEL             // Telefone
			xFAX_CLI  := SA2->A2_FAX             // Fax
		Endif
		dbSelectArea("SA3")                   // * Cadastro de Vendedores
		dbSetOrder(1)
		xVENDEDOR := {}                         // Nome do Vendedor
		For I := 1 to Len(xCOD_VEND)
			dbSeek(xFilial("SA3")+xCOD_VEND[I])
			Aadd(xVENDEDOR,SA3->A3_NREDUZ)
		EndFor
		dbSelectArea("SA4")                   // * Transportadoras
		dbSetOrder(1)
		dbSeek(xFilial("SA4")+SF2->F2_TRANSP)
		xNOME_TRANSP := SA4->A4_NOME           // Nome Transportadora
		xEND_TRANSP  := SA4->A4_END            // Endereco
		xMUN_TRANSP  := SA4->A4_MUN            // Municipio
		xEST_TRANSP  := SA4->A4_EST            // Estado
		xVIA_TRANSP  := SA4->A4_VIA            // Via de Transporte
		xCGC_TRANSP  := SA4->A4_CGC            // CGC
		xTEL_TRANSP  := SA4->A4_TEL            // Fone
		dbSelectArea("SE1")                   // * Contas a Receber
		dbSetOrder(1)
		xPARC_DUP   := {}                       // Parcela
		xVENC_DUP   := {}                       // Vencimento
		xVALOR_DUP  := {}                       // Valor
		xDUPLICATAS := IIF(dbSeek(xFilial("SE1")+xSERIE+xNUM_DUPLIC,.T.),.T.,.F.) // Flag p/Impressao de Duplicatas
      While !eof() .and. SE1->E1_NUM == xNUM_DUPLIC .and. xDUPLICATAS == .T. .and. (! empty(xNUM_DUPLIC))
			If !("NF" $ SE1->E1_TIPO)
				dbSkip()
				Loop
			Endif
			AADD(xPARC_DUP ,SE1->E1_PARCELA)
			AADD(xVENC_DUP ,SE1->E1_VENCTO)
			AADD(xVALOR_DUP,SE1->E1_VALOR)
			dbSkip()
		EndDo
		xNATUREZA  := ""
		cNATUREZA1 := ""
		cNATUREZA2 := ""
		cTES1      := ""
		cTES2      := ""
		cCF1       := ""
		cCF2       := ""
		FirstCF    := 1
		
		For I:=1 to Len(xTES)
			dbSelectArea("SF4")                 // * Tipos de Entrada e Saida
			DbSetOrder(1)
			dbSeek(xFilial("SF4")+xTES[I])
			xNATUREZA:=SF4->F4_TEXTO            // Natureza da Operacao
			If FirstCF == 1
				cNATUREZA1 := xNATUREZA
				cTES1      := xTES[I]
				cCF1       := xCF[I]
				FirstCF    := 2
			Endif
			If FirstCF == 2 .and. cCF1 <> xCF[I]
				cNATUREZA2 := xNATUREZA
				cTES2      := xTES[I]
				cCF2       := xCF[I]
				FirstCF    := 3
				I := Len(xTES) + 1
			Endif
		EndFor
		
		//Verifica se o estoque atualizado ficou negativo
		If (Len(xCOD_PRO)>0)  .and. (xTIPO == 'N')
			_cAlias := Alias()
			
			DbSelectArea("SB2")
			_nRegSB2 := Recno()
			
			DbSetOrder(1)
			For _nA:=1 to len(xCOD_PRO)
				DbSeek(xFilial("SB2")+xCOD_PRO[_nA]+xCOD_LOC[_nA])
				_cMsg := " "
				If found() .and. (SB2->B2_QATU<0)
					_cMsg := "O produto "+alltrim(xCOD_PRO[_nA])+" ficou com estoque "
					_cMsg := _cMsg + "negativo na preparacao da NF, contacte o suporte"
					_cMsg := _cMsg + " Microsiga, pois nao sera impressa a NF "+xNUM_NF
					msgstop(_cMsg)
					_lImp := .f.
				Endif
				
				//Nao imprimira tambem, se D2_CF vazio. Embora o campo
				//seja obrigatorio, Siga estava deixando passar em branco em alguns casos
				If empty(xCF[_nA])
					_cMsg := "O produto "+alltrim(xCOD_PRO[_nA])+" ficou sem CFOP no "
					_cMsg := _cMsg + "arquivo de itens de nota.     Contacte o suporte"
					_cMsg := _cMsg + " Microsiga, pois nao sera impressa a NF "+xNUM_NF
					msgstop(_cMsg)
					_lImp := .f.
				Endif
				
			Next
			
			DbGoTo(_nRegSB2)
			
			DbSelectArea(_cAlias)
			If _lImp
				Imprime()
			Endif
			_lImp := .t.
		Else
			Imprime()
		Endif
		
		IncRegua()                    // Termometro de Impressao
		nLin := 0
		dbSelectArea("SF2")
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Gera Arq.TXT para Impressao do Boleto       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par07 == 1
			If lFirst
				cHeader := ""
				cDetail := ""
				cTraile := ""
				cAgencia:= ""
				cNumCta := ""
				nNumSeq := 1
				cArquivo:= "C:\BRADESCO\CB000000.REM"
				nHdlArq := FCreate(cArquivo,0)
			EndIf
			ExecBlock("GerBto",.F.,.F.)
		Endif
		dbSkip()                      // passa para a proxima Nota Fiscal
		
	EndDo
	
	If !lFirst
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Fecha Arq.TXT para Impressao do Boleto      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lFim := .T.
		ExecBlock("GerBto",.F.,.F.)
		FClose(nHdlArq)
	Endif
Else
	dbSelectArea("SF1")              // * Cabecalho da Nota Fiscal Entrada
	dbSeek(xFilial("SF1")+mv_par01+mv_par03,.t.)
	While !eof() .and. SF1->F1_DOC <= mv_par02 .and. SF1->F1_SERIE == mv_par03 .and. lContinua
		If SF1->F1_SERIE <> mv_par03    // Se a Serie do Arquivo for Diferente
			DbSkip()                    // do Parametro Informado !!!
			Loop
		Endif
		SetRegua(Val(mv_par02)-Val(mv_par01))
		#IFNDEF WINDOWS
			IF LastKey() == 286
				@ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
				lContinua := .F.
				Exit
			Endif
		#ELSE
			IF lAbortPrint
				@ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
				lContinua := .F.
				Exit
			Endif
		#ENDIF
		xESPECIE1   := ""
		xMARCA      := ""
		xNUM_NF     := SF1->F1_DOC             // Numero
		xSERIE      := SF1->F1_SERIE           // Serie
		xFORNECE    := SF1->F1_FORNECE         // Cliente/Fornecedor
		xEMISSAO    := SF1->F1_EMISSAO         // Data de Emissao
		xTOT_FAT    := SF1->F1_VALBRUT         // Valor Bruto da Compra
		xLOJA       := SF1->F1_LOJA            // Loja do Cliente
		xFRETE      := SF1->F1_FRETE           // Frete
		xSEGURO     := SF1->F1_DESPESA         // Despesa
		xBASE_ICMS  := SF1->F1_BASEICM         // Base   do ICMS
		xBASE_IPI   := SF1->F1_BASEIPI         // Base   do IPI
		xVALOR_ICMS := SF1->F1_VALICM          // Valor  do ICMS
		xBSICMRET   := SF1->F1_BRICMS          // Base   do ICMS Retido
		xICMS_RET   := SF1->F1_ICMSRET         // Valor  do ICMS Retido
		xVALOR_IPI  := SF1->F1_VALIPI          // Valor  do IPI
		xVALOR_MERC := SF1->F1_VALMERC         // Valor  da Mercadoria
		xNUM_DUPLIC := SF1->F1_DUPL            // Numero da Duplicata
		xCOND_PAG   := SF1->F1_COND            // Condicao de Pagamento
		xTIPO       := SF1->F1_TIPO            // Tipo do Cliente
		xNFORI      := SF1->F1_NFORI           // NF Original
		xPREF_DV    := SF1->F1_SERIORI         // Serie Original
		xMARCA      := Alltrim(SF1->F1_MARCA)  // Marca
		dbSelectArea("SD1")                   // * Itens da N.F. de Compra
		dbSetOrder(1)
		dbSeek(xFilial("SD1")+xNUM_NF+xSERIE+xFORNECE+xLOJA)
		cPedAtu   := SD1->D1_PEDIDO
		cItemAtu  := SD1->D1_ITEMPC
		xPEDIDO   := {}                         // Numero do Pedido de Compra
		xITEM_PED := {}                         // Numero do Item do Pedido de Compra
		xNUM_NFDV := {}                         // Numero quando houver devolucao
		xPREF_DV  := {}                         // Serie  quando houver devolucao
		xICMS     := {}                         // Porcentagem do ICMS
		xCOD_PRO  := {}                         // Codigo  do Produto
		xVAL_RET  := {}                         // Valor do Icms Retido
		xVAL_BR   := {}                         // Valor da Base de ICMS Retido
		xQTD_PRO  := {}                         // Peso/Quantidade do Produto
		xPRE_UNI  := {}                         // Preco Unitario de Compra
		xIPI      := {}                         // Porcentagem do IPI
		xPESOPROD := {}                         // Peso do Produto
		xVAL_IPI  := {}                         // Valor do IPI
		xDESC     := {}                         // Desconto por Item
		xVAL_DESC := {}                         // Valor do Desconto
		xVAL_MERC := {}                         // Valor da Mercadoria
		xTES      := {}                         // TES
		xFOR_MENS := {}
		xMSGTES   := {}                         // Mensagem de acordo com o TES
		xCF       := {}                         // Classificacao quanto natureza da Operacao
		xICMSOL   := {}                         // Base do ICMS Solidario
		xICM_PROD := {}                         // ICMS do Produto
		xQUANT    := {}
		xPESOL    := {}
		xPESOB    := {}
		xNATUREZA := ""
		xPBRUT    := 0
		xPLIQ     := 0
		xCODDI    := ""
		
		While !eof() .and. SD1->D1_DOC==xNUM_NF
			If SD1->D1_SERIE <> mv_par03        // Se a Serie do Arquivo for Diferente
				DbSkip()                      // do Parametro Informado !!!
				Loop
			Endif
			AADD(xPEDIDO   ,SD1->D1_PEDIDO)         // Ordem de Compra
			AADD(xITEM_PED ,SD1->D1_ITEMPC)         // Item da O.C.
			AADD(xNUM_NFDV ,IIF(Empty(SD1->D1_NFORI),"",SD1->D1_NFORI))
			AADD(xPREF_DV  ,SD1->D1_SERIORI)        // Serie Original
			AADD(xICMS     ,IIf(Empty(SD1->D1_PICM),0,SD1->D1_PICM))
			AADD(xCOD_PRO  ,SD1->D1_COD)            // Produto
			AADD(xVAL_RET  ,SD1->D1_ICMSRET)
			AADD(xVAL_BR  , SD1->D1_BRICMS)
			AADD(xQTD_PRO  ,SD1->D1_QUANT)          // Guarda as quant. da NF
			AADD(xPRE_UNI  ,SD1->D1_VUNIT)          // Valor Unitario
			AADD(xIPI      ,SD1->D1_IPI)            // % IPI
			AADD(xVAL_IPI  ,SD1->D1_VALIPI)         // Valor do IPI
			AADD(xPESOPROD ,SD1->D1_PESO)           // Peso do Produto
			AADD(xDESC     ,SD1->D1_DESC)           // % Desconto
			AADD(xVAL_MERC ,SD1->D1_TOTAL)          // Valor Total
			AADD(xTES      ,SD1->D1_TES)            // Tipo de Entrada/Saida
			AADD(xCF       ,SD1->D1_CF)             // Codigo Fiscal
			AADD(xICM_PROD ,IIf(Empty(SD1->D1_PICM),0,SD1->D1_PICM))
			AADD(xQUANT    ,SD1->D1_QUANT)          // Quantidade dos Produtos
			AADD(xICMSOL   ,SD1->D1_BRICMS)         // Base do ICMS Substituto
			//AADD(xICM_PROD ,SD1->D1_ICMSRET)        // cfe Andre, nunca eh impresso vlr nesta coluna - Valor do ICMS Subst.
			xPBRUT := xPBRUT + SD1->D1_PESOB
			xPLIQ  := xPLIQ  + SD1->D1_PESOL
			IF !EMPTY(SD1->D1_DI)
				xCODDI := ALLTRIM(SD1->D1_DI)
			ENDIF
			dbSelectArea("SF4")                 // * Tipos de Entrada e Saida
			DbSetOrder(1)
			dbSeek(xFilial("SF4")+SD1->D1_TES)
			xNATUREZA:=SF4->F4_TEXTO            // Natureza da Operacao
			DbSelectArea("SD1")
			dbskip()
		EndDo
		dbSelectArea("SB1")                        // Desc. Generica do Produto
		dbSetOrder(1)
		xUNID_PRO  := {}                           // Unidade do Produto
		xDESC_PRO  := {}                           // Descricao do Produto
		xDESCRICAO := {}                           // Descricao do Produto
		xCOD_TRIB  := {}                           // Codigo de Tributacao
		xCOD_FIS   := {}                           // Codigo Fiscal
		xCLAS_FIS  := {}                           // Classificacao Fiscal
		xISS       := {}                           // Aliquota de ISS
		xTIPO_PRO  := {}                           // Tipo do Produto
		xLUCRO     := {}                           // Margem de Lucro p/ ICMS Solidario
		xCLFISCAL  := {}
		xPESO_PRO  := {}
		xPESO_BRU  := {}
		xPESO_LIQ  := 0
		xPESO_BRT  := 0
		xSUFRAMA   := ""
		xCALCSUF   := ""
		xIMPRESSO  := {}
		For I := 1 to Len(xCOD_PRO)
			dbSeek(xFilial("SB1")+xCOD_PRO[I])
			AADD(xUNID_PRO, Tabela("97", SB1->B1_UM, .F.))
			dbSelectArea("SF4")
			dbSetOrder(1)
			dbSeek(xFilial("SF4") + xTES[I])
			If Found()
				AADD(xCOD_TRIB, If(.T., "", SF4->F4_TRIBUT))
				AADD(xFOR_MENS, SF4->F4_FORMULA)
			EndIf
			dbSelectArea("SB1")
			AADD(xPESO_PRO , SB1->B1_PESO   * xQTD_PRO[I])
			AADD(xPESO_BRU , SB1->B1_PESO   * xQTD_PRO[I])// SB1->B1_PESBRT * xQTD_PRO[I])
			AADD(xDESCRICAO, SB1->B1_DESC)
			AADD(xCLAS_FIS , SB1->B1_POSIPI)
			AADD(xTIPO_PRO , SB1->B1_TIPO)
			AADD(xLUCRO    , SB1->B1_PICMRET)
			xPESO_LIQ      := xPESO_LIQ + xPESO_PRO[I]
			xPESO_BRT      := xPESO_BRT + xPESO_BRU[I]
			If SB1->B1_ALIQISS > 0
				AADD(xISS ,SB1->B1_ALIQISS)
			Endif
			xGRUPO  := SB1->B1_GRUPO
			_cClass := "" // AllTrim(SB1->B1_CLASONU)
			_cCat   := "" // AllTrim(SB1->B1_CATONU)
		EndFor
		If Subs(alltrim(xSERIE),1,1) == "P"
			xPESOBRUTO  := xPBRUT
			xPESOLIQUI  := xPLIQ
		Else
			xPESOBRUTO  := xPESO_BRT
			xPESOLIQUI  := xPESO_LIQ
		EndIf
		dbSelectArea("SE4")                    // Condicao de Pagamento
		dbSetOrder(1)
		dbSeek(xFilial("SE4")+xCOND_PAG)
		xDESC_PAG := SE4->E4_DESCRI
		If xTIPO == "D"
			dbSelectArea("SA1")                // * Cadastro de Clientes
			dbSetOrder(1)
			dbSeek(xFilial("SA1")+xFORNECE)
			xCOD_CLI  := SA1->A1_COD             // Codigo do Cliente
			xNOME_CLI := SA1->A1_NOME            // Nome
			xEND_CLI  := SA1->A1_END             // Endereco
			xBAIRRO   := SA1->A1_BAIRRO          // Bairro
			xCEP_CLI  := SA1->A1_CEP             // CEP
			xCOB_CLI  := SA1->A1_ENDCOB          // Endereco de Cobranca
			xREC_CLI  := SA1->A1_ENDENT          // Endereco de Entrega
			xMUN_CLI  := SA1->A1_MUN             // Municipio
			xEST_CLI  := SA1->A1_EST             // Estado
			xCGC_CLI  := SA1->A1_CGC             // CGC
			xINSC_CLI := SA1->A1_INSCR           // Inscricao estadual
			xTRAN_CLI := SA1->A1_TRANSP          // Transportadora
			xTEL_CLI  := SA1->A1_TEL             // Telefone
			xFAX_CLI  := SA1->A1_FAX             // Fax
		Else
			dbSelectArea("SA2")                // * Cadastro de Fornecedores
			dbSetOrder(1)
			dbSeek(xFilial("SA2")+xFORNECE+xLOJA)
			xCOD_CLI  := SA2->A2_COD                // Codigo do Cliente
			xNOME_CLI := SA2->A2_NOME               // Nome
			xEND_CLI  := SA2->A2_END                // Endereco
			xBAIRRO   := SA2->A2_BAIRRO             // Bairro
			xCEP_CLI  := SA2->A2_CEP                // CEP
			xCOB_CLI  := ""                         // Endereco de Cobranca
			xREC_CLI  := ""                         // Endereco de Entrega
			xMUN_CLI  := SA2->A2_MUN                // Municipio
			xEST_CLI  := SA2->A2_EST                // Estado
			xCGC_CLI  := SA2->A2_CGC                // CGC
			xINSC_CLI := SA2->A2_INSCR              // Inscricao estadual
			xTRAN_CLI := SA2->A2_TRANSP             // Transportadora
			xTEL_CLI  := SA2->A2_TEL                // Telefone
			xFAX      := SA2->A2_FAX                // Fax
		EndIf
		dbSelectArea("SE1")                   // * Contas a Receber
		dbSetOrder(1)
		xPARC_DUP   := {}                       // Parcela
		xVENC_DUP   := {}                       // Vencimento
		xVALOR_DUP  := {}                       // Valor
		xDUPLICATAS := IIF(dbSeek(xFilial("SE1")+xSERIE+xNUM_DUPLIC,.T.),.T.,.F.) // Flag p/Impressao de Duplicatas
        While !eof() .and. SE1->E1_NUM == xNUM_DUPLIC .and. xDUPLICATAS == .T. .and. (! empty(xNUM_DUPLIC))
			AADD(xPARC_DUP ,SE1->E1_PARCELA)
			AADD(xVENC_DUP ,SE1->E1_VENCTO)
			AADD(xVALOR_DUP,SE1->E1_VALOR)
			dbSkip()
		EndDo
		dbSelectArea("SF4")                   // * Tipos de Entrada e Saida
		dbSetOrder(1)
		dbSeek(xFilial("SF4")+xTES[1])
		xNATUREZA := SF4->F4_TEXTO              // Natureza da Operacao
		Imprime()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Termino da Impressao da Nota Fiscal                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncRegua()                    // Termometro de Impressao
		nLin := 0
		dbSelectArea("SF1")
		dbSkip()                     // e passa para a proxima Nota Fiscal
	EndDo
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fechamento do Programa da Nota Fiscal                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SF2")
Retindex("SF2")
dbSelectArea("SF1")
Retindex("SF1")
dbSelectArea("SD2")
Retindex("SD2")
dbSelectArea("SD1")
Retindex("SD1")
DBCOMMITALL()

Set Device To Screen
If aReturn[5] == 1
	Set Printer TO
	dbcommitAll()
	ourspool(wnrel)
Endif

dbSelectArea("TRB")
dbCloseArea()
Ferase(_cArqTmp)

MS_FLUSH()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ VERIMP()                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF PROTHEUS
   Static Function VerImp()
#ELSE
   Function VerImp
#ENDIF

nLin    := 0                // Contador de Linhas

If aReturn[5] == 2
	nOpc := 1
	#IFNDEF WINDOWS
		cCor := "B/BG"
	#ENDIF
	While .T.
		SetPrc(0,0)
		dbCommitAll()
		@ nLin ,000 PSAY " "
		@ nLin ,004 PSAY "."
		#IFNDEF WINDOWS
			Set Device to Screen
			DrawAdvWindow(" Formulario ",10,25,14,56)
			SetColor(cCor)
			@ 12,27 Say "Formulario esta posicionado?"
			nOpc := Menuh({"Sim","Nao","Cancela Impressao"},14,26,"b/w,w+/n,r/w","SNC","",1)
			Set Device to Print
		#ELSE
			IF MsgYesNo("Fomulario esta posicionado ? ")
				nOpc := 1
			ElseIF MsgYesNo("Tenta Novamente ? ")
				nOpc := 2
			Else
				nOpc := 3
			Endif
		#ENDIF
		Do Case
		Case nOpc == 1
			lContinua := .T.
			Exit
		Case nOpc == 2
			Loop
		Case nOpc == 3
			lContinua := .F.
			Return
		EndCase
	EndDo
Endif
Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ IMPDET()                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF PROTHEUS
   Static Function IMPDET()
#ELSE
   Function IMPDET
#ENDIF

@ nLin, 000 PSAY Chr(15)  // Compressao de Impressao
nTamDet     := 17         // Tamanho da Area de Detalhe
J           := 1
xB_ICMS_SOL := 0          // Base  do ICMS Solidario
xV_ICMS_SOL := 0          // Valor do ICMS Solidario
xVOLUME1    := 0
xCOMPLICMS  := {}
For I := 1 to nTamDet
	If I <= Len(xCOD_PRO)
		If xTipo == "I"  && se for complemento de Icms
			@ nLin,000  PSAY Chr(15)                    // Compressao de Impressao
			If mv_par09 == 1
				@ nlin,020  PSAY "Complemento de Icms ST"
			Else
				@ nlin,020  PSAY "Complemento de Icms"
			Endif
			
			J := J + 1
			xVOLUME1 := xVOLUME1 + xQTD_PRO[I]
		ElseIf xTipo == "P"  && se for complemento de IPI
			@ nLin,000  PSAY Chr(15)                    // Compressao de Impressao
            If xICMS_RET > 0
                 @ nlin,020  PSAY "Complemento de IPI e ICMS ST"
            ElseIf (xVALOR_ICMS > 0)
                 @ nlin,020  PSAY "Complemento de IPI e Icms "
            Else
                 @ nlin,020  PSAY "Complemento de IPI"
            Endif

			J := J + 1
			xVOLUME1 := xVOLUME1 + xQTD_PRO[I]
		EndIf
	Endif
	Exit
EndFor
For I := 1 to Len(xCOD_PRO)
	If I <= Len(xCOD_PRO)
		If xTipo <> "I" .and. xTipo <> "P"
			DbSelectArea("TRB")
			RecLock("TRB",.T.)
			TRB->PRODUTO   := xCOD_PRO[I]
			TRB->DESCRICAO := xDESCRICAO[I]
			TRB->CF        := xCF[I]
			TRB->CLASSIF   := xCLAS_FIS[I]
			TRB->TRIB      := xCOD_TRIB[I]
			TRB->UNID      := xUNID_PRO[I]
			TRB->QTDE      := xQTD_PRO[I]
			TRB->PRECO     := xPRE_UNI[I]
			TRB->VALOR     := xVAL_MERC[I]
			TRB->ICM       := xICM_PROD[I]
			TRB->IPI       := xIPI[I]
			TRB->VALIPI    := xVAL_IPI[I]
			TRB->VALST     := xVAL_RET[I]
			TRB->BASEST    := xVAL_BR[I]
			MsUnlock()
			xVOLUME1       := xVOLUME1 + xQTD_PRO[I]
			If .F. // mv_par04 == 2
				DbSelectArea("SZ3")
				DbSetOrder(3)
				If DbSeek(xfilial("SZ3")+xTES_INT[I])
					npElem := ascan(xMSGTES,Substr(SZ3->Z3_MENS,1,3))
					if npElem == 0
						AADD(xMSGTES ,Substr(SZ3->Z3_MENS,1,3))
					Endif
					npElem := ascan(xMSGTES,Substr(SZ3->Z3_MENS,5,3))
					if npElem == 0
						AADD(xMSGTES ,Substr(SZ3->Z3_MENS,5,3))
					Endif
					npElem := ascan(xMSGTES,Substr(SZ3->Z3_MENS,9,3))
					if npElem == 0
						AADD(xMSGTES,Substr(SZ3->Z3_MENS,9,3))
					Endif
					npElem := ascan(xMSGTES,Substr(SZ3->Z3_MENS,13,3))
					if npElem == 0
						AADD(xMSGTES,Substr(SZ3->Z3_MENS,13,3))
					Endif
					npElem := ascan(xMSGTES,Substr(SZ3->Z3_MENS,17,3))
					if npElem == 0
						AADD(xMSGTES,Substr(SZ3->Z3_MENS,17,3))
					Endif
				Endif
			ElseIf .F.
				dbSelectArea("SM4")
				DbSetOrder(1)
				dbSeek(xFilial("SM4")+xFOR_MENS[I])
				If found()
					npElem := ascan(xMSGTES,SM4->M4_CODIGO)
					if npElem == 0
						AADD(xMSGTES ,SM4->M4_CODIGO)
					Endif
				EndIf
			EndIf
		EndIf
	Endif
EndFor

_caio:= 0
DbSelectArea("TRB")
DBGOTOP()
While !eof()
	//If xTipo == "I"  && se for complemento de Icms ST
	If xTipo == "I"  .or. xTipo == "P"
		@ nLin,000  PSAY Chr(15)                // Compressao de Impressao
		@ nLin,004  PSAY TRB->PRODUTO
		@ nLin,020  PSAY TRB->DESCRICAO
		If !Empty(cNATUREZA2)
			@ nLin,065 PSAY TRB->CF Picture "@R 9.99"
		Endif
		@ nLin,076  PSAY TRB->CLASSIF
		@ nLin,092  PSAY TRB->TRIB
		@ nLin,096  PSAY TRB->UNID
		@ nLin,143  PSAY TRB->VALOR  Picture"@E 999,999,999.99"
		@ nLin,162  PSAY TRB->ICM  Picture"99"
		@ nLin,168  PSAY TRB->IPI  Picture"99"
		@ nLin,174  PSAY TRB->VALIPI Picture"@E 9,999,999.99"
	Else
		@ nLin,000  PSAY Chr(15)                // Compressao de Impressao
		@ nLin,004  PSAY TRB->PRODUTO
		@ nLin,020  PSAY TRB->DESCRICAO
		If !Empty(cNATUREZA2)
			@ nLin,065 PSAY TRB->CF Picture "@R 9.99"
		Endif
		@ nLin,076  PSAY TRB->CLASSIF
		@ nLin,092  PSAY TRB->TRIB
		@ nLin,096  PSAY TRB->UNID
		@ nLin,106  PSAY TRB->QTDE   Picture"@E 999,999,999.999"
		@ nLin,124  PSAY TRB->PRECO   Picture"@E 9,999,999.9999"
		@ nLin,143  PSAY TRB->VALOR  Picture"@E 999,999,999.99"
		@ nLin,162  PSAY TRB->ICM  Picture"99"
		@ nLin,168  PSAY TRB->IPI  Picture"99"
		@ nLin,174  PSAY TRB->VALIPI  Picture"@E 9,999,999.99"
	Endif
	_TotIPI := _TotIPI + TRB->VALIPI
	_TotVal := _TotVal + TRB->VALOR
	_TotST  := _TotST +  TRB->VALST
	_TotBas := _TotBas + TRB->BASEST
	_Trib   := TRB->TRIB
	nLin    := nLin + 1
	_caio   := _caio + 1
	Dbskip()
	If TRB->TRIB <>  _Trib .and. !eof()
		@ nlin,091 PSAY "SUB-TOTAL:"
		@ nlin,142 PSAY  _TotVal Picture "@E 999,999,999.99"
		@ nlin,171 PSAY  _TotIPI Picture "@E 999,999,999.99"
		nlin    := nlin + 1
		_TotVal := 0
		_TotIPI := 0
		AADD(xTRIB,_Trib)
		AADD(xTOTST,_TotST)
		_TotST  := 0
		_Mau    := _Mau + 1
	Endif
	If _caio > ntamdet
		@ 42, 002  PSAY "**************"  // Base do ICMS
		@ 42, 024  PSAY "**************"
		@ 42, 046  PSAY "**************"  // Base ICMS Ret.
		@ 42, 068  PSAY "**************"  // Valor ICMS Ret.
		@ 42, 090  PSAY "**************"
		@ 44, 002  PSAY "**************"
		@ 44, 024  PSAY "**************"
		@ 44, 046  PSAY "**************"
		@ 44, 068  PSAY "**************"
		@ 44, 090  PSAY "**************"
		nlin:= 54
		@ nlin,02 PSAY "Continua........"
		@ 66, 102 PSAY xNUM_NF                   // Numero da Nota Fiscal
		@ 72, 000 PSAY chr(18)                   // Descompressao de Impressao
		@ 72, 000 PSAY ""
		@ 01, 000 PSAY Chr(18)                // Descompressao de Impressao
		@ 01, 104 PSAY xNUM_NF               // Numero da Nota Fiscal
		If mv_par04 == 1
			@ 02, 082 PSAY "X"
		Else
			@ 02, 071 PSAY "X"
			@ 05,50 PSAY "N/Ped.Nr." + xPedido
		Endif
		If mv_par04 == 1
			@ 07, 003 PSAY xNATUREZA                      // Texto da Natureza de Operacao
		Else
			@ 07, 003 PSAY Alltrim(cNATUREZA1)           // Texto da Natureza de Operacao
		Endif
		If !Empty(cNATUREZA2)
			@ 07, Pcol() PSAY " / " + cNATUREZA2         // Texto da Natureza de Operacao
		Endif
		If !Empty(cNATUREZA2)
			@ 07, 037 PSAY cCF1 Picture"@R 9.99"         // Codigo da Natureza de Operacao
			@ 07, 041 PSAY "/"
			@ 07, 042 PSAY cCF2 Picture "@R 9.99"
			xNAT := cCF1
		Else
			IF MV_PAR04 == 2
				@ 07, 039 PSAY cCF1 Picture"@R 9.99"      // Codigo da Natureza de Operacao
				xNAT := cCF1
			ELSE
				@ 07, 039 PSAY xCF[1] Picture"@R 9.99"      // Codigo da Natureza de Operacao
				xNAT := xCF[1]
			Endif
		Endif
		If xFilial("SD2")=="02"
			IF SUBST(xNAT,1,1) >= "5"
				DbSelectArea("SX5")
				DbSetOrder(1)
				DbSeek(xFilial("SX5")+"Z1"+xEST_CLI)
				@ 07, 049 PSAY X5_DESCRI
			ENDIF
		elseif xFilial("SD2")=="03"
			IF SUBST(xNAT,1,1) >= "5" .AND. xEST_CLI == "ES"
				@ 07, 049 PSAY "000.016.76-4"
			ENDIF
		elseif xFilial("SD2")=="04"
			IF SUBST(xNAT,1,1) >= "5" .AND. xEST_CLI == "RJ"
				@ 07, 049 PSAY "91.019.434"
			ENDIF
		Endif
		If xBSICMRET > 0
			@ 07, 047 PSAY Tabela("98",xEST_CLI,.f.)
			xEST_PAR := GetMv("MV_ESTADO")
		EndIf
		@ 10, 002 PSAY alltrim(xNOME_CLI)     //Nome do Cliente
		If mv_par04 == 2
			If Pcol() < 60
				@ 10, Pcol() PSAY " - "+ xCLIENTE
			Endif
		Endif
		If !EMPTY(xCGC_CLI)                   // Se o C.G.C. do Cli/Forn nao for Vazio
			@ 10, 072 PSAY Trans(xCGC_CLI, "@R 99.999.999/9999-99")
		Else
			@ 10, 072 PSAY " "                // Caso seja vazio
		Endif
		@ 10, 099 PSAY xEMISSAO              // Data da Emissao do Documento
		@ 12, 002 PSAY xEND_CLI                                 // Endereco
		@ 12, 063 PSAY xBAIRRO                                  // Bairro
		@ 12, 085 PSAY xCEP_CLI Picture"@R 99999-999"           // CEP
		@ 12, 099 PSAY " "                                      // Reservado  p/Data Saida/Entrada
		@ 14, 002 PSAY xMUN_CLI                               // Municipio
		@ 14, 048 PSAY xTEL_CLI                               // Telefone/FAX
		@ 14, 067 PSAY xEST_CLI                               // U.F.
		@ 14, 071 PSAY xINSC_CLI                              // Insc. Estadual
		@ 14, 099 PSAY " "                                    // Reservado p/Hora da Saida
		If mv_par04 == 2
			nLin := 17
			BB   := 1
			nCol := 10             //  duplicatas
			DUPLIC()
		Endif
		nLin := 22
		_caio:= 0
	Endif
Enddo

If _Mau > 0
	@ nlin,091 PSAY "SUB-TOTAL:"
	@ nlin,142 PSAY  _TotVal Picture "@E 999,999,999.99"
	@ nlin,171 PSAY  _TotIPI Picture "@E 999,999,999.99"
	nlin:= nlin + 1
	_TotVal:= 0
	_TotIPI:= 0
	AADD(xTRIB,_Trib)
	AADD(xTOTST,_TotST)
	_TotST:= 0
	_Mau:= 0
Endif

DbSelectArea("TRB")
ZAP
@ nLin, 000 PSAY Chr(18)                // Descompressao de Impressao

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Funcao       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPMENP  ³ Autor ³   Marcos Simidu       ³ Data ³ 20/12/95 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio da Funcao    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

#IFDEF PROTHEUS
   Static Function IMPMENP()
#ELSE
   Function IMPMENP
#ENDIF

nCol := 02

If mv_par04 == 1 .AND. !EMPTY(xCODDI)
	@ nLin, 002 PSAY "D.I NR. "+xCODDI
	nLin := nLin + 1
EndIf

If !Empty(xCOD_MENS)
	If xCOD_MENS == "002"
		@ nLin, 002 PSAY "A MERCADORIA SAIRA DIRETAMENTE DA "
		@ nLin, 036 PSAY xNUM_DRF Picture "@z 99"
		@ nLin, 039 PSAY "¦ DRF EM "
		@ nLin, 048 PSAY xLOC_DRF
		nLin := nLin + 1
		@ nLin, 002 PSAY "CONFORME  N/NF N§ "
		@ nLin, 020 PSAY xNNF
		@ nLin, 027 PSAY "SERIE "
		@ nLin, 033 PSAY xSER_NNF
		@ nLin, 037 PSAY ", DE "
		@ nLin, 042 PSAY xDAT_NNF
		nLin := nLin + 1
	Else
		@ nLin, NCol PSAY SUBS(FORMULA(xCOD_MENS),1,68)
		nLin := nLin + 1
		@ nLin, NCol PSAY SUBS(FORMULA(xCOD_MENS),69,68)
		nLin := nLin + 1
		@ nLin, NCol PSAY SUBS(FORMULA(xCOD_MENS),138,34)
		nLin := nLin + 1
	EndIf
Endif

If !Empty(x2COD_MENS) .AND. SUBSTR(xPedido,1,1)<>"L"
	@ nLin, NCol PSAY SUBS(FORMULA(x2COD_MENS),1,68)
	nLin := nLin + 1
	@ nLin, NCol PSAY SUBS(FORMULA(x2COD_MENS),69,68)
	nLin := nLin + 1
	@ nLin, NCol PSAY SUBS(FORMULA(x2COD_MENS),138,34)
	nLin := nLin + 1
Endif

If (ASCAN(xTRIB,"01") <> 0  .or. ASCAN(xTRIB,"11") <> 0) .and. ASCAN(xTRIB,"03")<> 0 .or. ASCAN(xTRIB,"13") <> 0
	_Tot01:= 0
	_Tot03:= 0
	_acha:= ASCAN(xTRIB,"01")
	If _acha <> 0
		_Tot01:= _Tot01 + xTOTST[_acha]
	Endif
	_acha:= ASCAN(xTRIB,"11")
	If _acha <> 0
		_Tot01:= _Tot01 + xTOTST[_acha]
	Endif
	_acha:= ASCAN(xTRIB,"03")
	If _acha <> 0
		_Tot03:= _Tot03 + xTOTST[_acha]
	Endif
	_acha:= ASCAN(xTRIB,"13")
	If _acha <> 0
		_Tot03:= _Tot03 + xTOTST[_acha]
	Endif
	@ nlin, 002 PSAY "ICMS RETIDO OP. NAO TRIBUT. - R$ "
	@ nlin, 035 PSAY _Tot03 PIcture "@E 999,999,999.99"
	nlin:= nlin + 1
	@ nlin, 002 PSAY "ICMS RETIDO OP.TRIBUTADO    - R$ "
	@ nlin, 035 PSAY _Tot01 Picture "@E 999,999,999.99"
	nlin:= nlin + 1
Endif
xTOTST  := {}
_TotSt  := 0
xTRIB   := {}
_Tot01  := 0
_Tot03  := 0
_TotVal := 0
_TotIPI := 0

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Funcao       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MENSOBS  ³ Autor ³   Marcos Simidu       ³ Data ³ 20/12/95 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio da Funcao    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

#IFDEF PROTHEUS
   Static Function MENSOBS()
#ELSE
   Function MENSOBS
#ENDIF

nTamObs := 160
nCol    := 02
If !empty(xMENSAGEM)
	@ nLin, nCol PSAY UPPER(SUBSTR(xMENSAGEM,1,68))
	nlin := nlin + 1
	If !empty(Substr(xMensagem,69,1))
		@ nLin, nCol PSAY UPPER(SUBSTR(xMENSAGEM,69,68))
		nlin := nlin + 1
		If !empty(Substr(xMensagem,138,1))
			@ nLin, nCol PSAY UPPER(SUBSTR(xMENSAGEM,138,24))
			nlin := nlin + 1
		Endif
	Endif
Endif

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Funcao       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ DUPLIC   ³ Autor ³   Marcos Simidu       ³ Data ³ 20/12/95 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio da Funcao    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

#IFDEF PROTHEUS
   Static Function DUPLIC()
#ELSE
   Function DUPLIC
#ENDIF

nCol    := 5
nAjuste := 0
For BB  := 1 to Len(xVALOR_DUP)
	If xDUPLICATAS == .T. .and. BB <= Len(xVALOR_DUP)
		@ nLin, nCol + nAjuste      PSAY xNUM_DUPLIC  //+ " " + xPARC_DUP[BB]
		@ nLin, nCol + 12 + nAjuste PSAY xVALOR_DUP[BB] Picture("@E 9,999,999.99")
		@ nLin, nCol + 29 + nAjuste PSAY xVENC_DUP[BB]
		nAjuste := nAjuste + 45
		If nAjuste == 90
			nAjuste := 0
			nLin    := nLin + 1
		EndIf
	Endif
EndFor

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Funcao       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPRIME  ³ Autor ³   Marcos Simidu       ³ Data ³ 20/12/95 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
#IFDEF PROTHEUS
   Static Function Imprime()
#ELSE
   Function Imprime
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Cabecalho da N.F.      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 00, 000 PSAY Chr(18)                   // Descompressao de Impressao
*If xFilial("SF2") == "02" .AND.  SUBSTR(xSERIE,1,1) == "L"
*   @ 00, 028 PSAY REPLICATE("X",15)
*   @ 00, 044 PSAY "NOVA RAZAO SOCIAL :"
*   @ 01, 028 PSAY REPLICATE("X",15)
*   @ 01, 045 PSAY "YPF BRASIL S.A."
*EndIf
@ 01, 104 PSAY xNUM_NF                   // Numero da Nota Fiscal
If mv_par04 == 1
	@ 02, 082 PSAY "X"
Else
	@ 02, 071 PSAY "X"
	@ 05,50 PSAY "N/Ped.Nr."+xPedido
Endif
If mv_par04==1
	@ 07, 003 PSAY upper(xNATUREZA)                 // Texto da Natureza de Operacao
Endif
@ 07, 003 PSAY upper(Alltrim(cNATUREZA1))                 // Texto da Natureza de Operacao
If !Empty(cNATUREZA2)
	@ 07, Pcol() PSAY " / " + upper(Alltrim(cNATUREZA2))             // Texto da Natureza de Operacao
Endif
If !Empty(cNATUREZA2)
	@ 07, 037 PSAY cCF1 Picture"@R 9.99"      // Codigo da Natureza de Operacao
	@ 07, 041 PSAY "/"
	@ 07, 042 PSAY cCF2 Picture "@R 9.99"
	
	// LINHA INCLUIDA POR ANTONIO EM 16/12/99
	xNAT := cCF1

Else
	IF MV_PAR04 == 2
		@ 07, 039 PSAY cCF1 Picture"@R 9.99"      // Codigo da Natureza de Operacao
		xNAT := cCF1
	ELSE
		@ 07, 039 PSAY xCF[1] Picture"@R 9.99"      // Codigo da Natureza de Operacao
		xNAT := xCF[1]
	Endif
Endif
If xFilial("SD2")=="02"
	// IF SUBST(xNAT,1,1) >= "5" .AND. xEST_CLI $ "DF|MG|SC|RS|PR|GO|PA|ES|PE|RJ|BA|RN|MA|TO|AP|AM|SE|RO|PB|MS"
	IF SUBST(xNAT,1,1) >= "5"
		DbSelectArea("SX5")
		DbSetOrder(1)
		DbSeek(xFilial("SX5")+"Z1"+xEST_CLI)
		@ 07, 049 PSAY X5_DESCRI
	ENDIF
Elseif xFilial("SD2")=="03"
	IF SUBST(xNAT,1,1) >= "5" .AND. xEST_CLI == "ES"
		@ 07, 049 PSAY "000.016.76-4"
	ENDIF
Elseif xFilial("SD2")=="04"
	IF SUBST(xNAT,1,1) >= "5" .AND. xEST_CLI == "RJ"
		@ 07, 049 PSAY "91.019.434"
	ENDIF
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Substituto Tributario  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If xBSICMRET > 0
	@ 07, 047 PSAY Tabela("98",xEST_CLI,.f.)
	xEST_PAR := GetMv("MV_ESTADO")
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao dos Dados do Cliente      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 10, 002 PSAY alltrim(xNOME_CLI)     //Nome do Cliente
if mv_par04 == 2
	If Pcol() < 60
		@ 10, Pcol() PSAY " - "+ xCLIENTE
	Endif
Endif
If !EMPTY(xCGC_CLI)                   // Se o C.G.C. do Cli/Forn nao for Vazio
	@ 10, 072 PSAY xCGC_CLI Picture"@R 99.999.999/9999-99"
Else
	@ 10, 072 PSAY " "                // Caso seja vazio
Endif
@ 10, 099 PSAY xEMISSAO              // Data da Emissao do Documento
@ 12, 002 PSAY xEND_CLI                                 // Endereco
@ 12, 063 PSAY xBAIRRO                                  // Bairro
@ 12, 085 PSAY xCEP_CLI Picture"@R 99999-999"           // CEP
@ 12, 099 PSAY " "                                      // Reservado  p/Data Saida/Entrada
@ 14, 002 PSAY xMUN_CLI                               // Municipio
@ 14, 048 PSAY xTEL_CLI                               // Telefone/FAX
@ 14, 067 PSAY xEST_CLI                               // U.F.
@ 14, 071 PSAY xINSC_CLI                              // Insc. Estadual
@ 14, 099 PSAY " "                                    // Reservado p/Hora da Saida
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao da Fatura/Duplicata       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par04 == 2
	nLin := 17
	BB   := 1
	nCol := 10             //  duplicatas
	DUPLIC()
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Dados dos Produtos Vendidos         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLin := 22
ImpDet()                 // Detalhe da NF


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Mensagem Corpo Nota fiscal  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! Empty(x2Cod_mens) .AND. Substr(xPedido,1,1)=="L"
	DBSELECTAREA("SM4")
	IF DBSEEK(XFILIAL()+x2Cod_mens)
		@ 38, 000 PSAY CHR(15)
		@ 38, 006 PSAY FORMULA(x2Cod_mens)
		@ 38, 220 PSAY CHR(18)
	ENDIF
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calculo dos Impostos                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If xTipo == "I"  && se for complemento de Icms
	@ 42, 002  PSAY xBASE_ICMS  Picture "@E@Z 999,999,999.99"  // Base do ICMS
	@ 42, 024  PSAY xVALOR_ICMS Picture "@E@Z 999,999,999.99"  // Valor do ICMS
	If mv_par09==1
		@ 42, 046  PSAY xBSICMRET   Picture "@E@Z 999,999,999.99"  // Base ICMS Ret.
		@ 42, 068  PSAY xICMS_RET   Picture "@E@Z 999,999,999.99"  // Valor do IPI
		@ 44, 090  PSAY xICMS_RET    Picture "@E@Z 999,999,999.99"  // Valor Total NF
	Endif
ElseIf xTipo == "P"
    //Casos especificos de complemento de IPI com adicionamento de icms st ou icm proprio
    If (xICMS_RET) > 0 .or. (xVALOR_ICMS > 0)
        @ 42, 024  PSAY xVALOR_ICMS Picture "@E@Z 999,999,999.99"  // Valor do ICMS
		@ 42, 068  PSAY xICMS_RET   Picture "@E@Z 999,999,999.99"  // Valor do IPI
        @ 44, 068  PSAY xVALOR_IPI  Picture "@E@Z 999,999,999.99"  // Valor do IPI
        @ 44, 090  PSAY xTOT_FAT    Picture "@E@Z 999,999,999.99"  // Valor Total NF
    Else
        @ 44, 068  PSAY xVALOR_IPI  Picture "@E@Z 999,999,999.99"  // Valor do IPI
        @ 44, 090  PSAY xTOT_FAT    Picture "@E@Z 999,999,999.99"  // Valor Total NF
    Endif
Else
	If xEST_CLI =="SP" .and. xBSICMRET > 0 .and. xFilial()=="02"
		@ 42, 002  PSAY xBASE_ICMS  Picture "@E@Z 999,999,999.99"  // Base do ICMS
		@ 42, 046  PSAY xBSICMRET   Picture "@E@Z 999,999,999.99"  // Base ICMS Ret.
		@ 42, 068  PSAY xICMS_RET   Picture "@E@Z 999,999,999.99"  // Valor ICMS Ret.
	Else
		@ 42, 002  PSAY xBASE_ICMS  Picture "@E@Z 999,999,999.99"  // Base do ICMS
		@ 42, 024  PSAY xVALOR_ICMS Picture "@E@Z 999,999,999.99"  // Valor do ICMS
		@ 42, 046  PSAY xBSICMRET   Picture "@E@Z 999,999,999.99"  // Base ICMS Ret.
		@ 42, 068  PSAY xICMS_RET   Picture "@E@Z 999,999,999.99"  // Valor ICMS Ret.
	Endif
	@ 42, 090  PSAY xVALOR_MERC Picture "@E@Z 999,999,999.99"  // Valor Tot. Prod.
	@ 44, 002  PSAY xFRETE          Picture "@E@Z 999,999,999.99"  // Valor do Frete
	@ 44, 024  PSAY xSEGURO         Picture "@E@Z 999,999,999.99"  // Valor Seguro
	If mv_par04 == 2
		@ 44, 046  PSAY xDESPESA        Picture "@E@Z 999,999,999.99"  // Valor Despesa
	EndIf
	@ 44, 068  PSAY xVALOR_IPI  Picture "@E@Z 999,999,999.99"  // Valor do IPI
	@ 44, 090  PSAY xTOT_FAT    Picture "@E@Z 999,999,999.99"  // Valor Total NF
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao Dados da Transportadora  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If xTipo <> "I"  && se for complemento de Icms
If xTipo <> "I" .and. xTipo <> "P"
	If mv_par04 == 2
		@ 47,002      PSAY xNOME_TRANSP                                               // Nome da Transport.
		If xTPFRETE == 'C'                                   // Frete por conta do
			@ 47, 071 PSAY "1"                              // Emitente (1)
		Else                                                                                           //     ou
			@ 47, 071 PSAY "2"                              // Destinatario (2)
		Endif
		@ 47, 076 PSAY xPLACA                                  // Res. p/Placa do Veiculo
		@ 47, 086 PSAY xEST_VEIC                             // Res. p/xEST_TRANSP                          // U.F.
		If !EMPTY(xCGC_TRANSP)                                                          // Se C.G.C. Transportador nao for Vazio
			@ 47, 089 PSAY xCGC_TRANSP Picture"@R 99.999.999/9999-99"
		Else
			@ 47, 089 PSAY " "                               // Caso seja vazio
		Endif
		@ 49, 002 PSAY xEND_TRANSP                                              // Endereco Transp.
		@ 49, 064 PSAY xMUN_TRANSP                                              // Municipio
		@ 49, 085 PSAY xEST_TRANSP                                              // U.F.
		@ 49, 089 PSAY " "                                  // Reservado p/Insc. Estad.
	EndIf
	
	@ 51, 003 PSAY ROUND(xVOLUME1,0)  Picture "@Z 999999999"             // Quant. Volumes
	
	If !Empty(xVOLUME2)
		@ 51, 005 PSAY "/"
		@ 51, 006 PSAY xVOLUME2  Picture "@Z 999"             // Quant. Volumes
		If !Empty(xVOLUME3)
			@ 51, 009 PSAY "/"
			@ 51, 010 PSAY xVOLUME3  Picture "@Z 999"             // Quant. Volumes
		EndIf
	EndIf
	
	If Subs(Alltrim(xSerie),1,1) == "P"
		IF EMPTY(xESPECIE1)
			@ 51, 016 PSAY "GRANEL LIQUIDO"                        // Especie
		ELSE
			@ 51, 016 PSAY xESPECIE1 Picture "@!"                 // Especie
		ENDIF
	Else
		@ 51, 016 PSAY xESPECIE1 Picture "@!"                 // Especie
	Endif
	
	If !Empty(xESPECIE2)
		@ 51, 026 PSAY "/"
		@ 51, 027 PSAY xESPECIE2 Picture "@!"                 // Especie
		If !Empty(xESPECIE3)
			@ 51, 036 PSAY "/"
			@ 51, 037 PSAY xESPECIE3 Picture "@!"                 // Especie
		EndIf
	EndIf
	
	IF EMPTY(xMARCA)
		@ 51, 052 PSAY "YPF"                        // MARCA
	ELSE
		@ 51, 052 PSAY xMARCA Picture "@!"                 // Especie
	ENDIF
	@ 51, 052 PSAY " "                                           // Res para Marca
	@ 51, 066 PSAY " "                                           // Res para Numero
	@ 51, 079 PSAY xPESOBRUTO  Picture "@E@Z 9999,999.99"      // Peso Bruto
	@ 51, 094 PSAY xPESOLIQUI  Picture "@E@Z 9999,999.99"      // Peso Liquido
EndIf

If xTipo == "I" .or. xTipo == "P"
	dbSelectArea("SF2")                // * Cabecalho da Nota Fiscal Saida
	_nRegistro := Recno()
	dbSetOrder(1)
	dbSeek(xFilial("SF2")+xNUM_NFDV[1]+xPREF_DV[1],.t.)
	xEmissao := SF2->F2_EMISSAO
	dbGoTo(_nRegistro)
	nLin := 54

    If xTipo == "I"
        If mv_par09 == 1
            @ 54, 002 PSAY "Nota Fiscal Complementar de ICMS ST "
        Else
            @ 54, 002 PSAY "Nota Fiscal Complementar de ICMS "
        Endif
    ElseIf xTipo == "P"
        If (xICMS_RET) > 0
             @ 54, 002 PSAY "Nota Fiscal Complementar de IPI e ICMS ST"
        ElseIf (xVALOR_ICMS) > 0
             @ 54, 002 PSAY "Nota Fiscal Complementar de IPI e Icms"
        Else
             @ 54, 002 PSAY "Nota Fiscal Complementar de IPI "
        Endif
    Endif
	@ 55, 002 PSAY "Referente a N/NF : "+xNUM_NFDV[1]+" de "+DtoC(xEMISSAO)
	nLin := 55
    If xEST_CLI =="SP" .and. xVALOR_ICMS > 0 .and. xFilial()=="02" .and. xTipo<>"I" .and. xTipo<>"P"
		nLin := nLin + 2
		@ nLin, 002 PSAY "ICMS Proprio : R$ "
		@ nLin, 020 PSAY xVALOR_ICMS Picture"@E@Z 999,999,999.99"  // Valor do ICMS
	EndIf
ElseIf xTipo == "C"
	dbSelectArea("SF2")                // * Cabecalho da Nota Fiscal Saida
	_nRegistro := Recno()
	dbSetOrder(1)
	dbSeek(xFilial("SF2")+xNUM_NFDV[1]+xPREF_DV[1],.t.)
	xEmissao := SF2->F2_EMISSAO
	dbGoTo(_nRegistro)
	nLin := 54
	@ 54, 002 PSAY "NOTA FISCAL COMPLEMENTAR DE PRECO REF. N/NF : "+xNUM_NFDV[1]
	nLin := 57
    If xEST_CLI =="SP" .and. xBSICMRET > 0 .and. xTIPO<>"I" .and. xTIPO<>"P" .and. xFilial()=="02"
		nLin := nLin + 1
		@ nLin, 002 PSAY "ICMS Proprio : R$ "
		@ nLin, 020 PSAY xVALOR_ICMS Picture"@E@Z 999,999,999.99"  // Valor do ICMS
	EndIf
Else
	nLin := 54
    If xEST_CLI =="SP" .and. xBSICMRET > 0 .and. xTIPO<>"I" .and. xTIPO<>"P" .and. xFilial()=="02"
		nLin := nLin + 1
		@ nLin, 002 PSAY "ICMS Proprio : R$ "
		@ nLin, 020 PSAY xVALOR_ICMS Picture"@E@Z 999,999,999.99"  // Valor do ICMS
		nLin:= nLin + 1
	Endif
	
	If Subs(Alltrim(xSerie),1,1) == "P"
		If alltrim(xGRUPO) $ mv_par05
			@ nLin, 002 PSAY "NUMERO DE RISCO: "+_cCat+" - CLASSIF.ONU: "+_cClass
		Elseif alltrim(xGRUPO) $ mv_par06
			@ nLin, 002 PSAY "PRODUTO NAO CLASSIFICADO NA ONU"
		EndIf
		nLin:= nLin + 1
	Endif
	
	For I := 1 to Len(xMSGTES)
		dbSelectArea("SM4")                   // * Mensagens
		DbSetOrder(1)
		dbSeek(xFilial("SM4")+xMSGTES[I])
		If found()
			@ nlin,002 PSAY Substr(SM4->M4_FORMULA,1,72)
			nlin:= nlin + 1
			If !empty(Substr(SM4->M4_FORMULA,73,1))
				@ nlin,002 PSAY Substr(SM4->M4_FORMULA,73,72)
				nlin:= nlin + 1
				If !empty(Substr(SM4->M4_FORMULA,145,1))
					@ nlin,002 PSAY Substr(SM4->M4_FORMULA,145,56)
					nlin:= nlin + 1
				Endif
			Endif
		EndIf
	EndFor
	
	If mv_par04 == 2
		nLin := nLin + 1
		MensObs()             // Imprime Mensagem de Observacao C5_MENPAD
	EndIf
	ImpMenp()             // Imprime Mensagem Padrao da Nota Fiscal
	If Len(xNUM_NFDV) > 0  .and. !Empty(xNUM_NFDV[1])
		@ 62, 002 PSAY "Nota Fiscal Original No." + "  " + xNUM_NFDV[1] + "  " + xPREF_DV[1]
	Endif
EndIf

@ 66, 102 PSAY xNUM_NF                   // Numero da Nota Fiscal
@ 72, 000 PSAY chr(18)                   // Descompressao de Impressao
@ 72, 000 PSAY ""
SetPrc(0,0)                              // (Zera o Formulario)

Return .T.
