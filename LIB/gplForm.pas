unit gplForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormState = (fsView, fsEdit, fsInsert);
  TgpForm = class(TForm)
  private
    FTexto: string;
    FNumero: Real;
    FFormState: TFormState;

  public
    property Texto: string read FTexto write FTexto;
    property Numero: Real read FNumero write FNumero;

  published
    property FormState: TFormState read FFormState write FFormState;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GPL', [TgpForm]);
end;

{ TgpForm }


end.

