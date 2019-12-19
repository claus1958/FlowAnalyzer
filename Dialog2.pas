unit Dialog2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, XFlowanalyzer, Vcl.ExtCtrls;

type
  TDialog2 = class(TForm)
    Button1: TButton;
    btnLoadNow: TButton;
    Timer1: TTimer;
    lblInfo: TLabel;
    Timer2: TTimer;
    lblInfo2: TLabel;
    btnFinishUpdate: TButton;
    lbLoadInfo: TListBox;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure info(s: string);
    procedure info2(s: string);
    procedure Timer2Timer(Sender: TObject);
    procedure askFinish();
    procedure btnFinishUpdateClick(Sender: TObject);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FDialog2: TDialog2;

implementation

{$R *.dfm}

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;
{$SETPEFLAGS IMAGE_FILE_LARGE_ADDRESS_AWARE}

procedure TDialog2.askFinish;
begin
  btnFinishUpdate.Visible := true;
  lblInfo2.Visible := false; // will ab jetzt die ständigen Tips nicht mehr sehen
  //
end;

procedure TDialog2.Button1Click(Sender: TObject);
begin
  FDialog2.Close;

end;

procedure TDialog2.btnFinishUpdateClick(Sender: TObject);
begin
  btnFinishUpdate.Visible := false;
  form2.finishUpdate();

end;

procedure TDialog2.FormCreate(Sender: TObject);
var
  i: integer;
begin
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NoMove or SWP_NoSize);

end;

procedure TDialog2.info(s: string);
begin




  lblInfo.caption := s;
  lblInfo.Refresh;
  if (lblInfo2.caption = '') then
    lblInfo.Top := 28
  else
    lblInfo.Top := 16;

  if(s='') then
    self.visible:=false
  else
    self.visible:=true;
end;

procedure TDialog2.info2(s: string);
begin
  //
  lblInfo2.caption := s;
  lblInfo2.Refresh;
end;

procedure TDialog2.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  FDialog2.Repaint;
  FDialog2.Refresh;
  // button2click(nil);

end;

procedure TDialog2.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := false;
  FDialog2.Top := form2.Top + form2.Height - FDialog2.Height - 4;
  FDialog2.Left := form2.Left + form2.width - FDialog2.width - 4-40; //etwas nach links wegen Überdeckung der Scrollbars
end;

end.
