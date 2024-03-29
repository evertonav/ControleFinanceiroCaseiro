unit uFrmCadastroDespesas;

interface

{ 1 -  Ajustar o copiar para quando executar a funcionalidade os registros do m�s
seguinte ficar como n�o pago. }

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
  TTipoPesquisa = (tpDescricao, tpData);

  TfrmCadastroDespesas = class(TfrmCadastroPai)
    lytContainerPesquisar: TLayout;
    edtPesquisar: TEdit;
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
    lytCampoTipoDespesa: TLayout;
    lblTipoDespesa: TLabel;
    cbxTipoDespesa: TComboBox;
    btnTipoDespesa: TSpeedButton;
    lytContainerValor: TLayout;
    lytTituloValor: TLayout;
    lblValor: TLabel;
    edtValor: TEdit;
    cbxPesquisar: TComboBox;
    dteDataInicial: TDateEdit;
    lblDataAte: TLabel;
    dteDataFinal: TDateEdit;
    lytPago: TLayout;
    chkPago: TCheckBox;
    lytAcoes: TLayout;
    rtcCopiarDespesas: TRectangle;
    btnCopiarDespesas: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
    procedure btnListagemClick(Sender: TObject);
    procedure mniAlterarClick(Sender: TObject);
    procedure mniRemoverClick(Sender: TObject);
    procedure cbxPesquisarChange(Sender: TObject);
    procedure edtValorKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnCopiarDespesasClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    procedure PreencherDadosAbaCadastro(const pId: Integer;
                                        const pData: TDate;
                                        const pValor: Double;
                                        const pDescricao: string;
                                        const pPago: SmallInt);

    procedure LimparCadastro;
    procedure PesquisarDespesas(const pTipoPesquisa: TTipoPesquisa);

    procedure AtivarAbaCadastro;

    procedure ConfigurarPesquisa(const pTipoPesquisa: TTipoPesquisa);
  public
    { Public declarations }
    procedure AdicionarParent(const pContainer: TFmxObject);
  end;

var
  frmCadastroDespesas: TfrmCadastroDespesas;

implementation

USES
  Controller.VariaveisGlobais,
  System.DateUtils,
  Uteis;

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
  inherited;

  LimparCadastro;
end;

procedure TfrmCadastroDespesas.btnCopiarDespesasClick(Sender: TObject);
begin
  try
    TController.Criar
      .CopiarDespesas()
      //.Descricao(UpperCase(edtPesquisar.Text.Trim))
      .DataInicial(dteDataInicial.Date)
      .DataFinal(dteDataFinal.Date)
      .IdUsuario(TUsuarioLogado.gCodigoUsuario)
      .Validar(qrPesquisar.RecordCount)
      .Copiar(IncMonth(dteDataInicial.Date));

    Self.AdicionarMensagemAviso(TTipoMensagem.tpMensagemSucesso,
                                'Despesa copiada com sucesso!',
                                tbiListagem);
  except
    on E: Exception do
    begin
      Self.AdicionarMensagemAviso(TTipoMensagem.tpMensagemErro,
                                  e.Message,
                                  tbiListagem);
    end;
  end;

end;

procedure TfrmCadastroDespesas.btnListagemClick(Sender: TObject);
begin
  tbcCadastroDespesas.ActiveTab := tbiListagem;

  ConfigurarPesquisa(tpData);
  PesquisarDespesas(tpData);
end;

procedure TfrmCadastroDespesas.btnPesquisarClick(Sender: TObject);
begin
  PesquisarDespesas(TTipoPesquisa(cbxPesquisar.ItemIndex));
end;

procedure TfrmCadastroDespesas.btnSalvarClick(Sender: TObject);
begin
  try
    case FAcaoCadastro of
      acInserir:
      begin
         TController
           .Criar
           .Despesas
           .IdUsuario(TUsuarioLogado.gCodigoUsuario)
           .Data(dteData.Date)
           .Descricao(edtDescricao.Text)
           .Valor(StrToFloatDef(edtValor.Text, 0))
           .Pago(SmallInt(chkPago.IsChecked))
           .Inserir;
      end;
      acAtualizar:
      begin
        TController
          .Criar
          .Despesas
          .Id(edtCodigo.Text.ToInteger)
          .IdUsuario(TUsuarioLogado.gCodigoUsuario)
          .Data(dteData.Date)
          .Descricao(edtDescricao.Text)
          .Valor(StrToFloatDef(edtValor.Text, 0))
          .Pago(SmallInt(chkPago.IsChecked))
          .Atualizar;
      end;
    end;

    LimparCadastro;

    Self.AdicionarMensagemAviso(TTipoMensagem.tpMensagemSucesso,
                                'Despesa salva com sucesso!');
  except
    on E: Exception do
      Self.AdicionarMensagemAviso(TTipoMensagem.tpMensagemErro, e.Message);
  end;

  FAcaoCadastro := acInserir;
