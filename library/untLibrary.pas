unit untLibrary;

interface

type

 TAluno =class
  private
    FNome: string;
    FNota: Extended;
    procedure SetNome(const Value: string);
    procedure SetNota(const Value: Extended);
  public
    property Nome : string read FNome write SetNome;
    property Nota: Extended read FNota write SetNota;
 end;

 
const
 STR_EMPTY ='';
 NUM_EMPTY =-2222;

 
implementation


{ TAluno }
procedure TAluno.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TAluno.SetNota(const Value: Extended);
begin
  FNota := Value;
end;

end.
