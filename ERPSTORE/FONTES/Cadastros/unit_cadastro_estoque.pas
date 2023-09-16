unit unit_cadastro_estoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_cadastro_padrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls;

type
  Tform_cadastro_estoque = class(Tform_cadastro_padrao)
    DBLookupComboBox1: TDBLookupComboBox;
    dsEstoque: TDataSource;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_cadastro_estoque: Tform_cadastro_estoque;

implementation

{$R *.dfm}

uses unit_conexao_tabelas, unit_conexao;

procedure Tform_cadastro_estoque.FormCreate(Sender: TObject);
begin
  inherited;
with form_conexao_tabelas.qryConsultaEstoque do
begin
close;
sql.Clear;
sql.Add('select * from estoque');
open;

end;

end;

end.
