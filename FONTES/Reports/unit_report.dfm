object frm_report: Tfrm_report
  Left = 0
  Top = 0
  Caption = 'frm_report'
  ClientHeight = 184
  ClientWidth = 327
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 8
    Top = 72
    Width = 311
    Height = 41
    Cursor = crHandPoint
    BevelOuter = bvNone
    Caption = 'Imprimir'
    Color = 12615680
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    OnClick = Panel2Click
    OnMouseEnter = Panel2MouseEnter
    OnMouseLeave = Panel2MouseLeave
  end
  object ppDBPipeline1: TppDBPipeline
    DataSource = form_conexao_tabelas.DataSourceClientes
    UserName = 'DBPipeline1'
    Left = 16
    Top = 16
    object ppDBPipeline1ppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'id'
      FieldName = 'id'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 0
    end
    object ppDBPipeline1ppField2: TppField
      FieldAlias = 'nome'
      FieldName = 'nome'
      FieldLength = 255
      DisplayWidth = 255
      Position = 1
    end
    object ppDBPipeline1ppField3: TppField
      FieldAlias = 'telefone'
      FieldName = 'telefone'
      FieldLength = 15
      DisplayWidth = 15
      Position = 2
    end
    object ppDBPipeline1ppField4: TppField
      FieldAlias = 'endereco'
      FieldName = 'endereco'
      FieldLength = 255
      DisplayWidth = 255
      Position = 3
    end
  end
  object Clientes: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline1
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    Template.FileName = 'D:\DelphiPaises\FONTES\Reports\relatorios\paises.rtm'
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    EmailSettings.ConnectionSettings.MailService = 'SMTP'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.EnableMultiPlugin = False
    LanguageID = 'Default'
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    ThumbnailSettings.PageHighlight.Width = 3
    ThumbnailSettings.ThumbnailSize = tsSmall
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.AllowExtract = True
    PDFSettings.EncryptSettings.AllowAssemble = True
    PDFSettings.EncryptSettings.AllowQualityPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.EncryptSettings.EncryptionType = etRC4
    PDFSettings.DigitalSignatureSettings.SignPDF = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PDFSettings.PDFAFormat = pafNone
    PreviewFormSettings.PageBorder.mmPadding = 0
    RTFSettings.AppName = 'ReportBuilder'
    RTFSettings.Author = 'ReportBuilder'
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    RTFSettings.Title = 'Report'
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<Texto a localizar>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    XLSSettings.WorksheetName = 'Report'
    CloudDriveSettings.DropBoxSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.DropBoxSettings.DirectorySupport = True
    CloudDriveSettings.GoogleDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.GoogleDriveSettings.DirectorySupport = False
    CloudDriveSettings.OneDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.OneDriveSettings.DirectorySupport = True
    Left = 56
    Top = 16
    Version = '22.01'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline1'
    object ppTitleBand1: TppTitleBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 17463
      mmPrintPosition = 0
      object ppLabel1: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label1'
        Border.mmPadding = 0
        Caption = 'Relat'#243'rio Clientes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 20
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 8467
        mmLeft = 64294
        mmTop = 5556
        mmWidth = 62177
        BandType = 1
        LayerName = Foreground
      end
    end
    object ppHeaderBand1: TppHeaderBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 23548
      mmPrintPosition = 0
      object ppShape2: TppShape
        DesignLayer = ppDesignLayer1
        UserName = 'Shape2'
        Brush.Color = clHighlight
        mmHeight = 8996
        mmLeft = 265
        mmTop = 8202
        mmWidth = 197644
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label2'
        Border.BorderPositions = [bpBottom]
        Border.Color = clWhite
        Border.Visible = True
        Border.Weight = 1.000000000000000000
        Border.mmPadding = 0
        Caption = 'ID'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5291
        mmLeft = 11377
        mmTop = 10319
        mmWidth = 4233
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel3: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label3'
        Border.BorderPositions = [bpBottom]
        Border.Color = clWhite
        Border.Visible = True
        Border.Weight = 1.000000000000000000
        Border.mmPadding = 0
        Caption = 'Nome'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5291
        mmLeft = 53711
        mmTop = 10319
        mmWidth = 11906
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel4: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label4'
        Border.BorderPositions = [bpBottom]
        Border.Color = clWhite
        Border.Visible = True
        Border.Weight = 1.000000000000000000
        Border.mmPadding = 0
        Caption = 'TELEFONE'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5291
        mmLeft = 103981
        mmTop = 10319
        mmWidth = 23019
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel5: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label5'
        Border.BorderPositions = [bpBottom]
        Border.Color = clWhite
        Border.Visible = True
        Border.Weight = 1.000000000000000000
        Border.mmPadding = 0
        Caption = 'ENDERE'#199'O'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5291
        mmLeft = 155311
        mmTop = 10319
        mmWidth = 24606
        BandType = 0
        LayerName = Foreground
      end
      object ppLine10: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line10'
        Border.mmPadding = 0
        Position = lpRight
        Weight = 0.750000000000000000
        mmHeight = 8996
        mmLeft = 25929
        mmTop = 8202
        mmWidth = 2117
        BandType = 0
        LayerName = Foreground
      end
      object ppLine11: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line11'
        Border.mmPadding = 0
        Position = lpRight
        Weight = 0.750000000000000000
        mmHeight = 8996
        mmLeft = 89959
        mmTop = 8202
        mmWidth = 2117
        BandType = 0
        LayerName = Foreground
      end
      object ppLine12: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line12'
        Border.mmPadding = 0
        Position = lpRight
        Weight = 0.750000000000000000
        mmHeight = 8996
        mmLeft = 139171
        mmTop = 8202
        mmWidth = 2117
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
      object ppShape1: TppShape
        DesignLayer = ppDesignLayer1
        UserName = 'Shape1'
        Brush.Color = clGradientInactiveCaption
        mmHeight = 8996
        mmLeft = 265
        mmTop = 2646
        mmWidth = 197644
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText3'
        Border.mmPadding = 0
        DataField = 'id'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 5027
        mmLeft = 1660
        mmTop = 5027
        mmWidth = 21250
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText4'
        Border.mmPadding = 0
        DataField = 'nome'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 5027
        mmLeft = 30163
        mmTop = 5027
        mmWidth = 57150
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText1: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText1'
        Border.mmPadding = 0
        DataField = 'telefone'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 5027
        mmLeft = 93398
        mmTop = 5027
        mmWidth = 43656
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText2: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText2'
        Border.mmPadding = 0
        DataField = 'endereco'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 5027
        mmLeft = 142082
        mmTop = 5027
        mmWidth = 50536
        BandType = 4
        LayerName = Foreground
      end
      object ppLine1: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line1'
        Border.mmPadding = 0
        Position = lpRight
        Weight = 0.750000000000000000
        mmHeight = 9038
        mmLeft = 25868
        mmTop = 2765
        mmWidth = 2182
        BandType = 4
        LayerName = Foreground
      end
      object ppLine2: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line2'
        Border.mmPadding = 0
        Position = lpRight
        Weight = 0.750000000000000000
        mmHeight = 8996
        mmLeft = 90848
        mmTop = 2646
        mmWidth = 1402
        BandType = 4
        LayerName = Foreground
      end
      object ppLine3: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line3'
        Border.mmPadding = 0
        Position = lpRight
        Weight = 0.750000000000000000
        mmHeight = 8996
        mmLeft = 139467
        mmTop = 2646
        mmWidth = 1558
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 21960
      mmPrintPosition = 0
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer1: TppDesignLayer
        UserName = 'Foreground'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object ppDBPipeline2: TppDBPipeline
    DataSource = form_conexao_tabelas.DataSourceProdutos
    UserName = 'DBPipeline2'
    Left = 8
    Top = 120
    object ppDBPipeline2ppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'id'
      FieldName = 'id'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 0
    end
    object ppDBPipeline2ppField2: TppField
      FieldAlias = 'nome'
      FieldName = 'nome'
      FieldLength = 255
      DisplayWidth = 255
      Position = 1
    end
    object ppDBPipeline2ppField3: TppField
      FieldAlias = 'tamanho'
      FieldName = 'tamanho'
      FieldLength = 5
      DisplayWidth = 5
      Position = 2
    end
    object ppDBPipeline2ppField4: TppField
      Alignment = taRightJustify
      FieldAlias = 'preco'
      FieldName = 'preco'
      FieldLength = 2
      DataType = dtDouble
      DisplayWidth = 11
      Position = 3
    end
  end
  object Produtos: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline2
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    Template.FileName = 'D:\DelphiPaises\FONTES\Reports\relatorios\estados.rtm'
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    EmailSettings.ConnectionSettings.MailService = 'SMTP'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.EnableMultiPlugin = False
    LanguageID = 'Default'
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    ThumbnailSettings.PageHighlight.Width = 3
    ThumbnailSettings.ThumbnailSize = tsSmall
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.AllowExtract = True
    PDFSettings.EncryptSettings.AllowAssemble = True
    PDFSettings.EncryptSettings.AllowQualityPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.EncryptSettings.EncryptionType = etRC4
    PDFSettings.DigitalSignatureSettings.SignPDF = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PDFSettings.PDFAFormat = pafNone
    PreviewFormSettings.PageBorder.mmPadding = 0
    RTFSettings.AppName = 'ReportBuilder'
    RTFSettings.Author = 'ReportBuilder'
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    RTFSettings.Title = 'Report'
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<Texto a localizar>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    XLSSettings.WorksheetName = 'Report'
    CloudDriveSettings.DropBoxSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.DropBoxSettings.DirectorySupport = True
    CloudDriveSettings.GoogleDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.GoogleDriveSettings.DirectorySupport = False
    CloudDriveSettings.OneDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.OneDriveSettings.DirectorySupport = True
    Left = 56
    Top = 120
    Version = '22.01'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline2'
    object ppTitleBand2: TppTitleBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 17463
      mmPrintPosition = 0
      object ppLabel6: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label1'
        Border.mmPadding = 0
        Caption = 'Relat'#243'rio Produtos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 20
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 8467
        mmLeft = 66940
        mmTop = 4498
        mmWidth = 65881
        BandType = 1
        LayerName = Foreground1
      end
    end
    object ppHeaderBand2: TppHeaderBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
      object ppShape3: TppShape
        DesignLayer = ppDesignLayer2
        UserName = 'Shape3'
        Brush.Color = clHighlight
        mmHeight = 8996
        mmLeft = 265
        mmTop = 1588
        mmWidth = 197644
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel7: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label2'
        Border.BorderPositions = [bpBottom]
        Border.Color = clWhite
        Border.Visible = True
        Border.Weight = 1.000000000000000000
        Border.mmPadding = 0
        Caption = 'ID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5292
        mmLeft = 8996
        mmTop = 3175
        mmWidth = 4233
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel8: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label3'
        Border.BorderPositions = [bpBottom]
        Border.Color = clWhite
        Border.Visible = True
        Border.Weight = 1.000000000000000000
        Border.mmPadding = 0
        Caption = 'PRODUTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5292
        mmLeft = 62706
        mmTop = 3704
        mmWidth = 21432
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel9: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label4'
        Border.BorderPositions = [bpBottom]
        Border.Color = clWhite
        Border.Visible = True
        Border.Weight = 1.000000000000000000
        Border.mmPadding = 0
        Caption = 'TAMANHO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5292
        mmLeft = 125677
        mmTop = 3704
        mmWidth = 21432
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel10: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label10'
        Border.BorderPositions = [bpBottom]
        Border.Color = clWhite
        Border.Visible = True
        Border.Weight = 1.000000000000000000
        Border.mmPadding = 0
        Caption = 'PRE'#199'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5292
        mmLeft = 168011
        mmTop = 3704
        mmWidth = 15346
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine7: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line7'
        Border.mmPadding = 0
        Position = lpRight
        Weight = 0.750000000000000000
        mmHeight = 8996
        mmLeft = 21696
        mmTop = 1588
        mmWidth = 2117
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine8: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line8'
        Border.mmPadding = 0
        Position = lpRight
        Weight = 0.750000000000000000
        mmHeight = 8996
        mmLeft = 118269
        mmTop = 1588
        mmWidth = 2117
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine9: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line9'
        Border.mmPadding = 0
        Position = lpRight
        Weight = 0.750000000000000000
        mmHeight = 8996
        mmLeft = 152665
        mmTop = 1588
        mmWidth = 2117
        BandType = 0
        LayerName = Foreground1
      end
    end
    object ppDetailBand2: TppDetailBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
      object ppShape4: TppShape
        DesignLayer = ppDesignLayer2
        UserName = 'Shape4'
        Brush.Color = clGradientInactiveCaption
        mmHeight = 8996
        mmLeft = 265
        mmTop = 2646
        mmWidth = 197644
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine4: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line4'
        Border.mmPadding = 0
        Position = lpRight
        Weight = 0.750000000000000000
        mmHeight = 8996
        mmLeft = 21696
        mmTop = 2646
        mmWidth = 2117
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText5: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText3'
        Border.mmPadding = 0
        DataField = 'id'
        DataPipeline = ppDBPipeline2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDBPipeline2'
        mmHeight = 5027
        mmLeft = 5556
        mmTop = 5027
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText6: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText4'
        Border.mmPadding = 0
        DataField = 'nome'
        DataPipeline = ppDBPipeline2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDBPipeline2'
        mmHeight = 5027
        mmLeft = 27252
        mmTop = 5027
        mmWidth = 91787
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText7: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText1'
        Border.mmPadding = 0
        DataField = 'tamanho'
        DataPipeline = ppDBPipeline2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDBPipeline2'
        mmHeight = 5027
        mmLeft = 121444
        mmTop = 5027
        mmWidth = 30214
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText8: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText8'
        Border.mmPadding = 0
        DataField = 'preco'
        DataPipeline = ppDBPipeline2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDBPipeline2'
        mmHeight = 5027
        mmLeft = 155311
        mmTop = 5027
        mmWidth = 40839
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine5: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line5'
        Border.mmPadding = 0
        Position = lpRight
        Weight = 0.750000000000000000
        mmHeight = 8996
        mmLeft = 118269
        mmTop = 2646
        mmWidth = 2117
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine6: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line6'
        Border.mmPadding = 0
        Position = lpRight
        Weight = 0.750000000000000000
        mmHeight = 8996
        mmLeft = 152665
        mmTop = 2646
        mmWidth = 2117
        BandType = 4
        LayerName = Foreground1
      end
    end
    object ppFooterBand2: TppFooterBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 21960
      mmPrintPosition = 0
    end
    object ppDesignLayers2: TppDesignLayers
      object ppDesignLayer2: TppDesignLayer
        UserName = 'Foreground1'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList2: TppParameterList
    end
  end
end
