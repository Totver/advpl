#ifdef SPANISH
	#define STR0001 "Confirma"
	#define STR0002 "Salir"
	#define STR0003 "Parametros"
	#define STR0004 "Archivo Magnetico"
	#define STR0005 "Este programa genera archivo preformateado de asientos fiscales"
	#define STR0006 "para entregar a las Secret.de Recaud. de Imp.Provinciales de la "
	#define STR0007 "Guia de Informacion y Calculo del ICMS (GIA)."
	#define STR0008 "Selec. Facturas..."
	#define STR0009 "Indexando Detalles de CFOP"
	#define STR0010 "Indexando operaciones interprovinciales"
	#define STR0011 "Indexando ZFM/ALC"
	#define STR0012 "Indexando Eventos"
	#define STR0013 "Indexando Remitentes"
	#define STR0014 "¿Vs.Sist. Nueva GIA?"
	#define STR0015 "¿Vs.LayOut Nueva GIA?"
	#define STR0016 "Indexando Ie_Sustituto"
	#define STR0017 "Indexando Ie_Sustituido"
	#define STR0018 "Drive Destino"
	#define STR0019 "Año y Mes de referencia incorrectos"
	#define STR0020 "El registro DIPAM no corresponde al año y mes de referencia de la Gia"
	#define STR0021 "¿Regimen Tributario?"
	#define STR0022 "RPA"
	#define STR0023 "RES"
	#define STR0024 "RPA-Eximido"
	#define STR0025 "Simple-ST"
	#define STR0026 "Informe la sucursal inicial tratandose de"
	#define STR0027 "procesamiento consolidado.              "
	#define STR0028 "Sucursal De"
	#define STR0029 "Informe la sucursal final tratandose de "
	#define STR0030 "Sucursal A"
	#define STR0031 "Informe si desea efectuar la seleccion de las"
	#define STR0032 "Sucursales que se consideraran en el "
	#define STR0033 "Procesamiento, rutina depende del parametro"
	#define STR0034 "(Procesa Sucursales igual a SI)."
	#define STR0035 "Informe si desea efectuar la seleccion de las"
	#define STR0036 "Sucursales que se consideraran en el "
	#define STR0037 "Procesamiento, rutina depende del parametro"
	#define STR0038 "(Procesa Sucursales igual a SI."
	#define STR0039 "Informe si desea efectuar la seleccion de las"
	#define STR0040 "Sucursales que se consideraran en el "
	#define STR0041 "Procesamiento, rutina depende del parametro"
	#define STR0042 "(Procesa Sucursales igual a SI."
	#define STR0043 "¿Selecciona Sucursales?"
	#define STR0044 "¿Selecciona Sucursales?"
	#define STR0045 "¿Selecciona Sucursales?"
