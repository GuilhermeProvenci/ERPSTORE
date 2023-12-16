unit unit_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.AppEvnts, unit_funcoes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, gplQry;

type
  Tform_principal = class(TForm)
    pnl_topo: TPanel;
    pnl_fundo: TPanel;
    pnl_menulateral: TPanel;
    img_logo_empresa: TImage;
    lbl_titulo: TLabel;
    lbl_versao: TLabel;
    img_botato_logado: TImage;
    img_botao_sair: TImage;
    pnl_botao_configuracoes: TPanel;
    img_botao_config: TImage;
    lbl_botao_config: TLabel;
    pnl_botao_clientes: TPanel;
    img_botao_clientes: TImage;
    lbl_botao_clientes: TLabel;
    pnl_botao_produtos: TPanel;
    img_botao_produtos: TImage;
    lbl_botao_produtos: TLabel;
    pnl_botao_cadastros: TPanel;
    img_botao_cadastros: TImage;
    lbl_botao_cadastros: TLabel;
    pnl_botao_usuarios: TPanel;
    img_botao_usuarios: TImage;
    lbl_botao_usuarios: TLabel;
    pnl_submenu_config: TPanel;
    pnl_config_servidor: TPanel;
    img_config_servidor: TImage;
    lbl_config_servidor: TLabel;
    pnl_submenu_cadastros: TPanel;
    pnl_tab_cidades: TPanel;
    img_tab_cidades: TImage;
    lbl_tab_cidades: TLabel;
    pnl_tab_estados: TPanel;
    img_tab_estados: TImage;
    lbl_tab_estados: TLabel;
    pnl_tab_paises: TPanel;
    img_tab_paises: TImage;
    lbl_tab_paises: TLabel;
    pnl_barra_separadora: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    ApplicationEvents: TApplicationEvents;
    pnl_config_nfe: TPanel;
    img_config_nfe: TImage;
    lbl_config_nfe: TLabel;
    pnl_botao_estoque: TPanel;
    img_botao_estoque: TImage;
    lbl_botao_estoque: TLabel;
    pnl_botao_compra: TPanel;
    img_botao_compras: TImage;
    lbl_botao_compras: TLabel;
    procedure img_botao_sairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure pnl_menulateralMouseEnter(Sender: TObject);
    procedure pnl_fundoMouseEnter(Sender: TObject);
    procedure pnl_botao_notasMouseEnter(Sender: TObject);
    procedure pnl_botao_configuracoesClick(Sender: TObject);
    procedure pnl_botao_cadastrosClick(Sender: TObject);
    procedure pnl_config_servidorClick(Sender: TObject);
    procedure ApplicationEventsModalBegin(Sender: TObject);
    procedure ApplicationEventsModalEnd(Sender: TObject);
    procedure pnl_botao_clientesClick(Sender: TObject);
    procedure pnl_botao_produtosClick(Sender: TObject);
    procedure pnl_tab_paisesClick(Sender: TObject);
    procedure pnl_tab_estadosClick(Sender: TObject);
    procedure pnl_tab_cidadesClick(Sender: TObject);
    procedure pnl_botao_estoqueClick(Sender: TObject);
    procedure pnl_botao_compraClick(Sender: TObject);


  private
    procedure prc_EscondeMenus;
    { Private declarations }
  public
    procedure prc_controla_menu ( Ativar: boolean );
    { Public declarations }
  end;

var
  form_principal: Tform_principal;

implementation

{$R *.dfm}

uses unit_configuracao_servidor, unit_fundo_esmaecer,
   unit_consulta_produtos, unit_consulta_clientes, unit_consulta_condicional,
  unit_consulta_estoque;

procedure Tform_principal.ApplicationEventsModalBegin(Sender: TObject);
begin
  form_fundo_esmaecer.Show;
end;

procedure Tform_principal.ApplicationEventsModalEnd(Sender: TObject);
begin
  form_fundo_esmaecer.Hide;
end;

procedure Tform_principal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //liberando o form da memoria
  FreeandNil ( form_principal );

  //Encerrando a Aplicação
  Application.Terminate;
end;

procedure Tform_principal.FormCreate(Sender: TObject);
begin
  //Ativando o Memory Leak (Vazamento de memoria)
  ReportMemoryLeaksOnShutdown := True;
  lbl_versao.Caption :=  'Versão: ' + Var_gbl_versao;
end;

procedure Tform_principal.img_botao_sairClick(Sender: TObject);
begin
  //fecha o form principal
  form_principal.Close;
end;

procedure Tform_principal.pnl_botao_compraClick(Sender: TObject);
begin
  form_consulta_clientes := Tform_consulta_clientes.Create ( Self );
  form_consulta_clientes.parent := pnl_fundo;
  prc_controla_menu ( False );

  form_consulta_clientes.Show;
end;

procedure Tform_principal.pnl_botao_configuracoesClick(Sender: TObject);
begin
  //Funcao que esconde um SubMenu caso esteja aberto
  prc_EscondeMenus;

  //Posicionando e mostrando o SubMenu COnfigurações
  pnl_submenu_config.Visible := True;
  pnl_submenu_config.Top :=  pnl_botao_configuracoes.Top;
  pnl_submenu_config.Left:= 0;
end;

procedure Tform_principal.pnl_botao_estoqueClick(Sender: TObject);
begin
  form_consulta_estoque := Tform_consulta_estoque.Create ( Self );
  form_consulta_estoque.parent := pnl_fundo;
  prc_controla_menu ( False );
  form_consulta_estoque.Show;
