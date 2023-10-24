unit unit_funcoes;

interface

uses
  Vcl.Forms, Vcl.ExtCtrls, Vcl.Graphics, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.Mask, Winapi.Windows, Vcl.DBGrids, Vcl.Grids, Data.DB, FireDAC.Comp.Client,
  System.Classes, System.Math, Vcl.Controls, unit_cadastro_padrao;

  function SomenteNumeros( AString: String ): String;
  function RemoveCaracteres( AString: String ): String;
  procedure ValidarCampoObrigatorios ( Form : TForm );
  procedure MudarBotao ( Form: Tform; Botao : TPanel );
  function Criptografia( Senha: string ): string;
  function CriarMensagem ( Tipo, MSG : String ) : boolean;

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
  procedure CalcDoisCamp(const SQLQuery: string; const ParametrosSaida: array of PChar);

  procedure ChamarUpdateGenerico(const NomeTabela: string; AContainer: TWinControl);
  procedure AtualizarGenerica(const NomeTabela: string; const NomesCamposAtualizar: string; Valores: array of string; const Condicao: string; NomesCampos: TStringList);


type
  TDBGridPadrao = class( TCustomGrid );

VAR //variaveis globais
  var_gbl_resposta_msg : Boolean;

implementation

uses unit_mensagem, unit_conexao, Vcl.Dialogs, Vcl.ComCtrls, System.SysUtils;


// Executar a manutenção, verificando se insere ou faz update em uma Tabela
function ManuDadoTabe(Tabe: string; Chav, Valo: array of string; Camp: string = '';
  Por_Comp: Boolean = False; iComp: TObject = nil; iWher: string = ''): Int64;
var
  i: Integer;
  NovoCamp, Wher: string;
  vQuery: TFDQuery;
  MergedArr: Array of string;
  ChavEmpty: Boolean;
begin
  if (Length(Chav) = 0) and (iWher.Trim = '') then
    Result := InseDadoTabe(Tabe, Valo, Camp, Por_Comp, iComp)
  else
  begin
    iWher := iWher.Trim;

    NovoCamp := Camp;
    if Camp = '' then
      NovoCamp := 'CODI' + Copy(Tabe, 5, MaxInt);

    vQuery := TFDQuery.Create(nil);
    try
      vQuery.Connection := TFDConnection(iComp); // Substitua pelo seu objeto de conexão

      ChavEmpty := True;
      for i := 0 to Length(Chav) - 1 do
        if not Chav[i].Trim.IsEmpty then
        begin
          ChavEmpty := False;
          Break;
        end;

      if ChavEmpty then
        Wher := ''
      else if (Length(Chav) = 2) and (AnsiUpperCase(Chav[0]) = AnsiUpperCase(NovoCamp)) and IsDigit(Chav[1]) then
      begin
        Result := StrToInt(Chav[1]);
        if Result > 0 then
        begin
          Wher := 'WHERE ' + NovoCamp + ' = ' + IntToStr(Result);
          if not iWher.IsEmpty then
            Wher := Wher + ' AND ' + iWher;
          Result := CalcInte(vQuery, 'SELECT ' + NovoCamp + ' FROM ' + Tabe + ' ' + Wher, 0);
        end
        else
        begin
          Chav[0] := '';
          Chav[1] := '';
        end;
      end
      else if (Length(Chav) = 2) and (AnsiUpperCase(Chav[0]) = AnsiUpperCase(NovoCamp)) and (AnsiUpperCase(Chav[1]) = 'NULL') then
      begin
        Result := 0;
        Chav[0] := '';
        Chav[1] := '';
      end
      else
      begin
        SetLength(MergedArr, Length(Chav));
        Wher := '';
        i := 0;
        while i <= (Length(Chav) - 1) do
        begin
          if Wher <> '' then
            Wher := Wher + ' AND ';
          if AnsiUpperCase(Chav[i + 1]) = 'NULL' then
            Wher := Wher + '(' + Chav[i] + ' IS NULL'
          else
            Wher := Wher + '(' + Chav[i] + ' = ' + QuotedStr(Chav[i + 1]);
          Inc(i);
          Wher := Wher + ')';
          Inc(i);
        end;
      end;

      if Result = 0 then
      begin
        SetLength(MergedArr, Length(Chav) + Length(Valo));
        for I := 0 to Length(Chav) - 1 do
          MergedArr[i] := Chav[i];
        for I := 0 to Length(Valo) - 1 do
          MergedArr[Length(Chav) + i] := Valo[i];
        Result := InseDadoTabe(Tabe, MergedArr, Camp, Por_Comp, iComp);
      end
      else
      begin
        // Substitua 'CampoID' pelo nome da coluna da chave primária
        AlteDadoTabe(Tabe, Valo, 'WHERE CampoID = ' + IntToStr(Result), Por_Comp, iComp);
      end;
    finally
      vQuery.Free;
    end;
  end;

  if Result <> 0 then
  begin
    // Substitua 'TrigPrin' pelo nome da função para executar as triggers
    TrigPrin(Tabe, IntToStr(Result), iComp);
  end;
