program FormGeneratorProject;

uses
  Vcl.Forms,
  FormGenerator in 'FormGenerator.pas' {frmGeradorFormularios};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmGeradorFormularios, frmGeradorFormularios);
  Application.Run;
end.
