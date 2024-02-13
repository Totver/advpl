#ifdef SPANISH
	#define STR0001 "ERROR MATXFIS - Referencia de impuesto no valida : "
	#define STR0002 "ERROR MATXFIS - Referencia de impuesto no valida "
	#define STR0003 "Cod."
	#define STR0004 "Descripcion"
	#define STR0005 "Base Impuesto"
	#define STR0006 "Alicuota"
	#define STR0007 "Vlr. Impuesto"
	#define STR0008 "FACT ANULADA"
	#define STR0009 "DIVERSAS"
	#define STR0010 "FACTURA DE SERVICIO"
	#define STR0011 "DEVOLUC. FACT.:"
	#define STR0012 "FACT.DE FLETE"
	#define STR0013 "FACT.GASTO"
	#define STR0014 "COMPL.PC.FACT: "
	#define STR0015 "FACT.ORIG: "
	#define STR0016 "COMPL.IPI FACT: "
	#define STR0017 "COMPL.ICMS FACT: "
	#define STR0018 "EXPORTAC.-GE Nro.: "
	#define STR0019 "ADQUIS.COMERC.NO-CONTRIB.IPI"
	#define STR0020 "Dev. Benef. FACT.ORIG: "
	#define STR0021 "CONT.SEG.SOCIAL: "
	#define STR0022 "COMPL.ISS FACT.: "
	#define STR0023 "Datos de Cobranza del ISS"
	#define STR0024 "Si"
	#define STR0025 "No"
	#define STR0026 "No existe tabla registrada para el codigo de municipio."
	#define STR0027 "¡Intervalo del ISS progresivo no encontrada!"
	#define STR0028 "¡El Calculo progresivo no se efectuara!"
	#define STR0029 "Por favor, verificar si la rutina MATXFIS esta actualizada de acuerdo con el "
	#define STR0030 "ultimo paquete disponible en el Portal del Cliente en la categoria Patch de Programa."
	#define STR0031 "En caso de que el problema persista con la rutina MATXFIS actualizada, entre en contacto con el HelpDesk."
	#define STR0032 "Divide Item, Tributado vs No Tributado"
	#define STR0033 "Para el control correcto de la generacion del IPI, sera necesario dividir en dos items:"
	#define STR0034 "Item: "
	#define STR0035 "/ Producto: "
	#define STR0036 "/ Lote: "
	#define STR0037 "/ Sublote: "
	#define STR0038 "1- Cantidad Tributada:"
	#define STR0039 "2- Cantidad No Tributada:"
	#define STR0040 "No hubo modificacion del calculo del IPI"
	#define STR0041 "Salir"
