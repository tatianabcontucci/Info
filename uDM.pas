unit uDM;

interface

uses
  SysUtils, Classes, DB, DBClient, IdMessage, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP, IdBaseComponent, IdComponent,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  Tdm = class(TDataModule)
    cdsCliente: TClientDataSet;
    cdsClienteNome: TStringField;
    cdsClienteRG: TStringField;
    cdsClienteCPF: TStringField;
    cdsClienteDDD: TIntegerField;
    cdsClientetelefone: TStringField;
    cdsClienteemail: TStringField;
    cdsClienteendereco: TStringField;
    cdsClientecep: TStringField;
    cdsClienteLogradouro: TStringField;
    cdsClienteNumero: TIntegerField;
    cdsClienteComplemento: TStringField;
    cdsClienteBairro: TStringField;
    cdsClienteCidade: TStringField;
    cdsClienteEstado: TStringField;
    cdsClientePais: TStringField;
    dscliente: TDataSource;
    dsconfigEmail: TDataSource;
    cdsConfigEmail: TClientDataSet;
    cdsConfigEmailusuario: TStringField;
    cdsConfigEmailsenha: TStringField;
    cdsConfigEmailhost: TStringField;
    cdsConfigEmailporta: TIntegerField;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

end.
