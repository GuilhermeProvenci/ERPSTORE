program ERPSTORE;

uses
  Vcl.Forms,
  unit_principal in 'FONTES\unit_principal.pas' {form_principal},
  unit_login in 'FONTES\unit_login.pas' {form_login},
  unit_conexao in 'FONTES\unit_conexao.pas' {form_conexao: TDataModule},
  unit_configuracao_servidor in 'FONTES\unit_configuracao_servidor.pas' {form_configuracao_servidor},
  unit_mensagem in 'FONTES\unit_mensagem.pas' {form_mensagem},
  unit_fundo_esmaecer in 'FONTES\unit_fundo_esmaecer.pas' {form_fundo_esmaecer},
  unit_consulta_padrao in 'FONTES\Repositorio\unit_consulta_padrao.pas' {form_consulta_padrao},
  unit_consulta_clientes in 'FONTES\Consultas\unit_consulta_clientes.pas' {form_consulta_clientes},
  unit_consulta_produtos in 'FONTES\Consultas\unit_consulta_produtos.pas' {form_consulta_produtos},
  unit_conexao_tabelas in 'FONTES\unit_conexao_tabelas.pas' {form_conexao_tabelas: TDataModule},
  unit_funcoes in 'FONTES\unit_funcoes.pas',
  ClassMap in 'FONTES\class\ClassMap.pas',
  unit_cadastro_padrao in 'FONTES\Repositorio\unit_cadastro_padrao.pas' {form_cadastro_padrao},
  unit_cadastro_clientes in 'FONTES\Cadastros\unit_cadastro_clientes.pas' {form_cadastro_clientes},
  unit_cadastro_produtos in 'FONTES\Cadastros\unit_cadastro_produtos.pas' {form_cadastro_produtos},
  unit_consulta_condicional in 'FONTES\Consultas\unit_consulta_condicional.pas' {form_consulta_condicional},
  unit_cadastro_condicional in 'FONTES\Cadastros\unit_cadastro_condicional.pas' {form_cadastro_condicional},
  unit_consulta_estoque in 'FONTES\Consultas\unit_consulta_estoque.pas' {form_consulta_estoque},
  unit_cadastro_estoque in 'FONTES\Cadastros\unit_cadastro_estoque.pas' {form_cadastro_estoque},
  unit_report in 'FONTES\Reports\unit_report.pas' {form_cadastro_estoque},
  class_clientes in 'CLASSES\class_clientes.pas',
  class_compras in 'CLASSES\class_compras.pas',
  gplQry in 'LIB\gplQry.pas',
  gplForm in 'LIB\gplForm.pas',
  gplEdit in 'LIB\gplEdit.pas',
  class_produtos in 'CLASSES\class_produtos.pas',
  gplCombo in 'LIB\gplCombo.pas',
  unit_consulta_vendas in 'FONTES\Consultas\unit_consulta_vendas.pas' {form_consulta_vendas},
  class_auxi in 'CLASSES\class_auxi.pas',
  unit_utils in 'FONTES\unit_utils.pas' {Form1},
  unit_classGenerator in 'FONTES\unit_classGenerator.pas' {FrmClassGenerator},
  class_generator in 'CLASSES\class_generator.pas',
  class_gplObject in 'CLASSES\class_gplObject.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  //cria os modulos de dados de conexao e de tabelas
  Application.CreateForm(Tform_conexao, form_conexao);
  Application.CreateForm(Tform_conexao_tabelas, form_conexao_tabelas);
  //testa pra ver se a conexao esta ativa
  var_gbl_versao := GetVersaoArq;
  if form_conexao.FDConnection.Connected then
  begin
    //Criando o form de login mas mantento o form principal como mainForm
    form_login := Tform_login.Create( Nil );
    form_login.ShowModal;

    //cria o formulario principal
    Application.CreateForm(Tform_principal, form_principal);
    Application.CreateForm(Tform_fundo_esmaecer, form_fundo_esmaecer);


    form_login.Hide;
    form_login.Free;

    Application.Run;
  end;

end.
