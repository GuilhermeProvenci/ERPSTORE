unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  System.RegularExpressions, System.IOUtils, Vcl.FileCtrl;

type
  TCampoInfo = record
    Nome: string;
    Tipo: string;
    TamanhoMaximo: Integer;
    EhObrigatorio: Boolean;
    EhPrimaryKey: Boolean;
    TipoDelphiProperty: string;
    TipoDelphiField: string;
  end;

  TfrmGeradorClasses = class(TForm)
    pnlMain: TPanel;
    pnlTop: TPanel;
    lblTitle: TLabel;
    btnClose: TSpeedButton;
    pnlSeparator: TPanel;
    pnl_conexao: TPanel;
    lbl_conexao: TLabel;
    edtConexao: TEdit;
    btnConectar: TSpeedButton;
    pnl_barra_conexao: TPanel;
    pnl_tabelas: TPanel;
    lbl_tabelas: TLabel;
    gridTabelas: TStringGrid;
    btnAtualizarTabelas: TSpeedButton;
    btnSelecionarTodas: TSpeedButton;
    btnLimparSelecao: TSpeedButton;
    pnl_preview: TPanel;
    lbl_preview: TLabel;
    pgcPreview: TPageControl;
    tsPreviewVazio: TTabSheet;
    lblInstrucao: TLabel;
    btnLimparAbas: TSpeedButton;
    pnl_opcoes: TPanel;
    lblContador: TLabel;
    btnEscolherPasta: TSpeedButton;
    btnGerarClasses: TSpeedButton;
    FDConnection: TFDConnection;
    qryTabelas: TFDQuery;
    qryCampos: TFDQuery;
    SaveDialog: TSaveDialog;
    pnl_opcoes_tabelas: TPanel;
    procedure btnCloseClick(Sender: TObject);
    procedure btnConectarClick(Sender: TObject);
    procedure btnAtualizarTabelasClick(Sender: TObject);
    procedure btnSelecionarTodasClick(Sender: TObject);
    procedure btnLimparSelecaoClick(Sender: TObject);
    procedure btnEscolherPastaClick(Sender: TObject);
    procedure btnGerarClassesClick(Sender: TObject);
    procedure btnLimparAbasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridTabelasMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    FPastaDestino: string;
    FCamposTabela: TArray<TCampoInfo>;

    procedure ConfigurarGrid;
    procedure CarregarTabelas;
    procedure AtualizarContador;
    function ObterCamposTabela(const ANomeTabela: string): TArray<TCampoInfo>;
    function ConverterTipoMySQLParaDelphi(const ATipoMySQL: string; ATamanho: Integer): string;
    function ConverterTipoMySQLParaFieldType(const ATipoMySQL: string): string;
    function GerarNomeClasse(const ANomeTabela: string): string;
    function GerarNomeArquivo(const ANomeTabela: string): string;
    function GerarCodigoClasse(const ANomeTabela: string): string;
    procedure AtualizarPreview(const ANomeTabela: string);
    procedure AdicionarAbaPreview(const ANomeTabela: string);
    procedure RemoverAbaPreview(const ANomeTabela: string);
    function AbaJaExiste(const ANomeTabela: string): Boolean;
    procedure LimparTodasAbas;
    function ValidarConexao: Boolean;
    procedure ConfigurarConexao;
  public

  end;

var
  frmGeradorClasses: TfrmGeradorClasses;

implementation

{$R *.dfm}

procedure TfrmGeradorClasses.FormCreate(Sender: TObject);
begin
  ConfigurarGrid;
  ConfigurarConexao;
  FPastaDestino := ExtractFilePath(Application.ExeName) + 'Classes\';

  if not TDirectory.Exists(FPastaDestino) then
    TDirectory.CreateDirectory(FPastaDestino);
end;

procedure TfrmGeradorClasses.ConfigurarConexao;
begin
  FDConnection.Params.Clear;
  FDConnection.Params.Add('DriverID=MySQL');
  FDConnection.Params.Add('Server=localhost');
  FDConnection.Params.Add('Database=ERPSTORE');
  FDConnection.Params.Add('User_Name=root');
  FDConnection.Params.Add('Password=');
  FDConnection.LoginPrompt := False;
end;

