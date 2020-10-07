object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Citrix Password Hasher by Remko Weijnen'
  ClientHeight = 104
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  GlassFrame.Enabled = True
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    688
    104)
  PixelsPerInch = 96
  TextHeight = 13
  object URLLabel: TLabel
    Left = 574
    Top = 79
    Width = 106
    Height = 13
    Cursor = crHandPoint
    Hint = 'http://www.remkoweijnen.nl/blog'
    Anchors = [akTop, akRight]
    Caption = 'www.remkoweijnen.nl'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = URLLabelClick
    ExplicitLeft = 561
  end
  object Label1: TLabel
    Left = 664
    Top = 53
    Width = 16
    Height = 13
    Alignment = taRightJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = '##'
  end
  object Label2: TLabel
    Left = 664
    Top = 26
    Width = 16
    Height = 13
    Alignment = taRightJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = '##'
  end
  object PasswordEdit: TLabeledEdit
    Left = 165
    Top = 25
    Width = 478
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Password'
    LabelPosition = lpLeft
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    OnKeyPress = PasswordEditKeyPress
  end
  object EncodeButton: TButton
    Left = 21
    Top = 21
    Width = 75
    Height = 25
    Caption = 'Encrypt'
    TabOrder = 2
    OnClick = EncodeButtonClick
  end
  object HashEdit: TLabeledEdit
    Left = 165
    Top = 52
    Width = 478
    Height = 21
    Hint = 'Minimum hash length is 4 characters, hash should be UPPERCASE'
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = 'Hash'
    LabelPosition = lpLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnKeyPress = HashEditKeyPress
  end
  object DecodeButton: TButton
    Left = 21
    Top = 52
    Width = 75
    Height = 25
    Caption = 'Decrypt'
    TabOrder = 3
    OnClick = DecodeButtonClick
  end
end
