{$RANGECHECKS ON}
unit XFlowAnalyzer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.strutils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, FTCommons, Vcl.StdCtrls, Vcl.Grids,
  Vcl.ExtCtrls, StringGridSorted, Vcl.CheckLst, ClipBrd, filterElement, FilterControl, MMSystem, HTTPWorker, FTTypes,
  Vcl.Themes, UDynGrid, GroupControl, DateUtils, Vcl.AppEvnts, uTwoLabel, Vcl.Buttons, iniFiles, ShellApi,
  System.NetEncoding, System.IoUtils, System.types, EvalInfo, ReportInfo;
// AdvChartView, AdvChartViewGDIP, AdvChartGDIP, AdvChart, AdvChartPaneEditorGDIP,
// AdvChartPaneEditor, AdvChartSerieEditor, ;

type
  // das ist wohl ein Trick wie man nichts umbenennen muss, wenn man eine neue Klasse von einer anderen Klasse ableitet.
  // Es bleibt hier beim Namen TStringGridSorted
  // TStringGridSorted = class(StringGridSorted.TStringGridSorted)
  // procedure WndProc(var Msg: TMessage); override;
  // end;

  TForm2 = class(TForm)
    StatusBar1: TStatusBar;
    PageControl1: TPanel;
    TabSheet2: TTabSheet;
    TabSheet5: TTabSheet;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    TabSheet1: TTabSheet;
    Panel26: TPanel;
    pnlInspectorBedienung: TPanel;
    Panel36: TPanel;
    lblFilterResult: TLabel;
    btnDoubleRemoveCw: TButton;
    btnSelectClearCw: TButton;
    pnlFilter: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    lblFilteredDataInfo: TLabel;
    TabSheet4: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Label24: TLabel;
    Label25: TLabel;
    lblCwActionsLength: TLabel;
    btnCwactionsToGrid: TButton;
    btnCwCommentsToGrid: TButton;
    btnCwSymbolsToGrid: TButton;
    btnCwusersToGrid: TButton;
    btnDblCheckCw: TButton;
    btnGetBinData: TButton;
    btnGetCsv: TButton;
    btnGetSymbolsUsersComments: TButton;
    btnListDoublesCw: TButton;
    btnLoadCacheFileCw: TButton;
    btnSaveCacheFileCw: TButton;
    btnShowCacheCw: TButton;
    edCacheCwShowMax: TEdit;
    edCacheCwShowStep: TEdit;
    edGetUrlBin: TEdit;
    edGetUrlCSV: TEdit;
    lbDebug2: TListBox;
    chkGetBinAppend: TCheckBox;
    TabSheet6: TTabSheet;
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel4: TCategoryPanel;
    CategoryPanel3: TCategoryPanel;
    CategoryPanel2: TCategoryPanel;
    CategoryPanel1: TCategoryPanel;
    Panel3: TPanel;
    lblAllDataInfo: TLabel;
    Button2: TButton;
    cbStyles: TComboBox;
    TabSheet3: TTabSheet;
    Panel12: TPanel;
    DynGrid2: TDynGrid;
    DynGrid3: TDynGrid;
    DynGrid4: TDynGrid;
    Panel13: TPanel;
    btnGetSingleUserActions: TButton;
    edSingleUserActionsId: TEdit;
    TabSheet7: TTabSheet;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    btnOnePage1: TButton;
    btnOnePage2: TButton;
    btnOnePage3: TButton;
    btnOnePage4: TButton;
    btnGroupSymbolsFilteredActions: TButton;
    Label4: TLabel;
    lbSymbolsGroupsInfo: TListBox;
    CategoryPanelGroup3: TCategoryPanelGroup;
    CategoryPanel8: TCategoryPanel;
    CategoryPanel9: TCategoryPanel;
    SGCwSymbolsGroups: FTCommons.TStringGridSorted;
    TabSheet8: TTabSheet;
    Button9: TButton;
    // AdvChartPanesEditorDialogGDIP1: TAdvChartPanesEditorDialogGDIP;
    // AdvGDIPChartView2: TAdvGDIPChartView;
    // AdvGDIPChartView1: TAdvGDIPChartView;
    // AdvGDIPChartView3: TAdvGDIPChartView;
    Panel20: TPanel;
    pnlPieButtons: TPanel;
    btnPieChart1: TButton;
    btnPieChart2: TButton;
    btnPieChart3: TButton;
    DynGrid5: TDynGrid;
    DynGrid6: TDynGrid;
    DynGrid7: TDynGrid;
    DynGrid8: TDynGrid;
    TabSheet9: TTabSheet;
    Panel21: TPanel;
    SGCwSymbols: FTCommons.TStringGridSorted;
    SGCwUsers: FTCommons.TStringGridSorted;
    SGCwComments: FTCommons.TStringGridSorted;
    SGCacheCwSearch: FTCommons.TStringGridSorted;
    pnlGrouping: TPanel;
    Label3: TLabel;
    DynGrid9: TDynGrid;
    Panel9: TPanel;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    lbUserInfo: TListBox;
    DynGrid10: TDynGrid;
    Panel14: TPanel;
    lblUserInfo0: TLabel;
    lblUserInfo1: TLabel;
    lblUserInfo2: TLabel;
    lblUserInfo3: TLabel;
    lblUserInfo4: TLabel;
    lblUserInfo5: TLabel;
    lblUserInfo6: TLabel;
    btnLadeDialog: TButton;
    btnDoFilter: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label12: TLabel;
    ApplicationEvents1: TApplicationEvents;
    StartTimer: TTimer;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    Panel10: TPanel;
    Label1: TLabel;
    lblWarten: TLabel;
    clbBrokers: TCheckListBox;
    lbLoadInfo: TListBox;
    btnClbBrokersSelectAll: TButton;
    btnClbBrokersDeSelectAll: TButton;
    btnLoadData: TButton;
    cbLoadActionsFromCache: TCheckBox;
    Button1: TButton;
    Button4: TButton;
    Button6: TButton;
    CheckBox1: TCheckBox;
    Panel11: TPanel;
    Memo1: TMemo;
    btnUpdateData: TButton;
    btnDoUsersAndSymbolsPlus: TButton;
    btnSymbolGroups: TButton;
    pnlStartBack: TPanel;
    pnlStart: TPanel;
    updateTimer: TTimer;
    pnlIcons: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Panel22: TPanel;
    Label11: TLabel;
    btnSample1: TButton;
    btnSample2: TButton;
    btnSample3: TButton;
    Splitter1: TSplitter;
    btnSample4: TButton;
    lblUserInfo7: TLabel;
    infoTimer: TTimer;
    Button3: FTCommons.TButton;
    SG: TStringGridSorted;
    lblUpdateRest: TLabel;
    btnSample5: TButton;
    Label13: TLabel;
    Button8: TButton;
    btnSample6: TButton;
    Button11: TButton;
    btnSample7: TButton;
    Panel23: TPanel;
    chkFilterWithOpenActions: TCheckBox;
    btnShowEvaluation: TButton;
    DynGrid11: TDynGrid;
    DynGrid12: TDynGrid;
    Panel24: TPanel;
    Button5: TButton;
    cbLoadFilters: TComboBox;
    Label14: TLabel;
    CheckBox2: TCheckBox;
    lbDummy: TListBox;
    SpeedButton7: TSpeedButton;
    lbCSVError: TListBox;
    Button7: TButton;
    edStoredActions: TEdit;
    DynGrid13: TDynGrid;
    Splitter4: TSplitter;
    Button12: TButton;
    Splitter5: TSplitter;
    SpeedButton8: TSpeedButton;
    Panel25: TPanel;
    ScrollBox1: TScrollBox;
    ReportInfo1: TReportInfo;
    ReportInfo2: TReportInfo;
    ReportInfo3: TReportInfo;
    ReportInfo4: TReportInfo;
    ReportInfo5: TReportInfo;
    ReportInfoA: TReportInfo;
    ReportInfoB: TReportInfo;
    ReportInfoC: TReportInfo;
    ReportInfo6: TReportInfo;
    Frame114: TFrame11;
    Frame115: TFrame11;
    Frame116: TFrame11;
    Frame117: TFrame11;
    Frame118: TFrame11;
    Frame119: TFrame11;
    Frame120: TFrame11;
    Frame121: TFrame11;
    Frame122: TFrame11;
    Frame123: TFrame11;
    Frame124: TFrame11;
    Frame125: TFrame11;
    Frame111: TFrame11;
    Frame112: TFrame11;
    Frame113: TFrame11;
    btnReport: TButton;
    pnlInspectorWait: TPanel;
    btnReportStop: TButton;
    DynGrid1: TDynGrid;
    Splitter6: TSplitter;
    procedure doLoadAllData();

    procedure getOpenActions(dt: TDateTime; serverTyp: integer; doAppend: boolean; sZeit: string; var openActions: DACwOpenActions);
    procedure deleteTodaysOpenActionCacheFiles(dt: TDateTime);
    procedure GetLastServerUnixTime();
    function checkLastUpdate(): TDateTime;
    procedure AppOnMessage(var Msg: TMsg; var Handled: boolean);
    procedure MyExceptionHandler(Sender: TObject; E: Exception);
    procedure doUpdate(dt: TDateTime = 0);
    procedure doLockWindowUpdate(yn: boolean);
    procedure setPageIndex(i: integer);
    procedure getSymbolsUsersComments(useCache: boolean);
    procedure finishUpdate();
    procedure btnGetCsvClick(Sender: TObject);
    procedure GetCsv(url, typ: string; lb: TListBox; append: boolean; tryCache: boolean);
    procedure btnCwSymbolsToGridClick(Sender: TObject);
    procedure btnCwactionsToGridClick(Sender: TObject);
    procedure btnCwusersToGridClick(Sender: TObject);
    procedure btnCwCommentsToGridClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGetBinDataClick(Sender: TObject);
    function GetBinData(url, typ: string; lb: TListBox; append: boolean = false; maxadd: integer = 0): integer;
    procedure btnLoadCacheFileCwClick(Sender: TObject);
    procedure doCacheGridCwInfo;
    procedure btnShowCacheCwClick(Sender: TObject);
    procedure btnDblCheckCwClick(Sender: TObject);
    procedure SGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure SortStringGrid(var genstrgrid: FTCommons.TStringGridSorted; ThatCol: integer; sortTyp: integer);
    procedure SortStringGridCW(var genstrgrid: FTCommons.TStringGridSorted; ThatCol: integer; sortTyp: integer);
    procedure btnListDoublesCwClick(Sender: TObject);
    procedure btnSelectClearCwClick(Sender: TObject);
    procedure btnDoubleRemoveCwClick(Sender: TObject);
    procedure btnClbBrokersSelectAllClick(Sender: TObject);
    procedure btnClbBrokersDeSelectAllClick(Sender: TObject);
    procedure btnLoadDataClick(Sender: TObject);
    procedure LoadInfo(s: string);
    procedure gridMouseClickHandler(grid: FTCommons.TStringGridSorted; col, row: integer; Button: TMouseButton; Shift: TShiftState; source: string);
    procedure btnGetSingleUserActionsClick(Sender: TObject);
    procedure TabSheet2Resize(Sender: TObject);
    procedure btnDoFilterClick(Sender: TObject);

    procedure edSingleUserActionsIdChange(Sender: TObject);
    procedure CategoryPanel1Collapse(Sender: TObject);
    procedure CategoryPanel1Expand(Sender: TObject);
    procedure remeasureCategoryPanels(c1: TCategoryPanelGroup);
    procedure StartHTTPWorker;
    procedure HTTPOnTerminate(Sender: TObject);
    function doHttpGetByteArrayFromWorker(var bArray: Bytearray; url: string; Var sErr: string): integer;
    procedure dosleep(t: integer);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure btnSampleClick(Sender: TObject);
    procedure doFilter();
    procedure doGroup();
    procedure Button2Click(Sender: TObject);
    procedure cbStylesChange(Sender: TObject);
    procedure btnUpdateDataClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btnDoUsersAndSymbolsPlusClick(Sender: TObject);
    procedure CategoryPanel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure CategoryPanelGroup1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure zeigUserInfo(id: integer; lb: TListBox);
    procedure btnSymbolGroupsClick(Sender: TObject);
    procedure btnOnePageClick(Sender: TObject);
    procedure doSymbolGroups(quelle: string; var actions: DACwAction; var actionsPlus: DACwActionPlus; var groups: DACwSymbolGroup; var groupsCt: integer; lb: TListBox);
    procedure doSymbolGroupValues(quelle: string; var actions: DACwAction; var actionsPlus: DACwActionPlus; var groups: DACwSymbolGroup; var groupsCt: integer; lb: TListBox);

    procedure doCountUsersInActions(var actions: DACwAction; var actionsPlus: DACwActionPlus; var groups: DACwSymbolGroup; var groupsCt: integer);

    procedure CategoryPanel9CollapseExpand(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure btnPieChartClick(Sender: TObject);
    // procedure machPieChart(data: DAPieValue; datact: integer; para: TPieParameters; cv: TAdvGDIPChartView;
    // pane: integer; serie: integer);

    procedure SGCwSymbolsGroupsDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
    procedure SGCwSymbolsGroupsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure SGCwSymbolsColumnMoved(Sender: TObject; FromIndex, ToIndex: integer);
    procedure machActionsUserIndex;
    function groupingTyp(styp: string): integer;
    function trimYear(year: integer): integer;
    function trimMonthYear(Month, year: integer; var s: string): integer;
    procedure machUserSelectionAusFilteredActions();
    procedure DynGrid10SGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);

    procedure dyngridMouseLeftClickHandler(topic: string; grid: FTCommons.TStringGridSorted; col, row: integer; sCell, sCol, sRow: string);
    procedure btnLadeDialogClick(Sender: TObject);
    // procedure TrackBar1Change(Sender: TObject);   f�r semitransparentes Form verwendet
    procedure ApplicationEvents1ModalBegin(Sender: TObject);
    procedure ApplicationEvents1ModalEnd(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure btnSaveCacheFileCwClick(Sender: TObject);
    procedure btnGetSymbolsUsersCommentsClick(Sender: TObject);
    procedure doFinalizeData;
    procedure fillStartScreen;
    procedure computeStartScreen;
    procedure updateTimerTimer(Sender: TObject);
    procedure pnlStartBackResize(Sender: TObject);
    procedure makelabels;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CategoryPanel1Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure infoTimerTimer(Sender: TObject);
    procedure OnMove(var Msg: TWMMove); message WM_MOVE;
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DynGrid9Selectcolumns1Click(Sender: TObject);
    procedure lblUpdateRestClick(Sender: TObject);
    procedure lblUpdateRestDblClick(Sender: TObject);
    procedure DynGrid9SpeedButton1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure btnShowEvaluationClick(Sender: TObject);
    function GetBinDataOpenActions(url, typ: string; lb: TListBox; var actions: DACwOpenActions; append: boolean = false; fromCache: boolean = false): integer;
    procedure getAndSortOpenActions(dt: TDateTime; var openActionsz: DACwOpenActions; accVon: integer; accBis: integer);
    function doHttpPutMemoryStreamToWorker(mStream: TMemoryStream; url: string): integer;
    procedure chkFilterWithOpenActionsClick(Sender: TObject);
    procedure makeEvaluation(var ps: EvaluationResult; source: string);
    procedure saveFilters(fName: string);
    procedure loadFilters(fName: string);
    procedure Button5Click(Sender: TObject);
    procedure fillCbLoadFilters;
    procedure cbLoadFiltersClick(Sender: TObject);
    procedure cbLoadFiltersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DynGrid10SpeedButton1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Panel26Resize(Sender: TObject);
    procedure Panel6Resize(Sender: TObject);
    procedure lbCSVErrorDblClick(Sender: TObject);
    procedure lbDebug2DblClick(Sender: TObject);
    procedure btnReportClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure btnReportStopClick(Sender: TObject);
    procedure DynGrid6SpeedButton1Click(Sender: TObject);
    procedure DynGrid4SpeedButton1Click(Sender: TObject);
    procedure DynGrid4MenuItem2Click(Sender: TObject);
    procedure DynGrid4MenuItem3Click(Sender: TObject);
    procedure DynGrid4CSVExportSelection1Click(Sender: TObject);
    procedure DynGrid10Selection2ndGrid1Click(Sender: TObject);
    procedure DynGrid10MenuItem10Click(Sender: TObject);
    procedure DynGrid10MenuItem8Click(Sender: TObject);
    procedure DynGrid1SpeedButton1Click(Sender: TObject);
    procedure DynGrid1RemoveSelection1Click(Sender: TObject);

  private
    { Private-Deklarationen }
    FColorKey: TCOLOR;
  public
    { Public-Deklarationen }
  end;

var
  Form2: TForm2;
  cw: boolean;
  reportStop: boolean;
  faIni: TMemIniFile;
  TabToResize: array [0 .. 10] of boolean; // NEU 12.12.19 wegen der Scrollbars die nicht richtig platziert werden
  Form2ResizeSimuliert: boolean;
  Filter: array [1 .. 10] of TFilterElemente;
  FilterCt: integer;
  Grouping: array [1 .. 3] of TGroupControl;
  GroupingCt: integer;
  twoLblStartCt: integer;
  twoLblStart: array [1 .. 20] of TTwoLabel;
  FilterTopic: string;
  SGFieldCol: DAInteger;
  SGColField: DAInteger;
  maxActionsPerGrid: integer;
  HTTPWorker1: THTTPWorker;
  HTTPWorker1Aktiv: boolean; // wenn create->true wenn terminate -> false
  HTTPWorkCriticalSection: TRTLCriticalSection;
  gridsortmethode2: boolean;
  info: TInfo;
  firstSampleDone: boolean;
  makeLabelsDone: boolean;
  nextUpdateTicks: integer;
  claus: boolean;
  CSleep: integer;
  pw: string;
  updateGoing: boolean;
  mynow: integer; // month year *12 (now)
  updateStatus: integer; // 0=nix zu tun 1=schnell ohne Actions Update 2=mit Actions
  updateTimerStarted: TDateTime;
  getAppOnMessage: boolean;
  lastUserActivity: cardinal;
  askFinishUpdate: boolean; //
  lastServerUnixTime: cardinal; // die ermittelte Serverzeit - meist 2 Stunden vor meiner Zeit
  lastUpdateServerUnixTime: cardinal; // die gemerkte ServerZeit des letzten vom Server angeforderten (vollen) Updates
  // (now-updateTimeStarted)*86400=Sekunden seit Start. Rest:  timer.Interval/1000-x in Sekunden
  getSymbolsUsersCommentsTime: TDateTime;
  doUpdateCt: integer; // wie oft wurde Update gemacht

implementation

{$R *.dfm}

uses doHTTP, Dialog1, Dialog2, Unit10;

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;
{$SETPEFLAGS IMAGE_FILE_LARGE_ADDRESS_AWARE}

procedure TForm2.OnMove(var Msg: TWMMove);
begin
  inherited;
  // label1.Caption:='l:'+inttostr(form45.Left)+' t:'+inttostr(form45.Top)+'w:'+inttostr(form45.width)+' h:'+inttostr(form45.height);
  if assigned(Dialog2.fdialog2) then
  begin
    Dialog2.fdialog2.Left := Form2.Left + Form2.Width - Dialog2.fdialog2.Width;
    Dialog2.fdialog2.Top := Form2.Top + Form2.Height - Dialog2.fdialog2.Height;
  end;
end;

procedure TForm2.btnGetBinDataClick(Sender: TObject);
var
  typ: string;
begin
  if containstext(edGetUrlBin.text, '/symbols') then
    typ := 'symbols';
  if containstext(edGetUrlBin.text, '/users') then
    typ := 'users';
  if containstext(edGetUrlBin.text, '/comments') then
    typ := 'comments';
  if containstext(edGetUrlBin.text, '/ticks') then
    typ := 'ticks';
  if containstext(edGetUrlBin.text, '/actions') then
    typ := 'actions';
  GetBinData(edGetUrlBin.text, typ, lbCSVError, chkGetBinAppend.Checked);
end;

function TForm2.GetBinDataOpenActions(url, typ: string; lb: TListBox; var actions: DACwOpenActions; append: boolean = false; fromCache: boolean = false): integer;
var
  ret: String;
  gt: cardinal;
  i, l, f: integer;
  j: integer;
  bytes: Bytearray;
  s: AnsiString;
  s1: AnsiString;
  ss: String;
  ms: TMemoryStream;
  sz: integer;
  oldlen: integer;
  res: integer;
  alt: integer;
  sErr: string;
  p: integer;
begin
  gt := GetTickCount;
  // bytes := doHTTPGetByteArray(url, lb);
  // �ber einen zweiten Thread werden die Daten abgerufen

  // Hier k�nnten Bytesarrays auch gepuffert werden, wenn die Abrufe mehrmals nacheinander notwendig sind
  // TODO 13.12.19

  p := pos('?', url);
  // alles nach dem ? ist der Filename des Cachefiles
  // year=2019&month=12&day=14&accountId=1  w�re die LCG-Datei vom 14.12.2019
  // diese befindet sich im Ordner cache und endet immer mit .bin
  res := 0;
  if (fromCache = true) then
    // nur �ltere Daten min 2 Tage aus einem Cache laden
    res := loadopenactionsbuffer(url.substring(p), bytes);
  if (res = 1) then
  begin
    // alles ok - aus Puffer geladen
    lbdebug('took OpenActions from cache')
  end
  else
  begin

    res := doHttpGetByteArrayFromWorker(bytes, url, sErr);
    lbadd(lbDebug2, 'Zeit GetUrl:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));

    // leftstr(url, p - 1);
    // die neueren Caches sollen nicht generiert werden, da diese dann Tage sp�ter
    // als unvollst�ndige Dateien geladen werden k�nnten !
    if (fromCache = true) then
      if length(bytes) > 0 then

        saveopenactionsbuffer(url.substring(p), bytes);

  end;
  if (typ = 'openActions1') or (typ = 'openActions2') then
  // ist ja sowieso nichts anderes ... eigentlich ist typ unn�tig
  begin
    // der verk�rzte Datentyp
    // body := TNetEncoding.Base64.Encode
    // tb:=TNetEncoding.Base64.Decode(bytes);
    i := SizeOf(cwOpenAction);
    sz := trunc(length(bytes) / i);
    if (sz = 0) then
      exit; // wenn es keine Daten gegeben hat ...
    if append = true then
    begin
      // die neuen Actions an die alten anh�ngen
      oldlen := length(actions);
      setlength(actions, length(actions) + sz);
      move(bytes[0], actions[oldlen], length(bytes));
    end
    else
    begin
      setlength(actions, sz);
      move(bytes[0], actions[0], length(bytes));
    end;
    // sz := trunc(length(bytes) / i);
    // Pr�fen ob es sich um eine der alten fehlerhaften Werte handelt
    f := -1;
    for i := length(actions) - sz to length(actions) - 1 do
      if (actions[i].actionId < 0) then
      begin
        f := 1;
        break;
      end;
    if (f = 1) then
    begin
      for i := length(actions) - sz to length(actions) - 1 do
        actions[i].actionId := actions[i].actionId + 4294967300;
    end;
  end;

end;

function TForm2.GetBinData(url, typ: string; lb: TListBox; append: boolean = false; maxadd: integer = 0): integer;
// kann actions symbols und ticks bin�r abrufen
// die users symbols gibt es nicht !
var
  ret: String;
  gt: cardinal;
  i, l: integer;
  j: integer;
  bytes: Bytearray;
  s: AnsiString;
  s1: AnsiString;
  ss: String;
  ms: TMemoryStream;
  sz: integer;
  oldlen: integer;
  res: integer;
  alt: integer;
  aneu: DACwAction;
  sErr: string;

  tb: TBytes;
begin
  gt := GetTickCount;
  // bytes := doHTTPGetByteArray(url, lb);
  // �ber einen zweiten Thread werden die Daten abgerufen

  if typ = 'actions' then
    if (append = false) then // NEU 15.11.2019 wegen Speichermangel!
    begin
      setlength(cwActions, 0);
      cwActionsSorted := false;
    end;

  res := doHttpGetByteArrayFromWorker(bytes, url, sErr);
  lbadd(lbDebug2, 'Zeit GetUrl:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));
  if typ = 'lastServerUnixTime' then
  begin

    SetString(s, PAnsiChar(@bytes[0]), high(bytes) + 1);
    lastServerUnixTime := strtoint(s);

  end;

  if typ = 'actions' then
  begin
    // nur wenn es sich um bin�re actions handelt !
    // Bytes->cwActions

    i := SizeOf(cwAction);
    sz := trunc(length(bytes) / i);
    if (append = true) then
      if (maxadd > 0) then
        if (sz > maxadd) then
        // nur bei manuellem Update wird dieser Parameter gesetzt ! Der normale Erstabruf braucht ebenfalls append und darf nicht abweisen
        begin
          lbDebug2.Items.Add('Too many new actions to append:' + inttostr(sz));
          showmessage('Too many new actions to append:' + inttostr(sz) + '(max.' + inttostr(maxadd) + ')');
          result := -1;
          exit;
        end;
    // Problem: es gibt bei den CloseTime Abrufen leider ca 11 Actions deren Datum in der Zukunft liegt
    // und die deshalb in Wahrheit gar nicht neu sind !
    LoadInfo(inttostr(sz) + ' new or changed actions');

    if ((sz > 0) and (sz < 20)) then
    begin
      gt := GetTickCount;
      setlength(aneu, sz);
      move(bytes[0], aneu[0], length(bytes));
      alt := 0;
      for i := 0 to sz - 1 do
      begin
        // die wenigen neuen actions in den alten actions suchen
        for l := 0 to length(cwActions) - 1 do
        begin
          if (aneu[i].actionId = cwActions[l].actionId) then
            if (aneu[i].closeTime = cwActions[l].closeTime) then
            begin
              inc(alt);
              break;
            end;
        end;
      end;
      lbCSVDebug('Check:' + inttostr(GetTickCount - gt));
      // wenn keine neuen darin waren wird sz->0 gesetzt . Also nix zu tun
      if (alt = sz) then
        sz := 0
      else
        sz := sz;

    end;
    if (sz > 0) then
    begin
      // append-Modus
      if append = true then
      begin
        // die neuen Actions an die alten anh�ngen
        oldlen := length(cwActions);
        setlength(cwActions, length(cwActions) + sz);
        setlength(cwActionsPlus, length(cwActionsPlus) + sz);
        cwActionsSorted := false;

        move(bytes[0], cwActions[oldlen], length(bytes));
      end
      else
      begin
        setlength(cwActions, sz);
        setlength(cwActionsPlus, sz);
        cwActionsSorted := false;
        move(bytes[0], cwActions[0], length(bytes));
      end;
      lbdebug('New/Changed actions:' + inttostr(sz));
      lbdebug('Zeit move->actions:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));
      lbdebug('Anzahl Actions:' + inttostr(sz));
      lblCwActionsLength.Caption := 'CwActions:' + inttostr(length(cwActions));
      btnCwactionsToGridClick(nil);
      result := sz;
    end
    else
    begin
      lbCSVDebug('No new actions');
      result := 0;
    end;;
  end;

  // die folgenden Routinen sind nicht anwendbar da durch dieVerwendung von Strings kein bin-Lesen mehr m�glich ist
  // if typ = 'symbols' then
  // begin
  // // Bytes->cwSymbols
  //
  // // //wenn Sicherung als Datei zum Debugging
  // // ms := TMemoryStream.Create;
  // // ms.WriteBuffer(bytes[0], length(bytes));
  // // ms.SaveToFile(ExtractFilePath(paramstr(0)) + 'symbols.bin');
  // // ms.Free;
  //
  // i := SizeOf(cwSymbol);
  // sz := trunc(length(bytes) / i);
  // SetLength(cwSymbols, sz);
  // SetLength(cwSymbolsPlus, sz);
  // SetLength(cwsymbolsSortindex, 0); // zur�cksetzen
  // move(bytes[0], cwSymbols[0], length(bytes));
  // lbadd(lbDebug2,('Zeit move->symbol:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));
  // lbadd(lbDebug2,('Anzahl Symbols:' + inttostr(sz));
  // for j := 0 to sz - 1 do
  // begin
  // lbadd(lbDebug2,(inttostr(j) + ' ' + cwSymbols[j].name + ' ' + inttostr(cwSymbols[j].symbolId) + ' ' +
  // inttostr(cwSymbols[j].brokerId));
  // if j > 100 then
  // break;
  // end;
  // lbadd(lbDebug2,('...');
  //
  // end;
  // if typ = 'ticks' then
  // begin
  // // wenn Sicherung als Datei zum Debugging
  // ms := TMemoryStream.Create;
  // ms.WriteBuffer(bytes[0], length(bytes));
  // ms.SaveToFile(ExtractFilePath(paramstr(0)) + 'ticks.bin');
  // ms.Free;
  // end;
  //
  // if typ = 'users' then
  // begin
  // // wenn Sicherung als Datei zum Debugging
  // ms := TMemoryStream.Create;
  // ms.WriteBuffer(bytes[0], length(bytes));
  // ms.SaveToFile(ExtractFilePath(paramstr(0)) + 'users.bin');
  // ms.Free;
  //
  // i := SizeOf(cwuser);
  // sz := trunc(length(bytes) / i);
  // SetLength(cwUsers, sz);
  // SetLength(cwUsersPlus, sz);
  // SetLength(cwUsersSortindex, 0); // zur�cksetzen
  // SetLength(cwUsersSortindex2, 0); // zur�cksetzen
  // move(bytes[0], cwUsers[0], length(bytes));
  // lbadd(lbDebug2,('Zeit move->user:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));
  // lbadd(lbDebug2,('Anzahl users:' + inttostr(sz));
  // for j := 0 to sz - 1 do
  // begin
  // lbadd(lbDebug2,(inttostr(j) + ' ' + cwUsers[j].name + ' ' + inttostr(cwUsers[j].userId) + ' ' +
  // inttostr(cwUsers[j].accountId));
  // if j > 100 then
  // break;
  // end;
  // lbadd(lbDebug2,('...');
  //
  // end;

  setlength(bytes, 0);
end;

procedure TForm2.btnGetCsvClick(Sender: TObject);
var
  typ: string;
  tryCache: boolean;
begin
  tryCache := true;
  if containstext(edGetUrlCSV.text, '/symbols') then
    typ := 'symbols';
  if containstext(edGetUrlCSV.text, '/users') then
    typ := 'users';
  if containstext(edGetUrlCSV.text, '/comments') then
    typ := 'comments';
  if containstext(edGetUrlCSV.text, '/ticks') then
    typ := 'ticks';
  // alle ohne append
  GetCsv(edGetUrlCSV.text, typ, lbCSVError, false, tryCache);

end;

procedure TForm2.GetCsv(url, typ: string; lb: TListBox; append: boolean; tryCache: boolean);
// die Routine gibt nichts zur�ck und behandelt die Ergebnisse selbst
// Fehler werden in die lb geschrieben
var
  gt: cardinal;
  fileName: string;
  fileMode: integer;
  bytes: Bytearray;
  s: AnsiString;
  ms: TMemoryStream;
  bpms: integer;
  Stream: TFileStream;
  ok: boolean;
  res: integer;
  i, j: integer;
  sl: TStringList;
  sErr: string;

begin
  gt := GetTickCount;

  ok := false;
  if (tryCache = true) then
  begin
    fileName := ExtractFilePath(paramstr(0)) + cCacheFolder + '\' + typ + '.csv';
    if (fileExists(fileName) = true) then
    begin
      Stream := TFileStream.Create(fileName, fmOpenRead or fmShareDenyNone);
      Stream.Position := 0;
      ParseDelimited(typ, lb, s, #13 + #10, cwUsers, cwSymbols, cwTicks, cwComments, Stream, append);
      Stream.free;
      if (typ = 'users') then
      begin
        cwusersct := length(cwUsers);
        setlength(cwUsersPlus, cwusersct);
      end;
      if (typ = 'symbols') then
      begin
        cwsymbolsct := length(cwSymbols);
        setlength(cwSymbolsPlus, cwsymbolsct);
      end;

      if (typ = 'comments') then
      begin
        cwcommentsct := length(cwComments);
        setlength(cwcommentsplus, cwcommentsct);
      end;

      LoadInfo('from Cache');
      ok := true;
    end;
  end;
  if (ok = false) then
  // vom Server laden
  begin

    // bytes := doHTTPGetByteArray(url, lbCSVError);
    res := doHttpGetByteArrayFromWorker(bytes, url, sErr); // res=0 ist der Normalfall ! <>0 ist ein Fehler
    if (res <> 0) then
    begin
      sErr := 'Fehler HTTPGet';
      // hier passiert im Fehlerfalle einfach gar nix und die Routine wird einfach beendet
      exit;

    end;
    bpms := trunc(length(bytes) / (GetTickCount - gt));

    lbadd(lb, 'CSV-Load:' + url);
    lbadd(lb, 'Z:get :' + inttostr(GetTickCount - gt));
    lbadd(lb, 'bpms:' + inttostr(bpms));
    gt := GetTickCount;
    // bei CSV-Dateien muss UTF8-decodiert werden damit die Umlaute passen
    SetString(s, PAnsiChar(@bytes[0]), high(bytes) + 1);
    s := UTF8Decode(s); // -> der String ist jetzt ok

    // den UTF8-decodierten AnsiString wieder als Bytearray
    setlength(bytes, length(s));
    move(Pointer(s)^, Pointer(bytes)^, length(s));
    lbadd(lb, 'Z:UTF8 :' + inttostr(GetTickCount - gt));

    gt := GetTickCount;
    ms := TMemoryStream.Create;

    ms.WriteBuffer(bytes[0], high(bytes) + 1);
    ms.Position := 0;
    lbadd(lb, 'Z:MStream :' + inttostr(GetTickCount - gt));

    lbadd(lb, 'Bytes gelesen:' + inttostr(length(s)));

    if typ = 'lastUpdate' then
    begin

      // die Bytes in eine Datei schreiben
      try
        fileName := ExtractFilePath(paramstr(0)) + cCacheFolder + '\lastUpdate.csv';
        fileMode := fmCreate;
        Stream := TFileStream.Create(fileName, fileMode);
        Stream.WriteBuffer(bytes[0], high(bytes) + 1);
        Stream.free; // Speicher freigeben
      except
        lbCSVDebug('F:writeUsersStream');
      end;
      sl := TStringList.Create;
      sl.Delimiter := ';';
      sl.DelimitedText := s; // ohne den Delimiter sl[0] = 'total;366;27.08.2019'
      // so jetzt sl[0]=total sl[1]=355
      info.lastUpdateOnServer := strtodatetime(sl[1]);
      sl.free;
    end;

    if typ = 'usersOnline' then
    begin
      // die Bytes in eine Datei schreiben
      try
        fileName := ExtractFilePath(paramstr(0)) + cCacheFolder + '\usersOnline.csv';
        fileMode := fmCreate;
        Stream := TFileStream.Create(fileName, fileMode);
        Stream.WriteBuffer(bytes[0], high(bytes) + 1);
        Stream.free; // Speicher freigeben
      except
        lbCSVDebug('F:writeUsersStream');
      end;
      sl := TStringList.Create;
      sl.Delimiter := ';';
      sl.DelimitedText := s; // ohne den Delimiter sl[0] = 'total;366;27.08.2019'
      // so jetzt sl[0]=total sl[1]=355
      info.usersonline := strtoint(sl[1]);
      sl.free;
    end;

    if typ = 'symbols' then
    begin
      // die Bytes in eine Datei schreiben
      try
        fileName := ExtractFilePath(paramstr(0)) + cCacheFolder + '\symbols.csv';
        fileMode := fmCreate;
        Stream := TFileStream.Create(fileName, fileMode);
        Stream.WriteBuffer(bytes[0], high(bytes) + 1);
        Stream.free; // Speicher freigeben
      except
        lbCSVDebug('F:writeUsersStream');
      end;

      ParseDelimited('symbols', lb, s, #13 + #10, cwUsers, cwSymbols, cwTicks, cwComments, ms, append);
      cwsymbolsct := length(cwSymbols);
      setlength(cwSymbolsPlus, cwsymbolsct);

    end;

    if typ = 'users' then
    begin
      // die Bytes in eine Datei schreiben
      try
        fileName := ExtractFilePath(paramstr(0)) + cCacheFolder + '\users.csv';
        fileMode := fmCreate;
        Stream := TFileStream.Create(fileName, fileMode);
        Stream.WriteBuffer(bytes[0], high(bytes) + 1);
        Stream.free; // Speicher freigeben
      except
        lbCSVDebug('F:writeUsersStream');
      end;
      ParseDelimited('users', lb, s, #13 + #10, cwUsers, cwSymbols, cwTicks, cwComments, ms, append);
      cwusersct := length(cwUsers);
      setlength(cwUsersPlus, cwusersct);

    end;
    if typ = 'comments' then
    begin
      // die Bytes in eine Datei schreiben
      try
        fileName := ExtractFilePath(paramstr(0)) + cCacheFolder + '\comments.csv';
        fileMode := fmCreate;
        Stream := TFileStream.Create(fileName, fileMode);
        Stream.WriteBuffer(bytes[0], high(bytes) + 1);
        Stream.free; // Speicher freigeben
      except
        lbCSVDebug('F:writeCommentsStream');
      end;
      ParseDelimited('comments', lb, s, #13 + #10, cwUsers, cwSymbols, cwTicks, cwComments, ms, append);
      cwcommentsct := length(cwComments);
      setlength(cwcommentsplus, cwcommentsct);
    end;

    if typ = 'ticks' then
    begin
      ParseDelimited('ticks', lb, s, #13 + #10, cwUsers, cwSymbols, cwTicks, cwComments, ms, append);
      cwTicksCt := length(cwTicks);

    end;
    // LoadInfo('from Server');
  end;
  if typ = 'users' then
  begin
    // und hier die accountCurrency setzen !
    // !! die Werte 1-4 sind Euro Dollar Sfr und GBP Die 0 ist unbelegt
    gt := GetTickCount;
    for i := 0 to cwusersct - 1 do
    begin
      cwUsersPlus[i].accountCurrency := 0;
      if (cwUsers[i].accountId = 1) then
      begin
        // LCG Hinten D E P S
        s := rightstr(cwUsers[i].group, 1);
        if (s = 'E') then
          cwUsersPlus[i].accountCurrency := 1;
        if (s = 'D') then
          cwUsersPlus[i].accountCurrency := 2;
        if (s = 'S') then
          cwUsersPlus[i].accountCurrency := 3;
        if (s = 'P') then
          cwUsersPlus[i].accountCurrency := 4;
        if (cwUsersPlus[i].accountCurrency = 0) then
        begin
          // LCG Hinten D E P S
          s := rightstr(cwUsers[i].group, 2);
          if (s = 'E_') then
            cwUsersPlus[i].accountCurrency := 1;
          if (s = 'D_') then
            cwUsersPlus[i].accountCurrency := 2;
          if (s = 'S_') then
            cwUsersPlus[i].accountCurrency := 3;
          if (s = 'P_') then
            cwUsersPlus[i].accountCurrency := 4;
        end;

      end;
      if (cwUsers[i].accountId = 2) then
      begin
        // LCG Hinten D E P S
        s := rightstr(cwUsers[i].group, 3);
        if (s = 'EUR') then
          cwUsersPlus[i].accountCurrency := 1;
        if (s = 'USD') then
          cwUsersPlus[i].accountCurrency := 2;
        if (s = 'CHF') then
          cwUsersPlus[i].accountCurrency := 3;
        if (s = 'GBP') then
          cwUsersPlus[i].accountCurrency := 4;
      end;

      if (cwUsers[i].accountId > 2) then
      begin
        s := leftstr(cwUsers[i].group, 3);
        if (s = 'EUR') then
          cwUsersPlus[i].accountCurrency := 1;
        if (s = 'USD') then
          cwUsersPlus[i].accountCurrency := 2;
        if (s = 'CHF') then
          cwUsersPlus[i].accountCurrency := 3;
        if (s = 'GBP') then
          cwUsersPlus[i].accountCurrency := 4;
      end;
    end;
    // showmessage(inttostr(GetTickCount - gt));

  end;
  ms.free;

end;

procedure TForm2.gridMouseClickHandler(grid: FTCommons.TStringGridSorted; col, row: integer; Button: TMouseButton; Shift: TShiftState; source: string);
// die alte Routine f�r die normalen Grids
var
  colHeader: string;
  i: integer;
  b: boolean;
begin
  // showmessage('Grid:' + grid.name + ' cell:' + sCell + ' col:' + sCol + ' row:' + sRow);
  colHeader := grid.Cells[col, 0];
  // die dynGrid heissen alle SG
  // bei cwusers jeder Click in eine Zeile -> user actions anzeigen
  if ((source = 'cwusers') or (source = 'cwusers2') or (source = 'cwusersX')) then
    if colHeader <> 'userId' then
      for i := 0 to grid.Colcount - 1 do
      begin
        if grid.Cells[i, 0] = 'userId' then
        begin
          edSingleUserActionsId.text := grid.Cells[i, row];
          btnGetSingleUserActionsClick(nil);
        end;
      end;

  if colHeader = 'userId' then
  begin
    edSingleUserActionsId.text := grid.Cells[col, row];
    btnGetSingleUserActionsClick(nil);
    // if (ssshift in shift) then
    if (Button = mbright) then
      // PageControl1.TabIndex := 2;
      setPageIndex(4); // 2;
  end;

  // if grid.name = 'SGCwUsers' then
  // begin
  // if colHeader = 'userId' then
  // begin
  // edSingleUserActionsId.text := grid.Cells[col, row];
  // PageControl1.TabIndex := 2;
  // btnGetSingleUserActionsClick(nil);
  // end;
  //
  // end;

end;

procedure TForm2.dyngridMouseLeftClickHandler(topic: string; grid: FTCommons.TStringGridSorted; col, row: integer; sCell, sCol, sRow: string);
// die alte Routine f�r die normalen Grids
var
  colHeader: string;
begin
  // showmessage('Grid:' + grid.name + ' cell:' + sCell + ' col:' + sCol + ' row:' + sRow);
  colHeader := grid.Cells[col, 0];

  if grid.name = 'SGCwCache' then
  begin
    if colHeader = 'userId' then
    begin
      edSingleUserActionsId.text := grid.Cells[col, row];
      setPageIndex(4); // 2;
      btnGetSingleUserActionsClick(nil);
    end;

  end;
  if topic = 'users' then
  begin
    if colHeader = 'userId' then
    begin
      edSingleUserActionsId.text := grid.Cells[col, row];
      setPageIndex(4); // 2;
      btnGetSingleUserActionsClick(nil);
    end;

  end;

end;

procedure TForm2.btnGetSingleUserActionsClick(Sender: TObject);
var
  id: integer;
  i: integer;
  fz: integer;
  fzmax: integer;
  max: integer;
begin
  id := mystrtoint(edSingleUserActionsId.text);
  if (id = 0) then
    exit;

  fzmax := 10000;
  fz := -1;
  setlength(cwSingleUserActions, fzmax);
  setlength(cwSingleUserActionsPlus, fzmax);
  cwactionsct := length(cwActions);
  for i := 0 to cwactionsct - 1 do
  begin
    if cwActions[i].userId = id then
    begin
      fz := fz + 1;
      if fz >= (fzmax - 1) then
      begin
        fzmax := fzmax + 10000;
        setlength(cwSingleUserActions, fzmax);
        setlength(cwSingleUserActionsPlus, fzmax);
      end;
      cwSingleUserActions[fz] := cwActions[i];
    end;
  end;

  // application.messagebox('test1','test3');

  setlength(cwSingleUserActions, fz + 1);
  setlength(cwSingleUserActionsPlus, fz + 1);
  cwsingleuseractionsCt := fz + 1;

  zeigUserInfo(id, lbUserInfo);
  showmemory(lbUserInfo);

  DynGrid4.initGrid('cwsingleuseractions', 'userId', 1, length(cwSingleUserActions), 30);

  // max := cwsingleuseractionsCt;
  // if max > maxActionsPerGrid then
  // max := maxActionsPerGrid;
  //
  // doActionsGridCW(SGCwSingleUser, SGFieldCol, cwSingleUserActions, max, max);
  // autosizegrid(SGCwSingleUser);
end;

procedure TForm2.btnGetSymbolsUsersCommentsClick(Sender: TObject);
begin
  getSymbolsUsersComments(true);
end;

procedure TForm2.getSymbolsUsersComments(useCache: boolean);
var
  gt: cardinal;
begin
  // Die drei Dateien vom Server abrufen: symbols user und comments
  gt := GetTickCount;
  edGetUrlCSV.text := 'http://h2827643.stratoserver.net:' + cServerPort + '/csv/symbols';
  LoadInfo('Load Symbols...');
  GetCsv(edGetUrlCSV.text, 'symbols', lbCSVError, false, useCache);

  edGetUrlCSV.text := 'http://h2827643.stratoserver.net:' + cServerPort + '/csv/users';
  LoadInfo('Load Users...');
  GetCsv(edGetUrlCSV.text, 'users', lbCSVError, false, useCache);

  edGetUrlCSV.text := 'http://h2827643.stratoserver.net:' + cServerPort + '/csv/comments';
  LoadInfo('Load Comments...');
  GetCsv(edGetUrlCSV.text, 'comments', lbCSVError, false, useCache);

  edGetUrlCSV.text := 'http://www.stonedcompany.de/FTUsersOnline/usersOnline.csv';
  LoadInfo('Load UsersOnline...');
  GetCsv(edGetUrlCSV.text, 'usersOnline', lbCSVError, false, false); // hier keinen Cache verwenden !

  lbCSVDebug('Load SymbolsUsersComments:' + inttostr(GetTickCount - gt));

  getSymbolsUsersCommentsTime := now;
end;

function TForm2.checkLastUpdate(): TDateTime;
var
  dt: TDateTime;
begin
  // in dieser Form nicht mehr notwendig da auf Server modified Daten abgelegt werden
  edGetUrlCSV.text := 'http://www.stonedcompany.de/FTServer/lastUpdate' + cServerPort + '.csv';
  LoadInfo('Load LastUpdate...');
  info.lastUpdateOnServer := 0; // -> wird nun gesetzt oder auch nicht
  GetCsv(edGetUrlCSV.text, 'lastUpdate' + cServerPort, lbCSVError, false, false); // hier keinen Cache verwenden !
  if (info.lastUpdateOnServer <> 0) then
  begin
    dt := info.lastUpdateOnServer;
  end;

  info.lastUpdateOnClient := faIni.ReadDateTime('updateOnClient:', 'dateTime', 0);
  // die �ltere Zeit z�hlt
  // Server=10:00  Client:07:00 Abrufen ab 07:00  merken: 10:00
  // Server=11:00 Client=11:30 kann niemals vorkommen und wenn dann muss client wieder ab 11:00 abrufen
  // n�chster Abruf um 10:09  Server:10:05 ab 10:05 und merken 10:05
  dt := info.lastUpdateOnServer;
  if (info.lastUpdateOnClient < dt) then
    dt := info.lastUpdateOnClient;
  // am Ende der Verarbeitung wird info.lastUpdateOnClient=info.lastUpdateOnServer und weggeschrieben

  // evtl bei Null etwas moderateres vorgeben ?
  if (dt = 0) then
    dt := now - 7; // 7 Tage default wenn nix geht
  result := dt;
  LoadInfo('...');
end;

procedure TForm2.chkFilterWithOpenActionsClick(Sender: TObject);
begin
  //
end;

procedure TForm2.btnSymbolGroupsClick(Sender: TObject);
var
  nam: string;
begin

  doSymbolGroups('cwsymbolsgroups', cwActions, cwActionsPlus, cwSymbolsGroups, cwSymbolsGroupsCt, lbSymbolsGroupsInfo);

  // diese Berechnungen werden letztlich gar nicht verwendet
  doSymbolGroupValues('cwsymbolsgroups', cwActions, cwActionsPlus, cwSymbolsGroups, cwSymbolsGroupsCt, lbSymbolsGroupsInfo);
  // Dieses Grid wird zwar gef�llt, ist aber gar nicht anzeigbar
  DynGrid8.initGrid('cwsymbolsgroups', 'groupId', 1, cwSymbolsGroupsCt, 18);

  // nochmal die Symbol-Liste neu darstellen weil jetzt die Symbolgruppen drin sind. Zwei Spalten am Ende ...
  btnCwSymbolsToGridClick(nil);

  // //das entf�llt
  // if (nam = 'btnGroupSymbolsFilteredActions') then
  // begin
  // pnlPieButtons.Visible := true;
  // doSymbolGroups('cwfilteredsymbolsgroups', cwFilteredActions, cwFilteredActionsPlus, cwFilteredSymbolsGroups,
  // cwFilteredSymbolsGroupsct, SGCwSymbolsGroups, lbSymbolsGroupsInfo);
  // end;
end;

procedure TForm2.doSymbolGroups(quelle: string; var actions: DACwAction; var actionsPlus: DACwActionPlus; var groups: DACwSymbolGroup; var groupsCt: integer; lb: TListBox);
// aus den actions (alle oder eine Teilmenge) werden Symbolgruppen gebildet mit �hnlichen Namen
// die Symbolgruppe aller Actions �ndert sich im Verlauf nicht
// die Symbolgruppe der Teilmenge von Actions �ndert sich
var
  i, j, k: integer;
  s, smerk, smerk5, s5, s6: string;
  t, t2: TStringList;
  nam: string;
  found: integer;
  typ: integer;
  gt: cardinal;
label weiter;

begin
  gt := GetTickCount;
  typ := 0;

  t := TStringList.Create;
  t.sorted := true;
  t2 := TStringList.Create;
  t2.sorted := false;
  smerk := '';
  for i := 0 to cwsymbolsct - 1 do
  begin
    s := leftstr(cwSymbols[i].name, 6);
    j := pos('.', s);
    if (j > 0) then
      s := leftstr(s, j - 1);
    j := pos('-', s);
    if (j > 0) then
      s := leftstr(s, j - 1);
    if s <> smerk then
    begin
      t.Add(s);
      smerk := s;
    end
    else
    begin

    end;
  end;
  smerk := '';
  for i := 0 to t.Count - 1 do
  begin
    if t.Strings[i] <> smerk then
    begin
      smerk := t.Strings[i];
      s5 := leftstr(smerk, 5);
      if s5 <> smerk5 then
        t2.Add(smerk)
      else
      // die 5 Buchstaben wiederholen sich also kein neues Groupsymbol anlegen
      begin
        t2.Strings[t2.Count - 1] := leftstr(t2.Strings[t2.Count - 1], 5);
      end;;
      smerk5 := s5;
    end;
  end;

  // jetzt k�nnten noch spezielle F�lle eliminiert werden
  // HOil NGas OJ

  // wie soll man das nun r�ckw�rts wieder Symbolen zuordnen ohne Missverst�ndnisse ?
  // wieder 6 links abschneiden -> GER30A  - das wurde sp�ter zu GER30  Aber es gibt auch ein GE und ein GER (angenommen)
  // wenn das GE nun �berpr�ft wird passen GE,GER und GER30A. Also ist GE das richtige weil es am k�rzesten ist - ok ?
  // also ... 6 abschneiden und pr�fen
  // wenn nix dann 5 abschneiden und pr�fen
  // wenn aber L�nge 1-4 gleich damit pr�fen
  // von den gepr�ften den k�rzesten Treffer verwenden

  // soll nun zu den Symbols eine SymbolGroupId gespeichert werden oder zu den SymbolGroups die SymbolIds ?
  // reicht eines davon ? Ist es nicht immer so da� im speziellen Array die Id des �bergeordneten gespeichert wird ?

  // lbGroupedSymbols.Items.Add('Groups:' + inttostr(lbGroupedSymbols.Items.Count));
  groupsCt := t2.Count;
  setlength(groups, groupsCt);
  for i := 0 to groupsCt - 1 do
  begin
    groups[i].groupId := i;
    groups[i].name := t2.Strings[i];
    groups[i].sourceNames := '';
    groups[i].sourceIds := '';
    groups[i].TradesCount := 0;
    groups[i].TradesVolumeTotal := 0;
    groups[i].TradesUsers := 0;
    groups[i].TradesProfitTotal := 0;
    groups[i].TradesSwapTotal := 0;
    groups[i].TradesProfitSwapTotal := 0;
  end;

  t.free;
  t2.free;

  found := -1;
  for i := 0 to cwsymbolsct - 1 do
  begin
    for k := 6 downto 1 do
    begin
      s6 := leftstr(cwSymbols[i].name, k);
      if (length(s6) = k) then
      begin
        for j := 0 to groupsCt - 1 do
        begin
          if leftstr(groups[j].name, k) = s6 then
          begin
            found := j;
            cwSymbolsPlus[i].groupId := j;
            goto weiter;
          end;
        end;
      end;
    end;
  weiter:
  end;
  lbCSVDebug('Z:Build SymbolGroups:' + inttostr(GetTickCount - gt));

  // damit sind die SymbolGroups ermittelt und k�nnen ab jetzt verwendet werden
  // jedem Symbol ist in cwSymbolsPlus().groupId eine GroupId zugeordnet welche die Nummer der Group darstellt

  // Der Rest ist hinf�llig weil k�nftig anders gel�st !
  // In den Filtern/Grouping wird separat alles nochmal gerechnet

  // Problem: die Actions werden zwar selektiert verwendet aber die groups ist das 'gro�e' Array mit allen Symbolen
  // - auch den in den selektierten Actions nicht verwendeten
  // die Zuordnung jedoch stimmt zwischen groups und cwsymbolsplus.
  // Lediglich die Summen stellen Teilsummen aus der Untergruppe der gefilterten Actions dar
  // die ganzen Werte k�nnen aus den actions gebildet werden (aufsummieren zB Volume) aber nicht direkt
  // die Anzahl verschiedener User
end;

procedure TForm2.doSymbolGroupValues(quelle: string; var actions: DACwAction; var actionsPlus: DACwActionPlus; var groups: DACwSymbolGroup; var groupsCt: integer; lb: TListBox);
var
  gt, gt2: cardinal;

begin
  gt2 := GetTickCount;
  gt := GetTickCount;
  computeSymbolGroupValues(actions, groups, lb); // einziger Aufruf -> Volume Profit Swap usw
  lbCSVDebug('Z:Get SymbolGroupsValues:' + inttostr(GetTickCount - gt));
  doCountUsersInActions(actions, actionsPlus, groups, groupsCt);
end;

procedure TForm2.doCountUsersInActions(var actions: DACwAction; var actionsPlus: DACwActionPlus; var groups: DACwSymbolGroup; var groupsCt: integer);
var
  gt, gt2: cardinal;
  aba: array of Bytearray;
  i, j, ll, ct: integer;
begin
  // global: cwSymbolsPlus wegen der groupIds und cwUsers
  // �bergeben werden die  actions,actionsplus und groups wo dann sp�ter die Anzahl Users drinstehen
  gt := GetTickCount;
  // Zweck: User z�hlen �ber ein 2-dimensionales Riesenarray  // aba = Array of ByteArray
  setlength(aba, groupsCt);
  ll := length(cwUsers);
  for i := 0 to groupsCt - 1 do
  begin
    setlength(aba[i], ll);
  end;
  for i := 0 to groupsCt - 1 do // ganze Matrix nullsetzen
    for j := 0 to length(cwUsers) - 1 do
      aba[i][j] := 0;
  lbCSVDebug('Z:Usercount vorbereiten:' + inttostr(GetTickCount - gt));
  gt := GetTickCount;
  for i := 0 to length(actions) - 1 do
  begin
    // alle Actions mit Gruppe/UserID in Matrix um 1 erh�hen
    // alte Variante: inc(aba[cwSymbolsPlus[cwActions[i].symbolId].groupId, finduserindex(actions[i].userId)]); war langsamer wegen findUserIndex
    try
      inc(aba[cwSymbolsPlus[actions[i].symbolId].groupId, actionsPlus[i].userIndex]);
    except
      on E: Exception do // hier kommen etliche Fehler vor
        lbCSVDebug('Err doSymbolGroupValues:' + E.ToString);
    end;
  end;
  lbCSVDebug('Z:User einf�llen:' + inttostr(GetTickCount - gt));
  gt := GetTickCount;
  for i := 0 to groupsCt - 1 do
  begin
    // wieviele User kommen in der jeweiligen (Symbol)Gruppe vor
    ct := 0;
    for j := 0 to length(cwUsers) - 1 do
    begin
      if aba[i, j] > 0 then
        ct := ct + 1;
    end;
    if (ct > 0) then
    begin
      groups[i].TradesUsers := ct;
    end;
  end;
  lbCSVDebug('Z:Gruppen Userwerte zuordnen:' + inttostr(GetTickCount - gt));
  gt2 := GetTickCount - gt2;
  lbCSVDebug('Z:Gruppen Userwerte gesamt:' + inttostr(gt2)); // 141 msec f�r alle 3.5MioActions

end;

procedure TForm2.DynGrid10MenuItem10Click(Sender: TObject);
begin
  DynGrid10.MenuItem10Click(Sender);

end;

procedure TForm2.DynGrid10MenuItem8Click(Sender: TObject);
begin
  DynGrid10.CSVExport1Click(Sender);

end;

procedure TForm2.DynGrid10Selection2ndGrid1Click(Sender: TObject);
begin
  DynGrid10.Selection2ndGrid1Click(Sender);

end;

procedure TForm2.DynGrid10SGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  grid: FTCommons.TStringGridSorted;
  col, row, mdcol, mdrow: integer;
begin
  DynGrid10.SGMouseDown(Sender, Button, Shift, X, Y);
  grid := Sender as FTCommons.TStringGridSorted;
  if Button = mbleft then
  begin
    grid.MouseToCell(X, Y, col, row);
    mdcol := col;
    mdrow := row;

    dyngridMouseLeftClickHandler('users', grid, col, row, grid.Cells[col, row], grid.Cells[col, 0], grid.Cells[0, row]);

  end;
end;

procedure TForm2.DynGrid10SpeedButton1Click(Sender: TObject);
begin
  DynGrid10.SpeedButton1Click(Sender);
end;

procedure TForm2.DynGrid1RemoveSelection1Click(Sender: TObject);
begin
  DynGrid1.RemoveSelection1Click(Sender);

end;

procedure TForm2.DynGrid1SpeedButton1Click(Sender: TObject);
begin
  DynGrid1.SpeedButton1Click(Sender);

end;

procedure TForm2.DynGrid4CSVExportSelection1Click(Sender: TObject);
begin
  DynGrid4.CSVExport1Click(Sender);

end;

procedure TForm2.DynGrid4MenuItem2Click(Sender: TObject);
begin
  DynGrid4.Selectcolumns1Click(Sender);

end;

procedure TForm2.DynGrid4MenuItem3Click(Sender: TObject);
begin
  DynGrid4.CSVExport1Click(Sender);

end;

procedure TForm2.DynGrid4SpeedButton1Click(Sender: TObject);
begin
  DynGrid4.SpeedButton1Click(Sender);

end;

procedure TForm2.DynGrid6SpeedButton1Click(Sender: TObject);
begin
  DynGrid6.SpeedButton1Click(Sender);

end;

procedure TForm2.DynGrid9Selectcolumns1Click(Sender: TObject);
begin
  DynGrid9.Selectcolumns1Click(Sender);
end;

procedure TForm2.DynGrid9SpeedButton1Click(Sender: TObject);
begin
  DynGrid9.SpeedButton1Click(Sender);

end;

procedure TForm2.btnListDoublesCwClick(Sender: TObject);
// liste alle doppelten OrderIds auf - macht aber sonst nichts!
var
  i: integer;
  merk: array of integer;
  max: integer;
begin
  max := 5000000;
  // Check doubles
  setlength(merk, max);
  for i := 0 to max - 1 do
  begin
    merk[i] := 0;
  end;

  for i := 0 to length(cwActions) - 1 do
  begin
    if cwActions[i].actionId < max then

      merk[cwActions[i].actionId] := merk[cwActions[i].actionId] + 1;
  end;

  for i := 0 to max - 1 do
  begin
    if merk[i] > 1 then
    begin
      lbCSVDebug('Doppelte Order:' + inttostr(i) + ':' + inttostr(merk[i]));
    end;
  end;
end;

procedure TForm2.btnLoadDataClick(Sender: TObject);
var
  all: boolean;
  i: integer;
  appendCSVUsers: boolean;
  appendBinActions: boolean;
  whichAccounts: string;
  p: integer;
  gt: cardinal;
begin
  gt := GetTickCount;
  whichAccounts := '';
  Panel10.enabled := false;
  lbLoadInfo.Items.clear;
  Dialog2.fdialog2.lbLoadInfo.Items.clear;
  Dialog2.fdialog2.info('');
  all := true;
  for i := 0 to clbBrokers.Count - 1 do
  begin
    if clbBrokers.Checked[i] = false then
    begin
      all := false;
      break;
    end;
  end;

  lastUpdateServerUnixTime := faIni.ReadInteger('lastUpdateServerUnixTime:', 'unixTime', 0);

  if all = true then
  // wenn alle Broker angehakelt sind - was eigentlich sowieso immer der Fall sein d�rfte
  begin
    // man k�nnte auch sagen wenn der Cache �lter ist als 4 Tage alles neu laden !

    if (lastUpdateServerUnixTime <> 0) and ((datetimetounix(now) - lastUpdateServerUnixTime) < (4 * 86400)) then
      // wenn cache da ist aber noch keine Serverzeit nochmal den ganzen Pack laden
      if cbLoadActionsFromCache.Checked = true then
      begin
        // holt Symbols Users und Comments vom Cache oder wenn noch nicht vorhanden vom Server
        getSymbolsUsersComments(true);
        btnLoadCacheFileCwClick(nil); // die Actions
        LoadInfo(inttostr(length(cwActions)) + ' Actions loaded from Cache');
      end;

    if ((cbLoadActionsFromCache.Checked = false) or (length(cwActions) = 0)) then
    begin
      getSymbolsUsersComments(false); // holt vom Server
      GetLastServerUnixTime; // -> lastServerUnixTime
      lastUpdateServerUnixTime := lastServerUnixTime;
      faIni.WriteInteger('lastUpdateServerUnixTime:', 'unixTime', lastUpdateServerUnixTime);

      LoadInfo('Load All Actions (wait!) ...');
      setlength(cwActions, 0); // NEU 9.12.19
      GetBinData('http://h2827643.stratoserver.net:' + cServerPort + '/bin/actions', 'actions', lbCSVError, false);
      // false=nicht anh�ngen
      btnSaveCacheFileCwClick(nil);
      LoadInfo(inttostr(length(cwActions)) + ' Actions loaded from Server');

    end;
    LoadInfo('Loading data finished');
    whichAccounts := 'All accounts/';
  end
  else
  begin

    edGetUrlCSV.text := 'http://h2827643.stratoserver.net:' + cServerPort + '/csv/symbols';
    LoadInfo('Load Symbols...');
    GetCsv(edGetUrlCSV.text, 'symbols', lbCSVError, false, true);
    LoadInfo(inttostr(length(cwSymbols)) + ' Symbols');

    // edGetUrlCSV.text := 'http://h2827643.stratoserver.net:'+cServerPort+'/csv/users';
    // LoadInfo('Load Users...');
    // GetCsv(edGetUrlCSV.text,'users', lbCSVError, false,true);
    // LoadInfo(inttostr(length(cwUsers)) + ' Users');

    edGetUrlCSV.text := 'http://h2827643.stratoserver.net:' + cServerPort + '/csv/comments';
    LoadInfo('Load Comments...');
    GetCsv(edGetUrlCSV.text, 'comments', lbCSVError, false, true);
    LoadInfo(inttostr(length(cwComments)) + ' Comments');

    appendBinActions := false;
    appendCSVUsers := false;

    GetLastServerUnixTime;
    lastUpdateServerUnixTime := lastServerUnixTime;
    faIni.WriteInteger('lastUpdateServerUnixTime:', 'unixTime', lastUpdateServerUnixTime);

    // kann ich hier schon merken da ja sowieso ALLE Daten der Accounts abgerufen werden

    for i := 0 to clbBrokers.Count - 1 do
    begin
      if clbBrokers.Checked[i] = true then
      begin
        whichAccounts := whichAccounts + clbBrokers.Items[i] + '/';
        LoadInfo('Load Users...');
        GetCsv('http://h2827643.stratoserver.net:' + cServerPort + '/csv/users?accountId=' + inttostr(i + 1), 'users', lbCSVError, appendCSVUsers, false);
        appendCSVUsers := true; // ab dem 2.mal anh�ngen !
        LoadInfo(inttostr(length(cwUsers)) + ' Users');

        // edGetUrlBin.text := 'http://h2827643.stratoserver.net:' + cServerPort + '/bin/actions?accountId=' +
        // inttostr(i + 1);  unn�tig
        LoadInfo('Load Actions...');
        GetBinData('http://h2827643.stratoserver.net:' + cServerPort + '/bin/actions?accountId=' + inttostr(i + 1), 'actions', lbCSVError, appendBinActions);
        appendBinActions := true;
        // ab dem 2.mal anh�ngen . Die Actions des erste Accounts werden nat�rlich nicht angeh�ngt aber dann die folgenden schon !

        LoadInfo(inttostr(length(cwActions)) + ' Actions');

        LoadInfo('Loading finished');

      end

    end;

  end;

  // fillStartScreen;

  LoadInfo('Data preparation');
  whichAccounts := leftstr(whichAccounts, length(whichAccounts) - 1);
  lblAllDataInfo.Caption := whichAccounts + #13#10 + ' Users:' + inttostr(length(cwUsers)) + #13#10 + ' Symbols:' + inttostr(length(cwSymbols)) + #13#10 + ' Actions:' + inttostr(length(cwActions)) + #13#10 + #13#10;
  // ifthen(length(cwActions) <= maxActionsPerGrid, '', '[In Grid:' + inttostr(maxActionsPerGrid) + ']');

  if (claus = true) then
  begin
    TabSheet1.TabVisible := true; // Filter
    TabSheet6.TabVisible := true; // All Data
    TabSheet5.TabVisible := true; // User

  end;
  // TabSheet7.TabVisible := true; // SymbolsGroups

  dosleep(CSleep);

  doFinalizeData;

  Panel10.enabled := true;
  LoadInfo('Finished');
  Dialog2.fdialog2.info2('');

  setPageIndex(1); // 0; // START

  computeStartScreen;
  dosleep(CSleep);
  pnlStart.Caption := '';
  pnlStart.Visible := true;
  pnlStart.Refresh;
  lbCSVDebug('Ladezeit komplett:' + inttostr(GetTickCount - gt));
  Dialog2.fdialog2.Button1click(nil);

  updateTimer.enabled := true;
  updateTimerStarted := now;
  // nextUpdateTicks:=gettickcount+updateTimer.interval;
end;

procedure TForm2.LoadInfo(s: string);
begin
  // lblLoadInfo.Caption := s;
  lbLoadInfo.Items.Add(s);
  Dialog2.fdialog2.lbLoadInfo.Items.Add(s);
  Dialog2.fdialog2.info(s);
  Memo1.lines.clear;
  Memo1.lines.Add(s);
  // lblLoadInfo.Repaint;
  lbLoadInfo.Repaint;
  Dialog2.fdialog2.lbLoadInfo.Repaint;

end;

procedure TForm2.doLockWindowUpdate(yn: boolean);
// Klappt alles nicht richtig !
begin
  if (yn = true) then
    SendMessage(Form2.pnlFilter.Handle, WM_SETREDRAW, WPARAM(false), 0)
  else
  begin
    SendMessage(Form2.pnlFilter.Handle, WM_SETREDRAW, WPARAM(true), 0);
    Form2.pnlFilter.Repaint;
  end;

  // LockWindowUpdate(Form2.WindowHandle);
end;

procedure TForm2.machActionsUserIndex;
var
  i, j: integer;
  index: integer;
  gt: cardinal;

begin
  //
  gt := GetTickCount;
  for i := 0 to length(cwActions) - 1 do
  begin
    index := finduserindex(cwActions[i].userId);
    cwActionsPlus[i].userIndex := index;
  end;
  lbCSVDebug('Z:MachActionsUserIndex:' + inttostr(GetTickCount - gt));
end;

procedure TForm2.doFinalizeData;
var
  i, p: integer;
  gt: cardinal;
  sort: Stringarray; // string
  isort: intarray;
begin
  // Nun alle zus�tzlichen Berechnungen durchf�hren, die nach dem Laden der Actions usw notwendig sind
  // Es sind manche Berechnungen nach einem Update nicht unbedingt notwendig. zB wenn sich User oder Symbole
  // gar nicht ge�ndert haben.
  // symbole sortieren in einem extra Feld
  gt := GetTickCount;
  cwsymbolsct := length(cwSymbols);
  setlength(sort, cwsymbolsct);
  setlength(cwsymbolsSortindex, cwsymbolsct);
  for i := 0 to cwsymbolsct - 1 do
  begin
    sort[i] := cwSymbols[i].name;
    cwsymbolsSortindex[i] := i;
  end;
  dosleep(CSleep);
  fastsort2arrayString(sort, cwsymbolsSortindex, 'VUAS');
  dosleep(CSleep);

  // users Sortieren in einem extra Feld
  cwusersct := length(cwUsers);
  setlength(isort, cwusersct);
  // findUserIndex und findUserName verwenden die cwUsersSortindex und cwUsersSortindex2
  setlength(cwUsersSortindex, cwusersct); // cwUsersSortIndex(111)='8212345=111'
  setlength(cwUsersSortindex2, cwusersct); // cwUsersSortIndex2(111)=8212345
  for i := 0 to cwusersct - 1 do
  begin
    isort[i] := cwUsers[i].userId;
    cwUsersSortindex[i] := inttostr(cwUsers[i].userId) + '$' + inttostr(i);
  end;
  dosleep(CSleep);
  fastsort2arrayIntegerString(isort, cwUsersSortindex, 'VUA');
  dosleep(CSleep);
  for i := 0 to cwusersct - 1 do
  begin
    p := pos('$', cwUsersSortindex[i]) - 1;
    cwUsersSortindex2[i] := strtoint(leftstr(cwUsersSortindex[i], p));
  end;

  dosleep(CSleep);

  machActionsUserIndex(); // einmalig die Userindices aus den Useraccountnummern berechnen
  dosleep(CSleep);

  btnDoUsersAndSymbolsPlusClick(nil);
  // zus�tzliche berechnete Felder f�r cwusers erstellen in cwusersplus  und cwsymbolsplus
  dosleep(CSleep);

  // den ersten User 'anklicken' und dessen actions im Grid darstellen
  edSingleUserActionsId.text := inttostr(cwActions[0].userId);

  btnGetSingleUserActionsClick(nil);
  dosleep(CSleep);

  btnSymbolGroupsClick(nil); // Symbolgruppen erzeugen und anschliessend Werte berechnen
  dosleep(CSleep);

  lbCSVDebug('Sym/Users prepare:' + inttostr(GetTickCount - gt));
  gt := GetTickCount;
  // die 4 Grids in Alle bef�llen
  dosleep(CSleep);
  btnCwSymbolsToGridClick(nil);
  dosleep(CSleep);
  btnCwusersToGridClick(nil);
  dosleep(CSleep);
  btnCwCommentsToGridClick(nil);
  dosleep(CSleep);
  btnCwactionsToGridClick(nil);
  lbCSVDebug('4 Grid:' + inttostr(GetTickCount - gt));

end;

// procedure TForm2.machPieChart(data: DAPieValue; datact: integer; para: TPieParameters; cv: TAdvGDIPChartView;
// pane: integer; serie: integer);
// var
// i: integer;
// begin
// cv.BeginUpdate;
// cv.panes[pane].series[serie].ClearPoints;
// for i := 0 to datact - 1 do
// cv.panes[pane].series[serie].AddPiePoints(data[i].value, data[i].text, data[i].color1, data[i].color2, 0, true);
// cv.EndUpdate;
//
// end;

procedure TForm2.PageControl1Change(Sender: TObject);
// var
// a: integer;
begin
  // a := PageControl1.TabIndex;
  // // wirksam um die falschen Skinnings zu beseitigen
  // PageControl1.ActivePage.Width := PageControl1.ActivePage.Width + 1;
  // if PageControl1.ActivePage.TabIndex = 5 then // caption='SymbolsGroups' then
  // begin
  // remeasureCategoryPanels(CategoryPanelGroup3);
  // end;
  // if PageControl1.ActivePage.TabIndex = 3 then // caption='SymbolsGroups' then
  // begin
  //
  // if (firstSampleDone = false) then
  // begin
  // btnSampleClick(btnSample2);
  // firstSampleDone := true;
  // end;
  // end;
  // if PageControl1.ActivePage.TabIndex = 1 then // all data
  // begin
  // end;

  //
end;

procedure TForm2.Panel26Resize(Sender: TObject);
begin
  // NEU das ist die Rettung damit die Scrollbars nach Resize des Forms richtig positioniert werden
  // Panel4.Width := Panel4.Width + 1;
  // Panel4.Width := Panel4.Width - 1;

end;

procedure TForm2.Panel6Resize(Sender: TObject);
begin
  // NEU das ist die Rettung damit die Scrollbars nach Resize des Forms richtig positioniert werden
  // DynGrid4.Width := DynGrid4.Width + 1;
  // DynGrid4.Width := DynGrid4.Width - 1;

end;

procedure TForm2.pnlStartBackResize(Sender: TObject);
begin
  // NEU das ist die Rettung damit die Scrollbars nach Resize des Forms richtig positioniert werden
  // pnlStart.Left := pnlStartBack.Left + trunc(pnlStartBack.Width / 2 - pnlStart.Width / 2);
  // pnlStart.Top := pnlStartBack.Top + trunc(pnlStartBack.Height / 2 - pnlStart.Height / 2);
end;

procedure TForm2.btnLoadCacheFileCwClick(Sender: TObject);
begin
  loadCacheFileCw(cCacheFolder + '\actions.bin', 'actions', lbCSVError);

  doCacheGridCwInfo;
  lblAllDataInfo.Caption := 'From Cache  Users:' + inttostr(length(cwUsers)) + #13#10 + ' Symbols:' + inttostr(length(cwSymbols)) + #13#10 + 'Actions:' + inttostr(length(cwActions));

end;

procedure TForm2.btnSelectClearCwClick(Sender: TObject);
begin
  cwFilteredActionCt := 0;
  setlength(cwFilteredActions, 0);
  setlength(cwFilteredActionsPlus, 0);
  if 1 = 1 then
  begin
    ClearStringGridSorted(SGCacheCwSearch);
    // 5367  msec bei 200000
    SGCacheCwSearch.rowcount := 1;
  end
  else
    // StringGridLeer(SGCacheCwSearch);
    // 5414 msec bei 200000
    SGCacheCwSearch.rowcount := 1;
  doCacheGridCwInfo;
end;

procedure TForm2.btnShowCacheCwClick(Sender: TObject);
var
  max: integer;
  stp: integer;
begin
  max := strtoint(edCacheCwShowMax.text);
  if length(cwActions) < max then
    max := length(cwActions)
  else;
  // showmessage('Die Darstellung wird auf ' + edCacheShowMax.Text + ' Eintr�ge beschr�nkt!');

  // stp := strtoint(edCacheCwShowStep.text);
  // doActionsGridCW(SGCwCache, SGFieldCol, cwActions, length(cwActions), max, stp);
  // autosizegrid(SGCwCache);
  //
  // doCacheGridCwInfo;
  DynGrid3.initGrid('cwactions', 'userId', 1, length(cwActions), 30);
end;

procedure TForm2.btnPieChartClick(Sender: TObject);
var
  data: DAPieValue;
  datact: integer;
  para: TPieParameters;
  i, j: integer;
  serie: integer;
  pane: integer;
  styp: integer;
begin
  // die Top-X und den Rest als Piechart darstellen
  // TPieValue DAPieValue

  if (Sender = btnPieChart1) then
    styp := 1;
  if (Sender = btnPieChart2) then
    styp := 2;
  if (Sender = btnPieChart3) then
    styp := 3;

  para.header := 'test';
  pane := 0;
  serie := 0;
  datact := cwFilteredSymbolsGroupsct;
  setlength(data, datact);
  for i := 0 to datact - 1 do
  begin
    if styp = 1 then
      data[i].value := 0; // cwFilteredSymbolsGroups[i].TradesCount; // , cwFilteredSymbolsGroupsct;
    if styp = 2 then
      data[i].value := 0; // cwFilteredSymbolsGroups[i].TradesVolumeTotal; // , cwFilteredSymbolsGroupsct;
    if styp = 3 then
      data[i].value := 0; // cwFilteredSymbolsGroups[i].TradesProfitTotal; // , cwFilteredSymbolsGroupsct;
    data[i].text := cwFilteredSymbolsGroups[i].name;
    data[i].color1 := random($1000000);
    data[i].color2 := random($1000000);
  end;
  // machPieChart(data, datact, para, SymbolsGroupsPieChartView, pane, serie);
end;

procedure TForm2.btnLadeDialogClick(Sender: TObject);
begin
  // TrackBar1.Position := 170;
  // Dialog2.FDialog2.Timer1.enabled := true;
  StartTimer.enabled := true;
  // TrackBar1.Position := 255;
  // btnStartDialog.Visible := false;

end;

procedure TForm2.getOpenActions(dt: TDateTime; serverTyp: integer; doAppend: boolean; sZeit: string; var openActions: DACwOpenActions);
var
  pstring: string;
  httpFehler: integer;
  lvorher, lnachher: integer;
  nochmal: boolean;
  dt2: TDateTime;
begin
  // sZeit='1' oder '2'
  dt2 := dt;
  lvorher := length(openActions);
  nochmal := true; // einmal immer
  while (nochmal = true) do
  begin
    pstring := '?year=' + FormatDateTime('YYYY', dt2) + '&month=' + FormatDateTime('MM', dt2) + '&day=' + FormatDateTime('DD', dt2) + '&accountId=' + inttostr(serverTyp);
    // httpFehler := doHttpPutMemoryStreamToWorker(mStream, edHTTPAddress.text + cServerPort + '/bin/openProfit' + pstring);
    GetBinDataOpenActions('http://h2827643.stratoserver.net:' + cServerPort + '/bin/openProfit' + pstring, 'openActions' + sZeit, lbCSVError, openActions, doAppend, true);
    // wenn sich die L�nge nicht ge�ndert hat - also keine Daten gefunden wurden - wird an Sonntagen und Samstagen jeweils r�ckw�rts nochmal gesucht
    if (length(openActions) = lvorher) then
    begin
      // war wohl nix
      lbdebug('nix:' + pstring);
      if ((dayofweek(dt2) = 1) or (dayofweek(dt2) = 7)) then // Sonntag(1) oder Samstag(7) eines zur�ck versuchen
      begin
        dt2 := dt2 - 1;
        nochmal := true;
      end
      else
        nochmal := false;
    end
    else
    begin
      lbdebug('ok:' + pstring);
      nochmal := false;
    end;
  end;

end;

procedure TForm2.getAndSortOpenActions(dt: TDateTime; var openActionsz: DACwOpenActions; accVon: integer; accBis: integer);
var
  i: integer;
  actionId: int64Array;
  ix: intarray;
  ct: integer;
  s: String;
var
  openActions: DACwOpenActions;
begin
  // btnSaveCacheFileCwClick(nil);
  setlength(openActions, 0);
  s := 'Load open actions:' + datetimetostr(dt);
  LoadInfo(s);
  // es werden die Daten von allen 7 Accounts nacheinander aneinandergeh�ngt

  getOpenActions(dt, accVon, false, '1', openActions);
  for i := accVon + 1 to accBis do
    // NICHT f�r LCG B abrufen weil des dort KEINE OPEN ACTIONS gibt
    if (i <> 2) then
      getOpenActions(dt, i, true, '1', openActions);

  ct := length(openActions);
  if (ct > 0) then
  begin
    setlength(actionId, ct);
    setlength(ix, ct);
    for i := 0 to ct - 1 do
    begin
      actionId[i] := openActions[i].actionId;
      ix[i] := i;
    end;

    fastsort2arrayInt64Int(actionId, ix, 'VUI'); // VDI
    setlength(openActionsz, ct);
    lbDummy.Items.clear;
    lbDummy.Items.BeginUpdate;
    for i := 0 to ct - 1 do
    begin
      openActionsz[i] := openActions[ix[i]];
      lbDummy.Items.Add(inttostr(openActionsz[i].actionId));
    end;
    lbDummy.Items.EndUpdate;

  end
  else
  // keine Daten an diesem Tag vorhanden
  begin
    LoadInfo('No open actions available:' + datetimetostr(dt));
    dosleep(2500);
    setlength(openActionsz, 0);
  end;

  // nun ist bereits alles sortiert und zusammengefasst in EINEM array statt 6(7)
  LoadInfo('');
end;

procedure TForm2.Button11Click(Sender: TObject);
var
  gt: cardinal;
  i, ct: integer;
  a: DACwAction;
begin
  ct := 0;
  gt := GetTickCount;
  for i := 0 to length(cwActions) - 1 do
  begin
    if (cwActions[i].actionId <> 0) then
      inc(ct);
  end;
  showmessage(inttostr(GetTickCount - gt) + ' ' + inttostr(ct));
  ct := 0;
  gt := GetTickCount;
  setlength(a, length(cwActions));
  for i := 0 to length(cwActions) - 1 do
  begin
    if (cwActions[i].actionId <> 0) then
      a[i] := cwActions[i];
  end;
  showmessage(inttostr(GetTickCount - gt) + ' ' + inttostr(ct));
end;

procedure TForm2.Button12Click(Sender: TObject);
var
  buttonselected: integer;
begin
  buttonselected := messagedlg('Really delete Filter: ' + cbLoadFilters.text + ' ?', mtError, mbOKCancel, 0);
  if (buttonselected = mrOK) then
  begin
    try
      deletefile(cbLoadFilters.text + '.flt');
      fillCbLoadFilters;
    except
      showmessage('File nox exists!');
    end;
  end;
end;

procedure TForm2.btnReportClick(Sender: TObject);
var
  Evals: array [1 .. 5, 1 .. 3] of EvaluationResult;
  fe: TFilterParameter;
  d, b, i: integer;
  s, s1, s2: string;
  sDate1: array [1 .. 5] of string;
  sDate2: array [1 .. 5] of string;
  sBroker: array [1 .. 3] of string;
  Ei: array [1 .. 5, 1 .. 3] of TFrame11;
  Ri: array [1 .. 5] of TReportInfo;
  Tx: Array [1 .. 5] of String;
  gt: cardinal;
label raus;

begin
  // zuerst Cache l�schen
  deletefiles(ExtractFilePath(paramstr(0)) + cCacheFolder, 'y*.bin');
  gt := GetTickCount;
  btnReportStop.Visible := true;
  btnReport.Visible := false;
  pnlInspectorWait.Visible := true;
  pnlInspectorBedienung.enabled := false;
  // 1=LCG 2=AT 3=Summe
  // Zeit1  heute morgen
  // Zeit2  heute-7 morgen-7
  // Zeit3  monat monat+1 oder morgen
  // Zeit4  monat-1 monat
  // Zeit5  jahr morgen

  // Evaluation durchf�hren
  // Haken an Action in TimeRange aktivieren
  // nochmal Filtern
  // Grouping auf BrokerAccount Summe in Header ist TradesAnzahl
  // Grouping auf SymbolGroup Stringarray die ersten zB 3 SymbolGruppen

  // Darstellung in eigenem Tab mit FrameElement das die Parameter enth�lt
  Ei[1, 1] := Frame111;
  Ei[1, 2] := Frame112;
  Ei[1, 3] := Frame113;
  Ei[2, 1] := Frame114;
  Ei[2, 2] := Frame115;
  Ei[2, 3] := Frame116;
  Ei[3, 1] := Frame117;
  Ei[3, 2] := Frame118;
  Ei[3, 3] := Frame119;
  Ei[4, 1] := Frame120;
  Ei[4, 2] := Frame121;
  Ei[4, 3] := Frame122;
  // die restlichen 3 erstmal weglassen
  Ei[5, 1] := Frame123;
  Ei[5, 2] := Frame124;
  Ei[5, 3] := Frame125;
  Ri[1] := ReportInfo1;
  Ri[2] := ReportInfo2;
  Ri[3] := ReportInfo3;
  Ri[4] := ReportInfo4;
  Ri[5] := ReportInfo5;

  Tx[1] := 'Heute';
  Tx[2] := '7-Tage';
  Tx[3] := 'Lfd.Monat';
  Tx[4] := 'Voriger Monat';
  Tx[5] := 'Lfd.Jahr';

  // die Angaben sind immer inclusive Start - exclusive Ende
  sDate1[1] := 'heute';
  sDate2[1] := 'morgen';

  sDate1[2] := 'heute-6';
  sDate2[2] := 'morgen';

  sDate1[3] := 'monat';
  sDate2[3] := 'morgen';

  sDate1[4] := 'monat-1';
  sDate2[4] := 'monat';

  sDate1[5] := 'jahr';
  sDate2[5] := 'morgen';

  sBroker[1] := 'LCG';
  sBroker[2] := 'ActiveTrades';
  sBroker[3] := 'LCG,ActiveTrades';

  // erstmal alle abschalten
  fe.comment := (Sender as TButton).Caption;

  s1 := '';
  s2 := '';
  for d := 1 to 5 do

    for b := 1 to 3 do
    begin
      Ei[d, b].init; // .setValues(evals[d,b]);
      Ri[d].init; // setValues(tx[d],s1,s2);
    end;

  for d := 1 to 5 do
  begin
    for b := 1 to 3 do
    begin
      dosleep(1);
      if (reportStop = true) then
      begin
        goto raus;
      end;
      Evals[d, b].clear;
      fe.Active := false;
      for i := 1 to FilterCt do
      begin
        Filter[i].setValues(fe);
      end;

      fe.Active := true;
      fe.topic := 'ActionType';
      fe.operator := '<>';
      fe.values := 'BALANCE,CREDIT';
      Filter[1].setValues(fe);

      fe.Active := true;
      fe.topic := 'BrokerId';
      fe.operator := '=';
      fe.values := sBroker[b];
      Filter[2].setValues(fe);

      fe.Active := true;
      fe.topic := 'CloseDateTime';
      fe.operator := '>= or 0';
      fe.values := sDate1[d];
      Filter[3].setValues(fe);

      fe.Active := true;
      fe.topic := 'OpenDateTime';
      fe.operator := '<';
      fe.values := sDate2[d];
      Filter[4].setValues(fe);

      fe.Active := false;
      fe.topic := '-';
      fe.operator := 'true';
      fe.values := '';
      Filter[5].setValues(fe);

      pnlFilter.Repaint;

      doFilter;

      screen.Cursor := crHourGlass;
      // Problem: durch die Einschr�nkung stimmen nun die Zahlen nicht mehr
      makeEvaluation(Evals[d, b], 'cwfilteredactions');
      // btnShowEvaluation.Visible := true;
      // btnShowEvaluationClick(nil);
      // und nun die restlichen Werte der Evaluation bef�llen

      // nun Einschr�nkung auf die tats�chlich gehandelten Trades im Zeitraum

      fe.Active := true;
      fe.topic := 'Action in TimeRange';
      fe.operator := 'true';
      fe.values := '';
      Filter[5].setValues(fe);
      pnlFilter.Repaint;
      doFilter;

      Grouping[1].cbTopic.text := 'userId';
      Grouping[1].cbTopic.Visible := true;
      Grouping[1].chkActive.Checked := true;
      doGroup();
      // -> Anzahl Users steht in der �berschrift
      Evals[d, b].usersCt := DynGrid9.maxdatarows;

      Grouping[1].cbTopic.text := 'symbolGroup';
      Grouping[1].cbTopic.Visible := true;
      Grouping[1].chkActive.Checked := true;
      doGroup();
      DynGrid9.sortcol := 'tradesCount';
      DynGrid9.sortdir := 1; // abw�rts
      DynGrid9.doSorting;
      try
        s := DynGrid9.SG.Cells[0, 1] + ' ' + DynGrid9.SG.Cells[0, 2] + ' ' + DynGrid9.SG.Cells[0, 3] + ' ' + DynGrid9.SG.Cells[0, 4] + ' ' + DynGrid9.SG.Cells[0, 5] + ' ' + DynGrid9.SG.Cells[0, 6] + ' ' + DynGrid9.SG.Cells[0, 7];
      except
      end;
      // -> Anzahl SymbolGruppen steht in der �berschrift
      // aus sSort die ersten soundsovielen aussuchen
      Evals[d, b].mostSymbols := s;

      // nun die Eintr�ge vornehmen
      Ei[d, b].setValues(Evals[d, b]);

      s1 := 'Ab Datum: ' + FormatDateTime('dd/mm/yy', Evals[d, b].z1 + 1);
      s2 := 'Bis Datum: ' + FormatDateTime('dd/mm/yy', Evals[d, b].z2);

      Ri[d].setValues(Tx[d], s1, s2);
      screen.Cursor := crDefault;
    end;
    setPageIndex(10);
  end;
  setPageIndex(10);
  /// /test eine Sortierung 'fernzusteuern'
  // dyngrid2.sortcol:='ActionID';
  // dyngrid2.sortdir:=0; //aufw�rts
  // dyngrid2.doSorting;
  // if dyngrid2.sDatenTyp=1  then
  /// / double
  // else
  /// / string

  // button13.test:=1; //das ist der abgeleitete TButton aus FTCOmmons der die Eigenschaft test hat !

  // nicht nur beimReport sondern allgemein sollten diese alten Cachefiles entfernt werden
  deleteTodaysOpenActionCacheFiles(now);
  deleteTodaysOpenActionCacheFiles(now - 1);
  deleteTodaysOpenActionCacheFiles(now - 2);

  if (cw = true) then
    showmessage(inttostr(GetTickCount - gt));
raus:
  // ganz wichtig das wieder anzuschalten!
  reportStop := false;
  btnReportStop.Visible := false;
  btnReport.Visible := true;
  pnlInspectorBedienung.enabled := true;
  pnlInspectorWait.Visible := false;
  deletefiles(ExtractFilePath(paramstr(0)) + cCacheFolder, 'y*.bin');
end;

procedure TForm2.btnReportStopClick(Sender: TObject);
begin
  reportStop := true;

end;

procedure TForm2.btnShowEvaluationClick(Sender: TObject);
begin
  // lastUpdateServerUnixTime := faIni.ReadInteger('lastUpdateServerUnixTime:', 'unixTime', 0);
  // Show Evaluation
  form10.show;
  form10.zeigen;

  // die zus�tzliche Darstellung der OpenActions f�r die beiden Zeitr�ume in einem eigenen Tab zur Fehlersuche bzw Verdeutlichung
  // Dies sind immer die OpenActions �ber alle Broker hinweg !
  // hier sind immer ein paar Actions weniger enthalten als in den Grids des Inspectors

  DynGrid11.initGrid('cwopenactions1', 'actionId', 1, length(cwOpenActionsZ1), 13);
  DynGrid11.lblHeader.Caption := 'OpenActions:' + inttostr(length(cwOpenActionsZ1));

  DynGrid12.initGrid('cwopenactions2', 'actionId', 1, length(cwOpenActionsZ2), 13);
  DynGrid12.lblHeader.Caption := 'OpenActions:' + inttostr(length(cwOpenActionsZ2));

  DynGrid13.initGrid('cwopenactionsOTR', 'actionId', 1, length(cwTradeRecords), 13);
  DynGrid13.lblHeader.Caption := 'OpenActionsOTR:' + inttostr(length(cwTradeRecords));

end;

procedure TForm2.Button2Click(Sender: TObject);
var
  gt: cardinal;
  i, j, l: integer;
  ia: intarray;
  ia2: intarray;
  da: doublearray;
  sa: Stringarray;
begin
  // Sorttests
  gt := GetTickCount;
  l := length(cwActions);
  lbCSVDebug('Sort Elementzahl:' + inttostr(l));

  setlength(ia, l);
  setlength(ia2, l);
  setlength(da, l);
  setlength(sa, l);
  try
    for i := 0 to length(cwActions) - 1 do
    begin
      ia[i] := i;
      da[i] := cwActions[i].typeId;
      // cwActions[i].profit;  mit profit sortiert er schneller als mit vielen �hnlichen (Int) Werten !
      sa[i] := cwComments[cwActions[i].commentid].text;
      ia2[i] := cwActions[i].typeId;
    end;
  except
    lbCSVDebug('Fehler bei i:' + inttostr(i));

  end;
  lbCSVDebug('SortPrepare:' + inttostr(GetTickCount - gt));

  for i := 1 to 1 do
  begin
    gt := GetTickCount;
    fastsort2arrayString(sa, ia, 'VUAS');
    lbCSVDebug('SortString:' + inttostr(GetTickCount - gt));

    gt := GetTickCount;
    FastSort2ArrayDouble(da, ia, 'VUA');
    lbCSVDebug('SortDouble:' + inttostr(GetTickCount - gt));

    gt := GetTickCount;
    fastsort2arrayIntInt(ia2, ia, 'VUI'); // VDI
    lbCSVDebug('SortInteger:' + inttostr(GetTickCount - gt));

    gt := GetTickCount;
    fastsort2arrayString(sa, ia, 'VDAS');
    lbCSVDebug('SortString:' + inttostr(GetTickCount - gt));

    gt := GetTickCount;
    FastSort2ArrayDouble(da, ia, 'VDA');
    lbCSVDebug('SortDouble:' + inttostr(GetTickCount - gt));

    gt := GetTickCount;
    fastsort2arrayIntInt(ia2, ia, 'VDI'); // VDI
    lbCSVDebug('SortInteger:' + inttostr(GetTickCount - gt));
  end
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  i: integer;
begin
  SG.rowcount := 1;
  SG.Colcount := 1;
  SG.Cells[12, 12] := 'test';
end;

procedure TForm2.btnDoFilterClick(Sender: TObject);
var
  gt: cardinal;
  i, index: integer;
begin
  // immer zuerst Cache l�schen
  deletefiles(ExtractFilePath(paramstr(0)) + cCacheFolder, 'y*.bin');

  // manuelles Anklicken der Berechnung
  mynow := monthof(now) + 12 * yearof(now); // viel gebraucht und aus Speedgr�nden hier einmalig belegt
  FilterTopic := 'manual';
  doFilter(); // -> cwFilteredActions cwFilteredActionsCt
  // Wegen grouping: Herstellen der Sortierfelder f�r die schnelle Usersuche in der Teilmenge der User in den Filteractions
  doGroup();
  // -> dynGrid9

  if (chkFilterWithOpenActions.Checked = true) then
  // Evaluation der OpenActions durchf�hren
  begin
    screen.Cursor := crHourGlass;
    PSEvaluation.clear;
    makeEvaluation(PSEvaluation, 'cwfilteredactions');
    btnShowEvaluation.Visible := true;
    btnShowEvaluationClick(nil);
  end;
  screen.Cursor := crDefault;

end;

procedure TForm2.machUserSelectionAusFilteredActions();
// Aus der Gesamtzahl cwUsers werden nur die User aus einer gro�en CwFilteredActions Menge herausgesucht,
// so da� nicht mehr alle User in die Gruppierungsermittlung rein m�ssen und so der Speicherbedarf m�glichst klein bleibt
var
  i, ix, ct, p: integer;
  v: array of cwuser;
  u: array of integer;
  isort: intarray;
  gt: cardinal;
begin
  gt := GetTickCount;
  // erstmal u auf alle cwusersct dimensionieren
  setlength(u, cwusersct);
  try
    for i := 0 to cwFilteredActionCt - 1 do
    begin
      ix := finduserindex(cwFilteredActions[i].userId);
      u[ix] := u[ix] + 1;
    end;
  except
    p := p;
  end;
  // Z�hler nullen
  ct := 0;
  // Arrays vordimensionieren auf alle Users
  setlength(cwusersselection, cwusersct);
  setlength(cwusersselectionPlus, cwusersct);
  for i := 0 to cwusersct - 1 do
    if (u[i] > 0) then
    begin
      ct := ct + 1;
      cwusersselection[ct - 1] := cwUsers[i];
      cwusersselectionPlus[ct - 1] := cwUsersPlus[i];
    end;
  // nun auf die richtigen Dimensionen verk�rzen
  cwusersselectionct := ct + 1;
  setlength(cwusersselection, cwusersselectionct);
  setlength(cwusersselectionPlus, cwusersselectionct);

  // nun die Sortierung vorbereiten
  setlength(isort, cwusersselectionct);
  setlength(cwUsersSelectionSortindex, cwusersselectionct);
  // cwUsersSelectionSortIndex(111)='8212345=111'

  for i := 0 to cwusersselectionct - 1 do
  begin
    isort[i] := cwusersselection[i].userId;
    cwUsersSelectionSortindex[i] := inttostr(cwusersselection[i].userId) + '$' + inttostr(i);
  end;
  // userid=ix sortieren
  // isort wird sortiert
  fastsort2arrayIntegerString(isort, cwUsersSelectionSortindex, 'VUA');

  // zur Verwendung des schnelleren BinSearchString2 ...
  setlength(cwUsersSelectionSortindex2, cwusersselectionct);
  // cwUsersSelectionSortIndex2(111)=8212345
  for i := 0 to cwusersselectionct - 1 do
  begin
    p := pos('$', cwUsersSelectionSortindex[i]) - 1;
    cwUsersSelectionSortindex2[i] := strtoint(leftstr(cwUsersSelectionSortindex[i], p));
  end;

  lbCSVDebug('Z:F.UserGroup:' + inttostr(GetTickCount - gt));
end;

procedure TForm2.btnDoUsersAndSymbolsPlusClick(Sender: TObject);
var
  i, index, j, total, dt: integer;
  sum: double;
  gt: cardinal;
  diff1, diff2: integer;
begin
  // zus�tzliche Berechnungen durchf�hren
  // das passiert gleich im Anschluss an das Laden der Actions
  // Ausgangsdaten sind ALLE cwactions
  gt := GetTickCount;
  sum := 0;
  total := 0;
  for i := 0 to cwusersct - 1 do
  begin
    // jeder User hat eine Kontow�hrung . Innerhalb des Users kommt nur eine W�hrung in diesen 4 Summen vor
    cwUsersPlus[i].totaltrades := 0;
    cwUsersPlus[i].totalprofit := 0;
    cwUsersPlus[i].totalsymbols := 0;
    cwUsersPlus[i].totalbalance := 0;
    cwUsersPlus[i].totalSwap := 0; // 18.12.19 das hatte ich vergessen ;-)
  end;

  for i := 0 to length(cwActions) - 1 do
  begin
    inc(cwSymbolsPlus[cwActions[i].symbolId].TradesCount);
    cwSymbolsPlus[cwActions[i].symbolId].TradesVolumeTotal := cwSymbolsPlus[cwActions[i].symbolId].TradesVolumeTotal + cwActions[i].volume;
    // Die profits und swaps sind GEMISCHT in der W�hrung ! Hier werden �ber alle Symbole Summen gebildet
    cwSymbolsPlus[cwActions[i].symbolId].TradesProfitTotal := cwSymbolsPlus[cwActions[i].symbolId].TradesProfitTotal + cwActions[i].profit;
    cwSymbolsPlus[cwActions[i].symbolId].TradesSwapTotal := cwSymbolsPlus[cwActions[i].symbolId].TradesSwapTotal + cwActions[i].swap;
    cwSymbolsPlus[cwActions[i].symbolId].TradesProfitSwapTotal := cwSymbolsPlus[cwActions[i].symbolId].TradesProfitSwapTotal + cwActions[i].profit + cwActions[i].swap;
    // kann nat�rlich auch die Summe der Balances sein !

    // NEU: die schnelle Variante
    // index := finduserindex(cwActions[i].userId);
    // Die actions habe eigentlich nur eine Useraccountnummer. Hieraus errechne ich einmalig in cwActionsPlus einen Userindex der direkt in cwusers zeigt
    index := cwActionsPlus[i].userIndex;
    if index > -1 then
    begin
      // cwusersplus[index].totalSymbols:=0;
      dt := cwActions[i].openTime;
      if (dt > cwUsersPlus[index].lastOpenAction) then
        cwUsersPlus[index].lastOpenAction := dt;

      inc(cwUsersPlus[index].totaltrades);
      if (cwActions[i].typeId = 7) or (cwActions[i].typeId = 8) then
      // balance und credit werden als Balance aufsummiert
      begin
        cwUsersPlus[index].totalbalance := cwUsersPlus[index].totalbalance + cwActions[i].profit;
      end
      else
      begin
        // der Rest z�hlt zum Profit. Das ist je User in einer Kontow�hrung und somit innerhalb des Users nicht gemischt
        cwUsersPlus[index].totalprofit := cwUsersPlus[index].totalprofit + cwActions[i].profit;
        // evtl auch noch swap aber nicht Balance
        cwUsersPlus[index].totalSwap := cwUsersPlus[index].totalSwap + cwActions[i].swap;
      end;

    end;
  end;
  // showmessage(inttostr(GetTickCount - gt));
  for i := 0 to cwusersct - 1 do
  begin
    // jeder User hat eine Kontow�hrung . Innerhalb des Users kommt nur eine W�hrung in diesen 4 Summen vor
    diff1 := trunc(UnixToDateTime(cwUsersPlus[i].lastOpenAction));
    diff2 := trunc(UnixToDateTime(cwUsers[i].lastLoginTime));
    if (diff2 > diff1) then
      diff1 := diff2;
    cwUsersPlus[i].silentDays := trunc(now) - diff1;

  end;
end;

procedure TForm2.doGroup();
var
  g, i, j, k, l, ui, X: integer;
  gt, gt1, gt2: cardinal;
  s: string;
  ct, cnt: integer;
  ctmax: integer;
  le: array [0 .. 2] of integer;
  // cw3Summaries: DA3CwSummary;
  // cw3SummariesCt: integer;
  max1, max2, max3, max: integer;
  fall: array [0 .. 10] of integer; // wie oft kommt welche Gruppe vor
  p: array [0 .. 2] of integer;
  par: array [0 .. 2] of string;
  TradesCount: integer;
  TradesVolumeTotal: double;
  TradesProfitTotal: double;
  TradesSwapTotal: double;
  TradesProfitSwapTotal: double;
  gct: integer;
  aba: array of Bytearray;
  sumCt: integer;
  selUsersCt, found, found2: integer;
  merk: string;
  sortIndex: Stringarray; // string
  sortIndexOhne: Stringarray; // string

  isort: intarray;
  ps: integer;
begin
  if (cwFilteredActionCt = 0) then
    exit;

  gt1 := GetTickCount;
  gt := GetTickCount;
  gct := 0;
  for i := 1 to GroupingCt do
  begin
    if (Grouping[i].chkActive.Checked = true) then
    begin
      cwgrouping.element[i - 1].styp := Grouping[i].cbTopic.text;
      cwgrouping.element[i - 1].typ := groupingTyp(Grouping[i].cbTopic.text);
      if (Grouping[i].cbTopic.text <> 'unused') then
        inc(gct);
    end
    else
    begin
      cwgrouping.element[i - 1].styp := 'unused';
      cwgrouping.element[i - 1].typ := 0;
    end;

  end;
  if (gct = 0) then
  // wenn gar nix gruppiert werden soll auch kein Grid anzeigen
  begin
    DynGrid9.initGrid('cwsummaries', cwgrouping.element[0].styp, 0, 0, 0);
    exit;
  end;
  for i := 0 to 2 do
  begin
    // unused
    // SymbolGroup
    // User
    // YearsOpen
    // YearsClose
    // DateSpecial

    if (cwgrouping.element[i].styp = 'unused') then // unused
    begin
      le[i] := 1;
      inc(fall[0]);
    end;
    if (cwgrouping.element[i].styp) = 'symbolGroup' then
    begin
      le[i] := cwSymbolsGroupsCt;
      inc(fall[1]);
    end;
    if (cwgrouping.element[i].styp) = 'user' then
    begin
      le[i] := length(cwUsers);
      inc(fall[2]);
    end;
    if (cwgrouping.element[i].styp) = 'userId' then
    begin
      le[i] := length(cwusersselection);
      inc(fall[3]);
    end;

    if (cwgrouping.element[i].styp) = 'yearsOpen' then
    begin
      le[i] := 12;
      inc(fall[4]);
    end;
    if (cwgrouping.element[i].styp) = 'yearsClose' then
    begin
      le[i] := 12;
      inc(fall[5]);
    end;
    if (cwgrouping.element[i].styp) = 'dateSpecial' then
    begin
      le[i] := 10;
      inc(fall[6]);
    end;
    if (cwgrouping.element[i].styp) = 'brokerAccount' then
    begin
      le[i] := 8;
      inc(fall[7]);
    end;

    if (cwgrouping.element[i].styp) = 'months' then
    begin
      le[i] := 12;
      inc(fall[8]);
    end;

    if (cwgrouping.element[i].styp) = 'broker' then
    begin
      le[i] := 2;
      inc(fall[9]);
    end;

  end;

  // le[] sind immer die Anzahl der m�glichen Varianten des betreffenden Groupkriteriums
  // Hier sollte die Gesamtanzahl einfach m�glichst klein sein. Knackpunkt des Speichermangels
  max := le[0] * le[1] * le[2];
  try
    setlength(cw3summaries, le[0], le[1], le[2]);
  except
    showmessage('zu viele Elemente !');
    exit;
  end;
  max1 := length(cw3summaries);
  max2 := length(cw3summaries[0]);
  max3 := length(cw3summaries[0][0]);
  // alles nullsetzen
  for i := 0 to max1 - 1 do
    for j := 0 to max2 - 1 do
      for k := 0 to max3 - 1 do
      begin
        cw3summaries[i][j][k].par0 := '';
        cw3summaries[i][j][k].par1 := '';
        cw3summaries[i][j][k].par2 := '';
        cw3summaries[i][j][k].sTradesCount := 0;
        cw3summaries[i][j][k].sTradesVolumeTotal := 0;
        cw3summaries[i][j][k].sTradesProfitTotal := 0;
        cw3summaries[i][j][k].sTradesSwapTotal := 0;
        cw3summaries[i][j][k].sTradesProfitSwapTotal := 0;
        cw3summaries[i][j][k].sTradesUsers := 0; // noch nicht verwendet
      end;
  try
    // alle gefilterten Actions durchlaufen
    for i := 0 to cwFilteredActionCt - 1 do
    begin
      // es gibt max. drei Gruppierungselemente  .
      // F�r jede Action wird anhand des Typs der Elemente immer ein Paar aus Integerwert/String ermittelt, welches zB die AccountId einer Action mit Id und Text sein kann
      //
      for j := 0 to 2 do
      begin
        case cwgrouping.element[j].typ of
          0: // unused
            begin
              p[j] := 0;
              par[j] := '.';
            end;
          1: // SymbolGroup
            begin
              p[j] := cwSymbolsPlus[cwFilteredActions[i].symbolId].groupId;
              s := inttostr(cwSymbolsPlus[cwFilteredActions[i].symbolId].groupId); // oder der Name !
              par[j] := cwSymbolsGroups[cwSymbolsPlus[cwFilteredActions[i].symbolId].groupId].name; // + '/' + s;
              // oder der Name !
            end;
          2: // User nicht verwendet
            begin
              p[j] := finduserindex(cwFilteredActions[i].userId);
              par[j] := inttostr(cwFilteredActions[i].userId);
              // oder Username
            end;
          3: // UserId =UserSelection
            begin
              p[j] := finduserSelectionIndex(cwFilteredActions[i].userId);
              par[j] := inttostr(cwFilteredActions[i].userId); // oder Username
            end;
          4: // YearsOpen
            begin
              p[j] := trimYear(yearof(UnixToDateTime(cwFilteredActions[i].openTime)));
              par[j] := inttostr(yearof(UnixToDateTime(cwFilteredActions[i].openTime)));
            end;
          5: // YearsClose
            begin
              p[j] := trimYear(yearof(UnixToDateTime(cwFilteredActions[i].closeTime)));
              par[j] := inttostr(yearof(UnixToDateTime(cwFilteredActions[i].closeTime)));
            end;
          6: // dateSpecial
            begin
              // FEHLT NOCH
              p[j] := trimYear(yearof(UnixToDateTime(cwFilteredActions[i].closeTime)));
              par[j] := inttostr(yearof(UnixToDateTime(cwFilteredActions[i].closeTime)));
            end;
          7: // brokerAccount
            begin
              p[j] := cwFilteredActions[i].accountId;
              par[j] := inttostr(cwFilteredActions[i].accountId);
              // BESSER machen mit Namen
            end;
          8: // months
            begin
              // FEHLT NOCH
              p[j] := trimMonthYear(monthof(UnixToDateTime(cwFilteredActions[i].closeTime)), yearof(UnixToDateTime(cwFilteredActions[i].closeTime)), par[j]);
              // par[j] := inttostr(monthof(unixtodatetime(cwFilteredActions[i].closeTime))+'/'+yearof(unixtodatetime(cwFilteredActions[i].closeTime)));
            end;
          9: // broker
            begin
              if (cwFilteredActions[i].accountId < 3) then
              begin
                p[j] := 0;
                par[j] := 'LCG';
              end
              else
              begin
                p[j] := 1;
                par[j] := 'AT';
              end;
            end;
        else
          // das w�re eine nicht vorgesehene Gruppierungsnummer - kann eigentlich nicht vorkommen
          begin
            p[j] := 0;
            par[j] := '?';
          end;
          ;
        end;
      end;

      // jetzt sind alle drei 'Koordinaten' im 3D-Array bekannt
      // wir sind immer noch bei einer einzelnen Action
      cw3summaries[p[0], p[1], p[2]].par0 := par[0];
      // das und die folgenden beiden wird immer wieder gleich belegt bzw �berschrieben. Es bleibt aber entweder leer oder ist eindeutig belegt
      cw3summaries[p[0], p[1], p[2]].par1 := par[1];
      cw3summaries[p[0], p[1], p[2]].par2 := par[2];
      // die drei Werte weisen jeder Action ein 'K�stchen' im 3D-Raum zu. Diese Koordinaten w�ren gut zu merken aber das kostet an dieser Stelle zu viel Platz
      // da es bei 4 Mio schon wieder 32MB sind. Daher erstmal fertigrechnen lassen und sp�ter nochmal dasselbe von vorn wenn bereits die cwSummaries 'eingedampft' sind
      // Hierbei werden dann sehr viel weniger Elemente ben�tigt da bei einer sinnvollen Gruppierung eine '�bersichtliche' Anzahl Gruppen �brigbleibt
      cw3summaries[p[0], p[1], p[2]].sTradesCount := cw3summaries[p[0], p[1], p[2]].sTradesCount + 1;
      // hier wird hochgez�hlt
      cw3summaries[p[0], p[1], p[2]].sTradesVolumeTotal := cw3summaries[p[0], p[1], p[2]].sTradesVolumeTotal +
      // und aufsummiert
        cwFilteredActions[i].volume;

      cw3summaries[p[0], p[1], p[2]].sTradesProfitTotal := cw3summaries[p[0], p[1], p[2]].sTradesProfitTotal + cwFilteredActions[i].profit;
      cw3summaries[p[0], p[1], p[2]].sTradesSwapTotal := cw3summaries[p[0], p[1], p[2]].sTradesSwapTotal + cwFilteredActions[i].swap;
      cw3summaries[p[0], p[1], p[2]].sTradesProfitSwapTotal := cw3summaries[p[0], p[1], p[2]].sTradesProfitSwapTotal + cwFilteredActions[i].profit + cwFilteredActions[i].swap;

      // cw3summaries[p[0], p[1], p[2]].sTradesUsers:=0;//das fehlt noch

      TradesCount := TradesCount + 1;
      TradesVolumeTotal := TradesVolumeTotal + cwFilteredActions[i].volume;
      TradesProfitTotal := TradesProfitTotal + cwFilteredActions[i].profit;
      TradesSwapTotal := TradesSwapTotal + cwFilteredActions[i].swap;
      TradesProfitSwapTotal := TradesProfitSwapTotal + cwFilteredActions[i].profit + cwFilteredActions[i].swap;
    end;
  except
    on E: Exception do
      s := E.ToString;

  end;


  // Ausd�nnen
  //
  // if (1 = 0) then
  // begin
  // // ausd�nnen der Symbole ohne Trades
  // // damit wird aber cwsymbolsplus().groupid FALSCH
  // j := -1;
  // for i := 0 to groupsCt - 1 do
  // begin
  // if groups[i].TradesCount <> 0 then
  // begin
  // inc(j);
  // groups[j] := groups[i];
  // end;
  // end;
  // groupsCt := j + 1;
  // SetLength(groups, groupsCt);
  // lbadd(lb,'Used Sym.groups:' + #9 + inttostr(groupsCt));
  // end;

  // aus den vielen vielen cw3summaries werden nun alle ausgelassen, die ohnehin leer sind (die allermeisten) und das Ergebnis landet
  // in einem nur noch 1-dimensionalen Array cwSummaries
  ctmax := 10000;
  setlength(cwsummaries, ctmax + 1);
  ct := -1;
  try
    for i := 0 to max1 - 1 do
      for j := 0 to max2 - 1 do
        for k := 0 to max3 - 1 do
        begin
          if cw3summaries[i][j][k].par0 <> '' then
          begin
            inc(ct);
            cwsummaries[ct] := cw3summaries[i][j][k];
            cwsummaries[ct].merk := inttostr(i) + '-' + inttostr(j) + '-' + inttostr(k);
            // das dient sp�ter der Ermittlung der STradesUsers
            // anhand dieses Strings (wie 12-2-23) kann der Index von cwSummaries gefunden werden �ber den dann die Users gez�hlt werden
            if (ct = ctmax) then
            begin
              ctmax := ctmax + 10000;
              setlength(cwsummaries, ctmax + 1);
            end;

          end;

        end;
    // hier ist der Moment wo der Speicherplatzbedarf am gr�ssten ist
    // mit User SymbolGroups und YearsOpen sind es um die 950 MB
  except
    on E: Exception do
      s := E.ToString;

  end;
  sumCt := ct;
  setlength(cwsummaries, sumCt + 1);
  // das gro�e Array wird nun endlich wieder gel�scht
  setlength(cw3summaries, 0, 0, 0);

  // nun k�me noch die Summe der User .sTradeUsers dazu
  // hierf�r wird dann der Rechenaufwand �bermenschlich. Es w�re kein Problem wenn man nun die Actions der ganzen cwSummaries noch einzen kennen w�rde
  // im Grund br�uchte man eine vierte Dimension zu jedem Element, n�mlich ein Bytearray mit allen Usern. Dann l�uft man alle Actions durch und setzt jeweils eine UserId hierin
  // Am Ende z�hlt man wie viele verschiedene User das dann jeweils sind
  // An dieser Stelle hat cwSummaries ja bereits eine deutlich kleinere Anzahl von Elementen (andernfalls ist die Auswertung sowieso Bl�dsinn).
  // von daher w�re es vielleicht doch machbar !

  // Sortierung vornehmen und damit schnelle Bin�rsuche vorbereiten
  setlength(isort, sumCt + 1);
  // findUserIndex und findUserName verwenden die cwUsersSortindex und cwUsersSortindex2
  setlength(sortIndex, sumCt + 1); // 1-2-3=123
  setlength(sortIndexOhne, sumCt + 1); // 1-2-3 ohne den Rest
  for i := 0 to sumCt do
  begin
    isort[i] := i;
    sortIndex[i] := cwsummaries[i].merk + '$' + inttostr(i);
    // sortIndexOhne[i] := cwsummaries[i].merk;
  end;
  fastsort2arrayStringInteger(isort, sortIndex, 'UA');
  //
  gt2 := GetTickCount;
  for i := 0 to sumCt do
  begin
    ps := pos('$', sortIndex[i]);
    sortIndexOhne[i] := leftstr(sortIndex[i], ps - 1);
    try
      isort[i] := strtoint(sortIndex[i].substring(ps));
    except
      ps := ps;
    end;
  end;
  lbdebug('$ Suche' + inttostr(GetTickCount - gt2));

  if (sumCt < 100000) then
  begin
    // nur wenn die Gruppenanzahl "klein" genug ist werden die User summiert
    gt := GetTickCount;
    setlength(aba, sumCt + 1);
    selUsersCt := length(cwusersselection); // eigentlich reicht hier auch die bereits reduzierte Useranzahl
    for i := 0 to sumCt do
    begin
      setlength(aba[i], selUsersCt);
    end;

    // for i := 0 to sumCt do // ganze Matrix nullsetzen  - notwendig ?
    // for j := 0 to selUsersCt - 1 do
    // aba[i][j] := 0;

    // nun k�nnen die Bytearrays belegt werden
    // Es werden nun alle Actions durchlaufen
    // in j wird der Userindex eingetragen bzw erh�ht
    // in i der Index der Group
    for i := 0 to cwFilteredActionCt - 1 do
    begin
      ui := finduserSelectionIndex(cwFilteredActions[i].userId);
      // nun muss wieder j=0..2 die Suche der Kriterien durchlaufen werden wie oben
      // man k�nnte das oben bereits abspeichern zu jeder Action aber das w�rde nochmal mehr Speicher ben�tigen
      for j := 0 to 2 do
      begin
        case cwgrouping.element[j].typ of
          0: // unused
            begin
              p[j] := 0;
            end;
          1: // SymbolGroup
            begin
              p[j] := cwSymbolsPlus[cwFilteredActions[i].symbolId].groupId;
            end;
          2: // User nicht verwendet
            begin
              p[j] := finduserindex(cwFilteredActions[i].userId);
            end;
          3: // UserId =UserSelection
            begin
              p[j] := ui; // siehe oben gerade erst gesucht
              // p[j] := finduserSelectionIndex(cwFilteredActions[i].userId);
            end;
          4: // YearsOpen
            begin
              p[j] := trimYear(yearof(UnixToDateTime(cwFilteredActions[i].openTime)));
            end;
          5: // YearsClose
            begin
              p[j] := trimYear(yearof(UnixToDateTime(cwFilteredActions[i].closeTime)));
            end;
          6: // dateSpecial
            begin
              // FEHLT NOCH
              p[j] := trimYear(yearof(UnixToDateTime(cwFilteredActions[i].closeTime)));
            end;
          7: // brokerAccount
            begin
              p[j] := cwFilteredActions[i].accountId;
            end;
          8: // months
            begin
              // FEHLT NOCH
              p[j] := trimMonthYear(monthof(UnixToDateTime(cwFilteredActions[i].closeTime)), yearof(UnixToDateTime(cwFilteredActions[i].closeTime)), par[j]);
            end;
          9: // broker
            begin
              if (cwFilteredActions[i].accountId < 3) then
              begin
                p[j] := 0;
              end
              else
              begin
                p[j] := 1;
              end;
            end;
        else
          // das w�re eine nicht vorgesehene Gruppierungsnummer - kann eigentlich nicht vorkommen
          begin
            p[j] := 0;
          end;
          ;
        end;
      end;
      merk := inttostr(p[0]) + '-' + inttostr(p[1]) + '-' + inttostr(p[2]);

      // nun ermitteln welchem cwsummaries[x].merk das merk entspricht
      // das geht am schnellsten �ber eine indizierte Suche
      /// /
      // found:=-1;
      // for k:=0 to sumct do
      // begin
      /// /        found:=1;
      /// /        break;
      // if(cwsummaries[k].merk=merk) then
      // begin
      // found:=k;
      // break;
      // end;
      // end;

      found := binSearchString(sortIndexOhne, merk);
      if (found = -1) then
      begin
        // zur Fehlersuche
        found := binSearchString(sortIndexOhne, merk);
      end;
      if (found > -1) then
      begin
        // dann wird in aba[x][ui] der Wert auf 1 gesetzt = belegt

        // ps := pos('$', sortIndex[found]);
        // found2 := strtoint(sortIndex[found].Substring(ps));
        // if(isort[found]<>found2) then  //zum �berpr�fen#
        // found:=found;
        // schneller...
        found2 := isort[found];
        aba[found2][ui] := 1; // gen�gt - man k�nnte aber auch hochz�hlen wenn die Anzahl interessieren w�rde
      end;
    end;
    // nun sind alle Actions durchlaufen

    // nun die aba[x][i] durchlaufen und wenn <>0 +1 so da� am Ende die gesuchte Anzahl steht
    for i := 0 to sumCt do
    begin
      cnt := 0;
      for k := 0 to selUsersCt - 1 do
      begin
        if (aba[i][k] > 0) then
          inc(cnt);
      end;
      cwsummaries[i].sTradesUsers := cnt;
    end;

    gt := GetTickCount - gt;
    lbdebug('UsersCount:' + inttostr(gt));
  end;

  // DynGrid9.initGrid('cw3summaries', 'par0', 1, max, 10);
  DynGrid9.initGrid('cwsummaries', cwgrouping.element[0].styp, 1, ct + 1, 9);
  DynGrid9.lblHeader.Caption := 'Grouped Elements:' + inttostr(ct + 1) + ' from:' + inttostr(cwFilteredActionCt) + ' z:' + inttostr(GetTickCount - gt1);

end;

function TForm2.trimYear(year: integer): integer;
begin
  // 2012 bis 2023 sind die 12 Jahre auf die getrimmt wird -> 0 bis 11
  if year < 2012 then
    year := 2012; // 2012-12;
  if year > 2023 then
    year := 2023; // 2023-12;
  result := year - 2012;

end;

function TForm2.trimMonthYear(Month, year: integer; var s: string): integer;
var
  // mynow:integer; //einsparen wegen Rechenzeit !
  my: integer;
  diff: integer;
begin
  if (mynow = 0) then
    mynow := yearof(now) * 12 + monthof(now); // zB 24236
  my := year * 12 + Month;
  diff := mynow - my;
  if (diff = 0) then
    s := '0 this month';
  if (diff > 0) then
    s := inttostr(diff) + ' months before';
  if (diff < 0) then
  begin
    diff := 0;
    s := 'in the future';
  end;
  if (diff > 11) then
  begin
    diff := 11;
    s := 'before 1 year';
  end;
  result := diff;
end;


// wie kann man das mit den Monaten machen
//

procedure TForm2.updateTimerTimer(Sender: TObject);
begin
  // Update timer
  updateTimer.Interval := cUpdateTimerInterval;
  updateTimerStarted := now;
  if (updateStatus > 0) then
    // updateStatus 0=nix zu tun 1=schnell ohne Actions Update 2=mit Actions
    if (updateGoing = true) then
    begin
      updateGoing := false;
      updateStatus := 0;
    end;

  if (updateGoing = false) then
  begin
    Dialog2.fdialog2.btnFinishUpdate.Visible := false;
    askFinishUpdate := false;
    btnUpdateDataClick(nil);
  end;
end;

function TForm2.groupingTyp(styp: string): integer;
begin
  result := 0;
  if (styp = 'unused') then
    result := 0;
  if styp = ('symbolGroup') then
    result := 1;
  if styp = ('user') then
    result := 2;
  if styp = ('userId') then
    result := 3;
  if styp = ('yearsOpen') then
    result := 4;
  if styp = ('yearsClose') then
    result := 5;
  if styp = ('dateSpecial') then
    result := 6;
  if styp = ('brokerAccount') then
    result := 7;
  if styp = ('months') then
    result := 8;
  if styp = ('broker') then
    result := 9;

end;

procedure TForm2.doFilter();
var
  i, index, j: integer;
  r: boolean;
  fz: integer;
  max, fzmax: integer;
  gt: cardinal;
  chk: array of boolean;
  faktivCt: integer;
  time1, time2, time3: integer;
label weiter, weiter1;
begin

  screen.Cursor := crHourGlass;

  faktivCt := 0;
  for i := 1 to FilterCt do
  begin
    if Filter[i].chkActive.Checked = true then
      inc(faktivCt);
  end;
  if faktivCt = 0 then
  // gar kein Filter aktiv -> alles wird durchgelassen
  begin
    setlength(cwFilteredActions, length(cwActions));
    setlength(cwFilteredActionsPlus, length(cwActions));
    for i := 0 to length(cwActions) - 1 do
      cwFilteredActions[i] := cwActions[i];
    cwFilteredActionCt := length(cwActions);

    goto weiter1;
  end;

  setlength(cwfilterParameter, FilterCt + 1);
  setlength(chk, FilterCt + 1);
  // sowieso hier bl�d
  time1 := 0;
  time2 := 0;
  for i := 1 to FilterCt do
  begin
    Filter[i].getValues(cwfilterParameter[i]);

    // machVergleichArrays
    // am Ende werden je nach cTopic und edValue.text verschiedene Variablen von Filter[] gef�llt
    // mal vglI[] und vglICt oder  vglS[] mit vglSCt, vDouble oder vInteger

    Filter[i].machVergleichArrays;
    chk[i] := Filter[i].chkActive.Checked;
    Filter[i].counter := 0;
    if Filter[i].topic = 'OpenDateTime' then
    begin
      time1 := Filter[i].vInteger;
    end;
    if Filter[i].topic = 'CloseDateTime' then
    begin
      time2 := Filter[i].vInteger;
    end;

  end;
  // Reihenfolge in Ordnung bringen
  if (time1 > time2) then
  begin
    time3 := time2;
    time2 := time1;
    time1 := time3;
  end;
  gt := timegettime;
  fz := -1;
  fzmax := 0;

  r := false;

  // unsinnige leere Eingaben abfangen
  for i := 1 to FilterCt do
  begin
    if Filter[i].topic <> 'Action in TimeRange' then
      if (chk[i] = true) and (Filter[i].edValue.text = '') then
        chk[i] := false;

    if Filter[i].topic = 'Action in TimeRange' then
    begin
      Filter[i].vInteger := time1;
      Filter[i].vInteger2 := time2;

    end;

  end;

  // nun werden alle Actions durchlaufen
  for i := 0 to length(cwActions) - 1 do
  begin
    for j := 1 to FilterCt do
    begin
      if chk[j] = true then
      begin
        r := Filter[j].checkCwaction(cwActions[i], cwActionsPlus[i]);
        if (r = false) then
          // die erste nicht erf�llte Bedingung l�sst diese Action herausfallen
          // sie wird ausgefiltert und ist damit weg
          goto weiter
      end;
    end;
    if r = true then
    begin
      fz := fz + 1;
      if (fz > fzmax - 1) then
      begin
        fzmax := fzmax + 1000;
        setlength(cwFilteredActions, fzmax);
        setlength(cwFilteredActionsPlus, fzmax);
      end;
      cwFilteredActions[fz] := cwActions[i];

    end;
    // dem Ergebnis hinzuf�gen
  weiter:

  end;

  lblFilterResult.Caption := (inttostr(timegettime - gt) + ' ct1:' + inttostr(Filter[1].counter) + ' ct2:' + inttostr(Filter[2].counter) + ' ct3:' + inttostr(Filter[3].counter));

  cwFilteredActionCt := fz + 1;
  setlength(cwFilteredActions, fz + 1);
  setlength(cwFilteredActionsPlus, fz + 1);

weiter1:
  max := maxActionsPerGrid;
  if cwFilteredActionCt < max then
    max := cwFilteredActionCt;
  SGCacheCwSearch.Visible := true;

  // nun die Userindexe finden wegen schnellerer Weiterberechnung
  gt := GetTickCount;
  for i := 0 to length(cwFilteredActions) - 1 do
  begin
    index := finduserindex(cwFilteredActions[i].userId);
    cwFilteredActionsPlus[i].userIndex := index;
  end;

  doCacheGridCwInfo;
  screen.Cursor := Cursor;

  gt := GetTickCount;
  DynGrid2.lblHeader.Caption := #34 + FilterTopic + #34 + ' ' + 'Filtered actions:' + inttostr(cwFilteredActionCt) + ' of ' + inttostr(length(cwActions));
  DynGrid2.initGrid('cwfilteredactions', 'userId', 1, length(cwFilteredActions), 30);
  lbdebug('dg2:' + inttostr(GetTickCount - gt));

  machUserSelectionAusFilteredActions;

  screen.Cursor := crDefault;
end;

procedure TForm2.makeEvaluation(var ps: EvaluationResult; source: string);
var
  z1, z2: TDateTime;
  u1, u2: integer;
  i, j, v: integer;
  flag: boolean;
  accVon, accBis: integer;
  acc: integer;
  ok1, ok2: boolean;
begin
  // Filtern mit OpenActions
  ok1 := false;
  ok2 := false;
  //
  // die beiden Zeiten f�r Start und Ende des Betrachtungszeitraums werden aus den ersten beiden Filtern entnommen
  // aber nur wenn diese auch die richtigen Filter beinhalten. Open und Close
  // Dann m�ssen die OpenProfit-Dateien auch f�r diese beiden Zeitr�ume vorhanden sein
  // Was ist wenn nicht - man k�nnte eventuell einen etwas �lteren Open und einen etwas j�ngeren Close Zeitpunkt vorschlagen
  // Dann werden die OpenProfit Dateien eingelesen. Um den Zugriff �ber die ActionID schnell zu cachen w�re es vorteilhaft, wenn
  // diese Actions sortiert w�ren. Entweder man sortiert gar nicht, sortiert 'on Demand' oder sortiert einmalig und speichert dies
  // Eigentlich gen�gt das on demand Sortieren vor der Verwendung , da sich diese OpenProfit-Tage nicht allzuoft wiederholen d�rften

  // dSort sind die Werte der ActionIds
  // fastsort2arrayInt64Int(ids,sorted, 'VUI'); // VDI
  if (source = 'cwfilteredactions') then
  begin

    u1 := 0;
    u2 := 0;
    accVon := 1;
    accBis := 7;
    for i := 1 to FilterCt do
    begin
      if Filter[i].chkActive.Checked = true then
      begin
        // immer nur nach dem ersten CloseDateTime bzw OpenDateTime suchen (falls noch mehr manuell spezifiziert wurde...)
        if (ok1 = false) then
          if (Filter[i].cbTopic.text = 'CloseDateTime') then
          begin
            // closed >=16.9 oder 0=noch offen
            ok1 := true;
            u1 := getUnixTimefromstring(Filter[i].edValue.text); // Unix Zeit um 0 Uhr des Tages
            z1 := UnixToDateTime(u1) - 1; // Datums des Vortags = die Datei welche am n�hesten kurz vor u1 liegt
            // wenn die Datei aber zB am 5.12 23:00 geschrieben wurde und u1=6.12. 00:00 dann gibt es f�r Orders zwischen 23 und 0 Uhr Fehler
            // >= 16.9 = OpenProfit von Ende 15.9 daher -1 was die letzten Daten vom 15.9. beinhaltet
          end;

        if (ok2 = false) then
          if (Filter[i].cbTopic.text = 'OpenDateTime') then
          begin
            // open <
            ok2 := true;
            // u2 := strtoint(Filter[i].edValue.text);
            u2 := getUnixTimefromstring(Filter[i].edValue.text);
            z2 := UnixToDateTime(u2) - 1;
            // < 23.9 = OpenProfit von Ende 22.9 daher wieder -1 um an die Daten zu kommen
          end;

        // das folgende gilt aber nur wenn lediglich EINER der Accounts im Topictext steht. Sonst werden sie ALLE abgerufen
        if (Filter[i].cbTopic.text = 'AccountId') then
        begin
          // open >
          acc := IndexStr(Filter[i].edValue.text, ['LCG A', 'LCG B', 'ActiveTrades A', 'ActiveTrades B', 'ActiveTrades C', 'ActiveTrades D', 'ActiveTrades E']);
          if (acc > -1) then
          begin
            accVon := acc + 1;
            accBis := acc + 1;
          end
          else
          begin
            accVon := 1;
            accBis := 7;

          end;

        end;

        // das folgende gilt aber nur wenn lediglich EINER der Accounts im Topictext steht. Sonst werden sie ALLE abgerufen
        if (Filter[i].cbTopic.text = 'BrokerId') then
        begin
          // open >
          acc := IndexStr(Filter[i].edValue.text, ['LCG', 'ActiveTrades']);
          if (acc > -1) then
          begin
            if (acc = 0) then
            begin
              accVon := 1;
              accBis := 2;
            end;
            if (acc = 1) then
            begin
              accVon := 3;
              accBis := 7;
            end;
          end
          else
          begin
            accVon := 1;
            accBis := 7;

          end;

        end;

      end;
    end;
    // damit sind die beiden erforderlichen OpenActions-Dateien festgestellt die nun eingelesen werden m�ssen
    // wie soll mit fehlenden Daten umgegangen werden ? Durch die vielen Ausf�lle fehlen oft die letzten Sonntagsdaten
    // diese sind aber mow identisch mit den letzten Samstags- und letzten Freitagsdaten. Es w�ren also nacheinander
    // alle Daten verwendbar ob So,Sa,Fr. Man k�nnte drei Versuche starten, diese Daten abzurufen ... was nun auch passiert!
    ps.z1 := z1;
    ps.z2 := z2;
    ps.ct1 := 0;
    ps.ct1nix := 0;
    ps.ct2 := 0;
    ps.ct2nix := 0;

    getAndSortOpenActions(z1, cwOpenActionsZ1, accVon, accBis);
    getAndSortOpenActions(z2, cwOpenActionsZ2, accVon, accBis);
    // nun aus cwFilteredActions, cwOpenActionsZ1 und cwOpenActionsZ2 die ps Werte hochz�hlen bzw f�llen !
    for i := 0 to length(cwFilteredActions) - 1 do
    // die F�lle A=alles vor Z1 bereits closed  und F alles opened nach Z2 sind bereits entsprechend der Filter entfernt worden
    //
    begin
      flag := false;
      if (cwFilteredActions[i].openTime < u1) then
      begin
        // Actions die zum Zeitpunkt u1 bereits offen waren
        // B und C bekommen profit1 aus cwOpenActionsZ1
        j := BinSearchOpenActionsInt64(cwOpenActionsZ1, cwFilteredActions[i].actionId);
        // Suche Order die vorher offen war nun in OpenZ1 wo diese stehen sollte
        if (j > -1) then
        begin
          ps.profit1[cwUsersPlus[cwFilteredActionsPlus[i].userIndex].accountCurrency] := ps.profit1[cwUsersPlus[cwFilteredActionsPlus[i].userIndex].accountCurrency] + cwOpenActionsZ1[j].profit;
          ps.swap1 := ps.swap1 + cwOpenActionsZ1[j].swap;
          ps.volume1 := ps.volume1 + cwFilteredActions[i].volume;
          inc(ps.ct1);
          flag := true;
        end
        else
        begin
          inc(ps.ct1nix);
          lbdebug('nF1 (open in z1):' + inttostr(cwFilteredActions[i].actionId));
        end;
      end
      else
      begin
        // D und E haben kein profit1
      end;

      if ((cwFilteredActions[i].closeTime <= u2) and (cwFilteredActions[i].closeTime <> 0)) then
      begin
        // im Zeitabaschnitt geschlossen
        // B und D bekommen profit aus cwFilteredActions
        ps.profit[cwUsersPlus[cwFilteredActionsPlus[i].userIndex].accountCurrency] := ps.profit[cwUsersPlus[cwFilteredActionsPlus[i].userIndex].accountCurrency] + cwFilteredActions[i].profit;
        ps.swap := ps.swap + cwFilteredActions[i].swap;
        ps.volume := ps.volume + cwFilteredActions[i].volume;
        inc(ps.ct);
        flag := true;
      end
      else
      begin
        // C und E bekommen profit2 aus cwOpenActionsZ2
        // im Zeitraum nicht geschlossen
        j := BinSearchOpenActionsInt64(cwOpenActionsZ2, cwFilteredActions[i].actionId);
        if (j > -1) then
        begin
          ps.profit2[cwUsersPlus[cwFilteredActionsPlus[i].userIndex].accountCurrency] := ps.profit2[cwUsersPlus[cwFilteredActionsPlus[i].userIndex].accountCurrency] + cwOpenActionsZ2[j].profit;
          ps.swap2 := ps.swap2 + cwOpenActionsZ2[j].swap;
          ps.volume2 := ps.volume2 + cwFilteredActions[i].volume;
          inc(ps.ct2);
          flag := true;

        end
        else
        begin
          //
          inc(ps.ct2nix);
          lbdebug('nF2 (open in z2):' + inttostr(cwFilteredActions[i].actionId));
        end;;
      end;
      if (flag = false) then
      begin
        // diese Action f�llt durchs Raster ???
        flag := false;
      end;
    end;

  end;
  if (source = 'cwsummaries') then
  begin

  end;
end;

// procedure TForm2.Button5Click(Sender: TObject);
/// / Balance direkt filtern (zum Geschwindigkeitsvergleich die der Filtersuche)
// var
// i: integer;
// gt, tg: cardinal;
// fz, max, fzmax: integer;
//
// function vergleichInteger(was, mit: integer; op: integer): boolean;
// // var oben bringt nix
// begin
// result := false;
// if op = 1 then // '=' then
// begin
// if was = mit then
// result := true;
// exit;
// end;
// if op = 2 then // '>' then
// begin
// if was > mit then
// result := true;
// exit;
// end;
// if op = 3 then // '<' then
// begin
// if was < mit then
// result := true;
// exit;
// end;
// if op = 4 then // '>=' then
// begin
// if was >= mit then
// result := true;
// exit;
// end;
// if op = 5 then // '<=' then
// begin
// if was <= mit then
// result := true;
// exit;
// end;
// if op = 6 then // '<>' then
// begin
// if was <> mit then
// result := true;
// exit;
// end;
//
// end;
//
// begin
// gt := timegettime;
// tg := timegettime;
// fz := -1;
// fzmax := -1;
// for i := 0 to length(cwActions) - 1 do
// begin
//
// if (cwActions[i].accountId = 4) then
// if (cwActions[i].typeId = 7) then
// begin
//
// // if vergleichInteger(cwActions[i].typeId, 7, 1) = true then
// // begin
// // hinzuf�gen
// begin
// fz := fz + 1;
// if (fz > fzmax) then
// begin
// fzmax := fzmax + 50000;
// setlength(cwFilteredActions, fzmax);
// setlength(cwFilteredActionsPlus, fzmax);
// end;
// cwFilteredActions[fz] := cwActions[i];
// end;
//
// // end;
// end;
// end;
//
// showmessage('z:' + inttostr(timegettime - gt) + ' ' + inttostr(timegettime - tg));
// cwFilteredActionCt := fz + 1;
// setlength(cwFilteredActions, fz + 1); // vergessen
// setlength(cwFilteredActionsPlus, fz + 1); // vergessen
//
// max := maxActionsPerGrid;
// if cwFilteredActionCt < max then
// max := cwFilteredActionCt;
//
// // if cwFilteredActionCt > 50 then
// // begin
// // doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwFilteredActions, 50, 50);
// // SGCacheCwSearch.Repaint;
// // doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwFilteredActions, max, max);
// // autosizegrid(SGCacheCwSearch, nil);
// // end
// // else
// // begin
// // doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwFilteredActions, cwFilteredActionCt, cwFilteredActionCt);
// // autosizegrid(SGCacheCwSearch, nil);
// // end;
// doCacheGridCwInfo;
// Screen.Cursor := Cursor;
// DynGrid2.lblHeader.Caption := 'Filtered actions:' + inttostr(cwFilteredActionCt) + ' of ' +
// inttostr(length(cwActions));
// if max < cwFilteredActionCt then
// begin
// DynGrid2.lblHeader.Caption := DynGrid2.lblHeader.Caption + ' Grid:' + inttostr(max);
// end;
//
// end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  TabSheet4.TabVisible := true;
end;

procedure TForm2.Button7Click(Sender: TObject);
begin
  loadCacheFileCw('openTrades\' + edStoredActions.text + '.otr', 'opentrades', lbCSVError);
end;

procedure TForm2.Button8Click(Sender: TObject);
var
  merk: boolean;
begin
  // Reload data
  // Clear cache and load all data
  Button8.enabled := false;
  merk := cbLoadActionsFromCache.Checked;
  cbLoadActionsFromCache.Checked := false;

  doLoadAllData();
  cbLoadActionsFromCache.Checked := merk;
  Button8.enabled := true;
  // wieder die Startseite anzeigen
  setPageIndex(1); // 0;

end;

procedure TForm2.btnUpdateDataClick(Sender: TObject);
begin
  doUpdate();
end;

procedure TForm2.GetLastServerUnixTime();
var
  a: integer;
begin
  a := GetBinData('http://h2827643.stratoserver.net:' + cServerPort + '/time', 'lastServerUnixTime', lbCSVError, false, 0);
  // schreibt den Wert direkt in die Variable lastServerUnixTime
end;

procedure TForm2.doUpdate(dt: TDateTime = 0);
var
  i, lold, lnew: integer;
  merkOpenTime, merkCloseTime: integer;
  gt, gtall, gts, tnow: cardinal;
  p, cnew, cold: integer;
  ia: intarray;
  ia2: int64Array;
  na: intarray;
  na2: int64Array;
  n: integer;
  a1, a2: integer;
  tt: cardinal;
  dtt: TDateTime;
  // label rest;
begin
  // update data
  inc(doUpdateCt); // damit es beim ersten mal unterschieden werden kann
  updateGoing := true;
  Dialog2.fdialog2.show; // Modal;
  Dialog2.fdialog2.Top := Form2.Top + Form2.Height - fdialog2.Height;
  Dialog2.fdialog2.Left := Form2.Left + Form2.Width - fdialog2.Width;
  Dialog2.fdialog2.info('Getting update data ...');
  gtall := GetTickCount;
  gt := GetTickCount;

  if (dt = 0) then // 0=keine Zeitvorgabe aus Dialogfenster
  begin
    // Alte Variante
    // dtt := checkLastUpdate(); // -> info.lastUpdateOnServer bzw info.lastUpdateOnClient jeweils das �ltere von beiden
    // tt := datetimetounix(dtt);
    lastUpdateServerUnixTime := faIni.ReadInteger('lastUpdateServerUnixTime:', 'unixTime', 0);

    tt := lastUpdateServerUnixTime;
  end
  else
    tt := datetimetounix(dt); // das ist die Vorgabe per Inputbox
  LoadInfo('Sort Actions ...');
  lold := length(cwActions);
  lbCSVDebug('[Vorbereitung]' + inttostr(GetTickCount - gt));

  // Neue Variante: fromModified
  gt := GetTickCount;
  GetLastServerUnixTime;

  // append=true Die Actions werden angeh�ngt
  // showmessage('Abruf ab:' + datetimetostr(unixtodatetime(tt)) + ' Actions:' + inttostr(lold));
  a1 := GetBinData('http://h2827643.stratoserver.net:' + cServerPort + '/bin/actions?fromModified=' + inttostr(tt), 'actions', lbCSVError, true, 500000);
  if (a1 <> -1) then
  begin
    //
    lastUpdateServerUnixTime := lastServerUnixTime;
    faIni.WriteInteger('lastUpdateServerUnixTime:', 'unixTime', lastUpdateServerUnixTime);

    // kann ich hier schon merken da ja sowieso ALLE Daten der Accounts abgerufen werden
    // andernfalls wurden keine Daten geholt !!
  end;

  // gt := GetTickCount;
  // // append=true Die Actions werden angeh�ngt
  // // showmessage('Abruf ab:' + datetimetostr(unixtodatetime(tt)) + ' Actions:' + inttostr(lold));
  // a1 := GetBinData('http://h2827643.stratoserver.net:' + cServerPort + '/bin/actions?fromOpen=' + inttostr(tt),
  // 'actions', lbCSVError, true, 300000);
  // if (a1 <> -1) then
  // // bei Abbruch wegen zu vieler Actions in a1 nicht weiter abrufen
  // begin
  // // showmessage(' Actions:' + inttostr(length(cwActions)));
  // a2 := GetBinData('http://h2827643.stratoserver.net:' + cServerPort + '/bin/actions?fromClose=' + inttostr(tt),
  // 'actions', lbCSVError, true, 300000);
  // // a1 > 0 bedeutet es sind neue Openings vorhanden
  // // a2 > 0 muss nix bedeuten da es momentan 11 mit CloseTime in der Zukunft gibt
  // end;

  lbCSVDebug('[Daten laden]' + inttostr(GetTickCount - gt));
  gt := GetTickCount;

  // showmessage(' Actions:' + inttostr(length(cwActions)));

  dosleep(CSleep);

  // btnSaveCacheFileCwClick(nil);
  lnew := length(cwActions);

  cnew := lnew - lold;

  // if (claus = false) then
  // begin
  if (cnew = 0) then
  begin
    lbCSVDebug('[Abbruch - keine neuen Actions]' + inttostr(GetTickCount - gt));
    updateStatus := 1; // udateStatus 0=nix zu tun 1=schnell ohne Actions Update 2=mit Actions
    updateGoing := false;
    Dialog2.fdialog2.askFinish(); // Close;
    askFinishUpdate := true;
    exit;
    // goto rest; // exit
  end;

  // end;
  // IntArray und Int64Array
  setlength(na2, cnew);
  setlength(na, cnew);
  p := -1;
  for i := lold to lnew - 1 do
  begin
    inc(p);
    na2[p] := cwActions[i].actionId;
    na[p] := i;
  end;

  dosleep(CSleep);
  // na2 enth�lt die neuen ActionIds und na die Indexe in cwactions
  // nun werden diese Arrays sortiert
  fastsort2arrayInt64Int(na2, na, 'VUI'); // VDI
  lbCSVDebug('[sort1]' + inttostr(GetTickCount - gt));
  dosleep(CSleep);

  gt := GetTickCount;

  // doppelte daraus entfernen
  for i := 1 to cnew - 1 do
  // Absichtlich ab i=1 !
  begin
    if na2[i] = na2[i - 1] then
      cwActions[na[i - 1]].actionId := 0;
  end;
  dosleep(CSleep);

  // jetzt sieht cwactions so aus: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa nnn0nn0nn0nn0n0n0nnn     a=die alten Action n=die neuen 0 dir doppelten

  // jetzt noch die bin�re Suche in den (alten) Actions erm�glichen
  // n := binsearchint64(ia2, cwActions[i].actionId);
  gts := GetTickCount;
  setlength(ia2, lold);
  setlength(ia, lold);
  for i := 0 to lold - 1 do
  begin
    ia2[i] := cwActions[i].actionId;
    ia[i] := i;
  end;
  dosleep(CSleep);

  fastsort2arrayInt64Int(ia2, ia, 'VUI'); // VDI
  lbCSVDebug('[sort2]' + inttostr(GetTickCount - gts));
  dosleep(CSleep);
  gt := GetTickCount;

  // das ist das sortierte alte cwactions array vor den Neuanf�gungen
  //
  for i := lold to lnew - 1 do
  begin
    if cwActions[i].actionId <> 0 then
    begin
      n := binsearchint64(ia2, cwActions[i].actionId);
      if (n = -1) then
      begin
        // nicht gefunden
      end
      else
      begin
        // die ge�nderte Action wurde in den alten Actions gefunden - nun austauschen
        cwActions[ia[n]] := cwActions[i];
        // und den neuen Eintrag 'l�schen'
        cwActions[i].actionId := 0;
      end;
    end;
  end;

  lbCSVDebug('[einf�gen1]' + inttostr(GetTickCount - gt));
  dosleep(CSleep);
  gt := GetTickCount;

  p := lold - 1; // zeiger auf den letzten alten index
  for i := lold to lnew - 1 do
  begin
    // das sind jetzt die neuen Actions !
    if cwActions[i].actionId <> 0 then
    begin
      inc(p);
      cwActions[p] := cwActions[i];
    end;
  end;
  setlength(cwActions, p + 1);
  setlength(cwActionsPlus, p + 1);
  cwActionsSorted := false;

  lbCSVDebug('[einf�gen2]' + inttostr(GetTickCount - gt));
  dosleep(CSleep);
  gt := GetTickCount;

  updateStatus := 2; // 0=nix zu tun 1=schnell ohne Actions Update 2=mit Actions
  if (doUpdateCt > 1) then
  begin
    Dialog2.fdialog2.askFinish(); // Close;
    askFinishUpdate := true; // -> button l�st finishUpdate
  end
  else
    finishUpdate();

  // Zeiten hier sind TDateTime
  faIni.WriteDateTime('updateOnClient:', 'dateTime', info.lastUpdateOnServer);
  faIni.WriteInteger('lastUpdateServerUnixTime:', 'unixTime', lastUpdateServerUnixTime);
  // lastUpdateServerUnixTime
  exit;

  // // -> nach finishUpdate verschoben
  // // fertig
  // showmessage('new data available');
  // doFinalizeData;
  // dosleep(CSleep);
  // lbCSVDebug('[finalize]' + inttostr(GetTickCount - gt));
  //
  // lblAllDataInfo.Caption := ' Users:' + inttostr(length(cwUsers)) + #13#10 + ' Symbols:' + inttostr(length(cwSymbols)) +
  // #13#10 + ' Actions:' + inttostr(length(cwActions));
  // lbCSVDebug('Time Update:' + inttostr(GetTickCount - gtall) + 'new actions:' + inttostr(lnew - lold));
  // rest:
  // dosleep(CSleep);
  // // gt:=gettickcount;
  // // computeStartScreen;
  // // lbCSVDebug('Compute StartScreen:' + inttostr(GetTickCount - gt));
  // dosleep(CSleep);
  // getSymbolsUsersComments(false); // vom Server damit die Werte aktuell sind
  // dosleep(CSleep);
  // gt := GetTickCount;
  // computeStartScreen;
  // lbCSVDebug('Compute StartScreen:' + inttostr(GetTickCount - gt));
  // dosleep(CSleep);
  //
  // Dialog2.fdialog2.Close;
  // updateGoing := false;
end;

procedure TForm2.finishUpdate();

begin
  updateGoing := true; // damit niemand reinfunkt
  askFinishUpdate := false;
  if (updateStatus = 2) then // die wichtigen Action-Updates
  begin

    // showmessage('new data available');
    doFinalizeData;
    dosleep(CSleep);

    lblAllDataInfo.Caption := ' Users:' + inttostr(length(cwUsers)) + #13#10 + ' Symbols:' + inttostr(length(cwSymbols)) + #13#10 + ' Actions:' + inttostr(length(cwActions));
  end;
  // lbCSVDebug('Time Update:' + inttostr(GetTickCount - gtall) + 'new actions:' + inttostr(lnew - lold));
  // rest:
  dosleep(CSleep);
  // gt:=gettickcount;
  // computeStartScreen;
  // lbCSVDebug('Compute StartScreen:' + inttostr(GetTickCount - gt));
  dosleep(CSleep);
  // das k�nnte man sich sparen wenn gerade erst durchgef�hrt !
  if ((now - getSymbolsUsersCommentsTime) > (1 / 1440)) then
  begin
    getSymbolsUsersComments(false);
    // vom Server damit die Werte aktuell sind
    dosleep(CSleep);
  end
  else
  begin
    // showmessage('das spare ich mir');
  end;
  computeStartScreen;
  // lbCSVDebug('Compute StartScreen:' + inttostr(GetTickCount - gt));
  dosleep(CSleep);

  Dialog2.fdialog2.Close;
  updateGoing := false;
  updateStatus := 0; // fertig
end;

procedure TForm2.Button9Click(Sender: TObject);

// const
// colors1: array [0 .. 4] of TCOLOR = (clWhite, clYellow, clBlack, clWhite, clWhite);
// // (clRed, clBlue, clGreen, clPurple, clMaroon);
// colors2: array [0 .. 4] of TCOLOR = (clDkGray, clLtGray, clLime, clOlive, clLime);
// colors3: array [0 .. 4] of TCOLOR = (clBlack, clWhite, clRed, clRed, clBlack);
// // (clBlue, clLime, clFuchsia, clAqua, clRed);
// values: array [0 .. 19] of String = ('Mercedes', 'Audi', 'Land rover', 'BMW', 'Ferrari', 'Bugatti', 'Porsche',
// 'Range rover', 'Lamborghini', 'Rolls Royce', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a');
// var
// i, j: integer;
// c: TCOLOR;
// X, Y: integer;
begin
  //
  // // AdvGDIPChartView1.Panes[0].Series.add;//von Hand eine Series hinzuf�gen (zwei bereits im Editor)
  //
  // for j := 0 to 3 do
  // begin
  // for i := 0 to 9 do
  // begin
  // Randomize;
  // if i <= 5 then
  // begin
  //
  // AdvGDIPChartView2.panes[0].series[j].AddPiePoints(RandomRange(20, 300), values[i], colors1[1],
  // colors3[i], 0, true);
  // end
  // else
  // begin
  // c := RGB(random(255), random(255), random(255));
  // AdvGDIPChartView2.panes[0].series[j].AddPiePoints(RandomRange(20, 300), values[i], colors2[i],
  // colors3[i], 0, true);
  // end;
  // end;
  // AdvGDIPChartView2.panes[0].series[j].ChartType := ctpie;
  // AdvGDIPChartView2.panes[0].series[j].LegendText := 'Donut Chart 1';
  // AdvGDIPChartView2.panes[0].series[j].Pie.LegendGradientType := gtHatch;
  // AdvGDIPChartView2.panes[0].series[j].Pie.LegendHatchStyle := HatchStyleForwardDiagonal;
  // AdvGDIPChartView2.panes[0].series[j].Pie.LegendOpacity := 100;
  // AdvGDIPChartView2.panes[0].series[j].Pie.LegendOpacityTo := 100;
  // AdvGDIPChartView2.panes[0].series[j].Pie.ValueFont.Color := clNavy;
  // AdvGDIPChartView2.panes[0].series[j].Pie.Size := 100 + j * 100;
  // AdvGDIPChartView2.Color := clBlue;
  // end;
  //
  // for j := 0 to 1 do
  // begin
  // for i := 0 to 9 do
  // begin
  // Randomize;
  // if i <= 5 then
  // begin
  // AdvGDIPChartView3.panes[0].series[j].AddPiePoints(RandomRange(20, 300), values[i], colors1[1],
  // colors3[i], 0, true);
  // end
  // else
  // begin
  // c := RGB(random(255), random(255), random(255));
  // AdvGDIPChartView3.panes[0].series[j].AddPiePoints(RandomRange(20, 300), values[i], colors2[i],
  // colors3[i], 0, true);
  // end;
  // end;
  // AdvGDIPChartView3.panes[0].series[j].ChartType := ctpie;
  // AdvGDIPChartView3.panes[0].series[j].LegendText := 'Donut Chart 1';
  // AdvGDIPChartView3.panes[0].series[j].Pie.LegendGradientType := gtHatch;
  // AdvGDIPChartView3.panes[0].series[j].Pie.LegendHatchStyle := HatchStyleForwardDiagonal;
  // AdvGDIPChartView3.panes[0].series[j].Pie.LegendOpacity := 100;
  // AdvGDIPChartView3.panes[0].series[j].Pie.LegendOpacityTo := 100;
  // AdvGDIPChartView3.panes[0].series[j].Pie.ValueFont.Color := clNavy;
  // AdvGDIPChartView3.panes[0].series[j].Pie.Size := 100 + j * 100;
  // AdvGDIPChartView3.Color := clBlue;
  // end;
  //
  // for j := 0 to 0 do
  // begin
  // for i := 0 to 19 do
  // begin
  // Randomize;
  // if i <= 5 then
  // begin
  // AdvGDIPChartView1.panes[0].series[j].AddPiePoints(RandomRange(20, 300), values[i], colors1[1],
  // colors3[i], 0, true);
  // end
  // else
  // begin
  // c := RGB(random(255), random(255), random(255));
  // AdvGDIPChartView1.panes[0].series[j].AddPiePoints(RandomRange(20, 300), values[i], colors2[i],
  // colors3[i], 0, true);
  // end;
  // end;
  // AdvGDIPChartView1.panes[0].series[j].ChartType := ctpie;
  // AdvGDIPChartView1.panes[0].series[j].LegendText := 'Donut Chart 1';
  // AdvGDIPChartView1.panes[0].series[j].Pie.LegendGradientType := gtHatch;
  // AdvGDIPChartView1.panes[0].series[j].Pie.LegendHatchStyle := HatchStyleForwardDiagonal;
  // AdvGDIPChartView1.panes[0].series[j].Pie.LegendOpacity := 100;
  // AdvGDIPChartView1.panes[0].series[j].Pie.LegendOpacityTo := 100;
  // AdvGDIPChartView1.panes[0].series[j].Pie.ValueFont.Color := clNavy;
  // AdvGDIPChartView1.panes[0].series[j].Pie.Size := 100 + j * 100;
  // AdvGDIPChartView1.Color := clBlue;
  // end;
  //
  // for j := 1 to 9 do
  // begin
  // AdvGDIPChartView1.panes[0].series.Add.Assign(AdvGDIPChartView1.panes[0].series[0]);
  // end;
  //
  // X := 50;
  // Y := 40;
  // for j := 0 to 9 do
  // begin
  // AdvGDIPChartView1.panes[0].series[j].Pie.Size := 70 + random(40);
  // AdvGDIPChartView1.panes[0].series[j].Pie.Left := X;
  // AdvGDIPChartView1.panes[0].series[j].Pie.top := Y;
  // X := X + 100;
  // if X > 800 then
  // begin
  // X := 50;
  // Y := Y + 50;
  // end;
  // end;
  //
  // //
  // // SwitchtoDonut1Click(self);
end;

procedure TForm2.btnOnePageClick(Sender: TObject);

begin

  with (Sender as TButton) do
  begin

    if Caption <> 'Actions' then
      CategoryPanel1.collapsed := true;
    if Caption <> 'Symbols' then
      CategoryPanel2.collapsed := true;
    if Caption <> 'Users' then
      CategoryPanel3.collapsed := true;
    if Caption <> 'Comments' then
      CategoryPanel4.collapsed := true;

    if Caption = 'Actions' then
      CategoryPanel1.collapsed := false;
    if Caption = 'Symbols' then
      CategoryPanel2.collapsed := false;
    if Caption = 'Users' then
      CategoryPanel3.collapsed := false;
    if Caption = 'Comments' then
      CategoryPanel4.collapsed := false;
  end;
end;

procedure TForm2.btnSampleClick(Sender: TObject);
// Die Sample-Buttons mit ihren speziellen Voreinstellungen
var
  i: integer;
  fe: TFilterParameter;
  // TFilterParameter = packed record
  // active: Boolean;
  // topic: string;
  // operator: string;
  // values: string;
  // vglI: array of integer;
  // vglS: array of string;
  // end;
begin
  // erstmal alle abschalten
  fe.Active := false;
  fe.comment := (Sender as TButton).Caption;

  chkFilterWithOpenActions.Checked := false;
  for i := 1 to FilterCt do
  begin
    Filter[i].setValues(fe);
  end;

  if (Sender = btnSample1) then
  begin
    fe.Active := true;
    fe.topic := 'ActionType';
    fe.operator := '=';
    fe.values := 'BALANCE';
    Filter[1].setValues(fe);
    Grouping[1].cbTopic.text := 'yearsOpen';
    Grouping[1].cbTopic.Visible := true;
  end;

  if (Sender = btnSample2) then
  begin
    fe.Active := true;
    fe.topic := 'Profit';
    fe.operator := '>=';
    fe.values := '1000';
    Filter[1].setValues(fe);

    fe.Active := true;
    fe.topic := 'ActionType';
    fe.operator := '<>';
    fe.values := 'BALANCE,CREDIT';
    Filter[2].setValues(fe);
    Grouping[1].cbTopic.text := 'yearsOpen';
    Grouping[1].cbTopic.Visible := true;

  end;

  if (Sender = btnSample3) then
  begin
    fe.Active := true;
    fe.topic := 'Symbol';
    fe.operator := 'contains';
    fe.values := 'GOLD';
    Filter[1].setValues(fe);

    fe.Active := true;
    fe.topic := 'Profit';
    fe.operator := '<';
    fe.values := '0';
    Filter[2].setValues(fe);

    fe.Active := true;
    fe.topic := 'CloseDateTime';
    fe.operator := '>';
    fe.values := '0';
    Filter[3].setValues(fe);
    Grouping[1].cbTopic.text := 'yearsOpen';
    Grouping[1].cbTopic.Visible := true;

  end;

  if (Sender = btnSample4) then
  begin
    fe.Active := true;
    fe.topic := 'Symbol';
    fe.operator := 'contains';
    fe.values := 'GOLD';
    Filter[1].setValues(fe);

    fe.Active := true;
    fe.topic := 'Profit';
    fe.operator := '>';
    fe.values := '0';
    Filter[2].setValues(fe);

    fe.Active := true;
    fe.topic := 'CloseDateTime';
    fe.operator := '<>';
    fe.values := '0';
    Filter[3].setValues(fe);

    Grouping[1].cbTopic.text := 'yearsOpen';
    Grouping[1].cbTopic.Visible := true;
  end;

  if (Sender = btnSample5) then
  begin
    fe.Active := true;
    fe.topic := 'ActionType';
    fe.operator := '<>';
    fe.values := 'BALANCE,CREDIT';
    Filter[1].setValues(fe);

    fe.Active := true;
    fe.topic := 'CloseDateTime';
    fe.operator := '>';
    fe.values := '1564617600';
    Filter[2].setValues(fe);

    fe.Active := true;
    fe.topic := 'CloseDateTime';
    fe.operator := '<';
    fe.values := '1567209600';
    Filter[3].setValues(fe);
    Grouping[1].cbTopic.text := 'yearsOpen';
    Grouping[1].cbTopic.Visible := true;

  end;

  if (Sender = btnSample6) then
  begin
    fe.Active := true;
    fe.topic := 'CloseDateTime';
    fe.operator := '=';
    fe.values := '0';
    Filter[1].setValues(fe);
    Grouping[1].cbTopic.text := 'brokerAccount';
    Grouping[1].cbTopic.Visible := true;
  end;

  if (Sender = btnSample7) then
  begin
    fe.Active := true;
    fe.topic := 'ActionType';
    fe.operator := '<>';
    fe.values := 'BALANCE,CREDIT';
    Filter[1].setValues(fe);

    fe.Active := true;
    fe.topic := 'CloseDateTime';
    fe.operator := '>= or 0';
    fe.values := inttostr(datetimetounix(trunc(now)));
    Filter[2].setValues(fe);

    fe.Active := true;
    fe.topic := 'OpenDateTime';
    fe.operator := '<';
    fe.values := inttostr(datetimetounix(trunc(now) + 1));
    Filter[3].setValues(fe);
    Grouping[1].cbTopic.text := 'brokerAccount';
    Grouping[1].cbTopic.Visible := true;
    // fe.Active := true;
    // fe.topic := 'CloseDateTime';
    // fe.operator := '< not 0';
    // fe.values := inttostr(datetimetounix(trunc(now) + 1));
    // Filter[4].setValues(fe);

    chkFilterWithOpenActions.Checked := true;
    Grouping[1].chkActive.Checked := true;
    exit; // nur ausf�llen aber nicht ausf�hren
  end;

  FilterTopic := (Sender as TButton).Caption;

  Grouping[1].chkActive.Checked := true;
  Grouping[2].chkActive.Checked := false;
  Grouping[3].chkActive.Checked := false;

  Form2.Refresh;

  doFilter();
  // Wegen grouping: Herstellen der Sortierfelder f�r die schnelle Usersuche in der Teilmenge der User in den Filteractions
  doGroup();
  // -> dynGrid9

end;

procedure TForm2.btnSaveCacheFileCwClick(Sender: TObject);
begin
  saveCacheFileCw(cCachefile, 'actions', lbCSVError);
end;

procedure TForm2.CategoryPanel1Click(Sender: TObject);
begin
  //

end;

procedure TForm2.CategoryPanel1Collapse(Sender: TObject);
begin
  //
  remeasureCategoryPanels(CategoryPanelGroup1);
end;

procedure TForm2.CategoryPanel1Expand(Sender: TObject);
begin
  //
  remeasureCategoryPanels(CategoryPanelGroup1);
end;

procedure TForm2.CategoryPanel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  i: integer;
  pa: TCategoryPanel;
begin
  //
  // if ssshift in Shift then

  if Y < CategoryPanelGroup1.Headerheight then
  begin
    if Button = mbright then
    begin
      for i := 0 to CategoryPanelGroup1.Panels.Count - 1 do
      begin
        pa := CategoryPanelGroup1.Panels.Items[i];
        // .collapsed:=true;
        pa.collapsed := true;
      end;
    end;

  end;

end;

procedure TForm2.CategoryPanel9CollapseExpand(Sender: TObject);
begin
  remeasureCategoryPanels(CategoryPanelGroup3);
end;

procedure TForm2.CategoryPanelGroup1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  //
  showmessage('');
end;

procedure TForm2.cbLoadFiltersClick(Sender: TObject);
begin
  loadFilters(GetCurrentDir + '\' + cbLoadFilters.text);
end;

procedure TForm2.cbLoadFiltersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
    showmessage('Delete key was pressed - delete the filters ?');
end;

procedure TForm2.cbStylesChange(Sender: TObject);
begin
  if cbStyles.text <> '' then
    TStyleManager.SetStyle(cbStyles.text);

end;

procedure TForm2.CheckBox1Click(Sender: TObject);
begin
  gridsortmethode2 := CheckBox1.Checked;
end;

procedure TForm2.CheckBox2Click(Sender: TObject);
begin
  updateTimer.enabled := CheckBox2.Checked;
end;

procedure TForm2.remeasureCategoryPanels(c1: TCategoryPanelGroup);
var
  coll, SplitHeight, i: integer;
begin
  coll := 0;
  for i := 0 to c1.ControlCount - 1 do
    if c1.Controls[i] is TCategoryPanel then
      if TCategoryPanel(c1.Controls[i]).collapsed then
        inc(coll);
  if coll < c1.ControlCount then
  begin
    SplitHeight := (c1.Height - coll * 30) div (c1.ControlCount - coll);
    for i := 0 to c1.ControlCount - 1 do
      if c1.Controls[i] is TCategoryPanel then
        if not TCategoryPanel(c1.Controls[i]).collapsed then
          TCategoryPanel(c1.Controls[i]).Height := SplitHeight;
  end;
end;

procedure TForm2.saveFilters(fName: string);
var
  mf: TMemIniFile;
  i: integer;
begin
  //
  mf := TMemIniFile.Create(fName + '.flt');
  for i := 1 to FilterCt do
  begin
    mf.WriteBool('filter' + inttostr(i), 'chkActive', Filter[i].chkActive.Checked);
    mf.WriteString('filter' + inttostr(i), 'cbTopic', Filter[i].cbTopic.text);
    mf.WriteString('filter' + inttostr(i), 'cbOperator', Filter[i].cbOperator.text);
    mf.WriteString('filter' + inttostr(i), 'edValue', Filter[i].edValue.text);
  end;
  mf.UpdateFile;
  freeandnil(mf);
end;

procedure TForm2.loadFilters(fName: string);
var
  mf: TMemIniFile;
  i: integer;
  fe: TFilterParameter;
begin
  //
  mf := TMemIniFile.Create(fName + '.flt');
  for i := 1 to FilterCt do
  begin
    fe.Active := mf.readBool('filter' + inttostr(i), 'chkActive', false);
    fe.topic := mf.readString('filter' + inttostr(i), 'cbTopic', '');
    fe.operator := mf.readString('filter' + inttostr(i), 'cbOperator', '');
    fe.values := mf.readString('filter' + inttostr(i), 'edValue', '');
    Filter[i].setValues(fe);
  end;
  freeandnil(mf);
end;

procedure TForm2.setPageIndex(i: integer);
var
  j: integer;
  t: TTabSheet;
begin
  // Wechsel der Tabs
  // Ersatz f�r PageControl1.ActivePageIndex:=i
  for j := 0 to 10 do
  begin
  end;
  if (TabSheet1.Visible = true) then
    if (i <> 0) then
      TabSheet1.Visible := false;

  if (TabSheet2.Visible = true) then
    if (i <> 1) then
      TabSheet2.Visible := false;

  if (TabSheet3.Visible = true) then
    if (i <> 2) then
      TabSheet3.Visible := false;

  if (TabSheet4.Visible = true) then
    if (i <> 3) then
      TabSheet4.Visible := false;

  if (TabSheet5.Visible = true) then
    if (i <> 4) then
      TabSheet5.Visible := false;

  if (TabSheet6.Visible = true) then
    if (i <> 5) then
      TabSheet6.Visible := false;

  if (TabSheet7.Visible = true) then
    if (i <> 6) then
      TabSheet7.Visible := false;

  if (TabSheet8.Visible = true) then
    if (i <> 7) then
      TabSheet8.Visible := false;

  if (TabSheet9.Visible = true) then
    if (i <> 8) then
      TabSheet9.Visible := false;

  if (TabSheet10.Visible = true) then
    if (i <> 9) then
      TabSheet10.Visible := false;

  if (TabSheet11.Visible = true) then
    if (i <> 10) then
      TabSheet11.Visible := false;

  case i of
    0:
      begin
        TabSheet1.Visible := true;
        DynGrid2.doUpdateStyleElements;
        DynGrid9.doUpdateStyleElements;
      end;
    1:
      begin
        TabSheet2.Visible := true; // Filter
      end;
    2:
      begin
        TabSheet3.Visible := true;
        DynGrid11.doUpdateStyleElements;
        DynGrid12.doUpdateStyleElements;
        DynGrid13.doUpdateStyleElements;

      end;
    3:
      TabSheet4.Visible := true;
    4:
      begin
        TabSheet5.Visible := true; // User
        DynGrid4.doUpdateStyleElements;
        DynGrid10.doUpdateStyleElements;
      end;
    5:
      begin
        TabSheet6.Visible := true;
        DynGrid3.doUpdateStyleElements;
        DynGrid5.doUpdateStyleElements;
        DynGrid6.doUpdateStyleElements;
        DynGrid7.doUpdateStyleElements;

      end;
    6:
      TabSheet7.Visible := true;
    7:
      TabSheet8.Visible := true;
    8:
      TabSheet9.Visible := true;
    9:
      TabSheet10.Visible := true;
    10:
      TabSheet11.Visible := true;

  end;
  if (TabToResize[i] = true) then
  begin
    Form2ResizeSimuliert := true;
    // Form2.Width := Form2.Width + 1;     //betrifft aber leider wieder ALLE
    // Form2.Width := Form2.Width - 1;
    Form2ResizeSimuliert := false;
    TabToResize[i] := false;
  end;

  // form2.Width:=form2.Width+1;
  // form2.Width:=form2.Width-1;

end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  gt: cardinal;
begin
  if (length(cwActions) > 0) then
    btnSaveCacheFileCwClick(nil);
  Application.OnMessage := nil;
  DynGrid2.saveInit;
  DynGrid3.saveInit;
  DynGrid4.saveInit;
  DynGrid5.saveInit;
  DynGrid6.saveInit;
  DynGrid7.saveInit;
  DynGrid8.saveInit;
  DynGrid9.saveInit;
  DynGrid10.saveInit;
  DynGrid11.saveInit;
  DynGrid12.saveInit;

  faIni.WriteInteger('closetick:', 'tick', GetTickCount);

  faIni.UpdateFile;
  freeandnil(faIni);
  if HTTPWorker1.Finished = false then
  begin
    HTTPWorker1.Terminate;
    HTTPWorker1.waitfor;
    HTTPWorker1.free;
    HTTPWorker1.ResultList.free;
    HTTPWorker1Aktiv := false;
    dosleep(10);
  end;
  DeleteCriticalSection(HTTPWorkCriticalSection);
end;

procedure TForm2.AppOnMessage(var Msg: TMsg; var Handled: boolean);
begin
  if getAppOnMessage then
    case Msg.Message of
      WM_KEYFIRST .. WM_KEYLAST, // Keyboard events
      WM_MOUSEFIRST .. WM_MOUSELAST: // Mouse events
        begin
          lastUserActivity := GetTickCount;
          // Handled := True
        end;
    end;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  i: integer;
  folder, fileName: string;
  style: string;
  pwct: integer;
  pwok: boolean;
  s: string;
  gt: cardinal;
begin

  deletefiles(ExtractFilePath(paramstr(0)) + cCacheFolder, 'y*.bin');

  // nicht nur beimReport sondern allgemein sollten diese alten Cachefiles entfernt werden
  deleteTodaysOpenActionCacheFiles(now);
  deleteTodaysOpenActionCacheFiles(now - 1);
  deleteTodaysOpenActionCacheFiles(now - 2);

  cwActionsSorted := false;
  doUpdateCt := 0;
  fillCbLoadFilters; // die flt Dateien in die Combobox eintragen
  sessionkey := '';
  askFinishUpdate := false; // Button dr�cken Update
  getAppOnMessage := true;
  Application.OnMessage := AppOnMessage;
  Application.OnException := MyExceptionHandler; // hier landet dann
  faIni := TMemIniFile.Create(leftstr(Application.ExeName, length(Application.ExeName) - 4) + '2.ini');
  faIni.AutoSave := true;

  pwct := 0;
  updateGoing := false;
  pwok := false;
  claus := false;

  if (claus = false) then
  begin
    TabSheet1.TabVisible := false;
    TabSheet2.TabVisible := false;
    TabSheet3.TabVisible := false;
    TabSheet4.TabVisible := false;
    TabSheet5.TabVisible := false;
    TabSheet6.TabVisible := false;
    TabSheet7.TabVisible := false;
    TabSheet8.TabVisible := false;
    TabSheet9.TabVisible := false;
    TabSheet10.TabVisible := false;
    setPageIndex(1);

    for pwct := 0 to 2 do
    begin

      if InputQuery('Password', #31 + 'Please enter a password:', pw) then
      else
      begin
        Application.Terminate;
        exit;
      end;

      // pw := InputBox('Password:', 'Password:', '');

      if (pw = '2502') or (pw = '##') then
      begin
        cw := false;
        if (pw = '##') then
        begin
          cw := true;
          SpeedButton7.Visible := true;
          SpeedButton8.Visible := true;
        end;
        pwok := true;
        break;
      end
      else
        showmessage('Wrong password !');

    end;
    if (pwok = false) then
    begin
      showmessage('Sorry ...');
      Application.Terminate;
      exit;
    end;

  end;
  CSleep := 10; // msec Pausen
  firstSampleDone := false;
  makeLabelsDone := false;
  for style in TStyleManager.StyleNames do
  begin
    cbStyles.AddItem(style, nil);
  end;

  gridsortmethode2 := false;
  folder := ExtractFilePath(paramstr(0)) + cCacheFolder;
  createDir(folder);
  fileName := folder + '\' + cCachefile + '.bin';
  if fileExists(fileName) then
  begin
    cbLoadActionsFromCache.Visible := true;
    cbLoadActionsFromCache.Checked := true;

  end
  else
  begin
    cbLoadActionsFromCache.Visible := false;
  end;

  TabSheet1.TabVisible := claus;
  TabSheet6.TabVisible := claus;
  TabSheet5.TabVisible := claus;
  TabSheet7.TabVisible := claus;
  TabSheet9.TabVisible := claus;
  TabSheet4.TabVisible := claus;
  TabSheet10.TabVisible := claus;

  brokerShort[1] := 'LCG';
  brokerShort[2] := 'AT';

  accountShort[1] := 'LCG A';
  accountShort[2] := 'LCG B';
  accountShort[3] := 'AT A';
  accountShort[4] := 'AT B';
  accountShort[5] := 'AT C';
  accountShort[6] := 'AT D';
  accountShort[7] := 'AT E';

  accountCurrency[1] := 'EUR';
  accountCurrency[2] := 'USD';
  accountCurrency[3] := 'CHF';
  accountCurrency[4] := 'GBP';

  FilterCt := 10;
  for i := 1 to FilterCt do
  begin
    Filter[i] := TFilterElemente.Create(self);
    Filter[i].name := 'Filter_' + inttostr(i); // muss sein
    Filter[i].SetBounds(0, (i - 1 + 2) * Filter[i].Height, Filter[i].Width, Filter[i].Height);
    Filter[i].Parent := pnlFilter;
  end;

  pnlStartBack.Refresh;
  GroupingCt := 3;
  for i := 1 to GroupingCt do
  begin
    Grouping[i] := TGroupControl.Create(self);
    Grouping[i].name := 'Grouping_' + inttostr(i); // muss sein
    Grouping[i].SetBounds(0, (i - 1 + 2) * Grouping[i].Height, Grouping[i].Width, Grouping[i].Height);
    Grouping[i].Parent := pnlGrouping;
  end;

  maxActionsPerGrid := 10000;

  lboxDebug := lbCSVError;
  lbCSV := lbCSVError;
  lboxInfo := lbCSVError;

  setlength(SGFieldCol, 30);
  setlength(SGColField, 30);
  for i := 0 to 29 do
  begin
    SGFieldCol[i] := i;
    // SGFieldCol(FieldNummer)->Row im Grid des Fields
    SGColField[i] := i; // SGColField(Row)->gesuchtes Feld der Spalte Row
  end;

  clbBrokers.Items.clear;

  clbBrokers.Items.Add('1: LCG A');
  clbBrokers.Items.Add('2: LCG B');
  clbBrokers.Items.Add('3: AT A');
  clbBrokers.Items.Add('4: AT B');
  clbBrokers.Items.Add('5: AT C');
  clbBrokers.Items.Add('6: AT D');
  clbBrokers.Items.Add('7: AT E');
  for i := 0 to 6 do
    clbBrokers.Checked[i] := true;

  InitializeCriticalSection(HTTPWorkCriticalSection);
  dosleep(CSleep);
  StartHTTPWorker;
  remeasureCategoryPanels(CategoryPanelGroup1);

  pnlStartBack.Repaint;
  pnlStartBack.Refresh;


  // btnStartDialogClick(nil);
  // fillStartScreen;

  btnLadeDialogClick(nil);
  // fillStartScreen;

end;

procedure TForm2.makelabels;
var
  i: integer;
begin
  twoLblStartCt := 14;
  for i := 1 to twoLblStartCt do
  begin
    twoLblStart[i] := TTwoLabel.Create(self);
    twoLblStart[i].name := 'twoLblStart_' + inttostr(i); // muss sein
    if (i <= trunc(twoLblStartCt / 2)) then
      twoLblStart[i].SetBounds(98, 35 + (i - 1 + 0) * twoLblStart[i].Height, twoLblStart[i].Width, twoLblStart[i].Height)
    else
      twoLblStart[i].SetBounds(500, 35 + (i - 1 + 0 - trunc(twoLblStartCt / 2)) * twoLblStart[i].Height, twoLblStart[i].Width, twoLblStart[i].Height);

    twoLblStart[i].Parent := pnlStart;

  end;
end;

procedure TForm2.ApplicationEvents1ModalBegin(Sender: TObject);
begin
  //
end;

procedure TForm2.ApplicationEvents1ModalEnd(Sender: TObject);
begin
  //
end;

procedure TForm2.btnClbBrokersDeSelectAllClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to clbBrokers.Items.Count - 1 do
  begin
    clbBrokers.Checked[i] := false;
  end;
end;

procedure TForm2.btnClbBrokersSelectAllClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to clbBrokers.Items.Count - 1 do
  begin
    clbBrokers.Checked[i] := true;
  end;
end;

procedure TForm2.btnCwactionsToGridClick(Sender: TObject);
begin
  // doActionsGridCW(SGCwCache, SGFieldCol, cwActions, length(cwActions), maxActionsPerGrid, 1);
  // autosizegrid(SGCwCache);
  DynGrid3.initGrid('cwactions', 'userId', 1, length(cwActions), 30);
  DynGrid3.lblHeader.Caption := 'Actions:' + inttostr(length(cwActions));

end;

procedure TForm2.btnCwCommentsToGridClick(Sender: TObject);
begin
  doCommentsGridCW(SGCwComments, SGFieldCol, cwComments, cwcommentsplus, cwcommentsct, maxActionsPerGrid, 1);
  autosizegrid(SGCwComments, nil);
  DynGrid7.initGrid('cwcomments', 'commentId', 1, length(cwComments), 2);
  DynGrid7.lblHeader.Caption := 'Comments:' + inttostr(length(cwComments));
end;

procedure TForm2.btnCwSymbolsToGridClick(Sender: TObject);
begin
  doSymbolsGridCW(SGCwSymbols, SGFieldCol, cwSymbols, cwSymbolsPlus, length(cwSymbols), maxActionsPerGrid, 1);
  DynGrid5.initGrid('cwsymbols', 'symbolId', 1, length(cwSymbols), 18);
  DynGrid5.lblHeader.Caption := 'Symbols:' + inttostr(cwsymbolsct);

  autosizegrid(SGCwSymbols, nil);

end;

procedure TForm2.btnCwusersToGridClick(Sender: TObject);
begin
  doUsersGridCW(SGCwUsers, SGFieldCol, cwUsers, cwUsersPlus, length(cwUsers), maxActionsPerGrid, 1);
  autosizegrid(SGCwUsers, nil);
  DynGrid6.initGrid('cwusers', 'userId', 1, length(cwUsers), 31);
  DynGrid6.lblHeader.Caption := 'Users:' + inttostr(cwusersct);
  DynGrid10.initGrid('cwusers2', 'userId', 1, length(cwUsers), 31);
  DynGrid10.lblHeader.Caption := 'Users:' + inttostr(cwusersct);

end;

procedure TForm2.btnDblCheckCwClick(Sender: TObject);
var
  sl: TStringList;
  slweg: TStringList;
  i, n: integer;
  doubleCount: integer;
  gt: cardinal;
  da: doublearray; // array of integer;
  ia: intarray; // array of double;
  ct: integer;
begin
  doubleCount := 0;
  ct := length(cwActions);
  setlength(ia, ct);
  setlength(da, ct);
  for i := 0 to ct - 1 do
  begin
    ia[i] := i;
    da[i] := cwActions[i].actionId;
  end;

  gt := timegettime();
  sl := TStringList.Create;
  slweg := TStringList.Create;
  for i := 0 to ct - 1 do
  begin
    sl.Add(inttostr(cwActions[i].actionId) + '=' + inttostr(i))
  end;
  showmessage('mach stringlist Z:' + inttostr(timegettime - gt));
  // der customsort braucht 25334 msec !!
  gt := timegettime();
  sl.CustomSort(StringListSortComparefnUp);
  showmessage('sortiert Zeit3:' + inttostr(timegettime - gt));

  // 1185
  gt := timegettime();
  FastSort2ArrayDouble(da, ia, 'VUA');
  showmessage('sortiert Zeit VUA:' + inttostr(timegettime - gt));
  // den folgenden Teil br�uchte ich nicht Ist nur damit der untere Code weiterhin funktioniert
  for i := 0 to ct do
  begin
    sl.Add(floattostr(da[i]) + '=' + inttostr(ia[i]))
  end;

  gt := timegettime();
  for i := 0 to ct - 2 do
  begin
    if (sl.Names[i] = sl.Names[i + 1]) then
    begin
      if (cwActions[strtoint(sl.ValueFromIndex[i])].typeId <> 7) then
      // nicht die BALANCE Eintr�ge entfernen  !! cmd=6 ist typeId=7 !!
      begin
        doubleCount := doubleCount + 1;
        slweg.Add(sl.ValueFromIndex[i]);
      end;
    end;
  end;
  showmessage('doppelte:' + inttostr(doubleCount) + ' Zeit:' + inttostr(timegettime - gt));
  gt := timegettime();
  // alle doppelten mit der order=-1 kennzeichnen
  for i := 0 to doubleCount - 1 do
  begin
    n := strtoint(slweg[i]);
    cwActions[n].actionId := -1;
  end;
  // und nun alle neu aufstapeln
  n := -1;
  for i := 0 to ct - 1 do
  begin
    if (cwActions[i].actionId <> -1) then
    begin
      n := n + 1;
      cwActions[n] := cwActions[i];
    end;
  end;
  // neuer Z�hler ist um doubleCount kleiner
  ct := n + 1;
  setlength(cwActions, ct);
  setlength(cwActionsPlus, ct);
  cwActionsSorted := false;
  showmessage('jetzt im Cache:' + inttostr(ct) + ' Zeit:' + inttostr(timegettime - gt));

  sl.free;
  slweg.free;
  btnShowCacheCwClick(nil); // darstellen
end;

procedure TForm2.btnDoubleRemoveCwClick(Sender: TObject);
var
  sl: TStringList;
  i, dptr: integer;
  killed: string;
  dummy: DACwAction;
begin
  // Doubles remove
  // Dient dazu alle doppelten Eintr�ge KOMPLETT zu entfernen
  // so kann aus einer Suche durch erneutes dr�bersuchen etwas verdoppelt und dann entfernt werden
  if cwFilteredActionCt < 1 then
    exit;

  sl := TStringList.Create;
  for i := 0 to cwFilteredActionCt - 1 do
  begin
    // ergibt name=value Wertepaare die sp�ter nach Name abgesucht werden k�nnen
    sl.Add(inttostr(cwFilteredActions[i].actionId) + '=' + inttostr(i))
  end;
  // sl.Sort;
  FastSortStList(sl, 'AU');
  // ein Dummy Array mit allen cwFilteredActions anlegen
  // dieses nacheinander mit allen nicht-Doppelten Actions f�llen
  setlength(dummy, cwFilteredActionCt);
  dptr := -1;
  // sl.names[]  sl.valuefromindex[]
  for i := 0 to cwFilteredActionCt - 2 do
  begin
    if (sl.Names[i] = killed) then
      // nichts tun - f�llt raus
    else
    begin
      if (sl.Names[i] = sl.Names[i + 1]) then
      begin
        killed := sl.Names[i];
      end
      else
      begin
        // speichern
        killed := '';
        dptr := dptr + 1;
        dummy[dptr] := cwFilteredActions[strtoint(sl.ValueFromIndex[i])];
      end;
    end;
  end;
  // nun noch der letzte
  if (sl.Names[cwFilteredActionCt - 1] <> killed) then
  begin
    dptr := dptr + 1;
    dummy[dptr] := cwFilteredActions[strtoint(sl.ValueFromIndex[cwFilteredActionCt - 1])];
  end;
  // kopieren
  cwFilteredActions := Copy(dummy, 0, cwFilteredActionCt);
  cwFilteredActionCt := dptr + 1;
  setlength(cwFilteredActions, cwFilteredActionCt);
  setlength(cwFilteredActionsPlus, cwFilteredActionCt);

  // doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwFilteredActions, cwFilteredActionCt, cwFilteredActionCt, 1);
  // lblCacheCwSearchResult.Caption := inttostr(cwFilteredActionCt);
  sl.free;
  doCacheGridCwInfo;
end;

procedure TForm2.deleteTodaysOpenActionCacheFiles(dt: TDateTime);
var
  fName: string;
  serverTyp: integer;
  folder, fileName: string;

begin
  for serverTyp := 1 to 7 do
  begin
    fName := 'year=' + FormatDateTime('YYYY', dt) + '&month=' + FormatDateTime('MM', dt) + '&day=' + FormatDateTime('DD', dt) + '&accountId=' + inttostr(serverTyp);
    folder := ExtractFilePath(paramstr(0)) + cCacheFolder;
    fileName := folder + '\' + fName + '.bin';
    if fileExists(fileName) then
    begin
      deletefile(fileName);
    end;

  end;
end;

procedure TForm2.doCacheGridCwInfo;
begin
  // pnlCacheCw.Caption := 'CacheGrid:' + inttostr(SGCache.RowCount - 1);
  // lblCacheCwSearchResult.Caption := inttostr(cwFilteredActionCt + 1); // + ' in:' + inttostr(timegettime - gt);

end;

procedure TForm2.edSingleUserActionsIdChange(Sender: TObject);
begin

end;

// procedure TStringGridSorted.WndProc(var Msg: TMessage);
// var
// v: Integer;
// c: Integer;
// begin
// inherited;
// // OldGridProc(Message);
// // der Hi Wert l�uft zwischen 0 und 127 vom oben nach unten im Scroller
// // if ((Message.Msg = WM_VSCROLL) or (Message.Msg = WM_HSCROLL) or  (Message.msg = WM_Mousewheel)) then
// if ((Msg.Msg = WM_VSCROLL)) then
// begin
//
// if Msg.WParamLo = 5 then // 5=SB_THUMBTRACK  Der Thumb wird bewegt
// begin
// v := VisibleRowCount;
// c := RowCount;
// TopRow := trunc(1 + (c - v - 1) / 127 * Msg.WParamHi);
// // bei wenigen mehr als sichtbare Rows springt der Thumb beim Bewegen leider obwohl die Rechnung schon stimmt
// //
// // cells[0,0]:='v:'+inttostr(v)+' c:'+inttostr(c)+' ->tr:'+inttostr(Toprow)+' Hi:'+inttostr(Msg.WParamHi);
// end;
// end;
// end;

procedure TForm2.SGCwSymbolsColumnMoved(Sender: TObject; FromIndex, ToIndex: integer);
var
  s: string;
  // das Verschieben wird intern im Grid behandelt und schl�gt sich nicht in den Variablen nieder
begin
  s := '';
end;

procedure TForm2.SGCwSymbolsGroupsDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
var
  s: string;
  r: TRect;
  merkColor: integer;
begin
  with Sender as TStringGrid do

  begin
    if ((ARow = 0) and (ACol = SGCwSymbolsGroups.tag)) then
    begin
      s := Cells[ACol, ARow];
      merkColor := Canvas.Brush.Color;
      Canvas.Brush.Color := clGray;

      r := Rect;
      r.Left := r.Left - 4; // -4 wird ganz gef�llt
      Canvas.FillRect(r);
      // Canvas.Pen.Color := clBlue;
      r.Left := r.Left + 6;
      r.Top := r.Top + 4;
      DrawText(Canvas.Handle, PChar(s), length(s), r, DT_LEFT);

      Canvas.Brush.Color := merkColor;
    end;
  end;
end;

procedure TForm2.SGCwSymbolsGroupsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  grid: FTCommons.TStringGridSorted;
  col, row: integer;

begin
  // nur in der obersten Fix row
  if Button = mbleft then
  begin
    grid := Sender as FTCommons.TStringGridSorted;
    grid.MouseToCell(X, Y, col, row);
    // Schutzverletzung
    grid.Cells[col, row];
    if row = 0 then
      grid.Repaint;
  end;

end;

procedure TForm2.SGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
// gemeinsamer Handler f�r alle normalen TStringGridSorted
var
  i: integer;
  grid: FTCommons.TStringGridSorted;
  col, row: integer;
  fixedCol, fixedRow: boolean;
  gt: cardinal;
  Cursor: TCursor;
  header: string;
begin
  gt := timegettime();
  grid := Sender as FTCommons.TStringGridSorted;
  // diese Routine ist nicht im FTCollector sondern nur im FlowAnalyzer
  if Button = mbleft then
  begin
    grid.MouseToCell(X, Y, col, row);
    grid.Cells[col, row];

    // hier kann dann individuell gehandelt werden !
    gridMouseClickHandler(grid, col, row, Button, Shift, '');
    ClipBoard.AsText := grid.Cells[col, row];
    if row = 0 then
    begin

      grid.tag := col;
      // grid.invalidate;
    end;
    exit;
  end;
  if Button = mbright then
  begin
    Cursor := screen.Cursor;
    try
      screen.Cursor := crHourGlass;
      grid.MouseToCell(X, Y, col, row);

      fixedCol := col < grid.FixedCols;
      fixedRow := row < grid.FixedRows;

      if fixedRow then
      // Rechtsclick in den Header -> Sortieren
      begin
        header := grid.Cells[col, 0];
        // speziell bei den Datumsfelder auf eine andere Spalte umlenken
        if header = 'openTime' then
        begin
          for i := 0 to grid.Colcount - 1 do
          begin
            if grid.Cells[i, 0] = 'openTimeUnix' then
            begin
              col := i;
              break;
            end;
          end;
        end;
        if header = 'closeTime' then
        begin
          for i := 0 to grid.Colcount - 1 do
          begin
            if grid.Cells[i, 0] = 'closeTimeUnix' then
            begin
              col := i;
              break;
            end;
          end;
        end;

        if (grid.sortTyp[col] = 0) then
          grid.sortTyp[col] := 1
        else
          grid.sortTyp[col] := -grid.sortTyp[col];

        if gridsortmethode2 = false then
          SortStringGrid(grid, col, grid.sortTyp[col])
        else
          // diese Methode kann nur bei Zahlen angewendet werden - nicht f�r Sortieren von Text !
          SortStringGridCW(grid, col, grid.sortTyp[col]);
        // Selektion l�schen
        grid.Selection := NoSelection;

      end
      else if fixedCol then
        // Right-click in a "row header"
      else
        // Right-click in a non-fixed cell
      finally
        screen.Cursor := Cursor;
      end;
      lbdebug('Zeit Gridsort:' + inttostr(timegettime - gt));
    end;
  end;

  procedure TForm2.SortStringGridCW(var genstrgrid: FTCommons.TStringGridSorted; ThatCol: integer; sortTyp: integer);

  const
    // Define the Separator
    TheSeparator = '@';
  var
    CountItem, i, k: integer;
    MyList: TStringList;
    da: doublearray;
    ia: intarray;
    gt: cardinal;
  begin
    // Give the number of rows in the StringGrid
    CountItem := genstrgrid.rowcount;
    // Create the List
    MyList := TStringList.Create;
    MyList.sorted := false;
    setlength(ia, CountItem - 1);
    setlength(da, CountItem - 1);

    try
      begin
        for i := 1 to (CountItem - 1) do
        begin
          // zB 1.234@name|test|kurs|usw
          // MyList.Add(GenStrGrid.Rows[i].Strings[ThatCol] + TheSeparator + GenStrGrid.Rows[i].Text);
          da[i - 1] := myStringToFloat(genstrgrid.Rows[i].Strings[ThatCol]);
          // da[i - 1] := StrToFloat(GenStrGrid.Rows[i].Strings[ThatCol]);   // !! muss aber auch ein passendes Feld sein !!
          ia[i - 1] := i;
        end;
        // in da[] sind nun ab 0 bis countItem-2  die Werte von Row 1 bis countItem-1 enthalten  Row 0 bleibt - da ist der Header drin
        // Sort the List
        gt := GetTickCount();
        if (sortTyp = -1) then
          // MyList.CustomSort(StringListSortComparefnDown);
          // Immer nach Value sortieren
          FastSort2ArrayDouble(da, ia, 'VUA');
        if (sortTyp = 1) then
          FastSort2ArrayDouble(da, ia, 'VDA');
        lbdebug('Sort:' + inttostr(GetTickCount - gt));
        gt := GetTickCount();
        for k := 0 to CountItem - 1 do
        begin
          MyList.Add(genstrgrid.Rows[k].text);
          // MyList ist nun quasi die Kopie des StringGrids ab unterhalb der �berschrift
        end;
        lbdebug('Mylist:' + inttostr(GetTickCount - gt));
        gt := GetTickCount();

        for k := 1 to CountItem - 1 do
        begin
          genstrgrid.Rows[k].BeginUpdate;
          genstrgrid.Rows[k].text := MyList.Strings[ia[k - 1]];
          genstrgrid.Rows[k].EndUpdate;
          if k = 50 then
            genstrgrid.Repaint;
        end;
        lbdebug('Grid neu:' + inttostr(GetTickCount - gt));

      end;
    finally
      // Free the List
      MyList.free;
    end;

  end;

  procedure TForm2.SpeedButton1Click(Sender: TObject);
  begin
    setPageIndex(1); // TabSheet2   Start/Info

  end;

  procedure TForm2.SpeedButton2Click(Sender: TObject);
  begin
    setPageIndex(0); // TabSheet 1 Data Inspector

  end;

  procedure TForm2.SpeedButton3Click(Sender: TObject);
  begin
    setPageIndex(4); // TabSheet5 User

  end;

  procedure TForm2.SpeedButton4Click(Sender: TObject);
  begin
    setPageIndex(5); // 1;
  end;

  procedure TForm2.SpeedButton5Click(Sender: TObject);
  begin
    setPageIndex(7); // Data Loading

  end;

  procedure TForm2.SpeedButton6Click(Sender: TObject);
  begin
    setPageIndex(10); // Report

  end;

  procedure TForm2.SpeedButton7Click(Sender: TObject);
  begin
    setPageIndex(3); // Report
  end;

  procedure TForm2.SpeedButton8Click(Sender: TObject);
  begin
    setPageIndex(2); // Internal
  end;

  procedure TForm2.SortStringGrid(var genstrgrid: FTCommons.TStringGridSorted; ThatCol: integer; sortTyp: integer);

  const
    // Define the Separator
    TheSeparator = #1;
  var
    CountItem, i, j, k, ThePosition: integer;
    MyList: TStringList;
    gt: cardinal;
  begin
    // Give the number of rows in the StringGrid
    CountItem := genstrgrid.rowcount;
    // Create the List
    MyList := TStringList.Create;
    MyList.sorted := false;
    try
      begin
        gt := timegettime;
        for i := 1 to (CountItem - 1) do
          // zB 1.234@name|test|kurs|usw
          // die zu sortierende Spalte vorne an die Row anh�ngen - dazwischen den Separator
          MyList.Add(genstrgrid.Rows[i].Strings[ThatCol] + TheSeparator + genstrgrid.Rows[i].text);

        // Sort the List
        lbdebug('Sort MyList:' + inttostr(timegettime - gt));
        gt := timegettime;
        if (sortTyp = -1) then
          MyList.CustomSort(StringListSortComparefnDown);
        if (sortTyp = 1) then
          MyList.CustomSort(StringListSortComparefnUp);
        lbdebug('Sort CustomSort:' + inttostr(timegettime - gt));

        gt := timegettime;

        for k := 1 to MyList.Count do
        begin
          // Take the String of the line (K � 1)
          // MyString := MyList.Strings[(k - 1)];
          // Find the position of the Separator in the String
          ThePosition := pos(TheSeparator, MyList.Strings[(k - 1)]); // MyString);
          // TempString := '';
          { Eliminate the Text of the column on which we have sorted the StringGrid }
          // TempString := Copy(MyString, (ThePosition + 1), length(MyString));
          // MyList.Strings[(k - 1)] := '';
          MyList.Strings[(k - 1)] := Copy(MyList.Strings[(k - 1)], (ThePosition + 1), length(MyList.Strings[(k - 1)]));
          // TempString;
        end;
        lbdebug('Sort MyList gen:' + inttostr(timegettime - gt));

        // Refill the StringGrid       - ca 75% der Zeit hierf�r
        gt := timegettime;
        for j := 1 to (CountItem - 1) do
        begin
          genstrgrid.Rows[j].BeginUpdate;
          genstrgrid.Rows[j].text := MyList.Strings[(j - 1)]; // hier ist der Zeitfresser
          genstrgrid.Rows[j].EndUpdate;
          if (j = 50) then // schonmal anzeigen !
            genstrgrid.Repaint;
        end;
        genstrgrid.rowcount := CountItem;

        lbdebug('Sort ->Grid:' + inttostr(timegettime - gt));
      end;
    finally
      // Free the List
      MyList.free;
    end;

  end;

  procedure TForm2.TabSheet2Resize(Sender: TObject);
  begin
    Panel10.Left := trunc(TabSheet2.Width / 2) - trunc(Panel10.Width / 2);
  end;

  procedure TForm2.StartTimerTimer(Sender: TObject);
  begin
    // Starttimer
    StartTimer.enabled := false;
    doLoadAllData;
    updateTimer.Interval := 100;
    // gleich nach dem Start ein Update durchf�hren

    // Form2.Width := Form2.Width + 1;
  end;

  procedure TForm2.doLoadAllData();
  begin
    Dialog2.fdialog2.btnFinishUpdate.Visible := false;
    askFinishUpdate := false;
    Dialog2.fdialog2.show; // Modal;
    Dialog2.fdialog2.Top := Form2.Top + Form2.Height - fdialog2.Height - 4;
    Dialog2.fdialog2.Left := Form2.Left + Form2.Width - fdialog2.Width - 4;
    Form2.Repaint;
    btnLoadDataClick(nil);
  end;
  // procedure TForm2.TrackBar1Change(Sender: TObject);
  // begin
  // SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
  // SetLayeredWindowAttributes(Handle, ColorToRGB(FColorKey), TrackBar1.Position, LWA_ALPHA);
  // end;

  procedure TForm2.zeigUserInfo(id: integer; lb: TListBox);
  var
    k: integer;
  begin
    k := finduserindex(id);

    lb.Items.clear;

    if (k < 0) then
      exit;

    lbadd(lb, 'userId' + #9 + inttostr(cwUsers[k].userId));
    lbadd(lb, 'accountId' + #9 + inttostr(cwUsers[k].accountId));
    lbadd(lb, 'group' + #9 + cwUsers[k].group);
    lbadd(lb, 'enable' + #9 + inttostr(cwUsers[k].enable));
    lbadd(lb, 'registrationTime' + #9 + inttostr(cwUsers[k].registrationTime));
    lbadd(lb, 'lastLoginTime' + #9 + inttostr(cwUsers[k].lastLoginTime));
    lbadd(lb, 'leverage' + #9 + inttostr(cwUsers[k].leverage));
    lbadd(lb, 'balance' + #9 + floattostr(cwUsers[k].balance));
    lbadd(lb, 'balPrevMonth' + #9 + floattostr(cwUsers[k].balancePreviousMonth));
    lbadd(lb, 'balPrevDay' + #9 + floattostr(cwUsers[k].balancePreviousDay));
    lbadd(lb, 'credit' + #9 + floattostr(cwUsers[k].credit));
    lbadd(lb, 'interestrate' + #9 + floattostr(cwUsers[k].interestrate));
    lbadd(lb, 'taxes' + #9 + floattostr(cwUsers[k].taxes));
    lbadd(lb, 'name' + #9 + cwUsers[k].name);
    lbadd(lb, 'country' + #9 + cwUsers[k].country);
    lbadd(lb, 'city' + #9 + cwUsers[k].city);
    lbadd(lb, 'state' + #9 + cwUsers[k].State);
    lbadd(lb, 'zipcode' + #9 + cwUsers[k].zipcode);
    lbadd(lb, 'address' + #9 + cwUsers[k].address);
    lbadd(lb, 'phone' + #9 + cwUsers[k].phone);
    lbadd(lb, 'email' + #9 + cwUsers[k].email);
    lbadd(lb, 'soc.number' + #9 + cwUsers[k].socialNumber);
    lbadd(lb, 'comment' + #9 + cwUsers[k].comment);
    lbadd(lb, 'totalTrades' + #9 + inttostr(cwUsersPlus[k].totaltrades));
    lbadd(lb, 'totalProfit' + #9 + FormatFloat('#,0.00', cwUsersPlus[k].totalprofit));
    lbadd(lb, 'totalBalance' + #9 + FormatFloat('#,0.00', cwUsersPlus[k].totalbalance));

    lblUserInfo0.Caption := cwUsers[k].name;
    lblUserInfo1.Caption := 'Reg.Date:  ' + datetimetostr(UnixToDateTime(cwUsers[k].registrationTime));
    lblUserInfo2.Caption := 'LastLogin: ' + datetimetostr(UnixToDateTime(cwUsers[k].lastLoginTime));
    lblUserInfo3.Caption := 'Balance:   ' + FormatFloat('#,0.00', cwUsers[k].balance);
    lblUserInfo4.Caption := 'T.Trades:  ' + inttostr(cwUsersPlus[k].totaltrades);
    lblUserInfo5.Caption := 'T.Balance: ' + FormatFloat('#,0.00', cwUsersPlus[k].totalbalance);
    lblUserInfo6.Caption := 'T.Profit:  ' + FormatFloat('#,0.00', cwUsersPlus[k].totalprofit);
    lblUserInfo7.Caption := inttostr(cwUsers[k].userId);

    lblUserInfo0.Hint := 'Users Name';
    lblUserInfo1.Hint := 'Registration Time';
    lblUserInfo2.Hint := 'Last Login Time';
    lblUserInfo3.Hint := 'Balance';
    lblUserInfo4.Hint := 'Total Trades';
    lblUserInfo5.Hint := 'Total Balance';
    lblUserInfo6.Hint := 'Total Profit';
    lblUserInfo7.Hint := 'UserID';

    lblUserInfo0.ShowHint := true;
    lblUserInfo1.ShowHint := true;
    lblUserInfo2.ShowHint := true;
    lblUserInfo3.ShowHint := true;
    lblUserInfo4.ShowHint := true;
    lblUserInfo5.ShowHint := true;
    lblUserInfo6.ShowHint := true;
    lblUserInfo7.ShowHint := true;
  end;

  procedure TForm2.StartHTTPWorker();
  var
    s: string;
  begin
    try
      HTTPWorker1 := THTTPWorker.Create();
      HTTPWorker1.OnTerminate := HTTPOnTerminate;
      HTTPWorker1.ResultList := TStringList.Create;
      HTTPWorker1.RequestBusy := false;
      HTTPWorker1.machfehler := false;
      HTTPWorker1Aktiv := true;

    except
      on E: Exception do
        s := E.ToString;
    end;

  end;

  procedure TForm2.HTTPOnTerminate(Sender: TObject);
  begin
    // debug('terminated');
    if HTTPWorker1Aktiv = true then
    begin
      // der Thread sollte eigentlich laufen - also wieder starten
      // StartHTTPWorker;
      lbLoadInfo.Items.Add('HTTPWorker Thread terminated');
    end;

  end;

  procedure TForm2.infoTimerTimer(Sender: TObject);
  var
    s: string;
    sec: integer;
    rest: double;
    s2: string;
  begin
    rest := (trunc(updateTimer.Interval / 1000)) - (now - updateTimerStarted) * 86400; // Rest in sekunden
    s := FormatDateTime('nn:ss', rest / 86400);
    s2 := FormatDateTime('nn:ss', (GetTickCount - lastUserActivity) / 1000 / 86400);
    // lblInfoTimer.caption:=inttostr(nextUpdateT
    lblUpdateRest.Caption := 'Next Update:' + s + ' User Off:' + s2;
    if (GetTickCount - lastUserActivity) > 120000 then // 2 Minuten kein Usereingriff -> Update kann durchgef�hrt werden
    begin
      // 2 Minuten keine Usereingabe - update anklicken
      if (askFinishUpdate = true) then
      begin
        Dialog2.fdialog2.btnFinishUpdateClick(nil); // Update durchf�hren
        btnSaveCacheFileCwClick(nil);
      end;
    end;
  end;

  procedure TForm2.Label3Click(Sender: TObject);
  begin
    doGroup;
  end;

  procedure TForm2.lbCSVErrorDblClick(Sender: TObject);
  begin
    lbCSVError.Items.clear;
  end;

  procedure TForm2.lbDebug2DblClick(Sender: TObject);
  begin
    lbDebug2.Items.clear;
  end;

  procedure TForm2.lblUpdateRestClick(Sender: TObject);
  begin
    //
    updateTimerTimer(nil);

  end;

  procedure TForm2.lblUpdateRestDblClick(Sender: TObject);
  var
    s: string;
    dt: TDateTime;
  begin
    // Update timer
    s := inputbox('Manual update', 'Time to update from', datetimetostr((now - 0.25)));
    if (s = '') then
      exit;
    dt := strtodatetime(s);

    updateTimerStarted := now;
    if (updateStatus > 0) then
      if (updateGoing = true) then
      begin
        updateGoing := false;
        updateStatus := 0;
      end;

    if (updateGoing = false) then
    begin
      Dialog2.fdialog2.btnFinishUpdate.Visible := false;
      askFinishUpdate := false;
      doUpdate(dt);
      // btnUpdateDataClick(nil);
    end;
  end;

  function TForm2.doHttpPutMemoryStreamToWorker(mStream: TMemoryStream; url: string): integer;
  // hier muss einfach zwangsweise gewartet werden bis der Thread seine Arbeit beendet hat
  begin

    // wenn der Worker bereits arbeitet dann warten ..
    while (HTTPWorker1.RequestBusy = true) do
    begin
      dosleep(100);
    end;

    // und nun Vorbereitungen treffen
    EnterCriticalSection(HTTPWorkCriticalSection);
    HTTPWorker1.ct := HTTPWorker1.ct + 1;
    // debugThread(inttostr(HTTPWorker1.ct) + ' HTTPWorker1. MS Request Start:' + Url);
    HTTPWorker1.url := url;
    HTTPWorker1.SendString := '';
    HTTPWorker1.HError := 0;
    HTTPWorker1.SendType := 2;
    // 1=JSONString  2=MemoryStream  3=get(todo)
    HTTPWorker1.RequestBusy := true;
    HTTPWorker1.MemoryStream := mStream;
    HTTPWorker1.Caption := 'HTTPWorker1';
    // HTTPWorker1.bArray hier nicht ben�tigt - w�re beim Abruf von Daten notwendig
    leaveCriticalSection(HTTPWorkCriticalSection);
    // damit sind die Variablen gesetzt und der Thread kann ab jetzt arbeiten
    while (HTTPWorker1.RequestBusy = true) do
    begin
      // an dieser Stelle k�nnte da eventgesteuert ein Actionupdate erfolgen und damit wird nochmals hier reingesprungen !
      // ansonsten einfach warten und zB weiterhin Ticks empfangen (dehalb ja der ganze Threadaufwand)
      dosleep(100);
    end;
    // debugThread(inttostr(HTTPWorker1.ct) + ' HTTPWorker1. MS Request Ende:' + Url);
    // in HTTWorkerResultList stehen die Meldungen
    result := HTTPWorker1.HError; // hier noch was anders machen !
  end;

  function TForm2.doHttpGetByteArrayFromWorker(var bArray: Bytearray; url: string; var sErr: string): integer;
  var
    flag: integer;
    gt, ngt: cardinal;

    li: integer;
    liText: array [1 .. 10] of string;

  begin
    // wenn der Worker noch was macht ... warten !
    while (HTTPWorker1.RequestBusy = true) do
    begin
      dosleep(CSleep);
    end;

    EnterCriticalSection(HTTPWorkCriticalSection);
    HTTPWorker1.ct := HTTPWorker1.ct + 1;
    // debugThread(inttostr(HTTPWorker1.ct) + ' HTTPWorker1. S Request Start:' + Url);
    HTTPWorker1.url := url;
    HTTPWorker1.SendString := ''; // hier nicht
    HTTPWorker1.HError := 0;
    HTTPWorker1.SendType := 3; // 1=Put String  2=Put MemoryStream     3=Get ByteArray
    HTTPWorker1.RequestBusy := true;
    HTTPWorker1.Caption := 'HTTPWorker1';
    HTTPWorker1.bArray := bArray;
    HTTPWorker1.ResultList.clear;
    // das array wird an den Worker �bergeben und dieser bef�llt es

    leaveCriticalSection(HTTPWorkCriticalSection);
    // damit sind die Variablen gesetzt und der Thread kann ab jetzt arbeiten
    flag := 0;
    lblWarten.Caption := '********************';
    liText[1] := 'Beim ersten Laden der Actions wird ein Cache angelegt';
    liText[2] := 'Dieser sorgt sp�ter f�r einen schnellen Programmstart';
    liText[3] := 'Das erste Laden aller �ber 3 Millionen Actions ...';
    liText[4] := 'kann je nach Leitung etliche Minuten dauern';
    liText[5] := 'Es kann sich nur noch um Minuten handeln ... noch etwas Geduld !';
    liText[6] := 'Es wurden inzwischen ' + inttostr(length(cwSymbols)) + ' Symbole geladen';
    liText[7] := 'Es wurden inzwischen ' + inttostr(length(cwUsers)) + ' User geladen';
    liText[8] := 'Es wurden inzwischen ' + inttostr(length(cwComments)) + ' Kommentare geladen';
    liText[9] := '';
    gt := GetTickCount;
    ngt := gt + 1000;
    li := 0;
    while (HTTPWorker1.RequestBusy = true) do
    begin
      // der Unterhaltungsteil ...
      gt := GetTickCount;
      dosleep(CSleep);
      if flag < 20 then
      begin
        inc(flag);
        lblWarten.Caption := '*' + lblWarten.Caption;
      end
      else
      begin
        flag := 0;
        if HTTPWorker1.Finished then
          lblWarten.Caption := '?' + lblWarten.Caption
        else
          lblWarten.Caption := '>' + lblWarten.Caption;
      end;
      lblWarten.Caption := leftstr(lblWarten.Caption, 20);
      if gt > ngt then
      begin
        li := li + 1;
        if (li < high(liText)) then
        begin
          if liText[li] = '' then
            // li := 1;
            Memo1.lines.clear;
          Memo1.lines.Add(liText[li]);
          Dialog2.fdialog2.info2(liText[li]);
          liText[li] := '';
          // damit es nur am Anfang einmal angezeigt wird
        end
        else
        begin
          Memo1.lines.clear;
          Dialog2.fdialog2.info2('');
        end;

        ngt := gt + 8000;

      end;
    end;
    // debugThread(inttostr(HTTPWorker1.ct) + 'HTTPWorker1. S Request Ende:' + Url);
    // Nun ist der Worker mit seiner Arbeit fertig
    lblWarten.Caption := 'Loading Finished';
    Memo1.lines.clear;
    // in HTTPWorker1.ResultList stehen die Meldungen
    // diese werden hier �berhaupt nicht ausgewertet
    bArray := HTTPWorker1.bArray;
    result := HTTPWorker1.HError; // hier noch was anders machen !
    sErr := HTTPWorker1.ResultList.CommaText;
  end;

  procedure TForm2.dosleep(t: integer);
  var
    gt: cardinal;
  begin
    gt := GetTickCount();
    repeat
      Application.ProcessMessages;
    until (GetTickCount - gt) > t;
    // lbstatisticsPumpAdd('sleep rum:' + inttostr(t));
  end;

  procedure TForm2.FormResize(Sender: TObject);
  var
    Msg: TWMMove;
    i: integer;
  begin
    // �ber align nicht mehr n�tig

    // PageControl1.Width := Form2.Width - pnlIcons.Width;
    // PageControl1.Top := -30;
    // PageControl1.Height := Form2.Height + 30;
    // if (claus = true) then
    // PageControl1.Top := -20;

    if Form2.Width < 200 then
      Form2.Width := 200;
    if Form2.Height < 100 then
      Form2.Height := 100;

    OnMove(Msg); // damit Dialog richtig platziert wird

    if (Form2ResizeSimuliert = false) then
      // nicht bei der 'unechten' +1 -1 Resize Aktion die per Programm ausgef�hrt wird
      for i := 0 to 10 do
      begin
        TabToResize[i] := true;
      end;

  end;

  procedure TForm2.Button4Click(Sender: TObject);
  begin
    StartHTTPWorker;
  end;

  procedure TForm2.Button5Click(Sender: TObject);
  // Save as filter
  var
    s: string;
  begin
    s := inputbox('Save Filters to File', 'Filter Topic', '');
    if (s = '') then
      exit;

    if (testfilename(s)) = true then
    begin
      saveFilters(s);
      fillCbLoadFilters;
    end
    else
      showmessage('Filename contains illegal characters! Dont use any of these /\:*?"<>');

  end;

  procedure TForm2.fillCbLoadFilters;
  var
    s, s1: string;
    p: integer;
    LSearchOption: TSearchOption;
    LList: TStringDynArray;
  begin
    LSearchOption := TSearchOption.soTopDirectoryOnly;
    LList := TDirectory.Getfiles(GetCurrentDir, '*.flt', LSearchOption);
    cbLoadFilters.Items.clear;
    cbLoadFilters.Items.BeginUpdate;
    try
      for s in LList do
      begin
        p := rinstr(s, '\');
        s1 := midstr(s, p + 1, length(s) - p - 4);

        cbLoadFilters.Items.Add(s1);
      end;
    finally
      cbLoadFilters.Items.EndUpdate;
    end;
    cbLoadFilters.text := '';
  end;

  // Trackbar.Position must run at range 1-255...
  procedure TForm2.fillStartScreen;
  begin
    twoLblStart[1].l1.Caption := 'Users total:';
    twoLblStart[2].l1.Caption := 'Actions total:';
    twoLblStart[3].l1.Caption := 'Users online:';
    twoLblStart[4].l1.Caption := 'Open Actions:';
    twoLblStart[5].l1.Caption := 'New Users 1 Week:';
    twoLblStart[6].l1.Caption := 'New Users 1 Month:';
    twoLblStart[7].l1.Caption := 'New Actions today:';
    twoLblStart[8].l1.Caption := 'New Actions 1 Week:';
    twoLblStart[9].l1.Caption := 'Profit today:';
    twoLblStart[10].l1.Caption := 'Profit 1 Week:';
    twoLblStart[11].l1.Caption := 'Logged Users 1 day:';
    twoLblStart[12].l1.Caption := 'Logged Users 1 week:';
    twoLblStart[13].l1.Caption := 'Logged Users 1 month:';
    twoLblStart[14].l1.Caption := 'Closed Actions Day/Week/Month/Year:';

    twoLblStart[1].l2.Caption := inttostr(length(cwUsers));
    twoLblStart[2].l2.Caption := inttostr(length(cwActions));
    // 'Actions total:';
    twoLblStart[3].l2.Caption := inttostr(info.usersonline); // '...';//'Users online:';
    twoLblStart[4].l2.Caption := inttostr(info.openActions); // ''/'Open Actions:';
    twoLblStart[5].l2.Caption := inttostr(info.newUsers1w); // ''/'New Users 1 week:';
    twoLblStart[6].l2.Caption := inttostr(info.newUsers1m); // ''/'New Users 1 month:';
    twoLblStart[7].l2.Caption := inttostr(info.newActions1d); // ''/'Actions new today:';
    twoLblStart[8].l2.Caption := inttostr(info.newActions1w); // ''/'Actions 1 week:';
    twoLblStart[9].l2.Caption := FormatFloat('#,0.00', info.profit1d); // ''/'Profit today:';
    twoLblStart[10].l2.Caption := FormatFloat('#,0.00', info.profit1w); // ''/'Profit 1 week:';
    twoLblStart[11].l2.Caption := inttostr(info.logUsers1d); // ''/'Actions new today:';
    twoLblStart[12].l2.Caption := inttostr(info.logUsers1w); // ''/'Actions new today:';
    twoLblStart[13].l2.Caption := inttostr(info.logUsers1m); // ''/'Actions new today:';
    twoLblStart[14].l2.Caption := info.ctHWMY; // ''/'Actions new today:';
    pnlStart.Refresh;
  end;

  procedure TForm2.computeStartScreen;

  // tInfo=record
  // usersOnline: integer;
  // openActions:integer;
  // newUsers1w:integer;
  // newUsers1m:integer;
  // newActions1d:integer;
  // newActions1w:integer;
  // newActions1m:integer;
  // profit1d:double;
  // profit1w:double;
  // profit1m:double;
  // end;

  var
    i: integer;
    t: TDateTime;
    ut: integer;
    dt: integer;
    gt: cardinal;
    unow: integer;
    startHeute: integer;
    // jeweils in Unix umgerechnet
    startMontag: integer;
    startMonat: integer;
    startJahr: integer;
    dow, dom, doy: integer;
    ctHeute, ctWoche, ctMonat, ctJahr: integer;
    doffset: integer;
  const
    c1 = 86400;
    c7 = 86400 * 7;
    c30 = 86400 * 30;
  begin
    gt := GetTickCount;
    t := now;
    ut := datetimetounix(t);
    dow := dayofweek(t); // 1=So
    // Offset auf Montag
    doffset := dow - 2;
    if (doffset < 0) then
      doffset := doffset + 7;
    dom := DayOfTheMonth(t);
    doy := DayOfTheYear(t);
    unow := datetimetounix(now); // JETZT damit die bl�den Zukunftswerte wegfallen
    startHeute := datetimetounix(int(t));
    startMontag := datetimetounix(int(t) - doffset);
    startMonat := datetimetounix(int(t) - dom + 1);
    startJahr := datetimetounix(int(t) - doy + 1);

    info.newUsers1d := 0;
    info.newUsers1w := 0;
    info.newUsers1m := 0;
    info.newUsers1y := 0;
    info.logUsers1d := 0;
    info.logUsers1w := 0;
    info.logUsers1m := 0;
    info.logUsers1y := 0;
    info.newActions1d := 0;
    info.newActions1w := 0;
    info.newActions1m := 0;
    info.newActions1y := 0;
    info.profit1d := 0;
    info.profit1w := 0;
    info.profit1m := 0;
    info.profit1y := 0;
    info.openActions := 0;
    for i := 0 to cwusersct - 1 do
    begin
      dt := cwUsers[i].registrationTime;
      if (dt > startHeute) then
        inc(info.newUsers1d);
      if (dt > startMontag) then
        inc(info.newUsers1w);
      if (dt > startMonat) then
        inc(info.newUsers1m);
      if (dt > startJahr) then
        inc(info.newUsers1y);

      dt := cwUsers[i].lastLoginTime;
      if (dt > startHeute) then
        inc(info.logUsers1d);
      if (dt > startMontag) then
        inc(info.logUsers1w);
      if (dt > startMonat) then
        inc(info.logUsers1m);
      if (dt > startJahr) then
        inc(info.logUsers1y);

    end;
    ctHeute := 0;
    ctWoche := 0;
    ctMonat := 0;
    ctJahr := 0;
    for i := 0 to cwactionsct - 1 do
    begin

      dt := cwActions[i].openTime;
      if (dt > startHeute) then
        inc(info.newActions1d);
      if (dt > startMontag) then
        inc(info.newActions1w);
      if (dt > startMonat) then
        inc(info.newActions1m);
      if (dt > startJahr) then
        inc(info.newActions1y);

      if (cwActions[i].typeId < 7) then // balance(7) und credit(8)
      begin
        dt := cwActions[i].closeTime;
        // offene Orders weisen immer einen momentanen Profit aus
        if (cwActions[i].closeTime > 0) then
        begin
          if (dt < unow) then
          begin
            if (dt > startHeute) then
            begin
              info.profit1d := info.profit1d + cwActions[i].profit;
              inc(ctHeute);
            end;
            if (dt > startMontag) then
            begin
              info.profit1w := info.profit1w + cwActions[i].profit;
              inc(ctWoche);
            end;
            if (dt > startMonat) then
            begin
              info.profit1m := info.profit1m + cwActions[i].profit;
              inc(ctMonat);
            end;
            if (dt > startJahr) then
            begin
              info.profit1y := info.profit1y + cwActions[i].profit;
              inc(ctJahr);
            end;

          end;
        end
        else
          inc(info.openActions);

      end;
      info.ctHWMY := inttostr(ctHeute) + '/' + inttostr(ctWoche) + '/' + inttostr(ctMonat) + '/' + inttostr(ctJahr);
    end;
    if (makeLabelsDone = false) then
    begin

      makeLabelsDone := true;
      makelabels;

    end;
    fillStartScreen;
    lbCSVDebug('ComputeStartScreen:' + inttostr(GetTickCount - gt));
  end;

  procedure TForm2.MyExceptionHandler(Sender: TObject; E: Exception);
  var
    s: string;
  begin
    s := E.Message;
    // MessageDlg('ERROR: ' +s);

    showmessage('MyExHandler Error:' + s);
    s := '';
  end;

end.
