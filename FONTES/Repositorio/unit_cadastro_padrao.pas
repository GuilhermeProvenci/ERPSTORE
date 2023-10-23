unit unit_cadastro_padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  Tform_cadastro_padrao = class(TForm)
    pnl_fundo: TPanel;
    lbl_informacao: TLabel;
    lbl_CODIGO: TLabel;
    lbl_informacao2: TLabel;
    lbl_informacao3: TLabel;
    lbl_informacao4: TLabel;
    pnl_topo: TPanel;
    lbl_titulo: TLabel;
    btn_fechar: TSpeedButton;
    pnl_separador_topo: TPanel;
    edt_codigo: TEdit;
    edt_nome: TEdit;
    edt_3: TEdit;
    edt_4: TEdit;
    pnl_salvar: TPanel;
    Image1: TImage;
    qryInsert: TFDQuery;
    procedure btn_fecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnl_salvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CarregarCampos(ID: Integer; Form: TForm);
  private
    { Private declarations }
    FModoEdicao: Boolean;
    FID: Integer;

  public
    { Public declarations }
    property ID: Integer read FID write FID;
    property ModoEdicao: Boolean read FModoEdicao write FModoEdicao;
  end;

var
  form_cadastro_padrao: Tform_cadastro_padrao;
  var
  NomeForm: string;
  NomeTabela: string;

implementation

{$R *.dfm}

uses unit_mensagem, unit_funcoes, unit_conexao, unit_conexao_tabelas,
  Vcl.ComCtrls;

procedure Tform_cadastro_padrao.btn_fecharClick(Sender: TObject);
begin
 if CriarMensagem('DELETE', 'Tem certeza que deseja Sair sem salvar?') = True then
 begin
 qryInsert.close;
 self.Close;
 end;



end;

procedure Tform_cadastro_padrao.CarregarCampos(ID: Integer; Form: TForm);
var
  Query: TFDQuery;
  i: Integer;
  Control: TControl;
begin
  // Obtenha o nome da tabela com base no nome do formulário
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := form_conexao.FDConnection;

    // Execute a consulta SQL para obter os valores dos campos com base no ID
    Query.SQL.Text := 'SELECT * FROM ' + NomeTabela + ' WHERE ID = :ID';
    Query.Params.ParamByName('ID').AsInteger := ID;
    Query.Open;

    // Preencha os controles no formulário com as tags 99
    for i := 0 to Form.ControlCount - 1 do
    begin
     // if Form.Controls[i] is TControl then
      //begin
      //  Control := TControl(Form.Components[i]);
        if (Form.Controls[i].Tag = 99) then
        begin
            if Form.Controls[i] is TEdit then
              TEdit(Form.Controls[i]).Text := Query.Fields[i].AsString
            else if Form.Controls[i] is TDateTimePicker then
              TDateTimePicker(Form.Controls[i]).Date := Query.Fields[i].AsDateTime;
        end;
      //end;
    end;
  finally
    Query.Free;
  end;
end;





procedure Tform_cadastro_padrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//FreeAndNil(Self);
action := caFree;
self := Nil;
end;

procedure Tform_cadastro_padrao.FormCreate(Sender: TObject);

begin

  NomeForm := Self.Name;
  Delete(NomeForm, 1, Length('form_cadastro_')); // Remove 'form_cadastro_'

  NomeTabela := NomeForm; // Usar o nome que você deu para o from como
                          // nome da tabela (nomear as tabelas seguindo
                          // esse padrão
  limpaEDit(Self);


end;

procedure Tform_cadastro_padrao.FormShow(Sender: TObject);
begin
 if ModoEdicao then
 begin
//   edt_codigo.text:=  ID.ToString
   CarregarCampos(ID, Self);
   lbl_titulo.Caption := 'EDIÇÃO DE ' + UpperCase(NomeTabela);
 end
 else
  maxID(NomeTabela, edt_codigo);
end;

procedure Tform_cadastro_padrao.pnl_salvarClick(Sender: TObject);
begin
  ValidarCampoObrigatorios(Self);

  if FModoEdicao then
  begin
    ChamarUpdateGenerico(NomeTabela, self);
  end
  else
  begin
    ChamarInsertGenerico(NomeTabela, self);
    limpaEDit(Self);
    maxID(NomeTabela, edt_codigo);
  end;

  CriarMensagem('aviso', 'Registro Salvo com sucesso');
end;



end.
