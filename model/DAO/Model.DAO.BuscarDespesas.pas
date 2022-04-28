unit Model.DAO.BuscarDespesas;

interface

uses
  Data.DB,
  Model.Query.Feature;

type
  IModelDAOBuscarDespesas = interface
    function Pago(const pValor: SmallInt): IModelDAOBuscarDespesas;
    function IdUsuario(const pValor: Integer): IModelDAOBuscarDespesas;
    function Descricao(const pValor: string): IModelDAOBuscarDespesas;
    function DataInicial(const pValor: TDateTime): IModelDAOBuscarDespesas;
    function DataFinal(const pValor: TDateTime): IModelDAOBuscarDespesas;
    function Executar: IModelDAOBuscarDespesas;
  end;

  TModelDAOBuscarDespesas = class(TInterfacedObject, IModelDAOBuscarDespesas)
  private
    FDataInicial: TDate;
    FDataFinal: TDate;
    FDescricao: string;
    FQuery: IModelQueryFeature;
    FIdUsuario: Integer;
    FPago: SmallInt;

    function GetWhereSQL: string;
  public
    constructor Create(var pDataSet: TDataSet);

    function Pago(const pValor: SmallInt): IModelDAOBuscarDespesas;
    function IdUsuario(const pValor: Integer): IModelDAOBuscarDespesas;
    function Descricao(const pValor: string): IModelDAOBuscarDespesas;
    function DataInicial(const pValor: TDateTime): IModelDAOBuscarDespesas;
    function DataFinal(const pValor: TDateTime): IModelDAOBuscarDespesas;
    function Executar: IModelDAOBuscarDespesas;

    class function Criar(var pDataSet: TDataSet): IModelDAOBuscarDespesas;
  end;

implementation

uses
  System.SysUtils,
  Controller.Helper;

{ TModelDAOBuscarDespesas }

constructor TModelDAOBuscarDespesas.Create(var pDataSet: TDataSet);
begin
  FQuery :=  TModelQueryFeature.Criar;
  pDataSet := FQuery.Query.GetQuery;

  FDataInicial := 0;
  FDataFinal := 0;
  FDescricao := EmptyStr;
  FIdUsuario := 0;
  FPago := -1;
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
                            + '  Data, '
                            + '  VALOR '
                            + 'FROM '
                            + '  gasto ';
begin
  FQuery
    .Query
    .FecharDataSet
    .AdicionarSQL(CONST_BUSCAR_DESPESAS + GetWhereSQL)
    .AbrirDataSet;

  Result := Self;
end;

function TModelDAOBuscarDespesas.GetWhereSQL: string;
begin
  Result := ' WHERE 1 = 1 ';

  if FPago <> -1 then
  begin
    Result := Result
            + ' AND pago = ' + FPago.ToString;
  end;

  if FIdUsuario > 0 then
  begin
    Result := Result
            + ' AND id_usuario = '
            + FIdUsuario.ToString;
  end;

  if FDescricao.Trim <> EmptyStr then
    Result := Result + ' AND Descricao like ' + '''' + '%' + FDescricao + '%' + '''';

  if (FDataInicial <> 0)
  and (FDataFinal <> 0) then
  begin
    Result := Result
            + ' AND data between '
            + '''' + FDataInicial.FormatoDataIngles + ''''
            + ' AND '
            + '''' + FDataFinal.FormatoDataIngles + '''';
  end;
end;

function TModelDAOBuscarDespesas.IdUsuario(
  const pValor: Integer): IModelDAOBuscarDespesas;
begin
  FIdUsuario := pValor;

  Result := Self;
end;

function TModelDAOBuscarDespesas.Pago(
  const pValor: SmallInt): IModelDAOBuscarDespesas;
begin
  FPago := pValor;

  Result := Self;
end;

end.
