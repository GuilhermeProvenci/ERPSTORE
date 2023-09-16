unit ClassMap;

 //ainda procurando um bom uso pra isso, para registrar sozinho as classes

interface

uses
  System.Generics.Collections;

type
  TClassMap = class
  private
    class var FClassRegistry: TDictionary<string, TClass>;
  public
    class constructor Create;
    class destructor Destroy;
    class procedure RegistrarClass(const AClassName: string; AClass: TClass);
    class function CreateInstance(const AClassName: string): TObject;
  end;

implementation


class constructor TClassMap.Create;
begin
  FClassRegistry := TDictionary<string, TClass>.Create;
end;

class destructor TClassMap.Destroy;
begin
  FClassRegistry.Free;
end;

class procedure TClassMap.RegistrarClass(const AClassName: string; AClass: TClass);
begin
  FClassRegistry.AddOrSetValue(AClassName, AClass);
end;

class function TClassMap.CreateInstance(const AClassName: string): TObject;
var
  ClassRef: TClass;
begin
  if FClassRegistry.TryGetValue(AClassName, ClassRef) then
    Result := ClassRef.Create
  else
    Result := nil; // Or raise an exception
end;


end.
