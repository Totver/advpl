unit fPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFrmInscricao = class(TForm)
    EdtInscricao: TEdit;
    BtnOk: TButton;
    EdtUf: TEdit;
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TConsisteInscricaoEstadual  = function (const Insc, UF: String): Integer; stdcall;

var
  FrmInscricao: TFrmInscricao;

implementation

{$R *.DFM}

procedure TFrmInscricao.BtnOkClick(Sender: TObject);

var
  IRet, IOk, IErro, IPar    : Integer;

  LibHandle                 : THandle;
  ConsisteInscricaoEstadual : TConsisteInscricaoEstadual;

begin

  try
    LibHandle :=  LoadLibrary (PChar (Trim ('DllInscE32.Dll')));
    if  LibHandle <=  HINSTANCE_ERROR then
      raise Exception.Create ('Dll n�o carregada');

    @ConsisteInscricaoEstadual  :=  GetProcAddress (LibHandle,
                                                    'ConsisteInscricaoEstadual');
    if  @ConsisteInscricaoEstadual  = nil then
      raise Exception.Create('Entrypoint Download n�o encontrado na Dll');


    IRet := ConsisteInscricaoEstadual (edtInscricao.Text,edtUF.Text);
    if      Iret = 0 then
       MessageDlg ('Inscri��o v�lida para '+edtUf.Text,mtInformation,[mbOk],0)
    else if Iret = 1 then
       MessageDlg ('Inscri��o inv�lida para '+edtUf.Text,mtError,[mbOk],0)
    else
       MessageDlg ('Par�metros inv�lidos',mtError,[mbOk],0);
    edtInscricao.SetFocus;


  finally
    FreeLibrary (LibHandle);
  end;


end;

end.
