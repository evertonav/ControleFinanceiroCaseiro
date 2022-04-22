unit AdicionarFramesPeriodo;

interface

uses
  FMX.Types,
  System.Classes;

type
  IAdicionarFramePeriodo = interface
    function DataInicial(const pValor: TDate): IAdicionarFramePeriodo;
    function DataFinal(const pValor: TDate): IAdicionarFramePeriodo;
    function Container(const pValor: TFmxObject): IAdicionarFramePeriodo;
    function Executar: TFmxObject;
  end;

  TAdicionarFramePeriodo = class(TInterfacedObject, IAdicionarFramePeriodo)
  strict protected
    FDataInicial: TDate;
    FDataFinal: TDate;
    FContainer: TFmxObject;
  public
    function DataInicial(const pValor: TDate): IAdicionarFramePeriodo;
    function DataFinal(const pValor: TDate): IAdicionarFramePeriodo;
    function Container(const pValor: TFmxObject): IAdicionarFramePeriodo;
    function Executar:  TFmxObject; virtual; abstract;

    class function Criar: IAdicionarFramePeriodo;
  end;

  TAdicionarFrameDespesasXSobrando = class(TAdicionarFramePeriodo)
  public
    function Executar: TFmxObject; override;
  end;

implementation

uses
  uFrameDespesasXSobrando;

{ TAdicionarFramePeriodo }

function TAdicionarFramePeriodo.Container(
  const pValor: TFmxObject): IAdicionarFramePeriodo;
begin
  FContainer := pValor;

  Result := Self;
end;

class function TAdicionarFramePeriodo.Criar: IAdicionarFramePeriodo;
begin
  Result := Self.Create;
end;

function TAdicionarFramePeriodo.DataFinal(
  const pValor: TDate): IAdicionarFramePeriodo;
begin
  FDataFinal := pValor;

  Result := Self;
end;

function TAdicionarFramePeriodo.DataInicial(
  const pValor: TDate): IAdicionarFramePeriodo;
begin
  FDataInicial := pValor;

  Result := Self;
end;

{ TAdicionarFrameDespesasXSobrando }

function TAdicionarFrameDespesasXSobrando.Executar: TFmxObject;
var
  fttDespesasXSobrando: TFrameDespesasXSobrando;
begin
  fttDespesasXSobrando := TFrameDespesasXSobrando.Create(FContainer);

  fttDespesasXSobrando.AdicionarParent(FContainer);
  fttDespesasXSobrando.Name := fttDespesasXSobrando.ClassName + '_';
  fttDespesasXSobrando.DataInicial := FDataInicial;
  fttDespesasXSobrando.DataFinal := FDataFinal;
  fttDespesasXSobrando.Atualizar;

  Result := fttDespesasXSobrando;
end;

end.
