unit uCadCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Buttons, Grids, DBGrids, StdCtrls, Mask, uDM,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdHTTPServer, IdHTTP, Data.DB,  IPPeerClient, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Rest.Json,uJSON, System.JSON, IdMessage, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, uEmail, Vcl.DBCtrls, dxCntner, dxEditor,
  dxEdLib, dxDBELib, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, IdAttachment,idAttachmentFile;


type
  TfrmCliente = class(TForm)
    pgGeral: TPageControl;
    tbCadastro: TTabSheet;
    pnlCadastro: TPanel;
    Bevel1: TBevel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Panel1: TPanel;
    btIncluir: TSpeedButton;
    btSalvar: TSpeedButton;
    btExcluir: TSpeedButton;
    btlimparTela: TSpeedButton;
    RESTRequest1: TRESTRequest;
    RESTClient1: TRESTClient;
    RESTResponse1: TRESTResponse;
    btBuscarCEP: TSpeedButton;
    pnlTitulo: TPanel;
    edtNome: TDBEdit;
    edtIdentidade: TdxDBMaskEdit;
    edtDDD: TDBEdit;
    edtFone: TDBEdit;
    edtEmail: TDBEdit;
    edtCep: TdxDBMaskEdit;
    edtLogradouro: TDBEdit;
    edtNumero: TDBEdit;
    edtComplemento: TDBEdit;
    edtBairro: TDBEdit;
    edtCidade: TDBEdit;
    edtEstado: TDBEdit;
    edtPais: TDBEdit;
    tbLista: TTabSheet;
    pnlFiltro: TPanel;
    Label14: TLabel;
    Label16: TLabel;
    Label15: TLabel;
    SpeedButton1: TSpeedButton;
    edtNomeFiltro: TEdit;
    Edit3: TEdit;
    Edit2: TEdit;
    DBGrid1: TDBGrid;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    edtCPF: TMaskEdit;
    btAlterar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btlimparTelaClick(Sender: TObject);
    procedure btAtualizarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btBuscarCEPClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure pgGeralChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edtNomeFiltroChange(Sender: TObject);
    procedure edtCPFExit(Sender: TObject);
    procedure edtEmailExit(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
  private
    { Private declarations }
    FAnexo: String;
    procedure HabilitarDesabilitarCampos(const pHabilitaDesabilita: Boolean);
    procedure SalvarCliente;
    function RemoverCaracterEspecial(const pTexto: String): String;
    function BuscarCep(const pCep: String): Boolean;
    function CriarXML: String;
    procedure EnviarEmail;
    function CheckAllowed(const s: string): Boolean;
    function ValidaCPF: Boolean;
    function ValidarEmail(const Value: string): Boolean;
  public
    { Public declarations }
  end;


var
  frmCliente: TfrmCliente;


implementation

{$R *.dfm}

procedure TfrmCliente.FormShow(Sender: TObject);
begin
  HabilitarDesabilitarCampos(False);
  edtCPF.Clear;
  pgGeral.ActivePage := tbCadastro;
  btAlterar.Enabled := False;
  btExcluir.Enabled := False;
  edtCPF.SetFocus;
end;

procedure TfrmCliente.pgGeralChange(Sender: TObject);
begin
  if pgGeral.ActivePage = tbLista then
    dm.cdsCliente.Open
  else
  begin
    dm.cdsCliente.Close;
    edtCPF.Clear;
    edtCPF.SetFocus;
  end
end;

procedure TfrmCliente.btIncluirClick(Sender: TObject);
begin
  dm.cdsCliente.Close;
  dm.cdsCliente.Open;

  dm.cdsCliente.Append;
  HabilitarDesabilitarCampos(True);
  btIncluir.Enabled := False;
  btSalvar.Enabled := True;
  edtCPF.Clear;
  edtCPF.SetFocus;
end;

procedure TfrmCliente.btAtualizarClick(Sender: TObject);
begin
  dm.cdsCliente.Open;
  dm.cdsCliente.First;
end;

procedure TfrmCliente.btExcluirClick(Sender: TObject);
begin
  if RemoverCaracterEspecial(edtCPF.Text) = EmptyStr then
    Exit;

   if MessageDlg('Confirma a exclus?o do registro registro?',
                 mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
    Exit;
  dm.cdsCliente.Delete;
  MessageDlg('Cliente excluido com sucesso.', mtInformation, [mbOk], 0, mbOk);
end;

procedure TfrmCliente.btlimparTelaClick(Sender: TObject);
begin
  if dm.cdsCliente.State in [dsInsert, dsEdit, dsBrowse] then
  begin
    dm.cdsCliente.Cancel;
    dm.cdsCliente.Refresh;
    HabilitarDesabilitarCampos(False);
    btAlterar.Enabled := False;
  end;
end;

procedure TfrmCliente.btSalvarClick(Sender: TObject);
begin
  if RemoverCaracterEspecial(edtCPF.Text) = EmptyStr then
  begin
    MessageDlg('Campo obrigat?rio.' + #13 +  'Preencha o "CPF', mtInformation, [mbOk], 0, mbOk);
    edtNome.SetFocus;
    Exit;
  end;

  if edtNome.Text = EmptyStr then
  begin
    MessageDlg('Campo obrigat?rio.' + #13 +  'Preencha o "Nome do Cliente', mtInformation, [mbOk], 0, mbOk);
    edtNome.SetFocus;
    Exit;
  end;
  if edtEmail.Text = EmptyStr then
  begin
    MessageDlg('Campo obrigat?rio.' + #13 + 'Preencha o "Email', mtInformation, [mbOk], 0, mbOk);
    edtEmail.SetFocus;
    Exit;
  end;
  SalvarCliente;
  EnviarEmail;

  btIncluir.Enabled := True;
  btSalvar.Enabled := False;
  dm.cdsCliente.Close;
  HabilitarDesabilitarCampos(False);
  edtCPF.Clear;
  edtCPF.SetFocus;
end;

procedure TfrmCliente.HabilitarDesabilitarCampos(const pHabilitaDesabilita: Boolean);
begin
  edtNome.Enabled := pHabilitaDesabilita;
  edtIdentidade.Enabled := pHabilitaDesabilita;
  edtDDD.Enabled := pHabilitaDesabilita;
  edtFone.Enabled := pHabilitaDesabilita;
  edtEmail.Enabled := pHabilitaDesabilita;
  edtCep.Enabled := pHabilitaDesabilita;
  edtLogradouro.Enabled := pHabilitaDesabilita;
  edtNumero.Enabled := pHabilitaDesabilita;
  edtComplemento.Enabled := pHabilitaDesabilita;
  edtBairro.Enabled := pHabilitaDesabilita;
  edtCidade.Enabled := pHabilitaDesabilita;
  edtEstado.Enabled := pHabilitaDesabilita;
  edtEmail.Enabled := pHabilitaDesabilita;
  edtpais.Enabled := pHabilitaDesabilita;
end;

procedure TfrmCliente.SalvarCliente;
begin
  dm.cdsClienteRG.AsString := RemoverCaracterEspecial(dm.cdsClienteRG.AsString);
  dm.cdsClienteCPF.AsString := RemoverCaracterEspecial(edtCPF.Text);
  dm.cdsClienteCEP.AsString := RemoverCaracterEspecial(edtCep.Text);
  dm.cdsCliente.Post;
  HabilitarDesabilitarCampos(False);
  btAlterar.Enabled := False;
  btExcluir.Enabled := False;
end;

procedure TfrmCliente.SpeedButton1Click(Sender: TObject);
begin
  dm.cdsCliente.Filtered := False;
  dm.cdsCliente.Filter := '';
  dm.cdsCliente.Open;
end;

procedure TfrmCliente.SpeedButton2Click(Sender: TObject);
begin
  fmConfigEmail.ShowModal;
end;

procedure TfrmCliente.SpeedButton3Click(Sender: TObject);
begin
  if not btIncluir.Enabled then
    Exit;
  dm.cdsCliente.Filtered := false;
  dm.cdsCliente.Filter := 'CPF = ' + RemoverCaracterEspecial(edtCPF.Text);
  dm.cdsCliente.Filtered := True;
  try
    dm.cdsCliente.Open;
  except
    dm.cdsCliente.Close;
  end;
  if dm.cdsCliente.RecordCount > 0 then
  begin
    btAlterar.Enabled := True;
    btExcluir.Enabled := True;
  end;
end;

procedure TfrmCliente.btAlterarClick(Sender: TObject);
begin
  dm.cdsCliente.Edit;
  HabilitarDesabilitarCampos(True);
  btSalvar.Enabled := True;
  edtIdentidade.SetFocus;
end;

procedure TfrmCliente.btBuscarCEPClick(Sender: TObject);
begin
  if RemoverCaracterEspecial(edtCep.Text) = EmptyStr then
    Exit;

  if not BuscarCep(edtcep.Text) then
  begin
    MessageDlg('CEP n?o encontrado.', mtInformation, [mbOk], 0, mbOk);
  end;
end;

function TfrmCliente.RemoverCaracterEspecial(const pTexto: String): String;
var
  vCaracter: String;
  vTexto: String;
  i: Integer;
Begin
  if pTexto = EmptyStr then
    Exit;
    
  vCaracter := '-.';
  vTexto := StringReplace(pTexto, '-', '', [rfReplaceAll]);
  vTexto := StringReplace(vTexto, '.', '', [rfReplaceAll]);

  Result := Trim(vTexto);
end;

function TfrmCliente.BuscarCep(const pCep: String): Boolean;
var
  vJsonObject: TJSONObject;
  vCep: String;
begin
  Result := True;
  vCep :=  RemoverCaracterEspecial(pCep);
  RESTClient1.BaseURL := 'http://viacep.com.br/ws/' + vCep + '/json';
  RESTRequest1.Execute;
  vJsonObject := TJsonObject(TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(RESTResponse1.Content),0));

  Try
    edtLogradouro.Text := vJsonObject.Get(1).JsonValue.Value;
    edtComplemento.Text := vJsonObject.Get(2).JsonValue.Value;
    edtBairro.Text := vJsonObject.Get(3).JsonValue.Value;
    edtCidade.Text := vJsonObject.Get(4).JsonValue.Value;
    edtEstado.Text := vJsonObject.Get(5).JsonValue.Value;
  except
    Result := False;
  end;
end;

procedure TfrmCliente.DBGrid1DblClick(Sender: TObject);
begin
  dm.cdsCliente.Locate('nome', dm.cdsClienteNome.AsString, []);
  pgGeral.ActivePage := tbCadastro;
end;

procedure TfrmCliente.edtCPFExit(Sender: TObject);
begin
  if not ValidaCPF then
  begin
    MessageDlg('CPF inv?lido.', mtInformation, [mbOk], 0, mbOk);
    edtCPF.SetFocus;
    Exit;
  end;
end;

procedure TfrmCliente.edtEmailExit(Sender: TObject);
begin
  if not ValidarEmail(edtEmail.Text) then
  begin
    MessageDlg('Email inv?lido.', mtInformation, [mbOk], 0, mbOk);
    edtEmail.SetFocus;
    Exit;
  end;
end;

procedure TfrmCliente.edtNomeFiltroChange(Sender: TObject);
begin
  dm.cdsCliente.Filtered := false;
  dm.cdsCliente.Filter := 'Nome Like' + QuotedStr('%' + Trim(edtNomeFiltro.Text) + '%');
  dm.cdsCliente.Filtered := True;
end;

function TfrmCliente.CriarXML:string;
var
   vXMLDocument  : TXMLDocument;
   vNodeTabela, vNodeRegistro, vNodeEndereco: IXMLNode;
   vCpfAux      : string;
begin
  vXMLDocument := TXMLDocument.Create(Self);
  try
      vXMLDocument.Active := True;
      vNodeTabela                                := vXMLDocument.AddChild('Pessoa');
      vNodeRegistro                              := vNodeTabela.AddChild('Registro');
      vNodeRegistro.ChildValues['nome']          := dm.cdsClienteNome.AsString;
      vNodeRegistro.ChildValues['rg']            := dm.cdsClienteRG.AsString;
      vNodeRegistro.ChildValues['cpf']           := dm.cdsClienteCPF.AsString;
      vNodeRegistro.ChildValues['ddd']           := dm.cdsClienteDDD.AsString;
      vNodeRegistro.ChildValues['telefone']      := dm.cdsClientetelefone.AsString;
      vNodeRegistro.ChildValues['email']         := dm.cdsClienteemail.AsString;

      vNodeEndereco                              := vNodeRegistro.AddChild('Endereco');
      vNodeEndereco.ChildValues['Logradouro']    := dm.cdsClienteLogradouro.AsString;
      vNodeEndereco.ChildValues['Numero']        := dm.cdsClienteNumero.AsString;
      vNodeEndereco.ChildValues['complemento']   := dm.cdsClienteComplemento.AsString;
      vNodeEndereco.ChildValues['bairro']        := dm.cdsClienteBairro.AsString;
      vNodeEndereco.ChildValues['cidade']        := dm.cdsClienteCidade.AsString;
      vNodeEndereco.ChildValues['estado']        := dm.cdsClienteEstado.AsString;
      vNodeEndereco.ChildValues['pais']          := dm.cdsClientePais.AsString;

      result   := ExtractFileDir(Application.ExeName)+'\'+ dm.cdsClienteCPF.AsString + '.xml';

      vXMLDocument.SaveToFile(result);
  finally
      vXMLDocument.Free;
  end;
end;

procedure TfrmCliente.EnviarEmail;
var
  IdAttach: TIdAttachmentFile;
  vAnexo: String;
begin
  if dm.cdsConfigEmail.RecordCount >= 0 then
  begin
    MessageDlg('N?o existe SMTP configurado para o envio de email.' + #13 +
    'Para que o envio de email autom?tico seja ativado: '+ #13 +
    'Acesse o bot?o "Configurar Servidor de Email"', mtInformation, [mbOk], 0, mbOk);
    Exit;
  end;
  if dm.cdsClienteemail.Text = EmptyStr then
    Exit;
  vAnexo := CriarXML;
  dm.IdSMTP1.Username := dm.cdsConfigEmailusuario.AsString;
  dm.IdSMTP1.Password := dm.cdsConfigEmailsenha.AsString;
  dm.IdSMTP1.Host := dm.cdsConfigEmailhost.AsString;
  dm.IdSMTP1.Port := dm.cdsConfigEmailporta.AsInteger;

  try
    dm.IdSMTP1.Connect;
  except
   On E:Exception do
    begin
      MessageDlg('Erro ao conectar no servidor: ' +
        E.Message, mtWarning, [mbOK], 0);
    end;
  end;

  dm.IdMessage1.From.Text := dm.cdsConfigEmailusuario.Text;
  dm.IdMessage1.Subject   := 'Arquivo XML - Dados Cadastrais';
  dm.IdMessage1.MessageParts.Clear;
  dm.IdMessage1.Body.Text := 'Prezado,' + #13 +  'Segue em anexo XML de dados cadastrais';
  dm.IdMessage1.Recipients.EMailAddresses := dm.cdsClienteemail.Text;


  dm.IdMessage1.MessageParts.Clear;
  if FileExists(vAnexo) then
  begin
    IdAttach := TIdAttachmentFile.Create(dm.IdMessage1.MessageParts, vAnexo);
    with IdAttach do
    begin
      FileName    := vAnexo;
      ContentType := 'application/xml;';
      CharSet     := 'ISO-8859-1';
      DisplayName := ExtractFileName(vAnexo);
    end;
  end;

  try
    try
      dm.IdSMTP1.Send(dm.IdMessage1);
      MessageDlg('Email enviado com sucesso.', mtInformation, [mbOk], 0, mbOk);
    except
      On E:Exception do
      begin
        MessageDlg('Erro ao enviar a mensagem: ' +
          E.Message, mtWarning, [mbOK], 0);
      end;
    end;
  finally
    dm.IdSMTP1.Disconnect;
  end;
end;

function TfrmCliente.ValidaCPF: Boolean;
var  dig10, dig11: string;
    s, i, r, peso: integer;
    cpf:string;
begin
  result := true;
  cpf := dm.cdsClienteCPF.AsString;
  cpf := StringReplace(cpf,'_','',[rfReplaceAll]);
  cpf := StringReplace(cpf,'-','',[rfReplaceAll]);
  cpf := StringReplace(cpf,'.','',[rfReplaceAll]);

  if (dm.cdsCliente.State in [dsEdit,dsInsert]) and (trim(cpf) <> '') then
  begin
    if ((CPF = '00000000000') or (CPF = '11111111111') or
        (CPF = '22222222222') or (CPF = '33333333333') or
        (CPF = '44444444444') or (CPF = '55555555555') or
        (CPF = '66666666666') or (CPF = '77777777777') or
        (CPF = '88888888888') or (CPF = '99999999999') or
        (length(CPF) <> 11)) then
    begin
        result := false;
        exit;
    end;
    try
      s := 0;
      peso := 10;
      for i := 1 to 9 do
      begin
         s := s + (StrToInt(CPF[i]) * peso);
         peso := peso - 1;
      end;
      r := 11 - (s mod 11);
      if ((r = 10) or (r = 11)) then
        dig10 := '0'
      else str(r:1, dig10);

      s := 0;
      peso := 11;
      for i := 1 to 10 do
      begin
        s := s + (StrToInt(CPF[i]) * peso);
        peso := peso - 1;
      end;
      r := 11 - (s mod 11);
      if ((r = 10) or (r = 11)) then
        dig11 := '0'
      else
        str(r:1, dig11);

      if ((dig10 = CPF[10]) and (dig11 = CPF[11]))then
        result := true
      else result := false;
    except
      result := false
    end;
  end;
end;

function TfrmCliente.ValidarEmail(const Value: string): Boolean;
var
  i: Integer;
  NamePart, ServerPart: string;
begin
  Result := False;
  i := Pos('@', Value);
  if i = 0 then
    Exit;
  NamePart := Copy(Value, 1, i - 1);
  ServerPart := Copy(Value, i + 1, Length(Value));
  if (Length(NamePart) = 0) or ((Length(ServerPart) < 5)) then
    Exit;
  i := Pos('.', ServerPart);
  if (i = 0) or (i > (Length(ServerPart) - 2)) then
    Exit;
  Result := CheckAllowed(NamePart) and CheckAllowed(ServerPart);
end;

function TfrmCliente.CheckAllowed(const s: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 1 to Length(s) do
      if not(s[i] in ['a' .. 'z', 'A' .. 'Z', '0' .. '9', '_', '-', '.']) then
      Exit;
  Result := true;
end;



end.

