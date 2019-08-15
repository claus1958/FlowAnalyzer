object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Loading ...'
  ClientHeight = 439
  ClientWidth = 722
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 20
    Width = 440
    Height = 35
    Caption = 'Loading data in the background ...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
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
    OnClick = Button2Click
  end
  object lbLoadInfo: TListBox
    Left = 8
    Top = 79
    Width = 705
    Height = 138
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 23
    ParentFont = False
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 8
    Top = 223
    Width = 705
    Height = 130
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 4
    Top = 4
  end
end
