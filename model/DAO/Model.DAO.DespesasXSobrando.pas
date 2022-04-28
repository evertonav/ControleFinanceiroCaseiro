unit Model.DAO.DespesasXSobrando;

interface

type
  IModelDAODespesasXSobrando = interface
    function IdUsuario(const pValor: integer): IModelDAODespesasXSobrando;
    function DataInicial(const pValor: TDateTime): IModelDAODespesasXSobrando;
    function DataFinal(const pValor: TDateTime): IModelDAODespesasXSobrando;
    function Pago(const pValor: SmallInt): IModelDAODespesasXSobrando;

    function TotalDespesas: Double;
    function TotalSobrando: Double; overload;
    function TotalSobrando(const pTotalDespesas: Double): Double; overload;
  end;

  TModelDAODespesasXSobrando = class(TInterfacedObject,
                                     IModelDAODespesasXSobrando)
  private
    FDataInicial: TDate;
    FDataFinal: TDate;
    FIdUsuario: Integer;
    FPago: SmallInt;

    function GetWhereSQL: string;
  public
    constructor Create;

    class function Criar: IModelDAODespesasXSobrando;

    function IdUsuario(const pValor: integer): IModelDAODespesasXSobrando;
    function DataInicial(const pValor: TDateTime): IModelDAODespesasXSobrando;
    function DataFinal(const pValor: TDateTime): IModelDAODespesasXSobrando;
    function Pago(const pValor: SmallInt): IModelDAODespesasXSobrando;

    function TotalDespesas: Double;
    function TotalSobrando: Double; overload;
    function TotalSobrando(const pTotalDespesas: Double): Double; overload;
  end;

implementation

uses
  Model.Query.Feature,
  Controller.VariaveisGlobais,
  System.SysUtils,
  Controller.Helper;

{ TModelDAODespesasXSobrando }

constructor TModelDAODespesasXSobrando.Create;
begin
  FDataInicial := 0;
  FDataFinal := 0;
  FIdUsuario := 0;
  FPago := -1;
end;

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

function TModelDAODespesasXSobrando.GetWhereSQL: string;
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

function TModelDAODespesasXSobrando.IdUsuario(
  const pValor: integer): IModelDAODespesasXSobrando;
begin
  FIdUsuario := pValor;

  Result := Self;
end;

function TModelDAODespesasXSobrando.Pago(
  const pValor: SmallInt): IModelDAODespesasXSobrando;
begin
  FPago := pValor;

  Result := Self;
end;

function TModelDAODespesasXSobrando.TotalDespesas: Double;
const CONST_SOMATORIO_DESPESA_PERIODO = ' select '
                                      + '   SUM(VALOR) '
                                      + ' from '
                                      + '   gasto '
                                      {+ ' where data between :DataInicial'
                                      + '   and :DataFinal'
                                      + '   and id_usuario = :id_usuario'};
begin
  Result := TModelQueryFeature
               .Criar
               .Query
               .FecharDataSet
               .AdicionarSQL(CONST_SOMATORIO_DESPESA_PERIODO + GetWhereSQL)
               {.AdicionarParametro('DataInicial', FDataInicial)
               .AdicionarParametro('DataFinal', FDataFinal)
               .AdicionarParametro('id_usuario', FIdUsuario)}
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
