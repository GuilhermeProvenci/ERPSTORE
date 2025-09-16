unit uCliente;

interface

uses
  uBaseClass;

type
  TCliente = class(TBaseObject)
  private
    FNome: string;
    FEndereco: string;
    FTelefone: string;
    FClassificacao: string;
  protected
    function GetTableName: string; override;
  public
    property Nome: string read FNome write FNome;
    property Endereco: string read FEndereco write FEndereco;
    property Telefone: string read FTelefone write FTelefone;
    property Classificacao: string read FClassificacao write FClassificacao;
  end;

implementation

function TCliente.GetTableName: string;
begin
  Result := 'clientes';
end;

initialization
  TCliente.ClassName;

end.

