unit MainFormOcx;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, OleCtrls, AP5ConnXControl_TLB;

type
  TfDLLDemo = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    cServer: TEdit;
    Label2: TLabel;
    cPort: TEdit;
    Label3: TLabel;
    cEnv: TEdit;
    cUser: TEdit;
    Label4: TLabel;
    cPass: TEdit;
    Label5: TLabel;
    Ap5Server: TAP5ConnX;
    BtnRun: TBitBtn;
    procedure BtnRunClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fDLLDemo: TfDLLDemo;

implementation

{$R *.DFM}

procedure TfDLLDemo.BtnRunClick(Sender: TObject);

Var cRet : WideString;

begin

  If Ap5Server.Connected then AP5Server.Disconnect;
  Ap5Server.Server      := cServer.Text;
  Ap5Server.Environment := cEnv.Text;
  Ap5Server.User        := cUser.Text;
  Ap5Server.Password    := cPass.Text;
  Ap5Server.Port        := StrToInt(cPort.Text);
  Ap5Server.Connect;

  Ap5Server.TextOut('Enviando parâmetro "5" ao AP5 Server ...');
  Ap5Server.AddNumericParam(5);
  Ap5Server.TextOut('Executando função MESEXTENSO...');
  If Ap5Server.CallProc('MESEXTENSO') Then
     Begin
        Ap5Server.TextOut('Obtendo resultado da função do AP5 Server...');
        cRet := Ap5Server.ResultAsString;
        Ap5Server.TextOut('Mês obtido como resultado: ' + cRet);
        Ap5Server.TextOut('Desconectando AP5 Server...');
     End
  Else
     Ap5Server.TextOut('Falha na execução da função. Verifique a função ' +
                       'utilizada, o ambiente informado ou o repositório utilizado.');
  AP5Server.Disconnect;

end;

procedure TfDLLDemo.FormClose(Sender: TObject; var Action: TCloseAction);
begin

   Ap5Server.Free;
   Action := caFree;

end;

end.

