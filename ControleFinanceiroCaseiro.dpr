program ControleFinanceiroCaseiro;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFrameDespesasXSobrando in 'view\Frames\uFrameDespesasXSobrando.pas' {FrameDespesasXSobrando: TFrame},
  uFrameMenusAcessoRapido in 'view\Frames\uFrameMenusAcessoRapido.pas' {Frame1: TFrame},
  Uteis in 'controller\Uteis.pas',
  ufrmPrincipal in 'view\ufrmPrincipal.pas' {frmPrincipal},
  Model.Conexao.ConfiguracaoBanco in 'model\Conexao\Model.Conexao.ConfiguracaoBanco.pas',
  Model.Conexao.Feature in 'model\Conexao\Model.Conexao.Feature.pas',
  Model.Conexao.FireDac in 'model\Conexao\Model.Conexao.FireDac.pas',
  Model.Conexao.FireDac.PostGre in 'model\Conexao\Model.Conexao.FireDac.PostGre.pas',
  Model.DAO.Eventos.DataSet.Interfaces in 'model\Query\Model.DAO.Eventos.DataSet.Interfaces.pas',
  Model.DAO.Eventos.DataSet in 'model\Query\Model.DAO.Eventos.DataSet.pas',
  Model.Query.Feature in 'model\Query\Model.Query.Feature.pas',
  Model.Query.FireDac in 'model\Query\Model.Query.FireDac.pas',
  Controller.Helper in 'controller\Controller.Helper.pas',
  Model.DAO.DespesasXSobrando in 'model\DAO\Model.DAO.DespesasXSobrando.pas',
  uFrmConfiguracaoUsuario in 'view\uFrmConfiguracaoUsuario.pas' {Form2},
  Controller.VariaveisGlobais in 'controller\Controller.VariaveisGlobais.pas',
  Controller in 'controller\Controller.pas',
  Model.DAO.BuscarDespesas in 'model\DAO\Model.DAO.BuscarDespesas.pas',
  uFrameLogin in 'view\Frames\uFrameLogin.pas' {Frame2: TFrame},
  Model.DAO.Devedores in 'model\DAO\Model.DAO.Devedores.pas',
  uFramePai in 'view\Frames\uFramePai.pas' {FramePai: TFrame},
  uFrmCadastroPai in 'view\uFrmCadastroPai.pas' {frmCadastroPai},
  uFrmCadastroDespesas in 'view\uFrmCadastroDespesas.pas' {frmCadastroDespesas},
  uFrmCadastroDevedores in 'view\uFrmCadastroDevedores.pas' {frmCadastroDevedores},
  uFrameTotalizadorDevedores in 'view\Frames\uFrameTotalizadorDevedores.pas' {FrameTotalizadorDevedores: TFrame},
  AdicionarFrames in 'view\Frames\AdicionarFrames.pas',
  AdicionarFramesConjunto in 'view\Frames\AdicionarFramesConjunto.pas',
  AdicionarFramesPeriodo in 'view\Frames\AdicionarFramesPeriodo.pas',
  Model.DAO.BuscarDevedores in 'model\DAO\Model.DAO.BuscarDevedores.pas',
  Model.DAO.Despesas in 'model\DAO\Model.DAO.Despesas.pas',
  Model.DAO.BuscarPessoas in 'model\DAO\Model.DAO.BuscarPessoas.pas',
  uFrameDespesasPagas in 'view\Frames\uFrameDespesasPagas.pas' {FrameDespesasPagas: TFrame},
  uFrameItemDespesaPaga in 'view\Frames\uFrameItemDespesaPaga.pas' {FrameItemDespesaPaga: TFrame},
  uFrameMensagemAviso in 'view\Frames\uFrameMensagemAviso.pas' {FrameMensagemAviso: TFrame},
  AdicionarFrameMensagemAviso in 'view\Frames\AdicionarFrameMensagemAviso.pas',
  Model.DAO.CopiarDespesas in 'model\DAO\Model.DAO.CopiarDespesas.pas',
  Model.DAO.Copiar in 'model\DAO\Interfaces\Model.DAO.Copiar.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TfrmCadastroPai, frmCadastroPai);
  Application.CreateForm(TfrmCadastroDespesas, frmCadastroDespesas);
  Application.CreateForm(TfrmCadastroDevedores, frmCadastroDevedores);
  ReportMemoryLeaksOnShutdown := True;
  Application.Run;
end.
