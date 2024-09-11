unit class_gplObject;

interface

uses
  System.Classes, System.Rtti, FireDAC.Comp.Client, System.SysUtils, gplQry;

type
  // Atributo personalizado para marcar propriedades persistentes
  TPersistente = class(TCustomAttribute)
  end;

  TgplObject = class(TPersistent)
  private
    FTable: string;
  public
    function SaveObject: boolean;
  published
    property Table: string read FTable write FTable;
  end;

implementation

function TgplObject.SaveObject: boolean;
var
  Context: TRttiContext;
  RttiType: TRttiType;
  Prop: TRttiProperty;
  SQL: string;
  Values, Fields: string;
  Query: TgpQry;
  Attribute: TCustomAttribute;
begin
  Context := TRttiContext.Create;
  try
    RttiType := Context.GetType(Self.ClassType);
    Fields := '';
    Values := '';
    for Prop in RttiType.GetProperties do
    begin
      // Verifica se a propriedade é gravável e possui o atributo TPersistente
      if Prop.IsWritable then
      begin
        for Attribute in Prop.GetAttributes do
        begin
          if Attribute is TPersistente then
          begin
            Fields := Fields + Prop.Name + ', ';
            Values := Values + QuotedStr(Prop.GetValue(Self).ToString) + ', ';
            Break;  // Propriedade encontrada com o atributo, sair do loop
          end;
        end;
      end;
    end;

    // Remove a última vírgula
    SetLength(Fields, Length(Fields) - 2);
    SetLength(Values, Length(Values) - 2);

    // Constrói a instrução SQL de inserção
    SQL := Format('INSERT INTO %s (%s) VALUES (%s)', [FTable, Fields, Values]);

    // Executa a SQL
    Query := TgpQry.Create(nil);
    try
      Query.SQL.Text := SQL;
      Query.ExecSQL;
    finally
      Query.Free;
    end;
  finally
    Context.Free;
  end;
end;

end.

