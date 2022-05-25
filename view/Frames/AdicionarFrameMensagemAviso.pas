unit AdicionarFrameMensagemAviso;

interface

uses
  Uteis,
  FMX.Types;

type
  IAdicionarFrameMensagemAviso = Interface
    function Container(const pValor: TFmxObject): IAdicionarFrameMensagemAviso;
    function Mensagem(const pValor: string): IAdicionarFrameMensagemAviso;
    function TipoMensagem(const pValor: TTipoMensagem): IAdicionarFrameMensagemAviso;
    function Executar:  TFmxObject;
  End;

  TAdicionarFrameMensagemAviso = class(TInterfacedObject, IAdicionarFrameMensagemAviso)
  private
    FTipoMensagem: TTipoMensagem;
    FMensagem: string;
    FContainer: TFmxObject;
  public
    function Container(const pValor: TFmxObject): IAdicionarFrameMensagemAviso;
    function Mensagem(const pValor: string): IAdicionarFrameMensagemAviso;
    function TipoMensagem(const pValor: TTipoMensagem): IAdicionarFrameMensagemAviso;
    function Executar:  TFmxObject;

    class function Criar: IAdicionarFrameMensagemAviso;
  end;

implementation

uses
  uFrameMensagemAviso;

{ TAdicionarFrameMensagemAviso }

function TAdicionarFrameMensagemAviso.Container(
  const pValor: TFmxObject): IAdicionarFrameMensagemAviso;
begin
  FContainer := pValor;

  Result := Self;
end;

class function TAdicionarFrameMensagemAviso.Criar: IAdicionarFrameMensagemAviso;
begin
  Result := Self.Create;
end;

function TAdicionarFrameMensagemAviso.Executar: TFmxObject;
var
  lFrameMensagemAviso: TFrameMensagemAviso;
begin
  lFrameMensagemAviso := TFrameMensagemAviso.Create(FContainer);
  lFrameMensagemAviso.Mensagem := FMensagem;
  lFrameMensagemAviso.TipoMensagem := FTipoMensagem;
  lFrameMensagemAviso.AdicionarParent(FContainer);
  lFrameMensagemAviso.Atualizar;

  Result := lFrameMensagemAviso;
end;

function TAdicionarFrameMensagemAviso.Mensagem(
  const pValor: string): IAdicionarFrameMensagemAviso;
begin
  FMensagem := pValor;

  Result := Self;
end;

function TAdicionarFrameMensagemAviso.TipoMensagem(
  const pValor: TTipoMensagem): IAdicionarFrameMensagemAviso;
begin
  FTipoMensagem := pValor;

  Result := Self;
end;

end.
