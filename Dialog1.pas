unit Dialog1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, XFlowanalyzer, Vcl.ExtCtrls, FTCommons, UDynGrid;

type
  TForm5 = class(TForm)
    Timer1: TTimer;
    chkLB1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Timer2: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure init(DG: TDynGrid);
    procedure gridselektor(DG: TDynGrid);
    procedure chkLB1DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure chkLB1Select(Sender: TObject);
    procedure chkLB1Click(Sender: TObject);
    procedure takeit;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);

  private
    chkLB1Selected: array of boolean;
    mmon: boolean;
    mmc: Integer;
    mm: array [1 .. 1000] of Integer;
    myDG: TDynGrid;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;
{$SETPEFLAGS IMAGE_FILE_LARGE_ADDRESS_AWARE}

procedure TForm5.Button1Click(Sender: TObject);
var i:integer;

begin
  for i := 0 to myDG.sg.colcount - 1 do
  begin
    chkLB1Selected[i] := true;

  end;
  chklb1.DroppedDown:=true;

end;



procedure TForm5.Button2Click(Sender: TObject);
var i:integer;

begin
  for i := 0 to myDG.sg.colcount - 1 do
  begin
    chkLB1Selected[i] := false;

  end;
  chklb1.DroppedDown:=true;
end;

procedure TForm5.Button3Click(Sender: TObject);
begin
takeit;
dialog1.form5.close;
end;

procedure TForm5.Button4Click(Sender: TObject);
begin
dialog1.form5.Close;

end;

procedure TForm5.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  i := 0;
end;

procedure TForm5.FormShow(Sender: TObject);
begin
//führt dazu dass irgendwo am Scrfeen die Combobox hängt
//chklb1.DroppedDown:=true;
timer2.Interval:=1000;
timer2.Enabled:=true;
end;

procedure TForm5.gridselektor(DG: TDynGrid);
var
  i: Integer;
begin
  //
  myDG := DG;
  chkLB1.items.clear;
  setlength(chklb1selected,myDG.sg.colcount);
  for i := 0 to myDG.sg.colcount - 1 do
  begin
    chkLB1.items.Add(myDG.sg.Cells[i, 0]);
    chkLB1Selected[i] := true;
    if (myDG.sg.ColWidths[i] = -1) then
      chkLB1Selected[i] := false;
  end;
  //chklb1.DroppedDown:=true;
end;

procedure TForm5.chkLB1Select(Sender: TObject);
var
  i: Integer;
  Sel: string;
begin
  mmon := true;
  Sel := EmptyStr;
  chkLB1Selected[TComboBox(Sender).itemindex] := not chkLB1Selected[TComboBox(Sender).itemindex];
  for i := 0 to TComboBox(Sender).items.Count - 1 do
    if chkLB1Selected[i] then
      Sel := Sel + TComboBox(Sender).items[i] + ' ';
  chkLB1.InvalIdate;
  chkLB1.DroppedDown := true;
  mmon := false;
end;

procedure TForm5.chkLB1Click(Sender: TObject);
begin
  //
  mmc := mmc;
end;

procedure TForm5.chkLB1DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  setlength(chkLB1Selected, TComboBox(Control).items.Count);
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

    TextOut(Rect.left + 15, Rect.Top, TComboBox(Control).items[Index]);
  end;
end;

procedure TForm5.init(DG: TDynGrid);
var
  i: Integer;
begin
  //
  showmessage('init:' + DG.source);
  i := DG.sg.test;
end;

procedure TForm5.takeit;
var
  i: Integer;

begin
  // übernehmen
  for i := 0 to myDG.sg.colcount - 1 do
  begin
    if (chkLB1Selected[i] = true) then
    begin
      if (myDG.sg.ColWidths[i] = -1) then
        myDG.sg.ColWidths[i] := 100
      else
        // an bleibt an
      ;

    end
    else
    begin
      if (myDG.sg.ColWidths[i] = -1) then
      else
        myDG.sg.ColWidths[i] := -1;
    end;
  end;
end;

procedure TForm5.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  Form5.Repaint;
  Form5.Refresh;
  Button2Click(nil);

end;

procedure TForm5.Timer2Timer(Sender: TObject);
begin
timer2.Enabled:=false;
chklb1.DroppedDown:=true;

end;

end.
