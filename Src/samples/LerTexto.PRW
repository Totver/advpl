Function U_Cliente

If MsgYesNo("Ler Cadastro de Clientes")
	DbSelectArea("SA1")
   Append From \Txt\Clientes.Txt SDF
Else
	cNomTrb   := CriaTrab({ { "CAMPO", "C", 400, 0 } })
	cCadastro := 'Leitura de Txt'
	dbUseArea(.T.,,cNomTrb, "TRB", .T.)
	Ferase("Sc*.*")
	aRotina := { { "Pesquisar" , "AxPesqui" , 0, 1},;
   	           { "Visualizar", "AxVisual" , 0, 2},;
      	        { "Incluir"   , "Axinclui" , 0, 3},;
	              { "Alterar"   , "AxAltera", 0, 4},;
   	           { "Excluir"   , "Axdeleta" , 0, 5} }
	dbSelectArea("TRB")
   Append From \Txt\Fi310500.Txt SDF
	mBrowse(6, 1, 22, 75, "TRB")
Endif	

Return .T.
