unit ReportInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TReportInfo = class(TFrame)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure init();
    procedure setValues(s1,s2,s3:string);
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

{ TReportInfo }

procedure TReportInfo.init;
begin
//
label1.Caption:='';
label2.Caption:='';
label3.Caption:='';
end;

procedure TReportInfo.setValues(s1, s2, s3: string);
begin
//  self.init;
  label1.caption:=s1;
  label2.caption:=s2;
  label3.caption:=s3;

end;

end.
