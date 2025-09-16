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
  object Button1: TButton
    Left = 216
    Top = 151
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
end
