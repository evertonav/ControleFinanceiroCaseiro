unit ufrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects, System.Generics.Collections;

type
  TMenu = (mnMenuInterativoOuTotalizados,
           mnAdicaoGastos,
           mnLogin,
           mnAdicaoDevedores,
           mnFrameDevedores);

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
    lytContainerAdicionarDespesas: TLayout;
    lblAdicionarDespesas: TLabel;
    imgAdicionarDespesas: TImage;
    btnAdicionarDespesas: TSpeedButton;
    rtcAdicionarDespesas: TRectangle;
    lneAdicionarDespesas: TLine;
    rtcPrincipal: TRectangle;
    lnePrincipal: TLine;
    SpeedButton1: TSpeedButton;
    lytContainerCadastroDevedores: TLayout;
    rtcAdicionarDevedores: TRectangle;
    Line1: TLine;
    btnAdicionarDevedores: TSpeedButton;
    imgAdicionarDevedores: TImage;
    lblAdicionarDevedores: TLabel;
    lytContainerRestoTela: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure btnPrincipalClick(Sender: TObject);
    procedure btnAdicionarDespesasClick(Sender: TObject);
    procedure btnMostrarMenuEsquerdaClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnAdicionarDevedoresClick(Sender: TObject);
  private
    { Private declarations }
    FContainerAdicionado: TFmxObject;

    procedure MostrarMenuInterativoOuTotalizador;
    procedure MostrarDevedores;
    procedure MostrarLogin;
    procedure MostrarAdicaoGastos;
    procedure MostrarAdicaoDevedores;

    procedure ConfigurarMenuSelecionado(const pMenu: TMenu);
  public
    { Public declarations }
    procedure ConfigurarMostrarMenus(const pMenu: TMenu);
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  AdicionarFrames,
  AdicionarFramesPeriodo,
  AdicionarFramesConjunto,
  Controller.VariaveisGlobais,
  Controller,
  System.DateUtils;

{$R *.fmx}

procedure TfrmPrincipal.btnMostrarMenuEsquerdaClick(Sender: TObject);
begin
  rtcMenuEsquerda.Visible := not rtcMenuEsquerda.Visible;
end;

procedure TfrmPrincipal.ConfigurarMenuSelecionado(const pMenu: TMenu);
begin
  rtcAdicionarDespesas.Visible := pMenu = mnAdicaoGastos;
  rtcPrincipal.Visible := pMenu = mnMenuInterativoOuTotalizados;
  rtcAdicionarDevedores.Visible := pMenu = mnAdicaoDevedores;
end;

procedure TfrmPrincipal.ConfigurarMostrarMenus(const pMenu: TMenu);
begin
  if Assigned(FContainerAdicionado) then
    FreeAndNil(FContainerAdicionado);

  lytContainerCentroTela.Visible := (pMenu = mnMenuInterativoOuTotalizados)
                                 or (pMenu = mnFrameDevedores);

  lytContainerTelaInteira.Visible := (pMenu = mnAdicaoGastos)
                                  or (pMenu = mnAdicaoDevedores);

  ConfigurarMenuSelecionado(pMenu);

  case pMenu of
    mnMenuInterativoOuTotalizados: MostrarMenuInterativoOuTotalizador;
    mnAdicaoGastos: MostrarAdicaoGastos;
    mnLogin: MostrarLogin;
    mnAdicaoDevedores: MostrarAdicaoDevedores;
    mnFrameDevedores: MostrarDevedores;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  TUsuarioLogado.gCodigoUsuario := 1;
  TUsuarioLogado.gValorRenda := 3500;

  ConfigurarMostrarMenus(mnMenuInterativoOuTotalizados);
end;

procedure TfrmPrincipal.MostrarAdicaoDevedores;
begin
  FContainerAdicionado := TAdicionarCadastroDevedores.Criar.Container(lytContainerTelaInteira).Executar;
end;

procedure TfrmPrincipal.MostrarAdicaoGastos;
begin
  FContainerAdicionado := TAdicionarCadastroDespesas.Criar.Container(lytContainerTelaInteira).Executar;
end;

procedure TfrmPrincipal.MostrarDevedores;
begin
  FContainerAdicionado := TAdicionarFrameDevedores.Criar.Container(lytContainerCentroTela).Executar;
end;

procedure TfrmPrincipal.MostrarLogin;
begin
  FContainerAdicionado := TAdicionarFrameLogin.Criar.Container(Self).Executar;
end;

procedure TfrmPrincipal.MostrarMenuInterativoOuTotalizador;
var
  lDataInicial: TDate;
  lDataFinal: TDate;
  lFrameDespesasXSobrando: TAdicionarFramePeriodo;
  lFrameDevedores: TAdicionarFramePeriodo;
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
    lFrameDespesasXSobrando := TAdicionarFrameDespesasXSobrando.Create;
    lFrameDespesasXSobrando.DataInicial(lDataInicial).DataFinal(lDataFinal);

    lFrameDevedores := TAdicionarFrameDevedores.Create;
    lFrameDevedores.DataInicial(lDataInicial).DataFinal(lDataFinal);

    FContainerAdicionado := TAdicionarFrameConjunto
                              .Criar
                              .AdicionarTela(lFrameDespesasXSobrando)
                              .AdicionarTela(lFrameDevedores)
                              .Container(lytContainerCentroTela)
                              .Executar;
  end
  else
    FContainerAdicionado := TAdicionarFrameMenuAcessoRapido.Criar.Container(lytContainerCentroTela).Executar;
end;

procedure TfrmPrincipal.SpeedButton1Click(Sender: TObject);
begin
  TAdicionarFrameLogin.Criar.Container(Self).Executar;
end;

procedure TfrmPrincipal.btnPrincipalClick(Sender: TObject);
begin
  ConfigurarMostrarMenus(mnMenuInterativoOuTotalizados);
end;

procedure TfrmPrincipal.btnAdicionarDevedoresClick(Sender: TObject);
begin
  ConfigurarMostrarMenus(mnAdicaoDevedores)
end;

procedure TfrmPrincipal.btnAdicionarDespesasClick(Sender: TObject);
begin
  ConfigurarMostrarMenus(mnAdicaoGastos)
end;

end.
