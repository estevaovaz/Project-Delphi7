unit untPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus;

type
  TfrmPrincipal = class(TForm)
    mmenu: TMainMenu;
    mOpcoes: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Grid1: TMenuItem;
    Ajuda1: TMenuItem;
    Sobre1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure Grid1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses untGrid;

{$R *.dfm}

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.Grid1Click(Sender: TObject);
var
  frmGrid: TfrmGrid;
begin
  frmGrid := TfrmGrid.Create(Self);
  try
    frmGrid.ShowModal;
  finally
    frmGrid.Free;
  end;
end;

end.
