#Include "RwMake.Ch"
#Include "Protheus.Ch"

// User's function's incluidas dos principais módulos Siga, módulos não referenciados
// devem somente ser incluido utilizando um dos abaixo como base

User function SIGAATF()

CriaBmp() 
	
Return

User function SIGACFG()

CriaBmp() 
	
Return

User function SIGACOM()

CriaBmp() 
	
Return

User function SIGACON()

CriaBmp() 
	
Return

User function SIGAEST()

CriaBmp() 
	
Return

User function SIGAFAT()

CriaBmp() 
	
Return

User function SIGAFIN()

CriaBmp()

Return

User function SIGAFIS()

CriaBmp()

Return

User function SIGAGPE()

CriaBmp()

Return

User function SIGALOJ()

CriaBmp()

Return

User function SIGAPCP()

CriaBmp()

Return

User function SIGAPON()

CriaBmp()

Return

User function SIGATEC()

CriaBmp()

Return

User function SIGATMK()

CriaBmp()

Return

User function SIGATRM()

CriaBmp()

Return

//------------------------------------------------------------------------------------
// Função para criar um bitmap na janela principal
//------------------------------------------------------------------------------------
Static function CriaBmp()

Local nEsquerda := nTopo := nAltura := nLargura := 0, oBmp

Static lFirst := .T.
      
If lFirst
	lFirst := .F.
	oMainWnd:ReadClientCoors()	// Atualiza as coordenadas da janela principal
	
	If GetPvProfString(GetEnvServer(), "LogoBitMap", "", "Ap5Srv.Ini") # ""
		cBitMap  := GetPvProfString(GetEnvServer(), "LogoBitMap", "", "Ap5Srv.Ini")
		nAltura  := Val(GetPvProfString(GetEnvServer(), "LogoAltura", "", "Ap5Srv.Ini"))
		nLargura := Val(GetPvProfString(GetEnvServer(), "LogoLargura", "", "Ap5Srv.Ini"))
	Else
 		cBitMap  := GetPvProfString("Logo", "BitMap", "", "Ap5Srv.Ini")
		nAltura  := Val(GetPvProfString("Logo", "Altura", "", "Ap5Srv.Ini"))
		nLargura := Val(GetPvProfString("Logo", "Largura", "", "Ap5Srv.Ini"))	
	Endif	

   nTopo     := (oMainWnd:nHeight/4)-(nAltura/2)  // Meio da tela
  	nEsquerda := (oMainWnd:nWidth/4) 				  // Left Máximo devido ao menu ocupar o resto da área
	
   @ nTopo,nEsquerda BITMAP SIZE nLargura,nAltura FILE cBitMap NOBORDER

Endif

Return Nil
