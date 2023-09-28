unit unit_mensagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  Tform_mensagem = class(TForm)
    pnl_fundo: TPanel;
    pnl_topo: TPanel;
    img_logo_empresa: TImage;
    lbl_titulo: TLabel;
    img_icone: TImage;
    lbl_descricao: TLabel;
    btn_sim: TButton;
    btn_nao: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_simClick(Sender: TObject);
    procedure btn_naoClick(Sender: TObject);
  private
    { Private declarations }
  public
    sTipo : String;
    { Public declarations }
  end;

var
  form_mensagem: Tform_mensagem;

implementation

{$R *.dfm}

uses unit_funcoes;

procedure Tform_mensagem.btn_naoClick(Sender: TObject);
begin
  //ARMAZENA A RESPOSTA NAO NA VARIAVEL
  var_gbl_resposta_msg := false;

    // Define o resultado como "mrNo"
  ModalResult := mrNo;


  form_mensagem.Close;
end;

procedure Tform_mensagem.btn_simClick(Sender: TObject);
begin
  //ARMAZENA A RESPOSTA SIM NA VARIAVEL
  var_gbl_resposta_msg := TRUE;

   // Define o resultado como "mrYes"
  ModalResult := mrYes;

  form_mensagem.Close;
end;

procedure Tform_mensagem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //se pressionou o enter executa o click do botao SIM
  if key = VK_RETURN then
    btn_SimClick(Self)
  else
  //se pressionou o esc executa o click do botao NAO
  if key = VK_ESCAPE then
    btn_naoClick(Self);

end;

procedure Tform_mensagem.FormShow(Sender: TObject);
begin
  //seleciona o icone e o tipo de mensagem de acordo com o valor da variavel sTipo
  IF UpperCase ( sTipo )= 'AVISO'  then
  BEGIN

    lbl_titulo.Caption := 'ATENÇÃO - AVISO';

    btn_sim.Left       := btn_nao.Left; //POSICIONA O BOTAO SIM POIS SO ELE IRA APARECER
    btn_nao.Visible    := false;

    btn_sim.caption    := 'OK ( ENTER )';
    img_icone.Picture.LoadFromFile( ExtractFilePath ( Application.ExeName ) + '\MENSAGEM\aviso.png' );

  END ELSE
  IF UpperCase ( sTipo )= 'DELETE'  then
  BEGIN

    lbl_titulo.Caption := 'CONFIRMAÇÃO DE EXCLUSÃO NECESSÁRIA';
    btn_sim.caption    := 'SIM ( ENTER )';
    btn_nao.Visible    := true;
    img_icone.Picture.LoadFromFile( ExtractFilePath ( Application.ExeName ) + '\MENSAGEM\delete.png' );

  END ELSE
  IF UpperCase ( sTipo )= 'CONFIRMACAO'  then
  BEGIN

    lbl_titulo.Caption := 'CONFIRMAÇÃO NECESSÁRIA';
    btn_nao.Visible    := TRUE;
    btn_sim.caption    := 'SIM ( ENTER )';
    img_icone.Picture.LoadFromFile( ExtractFilePath ( Application.ExeName ) + '\MENSAGEM\confirmacao.png' );

  END ELSE
  IF UpperCase ( sTipo )= 'ERRO'  then
  BEGIN

    lbl_titulo.Caption := 'ERRO NA OPERAÇÃO';

    btn_sim.Left       := btn_nao.Left; //POSICIONA O BOTAO SIM POIS SO ELE IRA APARECER
    btn_nao.Visible    := false;

    btn_sim.caption    := 'OK ( ENTER )';
    img_icone.Picture.LoadFromFile( ExtractFilePath ( Application.ExeName ) + '\MENSAGEM\erro.png' );

  END;
end;

end.
