object GroupControl: TGroupControl
  Left = 0
  Top = 0
  Width = 505
  Height = 28
  Color = clGray
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object Label1: TLabel
    Left = 256
    Top = 8
    Width = 3
    Height = 13
  end
  object cbTopic: TComboBox
    Left = 32
    Top = 3
    Width = 213
    Height = 21
    TabOrder = 0
    Text = 'unused'
    Items.Strings = (
      'unused'
      'symbolGroup'
      'userId'
      'yearsOpen'
      'yearsClose'
      'brokerAccount'
      'broker')
  end
  object chkActive: TCheckBox
    Left = 9
    Top = 4
    Width = 17
    Height = 17
    TabOrder = 1
    OnClick = chkActiveClick
  end
end
