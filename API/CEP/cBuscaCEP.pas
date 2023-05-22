unit cBuscaCEP;

interface

uses
  System.Net.HttpClient, System.Net.URLClient, System.JSON, REST.Json;

type
  TBuscaCEP = class
  private
    Fcep: String;
    Flogradouro: String;
    Fcomplemento: String;
    Fbairro: String;
    Flocalidade: String;
    Fuf: String;
    Fibge: Integer;
    Fgia: Integer;
    Fddd: String;
    Fsiafi: Integer;

  public
    constructor Create;
    destructor Destroy; override;

    function EncontrarCep(cep: String): TBuscaCEP;

    property cep: String read Fcep write Fcep;
    property logradouro: String read Flogradouro write Flogradouro;
    property complemento: String read Fcomplemento write Fcomplemento;
    property bairro: String read Fbairro write Fbairro;
    property localidade: String read Flocalidade write Flocalidade;
    property uf: String read Fuf write Fuf;
    property ibge: Integer read Fibge write Fibge;
    property gia: Integer read Fgia write Fgia;
    property ddd: String read Fddd write Fddd;
    property siafi: Integer read Fsiafi write Fsiafi;

  end;

{ TBuscaCEP }

implementation

constructor TBuscaCEP.Create;
begin

end;

destructor TBuscaCEP.Destroy;
begin

  inherited;
end;

function TBuscaCEP.EncontrarCep(cep: String): TBuscaCEP;
var
  HTTPClient: THttpClient;
  URL: TURI;
  Resposta: IHttpResponse;
  Conteudo: string;
begin
  HTTPClient := THttpClient.Create;
  try
    URL := TURI.Create('https://viacep.com.br/ws/'+cep+'/json/');
    Resposta := HTTPClient.Get(URL.ToString);
    Conteudo := Resposta.ContentAsString;
    result := TJson.JsonToObject<TBuscaCEP>(Conteudo);
  finally
    HTTPClient.Free;
  end;
end;

end.
