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
    property DataField: string read FDataField write FDataField;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GPL', [TgpEdit]);
end;

{ TgpEdit }

procedure TgpEdit.LoadField(const id: string);
var
  SQL: string;
  qry: TgpQry;
begin
  if FTable = '' then
    Exit;

  SQL := 'SELECT * FROM ' + FTable;
  if id <> '0' then
    SQL := SQL + ' WHERE id = ' + id;

  qry := TgpQry.Create(Self);
  try
    qry.SQLExec(SQL, []);
    if not qry.IsEmpty then
      Text := qry.FieldByName(DataField).AsString;
  except
    on E: Exception do
      ShowMessage('Erro ao carregar campo: ' + E.Message);
  end;
  qry.Free;
end;

end.

