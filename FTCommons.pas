unit FTCommons;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ManagerAPI, StdCtrls, ExtCtrls, Vcl.Grids, StrUtils, Vcl.ComCtrls, IniFiles,  StringGridSorted, Vcl.FileCtrl, Button1, System.generics.collections, Vcl.Buttons, IdHTTP, IdGlobal,
  psAPI, System.zip, Wininet, HTTPApp, IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze, FTTypes,
  System.NetEncoding, DateUtils, csCSV, SHELLAPI, MMSYSTEM;

const

  FileNameForbiddenChars: set of Char = ['<', '>', '|', '"', '\', '/', ':', '*', '?'];
  BoolStr: Array [Boolean] of AnsiString = ('False', 'True');
  NoSelection: TGridRect = (Left: - 1; Top: - 1; Right: - 1; Bottom: - 1);
  // Use crKey as the transparency color.
  LWA_COLORKEY = 1;
  // Use bAlpha to determine the opacity of the layered window..
  LWA_ALPHA = 2;
  WS_EX_LAYERED = $80000;
  cCachefile = 'Actions';
  cCacheFolder = 'cache';
  cUpdateTimerInterval = 600000;
  cServerPort = '8081';

type

  // das ist wohl ein Trick wie man nichts umbenennen muss, wenn man eine neue Klasse von einer anderen Klasse ableitet.
  // Es bleibt hier beim Namen TStringGridSorted

  { This explains part of the speed! I wish I (really) knew why!
    If this declaration is placed in connection with the
    procedure the whole procedure is more than ten times slower.
    The reason may be that placing it here means that the array is
    created when the program loads - if it is declared "locally"
    it is not created until the procedure requests it. }

  TTradeRecord = packed record
    // Das ist der originale Datentyp aus der API der in diesem Programm eigentlich nicht verwendet wird - nur zur Fehlersuche in den OTR-Files
    order: integer; // order number
    login: integer; // account login
    symbol: TStr12; // symbol
    digits: integer; // symbol digits
    cmd: integer; // trade comand
    volume: integer; // trade volume
    open_time: time_t; // trade open time
    open_reserv: integer; // reserved         c:state
    open_price: double; // trade open price
    sl, tp: double; // StopLoss,TakeProfit
    close_time: time_t; // trade close time
    value_date: time_t; // value date       c:gateway order volume
    expiration: time_t; // pending order expiration date
    conv_reserv: integer; // reserved     c:reason  c:conv_reserv[3]
    conv_rates: array [0 .. 1] of double; // convertation rates
    commission: double; // commission
    commission_agent: double; // agent commission
    storage: double; // swap
    close_price: double; // trade close price
    profit: double; // trade profit
    taxes: double; // taxes
    magic: integer; // unique magic number
    comment: TStr32; // comment
    internal_id: integer; // (internal usage)  -> Gateway Order Ticket
    activation: integer; // activation type
    margin_reserved: integer; // reserved          c:gw_open_rice gw_close_price in pips from order open / close price
    margin_rate: double; // margin convertation rate (rate of convertation from margin currency to deposit one)
    reserved: array [0 .. 4] of integer; // reserved
    next: PTradeRecord; // (internal usage)
    // function getJSON(accountId: integer): string;
  end;

  DATradeRecord = array of TTradeRecord; // um die OTR Files einzulesen

  TOurHttp = class(TIdHttp)
  public
    procedure Get(aUrl: String; aRequestBody, aResponseContent: TStream);
  end;

  EvaluationResult = record
    z1: TDateTime; // Startzeit der Auswertung inclusive    1. bis 2. berechnet also den gesamten 1.
    z2: TDateTime; // Endzeit der Auswertung exclusive
    profit1: array [1 .. 4] of double; // offener Profit Beginnn  ungew�hnlich 1..4 da die W�hrungen so laufen !
    profit: array [1 .. 4] of double; // realisierter Profit im Zeitraum
    profit2: array [1 .. 4] of double; // offener Profit am Ende
    swap1: double;
    swap: double;
    swap2: double;
    volume1: integer;
    volume: integer;
    volume2: integer;
    ct1: integer; // Zeit1 Anzahl Orders
    ct: integer; // innerhalb Z1Z2 realisierte Orders
    ct2: integer; // Zeit2 Anzahl Orders
    ct1nix: integer;
    ctnix: integer;
    ct2nix: integer;
    usersCt: integer; // Anzahl User getradet im Zeitraum
    usersCt2: integer; // schau mer mal
    mostSymbols: string;
    procedure clear;
  end;

  tExport = record
    fileName: string;
    separator: string;
    sl: TStringList;
    onlySelection: Boolean; // 28.10.19 vorgesehen f�r CSV Export nur die Selektion
  end;

  pExport = ^tExport;

  tInfo = record
    usersOnline: integer;
    openActions: integer;
    newUsers1d: integer;
    newUsers1w: integer;
    newUsers1m: integer;
    newUsers1y: integer;
    logUsers1d: integer;
    logUsers1w: integer;
    logUsers1m: integer;
    logUsers1y: integer;
    newActions1d: integer;
    newActions1w: integer;
    newActions1m: integer;
    newActions1y: integer;
    profit1d: double;
    profit1w: double;
    profit1m: double;
    profit1y: double;
    ctHWMY: string;
    lastUpdateOnServer: TDateTime;
    // letzte Serverupdate-Zeit mit kompletten Daten = die Startzeit der Verarbeitung FTCOll->Server - geschrieben wenn Upload fertig ist
    lastUpdateOnClient: TDateTime; // letzte Serverupdate-Zeit die vom Client verarbeitet wurde
  end;

  TPieParameters = Packed record
    // diverse Einstellparameter
    header: string;
  end;

  TPieValue = Packed record
    value: double;
    text: string;
    color1: integer;
    color2: integer;
    indent: integer;
  end;

  DAPieValue = array of TPieValue;

  StringArray = array of string;

  TFilterParameter = packed record
    active: Boolean;
    topic: string;
    operator: string;
    values: string;
    comment: string;
    // vglI: array of integer;
    // vglS: array of string;
  end;

  TStringGridSorted = class(StringGridSorted.TStringGridSorted)
    procedure WndProc(var Msg: TMessage); override;
    // procedure MoveColumn(FromIndex, ToIndex: Longint);
    // procedure MoveRow(FromIndex, ToIndex: Longint);
  private
  public
  var
    test: integer;
  end;

  TButton = class(Vcl.StdCtrls.TButton)
  private
  public
  var
    test: integer;
  end;

  intArray = array of integer;

  int64Array = array of int64;

  doubleArray = array of double;

  DAInteger = array of integer;

  // die offenen Orders in Kompaktform
  cwOpenAction = packed record
    actionId: int64;
    userId: integer;
    swap: double;
    profit: double;
  end;

  DACwOpenActions = array of cwOpenAction;

  cwTick = packed record // f�r die �bertragung an den Server. Sowohl �ber JSON als auch bin m�glich
    time: integer; // 4    reicht bis 2030  -  sonst 8 dword Unix Sekunden seit 1970
    bid: double; // 8
    ask: double; // 8
    symbol: TStr12;
  end;

  DACwTick = array of cwTick;

  TKursOCHLV = packed Record // Basiskurs ist der BID Kurs Die Spread-Info geht dabei verloren.
    lasttime: time_t;
    open: single;
    close: single;
    high: single;
    low: single;
    volume: integer;
  end;

  DAKursOCHL = array of TKursOCHLV;

  TKurs = packed record //
    bid: single; // 4
    ask: single; // 4
    lasttime: time_t; // 8 dword Unix Sekunden seit 1970
  end;

  cwRating = packed record
    userId: integer;
    balance: double;
    equity: double;
    volume: integer;
    margin: double;
    function getJSON(): string;
  end;

  DACwRating = array of cwRating;

  // vom Server an Client
  cwAction = packed Record
    actionId: int64; // 8
    userId: integer; // 4
    accountId: integer; // 4
    symbolId: integer; // 4
    commentId: integer; // 4
    typeId: integer; // 4
    sourceId: integer; // 4
    openTime: integer; // 8
    closeTime: integer; // 8
    expirationTime: integer; // 8
    openPrice: double; // 8
    closePrice: double; // 8
    stopLoss: double; // 8
    takeProfit: double; // 8
    swap: double; // 8
    profit: double; // 8
    volume: integer; // 4
    precision: integer; // 4
    conversionRate0: double; // 8
    conversionRate1: double; // 8
    marginRate: double; // 8
  End;

  DACwAction = array of cwAction; // hier sind Elemente NICHT �ber Pointer[i] ansprechbar.

  cwActionPlus = packed Record
    userIndex: integer; // f�r die schnellere Suche !
    openProfit: double;
    openSwap: double;
    openProfitStart: double; // Am Beginn des Zeitraums
    openSwapStart: double; // Am Beginn des Zeitraums
  End;

  DACwActionPlus = array of cwActionPlus; // hier sind Elemente NICHT �ber Pointer[i] ansprechbar.

  cwUserPlus = packed Record
    totalSymbols: integer;
    totalTrades: integer;
    totalProfit: double;
    totalBalance: double;
    totalSwap: double;
    lastOpenAction: integer;
    deadSince: integer; // seit wann weder Action noch Login
    accountCurrency: integer; // 1=EUR 2=USD 3=CHF 4=GBP ... 0=unbekannt
    silentDays: integer;
    multi: integer; // zur freien Verwendung (bei cwusersx der Index aus cwusers)
    marker: string;
  End;

  DACwUserPlus = array of cwUserPlus; // hier sind Elemente NICHT �ber Pointer[i] ansprechbar.

  cwSummary = packed Record
    par0: string; // Gruppierung 1-3
    par1: string;
    par2: string;
    sTradesCount: integer;
    sTradesVolumeTotal: integer;
    sTradesUsers: integer; // wieviele User handelten Symbol. Nur bei handlebarer Anzahl berechenbar !
    sTradesProfitTotal: double;
    sTradesSwapTotal: double;
    sTradesProfitSwapTotal: double;
    Plus: array [0 .. 12] of double; // Platzhalten erstmal f�r die zus�tzlichen Felder ...
    merk: string; // dient sp�ter der Ermittlung der sTradesUsers
  End;

  DACwSummary = array of cwSummary;
  DA3CwSummary = array of array of DACwSummary;

  cwGroupElement = packed record
    typ: integer;
    sTyp: string; // unused symbolGroup user datumJahre datumMonate datumSpezial
    header: string; // was steht sp�ter im Grid als Spalten�berschrift
  end;

  cwGroupElemente = packed record
    element: array [0 .. 2] of cwGroupElement;
  end;

  cwSymbolGroup = packed Record
    groupId: integer;
    name: string; // GE30
    sourceNames: string; // GE30-Apr;GE30-Jul...
    sourceIds: string; // 122;133;155;...
    TradesCount: integer;
    TradesVolumeTotal: integer;
    TradesUsers: integer; // wieviele User handelten Symbol
    TradesProfitTotal: double;
    TradesSwapTotal: double;
    TradesProfitSwapTotal: double;

  End;

  DACwSymbolGroup = array of cwSymbolGroup;

  cwSymbolPlus = packed Record
    TradesCount: integer;
    TradesVolumeTotal: double;
    TradesUsers: integer; // wieviele User handelten Symbol
    TradesProfitTotal: double;
    TradesSwapTotal: double;
    TradesProfitSwapTotal: double;
    groupId: integer; // symbolsgroup  ok
  End;

  DACwSymbolPlus = array of cwSymbolPlus; // hier sind Elemente NICHT �ber Pointer[i] ansprechbar.

  cwCommentPlus = packed Record
    total: integer;
  End;

  DACwCommentPlus = array of cwCommentPlus; // hier sind Elemente NICHT �ber Pointer[i] ansprechbar.

  cwUser = packed record // cwuser cwsymbol und cwcomment verwenden keine fixen Strings !
    userId: integer;
    accountId: integer;
    group: string;
    enable: integer;
    registrationTime: integer;
    lastLoginTime: integer;
    leverage: integer;
    balance: double;
    balancePreviousMonth: double;
    balancePreviousDay: double;
    credit: double;
    interestrate: double;
    taxes: double;
    name: string;
    country: string;
    city: string;
    state: string;
    zipcode: string;
    address: string;
    phone: string;
    email: string;
    socialNumber: string;
    comment: string;
  end;

  DAcwUser = array of cwUser;

  cwSymbol = packed Record
    symbolId: integer;
    brokerId: integer;
    name: string;
    description: string;
    currency: string; // currency
    margin_currency: string; // currency of margin requirments
    digits: integer; // security precision
    tradeMode: integer; // trade mode
    expiration: integer; // time_t; // trades end date      (UNIX time)
    contractSize: double;
    tickValue: double; // one tick value
    tickSize: double; // one tick size
    type_: integer; // security group (see ConSymbolGroup)
  End;

  DACwSymbol = array of cwSymbol;

  DAstring = array of string;

  cwComment = packed record
    commentId: integer;
    text: string;
  end;

  DAcwComment = array of cwComment;

  // byteArray = array of byte;

procedure lbAdd(lb: TListBox; s: string);

function findCwactionFromId(id: int64): integer;

function getSessionKey(var key: string): integer;
function GetModuleVersion(Instance: THandle; out iMajor, iMinor, iRelease, iBuild: integer): Boolean;
function DateTimeToUnix(ConvDate: TDateTime): Longint;
function UnixToDateTime(UnixTime: dword): TDateTime;
function doHTTPGetByteArray(Url: string; lbHTTP: TListBox): byteArray;
function StringListSortComparefnUp(List: TStringList; Index1, Index2: integer): integer;
function StringListSortComparefnDown(List: TStringList; Index1, Index2: integer): integer;
function myStringToFloat(s: String): double;
function CurrentProcessMemory: Cardinal;
function GetUrlContent(const Url: string): string;
function cwpos(const s: string; c: Char): integer;
function WideStringToString(const Source: UnicodeString; CodePage: UINT): RawByteString;
function MemoryStreamToString(M: TMemoryStream): RawByteString;
function byteArrayToString(b: Array of byte): RawByteString;
function MyStrToFloat(AString: string): double;
procedure FillCharArray(var a: TStr12; const s: String);
procedure SwapRowField(rf: array of integer; fr: array of integer; von, nach: integer);
procedure generateMinutes(var ticks: array of TKurs; var mBars: DAKursOCHL; minutes: integer);
procedure ParseDelimited(theme: string; const sl: TListBox; const value: AnsiString; const delimiter: string; var vu: DAcwUser; var vs: DACwSymbol; var vt: DACwTick; var vc: DAcwComment; const ms: TStream; append: Boolean);
procedure splitHeadLine(value: string; var headers: DAstring; var headerz: integer; delimiter: string);

function getCwComment(id: integer): string;
function getCwSymbol(id: integer): string;
function OrderTypes(cmd: integer): string;
procedure saveCacheFileCw(fname: string; typ: string; lb: TListBox);
function loadCacheFileCw(fname: string; typ: string; lb: TListBox): integer;
procedure saveOpenActionsBuffer(fname: string; ba: byteArray);
function loadOpenActionsBuffer(fname: string; var ba: byteArray): integer;

// A=Alpha V=Value U=Up D=Down
procedure QuicksortAU(low, high: integer; var Ordliste: StringArray); // StringArray ist Array of String
procedure QuicksortAD(low, high: integer; var Ordliste: StringArray);
procedure QuicksortVU(low, high: integer; var Ordliste: StringArray);
procedure QuicksortVD(low, high: integer; var Ordliste: StringArray);
procedure QuicksortVUA(low, high: integer; var dbla: doubleArray; var inta: intArray);
procedure QuicksortVDA(low, high: integer; var dbla: doubleArray; var inta: intArray);
procedure QuicksortUAStringInt(low, high: integer; var dbla: StringArray; var inta: intArray);
procedure QuicksortVDAS(low, high: integer; var dbla: StringArray; var inta: intArray);
procedure QuicksortVUAIntegerString(low, high: integer; var inta: intArray; var stra: StringArray);

procedure QuicksortVUI(low, high: integer; var dbla: intArray; var inta: intArray);
procedure QuicksortVDI(low, high: integer; var dbla: intArray; var inta: intArray);

procedure QuicksortVUI64(low, high: integer; var dbla: int64Array; var inta: intArray);
procedure QuicksortVDI64(low, high: integer; var dbla: int64Array; var inta: intArray);

procedure FastSortStList(Stlist: TStringList; sTyp: string);
procedure FastSort2ArrayDouble(dbla: doubleArray; inta: intArray; sTyp: string);
// sortiert nach value eines double-arrays und zieht integer-array dabei mit
procedure FastSort2ArrayString(stra: StringArray; inta: intArray; sTyp: string);
procedure FastSort2ArrayIntegerString(inta: intArray; stra: StringArray; sTyp: string);
procedure FastSort2ArrayStringInteger(inta: intArray; stra: StringArray; sTyp: string);
procedure FastSort2ArrayIntInt(dbla: intArray; inta: intArray; sTyp: string);
procedure FastSort2ArrayInt64Int(dbla: int64Array; inta: intArray; sTyp: string);

function CTime2DateTime(T: time_c): TDateTime;
function DateTime2CTime(T: TDateTime): time_c;
procedure swap(var Value1, Value2: string);
procedure SwapDbl(var Value1, Value2: double);
procedure SwapInt(var Value1, Value2: integer);
procedure SwapInt64(var Value1, Value2: int64);

function GetPIndex(lo, hi: integer): integer;
function strGleichToFloat(s: string): double;
procedure ClearStringGridSorted(const Grid: FTCommons.TStringGridSorted);
procedure lbDebug(s: string);
procedure lbCSVDebug(s: string);
procedure AutoSizeGrid(Grid, Grid2: FTCommons.TStringGridSorted);
procedure dosleep(T: integer);

procedure doOpenActionsGridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var actions: DACwOpenActions; var selSorted: byteArray; datafrom: integer; datato: integer; justone: Boolean = false; sl: TStringList = nil; onlySelection: Boolean = false);

procedure doOpenActionsOTRGridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var actions: DATradeRecord; var selSorted: byteArray; datafrom: integer; datato: integer; justone: Boolean = false; sl: TStringList = nil; onlySelection: Boolean = false);

procedure doActionsGridCW(SG: TStringGridSorted; SGFieldCol: DAInteger; actions: DACwAction; ct: integer; total: integer; stp: integer = 1);

procedure doUsersGridCW(SG: TStringGridSorted; SGFieldCol: DAInteger; users: DAcwUser; usersPlus: DACwUserPlus; ct: integer; total: integer; stp: integer = 1);

procedure doCommentsGridCW(SG: TStringGridSorted; SGFieldCol: DAInteger; comments: DAcwComment; commentsPlus: DACwCommentPlus; ct, total, stp: integer);

procedure doSymbolsGridCW(SG: TStringGridSorted; SGFieldCol: DAInteger; symbols: DACwSymbol; symbolsPlus: DACwSymbolPlus; ct: integer; total: integer; stp: integer = 1);
procedure doSymbolsGroupsGridCW(SG: TStringGridSorted; SGFieldCol: DAInteger; symbolsGroups: DACwSymbolGroup; ct, total, stp: integer);

procedure doActionsGridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var actions: DACwAction; var actionsPlus: DACwActionPlus; var selSorted: byteArray; datafrom: integer; datato: integer; justone: Boolean = false; sl: TStringList = nil;
  onlySelection: Boolean = false);

procedure doCommentsGridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var comments: DAcwComment; var selSorted: byteArray; datafrom: integer; datato: integer; justone: Boolean = false; sl: TStringList = nil; onlySelection: Boolean = false);

procedure doUsersGridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var users: DAcwUser; usersPlus: DACwUserPlus; var selSorted: byteArray; datafrom: integer; datato: integer; justone: Boolean = false; sl: TStringList = nil; onlySelection: Boolean = false);

procedure doSymbolsGridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var symbols: DACwSymbol; var symbolsPlus: DACwSymbolPlus; datafrom: integer; datato: integer; justone: Boolean = false);
procedure doSymbolsGroupsGridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var symbolsGroups: DACwSymbolGroup; datafrom: integer; datato: integer; justone: Boolean = false);
procedure doSummaries3GridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var summaries: DA3CwSummary; datafrom: integer; datato: integer; justone: Boolean = false);
procedure doSummariesGridCWDyn(var SG: TStringGridSorted; var SGSum: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var summaries: DACwSummary; datafrom: integer; datato: integer; justone: Boolean = false);

function BinSearchStringGleich(var Strings: StringArray; var v: integer): integer;
function BinSearchStringGleich2(var Strings: StringArray; var v: string): integer;

function BinSearchString(var Strings: StringArray; var v: string): integer;
function BinSearchString2(var Strings: StringArray; var Index: intArray; var v: integer): integer;
function BinSearchInt(var Ints: intArray; v: integer): integer;
function BinSearchInt64(var Ints: int64Array; v: int64): integer;
function BinSearchOpenActionsInt64(var actions: DACwOpenActions; v: int64): integer;

function findActionparameter(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var sel: byteArray; var actions: DACwAction; k: integer; col: integer; such: string; doCount: Boolean = false): integer;
function findUserparameter(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var sel: byteArray; var users: DAcwUser; k: integer; col: integer; such: string; doCount: Boolean = false): integer;

function findUserName(userId: integer): string;
function findUserIndex(userId: integer): integer;
function findUserSelectionName(userId: integer): string;
function findUserSelectionIndex(userId: integer): integer;

procedure computeSymbolGroupValues(var actions: DACwAction; var groups: DACwSymbolGroup; lb: TListBox);

function RandomRange(const AFrom, ATo: integer): integer;
function RGB2TColor(const R, G, b: byte): integer;
procedure showMemory(lb: TListBox);
function myStrToInt(AString: string): integer;
function TestFilename(fileName: String): Boolean;
function RInstr(const Str: string; const strSuche: string): integer;
function getDateTimeFromString(s: string): TDateTime;
function getUnixTimeFromString(s: string): integer;
function getNextMonth(dt: TDateTime): TDateTime;
function getPreviousMonth(dt: TDateTime): TDateTime;
function getStartOfMonth(dt: TDateTime): TDateTime;
function getNextYear(dt: TDateTime): TDateTime;
function getPreviousYear(dt: TDateTime): TDateTime;
function Get_File_Size(sFileToExamine: string): integer;
procedure DeleteFiles(APath, AFileSpec: string);
procedure writeUserMarkers();
procedure readUserMarkers();

