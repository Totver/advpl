program DLLDemo;

uses
  Forms,
  MainForm in 'MainForm.pas' {fDLLDemo};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfDLLDemo, fDLLDemo);
  Application.Run;
end.
