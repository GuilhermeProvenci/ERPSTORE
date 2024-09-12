unit class_clientes_C;

interface

uses
  System.Classes, System.SysUtils;

type
  TClientesCampos = class
  private
    FID: Integer;
    FNome: string;
    FTelefone: string;
    FEndereco: string;
    FClassificacao: string;
    procedure SetID(const Value: Integer);
  public
    property ID: Integer read FID write SetID;
    property Nome: string read FNome write FNome;
    property Telefone: string read FTelefone write FTelefone;
    property Endereco: string read FEndereco write FEndereco;
    property Classificacao: string read FClassificacao write FClassificacao;
  end;

implementation

procedure TClientesCampos.SetID(const Value: Integer);
begin
  FID := Value;
end;

end.

