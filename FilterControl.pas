unit FilterControl;

// FilterControl ist ein Frame ELement
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Strutils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, FTCommons, Vcl.CheckLst, DateUtils;

const

  fltTopicBrokerId = 1;
  fltTopicAccountId = 2;
  fltTopicUserId = 3;
  fltTopicSymbol = 4;
  fltTopicSymbolId = 5;
  fltTopicActionType = 6;
  fltTopicUserName = 7;
  fltTopicProfit = 8;
  fltTopicAccountDate = 9;
  fltTopicAccountDateUnix = 10;
  fltTopicOpenDateTime = 11;
  // fltTopicOpenDateTimeUnix = 12;
  fltTopicCloseDateTime = 13;
  // fltTopicCloseDateTimeUnix = 14;
  fltTopicOpenPrice = 15;
  fltTopicVolume = 16;
  fltTopicMarginRate = 17;
  fltTopicAccountCurrency = 18;
  fltTopicCloseDateTimeOrOpen = 19;
  fltTopicComment = 20;
  fltTopicActionInTimeRange = 21;

  fltOpGleich = 1;
  fltOpUnGleich = 2;
  fltOpGroesser = 3;
  fltOpKleiner = 4;
  fltOpGrGleich = 5;
  fltOpKlGleich = 6;
  fltOpContains = 7;
  fltOpBegins = 8;
  fltOpGroesserOderNull = 9; // bei Datum wichtig
  fltOpGroesserGleichOderNull = 10; // bei Datum wichtig
  fltOpKlNotNull = 11; // neuer Operator bei Datum
  fltOpKlOrNull = 12;
  fltOpTrue = 13;
  fltOpFalse = 14;

type
  TFilterElemente = class(TFrame)
    cbTopic: TComboBox;
    cbOperator: TComboBox;
    edValue: TEdit;
    dtPicker1: TDateTimePicker;
    chkActive: TCheckBox;
    btnMore: TButton;
    chkLB1: TComboBox;
    procedure WndProc(var Msg: TMessage); override;
    procedure cbTopicChange(Sender: TObject);
    constructor Create(AOwner: TComponent); override;
    // function checkCwaction(var a: cwaction): boolean;
    function checkCwaction(var a: cwaction; var aplus: cwActionPlus): boolean;
    procedure btnMoreClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure chkLB1DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure chkLB1Select(Sender: TObject);
    procedure machVergleichArrays;
    function findSymbolId(symbol: string): Integer;
    function findSymbol(symbolId: Integer): string;
    function findUserName(userId: Integer): string;
    function vergleichStringArray(var mit: array of string; was: string; op: Integer): boolean;
    function vergleichString(var mit, was: string; op: Integer): boolean;
    function vergleichIntegerArray(var mit: array of Integer; var was: Integer; op: Integer): boolean;
    function vergleichInteger(var mit, was: Integer; op: Integer): boolean;
    function vergleichIntegerGleich(var mit, was: Integer): boolean;
    function vergleichDouble(var mit, was: double; op: Integer): boolean;
    procedure getValues(f: TFilterParameter);
    procedure setValues(f: TFilterParameter);
    procedure FrameExit(Sender: TObject);
    procedure chkLB1Exit(Sender: TObject);
    procedure dtPicker1Change(Sender: TObject);
    procedure edValueChange(Sender: TObject);
    procedure btnMoreMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure wegdamit;
    procedure FrameClick(Sender: TObject);
    procedure chkLB1Click(Sender: TObject);
    function vorQuote(s: string): string;
    // function vergleichInteger(was,mit: integer; op: string): boolean;
    // function vergleichIntegerArray(was: array of integer; mit: integer; op: string): boolean;
  private
    chkLB1Selected: array of boolean;
  public
    topic: string;
    operators: string;
    coperator: Integer;
    ctopic: Integer;
    vglI: array of Integer; // all diese Parameter werden vor der eigentlichen Suche erstellt
    vglS: array of string;
    vglICt: Integer;
    vglSCt: Integer;
    vglD: double;
    vDouble: double;
    vString: String;
    vInteger: Integer;
    vInteger2: Integer; // nur bei Action in TimeRange verwendet und nicht manuell eingebbar
    brokerId: array [0 .. 7] of Integer;
    counter: Integer;
    mmon: boolean;
    mmc: Integer;
    mm: array [1 .. 1000] of Integer;
    //
    // active:boolean;
    // topic:string;
    // operator:string;
    // value:string;
  end;

implementation

{$R *.dfm}
// uses XFlowAnalyzer;  //brauche ich wohl gar nicht    . Sehr wohl aber oben FTCommons

constructor TFilterElemente.Create(AOwner: TComponent);
begin
  brokerId[0] := 0; // gibts natürlich nicht
  brokerId[1] := 1;
  brokerId[2] := 1;
  brokerId[3] := 2;
  brokerId[4] := 2;
  brokerId[5] := 2;
  brokerId[6] := 2;
  brokerId[7] := 2;
  inherited Create(AOwner);
  chkActiveClick(nil);
  counter := 0;
end;

procedure TFilterElemente.dtPicker1Change(Sender: TObject);
var
  e: TDateTimePicker;
begin
  e := Sender as TDateTimePicker;
  if screen.ActiveControl = e then
  begin
    // Dateof ist notwendig damit man an Null Uhr des gewählten Datums landet
    edValue.Text := inttostr(datetimetounix(dateof(e.DateTime)));
  end;
