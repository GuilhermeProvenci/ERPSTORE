unit unit_consulta_padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Comp.Client,
  unit_cadastro_padrao;

type
  Tform_consulta_padrao = class(TForm)
    pnl_principal: TPanel;
    pnl_cabecalho: TPanel;
    btn_fechar: TSpeedButton;
    pnl_separa_topo: TPanel;
    pnl_Rodape: TPanel;
    lbl_duplo_clique: TLabel;
    lbl_excluir: TLabel;
    pnl_pesquisa: TPanel;
    lbl_texto: TLabel;
    edt_consulta: TEdit;
    btn_inserir: TButton;
    pnl_dbgrid: TPanel;
    dbg_registros: TDBGrid;
    pnl_resultado: TPanel;
    lbl_resultado: TLabel;
    ds_consulta: TDataSource;
    lbl_titulo: TLabel;
    procedure btn_fecharClick(Sender: TObject);
    procedure btn_inserirClick(Sender: TObject);
    procedure dbg_registrosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbg_registrosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_consultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbg_registrosTitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure dbg_registrosDblClick(Sender: TObject);
  private
    { Private declarations }
    sSQL : TStrings;
    NomeCampo : String;
    TipoCampo : TFieldType;
    vID : Integer;
  public
    { Public declarations }
    procedure CriaForm(const Nome: string; ModoEdicao: Boolean);
    var
    NomeForm: string;
  end;

var
  form_consulta_padrao: Tform_consulta_padrao;

implementation

{$R *.dfm}

uses unit_funcoes, unit_principal, unit_cadastro_clientes, unit_cadastro_produtos,
  ClassMap, unit_cadastro_condicional, unit_cadastro_estoque;



procedure Tform_consulta_padrao.btn_fecharClick(Sender: TObject);
begin
  //FECHA O FORM
  Self.Close;
end;

procedure Tform_consulta_padrao.btn_inserirClick(Sender: TObject);
begin
// Abrir a tela de cadastro em modo de inserção
CriaForm(NomeForm, False);

end;

procedure Tform_consulta_padrao.CriaForm(const Nome: string; ModoEdicao: Boolean);
var
  Tela: TForm;
  Classe: TFormClass;
begin
  // Chamada da função FindClass do Delphi que procura uma classe registrada.
  Classe := TFormClass(FindClass(Nome));
  Tela := Classe.Create(Application);

  if ModoEdicao then
  begin
   (Tela as Tform_cadastro_padrao).ID := vID;
   (Tela as Tform_cadastro_padrao).ModoEdicao := true;
  end;

  Tela.ShowModal;
end;



procedure Tform_consulta_padrao.dbg_registrosDblClick(Sender: TObject);
begin
  // Verifica se há registros no DataSet
  if not ds_consulta.DataSet.IsEmpty then
  begin
    // Obtém o ID da linha selecionada
    vID := ds_consulta.DataSet.FieldByName('ID').AsInteger;
    // Abrir o formulário em modo de edição
    CriaForm(NomeForm, True);

  end;
end;

procedure Tform_consulta_padrao.dbg_registrosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  //funcao que da um layout diferente ao dbgrid
  prcDrawColumnCell( Sender, Rect, DataCol, Column, State );
end;

procedure Tform_consulta_padrao.dbg_registrosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  //se pressionou a tecla delete dentro do dbgrid entao chama o delete do dataset
  if ( Key = VK_DELETE ) and ( not ( ds_consulta.DataSet.IsEmpty ) ) and
     ( CriarMensagem('CONFIRMAÇÃO','Tem Certeza que deseja EXCLUIR essa Informação?') ) then
    ds_consulta.DataSet.Delete;
end;

procedure Tform_consulta_padrao.dbg_registrosTitleClick( Column: TColumn );
var
  Key : Word;

begin
  //quando clica no titulo da coluna do dbgrid muda a ordenação e
  //o campo que a consulta é feita

  //se trocou a coluna de busca entao tem que limpar query e chamar o metodo
  //edt_consultaKeyDown manualmente que é onde a consulta é montada
  if ( NomeCampo <> '' ) and ( NomeCampo <> Column.FieldName ) then
  begin
    edt_consulta.Clear;
    Key := VK_RETURN;
    edt_consultaKeyDown( edt_consulta, Key, [] );
  end;


  NomeCampo := Column.FieldName ; //pega o nome do campo dessa coluna
  TipoCampo := Column.Field.DataType; // pega o tipo do campo da coluna (integer, string, etc)

  //pinta o titulo da coluna que foi clicada
  prc_pintar_titulo_coluna( dbg_registros, Column );

  //trocar o texto do edt_consulta
  lbl_texto.Caption := 'Digite o(a) '+ Column.Title.Caption +
                       ' que dejesa encontrar e aperte ENTER.';


  if ( not ( ds_consulta.DataSet.IsEmpty ) ) then
  begin
    //ao inves de usar o order by, pode ser ordenado usando a propriedade
    // IndexFieldNames nos componentes TFDQuery - :D corresponde ao decrescente
    if ( ds_consulta.DataSet as TFDQuery ).IndexFieldNames = Column.FieldName Then
      ( ds_consulta.DataSet as TFDQuery ).IndexFieldNames := Column.FieldName + ':D'
    else
      ( ds_consulta.DataSet as TFDQuery ).IndexFieldNames := Column.FieldName;

    //apos realizar a ordenação, coloca o cursor no primeiro campo
    ( ds_consulta.DataSet as TFDQuery ).First;

    //aumenta o tamanho da linha do ddgrid
    prc_ajusta_tamanho_linha( dbg_registros );
  end;

