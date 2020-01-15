unit UDynGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Clipbrd, Vcl.Grids, StringGridSorted,
  Vcl.ExtCtrls, MMSystem,
  FTCommons, FTTypes, System.strutils, Vcl.Menus, Vcl.Buttons, ShellApi;

type
  TDynGrid = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    ScrollBar1: TScrollBar;
    lblHeader: TLabel;
    lblTime: TLabel;
    Panel3: TPanel;
    SG: TStringGridSorted;
    SGSum: TStringGridSorted;
    lblSelection: TLabel;
    SpeedButton1: TSpeedButton;
    PopupMenu1: TPopupMenu; // ColumnSelection und CSV-Export
    Selectcolumns1: TMenuItem;
    CSVExport1: TMenuItem;
    PopupMenu0: TPopupMenu; // ColumnSelection
    MenuItem1: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    CSVExportSelection1: TMenuItem;
    PopupMenu3: TPopupMenu;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    RemoveSelection1: TMenuItem;
    RemoveallbutSelection1: TMenuItem;
    PopupMenu4: TPopupMenu;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem10: TMenuItem;
    Selection2ndGrid1: TMenuItem;
    PopupMenu5: TPopupMenu;
    MenuItem9: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MarkSelection1: TMenuItem;
    MarkSelection2: TMenuItem;
    xxx1: TMenuItem;
    constructor Create(AOwner: TComponent); override;
    procedure saveInit();
    procedure suchInSpalte(dorepeat: boolean = false; doCount: boolean = false);
    procedure Panel2Resize(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure initGrid(source: string; sortCol: string; sortDir: integer; rows: integer; cols: integer);

    procedure doSorting();
    procedure doUpdateStyleElements();
    procedure sortGridCwOpenActions(source: string; sortCol: string; sortDir: integer; var actions: DACwOpenActions);
    procedure sortGridCwOpenActionsOTR(source: string; sortCol: string; sortDir: integer; var actions: DATradeRecord);

    procedure sortGridCwactions(source: string; sortCol: string; sortDir: integer; var actions: DACwAction);
    procedure sortGridCwUsers(source: string; sortCol: string; sortDir: integer; var users: DACwUser; var usersplus: DACwUserPlus);

    procedure sortGridCwComments(source: string; sortCol: string; sortDir: integer; var comments: DACwComment);
    procedure sortGridCwSymbolsGroups(source: string; sortCol: string; sortDir: integer; var symbolsGroups: DACwSymbolGroup);
    procedure sortGridCwSymbols(source: string; sortCol: string; sortDir: integer; var symbols: DACwSymbol; var symbolsPlus: DACwSymbolPlus);
    procedure sortGridCw3Summaries(source: string; sortCol: string; sortDir: integer; var summaries: DA3CwSummary);
    procedure sortGridCwSummaries(source: string; sortCol: string; sortDir: integer; var summaries: DACwSummary);

    procedure SGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure gridHandler(pexp: pExport);
    procedure SGRowMoved(Sender: TObject; FromIndex, ToIndex: integer);
    procedure SGMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure SGDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: integer);
    procedure SGSumMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure SGTopLeftChanged(Sender: TObject);
    procedure SGMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: boolean);
    procedure SGMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: boolean);
    procedure makeSummary(mdcol, mdrow: integer; header: string);
    procedure makeSummaries();
    procedure SGKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SGKeyPress(Sender: TObject; var Key: Char);
    procedure SGSelectCell(Sender: TObject; ACol, ARow: integer; var CanSelect: boolean);
    procedure workSelection(mdrow, murow: integer; Button: TMouseButton; Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Selectcolumns1Click(Sender: TObject);
    procedure CSVExport1Click(Sender: TObject);
    procedure RemoveSelection1Click(Sender: TObject);
    procedure RemoveallbutSelection1Click(Sender: TObject);
    procedure doRemoveSelection(typ: integer); // 1=sel weg 2=nur Selection belassen
    procedure doRemoveSelectionOTR(typ: integer);
    procedure Panel1Click(Sender: TObject);
    procedure UserSelectionTo2ndGrid(Sender: TObject; doClear: boolean = true);
    procedure Selection2ndGrid1Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure doRemoveSelectionUsersX(allBut: boolean);
    procedure MarkSelection1Click(Sender: TObject);
    procedure doMarkSelection(users: DACwUser; usersplus: DACwUserPlus);
    procedure MarkSelection2Click(Sender: TObject);
    procedure doMarkFilteredActionsSelection();
  private
  { Private-Deklarationen }
    const
    cPrivat = 1;

  var
    privat: integer;
  public
  { Public-Deklarationen }
    const
    mouseDownPause = 220;
    iniHeader = 'sfcscf1';
    // bei jeder Erweiterung der Spalten treten Fehler auf - daher hier einen anderen Header wählen ..

  var
    merkDynGridSuch: string;
    SGFieldCol: DAInteger;
    SGColField: DAInteger;
    initialized: boolean;
    maxDataRows, visibleCols, visibleRows, scrollPosition: integer;
    source: string;
    dSort: doubleArray;
    sSort: Stringarray;
    sDatenTyp: integer; // 1=Double 2=String NEU 12.12.19 zur nachträglichen Verwendung von ssort oder dsort
    ixSorted: intarray; // actionindex(sortindex)=nummer der Action/User/... in der Zeile sortindex
    selSorted: byteArray; // jeweils 0 oder 1=selektiert
    selectedCt: integer;
    sortTyp: integer;
    sortDir: integer;
    sortCol: string;
    mdcol, mdrow: integer;
    mucol, murow: integer;
    autosized: boolean;
    scrollBar1RepeatCount: integer;
    topic: string;
    lastMouseDown: cardinal; // doppelte Ausführung verhindern
  end;

procedure Register;

implementation

{$R *.dfm}

uses XFlowAnalyzer, Dialog1;

procedure Register;
begin
  RegisterComponents('Samples', [TDynGrid]);
end;

constructor TDynGrid.Create(AOwner: TComponent);
begin
  // hier können eider die Spalten noch nicht initialisert werden sondern erst in init
  inherited Create(AOwner);
  initialized := false;
  maxDataRows := 0;
  setlength(dSort, 0); // warum nur die beiden ?
  setlength(sSort, 0);
end;

procedure TDynGrid.CSVExport1Click(Sender: TObject);
var
  expo: TExport;
  fname: string;
  ok: boolean;
  mItem: TMenuItem;
  s: string;
  sz: integer;
  btn: integer;
begin
  // Export test
  fname := 'export.csv';
  mItem := Sender as TMenuItem;
  s := mItem.Caption;
  if (containstext(s, 'Selection')) then
    expo.onlySelection := true
  else
    expo.onlySelection := false;

  ok := InputQuery('Export to CSV-File', 'Filename:', fname);
  if (ok = false) then
    exit;

  if (fname = '') then
    exit;
  expo.fileName := fname;
  expo.separator := ';';
  gridHandler(@expo);
  sz := Get_File_Size(fname);

  btn := mrOk;
  if (sz > 5000000) then
  begin
    btn := messagedlg('Very large file - open now ?', mtWarning, mbOKCancel, 0);
  end;
  if (btn = mrOk) then
    ShellExecute(Application.Handle, 'open', PChar('notepad.exe'), PChar(fname), Nil, SW_NORMAL);
end;

procedure TDynGrid.SGRowMoved(Sender: TObject; FromIndex, ToIndex: integer);
// diese gridinterne Funktion ist beim DynGrid abgeschaltet
var
  i: integer;
begin
  //
  exit;
  //
  // i := SGFieldCol[FromIndex];
  // SGFieldCol[FromIndex] := SGFieldCol[ToIndex];
  // SGFieldCol[ToIndex] := i;
  // for i := 0 to SG.Colcount - 1 do
  // begin
  // // sgcolfield(sg.Cols[i,0].Text
  //
  // end;
end;

procedure TDynGrid.SGSelectCell(Sender: TObject; ACol, ARow: integer; var CanSelect: boolean);
begin
  //
end;

procedure TDynGrid.SGSumMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  i: integer;
  grid: FTCommons.TStringGridSorted;
  col, row: integer;
  fixedCol, fixedRow: boolean;
  gt: cardinal;
  Cursor: TCursor;
  header: string;
begin
  // SUmmen werden gebildet nach Rechtsclick in den Spaltenheader
  gt := timegettime();
  grid := Sender as FTCommons.TStringGridSorted;
  // diese Routine ist nicht im FTCollector sondern nur im FlowAnalyzer
  if Button = mbright then
  begin
    grid.MouseToCell(X, Y, col, row);
    mdcol := col;
    mdrow := row;

    header := SG.Cells[mdcol, 0];

    makeSummary(mdcol, mdrow, header);

  end;
end;

procedure TDynGrid.makeSummaries();
// es geht natürlich nicht an, dass diese Routine bei jedem Resize usw aufgerufen wird, obwohl sich die Werte überhaupt nicht ändern
var
  i: integer;
begin

  for i := 0 to SG.colcount - 1 do
  begin
    makeSummary(i, 0, SG.Cells[i, 0]);
  end;

end;

procedure TDynGrid.makeSummary(mdcol, mdrow: integer; header: string);
// diese Routine wird für jede Spalte getrennt aufgerufen und berechnet je nach source (cwsummaries oder cwfilteredactions) bestimmte Summen
var
  sumd: double;
  sumi: integer;
  sume: extended;
  typ: integer;
  sump: array [0 .. 4] of double;
  summe: string;
  i: integer;
  hc: integer; // Height count bei Profit
begin
  summe := '';
  if (source = 'cwsummaries') then
  begin
    if (ansiindextext(header, ['tradesCount', 'tradesVolumeTotal', 'tradesProfitTotal', 'tradesSwapTotal', 'tradesProfitSwapTotal']) > -1) then
    begin
      sumi := 0;
      sumd := 0;
      sume := 0;
      // Wert berechnen
      if (header = 'tradesCount') then
        typ := 0;
      if (header = 'tradesVolumeTotal') then
        typ := 1;
      if (header = 'tradesProfitTotal') then
        typ := 2;
      if (header = 'tradesSwapTotal') then
        typ := 3;
      if (header = 'tradesProfitSwapTotal') then
        typ := 4;
      for i := 0 to length(ixSorted) - 1 do
      begin
        case typ of
          0:
            begin
              sumi := sumi + cwsummaries[ixSorted[i]].sTradesCount;
            end;
          1:
            begin
              sumi := sumi + cwsummaries[ixSorted[i]].sTradesVolumeTotal;
            end;
          2:
            begin
              sume := sume + cwsummaries[ixSorted[i]].sTradesProfitTotal; // das sind Werte in gemischten Währungen
            end;
          3:
            begin
              sume := sume + cwsummaries[ixSorted[i]].sTradesSwapTotal;
            end;
          4:
            begin
              sume := sume + cwsummaries[ixSorted[i]].sTradesProfitSwapTotal;
            end;
        end;
      end;
      case typ of
        0:
          begin
            summe := inttostr(sumi);
          end;
        1:
          begin
            summe := FormatFloat(',#0.00', sumi / 100); // !! nur bei TradesVolumeTotal ist das so !!
          end;
        2:
          begin
            summe := FormatFloat(',#0.00', sume);
          end;
        3:
          begin
            summe := FormatFloat(',#0.00', sume);
          end;
        4:
          begin
            summe := FormatFloat(',#0.00', sume);
          end;
      end;
      SGSum.Cells[mdcol, mdrow] := summe;

    end;
  end;
  if (source = 'cwFilteredActions') then
  begin
    if (ansiindextext(header, ['profit', 'volume', 'swap']) > -1) then
    begin
      sumi := 0;
      sumd := 0;
      for i := 0 to 4 do
        sump[i] := 0;
      hc := 1;
      // Wert berechnen
      if (header = 'profit') then
        typ := 0;
      if (header = 'volume') then
        typ := 1;
      if (header = 'swap') then
        typ := 2;
      // hier erst werden die ganzen gefiltereten Actions durchlaufen und die Summen gebildet
      // warum ixsorted ? Die Sortierung ist hier eigentlich ganz egal
      for i := 0 to length(ixSorted) - 1 do
      begin
        case typ of
          0: // profit
            begin
              // unterscheiden: wenn ClosedTime<>0 ist es echter Profit - sonst OpenProfit 'jetzt'
              sumd := sumd + cwFilteredActions[ixSorted[i]].profit;

              // Profit ist immer in Account-Währung Swap ist in Euro
              sump[cwusersplus[cwFilteredactionsPlus[ixSorted[i]].userindex].accountcurrency] := sump[cwusersplus[cwFilteredactionsPlus[ixSorted[i]].userindex].accountcurrency] + cwFilteredActions[ixSorted[i]].profit;
            end;
          1: // volume
            begin
              sumi := sumi + cwFilteredActions[ixSorted[i]].volume;
            end;
          2: // swap
            begin
              sumd := sumd + cwFilteredActions[ixSorted[i]].swap;
            end;
        end;
      end;

      case typ of
        0:
          begin
            summe := FormatFloat(',#0.00', sumd);
            if (sump[2] + sump[3] + sump[4]) <> 0 then
            begin
              summe := '';
              if (sump[1] <> 0) then
              begin
                summe := summe + ' EUR:' + FormatFloat(',#0.00', sump[1]);
                hc := 1;
              end;
              if (sump[2] <> 0) then
              begin
                summe := summe + #13#10 + ' USD:' + FormatFloat(',#0.00', sump[2]);
                hc := hc + 1;
              end;
              if (sump[3] <> 0) then
              begin
                summe := summe + #13#10 + ' CHF:' + FormatFloat(',#0.00', sump[3]);
                hc := hc + 1;
              end;
              if (sump[4] <> 0) then
              begin
                summe := summe + #13#10 + ' GBP:' + FormatFloat(',#0.00', sump[4]);
                hc := hc + 1;
              end;

            end;
          end;
        1:
          begin
            summe := FormatFloat(',#0.00', sumi / 100);
          end;
        2:
          begin
            summe := FormatFloat(',#0.00', sumd);
          end;
      end;

      SGSum.Cells[mdcol, mdrow] := summe;
      if typ = 0 then
      // nur bei Profit wird die Höhe verändert
      begin
        SGSum.rowheights[0] := 6 + (hc * (SGSum.defaultrowheight - 6));
        SGSum.Height := SGSum.rowheights[0] + 2;
      end;
    end
    else
      SGSum.Cells[mdcol, mdrow] := '';

  end;

end;

procedure TDynGrid.MarkSelection1Click(Sender: TObject);
begin
  if (source = 'cwusersx') then
    doMarkSelection(cwusersx, cwusersxplus);
  if (source = 'cwfilteredactions') then
    doMarkSelection(cwusers, cwusersplus);

end;

procedure TDynGrid.MarkSelection2Click(Sender: TObject);
begin
  doMarkSelection(cwusers, cwusersplus);
end;

procedure TDynGrid.doMarkFilteredActionsSelection;
var
  i, p: integer;
  s: string;
  newMarker: string;
  flag: boolean;
  typ: integer;
  doDelete: boolean;
begin
  //
  if (source = 'cwfilteredactions') then
  begin

  end;
end;

procedure TDynGrid.doMarkSelection(users: DACwUser; usersplus: DACwUserPlus);
// text=-> marker
// -text= text wird aus Marker entfernt
// -- Marker wird gelöscht
var
  i, p: integer;
  s: string;
  newMarker: string;
  flag: boolean;
  uix, typ: integer;
  doDelete: boolean;
  gt: cardinal;
  ba: array of byte;
begin
  // Mark Selection
  if (source = 'cwusers2') then
    typ := 1;
  if (source = 'cwusersx') then
    typ := 2;
  if (source = 'cwfilteredactions') then
    typ := 3;

  if ((source = 'cwusers2') or (source = 'cwusersx') or (source = 'cwfilteredactions')) then
  begin
    // Eingabe eines Markers - dann werden alle usersPlus.Marker mit diesem Marker versehen
    newMarker := 's';
    newMarker := InputBox('Marker Input', 'Marker (-X=delete X --=delete Marker):', '1');
    if (newMarker = '') then
      exit;
    // wenn nix selektiert ist sollen alle verwendet werden

    gt := gettickcount;
    doDelete := false;
    if (newMarker[1] = '-') then
    begin
      doDelete := true;
      newMarker := newMarker.subString(1);
    end;

    if (typ = 3) then
    begin
      flag := false;
      setlength(ba, length(cwusers));
      for i := 0 to length(cwFilteredActions) - 1 do
      begin
        if (selSorted[i] <> 0) then
        begin
          flag := true;
          break;
        end;
      end;
      for i := 0 to length(cwFilteredActions) - 1 do
      begin
        if ((selSorted[i] <> 0) or (flag = false)) then
        begin
          // falsch
          uix := finduserindex(cwFilteredActions[i].userId);
          if (ba[uix] = 0) then
          begin
            ba[uix]:=1;
            s := usersplus[uix].marker;
            if (doDelete = false) then
            begin
              if (pos(newMarker, s) = 0) then
              begin
                s := s + newMarker;
                cwusersplus[uix].marker := s;
              end;
            end;
            if (doDelete = true) then
            begin
              if (newMarker = '-') then
              begin
                cwusersplus[uix].marker := '';
              end
              else
              begin
                p := pos(newMarker, s); // 0=nix 1..len   ungewöhnliche Zählung
                if (p > 0) then
                begin
                  s := s.subString(0, p - 1) + s.subString(p - 1 + length(newMarker));
                  cwusersplus[uix].marker := s;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
    if ((typ = 1) or (typ = 2)) then
    begin
      flag := false;
      for i := 0 to length(users) - 1 do
      begin
        if (selSorted[i] <> 0) then
        begin
          flag := true;
          break;
        end;
      end;
      for i := 0 to length(users) - 1 do
      begin
        if ((selSorted[i] <> 0) or (flag = false)) then
        begin
          if (typ = 1) then
            s := usersplus[i].marker;
          if (typ = 2) then
            s := cwusersplus[usersplus[i].multi].marker;
          if (doDelete = false) then
          begin
            if (pos(newMarker, s) = 0) then
            begin
              s := s + newMarker;
              if (typ = 2) then
                cwusersplus[usersplus[i].multi].marker := s;
              usersplus[i].marker := s;
            end;
          end;
          if (doDelete = true) then
          begin
            if (newMarker = '-') then
            begin
              if (typ = 2) then
                cwusersplus[usersplus[i].multi].marker := '';
              usersplus[i].marker := '';
            end
            else
            begin
              p := pos(newMarker, s); // 0=nix 1..len   ungewöhnliche Zählung
              if (p > 0) then
              begin
                s := s.subString(0, p - 1) + s.subString(p - 1 + length(newMarker));
                if (typ = 2) then
                  cwusersplus[usersplus[i].multi].marker := s;
                usersplus[i].marker := s;
              end;
            end;
          end;

        end;
      end;
    end;
    // und auf die Platte schreiben !
    writeUserMarkers();
    if (typ = 1) then
    // in diesem Fall von den gerade geänderten cwusers/cwusersplus nach cwusersx/cwusersxplus kopieren
    begin
      for i := 0 to length(cwusersx) - 1 do
      begin
        cwusersxplus[i].marker := cwusersplus[cwusersxplus[i].multi].marker;
      end;
      form2.dyngrid1.Panel2Resize(self);

    end;
  end;
  // jeweils beide Grids müssen bei Änderung der Marker neu gezeichnet werden
  // die Aufrufe explizit mit Nennung der Instanz sind natürlich haarsträubend ;-)
  if (typ = 2) then
    form2.dyngrid10.Panel2Resize(self);
  Panel2Resize(self);
  gt := gettickcount - gt;
  lbdebug('z:' + inttostr(gt));
end;

procedure TDynGrid.MenuItem10Click(Sender: TObject);
begin
  UserSelectionTo2ndGrid(Sender, true);
end;

procedure TDynGrid.UserSelectionTo2ndGrid(Sender: TObject; doClear: boolean = true);
// spezielle Funktion nur im cwusers2 Grid die Selektion nach cwusersx zu bringen
var
  i, j: integer;
  lmax: integer;
  hilf: array of integer;
begin
  // aus cwUsers die Selektion nach cwUsersX und cwUsersXPlus kopieren

  lmax := length(cwusers);
  setlength(hilf, lmax);

  i := length(cwusersx);
  if (doClear = true) then
    i := 0;
  for j := 0 to i - 1 do
  begin
    hilf[cwusersxplus[j].multi] := 1;
  end;

  setlength(cwusersx, lmax);
  setlength(cwusersxplus, lmax);

  j := -1;
  for i := 0 to length(selSorted) - 1 do
  begin
    if (selSorted[i] <> 0) then
    begin
      hilf[i] := 1;
    end;
  end;

  j := -1;
  for i := 0 to lmax - 1 do
  begin
    if (hilf[i] > 0) then
    begin
      inc(j);
      cwusersx[j] := cwusers[i];
      cwusersxplus[j] := cwusersplus[i];
      cwusersxplus[j].multi := i;
    end;
  end;
  setlength(cwusersx, j + 1);
  setlength(cwusersxplus, j + 1);
  form2.dyngrid1.initGrid('cwusersx', 'userId', 1, j + 1, 31);
  form2.dyngrid1.lblHeader.Caption := 'Users:' + inttostr(j + 1);
end;

procedure TDynGrid.SGTopLeftChanged(Sender: TObject);
begin
  //
  SGSum.LeftCol := SG.LeftCol;
end;

procedure TDynGrid.SGDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
var
  s: String;
  r: TRect;
  gt: cardinal;
  i, j: integer;
  sp: integer;
  rc: integer;
  grau: integer;
  flag: boolean;
begin

  flag := false;
  grau := 59;
  rc := (Sender as Tstringgrid).rowcount;
  if (rc = 1) then
    if (ARow = 1) then
      i := 0;

  if ARow >= (Sender as Tstringgrid).rowcount then
  begin
    exit;
  end;

  //
  sp := scrollPosition + ARow - 1;
  if sp < 0 then
    flag := true; // als normal behandeln
  // exit;

  if length(ixSorted) <= sp then
    flag := true; // als normal behandeln
  // exit;

  if (ARow = 0) then // oberste Zeile=fix nie selektieren
    flag := true;

  with Sender as Tstringgrid do
  begin
    if (flag = false) then
      if selSorted[ixSorted[sp]] = 1 then
        Canvas.Brush.Color := clGray // selektiert
      else
        Canvas.Brush.Color := RGB2TColor(grau, grau, grau)
    else
      Canvas.Brush.Color := RGB2TColor(grau, grau, grau);

    s := Cells[ACol, ARow];
    if (ARow > 1) then
    begin
      if (s = Cells[ACol, ARow - 1]) then
        s := '^';
    end;

    r := Rect;
    r.left := r.left - 4; // -4 wird ganz gefüllt
    Canvas.FillRect(r);
    // den Text am alten Rect ausrichten sonst zu weit links
    Canvas.Pen.Color := clBlue;
    if s = '^' then
    begin
      r.left := trunc((r.left + r.Right) / 2) - 3;
      r.Top := r.Top + 4;
    end
    else
    begin
      r.left := r.left + 6;
      r.Top := r.Top + 4;
    end;
    DrawText(Canvas.Handle, PChar(s), length(s), r, DT_LEFT);
  end;

end;

procedure TDynGrid.SGKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  grid: FTCommons.TStringGridSorted;
  col, row: integer;
  btn: TMouseButton;
  i:integer;
begin
  //
  grid := Sender as FTCommons.TStringGridSorted;
  col := grid.col;
  row := grid.row;
  visibleRows := trunc(((SG.Height - 20) / (1 + SG.defaultrowheight))); // 20 für hor.Scroll
  btn := mbleft;
  // col row ist die Zelle in welcher die Taste gedrückt wurde und nicht die Zielzelle !
  case Key of
    // geht leider nicht, da die Kopfzeile gar nicht gewählt werden kann.Daher ist col immer 0 , egal wo man sich befindet
    // VK_DELETE:
    // begin
    // // showmessage('make col invisible');
    // SG.ColWidths[col] := 20;
    // SGSum.ColWidths[col] := 20;
    // gridHandler(nil);
    // form2.repaint;
    // end;
    36: //POS1
       begin
         i:=0;
       end;
    114:

      // F3
      begin
        // Suche wiederholen
        suchInSpalte(true); // True=Wiederholung
      end;
    115:

      // F4
      begin
        // Suche wiederholen
        suchInSpalte(true, true); // True=Wiederholung
      end;

    VK_DOWN:
      begin
        if (row >= visibleRows - 1) then
        begin
          ScrollBar1.Position := ScrollBar1.Position + 1;
          form2.gridMouseClickHandler(grid, col, row + 1, btn, Shift, source);
          workSelection(row, row, btn, Shift);
        end
        else
        begin
          form2.gridMouseClickHandler(grid, col, row + 1, btn, Shift, source);
          workSelection(row, row + 1, btn, Shift);
        end;
        gridHandler(nil);
        form2.repaint;
      end;
    VK_UP:
      begin
        if (row < 2) then
        begin
          ScrollBar1.Position := ScrollBar1.Position - 1;
          form2.gridMouseClickHandler(grid, col, row - 1, btn, Shift, source);
          workSelection(row, row, btn, Shift);
        end
        else
        begin
          form2.gridMouseClickHandler(grid, col, row - 1, btn, Shift, source);
          workSelection(row, row - 1, btn, Shift);
        end;
        gridHandler(nil);
        form2.repaint;
      end;
  end;
end;

procedure TDynGrid.SGKeyPress(Sender: TObject; var Key: Char);
begin
  //
end;

procedure TDynGrid.Panel1Click(Sender: TObject);
begin
  self.invalidate;
end;

procedure TDynGrid.Panel2Resize(Sender: TObject);
var
  max: integer;
begin
  // neu Einstellen der Grenzen
  // ! defaultrowheight=24  - es werden aber 25 dargestellt
  visibleRows := trunc(((SG.Height - 20) / (1 + SG.defaultrowheight))); // 20 für hor.Scroll
  // visibleRows := trunc((SG.height / SG.rowheights[0])) + 1;

  // visibleRows := SG.VisibleRowCount + 1; // damit halbe auch mitgenommen werden  FALSCHER WERT - oft nur 2 statt zB 15
  visibleCols := trunc((SG.width / SG.defaultcolwidth)) + 1;

  if SG.rowcount < visibleRows then
    SG.rowcount := visibleRows;
  // 1 fix Row erfordert min. 2 RowCount
  if SG.rowcount > maxDataRows + 1 then
    SG.rowcount := maxDataRows + 1;

  if SG.rowcount < 2 then
    SG.rowcount := 2;
  if SG.fixedrows = 0 then
    SG.fixedrows := 1;
  ScrollBar1.Min := 0;
  max := maxDataRows - visibleRows + 1;
  if max < 0 then
    max := 0;
  ScrollBar1.max := max;
  if maxDataRows > 0 then
  begin
    gridHandler(nil);
    if autosized = false then
    begin
      autosizegrid(SG, SGSum);
      autosized := true; // nur einmal bei der ersten Darstellung nach dem Init und Sort
    end;
  end;

end;

procedure TDynGrid.RemoveallbutSelection1Click(Sender: TObject);
begin
  if (source = 'cwfilteredactions') then
    doRemoveSelection(2);
  if (source = 'cwopenactionsOTR') then
    doRemoveSelectionOTR(2);
  if (source = 'cwusersx') then
    doRemoveSelectionUsersX(true); // false=die Selektierten entfernen
end;

procedure TDynGrid.RemoveSelection1Click(Sender: TObject);
begin
  if (source = 'cwfilteredactions') then
    doRemoveSelection(1);
  if (source = 'cwopenactionsOTR') then
    doRemoveSelectionOTR(1);
  if (source = 'cwusersx') then
    doRemoveSelectionUsersX(false); // false=die Selektierten entfernen
end;

procedure TDynGrid.ScrollBar1Change(Sender: TObject);
begin
  // scrollbar1.position:=ScrollBar1.Position+5;//->stackoverflow
  scrollPosition := ScrollBar1.Position;

  if maxDataRows > 0 then
    gridHandler(nil);

end;

procedure TDynGrid.ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: integer);
var
  a: integer;
