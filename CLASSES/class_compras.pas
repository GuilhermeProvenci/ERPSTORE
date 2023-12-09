unit class_compras;

interface

uses class_clientes;

type
  TCompra = class
  public
    class function CalcularValorFinal(valorCompra: Double; cliente: TClientes): Double;
  end;

implementation

{ TCompra }

class function TCompra.CalcularValorFinal(valorCompra: Double; cliente: TClientes): Double;
var
  desconto: Double;
begin
  
  desconto := cliente.ObterDesconto;

  
  Result := valorCompra * (1 - desconto);
end;

end.
