unit uFrameDevedores;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, uFramePai;

type
  TFrame3 = class(TFramePai)
    rtcContainer: TRectangle;
    Layout7: TLayout;
    Label3: TLabel;
    lblValorSobrando: TLabel;
    lytMesAno: TLayout;
    rtcMesAno: TRectangle;
    lblDevedores: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
