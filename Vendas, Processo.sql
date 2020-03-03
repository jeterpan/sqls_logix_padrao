
-- vdp20000 - Pedido de Venda (Padrão Logix)

SELECT * 
  FROM pedidos
 WHERE cod_empresa = '66'
   AND num_pedido = 102042
;

SELECT *
  FROM ped_itens
 WHERE cod_empresa = '66'
   AND num_pedido = 102042
;

SELECT *
  FROM ped_itens_grade
;

-- -----------------------------------------------------------------------------

-- Pedido e seus itens (Padrão Logix) - NÃO GRADE

SELECT *
  FROM ped_itens pi
  JOIN pedidos pv ON pv.cod_empresa = pi.cod_empresa AND pv.num_pedido = pi.num_pedido
                 AND pv.cod_empresa = '66'
                 AND pv.num_pedido = 102042
;

-- -----------------------------------------------------------------------------

-- Pedido e seus itens (Padrão Logix) - GRADE

SELECT *
  FROM ped_itens pi
  JOIN pedidos pv ON pv.cod_empresa = pi.cod_empresa AND pv.num_pedido = pi.num_pedido
                 AND pv.cod_empresa = ''
                 AND pv.num_pedido =  
;

-- -----------------------------------------------------------------------------

SELECT * FROM pedidos;
SELECT * FROM ped_itens;
SELECT * FROM ped_itens_grade;
SELECT * FROM ped_itens_grade_vkrd;

-- Pedido e seus itens

SELECT *
  FROM ped_itens pi
  JOIN pedidos pv ON pv.cod_empresa = pi.cod_empresa AND pv.num_pedido = pi.num_pedido
                 AND pv.cod_empresa = ''
                 AND pv.num_pedido =  
;

-- -----------------------------------------------------------------------------

-- vdp20022 Auditoria de aprovação de pedidos

-- -----------------------------------------------------------------------------

-- vdp20028 Auditoria de manutenção de pedidos

-- -----------------------------------------------------------------------------
-- Ordens de Montagem (vdp10000 / vdp8020)
-- -----------------------------------------------------------------------------

SELECT DISTINCT ies_sit_om FROM ordem_montag_mest
;
-- B Bloqueada
-- N liberada Normal
-- F Faturada
-- E em Embalagem (WMS)

-- -----------------------------------------------------------------------------
-- Script de ajustes
-- -----------------------------------------------------------------------------

-- As reservas tem sup_par_resv_est?
--  Logix as vezes falha em gravar estas, se falhou, então temos que matar as reservas via banco

-- Tem reservas para o Pedido em questão?

-- create table bkp_estlocres171019 as
SELECT *
-- delete
  FROM estoque_loc_reser
 WHERE cod_empresa = '66'
   AND num_docum = '102042'
--ORDER BY num_docum, num_referencia 
;

--CREATE TABLE 
SELECT *

       -- Dimensionais reservados 
  FROM est_loc_reser_end e

       -- Reserva
  JOIN estoque_loc_reser r
    ON r.cod_empresa = e.cod_empresa AND r.num_reserva = e.num_reserva AND ies_origem='V' 

 WHERE r.cod_empresa = '66'
   AND r.num_docum = '102042'
   
ORDER BY   r.cod_empresa    
         , r.num_docum      -- Pedido de venda (string: 6 digitos com zeros a esquerda) 
         , r.num_referencia -- Sequencia de item do Pedido de venda ( string: 5 digitos com zeros a esquerda) 
;

-- Tem romaneio?
SELECT om.cod_empresa, om.num_om, om.ies_sit_om
 
       -- Sempre há dados nesta tabela de OM, independente se o item controla ou não grade
  FROM ordem_montag_grade omg

  JOIN ordem_montag_mest om ON om.cod_empresa = omg.cod_empresa AND om.num_om = omg.num_om

  WHERE om.cod_empresa = '66'
    AND omg.num_pedido = 102042 

--ORDER BY  
;

-- VALIDAR: TENTATIVA DE ACERTO DA TABELA ITEM DO PEDIDO, COM FATOS EXISTENTES NAS TABELAS DE RESERVA E FATURAMENTO
UPDATE ped_itens pi
   SET 
         pi.qtd_pecas_atend = (

                              -- Soma dos itens atendidos (de NF não canceladas)
                              
                                SELECT nfi.qtd_item 
                                        
                                  FROM fat_nf_item nfi

                                  JOIN fat_nf_mestre nf ON nf.empresa = nfi.empresa  AND nf.trans_nota_fiscal = nfi.trans_nota_fiscal
                                   AND nf.tip_nota_fiscal = 'FATPRDSV'
                                   AND nf.sit_nota_fiscal <> 'C'

                                 WHERE nfi.empresa = pi.cod_empresa
                                   AND nfi.pedido = pi.num_pedido
                                   AND nfi.seq_item_pedido = pi.num_sequencia
                                   AND nfi.item = pi.cod_item 
                                
                              )
       , pi.qtd_pecas_reserv = Nvl (
                                     (
       
                                      -- Reservas de Venda Normal (não Liquidadas)
                                
                                        SELECT Sum(qtd_reservada)

                                          FROM estoque_loc_reser r

                                        WHERE r.cod_empresa = pi.cod_empresa                                  
                                          AND Trim(r.num_docum) = Trim(LPad(pi.num_pedido, 6, 0))
                                          AND Trim(r.num_referencia) = Trim(LPad(pi.num_sequencia, 5, 0))
                                          AND r.cod_item = pi.cod_item
                                          AND r.ies_origem = 'V' -- C-Compras, V-Vendas
                                          AND r.ies_situacao = 'N' -- N-Normal, L-Liquidada    
                                      ),
                                      0
                                    )

 WHERE pi.cod_empresa = '66'
   AND pi.num_pedido = 102042
