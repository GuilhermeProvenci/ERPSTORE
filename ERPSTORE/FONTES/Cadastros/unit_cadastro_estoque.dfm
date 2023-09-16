inherited form_cadastro_estoque: Tform_cadastro_estoque
  Caption = 'form_cadastro_estoque'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_fundo: TPanel
    inherited lbl_informacao2: TLabel
      Left = 277
      Width = 47
      Caption = 'Produto'
      ExplicitLeft = 277
      ExplicitWidth = 47
    end
    inherited lbl_informacao4: TLabel
      Visible = False
    end
    inherited pnl_topo: TPanel
      inherited lbl_titulo: TLabel
        Width = 146
        Caption = 'Inclus'#227'o de Estoque'
        ExplicitWidth = 146
      end
    end
    inherited edt_nome: TEdit
      Left = 255
      Width = 23
      ReadOnly = True
      ExplicitLeft = 255
      ExplicitWidth = 23
    end
    inherited edt_3: TEdit
      Left = 570
      TabOrder = 4
      ExplicitLeft = 570
    end
    inherited edt_4: TEdit
      Tag = 0
      Enabled = False
      TabOrder = 5
      Visible = False
    end
    inherited pnl_salvar: TPanel
      TabOrder = 6
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 281
      Top = 129
      Width = 283
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      KeyField = 'nome_produto'
      ListField = 'nome_produto'
      ListSource = dsEstoque
      ParentFont = False
      TabOrder = 3
    end
  end
  object dsEstoque: TDataSource
    DataSet = form_conexao_tabelas.qryConsultaEstoque
    Left = 504
    Top = 16
  end
end
