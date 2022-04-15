unit Uteis;

interface

uses
  FMX.Types;

type
  TAdicionarFrame = class
  public
    class procedure AdicionarFrame(var pObjetoCriar: TFmxObject;
                                   const pContainer: TFmxObject;
                                   const pNomeObjetoCriado: string);
  end;

implementation

{ TAdicionarFrame }

class procedure TAdicionarFrame.AdicionarFrame(var pObjetoCriar: TFmxObject;
  const pContainer: TFmxObject; const pNomeObjetoCriado: string);
begin
  //pObjetoCriar := TFmxObject.Create(pContainer);

  pObjetoCriar.Parent := pContainer;
  pObjetoCriar.Name := pNomeObjetoCriado;
end;

end.
