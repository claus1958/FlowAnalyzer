object Frame4: TFrame4
  Left = 0
  Top = 0
  Width = 526
  Height = 27
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object cbAndOr: TComboBox
    Left = 3
    Top = 3
    Width = 78
    Height = 21
    ItemIndex = 0
    TabOrder = 0
    Text = 'AND'
    Items.Strings = (
      'AND'
      'OR')
  end
  object cbTopic: TComboBox
    Left = 96
    Top = 3
    Width = 129
    Height = 21
    ItemIndex = 0
    TabOrder = 1
    Text = 'Broker'
    Items.Strings = (
      'Broker'
      'BrokerAccount'
      'UserID'
      'UserName'
      'ActionType'
      'Profit'
      'AccountDate'
      'ActionFrom'
      'ActionTo'
      'Quote'
      'Profit')
  end
  object cbOperator: TComboBox
    Left = 231
    Top = 3
    Width = 74
    Height = 21
    ItemIndex = 0
    TabOrder = 2
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
    Left = 400
    Top = 3
    Width = 123
    Height = 21
    TabOrder = 3
    Text = 'edValue'
  end
  object cbValues: TComboBox
    Left = 312
    Top = 3
    Width = 82
    Height = 21
    TabOrder = 4
    Text = 'cbValues'
  end
end
