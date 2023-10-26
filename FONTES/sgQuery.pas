unit sgQuery;

interface

uses
  Forms, Windows, Messages, SysUtils, Classes, DB, Dialogs, Controls, ADODb, Variants, DBCommon, Func,
  {$ifdef ERPUNI}
    FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
    FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
    FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
    FireDAC.Comp.Client,
  {$ELSE}
  {$endif}
  WideStrings, MaskUtils, FatExpression, ADOInt, DBIniMemo, DBClient, sgClientDataSet, SConnect;

type
  {$ifdef ERPUNI}
    TParameterDirection = (pdUnknown, pdInput, pdOutput, pdInputOutput, pdReturnValue);
    TADOLockType = (ltBatchOptimistic, ltOptimistic, ltPessimistic, ltReadOnly, ltUnspecified);
  {$endif}

  TsgQuery = class;

  {$ifndef DATASNAP}
    {$ifdef ERPUNI}
      TParameterAttribute = (paSigned, paNullable, paLong);
      TParameterAttributes = set of TParameterAttribute;
      TsgFDParams = class(TFDParams)
      private
        FAttributes: TParameterAttributes;
      published
        property Attributes: TParameterAttributes read FAttributes write FAttributes;
      end;

      TsgQuery = class(TFDQuery)
    {$else}
      TUpdateOptions = class(TPersistent)
      private
        FKeyFields: String;
        FUpdateTableName: String;
      public
      published
        property KeyFields: String read FKeyFields write FKeyFields;
        property UpdateTableName: String read FUpdateTableName write FUpdateTableName;
      end;

      TsgQuery = class(TADOQuery)
    {$ENDIF}
    private
      FConfTabe: TCustomConfTabe;
      FatExpr: TFatExpression;

      FTexto    : String;
      FNumero   : Real;
      FLista    : TStrings;
      FColuna   : TStrings;
      FColunaDBG: TStrings;
      FMonitor  : TStrings;
      FTamaCamp : Integer;
      FExibChav : Boolean;
      HoraInic  : TTime;
      FHoraTota : TTime;
      FRequestLive: Boolean;
      FUpdateMode: TUpdateMode;
      FPBas: Integer;
      FsgState: Integer;
      FTemExpr: Boolean; // Ticket 8924

      FSQL_Back: TWideStrings;
      FSQL_Modi: TWideStrings;

      {$ifdef ERPUNI}
        FBoolean: Boolean;
        FInteger: Integer;
        FCursorType : TCursorType;
        FADOLockType: TADOLockType;
        FParamCheck: Boolean;
      {$else}
        FTransaction: TsgTransaction;
        FUpdateOptions: TUpdateOptions;
        FCachedUpdates: Boolean;
      {$ENDIF}
      FsgTransaction: TsgTransaction;
      procedure SetColuna(Value: TStrings);
      procedure GravMoniFina;
      procedure GravMoniInic;
      function GetPBas: Integer;
      procedure DoFunc(Sender: TObject; Eval: string; Args: array of Variant;ArgCount: Integer; var Value: Variant; var Done: Boolean);
      procedure DoVariable(Sender: TObject; Variable: string; var Value: Variant;var Done: Boolean);
      procedure GetText(Sender: TField; var Text: string; DisplayText: Boolean);
      function GetSQL_Back: TWideStrings;
      function GetSQL_Modi: TWideStrings;
      procedure SetSQL_Back(const Value: TWideStrings);
      procedure SetSQL_Modi(const Value: TWideStrings);

      function GetParamCount: Word;
      {$ifdef ERPUNI}
        function GetDataBaseName: TFDCustomConnection;
        procedure SetBaseName(const Value: TFDCustomConnection);
        function GetParameters: TFDParams;
        procedure SetParameters(const Value: TFDParams);
      {$ELSE}
        function GetDataBaseName: TADOConnection;
        procedure SetBaseName(const Value: TADOConnection);
        function GetParamData: TParameters;
        procedure SetParamData(const Value: TParameters);
      {$ENDIF}

      //retorna o nome da tablea da instrução sql
      function getTableName(const value : String):String;
      {$ifdef ERPUNI}
        function GetConnectionString: String;
        procedure SetConnectionString(const Value: String);
        function GetSort: String;
        procedure SetSort(const Value: String);
      {$ENDIF}
      procedure SetsgTransaction(const Value: TsgTransaction);
      function GetsgTransaction: TsgTransaction;
      function GetTamaCamp: Integer;
    procedure SetTamaCamp(const Value: Integer);
    procedure Ajusta_Filtro(iForca: Boolean = False);
    protected
      function isGeraMoni: Boolean;
      procedure InternalLast; override;

      {$ifndef ERPUNI}
        procedure SetFiltered(Value: Boolean); override;
      {$ENDIF}
      procedure SetActive(Value: Boolean); override;
    public
      constructor Create(AOwner: TComponent); override;
      procedure SetLista(Value: TStrings);
      procedure SetMonitor(Value: TStrings);
      destructor Destroy; override;
      function ExecSQL: Integer;
      procedure FormatFields;
      Function Soma(iCamp: String): Real;
      function ListaIn(iCamp: String): String;
      function Filtra(iFilt: String): Boolean;
      procedure PegaOrigin();
      procedure sgOpen;
      procedure sgClose;
      procedure sgClone(iQry: TDataSet); overload;
      procedure sgClone(iQry: TClientDataSet); overload;
      procedure sgRefresh(iMark: Boolean = False);
      function CriaCampField(Field: TField; DisplayLabel: String = ''; Origin: String = '';
                              Visi: Boolean = False; Tag: Integer = 10; DisplayWidth: Integer = 15;
                              DisplayFormat: String = ',0.00###'; Indi: Integer = 2): TField;
      procedure CriaCampos(iForm: TForm);
      //function ParamByName(const Value: string): TParameter;
      {$ifdef ERPUNI}
        procedure UpdateBatch;
        procedure CancelBatch;
      {$ELSE}
        property Transaction: TsgTransaction read FTransaction write FTransaction;
      {$ENDIF}
      property sgTransaction: TsgTransaction read GetsgTransaction write SetsgTransaction;
      property ConfTabe: TCustomConfTabe read fConfTabe write fConfTabe;
      property ColunaDBG:TStrings read FColunaDBG write fColunaDBG;
  published
      procedure DoBeforeOpen; override;
      procedure DoBeforeClose; override;
      procedure DoAfterOpen; override;
      procedure DoBeforePost; override;
      procedure DoAfterPost; override;
      procedure DoAfterError;
      procedure CriaParameter( iNome: String; iTipo: TFieldType; iDire: TParameterDirection = pdInput; iSize: integer = 0);
      procedure CriaParameter2(iNome: String; iTipo: TFieldType; iDire: TParameterDirection;           iSize: integer; iValue: OleVariant);

      property Texto   : String   read FTexto    write FTexto;
      property Numero  : Real     read FNumero   write FNumero;
      property Lista   : TStrings read FLista    write SetLista;
      property Coluna  : TStrings read FColuna   write SetColuna;
      property Monitor : TStrings read FMonitor  write SetMonitor;
      property TamaCamp: Integer  read GetTamaCamp write SetTamaCamp;
      property sgState : Integer  read FsgState  write FsgState default 0;
      property PBas: Integer  read GetPBas write FPBas;
      property ExibChav: Boolean  read FExibChav write FExibChav;
      property HoraTota: TTime    read FHoraTota write FHoraTota;
      property RequestLive: Boolean  read FRequestLive write FRequestLive;
      {$ifdef ERPUNI}
        property DataBaseName: TFDCustomConnection  read GetDataBaseName write SetBaseName;
        property Sort: String  read GetSort write SetSort;
      {$ELSE}
        property DataBaseName: TADOConnection  read GetDataBaseName write SetBaseName;
        property UpdateOptions: TUpdateOptions read FUpdateOptions write FUpdateOptions;
      {$ENDIF}
      property ParamCount: Word read GetParamCount;
      property UpdateMode: TUpdateMode read FUpdateMode write FUpdateMode;
      //property SQL_Back: TWideStrings read GetSQL_Back write SetSQL_Back;
      property SQL_Back: TWideStrings read FSQL_Back write FSQL_Back;
      property SQL_Modi: TWideStrings read GetSQL_Modi write SetSQL_Modi;

      {$ifdef ERPUNI}
        property ParamCheck: Boolean  read FParamCheck write FParamCheck default True;
        property EnableBCD: Boolean  read FBoolean write FBoolean;
        property Parameters: TFDParams read GetParameters write SetParameters;
        property CommandTimeout: Integer  read FInteger write FInteger;
        property CursorType: TCursorType  read FCursorType write FCursorType;
        property ConnectionString: String  read GetConnectionString write SetConnectionString;
        property LockType: TADOLockType read FADOLockType write FADOLockType default ltOptimistic;
      {$else}
        property ParamData: TParameters read GetParamData write SetParamData;
        property CachedUpdates: Boolean read FCachedUpdates write FCachedUpdates;
      {$ENDIF}
    end;

  //****************************************************************************
  //****************************************************************************
  {$else} //DATASNAP - CLIENTE
    TUpdateOptions = class(TPersistent)
    private
      FKeyFields: String;
    public
    published
      property KeyFields: String read FKeyFields write FKeyFields;
    end;

    TsgQuery = class(TClientDataSet)
    private
      FatExpr: TFatExpression;

      FTexto    : String;
      FNumero   : Real;
      FLista    : TStrings;
      FColuna   : TStrings;
      FColunaDBG: TStrings;
      FMonitor  : TStrings;
      FTamaCamp : Integer;
      FExibChav : Boolean;
      HoraInic  : TTime;
      FHoraTota : TTime;
      FRequestLive: Boolean;
      FUpdateMode: TUpdateMode;
      FPBas: Integer;
      FsgState: Integer;

      FSQL_Back: TWideStrings;
      FSQL_Modi: TWideStrings;

      //Para compatibilidade - Query-ClientDataSet
      FADOConnection: TADOConnection;
      FEnableBCD: Boolean;
      FParameters: TParameters;
      FSort: String;
      FParamCheck: Boolean;
      FCommandTimeout: Integer;
      FSQL      : TWideStrings;
      FCursorType: TCursorType;
      FCommand: TADOCommand;
      FParams: TParams;
      FAbriu: Integer;
      //Para compatibilidade - Query-ClientDataSet
      FTransaction: TsgTransaction;
      FsgTransaction: TsgTransaction;

      FClientCria: TsgClientDataSet;
      FListaQuery: String;
      function GetSQL: TWideStrings;
      procedure SetSQL(const Value: TWideStrings);
      procedure SetParameters(const Value: TParameters);
      function GetParameters: TParameters;
      procedure SetColuna(Value: TStrings);
      procedure GravMoniFina;
      procedure GravMoniInic;
      function GetPBas: Integer;
      procedure DoFunc(Sender: TObject; Eval: string; Args: array of Variant;ArgCount: Integer; var Value: Variant; var Done: Boolean);
      procedure DoVariable(Sender: TObject; Variable: string; var Value: Variant;var Done: Boolean);
      procedure GetText(Sender: TField; var Text: string; DisplayText: Boolean);
      function GetSQL_Back: TWideStrings;
      function GetSQL_Modi: TWideStrings;
      procedure SetSQL_Back(const Value: TWideStrings);
      procedure SetSQL_Modi(const Value: TWideStrings);

      procedure ConfigurarupWhereKeyOnly(ClientDataSet: TClientDataSet);
      function GetParamCount: Word;
  //    function GetParams: TParameters;
  //    procedure SetParams(const Value: TParameters);
      function GetDataBaseName: TADOConnection;
      procedure SetBaseName(const Value: TADOConnection);
    private
      uDestroi, uFechando: Boolean;
      FCachedUpdates: Boolean;
      fConfTabe: TCustomConfTabe;
    FUpdateOptions: TUpdateOptions;
    protected
      function isGeraMoni: Boolean;
      procedure InternalLast; override;

      procedure SetFiltered(Value: Boolean); override;
      procedure SetActive(Value: Boolean); override;

      procedure DoBeforeGetRecords(var OwnerData: OleVariant); override;
      procedure SetName(const NewName: TComponentName); override;
      procedure QueryChanged(Sender: TObject);
    public
      uCrioCompServ: Boolean;
      uVersCone: Integer;  //Versão da Conexão
      constructor Create(AOwner: TComponent); override;
      procedure SetLista(Value: TStrings);
      procedure SetMonitor(Value: TStrings);
      destructor Destroy; override;

      function ExecSQL: Integer;
      procedure FormatFields;
      Function Soma(iCamp: String): Real;
      function ListaIn(iCamp: String): String;
      function Filtra(iFilt: String): Boolean;
      procedure CancelBatch;
      procedure UpdateBatch;
      procedure sgOpen;
      procedure sgClose;
      procedure CriaCampos(iForm: TForm);
      procedure sgRefresh(iMark: Boolean = False);
      procedure PegaOrigin();

  //    function ParamByName(const Value: string): TParameter;
      property Transaction: TsgTransaction read FTransaction write FTransaction;
      property sgTransaction: TsgTransaction read FsgTransaction write FsgTransaction;
      property ColunaDBG:TStrings read FColunaDBG write FColunaDBG;
      property ConfTabe: TCustomConfTabe read fConfTabe write fConfTabe;
      property UpdateOptions: TUpdateOptions read FUpdateOptions write FUpdateOptions;
    published
      procedure DoBeforeOpen; override;
      procedure DoBeforeClose; override;
      procedure DoAfterOpen; override;
      procedure DoAfterPost; override;
      procedure DoAfterDelete; override;
      procedure DoBeforePost; override;
      procedure DoAfterError;
      procedure CriaParameter(iNome: String; iTipo: TFieldType; iDire: TParameterDirection = pdInput; iSize: integer = 0);
      procedure CriaParameter2(iNome: String; iTipo: TFieldType; iDire: TParameterDirection;           iSize: integer; iValue: OleVariant);
      property Texto   : String   read FTexto    write FTexto;
      property Numero  : Real     read FNumero   write FNumero;
      property Lista   : TStrings read FLista    write SetLista;
      property Coluna  : TStrings read FColuna   write SetColuna;
      property Monitor : TStrings read FMonitor  write SetMonitor;
      property TamaCamp: Integer  read FTamaCamp write FTamaCamp default 30;
      property sgState : Integer  read FsgState  write FsgState default 0;
      property PBas: Integer  read GetPBas write FPBas;
      property ExibChav: Boolean  read FExibChav write FExibChav;
      property HoraTota: TTime    read FHoraTota write FHoraTota;
      property RequestLive: Boolean  read FRequestLive write FRequestLive;
      property DataBaseName: TADOConnection  read GetDataBaseName write SetBaseName;
      property ParamCount: Word read GetParamCount;
      property UpdateMode: TUpdateMode read FUpdateMode write FUpdateMode;
      property SQL_Back: TWideStrings read GetSQL_Back write SetSQL_Back;
      property SQL_Modi: TWideStrings read GetSQL_Modi write SetSQL_Modi;

      //Compabitibilidade
      property Command: TADOCommand read FCommand;
      property Connection  : TADOConnection  read GetDataBaseName write SetBaseName;
      property EnableBCD   : Boolean   read FEnableBCD    write FEnableBCD;
      property Parameters: TParameters read GetParameters write SetParameters;
      property ParamData: TParameters read GetParameters write SetParameters;
      property Sort    : String   read FSort     write FSort;
      property ParamCheck   : Boolean   read FParamCheck    write FParamCheck default True;
      property SQL: TWideStrings read GetSQL write SetSQL;
      property CursorType: TCursorType read FCursorType write FCursorType;
      property CachedUpdates: Boolean read FCachedUpdates write FCachedUpdates;
    //Compabitibilidade

      property ClientCria   : TsgClientDataSet read FClientCria    write FClientCria;
      property ListaQuery : String   read FListaQuery    write FListaQuery;
      property CommandTimeout : Integer read FCommandTimeout    write FCommandTimeout;
      procedure CriaCompServ;
      procedure sgClone(iQry: TDataSet);
    end;
  {$endif}


