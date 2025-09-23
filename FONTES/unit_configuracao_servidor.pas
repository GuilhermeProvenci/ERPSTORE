unit unit_configuracao_servidor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls;

type
  Tform_configuracao_servidor = class(TForm)
    pnl_fundo: TPanel;
    pnl_topo: TPanel;
    pnl_separador_topo: TPanel;
    lbl_titulo: TLabel;
    btn_fechar: TSpeedButton;
    lbl_nova_configuracao: TLabel;
    lbl_configuracao_atual: TLabel;
    lbl_servidor_novo: TLabel;
    lbl_base_dados_novo: TLabel;
    lbl_porta_novo: TLabel;
    lbl_login_novo: TLabel;
    lbl_senha_novo: TLabel;
    edt_servidor_novo: TEdit;
    edt_caminho_novo: TEdit;
    edt_porta_novo: TEdit;
    edt_login_novo: TEdit;
    edt_senha_novo: TEdit;
    lbl_servidor: TLabel;
    lbl_porta: TLabel;
    lbl_base_dados: TLabel;
    lbl_login: TLabel;
    lbl_senha: TLabel;
    edt_nome_servidor_atual: TEdit;
    edt_caminho_atual: TEdit;
    edt_porta_atual: TEdit;
    edt_login_atual: TEdit;
    edt_senha_atual: TEdit;
    pnl_separacao: TPanel;
    btn_salvar: TSpeedButton;
    procedure btn_fecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_salvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_configuracao_servidor: Tform_configuracao_servidor;

implementation

{$R *.dfm}

uses unit_principal, unit_conexao, unit_funcoes, unit_mensagem;

procedure Tform_configuracao_servidor.btn_fecharClick(Sender: TObject);
begin
  Self.close;

  if form_principal = nil then //se o form principal nao existir
    Application.Terminate;

end;

procedure Tform_configuracao_servidor.btn_salvarClick(Sender: TObject);
begin
  ValidarCampoObrigatorios ( Self );


  //salva as configuracoes no arquivo ini
  try
    //adiciona os parametros digitados ao componente
    form_conexao.FDConnection.Params.Clear;
    form_conexao.FDConnection.Params.Add('Server=' + edt_servidor_novo.Text );
    form_conexao.FDConnection.Params.Add('user_name=' + edt_login_novo.Text);
    form_conexao.FDConnection.Params.Add('password=' + edt_senha_novo.Text );
    form_conexao.FDConnection.Params.Add('port=' + edt_porta_novo.Text );
    form_conexao.FDConnection.Params.Add('DataBase=' + edt_caminho_novo.Text );
    form_conexao.FDConnection.Params.Add('DriverID=' + 'mySQL');

    //tenta conectar com os novos parametros
    form_conexao.FDConnection.Connected := true;
  except

    //nao conseguiu conectar, parametros do arquivo ini errados
    on e:Exception do
    begin
      CriarMensagem(mtErro,'Não foi possível conectar ao Banco de Dados, motivo:'+
                    e.Message);

      Abort;
    end;

  end; //fim do try

  //a conexao foi realizada entao grava os valores dos edit para as variaveis
  form_conexao.sNomeServidor    := edt_servidor_novo.Text;
  form_conexao.sCaminhoNomeBase := edt_caminho_novo.Text;
  form_conexao.iPorta           := StrToInt( edt_porta_novo.Text);
  form_conexao.sLogin           := edt_login_novo.Text;
  form_conexao.sSenha           := edt_senha_novo.Text;

  //e depois grava o novo arquivo ini
  Try
    form_conexao.GravarArquivoINI;
    CriarMensagem(mtAviso,'Conexao Realizada com Sucesso, arquivo Gravado! O Sistema deve ser Reiniciado!');
    form_configuracao_servidor.Close;
    Application.Terminate;
  Except

    //erro na gravação do arquivo ini
    on e:Exception do
    begin
      CriarMensagem(mtErro,'Não foi possível Gravar o Arquivo .INI, motivo: ' + e.Message);
      Abort;
    end;

  End;

end;

procedure Tform_configuracao_servidor.Button1Click(Sender: TObject);
begin
Criptografia(form_conexao.sSenha);
ShowMessage(form_conexao.sSenha);
end;

procedure Tform_configuracao_servidor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  //reativa os botoes do formprincipal
  if form_principal <> nil then //se o form principal existir
    form_principal.prc_controla_menu ( True );

  //libera o form da memoria
  FreeAndNil( form_configuracao_servidor );
end;

procedure Tform_configuracao_servidor.FormShow(Sender: TObject);
begin
  //carrega os valores da atual configuracao no arquivo ini caso
  //exista e mostra nos edits
  edt_servidor_novo.Setfocus;

  form_conexao.LerArquivoINI;

  edt_nome_servidor_atual.Text := form_conexao.sNomeServidor;
  edt_caminho_atual.Text       := form_conexao.sCaminhoNomeBase;
  edt_porta_atual.Text         := IntToStr( form_conexao.iPorta );
  edt_login_atual.Text         := form_conexao.sLogin;
  edt_senha_atual.Text         := form_conexao.sSenha;

end;

end.
