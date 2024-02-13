#include "rwmake.ch"

User Function WebDemo(__aCookies,__aPostParms,__nProcID,__aProcParms,__cHTTPPage)

Local cHTML := ""
Local i

// Coloca uma mensagem em HTML
cHTML += '<p><h1 align="center">Hello World!!!</h1></p>'
                              
// Coloca um separador de linha em HTML
cHTML += '<hr>'
        
If Len(__aProcParms) = 0
  cHTML += '<p>Nenhum parâmetro informado na linha de URL.'
Else
  For i := 1 To Len(__aProcParms)	
    cHTML += '<p>Parâmetro: ' + __aProcParms[i,1] + '    -      Valor: '  +;
    __aProcParms[i,2] + '</p>'
  Next i
Endif

Return(cHTML)