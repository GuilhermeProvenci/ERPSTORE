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
    object Label1: TLabel [5]
      Left = 220
      Top = 181
      Width = 74
      Height = 17
      Caption = 'Classifica'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
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
      Tag = 99
      Top = 194
      TabOrder = 6
      ExplicitTop = 194
    end
    object cbb_classificacao: TComboBox [8]
      Tag = 99
      Left = 220
      Top = 203
      Width = 145
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 5
      Text = 'Bronze'
      StyleName = 'classificacao'
      Items.Strings = (
        'Bronze'
        'Prata '
        'Ouro'
        'Diamante')
    end
    inherited edt_nome: TgpEdit
      StyleName = 'nome'
      DataFieldName = 'Nome'
    end
    inherited edt_id: TgpEdit
      StyleName = 'id'
    end
    inherited edt_3: TgpEdit
      StyleName = 'telefone'
      DataFieldName = 'TELEFONE'
    end
    inherited edt_4: TgpEdit
      StyleName = 'ENDERECO'
      DataFieldName = 'ENDERECO'
    end
  end
end
