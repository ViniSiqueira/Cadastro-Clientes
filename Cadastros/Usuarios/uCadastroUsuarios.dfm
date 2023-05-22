inherited frmCadastroUsuarios: TfrmCadastroUsuarios
  Caption = 'Cadastro de Usu'#225'rios'
  ClientHeight = 494
  ClientWidth = 824
  ExplicitWidth = 840
  ExplicitHeight = 533
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlRodape: TPanel
    Top = 457
    Width = 824
    inherited btnNavegator: TDBNavigator
      Hints.Strings = ()
    end
    inherited brnFechar: TBitBtn
      Left = 726
    end
  end
  inherited pgcPrincipal: TPageControl
    Width = 824
    Height = 457
    inherited tbLista: TTabSheet
      ExplicitWidth = 816
      ExplicitHeight = 429
      inherited pnlCabecalho: TPanel
        Width = 816
        ExplicitLeft = 3
        ExplicitWidth = 1010
      end
      inherited gridLista: TDBGrid
        Width = 816
        Height = 380
        Columns = <
          item
            Expanded = False
            FieldName = 'USUARIO_ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Visible = True
          end>
      end
    end
    inherited tbManutencao: TTabSheet
      ExplicitWidth = 816
      ExplicitHeight = 429
      object edtCodigo: TLabeledEdit
        Tag = 1
        Left = 3
        Top = 20
        Width = 118
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Left = 3
        Top = 65
        Width = 497
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 50
        TabOrder = 1
      end
      object edtSenha: TLabeledEdit
        Left = 3
        Top = 113
        Width = 497
        Height = 21
        EditLabel.Width = 30
        EditLabel.Height = 13
        EditLabel.Caption = 'Senha'
        MaxLength = 250
        PasswordChar = '*'
        TabOrder = 2
      end
    end
  end
  inherited qryLista: TZQuery
    SQL.Strings = (
      'SELECT * FROM USUARIOS')
    Left = 436
    Top = 48
    object qryListaUSUARIO_ID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'USUARIO_ID'
      ReadOnly = True
    end
    object qryListaNOME: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
    object qryListaSENHA: TWideStringField
      DisplayLabel = 'Senha'
      FieldName = 'SENHA'
      Required = True
      Size = 50
    end
  end
  inherited dtsLista: TDataSource
    Left = 492
    Top = 48
  end
end
