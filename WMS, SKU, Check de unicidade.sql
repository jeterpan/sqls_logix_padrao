/*
   Objetivo: Checar se há item com mais de um SKU padrão

   Se encontrar registros, deve-se decidir qual sku será o padrão e atualizar os demais para Não

   27/04/2019: Na empresa 99, a maioria dos itens estavam sendo vendidos com SKU Unitário, então mativemos o Unitário como padrão

*/

  SELECT empresa, item, sku
    FROM wms_item_sku
   WHERE empresa = '99'
     AND sku_padrao = 'S'
GROUP BY empresa, item, sku
  HAVING Count(1) > 1
;

SELECT *
  FROM wms_item_sku
WHERE empresa = '99'
AND item = ''
;

UPDATE wms_item_sku
   SET sku_padrao = 'N'
WHERE empresa = '99'
AND item = ''
AND sku = ''
;

