inherited form_consulta_produtos: Tform_consulta_produtos
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_principal: TPanel
    inherited pnl_cabecalho: TPanel
      inherited lbl_titulo: TLabel
        Width = 219
        Caption = 'CONSULTA PRODUTOS'
        ExplicitWidth = 219
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
            FieldName = 'nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'preco'
            Visible = True
          end>
      end
    end
  end
  inherited ds_consulta: TDataSource
    DataSet = form_conexao_tabelas.qryConsultaProdutos
  end
end
