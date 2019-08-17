unit HTTPWorker;

interface

uses
  Classes, Windows, doHTTP,FTTypes;

type
  THTTPWorker = class(TThread)
  private
    { Private declarations }
  var
  protected
    procedure Execute; override;
    procedure doTheWork;
    procedure debug(s: string);

  public
  var
    RequestBusy: Boolean;
    HError: Integer;
    SendType: Integer; // 1=String 2=MemoryStream
    SendString: String; // der Sendestring
    MemoryStream: TMemoryStream;
    URL: string;
    Ct: Integer;
    ResultList: TStringList;
    Caption: String;
    machfehler: Boolean;
    bArray: Bytearray;//NEU: zum empfangen einer binären Datei
  end;

implementation

uses FTCollector, SysUtils,XFlowAnalyzer;    ///!!! ACHTUNG

procedure THTTPWorker.debug(s: string);
// die Debugmeldungen werden an das Hauptprogramm weitergereicht
begin
  // sDebug:=s;
  // synchronize(doDebug);
  //form1.debugThread(s);!!! ACHTUNG
end;

procedure THTTPWorker.doTheWork;
// HTTPWorkerPNr:integer;

var
  s: string;
  fehler: Integer;
  MerkUrl: string;
  list: TStringList;
  errFlag: Boolean;
  retryCount: Integer;
  mStream: TMemoryStream;
  typ: Integer;
  i:integer;
begin
  errFlag := false;
  retryCount := 0;
  fehler := 0;
  // **** beginn CS ****
  EnterCriticalSection(HTTPWorkcriticalSection);
  s := SendString;
  MerkUrl := URL;
  list := ResultList;
  typ := SendType;
  debug(Caption + ' Thread doTheWork Typ:' + inttostr(typ));
  mStream := MemoryStream;
  leaveCriticalSection(HTTPWorkcriticalSection);
  // versenden
  repeat
    EnterCriticalSection(HTTPWorkcriticalSection);
    if (typ = 1) then
    begin
      debug('sende string l:'+inttostr(s.Length));
      fehler := doHTTPPutString(s, MerkUrl, list);
    end;
    if (typ = 2) then
    begin
      debug('sende mStream l:'+inttostr(mStream.size)+' url:'+url);
      fehler := doHTTPPutMemoryStream(mStream, MerkUrl, list);
    end;
    if (typ=3) then
    begin
      bArray:=doHTTPGetByteArraySL(MerkUrl,list);//: byteArray;
    end;
    leaveCriticalSection(HTTPWorkcriticalSection);
    if fehler <> 0 then
    begin
      // wenn nicht gesendet werden konnte
      for i:=0 to list.Count-1 do
        begin
          debug('l:'+list[i]);
        end;
      errFlag := true;
      debug(Caption + ' Thread could not send ... wait 5sec');
      // 5 Sekunden warten bis erneuter Versuch
      sleep(5000);
      EnterCriticalSection(HTTPWorkcriticalSection);
      // nochmal die aktuelle URL übernehmen (darüber steuere letztlich ich den Fehlertest)
      MerkUrl := URL;
      leaveCriticalSection(HTTPWorkcriticalSection);
      inc(retryCount);
      debug(Caption + ' Retry:'+inttostr(retrycount));
    end
    else
    begin
      debug(Caption + ' Thread work done' + MerkUrl);
    end;

  until ((fehler = 0) or (terminated = true) or (retryCount > 1));

  if errFlag = true then
  begin
    debug(Caption + 'Thread could send again');
  end;

  if (terminated = true) then
    debug(Caption + ' Thread was terminated - doTheWork ends');
  if(retryCount>1) then
    debug(Caption + ' Thread was ended after 1 retries');
  if(fehler=0) then
    debug(Caption + ' Thread was ended with success');



  EnterCriticalSection(HTTPWorkcriticalSection);
  if fehler <> 0 then
    HError := 1;
  RequestBusy := false;
  leaveCriticalSection(HTTPWorkcriticalSection);
  // **** ende CS ****
  debug('end HTTP doTheWork');
end;

procedure THTTPWorker.Execute;

var
  busy: Boolean;
  Ct: Integer;
begin
  Ct := 0;
  debug(Caption + ' HTTPWorker-Thread started');
  while not terminated do
  //diese Schleife wird ewig durchlaufen
  begin
    EnterCriticalSection(HTTPWorkcriticalSection);
    // wartet bis die Variable HTTPWorkerRequestBusy gesetzt wird
    // und damit der Übertragungswunsch signalisiert wird
    busy := RequestBusy;
    leaveCriticalSection(HTTPWorkcriticalSection);
    if busy = true then
    begin
      // Sendeversuch bis erfolgreich oder der Thread terminiert wurde
      try
        // test um Fehler zu provozieren
//        if machfehler = true then
//          number1 := number1 div number0; // unbehandelter Fehler - was passiert ?   Sprung ans Ende von Execute

        doTheWork(); // senden...
      finally
        RequestBusy := false;
      end;
    end;
    sleep(100);
    inc(Ct);
    if (Ct mod 10000) = 0 then
    begin
      debug(Caption + ' Thread wartet..');
    end;

  end;
  debug(Caption + ' Thread terminated');

end;

end.
