unit Unit10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FTCommons;

type
  TForm10 = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure zeigen();
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

uses XFlowAnalyzer;

procedure TForm10.Button1Click(Sender: TObject);
begin
  zeigen
end;

procedure TForm10.zeigen();
var
  ps: ProfitSwapZ12;
  i: integer;
begin
  ps := FTCommons.PSFilteredActions;
  ListBox1.Items.Clear;

  ListBox1.Items.Add('Open Actions Time 1');
  ListBox1.Items.Add('Date after:' + FormatDateTime('dd/mm/yy', ps.z1));
  ListBox1.Items.Add('Volume:' + FormatFloat(',#0.00', ps.volume1 / 100));

  ListBox1.Items.Add('EURO:' + FormatFloat(',#0.00', ps.Profit1[1]));
  ListBox1.Items.Add('USD:' + FormatFloat(',#0.00', ps.Profit1[2]));
  ListBox1.Items.Add('SFR:' + FormatFloat(',#0.00', ps.Profit1[3]));
  ListBox1.Items.Add('GBP:' + FormatFloat(',#0.00', ps.Profit1[4]));
  ListBox1.Items.Add('Swap EUR:' + FormatFloat(',#0.00', ps.Swap1));

  ListBox1.Items.Add('');
  ListBox1.Items.Add('Realized');
  ListBox1.Items.Add('Volume:' + FormatFloat(',#0.00', ps.volume / 100));
  ListBox1.Items.Add('EURO:' + FormatFloat(',#0.00', ps.Profit[1]));
  ListBox1.Items.Add('USD:' + FormatFloat(',#0.00', ps.Profit[2]));
  ListBox1.Items.Add('SFR:' + FormatFloat(',#0.00', ps.Profit[3]));
  ListBox1.Items.Add('GBP:' + FormatFloat(',#0.00', ps.Profit[4]));
  ListBox1.Items.Add('Swap EUR:' + FormatFloat(',#0.00', ps.Swap));

  ListBox1.Items.Add('');
  ListBox1.Items.Add('Open Actions Time 2');
  ListBox1.Items.Add('Date before:' + FormatDateTime('dd/mm/yy', ps.z2 + 1));
  ListBox1.Items.Add('Volume:' + FormatFloat(',#0.00', ps.volume2 / 100));
  ListBox1.Items.Add('EURO:' + FormatFloat(',#0.00', ps.Profit2[1]));
  ListBox1.Items.Add('USD:' + FormatFloat(',#0.00', ps.Profit2[2]));
  ListBox1.Items.Add('SFR:' + FormatFloat(',#0.00', ps.Profit2[3]));
  ListBox1.Items.Add('GBP:' + FormatFloat(',#0.00', ps.Profit2[4]));
  ListBox1.Items.Add('Swap EUR:' + FormatFloat(',#0.00', ps.Swap2));

end;

end.
