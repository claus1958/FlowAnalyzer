unit Dialog2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Flowanalyzer, Vcl.ExtCtrls;

type
  TDialog2 = class(TForm)
    Button1: TButton;
    btnLoadNow: TButton;
    Timer1: TTimer;
    lbLoadInfo: TListBox;
    Memo1: TMemo;
    lblInfo: TLabel;
    Timer2: TTimer;
    lblInfo2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure info(s:string);
    procedure info2(s:string);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FDialog2: TDialog2;

implementation

{$R *.dfm}
const IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;
{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}
procedure TDialog2.Button1Click(Sender: TObject);
begin
  FDialog2.Close;

end;

procedure TDialog2.FormCreate(Sender: TObject);
var
  i: integer;
begin
    SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0,SWP_NoMove or SWP_NoSize);
end;

procedure TDialog2.info(s: string);
begin
lblinfo.caption:=s;
lblinfo.Refresh;
if (lblinfo2.Caption='') then
  lblinfo.Top:=28
else
  lblinfo.Top:=16;
end;

procedure TDialog2.info2(s: string);
begin
//
lblinfo2.caption:=s;
lblinfo2.Refresh;
end;

procedure TDialog2.Timer1Timer(Sender: TObject);
begin
  timer1.Enabled:=false;
  FDialog2.Repaint;
  FDialog2.Refresh;
  //button2click(nil);

end;

procedure TDialog2.Timer2Timer(Sender: TObject);
begin
timer2.enabled:=false;
  FDialog2.Top:=Form2.Top+Form2.Height-FDialog2.Height-4;
  FDialog2.Left:=Form2.left+Form2.width-FDialog2.width-4;
end;

end.
