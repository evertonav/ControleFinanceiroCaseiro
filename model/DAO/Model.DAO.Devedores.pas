unit Model.DAO.Devedores;

interface

type
  IModelDAODevedores = interface
    function IdPessoa(const pValor: integer): IModelDAODevedores;
    function ValorEmprestado(const pValor: Double): IModelDAODevedores;
    function Pago(const pValor: SmallInt): IModelDAODevedores;
    function DataEmprestou(const pValor: TDateTime): IModelDAODevedores;

    function Inserir: IModelDAODevedores;
  end;

  TModelDAODevedores = class(TInterfacedObject, IModelDAODevedores)
  private
    FValorEmprestado: Double;
    FPago: Integer;
    FIdPessoa: Integer;
    FDataEmprestou: TDateTime;

  public
    function IdPessoa(const pValor: integer): IModelDAODevedores;
    function ValorEmprestado(const pValor: Double): IModelDAODevedores;
    function Pago(const pValor: SmallInt): IModelDAODevedores;
    function DataEmprestou(const pValor: TDateTime): IModelDAODevedores;

    function Inserir: IModelDAODevedores;

    class function Criar: IModelDAODevedores;
  end;

implementation

USES
  Model.Query.Feature;

{ TModelDAODevedores }

class function TModelDAODevedores.Criar: IModelDAODevedores;
begin
  Result := Self.Create;
end;

function TModelDAODevedores.DataEmprestou(
  const pValor: TDateTime): IModelDAODevedores;
begin
  FDataEmprestou := pValor;

  Result := Self;
end;

function TModelDAODevedores.IdPessoa(const pValor: integer): IModelDAODevedores;
begin
  FIdPessoa := pValor;

  Result := Self;
end;

function TModelDAODevedores.Inserir: IModelDAODevedores;
const
  CONST_INSERIR_DEVEDOR = 'INSERT INTO devedores( '
                        + ' id_pessoa, '
                        + ' valor_emprestado, '
                        + ' pago, '
                        + ' data_emprestou)'
                        + ' VALUES( '
                        + ' :id_pessoa,'
                        + ' :valor_emprestado, '
                        + ' :pago, '
                        + ' :data_emprestou)';
begin
  TModelQueryFeature
    .Criar
    .Query
    .FecharDataSet
    .AdicionarSQL(CONST_INSERIR_DEVEDOR)
    .AdicionarParametro('id_pessoa', FIdPessoa)
    .AdicionarParametro('valor_emprestado', FValorEmprestado)
    .AdicionarParametro('pago', FPago)
    .AdicionarParametro('data_emprestou', FDataEmprestou)
    .ExecutarSQL;

  Result := Self;
end;

function TModelDAODevedores.Pago(const pValor: SmallInt): IModelDAODevedores;
begin
  FPago := pValor;

  Result := Self;
end;

function TModelDAODevedores.ValorEmprestado(
  const pValor: Double): IModelDAODevedores;
begin
  FValorEmprestado := pValor;

  Result := Self;
end;

end.
