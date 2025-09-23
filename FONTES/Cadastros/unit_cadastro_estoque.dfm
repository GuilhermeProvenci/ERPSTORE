inherited form_cadastro_estoque: Tform_cadastro_estoque
  Caption = 'Estoque'
  ClientHeight = 608
  ClientWidth = 722
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 722
  ExplicitHeight = 608
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 722
    Height = 608
    ParentColor = True
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 722
    ExplicitHeight = 608
    inherited pnlTop: TPanel
      Width = 722
      TabOrder = 6
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 722
      inherited lblTitle: TLabel
        Width = 178
        Height = 48
        Caption = 'CADASTRO DE ESTOQUE'
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 178
      end
      inherited btnClose: TSpeedButton
        Left = 669
        ExplicitLeft = 669
      end
      inherited btnSave: TImage
        Left = 631
        ExplicitLeft = 631
      end
      inherited pnlSeparator: TPanel
        Width = 722
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 722
      end
    end
    object pnl_produto: TPanel
      Left = 24
      Top = 85
      Width = 674
      Height = 65
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object lbl_produto: TLabel
        Left = 0
        Top = 0
        Width = 674
        Height = 17
        Align = alTop
        Caption = #55356#57335#65039' PRODUTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 86
      end
      object cmbProduto_id: TDBLookupComboBox
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 674
        Height = 29
        Margins.Left = 0
        Margins.Top = 15
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 0
      end
      object pnl_barra_produto: TPanel
        Left = 0
        Top = 61
        Width = 674
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_quantidade: TPanel
      Left = 24
      Top = 165
      Width = 216
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 1
      object lbl_quantidade: TLabel
        Left = 0
        Top = 0
        Width = 216
        Height = 17
        Align = alTop
        Caption = #55357#56550' QUANTIDADE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 109
      end
      object edtQuantidade_em_estoque: TEdit
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 216
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
      object pnl_barra_quantidade: TPanel
        Left = 0
        Top = 56
        Width = 216
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_preco_custo: TPanel
      Left = 257
      Top = 165
      Width = 216
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 2
      object lbl_preco_custo: TLabel
        Left = 0
        Top = 0
        Width = 216
        Height = 17
        Align = alTop
        Caption = #55357#56496' PRE'#199'O DE CUSTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 128
      end
      object edtPreco_Custo: TEdit
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 216
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
      object pnl_barra_preco_custo: TPanel
        Left = 0
        Top = 56
        Width = 216
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_data_entrada: TPanel
      Left = 482
      Top = 162
      Width = 216
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 3
      object lbl_data_entrada: TLabel
        Left = 0
        Top = 0
        Width = 216
        Height = 17
        Align = alTop
        Caption = #55357#56517' DATA DE ENTRADA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 142
      end
      object dtpData_Entrada: TDateTimePicker
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 216
        Height = 29
        Margins.Left = 0
        Margins.Top = 15
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Date = 45577.000000000000000000
        Time = 0.715611782405176200
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object pnl_barra_data_entrada: TPanel
        Left = 0
        Top = 61
        Width = 216
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_lote: TPanel
      Left = 24
      Top = 245
      Width = 332
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 4
      object lbl_lote: TLabel
        Left = 0
        Top = 0
        Width = 332
        Height = 17
        Align = alTop
        Caption = #55357#56598' LOTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 54
      end
      object edtLote: TEdit
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 332
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
      object pnl_barra_lote: TPanel
        Left = 0
        Top = 56
        Width = 332
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_validade: TPanel
      Left = 366
      Top = 242
      Width = 332
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 5
      object lbl_validade: TLabel
        Left = 0
        Top = 0
        Width = 332
        Height = 17
        Align = alTop
        Caption = #9203' DATA DE VALIDADE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 141
      end
      object dtpData_Validade: TDateTimePicker
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 332
        Height = 29
        Margins.Left = 0
        Margins.Top = 15
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Date = 45577.000000000000000000
        Time = 0.715611782405176200
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object pnl_barra_validade: TPanel
        Left = 0
        Top = 61
        Width = 332
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
  end
  object dsEstoque: TDataSource
    Left = 136
    Top = 64
  end
end
