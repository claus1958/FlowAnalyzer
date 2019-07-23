unit TickWorker;

interface

uses
  Classes, Windows, doHTTP;

type
  TTickWorker = class(TThread)
  private
    { Private declarations }
  var
    sDebug: string;
  protected
    procedure Execute; override;
    // function doHTTPPut(sJSON: string; Url: string; slDebug: TStringList): integer;
    procedure doTheWork;
    procedure doTheWorkBin;
    procedure debug(s: string);
  public
  end;

implementation

uses FTCollector, SysUtils;

procedure TTickWorker.debug(s: string);
// die Debugmeldungen werden an das Hauptprogramm weitergereicht
begin
  // sDebug:=s;
  // synchronize(doDebug);
  form1.debugThread(s);
end;

// procedure TTickWorker.doDebug();
// begin
// form1.debugThread(sDebug);
//
// end;


// function TTickWorker.doHTTPPut(sJSON: string; Url: string; slDebug: TStringList): integer;
// var
// HTTP: TIdHTTP;
// RequestBody: TStringStream;
// ast: AnsiString;
// fehler: integer;
// begin
// fehler := 0;
// slDebug.Clear;
// slDebug.Add('start');
// HTTP := TIdHTTP.Create;
// HTTP.ConnectTimeout := 400000;
// HTTP.ReadTimeout := 400000;
// HTTP.Request.customheaders.AddValue('Content-Type', 'text/plain; charset=UTF-8');
// // HTTP.Request.ContentEncoding:= 'text/plain; charset=UTF-8';  falsch
// try
// try
// ast := AnsiString(sJSON);
// // move(ast[1], ba[1], 2 * length(ast));
// RequestBody := TStringStream.Create(ast, TEncoding.UTF8);
// try
// slDebug.Add(HTTP.put(Url, RequestBody));
// slDebug.Add(HTTP.ResponseText);
// finally
// RequestBody.Free;
// end;
// except
// on E: EIdHTTPProtocolException do
// begin
// slDebug.Add(E.Message + #13#10#13#10 + E.ErrorMessage);
// fehler := 1;
// end;
// on E: Exception do
// begin
// slDebug.Add(E.Message);
// fehler := 1;
// end;
// end;
// finally
// HTTP.Free;
// end;
// result := fehler;
// end;

procedure TTickWorker.doTheWork;
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
  mStream: TMemoryStream;
begin
  errFlag := false;
  debug('TickWorker Thread doTheWork');

  fehler := 0;
  gt := GetTickCount;
  // **** beginn CS ****
  EnterCriticalSection(tickworkercriticalSection);
  ct := TickWorkerCt;
  pa := TickWorkerPA;
  Url := TickWorkerURLJson;
  list := TickWorkerResultList;

  // den JSON String aus dem Tickarray zusammenbauen
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
    fehler := doHTTPPutString(s, Url, list);
    leaveCriticalSection(tickworkercriticalSection);
    if fehler <> 0 then
    begin
      // wenn nicht gesendet werden konnte
      errFlag := true;
      debug('TickWorker Thread can''t send ...');
      // 5 Sekunden warten bis erneuter Versuch
      sleep(5000);
      EnterCriticalSection(tickworkercriticalSection);
      // nochmal die aktuelle URL übernehmen (darüber steuere letztlich ich den Fehlertest)
      Url := TickWorkerURLJson;
      leaveCriticalSection(tickworkercriticalSection);
    end
    else
    begin
      debug('TickWorker Thread sent:' + inttostr(ct) + ' ticks');

    end;

  until ((fehler = 0) or (terminated = true));

  if errFlag = true then
  begin
    debug('TickWorker Thread could send again');
  end;

  if (terminated = true) then
    debug('Thread wurde terminiert - doTheWork wird beendet');

  // an dieser Stelle kann nun noch die Datei falls vorhanden gesendet werden
  // der Name wird in diesem Fall aber in einer Variablen TickWorkerFileName mitgeteilt
  if (TickWorkerfilename <> '') then
  begin
    // war so eine Idee ...
  end;

  EnterCriticalSection(tickworkercriticalSection);
  TickWorkerRequestBusy := false;
  leaveCriticalSection(tickworkercriticalSection);
  // **** ende CS ****

end;

procedure TTickWorker.doTheWorkBin;
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
  mStream: TMemoryStream;
  i: integer;
  BA: array of byte;
  BB: array of byte;
