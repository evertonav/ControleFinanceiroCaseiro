unit ufrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects,
  System.Generics.Collections, AdicionarFramesPeriodo, uFrameLogin, Uteis;

type
  TMenu = (mnPrincipal,
           mnAdicaoGastos,
           mnLogin,
           mnAdicaoDevedores,
           mnFrameDevedores,
           mnConfiguracoes);

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
    btnConfiguracoes: TSpeedButton;
    lytContainerCadastroDevedores: TLayout;
    rtcAdicionarDevedores: TRectangle;
    Line1: TLine;
    btnAdicionarDevedores: TSpeedButton;
    imgAdicionarDevedores: TImage;
    lblAdicionarDevedores: TLabel;
    lytContainerRestoTela: TLayout;
    rtcSair: TRectangle;
    btnSair: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPrincipalClick(Sender: TObject);
    procedure btnAdicionarDespesasClick(Sender: TObject);
    procedure btnMostrarMenuEsquerdaClick(Sender: TObject);
    procedure btnConfiguracoesClick(Sender: TObject);
    procedure btnAdicionarDevedoresClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    FContainerAdicionado: TFmxObject;

    procedure MostrarDevedores;
    procedure MostrarLogin;
    procedure MostrarAdicaoGastos;
    procedure MostrarAdicaoDevedores;
    procedure MostrarMenuAcessoRapido;
    procedure MostrarConfiguracoes;

    procedure MostrarTelasValores(const pDataInicial: TDateTime;
                                  const pDataFinal: TDateTime);

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
  AdicionarFramesConjunto,
  Controller.VariaveisGlobais,
  Controller,
  System.DateUtils,
  uFrmConfiguracao;

const
  CONST_ALTURA_FORM = 500;
  CONST_LARGURA_FORM = 870;

{$R *.fmx}

procedure TfrmPrincipal.btnMostrarMenuEsquerdaClick(Sender: TObject);
begin
  rtcMenuEsquerda.Visible := not rtcMenuEsquerda.Visible;
end;

procedure TfrmPrincipal.ConfigurarMenuSelecionado(const pMenu: TMenu);
begin
  rtcAdicionarDespesas.Visible := pMenu = mnAdicaoGastos;
  rtcPrincipal.Visible := pMenu = mnPrincipal;
  rtcAdicionarDevedores.Visible := pMenu = mnAdicaoDevedores;
end;

procedure TfrmPrincipal.ConfigurarMostrarMenus(const pMenu: TMenu);
begin
  if Assigned(FContainerAdicionado) then
    FreeAndNil(FContainerAdicionado);

  lytContainerCentroTela.Visible := (pMenu = mnFrameDevedores);

  lytContainerTelaInteira.Visible := (pMenu = mnAdicaoGastos)
                                  or (pMenu = mnAdicaoDevedores);

  lytContainerTelaInteira.Visible := True;

  ConfigurarMenuSelecionado(pMenu);

  case pMenu of
    mnPrincipal:
    begin
      var lDataInicial: TDateTime;
      var lDataFinal: TDateTime;

      lytContainerTelaInteira.Visible := True;

      lDataInicial := StartOfTheMonth(Now);
      lDataFinal := EndOfTheMonth(Now);

      if TController
	    .Criar
	    .DespesasXSobrando
	    .IdUsuario(TUsuarioLogado.gCodigoUsuario)
	    .DataInicial(lDataInicial)
	    .DataFinal(lDataFinal)
	    .TotalDespesas > 0 then

        MostrarTelasValores(lDataInicial, lDataFinal)
      else
      begin
        lytContainerCentroTela.Visible := True;
        MostrarMenuAcessoRapido;
      end;
    end;
    mnAdicaoGastos: MostrarAdicaoGastos;
    mnLogin: MostrarLogin;
    mnAdicaoDevedores: MostrarAdicaoDevedores;
    mnFrameDevedores: MostrarDevedores;
    mnConfiguracoes: MostrarConfiguracoes;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FContainerAdicionado := TAdicionarFrameLogin.Criar.Container(lytContainerTotal).Executar;

  TFrameLogin(FContainerAdicionado).AdicionarProcedimentoAposLogar(procedure ()
                                                                    begin
                                                                      frmPrincipal.ConfigurarMostrarMenus(mnPrincipal);
                                                                    end );



  frmPrincipal.Height := CONST_ALTURA_FORM;
  frmPrincipal.Width := CONST_LARGURA_FORM;
end;

procedure TfrmPrincipal.FormResize(Sender: TObject);
begin
  if frmPrincipal.Height < CONST_ALTURA_FORM then
    frmPrincipal.Height := CONST_ALTURA_FORM;

  if frmPrincipal.Width < CONST_LARGURA_FORM then
    frmPrincipal.Width := CONST_LARGURA_FORM;
end;

procedure TfrmPrincipal.MostrarAdicaoDevedores;
begin
  FContainerAdicionado := TAdicionarCadastroDevedores.Criar.Container(lytContainerTelaInteira).Executar;
end;

procedure TfrmPrincipal.MostrarAdicaoGastos;
begin
   FContainerAdicionado := TAdicionarCadastroDespesas.Criar.Container(lytContainerTelaInteira).Executar;
end;

procedure TfrmPrincipal.MostrarConfiguracoes;
begin
  FContainerAdicionado := TAdicionarTelaConfiguracoes
                             .Criar
                             .Container(lytContainerTelaInteira)
                             .Executar;
end;

procedure TfrmPrincipal.MostrarDevedores;
begin
  FContainerAdicionado := TAdicionarFrameDevedores.Criar.Container(lytContainerCentroTela).Executar;
end;

procedure TfrmPrincipal.MostrarLogin;
begin
  FContainerAdicionado := TAdicionarFrameLogin.Criar.Container(Self).Executar;
end;

procedure TfrmPrincipal.MostrarMenuAcessoRapido;
begin
  FContainerAdicionado := TAdicionarFrameMenuAcessoRapido.Criar.Container(lytContainerCentroTela).Executar;
end;

procedure TfrmPrincipal.MostrarTelasValores(const pDataInicial,
  pDataFinal: TDateTime);
var
  lFrameDespesasXSobrando: TAdicionarFramePeriodo;
  lFrameDevedores: TAdicionarFramePeriodo;
  lFrameDespesasPagas: TAdicionarFramePeriodo;
begin
    lFrameDespesasXSobrando := TAdicionarFrameDespesasXSobrando.Create;
    lFrameDespesasXSobrando.DataInicial(pDataInicial).DataFinal(pDataFinal);

    lFrameDevedores := TAdicionarFrameDevedores.Create;
    lFrameDevedores.DataInicial(pDataInicial).DataFinal(pDataFinal);

    lFrameDespesasPagas := TAdicionarFrameDespesasPagas.Create;
    lFrameDespesasPagas.DataInicial(pDataInicial).DataFinal(pDataFinal);

    FContainerAdicionado := TAdicionarFrameConjunto
                              .Criar
                              .AdicionarTela(lFrameDespesasXSobrando)
                              .AdicionarTela(lFrameDevedores)
                              .AdicionarTela(lFrameDespesasPagas)
                              .Container(lytContainerTelaInteira)
                              .Executar;
end;

procedure TfrmPrincipal.btnConfiguracoesClick(Sender: TObject);
begin
  ConfigurarMostrarMenus(mnConfiguracoes);
end;

procedure TfrmPrincipal.btnPrincipalClick(Sender: TObject);
begin
  ConfigurarMostrarMenus(mnPrincipal);
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
  TMensagemAviso.ForcarTerminoThread();

  Self.Close;
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
