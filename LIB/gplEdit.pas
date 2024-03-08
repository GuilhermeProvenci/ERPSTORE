unit gplEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, gplQry, class_auxi;

type
  TgpEdit = class(TEdit)
  private
    FConf : TAuxi;
  public
    procedure LoadField(const id: string);
  published
    property Conf: TAuxi read FConf write FConf;
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
  if Conf.Table = '' then
    Exit;

  SQL := 'SELECT * FROM ' + Conf.Table;
  if id <> '0' then
    SQL := SQL + ' WHERE id = ' + id;

  qry := TgpQry.Create(Self);
  try
    qry.SQLExec(SQL, []);
    if not qry.IsEmpty then
      Text := qry.FieldByName(Conf.TableFieldName).AsString;
  except
    on E: Exception do
      ShowMessage('Erro ao carregar campo: ' + E.Message);
  end;
  qry.Free;
end;

end.

