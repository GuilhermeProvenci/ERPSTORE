unit unit_funcoes;

interface



uses
  Vcl.Forms, Vcl.ExtCtrls, Vcl.Graphics, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.Mask, Winapi.Windows, Vcl.DBGrids, Vcl.Grids, Data.DB, FireDAC.Comp.Client,
  System.Classes, Vcl.Controls, unit_cadastro_padrao,
  System.SysUtils, gplQry, gplEdit, gplForm;

  function SomenteNumeros( AString: String ): String;
  function RemoveCaracteres( AString: String ): String;
  procedure ValidarCampoObrigatorios ( Form : TForm );
  procedure MudarBotao ( Form: Tform; Botao : TPanel );
  function Criptografia( Senha: string ): string;
  function CriarMensagem ( Tipo, MSG : String ) : boolean;
  function StringReplaceAll(const Texto: string; const CaracteresRemover: string): string;

  procedure prcDrawColumnCell( Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  procedure prc_pintar_titulo_coluna( dbg: TDBGrid; Coluna : TColumn );
  procedure prc_ajusta_tamanho_linha ( dbg: TDBGrid );
  procedure prc_ajustar_colunas_grid(const xDBGrid: TDBGrid);


  procedure InsertGenerico(const NomeTabela: string; const NomesCampos: string; const Valores: array of string);
  procedure NomeCampos(const NomeTabela: string; NomesCampos: TStrings);
  procedure ChamarInsertGenerico(const NomeTabela: string; AContainer: TWinControl);
  function AcharEdit99(AContainer: TWinControl): TArray<TControl>;

  procedure maxID(const TableName: string; Edit: TEdit);
  procedure limpaEDit(Form : Tform);
  function CalcDoisCamp(TextSQL: String; var Val1, Val2: integer) : integer;

  procedure ChamarUpdateGenerico(const NomeTabela: string; AContainer: TWinControl);
  procedure AtualizarGenerica(const NomeTabela: string; const NomesCamposAtualizar: string; Valores: array of string; const Condicao: string; NomesCampos: TStringList);
  function GetVersaoArq: string;
  function DayPassword(iData: TDate) :String;
  function AltTableData(const TableName, FieldName, OldValue, NewValue, OptionalAnd: string): Boolean;
  function TableExists(const TableName: string; Query: TgpQry): Boolean;
  procedure CreateTable(const TableName: string; const Fields: array of string);
  function GetTableColumns(const TableName: string): TArray<string>;
  procedure DropTable(const TableName: string);
  procedure AddColumn(const TableName, ColumnName, ColumnType: string);

  procedure CarregarCamposClasse(form: TgpForm; Classe: TObject);
  function SubsTudo(Text: String; const Substituicoes: array of string): String;


type
  TDBGridPadrao = class( TCustomGrid );
  ECustomError = class(Exception);

VAR //variaveis globais
  var_gbl_resposta_msg : Boolean;
  Var_gbl_versao :String;

implementation

uses unit_mensagem, unit_conexao, Vcl.Dialogs, Vcl.ComCtrls, System.Math,
  System.Rtti;

//function getQry(sql: String; qryName: String='qryGetQry'; iComp: TObject=nil): TsgQuery;
//begin
//  Result := GetQry(nil, SQL, QryName, iComp);
//end;
//function getQry(iOwner: TComponent; sql: String; qryName: String='qryGetQry'; iComp: TObject=nil): TsgQuery;
//begin
//  Result := CriaQuery(iOwner, iComp, qryName);
//  Result.SQL.Text := sql;
//  Result.Open;
//end;
//Function CriaQuery(iOwner: TComponent; const iComp: TObject = nil; iName: String = ''; iTag: Integer = 888): TsgQuery;
//var
//  vQuer: TsgQuery;
//  vComp: TObject;
//
//  procedure CriaQuery_Cria();
//  begin
//    vQuer      := TsgQuery.Create(iOwner);
//    if iName = '' then
//      vQuer.Name := 'Qry_DmPlus_CriaQuery'
//    else
//      vQuer.Name := iName;
//    vQuer.Tag  := iTag;
//  end;
//
//begin
//  vComp  := iComp;
//  if not Assigned(vComp) then
//    vComp := GetPsgTrans();
//  if not Assigned(vComp) then
//    CriaQuery_Cria
//  else if (vComp.ClassType = TsgQuery) then
//  begin
//    vQuer := TsgQuery(vComp);
//    if vQuer.Tag = 888 then  //Quando reusa a Query, está sendo eliminada no Finally, com isso, não elimina
//      vQuer.Tag := 0;
//    vQuer.Close;
//    vQuer.SQL.Clear;
//  end
//  else
//  begin
//    CriaQuery_Cria;
//    if ((vComp is tsgADOConnection) or (vComp is TADOConnection) or (vComp is TFDConnection)) then
//    begin
//      vQuer.Connection    := TSgADOConnection(vComp);
//      vQuer.sgTransaction := TsgTransaction(vComp);
//    end
//    else if ((vComp is TsgTransaction) or (vComp is TFDTransaction)) then
//      vQuer.sgTransaction := TsgTransaction(vComp)
//  end;
//  vQuer.EnableBCD := False;
//  Result := vQuer;

//***
{Como usar
var
  vQuer: TsgQuery;
begin
  vQuer := CriaQuery(iComp);
  try
    with vQuer do
    begin
      Name := 'Qry';
    end;
  finally
    vQuer.Close;
    if vQuer.Tag = 888 then
      FreeAndNil(vQuer);
  end;
end;
}
//end;

// Executar a manuten��o, verificando se insere ou faz update em uma Tabela
//function ManuDadoTabe(Tabe: string; Chav, Valo: array of string; Camp: string = '';
//  Por_Comp: Boolean = False; iComp: TObject = nil; iWher: string = ''): Int64;
//var
//  i: Integer;
//  NovoCamp, Wher: string;
//  vQuery: TFDQuery;
//  MergedArr: Array of string;
//  ChavEmpty: Boolean;
//begin
//  if (Length(Chav) = 0) and (iWher.Trim = '') then
//    Result := InseDadoTabe(Tabe, Valo, Camp, Por_Comp, iComp)
//  else
//  begin
//    iWher := iWher.Trim;
//
//    NovoCamp := Camp;
//    if Camp = '' then
//      NovoCamp := 'CODI' + Copy(Tabe, 5, MaxInt);
//
//    vQuery := TFDQuery.Create(nil);
//    try
//      vQuery.Connection := TFDConnection(iComp); // Substitua pelo seu objeto de conex�o
//
//      ChavEmpty := True;
//      for i := 0 to Length(Chav) - 1 do
//        if not Chav[i].Trim.IsEmpty then
//        begin
//          ChavEmpty := False;
//          Break;
//        end;
//
//      if ChavEmpty then
//        Wher := ''
//      else if (Length(Chav) = 2) and (AnsiUpperCase(Chav[0]) = AnsiUpperCase(NovoCamp)) and IsDigit(Chav[1]) then
//      begin
//        Result := StrToInt(Chav[1]);
//        if Result > 0 then
//        begin
//          Wher := 'WHERE ' + NovoCamp + ' = ' + IntToStr(Result);
//          if not iWher.IsEmpty then
//            Wher := Wher + ' AND ' + iWher;
//          Result := CalcInte(vQuery, 'SELECT ' + NovoCamp + ' FROM ' + Tabe + ' ' + Wher, 0);
//        end
//        else
//        begin
//          Chav[0] := '';
//          Chav[1] := '';
//        end;
//      end
//      else if (Length(Chav) = 2) and (AnsiUpperCase(Chav[0]) = AnsiUpperCase(NovoCamp)) and (AnsiUpperCase(Chav[1]) = 'NULL') then
//      begin
//        Result := 0;
//        Chav[0] := '';
//        Chav[1] := '';
//      end
//      else
//      begin
//        SetLength(MergedArr, Length(Chav));
//        Wher := '';
//        i := 0;
//        while i <= (Length(Chav) - 1) do
//        begin
//          if Wher <> '' then
//            Wher := Wher + ' AND ';
//          if AnsiUpperCase(Chav[i + 1]) = 'NULL' then
//            Wher := Wher + '(' + Chav[i] + ' IS NULL'
//          else
//            Wher := Wher + '(' + Chav[i] + ' = ' + QuotedStr(Chav[i + 1]);
//          Inc(i);
//          Wher := Wher + ')';
//          Inc(i);
//        end;
//      end;
//
//      if Result = 0 then
//      begin
//        SetLength(MergedArr, Length(Chav) + Length(Valo));
//        for I := 0 to Length(Chav) - 1 do
//          MergedArr[i] := Chav[i];
//        for I := 0 to Length(Valo) - 1 do
//          MergedArr[Length(Chav) + i] := Valo[i];
//        Result := InseDadoTabe(Tabe, MergedArr, Camp, Por_Comp, iComp);
//      end
//      else
//      begin
//        // Substitua 'CampoID' pelo nome da coluna da chave prim�ria
//        AlteDadoTabe(Tabe, Valo, 'WHERE CampoID = ' + IntToStr(Result), Por_Comp, iComp);
//      end;
//    finally
//      vQuery.Free;
//    end;
//  end;
//
//  if Result <> 0 then
//  begin
//    // Substitua 'TrigPrin' pelo nome da fun��o para executar as triggers
//    TrigPrin(Tabe, IntToStr(Result), iComp);
//  end;
//end;
//
//// Executar o UPDATE em uma Tabela
//procedure AlteDadoTabe(Tabe: string; Valo: array of string; Wher: string;
//  Por_Comp: Boolean = False; iComp: TObject = nil; Apat: Boolean = False);
//var
//  i: Integer;
//  SeleCamp, ApatCamp: string;
//  vQuery: TFDQuery;
//begin
//  SeleCamp := '';
//  i := 0;
//
//  while i <= (Length(Valo) - 1) do
//  begin
//    if Valo[i].Trim = '' then
//      Inc(i, 2)
//    else
//    begin
//      SeleCamp := SeleCamp + ', ' + Valo[i];
//      Inc(i);
//      if not Por_Comp then
//        SeleCamp := SeleCamp + ' = ' + Valo[i];
//      Inc(i);
//    end;
//  end;
//  SeleCamp := Copy(SeleCamp, 3, Length(SeleCamp) - 2);
//
//  vQuery := TFDQuery.Create(nil);
//  try
//    vQuery.Connection := TFDConnection(iComp); // Substitua pelo seu objeto de conex�o
//
//    if not Por_Comp then
//    begin
//      vQuery.ExecSQL('UPDATE ' + Tabe + ' SET ' + SeleCamp + ' ' + Wher);
//    end
//    else
//    begin
//      if Apat then
//        ApatCamp := 'APAT' + AnsiUpperCase(Copy(Tabe, 5, 100));
//
//      vQuery.SQL.Clear;
//      vQuery.SQL.Add('SELECT ' + SeleCamp + SeStri(Apat, ', ' + ApatCamp, '') + ' FROM ' + Tabe);
//      vQuery.SQL.Add(Wher);
//      vQuery.Open;
//      vQuery.Edit;
//
//      if Apat then
//        vQuery.FieldByName(ApatCamp).AsInteger := Abs(vQuery.FieldByName(ApatCamp).AsInteger + 1);
//
//      i := 0;
//      while i <= (Length(Valo) - 1) do
//      begin
//        if Valo[i + 1] <> '' then
//        begin
//          if AnsiUpperCase(Valo[i + 1]) = 'NULL' then
//            vQuery.FieldByName(Valo[i]).Clear
//          else if (vQuery.FieldByName(Valo[i]).DataType = ftFloat) then
//            vQuery.FieldByName(Valo[i]).AsFloat := StrToFloat(StringReplace(Valo[i + 1], '.', ',', []))
//          else
//          begin
//            Valo[i + 1] := StringReplace(Valo[i + 1], '''''', '%$%$%$%$%$%$', '');
//            Valo[i + 1] := StringReplace(Valo[i + 1], '''', '', '');
//            Valo[i + 1] := StringReplace(Valo[i + 1], '%$%$%$%$%$%$', '''', '');
//            if AnsiUpperCase(Valo[i + 1]) = 'NULL' then
//              vQuery.FieldByName(Valo[i]).Clear
//            else
//              vQuery.FieldByName(Valo[i]).AsString := Valo[i + 1];
//          end;
//        end;
//        Inc(i, 2);
//      end;
//      vQuery.Post;
//    end;
//  finally
//    vQuery.Free;
//  end;
//end;


procedure limpaEDit(Form: TForm);
var
  i: Integer;
begin
  for i := 0 to Form.ComponentCount - 1 do
  begin
    // Testando se � TEdit
    if (Form.Components[i] is TEdit) then
    begin
      (Form.Components[i] as TEdit).Text := '';
    end
    else if (Form.Components[i] is TDBLookUpComboBox) then
    begin
      (Form.Components[i] as TDBLookUpComboBox).KeyValue := -1;
    end;
  end;
end;


function AcharEdit99(AContainer: TWinControl): TArray<TControl>;
var
  i: Integer;
  ControlList: TArray<TControl>;
begin
  SetLength(ControlList, 0);

  for i := 0 to AContainer.ControlCount - 1 do
  begin
    if (AContainer.Controls[i] is TEdit) or
       (AContainer.Controls[i] is TDBLookupComboBox) or
       (AContainer.Controls[i] is TComboBox) or
       (AContainer.Controls[i] is TDateTimePicker) then
    begin
      if AContainer.Controls[i].Tag = 99 then
      begin
        SetLength(ControlList, Length(ControlList) + 1);
        ControlList[High(ControlList)] := AContainer.Controls[i];
      end;
    end;

    if AContainer.Controls[i] is TWinControl then
      ControlList := ControlList + AcharEdit99(TWinControl(AContainer.Controls[i]));
  end;

  Result := ControlList;
end;


procedure InsertGenerico(const NomeTabela: string; const NomesCampos: string; const Valores: array of string);
var
  qryInserir: TgpQry;
  i: Integer;
begin
  qryInserir := TgpQry.Create(nil);
  try
    qryInserir.SQL.Text := 'INSERT INTO ' + NomeTabela + '(' + NomesCampos + ') VALUES (';
    for i := 0 to High(Valores) do
    begin
      qryInserir.SQL.Add(':' + IntToStr(i + 1));
      if i < High(Valores) then
        qryInserir.SQL.Add(',');
    end;
    qryInserir.SQL.Add(')');

    // Definir os valores como parametros
    for i := 0 to High(Valores) do
    begin
      qryInserir.Params[i].Value := Valores[i];
    end;

    qryInserir.ExecSQL;
  finally
    qryInserir.Free;
  end;
end;



procedure NomeCampos(const NomeTabela: string; NomesCampos: TStrings);
var
  qry: TgpQry;
  i: Integer;
begin
  qry := TgpQry.Create(nil);
  try
    qry.SQL.Text := 'SELECT * FROM ' + NomeTabela + ' WHERE 1 = 0'; // N�o traz dados, apenas estrutura
    qry.Open;

    for i := 0 to qry.FieldDefs.Count - 1 do
    begin
      NomesCampos.Add(qry.FieldDefs[i].Name);
    end;
  finally
    qry.Free;
  end;
end;

procedure ChamarInsertGenerico(const NomeTabela: string; AContainer: TWinControl);
var
  NomesCampos: TStringList;
  i: Integer;
  NomesCamposInserir: string;
  Valores: array of string;
  ControlesValores: TArray<TControl>; // Usado para qualquer controle (TEdit ou TDBLookupComboBox)
begin
  NomesCampos := TStringList.Create;
  try
    NomeCampos(NomeTabela, NomesCampos);

    // Crie uma string com os nomes dos campos separados por v�rgula
    NomesCamposInserir := '';
    for i := 0 to NomesCampos.Count - 1 do
    begin
      NomesCamposInserir := NomesCamposInserir + NomesCampos[i];
      if i < NomesCampos.Count - 1 then
        NomesCamposInserir := NomesCamposInserir + ', ';
    end;

    // Preencha o array de ControlesValores com os controles que t�m a tag 99
    ControlesValores := AcharEdit99(AContainer);

    // Preencha o array de valores com os valores dos controles
    SetLength(Valores, Length(ControlesValores));
    for i := 0 to High(ControlesValores) do
    begin
      if ControlesValores[i] is TEdit then
        Valores[i] := TEdit(ControlesValores[i]).Text
      else if (ControlesValores[i] is TDBLookupComboBox) then
        Valores[i] := TDBLookupComboBox(ControlesValores[i]).Text // ou KeyValue, dependendo do que voc� deseja
      else if (ControlesValores[i] is TComboBox)  then
        Valores[i] := TComboBox(ControlesValores[i]).Text
      else if ControlesValores[i] is TDateTimePicker then
           Valores[i] := FormatDateTime('yyyy/mm/dd' ,TDateTimePicker(ControlesValores[i]).DateTime);

    end;



    // Chame a fun��o InserirGenerica passando os campos resultantes e os valores dos controles
    InsertGenerico(NomeTabela, NomesCamposInserir, Valores);
  finally
    NomesCampos.Free;
  end;
end;


procedure maxID(const TableName: string; Edit: TEdit);
var
  qrySelect: TgpQry;
begin
  qrySelect := TgpQry.Create(nil);
  try
    qrySelect.SQL.Text := 'SELECT max(id) as id FROM ' + TableName;
    qrySelect.Open;

    if not qrySelect.FieldByName('id').IsNull then
      Edit.Text := IntToStr(qrySelect.FieldByName('id').AsInteger + 1)
    else
      Edit.Text := '1';
  finally
    qrySelect.Free;
  end;
end;



//funcao que retorna uma string de numeros sem os caracteres caso exista
function SomenteNumeros( AString: String ): String;
var
  I : Integer;
  Limpos : String;
begin

  Limpos := '';

  //percorra a string caracter por caracter
  for I := 1 to Length( AString ) do
  begin

  //verifico se � um numero
    if Pos ( Copy( AString, I, 1 ), '0123456789') > 0 then
      Limpos := Limpos + Copy( AString, i, 1 ); //so copia para a variavel se for numero

  end;

  //retorno para a funcao
  Result := Limpos;
end;


function CalcDoisCamp(TextSQL: String; var Val1, Val2: integer) : integer;
var
  vQuer: TgpQry;
begin
  vQuer := TgpQry.Create(nil);
  try
    with vQuer do
    begin
      SQL.Text := TextSQL;
      Open;

      Val1 := Ifthen((Fields.Count >= 1) and (not IsEmpty) and (not Fields[0].IsNull), Fields[0].AsInteger, 0);

      Val2 := IfThen((Fields.Count >= 2) and (not IsEmpty) and (not Fields[1].IsNull), Fields[1].AsInteger, 0);
    end;
  finally
    vQuer.Close;
    FreeAndNil(vQuer);
  end;
  result := val1 + val2;
end;



procedure ChamarUpdateGenerico(const NomeTabela: string; AContainer: TWinControl);
var
  NomesCampos: TStringList;
  i: Integer;
  NomesCamposAtualizar: string;
  Valores: array of string;
  ControlesValores: TArray<TControl>;
  Condicao: string;
begin
  NomesCampos := TStringList.Create;
  try
    NomeCampos(NomeTabela, NomesCampos);

    // Crie uma string com os nomes dos campos que ser�o atualizados
    NomesCamposAtualizar := '';
    for i := 0 to NomesCampos.Count - 1 do
    begin
      NomesCamposAtualizar := NomesCamposAtualizar + NomesCampos[i] + ' = :' + NomesCampos[i];
      if i < NomesCampos.Count - 1 then
        NomesCamposAtualizar := NomesCamposAtualizar + ', ';
    end;

    // Preencha o array de ControlesValores com os controles que t�m a tag 99
    ControlesValores := AcharEdit99(AContainer);

    // Preencha o array de valores com os valores dos controles
    SetLength(Valores, Length(ControlesValores));
    for i := 0 to High(ControlesValores) do
    begin
      if ControlesValores[i] is TEdit then
        Valores[i] := TEdit(ControlesValores[i]).Text
      else if ControlesValores[i] is TDBLookupComboBox then
        Valores[i] := TDBLookupComboBox(ControlesValores[i]).Text // ou KeyValue, dependendo do que voc� deseja
      else if ControlesValores[i] is TDateTimePicker then
        Valores[i] := FormatDateTime('yyyy/mm/dd', TDateTimePicker(ControlesValores[i]).DateTime)
      else if (ControlesValores[i] is TComboBox)  then
        Valores[i] := TComboBox(ControlesValores[i]).Text
    end;

    Condicao := NomesCampos[0] + ' = ' + QuotedStr(Valores[0]); // Adicione QuotedStr para lidar com strings

    // Chame a fun��o AtualizarGenerica passando os campos a serem atualizados, os valores dos controles, a condi��o e a lista de nomes de campos
 AtualizarGenerica(NomeTabela, NomesCamposAtualizar, Valores, Condicao, NomesCampos);


  finally
    NomesCampos.Free;
  end;
end;

procedure AtualizarGenerica(const NomeTabela: string; const NomesCamposAtualizar: string; Valores: array of string; const Condicao: string; NomesCampos: TStringList);
var
  qryAtualizar: TgpQry;
  SQLAtualizar: string;
  i: Integer;
begin
  qryAtualizar := TgpQry.Create(nil);
  try
    SQLAtualizar := 'UPDATE ' + NomeTabela + ' SET ' + NomesCamposAtualizar + ' WHERE ' + Condicao;

    qryAtualizar.SQL.Text := SQLAtualizar;

    // Defina os parametros com nomes correspondentes aos nomes dos campos da tabela
    for i := 0 to NomesCampos.Count - 1 do
    begin
      qryAtualizar.ParamByName(NomesCampos[i]).Value := Valores[i];
    end;


    qryAtualizar.ExecSQL;
  finally
    qryAtualizar.Free;
  end;
end;



//funcao que retorna uma string sem os caracteres especiais caso exista
function RemoveCaracteres( AString: String ): String;
var
  I : Integer;
  Limpos : String;
begin

  Limpos := '';

  //percorra a string caracter por caracter
  for I := 1 to Length( AString ) do
  begin

  //verifico se � um caracter especial
    if Pos ( Copy( AString, I, 1 ), '"!%$#@&�*().,;:/<>[]{}=+-_\|') = 0 then
      Limpos := Limpos + Copy( AString, i, 1 ); //so copia para a variavel se nao for caracter

  end;

  //retorno para a funcao
  Result := Limpos;
end;


//funcao que percorre todos os componentes do form vericando
//qual � obrigatorio e qual nao esta preenchido
procedure ValidarCampoObrigatorios ( Form : TForm );
var
  i:Integer;

begin

  //percorre todos os componentes do form
  for I := 0 to Form.ComponentCount - 1 do
  begin

    //se o tag = 99 entao indicara que � componente obrigatorio
    if ( Form.Components[i].Tag = 99 ) then
    begin
      //testando o Tedit
      if ( form.Components[i] is TEdit ) and
         ( ( form.Components[i] as TEdit ).Hint <> '' ) and //Se a Mensagem do Campo vazio nao estiver em branco
         ( ( form.Components[i] as TEdit ).Visible ) and  //se ele estiver visivel
         ( ( form.Components[i] as TEdit ).Enabled ) and
         ( ( form.Components[i] as TEdit ).Text = '' ) then //se ele estiver habilitado
      begin
         CriarMensagem ('aviso','O Campo ' + ( form.Components[i] as TEdit ).Hint +
                         ' � de preenchimento obrigat�rio!'); //avisa o usuario

        ( form.Components[i] as TEdit ).SetFocus; //poe o foco no componente

        Abort;  //aborta para nao executar mais nenhum codigo
      end;


      //testando o TDBedit
      if ( form.Components[i] is TDBEdit ) and     //testando o Tedit
         ( ( form.Components[i] as TDBEdit ).Hint <> '' ) and //Se a Mensagem do Campo vazio nao estiver em branco
         ( ( form.Components[i] as TDBEdit ).Visible ) and  //se ele estiver visivel
         ( ( form.Components[i] as TDBEdit ).Enabled ) and
         ( ( form.Components[i] as TDBEdit ).Text = '' ) then //se ele estiver habilitado
      begin
         CriarMensagem ('aviso','O Campo ' + ( form.Components[i] as TDBEdit ).Hint +
                         ' � de preenchimento obrigat�rio!'); //avisa o usuario

        ( form.Components[i] as TDBEdit ).SetFocus; //poe o foco no componente

        Abort;  //aborta para nao executar mais nenhum codigo
      end;



      //testando o TComboBox
      if ( form.Components[i] is TComboBox ) and     //testando o Tedit
         ( ( form.Components[i] as TComboBox ).Hint <> '' ) and //Se a Mensagem do Campo vazio nao estiver em branco
         ( ( form.Components[i] as TComboBox ).Visible ) and  //se ele estiver visivel
         ( ( form.Components[i] as TComboBox ).Enabled ) and
         ( ( form.Components[i] as TComboBox ).Text = '' ) then //se ele estiver habilitado
      begin
         CriarMensagem ('aviso','O Campo ' + ( form.Components[i] as TComboBox ).Hint +
                         ' � de preenchimento obrigat�rio!'); //avisa o usuario

        ( form.Components[i] as TComboBox ).SetFocus; //poe o foco no componente

        Abort;  //aborta para nao executar mais nenhum codigo
      end;


      //testando o TDBComboBox
      if ( form.Components[i] is TDBComboBox ) and     //testando o Tedit
         ( ( form.Components[i] as TDBComboBox ).Hint <> '' ) and //Se a Mensagem do Campo vazio nao estiver em branco
         ( ( form.Components[i] as TDBComboBox ).Visible ) and  //se ele estiver visivel
         ( ( form.Components[i] as TDBComboBox ).Enabled ) and
         ( ( form.Components[i] as TDBComboBox ).Text = '' ) then //se ele estiver habilitado
      begin
         CriarMensagem ('aviso','O Campo ' + ( form.Components[i] as TDBComboBox ).Hint +
                         ' � de preenchimento obrigat�rio!'); //avisa o usuario

        ( form.Components[i] as TDBComboBox ).SetFocus; //poe o foco no componente

        Abort;  //aborta para nao executar mais nenhum codigo
      end;


      //testando o TDBlookUpComboBox
      if ( form.Components[i] is TDBlookUpComboBox ) and     //testando o Tedit
         ( ( form.Components[i] as TDBlookUpComboBox ).Hint <> '' ) and //Se a Mensagem do Campo vazio nao estiver em branco
         ( ( form.Components[i] as TDBlookUpComboBox ).Visible ) and  //se ele estiver visivel
         ( ( form.Components[i] as TDBlookUpComboBox ).Enabled ) and
         ( ( form.Components[i] as TDBlookUpComboBox ).Text = '' ) then //se ele estiver habilitado
      begin
         CriarMensagem ('aviso','O Campo ' + ( form.Components[i] as TDBlookUpComboBox ).Hint +
                         ' � de preenchimento obrigat�rio!'); //avisa o usuario

        ( form.Components[i] as TDBlookUpComboBox ).SetFocus; //poe o foco no componente

        Abort;  //aborta para nao executar mais nenhum codigo
      end;


      //testando o TMemo
      if ( form.Components[i] is TMemo ) and     //testando o Tedit
         ( ( form.Components[i] as TMemo ).Hint <> '' ) and //Se a Mensagem do Campo vazio nao estiver em branco
         ( ( form.Components[i] as TMemo ).Visible ) and  //se ele estiver visivel
         ( ( form.Components[i] as TMemo ).Enabled ) and
         ( ( form.Components[i] as TMemo ).Text = '' ) then //se ele estiver habilitado
      begin
         CriarMensagem ('aviso','O Campo ' + ( form.Components[i] as TMemo ).Hint +
                         ' � de preenchimento obrigat�rio!'); //avisa o usuario

        ( form.Components[i] as TMemo ).SetFocus; //poe o foco no componente

        Abort;  //aborta para nao executar mais nenhum codigo
      end;


      //testando o TMaskEdit
      if ( form.Components[i] is TMaskEdit ) and     //testando o Tedit
         ( ( form.Components[i] as TMaskEdit ).Hint <> '' ) and //Se a Mensagem do Campo vazio nao estiver em branco
         ( ( form.Components[i] as TMaskEdit ).Visible ) and  //se ele estiver visivel
         ( ( form.Components[i] as TMaskEdit ).Enabled ) and
         ( RemoveCaracteres ( ( form.Components[i] as TMaskEdit ).Text ) = '' ) then //se ele estiver habilitado
      begin
         CriarMensagem ('aviso','O Campo ' + ( form.Components[i] as TMaskEdit ).Hint +
                         ' � de preenchimento obrigat�rio!'); //avisa o usuario

        ( form.Components[i] as TMaskEdit ).SetFocus; //poe o foco no componente

        Abort;  //aborta para nao executar mais nenhum codigo
      end;

    end;// fim do tag =99

  end; //fim do for que percorre os componentes

end;
procedure MudarBotao ( Form: Tform; Botao : TPanel );
var
  i: Integer;

begin
  //percorre todos os componentes do formulario
  for i:= 0 to Form.ComponentCount - 1 do
  begin
     //selecionando os label tag <> de 0, indicando que sao labels dos botoes
     if ( Form.Components[i] is TLabel ) and
        ( ( Form.Components[i] as TLabel ).Tag > 0 ) then
     begin

       //se a tag do label =  a do botao focado entao mud a cor
       if ( Botao as TPanel ).Tag = ( Form.Components[i] as TLabel ).Tag then
       begin
         ( Form.Components[i] as TLabel ).Font.Color := $000080FF;
         ( Form.Components[i] as TLabel ).Font.Style := [fsBold];
       end else //nao tem a mesma tage entao � label dos outros botoes
       begin
         ( Form.Components[i] as TLabel ).Font.Color := clWhite;
         ( Form.Components[i] as TLabel ).Font.Style := [];
       end;

     end;


    //voltar a cor original de todos os outros botoes
    if ( Form.Components[i] is TPanel ) and
       (
         ( ( ( Form.Components[i] as TPanel ).Parent ).Name = 'pnl_menulateral' ) or
         ( ( ( Form.Components[i] as TPanel ).Parent ).Name = 'pnl_submenu_config' ) or
         ( ( ( Form.Components[i] as TPanel ).Parent ).Name = 'pnl_submenu_tabelas' )
       ) then
    begin
       ( Form.Components[i] as TPanel ).Color := $00191919;
    end;

  end;

  //muda a cor do panel focado para um tom mais escuro
  ( Botao as TPanel ).Color      := $00141414;
end;

//funcao que gera uma sequencia de caracteres a partir de uma chave
function Criptografia( Senha: string ): string;
var
  x,y : Integer;
  Chave, NovaSenha : String;

begin
  Chave:= 'EmissorNFE';

  //percorre a chave caracter por caracter
  for x := 1 to Length( Chave ) do
  begin

    //limpa a variavel temporaria
    NovaSenha := '';

    //percorre a senha passado por parametro caracter por caracter
    for y := 1 to Length( Senha ) do
    begin
      //realiza operacoes logicas para trocar caracteres da senha por outros
      NovaSenha := NovaSenha + chr( ( Ord( Chave[x] ) xor Ord( Senha[y] ) ) );
    end;

    //A senha passada por parametro recebe o resultado das opea�oes logicas
    Senha := NovaSenha;
  end;

  //o resultado da senha � passado para o retorno da funcao
  Result := Senha;
end;


function CriarMensagem ( Tipo, MSG : String ) : boolean;
begin

  //inicializa o retorno da funcao
  Result := False;

  Try
    //cria o form mensagem
    form_mensagem       := TForm_mensagem.Create ( nil );

    //passa para o form o tipo de mensagem e o texto que deseja mostrar
    form_mensagem.sTipo := Tipo;
    form_mensagem.lbl_descricao.caption := MSG;

    // mostra o form
    form_mensagem.ShowModal;

    //retorna para funcao a resposta SIM OU NAO do usuario
    Result := var_gbl_resposta_msg;

    //reinicializa o valor da variavel
    var_gbl_resposta_msg := False;
  Finally

    //libera o form da memoria
    FreeandNil (form_mensagem);

  End;

end;

function StringReplaceAll(const Texto: string; const CaracteresRemover: string): string;
var
  i: Integer;
begin
  Result := Texto;

  for i := 1 to Length(CaracteresRemover) do
    Result := StringReplace(Result, CaracteresRemover[i], '', [rfReplaceAll]);
end;


//prcedure responsavel por mudar a cor da selecao e zebrar um dbgrid
procedure prcDrawColumnCell( Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  //zebrando o dbgrid
  if Odd( ( Sender as TDbgrid ).DataSource.DataSet.RecNo) then
    ( Sender as TDbgrid ).Canvas.Brush.Color :=  $00FBFBFB
  else
    ( Sender as TDbgrid ).Canvas.Brush.Color := clwhite;//$00F9F9F9;


  //mudando a cor da sele��o
  if ( gdSelected in State ) then
  begin
    ( Sender as TDbgrid ).Canvas.Brush.Color := $00FFE8CC; //cor da linha
    ( Sender as TDbgrid ).Canvas.Font.Color  := clBlack;   //cor da fonte
    ( Sender as TDbgrid ).Canvas.Font.Style  := [fsBold];  //estilo da fonte
  end;

  ( Sender as TDbgrid ).Canvas.FillRect(Rect);
  ( Sender as TDbgrid ).DefaultDrawColumnCell( Rect, DataCol, Column, State);

  //mudando a posicao e alinhamento vertical do texto de cada linha
  if Column.Field.DataType = ftBCD then
    ( Sender as TDbgrid ).Canvas.TextRect( Rect, Rect.Left - 8 + ( Rect.Width - (( Sender as TDbgrid ).Canvas.TextWidth ( Column.Field.DisplayText ) ) ), Rect.Top + 8 , Column.Field.DisplayText )
  else
    ( Sender as TDbgrid ).Canvas.TextRect( Rect, Rect.Left + 8, Rect.Top + 8, Column.Field.DisplayText );

end;


//procedure que pinta o titulo da coluna que esta sendo usada para ordenar os dados no dbgrid
procedure prc_pintar_titulo_coluna( dbg: TDBGrid; Coluna : TColumn );
var
  i:Integer;

begin

  //pintando o titulo da coluna do dbgrid
  for I := 0 to dbg.Columns.Count - 1  do
  begin
    if dbg.Columns[i].FieldName = Coluna.FieldName then
    begin
       //se for a coluna enviada por parametro entao mudo a cor do titulo (fonte)
      dbg.Columns[i].Title.Font.Color := clRed;  //cor da fonte
      dbg.Columns[i].Title.Font.Style := [fsBold]; //estilo da fonte
    end else
    begin
      // se nao for coloca no padrao
      dbg.Columns[i].Title.Font.Color := clBlack;
      dbg.Columns[i].Title.Font.Style := [];
    end;
  end;

end;

//aumenta o tamanho da linha do dbgrid sem mudar a fonte
procedure prc_ajusta_tamanho_linha (dbg: TDBGrid );
begin
  //Define o tamanho de cada linha do dbgrid apos ativar a query
  TDBGridPadrao(dbg).DefaultRowHeight := 30;
  TDBGridPadrao(dbg).ClientHeight     := ( 30 * TDBGridPadrao(dbg).RowCount ) + 30;

  TDBGridPadrao(dbg).RowHeights[0] := 30;
end;


//funcao para ajustar as colunas do dbgrid de acordo com o tamanho da tela
procedure prc_ajustar_colunas_grid(const xDBGrid: TDBGrid);
var
  I, TotalWidht, VarWidth, QtdTotalColuna : Integer;
  xColumn : TColumn;
begin

  //sempre mostro a barra lateral do dbgrid
  ShowScrollBar( xDBGrid.Handle,SB_Vert, True );


  //percorre o dbgrid alterando a tag da coluna que possuir o nome abaixo
  For I := 0 to xDBGrid.FieldCount - 1 do
  begin

    if ( UpperCase( xDBGrid.Fields[I].FieldName ) = 'DESCRICAO' ) or
       ( UpperCase( xDBGrid.Fields[I].FieldName ) = 'NOME' )  or
       ( UpperCase( xDBGrid.Fields[I].FieldName ) = 'ENDERECO' )  then
      xDBGrid.Fields[I].Tag := 30 //pode ser qualquer valor, � so pra diferenciar a coluna
    else
      xDBGrid.Fields[I].Tag := 0;

  end;

  // Largura total de todas as colunas antes de redimensionar
  TotalWidht := 0;

  // Quantas colunas devem ter auto-redimensionamento
  QtdTotalColuna := 0;

  //percorre o dbgrid para descobrir o tamanho total dele e a quantidade de
  //colunas que irao mudar de tamanho
  for I := 0 to -1 + xDBGrid.Columns.Count do
  begin
    TotalWidht := TotalWidht + xDBGrid.Columns[I].Width;

    if xDBGrid.Columns[I].Field.Tag <> 0 then
      Inc( QtdTotalColuna );
  end;

  // Adiciona 1px para a linha de separador de coluna
  if dgColLines in xDBGrid.Options then
    TotalWidht := TotalWidht + xDBGrid.Columns.Count;

  // width vale "Left"
  VarWidth :=  xDBGrid.ClientWidth - TotalWidht;

  // Da mesma forma distribuir VarWidth para todas as colunas auto-resizable
  if QtdTotalColuna > 0 then
    VarWidth := varWidth div QtdTotalColuna;

  //redimensionando as colunas
  for I := 0 to -1 + xDBGrid.Columns.Count do
  begin
    xColumn := xDBGrid.Columns[I];

    if xColumn.Field.Tag <> 0 then
    begin
      xColumn.Width := xColumn.Width + VarWidth;

      if xColumn.Width < xColumn.Field.Tag then
        xColumn.Width := xColumn.Field.Tag;
    end;
  end;

end;

//funcao que pega o valor da versao do executavel e retorna uma sting
function GetVersaoArq: string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  try
    GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
    VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
    with VerValue^ do
    begin
      Result := IntToStr(dwFileVersionMS shr 16);                   // Major
      Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF); // Minor
      Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);    // Release
      Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF); // Build
    end;
  finally
    FreeMem(VerInfo, VerInfoSize);
  end;
