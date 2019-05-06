object frmPrincipal: TfrmPrincipal
  Left = 311
  Top = 212
  Width = 743
  Height = 384
  Caption = 'frmPrincipal'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mmenu
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object mmenu: TMainMenu
    Left = 96
    Top = 56
    object mOpcoes: TMenuItem
      Caption = '&Opcoes'
      ShortCut = 16463
      object Grid1: TMenuItem
        Caption = 'Gri&d'
        OnClick = Grid1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = 'Sai&r'
        OnClick = Sair1Click
      end
    end
    object Ajuda1: TMenuItem
      Caption = 'Ajuda'
      object Sobre1: TMenuItem
        Caption = 'S&obre'
      end
    end
  end
end
