unit filterElement;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrame4 = class(TFrame)
    cbAndOr: TComboBox;
    cbTopic: TComboBox;
    cbOperator: TComboBox;
    edValue: TEdit;
    cbValues: TComboBox;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

end.
