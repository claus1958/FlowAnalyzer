unit Unit45;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ManagerAPI, StdCtrls, ExtCtrls, Vcl.Grids, StrUtils, Vcl.ComCtrls, IniFiles, Vcl.FileCtrl,
  System.generics.collections, Vcl.Buttons, IdHTTP, IdGlobal,
  psAPI, System.zip, Wininet, csCSV, HTTPApp, IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze, AdvChartSelectors,
  Vcl.CheckLst, Unit4, mmsystem;

// RSChartPanel, RSCharts, RSBarCharts,
type
  usertyp = packed record
    name: string;
    plz: integer;
  end;

  DAuser = array of usertyp;

  aInt = array of integer;
  aaint = array of aInt;

  TForm45 = class(TForm)
    Frame41: TFrame4;
    Button1: TButton;
    ListBox1: TListBox;
    Frame42: TFrame4;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    function vergleichInteger(was, mit: integer; op: string): boolean;
    function vergleichInteger2(was, mit: integer; op: integer): boolean;
    function vergleichInteger3(was, mit: integer): boolean;
    function vergleichIntegerArray(var was: array of integer; var mit: integer; op: string): boolean;
    function vergleichIntegerArray2(var was: array of integer; var mit: integer; op: integer): boolean;
    function vergleichIntegerArray3(var was: array of integer; var mit: integer): boolean;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form45: TForm45;

implementation

{$R *.dfm}

procedure TForm45.Button1Click(Sender: TObject);
var
  a: aaint;
  i, j: integer;
begin
  setlength(a, 10);
  for i := 0 to 9 do
  begin
    setlength(a[i], 10);
    for j := 0 to 9 do
    begin
      a[i][j] := 100 * i + j;

    end;

  end;
  Frame41.test := Frame41.test + 1;
end;

procedure TForm45.Button2Click(Sender: TObject);
var
  gt: cardinal;
  i, j: integer;
  s: String;
  c: integer;
  aa: array of integer;

begin
  j := 12;
  c := 0;
  s := 'Broker';

  gt := gettickcount;
  for i := 1 to 40000000 do
  begin
    if j = 12 then
      c := c + 1;
  end;
  showmessage(inttostr(gettickcount - gt) + ' ' + inttostr(c));

  c := 0;
  gt := gettickcount;
  for i := 1 to 40000000 do
  begin
    if s = 'Broker' then
      c := c + 1;
  end;
  showmessage(inttostr(gettickcount - gt) + ' ' + inttostr(c));

  c := 0;
  gt := gettickcount;
  for i := 1 to 40000000 do
  begin
    if vergleichInteger(j, 12, '=') = true then
      c := c + 1;
  end;
  showmessage(inttostr(gettickcount - gt) + ' ' + inttostr(c));

  c := 0;
  gt := gettickcount;
  for i := 1 to 40000000 do
  begin
    if vergleichInteger2(j, 12, 1) = true then
      c := c + 1;
  end;
  showmessage(inttostr(gettickcount - gt) + ' ' + inttostr(c));

  c := 0;
  gt := gettickcount;
  for i := 1 to 40000000 do
  begin
    if 1 = 1 then
      if vergleichInteger3(j, 12) = true then
        c := c + 1;
  end;
  showmessage(inttostr(gettickcount - gt) + ' ' + inttostr(c));

  c := 0;
  setlength(aa, 1);
  aa[0] := 1;
  gt := gettickcount;
  for i := 1 to 40000000 do
  begin

    if vergleichIntegerArray(aa, j, '=') = true then
      c := c + 1;
  end;
  showmessage(inttostr(gettickcount - gt) + ' ' + inttostr(c));

  c := 0;
  setlength(aa, 1);
  aa[0] := 1;
  gt := gettickcount;
  for i := 1 to 40000000 do
  begin

    if vergleichIntegerArray2(aa, j, 1) = true then
      c := c + 1;
  end;
  showmessage(inttostr(gettickcount - gt) + ' ' + inttostr(c));

  c := 0;
  setlength(aa, 1);
  aa[0] := 1;
  gt := gettickcount;
  for i := 1 to 40000000 do
  begin

    if vergleichIntegerArray3(aa, j) = true then
      c := c + 1;
  end;
  showmessage(inttostr(gettickcount - gt) + ' ' + inttostr(c));

