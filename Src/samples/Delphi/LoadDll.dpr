program LoadDll;

uses
  Forms,
  fPrincipal in 'fPrincipal.pas' {FrmInscricao};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmInscricao, FrmInscricao);
  Application.Run;
end.
