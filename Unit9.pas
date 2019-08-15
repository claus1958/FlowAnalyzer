unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm9 = class(TForm)
    Button1: TButton;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form9: TForm9;

implementation

{$R *.dfm}
const IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;
{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

end.
