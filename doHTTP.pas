unit doHTTP;

interface

uses
  Classes, Windows, idHTTP, FTTypes, IdSSLOpenSSL;

type
  xxx = integer;

type
  TOurHttp = class(TIdHttp)
  public
    procedure Get(aUrl: String; aRequestBody, aResponseContent: TStream);
  end;

function doHTTPPutString(sJSON: string; Url: string; slDebug: TStringList): integer;
function doHTTPDeleteString(sJSON: string; Url: string; slDebug: TStringList): integer;
function doHTTPDelete(Url: string): integer;
function doHTTPPutMemoryStream(mStream: TMemoryStream; Url: string; slDebug: TStringList): integer;
function doHTTPGetByteArraySL(Url: string; sl: TStringList): byteArray;

implementation

uses SysUtils;

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;
{$SETPEFLAGS IMAGE_FILE_LARGE_ADDRESS_AWARE}

procedure TOurHttp.Get(aUrl: String; aRequestBody, aResponseContent: TStream);
begin
  DoRequest(Id_HttpMethodGet, aUrl, aRequestBody, aResponseContent, []);
end;

function doHTTPGetByteArraySL(Url: string; sl: TStringList): byteArray;

var
  HTTP: TIdHttp;
  p: integer;
  b: byteArray;
  mStream: TMemoryStream;
  dummy: integer;
begin
  // test HTTP Get

  // INDY SSL
  // das ist die notwendige Ergänzung für die Verwendung von SSL
  // HTTP.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create;

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
            try
              sl.Add(E.Message);
            except
              dummy := 1;
            end;
          end;
        end;
      finally
        mStream.Free;
      end;
    except
      on E: EIdHTTPProtocolException do
      begin
        sl.Add(E.Message + #13#10#13#10 + E.ErrorMessage);
      end;
      on E: Exception do
      begin
        sl.Add(E.Message);
      end;
    end;
  finally
    HTTP.Free;
  end;
end;

function doHTTPPutMemoryStream(mStream: TMemoryStream; Url: string; slDebug: TStringList): integer;
var
  HTTP: TIdHttp;
  fehler: integer;
begin
  fehler := 0;
  slDebug.Clear;
  slDebug.Add('start');
  HTTP := TIdHttp.Create;
  HTTP.ConnectTimeout := 400000;
  HTTP.ReadTimeout := 400000;

  // HTTP.Request.customheaders.AddValue('Content-Type', 'text/plain; charset=UTF-8');
  // HTTP.Request.ContentEncoding:= 'text/plain; charset=UTF-8';  falsch
  try
    try
      try
        slDebug.Add('vor put');
        slDebug.Add(HTTP.put(Url, mStream));
        slDebug.Add('nach put');
        slDebug.Add(HTTP.ResponseText);
        slDebug.Add('x');
      finally
        // RequestBody.Free;
      end;
    except
      on E: EIdHTTPProtocolException do
      begin
        slDebug.Add('F:HTTPPutMemoryStream:' + E.Message + #13#10#13#10 + E.ErrorMessage);
        fehler := 1;
        mStream.savetofile(ExtractFilePath(paramstr(0)) + 'HTTPFehler1.bin');
      end;
      on E: Exception do
      begin
        // Socket-Fehler #10060 Zeitüberschreitung bei Verbindung
        slDebug.Add('F:HTTPPutMemoryStream:' + E.Message);
        fehler := 1;
        mStream.savetofile(ExtractFilePath(paramstr(0)) + 'HTTPFehler2.bin');
        // fs := TFileStream.Create(ExtractFilePath(paramstr(0))+'HTTPFehler2.bin', fmCreate);
        // fs.CopyFrom(mStream, mStream.Size);
        // fs.Free;
      end;
    end;
  finally
    slDebug.Add('HTTP.free');
    HTTP.Free;
  end;
  slDebug.Add('Result:' + inttostr(fehler));
  result := fehler;
end;

function doHTTPPutString(sJSON: string; Url: string; slDebug: TStringList): integer;
var
  HTTP: TIdHttp;
  RequestBody: TStringStream;
  ast: AnsiString;
  fehler: integer;
begin
  fehler := 0;
  slDebug.Clear;
  slDebug.Add('start');
  HTTP := TIdHttp.Create;
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
        slDebug.Add(HTTP.put(Url, RequestBody));
        slDebug.Add(HTTP.ResponseText);
      finally
        RequestBody.Free;
      end;
    except
      on E: EIdHTTPProtocolException do
      begin
        slDebug.Add(E.Message + #13#10#13#10 + E.ErrorMessage);
        fehler := 1;
      end;
      on E: Exception do
      begin
        slDebug.Add(E.Message);
        fehler := 1;
      end;
    end;
  finally
    HTTP.Free;
  end;
  result := fehler;
end;

function doHTTPDeleteString(sJSON: string; Url: string; slDebug: TStringList): integer;
var
  HTTP: TIdHttp;
  RequestBody: TStringStream;
  ast: AnsiString;
  fehler: integer;
begin
  fehler := 0;
  slDebug.Clear;
  slDebug.Add('start');
  HTTP := TIdHttp.Create;
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
        slDebug.Add('Delete:' + Url);
        HTTP.delete(Url, RequestBody);
        slDebug.Add(HTTP.ResponseText);
      finally
        RequestBody.Free;
      end;
    except
      on E: EIdHTTPProtocolException do
      begin
        slDebug.Add(E.Message + #13#10#13#10 + E.ErrorMessage);
        fehler := 1;
      end;
      on E: Exception do
      begin
        slDebug.Add(E.Message);
        fehler := 1;
      end;
    end;
  finally
    HTTP.Free;
  end;
  result := fehler;
end;

function doHTTPDelete(Url: string): integer;
var
  HTTP: TIdHttp;
  RequestBody: TStringStream;
  ast: AnsiString;
  fehler: integer;
begin
  fehler := 0;
  // slDebug.Clear;
  // slDebug.Add('start');
  HTTP := TIdHttp.Create;
  HTTP.ConnectTimeout := 400000;
  HTTP.ReadTimeout := 400000;
  HTTP.Request.customheaders.AddValue('Content-Type', 'text/plain; charset=UTF-8');
  // HTTP.Request.ContentEncoding:= 'text/plain; charset=UTF-8';  falsch
  try
    try
      ast := AnsiString('?');
      // move(ast[1], ba[1], 2 * length(ast));
      RequestBody := TStringStream.Create(ast, TEncoding.UTF8);
      try
        // slDebug.Add('Delete:'+url);
        HTTP.delete(Url, RequestBody);
        // slDebug.Add(HTTP.ResponseText);
      finally
        RequestBody.Free;
      end;
    except
      on E: EIdHTTPProtocolException do
      begin
        // slDebug.Add(E.Message + #13#10#13#10 + E.ErrorMessage);
        fehler := 1;
      end;
      on E: Exception do
      begin
        // slDebug.Add(E.Message);
        fehler := 1;
      end;
    end;
  finally
    HTTP.Free;
  end;
  result := fehler;
end;

end.
