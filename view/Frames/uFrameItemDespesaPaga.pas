unit uFrameItemDespesaPaga;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TFrameItemDespesaPaga = class(TFrame)
    rtcDespesaPaga: TRectangle;
    lblDescricaoDespesa: TLabel;
    lblDataDespesa: TLabel;
    lblValorDespesa: TLabel;
  private
    FID: Integer;
    FData: TDate;
    FDescricao: string;
    FValor: Double;

    procedure SetData(const Value: TDate);
    procedure SetDescricao(const Value: string);
    procedure SetID(const Value: Integer);
    procedure SetValor(const Value: Double);
    { Private declarations }
  public
    { Public declarations }
    property ID: Integer read FID write SetID;
    property Data: TDate write SetData;
    property Descricao: string write SetDescricao;
    property Valor: Double write SetValor;

    procedure Atualizar;
  end;

implementation

{$R *.fmx}

{ TFrameItemDespesaPaga }

procedure TFrameItemDespesaPaga.Atualizar;
begin
  lblDataDespesa.Text := DateToStr(FData);
  lblDescricaoDespesa.Text := FDescricao.Trim;
  lblValorDespesa.Text := FormatFloat('0.00', FValor);
end;

procedure TFrameItemDespesaPaga.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TFrameItemDespesaPaga.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TFrameItemDespesaPaga.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TFrameItemDespesaPaga.SetValor(const Value: Double);
begin
  FValor := Value;
end;

end.
