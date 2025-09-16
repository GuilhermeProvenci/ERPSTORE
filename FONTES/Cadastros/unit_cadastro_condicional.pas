unit unit_cadastro_condicional;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.NumberBox, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, unit_conexao_tabelas, Vcl.Grids,
  Vcl.DBGrids;

type
  Tform_cadastro_condicional = class(TForm)
    pnl_fundo: TPanel;
    lbl_cliente: TLabel;
    lbl_produtos: TLabel;
    pnl_topo: TPanel;
    lbl_titulo: TLabel;
    btn_fechar: TSpeedButton;
    pnl_separador_topo: TPanel;
    lbl_qtt: TLabel;
    pnl_add: TPanel;
    lbl_qtt_estoque: TLabel;
    dbg_registros: TDBGrid;
    pnl_registros: TPanel;
    pnl_remover: TPanel;
    pnl_campos: TPanel;
    Splitter1: TSplitter;
    lbl_obs: TLabel;
    qryClientes: TFDQuery;
    qryProdutos: TFDQuery;
    qryEstoque: TFDQuery;
    qryCondicional: TFDQuery;
    qryCondPendente: TFDQuery;
    procedure btn_fecharClick(Sender: TObject);
    procedure cbb_produtosChange(Sender: TObject);
    procedure cbb_clientesChange(Sender: TObject);
    procedure edt_cod_clieKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_cod_prodKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    clienteID, condicionalID: Integer;
  public
    FDQuery3: TFDQuery;
    { Public declarations }

  end;

var
  form_cadastro_condicional: Tform_cadastro_condicional;


implementation

{$R *.dfm}

uses unit_conexao, unit_funcoes;



procedure Tform_cadastro_condicional.btn_fecharClick(Sender: TObject);
begin
self.Close;
end;

procedure Tform_cadastro_condicional.cbb_clientesChange(Sender: TObject);
begin
  // Consulta clientes
  qryClientes.Close;
  qryClientes.SQL.Text := 'SELECT id, nome FROM clientes WHERE nome = :nome';
//  qryClientes.ParamByName('nome').AsString := cbb_clientes.Items[cbb_clientes.ItemIndex];
  qryClientes.Open;

//  edt_cod_clie.Clear;
//  edt_cod_clie.Text := qryClientes.FieldByName('id').AsString;
//  clienteID := StrToIntDef(edt_cod_clie.Text, 0);

  // Consulta condicional
  qryCondicional.Close;
  qryCondicional.SQL.Text :=
    'SELECT id, ID_Cliente, nome_cliente ' +
    'FROM condicional ' +
    'WHERE ID_Cliente = :id_cliente';
  qryCondicional.ParamByName('id_cliente').AsInteger := clienteID;
  qryCondicional.Open;

  condicionalID := qryCondicional.FieldByName('id').AsInteger;

  // Consulta pendente
  qryCondPendente.Close;
  qryCondPendente.SQL.Text :=
    'SELECT * ' +
    'FROM condicionalPendente ' +
    'WHERE id_condicional = :id_condicional';
  qryCondPendente.ParamByName('id_condicional').AsInteger :=
    qryCondicional.FieldByName('id').AsInteger;
  qryCondPendente.Open;
end;

procedure Tform_cadastro_condicional.cbb_produtosChange(Sender: TObject);
begin
  // Consulta produtos
  qryProdutos.Close;
  qryProdutos.SQL.Text := 'SELECT id, nome FROM produtos WHERE nome = :nome';
//  qryProdutos.ParamByName('nome').AsString := cbb_produtos.Items[cbb_produtos.ItemIndex];
  qryProdutos.Open;

 // edt_cod_prod.Clear;
 // edt_cod_prod.Text := qryProdutos.FieldByName('id').AsString;

  // Consulta estoque
  qryEstoque.Close;
  qryEstoque.SQL.Text := 'SELECT quantidade_em_estoque FROM estoque WHERE produto_id = :produto_id';
 // qryEstoque.ParamByName('produto_id').AsInteger := StrToIntDef(edt_cod_prod.Text, 0);
  qryEstoque.Open;

  // Preenche quantidade em estoque
 // if not qryEstoque.FieldByName('quantidade_em_estoque').IsNull then
 //   edt_qtt_estoque.Text := qryEstoque.FieldByName('quantidade_em_estoque').AsString
 // else
 //   edt_qtt_estoque.Clear;
end;

procedure Tform_cadastro_condicional.edt_cod_clieKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if key = VK_RETURN then
 begin
//    cbb_clientes.LoadField(edt_cod_clie.Text);
//    cbb_clientes.OnChange(cbb_clientes);
 end;
end;

procedure Tform_cadastro_condicional.edt_cod_prodKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if key = VK_RETURN then
 begin
//    cbb_produtos.LoadField(edt_cod_prod.Text);
//    cbb_produtos.OnChange(cbb_produtos);
 end;
end;

initialization

RegisterClass(Tform_cadastro_condicional);


end.
