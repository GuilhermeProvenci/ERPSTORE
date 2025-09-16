inherited form_cadastro_produtos: Tform_cadastro_produtos
  Caption = 'Produtos'
  ClientHeight = 272
  StyleElements = [seFont, seClient, seBorder]
  ExplicitHeight = 272
  TextHeight = 13
  inherited pnlMain: TPanel
    Height = 272
    StyleElements = [seFont, seClient, seBorder]
    ExplicitHeight = 416
    inherited pnlTop: TPanel
      TabOrder = 3
      StyleElements = [seFont, seClient, seBorder]
      inherited lblTitle: TLabel
        Width = 192
        Caption = 'CADASTRO DE PRODUTOS'
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 192
      end
      inherited pnlSeparator: TPanel
        StyleElements = [seFont, seClient, seBorder]
      end
    end
    object pnl_nome: TPanel
      Left = 24
      Top = 85
      Width = 766
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      object lbl_nome: TLabel
        Left = 0
        Top = 0
        Width = 766
        Height = 17
        Align = alTop
        Caption = #55356#57335' NOME DO PRODUTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 153
      end
      object edtNome: TEdit
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 766
        Height = 24
        Margins.Left = 0
        Margins.Top = 15
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        BorderStyle = bsNone
        CharCase = ecUpperCase
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object pnl_barra_nome: TPanel
        Left = 0
        Top = 56
        Width = 766
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_tamanho: TPanel
      Left = 24
      Top = 165
      Width = 372
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 1
      object lbl_tamanho: TLabel
        Left = 0
        Top = 0
        Width = 372
        Height = 17
        Align = alTop
        Caption = #55357#56528' TAMANHO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 89
      end
      object cmbTamanho: TComboBox
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 372
        Height = 29
        Margins.Left = 0
        Margins.Top = 15
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Style = csDropDownList
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 0
        Text = 'PP'
        Items.Strings = (
          'PP'
          'P'
          'M'
          'G'
          'GG'
          'XG')
      end
      object pnl_barra_tamanho: TPanel
        Left = 0
        Top = 61
        Width = 372
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_preco: TPanel
      Left = 418
      Top = 165
      Width = 372
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 2
      object lbl_preco: TLabel
        Left = 0
        Top = 0
        Width = 372
        Height = 17
        Align = alTop
        Caption = #55357#56496' PRE'#199'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 61
      end
      object edtPreco: TEdit
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 372
        Height = 24
        Margins.Left = 0
        Margins.Top = 15
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        BorderStyle = bsNone
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object pnl_barra_preco: TPanel
        Left = 0
        Top = 56
        Width = 372
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
  end
end
