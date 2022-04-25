unit uFrmCadastroDevedores;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uFrmCadastroPai,
  System.Rtti, FMX.Grid.Style, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Menus, FMX.StdCtrls,
  FMX.ScrollBox, FMX.Grid, FMX.TabControl, FMX.Controls.Presentation,
  FMX.Objects, FMX.Layouts, FMX.ListBox, FMX.Edit, FMX.DateTimeCtrls,
  FMX.Effects, FMX.Filter.Effects;

type
  TfrmCadastroDevedores = class(TfrmCadastroPai)
    lytContainerCodigo: TLayout;
    lytCampoCodigo: TLayout;
    lytTituloCodigo: TLayout;
    lblNomePessoaDevedora: TLabel;
    cbxPessoa: TComboBox;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Label1: TLabel;
    edtValorEmprestado: TEdit;
    Layout4: TLayout;
    Layout5: TLayout;
    chkPago: TCheckBox;
    Layout6: TLayout;
    lytCampoData: TLayout;
    lytData: TLayout;
    lblData: TLabel;
    dteDataEmprestou: TDateEdit;
    SpeedButton1: TSpeedButton;
    FillRGBEffect1: TFillRGBEffect;
    lytContainerPesquisar: TLayout;
    edtPesquisa: TEdit;
    lblPesquisar: TLabel;
    btnPesquisar: TSpeedButton;
    Layout7: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    Label2: TLabel;
    edtId: TEdit;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure mniAlterarClick(Sender: TObject);
    procedure mniRemoverClick(Sender: TObject);
  private
    { Private declarations }
    procedure PesquisarDevedores;
    procedure PreencherDadosAbaCadastro(const pId: Integer;
                                        const pDataEmprestou: TDate;
                                        const pValorEmprestou: Double;
                                        const pPago: Boolean);
  public
    { Public declarations }
  end;

var
  frmCadastroDevedores: TfrmCadastroDevedores;

implementation

uses
  Controller,
  Controller.VariaveisGlobais;

{$R *.fmx}

procedure TfrmCadastroDevedores.btnPesquisarClick(Sender: TObject);
begin
  PesquisarDevedores;
end;

procedure TfrmCadastroDevedores.btnSalvarClick(Sender: TObject);
begin
  try
    case FAcaoCadastro of
      acInserir:
      begin
        TController
          .Criar
          .Devedor
          .IdPessoaDevedora(1)
          .ValorEmprestado(StrToFloatDef(edtValorEmprestado.Text, 0))
          .Pago(chkPago.IsChecked.ToInteger)
          .DataEmprestou(dteDataEmprestou.Date)
          .IdUsuario(TUsuarioLogado.gCodigoUsuario)
          .Inserir;
      end;
      acAtualizar:
      begin
        TController
          .Criar
          .Devedor
          .Id(StrToIntDef(edtId.Text, 0))
          .IdPessoaDevedora(1)
          .ValorEmprestado(StrToFloatDef(edtValorEmprestado.Text, 0))
          .Pago(chkPago.IsChecked.ToInteger)
          .DataEmprestou(dteDataEmprestou.Date)
          .IdUsuario(TUsuarioLogado.gCodigoUsuario)
          .Atualizar;
      end;
    end;

    ShowMessage('Devedor salvo com sucesso!');
  except
    on E: Exception do
      ShowMessage(E.Message)
  end;

  FAcaoCadastro := acInserir;
end;

procedure TfrmCadastroDevedores.mniAlterarClick(Sender: TObject);
begin
  PreencherDadosAbaCadastro(qrPesquisar.FieldByName('id').AsInteger,
                            qrPesquisar.FieldByName('DATA_EMPRESTOU').AsDateTime,
                            qrPesquisar.FieldByName('valor_emprestado').AsFloat,
                            Boolean(qrPesquisar.FieldByName('PAGO').AsInteger));

  inherited
end;

procedure TfrmCadastroDevedores.PesquisarDevedores;
CONST CONST_TESTE = 'SELECT * FROM devedores ';
begin
  //Estudar sobre live binding para fazer em poo
  qrPesquisar.SQL.Clear;
  qrPesquisar.SQL.Add(CONST_TESTE);
  {qrPesquisar.SQL.Add('where Upper(Descricao) like ');
  qrPesquisar.SQL.Add('''' + '%' + UpperCase(edtPesquisa.Text.Trim) + '%' + '''');
  qrPesquisar.SQL.Add(' AND id_usuario = ' + TUsuarioLogado.gCodigoUsuario.ToString);}
  qrPesquisar.Open;
end;

procedure TfrmCadastroDevedores.PreencherDadosAbaCadastro(const pId: Integer;
  const pDataEmprestou: TDate; const pValorEmprestou: Double; const pPago: Boolean);
begin
  edtId.Text := pId.ToString;
  dteDataEmprestou.Date := pDataEmprestou;
  edtValorEmprestado.Text := pValorEmprestou.ToString;
  chkPago.IsChecked := pPago;
end;

procedure TfrmCadastroDevedores.mniRemoverClick(Sender: TObject);
begin
  if NOT qrPesquisar.IsEmpty then
  begin
    TController
      .Criar
      .Devedor
      .Id(qrPesquisar.FieldByName('id').AsInteger)
      .Deletar;

    qrPesquisar.Refresh;
  end;
end;

end.
