object FilterElemente: TFilterElemente
  Left = 0
  Top = 0
  Width = 505
  Height = 28
  Color = clGray
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  OnClick = FrameClick
  OnExit = FrameExit
  object cbTopic: TComboBox
    Left = 32
    Top = 3
    Width = 129
    Height = 21
    TabOrder = 0
    Text = 'BrokerId'
    OnChange = cbTopicChange
    Items.Strings = (
      'BrokerId'
      'AccountId'
      'SymbolId'#39'Suche aus Liste'
      'Symbol'#39'Texteingabe'
      'UserId'
      'UserName'
      'ActionType'
      'OpenDateTime'
      'CloseDateTime'
      'OpenPrice'
      'Profit'
      'Volume'
      'MarginRate'
      'AccountCurrency'
      'CloseDateTime OR Open')
  end
  object cbOperator: TComboBox
    Left = 163
    Top = 3
    Width = 58
    Height = 21
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
  end
  object edValue: TEdit
    Left = 227
    Top = 3
    Width = 254
    Height = 21
    TabOrder = 2
    OnChange = edValueChange
  end
  object dtPicker1: TDateTimePicker
    Left = 388
    Top = 3
    Width = 93
    Height = 22
    Date = 43549.000000000000000000
    Time = 0.412345231481595000
    TabOrder = 3
    Visible = False
    OnChange = dtPicker1Change
  end
  object chkActive: TCheckBox
    Left = 9
    Top = 4
    Width = 17
    Height = 17
    TabOrder = 4
    OnClick = chkActiveClick
  end
  object chkLB1: TComboBox
    Left = 223
    Top = 3
    Width = 258
    Height = 22
    Style = csOwnerDrawFixed
    DropDownCount = 24
    TabOrder = 6
    OnClick = chkLB1Click
    OnDrawItem = chkLB1DrawItem
    OnExit = chkLB1Exit
    OnSelect = chkLB1Select
  end
  object btnMore: TButton
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
    OnClick = btnMoreClick
    OnMouseUp = btnMoreMouseUp
  end
end
