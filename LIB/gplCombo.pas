unit gplCombo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, gplQry, class_auxi;

type
  TgpCombo = class(TComboBox)
  private
    FConf : TAuxi;
  public
    procedure LoadField(const id: string);
  published
    property Conf: TAuxi read FConf write FConf;
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
  if Conf.Table = '' then
    Exit;

  SQL := 'SELECT * FROM ' + Conf.Table;
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
      if qry.FieldByName(Conf.TableFieldName).AsString <> '' then
        Items.Add(qry.FieldByName(Conf.TableFieldName).AsString);
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

