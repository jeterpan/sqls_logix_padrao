-- REVISAR COMPLETAMENTE ESTE SCRIPT POIS ELE NAO FOI VALIDADO

--SELECT * FROM v$lock

WITH bloqueio_aguardando_bloqueio AS ( SELECT *
                                         FROM v$lock
                                        WHERE request > 0
                                     ),
     sessao_aguardando_bloqueio   AS ( SELECT *
                                         FROM v$session
                                     ),
     sessao_logix_aguardando      AS ( SELECT *
                                         FROM log_dados_sessao_logix
                                     ),
     usuarios_aguardando_bloqueio AS ( SELECT *
                                         FROM usuarios
                                     )

         SELECT Trim(usuarios.nom_funcionario) || ' bloqueando ' || Trim(usuarios_aguardando_bloqueio.nom_funcionario) AS Nomes_completos,
                v$session.sid,
                log_dados_sessao_logix.usuario,
                log_dados_sessao_logix.sid AS totvs_monitor_sid,
                v$session.username,
                log_dados_sessao_logix.programa,
                log_dados_sessao_logix.origem client_clienteip_appserver,
                --IP_appserverport,
                v$session.username || '@' ||v$session.machine
                || ' ( SID=' || v$session.sid || ' )  bloqueando '
                || sessao_aguardando_bloqueio.username || '@' || sessao_aguardando_bloqueio.machine || ' ( SID=' || sessao_aguardando_bloqueio.sid || ' ) ' AS situacao_do_bloqueio

           FROM v$lock

     INNER JOIN v$session
             ON v$session.sid = v$lock.sid

                -- View da Totvs criada pela instalação do Logix com banco de dados Oracle (ifxSysviews_ORA.sq)
left OUTER JOIN v_sessao_ora
             ON v_sessao_ora.sid = v$session.sid

LEFT OUTER JOIN log_dados_sessao_logix
             ON log_dados_sessao_logix.sid = v$session.audsid

     INNER JOIN bloqueio_aguardando_bloqueio
             ON bloqueio_aguardando_bloqueio.id1 = v$lock.id1
            AND bloqueio_aguardando_bloqueio.id2 = v$lock.id2

                -- Oracle view: Current Sessions
     INNER JOIN sessao_aguardando_bloqueio
             ON sessao_aguardando_bloqueio.sid = bloqueio_aguardando_bloqueio.sid

                -- Cadastro de usuários Logix (log05050)
LEFT OUTER JOIN usuarios
             ON usuarios.cod_usuario = log_dados_sessao_logix.usuario

LEFT OUTER JOIN sessao_logix_aguardando
             ON sessao_logix_aguardando.sid = sessao_aguardando_bloqueio.audsid

                -- Cadastro de usuários Logix (log05050)
LEFT OUTER JOIN usuarios_aguardando_bloqueio
             ON usuarios_aguardando_bloqueio.cod_usuario = sessao_logix_aguardando.usuario

          WHERE v$lock.BLOCK = 1

;

/*
ALTER SYSTEM KILL SESSION '1023,21799';
*/
