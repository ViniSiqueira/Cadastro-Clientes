object dtmConexao: TdtmConexao
  OldCreateOrder = False
  Height = 368
  Width = 789
  object conexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    AutoEncodeStrings = True
    Catalog = ''
    Properties.Strings = (
      'AutoEncodeStrings=ON'
      'controls_cp=CP_UTF16')
    Connected = True
    SQLHourGlass = True
    HostName = '.\SQLEXPRESS'
    Port = 1433
    Database = 'CLIENTES_PRD'
    User = ''
    Password = ''
    Protocol = 'mssql'
    LibraryLocation = 'C:\Users\vinic\Documents\ProjetoDelphi\ntwdblib.dll'
    Left = 112
    Top = 64
  end
end
