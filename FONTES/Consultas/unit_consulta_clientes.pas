unit unit_consulta_clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_consulta_padrao, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uFormLinker;

type
  Tform_consulta_clientes = class(TfrmBaseSearch)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_consulta_clientes: Tform_consulta_clientes;

implementation

{$R *.dfm}

end.
