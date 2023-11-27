inherited form_consulta_clientes: Tform_consulta_clientes
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_principal: TPanel
    inherited pnl_cabecalho: TPanel
      inherited lbl_titulo: TLabel
        Width = 200
        Caption = 'CONSULTA CLIENTES'
        ExplicitWidth = 200
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
            Width = 401
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'telefone'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'endereco'
            Visible = True
          end>
      end
    end
  end
  inherited ds_consulta: TDataSource
    DataSet = form_conexao_tabelas.qryConsultaClientes
  end
end
