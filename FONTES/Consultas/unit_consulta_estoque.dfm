inherited form_consulta_estoque: Tform_consulta_estoque
  Caption = 'form_consulta_estoque'
  ClientHeight = 624
  ClientWidth = 869
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 869
  ExplicitHeight = 624
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 869
    Height = 624
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 869
    ExplicitHeight = 624
    inherited pnlTop: TPanel
      Width = 869
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 869
      inherited btnClose: TSpeedButton
        Left = 796
        ExplicitLeft = 796
      end
      inherited lblTitle: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited pnlSeparator: TPanel
        Width = 869
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 869
      end
    end
    inherited pnlBottom: TPanel
      Top = 586
      Width = 869
      StyleElements = [seFont, seClient, seBorder]
      ExplicitTop = 586
      ExplicitWidth = 869
      inherited lblDoubleClick: TLabel
        Left = 574
        StyleElements = [seFont, seClient, seBorder]
        ExplicitLeft = 574
      end
      inherited lblDelete: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
    end
    inherited pnlSearch: TPanel
      Width = 869
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 869
      inherited lblText: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited edtSearch: TEdit
        Width = 578
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 578
      end
      inherited btnInsert: TPanel
        Left = 720
        StyleElements = [seFont, seClient, seBorder]
        ExplicitLeft = 720
      end
      inherited btnReports: TPanel
        Left = 603
        StyleElements = [seFont, seClient, seBorder]
        ExplicitLeft = 603
      end
    end
    inherited pnl_dbgrid: TPanel
      Width = 869
      Height = 457
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 869
      ExplicitHeight = 457
      inherited gridRegister: TDBGrid
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
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade_em_estoque'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade_minima'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'preco_custo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'preco_venda'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'lote'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_entrada'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_validade'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'fornecedor'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'localizacao'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'status'
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
        Width = 829
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 829
        inherited lblResult: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
      end
    end
  end
  inherited ds_consulta: TDataSource
    DataSet = form_conexao_tabelas.qryConsultaEstoque
    Left = 392
  end
  inherited FormLinker: TFormLinker
    ObjectClassName = 'TEstoque'
    RegisterFormName = 'Tform_cadastro_estoque'
  end
end
