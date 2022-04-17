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

  TAdicionarFrame = Class(TInterfacedObject, IAdicionarFrame)
  strict protected
    FContainer: TFmxObject;
  public
    function Container(const pValor: TFmxObject): IAdicionarFrame;
    function Executar:  TFmxObject;  virtual; abstract;

    class function Criar: IAdicionarFrame;
  End;

  TAdicionarFrameLogin = class(TAdicionarFrame)
  public
    function Executar: TFmxObject; override;
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

  TAdicionarFrameMenuAcessoRapido = class(TAdicionarFrame)
  public
    function Executar:  TFmxObject; override;
  end;

  TAdicionarCadastroDespesas = class(TAdicionarFrame)
  public
    function Executar:  TFmxObject; override;
  end;

  TAdicionarCadastroDevedores = class(TAdicionarFrame)
  public
    function Executar: TFmxObject; override;
  end;


implementation

uses
  uFrameDespesasXSobrando,
  uFrameMenusAcessoRapido,
  uFrmCadastroDespesas,
  Uteis,
  uFrameLogin,
  uFrmCadastroDevedores;

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

  fttDespesasXSobrando.AdicionarParent(FContainer);
  fttDespesasXSobrando.Name := fttDespesasXSobrando.ClassName + '_';
  fttDespesasXSobrando.DataInicial := FDataInicial;
  fttDespesasXSobrando.DataFinal := FDataFinal;
  fttDespesasXSobrando.Atualizar;

  Result := fttDespesasXSobrando;
end;

{ TAdicionarFrameMenuAcessoRapido }

function TAdicionarFrameMenuAcessoRapido.Executar: TFmxObject;
var
  fttMenusAcessoRapido: TFrameMenuAcessoRapido;
begin
  fttMenusAcessoRapido := TFrameMenuAcessoRapido.Create(FContainer);

  fttMenusAcessoRapido.AdicionarParent(FContainer);
  fttMenusAcessoRapido.Name := fttMenusAcessoRapido.ClassName + '_';

  Result := fttMenusAcessoRapido;
end;

{ TAdicionarCadastroDespesas }

function TAdicionarCadastroDespesas.Executar: TFmxObject;
var
  lfrmCadastroDespesas: TfrmCadastroDespesas;
begin
  lfrmCadastroDespesas := TfrmCadastroDespesas.Create(FContainer);

  lfrmCadastroDespesas.AdicionarParent(FContainer);
  lfrmCadastroDespesas.Name := lfrmCadastroDespesas.ClassName + '_';

  Result := lfrmCadastroDespesas;
end;

{ TAdicionarFrame }

function TAdicionarFrame.Container(const pValor: TFmxObject): IAdicionarFrame;
begin
  FContainer := pValor;

  Result := Self;
end;

class function TAdicionarFrame.Criar: IAdicionarFrame;
begin
  Result := Self.Create;
end;

{ TAdicionarFrameLogin }

function TAdicionarFrameLogin.Executar: TFmxObject;
var
  lFrameLogin: TFrame2;
begin
  lFrameLogin := TFrame2.Create(FContainer);

  lFrameLogin.AdicionarParent(FContainer);
  lFrameLogin.Name := lFrameLogin.ClassName + '_';

  Result := lFrameLogin;
end;

{ TAdicionarCadastroDevedores }

function TAdicionarCadastroDevedores.Executar: TFmxObject;
var
  lFrmCadastroDevedores: TfrmCadastroDevedores;
begin
  lFrmCadastroDevedores := TfrmCadastroDevedores.Create(FContainer);

  lFrmCadastroDevedores.AdicionarParent(FContainer);
  lFrmCadastroDevedores.Name := lFrmCadastroDevedores.ClassName + '_';

  Result := lFrmCadastroDevedores;
end;

end.
