unit uFrmCadastroPai;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.StdCtrls, FMX.Edit,
  FMX.TabControl, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.Menus,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmCadastroPai = class(TForm)
    lytContainer: TLayout;
    lytMenu: TLayout;
    rtcMenu: TRectangle;
    btnCadastro: TSpeedButton;
    btnListagem: TSpeedButton;
    tbcCadastroDespesas: TTabControl;
    tbiCadastro: TTabItem;
    rtcContainer: TRectangle;
    tbiListagem: TTabItem;
    rtcListagem: TRectangle;
    grdListagemDespesas: TGrid;
    rtcInformacoes: TRectangle;
    lblInformacaoAcoesGrade: TLabel;
    pmnAcoesGrade: TPopupMenu;
    mniAlterarDespesa: TMenuItem;
    mniRemoverGasto: TMenuItem;
    qrPesquisar: TFDQuery;
    qrPesquisarid: TIntegerField;
    qrPesquisardata: TDateField;
    qrPesquisardescricao: TWideStringField;
    qrPesquisarvalor: TBCDField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    lytContainerBotoesAcao: TLayout;
    btnCancelar: TSpeedButton;
    imgCancelar: TImage;
    btnSalvar: TSpeedButton;
    imgSalvar: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AdicionarParent(const pContainer: TFmxObject);
  end;

var
  frmCadastroPai: TfrmCadastroPai;

implementation

{$R *.fmx}

{ TfrmCadastroPai }

procedure TfrmCadastroPai.AdicionarParent(const pContainer: TFmxObject);
begin
  Self.lytContainer.Parent := pContainer;
end;

end.
