// +------------------------------------------------------------------+
// |                                    MetaTrader Manager API Sample |
// |                 Copyright © 2001-2005, MetaQuotes Software Corp. |
// |                                         http://www.metaquotes.ru |
// +------------------------------------------------------------------+
unit FTPumping2;

interface

// Etliche Änderungen Neu 6.5.19
// uses Variants
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ManagerAPI, StdCtrls, ExtCtrls, Vcl.Grids, StrUtils, Vcl.ComCtrls, IniFiles, RSChartPanel, RSCharts,
  RSBarCharts, StringGridSorted, Vcl.FileCtrl, Button1, System.generics.collections, Vcl.Buttons, IdHTTP, IdGlobal,
  psAPI, System.zip, Wininet, unit30, csCSV, HTTPApp, IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze;

// nicht verwendet TCharStream
type
  TCharStream = class(TObject)
  private
    FGrowBy: Integer;
    FGrowCount: Integer;
    FString: String;
    FLen: Integer;
    FSize: Integer;

  const
    MIN_GROW = 1024;
    MAX_GROW = 16384;

  protected
    procedure Grow;
    function GetString: String;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Append(Value: Char);
    procedure AddString(s: String);
    property Str: String read GetString;
  end;

  // ---- common settings
const
  BoolStr: Array [Boolean] of AnsiString = ('False', 'True');

  LOGFILE = 'LogFile.log';

  // SERVER = '51.140.185.184:443'; // Server-Standardport 443
  SERVER = '52.57.168.76:443'; // Server-Standardport 443
  MAN_LOGIN = 401; // 11;                         // Manager-Login
  MAN_PASS = 'g1iectd'; // 'Manager11';           // Manager-Passwort

  SERVER1 = 'mt4live-master.lcgmetatrader.com:443'; // 2.Server-LCG
  MAN_LOGIN1 = 138; // // Manager-Login
  MAN_PASS1 = 'password1'; // // Manager-Passwort

  SERVER2 = '94.188.214.6:5443'; // Server-A Active Trades
  MAN_LOGIN2 = 34157; // // Manager-Login
  MAN_PASS2 = 'Q7!23fG'; // // Manager-Passwort

  SERVER3 = '94.188.214.5:1443'; // Server-B Active Trades
  MAN_LOGIN3 = 102806; // // Manager-Login
  MAN_PASS3 = 'Rs75!ss'; // // Manager-Passwort

  SERVER4 = '94.188.214.6:4443'; // Server-C Active Trades
  MAN_LOGIN4 = 311613; // // Manager-Login
  MAN_PASS4 = 'A5ds!ab'; // // Manager-Passwort

  SERVER5 = '94.188.214.6:2443'; // Server-D Active Trades
  MAN_LOGIN5 = 400538; // // Manager-Login
  MAN_PASS5 = 'M63mA6i'; // // Manager-Passwort

  SERVER6 = '94.188.214.5:3443'; // Server-E Active Trades
  MAN_LOGIN6 = 2000137; // // Manager-Login
  MAN_PASS6 = 'UZrpwp'; // // Manager-Passwort



  // ---- our pumping message

  // Symbol Statistik für Auswertung der Historie
type
  holdStat = packed record
    count: Integer;
    profit: double;
  end;

type
  killer = packed record
    a: Integer;
    s: TStr12;
    b: string;
  end;

type
  symStat = packed record
    symbol: TStr12;
    count: Integer;
    plus: Integer;
    minus: Integer;
    sumPlus: double;
    sumMinus: double;
    users: Integer;
    merkuser: Integer;
  end;

type
  PMerkWP = ^TMerkWP;

  TMerkWP = packed record
    symbol: TStr12; // symbol name
    // digits                : integer; // floating point digits
    count: Integer; // symbol counter
    // visible               : integer; // visibility
    // stype                 : integer; // symbol type (symbols group index)
    // point                 : double;  // symbol point=1/pow(10,digits)
    // spread                : integer; // symbol spread
    // spread_balance        : integer; // spread balance
    // direction             : integer; // direction
    // updateflag            : integer; // update flag
    lasttime: time_t; // last tick time     dword
    bid, ask: double; // bid, ask
    // high,low              : double;  // high, low
    // commission            : double;  // commission
    // comm_type             : integer; // commission type
  end;

  TKurs = packed record //
    bid: single; // 4
    ask: single; // 4
    lasttime: time_t; // 8 dword Unix Sekunden seit 1970
  end;

  TTick = packed record // für die Übertragung an den Server
    symbol: TStr12;
    time: Integer; // 4    reicht bis 2030  -  sonst 8 dword Unix Sekunden seit 1970
    bid: double; // 8
    ask: double; // 8
    function getJSON: string;
  end;

  aTTick = array of TTick;
  paTTick = ^aTTick;

  TKursOCHLV = packed Record // Basiskurs ist der BID Kurs Die Spread-Info geht dabei verloren.
    lasttime: time_t;
    open: single;
    close: single;
    high: single;
    low: single;
    volume: Integer;
  end;

  aKursOCHL = array of TKursOCHLV;

const
  fmax = 1000;
  NoSelection: TGridRect = (Left: - 1; Top: - 1; Right: - 1; Bottom: - 1);

var

  dummy1, dummy2: string;
  cwActions: array of cwaction;
  cwSymbols: array of cwsymbol;
  cwUsers: array of cwuser;

  _SERVER: PAnsiChar;
  _MAN_LOGIN: Integer;
  _MAN_PASS: PAnsiChar;

  nextAutoTime: TDateTime;
  autoTime: Boolean;
  autoTimeIndex: Integer;

  saveHistoryInProgress: Boolean;

  saveQuoteHistoryFlag: Integer; // 0=nix 1=schreiben
  saveQuoteHistoryStop: Integer; // 1 um Schleife abzubrechen
  saveQuoteHistoryTotal: Integer; // zum Merken
  saveQuoteHistoryFrom: dword; // erste Zeit
  saveQuoteHistoryTo: dword; // letzte Zeit
  saveUserHistoryFlag: Integer; // 0=nix 1=schreiben
  saveUserHistoryStop: Integer; // 1 um Schleife abzubrechen
  saveUserHistoryTotal: Integer; // zum Merken
  loopAllBrokersStop: Integer;
  loopAllBrokersRunning: Integer;

  sendHistoryCounter: Integer; // wieviele Actions werden an den Server gesendet

  FA: array [0 .. fmax] of file of TKurs; // max 1000 gleichzeitig offene Kursdateien die laufend befüllt werden

  ExtPumpingMsg: UINT;
  msgCounter: array [0 .. 15] of Integer; // zählt die verschiedenen Messagearten
  msgCounterPlus: array [0 .. 15] of Integer; // weitere speziellere Daten
  msgTitle: array [0 .. 15] of AnsiString;

  tradeGrund: array [0 .. 15] of string; // die verschiedenen Orderumstände von Client bis Expert
  filecount: Integer = 2000;
  progStart: Cardinal;

  // das sind die ursprünglich als interessant eingestuften Instrumente
  // eigentlich hinfällig
  merkWpCount: Integer;
  merkWp: array [0 .. 31] of TMerkWP;
  merkWpCt: array [0 .. 31] of Integer;

  TickPuffer1: array of TTick;
  TickPuffer2: array of TTick;
  TickPuffer1Ct: Integer;
  TickPuffer2Ct: Integer;
  TickPuffer1Max: Integer;
  TickPuffer2Max: Integer;
  TickPufferSwitch: Integer; // 1->P1 2->P2
  TickPufferBlockSize: Integer; // 5000
  TickPufferFlushInterval: Integer; // 5000 msec
  TickPufferLastFlushTime: Cardinal;
  TickPufferFehler: Integer;
  TickpufferFehlerRepeatTime: Cardinal; // wann wieder erneut versuchen ?
  // das sind die 'Symbols' - also die aktuellen Symbole. Das sind aber nicht alle die in Actions (alten) vorkommen können
  allWPCount: Integer = 1000;
  allWp: array [0 .. 1000] of TMerkWP;
  allWpCt: array [0 .. 1000] of Integer;
  allWpBackptr: array [0 .. 1000] of Integer;
  allWPGridPtr: array [0 .. 1000] of Integer;

  symbolsDic: TDictionary<String, Integer>; // für das schnellere Suchen nach den Namen
  symbolsDicOK: Boolean = false;

  dummyct: Integer;
  filesClosed: Boolean = true;
  filesOpened: Boolean = false;

  ctDebug: Integer;
  doBidAskGrid: Boolean; // die Kurse
  doTradesGridFlag: Boolean; // die Trades

  serverShort: array [0 .. 10] of string; // Die Kurzbezeichnungen der Broker

  tradesNeu: DTATradeRecord; // array of TTradeRecord;//die beiden Arrays zum Vergleich auf neue bzw entfallene Orders
  tradesOld: DTATradeRecord; // array of TTradeRecord;
  tradesCache: DTATradeRecord;
  tradesCacheSelection: DTATradeRecord;
  tradesNeuCt: Integer;
  tradesOldCt: Integer;
  tradesCacheCt: Integer;
  tradesCacheSelectionCt: Integer;

  chartFileKurse: Array of TKurs;
  chartOHLCKurse: aKursOCHL; // Array of TKursOCHL;

  noLogFile: Boolean;

  willConnectPump: Boolean;
  willPumping: Boolean;
  workTicks: Boolean;
  workTrades: Boolean;
  workOpenOrders: Boolean;
  workDirect: Boolean;
  userHistorySendDatabase: Boolean;
  userHistoryToFile: Boolean;
  ticksToServer: Boolean;

  isConnectPump: Boolean;
  isPumping: Boolean;
  // isBidAsk:Boolean;
  // isTrades:Boolean;
  isConnectDirect: Boolean;

  formClosing: Boolean;

  lsRatioChanged: Boolean;
  lsRatioSymbols: String;
  lsRatioCount: Integer;

  SGFieldCol: array of Integer;
  SGColField: array of Integer;
  //

  // +------------------------------------------------------------------+
  // | Form type    sdfg                                                    |
  // +------------------------------------------------------------------+

type
  // das ist wohl ein Trick wie man nichts umbenennen muss, wenn man eine neue Klasse von einer anderen Klasse ableitet.
  // Es bleibt hier beim Namen TStringGridSorted
  TStringGridSorted = class(StringGridSorted.TStringGridSorted)
    procedure WndProc(var Msg: TMessage); override;
  end;

