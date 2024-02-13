aHeaderEx:= {}
Aadd(aHeaderEx, {" " ,"OK" ,'@BMP' ,01,0,".T." ,,"C","",,,})
Aadd(aHeaderEx, {"Filial" ,"FILI" ,'@!' ,01,0,".T." ,,"C","",,,})
Aadd(aHeaderEx, {"CD?" ,"CPCD" ,'@!' ,04,0,"U_ValidCD(oGetDados)" ,,"C","",,"S=Sim;N=Nao"," "})
Aadd(aHeaderEx, {"UF" ,"UF" ,'@!' ,02,0,".T." ,,"C","",,""," "})
Aadd(aHeaderEx, {"NOME" ,"NOME" ,'@!' ,20,0,".T." ,,"C","",,""," "})
Aadd(aHeaderEx, {"Dias A" ,"ESTA" ,'999' ,04,0,"Positivo()" ,,"N",,,,})
Aadd(aHeaderEx, {"Dias B" ,"ESTB" ,'999' ,04,0,"Positivo()" ,,"N",,,,})
Aadd(aHeaderEx, {"Dias C" ,"ESTC" ,'999' ,04,0,"Positivo()" ,,"N",,,,})

oGetDados:= MsNewGetDados():New( 020, 000, 250, 250, GD_INSERT+GD_UPDATE , "AllwaysTrue", "AllwaysTrue", "", {"CPCD","ESTA","ESTB","ESTC"},, Len(aDados) , "AllwaysTrue", "", "AllwaysTrue", oDlgFil, aHeaderEx, aDados)
oGetDados:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
