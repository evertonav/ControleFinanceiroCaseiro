unit Model.DAO.Copiar;

interface

type
  IModelDAOCopiar = interface
    function DataInicial(const pValor: TDate): IModelDAOCopiar;
    function DataFinal(const pValor: TDate): IModelDAOCopiar;
    function Descricao(const pValor: string): IModelDAOCopiar;
    function IdUsuario(const pValor: integer): IModelDAOCopiar;

    function Validar(const pTotalRegistros: Integer): IModelDAOCopiar;
    function Copiar(const pDataDestino: TDate): IModelDAOCopiar;

  end;

implementation

end.
