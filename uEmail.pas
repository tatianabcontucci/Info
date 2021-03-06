unit uEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, IdMessage,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP,
  IdBaseComponent, IdComponent, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls, Data.DB, Datasnap.DBClient, uDM, IdAttachment,idAttachmentFile;

type
  TfmConfigEmail = class(TForm)
    pgGeral: TPageControl;
    tbConfiguracao: TTabSheet;
    Panel1: TPanel;
    Bevel2: TBevel;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    btSalvar: TSpeedButton;
    edtSenha: TDBEdit;
    edtHost: TDBEdit;
    edtPorta: TDBEdit;
    edtUser: TDBEdit;
    pnlTitulo: TPanel;
    procedure btSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmConfigEmail: TfmConfigEmail;

implementation

{$R *.dfm}


procedure TfmConfigEmail.FormShow(Sender: TObject);
begin
  dm.cdsConfigEmail.Open;
end;

procedure TfmConfigEmail.btSalvarClick(Sender: TObject);
begin
  dm.cdsConfigEmail.Post;
  Close;
end;

end.