begin

  // TScrollCode = (scLineUp, scLineDown, scPageUp, scPageDown, scPosition,scTrack, scTop, scBottom, scEndScroll);
  a := 0;
  // klappt so nicht wie gewünscht da position nach +5 wieder als +1 kommt
  // scrollbar1.position:=ScrollBar1.Position+5;//->stackoverflow
  // if maxDataRows > 0 then
  // gridHandler(self);
  inc(scrollBar1RepeatCount);
  if scrollBar1RepeatCount = 20 then
  begin
    ScrollBar1.smallChange := 5;
    ScrollBar1.largechange := 100;
  end;
  if scrollBar1RepeatCount = 50 then
  begin
    ScrollBar1.smallChange := 10;
    ScrollBar1.largechange := 100;
  end;
  if scrollBar1RepeatCount = 100 then
  begin
    ScrollBar1.smallChange := 50;
    ScrollBar1.largechange := 500;
  end;

  if ScrollCode = scEndScroll then
  begin
    scrollBar1RepeatCount := 0;
    ScrollBar1.smallChange := 1;
    ScrollBar1.largechange := 20;
  end;
end;

procedure TDynGrid.Selectcolumns1Click(Sender: TObject);
begin
  Dialog1.form5.gridselektor(self);
  Dialog1.form5.Showmodal;
  // Column selection
