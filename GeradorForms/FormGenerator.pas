unit FormGenerator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, System.RegularExpressions, System.IOUtils, Vcl.FileCtrl;

type
  TCampoTipo = (ctString, ctInteger, ctCurrency, ctDate, ctTime, ctDateTime, ctBoolean, ctCombo);

  TCampoFormInfo = record
    Nome: string;
    NomeExibicao: string;
    Tipo: TCampoTipo;
    TamanhoMaximo: Integer;
    EhObrigatorio: Boolean;
    Emoji: string;
    Largura: Integer; // Para layout (100 = 100% da linha, 50 = 50%, 33 = 33%)
    OpcoesCombo: TArray<string>; // Para campos ComboBox
    Mascara: string; // Para campos com máscara
  end;

  TfrmGeradorFormularios = class(TForm)
    pnlMain: TPanel;
    pnlTop: TPanel;
    lblTitle: TLabel;
    btnClose: TSpeedButton;
    pnlSeparator: TPanel;
    //Origem dos Dados
    pnl_origem: TPanel;
    lbl_origem: TLabel;
    rbClasse: TRadioButton;
    rbBanco: TRadioButton;
    pnl_barra_origem: TPanel;
    //Classe
    pnl_classe: TPanel;
    lbl_classe: TLabel;
    edtArquivoClasse: TEdit;
    btnProcurarClasse: TSpeedButton;
    btnAnalisarClasse: TSpeedButton;
    pnl_barra_classe: TPanel;
    //Banco
    pnl_banco: TPanel;
    lbl_banco: TLabel;
    edtConexao: TEdit;
    btnConectar: TSpeedButton;
    pnl_barra_banco: TPanel;

    pnl_tabelas: TPanel;
    lbl_tabelas: TLabel;
    cmbTabelas: TComboBox;
    btnCarregarCampos: TSpeedButton;
    //Configuração dos Campos
    pnl_campos: TPanel;
    lbl_campos: TLabel;
    gridCampos: TStringGrid;
    //Preview
    pnl_preview: TPanel;
    lbl_preview: TLabel;
    pgcPreview: TPageControl;
    tsPas: TTabSheet;
    memoPas: TMemo;
    tsDfm: TTabSheet;
    memoDfm: TMemo;
    //Geração
    pnl_geracao: TPanel;
    lbl_nome_form: TLabel;
    edtNomeForm: TEdit;
    btnEscolherPasta: TSpeedButton;
    btnGerarFormulario: TSpeedButton;
    lblPastaDestino: TLabel;
    FDConnection: TFDConnection;
    qryCampos: TFDQuery;
    OpenDialog: TOpenDialog;
    qryTabelas: TFDQuery;

    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure rbClasseClick(Sender: TObject);
    procedure rbBancoClick(Sender: TObject);
    procedure btnProcurarClasseClick(Sender: TObject);
    procedure btnAnalisarClasseClick(Sender: TObject);
    procedure btnConectarClick(Sender: TObject);
    procedure cmbTabelasChange(Sender: TObject);
    procedure btnCarregarCamposClick(Sender: TObject);
    procedure gridCamposSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure edtNomeFormChange(Sender: TObject);
    procedure btnEscolherPastaClick(Sender: TObject);
    procedure btnGerarFormularioClick(Sender: TObject);

  private
    FPastaDestino: string;
    FCampos: TArray<TCampoFormInfo>;

    procedure ConfigurarInterface;
    procedure ConfigurarGridCampos;
    procedure ConfigurarConexao;
    procedure AtualizarInterface;
    procedure CarregarTabelas;
    function AnalisarArquivoClasse(const ACaminhoArquivo: string): TArray<TCampoFormInfo>;
    function ObterCamposDoBanco(const ANomeTabela: string): TArray<TCampoFormInfo>;
    function ConverterTipoMySQLParaCampo(const ATipoMySQL: string): TCampoTipo;
    function ObterEmojiPorNome(const ANome: string): string;
    function ObterLarguraPorTipo(ATipo: TCampoTipo): Integer;
    procedure PreencherGridCampos;
    procedure AtualizarPreview;
    function GerarCodigoPas(const ANomeForm, ANomeClasse: string): string;
    function GerarCodigoDfm(const ANomeForm, ANomeClasse: string): string;
    function ValidarConexao: Boolean;
  end;

var
  frmGeradorFormularios: TfrmGeradorFormularios;

