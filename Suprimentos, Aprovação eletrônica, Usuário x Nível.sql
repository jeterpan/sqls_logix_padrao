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

-- -----------------------------------------------------------------------------

-- Aprovação eletrônica SUP > Nível alçada

-- sup6040 - Níveis
SELECT *
  FROM nivel_autoridade
;

-- sup6050 - Usuários x Nível
SELECT *
  FROM usuario_nivel_aut
;

-- -----------------------------------------------------------------------------

-- sup6050 - Usuários x Nível
  SELECT *
    FROM usuario_nivel_aut
   WHERE nom_usuario = jsilva
     AND ies_versao_atual = 'S'
ORDER BY cod_empresa
;

-- -----------------------------------------------------------------------------
