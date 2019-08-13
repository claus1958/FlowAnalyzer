unit GroupControl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TGroupControl = class(TFrame)
    cbTopic: TComboBox;
    chkActive: TCheckBox;
    Label1: TLabel;
    procedure chkActiveClick(Sender: TObject);
       constructor Create(AOwner: TComponent); override;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

procedure TGroupControl.chkActiveClick(Sender: TObject);
begin
  if chkActive.Checked = false then
  begin
    cbTopic.Visible := false;
  end
  else
  begin
    cbTopic.Visible := true;
  end;
end;

constructor TGroupControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  chkActiveClick(nil);
end;

end.
