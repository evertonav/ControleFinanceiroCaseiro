unit AdicionarFrames;

interface

uses
  FMX.Types;

type
  IAdicionarFrame = interface
    function Container(const pValor: TFmxObject): IAdicionarFrame;
    function Executar: TFmxObject;
  end;

  IAdicionarFramePeriodo = interface
    function DataInicial(const pValor: TDate): IAdicionarFramePeriodo;
    function DataFinal(const pValor: TDate): IAdicionarFramePeriodo;
    function Container(const pValor: TFmxObject): IAdicionarFramePeriodo;
    function Executar: TFmxObject;
  end;

  TAdicionarFrameDespesasXSobrando = class(TInterfacedObject, IAdicionarFramePeriodo)
  strict private
    FContainer: TFmxObject;
  private
    FDataInicial: TDate;
    FDataFinal: TDate;
  public
    function DataInicial(const pValor: TDate): IAdicionarFramePeriodo;
    function DataFinal(const pValor: TDate): IAdicionarFramePeriodo;
    function Container(const pValor: TFmxObject): IAdicionarFramePeriodo;
    function Executar:  TFmxObject;

    class function Criar: IAdicionarFramePeriodo;
  end;

  TAdicionarFrameMenuAcessoRapido = class(TInterfacedObject, IAdicionarFrame)
  strict private
    FContainer: TFmxObject;
  public
    function Container(const pValor: TFmxObject): IAdicionarFrame;
    function Executar:  TFmxObject;

    class function Criar: IAdicionarFrame;
  end;

  TAdicionarCadastroDespesas = class(TInterfacedObject, IAdicionarFrame)
  strict private
    FContainer: TFmxObject;
  public
    function Container(const pValor: TFmxObject): IAdicionarFrame;
    function Executar:  TFmxObject;

    class function Criar: IAdicionarFrame;
  end;


implementation

uses
  uFrameDespesasXSobrando,
  uFrameMenusAcessoRapido,
  uFrmCadastroDespesas,
  Uteis;

{ TAdicionarFrameDespesasXSobrando }

function TAdicionarFrameDespesasXSobrando.Container(
  const pValor: TFmxObject): IAdicionarFramePeriodo;
begin
  FContainer := pValor;

  Result := Self;
end;

class function TAdicionarFrameDespesasXSobrando.Criar: IAdicionarFramePeriodo;
begin
  Result := Self.Create;
end;

function TAdicionarFrameDespesasXSobrando.DataFinal(
  const pValor: TDate): IAdicionarFramePeriodo;
begin
  FDataFinal := pValor;

  Result := Self;
end;

function TAdicionarFrameDespesasXSobrando.DataInicial(
  const pValor: TDate): IAdicionarFramePeriodo;
begin
  FDataInicial := pValor;

  Result := Self;
end;

function TAdicionarFrameDespesasXSobrando.Executar: TFmxObject;
var
  fttDespesasXSobrando: TFrameDespesasXSobrando;
begin
  fttDespesasXSobrando := TFrameDespesasXSobrando.Create(FContainer);

  fttDespesasXSobrando.Parent := FContainer;
  fttDespesasXSobrando.Name := fttDespesasXSobrando.ClassName + '_';
  fttDespesasXSobrando.DataInicial := FDataInicial;
  fttDespesasXSobrando.DataFinal := FDataFinal;
  fttDespesasXSobrando.Atualizar;

  Result := fttDespesasXSobrando;
end;

{ TAdicionarFrameMenuAcessoRapido }

function TAdicionarFrameMenuAcessoRapido.Container(
  const pValor: TFmxObject): IAdicionarFrame;
begin
  FContainer := pValor;

  Result := Self;
end;

class function TAdicionarFrameMenuAcessoRapido.Criar: IAdicionarFrame;
begin
  Result := Self.Create;
end;

function TAdicionarFrameMenuAcessoRapido.Executar: TFmxObject;
var
  fttMenusAcessoRapido: TFrame1;
begin
  fttMenusAcessoRapido := TFrame1.Create(FContainer);

  fttMenusAcessoRapido.Parent := FContainer;
  fttMenusAcessoRapido.Name := fttMenusAcessoRapido.ClassName + '_';

  Result := fttMenusAcessoRapido;
end;

{ TAdicionarCadastroDespesas }

function TAdicionarCadastroDespesas.Container(
  const pValor: TFmxObject): IAdicionarFrame;
begin
  FContainer := pValor;

  Result := Self;
end;

class function TAdicionarCadastroDespesas.Criar: IAdicionarFrame;
begin
  Result := Self.Create;
end;

function TAdicionarCadastroDespesas.Executar: TFmxObject;
var
  lfrmCadastroDespesas: TfrmCadastroDespesas;
begin
  lfrmCadastroDespesas := TfrmCadastroDespesas.Create(FContainer);

  lfrmCadastroDespesas.AdicionarParent(FContainer);
  lfrmCadastroDespesas.Name := lfrmCadastroDespesas.ClassName + '_';

  Result := lfrmCadastroDespesas;
end;

end.
