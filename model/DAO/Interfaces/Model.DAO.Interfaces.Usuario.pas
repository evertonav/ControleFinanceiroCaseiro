unit Model.DAO.Interfaces.Usuario;

interface

uses
  Entidades.Usuario;

type
  IModelDAOUsuario = interface
    function Id(const pId: Integer): IModelDAOUsuario;
    function Nome(const pValor: string): IModelDAOUsuario;
    function ValorRenda(const pValor: double): IModelDAOUsuario;

    function Inserir(): IModelDAOUsuario;
    function Atualizar(): IModelDAOUsuario;
    function Consultar(): TUsuario;
  end;

implementation

end.
