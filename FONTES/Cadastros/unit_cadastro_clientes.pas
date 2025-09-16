unit unit_cadastro_clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_cadastro_padrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.Mask;

type
  Tform_cadastro_clientes = class(TfrmBaseRegister)
    pnl_nome: TPanel;
    lbl_nome: TLabel;
    edtNome: TEdit;
    pnl_barra_nome: TPanel;
    pnl_endereco: TPanel;
    lbl_endereco: TLabel;
    edtEndereco: TEdit;
    pnl_barra_endereco: TPanel;
    pnl_telefone: TPanel;
    lbl_telefone: TLabel;
    edtTelefone: TEdit;
    pnl_barra_telefone: TPanel;
    pnl_email: TPanel;
    lbl_email: TLabel;
    edtEmail: TEdit;
    pnl_barra_email: TPanel;
    pnl_classificacao: TPanel;
    lbl_classificacao: TLabel;
    cmbClassificacao: TComboBox;
    pnl_barra_Classificacao: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_cadastro_clientes: Tform_cadastro_clientes;

implementation

{$R *.dfm}

uses unit_conexao, unit_funcoes;

initialization
  Tform_cadastro_clientes.ClassName;

end.