end;

procedure TFilterElemente.edValueChange(Sender: TObject);
var
  e: TEdit;
  i: Integer;
  s: string;
begin
  e := Sender as TEdit;
  if ((screen.ActiveControl = e) or (Sender <> dtPicker1)) then
  begin
    if dtPicker1.Visible = true then
    begin
      dtPicker1.DateTime := getDateTimeFromString(edValue.Text);

      // // den Wert umrechnen und im Picker eintragen
      // if trystrtoint(edValue.Text, i) = true then
      // dtPicker1.DateTime := (unixtodatetime(i))
      // else
      // begin
      // s := AnsiUpperCase(edValue.Text);
      // dtPicker1.DateTime := getDateTimeFromString(s);
      // end;
    end;

  end;
end;

procedure TFilterElemente.btnMoreClick(Sender: TObject);
var
  i: Integer;
  s: string;
  // ist jetzt am MouseUp Event
begin
  // if btnMore.Caption = '>' then
  // begin
  // chkLB1.Visible := true;
  // btnMore.Caption := '<';
  // chkLB1.DroppedDown := true;
  // end ;
  // else
  // begin
  // if  chkLB1.DroppedDown = true then
  // chkLB1.DroppedDown := false;
  //
  // chkLB1.Visible := false;
  // // übernehmen der Einträge
  // for i := 0 to chkLB1.Items.Count - 1 do
  // begin
  // if chkLB1Selected[i] = true then
  // s := s + chkLB1.Items[i] + ',';
  // end;
  // edValue.Text := leftstr(s, length(s) - 1);
  // edValue.Visible := true;
  // btnMore.Caption := '>';
  // end;
end;

procedure TFilterElemente.wegdamit;
var
  i: Integer;
  s: string;
begin
  if btnMore.Caption = '>' then
  begin
    chkLB1.Visible := true;
    btnMore.Caption := '<';
    chkLB1.DroppedDown := true;
  end
  else
  begin
    if chkLB1.DroppedDown = true then
      chkLB1.DroppedDown := false;

    chkLB1.Visible := false;
    // übernehmen der Einträge
    for i := 0 to chkLB1.Items.Count - 1 do
    begin
      if chkLB1Selected[i] = true then
        s := s + chkLB1.Items[i] + ',';
    end;
    edValue.Text := leftstr(s, length(s) - 1);
    edValue.Visible := true;
    btnMore.Caption := '>';
  end;
end;

procedure TFilterElemente.WndProc(var Msg: TMessage);
begin
  inherited;
  // // if msg.Msg=WM_VSCROLL then
  // begin
  // if msg.WParamLo=5 then   //5=SB_THUMBTRACK  Der Thumb wird bewegt
  if mmon = true then
  begin
    inc(mmc);
    if (mmc < 1000) then
      mm[mmc] := Msg.Msg;

  end;
end;

procedure TFilterElemente.btnMoreMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  wegdamit;

end;

