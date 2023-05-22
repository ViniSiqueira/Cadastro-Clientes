unit uCadastroUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls, cCadastroUsuarios, uEnum;

type
  TfrmCadastroUsuarios = class(TfrmHeranca)
    edtCodigo: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtSenha: TLabeledEdit;
    qryListaUSUARIO_ID: TIntegerField;
    qryListaNOME: TWideStringField;
    qryListaSENHA: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
    oUsuario : TCadastroUsuario;
  public
    { Public declarations }
    function Apagar: Boolean; override;
    function Salvar(estadoCadastro: TEstadoCadastro): Boolean; override;
  end;

var
  frmCadastroUsuarios: TfrmCadastroUsuarios;

implementation

{$R *.dfm}

uses
  uDtmConexao;

procedure TfrmCadastroUsuarios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(oUsuario) then
    FreeAndNil(oUsuario)
end;

procedure TfrmCadastroUsuarios.FormCreate(Sender: TObject);
begin
  inherited;
  oUsuario := TCadastroUsuario.Create(dtmConexao.conexaoDB);
  IndiceAtual := 'nome';
end;

function TfrmCadastroUsuarios.Apagar: Boolean;
begin
  if MessageDlg('Deseja mesmo apagar o registro atual?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
    Abort;

  Result := oUsuario.Apagar(qryLista.FieldByName('USUARIO_ID').AsInteger);
end;

function TfrmCadastroUsuarios.Salvar(estadoCadastro: TEstadoCadastro): Boolean;
begin
  Result := False;

  if edtCodigo.Text <> EmptyStr then
    oUsuario.UsuarioId := StrToInt(edtCodigo.Text)
  else
    oUsuario.UsuarioId := 0;

  oUsuario.Nome := edtNome.Text;
  oUsuario.Senha := edtSenha.Text;

  if EstadoCadastro = ecNovo then
    Result := oUsuario.Inserir
  else if EstadoCadastro = ecAlterar then
    Result := oUsuario.Atualizar;
end;

procedure TfrmCadastroUsuarios.btnAlterarClick(Sender: TObject);
begin
  if oUsuario.Selecionar(qryLista.FieldByName('USUARIO_ID').AsInteger) then
  begin
    edtCodigo.Text := oUsuario.UsuarioId.ToString;
    edtNome.Text := oUsuario.Nome;
    edtSenha.Text := oUsuario.Senha;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmCadastroUsuarios.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

end.
