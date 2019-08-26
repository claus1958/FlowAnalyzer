unit Dialog1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, XFlowanalyzer, Vcl.ExtCtrls,FTCommons,UDynGrid;

type
  TForm5 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure init(DG: TDynGrid);
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
i:=0;
end;

procedure TForm5.init(DG: TDynGrid);
var i:integer;
begin
//
  showmessage('init:'+DG.source);
  i:=DG.SG.test;
end;

procedure TForm5.Timer1Timer(Sender: TObject);
begin
  timer1.Enabled:=false;
  form5.Repaint;
  form5.Refresh;
  button2click(nil);

end;

end.
