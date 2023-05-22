unit uCadastroClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  RxToolEdit, cCadastroCliente, uEnum, System.Net.HttpClient, System.Net.URLClient, System.JSON, REST.Json;

type
  TfrmCadastroClientes = class(TfrmHeranca)
    edtCodigo: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtEndereco: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtEmail: TLabeledEdit;
    edtCep: TMaskEdit;
    edtEstado: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtTelefone: TMaskEdit;
    edtDataNascimento: TDateEdit;
    lblCEP: TLabel;
    qryListaCLIENTE_ID: TIntegerField;
    qryListaNOME: TWideStringField;
    qryListaENDERECO: TWideStringField;
    qryListaCIDADE: TWideStringField;
    qryListaBAIRRO: TWideStringField;
    qryListaESTADO: TWideStringField;
    qryListaCEP: TWideStringField;
    qryListaTELEFONE: TWideStringField;
    qryListaEMAIL: TWideStringField;
    qryListaDATA_NASCIMENTO: TDateTimeField;
    lblTelefone: TLabel;
    lblDataNascimento: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure edtCepExit(Sender: TObject);
  private
    { Private declarations }
    oCliente : TCadastroCliente;
  public
    { Public declarations }
    function Apagar: Boolean; override;
    function Salvar(estadoCadastro: TEstadoCadastro): Boolean; override;
  end;

var
  frmCadastroClientes: TfrmCadastroClientes;


implementation

uses
  uDtmConexao, cBuscaCEP;

{$R *.dfm}

{ TfrmCadastroCliente }

procedure TfrmCadastroClientes.btnAlterarClick(Sender: TObject);
begin
  if oCliente.Selecionar(qryLista.FieldByName('CLIENTE_ID').AsInteger) then
  begin
    edtCodigo.Text := oCliente.ClienteId.ToString;
    edtNome.Text := oCliente.Nome;
    edtEndereco.Text := oCliente.Endereco;
    edtCidade.Text := oCliente.Cidade;
    edtBairro.Text :=oCliente.Bairro;
    edtEstado.Text := oCliente.Estado;
    edtCep.Text := oCliente.CEP;
    edtTelefone.Text := oCliente.Telefone;
    edtEmail.Text := oCliente.Email;
    edtDataNascimento.Date := oCliente.DataNascimento;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmCadastroClientes.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCadastroClientes.edtCepExit(Sender: TObject);
begin
  inherited;
  var buscaCep := TBuscaCEP.Create;
  var dadosCep := buscaCep.EncontrarCep(edtCep.Text);

  edtEndereco.Text := dadosCep.logradouro;
  edtCidade.Text := dadosCep.localidade;
  edtBairro.Text :=dadosCep.bairro;
  edtEstado.Text := dadosCep.uf;
end;

procedure TfrmCadastroClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCliente) then
    FreeAndNil(oCliente)
end;

procedure TfrmCadastroClientes.FormCreate(Sender: TObject);
begin
  inherited;
  oCliente := TCadastroCliente.Create(dtmConexao.conexaoDB);
  IndiceAtual := 'nome';
end;

function TfrmCadastroClientes.Apagar: Boolean;
begin
  if MessageDlg('Deseja mesmo apagar o registro atual?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
    Abort;

  Result := oCliente.Apagar(qryLista.FieldByName('CLIENTE_ID').AsInteger);
end;

function TfrmCadastroClientes.Salvar(estadoCadastro: TEstadoCadastro): Boolean;
begin
  Result := False;

  if edtCodigo.Text <> EmptyStr then
    oCliente.ClienteId := StrToInt(edtCodigo.Text)
  else
    oCliente.ClienteId := 0;

  oCliente.Nome := edtNome.Text;
  oCliente.Endereco := edtEndereco.Text;
  oCliente.Cidade := edtCidade.Text;
  oCliente.Bairro := edtBairro.Text;
  oCliente.Estado := edtEstado.Text;
  oCliente.CEP := edtCep.Text;
  oCliente.Telefone := edtTelefone.Text;
  oCliente.Email := edtEmail.Text;
  oCliente.DataNascimento := edtDataNascimento.Date;

  if EstadoCadastro = ecNovo then
    Result := oCliente.Inserir
  else if EstadoCadastro = ecAlterar then
    Result := oCliente.Atualizar;
end;

end.
