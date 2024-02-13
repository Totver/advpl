library CarregaDll;

Uses SysUtils, Classes, Windows, Dialogs;

{$R *.RES}

Type TConsisteInscricaoEstadual = Function (Const Insc, UF: String): Integer; Stdcall;

// iFuncId    -> Código identificador da função
// pParametro -> Parâmetros passados para a função
// pBuffer    -> Retorno da função
// iBuffer    -> Tamanho do buffer de retorno pré-alocado ( São alocados 20000 Bytes por padrão )

Procedure Funcao2;

Begin

   MessageDlg('Funcao 1', mtinformation, [mbok], 0);

End;

Procedure ExecInClientDLL( iFuncId : integer; pParametro, pBuffer : pChar; iBuffer : integer ); StdCall;

Var ConsisteInscricaoEstadual : TConsisteInscricaoEstadual;
    LibHandle: THandle; sRetorno: String;
    aParametro: Array[0..10] Of String; iParametros, iPos, iIndice: Integer;

Begin

    Case iFuncId Of
    1:

    Begin

       LibHandle := LoadLibrary (PChar (Trim ('DllInscE32.Dll')));
       If LibHandle <=  HINSTANCE_ERROR Then
          Raise Exception.Create ('Dll não carregada');
       @ConsisteInscricaoEstadual  :=  GetProcAddress (LibHandle,
                                                       'ConsisteInscricaoEstadual');
       iParametros := 1;
       sRetorno := pParametro;
       While Pos(',', sRetorno) > 0 Do
          Begin
             sRetorno := Copy(sRetorno, Pos(',', sRetorno) + 1, Length(sRetorno));
             Inc(iParametros, 1);
          End;
       sRetorno := pParametro;

       iIndice := 1;
       While iIndice <= iParametros Do
          Begin
             If Pos(',', sRetorno) > 0 Then
                iPos := Pos(',', sRetorno) - 1
             Else
                iPos := Length(sRetorno);
             aParametro[iIndice - 1] := Copy(sRetorno, 1, iPos);
             sRetorno := PChar(Copy(sRetorno, Pos(',', sRetorno) + 1, Length(sRetorno)));
             Inc(iIndice, 1);
          End;

       sRetorno := IntToStr(ConsisteInscricaoEstadual(aParametro[0], aParametro[1]));
       StrPLCopy(pBuffer , sRetorno, iBuffer);

    End;

    2: Funcao2()

    End;

End;

Exports ExecInClientDLL;

// Essa será a única função lida pelo client do Protheus

Begin
End.

