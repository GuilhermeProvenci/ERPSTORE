inherited form_cadastro_estoque: Tform_cadastro_estoque
  Caption = 'form_cadastro_estoque'
  ClientHeight = 608
  ClientWidth = 722
  ExplicitWidth = 722
  ExplicitHeight = 608
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_fundo: TPanel
    Width = 722
    Height = 608
    ExplicitWidth = 722
    ExplicitHeight = 608
    inherited lbl_CODIGO: TLabel
      Left = 669
      Top = 121
      Visible = False
      ExplicitLeft = 669
      ExplicitTop = 121
    end
    inherited lbl_informacao2: TLabel
      Left = 61
      Width = 47
      Caption = 'Produto'
      ExplicitLeft = 61
      ExplicitWidth = 47
    end
    inherited lbl_informacao3: TLabel
      Left = 436
      Width = 123
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Quantidade a inserir'
      ExplicitLeft = 436
      ExplicitWidth = 123
    end
    inherited lbl_informacao4: TLabel
      Left = 660
      Top = 54
      Width = 64
      Caption = ' * nao usar'
      Visible = False
      ExplicitLeft = 660
      ExplicitTop = 54
      ExplicitWidth = 64
    end
    inherited pnl_topo: TPanel
      Width = 722
      ExplicitWidth = 722
      inherited lbl_titulo: TLabel
        Width = 146
        Caption = 'Inclus'#227'o de Estoque'
        ExplicitWidth = 146
      end
      inherited btn_fechar: TSpeedButton
        Left = 669
        ExplicitLeft = 669
      end
      inherited pnl_separador_topo: TPanel
        Width = 722
        ExplicitWidth = 722
      end
    end
    inherited edt_codigo: TEdit
      Left = 31
      Width = 24
      Hint = 'Id produto'
      ExplicitLeft = 31
      ExplicitWidth = 24
    end
    inherited edt_nome: TEdit
      Left = 669
      Top = 151
      Width = 12
      ReadOnly = True
      Visible = False
      ExplicitLeft = 669
      ExplicitTop = 151
      ExplicitWidth = 12
    end
    inherited edt_3: TEdit
      Left = 436
      Hint = 'Quantidade a inserir'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
      ExplicitLeft = 436
    end
    inherited edt_4: TEdit
      Tag = 0
      Left = 669
      Top = 77
      Width = 12
      Enabled = False
      TabOrder = 5
      Visible = False
      ExplicitLeft = 669
      ExplicitTop = 77
      ExplicitWidth = 12
    end
    inherited pnl_salvar: TPanel
      Left = 494
      Top = 544
      TabOrder = 6
      ExplicitLeft = 494
      ExplicitTop = 544
    end
    object lccb_nome: TDBLookupComboBox
      Left = 61
      Top = 128
      Width = 283
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      KeyField = 'id'
      ListField = 'nome'
      ListSource = form_conexao_tabelas.DataSourceProdutos
      ParentFont = False
      TabOrder = 3
      OnClick = lccb_nomeClick
    end
    object dbg_registros: TDBGrid
      Left = 40
      Top = 200
      Width = 601
      Height = 305
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsEstoque
      TabOrder = 7
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Width = 56
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'produto_id'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome_produto'
          Width = 252
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantidade_em_estoque'
          Width = 209
          Visible = True
        end>
    end
  end
  inherited qryInsert: TFDQuery
    Left = 520
  end
  object dsEstoque: TDataSource
    DataSet = form_conexao_tabelas.qryConsultaEstoque
    Left = 464
    Top = 8
  end
end
