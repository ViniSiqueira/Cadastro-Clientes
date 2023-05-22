inherited frmCadastroClientes: TfrmCadastroClientes
  Caption = 'Cadastro de Clientes'
  ClientHeight = 372
  ClientWidth = 759
  ExplicitWidth = 775
  ExplicitHeight = 411
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlRodape: TPanel
    Top = 335
    Width = 759
    ExplicitTop = 335
    ExplicitWidth = 759
    inherited btnNavegator: TDBNavigator
      Hints.Strings = ()
    end
    inherited brnFechar: TBitBtn
      Left = 661
      ExplicitLeft = 661
    end
  end
  inherited pgcPrincipal: TPageControl
    Width = 759
    Height = 335
    ExplicitWidth = 759
    ExplicitHeight = 335
    inherited tbLista: TTabSheet
      ExplicitWidth = 751
      ExplicitHeight = 307
      inherited pnlCabecalho: TPanel
        Width = 751
        ExplicitWidth = 751
      end
      inherited gridLista: TDBGrid
        Width = 751
        Height = 258
        Columns = <
          item
            Expanded = False
            FieldName = 'CLIENTE_ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CEP'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CIDADE'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ESTADO'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ENDERECO'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BAIRRO'
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TELEFONE'
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMAIL'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATA_NASCIMENTO'
            Width = 115
            Visible = True
          end>
      end
    end
    inherited tbManutencao: TTabSheet
      ExplicitWidth = 751
      ExplicitHeight = 307
      object lblCEP: TLabel
        Left = 520
        Top = 49
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object lblTelefone: TLabel
        Left = 520
        Top = 141
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object lblDataNascimento: TLabel
        Left = 520
        Top = 185
        Width = 96
        Height = 13
        Caption = 'Data de Nascimento'
      end
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
      object edtEndereco: TLabeledEdit
        Left = 3
        Top = 113
        Width = 497
        Height = 21
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o'
        MaxLength = 250
        TabOrder = 2
      end
      object edtCidade: TLabeledEdit
        Left = 3
        Top = 158
        Width = 497
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        MaxLength = 250
        TabOrder = 3
      end
      object edtEmail: TLabeledEdit
        Left = 3
        Top = 201
        Width = 497
        Height = 21
        EditLabel.Width = 24
        EditLabel.Height = 13
        EditLabel.Caption = 'Email'
        MaxLength = 250
        TabOrder = 4
      end
      object edtCep: TMaskEdit
        Left = 520
        Top = 68
        Width = 63
        Height = 21
        EditMask = '99999-999;1;_'
        MaxLength = 9
        TabOrder = 5
        Text = '     -   '
        OnExit = edtCepExit
      end
      object edtEstado: TLabeledEdit
        Left = 601
        Top = 68
        Width = 37
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Estado'
        MaxLength = 2
        TabOrder = 6
      end
      object edtBairro: TLabeledEdit
        Left = 520
        Top = 113
        Width = 118
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Bairro'
        MaxLength = 100
        TabOrder = 7
      end
      object edtTelefone: TMaskEdit
        Left = 523
        Top = 158
        Width = 117
        Height = 21
        EditMask = '(99)9999-9999;1;_'
        MaxLength = 13
        TabOrder = 8
        Text = '(  )    -    '
      end
      object edtDataNascimento: TDateEdit
        Left = 523
        Top = 204
        Width = 120
        Height = 21
        DialogTitle = 'Selecione a data'
        NumGlyphs = 2
        CalendarStyle = csDialog
        TabOrder = 9
      end
    end
  end
  inherited qryLista: TZQuery
    SQL.Strings = (
      'SELECT * FROM CLIENTES')
    Left = 588
    object qryListaCLIENTE_ID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CLIENTE_ID'
      ReadOnly = True
    end
    object qryListaNOME: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 50
    end
    object qryListaCEP: TWideStringField
      FieldName = 'CEP'
      Size = 10
    end
    object qryListaCIDADE: TWideStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Size = 250
    end
    object qryListaESTADO: TWideStringField
      DisplayLabel = 'Estado'
      FieldName = 'ESTADO'
      Size = 2
    end
    object qryListaENDERECO: TWideStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'ENDERECO'
      Size = 250
    end
    object qryListaBAIRRO: TWideStringField
      DisplayLabel = 'Bairro'
      FieldName = 'BAIRRO'
      Size = 100
    end
    object qryListaTELEFONE: TWideStringField
      DisplayLabel = 'Telefone'
      FieldName = 'TELEFONE'
      Size = 14
    end
    object qryListaEMAIL: TWideStringField
      DisplayLabel = 'Email'
      FieldName = 'EMAIL'
      Size = 250
    end
    object qryListaDATA_NASCIMENTO: TDateTimeField
      DisplayLabel = 'Data de Nascimento'
      FieldName = 'DATA_NASCIMENTO'
    end
  end
  inherited dtsLista: TDataSource
    Left = 644
    Top = 32
  end
end
