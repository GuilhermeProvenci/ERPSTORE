inherited form_cadastro_clientes: Tform_cadastro_clientes
  Caption = 'Clientes'
  ClientHeight = 416
  StyleElements = [seFont, seClient, seBorder]
  ExplicitHeight = 416
  TextHeight = 13
  inherited pnlMain: TPanel
    Height = 416
    StyleElements = [seFont, seClient, seBorder]
    ExplicitHeight = 416
    inherited pnlTop: TPanel
      TabOrder = 5
      StyleElements = [seFont, seClient, seBorder]
      inherited lblTitle: TLabel
        Width = 179
        Caption = 'CADASTRO DE CLIENTES'
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 179
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
        Caption = #55357#56420' NOME COMPLETO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 133
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
    object pnl_endereco: TPanel
      Left = 24
      Top = 165
      Width = 766
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 1
      object lbl_endereco: TLabel
        Left = 0
        Top = 0
        Width = 766
        Height = 17
        Align = alTop
        Caption = #55356#57314' ENDERE'#199'O COMPLETO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 164
      end
      object edtEndereco: TEdit
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
      object pnl_barra_endereco: TPanel
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
    object pnl_telefone: TPanel
      Left = 24
      Top = 245
      Width = 257
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 2
      object lbl_telefone: TLabel
        Left = 0
        Top = 0
        Width = 257
        Height = 17
        Align = alTop
        Caption = #55357#56561' TELEFONE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 80
      end
      object edtTelefone: TEdit
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 257
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
      object pnl_barra_telefone: TPanel
        Left = 0
        Top = 56
        Width = 257
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_email: TPanel
      Left = 312
      Top = 245
      Width = 478
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 3
      object lbl_email: TLabel
        Left = 0
        Top = 0
        Width = 478
        Height = 17
        Align = alTop
        Caption = #9993#65039' E-MAIL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 67
      end
      object edtEmail: TEdit
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 478
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
      object pnl_barra_email: TPanel
        Left = 0
        Top = 56
        Width = 478
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_classificacao: TPanel
      Left = 24
      Top = 325
      Width = 257
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 4
      object lbl_classificacao: TLabel
        Left = 0
        Top = 0
        Width = 257
        Height = 17
        Align = alTop
        Caption = #11088' CLASSIFICA'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 113
      end
      object cmbClassificacao: TComboBox
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 257
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
        Text = 'BRONZE'
        Items.Strings = (
          'BRONZE'
          'PRATA'
          'OURO'
          'DIAMANTE')
      end
      object pnl_barra_classificacao: TPanel
        Left = 0
        Top = 61
        Width = 257
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
