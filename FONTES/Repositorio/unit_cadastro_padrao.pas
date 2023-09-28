unit unit_cadastro_padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  Tform_cadastro_padrao = class(TForm)
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
    edt_codigo: TEdit;
    edt_nome: TEdit;
    edt_3: TEdit;
    edt_4: TEdit;
    pnl_salvar: TPanel;
    Image1: TImage;
    qryInsert: TFDQuery;
    procedure btn_fecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnl_salvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_cadastro_padrao: Tform_cadastro_padrao;
  var
  NomeForm: string;
  NomeTabela: string;

implementation

{$R *.dfm}

uses unit_mensagem, unit_funcoes, unit_conexao, unit_conexao_tabelas;

procedure Tform_cadastro_padrao.btn_fecharClick(Sender: TObject);
begin
 if CriarMensagem('DELETE', 'Tem certeza que deseja Sair sem salvar?') = True then
 begin
 qryInsert.close;
 self.Close;
 end;



end;

procedure Tform_cadastro_padrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//FreeAndNil(Self);
action := caFree;
self := Nil;
end;

procedure Tform_cadastro_padrao.FormCreate(Sender: TObject);

begin
  NomeForm := Self.Name;
  Delete(NomeForm, 1, Length('form_cadastro_')); // Remove 'form_cadastro_'

  NomeTabela := NomeForm; // Usar o nome que você deu para o from como
                          // nome da tabela (nomear as tabelas seguindo
                          // esse padrão

   limpaEDit(Self);
   maxID(NomeTabela, edt_codigo);


end;

procedure Tform_cadastro_padrao.pnl_salvarClick(Sender: TObject);
var
i : integer;
begin
    ValidarCampoObrigatorios(Self);

    ChamarInsertGenerico(NomeTabela, self);
    limpaEDit(Self);
    maxID(NomeTabela, edt_codigo);
    CriarMensagem('aviso', 'Registro Salvo com sucesso');
end;


end.
