unit Model.DAO.BuscarDespesas;

interface

uses
  Data.DB;

type
  IModelDAOBuscarDespesas = interface
    function Descricao(const pValor: string): IModelDAOBuscarDespesas;
    function DataInicial(const pValor: TDateTime): IModelDAOBuscarDespesas;
    function DataFinal(const pValor: TDateTime): IModelDAOBuscarDespesas;
    function Executar: IModelDAOBuscarDespesas;
  end;

  TModelDAOBuscarDespesas = class(TInterfacedObject, IModelDAOBuscarDespesas)
  private
    FDataInicial: TDate;
    FDataFinal: TDate;
    FDataSet: TDataSet;
    FDescricao: string;

    function GetWhereSQL: string;
  public
    constructor Create(var pDataSet: TDataSet);

    function Descricao(const pValor: string): IModelDAOBuscarDespesas;
    function DataInicial(const pValor: TDateTime): IModelDAOBuscarDespesas;
    function DataFinal(const pValor: TDateTime): IModelDAOBuscarDespesas;
    function Executar: IModelDAOBuscarDespesas;

    class function Criar(var pDataSet: TDataSet): IModelDAOBuscarDespesas;
  end;

implementation

uses
  Model.Query.Feature,
  System.SysUtils,
  Controller.Helper;

{ TModelDAOBuscarDespesas }

constructor TModelDAOBuscarDespesas.Create(var pDataSet: TDataSet);
begin
  FDataSet := pDataSet;

  FDataInicial := 0;
  FDataFinal := 0;
  FDescricao := EmptyStr;
end;

class function TModelDAOBuscarDespesas.Criar(var pDataSet: TDataSet): IModelDAOBuscarDespesas;
begin
  Result := Self.Create(pDataSet);
end;

function TModelDAOBuscarDespesas.DataFinal(
  const pValor: TDateTime): IModelDAOBuscarDespesas;
begin
  FDataFinal := pValor;

  Result := Self;
end;

function TModelDAOBuscarDespesas.DataInicial(
  const pValor: TDateTime): IModelDAOBuscarDespesas;
begin
  FDataInicial := pValor;

  Result := Self;
end;

function TModelDAOBuscarDespesas.Descricao(
  const pValor: string): IModelDAOBuscarDespesas;
begin
  FDescricao := pValor;

  Result := Self;
end;

function TModelDAOBuscarDespesas.Executar: IModelDAOBuscarDespesas;
const CONST_BUSCAR_DESPESAS = 'SELECT'
                            + '  ID, '
                            + '  DESCRICAO, '
                            + '  VALOR '
                            + 'FROM '
                            + '  gasto ';
begin
  FDataSet := TModelQueryFeature
              .Criar
              .Query
              .FecharDataSet
              .AdicionarSQL(CONST_BUSCAR_DESPESAS + GetWhereSQL)
//              .AdicionarParametro('DataInicial', FDataInicial)
//              .AdicionarParametro('DataFinal', FDataFinal)
              .AbrirDataSet
              .GetQuery;

  Result := Self;
end;

function TModelDAOBuscarDespesas.GetWhereSQL: string;
begin
  Result := ' WHERE 1 = 1';

  if FDescricao.Trim <> EmptyStr then
    Result := Result + ' AND Descricao like ' + '''' + '%' + FDescricao + '%' + '''';

  if (FDataInicial <> 0)
  and (FDataFinal <> 0) then
  begin
    Result := Result
            + 'data between '
            + '''' + FDataInicial.FormatoDataIngles + ''''
            + '''' + FDataFinal.FormatoDataIngles + '''';
  end;
end;

end.
