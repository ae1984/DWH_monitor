program dwh_monitor;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {fMain},
  uSQLID in 'uSQLID.pas' {fSQLID};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfSQLID, fSQLID);
  Application.Run;
end.
