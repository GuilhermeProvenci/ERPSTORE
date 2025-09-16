object form_conexao_tabelas: Tform_conexao_tabelas
  Height = 485
  Width = 871
  object qryConsultaClientes: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'select *'
      'from clientes'
      '')
    Left = 32
    Top = 40
    object qryConsultaClientesid: TFDAutoIncField
      FieldName = 'id'
    end
    object qryConsultaClientesnome: TStringField
      FieldName = 'nome'
      Required = True
      Size = 255
    end
    object qryConsultaClientestelefone: TStringField
      FieldName = 'telefone'
      Size = 15
    end
    object qryConsultaClientesendereco: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'endereco'
      Origin = 'endereco'
      Size = 255
    end
    object qryConsultaClientesclassificacao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'classificacao'
      Origin = 'classificacao'
      Size = 10
    end
  end
  object qryConsultaProdutos: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'select *'
      'from produtos'
      ''
      '')
    Left = 40
    Top = 112
    object qryConsultaProdutosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryConsultaProdutosnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 255
    end
    object qryConsultaProdutostamanho: TStringField
      FieldName = 'tamanho'
      Origin = 'tamanho'
      Required = True
      Size = 5
    end
    object qryConsultaProdutospreco: TBCDField
      FieldName = 'preco'
      Origin = 'preco'
      Required = True
      Precision = 10
      Size = 2
    end
  end
  object qryConsultaEstoque: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'select * from estoque')
    Left = 360
    Top = 40
    object qryConsultaEstoqueid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryConsultaEstoqueproduto_id: TIntegerField
      FieldName = 'produto_id'
      Origin = 'produto_id'
      Required = True
    end
    object qryConsultaEstoquequantidade_em_estoque: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade_em_estoque'
      Origin = 'quantidade_em_estoque'
    end
    object qryConsultaEstoquequantidade_minima: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade_minima'
      Origin = 'quantidade_minima'
    end
    object qryConsultaEstoquepreco_custo: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'preco_custo'
      Origin = 'preco_custo'
      Precision = 10
      Size = 2
    end
    object qryConsultaEstoquepreco_venda: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'preco_venda'
      Origin = 'preco_venda'
      Precision = 10
      Size = 2
    end
    object qryConsultaEstoquelote: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'lote'
      Origin = 'lote'
      Size = 100
    end
    object qryConsultaEstoquedata_entrada: TDateField
      FieldName = 'data_entrada'
      Origin = 'data_entrada'
      Required = True
    end
    object qryConsultaEstoquedata_validade: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'data_validade'
      Origin = 'data_validade'
    end
    object qryConsultaEstoquefornecedor: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'fornecedor'
      Origin = 'fornecedor'
      Size = 255
    end
    object qryConsultaEstoquelocalizacao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'localizacao'
      Origin = 'localizacao'
      Size = 100
    end
    object qryConsultaEstoquestatus: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'status'
      Origin = 'status'
      FixedChar = True
      Size = 9
    end
    object qryConsultaEstoqueobservacoes: TMemoField
      AutoGenerateValue = arDefault
      FieldName = 'observacoes'
      Origin = 'observacoes'
      BlobType = ftMemo
    end
    object qryConsultaEstoquedata_cadastro: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'data_cadastro'
      Origin = 'data_cadastro'
    end
    object qryConsultaEstoquedata_atualizacao: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'data_atualizacao'
      Origin = 'data_atualizacao'
    end
    object qryConsultaEstoqueusuario_cadastro: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'usuario_cadastro'
      Origin = 'usuario_cadastro'
      Size = 100
    end
  end
  object qryConsultaCST: TFDQuery
    BeforeOpen = qryConsultaCSTBeforeOpen
    Connection = form_conexao.FDConnection
    Left = 792
    Top = 56
    object qryConsultaCSTID_CST: TIntegerField
      FieldName = 'ID_CST'
      Origin = 'ID_CST'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryConsultaCSTFG_TIPO: TStringField
      FieldName = 'FG_TIPO'
      Origin = 'FG_TIPO'
      Size = 10
    end
    object qryConsultaCSTCD_CST: TStringField
      FieldName = 'CD_CST'
      Origin = 'CD_CST'
      Size = 10
    end
    object qryConsultaCSTDS_CST: TStringField
      FieldName = 'DS_CST'
      Origin = 'DS_CST'
      Size = 255
    end
  end
  object DataSourceClientes: TDataSource
    DataSet = qryConsultaClientes
    Left = 128
    Top = 40
  end
  object DataSourceProdutos: TDataSource
    DataSet = qryConsultaProdutos
    Left = 160
    Top = 112
  end
  object DataSourceCondicional: TDataSource
    DataSet = qryConsultaCondicional
    Left = 160
    Top = 184
  end
  object dsEstoque: TDataSource
    DataSet = qryConsultaEstoque
    Left = 464
    Top = 40
  end
  object qryConsultaCondicional: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'select * from condicional')
    Left = 40
    Top = 192
    object qryConsultaCondicionalID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryConsultaCondicionalID_Cliente: TIntegerField
      FieldName = 'ID_Cliente'
      Origin = 'ID_Cliente'
      Required = True
    end
    object qryConsultaCondicionalNome_Cliente: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'Nome_Cliente'
      Origin = 'Nome_Cliente'
      Size = 255
    end
  end
  object qryConsultaVendas: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'select * from Vendas')
    Left = 392
    Top = 120
    object qryConsultaVendasid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryConsultaVendascliente_id: TIntegerField
      FieldName = 'cliente_id'
      Origin = 'cliente_id'
      Required = True
    end
    object qryConsultaVendasnumero_venda: TStringField
      FieldName = 'numero_venda'
      Origin = 'numero_venda'
      Required = True
    end
    object qryConsultaVendasdata_venda: TDateField
      FieldName = 'data_venda'
      Origin = 'data_venda'
      Required = True
    end
    object qryConsultaVendashora_venda: TTimeField
      AutoGenerateValue = arDefault
      FieldName = 'hora_venda'
      Origin = 'hora_venda'
    end
    object qryConsultaVendasvalor_subtotal: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_subtotal'
      Origin = 'valor_subtotal'
      Precision = 10
      Size = 2
    end
    object qryConsultaVendasvalor_desconto: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_desconto'
      Origin = 'valor_desconto'
      Precision = 10
      Size = 2
    end
    object qryConsultaVendaspercentual_desconto: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'percentual_desconto'
      Origin = 'percentual_desconto'
      Precision = 5
      Size = 2
    end
    object qryConsultaVendasvalor_total: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_total'
      Origin = 'valor_total'
      Precision = 10
      Size = 2
    end
    object qryConsultaVendasforma_pagamento: TStringField
      FieldName = 'forma_pagamento'
      Origin = 'forma_pagamento'
      Required = True
      FixedChar = True
      Size = 14
    end
    object qryConsultaVendasstatus_venda: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'status_venda'
      Origin = 'status_venda'
      FixedChar = True
      Size = 9
    end
    object qryConsultaVendasvendedor: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'vendedor'
      Origin = 'vendedor'
      Size = 100
    end
    object qryConsultaVendasobservacoes: TMemoField
      AutoGenerateValue = arDefault
      FieldName = 'observacoes'
      Origin = 'observacoes'
      BlobType = ftMemo
    end
    object qryConsultaVendasdata_cadastro: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'data_cadastro'
      Origin = 'data_cadastro'
    end
    object qryConsultaVendasdata_atualizacao: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'data_atualizacao'
      Origin = 'data_atualizacao'
    end
    object qryConsultaVendasusuario_cadastro: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'usuario_cadastro'
      Origin = 'usuario_cadastro'
      Size = 100
    end
  end
  object DataSourceVendas: TDataSource
    DataSet = qryConsultaVendas
    Left = 548
    Top = 120
  end
  object qryConsultaCondicionalPendente: TFDQuery
    Active = True
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'SELECT'
      '  condicionalPendente.id,'
      '  clientes.nome,'
      '  condicionalPendente.id_produto,'
      '  produtos.Nome,'
      '  condicionalPendente.quantidade,'
      '  condicionalPendente.observacao'
      'FROM'
      '  condicionalPendente'
      'INNER JOIN'
      
        '  condicional ON condicionalPendente.id_condicional = condiciona' +
        'l.id'
      'INNER JOIN'
      '  clientes ON condicional.ID_Cliente = clientes.ID'
      'INNER JOIN'
      '  produtos ON condicionalPendente.id_produto = produtos.id')
    Left = 32
    Top = 288
    object qryConsultaCondicionalPendenteid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryConsultaCondicionalPendentenome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object qryConsultaCondicionalPendenteid_produto: TIntegerField
      FieldName = 'id_produto'
      Origin = 'id_produto'
      Required = True
    end
    object qryConsultaCondicionalPendenteNome_1: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'Nome_1'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object qryConsultaCondicionalPendentequantidade: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade'
      Origin = 'Quantidade'
    end
    object qryConsultaCondicionalPendenteobservacao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'observacao'
      Origin = 'observacao'
      Size = 255
    end
  end
  object DataSourceCondicionalPendente: TDataSource
    DataSet = qryConsultaCondicionalPendente
    Left = 152
    Top = 288
  end
end
