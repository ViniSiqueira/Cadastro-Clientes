unit cCadastroUsuarios;

interface

uses
  System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, System.SysUtils,
  ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TCadastroUsuario = class
  private
    FNome: String;
    FSenha: String;
    FUsuarioId: Integer;
    FConexaoDB: TZConnection;
  public
    constructor Create(conexao: TZConnection);
    destructor Destroy; override;

    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar(Id: Integer): Boolean;
    function Selecionar(Id: Integer): Boolean;
    function Logar(usuario, senha: String): Boolean;

    property Nome: String read FNome write FNome;
    property Senha: String read FSenha write FSenha;
    property UsuarioId: Integer read FUsuarioId write FUsuarioId;
    property ConexaoDB: TZConnection read FConexaoDB write FConexaoDB;
  end;

implementation

{ TCadastroUsuario }

constructor TCadastroUsuario.Create(conexao: TZConnection);
begin
  ConexaoDB := conexao;
end;

destructor TCadastroUsuario.Destroy;
begin

  inherited;
end;

function TCadastroUsuario.Apagar(Id: Integer): Boolean;
begin
  var qryExcluirUsuario := TZQuery.Create(nil);

  try
    Result := True;
    qryExcluirUsuario.Connection := FConexaoDB;
    qryExcluirUsuario.SQL.Clear;
    qryExcluirUsuario.SQL.Add('DELETE USUARIOS WHERE USUARIO_ID = :USUARIO_ID');
    qryExcluirUsuario.ParamByName('USUARIO_ID').AsInteger := Id;

    try
      qryExcluirUsuario.ExecSQL;
    except
      Result := False;
    end;

  finally
    if Assigned(qryExcluirUsuario) then
      FreeAndNil(qryExcluirUsuario);
  end;
end;

function TCadastroUsuario.Atualizar: Boolean;
begin
  var qryAtualizarUsuario := TZQuery.Create(nil);

  try
    Result := True;
    qryAtualizarUsuario.Connection := FConexaoDB;
    qryAtualizarUsuario.SQL.Clear;
    qryAtualizarUsuario.SQL.Add('UPDATE USUARIOS SET NOME = :NOME, SENHA = :SENHA');
    qryAtualizarUsuario.SQL.Add('WHERE USUARIO_ID = :USUARIO_ID');
    qryAtualizarUsuario.ParamByName('USUARIO_ID').AsInteger := FUsuarioId;
    qryAtualizarUsuario.ParamByName('NOME').AsString := FNome;
    qryAtualizarUsuario.ParamByName('SENHA').AsString := FSenha;

    try
      qryAtualizarUsuario.ExecSQL;
    except
      Result := False;
    end;

  finally
    if Assigned(qryAtualizarUsuario) then
      FreeAndNil(qryAtualizarUsuario);
  end;
end;

function TCadastroUsuario.Inserir: Boolean;
begin
  var qryInserirUsuario := TZQuery.Create(nil);

  try
    Result := True;
    qryInserirUsuario.Connection := FConexaoDB;
    qryInserirUsuario.SQL.Clear;
    qryInserirUsuario.SQL.Add('INSERT INTO USUARIOS(NOME, SENHA)');
    qryInserirUsuario.SQL.Add('VALUES(:NOME, :SENHA)');
    qryInserirUsuario.ParamByName('NOME').AsString := FNome;
    qryInserirUsuario.ParamByName('SENHA').AsString := FSenha;

    try
      qryInserirUsuario.ExecSQL;
    except
      Result := False;
    end;

  finally
    if Assigned(qryInserirUsuario) then
      FreeAndNil(qryInserirUsuario);
  end;
end;

function TCadastroUsuario.Logar(usuario, senha: String): Boolean;
begin
  var tblUsuarios := TZQuery.Create(nil);

  try
    Result := True;
    tblUsuarios.Connection := FConexaoDB;
    tblUsuarios.SQL.Clear;
    tblUsuarios.SQL.Add('SELECT COUNT(USUARIO_ID) AS QTDE_USUARIO FROM USUARIOS WHERE NOME = :NOME AND SENHA = :SENHA');
    tblUsuarios.ParamByName('NOME').AsString := usuario;
    tblUsuarios.ParamByName('SENHA').AsString := senha;    

    try
      tblUsuarios.Open;

      if tblUsuarios.FieldByName('QTDE_USUARIO').AsInteger > 0 then
        result := true
      else
        result := false;      

    except
      Result := False;
    end;

  finally
    if Assigned(tblUsuarios) then
      FreeAndNil(tblUsuarios);
  end;
end;

function TCadastroUsuario.Selecionar(Id: Integer): Boolean;
begin
  var tblUsuarios := TZQuery.Create(nil);

  try
    Result := True;
    tblUsuarios.Connection := FConexaoDB;
    tblUsuarios.SQL.Clear;
    tblUsuarios.SQL.Add('SELECT * FROM USUARIOS WHERE USUARIO_ID = :USUARIO_ID');
    tblUsuarios.ParamByName('USUARIO_ID').AsInteger := Id;

    try
      tblUsuarios.Open;

      FUsuarioId := tblUsuarios.FieldByName('USUARIO_ID').AsInteger;
      FNome := tblUsuarios.FieldByName('NOME').AsString;
      FSenha := tblUsuarios.FieldByName('SENHA').AsString;

    except
      Result := False;
    end;

  finally
    if Assigned(tblUsuarios) then
      FreeAndNil(tblUsuarios);
  end;
end;

end.