#else
	#ifdef ENGLISH
		#define STR0001 "ERROR MATXFIS - Invalid tax reference : "
		#define STR0002 "ERROR MATXFIS - Invalid tax reference : "
		#define STR0003 "Code"
		#define STR0004 "Descript."
		#define STR0005 "Tax Basis"
		#define STR0006 "Tax Rate"
		#define STR0007 "Tax Value"
		#define STR0008 "CANCELLED INVOICE"
		#define STR0009 "OTHER"
		#define STR0010 "SERVICE INVOICE"
		#define STR0011 "INVOICE RETURN:"
		#define STR0012 "WAYBILL"
		#define STR0013 "EXP INVOI."
		#define STR0014 "COMPL.PC.INV.: "
		#define STR0015 "SOUR.INV.: "
		#define STR0016 "COMPL.IPI INV.: "
		#define STR0017 "COMPL.ICMS INV.: "
		#define STR0018 "EXPORT-GE Numb.: "
		#define STR0019 "COMM.ACQUISI.NON-CONTRIB.IPI"
		#define STR0020 "SOUR.INV. Benef.Deb: "
		#define STR0021 "SOC.SECUR.CONT.: "
		#define STR0022 "INV. ISS COMPL.: "
		#define STR0023 "ISS Collection Data"
		#define STR0024 "Yes"
		#define STR0025 "No "
		#define STR0026 "There are is no table registered for city code."
		#define STR0027 "Progressive ISS range not found!"
		#define STR0028 "Progressive calculation will not be performed!"
		#define STR0029 "Please, check whether MATXFIS routine is updated according to "
		#define STR0030 "last patch available in Customer Portal related to Program Patch category."
		#define STR0031 "In case the problem persists with MATXFIS updated routine, please contact Help Desk."
		#define STR0032 "Item Break, Taxed x Not Taxed"
		#define STR0033 "For correct control of IPI generation, it is necessary to break into two items:"
		#define STR0034 "Item: "
		#define STR0035 "/ Product: "
		#define STR0036 "/ Lot: "
		#define STR0037 "/ Sub-lot: "
		#define STR0038 "1- Taxed Amount:"
		#define STR0039 "2 - Non-taxed Amount:"
		#define STR0040 "No changes to IPI calculation"
		#define STR0041 "Exit"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Erro matxfis - referencia de imposto inválida : ", "ERRO MATXFIS - Referencia de imposto invalida : " )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Erro matxfis - referencia de imposto inválida ", "ERRO MATXFIS - Referencia de imposto invalida " )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Cód.", "Cod." )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Descrição", "Descricao" )
		#define STR0005 "Base Imposto"
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Taxa", "Aliquota" )
		#define STR0007 "Vlr. Imposto"
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Nf Cancelada", "NF CANCELADA" )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Diversas", "DIVERSAS" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Fcatura De Serviço", "NT.FISCAL DE SERVICO" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Devolução N.f.:", "DEVOLUCAO N.F.:" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Conhecer Frete", "CONHEC. FRETE" )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Nf Despesa", "NF DESPESA" )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Compl.n.f.: ", "COMPL.N.F.: " )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "N.f.orig.: ", "N.F.ORIG.: " )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Compl.ipi n.f.: ", "COMPL.IPI N.F.: " )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Compl.icms n.f.: ", "COMPL.ICMS N.F.: " )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Exportação-ge no.: ", "EXPORTACAO-GE No.: " )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Aquis.comerc.nao-contrib.ipi", "AQUIS.COMERC.NAO-CONTRIB.IPI" )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Dev. terc. n.f.orig.: ", "Dev. terc. N.F.ORIG.: " )
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "Cont.seg.social: ", "CONT.SEG.SOCIAL: " )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "Compl.iss n.f.: ", "COMPL.ISS N.F.: " )
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "Dados De Cobrança Do Ss", "Dados de Cobranca do ISS" )
		#define STR0024 "Sim"
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "Não", "Nao" )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "Não existe tabela registada para o código de município.", "Não existe tabela cadastrada para o código de municipio." )
		#define STR0027 "Faixa do ISS progressivo não encontrada!"
		#define STR0028 If( cPaisLoc $ "ANG|PTG", "O Cálculo progressivo não será efectuado!", "O Cálculo progressivo não será efetuado!" )
		#define STR0029 If( cPaisLoc $ "ANG|PTG", "Favor verificar se a rotina MATXFIS está actualizada conforme ", "Favor verificar se a rotina MATXFIS está atualizada conforme " )
		#define STR0030 "o último pacote disponível no Portal do Cliente na categoria Patch de Programa."
		#define STR0031 If( cPaisLoc $ "ANG|PTG", "Caso o problema persista com o procedimento MATXFIS actualizada, favor contactar o HelpDesk.", "Caso o problema persista com a rotina MATXFIS atualizada, favor entrar em contato com o HelpDesk." )
		#define STR0032 "Quebra Item, Tributado x Não Tributado"
		#define STR0033 "Para controle correto da geração do IPI, será necessário quebrar em dois Itens:"
		#define STR0034 "Item: "
		#define STR0035 "/ Produto: "
		#define STR0036 "/ Lote: "
		#define STR0037 "/ Sub-Lote: "
		#define STR0038 "1- Quantidade Tributada:"
		#define STR0039 "2- Quantidade Não Tributada:"
		#define STR0040 "Não houve alteração do calculo do IPI"
		#define STR0041 "Sair"
	#endif
#endif
