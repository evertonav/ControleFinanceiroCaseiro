unit Model.DAO.Despesas;

interface

type
  IModelDAODespesas = interface
    function Id(const pValor: Integer): IModelDAODespesas;
    function Data(const pValor: TDateTime): IModelDAODespesas;
    function Descricao(const pValor: string): IModelDAODespesas;
    function Valor(const pValor: Double): IModelDAODespesas;
    function IdUsuario(const pValor: Integer): IModelDAODespesas;
    function Pago(const pValor: SmallInt): IModelDAODespesas;

    function Inserir: IModelDAODespesas;
    function Atualizar: IModelDAODespesas;
    function Deletar: IModelDAODespesas;
  end;

  TModelDAODespesas = class(TInterfacedObject, IModelDAODespesas)
  private
    FId: Integer;
    FData: TDateTime;
    FDescricao: string;
    FValor: Double;
    FIdUsuario: Integer;
    FPago: SmallInt;
  public
    function Id(const pValor: Integer): IModelDAODespesas;
    function Data(const pValor: TDateTime): IModelDAODespesas;
    function Descricao(const pValor: string): IModelDAODespesas;
    function Valor(const pValor: Double): IModelDAODespesas;
    function IdUsuario(const pValor: Integer): IModelDAODespesas;
    function Pago(const pValor: SmallInt): IModelDAODespesas;

    function Inserir: IModelDAODespesas;
    function Atualizar: IModelDAODespesas;
    function Deletar: IModelDAODespesas;

    class function Criar: IModelDAODespesas;
  end;

implementation

uses
  Model.Query.Feature,
  Controller.Helper,
  System.SysUtils;

{ TModelDAODespesas }

function TModelDAODespesas.Atualizar: IModelDAODespesas;
const CONST_ATUALIZAR_DESPESA = 'UPDATE gasto SET '
                              + '  data = :Data, '
                              + '  descricao = :descricao, '
                              + '  valor = :valor, '
                              + '  pago = :pago '
                              + 'WHERE ID = :ID';
begin
  if FId <= 0 then
    raise Exception.Create('Você precisa preencher o id para atualizar a despesa!');

  TModelQueryFeature
    .Criar
    .Query
    .FecharDataSet
    .AdicionarSQL(CONST_ATUALIZAR_DESPESA)
    .AdicionarParametro('ID', FId)
    .AdicionarParametro('data', FData)
    .AdicionarParametro('descricao', FDescricao)
    .AdicionarParametro('valor', FValor)
    .AdicionarParametro('pago', FPago)
    .ExecutarSQL;

  Result := Self;
end;

class function TModelDAODespesas.Criar: IModelDAODespesas;
begin
  Result := Self.Create;
end;

function TModelDAODespesas.Data(const pValor: TDateTime): IModelDAODespesas;
begin
  FData := pValor;

  Result := Self;
end;

function TModelDAODespesas.Deletar: IModelDAODespesas;
const CONST_DELETAR_GASTO = 'DELETE FROM GASTO '
                          + 'WHERE ID = :ID';
begin
  if FId <= 0 then
    raise Exception.Create('Você precisa preencher o id para atualizar a despesa!');

  TModelQueryFeature
    .Criar
    .Query
    .FecharDataSet
    .AdicionarSQL(CONST_DELETAR_GASTO)
    .AdicionarParametro('ID', FId)
    .ExecutarSQL;

  Result := Self;
end;

function TModelDAODespesas.Descricao(const pValor: string): IModelDAODespesas;
begin
  FDescricao := pValor;

  Result := Self;
end;

function TModelDAODespesas.Id(const pValor: Integer): IModelDAODespesas;
begin
  FId := pValor;

  Result := Self;
end;

function TModelDAODespesas.IdUsuario(const pValor: Integer): IModelDAODespesas;
begin
  FIdUsuario := pValor;

  Result := Self;
end;

function TModelDAODespesas.Inserir: IModelDAODespesas;
const
  CONST_INSERIR_GASTO = 'INSERT INTO gasto('
                      + '  data, '
                      + '  descricao, '
                      + '  valor, '
                      + '  id_usuario,'
                      + '  pago )'
//                      + ' id_tipo_gasto)'
                      + ' VALUES( '
                      + '  :data,'
                      + '  :DESCRICAO, '
                      + '  :VALOR,'
                      + '  :id_usuario,'
                      + '  :pago)';
                      //+ ' :ID_TIPO_GASTO)';
begin
  TModelQueryFeature
    .Criar
    .Query
    .FecharDataSet
    .AdicionarSQL(CONST_INSERIR_GASTO)
    .AdicionarParametro('data', FData)
    .AdicionarParametro('DESCRICAO', FDescricao)
    .AdicionarParametro('VALOR', FValor)
    .AdicionarParametro('id_usuario', FIdUsuario)
    .AdicionarParametro('pago', FPago)
//    .AdicionarParametro('ID_TIPO_GASTO', )
    .ExecutarSQL;

  Result := Self;
end;

function TModelDAODespesas.Pago(const pValor: SmallInt): IModelDAODespesas;
begin
  FPago := pValor;

  Result := Self;
end;

function TModelDAODespesas.Valor(const pValor: Double): IModelDAODespesas;
begin
  FValor := pValor;

  Result := Self;
end;

end.
