inherited form_cadastro_clientes: Tform_cadastro_clientes
  Caption = 'Clientes'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_fundo: TPanel
    inherited lbl_informacao: TLabel
      Width = 143
      Caption = 'Informa'#231#245'es da Pessoa:'
      ExplicitWidth = 143
    end
    inherited lbl_informacao2: TLabel
      Width = 36
      Caption = 'Nome'
      ExplicitWidth = 36
    end
    inherited lbl_informacao3: TLabel
      Width = 49
      Caption = 'Telefone'
      ExplicitWidth = 49
    end
    inherited lbl_informacao4: TLabel
      Width = 55
      Caption = 'Endere'#231'o'
      ExplicitWidth = 55
    end
    inherited pnl_topo: TPanel
      inherited lbl_titulo: TLabel
        Width = 219
        Height = 48
        Caption = 'Cadastro de Pessoas / clientes'
        ExplicitWidth = 219
      end
    end
    inherited pnl_salvar: TPanel
      Top = 194
      ExplicitTop = 194
    end
  end
  object qryCondicional: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      
        'INSERT INTO condicional (cliente_id, data_entregue, data_devoluc' +
        'ao, nome_cliente)'
      'VALUES (:1, :2, :3, :4);')
    Left = 504
    Top = 8
    ParamData = <
      item
        Name = '1'
        ParamType = ptInput
      end
      item
        Name = '2'
        ParamType = ptInput
      end
      item
        Name = '3'
        ParamType = ptInput
      end
      item
        Name = '4'
        ParamType = ptInput
      end>
  end
end
