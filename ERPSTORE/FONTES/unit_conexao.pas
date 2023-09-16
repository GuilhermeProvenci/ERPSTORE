unit unit_conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  Data.DB, FireDAC.Comp.Client, System.IniFiles, Vcl.Forms, Vcl.Dialogs,
  Vcl.Controls, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  Tform_conexao = class(TDataModule)
    FDConnection: TFDConnection;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sNomeServidor,
    sCaminhoNomeBase,
    sLogin,
    sSenha : String;
    iPorta : Integer;

    procedure GravarArquivoINI;
    function LerArquivoINI: Boolean;

  end;

var
  form_conexao: Tform_conexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses unit_funcoes, unit_configuracao_servidor;

{$R *.dfm}

procedure Tform_conexao.DataModuleCreate(Sender: TObject);
begin
  FDConnection.Params.Clear;

  //verifica se o arquivo existe e carrega os parametro para as variaveis
  if LerArquivoINI then
  begin
    //armazena os valores das variaveis do arquivo ini dentro do componente de conexao
    FDConnection.Params.Add('Server=' + sNomeServidor );
    FDConnection.Params.Add('user_name=' + sLogin);
    FDConnection.Params.Add('password=' + sSenha );
    FDConnection.Params.Add('port=' + IntToStr( iPorta ));
    FDConnection.Params.Add('DataBase=' + sCaminhoNomeBase );
    FDConnection.Params.Add('DriverID=' + 'mySQL');

    try
      //conecta ao banco
      FDConnection.Connected := True;

    Except
      //nao conseguiu conectar, parametros do arquivo ini errados
      on e:Exception do
      begin
        CriarMensagem('erro','Não foi possível conectar ao Banco de Dados, motivo:'+
                      e.Message);

        //criar a tela de configurar servidor
        form_configuracao_servidor          := Tform_configuracao_servidor.Create( nil );
        form_configuracao_servidor.align    := alNone;
        form_configuracao_servidor.Position := poScreenCenter;
        form_configuracao_servidor.ShowModal;
      end;

    end; //fim do except


  end else //fim do lerarquivoini
  begin
    //nao leu o arquivo ini entao avisa o usuario
    CriarMensagem('erro','Não foi possível ler o arquivo de configuração do Banco de Dados');


    //criar a tela de configurar servidor
    form_configuracao_servidor          := Tform_configuracao_servidor.Create( nil );
    form_configuracao_servidor.align    := alNone;
    form_configuracao_servidor.Position := poScreenCenter;
    form_configuracao_servidor.ShowModal;
  end;

end;

procedure Tform_conexao.DataModuleDestroy(Sender: TObject);
begin
  //Fecha a Conexao com o banco
  FDConnection.Connected := False;
end;

procedure Tform_conexao.GravarArquivoINI;
var
  NomeArquivoINI: String;
  ArquivoIni    : TIniFile;

begin
  //atribui o nome e caminho a variavel
  NomeArquivoINI := ChangeFileEXT ( Application.Exename, '.ini');

  //cria a variavel do arquivo e abre ela para edição
  ArquivoIni := TiniFile.Create( NomeArquivoINI );

  try
    //adiciona as variaveis ao arquivo
    ArquivoIni.WriteString('Configuracao','Servidor', sNomeServidor );
    ArquivoIni.WriteString('Configuracao','Base', sCaminhoNomeBase );
    ArquivoIni.WriteString('Configuracao','Porta', IntToStr( iPorta ) );
    ArquivoIni.WriteString('Acesso','Login', sLogin );
    ArquivoIni.WriteString('Acesso','Senha',  Criptografia ( sSenha ) );

  finally
    //Libera o arquivo da memoria
    ArquivoIni.Free;
  end;

end;

//verifica se o arquivo existe e carrega os parametro para as variaveis
function Tform_conexao.LerArquivoINI: Boolean;
var
  NomeArquivoINI: String;
  ArquivoIni    : TIniFile;

begin
  //atribui o nome e caminho a variavel
  NomeArquivoINI := ChangeFileEXT ( Application.Exename, '.ini');

  //cria a variavel do arquivo e abre ela para edição
  ArquivoIni := TiniFile.Create( NomeArquivoINI );

  //testa pra ver se encontrou o arquivo
  if not FileExists ( NomeArquivoINI ) then
  begin
    Result := False; //nao encontrou o arquivo entao retorna false na funcao
    ArquivoIni.Free; //Libera o arquivo da memoria
  end else
  begin

    try
      //le as variaveis do arquivo
      sNomeServidor    := ArquivoIni.ReadString('Configuracao','Servidor','');
      sCaminhoNomeBase := ArquivoIni.ReadString('Configuracao','Base','');
      iPorta           := StrToInt( ArquivoIni.ReadString('Configuracao','Porta','0') ) ;
      sLogin           := ArquivoIni.ReadString('Acesso','Login','');
      sSenha           := ArquivoIni.ReadString('Acesso','Senha','');
      sSenha           := Criptografia ( sSenha );

    finally
      //retorno para a funcao de arquivo encontrado e lido
      Result := True;

      //Libera o arquivo da memoria
      ArquivoIni.Free;
    end;

  end;
end;

end.
