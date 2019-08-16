{$RANGECHECKS ON}
unit FlowAnalyzer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.strutils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, FTCommons, Vcl.StdCtrls, Vcl.Grids,
  Vcl.ExtCtrls, StringGridSorted, Vcl.CheckLst, ClipBrd, filterElement, FilterControl, MMSystem, HTTPWorker, FTTypes,
  Vcl.Themes, UDynGrid, GroupControl, DateUtils, Vcl.AppEvnts, uTwoLabel, Vcl.Buttons;
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
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet5: TTabSheet;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    TabSheet1: TTabSheet;
    Panel26: TPanel;
    Panel34: TPanel;
    Panel36: TPanel;
    lblFilterResult: TLabel;
    btnDoubleRemoveCw: TButton;
    btnSelectClearCw: TButton;
    Button5: TButton;
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
    DynGrid1: TDynGrid;
    Button7: TButton;
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
    lbCSVError: TListBox;
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
    procedure getSymbolsUsersComments(useCache: boolean);

    procedure btnGetCsvClick(Sender: TObject);
    procedure GetCsv(url, typ: string; lb: TListBox; append: boolean; tryCache: boolean);
    procedure btnCwSymbolsToGridClick(Sender: TObject);
    procedure btnCwactionsToGridClick(Sender: TObject);
    procedure btnCwusersToGridClick(Sender: TObject);
    procedure btnCwCommentsToGridClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGetBinDataClick(Sender: TObject);
    function GetBinData(url, typ: string; lb: TListBox; append: boolean): integer;
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
    procedure gridMouseClickHandler(grid: FTCommons.TStringGridSorted; col, row: integer; sCell, sCol, sRow: string;
      Button: TMouseButton; Shift: TShiftState; source: string);
    procedure btnGetSingleUserActionsClick(Sender: TObject);
    procedure TabSheet2Resize(Sender: TObject);
    procedure btnDoFilterClick(Sender: TObject);

    procedure Button5Click(Sender: TObject);
    procedure edSingleUserActionsIdChange(Sender: TObject);
    procedure CategoryPanel1Collapse(Sender: TObject);
    procedure CategoryPanel1Expand(Sender: TObject);
    procedure remeasureCategoryPanels(c1: TCategoryPanelGroup);
    procedure StartHTTPWorker;
    procedure HTTPOnTerminate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    function doHttpGetByteArrayFromWorker(var bArray: Bytearray; url: string): integer;
    procedure dosleep(t: integer);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure btnSampleClick(Sender: TObject);
    procedure doFilter();
    procedure doGroup();
    procedure Button2Click(Sender: TObject);
    procedure lbCSVErrorClick(Sender: TObject);
    procedure cbStylesChange(Sender: TObject);
    // procedure gridHandler(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure btnUpdateDataClick(Sender: TObject);
    procedure PageControl1DrawTab(Control: TCustomTabControl; TabIndex: integer; const Rect: TRect; Active: boolean);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: boolean);
    procedure btnDoUsersAndSymbolsPlusClick(Sender: TObject);
    procedure CategoryPanel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure CategoryPanelGroup1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure zeigUserInfo(id: integer; lb: TListBox);
    procedure btnSymbolGroupsClick(Sender: TObject);
    procedure btnOnePageClick(Sender: TObject);
    procedure doSymbolGroups(quelle: string; var actions: DACwAction; var actionsPlus: DACwActionPlus;
      var groups: DACwSymbolGroup; var groupsCt: integer; lb: TListBox);
    procedure doSymbolGroupValues(quelle: string; var actions: DACwAction; var actionsPlus: DACwActionPlus;
      var groups: DACwSymbolGroup; var groupsCt: integer; lb: TListBox);

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
    procedure machUserSelection();
    procedure DynGrid10SGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);

    procedure dyngridMouseLeftClickHandler(topic: string; grid: FTCommons.TStringGridSorted; col, row: integer;
      sCell, sCol, sRow: string);
    procedure btnLadeDialogClick(Sender: TObject);
    // procedure TrackBar1Change(Sender: TObject);   für semitransparentes Form verwendet
    procedure ApplicationEvents1ModalBegin(Sender: TObject);
    procedure ApplicationEvents1ModalEnd(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure Button10Click(Sender: TObject);
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
    procedure SpeedButton6Click(Sender: TObject);
    procedure infoTimerTimer(Sender: TObject);
  private
    { Private-Deklarationen }
    FColorKey: TCOLOR;
  public
    { Public-Deklarationen }
  end;

var
  Form2: TForm2;
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
  updateGoing:boolean;
implementation

{$R *.dfm}

uses doHTTP, Dialog1, Dialog2;

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;
{$SETPEFLAGS IMAGE_FILE_LARGE_ADDRESS_AWARE}

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

function TForm2.GetBinData(url, typ: string; lb: TListBox; append: boolean): integer;
// kann actions symbols und ticks binär abrufen
// die users symbols gibt es noch nicht !
var
  ret: String;
  gt: Cardinal;
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
begin
  gt := GetTickCount;
  // bytes := doHTTPGetByteArray(url, lb);
  // über einen zweiten Thread werden die Daten abgerufen
  res := doHttpGetByteArrayFromWorker(bytes, url);
  lbDebug2.Items.Add('Zeit GetUrl:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));

  if typ = 'actions' then
  begin
    // nur wenn es sich um binäre actions handelt !
    // Bytes->cwActions
    i := SizeOf(cwAction);
    sz := trunc(length(bytes) / i);
    // Problem: es gibt bei den CloseTime Abrufen leider ca 11 actions deren Datum in der Zukunft liegt
    // und die deshalb in Wahrheit gar nicht neu sind !
    if ((sz > 0) and (sz < 20)) then
    begin
      gt := GetTickCount;
      setlength(aneu, sz);
      move(bytes[0], aneu[0], length(bytes));
      alt := 0;
      for i := 0 to sz - 1 do
      begin
        for l := 0 to length(cwactions) - 1 do
        begin
          if (aneu[i].actionId = cwactions[l].actionId) then
            if (aneu[i].closeTime = cwactions[l].closeTime) then
            begin
              inc(alt);
              break;
            end;
        end;
      end;
      lbCSVError.Items.Add('Check:' + inttostr(GetTickCount - gt));
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
        // die neuen Actions an die alten anhängen
        oldlen := length(cwactions);
        setlength(cwactions, length(cwactions) + sz);
        setlength(cwActionsPlus, length(cwActionsPlus) + sz);
        move(bytes[0], cwactions[oldlen], length(bytes));
      end
      else
      begin
        setlength(cwactions, sz);
        setlength(cwActionsPlus, sz);
        move(bytes[0], cwactions[0], length(bytes));
      end;
      lbDebug2.Items.Add('New/Changed actions:' + inttostr(sz));
      lbDebug2.Items.Add('Zeit move->actions:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));
      lbDebug2.Items.Add('Anzahl Actions:' + inttostr(sz));
      lblCwActionsLength.Caption := 'CwActions:' + inttostr(length(cwactions));
      btnCwactionsToGridClick(nil);
      result := sz;
    end
    else
    begin
      lbCSVError.Items.Add('No new actions');
      result := 0;
    end;;
    // for j := 0 to sz - 1 do
    // begin
    // lbDebug2.Items.Add(inttostr(j) + ' ' + inttostr(cwActions[j].actionId) + ' ' + inttostr(cwActions[j].userId) + ' '
    // + inttostr(cwActions[j].symbolId));
    // if j > 100 then
    // break;
    // end;
    // lbDebug2.Items.Add('...');
    // // ss := byteArrayToString(bytes);

  end;

  // die folgenden Routinen sind nicht anwendbar da durch dieVerwendung von Strings kein bin-Lesen mehr möglich ist
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
  // SetLength(cwsymbolsSortindex, 0); // zurücksetzen
  // move(bytes[0], cwSymbols[0], length(bytes));
  // lbDebug2.Items.Add('Zeit move->symbol:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));
  // lbDebug2.Items.Add('Anzahl Symbols:' + inttostr(sz));
  // for j := 0 to sz - 1 do
  // begin
  // lbDebug2.Items.Add(inttostr(j) + ' ' + cwSymbols[j].name + ' ' + inttostr(cwSymbols[j].symbolId) + ' ' +
  // inttostr(cwSymbols[j].brokerId));
  // if j > 100 then
  // break;
  // end;
  // lbDebug2.Items.Add('...');
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
  // SetLength(cwUsersSortindex, 0); // zurücksetzen
  // SetLength(cwUsersSortindex2, 0); // zurücksetzen
  // move(bytes[0], cwUsers[0], length(bytes));
  // lbDebug2.Items.Add('Zeit move->user:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));
  // lbDebug2.Items.Add('Anzahl users:' + inttostr(sz));
  // for j := 0 to sz - 1 do
  // begin
  // lbDebug2.Items.Add(inttostr(j) + ' ' + cwUsers[j].name + ' ' + inttostr(cwUsers[j].userId) + ' ' +
  // inttostr(cwUsers[j].accountId));
  // if j > 100 then
  // break;
  // end;
  // lbDebug2.Items.Add('...');
  //
  // end;

  setlength(bytes, 0)
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

var
  gt: Cardinal;
  fileName: string;
  fileMode: integer;
  bytes: Bytearray;
  s: AnsiString;
  ms: TMemoryStream;
  bpms: integer;
  Stream: TFileStream;
  ok: boolean;
  res: integer;
begin
  gt := GetTickCount;

  ok := false;
  if (tryCache = true) then
  begin
    fileName := ExtractFilePath(paramstr(0)) + 'cachecw\' + typ + '.csv';
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
        cwsymbolsct := length(cwSymbols);
      setlength(cwSymbolsPlus, cwsymbolsct);

      begin

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
  begin

    // bytes := doHTTPGetByteArray(url, lbCSVError);
    res := doHttpGetByteArrayFromWorker(bytes, url);

    bpms := trunc(length(bytes) / (GetTickCount - gt));

    lb.Items.Add('CSV-Load:' + url);
    lb.Items.Add('Z:get :' + inttostr(GetTickCount - gt));
    lb.Items.Add('bpms:' + inttostr(bpms));
    gt := GetTickCount;
    // bei CSV-Dateien muss UTF8-decodiert werden damit die Umlaute passen
    SetString(s, PAnsiChar(@bytes[0]), high(bytes) + 1);
    s := UTF8Decode(s); // -> der String ist jetzt ok

    // den UTF8-decodierten AnsiString wieder als Bytearray
    setlength(bytes, length(s));
    move(Pointer(s)^, Pointer(bytes)^, length(s));
    lb.Items.Add('Z:UTF8 :' + inttostr(GetTickCount - gt));

    gt := GetTickCount;
    ms := TMemoryStream.Create;

    ms.WriteBuffer(bytes[0], high(bytes) + 1);
    ms.Position := 0;
    lb.Items.Add('Z:MStream :' + inttostr(GetTickCount - gt));

    lb.Items.Add('Bytes gelesen:' + inttostr(length(s)));

    if typ = 'symbols' then
    begin
      // die Bytes in eine Datei schreiben
      try
        fileName := ExtractFilePath(paramstr(0)) + 'cachecw\symbols.csv';
        fileMode := fmCreate;
        Stream := TFileStream.Create(fileName, fileMode);
        Stream.WriteBuffer(bytes[0], high(bytes) + 1);
        Stream.free; // Speicher freigeben
      except
        lbCSVError.Items.Add('F:writeUsersStream');
      end;

      // Stream := TFileStream.Create(fileName, fmOpenRead or fmShareDenyNone);
      // stream.Position:=0;
      // ParseDelimited('symbols', lb, s, #13 + #10, cwUsers, cwSymbols, cwTicks, cwComments, stream, append);

      // // hier sind Grenzen gesetzt - bei 1.2 mio Kursen zB StackOverflow
      // n := trunc(Stream.Size / SizeOf(trade));
      // if (n > 50000) then
      // begin
      // debug('zu viele Orders:' + inttostr(n) + ' -> 50000 begrenzt');
      // n := 50000;
      // end;
      // SetLength(trades, n);
      // Stream.Position := (Stream.Size - n * SizeOf(trade));
      // Stream.ReadBuffer(trades[0], n * SizeOf(trade)); // nicht die ganze stream.size !

      ParseDelimited('symbols', lb, s, #13 + #10, cwUsers, cwSymbols, cwTicks, cwComments, ms, append);
      cwsymbolsct := length(cwSymbols);
      setlength(cwSymbolsPlus, cwsymbolsct);

    end;

    if typ = 'users' then
    begin
      // die Bytes in eine Datei schreiben
      try
        fileName := ExtractFilePath(paramstr(0)) + 'cachecw\users.csv';
        fileMode := fmCreate;
        Stream := TFileStream.Create(fileName, fileMode);
        Stream.WriteBuffer(bytes[0], high(bytes) + 1);
        Stream.free; // Speicher freigeben
      except
        lbCSVError.Items.Add('F:writeUsersStream');
      end;
      ParseDelimited('users', lb, s, #13 + #10, cwUsers, cwSymbols, cwTicks, cwComments, ms, append);
      cwusersct := length(cwUsers);
      setlength(cwUsersPlus, cwusersct);
    end;

    if typ = 'comments' then
    begin
      // die Bytes in eine Datei schreiben
      try
        fileName := ExtractFilePath(paramstr(0)) + 'cachecw\comments.csv';
        fileMode := fmCreate;
        Stream := TFileStream.Create(fileName, fileMode);
        Stream.WriteBuffer(bytes[0], high(bytes) + 1);
        Stream.free; // Speicher freigeben
      except
        lbCSVError.Items.Add('F:writeCommentsStream');
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
  ms.free;

end;

procedure TForm2.gridMouseClickHandler(grid: FTCommons.TStringGridSorted; col, row: integer; sCell, sCol, sRow: string;
  Button: TMouseButton; Shift: TShiftState; source: string);
// die alte Routine für die normalen Grids
var
  colHeader: string;
  pName: string;
  i: integer;
begin
  // showmessage('Grid:' + grid.name + ' cell:' + sCell + ' col:' + sCol + ' row:' + sRow);
  colHeader := grid.Cells[col, 0];
  pName := grid.Parent.Parent.name;
  // die dynGrid heissen alle SG

  // bei cwusers jeder Click in eine Zeile -> user actions anzeigen
  if source = 'cwusers' then
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
      PageControl1.TabIndex := 2;
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

procedure TForm2.dyngridMouseLeftClickHandler(topic: string; grid: FTCommons.TStringGridSorted; col, row: integer;
  sCell, sCol, sRow: string);
// die alte Routine für die normalen Grids
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
      PageControl1.TabIndex := 2;
      btnGetSingleUserActionsClick(nil);
    end;

  end;
  if topic = 'users' then
  begin
    if colHeader = 'userId' then
    begin
      edSingleUserActionsId.text := grid.Cells[col, row];
      PageControl1.TabIndex := 2;
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
  id := strtoint(edSingleUserActionsId.text);
  fzmax := 10000;
  fz := -1;
  setlength(cwSingleUserActions, fzmax);
  setlength(cwSingleUserActionsPlus, fzmax);
  cwactionsct := length(cwactions);
  for i := 0 to cwactionsct - 1 do
  begin
    if cwactions[i].userId = id then
    begin
      fz := fz + 1;
      if fz >= (fzmax - 1) then
      begin
        fzmax := fzmax + 10000;
        setlength(cwSingleUserActions, fzmax);
        setlength(cwSingleUserActionsPlus, fzmax);
      end;
      cwSingleUserActions[fz] := cwactions[i];
    end;
  end;

  // application.messagebox('test1','test3');

  setlength(cwSingleUserActions, fz + 1);
  setlength(cwSingleUserActionsPlus, fz + 1);
  cwsingleuseractionsCt := fz + 1;

  zeigUserInfo(id, lbUserInfo);
  showmemory(lbUserInfo);

  DynGrid4.initGrid('cwsingleuseractions', 'userId', 1, length(cwSingleUserActions), 25);

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
  gt: Cardinal;
begin
  // Die drei Dateien vom Server abrufen: symbols user und comments
  gt := GetTickCount;
  edGetUrlCSV.text := 'http://h2827643.stratoserver.net:8080/csv/symbols';
  LoadInfo('Load Symbols...');
  GetCsv(edGetUrlCSV.text, 'symbols', lbCSVError, false, useCache);

  edGetUrlCSV.text := 'http://h2827643.stratoserver.net:8080/csv/users';
  LoadInfo('Load Users...');
  GetCsv(edGetUrlCSV.text, 'users', lbCSVError, false, useCache);

  edGetUrlCSV.text := 'http://h2827643.stratoserver.net:8080/csv/comments';
  LoadInfo('Load Comments...');
  GetCsv(edGetUrlCSV.text, 'comments', lbCSVError, false, useCache);
  lbCSVError.Items.Add('Load SymbolsUsersComments:' + inttostr(GetTickCount - gt));
end;

procedure TForm2.btnSymbolGroupsClick(Sender: TObject);
var
  nam: string;
begin

  doSymbolGroups('cwsymbolsgroups', cwactions, cwActionsPlus, cwSymbolsGroups, cwSymbolsGroupsCt, lbSymbolsGroupsInfo);
  doSymbolGroupValues('cwsymbolsgroups', cwactions, cwActionsPlus, cwSymbolsGroups, cwSymbolsGroupsCt,
    lbSymbolsGroupsInfo);
  DynGrid8.initGrid('cwsymbolsgroups', 'groupId', 1, cwSymbolsGroupsCt, 18);
  // nochmal die Symbol-Liste neu darstellen weil jetzt die Symbolgruppen drin sind
  btnCwSymbolsToGridClick(nil);

  // //das entfällt
  // if (nam = 'btnGroupSymbolsFilteredActions') then
  // begin
  // pnlPieButtons.Visible := true;
  // doSymbolGroups('cwfilteredsymbolsgroups', cwFilteredActions, cwFilteredActionsPlus, cwFilteredSymbolsGroups,
  // cwFilteredSymbolsGroupsct, SGCwSymbolsGroups, lbSymbolsGroupsInfo);
  // end;
end;

procedure TForm2.doSymbolGroups(quelle: string; var actions: DACwAction; var actionsPlus: DACwActionPlus;
  var groups: DACwSymbolGroup; var groupsCt: integer; lb: TListBox);
// aus den actions (alle oder eine Teilmenge) werden Symbolgruppen gebildet mit ähnlichen Namen
// die Symbolgruppe aller Actions ändert sich im Verlauf nicht
// die Symbolgruppe der Teilmenge von Actions ändert sich
var
  i, j, k: integer;
  s, smerk, smerk5, s5, s6: string;
  t, t2: TStringList;
  nam: string;
  found: integer;
  typ: integer;
  gt: Cardinal;
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

  // jetzt könnten noch spezielle Fälle eliminiert werden
  // HOil NGas OJ

  // wie soll man das nun rückwärts wieder Symbolen zuordnen ohne Missverständnisse ?
  // wieder 6 links abschneiden -> GER30A  - das wurde später zu GER30  Aber es gibt auch ein GE und ein GER (angenommen)
  // wenn das GE nun überprüft wird passen GE,GER und GER30A. Also ist GE das richtige weil es am kürzesten ist - ok ?
  // also ... 6 abschneiden und prüfen
  // wenn nix dann 5 abschneiden und prüfen
  // wenn aber Länge 1-4 gleich damit prüfen
  // von den geprüften den kürzesten Treffer verwenden

  // soll nun zu den Symbols eine SymbolGroupId gespeichert werden oder zu den SymbolGroups die SymbolIds ?
  // reicht eines davon ? Ist es nicht immer so daß im speziellen Array die Id des übergeordneten gespeichert wird ?

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
  lbCSVError.Items.Add('Z:Build SymbolGroups:' + inttostr(GetTickCount - gt));

  // damit sind die SymbolGroups ermittelt und können ab jetzt verwendet werden

  // Der Rest ist hinfällig weil künftig anders gelöst !
  // Problem: die Actions werden zwar selektiert verwendet aber die groups ist das 'große' Array mit allen Symbolen
  // - auch den in den selektierten Actions nicht verwendeten
  // die Zuordnung jedoch stimmt zwischen groups und cwsymbolsplus.
  // Lediglich die Summen stellen Teilsummen aus der Untergruppe der gefilterten Actions dar
  // die ganzen Werte können aus den actions gebildet werden (aufsummieren zB Volume) aber nicht direkt
  // die Anzahl verschiedener User
end;

procedure TForm2.doSymbolGroupValues(quelle: string; var actions: DACwAction; var actionsPlus: DACwActionPlus;
  var groups: DACwSymbolGroup; var groupsCt: integer; lb: TListBox);
var
  gt: Cardinal;
  ba: Bytearray;
  aba: array of Bytearray;
  i, j, ll, ct: integer;
begin
  gt := GetTickCount;
  computeSymbolGroupValues(actions, groups, lb);
  lbCSVError.Items.Add('Z:Get SymbolGroupsValues:' + inttostr(GetTickCount - gt));

  gt := GetTickCount;
  // User zählen über ein 2-dimensionales Riesenarray
  // aba = Array of ByteArray
  setlength(aba, groupsCt);
  ll := length(cwUsers);
  for i := 0 to groupsCt - 1 do
  begin
    setlength(aba[i], ll);
  end;
  // ganze Matrix nullsetzen
  for i := 0 to groupsCt - 1 do
    for j := 0 to length(cwUsers) - 1 do
      aba[i][j] := 0;
  lbCSVError.Items.Add('Z:Usercount vorbereiten:' + inttostr(GetTickCount - gt));

  gt := GetTickCount;
  for i := 0 to length(actions) - 1 do
  begin
    // alle Actions mit Gruppe/UserID in Matrix um 1 erhöhen
    // alte Variante
    // inc(aba[cwSymbolsPlus[cwActions[i].symbolId].groupId, finduserindex(actions[i].userId)]);
    try
      inc(aba[cwSymbolsPlus[cwactions[i].symbolId].groupId, actionsPlus[i].userIndex]);
    except
      on E: Exception do
        lbCSVError.Items.Add('Err doSymbolGroupValues:' + E.ToString);
    end;
  end;
  lbCSVError.Items.Add('Z:User einfüllen:' + inttostr(GetTickCount - gt));

  gt := GetTickCount;
  for i := 0 to groupsCt - 1 do
  begin
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

  lbCSVError.Items.Add('Z:Gruppen Userwerte zuordnen:' + inttostr(GetTickCount - gt));

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

  for i := 0 to length(cwactions) - 1 do
  begin
    if cwactions[i].actionId < max then

      merk[cwactions[i].actionId] := merk[cwactions[i].actionId] + 1;
  end;

  for i := 0 to max - 1 do
  begin
    if merk[i] > 1 then
    begin
      lbCSVError.Items.Add('Doppelte Order:' + inttostr(i) + ':' + inttostr(merk[i]));
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
  gt: Cardinal;
begin
  gt := GetTickCount;
  whichAccounts := '';
  Panel10.enabled := false;
  lbLoadInfo.Items.clear;
  Dialog2.FDialog2.lbLoadInfo.Items.clear;
  Dialog2.FDialog2.info('');
  all := true;
  for i := 0 to clbBrokers.Count - 1 do
  begin
    if clbBrokers.Checked[i] = false then
    begin
      all := false;
      break;
    end;
  end;
  if all = true then
  // wenn alle Broker angehakelt sind - was eigentlich sowieso immer der Fall sein dürfte
  begin
    if cbLoadActionsFromCache.Checked = true then
    begin
      // holt Symbols Users und Comments vom Cache oder wenn noch nicht vorhanden vom Server
      getSymbolsUsersComments(true);
      btnLoadCacheFileCwClick(nil);
      LoadInfo(inttostr(length(cwactions)) + ' Actions loaded from Cache');
    end
    else
    begin
      getSymbolsUsersComments(false); // holt vom Server
      LoadInfo('Load All Actions (wait!) ...');
      GetBinData('http://h2827643.stratoserver.net:8080/bin/actions', 'actions', lbCSVError, false);
      btnSaveCacheFileCwClick(nil);
      LoadInfo(inttostr(length(cwactions)) + ' Actions loaded from Server');
    end;
    LoadInfo('Loading data finished');
    whichAccounts := 'All accounts/';
  end
  else
  begin

    edGetUrlCSV.text := 'http://h2827643.stratoserver.net:8080/csv/symbols';
    LoadInfo('Load Symbols...');
    GetCsv(edGetUrlCSV.text, 'symbols', lbCSVError, false, true);
    LoadInfo(inttostr(length(cwSymbols)) + ' Symbols');

    // edGetUrlCSV.text := 'http://h2827643.stratoserver.net:8080/csv/users';
    // LoadInfo('Load Users...');
    // GetCsv(edGetUrlCSV.text,'users', lbCSVError, false,true);
    // LoadInfo(inttostr(length(cwUsers)) + ' Users');

    edGetUrlCSV.text := 'http://h2827643.stratoserver.net:8080/csv/comments';
    LoadInfo('Load Comments...');
    GetCsv(edGetUrlCSV.text, 'comments', lbCSVError, false, true);
    LoadInfo(inttostr(length(cwComments)) + ' Comments');

    appendBinActions := false;
    appendCSVUsers := false;
    for i := 0 to clbBrokers.Count - 1 do
    begin
      if clbBrokers.Checked[i] = true then
      begin
        whichAccounts := whichAccounts + clbBrokers.Items[i] + '/';
        LoadInfo('Load Users...');
        GetCsv('http://h2827643.stratoserver.net:8080/csv/users?accountId=' + inttostr(i + 1), 'users', lbCSVError,
          appendCSVUsers, false);
        appendCSVUsers := true; // ab dem 2.mal anhängen !
        LoadInfo(inttostr(length(cwUsers)) + ' Users');

        edGetUrlBin.text := 'http://h2827643.stratoserver.net:8080/bin/actions?accountId=' + inttostr(i + 1);
        LoadInfo('Load Actions...');
        GetBinData('http://h2827643.stratoserver.net:8080/bin/actions?accountId=' + inttostr(i + 1), 'actions',
          lbCSVError, appendBinActions);
        appendBinActions := true; // ab dem 2.mal anhängen !

        LoadInfo(inttostr(length(cwactions)) + ' Actions');

        LoadInfo('Loading finished');

      end

    end;

  end;

  // fillStartScreen;

  LoadInfo('Data preparations');
  whichAccounts := leftstr(whichAccounts, length(whichAccounts) - 1);
  lblAllDataInfo.Caption := whichAccounts + #13#10 + ' Users:' + inttostr(length(cwUsers)) + #13#10 + ' Symbols:' +
    inttostr(length(cwSymbols)) + #13#10 + ' Actions:' + inttostr(length(cwactions)) + #13#10 + #13#10;
  // ifthen(length(cwActions) <= maxActionsPerGrid, '', '[In Grid:' + inttostr(maxActionsPerGrid) + ']');

  TabSheet1.TabVisible := true; // Filter
  TabSheet6.TabVisible := true; // All Data
  TabSheet5.TabVisible := true; // User

  // TabSheet7.TabVisible := true; // SymbolsGroups

  dosleep(CSleep);
  doFinalizeData;

  Panel10.enabled := true;
  LoadInfo('Finished');
  Dialog2.FDialog2.info2('');

  PageControl1.TabIndex := 0; // START

  computeStartScreen;
  dosleep(CSleep);
  pnlStart.Caption := '';
  pnlStart.Visible := true;
  pnlStart.Refresh;
  lbCSVError.Items.Add('Ladezeit komplett:' + inttostr(GetTickCount - gt));
  Dialog2.FDialog2.Button1click(nil);

  updateTimer.enabled := true;
  // nextUpdateTicks:=gettickcount+updateTimer.interval;
end;

procedure TForm2.LoadInfo(s: string);
begin
  // lblLoadInfo.Caption := s;
  lbLoadInfo.Items.Add(s);
  Dialog2.FDialog2.lbLoadInfo.Items.Add(s);
  Dialog2.FDialog2.info(s);
  Memo1.lines.clear;
  Memo1.lines.Add(s);
  // lblLoadInfo.Repaint;
  lbLoadInfo.Repaint;
  Dialog2.FDialog2.lbLoadInfo.Repaint;

end;

procedure TForm2.machActionsUserIndex;
var
  i, j: integer;
  index: integer;
  gt: Cardinal;

begin
  //
  gt := GetTickCount;
  for i := 0 to length(cwactions) - 1 do
  begin
    index := finduserindex(cwactions[i].userId);
    cwActionsPlus[i].userIndex := index;
  end;
  lbCSVError.Items.Add('Z:MachActionsUserIndex:' + inttostr(GetTickCount - gt));
end;

procedure TForm2.doFinalizeData;
var
  i, p: integer;
  gt: Cardinal;
  sort: Stringarray; // string
  isort: intarray;
begin
  // Nun alle zusätzlichen Berechnungen durchführen, die nach dem Laden der Actions usw notwendig sind
  // Es sind manche Berechnungen nach einem Update nicht unbedingt notwendig. zB wenn sich User oder Symbole
  // gar nicht geändert haben.
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

  // users sortieren in einem extra Feld
  cwusersct := length(cwUsers);
  setlength(isort, cwusersct);
  // findUserIndex und findUserName verwenden die cwUsersSortindex und cwUsersSortindex2
  setlength(cwUsersSortindex, cwusersct); // cwUsersSortIndex(111)='8212345=111'
  setlength(cwUsersSortindex2, cwusersct); // cwUsersSortIndex2(111)=8212345
  for i := 0 to cwusersct - 1 do
  begin
    isort[i] := cwUsers[i].userId;
    cwUsersSortindex[i] := inttostr(cwUsers[i].userId) + '=' + inttostr(i);
  end;
  dosleep(CSleep);
  fastsort2arrayIntegerString(isort, cwUsersSortindex, 'VUA');
  dosleep(CSleep);
  for i := 0 to cwusersct - 1 do
  begin
    p := pos('=', cwUsersSortindex[i]) - 1;
    cwUsersSortindex2[i] := strtoint(leftstr(cwUsersSortindex[i], p));
  end;

  dosleep(CSleep);

  machActionsUserIndex(); // einmalig die Userindices aus den Useraccountnummern berechnen
  dosleep(CSleep);

  btnDoUsersAndSymbolsPlusClick(nil);
  // zusätzliche berechnete Felder für cwusers erstellen in cwusersplus  und cwsymbolsplus
  dosleep(CSleep);

  // den ersten User 'anklicken' und dessen actions im Grid darstellen
  edSingleUserActionsId.text := inttostr(cwactions[0].userId);

  btnGetSingleUserActionsClick(nil);
  dosleep(CSleep);

  btnSymbolGroupsClick(nil); // Symbolgruppen erzeugen und anschliessend Werte berechnen
  dosleep(CSleep);

  lbCSVError.Items.Add('Sym/Users prepare:' + inttostr(GetTickCount - gt));
  gt := GetTickCount;
  // die 4 Grids in Alle befüllen
  dosleep(CSleep);
  btnCwSymbolsToGridClick(nil);
  dosleep(CSleep);
  btnCwusersToGridClick(nil);
  dosleep(CSleep);
  btnCwCommentsToGridClick(nil);
  dosleep(CSleep);
  btnCwactionsToGridClick(nil);
  lbCSVError.Items.Add('4 Grid:' + inttostr(GetTickCount - gt));

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
var
  a: integer;
begin
  a := PageControl1.TabIndex;
  // wirksam um die falschen Skinnings zu beseitigen
  PageControl1.ActivePage.Width := PageControl1.ActivePage.Width + 1;
  if PageControl1.ActivePage.TabIndex = 5 then // caption='SymbolsGroups' then
  begin
    remeasureCategoryPanels(CategoryPanelGroup3);
  end;
  if PageControl1.ActivePage.TabIndex = 3 then // caption='SymbolsGroups' then
  begin

    if (firstSampleDone = false) then
    begin
      btnSampleClick(btnSample2);
      firstSampleDone := true;
    end;
  end;
  if PageControl1.ActivePage.TabIndex = 1 then // all data
  begin
  end;

  //
end;

procedure TForm2.PageControl1Changing(Sender: TObject; var AllowChange: boolean);
var
  a: integer;
begin
  a := 1;
  //
end;

procedure TForm2.PageControl1DrawTab(Control: TCustomTabControl; TabIndex: integer; const Rect: TRect; Active: boolean);
var
  a: integer;
begin
  //
  a := 1;

end;

procedure TForm2.pnlStartBackResize(Sender: TObject);
begin
  pnlStart.Left := pnlStartBack.Left + trunc(pnlStartBack.Width / 2 - pnlStart.Width / 2);
  pnlStart.top := pnlStartBack.top + trunc(pnlStartBack.height / 2 - pnlStart.height / 2);
end;

procedure TForm2.btnLoadCacheFileCwClick(Sender: TObject);
begin
  loadCacheFileCw('CwActions', 'actions', lbCSVError);

  doCacheGridCwInfo;
  lblAllDataInfo.Caption := 'From Cache  Users:' + inttostr(length(cwUsers)) + #13#10 + ' Symbols:' +
    inttostr(length(cwSymbols)) + #13#10 + 'Actions:' + inttostr(length(cwactions));

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
  if length(cwactions) < max then
    max := length(cwactions)
  else;
  // showmessage('Die Darstellung wird auf ' + edCacheShowMax.Text + ' Einträge beschränkt!');

  // stp := strtoint(edCacheCwShowStep.text);
  // doActionsGridCW(SGCwCache, SGFieldCol, cwActions, length(cwActions), max, stp);
  // autosizegrid(SGCwCache);
  //
  // doCacheGridCwInfo;
  DynGrid3.initGrid('cwactions', 'userId', 1, length(cwactions), 25);
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

procedure TForm2.Button10Click(Sender: TObject);
begin
  btnSaveCacheFileCwClick(nil);
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  gt: Cardinal;
  i, j, l: integer;
  ia: intarray;
  ia2: intarray;
  da: doublearray;
  sa: Stringarray;
begin
  gt := GetTickCount;
  l := length(cwactions);
  lbCSVError.Items.Add('Sort Elementzahl:' + inttostr(l));

  setlength(ia, l);
  setlength(ia2, l);
  setlength(da, l);
  setlength(sa, l);

  for i := 0 to length(cwactions) - 1 do
  begin
    ia[i] := i;
    da[i] := cwactions[i].typeId;
    // cwActions[i].profit;  mit profit sortiert er schneller als mit vielen ähnlichen (Int) Werten !
    sa[i] := cwComments[cwactions[i].commentid].text;
    ia2[i] := cwactions[i].typeId;
  end;

  lbCSVError.Items.Add('SortPrepare:' + inttostr(GetTickCount - gt));

  for i := 1 to 1 do
  begin
    gt := GetTickCount;
    fastsort2arrayString(sa, ia, 'VUAS');
    lbCSVError.Items.Add('SortString:' + inttostr(GetTickCount - gt));

    gt := GetTickCount;
    FastSort2ArrayDouble(da, ia, 'VUA');
    lbCSVError.Items.Add('SortDouble:' + inttostr(GetTickCount - gt));

    gt := GetTickCount;
    fastsort2arrayIntInt(ia2, ia, 'VUI'); // VDI
    lbCSVError.Items.Add('SortInteger:' + inttostr(GetTickCount - gt));

    gt := GetTickCount;
    fastsort2arrayString(sa, ia, 'VDAS');
    lbCSVError.Items.Add('SortString:' + inttostr(GetTickCount - gt));

    gt := GetTickCount;
    FastSort2ArrayDouble(da, ia, 'VDA');
    lbCSVError.Items.Add('SortDouble:' + inttostr(GetTickCount - gt));

    gt := GetTickCount;
    fastsort2arrayIntInt(ia2, ia, 'VDI'); // VDI
    lbCSVError.Items.Add('SortInteger:' + inttostr(GetTickCount - gt));
  end
end;

procedure TForm2.btnDoFilterClick(Sender: TObject);
begin
  FilterTopic := 'manual';
  doFilter();
  // -> cwFilteredActions cwFilteredActionsCt
  // nun geht es weiter mit dem Gruppieren
  machUserSelection();
  doGroup();
end;

procedure TForm2.machUserSelection();
var
  i, ix, ct, p: integer;
  v: array of cwuser;
  u: array of integer;
  isort: intarray;
  gt: Cardinal;
begin
  gt := GetTickCount;
  setlength(u, cwusersct);
  for i := 0 to cwFilteredActionCt - 1 do
  begin
    ix := finduserindex(cwFilteredActions[i].userId);
    u[ix] := u[ix] + 1;
  end;
  ct := 0;
  setlength(cwusersselection, cwusersct);
  setlength(cwusersselectionPlus, cwusersct);
  for i := 0 to cwusersct - 1 do
    if (u[i] > 0) then
    begin
      ct := ct + 1;
      cwusersselection[ct - 1] := cwUsers[i];
      cwusersselectionPlus[ct - 1] := cwUsersPlus[i];
    end;
  cwusersselectionct := ct + 1;
  setlength(cwusersselection, cwusersselectionct);
  setlength(cwusersselectionPlus, cwusersselectionct);

  setlength(isort, cwusersselectionct);
  setlength(cwUsersSelectionSortindex, cwusersselectionct); // cwUsersSelectionSortIndex(111)='8212345=111'
  setlength(cwUsersSelectionSortindex2, cwusersselectionct); // cwUsersSelectionSortIndex2(111)=8212345
  for i := 0 to cwusersselectionct - 1 do
  begin
    isort[i] := cwusersselection[i].userId;
    cwUsersSelectionSortindex[i] := inttostr(cwusersselection[i].userId) + '=' + inttostr(i);
  end;
  fastsort2arrayIntegerString(isort, cwUsersSelectionSortindex, 'VUA');
  for i := 0 to cwusersselectionct - 1 do
  begin
    p := pos('=', cwUsersSelectionSortindex[i]) - 1;
    cwUsersSelectionSortindex2[i] := strtoint(leftstr(cwUsersSelectionSortindex[i], p));
  end;

  lbCSVError.Items.Add('Z:F.UserGrtoup:' + inttostr(GetTickCount - gt));
end;

procedure TForm2.btnDoUsersAndSymbolsPlusClick(Sender: TObject);
var
  i, index, j, total: integer;
  sum: double;
  gt: Cardinal;

begin
  // zusätzliche Berechnungen durchführen
  // das passiert gleich im Anschluss an das Laden der Actions
  // Ausgangsdaten sind ALLE cwactions
  gt := GetTickCount;
  sum := 0;
  total := 0;
  for i := 0 to cwusersct - 1 do
  begin
    cwUsersPlus[i].totaltrades := 0;
    cwUsersPlus[i].totalprofit := 0;
    cwUsersPlus[i].totalsymbols := 0;
    cwUsersPlus[i].totalbalance := 0;
  end;

  for i := 0 to length(cwactions) - 1 do
  begin
    inc(cwSymbolsPlus[cwactions[i].symbolId].TradesCount);
    cwSymbolsPlus[cwactions[i].symbolId].TradesVolumeTotal := cwSymbolsPlus[cwactions[i].symbolId].TradesVolumeTotal +
      cwactions[i].volume;

    cwSymbolsPlus[cwactions[i].symbolId].TradesProfitTotal := cwSymbolsPlus[cwactions[i].symbolId].TradesProfitTotal +
      cwactions[i].profit + cwactions[i].swap;

    // NEU: die schnelle Variante
    // index := finduserindex(cwActions[i].userId);
    // Die actions habe eigentlich nur eine Useraccountnummer. Hieraus errechne ich einmalig in cwActionsPlus einen Userindex der direkt in cwusers zeigt
    index := cwActionsPlus[i].userIndex;
    if index > -1 then
    begin
      // cwusersplus[index].totalSymbols:=0;
      inc(cwUsersPlus[index].totaltrades);
      if (cwactions[i].typeId = 7)or(cwactions[i].typeId = 8) then
      begin
        cwUsersPlus[index].totalbalance := cwUsersPlus[index].totalbalance + cwactions[i].profit;
      end
      else
      begin
        cwUsersPlus[index].totalprofit := cwUsersPlus[index].totalprofit + cwactions[i].profit + cwactions[i].swap;
        // evtl auch noch swap aber nicht Balance
      end;
    end;

  end;
  // showmessage(inttostr(GetTickCount - gt));
end;

procedure TForm2.doGroup();
var
  i, j, k, l: integer;
  gt: Cardinal;
  s: string;
  ct: integer;
  ctmax: integer;
  le: array [0 .. 2] of integer;
  // cw3Summaries: DA3CwSummary;
  // cw3SummariesCt: integer;
  max1, max2, max3, max: integer;
  fall: array [0 .. 9] of integer; // wie oft kommt welche Gruppe vor
  p: array [0 .. 2] of integer;
  par: array [0 .. 2] of string;
  TradesCount: integer;
  TradesVolumeTotal: double;
  TradesProfitTotal: double;
  gct: integer;
begin
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

  end;

  max := le[0] * le[1] * le[2];
  setlength(cw3summaries, le[0], le[1], le[2]);
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
        cw3summaries[i][j][k].TradesCount := 0;
        cw3summaries[i][j][k].TradesVolumeTotal := 0;
        cw3summaries[i][j][k].TradesProfitTotal := 0;
        cw3summaries[i][j][k].TradesUsers := 0;
      end;
  try
    for i := 0 to cwFilteredActionCt - 1 do
    begin
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
              par[j] := cwSymbolsGroups[cwSymbolsPlus[cwFilteredActions[i].symbolId].groupId].name + '/' + s;
              // oder der Name !
            end;
          2: // User
            begin
              p[j] := finduserindex(cwFilteredActions[i].userId);
              par[j] := inttostr(cwFilteredActions[i].userId); // oder Username
            end;
          3: // UserId =UserSelection
            begin
              p[j] := finduserSelectionIndex(cwFilteredActions[i].userId);
              par[j] := inttostr(cwFilteredActions[i].userId); // oder Username
            end;
          4: // YearsOpen
            begin
              p[j] := trimYear(yearof(unixtodatetime(cwFilteredActions[i].openTime)));
              par[j] := inttostr(yearof(unixtodatetime(cwFilteredActions[i].openTime)));
            end;
          5: // YearsClose
            begin
              p[j] := trimYear(yearof(unixtodatetime(cwFilteredActions[i].closeTime)));
              par[j] := inttostr(yearof(unixtodatetime(cwFilteredActions[i].closeTime)));
            end;
          6: // dateSpecial
            begin
              // FEHLT NOCH
              p[j] := trimYear(yearof(unixtodatetime(cwFilteredActions[i].closeTime)));
              par[j] := inttostr(yearof(unixtodatetime(cwFilteredActions[i].closeTime)));
            end;
          7: // brokerAccount
            begin
              // FEHLT NOCH
              p[j] := cwFilteredActions[i].accountId;
              par[j] := inttostr(cwFilteredActions[i].accountId); // BESSER machen mit Namen
            end;
        else
          begin
            p[j] := 0;
            par[j] := '?';
          end;
          ;
        end;
      end;

      // jetzt sind alle "Kästchen" im 3D-Array gefüllt
      cw3summaries[p[0], p[1], p[2]].par0 := par[0];
      cw3summaries[p[0], p[1], p[2]].par1 := par[1];
      cw3summaries[p[0], p[1], p[2]].par2 := par[2];
      cw3summaries[p[0], p[1], p[2]].TradesCount := cw3summaries[p[0], p[1], p[2]].TradesCount + 1;
      cw3summaries[p[0], p[1], p[2]].TradesVolumeTotal := cw3summaries[p[0], p[1], p[2]].TradesVolumeTotal +
        cwFilteredActions[i].volume;
      cw3summaries[p[0], p[1], p[2]].TradesProfitTotal := cw3summaries[p[0], p[1], p[2]].TradesProfitTotal +
        cwFilteredActions[i].swap + cwFilteredActions[i].profit;

      TradesCount := TradesCount + 1;
      TradesVolumeTotal := TradesVolumeTotal + cwFilteredActions[i].volume;
      TradesProfitTotal := TradesProfitTotal + cwFilteredActions[i].swap + cwFilteredActions[i].profit;

    end;
  except
    on E: Exception do
      s := E.ToString;

  end;

  // Ausdünnen
  //
  // if (1 = 0) then
  // begin
  // // ausdünnen der Symbole ohne Trades
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
  // lb.Items.Add('Used Sym.groups:' + #9 + inttostr(groupsCt));
  // end;
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
            if (ct = ctmax) then
            begin
              ctmax := ctmax + 10000;
              setlength(cwsummaries, ctmax + 1);
            end;

          end;

        end;
    // hier ist der Moment wo der SPeicherplatzbedarf am grössten ist
    // mit User SymbolGroups und YearsOpen sind es um die 950 MB
  except
    on E: Exception do
      s := E.ToString;

  end;
  setlength(cwsummaries, ct + 1);
  setlength(cw3summaries, 0, 0, 0);

  // DynGrid9.initGrid('cw3summaries', 'par0', 1, max, 10);
  DynGrid9.initGrid('cwsummaries', cwgrouping.element[0].styp, 1, ct + 1, 8);
  DynGrid9.lblTime.Caption := 'Grouped Elements:' + inttostr(ct + 1) + ' from:' + inttostr(cwFilteredActionCt);
end;

function TForm2.trimYear(year: integer): integer;
begin
  // 2012 bis 2023 sind die 12 Jahre auf die getrimmt wird
  if year < 2012 then
    year := 2012; // 2012-12;
  if year > 2023 then
    year := 2023; // 2023-12;
  result := year - 2012;

end;

procedure TForm2.updateTimerTimer(Sender: TObject);
begin
  // Update timer
  if (updategoing=false) then
    btnUpdateDataClick(nil);
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

end;

procedure TForm2.doFilter();
var
  i, j: integer;
  r: boolean;
  fz: integer;
  max, fzmax: integer;
  gt: Cardinal;
  chk: array of boolean;
  faktivCt: integer;

label weiter, weiter1;
begin

  faktivCt := 0;
  for i := 1 to FilterCt do
  begin
    if Filter[i].chkActive.Checked = true then
      inc(faktivCt);
  end;
  if faktivCt = 0 then
  begin
    setlength(cwFilteredActions, length(cwactions));
    setlength(cwFilteredActionsPlus, length(cwactions));
    for i := 0 to length(cwactions) - 1 do
      cwFilteredActions[i] := cwactions[i];
    cwFilteredActionCt := length(cwactions);

    goto weiter1;
  end;

  setlength(cwfilterParameter, FilterCt + 1);
  setlength(chk, FilterCt + 1);
  // sowieso hier blöd
  for i := 1 to FilterCt do
  begin
    Filter[i].getValues(cwfilterParameter[i]);
    Filter[i].machVergleichArrays;
    chk[i] := Filter[i].chkActive.Checked;
    Filter[i].counter := 0;
  end;

  gt := timegettime;
  fz := -1;
  fzmax := 0;

  r := false;

  // unsinnige leere Eingaben abfangen
  for i := 1 to FilterCt do
  begin
    if (chk[i] = true) and (Filter[i].edValue.text = '') then
      chk[i] := false
    else

  end;

//  for i := 1 to FilterCt do
//  begin
//    if (chk[i] = true) then
//     Filter[i].machVergleichArrays; // verlegt      War aber dann ein Fehler in der Berechnung ???
//  end;

  for i := 0 to length(cwactions) - 1 do
  begin
    if(i=12689) then
      j:=0;

    for j := 1 to FilterCt do
    begin
      if chk[j] = true then
      begin
        r := Filter[j].checkCwaction(cwactions[i]);
        if (r = false) then
          // die erste nicht erfüllte Bedingung lässt diese action herausfallen
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
      cwFilteredActions[fz] := cwactions[i];

    end;
    // dem Ergebnis hinzufügen
  weiter:

  end;

  lblFilterResult.Caption := (inttostr(timegettime - gt) + ' ct1:' + inttostr(Filter[1].counter) + ' ct2:' +
    inttostr(Filter[2].counter) + ' ct3:' + inttostr(Filter[3].counter));

  cwFilteredActionCt := fz + 1;
  setlength(cwFilteredActions, fz + 1);
  setlength(cwFilteredActionsPlus, fz + 1);

weiter1:
  max := maxActionsPerGrid;
  if cwFilteredActionCt < max then
    max := cwFilteredActionCt;
  SGCacheCwSearch.Visible := true;
  if cwFilteredActionCt > 50 then
  begin
    doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwFilteredActions, 50, 50);
    SGCacheCwSearch.Repaint;
    doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwFilteredActions, max, max);
    autosizegrid(SGCacheCwSearch, nil);
  end
  else
  begin
    doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwFilteredActions, cwFilteredActionCt, cwFilteredActionCt);
    autosizegrid(SGCacheCwSearch, nil);
  end;
  doCacheGridCwInfo;
  Screen.Cursor := Cursor;
  lblFilteredDataInfo.Caption := #34 + FilterTopic + #34 + ' ' + 'Filtered actions:' + inttostr(cwFilteredActionCt) +
    ' of ' + inttostr(length(cwactions));
  if max < cwFilteredActionCt then
  begin
    lblFilteredDataInfo.Caption := lblFilteredDataInfo.Caption;
  end;

  DynGrid2.initGrid('cwfilteredactions', 'userId', 1, length(cwFilteredActions), 25);
end;

procedure TForm2.Button5Click(Sender: TObject);
// Balance direkt filtern (zum Geschwindigkeitsvergleich die der Filtersuche)
var
  i: integer;
  gt, tg: Cardinal;
  fz, max, fzmax: integer;

  function vergleichInteger(was, mit: integer; op: integer): boolean;
  // var oben bringt nix
  begin
    result := false;
    if op = 1 then // '=' then
    begin
      if was = mit then
        result := true;
      exit;
    end;
    if op = 2 then // '>' then
    begin
      if was > mit then
        result := true;
      exit;
    end;
    if op = 3 then // '<' then
    begin
      if was < mit then
        result := true;
      exit;
    end;
    if op = 4 then // '>=' then
    begin
      if was >= mit then
        result := true;
      exit;
    end;
    if op = 5 then // '<=' then
    begin
      if was <= mit then
        result := true;
      exit;
    end;
    if op = 6 then // '<>' then
    begin
      if was <> mit then
        result := true;
      exit;
    end;

  end;

begin
  gt := timegettime;
  tg := timegettime;
  fz := -1;
  fzmax := -1;
  for i := 0 to length(cwactions) - 1 do
  begin

    if (cwactions[i].accountId = 4) then
      if (cwactions[i].typeId = 7) then
      begin

        // if vergleichInteger(cwActions[i].typeId, 7, 1) = true then
        // begin
        // hinzufügen
        begin
          fz := fz + 1;
          if (fz > fzmax) then
          begin
            fzmax := fzmax + 50000;
            setlength(cwFilteredActions, fzmax);
            setlength(cwFilteredActionsPlus, fzmax);
          end;
          cwFilteredActions[fz] := cwactions[i];
        end;

        // end;
      end;
  end;
  showmessage('z:' + inttostr(timegettime - gt) + ' ' + inttostr(timegettime - tg));
  cwFilteredActionCt := fz + 1;
  setlength(cwFilteredActions, fz + 1); // vergessen
  setlength(cwFilteredActionsPlus, fz + 1); // vergessen

  max := maxActionsPerGrid;
  if cwFilteredActionCt < max then
    max := cwFilteredActionCt;

  if cwFilteredActionCt > 50 then
  begin
    doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwFilteredActions, 50, 50);
    SGCacheCwSearch.Repaint;
    doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwFilteredActions, max, max);
    autosizegrid(SGCacheCwSearch, nil);
  end
  else
  begin
    doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwFilteredActions, cwFilteredActionCt, cwFilteredActionCt);
    autosizegrid(SGCacheCwSearch, nil);
  end;
  doCacheGridCwInfo;
  Screen.Cursor := Cursor;
  lblFilteredDataInfo.Caption := 'Filtered actions:' + inttostr(cwFilteredActionCt) + ' of ' +
    inttostr(length(cwactions));
  if max < cwFilteredActionCt then
  begin
    lblFilteredDataInfo.Caption := lblFilteredDataInfo.Caption + ' Grid:' + inttostr(max);
  end;

