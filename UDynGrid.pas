unit UDynGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, StringGridSorted, Vcl.ExtCtrls,FTCommons;

type
  TDynGrid = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    SG: FTCommons.TStringGridSorted;
    ScrollBar1: TScrollBar;
    lblHeader: TLabel;
    constructor Create(AOwner: TComponent); override;
    procedure Panel2Resize(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure initGrid(rows: integer; cols: integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  var
    initialized: boolean;
    maxDataRows, visibleCols, visibleRows, scrollPosition: integer;
  end;

implementation

{$R *.dfm}

uses FlowAnalyzer,FTTypes;

constructor TDynGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  initialized := true;
  maxDataRows := 0;
end;

procedure TDynGrid.initGrid(rows: integer; cols: integer);
var
  mrows: integer;
begin
  maxDataRows := 0;
  mrows := visibleRows;
  if rows < mrows then
    mrows := rows;
  SG.RowCount := mrows;
  SG.Colcount := cols;
  maxdatarows:=rows;
  Panel2Resize(self);
end;

procedure TDynGrid.Panel2Resize(Sender: TObject);
var
  max: integer;
begin
  // neu Einstellen der Grenzen
  visibleRows := trunc((SG.height / SG.defaultrowheight)) + 1;
  visibleCols := trunc((SG.width / SG.defaultcolwidth)) + 1;
  ScrollBar1.Min := 0;
  max := maxDataRows - visibleRows;
  if max < 0 then
    max := 0;
  ScrollBar1.max := max;
  if maxDataRows > 0 then
    form2.gridhandler(self);

end;

procedure TDynGrid.ScrollBar1Change(Sender: TObject);
begin
  scrollPosition := ScrollBar1.Position;
  if maxDataRows > 0 then
    form2.gridhandler(self);

end;

end.
