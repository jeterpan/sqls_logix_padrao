SELECT nf.empresa, et.num_lote_orig, te.*

  FROM fat_nf_item ni

  JOIN fat_nf_mestre nf ON nf.empresa = ni.empresa  AND nf.trans_nota_fiscal = ni.trans_nota_fiscal
   AND nf.tip_nota_fiscal = 'FATPRDSV' AND nf.sit_nota_fiscal <> 'C'
   AND nf.empresa = '66'
   --AND nf.cliente = ''
   AND nf.nota_fiscal = 100484

       -- Relacionamento: Movimentado no Item da NF (fat_nf_item) para cada grade (tabulacao) x Tabela estoque_trans
  JOIN fat_ctr_est_nf iet ON iet.empresa = ni.empresa AND iet.trans_nota_fiscal = ni.trans_nota_fiscal AND iet.seq_item_nf = ni.seq_item_nf

       -- Movimentação de estoque
  JOIN estoque_trans et ON et.cod_empresa = iet.empresa AND et.num_transac = iet.trans_estoque

       -- Movimentação de estoque (no nível de endereçamento)
  JOIN estoque_trans_end te ON te.cod_empresa = et.cod_empresa AND te.num_transac = et.num_transac
;

