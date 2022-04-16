unit uFrameDespesasXSobrando;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TFrameDespesasXSobrando = class(TFrame)
    lytContainer: TLayout;
    lytMesAno: TLayout;
    rtcMesAno: TRectangle;
    lblMesAno: TLabel;
    rtcContainer: TRectangle;
    Layout7: TLayout;
    Label3: TLabel;
    lblValorSobrando: TLabel;
    Layout6: TLayout;
    lblTotalDespesas: TLabel;
    lblValorDespesas: TLabel;
  private
    FDataInicial: TDate;
    FDataFinal: TDate;
    procedure SetDataFinal(const Value: TDate);
    procedure SetDataInicial(const Value: TDate);

    { Private declarations }
  public
    { Public declarations }
    procedure Atualizar;
    property DataInicial: TDate write SetDataInicial;
    property DataFinal: TDate write SetDataFinal;
  end;

implementation

uses
  Model.DAO.DespesasXSobrando,
  Controller.VariaveisGlobais,
  System.DateUtils;

{$R *.fmx}

{ TFrameDespesasXSobrando }

procedure TFrameDespesasXSobrando.Atualizar;
var
  lTotalDespesas: Double;
begin
  lTotalDespesas := TModelDAODespesasXSobrando
                            .Criar
                            .IdUsuario(TUsuarioLogado.gCodigoUsuario)
                            .DataInicial(FDataInicial)
                            .DataFinal(FDataFinal)
                            .TotalDespesas;

  lblValorDespesas.Text := FormatFloat('0.00', lTotalDespesas);

  lblValorSobrando.Text := FormatFloat('0.00',
                                       TModelDAODespesasXSobrando
                                         .Criar
                                         .IdUsuario(TUsuarioLogado.gCodigoUsuario)
                                         .DataInicial(FDataInicial)
                                         .DataFinal(FDataFinal)
                                         .TotalSobrando(lTotalDespesas));

  lblMesAno.Text := FormatFloat('00', MonthOf(FDataInicial)) + '/' + YearOf(FDataInicial).ToString;
end;

procedure TFrameDespesasXSobrando.SetDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TFrameDespesasXSobrando.SetDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;

end.