var

  cwOpenActionsZ1: DACwOpenActions;
  cwOpenActionsZ2: DACwOpenActions;

  cwSingleUserActions: DACwAction;
  cwSingleUserActionsPlus: DACwActionPlus;
  cwSingleUserActionsCt: integer;

  cwSymbols: DACwSymbol;
  cwSymbolsPlus: DACwSymbolPlus;
  cwSymbolsCt: integer;

  cw3Summaries: DA3CwSummary;
  cw3SummariesCt: integer;
  cwSummaries: DACwSummary; // f�r das ausged�nnte Array ohne 3D Struktur
  cwSummariesCt: integer;

  cwSymbolsGroups: DACwSymbolGroup;
  cwSymbolsGroupsCt: integer;

  cwFilteredSymbolsGroups: DACwSymbolGroup;
  cwFilteredSymbolsGroupsCt: integer;

  cwSymbolsSortIndex: intArray; // sortierter Zugang zu cwsymbols

  cwUsers: DAcwUser;
  cwUsersPlus: DACwUserPlus;
  cwUsersCt: integer;
  cwUsersSortIndex: StringArray;
  cwUsersSortIndex2: intArray;
  cwUsersX: DAcwUser; // NEU 19.12.19 f�r eine User-Selektion
  cwUsersXPlus: DACwUserPlus;

  cwUsersSelection: DAcwUser;
  cwUsersSelectionPlus: DACwUserPlus;
  cwUsersSelectionCt: integer;
  cwUsersSelectionSortIndex: StringArray;
  cwUsersSelectionSortIndex2: intArray;

  cwTicks: DACwTick;
  cwTicksCt: integer;
  cwTradeRecords: DATradeRecord; // nur f�r die OTR Files
  cwComments: DAcwComment;
  cwCommentsPlus: DACwCommentPlus;
  cwCommentsCt: integer;
  cwActions: DACwAction; // 'Alle' Actions
  cwActionsPlus: DACwActionPlus; // 'Alle' Actions
  cwActionsCt: integer;
  cwActionsSorted: Boolean;
  cwActionsInt: intArray;
  cwActionsInt64: int64Array;

  cwFilteredActions: DACwAction; // die herausgesuchten Actions
  cwFilteredActionsPlus: DACwActionPlus; // die herausgesuchten Actions
  cwFilteredActionCt: integer;
  cwRatings: DACwRating;
  cwGrouping: cwGroupElemente;
  lboxDebug: TListBox;
  lbCSV: TListBox;
  lboxInfo: TListBox;
  cwFilterParameter: array of TFilterParameter;
  brokerShort: array [1 .. 2] of string;
  accountShort: array [1 .. 7] of string;
  accountCurrency: array [0 .. 4] of string;
  sessionKey: String;
  PSEvaluation: EvaluationResult;

implementation

uses XFlowAnalyzer;

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;
{$SETPEFLAGS IMAGE_FILE_LARGE_ADDRESS_AWARE}

procedure EvaluationResult.clear;
var
  i: integer;
begin
  for i := 1 to 4 do
  begin
    profit1[i] := 0;
    profit[i] := 0;
    profit2[i] := 0;
  end;
  swap1 := 0;
  swap := 0;
  swap2 := 0;

  volume := 0;
  volume1 := 0;
  volume2 := 0;

  ct := 0;
  ct1 := 0;
  ct2 := 0;

end;

procedure TOurHttp.Get(aUrl: String; aRequestBody, aResponseContent: TStream);
begin
  DoRequest(Id_HttpMethodGet, aUrl, aRequestBody, aResponseContent, []);
end;

function cwRating.getJSON(): string;
// wird aber nicht gebraucht
begin
  result := '{' + c34 + 'userId' + c34 + ':' + inttostr(userId) + ',' + c34 + 'balance' + c34 + ':' + FloatToSQLStr(balance) + ',' + c34 + 'equity' + c34 + ':' + FloatToSQLStr(equity) + ',' + c34 + 'volume' + c34 + ':' + inttostr(volume) + ',' + c34 + 'margin' + c34 + ':' +
    FloatToSQLStr(margin) + '}';
end;

procedure lbDebug(s: string);
begin
  if (lboxDebug <> nil) then
  begin
    lboxDebug.items.add(timetostr(now) + ':' + s);
  end;
end;

procedure lbCSVDebug(s: string);
begin
  if (lbCSV <> nil) then
  begin
    lbCSV.items.add(timetostr(now) + ':' + s);
  end;
end;

procedure lbInfo(s: string);
begin
  if (lboxInfo <> nil) then
  begin
    lboxInfo.items.add(timetostr(now) + ':' + s);
  end;
end;

function doHTTPGetByteArray(Url: string; lbHTTP: TListBox): byteArray;

var
  HTTP: TIdHttp;
  p: integer;
  b: byteArray;
  // stream:TStream;
  mStream: TMemoryStream;

begin
  // test HTTP Get
  HTTP := TIdHttp.Create;
  HTTP.ConnectTimeout := 400000;
  HTTP.ReadTimeout := 400000;
  mStream := TMemoryStream.Create;
  try
    try
      try
        try
          HTTP.Get(Url, mStream);
          mStream.Position := 0;
          // memo1.Lines.LoadFromStream(mStream);
          p := mStream.Size;
          SetLength(b, p);
          mStream.Read(b[0], p);
          result := b;
        except
          on E: Exception do
          begin
            lbHTTP.items.add(E.Message);
          end;
        end;
      finally
        mStream.Free;
      end;
    except
      on E: EIdHTTPProtocolException do
      begin
        lbHTTP.items.add(E.Message + #13#10#13#10 + E.ErrorMessage);
      end;
      on E: Exception do
      begin
        lbHTTP.items.add(E.Message);
      end;
    end;
  finally
    HTTP.Free;
  end;
end;

function StringListSortComparefnUp(List: TStringList; Index1, Index2: integer): integer;
var
  i1, i2: double;
  s1, s2: string;
  cs: integer;
begin
  s1 := List[Index1];
  s2 := List[Index2];

  i1 := myStringToFloat(List[Index1]);
  i2 := myStringToFloat(List[Index2]);
  if (i1 > i2) then
    result := 1
  else if (i1 = i2) then
  begin
    result := 0;
    cs := compareStr(s1, s2);
    if (cs > 0) then
      result := 1;
    if (cs < 0) then
      result := -1;

  end
  else
    result := -1;
  // Result := i1 - i2;
end;

function StringListSortComparefnDown(List: TStringList; Index1, Index2: integer): integer;
var
  i1, i2: double;
  s1, s2: string;
  cs: integer;
begin
  s1 := List[Index1];
  s2 := List[Index2];

  i1 := myStringToFloat(List[Index1]);
  i2 := myStringToFloat(List[Index2]);
  if (i1 > i2) then
    result := -1
  else if (i1 = i2) then
  begin
    result := 0;
    cs := compareStr(s1, s2);
    if (cs > 0) then
      result := -1;
    if (cs < 0) then
      result := 1;

  end
  else
    result := 1;
  // Result := i1 - i2;
end;

function myStringToFloat(s: String): double;
// kann -123.55xxxx ebenso wie 1.23.45 -> 1.23  aber keine e-Notation wie 1.2e+05
// kommt mit . UND , klar. Die jeweils 'falsche' Variante wird in die laut FormatSettings.DecimalSeparator g�ltige �bersetzt !!
// das wird dann aber logischerweise langsamer werden
var
  i: integer;
  ok: Boolean;
  ds, ds2: Char;

  sc: integer;

begin
  try
    ds := FormatSettings.DecimalSeparator;
    if (ds = '.') then
      ds2 := ','
    else
      ds2 := '.';

    ok := false;
    sc := 0;
    for i := 1 to length(s) do
    begin
      if (s[i] in ['0' .. '9']) then
        ok := true
      else if s[i] = ds2 then
      begin
        // der falsche Dezimalseparator muss durch den richtigen ersetzt werden
        s[i] := ds;
        sc := sc + 1;
        ok := true;
        if (sc > 1) then
        begin
          s := Copy(s, 1, i - 1);

          break;
        end
      end
      else if s[i] = ds then
      begin
        sc := sc + 1;
        ok := true;
        if (sc > 1) then
        begin
          s := Copy(s, 1, i - 1);

          break;
        end
      end
      else if ((s[i] = '-') and (i = 1)) then
      begin
        ok := true;
      end
      else
      begin
        s := Copy(s, 1, i - 1);

        break;
      end
    end;
    if ok = true then
    begin
      if (s = '-') then
        s := '0';

      result := StrToFloat(s)
    end
    else
      result := 0;

    // debug(Floattostr(result));
  except
    result := 0;
  end;
end;

function CurrentProcessMemory: Cardinal;
var
  MemCounters: TProcessMemoryCounters;
begin
  MemCounters.cb := SizeOf(MemCounters);
  if GetProcessMemoryInfo(GetCurrentProcess, @MemCounters, SizeOf(MemCounters)) then
    result := MemCounters.WorkingSetSize
  else
    RaiseLastOSError;
end;

function GetUrlContent(const Url: string): string;
// diese Variante verwendet die Wininet-DLL
const
  bsize = 1000;

var
  NetHandle: HINTERNET;
  UrlHandle: HINTERNET;
  // die L�nge habe ich mit 64 und 16384 probiert und kaum einen Unterschied festgestellt
  Buffer: array [1 .. bsize] of AnsiChar;
  BytesRead: dword;
  s: string;
begin

  result := '';
  s := '';
  NetHandle := InternetOpen('Delphi 5.x', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

  if Assigned(NetHandle) then
  begin
    UrlHandle := InternetOpenUrl(NetHandle, PChar(Url), nil, 0, INTERNET_FLAG_RELOAD, 0);

    if Assigned(UrlHandle) then
    begin
      FillChar(Buffer, SizeOf(Buffer), 0);
      repeat
        // merkw�rdig - eigentlich wird beim ersten mal ein 1000 Nullen Buffer an result angeh�ngt. Die Nullen werden aber offenbar in einem String ignoriert ???
        InternetReadFile(UrlHandle, @Buffer, SizeOf(Buffer), BytesRead);

        if (BytesRead > 0) then
        begin
          if (BytesRead < bsize) then
            result := result + leftstr(Buffer, BytesRead)
          else
            result := result + Buffer;

          FillChar(Buffer, SizeOf(Buffer), 0); // warum eigentlich noch ?

        end;
      until BytesRead = 0;
      InternetCloseHandle(UrlHandle);
    end
    else
      { UrlHandle is not valid. Raise an exception. }
      raise Exception.CreateFmt('Cannot open URL %s', [Url]);

    InternetCloseHandle(NetHandle);
  end
  else
    { NetHandle is not valid. Raise an exception }
    raise Exception.Create('Unable to initialize Wininet');
end;

procedure SwapRowField(rf: array of integer; fr: array of integer; von, nach: integer);
var
  max: integer;
  i, merk: integer;
begin
  max := high(rf);
  // fr fieldrow wird einElement von nach verschoben
  if (von < nach) then
  begin
    merk := rf[von];
    for i := von to nach - 1 do
    begin
      rf[i] := rf[i + 1];
    end;
    rf[nach] := merk;
  end;
  if (von > nach) then
  begin
    merk := rf[nach];
    for i := 0 to (von - nach) - 1 do
    begin
      rf[nach - i] := rf[nach - i - 1];
    end;
    rf[von] := merk;
  end;

  for i := 0 to max - 1 do
  begin
    fr[rf[i]] := i;
  end;

end;

function cwpos(const s: string; c: Char): integer;
var
  i: integer;
begin
  for i := 1 to length(s) do
  begin
    if (s[i] = c) then
    begin
      result := i;
      exit;
    end;
  end;
  result := 0;
end;

function WideStringToString(const Source: UnicodeString; CodePage: UINT): RawByteString;
var
  strLen: integer;
begin
  strLen := LocaleCharsFromUnicode(CodePage, 0, PWideChar(Source), length(Source), nil, 0, nil, nil);
  if strLen > 0 then
  begin
    SetLength(result, strLen);
    LocaleCharsFromUnicode(CodePage, 0, PWideChar(Source), length(Source), PAnsiChar(result), strLen, nil, nil);
    SetCodePage(result, CodePage, false);
  end;
end;

function MemoryStreamToString(M: TMemoryStream): RawByteString;
begin
  SetString(result, PChar(M.Memory), M.Size div SizeOf(Char));
end;

function byteArrayToString(b: Array of byte): RawByteString;

var
  i: integer;
begin
  result := '';
  for i := Low(b) to High(b) do
    result := result + chr(b[i]);
end;

function myStrToInt(AString: string): integer;
begin
  try
    result := strtoint(AString);
  except
    result := 0;
  end;
end;

function MyStrToFloat(AString: string): double;
begin
  if (AString = '') then
    result := 0
  else
  begin
    AString := StringReplace(AString, '.', FormatSettings.DecimalSeparator, [rfIgnoreCase, rfReplaceAll]);
    AString := StringReplace(AString, ',', FormatSettings.DecimalSeparator, [rfIgnoreCase, rfReplaceAll]);
    try
      result := StrToFloat(AString);
    except
      result := 0;
    end;
  end;
end;

// f�llt ein char array mit den Zeichen eines Strings
// https://www.delphipraxis.net/65569-string-zu-array-char.html
procedure FillCharArray(var a: TStr12; // char array, welches gef�llt werden soll
  const s: String // string, der die Zeichen liefert
  );
var
  i, j: integer;
begin
  // weil die untere Grenze des char array verschoben sein kann,
  // und ich den Index f�r den String s nicht jedesmal mit
  // einem komplizierten Ausdruck berechnen will, verwende ich
  // eine zweite Laufvariable j zur Indizierung von s
  j := 0;
  // Um die Funktion allgemein zu halten greife ich nicht auf
  // die mir bekannten array Grenzen zu, sondern verwende die
  // Funktionen Low() und High()
  for i := Low(a) to High(a) do
  begin
    // Das erste Zeichen in einem String muss �ber den Index 1
    // angesprochen werden
    Inc(j);
    // Wenn im String s keine weiteren Zeichen mehr f�r mein
    // array enthalten sind,
    if i > length(s)
    // dann f�lle ich mit dem speziellen #0 auf
    then
      a[i] := #0
      // sonst �bernehme ich ein weiteres Zeichen
    else
      a[i] := AnsiChar(s[j]);
  end;
end;

procedure generateMinutes(var ticks: array of TKurs; var mBars: DAKursOCHL; minutes: integer);
var
  i: integer;
  tick: TKurs;
  open, high_, low, close: single;
  cseconds: integer;
  secint: integer; // das Intervall seit 1970 aus diesen Seconds  secint*cseconds-> die genaue Uhrzeit/Datum
  merksecint: integer;
  mbc: integer;
  mbmax: integer;
  tmax: integer;
begin
  merksecint := 0;
  mbmax := 0;
  mbc := -1;
  high_ := -1;
  low := 99999999;
  if minutes > 0 then

    cseconds := minutes * 60 // auf diese Sekundenzahl hin wird normiert
  else
    cseconds := -minutes; // auf diese Sekundenzahl hin wird normiert

  tmax := high(ticks);
  for i := 0 to tmax do
  begin
    tick := ticks[i];
    secint := trunc(tick.lasttime / cseconds);
    if merksecint = 0 then
    begin
      open := tick.bid;
      high_ := open;
      low := open;
      close := open;
      merksecint := secint; // erstes mal
    end;
    if secint <> merksecint then
    begin
      mbc := mbc + 1;
      if mbc = mbmax then
      begin
        mbmax := mbmax + 1000;
        SetLength(mBars, mbmax);
      end;
      mBars[mbc].open := open;
      mBars[mbc].high := high_;
      mBars[mbc].low := low;
      mBars[mbc].close := close;
      mBars[mbc].lasttime := secint * cseconds;
      open := tick.bid;
      high_ := open;
      low := open;
      close := open;
      merksecint := secint;
    end
    else
    begin
      if tick.bid > high_ then
        high_ := tick.bid;
      if tick.bid < low then
        low := tick.bid;
      close := tick.bid;
    end;
  end;
  // den letzten noch verarbeiten
  mbc := mbc + 1;
  if mbc = mbmax then
  begin
    mbmax := mbmax + 1000;
    SetLength(mBars, mbmax);
  end;
  mBars[mbc].open := open;
  mBars[mbc].high := high_;
  mBars[mbc].low := low;
  mBars[mbc].close := close;
  mBars[mbc].lasttime := secint * cseconds;
  SetLength(mBars, mbc + 1);
end;
// ParseDelimited('symbols', lbDebug2, s, #13 + #10, cwUsers, cwSymbols, cwTicks, cwComments, ms);

procedure ParseDelimited(theme: string; const sl: TListBox; const value: AnsiString; const delimiter: string; var vu: DAcwUser; var vs: DACwSymbol; var vt: DACwTick; var vc: DAcwComment; const ms: TStream; append: Boolean);
// von TMemoryStream auf TStream abge�ndert ,damit auch TFileStream gelesen werden kann !
var
  ns: string;
  s: string;
  lc: integer;
  itheme: integer;
  headers: DAstring;
  headerz: integer;
  values: DAstring;
  valuez: integer;
  i: integer;
  max: integer;
  headok: Boolean;
  csvReader: TCsvReader;
  dummy: string;
  l: integer;
  ok: Boolean;
  gt: Cardinal;
begin
  // append wird nur bei Users relevant !
  gt := GetTickCount;
  headok := false;

  max := 100;
  if theme = 'users' then
  begin
    // laufen ab Id=0
    itheme := 1;
    if append = true then
    begin
      lc := length(vu) - 1;
      SetLength(vu, length(vu) + max);
    end
    else
    begin
      SetLength(vu, max);
      lc := -1;
    end;
  end;
  if theme = 'symbols' then
  begin
    // 0=BALANCE Symbole laufen ab Id=1
    itheme := 2;
    SetLength(vs, max);
    vs[0].symbolId := 0;
    vs[0].name := 'BALANCE';
    lc := 0;

  end;
  if theme = 'ticks' then
  begin
    // laufen ab Id=0
    itheme := 3;
    SetLength(vt, max);
    lc := -1;
  end;
  if theme = 'comments' then
  begin
    // laufen ab Id=1
    itheme := 4;
    SetLength(vc, max);
    lc := 0;
  end;

  csvReader := TCsvReader.Create(ms, ';');
  csvReader.first;
  While not csvReader.Eof Do
  Begin
    if (headok = false) then
    begin
      // Headline
      headok := true;
      headerz := csvReader.ColumnCount;
      SetLength(headers, headerz);
      For i := 0 to csvReader.ColumnCount - 1 Do
      begin
        headers[i] := csvReader.Columns[i];
      end;
    end
    else
    begin

      valuez := csvReader.ColumnCount;
      if valuez = 0 then
      begin
        // lbAdd(sl,'leere Zeile ignoriert');
      end
      else
      begin
        SetLength(values, valuez);
        For i := 0 to csvReader.ColumnCount - 1 Do
        begin
          values[i] := csvReader.Columns[i];
        end;
        ok := true;

        if (values[0] = '') then
        begin
          l := 0;
          For i := 0 to csvReader.ColumnCount - 1 Do
            l := l + length(csvReader.Columns[i]);
          if l = 0 then
          begin
            ok := false;
            lbAdd(sl, 'leere Daten entfernt');
          end;
        end;
        if ok = true then
        begin
          Inc(lc); // lc ist nicht counter sondern zeiger !
          if (lc + 1 = max) then
          begin
            max := max + 500;
            if itheme = 1 then
              SetLength(vu, max);
            if itheme = 2 then
              SetLength(vs, max);
            if itheme = 3 then
              SetLength(vt, max);
            if itheme = 4 then
              SetLength(vc, max);
          end;

          // und zuweisen
          if (valuez > headerz) then
          begin
            lbAdd(sl, 'zu viele valuez. Angepasst !');
            valuez := headerz;
          end;

          for i := 0 to valuez - 1 do
          begin
            s := headers[i];
            case itheme of
              4:
                try
                  case IndexStr(s, ['CommentId', 'Text']) of
                    0:
                      vc[lc].commentId := strtoint(values[i]); // kritisch. Eigentlich vc[strtoint(Values[i])]
                    1:
                      vc[lc].text := values[i];
                  else
                    ;

                  End;
                except
                  on E: Exception do
                  begin
                    lbAdd(sl, ns);
                    lbAdd(sl, 'lc' + inttostr(lc) + ' ' + values[i] + '->' + E.Message);
                  end;

                end;

              2:
                try
                  case IndexStr(s, ['SymbolId', 'BrokerId', 'Name', 'Description', 'Currency', 'MarginCurrency', 'Digits', 'TradeMode', 'Expiration', 'ContractSize', 'TickValue', 'TickSize', 'Type']) of
                    0:
                      vs[lc].symbolId := strtoint(values[i]);
                    1:
                      vs[lc].brokerId := strtoint(values[i]);
                    2:
                      vs[lc].name := values[i];
                    3:
                      vs[lc].description := values[i];
                    4:
                      vs[lc].currency := values[i];
                    5:
                      vs[lc].margin_currency := values[i];
                    6:
                      vs[lc].digits := strtoint(values[i]);
                    7:
                      vs[lc].tradeMode := strtoint(values[i]);
                    8:
                      vs[lc].expiration := strtoint(values[i]);
                    9:
                      vs[lc].contractSize := MyStrToFloat(values[i]);
                    10:
                      vs[lc].tickValue := MyStrToFloat(values[i]); // hier steckt die Bremse !
                    11:
                      vs[lc].tickSize := MyStrToFloat(values[i]);
                    12:
                      vs[lc].type_ := strtoint(values[i]);
                  else
                    ;

                  End;
                except
                  on E: Exception do
                  begin
                    lbAdd(sl, ns);
                    lbAdd(sl, 'lc' + inttostr(lc) + ' ' + values[i] + '->' + E.Message);
                  end;

                end;

              1:
                try

                  Case IndexStr(s, ['UserId', 'AccountId', 'Group', 'Enable', 'RegistrationTime', 'LastLoginTime', 'Leverage', 'Balance', 'BalancePreviousMonth', 'BalancePreviousDay', 'Credit', 'InterestRate', 'Taxes', 'Name', 'Country', 'City', 'State', 'Zipcode', 'Address', 'Phone', 'Email',
                    'SocialNumber', 'Comment']) of
                    0:
                      vu[lc].userId := strtoint(values[i]);
                    1:
                      vu[lc].accountId := strtoint(values[i]);
                    2:
                      vu[lc].group := values[i];
                    3:
                      vu[lc].enable := strtoint(values[i]);
                    4:
                      vu[lc].registrationTime := strtoint(values[i]);
                    5:
                      vu[lc].lastLoginTime := strtoint(values[i]);
                    6:
                      vu[lc].leverage := strtoint(values[i]);
                    7:
                      vu[lc].balance := MyStrToFloat(values[i]);
                    8:
                      vu[lc].balancePreviousMonth := MyStrToFloat(values[i]);
                    9:
                      vu[lc].balancePreviousDay := MyStrToFloat(values[i]);
                    10:
                      vu[lc].credit := MyStrToFloat(values[i]);
                    11:
                      vu[lc].interestrate := MyStrToFloat(values[i]);
                    12:
                      vu[lc].taxes := MyStrToFloat(values[i]);
                    13:
                      vu[lc].name := values[i];
                    14:
                      vu[lc].country := values[i];
                    15:
                      vu[lc].city := (values[i]);
                    16:
                      vu[lc].state := (values[i]);
                    17:
                      vu[lc].zipcode := values[i];
                    18:
                      vu[lc].address := values[i];
                    19:
                      vu[lc].phone := values[i];
                    20:
                      vu[lc].email := values[i];
                    21:
                      vu[lc].socialNumber := values[i];
                    22:
                      vu[lc].comment := values[i];
                  End;

                except
                  on E: Exception do
                  begin
                    lbAdd(sl, ns);
                    lbAdd(sl, 'lc' + inttostr(lc) + ' ' + values[i] + '->' + E.Message);
                  end;

                end;
            end;
          end;
        end;
      end;

    end;

    csvReader.next;

  End;
  csvReader.Free;

  if itheme = 1 then
  begin
    SetLength(vu, lc + 1);
    // cwUsersCt := lc + 1;
  end;
  if itheme = 2 then
  begin
    SetLength(vs, lc + 1);
    // cwSymbolsCt := lc + 1;
  end;
  if itheme = 3 then
  begin
    SetLength(vt, lc + 1);
    // cwTicksCt := lc + 1;
  end;
  if itheme = 4 then
  begin
    SetLength(vc, lc + 1);
    // cwCommentsCt := lc + 1;
    // //
    // for i := 0 to lc do
    // begin
    // if cwComments[i].commentId <> i then
    // begin
    // sl.Items.Add('F:commentid:' + inttostr(i) + ':' + inttostr(cwComments[i].commentId));
    // end;
    // end;
  end;
  lbAdd(sl, 'Z Parse:' + inttostr(GetTickCount - gt) + ' Ct:' + inttostr(lc));
end;

procedure splitHeadLine(value: string; var headers: DAstring; var headerz: integer; delimiter: string);
var
  dx: integer;
  ns: string;
  txt: string;
  delta: integer;
  max: integer;
begin
  max := 100;
  SetLength(headers, max);
  delta := length(delimiter);
  txt := value + delimiter;
  headerz := 0;
  try
    while length(txt) > 0 do
    begin
      dx := pos(delimiter, txt);
      ns := Copy(txt, 0, dx - 1);
      if (ns <> '') then
      begin
        Inc(headerz);
        if (headerz + 1) > max then
        begin
          max := max + 100;
          SetLength(headers, max);
        end;
        headers[headerz - 1] := ns;

      end;

      txt := Copy(txt, dx + delta, MaxInt);
    end;
    SetLength(headers, headerz);
  finally
  end;
end;

procedure doActionsGridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var actions: DACwAction; var actionsPlus: DACwActionPlus; var selSorted: byteArray; datafrom: integer; datato: integer; justone: Boolean = false; sl: TStringList = nil;
  onlySelection: Boolean = false);
var
  k, l: integer;
  row: integer;
  fehler: string;
  v: integer;
  gt: Cardinal;
  lines: array [0 .. 30] of string;
  linesHide: array [0 .. 30] of Boolean;
  toSL: Boolean;
  line: string;
  sep: string;
  makeLines: Boolean;
  uid: integer;
const
  colmax = 28;
begin
  gt := GetTickCount;
  toSL := false;
  if (sl <> nil) then
  // wenn eine StringList sl �bergeben wird dann soll dort auch eingetragen werden
  begin
    toSL := true;
    sep := ';';
  end;
  v := SG.visiblerowcount;
  try
    if (justone = false) then
    begin
      if (toSL = false) then
      begin
        SG.Rows[0].BeginUpdate;
        // SG.ColWidths[SGFieldCol[0]] := 140;
      end;

      // SG.cells[SGFieldCol[0], 0] := 'actionId';

      lines[SGFieldCol[0]] := 'actionId';
      lines[SGFieldCol[1]] := 'userId';
      lines[SGFieldCol[2]] := 'accountId';
      lines[SGFieldCol[3]] := 'symbol';
      lines[SGFieldCol[4]] := 'symbolId';
      lines[SGFieldCol[5]] := 'comment';
      lines[SGFieldCol[6]] := 'typeId';
      lines[SGFieldCol[7]] := 'sourceId';
      lines[SGFieldCol[8]] := 'openTime';
      lines[SGFieldCol[9]] := 'closeTime';
      lines[SGFieldCol[10]] := 'openTimeUnix';
      lines[SGFieldCol[11]] := 'closeTimeUnix';
      lines[SGFieldCol[12]] := 'expirationTime';
      lines[SGFieldCol[13]] := 'openPrice';
      lines[SGFieldCol[14]] := 'closePrice';
      lines[SGFieldCol[15]] := 'stopLoss';
      lines[SGFieldCol[16]] := 'takeProfit';
      lines[SGFieldCol[17]] := 'swap';
      lines[SGFieldCol[18]] := 'profit';
      lines[SGFieldCol[19]] := 'volume';
      lines[SGFieldCol[20]] := 'precision';
      lines[SGFieldCol[21]] := 'conversionRate0';
      lines[SGFieldCol[22]] := 'conversionRate1';
      lines[SGFieldCol[23]] := 'marginRate';
      lines[SGFieldCol[24]] := 'symGroupId';
      lines[SGFieldCol[25]] := '-'; // 'openProfit';
      lines[SGFieldCol[26]] := '-'; // 'openSwap';
      lines[SGFieldCol[27]] := 'commentId'; // 'openSwap';
      lines[SGFieldCol[28]] := 'userMarker'; // 'openSwap';
      lines[SGFieldCol[29]] := '-'; // 'openSwap';

      if (toSL = false) then
      begin
        for k := 0 to colmax do
          SG.cells[k, 0] := lines[k];
        // Ausblenden was nicht erw�nscht ist
        SG.Rows[0].endUpdate;
      end
      else
      begin
        sl.clear;
        line := '';
        for k := 0 to colmax do
        begin
          if (SG.ColWidths[SGFieldCol[k]] = -1) then
            linesHide[SGFieldCol[k]] := true
          else
            linesHide[SGFieldCol[k]] := false
        end;
      end;

      if (toSL = true) then
      begin
        for k := 0 to colmax do
        begin
          if (linesHide[SGFieldCol[k]] = false) then
            line := line + lines[k] + sep;
        end;
        sl.add(leftstr(line, length(line) - 1));
      end;

      row := 0;
      for k := datafrom to datato do
      begin
        row := row + 1;
        // alles nur um beim Export unn�tiges Zusammenbauen der Lines zu verhindern
        if (toSL = true) then
        begin
          if ((onlySelection = false) or (selSorted[sort[k]] = 1)) then
            makeLines := true
          else
            makeLines := false;
        end
        else
          makeLines := true;

        if (makeLines = true) then
        begin
          lines[SGFieldCol[0]] := inttostr(actions[sort[k]].actionId) + ' ' + inttostr(k);
          lines[SGFieldCol[1]] := inttostr(actions[sort[k]].userId);
          lines[SGFieldCol[2]] := accountShort[actions[sort[k]].accountId];
          lines[SGFieldCol[3]] := getCwSymbol(actions[sort[k]].symbolId);
          lines[SGFieldCol[4]] := inttostr(actions[sort[k]].symbolId);
          lines[SGFieldCol[5]] := getCwComment(actions[sort[k]].commentId);
          lines[SGFieldCol[6]] := OrderTypes(actions[sort[k]].typeId - 1) + ' ' + inttostr(actions[sort[k]].typeId);
          // cw statt 0..7ist 1..8
          lines[SGFieldCol[7]] := inttostr(actions[sort[k]].sourceId);
          lines[SGFieldCol[8]] := DateTimeToStr(UnixToDateTime(actions[sort[k]].openTime));
          lines[SGFieldCol[9]] := DateTimeToStr(UnixToDateTime(actions[sort[k]].closeTime));
          lines[SGFieldCol[10]] := inttostr(actions[sort[k]].openTime);
          lines[SGFieldCol[11]] := inttostr(actions[sort[k]].closeTime);
          lines[SGFieldCol[12]] := DateTimeToStr(UnixToDateTime(actions[sort[k]].expirationTime));
          lines[SGFieldCol[13]] := floattostr(actions[sort[k]].openPrice);
          lines[SGFieldCol[14]] := floattostr(actions[sort[k]].closePrice);
          lines[SGFieldCol[15]] := floattostr(actions[sort[k]].stopLoss);
          lines[SGFieldCol[16]] := floattostr(actions[sort[k]].takeProfit);
          lines[SGFieldCol[17]] := floattostr(actions[sort[k]].swap);
          lines[SGFieldCol[18]] := floattostr(actions[sort[k]].profit);
          lines[SGFieldCol[19]] := FormatFloat(',#0.00', actions[sort[k]].volume / 100);
          lines[SGFieldCol[20]] := inttostr(actions[sort[k]].precision);
          lines[SGFieldCol[21]] := floattostr(actions[sort[k]].conversionRate0);
          lines[SGFieldCol[22]] := floattostr(actions[sort[k]].conversionRate0);
          lines[SGFieldCol[23]] := floattostr(actions[sort[k]].marginRate);
          lines[SGFieldCol[27]] := inttostr(actions[sort[k]].commentId);
          uid := findUserIndex(actions[sort[k]].userId);
          lines[SGFieldCol[28]] := cwUsersPlus[uid].marker;
        end;
        if cwSymbolsGroupsCt > 0 then
          lines[SGFieldCol[24]] := cwSymbolsGroups[cwSymbolsPlus[actions[sort[k]].symbolId].groupId].name;
        // lines[SGFieldCol[25]] := floattostr(actionsPlus[sort[k]].openProfit);
        // lines[SGFieldCol[26]] := floattostr(actionsPlus[sort[k]].openSwap);
        if (toSL = false) then
        begin
          SG.Rows[row].BeginUpdate;
          for l := 0 to colmax do
            SG.cells[l, row] := lines[l];
          SG.Rows[row].endUpdate;
        end
        else
        begin
          if ((onlySelection = false) or (selSorted[sort[k]] = 1)) then
          begin
            line := '';
            for l := 0 to colmax do
            begin
              if (linesHide[SGFieldCol[l]] = false) then
                line := line + lines[l] + sep;
            end;
            sl.add(leftstr(line, length(line) - 1));

          end;
        end;
      end;
    end;
    // evtl noch was l�schen ?
    v := v;
  except
    on E: Exception do
    begin
      fehler := E.Message;
    end;

  end;
  gt := GetTickCount - gt;
end;

procedure doOpenActionsGridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var actions: DACwOpenActions; var selSorted: byteArray; datafrom: integer; datato: integer; justone: Boolean = false; sl: TStringList = nil; onlySelection: Boolean = false);
const
  smax = 12;
