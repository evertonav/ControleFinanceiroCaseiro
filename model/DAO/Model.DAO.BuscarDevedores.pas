unit Model.DAO.BuscarDevedores;

interface

type
  IModelDAOBuscarDevedores = interface
    function DataInicial(const pValor: TDateTime): IModelDAOBuscarDevedores;
    function DataFinal(const pValor: TDateTime): IModelDAOBuscarDevedores;
    function IdUsuario(const pValor: Integer): IModelDAOBuscarDevedores;

    function Total: Double;
  end;

  TModelDAOBuscarDevedores = class(TInterfacedObject, IModelDAOBuscarDevedores)
  private
    FIdUsuario: Integer;
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;
  public
    function DataInicial(const pValor: TDateTime): IModelDAOBuscarDevedores;
    function DataFinal(const pValor: TDateTime): IModelDAOBuscarDevedores;
    function IdUsuario(const pValor: Integer): IModelDAOBuscarDevedores;

    function Total: Double;
    class function Criar: IModelDAOBuscarDevedores;
  end;

implementation

uses
  Model.Query.Feature;

{ TModelDAOBuscarDevedores }

class function TModelDAOBuscarDevedores.Criar: IModelDAOBuscarDevedores;
begin
  Result := Self.Create;
end;

function TModelDAOBuscarDevedores.DataFinal(
  const pValor: TDateTime): IModelDAOBuscarDevedores;
begin
  FDataFinal := pValor;

  Result := Self;
end;

function TModelDAOBuscarDevedores.DataInicial(
  const pValor: TDateTime): IModelDAOBuscarDevedores;
begin
  FDataInicial := pValor;

  Result := Self;
end;

function TModelDAOBuscarDevedores.IdUsuario(
  const pValor: Integer): IModelDAOBuscarDevedores;
begin
   FIdUsuario := pValor;

   Result := Self;
end;

function TModelDAOBuscarDevedores.Total: Double;
const CONST_SOMATORIO_DESPESA_PERIODO = ' select '
                                      + '   SUM(valor_emprestado) '
                                      + ' from '
                                      + '   devedores '
                                      + ' where data_emprestou between :DataInicial'
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

end.