implementation

{$R *.dfm}

procedure TfrmGeradorFormularios.FormCreate(Sender: TObject);
begin
  ConfigurarInterface;
  ConfigurarGridCampos;
  ConfigurarConexao;

  FPastaDestino := ExtractFilePath(Application.ExeName) + 'Forms\';
  if not TDirectory.Exists(FPastaDestino) then
    TDirectory.CreateDirectory(FPastaDestino);

  lblPastaDestino.Caption := 'Pasta: ' + FPastaDestino;
end;

procedure TfrmGeradorFormularios.ConfigurarInterface;
begin
  rbClasse.Checked := True;
  AtualizarInterface;
end;

procedure TfrmGeradorFormularios.ConfigurarGridCampos;
begin
  // colunas do grid
  gridCampos.ColCount := 7;
  gridCampos.RowCount := 1;

  gridCampos.Cells[0, 0] := 'Campo';
  gridCampos.Cells[1, 0] := 'Nome Exibição';
  gridCampos.Cells[2, 0] := 'Tipo';
  gridCampos.Cells[3, 0] := 'Emoji';
  gridCampos.Cells[4, 0] := 'Largura %';
  gridCampos.Cells[5, 0] := 'Obrigatório';
  gridCampos.Cells[6, 0] := 'Opções/Máscara';

  gridCampos.ColWidths[0] := 120; // Campo
  gridCampos.ColWidths[1] := 150; // Nome Exibição
  gridCampos.ColWidths[2] := 80;  // Tipo
  gridCampos.ColWidths[3] := 60;  // Emoji
  gridCampos.ColWidths[4] := 80;  // Largura
  gridCampos.ColWidths[5] := 80;  // Obrigatório
  gridCampos.ColWidths[6] := 200; // Opções
end;

procedure TfrmGeradorFormularios.ConfigurarConexao;
begin
  FDConnection.Params.Clear;
  FDConnection.Params.Add('DriverID=MySQL');
  FDConnection.Params.Add('Server=localhost');
  FDConnection.Params.Add('Database=ERPSTORE');
  FDConnection.Params.Add('User_Name=root');
  FDConnection.Params.Add('Password=');
  FDConnection.LoginPrompt := False;
end;

procedure TfrmGeradorFormularios.AtualizarInterface;
begin
  // Mostrar/ocultar painéis baseado na seleção
  pnl_classe.Visible := rbClasse.Checked;
  pnl_banco.Visible := rbBanco.Checked;
  pnl_tabelas.Visible := rbBanco.Checked;

  if rbClasse.Checked then
    edtConexao.Text := 'Modo: Análise de Classe Selecionado'
  else
    edtConexao.Text := 'Status: Desconectado';
end;

procedure TfrmGeradorFormularios.rbClasseClick(Sender: TObject);
begin
  AtualizarInterface;
end;

procedure TfrmGeradorFormularios.rbBancoClick(Sender: TObject);
begin
  AtualizarInterface;
end;

procedure TfrmGeradorFormularios.btnProcurarClasseClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Arquivos Pascal (*.pas)|*.pas|Todos os arquivos (*.*)|*.*';
  OpenDialog.Title := 'Selecionar arquivo da classe';

  if OpenDialog.Execute then
    edtArquivoClasse.Text := OpenDialog.FileName;
end;

procedure TfrmGeradorFormularios.btnAnalisarClasseClick(Sender: TObject);
begin
  if edtArquivoClasse.Text = '' then
  begin
    ShowMessage('Selecione um arquivo de classe primeiro.');
    Exit;
  end;

  if not FileExists(edtArquivoClasse.Text) then
  begin
    ShowMessage('Arquivo não encontrado.');
    Exit;
  end;

  try
    FCampos := AnalisarArquivoClasse(edtArquivoClasse.Text);
    PreencherGridCampos;
    AtualizarPreview;
    ShowMessage(Format('Análise concluída! %d campos encontrados.', [Length(FCampos)]));
  except
    on E: Exception do
      ShowMessage('Erro ao analisar classe: ' + E.Message);
  end;
end;

function TfrmGeradorFormularios.AnalisarArquivoClasse(const ACaminhoArquivo: string): TArray<TCampoFormInfo>;
var
  Linhas: TStringList;
  Campos: TArray<TCampoFormInfo>;
  Campo: TCampoFormInfo;
  i: Integer;
  Linha, NomePropriedade, TipoPropriedade: string;
  RegexProperty: TRegEx;
  Match: TMatch;
