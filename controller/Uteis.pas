unit Uteis;

interface

uses
  FMX.Types,
  FMX.Edit,
  System.Classes;

type
  TTipoMensagem = (tpMensagemSucesso, tpMensagemErro);

  TParseCampo = class
  private

  public
    class function TratarCampoPago(const pPago: string): Integer;
  end;

  TAdicionarFrame = class
  public
    class procedure AdicionarFrame(var pObjetoCriar: TFmxObject;
                                   const pContainer: TFmxObject;
                                   const pNomeObjetoCriado: string);
  end;

  TMask = class
  public
    class procedure MaskFloat(const pEdit: TEdit;
                              const pMask: string);
  end;

  TMensagemAviso = class
    private
      class var FThread: TThread;
    public
      class procedure ForcarTerminoThread();

      class procedure AdicionarMensagem(const pTipoMensagem: TTipoMensagem;
                                        const pMensagem: string;
                                        const pContainer: TFmxObject);

      destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils,
  FMX.Forms,
  AdicionarFrameMensagemAviso;

{ TAdicionarFrame }

class procedure TAdicionarFrame.AdicionarFrame(var pObjetoCriar: TFmxObject;
  const pContainer: TFmxObject; const pNomeObjetoCriado: string);
begin
  //pObjetoCriar := TFmxObject.Create(pContainer);

  pObjetoCriar.Parent := pContainer;
  pObjetoCriar.Name := pNomeObjetoCriado;
end;

{ TMask }

class procedure TMask.MaskFloat(const pEdit: TEdit; const pMask: string);
var
  lStrAux: string;
  lFloatAux: Single;
begin
  lStrAux := pEdit.Text;

  if lStrAux.IsEmpty then
    lStrAux := '0,00';

  lStrAux := lStrAux.Replace('.','', [rfReplaceAll]);
  lStrAux := lStrAux.Replace(',','', [rfReplaceAll]);

  lFloatAux := StrToFloatDef(lStrAux, 0)/100;

  TEdit(pEdit).Text := FormatFloat(pMask, lFloatAux);
  TEdit(pEdit).GoToTextEnd;
end;

{ TParseCampo }

class function TParseCampo.TratarCampoPago(const pPago: string): Integer;
begin
  if UpperCase(pPago) = 'SIM' then
    Result := 1
  else
    Result := 0;
end;

{ TMensagemAviso }

class procedure TMensagemAviso.AdicionarMensagem(
  const pTipoMensagem: TTipoMensagem; const pMensagem: string;
  const pContainer: TFmxObject);
begin
  Self.FThread := TThread.CreateAnonymousThread(
                      procedure ()
                      var
                        lObjetoFrameMensagem: TFmxObject;
                        I: Integer;
                      begin
                        TThread.Synchronize(
                          TThread.CurrentThread,
                          PROCEDURE ()
                          BEGIN
                            lObjetoFrameMensagem := TAdicionarFrameMensagemAviso
                                                      .Criar
                                                      .Mensagem(pMensagem)
                                                      .TipoMensagem(pTipoMensagem)
                                                      .Container(pContainer)
                                                      .Executar;
                          END
                        );

                        for I := 0 to 100 do
                        begin
                          if TThread.CheckTerminated then
                          begin
                            Break
                          end
                          else
                            Sleep(2);
                        end;


                        lObjetoFrameMensagem.Free;
                      end
                    );

  Self.FThread.Start;
  Self.FThread.FreeOnTerminate := False;
end;

destructor TMensagemAviso.Destroy;
begin

  inherited;
end;

class procedure TMensagemAviso.ForcarTerminoThread;
begin
  if Assigned(Self.FThread)
  and (Self.FThread <> nil) then
  begin
    if not Self.FThread.Finished then
      Self.FThread.Terminate();

    Sleep(100);

    Self.FThread.FreeInstance;
    Self.FThread := nil;
  end;
end;

end.
