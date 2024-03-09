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
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadField(const id: string);
  published
    property Conf: TAuxi read FConf write FConf;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GPL', [TgpCombo]);
end;

{ TgpCombo }

constructor TgpCombo.Create(AOwner: TComponent);
begin
  inherited;
  FConf := TAuxi.Create;
end;

destructor TgpCombo.Destroy;
begin
  FConf.Free;
  inherited;
end;

procedure TgpCombo.LoadField(const id: string);
var
  SQL: string;
  qry: TgpQry;
begin
  if FConf.Table = '' then
    Exit;

  SQL := 'SELECT * FROM ' + FConf.Table;
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
      if qry.FieldByName(FConf.TableFieldName).AsString <> '' then
        Items.Add(qry.FieldByName(FConf.TableFieldName).AsString);
      qry.Next;
    end;

    if Items.Count > 0 then
      ItemIndex := 0
    else
      ItemIndex := -1;

  finally
    qry.Free;
  end;
end;


end.

