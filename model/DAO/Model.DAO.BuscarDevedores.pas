unit Model.DAO.BuscarDevedores;

interface

type
  IModelDAOBuscarDevedores = interface
    function DataInicial(const pValor: TDateTime): IModelDAOBuscarDevedores;
    function DataFinal(const pValor: TDateTime): IModelDAOBuscarDevedores;
    function IdUsuario(const pValor: Integer): IModelDAOBuscarDevedores;
    function Pago(const pValor: Boolean): IModelDAOBuscarDevedores;

    function Total: Double;
  end;

  TModelDAOBuscarDevedores = class(TInterfacedObject, IModelDAOBuscarDevedores)
  private
    FIdUsuario: Integer;
    FDataInicial: TDate;
    FDataFinal: TDate;
    FPago: SmallInt;

    function GetWhereSQL: string;
  public
    function DataInicial(const pValor: TDateTime): IModelDAOBuscarDevedores;
    function DataFinal(const pValor: TDateTime): IModelDAOBuscarDevedores;
    function IdUsuario(const pValor: Integer): IModelDAOBuscarDevedores;
    function Pago(const pValor: Boolean): IModelDAOBuscarDevedores;

    constructor Create;

    function Total: Double;
    class function Criar: IModelDAOBuscarDevedores;
  end;

implementation

uses
  Model.Query.Feature,
  Controller.Helper,
  System.SysUtils;

{ TModelDAOBuscarDevedores }

constructor TModelDAOBuscarDevedores.Create;
begin
  FIdUsuario := 0;
  FDataInicial := 0;
  FDataInicial := 0;
  FPago := -1;
end;

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

function TModelDAOBuscarDevedores.GetWhereSQL: string;
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
            + ' AND data_emprestou between '
            + '''' + FDataInicial.FormatoDataIngles + ''''
            + ' AND '
            + '''' + FDataFinal.FormatoDataIngles + '''';
  end;
end;

function TModelDAOBuscarDevedores.IdUsuario(
  const pValor: Integer): IModelDAOBuscarDevedores;
begin
   FIdUsuario := pValor;

   Result := Self;
end;

function TModelDAOBuscarDevedores.Pago(
  const pValor: Boolean): IModelDAOBuscarDevedores;
begin
  FPago := Integer(pValor);

  Result := Self;
end;

function TModelDAOBuscarDevedores.Total: Double;
const CONST_SOMATORIO_DESPESA_PERIODO = ' select '
                                      + '   SUM(valor_emprestado) '
                                      + ' from '
                                      + '   devedores ';
                                      //+ ' where data_emprestou between :DataInicial'
                                      //+ '   and :DataFinal'
                                      //+ '   and id_usuario = :id_usuario';
begin
  Result := TModelQueryFeature
               .Criar
               .Query
               .FecharDataSet
               .AdicionarSQL(CONST_SOMATORIO_DESPESA_PERIODO + GetWhereSQL)
               //.AdicionarParametro('DataInicial', FDataInicial)
               //.AdicionarParametro('DataFinal', FDataFinal)
               //.AdicionarParametro('id_usuario', FIdUsuario)
               .AbrirDataSet
               .GetQuery
               .Fields[0].AsFloat;
end;

end.
