unit class_gplObject;

interface

uses
  System.Classes, System.Rtti, FireDAC.Comp.Client, System.SysUtils, gplQry;

type
  TgplObject = class(TPersistent)
  private
    FTable: string;
    function GetTable : string;
  public
    function SaveObject: boolean;
    procedure CarregarCampos(ID: string);
  published
    property Table: string read GetTable;
  end;

implementation

function TgplObject.GetTable: string;
begin
  Result := ClassName;
  if Result.StartsWith('T') then
    Delete(Result, 1, 1);
end;

function TgplObject.SaveObject: boolean;
var
  Context: TRttiContext;
  RttiType, CamposType: TRttiType;
  Prop: TRttiProperty;
  CamposProp: TRttiProperty;
  SQL: string;
  Values, Fields: string;
  Query: TgpQry;
  CamposInstance: TObject;
begin
  Context := TRttiContext.Create;
  try
    RttiType := Context.GetType(Self.ClassType);
    Fields := '';
    Values := '';

    // Procura a propriedade chamada "Campos" que contém a instância da classe _C
    Prop := RttiType.GetProperty('Campos');
    if Assigned(Prop) and (Prop.PropertyType.TypeKind = tkClass) then
    begin
      CamposInstance := Prop.GetValue(Self).AsObject;

      if Assigned(CamposInstance) then
      begin
        CamposType := Context.GetType(CamposInstance.ClassType);

        for CamposProp in CamposType.GetProperties do
        begin
          if CamposProp.IsWritable then
          begin
            Fields := Fields + CamposProp.Name + ', ';
            Values := Values + QuotedStr(CamposProp.GetValue(CamposInstance).ToString) + ', ';
          end;
        end;
      end;
    end;

    SetLength(Fields, Length(Fields) - 2);
    SetLength(Values, Length(Values) - 2);


    SQL := Format('INSERT INTO %s (%s) VALUES (%s)', [FTable, Fields, Values]);

    Query := TgpQry.Create(nil);
    try
      Query.SQL.Text := SQL;
      Query.ExecSQL;
    finally
      Query.Free;
    end;

    Result := True;
  finally
    Context.Free;
  end;
end;


procedure TgplObject.CarregarCampos(ID: string);
var
  Contexto: TRttiContext;
  Propriedade: TRttiProperty;
  Query: TgpQry;
  RttiType: TRttiType;
  PropName: string;
  PropValue: TValue;
  CamposObj: TObject;
begin
  Contexto := TRttiContext.Create;
  try
    RttiType := Contexto.GetType(Self.ClassType);
    Propriedade := RttiType.GetProperty('Campos');
    if not Assigned(Propriedade) then
      raise Exception.Create('Propriedade "Campos" não encontrada na classe.');

    CamposObj := Propriedade.GetValue(Self).AsObject;

    if not Assigned(CamposObj) then
      raise Exception.Create('Objeto "Campos" não inicializado.');

    // Cria e executa uma query para buscar os dados pelo ID
    Query := TgpQry.Create(nil);
    try
      Query.SQL.Text := Format('SELECT * FROM %s WHERE ID = :ID', [Table]);
      Query.ParamByName('ID').AsString := ID;
      Query.Open;

      if not Query.Eof then
      begin
        // Itera sobre as propriedades da classe de campos (_C) e define seus valores com base no resultado da query
        for Propriedade in Contexto.GetType(CamposObj.ClassType).GetProperties do
        begin
          PropName := Propriedade.Name;
          if Query.FieldDefs.IndexOf(PropName) <> -1 then
          begin
            case Propriedade.PropertyType.TypeKind of
              tkInteger:
                PropValue := Query.FieldByName(PropName).AsInteger;
              tkFloat:
                PropValue := Query.FieldByName(PropName).AsFloat;
              tkString, tkUString, tkWString, tkLString:
                PropValue := Query.FieldByName(PropName).AsString;
              // Outros tipos podem ser adicionados conforme necessário
            else
              Continue;
            end;

            Propriedade.SetValue(CamposObj, PropValue);
          end;
        end;
      end
      else
        raise Exception.Create('Nenhum registro encontrado para o ID: ' + ID);
    finally
      Query.Free;
    end;
  finally
    Contexto.Free;
  end;
end;

end.

