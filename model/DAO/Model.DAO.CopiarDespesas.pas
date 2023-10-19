unit Model.DAO.CopiarDespesas;

interface

USES
  Model.Query.FireDac,
  Model.DAO.Copiar;

type
  TModelDAOCopiarDespesas = class(TInterfacedObject,
                                  IModelDAOCopiar)
  private
    FDataFinal: TDate;
    FDataInicial: TDate;
    FDescricao: string;
    FIdUsuario: Integer;
    FQuery: IModelQuery;

    function GetWhereSQL(): string;
  public
    constructor Create(pQuery: IModelQuery); overload;

    constructor Create(const pDataInicial: TDate;
                       const pDataFinal: TDate;
                       const pIdUsuario: Integer;
                       pQuery: IModelQuery); overload;

    function DataInicial(const pValor: TDate): IModelDAOCopiar;
    function DataFinal(const pValor: TDate): IModelDAOCopiar;
    function Descricao(const pValor: string): IModelDAOCopiar;
    function IdUsuario(const pValor: integer): IModelDAOCopiar;

    function Copiar(const pDataDestino: TDate): IModelDAOCopiar;

    class function Criar(pQuery: IModelQuery): IModelDAOCopiar; overload;
    
    class function Criar(const pDataInicial: TDate;
                         const pDataFinal: TDate;
                         const pIdUsuario: Integer;
                         pQuery: IModelQuery): IModelDAOCopiar; overload;    
  end;


implementation

uses
  System.SysUtils, Controller.Helper;

{ TModelDAOCopiarDespesas }

constructor TModelDAOCopiarDespesas.Create(pQuery: IModelQuery);
begin
  FDescricao := '';
  FDataFinal := 0;
  FDataInicial := 0;
  FIdUsuario := -1;
  FQuery := pQuery;
end;

function TModelDAOCopiarDespesas.Copiar(const pDataDestino: TDate): IModelDAOCopiar;
const
  CONST_COPIAR_DESPESAS = 'INSERT INTO gasto( '
                        + '  data, '
                        + '  descricao, '
                        + '  valor, '
                        + '  id_usuario, '
                        + '  pago) ';

var
  lSql: string;

begin
  lSql := CONST_COPIAR_DESPESAS
        + '  SELECT '
        + '''' + pDataDestino.FormatoDataIngles() + ''''
        + '    ,descricao, '
        + '    valor, '
        + '    id_usuario, '
        + '    pago '
        + '  from  '
        + '    gasto '
        + GetWhereSQL();

  FQuery
    .FecharDataSet
    .AdicionarSQL(lSql)
    .ExecutarSQL;

  Result := Self;
end;

constructor TModelDAOCopiarDespesas.Create(const pDataInicial,
  pDataFinal: TDate; const pIdUsuario: Integer;  pQuery: IModelQuery);
begin
  FDataInicial := pDataInicial;
  FDataFinal := pDataFinal;
  FIdUsuario := pIdUsuario;
  FDescricao := '';
  FQuery := pQuery;
end;

class function TModelDAOCopiarDespesas.Criar(const pDataInicial,
  pDataFinal: TDate; const pIdUsuario: Integer;
  pQuery: IModelQuery): IModelDAOCopiar;
begin
  Result := Self.Create(pDataInicial, pDataFinal, pIdUsuario, pQuery);
end;

class function TModelDAOCopiarDespesas.Criar(
  pQuery: IModelQuery): IModelDAOCopiar;
begin
  Result := Self.Create(pQuery);
end;

function TModelDAOCopiarDespesas.DataFinal(const pValor: TDate): IModelDAOCopiar;
begin
  FDataFinal := pValor;

  Result := Self;
end;

function TModelDAOCopiarDespesas.DataInicial(const pValor: TDate): IModelDAOCopiar;
begin
  FDataInicial := pValor;

  Result := Self;
end;

function TModelDAOCopiarDespesas.Descricao(const pValor: string): IModelDAOCopiar;
begin
  FDescricao := pValor;

  Result := Self;
end;

function TModelDAOCopiarDespesas.GetWhereSQL: string;
begin
 Result := ' WHERE 1 = 1 ';

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

function TModelDAOCopiarDespesas.IdUsuario(const pValor: Integer): IModelDAOCopiar;
begin
  FIdUsuario := pValor;

  Result := Self;
end;

end.