end;

procedure TDynGrid.Selection2ndGrid1Click(Sender: TObject);
begin
  //
  UserSelectionTo2ndGrid(Sender, false); // nicht löschen
end;

// spezieller Teil auf zB cwactions,cwfilteredactions,cwsingleuseractions bezugnehmend
// todo: cwsymbols cwusers cwcomments cwsymbolsgroups cwfilteredsymbolsgroups

procedure TDynGrid.initGrid(source: string; sortCol: string; sortDir: integer; rows: integer; cols: integer);
var
  mrows, dl, i, scol, smethode: integer;
  j, k: integer;
  b: boolean;
begin
  merkDynGridSuch := '';
  lblSelection.Caption := '';
  selectedCt := 0;
  self.source := source;
  self.sortCol := sortCol;
  self.sortDir := sortDir;
  maxDataRows := 0;
  visibleRows := trunc(((SG.Height - 20) / (1 + SG.defaultrowheight))); // 20 für hor.Scroll
  mrows := visibleRows;
  SG.test := 1;
  if rows < mrows then
  begin

    for j := rows to mrows do
      for k := 0 to SG.colcount - 1 do
        SG.Cells[k, j] := ' ';
    mrows := rows;
  end;
  // Problem: wenn alte Inhalte vorhanden sind werden sie bei Verkleinerung von Rowcount nicht entfernt !
  SG.rowcount := mrows;
  SG.colcount := cols;

  SGSum.rowcount := 1;
  SGSum.colcount := cols;

  if (mrows + cols) = 0 then
  begin
    SG.Visible := false;
    exit;
  end
  else
    SG.Visible := true;

  for j := 0 to SG.rowcount - 1 do
    for k := 0 to SG.colcount - 1 do
      SG.Cells[k, j] := ' ';

  for j := 0 to SGSum.rowcount - 1 do
    for k := 0 to SGSum.colcount - 1 do
      SGSum.Cells[k, j] := ' ';

  if (SG.rowcount < 1) then
    exit;

  if (initialized = false) then
  begin
    setlength(SGFieldCol, cols);
    setlength(SGColField, cols);
    // Einlesen der SGFieldcol... aus der Ini-Datei - es sei denn die Daten fehlen
    b := faIni.ReadBool('dyngrid:' + source, iniHeader, false);
    if (b = true) then
    begin
      for i := 0 to cols - 1 do
      begin
        SGFieldCol[i] := faIni.ReadInteger('dyngrid:' + source, 'sfc' + inttostr(i), 0); // sfc fieldCol
        SGColField[i] := faIni.ReadInteger('dyngrid:' + source, 'scf' + inttostr(i), 0); // scf colField
        SG.ColWidths[i] := faIni.ReadInteger('dyngrid:' + source, 'cw' + inttostr(i), 100); // cw colWidths
        SGSum.ColWidths[i] := faIni.ReadInteger('dyngrid:' + source, 'cw' + inttostr(i), 100);
      end;
      // bei Erweiterung der Spalten werden die hinteren EInträge noch nicht richtig belegt - es sei denn der User verschiebt die Spalten zum ersten Mal
      for i := cols - 1 downto 0 do
      begin
        if SGFieldCol[i] = 0 then
        begin
          SGFieldCol[i] := i;
          SGColField[i] := i;
          SG.ColWidths[i] := 100;
          SGSum.ColWidths[i] := 100;
        end
        else
          break;
      end;
      autosized := true;
    end
    else
      for i := 0 to cols - 1 do
      begin
        SGFieldCol[i] := i;
        SGColField[i] := i;
        SG.ColWidths[i] := 100;
        SGSum.ColWidths[i] := 100;
      end;
    initialized := true;
  end;

  maxDataRows := rows;
  // source   cwactions
  // sortcol  ActionId
  // sortdir  1  und -1
  // und das array
  doSorting();
  // if source = 'cwopenactions1' then
  // sortGridCwOpenActions(source, sortcol, sortdir, cwOpenActionsZ1);
  // if source = 'cwopenactions2' then
  // sortGridCwOpenActions(source, sortcol, sortdir, cwOpenActionsZ2);
  // if source = 'cwopenactionsOTR' then
  // sortGridCwOpenActionsOTR(source, sortcol, sortdir, cwTradeRecords);
  // if source = 'cwactions' then
  // sortGridCwactions(source, sortcol, sortdir, cwactions);
  // if source = 'cwfilteredactions' then
  // sortGridCwactions(source, sortcol, sortdir, cwfilteredactions);
  // if source = 'cwsingleuseractions' then
  // sortGridCwactions(source, sortcol, sortdir, cwSingleUserActions);
  // if source = 'cwsymbols' then
  // sortGridCwSymbols(source, sortcol, sortdir, cwSymbols, cwsymbolsplus);
  // if ((source = 'cwusers') or (source = 'cwusers2')) then
  // sortGridCwUsers(source, sortcol, sortdir, cwUsers, cwusersplus);
  // if source = 'cwcomments' then
  // sortGridCwComments(source, sortcol, sortdir, cwComments);
  // if source = 'cwsymbolsgroups' then
  // sortGridCwSymbolsGroups(source, sortcol, sortdir, cwSymbolsGroups);
  // if source = 'cwfilteredsymbolsgroups' then
  // sortGridCwSymbolsGroups(source, sortcol, sortdir, cwFilteredSymbolsGroups);
  // if source = 'cw3summaries' then
  // sortGridCw3Summaries(source, sortcol, sortdir, cw3summaries);
  // if source = 'cwsummaries' then
  // sortGridCwSummaries(source, sortcol, sortdir, cwsummaries);

  // autosized := false;
  // alle Selektionen auf Null setzen


  // nun stecken die sortierten Elemente der einen Spalte in ssort und dsort
  // wird dann aber eigentlich nicht mehr gebraucht weil es um den Index ixSorted geht !

  setlength(sSort, 0); // NEU 12.12.19
  setlength(dSort, 0);

  setlength(selSorted, length(ixSorted));
  for i := 0 to length(ixSorted) - 1 do
    selSorted[i] := 0;

end;

// es geht hier nur um die Überschrift der Column um das Grid zu sortieren
// die Reihenfolge der Columns spielt keine Rolle !
procedure TDynGrid.doRemoveSelection(typ: integer);
var
  i, ct: integer;
  mem: string;
  neuActions: DACwAction;
begin
  // 1 = Selection weg oder 2 nur Selection
  ct := -1;
  setlength(neuActions, cwFilteredActionCt);
  for i := 0 to cwFilteredActionCt - 1 do
  begin
    if (typ = 1) then
    begin
      mem := 'Selection removed';
      if selSorted[i] = 0 then
      begin
        inc(ct);
        neuActions[ct] := cwFilteredActions[i];
      end;
    end;
    if (typ = 2) then
    begin
      mem := 'Selection left';
      if selSorted[i] = 1 then
      begin
        inc(ct);
        neuActions[ct] := cwFilteredActions[i];
      end;
    end;
  end;
  cwFilteredActionCt := ct + 1;
  cwFilteredActions := Copy(neuActions, 0, cwFilteredActionCt);
  lblHeader.Caption := #34 + FilterTopic + #34 + ' ' + 'Filtered actions:' + inttostr(cwFilteredActionCt) + ' of ' + inttostr(length(cwActions));

  initGrid('cwfilteredactions', 'userId', 1, length(cwFilteredActions), 28);

end;

procedure TDynGrid.doRemoveSelectionOTR(typ: integer);
var
  i, ct: integer;
  mem: string;
  neuTrades: DATradeRecord;
begin
  // 1 = Selection weg oder 2 nur Selection
  ct := -1;
  setlength(neuTrades, length(cwTradeRecords));
  for i := 0 to length(cwTradeRecords) - 1 do
  begin
    if (typ = 1) then
    begin
      mem := 'Selection removed';
      if selSorted[i] = 0 then
      begin
        inc(ct);
        neuTrades[ct] := cwTradeRecords[i];
      end;
    end;
    if (typ = 2) then
    begin
      mem := 'Selection left';
      if selSorted[i] = 1 then
      begin
        inc(ct);
        neuTrades[ct] := cwTradeRecords[i];
      end;
    end;
  end;
  cwTradeRecords := Copy(neuTrades, 0, ct + 1);

  initGrid('cwopenactionsOTR', 'actionId', 1, length(cwTradeRecords), 13);
  lblHeader.Caption := 'OpenActionsOTR:' + inttostr(length(cwTradeRecords));

end;

procedure TDynGrid.doRemoveSelectionUsersX(allBut: boolean);
var
  i, j: integer;
  lmax: integer;
  hilf: array of integer;
