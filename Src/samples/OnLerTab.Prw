#Include "RwMake.Ch"

User Function OnLerTab

Prepare Enviroment Empresa "88" Filial "01" Tables { "SA1" } // Abre os SX'S
                                                             // Tables abre
                                                             // as tabelas
                                                             // especificas

DbSelectArea("SX5") // Seleciono SX5

DbSelectArea("SA1") // Seleciono SX5
DbGoTop()

While ! Eof()
   DbSkip()
Enddo

Return .T.
