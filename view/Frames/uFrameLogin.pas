unit uFrameLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.Edit, uFramePai;

type
  TFrameLogin = class(TFramePai)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    V: TRectangle;
    Label1: TLabel;
    Layout2: TLayout;
    Layout3: TLayout;
    Label2: TLabel;
    Edit1: TEdit;
    Rectangle3: TRectangle;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
  private
    FExecutarProcedimentoAposLogar: TProc;
    { Private declarations }
  public
    { Public declarations }
    procedure AdicionarParent(const pContainer: TFmxObject); override;
    procedure AdicionarProcedimentoAposLogar(pProcedimento: TProc);
//    property ExecutarProcedimentoAposLogar: TProc read FExecutarProcedimentoAposLogar write FExecutarProcedimentoAposLogar;
  end;

implementation

uses
  Controller.VariaveisGlobais;

{$R *.fmx}

procedure TFrameLogin.AdicionarParent(const pContainer: TFmxObject);
begin
  Layout1.Parent := pContainer;
end;

procedure TFrameLogin.AdicionarProcedimentoAposLogar(pProcedimento: TProc);
begin
  FExecutarProcedimentoAposLogar := pProcedimento;
end;

procedure TFrameLogin.SpeedButton1Click(Sender: TObject);
begin
  TUsuarioLogado.gCodigoUsuario := StrToIntDef(Edit1.Text, 0);

  if Assigned(FExecutarProcedimentoAposLogar) then
    FExecutarProcedimentoAposLogar;

//  Self := nil;
end;

end.
