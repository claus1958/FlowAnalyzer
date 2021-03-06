program FlowAnalyzer;

uses
  Forms,
  ManagerAPI in 'ManagerAPI.pas',
  Vcl.Themes,
  Vcl.Styles,
  XFlowAnalyzer in 'XFlowAnalyzer.pas' {Form2},
  csCSV in 'csCSV.pas',
  doHTTP in 'doHTTP.pas',
  FTCommons in 'FTCommons.pas',
  FilterControl in 'FilterControl.pas' {FilterElemente: TFrame},
  HTTPWorker in 'HTTPWorker.pas',
  FTTypes in 'FTTypes.pas',
  UDynGrid in 'UDynGrid.pas' {DynGrid: TFrame},
  GroupControl in 'GroupControl.pas' {GroupControl: TFrame},
  Dialog1 in 'Dialog1.pas' {Form5},
  uTwoLabel in 'uTwoLabel.pas' {twoLabel: TFrame},
  Dialog2 in 'Dialog2.pas' {Dialog2},
  ChangeLog in 'ChangeLog.pas',
  Unit10 in 'Unit10.pas' {Form10},
  EvalInfo in 'EvalInfo.pas' {Frame11: TFrame},
  ReportInfo in 'ReportInfo.pas' {ReportInfo: TFrame};

{$R *.res}
{$SetPEFlags $0020} //IMAGE_FILE_LARGE_ADDRESS_AWARE}
begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.Initialize;
 // TStyleManager.TrySetStyle('Carbon');
  TStyleManager.TrySetStyle('Carbon');
  //  TStyleManager.TrySetStyle('Cyan Dusk');
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDialog2, FDialog2);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm10, Form10);
  Application.Run;
end.