function TFilterElemente.vorQuote(s: string): string;
begin
  if pos('''', s) > 0 then
  begin
    result := leftstr(s, pos('''', s) - 1);
  end
  else
    result := s;

end;

procedure TFilterElemente.cbTopicChange(Sender: TObject);
var
  typ: Integer;
  i: Integer;
  lb1flag: boolean;
  topic: string;
begin
  // form2.dolockWindowUpdate(true);
  chkLB1.Items.Clear;
  topic := vorQuote(cbTopic.Text);
  lb1flag := false;
  setlength(chkLB1Selected, 0);
  // BrokerId
  // AccountId
  // SymbolId'Suche aus Liste
  // Symbol'Texteingabe
  // UserId
  // UserName
  // ActionType
  // OpenDateTime
  // CloseDateTime
  // OpenPrice
  // Profit
  // Volume
  // MarginRate
  // AccountCurrency
  // CloseDateTime OR Open

  typ := 1; // 1=nur edit text  2=edit mit comboboxListe  3=dtPicker
  if topic = 'BrokerId' then
  begin
    typ := 2;
    chkLB1.Items.Add('LCG');
    chkLB1.Items.Add('ActiveTrades');
    lb1flag := true;
    btnMore.Visible := true;
  end;

  if topic = 'AccountId' then
  begin
    typ := 2;
    chkLB1.Items.Add('LCG A');
    chkLB1.Items.Add('LCG B');
    chkLB1.Items.Add('ActiveTrades A');
    chkLB1.Items.Add('ActiveTrades B');
    chkLB1.Items.Add('ActiveTrades C');
    chkLB1.Items.Add('ActiveTrades D');
    chkLB1.Items.Add('ActiveTrades E');
    lb1flag := true;
    btnMore.Visible := true;

  end;

  if topic = 'ActionType' then
  begin
    typ := 2;
    chkLB1.Items.Add('BUY');
    chkLB1.Items.Add('SELL');
    chkLB1.Items.Add('BUY LIMIT');
    chkLB1.Items.Add('SELL LIMIT');
    chkLB1.Items.Add('BUY STOP');
    chkLB1.Items.Add('SELL STOP');
    chkLB1.Items.Add('BALANCE');
    chkLB1.Items.Add('CREDIT');
    chkLB1.Items.Add('BALANCE,CREDIT');
    lb1flag := true;
    btnMore.Visible := true;
  end;

  if topic = 'AccountCurrency' then
  begin
    typ := 2;
    chkLB1.Items.Add('EUR');
    chkLB1.Items.Add('USD');
    chkLB1.Items.Add('CHF');
    chkLB1.Items.Add('GBP');
    lb1flag := true;
    btnMore.Visible := true;
  end;

  if topic = 'Symbol' then
  begin
    typ := 1;
    chkLB1.Items.BeginUpdate;

    // chkLB1.Visible:=false;
    for i := 0 to length(cwsymbols) - 1 do
    begin
      chkLB1.Items.Add(cwsymbols[cwsymbolssortindex[i]].name);
    end;

    // chkLB1.Visible:=true;
    chkLB1.Items.EndUpdate;
    lb1flag := true;
  end;

  if topic = 'SymbolId' then
  begin
    typ := 2;
    chkLB1.Items.BeginUpdate;

    // chkLB1.Visible:=false;
    for i := 0 to length(cwsymbols) - 1 do
    begin
      chkLB1.Items.Add(inttostr(cwsymbols[cwsymbolssortindex[i]].symbolId) + '=' + cwsymbols[cwsymbolssortindex[i]].name
        + ' ' + brokerShort[cwsymbols[cwsymbolssortindex[i]].brokerId]);
    end;

    // chkLB1.Visible:=true;
    chkLB1.Items.EndUpdate;
    lb1flag := true;

  end;

  if lb1flag = true then
  begin
    setlength(chkLB1Selected, chkLB1.Items.Count);
    chkLB1.itemindex := 0;
  end;

  if topic = 'OpenDateTime' then
  begin
    typ := 3;
  end;
  if topic = 'CloseDateTime' then
  begin
    typ := 3;
  end;
  if topic = 'Profit' then
  begin
    typ := 1;
  end;
  if topic = 'UserId' then
  begin
    typ := 1;
  end;
  if topic = 'UserName' then
  begin
    typ := 1;
  end;
  if topic = 'OpenPrice' then
  begin
    typ := 1;
  end;
  if topic = 'Volume' then
  begin
    typ := 1;
  end;
  if topic = 'CloseDateTime OR Open' then
  begin
    typ := 3;
  end;
  if topic = 'Comment' then
  begin
    typ := 1;
  end;
  if topic = 'Action in TimeRange' then
    typ := 4;

  if typ = 1 then
  // reines Editierfeld
  begin
    edValue.Visible := true;
    edValue.Width := dtPicker1.left + dtPicker1.Width - edValue.left;
    dtPicker1.Visible := false;
    btnMore.Visible := false;
    chkLB1.Visible := false;
    cbOperator.Items.Clear;
    cbOperator.Items.Add('=');
    cbOperator.Items.Add('<>');
    cbOperator.Items.Add('>');
    cbOperator.Items.Add('<');
    cbOperator.Items.Add('>=');
    cbOperator.Items.Add('<=');
    cbOperator.Items.Add('contains');
    cbOperator.Items.Add('begins');
  end;

  if typ = 2 then
  // Auswahl aus Combobox
  begin
    edValue.Visible := true;
    edValue.Width := dtPicker1.left + dtPicker1.Width - edValue.left;
    dtPicker1.Visible := false;
    btnMore.Visible := true;
    btnMore.Caption := '>';
    chkLB1.Visible := false;
    cbOperator.Items.Clear;
    cbOperator.Items.Add('=');
    cbOperator.Items.Add('<>');

  end;

  if typ = 3 then
  // Datum
  begin
    chkLB1.Visible := false;
    edValue.Visible := true;
    dtPicker1.Visible := true;
    edValue.Width := dtPicker1.left - edValue.left;
    btnMore.Visible := false;
    chkLB1.Visible := false;
    cbOperator.Items.Clear;
    cbOperator.Items.Add('>=');
    cbOperator.Items.Add('>= or 0');
    cbOperator.Items.Add('<');
    cbOperator.Items.Add('< not 0');
    cbOperator.Items.Add('< or 0');

  end;

  if typ = 4 then
  begin
    chkLB1.Visible := false;
    edValue.Visible := false;
    dtPicker1.Visible := false;
    btnMore.Visible := false;
    chkLB1.Visible := false;
    cbOperator.Items.Clear;
    cbOperator.Items.Add('true');
    cbOperator.Items.Add('false');

  end;
  // form2.dolockWindowUpdate(false);
  cbOperator.itemindex:=0;

end;

procedure TFilterElemente.machVergleichArrays();
var
  charArray: Array [0 .. 0] of Char;
  strArray: TArray<String>; // Array of String;
  s: string;
  i, j, ict, p: Integer;
begin
  // etwas eigenartig
  // am Ende werden je nach cTopic und edValue.text verschiedene Variablen gefüllt
  // mal vglI[] und vglICt oder  vglS[] mit vglSCt, vDouble oder vInteger

  vglICt := 0;
  charArray[0] := ',';
  s := edValue.Text;
  strArray := s.Split(charArray);
  //
  if ctopic = fltTopicBrokerId then
  begin
    for i := 0 to length(strArray) - 1 do
    begin
      if strArray[i] = 'LCG' then
      begin
        vglICt := vglICt + 1;
        setlength(vglI, vglICt);
        vglI[vglICt - 1] := 1;
      end;
      if strArray[i] = 'ActiveTrades' then
      begin
        vglICt := vglICt + 1;
        setlength(vglI, vglICt);
        vglI[vglICt - 1] := 2;
      end;

    end;
    if (vglICt = 0) then
    begin
      // nix passendes eingetragen dann wenigstens eine Null verwenden um den Absturz abzufangen
      vglICt := vglICt + 1;
      setlength(vglI, vglICt);
      vglI[vglICt - 1] := 0
    end;
  end;

  if ctopic = fltTopicAccountId then
  begin
    for i := 0 to length(strArray) - 1 do
    begin
      j := IndexStr(strArray[i], ['LCG A', 'LCG B', 'ActiveTrades A', 'ActiveTrades B', 'ActiveTrades C',
        'ActiveTrades D', 'ActiveTrades E']);
      if (j > -1) then
      begin
        vglICt := vglICt + 1;
        setlength(vglI, vglICt);
        vglI[vglICt - 1] := j + 1; // index hier 1..7 !!
      end;
    end;
    if (vglICt = 0) then
    begin
      // nix passendes eingetragen dann wenigstens eine Null verwenden um den Absturz abzufangen
      vglICt := vglICt + 1;
      setlength(vglI, vglICt);
      vglI[vglICt - 1] := 0
    end;
  end;

  if ctopic = fltTopicUserId then
  begin
    for i := 0 to length(strArray) - 1 do
    begin
      if strArray[i] <> '' then
      begin
        vglICt := vglICt + 1;
        setlength(vglI, vglICt);
        vglI[vglICt - 1] := strtoint(strArray[i]);
      end;
    end;
    if (vglICt = 0) then
    begin
      // nix passendes eingetragen dann wenigstens eine Null verwenden um den Absturz abzufangen
      vglICt := vglICt + 1;
      setlength(vglI, vglICt);
      vglI[vglICt - 1] := 0
    end;
  end;

  if (ctopic = fltTopicSymbolId) and (coperator = fltOpGleich) then
  begin
    for i := 0 to length(strArray) - 1 do
    begin
      if strArray[i] <> '' then
      begin
        p := pos('=', strArray[i]); // pos liefert 1 als Position des ersten Zeichens !
        if (p > 0) then
          j := strtoint(leftstr(strArray[i], p - 1))
        else
          j := strtoint(strArray[i]);
        // j := findSymbolId(strArray[i]);
        if (j >= 0) then
        begin
          vglICt := vglICt + 1;
          setlength(vglI, vglICt);
          vglI[vglICt - 1] := j;
        end;
      end;
    end;
    if (vglICt = 0) then
    begin
      // nix passendes eingetragen dann wenigstens eine Null verwenden um den Absturz abzufangen
      vglICt := vglICt + 1;
      setlength(vglI, vglICt);
      vglI[vglICt - 1] := 0
    end;
  end;

  // //bei Symbol und gleich werden die Namen zu symbolIds gewandelt
  // if (ctopic = fltTopicSymbol) and (coperator = fltOpGleich) then
  // begin
  // for i := 0 to length(strArray) - 1 do
  // begin
  // if strArray[i] <> '' then
  // begin
  // j := findSymbolId(strArray[i]);
  // if (j > 0) then
  // begin
  // vglICt := vglICt + 1;
  // setlength(vglI, vglICt);
  // vglI[vglICt - 1] := strtoint(strArray[i]);
  // end;
  // end;
  // end;
  // end;

  if ctopic = fltTopicAccountCurrency then
  begin
    for i := 0 to length(strArray) - 1 do
    begin
      j := IndexStr(strArray[i], ['EUR', 'USD', 'CHF', 'GBP']);
      if (j > -1) then
      begin
        vglICt := vglICt + 1;
        setlength(vglI, vglICt);
        vglI[vglICt - 1] := j + 1; // 1-4
      end;
    end;
    if (vglICt = 0) then
    begin
      // nix passendes eingetragen dann wenigstens eine Null verwenden um den Absturz abzufangen
      vglICt := vglICt + 1;
      setlength(vglI, vglICt);
      vglI[vglICt - 1] := 0
    end;
  end;

  if ctopic = fltTopicActionType then
  begin
    for i := 0 to length(strArray) - 1 do
    begin
      j := IndexStr(strArray[i], ['BUY', 'SELL', 'BUY LIMIT', 'SELL LIMIT', 'BUY STOP', 'SELL STOP', 'BALANCE',
        'CREDIT']);
      if (j > -1) then
      begin
        vglICt := vglICt + 1;
        setlength(vglI, vglICt);
        vglI[vglICt - 1] := j + 1; // index hier 1..8 !!
      end;
    end;
    if (vglICt = 0) then
    begin
      // nix passendes eingetragen dann wenigstens eine Null verwenden um den Absturz abzufangen
      vglICt := vglICt + 1;
      setlength(vglI, vglICt);
      vglI[vglICt - 1] := 0
    end;
  end;

  vglSCt := 0;
  if (ctopic = fltTopicSymbol) then
  begin
    for i := 0 to length(strArray) - 1 do
    begin
      vglSCt := vglSCt + 1;
      setlength(vglS, vglSCt);
      vglS[vglSCt - 1] := strArray[i];
    end;
  end;

  // Ende der Array Vergleiche

  if ctopic = fltTopicUserName then
  begin
    vString := edValue.Text;
  end;

  if ctopic = fltTopicComment then
  begin
    vString := edValue.Text;
  end;

  if (ctopic = fltTopicAccountDate) or (ctopic = fltTopicOpenDateTime) or (ctopic = fltTopicCloseDateTime) or
    (ctopic = fltTopicCloseDateTimeOrOpen)

  then
  begin
    // oben:dtPicker1.DateTime:=getDateTimeFromString(edValue.Text); ->
    vString := edValue.Text;
    if (vString = '') then
      vString := '0';
    if pos('.', vString) = 0 then // keine Angabe wie 12.01.2019
    begin
      if (vString = '') then
        vInteger := 0
      else
        vInteger := getUnixTimeFromString(edValue.Text);
      // vInteger := strtoint(vString)
    end
    else
      vInteger := datetimetounix(strtodatetime(vString));
  end;

  if (ctopic = fltTopicOpenPrice) or (ctopic = fltTopicVolume) OR (ctopic = fltTopicProfit) OR
    (ctopic = fltTopicMarginRate) then
    vDouble := mystringtofloat(edValue.Text);

  if (ctopic = fltTopicActionInTimeRange) then
  begin
    // very special wird später zugewiesen
  end;

end;

function TFilterElemente.vergleichIntegerGleich(var mit, was: Integer): boolean;
begin
  result := false;
  inc(counter);
  if was = mit then
    result := true;
end;

function TFilterElemente.vergleichInteger(var mit, was: Integer; op: Integer): boolean;
begin
  result := false;
  inc(counter);
  if op = fltOpGleich then
  begin
    if was = mit then
      result := true;
    exit;
  end;
  if op = fltOpGroesser then
  begin
    if was > mit then
      result := true;
    exit;
  end;
  if op = fltOpKleiner then
  begin
    if was < mit then
      result := true;
    exit;
  end;
  if op = fltOpGrGleich then
  begin
    if was >= mit then
      result := true;
    exit;
  end;
  if op = fltOpKlGleich then
  begin
    if was <= mit then
      result := true;
    exit;
  end;
  if op = fltOpUnGleich then
  begin
    if was <> mit then
      result := true;
    exit;
  end;
  if op = fltOpGroesserOderNull then
  begin
    if ((was > mit) or (was = 0)) then
      result := true;
    exit;
  end;
  if op = fltOpGroesserGleichOderNull then
  begin
    if ((was >= mit) or (was = 0)) then
      result := true;
    exit;
  end;
  if op = fltOpKlNotNull then
  begin
    if ((was < mit) and (was <> 0)) then
      result := true;
    exit;
  end;
  if op = fltOpKlOrNull then
  begin
    if ((was < mit) or (was = 0)) then
      result := true;
    exit;
  end;

end;

function TFilterElemente.vergleichDouble(var mit, was: double; op: Integer): boolean;
begin
  result := false;
  inc(counter);
  if op = fltOpGleich then
  begin
    if was = mit then
      result := true;
    exit;
  end;
  if op = fltOpGroesser then
  begin
    if was > mit then
      result := true;
    exit;
  end;
  if op = fltOpKleiner then
  begin
    if was < mit then
      result := true;
    exit;
  end;
  if op = fltOpGrGleich then
  begin
    if was >= mit then
      result := true;
    exit;
  end;
  if op = fltOpKlGleich then
  begin
    if was <= mit then
      result := true;
    exit;
  end;
  if op = fltOpUnGleich then
  begin
    if was <> mit then
      result := true;
    exit;
  end;
  if op = fltOpGroesserOderNull then
  begin
    if ((was > mit) or (was = 0)) then
      result := true;
    exit;
  end;
  if op = fltOpGroesserGleichOderNull then
  begin
    if ((was >= mit) or (was = 0)) then
      result := true;
    exit;
  end;

end;

function TFilterElemente.vergleichIntegerArray(var mit: array of Integer; var was: Integer; op: Integer): boolean;
// eines der Kriterien passt -> true
// das ist aber nicht immer sinnvoll nämlich bei <>
var
  i: Integer;
  res: boolean;
begin
  if (op = fltOpUnGleich) then
  begin
    res := true;
    for i := 0 to length(mit) - 1 do
    begin
      res := vergleichInteger(mit[i], was, op);
      if res = false then
        break
    end;

  end
  else
  begin

    res := false;
    for i := 0 to length(mit) - 1 do
    begin
      res := vergleichInteger(mit[i], was, op);
      if res = true then
        break
    end;
  end;
  result := res;
end;

function TFilterElemente.vergleichString(var mit, was: string; op: Integer): boolean;
begin
  result := false;
  if op = fltOpGleich then
  begin
    if was = mit then
      result := true;
    exit;
  end;
  if op = fltOpGroesser then
  begin
    if was > mit then
      result := true;
    exit;
  end;
  if op = fltOpKleiner then
  begin
    if was < mit then
      result := true;
    exit;
  end;
  if op = fltOpGrGleich then
  begin
    if was >= mit then
      result := true;
    exit;
  end;
  if op = fltOpKlGleich then
  begin
    if was <= mit then
      result := true;
    exit;
  end;
  if op = fltOpUnGleich then
  begin
    if was <> mit then
      result := true;
    exit;
  end;
  if op = fltOpContains then
  begin
    if pos(mit, was) > 0 then
      result := true;
    exit;
  end;
  if op = fltOpBegins then
  begin
    if pos(mit, was) = 1 then
      result := true;
    exit;
  end;

end;

function TFilterElemente.vergleichStringArray(var mit: array of string; was: string; op: Integer): boolean;
var
  i: Integer;
  p: Integer;
begin
  result := false;
  for i := 0 to length(mit) - 1 do
  begin
    result := vergleichString(mit[i], was, op);
    // erster Treffer ist hinreichend genug dann abbrechen
    if result = true then
      exit;
  end;
end;

function TFilterElemente.findUserName(userId: Integer): string;
var
  i: Integer;
  p: Integer;

begin
  // statt ca 10000 -> 2736  nicht die Welt aber besser als vorher
  // mit Binsearch2 sinds: 850  Super:-)
  // Die Suche sucht aus 50001234=12345 binär schnell die 12345 heraus
  // Das zweite Array enthält gleich die =12345 Werte damit diese nicht aus dem String 50001234=12345 mit StrToInt herausgelesen werden müssen
  i := BinSearchString2(cwuserssortindex, cwuserssortindex2, userId);
  if (i > -1) then
  begin
    p := pos('$', cwuserssortindex[i]);

    result := cwusers[strtoint(midstr(cwuserssortindex[i], p + 1, 255))].name;
  end
  else
    result := '?';

  // NEU cwUsersSortIndex enthält sortiert die userId=index

  // for i := 0 to length(cwusers) - 1 do
  // begin
  // if cwusers[i].userId = userId then
  // begin
  // result := cwusers[i].name;
  // break;
  // end;
  // end;
end;

procedure TFilterElemente.FrameClick(Sender: TObject);
begin
  mmc := mmc;
end;

procedure TFilterElemente.FrameExit(Sender: TObject);
begin
  //
  if btnMore.Caption = '<' then
    btnMoreClick(nil);

end;

procedure TFilterElemente.setValues(f: TFilterParameter);
begin
  chkActive.Checked := f.active;
  cbTopic.Text := f.topic;
  if (chkActive.Checked) = true then
    cbTopicChange(nil); // damit die Felder rechts entsprechend aktiviert/ausgefüllt werden
  cbOperator.Text := f.operator;
  edValue.Text := f.values;

end;

procedure TFilterElemente.getValues(f: TFilterParameter);
var
  s: string;
  charArray: Array [0 .. 0] of Char;
begin
  f.active := chkActive.Checked;
  f.topic := vorQuote(cbTopic.Text);
  f.operator := cbOperator.Text;
  f.values := edValue.Text;
  charArray[0] := ',';
  s := edValue.Text;

  operators := cbOperator.Text;

  if operators = '=' then
    coperator := fltOpGleich;
  if operators = '<>' then
    coperator := fltOpUnGleich;
  if operators = '>' then
    coperator := fltOpGroesser;
  if operators = '> or 0' then
    coperator := fltOpGroesserOderNull;
  if operators = '>= or 0' then
    coperator := fltOpGroesserGleichOderNull;
  if operators = '< not 0' then
    coperator := fltOpKlNotNull;
  if operators = '< or 0' then
    coperator := fltOpKlOrNull;

  if operators = '<' then
    coperator := fltOpKleiner;
  if operators = '>=' then
    coperator := fltOpGrGleich;
  if operators = '<=' then
    coperator := fltOpKlGleich;
  if operators = 'contains' then
    coperator := fltOpContains;
  if operators = 'begins' then
    coperator := fltOpBegins;
  if operators='true' then
    coperator:=fltOpTrue;
  if operators='false' then
    coperator:=fltOpFalse;

  topic := vorQuote(cbTopic.Text);

  if topic = 'BrokerId' then
    ctopic := fltTopicBrokerId; // 1;
  if topic = 'AccountId' then
    ctopic := fltTopicAccountId; // 2;
  if topic = 'UserId' then
    ctopic := fltTopicUserId; // 3;
  if topic = 'Symbol' then
    ctopic := fltTopicSymbol; // = 4;
  if topic = 'SymbolId' then
    ctopic := fltTopicSymbolId; // 5;
  if topic = 'ActionType' then
    ctopic := fltTopicActionType; // = 6;
  if topic = 'UserName' then
    ctopic := fltTopicUserName; // = 7;
  if topic = 'Profit' then
    ctopic := fltTopicProfit; // = 8;
  if topic = 'AccountDate' then
    ctopic := fltTopicAccountDate; // = 9;
  if topic = 'AccountDateUnix' then
    ctopic := fltTopicAccountDateUnix; // = 10;
  if topic = 'OpenDateTime' then
    ctopic := fltTopicOpenDateTime; // = 11;
  if topic = 'CloseDateTime' then
    ctopic := fltTopicCloseDateTime; // = 13;
  if topic = 'OpenPrice' then
    ctopic := fltTopicOpenPrice; // = 15;
  if topic = 'Profit' then
    ctopic := fltTopicProfit; // = 16;
  if topic = 'Volume' then
    ctopic := fltTopicVolume; // = 17;
  if topic = 'MarginRate' then
    ctopic := fltTopicMarginRate; // = 17;
  if topic = 'AccountCurrency' then
    ctopic := fltTopicAccountCurrency; // = 18;
  if topic = 'CloseDateTime OR Open' then
    ctopic := fltTopicCloseDateTimeOrOpen; // = 19;
  if topic = 'Comment' then
    ctopic := fltTopicComment; // = 20
  if topic = 'Action in TimeRange' then
    ctopic := fltTopicActionInTimeRange; // = 21

  // Rest passiert beim Aufrufer
end;

function TFilterElemente.findSymbol(symbolId: Integer): string;
var
  i: Integer;
begin
  result := '';
  if symbolId > length(cwsymbols) then
    exit;
  if cwsymbols[symbolId].symbolId = symbolId then
  begin
    result := cwsymbols[symbolId].name;
    exit;
  end;

  // das hier sollte nie vorkommen - es sei denn die Symbole sind nicht mehr richtig sortiert !
  for i := 0 to length(cwsymbols) - 1 do
  begin
    if cwsymbols[i].symbolId = symbolId then
    begin
      result := cwsymbols[i].name;
      break;
    end;
  end;
end;

function TFilterElemente.checkCwaction(var a: cwaction; var aplus: cwActionPlus): boolean;
// prüft ob eine CwAction den Filterkriterien entspricht

// BrokerId
// AccountId
// UserId
// UserName
// ActionType
// AccountDate
// OpenDateTimeUnix
// OpenDateTime
// CloseDateTimeUnix
// CloseDateTime
// OpenPrice
// Profit
// SymbolId
// Symbol  =
// Lotsize
// Action in TimeRange

// was wird verglichen - Index aus einer Liste bzw eine Zahl(Integer) oder Double  / oder ein String / ein Datum TDate  /
// mit was wird verglichen - muss eigentlich derselbe Daten typ sein
// also jeweils eine Vergleichsfunktion nach einem dieser Typen, die dann true oder false liefert

// ist eigentlich viel schwieriger wenn statt echter Ids irgendwelche Strings verwendet werden

// dem Suchfeld LCG A,ActiveTrades C entspricht die Suche 1,5 - das ist aber schlecht leserlich
// die festen Suchen nach Broker,BrokerAccount,ActionType könnten von Stringfeld in ein Id-Feld umgerechnet werden

// schwierig ist es bei Symbolen
// die = Suche darf nur aus festen Symbolen bestehen. Hier müsste man zB DAXF09,Silber,Gold -> 123,345,6675 umwandeln und darüber suchen
// die enthält oder beginnt Suche muss die Suchstrings direkt selbst vergleichen

// die Nummersuche ohne CheckBoxListe vergleicht direkt Zahlenwerte

// Die Datumssuche vergleicht ebenfalls direkt Zahlenwerte
var
  s: string;
begin

  // result:=true;   //so nur 31 statt 3136
  // exit;
  try
    if vglSCt > 1 then
    begin
      if (ctopic = fltTopicSymbol) then
      begin
        result := vergleichStringArray(vglS, findSymbol(a.symbolId), coperator);
        exit;
      end;
    end
    else
    begin
      if (ctopic = fltTopicSymbol) then
      begin
        s := findSymbol(a.symbolId);
        result := vergleichString(vglS[0], s, coperator);
        exit;
      end;

    end;

    if vglICt >= 1 then
    // wenn mit mehreren Elementen verglichen wird
    begin
      if ctopic = fltTopicBrokerId then
      begin
        result := vergleichIntegerArray(vglI, brokerId[a.accountId], coperator);
        exit;
      end;

      if ctopic = fltTopicAccountId then
      begin
        result := vergleichIntegerArray(vglI, a.accountId, coperator);
        exit;
      end;

      if ctopic = fltTopicUserId then
      begin
        result := vergleichIntegerArray(vglI, a.userId, coperator);
        exit;
      end;

      if (ctopic = fltTopicSymbolId) and (coperator = fltOpGleich) then
      begin
        result := vergleichIntegerArray(vglI, a.symbolId, coperator);
        exit;
      end;

      if ctopic = fltTopicActionType then
      begin
        result := vergleichIntegerArray(vglI, a.typeId, coperator);
        exit;
      end;

      if ctopic = fltTopicAccountCurrency then
      begin
        result := vergleichIntegerArray(vglI, cwusersPlus[aplus.userindex].accountCurrency, coperator);
        exit;
      end;

    end
    else
    // wenn nur mit einem Element verglichen wird
    begin
      if ctopic = fltTopicBrokerId then
      begin
        result := vergleichInteger(vglI[0], brokerId[a.accountId], coperator);
        exit;
      end;

      if ctopic = fltTopicAccountId then
      begin
        result := vergleichInteger(vglI[0], a.accountId, coperator);
        exit;
      end;

      if ctopic = fltTopicUserId then
      begin
        result := vergleichInteger(vglI[0], a.userId, coperator);
        exit;
      end;

      if (ctopic = fltTopicSymbolId) and (coperator = fltOpGleich) then
      begin
        result := vergleichInteger(vglI[0], a.symbolId, coperator);
        exit;
      end;

      if ctopic = fltTopicActionType then
      begin
        result := vergleichInteger(vglI[0], a.typeId, coperator);
        exit;
      end;

    end;

    // Ende der Array Vergleiche

    if ctopic = fltTopicComment then
    begin
      s := getcwcomment(a.commentId);
      result := vergleichString(vString, s, coperator);
      exit;
    end;

    if ctopic = fltTopicUserName then
    begin
      s := findUserName(a.userId);
      result := vergleichString(vString, s, coperator);
      exit;
    end;

    if ctopic = fltTopicProfit then
    begin
      result := vergleichDouble(vDouble, a.profit, coperator);
      exit;
    end;

    if ctopic = fltTopicOpenDateTime then
    begin
      result := vergleichInteger(vInteger, a.openTime, coperator);
      exit;

    end;

    if ctopic = fltTopicCloseDateTime then
    begin
      result := vergleichInteger(vInteger, a.closeTime, coperator);
      exit;

    end;

    if ctopic = fltTopicOpenPrice then
    begin
      result := vergleichDouble(vDouble, a.openPrice, coperator);
      exit;
    end;

    if ctopic = fltTopicProfit then
    begin
      result := vergleichDouble(vDouble, a.profit, coperator);
      exit;

    end;

    if ctopic = fltTopicVolume then
    begin
      result := vergleichDouble(vDouble, a.profit, coperator);
      exit;
    end;
    if ctopic = fltTopicMarginRate then
    begin
      result := vergleichDouble(vDouble, a.marginRate, coperator);
      exit;
    end;

    if ctopic = fltTopicAccountCurrency then
    begin
      result := vergleichInteger(vInteger, cwusersPlus[aplus.userindex].accountCurrency, coperator);
      exit;
    end;

    if ctopic = fltTopicCloseDateTimeOrOpen then
    begin
      result := vergleichInteger(vInteger, a.closeTime, coperator);
      // zusätzlich der Vergleich ob in diesem Zeitraum die Action open war. Also closeTime=0 und openTime
      // Problem weil es zwei open Fälle gibt, die hier nicht ausgefiltert werden sollen:
      // open vor A und kein Close
      // open nach A und kein Close
      // ist zusammen einfach open ja - close nein

      // wenn > vergleich
      if (coperator = fltOpGrGleich) then
        if (a.openTime <> 0) then
          // wenn es eine opentime gibt
          if (a.closeTime = 0) then
            // und nicht geschlossen dann -> true
            if (result = false) then
              result := true;

      // wenn < vergleich
      if (coperator = fltOpKleiner) then
        if (a.openTime < vInteger) then
          if (a.closeTime = 0) then
            result := true;

      exit;

    end;
    if ctopic = fltTopicActionInTimeRange then
    begin
       if((a.openTime>=vinteger) and (a.openTime<=vinteger2))or((a.closeTime>=vinteger) and ((a.closeTime<>0)and(a.closeTime<=vinteger2))) then
       begin
           if (coperator = fltOpTrue) then
             result:=true;
           if (coperator = fltOpFalse) then
             result:=false;
       end
       else
       begin
           if (coperator = fltOpTrue) then
             result:=false;
           if (coperator = fltOpFalse) then
             result:=true;

       end;


    end;

  except
    result := false;
  end;
end;

procedure TFilterElemente.chkActiveClick(Sender: TObject);
begin
  if chkActive.Checked = false then
  begin
    cbTopic.Visible := false;
    cbOperator.Visible := false;
    chkLB1.Visible := false;
    edValue.Visible := false;
    dtPicker1.Visible := false;
    btnMore.Visible := false;
  end
  else
  begin
    cbTopic.Visible := true;
    cbOperator.Visible := true;
    cbTopicChange(nil);
  end;
end;

procedure TFilterElemente.chkLB1Click(Sender: TObject);
begin
  //
  mmc := mmc;
end;

procedure TFilterElemente.chkLB1DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  setlength(chkLB1Selected, TComboBox(Control).Items.Count);
  with TComboBox(Control).Canvas do
  begin
    FillRect(Rect);

    Rect.left := Rect.left + 1;
    Rect.Right := Rect.left + 13;
    Rect.Bottom := Rect.Bottom;
    Rect.Top := Rect.Top;

    if not(odSelected in State) and (chkLB1Selected[Index]) then
      DrawFrameControl(Handle, Rect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED or DFCS_FLAT)
    else if (odFocused in State) and (chkLB1Selected[Index]) then
      DrawFrameControl(Handle, Rect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED or DFCS_FLAT)
    else if (chkLB1Selected[Index]) then
      DrawFrameControl(Handle, Rect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED or DFCS_FLAT)
    else if not(chkLB1Selected[Index]) then
      DrawFrameControl(Handle, Rect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_FLAT);

    TextOut(Rect.left + 15, Rect.Top, TComboBox(Control).Items[Index]);
  end;
end;

procedure TFilterElemente.chkLB1Exit(Sender: TObject);
begin
  if btnMore.Caption = '<' then
    wegdamit;
end;

procedure TFilterElemente.chkLB1Select(Sender: TObject);
var
  i: Integer;
  Sel: string;
begin
  mmon := true;
  Sel := EmptyStr;
  chkLB1Selected[TComboBox(Sender).itemindex] := not chkLB1Selected[TComboBox(Sender).itemindex];
  for i := 0 to TComboBox(Sender).Items.Count - 1 do
    if chkLB1Selected[i] then
      Sel := Sel + TComboBox(Sender).Items[i] + ' ';
  chkLB1.InvalIdate;
  chkLB1.DroppedDown := true;
  mmon := false;
end;

function TFilterElemente.findSymbolId(symbol: string): Integer;
var
  i: Integer;
begin
  result := -1;

  for i := 0 to length(cwsymbols) - 1 do
  begin
    if cwsymbols[i].name = symbol then
    begin
      result := cwsymbols[i].symbolId;
      break;
    end;
  end;
end;

end.