begin
  SetLength(Campos, 0);
  Linhas := TStringList.Create;
  try
    Linhas.LoadFromFile(ACaminhoArquivo);

    // Regex para properties: property NomeProp: Tipo read ... write ...;
    RegexProperty := TRegEx.Create('property\s+(\w+)\s*:\s*(\w+)', [roIgnoreCase]);

    for i := 0 to Linhas.Count - 1 do
    begin
      Linha := Trim(Linhas[i]);
      Match := RegexProperty.Match(Linha);

      if Match.Success then
      begin
        NomePropriedade := Match.Groups[1].Value;
        TipoPropriedade := Match.Groups[2].Value;

        // Pular propriedades herdadas da base (ID, etc)
        if SameText(NomePropriedade, 'ID') then
          Continue;

        Campo.Nome := NomePropriedade;
        Campo.NomeExibicao := StringReplace(NomePropriedade, '_', ' ', [rfReplaceAll]);

        // Converter tipo Delphi para nosso enum
        if SameText(TipoPropriedade, 'string') then
          Campo.Tipo := ctString
        else if SameText(TipoPropriedade, 'Integer') then
          Campo.Tipo := ctInteger
        else if SameText(TipoPropriedade, 'Currency') then
          Campo.Tipo := ctCurrency
        else if SameText(TipoPropriedade, 'TDate') then
          Campo.Tipo := ctDate
        else if SameText(TipoPropriedade, 'TTime') then
          Campo.Tipo := ctTime
        else if SameText(TipoPropriedade, 'TDateTime') then
          Campo.Tipo := ctDateTime
        else if SameText(TipoPropriedade, 'Boolean') then
          Campo.Tipo := ctBoolean
        else
          Campo.Tipo := ctString; // Default

        Campo.TamanhoMaximo := 0; // Será definido pelo usuário se necessário
        Campo.EhObrigatorio := True; // Default
        Campo.Emoji := ObterEmojiPorNome(NomePropriedade);
        Campo.Largura := ObterLarguraPorTipo(Campo.Tipo);
        SetLength(Campo.OpcoesCombo, 0);
        Campo.Mascara := '';

        SetLength(Campos, Length(Campos) + 1);
        Campos[High(Campos)] := Campo;
      end;
    end;

  finally
    Linhas.Free;
  end;

  Result := Campos;
end;

function TfrmGeradorFormularios.ObterEmojiPorNome(const ANome: string): string;
var
  NomeLower: string;
begin
  NomeLower := LowerCase(ANome);

  if NomeLower.Contains('nome') then
    Result := '🧑'
  else if NomeLower.Contains('endereco') or NomeLower.Contains('address') then
    Result := '🏠'
  else if NomeLower.Contains('telefone') or NomeLower.Contains('phone') then
    Result := '📱'
  else if NomeLower.Contains('email') or NomeLower.Contains('mail') then
    Result := '✉️'
  else if NomeLower.Contains('data') or NomeLower.Contains('date') then
    Result := '📅'
  else if NomeLower.Contains('valor') or NomeLower.Contains('preco') or NomeLower.Contains('price') then
    Result := '💰'
  else if NomeLower.Contains('classificacao') or NomeLower.Contains('categoria') then
    Result := '⭐'
  else if NomeLower.Contains('descricao') or NomeLower.Contains('obs') then
    Result := '📝'
  else if NomeLower.Contains('codigo') or NomeLower.Contains('cod') then
    Result := '🔢'
  else if NomeLower.Contains('status') then
    Result := '📊'
  else
    Result := '📋'; // Default
end;

function TfrmGeradorFormularios.ObterLarguraPorTipo(ATipo: TCampoTipo): Integer;
begin
  case ATipo of
    ctString: Result := 100; // Campos de texto geralmente ocupam linha toda
    ctInteger: Result := 33;  // Números podem ser menores
    ctCurrency: Result := 33;
    ctDate, ctTime, ctDateTime: Result := 50; // Datas ocupam meia linha
    ctBoolean: Result := 33;
    ctCombo: Result := 50;
  else
    Result := 100;
  end;
end;

procedure TfrmGeradorFormularios.PreencherGridCampos;
var
  i: Integer;
  TipoStr, LarguraStr: string;
