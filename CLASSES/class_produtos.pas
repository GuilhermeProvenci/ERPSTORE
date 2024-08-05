unit class_produtos;

interface

uses
  System.Classes, FireDAC.Comp.Client, System.SysUtils, VCL.Forms;

type
  TProdutos = class(TComponent)
  private
    FID: Integer;
    FNome: string;
  public
    constructor Create(form : Tform);
    property Nome: string read FNome;
    end;

implementation

{ TProdutos }

uses
  gplEdit, Vcl.Dialogs;

constructor TProdutos.Create(form : Tform);
begin
  inherited Create(nil);

end;


initialization
  RegisterClass(TProdutos);

end.
