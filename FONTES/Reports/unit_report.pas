unit unit_report;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_conexao_tabelas, ppProd, ppClass,
  ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    ppDBPipeline1: TppDBPipeline;
    ppReport1: TppReport;

    procedure Panel2MouseEnter(Sender: TObject);
    procedure Panel2MouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Panel2MouseEnter(Sender: TObject);
begin
      Panel2.Color := clNavy;
      Panel2.Font.Style := [fsBold];
      Panel2.Font.Size := 11;

end;

procedure TForm1.Panel2MouseLeave(Sender: TObject);
begin
      Panel2.Color := $00C08000;
      Panel2.Font.Style := [];
      Panel2.Font.Size := 10;
end;

end.
