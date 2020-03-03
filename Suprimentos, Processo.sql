SELECT *
  FROM aviso_rec
 WHERE cod_empresa = '99'
   AND num_aviso_rec = 15311 -- Aviso de Recebimento (A.R.)
;

SELECT *
  FROM nf_sup n
  JOIN aviso_rec ar
    ON ar.cod_empresa = n.cod_empresa
   AND ar.num_aviso_rec = n.num_aviso_rec
   AND ar.cod_item = ''
 WHERE cod_fornecedor = '' -- CNPJ do Fornecedor
;

SELECT DISTINCT ies_situa_ar -- I-Inspeção???, C-Contagem e E-Encerrado
           FROM aviso_rec
;

SELECT DISTINCT ies_liberacao_ar -- 1, 2 e 3
           FROM aviso_rec
;

-- -----------------------------------------------------------------------------

-- sup0090

SELECT *
  FROM item_fornec
;

-- Situações com Unidade de Medida do Fornecedor diferente da Unidade de Media de controle interno

SELECT   f.cod_empresa, f.cod_item
       , i.cod_unid_med AS x_cod_unid_med_item
       , f.cod_fornecedor, f.cod_item_fornec
       , f.ies_item_iso, f.dat_aprov, dat_entrega_ult, f.cnd_pgto, f.cod_mod_embar, f.cod_moeda, f.ies_aprovado, f.cod_unid_med_forn, f.fat_conver_unid, f.pct_particip_comp, f.ies_tip_entrega
       , f.qtd_periodos_seg, f.qtd_lote_minimo, f.qtd_lote_maximo, f.qtd_lote_multiplo, f.qtd_max_mes, f.qtd_dias_entrega, f.ies_tip_preco, f.dat_ini_contrato, f.dat_fim_contrato
       , f.ies_tem_inspecao, f.ies_tipo_inspecao, f.qtd_inspecao, f.ies_tip_aprovacao, f.tex_observ, f.ies_reg_espec_icms, f.qtd_entr_sem_insp
  FROM item_fornec f
  JOIN item i
    ON i.cod_empresa = f.cod_empresa
   AND i.cod_item = f.cod_item
   AND i.cod_unid_med <> f.cod_unid_med_forn
;