end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  TabSheet4.TabVisible := true;
end;

procedure TForm2.Button7Click(Sender: TObject);
begin
  DynGrid1.initGrid('cwactions', 'userId', 1, length(cwactions), 25);
end;

procedure TForm2.btnUpdateDataClick(Sender: TObject);
var
  i, lold, lnew: integer;
  merkOpenTime, merkCloseTime: integer;
  gt, gtall, tt, tnow: Cardinal;
  p, cnew, cold: integer;
  ia: intarray;
  ia2: int64array;
  na: intarray;
  na2: int64array;
  n: integer;
  a1, a2: integer;
label rest;
begin
  // update data
  updategoing:=true;
  Dialog2.FDialog2.Show; // Modal;
  Dialog2.FDialog2.top := Form2.top + Form2.height - FDialog2.height - 4;
  Dialog2.FDialog2.Left := Form2.Left + Form2.Width - FDialog2.Width - 4;

  Dialog2.FDialog2.info('Update data ...');
  gtall := GetTickCount;
  gt := GetTickCount;
  merkOpenTime := 0;
  merkCloseTime := 0;
  tnow := datetimetounix(now);
  // feststellen, wie weit die 'alten' actions zeitlich reichen
  for i := 0 to length(cwactions) - 1 do
  begin
    if cwactions[i].typeId <> 7 then
    begin
      if cwactions[i].openTime > merkOpenTime then
        if cwactions[i].openTime < tnow then
          merkOpenTime := cwactions[i].openTime;
      if cwactions[i].closeTime > merkCloseTime then
        if cwactions[i].closeTime < tnow then
          merkCloseTime := cwactions[i].closeTime;

    end
    else
    begin
    end;
    tt := merkOpenTime;
    if merkCloseTime > tt then
      tt := merkCloseTime;
    tt := tt - 0; // 5 Minuten zurück ???
  end;
  lold := length(cwactions);
  lbCSVError.Items.Add('[Vorbereitung]' + inttostr(GetTickCount - gt));
  gt := GetTickCount;
  // showmessage('Abruf ab:' + datetimetostr(unixtodatetime(tt)) + ' Actions:' + inttostr(lold));
  a1 := GetBinData('http://h2827643.stratoserver.net:8080/bin/actions?fromOpen=' + inttostr(tt), 'actions',
    lbCSVError, true);
  // showmessage(' Actions:' + inttostr(length(cwActions)));
  a2 := GetBinData('http://h2827643.stratoserver.net:8080/bin/actions?fromClose=' + inttostr(tt), 'actions',
    lbCSVError, true);
  // a1 > 0 bedeutet es sind neue Openings vorhanden
  // a2 > 0 muss nix bedeuten da es momentan 11 mit CloseTime in der Zukunft gibt
  lbCSVError.Items.Add('[Daten laden]' + inttostr(GetTickCount - gt));
  gt := GetTickCount;

  // showmessage(' Actions:' + inttostr(length(cwActions)));

  dosleep(CSleep);

  // btnSaveCacheFileCwClick(nil);
  lnew := length(cwactions);

  cnew := lnew - lold;

  //if (claus = false) then
  //begin
    if (cnew = 0) then
    begin
      lbCSVError.Items.Add('[Abbruch - keine Änderungen]' + inttostr(GetTickCount - gt));
      Dialog2.FDialog2.Close;
      goto rest; //exit
    end;

  //end;
  setlength(na2, cnew);
  setlength(na, cnew);
  p := -1;
  for i := lold to lnew - 1 do
  begin
    inc(p);
    na2[p] := cwactions[i].actionId;
    na[p] := i;
  end;

  dosleep(CSleep);

  fastsort2arrayInt64Int(na2, na, 'VUI'); // VDI
  lbCSVError.Items.Add('[sort1]' + inttostr(GetTickCount - gt));
  dosleep(CSleep);

  gt := GetTickCount;

  // doppelte daraus entfernen
  for i := 1 to cnew - 1 do
  begin
    if na2[i] = na2[i - 1] then
      cwactions[na[i - 1]].actionId := 0;
  end;
  dosleep(CSleep);

  // jetzt sieht cwactions so aus: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa nnn0nn0nn0nn0n0n0nnn     a=die alten Action n=die neuen 0 dir doppelten

  // jetzt noch die binäre Suche in den alten Actions ermöglich
  setlength(ia2, lold);
  setlength(ia, lold);
  for i := 0 to lold - 1 do
  begin
    ia2[i] := cwactions[i].actionId;
    ia[i] := i;
  end;
  dosleep(CSleep);

  fastsort2arrayInt64Int(ia2, ia, 'VUI'); // VDI
  lbCSVError.Items.Add('[sort2]' + inttostr(GetTickCount - gt));
  dosleep(CSleep);
  gt := GetTickCount;

  // das ist das sortierte alte cwactions array vor den Neuanfügungen
  //
  for i := lold to lnew - 1 do
  begin
    if cwactions[i].actionId <> 0 then
    begin
      n := binsearchint64(ia2, cwactions[i].actionId);
      if (n = -1) then
      begin
        // nicht gefunden
      end
      else
      begin
        // die geänderte Action wurde in den alten Actions gefunden - nun austauschen
        cwactions[ia[n]] := cwactions[i];
        // und den neuen Eintrag löschen
        cwactions[i].actionId := 0;
      end;
    end;
  end;

  lbCSVError.Items.Add('[einfügen1]' + inttostr(GetTickCount - gt));
  dosleep(CSleep);
  gt := GetTickCount;

  p := lold - 1; // zeiger auf den letzten alten index
  for i := lold to lnew - 1 do
  begin
    // das sind jetzt die neuen Actions !
    if cwactions[i].actionId <> 0 then
    begin
      inc(p);
      cwactions[p] := cwactions[i];
    end;
  end;
  setlength(cwactions, p + 1);
  setlength(cwActionsPlus, p + 1);
  lbCSVError.Items.Add('[einfügen2]' + inttostr(GetTickCount - gt));
  dosleep(CSleep);
  gt := GetTickCount;
  // fertig
  doFinalizeData;
  dosleep(CSleep);
  lbCSVError.Items.Add('[finalize]' + inttostr(GetTickCount - gt));

  lblAllDataInfo.Caption := ' Users:' + inttostr(length(cwUsers)) + #13#10 + ' Symbols:' + inttostr(length(cwSymbols)) +
    #13#10 + ' Actions:' + inttostr(length(cwactions));
  lbCSVError.Items.Add('Time Update:' + inttostr(GetTickCount - gtall) + 'new actions:' + inttostr(lnew - lold));
