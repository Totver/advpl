#Include "Totvs.Ch"
User Function TSTPRD

Private aRotina := {{ "Pesquisar" 	, "AxPesqui", 0 , 1 } ,;
					{ "Foto"   		, "U_FOTO" 	, 0 , 4 },;
					{ "Gerar Imagens", "U_GRFOTO", 0 , 3 } }

mBrowse( 6 , 1 , 22 , 75 , "SB1" , , , , , ,/*tLegenda*/ )

Return

User Function Foto

cCadastro := "Cadastro de Produtos - Foto"

aFields := { "B1_COD", "B1_DESC", "B1_BITMAP", "NOUSER" };;
aEdit   := { "B1_BITMAP" }

AxAltera("SB1", SB1->(Recno()), 2, aFields, aEdit)

Return

User Function GrFoto

LjMsgRun("Gerando as imagens dos produtos...","Aguarde",{|| GrvImagem() })

Return

Static Function GrvImagem

Local oRep := TBmpRep():New(10,30,250,250,,,oMainWnd)

DbSelectArea("SB1")
Set Filter To B1_BITMAP <> ' '
DbGotop()
While ! SB1->(Eof())
	Ferase("c:\temp\foto\" + AllTrim(SB1->B1_BITMAP) + ".jpg")
	oRep:Extract(AllTrim(SB1->B1_BITMAP),"c:\temp\foto\" + AllTrim(SB1->B1_BITMAP) + ".jpg", .T.)
	SB1->(DbSkip())
EndDo

Return