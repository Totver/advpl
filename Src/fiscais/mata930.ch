#ifdef SPANISH
	#define STR0001 "Esta rutina rehace los libros fiscales referente al periodo"
	#define STR0002 "y el tipo informado, si es Entrada o Salida. ATENCION! Esta rutina"
	#define STR0003 "debera ser ejecutada en modo monousuario."
	#define STR0004 "Reprocesamiento Fiscal"
	#define STR0005 "FACTURA DE SERVICIO"
	#define STR0006 "Fecha: "
	#define STR0007 "Nota: "
	#define STR0008 "Se finalizo con exito."
#else
	#ifdef ENGLISH
		#define STR0001 "This routine will remake Tax Records referring to the period"
		#define STR0002 "entered and the Type of Inflow/Outflow. ATTENTION! This routine"
		#define STR0003 "must run in monouser mode."
		#define STR0004 "Fiscal Reprocessing"
		#define STR0005 "SERVICE INVOICE"
		#define STR0006 "Date: "
		#define STR0007 "Inv.: "
		#define STR0008 "Successfully concluded."
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Este procedimento irá refazer os livros fiscais referentes ao período", "Esta  rotina ira refazer os Livros Fiscais referente ao periodo" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Introduzido e o tipo, se entrada ou saída. atenção! este procedimento", "informado e o tipo, se Entrada ou Saída. ATENCAO! Esta rotina" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Deverá ser executado em modo mono-utilizador.", "devera ser executada em modo mono-usuario." )
		#define STR0004 "Reprocessamento Fiscal"
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Fcatura De Serviço", "NT.FISCAL DE SERVICO" )
		#define STR0006 "Data: "
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Factura: ", "Nota: " )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Concluído com sucesso.", "Finalizado com sucesso." )
	#endif
#endif
