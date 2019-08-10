unit FTTypes;



interface

type
  byteArray = array of byte;
  byteArray2 = array of byteArray;
  byteArray3 = array of byteArray2;
  // b3[x][y][z]
  TFunctionStringString = function(const value : string) : string;

implementation

end.