end;

procedure Tform_principal.pnl_botao_notasMouseEnter(Sender: TObject);
begin
  //expande o menu lateral
  pnl_menulateral.Width := 155;

  if ( Sender is TPanel ) then
    MudarBotao ( form_principal, ( Sender AS TPanel ) )
  else
  if ( Sender is TLabel ) then
    MudarBotao ( form_principal, ( ( Sender AS TLabel ).Parent As TPanel ) )
  else
  if ( Sender is TImage ) then
    MudarBotao ( form_principal, ( ( Sender AS TImage ).Parent As TPanel ) );
end;

procedure Tform_principal.pnl_botao_clientesClick(Sender: TObject);
begin
  form_consulta_clientes := Tform_consulta_clientes.Create ( Self );
  form_consulta_clientes.parent := pnl_fundo;
  prc_controla_menu ( False );

  form_consulta_clientes.Show;
end;

procedure Tform_principal.pnl_botao_produtosClick(Sender: TObject);
begin

  form_consulta_produtos := Tform_consulta_produtos.Create ( Self );

  form_consulta_produtos.parent := pnl_fundo;
  prc_controla_menu ( False );

  form_consulta_produtos.Show;
end;

procedure Tform_principal.pnl_botao_cadastrosClick(Sender: TObject);
begin
  //Funcao que esconde um SubMenu caso esteja aberto
  prc_EscondeMenus;

  //Posicionando e mostrando o SubMenu Tabelas
  pnl_submenu_cadastros.Visible := True;
  pnl_submenu_cadastros.Top     :=  pnl_botao_cadastros.Top;
  pnl_submenu_cadastros.Left    := 0;
end;

procedure Tform_principal.pnl_config_servidorClick(Sender: TObject);
begin

  //cria o form config servidor
  form_configuracao_servidor := Tform_configuracao_servidor.Create ( Self );

  //manda abrir o form dentro do painel
  form_configuracao_servidor.parent := pnl_fundo;

  // desativando os botoes do form principal
  prc_controla_menu ( False );

  form_configuracao_servidor.Show;

end;

procedure Tform_principal.pnl_fundoMouseEnter(Sender: TObject);
begin
  //retrai o menu lateral e esconde os submenus
  pnl_menulateral.Width := 54;
  prc_EscondeMenus;
end;

procedure Tform_principal.pnl_menulateralMouseEnter(Sender: TObject);
begin
  //expande o menu lateral
  pnl_menulateral.Width := 155;
end;


procedure Tform_principal.pnl_tab_estadosClick(Sender: TObject);
var
  Valor1, Valor2, Msg:  String;
  gplQry : TgpQry;
  qry : TFDQuery;

begin

//CalcDoisCamp('SELECT id, preco FROM produtos WHERE id = 2', Valor1, Valor2);
//
//// Agora você pode usar os valores retornados conforme necessário
//ShowMessage('Valor1: ' + Valor1 + #13#10 + 'Valor2: ' + Valor2);

  gplQry := TgpQry.Create(Self);

  try
    // Verifique se a propriedade Connection está atribuída
    if Assigned(gplQry.Connection) then
    begin
      gplQry.SQL.Text := 'select * from clientes';
      gplQry.Open;

      Msg := 'Resultados da Consulta:'#13#10;
      try
        while not gplQry.Eof do
        begin
          Msg := Msg + 'Nome: ' + gplQry.FieldByName('Nome').AsString + ', ';
          Msg := Msg + 'Idade: ' + gplQry.FieldByName('Idade').AsString + ', ';
          // Adicione outros campos conforme necessário

          // Vá para o próximo registro
          gplQry.Next;
        end;

        // Exiba a mensagem
        ShowMessage(Msg);
      finally
        gplQry.Close;  // Certifique-se de fechar a query após o uso
      end;
    end
    else
      ShowMessage('A propriedade Connection não está atribuída corretamente.');
  finally
    FreeAndNil(gplQry);
  end;
  end;


procedure Tform_principal.pnl_tab_cidadesClick(Sender: TObject);
begin
  //cria o form_consulta_origem_mercadoria
//  form_consulta_cidades := Tform_consulta_cidades.Create ( Self );

  //manda abrir o form dentro do painel
//  form_consulta_cidades.parent := pnl_fundo;

  // desativando os botoes do form principal
//  prc_controla_menu ( False );

//  form_consulta_cidades.Show;
end;

procedure Tform_principal.pnl_tab_paisesClick(Sender: TObject);
begin
  //cria o form_consulta_origem_mercadoria
 form_consulta_condicional := Tform_consulta_condicional.Create ( Self );

  //manda abrir o form dentro do painel
  form_consulta_condicional.parent := pnl_fundo;

  // desativando os botoes do form principal
  prc_controla_menu ( False );

  form_consulta_condicional.Show;
end;

procedure Tform_principal.prc_controla_menu( Ativar: boolean );
begin
  //retrai o menu lateral e esconde os submenus
  pnl_menulateral.Width := 54;
  prc_EscondeMenus;

  // desativando/ativando os botoes do form principal
  pnl_menulateral.Enabled := Ativar;
  pnl_topo.Enabled        := Ativar;

end;

procedure Tform_principal.prc_EscondeMenus;
begin
  //Funcao que esconde qualquer submenu que esteja aberto
  pnl_submenu_cadastros.Visible := False;
  pnl_submenu_config.Visible  := False;
end;

end.