var
  i, k, l, v: integer;
  j, found2: integer;
  row: integer;
  fehler: string;
  lines: array [0 .. smax] of string;
  linesHide: array [0 .. smax] of Boolean;
  toSL: Boolean;
  line: string;
  sep: string;
  gt, gts: Cardinal;
  found: integer;
  uid: integer;
begin
  toSL := false;
  if (sl <> nil) then
  // wenn eine StringList sl �bergeben wird dann soll dort auch eingetragen werden
  begin
    toSL := true;
    sep := ';';
  end;

  // jetzt noch die bin�re Suche in den Actions erm�glichen
  // n := binsearchint64(ia2, cwActions[i].actionId);
  if (cwActionsSorted = false) then
  begin
    gts := GetTickCount;
    cwActionsCt := length(cwActions);
    SetLength(cwActionsInt64, cwActionsCt);
    SetLength(cwActionsInt, cwActionsCt);
    try
      for i := 0 to cwActionsCt - 1 do
      begin
        cwActionsInt64[i] := cwActions[i].actionId;
        cwActionsInt[i] := i;
      end;
    except
      i := i;
    end;
    dosleep(CSleep);

    FastSort2ArrayInt64Int(cwActionsInt64, cwActionsInt, 'VUI'); // VDI
    // lbCSVError.Items.Add('[sort2]' + inttostr(GetTickCount - gts));
    gts := GetTickCount - gts;
    dosleep(CSleep);

    gt := GetTickCount;
    cwActionsSorted := true;
  end;

  try
    if (justone = false) then
    begin
      if (toSL = false) then
      begin
        SG.Rows[0].BeginUpdate;
        // SG.ColWidths[SGFieldCol[0]] := 140;
      end;
      // SG.cells[SGFieldCol[0], 0] := 'actionId';

      lines[SGFieldCol[0]] := 'actionId';
      lines[SGFieldCol[1]] := 'userId';
      lines[SGFieldCol[2]] := 'profit';
      lines[SGFieldCol[3]] := 'swap';
      lines[SGFieldCol[4]] := 'opentime';
      lines[SGFieldCol[5]] := 'closetime';
      lines[SGFieldCol[6]] := '(neu)typ';
      lines[SGFieldCol[7]] := '(neu)close';
      lines[SGFieldCol[8]] := '(neu)volume';
      lines[SGFieldCol[9]] := '(alt)typ';
      lines[SGFieldCol[10]] := '(alt)close';
      lines[SGFieldCol[11]] := '(alt)volume';
      lines[SGFieldCol[12]] := 'comment';

      if (toSL = false) then
      begin
        for k := 0 to smax do
          SG.cells[k, 0] := lines[k];
        // Ausblenden was nicht erw�nscht ist
        SG.Rows[0].endUpdate;
      end
      else
      begin
        sl.clear;
        line := '';
        for k := 0 to smax do
        begin
          if (SG.ColWidths[SGFieldCol[k]] = -1) then
            linesHide[SGFieldCol[k]] := true
          else
            linesHide[SGFieldCol[k]] := false
        end;
      end;

      if (toSL = true) then
      begin
        for k := 0 to smax do
        begin
          if (linesHide[SGFieldCol[k]] = false) then
            line := line + lines[k] + sep;
        end;
        sl.add(leftstr(line, length(line) - 1));
      end;

      row := 0;
      for k := datafrom to datato do
      begin
        row := row + 1;
        lines[SGFieldCol[0]] := inttostr(actions[sort[k]].actionId) + ' ' + inttostr(k);
        lines[SGFieldCol[1]] := inttostr(actions[sort[k]].userId);
        uid := findUserIndex(actions[sort[k]].userId);
        lines[SGFieldCol[2]] := floattostr(actions[sort[k]].profit);
        lines[SGFieldCol[3]] := floattostr(actions[sort[k]].swap);
        found := findCwactionFromId(actions[sort[k]].actionId);
        if (found > -1) then
        begin
          lines[SGFieldCol[4]] := DateTimeToStr(UnixToDateTime(cwActions[found].openTime));
          lines[SGFieldCol[5]] := DateTimeToStr(UnixToDateTime(cwActions[found].closeTime));
          // das sind freie Pl�tze in die fehlerhafte Eintr�ge aus den OpenTrades die abge�ndert wurden eingesetzt werden k�nnen
          // dazu m�ssen erstmal die passenden OpenTrades �berhaupt vorhanden sein , der Tag stimmen
          lines[SGFieldCol[6]] := OrderTypes(cwActions[found].typeId - 1) + ' ' + inttostr(cwActions[found].typeId);
          lines[SGFieldCol[7]] := floattostr(cwActions[found].openPrice);
          lines[SGFieldCol[8]] := FormatFloat(',#0.00', cwActions[found].volume / 100);
          lines[SGFieldCol[12]] := getCwComment(cwActions[found].commentId);
          found2 := -1;
          for j := 0 to length(cwTradeRecords) - 1 do
          begin
            // hinten an der ActionId eine Stelle wieder abschneiden, welche ich als BrokerAccount angeh�ngt habe
            if (cwTradeRecords[j].order = int(actions[sort[k]].actionId / 10)) then
            begin
              found2 := j;
              break;
            end;
          end;
          if (found2 > -1) then
          begin
            lines[SGFieldCol[9]] := '!' + OrderTypes(cwTradeRecords[found2].cmd) + ' ' + inttostr(cwTradeRecords[found2].cmd + 1);
            lines[SGFieldCol[10]] := '!' + floattostr(cwTradeRecords[found2].open_price);
            lines[SGFieldCol[11]] := '!' + FormatFloat(',#0.00', cwTradeRecords[found2].volume / 100);
          end
          else
          begin
            lines[SGFieldCol[9]] := '-';
            lines[SGFieldCol[10]] := '-';
            lines[SGFieldCol[11]] := '-';
          end;
        end
        else
        begin
          lines[SGFieldCol[4]] := '-';
          lines[SGFieldCol[5]] := '-';
          lines[SGFieldCol[5]] := '-';
          lines[SGFieldCol[6]] := '-';
          lines[SGFieldCol[7]] := '-';
          lines[SGFieldCol[8]] := '-';
          lines[SGFieldCol[9]] := '-';
          lines[SGFieldCol[10]] := '-';
          lines[SGFieldCol[11]] := '-';
          lines[SGFieldCol[12]] := '-';
        end;

        if (toSL = false) then
        begin
          SG.Rows[row].BeginUpdate;
          for l := 0 to smax do
            SG.cells[l, row] := lines[l];
          SG.Rows[row].endUpdate;
        end
        else
        begin
          if ((onlySelection = false) or (selSorted[sort[k]] = 1)) then
          begin
            line := '';
            for l := 0 to smax do
            begin
              if (linesHide[SGFieldCol[l]] = false) then
                line := line + lines[l] + sep;
            end;
            sl.add(leftstr(line, length(line) - 1));

          end;
        end;
      end;
    end;
    // evtl noch was l�schen ?
    v := v;
  except
    on E: Exception do
    begin
      fehler := E.Message;
    end;

  end;
  gt := GetTickCount - gt;
end;

procedure doOpenActionsOTRGridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var actions: DATradeRecord; var selSorted: byteArray; datafrom: integer; datato: integer; justone: Boolean = false; sl: TStringList = nil; onlySelection: Boolean = false);
const
  smax = 12;
var
  i, k, l, v: integer;
  j, found2: integer;
  row: integer;
  fehler: string;

  lines: array [0 .. smax] of string;
  linesHide: array [0 .. smax] of Boolean;
  toSL: Boolean;
  line: string;
  sep: string;
  gt, gts: Cardinal;
  found: integer;
begin
  toSL := false;
  if (sl <> nil) then
  // wenn eine StringList sl �bergeben wird dann soll dort auch eingetragen werden
  begin
    toSL := true;
    sep := ';';
  end;

  try
    if (justone = false) then
    begin
      if (toSL = false) then
      begin
        SG.Rows[0].BeginUpdate;
      end;
      lines[SGFieldCol[0]] := 'actionId';
      lines[SGFieldCol[1]] := 'userId';
      lines[SGFieldCol[2]] := 'symbol';
      lines[SGFieldCol[3]] := 'opentime';
      lines[SGFieldCol[4]] := 'closetime';
      lines[SGFieldCol[5]] := 'cmd';
      lines[SGFieldCol[6]] := 'openprice';
      lines[SGFieldCol[7]] := 'closeprice';
      lines[SGFieldCol[8]] := 'volume';
      lines[SGFieldCol[9]] := 'comment';
      lines[SGFieldCol[10]] := 'profit';
      lines[SGFieldCol[11]] := 'stoploss';

      if (toSL = false) then
      begin
        for k := 0 to smax do
          SG.cells[k, 0] := lines[k];
        // Ausblenden was nicht erw�nscht ist
        SG.Rows[0].endUpdate;
      end
      else
      begin
        sl.clear;
        line := '';
        for k := 0 to smax do
        begin
          if (SG.ColWidths[SGFieldCol[k]] = -1) then
            linesHide[SGFieldCol[k]] := true
          else
            linesHide[SGFieldCol[k]] := false
        end;
      end;

      if (toSL = true) then
      begin
        for k := 0 to smax do
        begin
          if (linesHide[SGFieldCol[k]] = false) then
            line := line + lines[k] + sep;
        end;
        sl.add(leftstr(line, length(line) - 1));
      end;

      row := 0;
      for k := datafrom to datato do
      begin
        row := row + 1;
        lines[SGFieldCol[0]] := inttostr(actions[sort[k]].order) + ' ' + inttostr(k);
        lines[SGFieldCol[1]] := inttostr(actions[sort[k]].login);
        lines[SGFieldCol[2]] := actions[sort[k]].symbol;
        lines[SGFieldCol[3]] := DateTimeToStr(UnixToDateTime(actions[sort[k]].open_time));
        lines[SGFieldCol[4]] := DateTimeToStr(UnixToDateTime(actions[sort[k]].close_time));
        lines[SGFieldCol[5]] := OrderTypes(actions[sort[k]].cmd);
        lines[SGFieldCol[6]] := floattostr(actions[sort[k]].open_price);
        lines[SGFieldCol[7]] := floattostr(actions[sort[k]].close_price);
        lines[SGFieldCol[8]] := FormatFloat(',#0.00', actions[sort[k]].volume / 100);
        lines[SGFieldCol[9]] := actions[sort[k]].comment;
        lines[SGFieldCol[10]] := floattostr(actions[sort[k]].profit);
        lines[SGFieldCol[11]] := floattostr(actions[sort[k]].sl);

        if (toSL = false) then
        begin
          SG.Rows[row].BeginUpdate;
          for l := 0 to smax do
            SG.cells[l, row] := lines[l];
          SG.Rows[row].endUpdate;
        end
        else
        begin
          if ((onlySelection = false) or (selSorted[sort[k]] = 1)) then
          begin
            line := '';
            for l := 0 to smax do
            begin
              if (linesHide[SGFieldCol[l]] = false) then
                line := line + lines[l] + sep;
            end;
            sl.add(leftstr(line, length(line) - 1));
          end;
        end;
      end;
    end;
    // evtl noch was l�schen ?
    v := v;
  except
    on E: Exception do
    begin
      fehler := E.Message;
    end;

  end;
  gt := GetTickCount - gt;
end;

procedure doCommentsGridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var comments: DAcwComment; var selSorted: byteArray; datafrom: integer; datato: integer; justone: Boolean = false; sl: TStringList = nil; onlySelection: Boolean = false);
const
  smax = 1;
