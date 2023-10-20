unit Model.DAO.Usuario;

interface

uses Model.DAO.Interfaces.Usuario;

type
  TModelDAOUsuario = class(TInterfacedObject, IModelDAOUsuario)
  private
    FValorRenda: Double;
    FNome: string;

  public
    function Nome(const pValor: string): IModelDAOUsuario;
    function ValorRenda(const pValor: double): IModelDAOUsuario;

    function Inserir(): IModelDAOUsuario;

  end;

implementation

{ TModelDAOUsuario }

function TModelDAOUsuario.Inserir: IModelDAOUsuario;
begin
  Result := Self;
end;

function TModelDAOUsuario.Nome(const pValor: string): IModelDAOUsuario;
begin
  FNome := pValor;

  Result := Self;
end;

function TModelDAOUsuario.ValorRenda(const pValor: double): IModelDAOUsuario;
begin
  FValorRenda := pValor;

  Result := Self;
end;


end.
