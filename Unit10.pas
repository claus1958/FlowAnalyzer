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
  ListBox1.Items.Add('Date End of:' + FormatDateTime('dd/mm/yy', ps.z1));
  ListBox1.Items.Add('Volume:' + FormatFloat(',#0.00', ps.volume1 / 100));
  ListBox1.Items.Add('Actions:' + inttostr(ps.ct1)+' nf:'+inttostr(ps.ct1nix));

  ListBox1.Items.Add('Profit EURO:' + FormatFloat(',#0.00', ps.Profit1[1]));
  ListBox1.Items.Add('Profit USD:' + FormatFloat(',#0.00', ps.Profit1[2]));
  ListBox1.Items.Add('Profit SFR:' + FormatFloat(',#0.00', ps.Profit1[3]));
  ListBox1.Items.Add('Profit GBP:' + FormatFloat(',#0.00', ps.Profit1[4]));
  ListBox1.Items.Add('Swap EUR:' + FormatFloat(',#0.00', ps.Swap1));

  ListBox1.Items.Add('');
  ListBox1.Items.Add('Realized from:'+ FormatDateTime('dd/mm/yy', ps.z1+1)+' to '+ FormatDateTime('dd/mm/yy', ps.z2));
  ListBox1.Items.Add('Volume:' + FormatFloat(',#0.00', ps.volume / 100));
  ListBox1.Items.Add('Actions:' + inttostr(ps.ct));

  ListBox1.Items.Add('Profit EURO:' + FormatFloat(',#0.00', ps.Profit[1]));
  ListBox1.Items.Add('Profit USD:' + FormatFloat(',#0.00', ps.Profit[2]));
  ListBox1.Items.Add('Profit SFR:' + FormatFloat(',#0.00', ps.Profit[3]));
  ListBox1.Items.Add('Profit GBP:' + FormatFloat(',#0.00', ps.Profit[4]));
  ListBox1.Items.Add('Swap EUR:' + FormatFloat(',#0.00', ps.Swap));

  ListBox1.Items.Add('');
  ListBox1.Items.Add('Open Actions Time 2');
  ListBox1.Items.Add('Date End of:' + FormatDateTime('dd/mm/yy', ps.z2 ));
  ListBox1.Items.Add('Volume:' + FormatFloat(',#0.00', ps.volume2 / 100));
  ListBox1.Items.Add('Actions:' + inttostr(ps.ct2)+' nf:'+inttostr(ps.ct2nix));

  ListBox1.Items.Add('Profit EURO:' + FormatFloat(',#0.00', ps.Profit2[1]));
  ListBox1.Items.Add('Profit USD:' + FormatFloat(',#0.00', ps.Profit2[2]));
  ListBox1.Items.Add('Profit SFR:' + FormatFloat(',#0.00', ps.Profit2[3]));
  ListBox1.Items.Add('Profit GBP:' + FormatFloat(',#0.00', ps.Profit2[4]));
  ListBox1.Items.Add('Swap EUR:' + FormatFloat(',#0.00', ps.Swap2));

  ListBox1.Items.Add('');
  ListBox1.Items.Add('Profit Diff EURO:' + FormatFloat(',#0.00', ps.Profit2[1]-ps.Profit1[1]+ps.Profit[1]));
  ListBox1.Items.Add('Profit Diff USD:' + FormatFloat(',#0.00', ps.Profit2[2]-ps.Profit1[2]+ps.Profit[2]));
  ListBox1.Items.Add('Profit Diff SFR:' + FormatFloat(',#0.00', ps.Profit2[3]-ps.Profit1[3]+ps.Profit[3]));
  ListBox1.Items.Add('Profit Diff GBP:' + FormatFloat(',#0.00', ps.Profit2[4]-ps.Profit1[4]+ps.Profit[4]));
  ListBox1.Items.Add('Swap Diff EUR:'   + FormatFloat(',#0.00', ps.swap2-ps.swap1+ps.swap));

end;

end.
