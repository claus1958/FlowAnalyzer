object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Flow Analyzer'
  ClientHeight = 940
  ClientWidth = 1473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 907
    Width = 1473
    Height = 33
    Panels = <>
    ExplicitWidth = 1356
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1473
    Height = 907
    ActivePage = TabSheet3
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabHeight = 26
    TabOrder = 1
    ExplicitWidth = 1356
    object TabSheet2: TTabSheet
      Caption = 'Start'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      OnResize = TabSheet2Resize
      ExplicitWidth = 1348
      object Panel10: TPanel
        AlignWithMargins = True
        Left = 568
        Top = 40
        Width = 633
        Height = 729
        TabOrder = 0
        object Label1: TLabel
          Left = 32
          Top = 48
          Width = 159
          Height = 14
          Caption = 'Load actual Data from Server'
        end
        object Label3: TLabel
          Left = 33
          Top = 637
          Width = 92
          Height = 14
          Caption = 'max.Actions/Grid'
        end
        object lblWarten: TLabel
          Left = 327
          Top = 463
          Width = 6
          Height = 19
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object clbBrokers: TCheckListBox
          Left = 32
          Top = 80
          Width = 209
          Height = 377
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 25
          ParentFont = False
          TabOrder = 0
        end
        object lbLoadInfo: TListBox
          Left = 312
          Top = 80
          Width = 225
          Height = 377
          ItemHeight = 14
          TabOrder = 1
        end
        object btnClbBrokersSelectAll: TButton
          Left = 33
          Top = 464
          Width = 105
          Height = 17
          Caption = 'select all'
          TabOrder = 2
          OnClick = btnClbBrokersSelectAllClick
        end
        object btnClbBrokersDeSelectAll: TButton
          Left = 140
          Top = 464
          Width = 101
          Height = 17
          Caption = 'deselect all'
          TabOrder = 3
          OnClick = btnClbBrokersDeSelectAllClick
        end
        object btnLoadData: TButton
          Left = 33
          Top = 487
          Width = 209
          Height = 25
          Caption = 'Load Data'
          TabOrder = 4
          OnClick = btnLoadDataClick
        end
        object cbLoadActionsFromCache: TCheckBox
          Left = 33
          Top = 546
          Width = 209
          Height = 17
          Caption = 'Get Actions from Cache'
          TabOrder = 5
        end
        object Button1: TButton
          Left = 384
          Top = 664
          Width = 109
          Height = 22
          Caption = 'Load Cachefile'
          TabOrder = 6
          Visible = False
          OnClick = btnLoadCacheFileCwClick
        end
        object edMaxActionsPerGrid: TEdit
          Left = 33
          Top = 656
          Width = 113
          Height = 22
          TabOrder = 7
          Text = '100000'
        end
        object Button3: TButton
          Left = 152
          Top = 656
          Width = 53
          Height = 21
          Caption = 'apply'
          TabOrder = 8
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 36
          Top = 680
          Width = 117
          Height = 21
          Caption = 'Restart HTTP Thread'
          TabOrder = 9
          OnClick = Button4Click
        end
        object Button6: TButton
          Left = 152
          Top = 680
          Width = 53
          Height = 21
          Caption = 'Status..'
          TabOrder = 10
          OnClick = Button6Click
        end
        object CheckBox1: TCheckBox
          Left = 40
          Top = 704
          Width = 113
          Height = 13
          Caption = 'Sortmethode2'
          TabOrder = 11
          OnClick = CheckBox1Click
        end
        object Panel11: TPanel
          Left = 312
          Top = 488
          Width = 225
          Height = 161
          TabOrder = 12
          object Memo1: TMemo
            Left = 1
            Top = 1
            Width = 223
            Height = 159
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
        end
        object Button8: TButton
          Left = 36
          Top = 516
          Width = 205
          Height = 25
          Caption = 'Update Data'
          TabOrder = 13
          OnClick = Button8Click
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'All Data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 5
      ParentFont = False
      ExplicitWidth = 1348
      object CategoryPanelGroup1: TCategoryPanelGroup
        Left = 177
        Top = 0
        Width = 1288
        Height = 871
        VertScrollBar.Tracking = True
        Align = alClient
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -16
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        HeaderHeight = 20
        TabOrder = 0
        OnResize = CategoryPanel1Expand
        ExplicitWidth = 1171
        object CategoryPanel4: TCategoryPanel
          Top = 588
          Height = 241
          Caption = 'Comments'
          TabOrder = 0
          OnCollapse = CategoryPanel1Collapse
          OnExpand = CategoryPanel1Expand
          ExplicitWidth = 1169
          object SGCwComments: TStringGridSorted
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 1278
            Height = 213
            Align = alClient
            DefaultColWidth = 80
            RowCount = 1
            FixedRows = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goRowSelect]
            TabOrder = 0
            OnMouseDown = SGMouseDown
            ExplicitWidth = 1161
          end
        end
        object CategoryPanel3: TCategoryPanel
          Top = 392
          Height = 196
          Caption = 'Users'
          TabOrder = 1
          OnCollapse = CategoryPanel1Collapse
          OnExpand = CategoryPanel1Expand
          ExplicitWidth = 1169
          object SGCwUsers: TStringGridSorted
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 1278
            Height = 168
            Align = alClient
            DefaultColWidth = 80
            RowCount = 1
            FixedRows = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goRowSelect]
            TabOrder = 0
            OnMouseDown = SGMouseDown
            ExplicitWidth = 1161
          end
        end
        object CategoryPanel2: TCategoryPanel
          Top = 196
          Height = 196
          Caption = 'Symbols'
          TabOrder = 2
          OnCollapse = CategoryPanel1Collapse
          OnExpand = CategoryPanel1Expand
          ExplicitWidth = 1169
          object SGCwSymbols: TStringGridSorted
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 1278
            Height = 168
            Align = alClient
            DefaultColWidth = 80
            RowCount = 1
            FixedRows = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goRowSelect]
            TabOrder = 0
            OnMouseDown = SGMouseDown
            ExplicitWidth = 1161
          end
        end
        object CategoryPanel1: TCategoryPanel
          Top = 0
          Height = 196
          Caption = 'Actions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnCollapse = CategoryPanel1Collapse
          OnExpand = CategoryPanel1Expand
          ExplicitWidth = 1169
          object SGCwCache: TStringGridSorted
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 1278
            Height = 168
            Align = alClient
            ColCount = 1
            DefaultColWidth = 80
            FixedCols = 0
            RowCount = 1
            FixedRows = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goRowSelect]
            TabOrder = 0
            OnMouseDown = SGMouseDown
            ExplicitWidth = 1161
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 177
        Height = 871
        Align = alLeft
        TabOrder = 1
        object lblAllDataInfo: TLabel
          Left = 4
          Top = 36
          Width = 6
          Height = 19
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'User'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 4
      ParentFont = False
      ExplicitWidth = 1348
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 1465
        Height = 871
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 1348
        object Panel7: TPanel
          Left = 1
          Top = 1
          Width = 321
          Height = 869
          Align = alLeft
          TabOrder = 0
          object Label2: TLabel
            Left = 184
            Top = 24
            Width = 32
            Height = 14
            Caption = 'userid'
          end
          object Label4: TLabel
            Left = 184
            Top = 72
            Width = 66
            Height = 14
            Caption = 'max Actions'
            Visible = False
          end
          object btnGetSingleUserActions: TButton
            Left = 8
            Top = 40
            Width = 161
            Height = 21
            Caption = 'Get Users Actions'
            TabOrder = 0
            OnClick = btnGetSingleUserActionsClick
          end
          object edSingleUserActionsId: TEdit
            Left = 184
            Top = 40
            Width = 89
            Height = 22
            TabOrder = 1
            Text = '0'
            OnChange = edSingleUserActionsIdChange
          end
          object edFZMax: TEdit
            Left = 184
            Top = 88
            Width = 89
            Height = 22
            TabOrder = 2
            Text = '10000'
            Visible = False
          end
        end
        object Panel8: TPanel
          Left = 322
          Top = 1
          Width = 1142
          Height = 869
          Align = alClient
          Caption = 'Panel8'
          TabOrder = 1
          ExplicitWidth = 1025
          object Panel9: TPanel
            Left = 1
            Top = 1
            Width = 1140
            Height = 41
            Align = alTop
            TabOrder = 0
            ExplicitWidth = 1023
            object lblSingleUserActions: TLabel
              Left = 392
              Top = 8
              Width = 144
              Height = 19
              Caption = 'lblSingleUserActions'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
          end
          object SGCwSingleUser: TStringGridSorted
            AlignWithMargins = True
            Left = 4
            Top = 45
            Width = 1134
            Height = 820
            Align = alClient
            DefaultColWidth = 80
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goRowSelect]
            TabOrder = 1
            OnMouseDown = SGMouseDown
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Filtering'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 1348
      object Panel26: TPanel
        Left = 0
        Top = 0
        Width = 1465
        Height = 871
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 1348
        object Panel34: TPanel
          Left = 1
          Top = 1
          Width = 524
          Height = 869
          Align = alLeft
          TabOrder = 0
          object Panel36: TPanel
            Left = 8
            Top = 30
            Width = 513
            Height = 643
            Color = clGray
            ParentBackground = False
            TabOrder = 0
            object Label5: TLabel
              Left = 15
              Top = 12
              Width = 119
              Height = 19
              Caption = 'Filter Parameters'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object lblFilterResult: TLabel
              Left = 10
              Top = 426
              Width = 4
              Height = 14
            end
            object Label6: TLabel
              Left = 15
              Top = 37
              Width = 34
              Height = 14
              Caption = 'on/off'
            end
            object Label7: TLabel
              Left = 60
              Top = 37
              Width = 27
              Height = 14
              Caption = 'topic'
            end
            object Label8: TLabel
              Left = 176
              Top = 37
              Width = 52
              Height = 14
              Caption = 'operation'
            end
            object Label9: TLabel
              Left = 244
              Top = 37
              Width = 48
              Height = 14
              Caption = 'selection'
            end
            object Label10: TLabel
              Left = 493
              Top = 37
              Width = 14
              Height = 14
              Caption = 'list'
            end
            object Label11: TLabel
              Left = 10
              Top = 495
              Width = 91
              Height = 19
              Caption = 'Samplefilters'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object btnDoubleRemoveCw: TButton
              Left = 204
              Top = 399
              Width = 82
              Height = 25
              Caption = 'DblRemove'
              TabOrder = 0
              Visible = False
              OnClick = btnDoubleRemoveCwClick
            end
            object btnSelectClearCw: TButton
              Left = 107
              Top = 399
              Width = 91
              Height = 25
              Caption = 'Clear all'
              TabOrder = 1
              OnClick = btnSelectClearCwClick
            end
            object btnDoFilter: TButton
              Left = 4
              Top = 399
              Width = 97
              Height = 25
              Caption = 'Filter!'
              TabOrder = 2
              OnClick = btnDoFilterClick
            end
            object Button5: TButton
              Left = 312
              Top = 399
              Width = 137
              Height = 25
              Caption = 'Balance direkt filtern'
              TabOrder = 3
              Visible = False
              OnClick = Button5Click
            end
            object pnlFilter: TPanel
              Left = 5
              Top = 56
              Width = 505
              Height = 337
              TabOrder = 4
              inline FilterElemente1: TFilterElemente
                Left = 2
                Top = 8
                Width = 505
                Height = 28
                Color = clGray
                ParentBackground = False
                ParentColor = False
                TabOrder = 0
                ExplicitLeft = 2
                ExplicitTop = 8
                inherited cbTopic: TComboBox
                  Height = 22
                  ExplicitHeight = 22
                end
                inherited cbOperator: TComboBox
                  Height = 22
                  ExplicitHeight = 22
                end
                inherited edValue: TEdit
                  Height = 22
                  ExplicitHeight = 22
                end
                inherited dtPicker1: TDateTimePicker
                  Height = 22
                  ExplicitHeight = 22
                end
              end
            end
            object btnSample1: TButton
              Left = 8
              Top = 520
              Width = 120
              Height = 25
              Caption = 'Balance only'
              TabOrder = 5
              OnClick = btnSample1Click
            end
            object btnSample2: TButton
              Left = 7
              Top = 551
              Width = 120
              Height = 25
              Caption = 'Winner>1000'
              TabOrder = 6
              OnClick = btnSample1Click
            end
            object btnSample3: TButton
              Left = 7
              Top = 582
              Width = 120
              Height = 25
              Caption = 'Gold 2018 Loosers'
              TabOrder = 7
              OnClick = btnSample1Click
            end
          end
        end
        object Panel4: TPanel
          Left = 525
          Top = 1
          Width = 939
          Height = 869
          Align = alClient
          TabOrder = 1
          ExplicitWidth = 822
          object Panel5: TPanel
            Left = 1
            Top = 1
            Width = 937
            Height = 41
            Align = alTop
            TabOrder = 0
            ExplicitWidth = 820
            object lblFilteredDataInfo: TLabel
              Left = 1
              Top = 1
              Width = 935
              Height = 19
              Align = alTop
              Alignment = taCenter
              Caption = '-'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 6
            end
          end
          object SGCacheCwSearch: TStringGridSorted
            AlignWithMargins = True
            Left = 4
            Top = 45
            Width = 931
            Height = 820
            Align = alClient
            ColCount = 1
            DefaultColWidth = 80
            FixedCols = 0
            RowCount = 1
            FixedRows = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goRowSelect]
            TabOrder = 1
            Visible = False
            OnMouseDown = SGMouseDown
            ExplicitWidth = 814
          end
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Internal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 3
      ParentFont = False
      ExplicitWidth = 1348
      object Panel1: TPanel
        Left = 8
        Top = 24
        Width = 1169
        Height = 841
        TabOrder = 0
        object Panel2: TPanel
          Left = 16
          Top = 24
          Width = 617
          Height = 705
          TabOrder = 0
          object Label24: TLabel
            Left = 119
            Top = 195
            Width = 32
            Height = 14
            Caption = 'count'
          end
          object Label25: TLabel
            Left = 222
            Top = 193
            Width = 24
            Height = 14
            Caption = 'step'
          end
          object lblCwActionsLength: TLabel
            Left = 8
            Top = 176
            Width = 61
            Height = 14
            Caption = 'CwActions:'
          end
          object btnCwactionsToGrid: TButton
            Left = 434
            Top = 144
            Width = 125
            Height = 25
            Caption = 'CwActionsToGrid'
            TabOrder = 0
            OnClick = btnCwactionsToGridClick
          end
          object btnCwCommentsToGrid: TButton
            Left = 434
            Top = 239
            Width = 125
            Height = 25
            Caption = 'CwCommentsToGrid'
            TabOrder = 1
            OnClick = btnCwCommentsToGridClick
          end
          object btnCwSymbolsToGrid: TButton
            Left = 434
            Top = 176
            Width = 125
            Height = 25
            Caption = 'CwSymbolsToGrid'
            TabOrder = 2
            OnClick = btnCwSymbolsToGridClick
          end
          object btnCwusersToGrid: TButton
            Left = 434
            Top = 208
            Width = 125
            Height = 25
            Caption = 'CwUsersToGrid'
            TabOrder = 3
            OnClick = btnCwusersToGridClick
          end
          object btnDblCheckCw: TButton
            Left = 280
            Top = 208
            Width = 97
            Height = 22
            Caption = 'DblCheckCw'
            TabOrder = 4
            OnClick = btnDblCheckCwClick
          end
          object btnGetBinData: TButton
            Left = 8
            Top = 117
            Width = 169
            Height = 23
            Caption = 'GetBinActions Indy'
            TabOrder = 5
            OnClick = btnGetBinDataClick
          end
          object btnGetCsv: TButton
            Left = 8
            Top = 66
            Width = 105
            Height = 25
            Caption = 'Get CSV Indy UTF8'
            TabOrder = 6
            OnClick = btnGetCsvClick
          end
          object btnGetSymbolsUsersComments: TButton
            Left = 119
            Top = 66
            Width = 137
            Height = 25
            Caption = 'Symbols/Users/Comments'
            TabOrder = 7
            OnClick = btnGetSymbolsUsersCommentsClick
          end
          object btnListDoublesCw: TButton
            Left = 8
            Top = 240
            Width = 65
            Height = 17
            Caption = 'List Doubles'
            TabOrder = 8
            OnClick = btnListDoublesCwClick
          end
          object btnLoadCacheFileCw: TButton
            Left = 111
            Top = 263
            Width = 97
            Height = 22
            Caption = 'Load Cachefile'
            TabOrder = 9
            OnClick = btnLoadCacheFileCwClick
          end
          object btnSaveCacheFileCw: TButton
            Left = 8
            Top = 263
            Width = 97
            Height = 22
            Caption = 'Save Cachefile'
            TabOrder = 10
            OnClick = btnSaveCacheFileCwClick
          end
          object btnShowCacheCw: TButton
            Left = 8
            Top = 207
            Width = 105
            Height = 25
            Caption = 'ShowCacheCw'
            TabOrder = 11
            OnClick = btnShowCacheCwClick
          end
          object edCacheCwShowMax: TEdit
            Left = 119
            Top = 211
            Width = 97
            Height = 22
            TabOrder = 12
            Text = '10000'
          end
          object edCacheCwShowStep: TEdit
            Left = 222
            Top = 209
            Width = 49
            Height = 22
            TabOrder = 13
            Text = '1'
          end
          object edGetUrlBin: TEdit
            Left = 183
            Top = 117
            Width = 258
            Height = 22
            TabOrder = 14
            Text = 'http://h2827643.stratoserver.net:8080/bin/actions'
          end
          object edGetUrlCSV: TEdit
            Left = 262
            Top = 68
            Width = 299
            Height = 22
            TabOrder = 15
            Text = 'http://h2827643.stratoserver.net:8080/csv/symbols'
          end
          object lbCSVError: TListBox
            Left = 8
            Top = 471
            Width = 562
            Height = 170
            ItemHeight = 14
            TabOrder = 16
            OnClick = lbCSVErrorClick
          end
          object lbDebug2: TListBox
            Left = 8
            Top = 296
            Width = 562
            Height = 169
            ItemHeight = 14
            TabOrder = 17
          end
          object chkGetBinAppend: TCheckBox
            Left = 448
            Top = 120
            Width = 105
            Height = 17
            Caption = 'chkGetBinAppend'
            TabOrder = 18
          end
          object Button2: TButton
            Left = 216
            Top = 264
            Width = 105
            Height = 21
            Caption = 'Sorttests'
            TabOrder = 19
            OnClick = Button2Click
          end
          object cbStyles: TComboBox
            Left = 434
            Top = 268
            Width = 119
            Height = 22
            TabOrder = 20
            OnChange = cbStylesChange
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Speed-Grid'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 5
      ParentFont = False
      ExplicitWidth = 1348
      object Panel12: TPanel
        Left = 0
        Top = 0
        Width = 1465
        Height = 871
        Align = alClient
        Caption = 'Panel12'
        TabOrder = 0
        ExplicitWidth = 1348
        inline DynGrid1: TDynGrid
          Left = 1
          Top = 1
          Width = 1463
          Height = 869
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 712
          ExplicitHeight = 869
          inherited Panel1: TPanel
            Width = 1463
            Align = alTop
            ExplicitWidth = 1346
            inherited lblTime: TLabel
              Width = 38
              Height = 14
              ExplicitWidth = 38
              ExplicitHeight = 14
            end
          end
          inherited Panel2: TPanel
            Left = 0
            Top = 41
            Width = 1463
            Height = 828
            Align = alClient
            ExplicitLeft = 0
            ExplicitTop = 41
            ExplicitWidth = 1346
            ExplicitHeight = 828
            inherited SG: TStringGridSorted
              Width = 1445
              Height = 826
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goRowSelect, goFixedColClick]
              ExplicitWidth = 1328
              ExplicitHeight = 826
            end
            inherited ScrollBar1: TScrollBar
              Left = 1446
              Height = 826
              ExplicitLeft = 1329
              ExplicitHeight = 826
            end
          end
        end
        object Button7: TButton
          Left = 2
          Top = 10
          Width = 69
          Height = 25
          Caption = 'Show Grid'
          TabOrder = 1
          OnClick = Button7Click
        end
      end
    end
  end
end
