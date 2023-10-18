object form_configuracao_servidor: Tform_configuracao_servidor
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  ClientHeight = 544
  ClientWidth = 751
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_fundo: TPanel
    Left = 0
    Top = 0
    Width = 751
    Height = 544
    Margins.Left = 15
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      751
      544)
    object lbl_nova_configuracao: TLabel
      Left = 17
      Top = 69
      Width = 189
      Height = 17
      Caption = 'Nova configura'#231#227'o do Servidor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8404992
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
    end
    object lbl_configuracao_atual: TLabel
      Left = 17
      Top = 277
      Width = 177
      Height = 17
      Caption = 'Dados da Configura'#231#227'o Atual'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
    end
    object lbl_servidor_novo: TLabel
      Left = 25
      Top = 110
      Width = 92
      Height = 17
      Caption = 'Ip do servidor *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbl_base_dados_novo: TLabel
      Left = 220
      Top = 110
      Width = 201
      Height = 17
      Caption = 'Caminho / Nome da Base Dados *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbl_porta_novo: TLabel
      Left = 566
      Top = 110
      Width = 40
      Height = 17
      Caption = 'Porta *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbl_login_novo: TLabel
      Left = 25
      Top = 179
      Width = 41
      Height = 17
      Caption = 'Login *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbl_senha_novo: TLabel
      Left = 220
      Top = 179
      Width = 44
      Height = 17
      Caption = 'Senha *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbl_servidor: TLabel
      Left = 25
      Top = 318
      Width = 142
      Height = 17
      Caption = 'Nome do Servidor Atual'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbl_porta: TLabel
      Left = 566
      Top = 318
      Width = 64
      Height = 17
      Caption = 'Porta Atual'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbl_base_dados: TLabel
      Left = 220
      Top = 318
      Width = 176
      Height = 17
      Caption = 'Caminho da Base Dados Atual'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbl_login: TLabel
      Left = 25
      Top = 387
      Width = 65
      Height = 17
      Caption = 'Login Atual'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbl_senha: TLabel
      Left = 220
      Top = 387
      Width = 68
      Height = 17
      Caption = 'Senha Atual'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object btn_salvar: TSpeedButton
      AlignWithMargins = True
      Left = 262
      Top = 472
      Width = 189
      Height = 38
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Anchors = [akTop]
      Caption = 'Salvar Configura'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5395026
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        E6E6E6D1D1D1E8E8E8FFFFFFD1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1
        D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1FFFFFFE8E8E8D1D1D1E6E6E6FFFFFFFF
        FFFFFFFFFF9A9A9A525252525252A8A8A8FFFFFF525252525252525252525252
        525252525252525252525252525252525252525252525252FFFFFFA8A8A85252
        525252529B9B9BFFFFFFE6E6E6525252525252525252A8A8A8FFFFFF52525252
        5252525252525252525252525252525252525252525252525252525252525252
        FFFFFFA8A8A8525252525252525252E6E6E6D4D4D4525252525252525252A8A8
        A8FFFFFF52525252525252525252525252525252525252525252525252525252
        5252525252525252FFFFFFA8A8A8525252525252525252D4D4D4D4D4D4525252
        525252525252A8A8A8FFFFFF5252525252525252525252525252525252525252
        52525252525252525252525252525252FFFFFFA8A8A8525252525252525252D4
        D4D4D4D4D4525252525252525252A8A8A8FFFFFF525252525252525252525252
        525252525252525252525252525252525252525252525252FFFFFFA8A8A85252
        52525252525252D4D4D4D4D4D4525252525252525252A8A8A8FFFFFF52525252
        5252525252525252525252525252525252525252525252525252525252525252
        FFFFFFA8A8A8525252525252525252D4D4D4D4D4D4525252525252525252A4A4
        A4FFFFFF5B5B5B52525252525252525252525252525252525252525252525252
        52525252525B5B5BFFFFFFA4A4A4525252525252525252D4D4D4D4D4D4525252
        525252525252777777FEFEFEE7E7E7D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1
        D1D1D1D1D1D1D1D1D1D1D1D1D1E7E7E7FEFEFE777777525252525252525252D4
        D4D4D4D4D4525252525252525252525252898989C9C9C9D1D1D1D1D1D1D1D1D1
        D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1C9C9C98989895252525252
        52525252525252D4D4D4D4D4D452525252525252525252525252525252525252
        5252525252525252525252525252525252525252525252525252525252525252
        525252525252525252525252525252D4D4D4D4D4D45252525252525252525252
        5252525252525252525252525252525252525252525252525252525252525252
        5252525252525252525252525252525252525252525252D4D4D4D4D4D4525252
        5252525252525252525252525252525252525252525252525252525252525252
        52525252525252525252525252525252525252525252525252525252525252D4
        D4D4D4D4D4525252525252525252525252525252525252525252525252525252
        5252525252525252525252525252525252525252525252525252525252525252
        52525252525252D4D4D4D4D4D452525252525252525252525252525252525252
        5252525252525252525252525252525252525252525252525252525252525252
        525252525252525252525252525252D4D4D4D4D4D45252525252525252525252
        5252525252525252525267676780808080808080808080808080808080808067
        6767525252525252525252525252525252525252525252D4D4D4D4D4D4525252
        5252525252525252525252525252527D7D7DFCFCFCFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFCFCFC7C7C7C525252525252525252525252525252525252D4
        D4D4D4D4D4525252525252525252525252525252525252A7A7A7FFFFFF808080
        808080808080808080808080808080FFFFFFA7A7A75252525252525252525252
        52525252525252D4D4D4D4D4D4525252525252525252525252525252525252A8
        A8A8FFFFFF525252525252525252525252525252525252FFFFFFA8A8A8525252
        525252525252525252525252626262F2F2F2D4D4D45252525252525252525252
        52525252525252A8A8A8FFFFFF525252525252525252525252525252525252FF
        FFFFA8A8A8525252525252525252525252616161E2E2E2FFFFFFD4D4D4525252
        525252525252525252525252525252A8A8A8FFFFFF5252525252525252525252
        52525252525252FFFFFFA8A8A8525252525252525252616161E2E2E2FFFFFFFF
        FFFFE6E6E6525252525252525252525252525252525252A8A8A8FFFFFF525252
        525252525252525252525252525252FFFFFFA8A8A8525252525252626262E4E4
        E4FFFFFFFFFFFFFFFFFFFFFFFF999999525252525252525252525252525252A8
        A8A8FFFFFF525252525252525252525252525252525252FFFFFFA8A8A8525252
        626262E4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6E6E6D1D1D1D1D1
        D1D1D1D1D1D1D1E8E8E8FFFFFFD1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1FF
        FFFFE8E8E8D1D1D1F2F2F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      Spacing = 10
      OnClick = btn_salvarClick
      ExplicitLeft = 392
    end
    object pnl_topo: TPanel
      Left = 0
      Top = 0
      Width = 751
      Height = 49
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lbl_titulo: TLabel
        AlignWithMargins = True
        Left = 15
        Top = 0
        Width = 229
        Height = 48
        Margins.Left = 15
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'CONFIGURA'#199#195'O DO SERVIDOR'
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
        Left = 698
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
        ExplicitTop = 1
      end
      object pnl_separador_topo: TPanel
        Left = 0
        Top = 48
        Width = 751
        Height = 1
        Align = alBottom
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
      end
    end
    object edt_servidor_novo: TEdit
      Tag = 99
      Left = 25
      Top = 128
      Width = 187
      Height = 25
      Hint = 'Nome do Servidor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edt_caminho_novo: TEdit
      Tag = 99
      Left = 222
      Top = 128
      Width = 338
      Height = 25
      Hint = 'Caminho ou Nome da Base de Dados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edt_porta_novo: TEdit
      Tag = 99
      Left = 566
      Top = 128
      Width = 149
      Height = 25
      Hint = 'N'#250'mero da Porta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edt_login_novo: TEdit
      Tag = 99
      Left = 27
      Top = 202
      Width = 187
      Height = 25
      Hint = 'Login'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object edt_senha_novo: TEdit
      Tag = 98
      Left = 220
      Top = 202
      Width = 187
      Height = 25
      Hint = 'Senha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 5
    end
    object edt_nome_servidor_atual: TEdit
      Left = 25
      Top = 336
      Width = 187
      Height = 25
      CharCase = ecUpperCase
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5395026
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
    end
    object edt_caminho_atual: TEdit
      Left = 220
      Top = 336
      Width = 338
      Height = 25
      CharCase = ecUpperCase
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5395026
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 7
    end
    object edt_porta_atual: TEdit
      Left = 566
      Top = 336
      Width = 149
      Height = 25
      CharCase = ecUpperCase
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5395026
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
    end
    object edt_login_atual: TEdit
      Left = 25
      Top = 405
      Width = 187
      Height = 25
      CharCase = ecUpperCase
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5395026
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
    end
    object edt_senha_atual: TEdit
      Left = 220
      Top = 405
      Width = 187
      Height = 25
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5395026
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      ReadOnly = True
      TabOrder = 10
    end
    object pnl_separacao: TPanel
      Left = 8
      Top = 249
      Width = 730
      Height = 1
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 11
    end
  end
end
