SELECT   et.cod_empresa, et.cod_item, To_Char (et.dat_movto,'DD/MM/YYYY') AS dat_movto, et.cod_operacao
       , CASE 
              WHEN et.num_prog = 'SUP0570' THEN 'AR / seqItemAR' 
              WHEN et.num_prog = 'SUP0064' THEN 'AR / seqItemAR'
              WHEN et.num_prog = 'VDP0745' THEN 'NF-Serie / seqItemNF'
         END AS x_tipo_docum
       , et.num_docum, et.num_seq
       , et.num_prog
       , CASE 
              WHEN et.num_prog = 'SUP0570' THEN 'Inspeção' 
              WHEN et.num_prog = 'SUP0064' THEN 'Contagem'
              WHEN et.num_prog = 'VDP0745' THEN 'Faturamento'
         END AS x_processo
       
       , et.ies_tip_movto
       , et.qtd_movto, i.cod_unid_med, et.cod_local_est_orig, et.cod_local_est_dest, et.num_lote_orig, et.num_lote_dest, et.ies_sit_est_orig
       ,
       CASE WHEN et.ies_sit_est_orig = 'L' THEN 'Liberado normal' WHEN et.ies_sit_est_orig = 'I' THEN 'Impedido' WHEN et.ies_sit_est_orig = 'R' THEN 'Rejeitado'
            WHEN et.ies_sit_est_orig = 'E' THEN 'Liberado excepcionalmente' WHEN et.ies_sit_est_orig = 'V' THEN 'Disponível para venda'
       END AS situacao_orig, 
       et.ies_sit_est_dest, 
       CASE WHEN et.ies_sit_est_dest = 'L' THEN 'Liberado normal' WHEN et.ies_sit_est_dest = 'I' THEN 'Impedido' WHEN et.ies_sit_est_dest = 'R' THEN 'Rejeitado'
            WHEN et.ies_sit_est_dest = 'E' THEN 'Liberado excepcionalmente' WHEN et.ies_sit_est_dest = 'V' THEN 'Disponível para venda'
       END AS situacao_dest,
       et.nom_usuario, et.dat_proces, et.hor_operac, et.num_transac

-- SELECT *
  FROM estoque_trans et
  JOIN item i ON i.cod_empresa = et.cod_empresa AND i.cod_item = et.cod_item 

 WHERE et.cod_empresa = '66'

   --AND et.cod_operacao = ''
   --AND et.cod_item = ''
   --AND et.num_docum like '%93854%'
  --AND et.num_transac IN ( 126815, 126816 )

   --AND et.num_lote_orig = 'XXX'
   --AND et.num_lote_dest = 'XXX'
   AND ( et.num_lote_orig = '9K31000098345A' OR et.num_lote_dest = '9K31000098345A')

   --AND et.dat_movto = ''
   --AND et.dat_movto = to_char(SYSDATE , 'DD/MM/RRRR')
   --AND et.dat_movto BETWEEN  To_Date('19/12/2016 00:00:00', 'DD/MM/YYYY') and To_Date('27/12/2016 23:59:59', 'DD/MM/YYYY HH24:MI:SS')

   --AND et.dat_proces = ''
   --AND et.dat_proces BETWEEN  To_Date('19/12/2016 00:00:00', 'DD/MM/YYYY') and To_Date('27/12/2016 23:59:59', 'DD/MM/YYYY HH24:MI:SS')

ORDER BY et.dat_proces DESC, et.hor_operac DESC
;
