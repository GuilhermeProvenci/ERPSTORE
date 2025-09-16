unit unit_conexao_tabelas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  Tform_conexao_tabelas = class(TDataModule)
    qryConsultaClientes: TFDQuery;
    qryConsultaProdutos: TFDQuery;
    qryConsultaCST: TFDQuery;
    qryConsultaCSTID_CST: TIntegerField;
    qryConsultaCSTFG_TIPO: TStringField;
    qryConsultaCSTCD_CST: TStringField;
    qryConsultaCSTDS_CST: TStringField;
    qryConsultaClientesid: TFDAutoIncField;
    qryConsultaClientesnome: TStringField;
    qryConsultaClientestelefone: TStringField;
    qryConsultaClientesendereco: TStringField;
    DataSourceClientes: TDataSource;
    DataSourceProdutos: TDataSource;
    DataSourceCondicional: TDataSource;
    qryConsultaEstoque: TFDQuery;
    dsEstoque: TDataSource;
    qryConsultaCondicional: TFDQuery;
    qryConsultaProdutosid: TFDAutoIncField;
    qryConsultaProdutosnome: TStringField;
    qryConsultaProdutostamanho: TStringField;
    qryConsultaProdutospreco: TBCDField;
    qryConsultaClientesclassificacao: TStringField;
    qryConsultaCondicionalID: TFDAutoIncField;
    qryConsultaCondicionalID_Cliente: TIntegerField;
    qryConsultaCondicionalNome_Cliente: TStringField;
    qryConsultaVendas: TFDQuery;
    DataSourceVendas: TDataSource;
    qryConsultaCondicionalPendente: TFDQuery;
    DataSourceCondicionalPendente: TDataSource;
    qryConsultaCondicionalPendenteid: TFDAutoIncField;
    qryConsultaCondicionalPendentenome: TStringField;
    qryConsultaCondicionalPendenteid_produto: TIntegerField;
    qryConsultaCondicionalPendenteNome_1: TStringField;
    qryConsultaCondicionalPendentequantidade: TIntegerField;
    qryConsultaCondicionalPendenteobservacao: TStringField;
    qryConsultaEstoqueid: TFDAutoIncField;
    qryConsultaEstoqueproduto_id: TIntegerField;
    qryConsultaEstoquequantidade_em_estoque: TIntegerField;
    qryConsultaEstoquequantidade_minima: TIntegerField;
    qryConsultaEstoquepreco_custo: TBCDField;
    qryConsultaEstoquepreco_venda: TBCDField;
    qryConsultaEstoquelote: TStringField;
    qryConsultaEstoquedata_entrada: TDateField;
    qryConsultaEstoquedata_validade: TDateField;
    qryConsultaEstoquefornecedor: TStringField;
    qryConsultaEstoquelocalizacao: TStringField;
    qryConsultaEstoquestatus: TStringField;
    qryConsultaEstoqueobservacoes: TMemoField;
    qryConsultaEstoquedata_cadastro: TDateTimeField;
    qryConsultaEstoquedata_atualizacao: TDateTimeField;
    qryConsultaEstoqueusuario_cadastro: TStringField;
    qryConsultaVendasid: TFDAutoIncField;
    qryConsultaVendascliente_id: TIntegerField;
    qryConsultaVendasnumero_venda: TStringField;
    qryConsultaVendasdata_venda: TDateField;
    qryConsultaVendashora_venda: TTimeField;
    qryConsultaVendasvalor_subtotal: TBCDField;
    qryConsultaVendasvalor_desconto: TBCDField;
    qryConsultaVendaspercentual_desconto: TBCDField;
    qryConsultaVendasvalor_total: TBCDField;
    qryConsultaVendasforma_pagamento: TStringField;
    qryConsultaVendasstatus_venda: TStringField;
    qryConsultaVendasvendedor: TStringField;
    qryConsultaVendasobservacoes: TMemoField;
    qryConsultaVendasdata_cadastro: TDateTimeField;
    qryConsultaVendasdata_atualizacao: TDateTimeField;
    qryConsultaVendasusuario_cadastro: TStringField;
    procedure qryConsultaCSTBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    sTipoCST: String;{ Public declarations }
    function GetDataSourceByTableName(const TableName: string): TDataSource;
  end;

var
  form_conexao_tabelas: Tform_conexao_tabelas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses unit_conexao;

{$R *.dfm}

function Tform_conexao_tabelas.GetDataSourceByTableName(
  const TableName: string): TDataSource;
begin
  Result := TDataSource(FindComponent('DataSource' + TableName));
end;

procedure Tform_conexao_tabelas.qryConsultaCSTBeforeOpen(DataSet: TDataSet);
begin
  qryConsultaCST.ParamByName('p_fg_tipo').AsString := sTipoCST;
end;

end.
