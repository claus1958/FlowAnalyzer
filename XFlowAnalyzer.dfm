object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Flow Analyzer'
  ClientHeight = 1095
  ClientWidth = 1604
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 1062
    Width = 1604
    Height = 33
    Panels = <>
  end
  object PageControl1: TPanel
    Left = 77
    Top = 0
    Width = 1527
    Height = 1062
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
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
      object btnLadeDialog: TButton
        Left = 604
        Top = 671
        Width = 205
        Height = 26
        Caption = 'Lade Dialog anzeigen'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnLadeDialogClick
      end
      object pnlStartBack: TPanel
        Left = 0
        Top = 0
        Width = 1525
        Height = 1060
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -96
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        StyleElements = [seClient, seBorder]
        OnResize = pnlStartBackResize
        object lblUpdateRest: TLabel
          Left = 20
          Top = 16
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnDblClick = lblUpdateRestDblClick
        end
        object pnlStart: TPanel
          Left = 252
          Top = 96
          Width = 969
          Height = 637
          Align = alCustom
          Caption = 'FLOW ANALYZER'
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMedGray
          Font.Height = -96
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          object Label13: TLabel
            Left = 900
            Top = 616
            Width = 42
            Height = 13
            Caption = '1.0.0.20'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMedGray
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
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
      object CategoryPanelGroup1: TCategoryPanelGroup
        Left = 0
        Top = 0
        Width = 1525
        Height = 1060
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
            Width = 1521
            Height = 219
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 1521
            ExplicitHeight = 219
            inherited Panel1: TPanel
              Width = 1521
              Height = 20
              Align = alTop
              ExplicitWidth = 1521
              ExplicitHeight = 20
              inherited lblHeader: TLabel
                Top = 2
                ExplicitTop = 2
              end
              inherited lblTime: TLabel
                Top = 2
                Width = 4
                Height = 14
                ExplicitTop = 2
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
              inherited lblSelection: TLabel
                Top = 2
                Width = 4
                Height = 14
                ExplicitTop = 2
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
              inherited SpeedButton1: TSpeedButton
                Top = 1
                ExplicitTop = 1
              end
            end
            inherited Panel2: TPanel
              Left = 0
              Top = 20
              Width = 1521
              Height = 199
              Align = alClient
              ExplicitLeft = 0
              ExplicitTop = 20
              ExplicitWidth = 1521
              ExplicitHeight = 199
              inherited ScrollBar1: TScrollBar
                Left = 1504
                Height = 197
                ExplicitLeft = 1504
                ExplicitHeight = 197
              end
              inherited Panel3: TPanel
                Width = 1503
                Height = 197
                ExplicitWidth = 1503
                ExplicitHeight = 197
                inherited SG: TStringGridSorted
                  Width = 1501
                  Height = 165
                  ExplicitWidth = 1501
                  ExplicitHeight = 165
                end
                inherited SGSum: TStringGridSorted
                  Top = 166
                  Width = 1501
                  Font.Height = -12
                  ExplicitTop = 166
                  ExplicitWidth = 1501
                end
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
            Width = 1521
            Height = 174
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 1521
            ExplicitHeight = 174
            inherited Panel1: TPanel
              Width = 1521
              Height = 20
              Align = alTop
              ExplicitWidth = 1521
              ExplicitHeight = 20
              inherited lblHeader: TLabel
                Top = 2
                ExplicitTop = 2
              end
              inherited lblTime: TLabel
                Top = 2
                Width = 4
                Height = 14
                ExplicitTop = 2
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
              inherited lblSelection: TLabel
                Top = 2
                Width = 4
                Height = 14
                ExplicitTop = 2
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
              inherited SpeedButton1: TSpeedButton
                Top = 1
                ExplicitTop = 1
              end
            end
            inherited Panel2: TPanel
              Left = 0
              Top = 20
              Width = 1521
              Height = 154
              Align = alClient
              ExplicitLeft = 0
              ExplicitTop = 20
              ExplicitWidth = 1521
              ExplicitHeight = 154
              inherited ScrollBar1: TScrollBar
                Left = 1504
                Height = 152
                ExplicitLeft = 1504
                ExplicitHeight = 152
              end
              inherited Panel3: TPanel
                Width = 1503
                Height = 152
                ExplicitWidth = 1503
                ExplicitHeight = 152
                inherited SG: TStringGridSorted
                  Width = 1501
                  Height = 120
                  ExplicitWidth = 1501
                  ExplicitHeight = 120
                end
                inherited SGSum: TStringGridSorted
                  Top = 121
                  Width = 1501
                  Font.Height = -12
                  ExplicitTop = 121
                  ExplicitWidth = 1501
                end
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
            Width = 1521
            Height = 174
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 1521
            ExplicitHeight = 174
            inherited Panel1: TPanel
              Width = 1521
              Height = 20
              Align = alTop
              ExplicitWidth = 1521
              ExplicitHeight = 20
              inherited lblHeader: TLabel
                Top = 2
                ExplicitTop = 2
              end
              inherited lblTime: TLabel
                Top = 2
                Width = 4
                Height = 14
                ExplicitTop = 2
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
              inherited lblSelection: TLabel
                Top = 2
                Width = 4
                Height = 14
                ExplicitTop = 2
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
              inherited SpeedButton1: TSpeedButton
                Top = 1
                ExplicitTop = 1
              end
            end
            inherited Panel2: TPanel
              Left = 0
              Top = 20
              Width = 1521
              Height = 154
              Align = alClient
              ExplicitLeft = 0
              ExplicitTop = 20
              ExplicitWidth = 1521
              ExplicitHeight = 154
              inherited ScrollBar1: TScrollBar
                Left = 1504
                Height = 152
                ExplicitLeft = 1504
                ExplicitHeight = 152
              end
              inherited Panel3: TPanel
                Width = 1503
                Height = 152
                ExplicitWidth = 1503
                ExplicitHeight = 152
                inherited SG: TStringGridSorted
                  Width = 1501
                  Height = 120
                  ExplicitWidth = 1501
                  ExplicitHeight = 120
                end
                inherited SGSum: TStringGridSorted
                  Top = 121
                  Width = 1501
                  Font.Height = -12
                  ExplicitTop = 121
                  ExplicitWidth = 1501
                end
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
          OnClick = CategoryPanel1Click
          OnExpand = CategoryPanel1Expand
          inline DynGrid3: TDynGrid
            Left = 0
            Top = 0
            Width = 1521
            Height = 174
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 1521
            ExplicitHeight = 174
            inherited Panel1: TPanel
              Width = 1521
              Height = 20
              Align = alTop
              ExplicitWidth = 1521
              ExplicitHeight = 20
              inherited lblHeader: TLabel
                Top = 2
                ExplicitTop = 2
              end
              inherited lblTime: TLabel
                Top = 2
                Width = 4
                Height = 14
                ExplicitTop = 2
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
              inherited lblSelection: TLabel
                Top = 2
                Width = 4
                Height = 14
                ExplicitTop = 2
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
              inherited SpeedButton1: TSpeedButton
                Top = 1
                ExplicitTop = 1
              end
            end
            inherited Panel2: TPanel
              Left = 0
              Top = 20
              Width = 1521
              Height = 154
              Align = alClient
              ExplicitLeft = 0
              ExplicitTop = 20
              ExplicitWidth = 1521
              ExplicitHeight = 154
              inherited ScrollBar1: TScrollBar
                Left = 1504
                Height = 152
                ExplicitLeft = 1504
                ExplicitHeight = 152
              end
              inherited Panel3: TPanel
                Width = 1503
                Height = 152
                ExplicitWidth = 1503
                ExplicitHeight = 152
                inherited SG: TStringGridSorted
                  Width = 1501
                  Height = 120
                  ExplicitWidth = 1501
                  ExplicitHeight = 120
                end
                inherited SGSum: TStringGridSorted
                  Top = 121
                  Width = 1501
                  Font.Height = -12
                  ExplicitTop = 121
                  ExplicitWidth = 1501
                end
              end
            end
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 0
        Height = 1060
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
        Width = 1525
        Height = 1060
        Align = alClient
        TabOrder = 0
        OnResize = Panel6Resize
        object Splitter2: TSplitter
          Left = 501
          Top = 1
          Height = 1058
          ExplicitLeft = 322
          ExplicitHeight = 869
        end
        object Panel7: TPanel
          Left = 1
          Top = 1
          Width = 500
          Height = 1058
          Align = alLeft
          TabOrder = 0
          object Panel13: TPanel
            Left = 1
            Top = 1
            Width = 498
            Height = 1
            Align = alTop
            TabOrder = 0
            object btnGetSingleUserActions: TButton
              Left = 8
              Top = 17
              Width = 161
              Height = 21
              Caption = 'Get Users Actions'
              TabOrder = 0
              OnClick = btnGetSingleUserActionsClick
            end
            object edSingleUserActionsId: TEdit
              Left = 184
              Top = 17
              Width = 89
              Height = 22
              TabOrder = 1
              Text = '0'
              OnChange = edSingleUserActionsIdChange
            end
          end
          inline DynGrid10: TDynGrid
            Left = 1
            Top = 2
            Width = 498
            Height = 1055
            Align = alClient
            TabOrder = 1
            ExplicitLeft = 1
            ExplicitTop = 2
            ExplicitWidth = 498
            ExplicitHeight = 1055
            inherited Panel1: TPanel
              Width = 498
              Align = alTop
              ExplicitWidth = 498
              inherited lblTime: TLabel
                Width = 4
                Height = 14
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
              inherited lblSelection: TLabel
                Width = 4
                Height = 14
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
              inherited SpeedButton1: TSpeedButton
                OnClick = DynGrid10SpeedButton1Click
              end
            end
            inherited Panel2: TPanel
              Left = 0
              Top = 41
              Width = 498
              Height = 1014
              Align = alClient
              ExplicitLeft = 0
              ExplicitTop = 41
              ExplicitWidth = 498
              ExplicitHeight = 1014
              inherited ScrollBar1: TScrollBar
                Left = 481
                Height = 1012
                ExplicitLeft = 481
                ExplicitHeight = 1012
              end
              inherited Panel3: TPanel
                Width = 480
                Height = 1012
                ExplicitWidth = 480
                ExplicitHeight = 1012
                inherited SG: TStringGridSorted
                  Width = 478
                  Height = 980
                  ExplicitWidth = 478
                  ExplicitHeight = 980
                end
                inherited SGSum: TStringGridSorted
                  Top = 981
                  Width = 478
                  Font.Height = -12
                  ExplicitTop = 981
                  ExplicitWidth = 478
                end
              end
            end
          end
        end
        object Panel8: TPanel
          Left = 504
          Top = 1
          Width = 1020
          Height = 1058
          Align = alClient
          TabOrder = 1
          object Splitter3: TSplitter
            Left = 1
            Top = 201
            Width = 1018
            Height = 8
            Cursor = crVSplit
            Align = alTop
            ExplicitTop = 83
            ExplicitWidth = 1268
          end
          inline DynGrid4: TDynGrid
            Left = 1
            Top = 209
            Width = 1018
            Height = 848
            Align = alClient
            TabOrder = 0
            ExplicitLeft = 1
            ExplicitTop = 209
            ExplicitWidth = 1018
            ExplicitHeight = 848
            inherited Panel1: TPanel
              Width = 1018
              Align = alTop
              ExplicitWidth = 1018
              inherited lblTime: TLabel
                Width = 4
                Height = 14
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
              inherited lblSelection: TLabel
                Width = 4
                Height = 14
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
            end
            inherited Panel2: TPanel
              Left = 0
              Top = 41
              Width = 1018
              Height = 807
              Align = alClient
              ExplicitLeft = 0
              ExplicitTop = 41
              ExplicitWidth = 1018
              ExplicitHeight = 807
              inherited ScrollBar1: TScrollBar
                Left = 1001
                Height = 805
                ExplicitLeft = 1001
                ExplicitHeight = 805
              end
              inherited Panel3: TPanel
                Width = 1000
                Height = 805
                ExplicitWidth = 1000
                ExplicitHeight = 805
                inherited SG: TStringGridSorted
                  Width = 998
                  Height = 773
                  ExplicitWidth = 998
                  ExplicitHeight = 773
                end
                inherited SGSum: TStringGridSorted
                  Top = 774
                  Width = 998
                  Font.Height = -12
                  ExplicitTop = 774
                  ExplicitWidth = 998
                end
              end
            end
          end
          object Panel9: TPanel
            Left = 1
            Top = 1
            Width = 1018
            Height = 200
            Align = alTop
            TabOrder = 1
            object lbUserInfo: TListBox
              Left = 485
              Top = 1
              Width = 532
              Height = 198
              Align = alClient
              Color = 5263440
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clSilver
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = []
              ItemHeight = 18
              ParentFont = False
              TabOrder = 0
              TabWidth = 66
              StyleElements = [seFont, seBorder]
            end
            object Panel14: TPanel
              Left = 1
              Top = 1
              Width = 484
              Height = 198
              Align = alLeft
              Color = clSilver
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentBackground = False
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 1
              StyleElements = [seFont, seBorder]
              object lblUserInfo0: TLabel
                Left = 8
                Top = 12
                Width = 7
                Height = 23
                Caption = '-'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -19
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                StyleElements = [seClient, seBorder]
              end
              object lblUserInfo1: TLabel
                Left = 8
                Top = 41
                Width = 6
                Height = 19
                Caption = '-'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                StyleElements = [seClient, seBorder]
              end
              object lblUserInfo2: TLabel
                Left = 8
                Top = 66
                Width = 6
                Height = 19
                Caption = '-'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                StyleElements = [seClient, seBorder]
              end
              object lblUserInfo3: TLabel
                Left = 8
                Top = 91
                Width = 6
                Height = 19
                Caption = '-'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                StyleElements = [seClient, seBorder]
              end
              object lblUserInfo4: TLabel
                Left = 8
                Top = 116
                Width = 6
                Height = 19
                Caption = '-'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                StyleElements = [seClient, seBorder]
              end
              object lblUserInfo5: TLabel
                Left = 8
                Top = 141
                Width = 6
                Height = 19
                Caption = '-'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                StyleElements = [seClient, seBorder]
              end
              object lblUserInfo6: TLabel
                Left = 9
                Top = 166
                Width = 5
                Height = 19
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                StyleElements = [seClient, seBorder]
              end
              object lblUserInfo7: TLabel
                Left = 364
                Top = 15
                Width = 6
                Height = 19
                Caption = '-'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                StyleElements = [seClient, seBorder]
              end
            end
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Inspector'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      object Panel26: TPanel
        Left = 0
        Top = 0
        Width = 1525
        Height = 1060
        Align = alClient
        TabOrder = 0
        OnResize = Panel26Resize
        object pnlInspectorBedienung: TPanel
          Left = 1
          Top = 1
          Width = 524
          Height = 1058
          Align = alLeft
          TabOrder = 0
          object Panel36: TPanel
            Left = 8
            Top = 30
            Width = 513
            Height = 851
            Color = clGray
            ParentBackground = False
            TabOrder = 0
            object lblFilterResult: TLabel
              Left = 10
              Top = 426
              Width = 4
              Height = 14
            end
            object btnDoubleRemoveCw: TButton
              Left = 419
              Top = 814
              Width = 82
              Height = 25
              Caption = 'DblRemove'
              TabOrder = 0
              Visible = False
              OnClick = btnDoubleRemoveCwClick
            end
            object btnSelectClearCw: TButton
              Left = 419
              Top = 783
              Width = 82
              Height = 25
              Caption = 'Clear all'
              TabOrder = 1
              Visible = False
              OnClick = btnSelectClearCwClick
            end
            object pnlFilter: TPanel
              Left = 6
              Top = 8
              Width = 505
              Height = 337
              Color = clGray
              ParentBackground = False
              TabOrder = 2
              object Label5: TLabel
                Left = 15
                Top = 6
                Width = 57
                Height = 19
                Caption = 'Filtering'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label6: TLabel
                Left = 15
                Top = 30
                Width = 34
                Height = 14
                Caption = 'on/off'
              end
              object Label7: TLabel
                Left = 60
                Top = 30
                Width = 27
                Height = 14
                Caption = 'topic'
              end
              object Label8: TLabel
                Left = 176
                Top = 30
                Width = 52
                Height = 14
                Caption = 'operation'
              end
              object Label9: TLabel
                Left = 244
                Top = 30
                Width = 48
                Height = 14
                Caption = 'selection'
              end
              object Label10: TLabel
                Left = 491
                Top = 30
                Width = 14
                Height = 14
                Caption = 'list'
              end
            end
            object pnlGrouping: TPanel
              Left = 5
              Top = 387
              Width = 505
              Height = 154
              Color = clGray
              ParentBackground = False
              TabOrder = 3
              object Label3: TLabel
                Left = 16
                Top = 6
                Width = 66
                Height = 19
                Caption = 'Grouping'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                OnClick = Label3Click
              end
              object Label2: TLabel
                Left = 19
                Top = 30
                Width = 34
                Height = 14
                Caption = 'on/off'
              end
              object Label12: TLabel
                Left = 64
                Top = 30
                Width = 27
                Height = 14
                Caption = 'topic'
              end
            end
            object btnDoFilter: TButton
              Left = 4
              Top = 544
              Width = 506
              Height = 72
              Caption = 'Filter and Group'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              OnClick = btnDoFilterClick
            end
            object Panel22: TPanel
              Left = 4
              Top = 618
              Width = 501
              Height = 151
              TabOrder = 5
              object Label11: TLabel
                Left = 16
                Top = 16
                Width = 59
                Height = 19
                Caption = 'Samples'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object btnSample1: TButton
                Left = 10
                Top = 46
                Width = 140
                Height = 25
                Caption = 'Balance only'
                TabOrder = 0
                OnClick = btnSampleClick
              end
              object btnSample2: TButton
                Left = 10
                Top = 108
                Width = 140
                Height = 25
                Caption = 'Winner>1000'
                TabOrder = 1
                OnClick = btnSampleClick
              end
              object btnSample3: TButton
                Left = 10
                Top = 77
                Width = 140
                Height = 25
                Caption = 'Gold 2018 Loosers'
                TabOrder = 2
                OnClick = btnSampleClick
              end
              object btnSample4: TButton
                Left = 156
                Top = 46
                Width = 140
                Height = 25
                Caption = 'Gold Open Winners'
                TabOrder = 3
                OnClick = btnSampleClick
              end
              object btnSample5: TButton
                Left = 156
                Top = 77
                Width = 140
                Height = 25
                Caption = 'Closed Actions 08/19'
                TabOrder = 4
                OnClick = btnSampleClick
              end
              object btnSample6: TButton
                Left = 156
                Top = 108
                Width = 140
                Height = 25
                Caption = 'Open Actions'
                TabOrder = 5
                OnClick = btnSampleClick
              end
              object btnSample7: TButton
                Left = 302
                Top = 46
                Width = 140
                Height = 25
                Caption = 'Evaluation'
                TabOrder = 6
                OnClick = btnSampleClick
              end
            end
            object Panel23: TPanel
              Left = 5
              Top = 348
              Width = 505
              Height = 37
              TabOrder = 6
              object chkFilterWithOpenActions: TCheckBox
                Left = 9
                Top = 11
                Width = 284
                Height = 17
                Caption = 'perform Evaluation of OpenActions'
                TabOrder = 0
                OnClick = chkFilterWithOpenActionsClick
              end
              object btnShowEvaluation: TButton
                Left = 376
                Top = 8
                Width = 113
                Height = 25
                Caption = 'Show Evaluation'
                TabOrder = 1
                Visible = False
                OnClick = btnShowEvaluationClick
              end
            end
            object Panel24: TPanel
              Left = 4
              Top = 772
              Width = 501
              Height = 81
              TabOrder = 7
              object Label14: TLabel
                Left = 160
                Top = 20
                Width = 60
                Height = 14
                Caption = 'Load Filter:'
              end
              object Button5: TButton
                Left = 16
                Top = 15
                Width = 133
                Height = 25
                Caption = 'Save as Filter'
                TabOrder = 0
                OnClick = Button5Click
              end
              object cbLoadFilters: TComboBox
                Left = 232
                Top = 16
                Width = 221
                Height = 22
                TabOrder = 1
                OnClick = cbLoadFiltersClick
                OnKeyDown = cbLoadFiltersKeyDown
              end
              object Button12: TButton
                Left = 464
                Top = 15
                Width = 33
                Height = 25
                Caption = 'Del'
                TabOrder = 2
                OnClick = Button12Click
              end
            end
          end
          object pnlInspectorWait: TPanel
            Left = 41
            Top = 304
            Width = 453
            Height = 205
            Caption = 'Computing ...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -64
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Visible = False
          end
        end
        object Panel4: TPanel
          Left = 525
          Top = 1
          Width = 999
          Height = 1058
          Align = alClient
          TabOrder = 1
          object Splitter1: TSplitter
            Left = 1
            Top = 415
            Width = 997
            Height = 10
            Cursor = crVSplit
            Align = alTop
            ExplicitTop = 455
            ExplicitWidth = 521
          end
          object Panel5: TPanel
            Left = 1
            Top = 1
            Width = 997
            Height = 1
            Align = alTop
            TabOrder = 0
            object lblFilteredDataInfo: TLabel
              Left = 1
              Top = 1
              Width = 995
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
            Top = 2
            Width = 997
            Height = 413
            Align = alTop
            TabOrder = 1
            ExplicitLeft = 1
            ExplicitTop = 2
            ExplicitWidth = 997
            ExplicitHeight = 413
            inherited Panel1: TPanel
              Width = 997
              Align = alTop
              ExplicitWidth = 997
              inherited lblTime: TLabel
                Width = 4
                Height = 14
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
              inherited lblSelection: TLabel
                Width = 4
                Height = 14
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
            end
            inherited Panel2: TPanel
              Left = 0
              Top = 41
              Width = 997
              Height = 372
              Align = alClient
              ExplicitLeft = 0
              ExplicitTop = 41
              ExplicitWidth = 997
              ExplicitHeight = 372
              inherited ScrollBar1: TScrollBar
                Left = 980
                Height = 370
                ExplicitLeft = 980
                ExplicitHeight = 370
              end
              inherited Panel3: TPanel
                Width = 979
                Height = 370
                ExplicitWidth = 979
                ExplicitHeight = 370
                inherited SG: TStringGridSorted
                  Width = 977
                  Height = 338
                  ExplicitWidth = 977
                  ExplicitHeight = 338
                end
                inherited SGSum: TStringGridSorted
                  Top = 339
                  Width = 977
                  Font.Height = -12
                  ExplicitTop = 339
                  ExplicitWidth = 977
                end
              end
            end
          end
          inline DynGrid9: TDynGrid
            Left = 1
            Top = 425
            Width = 997
            Height = 632
            Align = alClient
            TabOrder = 2
            ExplicitLeft = 1
            ExplicitTop = 425
            ExplicitWidth = 997
            ExplicitHeight = 632
            inherited Panel1: TPanel
              Width = 997
              Align = alTop
              ExplicitWidth = 997
              inherited lblTime: TLabel
                Width = 5
                Height = 19
                Font.Height = -16
                ParentFont = False
                ExplicitWidth = 5
                ExplicitHeight = 19
              end
              inherited lblSelection: TLabel
                Width = 4
                Height = 14
                ExplicitWidth = 4
                ExplicitHeight = 14
              end
              inherited SpeedButton1: TSpeedButton
                OnClick = DynGrid9SpeedButton1Click
              end
            end
            inherited Panel2: TPanel
              Left = 0
              Top = 41
              Width = 997
              Height = 591
              Align = alClient
              ExplicitLeft = 0
              ExplicitTop = 41
              ExplicitWidth = 997
              ExplicitHeight = 591
              inherited ScrollBar1: TScrollBar
                Left = 980
                Height = 589
                ExplicitLeft = 980
                ExplicitHeight = 589
              end
              inherited Panel3: TPanel
                Width = 979
                Height = 589
                ExplicitWidth = 979
                ExplicitHeight = 589
                inherited SG: TStringGridSorted
                  Width = 977
                  Height = 557
                  ExplicitWidth = 977
                  ExplicitHeight = 557
                end
                inherited SGSum: TStringGridSorted
                  Top = 558
                  Width = 977
                  Font.Height = -12
                  ExplicitTop = 558
                  ExplicitWidth = 977
                end
              end
            end
            inherited PopupMenu1: TPopupMenu
              inherited Selectcolumns1: TMenuItem
                OnClick = DynGrid9Selectcolumns1Click
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
            Width = 105
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
          object lbDebug2: TListBox
            Left = 8
            Top = 296
            Width = 562
            Height = 169
            ItemHeight = 14
            TabOrder = 16
            OnDblClick = lbDebug2DblClick
          end
          object chkGetBinAppend: TCheckBox
            Left = 448
            Top = 120
            Width = 105
            Height = 17
            Caption = 'chkGetBinAppend'
            TabOrder = 17
          end
          object Button2: TButton
            Left = 216
            Top = 264
            Width = 105
            Height = 21
            Caption = 'Sorttests'
            TabOrder = 18
            OnClick = Button2Click
          end
          object cbStyles: TComboBox
            Left = 434
            Top = 268
            Width = 119
            Height = 22
            TabOrder = 19
            OnChange = cbStylesChange
          end
          object lbCSVError: TListBox
            Left = 8
            Top = 471
            Width = 561
            Height = 177
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 14
            ParentFont = False
            TabOrder = 20
            OnDblClick = lbCSVErrorDblClick
          end
          object Button7: TButton
            Left = 8
            Top = 656
            Width = 117
            Height = 21
            Caption = 'Lade Actionfile OTR'
            TabOrder = 21
            OnClick = Button7Click
          end
          object edStoredActions: TEdit
            Left = 136
            Top = 656
            Width = 381
            Height = 22
            TabOrder = 22
            Text = 'ActiveTrades A_191119'
          end
        end
        object Button3: TButton
          Left = 748
          Top = 60
          Width = 249
          Height = 33
          Caption = 'Button3'
          TabOrder = 1
          OnClick = Button3Click
        end
        object SG: TStringGridSorted
          Left = 752
          Top = 108
          Width = 245
          Height = 169
          TabOrder = 2
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Open Actions'
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
        Width = 1525
        Height = 1060
        Align = alClient
        Caption = 'Panel12'
        TabOrder = 0
        object Splitter4: TSplitter
          Left = 1
          Top = 301
          Width = 1523
          Height = 6
          Cursor = crVSplit
          Align = alTop
          ExplicitTop = 451
        end
        object Splitter5: TSplitter
          Left = 1
          Top = 604
          Width = 1523
          Height = 6
          Cursor = crVSplit
          Align = alTop
        end
        inline DynGrid11: TDynGrid
          Left = 1
          Top = 1
          Width = 1523
          Height = 300
          Align = alTop
          TabOrder = 0
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 1523
          ExplicitHeight = 300
          inherited Panel1: TPanel
            Width = 1523
            Align = alTop
            ExplicitWidth = 1523
            inherited lblTime: TLabel
              Width = 4
              Height = 14
              ExplicitWidth = 4
              ExplicitHeight = 14
            end
            inherited lblSelection: TLabel
              Width = 4
              Height = 14
              ExplicitWidth = 4
              ExplicitHeight = 14
            end
          end
          inherited Panel2: TPanel
            Left = 0
            Top = 41
            Width = 1523
            Height = 259
            Align = alClient
            ExplicitLeft = 0
            ExplicitTop = 41
            ExplicitWidth = 1523
            ExplicitHeight = 259
            inherited ScrollBar1: TScrollBar
              Left = 1506
              Height = 257
              ExplicitLeft = 1506
              ExplicitHeight = 257
            end
            inherited Panel3: TPanel
              Width = 1505
              Height = 257
              ExplicitWidth = 1505
              ExplicitHeight = 257
              inherited SG: TStringGridSorted
                Width = 1503
                Height = 225
                ExplicitWidth = 1503
                ExplicitHeight = 225
              end
              inherited SGSum: TStringGridSorted
                Top = 226
                Width = 1503
                Font.Height = -12
                ExplicitTop = 226
                ExplicitWidth = 1503
              end
            end
          end
        end
        inline DynGrid12: TDynGrid
          Left = 1
          Top = 307
          Width = 1523
          Height = 297
          Align = alTop
          TabOrder = 1
          ExplicitLeft = 1
          ExplicitTop = 307
          ExplicitWidth = 1523
          ExplicitHeight = 297
          inherited Panel1: TPanel
            Width = 1523
            Align = alTop
            ExplicitWidth = 1523
            inherited lblTime: TLabel
              Width = 4
              Height = 14
              ExplicitWidth = 4
              ExplicitHeight = 14
            end
            inherited lblSelection: TLabel
              Width = 4
              Height = 14
              ExplicitWidth = 4
              ExplicitHeight = 14
            end
          end
          inherited Panel2: TPanel
            Left = 0
            Top = 41
            Width = 1523
            Height = 256
            Align = alClient
            ExplicitLeft = 0
            ExplicitTop = 41
            ExplicitWidth = 1523
            ExplicitHeight = 256
            inherited ScrollBar1: TScrollBar
              Left = 1506
              Height = 254
              ExplicitLeft = 1506
              ExplicitHeight = 254
            end
            inherited Panel3: TPanel
              Width = 1505
              Height = 254
              ExplicitWidth = 1505
              ExplicitHeight = 254
              inherited SG: TStringGridSorted
                Width = 1503
                Height = 222
                ExplicitWidth = 1503
                ExplicitHeight = 222
              end
              inherited SGSum: TStringGridSorted
                Top = 223
                Width = 1503
                Font.Height = -12
                ExplicitTop = 223
                ExplicitWidth = 1503
              end
            end
          end
        end
        inline DynGrid13: TDynGrid
          Left = 1
          Top = 610
          Width = 1523
          Height = 449
          Align = alClient
          TabOrder = 2
          ExplicitLeft = 1
          ExplicitTop = 610
          ExplicitWidth = 1523
          ExplicitHeight = 449
          inherited Panel1: TPanel
            Width = 1523
            Align = alTop
            ExplicitWidth = 1523
            inherited lblTime: TLabel
              Width = 4
              Height = 14
              ExplicitWidth = 4
              ExplicitHeight = 14
            end
            inherited lblSelection: TLabel
              Width = 4
              Height = 14
              ExplicitWidth = 4
              ExplicitHeight = 14
            end
          end
          inherited Panel2: TPanel
            Left = 0
            Top = 41
            Width = 1523
            Height = 408
            Align = alClient
            ExplicitLeft = 0
            ExplicitTop = 41
            ExplicitWidth = 1523
            ExplicitHeight = 408
            inherited ScrollBar1: TScrollBar
              Left = 1506
              Height = 406
              ExplicitLeft = 1506
              ExplicitHeight = 406
            end
            inherited Panel3: TPanel
              Width = 1505
              Height = 406
              ExplicitWidth = 1505
              ExplicitHeight = 406
              inherited SG: TStringGridSorted
                Width = 1503
                Height = 374
                ExplicitWidth = 1503
                ExplicitHeight = 374
              end
              inherited SGSum: TStringGridSorted
                Top = 375
                Width = 1503
                Font.Height = -12
                ExplicitTop = 375
                ExplicitWidth = 1503
              end
            end
          end
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
        Height = 1060
        Align = alLeft
        TabOrder = 0
        object Label4: TLabel
          Left = 44
          Top = 12
          Width = 86
          Height = 19
          Caption = 'Use actions:'
        end
        object btnGroupSymbolsFilteredActions: TButton
          Left = 40
          Top = 72
          Width = 165
          Height = 25
          Caption = 'Actions from '#39'Filtering'#39
          TabOrder = 0
          OnClick = btnSymbolGroupsClick
        end
        object lbSymbolsGroupsInfo: TListBox
          Left = 0
          Top = 112
          Width = 260
          Height = 301
          ItemHeight = 19
          TabOrder = 1
          TabWidth = 60
        end
        object pnlPieButtons: TPanel
          Left = 10
          Top = 419
          Width = 245
          Height = 149
          TabOrder = 2
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
        Width = 1264
        Height = 1060
        Align = alClient
        TabOrder = 1
        object Panel17: TPanel
          Left = 1
          Top = 1
          Width = 1262
          Height = 33
          Align = alTop
          TabOrder = 0
        end
        object Panel18: TPanel
          Left = 1
          Top = 34
          Width = 1262
          Height = 1025
          Align = alClient
          Caption = 'Panel18'
          TabOrder = 1
          object CategoryPanelGroup3: TCategoryPanelGroup
            Left = 1
            Top = 1
            Width = 1260
            Height = 1023
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
              inline DynGrid8: TDynGrid
                Left = 0
                Top = 0
                Width = 1256
                Height = 274
                Align = alClient
                TabOrder = 0
                ExplicitWidth = 1256
                ExplicitHeight = 274
                inherited Panel1: TPanel
                  Width = 1256
                  Height = 5
                  Align = alTop
                  ExplicitWidth = 1256
                  ExplicitHeight = 5
                  inherited lblTime: TLabel
                    Width = 5
                    Height = 19
                    ExplicitWidth = 5
                    ExplicitHeight = 19
                  end
                  inherited lblSelection: TLabel
                    Width = 5
                    Height = 19
                    ExplicitWidth = 5
                    ExplicitHeight = 19
                  end
                end
                inherited Panel2: TPanel
                  Left = 0
                  Top = 5
                  Width = 1256
                  Height = 269
                  Align = alClient
                  ExplicitLeft = 0
                  ExplicitTop = 5
                  ExplicitWidth = 1256
                  ExplicitHeight = 269
                  inherited ScrollBar1: TScrollBar
                    Left = 1239
                    Height = 267
                    ExplicitLeft = 1239
                    ExplicitHeight = 267
                  end
                  inherited Panel3: TPanel
                    Width = 1238
                    Height = 267
                    ExplicitWidth = 1238
                    ExplicitHeight = 267
                    inherited SG: TStringGridSorted
                      Width = 1236
                      Height = 235
                      ExplicitWidth = 1236
                      ExplicitHeight = 235
                    end
                    inherited SGSum: TStringGridSorted
                      Top = 236
                      Width = 1236
                      Font.Height = -16
                      ExplicitTop = 236
                      ExplicitWidth = 1236
                    end
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
              object Panel20: TPanel
                Left = 0
                Top = 0
                Width = 1256
                Height = 539
                Align = alClient
                Caption = 'Panel20'
                TabOrder = 0
              end
            end
          end
        end
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'Reload Data'
      ImageIndex = 7
      TabVisible = False
      object Button9: TButton
        Left = 36
        Top = 76
        Width = 125
        Height = 29
        Caption = 'Button9'
        TabOrder = 0
        Visible = False
        OnClick = Button9Click
      end
      object Button8: TButton
        Left = 452
        Top = 320
        Width = 409
        Height = 157
        Caption = 'Clear Cache and Load all Data'
        TabOrder = 1
        OnClick = Button8Click
      end
      object CheckBox2: TCheckBox
        Left = 40
        Top = 116
        Width = 121
        Height = 17
        Caption = 'Auto-Update'
        TabOrder = 2
        OnClick = CheckBox2Click
      end
      object lbDummy: TListBox
        Left = 36
        Top = 156
        Width = 377
        Height = 605
        ItemHeight = 19
        TabOrder = 3
      end
    end
    object TabSheet11: TTabSheet
      Caption = 'Report'
      ImageIndex = 10
      TabVisible = False
      object Panel25: TPanel
        Left = 0
        Top = 0
        Width = 1525
        Height = 1060
        Align = alClient
        Caption = 'Panel25'
        TabOrder = 0
        object ScrollBox1: TScrollBox
          Left = 1
          Top = 1
          Width = 1523
          Height = 1058
          Align = alClient
          TabOrder = 0
          inline ReportInfo1: TReportInfo
            Left = 13
            Top = 64
            Width = 229
            Height = 209
            Color = 15448201
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentBackground = False
            ParentColor = False
            ParentFont = False
            TabOrder = 0
            ExplicitLeft = 13
            ExplicitTop = 64
          end
          inline ReportInfo2: TReportInfo
            Left = 13
            Top = 276
            Width = 229
            Height = 209
            Color = 15448201
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentBackground = False
            ParentColor = False
            ParentFont = False
            TabOrder = 1
            ExplicitLeft = 13
            ExplicitTop = 276
          end
          inline ReportInfo3: TReportInfo
            Left = 13
            Top = 488
            Width = 229
            Height = 209
            Color = 15448201
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentBackground = False
            ParentColor = False
            ParentFont = False
            TabOrder = 2
            ExplicitLeft = 13
            ExplicitTop = 488
          end
          inline ReportInfo4: TReportInfo
            Left = 13
            Top = 700
            Width = 229
            Height = 209
            Color = 15448201
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentBackground = False
            ParentColor = False
            ParentFont = False
            TabOrder = 3
            ExplicitLeft = 13
            ExplicitTop = 700
          end
          inline ReportInfo5: TReportInfo
            Left = 13
            Top = 912
            Width = 229
            Height = 209
            Color = 15448201
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentBackground = False
            ParentColor = False
            ParentFont = False
            TabOrder = 4
            ExplicitLeft = 13
            ExplicitTop = 912
          end
          inline ReportInfoA: TReportInfo
            Left = 248
            Top = 21
            Width = 325
            Height = 37
            Color = 15448201
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentBackground = False
            ParentColor = False
            ParentFont = False
            TabOrder = 5
            ExplicitLeft = 248
            ExplicitTop = 21
            ExplicitWidth = 325
            ExplicitHeight = 37
            inherited Label1: TLabel
              Width = 29
              Caption = 'LCG'
              ExplicitWidth = 29
            end
          end
          inline ReportInfoB: TReportInfo
            Left = 579
            Top = 21
            Width = 325
            Height = 37
            Color = 15448201
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentBackground = False
            ParentColor = False
            ParentFont = False
            TabOrder = 6
            ExplicitLeft = 579
            ExplicitTop = 21
            ExplicitWidth = 325
            ExplicitHeight = 37
            inherited Label1: TLabel
              Width = 96
              Caption = 'Active Trades'
              ExplicitWidth = 96
            end
          end
          inline ReportInfoC: TReportInfo
            Left = 910
            Top = 21
            Width = 325
            Height = 37
            Color = 15448201
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentBackground = False
            ParentColor = False
            ParentFont = False
            TabOrder = 7
            ExplicitLeft = 910
            ExplicitTop = 21
            ExplicitWidth = 325
            ExplicitHeight = 37
            inherited Label1: TLabel
              Width = 53
              Caption = 'Gesamt'
              ExplicitWidth = 53
            end
          end
          inline ReportInfo6: TReportInfo
            Left = 13
            Top = 21
            Width = 229
            Height = 37
            Color = 15448201
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentBackground = False
            ParentColor = False
            ParentFont = False
            TabOrder = 8
            ExplicitLeft = 13
            ExplicitTop = 21
            ExplicitHeight = 37
            inherited Label1: TLabel
              Width = 5
              Caption = ''
              ExplicitWidth = 5
            end
          end
          inline Frame114: TFrame11
            Left = 248
            Top = 276
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 9
            ExplicitLeft = 248
            ExplicitTop = 276
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          inline Frame115: TFrame11
            Left = 579
            Top = 276
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 10
            ExplicitLeft = 579
            ExplicitTop = 276
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          inline Frame116: TFrame11
            Left = 910
            Top = 276
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 11
            ExplicitLeft = 910
            ExplicitTop = 276
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          inline Frame117: TFrame11
            Left = 248
            Top = 488
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 12
            ExplicitLeft = 248
            ExplicitTop = 488
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          inline Frame118: TFrame11
            Left = 579
            Top = 488
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 13
            ExplicitLeft = 579
            ExplicitTop = 488
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          inline Frame119: TFrame11
            Left = 910
            Top = 488
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 14
            ExplicitLeft = 910
            ExplicitTop = 488
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          inline Frame120: TFrame11
            Left = 248
            Top = 700
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 15
            ExplicitLeft = 248
            ExplicitTop = 700
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          inline Frame121: TFrame11
            Left = 579
            Top = 700
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 16
            ExplicitLeft = 579
            ExplicitTop = 700
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          inline Frame122: TFrame11
            Left = 910
            Top = 700
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 17
            ExplicitLeft = 910
            ExplicitTop = 700
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          inline Frame123: TFrame11
            Left = 248
            Top = 912
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 18
            ExplicitLeft = 248
            ExplicitTop = 912
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          inline Frame124: TFrame11
            Left = 579
            Top = 912
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 19
            ExplicitLeft = 579
            ExplicitTop = 912
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          inline Frame125: TFrame11
            Left = 910
            Top = 912
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 20
            ExplicitLeft = 910
            ExplicitTop = 912
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          inline Frame111: TFrame11
            Left = 248
            Top = 64
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 21
            ExplicitLeft = 248
            ExplicitTop = 64
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          inline Frame112: TFrame11
            Left = 579
            Top = 64
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 22
            ExplicitLeft = 579
            ExplicitTop = 64
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          inline Frame113: TFrame11
            Left = 910
            Top = 64
            Width = 328
            Height = 209
            Color = clSkyBlue
            ParentBackground = False
            ParentColor = False
            TabOrder = 23
            ExplicitLeft = 910
            ExplicitTop = 64
            inherited Label2: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label4: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label6: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label8: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label10: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label12: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label14: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
            inherited Label16: TLabel
              Width = 8
              Height = 19
              ExplicitWidth = 8
              ExplicitHeight = 19
            end
          end
          object btnReport: TButton
            Left = 25
            Top = 33
            Width = 157
            Height = 21
            Caption = 'Perform Report'
            TabOrder = 24
            OnClick = btnReportClick
          end
          object btnReportStop: TButton
            Left = 184
            Top = 33
            Width = 53
            Height = 21
            Caption = 'STOP'
            TabOrder = 25
            Visible = False
            OnClick = btnReportStopClick
          end
        end
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
        end
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'Data Loading'
      ImageIndex = 9
      object Panel10: TPanel
        AlignWithMargins = True
        Left = 216
        Top = 44
        Width = 1181
        Height = 729
        TabOrder = 0
        object Label1: TLabel
          Left = 32
          Top = 48
          Width = 206
          Height = 19
          Caption = 'Load actual Data from Server'
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
          Height = 370
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
          Height = 370
          ItemHeight = 19
          TabOrder = 1
        end
        object btnClbBrokersSelectAll: TButton
          Left = 33
          Top = 456
          Width = 105
          Height = 25
          Caption = 'select all'
          TabOrder = 2
          OnClick = btnClbBrokersSelectAllClick
        end
        object btnClbBrokersDeSelectAll: TButton
          Left = 140
          Top = 456
          Width = 101
          Height = 25
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
          Left = 312
          Top = 668
          Width = 109
          Height = 22
          Caption = 'Load Cachefile'
          TabOrder = 6
          Visible = False
          OnClick = btnLoadCacheFileCwClick
        end
        object Button4: TButton
          Left = 36
          Top = 680
          Width = 117
          Height = 21
          Caption = 'Restart HTTP Thread'
          TabOrder = 7
          Visible = False
          OnClick = Button4Click
        end
        object Button6: TButton
          Left = 152
          Top = 680
          Width = 53
          Height = 21
          Caption = 'Status..'
          TabOrder = 8
          Visible = False
          OnClick = Button6Click
        end
        object CheckBox1: TCheckBox
          Left = 40
          Top = 704
          Width = 113
          Height = 13
          Caption = 'Sortmethode2'
          TabOrder = 9
          Visible = False
          OnClick = CheckBox1Click
        end
        object Panel11: TPanel
          Left = 312
          Top = 488
          Width = 225
          Height = 161
          TabOrder = 10
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
        object btnUpdateData: TButton
          Left = 33
          Top = 516
          Width = 209
          Height = 25
          Caption = 'Update Data'
          TabOrder = 11
          OnClick = btnUpdateDataClick
        end
        object btnDoUsersAndSymbolsPlus: TButton
          Left = 36
          Top = 572
          Width = 205
          Height = 25
          Caption = 'Additional computations'
          TabOrder = 12
          Visible = False
          OnClick = btnDoUsersAndSymbolsPlusClick
        end
        object btnSymbolGroups: TButton
          Left = 36
          Top = 600
          Width = 205
          Height = 25
          Caption = 'Symbol Groups'
          TabOrder = 13
          Visible = False
          OnClick = btnSymbolGroupsClick
        end
        object Button10: TButton
          Left = 313
          Top = 42
          Width = 161
          Height = 25
          Caption = 'Test getOpenActions'
          TabOrder = 14
          OnClick = Button10Click
        end
        object Button11: TButton
          Left = 316
          Top = 16
          Width = 157
          Height = 21
          Caption = 'Button11'
          TabOrder = 15
          OnClick = Button11Click
        end
      end
    end
  end
  object pnlIcons: TPanel
    Left = 0
    Top = 0
    Width = 77
    Height = 1062
    Align = alLeft
    TabOrder = 2
    object SpeedButton1: TSpeedButton
      Left = 1
      Top = -3
      Width = 77
      Height = 121
      GroupIndex = 1
      Caption = 'Info'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        5A0E0000424D5A0E000000000000320400002800000032000000320000000100
        080000000000280A0000120B0000120B0000FF000000FF000000FFFFFF003838
        3800F9F9F900D5D5D500FAFAFA00E1E1E100EAEAEA0033333300393939004141
        41006D6D6D00A0A0A000C4C4C400D7D7D700E2E2E200A1A1A100FDFDFD00E9E9
        E90044444400F1F1F100545454007171710073737300E0E0E000999999003F3F
        3F00CDCDCD0042424200DFDFDF008D8D8D00363636008E8E8E006B6B6B003535
        3500E3E3E300F8F8F800AAAAAA00454545004D4D4D0055555500C1C1C1007474
        7400EBEBEB00FCFCFC007D7D7D0034343400D8D8D800D9D9D9006F6F6F005656
        5600E4E4E4005959590058585800D4D4D4003C3C3C0037373700F0F0F000EEEE
        EE00A2A2A200A3A3A30097979700757575007272720098989800CBCBCB003E3E
        3E0070707000C5C5C5007B7B7B00C7C7C700404040007A7A7A00838383008B8B
        8B00848484008585850086868600D6D6D600DADADA00434343003A3A3A00A8A8
        A8008C8C8C00F7F7F700ADADAD008A8A8A00D1D1D100D3D3D300464646009F9F
        9F00DEDEDE00C2C2C200CACACA00C8C8C800C9C9C900CCCCCC007C7C7C008F8F
        8F006C6C6C00909090003D3D3D00D0D0D0006666660067676700686868006969
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
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE0007070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707000007070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070700000707
        0707070707070707070707070707070719150F5B1C380404385A280F15410707
        0707070707070707070707070707070700000707070707070707070707070707
        07084443100000000000000000000000002B0C47080707070707070707070707
        07070707000007070707070707070707070707081D110000041A1829271B0101
        1B313D181A040000114908070707070707070707070707070000070707070707
        0707070707070A0E00000D4B09070707070707070707070707094C2E00000520
        070707070707070707070707000007070707070707070707082400002F0A0707
        0707070707070707070707070707072D304E0000510807070707070707070707
        0000070707070707070707250300231D1E070707070707070707070707070707
        07070707071E1F0200352507070707070707070700000707070707070707260E
        000533070707070707070707070707070707070707070707070707330E000526
        0707070707070707000007070707070707121700031207070707070707070707
        0707070707070707070707070707070709560022250707070707070700000707
        0707070708030057360707070707070707070707070707070707070707070707
        0707070707643500350807070707070700000707070707072400051B07070707
        0707070707070707070707070707070707070707070707070707120E00510707
        07070707000007070707070A0023340707070707070707070707070000000000
        0000000707070707070707070707073302002007070707070000070707070822
        0052070707070707070707070707070000000000000000070707070707070707
        070707071F000508070707070000070707071F002E2107070707070707070707
        0707070707000000000707070707070707070707070707071E4E004907070707
        0000070707081100620707070707070707070707070707070700000000070707
        0707070707070707070707070742001108070707000007070760004D07070707
        0707070707070707070707070700000000070707070707070707070707070707
        072D2E0047070707000007070745004A07070707070707070707070707070707
        070000000007070707070707070707070707070707074C000C07070700000707
        0910024607070707070707070707070707070707070000000007070707070707
        0707070707070707070709042B41070700000707160040070707070707070707
        070707070707070707000000000707070707070707070707070707070707071A
        00420707000007073B003F070707070707070707070707070707070707000000
        0007070707070707070707070707070707070718000F0707000007070C003E07
        0707070707070707070707070707070707000000000707070707070707070707
        070707070707073D002807070000070705001407070707070707070707070707
        0707070707000000000707070707070707070707070707070707072700170707
        0000070713000907070707070707070707070707070707070700000000070707
        0707070707070707070707070707071200390707000007070400010707070707
        0707070707070707070707070700000000070707070707070707070707070707
        0707070800020707000007070400010707070707070707070707070707070707
        0700000000070707070707070707070707070707070707080002070700000707
        1300090707070707070707070707070707070707070000000007070707070707
        07070707070707070707074F0039070700000707050014070707070707070707
        0707070707070700000000000007070707070707070707070707070707070727
        00170707000007070C0015070707070707070707070707070707070000000000
        000707070707070707070707070707070707072900280707000007073B003C07
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070718000F07070000070729005C07070707070707070707070707
        0707070707070707070707070707070707070707070707070707071A00150707
        0000070709100219070707070707070707070707070707070707070707070707
        070707070707070707070707070709042B19070700000707075E004807070707
        0707070707070707070707070707070707070707070707070707070707070707
        07074B004307070700000707072C000307070707070707070707070707070707
        010B06060B010707070707070707070707070707072D0D004407070700000707
        07082A00200707070707070707070707070707070B0000000059070707070707
        0707070707070707070A00110807070700000707070763000D21070707070707
        070707070707070706000000000607070707070707070707070707071E2F001D
        0707070700000707070750320055070707070707070707070707070706000000
        000607070707070707070707070707071D000E08070707070000070707070730
        005331070707070707070707070707070B000000000B07070707070707070707
        0707073423000A0707070707000007070707070754001C090707070707070707
        07070707010F2A060B010707070707070707070707071B050024070707070707
        0000070707070707080D00563607070707070707070707070707070707070707
        0707070707070707073657000308070707070707000007070707070707120500
        034F070707070707070707070707070707070707070707070707070709650032
        5807070707070707000007070707070707072622001C31070707070707070707
        0707070707070707070707070707073405000E26070707070707070700000707
        07070707070707580D0053552107070707070707070707070707070707070707
        0721522300032507070707070707070700000707070707070707070708540000
        0D200707070707070707070707070707070707070A2F00002408070707070707
        0707070700000707070707070707070707073032000003481907070707070707
        0707070707464A4D0000220A0707070707070707070707070000070707070707
        0707070707070750612A000002403C16140937370914163F5F020000061F0807
        0707070707070707070707070000070707070707070707070707070707082C5D
        1000000000000000000000000010452C08070707070707070707070707070707
        000007070707070707070707070707070707070709163A0C17130404131C0C3A
        3E09070707070707070707070707070707070707000007070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707000007070707070707070707070707070707070707070707
        070707070707070707070707070707070707070707070707070707070000}
      Layout = blGlyphTop
      ParentFont = False
      StyleElements = []
      OnClick = SpeedButton1Click
    end
    object SpeedButton4: TSpeedButton
      Left = 1
      Top = 117
      Width = 77
      Height = 121
      GroupIndex = 1
      Caption = 'All Data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        5A0E0000424D5A0E000000000000320400002800000032000000320000000100
        080000000000280A0000120B0000120B0000FF000000FF000000FFFFFF003333
        3300EBEBEB00A0A0A00038383800A1A1A100EAEAEA00CECECE00D0D0D0009F9F
        9F000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
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
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE0001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010108000000000000000000000000000000000007010101
        0108000000000000000000000000000000000007010101010000010101010000
        0000000000000000000000000000000000010101010000000000000000000000
        0000000000000000010101010000010101010000010101010101010101010101
        0101010000010101010000010101010101010101010101010101000001010101
        0000010101010000010101010101010101010101010101000001010101000001
        0101010101010101010101010101000001010101000001010101000001010101
        0101010101010101010101000001010101000001010101010101010101010101
        0101000001010101000001010101000001010101010101010101010101010100
        0001010101000001010101010101010101010101010100000101010100000101
        0101000001010101010101010101010101010100000101010100000101010101
        0101010101010101010100000101010100000101010100000101010101010101
        0101010101010100000101010100000101010101010101010101010101010000
        0101010100000101010100000101010101010101010101010101010000010101
        0100000101010101010101010101010101010000010101010000010101010000
        0101010101010101010101010101010000010101010000010101010101010101
        0101010101010000010101010000010101010000010101010101010101010101
        0101010000010101010000010101010101010101010101010101000001010101
        0000010101010000010101010101010101010101010101000001010101000001
        0101010101010101010101010101000001010101000001010101000001010101
        0101010101010101010101000001010101000001010101010101010101010101
        0101000001010101000001010101000000000000000000000000000000000000
        0001010101000000000000000000000000000000000000000101010100000101
        0101000000000000000000000000000000000000000101010100000000000000
        0000000000000000000000000101010100000101010100000000000000000000
        0000000000000000000101010100000000000000000000000000000000000000
        0101010100000101010102000000000000000000000000000000000002010101
        0102000000000000000000000000000000000002010101010000010101010300
        0000000000000000000000000000000009010101010300000000000000000000
        0000000000000009010101010000010101010405020000000000000000000000
        0000060304010101010405020000000000000000000000000006030401010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010108000000000000000000
        0000000000000000070101010108000000000000000000000000000000000007
        0101010100000101010100000000000000000000000000000000000000010101
        0100000000000000000000000000000000000000010101010000010101010000
        0101010101010101010101010101010000010101010000010101010101010101
        0101010101010000010101010000010101010000010101010101010101010101
        0101010000010101010000010101010101010101010101010101000001010101
        0000010101010000010101010101010101010101010101000001010101000001
        0101010101010101010101010101000001010101000001010101000001010101
        0101010101010101010101000001010101000001010101010101010101010101
        0101000001010101000001010101000001010101010101010101010101010100
        0001010101000001010101010101010101010101010100000101010100000101
        0101000001010101010101010101010101010100000101010100000101010101
        0101010101010101010100000101010100000101010100000101010101010101
        0101010101010100000101010100000101010101010101010101010101010000
        0101010100000101010100000101010101010101010101010101010000010101
        0100000101010101010101010101010101010000010101010000010101010000
        0101010101010101010101010101010000010101010000010101010101010101
        0101010101010000010101010000010101010000010101010101010101010101
        0101010000010101010000010101010101010101010101010101000001010101
        0000010101010000010101010101010101010101010101000001010101000001
        0101010101010101010101010101000001010101000001010101000000000000
        0000000000000000000000000001010101000000000000000000000000000000
        0000000001010101000001010101000000000000000000000000000000000000
        0001010101000000000000000000000000000000000000000101010100000101
        0101000000000000000000000000000000000000000101010100000000000000
        0000000000000000000000000101010100000101010102000000000000000000
        0000000000000000020101010102000000000000000000000000000000000002
        0101010100000101010103000000000000000000000000000000000009010101
        0103000000000000000000000000000000000009010101010000010101010405
        0200000000000000000000000000060304010101010405020000000000000000
        0000000000060304010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101010000}
      Layout = blGlyphTop
      ParentFont = False
      StyleElements = []
      OnClick = SpeedButton4Click
    end
    object SpeedButton3: TSpeedButton
      Left = 1
      Top = 237
      Width = 77
      Height = 121
      GroupIndex = 1
      Caption = 'User'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        32140000424D3214000000000000320400002800000040000000400000000100
        08000000000000100000120B0000120B0000FF000000FF000000FFFFFF00FEFE
        FE005D5D5D008D8D8D00F1F1F1003535350041414100333333003D3D3D00FDFD
        FD00919191003F3F3F00BDBDBD00F5F5F500C8C8C80071717100363636004F4F
        4F009D9D9D00E1E1E100D5D5D500C9C9C900F6F6F60038383800E0E0E0008585
        8500EBEBEB00CDCDCD00F9F9F90045454500FCFCFC004D4D4D00474747003737
        3700A5A5A500FBFBFB007B7B7B00FAFAFA00ADADAD00A0A0A00092929200E8E8
        E80061616100E2E2E20034343400CECECE00A6A6A6006A6A6A0039393900A7A7
        A700D9D9D9003E3E3E00D4D4D400C3C3C300525252006F6F6F00D6D6D6005858
        580051515100CACACA0065656500545454008E8E8E007D7D7D00EFEFEF00F7F7
        F7009696960055555500E4E4E400BFBFBF0057575700BBBBBB00B6B6B6005050
        500078787800C5C5C500B0B0B000707070005B5B5B008686860046464600EAEA
        EA00B9B9B900B2B2B200CFCFCF0088888800C1C1C1007A7A7A003A3A3A00F4F4
        F400EDEDED00E6E6E6006D6D6D00D1D1D1008383830099999900A9A9A900C6C6
        C600E5E5E5004A4A4A005A5A5A00E9E9E900696969006363630064646400D7D7
        D700E7E7E700CCCCCC00DBDBDB00F8F8F8007F7F7F007272720048484800C2C2
        C20049494900D8D8D80043434300D2D2D20093939300E3E3E30087878700B7B7
        B700DCDCDC0080808000DDDDDD00565656008181810079797900535353004B4B
        4B0090909000C7C7C700DEDEDE00858585008686860087878700888888008989
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
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE0007070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707086730070707070707070707070707070707070707070707070707070707
        07070707070707173C0807070707070707070707070707070707070707070707
        070769003B050707070707070707070707070707070707070707070707070707
        070707070707056B001407070707070707070707070707070707070707070707
        0705410000030707070707070707070707070707070707070707070707070707
        0707070707073E00001605070707070707070707070707070707070707070707
        0707420000413607070707070707070707070707070707070707070707070707
        07070707073D6D00004207070707070707070707070707070707070707070707
        070710380000441D070707070707070707070707070707070707070707070707
        0707070774130000322107070707070707070707070707070707070707070707
        0707073916000075080707070707070707070707070707070707070707070707
        0707073334000016460707070707070707070707070707070707070707070707
        07070707371E00006C7207070707070707070707070707070707070707070707
        070720730000096F070707070707070707070707070707070707070707070707
        0707070707780100006A68070707070707070707070707070707070707070707
        073C650000011907070707070707070707070707070707070707070707070707
        0707070707076E23000009220807070707070707070707070707070707070708
        31090000253F0707070707070707070707070707070707070707070707070707
        070707070707072F040000004028080707070707070707070707070707087640
        0000000466070707070707070707070707070707070707070707070707070707
        07070707070707077035000000000D480F0B07070707070707070B0F790D0000
        0000712007070707070707070707070707070707070707070707070707070707
        070707070707070707073F44000000000001180C262727260C13010000000000
        7724070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707217E7C000000000000000000000000000000007A7B
        1007070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707074612142500000000000000002514127D0707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070707070717024A192828194A02170707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707498283840D1618150A800707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707074347000000000000000000001502070707
        0707070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707102209000000000000000000000000012E2107
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070B0E000000234824810B05497F45230000002D0B
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707100E0000000C1F0707070707070707110E00000015
        1707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707220000010307070707070707070707070712000000
        6007070707070707070707070707070707070707070707070707070707070707
        07070707070707070707640900000A0707070707070707070707070707120000
        0902070707070707070707070707070707070707070707070707070707070707
        070707070707070707070E000045070707070707070707070707070707052D00
        001B070707070707070707070707070707070707070707070707070707070707
        0707070707070707073A00001C11070707070707070707070707070707070200
        00003A0707070707070707070707070707070707070707070707070707070707
        0707070707070707070A00000C0707070707070707070707070707070707073B
        00005F0707070707070707070707070707070707070707070707070707070707
        0707070707070707071500002407070707070707070707070707070707070703
        0000610707070707070707070707070707070707070707070707070707070707
        0707070707070707071300003D07070707070707070707070707070707070702
        0000620707070707070707070707070707070707070707070707070707070707
        0707070707070707070D00000807070707070707070707070707070707070763
        0000090707070707070707070707070707070707070707070707070707070707
        0707070707070707071300180707070707070707070707070707070707070708
        0000000707070707070707070707070707070707070707070707070707070707
        070707070707070707113E110707070707070707070707070707070707070708
        0000000707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070708
        0000000707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070706
        0000000707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070703
        0000000707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070707070707070707070707070707074E522900
        0000000707070707070707070707070707070707070707070707070707070707
        0707070707071F32040404040404292B1456311939050707070707071B000000
        0000000707070707070707070707070707070707070707070707070707070707
        0707070707070A00000000000000000000000000001A2E360707070703000000
        0000000707070707070707070707070707070707070707070707070707070707
        0707070707074F000000000000000000000000000000001E4C06070707530000
        0000090707070707070707070707070707070707070707070707070707070707
        0707070707070F0000000000000000000000000000000000005B2A07075E0000
        00001A0707070707070707070707070707070707070707070707070707070707
        0707070707071D090000000000000000000000000000000000001C552F180000
        00000C0707070707070707070707070707070707070707070707070707070707
        0707070707070754000000000000000000000000000000000000000000000000
        00004D0707070707070707070707070707070707070707070707070707070707
        0707070707070757000000000000000000000000000000000000000000000000
        004B2C0707070707070707070707070707070707070707070707070707070707
        070707070707072C380000000000000000000000000000000000000000000000
        3406070707070707070707070707070707070707070707070707070707070707
        0707070707070707435900000000000000000000000000000000000000000D27
        5807070707070707070707070707070707070707070707070707070707070707
        070707070707070707371C00000000000000000000000000000000005D0F3307
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707072A5A0000000000000000000000000000002B1D070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070720261E000000000000000000000000355007070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707071F0A1B1A09000000000151475C070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707050606060630070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707070707070707070707}
      Layout = blGlyphTop
      ParentFont = False
      StyleElements = []
      OnClick = SpeedButton3Click
    end
    object SpeedButton2: TSpeedButton
      Left = 1
      Top = 357
      Width = 77
      Height = 121
      GroupIndex = 1
      Caption = 'Inspector'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        5A0E0000424D5A0E000000000000320400002800000032000000320000000100
        080000000000280A0000120B0000120B0000FF000000FF000000FFFFFF009595
        950046464600B5B5B500FDFDFD00414141003535350033333300FEFEFE003434
        340065656500F4F4F40036363600F5F5F50038383800E0E0E000B1B1B1003D3D
        3D00CFCFCF00A0A0A000FAFAFA008D8D8D007D7D7D00FCFCFC00F9F9F9006969
        69004A4A4A00ABABAB004D4D4D00C5C5C500E9E9E900BCBCBC0045454500D2D2
        D200B6B6B600F1F1F10039393900C1C1C100CACACA0051515100C7C7C700D6D6
        D60078787800CBCBCB0077777700C2C2C20082828200DBDBDB006A6A6A008888
        8800818181008989890093939300CDCDCD008E8E8E0099999900F6F6F6008C8C
        8C00636363004848480073737300A5A5A5006D6D6D00F7F7F70072727200ACAC
        AC006E6E6E00E3E3E300A6A6A600D7D7D7003B3B3B00EFEFEF00D3D3D300F8F8
        F8005C5C5C005555550060606000595959004B4B4B0061616100E2E2E2005B5B
        5B00545454004747470064646400F3F3F300EDEDED00EEEEEE00E7E7E700D1D1
        D10037373700ECECEC00E6E6E600585858005E5E5E005F5F5F00606060006161
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
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE0007070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707000007070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070700000707
        07070707070707070707070707070707070707070707070707070A2928070707
        0707070707070707070707070707070700000707070707070707070707070707
        0707070707070707070707070203080000070707070707070707070707070707
        0707070700000707070707070707070707070707070707070707070707070C15
        0B000D0000070707070707070707070707070707070707070000070707070707
        07070707070707070707070707070707070A2F00002D1A000007070707070707
        0707070707070707070707070000070707070707070707070707070707070707
        070707020308000F300707000007070707070707070707070707070707070707
        0000070707070707070707070707070707070707070C390B0038370E07070700
        0007070707070707070707070707070707070707000007070707070707070707
        0707070707070707073500080302070707070700000707070707070707070707
        070707070707070700000707070707070707070707070707070707070700003A
        0707070707070700000707070707070707070707070707070707070700000707
        0707070707070707070707070707070707000007070707070707070000070707
        0707070707070707070707070707070700000707070707070707070707070707
        0707070707000007070707070707070000070707070707070707070707070707
        0707070700000707070707070707070707070707070707070700000707070707
        0707070000070707070707070707070707070707070707070000070707070707
        0707070707070707070707070700000707070707070707000007070707070707
        0707070707070707070707070000070707070707070707070707070707070707
        0700000707070707070707000007070707070707070707070707070707070707
        0000070707070707070707070707070707070707070000070707070707070700
        0007070707070707070707070707070707070707000007070707070707070707
        0707070707070707070000070707070707070700000707070707070707070707
        0707070707070707000007070707070707070707070707070707070707000007
        0707070707070700000707070707070707070707070707070707070700000707
        0707070707070707070707070707070707000007070707070707070000070707
        0707070707070707070707070707070700000707070707070707070707070707
        0707070707000007070707070707070000070707070707070707070707070707
        0707070700000707070707070707070707070707070707070700000707070707
        0707070000070707070707070707070707070707070707070000070707070707
        0707070707070707070707070700000707070707070707000007070707070707
        0707070707070707070707070000070707070707070707070707070707070707
        0700000707070707070707000007070707070707070707070707070707070707
        0000070707070707070707070707070707070707070000070707070707070700
        0007070707070707070707070707070707070707000007070707070707070707
        0707070707070707070000070707070707070700000707070707070707070707
        0707070707070707000007070707070707070707070707070707070707000007
        0707070707070700000707070707070707070707070707070707070700000707
        0707070707070707070707070707070705000000000000000000000000050707
        0707070707070707070707070707070700000707070707070707070707070707
        0707074612000000000000000000000000481107070707070707070707070707
        070707070000070707070707070707070707070707070E1D00433B0707070707
        070707200F002624070707070707070707070707070707070000070707070707
        070707070707070707061F001E1C070707070707070707074E5800250C070707
        0707070707070707070707070000070707070707070707070707070709100047
        4B07070707070707070707070727560022060707070707070707070707070707
        000007070707070707070707070707091B000B4A070707070707070707070707
        07074D23001B0707070707070707070707070707000007070707070707070707
        0707071300490A070707070707070707070707070707074F0D003D0707070707
        0707070707070707000007070707070707070707070701001442070707070707
        0707070707070707070707071918003407070707070707070707070700000707
        0707070707070707073100042A07070707070707070707070707070707070707
        073C17001507070707070707070707070000070707070707070707071604082E
        0707070707070707070707070707070707070707070716040832070707070707
        0707070700000707070707070707074017003607070707070707070707070707
        07070707070707070707073300042C0707070707070707070000070707070707
        0707191800010707070707070707070707070707070707070707070707070707
        0100143E07070707070707070000070707070707074C0D004407070707070707
        07070707070707070707070707070707070707070713003F5407070707070707
        00000707070707075D2300100907070707070707070707070707070707070707
        070707070707070707094100555107070707070700000707070707275B002206
        0707070707070707070707070707070707070707070707070707070707070910
        00575207070707070000070707071A5C00255A07070707070707070707070707
        07070707070707070707070707070707070707061F001E1C0707070700000707
        07200F0026240707070707070707070707070707070707070707070707070707
        07070707070707070E1D00505307070700000707075900211107070707070707
        0707070707070707070707070707070707070707070707070707070707112100
        4507070700000707070000050707070707070707070707070707070707070707
        0707070707070707070707070707070707070500000707070000070707000007
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070700000707070000070707000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000070707
        00000707072B0000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000012070707000007070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707000007070707070707070707070707070707070707070707
        070707070707070707070707070707070707070707070707070707070000}
      Layout = blGlyphTop
      ParentFont = False
      StyleElements = []
      OnClick = SpeedButton2Click
    end
    object SpeedButton5: TSpeedButton
      Left = 1
      Top = 477
      Width = 77
      Height = 121
      GroupIndex = 1
      Caption = 'Reload Data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        36140000424D3614000000000000360400002800000040000000400000000100
        08000000000000100000120B0000120B00000001000000000000CCCCCC003535
        3500C5C5C5005C5C5C00CACACA0043434300C8C8C80033333300CBCBCB00C7C7
        C70036363600ACACAC009E9E9E00BCBCBC00383838006B6B6B00595959003D3D
        3D00616161008C8C8C0045454500A9A9A9008686860071717100AAAAAA006363
        6300727272006C6C6C0065656500C9C9C90042424200ADADAD006D6D6D005F5F
        5F00C3C3C300C4C4C400444444008D8D8D007A7A7A00C2C2C20082828200B4B4
        B4007C7C7C00A7A7A7006767670092929200525252004B4B4B0084848400BDBD
        BD007D7D7D00B6B6B600AFAFAF004C4C4C007E7E7E0077777700373737007070
        7000A2A2A2009B9B9B0094949400BFBFBF00464646007F7F7F00555555008E8E
        8E00C0C0C00047474700B9B9B900A4A4A400646464009D9D9D005D5D5D008888
        8800414141003A3A3A00737373005E5E5E0090909000BBBBBB0074747400A6A6
        A600666666009F9F9F00585858003C3C3C0075757500AEAEAE005A5A5A00C6C6
        C60078787800B2B2B20057575700838383005E5E5E005F5F5F00606060006161
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
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFFFF00070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        3D47030707070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        0000001301070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000028070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000004430707070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070701
        2E440000002A0707070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070F0000003A0707070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0714000000270107070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707310000002F07070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070C0000001B07070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707320000002507070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707480000003407070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070711080000084B070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707073300000010070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707073C00000026070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707560000003B070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707400000000D070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070E09000000050707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707070B0000001C0707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070713000000160707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707200000002B0707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707073500000000000000000000002318170A070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707070122000000000000000000000000000B1E0707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707074500000000000000000000000000001F0A07070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707073F0000000000000000000000000000001707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070707070707070707070707070705530000001507070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070707070707070707070707070707050000000207070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070707070707070707070707070707050000000207070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707070707070707070707070707240C0000001507070707070707070000
        0000000000000000000000000707070707070707074900000000000000000000
        0000000000000000000000000000000000000000001A07070707070707070000
        0000000000000000000000005207070707070707071900000000000000000000
        00000000000000000000000000000000000000001F0A07070707070707070000
        000000000000000000000000042C070707070707071104000000000000000000
        00000000000000000000000000000000000000571E0707070707070707070000
        00000000000000000000000000080F070707070707070B000000000000000000
        0000000000000000000000000000000002185038070707070707070707070707
        070707070707070707461D000000081B070707070707160000002D0707070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707071C1D00000004200707070707030000000D0507070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070719060000000439070707070E060000002955070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707071206000000081A070707070C0000000041070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707071209000000084C0707070A2500000004140707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070721090000000837070707015B000000360707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707072106000000005A0707070F000000510707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070707074D0900000000260707240000004F0707
        0707070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707070707070309000000002A070E000000090707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070707070707035900000000285D0000000D0707
        0707070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707070707070707580200000000000000004E0707
        0707070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707070707070707071002000000000000223E0707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707071023000000004254070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070707070707070707075C270629304A07070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707}
      Layout = blGlyphTop
      ParentFont = False
      StyleElements = []
      OnClick = SpeedButton5Click
    end
    object SpeedButton6: TSpeedButton
      Left = 1
      Top = 597
      Width = 77
      Height = 121
      GroupIndex = 1
      Caption = 'Report'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        36140000424D3614000000000000360400002800000040000000400000000100
        08000000000000100000120B0000120B00000001000000000000CCCCCC003535
        3500C5C5C5005C5C5C00CACACA0043434300C8C8C80033333300CBCBCB00C7C7
        C70036363600ACACAC009E9E9E00BCBCBC00383838006B6B6B00595959003D3D
        3D00616161008C8C8C0045454500A9A9A9008686860071717100AAAAAA006363
        6300727272006C6C6C0065656500C9C9C90042424200ADADAD006D6D6D005F5F
        5F00C3C3C300C4C4C400444444008D8D8D007A7A7A00C2C2C20082828200B4B4
        B4007C7C7C00A7A7A7006767670092929200525252004B4B4B0084848400BDBD
        BD007D7D7D00B6B6B600AFAFAF004C4C4C007E7E7E0077777700373737007070
        7000A2A2A2009B9B9B0094949400BFBFBF00464646007F7F7F00555555008E8E
        8E00C0C0C00047474700B9B9B900A4A4A400646464009D9D9D005D5D5D008888
        8800414141003A3A3A00737373005E5E5E0090909000BBBBBB0074747400A6A6
        A600666666009F9F9F00585858003C3C3C0075757500AEAEAE005A5A5A00C6C6
        C60078787800B2B2B20057575700838383005E5E5E005F5F5F00606060006161
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
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFFFF00070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        3D47030707070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        0000001301070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000028070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000004430707070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070701
        2E440000002A0707070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070F0000003A0707070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0714000000270107070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707310000002F07070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070C0000001B07070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707320000002507070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707480000003407070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070711080000084B070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707073300000010070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707073C00000026070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707560000003B070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707400000000D070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070E09000000050707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707070B0000001C0707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070713000000160707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707200000002B0707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707073500000000000000000000002318170A070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707070122000000000000000000000000000B1E0707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707074500000000000000000000000000001F0A07070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707073F0000000000000000000000000000001707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070707070707070707070707070705530000001507070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070707070707070707070707070707050000000207070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070707070707070707070707070707050000000207070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707070707070707070707070707240C0000001507070707070707070000
        0000000000000000000000000707070707070707074900000000000000000000
        0000000000000000000000000000000000000000001A07070707070707070000
        0000000000000000000000005207070707070707071900000000000000000000
        00000000000000000000000000000000000000001F0A07070707070707070000
        000000000000000000000000042C070707070707071104000000000000000000
        00000000000000000000000000000000000000571E0707070707070707070000
        00000000000000000000000000080F070707070707070B000000000000000000
        0000000000000000000000000000000002185038070707070707070707070707
        070707070707070707461D000000081B070707070707160000002D0707070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707071C1D00000004200707070707030000000D0507070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070719060000000439070707070E060000002955070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707071206000000081A070707070C0000000041070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707071209000000084C0707070A2500000004140707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070721090000000837070707015B000000360707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707072106000000005A0707070F000000510707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070707074D0900000000260707240000004F0707
        0707070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707070707070309000000002A070E000000090707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070707070707035900000000285D0000000D0707
        0707070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707070707070707580200000000000000004E0707
        0707070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707070707070707071002000000000000223E0707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707071023000000004254070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070707070707070707075C270629304A07070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707}
      Layout = blGlyphTop
      ParentFont = False
      StyleElements = []
      OnClick = SpeedButton6Click
    end
    object SpeedButton7: TSpeedButton
      Left = 3
      Top = 717
      Width = 77
      Height = 121
      GroupIndex = 1
      Caption = 'Internal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        36140000424D3614000000000000360400002800000040000000400000000100
        08000000000000100000120B0000120B00000001000000000000CCCCCC003535
        3500C5C5C5005C5C5C00CACACA0043434300C8C8C80033333300CBCBCB00C7C7
        C70036363600ACACAC009E9E9E00BCBCBC00383838006B6B6B00595959003D3D
        3D00616161008C8C8C0045454500A9A9A9008686860071717100AAAAAA006363
        6300727272006C6C6C0065656500C9C9C90042424200ADADAD006D6D6D005F5F
        5F00C3C3C300C4C4C400444444008D8D8D007A7A7A00C2C2C20082828200B4B4
        B4007C7C7C00A7A7A7006767670092929200525252004B4B4B0084848400BDBD
        BD007D7D7D00B6B6B600AFAFAF004C4C4C007E7E7E0077777700373737007070
        7000A2A2A2009B9B9B0094949400BFBFBF00464646007F7F7F00555555008E8E
        8E00C0C0C00047474700B9B9B900A4A4A400646464009D9D9D005D5D5D008888
        8800414141003A3A3A00737373005E5E5E0090909000BBBBBB0074747400A6A6
        A600666666009F9F9F00585858003C3C3C0075757500AEAEAE005A5A5A00C6C6
        C60078787800B2B2B20057575700838383005E5E5E005F5F5F00606060006161
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
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFFFF00070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        3D47030707070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        0000001301070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000028070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000004430707070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070701
        2E440000002A0707070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070F0000003A0707070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0714000000270107070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707310000002F07070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070C0000001B07070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707320000002507070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707480000003407070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070711080000084B070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707073300000010070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707073C00000026070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707560000003B070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707400000000D070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070E09000000050707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707070B0000001C0707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070713000000160707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707200000002B0707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707073500000000000000000000002318170A070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707070122000000000000000000000000000B1E0707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707074500000000000000000000000000001F0A07070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707073F0000000000000000000000000000001707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070707070707070707070707070705530000001507070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070707070707070707070707070707050000000207070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070707070707070707070707070707050000000207070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707070707070707070707070707240C0000001507070707070707070000
        0000000000000000000000000707070707070707074900000000000000000000
        0000000000000000000000000000000000000000001A07070707070707070000
        0000000000000000000000005207070707070707071900000000000000000000
        00000000000000000000000000000000000000001F0A07070707070707070000
        000000000000000000000000042C070707070707071104000000000000000000
        00000000000000000000000000000000000000571E0707070707070707070000
        00000000000000000000000000080F070707070707070B000000000000000000
        0000000000000000000000000000000002185038070707070707070707070707
        070707070707070707461D000000081B070707070707160000002D0707070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707071C1D00000004200707070707030000000D0507070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070719060000000439070707070E060000002955070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707071206000000081A070707070C0000000041070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707071209000000084C0707070A2500000004140707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070721090000000837070707015B000000360707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707072106000000005A0707070F000000510707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070707074D0900000000260707240000004F0707
        0707070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707070707070309000000002A070E000000090707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070707070707035900000000285D0000000D0707
        0707070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707070707070707580200000000000000004E0707
        0707070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707070707070707071002000000000000223E0707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707071023000000004254070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070707070707070707075C270629304A07070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707}
      Layout = blGlyphTop
      ParentFont = False
      StyleElements = []
      OnClick = SpeedButton7Click
    end
    object SpeedButton8: TSpeedButton
      Left = 3
      Top = 837
      Width = 77
      Height = 121
      GroupIndex = 1
      Caption = 'Eval.Actions'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        36140000424D3614000000000000360400002800000040000000400000000100
        08000000000000100000120B0000120B00000001000000000000CCCCCC003535
        3500C5C5C5005C5C5C00CACACA0043434300C8C8C80033333300CBCBCB00C7C7
        C70036363600ACACAC009E9E9E00BCBCBC00383838006B6B6B00595959003D3D
        3D00616161008C8C8C0045454500A9A9A9008686860071717100AAAAAA006363
        6300727272006C6C6C0065656500C9C9C90042424200ADADAD006D6D6D005F5F
        5F00C3C3C300C4C4C400444444008D8D8D007A7A7A00C2C2C20082828200B4B4
        B4007C7C7C00A7A7A7006767670092929200525252004B4B4B0084848400BDBD
        BD007D7D7D00B6B6B600AFAFAF004C4C4C007E7E7E0077777700373737007070
        7000A2A2A2009B9B9B0094949400BFBFBF00464646007F7F7F00555555008E8E
        8E00C0C0C00047474700B9B9B900A4A4A400646464009D9D9D005D5D5D008888
        8800414141003A3A3A00737373005E5E5E0090909000BBBBBB0074747400A6A6
        A600666666009F9F9F00585858003C3C3C0075757500AEAEAE005A5A5A00C6C6
        C60078787800B2B2B20057575700838383005E5E5E005F5F5F00606060006161
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
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFFFF00070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        3D47030707070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        0000001301070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000028070707070707070707070707070707070707070707070707070000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000004430707070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070701
        2E440000002A0707070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070F0000003A0707070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0714000000270107070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707310000002F07070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070C0000001B07070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707320000002507070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707480000003407070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070711080000084B070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707073300000010070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707073C00000026070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707560000003B070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707400000000D070707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070E09000000050707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707070B0000001C0707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070713000000160707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707200000002B0707070707070707070707070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707073500000000000000000000002318170A070707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        070707070122000000000000000000000000000B1E0707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707074500000000000000000000000000001F0A07070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707073F0000000000000000000000000000001707070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070707070707070707070707070705530000001507070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070707070707070707070707070707050000000207070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        0707070707070707070707070707070707050000000207070707070707070000
        0000070707070707000000000707070707070707070707070707070707070707
        07070707070707070707070707070707240C0000001507070707070707070000
        0000000000000000000000000707070707070707074900000000000000000000
        0000000000000000000000000000000000000000001A07070707070707070000
        0000000000000000000000005207070707070707071900000000000000000000
        00000000000000000000000000000000000000001F0A07070707070707070000
        000000000000000000000000042C070707070707071104000000000000000000
        00000000000000000000000000000000000000571E0707070707070707070000
        00000000000000000000000000080F070707070707070B000000000000000000
        0000000000000000000000000000000002185038070707070707070707070707
        070707070707070707461D000000081B070707070707160000002D0707070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707071C1D00000004200707070707030000000D0507070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070719060000000439070707070E060000002955070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707071206000000081A070707070C0000000041070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707071209000000084C0707070A2500000004140707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070721090000000837070707015B000000360707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707072106000000005A0707070F000000510707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070707074D0900000000260707240000004F0707
        0707070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707070707070309000000002A070E000000090707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070707070707035900000000285D0000000D0707
        0707070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707070707070707580200000000000000004E0707
        0707070707070707070707070707070707070707070707070707070707070707
        07070707070707070707070707070707070707071002000000000000223E0707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707071023000000004254070707
        0707070707070707070707070707070707070707070707070707070707070707
        070707070707070707070707070707070707070707075C270629304A07070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707}
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      Visible = False
      StyleElements = []
      OnClick = SpeedButton8Click
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnModalBegin = ApplicationEvents1ModalBegin
    OnModalEnd = ApplicationEvents1ModalEnd
    Left = 322
    Top = 65522
  end
  object StartTimer: TTimer
    Enabled = False
    OnTimer = StartTimerTimer
    Left = 400
    Top = 65520
  end
  object updateTimer: TTimer
    Enabled = False
    Interval = 900000
    OnTimer = updateTimerTimer
    Left = 444
    Top = 65524
  end
  object infoTimer: TTimer
    OnTimer = infoTimerTimer
    Left = 500
    Top = 65520
  end
end
