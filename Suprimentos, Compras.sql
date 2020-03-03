
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
