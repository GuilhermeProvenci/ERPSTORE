unit unit_consulta_padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Comp.Client,
  unit_cadastro_padrao, unit_report, uBaseClass, uFormLinker;

Type
 TBaseObjectClass = class of TBaseObject;

type
  TfrmBaseSearch = class(TForm)
    pnlMain: TPanel;
    pnlTop: TPanel;
    btnClose: TSpeedButton;
    pnlSeparator: TPanel;
    pnlBottom: TPanel;
    lblDoubleClick: TLabel;
    lblDelete: TLabel;
    pnlSearch: TPanel;
    lblText: TLabel;
    edtSearch: TEdit;
    btnReports: TPanel;
    btnInsert: TPanel;
    pnl_dbgrid: TPanel;
    gridRegister: TDBGrid;
    pnlResult: TPanel;
    lblResult: TLabel;
    ds_consulta: TDataSource;
    lblTitle: TLabel;
    TimerArrumaGrid: TTimer;
    FormLinker: TFormLinker;
    procedure btnCloseClick(Sender: TObject);
    procedure gridRegisterDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gridRegisterKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridRegisterTitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure gridRegisterDblClick(Sender: TObject);
    procedure btnRelatoriosClick(Sender: TObject);
    procedure TimerArrumaGridTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
  private
    { Private declarations }
    sSQL : TStrings;
    NomeCampo : String;
    TipoCampo : TFieldType;

    FRegisterForm : TFormClass;
    FObjectClass : TBaseObjectClass;

    function GetRegisterForm: TFormClass;
    procedure SetRegisterForm(const Value: TFormClass);

    function GetObjectClass: TBaseObjectClass;
    procedure SetObjectClass(const Value: TBaseObjectClass);

   protected
    procedure OpenRegisterForm(AMode: TFormMode; AObjectID: Integer = 0);
  public
    { Public declarations }
    property RegisterForm: TFormClass read GetRegisterForm write SetRegisterForm;
    property ObjectClass: TBaseObjectClass read GetObjectClass write SetObjectClass;
  end;

var
  frmBaseSearch: TfrmBaseSearch;

implementation

{$R *.dfm}

uses unit_funcoes, uBaseInterfaces, unit_principal, unit_mensagem;

procedure TfrmBaseSearch.OpenRegisterForm(AMode: TFormMode; AObjectID: Integer = 0);
var
  Form: TfrmBaseRegister;
  ObjectInstance: IBaseRegister;
  BaseObject: TBaseObject;
begin
  if not Assigned(FRegisterForm) then
    raise Exception.Create('RegisterForm não foi definido');
  if not Assigned(FObjectClass) then
    raise Exception.Create('ObjectClass não foi definido');

  BaseObject := nil;
  Form := nil;
  ObjectInstance := nil;

  try
    try
      BaseObject := FObjectClass.Create;

      if (AMode = fmEdit) and (AObjectID > 0) then
        BaseObject.LoadFromID(AObjectID);

      if not Supports(BaseObject, IBaseRegister, ObjectInstance) then
        raise Exception.CreateFmt('A classe %s não implementa IBaseRegister', [FObjectClass.ClassName]);

      Form := TfrmBaseRegister(FRegisterForm.Create(nil));
      Form.OpenObject(ObjectInstance, AMode, AObjectID);
      Form.ShowModal;

      TimerArrumaGrid.Enabled := true;

    except
      on E: Exception do
      begin
        ShowMessage('Erro ao abrir formulário de cadastro: ' + E.Message);
      end;
    end;

  finally
    ObjectInstance := nil;

    if Assigned(Form) then
      Form.Free;

    //NÃO libera BaseObject - a interface já fez isso automatico com o garbageColector (eu acho, nao sei se é ele ou a interface mesmo)
    // if Assigned(BaseObject) then
    //  BaseObject.Free;  <- NUNCA!
  end;
end;

function TfrmBaseSearch.GetObjectClass: TBaseObjectClass;
begin
  Result := FObjectClass;
end;

procedure TfrmBaseSearch.SetObjectClass(const Value: TBaseObjectClass);
begin
  FObjectClass := Value;
end;

function TfrmBaseSearch.GetRegisterForm: TFormClass;
begin
  Result := FRegisterForm;
end;

procedure TfrmBaseSearch.SetRegisterForm(const Value: TFormClass);
begin
  FRegisterForm := Value;
end;

procedure TfrmBaseSearch.btnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmBaseSearch.btnInsertClick(Sender: TObject);
begin
  OpenRegisterForm(fmInsert);
end;

procedure TfrmBaseSearch.btnRelatoriosClick(Sender: TObject);
begin
  frm_report := Tfrm_report.Create(self);
  frm_report.Grid := self.gridRegister;
  frm_report.ShowModal;
  FreeAndNil(frm_report);
end;

procedure TfrmBaseSearch.gridRegisterDblClick(Sender: TObject);
var
  ObjectID: Integer;
