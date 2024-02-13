#Include "RwMake.Ch"
#Include "Fw192.Ch"

#translate RGB( <nRed>, <nGreen>, <nBlue> ) => ;
              ( <nRed> + ( <nGreen> * 256 ) + ( <nBlue> * 65536 ) )

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//
//                        Low Intensity colors
//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

#define CLR_BLACK             0               // RGB(   0,   0,   0 )
#define CLR_BLUE        8388608               // RGB(   0,   0, 128 )
#define CLR_GREEN         32768               // RGB(   0, 128,   0 )
#define CLR_CYAN        8421376               // RGB(   0, 128, 128 )
#define CLR_RED             128               // RGB( 128,   0,   0 )
#define CLR_MAGENTA     8388736               // RGB( 128,   0, 128 )
#define CLR_BROWN         32896               // RGB( 128, 128,   0 )
#define CLR_HGRAY      12632256               // RGB( 192, 192, 192 )
#define CLR_LIGHTGRAY  CLR_HGRAY

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//
//                       High Intensity Colors
//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

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

User Function Lj10Orc

Local oSenha, oVar, cSenha := Space(15), lRetorno := .T.

@ 200,001 TO 330,200 DIALOG oDlg TITLE "Alteracao de Pedido"

DEFINE FONT oFont NAME "Arial" SIZE 0, -12 BOLD

If MsgYesNo("Utiliza Say como Objeto")
   @ 05,05 Say oVar Var "Digite a Senha" Of oDlg Pixel Size 60,10 
   oVar:SetFont(oFont)
Else
	If MsgYesNo("Utiliza Cor")
	   @ 05,05 Say oVar Var "Digite a Senha" Size 60,10 Color CLR_HBLUE, CLR_WHITE Of oDlg Pixel
	Else	   
	   @ 05,05 Say oVar Var "Digite a Senha" Of oDlg Pixel
	Endif	   
Endif
@ 15,05 to 40,94
@ 23,05 Get oSenha 	Var cSenha OF oDlg PIXEL SIZE 60, 10 PASSWORD 

oSenha:SetFont(oFont)
	
@ 43,33 BMPBUTTON    TYPE 01 Action Ok()
ACTIVATE DIALOG oDlg CENTERED

If ! IsDigit(ParamIxb) 
   MsgBox("Digitar apenas Numeros", "Sequencia Incorreta")
   lRetorno := .F.
Endif

Return(lRetorno)

Static Function Ok

Close(oDlg)

Return .T.
