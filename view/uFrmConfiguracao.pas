unit uFrmConfiguracao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.ListBox, FMX.Edit, FMX.Controls.Presentation, FMX.Layouts,
  FMX.TabControl, Model.DAO.Interfaces.Usuario, Entidades.Usuario,
  Controller.Cadastros, Controller.Interfaces.Cadastros, Model.Query.Feature;

type
  TfrmConfiguracao = class(TForm)
    rtcContainer: TRectangle;
    lytValorRenda: TLayout;
    lytlblValorRenda: TLayout;
    lblValorRenda: TLabel;
    edtValorRenda: TEdit;
    lytContainerBotoesAcao: TLayout;
    lytNomeUsuario: TLayout;
    lytlblNomeUsuario: TLayout;
    lblNomeUsuario: TLabel;
    edtNomeUsuario: TEdit;
    rtcGravar: TRectangle;
    btnSalvar: TSpeedButton;
    lytMenu: TLayout;
    rtcMenu: TRectangle;
    btnUsuario: TSpeedButton;
    tbcConfiguracoes: TTabControl;
    tbiUsuario: TTabItem;
    lytContainer: TLayout;
    rtcTrocarUsuario: TRectangle;
    btnTrocarUsuario: TSpeedButton;
    procedure btnSalvarClick(Sender: TObject);
    procedure edtValorRendaKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnTrocarUsuarioClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FCadastroUsuario: IModelDAOUsuario;
    FQueryFeature: IModelQueryFeature;

    procedure CarregarUsuairo();
    procedure InserirAtualizarUsuario();
  public
    { Public declarations }
    procedure AdicionarParent(pContainer: TFmxObject);
  end;

var
  frmConfiguracao: TfrmConfiguracao;

implementation

uses
  Model.DAO.Usuario, Uteis,
  Controller.VariaveisGlobais, AdicionarFrames, uFrameLogin,
  ufrmPrincipal;

{$R *.fmx}

procedure TfrmConfiguracao.AdicionarParent(pContainer: TFmxObject);
begin
  Self.lytContainer.Parent := pContainer;
end;

procedure TfrmConfiguracao.btnSalvarClick(Sender: TObject);
begin
  try
    btnSalvar.Enabled := False;

    InserirAtualizarUsuario();
  finally
    btnSalvar.Enabled := True;
  end;
end;

procedure TfrmConfiguracao.btnTrocarUsuarioClick(Sender: TObject);
begin
  TFrameLogin(TAdicionarFrameLogin.Criar.Container(lytContainer).Executar)
    .AdicionarProcedimentoAposLogar(procedure ()
                                    begin
                                      frmPrincipal.ConfigurarMostrarMenus(mnConfiguracoes);
                                    end )

end;

procedure TfrmConfiguracao.CarregarUsuairo;
begin
  FQueryFeature := TModelQueryFeature.Criar;

  FCadastroUsuario := TControllerCadastros.Criar(FQueryFeature).CadastroUsuario;

  FCadastroUsuario.Id(TUsuarioLogado.gCodigoUsuario).Consultar();

  Self.edtNomeUsuario.Text := FCadastroUsuario.GetNome();
  Self.edtValorRenda.Text := FormatFloat('#0.00', FCadastroUsuario.GetValorRenda());
end;

procedure TfrmConfiguracao.edtValorRendaKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  TMask.MaskFloat(TEdit(Sender), '#0.00');
end;

procedure TfrmConfiguracao.FormCreate(Sender: TObject);
begin
  CarregarUsuairo();
end;

procedure TfrmConfiguracao.FormDestroy(Sender: TObject);
begin
  TMensagemAviso.ForcarTerminoThread();
end;

procedure TfrmConfiguracao.InserirAtualizarUsuario;
var
  lIdUsuario: Integer;
begin
  try
    {Tive que fazer isso porque ainda n�o criei no login um cadastro se caso n�o
    tenha usu�rio de login, ent�o ele loga com qualquer c�digo de usu�rio}
    lIdUsuario := FCadastroUsuario.GetId();

    FCadastroUsuario
      .Id(TUsuarioLogado.gCodigoUsuario) //
      .Nome(edtNomeUsuario.Text.Trim)
      .ValorRenda(StrToFloatDef(edtValorRenda.Text, 0));

    case lIdUsuario of
      0:
      begin
        FCadastroUsuario.Inserir();
      end;
      else
      begin
        FCadastroUsuario.Atualizar()
      end;
    end;

    TUsuarioLogado.gValorRenda := StrToFloatDef(edtValorRenda.Text, 0);

    TMensagemAviso.ForcarTerminoThread();

    TMensagemAviso.AdicionarMensagem(
                         TTipoMensagem.tpMensagemSucesso,
                         'Informa��es de usu�rio gravados com sucesso!',
                         lytContainer);

  except
    on E: Exception do
    begin
      TMensagemAviso.AdicionarMensagem(TTipoMensagem.tpMensagemErro,
                                       e.Message,
                                       lytContainer);
    end;
  end;
end;

end.
