#Include "RwMake.Ch"
#Include "Fw192.Ch"

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北砇otina    � Ambiente   � Autor 砏agner Mobile Costa       	   � Data �05/03/2001潮�
北媚哪哪哪哪呐哪哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri嚻o � Tela que apresenta ambiente para replica dos dados                   潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�          �                                                                  	   潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌
/*/

User Function Ambiente

Local oServer, oPorta, oEnv, oEmpresa
Private cServer, cEnv, nPorta, cEmpresa, cFilialC

#translate RGB( <nRed>, <nGreen>, <nBlue> ) => ;
              ( <nRed> + ( <nGreen> * 256 ) + ( <nBlue> * 65536 ) )

//哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪//
//                        Low Intensity colors
//哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪//

#define CLR_BLACK             0               // RGB(   0,   0,   0 )
#define CLR_BLUE        8388608               // RGB(   0,   0, 128 )
#define CLR_GREEN         32768               // RGB(   0, 128,   0 )
#define CLR_CYAN        8421376               // RGB(   0, 128, 128 )
#define CLR_RED             128               // RGB( 128,   0,   0 )
#define CLR_MAGENTA     8388736               // RGB( 128,   0, 128 )
#define CLR_BROWN         32896               // RGB( 128, 128,   0 )
#define CLR_HGRAY      12632256               // RGB( 192, 192, 192 )
#define CLR_LIGHTGRAY  CLR_HGRAY

//哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪//
//                       High Intensity Colors
//哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪//

#define CLR_GRAY        8421504               // RGB( 128, 128, 128 )
#define CLR_HBLUE      16711680               // RGB(   0,   0, 255 )
#define CLR_HGREEN        65280               // RGB(   0, 255,   0 )
#define CLR_HCYAN      16776960               // RGB(   0, 255, 255 )
#define CLR_HRED            255               // RGB( 255,   0,   0 )
#define CLR_HMAGENTA   16711935               // RGB( 255,   0, 255 )
#define CLR_YELLOW        65535               // RGB( 255, 255,   0 )
#define CLR_WHITE      16777215               // RGB( 255, 255, 255 )

#xcommand DEFINE FONT <oFont> ;
             [ NAME <cName> ] ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ <from:FROM USER> ] ;
             [ <bold: BOLD> ] ;
             [ <italic: ITALIC> ] ;
             [ <underline: UNDERLINE> ] ;
             [ WEIGHT <nWeight> ] ;
             [ OF <oDevice> ] ;
             [ NESCAPEMENT <nEscapement> ] ;
       => ;
          <oFont> := TFont():New( <cName>, <nWidth>, <nHeight>, <.from.>,;
                     [<.bold.>],<nEscapement>,,<nWeight>, [<.italic.>],;
                     [<.underline.>],,,,,, [<oDevice>] )

If Empty(oServer)
   MsgAlert("Testando Empty em variavel nil Retorna True")
Endif

DEFINE FONT oFont NAME "Arial" SIZE 0, -12 BOLD

@ 200,1 TO 400,600 DIALOG oDialogo TITLE "Tela de confirmacao da gravacao em outra enviroment de replica"

U_CarregaRpc(@cEnv, @cServer, @nPorta, @cEmpresa, @cFilialC)

@ 005,05 Say "Environment" Pixel
@ 005,45 Say oEnv 	Var cEnv;
  						   Size 60,10 Color CLR_HBLUE, CLR_WHITE Of oDialogo Pixel
oEnv:SetFont(oFont)

@ 025,05 Say "Servidor " Pixel
@ 025,45 Say oServer Var cServer;
 	      Size 60,10 Color CLR_HBLUE, CLR_WHITE Of oDialogo Pixel
oServer:SetFont(oFont)

@ 045,05 Say "Porta    "  Pixel
@ 045,45 Say oPorta Var AllTrim(Str(nPorta));
  						   Size 60,10 Color CLR_HBLUE, CLR_WHITE Of oDialogo Pixel
oPorta:SetFont(oFont)

@ 065,05 Say "Empresa/Filial" Pixel
@ 065,45 Say oEmp 	Var cEmpresa + "/" + cFilialC;
  						   Size 60,10 Color CLR_HBLUE, CLR_WHITE Of oDialogo Pixel
oEmp:SetFont(oFont)

@ 82,005 BmpButton Type 1 Action Inicia()
@ 82,258 BmpButton Type 2 Action Close(oDialogo)

ACTIVATE DIALOG oDialogo CENTERED

Return .T.

/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北砇otina    � Inicia     � Autor 砏agner Mobile Costa       	   � Data �05/03/2001潮�
北媚哪哪哪哪呐哪哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri嚻o � Chama funcao para replica do ambiente                                潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�          �                                                                  	   潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌
/*/

Static Function Inicia

Local aChaves := {}, aTabelas := {}

DbSelectArea("SF2")
Aadd(aTabelas, Alias())

DbSetOrder(1)
DbGoTop()
Aadd(aChaves, { IndexOrd(), IndexKey(), &(IndexKey()) } )
 					  
DbSelectArea("SD2")
Aadd(aTabelas, Alias())
DbSetOrder(3)
DbSeek(aChaves[1][3]) // Posiciono no numero da nota definido no SF2
DbGoTop()

Aadd(aChaves, { IndexOrd(), "D2_FILIAL + D2_DOC + D2_SERIE + D2_CLIENTE + D2_LOJA",;
 					  				&("D2_FILIAL + D2_DOC + D2_SERIE + D2_CLIENTE + D2_LOJA") })
 					  
U_CarOutEnv(aTabelas, aChaves, cEnv, cServer, nPorta, cEmpresa, cFilialC)

Return .T.
