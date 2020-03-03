-- Conceito: Não é necessário ter programação de entrega para que sejam feitos recebimentos parciais no Logix para uma mesma OC
--           O Fornecedor pode enviar uma NF, e é feita a entrada da mesma vinculada a OC/PC, e tão logo for contada, será feita baixa parcial da mesma, ficando saldo
--           Em seguida fornecedor envia outra NF, onde é feita a entrada da mesma em um novo número de AR, porém vinculado a mesma OC/PC para poder ser contada e baixado o saldo final.

-- SUP0420 / SUP2023 - Programação de entrega

SELECT cod_empresa, num_oc, num_versao, num_prog_entrega, ies_situa_prog,
       CASE WHEN ies_situa_prog = 'P' THEN 'Planejado'
            WHEN ies_situa_prog = 'F' THEN 'Firme'
            WHEN ies_situa_prog = 'C' THEN 'Cancelado'
            WHEN ies_situa_prog = 'L' THEN 'Liquidado'
       END AS situacao_programa_entrega_,
       dat_entrega_prev, qtd_solic, qtd_recebida, num_pedido_fornec, qtd_em_transito, dat_palpite, tex_observacao, dat_origem

-- select *
  FROM prog_ordem_sup
 WHERE cod_empresa = '99'
   AND num_oc = 18331
;
