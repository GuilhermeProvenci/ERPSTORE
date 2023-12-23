unit gplEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, gplQry;

  type
  TgpEdit = class(TEdit)
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

procedure Register;
begin
  RegisterComponents('GPL', [TgpEdit]);
end;

{ TgpEdit }

procedure TgpEdit.LoadField(id: string);
var
  SQL: string;
  qry : TgpQry;
begin
  if FTable = '' then
    Exit;

  SQL := 'SELECT * FROM ' + FTable;
  if id <> '0' then
    SQL := SQL + ' WHERE id = ' + id
  else
    SQL := SQL + ' WHERE id is not null';

  qry:= TgpQry.Create(self);
  qry.SQLExec(SQL, []);

  self.Text := qry.FieldByName(DataField).AsString;
end;


end.
