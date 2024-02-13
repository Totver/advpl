program DLLDemoOcx;

uses
  Forms,
  MainFormOcx in 'MainFormOcx.pas' {fDLLDemo};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfDLLDemo, fDLLDemo);
  Application.Run;
end.
