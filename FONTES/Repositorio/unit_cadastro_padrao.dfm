object form_cadastro_padrao: Tform_cadastro_padrao
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'form_cadastro_padrao'
  ClientHeight = 289
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_fundo: TPanel
    Left = 0
    Top = 0
    Width = 750
    Height = 289
    Margins.Left = 15
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      750
      289)
    object lbl_informacao: TLabel
      Left = 17
      Top = 69
      Width = 78
      Height = 17
      Caption = 'Informa'#231#245'es:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8404992
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
    end
    object lbl_CODIGO: TLabel
      Left = 25
      Top = 110
      Width = 52
      Height = 17
      Caption = 'C'#243'digo *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbl_informacao2: TLabel
      Left = 222
      Top = 105
      Width = 5
      Height = 17
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbl_informacao3: TLabel
      Left = 566
      Top = 105
      Width = 9
      Height = 17
      Caption = ' *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbl_informacao4: TLabel
      Left = 25
      Top = 179
      Width = 9
      Height = 17
      Caption = ' *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object pnl_topo: TPanel
      Left = 0
      Top = 0
      Width = 750
      Height = 49
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lbl_titulo: TLabel
        AlignWithMargins = True
        Left = 15
        Top = 0
        Width = 88
        Height = 48
        Margins.Left = 15
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Cadastro de'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -16
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 21
      end
      object btn_fechar: TSpeedButton
        Left = 697
        Top = 0
        Width = 53
        Height = 48
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
        ExplicitLeft = 698
        ExplicitTop = 1
      end
      object pnl_separador_topo: TPanel
        Left = 0
        Top = 48
        Width = 750
        Height = 1
        Align = alBottom
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
      end
    end
    object pnl_salvar: TPanel
      Left = 522
      Top = 225
      Width = 209
      Height = 41
      Anchors = [akRight, akBottom]
      Caption = 'SALVAR  INFORMA'#199#213'ES'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 5
      OnClick = pnl_salvarClick
      object Image1: TImage
        Left = 1
        Top = 1
        Width = 24
        Height = 39
        Align = alLeft
        Center = True
        Picture.Data = {
          07544269746D6170F6060000424DF60600000000000036000000280000001800
          0000180000000100180000000000C0060000C40E0000C40E0000000000000000
          0000FFFFFFFFFFFFE6E6E6D1D1D1E8E8E8FFFFFFD1D1D1D1D1D1D1D1D1D1D1D1
          D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1FFFFFFE8E8E8D1D1
          D1E6E6E6FFFFFFFFFFFFFFFFFF9A9A9A525252525252A8A8A8FFFFFF52525252
          5252525252525252525252525252525252525252525252525252525252525252
          FFFFFFA8A8A85252525252529B9B9BFFFFFFE6E6E6525252525252525252A8A8
          A8FFFFFF52525252525252525252525252525252525252525252525252525252
          5252525252525252FFFFFFA8A8A8525252525252525252E6E6E6D4D4D4525252
          525252525252A8A8A8FFFFFF5252525252525252525252525252525252525252
          52525252525252525252525252525252FFFFFFA8A8A8525252525252525252D4
          D4D4D4D4D4525252525252525252A8A8A8FFFFFF525252525252525252525252
          525252525252525252525252525252525252525252525252FFFFFFA8A8A85252
          52525252525252D4D4D4D4D4D4525252525252525252A8A8A8FFFFFF52525252
          5252525252525252525252525252525252525252525252525252525252525252
          FFFFFFA8A8A8525252525252525252D4D4D4D4D4D4525252525252525252A8A8
          A8FFFFFF52525252525252525252525252525252525252525252525252525252
          5252525252525252FFFFFFA8A8A8525252525252525252D4D4D4D4D4D4525252
          525252525252A4A4A4FFFFFF5B5B5B5252525252525252525252525252525252
          525252525252525252525252525B5B5BFFFFFFA4A4A4525252525252525252D4
          D4D4D4D4D4525252525252525252777777FEFEFEE7E7E7D1D1D1D1D1D1D1D1D1
          D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1E7E7E7FEFEFE7777775252
          52525252525252D4D4D4D4D4D4525252525252525252525252898989C9C9C9D1
          D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1C9C9C9
          898989525252525252525252525252D4D4D4D4D4D45252525252525252525252
          5252525252525252525252525252525252525252525252525252525252525252
          5252525252525252525252525252525252525252525252D4D4D4D4D4D4525252
          5252525252525252525252525252525252525252525252525252525252525252
          52525252525252525252525252525252525252525252525252525252525252D4
          D4D4D4D4D4525252525252525252525252525252525252525252525252525252
          5252525252525252525252525252525252525252525252525252525252525252
          52525252525252D4D4D4D4D4D452525252525252525252525252525252525252
          5252525252525252525252525252525252525252525252525252525252525252
          525252525252525252525252525252D4D4D4D4D4D45252525252525252525252
          5252525252525252525252525252525252525252525252525252525252525252
          5252525252525252525252525252525252525252525252D4D4D4D4D4D4525252
          5252525252525252525252525252525252526767678080808080808080808080
          80808080808080676767525252525252525252525252525252525252525252D4
          D4D4D4D4D45252525252525252525252525252525252527D7D7DFCFCFCFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC7C7C7C5252525252525252525252
          52525252525252D4D4D4D4D4D4525252525252525252525252525252525252A7
          A7A7FFFFFF808080808080808080808080808080808080FFFFFFA7A7A7525252
          525252525252525252525252525252D4D4D4D4D4D45252525252525252525252
          52525252525252A8A8A8FFFFFF525252525252525252525252525252525252FF
          FFFFA8A8A8525252525252525252525252525252626262F2F2F2D4D4D4525252
          525252525252525252525252525252A8A8A8FFFFFF5252525252525252525252
          52525252525252FFFFFFA8A8A8525252525252525252525252616161E2E2E2FF
          FFFFD4D4D4525252525252525252525252525252525252A8A8A8FFFFFF525252
          525252525252525252525252525252FFFFFFA8A8A85252525252525252526161
          61E2E2E2FFFFFFFFFFFFE6E6E6525252525252525252525252525252525252A8
          A8A8FFFFFF525252525252525252525252525252525252FFFFFFA8A8A8525252
          525252626262E4E4E4FFFFFFFFFFFFFFFFFFFFFFFF9999995252525252525252
          52525252525252A8A8A8FFFFFF525252525252525252525252525252525252FF
          FFFFA8A8A8525252626262E4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          E6E6E6D1D1D1D1D1D1D1D1D1D1D1D1E8E8E8FFFFFFD1D1D1D1D1D1D1D1D1D1D1
          D1D1D1D1D1D1D1FFFFFFE8E8E8D1D1D1F2F2F2FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF}
        Proportional = True
        Transparent = True
        ExplicitTop = 9
        ExplicitHeight = 31
      end
    end
    object edt_nome: TgpEdit
      Tag = 99
      Left = 222
      Top = 128
      Width = 338
      Height = 24
      Hint = 'Preencha com o valor desejado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edt_id: TgpEdit
      Tag = 99
      Left = 27
      Top = 128
      Width = 187
      Height = 24
      Hint = 'Preencha com o valor desejado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      DataFieldName = 'Id'
    end
    object edt_3: TgpEdit
      Tag = 99
      Left = 566
      Top = 128
      Width = 149
      Height = 24
      Hint = 'Preencha com o valor desejado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edt_4: TgpEdit
      Tag = 99
      Left = 27
      Top = 202
      Width = 187
      Height = 24
      Hint = 'Preencha com o valor desejado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object qryInsert: TFDQuery
    Connection = form_conexao.FDConnection
    Left = 608
    Top = 8
  end
end
