object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Grid Column Selector'
  ClientHeight = 508
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object chkLB1: TComboBox
    Left = 10
    Top = 31
    Width = 405
    Height = 22
    AutoDropDown = True
    Style = csOwnerDrawFixed
    DropDownCount = 24
    TabOrder = 0
    OnClick = chkLB1Click
    OnDrawItem = chkLB1DrawItem
    OnSelect = chkLB1Select
  end
  object Button1: TButton
    Left = 10
    Top = 4
    Width = 107
    Height = 21
    Caption = 'select all'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 130
    Top = 4
    Width = 107
    Height = 21
    Caption = 'deselect all'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 244
    Top = 4
    Width = 97
    Height = 21
    Caption = 'OK'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 347
    Top = 4
    Width = 68
    Height = 21
    Caption = 'exit'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 688
    Top = 4
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer2Timer
    Left = 388
    Top = 72
  end
end
