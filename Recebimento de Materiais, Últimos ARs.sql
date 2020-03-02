-- Transferência entre Unidades (de um Grupo de Empresas)

-- Ultimos Avisos de Recebimentos (A.R.s) de Unidade A para Unidade B, onde a Unidade de Medida de controle é diferente

SELECT

       -- *

       ( SELECT Max(ar.num_aviso_rec)
           FROM aviso_rec ar
           JOIN nf_sup n ON n.cod_empresa = ar.cod_empresa AND n.num_aviso_rec = ar.num_aviso_rec
          WHERE ar.cod_empresa = o.cod_empresa
            AND ar.cod_item = o.cod_item
            AND n.cod_fornecedor = o.cod_fornecedor
       ) AS ult_ar

       , o.cod_empresa, o.cod_fornecedor, raz_social, cod_item_fornec, cod_unid_med_forn, fat_conver_unid, cod_unid_med, o.cod_item, den_item_reduz, den_item, ies_aprovado, dat_aprov,

       o.ies_tem_inspecao,

       CASE WHEN o.ies_tem_inspecao = 'N' THEN 'Inspeção manual'
            WHEN o.ies_tem_inspecao = 'S' THEN 'Inspeção automática'
            WHEN o.ies_tem_inspecao = '1' THEN 'Cont. e Insp.Manual'
            WHEN o.ies_tem_inspecao = '2' THEN 'Cont.Manual e Insp.Auto.'
            WHEN o.ies_tem_inspecao = '3' THEN 'Cont.Auto. e Insp.Manual'
            WHEN o.ies_tem_inspecao = '4' THEN 'Cont. e Insp.Automática'
       END AS tem_inspecao

       -- sup0090 Relacionamento Item x Fornecedor
  FROM item_fornec o

       -- man10081 / man10021 - Engenharia: Cadastro do item
  JOIN item i ON i.cod_empresa = o.cod_empresa AND i.cod_item = o.cod_item

       -- vdp10000 Cadastro de Clientes e Fornecedores > aba Fornecedor
  JOIN fornecedor f ON f.cod_fornecedor = o.cod_fornecedor

 WHERE o.cod_empresa = '99'
--   AND ies_aprovado = 'H'
  AND o.cod_unid_med_forn <> i.cod_unid_med
  AND o.cod_fornecedor = '' -- CPNJ (PODE SER QUE PRECISE DE UM 0 ZERO ANTES)
  --AND o.cod_item_fornec = ''
ORDER BY 1 DESC
;
