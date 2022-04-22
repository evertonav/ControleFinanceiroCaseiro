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
  Controller, Model.Conexao.Feature, uFrmCadastroPai;

type
  TAcaoCadastro = (acInserir, acAtualizar);

  TfrmCadastroDespesas = class(TfrmCadastroPai)
    lytContainerPesquisar: TLayout;
    edtPesquisa: TEdit;
    lblPesquisar: TLabel;
    btnPesquisar: TSpeedButton;
    lytContainerCodigo: TLayout;
    lytCampoCodigo: TLayout;
    lytTituloCodigo: TLayout;
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    lytContainerData: TLayout;
    lytCampoData: TLayout;
    lytData: TLayout;
    lblData: TLabel;
    dteData: TDateEdit;
    lytContainerDescricao: TLayout;
    lytTituloDescricao: TLayout;
    lblDescricao: TLabel;
    edtDescricao: TEdit;
    lytContainerTipoDespesas: TLayout;
    lytCampoTipoGasto: TLayout;
    lblTipoGasto: TLabel;
    ComboBox1: TComboBox;
    SpeedButton1: TSpeedButton;
    lytContainerValor: TLayout;
    lytTituloValor: TLayout;
    lblValor: TLabel;
    edtValor: TEdit;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
    procedure btnListagemClick(Sender: TObject);
    procedure mniAlterarClick(Sender: TObject);
    procedure mniRemoverClick(Sender: TObject);
  private
    { Private declarations }
    FAcaoCadastro: TAcaoCadastro;

    procedure PreencherDadosAbaCadastro(const pId: Integer;
                                        const pData: TDate;
                                        const pValor: Double;
                                        const pDescricao: string);

    procedure LimparCadastro;
    procedure PesquisarDespesas;

    procedure AtivarAbaCadastro;

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

procedure TfrmCadastroDespesas.AtivarAbaCadastro;
begin
  tbcCadastroDespesas.ActiveTab := tbiCadastro;
end;

procedure TfrmCadastroDespesas.btnCadastroClick(Sender: TObject);
begin
  AtivarAbaCadastro;
end;

procedure TfrmCadastroDespesas.btnCancelarClick(Sender: TObject);
begin
  LimparCadastro;

  FAcaoCadastro := acInserir;
end;

procedure TfrmCadastroDespesas.btnListagemClick(Sender: TObject);
begin
  tbcCadastroDespesas.ActiveTab := tbiListagem;

  qrPesquisar.close;
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
  inherited;

  FAcaoCadastro := acInserir;

  AtivarAbaCadastro;
end;

procedure TfrmCadastroDespesas.LimparCadastro;
begin
  dteData.Date := Now;
  edtValor.Text := EmptyStr;
  edtDescricao.Text := EmptyStr;
end;

procedure TfrmCadastroDespesas.mniAlterarClick(Sender: TObject);
begin
  if not qrPesquisar.IsEmpty then
  begin
    PreencherDadosAbaCadastro(qrPesquisar.FieldByName('id').AsInteger,
                              qrPesquisar.FieldByName('data').AsDateTime,
                              qrPesquisar.FieldByName('valor').AsFloat,
                              qrPesquisar.FieldByName('descricao').AsString);

    FAcaoCadastro := acAtualizar;

    tbcCadastroDespesas.ActiveTab := tbiCadastro;
  end;
end;

procedure TfrmCadastroDespesas.mniRemoverClick(Sender: TObject);
begin
  if not qrPesquisar.IsEmpty then
  begin
    TController
      .Criar
      .Gasto
      .Id(qrPesquisar.FieldByName('ID').AsInteger)
      .Deletar;

    qrPesquisar.Refresh;
  end;
end;

procedure TfrmCadastroDespesas.PesquisarDespesas;
CONST CONST_TESTE = 'SELECT id, data, descricao, valor FROM gasto ';
begin
  //Estudar sobre live binding para fazer em poo
  qrPesquisar.SQL.Clear;
  qrPesquisar.SQL.Add(CONST_TESTE);
  qrPesquisar.SQL.Add('where Upper(Descricao) like ');
  qrPesquisar.SQL.Add('''' + '%' + UpperCase(edtPesquisa.Text.Trim) + '%' + '''');
  qrPesquisar.SQL.Add(' AND id_usuario = ' + TUsuarioLogado.gCodigoUsuario.ToString);
  qrPesquisar.Open;
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
