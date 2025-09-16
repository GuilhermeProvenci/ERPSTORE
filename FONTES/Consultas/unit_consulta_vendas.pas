unit unit_consulta_vendas;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_consulta_padrao, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uFormLinker,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls;
type
  Tform_consulta_vendas = class(TfrmBaseSearch)
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  form_consulta_vendas: Tform_consulta_vendas;
implementation
{$R *.dfm}
uses unit_conexao_tabelas, unit_conexao;

initialization
  Tform_consulta_vendas.ClassName;

end.