end;

procedure TfrmCadastroDespesas.cbxPesquisarChange(Sender: TObject);
begin
  ConfigurarPesquisa(TTipoPesquisa(cbxPesquisar.ItemIndex));
end;

procedure TfrmCadastroDespesas.ConfigurarPesquisa(
  const pTipoPesquisa: TTipoPesquisa);
begin
  edtPesquisar.Visible := pTipoPesquisa = tpDescricao;

  dteDataInicial.Visible := pTipoPesquisa = tpData;
  dteDataFinal.Visible := pTipoPesquisa = tpData;
  lblDataAte.Visible := pTipoPesquisa = tpData;
end;

procedure TfrmCadastroDespesas.edtValorKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  TMask.MaskFloat(TEdit(Sender), '#0.00');
end;

procedure TfrmCadastroDespesas.FormCreate(Sender: TObject);
begin
  inherited;

  dteDataInicial.Date := StartOfTheMonth(Now);
  dteDataFinal.Date := EndOfTheMonth(Now);
  dteData.Date := Now;
end;

procedure TfrmCadastroDespesas.LimparCadastro;
begin
  dteData.Date := Now;
  edtValor.Text := EmptyStr;
  edtDescricao.Text := EmptyStr;
  chkPago.IsChecked := False;
end;

procedure TfrmCadastroDespesas.mniAlterarClick(Sender: TObject);
begin
  if not qrPesquisar.IsEmpty then
  begin
    PreencherDadosAbaCadastro(qrPesquisar.FieldByName('id').AsInteger,
                              qrPesquisar.FieldByName('data').AsDateTime,
                              qrPesquisar.FieldByName('valor').AsFloat,
                              qrPesquisar.FieldByName('descricao').AsString,
                              TParseCampo.TratarCampoPago(qrPesquisar.FieldByName('pago').AsString));

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
      .Despesas
      .Id(qrPesquisar.FieldByName('ID').AsInteger)
      .Deletar;

    qrPesquisar.Refresh;
  end;
end;

procedure TfrmCadastroDespesas.PesquisarDespesas(const pTipoPesquisa: TTipoPesquisa);
CONST CONST_TESTE = 'SELECT '
                  + '  id, '
                  + '  data, '
                  + '  descricao, '
                  + '  valor, '
                  + '  Case '
                  + '    when pago = 1 then ' + '''' + 'Sim' + ''''
                  + '    else ' + '''' + 'N�o' + ''''
                  + '  End as pago '
                  + ' FROM gasto ';
begin
  //Estudar sobre live binding para fazer em poo
  qrPesquisar.SQL.Clear;
  qrPesquisar.SQL.Add(CONST_TESTE);

  case pTipoPesquisa of
    tpDescricao:
    begin
      qrPesquisar.SQL.Add('where Upper(Descricao) like ');
      qrPesquisar.SQL.Add('''' + '%' + UpperCase(edtPesquisar.Text.Trim) + '%' + '''');
    end;
    tpData:
    begin
      qrPesquisar.SQL.Add('where data between ');
      qrPesquisar.SQL.Add('''' + DateToStr(dteDataInicial.Date)  + '''');
      qrPesquisar.SQL.Add(' AND ' + '''' + DateToStr(dteDataFinal.Date)  + '''');
    end;
  end;

  qrPesquisar.SQL.Add(' AND id_usuario = ' + TUsuarioLogado.gCodigoUsuario.ToString);
  qrPesquisar.Open;

  qrPesquisar.FieldByName('id').DisplayLabel := 'Id';
  qrPesquisar.FieldByName('data').DisplayLabel := 'Data';
  qrPesquisar.FieldByName('descricao').DisplayLabel := 'Descri��o';
  qrPesquisar.FieldByName('valor').DisplayLabel := 'Valor';
  qrPesquisar.FieldByName('pago').DisplayLabel := 'Pago';
end;

procedure TfrmCadastroDespesas.PreencherDadosAbaCadastro(const pId: Integer;
  const pData: TDate; const pValor: Double; const pDescricao: string;
  const pPago: SmallInt);
begin
  edtCodigo.Text := pId.ToString;
  dteData.Date := pData;
  edtValor.Text := FormatFloat('#0.00', pValor);
  edtDescricao.Text := pDescricao;
  chkPago.IsChecked := Boolean(pPago);
end;

end.
