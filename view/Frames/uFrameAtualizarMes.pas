unit uFrameAtualizarMes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, uFramePai,
  System.DateUtils, uFrameDespesasXSobrando, uFrameDespesasPagas,
  uFrameTotalizadorDevedores;

type
  TFrameAtualizarMes = class(TFramePai)
    lytContainer: TLayout;
    rtcContainer: TRectangle;
    lytMesAno: TLayout;
    rtcMesAno: TRectangle;
    lblMesAno: TLabel;
    ltybtnProximo: TLayout;
    lytbtnAnterior: TLayout;
    btnAnterior: TSpeedButton;
    btnProximo: TSpeedButton;
    procedure btnProximoClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
  private
    FDataFiltro: TDate;
    procedure SetDataFiltro(const Value: TDate);

    function GetFrameDespesasXSobrando: TFrameDespesasXSobrando;
    function GetFrameDespesasPagas: TFrameDespesasPagas;
    function GetFrameTotalizadorDevedores: TFrameTotalizadorDevedores;

    procedure AtualizarFramesTelaPrincipal(const pDataInicial: TDate;
                                           const pDataFinal: TDate);
    { Private declarations }
  public
    { Public declarations }
    property DataFiltro: TDate write SetDataFiltro;
    procedure Atualizar;
  end;

implementation

{$R *.fmx}

{ TFrameAtualizarMes }

procedure TFrameAtualizarMes.Atualizar;
begin
  lblMesAno.Text := FormatFloat('00', MonthOf(FDataFiltro))
                  + '/'
                  + YearOf(FDataFiltro).ToString;
end;

procedure TFrameAtualizarMes.AtualizarFramesTelaPrincipal(
  const pDataInicial: TDate; const pDataFinal: TDate);
var
  lFrameDespesasPagas: TFrameDespesasPagas;
  lFrameDespesasXSobrando: TFrameDespesasXSobrando;
  lFrameTotalizadorDevedores: TFrameTotalizadorDevedores;
begin
  lFrameDespesasPagas := GetFrameDespesasPagas();
  lFrameDespesasPagas.Free; //Por enquanto vou limpar, depois ajustar esse frame
                            // para funcionar a atualização.

  lFrameDespesasXSobrando := GetFrameDespesasXSobrando();
  lFrameDespesasXSobrando.DataInicial := pDataInicial;
  lFrameDespesasXSobrando.DataFinal := pDataFinal;
  lFrameDespesasXSobrando.Atualizar();

  lFrameTotalizadorDevedores := GetFrameTotalizadorDevedores();
  lFrameTotalizadorDevedores.DataInicial := pDataInicial;
  lFrameTotalizadorDevedores.DataFinal := pDataFinal;
  lFrameTotalizadorDevedores.Atualizar();

  Self.Atualizar;
end;

function TFrameAtualizarMes.GetFrameDespesasPagas: TFrameDespesasPagas;
var
  lTotalFilhos: Integer;
  lI: Integer;
begin
  Result := nil;
  lTotalFilhos := Pred(Self.Parent.ChildrenCount);

  For lI := lTotalFilhos downto 0 do
  begin
    if (Self.Parent.Children[lI] is TFrameDespesasPagas) then
    begin
      Result := TFrameDespesasPagas(Self.Parent.Children[lI]);
      Break;
    end;
  end;
end;

function TFrameAtualizarMes.GetFrameDespesasXSobrando: TFrameDespesasXSobrando;
var
  lTotalFilhos: Integer;
  lI: Integer;
begin
  Result := nil;
  lTotalFilhos := Pred(Self.Parent.ChildrenCount);

  For lI := lTotalFilhos downto 0 do
  begin
    if (Self.Parent.Children[lI] is TFrameDespesasXSobrando) then
    begin
      Result := TFrameDespesasXSobrando(Self.Parent.Children[lI]);
      Break;
    end;
  end;
end;

function TFrameAtualizarMes.GetFrameTotalizadorDevedores: TFrameTotalizadorDevedores;
var
  lTotalFilhos: Integer;
  lI: Integer;
begin
  Result := nil;
  lTotalFilhos := Pred(Self.Parent.ChildrenCount);

  For lI := lTotalFilhos downto 0 do
  begin
    if (Self.Parent.Children[lI] is TFrameTotalizadorDevedores) then
    begin
      Result := TFrameTotalizadorDevedores(Self.Parent.Children[lI]);
      Break;
    end;
  end;
end;

procedure TFrameAtualizarMes.SetDataFiltro(const Value: TDate);
begin
  FDataFiltro := Value;
end;

procedure TFrameAtualizarMes.btnAnteriorClick(Sender: TObject);
begin
  FDataFiltro := IncMonth(FDataFiltro, -1);
  AtualizarFramesTelaPrincipal(StartOfTheMonth(FDataFiltro),
                               EndOfTheMonth(FDataFiltro));

end;

procedure TFrameAtualizarMes.btnProximoClick(Sender: TObject);
begin
  FDataFiltro := IncMonth(FDataFiltro);
  AtualizarFramesTelaPrincipal(StartOfTheMonth(FDataFiltro),
                               EndOfTheMonth(FDataFiltro));
end;

end.
