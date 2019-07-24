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
    procedure sortGrid(source: string; sortcol: string; sortdir: integer);
    procedure SGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure gridHandler(Sender: TObject);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  var
    initialized: boolean;
    maxDataRows, visibleCols, visibleRows, scrollPosition: integer;
    source: string;
    dSort: doubleArray;
    sSort: Stringarray;
    ixSorted: intarray;
    sorttyp: integer;
    sortdir: integer;
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
begin
  self.source := source;
  self.sortdir := sortdir;
  maxDataRows := 0;
  mrows := visibleRows;
  if rows < mrows then
    mrows := rows;
  SG.RowCount := mrows;
  SG.Colcount := cols;
  maxDataRows := rows;
  // source   cwactions
  // sortcol  ActionId
  // sortdir  1  und -1
  sortGrid(source, sortcol, sortdir);
end;

procedure TDynGrid.sortGrid(source: string; sortcol: string; sortdir: integer);
var
  dl, i, scol, smethode: integer;
  gt: cardinal;
begin
  // Hier steckt jetzt sehr viel Spezielles drin
  gt := gettickcount;
  dl := length(cwactions);
  setlength(ixSorted, dl);
  smethode := 1; // double  2=String
  scol := 1;
  if source = 'cwactions' then
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
          dSort[i] := cwactions[i].actionId;
          continue;
        end;
        if scol = 2 then
        begin
          dSort[i] := cwactions[i].userId;
          continue;
        end;
        if scol = 3 then
        begin
          dSort[i] := cwactions[i].accountId;
          continue;
        end;
        if scol = 4 then
        begin
          dSort[i] := cwactions[i].symbolId;
          continue;
        end;
        if scol = 5 then
        begin
          dSort[i] := cwactions[i].commentId;
          continue;
        end;
        if scol = 6 then
        begin
          dSort[i] := cwactions[i].typeId;
          continue;
        end;
        if scol = 7 then
        begin
          dSort[i] := cwactions[i].sourceId;
          continue;
        end;
        if scol = 8 then
        begin
          dSort[i] := cwactions[i].openTime;
          continue;
        end;
        if scol = 9 then
        begin
          dSort[i] := cwactions[i].closeTime;
          continue;
        end;
        if scol = 10 then
        begin
          dSort[i] := cwactions[i].expirationTime;
          continue;
        end;
        if scol = 11 then
        begin
          dSort[i] := cwactions[i].openPrice;
          continue;
        end;
        if scol = 12 then
        begin
          dSort[i] := cwactions[i].closePrice;
          continue;
        end;
        if scol = 13 then
        begin
          dSort[i] := cwactions[i].stopLoss;
          continue;
        end;
        if scol = 14 then
        begin
          dSort[i] := cwactions[i].takeProfit;
        end;
        if scol = 15 then
        begin
          dSort[i] := cwactions[i].swap;
          continue;
        end;
        if scol = 16 then
        begin
          dSort[i] := cwactions[i].profit;
          continue;
        end;
        if scol = 17 then
        begin
          dSort[i] := cwactions[i].volume;
          continue;
        end;
        if scol = 18 then
        begin
          dSort[i] := cwactions[i].precision;
          continue;
        end;
        if scol = 19 then
        begin
          dSort[i] := cwactions[i].conversionRate0;
          continue;
        end;
        if scol = 20 then
        begin
          dSort[i] := cwactions[i].conversionRate1;
          continue;
        end;
        if scol = 21 then
        begin
          dSort[i] := cwactions[i].marginRate;
          continue;
        end;
        if scol = 22 then
        begin
          smethode := 2;
          sSort[i] := getcwsymbol(cwactions[i].symbolId);
          continue;
        end;
        if scol = 23 then
        begin
          smethode := 2;
          sSort[i] := getcwcomment(cwactions[i].commentId);
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

  ScrollBar1.Min := 0;
  max := maxDataRows - visibleRows+4;
  if max < 0 then
    max := 0;
  ScrollBar1.max := max;
  if maxDataRows > 0 then
    gridHandler(self);

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
  maxDataRows := length(cwactions);

  vscrollbis := vScrollvon + vRows;
  if vscrollbis > maxDataRows then
    vscrollbis := maxDataRows;
  // es könnten mehrere Grids vorhanden sein welche dieselben Daten verwenden
  // daher wäre es besser das Sortierarray gehört zum Grid

  // doActionsGridCWFast(SG, SGFieldCol, cwActions,vscroll, vscrollmax);
  doActionsGridCWFast(SG, SGFieldCol, ixSorted, cwactions, vScrollvon, vscrollbis-1);
  autosizegrid(SG);
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
    grid.MouseToCell(X, Y, col, row);
    grid.Cells[col, row];
    // hier kann dann individuell gehandelt werden !
    // gridMouseLeftClickHandler(grid, col, row, grid.Cells[col, row], grid.Cells[col, 0], grid.Cells[0, row]);
    // ClipBoard.AsText := grid.Cells[col, row];

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
          header := grid.Cells[col, 0];
          sortdir := -sortdir;
          grid.Selection := NoSelection;
          sortGrid(source, header, sortdir);
        end
        else if fixedCol then
          // Right-click in a "row header"
        else
          // Right-click in a non-fixed cell
        finally
          Screen.Cursor := Cursor;
        end;
      except
            LbDebug('Fehler:' );
      end;
    end;
    LbDebug('Zeit Gridsort:' + inttostr(timegettime - gt));
  end;

end.
