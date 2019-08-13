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
  UDynGrid in 'UDynGrid.pas' {DynGrid: TFrame},
  GroupControl in 'GroupControl.pas' {GroupControl: TFrame},
  Dialog1 in 'Dialog1.pas' {Form5},
  Dialog2 in 'Dialog2.pas' {Dialog2};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.Initialize;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDialog2,FDialog2);
  Application.Run;
end.
