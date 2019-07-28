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
    object lblTime: TLabel
      Left = 672
      Top = 12
      Width = 32
      Height = 13
      Caption = 'lblTime'
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
      DoubleBuffered = True
      FixedCols = 0
      RowCount = 2
      Options = [goRangeSelect, goColSizing, goFixedColClick, goFixedRowClick]
      ParentDoubleBuffered = False
      ScrollBars = ssHorizontal
      TabOrder = 0
      OnDrawCell = SGDrawCell
      OnMouseDown = SGMouseDown
      OnMouseUp = SGMouseUp
      OnRowMoved = SGRowMoved
    end
    object ScrollBar1: TScrollBar
      Left = 736
      Top = 1
      Width = 16
      Height = 587
      Align = alRight
      Kind = sbVertical
      LargeChange = 100
      PageSize = 0
      TabOrder = 1
      OnChange = ScrollBar1Change
      OnScroll = ScrollBar1Scroll
    end
  end
end
