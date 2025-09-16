unit unit_cadastro_padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, uBaseInterfaces, System.Rtti,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uBaseClass;

type
  TFormMode = (fmInsert, fmEdit);

  TfrmBaseRegister = class(TForm)
    pnlTop: TPanel;
    lblTitle: TLabel;
    btnClose: TSpeedButton;
    pnlMain: TPanel;
    btnSave: TImage;
    pnlSeparator: TPanel;
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FObjectInstance: IBaseRegister;
    FFormMode: TFormMode;
    FObjectID: Integer;
    procedure SaveObject;
    procedure LoadObjectToForm;
    procedure BindControlsToForm;
    function ValidateForm: Boolean; virtual;
  public
    // MÉTODO REMOVIDO - não precisa mais do método de classe
    // O OpenRegisterForm agora está no TfrmBaseSearch

    procedure OpenObject(AObjectInstance: IBaseRegister; AMode: TFormMode = fmInsert; AObjectID: Integer = 0);
    procedure SetObjectInstance(AInstance: IBaseRegister);
    function GetObjectInstance: IBaseRegister;
    function GetFormMode: TFormMode;
    property FormMode: TFormMode read FFormMode write FFormMode;
  end;

var
  frmBaseRegister: TfrmBaseRegister;

implementation

{$R *.dfm}

uses unit_funcoes, unit_conexao, Vcl.DBCtrls;

// ========================================
// MÉTODO OPENOBJECT - SEM SHOWMODAL
// ========================================
procedure TfrmBaseRegister.OpenObject(AObjectInstance: IBaseRegister; AMode: TFormMode = fmInsert; AObjectID: Integer = 0);
begin
  FObjectInstance := AObjectInstance;
  FFormMode := AMode;
  FObjectID := AObjectID;

  // Atualiza o título baseado no modo
  case FFormMode of
    fmInsert: lblTitle.Caption := lblTitle.Caption + ' - NOVO';
    fmEdit:   lblTitle.Caption := lblTitle.Caption + ' - EDIÇÃO';
  end;

  BindControlsToForm;

  // Só carrega dados se estiver em modo de edição
  if FFormMode = fmEdit then
    LoadObjectToForm;

  // ShowModal será chamado pelo TfrmBaseSearch
end;

// ========================================
// MÉTODOS DE BINDING E CARREGAMENTO (mantidos)
// ========================================
procedure TfrmBaseRegister.BindControlsToForm;
var
  ctx: TRttiContext;
  typ: TRttiType;
  prop: TRttiProperty;
  ctrl: TComponent;
  obj: TObject;
begin
  if FObjectInstance = nil then
    Exit;

  obj := FObjectInstance as TObject;
  ctx := TRttiContext.Create;
  try
    typ := ctx.GetType(obj.ClassType);
    for prop in typ.GetProperties do
    begin
      // Bind TEdit
      ctrl := FindComponent('edt' + prop.Name);
      if Assigned(ctrl) and (ctrl is TEdit) then
        TEdit(ctrl).Tag := 1;

      // Bind qualquer ComboBox (TComboBox, TDBComboBox, TDBLookupComboBox, etc.)
      ctrl := FindComponent('cmb' + prop.Name);
      if Assigned(ctrl) and ctrl.InheritsFrom(TCustomComboBox) then
        TCustomComboBox(ctrl).Tag := 1;
    end;
  finally
    ctx.Free;
  end;
end;

procedure TfrmBaseRegister.LoadObjectToForm;
var
  ctx: TRttiContext;
  typ: TRttiType;
  prop: TRttiProperty;
  ctrl: TWinControl;
  cmbCtrl: TComboBox;
  obj: TObject;
  propValue: string;
begin
  if FObjectInstance = nil then Exit;

  obj := FObjectInstance as TObject;
  ctx := TRttiContext.Create;
  try
    typ := ctx.GetType(obj.ClassType);
    for prop in typ.GetProperties do
    begin
      propValue := prop.GetValue(obj).ToString;

      // Load TEdit
      ctrl := FindComponent('edt' + prop.Name) as TWinControl;
      if Assigned(ctrl) and (ctrl is TEdit) then
        TEdit(ctrl).Text := propValue;

      // Load TComboBox
      cmbCtrl := FindComponent('cmb' + prop.Name) as TComboBox;
      if Assigned(cmbCtrl) then
        cmbCtrl.ItemIndex := cmbCtrl.Items.IndexOf(propValue);
    end;
  finally
    ctx.Free;
  end;
