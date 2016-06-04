unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.Win.ADODB, Vcl.StdCtrls, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart, Vcl.DBCtrls,DateUtils;
const count_tick = 3600;
      tick_sec = 4;
type
  TfMain = class(TForm)
    ADOConnection1: TADOConnection;
    ADO_PX_USE: TADOQuery;
    ds_ado_px_use: TDataSource;
    Timer1: TTimer;
    Chart1: TChart;
    Panel1: TPanel;
    btnOnMon: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    Label2: TLabel;
    Label3: TLabel;
    btnGetUserUsePX: TButton;
    ListBox1: TListBox;
    ADO_CPU_UTILIZ: TADOQuery;
    Timer2: TTimer;
    Chart2: TChart;
    Label5: TLabel;
    Label6: TLabel;
    DBText4: TDBText;
    ds_ADO_CPU_UTILIZ: TDataSource;
    DBText5: TDBText;
    Series2: TLineSeries;
    Series1: TLineSeries;
    btnDetail: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure btnOnMonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGetUserUsePXClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure btnDetailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    a: array [1..count_tick] of integer;
    b: array [1..count_tick] of integer;
  end;
  TMyThread = class(TThread) 
  private
    { Private declarations }
  protected
      procedure Execute; override;
  end;
var
  fMain: TfMain;
  MyThread: TMyThread;

implementation

{$R *.dfm}

uses uSQLID;
procedure TMyThread.Execute;
var
   ADOQuery: TADOQuery;
begin
   fMain.ListBox1.Items.Clear;
   fMain.ListBox1.Items.Add('Wait...');
   ADOQuery:= TADOQuery.Create(nil);
   ADOQuery.ConnectionString:='Provider=OraOLEDB.Oracle.1;Password=m??????;Persist Security Info=True;User ID=??????;Data Source=rdwh;Extended Properties=""';
   ADOQuery.SQL.Clear;
   ADOQuery.SQL.Add('select t.osuser, count(1) as cnt ');
   ADOQuery.SQL.Add('from v$session t ');
   ADOQuery.SQL.Add('join v$px_session px on px.SID = t.SID and px.SERIAL# = t.SERIAL# ');
   ADOQuery.SQL.Add('group by t.osuser ');
   ADOQuery.SQL.Add('order by count(1) desc ');
   ADOQuery.Active:=True;
   fMain.ListBox1.Items.Clear;
   while not(ADOQuery.Eof) do  begin
     fMain.ListBox1.Items.Add(ADOQuery.FieldByName('osuser').AsString+' - '+ADOQuery.FieldByName('cnt').AsString);
     ADOQuery.Next;
   end;
   ADOQuery.Free;
end;

procedure TfMain.btnDetailClick(Sender: TObject);
begin
   fSQLID.Showmodal;
end;

procedure TfMain.btnGetUserUsePXClick(Sender: TObject);
begin
  MyThread:=TMyThread.Create(True);
  MyThread.Priority:=tpLower;
  MyThread.Resume;
end;

procedure TfMain.btnOnMonClick(Sender: TObject);
begin
   Timer1.Enabled:= True;
   Timer2.Enabled:= True;
   ADO_CPU_UTILIZ.Close;
   ADO_CPU_UTILIZ.Open;
end;

procedure TfMain.FormShow(Sender: TObject);
var
   i: integer;
begin
   Timer1.Interval:=tick_sec*1000;
   for I := 1 to count_tick do  begin a[i]:=0; b[i]:=0; end;
   btnOnMon.Click;
end;

procedure TfMain.Timer1Timer(Sender: TObject);
var i: integer;
    str: string;
begin
  try
    ADO_PX_USE.Close;
    ADO_PX_USE.Open;
    for i := 1 to count_tick-1 do begin
       a[i]:=a[i+1];
       b[i]:=b[i+1];
    end;
    a[count_tick]:=ADO_PX_USE.FieldByName('px_use').AsInteger;
    b[count_tick]:= round(ADO_CPU_UTILIZ.FieldByName('val').AsFloat);

    Series1.Clear;
    Series2.Clear;
    for i:=0 to count_tick-1 do begin
      str:=FormatDateTime('hh:mm:ss', IncSecond(IncSecond(Now,count_tick*tick_sec*-1),(i+1)*tick_sec));
      Series1.AddXY(i, a[i+1], str, clBlue);
      Series2.AddXY(i, b[i+1], str, clBlue);
    end;

  except
    timer1.Enabled:=false;
    btnOnMon.Enabled:=False;
    ShowMessage('An error occurred while retrieving data from the Oracle');
  end;

end;


procedure TfMain.Timer2Timer(Sender: TObject);
var i: integer;
begin
  try
     ADO_CPU_UTILIZ.Close;
     ADO_CPU_UTILIZ.Open;
  except
    timer2.Enabled:=false;
    btnOnMon.Enabled:=False;

  end;

end;

end.
