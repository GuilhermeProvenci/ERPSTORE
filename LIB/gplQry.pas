unit gplQry;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TgpQry = class(TFDQuery)
  private
      FTexto    : String;
      FNumero   : Real;
      FColumn   : TStrings;
      FFieldSize : Integer;
    function GetFieldSize: Integer;
    procedure SetColumn(const Value: TStrings);
    procedure SetFieldSize(const Value: Integer);
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    property Texto   : String   read FTexto    write FTexto;
    property Numero  : Real     read FNumero   write FNumero;
    property Column  : TStrings read FColumn   write SetColumn;
    property FieldSize: Integer  read GetFieldSize write SetFieldSize;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GPL', [TgpQry]);
end;

{ TgpQry }

function TgpQry.GetFieldSize: Integer;
begin
   if FFieldSize = 0 then
      Result := 30
    else
      Result := FFieldSize;
end;

procedure TgpQry.SetFieldSize(const Value: Integer);
begin
  FFieldSize := Value;
end;

procedure TgpQry.SetColumn(const Value: TStrings);
begin
    if FColumn.Text <> Value.Text then
    begin
      FColumn.BeginUpdate;
      try
        FColumn.Assign(Value);
      finally
        FColumn.EndUpdate;
      end;
    end;
end;



end.
