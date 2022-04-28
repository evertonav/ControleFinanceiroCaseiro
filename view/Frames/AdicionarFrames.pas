unit AdicionarFrames;

interface

uses
  FMX.Types,
  AdicionarFramesPeriodo;

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

implementation

uses
  uFrameDespesasXSobrando,
  uFrameMenusAcessoRapido,
  uFrmCadastroDespesas,
  Uteis,
  uFrameLogin,
  uFrmCadastroDevedores;

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

end.