rest:
  dosleep(CSleep);
//  gt:=gettickcount;
//  computeStartScreen;
//  lbCSVError.Items.Add('Compute StartScreen:' + inttostr(GetTickCount - gt));
  dosleep(CSleep);
  getSymbolsUsersComments(false); // vom Server damit die Werte aktuell sind
  dosleep(CSleep);
  gt:=gettickcount;
  computeStartScreen;
  lbCSVError.Items.Add('Compute StartScreen:' + inttostr(GetTickCount - gt));
  dosleep(CSleep);

  Dialog2.FDialog2.Close;
  updategoing:=false;
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
  // // AdvGDIPChartView1.Panes[0].Series.add;//von Hand eine Series hinzufügen (zwei bereits im Editor)
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

var
  i: integer;
  fe: TFilterParameter;
begin
  // erstmal alle abschalten
  fe.Active := false;
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
    fe.values := 'BALANCE';
    Filter[2].setValues(fe);

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

  end;

  FilterTopic := (Sender as TButton).Caption;

  Grouping[1].chkActive.Checked := true;
  Grouping[2].chkActive.Checked := false;
  Grouping[3].chkActive.Checked := false;
  Grouping[1].cbTopic.text := 'yearsOpen';
  Form2.Refresh;

  doFilter();
  machUserSelection;
  doGroup();
