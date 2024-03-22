unit unit_classGenerator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrmClassGenerator = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmClassGenerator: TFrmClassGenerator;

implementation

{$R *.dfm}

uses class_Generator;

procedure TFrmClassGenerator.Button1Click(Sender: TObject);
var
  ComponentName, BaseClassName, GeneratedCode: string;
begin

  ComponentName := 'TMyComponent';
  BaseClassName := 'TButton';


  GeneratedCode := TComponentGenerator.GenerateComponentUnit(ComponentName, BaseClassName);

  Memo1.Text := GeneratedCode;
end;

end.
