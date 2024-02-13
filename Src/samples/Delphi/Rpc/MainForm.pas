unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, OleCtrls;

type
  TfDLLDemo = class(TForm)
    Bevel1: TBevel;
    cRes: TMemo;
    btnRun: TBitBtn;
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
    procedure btnRunClick(Sender: TObject);
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

// Declaração das funções da DLL
// Obs.: PAra a execução, a DLL deve estar no mesmo diretório que o executável,
// ou no patch do Windows
// As funções não precisam ser todas declaradas. Só as que serão utilizadas.

Function  AP5CreateConnControl(cServer: pchar; nPort: integer; cEnvironment: pchar; cUser: pchar; cPassWord: pchar): integer; stdcall; external 'AP5DCONN.DLL';
Function  AP5DestroyConnControl(ObjectID: integer): boolean; stdcall; external 'AP5DCONN.DLL';
Function  AP5Connect(ObjectID: integer): boolean; stdcall; external 'AP5DCONN.DLL';
Procedure AP5Disconnect(ObjectID: integer); stdcall; external 'AP5DCONN.DLL';
Function  AddNumericParam(ObjectID: integer; value: double): boolean; stdcall; external 'AP5DCONN.DLL';
Function  ResultAsString( ObjectID: integer; cResult: pchar; nSize: integer): integer; stdcall; external 'AP5DCONN.DLL';
Function  CallProc(ObjectID: integer; cFunction: pchar): boolean; stdcall; external 'AP5DCONN.DLL';

procedure TfDLLDemo.btnRunClick(Sender: TObject);
Var nAP5 : Integer;
    nPort: Integer;
    cRet : Pchar;
begin

  cRes.Clear;

  Try
    nPort := StrToInt(cPort.Text);
    If nPort < 0 Then
      raise Exception.Create('Invalid port');
  Except
    cRes.Lines.Add('Informe uma porta num valor numérico.');
    System.Exit;
  End;

  cRes.Lines.Add('Criando instância de comunicação...');
  nAP5 := AP5CreateConnControl(PChar(cServer.Text),nPort,PChar(cEnv.Text),PChar(cUser.Text),PChar(cPass.Text));
  If nAP5 < 0 Then
  Begin
    cRes.Lines.Add('Erro na criação de instância. Possivelmente problemas na alocação de memória.');
    System.Exit;
  End;

  Try
    cRes.Lines.Add('Conectando ao AP5 Server em "' + cServer.Text + '"...');
    If AP5Connect(nAP5) Then
    Begin
      Try
        cRes.Lines.Add('Enviando parâmetro "5" ao AP5 Server ...');
        AddNumericParam(nAP5,5);
        cRes.Lines.Add('Executando função MESEXTENSO...');
        If CallProc(nAP5,'MESEXTENSO') Then
        Begin
          cRes.Lines.Add('Obtendo resultado da função do AP5 Server...');
          cRet := StrAlloc(255);
          Try
            ResultAsString(nAP5,cRet,255);
            cRes.Lines.Add('Mês obtido como resultado: ' + StrPas(cRet));
          Finally
            StrDispose(cRet);
          End;
          cRes.Lines.Add('Desconectando AP5 Server...');
        End
        Else
          cRes.Lines.Add('Falha na execução da função. Verifique a função utilizada, o ambiente informado ou o repositório utilizado.');
      Finally
        AP5Disconnect(nAP5);
      End;
    End
    Else
      cRes.Lines.Add('Não foi possível se conectar ao servidor indicado. Por favor, verifique.');
  Finally
    AP5DestroyConnControl(nAP5);
  End;
end;

procedure TfDLLDemo.FormClose(Sender: TObject; var Action: TCloseAction);
begin

   Action := caFree;

end;

end.

