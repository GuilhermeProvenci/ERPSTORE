unit gplQry;

interface

uses
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, IniFiles, System.Classes, System.SysUtils;

type
  TConnectionParams = record
    Servidor: string;
    Base: string;
    Porta: string;
    Login: string;
    Senha: string;
  end;

  TgpQry = class(TFDQuery)
  private
    FConnection: TFDConnection;
    FTexto: String;
    FNumero: Real;
    FColumn: TStrings;
    FFieldSize: Integer;
    procedure SetConnection(const Servidor, Base, Porta, Login, Senha: String);
    function GetFieldSize: Integer;
    procedure SetColumn(const Value: TStrings);
    procedure SetFieldSize(const Value: Integer);
    function GetConnectionParamsFromIni: TConnectionParams;
    procedure SetConnectionFromIni;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SQLExec(const ASQL: string; const AParams: array of Variant) ;
  published
    property Texto: String read FTexto write FTexto;
    property Numero: Real read FNumero write FNumero;
    property Column: TStrings read FColumn write SetColumn;
    property FieldSize: Integer read GetFieldSize write SetFieldSize;
  end;

procedure Register;

implementation

uses
  Vcl.Dialogs, FireDAC.Stan.Param, unit_funcoes, System.Math;

procedure Register;
begin
  RegisterComponents('GPL', [TgpQry]);
end;

{ TgpQry }

constructor TgpQry.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FConnection := TFDConnection.Create(Self);
  SetConnectionFromIni;
  Connection := FConnection;
end;

function TgpQry.GetConnectionParamsFromIni: TConnectionParams;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'ERPSTORE.ini');
  try
    Result.Servidor := IniFile.ReadString('Configuracao', 'Servidor', '');
    Result.Base := IniFile.ReadString('Configuracao', 'Base', '');
    Result.Porta := IniFile.ReadString('Configuracao', 'Porta', '');
    Result.Login := IniFile.ReadString('Acesso', 'Login', '');
    Result.Senha := IniFile.ReadString('Acesso', 'Senha', '');
  finally
    IniFile.Free;
  end;
end;

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

procedure TgpQry.SQLExec(const ASQL: string; const AParams: array of Variant);
var
  I: Integer;
  Param: TFDParam;
  IsSelectQuery: Boolean;
begin
  Close;
  SQL.Clear;
  SQL.Add(ASQL);

  // Adiciona os parâmetros à query, se houver
  for I := 0 to High(AParams) do
  begin
    Param := ParamByName(IntToStr(I + 1)); // parâmetros começando do :1 em vez de :0
    if Assigned(Param) then
    begin
      Param.Value := AParams[I];
    end
    else
    begin
      ShowMessage('Parâmetro ' + IntToStr(I + 1) + ' não encontrado.');
    end;
  end;

  IsSelectQuery := (Pos('SELECT', UpperCase(ASQL)) > 0) or (Pos('SHOW', UpperCase(ASQL)) > 0);
  try
    if IsSelectQuery then
      Open
    else
      ExecSQL;
  except
    on E: Exception do
      CriarMensagem('ERRO', 'Erro ao executar a consulta: ' + E.Message);
  end;

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

procedure TgpQry.SetConnection(const Servidor, Base, Porta, Login, Senha: String);
begin
  if Assigned(FConnection) then
  begin
    FConnection.Params.Clear;
    FConnection.Params.Add('Server=' + Servidor);
    FConnection.Params.Add('Database=' + Base);
    FConnection.Params.Add('Port=' + Porta);
    FConnection.Params.Add('User_Name=' + Login);
    FConnection.Params.Add('Password=' + Senha);
    FConnection.DriverName := 'MySQL';
    try
      FConnection.Connected := True;
      // possivel erro> Connection property is not set because it's not using a ConnectionName
    except
      on E: Exception do
      begin
        CriarMensagem('ERRO',E.Message );
        Exit;
      end;
    end;
  end;
end;

procedure TgpQry.SetConnectionFromIni;
var
  ConnectionParams: TConnectionParams;
begin
  ConnectionParams := GetConnectionParamsFromIni;

  if Assigned(FConnection) then
  begin
    // parâmetros de conexão
    SetConnection(ConnectionParams.Servidor, ConnectionParams.Base, ConnectionParams.Porta, ConnectionParams.Login, ConnectionParams.Senha);
  end;
end;




end.

