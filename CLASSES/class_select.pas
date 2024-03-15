unit ObjetoSelect;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, Vcl.Dialogs;

type
  TJoinType = (jtInner, jtLeft, jtRight);

  TJoin = class
  private
    FTable: string;
    FCondition: string;
    FJoinType: TJoinType;
  public
    constructor Create(const Table, Condition: string; JoinType: TJoinType = jtInner);
    property Table: string read FTable write FTable;
    property Condition: string read FCondition write FCondition;
    property JoinType: TJoinType read FJoinType write FJoinType;
  end;

  TObjetoSelect = class
  private
    FTabela: string;
    FCampos: TArray<string>;
    FWhere: TList<string>;
    FGroupBy: TList<string>;
    FOrderBy: string;
    FHaving: string;
    FJoins: TObjectList<TJoin>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Select;
    procedure AddJoin(const Table, Condition: string; JoinType: TJoinType = jtInner);
    property Tabela: string read FTabela write FTabela;
    property Campos: TArray<string> read FCampos write FCampos;
    property Where: TList<string> read FWhere;
    property GroupBy: TList<string> read FGroupBy;
    property OrderBy: string read FOrderBy write FOrderBy;
    property Having: string read FHaving write FHaving;
  end;

implementation

{ TJoin }

constructor TJoin.Create(const Table, Condition: string; JoinType: TJoinType);
begin
  FTable := Table;
  FCondition := Condition;
  FJoinType := JoinType;
end;

{ TObjetoSelect }

constructor TObjetoSelect.Create;
begin
  FWhere := TList<string>.Create;
  FGroupBy := TList<string>.Create;
  FJoins := TObjectList<TJoin>.Create;
end;

destructor TObjetoSelect.Destroy;
begin
  FWhere.Free;
  FGroupBy.Free;
  FJoins.Free;
  inherited;
end;

procedure TObjetoSelect.Select;
var
  i: Integer;
  SQL: string;
begin
  if (Tabela = '') or (Length(Campos) = 0) then
    raise Exception.Create('Tabela e Campos são obrigatórios para a consulta.');

  SQL := 'SELECT ';

  for i := 0 to Length(Campos) - 1 do
  begin
    SQL := SQL + Campos[i];
    if i < Length(Campos) - 1 then
      SQL := SQL + ', ';
  end;

  SQL := SQL + sLineBreak +' FROM ' + Tabela;

  for i := 0 to FJoins.Count - 1 do
  begin
    case FJoins[i].JoinType of
      jtInner: SQL := SQL + sLineBreak + ' INNER JOIN ';
      jtLeft: SQL := SQL + sLineBreak +' LEFT JOIN ';
      jtRight: SQL := SQL + sLineBreak +' RIGHT JOIN ';
    end;
    SQL := SQL + FJoins[i].Table + ' ON ' + FJoins[i].Condition;
  end;

  if Where.Count > 0 then
  begin
    SQL := SQL + sLineBreak +' WHERE ';
    for i := 0 to Where.Count - 1 do
    begin
      SQL := SQL + Where[i];
      if i < Where.Count - 1 then
        SQL := SQL + sLineBreak +' AND ';
    end;
  end;

  if GroupBy.Count > 0 then
  begin
    SQL := SQL +sLineBreak + ' GROUP BY ';
    for i := 0 to GroupBy.Count - 1 do
    begin
      SQL := SQL + GroupBy[i];
      if i < GroupBy.Count - 1 then
        SQL := SQL + ', ';
    end;
  end;

  if Having <> '' then
    SQL := SQL + sLineBreak +' HAVING ' + Having;

  if OrderBy <> '' then
    SQL := SQL + sLineBreak +' ORDER BY ' + OrderBy;
  ShowMessage(SQL);
end;

procedure TObjetoSelect.AddJoin(const Table, Condition: string; JoinType: TJoinType);
begin
  FJoins.Add(TJoin.Create(Table, Condition, JoinType));
end;

end.

