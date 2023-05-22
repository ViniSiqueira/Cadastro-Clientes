unit cCadastroCliente;


interface

uses
  System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TCadastroCliente = class
  private
    FConexaoDB: TZConnection;
    FClienteId: Integer;
    FNome: String;
    FEndereco: String;
    FCidade: String;
    FBairro: String;
    FEstado: String;
    FCEP: String;
    FTelefone: String;
    FEmail: String;
    FDataNascimento: TDateTime;

  public
    constructor Create(conexao: TZConnection);
    destructor Destroy; override;

    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar(Id: Integer): Boolean;
    function Selecionar(Id: Integer): Boolean;

    property ConexaoDB: TZConnection read FConexaoDB write FConexaoDB;
    property ClienteId: Integer read FClienteId write FClienteId;
    property Nome: String read FNome write FNome;
    property Endereco: String read FEndereco write FEndereco;
    property Cidade: String read FCidade write FCidade;
    property Bairro: String read FBairro write FBairro;
    property Estado: String read FEstado write FEstado;
    property CEP: String read FCEP write FCEP;
    property Telefone: String read FTelefone write FTelefone;
    property Email: String read FEmail write FEmail;
    property DataNascimento: TDateTime read FDataNascimento write FDataNascimento;
  end;

implementation

uses
  System.SysUtils;

{ TCadastroCliente }

function TCadastroCliente.Apagar(Id: Integer): Boolean;
begin
  var qryExcluirCliente := TZQuery.Create(nil);

  try
    Result := True;
    qryExcluirCliente.Connection := FConexaoDB;
    qryExcluirCliente.SQL.Clear;
    qryExcluirCliente.SQL.Add('DELETE CLIENTES WHERE CLIENTE_ID = :CLIENTE_ID');
    qryExcluirCliente.ParamByName('CLIENTE_ID').AsInteger := Id;

    try
      qryExcluirCliente.ExecSQL;
    except
      Result := False;
    end;

  finally
    if Assigned(qryExcluirCliente) then
      FreeAndNil(qryExcluirCliente);
  end;
end;

function TCadastroCliente.Atualizar: Boolean;
begin
  var qryAtualizarCliente := TZQuery.Create(nil);

  try
    Result := True;
    qryAtualizarCliente.Connection := FConexaoDB;
    qryAtualizarCliente.SQL.Clear;
    qryAtualizarCliente.SQL.Add('UPDATE CLIENTES SET NOME = :NOME, ENDERECO = :ENDERECO, CIDADE = :CIDADE,');
    qryAtualizarCliente.SQL.Add('BAIRRO = :BAIRRO, ESTADO = :ESTADO, CEP = :CEP, TELEFONE = :TELEFONE, ');
    qryAtualizarCliente.SQL.Add('EMAIL = :EMAIL, DATA_NASCIMENTO = :DATA_NASCIMENTO');
    qryAtualizarCliente.SQL.Add('WHERE CLIENTE_ID = :CLIENTE_ID');
    qryAtualizarCliente.ParamByName('CLIENTE_ID').AsInteger := FClienteId;
    qryAtualizarCliente.ParamByName('NOME').AsString := FNome;
    qryAtualizarCliente.ParamByName('ENDERECO').AsString := FEndereco;
    qryAtualizarCliente.ParamByName('CIDADE').AsString := FCidade;
    qryAtualizarCliente.ParamByName('BAIRRO').AsString := FBairro;
    qryAtualizarCliente.ParamByName('ESTADO').AsString := FEstado;
    qryAtualizarCliente.ParamByName('CEP').AsString := FCEP;
    qryAtualizarCliente.ParamByName('TELEFONE').AsString := FTelefone;
    qryAtualizarCliente.ParamByName('EMAIL').AsString := FEmail;
    qryAtualizarCliente.ParamByName('DATA_NASCIMENTO').AsDateTime := FDataNascimento;

    try
      qryAtualizarCliente.ExecSQL;
    except
      Result := False;
    end;

  finally
    if Assigned(qryAtualizarCliente) then
      FreeAndNil(qryAtualizarCliente);
  end;
end;

function TCadastroCliente.Inserir: Boolean;
begin
  var qryInserirCliente := TZQuery.Create(nil);

  try
    Result := True;
    qryInserirCliente.Connection := FConexaoDB;
    qryInserirCliente.SQL.Clear;
    qryInserirCliente.SQL.Add('INSERT INTO CLIENTES(NOME, ENDERECO, CIDADE, BAIRRO, ESTADO, CEP, TELEFONE, EMAIL, DATA_NASCIMENTO)');
    qryInserirCliente.SQL.Add('VALUES(:NOME, :ENDERECO, :CIDADE, :BAIRRO, :ESTADO, :CEP, :TELEFONE, :EMAIL, :DATA_NASCIMENTO)');
    qryInserirCliente.ParamByName('NOME').AsString := FNome;
    qryInserirCliente.ParamByName('ENDERECO').AsString := FEndereco;
    qryInserirCliente.ParamByName('CIDADE').AsString := FCidade;
    qryInserirCliente.ParamByName('BAIRRO').AsString := FBairro;
    qryInserirCliente.ParamByName('ESTADO').AsString := FEstado;
    qryInserirCliente.ParamByName('CEP').AsString := FCEP;
    qryInserirCliente.ParamByName('TELEFONE').AsString := FTelefone;
    qryInserirCliente.ParamByName('EMAIL').AsString := FEmail;
    qryInserirCliente.ParamByName('DATA_NASCIMENTO').AsDateTime := FDataNascimento;

    try
      qryInserirCliente.ExecSQL;
    except
      Result := False;
    end;

  finally
    if Assigned(qryInserirCliente) then
      FreeAndNil(qryInserirCliente);
  end;
end;

function TCadastroCliente.Selecionar(Id: Integer): Boolean;
begin
  var tblCliente := TZQuery.Create(nil);

  try
    Result := True;
    tblCliente.Connection := FConexaoDB;
    tblCliente.SQL.Clear;
    tblCliente.SQL.Add('SELECT * FROM CLIENTES WHERE CLIENTE_ID = :CLIENTE_ID');
    tblCliente.ParamByName('CLIENTE_ID').AsInteger := Id;

    try
      tblCliente.Open;

      FClienteId := tblCliente.FieldByName('CLIENTE_ID').AsInteger;
      FNome := tblCliente.FieldByName('NOME').AsString;
      FEndereco := tblCliente.FieldByName('ENDERECO').AsString;
      FCidade := tblCliente.FieldByName('CIDADE').AsString;
      FBairro := tblCliente.FieldByName('BAIRRO').AsString;
      FEstado := tblCliente.FieldByName('ESTADO').AsString;
      FCEP := tblCliente.FieldByName('CEP').AsString;
      FTelefone := tblCliente.FieldByName('TELEFONE').AsString;
      FEmail := tblCliente.FieldByName('EMAIL').AsString;
      FDataNascimento := tblCliente.FieldByName('DATA_NASCIMENTO').AsDateTime;

    except
      Result := False;
    end;

  finally
    if Assigned(tblCliente) then
      FreeAndNil(tblCliente);
  end;
end;

constructor TCadastroCliente.Create(conexao: TZConnection);
begin
  FConexaoDB := conexao;
end;

destructor TCadastroCliente.Destroy;
begin

  inherited;
end;

end.
