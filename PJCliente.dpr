program PJCliente;

uses
  Forms,
  uEmail in 'uEmail.pas' {fmConfigEmail},
  uDM in 'uDM.pas' {dm: TDataModule},
  uCadCliente in 'uCadCliente.pas' {frmCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCliente, frmCliente);
  Application.CreateForm(TfmConfigEmail, fmConfigEmail);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