end;

function TfrmBaseRegister.ValidateForm: Boolean;
begin
  Result := True;

  case FFormMode of
    fmInsert:
    begin
      if not CriarMensagem('CONFIRMACAO', 'Confirma a inclusão do novo registro?') then
        Result := False;
    end;
    fmEdit:
    begin
      if not CriarMensagem('CONFIRMACAO', 'Confirma as alterações realizadas?') then
        Result := False;
    end;
  end;
end;

procedure TfrmBaseRegister.SaveObject;
var
  ctx: TRttiContext;
  typ: TRttiType;
  prop: TRttiProperty;
  ctrl: TComponent;
  obj: TObject;
  val: TValue;
  typKind: TTypeKind;
  s: string;
  v: Variant;
begin
  if FObjectInstance = nil then Exit;
  if not ValidateForm then Exit;

  obj := FObjectInstance as TObject;
  ctx := TRttiContext.Create;
  try
    typ := ctx.GetType(obj.ClassType);

    for prop in typ.GetProperties do
    begin
      // Qualquer Edit (TEdit, TLabeledEdit, TMaskEdit, etc.)
      ctrl := FindComponent('edt' + prop.Name);
      if Assigned(ctrl) and ctrl.InheritsFrom(TCustomEdit) then
      begin
        s := TCustomEdit(ctrl).Text;
        typKind := prop.PropertyType.TypeKind;

        case typKind of
          tkUString, tkString, tkLString, tkWString: val := s;
          tkInteger: val := StrToIntDef(s, 0);
          tkFloat: val := StrToFloatDef(s, 0);
          tkEnumeration:
            if prop.PropertyType.Handle = TypeInfo(Boolean) then
              val := SameText(s, 'true')
            else
              Continue;
          else Continue;
        end;

        prop.SetValue(obj, val);
      end;

      // Qualquer ComboBox (TComboBox, TDBComboBox, TDBLookupComboBox, etc.)
      ctrl := FindComponent('cmb' + prop.Name);
      if Assigned(ctrl) then
      begin
        if ctrl.InheritsFrom(TDBLookupComboBox) then
        begin
          v := TDBLookupComboBox(ctrl).KeyValue; // valor real do lookup
          val := TValue.FromVariant(v);
        end
        else if ctrl.InheritsFrom(TCustomComboBox) then
        begin
          if TCustomComboBox(ctrl).ItemIndex >= 0 then
            s := TCustomComboBox(ctrl).Items[TCustomComboBox(ctrl).ItemIndex]
          else
            s := '';

          typKind := prop.PropertyType.TypeKind;
          case typKind of
            tkUString, tkString, tkLString, tkWString: val := s;
            tkInteger: val := StrToIntDef(s, 0);
            tkFloat: val := StrToFloatDef(s, 0);
            tkEnumeration:
              if prop.PropertyType.Handle = TypeInfo(Boolean) then
                val := SameText(s, 'true')
              else
                Continue;
            else Continue;
          end;
        end
        else
          Continue;

        prop.SetValue(obj, val);
      end;
    end;

    FObjectInstance.Save;

    case FFormMode of
      fmInsert: CriarMensagem('AVISO', 'Registro incluído com sucesso');
      fmEdit:   CriarMensagem('AVISO', 'Registro alterado com sucesso');
    end;

    Self.Close;

  finally
    ctx.Free;
  end;
end;


procedure TfrmBaseRegister.SetObjectInstance(AInstance: IBaseRegister);
begin
  FObjectInstance := AInstance;
end;

procedure TfrmBaseRegister.btnCloseClick(Sender: TObject);
var
  mensagem: string;
begin
  case FFormMode of
    fmInsert: mensagem := 'Tem certeza que deseja sair sem incluir o registro?';
    fmEdit:   mensagem := 'Tem certeza que deseja sair sem salvar as alterações?';
  end;

  if CriarMensagem('CONFIRMACAO', mensagem) = True then
    Self.Close;
end;

procedure TfrmBaseRegister.btnSaveClick(Sender: TObject);
begin
  SaveObject;
end;

procedure TfrmBaseRegister.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FObjectInstance := nil;
  Action := caHide;
end;

function TfrmBaseRegister.GetObjectInstance: IBaseRegister;
begin
  Result := FObjectInstance;
end;

function TfrmBaseRegister.GetFormMode: TFormMode;
begin
  Result := FFormMode;
end;

end.