begin
  errFlag := false;
  debug('TickWorker Thread doTheWorkBin');

  fehler := 0;
  gt := GetTickCount;
  // **** beginn CS ****
  EnterCriticalSection(tickworkercriticalSection);
  ct := TickWorkerCt;
  pa := TickWorkerPA;
  Url := TickWorkerURLBin;
  list := TickWorkerResultList;
  mStream := TMemoryStream.Create;
  i := SizeOf(TTick); //

  // ct:=30;

  mStream.write(pa^[0], ct * i);
  // man beachte Pointer(...)^  ist der Trick da cwActionstoserver ein dynamisches Array ist!
  leaveCriticalSection(tickworkercriticalSection);

  // versenden
  // debug('sende Puffer ' + inttostr(pnr) + ' T:' + inttostr(ct) + ' B:' + inttostr(length(s)));
  repeat
    EnterCriticalSection(tickworkercriticalSection);
    // doHttpPutMemoryStream(mStream, edHTTPAddress.Text + '/bin/actions');
    mStream.position := 0;
    fehler := doHttpPutMemoryStream(mStream, Url, list);

    // mStream.savetofile(ExtractFilePath(paramstr(0))+'HTTPStream.bin');

//    // zur Kontrolle der Daten in Bytearray umwandeln ...
//    mStream.position := 0;
//    SetLength(BA,trunc( mStream.Size/2 ));
//    SetLength(BB,trunc(mStream.Size/2 ));
//    mStream.Read(BA[0],trunc( mStream.Size/2));
//    mStream.Read(BB[0],trunc( mStream.Size/2));
//    // mStream.Free;

    leaveCriticalSection(tickworkercriticalSection);
    if fehler <> 0 then
    begin
      // wenn nicht gesendet werden konnte
      errFlag := true;
      debug('TickWorker Thread can''t send ...F:'+inttostr(fehler));
      for I := 0 to list.count-1 do
        begin
           debug('L:'+list[i]);
        end;
      // 5 Sekunden warten bis erneuter Versuch
      // aber NUR wenn der Server nicht reagiert
      // bei allen anderen Fehlern nicht mehr warten - bringt ja nix
      // 500 Internal Server Error kommt oft vor
      // 10060 Zeitüberschreitung wäre allenfalls eine Wiederholung wert
      sleep(5000);
      EnterCriticalSection(tickworkercriticalSection);
      // nochmal die aktuelle URL übernehmen (darüber steuere letztlich ich den Fehlertest)
      Url := TickWorkerURLBin;
      leaveCriticalSection(tickworkercriticalSection);
    end
    else
    begin
      debug('TickWorker Thread sent:' + inttostr(ct) + ' ticks');

    end;

  until ((fehler = 0) or (fehler<>0) or  (terminated = true));
  mStream.Free;

  if fehler <> 0 then
    begin
      debug('Abbruch TickWorker wegen Fehler');
    end;


  if fehler = 0 then
    if errFlag = true then
    begin
      debug('TickWorker Thread could send again');
    end;

  if (terminated = true) then
    debug('Thread wurde terminiert - doTheWork wird beendet');

  // an dieser Stelle kann nun noch die Datei falls vorhanden gesendet werden
  // der Name wird in diesem Fall aber in einer Variablen TickWorkerFileName mitgeteilt
  if (TickWorkerfilename <> '') then
  begin
    // war so eine Idee ...
  end;

  EnterCriticalSection(tickworkercriticalSection);
  TickWorkerRequestBusy := false;
  leaveCriticalSection(tickworkercriticalSection);
  // **** ende CS ****

end;

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
  debug('Tickworker Thread started');
  while not terminated do
  begin
    EnterCriticalSection(tickworkercriticalSection);
    // wartet bis die Variable TickWorkerRequestBusy gesetzt wird und damit der Übertragungswunsch signalisiert wird
    busy := TickWorkerRequestBusy;
    leaveCriticalSection(tickworkercriticalSection);
    if busy = true then
    begin
      // Sendeversuch bis erfolgreich oder der Thread terminiert wurde
      if tickworkerdatatyp = 1 then
        doTheWork(); // a) JSON

      if tickworkerdatatyp = 2 then
        doTheWorkBin(); // b) bin
    end;
    sleep(100);
    inc(ct);
    if (ct mod 10000) = 0 then
    begin
      debug('TickWorker Thread wartet..');
    end;

  end;
  debug('Tickworker Thread terminated');

end;

end.
