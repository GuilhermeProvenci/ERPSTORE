unit ucliente;

interface

uses
  uBaseClass;

type
  TCliente = class(TBaseObject)
  private
    FCodigo_cliente: string;
    FNome: string;
    FCpf_cnpj: string;
    FTelefone: string;
    FEmail: string;
    FEndereco: string;
    FCep: string;
    FCidade: string;
    FEstado: string;
    FClassificacao: string;
    FLimite_credito: Currency;
    FCredito_usado: Currency;
    FStatus: string;
    FData_nascimento: TDate;
    FObservacoes: string;
    FData_cadastro: TDateTime;
    FData_atualizacao: TDateTime;
    FUsuario_cadastro: string;
  protected
    function GetTableName: string; override;
  public
    property Codigo_cliente: string read FCodigo_cliente write FCodigo_cliente;
    property Nome: string read FNome write FNome;
    property Cpf_cnpj: string read FCpf_cnpj write FCpf_cnpj;
    property Telefone: string read FTelefone write FTelefone;
    property Email: string read FEmail write FEmail;
    property Endereco: string read FEndereco write FEndereco;
    property Cep: string read FCep write FCep;
    property Cidade: string read FCidade write FCidade;
    property Estado: string read FEstado write FEstado;
    property Classificacao: string read FClassificacao write FClassificacao;
    property Limite_credito: Currency read FLimite_credito write FLimite_credito;
    property Credito_usado: Currency read FCredito_usado write FCredito_usado;
    property Status: string read FStatus write FStatus;
    property Data_nascimento: TDate read FData_nascimento write FData_nascimento;
    property Observacoes: string read FObservacoes write FObservacoes;
    property Data_cadastro: TDateTime read FData_cadastro write FData_cadastro;
    property Data_atualizacao: TDateTime read FData_atualizacao write FData_atualizacao;
    property Usuario_cadastro: string read FUsuario_cadastro write FUsuario_cadastro;
  end;

implementation

function TCliente.GetTableName: string;
begin
  Result := 'clientes';
end;

initialization
  TCliente.ClassName;

end.

