unit unit_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.AppEvnts, unit_funcoes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, gplQry, class_gplObject;

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
    pnl_tab_Condicional: TPanel;
    img_tab_Condicional: TImage;
    lbl_tab_Condicional: TLabel;
    pnl_barra_separadora: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    ApplicationEvents: TApplicationEvents;
    pnl_utils: TPanel;
    img_utils: TImage;
    lbl_utils: TLabel;
    pnl_botao_estoque: TPanel;
    img_botao_estoque: TImage;
    lbl_botao_estoque: TLabel;
    pnl_botao_vendas: TPanel;
    img_botao_vendas: TImage;
    lbl_botao_vendas: TLabel;
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
    procedure pnl_tab_CondicionalClick(Sender: TObject);
    procedure pnl_botao_estoqueClick(Sender: TObject);
    procedure pnl_botao_vendasClick(Sender: TObject);
  private
    procedure prc_EscondeMenus;
    procedure pnl_botaoClick(Sender: TObject; AFormClass: TFormClass);
    procedure MostrarSubMenu(ASubMenu, AButton: TPanel);
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
  unit_consulta_estoque, unit_consulta_vendas;


procedure Tform_principal.pnl_botaoClick(Sender: TObject; AFormClass: TFormClass);
var
  NewForm: TForm;
begin
  NewForm := AFormClass.Create(Self);
  NewForm.Parent := pnl_fundo;
  prc_controla_menu(False);
  NewForm.Show;
end;

procedure Tform_principal.MostrarSubMenu(ASubMenu: TPanel; AButton: TPanel);
begin
  prc_EscondeMenus;
  ASubMenu.Visible := True;
  ASubMenu.Top := AButton.Top;
  ASubMenu.Left := 0;
end;

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

procedure Tform_principal.pnl_botao_vendasClick(Sender: TObject);
begin
  pnl_botaoClick(Sender, Tform_consulta_vendas);
end;

procedure Tform_principal.pnl_botao_estoqueClick(Sender: TObject);
begin
  pnl_botaoClick(Sender, Tform_consulta_estoque);
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
  pnl_botaoClick(Sender, Tform_consulta_clientes);
end;

procedure Tform_principal.pnl_botao_produtosClick(Sender: TObject);
begin
  pnl_botaoClick(Sender, Tform_consulta_produtos);
end;

procedure Tform_principal.pnl_botao_cadastrosClick(Sender: TObject);
begin
  MostrarSubMenu(pnl_submenu_cadastros, pnl_botao_cadastros);
end;

procedure Tform_principal.pnl_botao_configuracoesClick(Sender: TObject);
begin
  MostrarSubMenu(pnl_submenu_config, pnl_botao_configuracoes);
end;

procedure Tform_principal.pnl_config_servidorClick(Sender: TObject);
begin
  pnl_botaoClick(Sender, Tform_configuracao_servidor);
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


procedure Tform_principal.pnl_tab_CondicionalClick(Sender: TObject);
begin
  pnl_botaoClick(Sender, Tform_consulta_condicional);
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
