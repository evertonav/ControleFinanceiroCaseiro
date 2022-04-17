unit uFramePai;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls;

type
  TFramePai = class(TFrame)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AdicionarParent(const pContainer: TFmxObject); virtual;
  end;

implementation

{$R *.fmx}

{ TFramePai }

procedure TFramePai.AdicionarParent(const pContainer: TFmxObject);
begin
  Self.Parent := pContainer;
end;

end.
