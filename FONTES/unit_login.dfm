object form_login: Tform_login
  Left = 0
  Top = 0
  Align = alClient
  Anchors = [akLeft, akTop, akBottom]
  BorderStyle = bsNone
  ClientHeight = 768
  ClientWidth = 1024
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object pnl_fundo: TPanel
    Left = 0
    Top = 0
    Width = 712
    Height = 768
    Align = alClient
    BevelOuter = bvNone
    Color = 1315860
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      712
      768)
    object pnl_imagem: TPanel
      Left = 216
      Top = 88
      Width = 413
      Height = 564
      Anchors = []
      BevelOuter = bvNone
      TabOrder = 0
      object lbl_titulo: TLabel
        Left = 0
        Top = 517
        Width = 413
        Height = 30
        Align = alBottom
        Alignment = taCenter
        Caption = 'ERPSTORE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 102
      end
      object lbl_versao: TLabel
        Left = 0
        Top = 547
        Width = 413
        Height = 17
        Align = alBottom
        Alignment = taCenter
        Caption = 'vers'#227'o 1.0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 33023
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 60
      end
      object lbl_bemvindo: TLabel
        Left = 0
        Top = 0
        Width = 413
        Height = 30
        Align = alTop
        Alignment = taCenter
        Caption = 'Bem-Vindo ao ERPSTORE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 248
      end
    end
  end
  object pnl_lateral: TPanel
    Left = 712
    Top = 0
    Width = 312
    Height = 768
    Align = alRight
    BevelOuter = bvNone
    Color = 1644825
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      312
      768)
    object img_botao_sair: TImage
      AlignWithMargins = True
      Left = 256
      Top = 8
      Width = 48
      Height = 48
      Cursor = crHandPoint
      Hint = 'Sair do Sistema'
      Margins.Right = 10
      Anchors = [akTop, akRight]
      AutoSize = True
      Center = True
      ParentShowHint = False
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000300000
        003008000000007269A65B000000097048597300000B1300000B1301009A9C18
        000003186943435050686F746F73686F70204943432070726F66696C65000078
        DA6360609EE0E8E2E4CA24C0C050505452E41EE418191119A5C07E9E818D8199
        81818181812131B9B8C03120C087818181212F3F2F9501153032307CBBC6C0C8
        C0C0C07059D7D1C5C9958134C09A5C5054C2C0C070808181C12825B538998181
        E10B0303437A794941090303630C030383485276410903036301030383487648
        90330303630B0303134F496A450903030383737E416551667A468982A1A5A5A5
        82634A7E52AA42706571496A6EB182675E727E51417E5162496A0A030303D40E
        060606065E97FC1205F7C4CC3C05230355062A8388C82805080B113E08310448
        2E2D2A83072503830083028301830343004322433DC30286A30C6F18C5195D18
        4B195730DE6312630A629AC07481599839927921F31B164B960E965BAC7AACAD
        ACF7D82CD9A6B17D630F67DFCDA1C4D1C5F1853391F3029723D7166E4DEE053C
        523C5379857827F109F34DE397E15F2CA023B043D055F08A50AAD00FE15E1115
        91BDA2E1A25FC426891B895F91A89094933C26952F2D2D7D42A64C565DF6965C
        9FBC8BFC1F85AD8A854A7A4A6F95D7AA14A89AA8FE543BA8DEA511AAA9A4F941
        EB80F6249D545D2B3D41BD57FA470C1618D61AC518DB9AC89B329BBE34BB60BE
        D36289E504AB3AEB5C9B38DB403B577B6B0763471D2735672517055779370577
        650F754F5D2F136F1B1F77DF60BF04FFFC80FAC089414B8377855C0C7D19CE14
        2117691515115D113333764FDC8304B644DDA4B0E4869435A937D339322C3233
        B3E6665FCC65CFB3CFAF28D854F8AE58BB24AB7455D99B0AFDCA92AA5D358CB5
        5E7553EB1F36EA35D5349F6D956B2B6C3FDA29DD55D47DBA57B5AFB1FFEE449B
        49B327FF9D1A3FEDF00C8D99FDB3BECF49987B7ABEF982A58B4416B72EF9B62C
        73F9BD9521AB4EAF7159BB6FBDE5866D9B4C366FD96AB26DFB0EAB9DFB77BBEE
        39BB2F6CFF838339877E1E693F267E7CC549EB53E7CE249FFD757ED245ED4B47
        AF245EFD777DCE4D9B5B77EFD4DF53BE7FE261DE63B127FB9F65BE107979F075
        FE5BF977173E347D32FDFCEAEB82EFE13F057E9DFAD3FACFF1FF7F000D000F34
        FA96F15D000002974944415478DADDD54B6813411800E099D96C5E9B8744A5B1
        1E3C893D781144292A68F520EA410F8156B0D25A68BDA9A77AF1627BD1AB502D
        A5B1584803A5A591AA2524340A52AB39B4D51C04F1A0CDBBD924CD7BB33B6E1E
        DBAC74379B5E3B97CCFEE1DBFF1FE69F597804EC6DC07D05F2653514FD812141
        3401908B1E326D218D88E03436C9032ED7633BFC7B33CEAA101410BDB246212C
        0D70BCFF55E5B7140AA618565DAD056AD376B71E4983029EBB547B66E93FF104
        ABAECE8DD9A7BF0CD2206B767636629B6B29B29AD732E5D2224990333ACE8B82
        B487AD56A5FFE0205A02C01353ED000C5B00BE500DBC9F51153384418D1500F6
        8505503C3B12184E1DC4CA00132A48BD9D4ED87B81F33E63E69400A967E365BD
        D79570D80070F5954CB839881A56DD498C0AB9F8540F1F981FC80A554983E58C
        6F6ABBC8CF4866B2AF12991D2CD5AB92062B1BCF82BA536D0C00A9E15A0B2C0C
        325A2C0FD627EDB9074F4C2C3F47F56D187FA827E5C1F7B1D7F9B1A1FF36ECF3
        5552230FFC4B2FE813F72AC7217FE5783514EDFE626EB2864F5BF62558E4BB02
        956B8B0EDDF1B6375BF47232E7FC9A6681461B9BBECD07B66F7AADB0E93E848C
        2010E4343FFC8937DD00C46CBE36A16BE5769A40941A527313F4EC2D10ECF51C
        556C0DA1F93243A3897EB7B5D1E24A007167FEFE3C203A124A4085931A83F8EA
        5002AD1DD11DD0EA99168061716F19B06562512F03CC339D62F0B102A031381A
        A1802428A0F90B62B01A23208691F18D5D175F1D70B1C723A220F732A00520FC
        2DAC93BB8C01831EDDB53632DC78C7BF1A9124043219002AA43B4E5FEBB2D4A3
        5D7E0AC80CE10B04CBA9B2C97AF1FAC963FCC3C200209540A510B65C28765C3E
        D7BEFE9C964DB0EBA3984BE92C11CAC0B50C002C311A1506AD03A5B11FC03F84
        FE4BF071C587FB0000000049454E44AE426082}
      ShowHint = True
      OnClick = img_botao_sairClick
      ExplicitLeft = 216
    end
    object img_logo_empresa: TImage
      Left = 111
      Top = 104
      Width = 128
      Height = 128
      AutoSize = True
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000800000
        00800806000000C33E61CB000000017352474200AECE1CE90000000467414D41
        0000B18F0BFC6105000000097048597300000EC200000EC20115284A80000003
        874944415478DAEDDCCD4B54511C87F173C799F02D6754A25AD80B6D22A4BDB4
        8868530D244464668B162D2270D73E084A42FF8076AD32085BB468A125445814
        D4464B5D8891AB76CE581638E3DCAEB46A73181DCFF18CDFE7037760E032BF73
        390F677727329016EDF402B0B308401C018823007104208E00C4118038021047
        00E208405C6D01C4B139FBD0B435C6C5D44E3F48680AC9953345333475DB6493
        6F45C7F3B2C9B44AFA677CE4C5DBE26636B5A6007AEF2E67FF34663E35A433ED
        9572C9F123D6975294366DE5A2999D1CEEF439F7D581B9F6C34F5F16AABDBFA6
        00F243855CD9A497D24D2D7B09E07FE52863DA4A0533337EDFEBDCD79DD31D87
        C62696ABBD7F3B02584865F67456CA6B5E1F3474E58D13A054345F2787BDCE25
        804010803802104700E208401C018823007104208E00C411803802104700E208
        401C018823007104208E00C411803802104700E208401C01882300713A01C48D
        0B0D4900EB1E02D8586C94AE8FB7D0CAA92480B5A29999D8D52F867CCFADA5FE
        05E0FE048836DE45AC4471D34A6C5215C7C36AB69E9C00D95221FA3239D2EE73
        AED700BA9FF4E75A272E563D6C3B34F5986399D5F35E676ED5B985D1DCA3F9C5
        459F333D07904F02B8EE75330A37FA5BE7CF98559F33B7AAD26D9A8FEFBBE375
        ADBB3E80F8C2F38E8F7D637571024CE74FE52EFFEEF1BA560208080138400076
        04101002708000EC08202004E00001D811404008C00102B02380801080030460
        47000121000708C08E000242000E10801D010484001C20003B02080801384000
        7604101002708000EC08202004E00001D811404008C00102B023808010800304
        6047000121000708C08E000242000E10801D010484001C20003B020808013840
        007604101002708000EC08202004E00001D811404008C0810FF9B95673E55E5D
        FC51E4F8FE81E6C11307F9A3C8ED74EDD283A383BF660A3E676ED58FD9AEDCE9
        F77DDF7CCEDCF501A4963EFB1C5777A66E8D74A4FA0C01A822007104208E00C4
        11803802104700E208401C018823007104208E00C411803802104700E208401C
        018823007104208E00C411803802104700E208401C01882300715E0338F9B837
        DBFCE6AAD7F7F408C0EEDDCD91F668C054BD27350560E2E41418CDE75AD24DB5
        FD4E155692AB2BF97C66264C9BEB61F5289B6C6639D991BC29449BD80DE71B87
        B011803802104700E208401C018823007104208E00C411803802104700E20840
        1C01882300717F0152DE7CCC5A27801F0000000049454E44AE426082}
    end
    object lbl_autor: TLabel
      Left = 18
      Top = 221
      Width = 278
      Height = 35
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Desenvolvido por Guilherme Provenci de Lima. Todos os Direitos R' +
        'eservados.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object pnl_campos: TPanel
      Left = 0
      Top = 505
      Width = 312
      Height = 263
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object pnl_botao_entrar: TPanel
        Tag = 7
        AlignWithMargins = True
        Left = 59
        Top = 167
        Width = 166
        Height = 41
        Cursor = crHandPoint
        Margins.Top = 5
        BevelOuter = bvNone
        Color = clBlack
        ParentBackground = False
        TabOrder = 0
        OnClick = pnl_botao_entrarClick
        OnMouseEnter = lbl_botao_entrarMouseEnter
        OnMouseLeave = lbl_botao_entrarMouseLeave
        object img_botao_impostos: TImage
          Tag = 7
          AlignWithMargins = True
          Left = 10
          Top = 3
          Width = 32
          Height = 35
          Margins.Left = 10
          Align = alLeft
          AutoSize = True
          Center = True
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
            002008000000005611252800000002624B47440000AA8D233200000009704859
            73000000600000006000F06B42CF0000000774494D4507E704050B0A05831B24
            8C000000FE4944415478DA6364200018E9AE404C16CEFC74E73F8602B645E148
            BC4D01FFD11514F73C39CEC0C0EECE0EE16ADC4457B0C9D7EC3403E3616B28D7
            E42CBA820D7E922F19641E336057201D314BCC700D0383D25D1C0A9A6A8F7A7E
            66C0A3A0A39CE198E727FC0AC02AB029605F010C1F6909206BAF0B560542B784
            A1628F15FE61B5828D9B81A13E9F81E195F315BC6E78ED7C19AF2341FAF128B0
            AA2DB929F0068F022098172EF909AF82DD2ECAF7F02AD8EEA17D0DAF82F68A43
            DB1884CA702B103CA88BCCD5BB8CAE8081DD518E41A415CA396FF687015BAA16
            7F01227FEF5DBDE21B0356050C8B6380B21BDE4179D8F285CAEB8F080EFDB31E
            2600006E5A63217ED4645A0000002574455874646174653A6372656174650032
            3032332D30342D30355431313A31303A30352B30303A303075FAD3D200000025
            74455874646174653A6D6F6469667900323032332D30342D30355431313A3130
            3A30352B30303A303004A76B6E0000002874455874646174653A74696D657374
            616D7000323032332D30342D30355431313A31303A30352B30303A303053B24A
            B10000000049454E44AE426082}
          Transparent = True
          OnClick = pnl_botao_entrarClick
          OnMouseEnter = lbl_botao_entrarMouseEnter
          OnMouseLeave = lbl_botao_entrarMouseLeave
          ExplicitHeight = 32
        end
        object lbl_botao_entrar: TLabel
          Tag = 7
          Left = 52
          Top = 13
          Width = 92
          Height = 15
          Caption = 'Entrar no Sistema'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          OnClick = pnl_botao_entrarClick
          OnMouseEnter = lbl_botao_entrarMouseEnter
          OnMouseLeave = lbl_botao_entrarMouseLeave
        end
      end
      object pnl_login: TPanel
        Left = 24
        Top = 7
        Width = 249
        Height = 65
        BevelOuter = bvNone
        Color = 1644825
        ParentBackground = False
        TabOrder = 1
        object lbl_login: TLabel
          Left = 0
          Top = 0
          Width = 249
          Height = 13
          Align = alTop
          Caption = 'LOGIN'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clSilver
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 33
        end
        object edt_login: TEdit
          AlignWithMargins = True
          Left = 0
          Top = 28
          Width = 249
          Height = 24
          Margins.Left = 0
          Margins.Top = 15
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          BorderStyle = bsNone
          CharCase = ecUpperCase
          Color = 1644825
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object pnl_barra_login: TPanel
          Left = 0
          Top = 52
          Width = 249
          Height = 1
          Align = alTop
          TabOrder = 1
        end
      end
      object pnl_senha: TPanel
        Left = 24
        Top = 87
        Width = 249
        Height = 65
        BevelOuter = bvNone
        Color = 1644825
        ParentBackground = False
        TabOrder = 2
        object lbl_senha: TLabel
          Left = 0
          Top = 0
          Width = 249
          Height = 13
          Align = alTop
          Caption = 'SENHA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clSilver
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 35
        end
        object edt_senha: TEdit
          AlignWithMargins = True
          Left = 0
          Top = 28
          Width = 249
          Height = 24
          Margins.Left = 0
          Margins.Top = 15
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          BorderStyle = bsNone
          CharCase = ecUpperCase
          Color = 1644825
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          PasswordChar = '*'
          TabOrder = 0
        end
        object pnl_barra_senha: TPanel
          Left = 0
          Top = 52
          Width = 249
          Height = 1
          Align = alTop
          TabOrder = 1
        end
      end
    end
  end
end
