unit Uteis;

interface

uses
  FMX.Types,
  FMX.Edit;

type
  TTipoMensagem = (tpMensagemSucesso, tpMensagemErro);

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

implementation

uses
  System.SysUtils,
  FMX.Forms;

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

end.
