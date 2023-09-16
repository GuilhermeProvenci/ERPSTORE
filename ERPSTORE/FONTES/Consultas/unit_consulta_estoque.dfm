inherited form_consulta_estoque: Tform_consulta_estoque
  Caption = 'form_consulta_estoque'
  ClientHeight = 624
  ClientWidth = 869
  ExplicitWidth = 869
  ExplicitHeight = 624
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_principal: TPanel
    Width = 869
    Height = 624
    ExplicitWidth = 869
    ExplicitHeight = 624
    inherited pnl_cabecalho: TPanel
      Width = 869
      ExplicitWidth = 869
      inherited btn_fechar: TSpeedButton
        Left = 799
        ExplicitLeft = 799
      end
      inherited lbl_titulo: TLabel
        Width = 201
        Caption = 'CONSULTA ESTOQUE'
        ExplicitWidth = 201
      end
      inherited pnl_separa_topo: TPanel
        Width = 869
        ExplicitWidth = 869
      end
    end
    inherited pnl_Rodape: TPanel
      Top = 586
      Width = 869
      ExplicitTop = 586
      ExplicitWidth = 869
      inherited lbl_duplo_clique: TLabel
        Left = 574
        ExplicitLeft = 574
      end
    end
    inherited pnl_pesquisa: TPanel
      Width = 869
      ExplicitWidth = 869
      inherited edt_consulta: TEdit
        Width = 679
        ExplicitWidth = 679
      end
      inherited btn_inserir: TButton
        Left = 720
        ExplicitLeft = 720
      end
    end
    inherited pnl_dbgrid: TPanel
      Width = 869
      Height = 457
      ExplicitWidth = 869
      ExplicitHeight = 457
      inherited dbg_registros: TDBGrid
        Width = 829
        Height = 406
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'produto_id'
            Width = 105
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome_produto'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade_em_estoque'
            Width = 64
            Visible = True
          end>
      end
      inherited pnl_resultado: TPanel
        Width = 829
        ExplicitWidth = 829
      end
    end
  end
  inherited ds_consulta: TDataSource
    DataSet = form_conexao_tabelas.qryConsultaEstoque
    Left = 392
  end
end
