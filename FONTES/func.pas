unit Func;

interface

Uses

  Windows, Messages, SysUtils, Classes, Variants, Graphics, Controls, StrUtils, DBClient, ExtCtrls, ComCtrls, Consts,
  Dialogs, DB, StdCtrls, IniFiles, Registry, ADODb, IdStackWindows, Forms, sgClientDataSet, sgProgBar, sgLbl, sgBtn,
  sgTypes, RchLbl, MemLbl
  {$IFDEF ERPUNI}
    , uniGUIDialogs, uniImageList, uniGUIClasses
  {$ELSE}
    , System.Win.ScktComp, cxGraphics, cxGridTableView, AdvMenuStylers, cxStyles
  {$ENDIF}
  ;

const EspaCamp = 20;
      EspaTabe = 20;
      PTecEnte = #13;
      PTecResu = #27;
      PTecReto = #0;

      //Anti-Pirataria
      PNumAces = 99;
      PParFina = False;
      PParBase = '';

      Cor_Vermelho_Fraco = 10329599;
      Cor_Amarelo_Fraco=  13434879;// - 13826810
      Cor_Azul_Fraco=     14599344;
      Cor_Azul_Ceu=       15453831;
      Cor_Azul=           16748574;
      Cor_Laranja_Fraco=   7452927;
      Cor_Verde_Fraco=     9419900;   //8978312;
      Cor_Verde=          11193702;
      Cor_Vermelho=       10329599;
      Cor_Coluna_Editavel= 9221330;

type
  TConfRela = class
    private
      fTituRela: String;
      fCondLote: String;
      fCondAloj: String;
      fDiar    : Boolean;
      fAgruRela: TAgruRela;
      fCabeResu: Boolean;  //Cabeçalho Resumido
    protected
    public
      constructor Create(AControl: TObject); virtual;
      destructor Destroy; override;
      property TituRela: String  read fTituRela write fTituRela;
      property CondLote: String  read fCondLote write fCondLote;
      property CondAloj: String  read fCondAloj write fCondAloj;
      property Diar    : Boolean read fDiar     write fDiar;
      property AgruRela: TAgruRela  read fAgruRela write fAgruRela;
      property CabeResu: Boolean read fCabeResu write fCabeResu;
  end;

  //*********************************************************************************
  // CONFIGURAÇÃO WEB
  TConfWeb_Modo = (cwModoMobile, cwModoBrowser, cwDesktop);
  TConfWeb_TipoApli = (apGera, apRela, apCall, apGold, apPrat, apInto, apCW);

  TPOChBusc_Padr = class
  private
    FAltu: Integer;
    FTama: Integer;
    FTopo: Integer;
    FEsqu: Integer;
  public
    property Altu: Integer read FAltu write FAltu;
    property Tama: Integer read FTama write FTama;
    property Topo: Integer read FTopo write FTopo;
    property Esqu: Integer read FEsqu write FEsqu;
  end;

  TConfWeb = class
    private
      fModo: TConfWeb_Modo;
      fTipoApli: TConfWeb_TipoApli;
      fPSisFilt: String;
      fTabeFilt: String;
      fServer, fDatabase, fUsuario, fDriverID, fCharacterSet: String;
      fSistPrat: String;
      fAtuaBD_Conn: TsgADOConnection;
      fSenha: String;
      fUsuaMaster: String;
      fSenhMaster: String;

      FPCodPess: String;
      FPDa1Manu: TDateTime;
      FPDa2Manu: TDateTime;
      FEmpresas: String;
      FCodiEmpresas: String;
      FcgcMatriz: String;
      FCalcMax_ColeLote_SQL_: String;
      FCalcMax_ColeLote_Data: TDateTime;
      FPOChBuscPosi: TPOChBusc_Padr;
      FPLblAjud: TsgLbl;
      FPPrgPrin, FPPrgPri1: TsgProgBar;
      FPDataServ: TDateTime;
      FPDa1: TDateTime;
      FPDa2: TDateTime;
      FPApePess: String;
      FPNomUsua: String;
      FPNomEmpr: String;
      FPNomSist: String;
      FPCodEmpr: String;
      FPIsSAG_SenhAdm: String;
      FPIsSAG_SenhMast: String;
      FPAux: String;
      FPPerIdad: Real;
      FPBasTest: Boolean;
      FPBasTC: Boolean;
      FPClientCria: TsgClientDataSet;
      FAtuaVers: TTipoAtuaVers;
      FConfRela: TConfRela;
      FADOConn: TsgADOConnection;
      FsgTrans: TsgTransaction;
      FListImag: {$ifdef ERPUNI} TuniImageList {$else} TcxImageList {$endif};

      FCodiPrat: Integer;
      FCodiPess: Integer;
      FCodiProd: Integer;
      FCodiEmpr: Integer;
      FCodiGrUs: Integer;
      FCodiTabe: Integer;
      FCodiMoni: Integer;
      FCodiIdio: Integer;
      FCodiPais: Integer;

      FPBas: Integer;
      FPMelAjus: Boolean;
      FPLogTipo: Integer;
      FPZoo: Integer;
      FPIsNaSAG: Integer;
      FPGruGrid: Integer;
      FPRowGrid: Integer;
      FPUppeCase: Boolean;
      FIsPratic: Boolean;
      FPIsSAG_Dese: Integer;
      FPIsSAG_Cons: Integer;
      FPIsSAG_Supo: Integer;
      FPIsSAG_Adm : Integer;
      FPIsSAG_Come: Integer;
      FPIsSAG_Secr: Integer;
      FPIsSAG_Senh: Integer;
      FPIsSAG: Integer;
      FParent: TComponent;
      FPAltReso, FPTamReso: Integer;
      FPDtsEdit: TDataSource;
      FPWheRela: String;
      FPId1: Real;
      FPId2: Real;
      FMemValo: TStringList;
      FMemVal1: TStringList;
      FMemRela: TStringList;
      //FRchValo: TRchLbl;
      //FLstCamp: TLstLbl;
      FPCodTest: Integer;
      FPNomTest: String ;

      FPublStri: array[1..05] of String;
      FPublInte: array[1..05] of Int64;
      FPublData: array[1..05] of TDateTime;
      FPublReal: array[1..05] of Extended;
      FPublValo: array[1..05] of String;

      FTokenBI: String;
      {$IFNDEF ERPUNI}
        FPEstAdv_: TAdvMenuOfficeStyler;
        FPEstGrid: TcxCustomStyleSheet;
      {$ELSE}
      {$ENDIF}
      FCodiEmpr_WS_Padr: Integer;
      FGrupConf, FUserConf: String;

      function GetSenha: String;
      function GetPSisFilt: String;
      function GetConfConf: String;
      procedure SetCodiPrat(const Value: Integer);
      function GetSQLTabelas(): String;
      function GetSite(): String;
      function GetAtuaBD_Senh: String;
      function GetAtuaBD_Usua: String;
      function GetAtuaBD_Conn: TsgADOConnection;

      function GetCodiPess: Integer;
      procedure SetCodiPess(const Value: Integer);
      function GetPCodPess: String;
      procedure SetPCodPess(const Value: String);
      function GetPApePess: String;
      procedure SetParent(const Value: TComponent);
      function GetPublData(Index: Integer): TDateTime;
      function GetPublInte(Index: Integer): Int64;
      function GetPublReal(Index: Integer): Extended;
      function GetPublStri(Index: Integer): String;
      function GetPublValo(Index: Integer): String;
      procedure SetPublData(Index: Integer; const Value: TDateTime);
      procedure SetPublInte(Index: Integer; const Value: Int64);
      procedure SetPublReal(Index: Integer; const Value: Extended);
      procedure SetPublStri(Index: Integer; const Value: String);
      procedure SetPublValo(Index: Integer; const Value: String);
      function GetTokenBI: String;
      procedure SetCodiEmpr(const Value: Integer);
      function GetVersao_Delp: String;
      procedure SetVersao_Delp(const Value: String);
      function GetPDataServ: TDateTime;
      function GetPDa1: TDateTime;
      function GetPDa1Manu: TDateTime;
      function GetPDa2: TDateTime;
      function GetPDa2Manu: TDateTime;
    public
      constructor Create();
      constructor sgCreate(Owner: TComponent); virtual;
      destructor Destroy(); override;

      property Parent: TComponent read FParent write SetParent;

      property Modo: TConfWeb_Modo read fModo write fModo;
      property TipoAplicacao: TConfWeb_TipoApli read fTipoApli write fTipoApli;
      property PSisFiltro: String read GetPSisFilt write fPSisFilt;
      property TabeFiltro: String read fTabeFilt write fTabeFilt;

      property Server: String       read fServer   write fServer;
      property Database: String     read fDatabase write fDatabase;
      property Usuario: String      read fUsuario  write fUsuario;
      property Senha: String        read GetSenha  write fSenha;
      property DriverID: String     read fDriverID write fDriverID;
      property CharacterSet: String read fCharacterSet write fCharacterSet;
      property ConfConf: String     read GetConfConf;
      property GrupConf: String     read FGrupConf write FGrupConf;
      property UserConf: String     read FUserConf write FUserConf;
      property SistPrat: String     read fSistPrat write fSistPrat;
      property CodiPrat: Integer    read FCodiPrat write SetCodiPrat;
      property SenhMaster: String   read fSenhMaster write fSenhMaster;
      property UsuaMaster: String   read fUsuaMaster write fUsuaMaster;

      property CodiPess: Integer    read GetCodiPess write SetCodiPess;
      property PCodPess: String     read GetPCodPess write SetPCodPess;
      property PDa1Manu: TDateTime  read GetPDa1Manu write FPDa1Manu;
      property PDa2Manu: TDateTime  read GetPDa2Manu write FPDa2Manu;
      property PDataServ: TDateTime read GetPDataServ write FPDataServ;
      property PDa1: TDateTime      read GetPDa1 write FPDa1;
      property PDa2: TDateTime      read GetPDa2 write FPDa2;
      property Empresas: String     read FEmpresas write FEmpresas;
      property CodiEmpresas: String read FCodiEmpresas write FCodiEmpresas;
      property cgcMatriz: String    read FcgcMatriz write FcgcMatriz;
      property CalcMax_ColeLote_SQL_: String read FCalcMax_ColeLote_SQL_ write FCalcMax_ColeLote_SQL_;
      property CalcMax_ColeLote_Data: TDateTime read FCalcMax_ColeLote_Data write FCalcMax_ColeLote_Data;
      property POChBuscPosi: TPOChBusc_Padr read FPOChBuscPosi write FPOChBuscPosi;
      property PLblAjud: TsgLbl     read FPLblAjud write FPLblAjud;
      property PPrgPrin: TsgProgBar read FPPrgPrin write FPPrgPrin;
      property PPrgPri1: TsgProgBar read FPPrgPri1 write FPPrgPri1;
      property PApePess: String     read GetPApePess write FPApePess;
      property PNomUsua: String     read FPNomUsua write FPNomUsua;
      property PNomEmpr: String     read FPNomEmpr write FPNomEmpr;
      property PNomSist: String     read FPNomSist write FPNomSist;
      property PCodEmpr: String     read FPCodEmpr write FPCodEmpr;
      property CodiEmpr_WS_Padr: Integer read FCodiEmpr_WS_Padr write FCodiEmpr_WS_Padr;  //Empresa padrão do WS (Definida no Conf.sag)
      property PIsSAG_SenhAdm: String read FPIsSAG_SenhAdm write FPIsSAG_SenhAdm;
      property PIsSAG_SenhMast: String read FPIsSAG_SenhMast write FPIsSAG_SenhMast;
      property PAux: String read FPAux write FPAux;  //Função publica auxiliar, para transferencia de uma valor de um lado a outro
      property PPerIdad: Real read FPPerIdad write FPPerIdad; //Período da Idade (usado em vários locais)
      property PBasTest: Boolean read FPBasTest write FPBasTest;
      property PBasTC: Boolean read FPBasTC write FPBasTC;
      property PClientCria: TsgClientDataSet read FPClientCria write FPClientCria;
      property AtuaVers: TTipoAtuaVers read FAtuaVers write FAtuaVers;
      property ConfRela: TConfRela read FConfRela write FConfRela;
      property ADOConn: TsgADOConnection read FADOConn write FADOConn;
      property sgTrans: TsgTransaction read FsgTrans write FsgTrans;
      property ListImag: {$ifdef ERPUNI} TuniImageList {$else} TcxImageList {$endif} read FListImag write FListImag;
      property CodiEmpr: Integer read FCodiEmpr write SetCodiEmpr;
      property PBas: Integer read FPBas write FPBas;
      property CodiGrUs: Integer read FCodiGrUs write FCodiGrUs;
      property PCodiTabe: Integer read FCodiTabe write FCodiTabe;
      property PMelAjus: Boolean read FPMelAjus write FPMelAjus;
      property PLogTipo: Integer read FPLogTipo write FPLogTipo;
      property PZoo: Integer read FPZoo write FPZoo;
      property PIsNaSAG: Integer read FPIsNaSAG write FPIsNaSAG;
      property CodiMoni: Integer read FCodiMoni write FCodiMoni;
      property CodiIdio: Integer read FCodiIdio write FCodiIdio;
      property CodiPais: Integer read FCodiPais write FCodiPais;
      property PGruGrid: Integer read FPGruGrid write FPGruGrid;
      property PRowGrid: Integer read FPRowGrid write FPRowGrid;
      property CodiProd: Integer read FCodiProd write FCodiProd;
      property PUppeCase: Boolean read FPUppeCase write FPUppeCase;
      property IsPratic: Boolean read FIsPratic write FIsPratic;
      property PIsSAG_Dese: Integer read FPIsSAG_Dese write FPIsSAG_Dese;
      property PIsSAG_Cons: Integer read FPIsSAG_Cons write FPIsSAG_Cons;
      property PIsSAG_Supo: Integer read FPIsSAG_Supo write FPIsSAG_Supo;
      property PIsSAG_Adm: Integer read FPIsSAG_Adm write FPIsSAG_Adm;
      property PIsSAG_Come: Integer read FPIsSAG_Come write FPIsSAG_Come;
      property PIsSAG_Secr: Integer read FPIsSAG_Secr write FPIsSAG_Secr;
      property PIsSAG_Senh: Integer read FPIsSAG_Senh write FPIsSAG_Senh;
      property PIsSAG: Integer read FPIsSAG write FPIsSAG;

      property PAltReso: Integer read FPAltReso write FPAltReso;
      property PTamReso: Integer read FPTamReso write FPTamReso;
      property PDtsEdit: TDataSource read FPDtsEdit write FPDtsEdit;
      property PWheRela: String read FPWheRela write FPWheRela;
      property PId1: Real read FPId1 write FPId1;
      property PId2: Real read FPId2 write FPId2;
      property MemValo: TStringList read FMemValo write FMemValo;
      property MemVal1: TStringList read FMemVal1 write FMemVal1;
      property MemRela: TStringList read FMemRela write FMemRela;
      //property RchValo: TRchLbl read FRchValo write FRchValo;
      //property LstCamp: TLstLbl read FLstCamp write FLstCamp;
      {$IFNDEF ERPUNI}
        property PEstAdv_: TAdvMenuOfficeStyler read FPEstAdv_ write FPEstAdv_;
        property PEstGrid: TcxCustomStyleSheet read FPEstGrid write FPEstGrid;
      {$ELSE}
      {$ENDIF}
      property PCodTest: Integer read FPCodTest write FPCodTest;
      property PNomTest: String read FPNomTest write FPNomTest;
      property PublStri[Index: Integer]: String    read GetPublStri write SetPublStri;
      property PublInte[Index: Integer]: Int64     read GetPublInte write SetPublInte;
      property PublData[Index: Integer]: TDateTime read GetPublData write SetPublData;
      property PublReal[Index: Integer]: Extended  read GetPublReal write SetPublReal;
      property PublValo[Index: Integer]: String    read GetPublValo write SetPublValo;

      property AtuaBD_Conn: TsgADOConnection read GetAtuaBD_Conn write fAtuaBD_Conn;
      property AtuaBD_Usua: String read GetAtuaBD_Usua;
      property AtuaBD_Senh: String read GetAtuaBD_Senh;

      property SQLTabelas: String read GetSQLTabelas;
      property Site: String       read GetSite;

      property TokenBI: String read GetTokenBI write FTokenBI;

      procedure SetTipoAplicacao(iTipo: String);
      procedure SetModo(iModo: String);
      function SetCampPers_ConfWeb(Camp, Linh: String): Boolean;

      procedure Assign(iValo: TConfWeb);

      property Versao_Delp: String read GetVersao_Delp write SetVersao_Delp;
  end;

  var
    _Web_ConfWeb : TConfWeb;

  procedure ConfWeb_Publico(iValo: TConfWeb);
  function GetConfWeb: TConfWeb;
  Procedure SetConfWeb(iValo: TConfWeb);

  // CONFIGURAÇÃO DAS TABELAS
  //*********************************************************************************
type
  TCustomConfTabe = class(TPersistent)
  private
    FCodiGrav: Integer;
    FGravTabe: String;
    FNomeTabe: String;
    FNomeSgCh: String;
    FValoSgCh: String;
    FNomeCodi: String;
    FCodiTabe: Integer;
    FFormTabe: String;
    FCaptTabe: String;
    FChavTabe: Integer;
    FHintTabe: String;
    FOperacao: TDec_Operacao;
    FClicConf: Boolean;
    FClicCanc: Boolean;
    FFechaConfirma: Boolean;
    FSituGrav: Boolean;
    FConfMovi: TCustomConfTabe;
    FVersTabe: Integer;
    FNomeSgTb: String;
    FNomeSgBu: String;
    FCodiCons: Integer;
    FCodiRela: Integer;
    FClicTabe: String;
    FSGTBGrav: Integer;
    procedure SetGravTabe(const Value: String);
    function GetGravTabe: String;
    function GetNomeTabe: String;
    function GetCaptTabe: String;
    function GetNomeCodi: String;
    function GetNomeSgCh: String;
    procedure SetSituGrav(const Value: Boolean);
    function GetConfMovi: TCustomConfTabe;
    function GetFinaTabe: String;
    function GetNomePDat: String;
    function GetVersTabe: Integer;
    function GetNomePEmp: String;
    function GetNomePSis: String;
    function GetNomePUsu: String;
    function GetNomeSgBu: String;
    function GetNomeSgTb: String;
    procedure SetCodiTabe(const Value: Integer);
  public
    constructor Create(); virtual;
    destructor Destroy(); override;
    function GetValoSgCh: String; virtual;
    function GetFormTabe: String; virtual;

    property CodiTabe: Integer read FCodiTabe write SetCodiTabe;
    property CodiRela: Integer read FCodiRela write FCodiRela;
    property CodiCons: Integer read FCodiCons write FCodiCons;
    property CodiGrav: Integer read FCodiGrav write FCodiGrav;
    property GravTabe: String  read GetGravTabe write SetGravTabe;
    property FinaTabe: String  read GetFinaTabe;
    property NomePDat: String  read GetNomePDat;
    property NomePUsu: String  read GetNomePUsu;
    property NomePSis: String  read GetNomePSis;
    property NomePEmp: String  read GetNomePEmp;
    property NomeCodi: String  read GetNomeCodi write FNomeCodi;
    property NomeSgCh: String  read GetNomeSgCh write FNomeSgCh;
    property NomeSgBu: String  read GetNomeSgBu write FNomeSgBu;
    property NomeSgTb: String  read GetNomeSgTb write FNomeSgTb;
    property ValoSgCh: String  read GetValoSgCh write FValoSgCh;
    property FormTabe: String  read GetFormTabe write FFormTabe;
    property NomeTabe: String  read GetNomeTabe write FNomeTabe;
    property CaptTabe: String  read GetCaptTabe write FCaptTabe;
    property ChavTabe: Integer read FChavTabe write FChavTabe;   //Número de Campos Chave
    property HintTabe: String  read FHintTabe write FHintTabe;
    property VersTabe: Integer read GetVersTabe write FVersTabe;
    property Operacao: TDec_Operacao read FOperacao write FOperacao;  //Substituto para o PSitGrav
    property ClicTabe: String read FClicTabe write FClicTabe;

    property SituGrav: Boolean read FSituGrav write SetSituGrav default false;  //True: Inclusão e False: Alteração (alimenta a Operacao)
    property ClicConf: Boolean read FClicConf write FClicConf default false;
    property ClicCanc: Boolean read FClicCanc write FClicCanc default false;
    property FechaConfirma : Boolean read FFechaConfirma write FFechaConfirma default false;  //Fecha no Inclui

    property SGTBGrav: Integer read FSGTBGrav write FSGTBGrav;  //Código da tela que está gravando o registro

    property ConfMovi: TCustomConfTabe read GetConfMovi write FConfMovi;
    procedure Assign(iConf: TPersistent); override;
    procedure Limpa;
  end;

  // CONFIGURAÇÃO DAS SENHAS
  //*********************************************************************************
type
  TCustomsgSenh = class(TPersistent)
  private
    FEmprSenh: String;
    FVersSenh: String;
    FDataSenh: String;
    FDigiSenh: String;
    FOpcaSenh: String;
    FSistSenh: String;
    FNumeCont: String;
    FTipoCont: String;
    FDigiCont: String;
    FDataCont: String;
    FNum1Cont: String;
    FEmprCont: String;
    FSenhCont: String;
    FSistCont: String;
    fContra: String;
    fSenha: String;
    FPrazCont: TDateTime;
    FDiasSenh: Integer;
    fEnceModu: TDateTime;
    fMax1Cont: Integer;
    fMaxiCont: Integer;
    FCodiPess: Integer;
    procedure SetContra(const Value: String);
    procedure SetSenha(const Value: String);
    function GetEmprCont: String;
    function GetDataCont: String;
    function GetSistCont: String;
    function GetDigiCont: String;
    function GetNum1Cont: String;
    function GetNumeCont: String;
    function GetSenhCont: String;
    function GetTipoCont: String;
    function GetDataSenh: String;
    function GetDigiSenh: String;
    function GetEmprSenh: String;
    function GetOpcaSenh: String;
    function GetSistSenh: String;
    function GetVersSenh: String;

    function CalcDigiSenh: String;
    function CalcDigiCont: String;
    function CalcDigiPers: Integer;
    function Mistura(iValo: String): String;
    function DesMistura(iValo: String): String;
    procedure Mensagem(iMsg: String; iExib: Boolean);
    procedure SetPrazCont(const Value: TDateTime);
    function GetVersSenhForm: String;
    function FormataSenha(iSenh: String): String;
  public
    constructor Create(); virtual;
    destructor Destroy(); override;

    property EmprSenh: String read GetEmprSenh write FEmprSenh;
    property DataSenh: String read GetDataSenh write FDataSenh;
    property SistSenh: String read GetSistSenh write FSistSenh;
    property VersSenh: String read GetVersSenh write FVersSenh;
    property OpcaSenh: String read GetOpcaSenh write FOpcaSenh;
    property DigiSenh: String read GetDigiSenh write FDigiSenh;

    property VersSenhForm: String read GetVersSenhForm;

    property EmprCont: String read GetEmprCont write FEmprCont;
    property DataCont: String read GetDataCont write FDataCont;
    property SistCont: String read GetSistCont write FSistCont;
    property NumeCont: String read GetNumeCont write FNumeCont;
    property Num1Cont: String read GetNum1Cont write FNum1Cont;
    property TipoCont: String read GetTipoCont write FTipoCont;
    property SenhCont: String read GetSenhCont write FSenhCont;
    property DigiCont: String read GetDigiCont write FDigiCont;
    property PrazCont: TDateTime read FPrazCont write SetPrazCont;
    property DiasCont: Integer read FDiasSenh write FDiasSenh;
    property EnceModu: TDateTime read fEnceModu write fEnceModu;
    property MaxiCont: Integer read fMaxiCont write fMaxiCont;
    property Max1Cont: Integer read fMax1Cont write fMax1Cont;

    property CodiPess: Integer read FCodiPess write FCodiPess;

    property Senha : String read fSenha  write SetSenha;
    property Contra: String read fContra write SetContra;

    function GeraSenha(iMens: Boolean = True): String;
    function GeraContra(iMens: Boolean = True): String; virtual;
    function ValiCont(iMens: Boolean = True; iGeral: Boolean = False): Boolean; virtual;
    function ValiSenh(iMens: Boolean = True): Boolean;
    function MotivoSenha: String;
    function TipoLicenca: String;
  end;


  //*********************************************************************************
  function Operacao_StrMsg(iOper: TDec_Operacao): String;

  function TestaConexao(DataSet: TDataSet): Boolean;
  function FormataSql(Sql: String; Filtrar: Boolean = True): String;
  function ConfiguraConexao(TIPO, BANCO, CONFIG, USUARIO, SENHA: String;Conexao: TSGADOConnection): Boolean;

  function IsAdmiSAG(Usua: String = ''): Boolean;
  function IsAdmiClie(Usua: String = ''): Boolean;
  function IsVeriAces(): Boolean;
  function IsRx9(Sist: Integer = 0): Boolean;
  function IsRx(Sist: Integer = 0): Boolean;
  function isOracle(): Boolean;

  procedure SetPNomSist(Nome: String);
  procedure SetPEmp(Empr: Integer);
  procedure SetPCodEmpr(Empr: String);
  procedure SetPBas(Base: Integer);
  procedure SetPBasTest(Valo: Boolean);
  procedure SetPBasTC(Valo: Boolean);
  procedure SetPNomEmpr(Nome: String);
  procedure SetPAux(Nome: String);
  procedure SetPUsu(Usua: Integer);
  procedure SetPCodPess(Usua: String);
  procedure SetPApePess(Apel: String);
  procedure SetPNomUsua(Nome: String);
  procedure SetPSis(Sist: Integer);
  procedure SetPGru(Grup: Integer);
  procedure SetPPerIdad(Idad: Real);
  procedure SetPAtuVers(Valo: TTipoAtuaVers);
  procedure SetPTab(Tabe: Integer);
  procedure SetPZooRela(Zoom: Integer);
  procedure SetPLogTipo(LogTipo: Integer);
  procedure SetPMelAjus(Value: Boolean);
  procedure SetPIsNaSAG();
  procedure SetPCodMoni(Codi: Integer);
  procedure SetConfRela(Valo: TConfRela);
  procedure SetPADOConn(Conn: TSGADOConnection);
  procedure SetPsgTrans(Value: TsgTransaction);
  procedure SetPGruGrid(Valo: Integer);
  procedure SetPRowGrid(Valo: Integer);
  procedure SetPLisImag(Valo: {$ifdef ERPUNI} TuniImageList {$else} TcxImageList {$endif});
  procedure SetPUppeCase(Valo: Boolean);
  procedure SetIsPratic(Value: Boolean);
  procedure SetCodiPrat(CodiPrat: Integer);
  procedure SetCodiIdio(CodiIdio: Integer);
  procedure SetPOChBuscPosi(Topo, Esqu, Altu, Tama: SmallInt);

  function GetPMelAjus(): Boolean;
  function GetPZooRela(Zoom: Integer = 0): Integer;
  function GetPLogTipo(LogTipo: Integer = 0): Integer;
  function GetPEmp(Empr: Integer = 0): Integer;
  function GetPUsu(Usua: Integer = 0): Integer;
  function GetPGru(Grup: Integer = 0): Integer;
  Function GetPSis(Sist: Integer = 0): Integer;
  Function GetPCodSist(iSist: Integer = 0): String;
  function GetPBas(): Integer;
  Function GetPNomSist(): String;
  Function GetPNomTitu(): String;
  Function GetPNomSoft(): String;
  Function GetPNomAbreSoft(): String;
  Function GetPNomSiteSoft(): String;
  Function GetPNomEmpr(): String;
  Function GetPCodEmpr(Empr: String = ''): String;
  Function GetPAux(): String;
  Function GetPNomUsua(): String;
  Function GetPNomExec(): String;
  Function GetPEndExec(): String;
  function GetPEndExec_Remessa(): String;
  Function GetPEndExecOrig(): String;
  Function GetPCodPess(Usua: String = ''): String;
  Function GetPApePess(apel: String = ''): String;
  function GetPTab(Tabe: Integer = 0): Integer;
  function GetPBasTest(): Boolean;
  function GetPBasTC(): Boolean;
  function GetPPerIdad(Idad: Real = 0): Real;
  function GetPAtuVers(): TTipoAtuaVers;
  function GetPADOConn(): TSGADOConnection;
  function GetPsgTrans(): TsgTransaction;
  function GetPGruGrid(): Integer;
  function GetPRowGrid(): Integer;
  function GetPLisImag(): {$ifdef ERPUNI} TuniImageList {$else} TcxImageList {$endif};
  function GetPUppeCase(Valo: Boolean = False): Boolean;
  function GetCodiPrat(CodiPrat: Int64 = 0): Int64;
  function GetIsPratic(): Boolean;
  function IsPratic: Boolean;
  function PDataServ(): TDateTime;
  function GetCodiIdio(CodiIdio: Int64 = 0): Int64;

  function GetCor_Nome(Cor: String): Integer;

  Procedure CriaDire(Ende: String);

  Function InvePala(Pala: String): String;
  function PalaInic(const Text: String; Count: Integer = 1): String;
  function PalaFina(const Text: String; Count: Integer = 1): String;
  function isPalaInicFinaPor(iPala, iInic, iFina: String): Boolean;
  function isPalaInicPor(iPala, iInic: String): Boolean;
  function isPalaFinaPor(iPala, iFina: String): Boolean;
  function PalaContem(iPala, iContem: String): Boolean;

  //---> Objetivo: Tirar a(s) Palavra(s) (Pala) do Texto (Text)
  Function TiraPala(Text : String; Pala : String):String;
  Function TiraPalaInic(const Text, iPala : String):String;
  Function TiraPalaFina(const Text, iPala : String):String;
  Function TiraPalaInicFina(const Text, iInic, iFina : String):String;
  Function ContPala(Text:String; Pala:String):Integer;
  Function TiraRepe(Text: String):String;
  Function SubsPala(Text: String; Pala, Subs: String): String;
  function SubsPalaUma(Text: String; Pala, Subs: String):String;
  Function SubsPalaTudo(Text: String; Pala, Subs: String): String;
  function FastReplace(const aSourceString : String; const aFindString, aReplaceString : String; CaseSensitive : Boolean = False): String;
  Function GeraPala(Nume:Integer):String;
  Function PrimMaisculo(Pala: String): String;
  Function PrimLetrPalaMaisculo(Pala: String; Cara: String = ' '): String;


  Function PegaSQL_Camp(Camp: String): String;
  function PegaSQL_NomeCamp(iSele, iNome: String): String;
  Function TiraPare(Text: String):String;
  //Passado o FROM, pega a primeira tabela do From
  Function PegaTabe(From: String): String;

  function FunGravTabe_NomeAnti(const iTabe: String): String;
  function FunGravTabe_Inic(const iTabe: String): String;
  function FunGravTabe_InicAnti(const iTabe: String): String;
  function FunGravTabe_Fina(const iTabe: String; const iTama: Integer = 4): String;
  function FunGravTabe_Tipo(const iTabe: String): String;
  function FunGravTabe_isSGGE(const iTabe: String): Boolean;
  function FunGravTabe_isGE(const iTabe: String): Boolean;
  function FunGravTabe_isBkLo(const iTabe: String): Boolean;
  function Troca_CA_GE(iTabe: String): String;

  function RetoVers(Arqu: String = ''): String;
  Function GeraSenhFort(Nume:Integer): String;
  Function PosiProxVirg(Text: String; Cara: String = ',';Apos: Integer = 1): Integer;
  Function PegaCampSele(Sele: String; Nume: Integer): String;
  Function PegaNomeCamp(Camp: String; Nume: Integer = 0; AliaCamp: Boolean = True; Completo: Boolean = False; Integral: Boolean = False): String;
  Function PegaNomeCampSele(Sele : String; Nume: Integer; AliaCamp: Boolean = True; Completo: Boolean = False; Integral: Boolean = False): String;
  Function StrInPos(Pala : String; ArrayStri: Array of String): Boolean;
  Function StrIn(Pala: String; ArrayStri: Array of String): Boolean;
  Function NumeroIn(Numero :Real; ArrayNume: Array of Real): Boolean;
  function PegaCampManuGene(Sele: String; Nume: Integer = 1): String;
  function NomeCampSQL_PrimCamp(iSQL: String): String;
  function PegaSelePuroSQL(const Sele: String; const iNovoAlias: Boolean = False): String;
  Function NomeCampSQL(Camp: String):String;
  Function NomeAliaSQL(Camp: String):String;
  function TratSQL(const TextSQL: string): string;
  function OrgaSQL(SQL: String): String;
  function SQL_RetoFrom(iSQL: String): String;

  //Verifica se existe o campo na Query
  function VeriExisCampTabe(Tabe: TDataSet; Camp: String): Boolean;
  function BuscCampTabe_Origin(Tabe: TDataSet; iOrigin: String): TField;
  //Verifica se existe o campo na Query, se existir, retorna o valor, senão, o Padr
  function VeriExisCampTabe_Valo(Tabe: TDataSet; Camp, Padr: String): String;
  //---> Objetivo: Tirar os Campos passados no FROM que sco chaves
  function TiraChavSele(Sele : String; Chav : Integer):String;
  // Pega a String passado, caso exista uma vmrgula no fim, tira e na penultima vmrgula coloca '' e''
  //(Ex.: Pega ''Sidiney, Marcelo, Paulo, '' ou ''Sidiney, Marcelo, Paulo, '' <=> Retorna ''Sidiney, Marcelo e Paulo''
  Function TrocVirg(Text: String):String;
  //Busca o primeiro valor, retornando a chave, o valor e a nova chave sem o valor
  function BuscValoChavTextPrim(var Text, Chav: String; Sepa: String = '/'): String;
  function BuscValoChavText(Text, Chav: String; Sepa: String = '/'): String;
  function BuscValoChavTextQuot(Text, Chav: String; Sepa: String = '/'): String;
  Function RetoZero(Tipo: String; iPadr: String = '0'): String;
  function RetiPareIN(Param: string): string;
  Function IsExpressaoNumerica(Valo: String): Boolean;
  Function IsDigit(Valo: String): Boolean;
  Function IsDigitReal(Valo: String): Boolean;
  Function IsDigitInteger(Valo: String): Boolean;
  Function IsLetra(Valo: String): Boolean;
  Function TemLetra(Valo: String): Boolean;
  function IsAlphaNumeric(ToCheck : String) : Boolean;
  Function DeixLetrNume(Nome: String):String;
  function ContemApenasLetrasNumerosPontos(const Str: string): Boolean;
  Function DeixaAscii(Nome: String):String;
  Function RetiMasc(Nome: String):String;
  Function RetiMascTota(Nome:String):String;
  Function RetiMascReal(Nome:String):String;
  Function RetiMascStrToFloat(Nome:String):String;
  function RemoveMasc(const text, mask: string): string;
  Function ZeroDire(Pala:String;Tama:Integer;Copi:Boolean=True):String;
  Function ZeroEsqu(Pala:String;Tama:Integer;Copi:Boolean=True):String;
  function Replicate(Text : String; Qtde : Integer):String;
  function sgPos(iBusc, iText: String): Integer;
  Function Se(Expr: Boolean; Verd, Fals: Variant): Variant;
  Function SeStri(Expr: Boolean; Verd, Fals: String): String;
  Function SeInte(Expr: Boolean; Verd, Fals: Integer): Integer;
  Function SeReal(Expr: Boolean; Verd, Fals: Real): Real;
  Function SeData(Expr: Boolean; Verd, Fals: TDateTime): TDateTime;
  Function DiveZero(Valo, Dive: Real): Real;
  Function Mod_Zero(Valo, Dive: Integer): Integer;
  Function RetoMasc(TpCa: String):String;
  procedure Delay(msecs:integer);
  procedure BeepTemp(Veze:integer);
  Function TiraAcen(Text: String):String;
  function CompTextTerminado(Busc, Term: String): Boolean;
  function INSTR(p_busca: string; p_buscado: string; p_inicio: integer; p_incidencia: integer): integer;
  function STRIPART(ITEXT : String; ICARA : String; IINIC : Integer; IFINA : Integer): String;
  Function FormPont(Nume: String):String;
  function SomaCara(Cara: String; iPeso: Boolean = False):Integer;
  function SomaCaraAscii(Cara: String; iPeso: Boolean = False):Integer;
  function sgStrToInt(Cara: String):Int64;
  function sgStrToInt64(Cara: String):Int64;
  function sgStrToFloat(Cara: String): Real;
  function sgCopy(Cara: String; Inic, Fina: Integer): String;
  function sgStrToDateTime(const S: string): TDateTime;
  function EspaCadaCara(Cara:String):String;
  function PadL(const S, Pad: string; const Len: integer): string;
  function PadR(const S, Pad: string; const Len: integer): string;
  function TimeInRange(Time, StartTime, EndTime: TDateTime; Inclusive: Boolean): Boolean;
  function NumeroInRange(Nume, Inic, Fina: Real): Boolean;

  function Year(Data: TDateTime): Integer;
  function sgYear(Data: TDateTime): Integer;
  function Month(Data: TDateTime): Integer;
  function sgMonth(Data: TDateTime): Integer;
  function Day(Data: TDateTime): Integer;
  function sgDay(Data: TDateTime): Integer;
  function Next_Day(iData: TDateTime; Dia_Sema: String): TDateTime;
  function DateTimeToMilliseconds(const ADateTime: TDateTime): Int64;
  function TimeToMilliseconds(const ADateTime: TDateTime): Int64;

  Function NomeDia_Sema(Data: TDateTime): String;
  function Dia_Nome(Data: TDateTime): String;
  Function InicDataFormStor(Data: String): TDateTime;
  Function DifeEntrMes(Mes_Inic, Ano_Inic, Mes_Fina, Ano_Fina: Integer):Integer;
  Function DiasMes(Mes: Byte; Ano:Integer):Byte;
  function Mes_PrimDia(iData: TDateTime): TDateTime;
  function Mes_UltiDia(iData: TDateTime): TDateTime;
  function GeraSenhDia(iData: TDate) :String;

  function PegaValoRegiWind(Chav, Sequ, Tipo: String): String;
  Function LocaArquConfBase(Empr: TStrings): String;
  Function PegaDadoConfBase_Cone(Empr, EndeArqu, Usua, Senh: String): String;

  Function TipoDadoUsua(Tipo: TField):String;
  Function TipoDadoUsuaFieldDefs(Tipo: TFieldDef):String;
  Function TipoDadoBanc(Tipo:TField; Dado: String):String;
  Function TipoDadoCara(Tipo:TField):AnsiChar;
  Function TipoDadoCaraFieldDefs(Tipo: TFieldDef):AnsiChar;
  Function TipoDadoDelphi(Tipo: TField):String;
  function TipoDadoFieldType(iTipo: String): TFieldType;

  Function ExibDadoQuer(Dts: TDataSet; iVeriTama: Boolean=False; iExibTipo: Boolean=False): String;
  Function ExibDadoQuer_Nulos(Dts: TDataSet; iVeriTama: Boolean=False; iExibTipo: Boolean=False): String;
  function TestDataSet(Dts: TDataSource): Boolean; overload;
  function TestDataSet(Dts: TDataSet): Boolean; overload;


  Procedure SaveCompToStream(AComp:TComponent; AStream:TStream;IncludeData:Boolean=True;TextFormat:Boolean=False);
  Procedure LoadCompFromStream(Var AComp:TComponent;AStream:TStream);
  Procedure SaveCompToStream2(AComp:TComponent;aFileName: String);
  Procedure LoadCompFromStream2(Var AComp:TComponent;aFileName: String);

  function ArquAbre(Ende: String): WideString;
  procedure ArquGrav(Valo: WideString; Ende: WideString);
  procedure ArquAdicText(Valo: WideString; Ende: WideString);
  Function SetaFocu(Comp: TWinControl): Boolean;
  function CreateProcessSimple(cmd: string): boolean;

  Function FormInteBras(Valo: Real):String;
  Function FormRealBras(Valo: Real; Casa:Integer=2):String;
  Function FormDataBras(Data: TDateTime; DigiAno_: Integer = 4):String;
  Function FormDataHoraBras(Data: TDateTime; DigiAno_: Integer = 4):String;
  Function FormDataBrasRedu(Data: TDateTime):String;
  function FormHoraMinuSegu(TempSegu: Integer): String;
  Function FormDataSQL(Data: Variant):String;
  function FormHoraSQL(Data:TDateTime):String;
  function FormSomaCaraSQL(): String;
  Function FormLikeSQL:String;
  Function FormDataStri(Data: TDateTime):String;
  function SubsDataAtuaSQL(Text: String; DataInic, DataFina: TDateTime): String;
  function FormCondSQL(Test, Cond, Verd, Fals: String):String;
  Function FormCastStriSQL(Valo: String):String;
  Function FormUppeSQL():String;
  Function FormInteSQL:String;
  Function FormRounSQL(Valo: String; Casa: String='0'):String;
  Function FormCastInteSQL(Valo: String):String;
  Function FormCastRealSQL(Valo: String):String;
  Function FormMod_SQL(Ope1, Ope2: String):String;
  Function FormDeleSQL:String;
  Function DataAtuaSQL(): WideString;
  Function DataHoraAtuaSQL(): String;
  Function FormNuloSQL(Valo: String): String;
  Function FormLeftSQL(): String;
  Function FormRightSQL(): String;
  Function FormDia_SQL(): String;
  Function FormMes_SQL(): String;
  Function FormAno_SQL(): String;
  Function FormClobSQL(Valo: String): String;
  function sgNull(): String;
  function IsSGNull(iValo: String): Boolean;
  function Variant_IsEmptyOrNull(const Value: Variant): Boolean;
  function Extenso(Valo: Real): String;
  function ExtensoPers(Valo: Real; MoedSing, MoedPlur: String; Unid: String = 'Unidade'): String;
  Function FormMascNume(Valo: Real; Casa: Integer = 0): String;

  function GetPLblAjud(): TsgLbl;
  procedure SetPLblAjud(Valo: TsgLbl);
  procedure GravLog_Mens(iMens: String; nProc: Integer = 1; iForcGrav: Boolean = False);
  procedure SetPLblAjud_Capt(Valo: String);
  procedure GravaLogAtualizacao(Valor: String);
  procedure SetPPrgPrin(Valo: TsgProgBar);
  function GetPPrgPrin(): TsgProgBar;
  procedure SetPPrgPri1(Valo: TsgProgBar);
  function GetPPrgPri1(): TsgProgBar;
  function ExibProgPrinFunc(CompProg: TsgProgBar; Valo: Integer = 1; Maxi: Integer = 0; Mens: string = ''; ProgTota: Boolean = False): Boolean;
  function ExibProgPrin(Valo: Integer = 1; Maxi: Integer = 0; Mens: string = ''; ProgTota: Boolean = False): Boolean;
  function ExibProgPri1(Valo: Integer = 1; Maxi: Integer = 0; Mens: string = ''; ProgTota: Boolean = False): Boolean;

  procedure ExibMensHint(Mens: String);
  procedure Application_ProcessMessages;

  function GetIsNaSAG(): Boolean;
  function GetOwnerOrac(): String;
  function GetOwnerPratica(): String;
  function GetSessionCodiPrat(): String;
  function RetoUserBase(): String;
  function GetNomeArquLog_(Adic: String = ''): String;

  procedure SetPClientCria(Value: TSGClientDataSet);
  function GetPClientCria(Value: TSGClientDataSet = nil): TSGClientDataSet;
  function GetPCodMoni(): Integer;
  function GetConfRela(): TConfRela;

  function CapturaTela: TBitmap;
  function EnumWindowsProc(Wnd : HWnd; ListBox1 : TListBox) : Boolean; Export; StdCall;
  Function EnumWindowsProcAber(Wnd: HWND; lb: TStringList): BOOL; stdcall;
  procedure DeleteFiles(Ende: String);
  function GetURLFilename(const FilePath:String; Const Delimiter:String='/'):String;

  Function VerificaSerialDesenv():Boolean;
  Function VerificaSerialGerencia():Boolean;
  function IsERPSAG_Desenv(iUsua: String = ''): Boolean;
  Function VerificaSerialCons():Boolean;
  Function VerificaSerialSupo():Boolean;
  Function VerificaSerialAdm():Boolean;
  Function VerificaSerialCome():Boolean;
  Function VerificaSerialSenh():Boolean;
  Function VerificaSerialSecr():Boolean;
  Function GetSenhAdm():String;
  Function GetSenhMast():String;
  function IsSAG(): Boolean;
  function BuscEquipeSAG(iBuscCamp, iBuscValo, iCamp: String): String;
  Function SerialNum(FDrive:String) :String;
  function PegaIP: String;
  function PegaMaqu: String;
  function PegaUsuaWind: String;
  Function MemoTota : Longint;
  Function MemoLivr : Longint;
  Function Memo_Uso : Longint;
  Function PegaSeri(FDrive:String=''): String;

  function Crip(Pala:String):String;
  function CripXe7(Pala:String):String;
  function Des_CripXe7(Pala:String):String;
  function Des_Crip(Pala:String):String;
  Function CripArqu(EndeOrig, EndeDest, Senh: String): Boolean;
  Function Des_CripArqu(EndeOrig, EndeDest, Senh: String): Boolean;
  function CripChav(parstring,parchave: String): String;
  function CripChavSAG(Texto: String; Chav: Integer): String;
  function CripChav2(StrValue, Key : String) : String;
  function Split(value, delimiter : String) : TsgArrayString;
  function sgSplit(value, delimiter : String; AddDelimiter: Boolean = False) : TsgArrayString;

  function sgMessageDlgTimer(Msg :String;tempo:integer; AType: TMsgDlgType; AButtons : TMsgDlgButtons;
                             IndiceHelp : LongInt; DefButton : TModalResult=MrNone) : Word;
  //to-do: Verificar se é necessário passar o Vcl.Dialogs no XE7
  function MessageDlgDefault(Msg :String; AType: Dialogs.TMsgDlgType; AButtons : Dialogs.TMsgDlgButtons;
                             IndiceHelp : LongInt; DefButton : TModalResult=MrNone) : Word;
  function sgMessageDlg(const Msg: string; DlgType: TMsgDlgType;Buttons: TMsgDlgButtons): Integer; overload;
  function sgMessageDlg(const Msg: string; DlgType: TMsgDlgType;Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn = mbHelp): Integer; overload;
  function MyMessageDlg(const Msg:string; DlgType:TMsgDlgType; Buttons:TMsgDlgButtons;
               sFontName:string=''; iFontSize:Integer=0; fsStyle:TFontStyles=[];
               sCaptions: string=''):integer;
  Function msgOk(msg: String): Integer;
  Function msgAviso(msg: String): Integer;
  Function msgSim(msg: String): Boolean;
  Function msgNao(msg: String): Boolean;
  Function msgNovaMsg(msg: String; iNovaMsg: String): Boolean;

  procedure CopyToClipBoard(const iText: String);

  function GeraChavGrav(): String;

  Function BuscPareWin(Comp: TClass; Classe: String = {$IFDEF ERPUNI} 'TUniControl' {$else} 'TWinControl' {$endif}): Boolean;
  Function GetPareWin(Comp: {$IFDEF ERPUNI} TUniControl {$else} TWinControl {$endif}; Classe: TClass): TComponent;
  Function GetOwnerWin(Comp: TComponent; Classe: TClass): TComponent;
  function sgTipoForm(iComp: TClass): TsgTipoForm;

  function ZeroNume(Nume:String; Tama : integer):String;
  //---> Retira qualquer caracter da String, deixando apenas os nzmero de 0 a 9, o ponto e a vmrgula
  function RetiCara(Nome:String):String;
  //---> Retira o Caracter Passado da String Passada
  Function RetiTipoCara(Nome,Cara:String):String;
  //Deixa somente nzmero, ponto e vmrgula
  Function RetiLetr(Nome: String):String;
  //Deixa somente nzmero e letras
  function LetrNume(Nome: String; SubsPor_: String = ''):String;
  //---> Inverter vmrgulas para ponto e vice-versa.
  // Obs.: Esta Fungco ja possui o RetoZero
  Function InvePont(Nume: String):String;
  // Deixar sempre PONTO para separar Decimais.
  Function PontDeci(Nume: Real; Casa: Byte):String;
  // Pega uma String passado com um valor REAL no formato STRING e retorna o valor com o separador do WINDOWS
  // (Ex.: Pega 1.234.456,7890 <=> Retorna 123456.7890) (Caso o Separador seja Ponto)
  // Obs.: Esta Fungco ja possui o RetoZero
  Function FormReal(Nume: String):String;
  // Pega uma String passado com um valor DATA (DD/MM/YYYY) e retorna o valor no formado do WINDOWS
  Function FormData(Data: String; Padr: TDateTime = 0):String;
  function MergeArray(const iArray1, iArray2: TsgArrayString): TsgArrayString;

  Function EspaDire(Pala:String;Tama:Integer;Copi:Boolean=True):String;
  Function EspaEsqu(Pala:String;Tama:Integer;Copi:Boolean=True):String;
  Function CaraDire(Pala,Cara:String;Tama:Integer):String;
  Function CaraEsqu(Pala,Cara:String;Tama:Integer):String;
  function NuloStri(Valo:Variant):String;
  function NuloStri2(Valo:Variant): String;
  function NuloInte(Valo:Variant):Int64;
  function ZeroNulo(Valo:Variant):Variant;
  function NuloReal(Valo:Variant):Real;

  function TeclPres(const Key: Integer): Boolean;
  function VeriTeclPress(const Key: integer): boolean;

  function funCountChar(psTexto: string; pcChar: Char): Integer;
  function DateRec(const Year, Month, Day: SmallInt): TDateRec;
  function TimeRec(const Hour, Minute, Second: SmallInt): TTimeRec;
  function TSRec(const Year, Month, Day, Hour, Minute, Second: SmallInt): TTSRec;

  function FBDecDate(T: TFBDate): TDateRec;
  function FBDecTime(T: TFBTime): TTimeRec;
  function FBDecTS(T: TFBTS): TTSRec;

  function FBEncDate(T: TDateRec): TFBDate;
  function FBEncTime(T: TTimeRec): TFBTime;
  function FBEncTS(T: TTSRec): TFBTS;

  function FBTimeToSec(T: TFBTime): integer;
  function FBSecToTime(I: integer): TFBTime;
  function FBTSToSec(T: TFBTS): int64;
  function FBDifAsSec(T1, T2: TFBTS): int64;
  function FBDifAsDay(T1, T2: TFBTS): double;

  procedure FBIncYear(var T: TFBDate; const X: integer);
  procedure FBIncMonth(var T: TFBDate; const X: integer);
  procedure FBIncWeek(var T: TFBDate; const X: integer);
  procedure FBIncDay(var T: TFBDate; const X: integer);
  procedure FBIncSecond(var T: TFBTS; const X: integer);

  function LastDay(const Year, Month: SmallInt): SmallInt;
  function PosValue(const AbsValue, Base, Position: byte): integer;
  function Trunc32(const X: double): integer;
  function Round32(const X: double): integer;
  function RoundDouble(const X: double): double;
  function Age(const Birth, Today: TDateRec): integer;
  Function FormNumeSQL(Valo: Extended): String;
  Function FormNumeSQL_Nulo(Valo: Extended): String;

  Function FormNumeSgTable(Valo: Extended): String;

  Function RoundDec(Valo: Real; Casa: Integer): Real;
  Function LinhaDigitadaCodBarra(valor: String):string;

  function OnlyNumber(Texto: String): string;

  procedure addLog(msg : String);

  procedure Componentes_Formata(iPrin: TWinControl);
  procedure Btn_Formata(iBtn: TsgBtn);
  procedure FormatFields(iDts: TsgClientDataSet);
  function Ini_BuscValo(Valo, Seca: String; Chav: String=''; Padr: String=''): String;

  function HostDS(): String;
  function TiraEspaLinhFinaList(iText: String): String;
  function TiraAteENDFinaList(iText: String): String;

  function ValidaFormUnigui(iForm: String): Boolean;
  function ValiMail(iMail: String): Boolean;

  function Trat_POCaErro(iMens: String): String;

  function TamaCamp_Ajusta(iTipo: TField; iTama: Integer): Integer; overload;
  function TamaCamp_Ajusta(iTipo: TField; iTama: String): Integer; overload;
  function CreateIconFromBitmap(Bitmap: TBitmap; TransparentColor: TColor): TIcon;
  function isMobi_POCaCamp(iValo: String): String;
  function isMobi_POCaCamp_Sele(iValo: String): String;

  function ExecPers_isVariData(iValo: String): Boolean;
  function ExecPers_isVariHora(iValo: String): Boolean;
  function ExecPers_isConst(iValo: String): Boolean;
  Function CampPers_TratNome(const iNome:String): String;
  Function CampPers_TratNome_Gera(const iNome:String): String;

  function Banc_TratWher(iWherAtua, iWherAdic: String): String;

  function FormataVers(iVers : String): String;

  function ClicTabe_To_TipoClic(const iClicTabe: String): TTipoClic;

implementation

uses
  ListAdaptadores, uLkJSON, MyMessage, IdIpWatch, RetoVers, Trad, sgDBG, System.UITypes, Clipbrd
  {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
    {$ifdef SAGSINC}, Funcoes {$endif}
    , DmPoul, DmPlus
    {$ifdef ERPUNI}
      , ServerModule, uniGUIApplication, Main
    {$ELSE}
     , Mask, cxLookAndFeels, cxEdit, rxToolEdit, RXSpin, AdvMemo, cxGridCustomView, cxGridDBTableView
    {$endif}
  {$endif}
  , TradPtBr, TradEsAr, TradNamed, sgConsts, System.Math
  , EdtLbl,
  DBEdtLbl,
  DBVCmLbl,
  DBRxDLbl,
  DBRxELbl,
  RxEdtLbl,
  RxDatLbl,
  CmbLbl,
  LstLbl,
  FilLbl,
  DirLbl,
  LcbLbl,
  DBFilLbl, DbAdvMemLbl,  AdvMemLbl, DBLookNume, DBLookText, sgPop, DBLcbLbl,
  DBMemLbl, DBRchLbl, DBImgLbl, sgPgc, sgBvl, DBIniMemo, sgConstsMsg;


//Operação String para Mensagem
function Operacao_StrMsg(iOper: TDec_Operacao): String;
begin
  case iOper of
    opIncl: Result := SInclusaoInvalida;
    opAlte: Result := SAlteracaoInvalida;
    opExcl: Result := SExclusaoInvalida;
    opIndefinido: Result := SOperacaoInvalida;
  end;
end;

function TestaConexao(DataSet: TDataSet): Boolean;
var
  conTeste: TSGADOConnection;
  ConnectionString: String;
begin
  result := True;
  if DataSet.FieldByName('TIPO').AsString = 'ADO' then
  BEGIN
    if DataSet.FieldByName('BANCO').AsString = 'Oracle' then
    BEGIN
      ConnectionString := 'Provider=OraOLEDB.Oracle.1' +
        ';Persist Security Info=True' + ';User ID=' + DataSet.FieldByName
        ('USUARIO').AsString + ';Password=' + DataSet.FieldByName('SENHA')
        .AsString + ';Data Source=' + DataSet.FieldByName('CONFIG').AsString;
      conTeste := TSGADOConnection.Create(nil);
      conTeste.LoginPrompt := False;
      conTeste.ConnectionString := ConnectionString;
      try
        try
          conTeste.Connected := True;
        except
          on E: Exception do
          begin
            sgMessageDlg('Configuração invalida Erro: ' + E.Message, mtInformation, [mbOK], 0);
            result := False; ;
          end;
        end;
      finally
        conTeste.Free;
      end;
    END;
  end;
end;

function ConfiguraConexao(TIPO, BANCO, CONFIG, USUARIO, SENHA: String;Conexao: TSGADOConnection): Boolean;
var
  ConnectionString: String;
begin
  result := True;
  if TIPO = 'ADO' then
  BEGIN
    if BANCO = 'Oracle' then
    BEGIN
      ConnectionString := 'Provider=OraOLEDB.Oracle.1' +
        ';Persist Security Info=True' + ';User ID=' + USUARIO + ';Password=' +
        SENHA + ';Data Source=' + CONFIG;
      Conexao := TSGADOConnection.Create(nil);
      Conexao.LoginPrompt := False;
      Conexao.ConnectionString := ConnectionString;
      try
        try
          Conexao.Connected := True;
        except
          on E: Exception do
          begin
            sgMessageDlg('Configuração invalida Erro: ' + E.Message, mtInformation, [mbOK], 0);
            result := False; ;
          end;
        end;
      finally
        // Conexao.Free;
      end;
    END;
  end;
end;

function FormataSql(Sql: String; Filtrar: Boolean = True): String;
var
  Filtro: String;
begin
  if Filtrar then
    Filtro := ' WHERE (1=2) '
  else
    Filtro := ' WHERE (1=1) ';
  if Pos('SELECT', UpperCase(Sql)) > 0 then
  begin
    // PARA CARREGAR APENAS OS CAMPOS E NÃO OS DADOS DO SQL.
    // SE TEM WHERE
    if Pos(UpperCase(Sql), 'WHERE') > 0 then
      StringReplace(Sql, 'WHERE', Filtro + ' AND ',
        [rfReplaceAll, rfIgnoreCase])
      // SE NÃO TEM WHERE
    else
      Sql := Sql + Filtro;
  end
  // SE É APENAS UMA VIEW E/OU TABELA
  ELSE
  begin
    Sql := 'SELECT * FROM ' + Sql + Filtro;
  end;
  result := Sql;
end;

function IsAdmiSAG(Usua: String = ''): Boolean;
begin
  if Usua = '' then
    Usua := GetPCodPess();

  Usua := ZeroEsqu(Usua,03);
  Result := (Copy(Usua,02,02) = '99') and
            CharInSet(Usua[01], ['A'..'Z']);
  {$ifdef ERPUNI}
    if not Result then
       Result := (Copy(Usua,01,02) = 'U9');
  {$endif}
end;

function IsAdmiClie(Usua: String = ''): Boolean;
begin
  if Usua = '' then
    Usua := GetPCodPess();

  Usua := ZeroEsqu(Usua,03);
  Result := ((Copy(Usua,02,02) = '97') or (Copy(Usua,02,02) = '98'))
            and
            CharInSet(Usua[01], ['A'..'Z']);
end;

function IsVeriAces(): Boolean;
begin
  Result := not (IsAdmiClie or IsAdmiSAG)
end;

function IsRx9(Sist: Integer = 0): Boolean;
begin
  Result := IsRx;
end;

function IsRx(Sist: Integer = 0): Boolean;
begin
  Result := False;
  {$ifdef INTOTUM}
    Result := True;
  {$endif}
  {$IF Defined(Pratica) or Defined(CW) or Defined(DLL_Pratica)}
    Result := True;
  {$endif}
  {$ifdef RX}
    Result := True;
  {$endif}
  {$ifdef RXFINANCEIRO}
    Result := True;
  {$endif}
  {$ifdef RX9}
    Result := True;
  {$endif}
end;

function isOracle(): Boolean;
begin
  Result := GetPBas() = 4;
end;

procedure SetPNomSist(Nome: String);
begin
  GetConfWeb.PNomSist := Nome;
end;

procedure SetPNomEmpr(Nome: String);
begin
  GetConfWeb.PNomEmpr := Nome;
end;

procedure SetPAux(Nome: String);
begin
  GetConfWeb.PAux := Nome;
end;

procedure SetPNomUsua(Nome: String);
begin
  GetConfWeb.PNomUsua := Nome;
end;

procedure SetPEmp(Empr: Integer);
begin
  GetConfWeb.CodiEmpr := Empr;
end;

procedure SetPCodEmpr(Empr: String);
begin
  GetConfWeb.PCodEmpr := Empr;
end;

procedure SetPBas(Base: Integer);
begin
  GetConfWeb.PBas := Base;
end;

procedure SetPBasTest(Valo: Boolean);
begin
  GetConfWeb.PBasTest := Valo;
end;

procedure SetPBasTC(Valo: Boolean);
begin
  GetConfWeb.PBasTC := Valo;
end;

procedure SetPUsu(Usua: Integer);
begin
  GetConfWeb.CodiPess := Usua;
end;

procedure SetPCodPess(Usua: String);
begin
  GetConfWeb.PCodPess := Usua;
end;

procedure SetPApePess(Apel: String);
begin
  GetConfWeb.PApePess := AnsiUpperCase(Apel);
end;

procedure SetPGru(Grup: Integer);
begin
  GetConfWeb.CodiGrUs := Grup;
end;

procedure SetPPerIdad(Idad: Real);
begin
  if Idad = 0 then
    Idad := 1;
  GetConfWeb.PPerIdad := Idad;
end;

procedure SetPAtuVers(Valo: TTipoAtuaVers);
begin
  GetConfWeb.AtuaVers := Valo;
end;

procedure SetPTab(Tabe: Integer);
begin
  GetConfWeb.PCodiTabe := Tabe;
end;

procedure SetPZooRela(Zoom: Integer);
begin
  GetConfWeb.PZoo := Zoom;
end;

procedure SetPLogTipo(LogTipo: Integer);
begin
  GetConfWeb.PLogTipo := LogTipo;
end;

procedure SetPMelAjus(Value: Boolean);
begin
  GetConfWeb.PMelAjus := Value;
end;

//Verifica se esta na SAG
//PIsNaSAG: 0-Ainda não verificado, 1-Na SAG e 2-Não na SAG
procedure SetPIsNaSAG();
//var
//  IdStackWin: TIdStackWindows;
begin
  if GetConfWeb.PIsNaSAG = 0 then
  begin
    if (Pos(DeixLetrNume('08-00-27-F4-1C-62'), DeixLetrNume(AnsiUpperCase(ListAdaptadores.ListMac_()))) > 0) or   //Delphi Sidiney
       (Pos(DeixLetrNume('08-00-27-26-66-08'), DeixLetrNume(AnsiUpperCase(ListAdaptadores.ListMac_()))) > 0) or  //Delphi Sidiney
       (Pos(DeixLetrNume('08-00-27-95-84-E2'), DeixLetrNume(AnsiUpperCase(ListAdaptadores.ListMac_()))) > 0) or    //VM Delphi Sidiney maq nova
       (Pos(DeixLetrNume('08-00-27-C9-67-0E'), DeixLetrNume(AnsiUpperCase(ListAdaptadores.ListMac_()))) > 0) then //VM Xe7 maq nova
      GetConfWeb.PIsNaSAG := 1
    else
    begin
      GetConfWeb.PIsNaSAG := 2;
      if FileExists(GetPEndExecOrig()+'serv001.sag') then
      begin
        GetConfWeb.PIsNaSAG := 1;
      end;
      GravLog_Mens('Onde: '+SeStri(GetConfWeb.PIsNaSAG = 1, 'Na SAG', 'No Cliente'));
    end;
  end;
end;

procedure SetPCodMoni(Codi: Integer);
begin
  GetConfWeb.CodiMoni := Codi;
end;

procedure SetConfRela(Valo: TConfRela);
begin
  GetConfWeb.ConfRela := Valo;
end;

procedure SetPADOConn(Conn: TSGADOConnection);
begin
  GetConfWeb.ADOConn := Conn;
  if Assigned(Conn) then
    SetPBas(Conn.PBas);
end;

procedure SetPsgTrans(Value: TsgTransaction);
begin
  // VERIFICAR. Se abrir uma tela de parametros e confirmar, ao tentar abrir outro tipo de tela, acusa Access Violation pois seta TsgTransaction com estado csDestroying
  if Assigned(Value) and (Value.ComponentState <> [csDestroying]) then
    GetConfWeb.sgTrans := Value
  else
    GetConfWeb.sgTrans := nil;
end;

procedure SetPGruGrid(Valo: Integer);
begin
  GetConfWeb.PGruGrid := Valo;
end;

procedure SetPRowGrid(Valo: Integer);
begin
  GetConfWeb.PRowGrid := Valo;
end;

procedure SetPLisImag(Valo: {$ifdef ERPUNI} TuniImageList {$else} TcxImageList {$endif});
begin
  GetConfWeb.ListImag := Valo;
end;

procedure SetPSis(Sist: Integer);
begin
  GetConfWeb.CodiProd := Sist;
end;

procedure SetPUppeCase(Valo: Boolean);
begin
  GetConfWeb.PUppeCase := Valo;
end;

procedure SetIsPratic(Value: Boolean);
begin
  GetConfWeb.IsPratic := Value;
end;

procedure SetCodiPrat(CodiPrat: Integer);
begin
  {$IF Defined(Pratica) or Defined(CW)}
    SetIsPratic(CodiPrat > 0);
  {$else}
    SetIsPratic(False);
  {$endif}
  GetConfWeb.CodiPrat := CodiPrat;
end;

procedure SetCodiIdio(CodiIdio: Integer);
begin
  if GetConfWeb.CodiIdio <> CodiIdio then
  begin
    if GetConfWeb.CodiIdio = -1 then
      SetResString;

    if CodiIdio = 0 then
      TradPtBr.TTraducao.ChangeValues
    else if CodiIdio = 1 then
      TradEsAR.TTraducao.ChangeValues;

    GetConfWeb.CodiIdio := CodiIdio;
  end;
end;

procedure SetPOChBuscPosi(Topo, Esqu, Altu, Tama: SmallInt);
begin
  GetConfWeb.POChBuscPosi.Topo := Topo;
  GetConfWeb.POChBuscPosi.Esqu := Esqu;
  GetConfWeb.POChBuscPosi.Altu := Altu;
  GetConfWeb.POChBuscPosi.Tama := Tama;
end;

procedure ConfWeb_Publico(iValo: TConfWeb);
begin
  if not Assigned(_Web_ConfWeb) then
    _Web_ConfWeb := TConfWeb.Create;
  _Web_ConfWeb.Assign(iValo);
end;

function GetConfWeb: TConfWeb;

  function GetConfWeb_Cria(): TConfWeb;
  begin
    if not Assigned(_Web_ConfWeb) then
      _Web_ConfWeb := TConfWeb.Create;
    Result := _Web_ConfWeb;
  end;
begin
  {$if Defined(SAGLIB) or Defined(LIBUNI)}
  {$else}
    {$IFNDEF PDADATASNAP} //{$IFNDEF DLL_REINF}
      try
        if DtmPoul = nil then
          Result := GetConfWeb_Cria()
        else if DtmPoul.ConfWeb = nil then
          Result := GetConfWeb_Cria()
        else
          Result := DtmPoul.ConfWeb;
      except
        Result := GetConfWeb_Cria();
      end;
    {$ELSE}
      Result := GetConfWeb_Cria();
    {$ENDIF}
  {$ENDIF}
end;

procedure SetConfWeb(iValo: TConfWeb);
begin
  {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
    {$IFDEF ERPUNI}
      DtmPoul.ConfWeb := iValo;
    {$ELSE}
      _Web_ConfWeb := iValo;
    {$ENDIF}
  {$ENDIF}
end;

function GetPMelAjus(): Boolean;
begin
  Result := GetConfWeb.PMelAjus;
end;

function GetPZooRela(Zoom: Integer = 0): Integer;
begin
  if Zoom = 0 then
    Result := GetConfWeb.PZoo
  else
    Result := Zoom;
end;

function GetPLogTipo(LogTipo: Integer = 0): Integer;
begin
//  {$ifdef PDADATASNAP}
//    Result := 2;
//  {$else}
    if LogTipo = 0 then
      Result := GetConfWeb.PLogTipo
    else
      Result := LogTipo;
//  {$endif}
end;

function GetPEmp(Empr: Integer = 0): Integer;
begin
  if Empr = 0 then
    Result := GetConfWeb.CodiEmpr
  else
    Result := Empr;
end;

function GetPUsu(Usua: Integer = 0): Integer;
begin
  if Usua = 0 then
    Result := GetConfWeb.CodiPess
  else
    Result := Usua;
end;

function GetPGru(Grup: Integer = 0): Integer;
begin
  if Grup = 0 then
    Result := GetConfWeb.CodiGrUs
  else
    Result := Grup;
end;

//Retorna o GetPSis() corrente
//Obs: A Relação de todos os GetPSis() estão no I:\Unit\DtmPoul
Function GetPSis(Sist: Integer = 0): Integer;
begin
  if Sist = 0 then
    Result := GetConfWeb.CodiProd
  else
    Result := Sist;

  if GetPNomSist() = 'GPD - Genetic Poultry Dataware' then
    Result := 81;

  if GetPNomSist() = 'Expedição' then
    Result := 82;

  if GetPNomSist() = 'Vendas & Distribuição' then
    Result := 83;

  if GetPNomSist() = 'Compras' then
    Result := 84;

  if GetPNomSist() = 'PDAColetor' then
    Result := 70;

  if GetPNomSist() = 'Call Center' then
    Result := 89;

  if GetPNomSist() = 'SAGColetor' then
    Result := 87;
end;

Function GetPCodSist(iSist: Integer = 0): String;
begin
  Result := 'S'+ZeroEsqu(IntToStr(GetPSis(iSist)),02);
end;

//Retorna o GetPBas() conforme o nome do alias passado
function GetPBas(): Integer;
begin
  Result := GetConfWeb.PBas;
end;

Function GetPNomSist(): String;
begin
  Result := GetConfWeb.PNomSist;
end;

Function GetPNomTitu(): String;
begin
  Result := GetPNomSoft()+{$ifdef DATASNAP}' DATASNAP'+{$endif}{$ifndef Pratica}' :: '+GetPNomSist()+{$endif}' :: '+GetPNomEmpr()
                          {$IfDef TESTMODE}+' ::::: MODO DE ROTINA DE TESTE ::::: MODO DE ROTINA DE TESTE'{$endif};
end;

Function GetPNomSoft(): String;
begin
  {$IF Defined(Pratica) or Defined(DLL_Pratica)}
    {$ifdef CW}
      Result := 'Controladoria na Web';
    {$else}
      Result := 'ERP '+GetPNomAbreSoft();
    {$endif}
  {$else}
    Result := 'ERP '+GetPNomAbreSoft();
  {$endif}
  {$ifdef BEN}
    Result := 'Projeto b.e.n.';
  {$endif}
  {$ifdef WS}
    Result := 'WS '+Result;
  {$endif}
end;

//Nome Abreviado do Software
Function GetPNomAbreSoft(): String;
begin
  Result := '';
  {$ifdef BEN}
    Result := 'BEN';
  {$endif}
  {$ifdef RX}
    Result := 'RX';
  {$endif}
  {$ifdef INTOTUM}
    Result := 'Intotum';
  {$endif}
  {$IF Defined(Pratica) or Defined(DLL_Pratica)}
    {$ifdef CW}
      Result := 'CW';
    {$else}
      Result := 'Pratica';
    {$endif}
  {$endif}
  {$ifdef RX9}
    Result := 'RX9';
  {$endif}
  {$ifdef RXFINANCEIRO}
    Result := 'RXFinanceiro';
  {$endif}
  {$ifdef GROW}
    Result := 'GROW';
  {$endif}
  if Result = '' then
    Result := 'SAG';
end;

//Site da Empresa
Function GetPNomSiteSoft(): String;
begin
  Result := GetConfWeb.GetSite;
end;

Function GetPNomEmpr(): String;
begin
  Result := GetConfWeb.PNomEmpr;
end;

Function GetPCodEmpr(Empr: String = ''): String;
begin
  if Empr = '' then
    Result := GetConfWeb.PCodEmpr
  else
    Result := Empr;
  Result := ZeroEsqu(Result, 03);
end;

Function GetPAux(): String;
begin
  Result := GetConfWeb.PAux;
end;

Function GetPNomUsua(): String;
begin
  Result := GetConfWeb.PNomUsua;
end;

Function GetPCodPess(Usua: String = ''): String;
begin
  if Usua = '' then
    Result := GetConfWeb.PCodPess
  else
    Result := Usua;
  Result := ZeroEsqu(Result, 03);
end;

Function GetPApePess(apel: String = ''): String;
begin
  if Apel = '' then
    Result := GetConfWeb.PApePess
  else
    Result := Apel;
end;

Function GetPNomExec(): String;
begin
  {$ifndef LIBUNI}
    {$if Defined(ERPUNI) and not Defined(TRAY)}
      Result := UniServerModule.ModuleName;
    {$else}
      Result :=  ExtractFileName(Application.ExeName);
    {$endif}
  {$endif}
end;

Function GetPEndExec(): String;
begin
  {$ifdef PRATICA}
    Result := 'D:\Dados\Prat'+IntToStr(GetCodiPrat)+'\';
  {$else}
    Result := GetPEndExecOrig()+'Log\';
    CriaDire(Result);
  {$endif}
end;

Function GetPEndExec_Remessa(): String;
begin
  {$ifdef PRATICA}
    Result := 'D:\Dados\Prat'+IntToStr(GetCodiPrat)+'\';
  {$else}
    Result := GetPEndExecOrig();
    CriaDire(Result);
  {$endif}
end;

Function GetPEndExecOrig(): String;
begin
  Result := '';
  {$ifndef LIBUNI}
    {$if Defined(ERPUNI) and not Defined(TRAY)}
      Result := UniServerModule.StartPath;
    {$else}
      Result := ExtractFilePath(Application.ExeName);
    {$endif}
  {$endif}
end;

function GetPTab(Tabe: Integer = 0): Integer;
begin
  if Tabe = 0 then
    Result := GetConfWeb.PCodiTabe
  else
    Result := Tabe;
end;

function GetPBasTest(): Boolean;
begin
  Result := GetConfWeb.PBasTest;
end;

function GetPBasTC(): Boolean;
begin
  Result := GetConfWeb.PBasTC;
end;

function GetPPerIdad(Idad: Real = 0): Real;
begin
  if GetConfWeb.PPerIdad = 0 then
    GetConfWeb.PPerIdad := 1;

  if Idad = 0 then
    Result := GetConfWeb.PPerIdad
  else
    Result := Idad;
end;

function GetPAtuVers(): TTipoAtuaVers;
begin
  Result := GetConfWeb.AtuaVers;
end;

function GetPADOConn(): TsgADOConnection;
begin
  Result := GetConfWeb.ADOConn;
  if not Assigned(Result) then
  begin
    Result := TsgADOConnection.Create(nil);
    Result.LoginPrompt := False;
    SetPADOConn(Result);
  end;
  {$ifdef WS}
    if (not Result.Connected) and (GetConnectionString() <> '') then
    begin
      Result.AfterConnect := nil;
      Result.ConnectionString := GetConnectionString();
      Result.Open;
    end;
  {$else}
  {$endif}
end;

function GetPsgTrans(): TsgTransaction;
begin
  if Assigned(GetConfWeb.sgTrans) then
  begin
    try
      if GetConfWeb.sgTrans.Name = '' then
        GetConfWeb.sgTrans := nil;
    except
      GetConfWeb.sgTrans := nil;
    end;
  end;
  Result := GetConfWeb.sgTrans;
end;

function GetPGruGrid(): Integer;
begin
  Result := GetConfWeb.PGruGrid;
end;

function GetPRowGrid(): Integer;
begin
  Result := GetConfWeb.PRowGrid;
end;

function GetPLisImag(): {$ifdef ERPUNI} TuniImageList {$else} TcxImageList {$endif};
begin
  Result := GetConfWeb.ListImag;
end;

function GetPUppeCase(Valo: Boolean = False): Boolean;
begin
  Result := GetConfWeb.PUppeCase;
end;

function GetCodiPrat(CodiPrat: Int64 = 0): Int64;
begin
  if CodiPrat = 0 then
    Result := GetConfWeb.CodiPrat
  else
    Result := CodiPrat;
end;

function GetIsPratic(): Boolean;
begin
  {$IF Defined(Pratica) or Defined(CW)}
    Result := True;
  {$else}
    if GetConfWeb.TipoAplicacao = apPrat then
      Result := True
//    else if GetCodiPrat <> 0 then
//      Result := True
    else
      Result := GetConfWeb.IsPratic;
  {$endif}
end;

function IsPratic: Boolean;
begin
  Result := GetIsPratic;
end;

function GetCodiIdio(CodiIdio: Int64 = 0): Int64;
begin
  {$ifdef PDADATASNAP}
    Result := 0;
  {$else}
    if CodiIdio = 0 then
      Result := GetConfWeb.CodiIdio
    else
      Result := CodiIdio;
  {$endif}
end;

function PDataServ(): TDateTime;
begin
  Result := GetConfWeb.PDataServ;
end;

//Procurar a Cor pelo Nome
function GetCor_Nome(Cor: String): Integer;
const
  Cor_Qtde: Integer = 139;
  Cor_Nume: array[0..139] of TColor =      //cxX11OrderedColorValues em cxExtEditConsts
    ($C1B6FF, $CBC0FF, $3C14DC, $F5F0FF, $9370DB, $B469FF, $9314FF, $8515C7,
     $D670DA, $D8BFD8, $DDA0DD, $EE82EE, $FF00FF, $FF00FF, $8B008B, $800080,
     $D355BA, $D30094, $CC3299, $82004B, $E22B8A, $DB7093, $EE687B, $CD5A6A,
     $8B3D48, $FAE6E6, $FFF8F8, $FF0000, $CD0000, $701919, $8B0000, $800000,
     $E16941, $ED9564, $DEC4B0, $998877, $908070, $FF901E, $FFF8F0, $B48246,
     $FACE87, $EBCE87, $FFBF00, $E6D8AD, $E6E0B0, $A09E5F, $FFFFF0, $FFFFE0,
     $EEEEAF, $FFFF00, $FFFF00, $D1CE00, $4F4F2F, $8B8B00, $808000, $CCD148,
     $AAB220, $D0E040, $D4FF7F, $AACD66, $9AFA00, $FAFFF5, $7FFF00, $71B33C,
     $578B2E, $F0FFF0, $90EE90, $98FB98, $8FBC8F, $32CD32, $00FF00, $228B22,
     $008000, $006400, $00FF7F, $00FC7C, $2FFFAD, $2F6B55, $32CD9A, $238E6B,
     $DCF5F5, $D2FAFA, $F0FFFF, $E0FFFF, $00FFFF, $008080, $6BB7BD, $CDFAFF,
     $AAE8EE, $8CE6F0, $00D7FF, $DCF8FF, $20A5DA, $0B86B8, $F0FAFF, $E6F5FD,
     $B3DEF5, $B5E4FF, $00A5FF, $D5EFFF, $CDEBFF, $ADDEFF, $D7EBFA, $8CB4D2,
     $87B8DE, $C4E4FF, $008CFF, $E6F0FA, $3F85CD, $B9DAFF, $60A4F4, $1E69D2,
     $13458B, $EEF5FF, $2D52A0, $7AA0FF, $507FFF, $0045FF, $7A96E9, $4763FF,
     $E1E4FF, $7280FA, $FAFAFF, $8080F0, $8F8FBC, $5C5CCD, $0000FF, $2A2AA5,
     $2222B2, $00008B, $000080, $FFFFFF, $F5F5F5, $DCDCDC, $D3D3D3, $C0C0C0,
     $A9A9A9, $808080, $696969, $000000);

  Cor_Nome: array[0..139] of String =  //cxX11OrderedColorNames em cxExtEditConsts
    ('LightPink', 'Pink', 'Crimson', 'LavenderBlush', 'PaleVioletRed', 'HotPink',
     'DeepPink', 'MediumVioletRed', 'Orchid', 'Thistle', 'Plum', 'Violet',
     'Magenta', 'Fuchsia', 'DarkMagenta', 'Purple', 'MediumOrchid', 'DarkViolet',
     'DarkOrchid', 'Indigo', 'BlueViolet', 'MediumPurple', 'MediumSlateBlue',
     'SlateBlue', 'DarkSlateBlue', 'Lavender', 'GhostWhite', 'Blue', 'MediumBlue',
     'MidnightBlue', 'DarkBlue', 'Navy', 'RoyalBlue', 'CornflowerBlue',
     'LightSteelBlue', 'LightSlateGray', 'SlateGray', 'DodgerBlue', 'AliceBlue',
     'SteelBlue', 'LightSkyBlue', 'SkyBlue', 'DeepSkyBlue', 'LightBlue',
     'PowderBlue', 'CadetBlue', 'Azure', 'LightCyan', 'PaleTurquoise', 'Cyan',
     'Aqua', 'DarkTurquoise', 'DarkSlateGray', 'DarkCyan', 'Teal',
     'MediumTurquoise', 'LightSeaGreen', 'Turquoise', 'Aquamarine',
     'MediumAquamarine', 'MediumSpringGreen', 'MintCream', 'SpringGreen',
     'MediumSeaGreen', 'SeaGreen', 'Honeydew', 'LightGreen', 'PaleGreen',
     'DarkSeaGreen', 'LimeGreen', 'Lime', 'ForestGreen', 'Green', 'DarkGreen',
     'Chartreuse', 'LawnGreen', 'GreenYellow', 'DarkOliveGreen', 'YellowGreen',
     'OliveDrab', 'Beige', 'LightGoldenrodYellow', 'Ivory', 'LightYellow',
     'Yellow', 'Olive', 'DarkKhaki', 'LemonChiffon', 'PaleGoldenrod', 'Khaki',
     'Gold', 'Cornsilk', 'Goldenrod', 'DarkGoldenrod', 'FloralWhite', 'OldLace',
     'Wheat', 'Moccasin', 'Orange', 'PapayaWhip', 'BlanchedAlmond', 'NavajoWhite',
     'AntiqueWhite', 'Tan', 'BurlyWood', 'Bisque', 'DarkOrange', 'Linen', 'Peru',
     'PeachPuff', 'SandyBrown', 'Chocolate', 'SaddleBrown', 'Seashell', 'Sienna',
     'LightSalmon', 'Coral', 'OrangeRed', 'DarkSalmon', 'Tomato', 'MistyRose',
     'Salmon', 'Snow', 'LightCoral', 'RosyBrown', 'IndianRed', 'Red', 'Brown',
     'FireBrick', 'DarkRed', 'Maroon', 'White', 'WhiteSmoke', 'Gainsboro',
     'LightGrey', 'Silver', 'DarkGray', 'Gray', 'DimGray', 'Black');

  Cor_NomeTrad: array[0..139] of String =  //cxX11OrderedColorNames em cxExtEditConsts
    ('LightPink', 'Pink', 'Crimson', 'LavenderBlush', 'PaleVioletRed', 'HotPink',
     'DeepPink', 'MediumVioletRed', 'Orchid', 'Thistle', 'Plum', 'Violeta',
     'Magenta', 'Fuchsia', 'DarkMagenta', 'Purple', 'MediumOrchid', 'DarkViolet',
     'DarkOrchid', 'Indigo', 'BlueViolet', 'MediumPurple', 'MediumSlateBlue',
     'SlateBlue', 'DarkSlateBlue', 'Lavender', 'GhostWhite', 'Azul', 'MediumBlue',
     'MidnightBlue', 'DarkBlue', 'Navy', 'RoyalBlue', 'CornflowerBlue',
     'LightSteelBlue', 'LightSlateGray', 'SlateGray', 'DodgerBlue', 'AliceBlue',
     'SteelBlue', 'LightSkyBlue', 'SkyBlue', 'DeepSkyBlue', 'LightBlue',
     'PowderBlue', 'CadetBlue', 'Azure', 'LightCyan', 'PaleTurquoise', 'Cyan',
     'Aqua', 'DarkTurquoise', 'DarkSlateGray', 'DarkCyan', 'Teal',
     'MediumTurquoise', 'LightSeaGreen', 'Turquoise', 'Aquamarine',
     'MediumAquamarine', 'MediumSpringGreen', 'MintCream', 'SpringGreen',
     'MediumSeaGreen', 'SeaGreen', 'Honeydew', 'LightGreen', 'PaleGreen',
     'DarkSeaGreen', 'LimeGreen', 'Lima', 'ForestGreen', 'Verde', 'DarkGreen',
     'Chartreuse', 'LawnGreen', 'GreenYellow', 'DarkOliveGreen', 'YellowGreen',
     'OliveDrab', 'Beige', 'LightGoldenrodYellow', 'Ivory', 'LightYellow',
     'Amarelo', 'Olive', 'DarkKhaki', 'LemonChiffon', 'PaleGoldenrod', 'Khaki',
     'Gold', 'Cornsilk', 'Goldenrod', 'DarkGoldenrod', 'FloralWhite', 'OldLace',
     'Wheat', 'Moccasin', 'Orange', 'PapayaWhip', 'BlanchedAlmond', 'NavajoWhite',
     'AntiqueWhite', 'Tan', 'BurlyWood', 'Bisque', 'DarkOrange', 'Linen', 'Peru',
     'PeachPuff', 'SandyBrown', 'Chocolate', 'SaddleBrown', 'Seashell', 'Sienna',
     'LightSalmon', 'Coral', 'OrangeRed', 'DarkSalmon', 'Tomato', 'MistyRose',
     'Salmon', 'Snow', 'LightCoral', 'RosyBrown', 'IndianRed', 'Vermelho', 'Brown',
     'FireBrick', 'DarkRed', 'Marom', 'Branco', 'WhiteSmoke', 'Gainsboro',
     'LightGrey', 'Silver', 'DarkGray', 'Cinza', 'DimGray', 'Preto');

var
  i: Integer;
begin
  Cor := AnsiUpperCase(Cor);
  Result := 0;
  if Cor = 'VERMELHO_FRACO' then Result := Cor_Vermelho_Fraco else
  if Cor = 'AMARELO_FRACO'  then Result := Cor_Amarelo_Fraco else
  if Cor = 'AZUL_FRACO'     then Result := Cor_Azul_Fraco else
  if Cor = 'AZUL_CEU'       then Result := Cor_Azul_Ceu else
  if Cor = 'AZUL'           then Result := Cor_Azul else
  if Cor = 'LARANJA_FRACO'  then Result := Cor_Laranja_Fraco else
  if Cor = 'VERDE_FRACO'    then Result := Cor_Verde_Fraco else
  if Cor = 'VERDE'          then Result := Cor_Verde else
  if Cor = 'VERMELHO'       then Result := Cor_Vermelho else
  if Cor = 'COLUNA_EDITAVEL' then Result := Cor_Coluna_Editavel
  else
  begin
    //Procura no Traduzido
    i := 0;
    while (i <= Cor_Qtde) and (Result = 0) do
    begin
      if AnsiUpperCase(Cor_NomeTrad[i]) = Cor then
        Result := Cor_Nume[i];
      Inc(i);
    end;

    //Procura no Ingles
    i := 0;
    while (I <= Cor_Qtde) and (Result = 0) do
    begin
      if AnsiUpperCase(Cor_Nome[i]) = Cor then
        Result := Cor_Nume[i];
      Inc(i);
    end;
  end;
end;

//Cria Estrutura de Diretsrios (Se não existir)
Procedure CriaDire(Ende: String);
begin
  try
    ForceDirectories(ExtractFilePath(Ende));
  except
  end;
end;

//Retorna a Versão do Executável atual ou o passado
function RetoVers(Arqu: String = ''): String;
begin
  Result := RetoVers.RetoVers_(Arqu);
end;

//Sidiney (10/02/2022): Gerar uma senha forte
Function GeraSenhFort(Nume:Integer): String;
begin
  Result := GeraPala(Nume);
  Result := SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(Result
                        ,'a','@')
                        ,'e','3')
                        ,'i','1')
                        ,'o','0')
                        ,'c','C')
                        ,'r','R')
                        ,'s','S')
                        ,'t','T')
                        ,'f','7')
                        ;
end;

//Retorna a Posição da Próxima Vírgula dentro de um Select
//Text: Texto a ser procurado
//Cara: Caracter a ser procurado
//Apos: Começar após a posição X
Function PosiProxVirg(Text: String; Cara: String=',';Apos: Integer=1):Integer;
type TVali = Record
       CaraInic: String;
       CaraFina: String;
       Nume    : Integer;
end;
const nVali = 5;
var
  Encr : Boolean;
  i, Nume: Integer;
  Vali: array[1..nVali] of TVali;
begin
  if Apos > Length(Text) then
  begin
    Apos := Length(Text);
    Text := '';
  end
  else
    Text := Copy(Text,Apos,Length(Text)-Apos+1);

  Vali[1].CaraInic := '(';
  Vali[1].CaraFina := ')';
  Vali[1].Nume     := 0;
  Vali[2].CaraInic := '"';
  Vali[2].CaraFina := '"';
  Vali[2].Nume     := 0;
  Vali[3].CaraInic := '''';
  Vali[3].CaraFina := '''';
  Vali[3].Nume     := 0;
  Vali[4].CaraInic := '[';
  Vali[4].CaraFina := ']';
  Vali[4].Nume     := 0;
  Vali[5].CaraInic := '{';
  Vali[5].CaraFina := '}';
  Vali[5].Nume     := 0;

  Result := 1;
  Nume   := 0;
  Encr := False;
  while (Result <= Length(Text)) and (not Encr) do
  begin
    for I := 1 to nVali do
    begin
      if (Text[Result] = Vali[i].CaraInic) then
      begin
        if ((Vali[i].CaraInic <> Vali[i].CaraFina) or (Vali[i].Nume = 0)) then //Os caracteres forem diferente, ou ainda não teve nenhum deles
        begin
          Vali[i].Nume := Vali[i].Nume + 1;
          Inc(Nume);
        end
        else
        begin
          Vali[i].Nume := Vali[i].Nume - 1;
          Dec(Nume);
        end;
      end
      else if (Text[Result] = Vali[i].CaraFina) then
      begin
        Vali[i].Nume := Vali[i].Nume - 1;
        Dec(Nume);
      end;
    end;

    if (AnsiUpperCase(Copy(Text,Result,Length(Cara))) = AnsiUpperCase(Cara)) and (Nume = 0) then
      Encr := True
    else
      Inc(Result);
  end;

  if not Encr then  //Se não encontrou, tira 1 do result, que foi incrementado no final
    Dec(Result);

  if (Apos > 1) and (Text <> '') then
    Result := Result + Apos - 1;  //Tira um, que é posição inicial, então esse um já esta na outra parte da string (se começa na 30, então só tinha mais 29 na outra string)
end;

//Passado o Número do Campo, pego o Nome direto do SQL
Function PegaCampSele(Sele:String; Nume: Integer):String;
var
  j, Camp : Integer;
begin
  if Sele <> '' then
  begin
    //Retiro o ''SELECT '' da String
    if AnsiUpperCase(Copy(Trim(Sele),01,04)) = 'WITH' then
      Sele := Copy(Sele, Pos('(SELECT',Sele)+07, MaxInt)
    else if AnsiUpperCase(Copy(Trim(Sele),01,06)) = 'SELECT' then
      Sele := Copy(Sele,08,Length(Sele)-7)
    else if AnsiUpperCase(Copy(Trim(Sele),01,08)) = 'ORDER BY' then
      Sele := Copy(Sele,10,Length(Sele)-9);

    if Sele <> '' then
    begin
      j := 0;
      Camp := 0;
      while j <= Length(Sele) do
      begin
        Inc(Camp);
        j := PosiProxVirg(Sele);
        if Camp = Nume then
        begin
          if Sele[j] = ',' then  //Caso a última posição seja a vírgula, não copia a mesma
            Sele := Copy(Sele,01,j-1)
          else
            Sele := Copy(Sele,01,j);
          j := Length(Sele)+1;
        end
        else
        begin
          Delete(Sele,01,j);
          j := 1;  //Caso o Sele estiver vazio (Length(Sele) = 0), sai porque o j é 1
        end;

        if j = 0 then  //Último campo
        begin
          j := 1;
          Sele := '';
        end;
      end;
    end;
  end;
  Result := Trim(Sele);
end;

//Objetivo: Pega o nome do campo (Alias) ou o próprio campo do SELECT passado
//Exemplo: NomePess AS Pessoa, 2 -> Pessoa
//         NomePess, 2 -> Campo 2
//Param: AliaCamp: Se verdadeiro, ao inves de retornar o nome do campo, retorna Campo 1, Campo 2... caso contrario, sem AS, retorna nomepess, fantpess
//         Se True
//           NomePess AS Pessoa -> Pessoa
//           NomePess, -> Campo 2
//         Se False
//           Se Completo
//             POCaPess.NomePess AS Pessoa -> POCaPess.NomePess
//             POCaPess.NomePess, -> POCaPess.NomePess
//           Se Not Completo
//             POCaPess.NomePess AS Pessoa -> NomePess
//             POCaPess.NomePess, -> NomePess
//       Completo: Não tira nada, mesmo com ponto, POCapess.NomePess retorna POCapess.NomePess
Function PegaNomeCamp(Camp: String; Nume: Integer = 0; AliaCamp: Boolean = True; Completo: Boolean = False; Integral: Boolean = False): String;
var
  Posi : Integer;
begin
  Camp := InvePala(Camp);
  Posi := Pos(' SA ',AnsiUpperCase(Camp));
  if (Posi > 0) then
  begin
    Result := Copy(Camp,01,Posi-1);
    Result := InvePala(Result);
  end
  else if AliaCamp then
    Result := 'Campo '+IntToStr(Nume)
  else
  begin
    Result := InvePala(Camp);
    if (not Completo) and (Pos('.',Result)  > 0) then
      Result := Copy(Result,Pos('.',Result)+1,Length(Result));
  end;
  if not Integral then
    Result := SubsPala(SubsPala(SubsPala(Result,'"',''),'[',''),']','');
  Result := Result.Trim;
end;

//Objetivo: Pega o nome do campo (Alias) ou o proprio campo do SELECT passado
Function PegaNomeCampSele(Sele : String; Nume: Integer; AliaCamp: Boolean = True; Completo: Boolean = False; Integral: Boolean = False): String;
begin
  Result := PegaCampSele(Sele, Nume);
  if Result <> '' then
    Result := PegaNomeCamp(Result, Nume, AliaCamp, Completo, Integral);
end;

//Pega o Campo Real da String passada (usado principalmente nos ManuGene)
//Exemplo: POCaPess.CodiPess AS Chav -> POCaPess.CodiPess
function PegaCampManuGene(Sele: String; Nume: Integer = 1): String;
begin
  Result := PegaSQL_Camp(PegaCampSele(Sele, Nume));
end;

//Pega o Primeiro campo da Manutengco Generica (tira o nome da tabela, se tiver)
function NomeCampSQL_PrimCamp(iSQL: String): String;
begin
  Result := PegaNomeCamp(PegaCampManuGene(iSQL), 0, False, False);
end;

//Objetivo: Pega o campo SQL do Campo
//Exemplo: NomePess AS Pessoa -> NomePess
//         NomePess -> NomePess
//         POCaPess.CodiPess AS Chav -> POCaPess.CodiPess
Function PegaSQL_Camp(Camp: String): String;
begin
  Camp := SubsPalaTudo(Camp,'DISTINCT','');
  if sgPos(' AS ',Camp) > 0 then
    Result := Copy(Camp,01,Length(camp)-1 - sgPos(' SA ',ReverseString(Camp))-1)
  else if Pos(' ',Trim(Camp)) > 0 then
    Result := Copy(Camp, 01, Pos(' ',Camp)-1)
  else
    Result := Camp;
end;

//Busca o SQL do campo pelo nome do campo
//Exemplo: iSele = SELECT PoCaPess.CodiPess AS Chav, POCaPess.NomePess As Pessoa
//         oNome = Pessoa
//     Resultado: POCaPess.NomePess
function PegaSQL_NomeCamp(iSele, iNome: String): String;
var
  i: integer;
  vCamp : String;
begin
  Result := '';
  vCamp := 'a';
  i := 1;
  while vCamp <> '' do
  begin
    vCamp := PegaCampSele(iSele, i);
    if AnsiUpperCase(PegaNomeCamp(vCamp, i, True)) = AnsiUpperCase(iNome) then
    begin
      Result := PegaSQL_Camp(vCamp);
      vCamp := '';
    end;
    inc(i);
  end;
end;

//Passado o FROM, pega a primeira tabela do From
Function PegaTabe(From: String): String;
var
  PosiCros, PosiLeft, PosiInne, PosiRigh: Integer;
begin
  PosiLeft := Pos(' LEFT',AnsiUpperCase(From));
  PosiInne := Pos(' INNER',AnsiUpperCase(From));
  PosiRigh := Pos(' RIGHT',AnsiUpperCase(From));
  PosiCros := Pos(' CROSS',AnsiUpperCase(From));

  if (PosiLeft > PosiInne) and (PosiInne > 0) then
    PosiLeft := PosiInne;

  if (PosiLeft > PosiRigh) and (PosiRigh > 0) then
    PosiLeft := PosiRigh;

  if (PosiLeft > PosiCros) and (PosiCros > 0) then
    PosiLeft := PosiCros;

  if PosiLeft > 0 then  //Existe tabelas relacionadas
    Result := Copy(From, 01, PosiLeft)
  else
    Result := From;
  Result := Trim(SubsPala(Result,'(',''));
  Result := Copy(Result,06,08);
end;

function FunGravTabe_NomeAnti(const iTabe: String): String;
begin
  if FunGravTabe_isSGGE(iTabe) then
    Result := Copy(iTabe.Trim,05,MaxInt)
  else
    Result := iTabe.Trim;
end;

function FunGravTabe_InicAnti(const iTabe: String): String;
begin
  Result := Copy(FunGravTabe_NomeAnti(iTabe),01,02);
end;

function FunGravTabe_Inic(const iTabe: String): String;
begin
  if FunGravTabe_isSGGE(iTabe) then
    Result := Copy(iTabe.Trim,01,06)
  else
    Result := Copy(iTabe.Trim,01,02);
end;

//Retorna o final da Tabela
//iTama: O tamanho do final, normalmente é 4, que seria o sobrenome da tabela para os campos. Mas quando for tabela, usar o MaxInt
function FunGravTabe_Fina(const iTabe: String; const iTama: Integer = 4): String;
begin
  if FunGravTabe_isBkLo(iTabe) then
    Result := Copy(iTabe.Trim,09,iTama)
  else if (FunGravTabe_Tipo(iTabe) = 'LO') then
    Result := 'LOG_'
  else if FunGravTabe_isSGGE(iTabe) then
    Result := Copy(iTabe.Trim,09,iTama)
  else if Length(iTabe.Trim) > 4 then
    Result := Copy(iTabe.Trim,05,iTama)
  else
    Result := iTabe;
end;

function FunGravTabe_Tipo(const iTabe: String): String;
begin
  if FunGravTabe_isBkLo(iTabe) then
    Result := 'LO'
  else if FunGravTabe_isSGGE(iTabe) then
    Result := Copy(iTabe.Trim,07,02).ToUpper
  else
    Result := Copy(iTabe.Trim,03,02).ToUpper;
end;

function FunGravTabe_isSGGE(const iTabe: String): Boolean;
begin
  Result := sgCopy(iTabe.Trim,01,04) = 'SGGE';
end;

function FunGravTabe_isGE(const iTabe: String): Boolean;
begin
  Result := FunGravTabe_Tipo(iTabe) = 'GE';
end;

function FunGravTabe_isBkLo(const iTabe: String): Boolean;
begin
  Result := sgCopy(iTabe.Trim,01,04) = 'BKLO';
end;

//Se a tabela for CA, retorna GE e vice versa
function Troca_CA_GE(iTabe: String): String;
begin
  if FunGravTabe_Tipo(iTabe) = 'GE' then
    Result := FunGravTabe_Inic(iTabe)+'Ca'+FunGravTabe_Fina(iTabe, MaxInt)
  else if FunGravTabe_Tipo(iTabe) = 'CA' then
    Result := FunGravTabe_Inic(iTabe)+'Ge'+FunGravTabe_Fina(iTabe, MaxInt)
  else
    Result := iTabe;
end;

//Retorna o SELECT Puro sem AS
//SELECT NomePess AS Pessoa, FantPess, CodiPess AS Codigo
//SELECT NomePess, FantPess, CodiPess
//Param: Sele: Select
//       NovoAlias: Caso não seja um campo "Puro", adiciona o Alias (Qtde*Unit => Qtde*Unit AS Campo1
function PegaSelePuroSQL(const Sele: String; const iNovoAlias: Boolean = False): String;
var
  Camp: String;
  i, vNumeCamp: Integer;

  function PegaSelePuroSQL_AddAlias(const iCamp: String): String;
  begin
    Result := iCamp;
    if iNovoAlias and (not ContemApenasLetrasNumerosPontos(iCamp)) then
    begin
      Result := iCamp+' AS "Campo'+IntToStr(vNumeCamp)+'"';
      Inc(vNumeCamp);
    end;
  end;

begin
  vNumeCamp := 1;
  Camp := PegaSelePuroSQL_AddAlias(PegaCampManuGene(Sele, 1));
  Result := Camp;
  i := 2;
  while Camp <> '' do
  begin
    Camp := PegaCampManuGene(Sele, i).Trim;
    if Camp <> '' then
    begin
      Result := Result + ', ' +PegaSelePuroSQL_AddAlias(Camp);
    end;
    inc(i);
  end;
end;

//Passado o campo, retorna o nome que pode ser usado no SQL conforme a Base
Function NomeCampSQL(Camp: String):String;
begin
  Result := SubsPala(SubsPala(SubsPala(SubsPala(SubsPala(SubsPala(SubsPala(TiraAcen(Camp),
            ' ','_'),
            '-',''),
            '.',''),
            ')','_'),
            '(','_'),
            '/','_'),
            '%','_')
            ;
end;

//Passado o campo, retorna o nome que pode ser usado no Alias do SQL conforme a Base
Function NomeAliaSQL(Camp: String):String;
begin
//  if GetPBas() = 3 then
//    Result := SubsPala(SubsPala(SubsPala(TiraAcen(Camp),' ','_'),'-',''),'.','')
//  else
  Result := '"'+Camp+'"';
end;

function TratSQL(const TextSQL: string): string;
const
  NumeFunc = 58;
var
  i, Posi : Integer;
  Func: array[1 .. NumeFunc] of String;
  vText, vText1 : String;
begin
  if (GetPBas = 2) and (ansiUpperCase(copy(TextSql,1,6)) <> 'CREATE') then
  begin
    Func[01] := 'AnsiUpper(';
    Func[02] := 'DiveZero(';
    Func[03] := 'Nulo(';
    Func[04] := 'Copy(';
    Func[05] := 'RoundDec(';
    Func[06] := 'Substr(';
    Func[07] := 'RetoPEmp(';
    Func[08] := 'RetoPSis(';
    Func[09] := 'RetoPUsu(';
    Func[10] := 'Fun_';
    Func[11] := 'Pro_';
    Func[12] := 'StrLen(';
    Func[13] := 'ZeroEsqu(';
    Func[14] := 'ZeroDire(';
    Func[15] := 'DiviZero(';
    Func[16] := 'COPY(';
    Func[17] := 'Extenso(';
    Func[18] := 'AddMonth(';
    Func[19] := 'ApliMasc(';
    Func[20] := 'Concat(';
    Func[21] := 'DataMicrSiga(';
    Func[22] := 'DataSQL_Serv(';
    Func[23] := 'DateTimeFormat(';
    Func[24] := 'Dia_Nome(';
    Func[25] := 'EncDate(';
    Func[26] := 'EspaDire(';
    Func[27] := 'EspaEsqu(';
    Func[28] := 'EspaText(';
    Func[29] := 'ExtensoHora(';
    Func[30] := 'NuloStri(';
    Func[31] := 'NumberFormat(';
    Func[32] := 'NumberFormat2(';
    Func[33] := 'NumberFormat3(';
    Func[34] := 'NumberFormat4(';
    Func[35] := 'NumberFormatZero(';
    Func[36] := 'QtdeExtenso(';
    Func[37] := 'RetoGrup(';
    Func[38] := 'RetoPNomUsua(';
    Func[39] := 'RetoZero(';
    Func[40] := 'SGDay(';
    Func[41] := 'SGMonth(';
    Func[42] := 'SGYear(';
    Func[43] := 'TiraAcen(';
    Func[44] := 'TO_Date(';
    Func[45] := 'Trim(';
    Func[46] := 'TruncDec(';
    Func[47] := 'CHR(';
    Func[48] := 'FU_';
    Func[49] := 'TO_Char(';
    Func[50] := 'Length(';
    Func[51] := 'IsDigit(';
    Func[52] := 'sgDayName(';
    Func[53] := 'sDayName(';
    Func[54] := 'Dia_NomeAbre(';
    Func[55] := 'NuloStri2(';
    Func[56] := 'StriPart(';
    Func[57] := 'Trunc(';
    Func[58] := 'Trunc_Date(';

    Result := TextSQL;
    //Para não ser substituido pelo Trim( ficando Ldbo.Trim(
    Result := SubsPalaTudo(Result,'LTRIM(','LTRIM (');
    Result := SubsPalaTudo(Result,'RTRIM(','RTRIM (');
    for I := 1 to NumeFunc do
    begin
      if Trim(Func[i]) <> '' then
      begin
        Result := SubsPalaTudo(Result,'dbo. '+Func[i],'&&xxx&&');
        Result := SubsPalaTudo(Result,'dbo.'+Func[i],'&&xxx&&');
        Result := SubsPalaTudo(Result,Func[i],'&&xxx&&');
        Result := SubsPalaTudo(Result,'&&xxx&&','dbo.'+Func[i]);
      end;
    end;
    Result := SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(Result
                          , '||','+')
                          , ' COLUMN dbo.Pro_',' COLUMN Pro_')
                          , ' COLUMN dbo.FUN_',' COLUMN FUN_')
                          , ' COLUMN dbo.FU_' ,' COLUMN FU_')
                          , ' ADD dbo.Pro_',' ADD Pro_')
                          , ' ADD dbo.FUN_',' ADD FUN_')
                          , ' ADD dbo.FU_' ,' ADD FU_')
                 ;
  end
  else
  begin
    //Tira o Dbo. de outras bases
    Result := SubsPalaTudo(TextSQL,'dbo.','');
  end;

  if GetPBas in [2,3] then  //Fb e SQLServer
  begin

    if (GetPBas = 2) then
    begin

      Posi := System.Pos(String('ROWTOCOL('''),UpperCase(Result));
      while Posi > 0 do
      begin
        vText := Copy(Result, Posi, Length(Result));
        vText := Copy(vText, 01, PosiProxVirg(vText, ')', 09));  //09 = LENGTH('ROWTOCOL(')
        vText1 := vText;
        vText := SubsPalaTudo(vText,'ROWTOCOL(''','(');
        vText := SubsPalaTudo(vText,''','' '')',' FOR XML PATH(''''''))');
        vText := SubsPalaTudo(vText,'''''''+','');
        vText := SubsPalaTudo(vText,'+''''''','');
        vText := SubsPalaTudo(vText,'''''','''');
        vText := SubsPalaTudo(vText,'''+','');
        vText := SubsPalaTudo(vText,'+''','');
        Result := SubsPalaTudo(Result, vText1, vText);
        Posi := System.Pos(String('ROWTOCOL('), UpperCase(Result));
      end;
    end;

    //Tirar os TABLE do ORACLE
    Posi := sgPos('TABLE(', Result);
    while Posi > 0 do
    begin
      Delete(Result, PosiProxVirg(Result, ')', Posi) , 1);
      Result := SubsPalaTudo(Result,'TABLE(','');
      Posi := sgPos('TABLE(', Result);
    end;
    Result := SubsPalaTudo(Result,'VARCHAR2','VARCHAR');
  end;

  Result := SubsPalaTudo(Result,'RETOPUSU(USER)','RETOPUSU()');
  Result := SubsPalaTudo(Result,'RETOPEMP(USER)','RETOPEMP()');
  Result := SubsPalaTudo(Result,'RETOPSIS(USER)','RETOPSIS()');
  if sgPos('UPDATE',Result) = 0 then
  begin
    if sgPos('WHERE',Result) < sgPos(' = NULL)',Result) then
      Result := SubsPalaTudo(Result,' = NULL)',' IS NULL)');
    if sgPos('WHERE',Result) < sgPos(' = NULL ',Result) then
      Result := SubsPalaTudo(Result,' = NULL ',' IS NULL ');
  end;

  if GetPBas = 2 then  //SQLServer
    Result := SubsPalaTudo(Result,'ON 99=99','') //Usado no CROSS APPLY para o Oracle e no SQL Server não precisa
  else if GetPBas = 3 then  //Firebird
  begin
    Result := SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(Result
                ,'GETDATE()','CAST(''TODAY''AS TIMESTAMP)')
                ,'GETDATE','CAST(''TODAY''AS TIMESTAMP)')
                ,'FUN_LOGI(','(')
                ,'TIRAACEN(','(')
                ,'FONE_FORMAT(','(')
                ,'CPF_CNPJ_FORMAT(','(')
                ,'CEP_FORMAT(','(')
                ,'RETOPSIS()','(SELECT VALO FROM PRO_RETOPSIS)')
                ,'RETOPEMP()','(SELECT VALO FROM PRO_RETOPEMP)')
                ,'RETOPUSU()','(SELECT VALO FROM PRO_RETOPUSU)')
                ;
  end
  else if GetPBas = 4 then  //Oracle
  begin
    Result := SubsPalaTudo(Result,'CROSS APPLY','INNER JOIN');
    {$ifdef FD}
      Result := SubsPalaTudo(SubsPalaTudo(Result
                  ,'FROM DUAL' ,'FROM POCAAUXI')
                  ,'FROM  DUAL','FROM POCAAUXI')
                  ;
    {$endif}
  end;

end;

//Organiza o SQL conforme o padrco da SAG
//Linha:
//0-SELECT
//1-FROM
//2, 3 e 4-WHERE
//5-ORDER BY ou GROUP BY
//6-ORDER BY (se tiver GROUP BY)
function OrgaSQL(SQL: String): String;
var
  i: Integer;
//  Maxi: Integer;
  lAux1, lAux2: TStringList;
  Auxi : String;

  function OrgaSQL_BuscProx(Pala, Depo: String): String;
  var
    Posi: Integer;
  begin
    Posi := PosiProxVirg(Auxi, Depo);
    if Posi > 0 then
    begin
      Result := Copy(Auxi, 01, Posi-1);
      Delete(Auxi, 01, Posi-1);
    end
    else
    begin
      Result := Auxi;
      Auxi := '';
    end;

    {if Pos(AnsiUpperCase(Depo), AnsiUpperCase(Auxi)) > 0 then
    begin
      Result := Copy(Auxi, 01, Pos(AnsiUpperCase(Depo), AnsiUpperCase(Auxi))-1);
      Delete(Auxi,01, Pos(AnsiUpperCase(Depo), AnsiUpperCase(Auxi))-1);
    end
    else
    begin
      Result := Auxi;
      Auxi := '';
    end;}
  end;

begin
  lAux1 := TStringList.Create;
  lAux2 := TStringList.Create;
  try
    Auxi := '';
    lAux1.Text := SQL;
    for I := 0 To lAux1.Count-1 do
      Auxi := Auxi + lAux1.Strings[i]+' ';

    lAux2.Add(OrgaSQL_BuscProx('SELECT ','FROM '));
    lAux2.Add(OrgaSQL_BuscProx('FROM ','WHERE '));
    if Pos('GROUP BY ',AnsiUpperCase(Auxi)) > 0 then
      lAux2.Add(OrgaSQL_BuscProx('WHERE ','GROUP BY '))
    else if Pos('HAVING ',AnsiUpperCase(Auxi)) > 0 then
      lAux2.Add(OrgaSQL_BuscProx('WHERE ','HAVING '))
    else
      lAux2.Add(OrgaSQL_BuscProx('WHERE ','ORDER BY '));
    lAux2.Add('');
    lAux2.Add('');
    lAux2.Add(Auxi);

    Result := Trim(lAux2.Text);
  finally
    lAux1.Free;
    lAux2.Free;
  end;
end;

function SQL_RetoFrom(iSQL: String): String;
var
  vSQL_Orga: TStringList;
  i: integer;
  vSele: String;
begin
  vSQL_Orga := TStringList.Create;
  try
    vSQL_Orga.Text := OrgaSQL(iSQL);

    vSele := '';
    Result := '';
    for i := 0 to vSQL_Orga.Count-1 do
    begin
      if sgCopy(vSQL_Orga.Strings[i],01,05) = 'FROM ' then
      begin
        Result := Result+' '+vSQL_Orga.Strings[i];
      end
      else if (sgCopy(vSQL_Orga.Strings[i],01,06) = 'WHERE ') or
              (sgCopy(vSQL_Orga.Strings[i],01,09) = 'ORDER BY ') or
              (sgCopy(vSQL_Orga.Strings[i],01,09) = 'GROUP BY ') or
              (sgCopy(vSQL_Orga.Strings[i],01,07) = 'HAVING ') then
        break
      else
        vSele := vSele + vSQL_Orga.Strings[i];
    end;
  finally
    vSQL_Orga.Free;
  end;
end;

//Verifica se existe o campo na Query
function VeriExisCampTabe(Tabe: TDataSet; Camp: String): Boolean;
{var
  i: Integer;}
begin
  {Camp := AnsiUpperCase(Camp);
  i := 0;
  Result := False;
  while (i < Tabe.Fields.Count) and (not Result) do
  begin
    if AnsiUpperCase(Tabe.Fields[i].FieldName) = Camp then
      Result := True;
    Inc(i);
  end;}
  Result := Tabe.FindField(Camp) <> nil;
end;

//Busca o campo pelo Origin
function BuscCampTabe_Origin(Tabe: TDataSet; iOrigin: String): TField;
var
  i: Integer;
  vNome: String;
begin
  iOrigin := AnsiUpperCase(iOrigin);
  i := 0;
  Result := Nil;
  while (i < Tabe.Fields.Count) and (not Assigned(Result)) do
  begin
    vNome := Tabe.Fields[i].Origin;
    if sgPos('.', vNome) > 0 then
      vNome := Copy(vNome, sgPos('.',vNome)+1, MaxInt);
    if (AnsiUpperCase(vNome) = iOrigin) then
      Result := Tabe.Fields[i];
    Inc(i);
  end;
end;

//Verifica se existe o campo na Query, se existir, retorna o valor, senão, o Padr
function VeriExisCampTabe_Valo(Tabe: TDataSet; Camp, Padr: String): String;
begin
  if VeriExisCampTabe(Tabe, Camp) then
    Result := Tabe.FieldByName(Camp).AsString
  else
    Result := Padr;
end;
//Objetivo: Tirar os Campos passados no SELECT que sco chaves
Function TiraChavSele(Sele : String; Chav : Integer):String;
var
  i, j : integer;
begin
  for i := 1 to Chav do
    if PosiProxVirg(Sele) > 0 then
    begin
      j := PosiProxVirg(Sele);
      Delete(Sele,8,j-7);
    end;
  Result := Sele;
end;

//Procura se tem as palavras no Array dentro do Pala, usando o Pos
Function StrInPos(Pala : String; ArrayStri: Array of String): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Length(ArrayStri)-1 do
    if Pos(UpperCase(ArrayStri[I]), UpperCase(Pala)) > 0 then
    begin
      Result := True;
      Break;
    end;
end;

Function StrIn(Pala : String; ArrayStri: Array of String): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Length(ArrayStri)-1 do
    if UpperCase(ArrayStri[I]) = UpperCase(Pala) then
    begin
      Result := True;
      Break;
    end;
end;

Function NumeroIn(Numero :Real; ArrayNume: Array of Real): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Length(ArrayNume)-1 do
    if ArrayNume[I] = Numero then
    begin
      Result := True;
      Break;
    end;
end;


// Inverter uma Palavra (Exemplo: SAG -> GAS)
Function InvePala(Pala: String): String;
var
  i: Integer;
begin
  result := '';
  for i := Length(Pala) downto 1 do
    result := result + Pala[i];
end;

//Autor: ST: 16/07/2023
//Descr: Retorna Palavra Inicial
function PalaInic(const Text: String; Count: Integer = 1): String;
begin
  Result := Copy(Text, 01, Count);
end;

//Autor: ST: 16/07/2023
//Descr: Retorna Palavra Final
function PalaFina(const Text: String; Count: Integer = 1): String;
begin
  Result := InvePala(Copy(InvePala(Text), 01, Count));
end;

//Autor: ST: 15/07/2023
//Descr: Palavra iniciado e finalizada por
function isPalaInicFinaPor(iPala, iInic, iFina: String): Boolean;
begin
  Result := (Copy(iPala,01,Length(iInic)) = iInic) and (Copy(InvePala(iPala),01,Length(iFina)) = InvePala(iFina));
end;

//Autor: ST: 15/07/2023
//Descr: Palavra iniciado por
function isPalaInicPor(iPala, iInic: String): Boolean;
begin
  Result := (Copy(iPala,01,Length(iInic)) = iInic);
end;

//Autor: ST: 15/07/2023
//Descr: Palavra finalizada por
function isPalaFinaPor(iPala, iFina: String): Boolean;
begin
  Result := (Copy(InvePala(iPala),01,Length(iFina)) = InvePala(iFina));
end;

function PalaContem(iPala, iContem: String): Boolean;
begin
  Result := sgPos(iContem, iPala) > 0;
end;

//Objetivo: Substituir a(s) Palavra(s) (Pala) do Texto (Text) pelo Substituto (Subs), leva em consideração Maisculas e Minisculas
Function SubsPala(Text: String; Pala, Subs: String): String;
begin
  result := StringReplace(Text, Pala, Subs, [rfReplaceAll]);
end;

//Objetivo: Substitui apenas uma Palavra (Pala) do Texto (Text) pelo Substituto (Subs)
Function SubsPalaUma(Text: String; Pala, Subs: String):String;
var
  j : integer;
begin
  if Pos(Pala,Text) > 0 then
  begin
    j := Pos(Pala,Text);
    Delete(Text,j,Length(Pala));
    Insert(Subs,Text,j);
  end;
  Result := Text;
end;

Function SubsPalaTudo(Text: String; Pala, Subs: String): String;
begin
  result := StringReplace(Text, Pala, Subs, [rfReplaceAll, rfIgnoreCase]);
end;

function FastReplace(const aSourceString : String; const aFindString, aReplaceString : String;
   CaseSensitive : Boolean = False) : String;
begin
  if CaseSensitive then
    Result := SubsPala(aSourceString, aFindString, aReplaceString)
  else
    Result := SubsPalaTudo(aSourceString, aFindString, aReplaceString)
end;

//---> Gerar palavras randomicamente com o Número de Caracteres de Nume
Function GeraPala(Nume:Integer):String;
var
  i : Integer;
begin
  Result := '';
  Randomize;
  for i := 1 to Nume do
    Result := Result + Chr(Random(26)+97);
end;

//Objetivo: Tirar a(s) Palavra(s) (Pala) do Texto (Text)
Function TiraPala(Text : String; Pala : String):String;
var
  j : integer;
begin
  Pala := AnsiUpperCase(Pala);
  j := 0;
  while j <= Length(Text) do
  begin
    if Pos(Pala,AnsiUpperCase(Text)) > 0 then
    begin
      j := Pos(Pala,AnsiUpperCase(Text));
      Delete(Text,j,Length(Pala));
    end
    else
      j := Length(Text)+1;
  end;
  Result := Text;
end;

//Autor: ST: 15/07/2023
//Descr: Tirar a Palavra caso esteja no início do Texto
Function TiraPalaInic(const Text, iPala : String):String;
begin
  if isPalaInicPor(Text.ToUpper, iPala.ToUpper) then
    Result := Copy(Text, Length(iPala)+1, MaxInt)
  else
    Result := Text;
end;

//Autor: ST: 15/07/2023
//Descr: Tirar a Palavra caso esteja no Fim do Texto
Function TiraPalaFina(const Text, iPala : String):String;
begin
  if isPalaFinaPor(Text.ToUpper, iPala.ToUpper) then
    Result := Copy(Text, 01, Length(Text)-Length(iPala))
  else
    Result := Text;
end;

//Autor: ST: 15/07/2023
//Descr: Tirar a Palavra caso esteja no Fim do Texto
Function TiraPalaInicFina(const Text, iInic, iFina : String):String;
begin
  Result := TiraPalaInic(Text, iInic);
  Result := TiraPalaFina(Result, iFina);
end;

//---> Contadar as Palavras (Pala) contidas no Texto (Text)
function ContPala(Text:String; Pala:String):Integer;
var
  i : integer;
begin
  i := 0;
  Result := 0;
  Pala := AnsiUpperCase(Pala);
  Text := AnsiUpperCase(Text);
  while i <= Length(Text) do
  begin
    if Pos(Pala,Text) > 0 then
    begin
      i := Pos(Pala,AnsiUpperCase(Text));
      Delete(Text,i,Length(Pala));
      Inc(Result);
    end
    else
      i := Length(Text)+1;
  end;
end;

//Tira repetigues nos texto passado. Ex.: Ovos -> Ovs
Function TiraRepe(Text: String):String;
var
  i : Integer;
begin
  Result := '';
  for i := 1 to Length(Text) do
  begin
    if Pos(Text[i],Result) = 0 then  //Ainda nco existe no Result
      Result := Result + Text[i];
  end;
end;

// Pega a String passado, caso exista uma vmrgula no fim, tira e na penultima vmrgula coloca '' e''
//(Ex.: Pega ''Marcos, Pedro, Joco, '' ou ''Marcos, Pedro, Joco, '' <=> Retorna ''Marcos, Pedro e Joco''
Function TrocVirg(Text: String):String;
var
  i : integer;
  Enco : Boolean;  //Caso ja encontrou a Vmrgula
begin
  if Copy(Text,Length(Text)-1,2) = ', ' then
    Delete(Text,Length(Text)-1,2);
  i := Length(Text);
  Enco := False;
  while i > 0 do
  begin
    if not(Enco) then
    begin
      if Text[i] = ',' then
      begin
        Enco := True;
        Text[i] := ' ';
        Insert('e',Text,i+1);
        Inc(i);
      end;
    end;
    Dec(i);
  end;
  Result := Text;
end;

//Objetivo: Tirar o primeiro abre e fecha parentes ()
Function TiraPare(Text: String):String;
var
  Posi : integer;
begin
  Posi := Pos('(', Text);
  if Posi > 0 then
  begin
    Delete(Text,Posi,01);
    Insert(' ',Text,Posi);

    if Pos(')',Text) > 0 then
    begin
      Text := InvePala(Text);
      Posi := Pos(')',Text);
      Delete(Text,Posi,01);
      Insert(' ',Text,Posi);
      Text := InvePala(Text);
    end;
  end;
  Result := Text;
end;

//Busca o primeiro valor na string, retornando chave e o novo texto pela variavel
function BuscValoChavTextPrim(var Text, Chav: String; Sepa: String = '/'): String;
begin
  if (Text <> '') and (Pos(Sepa,Text) > 0) then
  begin
    Delete(Text,01,Pos(Sepa,Text)-1); //Tira ati o primeiro Sepa
    Chav := Copy(Text, 02, Pos('=',Text)-2);
    Result := BuscValoChavText(Text, Chav, Sepa);
    Delete(Text,01,Pos(Sepa,Text)); //Tira ati o primeiro Sepa (inclusive)

    if (Pos(Sepa,Text) > 0) then //Ainda existe Sepa, deixa a string dele, senco, sera a string
      Delete(Text,01,Pos(Sepa,Text)-1) //Tira ati o primeiro Sepa
    else
      Text := '';
  end
  else
  begin
    Text := '';
    Chav := '';
    Result := '';
  end;
end;

//Pegar um valor de uma string contendo o formato: /Chav=123/, passado a chave, retorna o 123, pode ser passado também o separador: //, +, etc...
function BuscValoChavText(Text, Chav: String; Sepa: String = '/'): String;
var
  Posi: Integer;
begin
  if (Pos('="',Text) > 0) and (Pos('"/',Text) > 0) then
    Result := BuscValoChavTextQuot(Text, Chav, Sepa)
  else
  begin
    Result := '';
    Posi := Pos(AnsiUpperCase(Sepa+Chav+'='), AnsiUpperCase(Text));
    if Posi > 0 then
    begin
      Delete(Text, 01, Posi);  //Tira texto para trás da Chave
      Posi := Pos('=', Text);
      Delete(Text, 01, Posi); //Tira Texto para trás do '='

      Text := SubsPala(Text,Sepa+' ','$$$AAAGGG'); //Quando usado barra, a mesma pode estar numa divisão, aí, se tiver um espaço depois da barra, substituo, depois retorna
      Posi := Pos(Sepa, Text);

      if Posi = 0 then  //Caso não tenha mais o Separador, estamos com o Valor
        Result := Text
      else
        Result := Copy(Text, 1, Posi-1);

      Result := SubsPala(Result,'$$$AAAGGG',Sepa+' ');
    end;
    Result := Trim(Result);
  end;
end;

//Pegar um valor de uma string contendo o formato: /Chav="123"/, passado a chave, retorna o 123, pode ser passado também o separador: //, +, etc...
function BuscValoChavTextQuot(Text, Chav: String; Sepa: String = '/'): String;
var
  Posi: Integer;
begin
  Result := '';
  Posi := sgPos(Sepa+Chav+'="', Text);
  if Posi > 0 then
  begin
    Text := Text + Sepa;
    Delete(Text, 01, Posi);  //Tira texto para trás da Chave
    Posi := Pos('="', Text);
    Delete(Text, 01, Posi+1); //Tira Texto para trás do '='

    Text := SubsPala(Text,Sepa+' ','$$$AAAGGG'); //Quando usado barra, a mesma pode estar numa divisão, aí, se tiver um espaço depois da barra, substituo, depois retorna
    Posi := Pos('"'+Sepa, Text);

    if Posi = 0 then  //Caso não tenha mais o Separador, estamos com o Valor
      Result := Text
    else
      Result := Copy(Text, 1, Posi-1);

    Result := SubsPala(Result,'$$$AAAGGG',Sepa+' ');
  end;
  Result := Result.Trim;
end;

//Retorna zero quando a String for vazia
Function RetoZero(Tipo: String; iPadr: String = '0'): String;
begin
  //if (Trim(Tipo) = '') or (not IsDigit(RetiMasc(Tipo))) then
  if Tipo.Trim = '' then
    Result := iPadr
  else
    Result := Tipo;
end;

function RetiPareIN(Param: string): string;
begin
  Result := TiraPalaInic(Param.Trim, '(');
  Result := TiraPalaFina(Result    , ')');
  Result:= '('+RetoZero(Result)+')';
end;

//Pode ser calculada pelo Exp
Function IsExpressaoNumerica(Valo: String): Boolean;
var
  i : Integer;
begin
  i := 1;
  Result := Valo.Trim <> '';
  while (i <= Length(Valo)) and Result do
  begin
    Result := CharInSet(Valo[i], ['0'..'9',' ','*','/','+','(',')','.','-']);
    Inc(i);
  end;
end;

Function IsDigit(Valo: String): Boolean;
var
  i : Integer;
begin
  i := 1;
  Result := Trim(Valo) <> '';
  while (i <= Length(Valo)) and Result do
  begin
    Result := CharInSet(Valo[i], ['0'..'9']);
    Inc(i);
  end;
end;

Function IsDigitReal(Valo: String): Boolean;
var
  i : Integer;
begin
  i := 1;
  Result := Trim(Valo) <> '';
  while (i <= Length(Valo)) and Result do
  begin
    Result := CharInSet(Valo[i], ['0'..'9','.','-']);
    Inc(i);
  end;
end;

Function IsDigitInteger(Valo: String): Boolean;
var
  i : Integer;
begin
  i := 1;
  Result := Trim(Valo) <> '';
  while (i <= Length(Valo)) and Result do
  begin
    Result := CharInSet(Valo[i], ['0'..'9','-']);
    Inc(i);
  end;
end;

Function IsLetra(Valo: String): Boolean;
var
  i : Integer;
begin
  i := 1;
  Valo := TiraAcen(Valo);
  Result := Trim(Valo) <> '';
  while (i <= Length(Valo)) and Result do
  begin
    Result := CharInSet(Valo[i], ['A'..'Z','a'..'z']);
    Inc(i);
  end;
end;

Function TemLetra(Valo: String): Boolean;
var
  i : Integer;
begin
  Result := False;
  i := 1;
  Valo := TiraAcen(Valo);
  while (i <= Length(Valo)) and (not Result) do
  begin
    Result := CharInSet(Valo[i], ['A'..'Z','a'..'z']);
    Inc(i);
  end;
end;

//Verifica se AlphaNumerico
function IsAlphaNumeric(ToCheck : String) : Boolean;
var
  i: integer;
  Tem_Nume, Tem_Letr: Boolean;
begin
  i := 1;
  Tem_Nume := False;
  while (i <= Length(ToCheck)) and (not Tem_Nume) do
  begin
    Tem_Nume := IsDigit(ToCheck[i]);
    inc(i);
  end;

  i := 1;
  Tem_Letr := False;
  while (i <= Length(ToCheck)) and (not Tem_Letr) do
  begin
    Tem_Letr := IsLetra(ToCheck[i]);
    inc(i);
  end;

  Result := Tem_Nume AND Tem_Letr;
end;

// Deixa caracteres Ascii
Function DeixaAscii(Nome: String):String;
var
  i : Integer;
begin
  Result := '';
  for i := 1 to Length(Nome) do
    if NumeroInRange(Ord(Nome[i]), 0, 255) then
      Result := Result + Nome[i];
end;

// Deixa Letra e Número (0..9, A..Z e a..z)
Function DeixLetrNume(Nome: String):String;
var
  i : Integer;
begin
  Result := '';
  for i := 1 to Length(Nome) do
    if isDigit(Nome[i]) or isLetra(Nome[i]) then
      Result := Result + Nome[i];
end;

//Autor: ST (14/08/2023) ChatGPT
//Descr: Verificar se a String contem apenas Letras/Números/Pontos/Underline (POCaCida.NomeCida)
function ContemApenasLetrasNumerosPontos(const Str: string): Boolean;
var
  i: Integer;
begin
  Result := True; // Assumimos que a string é válida até encontrar um caractere inválido

  for i := 1 to Length(Str) do
  begin
    // Verificar se o caractere é uma letra, número ou ponto
    if not (Ord(Str[i]) in [Ord('A')..Ord('Z'), Ord('a')..Ord('z'), Ord('0')..Ord('9'), Ord('.'), Ord('_')]) then
    begin
      Result := False; // Encontrou um caractere inválido
      Exit; // Sai do loop assim que um caractere inválido for encontrado
    end;
  end;
end;

// Retira qualquer caracter da String, deixando apenas os número de 0 a 9 e o sinal '-' (menos)
Function RetiMasc(Nome: String):String;
var
  i : Integer;
begin
  Result := '';
  for i := 1 to Length(Nome) do
    if isDigitInteger(Nome[i]) then
      Result := Result + Nome[i];
end;

// Retira qualquer caracter da String, deixando apenas os número de 0 a 9
Function RetiMascTota(Nome:String):String;
var
  i : byte;
  Aux : String;
begin
  Aux := '';
  for i := 1 to Length(Nome) do
  if isDigit(Nome[i]) then
    Aux := Aux + Nome[i];
  Result := Aux;
end;

// Retira qualquer caracter da String, deixando apenas os número de 0 a 9 e o "."
Function RetiMascReal(Nome:String):String;
var
  i : byte;
  Aux : String;
begin
  Aux := '';
  for i := 1 to Length(Nome) do
  if IsDigitReal(Nome[i]) then
    Aux := Aux + Nome[i];
  Result := Aux;
end;

// Retira qualquer caracter da String, deixando apenas os número de 0 a 9 e a "," (
Function RetiMascStrToFloat(Nome:String):String;
var
  i : byte;
  Aux : String;
begin
  Aux := '';
  for i := 1 to Length(Nome) do
    if CharInSet(Nome[i], ['0'..'9',FormatSettings.DecimalSeparator,'-']) then
      Aux := Aux + Nome[i];
  Result := Aux;
end;

//Autor: ST (01/09/2023)
//Descr: Tira os caracteres especiais conforme a máscara (depois de cada \)
//Exemp: Text   = 123.456.789-00
//       Mask   = 999\.999\.999\-99
//       Result = 12345678900
function RemoveMasc(const text, mask: string): string;
var
  i, j: Integer;
  barra: Boolean;
begin
  Result := '';

  i := 1; // Índice para percorrer o texto
  j := 1; // Índice para percorrer a máscara
  barra := False; // Indica se o caractere atual está escapado

  while (i <= Length(text)) and (j <= Length(mask)) do
  begin
    //Pode ser que tenha uma \ como caracteres especial, aí será informado o \\
    if (mask[j] = '\') and (not Barra) then
    begin
      barra := True;
    end
    else
    begin
      //Se tinha barra antes e o caracter atual do Texto é igual da Barra, ignora
      if (barra and (text[i] = mask[j])) then
        Inc(i)
      else
      begin
        if i <= Length(text) then
        begin
          Result := Result + text[i];
          Inc(i);
        end;
      end;

      barra := False;
    end;
    Inc(j);
  end;

  while (i <= Length(text)) do
  begin
    Result := Result + text[i];
    Inc(i);
  end;
end;


Function ZeroDire(Pala:String;Tama:Integer;Copi:Boolean=True):String;
begin
  Result := Pala;
  if Length(Trim(Pala)) < Tama then
    Result := Trim(Pala)+Replicate('0',Tama-Length(Trim(Pala)))
  else if Copi then
    Result := Copy(Pala,01,Tama);
end;

Function ZeroEsqu(Pala:String;Tama:Integer;Copi:Boolean=True):String;
begin
  Result := Pala;
  if Length(Trim(Pala)) < Tama then
    Result :=  Replicate('0',Tama-Length(Trim(Pala)))+Trim(Pala)
  else if Copi then
    Result := Copy(Pala,01,Tama);
end;

function Replicate(Text : String; Qtde : Integer):String;
// Objetivo : Repetir Qtde vezes o Text
var
  i : integer;
  Aux : String;
begin
  if Qtde < 0 then
    Qtde := 0;
  Aux := '';
  for i := 1 to Qtde do
    Aux := Aux + Text;
  Result := Aux;
end;

//Usa o Pos, mas como tem muito overload, as vezes não tem como usar o Pos, aí chama essa function
//Usa o UPPER para comparar
function sgPos(iBusc, iText: String): Integer;
begin
  Result := Pos(iBusc.ToUpper, iText.ToUpper);
end;

// --> Quando a Expressão for True retorno o Verd, quando False retorno o Fals
// Igual ao Clipper: if(Condição,Verdade,Falso)
Function Se(Expr: Boolean; Verd, Fals: Variant): Variant;
begin
  if Expr then
    Result := Verd
  else
    Result := Fals;
end;

// --> Quando a Expressão for True retorno o Verd, quando False retorno o Fals
// Igual ao Clipper: if(Condição,Verdade,Falso)
Function SeStri(Expr: Boolean; Verd, Fals: String): String;
begin
  if Expr then
    Result := Verd
  else
    Result := Fals;
end;

// --> Quando a Expressão for True retorno o Verd, quando False retorno o Fals
// Igual ao Clipper: if(Condição,Verdade,Falso)
Function SeInte(Expr: Boolean; Verd, Fals: Integer): Integer;
begin
  if Expr then
    Result := Verd
  else
    Result := Fals;
end;

// --> Quando a Expressão for True retorno o Verd, quando False retorno o Fals
// Igual ao Clipper: if(Condição,Verdade,Falso)
Function SeReal(Expr: Boolean; Verd, Fals: Real): Real;
begin
  if Expr then
    Result := Verd
  else
    Result := Fals;
end;

// --> Quando a Expressão for True retorno o Verd, quando False retorno o Fals
// Igual ao Clipper: if(Condição,Verdade,Falso)
Function SeData(Expr: Boolean; Verd, Fals: TDateTime): TDateTime;
begin
  if Expr then
    Result := Verd
  else
    Result := Fals;
end;

// --> Quando o divisor for '0' retorna '0' senão retorna a divisão
Function DiveZero(Valo, Dive: Real): Real;
begin
  if Dive = 0 then
    Result := 0
  else
    Result := Valo / Dive;
end;

// --> Quando o divisor for '0' retorna '0' senão retorna o resultado do Mod
Function Mod_Zero(Valo, Dive: Integer): Integer;
begin
  if Dive = 0 then
    Result := 0
  else
    Result := Valo Mod Dive;
end;

//Retorna a mascara conforme o Tipo Passado
Function RetoMasc(TpCa: String):String;
var
  vTpCa: String;
begin
  TpCa := AnsiUpperCase(Trim(TpCa));
  vTpCa := TpCa;
  if Pos(';',TpCa) > 0 then
  TpCa := sgCopy(TpCa,01,Pos(';',TpCa)-1);
  {$ifdef ERPUNI}
    if TpCa = 'NMOS' then
      Result := '###,###,###0.00'
    else if TpCa = 'INTE' then
      Result := '###,###,###0'
    else if (Copy(TpCa,01,02) = 'R$') then
    begin
      vTpCa := 'R$';
      Result := '###,###,##0.000000';
    end
  {$else}
    if TpCa = 'NMOS' then
      Result := ',0.00;-,0.00;0; '
    else if TpCa = 'INTE' then
      Result := ',0;-,0;0; '
    else if (Copy(TpCa,01,02) = 'R$') then
    begin
      vTpCa := 'R$';
      Result := ',0.000000;-,0.000000;0; ';
    end
  {$endif}
    else if TpCa = 'UF' then
    begin
      {$ifdef ERPUNI}
        Result := 'aa'
      {$else}
        Result := '>LL;0;_'
      {$endif}
    end
    else if TpCa = 'PLAC' then
    begin
      {$ifdef ERPUNI}
        if NumeroIn(GetConfWeb.CodiPais, [0, 1058]) then  //Brasil
          Result := 'aaa-9a99;1'
//        else if GetConfWeb.CodiPais = 973 then  //Bolivia - POCaPais.CodiPais
//          Result := '9999-aaa;1'
        else
          Result := '';
      {$else}
        if NumeroIn(GetConfWeb.CodiPais, [0, 1058]) then  //Brasil
          Result := '>LLL\-9>a99;1'
//        else if GetConfWeb.CodiPais = 973 then  //Bolivia - POCaPais.CodiPais
//          Result := '9999\->LLL;1'
        else
          Result := '';
      {$endif}
    end
    else if ((Copy(TpCa,01,04) = 'CNPJ') or (Copy(TpCa,01,03) = 'CGC')) and (GetCodiIdio=0) then
    begin
      vTpCa := 'CNPJ';
      Result := '99\.999\.999\/9999\-99;0;_';
    end
    else if (Copy(TpCa,01,03) = 'CPF') and (GetCodiIdio=0) then
    begin
      vTpCa := 'CPF';
      Result := '999\.999\.999\-99;0;_';
    end
    else if (Copy(TpCa,01,03) = 'CEP') then
    begin
      vTpCa := 'CEP';
      Result := '99\.999\-999;0;_';
    end
    else if (Copy(TpCa,01,03) = 'DDD') then
    begin
      vTpCa := 'DDD';
      Result := '\(999\);0;_';
    end
    else if (Copy(TpCa,01,04) = 'FONE') then
    begin
      vTpCa := 'FONE';
      Result := '9999\-9999;0;_';
    end
    else if (Copy(TpCa,01,08) = 'TELEFONE') then
    begin
      vTpCa := 'TELEFONE';
      Result := '\(999\)9999\-9999;0;_';
    end
    else if (Copy(TpCa,01,07) = 'CELULAR') then
    begin
      vTpCa := 'CELULAR';
      Result := '\(999\)99999\-9999;0;_';
    end
    else if (Copy(TpCa,01,03) = 'FAX') then
    begin
      vTpCa := 'FAX';
      Result := '9999\-9999;0;_';
    end
    else if TpCa = 'HORA_MASC' then
    begin
      vTpCa := 'HORA';
      Result := '99\:99;1;_';
    end
    else if TpCa = 'PLANO_MASC' then
    begin
      vTpCa := 'PLANO';
      Result := '99\.99\.99\.99;1;_';
    end
    else if TpCa = 'CC_MASC' then
    begin
      vTpCa := 'CC';
      Result := '99\.99\.99\.99;1;_';
    end
    else if (not TemLetra(TpCa)) or (sgPos('>',TpCa) > 0) then  //Mascara com letra tem >
      Result := vTpCa  //propria máscara
    else
      Result := '';

    if (Result = '') and (sgPos(';',TpCa) > 0) then
      Result := RetoMasc(Copy(TpCa,01,sgPos(';',TpCa)-1));

    if (Pos(';0',Result) > 0) and (Pos(';1',Result) > 0) then
      Result := SubsPala(Result, ';0', ';1');
end;

//Função de espera (como no Pascal)
procedure Delay(msecs:integer);
//var
//  Inic:longint;
begin
  Sleep(msecs);
//  Inic := GetTickCount;
//  repeat
//    Application.ProcessMessages;
//  until ((GetTickCount - Inic) >= Longint(msecs));
end;

//Beep com Tempo
procedure BeepTemp(Veze:integer);
var
  i: Integer;
begin
  Beep;
  for I := 1 to Veze-1 do
  begin
    Delay(500);
    Beep;
  end;
end;

//Tira letras acentuadas, deixando sem as mesmas. Ex.: Salario -> Salario
Function TiraAcen(Text: String):String;
const
  Nume = 17;
type
  TAcen = Record
    Erra: String;
    Cert: String;
  end;
var
  Acen: array [1..Nume] of TAcen;
  i : Integer;
begin
  Acen[01].Erra := 'á';
  Acen[01].Cert := 'a';
  Acen[02].Erra := 'é';
  Acen[02].Cert := 'e';
  Acen[03].Erra := 'í';
  Acen[03].Cert := 'i';
  Acen[04].Erra := 'ó';
  Acen[04].Cert := 'o';
  Acen[05].Erra := 'ú';
  Acen[05].Cert := 'u';
  Acen[06].Erra := 'ã';
  Acen[06].Cert := 'a';
  Acen[07].Erra := 'õ';
  Acen[07].Cert := 'o';
  Acen[08].Erra := 'ñ';
  Acen[08].Cert := 'n';
  Acen[09].Erra := 'â';
  Acen[09].Cert := 'a';
  Acen[10].Erra := 'ê';
  Acen[10].Cert := 'e';
  Acen[11].Erra := 'î';
  Acen[11].Cert := 'i';
  Acen[12].Erra := 'ô';
  Acen[12].Cert := 'o';
  Acen[13].Erra := 'û';
  Acen[13].Cert := 'u';
  Acen[14].Erra := 'ü';
  Acen[14].Cert := 'u';
  Acen[15].Erra := 'ç';
  Acen[15].Cert := 'c';
  Acen[16].Erra := 'º';
  Acen[16].Cert := '.';
  Acen[17].Erra := 'ª';
  Acen[17].Cert := '.';

  Result := Text;
  for i := 1 to Nume do
  begin
    Result := SubsPala(Result, Acen[i].Erra, Acen[i].Cert);
    Result := SubsPala(Result, AnsiUpperCase(Acen[i].Erra), AnsiUpperCase(Acen[i].Cert));
  end;
end;

//Comparar se o texto é terminado pelo segundo parametro
function CompTextTerminado(Busc, Term: String): Boolean;
begin
  Busc := InvePala(Busc);
  Term := InvePala(Term);
  Result := Copy(Busc,01,Length(Term)) = Term;
end;

function Instr(p_busca: string; p_buscado: string; p_inicio: integer; p_incidencia: integer): integer;
var
  v_posi : integer; //guarda última posição encontrada
  v_i : integer; //contador para loop
begin
  v_posi := PosEx(p_buscado, p_busca, p_inicio); //pego a primeira incidencia do que é procurado

  if v_posi <> 0 then //se retornou alguma coisa continuo testando
  begin
    for v_i := 0 to Length(p_busca) do //repito o teste até o final da palavra alvo
    begin
      if PosEx(p_buscado, p_busca, v_posi+1) <> 0 then //se eu encontrar agora partindo da posição encontrada anteriormente guardo a nova posição
         v_posi := PosEx(p_buscado, p_busca, v_posi+1);
      end;
  end;                                                   
  result := v_posi;
end;

function StriPart(ITEXT : String; ICARA : String; IINIC : Integer; IFINA : Integer): String;
var
  I, Contador : Integer;
  InicCopy, FinaCopy : Integer;
BEGIN
  contador := 1;
  FinaCopy := Length(iText);
  InicCopy := 1;
  if IINIC < IFINA then
  begin
    for I := 1 to Length(iText) do
    begin
      if IINIC = 1 then
        InicCopy := 1;
      if Copy(iText,i,1) = iCara then
      begin
        Inc(Contador);
        if (IINIC = contador) and (IINIC > 1) then
          InicCopy := i+1;
        if IFINA = contador then
          FinaCopy := i - InicCopy;
      end;
    end;
  end;
  Result := Copy(ITEXT,InicCopy,FinaCopy);
END;

// Pega uma String passado com um valor REAL e retorna o valor com PONTO
// Ex.: Pega 1.234.456,7890 <=> Retorna 123456.7890)
// Obs.: Esta Fungco ja possui o RetoZero
Function FormPont(Nume: String):String;
var
  i : integer;
  Enco : Boolean;  //Caso ja encontrou o Ponto ou a Virgula
begin
  Nume := RetoZero(Nume);
  i := Length(Nume);
  Enco := False;
  while i > 0 do
  begin
    if not(Enco) then
    begin
      if CharInSet(Nume[i], [',','.']) then
      begin
        Enco := True;
        Nume[i] := '.';
      end;
    end
    else
    begin
      if CharInSet(Nume[i], [',','.']) then
        Delete(Nume,i,01);
    end;
    Dec(i);
  end;
  Result := Nume;
end;

//===> Soma os caracteres (Nzmero no formato de String) retornando um inteiro (iPeso = True soma a posição)
function SomaCara(Cara: String; iPeso: Boolean = False):Integer;
var
  i : Integer;
begin
  Result := 0;
  Cara := RetiMascTota(Cara);
  for i := 1 to Length(Cara) do
    Result := Result + StrToInt(Cara[i]) + SeInte(iPeso, i, 0);
end;

//===> Soma os caracteres convertendo para Ascii
function SomaCaraAscii(Cara: String; iPeso: Boolean = False):Integer;
var
  i : Integer;
begin
  Result := 0;
  for i := 1 to Length(Cara) do
    Result := Result + Ord(Cara[i]) + SeInte(iPeso, i, 0);
end;

//===> Tira mascaras, retozero, etc... e converte para Int
function sgStrToInt(Cara: String):Int64;
begin
  //Result := StrToInt(RetoZero(RetiMasc(Cara)));
  Result := sgStrToInt64(Cara);
end;

//===> Tira mascaras, retozero, etc... e converte para Int
function sgStrToInt64(Cara: String):Int64;
begin
  Result := StrToInt64(RetoZero(RetiMasc(Cara)));
end;

//===> Tira mascaras, retozero, etc... e converte para Float
function sgStrToFloat(Cara: String): Real;
begin
  Result := RoundDec(StrToFloat(RetoZero(RetiMascStrToFloat(Cara))),08);
end;

//===> Coloca AnsiUpper e Trim no Copy
function sgCopy(Cara: String; Inic, Fina: Integer): String;
begin
  Result := AnsiUpperCase(Copy(Trim(Cara), Inic, Fina));
end;

function sgStrToDateTime(const S: string): TDateTime;
begin
  if not TryStrToDateTime(RetoZero(S), Result, FormatSettings) then
  begin
    //Se não conseguir pelo normal (padrão do StrToDateTime), tenta pela rotina personalizada
    Result := VarToDateTime(RetoZero(S));
  end;
end;

//===> Coloca espago em cada Caracter da String -SOMA -> S O M A
function EspaCadaCara(Cara:String):String;
var
  i : Integer;
begin
  Result := '';
  for i := 1 to Length(Cara) do
    Result := Result + Cara[i] + ' ';
end;

function PadL(const S, Pad: string; const Len: integer): string;
var
  SLen, PadLen, PadCount, I: integer;
begin
  if Len <= 0 then
    Result := ''
  else if Pad = '' then
    Result := S
  else begin
    SLen := Length(S);
    if SLen = Len then
      Result := S
    else if SLen > Len then
      Result := Copy(S, SLen - Len + 1, Len)
    else begin
      Result := S;
      PadLen := Length(Pad);
      PadCount := (Len - SLen) div PadLen;

      for I := 1 to PadCount do
        Result := Pad + Result;

      I := Len - (SLen + PadCount * PadLen);
      if I > 0 then
        Result := Copy(Pad, PadLen - I + 1, PadLen) + Result;
    end;
  end;
end;

function PadR(const S, Pad: string; const Len: integer): string;
var
  SLen, PadLen, PadCount, I: integer;
begin
  if Len <= 0 then
    Result := ''
  else if Pad = '' then
    Result := S
  else begin
    SLen := Length(S);
    if SLen = Len then
      Result := S
    else if SLen > Len then
      Result := Copy(S, 1, Len)
    else begin
      Result := S;
      PadLen := Length(Pad);
      PadCount := (Len - SLen) div PadLen;

      for I := 1 to PadCount do
        Result := Result + Pad;

      I := Len - (SLen + PadCount * PadLen);
      if I > 0 then
        Result := Result + Copy(Pad, 1, I);
    end;
  end;
end;

//Presente tambem em I:\SAG\LibD2006\RxLib2006\Units\DateUtil
function TimeInRange(Time, StartTime, EndTime: TDateTime; Inclusive: Boolean): Boolean;
begin
  StartTime := Trunc(Time)+StartTime;
  EndTime   := Trunc(Time)+EndTime;
  if Inclusive then
    result := (Time >= StartTime) and (Time <= EndTime)
  else
    result := (Time > StartTime) and (Time < EndTime);
end;

//Nzmero estiver Inmcio e Final
function NumeroInRange(Nume, Inic, Fina: Real): Boolean;
begin
  Result := (Nume >= Inic) and (Nume <= Fina);
end;

//Retorna o Ano de uma Data
function Year(Data: TDateTime): Integer;
var
  Ano, Mes, Dia: Word;
begin
  DecodeDate(Data, Ano, Mes, Dia);
  Result := Ano;
end;
function sgYear(Data: TDateTime): Integer;
begin
  Result := Year(Data);
end;

//Retorna o Mês de uma Data
function Month(Data: TDateTime): Integer;
var
  Ano, Mes, Dia: Word;
begin
  DecodeDate(Data, Ano, Mes, Dia);
  Result := Mes;
end;
function sgMonth(Data: TDateTime): Integer;
begin
  Result := Month(Data);
end;

//Retorna o Dia de uma Data
function Day(Data: TDateTime): Integer;
var
  Ano, Mes, Dia: Word;
begin
  DecodeDate(Data, Ano, Mes, Dia);
  Result := Dia;
end;
function sgDay(Data: TDateTime): Integer;
begin
  Result := Day(Data);
end;

//Retorna a data a partir da passada do dia da semana desejado (igual do Oracle)
//Por Exemplo: 04/01/2020 é uma quarta
//         se: Dia_Sema = seg ==> 09/01/2020
//             Dia_Sema = qua ==> 11/01/2020
//             Dia_Sema = qui ==> 05/01/2020
//  DaySunday   = 1, sun, dom
//  DayMonday   = 2, mon, seg
//  DayTuesday  = 3, tue, ter
//  DayWednesday= 4, wed, qua
//  DayThursday = 5, thu, qui
//  DayFriday   = 6, fri, sex
//  DaySaturday = 7, sat, sab
function Next_Day(iData: TDateTime; Dia_Sema: String): TDateTime;
const
  SemaBras: array[1..7] of string = ('dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sab');
  SemaIngl: array[1..7] of string = ('sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat');
var
  vDia: Integer;
  vDia_SemaAtua: Integer;
begin
  vDia_SemaAtua := DayOfWeek(iData);
  if IsDigit(Dia_Sema) then
    vDia := StrToInt(Dia_Sema)
  else
  begin
    vDia := AnsiIndexStr(LowerCase(Dia_Sema), SemaBras) + 1;
    if vDia = 0 then
      vDia := AnsiIndexStr(LowerCase(Dia_Sema), SemaIngl) + 1;
  end;

  if vDia > vDia_SemaAtua then
    Result := iData + (vDia_SemaAtua - vDia)
  else
    Result := iData + (vDia + (7 - vDia_SemaAtua));
end;

//Extraido do DateUtils -> DataHora para Milisegundos
function DateTimeToMilliseconds(const ADateTime: TDateTime): Int64;
var
  LTimeStamp: TTimeStamp;
begin
  LTimeStamp := DateTimeToTimeStamp(ADateTime);
  Result := LTimeStamp.Date;
  Result := (Result * MSecsPerDay) + LTimeStamp.Time;
end;

//TTime para Milisegundos
function TimeToMilliseconds(const ADateTime: TDateTime): Int64;
var
  LTimeStamp: TTimeStamp;
begin
  LTimeStamp := DateTimeToTimeStamp(ADateTime);
  Result := LTimeStamp.Time;
end;

//Retornar o dia da Semana escrito, baseado na data passada
Function NomeDia_Sema(Data: TDateTime): String;
const
  DiasSemana: array[1..7] of string = ('Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab');
begin
  Result := DiasSemana[DayOfWeek(Data)];
end;
function Dia_Nome(Data: TDateTime): String;
begin
  Result := NomeDia_Sema(Data);
end;

//Por que o FormStorage nco guarda as data do TRXDatLbl
Function InicDataFormStor(Data: String): TDateTime;
begin
  if Data <> '' then
    Result := StrToDate(FormData(Data))
  else
    Result := Date;
end;

//Passa Mes/Ano Inicial e Mes/Ano final, retorna o número de meses entre os dois
Function DifeEntrMes(Mes_Inic, Ano_Inic, Mes_Fina, Ano_Fina: Integer):Integer;
// Primeiro Vencimento 07/2002
// Mês/Ano Atual 02/2003
// ((((2003-2002)*12)+02)-07)+1
begin
  Result := ((((Ano_Fina - Ano_Inic)*12)+Mes_Fina)-Mes_Inic)+1;
end;

//Retorna os Dias do Mês, conforme o Ano (Para o Fevereiro)
Function DiasMes(Mes: Byte; Ano:Integer):Byte;
begin
  if Mes > 12 then
    Mes := 12;
  if Mes in [04,06,09,11] then
    Result := 30
  else if Mes = 2 then
  begin
    Result := 28;
    if (Ano div 4) = 0 then
      Result := 29;
  end
  else
    Result := 31;
end;

function Mes_PrimDia(iData: TDateTime): TDateTime;
var
  Ano, Mes, Dia: Word;
begin
  DecodeDate(iData, Ano, Mes, Dia);
  Result := EncodeDate(Ano, Mes, 01);
end;

function Mes_UltiDia(iData: TDateTime): TDateTime;
var
  Ano, Mes, Dia: Word;
begin
  DecodeDate(iData, Ano, Mes, Dia);
  Result := EncodeDate(Ano, Mes, DiasMes(Mes, Ano));
end;

//Gera uma senha de 4 digitos, conforme o dia enviado
function GeraSenhDia(iData: TDate) :String;
var
  vData: TDate;
  vDIA_MES : String;
  vD1: Integer;
  vD2: Integer;
  vM1: Integer;
  vM2: Integer;
  vA: Integer;
  vB: Integer;
  vC: Integer;
  vD: Integer;
  vX: Integer;
  vY: Integer;
  vZ: Integer;
  vK: Integer;
begin
  vData := iData;
  vDIA_MES := FormatDateTime('DDMM',vData);
  vD1 := StrToInt(COPY(vDIA_MES,1,1));
  vD2 := StrToInt(COPY(vDIA_MES,2,1));
  vM1 := StrToInt(COPY(vDIA_MES,3,1));
  vM2 := StrToInt(COPY(vDIA_MES,4,1));

  case vD2 of
    0 : vD2 := 5;
    1 : vD2 := 8;
    2 : vD2 := 6;
    3 : vD2 := 9;
    4 : vD2 := 3;
    5 : vD2 := 7;
    6 : vD2 := 2;
    7 : vD2 := 5;
    8 : vD2 := 1;
    9 : vD2 := 0;
  end;
  vA := (vD1 + 5) mod 10;
  vB := (vD2 + 7) mod 10;
  vC := (vM1 + 3) mod 10;
  vD := (vM2 + 8) mod 10;

  vX := (vA + vC + vB) mod 10;
  vY := (vA + vB) mod 10;
  vZ := (vC + vB) mod 10;
  vK := (vD + vA + vB) mod 10;

  result := IntToStr(vX) + IntToStr(vY) + IntToStr(vZ) + IntToStr(vK);
end;

//Pega valores no Registro do Windows
//Tipo (N=Número ou S=String)
function PegaValoRegiWind(Chav, Sequ, Tipo: String): String;
var
  Regi: TRegistry;
begin
  Result := '';
  Regi := TRegistry.Create;
  try
    Regi.RootKey := HKEY_CURRENT_USER;
    if Regi.KeyExists(Chav) then
    begin
      Regi.OpenKey(Chav, false);

      if Regi.ValueExists(Sequ) then
      begin
        if Tipo = 'N' then
          Result := IntToStr(Regi.ReadInteger(Sequ))
        else
          Result := Regi.ReadString(Sequ)
      end;
    end;
  finally
    Regi.Free;
  end;
end;

//Localizar o Arquivo que contém as Configurações das Bases (Retorna o Endereço do Arquivo)
Function LocaArquConfBase(Empr: TStrings): String;
var
  ArquIni: TIniFile;
begin
  Result := '';
  Empr.Clear;
  if FileExists(GetPEndExecOrig()+'Conf.sag') then
    Result := GetPEndExecOrig()+'Conf.sag'
  else
  begin
    Result := PegaValoRegiWind('SAGManager50','Conf.sag','S')+'Conf.sag'; //HKEY_CURRENT_USER
    if not FileExists(Result) then
      Result := PegaValoRegiWind('ERPSAG7','Conf.sag','S')+'Conf.sag'; //HKEY_CURRENT_USER
    if not FileExists(Result) then
    begin
      Empr.Add(GetPNomAbreSoft()+' Informática Ltda.');
      Result := '';
      Exit;
    end;
  end;

  ArquINI := TIniFile.Create(Result);
  try
    ArquINI.ReadSections(Empr);
  finally
    ArquIni.Free;
  end;
end;

//Retorna a conexão em String conforme os parametros passados
Function PegaDadoConfBase_Cone(Empr, EndeArqu, Usua, Senh: String): String;
Var
  ArquIni: TIniFile;
  //DB : TIBDataBase;
  //DBInfo : TIBDataBaseInfo;
  TextCone, Cone: String;
  Base: String;
begin
  Result := '';
  if (EndeArqu = '') or (not FileExists(EndeArqu)) then  //Não achou o Conf.sag
  begin
    SetPBas(3);
    SetPBasTest(False);
    Cone        := 'Provider=IBOLE.Provider.v4;Persist Security Info=False;Character Set=ISO8859_1'+
                   ';Data Source='+GetPEndExec()+'Dados\'+ChangeFileExt(GetPNomExec(),'.gdb');
    TextCone    := Cone + ';Role=UsuaSAG;USER ID=' +Usua+ ';Password='+Senh;
  end
  else
  begin
    ArquINI := TIniFile.Create(EndeArqu);
    try
      SetPBas(ArquINI.ReadInteger(Empr, 'Base', 3));
      SetPBasTest(AnsiUpperCase(ArquINI.ReadString(Empr, 'Tipo', ''))='TESTE');
      SetPBasTC(AnsiUpperCase(ArquINI.ReadString(Empr, 'TC', ''))='S');
      TextCone := ArquINI.ReadString(Empr, 'Conexao', 'Provider=IBOLE.Provider.v4;Persist Security Info=False;Character Set=ISO8859_1;Role=UsuaSAG');
      Base     := ArquINI.ReadString(Empr, 'Database', 'C:\SAG\Dados\SAGManager.gdb');
      TextCone := TextCone + ';Data Source='+ Base;
      if Usua <> '' then
        TextCone := TextCone + ';USER ID='+Usua;
      Cone := TextCone;

      if (AnsiUpperCase(Usua) = 'SYSDBA') and ((Senh = '') or (Senh = ';')) then
       Senh := '.zx.d3#4$'; //Qualquer senha, pois esta deixando entrar sem Senha com o SysDba

      if Senh <> '' then
        TextCone := Cone + ';Password=' + Senh;
    finally
      ArquIni.Free;
    end;
  end;
  Result := TextCone;
end;

//Retorna o tipo de Dados do Campo passado (Tipo) na forma de Genérica
Function TipoDadoUsua(Tipo: TField):String;
begin
  if Tipo.DataType = ftUnknown then
//    Result := 'U'
    Result := 'Desconhecido'
  else if (Tipo.DataType = ftString) or
          (Tipo.DataType = ftFixedChar) or
          (Tipo.DataType = ftWideString) then
  begin
//    Result := 'C'
      if (Tipo.Size in [1,2,3]) then
        Result := 'Char'+IntToStr(Tipo.Size)
      else
        Result := 'Texto'+ZeroEsqu(IntToStr(Tipo.Size),SeInte(Tipo.Size>999,4,3));
  end
  else if (Tipo.DataType = ftInteger) or
          (Tipo.DataType = ftWord) or
          (Tipo.DataType = ftBytes) or
          (Tipo.DataType = ftAutoInc) or
          (Tipo.DataType = ftLargeInt) then
//    Result := 'I'
    Result := 'Inteiro'
  else if (Tipo.DataType = ftFloat) or
          (Tipo.DataType = ftVarBytes) or
          (Tipo.DataType = ftCurrency) then
//    Result := 'N'
    Result := 'Numero'
  else if (Tipo.DataType = ftDate) or
          (Tipo.DataType = ftADT) or
          (Tipo.DataType = ftDateTime) then
//    Result := 'D'
    Result := 'Data'
  else if Tipo.DataType = ftTime then
//    Result := 'H'
    Result := 'Hora'
  else if (Tipo.DataType = ftBlob) then  //Foto
//    Result := 'F'
    Result := 'Foto'
  else if (Tipo.DataType = ftMemo) or
          (Tipo.DataType = ftWideMemo) or
          (Tipo.DataType = ftFmtMemo) or
          (Tipo.DataType = ftOraBlob) then
//    Result := 'M'
    Result := 'Memo'
  else if (Tipo.DataType = ftSmallint) or
          (Tipo.DataType = ftBoolean) then
//    Result := 'S'
    Result := 'SimNao'
  else if (Tipo.DataType = ftBCD) or
          (Tipo.DataType = ftFMTBCD) then
  begin
    if Tipo.Size = 0 then  //Inteiro
      Result := 'Inteiro'
    else
      Result := 'BCD'
  end
  else if Tipo.DataType = ftGraphic then
//    Result := 'G'
    Result := 'Grafico'
  else if (Tipo.DataType = ftParadoxOle) or
          (Tipo.DataType = ftDBaseOle) or
          (Tipo.DataType = ftReference) or
          (Tipo.DataType = ftDataSet) then
//    Result := 'P'
    Result := 'Paradox'
  else if Tipo.DataType = ftTypedBinary then
//    Result := 'E'
    Result := 'Binary'
  else if Tipo.DataType = ftCursor then
//    Result := 'R'
    Result := 'Cursor'
  else if Tipo.DataType = ftArray then
//    Result := 'A'
    Result := 'Array'
  else
    Result := 'Texto040';
end;

//Retorna o tipo de Dados do Campo passado (Tipo) na forma de Genérica (para FieldDefs)
Function TipoDadoUsuaFieldDefs(Tipo: TFieldDef):String;
begin
  if Tipo.DataType = ftUnknown then
//    Result := 'U'
    Result := 'Desconhecido'
  else if (Tipo.DataType = ftString) or
          (Tipo.DataType = ftFixedChar) or
          (Tipo.DataType = ftWideString) then
    Result := 'Texto'
  else if (Tipo.DataType = ftInteger) or
          (Tipo.DataType = ftWord) or
          (Tipo.DataType = ftBytes) or
          (Tipo.DataType = ftAutoInc) or
          (Tipo.DataType = ftLargeInt) then
//    Result := 'I'
    Result := 'Inteiro'
  else if (Tipo.DataType = ftFloat) or
          (Tipo.DataType = ftVarBytes) or
          (Tipo.DataType = ftCurrency) then
//    Result := 'N'
    Result := 'Numero'
  else if (Tipo.DataType = ftDate) or
          (Tipo.DataType = ftADT) or
          (Tipo.DataType = ftDateTime) then
//    Result := 'D'
    Result := 'Data'
  else if Tipo.DataType = ftTime then
//    Result := 'H'
    Result := 'Hora'
  else if (Tipo.DataType = ftBlob) then  //Foto
//    Result := 'F'
    Result := 'Foto'
  else if (Tipo.DataType = ftMemo) or
          (Tipo.DataType = ftWideMemo) or
          (Tipo.DataType = ftFmtMemo) or
          (Tipo.DataType = ftOraBlob) then
//    Result := 'M'
    Result := 'Memo'
  else if (Tipo.DataType = ftSmallint) or
          (Tipo.DataType = ftBoolean) then
//    Result := 'S'
    Result := 'SimNao'
  else if (Tipo.DataType = ftBCD) or
          (Tipo.DataType = ftFMTBCD) then
  begin
    if Tipo.Size = 0 then  //Inteiro
      Result := 'Inteiro'
    else
      Result := 'Numero'
  end
  else if Tipo.DataType = ftGraphic then
//    Result := 'G'
    Result := 'Grafico'
  else if (Tipo.DataType = ftParadoxOle) or
          (Tipo.DataType = ftDBaseOle) or
          (Tipo.DataType = ftReference) or
          (Tipo.DataType = ftDataSet) then
//    Result := 'P'
    Result := 'Paradox'
  else if Tipo.DataType = ftTypedBinary then
//    Result := 'E'
    Result := 'Binary'
  else if Tipo.DataType = ftCursor then
//    Result := 'R'
    Result := 'Cursor'
  else if Tipo.DataType = ftArray then
//    Result := 'A'
    Result := 'Array'
  else
    Result := 'Texto040';
end;

//Retorna o tipo do dado para criar no Banco de Dados (Caso o Tipo = Nil, pega o Dado (Inteiro, Numero, etc...)
Function TipoDadoBanc(Tipo:TField; Dado: String):String;
var
  Tama: String;
begin
  if Tipo <> nil then
    Dado := TipoDadoUsua(Tipo);

  if GetPBas() = 2 then
  begin
    if (Copy(Dado,01,04) = 'Char') or (Copy(Dado,01,04) = 'Text') then
    begin
      if Copy(Dado,01,04) = 'Char' then
        Tama := Copy(Dado,05,01)
      else
        Tama := Copy(Dado,06,Length(Dado)-5);
      Result := 'VarChar('+Tama+')'
    end
    else if Dado = 'Inteiro' then
//      Result := 'INT IDENTITY (1,1)'  Auto-Increment
      Result := 'Int'
    else if Dado = 'Numero' then
      Result := 'Float'
    else if Dado = 'Data' then
      Result := 'DateTime'
    else if Dado = 'Hora' then
      Result := 'DateTime'
    else if Dado = 'Foto' then  //Foto
      Result := 'Image'
    else if Dado = 'Memo' then
      Result := 'Text'
    else if Dado = 'CLOB' then
      Result := 'Text'
    else if Dado = 'SimNao' then
      Result := 'Int'
    else if Dado = 'BCD' then
      Result := 'Float'
    else
      Result := 'Char(40)';
  end
  else if GetPBas() = 3 then
  begin
    if (Copy(Dado,01,04) = 'Char') or (Copy(Dado,01,04) = 'Text') then
    begin
      Result := Dado;
      if (Copy(Dado,01,04) = 'Text') then
      begin
        if isDigit(Copy(Dado,06,04)) then
        begin
          if not(StrToInt(Copy(Dado,06,04)) in [1,2,3,10,15,25,40,60,100,250]) then
             Result := 'VARCHAR('+Copy(Dado,06,04)+')';
        end;
      end;
    end
    else if Dado = 'Inteiro' then
      Result := 'Inteiro'
    else if Dado = 'Numero' then
      Result := 'Duplo'
    else if Dado = 'Data' then
      Result := 'Data'
    else if Dado = 'Hora' then
      Result := 'Hora'
    else if Dado = 'Foto' then  //Foto
      Result := 'BlobFoto'
    else if Dado = 'Memo' then
      Result := 'BlobMemo'
    else if Dado = 'SimNao' then
      Result := 'SimNao'
    else if Dado = 'CLOB' then
      Result := 'BlobMemo'
    else if Dado = 'BCD' then
      Result := 'Duplo'
    else
      Result := 'Texto040';
  end
  else if GetPBas() = 4 then
  begin
    if (Copy(Dado,01,04) = 'Char') or (Copy(Dado,01,04) = 'Text') then
    begin
      if Copy(Dado,01,04) = 'Char' then
        Tama := Copy(Dado,05,01)
      else
        Tama := Copy(Dado,06,Length(Dado)-5);
      if (Tama = '1') or (Tama = '2') or (Tama = '3') then
        Result := 'Char('+Tama+')'
      //else if Tama = '4000' then  //Sidi: 12/07/2013 - Problema entre a tabela
      //  Result := 'CLOB'
      else
        Result := 'VarChar2('+Tama+')';
    end
    else if Dado = 'CLOB' then
      Result := 'CLOB'
    else if Dado = 'Inteiro' then
      Result := 'INT'
    else if Dado = 'Numero' then
      Result := 'Numeric(13,2)'
    else if Dado = 'Data' then
      Result := 'Date'
    else if Dado = 'Hora' then
      Result := 'Time'
    else if Dado = 'Foto' then  //Foto
      Result := 'BLOB'
    else if Dado = 'Memo' then
      Result := 'CLOB'
//      Result := 'BLOB'
    else if Dado = 'SimNao' then
      Result := 'INT'
    else if Dado = 'BCD' then
      Result := 'Numeric(13,2)'
    else
      Result := 'VarChar2(040)'
  end;
end;

//Retorna o tipo de Dados do Campo passado (Tipo) na forma de Caracter
Function TipoDadoCara(Tipo: TField): AnsiChar;
var
  Dado: String;
begin
  Dado := TipoDadoUsua(Tipo);
  if Dado = 'Desconhecido' then
    Result := 'U'
  else if (Copy(Dado,01,04) = 'Char') or (Copy(Dado,01,04) = 'Text') then
    Result := 'C'
  else if Dado = 'Inteiro' then
    Result := 'I'
  else if Dado = 'Numero' then
    Result := 'N'
  else if Dado = 'Data' then
    Result := 'D'
  else if Dado = 'Hora' then
    Result := 'H'
  else if Dado = 'Foto' then  //Foto
    Result := 'F'
  else if Dado = 'Memo' then
    Result := 'M'
  else if Dado = 'SimNao' then
    Result := 'S'
  else if Dado = 'BCD' then
  begin
    if Tipo.Size = 0 then  //Inteiro
      Result := 'I'
    else
      Result := 'N'
  end
  else if Dado = 'Grafico' then
    Result := 'G'
  else if Dado = 'Paradox' then
    Result := 'P'
  else if Dado = 'Binary' then
    Result := 'E'
  else if Dado = 'Cursor' then
    Result := 'R'
  else if Dado = 'Array' then
    Result := 'A'
  else
    Result := 'C';
end;

//Retorna o tipo de Dados do Campo passado (Tipo) na forma de Caracter
Function TipoDadoCaraFieldDefs(Tipo: TFieldDef):AnsiChar;
var
  TipoCamp: String;
begin
  TipoCamp := AnsiUpperCase(TipoDadoUsuaFieldDefs(Tipo));

  if TipoCamp = 'DATA' then
    Result := 'D'
  else if (TipoCamp = 'SIMNAO') or
          (TipoCamp = 'SIMNÃO') then  //Lógico
    Result := 'S'
  else if (TipoCamp = 'NUMERO') or      //Número
          (TipoCamp = 'NÚMERO') or      //Número
          (TipoCamp = 'INTEIRO') then    //Inteiro
    Result := 'I'
  else
    Result := 'C';
end;

//Retorna o tipo de Dados do Campo passado (Tipo) na forma do Delphi
Function TipoDadoDelphi(Tipo: TField):String;
var
  Dado: String;
begin
  Dado := TipoDadoUsua(Tipo);
  if Dado = 'Desconhecido' then
    Result := 'String'
  else if (Copy(Dado,01,04) = 'Char') or (Copy(Dado,01,04) = 'Text') then
    Result := 'String'
  else if Dado = 'Inteiro' then
    Result := 'Int64'
  else if Dado = 'Numero' then
    Result := 'Real'
  else if Dado = 'Data' then
    Result := 'TDateTime'
  else if Dado = 'Hora' then
    Result := 'String'
  else if Dado = 'Foto' then  //Foto
    Result := 'Variant'
  else if Dado = 'Memo' then
    Result := 'String'
  else if Dado = 'SimNao' then
    Result := 'Integer'
  else if Dado = 'BCD' then
  begin
    if Tipo.Size = 0 then  //Inteiro
      Result := 'Integer'
    else
      Result := 'Real'
  end
  else if Dado = 'Grafico' then
    Result := 'Variant'
  else if Dado = 'Paradox' then
    Result := 'Variant'
  else if Dado = 'Binary' then
    Result := 'Variant'
  else if Dado = 'Cursor' then
    Result := 'Variant'
  else if Dado = 'Array' then
    Result := 'Variant'
  else
    Result := 'String';

  if Result = 'Variant' then
    Result := '{$ifdef WS} String {$else} Variant {$endif}';
end;

function TipoDadoFieldType(iTipo: String): TFieldType;
begin
  if iTipo = 'Desconhecido' then
    Result := ftUnknown
  else if sgPos('char', iTipo) > 0 then
    Result := ftString
  else if StrIn(iTipo, ['Texto', 'CLob']) then
    Result := ftString
  else if StrIn(iTipo, ['Inteiro', 'int', 'I', 'B', 'Integer']) then
    Result := ftInteger
  else if StrIn(iTipo, ['Numero', 'N', 'number']) then
    Result := ftFloat
  else if StrIn(iTipo, ['Data', 'D', 'date']) then
    Result := ftDate
  else if iTipo = 'Hora' then
    Result := ftTime
  else if StrIn(iTipo, ['Foto', 'blob']) then
    Result := ftBlob
  else if iTipo = 'Memo' then
    Result := ftMemo
  else if iTipo = 'SimNao' then
    Result := ftSmallint
  else if iTipo = 'BCD' then
    Result := ftBCD
  else if iTipo = 'Grafico' then
    Result := ftGraphic
  else if iTipo = 'Paradox' then
    Result := ftParadoxOle
  else if iTipo = 'Binary' then
    Result := ftTypedBinary
  else if iTipo = 'Cursor' then
    Result := ftCursor
  else if iTipo = 'Array' then
    Result := ftArray
  else
    Result := ftString;
end;

Function ExibDadoQuer(Dts: TDataSet; iVeriTama: Boolean=False; iExibTipo: Boolean=False): String;
var
  i: Integer;
  sAuxi: String;
begin
  sAuxi := '';
  for i := 0 to Dts.FieldCount - 1 do
  begin
    if (TipoDadoBanc(Dts.Fields[i],'') = 'CLOB') or (TipoDadoBanc(Dts.Fields[i],'') = 'BLOB') then
      sAuxi := sAuxi + Dts.Fields[i].FieldName + ' = (' + TipoDadoBanc(Dts.Fields[i],'') +')' +sLineBreak //Evita o erro: Espaço insuficiente de armazenamento para processar este comando
    else
      sAuxi := sAuxi + Dts.Fields[i].FieldName + ' = '+SeStri(Dts.Fields[i].IsNull, 'NULL', Dts.Fields[i].AsString) +
               SeStri(iVeriTama and (Dts.Fields[i].Size > 0),'  // Tamanho: '+FormInteBras(Dts.Fields[i].Size)+SeStri((Dts.Fields[i].Size < Length(Dts.Fields[i].AsString)), '   ***** Real: '+FormInteBras(Length(Dts.Fields[i].AsString)),''),'')+
               SeStri(iExibTipo,'  // Tipo: '+TipoDadoBanc(Dts.Fields[i],''), '')+
               sLineBreak;
  end;
  SetPLblAjud_Capt(sAuxi);
  Result := sAuxi;
end;

//Exibe somente os campos setados para NULL
Function ExibDadoQuer_Nulos(Dts: TDataSet; iVeriTama: Boolean=False; iExibTipo: Boolean=False): String;
var
  i: Integer;
  sAuxi: String;
begin
  sAuxi := '';
  for i := 0 to Dts.FieldCount - 1 do
  begin
    if Dts.Fields[i].IsNull then
    begin
      if (TipoDadoBanc(Dts.Fields[i],'') = 'CLOB') or (TipoDadoBanc(Dts.Fields[i],'') = 'BLOB') then
        sAuxi := sAuxi + Dts.Fields[i].FieldName + ' = (' + TipoDadoBanc(Dts.Fields[i],'') +')' +sLineBreak //Evita o erro: Espaço insuficiente de armazenamento para processar este comando
      else
        sAuxi := sAuxi + Dts.Fields[i].FieldName + ' = '+SeStri(Dts.Fields[i].IsNull, 'NULL', Dts.Fields[i].AsString) +
                 SeStri(iVeriTama and (Dts.Fields[i].Size > 0),'  // Tamanho: '+FormInteBras(Dts.Fields[i].Size)+SeStri((Dts.Fields[i].Size < Length(Dts.Fields[i].AsString)), '   ***** Real: '+FormInteBras(Length(Dts.Fields[i].AsString)),''),'')+
                 SeStri(iExibTipo,'  // Tipo: '+TipoDadoBanc(Dts.Fields[i],''), '')+
                 sLineBreak;
    end;
  end;
  SetPLblAjud_Capt(sAuxi);
  Result := sAuxi;
end;

//Testa se o DataSet nco i nulo, e esta em Edigco ou Insergco
function TestDataSet(Dts: TDataSource): Boolean; overload;
begin
  Result := (Dts <> nil) and (Dts.DataSet <> nil) and (Dts.DataSet.Active) and (Dts.DataSet.State in [dsEdit, dsInsert]);
end;
function TestDataSet(Dts: TDataSet): Boolean; overload;
begin
  Result := (Dts <> nil) and (Dts.Active) and (Dts.State in [dsEdit, dsInsert]);
end;

Procedure SaveCompToStream(AComp:TComponent; AStream:TStream;
                            IncludeData:Boolean=True;
                            TextFormat:Boolean=False);
var tmp      : TComponent;
    OldName  : TComponentName;
    DestStream : TStream;
begin
  DestStream:=AStream;

  if TextFormat then AStream:=TMemoryStream.Create;

  try
    { write the Chart, Series and Tools properties }
    tmp:=AComp;
    if not (csDesigning in AComp.ComponentState) then
    begin
      OldName:=AComp.Name;
      AComp.Name:='';
    end;

    try
      AStream.WriteComponent(AComp);
    finally
    end;

    AComp:=tmp;
    if not (csDesigning in AComp.ComponentState) then
       AComp.Name:=OldName;

    { write the Series data points }
    //if IncludeData then WriteChartData(AStream,AComp);

    if TextFormat then
    begin
      AStream.Position:=0;
      ObjectBinaryToText(AStream,DestStream);
    end;

  finally
    if TextFormat then
       AStream.Free;
  end;
end;

Procedure LoadCompFromStream(Var AComp:TComponent;AStream:TStream);
var tmp     : TComponent;
    tmpName : TComponentName;
    DestStream : TStream;
begin

  { 5.01 commented: This allows saving more things to the AStream
                    before calling here.
  AStream.Position:=0; <--- commented out
  }

  if AStream.Size=0 then
     raise Exception.Create('[MENSSAG]: Arquivo Vazio');

  begin
    DestStream:=AStream;

    AStream:=TMemoryStream.Create;
    ObjectTextToBinary(DestStream,AStream);
    AStream.Position:=0;

    try
      tmp:=AComp;
      try
        tmpName:=tmp.Name; { 5.01 preserve the Chart Name }
      finally
        AComp:=tmp;
      end;

      if tmpName<>'' then
         AComp.Name:=tmpName; { 5.01 set back the same Chart Name }
    finally
    end;
    if DestStream<>AStream then AStream.Free;
  end;
end;

Procedure SaveCompToStream2(AComp:TComponent;aFileName: String);
var
  Stream: TFileStream;
begin
  Stream:=TFileStream.Create(aFileName,fmCreate);
  try
    Stream.WriteComponent(AComp);
  finally
    Stream.Free;
  end;
end;

Procedure LoadCompFromStream2(Var AComp:TComponent;aFileName: String);
var
  Stream: TFileStream;
begin
  try
    Stream:=TFileStream.Create(aFileName,fmOpenRead);
    try
      Stream.ReadComponent(AComp);
    finally
      Stream.Free;
    end;
  except
  end;
end;

//Salva Arquivo
procedure ArquAdicText(Valo: WideString; Ende: WideString);
var
  Fsaida: TextFile;
begin
  AssignFile(Fsaida, Ende);
  if FileExists(Ende) then
    Append(Fsaida)
  else
    Rewrite(Fsaida);
  WriteLn(Fsaida, Valo);
  CloseFile(Fsaida);
end;

//Abre Arquivo
function ArquAbre(Ende: String): WideString;
//var
//  Fentrada:File;
//  NumRead,i:integer;
//  Buf: array[1..2048] of Char;
//  S: WideString;
//begin
//  AssignFile(Fentrada,Ende);
//  Reset(Fentrada,1);
//  S:='';
//  for i:= 1 to FileSize(Fentrada) do
//  begin
//    //Blockread(Fentrada,buf,1,NumRead);
//    System.BlockRead(Fentrada, Buf, SizeOf(Buf), NumRead);
//    S:=S+buf;
//  end;
//  CloseFile(Fentrada);
//  Result := S;
var
  ArquPesq : TextFile;
  Linh : String;
begin
  Result := '';
  AssignFile(ArquPesq, Ende);
  try
    Reset(ArquPesq);                                //Prepara para Leitura
    while not(EOF(ArquPesq)) do
    begin
      ReadLn(ArquPesq, Linh);
      Result := Result + Linh;
    end;
  finally
    CloseFile(ArquPesq);
  end;
end;

//Salva Arquivo
procedure ArquGrav(Valo: WideString; Ende: WideString);
var
  Fsaida: TextFile;
begin
  AssignFile(Fsaida, Ende);
  Rewrite(Fsaida);
  Write(Fsaida, Valo);
  CloseFile(Fsaida);
end;

//Seta o Focus no Componente, caso ele permita
Function SetaFocu(Comp: TWinControl): Boolean;
begin
  Result := True;
  if Assigned(Comp) then
  begin
    Result := Comp.Enabled and Comp.Visible;
    if Result then
    begin
      try
        Comp.SetFocus;
      except
        Result := False;
      end;
    end;
  end;
end;

//Executar linha de comando no MS-DOS
function CreateProcessSimple(cmd: string): boolean;
var
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
begin
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  SUInfo.cb      := SizeOf(SUInfo);
  SUInfo.dwFlags := STARTF_USESHOWWINDOW;
  SUInfo.wShowWindow := SW_HIDE;

  Result := CreateProcess(nil,
                          PChar(cmd),
                          nil,
                          nil,
                          false,
                          CREATE_NEW_CONSOLE or
                          NORMAL_PRIORITY_CLASS,
                          nil,
                          nil,
                          SUInfo,
                          ProcInfo);

  if (Result) then
  begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);

    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end;
end;

//Formata o Inteiro para Brasileiro
Function FormInteBras(Valo: Real):String;
begin
  Result := FormatFloat('###,###,###,##0',Valo);
end;

//Formata o Real para Brasileiro
Function FormRealBras(Valo: Real; Casa:Integer=2):String;
begin
  Result := FormatFloat('###,###,###,##0.'+Replicate('0',Casa),Valo);
end;

//Formata a Data para Brasileira
Function FormDataBras(Data: TDateTime; DigiAno_: Integer = 4):String;
begin
  if DigiAno_ = 4 then
    Result := FormatDateTime('DD/MM/YYYY',Data)
  else
    Result := FormatDateTime('DD/MM/YY',Data);
end;

//Formata a Data e Hora para Brasileira
Function FormDataHoraBras(Data: TDateTime; DigiAno_: Integer = 4):String;
begin
  if DigiAno_ = 4 then
    Result := FormatDateTime('DD/MM/YYYY HH:NN:SS',Data)
  else
    Result := FormatDateTime('DD/MM/YY HH:NN:SS',Data);
end;

//Formata a Data para Brasileira Reduzida a dois digitos no Ano
Function FormDataBrasRedu(Data: TDateTime):String;
begin
  Result := FormatDateTime('DD/MM/YY',Data);
end;

function FormHoraMinuSegu(TempSegu: Integer): String;
var
  Hora, Minu, Segu: Integer;
begin
  Hora := Trunc(TempSegu / 60 / 60);
  Minu := Trunc((TempSegu - (Hora * 60 * 60)) / 60);
  Segu := TempSegu - (Hora * 60 * 60) - (Minu * 60);
  Result := '';
  if Hora > 0 then
    Result := FormInteBras(Hora)+' hs ';
  if Minu > 0 then
    Result := Result + FormInteBras(Minu)+' min ';
  if Segu > 0 then
    Result := Result + FormInteBras(Segu)+' seg';
end;

//Formata a Data para String, conforme a Base de Dados
Function FormDataStri(Data: TDateTime):String;
begin
  if GetPBas() = 5 then
    Result := QuotedStr(FormDataBras(Data))
  else if GetPBas() = 4 then
    Result := QuotedStr(FormDataBras(Data))
  else if GetPBas() = 3 then
    Result := QuotedStr(FormatDateTime('MM/DD/YYYY',Data))
  else if GetPBas() = 2 then
    Result := QuotedStr(FormatDateTime('MM/DD/YYYY',Data))
  else
    Result := FormatDateTime('MM/DD/YYYY',Data);
end;

//Formata a Data para o SQL conforme a Base de Dados
Function FormDataSQL(Data: Variant):String;
begin
  if Data = null then
    Result := 'NULL'
  else
  begin
    Result := FormDataStri(Data);
    if GetPBas() = 4 then
      Result := 'CAST('+ Result + 'AS DATE)'
    else if GetPBas() = 3 then
      Result := 'CAST('+ Result + 'AS TIMESTAMP)'
    else if GetPBas() = 2 then
      Result := 'CONVERT(DATETIME,'+ Result + ')';
  end;
end;

//Retornar a data formatada conforme a base de dados (utilizado no Importa Apanhas e Pesagem de Frango Vivo)
function FormHoraSQL(Data:TDateTime):String;
begin
  if GetPBas() = 1 then
    Result := '"'+DateTimeToStr(Data)+'"'
  else if GetPBas() = 2 then
    Result := 'CAST('''+ FormatDateTime('MM/DD/YYYY hh:nn:ss',Data) + ''' AS DATETIME)'
  else if GetPBas() = 3 then
    Result := 'CAST('''+ FormatDateTime('MM/DD/YYYY hh:nn:ss',Data) + ''' AS TIMESTAMP)'
  else
    //Result := FormDataSQL(Data);  //Confina
    Result := 'TO_DATE('''+FormatDateTime('DD/MM/YYYY hh:nn:ss',Data)+''',''dd/mm/yyyy hh24:mi:ss'')';
end;

//Retornar o caracter de Soma de Caracter conforme o Banco de Dados
function FormSomaCaraSQL(): String;
begin
  Result := SeStri(GetPBas()=2,'+','||');
end;

//Retorna o Tipo de Caracter utilizado pelo comando Like, dependendo da Base
Function FormLikeSQL:String;
begin
  Result := '%'
end;

//Substituir num texto passado a Data Atual pelas datas passadas
function SubsDataAtuaSQL(Text: String; DataInic, DataFina: TDateTime): String;
begin
  Result := SubsPala(Text,   DataAtuaSQL()+'-1', FormDataSQL(DataInic));
  Result := SubsPala(Result, DataAtuaSQL(),      FormDataSQL(DataFina));
  if GetPBas() = 2 then
    Result := SubsPala(Result, ' NULL,NULL ', FormDataStri(DataInic)+','+FormDataStri(DataFina));
end;

//Deixar o Teste conforme for a Base (IIF ou CASE)
function FormCondSQL(Test, Cond, Verd, Fals: String):String;
begin
  Result := '(CASE '+Test+' WHEN '+Cond+' THEN '+Verd+' ELSE '+Fals+' END)';
end;

//Formatar o Cast para String conforme for a Base
function FormCastStriSQL(Valo: String):String;
begin
  if GetPBas() = 4 then
    Result := 'CAST('+Valo+' AS VARCHAR2(2000))'
  else
    Result := 'CAST('+Valo+' AS VARCHAR(2000))';
end;

//Formatar Upper conforme a Base de Dados
Function FormUppeSQL():String;
begin
  if GetPBas() = 4 then
    Result := 'UPPER'
  else if GetPBas() = 2 then
    Result := ''
  else
    Result := 'ANSIUPPER';
end;

//Retornar a parte inteira de um nzmero
Function FormInteSQL:String;
begin
  Result := 'FLOOR';
end;

//Formatar ROUND conforme a Base de Dados
Function FormRounSQL(Valo: String; Casa: String='0'):String;
begin
  if GetPBas() = 4 then
    Result := 'ROUND('+Valo+','+Casa+')'
  else if GetPBas() = 3 then
    Result := 'ROUNDDEC('+Valo+','+Casa+')'
  else if GetPBas() = 2 then
    Result := 'ROUND('+Valo+','+Casa+')'
  else
    Result := 'INT('+Valo+')';
end;

//Formata o Valor passado para o tipo Integer
Function FormCastInteSQL(Valo: String):String;
begin
  Result := 'CAST('+ Valo + 'AS INTEGER)';
end;

//Formata o Valor passado para o tipo Real
Function FormCastRealSQL(Valo: String):String;
begin
  if (GetPBas() = 2) OR (GetPBas() = 4) then
    Result := 'CAST('+ Valo + 'AS Real)'
  else if GetPBas() = 3 then
    Result := 'CAST('+ Valo + 'AS Numeric)'
  else
    Result := Valo;
end;

//Formatar o Operador MOD conforme a Base de Dados e
//Caso seja SQL Server, converte os operadores para INTEGER
Function FormMod_SQL(Ope1, Ope2: String):String;
begin
  if GetPBas() >= 3 then
    Result := 'MOD(CAST('+Ope1+' AS INTEGER),CAST('+Ope2+' AS INTEGER))'
  else if GetPBas() = 2 then
    Result := 'CAST('+Ope1+' AS INTEGER) % CAST('+Ope2+' AS INTEGER)'
  else
    Result := Ope1 + ' MOD ' + Ope2;
end;

//Formatar o DELETE FROM quando possui tabela (Acces = Tabela.*, SQL = Tabela, IB = Tabela)
Function FormDeleSQL:String;
begin
  Result := '';
end;

//Retornar a Data Atual conforme a Base De Dados
Function DataAtuaSQL(): WideString;
begin
  if GetPBas() = 4 then
    Result := 'GETDATE()' //'TO_DATE(SYSDATE)'
  else if GetPBas() = 3 then
    Result := 'CAST(''TODAY''AS TIMESTAMP)'
  else if GetPBas() = 2 then
    Result := 'GETDATE()'
  else
    Result := 'DATE()';
end;

//Retornar a Data Hora Atual conforme a Base De Dados
Function DataHoraAtuaSQL(): String;
begin
  if GetPBas() = 4 then
    Result := 'SYSDATE'
  else if GetPBas() = 3 then
    Result := 'CAST(''NOW'' AS TIMESTAMP)'
  else if GetPBas() = 2 then
    Result := 'GETDATE()';
end;

//Verificar se o Valor i Nulo conforme a Base de Dados
Function FormNuloSQL(Valo: String): String;
begin
  if GetPBas() > 2 then
    Result := 'NULO('+Valo+')'
  else
    Result := 'ISNULL('+Valo+',0)';
end;

//Usar a fungco LEFT conforme for a Base de dados
Function FormLeftSQL(): String;
begin
  if GetPBas() >= 3 then
    Result := 'sgLEFT'
  else
    Result := 'LEFT';
end;

Function FormRightSQL(): String;
begin
  if GetPBas() >= 3 then
    Result := 'sgRIGHT'
  else
    Result := 'RIGHT';
end;

//Usar a fungco DAY conforme for a Base de dados
Function FormDia_SQL(): String;
begin
  if GetPBas() >= 3 then
    Result := 'sgDAY'
  else
    Result := 'DAY';
end;

//Usar a fungco MONTH conforme for a Base de dados
Function FormMes_SQL(): String;
begin
  if GetPBas() >= 3 then
    Result := 'sgMONTH'
  else
    Result := 'MONTH';
end;

//Usar a fungco YEAR conforme for a Base de dados
Function FormAno_SQL(): String;
begin
  if GetPBas() >= 3 then
    Result := 'sgYEAR'
  else
    Result := 'YEAR';
end;

//Formatar no ORACLE para incluir CLOB (String com mais de 4000 caracteres)
//Separa de 4000 em 4000 a string recebida e concatena essas substrings, utilizando a função TO_CLOB
Function FormClobSQL(Valo: String): String;
var
  n, i, posi: Integer;
begin
  Valo := Trim(Valo);
  if Valo = '' then
    Result := 'NULL'
  else if (GetPBas() = 4) and (Length(Valo) > 4000) then
  begin
    Result := '';
    posi   := 1;
    n      := Ceil(Length(Valo)/4000);
    for i := 1 to n do
    begin
      if i = n then
        Result := Result +'TO_CLOB(' +QuotedStr(Copy(Valo, posi, 4000))  +')'
      else
      begin
        Result := Result +'TO_CLOB(' +QuotedStr(Copy(Valo, posi, 4000))  +') || ';
        posi   := 4000*i +1; //Proxima posicao
      end;
    end;
  end
  else
    Result := QuotedStr(Valo);
end;

//Formatar o Nzmero para SQL
Function FormNumeSQL(Valo: Extended): String;
begin
  Result := FormPont(FloatToStr(Valo)); //A função RoundDec não funciona com números muito grandes, exemplo: 1027613203 é convertido em -922337203.685478. FormPont(FloatToStr(RoundDec(Valo,10)));
  if Valo < 0 then
    Result := '('+Result+')';
end;

//Formatar o Nzmero para SQL, caso Zero, retorna NULL
Function FormNumeSQL_Nulo(Valo: Extended): String;
begin
  if Valo = 0 then
    Result := 'NULL'
  else
    Result := FormNumeSQL(Valo);
end;

//Formatar o Nzmero para o sgTableData
Function FormNumeSgTable(Valo: Extended): String;
begin
  Result := FloatToStr(Valo); //A função RoundDec não funciona com números muito grandes, exemplo: 1027613203 é convertido em -922337203.685478. FormPont(FloatToStr(RoundDec(Valo,10)));
end;

Function RoundDec(Valo: Real; Casa: Integer): Real;
var
  LFactor: Double;
begin
  if Valo < 10 then  //Problema do SQLServer com 1-E16
  begin
    if Casa > 6 then
      Casa := 6;

    LFactor := IntPower(10, Casa);
    Result := Trunc((Valo * LFactor) + 0.5);
    //Result := Trunc32((Valo * LFactor) + 0.5);
  end
  else
  begin
    LFactor := IntPower(10, Casa);
    Result := Trunc((Valo * LFactor) + 0.5);
  end;

  Result := Result / LFactor;
//  Result :=  RoundTo(Valo   * Elevado(10,Casa));
//  Result := DiveZero(Result , Elevado(10,Casa));
end;

function sgNull(): String;
begin
  Result := '(NONE)@#$(NONE)';
end;

function IsSGNull(iValo: String): Boolean;
begin
  Result := StrIn(iValo, [sgNull, '']);
end;

function Variant_IsEmptyOrNull(const Value: Variant): Boolean;
begin
  Result := VarIsClear(Value) or VarIsEmpty(Value) or VarIsNull(Value) or (VarCompareValue(Value, Unassigned) = vrEqual);
  if (not Result) and VarIsStr(Value) then
    Result := Value = '';
end;

function Extenso(Valo: Real): String;
begin
  Result := ExtensoPers(Valo,'Real','Reais','Centavo');
end;

function ExtensoPers(Valo: Real; MoedSing, MoedPlur: String; Unid: String = 'Unidade'): String;
var
  Lst: TStringList;
  I: Integer;
  Aux: String;
  Grupo: String;
  Truncado: Longint;

  //Escreve por extenso um numero entre 0 e 999
  function TrataGrupo(const S: String): String;
  const
    Num1a19: array [1..19] of String = (
      'Um', 'Dois', 'Três', 'Quatro', 'Cinco',
      'Seis', 'Sete', 'Oito', 'Nove', 'Dez',
      'Onze', 'Doze', 'Treze', 'Catorze', 'Quinze',
      'Dezesseis', 'Dezessete', 'Dezoito', 'Dezenove');

    Num10a90: array [1..9] of String = (
      'Dez', 'Vinte', 'Trinta', 'Quarenta', 'Cinqüenta',
      'Sessenta', 'Setenta', 'Oitenta', 'Noventa');

    Num100a900: array [1..9] of String = (
      'Cento', 'Duzentos', 'Trezentos', 'Quatrocentos', 'Quinhentos',
      'Seiscentos', 'Setecentos', 'Oitocentos', 'Novecentos');
  var
    N: Integer;

    function Trata0a99(const S: String; N: Integer): String;
    begin
      case N of
        0:
          Result := '';
        1..19:
          Result := Num1a19[N];
        20..99:
        begin
          Result := Num10a90[Ord(S[1]) - Ord('0')];
          if S[2] <> '0' then
            Result := Result + ' e ' + Num1a19[Ord(S[2]) - Ord('0')];
        end;
      end;
    end;

    function Trata101a999(const S: String; N: Integer): String;
    var
      Aux: String;
    begin
      Result := Num100a900[Ord(S[1]) - Ord('0')];
      if (S[2] <> '0') or (S[3] <> '0') then
      begin
        Aux := Copy(S, 2, 2);
        Result := Result + ' e ' + Trata0a99(Aux, StrToInt(Aux));
      end;
    end;

  begin
    N := StrToInt(S);
    case N of
      0..99: Result := Trata0a99(IntToStr(N), N);
      100: Result := 'Cem';
      101..999: Result := Trata101a999(S, N);
    end;
  end;

begin
  Lst := nil;
  Result := '';
  try
    if Valo = 0.0 then
    begin
      Result := 'Zero ' + MoedPlur;
      Exit;
    end;
    Lst := TStringList.Create;
    Grupo := '';
    Aux := FormMascNume(Valo,2);

    // separa em grupos
    for I := 1 to Length(Aux) do
      if (Aux[I] = '.') or (Aux[I] = ',') then
      begin
        Lst.Add(Grupo);
        Grupo := '';
      end
      else
        Grupo := Grupo + Aux[I];
    Lst.Add(Grupo); // inclui o ultimo grupo

    // trata os bilhoes
    I := 0;
    if Lst.Count > 4 then
    begin
      Result := TrataGrupo(Lst[I]);
      if StrToInt(Lst[I]) = 1 then
        Result := Result + ' Bilhão'
      else
        Result := Result + ' Bilhões';
      Inc(I);
    end;

    // trata os milhoes
    if (Lst.Count > 3) then
    begin
      if StrToInt(Lst[I]) <> 0 then
      begin
        if Length(Result) > 0 then
          Result := Result + ', ';
        Result := Result + TrataGrupo(Lst[I]);
        if StrToInt(Lst[I]) = 1 then
          Result := Result + ' Milhão'
        else
          Result := Result + ' Milhões';
      end;
      Inc(I);
    end;

    // trata os milhares
    if Lst.Count > 2 then
    begin
      if StrToInt(Lst[I]) <> 0 then
      begin
        if Length(Result) > 0 then
          Result := Result + ', ';
        Result := Result + TrataGrupo(Lst[I]);
        Result := Result + ' Mil';
      end;
      Inc(I);
    end;

    // trata as unidades
    if StrToInt(Lst[I]) > 0 then
    begin
      if Length(Result) > 0 then
        Result := Result + ' e ';
      Result := Result + TrataGrupo(Lst[I]);
    end;
    Truncado := Trunc(Valo);
    if Truncado = 1 then
      Result := Result + ' ' + MoedSing
    else if (Truncado = 1000000) or
            (Truncado = 10000000) or
            (Truncado = 100000000) or
            (Truncado = 1000000000) then
      Result := Result + ' de ' + MoedPlur
    else if Truncado <> 0 then
      Result := Result + ' ' + MoedPlur;
    Inc(I);

    //Trata os centavos
    if StrToInt(Lst[I]) = 0 then
      Exit;
    if Truncado > 0 then
      Result := Result + ', ';
    Result := Result + TrataGrupo(Lst[I]);
    if StrToInt(Lst[I]) = 1 then
      Result := Result + ' ' + Unid
    else
      Result := Result + ' ' + Unid + 's';
    if Truncado = 0 then
      Result := Result + ' de ' + MoedSing;

  finally
    if Lst <> nil then
      Lst.Free;
  end;
end;

//Colocar mascara nos nzmeros
Function FormMascNume(Valo: Real; Casa: Integer):String;
begin
  Result := FormatFloat('###,###,###,##0'+SeStri(Casa>0,'.'+Replicate('0',Casa),''),Valo);
end;

function FirstLetterToUpperExceptConjunctions(const inputString: string): string;
const
  Conjunctions: array[0..7] of string = ('e', 'ou', 'mas', 'porque', 'se', 'como', 'quando', 'que');
var
  words: TStringList;
  i: Integer;
begin
  words := TStringList.Create;
  try
    words.Delimiter := ' ';
    words.DelimitedText := inputString;
    for i := 0 to words.Count - 1 do
    begin
      if (i > 0) and (AnsiLowerCase(words[i]) <> Conjunctions[0]) and
         (AnsiLowerCase(words[i]) <> Conjunctions[1]) and
         (AnsiLowerCase(words[i]) <> Conjunctions[2]) and
         (AnsiLowerCase(words[i]) <> Conjunctions[3]) and
         (AnsiLowerCase(words[i]) <> Conjunctions[4]) and
         (AnsiLowerCase(words[i]) <> Conjunctions[5]) and
         (AnsiLowerCase(words[i]) <> Conjunctions[6]) and
         (AnsiLowerCase(words[i]) <> Conjunctions[7]) then
      begin
        words[i] := AnsiUpperCase(words[i][1]) + AnsiLowerCase(Copy(words[i], 2, Length(words[i])));
      end;
    end;
    Result := words.DelimitedText;
  finally
    words.Free;
  end;
end;

//Transforma a Primeira Letra em Maizsculo
Function PrimMaisculo(Pala: String): String;
begin
  Result := AnsiLowerCase(Copy(Pala,02,Length(Pala)));
  Result := AnsiUpperCase(Copy(Pala,01,01)) + Result;
end;

//Transforma a Primeira Letra de Cada Palavra em Maiusculo
//Cara: Determina o finalizador de cada palavra, por padrão é o espaço
Function PrimLetrPalaMaisculo(Pala: String; Cara: String = ' '): String;
const
  cCont = 67;
  cPala: array [1..cCont] of String = (
      'CFOP'     , 'CST'     , 'ICMS'    , 'CNPJ'     , 'C.N.P.J',    //05
      'C.N.P.J.' , 'CPF'     , 'C.P.F'   , 'C.P.F.'   , 'CEP',        //10
      'UF'       , 'IPI'     , 'NFe'     , 'ST'       , 'de',         //15
      'da'       , 'do'      , 'das'     , 'dos'      , 'dele',       //20
      'dela'     , 'deles'   , 'delas'   , 'nenhum'   , 'nenhuma',    //25
      'nenhumas' , 'até'     , 'para'    , 'e'        , 'mas',        //30
      'o'        , 'ou'      , 'y'       , 'a'        , 'entretanto', //35
      'ante'     , 'após'    , 'com'     , 'contra'   , 'desde',      //40
      'em'       , 'entre'   , 'para'    , 'per'      , 'perante',    //45
      'por'      , 'sem'     , 'sob'     , 'sobre'    , 'trás',       //50
      'afora'    , 'como'    , 'conforme', 'consoante', 'durante',    //55
      'exceto'   , 'mediante', 'menos'   , 'salvo'    , 'segundo',    //60
      'visto'    , 'NF-e'    , 'CTe'     , 'CT-e'     , 'MDFe',       //65
      'MDF-e'    , 'CNAE');
  Var I, j: Integer;

  procedure PrimLetrPalaMaisculo_Letr;
  var
    vAuxi: String;
  begin
    while I <= Length(Pala) - 1 do
    begin
      if IsLetra(Result[I]) then
      begin
        vAuxi := UpCase(Result[I]);
        vAuxi := AnsiUpperCase(vAuxi);
        Result[I] := vAuxi[1];
        Break;
      end;
      Inc(I);
    end;
  end;

Begin
  Result := AnsiLowerCase(Pala);
  if Result <> '' then
  begin
    I := 1;
    PrimLetrPalaMaisculo_Letr;
    while I <= Length(Pala) - 1 Do
    Begin
      if StrIn(Result[I], [Cara, ' ', '''', '"', '-', '.', ',', '(', '[', '{', '=', '/', '|', '!', '?']) Then
        PrimLetrPalaMaisculo_Letr;

      Inc(I);
    end;

    for j := 1 to cCont do
    begin
      if Result.ToUpper = cPala[j].toUpper then
        Result := cPala[j]
      else
      begin
        if sgPos(' '+cPala[j]+' ', Result) > 0 then
          Result := SubsPalaTudo(Result, ' '+cPala[j]+' ', ' '+cPala[j]+' ');
        if isPalaInicPor(Result.ToUpper, cPala[j].ToUpper+' ') then
          Result := cPala[j]+' '+TiraPalaInic(Result, cPala[j]+' ');
        if isPalaFinaPor(Result.ToUpper, ' '+cPala[j].ToUpper) then
          Result := TiraPalaFina(Result, ' '+cPala[j])+' '+cPala[j];
      end;
    end;
  end;
end;

//Verifica se esta na SAG
//PIsNaSAG: 0-Ainda não verificado, 1-Na SAG e 2-Não na SAG
function GetIsNaSAG(): Boolean;
begin
  if GetConfWeb.PIsNaSAG = 0 then  //Ainda não verificado, verifica
    SetPIsNaSAG();
  Result := GetConfWeb.PIsNaSAG = 1;
  //SetPLblAjud_Capt('Onde: '+IntToStr(PIsNaSAG));
  //Result := False;
end;

function GetOwnerOrac(): String;
begin
  {$IF Defined(Pratica) or Defined(CW) or Defined(DLL_Pratica)}
    Result := 'PRATICA.';
  {$else}
    Result := '';
    {$ifdef UsuaBD}
      if (GetConfWeb.UsuaMaster <> '') and (GetPBas() = 4) then
        Result := GetConfWeb.UsuaMaster.ToUpper+'.';
    {$else}
      if (GetPBas()=4) then
      begin
        if not GetIsNaSAG() then
          Result := AnsiUpperCase(GetPNomAbreSoft())+'.';
      end
      else if (GetPBas()=2) then
      begin
        if isPratic then
          Result := 'sag.dbo.'
        else
          Result := 'dbo.';
      end;
    {$endif}
  {$endif}
end;

function GetOwnerPratica(): String;
begin
  Result := '';
  if isPratic then
    //SidiPrat
    //Result := 'Pratica.dbo.'
    Result := 'PRATICA.'
  else
    Result := '';
end;

function GetSessionCodiPrat(): String;
begin
  Result := '';
  if isPratic then
    Result := 'sys_context(''SAG_USUARIO'', ''CODIPRAT'')'
  else
    Result := '';
end;

//Retornar a função que retorna o Usuário do Banco
function RetoUserBase(): String;
begin
  {$IF Defined(Pratica) or Defined(DLL_Pratica) or Defined(ERPUNI) or Defined(UsuaBD)}
    Result := QuotedStr(GetPApePess());
  {$else}
//    {$ifdef DATASNAP}
//      Result := QuotedStr(GetPApePess());
//    {$else}
      if GetPBas() = 2 then
        Result := 'SYSTEM_USER'
      else
        Result := 'USER';
//    {$endif}
  {$endif}
end;

function GetNomeArquLog_(Adic: String = ''): String;
begin
  Result := GetPEndExec()+'ERP'+GetPNomAbreSoft()+'7'+SeStri(Adic='','','_'+Adic)+'.log';

  {$IFDEF PDADATASNAP}
    Result := GetPEndExec()+'DSServer'+GetPNomAbreSoft()+Adic+'.log';
  {$ELSE}
    {$IFDEF SAGWEBSERVICE}
      Result := GetPEndExec()+'WSServer'+GetPNomAbreSoft()+Adic+'_'+FormatDateTime('HH',Now)+'.log';
    {$ELSE}
      {$IFDEF DLL_ERPSAG7}
        Result := GetPEndExec()+'DLL_ERP'+GetPNomAbreSoft()+'7_'+Adic+'.log';
      {$ELSE}
        {$IFDEF DLL_Pratica}
          Result := GetPEndExec()+'DLL_'+GetPNomAbreSoft()+'_'+Adic+'.log';
        {$ELSE}
          {$IFDEF DLL_MDFE}
            Result := GetPEndExec()+'MDFE_'+Adic+'.log';
          {$ELSE}
            {$IFDEF DLL_TECNOSPEED_BOLETO}
              Result := GetPEndExec()+'SAGTecS_Boleto'+Adic+'.log';
            {$ELSE}
              {$IFDEF FISCAL}
                Result := GetPEndExec()+'SPED_FISCAL'+Adic+'.log';
              {$ELSE}
                {$IFDEF FS_FECH_FISCAL}
                  Result := GetPEndExec()+'FS_FECH_FISCAL'+Adic+'.log';
                {$ELSE}
                  {$IFDEF NFCE_DANFE}
                    Result := GetPEndExec()+'NFCE_DANFE'+Adic+'.log';
                  {$ELSE}
                    {$IFDEF DLL_CTE}
                      Result := GetPEndExec()+'CTE_'+Adic+'.log';
                    {$ELSE}
                      {$IFDEF DLL_NFE_BUSCA}
                        Result := GetPEndExec()+'NFE_BUSCA'+Adic+'.log';
                      {$ELSE}
                        {$IFDEF DLL_NFE_EVENTOS}
                          Result := GetPEndExec()+'NFE_EVENTOS_'+Adic+'.log';
                        {$ELSE}
                          {$IFDEF DLL_SPED_CONTABIL}
                            Result := GetPEndExec()+'SPED_CONTABIL'+Adic+'.log';
                          {$ELSE}
                            {$IFDEF DLL_DIRF}
                              Result := GetPEndExec()+'DIRF'+Adic+'.log';
                            {$ELSE}
                              {$IFDEF DLL_TECNOSPEED_PAGAMENTO}
                                Result := GetPEndExec()+'SAGTecS_Pagamento'+Adic+'.log';
                              {$ELSE}
                                {$IFDEF DLL_SPED_PIS_COFINS}
                                  Result := GetPEndExec()+'SpedPisCofins'+Adic+'.log';
                                {$ELSE}
                                  {$IFDEF DLL_REINF}
                                    Result := GetPEndExec()+'Reinf'+Adic+'.log';
                                  {$ELSE}
                                    {$IFDEF DLL_REAL}
                                      Result := GetPEndExec()+'Real'+Adic+'.log';
                                    {$ELSE}
                                      {$IFDEF DLL_INTEGCOOPAVEL}
                                        Result := GetPEndExec()+'Integracao'+Adic+'.log';
                                      {$ELSE}
                                        {$IFDEF DLL_SUPPLY}
                                          Result := GetPEndExec()+'SAGSupply'+Adic+'.log';
                                        {$ELSE}
                                          {$IFDEF DLL_DIEF}
                                            Result := GetPEndExec()+'DIEF'+Adic+'.log';
                                          {$ELSE}
                                            {$IFDEF DLL_GIA_ICMS}
                                              Result := GetPEndExec()+'GIA_ICMS'+Adic+'.log';
                                            {$ELSE}
                                              {$IFDEF DLL_ApuracaoCredito}
                                                Result := GetPEndExec()+'ApuracaoCredito'+Adic+'.log';
                                              {$ELSE}
                                                {$IFDEF DLL_TERCEIROSAPI}
                                                  Result := GetPEndExec()+'TerceirosAPI_'+Adic+'.log';
                                                {$ELSE}
                                                   {$IFDEF DLL_BBPAG}
                                                      Result := GetPEndExec()+'BBPag'+Adic+'.log';
                                                   {$ELSE}
                                                      {$IFDEF DLL_ArquivoPartidaDobrada}
                                                        Result := GetPEndExec()+'ArquivoPartidaDobrada'+Adic+'.log';
                                                      {$ELSE}
                                                        {$IFDEF DLL_e_CredRural}
                                                          Result := GetPEndExec()+'e_CredRural'+Adic+'.log';
                                                        {$ELSE}
                                                          {$IFDEF DLL_IMP_NFE}
                                                            Result := GetPEndExec()+'Imp_NFe'+Adic+'.log';
                                                          {$ELSE}
                                                            {$IFDEF DLL_LivroCaixa}
                                                              Result := GetPEndExec()+'LivroCaixa'+Adic+'.log';
                                                            {$ENDIF}
                                                          {$ENDIF}
                                                        {$ENDIF}
                                                      {$ENDIF}
                                                   {$ENDIF}
                                                {$ENDIF}
                                              {$ENDIF}
                                            {$ENDIF}
                                          {$ENDIF}
                                        {$ENDIF}
                                      {$ENDIF}
                                    {$ENDIF}
                                  {$ENDIF}
                                {$ENDIF}
                              {$ENDIF}
                            {$ENDIF}
                          {$ENDIF}
                        {$ENDIF}
                      {$ENDIF}
                    {$ENDIF}
                  {$ENDIF}
                {$ENDIF}
              {$ENDIF}
            {$ENDIF}
          {$ENDIF}
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
end;

function GetPLblAjud(): TsgLbl;
begin
  Result := GetConfWeb.PLblAjud;
end;

procedure SetPLblAjud(Valo: TsgLbl);
begin
  GetConfWeb.PLblAjud := Valo;
end;

//iForcGrav: Força Gravar o Log
procedure GravLog_Mens(iMens: String; nProc: Integer = 1; iForcGrav: Boolean = False);
begin
  try
    {$IFNDEF SAGSINC}
    //if (GetPLogTipo() IN [1,3]) and (GetPUsu() <> 0) then
    //if (GetPLogTipo() IN [1,3]) and (IsAdmiSAG or IsAdmiClie) then
    if (GetPLogTipo() IN [1,3]) or iForcGrav then
    {$endif}
    begin
      try
        ArquAdicText(FormatDateTime('dd/mm/yyyy hh:nn:ss:zzz',Now)+' - '+iMens, GetNomeArquLog_(GetPCodPess()));
        if (GetPLogTipo() = 3) or iForcGrav then  //Monitor e Mensagens, os traços para separar um pouco
          ArquAdicText(Replicate('-',40), GetNomeArquLog_(GetPCodPess()));
      except
        if nProc <= 10 then
        begin
          //Aguardo meio segundo e tenta de novo
          Delay(500);
          Inc(nProc);
          GravLog_Mens(iMens, nProc);
        end;
      end;
    end;
    //Application.ProcessMessages;
  except
  end;
end;

procedure SetPLblAjud_Capt(Valo: String);
begin
  if GetConfWeb.PLblAjud <> nil then
  begin
    GetConfWeb.PLblAjud.Caption := Valo;
    GetConfWeb.PLblAjud.Update;
  end;
  GravLog_Mens(Valo);
end;

procedure SetPPrgPrin(Valo: TsgProgBar);
begin
  GetConfWeb.PPrgPrin := Valo;
end;

function GetPPrgPrin(): TsgProgBar;
begin
  if GetConfWeb = nil then
    Result := TsgProgBar.Create(nil)
  else
  begin
    if not Assigned(GetConfWeb.PPrgPrin) then
      GetConfWeb.PPrgPrin := TsgProgBar.Create(nil);
    Result := GetConfWeb.PPrgPrin;
  end;
end;

procedure SetPPrgPri1(Valo: TsgProgBar);
begin
  GetConfWeb.PPrgPri1 := Valo;
end;

function GetPPrgPri1(): TsgProgBar;
begin
  if not Assigned(GetConfWeb.PPrgPri1) then
    GetConfWeb.PPrgPri1 := TsgProgBar.Create(nil);
  Result := GetConfWeb.PPrgPri1;
end;

//Exibir a Mensagem passada na Barra de Mensagens da Janela Principal
procedure ExibMensHint(Mens: String);
begin
  SetPLblAjud_Capt(Mens);
end;

procedure Application_ProcessMessages;
begin
  {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
    {$ifdef ERPUNI}
      UniSession.Synchronize;
    {$else}
      Application.ProcessMessages
    {$endif}
  {$endif}
end;

//Função que executa o Exibir o Progresso na Janela Principal
//ProgTota: Será passado o Progresso total
//Usado pelo ExibProgPrin e ExibProgPri1, o que muda é o componente
function ExibProgPrinFunc(CompProg: TsgProgBar; Valo: Integer = 1; Maxi: Integer = 0; Mens: string = ''; ProgTota: Boolean = False): Boolean;
begin
  Result := False;
  Application_ProcessMessages;

  if Maxi > 0 then  //Se for Maxi, esta começando, inicia tudo
  begin
    CompProg.MaxValue := Maxi;
    CompProg.Progress := 0;
    CompProg.Canc     := False;
    CompProg.Visible  := True;
  end
  else if CompProg.Canc then
  begin
    Result := True;
    CompProg.Visible := False;
    Exit;
  end;

  if Valo = 0 then
    CompProg.Progress := 0
  else if ProgTota then
    CompProg.Progress := Valo
  else
    CompProg.Progress := CompProg.Progress + Valo;

  if CompProg.Tag = 0 then  //Somente altera o Visible do PrgPrin (evita biscação, pois o Segundo progresso, fica acabando a toda hora)
    CompProg.Visible := (CompProg.Progress > 0) and (CompProg.Progress < CompProg.MaxValue);

  CompProg.Update;

  if Mens <> '' then
  begin
    if CompProg.Tag = 1 then  //PrgPri1, pega a mensagem do ProgPrin e soma a dele
      ExibMensHint(GetPPrgPrin.Texto + ' - '+Mens)
    else
      ExibMensHint(Mens);
  end;
  CompProg.Texto := Mens;
end;

//Exibir o Progresso na Janela Principal
//ProgTota: Será passado o Progresso total
function ExibProgPrin(Valo: Integer = 1; Maxi: Integer = 0; Mens: string = ''; ProgTota: Boolean = False): Boolean;
begin
  Result := False;
  {$IFDEF DLL_ERPSAG7}
    if Maxi > 0 then
      MSGAguarde(Mens, 'MAP1', 0, '', '', Maxi)
    else
      MSGAguarde(Mens, 'ATP1', Valo);
    SetPLblAjud_Capt(Mens);  //Para o log
  {$ELSE}
    if Assigned(GetPPrgPrin.Parent) then
    begin
      if Maxi >= 0 then
      begin
        Result := ExibProgPrinFunc(GetPPrgPrin, Valo, Maxi, Mens, ProgTota);
        if Assigned(GetPPrgPrin.Parent) then
          GetPPrgPrin.Parent.Visible := GetPPrgPrin.Visible;
        if GetPPrgPri1.Visible and Assigned(GetPPrgPri1.Parent) then
          GetPPrgPri1.Parent.Visible := GetPPrgPrin.Visible;
      end;
    end else if Mens <> '' then
      SetPLblAjud_Capt(Mens);
  {$ENDIF}
end;


//Exibir o Progresso na Janela Principal (Segundo progresso)
//ProgTota: Será passado o Progresso total
function ExibProgPri1(Valo: Integer = 1; Maxi: Integer = 0; Mens: string = ''; ProgTota: Boolean = False): Boolean;
begin
  Result := False;
  {$IFDEF DLL_ERPSAG7}
    if Maxi >= 0 then
      MSGAguarde(Mens, 'MAP2', 0, '', '', Maxi)
    else
      MSGAguarde(Mens, 'ATP2', Valo);
    SetPLblAjud_Capt(Mens);  //Para o log
  {$ELSE}
    if Assigned(GetPPrgPri1.Parent) then
      Result := ExibProgPrinFunc(GetPPrgPri1, Valo, Maxi, Mens, ProgTota)
    else
      SetPLblAjud_Capt(Mens);
  {$ENDIF}
end;

procedure GravaLogAtualizacao(Valor: String);
begin
  ArquAdicText(FormatDateTime('dd/mm/yyyy hh:nn:ss:zzz',Now)+' -- '+Valor, 'Atualizacao.log');
  ArquAdicText(Replicate('-',40), 'Atualizacao.log');
end;

procedure SetPClientCria(Value: TSGClientDataSet);
begin
  GetConfWeb.PClientCria := Value;
end;

function GetPClientCria(Value: TSGClientDataSet = nil): TSGClientDataSet;
begin
  if Value = nil then
    Result := GetConfWeb.PClientCria
  else
    Result := Value;
end;

function GetPCodMoni(): Integer;
begin
  Result := GetConfWeb.CodiMoni;
end;

function GetConfRela(): TConfRela;
begin
  Result := GetConfWeb.ConfRela;
end;

function CapturaTela: TBitmap;
var
  dc:hdc;
  cv:TCanvas;
begin
  result := TBitmap.Create;
  result.Width := Screen.Width;
  result.Height := Screen.Height;

  dc := GetDc(0);

  cv := TCanvas.Create;
  cv.Handle := DC;
  result.Canvas.CopyRect(Rect(0, 0,Screen.Width,Screen.Height),
                       cv,Rect(0,0,Screen.Width, Screen.Height));
  cv.Free;
  ReleaseDC (0, DC);
end;


function EnumWindowsProc(Wnd : HWnd; ListBox1 : TListBox) : Boolean; Export; StdCall;
var
  Buffer : Array[0..99] of char;
begin
  GetWindowText(Wnd,Buffer,100);
  if StrLen(Buffer) <> 0 then
    ListBox1.Items.Add(StrPas(Buffer));
  Result := True;
end;

Function EnumWindowsProcAber(Wnd: HWND; lb: TStringList): BOOL; stdcall;
//var caption: Array [0..128] of Char;
var Buffer : Array[0..99] of char;
begin
  if IsWindowVisible(Wnd) and
    ((GetWindowLong(Wnd, GWL_HWNDPARENT) = 0) or
    (HWND(GetWindowLong(Wnd, GWL_HWNDPARENT)) = GetDesktopWindow))and
    ((GetWindowLong(Wnd, GWL_EXSTYLE) and WS_EX_TOOLWINDOW) = 0) then
  begin
    GetWindowText(Wnd,Buffer,100);
    if StrLen(Buffer) <> 0 then
      Lb.Add(StrPas(Buffer));
//   SendMessage( Wnd, WM_GETTEXT, Sizeof(caption),integer(@caption));
//   lb.Items.AddObject( caption,TObject( Wnd ));
  end;
  Result := True;
end;

procedure DeleteFiles(Ende: String);
var
  lSearchRec:TSearchRec;
  lFind:integer;
  lPath, APath, AFileSpec:String;
begin
  APath := ExtractFilePath(Ende);
  AFileSpec := ExtractFileName(Ende);
  
  lPath := IncludeTrailingPathDelimiter(APath);

  lFind := FindFirst(lPath+AFileSpec,faAnyFile,lSearchRec);
  while lFind = 0 do
  begin
    DeleteFile(lPath+lSearchRec.Name);

  {$IFDEF ERP6}
    lFind := SysUtils.FindNext(lSearchRec);
  {$ELSE}
    lFind := System.SysUtils.FindNext(lSearchRec);
  {$ENDIF}
  end;
  FindClose(lSearchRec);
end;

function GetURLFilename(const FilePath:String; Const Delimiter:String='/'):String;
  var I: Integer;
begin
  I := LastDelimiter(Delimiter, FilePath);
  Result := Copy(FilePath, I + 1, MaxInt);
end;

Function VerificaSerialDesenv():Boolean;
begin
  if SerialNum('C') = 'A8A541E9' then //VM Xe7 Nova Sidiney
    GetConfWeb.PIsSAG_Dese := 1
  else if SerialNum('C') = '9E70B088' then //Notebook Asus Sidiney
    GetConfWeb.PIsSAG_Dese := 1
  else if SerialNum('C') = '2890BEB9' then //Vm Xe7Novo
    GetConfWeb.PIsSAG_Dese := 1
  else if SerialNum('C') = '707BEA42' then //Servidor - Alexandre
    GetConfWeb.PIsSAG_Dese := 1
  else if GetConfWeb.PIsSAG_Dese = 0 then
    IsSAG();
  Result := GetConfWeb.PIsSAG_Dese = 1;
end;

Function VerificaSerialGerencia():Boolean;
begin
  Result := StrIn(SerialNum('C'), ['A8A541E9' //VM Xe7 Nova Sidiney
                                  ,'9E70B088' //Notebook Asus Sidiney
                                  ,'A49AECFA' //Alexandre
                                  ,'707BEA42' //Servidor - Alexandre
                                  ,'2890BEB9' //Vm Xe7Novo
                                  ,'14BFA458' //Fabiano
                                  ]);
end;

function IsERPSAG_Desenv(iUsua: String = ''): Boolean;
begin
  Result := (iUsua.ToUpper = 'ERPSAG_DESENV') or
            (GetPApePess().ToUpper = 'ERPSAG_DESENV') or
            (GetConfWeb.UsuaMaster.ToUpper = 'ERPSAG_DESENV');
end;

Function VerificaSerialCons():Boolean;
begin
  if GetConfWeb.PIsSAG_Cons = 0 then
    IsSAG();
  Result := GetConfWeb.PIsSAG_Cons = 1;
end;

Function VerificaSerialSupo():Boolean;
begin
  if GetConfWeb.PIsSAG_Supo = 0 then
    IsSAG();
  Result := GetConfWeb.PIsSAG_Supo = 1;
end;

Function VerificaSerialAdm():Boolean;
begin
  if GetConfWeb.PIsSAG_Adm = 0 then
    IsSAG();
  Result := GetConfWeb.PIsSAG_Adm = 1;
end;

Function VerificaSerialCome():Boolean;
begin
  if GetConfWeb.PIsSAG_Come = 0 then
    IsSAG();
  Result := GetConfWeb.PIsSAG_Come = 1;
end;

Function GetSenhAdm():String;
begin
  Result := GetConfWeb.PIsSAG_SenhAdm;
end;

Function GetSenhMast():String;
begin
  Result := GetConfWeb.PIsSAG_SenhMast;
end;

Function VerificaSerialSenh():Boolean;
begin
  if GetConfWeb.PIsSAG_Senh = 0 then
    IsSAG();
  Result := GetConfWeb.PIsSAG_Senh = 1;
end;

Function VerificaSerialSecr():Boolean;
begin
  if GetConfWeb.PIsSAG_Secr = 0 then
    IsSAG();
  Result := GetConfWeb.PIsSAG_Secr = 1;
end;

//Verifica se é uma máquina da SAG
function IsSAG(): Boolean;
const
  NomeEqui = 'Equipe7';
var
  Auxi: TStringList;
  Equipe: String;
  js:TlkJSONobject;
  itjs: TlkJSONobject;
  ii  : integer;
  Mac_, SerC: String;
begin
  if GetConfWeb.PIsSAG = 0 then
  begin
    GetConfWeb.PIsSAG := 2;
    GetConfWeb.PIsSAG_Dese := 2;
    GetConfWeb.PIsSAG_Cons := 2;
    GetConfWeb.PIsSAG_Adm  := 2;
    GetConfWeb.PIsSAG_Come := 2;
    GetConfWeb.PIsSAG_Supo := 2;
    GetConfWeb.PIsSAG_Secr := 2;
    GetConfWeb.PIsSAG_Senh := 2;
    if FileExists(GetPEndExec()+NomeEqui+'.sag') then
    begin
      Auxi := TStringList.Create;
      try
        Des_CripArqu(GetPEndExec()+NomeEqui+'.sag',GetPEndExec()+NomeEqui+'.rar','equipe123');
        Auxi.LoadFromFile(GetPEndExec()+NomeEqui+'.rar');
        Equipe := Auxi.Text;
        DeleteFile(GetPEndExec()+NomeEqui+'.rar');

        //SetPLblAjud_Capt(Equipe);
        if Equipe <> '' then
        begin
          Mac_ := AnsiUpperCase(ListAdaptadores.ListMac_());
          SetPLblAjud_Capt('Mac: '+Mac_);
          //MessageDlg(Mac_, mtInformation, [mbOK], 0);
          SerC := PegaSeri('C');
          SetPLblAjud_Capt('SerieC: '+SerC);

          try
            js := TlkJSON.ParseText(Equipe) as TlkJsonObject;
            for ii:=0 to js.Field['result'].Count-1 do
            begin
              itjs := (js.Field['result'].Child[ii] as TlkJSONobject);

              if (Pos(AnsiUpperCase(DeixLetrNume(itjs.getString('Mac1'))), '001122334455') > 0) then
                GetConfWeb.PIsSAG_SenhMast := itjs.getString('SenhaMaster')
              else
              begin
                Result := (Pos(AnsiUpperCase(DeixLetrNume(itjs.getString('Mac1'))),   DeixLetrNume(Mac_)) > 0) and
                          (Pos(AnsiUpperCase(DeixLetrNume(itjs.getString('SerieC'))), DeixLetrNume(SerC)) > 0);

                if Result then
                begin
                  SetPLblAjud_Capt('Pessoa: '+itjs.getString('Pessoa'));
                  GetConfWeb.PIsSAG := 1;
                  GetConfWeb.PIsSAG_Dese := SeInte(itjs.getString('Desenv')='S',1,2);
                  GetConfWeb.PIsSAG_Secr := SeInte(itjs.getString('Secre') ='S',1,2);
                  GetConfWeb.PIsSAG_Senh := SeInte(itjs.getString('Senha') ='S',1,2);
                  GetConfWeb.PIsSAG_Supo := SeInte(itjs.getString('Suporte')='S',1,2);
                  GetConfWeb.PIsSAG_Cons := SeInte(itjs.getString('Cons')  ='S',1,2);
                  GetConfWeb.PIsSAG_Adm  := SeInte(itjs.getString('Adm')   ='S',1,2);
                  GetConfWeb.PIsSAG_Come := SeInte(itjs.getString('Comercial')='S',1,2);
                  GetConfWeb.PIsSAG_SenhAdm := itjs.getString('SenhaAdm');
                  Break;
                end;
              end;
            end;
            js.Free;
          except
          end;
        end;
      finally
        Auxi.Free;
      end;
    end;
  end;
  Result := GetConfWeb.PIsSAG = 1;
end;

//Busca no equipe.sag
//iBuscCamp: Campo para buscar (mac1, pessoa, Seriec)
//iBuscValo: Valor para comparar com o iBuscCamp
//iCamp: Campo que será retornado (NomeMaquina, SenhaADM, etc)
function BuscEquipeSAG(iBuscCamp, iBuscValo, iCamp: String): String;
const NomeEqui = {$IFDEF ERP6} 'Equipe' {$else} 'Equipe7' {$ENDIF};
var
  Auxi: TStringList;
  Equipe: String;
  js:TlkJSONobject;
  itjs: TlkJSONobject;
  ii  : integer;
begin
  Result := '';
  if FileExists(GetPEndExec()+NomeEqui+'.sag') then
  begin
    Auxi := TStringList.Create;
    try
      Des_CripArqu(GetPEndExec()+NomeEqui+'.sag',GetPEndExec()+NomeEqui+'.rar','equipe123');
      Auxi.LoadFromFile(GetPEndExec()+NomeEqui+'.rar');
      Equipe := Auxi.Text;
      DeleteFile(GetPEndExec()+NomeEqui+'.rar');

      if Equipe <> '' then
      begin
        try
          js := TlkJSON.ParseText(Equipe) as TlkJsonObject;
          for ii:=0 to js.Field['result'].Count-1 do
          begin
            itjs := (js.Field['result'].Child[ii] as TlkJSONobject);

            if (AnsiUpperCase(itjs.getString(iBuscCamp)) = AnsiUpperCase(iBuscValo)) then
            begin
              SetPLblAjud_Capt('Pessoa: '+itjs.getString('Pessoa'));
              Result := itjs.getString(iCamp);
              Break;
            end;
          end;
          js.Free;
        except
        end;
      end;
    finally
      Auxi.Free;
    end;
  end;
end;

Function SerialNum(FDrive:String) :String;
begin
  Result := PegaSeri(FDrive);
end;

//Retorna o IP da maquina Local
function PegaIP:String;
{$ifndef PRATICA}
  var
    IPW: TIdIPWatch;
{$endif}
begin
  {$ifndef PRATICA}
    try
      Result := '127.0.0.1';
      IpW := TIdIPWatch.Create(nil);
      try
        if IpW.LocalIP <> '' then
          Result := IpW.LocalIP;
      finally
        IpW.Free;
        DeleteFile(GetPEndExec()+'iphist.dat');
      end;
    except
      // CHAMADO 125.753
      // Incluído tratamento de exceção para quando tentar abrir uma nova instância do SAG pelo ícone da barra de tarefas
      // não ocorrer o erro 'Cannot create file "C:\Windows\system32\iphist.dat". Access is denied' que acontece em algumas versões do windows
    end;
  {$endif}
end;

function PegaMaqu: String;
// Retorna o nome do computador
var
  lpBuffer : PChar;
  nSize    : DWord;
const Buff_Size = MAX_COMPUTERNAME_LENGTH + 1;
  begin
  try
    nSize    := Buff_Size;
    lpBuffer := StrAlloc(Buff_Size);
    GetComputerName(lpBuffer,nSize);
    Result   := String(lpBuffer);
    StrDispose(lpBuffer);
  except
    Result := '';
  end;
end;

//Retorna o Usuário do Windows
function PegaUsuaWind: String;
//var
//  vobjRegistro : TRegistry;
//begin
//  vobjRegistro := TRegistry.Create;
//  try
//    case Win32Platform of
//      VER_PLATFORM_WIN32_WINDOWS:
//      begin // Windows 9x
//          vobjRegistro.RootKey := HKEY_LOCAL_MACHINE;
//          if vobjRegistro.OpenKey('\Network\Logon', True) then
//            Result := vobjRegistro.ReadString('username');
//      end;
//      VER_PLATFORM_WIN32_NT:
//      begin // Windows XP
//        vobjRegistro.RootKey := HKEY_CURRENT_USER;
//        if vobjRegistro.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer', True) then
//          Result := vobjRegistro.ReadString('Logon User Name');
//      end;
//    end;
//  finally
//    vobjRegistro.Free;
//  end;
var
  Size: DWord;
begin
  // retorna o login do usuário do sistema operacional
  Size := 1024;
  SetLength(result, Size);
  GetUserName(PChar(result), Size);
  SetLength(result, Size - 1);
end;

// Tamanho Total da Memória física em bytes
Function MemoTota : Longint;
var
  MemoStat: TMemoryStatus;
  Tama : Longint;
begin
  try
    GlobalMemoryStatus(MemoStat);
    Tama := MemoStat.dwTotalPhys;
  except
    Tama := 0;
  end;
  Result := Tama;
end;

// Memória física Livre (em bytes)
Function MemoLivr : Longint;
var
  MemoStat: TMemoryStatus;
  Tama : Longint;
begin
  try
    GlobalMemoryStatus(MemoStat);
    Tama := MemoStat.dwAvailPhys;
  except
    Tama := 0;
  end;
  Result := Tama;
end;

// Percentual de memória física em Uso
Function Memo_Uso : Longint;
var
  MemoStat: TMemoryStatus;
  Tama : Longint;
begin
  try
    GlobalMemoryStatus(MemoStat);
    Tama := MemoStat.dwMemoryLoad;
  except
    Tama := 0;
  end;
  Result := Tama;
end;

//--> Pega o número do HD
Function PegaSeri(FDrive:String=''): String;
var
  NomeVolu, SistArqu : String;
  NumeSeri, Flag, TamaMaxi : DWord;
begin
  SetLength(NomeVolu, 255);
  SetLength(SistArqu, 255);
  if FDrive = '' then
    FDrive := GetPEndExec()+'\'
  else
  begin
   if (Pos(':',FDrive) = 0) then
     FDrive := FDrive + ':';
   if (Pos('\',FDrive) = 0) then
     FDrive := FDrive + '\';
  end;


  GetVolumeInformation(PChar(FDrive),pChar(NomeVolu),255,@NumeSeri,TamaMaxi,Flag,pChar(SistArqu),255);
  Result := IntToHex(NumeSeri,8);
end;

//Objetivo: Criptograr a String passada como parâmetro, retornado numeros
function CripNume(Pala:String):String;
var
  Tama : integer;
  Cont: Integer;
  ArraOrde: Array of Integer;
  ArraChar: Array of String;
  Part1, Tota: Integer;
begin
  Tama := Length(Pala);
  Tota := Tama;
  SetLength(ArraOrde, Tota+1);
  Part1 := Tota div 2;

  for Cont := 1 to Tota do
    ArraOrde[Cont] := Ord(Pala[Cont]);

  SetLength(ArraChar, Tota+1);
  for Cont := 1 to Part1 do
    ArraChar[Cont] := ZeroEsqu(IntToStr(ArraOrde[Cont]+ArraOrde[Tota-Cont+1]),04);

  for Cont := Part1+1 to Tota do
    ArraChar[Cont] := ZeroEsqu(IntToStr((ArraOrde[Cont] * 2)),04);

  Result := '';
  for Cont := 1 to Tota do
    Result := Result + ArraChar[Cont];
end;

//Objetivo: DesCriptograr a String passada como parâmetro sendo números
function Des_CripNume(Pala:String):String;
var
  i, Tama : integer;
  Cont: Integer;
  ArraOrde: Array of Integer;
  ArraChar: Array of Char;
  Part1, Tota: Integer;
begin
  Tama := Length(Pala);
  Tota := Tama div 4;
  SetLength(ArraOrde, Tota+1);
  Part1 := Tota div 2;

  i := 1;
  Cont := 1;
  while i <= Tama do
  begin
    ArraOrde[Cont] := StrToInt(RetiMascTota(RetoZero(Copy(Pala,i,4))));
    Inc(i,4);
    Inc(Cont);
  end;

  SetLength(ArraChar, Tota+1);
  for Cont := Part1+1 to Tota do
  begin
    ArraChar[Cont] := char((ArraOrde[Cont]) div 2);
  end;

  for Cont := 1 to Part1 do
  begin
    ArraChar[Cont] := char(ArraOrde[Cont]-Ord(ArraChar[Tota-Cont+1]));
  end;

  Result := '';
  for Cont := 1 to Tota do
  begin
    Result := Result + ArraChar[Cont];
  end;
end;

//Objetivo: Criptograr a String passada como parâmetro
function Crip(Pala:String):String;
var
  i, Tama : integer;
begin
  Result := '';
  Tama := Length(Pala);
  for i := 1 to (Tama div 2) do
    Result := Result + Char(Ord(Pala[i])+Ord(Pala[Tama-i+1]));
  for i := ((Tama div 2)+1) to Tama do
    Result := Result + Char(Ord(Pala[i])*2);
end;

//Objetivo: Criptograr a String passada como parâmetro
function CripXe7(Pala:String):String;
var
  i: Integer;
begin
  {$IFDEF ERP6}
    Result := Crip(Pala);
  {$ELSE}
    Result := Crip(CripNume(Pala));
    for I := 1 to Length(Result) do
      Result[i] := char(Ord(Result[i])+1);
  {$ENDIF}
end;

//Objetivo: Criptograr a String passada como parâmetro
function Des_CripXe7(Pala:String):String;
var
  i: Integer;
begin
  {$IFDEF ERP6}
    Result := Des_Crip(Pala);
  {$ELSE}
    for I := 1 to Length(Pala) do
      Pala[i] := char(Ord(Pala[i])-1);
    Result := Des_CripNume(Des_Crip(Pala));
  {$ENDIF}
end;

//Objetivo: DesCriptograr a String passada como parâmetro
function Des_Crip(Pala:String):String;
var
  i, Tama : integer;
begin
  Result := '';
  Tama := Length(Pala);
  for i := ((Tama div 2)+1) to Tama do
    Pala[i] := Char(Ord(Pala[i]) div 2);
  for i := 1 to (Tama div 2) do
    Result := Result + (Char(Ord(Pala[i])-Ord(Pala[Tama-i+1])));
  for i := ((Tama div 2)+1) to Tama do
    Result := Result + Pala[i];
end;

//Criptografar um arquivo
Function CripArqu(EndeOrig, EndeDest, Senh: String): Boolean;
var
  i: Integer;
  ArquOrig: TStringList;
  ArquDest: TStringList;
begin
  Result := False;
  if not FileExists(EndeOrig) then
    msgAviso('Arquivo não Existe!')
  else
  begin
    if FileExists(EndeDest) then
    begin
      if msgSim('Arquivo Destino Existe. Substituir?') then
        DeleteFile(EndeDest)
      else
        Exit;
    end;

    ArquOrig := TStringList.Create;
    ArquDest := TStringList.Create;
    try
      ArquOrig.LoadFromFile(EndeOrig);
      ArquDest.Add(CripXe7(TiraAcen(Senh)));
      for I := 0 to ArquOrig.Count - 1 do
      begin
        ArquDest.Add(CripXe7(ArquOrig[i]));
      end;
      ArquDest.SaveToFile(EndeDest);
    finally
      ArquOrig.Free;
      ArquDest.Free;
    end;
  end;
end;

//Des Criptografar um arquivo
Function Des_CripArqu(EndeOrig, EndeDest, Senh: String): Boolean;
var
  i: Integer;
  ArquOrig: TStringList;
  ArquDest: TStringList;
  sAuxi: String;
begin
  if not FileExists(EndeOrig) then
  begin
    msgAviso('Arquivo não Existe!');
    Result := False;
  end
//  else if FileExists(EndeDest) then
//  begin
//    if (sgMessageDlg('Arquivo Destino Existe. Substituir?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
//      DeleteFile(EndeDest)
//    else
//      Exit;
//  end
  else
  begin
    Result := True;
    ArquOrig := TStringList.Create;
    ArquDest := TStringList.Create;
    try
      ArquOrig.LoadFromFile(EndeOrig);
      sAuxi := ArquOrig[0];
      if sAuxi <> CripXe7(TiraAcen(Senh)) then
      begin
        msgAviso('Equipe: Senha Invalida!');
        Result := False;
      end
      else
      begin
        for I := 1 to ArquOrig.Count - 1 do
          ArquDest.Add(Des_CripXe7(ArquOrig[i]));
      end;
      ArquDest.SaveToFile(EndeDest);
    finally
      ArquOrig.Free;
      ArquDest.Free;
    end;
  end;
end;

//Criptografar/Descriptografar com Chave
function CripChav(parstring,parchave: String): String;
var
  i, TamanhoString, pos, PosLetra, TamanhoChave: Integer;
begin
  Result := parstring;
  TamanhoString := Length(parstring);
  TamanhoChave := Length(parchave);
  for i := 1 to TamanhoString do
  begin
    pos := (i mod TamanhoChave);
    if pos = 0 then
    pos := TamanhoChave;
    posLetra := ord(Result[i]) xor ord(parChave[pos]);
    if posLetra = 0 then
      posLetra := ord(Result[i]);
    Result[i] := chr(posLetra);
  end;
end;

//Criptografar/Descriptografar com Chave (descriptografar, chave negativa)
function CripChavSAG(Texto: String; Chav: Integer): String;
//const Tipo = 'RCA6D9FBG8IEJ2KMHNXO5LPS1T3UV4W7 -:YQZ0/.#@()%AIMSZCUBJNT[G';
const Tipo = 'RCA6D9FBG8IEJ2KMHNXO5LPS1T3UV4W7YQZ0';
var
  i, TamanhoString, posi: Integer;
begin
  Result := AnsiUpperCase(Texto);
  TamanhoString := Length(Result);

  for i := 1 to TamanhoString do  //Pula o primeiro, tamanhochave
  begin
    if Chav > 0 then
      posi := Pos(Result[i],Tipo) + (Chav - (i mod Chav))
    else
      posi := Pos(Result[i],Tipo) + (Chav + (i mod Chav));

    if Posi > 0 then //Se não achou no "Tipo" deixa a letra original
    begin
      posi := posi mod Length(Tipo);  //Tamanho do Tipo
      if posi = 0 then
        posi := Length(Tipo)
      else if posi < 0 then
        posi := Length(Tipo) - ABS(posi);

      Result[i] := Tipo[posi];
    end;
  end;
end;

function CripChav2(StrValue, Key : String) : String;
var
  I: Integer;
  OutValue : String;
  Chave: Word;

  function StringCrc(const Data: String): longword;
  const
    CRCtable: array[0..255] of DWORD = (
      $00000000, $77073096, $EE0E612C, $990951BA, $076DC419, $706AF48F, $E963A535,
      $9E6495A3, $0EDB8832, $79DCB8A4, $E0D5E91E, $97D2D988, $09B64C2B, $7EB17CBD,
      $E7B82D07, $90BF1D91, $1DB71064, $6AB020F2, $F3B97148, $84BE41DE, $1ADAD47D,
      $6DDDE4EB, $F4D4B551, $83D385C7, $136C9856, $646BA8C0, $FD62F97A, $8A65C9EC,
      $14015C4F, $63066CD9, $FA0F3D63, $8D080DF5, $3B6E20C8, $4C69105E, $D56041E4,
      $A2677172, $3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B, $35B5A8FA, $42B2986C,
      $DBBBC9D6, $ACBCF940, $32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59, $26D930AC,
      $51DE003A, $C8D75180, $BFD06116, $21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F,
      $2802B89E, $5F058808, $C60CD9B2, $B10BE924, $2F6F7C87, $58684C11, $C1611DAB,
      $B6662D3D, $76DC4190, $01DB7106, $98D220BC, $EFD5102A, $71B18589, $06B6B51F,
      $9FBFE4A5, $E8B8D433, $7807C9A2, $0F00F934, $9609A88E, $E10E9818, $7F6A0DBB,
      $086D3D2D, $91646C97, $E6635C01, $6B6B51F4, $1C6C6162, $856530D8, $F262004E,
      $6C0695ED, $1B01A57B, $8208F4C1, $F50FC457, $65B0D9C6, $12B7E950, $8BBEB8EA,
      $FCB9887C, $62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65, $4DB26158, $3AB551CE,
      $A3BC0074, $D4BB30E2, $4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB, $4369E96A,
      $346ED9FC, $AD678846, $DA60B8D0, $44042D73, $33031DE5, $AA0A4C5F, $DD0D7CC9,
      $5005713C, $270241AA, $BE0B1010, $C90C2086, $5768B525, $206F85B3, $B966D409,
      $CE61E49F, $5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4, $59B33D17, $2EB40D81, 
      $B7BD5C3B, $C0BA6CAD, $EDB88320, $9ABFB3B6, $03B6E20C, $74B1D29A, $EAD54739, 
      $9DD277AF, $04DB2615, $73DC1683, $E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8,
      $E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1, $F00F9344, $8708A3D2, $1E01F268,
      $6906C2FE, $F762575D, $806567CB, $196C3671, $6E6B06E7, $FED41B76, $89D32BE0, 
      $10DA7A5A, $67DD4ACC, $F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5, $D6D6A3E8, 
      $A1D1937E, $38D8C2C4, $4FDFF252, $D1BB67F1, $A6BC5767, $3FB506DD, $48B2364B, 
      $D80D2BDA, $AF0A1B4C, $36034AF6, $41047A60, $DF60EFC3, $A867DF55, $316E8EEF, 
      $4669BE79, $CB61B38C, $BC66831A, $256FD2A0, $5268E236, $CC0C7795, $BB0B4703,
      $220216B9, $5505262F, $C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04, $C2D7FFA7,
      $B5D0CF31, $2CD99E8B, $5BDEAE1D, $9B64C2B0, $EC63F226, $756AA39C, $026D930A,
      $9C0906A9, $EB0E363F, $72076785, $05005713, $95BF4A82, $E2B87A14, $7BB12BAE,
      $0CB61B38, $92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21, $86D3D2D4, $F1D4E242,
      $68DDB3F8, $1FDA836E, $81BE16CD, $F6B9265B, $6FB077E1, $18B74777, $88085AE6,
      $FF0F6A70, $66063BCA, $11010B5C, $8F659EFF, $F862AE69, $616BFFD3, $166CCF45,
      $A00AE278, $D70DD2EE, $4E048354, $3903B3C2, $A7672661, $D06016F7, $4969474D,
      $3E6E77DB, $AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0, $A9BCAE53, $DEBB9EC5,
      $47B2CF7F, $30B5FFE9, $BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6, $BAD03605,
      $CDD70693, $54DE5729, $23D967BF, $B3667A2E, $C4614AB8, $5D681B02, $2A6F2B94,
      $B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D);
  var
    i: integer;
  begin
    result := $FFFFFFFF;
    for i := 0 to length(Data) - 1 do
      result := (result shr 8) xor (CRCtable[byte(result) xor Ord(Data[i + 1])]);
    result := result xor $FFFFFFFF;
  end;
  
begin
  Chave := StringCrc(Key);
  OutValue := '';
  for I := 1 to Length(StrValue) do
    OutValue := OutValue + char(Not(ord(StrValue[I])-Chave));
  Result := OutValue;
end;

function Split(value, delimiter : String) : TsgArrayString;
var
  i : Integer;
begin
  i := 0;
  if Pos(delimiter,value) = 0 then
  begin
    SetLength(Result,i+1);
    Result[i] := value;
  end
  else
  begin
    if not Value.EndsWith(delimiter) then
      Value := Value + delimiter;

    while Pos(delimiter,value) > 0 do
    begin
      SetLength(Result,i+1);
      Result[i] := Copy(value,1,Pos(delimiter,value)-1);
      value := Copy(Value, Pos(delimiter,value)+Length(Delimiter), MaxInt);
      //Sidiney 31/01/2021: Caso tenha duas vezes a mesma string dentro do value, o array não retorna correto por causa do replace
      //value := StringReplace(value,Result[i]+delimiter,'',[]);
      i := i+1;
    end;
    //SetLength(Result,i+1);
    //Result[i] := value;
  end;
end;

//Split para quando já começa com o delimiter, por exemplo: S01S02S03
//AddDelimiter: Retorna o Delimiter junto, por exemplo: S01 ; S02 ; S03
function sgSplit(value, delimiter : String; AddDelimiter: Boolean = False) : TsgArrayString;
var i : Integer;
begin
  i := 0;
  if Pos(delimiter,value) = 0 then
  begin
    SetLength(Result,i+1);
    Result[i] := value;
  end
  else
  begin
    value := InvePala(value);
    while Pos(delimiter,value) > 0 do
    begin
      SetLength(Result,i+1);
      Result[i] := InvePala(Copy(value,1,Pos(delimiter,value)-1+Length(Delimiter)));
      value := Copy(Value, Length(Result[i])+Length(Delimiter), MaxInt);
      i := i+1;
    end;
    if Value <> '' then
    begin
      SetLength(Result,i+1);
      Result[i] := value;
    end;
  end;
end;

//Como chamar a função:
//MessageDlgDefaultTime('Antes de iniciar iremos atualizar os dados, por favor aguarde!',tempo, mtConfirmation, [mbYes], 0,mrYes);
function sgMessageDlgTimer(Msg :String;tempo:integer; AType: TMsgDlgType; AButtons : TMsgDlgButtons;
                           IndiceHelp : LongInt; DefButton : TModalResult=MrNone) : Word;
Var
  I: Integer;
  Mensagem:TForm;
  TimerMethod: TNotifyEvent;

  procedure UpdateProgressBar(Data: Pointer; Sender: TObject);
  var
//    Mensagem: TForm;
    Tempo_Msg: Integer;
  begin
    if Sender is TTimer then
    begin
    if TTimer(Sender).Owner is TForm then
    begin
      Mensagem := TForm(TTimer(Sender).Owner);
      Mensagem.Tag := Mensagem.Tag - 1;
      Tempo_Msg := Mensagem.Tag;
      if Tempo_Msg > 0 then
      begin
        Mensagem := TForm(TButton(Sender).Owner);
        TButton(Mensagem.FindComponent('OK')).Caption := '&Ok '+inttostr(Tempo_Msg);
        TButton(Mensagem.FindComponent('YES')).Caption := '&Sim '+inttostr(Tempo_Msg);
//        TButton(Mensagem.FindComponent('NO')).Caption := '&Não '+inttostr(Tempo_Msg);
//        TButton(Mensagem.FindComponent('ABORTA')).Caption := '&Abortar '+inttostr(Tempo_Msg);
//        TButton(Mensagem.FindComponent('RETRY')).Caption := '&Excel '+inttostr(Tempo_Msg);
//        TButton(Mensagem.FindComponent('IGNORE')).Caption := '&Ignorar '+inttostr(Tempo_Msg);
//        TButton(Mensagem.FindComponent('ALL')).Caption := '&Texto '+inttostr(Tempo_Msg);
//        TButton(Mensagem.FindComponent('HELP')).Caption := '&Ajunda '+inttostr(Tempo_Msg);
//        TButton(Mensagem.FindComponent('CANCEL')).Caption := '&Cancelar '+inttostr(Tempo_Msg);
      end
      else
      begin
        Mensagem.ModalResult := mrOk;
      end;
      end;
    end;
  end;

Begin
  Mensagem:=CreateMessageDialog(Msg, AType, Abuttons);
  Mensagem.HelpConText:=IndiceHelp;
  With Mensagem Do
  Begin
    For i :=0 To ComponentCount -1 Do
    Begin
      If (Components[i] is TButton) Then
      Begin
        If (TButton(Components[i]).ModalResult=DefButton) Then
        Begin
          ActiveControl:=TWincontrol(Components[i]);
        End;
      End;
    End;
    Tag := Tempo;
    If Atype=mtConfirmation Then
      Caption := 'Confirmação'
    else If AType=mtWarning Then
      Caption := 'Atenção'
    else If AType=mtError Then
      Caption := 'Erro'
    else If AType=mtInFormation Then
      Caption := 'Informação';

    TButton(Mensagem.FindComponent('OK')).Caption := '&Ok '+inttostr(Tempo);
    TButton(Mensagem.FindComponent('YES')).Caption := '&Sim '+inttostr(Tempo);
    TButton(Mensagem.FindComponent('NO')).Caption := '&Não';
    TButton(Mensagem.FindComponent('ABORT')).Caption := '&Abortar';
    TButton(Mensagem.FindComponent('RETRY')).Caption := '&Repete';
    TButton(Mensagem.FindComponent('IGNORE')).Caption := '&Ignora';
    TButton(Mensagem.FindComponent('ALL')).Caption := '&Tudo';
    TButton(Mensagem.FindComponent('HELP')).Caption := '&Ajunda';
    TButton(Mensagem.FindComponent('CANCEL')).Caption := '&Cancela';
    TButton(Mensagem.FindComponent('CLOSE')).Caption := '&Fecha';
  End;

  if tempo > 0 then
  begin
    with TTimer.Create(Mensagem) do
    begin
      Name := 'MsgTimer';
      Interval := 1000;
    end;
    TMethod(TimerMethod).Code := Addr(UpdateProgressBar);
    TMethod(TimerMethod).Data := mensagem.FindComponent('MsgTimer');
    TTimer(mensagem.FindComponent('MsgTimer')).OnTimer := TimerMethod;
  end;

  Result := Mensagem.Showmodal;
  Mensagem.Free;
End;

function MessageDlgDefault(Msg :String; AType: Dialogs.TMsgDlgType; AButtons : Dialogs.TMsgDlgButtons;
                           IndiceHelp : LongInt; DefButton : TModalResult=MrNone) : Word;
Var
  I:Integer;
  Mensagem:TForm;
Begin
  Mensagem:=CreateMessageDialog(Msg, AType, Abuttons);
  Mensagem.HelpConText:=IndiceHelp;
  With Mensagem Do
  Begin
    For i :=0 To ComponentCount -1 Do
    Begin
      If (Components[i] is TButton) Then
      Begin
        If (TButton(Components[i]).ModalResult=DefButton) Then
        Begin
          ActiveControl:=TWincontrol(Components[i]);
        End;
      End;
    End;
    If Atype=mtConfirmation Then Caption := 'Confirmação'
    else If AType=mtWarning Then Caption := 'Atenção'
    else If AType=mtError Then Caption := 'Erro'
    else If AType=mtInFormation Then Caption := 'Informação';
    TButton(Mensagem.FindComponent('OK')).Caption := '&Ok';
    TButton(Mensagem.FindComponent('NO')).Caption := '&Não';
    TButton(Mensagem.FindComponent('ABORT')).Caption := '&Aborta';
    TButton(Mensagem.FindComponent('RETRY')).Caption := '&Excel';
    TButton(Mensagem.FindComponent('IGNORE')).Caption := '&Ignora';
    TButton(Mensagem.FindComponent('ALL')).Caption := '&Todos';
    TButton(Mensagem.FindComponent('HELP')).Caption := '&Ajuda';
    TButton(Mensagem.FindComponent('CANCEL')).Caption := '&Cancela';
    TButton(Mensagem.FindComponent('CLOSE')).Caption := 'Fe&cha';
    // Aqui vc pode adicionar mais buttons, vai depender da sua necessidade, os TMsgDlgBtn (Buttons) estão relacionados acima.
  End;
  Result := Mensagem.ShowModal;
  Mensagem.Free;
end;

//Substituir o sgMessageDlg padrao
function sgMessageDlg(const Msg: string; DlgType: TMsgDlgType;Buttons: TMsgDlgButtons): Integer; overload;
begin
  Result := sgMessageDlg(Msg, DlgType, Buttons, 0);
end;
function sgMessageDlg(const Msg: string; DlgType: TMsgDlgType;Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn = mbHelp): Integer; overload;
var
  MsgGrav, NovaMsg: String;
  I: Integer;
  vListBusc, vListTrad: TsgArrayString;
  MsgBusc, MsgTrad: String;
begin
  Result := -1;
  if Msg = 'Invalid pointer operation' then
    Exit;

  {$if Defined(SAGLIB) or Defined(LIBUNI)}
  {$else}
    NovaMsg := Msg;
    try
      if GetPADOConn.Connected then
      begin
        MsgGrav := Trad.TratMens_Ajus(Msg);

        NovaMsg := '';
        if (GetCodiIdio() <> 0) and Trad.TratMens_Valida(MsgGrav) then
        begin
          NovaMsg := CalcStri('SELECT NomeTrad FROM POCATRAD'+sLineBreak+
                              'WHERE TIPOTRAD = ''MSGS'' AND NAMETRAD = '+QuotedStr(MsgGrav)+
                              '  AND CODIIDIO = '+IntToStr(GetCodiIdio()));
          if NovaMsg = '' then //Busca as traduções gerais
          begin
            CalcDoisCamp('SELECT NomeTrad, BuscTrad FROM POCATRAD'+sLineBreak+
                         'WHERE TIPOTRAD = ''MSGS'' AND NOMETRAD LIKE ''%||%'' AND '+QuotedStr(MsgGrav)+' LIKE NAMETRAD||''%'''+
                         '  AND CODIIDIO = '+IntToStr(GetCodiIdio()),
                         MsgTrad, MsgBusc);
            if MsgBusc <> '' then
            begin
              NovaMsg := Msg;
              vListBusc := Split(SubsPala(MsgBusc,'||','|'), '|');
              vListTrad := Split(SubsPala(MsgTrad,'||','|'), '|');
              for i := 0 to Length(vListBusc) - 1 do
              begin
                if I < Length(vListTrad) then
                  NovaMsg := SubsPalaTudo(NovaMsg, vListBusc[i], vListTrad[i]);
              end;
            end;
          end;
        end;

        if (NovaMsg = '') then
        begin
          NovaMsg := Msg;
          if (GetCodiIdio() = 0) and Trad.TratMens_Valida(MsgGrav) then
          begin
            GetPADOConn.Execute('INSERT INTO POCATRAD (TIPOTRAD, NOMETRAD)'+sLineBreak+
                                'SELECT ''MENS'', '+QuotedStr(MsgGrav)+' FROM POCAAUXI '+
                                'WHERE 0 = (SELECT COUNT(*) FROM POCATRAD WHERE TIPOTRAD = ''MENS'' AND NOMETRAD = '+QuotedStr(MsgGrav)+')')
          end;
        end;
      end;
    except
      NovaMsg := Msg;
    end;
  {$endif}

  NovaMsg := SubsPalaTudo(NovaMsg,'<br>',chr(13));
  {$ifdef WS}
    if mbYesToAll in Buttons then
    begin
      WriteLn('..::..');
      WriteLn(NovaMsg);
      Result := mrYesToAll;
    end
    else
      raise Exception.Create(NovaMsg);
  {$else}
    {$ifdef SAGSINC}
      SetPLblAjud_Capt(NovaMsg);
      GetConfWeb.MemVal1.Text := NovaMsg;
      if mbOk in Buttons then
        Result := mrOk
      else
        Result := mrCancel;
    {$else}
      {$if Defined(ERPUNI) and not Defined(TRAY)}
        if Buttons = [mbOk] then
        begin
          uniGUIDialogs.MessageDlgN(NovaMsg, DlgType, Buttons);
          Result := mrOk;
        end
        else
        begin
          try
            Result := uniGUIDialogs.MessageDlg(NovaMsg, DlgType, Buttons);
          except
          end;
        end;
      {$else}
        if Buttons = [] then
          Result := MyMessageDlg(NovaMsg, DlgType, Buttons)
        else if DefaultButton = mbHelp then
          Result := MessageDlg(NovaMsg, DlgType, Buttons, HelpCtx)
        else
          Result := MessageDlg(NovaMsg, DlgType, Buttons, HelpCtx, DefaultButton);
      {$endif}
    {$endif}
  {$endif}
end;

function MyMessageDlg(const Msg:string; DlgType:TMsgDlgType; Buttons:TMsgDlgButtons;
               sFontName:string=''; iFontSize:Integer=0; fsStyle:TFontStyles=[];
               sCaptions: string=''):integer;
begin
  Result := MyMsgDlg(Msg, DlgType, Buttons, sFontName, iFontSize, fsStyle, sCaptions);
end;

Function msgOk(msg: String): Integer;
begin
  Result := sgMessageDlg(msg, mtInformation, [mbOK], 0);
end;

Function msgAviso(msg: String): Integer;
begin
  Result := sgMessageDlg(msg, mtWarning, [mbOK], 0);
end;

Function msgSim(msg: String): Boolean;
begin
  Result := sgMessageDlg(msg, mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

Function msgNao(msg: String): Boolean;
begin
  Result := sgMessageDlg(msg, mtConfirmation, [mbYes, mbNo], 0) = mrNo;
end;

Function msgNovaMsg(msg: String; iNovaMsg: String): Boolean;
begin
  {$ifdef ERPUNI}
    //Result := sgMessageDlg(msg, mtConfirmation, [mbOK, mbCancel], 0) = mrCancel;
    Result := False;
    CopyToClipBoard(Msg+sLineBreak+sLineBreak+iNovaMsg);
    msgOk(msg+sLineBreak+sLineBreak+'.'+Replicate(' ',20)+'(!)');
  {$else}
    Result := sgMessageDlg(msg, mtConfirmation, [mbOK, mbYesToAll], 0) = mrYesToAll;
  {$endif}
  if Result then
    msgOk(Msg+sLineBreak+sLineBreak+iNovaMsg);
end;

procedure CopyToClipBoard(const iText: String);
begin
  {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
//    {$ifdef ERPUNI}
//      try
//        UniSession.AddJS(
//               'function copyTextToClipboard(text) {'+sLineBreak+
//               '  // Crie um elemento de input oculto para armazenar o texto que você deseja copiar'+sLineBreak+
//               '  var input = document.createElement(''input'');'+sLineBreak+
//               '  document.body.appendChild(input);'+sLineBreak+
//               ''+sLineBreak+
//               '  // Defina o valor do input com o texto que você deseja copiar'+sLineBreak+
//               '  input.value = text;'+sLineBreak+
//               ''+sLineBreak+
//               '  // Selecione o texto no input'+sLineBreak+
//               '  input.select();'+sLineBreak+
//               ''+sLineBreak+
//               '  // Copie o texto para a área de transferência'+sLineBreak+
//               '  document.execCommand(''copy'');'+sLineBreak+
//               ''+sLineBreak+
//               '  // Remova o input, já que não é mais necessário'+sLineBreak+
//               '  document.body.removeChild(input);'+sLineBreak+
//               '}');
//
//        //Chame a função JavaScript
//        UniSession.AddJS('copyTextToClipboard("' + SubsPalaTudo(iText, sLineBreak, '<br>') + '");');
//      finally
//      end;
//    {$else}
      // Abre a área de transferência para escrita
      Clipboard.Open;
      try
        // Define o texto a ser copiado
        Clipboard.AsText := iText;
        // Fecha a área de transferência após copiar o texto
        Clipboard.Close;
      except
        // Trate qualquer exceção que possa ocorrer ao copiar o texto
        Clipboard.Close;
        raise;
      end;
//    {$endif}
  {$endif}
end;

function GeraChavGrav(): String;
//tamanho: 21
begin
  Result := GetPCodPess()+'D'+FormatDateTime('YYYYMMDDHHNNSSZZZ',Date+Time);
end;

Function BuscPareWin(Comp: TClass; Classe: String = {$IFDEF ERPUNI} 'TUniControl' {$else} 'TWinControl' {$endif}): Boolean;
begin
  if Comp = Nil then
    Result := False
  else if AnsiUpperCase(Comp.ClassName) = AnsiUpperCase(Classe) then
    Result := True
  else
    Result := BuscPareWin(Comp.ClassParent, Classe);
end;

//ST
//Buscar o criador conforme a classe (normalmente achar o TsgForm/TForm
Function GetOwnerWin(Comp: TComponent; Classe: TClass): TComponent;
begin
  if Comp = Nil then
    Result := Nil
  else if Comp is Classe then
    Result := Comp
  else
    Result := GetOwnerWin(Comp.Owner, Classe);
end;


Function GetPareWin(Comp: {$IFDEF ERPUNI} TUniControl {$else} TWinControl {$endif}; Classe: TClass): TComponent;
begin
  if Comp = Nil then
    Result := Nil
  else if Comp is Classe then
    Result := Comp
  else
    Result := GetPareWin( {$IFDEF ERPUNI} TUniControl {$else} TWinControl {$endif}(Comp.Parent), Classe);
end;

function sgTipoForm(iComp: TClass): TsgTipoForm;
begin
  if BuscPareWin(iComp, 'TsgForm') then
    Result := tfsgForm
  else if BuscPareWin(iComp, 'TsgFormModal') then
    Result := tfsgFormModal
  else
    Result := tfForm;
end;

//Objetivo: Formatar uma String, colocando zeros na frente ate o tamanho de Tama
Function ZeroNume(Nume:String; Tama : integer):String;
begin
  Result := Replicate('0',Tama-Length(Nume)) + Nume;
end;

//Retira qualquer caracter da String, deixando apenas os nzmero de 0 a 9, o ponto, a vmrgula e o sinal '-' (menos)
Function RetiCara(Nome:String):String;
var
  i : byte;
begin
  Result := '';
  for i := 1 to Length(Nome) do
  if CharInSet(Nome[i], ['0','1','2','3','4','5','6','7','8','9',',','.','-']) then
    Result := Result + Nome[i];
end;

//Retira o Caracter Passado da String Passada
Function RetiTipoCara(Nome, Cara: String): String;
var
  i : byte;
begin
  Result := '';
  for i := 1 to Length(Nome) do
  if Nome[i] <> Cara then
    Result := Result + Nome[i];
end;

//Deixa somente numero, ponto e vmrgula
Function RetiLetr(Nome: String):String;
var
  i : Integer;
begin
  Result := '';
  for i := 1 to Length(Nome) do
    if CharInSet(Nome[i], ['0','1','2','3','4','5','6','7','8','9','.',',']) then
      Result := Result + Nome[i];
end;

//Deixa somente nzmero e letras
function LetrNume(Nome: String; SubsPor_: String = ''):String;
var
  i : Integer;
begin
  Result := '';
  for i := 1 to Length(Nome) do
    if (Ord(Nome[i]) in [048..057]) or   //0 .. 9
       (Ord(Nome[i]) in [065..090]) or   //A .. Z
       (Ord(Nome[i]) in [097..122]) then //a .. z
      Result := Result + Nome[i]
    else
      Result := Result + SubsPor_;
end;

// Inverter vmrgulas para ponto e vice-versa.
// Obs.: Esta Fungco ja possui o RetoZero
Function InvePont(Nume: String):String;
var
  i : integer;
begin
  Nume := RetoZero(Nume);
  for i:= 1 to Length(Nume) do
  begin
    if Nume[i] = ',' then
      Nume[i] := '.'
    else if Nume[i] = '.' then
      Nume[i] := ',';
  end;
  Result := Nume;
end;

// Deixar sempre PONTO para separar Decimais.
Function PontDeci(Nume: Real; Casa: Byte):String;
begin
  Result := IntToStr(Trunc(Nume))+'.'+Copy(FloatToStr(Frac(Nume)),03,Casa);
end;

// Pega uma String passado com um valor REAL e retorna o valor com o separador do WINDOWS
// (Ex.: Pega 1.234.456,7890 <=> Retorna 123456.7890) (Caso o Separador seja Ponto)
// Obs.: Esta Fungco ja possui o RetoZero
Function FormReal(Nume: String):String;
var
  i : integer;
  Enco : Boolean;  //Caso ja encontrou o Ponto ou a Vmrgula
begin
  Nume := RetoZero(Nume);
  i := Length(Nume);
  Enco := False;
  while i > 0 do
  begin
    if not(Enco) then
    begin
      if CharInSet(Nume[i], [',','.']) then
      begin
        Enco := True;
        Nume[i] := {$IFNDEF ERP6}FormatSettings.{$ENDIF}DecimalSeparator;
      end;
    end
    else
    begin
      if CharInSet(Nume[i], [',','.']) then
        Delete(Nume,i,01);
    end;
    Dec(i);
  end;
  Result := Nume;
end;

function MergeArray(const iArray1, iArray2: TsgArrayString): TsgArrayString;
var
  i, vTam1, vTam2: Integer;
begin
  vTam1 := Length(iArray1);
  vTam2 := Length(iArray2);
  SetLength(Result, vTam1+vTam2);
  for I := 0 to vTam1-1 do
    Result[i] := iArray1[i];

  for I := 0 to vTam2-1 do
    Result[vTam1+i] := iArray2[i];
end;
//***********************************************
//Objetivo : Colocar os : entre a Hora
//Parbmetro: Hora
function SepaHora(Hora:String):String;
begin
 Insert(':',Hora,Length(Hora)-1);
 Result := Hora;
end;

Function EspaDire(Pala:String;Tama:Integer;Copi:Boolean=True):String;
begin
  Result := Pala;
  if Length(Trim(Pala)) < Tama then
    Result := Trim(Pala)+Replicate(' ',Tama-Length(Trim(Pala)))
  else if Copi then
    Result := Copy(Pala,01,Tama);
end;

Function EspaEsqu(Pala:String;Tama:Integer;Copi:Boolean=True):String;
begin
  Result := Pala;
  if Length(Trim(Pala)) < Tama then
    Result := Replicate(' ',Tama-Length(Trim(Pala)))+Trim(Pala)
  else if Copi then
    Result := Copy(Pala,01,Tama);
end;

// Repete o caracter passado a direita de Pala.
Function CaraDire(Pala,Cara:String;Tama:Integer):String;
begin
  if Length(Trim(Pala)) < Tama then
    Result := Trim(Pala)+Replicate(Cara,Tama-Length(Trim(Pala)))
  else
    Result := Pala;
end;

// Repete o caracter passado a esquerda de Pala.
Function CaraEsqu(Pala,Cara:String;Tama:Integer):String;
begin
  if Length(Trim(Pala)) < Tama then
    Result := Replicate(Cara,Tama-Length(Trim(Pala)))+Trim(Pala)
  else
    Result := Pala;
end;

// Pega uma String passado com um valor DATA (DD/MM/YYYY) e retorna o valor no formado do WINDOWS
Function FormData(Data: String; Padr: TDateTime = 0):String;
var
  Dia, Mes: String;
  Ano: String;
  DigiAno : Byte;  //Digito do Ano
begin
  if (Trim(Data) = '') or (Trim(Data) = '/  /') then
  begin
    if Padr = 0 then Padr := Date;
    Data := FormatDateTime('DD/MM/YYYY',Padr);
  end
  else if sgPos('/', Data) = 0 then
  begin
    Data.Insert(2,'/');
    Data.Insert(5,'/');
  end;
  Result := {$IFNDEF ERP6}FormatSettings.{$ENDIF}ShortDateFormat;

  DigiAno := ContPala(AnsiUpperCase(Result),'Y');
  Dia := Copy(Data,01,02);
  Mes := Copy(Data,04,02);
  Ano := Copy(Data,11-DigiAno,DigiAno);
  Result := SubsPala(AnsiUpperCase(Result),'DD','D');
  Result := SubsPala(AnsiUpperCase(Result),'D', Dia);
  Result := SubsPala(AnsiUpperCase(Result),'MM','M');
  Result := SubsPala(AnsiUpperCase(Result),'M', Mes);
  Result := SubsPala(AnsiUpperCase(Result),Replicate('Y',DigiAno),Ano);
end;

// Fungão que retorna zero (String) quando o valor for nulo
function NuloStri(Valo:Variant): String;
begin
  if VarIsNull(Valo) then
    Result := '0'
  else
    Result := Valo;
end;

// Função que retorna string vazia quando o valor for nulo
function NuloStri2(Valo:Variant): String;
begin
  if VarIsNull(Valo) then
    Result := ''
  else
    Result := Valo;
end;

// Fungco que retorna zero (Inteiro) quando o valor  for nulo
function NuloInte(Valo:Variant):Int64;
begin
  if VarIsNull(Valo) then
    Result := 0
  else
    Result := Valo;
end;

// Fungco que retorna Null quando o valor for 0 (zero)
function ZeroNulo(Valo:Variant):Variant;
begin
  if Valo = 0 then
    Result := Null
  else
    Result := Valo;
end;

// Fungco que retorna zero (Real) quando o valor  for nulo
function NuloReal(Valo:Variant):Real;
begin
  if VarIsNull(Valo) then
    Result := 0
  else
  begin
    Result := Valo;
    Result := RoundDec(Result,7);
  end;
end;

//Esta função retorna true se a tecla informada  estiver pressionada. False em caso contrario.
//Exemplo: if VeriTeclPress(VK_CONTROL) then  //Tecla Ctrl pressionada
//         if VeriTeclPress(VK_MENU) then     //Tecla Alt pressionada
//         if VeriTeclPress(VK_SHIFT) then    //Tecla Shift pressionada
//         if VeriTeclPress(VK_F2) then       //Tecla F2 pressionada
function VeriTeclPress(const Key: integer): boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
end;

//Verificar se uma determinada tecla esta pressionada;
function TeclPres(const Key: Integer): Boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
end;


{ TConfRela }
constructor TConfRela.Create(AControl: TObject);
begin
  inherited Create;
end;

destructor TConfRela.Destroy;
begin
  inherited;
end;

procedure addLog(msg : String);
var log : TStringList;
ende : string;
begin
  ende := GetPEndExec()+'LogIntegracaoGuardian.txt';
  log:=TStringList.Create;
  try
    if FileExists(ende) then
      log.LoadFromFile(ende);
    log.Add(msg);
    log.SaveToFile(ende);
  finally
    log.Free;
  end;
end;

procedure Componentes_Formata(iPrin: TWinControl);
var
  i: Integer;
  vUppe: Boolean;
begin
  with iPrin do
  begin
    vUppe := GetPUppeCase() and StrIn(AnsiUpperCase(iPrin.Name), ['FRMPOCATABE', 'FRMPOCACONS', 'FRMPOCACAMP', 'FRMPOCHCAMP']);

    for I  := 0 to ComponentCount - 1 do
    begin
      if vUppe then
      begin
        if (Components[i].ClassType = TDBEdtLbl) or
           (Components[i].ClassType = TEdtLbl) or
           (Components[i].ClassType = TDBMemLbl) or
           (Components[i].ClassType = TDBRchLbl) or
           (Components[i].ClassType = TMemLbl) or
           {$if defined(SAGLIB) OR defined(ERPUNI)} {$else}(Components[i].ClassType = TMaskEdit) or{$endif}
           (Components[i].ClassType = TFilLbl) or
           (Components[i].ClassType = TDirLbl) then
        begin
          with TEdtLbl(Components[i]) do
          begin
            if PasswordChar = '' then
              CharCase := ecUpperCase;
            //BorderStyle := bsSingle;
          end;
        end;
      end;

      if Components[i].ClassType = TsgPop then
        TsgPop(Components[i]).AtuaImag
      else if Components[i].ClassType = TsgPgc then
        TsgPgc(Components[i]).Style := tsFlatButtons
      //else if Components[i].ClassType = TsgBvl then
      //  TsgBvl(Components[i]).Shape := bsFrame
      else if (Components[i].ClassType = TDbAdvMemLbl) or
              {$if defined(SAGLIB) OR defined(ERPUNI)} {$else}(Components[i].ClassType = TAdvMemo) or{$endif}
              (Components[i].ClassType = TAdvMemLbl) then
      begin
        {$if defined(SAGLIB) OR defined(ERPUNI)}
        {$else}
          TAdvMemo(Components[i]).SmartTabs := True;          //Ir automaticamente para a próxima coluna da linha anterior com a tecla Tab quando verdadeiro
          TAdvMemo(Components[i]).TrimTrailingSpaces := True; //Tira espaços final de linha
          //TAdvMemo(Components[i]).EnhancedHomeKey := True;    //Home: Retorna para a primeira letra da linha
        {$endif}
      end
      else if (Components[i].ClassType = TCmbLbl) or
              (Components[i].ClassType = TDBVCmLbl) then
        TComboBox(Components[i]).DropDownCount := 8
      else if Components[i] is TsgBtn then
        Btn_Formata(TsgBtn(Components[i]))
      else if (Components[i].ClassType = TLcbLbl) or
              (Components[i].ClassType = TDBLcbLbl) then
      begin
        with TLcbLbl(Components[i]) do
        begin
          //if Tag <> 10 then
          begin
            {$if defined(SAGLIB) OR defined(ERPUNI)}
            {$else}
              Style.LookAndFeel.NativeStyle := False;
              Style.LookAndFeel.Kind := lfUltraFlat;
              Style.BorderStyle := ebsUltraFlat;
            {$endif}
          end;
        end
      end
      else if (Components[i].ClassType = TDBEdtLbl) or
              (Components[i].ClassType = TEdtLbl) or
              (Components[i].ClassType = TDBRxDLbl) or
              (Components[i].ClassType = TDBRxELbl) or
              (Components[i].ClassType = TDBLookNume) or
              (Components[i].ClassType = TDBLookText) or
              (Components[i].ClassType = TRxEdtLbl) or
              (Components[i].ClassType = TRxDatLbl) or
              //(Components[i].ClassType = TCmbLbl) or
              //(Components[i].ClassType = TDBVCmLbl) or
              //(Components[i].ClassType = TDBLcbLbl) or
              //(Components[i].ClassType = TDBMemLbl) or
              (Components[i].ClassType = TDBRchLbl) or
              (Components[i].ClassType = TDBImgLbl) or
              //(Components[i].ClassType = TMemLbl) or
              (Components[i].ClassType = TRchLbl) or
              {$if defined(SAGLIB) OR defined(ERPUNI)} {$else}(Components[i].ClassType = TMaskEdit) or{$endif}
              (Components[i].ClassType = TFilLbl) or
              (Components[i].ClassType = TDirLbl) or
              (Components[i].ClassType = TListBox) or
              {$if defined(SAGLIB) OR defined(ERPUNI)} {$else}(Components[i].ClassType = TrxSpinEdit) or{$endif}
              (Components[i].ClassType = TLstLbl) then
      begin
        with TEdtLbl(Components[i]) do
        begin
          {$if not Defined(SAGLIB) and not Defined(LIBUNI) and not Defined(ERPUNI)}
            //Sidiney (15/02/2022 17:58): Erro de memoria (POCaPess.pas) com o Skin
            //BevelKind := bkFlat;
            //BorderStyle := bsSingle;
          {$else}
          {$endif}
        end;
        if (Components[i].ClassType = TRxEdtLbl) or
           (Components[i].ClassType = TDBRxELbl) then
          TEdtLbl(Components[i]).Color := clWhite
        else if (Components[i].ClassType = TDBRchLbl) then
        begin
          if TDbRchLbl(Components[i]).WordWrap and (TDbRchLbl(Components[i]).ScrollBars in [ssHorizontal, ssBoth]) then
            TDbRchLbl(Components[i]).ScrollBars := ssVertical;
        end;
      {$if defined(SAGLIB) OR defined(ERPUNI)}
      {$else}
        end
        else if (Components[i].ClassType = TcxGridSite) or
                (Components[i] is TsgDBG) then
        begin
          if Assigned(TsgDBG(Components[i]).sgView) and (TsgDBG(Components[i]).sgView.ClassType = TcxGridDBTableView) then
            TcxGridDBTableView(TsgDBG(Components[i]).sgView).OptionsBehavior.CopyCaptionsToClipboard := False;
      {$endif}
      end;
      //Trad_Componente(Components[i], iPrin.HelpContext);
    end;
  end;
end;

procedure Btn_Formata(iBtn: TsgBtn);
begin
  if iBtn.Tag <> 10 then
  begin
    iBtn.Font.Name  := 'MS Sans Serif'; //cds.FieldByName('CFonCamp').AsString;
    iBtn.Font.Size  := 11; //cds.FieldByName('CTamCamp').AsInteger;
    iBtn.Font.Style := iBtn.Font.Style - [fsBold];
    iBtn.sgImageIndex := iBtn.sgImageIndex;
    {$if defined(SAGLIB) OR defined(ERPUNI)}
    {$else}
      //iBtn.LookAndFeel.NativeStyle := True;
      //iBtn.LookAndFeel.Kind := lfFlat;
    {$endif}
  end;
  {$if defined(SAGLIB) OR defined(ERPUNI)}
  {$else}
    //iBtn.Colors.Hot     := clWhite;
    //iBtn.Colors.Pressed := clWhite;
  {$endif}
end;

procedure FormatFields(iDts: TsgClientDataSet);
//*********************************************************
//IGUAL sgQuery.FormatFiels = Func.FormatFiels
//*********************************************************
var
  i: Integer;
  TipoCamp : AnsiChar;
  Unde: Boolean;
  Auxi, LinhConf, Masc: string;
  IniFiltCons: TDBIniMemo;

begin
  IniFiltCons := TDBiniMemo.Create(nil);
  with iDts do
  try
    IniFiltCons.Memo.Text := Coluna.Text;

    if TamaCamp = 0 then
      TamaCamp := {$ifdef ERPUNI} 40 {$else} 30 {$ENDIF};

    for i := 0 to Fields.Count - 1 do
    begin
      TipoCamp := TipoDadoCara(Fields[i]);

      if Fields[i].Tag <> 10 then
      begin
        LinhConf := IniFiltCons.ReadString('Colunas', Fields[i].FieldName, '');
        if LinhConf <> '' then
        begin
          Masc := BuscValoChavText(LinhConf,'Masc');
          if Masc <> '' then
          begin
            Fields[i].Tag := 10;
            if System.Pos('{',Masc) > 0 then  //Tirar a fórmula
              Masc := Copy(Masc,01,System.Pos('{',Masc)-1);

            {$ifdef FD} Masc := SubsPalaTudo(Masc,'#',''); {$endif}
            case TipoDadoCara(Fields[i]) of
             'N': TNumericField(Fields[i]).DisplayFormat := Masc;
             'I': TIntegerField(Fields[i]).DisplayFormat := Masc;
             'B': begin
                    if Masc[Length(Masc)] = '#' then
                      Masc[Length(Masc)] := '0';
                    TBCDField(Fields[i]).DisplayFormat := Masc;
                  end
            else
              Fields[i].EditMask := Masc;
            end;
          end;
          TamaCamp_Ajusta(Fields[i], BuscValoChavText(LinhConf,'Tama'));
        end;
      end;

      if Fields[i].Tag <> 10 then
      begin
        if (AnsiUpperCase(Copy(Fields[i].FieldName,01,05)) = 'CELU_') or
           (AnsiUpperCase(Copy(Fields[i].FieldName,01,05)) = 'COLU_') or
           (AnsiUpperCase(Copy(Fields[i].FieldName,01,05)) = 'LINH_') or
           (AnsiUpperCase(Copy(Fields[i].FieldName,01,09)) = 'LINHFONT_') then
        begin
          Fields[i].Visible := False;
          Fields[i].Tag     := 20;  //Para utilizar no sgDBG, criar uma coluna invisível lá
        end
        else
        begin
          TamaCamp_Ajusta(Fields[i], 0);

          if TipoCamp = 'N' then                      //Caso o Dado seja Número
          begin
            if System.Pos('R$',AnsiUpperCase(Fields[i].FieldName)) > 0 then
              (Fields[i] as TNumericField).DisplayFormat := Func.RetoMasc('R$')
            else
              (Fields[i] as TNumericField).DisplayFormat := Func.RetoMasc('NMos');
          end
          else if TipoCamp = 'I' then                 //Caso o Dado seja Inteiro
          begin
            TIntegerField(Fields[i]).DisplayFormat := Func.RetoMasc('Inte');
          end
          else if TipoCamp = 'B' then  //BCD
          begin
            if System.Pos('R$',AnsiUpperCase(Fields[i].FieldName)) > 0 then
              (Fields[i] as TNumericField).DisplayFormat := Func.RetoMasc('R$')
            else if TBCDField(Fields[i]).Size = 0 then  //Inteiro
              TBCDField(Fields[i]).DisplayFormat := Func.RetoMasc('Inte')
            else
              TBCDField(Fields[i]).DisplayFormat := Func.RetoMasc('NMos');
          end
          else if (RetoMasc(Fields[i].FieldName) <> '') then
            Fields[i].EditMask := Func.RetoMasc(Fields[i].FieldName);

          if Copy(Fields[i].FieldName, Length(Fields[i].FieldName), 01) = '_' then  //Último caracter for um "_"
          begin
            //Apaga todos os "_" do final do Nome do Campo
            Auxi := Fields[i].FieldName;
            Unde := Copy(Auxi, Length(Auxi), 01) = '_';
            if Unde then
            begin
              while Unde do
              begin
                System.Delete(Auxi, Length(Auxi), 01); //Apaga o último caracter
                Unde := Copy(Auxi, Length(Auxi), 01) = '_';
              end;
              Fields[i].DisplayLabel := Auxi;
            end;
          end;
        end;
      end;

      if (TipoCamp = 'C') and Assigned(FatExpr) and Assigned(FatExpr.OnVariable) then
        Fields[i].OnGetText := GetText;
    end;

    //Exibe Chave, Primeiro Campo
    Fields[0].Visible := ExibChav;
    if (Name = 'QryGrid') and (Fields.Count > 1) and (StrIn(Copy(Fields[1].FieldName,01,04), ['MARC','SGCH'])) then
      Fields[1].Visible := ExibChav;
  finally
    FreeAndNil(IniFiltCons);
  end;
end;

//Busca valores no formato Ini no Valo passado
function Ini_BuscValo(Valo, Seca: String; Chav: String=''; Padr: String=''): String;
var
  IniMemo: TDBIniMemo;
  List: TStringList;
  I: Integer;
  Acho: Boolean;
begin
  Seca := Trim(SubsPala(SubsPala(Seca,'[',''),']',''));
  if Trim(Chav) = '' then
  begin
    List := TStringList.Create;
    try
      List.Text := Valo;
      Result := '';
      Acho := False;
      for I := 0 to List.Count - 1 do
      begin
        if Acho then
        begin
          Acho := Copy(Trim(List[i]),01,01) <> '[';
          if Acho then
            Result := Result + Trim(List[i]) + #13;
        end;

        if not Acho then  //Nco usar o Else, que pode entrar no if do <> '[', am precisa verificar aqui novamente
          Acho := AnsiUpperCase(Trim(List[i])) = AnsiUpperCase('['+Seca+']');
      end;
    finally
      List.Free;
    end;
  end
  else
  begin
    IniMemo := TDBIniMemo.Create(nil);
    try
      IniMemo.Memo.Text := Valo;
      Chav := Trim(Chav);
      Result := IniMemo.ReadString(Seca, Chav, Padr);
    finally
      IniMemo.Free;
    end;
  end;
end;

function funCountChar(psTexto: string; pcChar: Char): Integer;
var
  i, ivTot: Integer;
begin
  ivTot := 0;
  psTexto := Trim(psTexto);
  for i := 1 to Length(psTexto) do
  begin
    if (UpCase(psTexto[i]) = UpCase(pcChar)) then
      ivTot := ivTot + 1;
  end;
  Result := ivTot;
end;

function DateRec(const Year, Month, Day: SmallInt): TDateRec;
begin
  Result.Year := Year;
  Result.Month := Month;
  Result.Day := Day;
end;

function TimeRec(const Hour, Minute, Second: SmallInt): TTimeRec;
begin
  Result.Hour := Hour;
  Result.Minute := Minute;
  Result.Second := Second;
end;

function TSRec(const Year, Month, Day, Hour, Minute, Second: SmallInt): TTSRec;
begin
  Result.Date := DateRec(Year, Month, Day);
  Result.Time := TimeRec(Hour, Minute, Second);
end;

function FBDecDate(T: TFBDate): TDateRec;
  { The FBDecDate procedure is based in ndate() function of
    gds.cpp (FireBird API) }
var
  Century, Y, M, D: integer;
begin
  T := T - (1721119 - 2400001);
  Century := (4 * T - 1) div 146097;
  T := 4 * T - 1 - 146097 * Century;
  D := T div 4;
  T := (4 * D + 3) div 1461;
  D := 4 * D + 3 - 1461 * T;
  D := (D + 4) div 4;
  M := (5 * D - 3) div 153;
  D := 5 * D - 3 - 153 * M;
  D := (D + 5) div 5;
  Y := 100 * Century + T;

  if M < 10 then
    M := M + 3
  else begin
    M := M - 9;
    Y := Y + 1;
  end;

  Result.Year := Y;
  Result.Month := M;
  Result.Day := D;
end;

function FBDecTime(T: TFBTime): TTimeRec;
  { In FireBird: 1 second = 10000 }
var
  TotalSeconds: Cardinal;
begin
  TotalSeconds := T div ISC_TIME_SECONDS_PRECISION;

  Result.Hour := TotalSeconds div SECONDS_PER_HOUR;
  Result.Minute := (TotalSeconds div SECONDS_PER_MINUTE) mod SECONDS_PER_MINUTE;
  Result.Second := TotalSeconds mod SECONDS_PER_MINUTE;
end;

function FBDecTS(T: TFBTS): TTSRec;
begin
  Result.Date := FBDecDate(T.Date);
  Result.Time := FBDecTime(T.Time);
end;

function FBEncDate(T: TDateRec): TFBDate;
  { The FBEncDate function is based in nday() function of
    gds.cpp (FireBird API) }
var
  Century, ShortYear: integer;
begin
  if T.Month > 2 then
    T.Month := T.Month - 3
  else begin
    T.Month := T.Month + 9;
    T.Year := T.Year - 1;
  end;

  Century := T.Year div 100;
  ShortYear := T.Year - 100 * Century;

  Result :=
    (146097 * Century) div 4 +
    (1461 * ShortYear) div 4 +
    (153 * T.Month + 2) div 5 + T.Day + 1721119 - 2400001;
end;


function FBEncTime(T: TTimeRec): TFBTime;
begin
  Result :=
    (T.Hour * SECONDS_PER_HOUR +
     T.Minute * SECONDS_PER_MINUTE + T.Second)
     * ISC_TIME_SECONDS_PRECISION;
end;

function FBEncTS(T: TTSRec): TFBTS;
begin
  Result.Date := FBEncDate(T.Date);
  Result.Time := FBEncTime(T.Time);
end;

function FBTimeToSec(T: TFBTime): integer;
begin
  Result := T div ISC_TIME_SECONDS_PRECISION;
end;

function FBSecToTime(I: integer): TFBTime;
begin
  Result := I * ISC_TIME_SECONDS_PRECISION;
end;

function FBTSToSec(T: TFBTS): int64;
begin
  Result := int64(T.Date) * SECONDS_PER_DAY +
    int64(T.Time) div ISC_TIME_SECONDS_PRECISION;
end;

function FBDifAsSec(T1, T2: TFBTS): int64;
var
  Days, Seconds: integer;
begin
  if T1.Date < T2.Date then begin
    Days := T2.Date - T1.Date - 1;
    Seconds := SECONDS_PER_DAY - FBTimeToSec(T1.Time) +
      FBTimeToSec(T2.Time);
  end else if T1.Date > T2.Date then begin
    Days := T1.Date - T2.Date - 1;
    Seconds := SECONDS_PER_DAY - FBTimeToSec(T2.Time) +
      FBTimeToSec(T1.Time);
  end else begin { T1.Date = T2.Date }
    Days := 0;
    if T1.Time < T2.Time then
      Seconds := FBTimeToSec(T2.Time) - FBTimeToSec(T1.Time)
    else
      Seconds := FBTimeToSec(T1.Time) - FBTimeToSec(T2.Time);
  end;
  Result := int64(Days) * SECONDS_PER_DAY + int64(Seconds);
end;

function FBDifAsDay(T1, T2: TFBTS): double;
var
  X, Y: double;
begin
  X := T1.Date + (T1.Time div ISC_TIME_SECONDS_PRECISION) / SECONDS_PER_DAY;
  Y := T2.Date + (T2.Time div ISC_TIME_SECONDS_PRECISION) / SECONDS_PER_DAY;
  Result := X - Y;
{  if X > Y then
    Result := X - Y
  else
    Result := Y - X;}
end;

procedure FBIncYear(var T: TFBDate; const X: integer);
var
  R: TDateRec;
begin
  R := FBDecDate(T);

  Inc(R.Year, X);
  if (R.Month = 2) and (R.Day > 28) then begin
    if IsLeapYear(R.Year) then
      R.Day := 29
    else
      R.Day := 28;
  end;

  T := FBEncDate(R);
end;

procedure FBIncMonth(var T: TFBDate; const X: integer);
var
  R: TDateRec;
begin
  R := FBDecDate(T);

  Inc(R.Year, X div MONTHS_PER_YEAR);
  Inc(R.Month, X mod MONTHS_PER_YEAR);
  if R.Month > MONTHS_PER_YEAR then begin
    R.Month := R.Month - MONTHS_PER_YEAR;
    Inc(R.Year);
  end else if R.Month < 1 then begin
    R.Month := R.Month + MONTHS_PER_YEAR;
    Dec(R.Year);
  end;

  if (R.Month = 2) and (R.Day > 28) then begin
    if IsLeapYear(R.Year) then
      R.Day := 29
    else
      R.Day := 28;
  end else if (R.Day > MONTH_DAYS[R.Month]) then
    R.Day := MONTH_DAYS[R.Month];

  T := FBEncDate(R);
end;

procedure FBIncWeek(var T: TFBDate; const X: integer);
begin
  Inc(T, X * DAYS_PER_WEEK);
end;

procedure FBIncDay(var T: TFBDate; const X: integer);
begin
  Inc(T, X);
end;

procedure FBIncSecond(var T: TFBTS; const X: integer);
var
  TotalSeconds: int64;
  Seconds, Days: integer;
begin
  TotalSeconds := int64(FBTimeToSec(T.Time)) + int64(X);

  Days := integer(TotalSeconds div SECONDS_PER_DAY);
  Seconds := integer(TotalSeconds mod SECONDS_PER_DAY);

  if TotalSeconds < 0 then begin
    Dec(Days);
    Inc(Seconds, SECONDS_PER_DAY);
  end;

  FBIncDay(T.Date, Days);

  T.Time := FBSecToTime(Seconds);
end;

//******************************************************************************************
//******************************************************************************************

function LastDay(const Year, Month: SmallInt): SmallInt;
begin
  if (Month = 2) and IsLeapYear(Year) then
    Result := 29
  else
    Result := MONTH_DAYS[Month];
end;

function PosValue(const AbsValue, Base, Position: byte): integer;
var
  X: integer;
  I: byte;
begin
  if Position = 0 then
    Result := AbsValue
  else begin
    X := Base;
    for I := 2 to Position do
      X := X * Base;

    Result := X * AbsValue;
  end;
end;

function Trunc32(const X: double): integer;
//var
//  I: int64;
begin
  try
    Result := Trunc(X);
    //?? Sidiney (23/11/2021 11:38): Ver questão SQLServer, numero negativo estava sendo ignorado
//    I := Trunc(X);
//
//    if (I >= Low(integer)) and (I <= High(integer)) then
//      Result := integer(I)
//    else
//      Result := 0;
  except
    Result := 0;
  end;
end;

function Round32(const X: double): integer;
var
  I: int64;
  F: double;
begin
  try
    I := Trunc(X);

    if (I >= Low(integer)) and (I <= High(integer)) then begin
      Result := integer(I);

      F := Frac(X);
      if F <= -0.5 then
        Dec(Result)
      else if F >= 0.5 then
        Inc(Result);

    end else
      Result := 0;

  except
    Result := 0;
  end;
end;

function RoundDouble(const X: double): double;
var
  F: double;
begin
  Result := Int(X);

  F := Frac(X);
  if F <= -0.5 then
    Result := Result - 1
  else if F >= 0.5 then
    Result := Result + 1;
end;

function Age(const Birth, Today: TDateRec): integer;
begin
  if Today.Year <= Birth.Year then
    Result := 0
  else
  begin
    Result := Today.Year - Birth.Year;
    if (Today.Month < Birth.Month) or
       ((Today.Month = Birth.Month) and (Today.Day < Birth.Day)) then
      Dec(Result);
  end;
end;

//******************************************************************************************
//******************************************************************************************

Function LinhaDigitadaCodBarra(valor: String):string;
var
  linhaDigi : String;
  codiBarra : String;
begin
  linhaDigi := StringReplace(StringReplace(valor,' ','',[rfReplaceAll]),'.','',[rfReplaceAll]);
  codiBarra := Copy(linhaDigi,1,4)+
               Copy(linhaDigi,33,1)+
               Copy(linhaDigi,34,4)+
               Copy(linhaDigi,38,10)+
               Copy(linhaDigi,5,5)+
               Copy(linhaDigi,11,10)+
               Copy(linhaDigi,22,10);
  Result := codiBarra;
end;

function OnlyNumber(Texto: String): string;
var
  i: Integer;
begin
  Result := '';
  for I := 1 to Length(Texto) do
    if CharInSet(Texto[i], ['0'..'9']) then
      Result := Result + Texto[i];
end;



{ TConfWeb }

function TConfWeb.GetPApePess: String;
begin
  Result := FPApePess.ToUpper;
end;

function TConfWeb.GetPCodPess: String;
begin
  Result := FPCodPess;
end;

function TConfWeb.GetPDa1: TDateTime;
begin
  if FPDa1 = 0 then
    FPDa1 := FPDataServ;
  Result := FPDa1;
end;

function TConfWeb.GetPDa1Manu: TDateTime;
begin
  if FPDa1Manu = 0 then
    FPDa1Manu := FPDataServ;
  Result := FPDa1Manu;
end;

function TConfWeb.GetPDa2: TDateTime;
begin
  if FPDa2 = 0 then
    FPDa2 := FPDataServ;
  Result := FPDa2;
end;

function TConfWeb.GetPDa2Manu: TDateTime;
begin
  if FPDa2Manu = 0 then
    FPDa2Manu := FPDataServ;
  Result := FPDa2Manu;
end;

function TConfWeb.GetPDataServ: TDateTime;
begin
  {$if Defined(SAGLIB) or Defined(LIBUNI)}
  {$else}
    if (FPDataServ = 0) and GetPADOConn.Connected then
      FPDataServ := CalcData('SELECT '+DataAtuaSQL()+' AS VALO FROM DUAL');
  {$endif}
  Result := FPDataServ;
end;

function TConfWeb.GetPSisFilt: String;
begin
  Result := fPSisFilt;
end;

function TConfWeb.GetCodiPess: Integer;
begin
  Result := FCodiPess;
end;

function TConfWeb.GetSenha: String;
begin
  {$ifdef UsuaBD}
    if fSenha <> '' then
      Result := fSenha
    else if Usuario.ToUpper = 'CALLCENTER' then
      Result := 'ccerpsag'
    else if Usuario.ToUpper = 'ERPSAG_DESENV' then
      Result := GeraSenhDia(Date)
    else
      Result := SenhMaster;
  {$else}
    if fSenha <> '' then
      Result := fSenha
    else if Usuario.ToUpper = 'SAG' then
    begin
      if (PIsNaSAG = 1) and (PBas = 2) then
        Result := 'sag'
      else
        Result := '124565';
    end
    else if Usuario.ToUpper = 'PRATICAADM' then
      Result := 'PR_pratica2023_04_'
    else if Usuario.ToUpper = 'CALLCENTER' then
      Result := 'ccerpsag'
    else if Usuario.ToUpper = 'ERPSAG_DESENV' then
      Result := GeraSenhDia(Date)
    else
      Result := fSenha;
  {$endif}
end;

procedure TConfWeb.Assign(iValo: TConfWeb);
begin
  fModo := iValo.Modo;
  fTipoApli := iValo.TipoAplicacao;
  fPSisFilt := iValo.PSisFiltro;
  fTabeFilt := iValo.TabeFiltro;
  fServer := iValo.Server;
  fDatabase := iValo.Database;
  fUsuario := iValo.Usuario;
  fDriverID := iValo.DriverID;
  fCharacterSet := iValo.CharacterSet;
  fSistPrat := iValo.SistPrat;
  FCodiPrat := iValo.CodiPrat;
  fAtuaBD_Conn := nil; //iValo.AtuaBD_Conn;
  fSenha := iValo.Senha;
  fUsuaMaster := iValo.UsuaMaster;
  fSenhMaster := iValo.SenhMaster;

  FCodiPess := iValo.CodiPess;
  FPCodPess := iValo.PCodPess;
  FPDa1Manu := iValo.PDa1Manu;
  FPDa2Manu := iValo.PDa2Manu;
  FEmpresas := iValo.Empresas;
  FCodiEmpresas := iValo.CodiEmpresas;
  FcgcMatriz := iValo.cgcMatriz;
  FCalcMax_ColeLote_SQL_ := iValo.CalcMax_ColeLote_SQL_;
  FCalcMax_ColeLote_Data := iValo.CalcMax_ColeLote_Data;
  FPOChBuscPosi.Topo := iValo.POChBuscPosi.Topo;
  FPOChBuscPosi.Esqu := iValo.POChBuscPosi.Esqu;
  FPOChBuscPosi.Altu := iValo.POChBuscPosi.Altu;
  FPOChBuscPosi.Tama := iValo.POChBuscPosi.Tama;
  FPLblAjud := iValo.PLblAjud;
  FPPrgPrin := iValo.PPrgPrin;
  FPPrgPri1 := iValo.PPrgPri1;
  FPDataServ := iValo.PDataServ;
  FPDa1 := iValo.PDa1;
  FPDa2 := iValo.PDa2;
  FPApePess := iValo.PApePess;
  FPNomUsua := iValo.PNomUsua;
  FPNomEmpr := iValo.PNomEmpr;
  FPNomSist := iValo.PNomSist;
  FPCodEmpr := iValo.PCodEmpr;
  FPIsSAG_SenhAdm := iValo.PIsSAG_SenhAdm;
  FPIsSAG_SenhMast := iValo.PIsSAG_SenhMast;
  FPAux := iValo.PAux;
  FPPerIdad := iValo.PPerIdad;
  FPBasTest := iValo.PBasTest;
  FPBasTC := iValo.PBasTC;
  FPClientCria := iValo.PClientCria;
  FAtuaVers := iValo.AtuaVers;
  FConfRela := iValo.ConfRela;
  FADOConn := nil; //iValo.ADOConn;
  FsgTrans := nil; //iValo.sgTrans;
  FListImag := nil; //iValo.ListImag;
  FCodiEmpr := iValo.CodiEmpr;
  FPBas := iValo.PBas;
  FCodiGrUs := iValo.CodiGrUs;
  FCodiTabe := iValo.PCodiTabe;
  FPMelAjus := iValo.PMelAjus;
  FPLogTipo := iValo.PLogTipo;
  FPZoo := iValo.PZoo;
  FPIsNaSAG := iValo.PIsNaSAG;
  FCodiMoni := iValo.CodiMoni;
  FPGruGrid := iValo.PGruGrid;
  FPRowGrid := iValo.PRowGrid;
  FCodiProd := iValo.CodiProd;
  FPUppeCase := iValo.PUppeCase;
  FIsPratic := iValo.IsPratic;
  FCodiIdio := iValo.CodiIdio;
  FPIsSAG_Dese := iValo.PIsSAG_Dese;
  FPIsSAG_Cons := iValo.PIsSAG_Cons;
  FPIsSAG_Supo := iValo.PIsSAG_Supo;
  FPIsSAG_Adm := iValo.PIsSAG_Adm;
  FPIsSAG_Come := iValo.PIsSAG_Come;
  FPIsSAG_Secr := iValo.PIsSAG_Secr;
  FPIsSAG_Senh := iValo.PIsSAG_Senh;
  FPIsSAG := iValo.PIsSAG;
end;

constructor TConfWeb.Create;
begin
  FMemValo := TStringList.Create();
  FMemVal1 := TStringList.Create();
  FMemRela := TStringList.Create();
  FPDataServ := 0;
  fModo := {$ifdef ERPUNI} cwModoBrowser {$else} cwDesktop {$endif};
  FCodiIdio := -1;
  FPOChBuscPosi := TPOChBusc_Padr.Create;
end;

constructor TConfWeb.sgCreate(Owner: TComponent);
begin
  Create();
  Parent := Owner;
end;

destructor TConfWeb.Destroy;
begin
  if Assigned(FMemValo) then
    FreeAndNil(FMemValo);
  if Assigned(FMemVal1) then
    FreeAndNil(FMemVal1);
  if Assigned(FMemRela) then
    FreeAndNil(FMemRela);
  FreeAndNil(FPOChBuscPosi);
end;

function TConfWeb.GetAtuaBD_Conn: TsgADOConnection;
var
  Cone: String;

  function GetAtuaBD_Conn_Troc(iCone, iChav, iValo: String): String;
  var
    aCamp: TsgArrayString;
    i: Integer;
    vAcho: Boolean;
  begin
    vAcho := False;
    aCamp := Split(iCone, ';');
    for i := 0 to Length(aCamp) - 1 do
    begin
      if iChav.ToUpper.Trim = Copy(aCamp[i], -1, Pos('=',aCamp[i])-1).ToUpper.Trim then
      begin
        if Pos('=',aCamp[i]) > 0 then
        begin
          aCamp[i] := Copy(aCamp[i], -1, Pos('=',aCamp[i])) + iValo;
          vAcho := True;
          Break;
        end;
      end;
    end;
    for i := 0 to Length(aCamp) - 1 do
      Result := Result + aCamp[i] + Se(i=Length(aCamp)-1, '', ';');
    if not vAcho then
      Result := Result + ';' + iChav + '=' + iValo;
    Result := SubsPalaTudo(Result,';;',';');
  end;

begin
  if Assigned(fAtuaBD_Conn) then
  begin
    {$ifdef DATASNAP}
      fAtuaBD_Conn := TsgADOConnection(DtmPoul.SckCone);
    {$else}
      if not fAtuaBD_Conn.Connected then
      begin
        fUsuario := UsuaMaster;
        fSenha   := SenhMaster;
        {$ifdef SGGE}
          Cone := GetConnectionString;
        {$else}
          Cone := GetPADOConn.ConnectionString;
          {$ifdef Pratica}
            //SidiPrat
            //Cone := GetAtuaBD_Conn_Troc(Cone, 'Initial Catalog', 'SAG');
            //Cone := GetAtuaBD_Conn_Troc(Cone, 'User ID', 'SAG');
            Cone := GetAtuaBD_Conn_Troc(Cone, 'User ID', 'Pratica');
            Cone := GetAtuaBD_Conn_Troc(Cone, 'password', AtuaBD_Senh);
          {$else}
            {$ifdef UsuaBD}
              Cone := GetAtuaBD_Conn_Troc(Cone, 'password', SenhMaster);
            {$else}
              Cone := GetAtuaBD_Conn_Troc(Cone, 'User ID', AtuaBD_Usua);
              Cone := GetAtuaBD_Conn_Troc(Cone, 'password', AtuaBD_Senh);
            {$endif}
          {$endif}
        {$endif}
        fAtuaBD_Conn.ConnectionString := Cone;
        fAtuaBD_Conn.PBas := GetPADOConn.PBas;
        fAtuaBD_Conn.Open;
      end;
    {$endif}
    Result := fAtuaBD_Conn
  end
  else
    Result := GetPADOConn;
end;

function TConfWeb.GetAtuaBD_Usua: String;
begin
  {$ifdef UsuaBD}
    Result := UsuaMaster;
  {$else}
    if GetIsNaSAG then
    begin
      if isPratic or (GetPBas = 2) or (Usuario.ToUpper = 'SAGADM') then
        Result := 'SAG'
      else
        Result := Usuario;
    end
    else
    begin
      if IsPratic then
        Result := 'SAG'
      else
        Result := GetPNomAbreSoft();
    end;
  {$endif}
end;

function TConfWeb.GetAtuaBD_Senh: String;
begin
  {$ifdef UsuaBD}
    Result := SenhMaster;
  {$else}
    if GetIsNaSAG then
    begin
      if isPratic or (GetPBas = 2) then
        Result := 'sag'
      else if (Usuario.ToUpper = 'SAGADM') then
        Result := '124565'
      else
        Result := Senha;
    end
    else
    begin
      if isPratic then
        Result := '124565'
      else
        Result := '124565';
    end;
  {$endif}
end;

function TConfWeb.GetSite: String;
begin
  {$IF Defined(Pratica) or Defined(DLL_Pratica)}
    {$ifdef CW}
      Result := 'controladorianaweb.com.br';
    {$else}
      Result := 'gestaopratica.com.br';
    {$endif}
  {$else}
    if IsRx then
      Result := 'rxsistemas.com.br'
    else
    begin
      case TipoAplicacao of
        apGold: Result := 'GoldenAves.com.br';
        apPrat: Result := 'GestaoPratica.com.br';
        apCW  : Result := 'ControladoriaNaWeb.com.br';
      else
        Result := 'SAG.com.br';
      end;
    end;
  {$endif}
  {$ifdef INTOTUM}
    Result := 'intotumse.com.br';
  {$endif}
  {$ifdef BEN}
    Result := 'beneggs.org.br';
  {$endif}
end;

function TConfWeb.GetSQLTabelas: String;
begin
  Result := '';

  if TabeFiltro <> '' then
  begin
    Result := SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(TabeFiltro
                ,':RETOPSIS',QuotedStr('S' + ZeroEsqu(IntToStr(GetPSis),02)))
                ,':RETOPUSU',QuotedStr(GetPCodPess))
                ,':RETOPEMP',QuotedStr(GetPCodEmpr))
                ,':APELPESS',QuotedStr(GetPApePess))
                ,':CODIPESS',IntToStr(GetCodiPess))
                ;
  end
  else
  begin
//    if TipoAplicacao = apCall then
//      Result := 'AND (SistTabe LIKE '+QuotedStr(FormLikeSQL +'S88'+ FormLikeSQL)+')'
//    else
      Result := 'AND (SistTabe LIKE '+QuotedStr(FormLikeSQL +PSisFiltro+ FormLikeSQL)+')';
  end;

  if TipoAplicacao = apRela then
    Result := Result + ' AND (CodiTabe BETWEEN 59000 AND 59999)'
//  else
//    Result := Result + ' AND (POCaTabe.CodiTabe NOT BETWEEN 52000 AND 59999)';
end;

function TConfWeb.GetTokenBI: String;
begin
  {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
    if FTokenBI = '' then
    begin
      FTokenBI := CalcStri('SELECT TOKEEMPR FROM POCAEMPR WHERE CODIEMPR = '+IntToStr(FCodiEmpr));
    end;
  {$else}
  {$endif}
  Result := FTokenBI;
end;

procedure TConfWeb.SetVersao_Delp(const Value: String);
begin
  {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
    GravPara(000, CripXe7('VERSAO_DELP'), CripXe7(Value));
  {$else}
  {$endif}
end;

function TConfWeb.GetVersao_Delp: String;
begin
  {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
    Result := Des_CripXe7(PegaPara(000,CripXe7('VERSAO_DELP')));
    if RetoZero(Result) = '0' then
      Result := Des_Crip(PegaPara(000,Crip('VERSAO_DELP')));
  {$else}
  {$endif}
end;

function TConfWeb.GetConfConf: String;
begin
  Result := GetPCodPess()+GetPCodEmpr()+GetPCodSist();
end;

function TConfWeb.SetCampPers_ConfWeb(Camp, Linh: String): Boolean;
begin
  Result := True;
  if Camp = 'SET_CONF' then
  begin
    SetPCodPess(Copy(Linh,01,03));
    SetPCodEmpr(Copy(Linh,04,03));
    SetPSis(StrToInt(RetoZero(RetiMascTota(Copy(Linh,08,02)))));
  end;
end;

procedure TConfWeb.SetCodiPrat(const Value: Integer);
begin
  if FCodiPrat <> Value then
  begin
    FCodiPrat := Value;
    SistPrat  := '';
  end;
end;

procedure TConfWeb.SetModo(iModo: String);
begin
  fModo := cwModoBrowser;
  {$if Defined(ERPUNI) and not Defined(LIBUNI) and not Defined(TRAY)}
    if StrIn(UpperCase(iModo.Trim), ['MOB','MOBILE']) then
      fModo := cwModoMobile
    else if (iModo = '') and (UniSession.IsMobile or UniSession.IsPhone) then
      fModo := cwModoMobile
  {$else}
  {$endif}
end;

procedure TConfWeb.SetParent(const Value: TComponent);
begin
  FParent := Value;
end;

procedure TConfWeb.SetPCodPess(const Value: String);
begin
  FPCodPess := ZeroEsqu(Value, 03);
end;

procedure TConfWeb.SetCodiEmpr(const Value: Integer);
begin
  if FCodiEmpr <> Value then
  begin
    FCodiEmpr := Value;
    FTokenBI := '';
  end;
end;

procedure TConfWeb.SetPublData(Index: Integer; const Value: TDateTime);
begin
  FPublData[Index] := Value;
end;

procedure TConfWeb.SetPublInte(Index: Integer; const Value: Int64);
begin
  FPublInte[Index] := Value;
end;

procedure TConfWeb.SetPublReal(Index: Integer; const Value: Extended);
begin
  FPublReal[Index] := Value;
end;

procedure TConfWeb.SetPublStri(Index: Integer; const Value: String);
begin
  FPublStri[Index] := Value;
end;

procedure TConfWeb.SetPublValo(Index: Integer; const Value: String);
begin
  FPublValo[Index] := Value;
end;

function TConfWeb.GetPublData(Index: Integer): TDateTime;
begin
  Result := FPublData[Index];
end;

function TConfWeb.GetPublInte(Index: Integer): Int64;
begin
  Result := FPublInte[Index];
end;

function TConfWeb.GetPublReal(Index: Integer): Extended;
begin
  Result := FPublReal[Index];
end;

function TConfWeb.GetPublStri(Index: Integer): String;
begin
  Result := FPublStri[Index];
end;

function TConfWeb.GetPublValo(Index: Integer): String;
begin
  Result := FPublValo[Index];
end;

procedure TConfWeb.SetCodiPess(const Value: Integer);
begin
  FCodiPess := Value;
end;

procedure TConfWeb.SetTipoAplicacao(iTipo: String);
begin
  iTipo := AnsiUpperCase(iTipo.Trim);
  if iTipo = 'RELA' then
    fTipoApli := apRela
  else if iTipo = 'CALL' then
    fTipoApli := apCall
  else if StrIn(iTipo, ['GOL','GOLD']) then
    fTipoApli := apGold
  else if iTipo = 'PRAT' then
    fTipoApli := apPrat
  else if iTipo = 'INTO' then
    fTipoApli := apInto
  else
    fTipoApli := apGera;
end;

{ TCustomConfTabe }

constructor TCustomConfTabe.Create;
begin
  inherited;
  FGravTabe := '';
end;

destructor TCustomConfTabe.Destroy;
begin
  if Assigned(FConfMovi) then
    FreeAndNil(FConfMovi);
  inherited;
end;

procedure TCustomConfTabe.Assign(iConf: TPersistent);
begin
  if Assigned(iConf) then
  begin
    FCodiTabe := TCustomConfTabe(iConf).CodiTabe;
    FCodiGrav := TCustomConfTabe(iConf).CodiGrav;
    FGravTabe := TCustomConfTabe(iConf).GravTabe;
    FNomeTabe := TCustomConfTabe(iConf).NomeTabe;
    FNomeSgCh := TCustomConfTabe(iConf).NomeSgCh;
    FValoSgCh := TCustomConfTabe(iConf).ValoSgCh;
    FNomeCodi := TCustomConfTabe(iConf).NomeCodi;
    FFormTabe := TCustomConfTabe(iConf).FormTabe;
    FChavTabe := TCustomConfTabe(iConf).ChavTabe;
    FHintTabe := TCustomConfTabe(iConf).HintTabe;
  end;
end;

function TCustomConfTabe.GetCaptTabe: String;
begin
  {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
    if (FCaptTabe = '') and (CodiTabe > 0) then
      FCaptTabe := DtmPoul.Tabelas_Busc('CaptTabe', '(CodiTabe = '+IntToStr(CodiTabe)+')');
  {$ELSE}
  {$ENDIF}
  Result := FCaptTabe;
end;

function TCustomConfTabe.GetConfMovi: TCustomConfTabe;
begin
  if not Assigned(FConfMovi) then
    FConfMovi := TCustomConfTabe.Create;
  Result := FConfMovi;
end;

function TCustomConfTabe.GetFinaTabe: String;
begin
  Result := Copy(GravTabe,05,MaxInt);
end;

function TCustomConfTabe.GetFormTabe: String;
begin
  {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
    if (FFormTabe = '') and (CodiTabe > 0) then
      FFormTabe := DtmPoul.Tabelas_Busc('FormTabe', '(CodiTabe = '+IntToStr(CodiTabe)+')');
  {$ELSE}
  {$ENDIF}
  Result := AnsiUpperCase(FFormTabe);
end;

function TCustomConfTabe.GetGravTabe: String;
begin
  {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
    if (FGravTabe = '') and (CodiTabe > 0) then
      FGravTabe := DtmPoul.Tabelas_Busc('GravTabe', '(CodiTabe = '+IntToStr(CodiTabe)+')');
  {$ELSE}
  {$ENDIF}
  Result := AnsiUpperCase(FGravTabe);
end;

function TCustomConfTabe.GetNomeCodi: String;
begin
  if FNomeCodi = '' then
    FNomeCodi := 'Codi'+Copy(GravTabe,05,MaxInt);
  Result := FNomeCodi;
end;

function TCustomConfTabe.GetNomePDat: String;
begin
  Result := 'PDat'+FinaTabe;
end;

function TCustomConfTabe.GetNomePEmp: String;
begin
  Result := 'PEmp'+FinaTabe;
end;

function TCustomConfTabe.GetNomePSis: String;
begin
  Result := 'PSis'+FinaTabe;
end;

function TCustomConfTabe.GetNomePUsu: String;
begin
  Result := 'PUsu'+FinaTabe;
end;

function TCustomConfTabe.GetNomeSgBu: String;
begin
  if FNomeSgBu = '' then
    FNomeSgBu := 'sgbu'+Copy(GravTabe,05,MaxInt);
  Result := FNomeSgBu;
end;

function TCustomConfTabe.GetNomeSgCh: String;
begin
  if fNomeSgCh = '' then
    fNomeSgCh := 'sgch'+Copy(GravTabe,05,MaxInt);
  Result := FNomeSgCh;
end;

function TCustomConfTabe.GetNomeSgTb: String;
begin
  if FNomeSgTb = '' then
    FNomeSgTb := 'sgtb'+Copy(GravTabe,05,MaxInt);
  Result := FNomeSgTb;
end;

function TCustomConfTabe.GetNomeTabe: String;
begin
  {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
    if (FNomeTabe = '') and (CodiTabe > 0) then
      FNomeTabe := DtmPoul.Tabelas_Busc('NomeTabe', '(CodiTabe = '+IntToStr(CodiTabe)+')');
  {$ELSE}
  {$ENDIF}
  Result := FNomeTabe;
end;

function TCustomConfTabe.GetValoSgCh: String;
begin
  if FValoSgCh = '' then
    FValoSgCh := GeraChavGrav;
  Result := FValoSgCh;
end;

function TCustomConfTabe.GetVersTabe: Integer;
begin
  {$if not Defined(SAGLIB) and not Defined(LIBUNI)}
    if (FVersTabe = 0) and (CodiTabe > 0) then
    begin
      FVersTabe := sgStrToInt(DtmPoul.Tabelas_Busc('VersTabe', '(CodiTabe = '+IntToStr(CodiTabe)+')'));
      if FVersTabe = 0 then
        FVersTabe := 1;
    end;
  {$ELSE}
  {$ENDIF}
  Result := FVersTabe;
end;

procedure TCustomConfTabe.Limpa;
begin
  FCodiGrav:= 0;
  FGravTabe:= '';
  FNomeTabe:= '';
  FNomeSgCh:= '';
  FValoSgCh:= '';
  FNomeCodi:= '';
  FCodiTabe:= 0;
  FFormTabe:= '';
  FCaptTabe:= '';
  FChavTabe:= 0;
  FHintTabe:= '';
  //FOperacao: TDec_Operacao;
  FClicConf:= False;
  FClicCanc:= False;
  FFechaConfirma:= False;
  FSituGrav:= True;
  //FConfMovi: TCustomConfTabe;
  FVersTabe:= 0;
end;

procedure TCustomConfTabe.SetCodiTabe(const Value: Integer);
begin
  if FCodiTabe <> Value then
  begin
    FCodiTabe := Value;
    FNomeTabe := '';
    FGravTabe := '';
    FCaptTabe := '';
    FFormTabe := '';
    FVersTabe := 0;
  end;
end;

procedure TCustomConfTabe.SetGravTabe(const Value: String);
begin
  FGravTabe := Value;
end;

procedure TCustomConfTabe.SetSituGrav(const Value: Boolean);
begin
  FSituGrav := Value;
  if Value then
    Operacao := opIncl
  else
    Operacao := opAlte;
end;

{ TsgSenh }

constructor TCustomsgSenh.Create;
begin
  inherited;
  FDataSenh := FormatDateTime('DDMMYY',Date);
end;

destructor TCustomsgSenh.Destroy;
begin
  inherited;
end;

procedure TCustomsgSenh.SetContra(const Value: String);
{******************************************************************************************
---> Esquema da ContraSenha
  01 a 03 - Empresa: SAG
  04 a 09 - Data   : DD/MM/YY
  10 a 12 - Sistema: 009
  13 a 13 - Tipo   : 1 (de 0 a Z)
  14 a 21 - Nume   : 12.345.678
  22 a 29 - Num1   : 12.345.678
  30 a 34 - Senha  : 3 (validação da ContraSenha)
  34 a 36 - Digi   : SomaCara
*******************************************************************************************}
begin
  if fContra <> Value then
  begin
    fContra := DeixLetrNume(DesMistura(Des_CripXe7(Value)));
    EmprCont := Copy(fContra,01,03);
    DataCont := Copy(fContra,04,06);
    SistCont := Copy(fContra,10,03);
    TipoCont := Copy(fContra,13,01);
    NumeCont := Copy(fContra,14,08);
    Num1Cont := Copy(fContra,22,08);
    SenhCont := Copy(fContra,30,03);
    DigiCont := Copy(fContra,33,03);
  end;
end;

function TCustomsgSenh.GeraContra(iMens: Boolean = True): String;

  function GeraContra_Valida(): Boolean;
  begin
    Result := False;
    if TipoCont = '7' then
      Result := True
    else if (PrazCont - Date) > DiasCont then
      Mensagem('Prazo de Validade ultrapassou o número de Dias permitido! (Cliente: '+FormInteBras(CodiPess)+')', iMens)
    else if (EnceModu = 0) then
      Mensagem('Cliente sem prazo definido para ContraSenha! (Cliente: '+FormInteBras(CodiPess)+')', iMens)
    else if (PrazCont > EnceModu) then
      Mensagem('Prazo de Validade ultrapassou o Encerramento do Contrato! (Cliente: '+FormInteBras(CodiPess)+')', iMens)
    else if (StrToInt(NumeCont) > MaxiCont) then
      Mensagem('Valor de controle é maior que o Permitido! (Cliente: '+FormInteBras(CodiPess)+')', iMens)
    else if (StrToInt(Num1Cont) > Max1Cont) then
      Mensagem('Valor de controle (1) é maior que o Permitido! (Cliente: '+FormInteBras(CodiPess)+')', iMens)
    else
      Result := True;
  end;
begin
  if GeraContra_Valida then
  begin
    Result := EmprCont
             +DataCont
             +SistCont
             +TipoCont
             +NumeCont
             +Num1Cont
             +CalcDigiSenh()
             +CalcDigiCont()
              ;
    Result := CripXe7(Mistura(Result));
  end;
end;

procedure TCustomsgSenh.SetPrazCont(const Value: TDateTime);
begin
  FPrazCont := Value;
  DataCont  := FormatDateTime('DDMMYY',FPrazCont);
end;

function TCustomsgSenh.CalcDigiCont(): String;
begin
  Result := ZeroEsqu(IntToStr(SomaCaraAscii(EmprCont, True)+
                                   SomaCara(DataCont
                                           +SistCont
                                           +NumeCont
                                           +Num1Cont
                                           +TipoCont
                                           +CalcDigiSenh(), True) + CalcDigiPers())
            , 03);
end;

procedure TCustomsgSenh.SetSenha(const Value: String);
{******************************************************************************************
---> Esquema da Senha Recebida
  01 a 03 - Empresa: SAG
  04 a 09 - Data   : DD/MM/YY
  10 a 12 - Sistema: 009
  13 a 19 - Versão : 7.1.04.230 => 7104230
  20 a 20 - Opção  : 1 (de 0 a Z)
  21 a 23 - Digi   : SomaCara = SomaCara com Peso
*******************************************************************************************}
begin
  if fSenha <> Value then
  begin
    fSenha := DesMistura(DeixLetrNume(Value));
    EmprSenh := Copy(fSenha,01,03);
    DataSenh := Copy(fSenha,04,06);
    SistSenh := Copy(fSenha,10,03);
    VersSenh := Copy(fSenha,13,07);
    OpcaSenh := Copy(fSenha,20,01);
    DigiSenh := Copy(fSenha,21,03);
  end;
end;

function TCustomsgSenh.FormataSenha(iSenh: String): String;
var
  I: Integer;
begin
  Result := InvePala(iSenh);
  for I := 1 to Trunc(Length(Result)/3) do
    Result.Insert((3*i)+(i-1),'.');
  Result := InvePala(Result);
end;

function TCustomsgSenh.GeraSenha(iMens: Boolean = True): String;
begin
  Result := '';
  begin
    Result := EmprSenh
             +DataSenh
             +SistSenh
             +VersSenh
             +OpcaSenh
             +CalcDigiSenh()
              ;
    Result := FormataSenha(Mistura(Result));
  end;
end;

function TCustomsgSenh.CalcDigiSenh(): String;
begin
  Result := ZeroEsqu(IntToStr(SomaCaraAscii(EmprSenh, True)+
                                   SomaCara(DataSenh
                                           +SistSenh
                                           +VersSenh
                                           +OpcaSenh, True) - CalcDigiPers())
            , 03);
end;

function TCustomsgSenh.CalcDigiPers(): Integer;
var
  vDigi, vVers: Integer;
begin
  vVers := sgStrtoInt(Copy(VersSenh,01,02));
  vDigi := 3;
  if isRx9() then  //INTOTUM
  begin
    if vVers <= 7104 then
      vDigi := 3;
  end
  else
  begin
    if vVers <= 7104 then
      vDigi := 3;
  end;
  Result := vDigi;
end;

function TCustomsgSenh.Mistura(iValo: String): String;
var
  i, Divi: Integer;
begin
  Divi := Trunc(Length(iValo)/2);

  Result := '';
  for I := 1 to Divi do
    Result := Result + iValo[Divi+i] + iValo[i];

  //String Impar
  if Length(iValo) > (Divi * 2) then
    Result := Result + iValo[Length(iValo)];
end;

function TCustomsgSenh.DesMistura(iValo: String): String;
var
  i, Divi: Integer;
  Part1, Part2: String;
begin
  Divi := Trunc(Length(iValo)/2);
  Part1 := '';
  Part2:= '';
  for I := 1 to Divi*2 do
  begin
    if i mod 2 = 0 then
      Part1 := Part1 + iValo[i]
    else
      Part2 := Part2 + iValo[i]
  end;
  Result := Part1 + Part2;

  //String Impar
  if Length(iValo) > (Divi * 2) then
    Result := Result + iValo[Length(iValo)];
end;

function TCustomsgSenh.GetDataCont: String;
begin
  Result := ZeroEsqu(FDataCont,06);
end;

function TCustomsgSenh.GetDataSenh: String;
begin
  Result := ZeroEsqu(FDataSenh,06);
end;

function TCustomsgSenh.GetDigiCont: String;
begin
  Result := ZeroEsqu(FDigiCont,03);
end;

function TCustomsgSenh.GetDigiSenh: String;
begin
  Result := ZeroEsqu(FDigiSenh,03);
end;

function TCustomsgSenh.GetEmprCont: String;
begin
  Result := ZeroEsqu(FEmprCont,03);
end;

function TCustomsgSenh.GetEmprSenh: String;
begin
  Result := ZeroEsqu(FEmprSenh,03);
end;

function TCustomsgSenh.GetNumeCont: String;
begin
  Result := ZeroEsqu(FNumeCont,08);
end;

function TCustomsgSenh.GetNum1Cont: String;
begin
  Result := ZeroEsqu(FNum1Cont,08);
end;

function TCustomsgSenh.GetOpcaSenh: String;
begin
  Result := ZeroEsqu(FOpcaSenh,01);
end;

function TCustomsgSenh.GetSenhCont: String;
begin
  Result := ZeroEsqu(FSenhCont,03);
end;

function TCustomsgSenh.GetSistCont: String;
begin
  Result := ZeroEsqu(FSistCont,03);
end;

function TCustomsgSenh.GetSistSenh: String;
begin
  Result := ZeroEsqu(FSistSenh,03);
end;

function TCustomsgSenh.GetTipoCont: String;
begin
  Result := ZeroEsqu(FTipoCont,01);
  if Result = '0' then
    Result := '1';
end;

function TCustomsgSenh.GetVersSenh: String;
begin
  Result := ZeroEsqu(RetiMascTota(FVersSenh),07);
end;

function TCustomsgSenh.GetVersSenhForm: String;
begin
  Result := VersSenh;
  Result.Insert(4,'.');
  Result.Insert(2,'.');
  Result.Insert(1,'.');
end;

function TCustomsgSenh.ValiCont(iMens: Boolean = True; iGeral: Boolean = False): Boolean;
begin
  Result := False;
  if Contra = '' then
  begin
    Mensagem('Digite a ContraSenha', iMens);
  end
  else if EmprSenh <> EmprCont then
  begin
    //Empresa não confere
    Mensagem('ContraSenha Inválida (Cod 001)', iMens);
  end
  else if (not iGeral) and (SistSenh <> SistCont) then
  begin
    //Sistema não Confere
    Mensagem('ContraSenha Inválida (Cod 002)', iMens);
  end
  else if SenhCont <> DigiSenh then
  begin
    //Senha e ContraSenha não conferem
    Mensagem('ContraSenha Inválida (Cod 003)', iMens);
  end
  else if DigiCont <> CalcDigiCont then
  begin
    //Digito Verificador da ContraSenha não confere
    Mensagem('ContraSenha Inválida (Cod 004)', iMens);
  end
  else
    Result := True;
end;

function TCustomsgSenh.ValiSenh(iMens: Boolean = True): Boolean;
begin
  Result := False;
  if Senha = '' then
  begin
    Mensagem('Digite a Senha do Cliente! (Cod: 011)', iMens);
  end
  else if DigiSenh <> CalcDigiSenh then
  begin
    //Digito Verificador da Senha não confere
    Mensagem('Senha Inválida (Cod: 012)', iMens);
  end
  else
    Result := True;
end;

function TCustomsgSenh.MotivoSenha(): String;
begin
  if OpcaSenh = '1' then
    Result := 'Data de Validade'
  else if OpcaSenh = '2' then
    Result := 'Data de Acesso'
  else if OpcaSenh = '3' then
    Result := 'Data Validade e Número Controle'
  else if OpcaSenh = '5' then
    Result := 'Série do HD'
  else if OpcaSenh = '6' then
    Result := 'Número de Acessos'
  else
    Result := OpcaSenh + ' - Não Identificado';
end;

function TCustomsgSenh.TipoLicenca(): String;
begin
  if TipoCont = '1' then
    Result := '1-Por Volume'
  else if TipoCont = '2' then
    Result := '2-Por Usuário'
  else if TipoCont = '3' then
    Result := '3-Por Usuário no Módulo'
  else if TipoCont = '4' then
    Result := '4-Por Usuário no Módulo e Acesso Completo'
  else if TipoCont = '5' then
    Result := '5-Por Acesso Completo'
  else if TipoCont = '6' then
    Result := '6-Por Acesso Simultâneo'
  else if TipoCont = '7' then
    Result := '7-Senha do Dia'
  else
    Result := TipoCont + '-Não Identificado';
end;

procedure TCustomsgSenh.Mensagem(iMsg: String; iExib: Boolean);
begin
  if iExib then
    sgMessageDlg(iMsg, mtInformation, [mbOK], 0)
  else
    SetPLblAjud_Capt(iMsg);
end;

function HostDS(): String;
begin
  if FileExists(GetPEndExec()+'HostLoca.sag') then
    Result := '192.168.0.1'
  else
    Result := SeStri(GetIsNaSAG(),'192.168.0.1','servidor.sag.com.br')
end;

function TiraEspaLinhFinaList(iText: String): String;
var
  vAuxi: TStringList;
  i: Integer;
begin
  vAuxi := TStringList.Create;
  try
    vAuxi.Text := iText;
    for I := vAuxi.Count-1 downto 0 do
    begin
      if (vAuxi.Strings[i].Trim = '') or (vAuxi.Strings[i].Trim = '<br>') then
        vAuxi.Delete(i)
      else
        Break;
    end;
    Result := vAuxi.Text;
  finally
    vAuxi.Free;
  end;
end;

function TiraAteENDFinaList(iText: String): String;
var
  vAuxi: TStringList;
  i: Integer;
begin
  vAuxi := TStringList.Create;
  try
    vAuxi.Text := iText;
    for I := vAuxi.Count-1 downto 0 do
    begin
      if sgCopy(vAuxi.Strings[i].Trim,01,03) = 'END' then
        Break
      else
        vAuxi.Delete(i);
    end;
    Result := vAuxi.Text;
  finally
    vAuxi.Free;
  end;
end;

function ValidaFormUnigui(iForm: String): Boolean;
begin
  Result := StrIn(AnsiUpperCase(Copy(iForm,01,12)),
                  ['TFRMPOHECAM6','TFRMVDUNPEDI','TFRMPOUNPESS','TFRMPOUNRELA','TFRMBECAIMAG'
                  ,'TFRMPOCATPMV','TFRMPOCACARG','TFRMCLCABLOQ','TFRMPOCAINDU','TFRMPOCHWEBB','TFRMPOCHWEBV'
                  ,'TFRMPECAVACI','TFRMPECAHIST','TFRMPECAGEST','TFRMPECAGADO','TFRMPECAAVAL','TFRMPOUTSQL_'
                  ,'TFRMGECHRELA','TFRMPOCAEMPR','TFRMPOCHACGR','TFRMPOCHACES','TFRMPOCHACES_NOVO','TFRMPOCHACGR_NOVO'
                  ,'TFRMCWCHIMPO','TFRMMPCACOLE','TFRMMPCACOBO','TFRMMPCHCOLE','TFRMCLCHREME','TFRMCLCHRETO'
                  ,'TFRMPOGESENH','TFRMPOGETROC','TFRMFSCAEVEN','TFRMPOCANOTA','TFRMABCHCAES','TFRMABCHCALA'
                  ]);
end;

function ValiMail(iMail: String): Boolean;
begin
  Result := not ((Pos('@', iMail) = 0) or (Pos('.', iMail) = 0));
end;

function Trat_POCaErro(iMens: String): String;
const cTama = 37;
type
  TErro = Record
    Erro: String;
    Err1: String;
    Mens: String;
  end;
var
  i: Integer;
  vErro: array of TErro;
begin
  SetLength(vErro, cTama);
  vErro[00].Erro := 'Impossível excluir a transferência cuja Ordem de Carregamento já esteja pesada!';
  vErro[00].Err1 := '';
  vErro[00].Mens := 'Impossível excluir a transferência cuja Ordem de Carregamento já esteja pesada!';
  vErro[01].Erro := 'UN_TIPO_NUME_CST';
  vErro[01].Err1 := '';
  vErro[01].Mens := 'CST já cadastrado. Favor verificar.';
  vErro[02].Erro := 'UN_NUMECFOP';
  vErro[02].Err1 := '';
  vErro[02].Mens := 'CFOP já cadastrado para o CST informado!';
  vErro[03].Erro := 'UN_POGETBJU_TIPOPERC';
  vErro[03].Err1 := '';
  vErro[03].Mens := 'Percentual já cadastrado para esse tipo de Juros!';
  vErro[04].Erro := 'O valor de chave desta linha foi alterado ou excluído do banco de dados. A linha local está agora excluída';
  vErro[04].Err1 := '';
  vErro[04].Mens := 'O valor de chave desta linha foi alterado ou excluído do banco de dados. A linha local está agora excluída';
  vErro[05].Erro := 'LC-NOTAAUXI-EXECDanf';
  vErro[05].Err1 := 'File not found';
  vErro[05].Mens := 'XML não encontrado!';
  vErro[06].Erro := 'FK_VDCAPEDI_CODC_POCAMVEN';
  vErro[06].Err1 := '';
  vErro[06].Mens := 'Informar um Endereço de Cobrança para o Cliente';
  vErro[07].Erro := 'A problem occurred in initializing MCI';
  vErro[07].Err1 := '';
  vErro[07].Mens := 'Dispositivo de Som não encontrado!';
  vErro[08].Erro := 'FK_VDCAPEOU_CODI_VDCATBPR';
  vErro[08].Err1 := '';
  vErro[08].Mens := 'Informe a Tabela de Preço';
  vErro[09].Erro := 'O valor de chave desta linha foi alterado ou excluído do repositório de dados. A linha local está agora excluída';
  vErro[09].Err1 := '';
  vErro[09].Mens := 'O valor de chave desta linha foi alterado ou excluído do repositório de dados. A linha local está agora excluída';
  vErro[10].Erro := 'UN_CLGEBLOQ_NUBA_CONT_DATA';
  vErro[10].Err1 := '';
  vErro[10].Mens := 'Boleto não gerado. Tente novamente!';

  vErro[11].Erro := 'Impossível excluir a transferência cuja Ordem de Carregamento já esteja pesada!';
  vErro[11].Err1 := '';
  vErro[11].Mens := 'Impossível excluir a transferência cuja Ordem de Carregamento já esteja pesada!';
  vErro[12].Erro := 'XML nao importado. Empresa atual';
  vErro[12].Err1 := '';
  vErro[12].Mens := 'XML não importado. Empresa atual não é a responsável pelo transporte.';
  vErro[13].Erro := 'Empresa atual nao possui CGC!';
  vErro[13].Err1 := '';
  vErro[13].Mens := 'Empresa atual não possui CNPJ em seu cadastro favor verificar!';
  vErro[14].Erro := 'XML nao importado. Empresa atual';
  vErro[14].Err1 := '';
  vErro[14].Mens := 'XML não importado. Empresa atual não é a responsável pelo transporte.';
  vErro[15].Erro := 'XML nao importado. Empresa atual';
  vErro[15].Err1 := '';
  vErro[15].Mens := 'XML não importado. Empresa atual não é a responsável pelo transporte.';
  vErro[16].Erro := 'Empresa atual nao possui CGC!';
  vErro[16].Err1 := '';
  vErro[16].Mens := 'Empresa atual não possui CNPJ em seu cadastro favor verificar!';
  vErro[17].Erro := 'UN_POGENOTA_NUMENOTA';
  vErro[17].Err1 := '';
  vErro[17].Mens := 'Nota não gerada. Tente novamente!';
  vErro[18].Erro := 'FK_FIGEADIA_CODIADIA) violada';
  vErro[18].Err1 := '';
  vErro[18].Mens := 'Não foi possível excluir este adiantamento pois existem Movimentos da tela Despesa de Viagem utilizando este registro!';
  vErro[19].Erro := 'Não encontrado parametrização necessária para geração da Nota Fiscal! Verifique os parâmetros de faturamento';
  vErro[19].Err1 := '';
  vErro[19].Mens := 'Não encontrado parametrização necessária para geração da Nota Fiscal! Verifique os parâmetros de faturamento.';
  vErro[20].Erro := 'FK_ESCAMVET_COD_POCAMVNO';
  vErro[20].Err1 := '';
  vErro[20].Mens := 'Registro vinculado a uma entrada de estoque por devolução de industrialização!';
  vErro[21].Erro := 'UN_NUMECFOP';
  vErro[21].Err1 := '';
  vErro[21].Mens := 'Impossível cadastrar o mesmo CFOP';
  vErro[22].Erro := 'UN_FIGECHEQ';
  vErro[22].Err1 := '';
  vErro[22].Mens := 'Já existe um cheque no sistema com este número, agência, conta e banco!';
  vErro[23].Erro := 'registro filho localizado';
  vErro[23].Err1 := '';
  vErro[23].Mens := 'Cadastro não pode ser excluído por estar presente em outro(s) cadastro(s)!!!';
  vErro[24].Erro := 'UK_FSCAMVID_ICDE_UF_PEMP';
  vErro[24].Err1 := '';
  vErro[24].Mens := 'É permitido apenas um cadastro de UF para o mesmo produto por Filial';
  vErro[24].Erro := 'UK_FSCAICDE_CODI_POCAPROD';
  vErro[25].Err1 := '';
  vErro[25].Mens := 'É Permitido sómente um cadastro de ICMS Interestadual por produto ';
  vErro[26].Erro := 'Pedido já enviado para aprovação. Exclusão inválida!';
  vErro[26].Err1 := '';
  vErro[26].Mens := 'Pedido já enviado para aprovação. Exclusão inválida!';
  vErro[27].Erro := 'Pedido aprovado. Exclusão inválida!';
  vErro[27].Err1 := '';
  vErro[27].Mens := 'Pedido aprovado. Exclusão inválida!';
  vErro[28].Erro := 'Pedido recusado. Exclusão inválida!';
  vErro[28].Err1 := '';
  vErro[28].Mens := 'Pedido recusado. Exclusão inválida!';
  vErro[29].Erro := 'Peso liquido carregado zerado';
  vErro[29].Err1 := '';
  vErro[29].Mens := 'Peso líquido carregado zerado.';
  vErro[30].Erro := 'FK_RAGEORPR_CODI_RACAMVOC';
  vErro[30].Err1 := '';
  vErro[30].Mens := 'Exclusão inválida da Ordem de Produção pois existem registros de estoque.';
  vErro[31].Erro := 'PRO_BLOQGERA_CONTA_HOMOLOGADA';
  vErro[31].Err1 := '';
  vErro[31].Mens := 'A Conta {} não está homologada! Operação não pode gerar o boleto!';
  vErro[32].Erro := 'TRG_CLCACONT_ATUA_HOMOCONT';
  vErro[32].Err1 := '';
  vErro[32].Mens := 'A Conta {} está homologada e não pode ser alterada!';
  vErro[33].Erro := 'TRG_CLCACONT_DELE_HOMOCONT';
  vErro[33].Err1 := '';
  vErro[33].Mens := 'A Conta {} está homologada e não pode ser excluída!';
  vErro[34].Erro := 'UN_VDCAMVPO_PROD_DATA';
  vErro[34].Err1 := '';
  vErro[34].Mens := 'Produto já enviado para este pedido!';
  vErro[35].Erro := 'FK_POCACOMP_CODI_POCACRIT';
  vErro[35].Err1 := '';
  vErro[35].Mens := 'Favor inserir um Critérios de Cotação (CODITABE: 840)';
  vErro[36].Erro := ' is not a valid floating point value for field';
  vErro[36].Err1 := '';
  vErro[36].Mens := 'O campo deve ter no máximo 12 caracteres, sem vírgula e com ponto para separar os decimais';

  Result := '';
  i := 0;
  while (Result = '') and (i < cTama) do
  begin
    if (sgPos(vErro[i].Erro, iMens) > 0) or ((vErro[i].Err1 <> '') and (sgPos(vErro[i].Err1, iMens) > 0)) then
      Result := vErro[i].Mens;
    Inc(i);
  end;

  Result := SubsPala(SubsPala(SubsPala(SubsPala(SubsPala(SubsPala(SubsPala(SubsPala(Result
                     ,'c?a','ção')
                     ,'n?a','não')
                     ,'s?a','são')
                     ,' ja ',' já ')

                     ,'C?O','ÇÃO')
                     ,'N?O','NÃO')
                     ,'S?O','SÃO')
                     ,' JA ',' JÁ ')
                     ;
end;

function TamaCamp_Ajusta(iTipo: TField; iTama: Integer): Integer; overload;
const
  cTamaCampNume = {$ifdef FD}  48 {$else}  16 {$ENDIF}; //VCL: proporção de 6x no Grid
  cTamaCampText = {$ifdef FD} 150 {$else}  30 {$ENDIF};
  cTamaCampData = {$ifdef FD}  39 {$else}  13 {$ENDIF};
  cDivi = {$ifdef FD} 5 {$else} 1 {$endif};
begin
  if not Assigned(iTipo) then
  begin
    if iTama < 0 then //tamanho a ser tratado
    begin
      Result := iTama * (-1);
      Result := Trunc(Result * cDivi);
    end
    else
      Result := Trunc(iTama / cDivi);
  end
  else
  begin
    if (iTama <= 0) AND (Copy(iTipo.FieldName, Length(iTipo.FieldName), 01) = '_') then  //Último caracter for um "_"
      Result := Length(iTipo.FieldName) * cDivi {$ifdef FD} * 2 {$else} {$endif}
    else
    begin
      if iTama > 0 then  //Respeita o valor passado, deseja ser deste tamanho
        Result := Abs(Trunc(iTama / cDivi))
      else  //Valor <= 0, trata
      begin
        Result := cTamaCampNume;
        case TipoDadoCara(iTipo) of
//         'N': iTipo.DisplayWidth := Result;
//         'I': iTipo.DisplayWidth := Result;
//         'B': iTipo.DisplayWidth := Result;
         'C': begin
                Result := cTamaCampText;
                if iTipo.DisplayWidth < Result then
                begin
                  if iTipo.DisplayWidth < 20 then
                    Result := 20
                  else
                    Result := iTipo.DisplayWidth;
                end;
              end;
         'D': begin
                Result := cTamaCampData;
                if iTipo.DisplayWidth < Result then
                  Result := iTipo.DisplayWidth;
              end;
        else
        end;
        {$ifdef FD}
        if iTipo.DisplayWidth = Result then //Se for igual, pode ter pego do DisplayWidth que é muito pequeno
          Result := Result * 2;
        {$else}
        {$ENDIF}
      end;
    end;
    iTipo.DisplayWidth := Result;
  end;
end;
function TamaCamp_Ajusta(iTipo: TField; iTama: String): Integer; overload;
var
  Tama: Integer;
begin
  Tama := sgStrToInt(iTama);
  Result := TamaCamp_Ajusta(iTipo, Tama);
end;

function CreateIconFromBitmap(Bitmap: TBitmap; TransparentColor: TColor): TIcon;
begin
  with TImageList.CreateSize(Bitmap.Width, Bitmap.Height) do
  begin
    try
      AllocBy := 1;
      AddMasked(Bitmap, TransparentColor);
      Result := TIcon.Create;
      try
        GetIcon(0, Result);
      except
        Result.Free;
        raise;
      end;
    finally
      Free;
    end;
  end;
end;

function isMobi_POCaCamp(iValo: String): String;
begin
  if GetConfWeb.Modo = cwModoMobile then
  begin
    Result := SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(
              SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(
              SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(iValo
              , 'TopoCamp', 'STopCamp')
              , 'MTopCamp', 'SMToCamp')
              , 'EsquCamp', 'SEsqCamp')
              , 'MEsqCamp', 'SMEsCamp')
              , 'TamaCamp', 'STamCamp')
              , 'AltuCamp', 'SAltCamp')
              , 'GuiaCamp', 'SGuiCamp')
              , 'ColuCamp', 'SColCamp')
              , 'CoEsCamp', 'SCoECamp')
              , 'LinhCamp', 'SLinCamp')
              , 'LiEsCamp', 'SLiECamp')
              , 'FixoCamp', 'SFixCamp')
              , 'FixoTabe', 'SFixTabe')
              , 'TamaTabe', 'STamTabe')
              , 'AltuTabe', 'SAltTabe')
    ;
  end
  else
    Result := iValo;
end;

function isMobi_POCaCamp_Sele(iValo: String): String;
begin
  if GetConfWeb.Modo = cwModoMobile then
  begin
    Result := SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(
              SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(
              SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(SubsPalaTudo(iValo
              , ', TopoCamp', ', STopCamp AS TopoCamp')
              , ', MTopCamp', ', SMToCamp AS MTopCamp')
              , ', EsquCamp', ', SEsqCamp AS EsquCamp')
              , ', MEsqCamp', ', SMEsCamp AS MEsqCamp')
              , ', TamaCamp', ', STamCamp AS TamaCamp')
              , ', AltuCamp', ', SAltCamp AS AltuCamp')
              , ', GuiaCamp', ', SGuiCamp AS GuiaCamp')
              , ', ColuCamp', ', SColCamp AS ColuCamp')
              , ', CoEsCamp', ', SCoECamp AS CoEsCamp')
              , ', LinhCamp', ', SLinCamp AS LinhCamp')
              , ', LiEsCamp', ', SLiECamp AS LiEsCamp')
              , ', OrdeCamp', ', SOrdCamp AS OrdeCamp')
              , ', FixoCamp', ', SFixCamp AS FixoCamp')
              , ', FixoTabe', ', SFixTabe AS FixoTabe')
              , ', TamaTabe', ', STamTabe AS TamaTabe')
              , ', AltuTabe', ', SAltTabe AS AltuTabe')

    ;
  end
  else
    Result := iValo;
end;

function ExecPers_isConst_Vali(iValo, iTipo: String): Boolean;
begin
  Result := iValo = QuotedStr(iTipo);
  if not Result then
    Result := iValo = QuotedStr('['+iTipo+']');
  if not Result then
    Result := iValo = '['+iTipo+']';
end;

function ExecPers_isVariData(iValo: String): Boolean;
var
  i: Integer;
  vValo: String;
begin
  vValo := iValo.ToUpper;
  Result := StrIn(vValo, cTipoDataVariavel);
  if not Result then
  begin
    for i := 1 to Length(cTipoDataVariavel) do
    begin
      Result := ExecPers_isConst_Vali(vValo, cTipoDataVariavel[i]);
      if Result then Exit;
    end;
  end;
end;

function ExecPers_isVariHora(iValo: String): Boolean;
var
  i: Integer;
  vValo: String;
begin
  vValo := iValo.ToUpper;
  Result := StrIn(vValo, cTipoHoraVariavel);
  if not Result then
  begin
    for i := 1 to Length(cTipoHoraVariavel) do
    begin
      Result := ExecPers_isConst_Vali(vValo, cTipoHoraVariavel[i]);
      if Result then Exit;
    end;
  end;
end;

function ExecPers_isConst(iValo: String): Boolean;
begin
  Result := ExecPers_isVariData(iValo) or ExecPers_isVariHora(iValo);
end;

Function CampPers_TratNome(const iNome:String): String;
begin
  {$ifdef ERPUNI}
    Result := SubsPalaTudo(iNome,'&','');
  {$else}
    Result := iNome;
  {$endif}
end;

Function CampPers_TratNome_Gera(const iNome:String): String;
begin
  Result := SubsPalaTudo(iNome,'&','');
end;

function Banc_TratWher(iWherAtua, iWherAdic: String): String;
//Acerta a WHERE conforme os valores passados nos parametros
begin
  if iWherAtua = '/*Sem Where*/' then iWherAtua := '';
  if iWherAdic = '/*Sem Where*/' then iWherAdic := '';

  Result := iWherAtua;
  iWherAtua := iWherAtua.Trim;
  if iWherAtua <> '' then //Não usar o Trim (passaado espaço para depois adicionar ao Where original)
  begin
    if (sgCopy(iWherAtua,01,05) <> 'WHERE') then
    begin
      if StrIn(sgCopy(iWherAtua,01,04), ['AND ','AND(']) then
        Result := 'WHERE '+Copy(iWherAtua,04,MaxInt).Trim
      else if StrIn(sgCopy(iWherAtua,01,03), ['OR ','OR(']) then
        Result := 'WHERE '+Copy(iWherAtua,03,MaxInt).Trim
      else if iWherAtua.Trim <> '' then
        Result := 'WHERE '+iWherAtua;
    end;
    Result := ' '+Result;
  end;

  iWherAdic := iWherAdic.Trim;
  if iWherAdic.Trim <> '' then
  begin
    if Result = '' then  //Não usar o Trim (passado espaço para depois adicionar o Where original)
    begin
      if (sgCopy(iWherAdic,01,05) = 'WHERE') then
        Result := iWherAdic
      else if StrIn(sgCopy(iWherAdic,01,04), ['AND ','AND(']) then
        Result := 'WHERE '+Copy(iWherAdic,04,MaxInt).Trim
      else if StrIn(sgCopy(iWherAdic,01,03), ['OR ','OR(']) then
        Result := 'WHERE '+Copy(iWherAdic,03,MaxInt).Trim
      else if iWherAdic <> '' then
        Result := 'WHERE '+iWherAdic;
    end
    else
    begin
      if (sgCopy(iWherAdic,01,05) = 'WHERE') then
        Result := Result+' AND '+Copy(iWherAdic,06,MaxInt).Trim
      else if not (StrIn(sgCopy(iWherAdic,01,04), ['AND ','AND(']) Or StrIn(sgCopy(iWherAdic,01,03), ['OR ','OR('])) then
        Result := Result+' AND '+iWherAdic
      else
        Result := Result+' '+iWherAdic.Trim;
    end;
    Result := ' '+Result;
  end;
end;

//Formata a versão para o formato nas pastas. ex: I= '7.1.05.222' O= '7105-222'
function FormataVers(iVers : String): String;
begin
  Result := (Copy(iVers, 1,6)+'-'+ Copy(iVers, 7,4)).Replace('.', '');
end;

function ClicTabe_To_TipoClic(const iClicTabe: String): TTipoClic;
begin
  if StrIn(iClicTabe.Trim.ToUpper, ['CLICMANUDETA', 'CLICMAN2DETA']) then
    Result := tcClicManuDeta
  else if StrIn(iClicTabe.Trim.ToUpper, ['CLICSHOW', 'CLICMODA']) then
    Result := tcClicShow
  else if StrIn(iClicTabe.Trim.ToUpper, ['CLICSHOWACES', 'CLICMODAACES']) then
    Result := tcClicShowAces
  else if (iClicTabe.Trim.ToUpper = 'CLICMODAACESINCL') then
    Result := tcClicShowIncl
  else if (iClicTabe.Trim.ToUpper = 'CLICMANUSEM_ACES') then
    Result := tcClicManuSem_Aces
  else //if StrIn(iClicTabe.Trim.ToUpper, ['CLICMAN2', 'CLICMAN2DETA', 'CLICMAN3', CLICBI']) then
    Result := tcClicManu;
end;

end.