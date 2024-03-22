unit unit_cadastro_estoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_cadastro_padrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, gplEdit,
  gplQry, class_auxi;

type
  Tform_cadastro_estoque = class(Tform_cadastro_padrao)
    lccb_nome: TDBLookupComboBox;
    dsEstoque: TDataSource;
    dbg_registros: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure pnl_salvarClick(Sender: TObject);
    procedure lccb_nomeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_cadastro_estoque: Tform_cadastro_estoque;

implementation

{$R *.dfm}

uses unit_conexao_tabelas, unit_conexao, unit_funcoes;

procedure Tform_cadastro_estoque.lccb_nomeClick(Sender: TObject);
var
qry : TgpQry;
begin
  inherited;
qry := TgpQry.Create(self);
qry.SQLExec('select id from produtos where nome = :1 ', [lccb_nome.Text]);
//with qry do
//begin
//  sql.Add('select id from produtos where nome = :nome ');
//  ParamByName('nome').Value := lccb_nome.Text;
//  open;
//end;

 edt_id.Text := qry.FieldByName('id').AsString;
end;

procedure Tform_cadastro_estoque.FormCreate(Sender: TObject);
begin
  inherited;

edt_id.Clear;

form_conexao_tabelas.qryConsultaEstoque.Active := true;
form_conexao_tabelas.qryConsultaProdutos.Active := true;

with form_conexao_tabelas.qryConsultaEstoque do
begin
close;
sql.Clear;
sql.Add('select * from estoque');
open;

end;

end;

procedure Tform_cadastro_estoque.pnl_salvarClick(Sender: TObject);
begin
  with qryInsert do
  begin
    // Verifique se o registro já existe na tabela
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) FROM estoque WHERE produto_id = :id_prod');
    ParamByName('id_prod').Value := StrToInt(edt_id.Text);
    Open;

    // Se o registro existir, execute um UPDATE
    if Fields[0].AsInteger > 0 then
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE estoque SET quantidade_em_estoque = quantidade_em_estoque + :qtt WHERE produto_id = :id_prod');

    end
    else
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO estoque (produto_id, nome_produto ,quantidade_em_estoque) VALUES (:id_prod, :nome ,:qtt)');
       ParamByName('nome').Value := lccb_nome.Text;
    end;

    ParamByName('qtt').Value := StrToInt(edt_3.Text);

    ParamByName('id_prod').Value := StrToInt(edt_id.Text);
    ExecSQL;
  end;
  limpaEDit(Self);
  CriarMensagem('aviso', 'Registro Salvo com sucesso');
  form_conexao_tabelas.qryConsultaEstoque.Refresh;
  dbg_registros.Refresh;
end;

initialization

RegisterClass(Tform_cadastro_estoque);


end.
