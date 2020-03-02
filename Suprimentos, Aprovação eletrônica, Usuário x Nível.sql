-- -----------------------------------------------------------------------------
-- sup6050 Manutenção de Nível de autorizade por usuário (NÍVEL ALÇADA DO SUP)
-- -----------------------------------------------------------------------------

-- Replica os acessos de um usuário 

INSERT INTO usuario_nivel_aut

SELECT   cod_empresa
       , '' -- Usuário destino
       , cod_nivel_autorid
       , num_versao
       , ies_versao_atual
       , nom_usuario_cad
       , TO_CHAR(sysdate,'DD/MM/YY')
       , hor_cadast
       , ies_tip_autoridade

  FROM usuario_nivel_aut
 WHERE nom_usuario = '' -- Usuário origem
;
