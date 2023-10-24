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

    function Inserir(): IModelDAOUsuario;
    function Atualizar(): IModelDAOUsuario;
    function Consultar(): TUsuario;

    constructor Create(pQuery: IModelQuery);

    class function Criar(pQuery: IModelQuery): IModelDAOUsuario;
  end;

implementation

uses
  Data.DB;

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

function TModelDAOUsuario.Consultar(): TUsuario;
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
  lDadosConsulta := FQuery
                      .FecharDataSet
                      .AdicionarSQL(CONST_CONSULTAR_USUARIO)
                      .AdicionarParametro('id', FId)
                      .AbrirDataSet
                      .GetQuery;

  Result := TUsuario.Create(lDadosConsulta.FieldByName('id').AsInteger,
                            lDadosConsulta.FieldByName('Nome').AsString,
                            lDadosConsulta.FieldByName('valor_renda').AsFloat);
end;

constructor TModelDAOUsuario.Create(pQuery: IModelQuery);
begin
  FQuery := pQuery;
end;

class function TModelDAOUsuario.Criar(pQuery: IModelQuery): IModelDAOUsuario;
begin
  Result := Self.Create(pQuery);
end;

function TModelDAOUsuario.Id(const pId: Integer): IModelDAOUsuario;
begin
  FId := pId;

  Result := Self;
end;

function TModelDAOUsuario.Inserir: IModelDAOUsuario;
const
  CONST_INSERIR_USUARIO = 'INSERT INTO usuario('
	                      + '  nome, '
                        + '  valor_renda) '
	                      + 'VALUES ( '
                        + ' :nome, '
                        + ' :valor_renda)';
begin
  FQuery
    .FecharDataSet
    .AdicionarSQL(CONST_INSERIR_USUARIO)
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
