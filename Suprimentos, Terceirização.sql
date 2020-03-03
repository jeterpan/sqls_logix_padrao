

SELECT nfi.*

  FROM fat_nf_item nfi

  JOIN fat_nf_mestre nf ON nf.empresa = nfi.empresa  AND nf.trans_nota_fiscal = nfi.trans_nota_fiscal
   AND nf.tip_nota_fiscal = 'FATPRDSV'
   --AND nf.sit_nota_fiscal <> 'C'
   AND nf.empresa = '99'
   --AND nf.cliente = '' -- CNPJ Cliente
   AND nf.nota_fiscal = 100484

       -- Relacionamento: Movimentado no Item da NF (fat_nf_item) para cada grade (tabulacao) x Tabela estoque_trans
  JOIN fat_ctr_est_nf iet ON iet.empresa = nfi.empresa AND iet.trans_nota_fiscal = nfi.trans_nota_fiscal AND iet.seq_item_nf = nfi.seq_item_nf

       -- Movimentação de estoque
  JOIN estoque_trans et ON et.cod_empresa = iet.empresa AND et.num_transac = iet.trans_estoque

       -- Movimentação de estoque (no nível de endereçamento)
  JOIN estoque_trans_end ete ON ete.cod_empresa = et.cod_empresa AND ete.num_transac = et.num_transac

ORDER BY nf.empresa, nfi.pedido, nfi.seq_item_pedido, nfi.ord_montag, nf.nota_fiscal, nfi.seq_item_nf
;

-- =============================================================================

SELECT *
  FROM item_em_terc
 WHERE cod_fornecedor = '' -- CNPJ do Fornecedor (pode conter um 0 zero adicional a esquerda se estiver cadastrado assim no vdp10000 - Cadastro de Clientes e Fornecedor)
   AND  cod_item = ''
;

-- -----------------------------------------------------------------------------
-- SUP2270 / Itens de Terceiro
-- -----------------------------------------------------------------------------

SELECT *
  FROM item_de_terc
 WHERE cod_empresa = '23'
   AND cod_fornecedor = '' -- CNPJ do Fornecedor (pode conter um 0 zero adicional a esquerda se estiver cadastrado assim no vdp10000 - Cadastro de Clientes e Fornecedor)
   AND cod_item = ''
   AND  ( qtd_tot_recebida - qtd_tot_devolvida ) > 0
;

-- -----------------------------------------------------------------------------
-- vdp0766 / vdp10029 Item retorno/remessa
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------


-- Lotes de um AR
SELECT *
  FROM aviso_rec_estoque are
  JOIN est_trans_relac_ar eta ON eta.cod_empresa = are.cod_empresa AND eta.num_aviso_rec = are.num_aviso_rec AND eta.num_seq = are.num_seq AND eta.num_transac_dest = are.num_transac
  JOIN estoque_trans et       ON et.cod_empresa = eta.cod_empresa AND et.num_transac = eta.num_transac_dest
  JOIN estoque_trans_end ete  ON ete.cod_empresa = eta.cod_empresa AND ete.num_transac = eta.num_transac_dest
 WHERE are.cod_empresa = '88'
   AND are.num_aviso_rec = 115
;

-- create table bkp_supitemtercend as
select *
  from sup_item_terc_end
 where empresa = '88'
   and nota_fiscal = '107099'
;

select * from sup_itterc_grade
WHERE empresa = '99'
AND nota_fiscal = 107099
;

SELECT * FROM sup_retn_item_terc
 WHERE empresa = '88'
   AND nota_fiscal = 107099
   AND nf_remessa = 107099
;


-- retorno
SELECT * 
  FROM fat_retn_item_nf
 WHERE empresa = '23'
   AND nf_entrada = 107099
;



SELECT * 
  FROM estoque_lote_ender
 WHERE
--cod_empresa = '88'
--AND
num_lote IN (
 '9K31000098084A'
,'9K31000098096A'
,'9K31000098090A'
)
;

-- create table bkp_supitemtercend031219 as
SELECT *
--DELETE
  FROM sup_item_terc_end
 WHERE empresa = '88'
   AND nota_fiscal = 107156
;

INSERT INTO sup_item_terc_end

-- Lotes de um AR
SELECT '88'
       , 107156
       , '6  '
       , 0
       , 'NFR'
       , '' -- CNPJ do Fornecedor (pode conter um 0 zero adicional a esquerda se estiver cadastrado assim no vdp10000 - Cadastro de Clientes e Fornecedor) 
       , 116
       , are.num_seq
       , are.num_seq_tabulacao
       , 1
       , et.cod_item
       , et.cod_local_est_dest
       , et.num_lote_dest
       , 'L' --et.ies_sit_est_dest
       , '               '
       , 0
       , ete.cod_grade_1
       , ete.cod_grade_2
       , ete.cod_grade_3
       , ete.cod_grade_4
       , ete.cod_grade_5
       , ete.dat_hor_producao
       , ete.dat_hor_validade
       , ete.num_peca
       , ete.num_serie
       , ete.comprimento
       , ete.largura
       , ete.altura
       , ete.diametro
       , ete.dat_hor_reserv_1
       , ete.dat_hor_reserv_2
       , ete.dat_hor_reserv_3
       , ete.qtd_reserv_1
       , ete.qtd_reserv_2
       , ete.qtd_reserv_3
       , ete.num_reserv_1
       , ete.num_reserv_2
       , ete.num_reserv_3
       , ete.tex_reservado
       , ete.qtd_movto
       , 0

  FROM aviso_rec_estoque are
  JOIN est_trans_relac_ar eta ON eta.cod_empresa = are.cod_empresa AND eta.num_aviso_rec = are.num_aviso_rec AND eta.num_seq = are.num_seq AND eta.num_transac_dest = are.num_transac
  JOIN estoque_trans et       ON et.cod_empresa = eta.cod_empresa AND et.num_transac = eta.num_transac_dest
  JOIN estoque_trans_end ete  ON ete.cod_empresa = eta.cod_empresa AND ete.num_transac = eta.num_transac_dest
 WHERE are.cod_empresa = '23'
   AND are.num_aviso_rec = 116
   AND (   '23'
         , 107156
         , '6  '
       , 0
       , 'NFR'
       , '' -- CNPJ do Fornecedor (pode conter um 0 zero adicional a esquerda se estiver cadastrado assim no vdp10000 - Cadastro de Clientes e Fornecedor)
       , are.num_seq
       , are.num_seq_tabulacao
       ) NOT IN ( SELECT empresa, nota_fiscal, serie_nota_fiscal, subserie_nf,
       espc_nota_fiscal, fornecedor, seq_aviso_recebto,
       seq_tabulacao FROM sup_item_terc_end )
;

