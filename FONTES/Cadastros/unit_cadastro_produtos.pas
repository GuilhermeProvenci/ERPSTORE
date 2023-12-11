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
  Tform_cadastro_produtos = class(Tform_cadastro_padrao)
    qryProd: TFDQuery;
    procedure pnl_salvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_cadastro_produtos: Tform_cadastro_produtos;

implementation

{$R *.dfm}

uses unit_conexao_tabelas, unit_conexao;

procedure Tform_cadastro_produtos.pnl_salvarClick(Sender: TObject);
VAR
nomeprod: string;
begin
  nomeprod := edt_nome.Text;
  inherited;



 if not ModoEdicao then
 begin
  with qryProd do
  begin
    close;
    sql.Clear;
    sql.Add('select max(id) as id, nome from produtos');
    open;
  end;

  with qryInsert do
  begin
    close;
    sql.Clear;
    sql.Add('Insert into estoque (produto_id, nome_produto ) values (:id, :nome)') ;
    ParamByName('id').Value := qryProd.FieldByName('id').Value;
    ParamByName('nome').Value := nomeprod;
    ExecSQL;
  end;
 end;




end;

initialization

RegisterClass(Tform_cadastro_produtos);

end.
