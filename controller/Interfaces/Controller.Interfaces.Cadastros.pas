unit Controller.Interfaces.Cadastros;

interface

uses
  Model.DAO.Interfaces.Usuario;

type
  IControllerCadastros = interface
    function CadastroUsuario: IModelDAOUsuario;
  end;

implementation

end.
