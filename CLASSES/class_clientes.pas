unit class_clientes;

interface

uses
  System.Classes, FireDAC.Comp.Client, System.SysUtils, System.Rtti, VCL.Forms;

type
  TClientes = class(TComponent)
  private
    FID: Integer;
    FNome: string;
    FTelefone: string;
    FEndereco: string;
    FClassificacao: string;
    FOwnerForm : TForm;
    procedure SetID(const Value: Integer);
  //  procedure CarregarCampos(form : Tform);
  public
   // constructor Create(AID: Integer; ANome, ATelefone, AEndereco: string; AClassificacao: TClassificacao);
    constructor Create(form : Tform);
    property ID: Integer read FID write SetID;
    property Nome: string read FNome write FNome;
    property Telefone: string read FTelefone write FTelefone ;
    property Endereco: string read FEndereco write FEndereco;
    property Classificacao: string read FClassificacao write FClassificacao;
    property OwnerForm: TForm read FOwnerForm write FOwnerForm;
    function ObterDesconto: Double;
    procedure TestMensage;
  end;

implementation

{ TClientes }

uses
  gplEdit, Vcl.Dialogs, StrUtils;

//constructor TClientes.Create(AID: Integer; ANome, ATelefone, AEndereco: string; AClassificacao: TClassificacao);
constructor TClientes.Create(form : Tform);
begin
  inherited Create(nil);
//  FID := AID;
//  FNome := ANome;
//  FTelefone := ATelefone;
//  FEndereco := AEndereco;
//  FClassificacao := AClassificacao;
   OwnerForm := form;
end;

procedure TClientes.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TClientes.TestMensage;
begin
  ShowMessage(Format('ID: %d'#13#10'Nome: %s'#13#10'Telefone: %s'#13#10'Endereco: %s'#13#10'Classificacao: %s',
  [FID, FNome, FTelefone, FEndereco, FClassificacao]));

end;

//procedure TClientes.CarregarCampos(form: TForm);
//var
//  Contexto: TRttiContext;
//  Propriedade: TRttiProperty;
//  Valor: TValue;
//  Componente: TComponent;
//  DataFieldName: string;
//begin
//  Contexto := TRttiContext.Create;
//  try
//    for var i: integer := 0 to form.ComponentCount - 1 do
//    begin
//      Componente := form.Components[i];
//      DataFieldName := '';
//      if (Componente is TgpEdit) then
//        DataFieldName := TgpEdit(Componente).DataFieldName
//      else
//        Continue;
//      for Propriedade in Contexto.GetType(Self.ClassType).GetProperties do
//      begin
//        if SameText(Propriedade.Name, DataFieldName) then
//        begin
//          Valor := TgpEdit(Componente).Text;
//          Propriedade.SetValue(Self, Valor);
//        end;
//      end;
//    end;
//  finally
//    Contexto.Free;
//  end;
//end;

function TClientes.ObterDesconto: Double;
begin
  case AnsiIndexStr(UpperCase(Trim(FClassificacao)), ['BRONZE', 'PRATA', 'OURO', 'DIAMANTE']) of
    0: Result := 0.05;
    1: Result := 0.1;
    2: Result := 0.15;
    3: Result := 0.2;
  else
    Result := 0.0;
  end;
end;






initialization
  RegisterClass(TClientes);

end.

