unit unit_cadastro_clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_cadastro_padrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, gplEdit;

type
  Tform_cadastro_clientes = class(Tform_cadastro_padrao)
    qryCondicional: TFDQuery;
    cbb_classificacao: TComboBox;
    Label1: TLabel;
    procedure pnl_salvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

procedure Tform_cadastro_clientes.FormShow(Sender: TObject);
//var
//  ClienteInstance: TClientes;
begin
  inherited;
//  if Assigned(ClasseInstance) and (ClasseInstance is TClientes) then
//  begin
//  ClienteInstance := TClientes.Create
//  end;

TClientes(Classe).Create;
end;

procedure Tform_cadastro_clientes.pnl_salvarClick(Sender: TObject);
  var
  DataDevolucao : TDateTime;
begin
  DataDevolucao := Date + 3;
  with qryCondicional do
    begin
      close;
      ParamByName('1').Value:= strtoint(edt_id.Text);
      ParamByName('2').AsDateTime := Now;
      ParamByName('3').AsDateTime := DataDevolucao;
      ParamByName('4').Value:= edt_nome.Text;
      ExecSQL;
    end;


 inherited;
 // arrumar a classe
end;

initialization

RegisterClass(Tform_cadastro_clientes);

end.