begin
  // die Selektion im cwusersx Grid entfernen

  lmax := length(cwusers);
  setlength(hilf, lmax);

  i := length(cwusersx);
  for j := 0 to i - 1 do
  begin
    hilf[cwusersxplus[j].multi] := 1;
  end;

  setlength(cwusersx, lmax);
  setlength(cwusersxplus, lmax);

  j := -1;
  for i := 0 to length(selSorted) - 1 do
  begin
    if (allBut = false) and (selSorted[i] <> 0) then
    begin
      hilf[cwusersxplus[i].multi] := 0;
    end;
    if (allBut = true) and (selSorted[i] = 0) then
    begin
      hilf[cwusersxplus[i].multi] := 0;
    end;
  end;

  j := -1;
  for i := 0 to lmax - 1 do
  begin
    if (hilf[i] > 0) then
    begin
      inc(j);
      cwusersx[j] := cwusers[i];
      cwusersxplus[j] := cwusersplus[i];
      cwusersxplus[j].multi := i;
    end;
  end;
  setlength(cwusersx, j + 1);
  setlength(cwusersxplus, j + 1);
  form2.dyngrid1.initGrid('cwusersx', 'userId', 1, j + 1, 31);
  form2.dyngrid1.lblHeader.Caption := 'Users:' + inttostr(j + 1);
end;

procedure TDynGrid.doSorting();
//
begin
  if source = 'cwopenactions1' then
    sortGridCwOpenActions(source, sortCol, sortDir, cwOpenActionsZ1);
  if source = 'cwopenactions2' then
    sortGridCwOpenActions(source, sortCol, sortDir, cwOpenActionsZ2);
  if source = 'cwopenactionsOTR' then
    sortGridCwOpenActionsOTR(source, sortCol, sortDir, cwTradeRecords);
  if source = 'cwactions' then
    sortGridCwactions(source, sortCol, sortDir, cwActions);
  if source = 'cwfilteredactions' then
    sortGridCwactions(source, sortCol, sortDir, cwFilteredActions);
  if source = 'cwsingleuseractions' then
    sortGridCwactions(source, sortCol, sortDir, cwSingleUserActions);
  if source = 'cwsymbols' then
    sortGridCwSymbols(source, sortCol, sortDir, cwSymbols, cwsymbolsplus);
  if ((source = 'cwusers') or (source = 'cwusers2')) then
    sortGridCwUsers(source, sortCol, sortDir, cwusers, cwusersplus);
  if ((source = 'cwusersx')) then
    sortGridCwUsers(source, sortCol, sortDir, cwusersx, cwusersxplus);
  if source = 'cwcomments' then
    sortGridCwComments(source, sortCol, sortDir, cwComments);
  if source = 'cwsymbolsgroups' then
    sortGridCwSymbolsGroups(source, sortCol, sortDir, cwSymbolsGroups);
  if source = 'cwfilteredsymbolsgroups' then
    sortGridCwSymbolsGroups(source, sortCol, sortDir, cwFilteredSymbolsGroups);
  if source = 'cw3summaries' then
    sortGridCw3Summaries(source, sortCol, sortDir, cw3summaries);
  if source = 'cwsummaries' then
    sortGridCwSummaries(source, sortCol, sortDir, cwsummaries);
end;

procedure TDynGrid.doUpdateStyleElements;
begin
  self.UpdateStyleElements;
end;

procedure TDynGrid.sortGridCwOpenActions(source: string; sortCol: string; sortDir: integer; var actions: DACwOpenActions);
var
  dl, i, scol, smethode: integer;
  gt: cardinal;
  k, found: integer;
begin
  gt := gettickcount;

  dl := length(actions); // immer der ganze Haufen !
  if (dl = 0) then
    exit;

  setlength(ixSorted, dl);
  smethode := 1; // double  2=String
  scol := 1;
  // alles undefinierte ist dann die erste Spalte = ActionId  Scol ist NICHT unbedingt die Spalte die man sieht
  if ((source = 'cwopenactions1') or (source = 'cwopenactions2')) then
  begin
    if sortCol = 'actionId' then
      scol := 1;
    if sortCol = 'userId' then
      scol := 2;
    if sortCol = 'profit' then
      scol := 3;
    if sortCol = 'swap' then
      scol := 4;
    if sortCol = 'opentime' then
      scol := 5;
    if sortCol = 'closetime' then
      scol := 6;
    if sortCol = 'comment' then
    begin
      smethode := 2; // 2=String
      scol := 12;
    end;

    setlength(dSort, dl);
    setlength(sSort, dl);

    begin
      for i := 0 to dl - 1 do
      begin
        ixSorted[i] := i;
        if scol = 1 then
        begin
          dSort[i] := actions[i].actionId;
          continue;
        end;
        if scol = 2 then
        begin
          dSort[i] := actions[i].userId;
          continue;
        end;
        if scol = 3 then
        begin
          dSort[i] := actions[i].profit;
          continue;
        end;
        if scol = 4 then
        begin
          dSort[i] := actions[i].swap;
          continue;
        end;
        // !!! ändern
        if scol = 5 then
        begin
          found := findCwactionFromId(actions[i].actionId);
          if (found > -1) then
            dSort[i] := cwActions[found].openTime
          else
            dSort[i] := -1;
          continue;
        end;
        if scol = 6 then
        begin
          found := findCwactionFromId(actions[i].actionId);
          if (found > -1) then
            dSort[i] := cwActions[found].CloseTime
          else
            dSort[i] := -1;
          continue;
        end;
        if scol = 12 then
        begin
          found := findCwactionFromId(actions[i].actionId);
          if (found > -1) then
            sSort[i] := getcwcomment(cwActions[found].commentid)
          else
            sSort[i] := '';
          continue;
        end;
      end;
    end;
    // nun sortieren
    if smethode = 1 then
    // double
    begin
      if sortDir = 1 then
        FastSort2ArrayDouble(dSort, ixSorted, 'VDA')
      else
        FastSort2ArrayDouble(dSort, ixSorted, 'VUA');
    end;

    if smethode = 2 then
    // String
    begin
      if sortDir = 1 then
        FastSort2ArrayString(sSort, ixSorted, 'VUAS')
      else
        FastSort2ArrayString(sSort, ixSorted, 'VDAS')

    end;
    sDatenTyp := smethode;

  end;
  Panel2Resize(self);
end;

procedure TDynGrid.sortGridCwOpenActionsOTR(source: string; sortCol: string; sortDir: integer; var actions: DATradeRecord);
var
  dl, i, scol, smethode: integer;
  gt: cardinal;
  k, found: integer;
begin
  gt := gettickcount;

  dl := length(actions);
  if (dl = 0) then
    exit;

  setlength(ixSorted, dl);
  smethode := 1; // double  2=String
  scol := 1; // alles undefinierte ist dann die erste Spalte = ActionId
  if (source = 'cwopenactionsOTR') then
  begin
    if sortCol = 'actionId' then
      scol := 1;
    if sortCol = 'userId' then
      scol := 2;
    if sortCol = 'symbol' then
      scol := 3;
    if sortCol = 'opentime' then
      scol := 4;
    if sortCol = 'closetime' then
      scol := 5;
    if sortCol = 'cmd' then
      scol := 6;
    if sortCol = 'openprice' then
      scol := 7;
    if sortCol = 'closeprice' then
      scol := 8;
    if sortCol = 'volume' then
      scol := 9;

    if sortCol = 'comment' then

    begin
      smethode := 2; // 2=String
      scol := 10;
    end;

    setlength(dSort, dl);
    setlength(sSort, dl);

    begin
      for i := 0 to dl - 1 do
      begin
        ixSorted[i] := i;
        if scol = 1 then
        begin
          dSort[i] := actions[i].order;
          continue;
        end;
        if scol = 2 then
        begin
          dSort[i] := actions[i].login;
          continue;
        end;
        if scol = 3 then
        begin
          smethode := 2;
          sSort[i] := actions[i].symbol;
          continue;
        end;
        if scol = 4 then
        begin
          dSort[i] := actions[i].open_time;
          continue;
        end;
        // !!! ändern
        if scol = 5 then
        begin
          dSort[i] := actions[i].close_time;
          continue;
        end;
        if scol = 6 then
        begin
          dSort[i] := actions[i].cmd;
          continue;
        end;
        if scol = 7 then
        begin
          dSort[i] := actions[i].open_price;
          continue;
        end;
        if scol = 8 then
        begin
          dSort[i] := actions[i].close_price;
          continue;
        end;
        if scol = 9 then
        begin
          dSort[i] := actions[i].volume;
          continue;
        end;
        if scol = 10 then
        begin
          smethode := 2;
          sSort[i] := actions[i].comment;
          continue;
        end;

      end;
    end;
    // nun sortieren
    if smethode = 1 then
    // double
    begin
      if sortDir = 1 then
        FastSort2ArrayDouble(dSort, ixSorted, 'VDA')
      else
        FastSort2ArrayDouble(dSort, ixSorted, 'VUA');
    end;

    if smethode = 2 then
    // String
    begin
      if sortDir = 1 then
        FastSort2ArrayString(sSort, ixSorted, 'VUAS')
      else
        FastSort2ArrayString(sSort, ixSorted, 'VDAS')

    end;
    sDatenTyp := smethode;

  end;
  Panel2Resize(self);
end;

procedure TDynGrid.sortGridCwactions(source: string; sortCol: string; sortDir: integer; var actions: DACwAction);
var
  dl, i, scol, smethode: integer;
  gt: cardinal;
  uid: integer;
begin
  gt := gettickcount;

  dl := length(actions);
  if (dl = 0) then
    exit;

  setlength(ixSorted, dl);
  smethode := 1; // double  2=String
  scol := 1;
  if ((source = 'cwactions') or (source = 'cwfilteredactions') or (source = 'cwsingleuseractions')) then
  begin
    if sortCol = 'actionId' then
      scol := 1;

    if sortCol = 'userId' then
      scol := 2;

    if sortCol = 'accountId' then
      scol := 3;

    if sortCol = 'symbolId' then
      scol := 4;

    if sortCol = 'commentId' then
      scol := 5;

    if sortCol = 'typeId' then
      scol := 6;

    if sortCol = 'sourceId' then
      scol := 7;

    if sortCol = 'openTime' then
      scol := 8;

    if sortCol = 'closeTime' then
      scol := 9;

    if sortCol = 'expirationTime' then
      scol := 10;

    if sortCol = 'openPrice' then
      scol := 11;

    if sortCol = 'closePrice' then
      scol := 12;

    if sortCol = 'stopLoss' then
      scol := 13;

    if sortCol = 'takeProfit' then
      scol := 14;

    if sortCol = 'swap' then
      scol := 15;

    if sortCol = 'profit' then
      scol := 16;

    if sortCol = 'volume' then
      scol := 17;

    if sortCol = 'precision' then
      scol := 18;

    if sortCol = 'conversionRate0' then
      scol := 19;

    if sortCol = 'conversionRate1' then
      scol := 20;

    if sortCol = 'marginRate' then
      scol := 21;

    // die beiden sind errechnete Werte
    if sortCol = 'symbol' then
      scol := 22;

    if sortCol = 'comment' then
      scol := 23;

    if sortCol = 'userMarker' then
      scol := 24;

    if ((scol = 22) or (scol = 23) or (scol = 24)) then
    begin
      setlength(sSort, dl);
      smethode := 2;
    end
    else
      setlength(dSort, dl);

    begin
      for i := 0 to dl - 1 do
      begin
        ixSorted[i] := i;
        if scol = 1 then
        begin
          dSort[i] := actions[i].actionId;
          continue;
        end;
        if scol = 2 then
        begin
          dSort[i] := actions[i].userId;
          continue;
        end;
        if scol = 3 then
        begin
          dSort[i] := actions[i].accountId;
          continue;
        end;
        if scol = 4 then
        begin
          dSort[i] := actions[i].symbolId;
          continue;
        end;
        if scol = 5 then
        begin
          dSort[i] := actions[i].commentid;
          continue;
        end;
        if scol = 6 then
        begin
          dSort[i] := actions[i].typeId;
          continue;
        end;
        if scol = 7 then
        begin
          dSort[i] := actions[i].sourceId;
          continue;
        end;
        if scol = 8 then
        begin
          dSort[i] := actions[i].openTime;
          continue;
        end;
        if scol = 9 then
        begin
          dSort[i] := actions[i].CloseTime;
          continue;
        end;
        if scol = 10 then
        begin
          dSort[i] := actions[i].expirationTime;
          continue;
        end;
        if scol = 11 then
        begin
          dSort[i] := actions[i].openPrice;
          continue;
        end;
        if scol = 12 then
        begin
          dSort[i] := actions[i].closePrice;
          continue;
        end;
        if scol = 13 then
        begin
          dSort[i] := actions[i].stopLoss;
          continue;
        end;
        if scol = 14 then
        begin
          dSort[i] := actions[i].takeProfit;
        end;
        if scol = 15 then
        begin
          dSort[i] := actions[i].swap;
          continue;
        end;
        if scol = 16 then
        begin
          dSort[i] := actions[i].profit;
          continue;
        end;
        if scol = 17 then
        begin
          dSort[i] := actions[i].volume;
          continue;
        end;
        if scol = 18 then
        begin
          dSort[i] := actions[i].precision;
          continue;
        end;
        if scol = 19 then
        begin
          dSort[i] := actions[i].conversionRate0;
          continue;
        end;
        if scol = 20 then
        begin
          dSort[i] := actions[i].conversionRate1;
          continue;
        end;
        if scol = 21 then
        begin
          dSort[i] := actions[i].marginRate;
          continue;
        end;
        if scol = 22 then
        begin
          smethode := 2;
          sSort[i] := getcwsymbol(actions[i].symbolId);
          continue;
        end;
        if scol = 23 then
        begin
          smethode := 2;
          sSort[i] := getcwcomment(actions[i].commentid);
          continue;
        end;

        if scol = 24 then
        begin
          smethode := 2;
          uid := finduserindex(actions[i].userId);
          sSort[i] := cwusersplus[uid].marker;
          continue;
        end;

      end;
    end;
    // nun sortieren
    if smethode = 1 then
    // double
    begin
      if sortDir = 1 then
        FastSort2ArrayDouble(dSort, ixSorted, 'VDA')
      else
        FastSort2ArrayDouble(dSort, ixSorted, 'VUA');
    end;

    if smethode = 2 then
    // String
    begin
      if sortDir = 1 then
        FastSort2ArrayString(sSort, ixSorted, 'VUAS')
      else
        FastSort2ArrayString(sSort, ixSorted, 'VDAS')

    end;
    sDatenTyp := smethode;

  end;
  // lblTime.caption := inttostr(gettickcount - gt);
  Panel2Resize(self);
