inherited form_cadastro_vendas: Tform_cadastro_vendas
  Caption = 'Vendas'
  ClientHeight = 680
  ClientWidth = 830
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 830
  ExplicitHeight = 680
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 830
    Height = 680
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 830
    ExplicitHeight = 680
    inherited pnlTop: TPanel
      Width = 830
      TabOrder = 11
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 830
      inherited lblTitle: TLabel
        Width = 171
        Caption = 'CADASTRO DE VENDAS'
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 171
      end
      inherited btnClose: TSpeedButton
        Left = 777
        ExplicitLeft = 777
      end
      inherited btnSave: TImage
        Left = 739
        ExplicitLeft = 739
      end
      inherited pnlSeparator: TPanel
        Width = 830
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 830
      end
    end
    object pnl_numero_venda: TPanel
      Left = 24
      Top = 85
      Width = 256
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      object lbl_numero_venda: TLabel
        Left = 0
        Top = 0
        Width = 256
        Height = 17
        Align = alTop
        Caption = #55357#56629' N'#218#154'MERO DA VENDA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 151
      end
      object edtNumeroVenda: TEdit
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 256
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
      object pnl_barra_numero_venda: TPanel
        Left = 0
        Top = 56
        Width = 256
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_cliente: TPanel
      Left = 292
      Top = 85
      Width = 514
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 1
      object lbl_cliente: TLabel
        Left = 0
        Top = 0
        Width = 514
        Height = 17
        Align = alTop
        Caption = #55357#56420' CLIENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 71
      end
      object cmbCliente: TComboBox
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 514
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
        ParentFont = False
        TabOrder = 0
      end
      object pnl_barra_cliente: TPanel
        Left = 0
        Top = 61
        Width = 514
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_data_venda: TPanel
      Left = 24
      Top = 165
      Width = 216
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 2
      object lbl_data_venda: TLabel
        Left = 0
        Top = 0
        Width = 216
        Height = 17
        Align = alTop
        Caption = #55357#56464' DATA DA VENDA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 129
      end
      object dtpDataVenda: TDateTimePicker
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
      object pnl_barra_data_venda: TPanel
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
    object pnl_hora_venda: TPanel
      Left = 252
      Top = 165
      Width = 156
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 3
      object lbl_hora_venda: TLabel
        Left = 0
        Top = 0
        Width = 156
        Height = 17
        Align = alTop
        Caption = #9200' HORA DA VENDA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 132
      end
      object dtpHoraVenda: TDateTimePicker
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 156
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
        Kind = dtkTime
        ParentFont = False
        TabOrder = 0
      end
      object pnl_barra_hora_venda: TPanel
        Left = 0
        Top = 61
        Width = 156
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_vendedor: TPanel
      Left = 420
      Top = 165
      Width = 386
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 4
      object lbl_vendedor: TLabel
        Left = 0
        Top = 0
        Width = 386
        Height = 17
        Align = alTop
        Caption = #55357#56421' VENDEDOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 94
      end
      object edtVendedor: TEdit
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 386
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
      object pnl_barra_vendedor: TPanel
        Left = 0
        Top = 56
        Width = 386
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_valor_subtotal: TPanel
      Left = 24
      Top = 245
      Width = 156
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 5
      object lbl_valor_subtotal: TLabel
        Left = 0
        Top = 0
        Width = 156
        Height = 17
        Align = alTop
        Caption = #65533#65533' SUBTOTAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 92
      end
      object edtValorSubtotal: TEdit
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 156
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
      object pnl_barra_valor_subtotal: TPanel
        Left = 0
        Top = 56
        Width = 156
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_desconto: TPanel
      Left = 192
      Top = 245
      Width = 156
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 6
      object lbl_desconto: TLabel
        Left = 0
        Top = 0
        Width = 156
        Height = 17
        Align = alTop
        Caption = #55357#57311' DESCONTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 82
      end
      object edtDesconto: TEdit
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 156
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
      object pnl_barra_desconto: TPanel
        Left = 0
        Top = 56
        Width = 156
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_valor_total: TPanel
      Left = 360
      Top = 245
      Width = 196
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 7
      object lbl_valor_total: TLabel
        Left = 0
        Top = 0
        Width = 196
        Height = 17
        Align = alTop
        Caption = #65533#65533' VALOR TOTAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 114
      end
      object edtValorTotal: TEdit
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 196
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
      object pnl_barra_valor_total: TPanel
        Left = 0
        Top = 56
        Width = 196
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_forma_pagamento: TPanel
      Left = 568
      Top = 245
      Width = 238
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 8
      object lbl_forma_pagamento: TLabel
        Left = 0
        Top = 0
        Width = 238
        Height = 17
        Align = alTop
        Caption = #65533#65533' FORMA PAGAMENTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 159
      end
      object cmbFormaPagamento: TComboBox
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 238
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
        Text = 'DINHEIRO'
        Items.Strings = (
          'DINHEIRO'
          'CARTAO_CREDITO'
          'CARTAO_DEBITO'
          'PIX'
          'TRANSFERENCIA'
          'FIADO')
      end
      object pnl_barra_forma_pagamento: TPanel
        Left = 0
        Top = 61
        Width = 238
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_status: TPanel
      Left = 24
      Top = 325
      Width = 782
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 9
      object lbl_status: TLabel
        Left = 0
        Top = 0
        Width = 782
        Height = 17
        Align = alTop
        Caption = #9989' STATUS DA VENDA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 141
      end
      object cmbStatus: TComboBox
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 782
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
        Text = 'PENDENTE'
        Items.Strings = (
          'PENDENTE'
          'CONCLUIDA'
          'CANCELADA'
          'DEVOLVIDA')
      end
      object pnl_barra_status: TPanel
        Left = 0
        Top = 61
        Width = 782
        Height = 2
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_observacoes: TPanel
      Left = 24
      Top = 405
      Width = 782
      Height = 125
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 10
      object lbl_observacoes: TLabel
        Left = 0
        Top = 0
        Width = 782
        Height = 17
        Align = alTop
        Caption = #55357#56393' OBSERVA'#199#213#149'ES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 112
      end
      object memoObservacoes: TMemo
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 782
        Height = 85
        Margins.Left = 0
        Margins.Top = 15
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        BorderStyle = bsNone
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object pnl_barra_observacoes: TPanel
        Left = 0
        Top = 117
        Width = 782
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
