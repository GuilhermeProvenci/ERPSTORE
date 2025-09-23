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
    ExplicitWidth = 962
    ExplicitHeight = 637
    inherited pnlTop: TPanel
      Width = 962
      StyleElements = [seFont, seClient, seBorder]
      inherited btnClose: TSpeedButton
        Left = 889
      end
      inherited lblTitle: TLabel
        Height = 56
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited pnlSeparator: TPanel
        Width = 962
        StyleElements = [seFont, seClient, seBorder]
      end
    end
    inherited pnlBottom: TPanel
      Top = 599
      Width = 962
      StyleElements = [seFont, seClient, seBorder]
      inherited lblDoubleClick: TLabel
        Left = 667
        Height = 38
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited lblDelete: TLabel
        Height = 38
        StyleElements = [seFont, seClient, seBorder]
      end
    end
    inherited pnlSearch: TPanel
      Width = 962
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
      Width = 962
      Height = 470
      StyleElements = [seFont, seClient, seBorder]
      inherited gridRegister: TDBGrid
        Width = 922
        Height = 419
      end
      inherited pnlResult: TPanel
        Width = 922
        StyleElements = [seFont, seClient, seBorder]
        inherited lblResult: TLabel
          Height = 41
          StyleElements = [seFont, seClient, seBorder]
        end
      end
    end
  end
  inherited ds_consulta: TDataSource
    DataSet = form_conexao_tabelas.qryConsultaCondicionalPendente
  end
end
