inherited form_consulta_condicional: Tform_consulta_condicional
  Caption = 'form_consulta_condicional'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_principal: TPanel
    inherited pnl_cabecalho: TPanel
      inherited lbl_titulo: TLabel
        Height = 56
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
    inherited pnl_pesquisa: TPanel
      inherited btn_inserir: TButton
        Caption = 'Add Itens'
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
            FieldName = 'cliente_id'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'produto_id'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_retirada'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_devolucao'
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
    DataSet = form_conexao_tabelas.qryConsultaCondicional
  end
end
