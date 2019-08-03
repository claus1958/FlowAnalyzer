program FTAnalyzer;

uses
  Forms,
  ManagerAPI in 'ManagerAPI.pas',
  Vcl.Themes,
  Vcl.Styles,
  FlowAnalyzer in 'FlowAnalyzer.pas' {Form2},
  csCSV in 'csCSV.pas',
  doHTTP in 'doHTTP.pas',
  FTCommons in 'FTCommons.pas',
  FilterControl in 'FilterControl.pas' {FilterElemente: TFrame},
  HTTPWorker in 'HTTPWorker.pas',
  FTTypes in 'FTTypes.pas',
  FTCollector in 'FTCollector.pas',
  UDynGrid in 'UDynGrid.pas' {DynGrid: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.Initialize;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
