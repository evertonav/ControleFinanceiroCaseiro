program ControleFinanceiroCaseiro;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFrameDespesasXSobrando in 'view\Frames\uFrameDespesasXSobrando.pas' {FrameDespesasXSobrando: TFrame},
  uFrameMenusAcessoRapido in 'view\Frames\uFrameMenusAcessoRapido.pas' {Frame1: TFrame},
  Uteis in 'controller\Uteis.pas',
  uFrmCadastroDespesas in 'view\uFrmCadastroDespesas.pas' {frmCadastroDespesas},
  ufrmPrincipal in 'view\ufrmPrincipal.pas' {frmPrincipal},
  Model.DAO.Gasto in 'model\DAO\Model.DAO.Gasto.pas',
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
  AdicionarFrames in 'view\AdicionarFrames.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