end;

procedure TDynGrid.sortGridCwUsers(source: string; sortCol: string; sortDir: integer; var users: DACwUser; var usersplus: DACwUserPlus);
var
  dl, i, scol, smethode: integer;
  gt: cardinal;

begin
  gt := gettickcount;

  dl := length(users);

  if (dl = 0) then
    exit;

  setlength(ixSorted, dl);
  smethode := 1; // double  2=String
  scol := 1;
  if ((source = 'cwusers') or (source = 'cwusers2') or (source = 'cwusersx')) then

  begin
    If sortCol = 'userId' then
      scol := 1;
    If sortCol = 'accountId' then
      scol := 2;
    If sortCol = 'group' then
      scol := 3;
    If sortCol = 'enable' then
      scol := 4;
    If sortCol = 'registrationTime' then
      scol := 5;
    If sortCol = 'lastLoginTime' then
      scol := 6;
    If sortCol = 'leverage' then
      scol := 7;
    If sortCol = 'balance' then
      scol := 8;
    If sortCol = 'balancePreviousMonth' then
      scol := 9;
    If sortCol = 'balancePreviousDay' then
      scol := 10;
    If sortCol = 'credit' then
      scol := 11;
    If sortCol = 'interestrate' then
      scol := 12;
    If sortCol = 'taxes' then
      scol := 13;
    If sortCol = 'name' then
      scol := 14;
    If sortCol = 'country' then
      scol := 15;
    If sortCol = 'city' then
      scol := 16;
    If sortCol = 'state' then
      scol := 17;
    If sortCol = 'zipcode' then
      scol := 18;
    If sortCol = 'address' then
      scol := 19;
    If sortCol = 'phone' then
      scol := 20;
    If sortCol = 'email' then
      scol := 21;
    If sortCol = 'socialNumber' then
      scol := 22;
    If sortCol = 'comment' then
      scol := 23;
    If sortCol = 'totalSymbols' then // nicht drin
      scol := 24;
    If sortCol = 'trades' then
      scol := 25;
    If sortCol = 'profit' then
      scol := 26;
    If sortCol = 'totalbalance' then
      scol := 27;
    If sortCol = 'totalswap' then
      scol := 28;
    If sortCol = 'accountCurrency' then
      scol := 29;
    If sortCol = 'lastOpenAction' then
      scol := 30;
    If sortCol = 'silentDays' then
      scol := 31;
    If sortCol = 'name' then
      scol := 32;
    If sortCol = 'marker' then
      scol := 33;

    if ((scol = 3) or ((scol >= 14) and (scol <= 23)) or (scol = 32) or (scol = 33)) then
    // Stringsort
    begin
      setlength(sSort, dl);
      smethode := 2;
    end
    else
      // Numbersort
      setlength(dSort, dl);

    begin
      for i := 0 to dl - 1 do
      begin
        // Grundstellung unsortiert alle ixSorted nacheinander
        ixSorted[i] := i;

        if scol = 1 then
        begin
          dSort[i] := users[i].userId;
          continue;
        end;
        if scol = 2 then
        begin
          dSort[i] := users[i].accountId;
          continue;
        end;
        if scol = 3 then
        begin
          sSort[i] := users[i].group;
          continue;
        end;
        if scol = 4 then
        begin
          dSort[i] := users[i].enable;
          continue;
        end;
        if scol = 5 then
        begin
          dSort[i] := users[i].registrationTime;
          continue;
        end;
        if scol = 6 then
        begin
          dSort[i] := users[i].lastLoginTime;
          continue;
        end;
        if scol = 7 then
        begin
          dSort[i] := users[i].leverage;
          continue;
        end;
        if scol = 8 then
        begin
          dSort[i] := users[i].balance;
          continue;
        end;
        if scol = 9 then
        begin
          dSort[i] := users[i].balancePreviousMonth;
          continue;
        end;
        if scol = 10 then
        begin
          dSort[i] := users[i].balancePreviousDay;
          continue;
        end;
        if scol = 11 then
        begin
          dSort[i] := users[i].credit;
          continue;
        end;
        if scol = 12 then
        begin
          dSort[i] := users[i].interestrate;
          continue;
        end;
        if scol = 13 then
        begin
          dSort[i] := users[i].taxes;
          continue;
        end;
        if scol = 14 then
        begin
          sSort[i] := users[i].name;
          continue;
        end;
        if scol = 15 then
        begin
          sSort[i] := users[i].country;
          continue;
        end;
        if scol = 16 then
        begin
          sSort[i] := users[i].city;
          continue;
        end;
        if scol = 17 then
        begin
          sSort[i] := users[i].State;
          continue;
        end;
        if scol = 18 then
        begin
          sSort[i] := users[i].zipcode;
          continue;
        end;
        if scol = 19 then
        begin
          sSort[i] := users[i].address;
          continue;
        end;
        if scol = 20 then
        begin
          sSort[i] := users[i].phone;
          continue;
        end;
        if scol = 21 then
        begin
          sSort[i] := users[i].email;
          continue;
        end;
        if scol = 22 then
        begin
          sSort[i] := users[i].socialNumber;
          continue;
        end;
        if scol = 23 then
        begin
          sSort[i] := users[i].comment;
          continue;
        end;
        if scol = 24 then // nicht dargestellt
        begin
          dSort[i] := usersplus[i].totalSymbols;
          continue;
        end;
        if scol = 25 then
        begin
          dSort[i] := usersplus[i].totalTrades;
          continue;
        end;
        if scol = 26 then
        begin
          dSort[i] := usersplus[i].totalProfit;
          continue;
        end;
        if scol = 27 then
        begin
          dSort[i] := usersplus[i].totalBalance;
          continue;
        end;
        if scol = 28 then
        begin
          dSort[i] := usersplus[i].totalSwap;
          continue;
        end;
        if scol = 29 then
        begin
          dSort[i] := usersplus[i].accountcurrency;
          continue;
        end;
        if scol = 30 then
        begin
          dSort[i] := usersplus[i].lastOpenAction;
          continue;
        end;
        if scol = 31 then
        begin
          dSort[i] := usersplus[i].silentDays;
          continue;
        end;
        if scol = 32 then
        begin
          sSort[i] := users[i].name;
          continue;
        end;
        if scol = 33 then
        begin
          sSort[i] := usersplus[i].marker;
          continue;
        end;

      end;
    end;
    // nun sortieren nach den dSort bzw sSort Dabei wird ixSorted sortiert und -> ixSorted(zeile)=userindex
    if smethode = 1 then
    begin
      if sortDir = 1 then
        FastSort2ArrayDouble(dSort, ixSorted, 'VDA')
      else
        FastSort2ArrayDouble(dSort, ixSorted, 'VUA');
    end;

    if smethode = 2 then
    begin
      if sortDir = 1 then
        FastSort2ArrayString(sSort, ixSorted, 'VUAS')
      else
        FastSort2ArrayString(sSort, ixSorted, 'VDAS')

    end;
    sDatenTyp := smethode;

  end;
  // lblTime.caption := inttostr(gettickcount - gt);
  Panel2Resize(self);
end;

procedure TDynGrid.SpeedButton1Click(Sender: TObject);
var
  p: TPoint;
  m: integer;
begin
  p := SpeedButton1.ClientToScreen(point(0, SpeedButton1.Height));
  m := 0;
  if source = 'cwcomments' then
    m := 2;
  if source = 'cwactions' then
    m := 2;
  if source = 'cwfilteredactions' then
    m := 5;
  if source = 'cwsingleuseractions' then
    m := 2;
  if source = 'cwusers2' then // neu 28.10.19
    m := 4;
  if source = 'cwusersx' then // neu 28.10.19
    m := 5;
  if source = 'cwopenactions1' then
    m := 2;
  if source = 'cwopenactions2' then
    m := 2;
  if source = 'cwopenactionsOTR' then
    m := 3;

  if (m = 5) then
  begin
    xxx1.Visible := false;
    PopupMenu5.Popup(p.X, p.Y); // Columnselection und CSV-Export  und Mark Selection
  end;
  if (m = 4) then
    PopupMenu4.Popup(p.X, p.Y); // Columnselection und CSV-Export  if (m = 3) then
  if (m = 3) then
    PopupMenu3.Popup(p.X, p.Y); // Columnselection und CSV-Export
  if (m = 2) then
    PopupMenu2.Popup(p.X, p.Y); // Columnselection und CSV-Export
  if (m = 1) then
    PopupMenu1.Popup(p.X, p.Y); // Columnselection und CSV-Export
  if (m = 0) then
    PopupMenu0.Popup(p.X, p.Y); // Columnselection

  // testweise hier mal was probieren
  self.UpdateStyleElements;

end;

procedure TDynGrid.suchInSpalte(dorepeat: boolean = false; doCount: boolean = false);

var
  such: string;
  suchLength, i: integer;
  suchfound: boolean;
  found: integer;
  gt: cardinal;
begin
  if ((dorepeat = false) or (merkDynGridSuch = '')) then
    such := InputBox('Search in column', 'Search expression:', merkDynGridSuch)
  else
    such := merkDynGridSuch;
  // immer in Großbuchstaben wandeln
  such := uppercase(such);
  merkDynGridSuch := such;
  suchLength := such.length;
  if such <> '' then
  begin
    suchfound := false;
    gt := gettickcount;
    i := scrollPosition + 1; // Achtung wenn Feld überschritten wird
    // der Parameter mucol ist hier falsch
    // wenn das SGColField(mucol) dann ist das Field wenigstens unverwechselbar
    // string wäre leichter umzusetzen ist aber in der Suche langsam !
    if source = 'cwopenactions1' then
      // fehlt wegen zu viel Aufwand !
      showmessage('Suchfunktion in' + source + ' noch nicht implementiert');

    // found := findActionparameter(SG, SGFieldCol, ixSorted, cwOpenActionsZ1, i, SGColField[mucol], such)
    ;
    if source = 'cwopenactions2' then
      // fehlt
      // found := findActionparameter(SG, SGFieldCol, ixSorted, cwOpenActionsZ2, i, SGColField[mucol], such)
      showmessage('Suchfunktion in' + source + ' noch nicht implementiert');;
    if source = 'cwactions' then
      found := findActionparameter(SG, SGFieldCol, ixSorted, selSorted, cwActions, i, SGColField[mucol], such, doCount)
    else if source = 'cwfilteredactions' then
      found := findActionparameter(SG, SGFieldCol, ixSorted, selSorted, cwFilteredActions, i, SGColField[mucol], such, doCount)
    else if source = 'cwsingleuseractions' then
      found := findActionparameter(SG, SGFieldCol, ixSorted, selSorted, cwSingleUserActions, i, SGColField[mucol], such, doCount)
    else if source = 'cwsymbols' then
      found := -2
    else if ((source = 'cwusers') or (source = 'cwusers2') or (source = 'cwusersx')) then
      found := findUserparameter(SG, SGFieldCol, ixSorted, selSorted, cwusers, i, SGColField[mucol], such, doCount)
    else if source = 'cwcomments' then
      found := -2
    else if source = 'cwsymbolsgroups' then
      found := -2
    else if source = 'cwfilteredsymbolsgroups' then
      found := -2;
    if (doCount = false) then
    begin
      if found > -1 then
        // todo das ist natürlich bei DynGrid Quatsch !
        ScrollBar1.Position := found;
      if (found = -1) then
        showmessage('z:' + inttostr(gettickcount - gt));
      if (found = -2) then
        showmessage('Funktion in' + source + ' noch nicht implementiert');
    end;
    if (doCount = true) then
      showmessage('Result count:' + inttostr(found) + ' hits of ' + such);
  end;

