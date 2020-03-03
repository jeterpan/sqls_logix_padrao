SELECT 

       -- *
              
       cod_empresa, cod_fornecedor, raz_social, cod_item_fornec, cod_unid_med_forn, fat_conver_unid, cod_unid_med, cod_item, den_item_reduz, den_item, ies_aprovado, dat_aprov,

       ifo.ies_tem_inspecao,

       CASE WHEN ifo.ies_tem_inspecao = 'N' THEN 'Inspeção manual'
            WHEN ifo.ies_tem_inspecao = 'S' THEN 'Inspeção automática'  
            WHEN ifo.ies_tem_inspecao = '1' THEN 'Cont. e Insp.Manual'
            WHEN ifo.ies_tem_inspecao = '2' THEN 'Cont.Manual e Insp.Auto.'
            WHEN ifo.ies_tem_inspecao = '3' THEN 'Cont.Auto. e Insp.Manual'
            WHEN ifo.ies_tem_inspecao = '4' THEN 'Cont. e Insp.Automática'
       END AS tem_inspecao

       -- sup0090 -- Item de Fornecedor
  FROM item_fornec ifo
  JOIN item USING ( cod_empresa, cod_item )
  JOIN fornecedor USING ( cod_fornecedor ) 
 WHERE cod_empresa = '66'
--   AND ies_aprovado = 'H'
  AND cod_unid_med_forn <> cod_unid_med
  AND cod_fornecedor = '' -- CPNJ do Fornecedor (Talvez esteja cadastrado com um zero a mais a esquerda no vdp10000)
;
