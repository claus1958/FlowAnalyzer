unit Dialog1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Flowanalyzer, Vcl.ExtCtrls;

type
  TForm5 = class(TForm)
    Button1: TButton;
    btnLoadNow: TButton;
    Label1: TLabel;
    Timer1: TTimer;
    lbLoadInfo: TListBox;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}
const IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;
{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

procedure TForm5.Button1Click(Sender: TObject);
begin
  Form5.Close;

end;

procedure TForm5.Button2Click(Sender: TObject);
begin

//  form2.trackbar1.position:=200;
//  form5.Repaint;
////dialog1.Form5.ShowModal;
//  form2.btnloaddataclick(nil);
//  form5.Repaint;
//
//  form2.trackbar1.position:=255;
//  form5.Repaint;

end;

procedure TForm5.FormCreate(Sender: TObject);
var
  i: integer;
begin
end;

procedure TForm5.Timer1Timer(Sender: TObject);
begin
  timer1.Enabled:=false;
  form5.Repaint;
  form5.Refresh;
  button2click(nil);

end;

end.
