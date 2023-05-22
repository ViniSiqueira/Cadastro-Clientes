program Clientes;

uses
  Vcl.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {frmMenuPrincipal},
  uDtmConexao in 'DataModule\uDtmConexao.pas' {dtmConexao: TDataModule},
  uFrmHeranca in 'Herança\uFrmHeranca.pas' {frmHeranca},
  uEnum in 'Herança\uEnum.pas',
  uCadastroClientes in 'Cadastros\Clientes\uCadastroClientes.pas' {frmCadastroClientes},
  cCadastroCliente in 'Cadastros\Clientes\cCadastroCliente.pas',
  cBuscaCEP in 'API\CEP\cBuscaCEP.pas',
  uCadastroUsuarios in 'Cadastros\Usuarios\uCadastroUsuarios.pas' {frmCadastroUsuarios},
  cCadastroUsuarios in 'Cadastros\Usuarios\cCadastroUsuarios.pas',
  uLogin in 'Login\uLogin.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenuPrincipal, frmMenuPrincipal);
  Application.Run;
end.
