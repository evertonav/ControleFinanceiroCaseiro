unit Model.DAO.Usuario;

interface

uses Model.DAO.Interfaces.Usuario, Model.Query.FireDac, Entidades.Usuario;

type
  TModelDAOUsuario = class(TInterfacedObject, IModelDAOUsuario)
  private
    FValorRenda: Double;
    FNome: string;
    FQuery: IModelQuery;
    FId: Integer;

  public
    function Id(const pId: Integer): IModelDAOUsuario;
    function Nome(const pValor: string): IModelDAOUsuario;
    function ValorRenda(const pValor: double): IModelDAOUsuario;

    function GetId: Integer;
    function GetNome: string;
    function GetValorRenda: Double;

    function Inserir(): IModelDAOUsuario;
    function Atualizar(): IModelDAOUsuario;
    function Consultar(): IModelDAOUsuario;

    constructor Create(pQuery: IModelQuery);

    class function Criar(pQuery: IModelQuery): IModelDAOUsuario;
  end;

implementation

uses
  Data.DB, System.SysUtils;

{ TModelDAOUsuario }

function TModelDAOUsuario.Atualizar: IModelDAOUsuario;
const
  CONST_ATUALIZAR_USUARIO = 'update usuario set '
                        + '  nome = :nome, '
                        + '  valor_renda = :valor_renda '
                        + ' where id = :id ';
begin
  FQuery
    .FecharDataSet
    .AdicionarSQL(CONST_ATUALIZAR_USUARIO)
    .AdicionarParametro('nome', FNome)
    .AdicionarParametro('valor_renda', FValorRenda)
    .AdicionarParametro('id', FId)
    .ExecutarSQL;

  Result := Self;
end;

function TModelDAOUsuario.Consultar(): IModelDAOUsuario;
const
  CONST_CONSULTAR_USUARIO = 'SELECT '
                          + '  id, '
	                        + '  nome, '
                          + '  valor_renda '
                          + ' FROM USUARIO '
                          + ' WHERE id = :id ';
var
  lDadosConsulta: TDataSet;
begin
  if FId = 0 then
    raise Exception.Create('É obrigatório o preenchimento do ID');

  lDadosConsulta := FQuery
                      .FecharDataSet
                      .AdicionarSQL(CONST_CONSULTAR_USUARIO)
                      .AdicionarParametro('id', FId)
                      .AbrirDataSet
                      .GetQuery;

  FId := lDadosConsulta.FieldByName('id').AsInteger;
  FNome := lDadosConsulta.FieldByName('Nome').AsString;
  FValorRenda := lDadosConsulta.FieldByName('valor_renda').AsFloat;

  Result := Self;
end;

constructor TModelDAOUsuario.Create(pQuery: IModelQuery);
begin
  FQuery := pQuery;
  FId := 0;
end;

class function TModelDAOUsuario.Criar(pQuery: IModelQuery): IModelDAOUsuario;
begin
  Result := Self.Create(pQuery);
end;

function TModelDAOUsuario.GetId: Integer;
begin
  Result := FId;
end;

function TModelDAOUsuario.GetNome: string;
begin
  Result := FNome;
end;

function TModelDAOUsuario.GetValorRenda: Double;
begin
  Result := FValorRenda;
end;

function TModelDAOUsuario.Id(const pId: Integer): IModelDAOUsuario;
begin
  FId := pId;

  Result := Self;
end;

function TModelDAOUsuario.Inserir: IModelDAOUsuario;
const
  CONST_INSERIR_USUARIO = 'INSERT INTO usuario('
                        + '  id, '
	                      + '  nome, '
                        + '  valor_renda) '
	                      + 'VALUES ( '
                        + ' :id, '
                        + ' :nome, '
                        + ' :valor_renda)';
begin
  if FId = 0 then
    raise Exception.Create('É obrigatório o preenchimento do ID');

  FQuery
    .FecharDataSet
    .AdicionarSQL(CONST_INSERIR_USUARIO)
    .AdicionarParametro('id', FId)
    .AdicionarParametro('nome', FNome)
    .AdicionarParametro('valor_renda', FValorRenda)
    .ExecutarSQL;

  Result := Self;
end;

function TModelDAOUsuario.Nome(const pValor: string): IModelDAOUsuario;
begin
  FNome := pValor;

  Result := Self;
end;

function TModelDAOUsuario.ValorRenda(const pValor: double): IModelDAOUsuario;
begin
  FValorRenda := pValor;

  Result := Self;
end;


end.
