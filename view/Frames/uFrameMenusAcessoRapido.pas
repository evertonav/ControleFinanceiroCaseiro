unit uFrameMenusAcessoRapido;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects, uFramePai;

type
  TFrameMenuAcessoRapido = class(TFramePai)
    rtcContainer: TRectangle;
    lytMenuAcessoRapido: TLayout;
    lblMenuAcessoRapido: TLabel;
    lneMenuAcessoRapido: TLine;
    rtcAdicionarDespesas: TRectangle;
    imgAdicionarDespesas: TImage;
    lneAdicionarDespesas: TLine;
    btnAdicionarDespesas: TSpeedButton;
    procedure btnAdicionarDespesasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  uFrmPrincipal;

{$R *.fmx}

procedure TFrameMenuAcessoRapido.btnAdicionarDespesasClick(Sender: TObject);
begin
  FrmPrincipal.ConfigurarMostrarMenus(mnAdicaoGastos);
end;

end.
