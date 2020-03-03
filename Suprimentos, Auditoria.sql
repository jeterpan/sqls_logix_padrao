
SELECT   cod_empresa
       , num_pedido_ordem
       , num_versao
       , nom_usuario
       , dat_proces
       , hor_operac
       , CASE WHEN ies_tipo = '1' THEN '1 - Pedido de Compra'
              WHEN ies_tipo = '2' THEN '2 - Ordem de Compra'
              WHEN ies_tipo = '3' THEN '3 - Programação de entrega da OC'
         ELSE ''
         END AS x_descricao_tipo

       , CASE WHEN Trim(num_prog) = 'SUP1960' OR Trim(num_prog) = 'SUP22036' THEN 'Alteração de comprador da Ordens de Compra'
              WHEN Trim(num_prog) = 'IMP0106' THEN 'Alteração Tipo Despesa e/ou Percentual IPI da OC'

              WHEN Trim(num_prog) = 'SUP7850' THEN 'Alteração de data entrega/qtds da Ordem de Compra'
              WHEN Trim(num_prog) = 'SUP22090' THEN 'Alteração da Data de entrega do Pedido de Compra'
              WHEN Trim(num_prog) = 'SUP0360' OR Trim(num_prog) = 'SUP20213' THEN 'Programação de entrega'
              WHEN Trim(num_prog) = 'SUP6720' THEN 'Alteração da data de entrega da Ordem de Compra (sup6510>K_altera_data)'

              WHEN Trim(num_prog) = 'SUP4330' THEN 'Elaboração automática de Pedidos de Compra'
              WHEN Trim(num_prog) = 'SUP0420' THEN 'Elaboração de Pedido de Compra, manual (varias OCs)'
              WHEN Trim(num_prog) = 'SUP10020' THEN 'Alteração do Pedido de Compra'
              WHEN Trim(num_prog) = 'sup1582' OR Trim(num_prog) = 'SUP1582' OR Trim(num_prog) = 'SUP22001' THEN 'Alteração de Pedido de Compra'
              WHEN Trim(num_prog) = 'SUP1600' OR Trim(num_prog) = 'SUP16039' THEN 'Cancelamento de Pedido de Compra'
              WHEN Trim(num_prog) = 'SUP0360' OR Trim(num_prog) = 'SUP6720' OR Trim(num_prog) = 'SUP20213' THEN 'Alteração de Programação de entrega'
              WHEN Trim(num_prog) = 'SUP22036' THEN 'Alteração do comprador das Ordens de Compra'
         ELSE 'A definir'
        END AS descricao_programa_
      , num_prog

-- select *
  FROM audit_sup
 WHERE cod_empresa = '65'
   AND num_pedido_ordem = 348
ORDER BY dat_proces, hor_operac
;

/*
https://centraldeatendimento.totvs.com/hc/pt-br/articles/360027303511-LG-COM-Auditorias-da-ordem-e-pedido-de-compra
*/