end;

procedure TDynGrid.sortGridCwComments(source: string; sortCol: string; sortDir: integer; var comments: DACwComment);
var
  dl, i, scol, smethode: integer;
  gt: cardinal;
begin
  gt := gettickcount;

  dl := length(comments);
  if (dl = 0) then
    exit;

  setlength(ixSorted, dl);
  smethode := 1; // double  2=String
  scol := 1;
  if ((source = 'cwcomments')) then
  begin
    if sortCol = 'commentId' then
      scol := 1;
    if sortCol = 'comment' then
      scol := 2;
    if ((scol = 2)) then
    begin
      setlength(sSort, dl);
      smethode := 2;
    end
    else
      setlength(dSort, dl);

    begin
      for i := 0 to dl - 1 do
      begin
        ixSorted[i] := i;

        if scol = 1 then
        begin
          dSort[i] := comments[i].commentid;
          continue;
        end;
        if scol = 2 then
        begin
          sSort[i] := comments[i].text;
          continue;
        end;
      end;
    end;
    // nun sortieren
    if smethode = 1 then
    begin
      if sortDir = 1 then
        FastSort2ArrayDouble(dSort, ixSorted, 'VDA')
      else
        FastSort2ArrayDouble(dSort, ixSorted, 'VUA');
    end;

    if smethode = 2 then
    begin
      if sortDir = 1 then
        FastSort2ArrayString(sSort, ixSorted, 'VUAS')
      else
        FastSort2ArrayString(sSort, ixSorted, 'VDAS')

    end;
    sDatenTyp := smethode;

  end;
  // lblTime.caption := inttostr(gettickcount - gt);
  Panel2Resize(self);
end;

procedure TDynGrid.sortGridCwSymbols(source: string; sortCol: string; sortDir: integer; var symbols: DACwSymbol; var symbolsPlus: DACwSymbolPlus);
var
  dl, i, scol, smethode: integer;
  gt: cardinal;
begin
  gt := gettickcount;

  dl := length(symbols);
  if (dl = 0) then
    exit;

  setlength(ixSorted, dl);
  smethode := 1; // double  2=String
  scol := 1;
  if ((source = 'cwsymbols')) then
  begin

    if sortCol = 'symbolId' then
      scol := 1;
    if sortCol = 'brokerId' then
      scol := 2;
    if sortCol = 'digits' then
      scol := 3;
    if sortCol = 'tradeMode' then
      scol := 4;
    if sortCol = 'expiration' then
      scol := 5;
    if sortCol = 'contractSize' then
      scol := 6;
    if sortCol = 'tickValue' then
      scol := 7;
    if sortCol = 'tickSize' then
      scol := 8;
    if sortCol = 'type_' then
      scol := 9;
    if sortCol = 'trades' then
      scol := 10;
    if sortCol = 'volume' then
      scol := 11;
    if sortCol = 'profit' then
      scol := 12;
    if sortCol = 'symGroup' then
      scol := 13;
    if sortCol = 'name' then
      scol := 14;
    if sortCol = 'description' then
      scol := 15;
    if sortCol = 'currency' then
      scol := 16;
    if sortCol = 'margin_currency' then
      scol := 17;

    if ((scol > 13)) then
    begin
      setlength(sSort, dl);
      smethode := 2;
    end
    else
      setlength(dSort, dl);

    begin
      for i := 0 to dl - 1 do
      begin
        ixSorted[i] := i;

        if scol = 1 then
        begin
          dSort[i] := symbols[i].symbolId;
          continue;
        end;
        if scol = 2 then
        begin
          dSort[i] := symbols[i].brokerId;
          continue;
        end;
        if scol = 3 then
        begin
          dSort[i] := symbols[i].digits;
          continue;
        end;
        if scol = 4 then
        begin
          dSort[i] := symbols[i].tradeMode;
          continue;
        end;
        if scol = 5 then
        begin
          dSort[i] := symbols[i].expiration;
          continue;
        end;
        if scol = 6 then
        begin
          dSort[i] := symbols[i].contractSize;
          continue;
        end;
        if scol = 7 then
        begin
          dSort[i] := symbols[i].tickValue;
          continue;
        end;
        if scol = 8 then
        begin
          dSort[i] := symbols[i].tickSize;
          continue;
        end;
        if scol = 9 then
        begin
          dSort[i] := symbols[i].type_;
          continue;
        end;
        if scol = 10 then
        begin
          dSort[i] := symbolsPlus[i].TradesCount;
          continue;
        end;
        if scol = 11 then
        begin
          dSort[i] := symbolsPlus[i].TradesVolumeTotal;
          continue;
        end;
        if scol = 12 then
        begin
          dSort[i] := symbolsPlus[i].TradesUsers;
          continue;
        end;
        if scol = 13 then
        begin
          dSort[i] := symbolsPlus[i].TradesProfitTotal;
          continue;
        end;
        if scol = 14 then
        begin
          sSort[i] := symbols[i].name;
          continue;
        end;
        if scol = 15 then
        begin
          sSort[i] := symbols[i].description;
          continue;
        end;
        if scol = 16 then
        begin
          sSort[i] := symbols[i].currency;
          continue;
        end;
        if scol = 17 then
        begin
          sSort[i] := symbols[i].margin_currency;
          continue;
        end;
      end;
    end;
    // nun sortieren
    if smethode = 1 then
    begin
      if sortDir = 1 then
        FastSort2ArrayDouble(dSort, ixSorted, 'VDA')
      else
        FastSort2ArrayDouble(dSort, ixSorted, 'VUA');
    end;

    if smethode = 2 then
    begin
      if sortDir = 1 then
        FastSort2ArrayString(sSort, ixSorted, 'VUAS')
      else
        FastSort2ArrayString(sSort, ixSorted, 'VDAS')

    end;
    sDatenTyp := smethode;

  end;
  // lblTime.caption := inttostr(gettickcount - gt);
  Panel2Resize(self);
end;

procedure TDynGrid.sortGridCwSymbolsGroups(source: string; sortCol: string; sortDir: integer; var symbolsGroups: DACwSymbolGroup);
var
  dl, i, scol, smethode: integer;
  gt: cardinal;
begin
  gt := gettickcount;

  dl := length(symbolsGroups);
  if (dl = 0) then
    exit;

  setlength(ixSorted, dl);
  smethode := 1; // double  2=String
  scol := 1;
  if ((source = 'cwsymbolsgroups') or (source = 'cwfilteredsymbolsgroups')) then
  begin

    if sortCol = 'tradesCount' then
      scol := 1;
    if sortCol = 'tradesVolumeTotal' then
      scol := 2;
    if sortCol = 'tradesUsers' then
      scol := 3;
    if sortCol = 'tradesProfitTotal' then
      scol := 4;
    if sortCol = 'tradesSwapTotal' then
      scol := 5;
    if sortCol = 'name' then
      scol := 7;
    if sortCol = 'sourceNames' then
      scol := 8;
    if sortCol = 'sourceIds' then
      scol := 9;
    if sortCol = 'groupId' then
      scol := 6;
    if sortCol = 'tradesProfitSwapTotal' then
      scol := 10;

    if ((scol > 6) and (scol < 10)) then
    begin
      setlength(sSort, dl);
      smethode := 2;
    end
    else
      setlength(dSort, dl);

    begin
      for i := 0 to dl - 1 do
      begin
        ixSorted[i] := i;

        if scol = 1 then
        begin
          dSort[i] := symbolsGroups[i].TradesCount;
          continue;
        end;
        if scol = 2 then
        begin
          dSort[i] := symbolsGroups[i].TradesVolumeTotal;
          continue;
        end;
        if scol = 3 then
        begin
          dSort[i] := symbolsGroups[i].TradesUsers;
          continue;
        end;
        if scol = 4 then
        begin
          dSort[i] := symbolsGroups[i].TradesProfitTotal;
          continue;
        end;
        if scol = 5 then
        begin
          dSort[i] := symbolsGroups[i].TradesSwapTotal;
          continue;
        end;
        if scol = 6 then
        begin
          dSort[i] := symbolsGroups[i].groupId;
          continue;
        end;
        if scol = 7 then
        begin
          sSort[i] := symbolsGroups[i].name;
          continue;
        end;
        if scol = 8 then
        begin
          sSort[i] := symbolsGroups[i].sourceNames;
          continue;
        end;
        if scol = 9 then
        begin
          sSort[i] := symbolsGroups[i].sourceIds;
          continue;
        end;
        if scol = 10 then
        begin
          dSort[i] := symbolsGroups[i].TradesProfitSwapTotal;
          continue;
        end;
      end;
    end;
    // nun sortieren
    if smethode = 1 then
    begin
      if sortDir = 1 then
        FastSort2ArrayDouble(dSort, ixSorted, 'VDA')
      else
        FastSort2ArrayDouble(dSort, ixSorted, 'VUA');
    end;

    if smethode = 2 then
    begin
      if sortDir = 1 then
        FastSort2ArrayString(sSort, ixSorted, 'VUAS')
      else
        FastSort2ArrayString(sSort, ixSorted, 'VDAS')

    end;
    sDatenTyp := smethode;

  end;
  // lblTime.caption := inttostr(gettickcount - gt);
  Panel2Resize(self);
end;

procedure TDynGrid.sortGridCw3Summaries(source: string; sortCol: string; sortDir: integer; var summaries: DA3CwSummary);
var
  dl1, dl2, dl3, dls, i, j, k, l, scol, smethode: integer;
  gt: cardinal;
begin
  gt := gettickcount;

  dl1 := length(summaries);
  dl2 := length(summaries[0]);
  dl3 := length(summaries[0][0]);
  dls := dl1 * dl2 * dl3;
  if (dls = 0) then
    exit;

  setlength(ixSorted, dls);
  smethode := 1; // double  2=String
  scol := 1;
  if (source = 'cw3summaries') then
  begin
    if sortCol = 'par0' then
      scol := 1;
    if sortCol = 'par1' then
      scol := 2;
    if sortCol = 'par2' then
      scol := 3;
    if sortCol = 'tradesCount' then
      scol := 4;
    if sortCol = 'tradesVolumeTotal' then
      scol := 5;
    if sortCol = 'tradesProfitTotal' then
      scol := 6;
    if sortCol = 'tradesUsers' then
      scol := 7;
    if sortCol = 'tradesSwapTotal' then
      scol := 8;
    if sortCol = 'tradesProfitSwapTotal' then
      scol := 9;

    if ((scol < 4)) then
    begin
      setlength(sSort, dls);
      smethode := 2;
    end
    else
      setlength(dSort, dls);
    l := -1;

    begin
      for i := 0 to dl1 - 1 do
        for j := 0 to dl2 - 1 do
          for k := 0 to dl3 - 1 do
          begin
            inc(l);
            ixSorted[l] := l;
            if scol = 1 then
            begin
              sSort[l] := summaries[i][j][k].par0;
              continue;
            end;
            if scol = 2 then
            begin
              sSort[l] := summaries[i][j][k].par1;
              continue;
            end;
            if scol = 3 then
            begin
              sSort[l] := summaries[i][j][k].par2;
              continue;
            end;

            if scol = 4 then
            begin
              dSort[l] := summaries[i][j][k].sTradesCount;
              continue;
            end;
            if scol = 5 then
            begin
              dSort[l] := summaries[i][j][k].sTradesVolumeTotal;
              continue;
            end;
            if scol = 6 then
            begin
              dSort[l] := summaries[i][j][k].sTradesProfitTotal;
              continue;
            end;
            if scol = 7 then
            begin
              dSort[l] := summaries[i][j][k].sTradesUsers;
              continue;
            end;
            if scol = 8 then
            begin
              dSort[l] := summaries[i][j][k].sTradesSwapTotal;
              continue;
            end;
            if scol = 9 then
            begin
              dSort[l] := summaries[i][j][k].sTradesProfitSwapTotal;
              continue;
            end;
          end;
    end;

    // nun sortieren
    if smethode = 1 then
    begin
      if sortDir = 1 then
        FastSort2ArrayDouble(dSort, ixSorted, 'VDA')
      else
        FastSort2ArrayDouble(dSort, ixSorted, 'VUA');
    end;

    if smethode = 2 then
    begin
      if sortDir = 1 then
        FastSort2ArrayString(sSort, ixSorted, 'VUAS')
      else
        FastSort2ArrayString(sSort, ixSorted, 'VDAS')
    end;
    sDatenTyp := smethode;
  end;
  // lblTime.caption := inttostr(gettickcount - gt);
  Panel2Resize(self);
end;

procedure TDynGrid.sortGridCwSummaries(source: string; sortCol: string; sortDir: integer; var summaries: DACwSummary);
var
  dls, i, j, k, l, scol, smethode: integer;
  gt: cardinal;
  sError: string;
