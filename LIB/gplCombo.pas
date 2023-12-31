unit gplCombo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, gplQry;

type
  TgpCombo = class(TComboBox)
  private
    FTexto: string;
    FNumero: Real;
    FDataFieldName: string;
    FDataField: string;
    FTable: string;
  public
    property Texto: string read FTexto write FTexto;
    property Numero: Real read FNumero write FNumero;
    procedure LoadField(const id: string);
  published
    property Table: string read FTable write FTable;
    property DataFieldName: string read FDataFieldName write FDataFieldName;
    // property DataField: string read FDataField write FDataField;
  end;

procedure Register;

implementation

{ TgpCombo }

procedure Register;
begin
  RegisterComponents('GPL', [TgpCombo]);
end;

procedure TgpCombo.LoadField(const id: string);
var
  SQL: string;
  qry: TgpQry;
begin
  if FTable = '' then
    Exit;

  SQL := 'SELECT * FROM ' + FTable;
  if id <> '' then
    SQL := SQL + ' WHERE id = ' + id
  else
    SQL := SQL + ' WHERE id IS NOT NULL';

  qry := TgpQry.Create(nil);
  try
    qry.SQLExec(SQL, []);

    Items.Clear;

    while not qry.Eof do
    begin
      if qry.FieldByName(DataFieldName).AsString <> '' then
        Items.Add(qry.FieldByName(DataFieldName).AsString);
      qry.Next;
    end;

    if Items.Count > 0 then
    begin
      if Items.Count > 0 then
        ItemIndex := 0
      else
        ItemIndex := -1;
    end
    else
      Text := '';

  finally
    qry.Free;
  end;
end;

end.