var
  i, k, l, v: integer;
  row: integer;
  fehler: string;
  lines: array [0 .. smax] of string;
  linesHide: array [0 .. smax] of Boolean;
  toSL: Boolean;
  line: string;
  sep: string;
  gt, gts: Cardinal;
  found: integer;
begin
  toSL := false;
  if (sl <> nil) then
  // wenn eine StringList sl �bergeben wird dann soll dort auch eingetragen werden
  begin
    toSL := true;
    sep := ';';
  end;

  try
    if (justone = false) then
    begin
      if (toSL = false) then
      begin
        SG.Rows[0].BeginUpdate;
      end;
      lines[SGFieldCol[0]] := 'commentId';
      lines[SGFieldCol[1]] := 'comment';

      if (toSL = false) then
      begin
        for k := 0 to smax do
          SG.cells[k, 0] := lines[k];
        // Ausblenden was nicht erw�nscht ist
        SG.Rows[0].endUpdate;
      end
      else
      begin
        sl.clear;
        line := '';
        for k := 0 to smax do
        begin
          if (SG.ColWidths[SGFieldCol[k]] = -1) then
            linesHide[SGFieldCol[k]] := true
          else
            linesHide[SGFieldCol[k]] := false
        end;
      end;

      if (toSL = true) then
      begin
        for k := 0 to smax do
        begin
          if (linesHide[SGFieldCol[k]] = false) then
            line := line + lines[k] + sep;
        end;
        sl.add(leftstr(line, length(line) - 1));
      end;

      row := 0;
      for k := datafrom to datato do
      begin
        row := row + 1;
        lines[SGFieldCol[0]] := inttostr(comments[sort[k]].commentId);
        lines[SGFieldCol[1]] := comments[sort[k]].text;
        if (toSL = false) then
        begin
          SG.Rows[row].BeginUpdate;
          for l := 0 to smax do
            SG.cells[l, row] := lines[l];
          SG.Rows[row].endUpdate;
        end
        else
        begin
          if ((onlySelection = false) or (selSorted[sort[k]] = 1)) then
          begin
            line := '';
            for l := 0 to smax do
            begin
              if (linesHide[SGFieldCol[l]] = false) then
                line := line + lines[l] + sep;
            end;
            sl.add(leftstr(line, length(line) - 1));
          end;
        end;
      end;
    end;
    // evtl noch was l�schen ?
    v := v;
  except
    on E: Exception do
    begin
      fehler := E.Message;
    end;

  end;
  gt := GetTickCount - gt;
end;

procedure doSummaries3GridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var summaries: DA3CwSummary; datafrom: integer; datato: integer; justone: Boolean = false);
var
  k: integer;
  row: integer;
  fehler: string;
  d1, d2, d3, d23: integer;
  i1, i2, i3, rest: integer; // die summaries[i1][i2][i3] aus k
begin
  try
    if (justone = false) then
    begin
      SG.Rows[0].BeginUpdate;
      SG.cells[SGFieldCol[0], 0] := cwGrouping.element[0].sTyp;
      SG.cells[SGFieldCol[1], 0] := cwGrouping.element[1].sTyp;
      SG.cells[SGFieldCol[2], 0] := cwGrouping.element[2].sTyp;
      SG.cells[SGFieldCol[3], 0] := 'tradesCount';
      SG.cells[SGFieldCol[4], 0] := 'tradesVolumeTotal';
      SG.cells[SGFieldCol[5], 0] := 'tradesProfitTotal';
      SG.cells[SGFieldCol[6], 0] := 'tradesUsers';
      SG.cells[SGFieldCol[7], 0] := 'tradesSwapTotal';
      SG.cells[SGFieldCol[8], 0] := 'tradesProfitSwapTotal';
      SG.Rows[0].endUpdate;
    end;
    row := 0;

    d1 := length(summaries);
    d2 := length(summaries[0]);
    d3 := length(summaries[0][0]);
    d23 := d2 * d3;
    // i1=int(ix/(d2*d3))
    // i2=int(rest/d3)
    // i3=rest

    for k := datafrom to datato do

    begin
      row := row + 1;
      SG.Rows[row].BeginUpdate;

      i1 := trunc(sort[k] / d23);
      rest := sort[k] - i1 * d23;
      i2 := trunc(rest / d3);
      i3 := rest - i2 * d3;

      SG.cells[SGFieldCol[0], row] := summaries[i1][i2][i3].par0;
      SG.cells[SGFieldCol[1], row] := summaries[i1][i2][i3].par1;
      SG.cells[SGFieldCol[2], row] := summaries[i1][i2][i3].par2;

      SG.cells[SGFieldCol[3], row] := inttostr(summaries[i1][i2][i3].sTradesCount);
      SG.cells[SGFieldCol[4], row] := FormatFloat(',#0.00', summaries[i1][i2][i3].sTradesVolumeTotal / 100);
      SG.cells[SGFieldCol[5], row] := FormatFloat(',#0.00', summaries[i1][i2][i3].sTradesProfitTotal);
      SG.cells[SGFieldCol[6], row] := inttostr(summaries[i1][i2][i3].sTradesUsers);
      SG.cells[SGFieldCol[7], row] := FormatFloat(',#0.00', summaries[i1][i2][i3].sTradesSwapTotal);
      SG.cells[SGFieldCol[8], row] := FormatFloat(',#0.00', summaries[i1][i2][i3].sTradesProfitSwapTotal);

      SG.Rows[row].endUpdate;
    end;
  except
    on E: Exception do
    begin
      fehler := E.Message;
    end;

  end;
end;

procedure doSummariesGridCWDyn(var SG: TStringGridSorted; var SGSum: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var summaries: DACwSummary; datafrom: integer; datato: integer; justone: Boolean = false);
var
  i, k: integer;
  row: integer;
  fehler: string;
  d1, d2, d3, d23: integer;
  i1, i2, i3, rest: integer; // die summaries[i1][i2][i3] aus k
begin
  try
    if (justone = false) then
    begin
      SG.Rows[0].BeginUpdate;
      SG.cells[SGFieldCol[0], 0] := cwGrouping.element[0].sTyp;
      SG.cells[SGFieldCol[1], 0] := cwGrouping.element[1].sTyp;
      SG.cells[SGFieldCol[2], 0] := cwGrouping.element[2].sTyp;
      SG.cells[SGFieldCol[3], 0] := 'tradesCount';
      SG.cells[SGFieldCol[4], 0] := 'tradesVolumeTotal';
      SG.cells[SGFieldCol[5], 0] := 'tradesProfitTotal';
      SG.cells[SGFieldCol[6], 0] := 'tradesUsers';
      SG.cells[SGFieldCol[7], 0] := 'tradesSwapTotal';
      SG.cells[SGFieldCol[8], 0] := 'tradesProfitSwapTotal';
      for i := 0 to 2 do
        if (cwGrouping.element[i].sTyp = 'unused') then
        begin
          SG.ColWidths[SGFieldCol[i]] := -1;
          SGSum.ColWidths[SGFieldCol[i]] := -1;
        end
        else
        begin
          if (SG.ColWidths[SGFieldCol[i]] = -1) then
            SG.ColWidths[SGFieldCol[i]] := 100;
          SGSum.ColWidths[SGFieldCol[i]] := 100;
        end;
      SG.Rows[0].endUpdate;
    end;
    row := 0;

    for k := datafrom to datato do

    begin
      row := row + 1;
      SG.Rows[row].BeginUpdate;

      SG.cells[SGFieldCol[0], row] := summaries[sort[k]].par0;
      SG.cells[SGFieldCol[1], row] := summaries[sort[k]].par1;
      SG.cells[SGFieldCol[2], row] := summaries[sort[k]].par2;

      SG.cells[SGFieldCol[3], row] := inttostr(summaries[sort[k]].sTradesCount);
      SG.cells[SGFieldCol[4], row] := FormatFloat(',#0.00', summaries[sort[k]].sTradesVolumeTotal / 100);
      SG.cells[SGFieldCol[5], row] := FormatFloat(',#0.00', summaries[sort[k]].sTradesProfitTotal);
      SG.cells[SGFieldCol[6], row] := inttostr(summaries[sort[k]].sTradesUsers);
      SG.cells[SGFieldCol[7], row] := FormatFloat(',#0.00', summaries[sort[k]].sTradesSwapTotal);
      SG.cells[SGFieldCol[8], row] := FormatFloat(',#0.00', summaries[sort[k]].sTradesProfitSwapTotal);

      SG.Rows[row].endUpdate;
    end;
  except
    on E: Exception do
    begin
      fehler := E.Message;
    end;

  end;
end;

procedure doUsersGridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var users: DAcwUser; usersPlus: DACwUserPlus; var selSorted: byteArray; datafrom: integer; datato: integer; justone: Boolean = false; sl: TStringList = nil; onlySelection: Boolean = false);

const
  cols = 30;
var
  k, l: integer;
  row: integer;
  fehler: string;
  lines: array [0 .. cols] of string;
  linesHide: array [0 .. cols] of Boolean;
  toSL: Boolean;
  line: string;
  sep: string;

begin
  toSL := false;
  if (sl <> nil) then
  // wenn eine StringList sl �bergeben wird dann soll dort auch eingetragen werden
  begin
    toSL := true;
    sep := ';';
  end;
  try
    if (justone = false) then
    begin
      if (toSL = false) then
      begin
        SG.Rows[0].BeginUpdate;
      end;
      lines[SGFieldCol[0]] := 'userId';
      lines[SGFieldCol[1]] := 'accountId';
      lines[SGFieldCol[2]] := 'name';
      lines[SGFieldCol[3]] := 'group';
      lines[SGFieldCol[4]] := 'enable';
      lines[SGFieldCol[5]] := 'registrationTime';
      lines[SGFieldCol[6]] := 'lastLoginTime';
      lines[SGFieldCol[7]] := 'leverage';
      lines[SGFieldCol[8]] := 'balance';
      lines[SGFieldCol[9]] := 'balancePreviousMonth';
      lines[SGFieldCol[10]] := 'balancePreviousDay';
      lines[SGFieldCol[11]] := 'credit';
      lines[SGFieldCol[12]] := 'interestrate';
      lines[SGFieldCol[13]] := 'taxes';
      lines[SGFieldCol[14]] := 'country';
      lines[SGFieldCol[15]] := 'city';
      lines[SGFieldCol[16]] := 'state';
      lines[SGFieldCol[17]] := 'zipcode';
      lines[SGFieldCol[18]] := 'address';
      lines[SGFieldCol[19]] := 'phone';
      lines[SGFieldCol[20]] := 'email';
      lines[SGFieldCol[21]] := 'socialNumber';
      lines[SGFieldCol[22]] := 'comment';
      lines[SGFieldCol[23]] := 'trades';
      lines[SGFieldCol[24]] := 'profit';
      lines[SGFieldCol[25]] := 'totalbalance';
      lines[SGFieldCol[26]] := 'totalswap';
      lines[SGFieldCol[27]] := 'accountCurrency';
      lines[SGFieldCol[28]] := 'lastOpenAction';
      lines[SGFieldCol[29]] := 'silentDays';
      lines[SGFieldCol[30]] := 'marker';
      if (toSL = false) then
      begin
        for k := 0 to cols do
          SG.cells[k, 0] := lines[k];
        // Ausblenden was nicht erw�nscht ist
        SG.Rows[0].endUpdate;
      end
      else
      begin
        sl.clear;
        line := '';
        for k := 0 to cols do
        begin
          if (SG.ColWidths[SGFieldCol[k]] = -1) then
            linesHide[SGFieldCol[k]] := true
          else
            linesHide[SGFieldCol[k]] := false
        end;
      end;

      if (toSL = true) then
      begin
        for k := 0 to cols do
        begin
          if (linesHide[SGFieldCol[k]] = false) then
            line := line + lines[k] + sep;
        end;
        sl.add(leftstr(line, length(line) - 1));
      end;

      SG.Rows[0].endUpdate;
    end;

    row := 0;
    for k := datafrom to datato do

    begin
      row := row + 1;
      SG.Rows[row].BeginUpdate;
      lines[SGFieldCol[0]] := inttostr(users[sort[k]].userId);
      lines[SGFieldCol[1]] := accountShort[users[sort[k]].accountId];
      lines[SGFieldCol[2]] := users[sort[k]].name;
      lines[SGFieldCol[3]] := users[sort[k]].group;
      lines[SGFieldCol[4]] := inttostr(users[sort[k]].enable);
      lines[SGFieldCol[5]] := DateTimeToStr(UnixToDateTime(users[sort[k]].registrationTime));
      // inttostr(users[sort[k]].registrationTime);
      lines[SGFieldCol[6]] := DateTimeToStr(UnixToDateTime(users[sort[k]].lastLoginTime));
      // inttostr(users[sort[k]].lastLoginTime);
      lines[SGFieldCol[7]] := inttostr(users[sort[k]].leverage);
      lines[SGFieldCol[8]] := floattostr(users[sort[k]].balance);
      lines[SGFieldCol[9]] := floattostr(users[sort[k]].balancePreviousMonth);
      lines[SGFieldCol[10]] := floattostr(users[sort[k]].balancePreviousDay);
      lines[SGFieldCol[11]] := floattostr(users[sort[k]].credit);
      lines[SGFieldCol[12]] := floattostr(users[sort[k]].interestrate);
      lines[SGFieldCol[13]] := floattostr(users[sort[k]].taxes);
      lines[SGFieldCol[14]] := users[sort[k]].country;
      lines[SGFieldCol[15]] := users[sort[k]].city;
      lines[SGFieldCol[16]] := users[sort[k]].state;
      lines[SGFieldCol[17]] := users[sort[k]].zipcode;
      lines[SGFieldCol[18]] := users[sort[k]].address;
      lines[SGFieldCol[19]] := users[sort[k]].phone;
      lines[SGFieldCol[20]] := users[sort[k]].email;
      lines[SGFieldCol[21]] := users[sort[k]].socialNumber;
      lines[SGFieldCol[22]] := users[sort[k]].comment;
      lines[SGFieldCol[23]] := inttostr(usersPlus[sort[k]].totalTrades);
      lines[SGFieldCol[24]] := FormatFloat(',#0.00', usersPlus[sort[k]].totalProfit);
      lines[SGFieldCol[25]] := FormatFloat(',#0.00', usersPlus[sort[k]].totalBalance);
      lines[SGFieldCol[26]] := FormatFloat(',#0.00', usersPlus[sort[k]].totalSwap);
      lines[SGFieldCol[27]] := accountCurrency[usersPlus[sort[k]].accountCurrency];
      lines[SGFieldCol[28]] := DateTimeToStr(UnixToDateTime(usersPlus[sort[k]].lastOpenAction));
      lines[SGFieldCol[29]] := inttostr(usersPlus[sort[k]].silentDays);
      lines[SGFieldCol[30]] := usersPlus[sort[k]].marker;

      if (toSL = false) then
      begin
        SG.Rows[row].BeginUpdate;
        for l := 0 to cols do
          SG.cells[l, row] := lines[l];
        SG.Rows[row].endUpdate;
      end
      else
      begin
        if ((onlySelection = false) or (selSorted[sort[k]] = 1)) then
        begin
          line := '';
          for l := 0 to cols do
          begin
            if (linesHide[SGFieldCol[l]] = false) then
              line := line + lines[l] + sep;
          end;
          sl.add(leftstr(line, length(line) - 1));
        end;
      end;
      SG.Rows[row].endUpdate;
    end;
  except
    on E: Exception do
    begin
      fehler := E.Message;
    end;

  end;
end;

procedure doSymbolsGridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var symbols: DACwSymbol; var symbolsPlus: DACwSymbolPlus; datafrom: integer; datato: integer; justone: Boolean = false);
var
  k: integer;
  row: integer;
  fehler: string;
begin
  try
    if (justone = false) then
    begin
      SG.Rows[0].BeginUpdate;
      SG.cells[SGFieldCol[0], 0] := 'symbolId';
      // SG.ColWidths[SGFieldCol[0]] := 100;
      SG.cells[SGFieldCol[1], 0] := 'brokerId';
      SG.cells[SGFieldCol[2], 0] := 'name';
      SG.cells[SGFieldCol[3], 0] := 'description';
      SG.cells[SGFieldCol[4], 0] := 'currency';
      SG.cells[SGFieldCol[5], 0] := 'margin_currency';
      SG.cells[SGFieldCol[6], 0] := 'digits';
      SG.cells[SGFieldCol[7], 0] := 'tradeMode';
      SG.cells[SGFieldCol[8], 0] := 'expiration';
      SG.cells[SGFieldCol[9], 0] := 'contractSize';
      SG.cells[SGFieldCol[10], 0] := 'tickValue';
      SG.cells[SGFieldCol[11], 0] := 'tickSize';
      SG.cells[SGFieldCol[12], 0] := 'type_';
      SG.cells[SGFieldCol[13], 0] := 'trades';
      SG.cells[SGFieldCol[14], 0] := 'volume';
      SG.cells[SGFieldCol[15], 0] := 'profit';
      SG.cells[SGFieldCol[16], 0] := 'symGroup';
      SG.cells[SGFieldCol[17], 0] := 'symGroupId';

      SG.Rows[0].endUpdate;
    end;
    row := 0;
    for k := datafrom to datato do

    begin
      row := row + 1;
      SG.Rows[row].BeginUpdate;
      SG.cells[SGFieldCol[0], row] := inttostr(symbols[sort[k]].symbolId);
      SG.cells[SGFieldCol[1], row] := inttostr(symbols[sort[k]].brokerId);
      SG.cells[SGFieldCol[2], row] := symbols[sort[k]].name;
      SG.cells[SGFieldCol[3], row] := symbols[sort[k]].description;
      SG.cells[SGFieldCol[4], row] := symbols[sort[k]].currency;
      SG.cells[SGFieldCol[5], row] := symbols[sort[k]].margin_currency;
      // sind bis auf 1x test immer gleich !  Es gibt aber viele mit currency=0
      // if( symbols[sort[k]].currency=symbols[sort[k]].margin_currency) then
      // SG.cells[SGFieldCol[5], row] :='='+SG.cells[SGFieldCol[5], row]
      // else
      // SG.cells[SGFieldCol[5], row] :='!'+SG.cells[SGFieldCol[5], row] ;

      SG.cells[SGFieldCol[6], row] := inttostr(symbols[sort[k]].digits);
      SG.cells[SGFieldCol[7], row] := inttostr(symbols[sort[k]].tradeMode);
      SG.cells[SGFieldCol[8], row] := inttostr(symbols[sort[k]].expiration);
      SG.cells[SGFieldCol[9], row] := floattostr(symbols[sort[k]].contractSize);
      SG.cells[SGFieldCol[10], row] := floattostr(symbols[sort[k]].tickValue);
      SG.cells[SGFieldCol[11], row] := floattostr(symbols[sort[k]].tickSize);
      SG.cells[SGFieldCol[12], row] := inttostr(symbols[sort[k]].type_);
      SG.cells[SGFieldCol[13], row] := inttostr(symbolsPlus[sort[k]].TradesCount);
      SG.cells[SGFieldCol[14], row] := FormatFloat(',#0.00', symbolsPlus[sort[k]].TradesVolumeTotal / 100);
      SG.cells[SGFieldCol[15], row] := FormatFloat(',#0.00', symbolsPlus[sort[k]].TradesProfitTotal);
      SG.cells[SGFieldCol[16], row] := FormatFloat(',#0.00', symbolsPlus[sort[k]].TradesSwapTotal);
      if cwSymbolsGroupsCt > 0 then
      begin
        SG.cells[SGFieldCol[16], row] := cwSymbolsGroups[symbolsPlus[sort[k]].groupId].name;
        SG.cells[SGFieldCol[17], row] := inttostr(symbolsPlus[sort[k]].groupId);
      end;
      SG.Rows[row].endUpdate;
    end;
  except
    on E: Exception do
    begin
      fehler := E.Message;
    end;

  end;
end;

procedure doSymbolsGroupsGridCWDyn(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var symbolsGroups: DACwSymbolGroup; datafrom: integer; datato: integer; justone: Boolean = false);
var
  k: integer;
  row: integer;
  fehler: string;
begin
  try
    if (justone = false) then
    begin
      SG.Rows[0].BeginUpdate;
      SG.cells[SGFieldCol[0], 0] := 'groupId';
      // SG.ColWidths[SGFieldCol[0]] := 100;
      SG.cells[SGFieldCol[1], 0] := 'name';
      SG.cells[SGFieldCol[2], 0] := 'tradesCount';
      SG.cells[SGFieldCol[3], 0] := 'tradesVolumeTotal';
      SG.cells[SGFieldCol[4], 0] := 'tradesUsers';
      SG.cells[SGFieldCol[5], 0] := 'tradesProfitTotal';
      SG.cells[SGFieldCol[6], 0] := 'tradesSwapTotal';
      SG.cells[SGFieldCol[7], 0] := 'sourceNames';
      SG.cells[SGFieldCol[8], 0] := 'sourceIds';
      SG.Rows[0].endUpdate;
    end;
    row := 0;
    for k := datafrom to datato do

    begin
      row := row + 1;
      SG.Rows[row].BeginUpdate;

      SG.cells[SGFieldCol[0], row] := inttostr(symbolsGroups[sort[k]].groupId);
      SG.cells[SGFieldCol[1], row] := symbolsGroups[sort[k]].name;
      SG.cells[SGFieldCol[2], row] := inttostr(symbolsGroups[sort[k]].TradesCount);
      SG.cells[SGFieldCol[3], row] := FormatFloat(',#0.00', symbolsGroups[sort[k]].TradesVolumeTotal / 100);
      SG.cells[SGFieldCol[4], row] := inttostr(symbolsGroups[sort[k]].TradesUsers);
      SG.cells[SGFieldCol[5], row] := FormatFloat(',#0.00', symbolsGroups[sort[k]].TradesProfitTotal);
      SG.cells[SGFieldCol[6], row] := FormatFloat(',#0.00', symbolsGroups[sort[k]].TradesSwapTotal);
      SG.cells[SGFieldCol[7], row] := symbolsGroups[sort[k]].sourceNames;
      SG.cells[SGFieldCol[8], row] := symbolsGroups[sort[k]].sourceIds;

      SG.Rows[row].endUpdate;
    end;
  except
    on E: Exception do
    begin
      fehler := E.Message;
    end;

  end;
end;

procedure doActionsGridCW(SG: TStringGridSorted; SGFieldCol: DAInteger; actions: DACwAction; ct: integer; total: integer; stp: integer = 1);
// nicht mehr verwendet
// {$RANGECHECKS OFF}
var
  k: integer;
  // sl: TStringList;
  row: integer;
  rct: integer;
  rct1: integer;
  s: string;
