program GeradorClasses;

uses
  Vcl.Forms,
  Main in 'Source\Main.pas' {frmGeradorClasses};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmGeradorClasses, frmGeradorClasses);
  Application.Run;
end.
