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
    FDataFieldName : string;
    FDataField: string;
    FTable : string;
  public
    property Texto: string read FTexto write FTexto;
    property Numero: Real read FNumero write FNumero;
    procedure LoadField(id : string);
  published
    property Table : string read FTable write FTable;
    property DataFieldName: string Read FDataFieldName Write FDataFieldName;
    property DataField: string Read FDataField Write FDataField;
  end;

  procedure Register;

implementation

{ TgpCombo }

procedure Register;
begin
  RegisterComponents('GPL', [TgpCombo]);
end;

procedure TgpCombo.LoadField(id: string);
var
  SQL: string;
  qry: TgpQry;
begin
  if FTable = '' then
    Exit;

  SQL := 'SELECT * FROM ' + FTable;
  if id <> '0' then
    SQL := SQL + ' WHERE id = ' + id
  else
    SQL := SQL + ' WHERE id IS NOT NULL';

  qry := TgpQry.Create(nil);
  try
    qry.SQLExec(SQL, []);

    Items.Clear;

    while not qry.Eof do
    begin
      Items.Add(qry.FieldByName(DataField).AsString);
      qry.Next;
    end;

    if Items.Count > 0 then
      ItemIndex := 0;
  finally
    qry.Free;
  end;
end;


end.


