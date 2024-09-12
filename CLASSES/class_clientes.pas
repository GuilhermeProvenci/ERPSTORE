unit class_clientes;

interface

uses
  System.Classes, FireDAC.Comp.Client, System.SysUtils, System.Rtti, VCL.Forms, gplForm, gplCombo, unit_funcoes, class_gplObject, class_clientes_C;

type
  TClientes = class(TgplObject)
  private
    FOwnerForm: TgpForm;
    FCampos: TClientesCampos;
    procedure SetCampos(const Value: TClientesCampos);
  public
    constructor Create(form: TgpForm);
    destructor Destroy; override;
    property Campos: TClientesCampos read FCampos write SetCampos;
    property OwnerForm: TgpForm read FOwnerForm write FOwnerForm;
    function ObterDesconto: Double;
    procedure TestMensage;
  end;

implementation

uses
  gplEdit, Vcl.Dialogs, StrUtils;

constructor TClientes.Create(form: TgpForm);
begin
  inherited Create();
  OwnerForm := form;
  FCampos := TClientesCampos.Create;
//  CarregarCamposClasse(OwnerForm, Self);
end;

destructor TClientes.Destroy;
begin
  FCampos.Free;
  inherited;
end;

procedure TClientes.SetCampos(const Value: TClientesCampos);
begin
  FCampos := Value;
end;

procedure TClientes.TestMensage;
begin
  ShowMessage(Format('ID: %d'#13#10'Nome: %s'#13#10'Telefone: %s'#13#10'Endereco: %s'#13#10'Classificacao: %s',
  [FCampos.ID, FCampos.Nome, FCampos.Telefone, FCampos.Endereco, FCampos.Classificacao]));
end;

function TClientes.ObterDesconto: Double;
begin
  case AnsiIndexStr(UpperCase(Trim(FCampos.Classificacao)), ['BRONZE', 'PRATA', 'OURO', 'DIAMANTE']) of
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

