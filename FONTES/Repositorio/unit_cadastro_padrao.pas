unit unit_cadastro_padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, gplForm, gplEdit, class_auxi;

type
  TFormState = (fsView, fsEdit, fsInsert);
  Tform_cadastro_padrao = class(TgpForm)
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
    pnl_salvar: TPanel;
    Image1: TImage;
    qryInsert: TFDQuery;
    edt_nome: TgpEdit;
    edt_3: TgpEdit;
    edt_4: TgpEdit;
    edt_id: TgpEdit;
    procedure btn_fecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnl_salvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CarregarCampos(ID: Integer; Form: TForm);
    procedure SetClass(const NomeClasse: string);
    procedure InstanceClass;
  private
    { Private declarations }
    FID: Integer;
    FFormState: TFormState;
  protected
    FClasseType: TClass;
    FClasseInstance: TObject;

  public
    { Public declarations }

    NomeForm: string;
    NomeTabela: string;
    NomeClass : String;
    property ID: Integer read FID write FID;
    property FormState: TFormState read FFormState write FFormState;
  end;

var
  form_cadastro_padrao: Tform_cadastro_padrao;


implementation

{$R *.dfm}

uses unit_mensagem, unit_funcoes, unit_conexao, unit_conexao_tabelas,
  Vcl.ComCtrls, gplQry, System.Rtti;


procedure Tform_cadastro_padrao.btn_fecharClick(Sender: TObject);
begin
 if CriarMensagem('CONFIRMACAO', 'Tem certeza que deseja Sair sem salvar?') = True then
 begin
 qryInsert.close;
 self.Close;
 Self.LogInfo('Fechando Tela: ' + NomeTabela);
 end;
end;

procedure Tform_cadastro_padrao.CarregarCampos(ID: Integer; Form: TForm);
var
  Query: TgpQry;
  i: Integer;
begin
  Query := TgpQry.Create(Self);
  try
    Query.SQLExec('SELECT * FROM ' + NomeTabela + ' WHERE ID = :1', [ID.ToString]);

    //Query.SQL.Text := 'SELECT * FROM ' + NomeTabela + ' WHERE ID = :ID';
    //Query.Params.ParamByName('ID').AsInteger := ID;
    //Query.Open;

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

 if Assigned(FClasseInstance) then
 FreeAndNil(FClasseInstance);

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

  SetClass(NomeClass);
  InstanceClass;
  Self.LogInfo('Tela de ' + NomeTabela + 'criada com sucesso');
end;

procedure Tform_cadastro_padrao.FormShow(Sender: TObject);
var
  Instancia: TObject;
begin
  case FormMode of
    fmView:
    begin
      CarregarCampos(ID, Self);
      pnl_salvar.Enabled := false;
    end;

    fmEdit:
    begin
        CarregarCampos(ID, Self);
        lbl_titulo.Caption := 'EDIÇÃO DE ' + UpperCase(NomeTabela);
        CarregarCamposClasse(self, FClasseInstance);
    end;

    fmInsert:
    begin
        maxID(NomeTabela, edt_id);
        lbl_titulo.Caption := 'CADASTRO DE ' + UpperCase(NomeTabela);
     end;


  end;
end;


procedure Tform_cadastro_padrao.pnl_salvarClick(Sender: TObject);
begin
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
        CarregarCamposClasse(self, FClasseInstance);
        ChamarInsertGenerico(NomeTabela, Self);
        LimpaEdit(Self);
        MaxID(NomeTabela, edt_id);
      end;
  end;

  CriarMensagem('aviso', 'Registro Salvo com sucesso');
  Self.LogInfo('Inserção na Tabela de ' + NomeTabela + ' realizada com sucesso');
  self.Close;
end;

procedure Tform_cadastro_padrao.SetClass(const NomeClasse: string);
begin
  FClasseType := GetClass(NomeClasse);
  if FClasseType = nil then
  begin
    raise Exception.CreateFmt('Classe %s não encontrada.', [NomeClasse]);
    Self.LogError('Falha no momento de Criar a Classe:' + NomeTabela);
  end;
end;


procedure Tform_cadastro_padrao.InstanceClass; //talvez passar para a unit_funcoes
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  Method: TRttiMethod;
  Instance: TValue;
begin
  if FClasseType = nil then
    Exit;

  RttiContext := TRttiContext.Create;
  try
    RttiType := RttiContext.GetType(FClasseType);
    Method := RttiType.GetMethod('Create');
    if not Assigned(Method) then
      Exit;

    if Length(Method.GetParameters) = 0 then
      Instance := Method.Invoke(RttiType.AsInstance.MetaclassType, [])
    else
      Instance := Method.Invoke(RttiType.AsInstance.MetaclassType, [Self]);

    FClasseInstance := Instance.AsObject;
  finally
    RttiContext.Free;
  end;
end;




end.
