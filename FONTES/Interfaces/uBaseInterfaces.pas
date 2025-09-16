unit uBaseInterfaces;

interface

type
  IBaseRegister = interface
    ['{A1B2C3D4-E5F6-47A8-B9C0-123456789ABC}']
    function GetID: Integer;
    procedure SetID(AID: Integer);
    procedure LoadFromID(AID: Integer);
    procedure Save;
    procedure Delete;
    function GetTableName: string;
  end;

implementation

end.