end;

procedure TForm2.btnSaveCacheFileCwClick(Sender: TObject);
begin
  //
  saveCacheFileCw('cwactions', 'actions', lbCSVError);
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
        pa := CategoryPanelGroup1.Panels.Items[i]; // .collapsed:=true;
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

procedure TForm2.cbStylesChange(Sender: TObject);
begin
  if cbStyles.text <> '' then
    TStyleManager.SetStyle(cbStyles.text);

end;

procedure TForm2.CheckBox1Click(Sender: TObject);
begin
  gridsortmethode2 := CheckBox1.Checked;
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
    SplitHeight := (c1.height - coll * 30) div (c1.ControlCount - coll);
    for i := 0 to c1.ControlCount - 1 do
      if c1.Controls[i] is TCategoryPanel then
        if not TCategoryPanel(c1.Controls[i]).collapsed then
          TCategoryPanel(c1.Controls[i]).height := SplitHeight;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  i: integer;
  folder, fileName: string;
  style: string;
  pwct: integer;
  pwok: boolean;

begin
  pwct := 0;
  updateGoing:=false;
  pwok := false;
  claus := false;
  if (claus = false) then
  begin
    for pwct := 0 to 2 do
    begin
      pw := InputBox('Password:', 'Password:', '');

      if pw = '2502' then
      begin
        pwok := true;
        break;

      end
      else
        showmessage('Wrong password !');

    end;
    if (pwok = false) then
    begin
      showmessage('Sorry ...');
      application.Terminate;
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
  folder := ExtractFilePath(paramstr(0)) + 'cachecw';
  createDir(folder);
  fileName := folder + '\cwactions.bin';
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

  FilterCt := 10;
  for i := 1 to FilterCt do
  begin
    Filter[i] := TFilterElemente.Create(self);
    Filter[i].name := 'Filter_' + inttostr(i); // muss sein
    Filter[i].SetBounds(0, (i - 1 + 2) * Filter[i].height, Filter[i].Width, Filter[i].height);
    Filter[i].Parent := pnlFilter;
  end;

  pnlStartBack.Refresh;
  GroupingCt := 3;
  for i := 1 to GroupingCt do
  begin
    Grouping[i] := TGroupControl.Create(self);
    Grouping[i].name := 'Grouping_' + inttostr(i); // muss sein
    Grouping[i].SetBounds(0, (i - 1 + 2) * Grouping[i].height, Grouping[i].Width, Grouping[i].height);
    Grouping[i].Parent := pnlGrouping;
  end;

  maxActionsPerGrid := 10000;

  lboxDebug := lbCSVError;
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
      twoLblStart[i].SetBounds(98, 35 + (i - 1 + 0) * twoLblStart[i].height, twoLblStart[i].Width,
        twoLblStart[i].height)
    else
      twoLblStart[i].SetBounds(500, 35 + (i - 1 + 0 - trunc(twoLblStartCt / 2)) * twoLblStart[i].height,
        twoLblStart[i].Width, twoLblStart[i].height);

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
  DynGrid3.initGrid('cwactions', 'userId', 1, length(cwactions), 25);
