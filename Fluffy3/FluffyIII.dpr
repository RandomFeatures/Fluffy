program FluffyIII;

uses
  Windows,
  Forms,
  Main in 'Main.pas' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Fluffy III    The New Word Order';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
