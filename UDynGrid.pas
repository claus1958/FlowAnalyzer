unit UDynGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, StringGridSorted, Vcl.ExtCtrls, MMSystem,
  FTCommons;

type
  TDynGrid = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    SG: FTCommons.TStringGridSorted;
    ScrollBar1: TScrollBar;
    lblHeader: TLabel;
    lblTime: TLabel;
    constructor Create(AOwner: TComponent); override;
    procedure Panel2Resize(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure initGrid(source: string; sortcol: string; sortdir: integer; rows: integer; cols: integer);
    procedure sortGridCwactions(source: string; sortcol: string; sortdir: integer; var actions: DACwAction);
    procedure SGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure gridHandler(Sender: TObject);
    procedure SGRowMoved(Sender: TObject; FromIndex, ToIndex: integer);
    procedure SGMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure SGDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  var

    SGFieldCol: DAInteger;
    SGColField: DAInteger;
    initialized: boolean;
    maxDataRows, visibleCols, visibleRows, scrollPosition: integer;
    source: string;
    dSort: doubleArray;
    sSort: Stringarray;
    ixSorted: intarray;
    sorttyp: integer;
    sortdir: integer;
    sortcol: string;
    mdcol, mdrow: integer;
    mucol, murow: integer;
    autosized: boolean;
  end;

implementation

{$R *.dfm}

uses FlowAnalyzer, FTTypes;

constructor TDynGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  initialized := true;
  maxDataRows := 0;
  setlength(dSort, 0);
  setlength(sSort, 0);
end;

procedure TDynGrid.initGrid(source: string; sortcol: string; sortdir: integer; rows: integer; cols: integer);
var
  mrows, dl, i, scol, smethode: integer;
  j,k:integer;
begin

  self.source := source;
  self.sortcol:=sortcol;
  self.sortdir := sortdir;
  maxDataRows := 0;
  mrows := visibleRows;
  if rows < mrows then
    mrows := rows;

  SG.RowCount := mrows;
  SG.Colcount := cols;
  for j:=0 to sg.rowcount-1 do
    for k:=0 to sg.colcount-1 do
      sg.cells[k,j]:='*';

  setlength(SGFieldCol, cols);
  setlength(SGColField, cols);
  for i := 0 to cols - 1 do
  begin
    SGFieldCol[i] := i;
    SGColField[i] := i;
  end;
  maxDataRows := rows;
  // source   cwactions
  // sortcol  ActionId
  // sortdir  1  und -1
  if source = 'cwactions' then
    sortGridCwactions(source, sortcol, sortdir, cwactions);
  if source = 'cwactionsselection' then
    sortGridCwactions(source, sortcol, sortdir, cwactionsselection);
  if source = 'cwsingleuseractions' then
    sortGridCwactions(source, sortcol, sortdir, cwSingleUserActions);



  autosized := false;
end;

procedure TDynGrid.sortGridCwactions(source: string; sortcol: string; sortdir: integer; var actions: DACwAction);
var
  dl, i, scol, smethode: integer;
  gt: cardinal;
begin
  // Hier steckt jetzt sehr viel Spezielles drin
  gt := gettickcount;

  dl := length(actions);

  setlength(ixSorted, dl);
  smethode := 1; // double  2=String
  scol := 1;
  if ((source = 'cwactions') or (source = 'cwactionsselection') or (source='cwsingleuseractions')) then
  begin
    if sortcol = 'actionId' then
      scol := 1;

    if sortcol = 'userId' then
      scol := 2;

    if sortcol = 'accountId' then
      scol := 3;

    if sortcol = 'symbolId' then
      scol := 4;

    if sortcol = 'commentId' then
      scol := 5;

    if sortcol = 'typeId' then
      scol := 6;

    if sortcol = 'sourceId' then
      scol := 7;

    if sortcol = 'openTime' then
      scol := 8;

    if sortcol = 'closeTime' then
      scol := 9;

    if sortcol = 'expirationTime' then
      scol := 10;

    if sortcol = 'openPrice' then
      scol := 11;

    if sortcol = 'closePrice' then
      scol := 12;

    if sortcol = 'stopLoss' then
      scol := 13;

    if sortcol = 'takeProfit' then
      scol := 14;

    if sortcol = 'swap' then
      scol := 15;

    if sortcol = 'profit' then
      scol := 16;

    if sortcol = 'volume' then
      scol := 17;

    if sortcol = 'precision' then
      scol := 18;

    if sortcol = 'conversionRate0' then
      scol := 19;

    if sortcol = 'conversionRate1' then
      scol := 20;

    if sortcol = 'marginRate' then
      scol := 21;

    // die beiden sind errechnete Werte
    if sortcol = 'symbol' then
      scol := 22;
    if sortcol = 'comment' then
      scol := 23;

    if ((scol = 22) or (scol = 23)) then
      setlength(sSort, dl)
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
          dSort[i] := actions[i].commentId;
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
          dSort[i] := actions[i].closeTime;
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
          sSort[i] := getcwcomment(actions[i].commentId);
          continue;
        end;
      end;
    end;
    // nun sortieren
    if smethode = 1 then
    begin
      if sortdir = 1 then
        FastSort2ArrayDouble(dSort, ixSorted, 'VDA')
      else
        FastSort2ArrayDouble(dSort, ixSorted, 'VUA');
      if smethode = 2 then
    end;

    if smethode = 2 then
    begin
      if sortdir = 1 then
        FastSort2ArrayString(sSort, ixSorted, 'VUAS')
      else
        FastSort2ArrayString(sSort, ixSorted, 'VDAS')

    end;

  end;
  lblTime.caption := inttostr(gettickcount - gt);
  Panel2Resize(self);
end;

procedure TDynGrid.Panel2Resize(Sender: TObject);
var
  max: integer;
begin
  // neu Einstellen der Grenzen
  visibleRows := trunc((SG.height / SG.defaultrowheight)) + 1;
  visibleCols := trunc((SG.width / SG.defaultcolwidth)) + 1;
  if SG.RowCount < visibleRows then
    SG.RowCount := visibleRows;
  //1 fix Row erfordert min. 2 RowCount
  if sg.RowCount<2 then
    sg.rowcount:=2;
  if sg.fixedrows=0 then
    sg.fixedrows:=1;
  ScrollBar1.Min := 0;
  max := maxDataRows - visibleRows + 4;
  if max < 0 then
    max := 0;
  ScrollBar1.max := max;
  if maxDataRows > 0 then
  begin
    gridHandler(self);
    if autosized = false then
    begin
      autosizegrid(SG);
      autosized := true; // nur einmal bei der ersten Darstellung nach dem Init und Sort
    end;
  end;

end;

procedure TDynGrid.ScrollBar1Change(Sender: TObject);
begin
  scrollPosition := ScrollBar1.Position;
  if maxDataRows > 0 then
    gridHandler(self);

end;

procedure TDynGrid.gridHandler(Sender: TObject);
var
  // sg: TDynGrid;
  i, j, k: integer;
  row: integer;
  vCols, vRows, vScrollvon: integer;
  rc: integer;
  vscrollbis: integer;
begin
  //
  // with Sender as TDynGrid do
  // begin
  rc := SG.RowCount;
  vCols := visibleCols; // cols und rows ändert sich dynamisch
  vRows := visibleRows;
  vScrollvon := scrollPosition; //

  if source = 'cwactions' then
    maxDataRows := length(cwactions);
  if source = 'cwactionsselection' then
    maxDataRows := length(cwactionsselection);
  if source = 'cwsingleuseractions' then
    maxDataRows := length(cwSingleUserActions);

  vscrollbis := vScrollvon + vRows;
  if vscrollbis > maxDataRows then
    vscrollbis := maxDataRows;
  // es könnten mehrere Grids vorhanden sein welche dieselben Daten verwenden
  // daher wäre es besser das Sortierarray gehört zum Grid
  if source = 'cwactions' then
    doActionsGridCWFast(SG, SGFieldCol, ixSorted, cwactions, vScrollvon, vscrollbis - 1);
  if source = 'cwactionsselection' then
    doActionsGridCWFast(SG, SGFieldCol, ixSorted, cwactionsselection, vScrollvon, vscrollbis - 1);
  if source = 'cwsingleuseractions' then
    doActionsGridCWFast(SG, SGFieldCol, ixSorted, cwsingleuseractions, vScrollvon, vscrollbis - 1);

  // end;
end;

procedure TDynGrid.SGDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
begin
  // Beispiel für selbst gezeichnete Zelle
  // in SG.Objects[] steckt in diesem Fall die Farbe
  // procedure TForm46.SGDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
  //
  // var
  // count, r, C: integer;
  // begin
  // r := ARow; // Copy variable 'row' as it only  seems to be valid for a short time
  // C := ACol; // yes I know this should not be required for new delphi versions
  // count := ((ARow - 1) * SG.colcount) + ACol; // calculate our position in the stringlist
  //
  // with (Sender as tstringgrid) do
  // begin
  // if State = [] then // dont overwrite fixed areas
  // begin
  // // if R  = Foundrow then
  // // canvas.brush.color := Findcolor
  // // else
  //
  // canvas.brush.color := (Objects[C, r] as TCellColor).Backcolor;
  // canvas.fillrect(Rect);
  // canvas.font.color := (Objects[C, r] as TCellColor).Fontcolor;
  // canvas.textout(Rect.left + 4, Rect.top + 4, Cells[ACol, ARow]);
  // end;
  // end;
  //
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
  gt := timegettime();
  grid := Sender as FTCommons.TStringGridSorted;
  // diese Routine ist nicht im FTCollector sondern nur im FlowAnalyzer
  if Button = mbleft then
  begin
    Screen.Cursor := crDrag;
    grid.MouseToCell(X, Y, col, row);
    mdcol := col;
    mdrow := row;
    // ClipBoard.AsText := grid.Cells[col, row];
    // hier kann dann individuell gehandelt werden !
    // gridMouseLeftClickHandler(grid, col, row, grid.Cells[col, row], grid.Cells[col, 0], grid.Cells[0, row]);

  end;
  if Button = mbright then
  begin
    Cursor := Screen.Cursor;
    try
      try
        Screen.Cursor := crHourGlass;
        grid.MouseToCell(X, Y, col, row);

        fixedCol := col < grid.FixedCols;
        fixedRow := row < grid.FixedRows;

        if fixedRow then
        // Rechtsclick in den Header -> Sortieren
        begin
          sortcol := grid.Cells[col, 0];
          sortdir := -sortdir;
          grid.Selection := NoSelection;
          if source = 'cwactions' then
            sortGridCwactions(source, sortcol, sortdir, cwactions);
          if source = 'cwactionsselection' then
            sortGridCwactions(source, sortcol, sortdir, cwactionsselection);
          if source = 'cwsingleuseractions' then
            sortGridCwactions(source, sortcol, sortdir, cwSingleUserActions);
        end
        else if fixedCol then
          // Right-click in a "row header"
        else
          // Right-click in a non-fixed cell
        finally
          Screen.Cursor := Cursor;
        end;
      except
        LbDebug('Fehler:');
      end;
      LbDebug('Zeit Gridsort:' + inttostr(timegettime - gt));
    end;
  end;

  procedure TDynGrid.SGMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
  var
    col, row, merk, i: integer;
    grid: FTCommons.TStringGridSorted;
    Cursor: TCursor;
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
      // showmessage(inttostr(mdcol)+'/'+inttostr(mucol));
      if Cursor = crDrag then
      begin
        if (murow = 0) and (mdrow = 0) then
        begin
          if (mucol <> mdcol) then
          begin
            setlength(SGColField, length(SGFieldCol));
            for i := 0 to length(SGFieldCol) - 1 do
              SGColField[SGFieldCol[i]] := i;

            if (mucol > mdcol) then
            begin
              merk := SGColField[mdcol];
              for i := mdcol to mucol - 1 do
                SGColField[i] := SGColField[i + 1];
              SGColField[mucol] := merk;
            end
            else
            begin
              merk := SGColField[mdcol];
              for i := mdcol downto mucol + 1 do
                SGColField[i] := SGColField[i - 1];
              SGColField[mucol] := merk;
            end
          end
          else
            // autosizegrid(SG)
              ;
          for i := 0 to length(SGFieldCol) - 1 do
            SGFieldCol[SGColField[i]] := i;

        end;
      end;

      // das ist die Tauschvariante
      // i := SGFieldCol[mucol];
      // SGFieldCol[mucol] := SGFieldCol[mdcol];
      // SGFieldCol[mdcol] := i;
      gridHandler(nil);
    end;

    // ClipBoard.AsText := grid.Cells[col, row];
    // hier kann dann individuell gehandelt werden !
    // gridMouseLeftClickHandler(grid, col, row, grid.Cells[col, row], grid.Cells[col, 0], grid.Cells[0, row]);

  end;

  procedure TDynGrid.SGRowMoved(Sender: TObject; FromIndex, ToIndex: integer);
  var
    i: integer;
  begin
    //
    exit;

    i := SGFieldCol[FromIndex];
    SGFieldCol[FromIndex] := SGFieldCol[ToIndex];
    SGFieldCol[ToIndex] := i;
    for i := 0 to SG.Colcount - 1 do
    begin
      // sgcolfield(sg.Cols[i,0].Text

    end;
  end;

end.
