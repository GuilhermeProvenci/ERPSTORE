unit unit_report;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_conexao_tabelas, ppProd, ppClass,
  ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, Vcl.ExtCtrls, ppCtrls, ppPrnabl,
  ppBands, ppCache, ppDesignLayer, ppParameter, unit_funcoes, Data.DB,
  Vcl.StdCtrls, Vcl.DBGrids{, frxClass, frxSmartMemo, frCoreClasses};


type
  Tfrm_report = class(TForm)
    Panel2: TPanel;
    PipelineClientes: TppDBPipeline;
    Clientes: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppTitleBand1: TppTitleBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppLabel4: TppLabel;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppLabel5: TppLabel;
    PipelineProdutos: TppDBPipeline;
    Produtos: TppReport;
    ppTitleBand2: TppTitleBand;
    ppLabel6: TppLabel;
    ppHeaderBand2: TppHeaderBand;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppFooterBand2: TppFooterBand;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppParameterList2: TppParameterList;
    ppLabel10: TppLabel;
    ppDBText8: TppDBText;
    ppShape1: TppShape;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppShape2: TppShape;
    ppShape3: TppShape;
    ppShape4: TppShape;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppLine9: TppLine;
    ppLine10: TppLine;
    ppLine11: TppLine;
    ppLine12: TppLine;
    PipelineEstoque: TppDBPipeline;
    Estoque: TppReport;
    ppTitleBand3: TppTitleBand;
    ppLabel11: TppLabel;
    ppHeaderBand3: TppHeaderBand;
    ppShape5: TppShape;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLine13: TppLine;
    ppLine14: TppLine;
    ppLine15: TppLine;
    ppDetailBand3: TppDetailBand;
    ppShape6: TppShape;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppLine16: TppLine;
    ppLine17: TppLine;
    ppLine18: TppLine;
    ppFooterBand3: TppFooterBand;
    ppDesignLayers3: TppDesignLayers;
    ppDesignLayer3: TppDesignLayer;
    ppParameterList3: TppParameterList;
    Button1: TButton;
    //frxReportConsulta: TfrxReport;

    procedure Panel2MouseEnter(Sender: TObject);
    procedure Panel2MouseLeave(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FNomeReport: string;
    FTable: string;

  public
    Grid : TDBGrid;
    //procedure ShowFastReportGrid(AGrid: TDBGrid);
    { Public declarations }
    property NomeReport: string read FNomeReport write FNomeReport;
    property Table: string read FTable write FTable;
  end;

var
  frm_report: Tfrm_report;

implementation

{$R *.dfm}


procedure Tfrm_report.Button1Click(Sender: TObject);
begin
//ShowFastReportGrid(Grid);
end;

procedure Tfrm_report.Panel2Click(Sender: TObject); //botao temporário, a impressao vai ser feita direto pelo consulta padrao
var
  Relatorio, report: TppReport;
  DataSource: TDataSource;
  pipeline : TppDBPipeline;

begin
  Relatorio := TppReport(FindComponent(NomeReport));

  if Assigned(Relatorio) then
    Relatorio.Print
  else
    CriarMensagem('aviso', 'Consulta não possui Relatório');

  //TESTE DINAMICO//
//  DataSource := form_conexao_tabelas.GetDataSourceByTableName(Table);
//  pipeline := TppDBPipeline(FindComponent('Pipeline'+Table));
//  pipeline.DataSource := DataSource;
//
//  report:= TppReport.Create(self);
//  report.DataPipeline := pipeline;
//
//  if Assigned(report) then
//    report.Print
//  else
//    CriarMensagem('aviso', 'Consulta não possui Relatório');
//
//  FreeAndNil(DataSource);
//  FreeAndNil(report);
//  FreeAndNil(pipeline);


end;


procedure Tfrm_report.Panel2MouseEnter(Sender: TObject);
begin
      Panel2.Color := clNavy;
      Panel2.Font.Style := [fsBold];
      Panel2.Font.Size := 11;

end;

procedure Tfrm_report.Panel2MouseLeave(Sender: TObject);
begin
      Panel2.Color := $00C08000;
      Panel2.Font.Style := [];
      Panel2.Font.Size := 10;
end;


//procedure Tfrm_report.ShowFastReportGrid(AGrid: TDBGrid);
//var
//  lPageHeader: TfrxReportPage;
//  lDataBand: TfrxMasterData;
//  lLine: TfrxLineView;
//  i, lLeft, lTop: Integer;
//  lHeightHeader: Extended;
//  lMemo: TfrxMemoView;
//begin
//  // Ajustar
//  frxReportConsulta.LoadFromFile('D:\ERPSTORE\FONTES\Reports\fr3\dinamic.fr3');
//  lPageHeader := TfrxReportPage(frxReportConsulta.FindObject('PageHeader1')) as TfrxReportPage;
//  lDataBand := TfrxMasterData(frxReportConsulta.FindObject('MasterData1')) as TfrxMasterData;
//
//  if Assigned(lPageHeader) and Assigned(lDataBand) then
//  begin
//    lPageHeader.Clear;
//    lDataBand.Clear;
//  end
//  else
//  exit;
//
//  // Cria Linha na parte superior do sumário
//  lHeightHeader := 19.90;
//
//  lDataBand.Height := lHeightHeader;
//  lPageHeader.Height := lHeightHeader;
//
//  lLeft := 0;
//  lTop := 0;
//
//  for i := 0 to AGrid.Columns.Count - 1 do
//  begin
//    if not AGrid.Columns[i].Visible then
//      Continue;
//
//    // Ajusta Altura das Bandas de acordo com a quantidade de campos.
//    if (i > 0) and ((lLeft + AGrid.Columns[i].Width) > 1046.93) then
//    begin
//      lHeightHeader := lHeightHeader + 19.90;
//
//      if lPageHeader.Height <> lHeightHeader then
//      begin
//        lPageHeader.Height := lHeightHeader;
//        lDataBand.Height := lHeightHeader;
//      end;
//
//      lLeft := 0;
//      lTop := lTop + 18;
//    end;
//
//    // Cria Memo para cada coluna no MasterData
//    lMemo := TfrxMemoView.Create(lDataBand);
//    lMemo.Parent := lDataBand;
//    lMemo.HAlign := haLeft;
//    lMemo.CreateUniqueName;
//    lMemo.Font.Size := 8;
//    lMemo.Font.Name := 'Tahoma';
//    lMemo.Text := AGrid.Columns[i].FieldName;  // Exibe o nome do campo no Memo
//    lMemo.SetBounds(lLeft, lTop, {AGrid.Columns[i].Width}20 , 16);
//   // lMemo.Align := baWidth; // Para ajustar automaticamente a largura
//
//
//    lLeft := lLeft + 20 {AGrid.Columns[i].Width};
//
//
//  end;
//
//  // Cria Linha na parte inferior do cabeçalho
//  lLine := TfrxLineView.Create(lPageHeader);
//  lLine.Align := baBottom;
//  lLine.Align := baWidth;
//  lLine.CreateUniqueName;
//  lLine.Top := lPageHeader.Height;
//
//  frxReportConsulta.ShowReport;
//end;





end.