end;


function DayPassword(iData: TDate) :String;
var
  vData: TDate;
  vDIA_MES : String;
  vD1: Integer;
  vD2: Integer;
  vM1: Integer;
  vM2: Integer;
  vA: Integer;
  vB: Integer;
  vC: Integer;
  vD: Integer;
  vX: Integer;
  vY: Integer;
  vZ: Integer;
  vK: Integer;
begin
  vData := iData;
  vDIA_MES := FormatDateTime('DDMM',vData);
  vD1 := StrToInt(COPY(vDIA_MES,1,1));
  vD2 := StrToInt(COPY(vDIA_MES,2,1));
  vM1 := StrToInt(COPY(vDIA_MES,3,1));
  vM2 := StrToInt(COPY(vDIA_MES,4,1));

  case vD2 of
    0 : vD2 := 5;
    1 : vD2 := 8;
    2 : vD2 := 6;
    3 : vD2 := 9;
    4 : vD2 := 3;
    5 : vD2 := 7;
    6 : vD2 := 2;
    7 : vD2 := 5;
    8 : vD2 := 1;
    9 : vD2 := 0;
  end;
  vA := (vD1 + 5) mod 10;
  vB := (vD2 + 7) mod 10;
  vC := (vM1 + 3) mod 10;
  vD := (vM2 + 8) mod 10;

  vX := (vA + vC + vB) mod 10;
  vY := (vA + vB) mod 10;
  vZ := (vC + vB) mod 10;
  vK := (vD + vA + vB) mod 10;

  result := IntToStr(vX) + IntToStr(vY) + IntToStr(vZ) + IntToStr(vK);
