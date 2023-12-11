﻿unit class_clientes;

interface

uses
  System.Classes;

type
  TClassificacao = (clBronze, clPrata, clOuro, clDiamante);

  TClientes = class(TComponent)
  private
    FNome: string;
    FTelefone: string;
    FEndereco: string;
    FClassificacao: TClassificacao;
  public
    constructor Create(ANome, ATelefone, AEndereco: string; AClassificacao: TClassificacao);
    property Nome: string read FNome;
    property Telefone: string read FTelefone;
    property Endereco: string read FEndereco;
    property Classificacao: TClassificacao read FClassificacao;
    function ObterDesconto: Double;
  end;

implementation

{ TCliente }

constructor TClientes.Create(ANome, ATelefone, AEndereco: string; AClassificacao: TClassificacao);
begin
  FNome := ANome;
  FTelefone := ATelefone;
  FEndereco := AEndereco;
  FClassificacao := AClassificacao;
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
