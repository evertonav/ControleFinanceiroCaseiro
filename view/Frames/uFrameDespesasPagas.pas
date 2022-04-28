unit uFrameDespesasPagas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFramePai, FMX.Objects, FMX.Layouts, FMX.Controls.Presentation,
  uFrameItemDespesaPaga;

type
  TFrameDespesasPagas = class(TFramePai)
    lytContainer: TLayout;
    rtcContainer: TRectangle;
    lytDespesasPagas: TLayout;
    rtcDespesasPagas: TRectangle;
    lblDespesasPagas: TLabel;
    vsbDespesasPagas: TVertScrollBox;
    rtcTotal: TRectangle;
    lneTotal: TLine;
    lblValorTotal: TLabel;
    Label1: TLabel;
  private
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;
    procedure SetDataFinal(const Value: TDate);
    procedure SetDataInicial(const Value: TDate);
    { Private declarations }

    procedure InserirItensDespesas;
    procedure AtualizarTotalizador;
  public
    { Public declarations }
    property DataInicial: TDate write SetDataInicial;
    property DataFinal: TDate write SetDataFinal;

    procedure Atualizar;
  end;

implementation

uses
  Model.DAO.BuscarDespesas,
  Data.DB,
  Controller,
  Controller.VariaveisGlobais;

{$R *.fmx}

{ TFrameDespesasPagas }

procedure TFrameDespesasPagas.Atualizar;
begin
  InserirItensDespesas;

  AtualizarTotalizador;
end;

procedure TFrameDespesasPagas.AtualizarTotalizador;
begin
  lblValorTotal.Text := FormatFloat('0.00', TController
                                              .Criar
                                              .DespesasXSobrando
                                              .IdUsuario(TUsuarioLogado.gCodigoUsuario)
                                              .DataInicial(FDataInicial)
                                              .DataFinal(FDataFinal)
                                              .Pago(1)
                                              .TotalDespesas);
end;

procedure TFrameDespesasPagas.InserirItensDespesas;
var
  ldtsDespesas: TDataSet;
  lFrameItemDespesa: TFrameItemDespesaPaga;
  lControllerBuscarDespesas: IController;
begin
  lControllerBuscarDespesas := TController.Criar;
  lControllerBuscarDespesas
    .BuscarDespesas(ldtsDespesas)
    .Pago(1)
    .IdUsuario(TUsuarioLogado.gCodigoUsuario)
    .DataInicial(FDataInicial)
    .DataFinal(FDataFinal)
    .Executar;

  ldtsDespesas.First;
  while not ldtsDespesas.Eof do
  begin
    lFrameItemDespesa := TFrameItemDespesaPaga.Create(vsbDespesasPagas);
    lFrameItemDespesa.Parent := vsbDespesasPagas;
    lFrameItemDespesa.Name := lFrameItemDespesa.ClassName + ldtsDespesas.FieldByName('Id').AsString;

    lFrameItemDespesa.Align := TAlignLayout.Top;
    lFrameItemDespesa.Margins.Left := 2;
    lFrameItemDespesa.Margins.Right := 2;
    lFrameItemDespesa.Margins.Bottom := 5;
    lFrameItemDespesa.ID := ldtsDespesas.FieldByName('Id').AsInteger;
    lFrameItemDespesa.Descricao := ldtsDespesas.FieldByName('Descricao').AsString;
    lFrameItemDespesa.Valor := ldtsDespesas.FieldByName('Valor').AsFloat;
    lFrameItemDespesa.Data := ldtsDespesas.FieldByName('Data').AsDateTime;
    lFrameItemDespesa.Atualizar;

    ldtsDespesas.Next;
  end;
end;

procedure TFrameDespesasPagas.SetDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TFrameDespesasPagas.SetDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;

end.
