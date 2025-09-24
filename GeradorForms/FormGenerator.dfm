object frmGeradorFormularios: TfrmGeradorFormularios
  Left = 0
  Top = 0
  Caption = 'Gerador de Formul'#225'rios'
  ClientHeight = 800
  ClientWidth = 1200
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 1200
    Height = 800
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 1200
      Height = 60
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object lblTitle: TLabel
        Left = 24
        Top = 18
        Width = 257
        Height = 25
        Caption = 'GERADOR DE FORMUL'#193'RIOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnClose: TSpeedButton
        Left = 1150
        Top = 15
        Width = 30
        Height = 30
        Caption = 'X'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnCloseClick
      end
      object pnlSeparator: TPanel
        Left = 0
        Top = 58
        Width = 1200
        Height = 2
        Align = alBottom
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 0
      end
    end
    object pnl_origem: TPanel
      Left = 24
      Top = 80
      Width = 560
      Height = 90
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 1
      object lbl_origem: TLabel
        Left = 0
        Top = 0
        Width = 144
        Height = 17
        Align = alTop
        Caption = #62759#65039' ORIGEM DOS DADOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rbClasse: TRadioButton
        Left = 16
        Top = 32
        Width = 200
        Height = 17
        Caption = 'Analisar Classe Existente'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = True
        OnClick = rbClasseClick
      end
      object rbBanco: TRadioButton
        Left = 240
        Top = 32
        Width = 200
        Height = 17
        Caption = 'Carregar do Banco de Dados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = rbBancoClick
      end
      object pnl_barra_origem: TPanel
        Left = 0
        Top = 88
        Width = 560
        Height = 2
        Align = alBottom
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 2
      end
    end
    object pnl_classe: TPanel
      Left = 24
      Top = 185
      Width = 560
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 2
      object lbl_classe: TLabel
        Left = 0
        Top = 0
        Width = 144
        Height = 17
        Align = alTop
        Caption = #62660' ARQUIVO DA CLASSE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnProcurarClasse: TSpeedButton
        Left = 430
        Top = 30
        Width = 60
        Height = 28
        Caption = 'Procurar'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        OnClick = btnProcurarClasseClick
      end
      object btnAnalisarClasse: TSpeedButton
        Left = 500
        Top = 30
        Width = 60
        Height = 28
        Caption = 'Analisar'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        OnClick = btnAnalisarClasseClick
      end
      object edtArquivoClasse: TEdit
        Left = 0
        Top = 32
        Width = 420
        Height = 24
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
      object pnl_barra_classe: TPanel
        Left = 0
        Top = 63
        Width = 560
        Height = 2
        Align = alBottom
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_banco: TPanel
      Left = 24
      Top = 185
      Width = 560
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 3
      Visible = False
      object lbl_banco: TLabel
        Left = 0
        Top = 0
        Width = 159
        Height = 17
        Align = alTop
        Caption = #62711#65039' CONEX'#195'O COM BANCO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnConectar: TSpeedButton
        Left = 460
        Top = 30
        Width = 100
        Height = 28
        Caption = 'Conectar'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        OnClick = btnConectarClick
      end
      object edtConexao: TEdit
        Left = 0
        Top = 32
        Width = 450
        Height = 24
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
      end
      object pnl_barra_banco: TPanel
        Left = 0
        Top = 63
        Width = 560
        Height = 2
        Align = alBottom
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
      end
    end
    object pnl_tabelas: TPanel
      Left = 24
      Top = 265
      Width = 560
      Height = 65
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 4
      Visible = False
      object lbl_tabelas: TLabel
        Left = 0
        Top = 0
        Width = 60
        Height = 17
        Align = alTop
        Caption = #62927#65039' TABELA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnCarregarCampos: TSpeedButton
        Left = 460
        Top = 30
        Width = 100
        Height = 33
        Caption = 'Carregar Campos'
        Enabled = False
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        OnClick = btnCarregarCamposClick
      end
      object cmbTabelas: TComboBox
        Left = 0
        Top = 32
        Width = 450
        Height = 29
        Style = csDropDownList
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = cmbTabelasChange
      end
    end
    object pnl_campos: TPanel
      Left = 24
      Top = 350
      Width = 560
      Height = 280
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 5
      object lbl_campos: TLabel
        Left = 0
        Top = 0
        Width = 213
        Height = 17
        Align = alTop
        Caption = #9881#65039' CONFIGURA'#199#195'O DOS CAMPOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object gridCampos: TStringGrid
        Left = 0
        Top = 25
        Width = 560
        Height = 255
        Align = alBottom
        BorderStyle = bsNone
        Color = clBtnFace
        ColCount = 7
        DefaultColWidth = 80
        DefaultRowHeight = 25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentFont = False
        TabOrder = 0
        OnSelectCell = gridCamposSelectCell
      end
    end
    object pnl_preview: TPanel
      Left = 600
      Top = 80
      Width = 576
      Height = 550
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 6
      object lbl_preview: TLabel
        Left = 0
        Top = 0
        Width = 576
        Height = 17
        Align = alTop
        Caption = #62529#65039' PREVIEW DO FORMUL'#193'RIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 181
      end
      object pgcPreview: TPageControl
        Left = 0
        Top = 25
        Width = 576
        Height = 525
        ActivePage = tsPas
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object tsPas: TTabSheet
          Caption = 'Arquivo .PAS'
          object memoPas: TMemo
            Left = 0
            Top = 0
            Width = 568
            Height = 495
            Align = alClient
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8404992
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
        object tsDfm: TTabSheet
          Caption = 'Arquivo .DFM'
          ImageIndex = 1
          object memoDfm: TMemo
            Left = 0
            Top = 0
            Width = 568
            Height = 495
            Align = alClient
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8404992
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
      end
    end
    object pnl_geracao: TPanel
      Left = 24
      Top = 650
      Width = 1152
      Height = 120
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 7
      object lbl_nome_form: TLabel
        Left = 0
        Top = 0
        Width = 194
        Height = 17
        Align = alTop
        Caption = #9889' GERA'#199#195'O DO FORMUL'#193'RIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPastaDestino: TLabel
        Left = 0
        Top = 70
        Width = 34
        Height = 15
        Caption = 'Pasta: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object btnEscolherPasta: TSpeedButton
        Left = 320
        Top = 30
        Width = 120
        Height = 28
        Caption = 'Escolher Pasta'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        OnClick = btnEscolherPastaClick
      end
      object btnGerarFormulario: TSpeedButton
        Left = 460
        Top = 30
        Width = 150
        Height = 28
        Caption = 'Gerar Formul'#225'rio'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnGerarFormularioClick
      end
      object edtNomeForm: TEdit
        Left = 0
        Top = 32
        Width = 300
        Height = 24
        BorderStyle = bsNone
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TextHint = 'Ex: cadastro_produtos'
        OnChange = edtNomeFormChange
      end
    end
  end
  object qryTabelas: TFDQuery
    Left = 344
    Top = 256
  end
  object qryCampos: TFDQuery
    Left = 520
    Top = 256
  end
  object FDConnection: TFDConnection
    Left = 952
  end
  object OpenDialog: TOpenDialog
    Left = 592
    Top = 408
  end
end
