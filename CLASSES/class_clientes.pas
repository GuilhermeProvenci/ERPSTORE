unit class_clientes;

interface

uses
  System.Classes, FireDAC.Comp.Client, System.SysUtils, System.Rtti;

type
  TClassificacao = (clBronze, clPrata, clOuro, clDiamante);

  TClientes = class(TComponent)
  private
    FID: Integer;
    FNome: string;
    FTelefone: string;
    FEndereco: string;
    FClassificacao: TClassificacao;
    procedure SetID(const Value: Integer);
    procedure CarregarCampos;
  public
   // constructor Create(AID: Integer; ANome, ATelefone, AEndereco: string; AClassificacao: TClassificacao);
    constructor Create;
    property ID: Integer read FID write SetID;
    property Nome: string read FNome;
    property Telefone: string read FTelefone;
    property Endereco: string read FEndereco;
    property Classificacao: TClassificacao read FClassificacao;
    function ObterDesconto: Double;
  end;

implementation

{ TClientes }

uses
  gplEdit, Vcl.Dialogs, Vcl.Forms;

//constructor TClientes.Create(AID: Integer; ANome, ATelefone, AEndereco: string; AClassificacao: TClassificacao);
constructor TClientes.Create;
begin
//  inherited Create(nil);
//  FID := AID;
//  FNome := ANome;
//  FTelefone := ATelefone;
//  FEndereco := AEndereco;
//  FClassificacao := AClassificacao;
  CarregarCampos;

  ShowMessage(Format('ID: %d'#13#10'Nome: %s'#13#10'Telefone: %s'#13#10'Endereco: %s'#13#10'Classificacao: %d',
  [FID, FNome, FTelefone, FEndereco, Ord(FClassificacao)]));
end;

procedure TClientes.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TClientes.CarregarCampos;
var
  i: Integer;
  Componente: TComponent;
  NomePropriedade: string;
  Valor: Variant;
  Contexto: TRttiContext;
  Propriedade: TRttiProperty;
begin
  if not Assigned(Owner) or not (Owner is TForm) then
    Exit; // Sair se não houver formulário associado ou se o Owner não for um TForm

  Contexto := TRttiContext.Create;
  try
    for i := 0 to TForm(Owner).ComponentCount - 1 do
    begin
      Componente := TForm(Owner).Components[i];

      // Verificar se o componente tem uma propriedade 'DataFieldName'
      if not (Componente is TgpEdit) then
        Continue;

      NomePropriedade := TgpEdit(Componente).DataFieldName;
      if NomePropriedade <> '' then
      begin
        // Verificar se a propriedade existe na classe
        Propriedade := Contexto.GetType(Self.ClassType).GetProperty(NomePropriedade);
        if Assigned(Propriedade) then
        begin
          // Converter Variant para TValue antes de atribuir à propriedade
          Valor := TgpEdit(Componente).Text; // Ou outra propriedade adequada
          Propriedade.SetValue(Self, TValue.FromVariant(Valor));
        end;
      end;
    end;
  finally
    Contexto.Free;
  end;
end;



function TClientes.ObterDesconto: Double;
const
  DescontoBronze = 0.05;
  DescontoPrata = 0.1;
  DescontoOuro = 0.15;
  DescontoDiamante = 0.2;
begin
  // Retornar o desconto com base na classificação do cliente
  case FClassificacao of
    clBronze: Result := DescontoBronze;
    clPrata: Result := DescontoPrata;
    clOuro: Result := DescontoOuro;
    clDiamante: Result := DescontoDiamante;
  else
    Result := 0.0; // Nenhum desconto para classificação não reconhecida
  end;
end;

initialization
  RegisterClass(TClientes);

end.

