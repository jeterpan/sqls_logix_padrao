-- Itens que controlam WMS
/*
Nota: Estamos levando em consideração aqui, que a empresa onde está instalado o módulo WMS, optou por
       escolher alguns Grupos de Controle de Estoque que controlam WMS e cadastraram eles no wms0002
      E também existem algumas exceções dentro destes Grupos de Controle de Estoque que foram cadastradas
       no wms0003
      O comando abaixo então é útil para esta situação
      
      Informo isso, pois, há outras combinações para definir se um item controla ou não WMS usando
       o wms0002 e wms0003
*/

SELECT *

  FROM item i
       -- wms0002 -- Grupos de Controle de estoque que controlam WMS
  JOIN wms_grp_ctr_est g ON g.cod_empresa = i.cod_empresa AND g.grp_ctr_estoque = i.gru_ctr_estoq

 WHERE  NOT EXISTS ( SELECT 1
                            -- wms0003 - Itens exceções controle WMS
                       FROM wms_item_ctr_est e -- Exceções
                      WHERE e.cod_empresa = i.cod_empresa AND  e.cod_item = i.cod_item
                        AND ind_item_ctr_wms = 'N' -- S-Controla WMS, N-Não controla WMS
                   )
;
