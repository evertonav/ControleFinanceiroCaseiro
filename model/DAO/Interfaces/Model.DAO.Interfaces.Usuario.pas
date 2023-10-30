unit Model.DAO.Interfaces.Usuario;

interface

uses
  Entidades.Usuario;

type
  IModelDAOUsuario = interface
    function Id(const pId: Integer): IModelDAOUsuario;
    function Nome(const pValor: string): IModelDAOUsuario;
    function ValorRenda(const pValor: double): IModelDAOUsuario;

    function GetId: Integer;
    function GetNome: string;
    function GetValorRenda: Double;

    function Inserir(): IModelDAOUsuario;
    function Atualizar(): IModelDAOUsuario;
    function Consultar(): IModelDAOUsuario;
  end;

implementation

end.
