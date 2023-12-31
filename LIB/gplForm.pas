unit gplForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormState = (fsView, fsEdit, fsInsert);

  TLogEventType = (etInfo, etWarning, etError);
  TLogEvent = procedure(Sender: TObject; EventType: TLogEventType; const Message: string) of object;

  TgpForm = class(TForm)
  private
    FTexto: string;
    FNumero: Real;
    FFormState: TFormState;
    FOnLog: TLogEvent;

    procedure Log(EventType: TLogEventType; const Message: string);
  public
    property Texto: string read FTexto write FTexto;
    property Numero: Real read FNumero write FNumero;

    procedure LogInfo(const Message: string);
    procedure LogWarning(const Message: string);
    procedure LogError(const Message: string);
    procedure GravaLog(const Message: string);

  published
    property FormState: TFormState read FFormState write FFormState;
    property OnLog: TLogEvent read FOnLog write FOnLog;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GPL', [TgpForm]);
end;

{ TgpForm }

procedure TgpForm.Log(EventType: TLogEventType; const Message: string);
begin
  if Assigned(FOnLog) then
    FOnLog(Self, EventType, Message);
end;

procedure TgpForm.GravaLog(const Message: string);
var
  LogFileName: string;
  LogFile: TextFile;
begin
  LogFileName := ExtractFilePath(ParamStr(0)) + 'ERPSTORE.LOG';

  AssignFile(LogFile, LogFileName);
  try
    if FileExists(LogFileName) then
      Append(LogFile)
    else
      Rewrite(LogFile);

    Writeln(LogFile, Format('[%s] %s: %s', [FormatDateTime('yyyy-mm-dd hh:nn:ss', Now), ClassName, Message]));
  finally
    CloseFile(LogFile);
  end;
end;

procedure TgpForm.LogInfo(const Message: string);
begin
  GravaLog('[INFO] ' + Message);
end;

procedure TgpForm.LogWarning(const Message: string);
begin
  GravaLog('[WARNING] ' + Message);
end;

procedure TgpForm.LogError(const Message: string);
begin
  GravaLog('[ERROR] ' + Message);
end;

end.

