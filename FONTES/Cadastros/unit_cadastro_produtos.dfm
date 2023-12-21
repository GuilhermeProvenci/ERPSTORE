inherited form_cadastro_produtos: Tform_cadastro_produtos
  Caption = 'form_cadastro_produtos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_fundo: TPanel
    inherited lbl_informacao: TLabel
      Width = 143
      Caption = 'Informa'#231#227'o do Produto'
      ExplicitWidth = 143
    end
    inherited lbl_informacao2: TLabel
      Width = 36
      Caption = 'Nome'
      ExplicitWidth = 36
    end
    inherited lbl_informacao3: TLabel
      Width = 53
      Caption = 'Tamanho'
      ExplicitWidth = 53
    end
    inherited lbl_informacao4: TLabel
      Width = 33
      Caption = 'Pre'#231'o'
      ExplicitWidth = 33
    end
    inherited pnl_topo: TPanel
      inherited lbl_titulo: TLabel
        Width = 159
        Caption = 'Cadastro de Produtos'
        ExplicitWidth = 159
      end
    end
    inherited edt_id: TEdit
      StyleName = 'id'
    end
    inherited edt_nome: TEdit
      StyleName = 'nome'
    end
    inherited edt_3: TEdit
      StyleName = 'tamanho'
    end
    inherited edt_4: TEdit
      StyleName = 'preco'
    end
  end
  object qryProd: TFDQuery
    Active = True
    Connection = form_conexao.FDConnection
    SQL.Strings = (
      'select max(id) from produtos')
    Left = 544
    Top = 8
  end
end
