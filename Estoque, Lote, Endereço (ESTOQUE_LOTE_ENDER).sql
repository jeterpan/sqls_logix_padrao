
-- Ender
SELECT ele.cod_empresa, ele.cod_item, ele.cod_local, ele.num_lote, ele.cod_grade_1 AS largura, ele.cod_grade_2 AS comprimento, ele.ies_situa_qtd, ele.qtd_saldo, i.cod_unid_med, ele.num_transac
-- SELECT *
  FROM estoque_lote_ender ele
  JOIN item i ON i.cod_empresa = ele.cod_empresa AND i.cod_item = ele.cod_item
 WHERE
       ele.cod_empresa = '99'
   AND
       ele.num_lote = 'INV20180303'
;

-- Ender WMS
SELECT ele.cod_empresa, ele.cod_item, ele.cod_local, ele.num_lote, ele.endereco,
       CASE WHEN NOT EXISTS ( SELECT 1 FROM wms_endereco e WHERE e.empresa = ele.cod_empresa AND e.LOCAL = ele.cod_local AND e.endereco = ele.endereco )
                 THEN ( '* Endereco nao existe no local' )
       ELSE we.des_reduz_endereco
       END AS existe_local,
       ele.ies_situa_qtd, ele.qtd_saldo, i.cod_unid_med, ele.dat_hor_validade,
       CASE WHEN dat_hor_validade < SYSDATE THEN '* Expirada'
       ELSE 'NAO'
       END AS expirada,
       ele.identif_estoque, ele.deposit, ele.num_transac

-- SELECT *
  FROM estoque_lote_ender ele

  JOIN item i ON i.cod_empresa = ele.cod_empresa AND i.cod_item = ele.cod_item
  JOIN wms_endereco we ON we.empresa = ele.cod_empresa AND we.LOCAL = ele.cod_local AND we.endereco = ele.endereco

 WHERE
       ele.cod_empresa = '66'
--   AND
--       ele.num_lote = 'INV20180303'
   AND cod_local IN (
                        'LC00000001' -- Armazem 1
                       ,'LC00000006' -- Armazem 2
                    )
   AND identif_estoque = '166190419072826262'
   AND deposit IN (
                      '' -- CNPJ DO DEPOSITANTE (EM CASO DE MODULO WMS INSTALADO EM OPERADOR LOGÍSTICO) OU CNPJ DA INDUSTRIA EM CASO DE WMS INSTALADO EM INDUSTRIA
                  )
;
