unit Unit3;

interface

uses
  Classes, Windows, idHTTP;

type
  TTickWorker = class(TThread)
  private
    { Private declarations }
    FStartNum: integer;
  protected
    procedure Execute; override;
    function doHTTPPut(sJSON: string; Url: string; lbHTTP: TStringList): integer;
    procedure doTheWork;
    procedure debug(s:string);
  public
    property StartNum: integer read FStartNum write FStartNum;
  end;

implementation

uses FTPumping2, SysUtils;

procedure TTickWorker.debug(s: string);
begin
  EnterCriticalSection(tickworkerdebugcriticalSection);//einmal anschalten und das bleibt dann
    form1.debug(s);
  leaveCriticalSection(tickworkerdebugcriticalSection);
end;

function TTickWorker.doHTTPPut(sJSON: string; Url: string; lbHTTP: TStringList): integer;
var
  HTTP: TIdHTTP;
  RequestBody: TStringStream;
  ContentType: string;
  Reply: TStream;
  SReply: String;
  p: integer;
  s2: string;
  ast: AnsiString;
  fehler: integer;
begin
  fehler := 0;
  lbHTTP.Clear;
  lbHTTP.Add('start');
  HTTP := TIdHTTP.Create;
  HTTP.ConnectTimeout := 400000;
  HTTP.ReadTimeout := 400000;
  HTTP.Request.customheaders.AddValue('Content-Type', 'text/plain; charset=UTF-8');
  // HTTP.Request.ContentEncoding:= 'text/plain; charset=UTF-8';  falsch
  try
    try
      ast := AnsiString(sJSON);
      // move(ast[1], ba[1], 2 * length(ast));
      RequestBody := TStringStream.Create(ast, TEncoding.UTF8);
      try
        lbHTTP.Add(HTTP.put(Url, RequestBody));
        lbHTTP.Add(HTTP.ResponseText);
      finally
        RequestBody.Free;
      end;
    except
      on E: EIdHTTPProtocolException do
      begin
        lbHTTP.Add(E.Message + #13#10#13#10 + E.ErrorMessage);
        fehler := 1;
      end;
      on E: Exception do
      begin
        lbHTTP.Add(E.Message);
        fehler := 1;
      end;
    end;
  finally
    HTTP.Free;
  end;
  result := fehler;
end;

procedure TTickWorker.doTheWork;
// TickPufferThreadPNr:integer;
// TickPufferThreadPA:paTTick;
// TickPufferThreadCt:integer;
var
  k, l: integer;
  s: string;
  gt: Cardinal;
  fehler: integer;
  ct: integer;
  pa: PATTick;
  Url: string;
  list: TStringList;
  errFlag: boolean;
begin
  errFlag := false;
  form1.debugThread('WorkerThread doTheWork');

  fehler := 0;
  gt := GetTickCount;
  //**** beginn CS ****
  EnterCriticalSection(tickworkercriticalSection);
  ct := TickPufferThreadCt;
  pa := TickPufferThreadPA;
  Url := TickPufferThreadURL;
  list := TickPufferThreadResultList;
  s := '[';
  for k := 0 to ct - 2 do
  begin
    s := s + pa^[k].getJSON + ',';
  end;
  s := s + pa^[ct - 1].getJSON + ']';
  leaveCriticalSection(tickworkercriticalSection);
  // versenden
  // form1.debug('sende Puffer ' + inttostr(pnr) + ' T:' + inttostr(ct) + ' B:' + inttostr(length(s)));
  repeat
    EnterCriticalSection(tickworkercriticalSection);
    fehler := doHTTPPut(s, Url, list);
    leaveCriticalSection(tickworkercriticalSection);
    if fehler <> 0 then
    begin
      errFlag := true;
      form1.debug('WorkerThread can''t send ...');
      sleep(5000);
      EnterCriticalSection(tickworkercriticalSection);
        Url := TickPufferThreadURL;
      leaveCriticalSection(tickworkercriticalSection);
    end
    else
    begin
      form1.debug('WorkerThread sent:' + inttostr(ct) + ' ticks');

    end;

  until fehler = 0;
  if errFlag = true then
  begin
    form1.debug('WorkerThread could send again');
  end;
  // an dieser Stelle kann nun noch die Datei falls vorhanden gesendet werden
  // der Name wird in diesem Fall aber in einer Variablen TickPufferThreadFileName mitgeteilt
  if(tickpufferthreadfilename<>'') then
  begin

  end;
  TickPufferThreadOrderBusy := false;
  leaveCriticalSection(tickworkercriticalSection);
  //**** ende CS ****

end; (*

*)

procedure TTickWorker.Execute;

var
  CurrentNum: integer;
  gt: Cardinal;
  msg: TMsg;
  flag: boolean;
  busy: boolean;
  ct: integer;
begin
  flag := true;
  ct := 0;
  gt := GetTickCount;
  debug('Thread started');
  while not terminated do
  begin
    EnterCriticalSection(tickworkercriticalSection);
      busy := TickPufferThreadOrderBusy;
    leaveCriticalSection(tickworkercriticalSection);
    if busy = true then
    begin
      doTheWork();
    end;
    sleep(100);
    inc(ct);
    if (ct mod 100) = 0 then
    begin
      debug('WorkerThread wartet..');
    end;

  end;
  debug('Thread terminated');

end;

end.
