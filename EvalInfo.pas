unit EvalInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,FTCommons;

type
  TFrame11 = class(TFrame)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    procedure init();
    procedure setValues(e:EvaluationResult);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

procedure TFrame11.init;
begin
label1.Caption:='Offener Gewinn:';
label3.Caption:='Geschlossener Gewinn:';
label5.Caption:='Gesamtgewinn:';
label7.Caption:='Handelsvolumen:';
label9.Caption:='SWAP-Umsatz:';
label11.Caption:='Einzel-Trades:';
label13.Caption:='Kunden aktiv:';
label15.Caption:='meistgehandelt:';

end;

procedure TFrame11.setValues(e: EvaluationResult);
begin
self.init;
label2.Caption:=floattostr(e.profit2[1]);
label4.Caption:=floattostr(e.profit[1]);
label6.Caption:=floattostr(e.profit2[1]+e.profit[1]);
label8.Caption:=floattostr(e.volume);
label10.Caption:=floattostr(e.swap);
label12.Caption:=floattostr(e.ct);
label14.Caption:=floattostr(e.usersCt);
label16.Caption:=e.mostSymbols;
end;

end.
