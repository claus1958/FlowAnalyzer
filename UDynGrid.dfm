object DynGrid: TDynGrid
  Left = 0
  Top = 0
  Width = 757
  Height = 631
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 757
    Height = 41
    TabOrder = 0
    object lblHeader: TLabel
      Left = 264
      Top = 12
      Width = 5
      Height = 19
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 4
    Top = 44
    Width = 753
    Height = 589
    TabOrder = 1
    OnResize = Panel2Resize
    object SG: TStringGridSorted
      Left = 1
      Top = 1
      Width = 735
      Height = 587
      Align = alClient
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      ScrollBars = ssHorizontal
      TabOrder = 0
    end
    object ScrollBar1: TScrollBar
      Left = 736
      Top = 1
      Width = 16
      Height = 587
      Align = alRight
      Kind = sbVertical
      PageSize = 0
      TabOrder = 1
      OnChange = ScrollBar1Change
    end
  end
end
