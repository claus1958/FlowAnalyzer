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
    OnClick = Panel1Click
    object lblHeader: TLabel
      Left = 324
      Top = 9
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
      Width = 3
      Height = 13
    end
    object lblSelection: TLabel
      Left = 120
      Top = 16
      Width = 3
      Height = 13
    end
    object SpeedButton1: TSpeedButton
      Left = 5
      Top = 9
      Width = 24
      Height = 20
      Flat = True
      Glyph.Data = {
        C6050000424DC605000000000000360400002800000014000000140000000100
        08000000000090010000120B0000120B00000001000000000000000000000101
        0100020202000303030004040400050505000606060007070700080808000909
        09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
        1100121212001313130014141400151515001616160017171700181818001919
        19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
        2100222222002323230024242400252525002626260027272700282828002929
        29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F00303030003131
        3100323232003333330034343400353535003636360037373700383838003939
        39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
        4100424242004343430044444400454545004646460047474700484848004949
        49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
        5100525252005353530054545400555555005656560057575700585858005959
        59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
        6100626262006363630064646400656565006666660067676700686868006969
        69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
        7100727272007373730074747400757575007676760077777700787878007979
        79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F00808080008181
        8100828282008383830084848400858585008686860087878700888888008989
        89008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F00909090009191
        9100929292009393930094949400959595009696960097979700989898009999
        99009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1
        A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9
        A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1
        B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9
        B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C1C1
        C100C2C2C200C3C3C300C4C4C400C5C5C500C6C6C600C7C7C700C8C8C800C9C9
        C900CACACA00CBCBCB00CCCCCC00CDCDCD00CECECE00CFCFCF00D0D0D000D1D1
        D100D2D2D200D3D3D300D4D4D400D5D5D500D6D6D600D7D7D700D8D8D800D9D9
        D900DADADA00DBDBDB00DCDCDC00DDDDDD00DEDEDE00DFDFDF00E0E0E000E1E1
        E100E2E2E200E3E3E300E4E4E400E5E5E500E6E6E600E7E7E700E8E8E800E9E9
        E900EAEAEA00EBEBEB00ECECEC00EDEDED00EEEEEE00EFEFEF00F0F0F000F1F1
        F100F2F2F200F3F3F300F4F4F400F5F5F500F6F6F600F7F7F700F8F8F800F9F9
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333312A29292929292929
        292929292929292A31332A59DDE5E5E5E5E5E5E5E5E5E5E5E5E5E5DC592A2A59
        DDE5E5E5E5E5E5E5E5E5E5E5E5E5E5DC592A33312A2929292929292929292929
        2929292A3133333333333333333333333333333333333333333333312A292929
        29292929292929292929292A31332A59DDE5E5E5E5E5E5E5E5E5E5E5E5E5E5DC
        592A2A59DDE5E5E5E5E5E5E5E5E5E5E5E5E5E5DC592A33312A29292929292929
        292929292929292A313333333333333333333333333333333333333333333331
        2A29292929292929292929292929292A31332A59DDE5E5E5E5E5E5E5E5E5E5E5
        E5E5E5DC592A2A59DDE5E5E5E5E5E5E5E5E5E5E5E5E5E5DC592A33312A292929
        29292929292929292929292A3133333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        33333333333333333333}
      OnClick = SpeedButton1Click
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
        Font.Style = [fsBold]
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
  object PopupMenu1: TPopupMenu
    Left = 408
    Top = 8
    object Selectcolumns1: TMenuItem
      Caption = 'Column Selection'
      OnClick = Selectcolumns1Click
    end
    object CSVExport1: TMenuItem
      Caption = 'CSV-Export'
      OnClick = CSVExport1Click
    end
  end
  object PopupMenu0: TPopupMenu
    Left = 476
    Top = 8
    object MenuItem1: TMenuItem
      Caption = 'Column Selection'
      OnClick = Selectcolumns1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 336
    Top = 8
    object MenuItem2: TMenuItem
      Caption = 'Column Selection'
      OnClick = Selectcolumns1Click
    end
    object MenuItem3: TMenuItem
      Caption = 'CSV-Export'
      OnClick = CSVExport1Click
    end
    object CSVExportSelection1: TMenuItem
      Caption = 'CSV-Export Selection'
      OnClick = CSVExport1Click
    end
  end
  object PopupMenu3: TPopupMenu
    Left = 264
    Top = 8
    object MenuItem4: TMenuItem
      Caption = 'Column Selection'
      OnClick = Selectcolumns1Click
    end
    object MenuItem5: TMenuItem
      Caption = 'CSV-Export'
      OnClick = CSVExport1Click
    end
    object MenuItem6: TMenuItem
      Caption = 'CSV-Export Selection'
      OnClick = CSVExport1Click
    end
    object RemoveSelection1: TMenuItem
      Caption = 'Remove Selection'
      OnClick = RemoveSelection1Click
    end
    object RemoveallbutSelection1: TMenuItem
      Caption = 'Remove all but Selection'
      OnClick = RemoveallbutSelection1Click
    end
  end
  object PopupMenu4: TPopupMenu
    Left = 200
    Top = 8
    object MenuItem7: TMenuItem
      Caption = 'Column Selection'
      OnClick = Selectcolumns1Click
    end
    object MenuItem8: TMenuItem
      Caption = 'CSV-Export'
      OnClick = CSVExport1Click
    end
    object MenuItem10: TMenuItem
      Caption = 'Selection to 2ndGrid'
      OnClick = MenuItem10Click
    end
    object Selection2ndGrid1: TMenuItem
      Caption = 'Selection +-> 2nd Grid'
      OnClick = Selection2ndGrid1Click
    end
    object MarkSelection2: TMenuItem
      Caption = 'Mark Selection'
      OnClick = MarkSelection2Click
    end
  end
  object PopupMenu5: TPopupMenu
    Left = 132
    Top = 8
    object MenuItem9: TMenuItem
      Caption = 'Column Selection'
      OnClick = Selectcolumns1Click
    end
    object MenuItem11: TMenuItem
      Caption = 'CSV-Export'
      OnClick = CSVExport1Click
    end
    object MenuItem12: TMenuItem
      Caption = 'CSV-Export Selection'
      OnClick = CSVExport1Click
    end
    object MenuItem13: TMenuItem
      Caption = 'Remove Selection'
      OnClick = RemoveSelection1Click
    end
    object MenuItem14: TMenuItem
      Caption = 'Remove all but Selection'
      OnClick = RemoveallbutSelection1Click
    end
    object MarkSelection1: TMenuItem
      Caption = 'Mark Selection'
      OnClick = MarkSelection1Click
    end
    object xxx1: TMenuItem
      Caption = 'xxx'
    end
  end
end