begin
  gridCampos.RowCount := Length(FCampos) + 1;

  for i := 0 to High(FCampos) do
  begin
    case FCampos[i].Tipo of
      ctString: TipoStr := 'String';
      ctInteger: TipoStr := 'Integer';
      ctCurrency: TipoStr := 'Currency';
      ctDate: TipoStr := 'Date';
      ctTime: TipoStr := 'Time';
      ctDateTime: TipoStr := 'DateTime';
      ctBoolean: TipoStr := 'Boolean';
      ctCombo: TipoStr := 'Combo';
    end;

    LarguraStr := IntToStr(FCampos[i].Largura) + '%';

    gridCampos.Cells[0, i + 1] := FCampos[i].Nome;
    gridCampos.Cells[1, i + 1] := FCampos[i].NomeExibicao;
    gridCampos.Cells[2, i + 1] := TipoStr;
    gridCampos.Cells[3, i + 1] := FCampos[i].Emoji;
    gridCampos.Cells[4, i + 1] := LarguraStr;
//    gridCampos.Cells[5, i + 1] := IfThen(FCampos[i].EhObrigatorio, 'Sim', 'Não');
    if (FCampos[i].EhObrigatorio) then
      gridCampos.Cells[5, i + 1] := 'Sim'
    else
      gridCampos.Cells[5, i + 1] := 'Não';



    gridCampos.Cells[6, i + 1] := FCampos[i].Mascara;
  end;
end;

procedure TfrmGeradorFormularios.btnConectarClick(Sender: TObject);
begin
  if ValidarConexao then
  begin
    CarregarTabelas;
    ShowMessage('Conexão estabelecida com sucesso!');
  end;
end;

function TfrmGeradorFormularios.ValidarConexao: Boolean;
begin
  Result := False;
  try
    if not FDConnection.Connected then
      FDConnection.Open;

    Result := FDConnection.Connected;

    if Result then
      edtConexao.Text := Format('Servidor: %s | Banco: %s | Status: Conectado',
        [FDConnection.Params.Values['Server'], FDConnection.Params.Values['Database']])
    else
      edtConexao.Text := 'Status: Falha na conexão';

  except
    on E: Exception do
    begin
      edtConexao.Text := 'Erro: ' + E.Message;
      ShowMessage('Erro ao conectar: ' + E.Message);
    end;
  end;
end;

procedure TfrmGeradorFormularios.CarregarTabelas;
begin
  if not FDConnection.Connected then Exit;

  try
    qryTabelas.Close;
    qryTabelas.SQL.Text := 'SHOW TABLES';
    qryTabelas.Open;

    cmbTabelas.Items.Clear;
    qryTabelas.First;
    while not qryTabelas.Eof do
    begin
      cmbTabelas.Items.Add(qryTabelas.Fields[0].AsString);
      qryTabelas.Next;
    end;

  except
    on E: Exception do
      ShowMessage('Erro ao carregar tabelas: ' + E.Message);
  end;
end;

procedure TfrmGeradorFormularios.cmbTabelasChange(Sender: TObject);
begin
  if cmbTabelas.ItemIndex >= 0 then
    btnCarregarCampos.Enabled := True
  else
    btnCarregarCampos.Enabled := False;
end;

procedure TfrmGeradorFormularios.btnCarregarCamposClick(Sender: TObject);
begin
  if cmbTabelas.Text = '' then Exit;

  try
    FCampos := ObterCamposDoBanco(cmbTabelas.Text);
    PreencherGridCampos;
    AtualizarPreview;
    ShowMessage(Format('Campos carregados! %d campos encontrados.', [Length(FCampos)]));
  except
    on E: Exception do
      ShowMessage('Erro ao carregar campos: ' + E.Message);
  end;
end;

function TfrmGeradorFormularios.ObterCamposDoBanco(const ANomeTabela: string): TArray<TCampoFormInfo>;
var
  Campos: TArray<TCampoFormInfo>;
  Campo: TCampoFormInfo;
