inherited form_consulta_condicional: Tform_consulta_condicional
  Caption = 'form_consulta_condicional'
  ClientHeight = 637
  ClientWidth = 962
  ExplicitWidth = 962
  ExplicitHeight = 637
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_principal: TPanel
    Width = 962
    Height = 637
    inherited pnl_cabecalho: TPanel
      Width = 962
      inherited btn_fechar: TSpeedButton
        Left = 892
      end
      inherited lbl_titulo: TLabel
        Width = 283
        Caption = 'CONSULTA DE CONDICIONAL'
        ExplicitWidth = 283
      end
      inherited pnl_separa_topo: TPanel
        Width = 962
      end
    end
    inherited pnl_Rodape: TPanel
      Top = 599
      Width = 962
      inherited lbl_duplo_clique: TLabel
        Left = 667
      end
    end
    inherited pnl_pesquisa: TPanel
      Width = 962
      inherited edt_consulta: TEdit
        Width = 772
      end
      inherited btn_inserir: TButton
        Left = 813
        Caption = 'Add Itens'
      end
    end
    inherited pnl_dbgrid: TPanel
      Width = 962
      Height = 470
      inherited dbg_registros: TDBGrid
        Width = 922
        Height = 419
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
            FieldName = 'data_entregue'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_devolucao'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome_cliente'
            Visible = True
          end>
      end
      inherited pnl_resultado: TPanel
        Width = 922
      end
    end
  end
  inherited ds_consulta: TDataSource
    DataSet = form_conexao_tabelas.qryConsultaCondicional
  end
end
