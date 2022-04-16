unit Model.DAO.DespesasXSobrando;

interface

type
  IModelDAODespesasXSobrando = interface
    function IdUsuario(const pValor: integer): IModelDAODespesasXSobrando;
    function DataInicial(const pValor: TDateTime): IModelDAODespesasXSobrando;
    function DataFinal(const pValor: TDateTime): IModelDAODespesasXSobrando;

    function TotalDespesas: Double;
    function TotalSobrando: Double; overload;
    function TotalSobrando(const pTotalDespesas: Double): Double; overload;
  end;

  TModelDAODespesasXSobrando = class(TInterfacedObject,
                                     IModelDAODespesasXSobrando)
  private
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;
    FIdUsuario: Integer;
  public
    class function Criar: IModelDAODespesasXSobrando;

    function IdUsuario(const pValor: integer): IModelDAODespesasXSobrando;
    function DataInicial(const pValor: TDateTime): IModelDAODespesasXSobrando;
    function DataFinal(const pValor: TDateTime): IModelDAODespesasXSobrando;

    function TotalDespesas: Double;
    function TotalSobrando: Double; overload;
    function TotalSobrando(const pTotalDespesas: Double): Double; overload;
  end;

implementation

uses
  Model.Query.Feature,
  Controller.VariaveisGlobais;

{ TModelDAODespesasXSobrando }

class function TModelDAODespesasXSobrando.Criar: IModelDAODespesasXSobrando;
begin
  Result := Self.Create;
end;

function TModelDAODespesasXSobrando.DataFinal(
  const pValor: TDateTime): IModelDAODespesasXSobrando;
begin
  FDataFinal := pValor;

  Result := Self;
end;

function TModelDAODespesasXSobrando.DataInicial(
  const pValor: TDateTime): IModelDAODespesasXSobrando;
begin
  FDataInicial := pValor;

  Result := Self;
end;

function TModelDAODespesasXSobrando.IdUsuario(
  const pValor: integer): IModelDAODespesasXSobrando;
begin
  FIdUsuario := pValor;

  Result := Self;
end;

function TModelDAODespesasXSobrando.TotalDespesas: Double;
const CONST_SOMATORIO_DESPESA_PERIODO = ' select '
                                      + '   SUM(VALOR) '
                                      + ' from '
                                      + '   gasto '
                                      + ' where data between :DataInicial'
                                      + '   and :DataFinal'
                                      + '   and id_usuario = :id_usuario';
begin
  Result := TModelQueryFeature
               .Criar
               .Query
               .FecharDataSet
               .AdicionarSQL(CONST_SOMATORIO_DESPESA_PERIODO)
               .AdicionarParametro('DataInicial', FDataInicial)
               .AdicionarParametro('DataFinal', FDataFinal)
               .AdicionarParametro('id_usuario', FIdUsuario)
               .AbrirDataSet
               .GetQuery
               .Fields[0].AsFloat;
end;

function TModelDAODespesasXSobrando.TotalSobrando(
  const pTotalDespesas: Double): Double;
begin
  Result := TUsuarioLogado.gValorRenda - pTotalDespesas;
end;

function TModelDAODespesasXSobrando.TotalSobrando: Double;
begin
  Result := TUsuarioLogado.gValorRenda - TotalDespesas;
end;


end.
