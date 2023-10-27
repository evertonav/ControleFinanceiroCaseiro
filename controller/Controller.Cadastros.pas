unit Controller.Cadastros;

interface

uses
  Controller.Interfaces.Cadastros,
  Model.DAO.Interfaces.Usuario,
  Model.Query.Feature;

type
  TControllerCadastros = class(TInterfacedObject, IControllerCadastros)
  private
    FCadastroUsuario: IModelDAOUsuario;
    FQueryFeature: IModelQueryFeature;
  public
    function CadastroUsuario: IModelDAOUsuario;

    constructor Create; overload;
    constructor Create(pQueryFeature: IModelQueryFeature); overload;

    class function Criar: IControllerCadastros; overload;
    class function Criar(pQueryFeature: IModelQueryFeature): IControllerCadastros; overload;
  end;

implementation

uses
  Model.DAO.Usuario;

{ TControllerCadastros }

function TControllerCadastros.CadastroUsuario: IModelDAOUsuario;
begin
  if not Assigned(FCadastroUsuario) then
  begin
    FCadastroUsuario :=
      TModelDAOUsuario.Criar(FQueryFeature.Query);
  end;

  Result := FCadastroUsuario;
end;

constructor TControllerCadastros.Create;
begin
  FQueryFeature := TModelQueryFeature.Create;
end;

constructor TControllerCadastros.Create(pQueryFeature: IModelQueryFeature);
begin
  FQueryFeature := pQueryFeature;
end;

class function TControllerCadastros.Criar(
  pQueryFeature: IModelQueryFeature): IControllerCadastros;
begin
  Result := Self.Create(pQueryFeature);
end;

class function TControllerCadastros.Criar: IControllerCadastros;
begin
  Result := Self.Create;
end;


end.
