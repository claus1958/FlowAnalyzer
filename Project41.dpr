program Project41;

uses
  Vcl.Forms,
  Unit45 in 'Unit45.pas' {Form45},
  Unit4 in 'Unit4.pas' {Frame4: TFrame},
  Vcl.Themes,
  Vcl.Styles,
  Unit5b in 'Unit5b.pas' {Frame5: TFrame},
  Unit7 in 'Unit7.pas' {Frame7: TFrame},
  Unit9 in 'Unit9.pas' {Form9};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TForm45, Form45);
  Application.CreateForm(TForm9, Form9);
  Application.Run;
end.
