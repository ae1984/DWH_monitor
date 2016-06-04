unit uSQLID;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls;

type
  TfSQLID = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btnGetData: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ADOQuery1: TADOQuery;
    DBMemo1: TDBMemo;
    procedure btnGetDataClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSQLID: TfSQLID;

implementation

{$R *.dfm}

procedure TfSQLID.btnGetDataClick(Sender: TObject);
begin
   ADOQuery1.Close;
   ADOQuery1.Open;
end;

end.
