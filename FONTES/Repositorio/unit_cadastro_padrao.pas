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
    edt_id: TEdit;
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
    NomeClass : String;
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
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := form_conexao.FDConnection;
    Query.SQL.Text := 'SELECT * FROM ' + NomeTabela + ' WHERE ID = :ID';
    Query.Params.ParamByName('ID').AsInteger := ID;
    Query.Open;

    for i := 0 to Form.ComponentCount - 1 do
    begin
      if (Form.Components[i].Tag = 99) and  (Form.Components[i] is TEdit)  then
          TEdit(Form.Components[i]).Text := Query.FieldByName((Form.Components[i] as TControl).StyleName).AsString
      else if (Form.Components[i].Tag = 99) and  (Form.Components[i] is TComboBox)  then
          TComboBox(Form.Components[i]).Text := Query.FieldByName((Form.Components[i] as TComboBox).StyleName).AsString
        else if (Form.Components[i].Tag = 99) and (Form.Components[i] is TDateTimePicker) then
          TDateTimePicker(Form.Components[i]).Date := Query.FieldByName(Form.Components[i].Name).AsDateTime;
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
  NomeClass:= 'T' + NomeForm;
  NomeTabela := NomeForm; // Usar o nome que você deu para o from como
                          // nome da tabela (nomear as tabelas seguindo
                          // esse padrão
  limpaEDit(Self);


end;

procedure Tform_cadastro_padrao.FormShow(Sender: TObject);
var
Classe : TClass;
Instancia: TObject;
begin
 if ModoEdicao then
 begin
   edt_id.text:=  ID.ToString;
   CarregarCampos(ID, Self);
   lbl_titulo.Caption := 'EDIÇÃO DE ' + UpperCase(NomeTabela);
   Classe := GetClass(NomeClass);
    if Assigned(Classe) then
    begin
      // Criar uma instância da classe diretamente
      Instancia := Classe.Create;

      try
        begin
        //    ShowMessage('classe criada - teste') ;
        end;

      finally

        Instancia.Free;
      end;

 end;
 end
 else
  maxID(NomeTabela, edt_id);
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
    maxID(NomeTabela, edt_id);
  end;

  CriarMensagem('aviso', 'Registro Salvo com sucesso');
  if FModoEdicao then
  self.close;



end;



end.
