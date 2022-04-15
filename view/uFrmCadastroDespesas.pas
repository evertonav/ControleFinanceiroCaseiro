unit uFrmCadastroDespesas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.DateTimeCtrls,
  FMX.Edit, FMX.ListBox, FMX.TabControl, System.Rtti, FMX.Grid.Style,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FMX.ScrollBox, FMX.Grid,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, FMX.Menus,
  Controller, Model.Conexao.Feature;

type
  TAcaoCadastro = (acInserir, acAtualizar);

  TfrmCadastroDespesas = class(TForm)
    qrPesquisarDespesas: TFDQuery;
    qrPesquisarDespesasdata: TDateField;
    qrPesquisarDespesasdescricao: TWideStringField;
    qrPesquisarDespesasvalor: TBCDField;
    BindSourceDB1: TBindSourceDB;
    pmnAcoesGrade: TPopupMenu;
    mniRemoverGasto: TMenuItem;
    qrPesquisarDespesasid: TIntegerField;
    tbcCadastroDespesas: TTabControl;
    tbiCadastro: TTabItem;
    rtcContainer: TRectangle;
    lytContainerData: TLayout;
    lytCampoData: TLayout;
    lytData: TLayout;
    lblData: TLabel;
    dteData: TDateEdit;
    lytContainerValor: TLayout;
    lytTituloValor: TLayout;
    lblValor: TLabel;
    edtValor: TEdit;
    lytContainerTipoDespesas: TLayout;
    lytCampoTipoGasto: TLayout;
    lblTipoGasto: TLabel;
    ComboBox1: TComboBox;
    SpeedButton1: TSpeedButton;
    lytContainerBotoesAcao: TLayout;
    btnCancelar: TSpeedButton;
    imgCancelar: TImage;
    btnSalvar: TSpeedButton;
    imgSalvar: TImage;
    lytContainerDescricao: TLayout;
    lytTituloDescricao: TLayout;
    lblDescricao: TLabel;
    edtDescricao: TEdit;
    tbiListagem: TTabItem;
    rtcListagem: TRectangle;
    lytContainerPesquisar: TLayout;
    edtPesquisa: TEdit;
    lblPesquisar: TLabel;
    btnPesquisar: TSpeedButton;
    grdListagemDespesas: TGrid;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    mniAlterarDespesa: TMenuItem;
    lytContainerCodigo: TLayout;
    lytCampoCodigo: TLayout;
    lytTituloCodigo: TLayout;
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    lytMenu: TLayout;
    btnCadastro: TSpeedButton;
    btnListagem: TSpeedButton;
    rtcMenu: TRectangle;
    lytContainer: TLayout;
    procedure btnSalvarClick(Sender: TObject);
    procedure mniRemoverGastoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mniAlterarDespesaClick(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
    procedure btnListagemClick(Sender: TObject);
  private
    { Private declarations }
    FConexao: IModelConexaoFeature;
    FAcaoCadastro: TAcaoCadastro;

    procedure PreencherDadosAbaCadastro(const pId: Integer;
                                        const pData: TDate;
                                        const pValor: Double;
                                        const pDescricao: string);

    procedure LimparCadastro;
    procedure PesquisarDespesas;

  public
    { Public declarations }
    procedure AdicionarParent(const pContainer: TFmxObject);
  end;

var
  frmCadastroDespesas: TfrmCadastroDespesas;

implementation

USES
  Controller.VariaveisGlobais;

{$R *.fmx}

procedure TfrmCadastroDespesas.AdicionarParent(const pContainer: TFmxObject);
begin
  lytContainer.Parent := pContainer;
end;

procedure TfrmCadastroDespesas.btnCadastroClick(Sender: TObject);
begin
  tbcCadastroDespesas.ActiveTab := tbiCadastro;
end;

procedure TfrmCadastroDespesas.btnCancelarClick(Sender: TObject);
begin
  LimparCadastro;

  FAcaoCadastro := acInserir;
end;

procedure TfrmCadastroDespesas.btnListagemClick(Sender: TObject);
begin
  tbcCadastroDespesas.ActiveTab := tbiListagem;
end;

procedure TfrmCadastroDespesas.btnPesquisarClick(Sender: TObject);
begin
  PesquisarDespesas;
end;

procedure TfrmCadastroDespesas.btnSalvarClick(Sender: TObject);
begin
  try
    case FAcaoCadastro of
      acInserir:
      begin
         TController
           .Criar
           .Gasto
           .IdUsuario(TUsuarioLogado.gCodigoUsuario)
           .Data(dteData.Date)
           .Descricao(edtDescricao.Text)
           .Valor(StrToFloatDef(edtValor.Text, 0))
           .Inserir;
      end;
      acAtualizar:
      begin
        TController
          .Criar
          .Gasto
          .Id(edtCodigo.Text.ToInteger)
          .IdUsuario(TUsuarioLogado.gCodigoUsuario)
          .Data(dteData.Date)
          .Descricao(edtDescricao.Text)
          .Valor(StrToFloatDef(edtValor.Text, 0))
          .Atualizar;
      end;
    end;

    LimparCadastro;

    ShowMessage('Despesa salva com sucesso!');
  except
    on E: Exception do
      ShowMessage(E.Message)
  end;

  FAcaoCadastro := acInserir;
end;

procedure TfrmCadastroDespesas.FormCreate(Sender: TObject);
begin
  FAcaoCadastro := acInserir;
  FConexao := TModelConexaoFeature.Criar;
  //Gambiarra para diminuir código estudar live binding
  qrPesquisarDespesas.Connection := TFDCustomConnection(FConexao.Conexao);
end;

procedure TfrmCadastroDespesas.LimparCadastro;
begin
  dteData.Date := Now;
  edtValor.Text := EmptyStr;
  edtDescricao.Text := EmptyStr;
end;

procedure TfrmCadastroDespesas.mniAlterarDespesaClick(Sender: TObject);
begin
  PreencherDadosAbaCadastro(qrPesquisarDespesasid.AsInteger,
                            qrPesquisarDespesasdata.AsDateTime,
                            qrPesquisarDespesasvalor.AsFloat,
                            qrPesquisarDespesasdescricao.AsString);

  FAcaoCadastro := acAtualizar;

  tbcCadastroDespesas.ActiveTab := tbiCadastro;
end;

procedure TfrmCadastroDespesas.mniRemoverGastoClick(Sender: TObject);
begin
  TController
    .Criar
    .Gasto
    .Id(qrPesquisarDespesas.FieldByName('ID').AsInteger)
    .Deletar;
end;

procedure TfrmCadastroDespesas.PesquisarDespesas;
CONST CONST_TESTE = 'SELECT * FROM gasto ';
begin
  //Estudar sobre live binding para fazer em poo
  qrPesquisarDespesas.SQL.Clear;
  qrPesquisarDespesas.SQL.Add(CONST_TESTE);
  qrPesquisarDespesas.SQL.Add('where Upper(Descricao) like ');
  qrPesquisarDespesas.SQL.Add('''' + '%' + UpperCase(edtPesquisa.Text.Trim) + '%' + '''');
  qrPesquisarDespesas.SQL.Add(' AND id_usuario = ' + TUsuarioLogado.gCodigoUsuario.ToString);
  qrPesquisarDespesas.Open;
end;

procedure TfrmCadastroDespesas.PreencherDadosAbaCadastro(const pId: Integer;
  const pData: TDate; const pValor: Double; const pDescricao: string);
begin
  edtCodigo.Text := pId.ToString;
  dteData.Date := pData;
  edtValor.Text := FormatFloat('##.##', pValor);
  edtDescricao.Text := pDescricao;
end;

end.
