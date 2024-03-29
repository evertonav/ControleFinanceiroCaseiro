unit uFrmConfiguracaoUsuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.ListBox, FMX.Edit, FMX.Controls.Presentation, FMX.Layouts;

type
  TForm2 = class(TForm)
    rtcContainer: TRectangle;
    Layout3: TLayout;
    Layout4: TLayout;
    Label2: TLabel;
    edtValor: TEdit;
    lytContainerBotoesAcao: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Label3: TLabel;
    edtDescricao: TEdit;
    rtcGravar: TRectangle;
    btnSalvar: TSpeedButton;
    lytMenu: TLayout;
    rtcMenu: TRectangle;
    btnUsuario: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

end.
