unit uFrameMensagemAviso;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFramePai, FMX.Controls.Presentation, FMX.Objects, Uteis;

type
  TFrameMensagemAviso = class(TFramePai)
    rtcMensagemAviso: TRectangle;
    lblMensagemAviso: TLabel;
  private
    FTipoMensagem: TTipoMensagem;
    FMensagem: string;
    procedure SetTipoMensagem(const Value: TTipoMensagem);
    procedure SetMensagem(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property Mensagem: string write SetMensagem;
    property TipoMensagem: TTipoMensagem write SetTipoMensagem;
    procedure Atualizar;
  end;

var
  FrameMensagemAviso: TFrameMensagemAviso;

implementation

{$R *.fmx}

{ TFrameMensagemAviso }

procedure TFrameMensagemAviso.Atualizar;
begin
  case FTipoMensagem of
    tpMensagemSucesso: rtcMensagemAviso.Stroke.Color := $FF1EBB49;
    tpMensagemErro: rtcMensagemAviso.Stroke.Color := $FFEC0101;
  end;

  lblMensagemAviso.Text := FMensagem;
end;

procedure TFrameMensagemAviso.SetMensagem(const Value: string);
begin
  FMensagem := Value;
end;

procedure TFrameMensagemAviso.SetTipoMensagem(const Value: TTipoMensagem);
begin
  FTipoMensagem := Value;
end;

end.