begin
  SetLength(Campos, 0);

  try
    qryCampos.Close;
    qryCampos.SQL.Text := Format('DESCRIBE %s', [ANomeTabela]);
    qryCampos.Open;

    qryCampos.First;
    while not qryCampos.Eof do
    begin
      // Pular campo ID
      if not SameText(qryCampos.FieldByName('Field').AsString, 'id') then
      begin
        Campo.Nome := qryCampos.FieldByName('Field').AsString;
        Campo.NomeExibicao := StringReplace(Campo.Nome, '_', ' ', [rfReplaceAll]);
        Campo.Tipo := ConverterTipoMySQLParaCampo(qryCampos.FieldByName('Type').AsString);
        Campo.EhObrigatorio := qryCampos.FieldByName('Null').AsString = 'NO';
        Campo.Emoji := ObterEmojiPorNome(Campo.Nome);
        Campo.Largura := ObterLarguraPorTipo(Campo.Tipo);
        Campo.TamanhoMaximo := 0;
        SetLength(Campo.OpcoesCombo, 0);
        Campo.Mascara := '';

        SetLength(Campos, Length(Campos) + 1);
        Campos[High(Campos)] := Campo;
      end;

      qryCampos.Next;
    end;

  except
    on E: Exception do
      ShowMessage('Erro ao obter campos: ' + E.Message);
  end;

  Result := Campos;
end;

function TfrmGeradorFormularios.ConverterTipoMySQLParaCampo(const ATipoMySQL: string): TCampoTipo;
var
  TipoLower: string;
begin
  TipoLower := LowerCase(ATipoMySQL);

  if TipoLower.Contains('int') then
    Result := ctInteger
  else if TipoLower.Contains('decimal') or TipoLower.Contains('float') or TipoLower.Contains('double') then
    Result := ctCurrency
  else if TipoLower.Contains('date') and not TipoLower.Contains('time') then
    Result := ctDate
  else if TipoLower.Contains('time') and not TipoLower.Contains('date') then
    Result := ctTime
  else if TipoLower.Contains('datetime') or TipoLower.Contains('timestamp') then
    Result := ctDateTime
  else if TipoLower.Contains('bool') or TipoLower.Contains('bit') then
    Result := ctBoolean
  else
    Result := ctString;
end;

procedure TfrmGeradorFormularios.gridCamposSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  // da pra implementar edição inline do grid se quiser
  CanSelect := True;
end;

procedure TfrmGeradorFormularios.edtNomeFormChange(Sender: TObject);
begin
  AtualizarPreview;
end;

procedure TfrmGeradorFormularios.AtualizarPreview;
var
  NomeForm, NomeClasse: string;
begin
  if edtNomeForm.Text = '' then Exit;

  NomeForm := edtNomeForm.Text;
  if not NomeForm.StartsWith('Tform_') then
    NomeForm := 'Tform_' + NomeForm;

  NomeClasse := StringReplace(NomeForm, 'Tform_', 'T', []);

  memoPas.Lines.Text := GerarCodigoPas(NomeForm, NomeClasse);
  memoDfm.Lines.Text := GerarCodigoDfm(NomeForm, NomeClasse);
end;

function TfrmGeradorFormularios.GerarCodigoPas(const ANomeForm, ANomeClasse: string): string;
var
  Codigo: TStringBuilder;
  Campo: TCampoFormInfo;
  NomeUnit: string;
begin
  NomeUnit := StringReplace(ANomeForm, 'Tform_', '', []);

  Codigo := TStringBuilder.Create;
  try
    // Unit header
    Codigo.AppendLine(Format('unit %s;', [NomeUnit]));
    Codigo.AppendLine('');
    Codigo.AppendLine('interface');
    Codigo.AppendLine('');
    Codigo.AppendLine('uses');
    Codigo.AppendLine('  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,');
    Codigo.AppendLine('  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,');
    Codigo.AppendLine('  unit_cadastro_padrao, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;');
    Codigo.AppendLine('');
    Codigo.AppendLine('type');
    Codigo.AppendLine(Format('  %s = class(TfrmBaseRegister)', [ANomeForm]));

    // Declaração dos componentes
    for Campo in FCampos do
    begin
      Codigo.AppendLine(Format('    pnl_%s: TPanel;', [LowerCase(Campo.Nome)]));
      Codigo.AppendLine(Format('    lbl_%s: TLabel;', [LowerCase(Campo.Nome)]));

      case Campo.Tipo of
        ctCombo, ctBoolean:
          Codigo.AppendLine(Format('    cmb%s: TComboBox;', [Campo.Nome]));
        else
          Codigo.AppendLine(Format('    edt%s: TEdit;', [Campo.Nome]));
      end;

      Codigo.AppendLine(Format('    pnl_barra_%s: TPanel;', [LowerCase(Campo.Nome)]));
    end;

    // Eventos
    Codigo.AppendLine('  private');
    Codigo.AppendLine('    { Private declarations }');
    Codigo.AppendLine('  public');
    Codigo.AppendLine('    { Public declarations }');
    Codigo.AppendLine('  end;');
    Codigo.AppendLine('');
    Codigo.AppendLine('var');
    Codigo.AppendLine(Format('  %s: %s;', [StringReplace(ANomeForm, 'T', '', []), ANomeForm]));
    Codigo.AppendLine('');
    Codigo.AppendLine('implementation');
    Codigo.AppendLine('');
    Codigo.AppendLine('{$R *.dfm}');
    Codigo.AppendLine('');
    Codigo.AppendLine('end.');

    Result := Codigo.ToString;
  finally
    Codigo.Free;
  end;
