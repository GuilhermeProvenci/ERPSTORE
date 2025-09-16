unit unit_cadastro_produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_cadastro_padrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons;

type
  Tform_cadastro_produtos = class(TfrmBaseRegister)
    pnl_nome: TPanel;
    lbl_nome: TLabel;
    edtNome: TEdit;
    pnl_barra_nome: TPanel;
    pnl_tamanho: TPanel;
    lbl_tamanho: TLabel;
    cmbTamanho: TComboBox;
    pnl_barra_tamanho: TPanel;
    pnl_preco: TPanel;
    lbl_preco: TLabel;
    edtPreco: TEdit;
    pnl_barra_preco: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_cadastro_produtos: Tform_cadastro_produtos;

implementation

{$R *.dfm}

initialization
  Tform_cadastro_produtos.ClassName;
end.
