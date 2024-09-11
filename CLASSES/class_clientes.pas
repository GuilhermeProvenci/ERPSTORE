unit class_clientes;

interface

uses
  System.Classes, FireDAC.Comp.Client, System.SysUtils, System.Rtti, VCL.Forms, gplForm, gplCombo, unit_funcoes, class_gplObject;

type
  TClientes = class(TgplObject)
  private
    FID: Integer;
    FNome: string;
    FTelefone: string;
    FEndereco: string;
    FClassificacao: string;
    FOwnerForm: TgpForm;
    procedure SetID(const Value: Integer);
  public
    constructor Create(form: TgpForm);
    [TPersistente] property ID: Integer read FID write SetID;
    [TPersistente] property Nome: string read FNome write FNome;
    [TPersistente] property Telefone: string read FTelefone write FTelefone;
    [TPersistente] property Endereco: string read FEndereco write FEndereco;
    [TPersistente] property Classificacao: string read FClassificacao write FClassificacao;
    property OwnerForm: TgpForm read FOwnerForm write FOwnerForm;  // Não é persistente
    function ObterDesconto: Double;
    procedure TestMensage;
  protected
  end;

implementation

uses
  gplEdit, Vcl.Dialogs, StrUtils;

constructor TClientes.Create(form: TgpForm);
begin
  inherited Create();
  OwnerForm := form;
  CarregarCamposClasse(OwnerForm, Self);
  Table := 'clientes';  // Nome da tabela
end;

procedure TClientes.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TClientes.TestMensage;
begin
  ShowMessage(Format('ID: %d'#13#10'Nome: %s'#13#10'Telefone: %s'#13#10'Endereco: %s'#13#10'Classificacao: %s',
  [FID, FNome, FTelefone, FEndereco, FClassificacao]));
end;

function TClientes.ObterDesconto: Double;
begin
  case AnsiIndexStr(UpperCase(Trim(FClassificacao)), ['BRONZE', 'PRATA', 'OURO', 'DIAMANTE']) of
    0: Result := 0.05;
    1: Result := 0.1;
    2: Result := 0.15;
    3: Result := 0.2;
  else
    Result := 0.0;
  end;
end;

initialization
  RegisterClass(TClientes);

end.

