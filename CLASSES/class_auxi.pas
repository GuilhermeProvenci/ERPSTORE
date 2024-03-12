unit class_auxi;

interface

uses
  System.Classes;

type
  TAuxi = class
  private
    FTexto: string;
    FNumero: Real;
    FTableFieldName: string;
    FTable: string;
    FID :  integer;
  published
    property Texto: string read FTexto write FTexto;
    property Numero: Real read FNumero write FNumero;
    property Table: string read FTable write FTable;
    property TableFieldName: string read FTableFieldName write FTableFieldName;
    property ID: integer read FID write FID;
  end;

implementation


end.

