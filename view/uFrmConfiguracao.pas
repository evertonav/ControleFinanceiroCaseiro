unit uFrmConfiguracao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.ListBox, FMX.Edit, FMX.Controls.Presentation, FMX.Layouts,
  FMX.TabControl;

type
  TfrmConfiguracao = class(TForm)
    rtcContainer: TRectangle;
    lytValorRenda: TLayout;
    lytlblValorRenda: TLayout;
    lblValorRenda: TLabel;
    edtValorRenda: TEdit;
    lytContainerBotoesAcao: TLayout;
    lytNomeUsuario: TLayout;
    lytlblNomeUsuario: TLayout;
    lblNomeUsuario: TLabel;
    edtNomeUsuario: TEdit;
    rtcGravar: TRectangle;
    btnSalvar: TSpeedButton;
    lytMenu: TLayout;
    rtcMenu: TRectangle;
    btnUsuario: TSpeedButton;
    tbcConfiguracoes: TTabControl;
    tbiUsuario: TTabItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracao: TfrmConfiguracao;

implementation

{$R *.fmx}

end.
