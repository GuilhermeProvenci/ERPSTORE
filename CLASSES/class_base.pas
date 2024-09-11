unit %s;

interface

uses
  System.Classes, class_auxi, class_gplObject;

type
  %s = class(%s)
  private
    FConf TAuxi;
  public
    constructor Create(AOwner TComponent); override;
    destructor Destroy; override;
  published
    property Conf TAuxi read FConf write FConf;
  end;

procedure Register;

implementation

uses
  Vcl.Dialogs, unit_funcoes;

procedure Register;
begin
  RegisterComponents('GPL', [%s]);
end;

{ %s }

constructor %s.Create(AOwner TComponent);
begin
  inherited Create(AOwner);
  FConf = TAuxi.Create;
end;

destructor %s.Destroy;
begin
  FConf.Free;
  inherited;
end;

end.
