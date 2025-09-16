unit uProduto;

interface

uses
  uBaseClass;

type
  TProduto = class(TBaseObject)
  private
    FNome: string;
    FTamanho: string;
    FPreco: Currency;
  protected
    function GetTableName: string; override;
  public
    property Nome: string read FNome write FNome;
    property Tamanho: string read FTamanho write FTamanho;
    property Preco: Currency read FPreco write FPreco;
  end;

implementation

function TProduto.GetTableName: string;
begin
  Result := 'produtos';
end;

initialization
  TProduto.ClassName;

end.