end;

procedure Tform_consulta_padrao.edt_consultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  sWhere,
  sFiltro : String;

begin
  //se for pressionada a tecla enter dentro do edtConsulta
  if ( key = VK_RETURN ) and ( ds_consulta.DataSet <> nil ) then
  begin

    //limpa o sql existente na query da ultima consulta realizada
    //e atribui o sql Padrao Salvo na Variavel
    ( ds_consulta.DataSet as TFDQuery ).Close;
    ( ds_consulta.DataSet as TFDQuery ).SQL.Clear;
    ( ds_consulta.DataSet as TFDQuery ).SQL.AddStrings( sSql );

    //remove os caracteres do edt_consulta.text se o campo escolhido for do tipo inteiro
    if ( TipoCampo = ftInteger ) then
      edt_consulta.Text := SomenteNumeros( edt_consulta.Text );

    //se for diferente de vazio tenho que buscar utilizando parametros
    if Trim ( edt_consulta.Text ) <> '' then
    begin
      //testo pra ver se já existe um where no sql
      if Pos ('WHERE', AnsiUpperCase( ( ds_consulta.DataSet as TFDQuery ).SQL.Text ) ) > 0 then
        sWhere := ' AND '
      else
        sWhere :=  ' WHERE ';

      if ( TipoCampo = ftInteger ) or  ( TipoCampo = ftDate ) then
        sFiltro := sWhere + NomeCampo + ' = :TEXTO '
      else
        sFiltro := sWhere + NomeCampo + ' LIKE ''%'' || :TEXTO || ''%''  ';

      //Adiciona o Filtro montado ao sql da query
      ( ds_consulta.DataSet as TFDQuery ).SQL.Add ( sFiltro );

      //manda o parametro texto receber o conteudo do edit que deve ser encontrado
      ( ds_consulta.DataSet as TFDQuery ).ParamByName('TEXTO').AsString := edt_consulta.Text;
    end;

    //abre a consulta apos a manipulação do sql
    ( ds_consulta.DataSet as TFDQuery ).open;
    ( ds_consulta.DataSet as TFDQuery ).IndexFieldNames := NomeCampo;
    ( ds_consulta.DataSet as TFDQuery ).First;


    //ajustas as colunas do dbgrid
    prc_ajustar_colunas_grid( dbg_registros );

    //aumenta o tamanho da linha do ddgrid
    prc_ajusta_tamanho_linha( dbg_registros );
  end;
end;

procedure Tform_consulta_padrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //libera o sql padrao da memoria
  sSQL.Destroy;

  //fecha a query do dbgrid
  if ds_consulta.DataSet <> nil then
    ds_consulta.DataSet.Close;

  //Libera o Form da Memoria
  FreeAndNil ( Self );

  //reativa os botoes do formprincipal
  if form_principal <> nil then //se o form principal existir
    form_principal.prc_controla_menu ( True );

end;

procedure Tform_consulta_padrao.FormCreate(Sender: TObject);
var
  ClassName: TClass;
begin
  NomeForm := Self.Name;
  Delete(NomeForm, 1, Length('form_consulta_'));
  NomeForm := 'Tform_cadastro_' + NomeForm;


  sSQL := TStringList.Create;
  sSQL.Assign( ( ds_consulta.DataSet as TFDQuery ).SQL );

  //ordena inicialmente pela coluna numero 0, ou seja, a primeira coluna do dbgrid
  dbg_registrosTitleClick( dbg_registros.Columns[0] );


   if ds_consulta.DataSet <> nil then
    ds_consulta.DataSet.active:= true;
end;


initialization

RegisterClass(Tform_cadastro_clientes);
RegisterClass(Tform_cadastro_produtos);
RegisterClass(Tform_cadastro_condicional);
RegisterClass(Tform_cadastro_estoque);
end.
