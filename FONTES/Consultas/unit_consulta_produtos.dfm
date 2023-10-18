inherited form_consulta_produtos: Tform_consulta_produtos
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_principal: TPanel
    inherited pnl_cabecalho: TPanel
      ExplicitWidth = 833
      inherited lbl_titulo: TLabel
        Width = 219
        Height = 56
        Caption = 'CONSULTA PRODUTOS'
        ExplicitWidth = 219
      end
      inherited pnl_separa_topo: TPanel
        ExplicitWidth = 833
      end
    end
    inherited pnl_Rodape: TPanel
      ExplicitTop = 478
      ExplicitWidth = 833
      inherited lbl_duplo_clique: TLabel
        Height = 38
      end
      inherited lbl_excluir: TLabel
        Height = 38
      end
    end
    inherited pnl_pesquisa: TPanel
      inherited edt_consulta: TEdit
        ExplicitWidth = 643
      end
      inherited btn_inserir: TButton
        ExplicitLeft = 684
      end
    end
    inherited pnl_dbgrid: TPanel
      ExplicitWidth = 833
      ExplicitHeight = 349
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
            FieldName = 'tamanho'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'preco'
            Visible = True
          end>
      end
      inherited pnl_resultado: TPanel
        ExplicitWidth = 793
        inherited lbl_resultado: TLabel
          Height = 41
        end
      end
    end
  end
  inherited ds_consulta: TDataSource
    DataSet = form_conexao_tabelas.qryConsultaProdutos
  end
end
