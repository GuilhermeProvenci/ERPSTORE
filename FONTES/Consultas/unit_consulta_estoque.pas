unit unit_consulta_estoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_consulta_padrao, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, gplQry;

type
  Tform_consulta_estoque = class(Tform_consulta_padrao)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryEstoque: TgpQry;
  public
    { Public declarations }
  end;

var
  form_consulta_estoque: Tform_consulta_estoque;

implementation

{$R *.dfm}

uses unit_conexao, unit_conexao_tabelas;

procedure Tform_consulta_estoque.FormCreate(Sender: TObject);
begin
  inherited;
with form_conexao_tabelas.qryConsultaEstoque do//alteração pra evitar caso mude o sql
begin                                          //pela tela de condicional
  close;
  sql.Clear;
  sql.Add('select * from estoque');
  open;
end;




end;

end.
