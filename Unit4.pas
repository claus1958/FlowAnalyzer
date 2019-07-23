unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrame4 = class(TFrame)
    ComboBox1: TComboBox;
    Button1: TButton;
    procedure ComboBox1DrawItem(Control: TWinControl;
     Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure ComboBox1Select(Sender: TObject);
        constructor Create(AOwner: TComponent); override;
    procedure Button1Click(Sender: TObject);

 private
    Selected: array of Boolean;
 public
    test:integer;
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

constructor TFrame4.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  test:=111;
end;


procedure TFrame4.Button1Click(Sender: TObject);
begin
        inc(test);
        button1.Caption:=inttostr(test);
end;

procedure TFrame4.ComboBox1DrawItem(Control: TWinControl;
     Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  SetLength(Selected, TComboBox(Control).Items.Count);
  with TComboBox(Control).Canvas do
  begin
    FillRect(rect);

    Rect.Left := Rect.Left + 1;
    Rect.Right := Rect.Left + 13;
    Rect.Bottom := Rect.Bottom;
    Rect.Top := Rect.Top;

//        if not (odSelected in State) and (Selected[Index]) then
//      DrawFrameControl(Handle, Rect, DFC_BUTTON,
//        DFCS_BUTTONCHECK or DFCS_CHECKED )
//    else if (odFocused in State) and (Selected[Index]) then
//      DrawFrameControl(Handle, Rect, DFC_BUTTON,
//        DFCS_BUTTONCHECK or DFCS_CHECKED )
//    else if (Selected[Index]) then
//      DrawFrameControl(Handle, Rect, DFC_BUTTON,
//        DFCS_BUTTONCHECK or DFCS_CHECKED )
//    else if not (Selected[Index]) then
//      DrawFrameControl(Handle, Rect, DFC_BUTTON, DFCS_BUTTONCHECK );
//
//

    if not (odSelected in State) and (Selected[Index]) then
      DrawFrameControl(Handle, Rect, DFC_BUTTON,
        DFCS_BUTTONCHECK or DFCS_CHECKED or DFCS_FLAT)
    else if (odFocused in State) and (Selected[Index]) then
      DrawFrameControl(Handle, Rect, DFC_BUTTON,
        DFCS_BUTTONCHECK or DFCS_CHECKED or DFCS_FLAT)
    else if (Selected[Index]) then
      DrawFrameControl(Handle, Rect, DFC_BUTTON,
        DFCS_BUTTONCHECK or DFCS_CHECKED or DFCS_FLAT)
    else if not (Selected[Index]) then
      DrawFrameControl(Handle, Rect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_FLAT);

    TextOut(Rect.Left + 15, Rect.Top, TComboBox(Control).Items[Index]);
  end;
end;


procedure TFrame4.ComboBox1Select(Sender: TObject);
var
  i: Integer;
  Sel: string;
begin
  Sel := EmptyStr;
  Selected[TComboBox(Sender).ItemIndex] := not Selected[TComboBox(Sender).ItemIndex];
  for i := 0 to TComboBox(Sender).Items.Count - 1 do
    if Selected[i] then
      Sel := Sel + TComboBox(Sender).Items[i] + ' ';
//  ShowMessage(Sel);  //Just for test...
  combobox1.Invalidate;
end;


end.