end;

function TfrmGeradorFormularios.GerarCodigoDfm(const ANomeForm, ANomeClasse: string): string;
var
  Codigo: TStringBuilder;
  Campo: TCampoFormInfo;
  NomeFormSemT: string;
  TopAtual, i: Integer;
  CamposLinha: TArray<TCampoFormInfo>;
  TotalLargura, LeftAtual, LarguraCampo: Integer;
begin
  NomeFormSemT := StringReplace(ANomeForm, 'T', '', []);

  Codigo := TStringBuilder.Create;
  try
    // Header do DFM
    Codigo.AppendLine(Format('inherited %s: %s', [NomeFormSemT, ANomeForm]));
    Codigo.AppendLine(Format('  Caption = ''%s''', [StringReplace(ANomeClasse, 'T', '', [])]));
    Codigo.AppendLine('  ClientHeight = 600');
    Codigo.AppendLine('  StyleElements = [seFont, seClient, seBorder]');
    Codigo.AppendLine('  ExplicitHeight = 600');
    Codigo.AppendLine('  TextHeight = 13');

    // pnlMain herdado
    Codigo.AppendLine('  inherited pnlMain: TPanel');
    Codigo.AppendLine('    Height = 600');
    Codigo.AppendLine('    StyleElements = [seFont, seClient, seBorder]');
    Codigo.AppendLine('    ExplicitHeight = 600');

    // pnlTop herdado
    Codigo.AppendLine('    inherited pnlTop: TPanel');
    Codigo.AppendLine('      TabOrder = 5');
    Codigo.AppendLine('      StyleElements = [seFont, seClient, seBorder]');
    Codigo.AppendLine('      inherited lblTitle: TLabel');
   // Codigo.AppendLine(Format('        Width = 200'));
    Codigo.AppendLine('        Width = 200');
    Codigo.AppendLine(Format('        Caption = ''CADASTRO DE %s''', [UpperCase(StringReplace(ANomeClasse, 'T', '', []))]));
    Codigo.AppendLine('        StyleElements = [seFont, seClient, seBorder]');
    Codigo.AppendLine('        ExplicitWidth = 200');
    Codigo.AppendLine('      end');
    Codigo.AppendLine('      inherited pnlSeparator: TPanel');
    Codigo.AppendLine('        StyleElements = [seFont, seClient, seBorder]');
    Codigo.AppendLine('      end');
    Codigo.AppendLine('    end');

    TopAtual := 85; // Posição inicial após o header
    i := 0;

    // Gerar campos agrupados por linha baseado na largura
    while i < Length(FCampos) do
    begin
      SetLength(CamposLinha, 0);
      TotalLargura := 0;

      // Agrupar campos que cabem na mesma linha
      while (i < Length(FCampos)) and (TotalLargura + FCampos[i].Largura <= 100) do
      begin
        SetLength(CamposLinha, Length(CamposLinha) + 1);
        CamposLinha[High(CamposLinha)] := FCampos[i];
        TotalLargura := TotalLargura + FCampos[i].Largura;
        Inc(i);
      end;

      // Se não conseguiu agrupar nenhum campo (largura > 100), forçar um
      if Length(CamposLinha) = 0 then
      begin
        SetLength(CamposLinha, 1);
        CamposLinha[0] := FCampos[i];
        CamposLinha[0].Largura := 100; // Forçar 100%
        Inc(i);
      end;

      // Gerar código para os campos da linha atual
      LeftAtual := 24; // Margem esquerda padrão

      for var j := 0 to High(CamposLinha) do
      begin
        Campo := CamposLinha[j];

        // Calcular largura em pixels (assumindo largura total de 766px)
        LarguraCampo := Round((766 * Campo.Largura) / 100);
        if j = High(CamposLinha) then
          LarguraCampo := 766 - LeftAtual + 24; // Ajustar último campo da linha

        // Panel do campo
        Codigo.AppendLine(Format('    object pnl_%s: TPanel', [LowerCase(Campo.Nome)]));
        Codigo.AppendLine(Format('      Left = %d', [LeftAtual]));
        Codigo.AppendLine(Format('      Top = %d', [TopAtual]));
        Codigo.AppendLine(Format('      Width = %d', [LarguraCampo]));
        Codigo.AppendLine('      Height = 65');
        Codigo.AppendLine('      BevelOuter = bvNone');
        Codigo.AppendLine('      ParentBackground = False');
        Codigo.AppendLine(Format('      TabOrder = %d', [i - Length(CamposLinha) + j]));

        // Label
        Codigo.AppendLine(Format('      object lbl_%s: TLabel', [LowerCase(Campo.Nome)]));
        Codigo.AppendLine('        Left = 0');
        Codigo.AppendLine('        Top = 0');
        Codigo.AppendLine(Format('        Width = %d', [LarguraCampo]));
        Codigo.AppendLine('        Height = 17');
        Codigo.AppendLine('        Align = alTop');
        Codigo.AppendLine(Format('        Caption = ''%s %s''', [Campo.Emoji, UpperCase(Campo.NomeExibicao)]));
        Codigo.AppendLine('        Font.Charset = DEFAULT_CHARSET');
        Codigo.AppendLine('        Font.Color = 8404992');
        Codigo.AppendLine('        Font.Height = -13');
        Codigo.AppendLine('        Font.Name = ''Segoe UI''');
        Codigo.AppendLine('        Font.Style = [fsBold]');
        Codigo.AppendLine('        ParentFont = False');
        Codigo.AppendLine('        ExplicitWidth = 133');
        Codigo.AppendLine('      end');

        // Controle de entrada (Edit ou ComboBox)
        if Campo.Tipo = ctCombo then
        begin
          Codigo.AppendLine(Format('      object cmb%s: TComboBox', [Campo.Nome]));
          Codigo.AppendLine('        AlignWithMargins = True');
          Codigo.AppendLine('        Left = 0');
          Codigo.AppendLine('        Top = 32');
          Codigo.AppendLine(Format('        Width = %d', [LarguraCampo]));
          Codigo.AppendLine('        Height = 29');
          Codigo.AppendLine('        Margins.Left = 0');
          Codigo.AppendLine('        Margins.Top = 15');
          Codigo.AppendLine('        Margins.Right = 0');
          Codigo.AppendLine('        Margins.Bottom = 0');
          Codigo.AppendLine('        Align = alTop');
          Codigo.AppendLine('        Style = csDropDownList');
          Codigo.AppendLine('        Color = clBtnFace');
          Codigo.AppendLine('        Font.Charset = DEFAULT_CHARSET');
          Codigo.AppendLine('        Font.Color = 8404992');
          Codigo.AppendLine('        Font.Height = -16');
          Codigo.AppendLine('        Font.Name = ''Segoe UI''');
          Codigo.AppendLine('        Font.Style = []');
          Codigo.AppendLine('        ParentFont = False');
          Codigo.AppendLine('        TabOrder = 0');

          // Adicionar itens se for boolean
          if Campo.Tipo = ctBoolean then
          begin
            Codigo.AppendLine('        Items.Strings = (');
            Codigo.AppendLine('          ''SIM''');
            Codigo.AppendLine('          ''NAO'')');
            Codigo.AppendLine('        ItemIndex = 0');
            Codigo.AppendLine('        Text = ''SIM''');
          end;

          Codigo.AppendLine('      end');
        end
        else
        begin
          Codigo.AppendLine(Format('      object edt%s: TEdit', [Campo.Nome]));
          Codigo.AppendLine('        AlignWithMargins = True');
          Codigo.AppendLine('        Left = 0');
          Codigo.AppendLine('        Top = 32');
          Codigo.AppendLine(Format('        Width = %d', [LarguraCampo]));
          Codigo.AppendLine('        Height = 24');
          Codigo.AppendLine('        Margins.Left = 0');
          Codigo.AppendLine('        Margins.Top = 15');
          Codigo.AppendLine('        Margins.Right = 0');
          Codigo.AppendLine('        Margins.Bottom = 0');
          Codigo.AppendLine('        Align = alTop');
          Codigo.AppendLine('        BorderStyle = bsNone');

          if Campo.Tipo = ctString then
            Codigo.AppendLine('        CharCase = ecUpperCase');

          Codigo.AppendLine('        Color = clBtnFace');
          Codigo.AppendLine('        Font.Charset = DEFAULT_CHARSET');
          Codigo.AppendLine('        Font.Color = 8404992');
          Codigo.AppendLine('        Font.Height = -16');
          Codigo.AppendLine('        Font.Name = ''Segoe UI''');
          Codigo.AppendLine('        Font.Style = []');
          Codigo.AppendLine('        ParentFont = False');
          Codigo.AppendLine('        TabOrder = 0');
          Codigo.AppendLine('      end');
        end;

        // Panel da barra
        Codigo.AppendLine(Format('      object pnl_barra_%s: TPanel', [LowerCase(Campo.Nome)]));
        Codigo.AppendLine('        Left = 0');
        if Campo.Tipo = ctCombo then
          Codigo.AppendLine('        Top = 61')
        else
          Codigo.AppendLine('        Top = 56');
        Codigo.AppendLine(Format('        Width = %d', [LarguraCampo]));
        Codigo.AppendLine('        Height = 2');
        Codigo.AppendLine('        Align = alTop');
        Codigo.AppendLine('        BevelOuter = bvNone');
        Codigo.AppendLine('        Color = 8404992');
        Codigo.AppendLine('        ParentBackground = False');
        Codigo.AppendLine('        TabOrder = 1');
        Codigo.AppendLine('      end');
        Codigo.AppendLine('    end');

        // Atualizar posição para próximo campo
        if j < High(CamposLinha) then
          LeftAtual := LeftAtual + LarguraCampo + 31; // Espaço entre campos
      end;

      // Próxima linha
      TopAtual := TopAtual + 80; // Altura do campo + espaço
    end;

    // Fechar pnlMain
    Codigo.AppendLine('  end');
    Codigo.AppendLine('end');

    Result := Codigo.ToString;
  finally
    Codigo.Free;
  end;
