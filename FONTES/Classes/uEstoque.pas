unit uEstoque;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, uBaseClass;

type
  TEstoque = class(TBaseObject)
  private
    FProduto_Id: Integer;
    FQuantidade_Em_Estoque: Integer;
    FQuantidade_Minima: Integer;
    FPreco_Custo: Currency;
    FPreco_Venda: Currency;
    FLote: string;
    FData_Entrada: TDate;
    FData_Validade: TDate;
    FFornecedor: string;
    FLocalizacao: string;
    FStatus: string;
    FObservacoes: string;
    FUsuario_Cadastro: string;
  protected
    function GetTableName: string; override;
  public
    property Produto_Id: Integer read FProduto_Id write FProduto_Id;
    property Quantidade_Em_Estoque: Integer read FQuantidade_Em_Estoque write FQuantidade_Em_Estoque;
    property Quantidade_Minima: Integer read FQuantidade_Minima write FQuantidade_Minima;
    property Preco_Custo: Currency read FPreco_Custo write FPreco_Custo;
    property Preco_Venda: Currency read FPreco_Venda write FPreco_Venda;
    property Lote: string read FLote write FLote;
    property Data_Entrada: TDate read FData_Entrada write FData_Entrada;
    property Data_Validade: TDate read FData_Validade write FData_Validade;
    property Fornecedor: string read FFornecedor write FFornecedor;
    property Localizacao: string read FLocalizacao write FLocalizacao;
    property Status: string read FStatus write FStatus;
    property Observacoes: string read FObservacoes write FObservacoes;
    property Usuario_Cadastro: string read FUsuario_Cadastro write FUsuario_Cadastro;

    class function CreateProdutosDataSource(AOwner: TComponent; AConnection: TFDConnection): TDataSource;
    function CreateDataSource(AOwner: TComponent): TDataSource;
  end;

implementation

function TEstoque.GetTableName: string;
begin
  Result := 'estoque';
end;

class function TEstoque.CreateProdutosDataSource(AOwner: TComponent; AConnection: TFDConnection): TDataSource;
var
  qry: TFDQuery;
  ds: TDataSource;
begin
  qry := TFDQuery.Create(AOwner);
  qry.Connection := AConnection;
  qry.SQL.Text := 'SELECT ID, NOME FROM PRODUTOS ORDER BY NOME';
  qry.Open;

  ds := TDataSource.Create(AOwner);
  ds.DataSet := qry;

  Result := ds;
end;

function TEstoque.CreateDataSource(AOwner: TComponent): TDataSource;
var
  mem: TFDMemTable;
  ds: TDataSource;
begin
  mem := TFDMemTable.Create(AOwner);

  mem.FieldDefs.Add('Produto_Id', ftInteger);
  mem.FieldDefs.Add('Quantidade_Em_Estoque', ftInteger);
  mem.FieldDefs.Add('Quantidade_Minima', ftInteger);
  mem.FieldDefs.Add('Preco_Custo', ftCurrency);
  mem.FieldDefs.Add('Preco_Venda', ftCurrency);
  mem.FieldDefs.Add('Lote', ftString, 50);
  mem.FieldDefs.Add('Data_Entrada', ftDate);
  mem.FieldDefs.Add('Data_Validade', ftDate);
  mem.FieldDefs.Add('Fornecedor', ftString, 100);
  mem.FieldDefs.Add('Localizacao', ftString, 50);
  mem.FieldDefs.Add('Status', ftString, 20);
  mem.FieldDefs.Add('Observacoes', ftString, 200);
  mem.FieldDefs.Add('Usuario_Cadastro', ftString, 50);

  mem.CreateDataSet;

  mem.Append;
  mem.FieldByName('Produto_Id').AsInteger := FProduto_Id;
  mem.FieldByName('Quantidade_Em_Estoque').AsInteger := FQuantidade_Em_Estoque;
  mem.FieldByName('Quantidade_Minima').AsInteger := FQuantidade_Minima;
  mem.FieldByName('Preco_Custo').AsCurrency := FPreco_Custo;
  mem.FieldByName('Preco_Venda').AsCurrency := FPreco_Venda;
  mem.FieldByName('Lote').AsString := FLote;
  mem.FieldByName('Data_Entrada').AsDateTime := FData_Entrada;
  mem.FieldByName('Data_Validade').AsDateTime := FData_Validade;
  mem.FieldByName('Fornecedor').AsString := FFornecedor;
  mem.FieldByName('Localizacao').AsString := FLocalizacao;
  mem.FieldByName('Status').AsString := FStatus;
  mem.FieldByName('Observacoes').AsString := FObservacoes;
  mem.FieldByName('Usuario_Cadastro').AsString := FUsuario_Cadastro;
  mem.Post;

  ds := TDataSource.Create(AOwner);
  ds.DataSet := mem;

  Result := ds;
end;

initialization
  TEstoque.ClassName;

end.

