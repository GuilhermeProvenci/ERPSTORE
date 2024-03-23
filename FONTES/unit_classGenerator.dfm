object FrmClassGenerator: TFrmClassGenerator
  Left = 0
  Top = 0
  Caption = 'FrmClassGenerator'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 628
    Height = 442
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 232
    ExplicitTop = 224
    ExplicitWidth = 185
    ExplicitHeight = 41
    object gerar: TButton
      Left = 48
      Top = 184
      Width = 75
      Height = 25
      Caption = 'gerar'
      TabOrder = 0
      OnClick = gerarClick
    end
    object Memo1: TMemo
      Left = 32
      Top = 64
      Width = 185
      Height = 89
      Lines.Strings = (
        '')
      TabOrder = 1
    end
  end
end