end;

procedure TForm45.Button3Click(Sender: TObject);
var
  T, u: cardinal;
begin
  T := timegettime;
  u := gettickcount;
  ListBox1.items.add(inttostr(T) + ' ' + inttostr(u));
end;

procedure TForm45.Button4Click(Sender: TObject);
var
  strarray: array of string;
  p: integer;
begin
  setlength(strarray, 10);
  strarray[0] := '1234=test';
  p := ansipos('=', strarray[0]);
  p := pos('t', 'maustest');
end;

procedure TForm45.Button5Click(Sender: TObject);
var
  u: DAuser;
  i: integer;
  v: DAuser;
  w:dauser;
begin
  setlength(u, 10);
  setlength(v, 5);
  for i := 0 to 9 do
  begin
    u[i].name := 'n' + inttostr(i);
    u[i].plz := 7000 + i
  end;

  for i := 0 to 4 do
  begin
    v[i] := u[i];
  end;

  w:=u;

  for i := 0 to 9 do
  begin
    u[i].name := 'neu' + inttostr(i);
    u[i].plz := 70000 + i
  end;

  w[0]:=v[0];   //-> da w=u wird mit w[0] auch u[0] geändert !!
end;

function TForm45.vergleichInteger(was, mit: integer; op: string): boolean;
// var oben bringt nix
var
  i: integer;
begin
  result := false;
  if op = '=' then
  begin
    if was = mit then
      result := true;
    exit;
  end;
  if op = '>' then
  begin
    if was > mit then
      result := true;
    exit;
  end;
  if op = '<' then
  begin
    if was < mit then
      result := true;
    exit;
  end;
  if op = '>=' then
  begin
    if was >= mit then
      result := true;
    exit;
  end;
  if op = '<=' then
  begin
    if was <= mit then
      result := true;
    exit;
  end;
  if op = '<>' then
  begin
    if was <> mit then
      result := true;
    exit;
  end;

end;

function TForm45.vergleichInteger2(was, mit: integer; op: integer): boolean;
// var oben bringt nix
var
  i: integer;
begin
  result := false;
  if op = 1 then
  begin
    if was = mit then
      result := true;
    exit;
  end;
  if op = 2 then
  begin
    if was > mit then
      result := true;
    exit;
  end;
  if op = 3 then
  begin
    if was < mit then
      result := true;
    exit;
  end;
  if op = 4 then
  begin
    if was >= mit then
      result := true;
    exit;
  end;
  if op = 5 then
  begin
    if was <= mit then
      result := true;
    exit;
  end;
  if op = 6 then
  begin
    if was <> mit then
      result := true;
    exit;
  end;

end;

function TForm45.vergleichInteger3(was, mit: integer): boolean;
var
  i: integer;
begin
  result := false;
  if was = mit then
    result := true;

end;

function TForm45.vergleichIntegerArray(var was: array of integer; var mit: integer; op: string): boolean;
var
  i: integer;
  res: boolean;
begin
  res := false;
  for i := 0 to length(was) - 1 do
  begin
    res := vergleichInteger(was[i], mit, op);
    if res = true then
      break
  end;
  result := res;
end;

function TForm45.vergleichIntegerArray2(var was: array of integer; var mit: integer; op: integer): boolean;
var
  i: integer;
  res: boolean;
begin
  res := false;
  for i := 0 to length(was) - 1 do
  begin
    res := vergleichInteger2(was[i], mit, op);
    if res = true then
      break
  end;
  result := res;
end;

function TForm45.vergleichIntegerArray3(var was: array of integer; var mit: integer): boolean;
var
  i: integer;
  res: boolean;
begin
  res := false;
  for i := 0 to length(was) - 1 do
  begin
    res := vergleichInteger3(was[i], mit);
    if res = true then
      break
  end;
  result := res;
end;

end.
