unit AdicionarFrames;

interface

uses
  FMX.Types,
  AdicionarFramesPeriodo,
  uFrameAtualizarMes;

type
  IAdicionarFrame = interface
    function Container(const pValor: TFmxObject): IAdicionarFrame;
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

  TAdicionarFrameAtualizarMes = class(TAdicionarFrame)
  private
    FData: TDate;
  public
    function Executar:  TFmxObject; override;

    constructor Create(const pData: TDate);
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
    function Executar:  TFmxObject; override;
  end;

  TAdicionarTelaConfiguracoes = class(TAdicionarFrame)
  public
    function Executar:  TFmxObject; override;
  end;

implementation

uses
  uFrameDespesasXSobrando,
  uFrameMenusAcessoRapido,
  uFrmCadastroDespesas,
  Uteis,
  uFrameLogin,
  uFrmCadastroDevedores, uFrmConfiguracao;

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
  lFrameLogin: TFrameLogin;
begin
  lFrameLogin := TFrameLogin.Create(FContainer);

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

{ TAdicionarTelaConfiguracoes }

function TAdicionarTelaConfiguracoes.Executar: TFmxObject;
var
  lfrmConfiguracoes: TfrmConfiguracao;
begin
  lfrmConfiguracoes := TfrmConfiguracao.Create(FContainer);

  lfrmConfiguracoes.AdicionarParent(FContainer);
  lfrmConfiguracoes.Name := lfrmConfiguracoes.ClassName + '_';

  Result := lfrmConfiguracoes;
end;

{ TAdicionarFrameAtualizarMes }

constructor TAdicionarFrameAtualizarMes.Create(const pData: TDate);
begin
  FData := pData;
end;

function TAdicionarFrameAtualizarMes.Executar: TFmxObject;
var
  lframeAtualizarMes: TFrameAtualizarMes;
begin
  lFrameAtualizarMes := TFrameAtualizarMes.Create(FContainer);

  lFrameAtualizarMes.AdicionarParent(FContainer);
  lFrameAtualizarMes.Name := lFrameAtualizarMes.ClassName + '_';
  lframeAtualizarMes.Data := FData;
  lframeAtualizarMes.Atualizar();

  Result := lFrameAtualizarMes;
end;

end.
