object form_cadastro_condicional: Tform_cadastro_condicional
  Left = 0
  Top = 0
  ActiveControl = edt_qtt
  BorderStyle = bsNone
  Caption = 'form_cadastro_condicional'
  ClientHeight = 576
  ClientWidth = 952
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_fundo: TPanel
    Left = 0
    Top = 0
    Width = 952
    Height = 576
    Margins.Left = 15
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      952
      576)
    object lbl_informacao1: TLabel
      Left = 25
      Top = 89
      Width = 39
      Height = 17
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbl_informacao2: TLabel
      Left = 27
      Top = 183
      Width = 47
      Height = 17
      Caption = 'Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbl_informacao3: TLabel
      Left = 27
      Top = 339
      Width = 68
      Height = 17
      Caption = 'Quantidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 25
      Top = 273
      Width = 141
      Height = 17
      Caption = 'Quantidade em Estoque'
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
      Width = 952
      Height = 49
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lbl_titulo: TLabel
        AlignWithMargins = True
        Left = 15
        Top = 0
        Width = 199
        Height = 48
        Margins.Left = 15
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Adicionar itens Condicional'
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
        Left = 899
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
        Width = 952
        Height = 1
        Align = alBottom
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
      end
    end
    object edt_qtt: TNumberBox
      Left = 27
      Top = 362
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object pnl_add: TPanel
      Left = 27
      Top = 439
      Width = 209
      Height = 41
      Anchors = [akLeft, akBottom]
      Caption = 'Adicionar'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      OnClick = pnl_addClick
    end
    object edt_cod_clie: TEdit
      Left = 27
      Top = 112
      Width = 32
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object edt_cod_prod: TEdit
      Left = 27
      Top = 208
      Width = 30
      Height = 21
      ReadOnly = True
      TabOrder = 4
    end
    object edt_qtt_estoque: TEdit
      Left = 27
      Top = 296
      Width = 56
      Height = 21
      ReadOnly = True
      TabOrder = 5
    end
    object pnl_registros: TPanel
      Left = 344
      Top = 112
      Width = 598
      Height = 409
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 6
      object dbg_registros: TDBGrid
        Left = 1
        Top = 1
        Width = 596
        Height = 407
        Align = alClient
        DataSource = dsCondPendente
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object Panel1: TPanel
      Left = 27
      Top = 495
      Width = 209
      Height = 41
      Anchors = [akLeft, akBottom]
      Caption = 'Remover'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 7
      OnClick = Panel1Click
    end
  end
  object cbb_produtos: TComboBox
    Left = 63
    Top = 208
    Width = 166
    Height = 21
    TabOrder = 1
    OnChange = cbb_produtosChange
  end
  object cbb_clientes: TComboBox
    Left = 63
    Top = 112
    Width = 166
    Height = 21
    TabOrder = 2
    OnChange = cbb_clientesChange
  end
  object qryProdutos: TFDQuery
    Connection = form_conexao.FDConnection
    Left = 248
    Top = 8
  end
  object qryClientes: TFDQuery
    Connection = form_conexao.FDConnection
    Left = 296
    Top = 8
  end
  object dsCondPendente: TDataSource
    DataSet = qryCondPendente
    Left = 664
    Top = 8
  end
  object qryCondPendente: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      
        'select id, id_produto, nome_produto, quantidade_condicional, id_' +
        'condicional from condicional_pendente'
      'where id_condicional = :id')
    Left = 592
    Top = 8
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object qryCond: TFDQuery
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      
        'Select id, cliente_id, data_entregue, data_devolucao, nome_clien' +
        'te from condicional where cliente_id = :id')
    Left = 432
    Top = 8
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryCondid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryCondcliente_id: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'cliente_id'
      Origin = 'cliente_id'
    end
    object qryConddata_entregue: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'data_entregue'
      Origin = 'data_entregue'
    end
    object qryConddata_devolucao: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'data_devolucao'
      Origin = 'data_devolucao'
    end
    object qryCondnome_cliente: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_cliente'
      Origin = 'nome_cliente'
      Size = 100
    end
  end
  object dsCond: TDataSource
    DataSet = qryCond
    Left = 488
    Top = 8
  end
end