end;

procedure TForm2.btnCwCommentsToGridClick(Sender: TObject);
begin
  doCommentsGridCW(SGCwComments, SGFieldCol, cwComments, cwcommentsplus, cwcommentsct, maxActionsPerGrid, 1);
  autosizegrid(SGCwComments, nil);
  DynGrid7.initGrid('cwcomments', 'commentId', 1, length(cwComments), 2);
end;

procedure TForm2.btnCwSymbolsToGridClick(Sender: TObject);
begin
  doSymbolsGridCW(SGCwSymbols, SGFieldCol, cwSymbols, cwSymbolsPlus, length(cwSymbols), maxActionsPerGrid, 1);
  DynGrid5.initGrid('cwsymbols', 'symbolId', 1, length(cwSymbols), 18);

  autosizegrid(SGCwSymbols, nil);

end;

procedure TForm2.btnCwusersToGridClick(Sender: TObject);
begin
  doUsersGridCW(SGCwUsers, SGFieldCol, cwUsers, cwUsersPlus, length(cwUsers), maxActionsPerGrid, 1);
  autosizegrid(SGCwUsers, nil);
  DynGrid6.initGrid('cwusers', 'userId', 1, length(cwUsers), 26);
  DynGrid10.initGrid('cwusers', 'userId', 1, length(cwUsers), 26);

