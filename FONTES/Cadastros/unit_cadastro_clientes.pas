unit unit_cadastro_clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_cadastro_padrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, gplEdit, gplQry;

type
  Tform_cadastro_clientes = class(Tform_cadastro_padrao)
    cbb_classificacao: TComboBox;
    Label1: TLabel;
    procedure pnl_salvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_cadastro_clientes: Tform_cadastro_clientes;

implementation

{$R *.dfm}

uses unit_conexao, unit_funcoes, class_clientes;

procedure Tform_cadastro_clientes.pnl_salvarClick(Sender: TObject);
  var
  qryCondicional : tgpQry;
begin
 inherited;
   qryCondicional := tgpQry.Create(self);
   qryCondicional.SQLExec('INSERT INTO Condicional (ID_Cliente, Nome_Cliente) values (:1, :2) ',
                          [TClientes(FClasseInstance).ID, TClientes(FClasseInstance).Nome]);
end;

initialization

RegisterClass(Tform_cadastro_clientes);

end.
