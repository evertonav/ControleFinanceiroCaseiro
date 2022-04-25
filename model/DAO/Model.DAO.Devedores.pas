unit Model.DAO.Devedores;

interface

type
  IModelDAODevedores = interface
    function Id(const pValor: Integer): IModelDAODevedores;
    function IdPessoaDevedora(const pValor: Integer): IModelDAODevedores;
    function ValorEmprestado(const pValor: Double): IModelDAODevedores;
    function Pago(const pValor: SmallInt): IModelDAODevedores;
    function DataEmprestou(const pValor: TDateTime): IModelDAODevedores;
    function IdUsuario(const pValor: integer): IModelDAODevedores;

    function Inserir: IModelDAODevedores;
    function Atualizar: IModelDAODevedores;
    function Deletar: IModelDAODevedores;
  end;

  TModelDAODevedores = class(TInterfacedObject, IModelDAODevedores)
  private
    FValorEmprestado: Double;
    FPago: Integer;
    FIdPessoaDevedora: Integer;
    FDataEmprestou: TDateTime;
    FIdUsuario: Integer;
    Fid: Integer;

  public
    function Id(const pValor: Integer): IModelDAODevedores;
    function IdPessoaDevedora(const pValor: integer): IModelDAODevedores;
    function ValorEmprestado(const pValor: Double): IModelDAODevedores;
    function Pago(const pValor: SmallInt): IModelDAODevedores;
    function DataEmprestou(const pValor: TDateTime): IModelDAODevedores;
    function IdUsuario(const pValor: integer): IModelDAODevedores;

    function Inserir: IModelDAODevedores;
    function Atualizar: IModelDAODevedores;
    function Deletar: IModelDAODevedores;

    class function Criar: IModelDAODevedores;
  end;

implementation

USES
  Model.Query.Feature,
  System.SysUtils;

{ TModelDAODevedores }

function TModelDAODevedores.Atualizar: IModelDAODevedores;
const CONST_ATUALIZAR_DEVEDOR = ' UPDATE devedores set '
                              + '   id_pessoa_devedora = :id_pessoa_devedora, '
                              + '   valor_emprestado = :valor_emprestado, '
                              + '   pago = :pago, '
                              + '   data_emprestou = :data_emprestou, '
                              + '   id_usuario = :id_usuario '
                              + ' where id = :id ';
begin
  if FId <= 0 then
    raise Exception.Create('Você precisa preencher o id para atualizar a despesa!');

  TModelQueryFeature
    .Criar
    .Query
    .FecharDataSet
    .AdicionarSQL(CONST_ATUALIZAR_DEVEDOR)
    .AdicionarParametro('id', Fid)
    .AdicionarParametro('id_pessoa_devedora', FIdPessoaDevedora)
    .AdicionarParametro('valor_emprestado', FValorEmprestado)
    .AdicionarParametro('pago', FPago)
    .AdicionarParametro('data_emprestou', FDataEmprestou)
    .AdicionarParametro('id_usuario', FIdUsuario)
    .ExecutarSQL;

  Result := Self;
end;

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

function TModelDAODevedores.Deletar: IModelDAODevedores;
const CONST_DELETAR_DEVEDORES = 'DELETE FROM DEVEDORES '
                              + 'WHERE ID = :ID';
begin
  if FId <= 0 then
    raise Exception.Create('Você precisa preencher o id para atualizar a despesa!');

  TModelQueryFeature
    .Criar
    .Query
    .FecharDataSet
    .AdicionarSQL(CONST_DELETAR_DEVEDORES)
    .AdicionarParametro('ID', FId)
    .ExecutarSQL;

  Result := Self;
end;

function TModelDAODevedores.Id(const pValor: Integer): IModelDAODevedores;
begin
  Fid := pValor;

  Result := Self;
end;

function TModelDAODevedores.IdPessoaDevedora(const pValor: integer): IModelDAODevedores;
begin
  FIdPessoaDevedora := pValor;

  Result := Self;
end;

function TModelDAODevedores.IdUsuario(
  const pValor: integer): IModelDAODevedores;
begin
  FIdUsuario := pValor;

  Result := Self;
end;

function TModelDAODevedores.Inserir: IModelDAODevedores;
const
  CONST_INSERIR_DEVEDOR = 'INSERT INTO devedores( '
                        + ' id_pessoa_devedora, '
                        + ' valor_emprestado, '
                        + ' pago, '
                        + ' data_emprestou,'
                        + ' id_usuario)'
                        + ' VALUES( '
                        + ' :id_pessoa_devedora,'
                        + ' :valor_emprestado, '
                        + ' :pago, '
                        + ' :data_emprestou, '
                        + ' :id_usuario)';
begin
  TModelQueryFeature
    .Criar
    .Query
    .FecharDataSet
    .AdicionarSQL(CONST_INSERIR_DEVEDOR)
    .AdicionarParametro('id_pessoa_devedora', FIdPessoaDevedora)
    .AdicionarParametro('valor_emprestado', FValorEmprestado)
    .AdicionarParametro('pago', FPago)
    .AdicionarParametro('data_emprestou', FDataEmprestou)
    .AdicionarParametro('id_usuario', FIdUsuario)
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