;

-- Lotes faturados

SELECT nfi.*

  FROM fat_nf_item nfi

  JOIN fat_nf_mestre nf ON nf.empresa = nfi.empresa  AND nf.trans_nota_fiscal = nfi.trans_nota_fiscal
   AND nf.tip_nota_fiscal = 'FATPRDSV'
   --AND nf.sit_nota_fiscal <> 'C'
   AND nf.empresa = '66'
   --AND nf.cliente = '' -- CNPJ
   AND nf.nota_fiscal = 100484

       -- Relacionamento: Movimentado no Item da NF (fat_nf_item) para cada grade (tabulacao) x Tabela estoque_trans
  JOIN fat_ctr_est_nf iet ON iet.empresa = nfi.empresa AND iet.trans_nota_fiscal = nfi.trans_nota_fiscal AND iet.seq_item_nf = nfi.seq_item_nf

       -- Movimentação de estoque
  JOIN estoque_trans et ON et.cod_empresa = iet.empresa AND et.num_transac = iet.trans_estoque

       -- Movimentação de estoque (no nível de endereçamento)
  JOIN estoque_trans_end ete ON ete.cod_empresa = et.cod_empresa AND ete.num_transac = et.num_transac

ORDER BY nf.empresa, nfi.pedido, nfi.seq_item_pedido, nfi.ord_montag, nf.nota_fiscal, nfi.seq_item_nf 
;
 
-- Consulta não validada e provavelmente gerando linhas repetidas
-- Apenas guardando ela para lembrar rapidamente do processo de vendas

SELECT
            'itens do pedido>' AS x_itens_do_pedido
          , pi.num_pedido
          , pi.num_sequencia
          , pi.cod_item
          , pi.qtd_pecas_solic
          , i.cod_unid_med
          , pi.qtd_pecas_atend
          , pi.qtd_pecas_cancel
          , pi.qtd_pecas_reserv
          , (pi.qtd_pecas_solic - qtd_pecas_atend - qtd_pecas_cancel - qtd_pecas_reserv) AS saldo

          , 'reserva normal>' AS x_reserva_normal
          , r.num_reserva
          , r.num_lote
          , r.qtd_reservada

          , 'om>' AS x_om
          , om.num_om
          , om.num_sequencia
          --, ordem_montag_item.num_om num_om_na_item,
          , om.num_reserva
          --, reservas.num_lote

          , 'nf>' AS x_nf
          , nf.nota_fiscal
          , ni.seq_item_nf
          , ni.qtd_item

     FROM ped_itens pi

left JOIN item i ON i.cod_empresa = pi.cod_empresa AND i.cod_item = pi.cod_item

          -- vdp20000 Pedido de Venda
     JOIN pedidos pv ON pv.cod_empresa = pi.cod_empresa AND pv.num_pedido = pi.num_pedido
      AND pv.cod_empresa = '66'
      AND pv.num_pedido = 106672

          -- Reservas
left JOIN estoque_loc_reser r ON r.cod_empresa = pi.cod_empresa AND To_Number(r.num_docum)= pi.num_pedido AND To_Number(r.num_referencia) = pi.num_sequencia

          -- Item da Ordem de Montagem (O.M.) - vdp1000/vdp8020 padrão
left JOIN ordem_montag_item oi ON oi.cod_empresa = pi.cod_empresa AND oi.num_pedido = pi.num_pedido AND oi.num_sequencia = pi.num_sequencia

          -- Cabeçalho da Ordem de Montagem (O.M.) - vdp1000/vdp8020 padrão
left JOIN ordem_montag_grade om ON om.cod_empresa = pi.cod_empresa AND om.num_pedido = pi.num_pedido AND om.num_sequencia = pi.num_sequencia

          -- Nota Fiscal, item
left JOIN fat_nf_item ni ON ni.empresa = pi.cod_empresa AND ni.pedido = pi.num_pedido AND ni.seq_item_pedido = pi.num_sequencia

          -- Nota Fiscal, capa
left JOIN fat_nf_mestre nf ON nf.empresa = ni.empresa AND nf.trans_nota_fiscal = ni.trans_nota_fiscal

 ORDER BY pi.cod_empresa,
          pi.num_sequencia
;
                                                                            
                                                                            
                                                                            SELECT * FROM pedidos
WHERE cod_empresa = '66'
AND ies_frete = 6
ORDER BY num_pedido desc
;

/*
1 - CIF Pago
2 - CIF Cobrado
3 - FOB
4 - CIF informado pct.
6 - item Tot.


*/

  SELECT cod_empresa,
         ies_frete,
         CASE
          WHEN ies_frete = 1 THEN 'CIF Pago'
          WHEN ies_frete = 2 THEN 'CIF Cobrado'
          WHEN ies_frete = 3 THEN 'FOB'
          WHEN ies_frete = 4 THEN 'CIF informado pct.'
          WHEN ies_frete = 6 THEN 'item Tot.'
         END AS tipo_frete,
         Count( cod_empresa ),
         Round (100 * Count(cod_empresa) / Sum (Count(cod_empresa)) OVER () , 2) percent

    FROM pedidos

   WHERE cod_empresa = '66'

GROUP BY cod_empresa,
         ies_frete

ORDER BY 5 DESC
;
