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
    procedure SetConnection(Servidor, Base, Porta, Login, Senha: String);
    function GetFieldSize: Integer;
    procedure SetColumn(const Value: TStrings);
    procedure SetFieldSize(const Value: Integer);
    function GetConnectionParamsFromIni: TConnectionParams;
    procedure SetConnectionFromIni;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Connection: TFDConnection read FConnection write FConnection;
    property Texto: String read FTexto write FTexto;
    property Numero: Real read FNumero write FNumero;
    property Column: TStrings read FColumn write SetColumn;
    property FieldSize: Integer read GetFieldSize write SetFieldSize;
  end;

procedure Register;

implementation

uses
  Vcl.Dialogs;

procedure Register;
begin
  RegisterComponents('GPL', [TgpQry]);
end;

{ TgpQry }

constructor TgpQry.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Connection := TFDConnection.Create(Self);
  SetConnectionFromIni;
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

procedure TgpQry.SetConnection(Servidor, Base, Porta, Login, Senha: String);
begin
  if Assigned(FConnection) then
  begin
    FConnection.Params.Clear;
    FConnection.Params.Add('Server=' + Servidor);
    FConnection.Params.Add('Database=' + Base);
    FConnection.Params.Add('Port=' + Porta);
    FConnection.Params.Add('User_Name=' + Login);
    FConnection.Params.Add('Password=' + Senha);

    // Configura o DriverName para o MySQL
    FConnection.DriverName := 'MySQL';

    // Conecta ao banco de dados
    try
      FConnection.Connected := True;

      // Se chegou até aqui sem exceções, então a conexão foi bem-sucedida
      Connection := FConnection;
    except
      // Trate qualquer exceção aqui, se necessário
      on E: Exception do
      begin
        // Exemplo de tratamento: exibir a mensagem da exceção
        ShowMessage('Erro na conexão: ' + E.Message);
      end;
    end;
  end;
end;


procedure TgpQry.SetConnectionFromIni;
var
  ConnectionParams: TConnectionParams;
begin
  ConnectionParams := GetConnectionParamsFromIni;

  // Verifica se a propriedade Connection está atribuída e não é nula
  if Assigned(FConnection) then
  begin
    // Configura os parâmetros de conexão
    SetConnection(ConnectionParams.Servidor, ConnectionParams.Base, ConnectionParams.Porta, ConnectionParams.Login, ConnectionParams.Senha);
  end;
end;




end.

