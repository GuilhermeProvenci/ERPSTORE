unit unit_report;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_conexao_tabelas, ppProd, ppClass,
  ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, Vcl.ExtCtrls, ppCtrls, ppPrnabl,
  ppBands, ppCache, ppDesignLayer, ppParameter, unit_funcoes, Data.DB;


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

    procedure Panel2MouseEnter(Sender: TObject);
    procedure Panel2MouseLeave(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
  private
    { Private declarations }
    FNomeReport: string;
    FTable: string;

  public
    { Public declarations }
    property NomeReport: string read FNomeReport write FNomeReport;
    property Table: string read FTable write FTable;
  end;

var
  frm_report: Tfrm_report;

implementation

{$R *.dfm}


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


end.