end;

procedure TForm2.btnDblCheckCwClick(Sender: TObject);
var
  sl: TStringList;
  slweg: TStringList;
  i, n: integer;
  doubleCount: integer;
  gt: Cardinal;
  da: doublearray; // array of integer;
  ia: intarray; // array of double;
  ct: integer;
begin
  doubleCount := 0;
  ct := length(cwactions);
  setlength(ia, ct);
  setlength(da, ct);
  for i := 0 to ct - 1 do
  begin
    ia[i] := i;
    da[i] := cwactions[i].actionId;
  end;

  gt := timegettime();
  sl := TStringList.Create;
  slweg := TStringList.Create;
  for i := 0 to ct - 1 do
  begin
    sl.Add(inttostr(cwactions[i].actionId) + '=' + inttostr(i))
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
  // den folgenden Teil bräuchte ich nicht Ist nur damit der untere Code weiterhin funktioniert
  for i := 0 to ct do
  begin
    sl.Add(floattostr(da[i]) + '=' + inttostr(ia[i]))
  end;

  gt := timegettime();
  for i := 0 to ct - 2 do
  begin
    if (sl.Names[i] = sl.Names[i + 1]) then
    begin
      if (cwactions[strtoint(sl.ValueFromIndex[i])].typeId <> 7) then
      // nicht die BALANCE Einträge entfernen  !! cmd=6 ist typeId=7 !!
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
    cwactions[n].actionId := -1;
  end;
  // und nun alle neu aufstapeln
  n := -1;
  for i := 0 to ct - 1 do
  begin
    if (cwactions[i].actionId <> -1) then
    begin
      n := n + 1;
      cwactions[n] := cwactions[i];
    end;
  end;
  // neuer Zähler ist um doubleCount kleiner
  ct := n + 1;
  setlength(cwactions, ct);
  setlength(cwActionsPlus, ct);
  showmessage('jetzt im Cache:' + inttostr(ct) + ' Zeit:' + inttostr(timegettime - gt));

  sl.clear;
  slweg.clear;
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
  // Dient dazu alle doppelten Einträge KOMPLETT zu entfernen
  // so kann aus einer Suche durch erneutes drübersuchen etwas verdoppelt und dann entfernt werden
  if cwFilteredActionCt < 1 then
    exit;

  sl := TStringList.Create;
  for i := 0 to cwFilteredActionCt - 1 do
  begin
    sl.Add(inttostr(cwFilteredActions[i].actionId) + '=' + inttostr(i))
  end;
  // sl.Sort;
  FastSortStList(sl, 'AU');
  setlength(dummy, cwFilteredActionCt);
  dptr := -1;
  // sl.names[]  sl.valuefromindex[]
  for i := 0 to cwFilteredActionCt - 2 do
  begin
    if (sl.Names[i] = killed) then
      // nichts tun - fällt raus
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

  doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwFilteredActions, cwFilteredActionCt, cwFilteredActionCt, 1);
  // lblCacheCwSearchResult.Caption := inttostr(cwFilteredActionCt);
  sl.clear;
  doCacheGridCwInfo;
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
// // der Hi Wert läuft zwischen 0 und 127 vom oben nach unten im Scroller
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
  // das Verschieben wird intern im Grid behandelt und schlägt sich nicht in den Variablen nieder
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
      r.Left := r.Left - 4; // -4 wird ganz gefüllt
      Canvas.FillRect(r);
      // Canvas.Pen.Color := clBlue;
      r.Left := r.Left + 6;
      r.top := r.top + 4;
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
    grid.MouseToCell(X, Y, col, row); // Schutzverletzung
    grid.Cells[col, row];
    if row = 0 then
      grid.Repaint;
  end;

