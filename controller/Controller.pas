unit Controller;

interface

uses
  Model.DAO.Despesas,
  Model.DAO.DespesasXSobrando,
  Model.DAO.BuscarDespesas,
  Model.DAO.Devedores,
  Model.DAO.BuscarDevedores,
  Model.DAO.BuscarPessoas,
  Data.DB;

type
  IController = interface
    function Despesas: IModelDAODespesas;
    function DespesasXSobrando: IModelDAODespesasXSobrando;
    function BuscarDespesas(var pDataSet: TDataSet): IModelDAOBuscarDespesas;
    function Devedor: IModelDAODevedores;
    function BuscarDevedores: IModelDAOBuscarDevedores;
    function BuscarPessoas: IModelDAOBuscarPessoas;
  end;

  TController = class(TInterfacedObject, IController)
  private
    FDespesasXSobrando: IModelDAODespesasXSobrando;
    FDespesas: IModelDAODespesas;
    FBuscarDespesas: IModelDAOBuscarDespesas;
    FDevedor: IModelDAODevedores;
    FBuscarDevedores: IModelDAOBuscarDevedores;
    FBuscarPessoa: IModelDAOBuscarPessoas;
  public
    function Despesas: IModelDAODespesas;
    function DespesasXSobrando: IModelDAODespesasXSobrando;
    function BuscarDespesas(var pDataSet: TDataSet): IModelDAOBuscarDespesas;
    function Devedor: IModelDAODevedores;
    function BuscarDevedores: IModelDAOBuscarDevedores;
    function BuscarPessoas: IModelDAOBuscarPessoas;

    class function Criar: IController;
  end;

implementation

{ TController }

function TController.BuscarDespesas(var pDataSet: TDataSet): IModelDAOBuscarDespesas;
begin
  if not Assigned(FBuscarDespesas) then
    FBuscarDespesas := TModelDAOBuscarDespesas.Criar(pDataSet);

  Result := FBuscarDespesas;
end;

function TController.BuscarDevedores: IModelDAOBuscarDevedores;
begin
  if not Assigned(FBuscarDevedores) then
    FBuscarDevedores := TModelDAOBuscarDevedores.Criar;

  Result := FBuscarDevedores;
end;

function TController.BuscarPessoas: IModelDAOBuscarPessoas;
begin
  if not Assigned(FBuscarPessoa) then
    FBuscarPessoa := TModelDAOBuscarPessoas.Criar;

  Result := FBuscarPessoa;
end;

class function TController.Criar: IController;
begin
  Result := Self.Create;
end;

function TController.DespesasXSobrando: IModelDAODespesasXSobrando;
begin
  if not Assigned(FDespesasXSobrando) then
    FDespesasXSobrando := TModelDAODespesasXSobrando.Criar;

  Result := FDespesasXSobrando;
end;

function TController.Devedor: IModelDAODevedores;
begin
  if not Assigned(FDevedor) then
    FDevedor := TModelDAODevedores.Criar;

  Result := FDevedor;
end;

function TController.Despesas: IModelDAODespesas;
begin
  if not Assigned(FDespesas) then
    FDespesas := TModelDAODespesas.Criar;

  Result := FDespesas;
end;

end.
