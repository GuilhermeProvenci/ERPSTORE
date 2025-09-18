unit unit_cadastro_estoque;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_cadastro_padrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, uEstoque;
type
  Tform_cadastro_estoque = class(TfrmBaseRegister)
    pnl_produto: TPanel;
    lbl_produto: TLabel;
    cmbProduto_id: TDBLookupComboBox;
    pnl_barra_produto: TPanel;
    pnl_quantidade: TPanel;
    lbl_quantidade: TLabel;
    edtQuantidade_em_estoque: TEdit;
    pnl_barra_quantidade: TPanel;
    pnl_preco_custo: TPanel;
    lbl_preco_custo: TLabel;
    edtPreco_Custo: TEdit;
    pnl_barra_preco_custo: TPanel;
    pnl_lote: TPanel;
    lbl_lote: TLabel;
    edtLote: TEdit;
    pnl_barra_lote: TPanel;
    pnl_data_entrada: TPanel;
    lbl_data_entrada: TLabel;
    dtpData_Entrada: TDateTimePicker;
    pnl_barra_data_entrada: TPanel;
    pnl_validade: TPanel;
    lbl_validade: TLabel;
    dtpData_Validade: TDateTimePicker;
    pnl_barra_validade: TPanel;
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

uses unit_conexao;

{$R *.dfm}


procedure Tform_cadastro_estoque.FormCreate(Sender: TObject);
var
  Estoque: TEstoque;
begin
  inherited;

  Estoque := TEstoque.Create;
  // datasource do objeto (tem o ProdutoId)
  dsEstoque := Estoque.CreateDataSource(Self);

  cmbProduto_id.ListSource := TEstoque.CreateProdutosDataSource(Self, form_conexao.FDConnection);
  cmbProduto_id.ListField  := 'NOME';
  cmbProduto_id.KeyField   := 'ID';

  cmbProduto_id.DataSource := dsEstoque;
  cmbProduto_id.DataField  := 'Produto_Id';

end;

initialization
  Tform_cadastro_estoque.ClassName;
end.
