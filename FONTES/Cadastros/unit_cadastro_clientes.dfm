inherited form_cadastro_clientes: Tform_cadastro_clientes
  Caption = 'Clientes'
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
    inherited edt_nome: TgpEdit
      StyleName = 'nome'
    end
    inherited edt_3: TgpEdit
      StyleName = 'telefone'
    end
    inherited edt_4: TgpEdit
      Top = 204
      StyleName = 'ENDERECO'
      ExplicitTop = 204
    end
    inherited edt_id: TgpEdit
      StyleName = 'id'
    end
    object cmbClassificacao: TgpCombo [12]
      Tag = 99
      Left = 220
      Top = 204
      Width = 165
      Height = 21
      ItemIndex = 0
      TabOrder = 5
      Text = 'Bronze'
      Items.Strings = (
        'Bronze'
        'Prata '
        'Ouro'
        'Diamante')
    end
    inherited Button1: TButton
      TabOrder = 7
      OnClick = Button1Click
    end
  end
end
