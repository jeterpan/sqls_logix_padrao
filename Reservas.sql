SELECT   r.cod_empresa
       , r.num_reserva
       , r.cod_item
       , r.cod_local
       , r.num_lote
       , r.ies_origem
       , CASE
            WHEN r.ies_origem = 'C' THEN 'Manual'
            WHEN r.ies_origem = 'I' THEN 'Manutenção Industrial'
            WHEN r.ies_origem = 'M' THEN 'M.R.P.'
            WHEN r.ies_origem = 'O' THEN 'Manutenção de Ativos'
            WHEN r.ies_origem = 'P' THEN 'Preventiva'
            WHEN r.ies_origem = 'V' THEN 'Vendas'
         END AS origem
       , r.qtd_reservada
       , i.cod_unid_med
       , r.ies_situacao
       , CASE WHEN r.ies_situacao = 'N' THEN 'Normal/Ativa'
            WHEN r.ies_situacao = 'L' THEN 'Liquidada'
         END AS situacao
       , r.dat_solicitacao
       , r.qtd_atendida
       , i.cod_unid_med
       , r.dat_ult_atualiz
-- delete
-- select *
  FROM estoque_loc_reser r
  JOIN item i ON i.cod_empresa = r.cod_empresa AND i.cod_item = r.cod_item
 WHERE r.cod_empresa = '66'
   AND r.cod_item = '31C01M03000003'
   --AND r.ies_origem = 'V'
   --AND r.ies_situacao = 'N'
   --AND r.num_reserva = 1221648
  -- AND r.num_lote = '9H66000856775A'
  AND qtd_reservada > 0
;
