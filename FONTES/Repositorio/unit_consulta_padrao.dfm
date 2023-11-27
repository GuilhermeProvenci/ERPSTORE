object form_consulta_padrao: Tform_consulta_padrao
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  ClientHeight = 516
  ClientWidth = 833
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_principal: TPanel
    Left = 0
    Top = 0
    Width = 833
    Height = 516
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnl_cabecalho: TPanel
      Left = 0
      Top = 0
      Width = 833
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      object btn_fechar: TSpeedButton
        Left = 763
        Top = 0
        Width = 70
        Height = 56
        Cursor = crHandPoint
        Align = alRight
        Flat = True
        Glyph.Data = {
          F6060000424DF606000000000000360000002800000018000000180000000100
          180000000000C006000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFF2F2F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFF6F6F6FFFFFFFFFFFFF8F8F88F8F8F5D5D5DABABABFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFDCDCDC717171696969D3D3D3FFFFFFECECEC6D6D6D6767675E5E5EA4A4
          A4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFD4D4D46E6E6E666666606060AFAFAFFFFFFFFFFFFFB9B9B9
          5F5F5F6C6C6C626262969696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFDDDDDD6363636969696262627D7D7DF4F4F4FF
          FFFFFFFFFFFFFFFFBEBEBE5C5C5C6B6B6B5E5E5E979797FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD1D1D16969696969696464647A7A
          7AFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C06969696B6B6B6161618F
          8F8FF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC2C2C26666666A6A6A
          6363638E8E8EFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBDBD
          BD5858586B6B6B636363848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDADADA5E
          5E5E6A6A6A5D5D5D808080F5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFE2E2E2636363696969606060797979F1F1F1FFFFFFFFFF
          FFB3B3B35A5A5A6C6C6C616161929292FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCBCBCB676767686868656565
          868686FDFDFDBCBCBC6565656C6C6C606060959595FDFDFDFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7
          D7D76E6E6E6767676868687272726868686B6B6B5B5B5BA4A4A4FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFE9E9E96D6D6D6C6C6C6C6C6C6D6D6D6A6A6AA1A1A1FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9393936767676E6E6E6C6C
          6C727272E9E9E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA7A7A75E5E5E
          6C6C6C6868686969696A6A6A646464F3F3F3FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE97
          97976161616B6B6B686868B4B4B48282826666666767676D6D6DDBDBDBFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF9595956262626C6C6C595959B2B2B2FFFFFFE7E7E770707062626269
          69696C6C6CEAEAEAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF7F7F78484845D5D5D6A6A6A5E5E5ED8D8D8FFFFFFFFFFFFFFFF
          FFFBFBFB8E8E8E6161616A6A6A515151D8D8D8FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFDFDFD9090906363636A6A6A656565BFBFBFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFBFBFB7B7B7B6060606A6A6A6B6B6BCFCFCFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7C7C7C636363696969686868D0
          D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F38F8F8F636363
          696969666666C5C5C5FFFFFFFFFFFFFFFFFFFFFFFFF2F2F27F7F7F6161616969
          69636363DADADAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFEFEFE9494945F5F5F6B6B6B5B5B5BC5C5C5FFFFFFFFFFFFF8F8F8888888
          6363636868686D6D6DD4D4D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8B8B8B6060606B6B6B646464CFCFCFFF
          FFFFEDEDED6F6F6F5E5E5E6F6F6FDEDEDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9999995F5F
          5F5D5D5DB1B1B1FFFFFFFFFFFFCFCFCFA0A0A0E9E9E9FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFB9B9B9ABABABF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        OnClick = btn_fecharClick
        ExplicitLeft = 820
        ExplicitHeight = 80
      end
      object lbl_titulo: TLabel
        AlignWithMargins = True
        Left = 15
        Top = 0
        Width = 104
        Height = 56
        Cursor = crHandPoint
        Margins.Left = 15
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'CONSULTA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -21
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 30
      end
      object pnl_separa_topo: TPanel
        Left = 0
        Top = 56
        Width = 833
        Height = 1
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alBottom
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
      end
    end
    object pnl_Rodape: TPanel
      Left = 0
      Top = 478
      Width = 833
      Height = 38
      Align = alBottom
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 1
      object lbl_duplo_clique: TLabel
        AlignWithMargins = True
        Left = 538
        Top = 0
        Width = 285
        Height = 38
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alRight
        Caption = 'DUPLO CLIQUE na linha desejada abre para ALTERA'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
      object lbl_excluir: TLabel
        AlignWithMargins = True
        Left = 10
        Top = 0
        Width = 405
        Height = 38
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 
          'Para EXCLUIR, selecione a LINHA que deseja e aperte DEL ou DELET' +
          'E no teclado'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object pnl_pesquisa: TPanel
      Left = 0
      Top = 57
      Width = 833
      Height = 72
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        833
        72)
      object lbl_texto: TLabel
        Left = 19
        Top = 11
        Width = 321
        Height = 17
        Caption = 'Texto ( Digite o que dejesa encontrar e aperte ENTER )'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object edt_consulta: TEdit
        Left = 19
        Top = 32
        Width = 542
        Height = 25
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnKeyDown = edt_consultaKeyDown
      end
      object btn_inserir: TButton
        Left = 684
        Top = 32
        Width = 129
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Novo / Inserir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btn_inserirClick
      end
      object Button1: TButton
        Left = 567
        Top = 32
        Width = 111
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Relat'#243'rio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = Button1Click
      end
    end
    object pnl_dbgrid: TPanel
      Left = 0
      Top = 129
      Width = 833
      Height = 349
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 3
      object dbg_registros: TDBGrid
        AlignWithMargins = True
        Left = 20
        Top = 41
        Width = 793
        Height = 298
        Margins.Left = 20
        Margins.Top = 0
        Margins.Right = 20
        Margins.Bottom = 10
        Align = alClient
        BorderStyle = bsNone
        DataSource = ds_consulta
        DrawingStyle = gdsClassic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [dgTitles, dgRowSelect, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Segoe UI Semibold'
        TitleFont.Style = []
        OnDrawColumnCell = dbg_registrosDrawColumnCell
        OnDblClick = dbg_registrosDblClick
        OnKeyDown = dbg_registrosKeyDown
        OnTitleClick = dbg_registrosTitleClick
      end
      object pnl_resultado: TPanel
        AlignWithMargins = True
        Left = 20
        Top = 0
        Width = 793
        Height = 41
        Margins.Left = 20
        Margins.Top = 0
        Margins.Right = 20
        Margins.Bottom = 0
        Align = alTop
        BevelOuter = bvNone
        Color = 8404992
        ParentBackground = False
        TabOrder = 1
        object lbl_resultado: TLabel
          AlignWithMargins = True
          Left = 15
          Top = 0
          Width = 213
          Height = 41
          Margins.Left = 15
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Resultado da Consulta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15395562
          Font.Height = -21
          Font.Name = 'Segoe UI Semibold'
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          ExplicitHeight = 30
        end
      end
    end
  end
  object ds_consulta: TDataSource
    Left = 584
    Top = 9
  end
end
