unit Model.DAO.Gasto;

interface

type
  IModelDAOGasto = interface
    function Id(const pValor: Integer): IModelDAOGasto;
    function Data(const pValor: TDateTime): IModelDAOGasto;
    function Descricao(const pValor: string): IModelDAOGasto;
    function Valor(const pValor: Double): IModelDAOGasto;
    function IdUsuario(const pValor: Integer): IModelDAOGasto;

    function Inserir: IModelDAOGasto;
    function Atualizar: IModelDAOGasto;
    function Deletar: IModelDAOGasto;
  end;

  TModelDAOGasto = class(TInterfacedObject, IModelDAOGasto)
  private
    FId: Integer;
    FData: TDateTime;
    FDescricao: string;
    FValor: Double;
    FIdUsuario: Integer;
  public
    function Id(const pValor: Integer): IModelDAOGasto;
    function Data(const pValor: TDateTime): IModelDAOGasto;
    function Descricao(const pValor: string): IModelDAOGasto;
    function Valor(const pValor: Double): IModelDAOGasto;
    function IdUsuario(const pValor: Integer): IModelDAOGasto;

    function Inserir: IModelDAOGasto;
    function Atualizar: IModelDAOGasto;
    function Deletar: IModelDAOGasto;

    class function Criar: IModelDAOGasto;
  end;

implementation

uses
  Model.Query.Feature,
  Controller.Helper,
  System.SysUtils;

{ TModelDAOGasto }

function TModelDAOGasto.Atualizar: IModelDAOGasto;
const CONST_ATUALIZAR_DESPESA = 'UPDATE gasto SET '
                              + '  data = :Data, '
                              + '  descricao = :descricao, '
                              + '  valor = :valor '
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
    .ExecutarSQL;

  Result := Self;
end;

class function TModelDAOGasto.Criar: IModelDAOGasto;
begin
  Result := Self.Create;
end;

function TModelDAOGasto.Data(const pValor: TDateTime): IModelDAOGasto;
begin
  FData := pValor;

  Result := Self;
end;

function TModelDAOGasto.Deletar: IModelDAOGasto;
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

function TModelDAOGasto.Descricao(const pValor: string): IModelDAOGasto;
begin
  FDescricao := pValor;

  Result := Self;
end;

function TModelDAOGasto.Id(const pValor: Integer): IModelDAOGasto;
begin
  FId := pValor;

  Result := Self;
end;

function TModelDAOGasto.IdUsuario(const pValor: Integer): IModelDAOGasto;
begin
  FIdUsuario := pValor;

  Result := Self;
end;

function TModelDAOGasto.Inserir: IModelDAOGasto;
const
  CONST_INSERIR_GASTO = 'INSERT INTO gasto('
                      + ' data, '
                      + ' descricao, '
                      + ' valor, '
                      + ' id_usuario)'
//                      + ' id_tipo_gasto)'
                      + ' VALUES( '
                      + ' :data,'
                      + ' :DESCRICAO, '
                      + ' :VALOR,'
                      + ' :id_usuario)';
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
//    .AdicionarParametro('ID_TIPO_GASTO', )
    .ExecutarSQL;

  Result := Self;
end;

function TModelDAOGasto.Valor(const pValor: Double): IModelDAOGasto;
begin
  FValor := pValor;

  Result := Self;
end;

end.
