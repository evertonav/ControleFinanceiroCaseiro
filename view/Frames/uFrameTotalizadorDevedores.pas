unit uFrameTotalizadorDevedores;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, uFramePai;

type
  TFrameTotalizadorDevedores = class(TFramePai)
    rtcContainer: TRectangle;
    Layout7: TLayout;
    Label3: TLabel;
    lblValorTotalDevedores: TLabel;
    lytMesAno: TLayout;
    rtcMesAno: TRectangle;
    lblDevedores: TLabel;
  private
    FDataFinal: TDate;
    FDataInicial: TDate;
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
  Model.DAO.BuscarDevedores,
  Controller,
  Controller.VariaveisGlobais;

{$R *.fmx}

{ TFrame3 }

procedure TFrameTotalizadorDevedores.Atualizar;
begin
  lblValorTotalDevedores.Text := FormatFloat('0.00', TController
                                                       .Criar
                                                       .BuscarDevedores
                                                       .DataInicial(FDataInicial)
                                                       .DataFinal(FDataFinal)
                                                       .IdUsuario(TUsuarioLogado.gCodigoUsuario)
                                                       .Total);
end;

procedure TFrameTotalizadorDevedores.SetDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TFrameTotalizadorDevedores.SetDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;

end.
