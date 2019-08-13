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
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FDialog2: TDialog2;

implementation

{$R *.dfm}

procedure TDialog2.Button1Click(Sender: TObject);
begin
  FDialog2.Close;

end;

procedure TDialog2.FormCreate(Sender: TObject);
var
  i: integer;
begin
end;

procedure TDialog2.Timer1Timer(Sender: TObject);
begin
  timer1.Enabled:=false;
  FDialog2.Repaint;
  FDialog2.Refresh;
  //button2click(nil);

end;

end.
