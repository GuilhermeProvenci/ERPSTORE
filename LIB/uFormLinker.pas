unit uFormLinker;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, System.Rtti, System.TypInfo;

type
  TFormLinker = class(TComponent)
  private
    FObjectClassName: string;
    FRegisterFormName: string;

    // Getters
    function GetObjectClassName: string;
    function GetRegisterFormName: string;

    // Setters
    procedure SetObjectClassName(const Value: string);
    procedure SetRegisterFormName(const Value: string);

    // Método para encontrar classes dinamicamente
    function FindClassByName(const ClassName: string): TClass;

  protected
    procedure Loaded; override;

  public
    constructor Create(AOwner: TComponent); override;
    procedure ConfigureOwnerForm;

  published
    property ObjectClassName: string read GetObjectClassName write SetObjectClassName;
    property RegisterFormName: string read GetRegisterFormName write SetRegisterFormName;
  end;

procedure Register;

implementation

uses
  System.SysUtils, Winapi.Windows;

procedure Register;
begin
  RegisterComponents('Base Components', [TFormLinker]);
end;

{ TFormLinker }

constructor TFormLinker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FObjectClassName := '';
  FRegisterFormName := '';
end;

procedure TFormLinker.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) then
    ConfigureOwnerForm;
end;

function TFormLinker.GetObjectClassName: string;
begin
  Result := FObjectClassName;
end;

function TFormLinker.GetRegisterFormName: string;
begin
  Result := FRegisterFormName;
end;

procedure TFormLinker.SetObjectClassName(const Value: string);
begin
  FObjectClassName := Value;
end;

procedure TFormLinker.SetRegisterFormName(const Value: string);
begin
  FRegisterFormName := Value;
end;

function TFormLinker.FindClassByName(const ClassName: string): TClass;
var
  Context: TRttiContext;
  Types: TArray<TRttiType>;
  RttiType: TRttiType;
begin
  Result := nil;

  Context := TRttiContext.Create;
  try
    // Obtém todos os tipos conhecidos pelo RTTI
    Types := Context.GetTypes;

    for RttiType in Types do
    begin
      // Verifica se é uma classe e se o nome corresponde
      if (RttiType.TypeKind = tkClass) and
         (SameText(RttiType.Name, ClassName)) then
      begin
        Result := RttiType.AsInstance.MetaclassType;
        Break;
      end;
    end;
  finally
    Context.Free;
  end;
end;

procedure TFormLinker.ConfigureOwnerForm;
var
  Context: TRttiContext;
  RttiType: TRttiType;
  ObjectClassProp: TRttiProperty;
  RegisterFormProp: TRttiProperty;
  ObjectClassRef: TClass;
  RegisterFormClassRef: TClass;
  OwnerForm: TForm;
begin
  if not Assigned(Owner) or not (Owner is TForm) then
    Exit;

  OwnerForm := TForm(Owner);

  Context := TRttiContext.Create;
  try
    RttiType := Context.GetType(OwnerForm.ClassType);

    ObjectClassProp := RttiType.GetProperty('ObjectClass');
    if not Assigned(ObjectClassProp) then
    begin
      raise Exception.CreateFmt(
        'O form "%s" não possui a propriedade "ObjectClass". ' +
        'Este componente só funciona em forms derivados de TfrmBaseSearch.',
        [OwnerForm.ClassName]
      );
    end;

    // Procura pela propriedade RegisterForm
    RegisterFormProp := RttiType.GetProperty('RegisterForm');
    if not Assigned(RegisterFormProp) then
    begin
      raise Exception.CreateFmt(
        'O form "%s" não possui a propriedade "RegisterForm". ' +
        'Este componente só funciona em forms derivados de TfrmBaseSearch.',
        [OwnerForm.ClassName]
      );
    end;

    if FObjectClassName <> '' then
    begin
      ObjectClassRef := FindClassByName(FObjectClassName);
      if Assigned(ObjectClassRef) then
      begin
        ObjectClassProp.SetValue(OwnerForm, TValue.From(ObjectClassRef))
      end
      else
      begin
        raise Exception.CreateFmt(
          'Classe "%s" não encontrada. Verifique se a unit que contém esta classe ' +
          'está incluída no uses do projeto ou se a classe foi compilada.',
          [FObjectClassName]
        );
      end;
    end;

    // Configura RegisterForm se foi especificado
    if FRegisterFormName <> '' then
    begin
      RegisterFormClassRef := FindClassByName(FRegisterFormName);
      if Assigned(RegisterFormClassRef) then
      begin
        // Verifica se herda de TForm
        if RegisterFormClassRef.InheritsFrom(TForm) then
        begin
          RegisterFormProp.SetValue(OwnerForm, TValue.From(TFormClass(RegisterFormClassRef)));
        end
        else
        begin
          raise Exception.CreateFmt(
            'A classe "%s" não herda de TForm.',
            [FRegisterFormName]
          );
        end;
      end
      else
      begin
        raise Exception.CreateFmt(
          'Classe de form "%s" não encontrada. Verifique se a unit que contém ' +
          'esta classe está incluída no uses do projeto.',
          [FRegisterFormName]
        );
      end;
    end;


  finally
    Context.Free;
  end;
end;

initialization

finalization

end.
