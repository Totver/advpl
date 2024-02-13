#INCLUDE "PARMTYPE.CH"
#INCLUDE "FWMBROWSE.CH"

//------------------------------------------------------------
//Conjunto de especificacoes do ProtheusFunctionMVC
//------------------------------------------------------------
#DEFINE FORM_STRUCT_TABLE_MODEL       1
#DEFINE FORM_STRUCT_TABLE_TRIGGER     2
#DEFINE FORM_STRUCT_TABLE_VIEW        3
#DEFINE FORM_STRUCT_TABLE_FOLDER      4
#DEFINE FORM_STRUCT_TABLE_GROUP       5
#DEFINE FORM_STRUCT_TABLE_ALIAS       6
#DEFINE FORM_STRUCT_TABLE_INDEX       7
#DEFINE FORM_STRUCT_TABLE_BROWSE      8

#DEFINE FORM_STRUCT_TABLE_ALIAS_ID          1
#DEFINE FORM_STRUCT_TABLE_ALIAS_PK          2
#DEFINE FORM_STRUCT_TABLE_ALIAS_DESCRIPTION 3

#DEFINE FORM_STRUCT_TABLE_INDEX_ORDEM       1
#DEFINE FORM_STRUCT_TABLE_INDEX_ID          2
#DEFINE FORM_STRUCT_TABLE_INDEX_KEY         3
#DEFINE FORM_STRUCT_TABLE_INDEX_DESCRIPTION 4
#DEFINE FORM_STRUCT_TABLE_INDEX_F3          5
#DEFINE FORM_STRUCT_TABLE_INDEX_NICKNAME    6
#DEFINE FORM_STRUCT_TABLE_INDEX_SHOWPESQ    7

#DEFINE FORM_STRUCT_TABLE_FOLDER_ID          1
#DEFINE FORM_STRUCT_TABLE_FOLDER_DESCRIPTION 2

#DEFINE FORM_STRUCT_TABLE_GROUP_ID          1
#DEFINE FORM_STRUCT_TABLE_GROUP_DESCRIPTION 2

