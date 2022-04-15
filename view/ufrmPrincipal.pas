unit ufrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects;

type
  TMenu = (mnMenuInterativoOuTotalizados,
           mnAdicaoGastos);

  TfrmPrincipal = class(TForm)
    lytContainerTotal: TLayout;
    lytCabecalho: TLayout;
    lytContainerTelaInteira: TLayout;
    btnMostrarMenuEsquerda: TSpeedButton;
    rtcMenuEsquerda: TRectangle;
    rtcCabecalho: TRectangle;
    lblTituloCabecalho: TLabel;
    lytContainerConfiguracao: TLayout;
    imgConfiguracao: TImage;
    lblConfiguracao: TLabel;
    lytContainerCentroTela: TLayout;
    lytContainerPrincipal: TLayout;
    lblPrincipal: TLabel;
    imgPrincipal: TImage;
    btnPrincipal: TSpeedButton;
    lytContainerAdicionarGastos: TLayout;
    lblAdicionarGastos: TLabel;
    imgAdicionarGastos: TImage;
    btnAdicionarGastos: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPrincipalClick(Sender: TObject);
    procedure btnAdicionarGastosClick(Sender: TObject);
    procedure btnMostrarMenuEsquerdaClick(Sender: TObject);
  private
    { Private declarations }
    FContainerAdicionado: TFmxObject;

    procedure MostrarMenuInterativoOuTotalizador;

    procedure ConfigurarMostrarMenus(const pMenu: TMenu);
  public
    { Public declarations }
    procedure MostrarAdicaoGastos;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  AdicionarFrames,
  Controller.VariaveisGlobais,
  Controller,
  System.DateUtils;

{$R *.fmx}

procedure TfrmPrincipal.btnMostrarMenuEsquerdaClick(Sender: TObject);
begin
  rtcMenuEsquerda.Visible := not rtcMenuEsquerda.Visible;
end;

procedure TfrmPrincipal.ConfigurarMostrarMenus(const pMenu: TMenu);
begin
  if Assigned(FContainerAdicionado) then
    FreeAndNil(FContainerAdicionado);

  lytContainerCentroTela.Visible := pMenu = mnMenuInterativoOuTotalizados;
  lytContainerTelaInteira.Visible := pMenu = mnAdicaoGastos;

  case pMenu of
    mnMenuInterativoOuTotalizados: MostrarMenuInterativoOuTotalizador;
    mnAdicaoGastos: MostrarAdicaoGastos;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  TUsuarioLogado.gCodigoUsuario := 1;
  TUsuarioLogado.gValorRenda := 3500;

  ConfigurarMostrarMenus(mnMenuInterativoOuTotalizados);
end;

procedure TfrmPrincipal.MostrarAdicaoGastos;
begin
  FContainerAdicionado := TAdicionarCadastroDespesas.Criar.Container(lytContainerTelaInteira).Executar;
end;

procedure TfrmPrincipal.MostrarMenuInterativoOuTotalizador;
var
  lDataInicial: TDate;
  lDataFinal: TDate;
begin
  lDataInicial := StartOfTheMonth(Now);
  lDataFinal := EndOfTheMonth(Now);

  if TController
      .Criar
      .DespesasXSobrando
      .IdUsuario(TUsuarioLogado.gCodigoUsuario)
      .DataInicial(lDataInicial)
      .DataFinal(lDataFinal)
      .TotalDespesas > 0 then
  begin
    FContainerAdicionado := TAdicionarFrameDespesasXSobrando
                              .Criar
                              .DataInicial(lDataInicial)
                              .DataFinal(lDataFinal)
                              .Container(lytContainerCentroTela)
                              .Executar
  end
  else
    FContainerAdicionado := TAdicionarFrameMenuAcessoRapido.Criar.Container(lytContainerCentroTela).Executar;
end;

procedure TfrmPrincipal.btnPrincipalClick(Sender: TObject);
begin
  ConfigurarMostrarMenus(mnMenuInterativoOuTotalizados)
end;

procedure TfrmPrincipal.btnAdicionarGastosClick(Sender: TObject);
begin
  ConfigurarMostrarMenus(mnAdicaoGastos)
end;

end.
