inherited form_consulta_vendas: Tform_consulta_vendas
  Caption = 'form_consulta_vendas'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_principal: TPanel
    inherited pnl_cabecalho: TPanel
      inherited lbl_titulo: TLabel
        Width = 222
        Height = 56
        Caption = 'CONSULTA DE VENDAS'
        ExplicitWidth = 222
      end
    end
    inherited pnl_Rodape: TPanel
      inherited lbl_duplo_clique: TLabel
        Height = 38
      end
      inherited lbl_excluir: TLabel
        Height = 38
      end
    end
    inherited pnl_dbgrid: TPanel
      inherited dbg_registros: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'id_cliente'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'observacao'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_venda'
            Visible = True
          end>
      end
      inherited pnl_resultado: TPanel
        inherited lbl_resultado: TLabel
          Height = 41
        end
      end
    end
  end
  inherited ds_consulta: TDataSource
    DataSet = form_conexao_tabelas.qryConsultaVendas
  end
end
