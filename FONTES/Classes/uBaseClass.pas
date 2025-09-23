unit uBaseClass;

interface

uses
  System.SysUtils, System.Classes, uBaseInterfaces, FireDAC.Comp.Client, Data.DB, unit_conexao, System.Rtti;

type
  TBaseObject = class(TInterfacedObject, IBaseRegister)
  private
    FID: Integer;
  protected
    function GetTableName: string; virtual; abstract;
  public
    function GetID: Integer;
    procedure SetID(AID: Integer);

    procedure LoadFromID(AID: Integer);
    procedure Save;
    procedure Delete;
    procedure Validate;
  end;

type
  TBaseObjectClass = class of TBaseObject;

implementation

{ TBaseObject }

function TBaseObject.GetID: Integer;
begin
  Result := FID;
end;

procedure TBaseObject.SetID(AID: Integer);
begin
  FID := AID;
end;

procedure TBaseObject.Validate;
begin
//
end;

procedure TBaseObject.LoadFromID(AID: Integer);
var
  qry: TFDQuery;
  ctx: TRttiContext;
  typ: TRttiType;
  prop: TRttiProperty;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := form_conexao.FDConnection;
    qry.SQL.Text := Format('SELECT * FROM %s WHERE id = :id', [GetTableName]);
    qry.ParamByName('id').AsInteger := AID;
    qry.Open;

    if qry.Eof then Exit;

    ctx := TRttiContext.Create;
    try
      typ := ctx.GetType(Self.ClassType);
      for prop in typ.GetProperties do
      begin
        if prop.IsWritable then
        begin
          if qry.FieldDefs.IndexOf(prop.Name) <> -1 then
            prop.SetValue(Self, TValue.FromVariant(qry.FieldByName(prop.Name).Value));
        end;
      end;
    finally
      ctx.Free;
    end;

    FID := AID;
  finally
    qry.Free;
  end;
end;

procedure TBaseObject.Save;
var
  qry: TFDQuery;
  ctx: TRttiContext;
  typ: TRttiType;
  prop: TRttiProperty;
  fields, values, setFields: string;
begin
  //Todo:
  Validate;

  qry := TFDQuery.Create(nil);
  try
    qry.Connection := form_conexao.FDConnection;

    ctx := TRttiContext.Create;
    try
      typ := ctx.GetType(Self.ClassType);

      // Monta campos e parâmetros
      fields := '';
      values := '';
      setFields := '';

      for prop in typ.GetProperties do
      begin
        if not prop.IsWritable then
          Continue;

        if prop.Name = 'FID' then
          Continue;

        fields := fields + prop.Name + ', ';
        values := values + ':' + prop.Name + ', ';
        setFields := setFields + prop.Name + ' = :' + prop.Name + ', ';
      end;

      // Remove última vírgula
      if fields <> '' then
      begin
        fields := Copy(fields, 1, Length(fields) - 2);
        values := Copy(values, 1, Length(values) - 2);
        setFields := Copy(setFields, 1, Length(setFields) - 2);
      end;

      if FID = 0 then
      begin
        // INSERT
        qry.SQL.Text := Format('INSERT INTO %s (%s) VALUES (%s)', [GetTableName, fields, values]);

        // Agora define os parâmetros
        for prop in typ.GetProperties do
        begin
          if not prop.IsWritable then Continue;
          if prop.Name = 'FID' then Continue;
          qry.ParamByName(prop.Name).Value := prop.GetValue(Self).AsVariant;
        end;

        qry.ExecSQL;

        // Recupera o ID gerado
        qry.SQL.Text := 'SELECT MAX(id) AS NewID FROM ' + GetTableName;
        qry.Open;
        if not qry.Eof then
          FID := qry.FieldByName('NewID').AsInteger;
      end
      else
      begin
        // UPDATE
        qry.SQL.Text := Format('UPDATE %s SET %s WHERE id = :id', [GetTableName, setFields]);

        // Define os parâmetros
        for prop in typ.GetProperties do
        begin
          if not prop.IsWritable then Continue;
          if prop.Name = 'FID' then Continue;
          qry.ParamByName(prop.Name).Value := prop.GetValue(Self).AsVariant;
        end;
        qry.ParamByName('id').Value := FID;

        qry.ExecSQL;
      end;

    finally
      ctx.Free;
    end;
  finally
    qry.Free;
  end;
end;

procedure TBaseObject.Delete;
var
  qry: TFDQuery;
begin
  if FID = 0 then Exit;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := form_conexao.FDConnection;
    qry.SQL.Text := Format('DELETE FROM %s WHERE id = :id', [GetTableName]);
    qry.ParamByName('id').AsInteger := FID;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

end.

