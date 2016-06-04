object fSQLID: TfSQLID
  Left = 0
  Top = 0
  Caption = 'ACTIVE SQL_ID'
  ClientHeight = 608
  ClientWidth = 1126
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 568
    Width = 1126
    Height = 40
    Align = alBottom
    TabOrder = 0
    object btnGetData: TButton
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Caption = 'btnGetData'
      TabOrder = 0
      OnClick = btnGetDataClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 361
    Height = 568
    Align = alLeft
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 359
      Height = 566
      Align = alClient
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'DT'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SCHEMANAME'
          Width = 86
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CNT_SES'
          Width = 38
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SQL_ID'
          Visible = True
        end>
    end
  end
  object Panel3: TPanel
    Left = 361
    Top = 0
    Width = 765
    Height = 568
    Align = alClient
    TabOrder = 2
    object DBMemo1: TDBMemo
      Left = 1
      Top = 1
      Width = 763
      Height = 566
      Align = alClient
      DataField = 'SQL_FULLTEXT'
      DataSource = DataSource1
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 584
    Top = 40
  end
  object ADOQuery1: TADOQuery
    Active = True
    Connection = fMain.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select t.*, s.sql_fulltext'
      'from ('
      '  select t.dt, t.sql_id, t.schemaname, t.cnt_ses'
      '  from NT_RDWH_SESSION_GROUP_HIST t'
      '  left join ('
      '     select distinct dt, sql_id --,sid,serial# '
      '     from u1.T_RDWH_PX_SESSION_HIST'
      '  ) px on px.dt = t.dt and px.sql_id = t.sql_id'
      '  --where t.username is null'
      
        '  where t.dt = (select max(dt)from u1.NT_RDWH_SESSION_GROUP_HIST' +
        ') '
      '        and t.sql_id is not null '
      '        and t.status = '#39'ACTIVE'#39
      '        and t.schemaname is not null'
      '  group by t.dt, t.sql_id, t.schemaname,  t.cnt_ses'
      ') t'
      'left join u1.t_Rdwh_Sqlarea_x_Sec s on s.sql_id = t.sql_id'
      'order by t.cnt_ses desc')
    Left = 585
    Top = 120
  end
end
