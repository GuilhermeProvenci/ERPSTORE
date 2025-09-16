inherited form_consulta_produtos: Tform_consulta_produtos
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 13
  inherited pnlMain: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited pnlTop: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited lblTitle: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited pnlSeparator: TPanel
        StyleElements = [seFont, seClient, seBorder]
      end
    end
    inherited pnlBottom: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited lblDoubleClick: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited lblDelete: TLabel
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
      inherited pnlResult: TPanel
        StyleElements = [seFont, seClient, seBorder]
        inherited lblResult: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
      end
    end
  end
  inherited ds_consulta: TDataSource
    DataSet = form_conexao_tabelas.qryConsultaProdutos
  end
  inherited FormLinker: TFormLinker
    ObjectClassName = 'TProduto'
    RegisterFormName = 'Tform_cadastro_produtos'
  end
end
