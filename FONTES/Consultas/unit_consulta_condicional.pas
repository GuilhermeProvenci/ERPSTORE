unit unit_consulta_condicional;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_consulta_padrao, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  Tform_consulta_condicional = class(Tform_consulta_padrao)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_consulta_condicional: Tform_consulta_condicional;

implementation

{$R *.dfm}

uses unit_conexao_tabelas;

end.

//arrumar db grid para mostrar o condicional pendente, e nao o cond
