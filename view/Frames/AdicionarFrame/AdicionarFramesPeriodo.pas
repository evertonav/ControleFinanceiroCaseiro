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

  TAdicionarFrameDevedores = class(TAdicionarFramePeriodo)
  public
    function Executar: TFmxObject; override;
  end;

  TAdicionarFrameDespesasPagas = class(TAdicionarFramePeriodo)
  public
    function Executar: TFmxObject; override;
  end;

implementation

uses
  uFrameDespesasXSobrando,
  uFrameTotalizadorDevedores,
  uFrameDespesasPagas;

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
  lfttDespesasXSobrando: TFrameDespesasXSobrando;
begin
  lfttDespesasXSobrando := TFrameDespesasXSobrando.Create(FContainer);

  lfttDespesasXSobrando.AdicionarParent(FContainer);
  lfttDespesasXSobrando.Name := lfttDespesasXSobrando.ClassName + '_';
  lfttDespesasXSobrando.DataInicial := FDataInicial;
  lfttDespesasXSobrando.DataFinal := FDataFinal;
  lfttDespesasXSobrando.Atualizar;

  Result := lfttDespesasXSobrando;
end;

{ TAdicionarFrameDevedores }

function TAdicionarFrameDevedores.Executar: TFmxObject;
var
  lfttTotalizadorDevedores: TFrameTotalizadorDevedores;
begin
  lfttTotalizadorDevedores := TFrameTotalizadorDevedores.Create(FContainer);

  lfttTotalizadorDevedores.AdicionarParent(FContainer);
  lfttTotalizadorDevedores.Name := lfttTotalizadorDevedores.ClassName + '_';
  lfttTotalizadorDevedores.DataInicial := FDataInicial;
  lfttTotalizadorDevedores.DataFinal := FDataFinal;
  lfttTotalizadorDevedores.Atualizar;

  Result := lfttTotalizadorDevedores;
end;

{ TAdicionarFrameDespesasPagas }

function TAdicionarFrameDespesasPagas.Executar: TFmxObject;
var
  lfttDespesasPagas: TFrameDespesasPagas;
begin
  lfttDespesasPagas := TFrameDespesasPagas.Create(FContainer);

  lfttDespesasPagas.AdicionarParent(FContainer);
  lfttDespesasPagas.Name := lfttDespesasPagas.ClassName + '_';
  lfttDespesasPagas.DataInicial := FDataInicial;
  lfttDespesasPagas.DataFinal := FDataFinal;
  lfttDespesasPagas.Atualizar;

  Result := lfttDespesasPagas;
end;

end.
