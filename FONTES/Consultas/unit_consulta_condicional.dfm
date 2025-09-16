inherited form_consulta_condicional: Tform_consulta_condicional
  Caption = 'form_consulta_condicional'
  ClientHeight = 637
  ClientWidth = 962
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 962
  ExplicitHeight = 637
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 962
    Height = 637
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
      inherited pnlResult: TPanel
        StyleElements = [seFont, seClient, seBorder]
        inherited lblResult: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
      end
    end
  end
  inherited ds_consulta: TDataSource
    DataSet = form_conexao_tabelas.qryConsultaCondicionalPendente
  end
end
