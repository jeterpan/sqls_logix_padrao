
-- Acessos Logix

-- Baseado nos acessos concedidos a Grupos, quais usuários tem acesso a um determinado programa?

  SELECT log_usu_niv_sist.empresa,
         log_usu_grupos.grupo,
         log_grupos.des_grupo,
         log_usu_grupos.usuario,
         usuarios.nom_funcionario nom_usuario
--SELECT *
    FROM log_usu_niv_sist

    JOIN log_usu_grupos
      ON Trim(log_usu_grupos.grupo) = Trim(log_usu_niv_sist.usuario)
     AND transacao = 'SUP5001' -- Maiúsculo: exemplo MAN0515
     --AND log_usu_grupos.usuario = 'jsilva'

    JOIN log_grupos
      ON log_grupos.grupo = log_usu_grupos.grupo

    JOIN usuarios
      ON usuarios.cod_usuario = log_usu_grupos.usuario

   WHERE log_usu_niv_sist.empresa = '66'

GROUP BY log_usu_niv_sist.empresa,
         log_usu_grupos.grupo,
         log_grupos.des_grupo,
         log_usu_grupos.usuario,
         usuarios.nom_funcionario

ORDER BY log_usu_niv_sist.empresa,
         log_usu_grupos.grupo,
         log_usu_grupos.usuario,
         usuarios.nom_funcionario
;

-- SUP9270 Operações de estoque por usuário

SELECT *
  FROM estoque_oper_usuar
;
-- log05050 > Grupos

select *
  from LOG_GRUPOS

-- LOG05050 > Grupos de usuários > Usuários x Grupos

select usuario,
       grupo
  from log_usu_grupos
 where usuario = 'jsilva' -- Usuário

-- LOG05050 > Grupos de usuários > Grupos x Usuários

select usuario,
       grupo
  from log_usu_grupos
 where grupo = 'MAN0515' -- Grupo
;


-- LOG05050 > Permissão de acesso
select *
  from log_usu_niv_sist
 where usuario = 'rh' -- Grupo ou Usuário
;

-- Programas/Usuarios que tem acesso ao Grupo
select *
  from log_usu_niv_sist
 where usuario = 'jsilva' -- Grupo ou Usuário
;

-- Checa integridade das tabelas de acesso do Logix

select usuario
  from log_usu_niv_sist
  where usuario not in ( select cod_usuario from usuarios )
;


-- LOG1120

insert into log_usu_dir_relat
select 'jsilva', empresa, sistema_fonte, ambiente, 'c:\totvs\logix\lst\jsilva\' from log_usu_dir_relat
where usuario = 'jsilva'
and sistema_fonte = 'LST'
;

-- SUP6050 - Nível de autoridade por usuário

SELECT *
  FROM usuario_nivel_aut
 WHERE nom_usuario = 'jsilva'
;

-- -----------------------------------------------------------------------------

-- vdp6070 - Usuário x Natureza de Operacao

-- Liberacao de Natureza de operacao

-- -----------------------------------------------------------------------------

-- sup0300 Acessos para poder incluir Ordem de Compra

-- SUP4270

-- Replicar apenas acessos inexistentes
-- REVISAR ESTES COMANDOS PARA PERMITIR COPIAR ACESSOS DE TODAS AS EMPRESAS OU DE APENAS EMPRESAS SELECIONADAS
INSERT INTO CTR_CPR_DEB_DIRETO

SELECT   cod_empresa
       , '' -- Usuário destino
       , cod_uni_funcio
  FROM ctr_cpr_deb_direto d

WHERE

     -- Empresa Origem
     cod_empresa IN ( --'99' -- Empresa Origem
                      )
 AND  nom_usuario = 'maria' -- Usuário origem

 AND NOT EXISTS ( SELECT 1
                    FROM ctr_cpr_deb_direto s -- Subconsulta
                   WHERE s.cod_empresa = d.cod_empresa
                     AND s.nom_usuario = '' -- Usuário Destino
                     AND s.cod_uni_funcio = d.cod_uni_funcio
                )
;

-- replicar acessos para cadastro de Ocs

INSERT INTO CTR_CPR_DEB_DIRETO

SELECT   cod_empresa
       , 'jsilva' -- Usuário destino
       , cod_uni_funcio 
  FROM ctr_cpr_deb_direto

WHERE
-- ctr_cpr_deb_direto.cod_empresa='88'
 nom_usuario = 'maria'
 AND cod_empresa IN ( '88'
                      )
;

 -- Para complementar unidades que faltam, e evitar chave violada
 AND (cod_empresa, nom_usuario, cod_uni_funcio ) NOT IN ( SELECT   '99' -- Empresa destino
                                                                 , 'jsilva' -- Usuário destino
                                                                 , cod_uni_funcio 
                                                          FROM CTR_CPR_DEB_DIRETO
                                                        ) 

; 


-- -----------------------------------------------------------------------------

-- Replica
INSERT INTO path_logix_v2
SELECT   '99' 
       , cod_sistema,
       ies_ambiente,
       cod_tip_processo,
       nom_caminho
  FROM path_logix_v2
 WHERE cod_sistema = 'EJF'
   AND cod_empresa = '88' -- Empresa origem
;

SELECT * 
  FROM programador
 WHERE login = 'jsilva'
;

INSERT INTO comprador

SELECT cod_empresa, 27, 'Joao da Silva', 'jsilva'
-- select *
  FROM comprador
--WHERE cod_comprador = 27
WHERE login = 'maria'
;
