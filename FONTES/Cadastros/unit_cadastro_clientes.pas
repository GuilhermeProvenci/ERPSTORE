unit unit_cadastro_clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_cadastro_padrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls;

type
  Tform_cadastro_clientes = class(Tform_cadastro_padrao)
    qryCondicional: TFDQuery;
    cbb_classificacao: TComboBox;
    Label1: TLabel;
    procedure pnl_salvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_cadastro_clientes: Tform_cadastro_clientes;

implementation

{$R *.dfm}

uses unit_conexao, unit_funcoes;

procedure Tform_cadastro_clientes.pnl_salvarClick(Sender: TObject);
  var DataDevolucao : TDateTime;
begin
 // inherited;
 // só está sem o inherited até arrumar o classe, para puxar as informações dela
 ValidarCampoObrigatorios(Self);

  case FormState of
    fsView:
      begin
        //
      end;
    fsEdit:
      begin
        ChamarUpdateGenerico(NomeTabela, Self);
      end;
    fsInsert:
      begin
        ChamarInsertGenerico(NomeTabela, Self);
        LimpaEdit(Self);
        MaxID(NomeTabela, edt_id);
      end;
  end;

  DataDevolucao := Date + 3;
  with qryCondicional do
    begin
      close;
      ParamByName('1').Value:= strtoint(edt_id.Text);
      ParamByName('2').AsDateTime := Now;
      ParamByName('3').AsDateTime := DataDevolucao;
      ParamByName('4').Value:= edt_nome.Text;
      ExecSQL;
    end;

  CriarMensagem('aviso', 'Registro Salvo com sucesso');
  self.Close;
end;

initialization

RegisterClass(Tform_cadastro_clientes);

end.
