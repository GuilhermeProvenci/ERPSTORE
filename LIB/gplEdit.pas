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
  RegisterComponents('GPL', [TgpEdit]);
end;

{ TgpEdit }

constructor TgpEdit.Create(AOwner: TComponent);
begin
  inherited;
  FConf := TAuxi.Create;
end;

destructor TgpEdit.Destroy;
begin
  FConf.Free;
  inherited;
end;

procedure TgpEdit.LoadField(const id: string);
var
  SQL: string;
  qry: TgpQry;
begin
  if FConf.Table = '' then
    Exit;

  SQL := 'SELECT * FROM ' + FConf.Table;
  if id <> '0' then
    SQL := SQL + ' WHERE id = ' + id;

  qry := TgpQry.Create(Self);
  try
    qry.SQLExec(SQL, []);
    if not qry.IsEmpty then
      Text := qry.FieldByName(FConf.TableFieldName).AsString;
  except
    on E: Exception do
      ShowMessage('Erro ao carregar campo: ' + E.Message);
  end;
  qry.Free;
end;

end.