end;

function AltTableData(const TableName, FieldName, OldValue, NewValue, OptionalAnd: string): Boolean;
var
  qry: TgpQry;
begin
  Result := False;

  qry := TgpQry.Create(nil);

  try
    qry.SQL.Text := Format('UPDATE %s SET %s = :NewValue WHERE %s = :OldValue %s', [TableName, FieldName, FieldName, OptionalAnd]);

    qry.ParamByName('OldValue').AsString := OldValue;
    qry.ParamByName('NewValue').AsString := NewValue;

    qry.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      CriarMensagem('ERRO', 'Erro ao executar o update: ' + E.Message);
      raise ECustomError.Create('Erro na execução da função AltTableData');
    end;
  end;

  FreeAndNil(qry);
end;

function TableExists(const TableName: string; Query: TgpQry): Boolean;
begin
  Query := TgpQry.create(nil);
  Query.SQLExec('SHOW TABLES LIKE :1', [TableName]);
  Result := not Query.IsEmpty;
  Query.Free;
end;


procedure CreateTable(const TableName: string; const Fields: array of string);
var
  Field, FieldsList, FieldsDefinition: string;
  Query: TgpQry;
begin

  Query:= TgpQry.Create(nil);

  if TableExists(TableName, Query) then
  begin
    CriarMensagem('ERRO','A tabela '+ TableName + ' já existe.');
    Exit;
  end;

  FieldsList := '';
  for Field in Fields do
    FieldsList := FieldsList + Field + ', ';

  if FieldsList <> '' then
    SetLength(FieldsList, Length(FieldsList) - 2); // Remove a última vírgula e espaço

  FieldsDefinition := 'id INT NOT NULL AUTO_INCREMENT, '; // Adiciona o campo 'id' no início

  for Field in Fields do
    FieldsDefinition := FieldsDefinition + Field + ' INT NOT NULL, ';

  if FieldsDefinition <> '' then
    SetLength(FieldsDefinition, Length(FieldsDefinition) - 2); // Remove a última vírgula e espaço

  Query.SQLExec(Format(
    'CREATE TABLE %s (%s, PRIMARY KEY (id))',
    [TableName, FieldsDefinition]
  ), []);

  CriarMensagem('AVISO', 'Tabela ' + TableName + ' criada com sucesso');
  Query.free;
