unit EvalInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,FTCommons, Vcl.ExtCtrls;

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
    Label18: TLabel;
    Label16: TLabel;
    Label17: TLabel;
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
label3.Caption:='Off Gew.Differenz:';
label5.Caption:='Geschl. Gewinn:';
label7.Caption:='Gesamtgewinn:';
label9.Caption:='Handelsvolumen:';
label11.Caption:='SWAP-Umsatz:';
label13.Caption:='Einzel-Trades:';
label15.Caption:='Kunden aktiv:';
label17.Caption:='meistgehandelt:';
label2.Caption:='';
label4.Caption:='';
label6.Caption:='';
label8.Caption:='';
label10.Caption:='';
label12.Caption:='';
label14.Caption:='';
label16.Caption:='';
label18.Caption:='';


end;

procedure TFrame11.setValues(e: EvaluationResult);
begin
self.init;
label2.Caption:=formatFloat('#,0.00',e.profit2[1]);
label4.Caption:=FormatFloat('#,0.00',e.profit2[1]-e.profit1[1]);
label6.Caption:=FormatFloat('#,0.00',e.profit[1]);
label8.Caption:=FormatFloat('#,0.00',e.profit2[1]-e.profit1[1]+e.profit[1]);
label10.Caption:=FormatFloat('#,0.00',e.volume/100);
label12.Caption:=FormatFloat('#,0.00',e.swap);
label14.Caption:=FormatFloat('#,0.',e.ct);
label16.Caption:=FormatFloat('#,0.',e.usersCt);
label18.Caption:=e.mostSymbols;
end;

end.
