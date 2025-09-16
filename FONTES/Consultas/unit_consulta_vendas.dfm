inherited form_consulta_vendas: Tform_consulta_vendas
  Caption = 'form_consulta_vendas'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 13
  inherited pnlMain: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited pnlTop: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited lblTitle: TLabel
        Height = 56
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited pnlSeparator: TPanel
        StyleElements = [seFont, seClient, seBorder]
      end
    end
    inherited pnlBottom: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited lblDoubleClick: TLabel
        Height = 38
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited lblDelete: TLabel
        Height = 38
        StyleElements = [seFont, seClient, seBorder]
      end
    end
    inherited pnlSearch: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited lblText: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited edtSearch: TEdit
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited btnInsert: TPanel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited btnReports: TPanel
        StyleElements = [seFont, seClient, seBorder]
      end
    end
    inherited pnl_dbgrid: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited gridRegister: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cliente_id'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'numero_venda'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_venda'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'hora_venda'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor_subtotal'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor_desconto'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'percentual_desconto'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor_total'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'forma_pagamento'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'status_venda'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'vendedor'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'observacoes'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_cadastro'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_atualizacao'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'usuario_cadastro'
            Visible = True
          end>
      end
      inherited pnlResult: TPanel
        StyleElements = [seFont, seClient, seBorder]
        inherited lblResult: TLabel
          Height = 41
          StyleElements = [seFont, seClient, seBorder]
        end
      end
    end
  end
  inherited ds_consulta: TDataSource
    DataSet = form_conexao_tabelas.qryConsultaVendas
  end
end