procedure Register;

implementation

uses sgConsts
  {$ifdef DATASNAP}
    , sgForm
  {$endif}
  {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
    , DmPlus
  {$endif}
;


{$ifndef DATASNAP}
  procedure TsgQuery.PegaOrigin();
  var
    i, j: integer;
    vSele, vFrom, vAuxi: String;
    vAcho: Boolean;

    procedure PegaOrigin_From();
    var
      vSQL_Orga: TWideStrings;
      i: integer;
    begin
      vSQL_Orga := TWideStringList.Create;
      try
        vSQL_Orga.Text := OrgaSQL(SQL.Text);

        vSele := '';
        for i := 0 to vSQL_Orga.Count-1 do
        begin
          if AnsiUpperCase(Copy(Trim(vSQL_Orga.Strings[i]),01,05)) = 'FROM ' then
          begin
            vFrom := vSQL_Orga.Strings[i];
            break;
          end
          else
            vSele := vSele + vSQL_Orga.Strings[i];
        end;
      finally
        vSQL_Orga.Free;
      end;
    end;
  begin
    //{$ifdef FD}
      if Active then
      begin
        PegaOrigin_From();
        {$ifdef FD}
          if UpdateOptions.UpdateTableName = '' then
            UpdateOptions.UpdateTableName := PegaTabe(vFrom);

          if (UpdateOptions.UpdateTableName <> '') and (UpdateOptions.KeyFields = '') then
            UpdateOptions.KeyFields := 'Codi'+Copy(UpdateOptions.UpdateTableName,05,MaxInt);
        {$endif}

        //if StrInPos(vFrom, ['INNER','LEFT','JOIN']) then
        begin
          for I := 0 to Fields.Count-1 do
          begin
            if StrIn(Fields[i].FieldName.ToUpper, ['LINH_']) then
            begin
              Fields[i].ReadOnly := True;
              Fields[i].ProviderFlags := [];
            end
            else
            begin
              vAuxi := Trim(PegaSQL_NomeCamp(vSele, Fields[i].FieldName));


              if vAuxi <> '' then
              begin
                begin
                  vAcho := False;
                  j := 0;
                  while (not vAcho) and (j < Fields.Count) do
                  begin
                    vAcho := AnsiUpperCase(vAuxi) = AnsiUpperCase(Fields[j].Origin);
                    inc(j);
                  end;

                  if (not vAcho) then
                  begin
                    if (sgPos('(',vAuxi) > 0) then  //Campos com formula, não são editáveis
                    begin
                      Fields[i].ReadOnly := True;
                      Fields[i].ProviderFlags := [];
                    end
                    else
                    begin
                      if Copy(Trim(vAuxi),01,01) = '''' then
                      begin
                        Fields[i].ProviderFlags := [];
                      end
                      else
                      begin
                        if sgPos('.',vAuxi) > 0 then
                          Fields[i].Origin := Copy(vAuxi, sgPos('.',vAuxi)+1, MaxInt)
                        else
                          Fields[i].Origin := vAuxi;
                      end;
                    end;
                  end;
                end;
              end
              else
              begin
                {$ifdef FD}
                  vAuxi := PegaCampSele(vSele, i+1).Trim;
                  if (sgPos('.',vAuxi) > 0) and (sgCopy(vAuxi,01,sgPos('.',vAuxi)-1).ToUpper <> UpdateOptions.UpdateTableName.ToUpper) then
                  begin
                    Fields[i].ReadOnly := True;
                    Fields[i].ProviderFlags := [];
                  end;
                {$endif}
              end;
            end;
          end;
        end;
      end;
    //{$endif}
  end;

  function TsgQuery.CriaCampField(Field: TField; DisplayLabel: String = ''; Origin: String = '';
                              Visi: Boolean = False; Tag: Integer = 10; DisplayWidth: Integer = 15;
                              DisplayFormat: String = ',0.00###'; Indi: Integer = 2): TField;
  begin
    Result := nil;
    if (DefaultFieldClasses[Field.DataType] <> nil) and (Field.DataType <> ftUnknown) then
    begin
      Result := DefaultFieldClasses[Field.DataType].Create(Self);
      Result.FieldName := Field.FieldName;
      if Origin = '' then
        Result.Origin := Field.Origin
      else
        Result.Origin := Origin;
      Result.Name := Self.Name+'_'+Result.Origin+'_'+Field.FieldName;
      if DisplayLabel <> '' then
        Result.DisplayLabel := DisplayLabel;
      Result.Visible := Visi;
      Result.Tag := Tag;
      TamaCamp_Ajusta(Result, DisplayWidth);
      //Result.DisplayFormat := DisplayFormat;
      Result.DataSet := Self;
      if Visi then
        Self.FieldByName(Result.FieldName).Index := Indi;
    end;
  end;

  procedure TsgQuery.CriaCampos(iForm: TForm);
  var
    i: Integer;
    isOpen: Boolean;
    IniFiltCons: TDBIniMemo;
    ListCamp, ListProp: TStringList;
    vAuxi: String;
    vQry: TsgQuery;
    vCamp: TField;
  begin
    isOpen := Self.Active;
    if Self.Active then
      Self.Close;

    AutoCalcFields := True;
    CachedUpdates  := False;
    if ConfTabe.GravTabe <> '' then
    begin
      UpdateMode := upWhereKeyOnly;
      UpdateOptions.KeyFields := ConfTabe.NomeCodi;
    end;

    FieldDefs.Update;
    FieldOptions.AutoCreateMode := acCombineAlways;
    CreateFields;
//    for I := 0 to FieldDefList.Count-1 do
//    begin
//      CriaCampField(FieldDefs[i]);
//    end;

    IniFiltCons := TDBIniMemo.Create(Nil);
    ListCamp := TStringList.Create;
    ListProp := TStringList.Create;
    try
      IniFiltCons.Memo.Add(Coluna.Text);
      //Nome dos Campos
      IniFiltCons.ReadSection('Colunas', ListCamp);
      //Configuração dos Campos
      IniFiltCons.ReadSectionValues('Colunas', ListProp);

      for I := 0 to ListProp.Count-1 do
      begin
        if sgPos('/Lookup=S',ListProp[i]) > 0 then
        begin
          vQry := nil;
          vAuxi := 'Qry'+BuscValoChavText(ListProp[i],'LookupQuery');
          if Assigned(iForm) then
          begin
            with iForm do
              vQry := TsgQuery(FindComponent(vAuxi));
          end
          else
            SetPLblAjud_Capt('CriaCampos Lookup: Sem Formulário');
          if Assigned(vQry) then
          begin
            //campo Lookup
            //CodiTran= (campo da tabela origem)
            //Lookup=S
            //LookQuery=CodiTran (RACaTran.CodiTran)
            //Key=CodiTran       (Ordem.CodiTran)
            //LookLista=NomeTran (RACaTran.NomeTran)
            if not vQry.Active then
              vQry.Open;
            vCamp := CriaCampField(vQry.FieldByName(ListCamp[i])
                                  , BuscValoChavText(ListProp[i],'Nome')
                                  , BuscValoChavText(ListProp[i],'Key')
                                  , BuscValoChavText(ListProp[i],'Visi')<>'N'
                                  , 10
                                  , sgStrToInt(BuscValoChavText(ListProp[i],'Tama'))
                                  , BuscValoChavText(ListProp[i],'Mask')
                                  , sgStrToInt(BuscValoChavText(ListProp[i],'Indi')));

            if Assigned(vCamp) then
            begin
              vCamp.FieldKind := fkLookup;
              vCamp.LookupDataSet := vQry;
              vCamp.LookupKeyFields := BuscValoChavText(ListProp[i],'LookupKey');
              vCamp.LookupResultField := ListCamp[i];
              vCamp.KeyFields := BuscValoChavText(ListProp[i],'Key');
              //vCamp.Size := 200;
              vCamp.Lookup := True;

              if Trim(vCamp.LookupKeyFields) = '' then
                raise Exception.Create('Necessário informar o LookupKey');
              if Trim(vCamp.KeyFields) = '' then
                raise Exception.Create('Necessário informar a Key');
            end
            else
              SetPLblAjud_Capt('CriaCampos Lookup: Campo '+ListCamp[i]+' sem tipo definido');
          end
          else
            SetPLblAjud_Capt('CriaCampos Lookup: Sem LookupQuery');
        end;
      end;
    finally
      IniFiltCons.Free;
      ListCamp.Free;
      ListProp.Free;
    end;

    if isOpen then
      Self.Open;
  end;

  procedure TsgQuery.GravMoniInic();
  var
    i: Integer;
    NovoSQL, Auxi: string;

    // Pega uma String passado com um valor REAL e retorna o valor com PONTO
    // Ex.: Pega 1.234.456,7890 <=> Retorna 123456.7890)
    // Obs.: Esta Função já possui o RetoZero
    Function FormPont(Nume: String):String;
    var
      i : integer;
      Enco : Boolean;  //Caso já encontrou o Ponto ou a Vírgula
    begin
      i := Length(Nume);
      Enco := False;
      while i > 0 do
      begin
        if not(Enco) then
        begin
          if Nume[i] in [',','.'] then
          begin
            Enco := True;
            Nume[i] := '.';
          end;
        end
        else
        begin
          if Nume[i] in [',','.'] then
            System.Delete(Nume,i,01);
        end;
        Dec(i);
      end;
      Result := Nume;
    end;

    //Formata a Data para String, conforme a Base de Dados
    Function FormDataStri(Data: TDateTime):String;
    begin
      if PBas = 4 then
        Result := QuotedStr(FormatDateTime('DD/MM/YYYY',Data))
      else if PBas = 3 then
        Result := QuotedStr(FormatDateTime('MM/DD/YYYY',Data))
      else if PBas = 2 then
        Result := QuotedStr(FormatDateTime('MM/DD/YYYY',Data))
      else
        Result := FormatDateTime('MM/DD/YYYY',Data);
    end;

    //Formata a Data para o SQL conforme a Base de Dados
    Function FormDataSQL(Data: TDateTime):String;
    begin
      Result := FormDataStri(Data);
      if PBas = 4 then
        Result := 'CAST('+ Result + 'AS DATE)'
      else if PBas = 3 then
        Result := 'CAST('+ Result + 'AS TIMESTAMP)';
    end;

  begin
    HoraInic := Now;
    if isGeraMoni() then
    begin

      FMonitor.Add('Qry: '+Name);
      if Assigned(Connection) then
      begin
        if Connection is  TsgADOConnection then
          FMonitor.Add('Connection: '+Connection.Name+'  '+FormInteBras(TsgADOConnection(Connection).CodiTabe)+SeStri(TsgADOConnection(Connection).InTransaction,' (Trans)',''))
        else
          FMonitor.Add('Connection: '+Connection.Name);
        {if (Self.FPBas = 2) and (GetPLogTipo() IN [2,3]) then
        begin
          Connection.Execute('DECLARE @UserOptions TABLE(SetOption varchar(100), Value varchar(100));'+#13+

                             'INSERT  @UserOptions EXEC(''DBCC USEROPTIONS WITH NO_INFOMSGS'');'+#13+

                             'INSERT INTO SISTLOG_ (CAM1LOG_, CAM2LOG_, CAM3LOG_) '+#13+
                             'SELECT  '+QuotedStr(Connection.Name)+', UPPER(SetOption), Value '+#13+
                             'FROM    @UserOptions '+#13+
                             'WHERE   UPPER(SetOption) = ''ISOLATION LEVEL''');
        end;}
      end;

      NovoSQL := SQL.Text;
      if Parameters.Count > 0 then
      begin
       FMonitor.Add(IntToStr(Parameters.Count)+' Parâmetro(s):');
        for i := 0 to Parameters.Count - 1 do
        begin
          if Parameters[i].Value = Null then
            Auxi := 'Null'
          else if Parameters[i].DataType = ftInteger then
            Auxi := IntToStr(Parameters[i].Value)
          else if Parameters[i].DataType = ftFloat then
            Auxi := FormPont(FloatToStr(Parameters[i].Value))
          else if Parameters[i].DataType in [ftDate, ftDateTime] then
            Auxi := FormDataSQL(Parameters[i].Value)
          else if Parameters[i].DataType in [ftString, ftWideString] then
            Auxi := QuotedStr(Parameters[i].Value);

          FMonitor.Add(':'+Parameters[i].Name+' = '+Auxi);
          NovoSQL := SubsPalaTudo(NovoSQL, ':'+Parameters[i].Name, Auxi);
        end;
      end;
      if Filtered then
        FMonitor.Add('Filter: '+Filter);

      FMonitor.Add('SQL: '+NovoSQL);
      if GetPLogTipo() IN [2,3] then
      begin
        try
          ArquAdicText(FMonitor.Text+#13+'...', GetNomeArquLog_(GetPCodPess()));
        except
          //MessageDlg('Arquivo de Log ocupado!', mtInformation, [mbOK], 0);
        end;
      end;

      FMonitor.Add('*** Erro ***');
      FMonitor.Add('---------------------');

    end;
  end;

  procedure TsgQuery.GravMoniFina();
  var
    i: Integer;
  begin
    FHoraTota := Now-HoraInic;
    if isGeraMoni() then
    begin
      FMonitor.Delete(FMonitor.Count-1);
      FMonitor.Delete(FMonitor.Count-1);
      if Active then
        FMonitor.Add('Tempo: '+FormatDateTime('nn:ss:zzz',FHoraTota)+' ('+FormInteBras(RecordCount)+')')
      else
        FMonitor.Add('Tempo: '+FormatDateTime('nn:ss:zzz',FHoraTota));
      FMonitor.Add('---------------------');

      if GetPLogTipo() IN [2,3] then
      begin
        try
          if Active then
            ArquAdicText('Tempo: '+FormatDateTime('nn:ss:zzz',FHoraTota)+' ('+FormInteBras(RecordCount)+')', GetNomeArquLog_(GetPCodPess()))
          else
            ArquAdicText('Tempo: '+FormatDateTime('nn:ss:zzz',FHoraTota), GetNomeArquLog_(GetPCodPess()));
          ArquAdicText('---------------------------------'              , GetNomeArquLog_(GetPCodPess()));
        except
          //MessageDlg('Arquivo de Log ocupado!', mtInformation, [mbOK], 0);
        end;
      end;

      if Assigned(Connection) and ((Connection.ClassType = TsgADOConnection) or (Connection.ClassType = TsgTransaction)) then
      begin
        for I := 0 to FMonitor.Count - 1 do
          TsgADOConnection(Connection).Monitor.Add(FMonitor.Strings[i]);
      end;
      FMonitor.Clear;
    end;
  end;

  constructor TsgQuery.Create(AOwner: TComponent);
  begin
    FLista  := TStringList.Create;
    FColuna := TStringList.Create;
    FColunaDBG := TStringList.Create;
    FMonitor:= TStringList.Create;
    FSQL_Back := TWideStringList.Create;
    FSQL_Modi := TWideStringList.Create;
    inherited Create(AOwner);

  //  UpdateMode := upWhereKeyOnly;
    CommandTimeout := 600;
    CursorType := ctKeyset;
    FExibChav  := True;
    //LockType   := ltPessimistic;

    FatExpr := TFatExpression.Create(Self);
    FConfTabe := TCustomConfTabe.Create;

    //FilterOptions := FilterOptions + [foCaseInsensitive];  --Erro
  //  Connection := PADOConn;
    {$ifdef ERPUNI}
      FADOLockType := ltOptimistic;
      FParamCheck  := True;
    {$ELSE}
      FUpdateOptions := TUpdateOptions.Create;
    {$ENDIF}
 end;

  destructor TsgQuery.Destroy;
  begin
//    FreeAndNil(FatExpr);
//    FreeAndNil(FConfTabe);
//    FreeAndNil(FLista);
//    FreeAndNil(FColuna);
//    FreeAndNil(FColunaDBG);
//    FreeAndNil(FMonitor);
//    FreeAndNil(FSQL_Back);
//    FreeAndNil(FSQL_Modi);
//    {$ifdef ERPUNI}
//    {$ELSE}
//      FreeAndNil(FUpdateOptions);
//    {$ENDIF}
    inherited Destroy;
  end;

  procedure TsgQuery.DoVariable(Sender: TObject; Variable: string; var Value: Variant; var Done: Boolean);
  begin
    try
      if sgPos('''{',Variable) > 0 then
        Value := 0
      else if sgPos('{',Self.FieldByName(Variable).Asstring) > 0 then
      begin
        FatExpr.Text := Copy(Self.FieldByName(Variable).Asstring,02,Length(Self.FieldByName(Variable).Asstring)-2);
        Value := FatExpr.Value;
      end
      else
        Value := Self.FieldByName(Variable).AsFloat;
    except
      Value := 0;
    end;
  end;

  function TsgQuery.ExecSQL: Integer;
  var
    Linh, Posi: Integer;
    Auxi, Come: string;
    AbreCome: Boolean;

    {$ifndef ERPUNI}
      procedure InitializeMasterFields(Dataset: TCustomADODataset);
      var
        I: Integer;
        MasterFieldList: string;
      begin
        with DataSet do
          //Assign MasterFields from parameters as needed by the MasterDataLink
          if (Parameters.Count > 0) and Assigned(MasterDataLink.DataSource) and
            Assigned(MasterDataLink.DataSource.DataSet) then
          begin
            for I := 0 to Parameters.Count - 1 do
              if (Parameters[I].Direction in [pdInput, pdInputOutput]) and
                (MasterDataLink.DataSource.DataSet.FindField(Parameters[I].Name) <> nil) then
                MasterFieldList := MasterFieldList + Parameters[I].Name + ';';
            MasterFields := Copy(MasterFieldList, 1, Length(MasterFieldList)-1);
            SetParamsFromCursor;
          end;
      end;
    {$ENDIF}
  begin
    {$ifdef WS}
      if (not Assigned(Connection)) and Assigned(GetPADOConn()) then
        Connection := GetPADOConn;
    {$else}
      {$ifdef ERPUNI}
        if not Assigned(sgTransaction) then
          sgTransaction := GetPsgTrans();
        if Assigned(sgTransaction) then
        begin
          if Assigned(sgTransaction.Connection) then
            Connection  := sgTransaction.Connection
          else
            sgTransaction.Connection  := GetPADOConn;
        end;
        if (not Assigned(Connection)) and Assigned(GetPADOConn()) then
          Connection := GetPADOConn;
      {$else}
        if System.Assigned(GetPADOConn()) {$ifdef PDADATASNAP} and not System.Assigned(Connection) {$endif} then
        begin
          if not Assigned(Connection) or
             (Assigned(Connection) and
              (not StrIn(AnsiUpperCase(Connection.Name), ['DTBNUME', 'DTBCADA', 'DTBSAG', 'DTBBASEAUXI', 'DTBCALL', 'DTBFINA']))) then
            Connection := GetPADOConn;
        end;
      {$endif}
    {$endif}
    SQL.Text := TratSQL(SQL.Text);
    AbreCome := False;
    for Linh := 0 to SQL.Count - 1 do
    begin
      if UpperCase(Copy(Trim(SQL[Linh]),1,6)) <> 'INSERT' then
      begin
        if not AbreCome then
          AbreCome := System.Pos('/*',SQL.Strings[Linh]) > 0;

        if AbreCome then
          AbreCome := not (System.Pos('*/',SQL.Strings[Linh]) > 0);

        if (not AbreCome) and (System.Pos('--',SQL.Strings[Linh]) > 0) then
        begin
          Auxi := Copy(SQL.Strings[Linh],01,System.Pos('--',SQL.Strings[Linh])-1);
          Come := Copy(SQL.Strings[Linh],   System.Pos('--',SQL.Strings[Linh]), Length(SQL.Strings[Linh]));
          Come := SubsPalaTudo(Come,'/*','/ *');
          Come := SubsPalaTudo(Come,'*/','* /');
          Come := StringReplace(Come,'--','/*',[])+' */';
          SQL.Strings[Linh] := Auxi + Come;
        end;
      end;
    end;

    if (PBas = 2) and (Copy(AnsiUpperCase(SQL.Text),01,04) = 'EXEC') then //Problemas com Data na chamada de Procedimento do SQLServer
    begin
      Posi := System.Pos('CONVERT(DATETIME', SQL.Text);
      while Posi > 0 do
      begin
        Auxi := Copy(SQL.Text, Posi, 30);
        SQL.Text := SubsPalaTudo(SQL.Text, Auxi, Copy(Auxi,18,12));
        Posi := System.Pos('CONVERT(DATETIME', SQL.Text);
      end;

      //Tira os Parenteses
      SQL.Text := TiraPare(SQL.Text);  //Coloca as vezes para o Oracle, assim, fica padrão
    end;
    //SQL.SaveToFile('i:\sag\versao\SQL.txt');

    {$ifndef ERPUNI}
      InitializeMasterFields(Self);
    {$ENDIF}

    GravMoniInic;
    //if not (Trig.TrigPrin(getTableName(self.SQL.Text), self.SQL.Text,self)) then
    //begin
    //  self.cancel;
    //  SysUtils.abort;
    //end;
    {$ifdef ERPUNI}
      if GetPBas = 4 then
      begin
        if (Pos('EXECUTE', AnsiUpperCase(SQL.Text)) > 0) and (Pos('END;', AnsiUpperCase(SQL.Text)) = 0) then
          Sql.Text := 'begin'+sLineBreak+
                        SubsPalaTudo(SQL.Text,'EXECUTE','')+';'+sLineBreak+
                      'end;';
      end;
      Execute;
    {$else}
      Command.Execute(Linh, EmptyParam);
    {$ENDIF}

    GravMoniFina;
  end;

  procedure TsgQuery.DoFunc(Sender: TObject; Eval: string; Args: array of Variant;
      ArgCount: Integer; var Value: Variant; var Done: Boolean);
  begin
    Eval := UpperCase(Eval);

    if Eval = 'DATE' then
      Value := Date
    else if Eval = 'IF' then
    begin
      if ArgCount = 3 then
      begin
        if Args[0] > 0 then
          Value := Args[1]
        else
          Value := Args[2];
      end
      else
        Value := 0;
  //      raise exception.create('Falta Argumentos. Sintaxe: if(condição, valorverdade, valorfalso)');
    end
    else
      Value := 0;
  //    raise exception.createFMT('Objeto "%s" desconhecido', [Eval]);

    Done := True;
  end;

  procedure TsgQuery.SetActive(Value: Boolean);
  var
    vMsg, vTabe, vFrom, vCamp, TabeAnte, TabeDepo: String;

  begin
    try
      inherited SetActive(Value);
    except
      on E: Exception do
      begin
        vMsg := '';
        if PalaContem(Copy(Name,01,07), 'QRYGRAV') and PalaContem(E.Message, 'INVALID COLUMN NAME') then
        begin
          vCamp := Copy(E.Message, Pos('''', E.Message)+1, MaxInt);
          vCamp := Copy(vCamp, 01, Pos('''', vCamp)-1).ToUpper;
          if Pos('_UN_',vCamp) = 0 then
          begin
            vCamp := Copy(vCamp, 05, MaxInt);
            vFrom := SQL_RetoFrom(SQL.Text).ToUpper;
            vTabe := PegaTabe(vFrom);
            if (Pos(vCamp, vTabe) = 0) and
               (Pos(vCamp, vFrom) > 0) then
            begin
              TabeAnte := Copy(vFrom, 01, Pos(vCamp, vFrom)-1);
              if Pos(' ',TabeAnte) > 0 then
              begin
                TabeAnte := InvePala(TabeAnte);
                TabeAnte := Copy(TabeAnte, 01, Pos(' ',TabeAnte)-1);
                TabeAnte := InvePala(TabeAnte);
              end;
              TabeDepo := Copy(vFrom, Pos(vCamp, vFrom), MaxInt);
              if Pos(' ',TabeDepo) > 0 then
                TabeDepo := Copy(TabeDepo, 01, Pos(' ',TabeDepo)-1);
              vTabe := TabeAnte + TabeDepo;
            end;
            {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
              if RodaEstrutura(vTabe, [teCamp, teView]) then
                vMsg := 'Campo inexistente. Estrutura recriada. Favor repetir o processo!'
              else
                vMsg := 'Coluna inválida!'+sLineBreak+sLineBreak+
                        Self.Name+sLineBreak+Self.SQL.Text+sLineBreak+sLineBreak+E.Message;
            {$endif}
          end;
        end
        else if (GetPBas() = 4) and ((Pos('ORA-01775:',AnsiUpperCase(E.Message)) > 0) or (Pos('LOOPING CHAIN OF SYNONYMS',AnsiUpperCase(E.Message)) > 0) or (Pos('LOOP NA CADEIA DE SIN',AnsiUpperCase(E.Message)) > 0)) then
        begin
          vMsg := 'ORA-20000: Falha na estrutura de Sinônimos!'+sLineBreak+sLineBreak+
                 Self.Name+sLineBreak+Self.SQL.Text+sLineBreak+sLineBreak+E.Message;
        end
        else if (GetPBas() = 4) and ((Pos('ORA-00942:',AnsiUpperCase(E.Message)) > 0) or (Pos('TABLE OR VIEW DOES NOT EXIST',AnsiUpperCase(E.Message)) > 0)) then
        begin
          vMsg := 'ORA-20000: Tabela ou View não Existe!'+sLineBreak+sLineBreak+
                  Self.Name+sLineBreak+Self.SQL.Text+sLineBreak+sLineBreak+E.Message;
        end
        else if ((Pos('MULTIPLE-STEP OPERATION GENERATED ERRORS. CHECK EACH STATUS VALUE',AnsiUpperCase(E.Message)) > 0) or (Pos('VERIFIQUE CADA VALOR DE STATUS',AnsiUpperCase(E.Message)) > 0)) then
        begin
          vMsg := 'ORA-20000: Campo DATA nulo ou inválido (< 1900)'+sLineBreak+sLineBreak+
                  Self.Name+sLineBreak+Self.SQL.Text+sLineBreak+sLineBreak+
                  E.Message+sLineBreak+sLineBreak+
                  ExibDadoQuer(Self, False, True)+sLineBreak+sLineBreak+
                  'Sugestão para Correção: UPDATE TABE SET DATA = (CASE WHEN DATA IS NULL OR DATA < ''01/01/1900'' THEN NULL ELSE DATA END)';
        end;
        if vMsg <> '' then
          raise exception.create(vMsg)
        else
          raise;
//        if (GetPBas() = 4) and ((Pos('ORA-01775:',AnsiUpperCase(E.Message)) > 0) or (Pos('LOOPING CHAIN OF SYNONYMS',AnsiUpperCase(E.Message)) > 0) or (Pos('LOOP NA CADEIA DE SIN',AnsiUpperCase(E.Message)) > 0)) then
//        begin
//          if msgNovaMsg('Falha na estrutura de Sinônimos!' then
//            msgOk(Self.Name+sLineBreak+Self.SQL.Text+sLineBreak+sLineBreak+E.Message);
//        end
//        else if (GetPBas() = 4) and ((Pos('ORA-00942:',AnsiUpperCase(E.Message)) > 0) or (Pos('TABLE OR VIEW DOES NOT EXIST',AnsiUpperCase(E.Message)) > 0)) then
//        begin
//          if msgNovaMsg('Tabela ou View não Existe!') then
//            msgOk(Self.Name+sLineBreak+Self.SQL.Text+sLineBreak+sLineBreak+E.Message);
//        end
//        else if ((Pos('MULTIPLE-STEP OPERATION GENERATED ERRORS. CHECK EACH STATUS VALUE',AnsiUpperCase(E.Message)) > 0) or (Pos('VERIFIQUE CADA VALOR DE STATUS',AnsiUpperCase(E.Message)) > 0)) then
//        begin
//          if msgNovaMsg('Campo DATA nulo ou inválido (< 1900)') then
//            msgOk(Self.Name+sLineBreak+Self.SQL.Text+sLineBreak+sLineBreak+
//                         E.Message+sLineBreak+sLineBreak+
//                         ExibDadoQuer(Self, False, True)+sLineBreak+sLineBreak+
//                         'Sugestão para Correção: UPDATE TABE SET DATA = (CASE WHEN DATA IS NULL OR DATA < ''01/01/1900'' THEN NULL ELSE DATA END)');
//        end;
//        raise;
      end;
    end;
  end;

  procedure TsgQuery.SetLista(Value: TStrings);
  begin
    if FLista.Text <> Value.Text then
    begin
      FLista.BeginUpdate;
      try                                                                        
        FLista.Assign(Value);
      finally
        FLista.EndUpdate;
      end;
    end;
  end;

  procedure TsgQuery.SetColuna(Value: TStrings);
  begin
    if FColuna.Text <> Value.Text then
    begin
      FColuna.BeginUpdate;
      try
        FColuna.Assign(Value);
      finally
        FColuna.EndUpdate;
      end;
    end;
  end;

  {$ifndef ERPUNI}
    procedure TsgQuery.SetFiltered(Value: Boolean);
    var
      Orde: String;

      procedure AbreFilt_AbreFech();
      begin
        Orde := Sort;
        Close;
        Open;
        if Orde <> '' then
          Sort := Orde;
      end;

    begin
      try
        if (Filter <> '') then
        begin
          if not((System.Pos(') OR (',Filter) > 0) and (System.Pos(') AND (',Filter) > 0)) and
             not((System.Pos(' NOT LIKE ',Filter) > 0)) then
          begin
            if (System.Pos('/*INICPROBFILT*/',SQL.Text) > 0) then  //Se ainda tiver filtro, limpa e depois set o Filtered
              AbreFilt_AbreFech();
            inherited SetFiltered(Value)
          end
          else
            AbreFilt_AbreFech();
        end
        else //O filtro for vazio (else)
        begin
          if System.Pos('/*INICPROBFILT*/',SQL.Text) > 0 then
            AbreFilt_AbreFech()
          else
            inherited SetFiltered(Value);
        end;
      except
        on E: Exception do
        begin
          msgNovaMsg('Coluna não disponível para Filtro!',
                     SeStri(Filter<>'','Filtro: '+Filter,'')+sLineBreak+sLineBreak+
                     E.Message);
        end;
      end;
    end;
  {$ENDIF}

  procedure TsgQuery.SetMonitor(Value: TStrings);
  begin
    if FMonitor.Text <> Value.Text then
    begin
      FMonitor.BeginUpdate;
      try
        FMonitor.Assign(Value);
      finally
        FMonitor.EndUpdate;
      end;
    end;
  end;

  procedure TsgQuery.SetsgTransaction(const Value: TsgTransaction);
  begin
    FsgTransaction := Value;
    {$IFDEF FD}
      if Assigned(FsgTransaction) then
        Connection := FsgTransaction.Connection;
    {$ELSE}
      if Assigned(FsgTransaction) then
        Connection := TsgADOConnection(FsgTransaction);
    {$ENDIF}
  end;

  function TsgQuery.GetsgTransaction: TsgTransaction;
  begin
    Result := FsgTransaction;
  end;

  {$ifdef ERPUNI}
    procedure TsgQuery.SetParameters(const Value: TFDParams);
    begin
      Params := Value;
    end;

    function TsgQuery.GetParameters: TFDParams;
    begin
      Result := Params;
    end;
  {$else}
    procedure TsgQuery.SetParamData(const Value: TParameters);
    begin
      Parameters := Value;
    end;

    function TsgQuery.GetParamData: TParameters;
    begin
      Result := Parameters;
    end;
  {$ENDIF}

  procedure TsgQuery.SetSQL_Back(const Value: TWideStrings);
  begin
    FSQL_Back.Assign(Value);
  end;

  procedure TsgQuery.SetSQL_Modi(const Value: TWideStrings);
  begin
    FSQL_Modi.Assign(Value);
  end;

  procedure TsgQuery.sgOpen;
  begin
    if not Active then
      Open;
  end;

  procedure TsgQuery.sgClone(iQry: TDataSet);
  begin
    {$ifdef ERPUNI}
      if Self.SQL.Text = '' then
        Self.SQL.Text := TsgQuery(iQry).SQL.Text;

      CloneCursor(TsgQuery(iQry));
    {$else}
      // Ticket 8924 - OFA - Precisa disso para atualizar os valores das colunas que usam expressão. Exemplo: '{([ORIGSALDO]-[DESCONTO])}' AS Saldo.
      // (Erro acontecia quando chamava pela tela de relatórios do gerencial GeChRela.pas)
      if System.Pos('''{',TsgQuery(iQry).SQL.Text) > 0 then
        FTemExpr := True;

      Clone(TsgQuery(iQry));
    {$endif}
    SQL_Back.Text := TsgQuery(iQry).SQL.Text;
  end;

  procedure TsgQuery.sgClone(iQry: TClientDataSet);
  begin
    {$ifdef ERPUNI}
      CloneCursor(TsgQuery(iQry));
    {$else}
      //Clone(iQry);
    {$endif}
  end;

  procedure TsgQuery.sgClose;
  begin
    if Active then
    begin
      if State in [dsEdit, dsInsert] then
        Cancel;
      Close;
    end;
  end;

  procedure TsgQuery.sgRefresh(iMark: Boolean = False);
  {$ifdef ERPUNI}
  {$else}
    var
      vMark : TBookMark;
  {$endif}
  begin
    {$ifdef ERPUNI}
      if not Active then
        Open
      else
        Refresh;
    {$else}
      //Requery();
      if iMark then
        vMark := Self.GetBookmark;
      try
        sgClose;
        sgOpen;
      finally
        if iMark then
        begin
          try
            if Self.BookmarkValid(vMark) then
              Self.GotoBookmark(vMark);
            Self.FreeBookmark(vMark);
          except
            Self.FreeBookmark(vMark);
          end;
        end;
      end;
    {$endif}
  end;

  function TsgQuery.Soma(iCamp: String): Real;
  begin
    Result := 0;
    if Active and (not IsEmpty) then
    begin
      if IsDigit(iCamp) then
        iCamp := Fields[sgStrToInt(iCamp)].FieldName;
      DisableControls;
      First;
      while not Eof do
      begin
        Result := Result + FieldByName(iCamp).AsFloat;
        Next;
      end;
      EnableControls;
    end;
  end;

  function TsgQuery.ListaIn(iCamp: String): String;
  begin
    Result := '';
    if Active and (not IsEmpty) then
    begin
      if IsDigit(iCamp) then
        iCamp := Fields[sgStrToInt(iCamp)].FieldName;
      DisableControls;
      First;
      while not Eof do
      begin
        if Trim(FieldByName(iCamp).AsString) <> '' then
          Result := Result + SeStri(Result = '', '', ', ')+QuotedStr(FieldByName(iCamp).AsString);
        Next;
      end;
      EnableControls;
    end;
    if Result = '' then
      Result := '(''0'')'
    else
      Result := '('+Result+')';
  end;

  function TsgQuery.Filtra(iFilt: String): Boolean;
  begin
    Result := True;
    if Active then
    begin
      Filtered := False;
      if iFilt <> '' then
      begin
        Filter := iFilt;
        Filtered := True;
      end;
    end;
  end;

  function TsgQuery.isGeraMoni(): Boolean;
  begin
    {$ifdef SAGSINC}
      Result := True;
    {$endif}
    {$ifdef PDADATASNAP}
      Result := True;
    {$else}
      Result := GetPLogTipo() IN [2,3]; //IsAdmiClie or IsAdmiSAG;
    {$endif}
  end;

  procedure TsgQuery.Ajusta_Filtro(iForca: Boolean = False);
  var
    i, LinhFrom, LinhDepo, LinhWher: Integer;
    Sele, NomeCamp, MaisWher: String;
  begin
    {$ifndef DATASNAP_SERV}  //Quando servidor DataSnap, executa o que vem, pois não tem Filter no lado do Servidor
      //*********************************************
      //Problema do Filter
      begin
        //Tira o Filtro anterior
        for I := 0 to SQL.Count - 1 do
        begin
          if System.Pos('/*INICPROBFILT*/',SQL.Strings[i]) > 0 then
            SQL.Strings[i] := Copy(SQL.Strings[i],01,System.Pos('/*INICPROBFILT*/',SQL.Strings[i])-1);
          if System.Pos('/*FINAPROBFILT*/',SQL.Strings[i]) > 0 then
            SQL.Strings[i] := Copy(SQL.Strings[i],System.Pos('/*FINAPROBFILT*/',SQL.Strings[i])+17,Length(SQL.Strings[i]));
        end;

        if iForca or
           ((System.Pos(') OR (',Filter) > 0) and (System.Pos(') AND (',Filter) > 0)) or
           ((System.Pos(' NOT LIKE ',Filter) > 0)) then
        begin
          LinhWher := 0;
          LinhDepo := 0;
          LinhFrom := 0;
          for I := 0 to SQL.Count - 1 do
          begin
            if (AnsiUpperCase(Copy(Trim(SQL.Strings[i]),01,08)) = 'ORDER BY') Or
               (AnsiUpperCase(Copy(Trim(SQL.Strings[i]),01,08)) = 'GROUP BY')then
              LinhDepo := i;
            if AnsiUpperCase(Copy(Trim(SQL.Strings[i]),01,05)) = 'WHERE' then
              LinhWher := i;
            if AnsiUpperCase(Copy(Trim(SQL.Strings[i]),01,04)) = 'FROM' then
              LinhFrom := i;
          end;

          Sele := '';
          for i := 0 to LinhFrom - 1 do   //Pega todo o SELECT
            Sele := Sele + SQL.Strings[i];

          NomeCamp := 'SSSAAAGGGGAAAGGGSSSGG';
          i := 1;
          MaisWher := Filter;
          while NomeCamp <> '' do
          begin
            NomeCamp := PegaCampSele(Sele,i);
            if NomeCamp <> '' then
            begin
              NomeCamp := PegaNomeCamp(NomeCamp,i);
              if System.Pos(AnsiUpperCase(NomeCamp), AnsiUpperCase(MaisWher)) > 0 then
                MaisWher := SubsPalaTudo(MaisWher, '['+NomeCamp+']', PegaCampManuGene(Sele,i));
            end;
            Inc(i);
          end;
          if LinhWher > 0 then
            SQL.Strings[LinhWher] := SQL.Strings[LinhWher] + '/*INICPROBFILT*/ AND ('+MaisWher+')/*FINAPROBFILT*/'
          else if LinhDepo > 0 then
            SQL.Strings[LinhDepo-1] := SQL.Strings[LinhDepo-1] + '/*INICPROBFILT*/WHERE ('+MaisWher+') ' + '/*FINAPROBFILT*/'
          else
            SQL.Add('/*INICPROBFILT*/WHERE ('+MaisWher+')/*FINAPROBFILT*/');
        end;
      end;
      //Fim Problema Filter
      //*********************************************
    {$endif}
  end;

  procedure TsgQuery.DoBeforeOpen;
  var
    i, LinhFrom, LinhDepo, LinhWher: Integer;
    Sele, NomeCamp, MaisWher: String;
  begin
    {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
      if Assigned(Connection) then
      begin
        try
          Sele := Connection.Name;
          if Sele = '' then
            Connection := nil;
        except
          Connection := nil;
          if Assigned(sgTransaction) then
            sgTransaction.Connection := nil;
          SetPsgTrans(nil);
        end;
      end;
      if Assigned(sgTransaction) then
      begin
        try
          Sele := sgTransaction.Name;
          if Sele = '' then
            sgTransaction := nil;
        except
          Connection := nil;
          if Assigned(sgTransaction) then
            sgTransaction.Connection := nil;
          SetPsgTrans(nil);
        end;
        if Assigned(sgTransaction) and Assigned(sgTransaction.Connection) then
        begin
          try
            Sele := sgTransaction.Connection.Name;
            if Sele = '' then
              sgTransaction.Connection := nil;
          except
            Connection := nil;
            if Assigned(sgTransaction) then
              sgTransaction.Connection := nil;
            SetPsgTrans(nil);
          end;
        end;
      end;
      if Assigned(GetPsgTrans()) then
      begin
        try
          Sele := GetPsgTrans().Name;
        except
          Connection := nil;
          if Assigned(sgTransaction) then
            sgTransaction.Connection := nil;
          SetPsgTrans(nil);
        end;
      end;
      {$ifdef WS}
        if (not Assigned(Connection)) and Assigned(GetPADOConn()) then
          Connection := GetPADOConn;
      {$else}
        {$ifndef SAGUTIL}
          {$ifndef SAGSINC}
            {$ifdef ERPUNI}
              if not Assigned(sgTransaction) then
                sgTransaction := GetPsgTrans();
              if Assigned(sgTransaction) then
              begin
                if Assigned(sgTransaction.Connection) then
                  Connection  := sgTransaction.Connection
                else
                  sgTransaction.Connection  := GetPADOConn;
              end;
              if (not Assigned(Connection)) and Assigned(GetPADOConn()) then
                Connection := GetPADOConn;
            {$else}
              if System.Assigned(GetPADOConn()) {$ifdef PDADATASNAP} and not System.Assigned(Connection) {$endif} then
              begin
                if not Assigned(Connection) or
                   (Assigned(Connection) and
                    (not StrIn(AnsiUpperCase(Connection.Name), ['DTBNUME', 'DTBCADA', 'DTBSAG', 'DTBBASEAUXI', 'DTBCALL', 'DTBFINA']))) then
                  Connection := GetPADOConn;
              end;
            {$endif}
          {$endif}
        {$endif}
      {$endif}

      if (System.Pos('{',SQL.Text) > 0) or FTemExpr then // Ticket 8924 - FTemExpr
      begin
        FatExpr.OnVariable := DoVariable;
        FatExpr.OnEvaluate := DoFunc;
      end
      else
      begin
        FatExpr.OnVariable := nil;
        FatExpr.OnEvaluate := nil;
      end;

      if (not Assigned(Connection)) and Assigned(GetPADOConn()) and (Trim(ConnectionString) = '') then
        Connection := GetPADOConn;

      if (AnsiUpperCase(COPY(Name,01,06)) = 'QRYSQL') then  //Para aparecer as 6 casas decimais (Oracle)
        EnableBCD := False;

      Sele := TratSQL(SQL.Text);
      if SQL.Text <> Sele then
        SQL.Text := Sele;

      Ajusta_Filtro(False);

      GravMoniInic();  //Deixado aqui, para já pegar o SQL Tratado

      //MessageDlg('Antes'+#10#13+SQL.Text, mtInformation, [mbOK], 0);
    {$endif}

    inherited;
  end;

  {$ifdef ERPUNI}
    function TsgQuery.GetDataBaseName: TFDCustomConnection;
    begin
      Result := Connection;
    end;
    procedure TsgQuery.SetBaseName(const Value: TFDCustomConnection);
    begin
      Connection := Value;
    end;
    procedure TsgQuery.SetConnectionString(const Value: String);
    begin
      ConnectionName := Value;
    end;
    function TsgQuery.GetConnectionString: String;
    begin
      Result := ConnectionName;
    end;

    procedure TsgQuery.SetSort(const Value: String);
    begin
      IndexFieldNames := Value;
    end;

    function TsgQuery.GetSort: String;
    begin
      Result := IndexFieldNames;
    end;

    procedure TsgQuery.UpdateBatch;
    begin
      ApplyUpdates;
    end;

    procedure TsgQuery.CancelBatch;
    begin
      CancelUpdates;
    end;

  {$ELSE}
    function TsgQuery.GetDataBaseName: TADOConnection;
    begin
      Result := Connection;
    end;
    procedure TsgQuery.SetBaseName(const Value: TADOConnection);
    begin
      //ParamCheck := System.Pos(':',SQL.Text) > 0;
      ParamCheck := (Parameters.Count > 0);
      Connection := Value;
    end;
  {$ENDIF}


  function TsgQuery.GetParamCount: Word;
  begin
    Result := Parameters.Count;
  end;

  function TsgQuery.GetPBas: Integer;
  begin
    try
      if DatabaseName <> nil then
        Result := TsgADOConnection(DatabaseName).PBas
      else
        Result := FPBas;
    except
      //Erro de memória no Unigui
    end;
  end;

  function TsgQuery.GetSQL_Back: TWideStrings;
  begin
    Result := FSQL_Back;
  end;

  function TsgQuery.GetSQL_Modi: TWideStrings;
  begin
    Result := FSQL_Modi;
  end;

  function TsgQuery.getTableName(const value: String): String;
  begin
    if System.Pos('insert',LowerCase(value)) > 0 then
    begin
      Result := trim(StringReplace(value,'insert','',[rfReplaceAll,rfIgnoreCase]));  
      Result := trim(StringReplace(Result,'into','',[rfReplaceAll,rfIgnoreCase]));
      Result := trim(copy(Result,1,System.Pos(' ',Result)));
    end
    else if System.Pos('update',LowerCase(value)) > 0 then
    begin
      Result := trim(StringReplace(value,'update','',[rfReplaceAll,rfIgnoreCase]));
      Result := trim(copy(Result,1,System.Pos(' ',Result)));
    end
    else if System.Pos('delete',LowerCase(value)) > 0 then
    begin
      Result := trim(StringReplace(value,'delete','',[rfReplaceAll,rfIgnoreCase]));
      Result := trim(StringReplace(Result,'from','',[rfReplaceAll,rfIgnoreCase]));
      Result := trim(copy(Result,1,System.Pos(' ',Result)));
    end
    ELSE if Result = '' then
    begin
      Result := GetTableNameFromQuery(value);
    end;

    Result := UpperCase(Result);
  end;

//function TsgQuery.GetParams: TParameters;
  //begin
  //  Result := Parameters;
  //end;

  //function TsgQuery.ParamByName(const Value: string): TParameter;
  //begin
  //  Result := TParameter(Parameters.ParamByName(Value));
  //end;

  procedure TsgQuery.SetTamaCamp(const Value: Integer);
  begin
    FTamaCamp := Value;
  end;

  function TsgQuery.GetTamaCamp: Integer;
  begin
    if FTamaCamp = 0 then
      Result := {$ifdef ERPUNI} 30 {$else} 30 {$ENDIF}
    else
      Result := FTamaCamp;
  end;

  procedure TsgQuery.GetText(Sender: TField; var Text: string;DisplayText: Boolean);
  var
    Auxi: String;
    Resu: Real;
  begin
    Auxi := Trim(Sender.AsString);
    if (Copy(Auxi,01,01) = '{') and
       (Copy(Auxi,Length(Auxi),01) = '}') and
       (TipoDadoCara(Sender) <> 'M') then  //Fórmula
    begin
      Sender.Tag := 20; //Expressão
      try
        // sintaxe de variaveis: [var_name] -chama o evento DoVariable
        FatExpr.Text    := Copy(Auxi,02,Length(Auxi)-2);
        Resu := FatExpr.Value;
        if sgPos('R$',Sender.FieldName) > 0 then
          Text            := FormatFloat(Func.RetoMasc('R$'), Resu)
        else if sgPos('_INTE',Sender.FieldName) > 0 then
          Text            := FormatFloat(Func.RetoMasc('Inte'), Resu)
        else if Sender.EditMaskPtr <> '' then
          Text            := FormatFloat(Sender.EditMaskPtr, Resu)
        else
          Text            := FormatFloat(Func.RetoMasc('NMos'), Resu);
        Sender.Alignment:= taRightJustify;
        //Sender.DisplayWidth := 10;
      except
        Text := '#Erro';
      end;
    end
    else if DisplayText and (Sender.EditMaskPtr <> '') then //Tem máscara, aplica - Igual ao DB.Pas (TFieldText.GetText)
      Text := FormatMaskText(Sender.EditMaskPtr, Sender.AsString)
//    else if (RetoMasc(Sender.FieldName) <> '') then
//      Text := FormatMaskText(Func.RetoMasc(Sender.FieldName), Sender.AsString)
    else
      Text := Sender.AsString;
  end;

  //Formata dos Fields, conforme o Coluna ou o nome (RetoMasc)
  procedure TsgQuery.FormatFields;
  //*********************************************************
  //IGUAL sgQuery.FormatFiels = Func.FormatFiels
  //*********************************************************
  var
    i: Integer;
    TipoCamp: String;
    Unde: Boolean;
    Auxi, LinhConf, Masc: string;
    IniFiltCons: TDBIniMemo;

  begin
    //Erro de Memoria: Func.FormatFields(TsgClientDataSet(Self));
    IniFiltCons := TDBiniMemo.Create(Self);
    try
      IniFiltCons.Memo.Text := FColuna.Text;

      for i := 0 to Fields.Count - 1 do
      begin
        TipoCamp := TipoDadoCara(Fields[i]);

        if Fields[i].Tag <> 10 then
        begin
          LinhConf := IniFiltCons.ReadString('Colunas', Fields[i].FieldName, '');
          if LinhConf <> '' then
          begin
            Fields[i].Tag := 10;
            Masc := BuscValoChavText(LinhConf,'Masc');
            if Masc <> '' then
            begin
              if sgPos('{',Masc) > 0 then  //Tirar a fórmula
                Masc := Copy(Masc,01,sgPos('{',Masc)-1);

              {$ifdef FD} Masc := SubsPalaTudo(Masc,'#',''); {$endif}
              case TipoDadoCara(Fields[i]) of
               'N': TNumericField(Fields[i]).DisplayFormat := Masc;
               'I': TIntegerField(Fields[i]).DisplayFormat := Masc;
               'B': begin
                      if Masc[Length(Masc)] = '#' then
                        Masc[Length(Masc)] := '0';
                      TBCDField(Fields[i]).DisplayFormat := Masc;
                    end
              else
                Fields[i].EditMask := Masc;
              end;
            end;
            TamaCamp_Ajusta(Fields[i], BuscValoChavText(LinhConf,'Tama'));
          end;
        end;

        if Fields[i].Tag <> 10 then
        begin
          if (AnsiUpperCase(Copy(Fields[i].FieldName,01,05)) = 'CELU_') or
             (AnsiUpperCase(Copy(Fields[i].FieldName,01,05)) = 'COLU_') or
             (AnsiUpperCase(Copy(Fields[i].FieldName,01,05)) = 'LINH_') or
             (AnsiUpperCase(Copy(Fields[i].FieldName,01,09)) = 'LINHFONT_') then
          begin
            Fields[i].Visible := False;
            Fields[i].Tag     := 20;  //Para utilizar no sgDBG, criar uma coluna invisível lá
          end
          else
          begin
            TamaCamp_Ajusta(Fields[i], 0);

            if TipoCamp = 'N' then                      //Caso o Dado seja Número
            begin
              if System.Pos('R$',AnsiUpperCase(Fields[i].FieldName)) > 0 then
                (Fields[i] as TNumericField).DisplayFormat := Func.RetoMasc('R$')
              else
                (Fields[i] as TNumericField).DisplayFormat := Func.RetoMasc('NMos');
            end
            else if TipoCamp = 'I' then                 //Caso o Dado seja Inteiro
            begin
              TIntegerField(Fields[i]).DisplayFormat := Func.RetoMasc('Inte');
            end
            else if TipoCamp = 'B' then  //BCD
            begin
              if System.Pos('R$',AnsiUpperCase(Fields[i].FieldName)) > 0 then
                (Fields[i] as TNumericField).DisplayFormat := Func.RetoMasc('R$')
              else if TBCDField(Fields[i]).Size = 0 then  //Inteiro
                TBCDField(Fields[i]).DisplayFormat := Func.RetoMasc('Inte')
              else
                TBCDField(Fields[i]).DisplayFormat := Func.RetoMasc('NMos');
            end
            else if (RetoMasc(Fields[i].FieldName) <> '') then
              Fields[i].EditMask := Func.RetoMasc(Fields[i].FieldName);

            if Copy(Fields[i].FieldName, Length(Fields[i].FieldName), 01) = '_' then  //Último caracter for um "_"
            begin
              //Apaga todos os "_" do final do Nome do Campo
              Auxi := Fields[i].FieldName;
              Unde := Copy(Auxi, Length(Auxi), 01) = '_';
              if Unde then
              begin
                while Unde do
                begin
                  System.Delete(Auxi, Length(Auxi), 01); //Apaga o último caracter
                  Unde := Copy(Auxi, Length(Auxi), 01) = '_';
                end;
                Fields[i].DisplayLabel := Auxi;
              end;
            end
          end;
        end;

        if (TipoCamp = 'C') and Assigned(FatExpr) and Assigned(FatExpr.OnVariable) then
          Fields[i].OnGetText := GetText;
      end;

      //Exibe Chave, Primeiro Campo
      Fields[0].Visible := FExibChav;
      if (Name = 'QryGrid') and (Fields.Count > 1) and (StrIn(Copy(Fields[1].FieldName,01,04), ['MARC','SGCH'])) then
        Fields[1].Visible := FExibChav;
    finally
      FreeAndNil(IniFiltCons);
    end;
  end;

  procedure TsgQuery.DoBeforeClose;
  begin
    inherited;
  end;

  procedure TsgQuery.DoAfterError;
  begin
    FMonitor.Add('');
    FMonitor.Add('');
    FMonitor.Add('');
    GravMoniFina();
  end;

  procedure TsgQuery.CriaParameter(iNome: String; iTipo: TFieldType; iDire: TParameterDirection = pdInput; iSize: integer = 0);
  begin
    CriaParameter2(iNome, iTipo, iDire, iSize, Null);
  end;

  procedure TsgQuery.CriaParameter2(iNome: String; iTipo: TFieldType; iDire: TParameterDirection;           iSize: integer; iValue: OleVariant);
  begin
    {$ifdef ERPUNI}
      if not Assigned(Self.Params.FindParam(iNome)) then
      with Self.Params.Add do
      begin
        ParamType := TParamType(iDire);
    {$else}
      with Self.Parameters.AddParameter do
      begin
        Direction := iDire;
    {$ENDIF};
      Name     := iNome;
      DataType := iTipo;
      Size     := iSize;
      Value    := iValue;
    end;
  end;

  procedure TsgQuery.DoAfterOpen;
  begin
    {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
      DisableControls;
      {$ifndef ERPUNI}
        Properties['Update Criteria'].Value := 0;
      {$ENDIF}

      FormatFields;

      inherited;

      GravMoniFina();
      FsgState := 1;

      EnableControls;
    {$else}
      inherited;
    {$endif}
  end;

  procedure TsgQuery.DoAfterPost;
  begin
    inherited;

  end;

  procedure TsgQuery.DoBeforePost;
  {var
    i: Integer;
    Novo, Tipo: String;
    QryExec: TsgQuery;

    function DoBeferoPost_CampAlte(Campo : TField) : Boolean;
    begin
      if VarToStr(Campo.NewValue) = '' then
        Result := VarToStr(Campo.OldValue) <> ''
      else
      begin
        Result := VarToStr(Campo.OldValue) = '';
        if not Result then
          Result := VarToStr(Campo.OldValue) <> VarToStr(Campo.NewValue);
      end;
    end;}
  begin
    FsgState := 0;
    //FsgState := PosiProxVirg(LowerCase(self.SQL.Text),'from');

  {  QryExec := TsgQuery.Create(Self);
    try
      QryExec.Connection := Self.Connection;
      if State = dsedit then
        Tipo := 'A'
      else
        Tipo := 'I';

      for I := 0 to Fields.Count - 1 do
      begin
        if (AnsiUpperCase(Copy(Fields[i].FieldName,01,04)) <> 'PDAT') and  //Tira os campos PDAT
           (TipoDadoCara(Fields[i]) <> 'M') and //Tira os campos Memo
           ((Tipo = 'I') or DoBeferoPost_CampAlte(Fields[i])) then
        begin
          if Tipo = 'I' then  //Se for Inserção, pega o valor do campo
            Novo := Fields[i].AsString
          else
            Novo := VarToStr(Fields[i].NewValue);

          if not((Tipo = 'I') and (Novo = '')) then  //Se for Inserção e estiver '', não grava
          begin
            QryExec.Close;
            QryExec.SQL.Text := 'INSERT INTO POCALOG (TabeLog, TipoLog, CampLog, AntiLog, NovoLog) '+
                                'VALUES ('+QuotedStr(Self.PSGetTableName)+', '+QuotedStr(Tipo)+', '+
                                           QuotedStr(Fields[i].FieldName)+', '+
                                           QuotedStr(Copy(VarToStr(Fields[i].OldValue),01,250))+', '+
                                           QuotedStr(Copy(Novo,01,250))+')';
            QryExec.ExecSQL;
          end;
        end;
      end;
    finally
      QryExec.Close;
      FreeAndNil(QryExec);
    end;
    }
    {Validação comentada pois algumas telas do sistema ainda trabalham com alteração na query
    if (System.Pos(String('join'),LowerCase(self.SQL.Text)) > 0) or (System.Pos(String('cross apply'),LowerCase(self.SQL.Text)) > 0) then
    begin
      DtmPoul.Meu_Erro(nil, Exception.Create('Consulta não preparada para alteração!'));
      self.cancel;
      SysUtils.abort;
    end}

//SidiUniGui
//    if not (TrigAnte.TrigPrin(getTableName(self.SQL.Text), self.SQL.Text, self)) then
//    begin
//      self.cancel;
//      SysUtils.abort;
//    end;

    PegaOrigin();
    inherited;
  end;

  procedure TsgQuery.InternalLast;
  begin
    {$ifndef ERPUNI}
      // inherited; -> BUG: EOF é True, mas o registro não está no RecordCount
      if not Recordset.EOF then
      begin
        Recordset.MoveLast;
        UpdateBufferCount; // 02/04/2006: Luiz C. Moser: para corrigir o BUG do EOF
        if not Recordset.EOF then
          Recordset.MoveNext;
      end;
    {$ENDIF}
  end;

  //*** INTERNAL FIRST
  {procedure TsgQuery.InternalFirst;
  begin
    // inherited; -> BUG: EOF é True, mas o registro não está no RecordCount. Não tire o comentário dessa linha.

    if not Recordset.BOF then
    begin
      Recordset.MoveFirst;
      UpdateBufferCount; // 02/04/2006: Luiz C. Moser: para corrigir o BUG do EOF
      if Recordset.Supports(adMovePrevious) and not Recordset.BOF then // Esse movePrevious pode estar gerando o problema, BOF pode ser falso mas já deve estar no BOF
        Recordset.MovePrevious;
    end;
  end;
  }
{$else}
//************* DATASNAP  *************************
  procedure TsgQuery.UpdateBatch;
  begin
    ApplyUpdates(-1);
  end;

  procedure TsgQuery.GravMoniInic();
  var
    i: Integer;
    NovoSQL, Auxi: string;

    // Pega uma String passado com um valor REAL e retorna o valor com PONTO
    // Ex.: Pega 1.234.456,7890 <=> Retorna 123456.7890)
    // Obs.: Esta Função já possui o RetoZero
    Function FormPont(Nume: String):String;
    var
      i : integer;
      Enco : Boolean;  //Caso já encontrou o Ponto ou a Vírgula
    begin
      i := Length(Nume);
      Enco := False;
      while i > 0 do
      begin
        if not(Enco) then
        begin
          if Nume[i] in [',','.'] then
          begin
            Enco := True;
            Nume[i] := '.';
          end;
        end
        else
        begin
          if Nume[i] in [',','.'] then
            System.Delete(Nume,i,01);
        end;
        Dec(i);
      end;
      Result := Nume;
    end;

    //Formata a Data para String, conforme a Base de Dados
    Function FormDataStri(Data: TDateTime):String;
    begin
      if PBas = 4 then
        Result := QuotedStr(FormatDateTime('DD/MM/YYYY',Data))
      else if PBas = 3 then
        Result := QuotedStr(FormatDateTime('MM/DD/YYYY',Data))
      else if PBas = 2 then
        Result := QuotedStr(FormatDateTime('MM/DD/YYYY',Data))
      else
        Result := FormatDateTime('MM/DD/YYYY',Data);
    end;

    //Formata a Data para o SQL conforme a Base de Dados
    Function FormDataSQL(Data: TDateTime):String;
    begin
      Result := FormDataStri(Data);
      if PBas = 4 then
        Result := 'CAST('+ Result + 'AS DATE)'
      else if PBas = 3 then
        Result := 'CAST('+ Result + 'AS TIMESTAMP)';
    end;

  begin
    HoraInic := Now;
    if isGeraMoni() then
    begin

      FMonitor.Add('Qry: '+Name);
      if Assigned(Connection) then
      begin
        if Connection.ClassType = TsgADOConnection then
          FMonitor.Add('Connection: '+Connection.Name+'  '+FormInteBras(TsgADOConnection(Connection).CodiTabe)+SeStri(TsgADOConnection(Connection).InTransaction,' (Trans)',''))
        else
          FMonitor.Add('Connection: '+Connection.Name);
      end;

      NovoSQL := SQL.Text;
      if Parameters.Count > 0 then
      begin
       FMonitor.Add(IntToStr(Parameters.Count)+' Parâmetro(s):');
        for i := 0 to Parameters.Count - 1 do
        begin
          if Parameters[i].Value = Null then
            Auxi := 'Null'
          else if Parameters[i].DataType = ftInteger then
            Auxi := IntToStr(Parameters[i].Value)
          else if Parameters[i].DataType = ftFloat then
            Auxi := FormPont(FloatToStr(Parameters[i].Value))
          else if Parameters[i].DataType in [ftDate, ftDateTime] then
            Auxi := FormDataSQL(Parameters[i].Value)
          else if Parameters[i].DataType in [ftString, ftWideString] then
            Auxi := QuotedStr(Parameters[i].Value);

          FMonitor.Add(':'+Parameters[i].Name+' = '+Auxi);
          NovoSQL := SubsPalaTudo(NovoSQL, ':'+Parameters[i].Name, Auxi);
        end;
      end;
      if Filtered then
        FMonitor.Add('Filter: '+Filter);

      FMonitor.Add('SQL: '+NovoSQL);
      if GetPLogTipo() IN [2,3] then
      begin
        try
          ArquAdicText(FMonitor.Text+#13+'...', GetNomeArquLog_(GetPCodPess()));
        except
          //MessageDlg('Arquivo de Log ocupado!', mtInformation, [mbOK], 0);
        end;
      end;

      FMonitor.Add('*** Erro ***');
      FMonitor.Add('---------------------');

    end;
  end;

  procedure TsgQuery.GravMoniFina();
  var
    i: Integer;
  begin
    FHoraTota := Now-HoraInic;
    if isGeraMoni() then
    begin
      FMonitor.Delete(FMonitor.Count-1);
      FMonitor.Delete(FMonitor.Count-1);
      if Active then
        FMonitor.Add('Tempo: '+FormatDateTime('nn:ss:zzz',FHoraTota)+' ('+FormInteBras(RecordCount)+')')
      else
        FMonitor.Add('Tempo: '+FormatDateTime('nn:ss:zzz',FHoraTota));
      FMonitor.Add('---------------------');

      if GetPLogTipo() IN [2,3] then
      begin
        try
          if Active then
            ArquAdicText('Tempo: '+FormatDateTime('nn:ss:zzz',FHoraTota)+' ('+FormInteBras(RecordCount)+')', GetNomeArquLog_(GetPCodPess()))
          else
            ArquAdicText('Tempo: '+FormatDateTime('nn:ss:zzz',FHoraTota), GetNomeArquLog_(GetPCodPess()));
          ArquAdicText('---------------------------------------'        , GetNomeArquLog_(GetPCodPess()));
        except
          //MessageDlg('Arquivo de Log ocupado!', mtInformation, [mbOK], 0);
        end;
      end;

      if Assigned(Connection) and (Connection is  TsgADOConnection) then
      begin
        for I := 0 to FMonitor.Count - 1 do
          TsgADOConnection(Connection).Monitor.Add(FMonitor.Strings[i]);
        FMonitor.Clear;
      end
      else if Assigned(GetPADOConn) then
      begin
        for I := 0 to FMonitor.Count - 1 do
          GetPADOConn.Monitor.Add(FMonitor.Strings[i]);
        FMonitor.Clear;
      end;

    end;
  end;

  procedure TsgQuery.CancelBatch;
  begin
    CancelUpdates;
  end;

  constructor TsgQuery.Create(AOwner: TComponent);
  begin
    uCrioCompServ := False;
    uVersCone := 0;
    FLista  := TStringList.Create;
    FColuna := TStringList.Create;
    FColunaDBG := TStringList.Create;
    FMonitor:= TStringList.Create;
    FSQL_Back := TWideStringList.Create;
    FSQL_Modi := TWideStringList.Create;

    FCommand := TADOCommand.Create(Self);
    FParameters := TParameters.Create(Self, TParameter);
    FParamCheck := True;
    FSQL := TWideStringList.Create;
    TWideStringList(FSQL).OnChange := QueryChanged;
    inherited Create(AOwner);
  //  UpdateMode := upWhereKeyOnly;
  //  CommandTimeout := 600;
  //  CursorType := ctKeyset;
    FExibChav  := True;

    FatExpr := TFatExpression.Create(Self);
    FConfTabe := TCustomConfTabe.Create;

    //FilterOptions := FilterOptions + [foCaseInsensitive];  --Erro
    //Connection := GetPADOConn;

    //CriaCompServ();  --Ficou ao Setar o Nome ou antes de Abrir
    if AOwner = nil then
    begin
      FClientCria := GetPClientCria();
      if Assigned(FClientCria) then
      begin
        uCrioCompServ := True;
        uVersCone := FClientCria.RemoteServer.Tag;
        Self.RemoteServer := FClientCria.RemoteServer;
        Self.ProviderName := 'DspGera';
      end;
    end;
    uDestroi := True;
    FAbriu := 0;
    FUpdateOptions := TUpdateOptions.Create;
  end;

  destructor TsgQuery.Destroy;
  begin
    FreeAndNil(FatExpr);
    FreeAndNil(FConfTabe);
    FreeAndNil(FLista);
    FreeAndNil(FColuna);
    FreeAndNil(FColunaDBG);
    FreeAndNil(FMonitor);
    FreeAndNil(FSQL_Back);
    FreeAndNil(FSQL_Modi);
    FreeAndNil(FUpdateOptions);

    FreeAndNil(FSQL);
    FreeAndNil(FCommand);
    FreeAndNil(FParameters);
    FreeAndNil(FParams);

    if (Self.ProviderName <> '') and (Self.ProviderName <> 'DspGera') and Assigned(FClientCria) then
    begin
      if Assigned(FClientCria.RemoteServer) and FClientCria.RemoteServer.Connected then
      begin
        FClientCria.Close;
        FClientCria.ListaQuery := '{"result":[{"nome":"'+Self.ProviderName+'","acao":"free"}]}';
        FClientCria.Open;
      end;
    end;
    uDestroi := False;

    inherited Destroy;
  end;

  procedure TsgQuery.CriaCampos(iForm: TForm);
  begin
  end;

procedure TsgQuery.CriaCompServ();
  begin
    if FAbriu = 0 then
    begin
      uFechando := False;
      FClientCria := GetPClientCria();
      if Assigned(FClientCria) then
      begin
        if Assigned(FClientCria.RemoteServer) and FClientCria.RemoteServer.Connected then
        begin
          if (not uCrioCompServ) or (uVersCone <> FClientCria.RemoteServer.Tag) then
          begin
            uVersCone := FClientCria.RemoteServer.Tag;

            FClientCria.ListaQuery := '';
            FClientCria.Close;
            FClientCria.ListaQuery := '{"result":[{"nome":"sg'+Self.Name+'","acao":"cria"}]}';
            FClientCria.Open;  //Cria o componente no lado do servidor

            Self.RemoteServer := FClientCria.RemoteServer;
            if Copy(FClientCria.Texto,01,03) = 'Dsp' then
              Self.ProviderName := FClientCria.Texto
            else
              Self.ProviderName := 'Dspsg'+Self.Name;
            uCrioCompServ := True;
          end;
        end;
      end;
    end;
  end;

  procedure TsgQuery.DoVariable(Sender: TObject; Variable: string; var Value: Variant; var Done: Boolean);
  begin
    try
      if sgPos('''{',Variable) > 0 then
        Value := 0
      else
        Value := Self.FieldByName(Variable).AsFloat;
    except
      Value := 0;
    end;
  end;

  function TsgQuery.ExecSQL: Integer;
  var
    Linh, Posi: Integer;
    Auxi, Come: string;
    AbreCome: Boolean;

//SidiDataSnap
//    procedure InitializeMasterFields(Dataset: TCustomADODataset);
//    var
//      I: Integer;
//      MasterFieldList: string;
//    begin
//      with DataSet do
//        //Assign MasterFields from parameters as needed by the MasterDataLink
//        if (Parameters.Count > 0) and Assigned(MasterDataLink.DataSource) and
//          Assigned(MasterDataLink.DataSource.DataSet) then
//        begin
//          for I := 0 to Parameters.Count - 1 do
//            if (Parameters[I].Direction in [pdInput, pdInputOutput]) and
//              (MasterDataLink.DataSource.DataSet.FindField(Parameters[I].Name) <> nil) then
//              MasterFieldList := MasterFieldList + Parameters[I].Name + ';';
//          MasterFields := Copy(MasterFieldList, 1, Length(MasterFieldList)-1);
//          SetParamsFromCursor;
//        end;
//    end;

  begin
    //Connection :=GetPADOConn;
    SQL.Text := TratSQL(SQL.Text);
    AbreCome := False;
    for Linh := 0 to SQL.Count - 1 do
    begin
      if UpperCase(Copy(Trim(SQL[Linh]),1,6)) <> 'INSERT' then
      begin
        if not AbreCome then
          AbreCome := System.Pos(WideString('/*'),SQL.Strings[Linh]) > 0;

        if AbreCome then
          AbreCome := not (System.Pos(WideString('*/'),SQL.Strings[Linh]) > 0);

        if (not AbreCome) and (System.Pos(WideString('--'),SQL.Strings[Linh]) > 0) then
        begin
          Auxi := Copy(SQL.Strings[Linh],01,System.Pos(WideString('--'),SQL.Strings[Linh])-1);
          Come := Copy(SQL.Strings[Linh],   System.Pos(WideString('--'),SQL.Strings[Linh]), Length(SQL.Strings[Linh]));
          Come := SubsPalaTudo(Come,'/*','/ *');
          Come := SubsPalaTudo(Come,'*/','* /');
          Come := StringReplace(Come,'--','/*',[])+' */';
          SQL.Strings[Linh] := Auxi + Come;
        end;
      end;
    end;

    if (PBas = 2) and (Copy(AnsiUpperCase(SQL.Text),01,04) = 'EXEC') then //Problemas com Data na chamada de Procedimento do SQLServer
    begin
      Posi := System.Pos(WideString('CONVERT(DATETIME'), SQL.Text);
      while Posi > 0 do
      begin
        Auxi := Copy(SQL.Text, Posi, 30);
        SQL.Text := SubsPalaTudo(SQL.Text, Auxi, Copy(Auxi,18,12));
        Posi := System.Pos(WideString('CONVERT(DATETIME'), SQL.Text);
      end;

      //Tira os Parenteses
      SQL.Text := TiraPare(SQL.Text);  //Coloca as vezes para o Oracle, assim, fica padrão
    end;
    //SQL.SaveToFile('i:\sag\versao\SQL.txt');

    //SidiDataSnap InitializeMasterFields(Self);

    GravMoniInic;
    CommandText := SQL.Text;
    Execute;
    GravMoniFina;

    Result := Linh;
  end;

  procedure TsgQuery.DoFunc(Sender: TObject; Eval: string; Args: array of Variant;
      ArgCount: Integer; var Value: Variant; var Done: Boolean);
  begin
    Eval := UpperCase(Eval);

    if Eval = 'DATE' then
      Value := Date
    else if Eval = 'IF' then
    begin
      if ArgCount = 3 then
      begin
        if Args[0] > 0 then
          Value := Args[1]
        else
          Value := Args[2];
      end
      else
        Value := 0;
  //      raise exception.create('Falta Argumentos. Sintaxe: if(condição, valorverdade, valorfalso)');
    end
    else
      Value := 0;
  //    raise exception.createFMT('Objeto "%s" desconhecido', [Eval]);

    Done := True;
  end;

  procedure TsgQuery.SetActive(Value: Boolean);
  type
    TTipo = (clNada, clForm, clDtm);
      Function BuscPareWin(Comp: TClass; Classe: String = 'TWinControl'): Boolean;
      begin
        if Comp = Nil then
          Result := False
        else if AnsiUpperCase(Comp.ClassName) = AnsiUpperCase(Classe) then
          Result := True
        else
          Result := BuscPareWin(Comp.ClassParent);
      end;

    Var
      Clas: TTipo;
      vHoraInic: TTime;
      Abriu : Integer;
  begin
    Abriu := 0;
    if Value and (Tag IN [5,15]) and (Self.FileName = '') then
    begin
      if Self.Owner <> nil then
      begin
             if (BuscPareWin(Self.Owner.ClassType, 'TsgForm')) then Clas := clForm
        else if (BuscPareWin(Self.Owner.ClassType, 'TDtmPoul')) then Clas := clDtm
        else Clas := clNada;

        if Clas <> clNada then
        begin
          //MessageDlg(IntToStr(TsgForm(Self.Owner).HelpContext)+Self.Name, mtInformation, [mbOK], 0);
          if Clas = clForm then
          begin
            if TsgForm(Self.Owner).HelpContext = 0 then
              Self.FileName := GetPEndExec+'BancoDS\'+TsgForm(Self.Owner).Name+Self.Name+'.xml'
            else
              Self.FileName := GetPEndExec+'BancoDS\'+IntToStr(TsgForm(Self.Owner).HelpContext)+Self.Name+'.xml';
          end
          else if Clas = clDtm then
            Self.FileName := GetPEndExec+'BancoDS\'+Self.Owner.Name+Self.Name+'.xml';
          if FileExists(Self.FileName) then
          begin
            Abriu := 1;
            vHoraInic := Now;
            FAbriu := 10;
            Self.LoadFromFile(Self.FileName);

            if isGeraMoni() and (GetPLogTipo() IN [2,3]) then
            begin
              try
                ArquAdicText('XML: '+FormatDateTime('nn:ss:zzz',Now-vHoraInic), GetNomeArquLog_(GetPCodPess()));
                ArquAdicText('---------------------'                          , GetNomeArquLog_(GetPCodPess()));
              except
                //MessageDlg('Arquivo de Log ocupado!', mtInformation, [mbOK], 0);
              end;
            end;
          end
          else
          begin
            Abriu := 2;  //Salvar os dados
            FAbriu := 0;
          end;
        end;
      end;
    end;

    if Abriu <> 1 then
    begin
      if Value or (Self.ProviderName <> 'DspGera') or (not uDestroi) then
        inherited SetActive(Value);
    end;

    if Abriu = 2 then
      Self.SaveToFile(Self.FileName, dfXML);
  end;

  procedure TsgQuery.DoBeforeClose;
  begin
    uFechando := True;
    inherited;
  end;

  procedure TsgQuery.DoAfterError;
  begin
    FMonitor.Add('');
    FMonitor.Add('');
    FMonitor.Add('');
    GravMoniFina();
  end;

  procedure TsgQuery.CriaParameter(iNome: String; iTipo: TFieldType; iDire: TParameterDirection = pdInput; iSize: integer = 0);
  begin
    CriaParameter2(iNome, iTipo, iDire, iSize, Null);
  end;

  procedure TsgQuery.CriaParameter2(iNome: String; iTipo: TFieldType; iDire: TParameterDirection;           iSize: integer; iValue: OleVariant);
  var
    Para: {$ifdef ERPUNI} TFDParam {$else} TParameter {$ENDIF};
  begin
    {$ifdef ERPUNI}
      Para := Self.Params.Add;
      Para.ParamType := TParamType(iDire);
    {$else}
      Para := Self.Parameters.AddParameter;
      Para.Direction := iDire;
    {$ENDIF};
    Para.Name     := iNome;
    Para.DataType := iTipo;
    Para.Size     := iSize;
    Para.Value    := iValue;
  end;

  procedure TsgQuery.SetBaseName(const Value: TADOConnection);
  begin
    FADOConnection := Value;
  end;

  procedure TsgQuery.SetLista(Value: TStrings);
  begin
    if FLista.Text <> Value.Text then
    begin
      FLista.BeginUpdate;
      try
        FLista.Assign(Value);
      finally
        FLista.EndUpdate;
      end;
    end;
  end;

  procedure TsgQuery.SetColuna(Value: TStrings);
  begin
    if FColuna.Text <> Value.Text then
    begin
      FColuna.BeginUpdate;
      try
        FColuna.Assign(Value);
      finally
        FColuna.EndUpdate;
      end;
    end;
  end;

  procedure TsgQuery.SetFiltered(Value: Boolean);
  var
    Orde : String;

    procedure AbreFilt_AbreFech();
    begin
      Orde := Sort;
      Close;
      Open;
      if Orde <> '' then
        Sort := Orde;
    end;

  begin
    try
      if (Filter <> '') then
      begin
        if not((System.Pos(') OR (',Filter) > 0) and (System.Pos(') AND (',Filter) > 0)) and
           not((System.Pos(' NOT LIKE ',Filter) > 0)) then
        begin
          if (System.Pos(WideString('/*INICPROBFILT*/'),SQL.Text) > 0) then  //Se ainda tiver filtro, limpa e depois set o Filtered
            AbreFilt_AbreFech();
          inherited SetFiltered(Value)
        end
        else
          AbreFilt_AbreFech();
      end
      else //O filtro for vazio (else)
      begin
        if System.Pos(WideString('/*INICPROBFILT*/'),SQL.Text) > 0 then
          AbreFilt_AbreFech()
        else
          inherited SetFiltered(Value);
      end;
    except
      on E: Exception do
        if msgNovaMsg('Coluna não disponível para Filtro!') then
          msgOk(E.Message);
    end;
  end;

  procedure TsgQuery.SetMonitor(Value: TStrings);
  begin
    if FMonitor.Text <> Value.Text then
    begin
      FMonitor.BeginUpdate;
      try
        FMonitor.Assign(Value);
      finally
        FMonitor.EndUpdate;
      end;
    end;
  end;

  procedure TsgQuery.SetName(const NewName: TComponentName);
  begin
    inherited;
    //CriaCompServ();
  end;

procedure TsgQuery.SetParameters(const Value: TParameters);
  begin
    Command.Parameters.Assign(Value);
  end;

  procedure TsgQuery.SetSQL_Back(const Value: TWideStrings);
  begin
    FSQL_Back.Assign(Value);
  end;

  procedure TsgQuery.SetSQL_Modi(const Value: TWideStrings);
  begin
    FSQL_Modi.Assign(Value);
  end;

  procedure TsgQuery.sgOpen;
  begin
    if not Active then
      Open;
  end;

  procedure TsgQuery.sgRefresh(iMark: Boolean);
  {$ifdef ERPUNI}
  {$else}
    var
      vMark : TBookMark;
  {$endif}
  begin
    {$ifdef ERPUNI}
      Refresh;
    {$else}
      //Requery();
      if iMark then
        vMark := Self.GetBookmark;
      try
        sgClose;
        sgOpen;
      finally
        if iMark then
        begin
          try
            if Self.BookmarkValid(vMark) then
              Self.GotoBookmark(vMark);
            Self.FreeBookmark(vMark);
          except
            Self.FreeBookmark(vMark);
          end;
        end;
      end;
    {$endif}
  end;

  procedure TsgQuery.PegaOrigin;
  begin
  end;

  procedure TsgQuery.sgClose;
  begin
    if Active then
      Close;
  end;

  function TsgQuery.Soma(iCamp: String): Real;
  begin
    Result := 0;
    if Active then
    begin
      DisableControls;
      First;
      while not Eof do
      begin
        Result := Result + FieldByName(iCamp).AsFloat;
        Next;
      end;
      EnableControls;
    end;
  end;

  function TsgQuery.ListaIn(iCamp: String): String;
  begin
    Result := '';
    if Active then
    begin
      DisableControls;
      First;
      while not Eof do
      begin
        Result := Result + SeStri(Result = '', '', ', ')+QuotedStr(FieldByName(iCamp).AsString);
        Next;
      end;
      if Result = '' then
        Result := '(''0'')'
      else
        Result := '('+Result+')';
      EnableControls;
    end;
  end;

  function TsgQuery.Filtra(iFilt: String): Boolean;
  begin
    Result := True;
    if Active then
    begin
      Filtered := False;
      if iFilt <> '' then
      begin
        Filter := iFilt;
        Filtered := True;
      end;
    end;
  end;

  function TsgQuery.isGeraMoni(): Boolean;
  begin
    {$ifdef SAGSINC}
      Result := True;
    {$endif}
    {$ifdef PDADATASNAP}
      Result := True;
    {$else}
      Result := GetPLogTipo() IN [2,3]; //IsAdmiClie or IsAdmiSAG;
    {$endif}
  end;

  procedure TsgQuery.QueryChanged(Sender: TObject);
  begin
    if Active and (not (csLoading in ComponentState)) then
      Close;
  end;

  procedure TsgQuery.DoBeforeOpen;
  var
    i, LinhFrom, LinhDepo, LinhWher: Integer;
    Sele, NomeCamp, MaisWher: String;
  begin
    {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
      //SetPLblAjud_Capt('a');
      CriaCompServ();
      //SetPLblAjud_Capt('b');

      if (AnsiUpperCase(COPY(Name,01,06)) = 'QRYSQL') then  //Para aparecer as 6 casas decimais (Oracle)
        EnableBCD := False;

      if System.Pos('{',SQL.Text) > 0 then
      begin
        FatExpr.OnVariable := DoVariable;
        FatExpr.OnEvaluate := DoFunc;
      end
      else
      begin
        FatExpr.OnVariable := nil;
        FatExpr.OnEvaluate := nil;
      end;

      //SQL.Text := TratSQL(SQL.Text);  //Trata no lado do Servidor
                                                          
      //*********************************************
      //Problema do Filter
      begin
        //Tira o Filtro anterior
        for I := 0 to SQL.Count - 1 do
        begin
          if System.Pos(WideString('/*INICPROBFILT*/'),SQL.Strings[i]) > 0 then
            SQL.Strings[i] := Copy(SQL.Strings[i],01,System.Pos(WideString('/*INICPROBFILT*/'),SQL.Strings[i])-1);
          if System.Pos(WideString('/*FINAPROBFILT*/'),SQL.Strings[i]) > 0 then
            SQL.Strings[i] := Copy(SQL.Strings[i],System.Pos(WideString('/*FINAPROBFILT*/'),SQL.Strings[i])+17,Length(SQL.Strings[i]));
        end;

        if ((System.Pos(') OR (',Filter) > 0) and (System.Pos(') AND (',Filter) > 0)) or
           ((System.Pos(' NOT LIKE ',Filter) > 0)) then
        begin
          LinhWher := 0;
          LinhDepo := 0;
          LinhFrom := 0;
          for I := 0 to SQL.Count - 1 do
          begin
            if (AnsiUpperCase(Copy(Trim(SQL.Strings[i]),01,08)) = 'ORDER BY') Or
               (AnsiUpperCase(Copy(Trim(SQL.Strings[i]),01,08)) = 'GROUP BY')then
              LinhDepo := i;
            if AnsiUpperCase(Copy(Trim(SQL.Strings[i]),01,05)) = 'WHERE' then
              LinhWher := i;
            if AnsiUpperCase(Copy(Trim(SQL.Strings[i]),01,04)) = 'FROM' then
              LinhFrom := i;
          end;

          Sele := '';
          for i := 0 to LinhFrom - 1 do   //Pega todo o SELECT
            Sele := Sele + SQL.Strings[i];

          NomeCamp := 'SSSAAAGGGGAAAGGGSSSGG';
          i := 1;
          MaisWher := Filter;
          while NomeCamp <> '' do
          begin
            NomeCamp := PegaCampSele(Sele,i);
            if NomeCamp <> '' then
            begin
              NomeCamp := PegaNomeCamp(NomeCamp,i);
              if System.Pos(AnsiUpperCase(NomeCamp), AnsiUpperCase(MaisWher)) > 0 then
                MaisWher := SubsPalaTudo(MaisWher, '['+NomeCamp+']', PegaCampManuGene(Sele,i));
            end;
            Inc(i);
          end;
          if LinhWher > 0 then
            SQL.Strings[LinhWher] := SQL.Strings[LinhWher] + '/*INICPROBFILT*/ AND ('+MaisWher+')/*FINAPROBFILT*/'
          else if LinhDepo > 0 then
            SQL.Strings[LinhDepo-1] := SQL.Strings[LinhDepo-1] + '/*INICPROBFILT*/WHERE ('+MaisWher+') ' + '/*FINAPROBFILT*/'
          else
            SQL.Add('/*INICPROBFILT*/WHERE ('+MaisWher+')/*FINAPROBFILT*/');
        end;
      end;
      //Fim Problema Filter
      //*********************************************

      GravMoniInic();  //Deixado aqui, para já pegar o SQL Tratado
    {$endif}

    //MessageDlg('Antes'+#10#13+SQL.Text, mtInformation, [mbOK], 0);
    inherited;
  end;

  function TsgQuery.GetDataBaseName: TADOConnection;
  begin
    Result := FADOConnection;
  end;

  function TsgQuery.GetParamCount: Word;
  begin
    Result := Parameters.Count;
  end;

  function TsgQuery.GetParameters: TParameters;
  begin
    Result := Command.Parameters;
  end;

  function TsgQuery.GetPBas: Integer;
  begin
    if DatabaseName <> nil then
      Result := TsgADOConnection(DatabaseName).PBas
    else
      Result := FPBas;
  end;

  function TsgQuery.GetSQL: TWideStrings;
  begin
    Result := FSQL;
  end;
  
  procedure TsgQuery.SetSQL(const Value: TWideStrings);
  begin
    if Value.Text <> FSQL.Text then
    begin
      Active := False;
      FSQL.Assign(Value);
    end;
  end;

  function TsgQuery.GetSQL_Back: TWideStrings;
  begin
    Result := FSQL_Back;
  end;

  function TsgQuery.GetSQL_Modi: TWideStrings;
  begin
    Result := FSQL_Modi;
  end;

  //function TsgQuery.GetParams: TParameters;
  //begin
  //  Result := Parameters;
  //end;

  //function TsgQuery.ParamByName(const Value: string): TParameter;
  //begin
  //  Result := TParameter(Parameters.ParamByName(Value));
  //end;

  procedure TsgQuery.GetText(Sender: TField; var Text: string;DisplayText: Boolean);
  var
    Auxi: String;
  begin
    Auxi := Trim(Sender.AsString);
    if (Copy(Trim(Auxi),01,01) = '{') and
       (Copy(Trim(Auxi),Length(Trim(Auxi)),01) = '}') and
       (TipoDadoCara(Sender) <> 'M') then  //Fórmula
    begin
      Sender.Tag := 20; //Expressão
      try
        // sintaxe de variaveis: [var_name] -chama o evento DoVariable
        FatExpr.Text    := Copy(Auxi,02,Length(Auxi)-2);
        if System.Pos('R$',AnsiUpperCase(Sender.FieldName)) > 0 then
          Text            := FormatFloat(RetoMasc('R$'), FatExpr.Value)
        else if System.Pos('_INTE',AnsiUpperCase(Sender.FieldName)) > 0 then
          Text            := FormatFloat(RetoMasc('Inte'), FatExpr.Value)
        else
          Text            := FormatFloat(RetoMasc('NMos'), FatExpr.Value);
        Sender.Alignment:= taRightJustify;
        //Sender.DisplayWidth := 10;
      except
        Text := '#Erro';
      end;
    end
    else if DisplayText and (Sender.EditMaskPtr <> '') then //Tem máscara, aplica - Igual ao DB.Pas (TFieldText.GetText)
      Text := FormatMaskText(Sender.EditMaskPtr, Sender.AsString)
    else
      Text := Sender.AsString;
  end;

  //Formata dos Fields, conforme o Coluna ou o nome (RetoMasc)
  procedure TsgQuery.FormatFields;
  const
    cTamaCampNume = {$ifdef ERPUNI} 15 {$else} 15 {$ENDIF};
  var
    i, Tama: Integer;
    TipoCamp: String;
    Unde: Boolean;
    Auxi, LinhConf, Masc: string;
    IniFiltCons: TDBIniMemo;

  begin
    IniFiltCons := TDBiniMemo.Create(Self);
    try
      IniFiltCons.Memo.Text := FColuna.Text;

      if TamaCamp = 0 then
        TamaCamp := {$ifdef ERPUNI} 40 {$else} 30 {$ENDIF};

      for i := 0 to Fields.Count - 1 do
      begin
        TipoCamp := TipoDadoCara(Fields[i]);

        if Fields[i].Tag <> 10 then
        begin
          LinhConf := IniFiltCons.ReadString('Colunas', Fields[i].FieldName, '');
          if LinhConf <> '' then
          begin
            Masc := BuscValoChavText(LinhConf,'Masc');
            if Masc <> '' then
            begin
              Fields[i].Tag := 10;
              if sgPos('{',Masc) > 0 then  //Tirar a fórmula
                Masc := Copy(Masc,01,sgPos('{',Masc)-1);
              case TipoDadoCara(Fields[i]) of
               'N': TNumericField(Fields[i]).DisplayFormat := Masc;
               'I': TIntegerField(Fields[i]).DisplayFormat := Masc;
               'B': TBCDField(Fields[i]).DisplayFormat := Masc;
              else
                Fields[i].EditMask := Masc;                     
              end;
            end;
            TamaCamp_Ajusta(Fields[i], BuscValoChavText(LinhConf,'Tama'));
          end;
        end;

        if Fields[i].Tag <> 10 then
        begin
          if StrIn(AnsiUpperCase(Copy(Fields[i].FieldName,01,05)), ['CELU_', 'COLU_', 'LINH_', 'LINHF']) then  //LINHF = LINHFONT_
          begin
            Fields[i].Visible := False;
            Fields[i].Tag     := 20;  //Para utilizar no sgDBG, criar uma coluna invisível lá
          end
          else
          begin
            if TipoCamp = 'N' then                      //Caso o Dado seja Número
            begin
              if System.Pos('R$',AnsiUpperCase(Fields[i].FieldName)) > 0 then
                (Fields[i] as TNumericField).DisplayFormat := Func.RetoMasc('R$')
              else
                (Fields[i] as TNumericField).DisplayFormat := Func.RetoMasc('NMos');
            end
            else if TipoCamp = 'I' then                 //Caso o Dado seja Inteiro
              TIntegerField(Fields[i]).DisplayFormat := Func.RetoMasc('Inte')
            else if TipoCamp = 'B' then  //BCD
            begin
              if System.Pos('R$',AnsiUpperCase(Fields[i].FieldName)) > 0 then
                (Fields[i] as TNumericField).DisplayFormat := Func.RetoMasc('R$')
              else if TBCDField(Fields[i]).Size = 0 then  //Inteiro
                TBCDField(Fields[i]).DisplayFormat := Func.RetoMasc('Inte')
              else
                TBCDField(Fields[i]).DisplayFormat := Func.RetoMasc('NMos');
              Fields[i].DisplayWidth := cTamaCampNume;
            end
            else if (RetoMasc(Fields[i].FieldName) <> '') then
              Fields[i].EditMask := Func.RetoMasc(Fields[i].FieldName);

            if Copy(Fields[i].FieldName, Length(Fields[i].FieldName), 01) = '_' then  //Último caracter for um "_"
            begin
              Fields[i].Tag := 10;
              Fields[i].DisplayWidth := Length(Fields[i].DisplayLabel)*15;

              //Apaga todos os "_" do final do Nome do Campo
              Auxi := Fields[i].FieldName;
              Unde := Copy(Auxi, Length(Auxi), 01) = '_';
              if Unde then
              begin
                while Unde do
                begin
                  System.Delete(Auxi, Length(Auxi), 01); //Apaga o último caracter
                  Unde := Copy(Auxi, Length(Auxi), 01) = '_';
                end;
                Fields[i].DisplayLabel := Auxi;
              end;

            end
            else if (TipoCamp = 'C') then
            begin
              if (TamaCamp <> 0) then  //Apenas para quando for Texto
              begin
                if (Length(Fields[i].DisplayLabel) > TamaCamp) then
                  Fields[i].DisplayWidth := Length(Fields[i].DisplayLabel)
                else
                  Fields[i].DisplayWidth := TamaCamp;
              end;
            end;
          end;
        end;

        if (TipoCamp = 'C') and Assigned(FatExpr.OnVariable) then
          Fields[i].OnGetText := GetText;
      end;

      //Exibe Chave, Primeiro Campo
      Fields[0].Visible := FExibChav;
    finally
      FreeAndNil(IniFiltCons);
    end;
  end;

  procedure TsgQuery.DoBeforeGetRecords(var OwnerData: OleVariant);
  var
    i: integer;
    SQL_, Auxi: String;
  begin
//    OwnerData := VarArrayOf([ContinentEqual, PopulationMin, NameStart]);
//    if VarIsArray(OwnerData) and (VarArrayHighBound(OwnerData, 1) = 2) then
//    begin
//      ContinentEqual := OwnerData[0];
//      PopulationMin := OwnerData[1];
//      NameStart := Ownerdata[2];
//    end;

    //SetPLblAjud_Capt('c');
    if (not uFechando) and (not Assigned(BeforeGetRecords)) and (SQL.Text <> '') then
    begin
      SQL_ := SQL.Text;
      for i := 0 to Parameters.Count - 1 do
      begin
        Auxi := '';
        if Parameters[i].Value = Null then
          Auxi := 'Null'
        else if Parameters[i].DataType = ftInteger then
          Auxi := IntToStr(Parameters[i].Value)
        else if Parameters[i].DataType = ftFloat then
          Auxi := FormPont(FloatToStr(Parameters[i].Value))
        else if Parameters[i].DataType in [ftDate, ftDateTime] then
          Auxi := FormDataSQL(Parameters[i].Value)
        else if Parameters[i].DataType in [ftString, ftWideString] then
          Auxi := QuotedStr(Parameters[i].Value);

        SQL_ := SubsPalaTudo(SQL_, ':'+Parameters[i].Name, Auxi);
      end;
      OwnerData := SQL_;
    end
    else
      inherited;
    //SetPLblAjud_Capt('d');
  end;

  procedure TsgQuery.sgClone(iQry: TDataSet);
   {$ifdef ERPUNI}
   {$else}
    var
      i : Integer;
   {$endif}
  begin
   {$ifdef ERPUNI}
     iQry.CloneCursor(iQry);
   {$else}
      for i := 0 to (iQry.FieldCount - 1) do
      begin
        Self.FieldByName(iQry.Fields[i].FieldName).ReadOnly := False;
        if iQry.Fields[i].IsNull then
          Self.FieldByName(iQry.Fields[i].FieldName).Value := Null
        else if TipoDadoCara(iQry.Fields[i]) = 'D' then
          Self.FieldByName(iQry.Fields[i].FieldName).AsDateTime := iQry.Fields[i].AsDateTime
        else
          Self.FieldByName(iQry.Fields[i].FieldName).AsString := iQry.Fields[i].AsString;
      end;
   {$endif}
  end;

procedure TsgQuery.ConfigurarupWhereKeyOnly(ClientDataSet: TClientDataSet);
//  var
//    lIdx: Integer;
  begin
//    ClientDataSet.Fields[0].ProviderFlags := [pfInUpdate,pfInWhere,pfInKey];
//    DataSetProvider1.UpdateMode := upWhereKeyOnly;
//
//    for lIdx := 0 to ClientDataSet.Fields.Count -1 do
//    begin
//  //    if (ClientDataSet.Fields[lIdx].FieldKind in [fkData]) then
//        if ClientDataSet.Fields[lIdx].FieldName = 'ID' then
//        begin
//          ClientDataSet.Fields[lIdx].ProviderFlags := [pfInUpdate,pfInWhere,pfInKey];
//        end
//        else
//        begin
//          ClientDataSet.Fields[lIdx].ProviderFlags := [pfInUpdate];
//        end;
//    end;
  end;

  procedure TsgQuery.DoAfterOpen;
  begin
    {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
      DisableControls;
      FormatFields;
      inherited;

      ConfigurarupWhereKeyOnly(Self);

      GravMoniFina();
      FsgState := 1;

      EnableControls;
    {$else}
      inherited;
    {$endif}
  end;

  procedure TsgQuery.DoBeforePost;
  var
    CampPDat: String;
  begin
    if Self.State = dsEdit then  //Por causa do WhereChange, quando tem dois campos com o mesmo valor na Query
    begin
      CampPDat := 'PDat'+Copy(Self.Fields[0].FieldName,05,04);
      if VeriExisCampTabe(Self, CampPDat) then
        Self.FieldByName(CampPDat).AsDateTime := Now;
    end;
    //ConfigurarupWhereKeyOnly(Self);
    if EnableBCD then
      EnableBCD := False;
    inherited;
  end;

  procedure TsgQuery.DoAfterPost;
  begin
    inherited;
    Self.ApplyUpdates(-1);
  end;

  procedure TsgQuery.DoAfterDelete;
  begin
    inherited;
    Self.ApplyUpdates(-1);
  end;

  procedure TsgQuery.InternalLast;
  begin
    inherited;
  end;
//************* FIM DATASNAP  *************************
{$endif}

procedure Register;
begin
  RegisterComponents('DBPlus', [TsgQuery]);
end;

end.