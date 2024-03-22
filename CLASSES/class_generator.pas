unit class_Generator;

interface

uses
  System.Classes;

type
  TComponentGenerator = class
  public
    class function GenerateComponentUnit(const ComponentName, BaseClassName: string): string;
  end;

implementation

uses
  SysUtils;

{ TComponentGenerator }

class function TComponentGenerator.GenerateComponentUnit(const ComponentName, BaseClassName: string): string;
var
  Template: TStringList;
begin
  Template := TStringList.Create;
  try
    Template.LoadFromFile('D:\ERPSTORE\CLASSES\class_base.pas');
    Result := Format(Template.Text, [ComponentName, ComponentName, BaseClassName, ComponentName, ComponentName, ComponentName, ComponentName]);
  finally
    Template.Free;
  end;
end;

end.
