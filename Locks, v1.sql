select distinct s.sid, s.serial#, s.status,g.usuario,g.programa,g.DAT_EXECUCAO,
To_Char(s.logon_time,'dd/mm/yyyy hh24:mi:ss') logon, o.object_name
  from v$locked_object l,
       all_objects     o,
       v$session       s,
       v$open_cursor   c,
       LOG_DADOS_SESSAO_LOGIX g
 where o.object_id = l.object_id
   and l.session_id  = s.sid
   and l.session_id  = c.sid
   AND g.SID = audsid

 ORDER BY 4
;

