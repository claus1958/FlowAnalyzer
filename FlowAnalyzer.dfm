object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Flow Analyzer'
  ClientHeight = 940
  ClientWidth = 1604
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
    Width = 1604
    Height = 33
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1604
    Height = 907
    ActivePage = TabSheet1
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabHeight = 26
    TabOrder = 1
    OnChange = PageControl1Change
    OnChanging = PageControl1Changing
    OnDrawTab = PageControl1DrawTab
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
        object btnDoUsersPlus: TButton
          Left = 36
          Top = 572
          Width = 205
          Height = 21
          Caption = 'Additional computations'
          TabOrder = 14
          Visible = False
          OnClick = btnDoUsersPlusClick
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
      object Splitter1: TSplitter
        Left = 229
        Top = 0
        Width = 8
        Height = 871
        ExplicitLeft = 177
      end
      object CategoryPanelGroup1: TCategoryPanelGroup
        Left = 237
        Top = 0
        Width = 1359
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
        object CategoryPanel4: TCategoryPanel
          Top = 588
          Height = 241
          Caption = 'Comments'
          TabOrder = 0
          OnCollapse = CategoryPanel1Collapse
          OnExpand = CategoryPanel1Expand
          inline DynGrid7: TDynGrid
            Left = 0
            Top = 0
            Width = 1355
            Height = 219
            Align = alClient
            TabOrder = 0
            ExplicitLeft = 8
            ExplicitWidth = 674
            ExplicitHeight = 213
            inherited Panel1: TPanel
              Width = 1355
              Height = 5
              Align = alTop
              ExplicitWidth = 674
              ExplicitHeight = 5
              inherited lblTime: TLabel
                Width = 38
                Height = 14
                ExplicitWidth = 38
                ExplicitHeight = 14
              end
            end
            inherited Panel2: TPanel
              Left = 0
              Top = 5
              Width = 1355
              Height = 214
              Align = alClient
              ExplicitLeft = 0
              ExplicitTop = 5
              ExplicitWidth = 674
              ExplicitHeight = 169
              inherited SG: TStringGridSorted
                Tag = 3
                Width = 1337
                Height = 212
                Options = [goColSizing, goFixedColClick, goFixedRowClick]
                ExplicitWidth = 656
                ExplicitHeight = 167
              end
              inherited ScrollBar1: TScrollBar
                Left = 1338
                Height = 212
                ExplicitLeft = 657
                ExplicitHeight = 167
              end
            end
          end
        end
        object CategoryPanel3: TCategoryPanel
          Top = 392
          Height = 196
          Caption = 'Users'
          TabOrder = 1
          OnCollapse = CategoryPanel1Collapse
          OnExpand = CategoryPanel1Expand
          inline DynGrid6: TDynGrid
            Left = 0
            Top = 0
            Width = 1355
            Height = 174
            Align = alClient
            TabOrder = 0
            ExplicitLeft = 4
            ExplicitWidth = 674
            ExplicitHeight = 174
            inherited Panel1: TPanel
              Width = 1355
              Height = 5
              Align = alTop
              ExplicitWidth = 674
              ExplicitHeight = 5
              inherited lblTime: TLabel
                Width = 38
                Height = 14
                ExplicitWidth = 38
                ExplicitHeight = 14
              end
            end
            inherited Panel2: TPanel
              Left = 0
              Top = 5
              Width = 1355
              Height = 169
              Align = alClient
              ExplicitLeft = 0
              ExplicitTop = 5
              ExplicitWidth = 674
              ExplicitHeight = 169
              inherited SG: TStringGridSorted
                Tag = 3
                Width = 1337
                Height = 167
                Options = [goColSizing, goFixedColClick, goFixedRowClick]
                ExplicitWidth = 656
                ExplicitHeight = 167
              end
              inherited ScrollBar1: TScrollBar
                Left = 1338
                Height = 167
                ExplicitLeft = 657
                ExplicitHeight = 167
              end
            end
          end
        end
        object CategoryPanel2: TCategoryPanel
          Top = 196
          Height = 196
          Caption = 'Symbols'
          TabOrder = 2
          OnCollapse = CategoryPanel1Collapse
          OnExpand = CategoryPanel1Expand
          inline DynGrid5: TDynGrid
            Left = 0
            Top = 0
            Width = 1355
            Height = 174
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 674
            ExplicitHeight = 174
            inherited Panel1: TPanel
              Width = 1355
              Height = 5
              Align = alTop
              ExplicitWidth = 1355
              ExplicitHeight = 5
              inherited lblTime: TLabel
                Width = 38
                Height = 14
                ExplicitWidth = 38
                ExplicitHeight = 14
              end
            end
            inherited Panel2: TPanel
              Left = 0
              Top = 5
              Width = 1355
              Height = 169
              Align = alClient
              ExplicitLeft = 0
              ExplicitTop = 5
              ExplicitWidth = 1355
              ExplicitHeight = 169
              inherited SG: TStringGridSorted
                Tag = 3
                Width = 1337
                Height = 167
                Options = [goColSizing, goFixedColClick, goFixedRowClick]
                ExplicitWidth = 1337
                ExplicitHeight = 167
              end
              inherited ScrollBar1: TScrollBar
                Left = 1338
                Height = 167
                ExplicitLeft = 1338
                ExplicitHeight = 167
              end
            end
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
          inline DynGrid3: TDynGrid
            Left = 0
            Top = 0
            Width = 1355
            Height = 174
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 1355
            ExplicitHeight = 174
            inherited Panel1: TPanel
              Width = 1355
              Height = 5
              Align = alTop
              ExplicitWidth = 1355
              ExplicitHeight = 5
              inherited lblTime: TLabel
                Width = 38
                Height = 14
                ExplicitWidth = 38
                ExplicitHeight = 14
              end
            end
            inherited Panel2: TPanel
              Left = 0
              Top = 5
              Width = 1355
              Height = 169
              Align = alClient
              ExplicitLeft = 0
              ExplicitTop = 41
              ExplicitWidth = 1355
              ExplicitHeight = 133
              inherited SG: TStringGridSorted
                Tag = 3
                Width = 1337
                Height = 167
                Options = [goColSizing, goFixedColClick, goFixedRowClick]
                ExplicitWidth = 1337
                ExplicitHeight = 131
              end
              inherited ScrollBar1: TScrollBar
                Left = 1338
                Height = 167
                ExplicitLeft = 1338
                ExplicitHeight = 131
              end
            end
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 229
        Height = 871
        Align = alLeft
        TabOrder = 1
        object lblAllDataInfo: TLabel
          Left = 0
          Top = 72
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
        object Panel19: TPanel
          Left = 0
          Top = 16
          Width = 231
          Height = 37
          Color = clWindow
          ParentBackground = False
          TabOrder = 0
          object btnOnePage1: TButton
            Left = 0
            Top = 8
            Width = 60
            Height = 21
            Caption = 'Actions'
            TabOrder = 0
            OnClick = btnOnePageClick
          end
          object btnOnePage2: TButton
            Left = 57
            Top = 8
            Width = 60
            Height = 21
            Caption = 'Symbols'
            TabOrder = 1
            OnClick = btnOnePageClick
          end
          object btnOnePage3: TButton
            Left = 114
            Top = 8
            Width = 60
            Height = 21
            Caption = 'Users'
            TabOrder = 2
            OnClick = btnOnePageClick
          end
          object btnOnePage4: TButton
            Left = 172
            Top = 8
            Width = 60
            Height = 21
            Caption = 'Comments'
            TabOrder = 3
            OnClick = btnOnePageClick
          end
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
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 1596
        Height = 871
        Align = alClient
        TabOrder = 0
        object Splitter2: TSplitter
          Left = 322
          Top = 1
          Width = 5
          Height = 869
          ExplicitLeft = 330
          ExplicitTop = 17
        end
        object Panel7: TPanel
          Left = 1
          Top = 1
          Width = 321
          Height = 869
          Align = alLeft
          TabOrder = 0
          object Panel13: TPanel
            Left = 1
            Top = 1
            Width = 319
            Height = 82
            Align = alTop
            TabOrder = 0
            object Label2: TLabel
              Left = 184
              Top = 24
              Width = 32
              Height = 14
              Caption = 'userid'
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
          end
          object CategoryPanelGroup2: TCategoryPanelGroup
            Left = 1
            Top = 83
            Width = 319
            Height = 785
            VertScrollBar.Tracking = True
            Align = alClient
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -16
            HeaderFont.Name = 'Tahoma'
            HeaderFont.Style = []
            TabOrder = 1
            object CategoryPanel7: TCategoryPanel
              Top = 363
              Height = 30
              Caption = '-'
              Collapsed = True
              TabOrder = 0
              OnCollapse = CategoryPanelCollapse2
              OnExpand = CategoryPanelExpand2
            end
            object CategoryPanel6: TCategoryPanel
              Top = 333
              Height = 30
              Caption = '-'
              Collapsed = True
              TabOrder = 1
              OnCollapse = CategoryPanelCollapse2
              OnExpand = CategoryPanelExpand2
            end
            object CategoryPanel5: TCategoryPanel
              Top = 0
              Height = 333
              Caption = 'User Data'
              TabOrder = 2
              OnCollapse = CategoryPanelCollapse2
              OnExpand = CategoryPanelExpand2
              object lbUserInfo: TListBox
                Left = 0
                Top = 1
                Width = 315
                Height = 306
                Align = alClient
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = []
                ItemHeight = 18
                ParentFont = False
                TabOrder = 0
                TabWidth = 66
              end
              object Panel14: TPanel
                Left = 0
                Top = 0
                Width = 315
                Height = 1
                Align = alTop
                TabOrder = 1
              end
            end
          end
        end
        object Panel8: TPanel
          Left = 329
          Top = 1
          Width = 1142
          Height = 869
          Caption = 'Panel8'
          TabOrder = 1
          object Panel9: TPanel
            Left = 1
            Top = 1
            Width = 1140
            Height = 41
            Align = alTop
            TabOrder = 0
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
          inline DynGrid4: TDynGrid
            Left = 1
            Top = 42
            Width = 1140
            Height = 826
            Align = alClient
            TabOrder = 1
            ExplicitLeft = 1
            ExplicitTop = 42
            ExplicitWidth = 1140
            ExplicitHeight = 826
            inherited Panel1: TPanel
              Width = 1140
              Align = alTop
              ExplicitWidth = 1140
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
              Width = 1140
              Height = 785
              Align = alClient
              ExplicitLeft = 0
              ExplicitTop = 41
              ExplicitWidth = 1140
              ExplicitHeight = 785
              inherited SG: TStringGridSorted
                Tag = 4
                Width = 1122
                Height = 783
                ExplicitWidth = 1122
                ExplicitHeight = 783
              end
              inherited ScrollBar1: TScrollBar
                Left = 1123
                Height = 783
                ExplicitLeft = 1123
                ExplicitHeight = 783
              end
            end
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
      object Panel26: TPanel
        Left = 0
        Top = 0
        Width = 1596
        Height = 871
        Align = alClient
        TabOrder = 0
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
                  Left = 32
                  Top = 3
                  Width = 129
                  Height = 22
                  TabOrder = 0
                  Text = 'BrokerId'
                  Items.Strings = (
                    'BrokerId'
                    'AccountId'
                    'SymbolId'
                    'Symbol'
                    'UserId'
                    'UserName'
                    'ActionType'
                    'OpenDateTime'
                    'CloseDateTime'
                    'OpenPrice'
                    'Profit'
                    'Volume')
                  ExplicitHeight = 22
                end
                inherited cbOperator: TComboBox
                  Left = 163
                  Top = 3
                  Width = 58
                  Height = 22
                  ItemIndex = 0
                  TabOrder = 1
                  Text = '='
                  Items.Strings = (
                    '='
                    '<>'
                    '<'
                    '>'
                    '<='
                    '>='
                    'contains'
                    'contains not')
                  ExplicitHeight = 22
                end
                inherited edValue: TEdit
                  Left = 223
                  Top = 3
                  Width = 258
                  Height = 22
                  TabOrder = 2
                  ExplicitHeight = 22
                end
                inherited dtPicker1: TDateTimePicker
                  Left = 376
                  Top = 3
                  Width = 105
                  Height = 22
                  Date = 43549.000000000000000000
                  Time = 0.616624108799442200
                  TabOrder = 3
                  Visible = False
                  ExplicitHeight = 22
                end
                inherited chkActive: TCheckBox
                  Left = 9
                  Top = 4
                  Width = 17
                  Height = 17
                  TabOrder = 4
                end
                inherited chkLB1: TComboBox
                  Left = 223
                  Top = 3
                  Width = 258
                  Height = 22
                  Style = csOwnerDrawFixed
                  DropDownCount = 24
                  TabOrder = 6
                  Items.Strings = ()
                end
                inherited btnMore: TButton
                  Left = 483
                  Top = 3
                  Width = 22
                  Height = 23
                  Hint = 'Select from list...'
                  Caption = '>'
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 5
                  Visible = False
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
              OnClick = btnSampleClick
            end
            object btnSample2: TButton
              Left = 7
              Top = 551
              Width = 120
              Height = 25
              Caption = 'Winner>1000'
              TabOrder = 6
              OnClick = btnSampleClick
            end
            object btnSample3: TButton
              Left = 7
              Top = 582
              Width = 120
              Height = 25
              Caption = 'Gold 2018 Loosers'
              TabOrder = 7
              OnClick = btnSampleClick
            end
          end
        end
        object Panel4: TPanel
          Left = 525
          Top = 1
          Width = 1070
          Height = 869
          Align = alClient
          TabOrder = 1
          object Panel5: TPanel
            Left = 1
            Top = 1
            Width = 1068
            Height = 41
            Align = alTop
            TabOrder = 0
            object lblFilteredDataInfo: TLabel
              Left = 1
              Top = 1
              Width = 1066
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
          inline DynGrid2: TDynGrid
            Left = 1
            Top = 42
            Width = 1068
            Height = 826
            Align = alClient
            TabOrder = 1
            ExplicitLeft = 1
            ExplicitTop = 420
            ExplicitWidth = 1068
            ExplicitHeight = 448
            inherited Panel1: TPanel
              inherited lblTime: TLabel
                Width = 38
                Height = 14
                ExplicitWidth = 38
                ExplicitHeight = 14
              end
            end
            inherited Panel2: TPanel
              Left = 0
              Top = 0
              Width = 1068
              Height = 826
              Align = alClient
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 1068
              ExplicitHeight = 448
              inherited SG: TStringGridSorted
                Tag = 2
                Width = 1050
                Height = 824
                Options = [goColSizing, goFixedColClick, goFixedRowClick]
                ExplicitWidth = 1050
                ExplicitHeight = 446
              end
              inherited ScrollBar1: TScrollBar
                Left = 1051
                Height = 824
                ExplicitLeft = 1051
                ExplicitHeight = 446
              end
            end
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
      TabVisible = False
      object Panel12: TPanel
        Left = 0
        Top = 0
        Width = 1596
        Height = 871
        Align = alClient
        Caption = 'Panel12'
        TabOrder = 0
        inline DynGrid1: TDynGrid
          Left = 1
          Top = 1
          Width = 1594
          Height = 869
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 1594
          ExplicitHeight = 869
          inherited Panel1: TPanel
            Width = 1594
            Align = alTop
            ExplicitWidth = 1594
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
            Width = 1594
            Height = 828
            Align = alClient
            ExplicitLeft = 0
            ExplicitTop = 41
            ExplicitWidth = 1594
            ExplicitHeight = 828
            inherited SG: TStringGridSorted
              Tag = 1
              Width = 1576
              Height = 826
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goFixedColClick]
              ExplicitWidth = 1576
              ExplicitHeight = 826
            end
            inherited ScrollBar1: TScrollBar
              Left = 1577
              Height = 826
              ExplicitLeft = 1577
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
    object TabSheet7: TTabSheet
      Caption = 'SymbolsGroups'
      ImageIndex = 6
      object Panel15: TPanel
        Left = 0
        Top = 0
        Width = 261
        Height = 871
        Align = alLeft
        TabOrder = 0
        object Label4: TLabel
          Left = 44
          Top = 12
          Width = 86
          Height = 19
          Caption = 'Use actions:'
        end
        object btnGroupSymbolsAllActions: TButton
          Left = 40
          Top = 38
          Width = 165
          Height = 25
          Caption = 'All Actions'
          TabOrder = 0
          OnClick = btnGroupSymbolsClick
        end
        object btnGroupSymbolsFilteredActions: TButton
          Left = 40
          Top = 72
          Width = 165
          Height = 25
          Caption = 'Actions from '#39'Filtering'#39
          TabOrder = 1
          OnClick = btnGroupSymbolsClick
        end
        object lbSymbolsGroupsInfo: TListBox
          Left = 0
          Top = 112
          Width = 260
          Height = 301
          ItemHeight = 19
          TabOrder = 2
          TabWidth = 60
        end
        object pnlPieButtons: TPanel
          Left = 10
          Top = 419
          Width = 245
          Height = 149
          TabOrder = 3
          Visible = False
          object btnPieChart1: TButton
            Left = 0
            Top = 8
            Width = 237
            Height = 41
            Caption = 'PieChart '#39'TradesCount'#39' Col'
            TabOrder = 0
            OnClick = btnPieChartClick
          end
          object btnPieChart2: TButton
            Left = 0
            Top = 55
            Width = 237
            Height = 41
            Caption = 'PieChart '#39'TradesVolume'#39' Col'
            TabOrder = 1
            OnClick = btnPieChartClick
          end
          object btnPieChart3: TButton
            Left = 0
            Top = 102
            Width = 237
            Height = 41
            Caption = 'PieChart '#39'TotalProfit'#39' Col'
            TabOrder = 2
            OnClick = btnPieChartClick
          end
        end
      end
      object Panel16: TPanel
        Left = 261
        Top = 0
        Width = 1335
        Height = 871
        Align = alClient
        TabOrder = 1
        object Panel17: TPanel
          Left = 1
          Top = 1
          Width = 1333
          Height = 33
          Align = alTop
          TabOrder = 0
        end
        object Panel18: TPanel
          Left = 1
          Top = 34
          Width = 1333
          Height = 836
          Align = alClient
          Caption = 'Panel18'
          TabOrder = 1
          object CategoryPanelGroup3: TCategoryPanelGroup
            Left = 1
            Top = 1
            Width = 1331
            Height = 834
            VertScrollBar.Tracking = True
            Align = alClient
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -16
            HeaderFont.Name = 'Tahoma'
            HeaderFont.Style = []
            TabOrder = 0
            object CategoryPanel8: TCategoryPanel
              Top = 0
              Height = 300
              Caption = 'Symbols Groups'
              TabOrder = 0
              OnCollapse = CategoryPanel9CollapseExpand
              OnExpand = CategoryPanel9CollapseExpand
              ExplicitWidth = 1329
              inline DynGrid8: TDynGrid
                Left = 0
                Top = 0
                Width = 1310
                Height = 274
                Align = alClient
                TabOrder = 0
                ExplicitLeft = 12
                ExplicitTop = 4
                ExplicitWidth = 674
                ExplicitHeight = 213
                inherited Panel1: TPanel
                  Width = 1310
                  Height = 5
                  Align = alTop
                  ExplicitWidth = 674
                  ExplicitHeight = 5
                  inherited lblTime: TLabel
                    Width = 53
                    Height = 19
                    ExplicitWidth = 53
                    ExplicitHeight = 19
                  end
                end
                inherited Panel2: TPanel
                  Left = 0
                  Top = 5
                  Width = 1310
                  Height = 269
                  Align = alClient
                  ExplicitLeft = 0
                  ExplicitTop = 5
                  ExplicitWidth = 674
                  ExplicitHeight = 208
                  inherited SG: TStringGridSorted
                    Tag = 3
                    Width = 1292
                    Height = 267
                    Options = [goColSizing, goFixedColClick, goFixedRowClick]
                    ExplicitWidth = 656
                    ExplicitHeight = 206
                  end
                  inherited ScrollBar1: TScrollBar
                    Left = 1293
                    Height = 267
                    ExplicitLeft = 657
                    ExplicitHeight = 206
                  end
                end
              end
            end
            object CategoryPanel9: TCategoryPanel
              Top = 300
              Height = 565
              Caption = 'Visualization'
              TabOrder = 1
              OnCollapse = CategoryPanel9CollapseExpand
              OnExpand = CategoryPanel9CollapseExpand
              ExplicitTop = 232
              ExplicitWidth = 1329
              object Panel20: TPanel
                Left = 0
                Top = 0
                Width = 1310
                Height = 539
                Align = alClient
                Caption = 'Panel20'
                TabOrder = 0
                ExplicitLeft = 16
                ExplicitTop = 8
                ExplicitWidth = 669
                ExplicitHeight = 561
                object SymbolsGroupsPieChartView: TAdvGDIPChartView
                  Left = 1
                  Top = 1
                  Width = 1308
                  Height = 537
                  Align = alClient
                  Color = clWhite
                  Panes = <
                    item
                      Bands.Distance = 2.000000000000000000
                      Background.Color = clSilver
                      Background.ColorTo = 3355443
                      Background.Font.Charset = DEFAULT_CHARSET
                      Background.Font.Color = clWindowText
                      Background.Font.Height = -11
                      Background.Font.Name = 'Tahoma'
                      Background.Font.Style = []
                      Background.GradientType = gtForwardDiagonal
                      BorderColor = clBlack
                      CrossHair.CrossHairYValues.Position = [chYAxis]
                      CrossHair.Distance = 0
                      Height = 100.000000000000000000
                      Legend.Color = clGray
                      Legend.ColorTo = clSilver
                      Legend.Font.Charset = DEFAULT_CHARSET
                      Legend.Font.Color = clWindowText
                      Legend.Font.Height = -11
                      Legend.Font.Name = 'Tahoma'
                      Legend.Font.Style = []
                      Legend.GradientType = gtVertical
                      Legend.Shadow = True
                      Name = 'ChartPane 0'
                      Options = []
                      Range.StartDate = 43675.893897118050000000
                      Range.RangeTo = 5
                      Series = <
                        item
                          AutoRange = arDisabled
                          Pie.Size = 500
                          Pie.ShowValues = True
                          Pie.ValuePosition = vpOutSideSlice
                          Pie.ShowLegendOnSlice = True
                          Pie.ValueFont.Charset = DEFAULT_CHARSET
                          Pie.ValueFont.Color = clWindowText
                          Pie.ValueFont.Height = -11
                          Pie.ValueFont.Name = 'Tahoma'
                          Pie.ValueFont.Style = []
                          Pie.LegendFont.Charset = DEFAULT_CHARSET
                          Pie.LegendFont.Color = clWindowText
                          Pie.LegendFont.Height = -11
                          Pie.LegendFont.Name = 'Tahoma'
                          Pie.LegendFont.Style = []
                          Annotations = <>
                          ChartType = ctPie
                          Color = 22015
                          CrossHairYValue.Font.Charset = DEFAULT_CHARSET
                          CrossHairYValue.Font.Color = clWindowText
                          CrossHairYValue.Font.Height = -11
                          CrossHairYValue.Font.Name = 'Tahoma'
                          CrossHairYValue.Font.Style = []
                          CrossHairYValue.GradientSteps = 0
                          LineColor = 22015
                          LegendText = 'Serie 0'
                          Marker.MarkerType = mCircle
                          Marker.MarkerColor = 22015
                          Marker.SelectedColor = 22015
                          Marker.SelectedLineColor = clBlack
                          Marker.SelectedSize = 15
                          Maximum = 12.000000000000000000
                          Name = 'Serie 0'
                          ValueFont.Charset = DEFAULT_CHARSET
                          ValueFont.Color = clWindowText
                          ValueFont.Height = -11
                          ValueFont.Name = 'Tahoma'
                          ValueFont.Style = []
                          ValueFormat = '%g'
                          ValueWidth = 80
                          XAxis.DateTimeFont.Charset = DEFAULT_CHARSET
                          XAxis.DateTimeFont.Color = clWindowText
                          XAxis.DateTimeFont.Height = -11
                          XAxis.DateTimeFont.Name = 'Tahoma'
                          XAxis.DateTimeFont.Style = []
                          XAxis.MajorFont.Charset = DEFAULT_CHARSET
                          XAxis.MajorFont.Color = clWindowText
                          XAxis.MajorFont.Height = -11
                          XAxis.MajorFont.Name = 'Tahoma'
                          XAxis.MajorFont.Style = []
                          XAxis.MajorUnit = 1.000000000000000000
                          XAxis.MajorUnitSpacing = 0
                          XAxis.MinorFont.Charset = DEFAULT_CHARSET
                          XAxis.MinorFont.Color = clWindowText
                          XAxis.MinorFont.Height = -11
                          XAxis.MinorFont.Name = 'Tahoma'
                          XAxis.MinorFont.Style = []
                          XAxis.MinorUnit = 1.000000000000000000
                          XAxis.MinorUnitSpacing = 0
                          XAxis.TextTop.Font.Charset = DEFAULT_CHARSET
                          XAxis.TextTop.Font.Color = clWindowText
                          XAxis.TextTop.Font.Height = -11
                          XAxis.TextTop.Font.Name = 'Tahoma'
                          XAxis.TextTop.Font.Style = []
                          XAxis.TextBottom.Font.Charset = DEFAULT_CHARSET
                          XAxis.TextBottom.Font.Color = clWindowText
                          XAxis.TextBottom.Font.Height = -11
                          XAxis.TextBottom.Font.Name = 'Tahoma'
                          XAxis.TextBottom.Font.Style = []
                          XAxis.TickMarkSize = 6
                          YAxis.MajorFont.Charset = DEFAULT_CHARSET
                          YAxis.MajorFont.Color = clWindowText
                          YAxis.MajorFont.Height = -11
                          YAxis.MajorFont.Name = 'Tahoma'
                          YAxis.MajorFont.Style = []
                          YAxis.MajorUnit = 1.000000000000000000
                          YAxis.MajorUnitSpacing = 0
                          YAxis.MinorFont.Charset = DEFAULT_CHARSET
                          YAxis.MinorFont.Color = clWindowText
                          YAxis.MinorFont.Height = -11
                          YAxis.MinorFont.Name = 'Tahoma'
                          YAxis.MinorFont.Style = []
                          YAxis.MinorUnitSpacing = 10
                          YAxis.TextLeft.Angle = -90
                          YAxis.TextLeft.Font.Charset = DEFAULT_CHARSET
                          YAxis.TextLeft.Font.Color = clWindowText
                          YAxis.TextLeft.Font.Height = -11
                          YAxis.TextLeft.Font.Name = 'Tahoma'
                          YAxis.TextLeft.Font.Style = []
                          YAxis.TextRight.Angle = 90
                          YAxis.TextRight.Font.Charset = DEFAULT_CHARSET
                          YAxis.TextRight.Font.Color = clWindowText
                          YAxis.TextRight.Font.Height = -11
                          YAxis.TextRight.Font.Name = 'Tahoma'
                          YAxis.TextRight.Font.Style = []
                          YAxis.TickMarkColor = clRed
                          BarValueTextFont.Charset = DEFAULT_CHARSET
                          BarValueTextFont.Color = clWindowText
                          BarValueTextFont.Height = -11
                          BarValueTextFont.Name = 'Tahoma'
                          BarValueTextFont.Style = []
                          XAxisGroups = <>
                          GradientType = gtHorizontal
                          SerieType = stNormal
                        end>
                      Title.Alignment = taCenter
                      Title.Color = clGray
                      Title.Font.Charset = DEFAULT_CHARSET
                      Title.Font.Color = clWindowText
                      Title.Font.Height = -11
                      Title.Font.Name = 'Tahoma'
                      Title.Font.Style = []
                      Title.Position = tTop
                      Title.Text = 'Darstellung'
                      XAxis.Font.Charset = DEFAULT_CHARSET
                      XAxis.Font.Color = clWindowText
                      XAxis.Font.Height = -11
                      XAxis.Font.Name = 'Tahoma'
                      XAxis.Font.Style = []
                      XAxis.Position = xNone
                      XAxis.Text = 'X-axis'
                      XGrid.MajorFont.Charset = DEFAULT_CHARSET
                      XGrid.MajorFont.Color = clWindowText
                      XGrid.MajorFont.Height = -11
                      XGrid.MajorFont.Name = 'Tahoma'
                      XGrid.MajorFont.Style = []
                      XGrid.MinorFont.Charset = DEFAULT_CHARSET
                      XGrid.MinorFont.Color = clWindowText
                      XGrid.MinorFont.Height = -11
                      XGrid.MinorFont.Name = 'Tahoma'
                      XGrid.MinorFont.Style = []
                      YAxis.Font.Charset = DEFAULT_CHARSET
                      YAxis.Font.Color = clWindowText
                      YAxis.Font.Height = -11
                      YAxis.Font.Name = 'Tahoma'
                      YAxis.Font.Style = []
                      YAxis.Position = yNone
                      YAxis.Size = 40
                      YAxis.Text = 'Y-axis'
                      YGrid.MinorDistance = 1.000000000000000000
                      YGrid.MajorDistance = 2.000000000000000000
                    end>
                  Tracker.Font.Charset = DEFAULT_CHARSET
                  Tracker.Font.Color = clWindowText
                  Tracker.Font.Height = -11
                  Tracker.Font.Name = 'Tahoma'
                  Tracker.Font.Style = []
                  Tracker.Title.Font.Charset = DEFAULT_CHARSET
                  Tracker.Title.Font.Color = clWindowText
                  Tracker.Title.Font.Height = -11
                  Tracker.Title.Font.Name = 'Tahoma'
                  Tracker.Title.Font.Style = []
                  Tracker.Title.Text = 'TRACKER'
                  Tracker.OpenValuePrefix = 'O:'
                  Tracker.HighValuePrefix = 'H:'
                  Tracker.LowValuePrefix = 'L:'
                  Tracker.CloseValuePrefix = 'C:'
                  Version = '4.2.1.6 APR, 2018'
                  XAxisZoomSensitivity = 1.000000000000000000
                  YAxisZoomSensitivity = 1.000000000000000000
                  DoubleBuffered = True
                  ExplicitLeft = -216
                  ExplicitTop = 256
                  ExplicitWidth = 597
                  ExplicitHeight = 305
                end
              end
            end
          end
        end
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'TabSheet8'
      ImageIndex = 7
      TabVisible = False
      object Button9: TButton
        Left = 36
        Top = 76
        Width = 125
        Height = 29
        Caption = 'Button9'
        TabOrder = 0
        OnClick = Button9Click
      end
      object AdvGDIPChartView2: TAdvGDIPChartView
        Left = 859
        Top = -8
        Width = 633
        Height = 561
        ShowDesignHelper = False
        Color = clWhite
        Panes = <
          item
            Bands.Distance = 2.000000000000000000
            Bands.GradientDirection = cgdVertical
            Bands.PrimaryColorTo = clSilver
            Bands.SecondaryColor = clGray
            Bands.SecondaryColorTo = clGray
            Background.BackGroundPosition = bpStretched
            Background.Color = 26367
            Background.ColorTo = 10092543
            Background.Font.Charset = DEFAULT_CHARSET
            Background.Font.Color = clWindowText
            Background.Font.Height = -11
            Background.Font.Name = 'Tahoma'
            Background.Font.Style = []
            Background.PictureVisible = True
            Background.GradientType = gtHorizontal
            BorderColor = clGreen
            BorderWidth = 7
            CrossHair.CrossHairYValues.Position = [chYAxis]
            CrossHair.Distance = 0
            Height = 100.000000000000000000
            Legend.ColorTo = clWhite
            Legend.Font.Charset = DEFAULT_CHARSET
            Legend.Font.Color = clWindowText
            Legend.Font.Height = -19
            Legend.Font.Name = 'Tahoma'
            Legend.Font.Style = []
            Legend.Left = 5
            Legend.Top = 5
            Legend.RectangleSize = 20
            Legend.Visible = False
            Legend.GradientType = gtVertical
            Legend.Opacity = 100
            Legend.OpacityTo = 100
            Name = 'ChartPane 0'
            Options = []
            Range.RangeTo = 9
            Series = <
              item
                AutoRange = arEnabledZeroBased
                Pie.Position = spCustom
                Pie.Left = 111
                Pie.Top = 111
                Pie.Size = 120
                Pie.ShowValues = True
                Pie.ValueFont.Charset = ANSI_CHARSET
                Pie.ValueFont.Color = clWhite
                Pie.ValueFont.Height = -13
                Pie.ValueFont.Name = 'Tw Cen MT'
                Pie.ValueFont.Style = []
                Pie.LegendFont.Charset = ANSI_CHARSET
                Pie.LegendFont.Color = clBlack
                Pie.LegendFont.Height = -13
                Pie.LegendFont.Name = 'Tw Cen MT'
                Pie.LegendFont.Style = []
                Pie.LegendTitleColor = clWhite
                Pie.LegendTitleColorTo = 52377
                Pie.LegendTitleGradientType = gtHatch
                Pie.LegendTitleHatchStyle = HatchStyleForwardDiagonal
                Annotations = <>
                BorderColor = clGray
                ChartType = ctPie
                Color = clNone
                CrossHairYValue.BorderWidth = 0
                CrossHairYValue.Font.Charset = DEFAULT_CHARSET
                CrossHairYValue.Font.Color = clWindowText
                CrossHairYValue.Font.Height = -11
                CrossHairYValue.Font.Name = 'Tahoma'
                CrossHairYValue.Font.Style = []
                CrossHairYValue.GradientSteps = 0
                LegendText = 'Pie Chart 1'
                Marker.MarkerColorTo = clBlack
                Maximum = 12.000000000000000000
                Name = 'Serie 1'
                ValueFont.Charset = DEFAULT_CHARSET
                ValueFont.Color = clWindowText
                ValueFont.Height = -11
                ValueFont.Name = 'Tahoma'
                ValueFont.Style = []
                ValueFormat = '%.2g'
                ValueType = cvPercentage
                ValueWidth = 80
                XAxis.DateTimeFont.Charset = DEFAULT_CHARSET
                XAxis.DateTimeFont.Color = clWindowText
                XAxis.DateTimeFont.Height = -11
                XAxis.DateTimeFont.Name = 'Tahoma'
                XAxis.DateTimeFont.Style = []
                XAxis.MajorFont.Charset = DEFAULT_CHARSET
                XAxis.MajorFont.Color = clWindowText
                XAxis.MajorFont.Height = -11
                XAxis.MajorFont.Name = 'Tahoma'
                XAxis.MajorFont.Style = []
                XAxis.MajorUnit = 1.000000000000000000
                XAxis.MajorUnitSpacing = 0
                XAxis.MinorFont.Charset = DEFAULT_CHARSET
                XAxis.MinorFont.Color = clWindowText
                XAxis.MinorFont.Height = -11
                XAxis.MinorFont.Name = 'Tahoma'
                XAxis.MinorFont.Style = []
                XAxis.MinorUnit = 1.000000000000000000
                XAxis.MinorUnitSpacing = 0
                XAxis.TextTop.Font.Charset = DEFAULT_CHARSET
                XAxis.TextTop.Font.Color = clWindowText
                XAxis.TextTop.Font.Height = -11
                XAxis.TextTop.Font.Name = 'Tahoma'
                XAxis.TextTop.Font.Style = []
                XAxis.TextBottom.Font.Charset = DEFAULT_CHARSET
                XAxis.TextBottom.Font.Color = clWindowText
                XAxis.TextBottom.Font.Height = -11
                XAxis.TextBottom.Font.Name = 'Tahoma'
                XAxis.TextBottom.Font.Style = []
                XAxis.Visible = False
                YAxis.MajorFont.Charset = DEFAULT_CHARSET
                YAxis.MajorFont.Color = clWindowText
                YAxis.MajorFont.Height = -11
                YAxis.MajorFont.Name = 'Tahoma'
                YAxis.MajorFont.Style = []
                YAxis.MajorUnitSpacing = 0
                YAxis.MinorFont.Charset = DEFAULT_CHARSET
                YAxis.MinorFont.Color = clWindowText
                YAxis.MinorFont.Height = -11
                YAxis.MinorFont.Name = 'Tahoma'
                YAxis.MinorFont.Style = []
                YAxis.MinorUnitSpacing = 0
                YAxis.Position = yNone
                YAxis.TextLeft.Font.Charset = DEFAULT_CHARSET
                YAxis.TextLeft.Font.Color = clWindowText
                YAxis.TextLeft.Font.Height = -11
                YAxis.TextLeft.Font.Name = 'Tahoma'
                YAxis.TextLeft.Font.Style = []
                YAxis.TextRight.Font.Charset = DEFAULT_CHARSET
                YAxis.TextRight.Font.Color = clWindowText
                YAxis.TextRight.Font.Height = -11
                YAxis.TextRight.Font.Name = 'Tahoma'
                YAxis.TextRight.Font.Style = []
                BarValueTextFont.Charset = DEFAULT_CHARSET
                BarValueTextFont.Color = clWindowText
                BarValueTextFont.Height = -11
                BarValueTextFont.Name = 'Tahoma'
                BarValueTextFont.Style = []
                XAxisGroups = <>
                Angle = 90
                Opacity = 209
                GradientType = gtBackwardDiagonal
                SerieType = stNormal
              end
              item
                AutoRange = arEnabledZeroBased
                Pie.Position = spCustom
                Pie.Left = 121
                Pie.Top = 555
                Pie.Size = 120
                Pie.ShowValues = True
                Pie.ValueFont.Charset = ANSI_CHARSET
                Pie.ValueFont.Color = clWhite
                Pie.ValueFont.Height = -13
                Pie.ValueFont.Name = 'Tw Cen MT'
                Pie.ValueFont.Style = []
                Pie.LegendFont.Charset = ANSI_CHARSET
                Pie.LegendFont.Color = clBlack
                Pie.LegendFont.Height = -13
                Pie.LegendFont.Name = 'Tw Cen MT'
                Pie.LegendFont.Style = []
                Pie.LegendTitleColor = clWhite
                Pie.LegendTitleColorTo = 52377
                Pie.LegendTitleGradientType = gtHatch
                Pie.LegendTitleHatchStyle = HatchStyleForwardDiagonal
                Annotations = <>
                BorderColor = clGray
                ChartType = ctPie
                Color = clNone
                CrossHairYValue.BorderWidth = 0
                CrossHairYValue.Font.Charset = DEFAULT_CHARSET
                CrossHairYValue.Font.Color = clWindowText
                CrossHairYValue.Font.Height = -11
                CrossHairYValue.Font.Name = 'Tahoma'
                CrossHairYValue.Font.Style = []
                CrossHairYValue.GradientSteps = 0
                LegendText = 'Pie Chart 1'
                Marker.MarkerColorTo = clBlack
                Maximum = 12.000000000000000000
                Name = 'Serie 1'
                ValueFont.Charset = DEFAULT_CHARSET
                ValueFont.Color = clWindowText
                ValueFont.Height = -11
                ValueFont.Name = 'Tahoma'
                ValueFont.Style = []
                ValueFormat = '%.2g'
                ValueType = cvPercentage
                ValueWidth = 80
                XAxis.DateTimeFont.Charset = DEFAULT_CHARSET
                XAxis.DateTimeFont.Color = clWindowText
                XAxis.DateTimeFont.Height = -11
                XAxis.DateTimeFont.Name = 'Tahoma'
                XAxis.DateTimeFont.Style = []
                XAxis.MajorFont.Charset = DEFAULT_CHARSET
                XAxis.MajorFont.Color = clWindowText
                XAxis.MajorFont.Height = -11
                XAxis.MajorFont.Name = 'Tahoma'
                XAxis.MajorFont.Style = []
                XAxis.MajorUnit = 1.000000000000000000
                XAxis.MajorUnitSpacing = 0
                XAxis.MinorFont.Charset = DEFAULT_CHARSET
                XAxis.MinorFont.Color = clWindowText
                XAxis.MinorFont.Height = -11
                XAxis.MinorFont.Name = 'Tahoma'
                XAxis.MinorFont.Style = []
                XAxis.MinorUnit = 1.000000000000000000
                XAxis.MinorUnitSpacing = 0
                XAxis.TextTop.Font.Charset = DEFAULT_CHARSET
                XAxis.TextTop.Font.Color = clWindowText
                XAxis.TextTop.Font.Height = -11
                XAxis.TextTop.Font.Name = 'Tahoma'
                XAxis.TextTop.Font.Style = []
                XAxis.TextBottom.Font.Charset = DEFAULT_CHARSET
                XAxis.TextBottom.Font.Color = clWindowText
                XAxis.TextBottom.Font.Height = -11
                XAxis.TextBottom.Font.Name = 'Tahoma'
                XAxis.TextBottom.Font.Style = []
                XAxis.Visible = False
                YAxis.MajorFont.Charset = DEFAULT_CHARSET
                YAxis.MajorFont.Color = clWindowText
                YAxis.MajorFont.Height = -11
                YAxis.MajorFont.Name = 'Tahoma'
                YAxis.MajorFont.Style = []
                YAxis.MajorUnitSpacing = 0
                YAxis.MinorFont.Charset = DEFAULT_CHARSET
                YAxis.MinorFont.Color = clWindowText
                YAxis.MinorFont.Height = -11
                YAxis.MinorFont.Name = 'Tahoma'
                YAxis.MinorFont.Style = []
                YAxis.MinorUnitSpacing = 0
                YAxis.Position = yNone
                YAxis.TextLeft.Font.Charset = DEFAULT_CHARSET
                YAxis.TextLeft.Font.Color = clWindowText
                YAxis.TextLeft.Font.Height = -11
                YAxis.TextLeft.Font.Name = 'Tahoma'
                YAxis.TextLeft.Font.Style = []
                YAxis.TextRight.Font.Charset = DEFAULT_CHARSET
                YAxis.TextRight.Font.Color = clWindowText
                YAxis.TextRight.Font.Height = -11
                YAxis.TextRight.Font.Name = 'Tahoma'
                YAxis.TextRight.Font.Style = []
                BarValueTextFont.Charset = DEFAULT_CHARSET
                BarValueTextFont.Color = clWindowText
                BarValueTextFont.Height = -11
                BarValueTextFont.Name = 'Tahoma'
                BarValueTextFont.Style = []
                XAxisGroups = <>
                Angle = 90
                Opacity = 209
                GradientType = gtBackwardDiagonal
                SerieType = stNormal
              end
              item
                AutoRange = arEnabledZeroBased
                Pie.Position = spCustom
                Pie.Left = 221
                Pie.Top = 555
                Pie.Size = 120
                Pie.ShowValues = True
                Pie.ValueFont.Charset = ANSI_CHARSET
                Pie.ValueFont.Color = clWhite
                Pie.ValueFont.Height = -13
                Pie.ValueFont.Name = 'Tw Cen MT'
                Pie.ValueFont.Style = []
                Pie.LegendFont.Charset = ANSI_CHARSET
                Pie.LegendFont.Color = clBlack
                Pie.LegendFont.Height = -13
                Pie.LegendFont.Name = 'Tw Cen MT'
                Pie.LegendFont.Style = []
                Pie.LegendTitleColor = clWhite
                Pie.LegendTitleColorTo = 52377
                Pie.LegendTitleGradientType = gtHatch
                Pie.LegendTitleHatchStyle = HatchStyleForwardDiagonal
                Annotations = <>
                BorderColor = clGray
                ChartType = ctPie
                Color = clNone
                CrossHairYValue.BorderWidth = 0
                CrossHairYValue.Font.Charset = DEFAULT_CHARSET
                CrossHairYValue.Font.Color = clWindowText
                CrossHairYValue.Font.Height = -11
                CrossHairYValue.Font.Name = 'Tahoma'
                CrossHairYValue.Font.Style = []
                CrossHairYValue.GradientSteps = 0
                LegendText = 'Pie Chart 1'
                Marker.MarkerColorTo = clBlack
                Maximum = 12.000000000000000000
                Name = 'Serie 1'
                ValueFont.Charset = DEFAULT_CHARSET
                ValueFont.Color = clWindowText
                ValueFont.Height = -11
                ValueFont.Name = 'Tahoma'
                ValueFont.Style = []
                ValueFormat = '%.2g'
                ValueType = cvPercentage
                ValueWidth = 80
                XAxis.DateTimeFont.Charset = DEFAULT_CHARSET
                XAxis.DateTimeFont.Color = clWindowText
                XAxis.DateTimeFont.Height = -11
                XAxis.DateTimeFont.Name = 'Tahoma'
                XAxis.DateTimeFont.Style = []
                XAxis.MajorFont.Charset = DEFAULT_CHARSET
                XAxis.MajorFont.Color = clWindowText
                XAxis.MajorFont.Height = -11
                XAxis.MajorFont.Name = 'Tahoma'
                XAxis.MajorFont.Style = []
                XAxis.MajorUnit = 1.000000000000000000
                XAxis.MajorUnitSpacing = 0
                XAxis.MinorFont.Charset = DEFAULT_CHARSET
                XAxis.MinorFont.Color = clWindowText
                XAxis.MinorFont.Height = -11
                XAxis.MinorFont.Name = 'Tahoma'
                XAxis.MinorFont.Style = []
                XAxis.MinorUnit = 1.000000000000000000
                XAxis.MinorUnitSpacing = 0
                XAxis.TextTop.Font.Charset = DEFAULT_CHARSET
                XAxis.TextTop.Font.Color = clWindowText
                XAxis.TextTop.Font.Height = -11
                XAxis.TextTop.Font.Name = 'Tahoma'
                XAxis.TextTop.Font.Style = []
                XAxis.TextBottom.Font.Charset = DEFAULT_CHARSET
                XAxis.TextBottom.Font.Color = clWindowText
                XAxis.TextBottom.Font.Height = -11
                XAxis.TextBottom.Font.Name = 'Tahoma'
                XAxis.TextBottom.Font.Style = []
                XAxis.Visible = False
                YAxis.MajorFont.Charset = DEFAULT_CHARSET
                YAxis.MajorFont.Color = clWindowText
                YAxis.MajorFont.Height = -11
                YAxis.MajorFont.Name = 'Tahoma'
                YAxis.MajorFont.Style = []
                YAxis.MajorUnitSpacing = 0
                YAxis.MinorFont.Charset = DEFAULT_CHARSET
                YAxis.MinorFont.Color = clWindowText
                YAxis.MinorFont.Height = -11
                YAxis.MinorFont.Name = 'Tahoma'
                YAxis.MinorFont.Style = []
                YAxis.MinorUnitSpacing = 0
                YAxis.Position = yNone
                YAxis.TextLeft.Font.Charset = DEFAULT_CHARSET
                YAxis.TextLeft.Font.Color = clWindowText
                YAxis.TextLeft.Font.Height = -11
                YAxis.TextLeft.Font.Name = 'Tahoma'
                YAxis.TextLeft.Font.Style = []
                YAxis.TextRight.Font.Charset = DEFAULT_CHARSET
                YAxis.TextRight.Font.Color = clWindowText
                YAxis.TextRight.Font.Height = -11
                YAxis.TextRight.Font.Name = 'Tahoma'
                YAxis.TextRight.Font.Style = []
                BarValueTextFont.Charset = DEFAULT_CHARSET
                BarValueTextFont.Color = clWindowText
                BarValueTextFont.Height = -11
                BarValueTextFont.Name = 'Tahoma'
                BarValueTextFont.Style = []
                XAxisGroups = <>
                Angle = 90
                Opacity = 209
                GradientType = gtBackwardDiagonal
                SerieType = stNormal
              end
              item
                Pie.Position = spCustom
                Pie.Left = 300
                Pie.Top = 300
                Pie.ShowValues = True
                Pie.ValueFont.Charset = DEFAULT_CHARSET
                Pie.ValueFont.Color = clWindowText
                Pie.ValueFont.Height = -11
                Pie.ValueFont.Name = 'Tahoma'
                Pie.ValueFont.Style = []
                Pie.LegendFont.Charset = DEFAULT_CHARSET
                Pie.LegendFont.Color = clWindowText
                Pie.LegendFont.Height = -11
                Pie.LegendFont.Name = 'Tahoma'
                Pie.LegendFont.Style = []
                Annotations = <>
                ChartType = ctPie
                Color = clNone
                CrossHairYValue.BorderWidth = 0
                CrossHairYValue.Font.Charset = DEFAULT_CHARSET
                CrossHairYValue.Font.Color = clWindowText
                CrossHairYValue.Font.Height = -11
                CrossHairYValue.Font.Name = 'Tahoma'
                CrossHairYValue.Font.Style = []
                CrossHairYValue.GradientSteps = 0
                LegendText = 'Serie 3'
                Maximum = 12.000000000000000000
                Name = 'Serie 3'
                ValueFont.Charset = DEFAULT_CHARSET
                ValueFont.Color = clWindowText
                ValueFont.Height = -11
                ValueFont.Name = 'Tahoma'
                ValueFont.Style = []
                ValueFormat = '%.2g'
                ValueType = cvPercentage
                XAxis.DateTimeFont.Charset = DEFAULT_CHARSET
                XAxis.DateTimeFont.Color = clWindowText
                XAxis.DateTimeFont.Height = -11
                XAxis.DateTimeFont.Name = 'Tahoma'
                XAxis.DateTimeFont.Style = []
                XAxis.MajorFont.Charset = DEFAULT_CHARSET
                XAxis.MajorFont.Color = clWindowText
                XAxis.MajorFont.Height = -11
                XAxis.MajorFont.Name = 'Tahoma'
                XAxis.MajorFont.Style = []
                XAxis.MajorUnit = 1.000000000000000000
                XAxis.MajorUnitSpacing = 0
                XAxis.MinorFont.Charset = DEFAULT_CHARSET
                XAxis.MinorFont.Color = clWindowText
                XAxis.MinorFont.Height = -11
                XAxis.MinorFont.Name = 'Tahoma'
                XAxis.MinorFont.Style = []
                XAxis.MinorUnit = 1.000000000000000000
                XAxis.MinorUnitSpacing = 0
                XAxis.TextTop.Font.Charset = DEFAULT_CHARSET
                XAxis.TextTop.Font.Color = clWindowText
                XAxis.TextTop.Font.Height = -11
                XAxis.TextTop.Font.Name = 'Tahoma'
                XAxis.TextTop.Font.Style = []
                XAxis.TextBottom.Font.Charset = DEFAULT_CHARSET
                XAxis.TextBottom.Font.Color = clWindowText
                XAxis.TextBottom.Font.Height = -11
                XAxis.TextBottom.Font.Name = 'Tahoma'
                XAxis.TextBottom.Font.Style = []
                XAxis.Visible = False
                YAxis.MajorFont.Charset = DEFAULT_CHARSET
                YAxis.MajorFont.Color = clWindowText
                YAxis.MajorFont.Height = -11
                YAxis.MajorFont.Name = 'Tahoma'
                YAxis.MajorFont.Style = []
                YAxis.MajorUnitSpacing = 0
                YAxis.MinorFont.Charset = DEFAULT_CHARSET
                YAxis.MinorFont.Color = clWindowText
                YAxis.MinorFont.Height = -11
                YAxis.MinorFont.Name = 'Tahoma'
                YAxis.MinorFont.Style = []
                YAxis.MinorUnitSpacing = 0
                YAxis.TextLeft.Font.Charset = DEFAULT_CHARSET
                YAxis.TextLeft.Font.Color = clWindowText
                YAxis.TextLeft.Font.Height = -11
                YAxis.TextLeft.Font.Name = 'Tahoma'
                YAxis.TextLeft.Font.Style = []
                YAxis.TextRight.Font.Charset = DEFAULT_CHARSET
                YAxis.TextRight.Font.Color = clWindowText
                YAxis.TextRight.Font.Height = -11
                YAxis.TextRight.Font.Name = 'Tahoma'
                YAxis.TextRight.Font.Style = []
                BarValueTextFont.Charset = DEFAULT_CHARSET
                BarValueTextFont.Color = clWindowText
                BarValueTextFont.Height = -11
                BarValueTextFont.Name = 'Tahoma'
                BarValueTextFont.Style = []
                XAxisGroups = <>
                Angle = 90
                Opacity = 205
                GradientType = gtBackwardDiagonal
                SerieType = stNormal
              end>
            Title.Alignment = taCenter
            Title.GradientSteps = 0
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -24
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = []
            Title.Position = tTop
            Title.Size = 30
            Title.Text = 'Pie chart with TAdvChartviewGDIP'
            XAxis.Font.Charset = DEFAULT_CHARSET
            XAxis.Font.Color = clWindowText
            XAxis.Font.Height = -11
            XAxis.Font.Name = 'Tahoma'
            XAxis.Font.Style = []
            XAxis.Position = xNone
            XAxis.Text = 'X-axis'
            XAxis.Enable3D = True
            XAxis.Offset3D = 49
            XGrid.MinorDistance = 1
            XGrid.MajorDistance = 2
            XGrid.MajorFont.Charset = DEFAULT_CHARSET
            XGrid.MajorFont.Color = clWindowText
            XGrid.MajorFont.Height = -11
            XGrid.MajorFont.Name = 'Tahoma'
            XGrid.MajorFont.Style = []
            XGrid.MinorFont.Charset = DEFAULT_CHARSET
            XGrid.MinorFont.Color = clWindowText
            XGrid.MinorFont.Height = -11
            XGrid.MinorFont.Name = 'Tahoma'
            XGrid.MinorFont.Style = []
            YAxis.Font.Charset = DEFAULT_CHARSET
            YAxis.Font.Color = clWindowText
            YAxis.Font.Height = -11
            YAxis.Font.Name = 'Tahoma'
            YAxis.Font.Style = []
            YAxis.Position = yNone
            YAxis.Size = 40
            YAxis.Text = 'Y-axis'
            YGrid.MinorDistance = 1.000000000000000000
            YGrid.MajorDistance = 2.000000000000000000
            YGrid.ShowBorder = True
            ZoomControl.Visible = True
          end>
        TabOrder = 1
        Tracker.Font.Charset = DEFAULT_CHARSET
        Tracker.Font.Color = clWindowText
        Tracker.Font.Height = -11
        Tracker.Font.Name = 'Tahoma'
        Tracker.Font.Style = []
        Tracker.Title.Font.Charset = DEFAULT_CHARSET
        Tracker.Title.Font.Color = clWindowText
        Tracker.Title.Font.Height = -11
        Tracker.Title.Font.Name = 'Tahoma'
        Tracker.Title.Font.Style = []
        Tracker.Title.Text = 'TRACKER'
        Tracker.OpenValuePrefix = 'O:'
        Tracker.HighValuePrefix = 'H:'
        Tracker.LowValuePrefix = 'L:'
        Tracker.CloseValuePrefix = 'C:'
        Version = '4.2.1.6 APR, 2018'
        XAxisZoomSensitivity = 1.000000000000000000
        YAxisZoomSensitivity = 1.000000000000000000
        DoubleBuffered = True
      end
      object AdvGDIPChartView1: TAdvGDIPChartView
        Left = 288
        Top = 10
        Width = 565
        Height = 853
        Color = clWhite
        Panes = <
          item
            Bands.Distance = 2.000000000000000000
            Bands.GradientDirection = cgdVertical
            Bands.PrimaryColorTo = clSilver
            Bands.SecondaryColor = clGray
            Bands.SecondaryColorTo = clGray
            Background.BackGroundPosition = bpStretched
            Background.Color = clWhite
            Background.Font.Charset = DEFAULT_CHARSET
            Background.Font.Color = clWindowText
            Background.Font.Height = -11
            Background.Font.Name = 'Tahoma'
            Background.Font.Style = []
            Background.PictureVisible = True
            Background.GradientType = gtSolid
            CrossHair.CrossHairYValues.Position = [chYAxis]
            CrossHair.Distance = 0
            Height = 100.000000000000000000
            Legend.ColorTo = clWhite
            Legend.Font.Charset = DEFAULT_CHARSET
            Legend.Font.Color = clWindowText
            Legend.Font.Height = -19
            Legend.Font.Name = 'Tahoma'
            Legend.Font.Style = []
            Legend.Left = 5
            Legend.Top = 5
            Legend.RectangleSize = 20
            Legend.Visible = False
            Legend.GradientType = gtVertical
            Legend.Opacity = 100
            Legend.OpacityTo = 100
            Name = 'ChartPane 0'
            Options = []
            Range.RangeTo = 9
            Series = <
              item
                AutoRange = arEnabledZeroBased
                Pie.Position = spCustom
                Pie.Left = 222
                Pie.Top = 222
                Pie.ShowValues = True
                Pie.ValueFont.Charset = ANSI_CHARSET
                Pie.ValueFont.Color = clWhite
                Pie.ValueFont.Height = -13
                Pie.ValueFont.Name = 'Tw Cen MT'
                Pie.ValueFont.Style = []
                Pie.LegendVisible = False
                Pie.LegendFont.Charset = ANSI_CHARSET
                Pie.LegendFont.Color = clBlack
                Pie.LegendFont.Height = -13
                Pie.LegendFont.Name = 'Tw Cen MT'
                Pie.LegendFont.Style = []
                Pie.LegendTitleColor = clWhite
                Pie.LegendTitleColorTo = 52377
                Pie.LegendTitleGradientType = gtHatch
                Pie.LegendTitleHatchStyle = HatchStyleForwardDiagonal
                Annotations = <>
                BorderColor = clGray
                ChartType = ctBar
                Color = clNone
                CrossHairYValue.BorderWidth = 0
                CrossHairYValue.Font.Charset = DEFAULT_CHARSET
                CrossHairYValue.Font.Color = clWindowText
                CrossHairYValue.Font.Height = -11
                CrossHairYValue.Font.Name = 'Tahoma'
                CrossHairYValue.Font.Style = []
                CrossHairYValue.GradientSteps = 0
                LegendText = 'Pie Chart 1'
                Marker.MarkerColorTo = clBlack
                Maximum = 12.000000000000000000
                Name = 'Serie 1'
                ValueFont.Charset = DEFAULT_CHARSET
                ValueFont.Color = clWindowText
                ValueFont.Height = -11
                ValueFont.Name = 'Tahoma'
                ValueFont.Style = []
                ValueFormat = '%.2g'
                ValueType = cvPercentage
                ValueWidth = 80
                XAxis.DateTimeFont.Charset = DEFAULT_CHARSET
                XAxis.DateTimeFont.Color = clWindowText
                XAxis.DateTimeFont.Height = -11
                XAxis.DateTimeFont.Name = 'Tahoma'
                XAxis.DateTimeFont.Style = []
                XAxis.MajorFont.Charset = DEFAULT_CHARSET
                XAxis.MajorFont.Color = clWindowText
                XAxis.MajorFont.Height = -11
                XAxis.MajorFont.Name = 'Tahoma'
                XAxis.MajorFont.Style = []
                XAxis.MajorUnit = 1.000000000000000000
                XAxis.MajorUnitSpacing = 0
                XAxis.MinorFont.Charset = DEFAULT_CHARSET
                XAxis.MinorFont.Color = clWindowText
                XAxis.MinorFont.Height = -11
                XAxis.MinorFont.Name = 'Tahoma'
                XAxis.MinorFont.Style = []
                XAxis.MinorUnit = 1.000000000000000000
                XAxis.MinorUnitSpacing = 0
                XAxis.TextTop.Font.Charset = DEFAULT_CHARSET
                XAxis.TextTop.Font.Color = clWindowText
                XAxis.TextTop.Font.Height = -11
                XAxis.TextTop.Font.Name = 'Tahoma'
                XAxis.TextTop.Font.Style = []
                XAxis.TextBottom.Font.Charset = DEFAULT_CHARSET
                XAxis.TextBottom.Font.Color = clWindowText
                XAxis.TextBottom.Font.Height = -11
                XAxis.TextBottom.Font.Name = 'Tahoma'
                XAxis.TextBottom.Font.Style = []
                XAxis.Visible = False
                YAxis.MajorFont.Charset = DEFAULT_CHARSET
                YAxis.MajorFont.Color = clWindowText
                YAxis.MajorFont.Height = -11
                YAxis.MajorFont.Name = 'Tahoma'
                YAxis.MajorFont.Style = []
                YAxis.MajorUnitSpacing = 0
                YAxis.MinorFont.Charset = DEFAULT_CHARSET
                YAxis.MinorFont.Color = clWindowText
                YAxis.MinorFont.Height = -11
                YAxis.MinorFont.Name = 'Tahoma'
                YAxis.MinorFont.Style = []
                YAxis.MinorUnitSpacing = 0
                YAxis.Position = yNone
                YAxis.TextLeft.Font.Charset = DEFAULT_CHARSET
                YAxis.TextLeft.Font.Color = clWindowText
                YAxis.TextLeft.Font.Height = -11
                YAxis.TextLeft.Font.Name = 'Tahoma'
                YAxis.TextLeft.Font.Style = []
                YAxis.TextRight.Font.Charset = DEFAULT_CHARSET
                YAxis.TextRight.Font.Color = clWindowText
                YAxis.TextRight.Font.Height = -11
                YAxis.TextRight.Font.Name = 'Tahoma'
                YAxis.TextRight.Font.Style = []
                BarValueTextFont.Charset = DEFAULT_CHARSET
                BarValueTextFont.Color = clWindowText
                BarValueTextFont.Height = -11
                BarValueTextFont.Name = 'Tahoma'
                BarValueTextFont.Style = []
                XAxisGroups = <>
                Angle = 90
                Opacity = 209
                GradientType = gtBackwardDiagonal
                SerieType = stNormal
              end>
            Title.Alignment = taCenter
            Title.GradientSteps = 0
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -24
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = []
            Title.Position = tTop
            Title.Size = 30
            Title.Text = 'Pie chart with TAdvChartviewGDIP'
            XAxis.Font.Charset = DEFAULT_CHARSET
            XAxis.Font.Color = clWindowText
            XAxis.Font.Height = -11
            XAxis.Font.Name = 'Tahoma'
            XAxis.Font.Style = []
            XAxis.Position = xNone
            XAxis.Text = 'X-axis'
            XGrid.MinorDistance = 1
            XGrid.MajorDistance = 2
            XGrid.MajorFont.Charset = DEFAULT_CHARSET
            XGrid.MajorFont.Color = clWindowText
            XGrid.MajorFont.Height = -11
            XGrid.MajorFont.Name = 'Tahoma'
            XGrid.MajorFont.Style = []
            XGrid.MinorFont.Charset = DEFAULT_CHARSET
            XGrid.MinorFont.Color = clWindowText
            XGrid.MinorFont.Height = -11
            XGrid.MinorFont.Name = 'Tahoma'
            XGrid.MinorFont.Style = []
            YAxis.Font.Charset = DEFAULT_CHARSET
            YAxis.Font.Color = clWindowText
            YAxis.Font.Height = -11
            YAxis.Font.Name = 'Tahoma'
            YAxis.Font.Style = []
            YAxis.Position = yNone
            YAxis.Size = 40
            YAxis.Text = 'Y-axis'
            YGrid.MinorDistance = 1.000000000000000000
            YGrid.MajorDistance = 2.000000000000000000
            YGrid.ShowBorder = True
          end>
        TabOrder = 2
        Tracker.Font.Charset = DEFAULT_CHARSET
        Tracker.Font.Color = clWindowText
        Tracker.Font.Height = -11
        Tracker.Font.Name = 'Tahoma'
        Tracker.Font.Style = []
        Tracker.Title.Font.Charset = DEFAULT_CHARSET
        Tracker.Title.Font.Color = clWindowText
        Tracker.Title.Font.Height = -11
        Tracker.Title.Font.Name = 'Tahoma'
        Tracker.Title.Font.Style = []
        Tracker.Title.Text = 'TRACKER'
        Tracker.OpenValuePrefix = 'O:'
        Tracker.HighValuePrefix = 'H:'
        Tracker.LowValuePrefix = 'L:'
        Tracker.CloseValuePrefix = 'C:'
        Version = '4.2.1.6 APR, 2018'
        XAxisZoomSensitivity = 1.000000000000000000
        YAxisZoomSensitivity = 1.000000000000000000
        DoubleBuffered = True
      end
      object AdvGDIPChartView3: TAdvGDIPChartView
        Left = 864
        Top = 568
        Width = 597
        Height = 305
        Color = clWhite
        Panes = <
          item
            Bands.Distance = 2.000000000000000000
            Background.Color = clSilver
            Background.ColorTo = 3355443
            Background.Font.Charset = DEFAULT_CHARSET
            Background.Font.Color = clWindowText
            Background.Font.Height = -11
            Background.Font.Name = 'Tahoma'
            Background.Font.Style = []
            Background.GradientType = gtForwardDiagonal
            BorderColor = clBlack
            CrossHair.CrossHairYValues.Position = [chYAxis]
            CrossHair.Distance = 0
            Height = 100.000000000000000000
            Legend.Font.Charset = DEFAULT_CHARSET
            Legend.Font.Color = clWindowText
            Legend.Font.Height = -11
            Legend.Font.Name = 'Tahoma'
            Legend.Font.Style = []
            Name = 'ChartPane 0'
            Options = []
            Range.StartDate = 43675.893897118050000000
            Range.RangeTo = 5
            Series = <
              item
                AutoRange = arDisabled
                Pie.ValueFont.Charset = DEFAULT_CHARSET
                Pie.ValueFont.Color = clWindowText
                Pie.ValueFont.Height = -11
                Pie.ValueFont.Name = 'Tahoma'
                Pie.ValueFont.Style = []
                Pie.LegendFont.Charset = DEFAULT_CHARSET
                Pie.LegendFont.Color = clWindowText
                Pie.LegendFont.Height = -11
                Pie.LegendFont.Name = 'Tahoma'
                Pie.LegendFont.Style = []
                Annotations = <>
                ChartType = ctPie
                Color = 22015
                CrossHairYValue.Font.Charset = DEFAULT_CHARSET
                CrossHairYValue.Font.Color = clWindowText
                CrossHairYValue.Font.Height = -11
                CrossHairYValue.Font.Name = 'Tahoma'
                CrossHairYValue.Font.Style = []
                CrossHairYValue.GradientSteps = 0
                LineColor = 22015
                LegendText = 'Serie 0'
                Marker.MarkerType = mCircle
                Marker.MarkerColor = 22015
                Marker.SelectedColor = 22015
                Marker.SelectedLineColor = clBlack
                Marker.SelectedSize = 15
                Maximum = 12.000000000000000000
                Name = 'Serie 0'
                ValueFont.Charset = DEFAULT_CHARSET
                ValueFont.Color = clWindowText
                ValueFont.Height = -11
                ValueFont.Name = 'Tahoma'
                ValueFont.Style = []
                ValueFormat = '%g'
                ValueWidth = 80
                XAxis.DateTimeFont.Charset = DEFAULT_CHARSET
                XAxis.DateTimeFont.Color = clWindowText
                XAxis.DateTimeFont.Height = -11
                XAxis.DateTimeFont.Name = 'Tahoma'
                XAxis.DateTimeFont.Style = []
                XAxis.MajorFont.Charset = DEFAULT_CHARSET
                XAxis.MajorFont.Color = clWindowText
                XAxis.MajorFont.Height = -11
                XAxis.MajorFont.Name = 'Tahoma'
                XAxis.MajorFont.Style = []
                XAxis.MajorUnit = 1.000000000000000000
                XAxis.MajorUnitSpacing = 0
                XAxis.MinorFont.Charset = DEFAULT_CHARSET
                XAxis.MinorFont.Color = clWindowText
                XAxis.MinorFont.Height = -11
                XAxis.MinorFont.Name = 'Tahoma'
                XAxis.MinorFont.Style = []
                XAxis.MinorUnit = 1.000000000000000000
                XAxis.MinorUnitSpacing = 0
                XAxis.TextTop.Font.Charset = DEFAULT_CHARSET
                XAxis.TextTop.Font.Color = clWindowText
                XAxis.TextTop.Font.Height = -11
                XAxis.TextTop.Font.Name = 'Tahoma'
                XAxis.TextTop.Font.Style = []
                XAxis.TextBottom.Font.Charset = DEFAULT_CHARSET
                XAxis.TextBottom.Font.Color = clWindowText
                XAxis.TextBottom.Font.Height = -11
                XAxis.TextBottom.Font.Name = 'Tahoma'
                XAxis.TextBottom.Font.Style = []
                XAxis.TickMarkSize = 6
                YAxis.MajorFont.Charset = DEFAULT_CHARSET
                YAxis.MajorFont.Color = clWindowText
                YAxis.MajorFont.Height = -11
                YAxis.MajorFont.Name = 'Tahoma'
                YAxis.MajorFont.Style = []
                YAxis.MajorUnit = 1.000000000000000000
                YAxis.MajorUnitSpacing = 0
                YAxis.MinorFont.Charset = DEFAULT_CHARSET
                YAxis.MinorFont.Color = clWindowText
                YAxis.MinorFont.Height = -11
                YAxis.MinorFont.Name = 'Tahoma'
                YAxis.MinorFont.Style = []
                YAxis.MinorUnitSpacing = 10
                YAxis.TextLeft.Angle = -90
                YAxis.TextLeft.Font.Charset = DEFAULT_CHARSET
                YAxis.TextLeft.Font.Color = clWindowText
                YAxis.TextLeft.Font.Height = -11
                YAxis.TextLeft.Font.Name = 'Tahoma'
                YAxis.TextLeft.Font.Style = []
                YAxis.TextRight.Angle = 90
                YAxis.TextRight.Font.Charset = DEFAULT_CHARSET
                YAxis.TextRight.Font.Color = clWindowText
                YAxis.TextRight.Font.Height = -11
                YAxis.TextRight.Font.Name = 'Tahoma'
                YAxis.TextRight.Font.Style = []
                YAxis.TickMarkColor = clRed
                BarValueTextFont.Charset = DEFAULT_CHARSET
                BarValueTextFont.Color = clWindowText
                BarValueTextFont.Height = -11
                BarValueTextFont.Name = 'Tahoma'
                BarValueTextFont.Style = []
                XAxisGroups = <>
                GradientType = gtHorizontal
                SerieType = stNormal
              end
              item
                AutoRange = arDisabled
                Pie.ValueFont.Charset = DEFAULT_CHARSET
                Pie.ValueFont.Color = clWindowText
                Pie.ValueFont.Height = -11
                Pie.ValueFont.Name = 'Tahoma'
                Pie.ValueFont.Style = []
                Pie.LegendFont.Charset = DEFAULT_CHARSET
                Pie.LegendFont.Color = clWindowText
                Pie.LegendFont.Height = -11
                Pie.LegendFont.Name = 'Tahoma'
                Pie.LegendFont.Style = []
                Annotations = <>
                Color = 13599488
                CrossHairYValue.BorderWidth = 0
                CrossHairYValue.Font.Charset = DEFAULT_CHARSET
                CrossHairYValue.Font.Color = clWindowText
                CrossHairYValue.Font.Height = -11
                CrossHairYValue.Font.Name = 'Tahoma'
                CrossHairYValue.Font.Style = []
                CrossHairYValue.GradientSteps = 0
                LineColor = 13599488
                LegendText = 'Serie 1'
                Marker.MarkerType = mCircle
                Marker.MarkerColor = 13599488
                Marker.SelectedColor = 13599488
                Marker.SelectedLineColor = clBlack
                Marker.SelectedSize = 15
                Maximum = 12.000000000000000000
                Name = 'Serie 1'
                ValueFont.Charset = DEFAULT_CHARSET
                ValueFont.Color = clWindowText
                ValueFont.Height = -11
                ValueFont.Name = 'Tahoma'
                ValueFont.Style = []
                ValueFormat = '%g'
                ValueWidth = 80
                XAxis.DateTimeFont.Charset = DEFAULT_CHARSET
                XAxis.DateTimeFont.Color = clWindowText
                XAxis.DateTimeFont.Height = -11
                XAxis.DateTimeFont.Name = 'Tahoma'
                XAxis.DateTimeFont.Style = []
                XAxis.MajorFont.Charset = DEFAULT_CHARSET
                XAxis.MajorFont.Color = clWindowText
                XAxis.MajorFont.Height = -11
                XAxis.MajorFont.Name = 'Tahoma'
                XAxis.MajorFont.Style = []
                XAxis.MajorUnit = 1.000000000000000000
                XAxis.MajorUnitSpacing = 0
                XAxis.MinorFont.Charset = DEFAULT_CHARSET
                XAxis.MinorFont.Color = clWindowText
                XAxis.MinorFont.Height = -11
                XAxis.MinorFont.Name = 'Tahoma'
                XAxis.MinorFont.Style = []
                XAxis.MinorUnit = 1.000000000000000000
                XAxis.MinorUnitSpacing = 0
                XAxis.TextTop.Font.Charset = DEFAULT_CHARSET
                XAxis.TextTop.Font.Color = clWindowText
                XAxis.TextTop.Font.Height = -11
                XAxis.TextTop.Font.Name = 'Tahoma'
                XAxis.TextTop.Font.Style = []
                XAxis.TextBottom.Font.Charset = DEFAULT_CHARSET
                XAxis.TextBottom.Font.Color = clWindowText
                XAxis.TextBottom.Font.Height = -11
                XAxis.TextBottom.Font.Name = 'Tahoma'
                XAxis.TextBottom.Font.Style = []
                XAxis.Visible = False
                YAxis.MajorFont.Charset = DEFAULT_CHARSET
                YAxis.MajorFont.Color = clWindowText
                YAxis.MajorFont.Height = -11
                YAxis.MajorFont.Name = 'Tahoma'
                YAxis.MajorFont.Style = []
                YAxis.MajorUnitSpacing = 0
                YAxis.MinorFont.Charset = DEFAULT_CHARSET
                YAxis.MinorFont.Color = clWindowText
                YAxis.MinorFont.Height = -11
                YAxis.MinorFont.Name = 'Tahoma'
                YAxis.MinorFont.Style = []
                YAxis.MinorUnitSpacing = 0
                YAxis.TextLeft.Angle = -90
                YAxis.TextLeft.Font.Charset = DEFAULT_CHARSET
                YAxis.TextLeft.Font.Color = clWindowText
                YAxis.TextLeft.Font.Height = -11
                YAxis.TextLeft.Font.Name = 'Tahoma'
                YAxis.TextLeft.Font.Style = []
                YAxis.TextRight.Angle = 90
                YAxis.TextRight.Font.Charset = DEFAULT_CHARSET
                YAxis.TextRight.Font.Color = clWindowText
                YAxis.TextRight.Font.Height = -11
                YAxis.TextRight.Font.Name = 'Tahoma'
                YAxis.TextRight.Font.Style = []
                YAxis.Visible = False
                SelectedIndex = 5
                BarValueTextFont.Charset = DEFAULT_CHARSET
                BarValueTextFont.Color = clWindowText
                BarValueTextFont.Height = -11
                BarValueTextFont.Name = 'Tahoma'
                BarValueTextFont.Style = []
                XAxisGroups = <>
                SerieType = stNormal
              end
              item
                AutoRange = arDisabled
                Pie.ValueFont.Charset = DEFAULT_CHARSET
                Pie.ValueFont.Color = clWindowText
                Pie.ValueFont.Height = -11
                Pie.ValueFont.Name = 'Tahoma'
                Pie.ValueFont.Style = []
                Pie.LegendFont.Charset = DEFAULT_CHARSET
                Pie.LegendFont.Color = clWindowText
                Pie.LegendFont.Height = -11
                Pie.LegendFont.Name = 'Tahoma'
                Pie.LegendFont.Style = []
                Annotations = <>
                Color = 6732418
                CrossHairYValue.BorderWidth = 0
                CrossHairYValue.Font.Charset = DEFAULT_CHARSET
                CrossHairYValue.Font.Color = clWindowText
                CrossHairYValue.Font.Height = -11
                CrossHairYValue.Font.Name = 'Tahoma'
                CrossHairYValue.Font.Style = []
                CrossHairYValue.GradientSteps = 0
                LineColor = 6732418
                LegendText = 'Serie 2'
                Marker.MarkerType = mCircle
                Marker.MarkerColor = 6732418
                Marker.SelectedColor = 6732418
                Marker.SelectedLineColor = clBlack
                Marker.SelectedSize = 15
                Maximum = 12.000000000000000000
                Name = 'Serie 2'
                ValueFont.Charset = DEFAULT_CHARSET
                ValueFont.Color = clWindowText
                ValueFont.Height = -11
                ValueFont.Name = 'Tahoma'
                ValueFont.Style = []
                ValueFormat = '%g'
                ValueWidth = 80
                XAxis.DateTimeFont.Charset = DEFAULT_CHARSET
                XAxis.DateTimeFont.Color = clWindowText
                XAxis.DateTimeFont.Height = -11
                XAxis.DateTimeFont.Name = 'Tahoma'
                XAxis.DateTimeFont.Style = []
                XAxis.MajorFont.Charset = DEFAULT_CHARSET
                XAxis.MajorFont.Color = clWindowText
                XAxis.MajorFont.Height = -11
                XAxis.MajorFont.Name = 'Tahoma'
                XAxis.MajorFont.Style = []
                XAxis.MajorUnit = 1.000000000000000000
                XAxis.MajorUnitSpacing = 0
                XAxis.MinorFont.Charset = DEFAULT_CHARSET
                XAxis.MinorFont.Color = clWindowText
                XAxis.MinorFont.Height = -11
                XAxis.MinorFont.Name = 'Tahoma'
                XAxis.MinorFont.Style = []
                XAxis.MinorUnit = 1.000000000000000000
                XAxis.MinorUnitSpacing = 0
                XAxis.TextTop.Font.Charset = DEFAULT_CHARSET
                XAxis.TextTop.Font.Color = clWindowText
                XAxis.TextTop.Font.Height = -11
                XAxis.TextTop.Font.Name = 'Tahoma'
                XAxis.TextTop.Font.Style = []
                XAxis.TextBottom.Font.Charset = DEFAULT_CHARSET
                XAxis.TextBottom.Font.Color = clWindowText
                XAxis.TextBottom.Font.Height = -11
                XAxis.TextBottom.Font.Name = 'Tahoma'
                XAxis.TextBottom.Font.Style = []
                XAxis.TickMarkColor = clRed
                XAxis.TickMarkSize = 6
                XAxis.TickMarkWidth = 2
                XAxis.Visible = False
                YAxis.MajorFont.Charset = DEFAULT_CHARSET
                YAxis.MajorFont.Color = clWindowText
                YAxis.MajorFont.Height = -11
                YAxis.MajorFont.Name = 'Tahoma'
                YAxis.MajorFont.Style = []
                YAxis.MajorUnit = 2.000000000000000000
                YAxis.MajorUnitSpacing = 0
                YAxis.MinorFont.Charset = DEFAULT_CHARSET
                YAxis.MinorFont.Color = clWindowText
                YAxis.MinorFont.Height = -11
                YAxis.MinorFont.Name = 'Tahoma'
                YAxis.MinorFont.Style = []
                YAxis.MinorUnitSpacing = 10
                YAxis.TextLeft.Angle = -90
                YAxis.TextLeft.Font.Charset = DEFAULT_CHARSET
                YAxis.TextLeft.Font.Color = clWindowText
                YAxis.TextLeft.Font.Height = -11
                YAxis.TextLeft.Font.Name = 'Tahoma'
                YAxis.TextLeft.Font.Style = []
                YAxis.TextRight.Angle = 90
                YAxis.TextRight.Font.Charset = DEFAULT_CHARSET
                YAxis.TextRight.Font.Color = clWindowText
                YAxis.TextRight.Font.Height = -11
                YAxis.TextRight.Font.Name = 'Tahoma'
                YAxis.TextRight.Font.Style = []
                YAxis.TickMarkColor = clBlue
                YAxis.Visible = False
                BarValueTextFont.Charset = DEFAULT_CHARSET
                BarValueTextFont.Color = clWindowText
                BarValueTextFont.Height = -11
                BarValueTextFont.Name = 'Tahoma'
                BarValueTextFont.Style = []
                XAxisGroups = <>
                SerieType = stNormal
              end>
            Title.Alignment = taCenter
            Title.Color = clGray
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = []
            Title.Position = tTop
            Title.Text = 'Darstellung'
            XAxis.Font.Charset = DEFAULT_CHARSET
            XAxis.Font.Color = clWindowText
            XAxis.Font.Height = -11
            XAxis.Font.Name = 'Tahoma'
            XAxis.Font.Style = []
            XAxis.Position = xNone
            XAxis.Text = 'X-axis'
            XGrid.MajorFont.Charset = DEFAULT_CHARSET
            XGrid.MajorFont.Color = clWindowText
            XGrid.MajorFont.Height = -11
            XGrid.MajorFont.Name = 'Tahoma'
            XGrid.MajorFont.Style = []
            XGrid.MinorFont.Charset = DEFAULT_CHARSET
            XGrid.MinorFont.Color = clWindowText
            XGrid.MinorFont.Height = -11
            XGrid.MinorFont.Name = 'Tahoma'
            XGrid.MinorFont.Style = []
            YAxis.Font.Charset = DEFAULT_CHARSET
            YAxis.Font.Color = clWindowText
            YAxis.Font.Height = -11
            YAxis.Font.Name = 'Tahoma'
            YAxis.Font.Style = []
            YAxis.Position = yNone
            YAxis.Size = 40
            YAxis.Text = 'Y-axis'
            YGrid.MinorDistance = 1.000000000000000000
            YGrid.MajorDistance = 2.000000000000000000
          end>
        TabOrder = 3
        Tracker.Font.Charset = DEFAULT_CHARSET
        Tracker.Font.Color = clWindowText
        Tracker.Font.Height = -11
        Tracker.Font.Name = 'Tahoma'
        Tracker.Font.Style = []
        Tracker.Title.Font.Charset = DEFAULT_CHARSET
        Tracker.Title.Font.Color = clWindowText
        Tracker.Title.Font.Height = -11
        Tracker.Title.Font.Name = 'Tahoma'
        Tracker.Title.Font.Style = []
        Tracker.Title.Text = 'TRACKER'
        Tracker.OpenValuePrefix = 'O:'
        Tracker.HighValuePrefix = 'H:'
        Tracker.LowValuePrefix = 'L:'
        Tracker.CloseValuePrefix = 'C:'
        Version = '4.2.1.6 APR, 2018'
        XAxisZoomSensitivity = 1.000000000000000000
        YAxisZoomSensitivity = 1.000000000000000000
        DoubleBuffered = True
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'Gelber Sack'
      ImageIndex = 8
      object Panel21: TPanel
        Left = 120
        Top = 12
        Width = 1401
        Height = 829
        Caption = 'Panel21'
        TabOrder = 0
        object SGCwSymbols: TStringGridSorted
          AlignWithMargins = True
          Left = 4
          Top = 271
          Width = 1393
          Height = 168
          Align = alTop
          DefaultColWidth = 80
          RowCount = 1
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goRowSelect]
          TabOrder = 0
          OnColumnMoved = SGCwSymbolsColumnMoved
          OnMouseDown = SGMouseDown
          ExplicitLeft = 365
          ExplicitTop = 255
          ExplicitWidth = 672
        end
        object SGCwUsers: TStringGridSorted
          AlignWithMargins = True
          Left = 4
          Top = 445
          Width = 1393
          Height = 168
          Align = alTop
          DefaultColWidth = 80
          RowCount = 1
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goRowSelect]
          TabOrder = 1
          OnMouseDown = SGMouseDown
          ExplicitLeft = 365
          ExplicitTop = 429
          ExplicitWidth = 684
        end
        object SGCwComments: TStringGridSorted
          AlignWithMargins = True
          Left = 4
          Top = 895
          Width = 1393
          Height = 213
          Align = alTop
          DefaultColWidth = 80
          RowCount = 1
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goRowSelect]
          TabOrder = 2
          OnMouseDown = SGMouseDown
          ExplicitLeft = 365
          ExplicitTop = 603
          ExplicitWidth = 691
        end
        object SGCacheCwSearch: TStringGridSorted
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 1393
          Height = 261
          Align = alTop
          ColCount = 1
          DefaultColWidth = 80
          FixedCols = 0
          RowCount = 1
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goRowSelect]
          TabOrder = 3
          Visible = False
          OnMouseDown = SGMouseDown
          ExplicitLeft = 365
          ExplicitTop = -12
          ExplicitWidth = 1017
        end
        object SGCwSymbolsGroups: TStringGridSorted
          AlignWithMargins = True
          Left = 4
          Top = 619
          Width = 1393
          Height = 270
          Align = alTop
          DefaultColWidth = 80
          RowCount = 1
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goRowSelect, goFixedColClick]
          TabOrder = 4
          OnDrawCell = SGCwSymbolsGroupsDrawCell
          OnMouseDown = SGMouseDown
          OnMouseUp = SGCwSymbolsGroupsMouseUp
          ExplicitLeft = 36
          ExplicitTop = 507
          ExplicitWidth = 484
        end
      end
    end
  end
  object AdvChartPanesEditorDialogGDIP1: TAdvChartPanesEditorDialogGDIP
    Left = 20
    Top = 56
  end
end