function StringListSortComparefnUp(List: TStringList; Index1, Index2: Integer): Integer;
function StringListSortComparefnDown(List: TStringList; Index1, Index2: Integer): Integer;
function myStringToFloat(s: String): double;
function CurrentProcessMemory: Cardinal;
function GetUrlContent(const Url: string): string;
procedure FillCharArray(var a: TStr12; const s: String);
procedure SwapRowField(rf: array of Integer; fr: array of Integer; von, nach: Integer);
function cwpos(const s: string; c: Char): Integer;
function WideStringToString(const Source: UnicodeString; CodePage: UINT): RawByteString;
procedure generateMinutes(var ticks: array of TKurs; var mBars: aKursOCHL; minutes: Integer);
procedure ParseDelimited(const sl : TListBox; const value : string; const delimiter : string) ;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    lbUsers: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    cbQuotesHistoryInterval: TComboBox;
    btnChartRequest: TButton;
    btnTickRequest: TButton;
    timage: TTimer;
    Panel3: TPanel;
    ComboBox2: TComboBox;
    Panel4: TPanel;
    LbDebug: TListBox;
    lbStatisticsWP: TListBox;
    Panel5: TPanel;
    lbStatisticsPump: TListBox;
    lbStatistics: TListBox;
    ListBox6: TListBox;
    cbQuotesHistorySymbol: TComboBox;
    RSChartPanel4: TRSChartPanel;
    edQuotesHistorySeek: TEdit;
    Label2: TLabel;
    ListBox7: TListBox;
    Label3: TLabel;
    Label4: TLabel;
    Panel6: TPanel;
    chkWorkTicks: TCheckBox;
    chkShowBidAsk: TCheckBox;
    chkShowSymbols: TCheckBox;
    chkShowTrades: TCheckBox;
    Labelm1: TLabel;
    Labelm2: TLabel;
    Label5: TLabel;
    Panel7: TPanel;
    btnStopPump: TButton;
    btnStartPump: TButton;
    btnStopTimer: TButton;
    btnStopAll: TButton;
    btnStartAll: TButton;
    btnStatistics: TButton;
    Panel8: TPanel;
    SG4: TStringGridSorted;
    SG: TStringGridSorted;
    SG3: TStringGridSorted;
    Panel9: TPanel;
    btnRefreshOpenOrders: TButton;
    lblSG3: TLabel;
    TabSheet6: TTabSheet;
    Panel10: TPanel;
    Panel11: TPanel;
    SG6: TStringGridSorted;
    RSChartPanel1: TRSChartPanel;
    chart: TRSCandleStickChart;
    LChart: TRSLineChart;
    Timer2: TTimer;
    Label1: TLabel;
    Panel12: TPanel;
    btnRefreshQuoteGrid: TButton;
    btnStopQuoteGridUpdate: TButton;
    Panel13: TPanel;
    FileListBox1: TFileListBox;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    btnReadQuotesFile: TButton;
    chkShowNoLogfile: TCheckBox;
    chkWorkTrades: TCheckBox;
    chkWorkDirect: TCheckBox;
    Label6: TLabel;
    cbQuotesHistoryMode: TComboBox;
    Label7: TLabel;
    btnQuotesHistorySave: TButton;
    ListBox8: TListBox;
    btnQuotesHistorySaveAll: TButton;
    btnQuotesHistorySaveStop: TButton;
    Label8: TLabel;
    chkShowStatistics: TCheckBox;
    Panel14: TPanel;
    btnRequestUsers: TButton;
    btnGetUserHistory: TButton;
    edHistoryUserId: TEdit;
    btnSaveUserHistory: TButton;
    btnSaveAllUserHistory: TButton;
    btnStopSaveUserHistory: TButton;
    Label9: TLabel;
    ListBox9: TListBox;
    TabSheet7: TTabSheet;
    Panel15: TPanel;
    Panel16: TPanel;
    SG8: TStringGridSorted;
    Button1: TButton;
    Button2: TButton;
    ListBox81: TListBox;
    Button3: TButton;
    ComboBox1: TComboBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Panel17: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    SG9: TStringGridSorted;
    Label12: TLabel;
    RadioButton3: TRadioButton;
    CheckBox9: TCheckBox;
    Panel18: TPanel;
    SG2: TStringGridSorted;
    SG10: TStringGridSorted;
    SG7: TStringGridSorted;
    Panel19: TPanel;
    bitBtn2: TSpeedButton;
    bitBtn3: TSpeedButton;
    bitBtn4: TSpeedButton;
    bitBtn5: TSpeedButton;
    bitBtn6: TSpeedButton;
    BitBtn0: TSpeedButton;
    TabSheet8: TTabSheet;
    Panel20: TPanel;
    Panel21: TPanel;
    SG11: TStringGridSorted;
    SG12: TStringGridSorted;
    btnReadInOutFile: TButton;
    Panel22: TPanel;
    lbLSRatio: TListBox;
    edLSRatio: TEdit;
    Button4: TButton;
    Timer3: TTimer;
    TabSheet9: TTabSheet;
    Panel24: TPanel;
    chkUserHistorySendDatabase: TCheckBox;
    Panel23: TPanel;
    lblHTTP: TLabel;
    edHTTPAddress: TEdit;
    mHTTP: TMemo;
    Button6: TButton;
    Button8: TButton;
    mJSON: TMemo;
    Button9: TButton;
    Button10: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    chkUserHistoryShowJSON: TCheckBox;
    chkUserHistoryToFile: TCheckBox;
    edHistoryDateFrom: TEdit;
    edHistoryDateTo: TEdit;
    chkUserHistoryToCache: TCheckBox;
    SGCacheSearch: TStringGridSorted;
    Button14: TButton;
    Panel25: TPanel;
    btnShowCache: TButton;
    btnClearCache: TButton;
    btnClearGrid: TButton;
    btnSaveCacheFile: TButton;
    btnLoadCacheFile: TButton;
    btnSelectPlus: TButton;
    lbSelectTime: TLabel;
    Label13: TLabel;
    edCacheSearchUserId: TEdit;
    Label14: TLabel;
    edCacheSearchSymbol: TEdit;
    Label15: TLabel;
    edCacheSearchValueFrom: TEdit;
    edCacheSearchValueTo: TEdit;
    Label16: TLabel;
    edCacheSearchTimeFrom: TEdit;
    edCacheSearchTimeTo: TEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    bntOpenTradesToCache: TButton;
    lbCacheSearchSelected: TLabel;
    Label17: TLabel;
    ComboBox3: TComboBox;
    btnClearPlus: TButton;
    Label18: TLabel;
    edCacheSearchComment: TEdit;
    btnDblRemove: TButton;
    btnDblCheck: TButton;
    bitBtn1: TSpeedButton;
    Button7: TButton;
    chkAutoTime: TCheckBox;
    comAutoTime: TComboBox;
    Label19: TLabel;
    lblServer: TLabel;
    lbHTTP: TListBox;
    Button19: TButton;
    btnCheckDoubles: TButton;
    btnGetOnline: TButton;
    lblOnlineRequest: TLabel;
    btnOnlineRecordGet: TButton;
    edOnlineRecordGet: TEdit;
    btnGetMemory: TButton;
    lblMemory: TLabel;
    lbDebug3: TListBox;
    Button21: TButton;
    btnExtractZIP: TButton;
    btnZipFile: TButton;
    cbCacheFileName: TComboBox;
    TabSheet10: TTabSheet;
    Panel26: TPanel;
    btnGetUrlTest: TButton;
    edGetUrl: TEdit;
    memGetUrl: TMemo;
    memGetUrl2: TMemo;
    lbDebug2: TListBox;
    Button22: TButton;
    Button23: TButton;
    edMemMB: TEdit;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    edCacheShowMax: TEdit;
    edCacheShowStep: TEdit;
    Label20: TLabel;
    Label21: TLabel;
    Panel27: TPanel;
    SGCache: TStringGridSorted;
    pnlCache: TPanel;
    Button11: TButton;
    Button13: TButton;
    TabSheet11: TTabSheet;
    Panel28: TPanel;
    Button16: TButton;
    edCSVFileName: TEdit;
    Memo1: TMemo;
    btnGetBinActions: TButton;
    Button5: TButton;
    edMinutes: TEdit;
    chkOnlyArray: TCheckBox;
    lblProgramPath: TLabel;
    lblKursZahl: TLabel;
    TabSheet12: TTabSheet;
    Panel29: TPanel;
    Panel30: TPanel;
    Panel31: TPanel;
    Panel32: TPanel;
    SGSymbols: TStringGridSorted;
    btnSymbolsGrid: TButton;
    btnSendSymbolsToDatabase: TButton;
    btnSleep20: TButton;
    Button12: TButton;
    edBlockSec: TEdit;
    edLoopAllFrom: TEdit;
    edLoopAllTo: TEdit;
    IdAntiFreeze1: TIdAntiFreeze;
    chkWorkOpenOrders: TCheckBox;
    Button15: TButton;
    chkTicksToServer: TCheckBox;
    edTickPufferBlockSize: TEdit;
    edFlushInterval: TEdit;
    Label22: TLabel;
    edGetUrlCSV: TEdit;
    edGetUrlWIninet: TEdit;

    constructor Construct;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WndProc(var Msg: TMessage); override;

    procedure OnUpdateTrades;
    procedure OnUpdateBidAsk;
    procedure OnUpdateSymbols;
    procedure OnUpdateUsers;
    procedure OnUpdateOnline;
    procedure btnStopAllClick(Sender: TObject);
    procedure StopAll;
    procedure lbStatisticsClick(Sender: TObject);
    procedure lbStatisticsPumpClick(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure initMerkWPs();
    procedure btnStatisticsClick(Sender: TObject);
    procedure saveTicks(si: array of TSymbolInfo; count: Integer);
    function saveTickPufferToFile(pa: paTTick; ct: Integer): Integer;
    procedure doTicksToServer(si: array of TSymbolInfo; count: Integer);

    function sucheSymbolNachCount(c: Integer): AnsiString;
    procedure openAllFiles();
    procedure closeAllFiles();
    procedure writeTicks(si: array of TSymbolInfo; count: Integer);
    procedure btnTickRequestClick(Sender: TObject);
    procedure btnGetUserHistoryClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    function StartPumping(): Integer;
    procedure btnStopTimerClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure btnStopPumpClick(Sender: TObject);
    function StopPumping(): Integer;
    procedure OnStartPumping;
    procedure OnStopPumping;
    procedure btnStartPumpClick(Sender: TObject);
    function startConnection(typ: Integer): Integer;
    function initConnection(var mtyp: IManagerInterface; typInfo: string): Integer;

    procedure btnChartRequestClick(Sender: TObject);
    procedure LbDebugClick(Sender: TObject);
    procedure updateGrid(si: array of TSymbolInfo; count: Integer);
    procedure SGOnDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure lbUsersDblClick(Sender: TObject);
    procedure lbUsersClick(Sender: TObject);
    procedure OnChange(Sender: TObject);
    procedure btnRefreshOpenOrdersClick(Sender: TObject);
    procedure btnStartAllClick(Sender: TObject);
    procedure stopKursGrid();
    procedure doRequestUsers();
    procedure vergleich(var s1: array of TTradeRecord; var s2: array of TTradeRecord; var s1c: longint;
      var s2c: longint);
    procedure timageTimer(Sender: TObject);
    procedure merkOrderInOut(typ: Integer; r: TTradeRecord);
    procedure btnRefreshQuoteGridClick(Sender: TObject);
    procedure readInit();
    procedure saveInit();
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure startAll();
    procedure btnRequestUsersClick(Sender: TObject);
    procedure edQuotesHistorySeekChange(Sender: TObject);
    procedure ListBox7Click(Sender: TObject);
    procedure cbQuotesHistorySymbolClick(Sender: TObject);
    procedure cbQuotesHistoryIntervalClick(Sender: TObject);
    procedure showstate;
    procedure btnDblRemoveClick(Sender: TObject);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure FileListBox1DblClick(Sender: TObject);
    procedure btnReadQuotesFileClick(Sender: TObject);
    procedure SG4Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure doStatistics;
    procedure btnStopQuoteGridUpdateClick(Sender: TObject);
    procedure chkShowNoLogfileClick(Sender: TObject);
    procedure PageControl1Resize(Sender: TObject);
    procedure dosleep(t: Integer);
    procedure chkWorkTicksClick(Sender: TObject);
    procedure chkWorkTradesClick(Sender: TObject);
    procedure chkWorkDirectClick(Sender: TObject);
    procedure cbQuotesHistoryModeChange(Sender: TObject);
    procedure btnQuotesHistorySaveClick(Sender: TObject);
    procedure ListBox8DblClick(Sender: TObject);
    procedure btnQuotesHistorySaveAllClick(Sender: TObject);
    procedure btnQuotesHistorySaveStopClick(Sender: TObject);
    procedure chkShowStatisticsClick(Sender: TObject);
    procedure btnSaveUserHistoryClick(Sender: TObject);
    procedure btnSaveAllUserHistoryClick(Sender: TObject);
    procedure btnStopSaveUserHistoryClick(Sender: TObject);
    function doTradesInfo(trades: pATradeRecord; total: Integer; login: Integer): string;
    procedure ListBox9Click(Sender: TObject);
    procedure csvToStringgridSorted(fname: string; var SG: TStringGridSorted);
    procedure Panel16Resize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure writeUsersStream();
    procedure SG7DblClick(Sender: TObject);
    procedure SG8DblClick(Sender: TObject);
    procedure AutoSizeGrid(Grid: TStringGridSorted);
    procedure BitBtnClick(Sender: TObject);
    procedure btnReadInOutFileClick(Sender: TObject);
    procedure doReadOrdersInOut(fileName: string; SG: TStringGridSorted);
    procedure checkRatioSymbols(s: TStr12);
    procedure edLSRatioChange(Sender: TObject);
    procedure updateLSRatio();
    procedure Button4Click(Sender: TObject);
    procedure bntOpenTradesToDatabaseClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure rightTest();
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure mHTTPClick(Sender: TObject);
    procedure mHTTPDblClick(Sender: TObject);
    procedure btnShowCacheClick(Sender: TObject);
    procedure btnClearCacheClick(Sender: TObject);
    procedure btnSelectPlusClick(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure btnClearGridClick(Sender: TObject);
    procedure btnSaveCacheFileClick(Sender: TObject);
    procedure btnLoadCacheFileClick(Sender: TObject);
    procedure saveCacheFile();
    procedure loadCacheFile();
    procedure ClearStringGridSorted(const Grid: TStringGridSorted);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure DateTimePicker2Change(Sender: TObject);
    procedure edCacheSearchTimeFromExit(Sender: TObject);
    procedure bntOpenTradesToCacheClick(Sender: TObject);
    procedure btnClearPlusClick(Sender: TObject);
    procedure edCacheSearchTimeToExit(Sender: TObject);
    procedure btnDblCheckClick(Sender: TObject);
    procedure chkAutoTimeClick(Sender: TObject);
    procedure getNextAutoTime;
    procedure performAutoTime;
    procedure OpenTradesToDataBaseUser(login: Integer);
    procedure selectServer(serverTyp: Integer);
    procedure comAutoTimeChange(Sender: TObject);
    procedure chkUserHistorySendDatabaseClick(Sender: TObject);
    procedure chkUserHistoryToFileClick(Sender: TObject);
    procedure lbHTTPClick(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure btnCheckDoublesClick(Sender: TObject);
    procedure ListBox6Click(Sender: TObject);
    procedure btnGetOnlineClick(Sender: TObject);
    procedure btnOnlineRecordGetClick(Sender: TObject);
    procedure btnGetMemoryClick(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure btnExtractZIPClick(Sender: TObject);
    procedure btnZipFileClick(Sender: TObject);
    function zipFile(ArchiveName, fileName: String): Boolean;
    function UnZipFile(ArchiveName, Path: String): Boolean;
    procedure btnGetUrlTestClick(Sender: TObject);
    procedure lbDebug3Click(Sender: TObject);
    procedure testInt;
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure doCacheGridInfo;
    procedure SGCacheColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure Button11Click(Sender: TObject);
    // die evtl etwas allgemeineren Routinen
    procedure doHistoryGrid(SG2: TStringGridSorted; quotes: PARateInfo; total: Integer);
    procedure doUsersGrid(SG2: TStringGridSorted; users: pAUserRecord; total: Integer);
    procedure doSymbolsGrid(SG2: TStringGridSorted; symbols: PAConSymbol; total: Integer);
    procedure doKursrecordGrid(SG2: TStringGridSorted; var Kurse: array of TKurs; total: Integer);
    procedure doHistoryChart(chart: TRSCandleStickChart; quotes: PARateInfo; total: Integer);
    procedure doKursChart(chart: TRSLineChart; var Kurse: array of TKurs; total: Integer);
    procedure doTradesGrid(SG: TStringGridSorted; trades: pATradeRecord; ct: Integer; total: Integer; stp: Integer = 1);
    procedure doKursGrid();
    function doHTTPPut(sJSON: string; Url: string): Integer;
    function doHTTPGetBA(Url: string): byteArray;
    function pTradesArrayToJSON(pTR: pATradeRecord; von: Integer; bis: Integer; login: Integer): string;
    function SymbolsToJSON(von, bis: Integer): string;

    function OrderTypes(cmd: Integer): string;
    function UnixToDateTime(UnixTime: dword): TDateTime;
    procedure debug(s: AnsiString);
    function DateTimeToUnix(TD: TDateTime): time_t;
    procedure SortStringGrid(var GenStrGrid: TStringGridSorted; ThatCol: Integer; sortTyp: Integer);
    procedure SortStringGridCW(var GenStrGrid: TStringGridSorted; ThatCol: Integer; sortTyp: Integer);
    procedure SGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SGMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    function WriteLog(LogString: String): Integer;
    procedure SGCacheDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure Button13Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure btnGetBinActionsClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure btnSymbolsGridClick(Sender: TObject);
    procedure btnSendSymbolsToDatabaseClick(Sender: TObject);
    procedure btnSleep20Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure chkWorkOpenOrdersClick(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure chkTicksToServerClick(Sender: TObject);
    procedure edTickPufferBlockSizeChange(Sender: TObject);
    procedure edFlushIntervalChange(Sender: TObject);

  private
    // ---- members
    factory: TManagerFactory; // manager factory
    manapi: IManagerInterface; // manager interface
    manapi2: IManagerInterface; // manager interface
    pOpenTradesArray: pATradeRecord; // trades array pumping
    totalOpenTrades: Integer; // total trades

    tradesUser: pATradeRecord; // trades array pumping
    totalTradesUser: Integer; // trades array pumping
    pUsersArray: pAUserRecord;
    usersTotal: Integer;
    symbols: PAConSymbol; // CW Symbole
    symbolsTotal: Integer;
    symbolsStatistic: array of symStat;
    symbolsStatisticCount: Integer;
    // die Symbole in den alten Trades können deutlich mehr sein als die aktuellen Symbole
    symbolsStatisticReserved: Integer; // Array wird größer vorbelegt um ständige setLength um 1 mehr zu vermeiden
    holdStatistic: array [0 .. 11, 0 .. 2] of holdStat;
    holdTypes: array [0 .. 12] of string;
    symbolsSummary: PASymbolSummary;
    symbolsSummaryTotal: Integer;
    writtenTicks: Integer;
    pai: PARateInfo; // Minutencharts per API
    tci: TChartInfo;
    serverTyp: Integer; // 0=nix 1=LCG 2=ActiveTradesA usw
    broker: array [1 .. 7] of Integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
// +------------------------------------------------------------------+
// | Constructor                                                      |
// +------------------------------------------------------------------+

function TTick.getJSON: string;

begin
  // die Brokerid wird  mit der order kombiniert zu einer eindeutigen ActionId
  result := '{' + c34 + 'symbol' + c34 + ':' + c34 + symbol + c34 + ',' + c34 + 'time' + c34 + ':' + inttostr(time) +
    ',' + c34 + 'bid' + c34 + ':' + floattosqlstr(bid) + ',' + c34 + 'ask' + c34 + ':' + floattosqlstr(ask) + '}';
end;

procedure TCharStream.Grow;
begin

  // Raise the allocation size the more this is used
  Inc(FGrowCount);
  if (FGrowCount > 10) then
  begin
    FGrowCount := 0;
    // Cap out at max grow
    if (FGrowBy < MAX_GROW) then
      Inc(FGrowBy, FGrowBy);
  end;

  // Calc new size
  Inc(FSize, FGrowBy);

  // Set new length of string
  SetLength(FString, FSize);

end;

procedure TCharStream.AddString(s: string);
var
  ls: Integer;
begin

  // Increment the length
  ls := length(s);


  // Check for growth

  while (FLen + ls > FSize) do
    Grow;

  // Set the string
  move(s[1], FString[FLen + 1], ls * 2);

  FLen := FLen + ls;
end;

procedure TCharStream.Append(Value: Char);
begin

  // Increment the length
  Inc(FLen);

  // Check for growth
  if (FLen > FSize) then
    Grow;

  // Set the char
  FString[FLen] := Value;

end;

function TCharStream.GetString: String;
begin

  // Return the actual string
  result := Copy(FString, 1, FLen);

end;

constructor TCharStream.Create;
begin

  // Inherited
  inherited Create;

  // Starting values
  FLen := 0;
  FGrowCount := 0;
  FGrowBy := MIN_GROW;
  FSize := FGrowBy;
  SetLength(FString, FSize);

end;

destructor TCharStream.Destroy;
begin

  // Clear the string
  SetLength(FString, 0);

  // Inherited
  inherited Destroy;

end;

procedure TStringGridSorted.WndProc(var Msg: TMessage);
var
  v: Integer;
  c: Integer;
begin
  inherited;
  // OldGridProc(Message);
  // der Hi Wert läuft zwischen 0 und 127 vom oben nach unten im Scroller
  // if ((Message.Msg = WM_VSCROLL) or (Message.Msg = WM_HSCROLL) or  (Message.msg = WM_Mousewheel)) then
  if ((Msg.Msg = WM_VSCROLL)) then
  begin

    if Msg.WParamLo = 5 then // 5=SB_THUMBTRACK  Der Thumb wird bewegt
    begin
      v := VisibleRowCount;
      c := RowCount;
      TopRow := trunc(1 + (c - v - 1) / 127 * Msg.WParamHi);
      // bei wenigen mehr als sichtbare Rows springt der Thumb beim Bewegen leider obwohl die Rechnung schon stimmt
      //
      // cells[0,0]:='v:'+inttostr(v)+' c:'+inttostr(c)+' ->tr:'+inttostr(Toprow)+' Hi:'+inttostr(Msg.WParamHi);
    end;
  end;
end;

procedure TForm1.cbQuotesHistoryIntervalClick(Sender: TObject);
begin
  btnChartRequestClick(nil); // Request und je nach   saveQuoteHistoryFlag:=1; auch sichern

end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  // SG2.enabled:=false;//User-Grid ausblenden Neu 6.5.19
  // lbUsers.Items.Clear; // User-Liste leeren
  // usersTotal := 0; // NEU 21.5.19
  serverTyp := ComboBox2.ItemIndex; // 1 bis 7
  selectServer(serverTyp);
end;

procedure TForm1.selectServer(serverTyp: Integer);
begin

  if (serverTyp < 0) then
    exit; // das passiert beim ersten Start durch das Setzen von Flags im Ini-File

  ComboBox2.ItemIndex := serverTyp;

  case serverTyp of
    1:
      BitBtn0.Down := true;
    2:
      bitBtn1.Down := true;
    3:
      bitBtn2.Down := true;
    4:
      bitBtn3.Down := true;
    5:
      bitBtn4.Down := true;
    6:
      bitBtn5.Down := true;
    7:
      bitBtn6.Down := true;
  end;

  Panel8.Caption := serverShort[serverTyp];
  lblServer.Caption := serverShort[serverTyp];

  Timer1.Enabled := false;

  willPumping := false;

  StopAll;

  if serverTyp = 0 then
    exit;

  willPumping := true;
  startAll;

  lbUsers.Items.Clear; // Userliste löschen
  usersTotal := 0; // NEU 21.5.19
  // Grid mit den Trades des Users löschen
  SG2.RowCount := 1;
  SG2.ColCount := 1;
  // die Trade-Vergleichslisten zurücksetzen
  tradesNeuCt := 0;
  tradesOldCt := 0;
end;

procedure TForm1.cbQuotesHistorySymbolClick(Sender: TObject);
begin
  btnChartRequestClick(nil);
end;

procedure TForm1.cbQuotesHistoryModeChange(Sender: TObject);
begin
  // Mode geändert -> neu abrufen
  btnChartRequestClick(nil);
end;

constructor TForm1.Construct;
begin
  // ---- init trades
  Form1.pOpenTradesArray := nil;
  Form1.totalOpenTrades := -1;

  Form1.symbols := nil;
  Form1.symbolsTotal := 0;

  Form1.symbolsSummary := nil;
  Form1.symbolsSummaryTotal := 0;
end;

// +------------------------------------------------------------------+
// | Create                                                           |
// +------------------------------------------------------------------+
procedure TForm1.FormCreate(Sender: TObject);
var
  err, i: Integer;
  kurs: TKurs;

begin

  // showmessage(inttostr(i));

  broker[1] := 1; // LCG A
  broker[2] := 1; // LCG B
  broker[3] := 2; // ActiveTrades A
  broker[4] := 2;
  broker[5] := 2;
  broker[6] := 2;
  broker[7] := 2; // ActiveTrades E

  lblProgramPath.Caption := paramstr(0);
  autoTime := false;

  lsRatioSymbols := edLSRatio.Text + ';';
  lsRatioCount := 0; // Startwert 0 -> es wird gleich eine Start-Ratio berechnet

  // das war eine Planung künftig bestimmte Felder in bestimmten Spalten darzustellen
  SetLength(SGFieldCol, 30);
  SetLength(SGColField, 30);
  for i := 0 to 29 do
  begin
    SGFieldCol[i] := i; // SGFieldCol(FieldNummer)->Row im Grid des Fields
    SGColField[i] := i; // SGColField(Row)->gesuchtes Feld der Spalte Row
  end;

  holdTypes[1] := '15sec';
  holdTypes[2] := '1Min';
  holdTypes[3] := '5Min';
  holdTypes[4] := '20Min';
  holdTypes[5] := '1Hr';
  holdTypes[6] := '5Hrs';
  holdTypes[7] := '1Day';
  holdTypes[8] := '5Days';
  holdTypes[9] := '30Days';
  holdTypes[10] := '100Days';
  holdTypes[11] := '>100Days';

  // ---- create factory
  progStart := GetTickCount;
  willConnectPump := true;
  workDirect := true;
  chkWorkDirect.Checked := true;
  willPumping := true;
  workTrades := true;
  chkWorkTicks.Checked := true;
  workTicks := true;
  chkWorkTrades.Checked := true;
  workOpenOrders := true;
  chkWorkOpenOrders.Checked := true;
  ticksToServer := false;
  chkTicksToServer.Checked := true;

  msgTitle[0] := 'PUMP_START_PUMPING'; // = 0;      // pumping started
  msgTitle[1] := 'PUMP_UPDATE_SYMBOLS'; // = 1;      // update symbols
  msgTitle[2] := 'PUMP_UPDATE_GROUPS'; // = 2;      // update groups
  msgTitle[3] := 'PUMP_UPDATE_USERS'; // = 3;      // update users
  msgTitle[4] := 'PUMP_UPDATE_ONLINE'; // = 4;      // update online users
  msgTitle[5] := 'PUMP_UPDATE_BIDASK'; // = 5;      // update bid/ask
  msgTitle[6] := 'PUMP_UPDATE_NEWS'; // = 6;      // update news
  msgTitle[7] := 'PUMP_UPDATE_NEWS_BODY'; // = 7;      // update news body
  msgTitle[8] := 'PUMP_UPDATE_MAIL'; // = 8;      // update news
  msgTitle[9] := 'PUMP_UPDATE_TRADES'; // = 9;       // update trades
  msgTitle[10] := 'PUMP_UPDATE_REQUESTS'; // = 10;     // update trade requests
  msgTitle[11] := 'PUMP_UPDATE_PLUGINS'; // = 11;     // update server plugins
  msgTitle[12] := 'PUMP_UPDATE_ACTIVATION';
  // = 12;     // new order for activation (sl/sp/stopout)
  msgTitle[13] := 'PUMP_UPDATE_MARGINCALL'; // = 13;     // new margin calls
  msgTitle[14] := 'PUMP_STOP_PUMPING'; // = 14;     // pumping stoppd
  msgTitle[15] := 'PUMP_UPDATE_NEWS_NEW'; // = 15     //NEU CW

  for i := 0 to 15 do
    tradeGrund[i] := '?';
  tradeGrund[0] := 'Client';
  tradeGrund[1] := 'Expert';
  tradeGrund[2] := 'Dealer';
  tradeGrund[3] := 'Signal';
  tradeGrund[4] := '??????';
  tradeGrund[5] := 'Mobile';

  factory := TManagerFactory.Create('mtmanapi.dll');
  if factory = nil then
    exit;

  serverShort[0] := '-';
  serverShort[1] := 'LCG';
  serverShort[2] := 'LCG B';
  serverShort[3] := 'ActiveTrades A';
  serverShort[4] := 'ActiveTrades B';
  serverShort[5] := 'ActiveTrades C';
  serverShort[6] := 'ActiveTrades D';
  serverShort[7] := 'ActiveTrades E';

  // startConnections();

  initMerkWPs();

  readInit(); // -> auch ServerTyp

  selectServer(serverTyp);

  getNextAutoTime;


  // gestartet wird über den Timer1

  // ---- add symbols  warum das ??
  // angeblich werden nur diese Symbole dann im Pumping Modus mit Kursen versorgt
  // es geht doch aber auch ohne ???? Oder rühren da die unterschiedlichen Zahlen von versorgten Instrumenten her ?
  // manapi.SymbolAdd('EURUSD');
  chart.Values.Clear;
end;

function TForm1.initConnection(var mtyp: IManagerInterface; typInfo: string): Integer;
// 1=Pumping 2=Direct 3=beide
var
  res: Integer;
  err: Integer;
  serverno: Integer;
begin
  // ---- create manager interface
  serverno := ComboBox2.ItemIndex - 1; // 0=LCG 1=AT
  if serverno = 0 then
  begin
    _SERVER := SERVER;
    _MAN_LOGIN := MAN_LOGIN;
    _MAN_PASS := MAN_PASS;
  end;

  if serverno = 1 then
  begin
    _SERVER := SERVER1;
    _MAN_LOGIN := MAN_LOGIN1;
    _MAN_PASS := MAN_PASS1;
  end;

  if serverno = 2 then
  begin
    _SERVER := SERVER2;
    _MAN_LOGIN := MAN_LOGIN2;
    _MAN_PASS := MAN_PASS2;
  end;

  if serverno = 3 then
  begin
    _SERVER := SERVER3;
    _MAN_LOGIN := MAN_LOGIN3;
    _MAN_PASS := MAN_PASS3;
  end;

  if serverno = 4 then
  begin
    _SERVER := SERVER4;
    _MAN_LOGIN := MAN_LOGIN4;
    _MAN_PASS := MAN_PASS4;
  end;

  if serverno = 5 then
  begin
    _SERVER := SERVER5;
    _MAN_LOGIN := MAN_LOGIN5;
    _MAN_PASS := MAN_PASS5;
  end;

  if serverno = 6 then
  begin
    _SERVER := SERVER6;
    _MAN_LOGIN := MAN_LOGIN6;
    _MAN_PASS := MAN_PASS6;
  end;

  res := 0;
  debug('!CreateAPI ' + typInfo);
  mtyp := factory.CreateAPI;
  if mtyp = nil then
  begin
    debug('!CreateAPI ' + typInfo + ' error');
    res := res + 1;
    result := res;
    exit;
  end;


  // ---- connect to the server

  err := RET_OK;

  if ((serverno = 0) or (serverno = 1)) then
    debug('!Connect LCG')
  else
    debug('!Connect Active Trades');

  err := mtyp.Connect(PAnsiChar(_SERVER));

  if err <> RET_OK then
  begin
    debug(typInfo + ' Unable to connect to server: ' + inttostr(err));
    // +'='+AnsiString( mtyp.ErrorDescription(err)));
    res := res + 2;
    result := res;
    exit;
  end;



  // ---- login

  err := RET_OK;

  err := mtyp.login(_MAN_LOGIN, _MAN_PASS);

  if err <> RET_OK then
  begin
    debug('Login ' + typInfo + ' failed: ' + mtyp.ErrorDescription(err));
    res := res + 4;
    result := res;
    exit;
  end;

end;

function TForm1.startConnection(typ: Integer): Integer;
// 1=Pumping 2=Direct 3=beide
var
  res: Integer;
  err, err2: Integer;
  serverno: Integer;
begin
  // ---- create manager interface
  serverno := ComboBox2.ItemIndex - 1; // 0=LCG 1=AT
  if serverno = 0 then
  begin
    _SERVER := SERVER;
    _MAN_LOGIN := MAN_LOGIN;
    _MAN_PASS := MAN_PASS;
  end;

  if serverno = 1 then
  begin
    _SERVER := SERVER1;
    _MAN_LOGIN := MAN_LOGIN1;
    _MAN_PASS := MAN_PASS1;
  end;

  if serverno = 2 then
  begin
    _SERVER := SERVER2;
    _MAN_LOGIN := MAN_LOGIN2;
    _MAN_PASS := MAN_PASS2;
  end;

  if serverno = 3 then
  begin
    _SERVER := SERVER3;
    _MAN_LOGIN := MAN_LOGIN3;
    _MAN_PASS := MAN_PASS3;
  end;

  if serverno = 4 then
  begin
    _SERVER := SERVER4;
    _MAN_LOGIN := MAN_LOGIN4;
    _MAN_PASS := MAN_PASS4;
  end;

  if serverno = 5 then
  begin
    _SERVER := SERVER5;
    _MAN_LOGIN := MAN_LOGIN5;
    _MAN_PASS := MAN_PASS5;
  end;

  if serverno = 6 then
  begin
    _SERVER := SERVER6;
    _MAN_LOGIN := MAN_LOGIN6;
    _MAN_PASS := MAN_PASS6;
  end;

  if (willConnectPump = true) and ((typ and 1) = 1) then
  begin
    res := 0;
    debug('!CreateAPI 1');
    manapi := factory.CreateAPI;
    if manapi = nil then
    begin
      debug('!CreateAPI 1 error');
      res := res + 1;
      result := res;
      exit;
    end;
  end;

  if (workDirect = true) and ((typ and 2) = 2) then
  begin
    debug('!CreateAPI 2');
    manapi2 := factory.CreateAPI; // das sollte noch problemlos gehen
    if manapi2 = nil then
    begin
      debug('!CreateAPI 2 error');
      res := res + 2;
      result := res;
      exit;
    end;
  end;

  // ---- connect to the server

  err := RET_OK;
  err2 := RET_OK;

  if ((serverno = 0) or (serverno = 1)) then
    debug('!Connect LCG')
  else
    debug('!Connect Active Trades');

  if (willConnectPump = true) and ((typ and 1) = 1) then
    err := manapi.Connect(PAnsiChar(_SERVER));

  if (workDirect = true) and ((typ and 2) = 2) then
    err2 := manapi2.Connect(PAnsiChar(_SERVER));

  if err <> RET_OK then
  begin
    debug('Unable to connect to server (pump): ' + inttostr(err));
    // +'='+AnsiString( manapi.ErrorDescription(err)));
    res := res + 4;
    result := res;
    exit;
  end;

  if err2 <> RET_OK then
  begin
    debug('Unable to connect to server (direct): ' + inttostr(err));
  end;


  // ---- login

  err := RET_OK;
  err2 := RET_OK;

  if (willConnectPump = true) and ((typ and 1) = 1) then
    err := manapi.login(_MAN_LOGIN, _MAN_PASS);

  if (workDirect = true) and ((typ and 2) = 2) then
    err2 := manapi2.login(_MAN_LOGIN, _MAN_PASS);

  if err <> RET_OK then
  begin
    debug('Login failed (pump): ' + manapi.ErrorDescription(err));
    res := res + 8;
    result := res;
    exit;
  end;

  if err2 <> RET_OK then
  begin
    debug('Login failed (direct): ' + manapi.ErrorDescription(err2));
    res := res + 16;
    result := res;
    exit;
  end;

end;

function TForm1.StopPumping(): Integer;
{
  CLIENT_FLAGS_HIDETICKS - do not receive ticks

  CLIENT_FLAGS_HIDENEWS - do not receive news

  CLIENT_FLAGS_HIDEMAIL - do not receive emails

  CLIENT_FLAGS_SENDFULLNEWS - receive news with body. When enabled, the news arrive at the manager application with their bodies (and not only headers). Thus, the news body can be received using the NewsBodyGet method at once without preliminarily requesting it from the server via the NewsBodyRequest method.

  CLIENT_FLAGS_HIDEONLINE - do not receive information about online clients

  CLIENT_FLAGS_HIDEUSERS
}
// Nur manapi soll pumpen
var
  err: Integer;
begin
  // err := manapi.PumpingSwitch(nil,Form1.WindowHandle,ExtPumpingMsg,31);//alle abschalten indem die Flags gesetzt werden
  debug('!StopPumping');
  err := manapi.disconnect(); // Brachialste Methode
  manapi := nil;
  if err <> RET_OK then
  begin
    debug('Pumping disconnect failed: ' + manapi.ErrorDescription(err));
    result := 1;
    exit;
  end
  else
    result := 0;
  // isPumping:=false; nicht hier sondern im Event OnStopPumping

end;

function TForm1.StartPumping(): Integer;
// Pumping immer mit manapi
var
  err: Integer;
  // 0=ok alles andere Fehler
  // API:Returns TRUE if successful, otherwise returns FALSE. Also was jetzt !!!
  // wie kann das seither funktioniert haben ???
  // Die API Bechreibung scheint falsch zu sein. Der Rückgabewert 0 ist OK

  // CLIENT_FLAGS_HIDETICKS = 1; // do not send ticks
  // CLIENT_FLAGS_HIDENEWS = 2; // do not send news
  // CLIENT_FLAGS_HIDEMAIL = 4; // do not send mails
  // CLIENT_FLAGS_SENDFULLNEWS = 8; // send news body with news header in pumping mode
  // CLIENT_FLAGS_RESERVED = 16; // reserved
  // // ---- manager flags
  // CLIENT_FLAGS_HIDEUSERS = 32; // do not send online users

  flags: Integer;
begin
  // ---- switch to the pumping mode
  try
    result := 0;
    flags := 0;
    if (workTicks = false) then
    begin
      flags := flags or CLIENT_FLAGS_HIDETICKS;
      debug('ACHTUNG pumping modus eingeschränkt: keine BidAsk');
    end;
    if (flags > 0) then
      debug('ACHTUNG pumping modus eingeschränkt Flags:' + inttostr(flags));

    err := manapi.PumpingSwitch(nil, Form1.WindowHandle, ExtPumpingMsg, flags);
    if err <> RET_OK then
    begin
      debug('Pumping switch failed: ' + manapi.ErrorDescription(err));
      isPumping := false;
      result := 1;

    end
    else
    begin
      isPumping := true;
      result := 0;
    end;

  except
    result := 2; // Fehler
  end;
end;

// +------------------------------------------------------------------+
// | Destroy                                                          |
// +------------------------------------------------------------------+
procedure TForm1.FormDestroy(Sender: TObject);
begin
  saveInit();
  formClosing := true;

  willPumping := false;
  StopAll;
  if factory <> nil then
    factory.Free;
end;

procedure TForm1.StopAll;
begin
  if manapi <> nil then
  begin
    // ---- do not forget to free trades memory
    if pOpenTradesArray <> nil then
    begin
      manapi.MemFree(pOpenTradesArray);
      pOpenTradesArray := nil;
    end;
    totalOpenTrades := -1;

    if symbols <> nil then
    begin
      manapi.MemFree(symbols);
      symbols := nil; // prüfen
      symbolsTotal := 0;
      manapi.MemFree(symbolsSummary);
      symbolsSummary := nil;
      symbolsSummaryTotal := 0;
    end;
    // ---- disconnect and free manager interface
    manapi.disconnect;
    manapi := nil;
  end;

  if manapi2 <> nil then
  begin
    // ---- do not forget to free trades memory
    if tradesUser <> nil then
    begin
      manapi2.MemFree(tradesUser);
      tradesUser := nil;
      totalTradesUser := 0;
    end;
    // ---- disconnect and free manager interface
    manapi2.disconnect;
    manapi2 := nil;
  end;

  // ---- cleanup winsock and deinit factory
  if factory <> nil then
  begin
    // factory.Free;
  end;
  dosleep(1000);

end;

// +------------------------------------------------------------------+
// | Initialization                                                   |
// +------------------------------------------------------------------+
procedure TForm1.WndProc(var Msg: TMessage);
var
  ct: Integer;
var
  v, c: Integer;
begin
  inherited;


  // if msg.Msg=WM_VSCROLL then
  // begin
  // if msg.WParamLo=5 then   //5=SB_THUMBTRACK  Der Thumb wird bewegt
  // begin
  // v:=SG.VisibleRowCount;
  // c:=SG.RowCount;
  // SG.TopRow:=trunc(1+(c-v-1)/127*msg.WParamHi);
  // end;
  // end;


  // gibt es auch eine Message die die Connection betrifft ?

  // end;

  // After calling PumpingSwitch, the Manager interface will send the following codes as a parameter to the callback function or as WPARAM parameter of a user message:
  //
  // •PUMP_START_PUMPING - the Manager interface has successfully switched to the pumping mode;
  //
  // •PUMP_UPDATE_SYMBOLS - symbol settings have been updated, the updated settings can be obtained using the functions SymbolsGetAll, SymbolGet or SymbolInfoGet;
  //
  // •PUMP_UPDATE_GROUPS - group settings have been updated, the updated settings can be obtained using the functions GroupsGet or GroupRecordGet;
  //
  // •PUMP_UPDATE_USERS - the list of accounts has been updated, the updated list can be obtained using the functions UsersGet or UserRecordGet;
  //
  // •PUMP_UPDATE_ONLINE - the list of online clients has been updated, the updated list of online clients can be obtained using the functions OnlineGet or OnlineRecordGet;
  //
  // •PUMP_UPDATE_BIDASK - a new quote has been received, the received quotes can be obtained using the TickInfoLast function, the last prices can be obtained using one or more calls of the SymbolInfoUpdated function;
  //
  // •PUMP_UPDATE_NEWS - a newsletter has been received, the headers of the received newsletters can be obtained using the functions NewsGet, NewsTotal and NewsTopicGet; the body of a received newsletter can be requested using the NewsBodyRequest function;
  //
  // •PUMP_UPDATE_NEWS_BODY - a news body has been received, the news body can be obtained using the NewsBodyGet function;
  //
  // •PUMP_UPDATE_MAIL - a new email has been received, it has been saved to a disk in the 'mailbox\' folder of the Manager API working directory; the name of the file and the size of the email can be obtained using the MailLast function;
  //
  // •PUMP_UPDATE_TRADES - the list of orders has been updated, the updated list of orders can be obtained using the functions TradesGet (all orders), TradesGetBySymbol (orders of one symbol), TradesGetByLogin (orders of one account), TradesGetByMarket (all orders sorted by distance from the market) and TradeRecordGet (a specific order with the specified ticket). Trade results on symbols and groups of symbols can be obtained using the functions SummaryGetAll, SummaryGet, SummaryGetByCount and SummaryGetByType. Company's exposure on currencies can be obtained using the functions ExposureGet and ExposureValueGet;
  //
  // •PUMP_UPDATE_REQUESTS - the list of trade requests has been updated, the updated list of trade requests can be obtained using the functions RequestsGet and RequestInfoGet;
  //
  // •PUMP_UPDATE_PLUGINS - the list of server plugins has been updated, the updated list of plugins can be obtained using the functions PluginsGet and PluginParamGet;
  //
  // •PUMP_UPDATE_ACTIVATION - the list of orders with triggered Stop Loss or Take Profit levels, pending orders, and the most unprofitable orders for accounts in the stop out state has been updated;
  //
  // •PUMP_UPDATE_MARGINCALL - the list of accounts with the margin call state has been updated, the updated list of account margin requirements can be obtained using MarginsGet and MarginLevelGet;
  //
  // •PUMP_STOP_PUMPING - the pumping mode has been stopped.
  //
  // •PUMP_UPDATE_NEWS_NEW - a newsletter of the new NewsTopicNew format has been received.
  // PUMP_START_PUMPING = 0; // pumping started
  // PUMP_UPDATE_SYMBOLS = 1; // update symbols
  // PUMP_UPDATE_GROUPS = 2; // update groups
  // PUMP_UPDATE_USERS = 3; // update users
  // PUMP_UPDATE_ONLINE = 4; // update online users
  // PUMP_UPDATE_BIDASK = 5; // update bid/ask
  // PUMP_UPDATE_NEWS = 6; // update news
  // PUMP_UPDATE_NEWS_BODY = 7; // update news body
  // PUMP_UPDATE_MAIL = 8; // update news
  // PUMP_UPDATE_TRADES = 9; // update trades
  // PUMP_UPDATE_REQUESTS = 10; // update trade requests
  // PUMP_UPDATE_PLUGINS = 11; // update server plugins
  // PUMP_UPDATE_ACTIVATION = 12; // new order for activation (sl/sp/stopout)
  // PUMP_UPDATE_MARGINCALL = 13; // new margin calls
  // PUMP_STOP_PUMPING = 14; // pumping stopped

  // ---- test for our pumping message
  if Msg.Msg = ExtPumpingMsg then
  begin
    // ---- switch pumping codes
    case Msg.WParam of
      PUMP_START_PUMPING: // pumping started
        begin
          OnStartPumping;
        end;
      PUMP_UPDATE_SYMBOLS: // update symbols - warum passiert das eigentlich mehrfach ?
        begin
          OnUpdateSymbols;
        end;

      PUMP_UPDATE_TRADES: // update trades
        begin
          OnUpdateTrades;
        end;
      PUMP_UPDATE_BIDASK:
        begin
          OnUpdateBidAsk;
        end;
      PUMP_UPDATE_USERS:
        begin
          // noch nicht eingebaut
          OnUpdateUsers;
        end;
      PUMP_UPDATE_ONLINE:
        begin
          // noch nicht eingebaut
          OnUpdateOnline;
        end;

      PUMP_STOP_PUMPING:
        begin
          OnStopPumping;
        end;

      // other PUMP_* codes
    end;
    begin
      if (Msg.WParam < 256) then
      begin
        msgCounter[Msg.WParam] := msgCounter[Msg.WParam] + 1;
      end;
    end;

  end;
end;

// +------------------------------------------------------------------+
// | On update symbols                                                |
// +------------------------------------------------------------------+
procedure TForm1.OnChange(Sender: TObject);
begin
  // User wählt neue Seite / TAB aus

  if PageControl1.ActivePage = TabSheet2 then
  // Users laden
  begin
    if manapi2 = nil then
      exit;
    // nicht sofort sondern warten bis angeklickt , da sonst automatisch
    // zB Daten an die Datenbank oder in den Cache gesendet werden

    // doRequestUsers();

  end;

  if PageControl1.ActivePage = TabSheet3 then
  begin
    if manapi = nil then
      exit;
    doTradesGrid(SG3, pOpenTradesArray, totalOpenTrades, totalOpenTrades);

  end;

end;

procedure TForm1.OnStartPumping;
var
  ret: Boolean;
  pause: Integer;
  ct: Integer;
begin
  debug('StartPumping detected');
  isPumping := true;
  showstate;
end;

procedure TForm1.OnStopPumping;
// Dauerschleife da während disconnect schon wieder ein Stoppumping festgestellt wird
var
  ret: Integer;
  pause: Integer;
  ct: Integer;
begin
  ret := 0;
  pause := 1000;
  ct := 0;
  debug('StopPumping detected');
  isPumping := false;
  showstate;
  Panel8.color := clBlue;

  // button10Click(nil);
  // wenn Auto-Pumping aktiv ist würde sofort wieder gepumpt - daher bei manuellem Abbruch die Checkbox ausschalten
  if (willPumping = false) or (formClosing = true) then
    exit;

  repeat
    dosleep(pause);
    if (manapi = nil) then
    begin
      debug('manapi=nil');
      debug('Starte Timer1 nochmal');
      Timer1.Interval := 1000;
      Timer1.Enabled := true;
    end;
    manapi.Ping;
    if manapi.IsConnected <> 0 then
    begin
      debug('try StartPumping');
      ret := StartPumping();
      pause := 5000; // erstmal nur 1 sec dann alle 5 sec probieren
      ct := ct + 1;
      if ret <> 0 then
      begin
        debug('Err startPumping:' + inttostr(ret));

        debug('Starte Timer1 nochmal');
        Timer1.Interval := 1000;
        Timer1.Enabled := true;

      end;
    end
    else
    begin
      debug('manapi nicht mehr connected');
      debug('Starte Timer1 nochmal');
      Timer1.Interval := 1000;
      Timer1.Enabled := true;
    end;
    // Abbruchbedingung einbauen
    debug('onStop loop');
  until ret = ret;
  showstate;

end;

procedure TForm1.showstate;
begin
  if isPumping = false then
    Panel8.color := clRed
  else
    Panel8.color := clGreen;
end;

procedure TForm1.OnUpdateUsers;
var
  total: Integer;
  ur: pAUserRecord;
begin
  // geht nicht - das Pump-Event erscheint zwar aber es geht nix abzurufen
  // !! GEHT !!  Ich darf nicht manapi2. schreiben sondern manapi. !!
  lbStatisticsPump.Items.Add('UpdateUsers');
  ur := manapi.UsersGet(total); // Implementierung fehlt noch
  if ur <> nil then
  begin
    manapi.MemFree(ur);
    ur := nil; // prüfen
    total := 0;
  end;
end;

procedure TForm1.OnUpdateOnline;
begin
  lbStatisticsPump.Items.Add('UpdateOnline');
  // Implementierung fehlt noch
  btnGetOnlineClick(nil);
end;

procedure TForm1.OnUpdateSymbols;
// nur ein Event das signalisiert daß sich was an den Symbols geändert hat (?)
var
  Str: AnsiString;
  k: Integer;
  // f: Array [0 .. 1000] of integer;
begin
  // ---- free old symbols
  if symbols <> nil then
    manapi.MemFree(symbols);
  // ---- get new symbols
  symbols := manapi.SymbolsGetAll(symbolsTotal);

  // symbolsSummary ist immer leer ??
  if symbolsSummary <> nil then
    manapi.MemFree(symbolsSummary);
  // ---- get new symbols
  symbolsSummary := manapi.SummaryGetAll(symbolsSummaryTotal);

  // ---- add status message
  Str := 'PUMP_UPDATE_SYMBOLS: ' + inttostr(symbolsTotal) + ' total symbols';
  lbStatisticsPump.Items.Add(Str);

  Str := 'SymbolsSummary: ' + inttostr(symbolsSummaryTotal) + ' total Summary symbols';
  lbStatisticsPump.Items.Add(Str);

  // die allWP Symbole zuweisen
  ListBox6.Items.Clear;

  // // F[] ist nur der Zähler wie oft ein .count vorkommt um doppelte festzustellen
  // for k := 0 to 1000 do
  // begin
  // f[k] := 0;
  // end;
  //
  // for k := 0 to symbolsTotal - 1 do
  // begin
  // f[symbols[k].count] := f[symbols[k].count] + 1;
  // end;

  for k := 0 to symbolsTotal - 1 do
  begin
    manapi.SymbolAdd(symbols[k].symbol); // NEU da angeblich notwendig für das Pumping
    allWp[symbols[k].count].symbol := symbols[k].symbol;
    allWpBackptr[symbols[k].count] := k;
    if (chkShowSymbols.Checked = true) then
    begin
      ListBox6.Items.Add(symbols[k].symbol + ' tv:' + floattostr(symbols[k].tick_value) + ' ts:' +
        floattostr(symbols[k].tick_size) + ':' + inttostr((symbols[k].count)));

    end;
  end;

  cbQuotesHistorySymbol.Items.Clear;
  for k := 0 to symbolsTotal - 1 do
  begin
    cbQuotesHistorySymbol.Items.Add(symbols[k].symbol);
  end;
  if symbolsTotal > 0 then
    cbQuotesHistorySymbol.ItemIndex := 0;

  // CHART_RANGE_IN   = 0;  //Data from the range of ChartInfo::from - ChartInfo::to.
  // CHART_RANGE_OUT  = 1;  //Data from the ranges "the beginning of history" - ChartInfo::from and ChartInfo::to - the end of history.
  // CHART_RANGE_LAST = 2;  //Data from the range ChartInfo::from - the end of history.combobox4.Items.Clear;//Mode

  cbQuotesHistoryMode.Items.Clear;
  cbQuotesHistoryMode.Items.Add('1');
  cbQuotesHistoryMode.Items.Add('2');
  cbQuotesHistoryMode.Items.Add('3');
  cbQuotesHistoryMode.Text := '1';

  openAllFiles();

  // doKursGrid; // damit von Anfang an die Zellen gefüllt werden

  // Button12Click(nil); // Chart request
  // ----
  // ---- or manapi.TradeRecordGet by order#
end;

// +------------------------------------------------------------------+
// | On update trades                                                 |
// +------------------------------------------------------------------+
procedure TForm1.OnUpdateTrades;
var
  Str: AnsiString;
  k, i: Integer;
  dataLength: LongWord;
  Stream: TStream;
  fileMode: Integer;
  fileName: AnsiString;
  // trades ist global ein PATradeRecord
begin
  // ---- free old trades
  if (manapi = nil) then
    exit;

  if workOpenOrders = false then
    exit;

  if pOpenTradesArray <> nil then
  begin
    manapi.MemFree(pOpenTradesArray);
    pOpenTradesArray := nil; // prüfen
  end;
  // ---- get new trades
  pOpenTradesArray := manapi.TradesGet(totalOpenTrades); // trades ist ein PATradeRecord
  // ---- add status message
  Str := 'PUMP_UPDATE_TRADES: ' + inttostr(totalOpenTrades) + ' total trades';
  lbStatisticsPump.Items.Add(Str);
  if (chkShowTrades.Checked = true) then
  begin
    for k := 0 to totalOpenTrades - 1 do
    begin
      lbStatistics.Items.Add(inttostr(pOpenTradesArray[k].order) + ':' + inttostr(pOpenTradesArray[k].login) + ' ' +
        pOpenTradesArray[k].symbol);
    end;
  end;

  // hier die Routine verlassen wenn keine Änderungen der Trades an den Server geschickt werden sollen
  if workTrades = false then
    exit;

  begin

    // try
    // // die Trades in die Datei testrecord.bin schreiben. War zum externen Vergleich gedacht
    //
    // fileName := ExtractFilePath(ParamStr(0)) + 'testrecord.bin';
    // // IMMER NEU SCHREIBEN damit hinten auch alles überschrieben wird !
    // fileMode := fmCreate;
    // Stream := TFileStream.Create(fileName, fileMode);
    // dataLength := totalTrades * SizeOf(trades[0]); // Trades.Length;
    // Stream.WriteBuffer(Pointer(trades)^, dataLength); // L * SizeOf(Trades[0]));
    // Stream.Free; // Speicher freigeben
    // except
    // debug('Fehler Datei testrecord erstellen...');
    // end;

    try
      // an dieser Stelle können aber auch direkt die Änderungen festgestellt werden

      // gemerkter Stand neu nach alt kopieren . Dann tradesNeu nach neu. Dann alt und neu vergleichen
      if tradesNeuCt = 0 then
      begin
        SetLength(tradesNeu, 1);
      end;
      tradesOldCt := tradesNeuCt;
      SetLength(tradesOld, tradesOldCt);

      tradesOld := Copy(tradesNeu, 0, tradesOldCt);

      tradesNeuCt := totalOpenTrades;
      SetLength(tradesNeu, tradesNeuCt);
      // tradesNeu:=copy(trades^,0,totalTrades);

      // das ist wohl die sicherste Kopiermethode
      // mit Memory kopieren bekommt man Probleme mit Referenzzählern
      for i := 0 to totalOpenTrades - 1 do
      begin
        tradesNeu[i] := pOpenTradesArray[i];
      end;

      // jetzt liegt neu und alt als tradesNeu und tradesAlt vor
      vergleich(tradesOld, tradesNeu, tradesOldCt, tradesNeuCt);
    except
      debug('Fehler Trades verarbeiten...');
    end;
  end;
  // ----
  // ---- or manapi.TradeRecordGet by order#
end;

// +------------------------------------------------------------------+
// | On update bid/ask                                                |
// +------------------------------------------------------------------+
procedure TForm1.OnUpdateBidAsk;
var
  count: Integer;
  // si wird hier groß genug angelegt und der Speicher nach Verlassen der Funktion gelöscht
  si: array [0 .. 255] of TSymbolInfo;
  Str: AnsiString;
  k: Integer;
  {
    symbol                : TStr12;  // symbol name
    digits                : integer; // floating point digits
    count                 : integer; // symbol counter     Das ist die interne WP-Nummer zB zwischen 1 und 840
    visible               : integer; // visibility
    //---- äàííûå äëÿ ïåðåðàñ÷¸òà ñïðåäà
    stype                 : integer; // symbol type (symbols group index)
    point                 : double;  // symbol point=1/pow(10,digits)
    spread                : integer; // symbol spread
    spread_balance        : integer; // spread balance
    //----
    direction             : integer; // direction
    updateflag            : integer; // update flag
    lasttime              : time_t;  // last tick time
    bid,ask               : double;  // bid, ask
    high,low              : double;  // high, low
    commission            : double;  // commission
    comm_type             : integer; // commission type
  }
begin
  if (manapi = nil) then
    exit;

  count := 255; // muss das am Anfang so sein ?
  // int  CManagerInterface::SymbolInfoUpdated(
  // SymbolInfo*      si,       // Description of symbols
  // const int        max_info  // The maximum number of symbols
  // )
  count := manapi.SymbolInfoUpdated(@si, count);
  if count > 0 then
  begin
    msgCounterPlus[5] := msgCounterPlus[5] + count;
    if (workTicks = true) then
    begin
      if filesClosed = false then
        // -> die Ticks wegschreiben in die tausend offenen Files
        saveTicks(si, count);

      if ticksToServer = true then
        doTicksToServer(si, count);

      if doBidAskGrid = true then
      begin
        updateGrid(si, count);
      end;
      if (chkShowBidAsk.Checked = true) then
      begin
        Str := 'PUMP_UPDATE_BIDASK: ' + inttostr(count) + ' total quotes. All:' + inttostr(msgCounterPlus[5]);
        lbStatisticsPump.Items.Add(Str);
        Str := '';
      end;

    end;
  end;
end;

procedure TForm1.saveTicks(si: array of TSymbolInfo; count: Integer);
// si[] sind nur die aktualisierten  Symbole mit Kurs
// das sind nicht ALLE sondern einfach MEHRERE Symbole mit jeweils EINEM neuen
var
  k, l: Integer;
  gt: Cardinal;
begin
  gt := GetTickCount;
  for k := 0 to count - 1 do
  begin
    allWpCt[si[k].count] := allWpCt[si[k].count] + 1; // Kurse hochzählen

    // die besonderen merkWp[] extra hochzählen
    // ist eigentlich Quatsch, das immer abzusuchen nachdem ja sowieso ALLE Werte weggeschrieben werden
    // for l := 0 to merkWpCount - 1 do
    // begin
    // if (si[k].symbol = merkWp[l].symbol) then
    // begin
    // merkWpCt[l] := merkWpCt[l] + 1;
    // break;
    // end;
    //
    // end;
  end;
  // Alles wegschreiben
  writeTicks(si, count);
  // bug('wt:' + inttostr(count) + '=' + inttostr(GetTickCount - gt));
end;

procedure TForm1.updateGrid(si: array of TSymbolInfo; count: Integer);
var
  k, l: Integer;
begin
  // !! hier über den Rückzeiger gehen wegen der Sortierung
  // allWPGridPtr: array [0 .. 1000] of integer;

  for k := 0 to count - 1 do
  begin
    SG.cells[1, allWPGridPtr[si[k].count]] := TimeToStr(now);
    SG.cells[2, allWPGridPtr[si[k].count]] := floattostr(si[k].bid);
    SG.cells[3, allWPGridPtr[si[k].count]] := floattostr(si[k].ask);
    SG.cells[4, allWPGridPtr[si[k].count]] := inttostr(allWpCt[si[k].count]);

  end;
end;

procedure TForm1.writeTicks(si: array of TSymbolInfo; count: Integer);
// ein Datenblock in si[] (meist max 255 Kurse) wird weggeschrieben
var
  kurs: TKurs;
  k: Integer;
  symbol: AnsiString;
begin
  for k := 0 to count - 1 do
  begin
    kurs.lasttime := si[k].lasttime;
    kurs.bid := si[k].bid;
    kurs.ask := si[k].ask;
    try
      Write(FA[si[k].count], kurs);
      writtenTicks := writtenTicks + 1;
    except
      symbol := symbols[allWpBackptr[si[k].count]].symbol;
      debug('cant write:' + inttostr(k) + ' c:' + inttostr(si[k].count) + ' sym:' + symbol);
    end;
  end;
end;

procedure TForm1.doTicksToServer(si: array of TSymbolInfo; count: Integer);
var
  i, k: Integer;
  tick: TTick;
  FlushNow: Boolean;
  fehler: Integer;
begin

  if TickPufferBlockSize = 0 then
    TickPufferBlockSize := 5000;
  if TickPufferFlushInterval = 0 then
    TickPufferFlushInterval := 5000; // msec

  if TickPufferFehler <> 0 then
  begin
    debug('Fehlerzustand fülle aber weiter');
  end;
  if TickPufferSwitch = 0 then
  // Anfangszustand - auf Puffer1 stellen
  begin
    TickPufferSwitch := 1;
    TickPuffer1Max := 3000;
    TickPuffer1Ct := -1;
    SetLength(TickPuffer1, TickPuffer1Max);
  end;

  for k := 0 to count - 1 do
  begin
    tick.symbol := symbols[allWpBackptr[si[k].count]].symbol;
    tick.time := si[k].lasttime;
    tick.bid := si[k].bid;
    tick.ask := si[k].ask;

    if TickPufferSwitch = 1 then
    begin

      TickPuffer1Ct := TickPuffer1Ct + 1;
      TickPuffer1[TickPuffer1Ct] := tick;
      if TickPuffer1Ct = TickPuffer1Max then
      begin
        TickPuffer1Max := TickPuffer1Max + 3000;
        SetLength(TickPuffer1, TickPuffer1Max);
        debug('puffer1->' + inttostr(TickPuffer1Max));
        // saveTickPufferToFile(@TickPuffer1, TickPuffer1Ct);
      end;

    end
    else
    begin
      TickPuffer2Ct := TickPuffer2Ct + 1;
      TickPuffer2[TickPuffer2Ct] := tick;
      if TickPuffer2Ct = TickPuffer2Max then
      begin
        TickPuffer2Max := TickPuffer2Max + 3000;
        SetLength(TickPuffer2, TickPuffer2Max);
        debug('puffer2->' + inttostr(TickPuffer2Max));
        // saveTickPufferToFile(@TickPuffer2, TickPuffer2Ct);
      end;

    end;
  end;

  // erst jetzt die Überprüfung auf Absenden
  FlushNow := false;

  if (TickPufferFehler = 0) then

  begin

    if (GetTickCount - TickPufferLastFlushTime) > TickPufferFlushInterval then
    begin
      FlushNow := true;
      debug('Flushtime erreicht');
    end;

    if TickPufferSwitch = 1 then

    begin
      if ((TickPuffer1Ct > TickPufferBlockSize) or (FlushNow = true)) then
      begin
        // Wechsel auf Puffer2
        debug('Wechsel -> Puffer2');
        TickPufferSwitch := 2;
        TickPuffer2Max := 3000;
        TickPuffer2Ct := -1;
        SetLength(TickPuffer2, TickPuffer2Max);
        // Puffer 1 nun wegsenden usw
        TickPufferLastFlushTime := GetTickCount;
        TickPufferFehler := saveTickPufferToFile(@TickPuffer1, TickPuffer1Ct);
        TickpufferFehlerRepeatTime := GetTickCount + 10000;
      end;
    end;

    if TickPufferSwitch = 2 then
    begin
      if ((TickPuffer2Ct > TickPufferBlockSize) or (FlushNow = true)) then
      begin
        // Wechsel auf Puffer1
        debug('Wechsel -> Puffer1');
        TickPufferSwitch := 1;
        TickPuffer1Max := 3000;
        TickPuffer1Ct := -1;
        SetLength(TickPuffer1, TickPuffer1Max);
        // Puffer 2 nun wegsenden usw
        TickPufferLastFlushTime := GetTickCount;
        TickPufferFehler := saveTickPufferToFile(@TickPuffer2, TickPuffer2Ct);
        if TickPufferFehler > 0 then
          TickpufferFehlerRepeatTime := GetTickCount + 10000;
      end;

    end;
  end;

  if (TickPufferFehler <> 0) then
  begin
    if (GetTickCount > TickpufferFehlerRepeatTime) then
    begin
      // es gibt einen nicht vollendeten Sendevorgang der nun wiederholt werden sollte
      if TickPufferSwitch = 1 then
      begin
        debug('erneuter Sendeversuch Puffer2');
        TickPufferFehler := saveTickPufferToFile(@TickPuffer2, TickPuffer2Ct);
        TickpufferFehlerRepeatTime := GetTickCount + 30000;

      end;
      if TickPufferSwitch = 2 then
      begin
        debug('erneuter Sendeversuch Puffer1');
        TickPufferFehler := saveTickPufferToFile(@TickPuffer1, TickPuffer1Ct);
        if TickPufferFehler > 0 then
          TickpufferFehlerRepeatTime := GetTickCount + 30000;
      end;
    end
    else
      debug('warte noch auf repeat...' + inttostr(GetTickCount) + '/' + inttostr(TickpufferFehlerRepeatTime) + ' Diff:'
        + inttostr(TickpufferFehlerRepeatTime - GetTickCount));
  end;

end;

function TForm1.saveTickPufferToFile(pa: paTTick; ct: Integer): Integer;
var

  tt: time_t;
  pTradeRecordArray: pATradeRecord;
  TFrom, TUpto: time_t;
  k, l: Integer;
  s: string;
  fileName: string;
  dat: string;
  folder: string;
  fstream: TStream;
  gt: Cardinal;
  fehler: Integer;
begin
  fehler := 0;
  gt := GetTickCount;
  // try
  // // die Datei zuerst speichern
  // dat := FormatDateTime('DDMMYYHHMMSS', now);
  // folder := ExtractFilePath(paramstr(0)) + 'tickpuffer_' + serverShort[serverTyp];
  // createDir(folder);
  // fileName := folder + '\puffer' + '_' + dat + '.tic';
  // fstream := TFileStream.Create(fileName, fmCreate);
  // l := SizeOf(pa^[0]);
  // fstream.WriteBuffer(pa^, l * ct);
  // finally
  // fstream.Free;
  // end;

  s := '[';
  for k := 0 to ct - 2 do
  begin
    s := s + pa^[k].getJSON + ',';
  end;
  s := s + pa^[ct - 1].getJSON + ']';
  // versenden
  debug('sende Puffer T:' + inttostr(ct) + ' B:' + inttostr(length(s)));
  if chkUserHistoryShowJSON.Checked = true then
  begin
    mJSON.Text := s;
  end;
  fehler := doHTTPPut(s, edHTTPAddress.Text + '/data/ticks?brokerId=' + inttostr(broker[serverTyp]));
  result := fehler;
end;

procedure TForm1.SGMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Grid: TStringGridSorted;
  i: Integer;
begin
  Grid := Sender as TStringGridSorted;
  i := Grid.Selection.Bottom - Grid.Selection.Top + 1;
  if Grid = SG then // Kurse
  begin

  end;

  if Grid = SG2 then // Users
  begin

  end;
  if Grid = SG3 then // Open Orders
  begin
    lblSG3.Caption := inttostr(i) + ' Orders selektiert';
  end;
  if Grid = SGCacheSearch then // History
  begin
    lbCacheSearchSelected.Caption := inttostr(i) + ' Orders selektiert';
  end;

end;

procedure TForm1.SG4Click(Sender: TObject);
begin
  SG4.cwtest := 1; // nur ein Versuch
end;

procedure TForm1.SG7DblClick(Sender: TObject);
var
  i: Integer;
  sum, w: double;
begin
  for i := 1 to SG7.RowCount - 1 do
  begin
    try
      w := StrToFloat(SG7.cells[1, i]);
      sum := sum + w;
    except
      // Fehler also nix aufsummieren
    end;
  end;
  SG7.cells[1, 0] := floattostr(sum);

end;

procedure TForm1.SG8DblClick(Sender: TObject);
var
  i: Integer;
  sum, sum2, sum3, w: double;
begin
  sum := 0;
  sum2 := 0;
  sum3 := 0;
  for i := 1 to SG8.RowCount - 1 do
  begin
    try
      w := StrToFloat(SG8.cells[1, i]);
      sum := sum + w;
      w := StrToFloat(SG8.cells[2, i]);
      sum2 := sum2 + w;
      w := StrToFloat(SG8.cells[4, i]);
      sum3 := sum3 + w;
    except
      // Fehler also nix aufsummieren
    end;
  end;
  SG8.cells[1, 0] := floattostr(sum);
  SG8.cells[2, 0] := floattostr(sum2);
  SG8.cells[4, 0] := floattostr(sum3);

end;

procedure TForm1.SGCacheColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
var
  Grid: TStringGridSorted;
begin
  debug('column moved:' + inttostr(FromIndex) + ' ->' + inttostr(ToIndex));
  // SwapRowField(SGColField,SGFieldCol,fromindex,toindex);
  // Grid := Sender as TStringGridSorted;

end;

procedure TForm1.SGCacheDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Grid: TStringGridSorted;

begin
  exit;

  // Beispiel wie man eine Zelle selbst zeichnen kann
  Grid := Sender as TStringGridSorted;
  Grid.Canvas.Brush.color := RGB(Random(256), Random(256), Random(256));
  Grid.Canvas.FillRect(Rect);
  Grid.Canvas.TextRect(Rect, Rect.Left, Rect.Top, Grid.cells[ACol, ARow]);
end;

procedure TForm1.SGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
// Live Kurse Grid
// diese proc wird von vielen Grids aufgerufen
var
  Grid: TStringGridSorted;
  col, row: Integer;
  fixedCol, fixedRow: Boolean;
  i, p: Integer;
  s: string;
  gt: Cardinal;
begin
  gt := GetTickCount();
  Grid := Sender as TStringGridSorted;

  if Button = mbright then
  // rechte Maus
  begin
    Grid.MouseToCell(X, Y, col, row);

    fixedCol := col < Grid.FixedCols;
    fixedRow := row < Grid.FixedRows;

    // if (fixedCol and fixedRow) then
    // Right-click in "header hub"

    if fixedRow then
    // Right-click in a "column header"
    // Rechtsclick in den Header -> Sortieren
    begin
      if (Grid.sortTyp[col] = 0) then
        Grid.sortTyp[col] := 1
      else
        Grid.sortTyp[col] := -Grid.sortTyp[col];

      SortStringGrid(Grid, col, Grid.sortTyp[col]);
      // SortStringGridCW(Grid, col, Grid.sortTyp[col]);
      // Selektion löschen
      Grid.Selection := NoSelection;

      // Sonderbehandlung SG: Grid der live-Kurse
      if (Grid = SG) then
      begin
        // die AllWpGridPtr müssen nun korrigiert werden
        // in der ersten Spalte steht die Nummer   #:123
        for i := 1 to symbolsTotal do // 1000 do
        begin
          s := SG.cells[0, i];
          p := AnsiPos('#:', s); // 0=nicht 1..=Position
          if (p > 0) then
          begin
            s := Copy(s, p + 2);

            allWPGridPtr[StrToInt(s)] := i; // aufpassen Index 0 oder 1 ???
          end
          else;
        end;
      end;
      // Ende Sonderbehandlung

    end
    else if fixedCol then
      // Right-click in a "row header"

    else
      // Right-click in a non-fixed cell
  end;
  LbDebug.Items.Add('Zeit Gridsort:' + inttostr(GetTickCount - gt));
end;

procedure TForm1.SGOnDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  s: string;
begin
  if ACol = 5 then
  begin
    s := SG.cells[ACol, ARow];
    {
      if StrToInt(s)>0  then begin
      SG.canvas.Brush.Color := clGreen;
      SG.Canvas.FillRect(Rect);
      SG.Canvas.TextRect(Rect, Rect.Left+2, Rect.Top+5, SG.Cells[ACol, ARow]);
      end;
    }
  end;
end;

// +------------------------------------------------------------------+
// | Initialization                                                   |
// +------------------------------------------------------------------+
procedure TForm1.btnStopAllClick(Sender: TObject);
begin
  willPumping := false;
  StopAll;
end;

procedure TForm1.btnQuotesHistorySaveClick(Sender: TObject);
var
  i: Integer;
  s, s2: string;
begin
  saveQuoteHistoryFlag := 1;
  s := cbQuotesHistorySymbol.Text + ':';
  s2 := s;
  for i := 0 to cbQuotesHistoryInterval.Items.count - 1 do
  begin
    cbQuotesHistoryInterval.ItemIndex := i;
    cbQuotesHistoryIntervalClick(nil);
    // -> saveQuoteHistoryTotal

    dosleep(10);
    // die Zeit  des ersten Kurses ist in saveQuoteHistoryFrom
    s2 := s2 + cbQuotesHistoryInterval.Text + '/' + DateTimeToStr(UnixToDateTime(saveQuoteHistoryFrom)) + '/' +
      DateTimeToStr(UnixToDateTime(saveQuoteHistoryTo)) + '/' + inttostr(saveQuoteHistoryTotal) + '/';
    s := s + cbQuotesHistoryInterval.Text + '=' + inttostr(saveQuoteHistoryTotal) + '/';
  end;
  ListBox8.Items.Add(s);
  ListBox81.Items.Add(s2);
  saveQuoteHistoryFlag := 0;
end;

procedure TForm1.btnQuotesHistorySaveAllClick(Sender: TObject);
var
  i: Integer;
  fileName, fileName2: string;
  gt: Cardinal;
  z: Integer;
begin
  gt := GetTickCount();
  btnQuotesHistorySaveStop.Visible := true;
  z := cbQuotesHistorySymbol.Items.count;
  for i := 0 to z - 1 do
  begin
    Label8.Caption := inttostr(i + 1) + ' of ' + inttostr(z);
    cbQuotesHistorySymbol.ItemIndex := i;
    btnQuotesHistorySaveClick(nil); // Save History
    if (saveQuoteHistoryStop <> 0) then
      break;
  end;
  // die Liste sichern

  fileName := ExtractFilePath(paramstr(0)) + 'history_' + serverShort[serverTyp] + '_' + FormatDateTime('ddmmyy', now) +
    '\info.txt';
  fileName2 := ExtractFilePath(paramstr(0)) + 'history_' + serverShort[serverTyp] + '_' + FormatDateTime('ddmmyy', now)
    + '\infoDatum.txt';
  // ListBox8.Items.Add('z:' + inttostr(GetTickCount - gt));
  ListBox8.Items.SaveToFile(fileName);
  ListBox81.Items.SaveToFile(fileName2);
  btnQuotesHistorySaveStop.Visible := false;

  saveQuoteHistoryStop := 0;
  Label8.Caption := '';

end;

procedure TForm1.btnQuotesHistorySaveStopClick(Sender: TObject);
begin
  saveQuoteHistoryStop := 1;
end;

procedure TForm1.btnSaveUserHistoryClick(Sender: TObject);
begin
  // save history
  saveUserHistoryFlag := 1;
  btnGetUserHistoryClick(nil);
  saveUserHistoryFlag := 0;
end;

procedure TForm1.btnSaveAllUserHistoryClick(Sender: TObject);
var
  i: Integer;
  z: Integer;
  gt: Cardinal;
  fileName: string;
  s: string;
begin
  debug('userstotal:' + inttostr(usersTotal));
  if usersTotal = 0 then
  begin
    debug('vor btnRequestUsersClick');
    btnRequestUsersClick(nil);
    debug('nach btnRequestUsersClick');
    dosleep(10);
  end;

  debug('marke1');

  saveHistoryInProgress := true;
  // zur schnellen Suche nach den Symbolnamen...
  if symbolsDic <> nil then
    try
      symbolsDic.Free;
    except
      debug('F:symbolsDic.free');

    end;
  symbolsDicOK := true;
  symbolsDic := TDictionary<String, Integer>.Create;
  symbolsStatisticCount := symbolsTotal; //
  symbolsStatisticReserved := symbolsTotal + 500;
  SetLength(symbolsStatistic, symbolsStatisticReserved);

  for i := 0 to symbolsStatisticReserved do // eigentlich nur bis symbolsTotal-1 aber wegen unknown eins mehr
  begin
    if i < symbolsTotal then
      symbolsDic.Add(symbols[i].symbol, i);
    if i < symbolsTotal then
      symbolsStatistic[i].symbol := symbols[i].symbol;
    // das sind die in Symbols enthaltenen Symbole. Später kommen welche aus alten Actions hinzu
    symbolsStatistic[i].count := 0;
    symbolsStatistic[i].sumPlus := 0;
    symbolsStatistic[i].sumMinus := 0;
    symbolsStatistic[i].plus := 0;
    symbolsStatistic[i].minus := 0;
    symbolsStatistic[i].users := 0;
    symbolsStatistic[i].merkuser := 0;

  end;

  debug('marke2');

  sendHistoryCounter := 0;
  // symbolsDic.Add('unknown', symbolsTotal);
  // symbols[symbolstotal].symbol:='unknown';
  btnStopSaveUserHistory.Visible := true;
  gt := GetTickCount();
  z := lbUsers.Items.count;
  ListBox9.Items.Clear;
  ListBox9.Items.Add
    ('User;Actions;OpenDate;BalanceIn;BalanceOut;zOrders;sumPlus;sumMinus;zPlus;zMinus;zCancel;accountTotal');

  // for i := lbUsers.ItemIndex to z - 1 do
  // debug('!! eingeschränkt!');
  for i := lbUsers.ItemIndex to z - 1 do

  begin
    Label9.Caption := inttostr(i + 1) + ' of ' + inttostr(z);
    edHistoryUserId.Text := inttostr(trunc(myStringToFloat(lbUsers.Items[i])));
    btnSaveUserHistoryClick(nil);
    if saveUserHistoryStop = 1 then
      break;
    dosleep(1);
  end;

  lbHTTP.Items.Add('Sendcounter:' + inttostr(sendHistoryCounter));

  createDir(ExtractFilePath(paramstr(0)) + 'users_' + serverShort[serverTyp]);

  fileName := ExtractFilePath(paramstr(0)) + 'users_' + serverShort[serverTyp] + '\userinfo' +
    serverShort[serverTyp] + '.csv';

  // ListBox9.Items.Add('z:' + inttostr(GetTickCount - gt));
  ListBox9.Items.SaveToFile(fileName);

  ListBox9.Items.Clear;

  ListBox9.Items.Add('Symbol;active;count;zPlus;sumPlus;zMinus;sumMinus;users');

  for i := 0 to symbolsStatisticCount - 1 do // eins mehr wegen unknown !
  begin

    if symbolsStatistic[i].count > 0 then
    begin
      if symbolsStatistic[i].symbol = '' then
        symbolsStatistic[i].symbol := '(BALANCE)';

      s := symbolsStatistic[i].symbol + ';';
      // bis symbolsTotal sind es Symbole aus der aktiven Liste. Die danach sind Symbole aus alten Actions !
      if i < symbolsTotal then
        s := s + 'yes;'
      else
        s := s + 'no;';

      s := s + inttostr(symbolsStatistic[i].count) + ';' + inttostr(symbolsStatistic[i].plus) + ';' +
        formatfloat('0.##', symbolsStatistic[i].sumPlus) + ';' + inttostr(symbolsStatistic[i].minus) + ';' +
        formatfloat('0.##', symbolsStatistic[i].sumMinus) + ';' + inttostr(symbolsStatistic[i].users);

      ListBox9.Items.Add(s);
    end;

  end;

  createDir(ExtractFilePath(paramstr(0)) + 'users_' + serverShort[serverTyp]);

  fileName := ExtractFilePath(paramstr(0)) + 'users_' + serverShort[serverTyp] + '\symbolinfo' +
    serverShort[serverTyp] + '.csv';

  ListBox9.Items.SaveToFile(fileName);

  ListBox9.Items.Clear;
  s := 'Int<=;zCanc;sumCanc;zWin;sumWin;zLoss;sumLoss';
  ListBox9.Items.Add(s);
  for i := 1 to 11 do
  begin
    s := holdTypes[i] + ';' + inttostr(holdStatistic[i, 0].count) + ';' +
      formatfloat('0.##', holdStatistic[i, 0].profit) + ';' + inttostr(holdStatistic[i, 1].count) + ';' +
      formatfloat('0.##', holdStatistic[i, 1].profit) + ';' + inttostr(holdStatistic[i, 2].count) + ';' +
      formatfloat('0.##', holdStatistic[i, 2].profit);
    ListBox9.Items.Add(s);
  end;
  fileName := ExtractFilePath(paramstr(0)) + 'users_' + serverShort[serverTyp] + '\holdinfo' +
    serverShort[serverTyp] + '.csv';
  ListBox9.Items.SaveToFile(fileName);

  saveUserHistoryStop := 0;
  btnStopSaveUserHistory.Visible := false;
  if symbolsDic <> nil then
    try

      symbolsDic.Free;
    except
      debug('F:symbolsDic.free');
    end;
  symbolsDic := nil;
  saveHistoryInProgress := false;
  // showmessage('Ende saveAllUserHistoryClick');

end;

procedure TForm1.btnSaveCacheFileClick(Sender: TObject);
begin
  saveCacheFile;
end;

procedure TForm1.btnStopSaveUserHistoryClick(Sender: TObject);
begin
  saveUserHistoryStop := 1;
  loopAllBrokersStop := 1;
end;

procedure TForm1.btnRefreshOpenOrdersClick(Sender: TObject);
// Open Trades werden in SG3 dargestellt
begin
  doTradesGrid(SG3, pOpenTradesArray, totalOpenTrades, totalOpenTrades);
  // SortStringGrid(SG3, 1);
end;

procedure TForm1.lbHTTPClick(Sender: TObject);
begin
  lbHTTP.Items.Clear;
end;

procedure TForm1.lbStatisticsClick(Sender: TObject);
begin
  lbStatistics.Items.Clear();
end;

procedure TForm1.ListBox7Click(Sender: TObject);
begin
  cbQuotesHistorySymbol.Text := ListBox7.Items[ListBox7.ItemIndex];
  btnChartRequestClick(nil);
end;

procedure TForm1.ListBox8DblClick(Sender: TObject);
begin
  ListBox8.Items.Clear;
end;

procedure TForm1.ListBox9Click(Sender: TObject);
begin
  showmessage(ListBox9.Items[ListBox9.ItemIndex]);
end;

procedure TForm1.LbDebugClick(Sender: TObject);
begin
  LbDebug.Items.Clear;
end;

procedure TForm1.lbStatisticsPumpClick(Sender: TObject);
begin
  lbStatisticsPump.Items.Clear;
end;

procedure TForm1.lbDebug3Click(Sender: TObject);
begin
  lbDebug3.Items.Clear;
end;

procedure TForm1.ListBox2Click(Sender: TObject);
begin
  lbStatisticsWP.Items.Clear;

end;

procedure TForm1.ListBox6Click(Sender: TObject);
begin
  ListBox6.Items.Clear;

end;

procedure TForm1.lbUsersClick(Sender: TObject);
var
  s: string;
  ipos: Integer;
  id: Integer;
  user: TUserRecord;
begin
  s := lbUsers.Items[lbUsers.ItemIndex];
  user := pUsersArray[lbUsers.ItemIndex];
  ipos := pos(':', s);

  s := leftstr(s, ipos - 1);
  edHistoryUserId.Text := s;
  btnGetUserHistoryClick(nil);
end;

procedure TForm1.lbUsersDblClick(Sender: TObject);
begin
  // lbUsers.Items.Clear;
end;

function TForm1.UnixToDateTime(UnixTime: dword): TDateTime;

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

procedure TForm1.initMerkWPs();
begin
  // DAX, EUR/USD, Gold, WTI, USD/JPY, GBP/USD, EUR/GBP, EUR/JPY, S&P500, Bitcoin, Coffee, DOW, NASDAQ, Silver.
  // Das sind die Werte, die beobachtet werden sollten. Ich beobachte allerdinge momentan alle ...
  merkWpCount := 15;
  merkWp[0].symbol := 'GE30-MAR';
  merkWp[1].symbol := 'GE30';
  merkWp[2].symbol := 'EURUSD';
  merkWp[3].symbol := 'GOLD';
  merkWp[4].symbol := 'SILVER';
  merkWp[5].symbol := 'WTI';
  merkWp[6].symbol := 'USDJPY';
  merkWp[7].symbol := 'GBPUSD';
  merkWp[8].symbol := 'EURJPY';
  merkWp[9].symbol := 'US500';
  merkWp[10].symbol := 'BTCEUR';
  merkWp[11].symbol := 'BTCUSD';
  merkWp[12].symbol := 'COF';
  merkWp[13].symbol := 'WS30'; // Dow
  merkWp[14].symbol := 'US100'; // Nasdaq

end;

procedure TForm1.btnStatisticsClick(Sender: TObject);
// Statistics
begin
  doStatistics;

end;

procedure TForm1.doStatistics;
var
  k: Integer;
  s: Integer;
  s1, s2: Integer;
  sym: string;
begin
  lbStatistics.Items.Clear;
  lbStatistics.Items.Add('Seit Start:' + inttostr(GetTickCount - progStart));
  s := 0;
  lbStatisticsWP.Items.Clear;
  lbStatisticsWP.Items.Add('--------------------------');
  lbStatisticsWP.Items.Add('Anzahl WP:' + inttostr(merkWpCount));
  for k := 0 to merkWpCount - 1 do
  begin
    lbStatisticsWP.Items.Add(merkWp[k].symbol + ':' + inttostr(merkWpCt[k]));
    s := s + merkWpCt[k];
  end;
  lbStatisticsWP.Items.Add('Summe:' + inttostr(s));

  s1 := 0;
  s2 := 0;
  s := 0;
  lbStatisticsWP.Items.Add('Alle WP:' + inttostr(allWPCount));
  for k := 0 to allWPCount - 1 do
  begin
    if (allWpCt[k] = 0) then
    begin
      sym := sucheSymbolNachCount(k);
      if (sym <> '') then
      begin
        lbStatisticsWP.Items.Add(sym + ':' + inttostr(allWpCt[k]));
        s1 := s1 + 1;
      end;
    end
    else
    begin
      s2 := s2 + 1;
      lbStatisticsWP.Items.Add(sucheSymbolNachCount(k) + ':' + inttostr(allWpCt[k]));
    end;
    s := s + allWpCt[k];
  end;

  lbStatistics.Items.Clear;
  for k := 0 to 15 do
  begin
    if (msgCounter[k] <> 0) then
    begin
      if (k = 5) then
      begin
        lbStatistics.Items.Add(msgTitle[k] + '  :  ' + inttostr(msgCounter[k]) + ' = ' + inttostr(msgCounterPlus[k]))
      end
      else
      begin
        lbStatistics.Items.Add(msgTitle[k] + '  :  ' + inttostr(msgCounter[k]))

      end;
    end;
  end;

  lbStatisticsWP.Items.Add('Summe:' + inttostr(s));
  lbStatisticsWP.Items.Add('writtenTicks:' + inttostr(writtenTicks));
  lbStatisticsWP.Items.Add('keine Kurse WPs:' + inttostr(s1));
  lbStatisticsWP.Items.Add('mit Kursen WPs:' + inttostr(s2));

end;

function TForm1.sucheSymbolNachCount(c: Integer): AnsiString;
// c ist .count und das ist die Laufnummer

begin

  result := allWp[c].symbol;
end;

procedure TForm1.openAllFiles();
var
  k: Integer;
  fname: AnsiString;
  len: Integer;
  lpos: Integer;
  kurs: TKurs;
  fpath: string;
begin
  fpath := ExtractFilePath(paramstr(0));
  createDir(fpath + 'kurse_' + serverShort[serverTyp]);
  for k := 0 to allWPCount - 1 do
  begin
    try

      fname := fpath + 'kurse_' + serverShort[serverTyp] + '\' + allWp[k].symbol + '.dat';

      fileMode := fmOpenReadWrite + fmShareDenyNone;
      AssignFile(FA[k], fname);
      fileMode := fmOpenReadWrite + fmShareDenyNone;

      if fileexists(fname) = true then
      begin
        fileMode := fmOpenReadWrite + fmShareDenyNone;
        Reset(FA[k]); // erneut öffnen
      end
      else
      begin
        fileMode := fmOpenReadWrite + fmShareDenyNone;
        Rewrite(FA[k]) // erstellt die Datei NEU löscht also alles!
      end;

      Seek(FA[k], FileSize(FA[k]));
    except
      debug('F:openAllFiles');
    end;

  end;
  filesClosed := false;
  filesOpened := true;
end;

procedure TForm1.closeAllFiles();
var
  k: Integer;
begin
  for k := 0 to allWPCount - 1 do
  begin
    try
      CloseFile(FA[k]);
    except
      debug('F:closeAllFiles');
    end;
  end;
  filesClosed := true;
  filesOpened := false;
end;

procedure TForm1.comAutoTimeChange(Sender: TObject);
begin
  autoTimeIndex := comAutoTime.ItemIndex;

end;

procedure TForm1.FileListBox1DblClick(Sender: TObject);
var
  s: string;
begin
  // Datei doppelt angeklickt
  btnReadQuotesFileClick(nil);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  debug('ende');
  if (filesOpened = true) then
    closeAllFiles();

end;

procedure TForm1.debug(s: AnsiString);
Var
  Datum: TDateTime;
  d: AnsiString;
begin
  Datum := now;
  d := FormatDateTime('dd.mm.yyyy hh:mm:ss', Datum);

  ctDebug := ctDebug + 1;

  WriteLog(s);

  s := d + ' ' + s;
  LbDebug.Items.Add(s);
  if ctDebug > 3000 then
  begin
    LbDebug.Items.Clear;
    ctDebug := 0;
  end;
end;

procedure TForm1.DirectoryListBox1Change(Sender: TObject);
begin
  FileListBox1.Directory := DirectoryListBox1.Directory;
end;

procedure TForm1.btnTickRequestClick(Sender: TObject);
// Ticksrequest geht nicht
var
  TickRecord: PATickRecord;
  TRequest: TTickRequest;
  total: Integer;
  TDFrom: TDateTime;
  TDFromTo: TDateTime;
  tt: time_t;
begin
  {
    type
    PTickRequest = ^TTickRequest;
    TTickRequest = packed record
    symbol : TStr12;                  // symbol
    from   : time_t; 	              // start of period
    fromto : time_t;                  // end of period
    flags  : char;                    // TICK_FLAG_* flags  TICK_FLAG_RAW usw
    end;
  }

  TRequest.symbol := 'EURUSD'#0;
  TDFrom := StrToDate('21.05.2019'); // + 0.5;
  TDFromTo := StrToDate('24.05.2019'); // + 0.6;
  tt := DateTimeToUnix(TDFrom);
  TRequest.from := DateTimeToUnix(TDFrom);
  TRequest.fromto := DateTimeToUnix(TDFromTo);

  // feste Werte
  // TRequest.from :=   1549368000; // diese Werte funktionieren im C-Programm
  // TRequest.fromto := 1549550000;

  // 1=from datafeed (RAW) 2=from server (normal) TICK_FLAG_ALL; //3=All
  // if TickRecord <> nil then manapi.MemFree(TickRecord);
  // function TicksRequest(const Request: TTickRequest;out Total: integer): PATickRecord; stdcall;

  // TickRecord:=Manapi.TicksRequest(TRequest,@Total);
  // geht nicht . Bei allen Symbolen ist logging=1 (Voraussetzung)    2   keepticks ist 15 (c++ Programm kann das abrufen aber nicht die Delphi-Api - hier fehlt die (neue) Funktion

  // TRequest.from := 0;
  // TRequest.fromto := 2000000000;

  total := 0;

  TRequest.flags := '1';
  TickRecord := manapi2.TicksRequest(TRequest, total);
  debug('Total:' + inttostr(total));

  total := 0;
  TRequest.flags := '2';
  TickRecord := manapi2.TicksRequest(TRequest, total);
  debug('Total:' + inttostr(total));

  total := 0;
  TRequest.flags := '3';
  TickRecord := manapi2.TicksRequest(TRequest, total);
  debug('Total:' + inttostr(total));

  if TickRecord <> nil then
  begin
    manapi2.MemFree(TickRecord);
    TickRecord := nil; // prüfen
  end;
end;

procedure TForm1.btnZipFileClick(Sender: TObject);
var
  gt: Cardinal;
begin
  // class procedure ExtractZipFile(const ZipFileName: string; const Path: string; ZipProgress: TZipProgressEvent = nil); static;

  gt := GetTickCount();
  zipFile(ExtractFilePath(paramstr(0)) + 'cache\' + cbCacheFileName.Text + '.zip',
    ExtractFilePath(paramstr(0)) + 'cache\' + cbCacheFileName.Text + '.bin');
  lbDebug3.Items.Add('Zip:' + inttostr(GetTickCount() - gt));
end;

function TForm1.zipFile(ArchiveName, fileName: String): Boolean;
var
  zip: TZipFile;
begin
  zip := TZipFile.Create;
  try
    if fileexists(ArchiveName) then
      DeleteFile(ArchiveName);
    zip.open(ArchiveName, zmWrite);
    zip.Add(fileName);
    zip.close;
    result := true;
  except
    result := false;
  end;
  FreeAndNil(zip);
end;

function TForm1.UnZipFile(ArchiveName, Path: String): Boolean;
var
  zip: TZipFile;
begin

  zip := TZipFile.Create;
  try
    zip.open(ArchiveName, zmRead);
    zip.ExtractAll(Path);
    zip.close;
    result := true;
  except
    result := false;
  end;
  zip.Free;

end;

procedure TForm1.DateTimePicker1Change(Sender: TObject);
var
  dt: TDateTime;
begin
  //
  dt := DateTimePicker1.DateTime;
  edCacheSearchTimeFrom.Text := inttostr(DateTimeToUnix(dt));
end;

procedure TForm1.DateTimePicker2Change(Sender: TObject);
var
  dt: TDateTime;
begin
  //
  dt := DateTimePicker2.DateTime;
  edCacheSearchTimeTo.Text := inttostr(DateTimeToUnix(dt));
end;

function TForm1.DateTimeToUnix(TD: TDateTime): time_t;
begin
  result := trunc((TD - 25569) * 86400);
end;

procedure datumstest();
var
  day1, day2: TDateTime;
  diff: double;
begin
  day1 := StrToDate('12/06/2002');
  day2 := StrToDate('12/07/2002');
  // debug('day1 = ' + DateToStr(day1));
  // debug('day2 = ' + DateToStr(day2));

  diff := day2 - day1;
  // debug('day2 - day1 = ' + floattostr(diff) + ' days');
end;

procedure TForm1.btnGetBinActionsClick(Sender: TObject);
var
  ret: String;
  gt: Cardinal;
  i: Integer;
  j: Integer;
  bytes: byteArray;
  s: AnsiString;
  s1: AnsiString;
  ms: TMemoryStream;
  sz:integer;
begin
  gt := GetTickCount;
  bytes := doHTTPGetBA(edGetUrl.Text);
  lbDebug2.Items.Add('Zeit GetUrl:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));

  if containstext(edGetUrl.Text, '/actions') then
  begin
    // nur wenn es sich um binäre actions handelt !
    i := SizeOf(cwaction);
    sz:= trunc(length(bytes) / i);
    SetLength(cwActions,sz);
    move(bytes[0], cwActions[0], length(bytes));
    // Move(dummy2[1], cwActions[0], dummy2.length);
    // Move(dummy1[1], cwActions[0], dummy2.length);
    lbDebug2.Items.Add('Zeit move->actions:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(length(bytes)));
    lbDebug2.Items.Add('Anzahl Actions:' + inttostr(sz));
    for j := 0 to sz - 1 do
    begin
      lbDebug2.Items.Add(inttostr(j) + ' ' + inttostr(cwActions[j].actionId)+' '+ inttostr(cwActions[j].userId)+' '+ inttostr(cwActions[j].symbolId));
      if j>100 then
        break;
    end;
    lbdebug2.items.add('...');
  end

end;

procedure TForm1.btnGetMemoryClick(Sender: TObject);
begin
  lblMemory.Caption := inttostr(CurrentProcessMemory);
  lblMemory.Caption := Format('%.0n', [CurrentProcessMemory * 1.0])
end;

procedure TForm1.btnGetOnlineClick(Sender: TObject);
var
  total: Integer;
  pr: PAOnlineRecord;
begin
  if manapi2 <> nil then
  begin
    pr := manapi2.OnlineRequest(total); // der direkte Abruf der funktioniert
    // function OnlineGet(out total: integer): PAOnlineRecord; stdcall; die im Pumpmodus verwendete Methode die funktioniert

    if (total = 0) then
      lblOnlineRequest.Caption := 'keine online'
    else
    begin
      lblOnlineRequest.Caption := inttostr(total) + ':' + inttostr(pr^[0].login) + ' ...';
    end;
  end;
end;


// function RecordToStr(const input: TMyRecord): String;
// begin
// SetLength(Result, SizeOf(TMyRecord));
// Move(input, Result[1], SizeOf(TMyRecord));
// end;
//
// function StrToRecord(const input: String): TMyRecord;
// begin
// //if Length(input) = SizeOf(TMyRecord) then
// Move(input[1], Result, SizeOf(TMyRecord));
// end;

procedure TForm1.btnGetUrlTestClick(Sender: TObject);
var
  Url, ret: String;
  u, v: string;
  w: widestring;
  gt: Cardinal;
  s: string;
begin
  Url := edGetUrlWininet.Text;
  gt := GetTickCount();
  ret := GetUrlContent(Url);
  s := UTF8Decode(ret);
  memGetUrl.Text := ret;
  memGetUrl2.Text := s;

  lbDebug2.Items.Add('Zeit GetUrl:' + inttostr(GetTickCount - gt) + ' l:' + inttostr(ret.length));
  if ret.length < 100 then
    lbDebug2.Items.Add(ret);
  dummy1 := ret;

end;

function GetUrlContent(const Url: string): string;
const
  bsize = 1000;

var
  NetHandle: HINTERNET;
  UrlHandle: HINTERNET;
  // die Länge habe ich mit 64 und 16384 probiert und kaum einen Unterschied festgestellt
  Buffer: array [1 .. bsize] of AnsiChar;
  BytesRead: dword;
  l: Integer;
  l1: Integer;
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
        // merkwürdig - eigentlich wird beim ersten mal ein 1000 Nullen Buffer an result angehängt. Die Nullen werden aber offenbar in einem String ignoriert ???
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

procedure TForm1.btnGetUserHistoryClick(Sender: TObject);
// GetHistory im Userfenster
// auch speichern mit saveUserHistoryFlag
// function TradesUserHistory(Login: integer;
// From, Upto: time_t; out Total: integer): PATradeRecord; stdcall;
// History request
var
  login: Integer;
  total: Integer;
  TDFrom: TDateTime;
  TDUpTo: TDateTime;
  tt: time_t;
  pTradeRecordArray: pATradeRecord;
  TFrom, TUpto: time_t;
  iBytesSent: Integer;
  k, l: Integer;

  s: AnsiString;
  fileName: string;
  dat: string;
  folder: string;
  fstream: TStream;
  sInfo: string;
  sJSON: string;
  rest, rptr, rz: Integer;
  done: Boolean;
  errCount: Integer;
  gt, gtt: Cardinal;
  httpFehler: Integer;
begin
  // iBytesSent:=manapi.BytesSent();
  // todo: der erste Eintrag fehlt
  if manapi2 <> nil then
    if manapi2.IsConnected <> 1 then
      showmessage('! nicht mehr verbunden !');

  if manapi = nil then
    exit;
  login := StrToInt(edHistoryUserId.Text); // 5033372;

  TDFrom := StrToDateTime(edHistoryDateFrom.Text);
  TDUpTo := StrToDateTime(edHistoryDateTo.Text);

  tt := DateTimeToUnix(TDFrom);
  TFrom := DateTimeToUnix(TDFrom);
  TUpto := DateTimeToUnix(TDUpTo);

  login := StrToInt(edHistoryUserId.Text); // 5025420;
  // In order to be able to use this method, a manager account needs to have the Supervise trades permission (ConManager::see_trades).
  // The method can only be called before switching to pumping.
  // Dieses Recht ist aber gegeben !!

  // Speicher anschliessend aufräumen nicht vergessen !
  pTradeRecordArray := manapi2.TradesUserHistory(login, TFrom, TUpto, total);

  // debug('Anzahl Trades:' + inttostr(total));
  Panel1.Caption := 'User:' + edHistoryUserId.Text + ' Entries:' + inttostr(total);
  if (total > -1) then
  begin
    if saveUserHistoryFlag = 0 then
      // wenn die Daten gesichert werden NICHT im Grid darstellen
      doTradesGrid(SG2, pTradeRecordArray, total, total);
    if saveUserHistoryFlag = 1 then
    begin
      if userHistoryToFile = true then
      begin

        try
          // die Datei zuerst speichern
          dat := FormatDateTime('DDMMYY', now);
          folder := ExtractFilePath(paramstr(0)) + 'users_' + serverShort[serverTyp];
          createDir(folder);
          fileName := folder + '\' + edHistoryUserId.Text + '_' + dat + '.htr';
          fstream := TFileStream.Create(fileName, fmCreate);
          l := SizeOf(pTradeRecordArray^[0]);
          // spai:=SizeOf(pai^);   //28   SizeOf(pai)=4   ich glaube die Größe kriegt man so nicht !
          fstream.WriteBuffer(pTradeRecordArray^, l * total);

          // und die Trades analysieren
          if symbolsDicOK = true then
          begin
            sInfo := doTradesInfo(pTradeRecordArray, total, login);
            ListBox9.Items.Add('K:' + edHistoryUserId.Text + ' ; ' + inttostr(total) + ' ; ' + sInfo);
          end;
        finally
          fstream.Free;
        end;

      end;
    end;

    // die offenen Trades:pOpenTradesArray, totalOpenTrades
    if userHistorySendDatabase = true then
    begin
      if total <> 0 then
      begin
        sendHistoryCounter := sendHistoryCounter + total;
        gt := GetTickCount;
        gtt := GetTickCount;
        rest := total;
        rptr := 0;
        rz := 0;
        repeat
          // nicht alles auf einmal senden
          rz := rest;
          if (rz > 5000) then
            rz := 5000;
          sJSON := pTradesArrayToJSON(pTradeRecordArray, rptr, rptr + rz - 1, 0);
          lbHTTP.Items.Add('U:' + edHistoryUserId.Text + ' A:' + inttostr(total) + ' B:' + inttostr(length(sJSON)));
          lbHTTP.Repaint;
          done := false;
          errCount := 0;
          repeat
            try
              httpFehler := doHTTPPut(sJSON, edHTTPAddress.Text + '/data/actions');
              if httpFehler <> 0 then
              begin
                done := false;
                lbHTTP.Items.Add('Fehler-nochmal!');
                errCount := errCount + 1;
              end
              else
                done := true;
            except
              done := false;
              lbHTTP.Items.Add('Fehler-nochmal!');
              errCount := errCount + 1;
            end;
          until ((done = true) or (errCount > 5));
          if chkUserHistoryShowJSON.Checked = true then
            mJSON.Text := sJSON;
          rptr := rptr + rz;
          rest := rest - rz;
          if rest > 0 then
          begin
            lbHTTP.Items.Add('(t:' + inttostr(GetTickCount - gt) + ')');
            dosleep(250); // kleine Pause
          end;
          gt := GetTickCount;
        until rest = 0;
        lbHTTP.Items.Add('t:' + inttostr(GetTickCount - gtt) + ' ' + edHistoryUserId.Text);

      end;
    end;

    if saveUserHistoryFlag = 0 then
      for k := 0 to total - 1 do
      begin
        s := inttostr(pTradeRecordArray[k].order) + ':' + inttostr(pTradeRecordArray[k].login) + ' ' + pTradeRecordArray
          [k].symbol + ' ' + inttostr(pTradeRecordArray[k].cmd) + ' ' + inttostr(pTradeRecordArray[k].volume) + ' ' +
          floattostr(pTradeRecordArray[k].open_price);
        lbStatisticsWP.Items.Add(s);
      end;

    if (chkUserHistoryToCache.Checked = true) and (total > 0) then
    begin

      l := tradesCacheCt;
      tradesCacheCt := tradesCacheCt + total;
      SetLength(tradesCache, tradesCacheCt);
      for k := 0 to total - 1 do
      begin
        tradesCache[l] := pTradeRecordArray[k];
        l := l + 1;
      end;
      btnShowCache.Caption := inttostr(tradesCacheCt) + ' Actions';
    end;

  end;
  // den Speicher wieder freigeben
  if pTradeRecordArray <> nil then
  begin
    manapi2.MemFree(pTradeRecordArray); // hier stand manapi
    pTradeRecordArray := nil; // prüfen
    total := 0;
  end;

end;

procedure TForm1.btnLoadCacheFileClick(Sender: TObject);
begin
  loadCacheFile;
  btnShowCache.Caption := inttostr(tradesCacheCt) + ' Actions';
end;

procedure TForm1.btnOnlineRecordGetClick(Sender: TObject);
// Beides geht ums verrecken nicht - kommt immer Fehlercode 2 zurück
// haha .. alles geklärt. Geht !
var
  user: TOnlineRecord;
  user2: TUserRecord;
  ret: Integer;
begin
  user.login := 0;

  ret := manapi.OnlineRecordGet(StrToInt(edOnlineRecordGet.Text), user);
  if (ret = RET_OK) then
    lblOnlineRequest.Caption := 'online:' + inttostr(user.counter)
  else
    lblOnlineRequest.Caption := 'offline:' + inttostr(ret);

  ret := manapi.UserRecordGet(StrToInt(edOnlineRecordGet.Text), user2);
  if (ret = RET_OK) then
    lblOnlineRequest.Caption := lblOnlineRequest.Caption + 'ok:' + inttostr(user2.login)
  else
    lblOnlineRequest.Caption := lblOnlineRequest.Caption + '?:' + inttostr(ret);
  //

end;

// procedure TForm1.TabUsersResize(Sender: TObject);
// var
// w: integer;
// begin
// w := TabSheet2.width - 8;
// lbUsers.width := trunc(w / 2);
// SG2.width := trunc(w / 2);
// end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  ret, ret2: Integer;
  ok1, ok2: Boolean;
begin
  // alle 5 Sekunden
  ok1 := false;
  ok2 := false;
  if serverTyp = 0 then
  begin
    exit; // noch kein Server ausgewählt - abbrechen

  end;

  // wenn alles bereits läuft nichts mehr tun
  if (manapi <> nil) then
  begin
    if manapi.IsConnected <> 0 then
      ok1 := true;
  end;

  if (manapi2 <> nil) then
  begin
    if manapi2.IsConnected <> 0 then
      ok2 := true;
  end;

  btnStopTimer.Enabled := false; // Stop Timer

  if ok1 = false then
  begin
    ret := initConnection(manapi, 'Pumping'); // 1=pump 2=direct
    if ret = 0 then
      ret := StartPumping();
  end;

  if ok2 = false then
  begin
    ret2 := initConnection(manapi2, 'Direct'); // 1=pump 2=direct

  end;

  if (ret + ret2) = 0 then
  begin
    // alles ok - der Start-Timer kann abgeschaltet werden
    debug('Schalte Starttimer ab');
    Timer1.Enabled := false;
    Timer1.Interval := 1000;
  end
  else
  begin
    // am Wochenende ist das wohl normal
    debug('Schalte Starttimer-> 10 sec');
    Timer1.Interval := 10000;
  end;;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
  t: TDateTime;
  d: Integer;
  s: string;
begin
  // alle 30 sec Statistics
  doStatistics;

  t := now;
  if autoTime = true then
  begin
    if t > nextAutoTime then
    begin
      getNextAutoTime;
      DateTimeToString(s, 'dd.mm.yyyy', trunc(now - 1));
      edHistoryDateFrom.Text := s;
      if loopAllBrokersRunning = 0 then
        performAutoTime;
    end
    else
    begin
      d := trunc((nextAutoTime - now) * 86400);
      Label19.Caption := 'Next sec:' + inttostr(d);
    end;
  end;

  // AutoTime prüfen

end;

procedure TForm1.timageTimer(Sender: TObject);
var
  err2: Integer;
begin
  if serverTyp = 0 then
  begin
    Labelm1.Caption := '1:-';
    Labelm2.Caption := '2:-';
    exit;

  end;
  if manapi = nil then
    Labelm1.Caption := '1:nil';
  if manapi2 = nil then
    Labelm2.Caption := '2:nil';
  if (manapi = nil) or (manapi2 = nil) then
    exit;

  manapi.Ping;
  manapi2.Ping;

  try
    if manapi.IsConnected <> 0 then
      Labelm1.Caption := '1:ok'
    else
      Labelm1.Caption := '1:?';

    if manapi2.IsConnected <> 0 then
      Labelm2.Caption := '2:ok'
    else
    begin
      Labelm2.Caption := '2:?';
      // hier sollte manapi2 nochmal aufgebaut werden
      if manapi2 <> nil then
        if (workDirect = true) then
          lbUsers.Items.Add('versuche Manapi2 login nochmals');
      err2 := manapi2.login(_MAN_LOGIN, _MAN_PASS);
    end;
  except
    debug('F:timageTimer');
  end;
end;

procedure TForm1.btnStopTimerClick(Sender: TObject);
begin
  Timer1.Enabled := false;

end;

procedure TForm1.btnSymbolsGridClick(Sender: TObject);
begin
  doSymbolsGrid(SGSymbols, symbols, symbolsTotal);
end;

function WideStringToString(const Source: UnicodeString; CodePage: UINT): RawByteString;
var
  strLen: Integer;
begin
  strLen := LocaleCharsFromUnicode(CodePage, 0, PWideChar(Source), length(Source), nil, 0, nil, nil);
  if strLen > 0 then
  begin
    SetLength(result, strLen);
    LocaleCharsFromUnicode(CodePage, 0, PWideChar(Source), length(Source), PAnsiChar(result), strLen, nil, nil);
    SetCodePage(result, CodePage, false);
  end;
end;

procedure TForm1.Button8Click(Sender: TObject);
// get all Users and go
var
  sJSON: string;
  sAll: string;
  sTest: string;
  sTest2: string;
  i: Integer;
  gt, von, bis: Integer;
  httpFehler: Integer;
begin
  if usersTotal <= 0 then
  begin
    btnRequestUsersClick(nil);
    if usersTotal <= 0 then
      exit;
  end;

  gt := GetTickCount();
  sAll := '[';
  von := StrToInt(Edit2.Text);
  bis := StrToInt(Edit3.Text);
  if bis > usersTotal then
    bis := usersTotal - 1;

  // bei 0-0 den nullten User als Test verändern
  if (von + bis = 0) then
  begin
    pUsersArray[0].group := 'ÄÖÜäöü';
    pUsersArray[0].State := 'ÄÖÜäöü';
  end;
  for i := von to bis do
  begin
    sJSON := pUsersArray[i].getJSON(serverTyp);
    if i = von then
      sAll := sAll + sJSON
    else
      sAll := sAll + ',' + sJSON;
  end;
  sAll := sAll + ']';


  // das waren untaugliche Versuche ... letztlich wurde das Umlautproblem durch das richtige ANSI-Encoding gelöst !
  // sTest:=HTTPEncode(sAll);//Probieren
  // sTest2:=UTF8Encode(sAll);
  // mHttp.text:='HTTPEncode:'+sTest+ ' UTF8Encode:'+sTest2;

  // edHTTPtopic.Text := 'users';
  httpFehler := doHTTPPut(sAll, edHTTPAddress.Text + '/data/users');
  if httpFehler = 0 then
  begin
    mJSON.Text := 'done ' + inttostr(GetTickCount - gt);
    // mJSON.Text := sAll;
    lbHTTP.Items.Add('JSON Length:' + inttostr(sAll.length) + ' t:' + inttostr(GetTickCount - gt));
    // lblHTTP.Caption := inttostr(length(mJSON.Text));
  end
  else
    lbHTTP.Items.Add('Fehler HTTP');

end;

procedure TForm1.Button9Click(Sender: TObject);
var
  sJSON: string;
begin
  if totalOpenTrades <= 0 then
    exit;
  sJSON := pOpenTradesArray[0].getJSON(serverTyp);
  mJSON.Text := sJSON;
  lblHTTP.Caption := inttostr(length(mJSON.Text));

end;

procedure TForm1.rightTest();
var
  man: PConManager;
  results: Integer;
begin
  // function ManagerRights(man: PConManager): integer; stdcall;     //todo: ???
  results := 0;
  results := manapi.ManagerRights(man);
  debug(manapi.ErrorDescription(results)); // invalid Parameters
  { *       aus c-Programm entnommen:
    online
    logs
    reports
    user details
    see trades
    alles andere nicht!
    * }
  if (results = 0) then
  begin
    // -> 3 das könnte  invalid data sein. Warum steht todo dahinter ?
    lbStatisticsPump.Items.Add('login:' + inttostr(man.login));
    lbStatisticsPump.Items.Add('money:' + inttostr(man.money));
    lbStatisticsPump.Items.Add('online:' + inttostr(man.online));
    lbStatisticsPump.Items.Add('riskman:' + inttostr(man.riskman));
    lbStatisticsPump.Items.Add('broker:' + inttostr(man.broker));
    lbStatisticsPump.Items.Add('admin:' + inttostr(man.admin));
    lbStatisticsPump.Items.Add('logs:' + inttostr(man.logs));
    lbStatisticsPump.Items.Add('reports:' + inttostr(man.reports));
    lbStatisticsPump.Items.Add('trades:' + inttostr(man.trades));
    lbStatisticsPump.Items.Add('market_watch:' + inttostr(man.market_watch));
    lbStatisticsPump.Items.Add('email:' + inttostr(man.email));
    lbStatisticsPump.Items.Add('user_details:' + inttostr(man.user_details));
    lbStatisticsPump.Items.Add('see_trades:' + inttostr(man.see_trades));
    lbStatisticsPump.Items.Add('news:' + inttostr(man.news));
    lbStatisticsPump.Items.Add('plugins:' + inttostr(man.plugins));
  end;

end;

procedure TForm1.btnStopPumpClick(Sender: TObject); // STOP Pump
var
  ret: Integer;
begin

  StopPumping();

  ret := initConnection(manapi, 'Pumping'); // 1=pump 2=direct

  // startConnection(1 + 2);
  // damit sind Trades abrufbar
end;

procedure TForm1.chkWorkTicksClick(Sender: TObject);
begin
  workTicks := chkWorkTicks.Checked;
  // nachdem sich nun der Pump Modus ändern muss neu verbunden werden
  selectServer(ComboBox2.ItemIndex);
end;

procedure TForm1.chkShowStatisticsClick(Sender: TObject);
begin
  Timer2.Enabled := chkShowStatistics.Checked;
end;

procedure TForm1.chkTicksToServerClick(Sender: TObject);
begin
  ticksToServer := chkTicksToServer.Checked;

end;

procedure TForm1.chkUserHistorySendDatabaseClick(Sender: TObject);
begin
  userHistorySendDatabase := chkUserHistorySendDatabase.Checked;
end;

procedure TForm1.chkUserHistoryToFileClick(Sender: TObject);
begin
  userHistoryToFile := chkUserHistoryToFile.Checked;
end;

procedure TForm1.chkShowNoLogfileClick(Sender: TObject);
begin
  noLogFile := chkShowNoLogfile.Checked;
end;

procedure TForm1.chkWorkTradesClick(Sender: TObject);
begin
  workTrades := chkWorkTrades.Checked;
end;

procedure TForm1.chkWorkDirectClick(Sender: TObject);
begin
  workDirect := chkWorkDirect.Checked;
end;

procedure TForm1.chkWorkOpenOrdersClick(Sender: TObject);
begin
  workOpenOrders := chkWorkOpenOrders.Checked;

end;

procedure TForm1.CheckBox9Click(Sender: TObject);
begin
  if CheckBox9.Checked = true then
  begin
    RadioButton1.Enabled := true;
    RadioButton2.Enabled := true;
    RadioButton3.Enabled := true;
  end
  else
  begin
    RadioButton1.Enabled := false;
    RadioButton2.Enabled := false;
    RadioButton3.Enabled := false;
  end;
end;

procedure TForm1.btnStartPumpClick(Sender: TObject);
var
  ret: Integer;
begin

  ret := StartPumping();
end;

procedure test(var a: TStr12);
begin

end;

procedure test1();
var
  a: TStr12;
begin
  test(a);
end;

// füllt ein char array mit den Zeichen eines Strings
// https://www.delphipraxis.net/65569-string-zu-array-char.html
procedure FillCharArray(var a: TStr12; // char array, welches gefüllt werden soll
  const s: String // string, der die Zeichen liefert
  );
var
  i, j: Integer;
begin
  // weil die untere Grenze des char array verschoben sein kann,
  // und ich den Index für den String s nicht jedesmal mit
  // einem komplizierten Ausdruck berechnen will, verwende ich
  // eine zweite Laufvariable j zur Indizierung von s
  j := 0;
  // Um die Funktion allgemein zu halten greife ich nicht auf
  // die mir bekannten array Grenzen zu, sondern verwende die
  // Funktionen Low() und High()
  for i := Low(a) to High(a) do
  begin
    // Das erste Zeichen in einem String muss über den Index 1
    // angesprochen werden
    Inc(j);
    // Wenn im String s keine weiteren Zeichen mehr für mein
    // array enthalten sind,
    if i > length(s)
    // dann fülle ich mit dem speziellen #0 auf
    then
      a[i] := #0
      // sonst übernehme ich ein weiteres Zeichen
    else
      a[i] := AnsiChar(s[j]);
  end;
end;

procedure TForm1.BitBtnClick(Sender: TObject);
var
  i: Integer;
begin
  if Sender = BitBtn0 then
    i := 0;
  if Sender = bitBtn1 then
    i := 1;
  if Sender = bitBtn2 then
    i := 2;
  if Sender = bitBtn3 then
    i := 3;
  if Sender = bitBtn4 then
    i := 4;
  if Sender = bitBtn5 then
    i := 5;
  if Sender = bitBtn6 then
    i := 6;

  ComboBox2.ItemIndex := i + 1;
  ComboBox2Change(nil);
end;

procedure TForm1.btnChartRequestClick(Sender: TObject);
// Chart request
// und saveQuoteHistoryFlag=1 -> auch sichern
// das sind die Minutencharts die man über die API anfordern kann
var

  timesign: ptime_t; // weder so noch so geht was
  timesign2: time_t;
  total: Integer;
  ret: Integer;
  sym: TStr12;
  i: Integer;
  ssym: string;
  fileName: string;
  dat: string;
  folder: string;
  fstream: TStream;
  l: Integer;
  spai: Integer;
  txt: String;
begin
  // ChartRequest
  // function ChartRequest(const Chart: TChartInfo; TimeSign: ptime_t;out Total: integer): PARateInfo; stdcall;
  if manapi2 = nil then
    exit;
  ssym := cbQuotesHistorySymbol.Text;
  // sym:=ssym;   //inkompatible Typen !! Daher ist FillCharArray notwendig
  FillCharArray(sym, ssym);

  tci.symbol := sym;
  tci.period := StrToInt(cbQuotesHistoryInterval.Text);

  // tci.start := 1549368000;
  // tci.tend := 1549550000;
  //
  // tci.tend := trunc(1549368000 / 86400) * 86400 + 86400;
  // tci.start := tci.tend - 86400;

  // so klappts in c++
  // einen gigantischen Zeitraum auswählen
  tci.start := 0; // 1549584000;
  tci.tend := 2000000000; // 1549670400;

  // Mode: nur 0 und 1 wirken - und das dann aber identisch
  // CHART_RANGE_IN   = 0;  //Data from the range of ChartInfo::from - ChartInfo::to.
  // CHART_RANGE_OUT  = 1;  //Data from the ranges "the beginning of history" - ChartInfo::from and ChartInfo::to - the end of history.
  // CHART_RANGE_LAST = 2;  //Data from the range ChartInfo::from - the end of history.

  tci.mode := StrToInt(cbQuotesHistoryMode.Text);
  total := 0;
  new(timesign);
  timesign^ := 0;
  if pai <> nil then
  begin
    manapi2.MemFree(pai);
    pai := nil; // prüfen
    total := 0;
  end;

  pai := manapi2.ChartRequest(tci, timesign, total);
  saveQuoteHistoryTotal := total; // globale Variable
  if pai <> nil then
  begin
    saveQuoteHistoryFrom := pai^[0].ctm;
    saveQuoteHistoryTo := pai^[total - 1].ctm;
  end
  else
  begin
    saveQuoteHistoryFrom := 0;
    saveQuoteHistoryTo := 0;
  end;
  if (pai = NIL) then
    debug('ChartRequest misslungen')
  else
  begin
    if saveQuoteHistoryFlag = 0 then
    begin
      doHistoryGrid(SG4, pai, total);
      doHistoryChart(chart, pai, total);

    end;
    if saveQuoteHistoryFlag = 1 then
    begin
      try
        folder := ExtractFilePath(paramstr(0)) + 'history_' + serverShort[serverTyp] + '_' +
          FormatDateTime('ddmmyy', now);
        createDir(folder);
        fileName := folder + '\' + ssym + '_' + cbQuotesHistoryInterval.Text + '.his';
        fstream := TFileStream.Create(fileName, fmCreate);
        l := SizeOf(pai^[0]);
        // spai:=SizeOf(pai^);   //28   SizeOf(pai)=4   ich glaube die Größe kriegt man so nicht !
        fstream.WriteBuffer(pai^, l * total);
      finally
        fstream.Free;
      end;
    end;

  end;
  Label6.Caption := 'Count:' + inttostr(total);
end;

procedure TForm1.btnExtractZIPClick(Sender: TObject);
var
  zipFile: TZipFile;
  folder: string;
  fileName: string;
  gt: Cardinal;
begin
  // class procedure ExtractZipFile(const ZipFileName: string; const Path: string; ZipProgress: TZipProgressEvent = nil); static;

  gt := GetTickCount();
  TZipFile.ExtractZipFile(ExtractFilePath(paramstr(0)) + 'cache\' + cbCacheFileName.Text + '.zip',
    ExtractFilePath(paramstr(0)) + 'cache');
  lbDebug3.Items.Add('Unzip:' + inttostr(GetTickCount() - gt));

end;

procedure TForm1.btnRefreshQuoteGridClick(Sender: TObject);
begin
  // sg.Refresh;
  doKursGrid;
end;

procedure TForm1.stopKursGrid();

begin
  doBidAskGrid := false;
end;

procedure TForm1.doKursGrid();
var
  today: TDateTime;
  loop: Integer;
  k: Integer;
  l: Integer;
  s: string;
  sl: TStringList;
  gt: Cardinal;
  row: Integer;
begin
  gt := GetTickCount();
  sl := TStringList.Create;
  // die Größe gleich festlegen
  SG.RowCount := symbolsTotal + 1; // 1001;
  SG.ColCount := 6;
  SG.ColWidths[0] := 120;
  SG.cells[0, 0] := 'Symbol';
  SG.cells[1, 0] := 'Time';
  SG.cells[2, 0] := 'Bid';
  SG.cells[3, 0] := 'Ask';
  SG.cells[4, 0] := 'Count';
  SG.cells[5, 0] := 'Number';

  // lbStatistics.Items.Add('z:' + inttostr(GetTickCount() - gt) + ' count:' + inttostr(sl.count));

  gt := GetTickCount();
  today := now;
  s := TimeToStr(today);

  for k := 0 to symbolsTotal - 1 do // 1000 do
    allWPGridPtr[k] := k;

  for k := 0 to symbolsTotal - 1 do
  begin
    row := symbols[k].count + 1;
    SG.cells[0, row] := symbols[k].symbol + ' #:' + inttostr(symbols[k].count);
    allWPGridPtr[symbols[k].count] := row;

    // SG.cells[1, si[k].count + 1] := TimeToStr(now);
    // SG.cells[2, si[k].count + 1] := floattostr(si[k].bid);
    // SG.cells[3, si[k].count + 1] := floattostr(si[k].ask);
    // SG.cells[4, si[k].count + 1] := inttostr(allWpCt[si[k].count]);

    SG.cells[1, row] := '-';
    SG.cells[2, row] := '-';
    SG.cells[3, row] := '';
    SG.cells[4, row] := '';

    SG.cells[5, row] := inttostr(k); // Zähler für das erneute unsortierte Anzeigen

  end;

  // lbStatistics.Items.Add('z:' + inttostr(GetTickCount() - gt) + ' count:' + inttostr(sl.count));
  doBidAskGrid := true;

end;

procedure TForm1.doHistoryChart(chart: TRSCandleStickChart; quotes: PARateInfo; total: Integer);
var
  i: Integer;
  X, o, c, h, l: double;
  s: string;

begin
  chart.Values.Clear;
  // Chart.Values.DateTimeAxes :='xyX';// [xyX];

  for i := 0 to total - 1 do
  begin
    // x:=i;
    o := quotes[i].open;
    c := o + quotes[i].close;
    h := o + quotes[i].high;
    l := o + quotes[i].low;
    X := UnixToDateTime(quotes[i].ctm);
    // s dazu und an jeder Candle steht ein Text - das will ich nicht !
    chart.Values.Add(X, o, c, h, l);
  end;

end;

procedure TForm1.doKursChart(chart: TRSLineChart; var Kurse: array of TKurs; total: Integer);
// macht ab 20000 Elementen eine Komprimierung der Darstellung
var
  i: Integer;
  X, m: double;
  stp: Integer;
begin
  chart.Values.Clear;
  // Chart.Values.DateTimeAxes :='xyX';// [xyX];
  i := 0;
  stp := 1;
  if (total > 20000) then
  begin
    stp := 1 + trunc(total / 20000);
  end;
  while i < total do
  begin
    // x:=i;
    m := (Kurse[i].bid + Kurse[i].ask) / 2;
    X := UnixToDateTime(Kurse[i].lasttime);
    // chart.Values.Add(X, m);
    chart.Values.Add(X, m, '', clBlue);
    i := i + stp;
  end;

end;

// das History Grid
procedure TForm1.doHistoryGrid(SG2: TStringGridSorted; quotes: PARateInfo; total: Integer);
{ *
  struct RateInfo
  {
  time_t            ctm;                       // Bar time
  int               open;                      // Open price
  int               high,low,close;            // High, Low and Close prices (distance from the Open price)
  double            vol;                       // Tick volume
  * }

var
  today: TDateTime;
  loop: Integer;
  k: Integer;
  l: Integer;
  s: string;
  sl: TStringList;
  gt: Cardinal;
  row: Integer;
  i: Integer;
  j: Integer;
begin
  gt := GetTickCount();
  sl := TStringList.Create;
  // die Größe gleich festlegen
  SG2.RowCount := total;
  SG2.ColCount := 7;
  SG2.ColWidths[0] := 90;
  SG2.cells[0, 0] := 'Time';
  SG2.cells[1, 0] := 'Open';
  SG2.cells[2, 0] := 'High';
  SG2.cells[3, 0] := 'Low';
  SG2.cells[4, 0] := 'Close';
  SG2.cells[5, 0] := 'Volume';
  SG2.cells[6, 0] := 'Nr';

  // lbStatistics.Items.Add('z:' + inttostr(GetTickCount() - gt) + ' count:' + inttostr(sl.count));

  gt := GetTickCount();
  today := now;
  s := TimeToStr(today);

  for k := 1 to total do
  begin
    row := k;
    SG2.cells[0, row] := DateTimeToStr(UnixToDateTime(quotes[k].ctm));
    SG2.cells[1, row] := inttostr(quotes[k].open);
    SG2.cells[2, row] := inttostr(quotes[k].high);
    SG2.cells[3, row] := inttostr(quotes[k].low);
    SG2.cells[4, row] := inttostr(quotes[k].close);
    SG2.cells[5, row] := floattostr(quotes[k].vol);
    SG2.cells[6, row] := inttostr(k);

  end;

  // lbStatistics.Items.Add('z:' + inttostr(GetTickCount() - gt) + ' count:' + inttostr(sl.count));
  doTradesGridFlag := true;

end;

procedure TForm1.doKursrecordGrid(SG2: TStringGridSorted; var Kurse: array of TKurs; total: Integer);

{ *
  struct RateInfo
  {
  time_t            ctm;                       // Bar time
  int               open;                      // Open price
  int               high,low,close;            // High, Low and Close prices (distance from the Open price)
  double            vol;                       // Tick volume
  * }

var
  today: TDateTime;
  loop: Integer;
  k: Integer;
  l: Integer;
  s: string;
  sl: TStringList;
  gt: Cardinal;
  row: Integer;
  i: Integer;
  j: Integer;
begin
  gt := GetTickCount();
  // sl := TStringList.Create;
  // die Größe gleich festlegen
  SG2.RowCount := total;
  SG2.ColCount := 4;
  SG2.ColWidths[0] := 140;
  SG2.cells[0, 0] := 'Time';
  SG2.cells[1, 0] := 'Bid';
  SG2.cells[2, 0] := 'Ask';
  SG2.cells[3, 0] := 'Nr';

  // lbStatistics.Items.Add('z:' + inttostr(GetTickCount() - gt) + ' count:' + inttostr(sl.count));

  gt := GetTickCount();
  today := now;
  s := TimeToStr(today);

  for k := 1 to total do
  begin
    row := k;
    // DateTimeToString(formattedDateTime, 'c', myDate);   zeigt alles
    SG2.cells[0, row] := DateTimeToStr(UnixToDateTime(Kurse[k].lasttime));
    SG2.cells[1, row] := floattostr(Kurse[k].bid);
    SG2.cells[2, row] := floattostr(Kurse[k].ask);
    SG2.cells[3, row] := inttostr(k);

  end;

  // lbStatistics.Items.Add('z:' + inttostr(GetTickCount() - gt) + ' count:' + inttostr(sl.count));

end;

function TForm1.doTradesInfo(trades: pATradeRecord; total: Integer; login: Integer): string;
// die historischen Trades eines Users werden analysiert
var
  i, k: Integer;
  s: string;
  zBalance, zOrders: Integer;
  sPlus, sMinus: double;
  zPlus, zMinus: Integer;
  sNix: Integer;
  dOpen: Integer;
  balIn: double;
  balOut: double;
  summe: double;
  dat: string;
  sym: TStr12;
  hold: Integer; // Anzahl sekunden bis closing
  holdtyp: Integer;
  merkSeparator: Char;
  flag: Boolean;
begin
  dOpen := DateTimeToUnix(now);
  sPlus := 0;
  sMinus := 0;
  zPlus := 0;
  zMinus := 0;
  sNix := 0;
  zBalance := 0;
  zOrders := 0;
  balIn := 0;
  balOut := 0;
  summe := 0;
  for k := 0 to total - 1 do
  begin
    // zuerst die Daten auf den User bezogen auswerten
    summe := summe + trades[k].profit;
    if trades[k].cmd = 6 then
    begin
      zBalance := zBalance + 1;
      if trades[k].profit > 0 then
        balIn := balIn + trades[k].profit
      else
        balOut := balOut + trades[k].profit;
    end
    else
      zOrders := zOrders + 1;
    if trades[k].open_time < dOpen then
      dOpen := trades[k].open_time;

    if trades[k].cmd <> 6 then
    begin
      if trades[k].profit > 0 then
      begin
        sPlus := sPlus + trades[k].profit;
        zPlus := zPlus + 1;
      end
      else if trades[k].profit < 0 then
      begin
        sMinus := sMinus + trades[k].profit;
        zMinus := zMinus + 1;
      end;
      if trades[k].profit = 0 then
        sNix := sNix + 1;

    end;

    sym := trades[k].symbol;

    // dann auf die Symbole bezogen auswerten
    // Ergebnisse stecken im globalen symbolsStatistic-Array

    flag := false;
    if symbolsDic = nil then
    begin
      flag := true;
      symbolsStatisticCount := 0;
      symbolsDic := TDictionary<String, Integer>.Create;
    end
    else if symbolsDic.ContainsKey(sym) = false then // hier tritt der Fehler auf !!
      flag := true;

    if flag = true then
    begin
      symbolsStatisticCount := symbolsStatisticCount + 1;
      symbolsDic.Add(sym, symbolsStatisticCount - 1);
      symbolsStatistic[symbolsStatisticCount - 1].symbol := sym;
      if symbolsStatisticCount >= symbolsStatisticReserved then
      begin
        // neu dimensionieren
        symbolsStatisticReserved := symbolsStatisticReserved + 100;
        SetLength(symbolsStatistic, symbolsStatisticReserved);
        // alle Felder noch auf null setzen
        for i := symbolsStatisticReserved - 100 - 1 to symbolsStatisticReserved - 1 do
        begin

          symbolsStatistic[i].count := 0;
          symbolsStatistic[i].sumPlus := 0;
          symbolsStatistic[i].sumMinus := 0;
          symbolsStatistic[i].plus := 0;
          symbolsStatistic[i].minus := 0;
          symbolsStatistic[i].users := 0;
          symbolsStatistic[i].merkuser := 0;

        end;
      end;

    end;
    if symbolsDic.ContainsKey(sym) then
    begin
      // aufsummieren
      if symbolsStatistic[symbolsDic[sym]].merkuser <> login then
      begin
        symbolsStatistic[symbolsDic[sym]].merkuser := login;
        symbolsStatistic[symbolsDic[sym]].users := symbolsStatistic[symbolsDic[sym]].users + 1;

      end;
      symbolsStatistic[symbolsDic[sym]].count := symbolsStatistic[symbolsDic[sym]].count + 1;
      if trades[k].cmd <> 6 then
      begin
        if trades[k].profit > 0 then
        begin
          symbolsStatistic[symbolsDic[sym]].sumPlus := symbolsStatistic[symbolsDic[sym]].sumPlus + trades[k].profit;
          symbolsStatistic[symbolsDic[sym]].plus := symbolsStatistic[symbolsDic[sym]].plus + 1;
        end
        else if trades[k].profit < 0 then
        begin
          symbolsStatistic[symbolsDic[sym]].sumMinus := symbolsStatistic[symbolsDic[sym]].sumMinus + trades[k].profit;
          symbolsStatistic[symbolsDic[sym]].minus := symbolsStatistic[symbolsDic[sym]].minus + 1;
        end;

      end;

    end
    else
    begin
      // Symbol im Trade ist NICHT in den Symbolen enthalten

    end;
    // Unterteilung der Haltezeiten in verschiedene Typen
    hold := trades[k].close_time - trades[k].open_time;
    case hold of
      0 .. 15:
        holdtyp := 1;
      16 .. 60: // bis 1 Minute
        holdtyp := 2;
      61 .. 300: // bis 5 Minuten
        holdtyp := 3;
      301 .. 1200: // bis 20 Minuten
        holdtyp := 4;
      1201 .. 3600: // bis 1 Stunde
        holdtyp := 5;
      3601 .. 18000:
        holdtyp := 6;
      18001 .. 86400:
        holdtyp := 7;
      86401 .. 432000:
        holdtyp := 8;
      432001 .. 2592000:
        holdtyp := 9;
      2592001 .. 8640000:
        holdtyp := 10;
    else
      holdtyp := 11;
    end;

    if trades[k].cmd <> 6 then
    begin
      if trades[k].profit > 0 then
      begin
        holdStatistic[holdtyp, 1].count := holdStatistic[holdtyp, 1].count + 1;
        holdStatistic[holdtyp, 1].profit := holdStatistic[holdtyp, 1].profit + trades[k].profit;
      end
      else if trades[k].profit < 0 then
      begin
        holdStatistic[holdtyp, 2].count := holdStatistic[holdtyp, 2].count + 1;
        holdStatistic[holdtyp, 2].profit := holdStatistic[holdtyp, 2].profit + trades[k].profit;
      end
      else
      begin
        holdStatistic[holdtyp, 0].count := holdStatistic[holdtyp, 0].count + 1;
        // profit gibt es nicht
      end;
    end;
  end;

  // die auf den User bezogenen Auswertungen als Resultatstring zurückgeben
  merkSeparator := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := ',';
  if total = 0 then
    dat := '-'
  else
    dat := FormatDateTime('dd.mm.yyyy', UnixToDateTime(dOpen));

  s := dat + ' ; ' + formatfloat('0.##', balIn) + ';' + formatfloat('0.##', balOut) + ';' + inttostr(zOrders) + ' ; ' +
    formatfloat('0.##', sPlus) + ' ; ' + formatfloat('0.##', sMinus) + ' ; ' + inttostr(zPlus) + ' ; ' +
    inttostr(zMinus) + ' ; ' + inttostr(sNix) + ';' + formatfloat('0.##', summe);;
  result := s;
  FormatSettings.DecimalSeparator := merkSeparator;

end;

procedure TForm1.doSymbolsGrid(SG2: TStringGridSorted; symbols: PAConSymbol; total: Integer);
var
  today: TDateTime;
  loop: Integer;
  k: Integer;
  l: Integer;
  s: string;
  sl: TStringList;
  gt: Cardinal;
  row: Integer;
  acc: double;

begin
  gt := GetTickCount();
  sl := TStringList.Create;
  // SG2.enabled:=true;//neu 6.5.19
  // die Größe gleich festlegen
  SG2.RowCount := total + 1;
  SG2.ColCount := 23;
  if (SG2.RowCount > 1) then
    SG2.FixedRows := 1;
  SG2.ColWidths[0] := 100;
  SG2.cells[0, 0] := 'Symbol';
  SG2.cells[1, 0] := 'Description';
  SG2.cells[2, 0] := 'source';
  SG2.cells[3, 0] := 'currency';
  SG2.cells[4, 0] := 'gtype';
  SG2.cells[5, 0] := 'digits';
  SG2.cells[6, 0] := 'trade';
  SG2.cells[7, 0] := 'starting';
  SG2.cells[8, 0] := 'expiration';
  SG2.cells[9, 0] := 'profit_mode';
  SG2.cells[10, 0] := 'contract_size';
  SG2.cells[11, 0] := 'tick_value';
  SG2.cells[12, 0] := 'tick_size';
  SG2.cells[13, 0] := 'stops_level';
  SG2.cells[14, 0] := 'margin_initial';
  SG2.cells[15, 0] := 'margin_maintenance';
  SG2.cells[16, 0] := 'margin_hedged';
  SG2.cells[17, 0] := 'point';
  SG2.cells[18, 0] := 'multiply';
  SG2.cells[19, 0] := 'bid_tickvalue';
  SG2.cells[20, 0] := 'ask_tickvalue';
  SG2.cells[21, 0] := 'margin_currency';
  SG2.cells[22, 0] := '#';

  for k := 0 to total - 1 do
  begin
    row := k + 1;
    SG2.cells[0, row] := symbols[k].symbol;
    SG2.cells[1, row] := symbols[k].description;
    SG2.cells[2, row] := symbols[k].Source;
    SG2.cells[3, row] := symbols[k].currency;
    SG2.cells[4, row] := inttostr(symbols[k].gtype);
    SG2.cells[5, row] := inttostr(symbols[k].digits);
    SG2.cells[6, row] := inttostr(symbols[k].trade);
    SG2.cells[7, row] := DateTimeToStr(UnixToDateTime(symbols[k].starting));
    SG2.cells[8, row] := DateTimeToStr(UnixToDateTime(symbols[k].expiration));
    SG2.cells[9, row] := inttostr(symbols[k].profit_mode);
    SG2.cells[10, row] := floattostr(symbols[k].contract_size);
    SG2.cells[11, row] := floattostr(symbols[k].tick_value);
    SG2.cells[12, row] := floattostr(symbols[k].tick_size);
    SG2.cells[13, row] := inttostr(symbols[k].stops_level);
    SG2.cells[14, row] := floattostr(symbols[k].margin_initial);
    SG2.cells[15, row] := floattostr(symbols[k].margin_maintenance);
    SG2.cells[16, row] := floattostr(symbols[k].margin_hedged);
    SG2.cells[17, row] := floattostr(symbols[k].point);
    SG2.cells[18, row] := floattostr(symbols[k].multiply);
    SG2.cells[19, row] := floattostr(symbols[k].bid_tickvalue);
    SG2.cells[20, row] := floattostr(symbols[k].ask_tickvalue);
    SG2.cells[21, row] := symbols[k].margin_currency;
    SG2.cells[22, row] := inttostr(row);

  end;
  AutoSizeGrid(SG2);
end;

procedure TForm1.doUsersGrid(SG2: TStringGridSorted; users: pAUserRecord; total: Integer);
var
  today: TDateTime;
  loop: Integer;
  k: Integer;
  l: Integer;
  s: string;
  sl: TStringList;
  gt: Cardinal;
  row: Integer;
  acc: double;

begin
  gt := GetTickCount();
  sl := TStringList.Create;
  // SG2.enabled:=true;//neu 6.5.19
  // die Größe gleich festlegen
  SG2.RowCount := total + 1;
  SG2.ColCount := 15;
  if (SG2.RowCount > 1) then
    SG2.FixedRows := 1;
  SG2.ColWidths[0] := 100;
  SG2.cells[0, 0] := 'Login';
  SG2.cells[1, 0] := 'Name';
  SG2.cells[2, 0] := 'Email';
  SG2.cells[3, 0] := 'RegDate';
  SG2.cells[4, 0] := 'LastDate';
  SG2.cells[5, 0] := 'Leverage';
  SG2.cells[6, 0] := 'Balance';
  SG2.cells[7, 0] := 'Bal.l.Mon';
  SG2.cells[8, 0] := 'Country';
  SG2.cells[9, 0] := 'City';
  SG2.cells[10, 0] := 'PLZ';
  SG2.cells[11, 0] := 'Comment';
  SG2.cells[12, 0] := 'Group';
  SG2.cells[13, 0] := 'RegDateUnix';
  SG2.cells[14, 0] := 'LastDateUnix';

  for k := 0 to total - 1 do
  begin
    row := k + 1;
    SG2.cells[0, row] := inttostr(users[k].login);
    SG2.cells[1, row] := users[k].name;
    SG2.cells[2, row] := users[k].email;
    SG2.cells[3, row] := DateTimeToStr(UnixToDateTime(users[k].regdate));
    SG2.cells[4, row] := DateTimeToStr(UnixToDateTime(users[k].lastdate));
    SG2.cells[5, row] := inttostr(users[k].leverage);
    SG2.cells[6, row] := floattostr(users[k].balance);
    SG2.cells[7, row] := floattostr(users[k].prevmonthbalance);
    SG2.cells[8, row] := users[k].country;
    SG2.cells[9, row] := users[k].city;
    SG2.cells[10, row] := users[k].zipcode;
    SG2.cells[11, row] := users[k].comment;
    SG2.cells[12, row] := users[k].group;
    SG2.cells[13, row] := inttostr(users[k].regdate);
    SG2.cells[14, row] := inttostr(users[k].lastdate);

  end;
  AutoSizeGrid(SG2);
end;

procedure TForm1.doTradesGrid(SG: TStringGridSorted; trades: pATradeRecord; ct: Integer; total: Integer;
  stp: Integer = 1);
var
  today: TDateTime;
  loop: Integer;
  k: Integer;
  l: Integer;
  s: string;
  sl: TStringList;
  gt: Cardinal;
  row: Integer;
  acc: double;
  merkSeparator: Char;
  rct: Integer;
  rct1: Integer;
begin
  try
    gt := GetTickCount();
    sl := TStringList.Create;
    // die Größe gleich festlegen
    rct := trunc(ct / stp) + 2;
    rct1 := total + 1;
    if rct1 < rct then
      rct := rct1;

    SG.RowCount := rct;
    SG.ColCount := 30;
    if (SG.RowCount > 1) then
      SG.FixedRows := 1;

    SG.cells[SGFieldCol[0], 0] := 'Order';
    SG.ColWidths[SGFieldCol[0]] := 100;
    SG.cells[SGFieldCol[1], 0] := 'Login';
    SG.cells[SGFieldCol[2], 0] := 'Symbol';
    SG.cells[SGFieldCol[3], 0] := 'Cmd';
    SG.cells[SGFieldCol[4], 0] := 'Volume';
    SG.cells[SGFieldCol[5], 0] := 'OpenTime';
    SG.ColWidths[SGFieldCol[5]] := 150;
    SG.cells[SGFieldCol[6], 0] := 'OpenPrice';
    SG.cells[SGFieldCol[7], 0] := 'CloseTime';
    SG.ColWidths[SGFieldCol[7]] := 150;
    SG.cells[SGFieldCol[8], 0] := 'ClosePrice';
    SG.cells[SGFieldCol[9], 0] := 'Profit';
    SG.cells[SGFieldCol[10], 0] := 'Comment';
    SG.ColWidths[SGFieldCol[10]] := 200;
    SG.cells[SGFieldCol[11], 0] := 'S/L';
    SG.cells[SGFieldCol[12], 0] := 'T/P';
    SG.cells[SGFieldCol[13], 0] := 'Grund';
    SG.cells[SGFieldCol[14], 0] := 'Swap';
    SG.cells[SGFieldCol[15], 0] := 'reserve';
    SG.cells[SGFieldCol[16], 0] := 'Open UNIXTime';
    SG.cells[SGFieldCol[17], 0] := 'Close UNIXTime';
    SG.cells[SGFieldCol[18], 0] := 'AccProfit';
    SG.cells[SGFieldCol[19], 0] := 'reserve XOR';
    SG.cells[SGFieldCol[20], 0] := 'open_reserv';
    SG.cells[SGFieldCol[21], 0] := 'expiration';
    SG.cells[SGFieldCol[22], 0] := 'value_date'; // neu
    SG.cells[SGFieldCol[23], 0] := 'conv_rates[0]';
    SG.cells[SGFieldCol[24], 0] := 'commission';
    SG.cells[SGFieldCol[25], 0] := 'commission_agent';
    SG.cells[SGFieldCol[26], 0] := 'conv_rates[1]';
    SG.cells[SGFieldCol[27], 0] := 'activation';
    SG.cells[SGFieldCol[28], 0] := 'margin_reserved';
    SG.cells[SGFieldCol[29], 0] := 'margin_rate';

    // lbStatistics.Items.Add('z:' + inttostr(GetTickCount() - gt) + ' count:' + inttostr(sl.count));

    gt := GetTickCount();

    // merkSeparator:=FormatSettings.DecimalSeparator;
    // FormatSettings.DecimalSeparator:='.';

    today := now;
    s := TimeToStr(today);
    acc := 0;
    row := 0;
    k := 0;
    while (k < ct) do

    begin
      row := row + 1;
      if (row < (total + 1)) then
      begin
        SG.cells[SGFieldCol[0], row] := inttostr(trades[k].order);
        SG.cells[SGFieldCol[1], row] := inttostr(trades[k].login);
        SG.cells[SGFieldCol[2], row] := trades[k].symbol;
        SG.cells[SGFieldCol[3], row] := OrderTypes(trades[k].cmd);
        SG.cells[SGFieldCol[4], row] := inttostr(trades[k].volume);
        SG.cells[SGFieldCol[5], row] := DateTimeToStr(UnixToDateTime(trades[k].open_time));
        SG.cells[SGFieldCol[6], row] := floattostr(trades[k].open_price);
        SG.cells[SGFieldCol[7], row] := DateTimeToStr(UnixToDateTime(trades[k].close_time));
        SG.cells[SGFieldCol[8], row] := floattostr(trades[k].close_price);
        SG.cells[SGFieldCol[9], row] := floattostr(trades[k].profit);
        SG.cells[SGFieldCol[10], row] := trades[k].comment;
        SG.cells[SGFieldCol[11], row] := floattostr(trades[k].sl);
        SG.cells[SGFieldCol[12], row] := floattostr(trades[k].tp);
        SG.cells[SGFieldCol[13], row] := tradeGrund[trades[k].conv_reserv and 15];
        SG.cells[SGFieldCol[14], row] := floattostr(trades[k].storage);
        SG.cells[SGFieldCol[15], row] := inttohex(trades[k].conv_reserv);
        SG.cells[SGFieldCol[16], row] := inttostr(trades[k].open_time);
        SG.cells[SGFieldCol[17], row] := inttostr(trades[k].close_time);
        acc := acc + trades[k].profit + trades[k].storage;
        SG.cells[SGFieldCol[18], row] := formatfloat('0.##', acc);
        SG.cells[SGFieldCol[19], row] := inttohex(trades[k].conv_reserv xor 15);
        SG.cells[SGFieldCol[20], row] := inttostr(trades[k].open_reserv);
        SG.cells[SGFieldCol[21], row] := DateTimeToStr(UnixToDateTime(trades[k].expiration));
        SG.cells[SGFieldCol[22], row] := DateTimeToStr(UnixToDateTime(trades[k].value_date)); // test
        SG.cells[SGFieldCol[23], row] := floattostr(trades[k].conv_rates[0]);
        SG.cells[SGFieldCol[24], row] := floattostr(trades[k].commission);
        SG.cells[SGFieldCol[25], row] := floattostr(trades[k].commission_agent);
        SG.cells[SGFieldCol[26], row] := floattostr(trades[k].conv_rates[1]);
        SG.cells[SGFieldCol[27], row] := inttostr(trades[k].activation);
        SG.cells[SGFieldCol[28], row] := inttostr(trades[k].margin_reserved);
        SG.cells[SGFieldCol[29], row] := floattostr(trades[k].margin_rate);
      end
      else
      begin
        break;
      end;
      k := k + stp;
    end;

    // lbStatistics.Items.Add('z:' + inttostr(GetTickCount() - gt) + ' count:' + inttostr(sl.count));
    doTradesGridFlag := true;
    // FormatSettings.DecimalSeparator:=merkseparator;
  except
    debug('Fehler');
  end;
end;

procedure TForm1.DriveComboBox1Change(Sender: TObject);
begin
  DirectoryListBox1.Drive := DriveComboBox1.Drive;
end;

procedure TForm1.edCacheSearchTimeFromExit(Sender: TObject);
begin
  DateTimePicker1.DateTime := UnixToDateTime(StrToInt(edCacheSearchTimeFrom.Text));
end;

procedure TForm1.edCacheSearchTimeToExit(Sender: TObject);
begin
  DateTimePicker2.DateTime := UnixToDateTime(StrToInt(edCacheSearchTimeTo.Text));
end;

procedure TForm1.edFlushIntervalChange(Sender: TObject);
begin
  TickPufferFlushInterval := StrToInt(edFlushInterval.Text);
end;

procedure TForm1.edLSRatioChange(Sender: TObject);
begin
  lsRatioSymbols := edLSRatio.Text + ';';
end;

procedure TForm1.edQuotesHistorySeekChange(Sender: TObject);
var
  i: Integer;
  s: string;
begin
  // suhen nach Textinhalten -> combobox4
  ListBox7.Items.Clear;
  s := UpperCase(edQuotesHistorySeek.Text);
  for i := 0 to cbQuotesHistorySymbol.Items.count - 1 do
  begin
    if pos(s, UpperCase(cbQuotesHistorySymbol.Items[i])) > 0 then
      ListBox7.Items.Add(cbQuotesHistorySymbol.Items[i]);
  end;
end;

procedure TForm1.edTickPufferBlockSizeChange(Sender: TObject);
begin
  TickPufferBlockSize := StrToInt(edTickPufferBlockSize.Text);
end;

procedure TForm1.btnStartAllClick(Sender: TObject);
begin
  willPumping := true;
  startAll();
end;

procedure TForm1.btnRequestUsersClick(Sender: TObject);
begin
  if manapi2 = nil then
  begin
    debug('keine manapi2 Verbindung - Abbruch requestUsers');
    exit;
  end;
  doRequestUsers;
end;

function TForm1.pTradesArrayToJSON(pTR: pATradeRecord; von: Integer; bis: Integer; login: Integer): string;
var
  i: Integer;
  first: Integer;
begin
  result := '[';
  first := 1;
  for i := von to bis do
  begin
    // gt:=gettickcount;
    if ((login = 0) or (pTR[i].login = login)) then
    begin
      if first = 1 then
        result := result + pTR[i].getJSON(serverTyp)
      else
        result := result + ',' + pTR[i].getJSON(serverTyp);
      first := 0;
    end;
  end;
  result := result + ']';
end;

procedure TForm1.Button10Click(Sender: TObject);
// get all open Trades and go
var
  sJSON: string;
  sAll: string;
  i: Integer;
  von, bis: Integer;
  gt, gt2: Integer;
  httpFehler: Integer;
begin
  if totalOpenTrades <= 0 then
    exit;

  gt := GetTickCount();
  von := StrToInt(Edit2.Text);
  bis := StrToInt(Edit3.Text);
  if bis > totalOpenTrades then
    bis := totalOpenTrades - 1;

  sAll := pTradesArrayToJSON(pOpenTradesArray, von, bis, 0);
  httpFehler := doHTTPPut(sAll, edHTTPAddress.Text + '/data/actions');
  if httpFehler = 0 then
  begin
    mJSON.Text := 'done ' + inttostr(GetTickCount - gt);
    lbHTTP.Items.Add('JSON Length:' + inttostr(sAll.length));
    lblHTTP.Caption := inttostr(length(mJSON.Text));

  end
  else
    lbHTTP.Items.Add('HTTP Fehler');

end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  SGCache.MoveColumn(0, 3);
end;

procedure TForm1.Button12Click(Sender: TObject);
var
  gt: Cardinal;
  p: Integer;
begin
  gt := GetTickCount;
  p := StrToInt(edBlockSec.Text);
  Button12.Caption := 'block...';
  while (GetTickCount - gt) < p do
  begin

  end;
  Button12.Caption := 'btnBlock msec:';
end;

procedure TForm1.Button13Click(Sender: TObject);
var
  ret: String;
  gt: Cardinal;
  i: Integer;
  j: Integer;
  bytes: byteArray;
  s: AnsiString;
  s1: AnsiString;
  ms: TMemoryStream;
begin
  gt := GetTickCount;
  bytes := doHTTPGetBA(edGetUrlCSV.Text);

  // bei CSV-Dateien muss UTF8-decodiert werden damit die Umlaute passen
  SetString(s, PAnsiChar(@bytes[0]), high(bytes) - 1);
  s := UTF8Decode(s); // -> der String ist jetzt ok

  // den UTF8-decodierten AnsiString wieder als Bytearray
  SetLength(bytes, length(s));
  move(Pointer(s)^, Pointer(bytes)^, length(s));

  ms := TMemoryStream.Create;
  ms.WriteBuffer(bytes[0], high(bytes) - 1);

  lbdebug2.Items.Add('Bytes gelesen:'+inttostr(length(s)));
  lbdebug2.Items.Add(s);

  parsedelimited(lbdebug2,s,#13);
end;

procedure ParseDelimited(const sl : TListBox; const value : string; const delimiter : string) ;
var
dx : integer;
ns : string;
txt : string;
delta : integer;
begin
delta := Length(delimiter) ;
txt := value + delimiter;
sl.items.Clear;
try
while Length(txt) > 0 do
begin
dx := Pos(delimiter, txt) ;
ns := Copy(txt,0,dx-1) ;
sl.items.Add(ns) ;
txt := Copy(txt,dx+delta,MaxInt) ;
end;
finally
end;
end;

procedure TForm1.btnShowCacheClick(Sender: TObject);
var
  max: Integer;
  stp: Integer;
begin
  max := StrToInt(edCacheShowMax.Text);
  if tradesCacheCt < max then
    max := tradesCacheCt
  else;
  // showmessage('Die Darstellung wird auf ' + edCacheShowMax.Text + ' Einträge beschränkt!');

  stp := StrToInt(edCacheShowStep.Text);
  doTradesGrid(SGCache, @tradesCache[0], tradesCacheCt, max, stp);
  doCacheGridInfo;
end;

procedure TForm1.btnSleep20Click(Sender: TObject);
var
  s: string;
begin
  s := btnSleep20.Caption;
  btnSleep20.Caption := 'sleep...';
  dosleep(4000);
  btnSleep20.Caption := s;
end;

procedure TForm1.doCacheGridInfo;
begin
  pnlCache.Caption := 'CacheGrid:' + inttostr(SGCache.RowCount - 1) + ' SelectionGrid:' +
    inttostr(SGCacheSearch.RowCount - 1);
end;

procedure TForm1.btnClearCacheClick(Sender: TObject);
begin
  tradesCacheCt := 0;
  SetLength(tradesCache, 0);
  btnShowCache.Caption := inttostr(tradesCacheCt) + ' Actions';
end;

procedure TForm1.btnSelectPlusClick(Sender: TObject);
var
  i, max: Integer;
  found1: Boolean;
  found2: Boolean;
  found3: Boolean;
  found4: Boolean;
  found5: Boolean;
  found6: Boolean;
  fz: Integer;
  fzmax: Integer;
  s: string;
  login: Integer;
  // sCache: DTATradeRecord;
  symbol: string;
  gt: Cardinal;
  quoteFrom: double;
  quoteTo: double;
  timeFrom: Integer;
  timeTo: Integer;
  dummy: Boolean;
  grund: Integer;
  comment: string;
  sc: string;
begin
  // tradesCache[0],   tradesCacheCt
  FormatSettings.DecimalSeparator := '.';

  gt := GetTickCount();
  s := edCacheSearchUserId.Text;
  symbol := edCacheSearchSymbol.Text;
  if (s <> '') then
    try
      login := StrToInt(s);
    except
      login := 0;
    end;

  fzmax := tradesCacheSelectionCt + 1000;
  fz := tradesCacheSelectionCt - 1;
  SetLength(tradesCacheSelection, fzmax);
  quoteFrom := StrToFloat(edCacheSearchValueFrom.Text);
  quoteTo := StrToFloat(edCacheSearchValueTo.Text);
  timeFrom := StrToInt(edCacheSearchTimeFrom.Text);
  timeTo := StrToInt(edCacheSearchTimeTo.Text);
  grund := ComboBox3.ItemIndex - 1; // -1 alle Rest wie reason and 15
  comment := edCacheSearchComment.Text;
  for i := 0 to tradesCacheCt - 1 do
  begin
    found1 := false;
    found2 := false;
    found3 := false;
    found4 := false;
    found5 := false;
    found6 := false;
    if (tradesCache[i].order = 7011899) then
      dummy := true;
    if ((tradesCache[i].login = login) or (s = '')) then
      found1 := true;
    if ((tradesCache[i].symbol = symbol) or (symbol = '')) then
      found2 := true;
    if ((tradesCache[i].open_price >= quoteFrom) and (tradesCache[i].open_price <= quoteTo)) then
      found3 := true;
    if (quoteTo = 0) then
      found3 := true;

    if (((tradesCache[i].open_time >= timeFrom) or (timeFrom = 0)) and (tradesCache[i].open_time <= timeTo)) then
      found4 := true;

    if grund = -1 then
      found5 := true
    else
    begin
      if (tradesCache[i].conv_reserv and 15) = grund then
        found5 := true;
    end;

    if comment = '' then
      found6 := true
    else
    begin
      sc := tradesCache[i].comment;
      if (pos(comment, sc) > 0) then
        found6 := true;
    end;

    if ((found1 = true) and (found2 = true) and (found3 = true) and (found4 = true) and (found5 = true) and
      (found6 = true)) then
    begin
      fz := fz + 1;
      if (fz > fzmax - 1) then
      begin
        fzmax := fzmax + 1000;
        SetLength(tradesCacheSelection, fzmax);
      end;
      tradesCacheSelection[fz] := tradesCache[i];

    end;
  end;
  lbSelectTime.Caption := inttostr(fz + 1) + ' in:' + inttostr(GetTickCount - gt);

  max := 300000;
  if fz < max then
    max := fz + 1
  else
    showmessage('Die Darstellung wird auf 300000 Einträge beschränkt!');
  tradesCacheSelectionCt := max;
  doTradesGrid(SGCacheSearch, @tradesCacheSelection[0], tradesCacheSelectionCt, tradesCacheSelectionCt);
  doCacheGridInfo;
end;

function TForm1.SymbolsToJSON(von, bis: Integer): string;
var
  i: Integer;
  first: Integer;
begin
  result := '[';
  first := 1;
  for i := von to bis do
  begin

    begin
      if first = 1 then
        result := result + symbols[i].getJSON(broker[serverTyp])
      else
        result := result + ',' + symbols[i].getJSON(broker[serverTyp]);
      first := 0;
    end;
  end;
  result := result + ']';
end;

procedure TForm1.btnSendSymbolsToDatabaseClick(Sender: TObject);
// Send All Open Trades To DataBase
var
  sJSON, t: string;
  rest, rptr, rz: Integer;
  von, bis: Integer;
  httpFehler: Integer;
begin
  // die offenen Trades:pOpenTradesArray, totalOpenTrades

  if symbolsTotal <> 0 then
  begin
    von := StrToInt(Edit2.Text);
    bis := StrToInt(Edit3.Text);
    if bis > (symbolsTotal - 1) then
      bis := symbolsTotal - 1;
    sJSON := SymbolsToJSON(von, bis);
    httpFehler := doHTTPPut(sJSON, edHTTPAddress.Text + '/data/symbols');

    if chkUserHistoryShowJSON.Checked = true then
      mJSON.Text := sJSON;
    if httpFehler = 0 then

      lbHTTP.Items.Add('Symbols->DBase')
    else
      lbHTTP.Items.Add('HTTP Fehler');

  end;

end;

procedure TForm1.Button14Click(Sender: TObject);
// Loop all Brokers
var
  i: Integer;
  gt: Cardinal;
  gt2: Cardinal;
  flag: Boolean;
  ct: Integer;
  merk: Boolean;
begin
  // Cache zurücksetzen
  tradesCacheCt := 0;
  SetLength(tradesCache, 0);
  loopAllBrokersStop := 0;
  loopAllBrokersRunning := 1;
  gt := GetTickCount();
  for i := StrToInt(edLoopAllTo.Text) downto StrToInt(edLoopAllFrom.Text) do
  begin
    // alle Broker nacheinander durchwechseln
    ComboBox2.ItemIndex := i + 1;
    ComboBox2Change(nil);
    // warten bis Symbole und Offene Trades angekommen sind
    // Gefahr Endlosschleife !!
    // !! In dieser Wartezeit ist das Programm bedienbar und man kann so auch den Broker (fälschlicherweise) wechseln !!
    flag := false;
    ct := 0;
    gt2 := GetTickCount;
    // Problem ist dass Broker 2 (LCG B) keine Open Trades und symbols=0 hat
    // daher wird dieser nach Timeout ausgelassen
    repeat
      ct := ct + 1;
      dosleep(100);
      if (((symbolsTotal <> 0) and (totalOpenTrades > -1)) or (serverTyp = 2)) then
        flag := true
      else
        debug('ct:' + inttostr(ct) + ' warte symbolsTotal:' + inttostr(symbolsTotal) + ' und totalOpenTrades:' +
          inttostr(totalOpenTrades));
    until ((flag = true) or ((GetTickCount - gt2) > 20000));

    if (flag = true) then
      debug('br:' + inttostr(i) + 'symbols und opentrades angekommen')
    else
      debug('symbols da aber keine opentrades');

    if flag = true then
    begin
      debug('Liste user anfordern');

      // die Liste der User anfordern
      merk := chkUserHistorySendDatabase.Checked;
      chkUserHistorySendDatabase.Checked := false;
      debug('vor requestUsersClick');
      btnRequestUsersClick(nil);
      chkUserHistorySendDatabase.Checked := merk;

      // alle Userdaten abrufen
      debug('vor saveAllUserHistoryClick');
      // showmessage('ausgelassen');
      dosleep(1000);
      btnSaveAllUserHistoryClick(nil); // hier passiert Schutzverletzung
      debug('nach saveAllUserHistoryClick');

      // und den Cache speichern
      if chkUserHistoryToCache.Checked = true then
        bntOpenTradesToCacheClick(nil);

      if userHistorySendDatabase = true then
      begin
        debug('vor openTradesToDataBaseClick');
        bntOpenTradesToDatabaseClick(nil);

      end;
    end;
    if loopAllBrokersStop = 1 then
      break;
    // showmessage('weiter');
  end;
  loopAllBrokersStop := 0;
  loopAllBrokersRunning := 0;
  debug('Alle Daten ok :' + inttostr(GetTickCount - gt));
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
  Button14Click(nil); // Loop all brokers
end;

procedure TForm1.Button16Click(Sender: TObject);
// https://www.delphipraxis.net/174012-csv-dateien-einlesen.html
Var

  ca: array of cwaction;

  csvReader: TCSVReader;
  // sData: TFileStream;
  i, p: Integer;
  ct: Integer;
  gt: Cardinal;
  camax: Integer;
  cact: Integer;
  cptr: array of Integer;
  colFromField: array of Integer;

  ret: String;
  j: Integer;
  bytes: byteArray;
  s: AnsiString;
  s1: AnsiString;
  sData: TMemoryStream;

  function getCwActionFieldName(s: string): Integer;
  begin
    result := -1;
    s := UpperCase(s);
    if (s = UpperCase('actionId')) then
      result := 0;
    if (s = UpperCase('userId')) then
      result := 1;
    if (s = UpperCase('accountId')) then
      result := 2;
    if (s = UpperCase('symbolId')) then
      result := 3;
    if (s = UpperCase('commentId')) then
      result := 4;
    if (s = UpperCase('typeId')) then
      result := 5;
    if (s = UpperCase('sourceId')) then
      result := 6;
    if (s = UpperCase('openTime')) then
      result := 7;
    if (s = UpperCase('closeTime')) then
      result := 8;
    if (s = UpperCase('expirationTime')) then
      result := 9;
    if (s = UpperCase('openPrice')) then
      result := 10;
    if (s = UpperCase('closePrice')) then
      result := 11;
    if (s = UpperCase('stopLoss')) then
      result := 12;
    if (s = UpperCase('takeProfit')) then
      result := 13;
    if (s = UpperCase('swap')) then
      result := 14;
    if (s = UpperCase('profit')) then
      result := 15;
    if (s = UpperCase('volume')) then
      result := 16;
    if (s = UpperCase('precision')) then
      result := 17;
    if (s = UpperCase('conversionRate0')) then
      result := 18;
    if (s = UpperCase('conversionRate1')) then
      result := 19;
    if (s = UpperCase('marginRate')) then
      result := 20;

  end;

  procedure ff(f: Integer);
  begin
    if ct < 2 then
      Memo1.Lines.Add('Fehlende Col:' + inttostr(f));
  end;

Begin

  gt := GetTickCount;
  bytes := doHTTPGetBA(edCSVFileName.Text);
  if length(bytes) = 0 then
    exit;
  Memo1.Lines.Add('Zeit bis Bytearray:' + inttostr(GetTickCount - gt));

  // bei CSV-Dateien muss UTF8-decodiert werden damit die Umlaute passen
  SetString(s, PAnsiChar(@bytes[0]), high(bytes) - 1);
  Memo1.Lines.Add('Zeit bis string:' + inttostr(GetTickCount - gt));
  s := UTF8Decode(s); // -> der String ist jetzt ok
  Memo1.Lines.Add('Zeit bis utf8:' + inttostr(GetTickCount - gt));

  // den UTF8-decodierten AnsiString wieder als Bytearray
  SetLength(bytes, length(s));
  move(Pointer(s)^, Pointer(bytes)^, length(s));
  Memo1.Lines.Add('Zeit wieder string:' + inttostr(GetTickCount - gt));

  sData := TMemoryStream.Create;
  sData.WriteBuffer(bytes[0], high(bytes) - 1);
  sData.position := 0;
  Memo1.Lines.Add('Zeit bis Memorystream:' + inttostr(GetTickCount - gt));

  // sData := TFileStream.Create(edCSVFileName.Text, fmOpenRead);
  csvReader := TCSVReader.Create(sData, ';');
  csvReader.first;
  ct := 0;
  cact := 0;
  camax := 100000;
  SetLength(ca, camax);

  SetLength(colFromField, 21);
  Memo1.Lines.Add('Zeit bis Beginn csv Verarbeitung:' + inttostr(GetTickCount - gt));

  for i := 0 to 20 do
  begin
    colFromField[i] := -1;
  end;

  // Einlesen von actions aus csv und wandeln in cwactions

  Try
    While not csvReader.Eof Do
    Begin
      // if ct>10 then break;

      if (ct = 0) then
      begin
        // Header verarbeiten
        For i := 0 to csvReader.ColumnCount - 1 Do
        begin
          p := getCwActionFieldName(csvReader.Columns[i]);
          colFromField[p] := i;
          // Memo1.lines.add('Feld '+inttostr(i)+'='+csvReader.Columns[i]+' p:'+inttostr(p));
        end;
        ct := ct + 1;
      end
      else
      begin
        // Elemente hinzufügen
        ct := ct + 1;
        if (ct > camax) then
        begin
          camax := camax + 100000;
          SetLength(ca, camax);
        end;

        // *** hier spezielle Teile für actions users symbols ...
        // csv(col i)=feld(p)   ;
        if colFromField[0] > -1 then
          ca[ct].actionId := StrToInt(csvReader.Columns[colFromField[0]])
        else
          ff(0);
        if colFromField[1] > -1 then
          ca[ct].userId := StrToInt(csvReader.Columns[colFromField[1]])
        else
          ff(1);
        if colFromField[2] > -1 then
          ca[ct].brokerId := StrToInt(csvReader.Columns[colFromField[2]])
        else
          ff(2);
        if colFromField[3] > -1 then
          ca[ct].symbolId := StrToInt(csvReader.Columns[colFromField[3]])
        else
          ff(3);
        if colFromField[4] > -1 then
          ca[ct].commentId := StrToInt(csvReader.Columns[colFromField[4]])
        else
          ff(4);
        if colFromField[5] > -1 then
          ca[ct].typeId := StrToInt(csvReader.Columns[colFromField[5]])
        else
          ff(5);
        if colFromField[6] > -1 then
          ca[ct].sourceId := StrToInt(csvReader.Columns[colFromField[6]])
        else
          ff(6);
        if colFromField[7] > -1 then
          ca[ct].openTime := StrToInt(csvReader.Columns[colFromField[7]])
        else
          ff(7);
        if colFromField[8] > -1 then
          ca[ct].closeTime := StrToInt(csvReader.Columns[colFromField[8]])
        else
          ff(8);
        if colFromField[9] > -1 then
          ca[ct].expirationTime := StrToInt(csvReader.Columns[colFromField[9]])
        else
          ff(9);
        if colFromField[10] > -1 then
          ca[ct].openPrice := myStringToFloat(csvReader.Columns[colFromField[10]])
        else
          ff(10);
        if colFromField[11] > -1 then
          ca[ct].closePrice := myStringToFloat(csvReader.Columns[colFromField[11]])
        else
          ff(11);
        if colFromField[12] > -1 then
          ca[ct].stopLoss := myStringToFloat(csvReader.Columns[colFromField[12]])
        else
          ff(12);
        if colFromField[13] > -1 then
          ca[ct].takeProfit := myStringToFloat(csvReader.Columns[colFromField[13]])
        else
          ff(13);
        if colFromField[14] > -1 then
          ca[ct].swap := myStringToFloat(csvReader.Columns[colFromField[14]])
        else
          ff(14);
        if colFromField[15] > -1 then
          ca[ct].profit := myStringToFloat(csvReader.Columns[colFromField[15]])
        else
          ff(15);
        if colFromField[16] > -1 then
          ca[ct].volume := StrToInt(csvReader.Columns[colFromField[16]])
        else
          ff(16);
        if colFromField[17] > -1 then
          ca[ct].precision := StrToInt(csvReader.Columns[colFromField[17]])
        else
          ff(17);
        if colFromField[18] > -1 then
          ca[ct].conversionrate0 := myStringToFloat(csvReader.Columns[colFromField[18]])
        else
          ff(18);
        if colFromField[19] > -1 then
          ca[ct].conversionrate1 := myStringToFloat(csvReader.Columns[colFromField[19]])
        else
          ff(19);
        if colFromField[20] > -1 then
          ca[ct].marginrate := myStringToFloat(csvReader.Columns[colFromField[20]])
        else
          ff(20);
        // ****
        // if ct<100 then memo1.lines.add(inttostr(ca[ct].actionId));
      end;

      csvReader.Next;
    End;
  Finally
    // showmessage('vor free reader');
    csvReader.Free;
    sData.Free;
  End;
  Memo1.Lines.Add('Zeit:' + inttostr(GetTickCount - gt) + ' ct:' + inttostr(ct));
  SetLength(ca, ct); // Rest abschneiden

  // erste Zeile der CSV Datei enthält die Header
  // jeder dieser Header wird in der Headerliste gesucht und bekommt dann einen Index
  // zB spalte('UserID')=csv1 spalte('StopLoss')=csv10 . Damit wird dann ein Grid befüllt ODER ein Record belegt record.UserId=csv(1) record.StopLoss=cwv(10)
  //

  Memo1.Lines.Add('Anzahl gelesen:' + inttostr(ct));
  Memo1.Lines.BeginUpdate;
  for i := 0 to ct - 1 do
  begin
    Memo1.Lines.Add(inttostr(i) + ' ' + inttostr(ca[i].actionId) + ' ' + inttostr(ca[i].userId) + ' ' +
      inttostr(ca[i].symbolId));
    if i > 1000 then
      break;
  end;
  Memo1.Lines.Add('...');
  Memo1.Lines.EndUpdate;
  showmessage('fertig');
End;

procedure TForm1.btnClearGridClick(Sender: TObject);
var
  i: Integer;
begin

  ClearStringGridSorted(SGCache);
  // for i := 0 to SGCache.ColCount - 1 do
  // SGCache.Cols[i].clear;
  SGCache.RowCount := 1;
  doCacheGridInfo;
end;

procedure TForm1.btnClearPlusClick(Sender: TObject);
begin
  tradesCacheSelectionCt := 0;
  SetLength(tradesCacheSelection, 0);
  ClearStringGridSorted(SGCacheSearch);
  doCacheGridInfo;
end;

procedure TForm1.bntOpenTradesToCacheClick(Sender: TObject);
// send all open trades to cache
var
  k, l: Integer;
begin
  if (chkUserHistoryToCache.Checked = true) and (totalOpenTrades > 0) then
  begin

    l := tradesCacheCt;
    tradesCacheCt := tradesCacheCt + totalOpenTrades;
    SetLength(tradesCache, tradesCacheCt);
    for k := 0 to totalOpenTrades - 1 do
    begin
      tradesCache[l] := pOpenTradesArray[k];
      l := l + 1;
    end;
    btnShowCache.Caption := inttostr(tradesCacheCt) + ' Actions';
  end;
end;

procedure TForm1.Button21Click(Sender: TObject);
var
  sl: TStringList;
  s2: TStringList;

  f, i, dptr, ct: Integer;
  cCount: array of Integer;

begin
  // Check Comments

  sl := TStringList.Create;
  sl.Sorted := true;
  sl.Duplicates := dupIgnore;
  for i := 0 to tradesCacheCt - 1 do
  begin
    sl.Add(tradesCache[i].comment);
  end;
  showmessage('Kommentare:' + inttostr(sl.count) + ' von:' + inttostr(tradesCacheCt));
  SetLength(cCount, sl.count);
  for i := 0 to tradesCacheCt - 1 do
  begin
    if sl.Find(tradesCache[i].comment, f) then
      cCount[f] := cCount[f] + 1;
  end;
  lbDebug3.Items.Clear;

  for i := 0 to sl.count - 1 do
  begin
    if sl.Find(tradesCache[i].comment, f) then
      cCount[f] := cCount[f] + 1;
  end;

  s2 := TStringList.Create;
  s2.Sorted := true;

  for i := 0 to sl.count - 1 do
  begin
    s2.Add(inttostr(10000000 + cCount[i]) + ':' + sl[i]);
  end;
  ct := sl.count;
  for i := 0 to ct - 1 do
  begin
    lbDebug3.Items.Add(s2[ct - i - 1]);
  end;

  lbDebug3.Items.SaveToFile('commentCount.txt');

  sl.Clear;
  s2.Clear;
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
  // 10Mio Int-Array 40MB speichern
  testInt;
end;

procedure TForm1.Button23Click(Sender: TObject);
var
  data: TMemoryStream;
  i, len: Integer;
  Str, t: String;
  a: array of byte;
  gt: Cardinal;
  folder: string;
  n: Integer;
begin
  n := StrToInt(edMemMB.Text) * 1000000;
  SetLength(a, n);
  gt := GetTickCount;
  data := TMemoryStream.Create;
  len := n;
  data.write(a[0], n);
  data.position := 0;
  folder := ExtractFilePath(paramstr(0)) + 'cache';
  data.SaveToFile(folder + '\MemoryStream.bin');
  data.Free;
  lbDebug3.Items.Add('MemStream MB=' + edMemMB.Text + ' T:' + inttostr((GetTickCount - gt)));
end;

procedure TForm1.Button24Click(Sender: TObject);
var
  data: TMemoryStream;
  i, len: Integer;
  Str, t: String;
  a: array of byte;
  gt: Cardinal;
  folder: string;
  n: Integer;
begin
  n := StrToInt(edMemMB.Text) * 1000000;
  SetLength(a, n);
  gt := GetTickCount;
  data := TMemoryStream.Create;
  len := n;
  data.write(a[0], n);
  data.position := 0;
  folder := 'O:\cache\';
  data.SaveToFile(folder + '\MemoryStream.bin');
  data.Free;
  lbDebug3.Items.Add('MemStream MB=' + edMemMB.Text + ' T:' + inttostr((GetTickCount - gt)));
end;

procedure TForm1.Button25Click(Sender: TObject);
var
  logFilePath: PAnsiChar;
  hFile: Thandle;

  ofStruct: _OFSTRUCT;
  BytesWritten: dword;
  t: string;
  a: array of Integer;
  b: array of byte;
  i: Integer;
  gt: Cardinal;
  s: string;
  n: Integer;
begin
  n := StrToInt(edMemMB.Text) * 1000000;
  SetLength(a, n);
  for i := 0 to n do
  begin
    a[i] := i;
  end;
  gt := GetTickCount;
  s := ExtractFilePath(paramstr(0)) + 'cache\WriteFile.bin';
  logFilePath := PAnsiChar(AnsiString(s));
  hFile := OpenFile(logFilePath, ofStruct, OF_READWRITE OR OF_CREATE);
  If hFile <> INVALID_HANDLE_VALUE Then
  begin
    SetFilePointer(hFile, 0, nil, FILE_END);
    i := SizeOf(a);
    WriteFile(hFile, a[0], SizeOf(a) + (high(a) + 1), BytesWritten, nil);
  end;
  CloseHandle(hFile);
  lbDebug3.Items.Add('Writefile MB=' + edMemMB.Text + ' T:' + inttostr((GetTickCount - gt)));
end;

procedure TForm1.Button26Click(Sender: TObject);
var
  logFilePath: PAnsiChar;
  hFile: Thandle;

  ofStruct: _OFSTRUCT;
  BytesWritten: dword;
  t: string;
  a: array of Integer;
  b: array of byte;
  i: Integer;
  gt: Cardinal;
  s: string;
  n: Integer;
begin
  n := StrToInt(edMemMB.Text) * 1000000;
  SetLength(a, n);
  for i := 0 to n do
  begin
    a[i] := i;
  end;
  gt := GetTickCount;
  s := 'o:\cache\WriteFile.bin';
  logFilePath := PAnsiChar(AnsiString(s));
  hFile := OpenFile(logFilePath, ofStruct, OF_READWRITE OR OF_CREATE);
  If hFile <> INVALID_HANDLE_VALUE Then
  begin
    SetFilePointer(hFile, 0, nil, FILE_END);
    i := SizeOf(a);
    WriteFile(hFile, a[0], SizeOf(a) + (high(a) + 1), BytesWritten, nil);
  end;
  CloseHandle(hFile);
  lbDebug3.Items.Add('Writefile MB=' + edMemMB.Text + ' T:' + inttostr((GetTickCount - gt)));
end;

procedure TForm1.Button27Click(Sender: TObject);
var
  logFilePath: PAnsiChar;
  hFile: Thandle;

  ofStruct: _OFSTRUCT;
  BytesWritten: dword;
  t: string;
  a: array of Integer;
  b: array of byte;
  i: Integer;
  gt: Cardinal;
  s: string;
  n: Integer;
  block: Integer;
  rest: Integer;
  p: Integer;
  siz: Integer;
begin
  block := 4 * 65536; // 4096;//65536;
  n := StrToInt(edMemMB.Text) * 1000000;
  rest := n;
  SetLength(a, n);
  for i := 0 to n do
  begin
    a[i] := i;
  end;
  gt := GetTickCount;
  s := ExtractFilePath(paramstr(0)) + 'cache\WriteFileBlock.bin';
  logFilePath := PAnsiChar(AnsiString(s));
  hFile := OpenFile(logFilePath, ofStruct, OF_READWRITE OR OF_CREATE);
  If hFile <> INVALID_HANDLE_VALUE Then
  begin
    SetFilePointer(hFile, 0, nil, FILE_END);
    i := SizeOf(a);

    p := 0;
    rest := n;
    while rest > 0 do
    begin
      if rest > block then
        siz := block
      else
        siz := rest;

      WriteFile(hFile, a[p], siz, BytesWritten, nil);
      p := p + siz;
      rest := rest - siz;
    end;

  end;
  CloseHandle(hFile);
  lbDebug3.Items.Add('Writefile MB=' + edMemMB.Text + ' T:' + inttostr((GetTickCount - gt)));
end;

procedure TForm1.Button28Click(Sender: TObject);
var
  logFilePath: PAnsiChar;
  hFile: Thandle;

  ofStruct: _OFSTRUCT;
  BytesWritten: dword;
  t: string;
  a: array of Integer;
  b: array of byte;
  i: Integer;
  gt: Cardinal;
  s: string;
  n: Integer;
  block: Integer;
  rest: Integer;
  p: Integer;
  siz: Integer;
begin
  block := 4 * 65536 + 100; // 4096;//65536;
  n := StrToInt(edMemMB.Text) * 1000000;
  rest := n;
  SetLength(a, n);
  for i := 0 to n do
  begin
    a[i] := i;
  end;
  gt := GetTickCount;
  s := 'o:\cache\WriteFileBlock.bin';
  logFilePath := PAnsiChar(AnsiString(s));
  hFile := OpenFile(logFilePath, ofStruct, OF_READWRITE OR OF_CREATE);
  If hFile <> INVALID_HANDLE_VALUE Then
  begin
    SetFilePointer(hFile, 0, nil, FILE_END);
    i := SizeOf(a);

    p := 0;
    rest := n;
    while rest > 0 do
    begin
      if rest > block then
        siz := block
      else
        siz := rest;

      WriteFile(hFile, a[p], siz, BytesWritten, nil);
      p := p + siz;
      rest := rest - siz;
    end;

  end;
  CloseHandle(hFile);
  lbDebug3.Items.Add('Writefile MB=' + edMemMB.Text + ' T:' + inttostr((GetTickCount - gt)));
end;

procedure TForm1.Button29Click(Sender: TObject);
var

  a1: array of byte;
  a2: array of byte;

  i: Integer;
  gt: Cardinal;
  s: string;
  n: Integer;
begin
  n := StrToInt(edMemMB.Text) * 1000000;
  SetLength(a1, n);
  SetLength(a2, n);
  for i := 0 to n - 1 do
  begin
    a1[i] := 11;
    a2[i] := 22;
  end;

  gt := GetTickCount;
  // copymemory(@a1, @a2,n);
  move(a1[0], a2[0], 4);
  move(a1[0], a2[0], 12);
  move(a1[0], a2[0], 122);
  move(a1[0], a2[0], n);
  lbDebug3.Items.Add('CopyMemory MB=' + edMemMB.Text + ' T:' + inttostr(GetTickCount - gt));

end;

procedure TForm1.btnDblRemoveClick(Sender: TObject);
var
  sl: TStringList;
  i, dptr: Integer;
  killed: string;
  dummy: DTATradeRecord;
begin
  // Doubles remove
  // Dient dazu alle doppelten Einträge KOMPLETT zu entfernen
  // so kann aus einer Suche durch erneutes drübersuchen etwas verdoppelt und dann entfernt werden
  sl := TStringList.Create;
  for i := 0 to tradesCacheSelectionCt - 1 do
  begin
    sl.Add(inttostr(tradesCacheSelection[i].order) + '=' + inttostr(i))
  end;
  // sl.Sort;
  FastSortStList(sl, 'AU');
  SetLength(dummy, tradesCacheSelectionCt);
  dptr := -1;
  // sl.names[]  sl.valuefromindex[]
  for i := 0 to tradesCacheSelectionCt - 2 do
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
        dummy[dptr] := tradesCacheSelection[StrToInt(sl.ValueFromIndex[i])];
      end;
    end;
  end;
  // nun noch der letzte
  if (sl.Names[tradesCacheSelectionCt - 1] <> killed) then
  begin
    dptr := dptr + 1;
    dummy[dptr] := tradesCacheSelection[StrToInt(sl.ValueFromIndex[tradesCacheSelectionCt - 1])];
  end;
  // kopieren
  tradesCacheSelection := Copy(dummy, 0, tradesCacheSelectionCt);
  tradesCacheSelectionCt := dptr + 1;
  SetLength(tradesCacheSelection, tradesCacheSelectionCt);
  doTradesGrid(SGCacheSearch, @tradesCacheSelection[0], tradesCacheSelectionCt, tradesCacheSelectionCt);
  lbSelectTime.Caption := inttostr(tradesCacheSelectionCt);
  sl.Clear;
  doCacheGridInfo;
end;

procedure TForm1.btnDblCheckClick(Sender: TObject);
var
  sl: TStringList;
  slweg: TStringList;
  i, n: Integer;
  dCount: Integer;
  gt: Cardinal;
  da: doubleArray; // array of integer;
  ia: intArray; // array of double;

begin
  dCount := 0;
  SetLength(ia, tradesCacheCt);
  SetLength(da, tradesCacheCt);
  for i := 0 to tradesCacheCt - 1 do
  begin
    ia[i] := i;
    da[i] := tradesCache[i].order;
  end;

  gt := GetTickCount();
  sl := TStringList.Create;
  slweg := TStringList.Create;
  for i := 0 to tradesCacheCt - 1 do
  begin
    sl.Add(inttostr(tradesCache[i].order) + '=' + inttostr(i))
  end;
  showmessage('stringlist Zeit:' + inttostr(GetTickCount - gt));
  // // Die Standardmethode dauert 8800 msec
  // gt:=gettickcount;
  // sl.Sort;
  // showmessage('sortiert standard:'+inttostr(gettickcount-gt));
  //
  // // 1155
  // gt := GetTickCount();
  // FastSortStList(sl, 'AU');
  // showmessage('sortiert Zeit AU:' + inttostr(GetTickCount - gt));
  //
  // // 1123
  // gt := GetTickCount();
  // FastSortStList(sl, 'AD');
  // showmessage('sortiert Zeit AD:' + inttostr(GetTickCount - gt));
  //
  // //   12230
  // gt := GetTickCount();
  // FastSortStList(sl, 'VU');
  // showmessage('sortiert Zeit VU:' + inttostr(GetTickCount - gt));
  //
  // //   8252
  // gt := GetTickCount();
  // FastSortStList(sl, 'VD');
  // showmessage('sortiert Zeit VD:' + inttostr(GetTickCount - gt));

  // der customsort braucht 25334 msec !!
  gt := GetTickCount();
  sl.CustomSort(StringListSortComparefnUp);
  showmessage('sortiert Zeit3:' + inttostr(GetTickCount - gt));

  // 1185
  gt := GetTickCount();
  FastSort2Array(da, ia, 'VUA');
  showmessage('sortiert Zeit VUA:' + inttostr(GetTickCount - gt));
  // den folgenden Teil bräuchte ich nicht Ist nur damit der untere Code weiterhin funktioniert
  for i := 0 to tradesCacheCt do
  begin
    sl.Add(floattostr(da[i]) + '=' + inttostr(ia[i]))
  end;

  gt := GetTickCount();
  for i := 0 to tradesCacheCt - 2 do
  begin
    if (sl.Names[i] = sl.Names[i + 1]) then
    begin
      if (tradesCache[StrToInt(sl.ValueFromIndex[i])].cmd <> 6) then // nicht die BALANCE Einträge entfernen
      begin
        dCount := dCount + 1;
        slweg.Add(sl.ValueFromIndex[i]);
      end;
    end;
  end;
  showmessage('doppelte:' + inttostr(dCount) + ' Zeit:' + inttostr(GetTickCount - gt));
  gt := GetTickCount();
  for i := 0 to dCount - 1 do
  begin
    n := StrToInt(slweg[i]);
    tradesCache[n].order := -1;
  end;
  n := -1;
  for i := 0 to tradesCacheCt - 1 do
  begin
    if (tradesCache[i].order <> -1) then
    begin
      n := n + 1;
      tradesCache[n] := tradesCache[i];
    end;
  end;
  tradesCacheCt := n + 1;
  SetLength(tradesCache, tradesCacheCt);
  showmessage('jetzt im Cache:' + inttostr(tradesCacheCt) + ' Zeit:' + inttostr(GetTickCount - gt));

  sl.Clear;
  slweg.Clear;
  btnShowCacheClick(nil); // darstellen
end;

procedure TForm1.Button19Click(Sender: TObject);
// Listbox HTTP Protokoll in Datei speichern
var
  fileName: string;
begin

  fileName := ExtractFilePath(paramstr(0)) + 'httplog_' + serverShort[serverTyp] + '_' +
    FormatDateTime('ddmmyy', now) + '.txt';
  lbHTTP.Items.SaveToFile(fileName);

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  fileName: string;
  filePart: String;
  serverTyp: Integer;
  ziel: TStringGridSorted;
  LZiel: TLabel;
begin
  serverTyp := ComboBox1.ItemIndex;
  filePart := ExtractFilePath(paramstr(0)) + 'users_' + serverShort[serverTyp] + '\';
  if Sender = Button1 then
    fileName := 'userinfo' + serverShort[serverTyp] + '.csv';
  if Sender = Button2 then
    fileName := 'symbolinfo' + serverShort[serverTyp] + '.csv';
  if Sender = Button3 then
    fileName := 'holdinfo' + serverShort[serverTyp] + '.csv';

  if CheckBox9.Checked = true then
  // manuell
  begin
    if RadioButton1.Checked = true then
    begin
      ziel := SG7;
      LZiel := Label10;
    end;
    if RadioButton2.Checked = true then
    begin
      ziel := SG8;
      LZiel := Label11;
    end;
    if RadioButton3.Checked = true then
    begin
      ziel := SG9;
      LZiel := Label12;
    end;
  end
  else
  begin
    if Sender = Button1 then
    begin
      ziel := SG7;
      LZiel := Label10;
    end;
    if Sender = Button2 then
    begin
      ziel := SG8;
      LZiel := Label11;
    end;
    if Sender = Button3 then
    begin
      ziel := SG9;
      LZiel := Label12;
    end;

  end;

  csvToStringgridSorted(filePart + fileName, ziel);
  LZiel.Caption := fileName;

end;

procedure TForm1.btnCheckDoublesClick(Sender: TObject);
var
  i: Integer;
  merk: array of Integer;

begin
  // Check doubles
  SetLength(merk, 2000000);
  for i := 0 to 2000000 - 1 do
  begin

    merk[i] := 0;

  end;

  for i := 0 to tradesCacheCt - 1 do
  begin
    if tradesCache[i].order < 2000000 then

      merk[tradesCache[i].order] := merk[tradesCache[i].order] + 1;
  end;

  for i := 0 to 2000000 - 1 do
  begin
    if merk[i] > 1 then
    begin
      ListBox6.Items.Add('Doppelte Order:' + inttostr(i) + ':' + inttostr(merk[i]));
    end;
  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  lbLSRatio.Items.SaveToFile(ExtractFilePath(paramstr(0)) + 'Ratio.csv');
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  gt: Cardinal;
begin
  // -> Minuten
  gt := GetTickCount;
  generateMinutes(chartFileKurse, chartOHLCKurse, StrToInt(edMinutes.Text));
  showmessage('Erzeugte Bars:' + inttostr(high(chartOHLCKurse)) + 'Z:' + inttostr(GetTickCount - gt));
end;

function TForm1.doHTTPGetBA(Url: string): byteArray;

var
  HTTP: TIdHTTP;
  p: Integer;
  b: byteArray;
  // stream:TStream;
  mStream: TMemoryStream;

begin
  // test HTTP Get
  HTTP := TIdHTTP.Create;
  HTTP.ConnectTimeout := 400000;
  HTTP.ReadTimeout := 400000;
  mStream := TMemoryStream.Create;

  // sJSON := mJSON.Text;
  try
    try
      // ContentType := 'text/plain';
      try
        // result := HTTP.get(url);

        try
          HTTP.Get(Url, mStream);
          mStream.position := 0; // <-- add this!!
          // memo1.Lines.LoadFromStream(mStream);
          p := mStream.Size;
          SetLength(b, p);
          mStream.Read(b[0], p);
          result := b;
          // HTTP.Get(url,stream);
          // p:=stream.Size;
          // setlength(b,p);
        except
          on E: Exception do
          begin
            lbHTTP.Items.Add(E.Message);
          end;
        end;
      finally
        mStream.Free;
      end;
    except
      on E: EIdHTTPProtocolException do
      begin
        lbHTTP.Items.Add(E.Message + #13#10#13#10 + E.ErrorMessage);
      end;
      on E: Exception do
      begin
        lbHTTP.Items.Add(E.Message);
      end;
    end;
  finally
    HTTP.Free;
  end;
end;

function TForm1.doHTTPPut(sJSON: string; Url: string): Integer;
var
  HTTP: TIdHTTP;
  RequestBody: TStringStream;
  ContentType: string;
  Reply: TStream;
  SReply: String;
  p: Integer;
  s2: string;
  // EXperimente
  ast: AnsiString;
  fehler: Integer;
  // ba: array [1 .. 1000] of byte;
begin
  // test HTTP Post
  fehler := 0;
  HTTP := TIdHTTP.Create;
  HTTP.ConnectTimeout := 400000;
  HTTP.ReadTimeout := 400000;

  // HTTP.Request.ContentEncoding := 'UTF-8';//
  HTTP.Request.customheaders.AddValue('Content-Type', 'text/plain; charset=UTF-8');
  // HTTP.Request.ContentEncoding:= 'text/plain; charset=UTF-8';  falsch
  try
    try
      // RequestBody := TStringStream.Create(sJSON, TEncoding.ANSI); // .UTF8);

      // //dient zum Anschauen was sich in den Bytes durch Encoding ändert
      // ast := System.AnsiToUtf8(AnsiString(sJSON));
      ast := AnsiString(sJSON);
      // move(ast[1], ba[1], 2 * length(ast));
      // RequestBody := TStringStream.Create(sJSON, TEncoding.UTF8); // TEncoding.UTF8); // .UTF8);
      RequestBody := TStringStream.Create(ast, TEncoding.UTF8); // TEncoding.UTF8); // .UTF8);
      try
        lbHTTP.Items.Add(HTTP.put(Url, RequestBody));
        lbHTTP.Items.Add(HTTP.ResponseText);
      finally
        RequestBody.Free;
      end;
    except
      on E: EIdHTTPProtocolException do
      begin
        lbHTTP.Items.Add(E.Message + #13#10#13#10 + E.ErrorMessage);
        fehler := 1;
      end;
      on E: Exception do
      begin
        lbHTTP.Items.Add(E.Message);
        fehler := 1;
      end;
    end;
  finally
    HTTP.Free;
  end;
  result := fehler;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  sJSON: string;
begin
  if usersTotal <= 0 then
    exit;
  sJSON := pUsersArray[0].getJSON(serverTyp);
  mJSON.Text := sJSON;
  lblHTTP.Caption := inttostr(length(mJSON.Text));

end;

procedure TForm1.bntOpenTradesToDatabaseClick(Sender: TObject);
// Send All Open Trades To DataBase
var
  sJSON, t: string;
  rest, rptr, rz: Integer;
begin
  // die offenen Trades:pOpenTradesArray, totalOpenTrades

  if totalOpenTrades <> 0 then
  begin
    rest := totalOpenTrades;
    rptr := 0;
    rz := 0;
    repeat
      rz := rest;
      if (rz > 5000) then
        rz := 5000;
      sJSON := pTradesArrayToJSON(pOpenTradesArray, rptr, rptr + rz - 1, 0);
      // keine Fehlerbehandlung !!
      doHTTPPut(sJSON, edHTTPAddress.Text + '/data/actions');
      if chkUserHistoryShowJSON.Checked = true then
        mJSON.Text := sJSON;
      lbHTTP.Items.Add('OpenTrades->DBase');
      rptr := rptr + rz;
      rest := rest - rz;
    until rest = 0;
  end;

end;

procedure TForm1.OpenTradesToDataBaseUser(login: Integer);
var
  i: Integer;
  sJSON: string;
begin
  // alle offenen Trades des Users in die Datenbank schreiben

  sJSON := pTradesArrayToJSON(pOpenTradesArray, 0, totalOpenTrades - 1, login);
  doHTTPPut(sJSON, edHTTPAddress.Text + '/data/actions');
end;

procedure TForm1.btnReadInOutFileClick(Sender: TObject);
// SG11 und SG12 befüllen mit den neuen und weggefallenen Orders
begin
  doReadOrdersInOut('ordersIn.bin', SG11);
  doReadOrdersInOut('ordersOut.bin', SG12);
end;

procedure TForm1.doReadOrdersInOut(fileName: string; SG: TStringGridSorted);
var
  fil: file of TTradeRecord;
  fname: string;
  Stream: TFileStream;
  trades: array of TTradeRecord;
  trade: TTradeRecord;
  n: Integer;
  ps: Integer;
  dir: string;
begin

  try
    try
      fname := ExtractFilePath(paramstr(0)) + fileName;
      Stream := TFileStream.Create(fname, fmOpenRead or fmShareDenyNone);
      // hier sind Grenzen gesetzt - bei 1.2 mio Kursen zB StackOverflow
      n := trunc(Stream.Size / SizeOf(trade));
      if (n > 50000) then
      begin
        debug('zu viele Orders:' + inttostr(n) + ' -> 50000 begrenzt');
        n := 50000;
      end;
      SetLength(trades, n);
      Stream.position := (Stream.Size - n * SizeOf(trade));
      Stream.ReadBuffer(trades[0], n * SizeOf(trade)); // nicht die ganze stream.size !
      doTradesGrid(SG, @trades[0], n, n);
    except
      debug('Fehler bei Kursdarstellung n:' + inttostr(n));
    end;
  finally
    Stream.Free

  end;
  // !! aufpassen hier wird immer das CurrentDir verstellt. Daher alle Dateizugriffe auf den ApplicationPath beziehen !!
  dir := GetCurrentDir;
  debug('Current directory = ' + dir);

end;

procedure TForm1.btnReadQuotesFileClick(Sender: TObject);
var
  fil: file of TKurs;
  fname: string;
  Stream: TFileStream;
  // Kurse: array of TKurs;
  Kurs1: TKurs;
  n: Integer;
  ps: Integer;
  dir: string;
  p1: Integer;
  p2: Integer;
  gt: Cardinal;
  skurs1: Integer;
begin
  try
    try
      fname := FileListBox1.fileName;
      Stream := TFileStream.Create(fname, fmOpenRead or fmShareDenyNone);
      Kurs1.bid := 0;
      // hier sind Grenzen gesetzt - bei 1.2 mio Kursen zB StackOverflow
      n := trunc(Stream.Size / SizeOf(Kurs1));
      lblKursZahl.Caption := inttostr(n);
      if (chkOnlyArray.Checked = false) then
      begin
        if (n > 500000) then
        begin
          debug('zu viele Kurse:' + inttostr(n) + ' -> 500000 begrenzt');
          n := 500000;
        end;
      end;
      // Stream.position := 0;
      // gt := GetTickCount;
      // for p1 := 0 to 1000000 do
      // begin
      // Stream.position := p1;
      // end;
      // debug('1Mio position weitersetzen' + inttostr(GetTickCount - gt));
      //
      // Stream.position := 0;
      // skurs1 := SizeOf(Kurs1);
      // gt := GetTickCount;
      // for p1 := 0 to 1000000 do
      // begin
      // Stream.position := p1;
      // Stream.ReadBuffer(Kurs1, skurs1); // nicht die ganze stream.size !
      //
      // end;
      // debug('1Mio position weitersetzen+read' + inttostr(GetTickCount - gt));
      //
      // Stream.position := 0;
      // skurs1 := SizeOf(Kurs1);
      // gt := GetTickCount;
      // p2 := 0;
      // for p1 := 0 to 100000 do
      // begin
      //
      // Stream.position := p2;
      // Stream.ReadBuffer(Kurs1, skurs1); // nicht die ganze stream.size !
      // p2 := p2 + 10;
      //
      // end;
      // debug('1Mio position weitersetzen stp10 +read' + inttostr(GetTickCount - gt));

      SetLength(chartFileKurse, n);
      Stream.position := (Stream.Size - n * SizeOf(Kurs1)); // immer die hinteren (= aktuellen) Kurse einlesen
      p1 := Stream.position;
      Stream.ReadBuffer(chartFileKurse[0], n * SizeOf(Kurs1)); // nicht die ganze stream.size !
      p2 := Stream.position; // wird weitergesetzt

      if (chkOnlyArray.Checked = true) then
        exit;

      doKursrecordGrid(SG6, chartFileKurse, n);
      doKursChart(LChart, chartFileKurse, n);
      // der Chart wird begrenzt auf 20000 und darüber schrittweise Daten ausgelassen
    except
      debug('Fehler bei Kursdarstellung n:' + inttostr(n));
    end;
  finally
    Stream.Free

  end;
  // !! aufpassen hier wird immer das CurrentDir verstellt. Daher alle Dateizugriffe auf den ApplicationPath beziehen !!
  dir := GetCurrentDir;
  debug('Current directory = ' + dir);
end;

procedure TForm1.btnStopQuoteGridUpdateClick(Sender: TObject);
begin
  stopKursGrid;

end;

procedure TForm1.startAll();
var
  ret: Integer;
begin
  ret := initConnection(manapi, 'Pumping'); // 1=pump 2=direct
  ret := initConnection(manapi2, 'Direct'); // 1=pump 2=direct
  // artConnection(1 + 2);
  if willPumping = true then
    ret := StartPumping();
end;

function TForm1.OrderTypes(cmd: Integer): string;
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

  else
    result := inttostr(cmd);

  end;
end;

procedure TForm1.PageControl1Resize(Sender: TObject);
begin

  Panel4.Width := (PageControl1.Width - Panel3.Width) div 2;
  Panel5.Width := (PageControl1.Width - Panel3.Width) div 2;
end;

procedure TForm1.Panel16Resize(Sender: TObject);
begin
  SG7.Width := Panel16.Width div 2;
  SG8.Left := Panel16.Width div 2;
  SG8.Width := Panel16.Width div 4;
  SG9.Left := (Panel16.Width div 4) * 3;
  SG9.Width := Panel16.Width div 4;

  SG7.Height := Panel16.Height - SG7.Top;
  SG8.Height := Panel16.Height - SG8.Top;
  SG9.Height := Panel16.Height - SG9.Top;

  Label11.Left := Panel16.Width div 2;
  Label12.Left := (Panel16.Width div 4) * 3;
end;

procedure TForm1.writeUsersStream();
var
  dataLength: LongWord;
  Stream: TStream;
  fileMode: Integer;
  fileName: AnsiString;
begin

  try
    fileName := ExtractFilePath(paramstr(0)) + 'users_' + serverShort[serverTyp] + '.bin';
    { if fileexists(fName) then
      fm:=fmOpenWrite
      else
      fm:=fmCreate;
    }
    // IMMER NEU SCHREIBEN damit hinten auch alles überschrieben wird !
    fileMode := fmCreate;
    Stream := TFileStream.Create(fileName, fileMode);
    dataLength := usersTotal * SizeOf(pUsersArray[0]); // Trades.Length;
    Stream.WriteBuffer(Pointer(pUsersArray)^, dataLength); // L * SizeOf(Trades[0]));
    Stream.Free; // Speicher freigeben
  except
    debug('F:writeUsersStream');
  end;
end;

procedure TForm1.doRequestUsers();
var
  total: Integer;
  i: Integer;
begin

  total := 0;
  if pUsersArray <> nil then
  begin
    manapi2.MemFree(pUsersArray);
    pUsersArray := nil; // prüfen
    total := 0;
  end;

  i := manapi2.IsConnected();
  if i <> 1 then
  begin
    lbUsers.Items.Add('manapi2 not connected!');

  end;

  pUsersArray := manapi2.UsersRequest(total);
  usersTotal := total;

  writeUsersStream;

  doUsersGrid(SG10, pUsersArray, total);

  lbUsers.Items.Clear;
  for i := 0 to total - 1 do
  begin
    lbUsers.Items.Add(inttostr(pUsersArray[i].login) + ':' + pUsersArray[i].name);
  end;

  if lbUsers.Items.count > 0 then
  begin
    lbUsers.ItemIndex := 0;
    lbUsersClick(nil);
  end;
  Label9.Caption := 'Z:' + inttostr(total);
end;

procedure TForm1.vergleich(var s1: array of TTradeRecord; var s2: array of TTradeRecord; var s1c: longint;
  var s2c: longint);
var
  gt: longint;
  l: longint;
  s1p: longint;
  s2p: longint;
  v: longint;
  pweg: array of smallint;
  phin: array of smallint;
  weg: longint;
  hin: longint;
  gleich: longint;
  f1: array of smallint;
  f2: array of smallint;
  // pass2 nochmal alle vergleichen
  mweg: longint;
  mhin: longint;
  k: Integer;
  merks1p, merks2p: Integer;

  ratioFlag: Boolean;
  debug_: Boolean;
begin
  try
    // ein wenig History soll in der Liste zu sehen sein
    if lbStatisticsPump.Items.count > 20 then
      lbStatisticsPump.Items.Clear;

    if (s1c = 0) or (s2c = 0) then
    begin
      lbStatisticsPump.Items.Add('erster Tradevergleich keine Vergleichswerte - Abbruch ...');
      exit;
    end;
    WriteLog('Start Vergleich...');
    gt := GetTickCount();
    SetLength(pweg, s1c);
    SetLength(phin, s2c);
    weg := 0;
    hin := 0;
    debug_ := chkShowTrades.Checked;
    if debug_ then
    begin
      lbStatisticsWP.Items.Clear;
      for k := 0 to s2c - 1 do
      begin
        lbStatisticsWP.Items.Add(inttostr(k) + ' ' + inttostr(s2[k].order) + ' ' + inttostr(s2[k].cmd) + ' ' +
          inttostr(s2[k].volume));
      end;
      // jetzt sind beide Listen gefüllt. Reihenfolge unverändert aber Teile aus Liste 1 entfernt und dafür neue in Liste2 hinzu
    end;

    SetLength(f1, s1c);
    SetLength(f2, s2c);
    s1p := -1;
    s2p := -1;
    repeat
      s1p := s1p + 1;
      merks2p := s2p;
      v := s1[s1p].order;
      for s2p := s2p + 1 to s2c - 1 do
      begin
        if (s2[s2p].order = v) then
        begin
          // Treffer
          f1[s1p] := 1;
          f2[s2p] := 1;
          break;
        end
        else
        begin
          // weitersuchen
          // Debug.Print "."; s2p;
        end;
      end;
      if (s2p > s2c - 1) then
      begin
        // nicht gefunden in s2
        f1[s1p] := 2; // nicht gefunden
        weg := weg + 1;
        pweg[weg] := s1p;
        s2p := merks2p;
      end;
    until (s1p >= s1c - 1); // eigentlich = aber >= ist besser um ja keine endlose Schleife zu bekommen
    for k := 0 to s1c - 1 do
    begin
      if (f1[k] = 2) then
      begin
        if debug_ then
        begin
          lbStatisticsPump.Items.Add('aus 1 raus:' + inttostr(k) + '=' + inttostr(s1[k].order));
        end;
      end;
    end;
    for k := 0 to s2c - 1 do
    begin
      if (f2[k] = 0) then
      begin
        // ok kommt vor
        if debug_ then
        begin
          lbStatisticsPump.Items.Add('in  2 rein:' + inttostr(k) + '=' + inttostr(s2[k].order));
        end;
        hin := hin + 1;
        phin[hin] := k;
      end;
    end;
    if (s1c = s2c) then
    begin
      if (hin = 0) and (weg = 0) then
      begin
        if debug_ then
        begin
          lbStatisticsPump.Items.Add('unverändert' + inttostr(s1c));
        end;
      end
      else
      begin
        if debug_ then
        begin
          lbStatisticsPump.Items.Add('hin:' + inttostr(hin) + ' weg:' + inttostr(weg));
        end;
      end;
    end;
    mweg := weg;
    mhin := hin;
    // lbStatisticsPump.Items.Add('pass2');
    for k := 1 to weg do
    begin
      if (f1[pweg[k]] = 2) then
      begin
        v := s1[pweg[k]].order;
        for l := 1 to hin do
        begin
          if (s2[phin[l]].order = v) then
          begin
            // Treffer
            if debug_ then
            begin
              lbStatisticsPump.Items.Add('doch noch treffer:' + inttostr(v));
            end;
            mweg := mweg - 1;
            mhin := mhin - 1;
            f1[pweg[k]] := 1;
            f2[phin[l]] := 1;
          end;
        end;
      end;
    end;
    for k := 1 to hin do
    begin
      if (f2[phin[k]] = 0) then
      begin
        v := s2[phin[k]].order;
        for l := 1 to weg do
        begin
          if (s1[pweg[l]].order = v) then
          begin
            // Treffer
            if debug_ then
            begin
              lbStatisticsPump.Items.Add('doch noch treffer:' + inttostr(v));
            end;
            mhin := mhin - 1;
            f2[phin[k]] := 1;
            f1[pweg[l]] := 1;
          end;
        end;
      end;
    end;
    lbStatisticsPump.Items.Add('Am Ende hin:' + inttostr(mhin) + ' weg:' + inttostr(mweg));
    // und den

    // hier wird geprüft ob die in der Ratio aufgeführten Instrumente von den Änderungen betroffen sind

    for k := 1 to weg do
    begin
      if (f1[pweg[k]] = 2) then
      begin
        WriteLog('aus 1 raus:' + inttostr(pweg[k]) + '=' + inttostr(s1[pweg[k]].order));
        // schreibt in File aber auch in die Datenbank nachdem vorher die History geholt wurde
        merkOrderInOut(1, s1[pweg[k]]);
        checkRatioSymbols(s1[pweg[k]].symbol);
      end;
    end;
    for k := 1 to hin do
    begin
      if (f2[phin[k]] = 0) then
      begin
        // ok kommt vor
        WriteLog('in  2 rein:' + inttostr(phin[k]) + '=' + inttostr(s2[phin[k]].order));
        merkOrderInOut(0, s2[phin[k]]);
        checkRatioSymbols(s2[phin[k]].symbol);
      end;
    end;
    lbStatisticsPump.Items.Add('Z:' + floattostr((GetTickCount - gt) / 10));
    WriteLog('Ende Vergleich');

    if lsRatioCount = 0 then
      updateLSRatio;
    lsRatioCount := lsRatioCount + 1;
    if lsRatioChanged = true then
      updateLSRatio;

    exit;
  except
    On E: Exception do
    begin
      debug('Exception class name = ' + E.ClassName);
      debug('Exception message = ' + E.Message);
    end
    else
      debug('unbekannter Fehler in vergleich');
  end;
end;

procedure TForm1.updateLSRatio();
var
  i: Integer;
  ctLong, ctShort: Integer;
  ctLong2, ctShort2: Integer;
  ctLong3, ctShort3: Integer;
  ctb: Integer;
  typ: Integer;
  ratio: single;
  line: string;
begin
  ctLong := 0;
  ctShort := 0;
  ctLong2 := 0;
  ctShort2 := 0;
  ctLong3 := 0;
  ctShort3 := 0;
  ctb := 0;
  ratio := 0;
  lsRatioChanged := false;
  // tradesNeu[] und tradesNeuCt
  for i := 0 to tradesNeuCt - 1 do
  begin
    if containstext(lsRatioSymbols, tradesNeu[i].symbol + ';') then
    begin
      case tradesNeu[i].cmd of
        0:
          // result := 'BUY';
          ctLong := ctLong + 1;
        1:
          // result := 'SELL';
          ctShort := ctShort + 1;
        2:
          // result := 'BUY Limit';
          ctLong2 := ctLong2 + 1;
        3:
          // result := 'SELL Limit';
          ctShort2 := ctShort2 + 1;
        4:
          // result := 'BUY Stop';
          ctLong3 := ctLong3 + 1;
        5:
          // result := 'SELL Stop';
          ctShort3 := ctShort3 + 1;
        6:
          // result := 'BALANCE';
          ctb := ctb + 1;
      end;
    end;
  end;
  if ctShort <> 0 then
    ratio := int(ctLong / ctShort * 100) / 100;
  line := DateTimeToStr(now) + ';' + formatfloat('0.##', ratio) + ';' + inttostr(ctLong) + ';' + inttostr(ctShort) + ';'
    + inttostr(ctLong2) + ';' + inttostr(ctShort2) + ';' + inttostr(ctLong3) + ';' + inttostr(ctShort3) + ';';
  lbLSRatio.Items.Add(line);

end;

procedure TForm1.checkRatioSymbols(s: TStr12);
var
  s1, s2: string;
begin
  s1 := s + ';';
  s2 := lsRatioSymbols;
  if containstext(s2, s1) = true then
    lsRatioChanged := true;

end;

procedure TForm1.chkAutoTimeClick(Sender: TObject);
begin
  autoTime := chkAutoTime.Checked;
  getNextAutoTime;
end;

procedure TForm1.getNextAutoTime;
var
  i: Integer;
begin
  i := comAutoTime.ItemIndex;
  case i of
    0:
      begin
        nextAutoTime := trunc(now) + 1 + 1 / 86400;
        while (dayofweek(nextAutoTime) = 1) or (dayofweek(nextAutoTime) = 2) do
        // So 00:00:01 oder Mo 00:00:01  nicht anwenden
        begin
          nextAutoTime := nextAutoTime + 1;
        end;

      end;
    1:
      begin
        nextAutoTime := (trunc(now * 2) + 1) / 2;

      end;
    2:
      begin
        nextAutoTime := (trunc(now * 24) + 1) / 24;

      end;
    3:
      begin
        nextAutoTime := (trunc(now * 96) + 1) / 96;

      end;
    4:
      begin
        nextAutoTime := (trunc(now * 288) + 1) / 288;
      end;
    5:
      begin
        nextAutoTime := (trunc(now * 1440) + 1) / 1440;
      end;

  end;
end;

procedure TForm1.performAutoTime;
begin
  // Loop all Brokers
  Button14Click(nil);

end;

procedure TForm1.merkOrderInOut(typ: Integer; r: TTradeRecord);
// Typ=0 In-Order
// Typ=1 Out-Order
var
  Str: AnsiString;
  k, i: Integer;
  dataLength: LongWord;
  Stream: TStream;
  fileMode: Integer;
  fileName: AnsiString;
  ds: string;
  merks1, merks2: string;
begin

  if saveHistoryInProgress = true then
    exit;

  begin
    try
      if typ = 0 then
        fileName := ExtractFilePath(paramstr(0)) + 'ordersIn.bin'
      else
        fileName := ExtractFilePath(paramstr(0)) + 'ordersOut.bin';
      if fileexists(fileName) then
        fileMode := fmOpenWrite
      else
        fileMode := fmCreate;
      Stream := TFileStream.Create(fileName, fileMode);
      dataLength := SizeOf(r); // Trades.Length;    224
      Stream.Seek(0, soFromEnd); // ans Ende gehen
      Stream.WriteBuffer(r, dataLength); // L * SizeOf(Trades[0]));
      Stream.Free; // Speicher freigeben
    finally

    end;

    // Daten aus History holen und in die Datenbank

    if userHistorySendDatabase = true then
    begin
      if typ = 0 then
      begin
        OpenTradesToDataBaseUser(r.login);
      end
      else
      begin
        // texte merken und wiederherstellen
        // erforderlich wenn Tradeupdate in Historyupload reinfunkt
        merks1 := edHistoryDateFrom.Text;
        merks2 := edHistoryDateTo.Text;

        edHistoryUserId.Text := inttostr(r.login);
        ds := FormatDateTime('dd.mm.yyyy hh:mm:ss', now - 1);
        edHistoryDateFrom.Text := ds;
        ds := FormatDateTime('dd.mm.yyyy hh:mm:ss', now + 1);
        edHistoryDateTo.Text := ds;
        btnSaveUserHistoryClick(nil);

        edHistoryDateFrom.Text := merks1;
        edHistoryDateTo.Text := merks2;

      end;
    end;
  end;
end;

procedure TForm1.mHTTPClick(Sender: TObject);
begin
  // mHTTP.clear;
end;

procedure TForm1.mHTTPDblClick(Sender: TObject);
begin
  mHTTP.Clear;
end;

procedure TForm1.readInit();
var
  Ini: TIniFile;
begin
  // exit;
  // der Application.exename ist bereits der vollständige Pfad ! und nicht nur der 'exeName'
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
    Left := Ini.ReadInteger('Form', 'Left', 100);
    Height := Ini.ReadInteger('Form', 'Height', 200);
    if Ini.ReadBool('Form', 'InitMax', false) then
      WindowState := wsMaximized
    else
      WindowState := wsNormal;

    Top := Ini.ReadInteger('Form', 'Top', 100);
    Width := Ini.ReadInteger('Form', 'Width', 300);
    // Caption := Ini.ReadString('Form', 'Caption', 'FT Collector');
    serverTyp := Ini.ReadInteger('Form', 'ServerTyp', 0);
    workDirect := Ini.ReadBool('Form', 'workDirect', true);
    workTicks := Ini.ReadBool('Form', 'workTicks', true);
    ticksToServer := Ini.ReadBool('Form', 'TicksToServer', true);
    workTrades := Ini.ReadBool('Form', 'workTrades', true);
    workOpenOrders := Ini.ReadBool('Form', 'workOpenOrders', true);
    userHistorySendDatabase := false;
    // Ini.ReadBool('Form', 'userHistorySendDatabase', true); Beim Start nie sofort Daten senden !! Neu 6.5.19
    userHistoryToFile := Ini.ReadBool('Form', 'userHistoryToFile', true);
    autoTime := Ini.ReadBool('Form', 'autoTime', false);
    autoTimeIndex := Ini.ReadInteger('Form', 'autoTimeIndex', 4);
    chkWorkTicks.Checked := workTicks;
    chkWorkTrades.Checked := workTrades;
    chkWorkDirect.Checked := workDirect;
    chkTicksToServer.Checked := ticksToServer;
    chkWorkOpenOrders.Checked := workOpenOrders;
    chkUserHistorySendDatabase.Checked := userHistorySendDatabase;
    chkUserHistoryToFile.Checked := userHistoryToFile;
    chkAutoTime.Checked := autoTime;
    comAutoTime.ItemIndex := autoTimeIndex;
  finally
    Ini.Free;
  end;
end;

procedure TForm1.saveInit();
var
  Ini: TIniFile;
begin
  // exit;

  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
    Ini.WriteInteger('Form', 'Top', Top);
    Ini.WriteInteger('Form', 'Left', Left);
    Ini.WriteInteger('Form', 'Height', Height);
    Ini.WriteInteger('Form', 'Width', Width);
    // Ini.WriteString('Form', 'Caption', 'FT Collector');
    Ini.WriteBool('Form', 'InitMax', WindowState = wsMaximized);
    Ini.WriteInteger('Form', 'ServerTyp', serverTyp);
    Ini.WriteBool('Form', 'workDirect', workDirect);
    Ini.WriteBool('Form', 'workTicks', workTicks);
    Ini.WriteBool('Form', 'TicksToServer', ticksToServer);
    Ini.WriteBool('Form', 'workTrades', workTrades);
    Ini.WriteBool('Form', 'workOpenOrders', workOpenOrders);

    Ini.WriteBool('Form', 'userHistorySendDatabase', userHistorySendDatabase);
    Ini.WriteBool('Form', 'userHistoryToFile', userHistoryToFile);
    Ini.WriteBool('Form', 'autoTime', autoTime);
    Ini.WriteInteger('Form', 'autoTimeIndex', autoTimeIndex);

  finally
    Ini.Free;
  end;
end;

procedure TForm1.SortStringGrid(var GenStrGrid: TStringGridSorted; ThatCol: Integer; sortTyp: Integer);

const
  // Define the Separator
  TheSeparator = '@';
var
  CountItem, i, j, k, ThePosition: Integer;
  MyList: TStringList;
  MyString, TempString: string;
begin
  // Give the number of rows in the StringGrid
  CountItem := GenStrGrid.RowCount;
  // Create the List
  MyList := TStringList.Create;
  MyList.Sorted := false;
  try
    begin
      for i := 1 to (CountItem - 1) do
        // zB 1.234@name|test|kurs|usw
        MyList.Add(GenStrGrid.Rows[i].Strings[ThatCol] + TheSeparator + GenStrGrid.Rows[i].Text);

      // Sort the List

      if (sortTyp = -1) then
        MyList.CustomSort(StringListSortComparefnDown);
      if (sortTyp = 1) then
        MyList.CustomSort(StringListSortComparefnUp);
      // MyList.sort;

      for k := 1 to MyList.count do
      begin
        // Take the String of the line (K – 1)
        MyString := MyList.Strings[(k - 1)];
        // Find the position of the Separator in the String
        ThePosition := pos(TheSeparator, MyString);
        TempString := '';
        { Eliminate the Text of the column on which we have sorted the StringGrid }
        TempString := Copy(MyString, (ThePosition + 1), length(MyString));
        MyList.Strings[(k - 1)] := '';
        MyList.Strings[(k - 1)] := TempString;
      end;

      // Refill the StringGrid
      for j := 1 to (CountItem - 1) do
        GenStrGrid.Rows[j].Text := MyList.Strings[(j - 1)];
    end;
  finally
    // Free the List
    MyList.Free;
  end;

end;

procedure TForm1.SortStringGridCW(var GenStrGrid: TStringGridSorted; ThatCol: Integer; sortTyp: Integer);

const
  // Define the Separator
  TheSeparator = '@';
var
  CountItem, i, j, k, ThePosition: Integer;
  MyList: TStringList;
  MyString, TempString: string;
  da: doubleArray;
  ia: intArray;
  gt: Cardinal;
begin
  // Give the number of rows in the StringGrid
  CountItem := GenStrGrid.RowCount;
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
        da[i - 1] := myStringToFloat(GenStrGrid.Rows[i].Strings[ThatCol]);
        // da[i - 1] := StrToFloat(GenStrGrid.Rows[i].Strings[ThatCol]);   // !! muss aber auch ein passendes Feld sein !!
        ia[i - 1] := i;
      end;
      // in da[] sind nun ab 0 bis countItem-2  die Werte von Row 1 bis countItem-1 enthalten  Row 0 bleibt - da ist der Header drin
      // Sort the List
      gt := GetTickCount();
      if (sortTyp = -1) then
        // MyList.CustomSort(StringListSortComparefnDown);
        FastSort2Array(da, ia, 'VUA');
      if (sortTyp = 1) then
        FastSort2Array(da, ia, 'VDA');
      LbDebug.Items.Add('Sort:' + inttostr(GetTickCount - gt));
      gt := GetTickCount();
      for k := 0 to CountItem - 1 do
      begin
        MyList.Add(GenStrGrid.Rows[k].Text);
        // MyList ist nun quasi die Kopie des StringGrids ab unterhalb der Überschrift
      end;
      LbDebug.Items.Add('Mylist:' + inttostr(GetTickCount - gt));
      gt := GetTickCount();

      for k := 1 to CountItem - 1 do
      begin
        GenStrGrid.Rows[k].Text := MyList.Strings[ia[k - 1]];
      end;
      LbDebug.Items.Add('Grid neu:' + inttostr(GetTickCount - gt));

    end;
  finally
    // Free the List
    MyList.Free;
  end;

end;

function StringListSortComparefnUp(List: TStringList; Index1, Index2: Integer): Integer;
var
  i1, i2: double;
  s1, s2: string;
  cs: Integer;
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

function StringListSortComparefnDown(List: TStringList; Index1, Index2: Integer): Integer;
var
  i1, i2: double;
  s1, s2: string;
  cs: Integer;
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
// kommt mit . UND , klar. Die jeweils 'falsche' Variante wird in die laut FormatSettings.DecimalSeparator gültige übersetzt !!
// das wird dann aber logischerweise langsamer werden
var
  i: Integer;
  ok: Boolean;
  ds, ds2: Char;

  sc: Integer;

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

function TForm1.WriteLog(LogString: String): Integer;
var
  f: TextFile;
  Datum: TDateTime;
  d: AnsiString;
begin
  if noLogFile = true then
    exit;

  Datum := now;
  d := FormatDateTime('dd.mm.yyyy hh:mm:ss', Datum);

{$IOCHECKS OFF}
  // ParamStr(0) ist immer der Pfad und Name der Exe Datei
  AssignFile(f, ExtractFilePath(paramstr(0)) + LOGFILE);
  if fileexists(ExtractFilePath(paramstr(0)) + LOGFILE) then
    Append(f)
  else
    Rewrite(f);
  WriteLn(f, d + ' ' + LogString);
  CloseFile(f);
  result := GetLastError();
{$IOCHECKS ON}
end;

procedure TForm1.dosleep(t: Integer);
var
  gt: Cardinal;
begin
  gt := GetTickCount();
  repeat
    Application.ProcessMessages;
  until (GetTickCount - gt) > t;
  lbStatisticsPump.Items.Add('sleep rum');
end;

procedure TForm1.csvToStringgridSorted(fname: string; var SG: TStringGridSorted);
var
  sl: TStringList;
  header: string;
  Splitted: TArray<String>;
  i, j: Integer;
begin
  sl := TStringList.Create;
  try
    sl.LoadFromFile(fname);
    if sl.count > 0 then
    begin
      SG.RowCount := 2;
      header := sl[0];
      Splitted := header.Split([';']);
      SG.ColCount := length(Splitted);
      for j := 0 to length(Splitted) - 1 do
        SG.cells[j, 0] := Splitted[j];
      SG.RowCount := sl.count;
      for i := 0 to sl.count - 1 do
      begin
        Splitted := sl[i].Split([';']);
        for j := 0 to length(Splitted) - 1 do
          SG.cells[j, i] := Splitted[j];

      end;
    end;
    sl.Free;
  except
    // die Datei gibt es nicht !
    SG.RowCount := 1;
    SG.ColCount := 1;
    SG.cells[0, 0] := 'File???';
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  Button1Click(Button1);
  Button1Click(Button2);
  Button1Click(Button3);
  AutoSizeGrid(SG8);
  AutoSizeGrid(SG9);
  AutoSizeGrid(SG10);

end;

procedure TForm1.AutoSizeGrid(Grid: TStringGridSorted);
const
  ColWidthMin = 10;
var
  c, r, w, ColWidthMax: Integer;
begin
  for c := 0 to Grid.ColCount - 1 do
  begin
    ColWidthMax := ColWidthMin;
    for r := 0 to (Grid.RowCount - 1) do
    begin
      w := Grid.Canvas.TextWidth(Grid.cells[c, r]);
      if w > ColWidthMax then
        ColWidthMax := w;
    end;
    Grid.ColWidths[c] := ColWidthMax + 5;
  end;
end;

procedure TForm1.saveCacheFile;
var
  folder: string;
  fileName: string;
  fstream: TStream;
  l: Integer;
  gt: Cardinal;
begin
  try
    gt := GetTickCount();
    folder := ExtractFilePath(paramstr(0)) + 'cache';
    createDir(folder);
    fileName := folder + '\' + cbCacheFileName.Text + '.bin';
    fstream := TFileStream.Create(fileName, fmCreate);
    l := SizeOf(tradesCache[0]);
    fstream.WriteBuffer(tradesCache[0], l * tradesCacheCt); // nicht 1 mehr ?

  finally
    fstream.Free;
  end;
  lbDebug3.Items.Add('Zeit SaveCacheFile:' + inttostr(GetTickCount() - gt));
end;

procedure TForm1.testInt;
var
  a: array of Integer;
  folder: string;
  fileName: string;
  fstream: TStream;
  gt: Cardinal;
begin

  try
    SetLength(a, 10000000);
    gt := GetTickCount();
    folder := ExtractFilePath(paramstr(0)) + 'cache';
    createDir(folder);
    fileName := folder + '\testint.bin';
    fstream := TFileStream.Create(fileName, fmCreate);
    fstream.WriteBuffer(a[0], 40000000); // nicht 1 mehr ?

  finally
    fstream.Free;
  end;
  lbDebug3.Items.Add('Zeit SaveCacheFile:' + inttostr(GetTickCount() - gt));

  try
    SetLength(a, 65000000);
    gt := GetTickCount();
    folder := ExtractFilePath(paramstr(0)) + 'cache';
    createDir(folder);
    fileName := folder + '\testint2.bin';
    fstream := TFileStream.Create(fileName, fmCreate);
    fstream.WriteBuffer(a[0], 260000000); // nicht 1 mehr ?

  finally
    fstream.Free;
  end;
  lbDebug3.Items.Add('Zeit SaveCacheFile:' + inttostr(GetTickCount() - gt));

end;

procedure TForm1.loadCacheFile;
var
  folder: string;
  fileName: string;
  fstream: TStream;
  gt: Cardinal;
  FSize: Integer;
  p0: Pointer;
  tr: TTradeRecord;
begin
  try
    gt := GetTickCount();
    folder := ExtractFilePath(paramstr(0)) + 'cache';
    createDir(folder);
    fileName := folder + '\' + cbCacheFileName.Text + '.bin';
    if fileexists(fileName) then
    begin
      fstream := TFileStream.Create(fileName, fmOpenRead or fmShareDenyNone);
      FSize := fstream.Size;
      tradesCacheCt := trunc(fstream.Size / SizeOf(tr));
      SetLength(tradesCache, tradesCacheCt);
      // Stream.position := (Stream.Size - n * SizeOf(Trade));
      fstream.ReadBuffer(tradesCache[0], tradesCacheCt * SizeOf(tr)); // nicht die ganze stream.size !
    end
    else
    begin
      showmessage('Die Datei existiert nicht');
    end;
  finally
    if fileexists(fileName) then
      fstream.Free;
  end;
  lbDebug3.Items.Add('Zeit LoadCacheFile:' + inttostr(GetTickCount() - gt));
  p0 := @tradesCache[0];

end;

procedure TForm1.ClearStringGridSorted(const Grid: TStringGridSorted);
var
  c, r: Integer;
begin
  for c := 0 to Pred(Grid.ColCount) do
    for r := 0 to Pred(Grid.RowCount) do
      Grid.cells[c, r] := '';
end;

procedure SwapRowField(rf: array of Integer; fr: array of Integer; von, nach: Integer);
var
  max: Integer;
  i, merk: Integer;
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

function cwpos(const s: string; c: Char): Integer;
var
  i: Integer;
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

procedure generateMinutes(var ticks: array of TKurs; var mBars: aKursOCHL; minutes: Integer);
var
  i: Integer;
  tick: TKurs;
  open, high_, low, close: single;
  cseconds: Integer;
  secint: Integer; // das Intervall seit 1970 aus diesen Seconds  secint*cseconds-> die genaue Uhrzeit/Datum
  merksecint: Integer;
  mbc: Integer;
  mbmax: Integer;
  tmax: Integer;
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

initialization

// ---- register pumping message
ExtPumpingMsg := RegisterWindowMessage('DelphiPumpingMessage');

end.
