unit unit_conexao_tabelas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, unit_conexao;

type
  Tform_conexao_tabelas = class(TDataModule)
    qryConsultaClientes: TFDQuery;
    DataSourceClientes: TDataSource;
    qryConsultaClientesid: TFDAutoIncField;
    qryConsultaClientescodigo_cliente: TStringField;
    qryConsultaClientesnome: TStringField;
    qryConsultaClientescpf_cnpj: TStringField;
    qryConsultaClientestelefone: TStringField;
    qryConsultaClientesemail: TStringField;
    qryConsultaClientesendereco: TMemoField;
    qryConsultaClientescep: TStringField;
    qryConsultaClientescidade: TStringField;
    qryConsultaClientesestado: TStringField;
    qryConsultaClientesclassificacao: TStringField;
    qryConsultaClienteslimite_credito: TBCDField;
    qryConsultaClientescredito_usado: TBCDField;
    qryConsultaClientesstatus: TStringField;
    qryConsultaClientesdata_nascimento: TDateField;
    qryConsultaClientesobservacoes: TMemoField;
    qryConsultaClientesdata_cadastro: TDateTimeField;
    qryConsultaClientesdata_atualizacao: TDateTimeField;
    qryConsultaClientesusuario_cadastro: TStringField;

    qryConsultaCategorias: TFDQuery;
    DataSourceCategorias: TDataSource;
    qryConsultaCategoriasid: TFDAutoIncField;
    qryConsultaCategoriasnome: TStringField;
    qryConsultaCategoriasdescricao: TMemoField;
    qryConsultaCategoriascategoria_pai_id: TIntegerField;
    qryConsultaCategoriasativo: TBooleanField;
    qryConsultaCategoriasdata_cadastro: TDateTimeField;
    qryConsultaCategoriasdata_atualizacao: TDateTimeField;

    qryConsultaProdutos: TFDQuery;
    DataSourceProdutos: TDataSource;
    qryConsultaProdutosid: TFDAutoIncField;
    qryConsultaProdutoscodigo_produto: TStringField;
    qryConsultaProdutoscodigo_barras: TStringField;
    qryConsultaProdutosnome: TStringField;
    qryConsultaProdutosdescricao: TMemoField;
    qryConsultaProdutoscategoria_id: TIntegerField;
    qryConsultaProdutosmarca: TStringField;
    qryConsultaProdutostamanho: TStringField;
    qryConsultaProdutoscor: TStringField;
    qryConsultaProdutospeso: TBCDField;
    qryConsultaProdutosunidade_medida: TStringField;
    qryConsultaProdutospreco: TBCDField;
    qryConsultaProdutospreco_promocional: TBCDField;
    qryConsultaProdutosativo: TBooleanField;
    qryConsultaProdutosdestaque: TBooleanField;
    qryConsultaProdutosobservacoes: TMemoField;
    qryConsultaProdutosdata_cadastro: TDateTimeField;
    qryConsultaProdutosdata_atualizacao: TDateTimeField;
    qryConsultaProdutosusuario_cadastro: TStringField;

    qryConsultaEstoque: TFDQuery;
    dsEstoque: TDataSource;
    qryConsultaEstoqueid: TFDAutoIncField;
    qryConsultaEstoqueproduto_id: TIntegerField;
    qryConsultaEstoquequantidade_em_estoque: TIntegerField;
    qryConsultaEstoquequantidade_reservada: TIntegerField;
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

    qryConsultaCondicionais: TFDQuery;
    DataSourceCondicionais: TDataSource;
    qryConsultaCondicionaisid: TFDAutoIncField;
    qryConsultaCondicionaisnumero_condicional: TStringField;
    qryConsultaCondicionaiscliente_id: TIntegerField;
    qryConsultaCondicionaisdata_condicional: TDateField;
    qryConsultaCondicionaishora_condicional: TTimeField;
    qryConsultaCondicionaisdata_validade: TDateField;
    qryConsultaCondicionaisvalor_subtotal: TBCDField;
    qryConsultaCondicionaisvalor_desconto: TBCDField;
    qryConsultaCondicionaispercentual_desconto: TBCDField;
    qryConsultaCondicionaisvalor_total: TBCDField;
    qryConsultaCondicionaisstatus: TStringField;
    qryConsultaCondicionaisvendedor: TStringField;
    qryConsultaCondicionaisaprovador: TStringField;
    qryConsultaCondicionaisdata_aprovacao: TDateTimeField;
    qryConsultaCondicionaismotivo_rejeicao: TMemoField;
    qryConsultaCondicionaisobservacoes: TMemoField;
    qryConsultaCondicionaisvenda_gerada_id: TIntegerField;
    qryConsultaCondicionaisdata_cadastro: TDateTimeField;
    qryConsultaCondicionaisdata_atualizacao: TDateTimeField;
    qryConsultaCondicionaisusuario_cadastro: TStringField;

    qryConsultaCondicionaisItens: TFDQuery;
    DataSourceCondicionaisItens: TDataSource;
    qryConsultaCondicionaisItensid: TFDAutoIncField;
    qryConsultaCondicionaisItenscondicional_id: TIntegerField;
    qryConsultaCondicionaisItensproduto_id: TIntegerField;
    qryConsultaCondicionaisItensquantidade: TIntegerField;
    qryConsultaCondicionaisItenspreco_unitario: TBCDField;
    qryConsultaCondicionaisItensdesconto_item: TBCDField;
    qryConsultaCondicionaisItenssubtotal: TBCDField;
    qryConsultaCondicionaisItensobservacao: TStringField;
    qryConsultaCondicionaisItensdata_cadastro: TDateTimeField;

    qryConsultaVendas: TFDQuery;
    DataSourceVendas: TDataSource;
    qryConsultaVendasid: TFDAutoIncField;
    qryConsultaVendascliente_id: TIntegerField;
    qryConsultaVendasnumero_venda: TStringField;
    qryConsultaVendastipo_origem: TStringField;
    qryConsultaVendascondicional_origem_id: TIntegerField;
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

    qryConsultaVendasItens: TFDQuery;
    DataSourceVendasItens: TDataSource;
    qryConsultaVendasItensid: TFDAutoIncField;
    qryConsultaVendasItensvenda_id: TIntegerField;
    qryConsultaVendasItensproduto_id: TIntegerField;
    qryConsultaVendasItensquantidade: TIntegerField;
    qryConsultaVendasItenspreco_unitario: TBCDField;
    qryConsultaVendasItensdesconto_item: TBCDField;
    qryConsultaVendasItenssubtotal: TBCDField;
    qryConsultaVendasItensdata_cadastro: TDateTimeField;
  private
  public
    function GetDataSourceByTableName(const TableName: string): TDataSource;
  end;

var
  form_conexao_tabelas: Tform_conexao_tabelas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}


{$R *.dfm}

function Tform_conexao_tabelas.GetDataSourceByTableName(
  const TableName: string): TDataSource;
begin
  Result := TDataSource(FindComponent('DataSource' + TableName));
end;

end.

