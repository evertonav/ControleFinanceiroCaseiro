unit Model.DAO.Interfaces.Usuario;

interface

type
  IModelDAOUsuario = interface
    function Nome(const pValor: string): IModelDAOUsuario;
    function ValorRenda(const pValor: double): IModelDAOUsuario;

    function Inserir(): IModelDAOUsuario;

  end;

implementation

end.