//------------------------------------------------------------
#DEFINE MODELO_PK_OPERATION 1
#DEFINE MODELO_PK_KEYS      2
#DEFINE MODELO_PK_VALUE    1
#DEFINE MODELO_PK_IDFIELD  2
//------------------------------------------------------------
#DEFINE MODEL_TRIGGER_IDFIELD       1
#DEFINE MODEL_TRIGGER_TARGETIDFIELD 2
#DEFINE MODEL_TRIGGER_PRE           3
#DEFINE MODEL_TRIGGER_SETVALUE      4
//------------------------------------------------------------
#DEFINE MODEL_FIELD_TITULO  1
#DEFINE MODEL_FIELD_TOOLTIP 2
#DEFINE MODEL_FIELD_IDFIELD 3
#DEFINE MODEL_FIELD_TIPO    4
#DEFINE MODEL_FIELD_TAMANHO 5
#DEFINE MODEL_FIELD_DECIMAL 6
#DEFINE MODEL_FIELD_VALID   7
#DEFINE MODEL_FIELD_WHEN    8
#DEFINE MODEL_FIELD_VALUES  9
#DEFINE MODEL_FIELD_OBRIGAT 10
#DEFINE MODEL_FIELD_INIT    11
#DEFINE MODEL_FIELD_KEY     12
#DEFINE MODEL_FIELD_NOUPD   13
#DEFINE MODEL_FIELD_VIRTUAL 14
//------------------------------------------------------------
//Conjunto de especificacoes do FWFORMMODEL e derivacoes
//------------------------------------------------------------
#DEFINE MODEL_RELATION_RULES 1
#DEFINE MODEL_RELATION_KEY   2
#DEFINE MODEL_RELATION_RULES_ORIGEM 1
#DEFINE MODEL_RELATION_RULES_TARGET 2
//------------------------------------------------------------
#DEFINE MODEL_STRUCT_TYPE         1
#DEFINE MODEL_STRUCT_ID           2
#DEFINE MODEL_STRUCT_MODEL        3
#DEFINE MODEL_STRUCT_OWNER        4
//------------------------------------------------------------
#DEFINE MODEL_DATA_IDFIELD  1
#DEFINE MODEL_DATA_VALUE    2
#DEFINE MODEL_DATA_UPDATE   3
//------------------------------------------------------------
#DEFINE MODEL_GRID_DATA     1
#DEFINE MODEL_GRID_VALID    2
#DEFINE MODEL_GRID_DELETE   3
#DEFINE MODEL_GRID_ID       4
#DEFINE MODEL_GRID_CHILDREN 5
//------------------------------------------------------------
#DEFINE MODEL_GRID_CHILDREN_ID     1
#DEFINE MODEL_GRID_CHILDREN_DATA   2
#DEFINE MODEL_GRID_CHILDREN_COLS   3
#DEFINE MODEL_GRID_CHILDREN_CALC   4
//------------------------------------------------------------
#DEFINE MODEL_GRID_CALC_IDFIELD    1
#DEFINE MODEL_GRID_CALC_IDFORMCALC 2
#DEFINE MODEL_GRID_CALC_IDCALC     3
//------------------------------------------------------------
#DEFINE MODEL_GRIDLINE_VALUE    1
#DEFINE MODEL_GRIDLINE_UPDATE   2
//------------------------------------------------------------
#DEFINE MODEL_RULES_IDFIELD       1
#DEFINE MODEL_RULES_IDTARGET      2
#DEFINE MODEL_RULES_IDFIELDTARGET 3
#DEFINE MODEL_RULES_TYPE          4
//------------------------------------------------------------
#DEFINE MODEL_MSGERR_IDFORM     1
#DEFINE MODEL_MSGERR_IDFIELD    2
#DEFINE MODEL_MSGERR_IDFORMERR  3
#DEFINE MODEL_MSGERR_IDFIELDERR 4
#DEFINE MODEL_MSGERR_ID         5
#DEFINE MODEL_MSGERR_MESSAGE    6
#DEFINE MODEL_MSGERR_SOLUCTION  7
#DEFINE MODEL_MSGERR_VALUE      8
#DEFINE MODEL_MSGERR_OLDVALUE   9
//------------------------------------------------------------
#DEFINE MODEL_OPERATION_VIEW       1
#DEFINE MODEL_OPERATION_INSERT     3
#DEFINE MODEL_OPERATION_UPDATE     4
#DEFINE MODEL_OPERATION_DELETE     5
#DEFINE MODEL_OPERATION_ONLYUPDATE 6

//------------------------------------------------------------
//Conjunto de especificacoes do FWFORMVIEW e derivacoes
//------------------------------------------------------------
#DEFINE MVC_VIEW_IDFIELD 1
#DEFINE MVC_VIEW_ORDEM   2
#DEFINE MVC_VIEW_TITULO  3
#DEFINE MVC_VIEW_DESCR   4
#DEFINE MVC_VIEW_HELP  5
#DEFINE MVC_VIEW_PICT  7
#DEFINE MVC_VIEW_PVAR  8
#DEFINE MVC_VIEW_LOOKUP 9
#DEFINE MVC_VIEW_CANCHANGE 10
#DEFINE MVC_VIEW_FOLDER_NUMBER 11
#DEFINE MVC_VIEW_GROUP_NUMBER 12
#DEFINE MVC_VIEW_COMBOBOX 13
#DEFINE MVC_VIEW_MAXTAMCMB 14
#DEFINE MVC_VIEW_INIBROW 15
#DEFINE MVC_VIEW_VIRTUAL 16
#DEFINE MVC_VIEW_PICTVAR 17

#DEFINE MVC_MODEL_TITULO  1
#DEFINE MVC_MODEL_TOOLTIP 2
#DEFINE MVC_MODEL_IDFIELD 3
#DEFINE MVC_MODEL_TIPO    4
#DEFINE MVC_MODEL_TAMANHO 5
#DEFINE MVC_MODEL_DECIMAL 6
#DEFINE MVC_MODEL_VALID   7
#DEFINE MVC_MODEL_WHEN    8
#DEFINE MVC_MODEL_VALUES  9
#DEFINE MVC_MODEL_OBRIGAT 10
#DEFINE MVC_MODEL_INIT    11