begin
  try
    // sl := TStringList.Create;
    SG.test := 1;
    // die Gr��e gleich festlegen
    rct := trunc(ct / stp) + 1;
    rct1 := total + 1;
    if rct1 < rct then
      rct := rct1;
    SG.RowCount := rct;
    SG.ColCount := 25;
    if (SG.RowCount > 1) then
      SG.FixedRows := 1;
    SG.Rows[0].BeginUpdate;
    SG.cells[SGFieldCol[0], 0] := 'actionId';
    // SG.ColWidths[SGFieldCol[0]] := 100;
    SG.cells[SGFieldCol[1], 0] := 'userId';
    SG.cells[SGFieldCol[2], 0] := 'accountId';
    SG.cells[SGFieldCol[3], 0] := 'symbol';
    SG.cells[SGFieldCol[4], 0] := 'symbolId';
    SG.cells[SGFieldCol[5], 0] := 'commentId';
    SG.cells[SGFieldCol[6], 0] := 'typeId';
    SG.cells[SGFieldCol[7], 0] := 'sourceId';
    SG.cells[SGFieldCol[8], 0] := 'openTime';
    SG.cells[SGFieldCol[9], 0] := 'closeTime';
    SG.cells[SGFieldCol[10], 0] := 'openTimeUnix';
    SG.cells[SGFieldCol[11], 0] := 'closeTimeUnix';
    SG.cells[SGFieldCol[12], 0] := 'expirationTime';
    SG.cells[SGFieldCol[13], 0] := 'openPrice';
    SG.cells[SGFieldCol[14], 0] := 'closePrice';
    SG.cells[SGFieldCol[15], 0] := 'stopLoss';
    SG.cells[SGFieldCol[16], 0] := 'takeProfit';
    SG.cells[SGFieldCol[17], 0] := 'swap';
    SG.cells[SGFieldCol[18], 0] := 'profit';
    SG.cells[SGFieldCol[19], 0] := 'volume';
    SG.cells[SGFieldCol[20], 0] := 'precision';
    SG.cells[SGFieldCol[21], 0] := 'conversionRate0';
    SG.cells[SGFieldCol[22], 0] := 'conversionRate1';
    SG.cells[SGFieldCol[23], 0] := 'marginRate';
    SG.cells[SGFieldCol[24], 0] := 'symGroupId';
    SG.Rows[0].endUpdate;

    // lbStatistics.Items.Add('z:' + inttostr(GetTickCount() - gt) + ' count:' + inttostr(sl.count));

    row := 0;
    k := 0;
    while (k < ct) do

    begin
      row := row + 1;
      if (row < (total + 1)) then
      begin
        SG.Rows[row].BeginUpdate;

        SG.cells[SGFieldCol[0], row] := inttostr(actions[k].actionId);
        SG.cells[SGFieldCol[1], row] := inttostr(actions[k].userId);
        SG.cells[SGFieldCol[2], row] := accountShort[actions[k].accountId];
        SG.cells[SGFieldCol[3], row] := getCwSymbol(actions[k].symbolId);
        SG.cells[SGFieldCol[4], row] := inttostr(actions[k].symbolId);
        SG.cells[SGFieldCol[5], row] := getCwComment(actions[k].commentId);
        SG.cells[SGFieldCol[6], row] := OrderTypes(actions[k].typeId - 1); // cw statt 0..6 ist 1..7
        SG.cells[SGFieldCol[7], row] := inttostr(actions[k].sourceId);
        SG.cells[SGFieldCol[8], row] := DateTimeToStr(UnixToDateTime(actions[k].openTime));
        SG.cells[SGFieldCol[9], row] := DateTimeToStr(UnixToDateTime(actions[k].closeTime));
        SG.cells[SGFieldCol[10], row] := inttostr(actions[k].openTime);
        SG.cells[SGFieldCol[11], row] := inttostr(actions[k].closeTime);
        SG.cells[SGFieldCol[12], row] := DateTimeToStr(UnixToDateTime(actions[k].expirationTime));
        SG.cells[SGFieldCol[13], row] := floattostr(actions[k].openPrice);
        SG.cells[SGFieldCol[14], row] := floattostr(actions[k].closePrice);
        SG.cells[SGFieldCol[15], row] := floattostr(actions[k].stopLoss);
        SG.cells[SGFieldCol[16], row] := floattostr(actions[k].takeProfit);
        SG.cells[SGFieldCol[17], row] := floattostr(actions[k].swap);
        SG.cells[SGFieldCol[18], row] := floattostr(actions[k].profit);
        SG.cells[SGFieldCol[19], row] := FormatFloat(',#0.00', actions[k].volume / 100);
        SG.cells[SGFieldCol[20], row] := inttostr(actions[k].precision);
        SG.cells[SGFieldCol[21], row] := floattostr(actions[k].conversionRate0);
        SG.cells[SGFieldCol[22], row] := floattostr(actions[k].conversionRate0);
        SG.cells[SGFieldCol[23], row] := floattostr(actions[k].marginRate);
        if cwSymbolsGroupsCt > 0 then
          SG.cells[SGFieldCol[24], row] := cwSymbolsGroups[cwSymbolsPlus[actions[k].symbolId].groupId].name;

        SG.Rows[row].endUpdate;
      end
      else
      begin
        break;
      end;
      k := k + stp;
    end;

  except
    // debug('Fehler');
    s := 'Fehler';
  end;
  // {$RANGECHECKS ON}
end;

const
  // Sets UnixStartDate to TDateTime of 01/01/1970
  UnixStartDate: TDateTime = 25569.0;

function DateTimeToUnix(ConvDate: TDateTime): Longint;
begin
  // example: DateTimeToUnix(now);
  result := Round((ConvDate - UnixStartDate) * 86400);
end;

function UnixToDateTime(UnixTime: dword): TDateTime;

// const
// UnixTime = 1427359860;
var
  dt: TDateTime;
begin
  dt := EncodeDate(1970, 1, 1);
  dt := dt + UnixTime / 86400;
  // IncSecond(dt, UnixTime);   86400 sec/Tag   Die Integer gehen bis 2147483647 und das reicht bis 2038
  result := dt;
end;

function getCwComment(id: integer): string;
begin
  result := '';
  if id < cwCommentsCt then
    result := cwComments[id].text;
end;

function getCwSymbol(id: integer): string;
// Achtung wenn umsortiert ist das der Index aber nicht die symbolId
begin
  try
    result := '';
    if id < cwSymbolsCt then
      result := cwSymbols[id].name;
  except
    result := '';
  end;
end;

function OrderTypes(cmd: integer): string;
begin
  case cmd of
    0:
      result := 'BUY';
    1:
      result := 'SELL';
    2:
      result := 'BUY Limit';
    3:
      result := 'SELL Limit';
    4:
      result := 'BUY Stop';
    5:
      result := 'SELL Stop';
    6:
      result := 'BALANCE';
    7:
      result := 'CREDIT';

  else
    result := inttostr(cmd);

  end;
end;

procedure doUsersGridCW(SG: TStringGridSorted; SGFieldCol: DAInteger; users: DAcwUser; usersPlus: DACwUserPlus; ct: integer; total: integer; stp: integer = 1);
// nicht mehr verwendet

var
  k: integer;
  row: integer;
  rct: integer;
  rct1: integer;
begin
  try
    // sl := TStringList.Create;
    // die Gr��e gleich festlegen
    rct := trunc(ct / stp) + 1;
    rct1 := total + 1;
    if rct1 < rct then
      rct := rct1;

    SG.RowCount := rct;
    SG.ColCount := 26;
    if (SG.RowCount > 1) then
      SG.FixedRows := 1;

    SG.cells[SGFieldCol[0], 0] := 'userId';
    // SG.ColWidths[SGFieldCol[0]] := 100;
    SG.cells[SGFieldCol[1], 0] := 'accountId';
    SG.cells[SGFieldCol[2], 0] := 'group';
    SG.cells[SGFieldCol[3], 0] := 'enable';
    SG.cells[SGFieldCol[4], 0] := 'registrationTime';
    SG.cells[SGFieldCol[5], 0] := 'lastLoginTime';
    SG.cells[SGFieldCol[6], 0] := 'leverage';
    SG.cells[SGFieldCol[7], 0] := 'balance';
    SG.cells[SGFieldCol[8], 0] := 'balancePreviousMonth';
    SG.cells[SGFieldCol[9], 0] := 'balancePreviousDay';
    SG.cells[SGFieldCol[10], 0] := 'credit';
    SG.cells[SGFieldCol[11], 0] := 'interestrate';
    SG.cells[SGFieldCol[12], 0] := 'taxes';
    SG.cells[SGFieldCol[13], 0] := 'name';
    SG.cells[SGFieldCol[14], 0] := 'country';
    SG.cells[SGFieldCol[15], 0] := 'city';
    SG.cells[SGFieldCol[16], 0] := 'state';
    SG.cells[SGFieldCol[17], 0] := 'zipcode';
    SG.cells[SGFieldCol[18], 0] := 'address';
    SG.cells[SGFieldCol[19], 0] := 'phone';
    SG.cells[SGFieldCol[20], 0] := 'email';
    SG.cells[SGFieldCol[21], 0] := 'socialNumber';
    SG.cells[SGFieldCol[22], 0] := 'comment';
    SG.cells[SGFieldCol[23], 0] := 'trades';
    SG.cells[SGFieldCol[24], 0] := 'profit';
    SG.cells[SGFieldCol[25], 0] := 'totalbalance';

    // lbStatistics.Items.Add('z:' + inttostr(GetTickCount() - gt) + ' count:' + inttostr(sl.count));


    // merkSeparator:=FormatSettings.DecimalSeparator;
    // FormatSettings.DecimalSeparator:='.';

    row := 0;
    k := 0;
    while (k < ct) do
    // userId: integer;
    // accountId: integer;
    // group: string;
    // enable: integer;
    // registrationTime: integer;
    // lastLoginTime: integer;
    // leverage: integer;
    // balance: double;
    // balancePreviousMonth: double;
    // balancePreviousDay: double;
    // credit: double;
    // interestrate: double;
    // taxes: double;
    // name: string;
    // country: string;
    // city: string;
    // state: string;
    // zipcode: string;
    // address: string;
    // phone: string;
    // email: string;
    // socialNumber: string;
    // comment: string;

    begin
      row := row + 1;
      if (row < (total + 1)) then
      begin
        SG.cells[SGFieldCol[0], row] := inttostr(users[k].userId);
        SG.cells[SGFieldCol[1], row] := accountShort[users[k].accountId];
        SG.cells[SGFieldCol[2], row] := users[k].group;
        SG.cells[SGFieldCol[3], row] := inttostr(users[k].enable);
        SG.cells[SGFieldCol[4], row] := inttostr(users[k].registrationTime);
        SG.cells[SGFieldCol[5], row] := inttostr(users[k].lastLoginTime);
        SG.cells[SGFieldCol[6], row] := inttostr(users[k].leverage);
        SG.cells[SGFieldCol[7], row] := floattostr(users[k].balance);
        SG.cells[SGFieldCol[8], row] := floattostr(users[k].balancePreviousMonth);
        SG.cells[SGFieldCol[9], row] := floattostr(users[k].balancePreviousDay);
        SG.cells[SGFieldCol[10], row] := floattostr(users[k].credit);
        SG.cells[SGFieldCol[11], row] := floattostr(users[k].interestrate);
        SG.cells[SGFieldCol[12], row] := floattostr(users[k].taxes);
        SG.cells[SGFieldCol[13], row] := users[k].name;
        SG.cells[SGFieldCol[14], row] := users[k].country;
        SG.cells[SGFieldCol[15], row] := users[k].city;
        SG.cells[SGFieldCol[16], row] := users[k].state;
        SG.cells[SGFieldCol[17], row] := users[k].zipcode;
        SG.cells[SGFieldCol[18], row] := users[k].address;
        SG.cells[SGFieldCol[19], row] := users[k].phone;
        SG.cells[SGFieldCol[20], row] := users[k].email;
        SG.cells[SGFieldCol[21], row] := users[k].socialNumber;
        SG.cells[SGFieldCol[22], row] := users[k].comment;
        SG.cells[SGFieldCol[23], row] := inttostr(usersPlus[k].totalTrades);
        SG.cells[SGFieldCol[24], row] := FormatFloat(',#0.00', usersPlus[k].totalProfit);
        SG.cells[SGFieldCol[25], row] := FormatFloat(',#0.00', usersPlus[k].totalBalance);

      end
      else
      begin
        break;
      end;
      k := k + stp;
    end;

  except
    // debug('Fehler');
  end;
  // {$RANGECHECKS ON}
end;

procedure doCommentsGridCW(SG: TStringGridSorted; SGFieldCol: DAInteger; comments: DAcwComment; commentsPlus: DACwCommentPlus; ct, total, stp: integer);
// nicht mehr verwendet
var
  k: integer;
  // sl: TStringList;
  row: integer;
  rct: integer;
  rct1: integer;
begin
  try
    // sl := TStringList.Create;
    // die Gr��e gleich festlegen
    rct := trunc(ct / stp) + 1;
    rct1 := total + 1;
    if rct1 < rct then
      rct := rct1;

    SG.RowCount := rct;
    SG.ColCount := 2;
    if (SG.RowCount > 1) then
      SG.FixedRows := 1;

    SG.cells[SGFieldCol[0], 0] := 'commentId';
    // SG.ColWidths[SGFieldCol[0]] := 100;
    SG.cells[SGFieldCol[1], 0] := 'comment';
    // SG.ColWidths[SGFieldCol[1]] := 300;

    // merkSeparator:=FormatSettings.DecimalSeparator;
    // FormatSettings.DecimalSeparator:='.';

    row := 0;
    k := 0;
    while (k < ct) do
    // symbolId: integer;
    // brokerId: integer;
    // name: string;
    // description: string;
    // currency: string; // currency
    // margin_currency: string; // currency of margin requirements
    // digits: integer; // security precision
    // tradeMode: integer; // trade mode
    // expiration: time_t; // trades end date      (UNIX time)
    // contractSize:double;
    // tickValue: double; // one tick value
    // tickSize: double; // one tick size
    // type_: integer; // security group (see ConSymbolGroup
    begin
      row := row + 1;
      if (row < (total + 1)) then
      begin
        SG.cells[SGFieldCol[0], row] := inttostr(comments[k].commentId);
        SG.cells[SGFieldCol[1], row] := comments[k].text;
      end
      else
      begin
        break;
      end;
      k := k + stp;
    end;

  except
    // debug('Fehler');
  end;
  // {$RANGECHECKS ON}
end;

procedure doSymbolsGridCW(SG: TStringGridSorted; SGFieldCol: DAInteger; symbols: DACwSymbol; symbolsPlus: DACwSymbolPlus; ct, total, stp: integer);
// nicht mehr verwendet

var
  k: integer;
  row: integer;
  rct: integer;
  rct1: integer;
begin
  try
    // sl := TStringList.Create;
    // die Gr��e gleich festlegen
    rct := trunc(ct / stp) + 1;
    rct1 := total + 1;
    if rct1 < rct then
      rct := rct1;

    SG.RowCount := rct;
    SG.ColCount := 17;
    if (SG.RowCount > 1) then
      SG.FixedRows := 1;

    SG.cells[SGFieldCol[0], 0] := 'symbolId';
    // SG.ColWidths[SGFieldCol[0]] := 100;
    SG.cells[SGFieldCol[1], 0] := 'brokerId';
    SG.cells[SGFieldCol[2], 0] := 'name';
    SG.cells[SGFieldCol[3], 0] := 'description';
    SG.cells[SGFieldCol[4], 0] := 'currency';
    SG.cells[SGFieldCol[5], 0] := 'margin_currency';
    SG.cells[SGFieldCol[6], 0] := 'digits';
    SG.cells[SGFieldCol[7], 0] := 'tradeMode';
    SG.cells[SGFieldCol[8], 0] := 'expiration';
    SG.cells[SGFieldCol[9], 0] := 'contractSize';
    SG.cells[SGFieldCol[10], 0] := 'tickValue';
    SG.cells[SGFieldCol[11], 0] := 'tickSize';
    SG.cells[SGFieldCol[12], 0] := 'type_';
    SG.cells[SGFieldCol[13], 0] := 'trades';
    SG.cells[SGFieldCol[14], 0] := 'volume';
    SG.cells[SGFieldCol[15], 0] := 'profit';
    SG.cells[SGFieldCol[16], 0] := 'swap';
    SG.cells[SGFieldCol[17], 0] := 'symGroup';

    // lbStatistics.Items.Add('z:' + inttostr(GetTickCount() - gt) + ' count:' + inttostr(sl.count));


    // merkSeparator:=FormatSettings.DecimalSeparator;
    // FormatSettings.DecimalSeparator:='.';

    row := 0;
    k := 0;
    while (k < ct) do
    // symbolId: integer;
    // brokerId: integer;
    // name: string;
    // description: string;
    // currency: string; // currency
    // margin_currency: string; // currency of margin requirments
    // digits: integer; // security precision
    // tradeMode: integer; // trade mode
    // expiration: time_t; // trades end date      (UNIX time)
    // contractSize:double;
    // tickValue: double; // one tick value
    // tickSize: double; // one tick size
    // type_: integer; // security group (see ConSymbolGroup
    begin
      row := row + 1;
      if (row < (total + 1)) then
      begin
        SG.cells[SGFieldCol[0], row] := inttostr(symbols[k].symbolId);
        SG.cells[SGFieldCol[1], row] := inttostr(symbols[k].brokerId);
        SG.cells[SGFieldCol[2], row] := symbols[k].name;
        SG.cells[SGFieldCol[3], row] := symbols[k].description;
        SG.cells[SGFieldCol[4], row] := symbols[k].currency;
        SG.cells[SGFieldCol[5], row] := symbols[k].margin_currency;
        SG.cells[SGFieldCol[6], row] := inttostr(symbols[k].digits);
        SG.cells[SGFieldCol[7], row] := inttostr(symbols[k].tradeMode);
        SG.cells[SGFieldCol[8], row] := inttostr(symbols[k].expiration);
        SG.cells[SGFieldCol[9], row] := floattostr(symbols[k].contractSize);
        SG.cells[SGFieldCol[10], row] := floattostr(symbols[k].tickValue);
        SG.cells[SGFieldCol[11], row] := floattostr(symbols[k].tickSize);
        SG.cells[SGFieldCol[12], row] := inttostr(symbols[k].type_);
        SG.cells[SGFieldCol[13], row] := inttostr(symbolsPlus[k].TradesCount);
        SG.cells[SGFieldCol[14], row] := FormatFloat(',#0.00', symbolsPlus[k].TradesVolumeTotal / 100);
        SG.cells[SGFieldCol[15], row] := FormatFloat(',#0.00', symbolsPlus[k].TradesProfitTotal);
        SG.cells[SGFieldCol[16], row] := FormatFloat(',#0.00', symbolsPlus[k].TradesSwapTotal);
        if cwSymbolsGroupsCt > 0 then
          SG.cells[SGFieldCol[17], row] := cwSymbolsGroups[symbolsPlus[k].groupId].name;

      end
      else
      begin
        break;
      end;
      k := k + stp;
    end;

  except
    // debug('Fehler');
  end;
  // {$RANGECHECKS ON}
end;

procedure doSymbolsGroupsGridCW(SG: TStringGridSorted; SGFieldCol: DAInteger; symbolsGroups: DACwSymbolGroup; ct, total, stp: integer);
var
  k: integer;
  row: integer;
  rct: integer;
  rct1: integer;

begin
  try
    // sl := TStringList.Create;
    // die Gr��e gleich festlegen
    rct := trunc(ct / stp) + 1;
    rct1 := total + 1;
    if rct1 < rct then
      rct := rct1;

    SG.RowCount := rct;
    SG.ColCount := 8;
    if (SG.RowCount > 1) then
      SG.FixedRows := 1;
    // name:string;        //GE30
    // sourceNames:string; //GE30-Apr;GE30-Jul...
    // sourceIds:string;   //122;133;155;...
    // TradesCount:integer;
    // TradesVolumeTotal:double;
    // TradesUsers:integer;//wieviele User handelten Symbol
    // TradesProfitTotal:double;

    SG.cells[SGFieldCol[0], 0] := 'groupId';
    // SG.ColWidths[SGFieldCol[0]] := 100;
    SG.cells[SGFieldCol[1], 0] := 'name';
    SG.cells[SGFieldCol[2], 0] := 'TradesCount';
    SG.cells[SGFieldCol[3], 0] := 'T.VolumeTotal';
    SG.cells[SGFieldCol[4], 0] := 'T.Users';
    SG.cells[SGFieldCol[5], 0] := 'T.ProfitTotal';
    SG.cells[SGFieldCol[6], 0] := 'T.SwapTotal';
    SG.cells[SGFieldCol[7], 0] := 'sourceNames';
    SG.cells[SGFieldCol[8], 0] := 'sourceIds';
    row := 0;
    k := 0;
    while (k < ct) do
    begin
      row := row + 1;
      if (row < (total + 1)) then
      begin
        SG.cells[SGFieldCol[0], row] := inttostr(symbolsGroups[k].groupId);
        SG.cells[SGFieldCol[1], row] := symbolsGroups[k].name;
        SG.cells[SGFieldCol[2], row] := inttostr(symbolsGroups[k].TradesCount);
        SG.cells[SGFieldCol[3], row] := FormatFloat(',#0.00', symbolsGroups[k].TradesVolumeTotal / 100);
        SG.cells[SGFieldCol[4], row] := inttostr(symbolsGroups[k].TradesUsers);
        SG.cells[SGFieldCol[5], row] := FormatFloat(',#0.00', symbolsGroups[k].TradesProfitTotal);
        SG.cells[SGFieldCol[6], row] := FormatFloat(',#0.00', symbolsGroups[k].TradesSwapTotal);
        SG.cells[SGFieldCol[7], row] := symbolsGroups[k].sourceNames;
        SG.cells[SGFieldCol[8], row] := symbolsGroups[k].sourceIds;


        // SG.cells[SGFieldCol[15], row] := FormatFloat(',#0.00',symbolsPlus[k].TradesProfitTotal);
        // if cwsymbolsgroupsct>0 then SG.cells[SGFieldCol[16], row] := cwsymbolsgroups[symbolsplus[k].groupId].name;

      end
      else
      begin
        break;
      end;
      k := k + stp;
    end;

  except
    // debug('Fehler');
  end;
  // {$RANGECHECKS ON}
end;