end;

function GetTableColumns(const TableName: string): TArray<string>;
var
  FieldList: TArray<string>;
  Query: TgpQry;
begin
  Query := TgpQry.Create(nil);

  if not TableExists(TableName, Query) then
  begin
    ShowMessage('A tabela não existe.');
    Exit;
  end;

  Query.SQLExec(Format('SHOW COLUMNS FROM %s', [TableName]), []);
  SetLength(FieldList, 0);

  while not Query.Eof do
  begin
    SetLength(FieldList, Length(FieldList) + 1);
    FieldList[High(FieldList)] := Query.FieldByName('Field').AsString;
    Query.Next;
  end;

  Result := FieldList;
  Query.Free;
end;

procedure DropTable(const TableName: string);
var
Query: TgpQry;
begin
 Query:= TgpQry.Create(nil);
  if not TableExists(TableName, Query) then
  begin
    ShowMessage('A tabela não existe.');
    Exit;
  end;

  Query.SQLExec(Format('DROP TABLE %s', [TableName]), []);

  CriarMensagem('AVISO', 'Tabela ' + TableName + ' excluída com sucesso');
  Query.Free;
end;

procedure AddColumn(const TableName, ColumnName, ColumnType: string);
var
  Query: TgpQry;
begin
  Query := TgpQry.Create(nil);
  try
    if not TableExists(TableName, Query) then
    begin
      CriarMensagem('ERRO','A tabela não existe.');
      Exit;
    end;

    Query.SQLExec(Format('ALTER TABLE %s ADD %s %s', [TableName, ColumnName, ColumnType]), []);

    CriarMensagem('AVISO', 'Coluna ' + ColumnName + ' adicionada com sucesso à tabela ' + TableName);
  finally
    Query.Free;
  end;
