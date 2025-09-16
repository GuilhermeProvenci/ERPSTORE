unit unit_cadastro_vendas;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_cadastro_padrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls;
type
  Tform_cadastro_vendas = class(TfrmBaseRegister)
    pnl_numero_venda: TPanel;
    lbl_numero_venda: TLabel;
    edtNumeroVenda: TEdit;
    pnl_barra_numero_venda: TPanel;
    pnl_cliente: TPanel;
    lbl_cliente: TLabel;
    cmbCliente: TComboBox;
    pnl_barra_cliente: TPanel;
    pnl_data_venda: TPanel;
    lbl_data_venda: TLabel;
    dtpDataVenda: TDateTimePicker;
    pnl_barra_data_venda: TPanel;
    pnl_hora_venda: TPanel;
    lbl_hora_venda: TLabel;
    dtpHoraVenda: TDateTimePicker;
    pnl_barra_hora_venda: TPanel;
    pnl_vendedor: TPanel;
    lbl_vendedor: TLabel;
    edtVendedor: TEdit;
    pnl_barra_vendedor: TPanel;
    pnl_valor_subtotal: TPanel;
    lbl_valor_subtotal: TLabel;
    edtValorSubtotal: TEdit;
    pnl_barra_valor_subtotal: TPanel;
    pnl_desconto: TPanel;
    lbl_desconto: TLabel;
    edtDesconto: TEdit;
    pnl_barra_desconto: TPanel;
    pnl_valor_total: TPanel;
    lbl_valor_total: TLabel;
    edtValorTotal: TEdit;
    pnl_barra_valor_total: TPanel;
    pnl_forma_pagamento: TPanel;
    lbl_forma_pagamento: TLabel;
    cmbFormaPagamento: TComboBox;
    pnl_barra_forma_pagamento: TPanel;
    pnl_status: TPanel;
    lbl_status: TLabel;
    cmbStatus: TComboBox;
    pnl_barra_status: TPanel;
    pnl_observacoes: TPanel;
    lbl_observacoes: TLabel;
    memoObservacoes: TMemo;
    pnl_barra_observacoes: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  form_cadastro_vendas: Tform_cadastro_vendas;
implementation
{$R *.dfm}
initialization
  Tform_cadastro_vendas.ClassName;
end.
