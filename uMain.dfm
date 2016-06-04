object fMain: TfMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 704
  ClientWidth = 1126
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 224
    Top = 41
    Width = 902
    Height = 368
    Legend.Visible = False
    Title.Text.Strings = (
      'Use PX-process')
    BottomAxis.Axis.Width = 0
    DepthAxis.Axis.Width = 0
    DepthTopAxis.Axis.Width = 0
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.Axis.Width = 0
    LeftAxis.Maximum = 866.000000000000000000
    RightAxis.Axis.Width = 0
    TopAxis.Axis.Width = 0
    View3D = False
    TabOrder = 0
    DefaultCanvas = 'TGDIPlusCanvas'
    PrintMargins = (
      15
      32
      15
      32)
    ColorPaletteIndex = 13
    object Series1: TLineSeries
      Selected.Hover.Visible = False
      SeriesColor = 13246208
      Brush.BackColor = clDefault
      LinePen.Color = 10708548
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      TreatNulls = tnIgnore
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 663
    Width = 1126
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btnOnMon: TButton
      Left = 136
      Top = 5
      Width = 129
      Height = 25
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1084#1086#1085#1080#1090#1086#1088
      TabOrder = 0
      Visible = False
      OnClick = btnOnMonClick
    end
    object btnDetail: TButton
      Left = 16
      Top = 5
      Width = 114
      Height = 25
      Caption = 'SQL_ID/Username'
      TabOrder = 1
      OnClick = btnDetailClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1126
    Height = 49
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 18
      Width = 181
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1089#1085#1103#1090#1080#1103' '#1087#1086#1089#1083#1077#1076#1085#1080#1093' '#1087#1086#1082#1072#1079#1072#1085#1080#1081
    end
    object DBText1: TDBText
      Left = 224
      Top = 18
      Width = 121
      Height = 17
      DataField = 'DT'
      DataSource = ds_ado_px_use
    end
    object DBText2: TDBText
      Left = 407
      Top = 18
      Width = 42
      Height = 17
      DataField = 'PX_USE'
      DataSource = ds_ado_px_use
    end
    object DBText3: TDBText
      Left = 523
      Top = 18
      Width = 42
      Height = 17
      DataField = 'PX_NOT_USE'
      DataSource = ds_ado_px_use
    end
    object Label2: TLabel
      Left = 364
      Top = 18
      Width = 37
      Height = 13
      Caption = 'PX-use:'
    end
    object Label3: TLabel
      Left = 455
      Top = 18
      Width = 62
      Height = 13
      Caption = 'PX-available:'
    end
    object Label6: TLabel
      Left = 591
      Top = 18
      Width = 120
      Height = 13
      Caption = 'Host CPU Utilization (%):'
    end
    object DBText4: TDBText
      Left = 717
      Top = 18
      Width = 116
      Height = 17
      DataField = 'DT'
      DataSource = ds_ADO_CPU_UTILIZ
    end
    object DBText5: TDBText
      Left = 854
      Top = 18
      Width = 162
      Height = 17
      DataField = 'VAL'
      DataSource = ds_ADO_CPU_UTILIZ
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 49
    Width = 225
    Height = 614
    Align = alLeft
    TabOrder = 3
    object btnGetUserUsePX: TButton
      Left = 1
      Top = 588
      Width = 223
      Height = 25
      Hint = #1086#1090#1088#1072#1073#1072#1090#1099#1074#1072#1077#1090' '#1086#1082#1086#1083#1086' 40'#1089#1077#1082#1091#1085#1076', '#1090'.'#1095'. '#1078#1084#1080#1090#1077' '#1088#1077#1078#1077
      Align = alBottom
      Caption = #1050#1090#1086' '#1079#1072#1085#1103#1083' '#1087#1072#1088#1072#1083#1077#1083#1083#1100#1085#1099#1077' '#1089#1077#1089#1089#1080#1080'?'
      TabOrder = 0
      OnClick = btnGetUserUsePXClick
    end
    object ListBox1: TListBox
      Left = 1
      Top = 1
      Width = 223
      Height = 587
      Align = alClient
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object Chart2: TChart
    Left = 224
    Top = 408
    Width = 902
    Height = 256
    Legend.Visible = False
    Title.Text.Strings = (
      'Host CPU Utilization (%)')
    BottomAxis.Axis.Width = 0
    DepthAxis.Axis.Width = 0
    DepthTopAxis.Axis.Width = 0
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.Axis.Width = 0
    LeftAxis.Maximum = 102.000000000000000000
    RightAxis.Axis.Width = 0
    TopAxis.Axis.Width = 0
    View3D = False
    TabOrder = 4
    DefaultCanvas = 'TGDIPlusCanvas'
    PrintMargins = (
      15
      36
      15
      36)
    ColorPaletteIndex = 13
    object Label5: TLabel
      Left = 64
      Top = 580
      Width = 31
      Height = 13
      Caption = 'Label4'
    end
    object Series2: TLineSeries
      SeriesColor = 13246208
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=OraOLEDB.Oracle.1;Password=m?????????;Persist Security In' +
      'fo=True;User ID=u???????;Data Source=rdwh'
    LoginPrompt = False
    Provider = 'OraOLEDB.Oracle.1'
    Left = 192
    Top = 176
  end
  object ADO_PX_USE: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select '
      '    sysdate as dt'
      
        '    ,(select t.VALUE from v$px_process_sysstat t where t.STATIST' +
        'IC = '#39'Servers In Use                '#39') as px_use'
      
        '    ,(select t.VALUE from v$px_process_sysstat t where t.STATIST' +
        'IC = '#39'Servers Available             '#39') as px_not_use'
      'from dual')
    Left = 176
    Top = 64
  end
  object ds_ado_px_use: TDataSource
    DataSet = ADO_PX_USE
    Left = 272
    Top = 56
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 8000
    OnTimer = Timer1Timer
    Left = 64
    Top = 144
  end
  object ADO_CPU_UTILIZ: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select '
      '   t.END_TIME as dt,t.value as val'
      '   ,(sysdate - t.END_TIME)*3600*24'
      'from v$sysmetric t '
      'where t.metric_name = '#39'Host CPU Utilization (%)'#39
      '      and (sysdate - t.END_TIME)*3600*24 <18'
      '      and rownum <= 1')
    Left = 192
    Top = 248
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 18000
    OnTimer = Timer2Timer
    Left = 64
    Top = 240
  end
  object ds_ADO_CPU_UTILIZ: TDataSource
    DataSet = ADO_CPU_UTILIZ
    Left = 112
    Top = 352
  end
end