end;

procedure CarregarCamposClasse(form: TgpForm; Classe: TObject);
var
  Contexto: TRttiContext;
  Propriedade: TRttiProperty;
  Valor: TValue;
  Componente: TComponent;
  DataFieldName: string;
begin
  Contexto := TRttiContext.Create;
  try
    for var i: integer := 0 to form.ComponentCount - 1 do
    begin
      Componente := form.Components[i];
      DataFieldName := '';
      if (Componente is TgpEdit) then
        DataFieldName := TgpEdit(Componente).Conf.TableFieldName
      else
        Continue;

      for Propriedade in Contexto.GetType(Classe.ClassType).GetProperties do
      begin
        if SameText(Propriedade.Name, DataFieldName) then
        begin
          if Propriedade.PropertyType.TypeKind = tkInteger then
          begin
            Valor := StrToIntDef(TgpEdit(Componente).Text, 0);
          end
          else
          begin
            // Se não for Integer, manter o valor como string
            Valor := TgpEdit(Componente).Text;
          end;

          Propriedade.SetValue(Classe, Valor);
        end;
      end;
    end;
  finally
    Contexto.Free;
  end;
end;

function SubsTudo(Text: String; const Substituicoes: array of string): String;
var
  i: Integer;
begin
  Result := Text;
  if Length(Substituicoes) mod 2 <> 0 then
    raise Exception.Create('O número de elementos na matriz de substituições deve ser par');
  i := 0;
  while i < Length(Substituicoes) do
  begin
    Result := StringReplace(Result, Substituicoes[i], Substituicoes[i + 1], [rfReplaceAll, rfIgnoreCase]);
    Inc(i, 2);
  end;
end;



end.