end;

procedure TfrmGeradorFormularios.btnEscolherPastaClick(Sender: TObject);
var
  Folder: string;
begin
  Folder := FPastaDestino;
  if SelectDirectory('Escolha a pasta para salvar os formulários:', '', Folder) then
  begin
    FPastaDestino := Folder;
    lblPastaDestino.Caption := 'Pasta: ' + FPastaDestino;
  end;
end;

procedure TfrmGeradorFormularios.btnGerarFormularioClick(Sender: TObject);
var
  NomeForm, NomeUnit: string;
  CodigoPas, CodigoDfm: string;
  CaminhoCompleto: string;
begin
  if edtNomeForm.Text = '' then
  begin
    ShowMessage('Digite o nome do formulário.');
    Exit;
  end;

  if Length(FCampos) = 0 then
  begin
    ShowMessage('Carregue os campos primeiro.');
    Exit;
  end;

  NomeForm := edtNomeForm.Text;
  if not NomeForm.StartsWith('Tform_') then
    NomeForm := 'Tform_' + NomeForm;

  NomeUnit := StringReplace(NomeForm, 'Tform_', '', []);

  if not TDirectory.Exists(FPastaDestino) then
    TDirectory.CreateDirectory(FPastaDestino);

  try
    // Gerar arquivo .pas
    CodigoPas := GerarCodigoPas(NomeForm, StringReplace(NomeForm, 'Tform_', 'T', []));
    CaminhoCompleto := TPath.Combine(FPastaDestino, NomeUnit + '.pas');
    TFile.WriteAllText(CaminhoCompleto, CodigoPas, TEncoding.UTF8);

    // Gerar arquivo .dfm
    CodigoDfm := GerarCodigoDfm(NomeForm, StringReplace(NomeForm, 'Tform_', 'T', []));
    CaminhoCompleto := TPath.Combine(FPastaDestino, NomeUnit + '.dfm');
    TFile.WriteAllText(CaminhoCompleto, CodigoDfm, TEncoding.UTF8);

    ShowMessage(Format('Formulário gerado com sucesso!%s%sPasta: %s',
      [#13#10, #13#10, FPastaDestino]));

  except
    on E: Exception do
      ShowMessage('Erro ao gerar formulário: ' + E.Message);
  end;
end;

procedure TfrmGeradorFormularios.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.

