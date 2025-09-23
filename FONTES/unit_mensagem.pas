unit unit_mensagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TMensagemTipo = (mtAviso, mtDelete, mtConfirmacao, mtErro);

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
    Tipo: TMensagemTipo;
    { Public declarations }
  end;

var
  form_mensagem: Tform_mensagem;

implementation

{$R *.dfm}

uses unit_funcoes;

procedure Tform_mensagem.btn_naoClick(Sender: TObject);
begin
  ModalResult := mrNo;
end;

procedure Tform_mensagem.btn_simClick(Sender: TObject);
begin
  ModalResult := mrYes;
end;

procedure Tform_mensagem.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btn_sim.Click
  else if Key = VK_ESCAPE then
    btn_nao.Click;
end;

procedure Tform_mensagem.FormShow(Sender: TObject);
begin
  case Tipo of
    mtAviso:
      begin
        lbl_titulo.Caption := 'ATENÇÃO - AVISO';
        btn_sim.Left := btn_nao.Left;
        btn_nao.Visible := False;
        btn_sim.Caption := 'OK (ENTER)';
        img_icone.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\MENSAGEM\aviso.png');
      end;

    mtDelete:
      begin
        lbl_titulo.Caption := 'CONFIRMAÇÃO DE EXCLUSÃO NECESSÁRIA';
        btn_sim.Caption := 'SIM (ENTER)';
        btn_nao.Visible := True;
        img_icone.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\MENSAGEM\delete.png');
      end;

    mtConfirmacao:
      begin
        lbl_titulo.Caption := 'CONFIRMAÇÃO NECESSÁRIA';
        btn_sim.Caption := 'SIM (ENTER)';
        btn_nao.Visible := True;
        img_icone.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\MENSAGEM\confirmacao.png');
      end;

    mtErro:
      begin
        lbl_titulo.Caption := 'ERRO NA OPERAÇÃO';
        btn_sim.Left := btn_nao.Left;
        btn_nao.Visible := False;
        btn_sim.Caption := 'OK (ENTER)';
        img_icone.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\MENSAGEM\erro.png');
      end;
  end;
end;

end.
