create or replace procedure u1.NPRC_MONITORING is
   v_dt date;
begin
  v_dt := sysdate;

  insert into T_RDWH_PX_SESSION_HIST
  select v_dt as dt,
         t.*,
         s.SQL_ID
  from V$PX_SESSION t
  left join v$session s on s.SID = t.SID and
                           s.SERIAL# = t.SERIAL#;

  insert into T_RDWH_PX_PROCESS_SYSSTAT_HIST
  select v_dt as DT, t.* from V$PX_PROCESS_SYSSTAT t;

  /*insert into t_Rdwh_license_hist
  select v_dt as DT,t.* from v$license t;*/

  insert into T_RDWH_RESOURCE_LIMIT_HIST
  select v_dt as DT , t.* from V$RESOURCE_LIMIT t;

  insert into T_RDWH_top_heavy_sql_hist
  select distinct
     v_dt as DT
     /* trunc(t.PHYSICAL_READ_BYTES/1024/1024) as PHYSICAL_READ_MBYTES
     ,trunc(t.PHYSICAL_WRITE_BYTES/1024/1024) as PHYSICAL_WRITE_MBYTES
     ,trunc(t.CPU_TIME/1000000/60) as CPU_TIME_MM
     ,trunc(t.ELAPSED_TIME/1000000/60) as ELAPSED_TIME_MM*/
     ,t.PHYSICAL_READ_BYTES
     ,t.PHYSICAL_WRITE_BYTES
     ,t.CPU_TIME
     ,t.ELAPSED_TIME
     ,t.STATUS
     ,t.SQL_TEXT
     --,t.SQL_FULLTEXT
     ,t.SQL_ID
     ,t.LAST_LOAD_TIME
     ,t.action
     ,t.module
     ,t.PARSING_SCHEMA_NAME
  from
  (select
    a.STATUS
    ,t.*
  from V$SQLAREA t --предоставляет статистику по заявлениям SQL, которые находятся в памяти, анализируется, и готов к выполнению.
  join V$session a on a.sql_hash_value = t.HASH_VALUE
  where t.CPU_TIME >=1000000*60*30 or t.PHYSICAL_READ_BYTES >=1024*1024*1024  or t.PHYSICAL_WRITE_BYTES >=1024*1024*1024 or t.ELAPSED_TIME >=1000000*60*30
  ) t;

  insert into T_RDWH_session_longops_HIST
  select
    v_dt as DT
    ,t.SID --Session identifier
    ,t.SERIAL# --Session serial number
    ,t.SQL_ID --SQL-идентификатор оператора SQL, связанный с операцией
    ,a.SQL_ID as SQL_ID_ses
    ,t.SQL_EXEC_START --Время, когда выполнение SQL началась; NULL, если SQL_ID является NULL
    ,t.START_TIME --Время начала работы
    ,t.LAST_UPDATE_TIME --Время, когда статистика последнего обновления
    ,t.ELAPSED_SECONDS --Число истекших секунд с момента начала операции
    ,t.USERNAME --Идентификатор пользователя пользователя, выполняющего операцию
    ,t.TARGET --oбъект, на котором операция выполняется
    ,t.OPNAME --Краткое описание работы
    ,t.TIME_REMAINING --Расчетный показатель (в секундах) времени, оставшееся для завершения операции
    ,t.SQL_EXEC_ID
  from  v$session_longops t
  left join v$session a on a.SID = t.SID and a.SERIAL# = t.SERIAL#;

  insert into T_RDWH_SQL_MONITOR_HIST
  select
           v_dt as dt
           ,t.SQL_ID
           ,t.SQL_EXEC_START
           ,t.SQL_EXEC_ID
  from SYS.V_$SQL_MONITOR t
  left join T_RDWH_SQL_MONITOR_HIST a on a.sql_id = t.SQL_ID and a.sql_exec_start = t.SQL_EXEC_START and a.sql_exec_id = t.SQL_EXEC_ID
  where a.sql_id is null
  group by
        t.SQL_ID
       ,t.SQL_EXEC_START
       ,t.SQL_EXEC_ID;

  insert into t_Rdwh_Sqlarea_x_Sec
  select
     v_dt as dt
     ,t.HASH_VALUE
     ,t.SQL_ID
     ,t.SQL_TEXT
     ,t.SQL_FULLTEXT
     ,t.action
     ,t.module
     ,t.PARSING_SCHEMA_NAME
  from SYS.V_$SQLAREA t
  left join t_Rdwh_Sqlarea_x_Sec a on a.hash_value = t.HASH_VALUE --a.sql_id = t.SQL_ID
  where     t.SQL_TEXT not like 'insert into t_luna%'
        and t.SQL_TEXT not like 'insert into u1.t_luna%'
        and t.SQL_TEXT not like 'insert into dhk_user.%'
        and t.SQL_TEXT not like 'update DHK_USER.PORTF_DHK%'
        and a.sql_id is null
        and t.PARSING_SCHEMA_NAME not in ('SYS','SYSTEM')
        and t.SQL_TEXT not like 'SELECT /* DS_SVC */ /*+%'
  ;

  insert into NT_RDWH_sysmetric_summary_hist
  select v_dt as dt, t.*
  from v$sysmetric_summary t;
  --where t.metric_name like '%CPU%' or t.metric_name like '%IO%' ;

  insert into NT_RDWH_sysmetric_hist
  select
    v_dt as dt
    ,t.*
  from v$sysmetric t;
  --where metric_name like '%CPU%' or metric_name like '%IO%' ;
  
  insert into NT_RDWH_PX_SES_USE_HIST 
  select 
      v_dt as dt
      ,t.osuser
      , count(1) as cnt 
  from v$session t 
  join v$px_session px on px.SID = t.SID and px.SERIAL# = t.SERIAL# 
  group by t.osuser ;

  insert into NT_RDWH_SESSION_GROUP_HIST
  select 
    v_dt as DT
    ,t.SQL_ID
    ,t.USERNAME
    ,t.SCHEMANAME 
    ,t.STATUS
    ,count(*) as cnt_ses
  from V$SESSION t
  group by 
    t.SQL_ID
    ,t.USERNAME
    ,t.SCHEMANAME 
    ,t.STATUS
  ;  
  commit;
  select trunc(max(dt)) into v_dt from NT_RDWH_OBJSTATICTICS;
  if v_dt <> trunc(sysdate) and extract(hour from cast(sysdate as timestamp)) >= 20 then
        insert into NT_RDWH_OBJSTATICTICS 
        select * 
        from (
          select distinct
             sysdate as dt
            ,o.OBJECT_NAME
            ,o.LAST_DDL_TIME
            ,t.NUM_ROWS
            ,t.LAST_ANALYZED
            ,mv.LAST_REFRESH_DATE
            ,case when t.TABLE_NAME is null then 0 else 1 end is_table
            ,case when mv.MVIEW_NAME is null then 0 else 1 end is_MVIEW
            ,case when v.VIEW_NAME is null then 0 else 1 end is_VIEW
          from all_objects o 
          left join all_tables t on t.OWNER = o.OWNER and t.TABLE_NAME = o.OBJECT_NAME
          left join all_mviews mv on mv.OWNER = o.OWNER and mv.MVIEW_NAME = o.OBJECT_NAME
          left join all_views v on v.OWNER = o.OWNER and v.VIEW_NAME = o.OBJECT_NAME
          where o.OWNER = 'U1'
        ) t
        where t.is_table+is_MVIEW+is_VIEW>0
        ;
        commit;
  end if;  
  
  
end NPRC_MONITORING;
/