begin
  gt := gettickcount;

  dls := length(summaries);
  if (dls = 0) then
    exit;

  setlength(ixSorted, dls);
  smethode := 1; // double  2=String
  scol := 1;
  if (source = 'cwsummaries') then
  begin
    // die umgelabelten Überschriften von par0 par1 par2
    if sortCol = cwgrouping.element[0].styp then
      scol := 1;
    if sortCol = cwgrouping.element[1].styp then
      scol := 2;
    if sortCol = cwgrouping.element[2].styp then
      scol := 3;

    if sortCol = 'par0' then
      scol := 1;
    if sortCol = 'par1' then
      scol := 2;
    if sortCol = 'par2' then
      scol := 3;
    if sortCol = 'tradesCount' then
      scol := 4;
    if sortCol = 'tradesVolumeTotal' then
      scol := 5;
    if sortCol = 'tradesProfitTotal' then
      scol := 6;
    if sortCol = 'tradesUsers' then
      scol := 7;
    if sortCol = 'tradesSwapTotal' then
      scol := 8;
    if sortCol = 'tradesProfitSwapTotal' then
      scol := 9;

    if ((scol < 4)) then
    begin
      try
        setlength(sSort, dls);
        smethode := 2;
      except

        on E: Exception do
          sError := E.ToString;
      end;
    end
    else
      setlength(dSort, dls);
    l := -1;

    begin
      for i := 0 to dls - 1 do
      begin
        inc(l);
        ixSorted[l] := l;
        // hier könnte man die Nebenspalten mit in die Sortierung aufnehmen , so daß bei gleichem Inhalt auch nach der nächsten Spale sortiert wird
        if scol = 1 then
        begin
          sSort[l] := summaries[i].par0 + summaries[i].par1 + summaries[i].par2;
          continue;
        end;
        if scol = 2 then
        begin
          sSort[l] := summaries[i].par1 + summaries[i].par0 + summaries[i].par2;
          continue;
        end;
        if scol = 3 then
        begin
          sSort[l] := summaries[i].par2 + summaries[i].par0 + summaries[i].par1;
          continue;
        end;

        if scol = 4 then
        begin
          dSort[l] := summaries[i].sTradesCount;
          continue;
        end;
        if scol = 5 then
        begin
          dSort[l] := summaries[i].sTradesVolumeTotal;
          continue;
        end;
        if scol = 6 then
        begin
          dSort[l] := summaries[i].sTradesProfitTotal;
          continue;
        end;
        if scol = 7 then
        begin
          dSort[l] := summaries[i].sTradesUsers;
          continue;
        end;
        if scol = 8 then
        begin
          dSort[l] := summaries[i].sTradesSwapTotal;
          continue;
        end;
        if scol = 9 then
        begin
          dSort[l] := summaries[i].sTradesProfitSwapTotal;
          continue;
        end;
      end;
    end;

    // nun sortieren
    if smethode = 1 then
    begin
      if sortDir = 1 then
        FastSort2ArrayDouble(dSort, ixSorted, 'VDA')
      else
        FastSort2ArrayDouble(dSort, ixSorted, 'VUA');
    end;

    if smethode = 2 then
    begin
      if sortDir = 1 then
        FastSort2ArrayString(sSort, ixSorted, 'VUAS')
      else
        FastSort2ArrayString(sSort, ixSorted, 'VDAS')

    end;
    sDatenTyp := smethode;
  end;
  // lblTime.caption := inttostr(gettickcount - gt);
  Panel2Resize(self);
end;

procedure TDynGrid.gridHandler(pexp: pExport);
// damit man auch nil übergeben kann muß der Typ ein Zeigertyp sein !
// nil=kein Export oder pexp ein Export-Objekt
var

  i, j, k: integer;
  row: integer;
  vCols, vRows, vScrollvon: integer;
  rc: integer;
  vscrollbis: integer;
  exp: TExport;
  doExport: boolean;
  sl: TStringList;
begin
  //
  // entweder wird nichts übergeben , dann wird nur das Grid dargestellt
  // oder es wird im Falle eines Exports ein Zeiger auf
  doExport := false;
  if (pexp <> nil) then
  begin
    exp := pexp^;
    sl := TStringList.Create;
    doExport := true;
  end
  else
    sl := nil;

  rc := SG.rowcount;
  vCols := visibleCols; // cols und rows ändert sich dynamisch
  vRows := visibleRows;
  vScrollvon := scrollPosition; //

  if source = 'cwopenactions1' then
    maxDataRows := length(cwOpenActionsZ1);
  if source = 'cwopenactions2' then
    maxDataRows := length(cwOpenActionsZ2);
  if source = 'cwopenactionsOTR' then
    maxDataRows := length(cwTradeRecords);
  if source = 'cwactions' then
    maxDataRows := length(cwActions);
  if source = 'cwfilteredactions' then
    maxDataRows := length(cwFilteredActions);
  if source = 'cwsingleuseractions' then
    maxDataRows := length(cwSingleUserActions);
  if source = 'cwsymbols' then
    maxDataRows := length(cwSymbols);
  if ((source = 'cwusers') or (source = 'cwusers2')) then
    maxDataRows := length(cwusers);
  if ((source = 'cwusersx')) then
    maxDataRows := length(cwusersx);
  if source = 'cwcomments' then
    maxDataRows := length(cwComments);
  if source = 'cwsymbolsgroups' then
    maxDataRows := length(cwSymbolsGroups);
  if source = 'cwfilteredsymbolsgroups' then
    maxDataRows := length(cwFilteredSymbolsGroups);
  if source = 'cw3summaries' then
    maxDataRows := length(cw3summaries);
  if source = 'cwsummaries' then
    maxDataRows := length(cwsummaries);

  vscrollbis := vScrollvon + vRows;
  if vscrollbis > maxDataRows then
    vscrollbis := maxDataRows;

  if (doExport = true) then
  begin
    vScrollvon := 0;
    vscrollbis := maxDataRows;
    if (maxDataRows > 30000000) then
    begin
      showmessage('Maximum number of lines = 30000000');
      vscrollbis := 29999999;
    end;
  end;

  // es könnten mehrere Grids vorhanden sein welche dieselben Daten verwenden
  // daher wäre es besser das Sortierarray gehört zum Grid

  // die Selektion wird hier nicht übergeben obwohl das zB auch einen CSV Export nur der Selektion ermöglichen würde
  if source = 'cwopenactions1' then
    doOpenActionsGridCWDyn(SG, SGFieldCol, ixSorted, cwOpenActionsZ1, selSorted, vScrollvon, vscrollbis - 1, false, sl, exp.onlySelection);
  if source = 'cwopenactions2' then
    doOpenActionsGridCWDyn(SG, SGFieldCol, ixSorted, cwOpenActionsZ2, selSorted, vScrollvon, vscrollbis - 1, false, sl, exp.onlySelection);
  if source = 'cwopenactionsOTR' then
    doOpenActionsOTRGridCWDyn(SG, SGFieldCol, ixSorted, cwTradeRecords, selSorted, vScrollvon, vscrollbis - 1, false, sl, exp.onlySelection);
  if source = 'cwactions' then
    doActionsGridCWDyn(SG, SGFieldCol, ixSorted, cwActions, cwactionsplus, selSorted, vScrollvon, vscrollbis - 1, false, sl, exp.onlySelection);
  if source = 'cwfilteredactions' then
    doActionsGridCWDyn(SG, SGFieldCol, ixSorted, cwFilteredActions, cwFilteredactionsPlus, selSorted, vScrollvon, vscrollbis - 1, false, sl, exp.onlySelection);
  if source = 'cwsingleuseractions' then
    doActionsGridCWDyn(SG, SGFieldCol, ixSorted, cwSingleUserActions, cwSingleUserActionsPlus, selSorted, vScrollvon, vscrollbis - 1, false, sl, exp.onlySelection);
  if source = 'cwsymbols' then
    doSymbolsGridCWDyn(SG, SGFieldCol, ixSorted, cwSymbols, cwsymbolsplus, vScrollvon, vscrollbis - 1);
  if ((source = 'cwusers') or (source = 'cwusers2')) then
    doUsersGridCWDyn(SG, SGFieldCol, ixSorted, cwusers, cwusersplus, selSorted, vScrollvon, vscrollbis - 1, false, sl, exp.onlySelection);
  if ((source = 'cwusersx')) then
    doUsersGridCWDyn(SG, SGFieldCol, ixSorted, cwusersx, cwusersxplus, selSorted, vScrollvon, vscrollbis - 1, false, sl, exp.onlySelection);

  if source = 'cwcomments' then
    doCommentsGridCWDyn(SG, SGFieldCol, ixSorted, cwComments, selSorted, vScrollvon, vscrollbis - 1, false, sl, exp.onlySelection);

  if source = 'cwsymbolsgroups' then
    doSymbolsGroupsGridCWDyn(SG, SGFieldCol, ixSorted, cwSymbolsGroups, vScrollvon, vscrollbis - 1);
  if source = 'cwfilteredsymbolsgroups' then
    doSymbolsGroupsGridCWDyn(SG, SGFieldCol, ixSorted, cwFilteredSymbolsGroups, vScrollvon, vscrollbis - 1);
  if source = 'cw3summaries' then
    doSummaries3GridCWDyn(SG, SGFieldCol, ixSorted, cw3summaries, vScrollvon, vscrollbis - 1);
  if source = 'cwsummaries' then
    doSummariesGridCWDyn(SG, SGSum, SGFieldCol, ixSorted, cwsummaries, vScrollvon, vscrollbis - 1);

  // und nun die verschiedenen Summen der Spalten berechnen und eintragen
  makeSummaries;

  if (doExport = true) then
  begin
    // die sl ist nun bereits erzeugt worden
    sl.SaveToFile(exp.fileName);
    if (exp.onlySelection = false) then
      showmessage(inttostr(vscrollbis - vScrollvon + 1) + ' lines successfully exported to:' + exp.fileName)
    else
      showmessage(inttostr(selectedCt) + ' lines successfully exported to:' + exp.fileName);
    sl.Free;
  end;

  // hier kann auch ein Col resized worden sein! Das kann man merken, wenn SG nicht mehr dieselbe ColsWidth hat wie SGSUm
  // end;
end;

procedure TDynGrid.SGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  i: integer;
  grid: FTCommons.TStringGridSorted;
  col, row: integer;
  fixedCol, fixedRow: boolean;
  gt: cardinal;
  Cursor: TCursor;
  header: string;
begin
  if (Button = mbleft) then
    lbdebug('MD left')
  else if (Button = mbright) then
    lbdebug('MD right')
  else
    lbdebug('MD wedernoch');
  gt := gettickcount;
  lbdebug('Zwischenzeit:' + inttostr(gt - lastMouseDown));
  if ((gt - lastMouseDown) < mouseDownPause) then
  begin
    lbdebug('zu schnell MouseDown - Abbruch');
    if (Button = mbleft) then
    begin
      grid := Sender as FTCommons.TStringGridSorted; // das ist gleichzeitig SG
      grid.MouseToCell(X, Y, col, row);
      mucol := col;
      suchInSpalte;
    end;
    // grid := Sender as FTCommons.TStringGridSorted; // das ist gleichzeitig SG
    // self.SGMouseUp(self,mbLeft,sssShift,x,y);
    exit;
  end;
  lastMouseDown := gt;
  gt := timegettime();
  grid := Sender as FTCommons.TStringGridSorted; // das ist gleichzeitig SG
  // diese Routine ist nicht im FTCollector sondern nur im FlowAnalyzer

  if Button = mbleft then
  begin
    grid.MouseToCell(X, Y, col, row);
    mdcol := col;
    mdrow := row;
    if (row = 0) then
      // Dragmodus der Col einleiten - Mauscursor umschalten
      Screen.Cursor := crDrag;
    if ((col > -1) and (row > -1)) then
    begin
      ClipBoard.AsText := grid.Cells[col, row];
      // hier kann dann individuell gehandelt werden !
      form2.gridMouseClickHandler(grid, col, row, Button, Shift, source);

    end;

  end;
  if Button = mbright then
  // Rechte Maus = Sortieren der Col
  begin
    Cursor := Screen.Cursor;
    try
      try
        Screen.Cursor := crHourGlass;
        grid.MouseToCell(X, Y, col, row);
        if ((col = -1) or (row = -1)) then
          // exit;
          fixedCol := col < grid.FixedCols;
        fixedRow := row < grid.fixedrows;

        if fixedRow then
        // Rechtsclick in den Header -> Sortieren
        // Das Sortieren erfolgt spezifisch zum Thema des Grids
        begin
          sortCol := grid.Cells[col, 0];
          sortDir := -sortDir;
          grid.Selection := NoSelection;
          doSorting();
          setlength(sSort, 0); // NEU 12.12.19
          setlength(dSort, 0);

          // if source = 'cwopenactions1' then
          // sortGridCwOpenActions(source, sortcol, sortdir, cwOpenActionsZ1);
          // if source = 'cwopenactions2' then
          // sortGridCwOpenActions(source, sortcol, sortdir, cwOpenActionsZ2);
          // if source = 'cwopenactionsOTR' then
          // sortGridCwOpenActionsOTR(source, sortcol, sortdir, cwTradeRecords);
          // if source = 'cwactions' then
          // sortGridCwactions(source, sortcol, sortdir, cwactions);
          // if source = 'cwfilteredactions' then
          // sortGridCwactions(source, sortcol, sortdir, cwfilteredactions);
          // if source = 'cwsingleuseractions' then
          // sortGridCwactions(source, sortcol, sortdir, cwSingleUserActions);
          // if source = 'cwsymbols' then
          // sortGridCwSymbols(source, sortcol, sortdir, cwSymbols, cwsymbolsplus);
          // if ((source = 'cwusers') or (source = 'cwusers2')) then
          // sortGridCwUsers(source, sortcol, sortdir, cwUsers, cwusersplus);
          // if source = 'cwcomments' then
          // sortGridCwComments(source, sortcol, sortdir, cwComments);
          // if source = 'cwsymbolsgroups' then
          // sortGridCwSymbolsGroups(source, sortcol, sortdir, cwSymbolsGroups);
          // if source = 'cwfilteredsymbolsgroups' then
          // sortGridCwSymbolsGroups(source, sortcol, sortdir, cwFilteredSymbolsGroups);
          // if source = 'cwsummaries' then
          // sortGridCwSummaries(source, sortcol, sortdir, cwsummaries);

        end
        else if fixedCol then
          // die restlichen Rechtsclicks bewirken nichts
          // Right-click in a "row header"
        else
          // Right-click in a non-fixed cell
          form2.gridMouseClickHandler(grid, col, row, Button, Shift, source);

      finally
        Screen.Cursor := Cursor;
      end;
    except
      lbdebug('Fehler:');
    end;
    lbdebug('MD:Zeit Gridsort:' + inttostr(timegettime - gt));
  end;
