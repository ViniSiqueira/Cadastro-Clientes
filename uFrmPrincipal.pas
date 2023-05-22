unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDtmConexao;

type
  TfrmMenuPrincipal = class(TForm)
    mainMenuPrincipal: TMainMenu;
    menuCadatros: TMenuItem;
    menuClientes: TMenuItem;
    menuUsuario: TMenuItem;
    menuFechar: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure menuFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure menuClientesClick(Sender: TObject);
    procedure menuUsuarioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure CriarConexaoComBanco;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenuPrincipal: TfrmMenuPrincipal;

implementation

{$R *.dfm}

uses
  uCadastroClientes, uCadastroUsuarios, uLogin;

procedure TfrmMenuPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(dtmConexao);
end;

procedure TfrmMenuPrincipal.FormCreate(Sender: TObject);
begin
  CriarConexaoComBanco;
end;

procedure TfrmMenuPrincipal.FormShow(Sender: TObject);
begin
  frmLogin := TfrmLogin.Create(Self);
  frmLogin.ShowModal;
  frmLogin.Release;
end;

procedure TfrmMenuPrincipal.menuClientesClick(Sender: TObject);
begin
  frmCadastroClientes := TfrmCadastroClientes.Create(self);
  frmCadastroClientes.ShowModal;
  frmCadastroClientes.Release;
end;

procedure TfrmMenuPrincipal.menuFecharClick(Sender: TObject);
begin
  application.Terminate;
end;

procedure TfrmMenuPrincipal.menuUsuarioClick(Sender: TObject);
begin
  frmCadastroUsuarios := TfrmCadastroUsuarios.Create(self);
  frmCadastroUsuarios.ShowModal;
  frmCadastroUsuarios.Release;
end;

procedure TfrmMenuPrincipal.CriarConexaoComBanco;
begin
  dtmConexao := TdtmConexao.Create(Self);
  dtmConexao.ConexaoDB.SQLHourGlass := true;
  dtmConexao.ConexaoDB.Protocol := 'mssql';
  dtmConexao.ConexaoDB.LibraryLocation := 'C:\Users\vinic\Documents\ProjetoDelphi\ntwdblib.dll';
  dtmConexao.ConexaoDB.Hostname := '.\SQLEXPRESS';
  dtmConexao.ConexaoDB.Port := 1433;
  dtmConexao.ConexaoDB.DataBase := 'CLIENTES_PRD';
  dtmConexao.ConexaoDB.Connected := true;
end;

end.
