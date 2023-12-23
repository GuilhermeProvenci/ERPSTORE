object form_conexao_tabelas: Tform_conexao_tabelas
  OldCreateOrder = False
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
      ReadOnly = True
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
    Active = True
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
      ReadOnly = True
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
    Left = 416
    Top = 40
    object qryConsultaEstoqueid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryConsultaEstoqueproduto_id: TIntegerField
      FieldName = 'produto_id'
      Origin = 'produto_id'
      Required = True
    end
    object qryConsultaEstoquenome_produto: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_produto'
      Origin = 'nome_produto'
      Size = 255
    end
    object qryConsultaEstoquequantidade_em_estoque: TIntegerField
      FieldName = 'quantidade_em_estoque'
      Origin = 'quantidade_em_estoque'
      Required = True
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
    Left = 448
    Top = 40
  end
  object qryConsultaCondicional: TFDQuery
    Active = True
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
end
