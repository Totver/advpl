#Include "RwMake.Ch"

// A rotina chamada pelo agendamento deve ser normal sem laço de execução

User Function Carga

Local nVar := 1

nHandle := FCreate("\Texto\" + StrZero(nVar ++, 6) + ".TXT")
FWrite(nHandle, StrZero(nVar ++, 6))
FClose(nHandle)
Memowrit("\HORAS.SRV", "Horas no Servidor: "+Time())

Return .T.

User Function CargaF2

Local nVar := 1

nHandle := FCreate("\Texto\F2" + StrZero(nVar ++, 6) + ".TXT")
FWrite(nHandle, StrZero(nVar ++, 6))
FClose(nHandle)
Memowrit("\F2HORAS.SRV", "Horas no Servidor: "+Time())

Return .T.


// Exemplo de rotina para ser somente chamada no ONSTART

User Function ExecOnStart

Local nVar := 1

While ! KillApp()
	If nVar < 1001	
   	nHandle := FCreate("\Texto\E" + StrZero(nVar ++, 6) + ".TXT")
   	FWrite(nHandle, StrZero(nVar ++, 6))
   	FClose(nHandle)
   Endif	   
   Memowrit("HORAS.SRV", "Horas no Servidor: "+Time())
   Sleep(0)
Enddo

Return .T.