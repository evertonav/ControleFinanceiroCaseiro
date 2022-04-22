unit Controller;

interface

uses
  Model.DAO.Gasto,
  Model.DAO.DespesasXSobrando,
  Model.DAO.BuscarDespesas,
  Model.DAO.Devedores,
  Model.DAO.BuscarDevedores,
  Data.DB;

type
  IController = interface
    function Gasto: IModelDAOGasto;
    function DespesasXSobrando: IModelDAODespesasXSobrando;
    function BuscarDespesas(var pDataSet: TDataSet): IModelDAOBuscarDespesas;
    function Devedor: IModelDAODevedores;
    function BuscarDevedores: IModelDAOBuscarDevedores;
  end;

  TController = class(TInterfacedObject, IController)
  private
    FDespesasXSobrando: IModelDAODespesasXSobrando;
    FGasto: IModelDAOGasto;
    FBuscarDespesas: IModelDAOBuscarDespesas;
    FDevedor: IModelDAODevedores;
    FBuscarDevedores: IModelDAOBuscarDevedores;
  public
    function Gasto: IModelDAOGasto;
    function DespesasXSobrando: IModelDAODespesasXSobrando;
    function BuscarDespesas(var pDataSet: TDataSet): IModelDAOBuscarDespesas;
    function Devedor: IModelDAODevedores;
    function BuscarDevedores: IModelDAOBuscarDevedores;

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

function TController.Gasto: IModelDAOGasto;
begin
  if not Assigned(FGasto) then
    FGasto := TModelDAOGasto.Criar;

  Result := FGasto;
end;

end.
