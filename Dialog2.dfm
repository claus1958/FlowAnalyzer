object Dialog2: TDialog2
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 222
  BorderStyle = bsNone
  Caption = 'Loading ...'
  ClientHeight = 85
  ClientWidth = 500
  Color = 2105376
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  StyleElements = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblInfo: TLabel
    Left = 0
    Top = 16
    Width = 500
    Height = 29
    Alignment = taCenter
    AutoSize = False
    Caption = '-'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
    StyleElements = [seClient, seBorder]
  end
  object lblInfo2: TLabel
    Left = 0
    Top = 51
    Width = 500
    Height = 18
    Alignment = taCenter
    AutoSize = False
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
    StyleElements = [seClient, seBorder]
  end
  object Button1: TButton
    Left = 254
    Top = 210
    Width = 253
    Height = 29
    Caption = 'Weiter'
    TabOrder = 0
    Visible = False
    OnClick = Button1Click
  end
  object btnLoadNow: TButton
    Left = 0
    Top = 210
    Width = 253
    Height = 29
    Caption = 'btnLoadNow'
    TabOrder = 1
    Visible = False
  end
  object btnFinishUpdate: TButton
    Left = 0
    Top = 0
    Width = 500
    Height = 85
    Caption = 'Click to finish Update now ...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Visible = False
    OnClick = btnFinishUpdateClick
  end
  object lbLoadInfo: TListBox
    Left = 0
    Top = 102
    Width = 248
    Height = 106
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 19
    ParentFont = False
    TabOrder = 3
  end
  object Memo1: TMemo
    Left = 254
    Top = 102
    Width = 253
    Height = 106
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 544
    Top = 28
  end
  object Timer2: TTimer
    Interval = 10
    OnTimer = Timer2Timer
    Left = 428
    Top = 24
  end
end
