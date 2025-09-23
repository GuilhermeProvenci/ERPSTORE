object form_conexao_tabelas: Tform_conexao_tabelas
  Height = 800
  Width = 1200
  object qryConsultaClientes: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'SELECT * FROM clientes ORDER BY nome')
    Left = 32
    Top = 40
    object qryConsultaClientesid: TFDAutoIncField
      FieldName = 'id'
    end
    object qryConsultaClientescodigo_cliente: TStringField
      FieldName = 'codigo_cliente'
    end
    object qryConsultaClientesnome: TStringField
      FieldName = 'nome'
      Required = True
      Size = 255
    end
    object qryConsultaClientescpf_cnpj: TStringField
      FieldName = 'cpf_cnpj'
    end
    object qryConsultaClientestelefone: TStringField
      FieldName = 'telefone'
      Required = True
      Size = 50
    end
    object qryConsultaClientesemail: TStringField
      FieldName = 'email'
      Size = 255
    end
    object qryConsultaClientesendereco: TMemoField
      FieldName = 'endereco'
      Required = True
      BlobType = ftMemo
    end
    object qryConsultaClientescep: TStringField
      FieldName = 'cep'
      Size = 10
    end
    object qryConsultaClientescidade: TStringField
      FieldName = 'cidade'
      Size = 100
    end
    object qryConsultaClientesestado: TStringField
      FieldName = 'estado'
      Size = 2
    end
    object qryConsultaClientesclassificacao: TStringField
      FieldName = 'classificacao'
      Size = 8
    end
    object qryConsultaClienteslimite_credito: TBCDField
      FieldName = 'limite_credito'
      Precision = 10
      Size = 2
    end
    object qryConsultaClientescredito_usado: TBCDField
      FieldName = 'credito_usado'
      Precision = 10
      Size = 2
    end
    object qryConsultaClientesstatus: TStringField
      FieldName = 'status'
      Size = 8
    end
    object qryConsultaClientesdata_nascimento: TDateField
      FieldName = 'data_nascimento'
    end
    object qryConsultaClientesobservacoes: TMemoField
      FieldName = 'observacoes'
      BlobType = ftMemo
    end
    object qryConsultaClientesdata_cadastro: TDateTimeField
      FieldName = 'data_cadastro'
    end
    object qryConsultaClientesdata_atualizacao: TDateTimeField
      FieldName = 'data_atualizacao'
    end
    object qryConsultaClientesusuario_cadastro: TStringField
      FieldName = 'usuario_cadastro'
      Size = 100
    end
  end
  object DataSourceClientes: TDataSource
    DataSet = qryConsultaClientes
    Left = 160
    Top = 40
  end
  object qryConsultaCategorias: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'SELECT * FROM categorias ORDER BY nome')
    Left = 32
    Top = 120
    object qryConsultaCategoriasid: TFDAutoIncField
      FieldName = 'id'
    end
    object qryConsultaCategoriasnome: TStringField
      FieldName = 'nome'
      Required = True
      Size = 100
    end
    object qryConsultaCategoriasdescricao: TMemoField
      FieldName = 'descricao'
      BlobType = ftMemo
    end
    object qryConsultaCategoriascategoria_pai_id: TIntegerField
      FieldName = 'categoria_pai_id'
    end
    object qryConsultaCategoriasativo: TBooleanField
      FieldName = 'ativo'
    end
    object qryConsultaCategoriasdata_cadastro: TDateTimeField
      FieldName = 'data_cadastro'
    end
    object qryConsultaCategoriasdata_atualizacao: TDateTimeField
      FieldName = 'data_atualizacao'
    end
  end
  object DataSourceCategorias: TDataSource
    DataSet = qryConsultaCategorias
    Left = 160
    Top = 120
  end
  object qryConsultaProdutos: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'SELECT * FROM produtos ORDER BY nome')
    Left = 32
    Top = 200
    object qryConsultaProdutosid: TFDAutoIncField
      FieldName = 'id'
    end
    object qryConsultaProdutoscodigo_produto: TStringField
      FieldName = 'codigo_produto'
      Size = 50
    end
    object qryConsultaProdutoscodigo_barras: TStringField
      FieldName = 'codigo_barras'
      Size = 50
    end
    object qryConsultaProdutosnome: TStringField
      FieldName = 'nome'
      Required = True
      Size = 255
    end
    object qryConsultaProdutosdescricao: TMemoField
      FieldName = 'descricao'
      BlobType = ftMemo
    end
    object qryConsultaProdutoscategoria_id: TIntegerField
      FieldName = 'categoria_id'
    end
    object qryConsultaProdutosmarca: TStringField
      FieldName = 'marca'
      Size = 100
    end
    object qryConsultaProdutostamanho: TStringField
      FieldName = 'tamanho'
      Required = True
      Size = 10
    end
    object qryConsultaProdutoscor: TStringField
      FieldName = 'cor'
      Size = 50
    end
    object qryConsultaProdutospeso: TBCDField
      FieldName = 'peso'
      Precision = 8
      Size = 3
    end
    object qryConsultaProdutosunidade_medida: TStringField
      FieldName = 'unidade_medida'
      Size = 10
    end
    object qryConsultaProdutospreco: TBCDField
      FieldName = 'preco'
      Required = True
      Precision = 10
      Size = 2
    end
    object qryConsultaProdutospreco_promocional: TBCDField
      FieldName = 'preco_promocional'
      Precision = 10
      Size = 2
    end
    object qryConsultaProdutosativo: TBooleanField
      FieldName = 'ativo'
    end
    object qryConsultaProdutosdestaque: TBooleanField
      FieldName = 'destaque'
    end
    object qryConsultaProdutosobservacoes: TMemoField
      FieldName = 'observacoes'
      BlobType = ftMemo
    end
    object qryConsultaProdutosdata_cadastro: TDateTimeField
      FieldName = 'data_cadastro'
    end
    object qryConsultaProdutosdata_atualizacao: TDateTimeField
      FieldName = 'data_atualizacao'
    end
    object qryConsultaProdutosusuario_cadastro: TStringField
      FieldName = 'usuario_cadastro'
      Size = 100
    end
  end
  object DataSourceProdutos: TDataSource
    DataSet = qryConsultaProdutos
    Left = 160
    Top = 200
  end
  object qryConsultaEstoque: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'SELECT * FROM estoque')
    Left = 320
    Top = 40
    object qryConsultaEstoqueid: TFDAutoIncField
      FieldName = 'id'
    end
    object qryConsultaEstoqueproduto_id: TIntegerField
      FieldName = 'produto_id'
      Required = True
    end
    object qryConsultaEstoquequantidade_em_estoque: TIntegerField
      FieldName = 'quantidade_em_estoque'
    end
    object qryConsultaEstoquequantidade_reservada: TIntegerField
      FieldName = 'quantidade_reservada'
    end
    object qryConsultaEstoquequantidade_minima: TIntegerField
      FieldName = 'quantidade_minima'
    end
    object qryConsultaEstoquepreco_custo: TBCDField
      FieldName = 'preco_custo'
      Precision = 10
      Size = 2
    end
    object qryConsultaEstoquepreco_venda: TBCDField
      FieldName = 'preco_venda'
      Precision = 10
      Size = 2
    end
    object qryConsultaEstoquelote: TStringField
      FieldName = 'lote'
      Size = 100
    end
    object qryConsultaEstoquedata_entrada: TDateField
      FieldName = 'data_entrada'
      Required = True
    end
    object qryConsultaEstoquedata_validade: TDateField
      FieldName = 'data_validade'
    end
    object qryConsultaEstoquefornecedor: TStringField
      FieldName = 'fornecedor'
      Size = 255
    end
    object qryConsultaEstoquelocalizacao: TStringField
      FieldName = 'localizacao'
      Size = 100
    end
    object qryConsultaEstoquestatus: TStringField
      FieldName = 'status'
      Size = 9
    end
    object qryConsultaEstoqueobservacoes: TMemoField
      FieldName = 'observacoes'
      BlobType = ftMemo
    end
    object qryConsultaEstoquedata_cadastro: TDateTimeField
      FieldName = 'data_cadastro'
    end
    object qryConsultaEstoquedata_atualizacao: TDateTimeField
      FieldName = 'data_atualizacao'
    end
    object qryConsultaEstoqueusuario_cadastro: TStringField
      FieldName = 'usuario_cadastro'
      Size = 100
    end
  end
  object dsEstoque: TDataSource
    DataSet = qryConsultaEstoque
    Left = 448
    Top = 40
  end
  object qryConsultaCondicionais: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'SELECT * FROM condicionais ORDER BY data_condicional DESC')
    Left = 320
    Top = 120
    object qryConsultaCondicionaisid: TFDAutoIncField
      FieldName = 'id'
    end
    object qryConsultaCondicionaisnumero_condicional: TStringField
      FieldName = 'numero_condicional'
      Required = True
    end
    object qryConsultaCondicionaiscliente_id: TIntegerField
      FieldName = 'cliente_id'
      Required = True
    end
    object qryConsultaCondicionaisdata_condicional: TDateField
      FieldName = 'data_condicional'
      Required = True
    end
    object qryConsultaCondicionaishora_condicional: TTimeField
      FieldName = 'hora_condicional'
    end
    object qryConsultaCondicionaisdata_validade: TDateField
      FieldName = 'data_validade'
      Required = True
    end
    object qryConsultaCondicionaisvalor_subtotal: TBCDField
      FieldName = 'valor_subtotal'
      Precision = 10
      Size = 2
    end
    object qryConsultaCondicionaisvalor_desconto: TBCDField
      FieldName = 'valor_desconto'
      Precision = 10
      Size = 2
    end
    object qryConsultaCondicionaispercentual_desconto: TBCDField
      FieldName = 'percentual_desconto'
      Precision = 5
      Size = 2
    end
    object qryConsultaCondicionaisvalor_total: TBCDField
      FieldName = 'valor_total'
      Precision = 10
      Size = 2
    end
    object qryConsultaCondicionaisstatus: TStringField
      FieldName = 'status'
      Size = 9
    end
    object qryConsultaCondicionaisvendedor: TStringField
      FieldName = 'vendedor'
      Size = 100
    end
    object qryConsultaCondicionaisaprovador: TStringField
      FieldName = 'aprovador'
      Size = 100
    end
    object qryConsultaCondicionaisdata_aprovacao: TDateTimeField
      FieldName = 'data_aprovacao'
    end
    object qryConsultaCondicionaismotivo_rejeicao: TMemoField
      FieldName = 'motivo_rejeicao'
      BlobType = ftMemo
    end
    object qryConsultaCondicionaisobservacoes: TMemoField
      FieldName = 'observacoes'
      BlobType = ftMemo
    end
    object qryConsultaCondicionaisvenda_gerada_id: TIntegerField
      FieldName = 'venda_gerada_id'
    end
    object qryConsultaCondicionaisdata_cadastro: TDateTimeField
      FieldName = 'data_cadastro'
    end
    object qryConsultaCondicionaisdata_atualizacao: TDateTimeField
      FieldName = 'data_atualizacao'
    end
    object qryConsultaCondicionaisusuario_cadastro: TStringField
      FieldName = 'usuario_cadastro'
      Size = 100
    end
  end
  object DataSourceCondicionais: TDataSource
    DataSet = qryConsultaCondicionais
    Left = 448
    Top = 120
  end
  object qryConsultaCondicionaisItens: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'SELECT * FROM condicionais_itens'
      'WHERE condicional_id = :condicional_id')
    Left = 320
    Top = 200
    object qryConsultaCondicionaisItensid: TFDAutoIncField
      FieldName = 'id'
    end
    object qryConsultaCondicionaisItenscondicional_id: TIntegerField
      FieldName = 'condicional_id'
      Required = True
    end
    object qryConsultaCondicionaisItensproduto_id: TIntegerField
      FieldName = 'produto_id'
      Required = True
    end
    object qryConsultaCondicionaisItensquantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object qryConsultaCondicionaisItenspreco_unitario: TBCDField
      FieldName = 'preco_unitario'
      Required = True
      Precision = 10
      Size = 2
    end
    object qryConsultaCondicionaisItensdesconto_item: TBCDField
      FieldName = 'desconto_item'
      Precision = 10
      Size = 2
    end
    object qryConsultaCondicionaisItenssubtotal: TBCDField
      FieldName = 'subtotal'
      Required = True
      Precision = 10
      Size = 2
    end
    object qryConsultaCondicionaisItensobservacao: TStringField
      FieldName = 'observacao'
      Size = 255
    end
    object qryConsultaCondicionaisItensdata_cadastro: TDateTimeField
      FieldName = 'data_cadastro'
    end
  end
  object DataSourceCondicionaisItens: TDataSource
    DataSet = qryConsultaCondicionaisItens
    Left = 448
    Top = 200
  end
  object qryConsultaVendas: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'SELECT * FROM vendas ORDER BY data_venda DESC')
    Left = 600
    Top = 40
    object qryConsultaVendasid: TFDAutoIncField
      FieldName = 'id'
    end
    object qryConsultaVendascliente_id: TIntegerField
      FieldName = 'cliente_id'
      Required = True
    end
    object qryConsultaVendasnumero_venda: TStringField
      FieldName = 'numero_venda'
      Required = True
    end
    object qryConsultaVendastipo_origem: TStringField
      FieldName = 'tipo_origem'
      Size = 11
    end
    object qryConsultaVendascondicional_origem_id: TIntegerField
      FieldName = 'condicional_origem_id'
    end
    object qryConsultaVendasdata_venda: TDateField
      FieldName = 'data_venda'
      Required = True
    end
    object qryConsultaVendashora_venda: TTimeField
      FieldName = 'hora_venda'
    end
    object qryConsultaVendasvalor_subtotal: TBCDField
      FieldName = 'valor_subtotal'
      Precision = 10
      Size = 2
    end
    object qryConsultaVendasvalor_desconto: TBCDField
      FieldName = 'valor_desconto'
      Precision = 10
      Size = 2
    end
    object qryConsultaVendaspercentual_desconto: TBCDField
      FieldName = 'percentual_desconto'
      Precision = 5
      Size = 2
    end
    object qryConsultaVendasvalor_total: TBCDField
      FieldName = 'valor_total'
      Precision = 10
      Size = 2
    end
    object qryConsultaVendasforma_pagamento: TStringField
      FieldName = 'forma_pagamento'
      Required = True
      Size = 14
    end
    object qryConsultaVendasstatus_venda: TStringField
      FieldName = 'status_venda'
      Size = 9
    end
    object qryConsultaVendasvendedor: TStringField
      FieldName = 'vendedor'
      Size = 100
    end
    object qryConsultaVendasobservacoes: TMemoField
      FieldName = 'observacoes'
      BlobType = ftMemo
    end
    object qryConsultaVendasdata_cadastro: TDateTimeField
      FieldName = 'data_cadastro'
    end
    object qryConsultaVendasdata_atualizacao: TDateTimeField
      FieldName = 'data_atualizacao'
    end
    object qryConsultaVendasusuario_cadastro: TStringField
      FieldName = 'usuario_cadastro'
      Size = 100
    end
  end
  object DataSourceVendas: TDataSource
    DataSet = qryConsultaVendas
    Left = 728
    Top = 40
  end
  object qryConsultaVendasItens: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'SELECT * FROM vendas_itens'
      'WHERE venda_id = :venda_id')
    Left = 600
    Top = 120
    object qryConsultaVendasItensid: TFDAutoIncField
      FieldName = 'id'
    end
    object qryConsultaVendasItensvenda_id: TIntegerField
      FieldName = 'venda_id'
      Required = True
    end
    object qryConsultaVendasItensproduto_id: TIntegerField
      FieldName = 'produto_id'
      Required = True
    end
    object qryConsultaVendasItensquantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object qryConsultaVendasItenspreco_unitario: TBCDField
      FieldName = 'preco_unitario'
      Required = True
      Precision = 10
      Size = 2
    end
    object qryConsultaVendasItensdesconto_item: TBCDField
      FieldName = 'desconto_item'
      Precision = 10
      Size = 2
    end
    object qryConsultaVendasItenssubtotal: TBCDField
      FieldName = 'subtotal'
      Required = True
      Precision = 10
      Size = 2
    end
    object qryConsultaVendasItensdata_cadastro: TDateTimeField
      FieldName = 'data_cadastro'
    end
  end
  object DataSourceVendasItens: TDataSource
    DataSet = qryConsultaVendasItens
    Left = 728
    Top = 120
  end
end
