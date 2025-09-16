unit uVendas;

interface

uses
  uBaseClass;

type
  TVenda = class(TBaseObject)
  private
    FClienteId: Integer;
    FNumeroVenda: string;
    FDataVenda: TDate;
    FHoraVenda: TTime;
    FValorSubtotal: Currency;
    FValorDesconto: Currency;
    FPercentualDesconto: Currency;
    FValorTotal: Currency;
    FFormaPagamento: string;
    FStatusVenda: string;
    FVendedor: string;
    FObservacoes: string;
    FUsuarioCadastro: string;
  protected
    function GetTableName: string; override;
  public
    property ClienteId: Integer read FClienteId write FClienteId;
    property NumeroVenda: string read FNumeroVenda write FNumeroVenda;
    property DataVenda: TDate read FDataVenda write FDataVenda;
    property HoraVenda: TTime read FHoraVenda write FHoraVenda;
    property ValorSubtotal: Currency read FValorSubtotal write FValorSubtotal;
    property ValorDesconto: Currency read FValorDesconto write FValorDesconto;
    property PercentualDesconto: Currency read FPercentualDesconto write FPercentualDesconto;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
    property FormaPagamento: string read FFormaPagamento write FFormaPagamento;
    property StatusVenda: string read FStatusVenda write FStatusVenda;
    property Vendedor: string read FVendedor write FVendedor;
    property Observacoes: string read FObservacoes write FObservacoes;
    property UsuarioCadastro: string read FUsuarioCadastro write FUsuarioCadastro;
  end;

  TVendaItem = class(TBaseObject)
  private
    FVendaId: Integer;
    FProdutoId: Integer;
    FQuantidade: Integer;
    FPrecoUnitario: Currency;
    FDescontoItem: Currency;
    FSubtotal: Currency;
  protected
    function GetTableName: string; override;
  public
    property VendaId: Integer read FVendaId write FVendaId;
    property ProdutoId: Integer read FProdutoId write FProdutoId;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property PrecoUnitario: Currency read FPrecoUnitario write FPrecoUnitario;
    property DescontoItem: Currency read FDescontoItem write FDescontoItem;
    property Subtotal: Currency read FSubtotal write FSubtotal;
  end;

implementation

function TVenda.GetTableName: string;
begin
  Result := 'vendas';
end;

function TVendaItem.GetTableName: string;
begin
  Result := 'vendas_itens';
end;

initialization
  TVenda.ClassName;
  TVendaItem.ClassName;

end.
