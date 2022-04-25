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
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Model.Conexao.Feature;

type
  TAcaoCadastro = (acInserir, acAtualizar);

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
    mniAlterar: TMenuItem;
    mniRemover: TMenuItem;
    qrPesquisar: TFDQuery;
    lytContainerBotoesAcao: TLayout;
    btnCancelar: TSpeedButton;
    imgCancelar: TImage;
    btnSalvar: TSpeedButton;
    imgSalvar: TImage;
    bdsPesquisar: TBindSourceDB;
    bdlPesquisar: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    procedure btnCadastroClick(Sender: TObject);
    procedure btnListagemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure mniAlterarClick(Sender: TObject);
  private
    { Private declarations }
    FConexao: IModelConexaoFeature;
  protected
    FAcaoCadastro: TAcaoCadastro;

    procedure AtivarAbaCadastro;
    procedure AtivarAbaListagem;
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

procedure TfrmCadastroPai.AtivarAbaCadastro;
begin
  tbcCadastroDespesas.ActiveTab := tbiCadastro;
end;

procedure TfrmCadastroPai.AtivarAbaListagem;
begin
  tbcCadastroDespesas.ActiveTab := tbiListagem;

  qrPesquisar.Close;
end;

procedure TfrmCadastroPai.btnCadastroClick(Sender: TObject);
begin
  AtivarAbaCadastro;
end;

procedure TfrmCadastroPai.btnCancelarClick(Sender: TObject);
begin
  FAcaoCadastro := acInserir;
end;

procedure TfrmCadastroPai.btnListagemClick(Sender: TObject);
begin
  AtivarAbaListagem;
end;

procedure TfrmCadastroPai.FormCreate(Sender: TObject);
begin
  FConexao := TModelConexaoFeature.Criar;
  FAcaoCadastro := acInserir;
  //Gambiarra para diminuir código estudar live binding
  qrPesquisar.Connection := TFDCustomConnection(FConexao.Conexao);

  AtivarAbaCadastro;
end;

procedure TfrmCadastroPai.mniAlterarClick(Sender: TObject);
begin
  AtivarAbaCadastro;

  FAcaoCadastro := acAtualizar;
end;

end.