procedure TfrmGeradorClasses.ConfigurarGrid;
begin
  gridTabelas.Cells[0, 0] := '✓';
  gridTabelas.Cells[1, 0] := 'Nome da Tabela';
  gridTabelas.Cells[2, 0] := 'Qtd. Campos';

  gridTabelas.ColWidths[0] := 30;
  gridTabelas.ColWidths[1] := 250;
  gridTabelas.ColWidths[2] := 100;

  gridTabelas.RowCount := 1;
end;

function TfrmGeradorClasses.ValidarConexao: Boolean;
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
      ShowMessage('Erro ao conectar com o banco de dados:' + #13#10 + E.Message);
    end;
  end;
end;

procedure TfrmGeradorClasses.btnConectarClick(Sender: TObject);
begin
  if ValidarConexao then
  begin
    CarregarTabelas;
    ShowMessage('Conexão estabelecida com sucesso!');
  end;
end;

procedure TfrmGeradorClasses.CarregarTabelas;
var
  i: Integer;
begin
  if not FDConnection.Connected then
  begin
    ShowMessage('Conecte-se ao banco de dados primeiro.');
    Exit;
  end;

  try
    qryTabelas.Close;
    qryTabelas.SQL.Text := 'SHOW TABLES';
    qryTabelas.Open;

    gridTabelas.RowCount := qryTabelas.RecordCount + 1;

    i := 1;
    qryTabelas.First;
    while not qryTabelas.Eof do
    begin
      gridTabelas.Cells[0, i] := '☐';
      gridTabelas.Cells[1, i] := qryTabelas.Fields[0].AsString;
      gridTabelas.Cells[2, i] := '-';

      qryTabelas.Next;
      Inc(i);
    end;

    AtualizarContador;

  except
    on E: Exception do
      ShowMessage('Erro ao carregar tabelas: ' + E.Message);
  end;
end;

procedure TfrmGeradorClasses.btnAtualizarTabelasClick(Sender: TObject);
begin
  CarregarTabelas;
end;

procedure TfrmGeradorClasses.gridTabelasMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Col, Row: Integer;
  NomeTabela: string;
  QtdCampos: Integer;
  i: Integer;
begin
  gridTabelas.MouseToCell(X, Y, Col, Row);

  // Se clicou fora das células válidas, sai
  if (Row < 1) or (Row >= gridTabelas.RowCount) or (Col < 0) then
    Exit;

  NomeTabela := gridTabelas.Cells[1, Row];

  //coluna da checkbox
  if Col = 0 then
  begin
    if gridTabelas.Cells[0, Row] = '☐' then
    begin
      gridTabelas.Cells[0, Row] := '☑';

      if NomeTabela <> '' then
      begin
        FCamposTabela := ObterCamposTabela(NomeTabela);
        QtdCampos := Length(FCamposTabela);
        gridTabelas.Cells[2, Row] := IntToStr(QtdCampos);

        AdicionarAbaPreview(NomeTabela);
      end;
    end
    else
    begin
      gridTabelas.Cells[0, Row] := '☐';

      if NomeTabela <> '' then
        RemoverAbaPreview(NomeTabela);
    end;

    AtualizarContador;
  end
  else
  begin
    // Se clicou em outra coluna e a aba já existir, coloca em foco
    for i := 0 to pgcPreview.PageCount - 1 do
      if SameText(pgcPreview.Pages[i].Caption, NomeTabela) then
      begin
        pgcPreview.ActivePage := pgcPreview.Pages[i];
        Break;
      end;
  end;
end;

function TfrmGeradorClasses.ObterCamposTabela(const ANomeTabela: string): TArray<TCampoInfo>;
var
  Campos: TArray<TCampoInfo>;
  Campo: TCampoInfo;
begin
  SetLength(Campos, 0);

  try
    qryCampos.Close;
    qryCampos.SQL.Text := Format('DESCRIBE %s', [ANomeTabela]);
    qryCampos.Open;

    qryCampos.First;
    while not qryCampos.Eof do
    begin
      Campo.Nome := qryCampos.FieldByName('Field').AsString;
      Campo.Tipo := qryCampos.FieldByName('Type').AsString;
      Campo.EhObrigatorio := qryCampos.FieldByName('Null').AsString = 'NO';
      Campo.EhPrimaryKey := qryCampos.FieldByName('Key').AsString = 'PRI';

      // Extrair tamanho se existir
      var Match := TRegEx.Match(Campo.Tipo, '\((\d+)\)');
      if Match.Success then
        Campo.TamanhoMaximo := StrToIntDef(Match.Groups[1].Value, 0)
      else
        Campo.TamanhoMaximo := 0;

      Campo.TipoDelphiProperty := ConverterTipoMySQLParaDelphi(Campo.Tipo, Campo.TamanhoMaximo);
      Campo.TipoDelphiField := ConverterTipoMySQLParaFieldType(Campo.Tipo);

      SetLength(Campos, Length(Campos) + 1);
      Campos[High(Campos)] := Campo;

      qryCampos.Next;
    end;

  except
    on E: Exception do
      ShowMessage('Erro ao obter campos da tabela ' + ANomeTabela + ': ' + E.Message);
  end;

  Result := Campos;
end;

function TfrmGeradorClasses.ConverterTipoMySQLParaDelphi(const ATipoMySQL: string; ATamanho: Integer): string;
var
  TipoLower: string;
begin
  TipoLower := LowerCase(ATipoMySQL);

  if TipoLower.Contains('int') then
    Result := 'Integer'
  else if TipoLower.Contains('decimal') or TipoLower.Contains('float') or TipoLower.Contains('double') then
    Result := 'Currency'
  else if TipoLower.Contains('date') and not TipoLower.Contains('time') then
    Result := 'TDate'
  else if TipoLower.Contains('time') and not TipoLower.Contains('date') then
    Result := 'TTime'
  else if TipoLower.Contains('datetime') or TipoLower.Contains('timestamp') then
    Result := 'TDateTime'
  else if TipoLower.Contains('bool') or TipoLower.Contains('bit') then
    Result := 'Boolean'
  else
    Result := 'string';
end;

function TfrmGeradorClasses.ConverterTipoMySQLParaFieldType(const ATipoMySQL: string): string;
var
  TipoLower: string;
begin
  TipoLower := LowerCase(ATipoMySQL);

  if TipoLower.Contains('int') then
    Result := 'ftInteger'
  else if TipoLower.Contains('decimal') or TipoLower.Contains('float') or TipoLower.Contains('double') then
    Result := 'ftCurrency'
  else if TipoLower.Contains('date') and not TipoLower.Contains('time') then
    Result := 'ftDate'
  else if TipoLower.Contains('time') and not TipoLower.Contains('date') then
    Result := 'ftTime'
  else if TipoLower.Contains('datetime') or TipoLower.Contains('timestamp') then
    Result := 'ftDateTime'
  else if TipoLower.Contains('bool') or TipoLower.Contains('bit') then
    Result := 'ftBoolean'
  else
    Result := 'ftString';
end;

function TfrmGeradorClasses.GerarNomeClasse(const ANomeTabela: string): string;
var
  Nome: string;
begin
  Nome := ANomeTabela;

  // Remover 's' se for plural
  if Nome.EndsWith('s') and (Length(Nome) > 1) then
    Nome := Copy(Nome, 1, Length(Nome) - 1);

  // Primeira letra maiúscula
  if Length(Nome) > 0 then
    Nome[1] := UpCase(Nome[1]);

  Result := 'T' + Nome;
end;

function TfrmGeradorClasses.GerarNomeArquivo(const ANomeTabela: string): string;
var
  Nome: string;
begin
  Nome := ANomeTabela;

  // Remover 's' se for plural
  if Nome.EndsWith('s') and (Length(Nome) > 1) then
    Nome := Copy(Nome, 1, Length(Nome) - 1);

  Result := 'u' + Nome;
end;

function TfrmGeradorClasses.GerarCodigoClasse(const ANomeTabela: string): string;
var
  Codigo: TStringBuilder;
  Campo: TCampoInfo;
  NomeClasse, NomeArquivo, NomeProp, NomeField: string;
begin
  NomeClasse := GerarNomeClasse(ANomeTabela);
  NomeArquivo := GerarNomeArquivo(ANomeTabela);

  Codigo := TStringBuilder.Create;
  try
    // Header
    Codigo.AppendLine(Format('unit %s;', [NomeArquivo]));
    Codigo.AppendLine('');
    Codigo.AppendLine('interface');
    Codigo.AppendLine('');
    Codigo.AppendLine('uses');
    Codigo.AppendLine('  uBaseClass;');
    Codigo.AppendLine('');
    Codigo.AppendLine('type');
    Codigo.AppendLine(Format('  %s = class(TBaseObject)', [NomeClasse]));

    // Private fields
    Codigo.AppendLine('  private');
    for Campo in FCamposTabela do
    begin
      if not Campo.EhPrimaryKey then // Pular ID que já está na base
      begin
        NomeField := 'F' + Campo.Nome;
        // Primeira letra maiúscula
        if Length(NomeField) > 1 then
          NomeField[2] := UpCase(NomeField[2]);

        Codigo.AppendLine(Format('    %s: %s;', [NomeField, Campo.TipoDelphiProperty]));
      end;
    end;

    // Protected
    Codigo.AppendLine('  protected');
    Codigo.AppendLine('    function GetTableName: string; override;');

    // Public properties
    Codigo.AppendLine('  public');
    for Campo in FCamposTabela do
    begin
      if not Campo.EhPrimaryKey then // Pular ID que já está na base
      begin
        NomeProp := Campo.Nome;
        // Primeira letra maiúscula
        if Length(NomeProp) > 0 then
          NomeProp[1] := UpCase(NomeProp[1]);

        NomeField := 'F' + NomeProp;

        Codigo.AppendLine(Format('    property %s: %s read %s write %s;',
          [NomeProp, Campo.TipoDelphiProperty, NomeField, NomeField]));
      end;
    end;

    Codigo.AppendLine('  end;');
    Codigo.AppendLine('');

    // Implementation
    Codigo.AppendLine('implementation');
    Codigo.AppendLine('');
    Codigo.AppendLine(Format('function %s.GetTableName: string;', [NomeClasse]));
    Codigo.AppendLine('begin');
    Codigo.AppendLine(Format('  Result := ''%s'';', [ANomeTabela]));
    Codigo.AppendLine('end;');
    Codigo.AppendLine('');
    Codigo.AppendLine('initialization');
    Codigo.AppendLine(Format('  %s.ClassName;', [NomeClasse]));
    Codigo.AppendLine('');
    Codigo.AppendLine('end.');

    Result := Codigo.ToString;
  finally
    Codigo.Free;
  end;
end;

procedure TfrmGeradorClasses.AtualizarPreview(const ANomeTabela: string);
begin
  FCamposTabela := ObterCamposTabela(ANomeTabela);
  AdicionarAbaPreview(ANomeTabela);
end;

procedure TfrmGeradorClasses.AdicionarAbaPreview(const ANomeTabela: string);
var
  NovaAba: TTabSheet;
  MemoPreview: TMemo;
  NomeClasse: string;
begin
  if AbaJaExiste(ANomeTabela) then
  begin
    for var i := 0 to pgcPreview.PageCount - 1 do
    begin
      if pgcPreview.Pages[i].Caption = ANomeTabela then
      begin
        pgcPreview.ActivePage := pgcPreview.Pages[i];
        Exit;
      end;
    end;
  end;

  if tsPreviewVazio.TabVisible then
    tsPreviewVazio.TabVisible := False;

  NovaAba := TTabSheet.Create(pgcPreview);
  NovaAba.PageControl := pgcPreview;
  NovaAba.Caption := ANomeTabela;

  MemoPreview := TMemo.Create(NovaAba);
  MemoPreview.Parent := NovaAba;
  MemoPreview.Align := alClient;
  MemoPreview.BorderStyle := bsNone;
  MemoPreview.Color := clBtnFace;
  MemoPreview.Font.Name := 'Courier New';
  MemoPreview.Font.Size := 9;
  MemoPreview.Font.Color := 8404992;
  MemoPreview.ReadOnly := True;
  MemoPreview.ScrollBars := ssVertical;

  NomeClasse := GerarCodigoClasse(ANomeTabela);
  MemoPreview.Lines.Text := NomeClasse;

  pgcPreview.ActivePage := NovaAba;
end;

procedure TfrmGeradorClasses.RemoverAbaPreview(const ANomeTabela: string);
var
  i: Integer;
begin
  for i := pgcPreview.PageCount - 1 downto 0 do
  begin
    if pgcPreview.Pages[i].Caption = ANomeTabela then
    begin
      pgcPreview.Pages[i].Free;
      Break;
    end;
  end;

  if pgcPreview.PageCount = 1 then // Só resta a aba de instrução
    tsPreviewVazio.TabVisible := True;
end;

function TfrmGeradorClasses.AbaJaExiste(const ANomeTabela: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to pgcPreview.PageCount - 1 do
  begin
    if pgcPreview.Pages[i].Caption = ANomeTabela then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TfrmGeradorClasses.LimparTodasAbas;
var
  i: Integer;
begin
  // Remove todas as abas menos a de instrução
  for i := pgcPreview.PageCount - 1 downto 0 do
  begin
    if pgcPreview.Pages[i] <> tsPreviewVazio then
      pgcPreview.Pages[i].Free;
  end;

  //aba de instrução
  tsPreviewVazio.TabVisible := True;
  pgcPreview.ActivePage := tsPreviewVazio;
end;

procedure TfrmGeradorClasses.AtualizarContador;
var
  i, Contador: Integer;
begin
  Contador := 0;
  for i := 1 to gridTabelas.RowCount - 1 do
    if gridTabelas.Cells[0, i] = '☑' then
      Inc(Contador);

  lblContador.Caption := Format('%d tabela(s) selecionada(s)', [Contador]);
end;

procedure TfrmGeradorClasses.btnSelecionarTodasClick(Sender: TObject);
var
  i: Integer;
  NomeTabela: string;
begin
  for i := 1 to gridTabelas.RowCount - 1 do
  begin
    if gridTabelas.Cells[0, i] <> '☑' then
    begin
      gridTabelas.Cells[0, i] := '☑';
      NomeTabela := gridTabelas.Cells[1, i];
      if NomeTabela <> '' then
      begin
        FCamposTabela := ObterCamposTabela(NomeTabela);
        gridTabelas.Cells[2, i] := IntToStr(Length(FCamposTabela));
        AdicionarAbaPreview(NomeTabela);
      end;
    end;
  end;
  AtualizarContador;
end;

procedure TfrmGeradorClasses.btnLimparAbasClick(Sender: TObject);
begin
  LimparTodasAbas;
  btnLimparSelecaoClick(self);
end;

procedure TfrmGeradorClasses.btnLimparSelecaoClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 1 to gridTabelas.RowCount - 1 do
    gridTabelas.Cells[0, i] := '☐';

  LimparTodasAbas;
  AtualizarContador;
end;

procedure TfrmGeradorClasses.btnEscolherPastaClick(Sender: TObject);
var
  Folder: string;
begin
  Folder := FPastaDestino;
  if SelectDirectory('Escolha a pasta para salvar as classes:', '', Folder) then
  begin
    FPastaDestino := Folder;
    ShowMessage('Pasta selecionada: ' + FPastaDestino);
  end;
end;

procedure TfrmGeradorClasses.btnGerarClassesClick(Sender: TObject);
var
  i, TotalGeradas: Integer;
  NomeTabela, CodigoClasse, NomeArquivoCompleto: string;
begin
  TotalGeradas := 0;

  if not TDirectory.Exists(FPastaDestino) then
    TDirectory.CreateDirectory(FPastaDestino);

  for i := 1 to gridTabelas.RowCount - 1 do
  begin
    if gridTabelas.Cells[0, i] = '☑' then
    begin
      NomeTabela := gridTabelas.Cells[1, i];
      FCamposTabela := ObterCamposTabela(NomeTabela);
      CodigoClasse := GerarCodigoClasse(NomeTabela);
      NomeArquivoCompleto := TPath.Combine(FPastaDestino, GerarNomeArquivo(NomeTabela) + '.pas');

      try
        TFile.WriteAllText(NomeArquivoCompleto, CodigoClasse, TEncoding.UTF8);
        Inc(TotalGeradas);
      except
        on E: Exception do
          ShowMessage('Erro ao salvar arquivo ' + NomeArquivoCompleto + ': ' + E.Message);
      end;
    end;
  end;

  ShowMessage(Format('%d classe(s) gerada(s) com sucesso na pasta:%s%s',
    [TotalGeradas, #13#10, FPastaDestino]));
end;

procedure TfrmGeradorClasses.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
