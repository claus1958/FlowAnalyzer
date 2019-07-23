program Project41;

uses
  Vcl.Forms,
  Unit45 in 'Unit45.pas' {Form45},
  Unit4 in 'Unit4.pas' {Frame4: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm45, Form45);
  Application.Run;
end.