end;

procedure TForm2.SGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
// gemeinsamer Handler für alle normalen TStringGridSorted
var
  i: integer;
  grid: FTCommons.TStringGridSorted;
  col, row: integer;
  fixedCol, fixedRow: boolean;
  gt: Cardinal;
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
    gridMouseClickHandler(grid, col, row, grid.Cells[col, row], grid.Cells[col, 0], grid.Cells[0, row], Button,
      Shift, '');
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
    Cursor := Screen.Cursor;
    try
      Screen.Cursor := crHourGlass;
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
          // diese Methode kann nur bei Zahlen angewendet werden - nicht für Sortieren von Text !
          SortStringGridCW(grid, col, grid.sortTyp[col]);
        // Selektion löschen
        grid.Selection := NoSelection;

      end
      else if fixedCol then
        // Right-click in a "row header"
      else
        // Right-click in a non-fixed cell
      finally
        Screen.Cursor := Cursor;
      end;
      LbDebug('Zeit Gridsort:' + inttostr(timegettime - gt));
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
    gt: Cardinal;
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
        LbDebug('Sort:' + inttostr(GetTickCount - gt));
        gt := GetTickCount();
        for k := 0 to CountItem - 1 do
        begin
          MyList.Add(genstrgrid.Rows[k].text);
          // MyList ist nun quasi die Kopie des StringGrids ab unterhalb der Überschrift
        end;
        LbDebug('Mylist:' + inttostr(GetTickCount - gt));
        gt := GetTickCount();

        for k := 1 to CountItem - 1 do
        begin
          genstrgrid.Rows[k].BeginUpdate;
          genstrgrid.Rows[k].text := MyList.Strings[ia[k - 1]];
          genstrgrid.Rows[k].EndUpdate;
          if k = 50 then
            genstrgrid.Repaint;
        end;
        LbDebug('Grid neu:' + inttostr(GetTickCount - gt));

      end;
    finally
      // Free the List
      MyList.free;
    end;

  end;

  procedure TForm2.SpeedButton1Click(Sender: TObject);
  begin
    PageControl1.TabIndex := 0;

  end;

  procedure TForm2.SpeedButton2Click(Sender: TObject);
  begin
    PageControl1.TabIndex := 3;

  end;

  procedure TForm2.SpeedButton3Click(Sender: TObject);
  begin
    PageControl1.TabIndex := 2;

  end;

  procedure TForm2.SpeedButton4Click(Sender: TObject);
  begin
    PageControl1.TabIndex := 1;
  end;

  procedure TForm2.SpeedButton5Click(Sender: TObject);
  begin
    PageControl1.TabIndex := 4;

  end;

  procedure TForm2.SpeedButton6Click(Sender: TObject);
  begin
    PageControl1.TabIndex := 4;

  end;

  procedure TForm2.SortStringGrid(var genstrgrid: FTCommons.TStringGridSorted; ThatCol: integer; sortTyp: integer);

  const
    // Define the Separator
    TheSeparator = #1;
  var
    CountItem, i, j, k, ThePosition: integer;
    MyList: TStringList;
    gt: Cardinal;
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
          // die zu sortierende Spalte vorne an die Row anhängen - dazwischen den Separator
          MyList.Add(genstrgrid.Rows[i].Strings[ThatCol] + TheSeparator + genstrgrid.Rows[i].text);

        // Sort the List
        LbDebug('Sort MyList:' + inttostr(timegettime - gt));
        gt := timegettime;
        if (sortTyp = -1) then
          MyList.CustomSort(StringListSortComparefnDown);
        if (sortTyp = 1) then
          MyList.CustomSort(StringListSortComparefnUp);
        LbDebug('Sort CustomSort:' + inttostr(timegettime - gt));

        gt := timegettime;

        for k := 1 to MyList.Count do
        begin
          // Take the String of the line (K – 1)
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
        LbDebug('Sort MyList gen:' + inttostr(timegettime - gt));

        // Refill the StringGrid       - ca 75% der Zeit hierfür
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

        LbDebug('Sort ->Grid:' + inttostr(timegettime - gt));
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

    Dialog2.FDialog2.Show; // Modal;
    Dialog2.FDialog2.top := Form2.top + Form2.height - FDialog2.height - 4;
    Dialog2.FDialog2.Left := Form2.Left + Form2.Width - FDialog2.Width - 4;
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

    lb.Items.Add('userId' + #9 + inttostr(cwUsers[k].userId));
    lb.Items.Add('accountId' + #9 + inttostr(cwUsers[k].accountId));
    lb.Items.Add('group' + #9 + cwUsers[k].group);
    lb.Items.Add('enable' + #9 + inttostr(cwUsers[k].enable));
    lb.Items.Add('registrationTime' + #9 + inttostr(cwUsers[k].registrationTime));
    lb.Items.Add('lastLoginTime' + #9 + inttostr(cwUsers[k].lastLoginTime));
    lb.Items.Add('leverage' + #9 + inttostr(cwUsers[k].leverage));
    lb.Items.Add('balance' + #9 + floattostr(cwUsers[k].balance));
    lb.Items.Add('balPrevMonth' + #9 + floattostr(cwUsers[k].balancePreviousMonth));
    lb.Items.Add('balPrevDay' + #9 + floattostr(cwUsers[k].balancePreviousDay));
    lb.Items.Add('credit' + #9 + floattostr(cwUsers[k].credit));
    lb.Items.Add('interestrate' + #9 + floattostr(cwUsers[k].interestrate));
    lb.Items.Add('taxes' + #9 + floattostr(cwUsers[k].taxes));
    lb.Items.Add('name' + #9 + cwUsers[k].name);
    lb.Items.Add('country' + #9 + cwUsers[k].country);
    lb.Items.Add('city' + #9 + cwUsers[k].city);
    lb.Items.Add('state' + #9 + cwUsers[k].State);
    lb.Items.Add('zipcode' + #9 + cwUsers[k].zipcode);
    lb.Items.Add('address' + #9 + cwUsers[k].address);
    lb.Items.Add('phone' + #9 + cwUsers[k].phone);
    lb.Items.Add('email' + #9 + cwUsers[k].email);
    lb.Items.Add('soc.number' + #9 + cwUsers[k].socialNumber);
    lb.Items.Add('comment' + #9 + cwUsers[k].comment);
    lb.Items.Add('totalTrades' + #9 + inttostr(cwUsersPlus[k].totaltrades));
    lb.Items.Add('totalProfit' + #9 + FormatFloat('#0.00', cwUsersPlus[k].totalprofit));
    lb.Items.Add('totalBalance' + #9 + FormatFloat('#0.00', cwUsersPlus[k].totalbalance));

    lblUserInfo0.Caption := cwUsers[k].name;
    lblUserInfo1.Caption := 'Reg.Date:  ' + datetimetostr(unixtodatetime(cwUsers[k].registrationTime));
    lblUserInfo2.Caption := 'LastLogin: ' + datetimetostr(unixtodatetime(cwUsers[k].lastLoginTime));
    lblUserInfo3.Caption := 'Balance:   ' + FormatFloat('#0.00', cwUsers[k].balance);
    lblUserInfo4.Caption := 'T.Trades:  ' + inttostr(cwUsersPlus[k].totaltrades);
    lblUserInfo5.Caption := 'T.Balance: ' + FormatFloat('#0.00', cwUsersPlus[k].totalbalance);
    lblUserInfo6.Caption := 'T.Profit:  ' + FormatFloat('#0.00', cwUsersPlus[k].totalprofit);
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
  begin
    // lblInfoTimer.caption:=inttostr(nextUpdateT
  end;

  procedure TForm2.lbCSVErrorClick(Sender: TObject);
  begin
    lbCSVError.Items.clear;
  end;

  function TForm2.doHttpGetByteArrayFromWorker(var bArray: Bytearray; url: string): integer;
  var
    flag: integer;
    gt, ngt: Cardinal;

    li: integer;
    liText: array [1 .. 8] of string;

  begin
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
    HTTPWorker1.SendType := 3; // String  2=MemoryStream     3=get ByteArray
    HTTPWorker1.RequestBusy := true;
    HTTPWorker1.Caption := 'HTTPWorker1';
    HTTPWorker1.bArray := bArray; // das array wird an den Worker übergeben und dieser befüllt es

    leaveCriticalSection(HTTPWorkCriticalSection);
    // damit sind die Variablen gesetzt und der Thread kann ab jetzt arbeiten
    flag := 0;
    lblWarten.Caption := '********************';
    liText[1] := 'Beim ersten Laden der Actions wird ein Cache angelegt';
    liText[2] := 'Dieser sorgt später für einen schnellen Programmstart';
    liText[3] := 'Das erste Laden aller über 3 Millionen Actions ...';
    liText[4] := 'kann je nach Leitung etliche Minuten dauern';
    liText[5] := 'Es kann sich nur noch um Stunden handeln ... noch etwas Geduld !';
    liText[6] := 'Es wurden inzwischen ' + inttostr(length(cwSymbols)) + ' Symbole geladen';
    liText[7] := 'Es wurden inzwischen ' + inttostr(length(cwUsers)) + ' User geladen';
    liText[8] := 'Es wurden inzwischen ' + inttostr(length(cwComments)) + ' Kommentare geladen';
    gt := GetTickCount;
    ngt := gt + 1000;
    li := 0;
    while (HTTPWorker1.RequestBusy = true) do
    begin
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
            li := 1;
          Memo1.lines.clear;
          Memo1.lines.Add(liText[li]);
          Dialog2.FDialog2.info2(liText[li]);
        end;
        ngt := gt + 8000;

      end;
    end;
    // debugThread(inttostr(HTTPWorker1.ct) + 'HTTPWorker1. S Request Ende:' + Url);
    lblWarten.Caption := 'Loading Finished';
    Memo1.lines.clear;
    // in HTTWorkerResultList stehen die Meldungen
    bArray := HTTPWorker1.bArray;
    result := HTTPWorker1.HError; // hier noch was anders machen !
  end;

  procedure TForm2.dosleep(t: integer);
  var
    gt: Cardinal;
  begin
    gt := GetTickCount();
    repeat
      application.ProcessMessages;
    until (GetTickCount - gt) > t;
    // lbstatisticsPumpAdd('sleep rum:' + inttostr(t));
  end;

  procedure TForm2.FormDestroy(Sender: TObject);
  begin
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

  procedure TForm2.FormResize(Sender: TObject);
  begin
    PageControl1.height := Form2.height;
    PageControl1.Width := Form2.Width - pnlIcons.Width;
    PageControl1.top := -30;
    if (claus = true) then
      PageControl1.top := -20;

  end;

  procedure TForm2.Button4Click(Sender: TObject);
  begin
    StartHTTPWorker;
  end;

  // Trackbar.Position must run at range 1-255...
  procedure TForm2.fillStartScreen;
  begin
    twoLblStart[1].l1.Caption := 'Users total:';
    twoLblStart[2].l1.Caption := 'Actions total:';
    twoLblStart[3].l1.Caption := 'Users online:';
    twoLblStart[4].l1.Caption := 'Open Actions:';
    twoLblStart[5].l1.Caption := 'New Users 1 week:';
    twoLblStart[6].l1.Caption := 'New Users 1 month:';
    twoLblStart[7].l1.Caption := 'Actions new today:';
    twoLblStart[8].l1.Caption := 'Actions 1 week:';
    twoLblStart[9].l1.Caption := 'Profit today:';
    twoLblStart[10].l1.Caption := 'Profit 1 week:';
    twoLblStart[11].l1.Caption := 'logged Users 1 day:';
    twoLblStart[12].l1.Caption := 'logged Users 1 week:';
    twoLblStart[13].l1.Caption := 'logged Users 1 month:';

    twoLblStart[1].l2.Caption := inttostr(length(cwUsers));
    twoLblStart[2].l2.Caption := inttostr(length(cwactions)); // 'Actions total:';
    twoLblStart[3].l2.Caption := '33'; // inttostr(info.usersOnline); // '...';//'Users online:';
    twoLblStart[4].l2.Caption := inttostr(info.openActions); // ''/'Open Actions:';
    twoLblStart[5].l2.Caption := inttostr(info.newUsers1w); // ''/'New Users 1 week:';
    twoLblStart[6].l2.Caption := inttostr(info.newUsers1m); // ''/'New Users 1 month:';
    twoLblStart[7].l2.Caption := inttostr(info.newActions1d); // ''/'Actions new today:';
    twoLblStart[8].l2.Caption := inttostr(info.newActions1w); // ''/'Actions 1 week:';
    twoLblStart[9].l2.Caption := FormatFloat('#0.00', info.profit1d); // ''/'Profit today:';
    twoLblStart[10].l2.Caption := FormatFloat('#0.00', info.profit1w); // ''/'Profit 1 week:';
    twoLblStart[11].l2.Caption := inttostr(info.logUsers1d); // ''/'Actions new today:';
    twoLblStart[12].l2.Caption := inttostr(info.logUsers1w); // ''/'Actions new today:';
    twoLblStart[13].l2.Caption := inttostr(info.logUsers1m); // ''/'Actions new today:';
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
    t: tdatetime;
    ut:integer;
    dt:integer;
    gt:cardinal;
  const
    c1=86400;
    c7=86400*7;
    c30=86400*30;
  begin
    gt:=gettickcount;
    t := now;
    ut:=datetimetounix(t);
    info.newUsers1w := 0;
    info.newUsers1m := 0;
    info.logUsers1d := 0;
    info.logUsers1w := 0;
    info.logUsers1m := 0;
    info.newActions1d := 0;
    info.newActions1w := 0;
    info.newActions1m := 0;
    info.profit1d := 0;
    info.profit1w := 0;
    info.profit1m := 0;
    info.openActions := 0;
    for i := 0 to cwusersct - 1 do
    begin
      dt := cwUsers[i].registrationTime;
      if ((ut - dt) < c7) then
        inc(info.newUsers1w);
      if ((ut - dt) < c30) then
        inc(info.newUsers1m);
      dt := cwUsers[i].lastLoginTime;
      if ((ut - dt) < c1) then
        inc(info.logUsers1d);
      if ((ut - dt) < c7) then
        inc(info.logUsers1w);
      if ((ut - dt) < c30) then
        inc(info.logUsers1m);
    end;
    for i := 0 to cwactionsct - 1 do
    begin
      dt := cwactions[i].openTime;
      if ((ut - dt) < c1) then
        inc(info.newActions1d);
      if ((ut - dt) < c7) then
        inc(info.newActions1w);
      if ((ut - dt) < c30) then
        inc(info.newActions1m);

      if (cwactions[i].typeId = c7) then // balance
      begin
        dt := dt;
      end;
      if (cwactions[i].typeId <> c7) then // balance
      begin
        dt := cwactions[i].closeTime;

        // offene Orders weisen immer einen momentanen Profit aus
        if (cwactions[i].closeTime > 0) then
        begin
          if ((ut - dt) < c1) then
            info.profit1d := info.profit1d + cwactions[i].profit;
          if ((ut - dt) < c7) then
            info.profit1w := info.profit1d + cwactions[i].profit;
          if ((ut - dt) < c30) then
            info.profit1m := info.profit1d + cwactions[i].profit;
        end
        else
          inc(info.openActions);

      end;
    end;
    if (makeLabelsDone = false) then
    begin

      makeLabelsDone := true;
      makelabels;

    end;
    fillStartScreen;
    lbcsverror.items.add('ComputeStartScreen:'+inttostr(gettickcount-gt));
  end;

end.