function loadCacheFileCw(fname: string; typ: string; lb: TListBox): integer;
var
  folder: string;
  fileName: string;
  fstream: TStream;
  gt: Cardinal;
  FSize: integer;
  ct: integer;
  cwa: cwAction;
  cwu: cwUser;
  cws: cwSymbol;
  cwc: cwComment;
  cwot: TTradeRecord;
  a: integer;
begin
  try
    gt := GetTickCount();
    folder := ExtractFilePath(paramstr(0)) + cCacheFolder;
    createDir(folder);

    fileName := fname;
    if fileexists(fileName) then
    begin
      fstream := TFileStream.Create(fileName, fmOpenRead or fmShareDenyNone);

      Case IndexStr(typ, ['actions', 'users', 'symbols', 'comments', 'opentrades']) of
        0: // das kommt vor
          begin
            ct := trunc(fstream.Size / SizeOf(cwa));
            SetLength(cwActions, ct);
            SetLength(cwActionsPlus, ct);
            cwActionsSorted := false;
            a := SizeOf(cwa);
            fstream.ReadBuffer(cwActions[0], ct * SizeOf(cwa)); // nicht die ganze stream.size !
          end;
        1:
          begin
            ct := trunc(fstream.Size / SizeOf(cwu));
            SetLength(cwUsers, ct);
            SetLength(cwUsersPlus, ct);
            SetLength(cwUsersSortIndex, 0); // zur�cksetzen
            SetLength(cwUsersSortIndex2, 0); // zur�cksetzen
            fstream.ReadBuffer(cwUsers[0], ct * SizeOf(cwu)); // nicht die ganze stream.size !
            // showmessage(inttostr(fstream.Size) + ' ' + inttostr(ct * SizeOf(cwu)));
          end;
        2:
          begin
            ct := trunc(fstream.Size / SizeOf(cws));
            SetLength(cwSymbols, ct);
            SetLength(cwSymbolsPlus, ct);
            SetLength(cwSymbolsSortIndex, 0); // zur�cksetzen
            fstream.ReadBuffer(cwSymbols[0], ct * SizeOf(cws)); // nicht die ganze stream.size !

          end;
        3:
          begin
            ct := trunc(fstream.Size / SizeOf(cwc));
            SetLength(cwComments, ct);
            SetLength(cwCommentsPlus, ct);
            fstream.ReadBuffer(cwComments[0], ct * SizeOf(cwc)); // nicht die ganze stream.size !

          end;
        4:
          begin // im Ausnahmefall f�r die Fehlersuche in den OTR-Dateien
            ct := trunc(fstream.Size / SizeOf(cwot));
            SetLength(cwTradeRecords, ct);
            fstream.ReadBuffer(cwTradeRecords[0], ct * SizeOf(cwot)); // nicht die ganze stream.size !
          end;

      End;
      result := 1;
    end
    else
    begin
      // showmessage('Die Datei existiert nicht');
      result := 0;
    end;
  finally
    if fileexists(fileName) then
      fstream.Free;
  end;
  lbAdd(lb, 'Zeit LoadCacheFileCw:' + inttostr(GetTickCount() - gt));
  // p0 := @cwActions[0];

end;

procedure saveCacheFileCw(fname: string; typ: string; lb: TListBox);
// das ist der Cache im API-Format
var
  folder: string;
  fileName: string;
  fstream: TStream;
  l: integer;
  gt, td: Cardinal;
begin
  try
    gt := GetTickCount();
    folder := ExtractFilePath(paramstr(0)) + cCacheFolder;
    createDir(folder);
    fileName := folder + '\' + fname + '.bin';
    fstream := TFileStream.Create(fileName, fmCreate);

    Case IndexStr(typ, ['actions', 'users', 'symbols', 'comments']) of
      0:
        begin
          l := SizeOf(cwActions[0]);
          fstream.WriteBuffer(cwActions[0], l * length(cwActions)); // nicht 1 mehr ?
        end;
      1:
        begin
          l := SizeOf(cwUsers[0]);
          fstream.WriteBuffer(cwUsers[0], l * length(cwUsers)); // nicht 1 mehr ?
        end;
      2:
        begin
          l := SizeOf(cwSymbols[0]);
          fstream.WriteBuffer(cwSymbols[0], l * length(cwSymbols)); // nicht 1 mehr ?
        end;
      3:
        begin
          l := SizeOf(cwComments[0]);
          fstream.WriteBuffer(cwComments[0], l * length(cwComments)); // nicht 1 mehr ?
        end;
    End;

  finally
    fstream.Free;
  end;
  td := GetTickCount - gt;
  lb.items.add('Zeit SaveCacheFile:' + inttostr(td)); // 1.5 sec
end;

procedure QuicksortUAStringInt(low, high: integer; var dbla: StringArray; var inta: intArray);
// Alphanumerisch aufw�rts StrinArray wird sortiert und IntArray wird mitgezogen
var
  pivotIndex: integer;
  pivotValue: string;
  Left, Right: integer;
begin

  pivotIndex := GetPIndex(low, high);
  pivotValue := dbla[pivotIndex];

  Left := low;
  Right := high;
  repeat

    while ((Left <= high) and (dbla[Left] < pivotValue)) do
    begin
      Inc(Left);
    end;

    while ((Right >= low) and (pivotValue < dbla[Right])) do
    begin
      Dec(Right);
    end;
    if (Left <= Right) then
    begin
      swap(dbla[Left], dbla[Right]);
      SwapInt(inta[Left], inta[Right]);
      Inc(Left);
      Dec(Right);
    end;

  until (Left > Right);

  if (low < Right) then
  begin
    QuicksortUAStringInt(low, Right, dbla, inta);
  end;

  if (Left < high) then
  begin
    QuicksortUAStringInt(Left, high, dbla, inta);
  end;
end;

procedure QuicksortVUA(low, high: integer; var dbla: doubleArray; var inta: intArray);
// value aufw�rts
var
  pivotIndex: integer;
  pivotValue: double;
  Left, Right: integer;
begin
  pivotIndex := GetPIndex(low, high);
  pivotValue := dbla[pivotIndex];
  Left := low;
  Right := high;
  repeat
    while ((Left <= high) and (dbla[Left] < pivotValue)) do
    begin
      Inc(Left);
    end;

    while ((Right >= low) and (pivotValue < dbla[Right])) do
    begin
      Dec(Right);
    end;
    if (Left <= Right) then
    begin
      SwapDbl(dbla[Left], dbla[Right]);
      SwapInt(inta[Left], inta[Right]);
      Inc(Left);
      Dec(Right);
    end;
  until (Left > Right);

  if (low < Right) then
  begin
    QuicksortVUA(low, Right, dbla, inta);
  end;

  if (Left < high) then
  begin
    QuicksortVUA(Left, high, dbla, inta);
  end;
end;

procedure QuicksortVUI(low, high: integer; var dbla: intArray; var inta: intArray);
// value aufw�rts
//
var
  pivotIndex: integer;
  pivotValue: integer;
  Left, Right: integer;
begin
  pivotIndex := GetPIndex(low, high);
  pivotValue := dbla[pivotIndex];
  Left := low;
  Right := high;
  repeat
    while ((Left <= high) and (dbla[Left] < pivotValue)) do
    begin
      Inc(Left);
    end;

    while ((Right >= low) and (pivotValue < dbla[Right])) do
    begin
      Dec(Right);
    end;
    if (Left <= Right) then
    begin
      SwapInt(dbla[Left], dbla[Right]);
      SwapInt(inta[Left], inta[Right]);
      Inc(Left);
      Dec(Right);
    end;
  until (Left > Right);

  if (low < Right) then
  begin
    QuicksortVUI(low, Right, dbla, inta);
  end;

  if (Left < high) then
  begin
    QuicksortVUI(Left, high, dbla, inta);
  end;
end;

procedure QuicksortVUI64(low, high: integer; var dbla: int64Array; var inta: intArray);
// value aufw�rts
//
var
  pivotIndex: integer;
  pivotValue: int64;
  Left, Right: integer;
begin
  pivotIndex := GetPIndex(low, high);
  pivotValue := dbla[pivotIndex];
  Left := low;
  Right := high;
  repeat
    while ((Left <= high) and (dbla[Left] < pivotValue)) do
    begin
      Inc(Left);
    end;

    while ((Right >= low) and (pivotValue < dbla[Right])) do
    begin
      Dec(Right);
    end;
    if (Left <= Right) then
    begin
      SwapInt64(dbla[Left], dbla[Right]);
      SwapInt(inta[Left], inta[Right]);
      Inc(Left);
      Dec(Right);
    end;
  until (Left > Right);

  if (low < Right) then
  begin
    QuicksortVUI64(low, Right, dbla, inta);
  end;

  if (Left < high) then
  begin
    QuicksortVUI64(Left, high, dbla, inta);
  end;
end;

// procedure QuicksortVUAInteger(low, high: integer; var dbla: intArray; var inta: intArray);
procedure QuicksortVUAIntegerString(low, high: integer; var inta: intArray; var stra: StringArray);
// value aufw�rts  StringArray wird mitgezogen
var
  pivotIndex: integer;
  pivotValue: integer;
  Left, Right: integer;
begin

  pivotIndex := GetPIndex(low, high);
  pivotValue := inta[pivotIndex];

  Left := low;
  Right := high;
  repeat

    while ((Left <= high) and (inta[Left] < pivotValue)) do
    begin
      Inc(Left);
    end;

    while ((Right >= low) and (pivotValue < inta[Right])) do
    begin
      Dec(Right);
    end;
    if (Left <= Right) then
    begin
      SwapInt(inta[Left], inta[Right]);
      swap(stra[Left], stra[Right]);
      Inc(Left);
      Dec(Right);
    end;

  until (Left > Right);

  if (low < Right) then
  begin
    QuicksortVUAIntegerString(low, Right, inta, stra);
  end;

  if (Left < high) then
  begin
    QuicksortVUAIntegerString(Left, high, inta, stra);
  end;
end;

procedure QuicksortVDA(low, high: integer; var dbla: doubleArray; var inta: intArray);
// value abw�rts
var
  pivotIndex: integer;
  pivotValue: double;
  Left, Right: integer;
begin

  pivotIndex := GetPIndex(low, high);
  pivotValue := dbla[pivotIndex];

  Left := low;
  Right := high;
  repeat

    while ((Left <= high) and (dbla[Left] > pivotValue)) do
    begin
      Inc(Left);
    end;

    while ((Right >= low) and (pivotValue > dbla[Right])) do
    begin
      Dec(Right);
    end;
    if (Left <= Right) then
    begin
      SwapDbl(dbla[Left], dbla[Right]);
      SwapInt(inta[Left], inta[Right]);
      Inc(Left);
      Dec(Right);
    end;

  until (Left > Right);

  if (low < Right) then
  begin
    QuicksortVDA(low, Right, dbla, inta);
  end;

  if (Left < high) then
  begin
    QuicksortVDA(Left, high, dbla, inta);
  end;
end;

procedure QuicksortVDI(low, high: integer; var dbla: intArray; var inta: intArray);
// value abw�rts
var
  pivotIndex: integer;
  pivotValue: integer;
  Left, Right: integer;
begin

  pivotIndex := GetPIndex(low, high);
  pivotValue := dbla[pivotIndex];

  Left := low;
  Right := high;
  repeat

    while ((Left <= high) and (dbla[Left] > pivotValue)) do
    begin
      Inc(Left);
    end;

    while ((Right >= low) and (pivotValue > dbla[Right])) do
    begin
      Dec(Right);
    end;
    if (Left <= Right) then
    begin
      SwapInt(dbla[Left], dbla[Right]);
      SwapInt(inta[Left], inta[Right]);
      Inc(Left);
      Dec(Right);
    end;

  until (Left > Right);

  if (low < Right) then
  begin
    QuicksortVDI(low, Right, dbla, inta);
  end;

  if (Left < high) then
  begin
    QuicksortVDI(Left, high, dbla, inta);
  end;
end;

procedure QuicksortVDI64(low, high: integer; var dbla: int64Array; var inta: intArray);
// value abw�rts
var
  pivotIndex: integer;
  pivotValue: int64;
  Left, Right: integer;
begin

  pivotIndex := GetPIndex(low, high);
  pivotValue := dbla[pivotIndex];

  Left := low;
  Right := high;
  repeat

    while ((Left <= high) and (dbla[Left] > pivotValue)) do
    begin
      Inc(Left);
    end;

    while ((Right >= low) and (pivotValue > dbla[Right])) do
    begin
      Dec(Right);
    end;
    if (Left <= Right) then
    begin
      SwapInt64(dbla[Left], dbla[Right]);
      SwapInt(inta[Left], inta[Right]);
      Inc(Left);
      Dec(Right);
    end;

  until (Left > Right);

  if (low < Right) then
  begin
    QuicksortVDI64(low, Right, dbla, inta);
  end;

  if (Left < high) then
  begin
    QuicksortVDI64(Left, high, dbla, inta);
  end;
end;

procedure QuicksortVDAS(low, high: integer; var dbla: StringArray; var inta: intArray);
// value abw�rts
var
  pivotIndex: integer;
  pivotValue: string;
  Left, Right: integer;
begin

  pivotIndex := GetPIndex(low, high);
  pivotValue := dbla[pivotIndex];

  Left := low;
  Right := high;
  repeat

    while ((Left <= high) and (dbla[Left] > pivotValue)) do
    begin
      Inc(Left);
    end;

    while ((Right >= low) and (pivotValue > dbla[Right])) do
    begin
      Dec(Right);
    end;
    if (Left <= Right) then
    begin
      swap(dbla[Left], dbla[Right]);
      SwapInt(inta[Left], inta[Right]);
      Inc(Left);
      Dec(Right);
    end;

  until (Left > Right);

  if (low < Right) then
  begin
    QuicksortVDAS(low, Right, dbla, inta);
  end;

  if (Left < high) then
  begin
    QuicksortVDAS(Left, high, dbla, inta);
  end;
end;

procedure QuicksortVU(low, high: integer; var Ordliste: StringArray);
// value aufw�rts
var
  pivotIndex: integer;
  pivotValue: double;
  Left, Right: integer;
begin

  pivotIndex := GetPIndex(low, high);
  pivotValue := strGleichToFloat(Ordliste[pivotIndex]);

  Left := low;
  Right := high;
  repeat

    while ((Left <= high) and (strGleichToFloat(Ordliste[Left]) < pivotValue)) do
    begin
      Inc(Left);
    end;

    while ((Right >= low) and (pivotValue < strGleichToFloat(Ordliste[Right]))) do
    begin
      Dec(Right);
    end;
    if (Left <= Right) then
    begin
      swap(Ordliste[Left], Ordliste[Right]);
      Inc(Left);
      Dec(Right);
    end;

  until (Left > Right);

  if (low < Right) then
  begin
    QuicksortVU(low, Right, Ordliste);
  end;

  if (Left < high) then
  begin
    QuicksortVU(Left, high, Ordliste);
  end;
end;

procedure QuicksortVD(low, high: integer; var Ordliste: StringArray);
// value aufw�rts
var
  pivotIndex: integer;
  pivotValue: double;
  Left, Right: integer;
begin

  pivotIndex := GetPIndex(low, high);
  pivotValue := strGleichToFloat(Ordliste[pivotIndex]);

  Left := low;
  Right := high;
  repeat

    while ((Left <= high) and (strGleichToFloat(Ordliste[Left]) > pivotValue)) do
    begin
      Inc(Left);
    end;

    while ((Right >= low) and (pivotValue > strGleichToFloat(Ordliste[Right]))) do
    begin
      Dec(Right);
    end;
    if (Left <= Right) then
    begin
      swap(Ordliste[Left], Ordliste[Right]);
      Inc(Left);
      Dec(Right);
    end;

  until (Left > Right);

  if (low < Right) then
  begin
    QuicksortVD(low, Right, Ordliste);
  end;

  if (Left < high) then
  begin
    QuicksortVD(Left, high, Ordliste);
  end;
end;

procedure QuicksortAU(low, high: integer; var Ordliste: StringArray);
// alphanumerisch aufw�rts
var
  pivotIndex: integer;
  pivotValue: string;
  Left, Right: integer;
begin

  pivotIndex := GetPIndex(low, high);
  pivotValue := Ordliste[pivotIndex];

  Left := low;
  Right := high;
  repeat

    while ((Left <= high) and (Ordliste[Left] < pivotValue)) do
    begin
      Inc(Left);
    end;

    while ((Right >= low) and (pivotValue < Ordliste[Right])) do
    begin
      Dec(Right);
    end;
    if (Left <= Right) then
    begin
      swap(Ordliste[Left], Ordliste[Right]);
      Inc(Left);
      Dec(Right);
    end;

  until (Left > Right);

  if (low < Right) then
  begin
    QuicksortAU(low, Right, Ordliste);
  end;

  if (Left < high) then
  begin
    QuicksortAU(Left, high, Ordliste);
  end;
end;

procedure QuicksortAD(low, high: integer; var Ordliste: StringArray);
// alphanumerisch aufw�rts
var
  pivotIndex: integer;
  pivotValue: string;
  Left, Right: integer;
begin

  pivotIndex := GetPIndex(low, high);
  pivotValue := Ordliste[pivotIndex];

  Left := low;
  Right := high;
  repeat

    while ((Left <= high) and (Ordliste[Left] > pivotValue)) do
    begin
      Inc(Left);
    end;

    while ((Right >= low) and (pivotValue > Ordliste[Right])) do
    begin
      Dec(Right);
    end;
    if (Left <= Right) then
    begin
      swap(Ordliste[Left], Ordliste[Right]);
      Inc(Left);
      Dec(Right);
    end;

  until (Left > Right);

  if (low < Right) then
  begin
    QuicksortAD(low, Right, Ordliste);
  end;

  if (Left < high) then
  begin
    QuicksortAD(Left, high, Ordliste);
  end;
end;

{ -----------   End of Quicksort routines   ----------------------------- }

{ -----------   The Stringlist sorting routine with casts   ------------- }

procedure FastSortStList(Stlist: TStringList; sTyp: string);
var
  SortArray: StringArray;
  i, j: integer;
begin
  // Cast Stringlist to an array
  if (Stlist.Count = 0) then
    exit;

  gtc := 0;
  SetLength(SortArray, Stlist.Count);
  for i := 0 to Stlist.Count - 1 do
    SortArray[i] := Trim(Stlist.Strings[i]);

  // Now sort
  if (sTyp = 'AU') then
    QuicksortAU(Low(SortArray), High(SortArray), SortArray);
  if (sTyp = 'AD') then
    QuicksortAD(Low(SortArray), High(SortArray), SortArray);
  if (sTyp = 'VU') then
    QuicksortVU(Low(SortArray), High(SortArray), SortArray);
  if (sTyp = 'VD') then
    QuicksortVD(Low(SortArray), High(SortArray), SortArray);

  // Recast
  for j := low(SortArray) to High(SortArray) do
  begin // Sometimes empty entries abound, get rid of them
    if Stlist.Strings[j] <> '' then
      Stlist.Strings[j] := SortArray[j];
  end;

  // Free the array
  SetLength(SortArray, 0);
  // showmessage('gtc:'+inttostr(gtc));
end;

// procedure FastSort2ArrayInteger(dbla: intArray; inta: intArray; styp: string);

procedure FastSort2ArrayStringInteger(inta: intArray; stra: StringArray; sTyp: string);

begin

  if ((low(stra) + high(stra)) = 0) then
    exit;

  if (sTyp = 'UA') then
    QuicksortUAStringInt(Low(stra), High(stra), stra, inta);

end;

procedure FastSort2ArrayIntegerString(inta: intArray; stra: StringArray; sTyp: string);

begin
  // Cast Stringlist to an array
  if ((low(inta) + high(inta)) = 0) then
    exit;

  if (sTyp = 'VUA') then
    QuicksortVUAIntegerString(Low(inta), High(inta), inta, stra);
  // abw�rts nicht ben�tigt
  // if (styp = 'VDA') then
  // QuicksortVDAInteger(Low(dbla), High(dbla), dbla, inta);

end;

procedure FastSort2ArrayDouble(dbla: doubleArray; inta: intArray; sTyp: string);

begin
  // Cast Stringlist to an array
  if ((low(dbla) + high(dbla)) = 0) then
    exit;
  if (sTyp = 'VUA') then
    QuicksortVUA(Low(dbla), High(dbla), dbla, inta);
  if (sTyp = 'VDA') then
    QuicksortVDA(Low(dbla), High(dbla), dbla, inta);

end;

procedure FastSort2ArrayIntInt(dbla: intArray; inta: intArray; sTyp: string);

begin
  // Cast Stringlist to an array

  if ((low(dbla) + high(dbla)) = 0) then
    exit;
  if (sTyp = 'VUI') then
    QuicksortVUI(Low(dbla), High(dbla), dbla, inta);
  if (sTyp = 'VDI') then
    QuicksortVDI(Low(dbla), High(dbla), dbla, inta);

end;

procedure FastSort2ArrayInt64Int(dbla: int64Array; inta: intArray; sTyp: string);

begin
  // Cast Stringlist to an array

  if ((low(dbla) + high(dbla)) = 0) then
    exit;
  if (sTyp = 'VUI') then
    QuicksortVUI64(Low(dbla), High(dbla), dbla, inta);
  if (sTyp = 'VDI') then
    QuicksortVDI64(Low(dbla), High(dbla), dbla, inta);

end;

procedure FastSort2ArrayString(stra: StringArray; inta: intArray; sTyp: string);

begin
  // Cast Stringlist to an array

  if ((low(stra) + high(stra)) = 0) then
    exit;
  if (sTyp = 'VUAS') then
    QuicksortUAStringInt(Low(stra), High(stra), stra, inta);
  if (sTyp = 'VDAS') then
    QuicksortVDAS(Low(stra), High(stra), stra, inta);

end;

function strGleichToFloat(s: string): double;
// wie 1231231234234=3465 aufteilen links vom=
// Diese Funktion wird bei den 2.3 Mio Strings in der Liste gesamt 45 Mio bis 62 Mio mal aufgerufen
var
  pos: integer;
begin
  // gtc:=gtc+1;
  pos := ansipos('$', s);
  if (pos = 0) then
    result := StrToFloat(s)
  else
  begin
    result := StrToFloat(leftstr(s, pos - 1));
  end;
end;

procedure swap(var Value1, Value2: string);
var
  temp: string; // Integer;
begin
  temp := Value1;
  Value1 := Value2;
  Value2 := temp;
end;

procedure SwapDbl(var Value1, Value2: double);
var
  temp: double; // Integer;
begin
  temp := Value1;
  Value1 := Value2;
  Value2 := temp;
end;

