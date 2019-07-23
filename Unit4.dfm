object Frame4: TFrame4
  Left = 0
  Top = 0
  Width = 474
  Height = 45
  TabOrder = 0
  object ComboBox1: TComboBox
    Left = 3
    Top = 8
    Width = 314
    Height = 22
    Style = csOwnerDrawFixed
    TabOrder = 0
    OnDrawItem = ComboBox1DrawItem
    OnSelect = ComboBox1Select
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '0'
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7')
  end
  object Button1: TButton
    Left = 328
    Top = 8
    Width = 65
    Height = 17
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
end
