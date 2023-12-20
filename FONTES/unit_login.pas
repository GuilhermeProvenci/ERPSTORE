unit unit_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, unit_funcoes, gplForm;

type
  Tform_login = class(TgpForm)
    pnl_fundo: TPanel;
    pnl_lateral: TPanel;
    pnl_imagem: TPanel;
    lbl_titulo: TLabel;
    lbl_versao: TLabel;
    lbl_bemvindo: TLabel;
    img_botao_sair: TImage;
    img_logo_empresa: TImage;
    lbl_autor: TLabel;
    pnl_login: TPanel;
    lbl_login: TLabel;
    edt_login: TEdit;
    pnl_barra_login: TPanel;
    pnl_senha: TPanel;
    lbl_senha: TLabel;
    edt_senha: TEdit;
    pnl_barra_senha: TPanel;
    pnl_botao_entrar: TPanel;
    img_botao_impostos: TImage;
    lbl_botao_entrar: TLabel;
    pnl_campos: TPanel;
    procedure img_botao_sairClick(Sender: TObject);
    procedure lbl_botao_entrarMouseEnter(Sender: TObject);
    procedure lbl_botao_entrarMouseLeave(Sender: TObject);
    procedure pnl_botao_entrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_login: Tform_login;

implementation

{$R *.dfm}

procedure Tform_login.FormCreate(Sender: TObject);
begin
lbl_versao.caption :=  'Versão: ' + Var_gbl_versao;
end;

procedure Tform_login.img_botao_sairClick(Sender: TObject);
begin
  //Encerrar a Aplicação
  Application.Terminate;

end;

procedure Tform_login.lbl_botao_entrarMouseEnter(Sender: TObject);
begin
  lbl_botao_entrar.Font.Color := $000080FF;
end;

procedure Tform_login.lbl_botao_entrarMouseLeave(Sender: TObject);
begin
  lbl_botao_entrar.Font.Color := clWhite;
end;

procedure Tform_login.pnl_botao_entrarClick(Sender: TObject);
begin
  //faremos as validacoes de login e depois -->
  //Fecha o Form de Login
  Close;
end;

end.