#else
	#ifdef ENGLISH
		#define STR0001 "Confirm"
		#define STR0002 "Quit"
		#define STR0003 "Parameters"
		#define STR0004 "Magnetic File"
		#define STR0005 "This program generated a pre-formatted file on fiscal entries"
		#define STR0006 "to send to State Finance Secretariat based on GIA (ICMS  "
		#define STR0007 "Calculation Report )."
		#define STR0008 "Selec.Invoices..."
		#define STR0009 "Indexing CFOP Details"
		#define STR0010 "Indexing Interestate Operations"
		#define STR0011 "Indexing ZFM/ALC"
		#define STR0012 "Indexing Occurrences"
		#define STR0013 "Indexing Senders"
		#define STR0014 "Vs.Syst. New GIA?"
		#define STR0015 "Vs.LayOut New  GIA?"
		#define STR0016 "Indexing  Ie_Substituto"
		#define STR0017 "Indexing  Ie_Substituido"
		#define STR0018 "Destination Drive"
		#define STR0019 "Year and Month of reference are incorrect"
		#define STR0020 "The DIPAM registration does not correspond to the GIA reference month and year"
		#define STR0021 "Taxation Regimen  ?"
		#define STR0022 "RPA"
		#define STR0023 "RES"
		#define STR0024 "RPA-Released  "
		#define STR0025 "Simple-ST"
		#define STR0026 "Enter initial branch in case of "
		#define STR0027 "consolidated processing.                "
		#define STR0028 "From branch"
		#define STR0029 "Enter final branch in case of processing"
		#define STR0030 "To branch "
		#define STR0031 "Inform if you want to select"
		#define STR0032 "Branches to be considered in the "
		#define STR0033 "processing, routine depends on the paramenter"
		#define STR0034 "(Process Branch equals to YES)."
		#define STR0035 "Inform if you want to select the"
		#define STR0036 "Branches to be considered in "
		#define STR0037 "Processing. Routine depends on the parameter"
		#define STR0038 "(Process Branches equals to YES."
		#define STR0039 "Inform if you want to select "
		#define STR0040 "Branches to be considered in "
		#define STR0041 "processing, routine which depends on the parameter"
		#define STR0042 "(Process Branches equal to YES."
		#define STR0043 "Select branches?"
		#define STR0044 "Select branches?"
		#define STR0045 "Select branches?"
	#else
		#define STR0001 "Confirma"
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Abandonar", "Abandona" )
		#define STR0003 "Parâmetros"
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Ficheiro magnético", "Arquivo Magnético" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Este programa cria ficheiro pré-formatado dos lançamentos fiscais", "Este programa gera arquivo pré-formatado dos lançamentos fiscais" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Para entrega às secretarias de finanças distritais da guia de  ", "para entrega as Secretarias de Fazenda Estaduais da Guia de  " )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Informação e apuro do icms (gia ).", "Informacao e Apuracao do ICMS (GIA )." )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Selec.notas fiscais...", "Selec.Notas fiscais..." )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "A Indexar Detalhes De Código Fiscal", "Indexando Detalhes de CFOP" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "A indexar operações interdistritais", "Indexando Operacoes interestaduais" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "A Indexar Zfm/alc", "Indexando ZFM/ALC" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "A Indexar Ocorrências", "Indexando Ocorrencias" )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "A Indexar Remetentes", "Indexando Remetentes" )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Vs.sist. Nova Gia?", "Vs.Sist. Nova GIA?" )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Vs.layout Nova Gia?", "Vs.LayOut Nova GIA?" )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "A Indexar Ie_substituto", "Indexando Ie_Substituto" )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "A Indexar Ie_substituído", "Indexando Ie_Substituido" )
		#define STR0018 "Drive Destino"
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Ano e mês de referência incorrectos", "Ano e Mês de Referência Incorretos" )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "O registo dipam não corresponde ao ano e mês de referência da gia", "O Registro DIPAM não corresponde ao ano e mes de referencia da Gia" )
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "Regime tributário ?", "Regime Tributario ?" )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "Rpa", "RPA" )
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "Res", "RES" )
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "Rpa-dispensado", "RPA-Dispensado" )
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "Simples-st", "Simples-ST" )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "Indique a filial inicial no caso de pro-", "Informe a filial inicial no caso de pro-" )
		#define STR0027 If( cPaisLoc $ "ANG|PTG", "Cessamento consolidado.                 ", "cessamento consolidado.                 " )
		#define STR0028 "Filial De"
		#define STR0029 If( cPaisLoc $ "ANG|PTG", "Indique a filial final  no caso de  pro-", "Informe a filial final  no caso de  pro-" )
		#define STR0030 If( cPaisLoc $ "ANG|PTG", "Filial Até", "Filial Ate" )
		#define STR0031 If( cPaisLoc $ "ANG|PTG", "Informe se deseja efectuar a selecção das", "Informe de deseja efetuar a seleção das" )
		#define STR0032 "Filiais a serem consideradas no "
		#define STR0033 If( cPaisLoc $ "ANG|PTG", "processamento, rotina depende do parâmetro", "Processamento, rotina depende do parâmetro" )
		#define STR0034 "(Processa Filiais igual a SIM)."
		#define STR0035 If( cPaisLoc $ "ANG|PTG", "Informe se deseja efectuar a selecção das", "Informe de deseja efetuar a seleção das" )
		#define STR0036 "Filiais a serem consideradas no "
		#define STR0037 If( cPaisLoc $ "ANG|PTG", "processamento, rotina depende do parâmetro", "Processamento, rotina depende do parâmetro" )
		#define STR0038 "(Processa Filiais igual a SIM."
		#define STR0039 If( cPaisLoc $ "ANG|PTG", "Informe se deseja efectuar a selecção das", "Informe de deseja efetuar a seleção das" )
		#define STR0040 "Filiais a serem consideradas no "
		#define STR0041 If( cPaisLoc $ "ANG|PTG", "processamento, rotina depende do parâmetro", "Processamento, rotina depende do parâmetro" )
		#define STR0042 "(Processa Filiais igual a SIM."
		#define STR0043 If( cPaisLoc $ "ANG|PTG", "Selecciona Filiais?", "Seleciona Filiais ?" )
		#define STR0044 If( cPaisLoc $ "ANG|PTG", "Selecciona Filiais?", "Seleciona Filiais ?" )
		#define STR0045 If( cPaisLoc $ "ANG|PTG", "Selecciona Filiais?", "Seleciona Filiais ?" )
	#endif
#endif
