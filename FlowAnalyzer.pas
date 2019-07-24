unit FlowAnalyzer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.strutils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, FTCommons, Vcl.StdCtrls, Vcl.Grids,
  Vcl.ExtCtrls, StringGridSorted, Vcl.CheckLst, ClipBrd, filterElement, FilterControl, MMSystem, HTTPWorker, FTTypes,
  Vcl.Themes, UDynGrid;

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
    Panel10: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    lblWarten: TLabel;
    clbBrokers: TCheckListBox;
    lbLoadInfo: TListBox;
    btnClbBrokersSelectAll: TButton;
    btnClbBrokersDeSelectAll: TButton;
    btnLoadData: TButton;
    cbLoadActionsFromCache: TCheckBox;
    Button1: TButton;
    edMaxActionsPerGrid: TEdit;
    TabSheet5: TTabSheet;
    Panel6: TPanel;
    Panel7: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    btnGetSingleUserActions: TButton;
    edSingleUserActionsId: TEdit;
    edFZMax: TEdit;
    Panel8: TPanel;
    Panel9: TPanel;
    lblSingleUserActions: TLabel;
    SGCwSingleUser: FTCommons.TStringGridSorted;
    TabSheet1: TTabSheet;
    Panel26: TPanel;
    Panel34: TPanel;
    Panel36: TPanel;
    Label5: TLabel;
    lblFilterResult: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    btnDoubleRemoveCw: TButton;
    btnSelectClearCw: TButton;
    btnDoFilter: TButton;
    Button5: TButton;
    pnlFilter: TPanel;
    FilterElemente1: TFilterElemente;
    Panel4: TPanel;
    Panel5: TPanel;
    lblFilteredDataInfo: TLabel;
    SGCacheCwSearch: FTCommons.TStringGridSorted;
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
    lbCSVError: TListBox;
    lbDebug2: TListBox;
    chkGetBinAppend: TCheckBox;
    TabSheet6: TTabSheet;
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel4: TCategoryPanel;
    CategoryPanel3: TCategoryPanel;
    SGCwUsers: FTCommons.TStringGridSorted;
    CategoryPanel2: TCategoryPanel;
    SGCwSymbols: FTCommons.TStringGridSorted;
    CategoryPanel1: TCategoryPanel;
    SGCwCache: FTCommons.TStringGridSorted;
    SGCwComments: FTCommons.TStringGridSorted;
    Panel3: TPanel;
    lblAllDataInfo: TLabel;
    Button3: TButton;
    Button4: TButton;
    Button6: TButton;
    CheckBox1: TCheckBox;
    btnSample1: TButton;
    Label11: TLabel;
    btnSample2: TButton;
    btnSample3: TButton;
    Panel11: TPanel;
    Memo1: TMemo;
    Button2: TButton;
    cbStyles: TComboBox;
    TabSheet3: TTabSheet;
    Panel12: TPanel;
    DynGrid1: TDynGrid;
    Button7: TButton;
    Button8: TButton;
    procedure btnGetSymbolsUsersCommentsClick(Sender: TObject);
    procedure btnGetCsvClick(Sender: TObject);
    procedure GetCsv(url, typ: string; lb: TListBox; append: boolean);
    procedure btnCwSymbolsToGridClick(Sender: TObject);
    procedure btnCwactionsToGridClick(Sender: TObject);
    procedure btnCwusersToGridClick(Sender: TObject);
    procedure btnCwCommentsToGridClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGetBinDataClick(Sender: TObject);
    procedure GetBinData(url, typ: string; lb: TListBox; append: boolean);
    procedure btnSaveCacheFileCwClick(Sender: TObject);
    procedure btnLoadCacheFileCwClick(Sender: TObject);
    procedure doCacheGridCwInfo;
    procedure btnShowCacheCwClick(Sender: TObject);
    procedure btnDblCheckCwClick(Sender: TObject);
    procedure SGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SortStringGrid(var genstrgrid: FTCommons.TStringGridSorted; ThatCol: Integer; sortTyp: Integer);
    procedure SortStringGridCW(var genstrgrid: FTCommons.TStringGridSorted; ThatCol: Integer; sortTyp: Integer);
    procedure btnListDoublesCwClick(Sender: TObject);
    procedure btnSelectClearCwClick(Sender: TObject);
    procedure btnDoubleRemoveCwClick(Sender: TObject);
    procedure btnClbBrokersSelectAllClick(Sender: TObject);
    procedure btnClbBrokersDeSelectAllClick(Sender: TObject);
    procedure btnLoadDataClick(Sender: TObject);
    procedure LoadInfo(s: string);
    procedure gridMouseLeftClickHandler(grid: FTCommons.TStringGridSorted; col, row: Integer;
      sCell, sCol, sRow: string);
    procedure btnGetSingleUserActionsClick(Sender: TObject);
    procedure TabSheet2Resize(Sender: TObject);
    procedure btnDoFilterClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure edSingleUserActionsIdChange(Sender: TObject);
    procedure CategoryPanel1Collapse(Sender: TObject);
    procedure CategoryPanel1Expand(Sender: TObject);
    procedure remeasureCategoryPanels;
    procedure StartHTTPWorker;
    procedure HTTPOnTerminate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    function doHttpGetByteArrayFromWorker(var bArray: Bytearray; url: string): Integer;
    procedure dosleep(t: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure btnSample1Click(Sender: TObject);
    procedure doFilter();
    procedure Button2Click(Sender: TObject);
    procedure lbCSVErrorClick(Sender: TObject);
    procedure cbStylesChange(Sender: TObject);
    procedure gridHandler(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form2: TForm2;
  Filter: array [1 .. 10] of TFilterElemente;
  FilterCt: Integer;
  FilterTopic: string;
  SGFieldCol: DAInteger;
  SGColField: DAInteger;
  maxActionsPerGrid: Integer;
  HTTPWorker1: THTTPWorker;
  HTTPWorker1Aktiv: boolean; // wenn create->true wenn terminate -> false
  HTTPWorkCriticalSection: TRTLCriticalSection;
  gridsortmethode2: boolean;

implementation

{$R *.dfm}

uses doHTTP;

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

procedure TForm2.GetBinData(url, typ: string; lb: TListBox; append: boolean);
// kann actions symbols und ticks binär abrufen
// die users symbols gibt es noch nicht !
var
  ret: String;
  gt: Cardinal;
  i: Integer;
  j: Integer;
  bytes: Bytearray;
  s: AnsiString;
  s1: AnsiString;
  ss: String;
  ms: TMemoryStream;
  sz: Integer;
  oldlen: Integer;
  res: Integer;
begin
  gt := GetTickCount;
  // bytes := doHTTPGetByteArray(url, lb);
  res := doHttpGetByteArrayFromWorker(bytes, url);
  lbDebug2.Items.Add('Zeit GetUrl:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));

  if typ = 'actions' then
  begin
    // nur wenn es sich um binäre actions handelt !
    // Bytes->cwActions
    i := SizeOf(cwAction);
    sz := trunc(length(bytes) / i);

    // append-Modus
    if append = true then
    begin
      oldlen := length(cwActions);
      SetLength(cwActions, length(cwActions) + sz);
      move(bytes[0], cwActions[oldlen], length(bytes));
    end
    else
    begin
      SetLength(cwActions, sz);
      move(bytes[0], cwActions[0], length(bytes));
    end;

    lbDebug2.Items.Add('Zeit move->actions:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));
    lbDebug2.Items.Add('Anzahl Actions:' + inttostr(sz));
    lblCwActionsLength.Caption := 'CwActions:' + inttostr(length(cwActions));
    btnCwactionsToGridClick(nil);

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

  if typ = 'symbols' then
  begin
    // Bytes->cwSymbols

    // //wenn Sicherung als Datei zum Debugging
    // ms := TMemoryStream.Create;
    // ms.WriteBuffer(bytes[0], length(bytes));
    // ms.SaveToFile(ExtractFilePath(paramstr(0)) + 'symbols.bin');
    // ms.Free;

    i := SizeOf(cwSymbol);
    sz := trunc(length(bytes) / i);
    SetLength(cwSymbols, sz);
    SetLength(cwsymbolsSortindex, 0); // zurücksetzen
    move(bytes[0], cwSymbols[0], length(bytes));
    lbDebug2.Items.Add('Zeit move->symbol:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));
    lbDebug2.Items.Add('Anzahl Symbols:' + inttostr(sz));
    for j := 0 to sz - 1 do
    begin
      lbDebug2.Items.Add(inttostr(j) + ' ' + cwSymbols[j].name + ' ' + inttostr(cwSymbols[j].symbolId) + ' ' +
        inttostr(cwSymbols[j].brokerId));
      if j > 100 then
        break;
    end;
    lbDebug2.Items.Add('...');

  end;
  if typ = 'ticks' then
  begin
    // wenn Sicherung als Datei zum Debugging
    ms := TMemoryStream.Create;
    ms.WriteBuffer(bytes[0], length(bytes));
    ms.SaveToFile(ExtractFilePath(paramstr(0)) + 'ticks.bin');
    ms.Free;
  end;

  if typ = 'users' then
  begin
    // wenn Sicherung als Datei zum Debugging
    ms := TMemoryStream.Create;
    ms.WriteBuffer(bytes[0], length(bytes));
    ms.SaveToFile(ExtractFilePath(paramstr(0)) + 'users.bin');
    ms.Free;

    i := SizeOf(cwuser);
    sz := trunc(length(bytes) / i);
    SetLength(cwUsers, sz);
    SetLength(cwUsersSortindex, 0); // zurücksetzen
    SetLength(cwUsersSortindex2, 0); // zurücksetzen
    move(bytes[0], cwUsers[0], length(bytes));
    lbDebug2.Items.Add('Zeit move->user:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));
    lbDebug2.Items.Add('Anzahl users:' + inttostr(sz));
    for j := 0 to sz - 1 do
    begin
      lbDebug2.Items.Add(inttostr(j) + ' ' + cwUsers[j].name + ' ' + inttostr(cwUsers[j].userId) + ' ' +
        inttostr(cwUsers[j].accountId));
      if j > 100 then
        break;
    end;
    lbDebug2.Items.Add('...');

  end;

  SetLength(bytes, 0)
end;

procedure TForm2.btnGetCsvClick(Sender: TObject);
var
  typ: string;
begin
  if containstext(edGetUrlCSV.text, '/symbols') then
    typ := 'symbols';
  if containstext(edGetUrlCSV.text, '/users') then
    typ := 'users';
  if containstext(edGetUrlCSV.text, '/comments') then
    typ := 'comments';
  if containstext(edGetUrlCSV.text, '/ticks') then
    typ := 'ticks';
  // alle ohne append
  GetCsv(edGetUrlCSV.text, typ, lbCSVError, false);

end;

procedure TForm2.GetCsv(url, typ: string; lb: TListBox; append: boolean);

var
  gt: Cardinal;

  bytes: Bytearray;
  s: AnsiString;
  ms: TMemoryStream;
  bpms: Integer;

begin
  gt := GetTickCount;
  bytes := doHTTPGetByteArray(url, lbCSVError);
  bpms := trunc(length(bytes) / (GetTickCount - gt));

  lb.Items.Add('CSV-Load:' + url);
  lb.Items.Add('Z:get :' + inttostr(GetTickCount - gt));
  lb.Items.Add('bpms:' + inttostr(bpms));
  gt := GetTickCount;
  // bei CSV-Dateien muss UTF8-decodiert werden damit die Umlaute passen
  SetString(s, PAnsiChar(@bytes[0]), high(bytes) + 1);
  s := UTF8Decode(s); // -> der String ist jetzt ok

  // den UTF8-decodierten AnsiString wieder als Bytearray
  SetLength(bytes, length(s));
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
    // // die Bytes in eine Datei schreiben
    // try
    // fileName := ExtractFilePath(paramstr(0)) + 'symbols.csv';
    // fileMode := fmCreate;
    // Stream := TFileStream.Create(fileName, fileMode);
    // Stream.WriteBuffer(bytes[0], high(bytes) + 1);
    // Stream.Free; // Speicher freigeben
    // except
    // debug('F:writeUsersStream');
    // end;
    ParseDelimited('symbols', lb, s, #13 + #10, cwUsers, cwSymbols, cwTicks, cwComments, ms, append);
    cwSymbolsCt := length(cwSymbols);

  end;

  if typ = 'users' then
  begin
    // // die Bytes in eine Datei schreiben
    // try
    // fileName := ExtractFilePath(paramstr(0)) + 'users.csv';
    // fileMode := fmCreate;
    // Stream := TFileStream.Create(fileName, fileMode);
    // Stream.WriteBuffer(bytes[0], high(bytes) + 1);
    // Stream.Free; // Speicher freigeben
    // except
    // debug('F:writeUsersStream');
    // end;
    ParseDelimited('users', lb, s, #13 + #10, cwUsers, cwSymbols, cwTicks, cwComments, ms, append);
    cwUsersCt := length(cwUsers);
  end;

  if typ = 'comments' then
  begin
    // // die Bytes in eine Datei schreiben
    // try
    // fileName := ExtractFilePath(paramstr(0)) + 'users.csv';
    // fileMode := fmCreate;
    // Stream := TFileStream.Create(fileName, fileMode);
    // Stream.WriteBuffer(bytes[0], high(bytes) + 1);
    // Stream.Free; // Speicher freigeben
    // except
    // debug('F:writeUsersStream');
    // end;
    ParseDelimited('comments', lb, s, #13 + #10, cwUsers, cwSymbols, cwTicks, cwComments, ms, append);
    cwCommentsCt := length(cwComments);
  end;

  if typ = 'ticks' then
  begin
    ParseDelimited('ticks', lb, s, #13 + #10, cwUsers, cwSymbols, cwTicks, cwComments, ms, append);
    cwTicksCt := length(cwTicks);

  end;
  ms.Free;

end;

procedure TForm2.gridHandler(Sender: TObject);
var
  sg: TDynGrid;
  i, j, k: Integer;
  row: Integer;
  vCols, vRows, vScroll: Integer;
  rc: Integer;
  vscrollmax: Integer;
begin
  //
  with Sender as TDynGrid do
  begin
    rc := sg.rowcount;
    vCols := VisibleCols; // cols und rows ändert sich dynamisch
    vRows := VisibleRows;
    vScroll := scrollPosition; //
    maxdatarows := length(cwActions);

    vscrollmax := vScroll + vRows;
    if vscrollmax > maxdatarows then
      vscrollmax := maxdatarows;
    // es könnten mehrere Grids vorhanden sein welche dieselben Daten verwenden
    // daher wäre es besser das Sortierarray gehört zum Grid

    // doActionsGridCWFast(SG, SGFieldCol, cwActions,vscroll, vscrollmax);
    doActionsGridCWFast(sg, SGFieldCol, ixSorted, cwActions, vScroll, vscrollmax);
  end;
end;

procedure TForm2.gridMouseLeftClickHandler(grid: FTCommons.TStringGridSorted; col, row: Integer;
  sCell, sCol, sRow: string);
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
  if grid.name = 'SGCwUsers' then
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
  id: Integer;
  i: Integer;
  fz: Integer;
  fzmax: Integer;
  max: Integer;
begin
  id := strtoint(edSingleUserActionsId.text);
  fzmax := strtoint(edFZMax.text);
  fz := -1;
  SetLength(cwSingleUserActions, fzmax);
  cwactionsct := length(cwActions);
  for i := 0 to cwactionsct - 1 do
  begin
    if cwActions[i].userId = id then
    begin
      fz := fz + 1;
      if fz >= fzmax then
      begin
        fzmax := fzmax + strtoint(edFZMax.text);
        SetLength(cwSingleUserActions, fzmax);
      end;
      cwSingleUserActions[fz] := cwActions[i];
    end;
  end;

  // application.messagebox('test1','test3');

  SetLength(cwSingleUserActions, fz + 1);
  cwsingleuseractionsCt := fz + 1;
  max := cwsingleuseractionsCt;
  if max > maxActionsPerGrid then
    max := maxActionsPerGrid;

  doActionsGridCW(SGCwSingleUser, SGFieldCol, cwSingleUserActions, max, max);
  autosizegrid(SGCwSingleUser);
  lblSingleUserActions.Caption := 'Actions: ' + inttostr(cwsingleuseractionsCt);
end;

procedure TForm2.btnGetSymbolsUsersCommentsClick(Sender: TObject);
begin
  // Die drei Dateien vom Server abrufen: symbols user und comments
  edGetUrlCSV.text := 'http://h2827643.stratoserver.net:8080/csv/symbols';
  LoadInfo('Load Symbols...');
  btnGetCsvClick(nil);

  edGetUrlCSV.text := 'http://h2827643.stratoserver.net:8080/csv/users';
  LoadInfo('Load Users...');
  btnGetCsvClick(nil);

  edGetUrlCSV.text := 'http://h2827643.stratoserver.net:8080/csv/comments';
  LoadInfo('Load Comments...');
  btnGetCsvClick(nil);

end;

procedure TForm2.btnListDoublesCwClick(Sender: TObject);
// liste alle doppelten OrderIds auf - macht aber sonst nichts!
var
  i: Integer;
  merk: array of Integer;
  max: Integer;
begin
  max := 5000000;
  // Check doubles
  SetLength(merk, max);
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
      lbCSVError.Items.Add('Doppelte Order:' + inttostr(i) + ':' + inttostr(merk[i]));
    end;
  end;
end;

procedure TForm2.btnLoadDataClick(Sender: TObject);
var
  all: boolean;
  i: Integer;
  appendCSVUsers: boolean;
  appendBinActions: boolean;
  whichAccounts: string;
  sort: Stringarray; // string
  isort: intarray;
  p: Integer;
  gt: Cardinal;
begin
  whichAccounts := '';
  Panel10.enabled := false;
  lbLoadInfo.Items.clear;
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
  begin
    btnGetSymbolsUsersCommentsClick(nil);
    if cbLoadActionsFromCache.Checked = true then
    begin
      btnLoadCacheFileCwClick(nil);
      LoadInfo(inttostr(length(cwActions)) + ' Actions loaded from Cache');
    end
    else
    begin
      LoadInfo('Load All Actions...');
      GetBinData('http://h2827643.stratoserver.net:8080/bin/actions', 'actions', lbCSVError, false);
      btnSaveCacheFileCwClick(nil);
      LoadInfo(inttostr(length(cwActions)) + ' Actions loaded from Cache');
    end;
    LoadInfo('Loading finished');
    whichAccounts := 'All accounts/';
  end
  else
  begin

    edGetUrlCSV.text := 'http://h2827643.stratoserver.net:8080/csv/symbols';
    LoadInfo('Load Symbols...');
    btnGetCsvClick(nil);
    LoadInfo(inttostr(length(cwSymbols)) + ' Symbols');

    edGetUrlCSV.text := 'http://h2827643.stratoserver.net:8080/csv/comments';
    LoadInfo('Load Comments...');
    btnGetCsvClick(nil);
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
          appendCSVUsers);
        appendCSVUsers := true; // ab dem 2.mal anhängen !
        LoadInfo(inttostr(length(cwUsers)) + ' Users');

        edGetUrlBin.text := 'http://h2827643.stratoserver.net:8080/bin/actions?accountId=' + inttostr(i + 1);
        LoadInfo('Load Actions...');
        GetBinData('http://h2827643.stratoserver.net:8080/bin/actions?accountId=' + inttostr(i + 1), 'actions',
          lbCSVError, appendBinActions);
        appendBinActions := true; // ab dem 2.mal anhängen !

        LoadInfo(inttostr(length(cwActions)) + ' Actions');

        LoadInfo('Loading finished');

      end

    end;

  end;
  whichAccounts := leftstr(whichAccounts, length(whichAccounts) - 1);
  lblAllDataInfo.Caption := whichAccounts + #13#10 + ' Users:' + inttostr(length(cwUsers)) + #13#10 + ' Symbols:' +
    inttostr(length(cwSymbols)) + #13#10 + ' Actions:' + inttostr(length(cwActions)) + #13#10 + #13#10 +
    ifthen(length(cwActions) <= maxActionsPerGrid, '', '[In Grid:' + inttostr(maxActionsPerGrid) + ']');

  btnCwSymbolsToGridClick(nil);
  btnCwusersToGridClick(nil);
  btnCwCommentsToGridClick(nil);
  btnCwactionsToGridClick(nil);

  TabSheet1.TabVisible := true;
  TabSheet6.TabVisible := true;
  TabSheet5.TabVisible := true;

  PageControl1.TabIndex := 1;

  // symbole sortieren in einem extra Feld
  cwSymbolsCt := length(cwSymbols);
  SetLength(sort, cwSymbolsCt);
  SetLength(cwsymbolsSortindex, cwSymbolsCt);
  for i := 0 to cwSymbolsCt - 1 do
  begin
    sort[i] := cwSymbols[i].name;
    cwsymbolsSortindex[i] := i;
  end;
  fastsort2arrayString(sort, cwsymbolsSortindex, 'VUAS');

  // symbole sortieren in einem extra Feld
  cwUsersCt := length(cwUsers);
  SetLength(isort, cwUsersCt);
  SetLength(cwUsersSortindex, cwUsersCt);
  SetLength(cwUsersSortindex2, cwUsersCt);
  for i := 0 to cwUsersCt - 1 do
  begin
    isort[i] := cwUsers[i].userId;
    cwUsersSortindex[i] := inttostr(cwUsers[i].userId) + '=' + inttostr(i);
  end;
  fastsort2arrayIntegerString(isort, cwUsersSortindex, 'VUA');
  for i := 0 to cwUsersCt - 1 do
  begin
    p := pos('=', cwUsersSortindex[i]) - 1;
    cwUsersSortindex2[i] := strtoint(leftstr(cwUsersSortindex[i], p));
  end;

  edSingleUserActionsId.text := inttostr(cwActions[0].userId);
  btnGetSingleUserActionsClick(nil);

  Panel10.enabled := true;

end;

procedure TForm2.LoadInfo(s: string);
begin
  // lblLoadInfo.Caption := s;
  lbLoadInfo.Items.Add(s);
  Memo1.lines.clear;
  Memo1.lines.Add(s);
  // lblLoadInfo.Repaint;
  lbLoadInfo.Repaint;
end;

procedure TForm2.btnSaveCacheFileCwClick(Sender: TObject);
begin
  saveCacheFileCw('CwActions', 'actions', lbCSVError);
  // saveCacheFileCw('CwSymbolsCache', 'symbols', lbCSVError);
  // saveCacheFileCw('CwUsersCache', 'users', lbCSVError);
  // saveCacheFileCw('CwCommentsCache', 'comments', lbCSVError);
end;

procedure TForm2.btnLoadCacheFileCwClick(Sender: TObject);
begin
  loadCacheFileCw('CwActions', 'actions', lbCSVError);
  // loadCacheFileCw('CwSymbolsCache', 'symbols', lbCSVError);
  // loadCacheFileCw('CwUsersCache', 'users', lbCSVError);
  // loadCacheFileCw('CwCommentsCache', 'comments', lbCSVError);

  doCacheGridCwInfo;
  lblAllDataInfo.Caption := 'From Cache  Users:' + inttostr(length(cwUsers)) + #13#10 + ' Symbols:' +
    inttostr(length(cwSymbols)) + #13#10 + 'Actions:' + inttostr(length(cwActions));

end;

procedure TForm2.btnSelectClearCwClick(Sender: TObject);
begin
  cwActionsSelectionCt := 0;
  SetLength(cwActionsSelection, 0);
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
  max: Integer;
  stp: Integer;
begin
  max := strtoint(edCacheCwShowMax.text);
  if length(cwActions) < max then
    max := length(cwActions)
  else;
  // showmessage('Die Darstellung wird auf ' + edCacheShowMax.Text + ' Einträge beschränkt!');

  stp := strtoint(edCacheCwShowStep.text);
  doActionsGridCW(SGCwCache, SGFieldCol, cwActions, length(cwActions), max, stp);
  autosizegrid(SGCwCache);

  doCacheGridCwInfo;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  gt: Cardinal;
  i, j, l: Integer;
  ia: intarray;
  ia2: intarray;
  da: doublearray;
  sa: Stringarray;
begin
  gt := GetTickCount;
  l := length(cwActions);
  lbCSVError.Items.Add('Sort Elementzahl:' + inttostr(l));

  SetLength(ia, l);
  SetLength(ia2, l);
  SetLength(da, l);
  SetLength(sa, l);

  for i := 0 to length(cwActions) - 1 do
  begin
    ia[i] := i;
    da[i] := cwActions[i].typeId;
    // cwActions[i].profit;  mit profit sortiert er schneller als mit vielen ähnlichen (Int) Werten !
    sa[i] := cwComments[cwActions[i].commentid].text;
    ia2[i] := cwActions[i].typeId;
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
end;

procedure TForm2.doFilter();
var
  i, j: Integer;
  r: boolean;
  fz: Integer;
  max, fzmax: Integer;
  gt: Cardinal;
  chk: array of boolean;
label weiter;
begin
  SetLength(cwfilterParameter, FilterCt + 1);
  SetLength(chk, FilterCt + 1);
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
      chk[i] := false;
  end;

  for i := 0 to length(cwActions) - 1 do
  begin
    for j := 1 to FilterCt do
    begin
      if chk[j] = true then
      begin
        r := Filter[j].checkCwaction(cwActions[i]);
        if (r = false) then
          goto weiter
      end;
    end;
    if r = true then
    begin
      fz := fz + 1;
      if (fz > fzmax - 1) then
      begin
        fzmax := fzmax + 1000;
        SetLength(cwActionsSelection, fzmax);
      end;
      cwActionsSelection[fz] := cwActions[i];

    end;
    // dem Ergebnis hinzufügen
  weiter:

  end;
  lblFilterResult.Caption := (inttostr(timegettime - gt) + ' ct1:' + inttostr(Filter[1].counter) + ' ct2:' +
    inttostr(Filter[2].counter) + ' ct3:' + inttostr(Filter[3].counter));

  cwActionsSelectionCt := fz + 1;
  SetLength(cwActionsSelection, fz + 1); // vergessen

  max := maxActionsPerGrid;
  if cwActionsSelectionCt < max then
    max := cwActionsSelectionCt;
  SGCacheCwSearch.Visible := true;
  if cwActionsSelectionCt > 50 then
  begin
    doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwActionsSelection, 50, 50);
    SGCacheCwSearch.Repaint;
    doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwActionsSelection, max, max);
    autosizegrid(SGCacheCwSearch);
  end
  else
  begin
    doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwActionsSelection, cwActionsSelectionCt, cwActionsSelectionCt);
    autosizegrid(SGCacheCwSearch);
  end;
  doCacheGridCwInfo;
  Screen.Cursor := Cursor;
  lblFilteredDataInfo.Caption := #34 + FilterTopic + #34 + ' ' + 'Filtered actions:' + inttostr(cwActionsSelectionCt) +
    ' of ' + inttostr(length(cwActions));
  if max < cwActionsSelectionCt then
  begin
    lblFilteredDataInfo.Caption := lblFilteredDataInfo.Caption + ' Grid:' + inttostr(max);
  end;

end;

procedure TForm2.Button5Click(Sender: TObject);
// Balance direkt filtern (zum Geschwindigkeitsvergleich die der Filtersuche)
var
  i: Integer;
  gt, tg: Cardinal;
  fz, max, fzmax: Integer;

  function vergleichInteger(was, mit: Integer; op: Integer): boolean;
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
  for i := 0 to length(cwActions) - 1 do
  begin

    if (cwActions[i].accountId = 4) then
      if (cwActions[i].typeId = 7) then
      begin
        // if vergleichInteger(cwActions[i].typeId, 7, 1) = true then
        // begin
        // hinzufügen
        begin
          fz := fz + 1;
          if (fz > fzmax) then
          begin
            fzmax := fzmax + 50000;
            SetLength(cwActionsSelection, fzmax);
          end;
          cwActionsSelection[fz] := cwActions[i];
        end;

        // end;
      end;
  end;
  showmessage('z:' + inttostr(timegettime - gt) + ' ' + inttostr(timegettime - tg));
  cwActionsSelectionCt := fz + 1;
  SetLength(cwActionsSelection, fz + 1); // vergessen

  max := maxActionsPerGrid;
  if cwActionsSelectionCt < max then
    max := cwActionsSelectionCt;

  if cwActionsSelectionCt > 50 then
  begin
    doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwActionsSelection, 50, 50);
    SGCacheCwSearch.Repaint;
    doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwActionsSelection, max, max);
    autosizegrid(SGCacheCwSearch);
  end
  else
  begin
    doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwActionsSelection, cwActionsSelectionCt, cwActionsSelectionCt);
    autosizegrid(SGCacheCwSearch);
  end;
  doCacheGridCwInfo;
  Screen.Cursor := Cursor;
  lblFilteredDataInfo.Caption := 'Filtered actions:' + inttostr(cwActionsSelectionCt) + ' of ' +
    inttostr(length(cwActions));
  if max < cwActionsSelectionCt then
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
  DynGrid1.initGrid('cwactions', 'userId', 1, length(cwActions), 20);
  //nGrid2.initGrid('cwactions', 'userId', 1, length(cwActions), 20);
end;

procedure TForm2.Button8Click(Sender: TObject);
var
  i, lold, lnew: Integer;
  merkOpenTime, merkCloseTime: Integer;
  tt, tnow: Cardinal;
  p, cnew, cold: Integer;
  ia: intarray;
  ia2: int64array;
  na: intarray;
  na2: int64array;
  n: Integer;
begin
  // update data
  merkOpenTime := 0;
  merkCloseTime := 0;
  tnow := datetimetounix(now);
  for i := 0 to length(cwActions) - 1 do
  begin
    if cwActions[i].typeId <> 7 then
    begin
      if cwActions[i].openTime > merkOpenTime then
        if cwActions[i].openTime < tnow then
          merkOpenTime := cwActions[i].openTime;
      if cwActions[i].closeTime > merkCloseTime then
        if cwActions[i].closeTime < tnow then
          merkCloseTime := cwActions[i].closeTime;

    end
    else
    begin
    end;
    tt := merkOpenTime;
    if merkCloseTime > tt then
      tt := merkCloseTime;
    tt := tt - 0; // 5 Minuten zurück
  end;
  lold := length(cwActions);
  showmessage('Abruf ab:' + datetimetostr(unixtodatetime(tt)) + ' Actions:' + inttostr(lold));
  GetBinData('http://h2827643.stratoserver.net:8080/bin/actions?fromOpen=' + inttostr(tt), 'actions', lbCSVError, true);
  showmessage(' Actions:' + inttostr(length(cwActions)));
  GetBinData('http://h2827643.stratoserver.net:8080/bin/actions?fromClose=' + inttostr(tt), 'actions',
    lbCSVError, true);
  showmessage(' Actions:' + inttostr(length(cwActions)));

  // btnSaveCacheFileCwClick(nil);
  lnew := length(cwActions);
  cnew := lnew - lold;
  SetLength(na2, cnew);
  SetLength(na, cnew);
  p := -1;
  for i := lold to lnew - 1 do
  begin
    inc(p);
    na2[p] := cwActions[i].actionId;
    na[p] := i;
  end;

  fastsort2arrayInt64Int(na2, na, 'VUI'); // VDI
  // doppelte daraus entfernen
  for i := 1 to cnew - 1 do
  begin
    if na2[i] = na2[i - 1] then
      cwActions[na[i - 1]].actionId := 0;
  end;

  // jetzt sieht cwactions so aus: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa nnn0nn0nn0nn0n0n0nnn     a=die alten Action n=die neuen 0 dir doppelten

  // jetzt noch die binäre Suche in den alten Actions ermöglich
  SetLength(ia2, lold);
  SetLength(ia, lold);
  for i := 0 to lold - 1 do
  begin
    ia2[i] := cwActions[i].actionId;
    ia[i] := i;
  end;
  fastsort2arrayInt64Int(ia2, ia, 'VUI'); // VDI

  // das ist das sortierte alte cwactions array vor den Neuanfügungen
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
        // gefunden - austauschen
        cwActions[ia[n]] := cwActions[i];
        cwActions[i].actionId := 0;
      end;
    end;
  end;
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
  setlength(cwactions,p+1);
  //fertig
end;

procedure TForm2.btnSample1Click(Sender: TObject);

var
  i: Integer;
  fe: TFilterParameter;
begin
  fe.active := false;
  for i := 1 to FilterCt do
  begin
    Filter[i].setValues(fe);
  end;

  if (Sender = btnSample1) then
  begin
    fe.active := true;
    fe.topic := 'ActionType';
    fe.operator := '=';
    fe.values := 'BALANCE';
    Filter[1].setValues(fe);
  end;

  if (Sender = btnSample2) then
  begin
    fe.active := true;
    fe.topic := 'Profit';
    fe.operator := '>=';
    fe.values := '1000';
    Filter[1].setValues(fe);
    fe.active := true;
    fe.topic := 'ActionType';
    fe.operator := '<>';
    fe.values := 'BALANCE';
    Filter[2].setValues(fe);

  end;

  if (Sender = btnSample3) then
  begin
    fe.active := true;
    fe.topic := 'Symbol';
    fe.operator := 'contains';
    fe.values := 'GOLD';
    Filter[1].setValues(fe);
  end;

  FilterTopic := (Sender as TButton).Caption;
  doFilter();
end;

procedure TForm2.CategoryPanel1Collapse(Sender: TObject);
begin
  //
  remeasureCategoryPanels;
end;

procedure TForm2.CategoryPanel1Expand(Sender: TObject);
begin
  //
  remeasureCategoryPanels;
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

procedure TForm2.remeasureCategoryPanels;
var
  coll, SplitHeight, i: Integer;
begin
  coll := 0;
  for i := 0 to CategoryPanelGroup1.ControlCount - 1 do
    if CategoryPanelGroup1.Controls[i] is TCategoryPanel then
      if TCategoryPanel(CategoryPanelGroup1.Controls[i]).Collapsed then
        inc(coll);
  if coll < CategoryPanelGroup1.ControlCount then
  begin
    SplitHeight := (CategoryPanelGroup1.Height - coll * 30) div (CategoryPanelGroup1.ControlCount - coll);
    for i := 0 to CategoryPanelGroup1.ControlCount - 1 do
      if CategoryPanelGroup1.Controls[i] is TCategoryPanel then
        if not TCategoryPanel(CategoryPanelGroup1.Controls[i]).Collapsed then
          TCategoryPanel(CategoryPanelGroup1.Controls[i]).Height := SplitHeight;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  i: Integer;
  folder, fileName: string;
  style: string;
begin
  for style in TStyleManager.StyleNames do
  begin
    cbStyles.AddItem(style, nil);
  end;

  gridsortmethode2 := false;
  folder := ExtractFilePath(paramstr(0)) + 'cachecw';
  createDir(folder);
  fileName := folder + '\cwactions.bin';
  if fileexists(fileName) then
  begin
    cbLoadActionsFromCache.Visible := true;
    cbLoadActionsFromCache.Checked := true;

  end
  else
  begin
    cbLoadActionsFromCache.Visible := false;
  end;

  TabSheet1.TabVisible := false;
  TabSheet6.TabVisible := false;
  TabSheet5.TabVisible := false;

  brokerShort[1] := 'LCG';
  brokerShort[2] := 'AT';

  FilterCt := 10;
  for i := 1 to FilterCt do
  begin
    Filter[i] := TFilterElemente.Create(self);
    Filter[i].name := 'Filter_' + inttostr(i); // muss sein
    Filter[i].SetBounds(0, (i - 1) * Filter[i].Height, Filter[i].width, Filter[i].Height);
    Filter[i].Parent := pnlFilter;

  end;

  maxActionsPerGrid := 10000;
  edMaxActionsPerGrid.text := inttostr(maxActionsPerGrid);

  lboxDebug := lbCSVError;
  lboxInfo := lbCSVError;

  SetLength(SGFieldCol, 30);
  SetLength(SGColField, 30);
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
  dosleep(100);
  StartHTTPWorker;
end;

procedure TForm2.btnClbBrokersDeSelectAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to clbBrokers.Items.Count - 1 do
  begin
    clbBrokers.Checked[i] := false;
  end;
end;

procedure TForm2.btnClbBrokersSelectAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to clbBrokers.Items.Count - 1 do
  begin
    clbBrokers.Checked[i] := true;
  end;
end;

procedure TForm2.btnCwactionsToGridClick(Sender: TObject);
begin
  doActionsGridCW(SGCwCache, SGFieldCol, cwActions, length(cwActions), maxActionsPerGrid, 1);
  autosizegrid(SGCwCache);
end;

procedure TForm2.btnCwCommentsToGridClick(Sender: TObject);
begin
  doCommentsGridCW(SGCwComments, SGFieldCol, cwComments, cwCommentsCt, maxActionsPerGrid, 1);
  autosizegrid(SGCwComments);
end;

procedure TForm2.btnCwSymbolsToGridClick(Sender: TObject);
begin
  doSymbolsGridCW(SGCwSymbols, SGFieldCol, cwSymbols, length(cwSymbols), maxActionsPerGrid, 1);
  autosizegrid(SGCwSymbols);

end;

procedure TForm2.btnCwusersToGridClick(Sender: TObject);
begin
  doUsersGridCW(SGCwUsers, SGFieldCol, cwUsers, length(cwUsers), maxActionsPerGrid, 1);
  autosizegrid(SGCwUsers);

end;

procedure TForm2.btnDblCheckCwClick(Sender: TObject);
var
  sl: TStringList;
  slweg: TStringList;
  i, n: Integer;
  doubleCount: Integer;
  gt: Cardinal;
  da: doublearray; // array of integer;
  ia: intarray; // array of double;
  ct: Integer;
begin
  doubleCount := 0;
  ct := length(cwActions);
  SetLength(ia, ct);
  SetLength(da, ct);
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
      if (cwActions[strtoint(sl.ValueFromIndex[i])].typeId <> 7) then
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
  // neuer Zähler ist um doubleCount kleiner
  ct := n + 1;
  SetLength(cwActions, ct);
  showmessage('jetzt im Cache:' + inttostr(ct) + ' Zeit:' + inttostr(timegettime - gt));

  sl.clear;
  slweg.clear;
  btnShowCacheCwClick(nil); // darstellen
end;

procedure TForm2.btnDoubleRemoveCwClick(Sender: TObject);
var
  sl: TStringList;
  i, dptr: Integer;
  killed: string;
  dummy: DAcwaction;
begin
  // Doubles remove
  // Dient dazu alle doppelten Einträge KOMPLETT zu entfernen
  // so kann aus einer Suche durch erneutes drübersuchen etwas verdoppelt und dann entfernt werden
  if cwActionsSelectionCt < 1 then
    exit;

  sl := TStringList.Create;
  for i := 0 to cwActionsSelectionCt - 1 do
  begin
    sl.Add(inttostr(cwActionsSelection[i].actionId) + '=' + inttostr(i))
  end;
  // sl.Sort;
  FastSortStList(sl, 'AU');
  SetLength(dummy, cwActionsSelectionCt);
  dptr := -1;
  // sl.names[]  sl.valuefromindex[]
  for i := 0 to cwActionsSelectionCt - 2 do
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
        dummy[dptr] := cwActionsSelection[strtoint(sl.ValueFromIndex[i])];
      end;
    end;
  end;
  // nun noch der letzte
  if (sl.Names[cwActionsSelectionCt - 1] <> killed) then
  begin
    dptr := dptr + 1;
    dummy[dptr] := cwActionsSelection[strtoint(sl.ValueFromIndex[cwActionsSelectionCt - 1])];
  end;
  // kopieren
  cwActionsSelection := Copy(dummy, 0, cwActionsSelectionCt);
  cwActionsSelectionCt := dptr + 1;
  SetLength(cwActionsSelection, cwActionsSelectionCt);

  doActionsGridCW(SGCacheCwSearch, SGFieldCol, cwActionsSelection, cwActionsSelectionCt, cwActionsSelectionCt, 1);
  // lblCacheCwSearchResult.Caption := inttostr(cwActionsSelectionCt);
  sl.clear;
  doCacheGridCwInfo;
end;

procedure TForm2.doCacheGridCwInfo;
begin
  // pnlCacheCw.Caption := 'CacheGrid:' + inttostr(SGCache.RowCount - 1);
  // lblCacheCwSearchResult.Caption := inttostr(cwActionsSelectionCt + 1); // + ' in:' + inttostr(timegettime - gt);

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
procedure TForm2.SGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
  grid: FTCommons.TStringGridSorted;
  col, row: Integer;
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
    gridMouseLeftClickHandler(grid, col, row, grid.Cells[col, row], grid.Cells[col, 0], grid.Cells[0, row]);
    ClipBoard.AsText := grid.Cells[col, row];

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
          for i := 0 to grid.ColCount - 1 do
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
          for i := 0 to grid.ColCount - 1 do
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
    end;
    LbDebug('Zeit Gridsort:' + inttostr(timegettime - gt));
  end;

  procedure TForm2.SortStringGridCW(var genstrgrid: FTCommons.TStringGridSorted; ThatCol: Integer; sortTyp: Integer);

  const
    // Define the Separator
    TheSeparator = '@';
  var
    CountItem, i, k: Integer;
    MyList: TStringList;
    da: doublearray;
    ia: intarray;
    gt: Cardinal;
  begin
    // Give the number of rows in the StringGrid
    CountItem := genstrgrid.rowcount;
    // Create the List
    MyList := TStringList.Create;
    MyList.Sorted := false;
    SetLength(ia, CountItem - 1);
    SetLength(da, CountItem - 1);

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
      MyList.Free;
    end;

  end;

  procedure TForm2.SortStringGrid(var genstrgrid: FTCommons.TStringGridSorted; ThatCol: Integer; sortTyp: Integer);

  const
    // Define the Separator
    TheSeparator = '@';
  var
    CountItem, i, j, k, ThePosition: Integer;
    MyList: TStringList;
    gt: Cardinal;
  begin
    // Give the number of rows in the StringGrid
    CountItem := genstrgrid.rowcount;
    // Create the List
    MyList := TStringList.Create;
    MyList.Sorted := false;
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
      MyList.Free;
    end;

  end;

  procedure TForm2.TabSheet2Resize(Sender: TObject);
  begin
    Panel10.Left := trunc(TabSheet2.width / 2) - trunc(Panel10.width / 2);
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

  procedure TForm2.lbCSVErrorClick(Sender: TObject);
  begin
    lbCSVError.Items.clear;
  end;

  function TForm2.doHttpGetByteArrayFromWorker(var bArray: Bytearray; url: string): Integer;
  var
    flag: Integer;
    gt, ngt: Cardinal;

    li: Integer;
    liText: array [1 .. 15] of string;

  begin
    while (HTTPWorker1.RequestBusy = true) do
    begin
      dosleep(100);
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
    HTTPWorker1.bArray := bArray;

    leaveCriticalSection(HTTPWorkCriticalSection);
    // damit sind die Variablen gesetzt und der Thread kann ab jetzt arbeiten
    flag := 0;
    lblWarten.Caption := '********************';
    liText[1] :=
      'Beim ersten Laden der Actions wird ein Cache angelegt, der später für einen schnellen Programmstart sorgt';
    liText[2] :=
      'Das erste Laden aller über 3 Millionen Actions kann je nach Internetgeschwindigkeit etliche Minuten dauern';
    liText[3] := 'Die Grids können durch Rechtsclick in die Spaltenheader sortiert werden';
    liText[4] := 'Es kann sich nur noch um Stunden handeln ... noch etwas Geduld !';
    liText[5] := 'Es wurden inzwischen ' + inttostr(length(cwSymbols)) + ' Symbole geladen';
    liText[6] := 'Es wurden inzwischen ' + inttostr(length(cwUsers)) + ' User geladen';
    liText[7] := 'Es wurden inzwischen ' + inttostr(length(cwComments)) + ' Kommentare geladen';
    gt := GetTickCount;
    ngt := gt + 1000;
    li := 0;
    while (HTTPWorker1.RequestBusy = true) do
    begin
      gt := GetTickCount;
      dosleep(100);
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

  procedure TForm2.dosleep(t: Integer);
  var
    gt: Cardinal;
  begin
    gt := GetTickCount();
    repeat
      Application.ProcessMessages;
    until (GetTickCount - gt) > t;
    // lbstatisticsPumpAdd('sleep rum:' + inttostr(t));
  end;

  procedure TForm2.FormDestroy(Sender: TObject);
  begin
    if HTTPWorker1.Finished = false then
    begin
      HTTPWorker1.Terminate;
      HTTPWorker1.waitfor;
      HTTPWorker1.Free;
      HTTPWorker1.ResultList.Free;
      HTTPWorker1Aktiv := false;
      dosleep(10);
    end;
    DeleteCriticalSection(HTTPWorkCriticalSection);

  end;

  procedure TForm2.Button3Click(Sender: TObject);
  begin
    maxActionsPerGrid := strtoint(edMaxActionsPerGrid.text);
    btnCwactionsToGridClick(nil);
  end;

  procedure TForm2.Button4Click(Sender: TObject);
  begin
    StartHTTPWorker;
  end;

end.
