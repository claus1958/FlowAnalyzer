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
      Width = 4
      Height = 19
      Caption = '!'
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
      Width = 4
      Height = 13
      Caption = '!'
    end
    object lblSelection: TLabel
      Left = 24
      Top = 12
      Width = 4
      Height = 13
      Caption = '!'
    end
  end
  object Panel2: TPanel
    Left = 4
    Top = 44
    Width = 753
    Height = 589
    TabOrder = 1
    OnResize = Panel2Resize
    object ScrollBar1: TScrollBar
      Left = 736
      Top = 1
      Width = 16
      Height = 587
      Align = alRight
      Kind = sbVertical
      LargeChange = 100
      PageSize = 0
      TabOrder = 0
      OnChange = ScrollBar1Change
      OnScroll = ScrollBar1Scroll
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 735
      Height = 587
      Align = alClient
      TabOrder = 1
      object SG: TStringGridSorted
        Left = 1
        Top = 1
        Width = 733
        Height = 555
        Align = alClient
        Color = 3881787
        DoubleBuffered = True
        FixedCols = 0
        RowCount = 2
        Options = [goVertLine, goHorzLine, goRangeSelect, goColSizing, goFixedColClick, goFixedRowClick]
        ParentDoubleBuffered = False
        ScrollBars = ssHorizontal
        TabOrder = 0
        StyleElements = [seFont, seBorder]
        OnDrawCell = SGDrawCell
        OnKeyDown = SGKeyDown
        OnKeyPress = SGKeyPress
        OnMouseDown = SGMouseDown
        OnMouseUp = SGMouseUp
        OnMouseWheelDown = SGMouseWheelDown
        OnMouseWheelUp = SGMouseWheelUp
        OnRowMoved = SGRowMoved
        OnSelectCell = SGSelectCell
        OnTopLeftChanged = SGTopLeftChanged
        ColWidths = (
          64
          64
          64
          64
          64)
      end
      object SGSum: TStringGridSorted
        Left = 1
        Top = 556
        Width = 733
        Height = 30
        Align = alBottom
        Color = 3881787
        DoubleBuffered = True
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsItalic]
        Options = [goVertLine, goHorzLine, goRangeSelect, goColSizing, goFixedColClick, goFixedRowClick]
        ParentDoubleBuffered = False
        ParentFont = False
        ScrollBars = ssNone
        TabOrder = 1
        StyleElements = [seFont, seBorder]
        OnDrawCell = SGDrawCell
        OnMouseDown = SGSumMouseDown
        OnRowMoved = SGRowMoved
      end
    end
  end
end
