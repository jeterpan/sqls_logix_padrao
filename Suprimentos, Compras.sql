
-- =============================================================================
-- EMPRESA
-- =============================================================================

SELECT *
  FROM empresa
;

-- =============================================================================
-- TRANSFERÊNCIA
-- =============================================================================

-- SUP4100 - Manutenção das empresas que possuem o Faturamento Logix e Transferência

  SELECT *
    FROM empresa_transf
ORDER BY cod_empresa, cod_empresa_transf
;

-- =============================================================================
-- COMPRAS
-- =============================================================================

-- SUP0290 Ordem de compra - Item de estoque
-- SUP0300 Ordem de compra - Débito Direto

SELECT *
  FROM ordem_sup
;

SELECT *
  FROM ordem_sup_txt
;

SELECT *

  FROM ordem_sup oc

  JOIN ordem_sup_txt t ON t.cod_empresa = oc.cod_empresa AND t.num_oc = oc.num_oc
   AND tex_observ_oc LIKE '%CONSULTOR%'

WHERE
       oc.cod_empresa = '99'
  --AND
      --oc.num_oc = 2129

ORDER BY oc.num_oc DESC
;

-- =============================================================================

-- Situações de OCs existentes na base:
SELECT DISTINCT ies_situa_oc
  FROM ordem_sup;

SELECT * FROM ordem_sup WHERE cod_empresa = '99' AND ies_situa_oc = 'R' AND ies_versao_atual = 'S';

-- A -- Em (A)berto
-- C -- (C)ancelada
-- L -- (L)iquidada
-- P -- (P)lanejada
-- R -- (R)ealizada

-- Situações de Pedidos existentes na base:
SELECT DISTINCT ies_situa_ped FROM pedido_sup;

SELECT * FROM pedido_sup WHERE
--cod_empresa = '99' AND
ies_situa_ped = 'R' AND ies_versao_atual = 'S';

-- L -- (L)iquidado
-- C -- (C)ancelado
-- A -- (A)berto
-- R -- (R)ealizado

SELECT * FROM audit_sup
;

CREATE TABLE bkp_ordem_sup20180130 AS SELECT * FROM ordem_sup;
CREATE TABLE bkp_pedido_sup20180130 AS SELECT * FROM pedido_sup;

-- Levantamento Número de OCs a serem apagadas
SELECT cod_empresa,
       Count(1)

  FROM ordem_sup

 WHERE ies_situa_oc NOT IN ('L','C')
   AND ies_versao_atual = 'S'
   AND ( cod_empresa, num_pedido ) IN

(
SELECT cod_empresa,
       num_pedido
  FROM pedido_sup
 WHERE
       ies_situa_ped NOT IN ('L','C')
       --dat_liquidac IS NULL
   AND ies_versao_atual = 'S'
   AND dat_emis BETWEEN To_Date('01/01/2015 00:00:00', 'DD/MM/RRRR HH24:MI:SS')
                    AND To_Date('31/12/2016 23:59:59', 'DD/MM/RRRR HH24:MI:SS')

)

GROUP BY cod_empresa
;

 -- ies_liquida_oc

-- dat_liquidac

-- Levantamento Número de Pedidos de Compra a serem apagados
SELECT cod_empresa,
       Count(1)
  FROM pedido_sup
 WHERE
       ies_situa_ped NOT IN ('L','C')
       --dat_liquidac IS NULL
   AND ies_versao_atual = 'S'
   AND dat_emis BETWEEN To_Date('01/01/2015 00:00:00', 'DD/MM/RRRR HH24:MI:SS')
                    AND To_Date('31/12/2016 23:59:59', 'DD/MM/RRRR HH24:MI:SS')

GROUP BY cod_empresa
;

-- log das Ordens de compra que serão alteradas

CREATE TABLE bkp_ordem_sup_log20180130 AS

SELECT *

  FROM ordem_sup

 WHERE ies_situa_oc NOT IN ('L','C')
   AND ies_versao_atual = 'S'
   AND ( cod_empresa, num_pedido ) IN

(
SELECT cod_empresa,
       num_pedido
  FROM pedido_sup
 WHERE
       ies_situa_ped NOT IN ('L','C')
       --dat_liquidac IS NULL
   AND ies_versao_atual = 'S'
   AND dat_emis BETWEEN To_Date('01/01/2015 00:00:00', 'DD/MM/RRRR HH24:MI:SS')
                    AND To_Date('31/12/2016 23:59:59', 'DD/MM/RRRR HH24:MI:SS')
)
;

-- log dos Pedidos de Compra que serão alterados

CREATE TABLE bkp_pedido_sup_log20180130 AS

SELECT *
  FROM pedido_sup
 WHERE
       ies_situa_ped NOT IN ('L','C')
       --dat_liquidac IS NULL
   AND ies_versao_atual = 'S'
   AND dat_emis BETWEEN To_Date('01/01/2015 00:00:00', 'DD/MM/RRRR HH24:MI:SS')
                    AND To_Date('31/12/2016 23:59:59', 'DD/MM/RRRR HH24:MI:SS')
;

-- Liquidação de OCs e PCs de 2015a2016

UPDATE ordem_sup
   SET ies_situa_oc = 'L'

 WHERE ies_situa_oc NOT IN ('L','C')
   AND ies_versao_atual = 'S'
   AND ( cod_empresa, num_pedido ) IN

(
SELECT cod_empresa,
       num_pedido
  FROM pedido_sup
 WHERE
       ies_situa_ped NOT IN ('L','C')
       --dat_liquidac IS NULL
   AND ies_versao_atual = 'S'
   AND dat_emis BETWEEN To_Date('01/01/2015 00:00:00', 'DD/MM/RRRR HH24:MI:SS')
                    AND To_Date('31/12/2016 23:59:59', 'DD/MM/RRRR HH24:MI:SS')
)
;

UPDATE pedido_sup
   SET ies_situa_ped = 'L', dat_liquidac = SYSDATE
 WHERE
       ies_situa_ped NOT IN ('L','C')
       --dat_liquidac IS NULL
   AND ies_versao_atual = 'S'
   AND dat_emis BETWEEN To_Date('01/01/2015 00:00:00', 'DD/MM/RRRR HH24:MI:SS')
                    AND To_Date('31/12/2016 23:59:59', 'DD/MM/RRRR HH24:MI:SS')
;

