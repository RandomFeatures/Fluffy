program chicken;

uses
  Windows,
  Forms,
  Main in 'Main.pas' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Fluffy the player killing chicken 2.1';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
