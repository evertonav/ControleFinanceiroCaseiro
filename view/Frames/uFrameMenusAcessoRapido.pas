unit uFrameMenusAcessoRapido;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects;

type
  TFrame1 = class(TFrame)
    Rectangle1: TRectangle;
    rtcAdicionarDespesas: TRectangle;
    Layout1: TLayout;
    Label2: TLabel;
    imgAdicionarDespesas: TImage;
    lneAdicionarDespesas: TLine;
    Line2: TLine;
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

procedure TFrame1.btnAdicionarDespesasClick(Sender: TObject);
begin
  FrmPrincipal.MostrarAdicaoGastos;
end;

end.
