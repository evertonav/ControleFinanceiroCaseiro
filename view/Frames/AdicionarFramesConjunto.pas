unit AdicionarFramesConjunto;

interface

uses
  AdicionarFrames,
  AdicionarFramesPeriodo,
  FMX.Types,
  System.Generics.Collections,
  FMX.Layouts,
  System.SysUtils;

type
  IAdicionarFrameConjunto = interface
    function AdicionarTela(pTela: TAdicionarFrame): IAdicionarFrameConjunto; overload;
    function AdicionarTela(pTela: TAdicionarFramePeriodo): IAdicionarFrameConjunto;  overload;
    function Container(const pValor: TFmxObject): IAdicionarFrameConjunto;
    function Executar: TFmxObject;
  end;

  TAdicionarFrameConjunto = class(TInterfacedObject, IAdicionarFrameConjunto)
  private
    FTelasFrame: TObjectList<TAdicionarFrame>;
    FContainer: TFmxObject;
    FTelasFramePeriodo: TObjectList<TAdicionarFramePeriodo>;
  public
    function AdicionarTela(pTela: TAdicionarFrame): IAdicionarFrameConjunto; overload;
    function AdicionarTela(pTela: TAdicionarFramePeriodo): IAdicionarFrameConjunto; overload;
    function Container(const pValor: TFmxObject): IAdicionarFrameConjunto;
    function Executar: TFmxObject;

    constructor Create;
    destructor Destroy; override;
    class function Criar: IAdicionarFrameConjunto;
  end;

implementation

{ TAdicionarFrameConjunto }

function TAdicionarFrameConjunto.AdicionarTela(
  pTela: TAdicionarFrame): IAdicionarFrameConjunto;
begin
  if Assigned(pTela) then
    FTelasFrame.Add(pTela);

  Result := Self;
end;

function TAdicionarFrameConjunto.AdicionarTela(
  pTela: TAdicionarFramePeriodo): IAdicionarFrameConjunto;
begin
  if Assigned(pTela) then
    FTelasFramePeriodo.Add(pTela);

  Result := Self;
end;

function TAdicionarFrameConjunto.Container(
  const pValor: TFmxObject): IAdicionarFrameConjunto;
begin
  FContainer := pValor;

  Result := Self;
end;

constructor TAdicionarFrameConjunto.Create;
begin
  FTelasFrame := TObjectList<TAdicionarFrame>.Create(False);

  FTelasFramePeriodo := TObjectList<TAdicionarFramePeriodo>.Create(False);
end;

class function TAdicionarFrameConjunto.Criar: IAdicionarFrameConjunto;
begin
  Result := Self.Create;
end;

destructor TAdicionarFrameConjunto.Destroy;
begin
  inherited;

  if Assigned(FTelasFrame) then
    FreeAndNil(FTelasFrame);

  if Assigned(FTelasFramePeriodo) then
    FreeAndNil(FTelasFramePeriodo);
end;

function TAdicionarFrameConjunto.Executar: TFmxObject;
var
  lContainerAdicionar: TLayout;
  I:  Integer;
begin
  lContainerAdicionar := TLayout.Create(FContainer);
  lContainerAdicionar.Parent := FContainer;
  lContainerAdicionar.Align := TAlignLayout.Contents;

  for I := 0 to FTelasFrame.Count - 1 do
    FTelasFrame[I].Container(lContainerAdicionar).Executar;

  for I := 0 to FTelasFramePeriodo.Count - 1 do
    FTelasFramePeriodo[I].Container(lContainerAdicionar).Executar;

  Result := lContainerAdicionar;
end;

end.
