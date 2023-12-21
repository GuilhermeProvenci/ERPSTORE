unit gplEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

  type
  TgpEdit = class(TEdit)
  private
    FTexto: string;
    FNumero: Real;
    FDataFieldName : string;
  public
    property Texto: string read FTexto write FTexto;
    property Numero: Real read FNumero write FNumero;
  published
    property DataFieldName: string Read FDataFieldName Write FDataFieldName;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GPL', [TgpEdit]);
end;

end.