#DEFINE FORMSTRUFIELD      1
#DEFINE FORMSTRUTRIGGER    2
#DEFINE VIEWSTRUFIELD      3
#DEFINE VIEWSTRUFOLDER     4
#DEFINE VIEWSTRUDOCKWINDOW 5
#DEFINE VIEWSTRUGROUP      6

// ------------------------------------------------------------

#DEFINE OP_PESQUISAR 	1
#DEFINE OP_VISUALIZAR	2
#DEFINE OP_INCLUIR		3
#DEFINE OP_ALTERAR		4
#DEFINE OP_EXCLUIR		5
#DEFINE OP_IMPRIMIR	 	8

#xcommand NEW MODEL ;
			TYPE <nType> ;
			DESCRIPTION <cDescription> ;
			BROWSE <oBrowse> ;
			[ ALIAS <cAlias> ] ;
			[ <pk:PRIMARYKEY> <aPrimaryKey,...> ] ;
				[ MASTER <cMasterAlias> ] ;
				[ <header:HEADER> <aHeader,...> ] ;
				[ BEFORE <bBeforeCommit> ] ;
				[ AFTER <bAfterCommit> ] ;
				[ COMMIT <bCommit> ] ;
				[ ROLLBACK <bRollBack> ] ;
					[ DETAIL <cDetailAlias> ] ;
					[ BEFORE LINE <bBeforeLine> ] ;
					[ AFTER LINE <bAfterLine> ]	;
					[ WHEN <bWhen> ] ;
					[ POST <bPost> ] ;
					[ <relation:RELATION> <aRelation,...> ] ;
					[ ORDER <nOrder> ] ;
					[ <uniqueline:UNIQUE LINE> <aUniqueLine,...> ];
					[ AUTO INCREMENT <cFieldInc>];
	=>;
		If Valtype(<nType>) <> "N" ;;
			CLASSEXCEPTION "TYPE" MESSAGE "type mismatch" ;;
		ElseIf <nType> # 1 .And. <nType> # 2 .And. <nType> # 3 ;;
			CLASSEXCEPTION "TYPE" MESSAGE "invalid option" ;;
		EndIf ;;
		;;
		If ( Valtype(<cAlias>) <> "C" ) .And. ( Valtype(<cMasterAlias>) <> "C" );;
			CLASSEXCEPTION "ALIAS" MESSAGE "parameter required in model" ;;
		EndIf;;
		;;
		If ( <nType> > 1 ) ;;
			If ( ValType(<aRelation>) <> "A" ) ;;
				CLASSEXCEPTION "RELATION" MESSAGE "parameter required in model" ;;
			ElseIf ( Empty(<nOrder>) ) ;;
				CLASSEXCEPTION "ORDER" MESSAGE "parameter required in model" ;;
			EndIf ;;
		EndIf;;
		;;
		<oBrowse> := FWMBrowse():New() ;;
		<oBrowse>:SetAlias(If(ValType(<cAlias>)=="C",<cAlias>,<cMasterAlias>)) ;;
		<oBrowse>:Activate() ;;
		;;
		Return;;
		;;
		Static Function ViewDef(	oView,;
									oModel,;
									oMasterStruct,;
									oDetailStruct) ;;
			;;
			;;
			oModel		  := FWLoadModel(FunName()) ;;
			;;
			oMasterStruct := FWFormStruct(2,<cMasterAlias>) ;;
			If ( <nType> == 3 );;
				oDetailStruct := FWFormStruct(2,[<cDetailAlias>]) ;;
			EndIf;;
			;;			
			oView := FWFormView():New() ;;
			oView:SetModel(oModel) ;;
			oView:AddField( "ID_MASTER" , oMasterStruct) ;;
			;;
			If ( <nType> == 1 ) ;;
				oView:setHeightView("ID_MASTER" ,100) ;;
			EndIf ;;
			;;
			If ( <nType> == 3 );;
				oView:AddGrid("ID_DETAIL",oDetailStruct) ;;
				If ValType(<cFieldInc>) == "C" .And. !Empty(<cFieldInc>) ;;
					oView:AddIncrementField("ID_DETAIL",<cFieldInc>) ;;
				EndIf ;;
				oView:createHorizontalBox("FORMFIELD",20) ;;
				oView:SetOwnerView("ID_MASTER","FORMFIELD") ;;
				oView:createHorizontalBox("GRID",80) ;;
				oView:SetOwnerView("ID_DETAIL","GRID") ;;
			EndIf ;;
			oView:EnableControlBar(.T.) ;;
		Return oView;;
		;;
		Static Function ModelDef(	oModel,;
									cMasterDescription,;
									cDetailDescription,;
									oMasterStruct,;
									oDetailStruct,;
									_bCommit,;
									_bRollBack,;
									cDetailAlias,;
									aHeader,;
									cHeader,;
									_nI,;
									bSX3Header,;
									bSX3Detail);;
			;;
			;;
			cMasterDescription := "" ;;
			SX2->(dbSetOrder(1)) ;;
			If SX2->(dbSeek(<cMasterAlias>)) ;;
				cMasterDescription := X2Nome() ;;
			EndIf;;
			;;
			cDetailAlias := "";;
			If ( <nType> == 2 ) ;;
				cDetailAlias := [<cMasterAlias>] ;;
			EndIf;;
			If ( <nType> == 3 ) ;;
				[ cDetailAlias := <cDetailAlias> ] ;;
			EndIf;;
			;;
			If ( <nType> >= 2 ) ;;
				cDetailDescription := "";;
				SX2->(dbSetOrder(1)) ;;
				If SX2->(dbSeek(cDetailAlias)) ;;
					cDetailDescription := X2Nome() ;;
				EndIf;;
			EndIf;;
			;;
			cHeader := "";;
			If ( <nType> == 2 );;
				aHeader := {<aHeader>};;
				If ( ValType(aHeader) == "A" );;
					For _nI:=1 To Len(aHeader);;
						cHeader += aHeader[_nI]+"|";;
					Next nI;;
				EndIf;;
				If !Empty(cHeader);;
					bSX3Header := {|cCampo|  AllTrim(cCampo)+"|" $ cHeader} ;;
					bSX3Detail := {|cCampo| !AllTrim(cCampo)+"|" $ cHeader} ;;
				EndIf;;
			EndIf;;
			;;
			oMasterStruct := FWFormStruct(1,<cMasterAlias>,bSX3Header,.F.) ;; //Model
			;;
			If ( <nType> >= 2 ) ;;
				oDetailStruct := FWFormStruct(1,cDetailAlias,bSX3Detail) ;; //Model
			EndIf;;
			;;
			oModel := MPFormModel():New("MODEL", <{bBeforeCommit}>, <{bAfterCommit}>, If(ValType(<bCommit>)=="B",<bCommit>,Nil), If(ValType(<bRollBack>)=="B",<bRollBack>,Nil)) ;;
			oModel:SetDescription(<cDescription>) ;;
			;;
			oModel:AddFields("ID_MASTER", Nil, oMasterStruct, <{bBeforeField}>, <{bAfterField}>, {|oModel,cIdField| FormLoadField(oModel,cIdField)}) ;;
			oModel:GetModel("ID_MASTER"):SetDescription(cMasterDescription) ;;
			;;
			If ( <nType> == 3 ) ;;
				oModel:AddGrid("ID_DETAIL", "ID_MASTER", oDetailStruct, <{bBeforeLine}>, <{bAfterLine}>, <{bWhen}>, <{bPost}>, {|oGrid| FormLoadGrid(oGrid,oModel)}) ;;
				oModel:GetModel("ID_DETAIL"):SetDescription(cDetailDescription);;
				oModel:GetModel("ID_DETAIL"):SetUseOldGrid() ;;
				oModel:GetModel("ID_DETAIL"):SetUniqueLine([\{<aUniqueLine>\}]) ;;
				oModel:GetModel("ID_DETAIL"):SetRelation([\{<aRelation>\}],<nOrder>) ;;
			EndIf ;;
			If ( ValType([\{<aPrimaryKey>\}])=="A" );;
				oModel:SetPrimaryKey([\{<aPrimaryKey>\}]) ;; 
			EndIf ;;
		Return oModel
