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
    lblCodigo: TLabel;
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
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroDevedores: TfrmCadastroDevedores;

implementation

uses
  Controller;

{$R *.fmx}

procedure TfrmCadastroDevedores.btnSalvarClick(Sender: TObject);
begin
  try
     TController
       .Criar
       .Devedor
       .IdPessoa(cbxPessoa.Tag)
       .ValorEmprestado(StrToFloatDef(edtValorEmprestado.Text, 0))
       .Pago(chkPago.IsChecked.ToInteger)
       .DataEmprestou(dteDataEmprestou.Date)
       .Inserir;

    ShowMessage('Devedor salvo com sucesso!');
  except
    on E: Exception do
      ShowMessage(E.Message)
  end;

end;

end.
