unit unit_consulta_produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_consulta_padrao, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uFormLinker;

type
  Tform_consulta_produtos = class(TfrmBaseSearch)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_consulta_produtos: Tform_consulta_produtos;

implementation

{$R *.dfm}

end.