procedure SwapInt(var Value1, Value2: integer);
var
  temp: integer;
begin
  temp := Value1;
  Value1 := Value2;
  Value2 := temp;
end;

procedure SwapInt64(var Value1, Value2: int64);
var
  temp: int64;
begin
  temp := Value1;
  Value1 := Value2;
  Value2 := temp;
end;

function GetPIndex(lo, hi: integer): integer;
var
  i: integer;
begin
  i := (lo + hi) div 2;
  GetPIndex := i;
end;

// C-time is number of seconds since the beginning of January 1, 1970

function CTime2DateTime(T: time_c): TDateTime;
begin
  result := EncodeDate(1970, 1, 1) + (T / 86400.0);
end;

function DateTime2CTime(T: TDateTime): time_c;
begin
  result := trunc((T - EncodeDate(1970, 1, 1)) * 86400.0);
end;

// procedure TStringGridSorted.MoveColumn(FromIndex, ToIndex: Longint);
// begin
// inherited;
// end;
//
// procedure TStringGridSorted.MoveRow(FromIndex, ToIndex: Longint);
// begin
// inherited;
// end;

procedure TStringGridSorted.WndProc(var Msg: TMessage);
var
  v: integer;
  c: integer;
begin
  inherited;
  // OldGridProc(Message);
  // der Hi Wert l�uft zwischen 0 und 127 vom oben nach unten im Scroller
  // if ((Message.Msg = WM_VSCROLL) or (Message.Msg = WM_HSCROLL) or  (Message.msg = WM_Mousewheel)) then
  if ((Msg.Msg = WM_VSCROLL)) then
  begin

    if Msg.WParamLo = 5 then // 5=SB_THUMBTRACK  Der Thumb wird bewegt
    begin
      v := visiblerowcount;
      c := RowCount;
      TopRow := trunc(1 + (c - v - 1) / 127 * Msg.WParamHi);
      // bei wenigen mehr als sichtbare Rows springt der Thumb beim Bewegen leider obwohl die Rechnung schon stimmt
      //
      // cells[0,0]:='v:'+inttostr(v)+' c:'+inttostr(c)+' ->tr:'+inttostr(Toprow)+' Hi:'+inttostr(Msg.WParamHi);
    end;
  end;
end;

procedure ClearStringGridSorted(const Grid: FTCommons.TStringGridSorted);
var
  c, R: integer;
begin
  for c := 0 to Pred(Grid.ColCount) do
    for R := 0 to Pred(Grid.RowCount) do
      Grid.cells[c, R] := '';
  // lbDebug3.Items.Add('ClearSG:' + inttostr(GetTickCount - gt));
end;

procedure AutoSizeGrid(Grid, Grid2: FTCommons.TStringGridSorted);
const
  ColWidthMin = 10;
var
  c, R, w, ColWidthMax: integer;
  header: string;
begin
  exit; // vorl�ufig abgeschaltet, da manuell einstellbar !

  for c := 0 to Grid.ColCount - 1 do
  begin
    // bestehende durch -1 unsichtbare Spalten unber�hrt lassen !
    if (Grid.ColWidths[c] <> -1) then
    begin
      header := Grid.cells[c, 0];
      ColWidthMax := ColWidthMin;
      for R := 0 to (Grid.RowCount - 1) do
      begin
        w := Grid.Canvas.TextWidth(Grid.cells[c, R]);
        if w > ColWidthMax then
          ColWidthMax := w;
      end;
      Grid.ColWidths[c] := ColWidthMax + 12;
      if (Grid2 <> nil) then
        Grid2.ColWidths[c] := ColWidthMax + 12;

      if (header = 'unused') then
      begin
        Grid.ColWidths[c] := -1;
        if (Grid2 <> nil) then
          Grid2.ColWidths[c] := -1;
      end;

    end
    else
    begin
      if (Grid2 <> nil) then
        Grid2.ColWidths[c] := -1;
    end;
  end;
end;

procedure dosleep(T: integer);
var
  gt: Cardinal;
  er: string;
begin
  gt := GetTickCount();
  repeat
    Application.ProcessMessages;
  until (GetTickCount - gt) > T;
  // lbstatisticsPumpAdd('sleep rum:' + inttostr(t));
end;

function findActionparameter(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var sel: byteArray; var actions: DACwAction; k: integer; col: integer; such: string; doCount: Boolean = false): integer;
var
  suchlength: integer;
  len: integer;
  von, bis: integer;
  l, M: integer;
  res: string;
  suchtyp: integer;
  Count: integer;
label weiter;
// ganz schlecht �ber eine Spalte �ber den Index zu suchen ...

begin
  Count := 0;
  suchtyp := 0; // normal ab Anfang
  such := uppercase(such);
  res := '';
  if leftstr(such, 1) = '*' then
  begin
    suchtyp := 1;
    such := midstr(such, 2, length(such) - 1);
  end;
  len := length(sort);
  result := -1;
  suchlength := length(such);
  for M := 0 to 1 do
  begin
    if M = 0 then
    begin
      von := k;
      bis := len;
    end;
    if M = 1 then
    begin
      von := 0;
      bis := k;
    end;
    for l := von to bis do
    begin

      if (col = 0) then
      begin
        res := inttostr(actions[sort[l]].actionId) + ' ' + inttostr(l);
        goto weiter;
      end;
      if (col = 1) then
      begin
        res := inttostr(actions[sort[l]].userId);
        goto weiter;
      end;
      if (col = 2) then
      begin
        res := inttostr(actions[sort[l]].accountId);
        goto weiter;
      end;
      if (col = 3) then
      begin
        res := getCwSymbol(actions[sort[l]].symbolId);
        goto weiter;
      end;
      if (col = 4) then
      begin
        res := inttostr(actions[sort[l]].symbolId);
        goto weiter;
      end;
      if (col = 5) then
      begin
        res := getCwComment(actions[sort[l]].commentId);
        goto weiter;
      end;
      if (col = 6) then
      begin
        res := OrderTypes(actions[sort[l]].typeId - 1);
        goto weiter;
      end; // cw statt 0..6 ist 1..7
      if (col = 7) then
      begin
        res := inttostr(actions[sort[l]].sourceId);
        goto weiter;
      end;
      if (col = 8) then
      begin
        res := DateTimeToStr(UnixToDateTime(actions[sort[l]].openTime));
        goto weiter;
      end;
      if (col = 9) then
      begin
        res := DateTimeToStr(UnixToDateTime(actions[sort[l]].closeTime));
        goto weiter;
      end;
      if (col = 10) then
      begin
        res := inttostr(actions[sort[l]].openTime);
        goto weiter;
      end;
      if (col = 11) then
      begin
        res := inttostr(actions[sort[l]].closeTime);
        goto weiter;
      end;
      if (col = 12) then
      begin
        res := DateTimeToStr(UnixToDateTime(actions[sort[l]].expirationTime));
        goto weiter;
      end;
      if (col = 13) then
      begin
        res := floattostr(actions[sort[l]].openPrice);
        goto weiter;
      end;
      if (col = 14) then
      begin
        res := floattostr(actions[sort[l]].closePrice);
        goto weiter;
      end;
      if (col = 15) then
      begin
        res := floattostr(actions[sort[l]].stopLoss);
        goto weiter;
      end;
      if (col = 16) then
      begin
        res := floattostr(actions[sort[l]].takeProfit);
        goto weiter;
      end;
      if (col = 17) then
      begin
        res := floattostr(actions[sort[l]].swap);
        goto weiter;
      end;
      if (col = 18) then
      begin
        res := floattostr(actions[sort[l]].profit);
        goto weiter;
      end;
      if (col = 19) then
      begin
        res := FormatFloat(',#0.00', actions[sort[l]].volume / 100);
        goto weiter;
      end;
      if (col = 20) then
      begin
        res := inttostr(actions[sort[l]].precision);
        goto weiter;
      end;
      if (col = 21) then
      begin
        res := floattostr(actions[sort[l]].conversionRate0);
        goto weiter;
      end;
      if (col = 22) then
      begin
        res := floattostr(actions[sort[l]].conversionRate0);
        goto weiter;
      end;
      if (col = 23) then
      begin
        res := floattostr(actions[sort[l]].marginRate);
        goto weiter;
      end;
    weiter:
      // pr�fen auf �bereinstimmung
      res := uppercase(res);

      if suchtyp = 0 then
      begin
        if (leftstr(res, suchlength) = such) then
        // Treffer
        begin
          if (doCount = false) then
          begin
            result := l;
            sel[sort[l]] := 1; // den Treffer selektieren
            break;
          end
          else
            Inc(Count);
          sel[sort[l]] := 1
        end;
      end;

      if suchtyp = 1 then
      begin
        if (pos(such, res) > 0) then
        begin
          if (doCount = false) then
          begin
            result := l;
            sel[sort[l]] := 1; // den Treffer selektieren
            break;
          end
          else
            Inc(Count);
          sel[sort[l]] := 1; // den Treffer selektieren
        end;
      end;

    end;
    if (doCount = false) then
      if result > -1 then
        break;

  end;
  if ((doCount = false) and (result = -1)) or ((doCount = true) and (Count = 0)) then
    PlaySound('APPGPFAULT', 0, SND_ASYNC);
  if (doCount = true) then
    result := Count;

  // SYSTEMEXCLAMATION (Hinweis)
  // SYSTEMHAND (Kritischer Abbruch)
  // SYSTEMQUESTION (Frage)
  // SYSTEMSTART (Windows-Start)
  // SYSTEMEXIT (Windows-Shutdown)
  // SYSTEMASTERIX (Stern)
  // RESTOREUP (Vergr��ern)
  // RESTOREDOWN (Verkleinern)
  // MENUCOMMAND (Men�befehl)
  // MENUPOPUP (Pop-Up)
  // MAXIMIZE (Maximieren)
  // MINIMIZE (Minimieren)
  // MAILBEEP (Neue Mail)
  // OPEN (Programm �ffnen)
  // CLOSE (Programm schlie�en)
  // APPGPFAULT (Programmfehler)
end;

function findUserparameter(var SG: TStringGridSorted; var SGFieldCol: DAInteger; var sort: intArray; var sel: byteArray; var users: DAcwUser; k: integer; col: integer; such: string; doCount: Boolean = false): integer;
var
  suchlength: integer;
  len: integer;
  von, bis: integer;
  l, M: integer;
  res: string;
  suchtyp: integer;
  Count: integer;
label weiter;
// ganz schlecht �ber eine Spalte �ber den Index zu suchen ...

begin
  Count := 0;
  suchtyp := 0; // normal ab Anfang
  such := uppercase(such);
  if leftstr(such, 1) = '*' then
  begin
    suchtyp := 1;
    such := midstr(such, 2, length(such) - 1);
  end;
  len := length(sort);
  result := -1;
  suchlength := length(such);
  res := '';
  for M := 0 to 1 do
  begin
    if M = 0 then
    begin
      von := k;
      bis := len;
    end;
    if M = 1 then
    begin
      von := 0;
      bis := k;
    end;
    for l := von to bis do
    begin

      if (col = 0) then
      begin
        res := inttostr(users[sort[l]].userId) + ' ' + inttostr(l);
        goto weiter;
      end;

      if (col = 1) then
      begin
        res := inttostr(users[sort[l]].accountId);
        goto weiter;
      end;
      if (col = 2) then
      begin
        res := users[sort[l]].name;
        goto weiter;
      end;
      if (col = 3) then
      begin
        res := users[sort[l]].group;
        goto weiter;
      end;
      if (col = 5) then
      begin
        res := DateTimeToStr(UnixToDateTime(users[sort[l]].registrationTime));
        goto weiter;
      end;
      if (col = 6) then
      begin
        res := DateTimeToStr(UnixToDateTime(users[sort[l]].lastLoginTime));
        goto weiter;
      end;
      if (col = 22) then
      begin
        res := users[sort[l]].comment;
        goto weiter;
      end;

    weiter:
      // pr�fen
      res := uppercase(res);

      if suchtyp = 0 then
      begin
        if (leftstr(res, suchlength) = such) then
        begin
          if (doCount = false) then
          begin
            result := l;
            sel[sort[l]] := 1; // den Treffer selektieren
            break;
          end
          else
            Inc(Count);
          sel[sort[l]] := 1; // den Treffer selektieren
        end;
      end;

      if suchtyp = 1 then
      begin
        if (pos(such, res) > 0) then
        begin
          if (doCount = false) then
          begin
            result := l;
            sel[sort[l]] := 1; // den Treffer selektieren
            break;
          end
          else
            Inc(Count);
          sel[sort[l]] := 1; // den Treffer selektieren
        end;
      end;

    end;
    if result > -1 then
      break;

  end;
  // PlaySound('SYSTEMEXCLAMATION', 0, SND_ASYNC);
  if ((doCount = false) and (result = -1)) or ((doCount = true) and (Count = 0)) then
    PlaySound('APPGPFAULT', 0, SND_ASYNC);
  if (doCount = true) then
    result := Count;

end;

function BinSearchString2(var Strings: StringArray; var Index: intArray; var v: integer): integer;
// spezielle schnellere Variante die nach 45678 in abcde=45678 sucht und den Index liefert
// ich nehme zwei Arrays : eines ist 12345=45678 und eines nur 45678 damit man die strtoint-Berechnung des =45678 spart
// ??? eigentlich Quatsch das Strings wird ja gar nicht mehr ben�tigt - erst sp�ter beim Aufrufer wird das ausgewertet
var
  first: integer;
  Last: integer;
  Pivot: integer;
  found: Boolean;
  substr: string;
  ps: string;
  p: integer;
  pi: integer;
begin
  // inttostr ist halb so schnell wie strtoint
  first := Low(Strings); // Sets the first item of the range
  Last := High(Strings); // Sets the last item of the range
  found := false; // Initializes the Found flag (Not found yet)
  result := -1; // Initializes the Result
  // substr := inttostr(v);
  // If First > Last then the searched item doesn't exist
  // If the item is found the loop will stop
  while (first <= Last) and (not found) do
  begin
    // Gets the middle of the selected range
    Pivot := (first + Last) div 2;
    // Compares the String in the middle with the searched one
    // p := pos('$', Strings[Pivot]);
    // ps := leftstr(Strings[Pivot], p - 1);
    // pi := strtoint(ps);
    if index[Pivot] = v then
    // if ps = substr then
    begin
      found := true;
      result := Pivot;
    end
    // If the Item in the middle has a bigger value than
    // the searched item, then select the first half
    else if index[Pivot] > v then
      Last := Pivot - 1
      // else select the second half
    else
      first := Pivot + 1;
  end;
end;

function BinSearchStringGleich(var Strings: StringArray; var v: integer): integer;
var
  // sucht Zahl in einem String der Form zahl=andereZahl
  // gibt den Index zur�ck und von der aufrufenden Stelle wird dann andereZahl verwendet
  // spezielle Variante die nach 12345 in 12345=45678 sucht und den Index des Treffers liefert
  // ist etwas langsam weil st�ndig der String nach = aufgetrennt werden muss
  first: integer;
  Last: integer;
  Pivot: integer;
  found: Boolean;
  substr: string;
  ps: string;
  p: integer;
  pi: integer;
begin
  // inttostr ist halb so schnell wie strtoint
  first := Low(Strings); // Sets the first item of the range
  Last := High(Strings); // Sets the last item of the range
  found := false; // Initializes the Found flag (Not found yet)
  result := -1; // Initializes the Result
  // substr := inttostr(v);
  // If First > Last then the searched item doesn't exist
  // If the item is found the loop will stop
  while (first <= Last) and (not found) do
  begin
    // Gets the middle of the selected range
    Pivot := (first + Last) div 2;
    // Compares the String in the middle with the searched one
    p := pos('$', Strings[Pivot]);
    ps := leftstr(Strings[Pivot], p - 1);
    pi := strtoint(ps);
    if pi = v then
    // if ps = substr then
    begin
      found := true;
      result := Pivot;
    end
    // If the Item in the middle has a bigger value than
    // the searched item, then select the first half
    else if pi > v then
      Last := Pivot - 1
      // else select the second half
    else
      first := Pivot + 1;
  end;
end;

function BinSearchStringGleich2(var Strings: StringArray; var v: string): integer;
var
  // sucht Zahl in einem String der Form zahl=andereZahl
  // gibt den Index zur�ck und von der aufrufenden Stelle wird dann andereZahl verwendet
  // spezielle Variante die nach 12345 in 12345=45678 sucht und den Index des Treffers liefert
  // ist etwas langsam weil st�ndig der String nach = aufgetrennt werden muss
  first: integer;
  Last: integer;
  Pivot: integer;
  found: Boolean;
  substr: string;
  ps: string;
  p: integer;
begin
  // inttostr ist halb so schnell wie strtoint
  first := Low(Strings); // Sets the first item of the range
  Last := High(Strings); // Sets the last item of the range
  found := false; // Initializes the Found flag (Not found yet)
  result := -1; // Initializes the Result
  // substr := inttostr(v);
  // If First > Last then the searched item doesn't exist
  // If the item is found the loop will stop
  while (first <= Last) and (not found) do
  begin
    // Gets the middle of the selected range
    Pivot := (first + Last) div 2;
    // Compares the String in the middle with the searched one
    p := pos('$', Strings[Pivot]);
    ps := leftstr(Strings[Pivot], p - 1);
    if ps = v then
    // if ps = substr then
    begin
      found := true;
      result := Pivot;
    end
    // If the Item in the middle has a bigger value than
    // the searched item, then select the first half
    else if ps > v then
      Last := Pivot - 1
      // else select the second half
    else
      first := Pivot + 1;
  end;
end;

function BinSearchString(var Strings: StringArray; var v: string): integer;
var
  first: integer;
  Last: integer;
  Pivot: integer;
  found: Boolean;
  substr: string;
  ps: string;
  p: integer;
  pi: integer;
begin
  // inttostr ist halb so schnell wie strtoint
  first := Low(Strings); // Sets the first item of the range
  Last := High(Strings); // Sets the last item of the range
  found := false; // Initializes the Found flag (Not found yet)
  result := -1; // Initializes the Result
  // substr := inttostr(v);
  // If First > Last then the searched item doesn't exist
  // If the item is found the loop will stop
  while (first <= Last) and (not found) do
  begin
    Pivot := (first + Last) div 2;
    if Strings[Pivot] = v then
    // if ps = substr then
    begin
      found := true;
      result := Pivot;
    end
    // If the Item in the middle has a bigger value than
    // the searched item, then select the first half
    else if Strings[Pivot] > v then
      Last := Pivot - 1
      // else select the second half
    else
      first := Pivot + 1;
  end;
end;

function BinSearchInt(var Ints: intArray; v: integer): integer;
var
  first: integer;
  Last: integer;
  Pivot: integer;
  found: Boolean;
begin
  first := Low(Ints); // Sets the first item of the range
  Last := High(Ints); // Sets the last item of the range
  found := false; // Initializes the Found flag (Not found yet)
  result := -1; // Initializes the Result
  while (first <= Last) and (not found) do
  begin
    Pivot := (first + Last) div 2;
    if Ints[Pivot] = v then
    begin
      found := true;
      result := Pivot;
    end
    else if Ints[Pivot] > v then
      Last := Pivot - 1
    else
      first := Pivot + 1;
  end;
end;

function BinSearchInt64(var Ints: int64Array; v: int64): integer;
var
  first: integer;
  Last: integer;
  Pivot: integer;
  found: Boolean;
begin
  // sucht Zahl aus einer sortierten Reihe von Zahlen und gibt deren Index zur�ck
  first := Low(Ints); // Sets the first item of the range
  Last := High(Ints); // Sets the last item of the range
  found := false; // Initializes the Found flag (Not found yet)
  result := -1; // Initializes the Result
  while (first <= Last) and (not found) do
  begin
    Pivot := (first + Last) div 2;
    if Ints[Pivot] = v then
    begin
      found := true;
      result := Pivot;
    end
    else if Ints[Pivot] > v then
      Last := Pivot - 1
    else
      first := Pivot + 1;
  end;
end;

function BinSearchOpenActionsInt64(var actions: DACwOpenActions; v: int64): integer;
var
  first: integer;
  Last: integer;
  Pivot: integer;
  found: Boolean;
begin
  first := Low(actions); // Sets the first item of the range
  Last := High(actions); // Sets the last item of the range
  found := false; // Initializes the Found flag (Not found yet)
  result := -1; // Initializes the Result
  while (first <= Last) and (not found) do
  begin
    Pivot := (first + Last) div 2;
    if actions[Pivot].actionId = v then
    begin
      found := true;
      result := Pivot;
    end
    else if actions[Pivot].actionId > v then
      Last := Pivot - 1
    else
      first := Pivot + 1;
  end;
end;

function findUserName(userId: integer): string;
var
  i: integer;
  p: integer;
begin
  // mit BinSearchString statt ca 10000 -> 2736  nicht die Welt aber besser als vorher
  // mit BinSearchString2 sinds: 850  Super:-)
  i := BinSearchString2(cwUsersSortIndex, cwUsersSortIndex2, userId);
  if (i > -1) then
  begin
    p := pos('$', cwUsersSortIndex[i]);
    result := cwUsers[strtoint(midstr(cwUsersSortIndex[i], p + 1, 255))].name;
  end
  else
    result := '?';
end;

function findUserIndex(userId: integer): integer;
var
  i: integer;
  p: integer;
begin
  // statt ca 10000 -> 2736  nicht die Welt aber besser als vorher
  // mit BinsearchString2 sinds: 850  Super:-)
  i := BinSearchString2(cwUsersSortIndex, cwUsersSortIndex2, userId);

  if (i > -1) then
  begin
    p := pos('$', cwUsersSortIndex[i]);
    result := strtoint(midstr(cwUsersSortIndex[i], p + 1, 255));
  end
  else
    result := -1;
end;

function findUserSelectionName(userId: integer): string;
var
  i: integer;
  p: integer;
begin
  // statt ca 10000 -> 2736  nicht die Welt aber besser als vorher
  // mit Binsearch2 sinds: 850  Super:-)
  i := BinSearchString2(cwUsersSelectionSortIndex, cwUsersSelectionSortIndex2, userId);
  if (i > -1) then
  begin
    p := pos('$', cwUsersSelectionSortIndex[i]);
    result := cwUsersSelection[strtoint(midstr(cwUsersSelectionSortIndex[i], p + 1, 255))].name;
  end
  else
    result := '?';
end;

function findUserSelectionIndex(userId: integer): integer;
var
  i: integer;
  p: integer;
