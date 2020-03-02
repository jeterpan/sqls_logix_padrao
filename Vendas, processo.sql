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
