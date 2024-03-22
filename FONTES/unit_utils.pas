unit unit_utils;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, gplForm, Vcl.Buttons, class_auxi,
  Vcl.StdCtrls, gplEdit, Vcl.ExtCtrls;

type
  TForm1 = class(TgpForm)
    pnl_fundo: TPanel;
    lbl_CODIGO: TLabel;
    lbl_informacao4: TLabel;
    pnl_topo: TPanel;
    lbl_titulo: TLabel;
    pnl_separador_topo: TPanel;
    edt_nome: TgpEdit;
    edt_4: TgpEdit;
    btn_fechar: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