end;

// Executar o UPDATE em uma Tabela
procedure AlteDadoTabe(Tabe: string; Valo: array of string; Wher: string;
  Por_Comp: Boolean = False; iComp: TObject = nil; Apat: Boolean = False);
var
  i: Integer;
  SeleCamp, ApatCamp: string;
  vQuery: TFDQuery;
begin
  SeleCamp := '';
  i := 0;

  while i <= (Length(Valo) - 1) do
  begin
    if Valo[i].Trim = '' then
      Inc(i, 2)
    else
    begin
      SeleCamp := SeleCamp + ', ' + Valo[i];
      Inc(i);
      if not Por_Comp then
        SeleCamp := SeleCamp + ' = ' + Valo[i];
      Inc(i);
    end;
  end;
  SeleCamp := Copy(SeleCamp, 3, Length(SeleCamp) - 2);

  vQuery := TFDQuery.Create(nil);
  try
    vQuery.Connection := TFDConnection(iComp); // Substitua pelo seu objeto de conexão

    if not Por_Comp then
    begin
      vQuery.ExecSQL('UPDATE ' + Tabe + ' SET ' + SeleCamp + ' ' + Wher);
    end
    else
    begin
      if Apat then
        ApatCamp := 'APAT' + AnsiUpperCase(Copy(Tabe, 5, 100));

      vQuery.SQL.Clear;
      vQuery.SQL.Add('SELECT ' + SeleCamp + SeStri(Apat, ', ' + ApatCamp, '') + ' FROM ' + Tabe);
      vQuery.SQL.Add(Wher);
      vQuery.Open;
      vQuery.Edit;

      if Apat then
        vQuery.FieldByName(ApatCamp).AsInteger := Abs(vQuery.FieldByName(ApatCamp).AsInteger + 1);

      i := 0;
      while i <= (Length(Valo) - 1) do
      begin
        if Valo[i + 1] <> '' then
        begin
          if AnsiUpperCase(Valo[i + 1]) = 'NULL' then
            vQuery.FieldByName(Valo[i]).Clear
          else if (vQuery.FieldByName(Valo[i]).DataType = ftFloat) then
            vQuery.FieldByName(Valo[i]).AsFloat := StrToFloat(StringReplace(Valo[i + 1], '.', ',', []))
          else
          begin
            Valo[i + 1] := StringReplace(Valo[i + 1], '''''', '%$%$%$%$%$%$', '');
            Valo[i + 1] := StringReplace(Valo[i + 1], '''', '', '');
            Valo[i + 1] := StringReplace(Valo[i + 1], '%$%$%$%$%$%$', '''', '');
            if AnsiUpperCase(Valo[i + 1]) = 'NULL' then
              vQuery.FieldByName(Valo[i]).Clear
            else
              vQuery.FieldByName(Valo[i]).AsString := Valo[i + 1];
          end;
        end;
        Inc(i, 2);
      end;
      vQuery.Post;
    end;
  finally
    vQuery.Free;
  end;
end;


procedure limpaEDit(Form: TForm);
var
  i: Integer;
begin
  for i := 0 to Form.ComponentCount - 1 do
  begin
    // Testando se é TEdit
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
    if (AContainer.Controls[i] is TEdit) then
    begin
      if TEdit(AContainer.Controls[i]).Tag = 99 then
      begin
        SetLength(ControlList, Length(ControlList) + 1);
        ControlList[High(ControlList)] := AContainer.Controls[i];
      end;
    end
    else if (AContainer.Controls[i] is TDBLookupComboBox) then
    begin
      if TDBLookupComboBox(AContainer.Controls[i]).Tag = 99 then
      begin
        SetLength(ControlList, Length(ControlList) + 1);
        ControlList[High(ControlList)] := AContainer.Controls[i];
      end;
    end
    else if  (AContainer.Controls[i] is TDateTimePicker) then
     begin
      if TDateTimePicker(AContainer.Controls[i]).Tag = 99 then
      begin
        SetLength(ControlList, Length(ControlList) + 1);
        ControlList[High(ControlList)] := AContainer.Controls[i];
      end;
     end;


    if AContainer.Controls[i] is TWinControl then
    begin
      ControlList := ControlList + AcharEdit99(TWinControl(AContainer.Controls[i]));
    end;
  end;

  Result := ControlList;
end;


procedure InsertGenerico(const NomeTabela: string; const NomesCampos: string; const Valores: array of string);
var
  qryInserir: TFDQuery;
  i: Integer;
begin
  qryInserir := TFDQuery.Create(nil);
  try
    qryInserir.Connection := unit_conexao.form_conexao.FDConnection; // Defina aqui a sua conexão

    qryInserir.SQL.Text := 'INSERT INTO ' + NomeTabela + '(' + NomesCampos + ') VALUES (';
    for i := 0 to High(Valores) do
    begin
      qryInserir.SQL.Add(':' + IntToStr(i + 1));
      if i < High(Valores) then
        qryInserir.SQL.Add(',');
    end;
    qryInserir.SQL.Add(')');

    // Definir os valores como parâmetros
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
  qry: TFDQuery;
  i: Integer;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := unit_conexao.form_conexao.FDConnection; // Defina aqui a sua conexão
    qry.SQL.Text := 'SELECT * FROM ' + NomeTabela + ' WHERE 1 = 0'; // Não traz dados, apenas estrutura
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

    // Crie uma string com os nomes dos campos separados por vírgula
    NomesCamposInserir := '';
    for i := 0 to NomesCampos.Count - 1 do
    begin
      NomesCamposInserir := NomesCamposInserir + NomesCampos[i];
      if i < NomesCampos.Count - 1 then
        NomesCamposInserir := NomesCamposInserir + ', ';
    end;

    // Preencha o array de ControlesValores com os controles que têm a tag 99
    ControlesValores := AcharEdit99(AContainer);

    // Preencha o array de valores com os valores dos controles
    SetLength(Valores, Length(ControlesValores));
    for i := 0 to High(ControlesValores) do
    begin
      if ControlesValores[i] is TEdit then
        Valores[i] := TEdit(ControlesValores[i]).Text
      else if ControlesValores[i] is TDBLookupComboBox then
        Valores[i] := TDBLookupComboBox(ControlesValores[i]).Text // ou KeyValue, dependendo do que você deseja
         else if ControlesValores[i] is TDateTimePicker then
           Valores[i] := FormatDateTime('yyyy/mm/dd' ,TDateTimePicker(ControlesValores[i]).DateTime);
    end;



    // Chame a função InserirGenerica passando os campos resultantes e os valores dos controles
    InsertGenerico(NomeTabela, NomesCamposInserir, Valores);
  finally
    NomesCampos.Free;
  end;
end;


procedure maxID(const TableName: string; Edit: TEdit);
var
  qrySelect: TFDQuery;
begin
  qrySelect := TFDQuery.Create(nil);
  try
   qrySelect.Connection := unit_conexao.form_conexao.FDConnection; // Defina aqui a sua conexão
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

  //verifico se é um numero
    if Pos ( Copy( AString, I, 1 ), '0123456789') > 0 then
      Limpos := Limpos + Copy( AString, i, 1 ); //so copia para a variavel se for numero

  end;

  //retorno para a funcao
  Result := Limpos;
end;


procedure CalcDoisCamp(const SQLQuery: string; const ParametrosSaida: array of PChar);
var
  Query: TFDQuery; // Você pode usar o componente TADOQuery para acessar bancos de dados ADO
  I: Integer;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := form_conexao.FDConnection;
    Query.SQL.Text := SQLQuery;

    Query.Open;

    // Verifique se a consulta retornou resultados
    if not Query.IsEmpty then
    begin
      // Percorra os parâmetros de saída e atribua os valores dos campos da consulta
      for I := 0 to Min(Length(ParametrosSaida), Query.FieldCount) - 1 do
      begin
        StrPCopy(ParametrosSaida[I], Query.Fields[I].AsString);
      end;
    end;
  finally
    Query.Free;
  end;
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

    // Crie uma string com os nomes dos campos que serão atualizados
    NomesCamposAtualizar := '';
    for i := 0 to NomesCampos.Count - 1 do
    begin
      NomesCamposAtualizar := NomesCamposAtualizar + NomesCampos[i] + ' = :' + NomesCampos[i];
      if i < NomesCampos.Count - 1 then
        NomesCamposAtualizar := NomesCamposAtualizar + ', ';
    end;

    // Preencha o array de ControlesValores com os controles que têm a tag 99
    ControlesValores := AcharEdit99(AContainer);

    // Preencha o array de valores com os valores dos controles
    SetLength(Valores, Length(ControlesValores));
    for i := 0 to High(ControlesValores) do
    begin
      if ControlesValores[i] is TEdit then
        Valores[i] := TEdit(ControlesValores[i]).Text
      else if ControlesValores[i] is TDBLookupComboBox then
        Valores[i] := TDBLookupComboBox(ControlesValores[i]).Text // ou KeyValue, dependendo do que você deseja
      else if ControlesValores[i] is TDateTimePicker then
        Valores[i] := FormatDateTime('yyyy/mm/dd', TDateTimePicker(ControlesValores[i]).DateTime);
    end;

    Condicao := NomesCampos[0] + ' = ' + QuotedStr(Valores[0]); // Adicione QuotedStr para lidar com strings

    // Chame a função AtualizarGenerica passando os campos a serem atualizados, os valores dos controles, a condição e a lista de nomes de campos
 AtualizarGenerica(NomeTabela, NomesCamposAtualizar, Valores, Condicao, NomesCampos);


  finally
    NomesCampos.Free;
  end;
end;

procedure AtualizarGenerica(const NomeTabela: string; const NomesCamposAtualizar: string; Valores: array of string; const Condicao: string; NomesCampos: TStringList);
var
  qryAtualizar: TFDQuery;
  SQLAtualizar: string;
  i: Integer;
begin
  qryAtualizar := TFDQuery.Create(nil);
  try
    qryAtualizar.Connection := unit_conexao.form_conexao.FDConnection;

    // Crie a instrução SQL de atualização
    SQLAtualizar := 'UPDATE ' + NomeTabela + ' SET ' + NomesCamposAtualizar + ' WHERE ' + Condicao;

    qryAtualizar.SQL.Text := SQLAtualizar;

    // Defina os parâmetros com nomes correspondentes aos nomes dos campos da tabela
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

  //verifico se é um caracter especial
    if Pos ( Copy( AString, I, 1 ), '"!%$#@&¨*().,;:/<>[]{}=+-_\|') = 0 then
      Limpos := Limpos + Copy( AString, i, 1 ); //so copia para a variavel se nao for caracter

  end;

  //retorno para a funcao
  Result := Limpos;
end;


//funcao que percorre todos os componentes do form vericando
//qual é obrigatorio e qual nao esta preenchido
procedure ValidarCampoObrigatorios ( Form : TForm );
var
  i:Integer;

begin

  //percorre todos os componentes do form
  for I := 0 to Form.ComponentCount - 1 do
  begin

    //se o tag = 99 entao indicara que é componente obrigatorio
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
                         ' é de preenchimento obrigatório!'); //avisa o usuario

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
                         ' é de preenchimento obrigatório!'); //avisa o usuario

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
                         ' é de preenchimento obrigatório!'); //avisa o usuario

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
                         ' é de preenchimento obrigatório!'); //avisa o usuario

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
                         ' é de preenchimento obrigatório!'); //avisa o usuario

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
                         ' é de preenchimento obrigatório!'); //avisa o usuario

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
                         ' é de preenchimento obrigatório!'); //avisa o usuario

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
       end else //nao tem a mesma tage entao é label dos outros botoes
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

    //A senha passada por parametro recebe o resultado das opeaçoes logicas
    Senha := NovaSenha;
  end;

  //o resultado da senha é passado para o retorno da funcao
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

//prcedure responsavel por mudar a cor da selecao e zebrar um dbgrid
procedure prcDrawColumnCell( Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  //zebrando o dbgrid
  if Odd( ( Sender as TDbgrid ).DataSource.DataSet.RecNo) then
    ( Sender as TDbgrid ).Canvas.Brush.Color :=  $00FBFBFB
  else
    ( Sender as TDbgrid ).Canvas.Brush.Color := clwhite;//$00F9F9F9;


  //mudando a cor da seleção
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
       ( UpperCase( xDBGrid.Fields[I].FieldName ) = 'NOME' )  then
      xDBGrid.Fields[I].Tag := 30 //pode ser qualquer valor, é so pra diferenciar a coluna
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


end.
