program prj25;

uses
  Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untGrid in 'untGrid.pas' {frmGrid};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