end;

procedure TDynGrid.SGMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  col, row, merk, merkWidth, i, nr, anr, fall, seltop, selbottom: integer;
  grid: FTCommons.TStringGridSorted;
  Cursor: TCursor;
  such, vgl: string;
  suchLength: integer;
  suchfound: boolean;
  gt: cardinal;
  found: integer;
  flag: boolean;
begin

  //
  if Button = mbleft then
  begin
    Cursor := Screen.Cursor;
    Screen.Cursor := crDefault;
    grid := Sender as FTCommons.TStringGridSorted;
    grid.MouseToCell(X, Y, col, row);
    mucol := col;
    murow := row;

    if ((col = -1) or (row = -1)) then
      exit;

    // showmessage(inttostr(mdcol)+'/'+inttostr(mucol));
    // dasselbe sollte im normalen Grid passieren - statt mdcol mucol ist es dann eben from und to
    if Cursor = crDrag then
    // im Verschiebemodus der Cols wurde die Maus losgelassen
    begin
      if ((murow = 0) and (mdrow = 0)) then
      begin
        if (mucol <> mdcol) then
        begin
          // col wurde verschoben
          setlength(SGColField, length(SGFieldCol));
          for i := 0 to length(SGFieldCol) - 1 do
            SGColField[SGFieldCol[i]] := i;

          if (mucol > mdcol) then
          begin
            // nach rechts verschoben
            merk := SGColField[mdcol];
            merkWidth := SG.ColWidths[mdcol];
            for i := mdcol to mucol - 1 do
            begin
              SGColField[i] := SGColField[i + 1];
              SG.ColWidths[i] := SG.ColWidths[i + 1];
              SGSum.ColWidths[i] := SGSum.ColWidths[i + 1];
            end;
            SGColField[mucol] := merk;
            SG.ColWidths[mucol] := merkWidth;
            SGSum.ColWidths[mucol] := merkWidth;
          end
          else
          begin
            // nach links verschoben
            merk := SGColField[mdcol];
            merkWidth := SG.ColWidths[mdcol];
            for i := mdcol downto mucol + 1 do
            begin
              SGColField[i] := SGColField[i - 1];
              SG.ColWidths[i] := SG.ColWidths[i - 1];
              SGSum.ColWidths[i] := SGSum.ColWidths[i - 1];
            end;
            SGColField[mucol] := merk;
            SG.ColWidths[mucol] := merkWidth;
            SGSum.ColWidths[mucol] := merkWidth;
          end
        end
        else
        // autosizegrid(SG,SGsum)
        begin
          if ssShift in Shift then
          begin
            suchInSpalte;

            // such := InputBox('Search in column', 'Search expression:', '');
            // // immer in Großbuchstaben wandeln
            // such := uppercase(such);
            // suchlength := such.length;
            // if such <> '' then
            // begin
            // suchfound := false;
            // gt := gettickcount;
            // i := scrollPosition;
            // // der Parameter mucol ist hier falsch
            // // wenn das SGColField(mucol) dann ist das Field wenigstens unverwechselbar
            // // string wäre leichter umzusetzen ist aber in der Suche langsam !
            // if source = 'cwopenactions1' then
            // // fehlt wegen zu viel Aufwand !
            // showmessage('Suchfunktion in' + source + ' noch nicht implementiert');
            //
            // // found := findActionparameter(SG, SGFieldCol, ixSorted, cwOpenActionsZ1, i, SGColField[mucol], such)
            // ;
            // if source = 'cwopenactions2' then
            // // fehlt
            // // found := findActionparameter(SG, SGFieldCol, ixSorted, cwOpenActionsZ2, i, SGColField[mucol], such)
            // showmessage('Suchfunktion in' + source + ' noch nicht implementiert');;
            // if source = 'cwactions' then
            // found := findActionparameter(SG, SGFieldCol, ixSorted, cwActions, i, SGColField[mucol], such)
            // else if source = 'cwfilteredactions' then
            // found := findActionparameter(SG, SGFieldCol, ixSorted, cwFilteredActions, i, SGColField[mucol], such)
            // else if source = 'cwsingleuseractions' then
            // found := findActionparameter(SG, SGFieldCol, ixSorted, cwSingleUserActions, i, SGColField[mucol], such)
            // else if source = 'cwsymbols' then
            // found := -2
            // else if ((source = 'cwusers') or (source = 'cwusers2')) then
            // found := -2
            // else if source = 'cwcomments' then
            // found := -2
            // else if source = 'cwsymbolsgroups' then
            // found := -2
            // else if source = 'cwfilteredsymbolsgroups' then
            // found := -2;
            // if found > -1 then
            // // todo das ist natürlich bei DynGrid Quatsch !
            // ScrollBar1.Position := found;
            // if (found = -1) then
            // showmessage('z:' + inttostr(gettickcount - gt));
            // if (found = -2) then
            // showmessage('Funktion in' + source + ' noch nicht implementiert');
            //
            // end;
          end;
        end;

        ;

        for i := 0 to length(SGFieldCol) - 1 do
          SGFieldCol[SGColField[i]] := i;

        saveInit;
      end;
    end
    else
    begin

      workSelection(mdrow, murow, Button, Shift);
    end;

    // das ist die Tauschvariante
    // i := SGFieldCol[mucol];
    // SGFieldCol[mucol] := SGFieldCol[mdcol];
    // SGFieldCol[mdcol] := i;
    // hier kann sich colwidths geändert haben !
    flag := false;
    if (SG.ColWidths[mdcol] <> SGSum.ColWidths[mdcol]) then
    begin
      SGSum.ColWidths[mdcol] := SG.ColWidths[mdcol];
      flag := true;
    end;

    if (SG.ColWidths[mucol] <> SGSum.ColWidths[mucol]) then
    begin
      SGSum.ColWidths[mucol] := SG.ColWidths[mucol];
      flag := true;
    end;
    if (flag = true) then
      saveInit;

    gridHandler(nil);
  end;

  // ClipBoard.AsText := grid.Cells[col, row];
  // hier kann dann individuell gehandelt werden !
  // gridMouseLeftClickHandler(grid, col, row, grid.Cells[col, row], grid.Cells[col, 0], grid.Cells[0, row]);

end;

procedure TDynGrid.saveInit();
var
  i: integer;
begin
  // hier könnte in INI File gesichert werden
  faIni.writeBool('dyngrid:' + source, iniHeader, true);
  for i := 0 to length(SGFieldCol) - 1 do
  begin
    faIni.writeInteger('dyngrid:' + source, 'sfc' + inttostr(i), SGFieldCol[i]);
    faIni.writeInteger('dyngrid:' + source, 'scf' + inttostr(i), SGColField[i]);
    faIni.writeInteger('dyngrid:' + source, 'cw' + inttostr(i), SG.ColWidths[i]);
  end;
  faIni.UpdateFile;

end;

procedure TDynGrid.workSelection(mdrow, murow: integer; Button: TMouseButton; Shift: TShiftState);
var
  nr, anr, fall, i, seltop, selbottom: integer;
begin
  // Dieser Bereich gehört in eine eigene Procedure die dann auch über die Key Tasten angesteuert werden kann
  // Selektion bearbeiten
  // type TShiftState = set of (ssShift, ssAlt, ssCtrl, ssLeft, ssRight, ssMiddle, ssDouble);

  nr := scrollPosition + murow - 1;
  if (length(ixSorted) = 0) then
    exit;

  anr := ixSorted[nr];
  // showmessage(inttostr(scrollPosition) + '/' + inttostr(murow) + ' ' + inttostr(cwactions[anr].actionId));
  if ((murow = 0) and (mdrow = 0)) then
    // damit wird shift up nicht als Fall 0 behandelt weil hier mdrow=1 und murow=0
    fall := 0 // shift links oben
  else
  begin
    fall := 1;
    if ssShift in Shift then
    begin
      fall := 2;
    end;
    if ssCtrl in Shift then
    begin
      fall := 3;
    end;
    if (ssCtrl in Shift) and (ssShift in shift)  then
    begin
      fall := 4;
    end;
  end;
  case fall of
    1:
      begin
        // alte Selektion abschalten
        for i := 0 to length(selSorted) - 1 do
          selSorted[i] := 0;
        // eine Zeile selektieren
        selSorted[anr] := selSorted[anr] xor 1;
      end;
    2:
      begin
        // der kompliziertere Fall
        seltop := -1;
        selbottom := -1;
        for i := 0 to length(selSorted) - 1 do
        begin
          if selSorted[ixSorted[i]] = 1 then
          begin
            if seltop = -1 then  //der erste selektierte Eintrag von oben nach unten
              seltop := i;
            selbottom := i;   //der letzte selektierte Eintrag nach unten
          end;
        end;
        if nr < seltop then  //es wurde über dem obersten selektierten Eintrag geklickt
        begin
          for i := nr to seltop - 1 do
          begin
            selSorted[ixSorted[i]] := 1;
          end;
        end;
        if nr > selbottom then   //es wurde unter dem untersten selektierten Eintrag geklickt
        begin
          for i := selbottom + 1 to nr do
          begin
            selSorted[ixSorted[i]] := 1;
          end;

        end;
        if (nr >= seltop) and (nr <= selbottom) then //es wurde zwischen dem obersten und dem untersten selektierten Eintrag geklickt
        begin
          selSorted[ixSorted[nr]] := selSorted[ixSorted[nr]] xor 1;
          for i := nr + 1 to length(selSorted) - 1 do
          begin
            selSorted[ixSorted[i]] := 0;
          end;

        end;

      end;
    3:
      selSorted[anr] := selSorted[anr] xor 1;
    4: //shift+Ctrl
      ;
    0:
      // könnte einfach Linksclick oder auch Size-Änderung der Colwidth sein
      // col kann aber auch links oder rechts vom Col-Trenner liegen je nachdem wo halt die Maus losgelassen wurde
      begin
        // showmessage('col:'+inttostr(mucol)+' row:'+inttostr(murow)+' ='+inttostr(sg.colwidths[mucol]));
        // am besten die COlWidts nun nach SGsum kopieren
        for i := 0 to SG.colcount - 1 do
          SGSum.ColWidths[i] := SG.ColWidths[i];
        exit; // nicht gridhandler aufrufen !
      end;

  end;
  selectedCt := 0;
  if (fall <> 0) then
    for i := 0 to length(selSorted) - 1 do
    begin
      if selSorted[ixSorted[i]] = 1 then
      begin
        inc(selectedCt);
      end;
    end;
  lblSelection.Caption := inttostr(selectedCt) + ' rows selected';

end;

procedure TDynGrid.SGMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: boolean);
begin
  with Sender as Tstringgrid do
  begin
    // obere Reihe + angezeigte Reihen darf nicht größer sein, als die Gesamtreihen
    if TopRow + VisibleRowCount < rowcount then
      TopRow := TopRow + 1
  end;
  Handled := true;
end;

procedure TDynGrid.SGMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: boolean);
begin
  with Sender as Tstringgrid do
  begin
    if TopRow > fixedrows then
      TopRow := TopRow - 1
  end;
  Handled := true;
end;

end.
