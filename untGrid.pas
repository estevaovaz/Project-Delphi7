unit untGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math, Grids, StdCtrls, untLibrary;

type
  TfrmGrid = class(TForm)
    sgridAlunos: TStringGrid;
    btnOrdenarPorNome: TButton;
    sgridResultado: TStringGrid;
    btnOrdernarNota: TButton;
    chkCrescente: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure sgridAlunosKeyPress(Sender: TObject; var Key: Char);
    procedure btnOrdenarPorNomeClick(Sender: TObject);
  private
    { Private declarations }
    FNome : string;
    FIdade: Integer;
  protected
    procedure CarregarLista(Alist : TList);
    procedure CarregarResultado(Alist : TList; AVBOrdemCrescente: Boolean =True);
  public
    { Public declarations }
    procedure IniciaTela;
    procedure setupGrid;
  end;

function ClassificarPorNome(item1, item2: TAluno): integer;
function ClassificarPorNota(item1: Pointer; item2: Pointer): integer;

const
  COL_ALUNO_NOME =0;
  COL_ALUNO_NOTA =1;



{variavel global}
var iGlobal : Integer;

implementation

//uses untLibrary;

{escopo da unidade}
var iEscopoUnidade : Integer;

function ClassificarPorNome(item1, item2: TAluno): integer;
begin
  Result := CompareText(item1.Nome, item2.Nome);
end;

function ClassificarPorNota(item1: Pointer; item2: Pointer): integer;
begin
  Result := CompareValue(TAluno(item1).Nota, TAluno(item2).Nota);
end;

{$R *.dfm}

procedure TfrmGrid.FormCreate(Sender: TObject);
begin
  IniciaTela;
end;

procedure TfrmGrid.IniciaTela;
begin
  FNome := STR_EMPTY;
  FIdade:= NUM_EMPTY;

  setupGrid;
end;

procedure TfrmGrid.setupGrid;
begin   
 sgridAlunos.ColCount  := 2;
 sgridAlunos.RowCount  := 2;
 sgridAlunos.FixedCols := 0;
 sgridAlunos.FixedRows := 1;
{  TGridOption = (goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
    goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goRowMoving,
    goColMoving, goEditing, goTabs, goRowSelect,
    goAlwaysShowEditor, goThumbTracking); }

 sgridAlunos.Options := [goFixedVertLine
                        ,goFixedHorzLine
                        ,goVertLine
                        ,goHorzLine
                        ,goRangeSelect  //opçoes defaut
                        ,goEditing];

  {Nome do aluno}
 sgridAlunos.Cells[COL_ALUNO_NOME, 0]  := 'Nome';
 sgridAlunos.ColWidths[COL_ALUNO_NOME] := 150;

 sgridAlunos.Cells[COL_ALUNO_NOTA, 0]  := 'Nota';
 sgridAlunos.ColWidths[COL_ALUNO_NOTA] := 40;

end;

procedure TfrmGrid.sgridAlunosKeyPress(Sender: TObject; var Key: Char);
var
  vGrid : TStringGrid;
begin
  {testando o tipo da classe}
 if   (Sender is TStringGrid)
   and(Key =#13)
  then begin
    {type casting de classe}
    vGrid := TStringGrid(Sender);

    if vGrid.Col = COL_ALUNO_NOME
     then vGrid.Col := COL_ALUNO_NOTA
     else begin
       vGrid.RowCount := vGrid.RowCount +1;
       vGrid.Row := vGrid.RowCount -1;
       vGrid.Col := COL_ALUNO_NOME;
     end;
  end;
end;

procedure TfrmGrid.btnOrdenarPorNomeClick(Sender: TObject);
var
  Aluno_list : TList;

begin
  Aluno_list := TList.Create;
  try
    CarregarLista(Aluno_list);

    if TButton(Sender).Name ='btnOrdenarPorNome'
     then Aluno_list.Sort(@ClassificarPorNome)
     else Aluno_list.Sort(@ClassificarPorNota);

    //exibir grid resultado com lista ordenada
    CarregarResultado(Aluno_list,  chkCrescente.Checked);
  finally
    //destruir cada aluno..
    Aluno_list.Free;
  end;
end;


procedure TfrmGrid.CarregarLista(Alist: TList);
var
  i: Integer;
  vAluno : TAluno;
begin

  for i :=1 to sgridAlunos.RowCount -1  do
  begin
    //ler a linha da grid.
    //criar popular o objeto aluno
    if (sgridAlunos.Cells[COL_ALUNO_NOME, i] + sgridAlunos.Cells[COL_ALUNO_NOTA, i] <>'')
     then begin
      {instanciando novo aluno}
      vAluno := TAluno.Create;

      if sgridAlunos.Cells[COL_ALUNO_NOME, i] = ''
       then vAluno.Nome := '**'
       else vAluno.Nome := sgridAlunos.Cells[COL_ALUNO_NOME, i];

      if sgridAlunos.Cells[COL_ALUNO_NOTA, i] = ''
       then vAluno.Nota := 0
       else vAluno.Nota := StrToFloat(sgridAlunos.Cells[COL_ALUNO_NOTA, i]);

     //adicionar objeto aluno a lista.
      Alist.Add(vAluno);
     end  
  end;
end;

procedure TfrmGrid.CarregarResultado(Alist: TList; AVBOrdemCrescente: Boolean =True);
var
  i, j : Integer;

  procedure CarregaLinha(ALinha: integer;  Aaluno: TAluno);
  begin
    sgridResultado.Cells[COL_ALUNO_NOME, ALinha] := Aaluno.Nome;
    sgridResultado.Cells[COL_ALUNO_NOTA, ALinha] := FloatToStr(Aaluno.Nota);
  end;

begin
  sgridResultado.ColCount  := sgridAlunos.ColCount;
  sgridResultado.RowCount  := Alist.Count +1;
  sgridResultado.FixedCols := sgridAlunos.FixedCols;
  sgridResultado.FixedRows := sgridAlunos.FixedRows;
  sgridResultado.Options   := sgridAlunos.Options;

  if AVBOrdemCrescente
   then begin
    for i :=0 to pred(Alist.Count)  do
      CarregaLinha(i+1,TAluno(Alist[i]));
   end
   else begin
    j:=1;
    
    for i := pred(Alist.Count) downto 0  do
     begin
       CarregaLinha(j,TAluno(Alist[i]));
       Inc(j);
     end; 
   end;
end;

end.


