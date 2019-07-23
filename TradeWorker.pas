unit TradeWorker;

interface

uses
  Classes, Windows,doHTTP;

type
  TTradeWorker = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    //function doHTTPPut(sJSON: string; Url: string; slDebug: TStringList): integer;
    procedure doTheWork;
    procedure debug(s:string);
  public
  end;

implementation

uses FTPumping2, SysUtils;

procedure TTradeWorker.debug(s: string);
//die Debugmeldungen werden an das Hauptprogramm weitergereicht
begin
  EnterCriticalSection(tickworkerdebugcriticalSection);//einmal anschalten und das bleibt dann
    form1.debugThread(s);
  leaveCriticalSection(tickworkerdebugcriticalSection);
end;



procedure TTradeWorker.doTheWork;
// TickWorkerPNr:integer;
// TickWorkerPA:paTTick;
// TickWorkerCt:integer;
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
  debug('WorkerThread doTheWork');

  fehler := 0;
  gt := GetTickCount;
  //**** beginn CS ****
  EnterCriticalSection(tickworkercriticalSection);
  ct := TickWorkerCt;
  pa := TickWorkerPA;
  Url := TickWorkerURL;
  list := TickWorkerResultList;
  //den JSON String aus dem Tickarray zusammenbauen
  s := '[';
  for k := 0 to ct - 2 do
  begin
    s := s + pa^[k].getJSON + ',';
  end;
  s := s + pa^[ct - 1].getJSON + ']';
  leaveCriticalSection(tickworkercriticalSection);
  // versenden
  // debug('sende Puffer ' + inttostr(pnr) + ' T:' + inttostr(ct) + ' B:' + inttostr(length(s)));
  repeat
    EnterCriticalSection(tickworkercriticalSection);
      fehler := doHTTPPut(s, Url, list);
    leaveCriticalSection(tickworkercriticalSection);
    if fehler <> 0 then
    begin
      //wenn nicht gesendet werden konnte
      errFlag := true;
      debug('WorkerThread can''t send ...');
      // 5 Sekunden warten bis erneuter Versuch
      sleep(5000);
      EnterCriticalSection(tickworkercriticalSection);
      // nochmal die aktuelle URL übernehmen (darüber steuere letztlich ich den Fehlertest)
        Url := TickWorkerURL;
      leaveCriticalSection(tickworkercriticalSection);
    end
    else
    begin
      debug('WorkerThread sent:' + inttostr(ct) + ' ticks');

    end;

  until ((fehler = 0) or (terminated=true));

  if errFlag = true then
  begin
    debug('WorkerThread could send again');
  end;

  if (terminated=true) then
    debug('Thread wurde terminiert - doTheWork wird beendet');

  // an dieser Stelle kann nun noch die Datei falls vorhanden gesendet werden
  // der Name wird in diesem Fall aber in einer Variablen TickWorkerFileName mitgeteilt
  if(TickWorkerfilename<>'') then
  begin
  //war so eine Idee ...
  end;

  EnterCriticalSection(tickworkercriticalSection);
    TickWorkerRequestBusy := false;
  leaveCriticalSection(tickworkercriticalSection);
  //**** ende CS ****

end; (*

*)

procedure TTradeWorker.Execute;

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
  debug('Tickworker Thread started');
  while not terminated do
  begin
    EnterCriticalSection(tickworkercriticalSection);
    //wartet bis die Variable TickWorkerRequestBusy gesetzt wird und damit der Übertragungswunsch signalisiert wird
      busy := TickWorkerRequestBusy;
    leaveCriticalSection(tickworkercriticalSection);
    if busy = true then
    begin
      //Sendeversuch bis erfolgreich oder der Thread terminiert wurde
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
