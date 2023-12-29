unit unit_cadastro_condicional;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.NumberBox, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, unit_conexao_tabelas, Vcl.Grids,
  Vcl.DBGrids, gplQry, gplEdit, gplCombo;

type
  Tform_cadastro_condicional = class(TForm)
    pnl_fundo: TPanel;
    lbl_cliente: TLabel;
    lbl_produtos: TLabel;
    pnl_topo: TPanel;
    lbl_titulo: TLabel;
    btn_fechar: TSpeedButton;
    pnl_separador_topo: TPanel;
    edt_qtt: TNumberBox;
    lbl_qtt: TLabel;
    pnl_add: TPanel;
    edt_cod_clie: TEdit;
    edt_cod_prod: TEdit;
    lbl_qtt_estoque: TLabel;
    edt_qtt_estoque: TEdit;
    dbg_registros: TDBGrid;
    pnl_registros: TPanel;
    pnl_remover: TPanel;
    pnl_campos: TPanel;
    Splitter1: TSplitter;
    edt_obs: TgpEdit;
    lbl_obs: TLabel;
    cbb_clientes: TgpCombo;
    cbb_produtos: TgpCombo;
    procedure btn_fecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbb_produtosChange(Sender: TObject);
    procedure cbb_clientesChange(Sender: TObject);
    procedure pnl_addClick(Sender: TObject);
    procedure pnl_removerClick(Sender: TObject);
    procedure edt_cod_clieKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_cod_prodKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    qryClientes, qryProdutos, qryEstoque, qryCondicional,qryCondPendente  :   TgpQry;
    clienteID, condicionalID: Integer;
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

  qryClientes.SQLExec('SELECT id, nome FROM clientes WHERE nome = :1',
  [cbb_clientes.Items[cbb_clientes.ItemIndex]]);

  edt_cod_clie.Clear;
  edt_cod_clie.Text := qryClientes.FieldByName('id').AsString;
  clienteID := StrToIntDef(edt_cod_clie.Text, 0);

  qryCondicional.SQLExec('Select id, ID_Cliente, nome_cliente from condicional where ID_Cliente = :1',
  [clienteID]);

  condicionalID := qryCondicional.FieldByName('id').AsInteger;

  qryCondPendente.SQLExec('Select * from condicionalPendente where id_condicional = :1',
                          [qryCondicional.FieldByName('id').AsInteger]);

end;


procedure Tform_cadastro_condicional.cbb_produtosChange(Sender: TObject);
begin

  qryProdutos.SQLExec('SELECT id, nome FROM produtos WHERE nome = :1',
  [cbb_produtos.Items[cbb_produtos.ItemIndex]]);

  edt_cod_prod.Clear;
  edt_cod_prod.Text := qryProdutos.FieldByName('id').AsString;

  qryEstoque.SQLExec('SELECT * FROM estoque WHERE produto_id = :1',[edt_cod_prod.Text]);

  if qryEstoque.FieldByName('quantidade_em_estoque').AsString <> '' then
    edt_qtt_estoque.Text := qryEstoque.FieldByName('quantidade_em_estoque').AsString
  else
  edt_qtt_estoque.Clear;
end;

procedure Tform_cadastro_condicional.edt_cod_clieKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if key = VK_RETURN then
 begin
    cbb_clientes.LoadField(edt_cod_clie.Text);
    cbb_clientes.OnChange(cbb_clientes);
 end;
end;

procedure Tform_cadastro_condicional.edt_cod_prodKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if key = VK_RETURN then
 begin
    cbb_produtos.LoadField(edt_cod_prod.Text);
    cbb_produtos.OnChange(cbb_produtos);
 end;
end;

procedure Tform_cadastro_condicional.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
FreeAndNil(qryClientes);
FreeAndNil(qryProdutos);
FreeAndNil(qryEstoque);
FreeAndNil(qryCondicional);
FreeAndNil(qryCondPendente);
FreeAndNil(form_cadastro_condicional);
end;

procedure Tform_cadastro_condicional.FormCreate(Sender: TObject);
begin

qryClientes := TgpQry.Create(self);
qryProdutos := TgpQry.Create(self);
qryEstoque := TgpQry.Create(self);
qryCondicional:= TgpQry.Create(self);
qryCondPendente:= TgpQry.Create(self);

cbb_clientes.LoadField('');
cbb_clientes.OnChange(cbb_clientes);
cbb_produtos.LoadField('');
cbb_produtos.OnChange(cbb_produtos);

end;

procedure Tform_cadastro_condicional.pnl_removerClick(Sender: TObject);

begin
 // Verifica se há um registro selecionado no TDBGrid
  if not qryCondPendente.IsEmpty then
  begin
    // Obtém o ID do registro selecionado
    var ID: Integer := qryCondPendente.FieldByName('id').AsInteger;

    // Desfaz a transação removendo o registro da tabela condicional_pendente
    with TgpQry.Create(nil) do
    begin
      SQLExec('DELETE FROM condicional_pendente WHERE id = :1', [ID.ToString]);
      Free;
    end;

    // Atualiza o saldo do estoque desfazendo a quantidade condicional
    with qryEstoque do
    begin
      SQLExec('UPDATE estoque SET quantidade_em_estoque = quantidade_em_estoque + :1 WHERE id = :2', [qryCondPendente.FieldByName('quantidade_condicional').ToString, qryCondPendente.FieldByName('id_produto').ToString] );
    end;

    // Recarrega os dados do TDBGrid
    qryCondPendente.Refresh;

    CriarMensagem('aviso', 'Registro removido com sucesso!');
  end
  else
  begin
    CriarMensagem('aviso', 'Nenhum registro selecionado para remover.');
  end;
end;

procedure Tform_cadastro_condicional.pnl_addClick(Sender: TObject);
var
  saldoEstoque: Integer;
begin
//reajustar toda o lógica, trabalhar com Transaction


  qryEstoque.SQLExec('SELECT id, produto_id, nome_produto, quantidade_em_estoque FROM estoque WHERE produto_id = :1', [edt_cod_prod.Text]);

  if not qryEstoque.IsEmpty then
  begin
    // Obtenha o saldo em estoque do produto
    saldoEstoque := qryEstoque.FieldByName('quantidade_em_estoque').AsInteger;

    qryCondPendente.SQLExec(
      'INSERT INTO condicional_pendente (id_produto, nome_produto, quantidade_condicional, id_condicional, nome_cliente) ' +
      'VALUES (:1, :2, :3, :4, :5)',
      [edt_cod_prod.Text, cbb_produtos.Items[cbb_produtos.ItemIndex],
       edt_qtt.Text, condicionalID, qryClientes.FieldByName('nome').AsString]);

    qryEstoque.SQLExec(
      'UPDATE estoque SET quantidade_em_estoque = :1 WHERE id = :2',
      [saldoEstoque - edt_qtt.Value, edt_cod_prod.Text]
    );

    CriarMensagem('aviso', 'Inserção realizada com sucesso!');
    qryCondPendente.Refresh;
    dbg_registros.Refresh;
  end
  else
  begin
    CriarMensagem('aviso', 'Produto não encontrado.');
    Exit;
  end;
end;



initialization

RegisterClass(Tform_cadastro_condicional);


end.
