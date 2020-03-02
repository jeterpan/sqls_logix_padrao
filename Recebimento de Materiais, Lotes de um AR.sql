
-- Lotes de um AR

SELECT
--         et.qtd_movto

--       , coalesce ( ( SELECT ele.qtd_saldo FROM estoque_lote_ender ele WHERE ele.cod_empresa = et.cod_empresa AND ele.num_lote = et.num_lote_dest ), 0 ) AS saldo_atual_do_lote

         are.cod_empresa
       , are.num_aviso_rec
       , are.num_seq
--       , are.num_seq_tabulacao
       , et.num_lote_dest
       , ( SELECT qtd_liber FROM aviso_rec ar WHERE ar.cod_empresa = are.cod_empresa AND ar.num_aviso_rec = are.num_aviso_rec AND ar.num_seq = are.num_seq ) AS qtd_liber
       --, ( SELECT qtd_saldo FROM estoque_lote_ender ele WHERE ele.cod_empresa = are.cod_empresa AND ele.cod_item = et.cod_item AND ele.num_lote = et.num_lote_dest ) AS saldo_estoque

  FROM aviso_rec_estoque are
  JOIN est_trans_relac_ar eta ON eta.cod_empresa = are.cod_empresa AND eta.num_aviso_rec = are.num_aviso_rec AND eta.num_seq = are.num_seq AND eta.num_transac_dest = are.num_transac
  JOIN estoque_trans et       ON et.cod_empresa = eta.cod_empresa AND et.num_transac = eta.num_transac_dest
  JOIN estoque_trans_end ete  ON ete.cod_empresa = eta.cod_empresa AND ete.num_transac = eta.num_transac_dest
 WHERE
       are.cod_empresa = '99'
   AND are.num_aviso_rec = 15311
;
