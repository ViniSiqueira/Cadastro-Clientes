unit uFrmHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, uDtmConexao, uEnum, RxToolEdit;

type
  TfrmHeranca = class(TForm)
    pnlRodape: TPanel;
    pgcPrincipal: TPageControl;
    tbLista: TTabSheet;
    tbManutencao: TTabSheet;
    pnlCabecalho: TPanel;
    gridLista: TDBGrid;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnApagar: TBitBtn;
    btnNavegator: TDBNavigator;
    brnFechar: TBitBtn;
    lblIndice: TLabel;
    btmPesquisar: TBitBtn;
    mskPesquisar: TMaskEdit;
    qryLista: TZQuery;
    dtsLista: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure mskPesquisarChange(Sender: TObject);
    procedure gridListaDblClick(Sender: TObject);
    procedure gridListaTitleClick(Column: TColumn);
    procedure brnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
  private
    FIndiceAtual: String;
    FEstadoCadastro: TEstadoCadastro;
    procedure ExibirCampoPesquisa(campo: String; tLabel: TLabel);
    function RetornarCampoPesquisado(campo: String): String;
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; indice: Integer);
    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
      btnApagar: TBitBtn; btnNavegador: TDBNavigator;
      pgcPrincipal: TPageControl; flag: Boolean);
    procedure VerificarAlteracaoRegistro;
    procedure LimparCampos;
    { Private declarations }
  public
    { Public declarations }
    function Apagar: Boolean; virtual;
    function Salvar(estadoCadastro: TEstadoCadastro): Boolean; virtual;

    property IndiceAtual: String read FIndiceAtual write FIndiceAtual;
    property EstadoCadastro: TEstadoCadastro read FEstadoCadastro write FEstadoCadastro;
  end;

var
  frmHeranca: TfrmHeranca;

implementation

{$R *.dfm}

procedure TfrmHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryLista.Close;
end;

procedure TfrmHeranca.FormCreate(Sender: TObject);
begin
  qryLista.Connection := dtmConexao.ConexaoDB;
  dtsLista.DataSet := qryLista;
  gridLista.DataSource := dtsLista;
  gridLista.Options := [dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection,dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
end;

procedure TfrmHeranca.FormShow(Sender: TObject);
begin
  if (qryLista.SQL.Text <> '') then
  begin
    qryLista.IndexFieldNames := FIndiceAtual;
    ExibirCampoPesquisa(FIndiceAtual, lblIndice);
    qryLista.Open;
  end;
  ControlarIndiceTab(pgcPrincipal,0);
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavegator, pgcPrincipal, true);
end;

procedure TfrmHeranca.ControlarIndiceTab(pgcPrincipal: TPageControl; indice: Integer);
begin
  if pgcPrincipal.Pages[indice].TabVisible  then
    pgcPrincipal.TabIndex := indice;
end;

procedure TfrmHeranca.btnAlterarClick(Sender: TObject);
begin
  try
    ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavegator, pgcPrincipal, false);
    VerificarAlteracaoRegistro;
  finally
    FEstadoCadastro := ecAlterar;
  end;
end;

procedure TfrmHeranca.btnApagarClick(Sender: TObject);
begin
  try
    if Apagar then
    begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavegator, pgcPrincipal, true);
      ControlarIndiceTab(pgcPrincipal, 0);
      LimparCampos;
      qryLista.Refresh;
    end
  finally
    FEstadoCadastro := ecNenhum;
  end;
end;

procedure TfrmHeranca.btnCancelarClick(Sender: TObject);
begin
  try
    ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavegator, pgcPrincipal, true);
    ControlarIndiceTab(pgcPrincipal, 0);
    LimparCampos;
  finally
    FEstadoCadastro := ecNenhum;
  end;
end;

procedure TfrmHeranca.btnGravarClick(Sender: TObject);
begin
  try
    if Salvar(FEstadoCadastro) then
    begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavegator, pgcPrincipal, true);
      ControlarIndiceTab(pgcPrincipal, 0);
      LimparCampos;
      qryLista.Refresh;
    end;
  finally
    FEstadoCadastro := ecNenhum;
  end;
end;

procedure TfrmHeranca.btnNovoClick(Sender: TObject);
begin
  try
    ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavegator, pgcPrincipal, false);
    LimparCampos;
  finally
    FEstadoCadastro := ecNovo;
  end;
end;

procedure TfrmHeranca.VerificarAlteracaoRegistro;
begin
  if qryLista.RecordCount = 0 then
  begin
    ControlarIndiceTab(pgcPrincipal, 0);
    MessageDlg('Atenção! Para alterar é necessário ter um registro cadastrado', mtInformation,[mbOk],0);
    abort;
  end;
end;

procedure TfrmHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar,btnGravar, btnApagar: TBitBtn; btnNavegador: TDBNavigator; pgcPrincipal: TPageControl; flag: Boolean);
begin
  btnNovo.Enabled := flag;
  btnApagar.Enabled := flag;
  btnAlterar.Enabled := flag;
  btnNavegador.Enabled := flag;
  pgcPrincipal.Pages[0].TabVisible := flag;
  btnCancelar.Enabled := not flag;
  btnGravar.Enabled := not flag;
end;

procedure TfrmHeranca.LimparCampos;
begin
  for var i := 0 to ComponentCount - 1 do
  begin
    if (Components[i]) is TLabeledEdit then
      TLabeledEdit(Components[i]).Text := ''
    else if (Components[i]) is TMaskEdit then
      TMaskEdit(Components[i]).Text := ''
    else if (Components[i]) is TDateEdit then
      TDateEdit(Components[i]).Date := Date
    else if (Components[i]) is TDBLookupComboBox then
      TDBLookupComboBox(Components[i]).KeyValue := Null;
  end;
end;

procedure TfrmHeranca.gridListaDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TfrmHeranca.gridListaTitleClick(Column: TColumn);
begin
  FIndiceAtual := Column.FieldName;
  qryLista.IndexFieldNames := FIndiceAtual;
  ExibirCampoPesquisa(FIndiceAtual, lblIndice);
end;

function TfrmHeranca.Apagar: Boolean;
begin

end;

procedure TfrmHeranca.brnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmHeranca.ExibirCampoPesquisa(campo: String; tLabel: TLabel);
begin
  tLabel.Caption := RetornarCampoPesquisado(campo);
end;

function TfrmHeranca.RetornarCampoPesquisado(campo: String): String;
begin
  for var i := 0 to qryLista.Fields.Count - 1 do
  begin
    if lowerCase(qryLista.Fields[i].FieldName) = lowerCase(campo) then
    begin
      Result := qryLista.Fields[i].DisplayLabel;
      break;
    end;
  end;
end;

function TfrmHeranca.Salvar(estadoCadastro: TEstadoCadastro): Boolean;
begin

end;

procedure TfrmHeranca.mskPesquisarChange(Sender: TObject);
begin
  qryLista.Locate(FIndiceAtual,TMaskEdit(Sender).Text, [loPartialKey]);
end;

end.
