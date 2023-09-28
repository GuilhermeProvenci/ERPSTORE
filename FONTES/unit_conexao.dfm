object form_conexao: Tform_conexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 298
  Width = 397
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=marimodas'
      'User_Name=root'
      'Password=masterkey'
      'DriverID=mySQL')
    LoginPrompt = False
    Left = 48
    Top = 56
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 272
    Top = 56
  end
end
