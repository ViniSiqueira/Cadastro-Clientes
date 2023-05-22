unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, cCadastroUsuarios, uDtmConexao;

type
  TfrmLogin = class(TForm)
    edtNome: TEdit;
    edtSenha: TEdit;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    btnFechar: TBitBtn;
    btnEntrar: TBitBtn;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
  private
    { Private declarations }
    fechar: Boolean;
    procedure RealizarLogin;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin
  RealizarLogin;
end;

procedure TfrmLogin.btnFecharClick(Sender: TObject);
begin
  fechar := true;
  Application.Terminate;
end;

procedure TfrmLogin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := fechar;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  fechar := false;
end;

procedure TfrmLogin.RealizarLogin;
begin
  var oUsuario := TCadastroUsuario.Create(dtmConexao.ConexaoDB);
  try
    if oUsuario.Logar(edtNome.Text, edtSenha.Text) then
    begin
      fechar := true;
      Close;
    end
    else
    begin
        MessageDlg('Usuário Inválido', mtInformation, [mbok], 0);
        edtNome.SetFocus;
    end;
  finally
    if Assigned(oUsuario) then
      FreeAndNil(oUsuario);

  end;
end;

end.