begin
  if not ds_consulta.DataSet.IsEmpty then
  begin
    ObjectID := ds_consulta.DataSet.FieldByName('ID').AsInteger;
    OpenRegisterForm(fmEdit, ObjectID);
  end;
end;

procedure TfrmBaseSearch.gridRegisterDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  prcDrawColumnCell( Sender, Rect, DataCol, Column, State );
end;

procedure TfrmBaseSearch.gridRegisterKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  //se pressionou a tecla delete dentro do dbgrid entao chama o delete do dataset
  if ( Key = VK_DELETE ) and ( not ( ds_consulta.DataSet.IsEmpty ) ) and
     ( CriarMensagem(mtConfirmacao,'Tem Certeza que deseja EXCLUIR essa Informação?') ) then
    ds_consulta.DataSet.Delete;
end;

procedure TfrmBaseSearch.gridRegisterTitleClick(Column: TColumn);
var
  Query: TFDQuery;
  Key: Word;
begin
  if ds_consulta.DataSet = nil then
    Exit;

  Query := ds_consulta.DataSet as TFDQuery;

  if (NomeCampo <> '') and (NomeCampo <> Column.FieldName) then
  begin
    edtSearch.Clear;
    Key := VK_RETURN;
    edtSearchKeyDown(edtSearch, Key, []);
  end;

  NomeCampo := Column.FieldName;
  TipoCampo := Column.Field.DataType;

  prc_pintar_titulo_coluna(gridRegister, Column);
  lblText.Caption := 'Digite o(a) ' + Column.Title.Caption +
                      ' que deseja encontrar e aperte ENTER.';

  if Query.IsEmpty then
    Exit;

  if Query.IndexFieldNames = Column.FieldName then
    Query.IndexFieldNames := Column.FieldName + ':D'
  else
    Query.IndexFieldNames := Column.FieldName;

  Query.First;
  prc_ajusta_tamanho_linha(gridRegister);
end;

procedure TfrmBaseSearch.edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  sWhere, sFiltro: string;
  Query: TFDQuery;
  TextoFiltro: string;
begin
  if Key <> VK_RETURN then
    Exit;

  if ds_consulta.DataSet = nil then
    Exit;

  Query := ds_consulta.DataSet as TFDQuery;
  Query.Close;
  Query.SQL.Clear;
  Query.SQL.AddStrings(sSql);

  if TipoCampo = ftInteger then
    edtSearch.Text := SomenteNumeros(edtSearch.Text);

  TextoFiltro := Trim(edtSearch.Text);
  if TextoFiltro = '' then
  begin
    Query.Open;
    Query.IndexFieldNames := NomeCampo;
    Query.First;
    prc_ajustar_colunas_grid(gridRegister);
    prc_ajusta_tamanho_linha(gridRegister);
    Exit;
  end;

  if Pos('WHERE', AnsiUpperCase(Query.SQL.Text)) > 0 then
    sWhere := ' AND '
  else
    sWhere := ' WHERE ';

  if (TipoCampo = ftInteger) or (TipoCampo = ftDate) then
    sFiltro := sWhere + NomeCampo + ' = :TEXTO '
  else
    sFiltro := sWhere + NomeCampo + ' LIKE :TEXTO ';

  Query.SQL.Add(sFiltro);
  if (TipoCampo = ftInteger) or (TipoCampo = ftDate) then
    Query.ParamByName('TEXTO').AsString := TextoFiltro
  else
    Query.ParamByName('TEXTO').AsString := '%' + TextoFiltro + '%';

  Query.Open;
  Query.IndexFieldNames := NomeCampo;
  Query.First;

  prc_ajustar_colunas_grid(gridRegister);
  prc_ajusta_tamanho_linha(gridRegister);
end;

procedure TfrmBaseSearch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  sSQL.Free;

  if ds_consulta.DataSet <> nil then
    ds_consulta.DataSet.Close;

  if form_principal <> nil then
    form_principal.prc_controla_menu (True);
end;

procedure TfrmBaseSearch.FormCreate(Sender: TObject);
begin
  //Criar um objeto visual em tela que receba uma classee e um form, pra eu nao precisar colocar manualmente no create de cada form
  //a classe e o form de cadastro dele, ai aqui eu posso pegar do componente e settar o Self.ObjectClass e o Self.RegisterForm

  sSQL := TStringList.Create;
  sSQL.Assign( ( ds_consulta.DataSet as TFDQuery ).SQL );

  gridRegisterTitleClick(gridRegister.Columns[0] );

   if ds_consulta.DataSet <> nil then
    ds_consulta.DataSet.active:= true;
end;

procedure TfrmBaseSearch.FormShow(Sender: TObject);
begin
 TimerArrumaGrid.Enabled := True;
end;

procedure TfrmBaseSearch.TimerArrumaGridTimer(Sender: TObject);
var
  Key: Word;
begin
  TimerArrumaGrid.Enabled := false;
  Key := VK_RETURN;
    edtSearchKeyDown(Self, Key, []);
end;

initialization

end.
