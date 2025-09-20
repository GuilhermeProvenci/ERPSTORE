object frmGeradorClasses: TfrmGeradorClasses
  Left = 0
  Top = 0
  Caption = 'Gerador de Classes'
  ClientHeight = 600
  ClientWidth = 900
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 900
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 900
    Height = 600
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      900
      600)
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 900
      Height = 75
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      DesignSize = (
        900
        75)
      object lblTitle: TLabel
        Left = 24
        Top = 24
        Width = 213
        Height = 28
        Caption = 'GERADOR DE CLASSES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnClose: TSpeedButton
        Left = 847
        Top = 8
        Width = 45
        Height = 45
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Flat = True
        OnClick = btnCloseClick
      end
      object pnlSeparator: TPanel
        Left = 0
        Top = 73
        Width = 900
        Height = 2
        Align = alBottom
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 0
      end
    end
    object pnl_conexao: TPanel
      Left = 24
      Top = 95
      Width = 852
      Height = 65
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        852
        65)
      object lbl_conexao: TLabel
        Left = 0
        Top = 0
        Width = 852
        Height = 17
        Align = alTop
        Caption = #55357#56456' CONEX'#195#131'O COM BANCO DE DADOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 233
      end
      object btnConectar: TSpeedButton
        Left = 720
        Top = 25
        Width = 120
        Height = 35
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = 'CONECTAR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnConectarClick
      end
      object edtConexao: TEdit
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 714
        Height = 24
        Margins.Left = 0
        Margins.Top = 15
        Margins.Right = 0
        Margins.Bottom = 0
        Anchors = [akLeft, akTop, akRight]
        BorderStyle = bsNone
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        Text = 'Servidor: localhost | Banco: sistema | Status: Desconectado'
      end
      object pnl_barra_conexao: TPanel
        Left = 0
        Top = 56
        Width = 714
        Height = 2
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_tabelas: TPanel
      Left = 24
      Top = 175
      Width = 418
      Height = 350
      Anchors = [akLeft, akTop, akBottom]
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 2
      object lbl_tabelas: TLabel
        Left = 0
        Top = 0
        Width = 418
        Height = 17
        Align = alTop
        Caption = #55357#56460' TABELAS DISPON'#205#141'VEIS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 161
      end
      object gridTabelas: TStringGrid
        Left = 0
        Top = 17
        Width = 418
        Height = 283
        Align = alClient
        ColCount = 3
        DefaultRowHeight = 25
        FixedCols = 0
        RowCount = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentFont = False
        TabOrder = 0
        OnMouseDown = gridTabelasMouseDown
        ExplicitTop = 32
        ExplicitHeight = 275
        ColWidths = (
          30
          200
          150)
        RowHeights = (
          25
          25)
      end
      object pnl_opcoes_tabelas: TPanel
        Left = 0
        Top = 300
        Width = 418
        Height = 50
        Align = alBottom
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 1
        ExplicitLeft = -434
        ExplicitWidth = 852
        DesignSize = (
          418
          50)
        object btnAtualizarTabelas: TSpeedButton
          Left = 288
          Top = 13
          Width = 130
          Height = 30
          Cursor = crHandPoint
          Anchors = [akRight, akBottom]
          Caption = 'ATUALIZAR LISTA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8404992
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnAtualizarTabelasClick
          ExplicitTop = 313
        end
        object btnLimparSelecao: TSpeedButton
          Left = 8
          Top = 13
          Width = 130
          Height = 30
          Cursor = crHandPoint
          Anchors = [akLeft, akBottom]
          Caption = 'LIMPAR SELE'#199#195'O'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8404992
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnLimparSelecaoClick
          ExplicitTop = 313
        end
        object btnSelecionarTodas: TSpeedButton
          Left = 148
          Top = 13
          Width = 130
          Height = 30
          Cursor = crHandPoint
          Anchors = [akRight, akBottom]
          Caption = 'SELECIONAR TODAS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8404992
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnSelecionarTodasClick
          ExplicitTop = 313
        end
      end
    end
    object pnl_preview: TPanel
      Left = 458
      Top = 175
      Width = 418
      Height = 350
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 3
      DesignSize = (
        418
        350)
      object lbl_preview: TLabel
        Left = 0
        Top = 0
        Width = 418
        Height = 17
        Align = alTop
        Caption = #55357#56393' PREVIEW DAS CLASSES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 165
      end
      object btnLimparAbas: TSpeedButton
        Left = 288
        Top = 5
        Width = 130
        Height = 20
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = 'LIMPAR PREVIEWS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -9
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnLimparAbasClick
      end
      object pgcPreview: TPageControl
        Left = 0
        Top = 32
        Width = 418
        Height = 318
        ActivePage = tsPreviewVazio
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object tsPreviewVazio: TTabSheet
          Caption = 'Selecione uma tabela'
          object lblInstrucao: TLabel
            Left = 0
            Top = 0
            Width = 410
            Height = 290
            Align = alClient
            Alignment = taCenter
            Caption = 
              'Clique em uma tabela na lista '#13#10'para visualizar o preview '#13#10'da c' +
              'lasse gerada'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
            WordWrap = True
            ExplicitWidth = 208
            ExplicitHeight = 63
          end
        end
      end
    end
    object pnl_opcoes: TPanel
      Left = 24
      Top = 540
      Width = 852
      Height = 50
      Anchors = [akLeft, akRight, akBottom]
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 4
      DesignSize = (
        852
        50)
      object lblContador: TLabel
        Left = 8
        Top = 18
        Width = 132
        Height = 15
        Caption = '0 tabela(s) selecionada(s)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object btnEscolherPasta: TSpeedButton
        Left = 566
        Top = 5
        Width = 140
        Height = 40
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = 'ESCOLHER PASTA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnEscolherPastaClick
      end
      object btnGerarClasses: TSpeedButton
        Left = 712
        Top = 5
        Width = 140
        Height = 40
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = 'GERAR CLASSES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnGerarClassesClick
      end
    end
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=sistema'
      'User_Name=root'
      'Password='
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object qryTabelas: TFDQuery
    Connection = FDConnection
    Left = 88
    Top = 16
  end
  object qryCampos: TFDQuery
    Connection = FDConnection
    Left = 136
    Top = 16
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'pas'
    Filter = 'Arquivos Pascal (*.pas)|*.pas'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 184
    Top = 16
  end
end
