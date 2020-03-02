-- -----------------------------------------------------------------------------
-- vdp6330 Usuário x Carteira
-- -----------------------------------------------------------------------------

-- Replica acessos de carteira que usuario destino ainda não tem

INSERT INTO usuario_carteira

SELECT   cod_empresa
       , '' -- Usuário destino
       , cod_tip_carteira
       , ies_tip_lista
  FROM usuario_carteira u
 WHERE nom_usuario = '' -- Usuário origem
   AND NOT EXISTS ( SELECT 1
                      FROM usuario_carteira u2
                     WHERE u2.cod_empresa = u.cod_empresa
                       AND u2.nom_usuario = '' -- Usuário destino
                       AND u2.cod_tip_carteira = u.cod_tip_carteira
                  )
;
