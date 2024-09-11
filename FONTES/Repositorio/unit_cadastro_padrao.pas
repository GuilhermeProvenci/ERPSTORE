unit unit_cadastro_padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, gplForm, gplEdit, class_auxi, gplCombo, gplQry,
  class_gplObject;

type
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
    qryGene: TgpQry;
    DataSourceGene: TDataSource;
    procedure btn_fecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnl_salvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CarregarCampos(ID: Integer; Table: string);
    procedure SetClass(const NomeClasse: string);
    procedure InstanceClass;
  private
    { Private declarations }
  protected
    FClasseType: TClass;
    FClasseInstance: TgplObject;

  public
    { Public declarations }
    NomeForm: string;
    NomeTabela: string;
    NomeClass : String;
  end;

var
  form_cadastro_padrao: Tform_cadastro_padrao;


implementation

{$R *.dfm}

uses unit_mensagem, unit_funcoes, unit_conexao, unit_conexao_tabelas,
  Vcl.ComCtrls, System.Rtti;


procedure Tform_cadastro_padrao.btn_fecharClick(Sender: TObject);
begin
 if CriarMensagem('CONFIRMACAO', 'Tem certeza que deseja Sair sem salvar?') = True then
 begin
 qryInsert.close;
 self.Close;
 Self.LogInfo('Fechando Tela: ' + NomeTabela);
 end;
end;

procedure Tform_cadastro_padrao.CarregarCampos(ID: Integer; Table: string);
var
  i: Integer;
  fieldName : string;
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Componente: TComponent;
begin
  qryGene.SQLExec('SELECT * FROM ' + Table + ' WHERE ID = :1', [ID]);

  Contexto := TRttiContext.Create;
  try
    qryGene.First;
    while not qryGene.Eof do
    begin
      for i := 0 to Self.ComponentCount - 1 do
      begin
        Componente := Self.Components[i];
        if (Componente.Tag = 99) then
        begin
          Tipo := Contexto.GetType(Componente.ClassType);

          Propriedade := Tipo.GetProperty('Conf.TableFieldName');
          if Assigned(Propriedade) then
          begin
            fieldName := Propriedade.GetValue(Componente).AsString;
            if Assigned(qryGene.FindField(fieldName)) then
            begin
              if (Componente is TgpEdit) then
                TgpEdit(Componente).Text := qryGene.FieldByName(fieldName).AsString
              else if (Componente is TgpCombo) then
                TgpCombo(Componente).Text := qryGene.FieldByName(fieldName).AsString
              else if (Componente is TDateTimePicker) then
                TDateTimePicker(Componente).Date := qryGene.FieldByName(fieldName).AsDateTime;
            end;
          end;
        end;
      end;
      qryGene.Next;
    end;
  finally
    Contexto.Free;
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
      CarregarCampos(edt_id.Conf.ID, NomeTabela);
      pnl_salvar.Enabled := false;
    end;

    fmEdit:
    begin
        lbl_titulo.Caption := 'EDIÇÃO DE ' + UpperCase(NomeTabela);
        CarregarCampos(edt_id.Conf.ID, NomeTabela);
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

  case FormMode of
    fmView:
      begin
        //
      end;
    fmEdit:
      begin
        ChamarUpdateGenerico(NomeTabela, Self);
      end;
    fmInsert:
      begin
        CarregarCamposClasse(self, FClasseInstance);
        FClasseInstance.SaveObject;
        //ChamarInsertGenerico(NomeTabela, Self);
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

     if Instance.IsInstanceOf(TgplObject) then
      FClasseInstance := TgplObject(Instance.AsObject)
     else
      raise Exception.Create('Não foi possível instanciar Classe da Tela');
  finally
    RttiContext.Free;
  end;
end;


end.
