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
  uFrmConfiguracao in 'view\uFrmConfiguracao.pas' {frmConfiguracao},
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
  Model.DAO.BuscarDevedores in 'model\DAO\Model.DAO.BuscarDevedores.pas',
  Model.DAO.Despesas in 'model\DAO\Model.DAO.Despesas.pas',
  Model.DAO.BuscarPessoas in 'model\DAO\Model.DAO.BuscarPessoas.pas',
  uFrameDespesasPagas in 'view\Frames\uFrameDespesasPagas.pas' {FrameDespesasPagas: TFrame},
  uFrameItemDespesaPaga in 'view\Frames\uFrameItemDespesaPaga.pas' {FrameItemDespesaPaga: TFrame},
  uFrameMensagemAviso in 'view\Frames\uFrameMensagemAviso.pas' {FrameMensagemAviso: TFrame},
  Model.DAO.CopiarDespesas in 'model\DAO\Model.DAO.CopiarDespesas.pas',
  Model.DAO.Copiar in 'model\DAO\Interfaces\Model.DAO.Copiar.pas',
  Model.DAO.Usuario in 'model\DAO\Model.DAO.Usuario.pas',
  Model.DAO.Interfaces.Usuario in 'model\DAO\Interfaces\Model.DAO.Interfaces.Usuario.pas',
  Controller.Cadastros in 'controller\Controller.Cadastros.pas',
  Controller.Interfaces.Cadastros in 'controller\Interfaces\Controller.Interfaces.Cadastros.pas',
  Entidades.Usuario in 'model\Entidades\Entidades.Usuario.pas',
  AdicionarFrameMensagemAviso in 'view\Frames\AdicionarFrame\AdicionarFrameMensagemAviso.pas',
  AdicionarFrames in 'view\Frames\AdicionarFrame\AdicionarFrames.pas',
  AdicionarFramesConjunto in 'view\Frames\AdicionarFrame\AdicionarFramesConjunto.pas',
  AdicionarFramesPeriodo in 'view\Frames\AdicionarFrame\AdicionarFramesPeriodo.pas',
  uFrameAtualizarMes in 'view\Frames\uFrameAtualizarMes.pas' {FrameAtualizarMes: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  ReportMemoryLeaksOnShutdown := True;
  Application.Run;
end.