begin
  // statt ca 10000 -> 2736  nicht die Welt aber besser als vorher
  // mit BinsearchString2 sinds: 850  Super:-)
  i := BinSearchString2(cwUsersSelectionSortIndex, cwUsersSelectionSortIndex2, userId);
  if (i > -1) then
  begin
    p := pos('$', cwUsersSelectionSortIndex[i]);
    result := strtoint(midstr(cwUsersSelectionSortIndex[i], p + 1, 255));
  end
  else
    result := -1;
end;

procedure computeSymbolGroupValues(var actions: DACwAction; var groups: DACwSymbolGroup; lb: TListBox);
// wird nach dem Einlesen aller Actions aufgerufen und berechnet die Werte OHNE die TradesUsers !
var
  i, j, symbolId, groupId: integer;
  _TradesCount: integer;
  _TradesVolumeTotal: integer;
  _TradesProfitTotal: double;
  _TradesSwapTotal: double;
  sum: double;
begin
  // erstmal alles initialisieren
  _TradesCount := 0;
  _TradesVolumeTotal := 0;
  _TradesProfitTotal := 0;
  _TradesSwapTotal := 0;
  for i := 0 to length(groups) - 1 do
  begin
    // die folgenden sind hier aus den actions berechenbar
    groups[i].TradesCount := 0;
    groups[i].TradesVolumeTotal := 0;
    groups[i].TradesProfitTotal := 0;
    groups[i].TradesSwapTotal := 0;
    // die folgenden Werte sind hier nicht direkt berechenbar
    groups[i].TradesUsers := 0;
    groups[i].sourceNames := '';
    groups[i].sourceIds := '';
    groups[i].groupId := i;

  end;

  // aus den cwSymbols den cwSymbolGroups die sourceNames und sourceIds zuordnen
  for i := 0 to cwSymbolsCt - 1 do
  begin
    j := cwSymbolsPlus[i].groupId;
    groups[j].sourceNames := groups[j].sourceNames + cwSymbols[i].name + ';';
    groups[j].sourceIds := groups[j].sourceIds + inttostr(i) + ';';
  end;

  // das Einordnen der Actions in die groups �ber die groupid die aus der symbolId ermittelt wird
  for i := 0 to length(actions) - 1 do
  begin
    // Balance rauslassen ? Ist aber auch interessant
    symbolId := actions[i].symbolId;
    groupId := cwSymbolsPlus[symbolId].groupId;
    // direkt nach Symbolen(ohne Gruppe) w�re hier symbolId zu verwenden und cwSymbolsCt w�re die Gr��e der 'group'
    Inc(groups[groupId].TradesCount);
    Inc(_TradesCount);
    groups[groupId].TradesVolumeTotal := groups[groupId].TradesVolumeTotal + actions[i].volume;
    _TradesVolumeTotal := _TradesVolumeTotal + actions[i].volume;
    groups[groupId].TradesProfitTotal := groups[groupId].TradesProfitTotal + actions[i].profit;
    groups[groupId].TradesSwapTotal := groups[groupId].TradesSwapTotal + actions[i].swap;
    _TradesProfitTotal := _TradesProfitTotal + actions[i].profit;
    _TradesSwapTotal := _TradesSwapTotal + actions[i].swap;
  end;

  lb.items.clear;
  lb.items.add('Actions:' + #9 + inttostr(length(actions)));
  lb.items.add('SymbolGroups:' + #9 + inttostr(length(groups)));
  lb.items.add('BalanceActions:' + #9 + inttostr(groups[cwSymbolsPlus[0].groupId].TradesCount));
  lb.items.add('BalanceTotal:' + #9 + FormatFloat(',#0.00', groups[cwSymbolsPlus[0].groupId].TradesProfitTotal));
  lb.items.add('Volume total:' + #9 + FormatFloat(',#0', _TradesVolumeTotal / 1. - groups[cwSymbolsPlus[0].groupId].TradesCount));
  lb.items.add('Profit total:' + #9 + FormatFloat(',#0.00', _TradesProfitTotal - groups[cwSymbolsPlus[0].groupId].TradesProfitTotal));
  lb.items.add('Swap total:' + #9 + FormatFloat(',#0.00', _TradesSwapTotal - groups[cwSymbolsPlus[0].groupId].TradesSwapTotal));

end;

function RandomRange(const AFrom, ATo: integer): integer;
begin
  if AFrom > ATo then
    result := Random(AFrom - ATo) + ATo
  else
    result := Random(ATo - AFrom) + AFrom;
end;

function RGB2TColor(const R, G, b: byte): integer;
begin
  // convert hexa-decimal values to RGB
  result := R + G shl 8 + b shl 16;
end;

function SetLayeredWindowAttributes(
  // Handle to the layered window.
  Wnd: hwnd;
  // Pointer to a COLORREF value that specifies the transparency
  // color key to be used when composing the layered window
  crKey: ColorRef;
  // Alpha value used to describe the opacity of the layered window
  Alpha: byte;
  // Specifies an action to take
  // LWA_COLORKEY or LWA_ALPHA
  // This parameter can be one or more of the following values:
  dwFlags: dword): Boolean;

  stdcall; external 'user32.dll';


// procedure TForm57.TrackBar1Change(Sender: TObject);
// // Trackbar.Position must run at range 1-255...
// begin
// SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
// SetLayeredWindowAttributes(Handle, ColorToRGB(FColorKey), TrackBar1.Position, LWA_ALPHA);
// end;

{ ****************************************************************** }

{ To load the SetLayeredWindowAttributes() function dynamically, use this function: }

function MakeWindowTransparent(Wnd: hwnd; nAlpha: integer = 10): Boolean;
type
  TSetLayeredWindowAttributes = function(hwnd: hwnd; crKey: ColorRef; bAlpha: byte; dwFlags: Longint): Longint; stdcall;
const
  // Use crKey as the transparency color.
  LWA_COLORKEY = 1;
  // Use bAlpha to determine the opacity of the layered window..
  LWA_ALPHA = 2;
  WS_EX_LAYERED = $80000;
var
  hUser32: HMODULE;
  SetLayeredWindowAttributes: TSetLayeredWindowAttributes;
  i: integer;
begin
  result := false;
  // Here we import the function from USER32.DLL
  hUser32 := GetModuleHandle('USER32.DLL');
  if hUser32 <> 0 then
  begin
    @SetLayeredWindowAttributes := GetProcAddress(hUser32, 'SetLayeredWindowAttributes');
    // If the import did not succeed, make sure your app can handle it!
    if @SetLayeredWindowAttributes <> nil then
    begin
      // Check the current state of the dialog, and then add the WS_EX_LAYERED attribute
      SetWindowLong(Wnd, GWL_EXSTYLE, GetWindowLong(Wnd, GWL_EXSTYLE) or WS_EX_LAYERED);
      // The SetLayeredWindowAttributes function sets the opacity and
      // transparency color key of a layered window
      SetLayeredWindowAttributes(Wnd, 0, trunc((255 / 100) * (100 - nAlpha)), LWA_ALPHA);
      result := true;
    end;
  end;
end;

procedure showMemory(lb: TListBox);
var
  GMS: TMemoryStatusEx;
begin
  GMS.dwLength := SizeOf(TMemoryStatusEx);
  GlobalMemoryStatusEx(GMS);
  lbAdd(lb, 'used (system):               ' + inttostr(GMS.dwMemoryLoad) + ' %');
  lbAdd(lb, 'physical memory - total:     ' + inttostr(trunc(GMS.ullTotalPhys / 1048576)) + ' MB');
  lbAdd(lb, ' (system)       - available: ' + inttostr(trunc(GMS.ullAvailPhys / 1048576)) + ' MB');
  lbAdd(lb, 'page file       - total:     ' + inttostr(trunc(GMS.ullTotalPageFile / 1048576)) + ' MB');
  lbAdd(lb, '                - available: ' + inttostr(trunc(GMS.ullAvailPageFile / 1048576)) + ' MB');
  lbAdd(lb, 'virtual memory  - total:     ' + inttostr(trunc(GMS.ullTotalVirtual / 1048576)) + ' MB');
  lbAdd(lb, ' (this program) - available: ' + inttostr(trunc(GMS.ullAvailVirtual / 1048576)) + ' MB');

end;

function GetModuleVersion(Instance: THandle; out iMajor, iMinor, iRelease, iBuild: integer): Boolean;
var
  fileInformation: PVSFIXEDFILEINFO;
  verlen: Cardinal;
  rs: TResourceStream;
  M: TMemoryStream;
  resource: HRSRC;
begin
  // You said zero, but you mean "us"
  if Instance = 0 then
    Instance := HInstance;

  // UPDATE: Workaround bug in Delphi if resource doesn't exist
  resource := FindResource(Instance, PWideChar(1), RT_VERSION);
  if resource = 0 then
  begin
    iMajor := 0;
    iMinor := 0;
    iRelease := 0;
    iBuild := 0;
    result := false;
    exit;
  end;

  M := TMemoryStream.Create;
  try
    rs := TResourceStream.CreateFromID(Instance, 1, RT_VERSION);
    try
      M.CopyFrom(rs, rs.Size);
    finally
      rs.Free;
    end;

    M.Position := 0;
    if not VerQueryValue(M.Memory, '\', (* var *) Pointer(fileInformation), (* var *) verlen) then
    begin
      iMajor := 0;
      iMinor := 0;
      iRelease := 0;
      iBuild := 0;
      exit;
    end;

    iMajor := fileInformation.dwFileVersionMS shr 16;
    iMinor := fileInformation.dwFileVersionMS and $FFFF;
    iRelease := fileInformation.dwFileVersionLS shr 16;
    iBuild := fileInformation.dwFileVersionLS and $FFFF;
  finally
    M.Free;
  end;

  result := true;
end;

procedure SetFileCreationTime(const fileName: string; const DateTime: TDateTime);
var
  Handle: THandle;
  SystemTime: TSystemTime;
  FileTime: TFileTime;
begin
  Handle := CreateFile(PChar(fileName), FILE_WRITE_ATTRIBUTES, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if Handle = INVALID_HANDLE_VALUE then
    RaiseLastOSError;
  try
    DateTimeToSystemTime(DateTime, SystemTime);
    if not SystemTimeToFileTime(SystemTime, FileTime) then
      RaiseLastOSError;
    if not SetFileTime(Handle, @FileTime, nil, nil) then
      RaiseLastOSError;
  finally
    CloseHandle(Handle);
  end;
end;

function getSessionKey(var key: string): integer;
var
  HTTP: TOurHttp; // kann get und post
  Url: string;
  body: string;
  tbody: TStringStream;
  tresult: TStringStream;
  res: string;
  ret: integer;
  ansistr: string;
  bytes: byteArray;
  sErr: string;

  //
begin
  result := 0;
  try
    try
      HTTP := TOurHttp.Create();
      Url := 'http://h2827643.stratoserver.net:' + cServerPort + '/login';
      body := TNetEncoding.Base64.Encode('flow_collector') + ':' + TNetEncoding.Base64.Encode('f9#w01*F21b/dQ');
      // body := TNetEncoding.Base64.Encode('pmueller') + ':' + TNetEncoding.Base64.Encode('f9#w01*F21b/dQ');
      // body := TNetEncoding.Base64.Encode('cweisenboehler') + ':' + TNetEncoding.Base64.Encode('f9#w01*F21b/dQ');
      tbody := TStringStream.Create(body);
      tbody.Position := 0;
      tresult := TStringStream.Create();
      HTTP.post(Url, tbody, tresult);
      key := tresult.datastring;
      result := 0; // OK
    except
      key := '';
      result := 1; // Fehler
    end;
  finally
    HTTP.Free;
    tbody.Free;
    tresult.Free;
  end;
  // showmessage('res:' + res);
end;

function TestFilename(fileName: String): Boolean;
var
  i: integer;
begin
  result := fileName <> '';
  for i := 1 to length(fileName) do
    result := result and not(fileName[i] in FileNameForbiddenChars);
end;

function RInstr(const Str: string; const strSuche: string): integer;
// ----------------------------------------------------
var
  i: integer;
  l: integer;
begin
  // Instr von Hinten
  i := 0;
  l := length(strSuche);
  for i := length(Str) downto 1 do
  begin
    if midstr(Str, i, l) = strSuche then
    begin
      break;
    end;
  end;
  result := i;
end;

function findCwactionFromId(id: int64): integer;
var
  k: integer;
begin
  //

  result := -1;

  if (cwActionsSorted = true) then
  begin
    k := BinSearchInt64(cwActionsInt64, id);
    if (k > -1) then
    begin
      result := cwActionsInt[k];
      exit;
    end;
  end;

  // Unsortiert - dann alle durchlaufen ...
  if (cwActionsSorted = false) then
    for k := 0 to length(cwActions) - 1 do
    begin
      if (cwActions[k].actionId = id) then
      begin
        result := k;
        break;
      end;
    end;
end;

function getDateTimeFromString(s: string): TDateTime;
var
  i: integer;
  s2: string;
  pm: integer;
  p, q: integer;
  td: TDateTime;
  iNow: extended; // heute - aber am Samstag und Sonntag ist das immer der Freitag !!
begin

  iNow := int(now);
  if (dayofweek(now) = 7) then // Samstag
    iNow := iNow - 1;
  if (dayofweek(now) = 1) then // Sonntag
    iNow := iNow - 2;

  s := ansiuppercase(s);
  pm := 0;
  if (trystrtoint(s, i) = true) then
  begin
    result := UnixToDateTime(i);
    exit;
  end;
  // bl�d Pos z�hlt ab Index 1 - aber SubString geht ab Index 0
  p := pos('+', s);
  if p > 0 then
  begin
    try
      s2 := s.substring(p);
      pm := strtoint(s2);
      s := s.substring(0, p - 1);
    except
      pm := 0;
      s := s.substring(0, p - 1);
    end;
  end;

  p := pos('-', s);
  if p > 0 then
  begin
    try
      s2 := s.substring(p);
      pm := -strtoint(s2);
      s := s.substring(0, p - 1);
    except
      pm := 0;
      s := s.substring(0, p - 1);
    end;
  end;

  if (s = 'DAY') or (s = 'TODAY') or (s = 'TAG') or (s = 'HEUTE') then
  begin
    result := iNow + pm;
    exit;
  end;

  if (s = 'MORGEN') or (s = 'TOMORROW') then
  begin
    result := iNow + 1 + pm;
    exit;
  end;

  if (s = 'GESTERN') or (s = 'YESTERDAY') then
  begin
    result := iNow - 1 + pm;
    exit;
  end;

  if (s = 'MONTAG') or (s = 'MONDAY') then
  begin
    result := iNow; // Sonntag=1 Mo=2 ... Samstag=7
    while (dayofweek(result) <> 2) do
      result := result - 1;
    result := result + pm;
    exit;
  end;

  if (s = 'WEEK') or (s = 'WEEKSTART') or (s = 'WOCHE') then
  begin
    result := iNow + pm * 7;
    while (dayofweek(result) <> 2) do
      result := result - 1;
    exit;
  end;

  // schwierig hier mit + und - umzugehen
  if (s = 'MONTH') or (s = 'MONTHSTART') or (s = 'MONAT') then
  begin
    result := iNow;
    td := getStartOfMonth(now);
    if pm = 0 then
      result := td;

    if (pm < 0) then
    begin
      for i := 1 to abs(pm) do
      begin
        td := getPreviousMonth(td);
      end;
      result := td;
    end;

    if (pm > 0) then
    begin
      for i := 1 to abs(pm) do
      begin
        td := getNextMonth(td);
      end;
      result := td;
    end;

    exit;
  end;

  if (s = 'YEAR') or (s = 'YEARSTART') or (s = 'JAHR') then
  begin
    td := iNow;
    p := dayoftheyear(td);
    td := td - (p - 1);
    if (pm = 0) then
      result := td;
    // i ist jetzt am 1.1.xx
    if (pm < 0) then
    begin
      for i := 1 to abs(pm) do
      begin
        td := getPreviousYear(td);
      end;
      result := td;
    end;

    if (pm > 0) then
    begin
      for i := 1 to abs(pm) do
      begin
        td := getNextYear(td);
      end;
      result := td;
    end;

    exit;
  end;

end;

function getUnixTimeFromString(s: string): integer;
var
  dt: TDateTime;
begin
  dt := getDateTimeFromString(s);
  result := DateTimeToUnix(dt);
end;

function getNextMonth(dt: TDateTime): TDateTime;
var
  y1, m1, d1: word;
begin
  result := 0;
  DecodeDate(dt, y1, m1, d1);
  // nextMonth
  m1 := m1 + 1;
  if (m1 = 13) then
  begin
    m1 := 1;
    y1 := y1 + 1;
  end;
  result := EncodeDate(y1, m1, 1);
end;

function getPreviousMonth(dt: TDateTime): TDateTime;
var
  y1, m1, d1: word;
begin
  result := 0;
  DecodeDate(dt, y1, m1, d1);
  // nextMonth
  m1 := m1 - 1;
  if (m1 = 0) then
  begin
    m1 := 12;
    y1 := y1 - 1;
  end;
  result := EncodeDate(y1, m1, 1);
end;

function getNextYear(dt: TDateTime): TDateTime;
var
  y1, m1, d1: word;
begin
  result := 0;
  DecodeDate(dt, y1, m1, d1);
  // nextYear
  y1 := y1 + 1;
  result := EncodeDate(y1, 1, 1);
end;

function getPreviousYear(dt: TDateTime): TDateTime;
var
  y1, m1, d1: word;
begin
  result := 0;
  DecodeDate(dt, y1, m1, d1);
  y1 := y1 - 1;
  result := EncodeDate(y1, 1, 1);
end;

function getStartOfMonth(dt: TDateTime): TDateTime;
var
  y1, m1, d1: word;
begin
  result := 0;
  DecodeDate(dt, y1, m1, d1);
  result := EncodeDate(y1, m1, 1);
end;

function Get_File_Size(sFileToExamine: string): integer;
{
  for some reason both methods of finding file size return
  a filesize that is slightly larger than what Windows File
  Explorer reports
}
var
  FileHandle: THandle;
  FileSize: LongWord;
  d1: double;
  i1: int64;
begin
  // a- Get file size
  FileHandle := CreateFile(PChar(sFileToExamine), GENERIC_READ, 0, { exclusive }
    nil, { security }
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  FileSize := GetFileSize(FileHandle, nil);
  // Result     := IntToStr(FileSize);
  result := FileSize;
  CloseHandle(FileHandle);

  // //a- optionally report back in Kbytes
  // if bInKbytes = True then
  // begin
  // if Length(Result) > 3 then
  // begin
  // Insert('.', Result, Length(Result) - 2);
  // d1     := StrToFloat(Result);
  // Result := IntToStr(round(d1)) + 'KB';
  // end
  // else
  // Result := '1KB';
  // end;
end;

procedure lbAdd(lb: TListBox; s: string);
begin
  lb.items.add(timetostr(now) + ':' + s);
end;

procedure saveOpenActionsBuffer(fname: string; ba: byteArray);
// das ist der Cache im API-Format
var
  folder: string;
  fileName: string;
  fstream: TStream;
  l: integer;
  gt, td: Cardinal;
begin
  try
    try
      gt := GetTickCount();
      folder := ExtractFilePath(paramstr(0)) + cCacheFolder;
      createDir(folder);
      fileName := folder + '\' + fname + '.bin';
      fstream := TFileStream.Create(fileName, fmCreate);

      l := length(ba);
      fstream.WriteBuffer(ba[0], l);

    finally
      fstream.Free;
    end;
  except
    l := l;
  end;
  td := GetTickCount - gt;
  lbDebug('Zeit SaveOpenActionsBuffer:' + inttostr(td));
end;

function loadOpenActionsBuffer(fname: string; var ba: byteArray): integer;
var
  folder: string;
  fileName: string;
  fstream: TStream;
  gt: Cardinal;
  FSize: integer;
  ct: integer;
begin
  try
    gt := GetTickCount();
    folder := ExtractFilePath(paramstr(0)) + cCacheFolder;
    createDir(folder);

    fileName := folder + '\' + fname + '.bin';
    if fileexists(fileName) then
    begin
      fstream := TFileStream.Create(fileName, fmOpenRead or fmShareDenyNone);

      ct := fstream.Size;
      SetLength(ba, ct);
      fstream.ReadBuffer(ba[0], ct); // nicht die ganze stream.size !
      result := 1;
    end
    else
    begin
      // showmessage('Die Datei existiert nicht');
      result := 0;
    end;
  finally
    if fileexists(fileName) then
      fstream.Free;
  end;
  lbDebug('Zeit LoadCacheFileCw:' + inttostr(GetTickCount() - gt));
  // p0 := @cwActions[0];

end;

procedure DeleteFiles(APath, AFileSpec: string);
var
  lSearchRec: TSearchRec;
  lPath: string;
begin
  lPath := IncludeTrailingPathDelimiter(APath);

  if FindFirst(lPath + AFileSpec, faAnyFile, lSearchRec) = 0 then
  begin
    try
      repeat
        SysUtils.DeleteFile(lPath + lSearchRec.name);
      until SysUtils.FindNext(lSearchRec) <> 0;
    finally
      SysUtils.FindClose(lSearchRec); // Free resources on successful find
    end;
  end;
end;

procedure writeUserMarkers();
var
  myFile: TextFile;
  text: string;
  i: integer;
begin
  // Try to open the Test.txt file for writing to
  AssignFile(myFile, 'UserMarkers.txt');
  ReWrite(myFile);
  for i := 0 to length(cwUsers) - 1 do
  begin
    // Write a couple of well known words to this file
    if (cwUsersPlus[i].marker <> '') then
      WriteLn(myFile, inttostr(cwUsers[i].userId) + ';' + cwUsersPlus[i].marker);

  end;
  // Close the file
  CloseFile(myFile);

end;

procedure readUserMarkers();

var
  myFile: TextFile;
  text: string;
  p, i: integer;
  id, ix: integer;
  mark: string;
  gt:cardinal;
begin
  // Reopen the file for reading
  if(length(cwusers))=0 then exit;
  gt:=gettickcount;
  if (fileexists('UserMarkers.txt')) then
  begin
    AssignFile(myFile, 'UserMarkers.txt');
    try
      Reset(myFile);

      // Display the file contents
      while not Eof(myFile) do
      begin
        ReadLn(myFile, text);
        // aufsplitten
        p := pos(';', text);
        id := strtoint(text.substring(0, p - 1));
        mark := text.substring(p);
        ix := findUserIndex(id);
        if(ix>-1) then
          cwUsersPlus[ix].marker := mark;
      end;

    finally
      // Close the file for the last time
      try
      CloseFile(myFile);
      finally

      end;
    end;
  end;
  //showmessage(inttostr(gettickcount-gt));
end;

end.
