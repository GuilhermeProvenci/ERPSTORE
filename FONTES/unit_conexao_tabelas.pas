unit unit_conexao_tabelas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  Tform_conexao_tabelas = class(TDataModule)
    qryConsultaClientes: TFDQuery;
    qryConsultaProdutos: TFDQuery;
    qryConsultaCST: TFDQuery;
    qryConsultaCSTID_CST: TIntegerField;
    qryConsultaCSTFG_TIPO: TStringField;
    qryConsultaCSTCD_CST: TStringField;
    qryConsultaCSTDS_CST: TStringField;
    qryConsultaClientesid: TFDAutoIncField;
    qryConsultaClientesnome: TStringField;
    qryConsultaClientestelefone: TStringField;
    qryConsultaClientesendereco: TStringField;
    DataSourceClientes: TDataSource;
    DataSourceProdutos: TDataSource;
    DataSourceCondicional: TDataSource;
    qryConsultaEstoque: TFDQuery;
    dsEstoque: TDataSource;
    qryConsultaEstoqueid: TFDAutoIncField;
    qryConsultaEstoqueproduto_id: TIntegerField;
    qryConsultaEstoquenome_produto: TStringField;
    qryConsultaEstoquequantidade_em_estoque: TIntegerField;
    qryConsultaCondicional: TFDQuery;
    qryConsultaCondicionalid: TFDAutoIncField;
    qryConsultaCondicionalcliente_id: TIntegerField;
    qryConsultaCondicionaldata_entregue: TDateField;
    qryConsultaCondicionaldata_devolucao: TDateField;
    qryConsultaCondicionalnome_cliente: TStringField;
    qryConsultaProdutosid: TFDAutoIncField;
    qryConsultaProdutosnome: TStringField;
    qryConsultaProdutostamanho: TStringField;
    qryConsultaProdutospreco: TBCDField;
    procedure qryConsultaCSTBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    sTipoCST: String;{ Public declarations }
  end;

var
  form_conexao_tabelas: Tform_conexao_tabelas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses unit_conexao;

{$R *.dfm}

procedure Tform_conexao_tabelas.qryConsultaCSTBeforeOpen(DataSet: TDataSet);
begin
  qryConsultaCST.ParamByName('p_fg_tipo').AsString := sTipoCST;
end;

end.
