program Project41;

uses
  Vcl.Forms,
  Unit45 in 'Unit45.pas' {Form45},
  Unit4 in 'Unit4.pas' {Frame4: TFrame},
  Vcl.Themes,
  Vcl.Styles,
  Unit5b in 'Unit5b.pas' {Frame5: TFrame},
  Unit7 in 'Unit7.pas' {Frame7: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Cyan Dusk');
  Application.CreateForm(TForm45, Form45);
  Application.Run;
end.
