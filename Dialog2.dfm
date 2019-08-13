object Dialog2: TDialog2
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 177
  BorderStyle = bsDialog
  Caption = 'Loading ...'
  ClientHeight = 203
  ClientWidth = 242
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 368
    Top = 402
    Width = 253
    Height = 29
    Caption = 'Weiter'
    TabOrder = 0
    Visible = False
    OnClick = Button1Click
  end
  object btnLoadNow: TButton
    Left = 24
    Top = 402
    Width = 253
    Height = 29
    Caption = 'btnLoadNow'
    TabOrder = 1
    Visible = False
  end
  object lbLoadInfo: TListBox
    Left = 0
    Top = 0
    Width = 248
    Height = 106
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 19
    ParentFont = False
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 0
    Top = 107
    Width = 248
    Height = 98
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 544
    Top = 28
  end
end
