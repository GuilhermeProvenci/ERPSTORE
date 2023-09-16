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
    lbl_informacao1: TLabel;
    lbl_informacao2: TLabel;
    pnl_topo: TPanel;
    lbl_titulo: TLabel;
    btn_fechar: TSpeedButton;
    pnl_separador_topo: TPanel;
    edt_qtt: TNumberBox;
    lbl_informacao3: TLabel;
    pnl_add: TPanel;
    edt_cod_clie: TEdit;
    edt_cod_prod: TEdit;
    qryProdutos: TFDQuery;
    cbb_produtos: TComboBox;
    cbb_clientes: TComboBox;
    qryClientes: TFDQuery;
    Label2: TLabel;
    edt_qtt_estoque: TEdit;
    dbg_registros: TDBGrid;
    dsCondPendente: TDataSource;
    qryCondPendente: TFDQuery;
    pnl_registros: TPanel;
    qryCond: TFDQuery;
    dsCond: TDataSource;
    qryCondid: TFDAutoIncField;
    qryCondcliente_id: TIntegerField;
    qryConddata_entregue: TDateTimeField;
    qryConddata_devolucao: TDateTimeField;
    qryCondnome_cliente: TStringField;
    procedure btn_fecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbb_produtosChange(Sender: TObject);
    procedure cbb_clientesChange(Sender: TObject);
    procedure pnl_addClick(Sender: TObject);
  private
    { Private declarations }
  public
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


  with qryClientes do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT id, nome FROM clientes WHERE nome = :nome');
    ParamByName('nome').Value := cbb_clientes.Items[cbb_clientes.ItemIndex];
    Open;
  end;
  edt_cod_clie.Clear;
  edt_cod_clie.Text := qryClientes.FieldByName('id').AsString;



with qryCond do
begin
  close;
  sql.Clear;
  sql.add('Select id, cliente_id, data_entregue, data_devolucao, nome_cliente from condicional where cliente_id = :id');
  ParamByName('id').DataType := ftInteger;
  ParamByName('id').Value := strtoint(edt_cod_clie.Text);
  open;
end;

with qryCondPendente do //tem que ter algo pendente já, ai é foda
begin
  close;
  sql.Clear;
  sql.add('Select * from condicional_pendente where id_condicional = :id');
  ParamByName('id').Value := qryCond.FieldByName('id').Value;
  open;
end;

end;

procedure Tform_cadastro_condicional.cbb_produtosChange(Sender: TObject);
begin
  with qryProdutos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT id, nome FROM produtos WHERE nome = :nome');
    ParamByName('nome').Value := cbb_produtos.Items[cbb_produtos.ItemIndex];
    Open;
  end;
  edt_cod_prod.Clear;
  edt_cod_prod.Text := qryProdutos.FieldByName('id').AsString;


  with form_conexao_tabelas.qryConsultaEstoque do
  begin
    close;
    sql.clear;
    sql.Add('Select * from estoque where produto_id = :id');
    ParamByName('id').Value := strtoint(edt_cod_prod.Text);
    open;
  end;


  edt_qtt_estoque.Clear;
  edt_qtt_estoque.Text := form_conexao_tabelas.qryConsultaEstoque.FieldByName('quantidade_em_estoque').AsString;
end;

procedure Tform_cadastro_condicional.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
form_conexao_tabelas.qryConsultaClientes.Active := false;
form_conexao_tabelas.qryConsultaProdutos.Active := false;
form_conexao_tabelas.qryConsultaEstoque.Active := false;
FreeAndNil(form_cadastro_condicional);
end;

procedure Tform_cadastro_condicional.FormCreate(Sender: TObject);
var
i, j : integer;
begin
  form_conexao_tabelas.qryConsultaClientes.Active := true;
  form_conexao_tabelas.qryConsultaProdutos.Active := true;
  form_conexao_tabelas.qryConsultaEstoque.Active := true;


for I := 0 to form_conexao_tabelas.qryConsultaProdutos.RecordCount - 1 do
begin
  cbb_produtos.Items.Add(form_conexao_tabelas.qryConsultaProdutos.FieldByName('nome').AsString);
  form_conexao_tabelas.qryConsultaProdutos.Next;
end;

 for j := 0 to form_conexao_tabelas.qryConsultaClientes.RecordCount - 1 do
begin
  cbb_clientes.Items.Add(form_conexao_tabelas.qryConsultaClientes.FieldByName('nome').AsString);
  form_conexao_tabelas.qryConsultaClientes.Next;
end;


end;

procedure Tform_cadastro_condicional.pnl_addClick(Sender: TObject);
 var
saldoEstoque : integer;
qryInsertCond: TFDQuery;
begin

qryInsertCond := TFDQuery.Create(NIL);


    form_conexao_tabelas.qryConsultaEstoque.close;
    form_conexao_tabelas.qryConsultaEstoque.SQL.Clear;
    form_conexao_tabelas.qryConsultaEstoque.SQL.Text := 'SELECT quantidade_em_estoque FROM estoque WHERE produto_id = :id';
    form_conexao_tabelas.qryConsultaEstoque.ParamByName('id').AsInteger := strtoint(edt_cod_prod.Text);
    form_conexao_tabelas.qryConsultaEstoque.Open;

    if not form_conexao_tabelas.qryConsultaEstoque.IsEmpty then
    begin
      // Obtenha o saldo em estoque do produto
       saldoEstoque := form_conexao_tabelas.qryConsultaEstoque.FieldByName('quantidade_em_estoque').AsInteger;

       qryInsertCond.Close;
       qryInsertCond.Connection := form_conexao.FDConnection;
       qryInsertCond.SQL.Text :=
          'INSERT INTO condicional_pendente (id_produto, nome_produto, quantidade_condicional, id_condicional, nome_cliente) ' +
          'VALUES (:id_produto, :nome_produto, :quantidade_condicional, :id_condicional, :nome_cliente)';

        qryInsertCond.ParamByName('id_produto').AsInteger := strtoint(edt_cod_prod.Text);
        qryInsertCond.ParamByName('nome_produto').AsString := cbb_produtos.Items[cbb_produtos.ItemIndex];
        qryInsertCond.ParamByName('quantidade_condicional').AsInteger := trunc(edt_qtt.Value);
        qryInsertCond.ParamByName('id_condicional').AsInteger := qryCond.FieldByName('id').Value;
        qryInsertCond.ParamByName('nome_cliente').AsString := qryClientes.FieldByName('nome').asstring;
        qryInsertCond.ExecSQL;
        CriarMensagem('aviso','Inserção realizada com sucesso!');
        qryCondPendente.Refresh;
        qryInsertCond.Free;
    end
    else
    begin
    CriarMensagem('aviso','Produto não encontrado.');
    exit;
    end;


   with form_conexao_tabelas.qryConsultaEstoque do
   begin
     close;
     sql.clear;
     sql.Add('UPDATE estoque SET quantidade_em_estoque = :novo_saldo WHERE id = :id_produto');
     ParamByName('novo_saldo').value := saldoEstoque - edt_qtt.value;
     ParamByName('id_produto').Value := strtoint(edt_cod_prod.Text);
     ExecSQL;
   end;



end;


end.
