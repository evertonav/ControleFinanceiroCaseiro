unit Model.DAO.BuscarPessoas;

interface

uses
  FMX.ListBox;

type
  IModelDAOBuscarPessoas = Interface
    function Executar(pComboBoxPreencher: TComboBox): IModelDAOBuscarPessoas;
  End;

  TModelDAOBuscarPessoas = class(TInterfacedObject, IModelDAOBuscarPessoas)
  public
    function Executar(pComboBoxPreencher: TComboBox): IModelDAOBuscarPessoas;

    class function Criar: IModelDAOBuscarPessoas;
  end;

implementation

uses
  Model.Query.Feature,
  Data.DB;

{ TModelDAOBuscarPessoas }

class function TModelDAOBuscarPessoas.Criar: IModelDAOBuscarPessoas;
begin
  Result := Self.Create;
end;

function TModelDAOBuscarPessoas.Executar(
  pComboBoxPreencher: TComboBox): IModelDAOBuscarPessoas;
const CONST_BUSCAR_PESSOAS = ' select '
                           + '   nome '
                           + ' from '
                           + '   pessoa ';
var
  lDataSet: TDataSet;
begin
  lDataSet := TModelQueryFeature
                .Criar
                .Query
                .FecharDataSet
                .AdicionarSQL(CONST_BUSCAR_PESSOAS)
                .AbrirDataSet
                .GetQuery;

  lDataSet.First;
  while not lDataSet.Eof do
  begin
    pComboBoxPreencher.Items.Add(lDataSet.FieldByName('nome').AsString);
    lDataSet.Next;
  end;

  Result := Self;
end;

end.
