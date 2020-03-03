SELECT   r.cod_empresa
       , r.num_reserva
       , r.cod_item
       , r.cod_local
       , r.num_lote
       , r.ies_origem
       , CASE
            WHEN r.ies_origem = 'C' THEN 'Manual'
            WHEN r.ies_origem = 'I' THEN 'Manutenção Industrial'
            WHEN r.ies_origem = 'M' THEN 'M.R.P.'
            WHEN r.ies_origem = 'O' THEN 'Manutenção de Ativos'
            WHEN r.ies_origem = 'P' THEN 'Preventiva'
            WHEN r.ies_origem = 'V' THEN 'Vendas'
         END AS origem
       , r.qtd_reservada
       , i.cod_unid_med
       , r.ies_situacao
       , CASE WHEN r.ies_situacao = 'N' THEN 'Normal/Ativa'
            WHEN r.ies_situacao = 'L' THEN 'Liquidada'
         END AS situacao
       , r.dat_solicitacao
       , r.qtd_atendida
       , i.cod_unid_med
       , r.dat_ult_atualiz
-- delete
-- select *
  FROM estoque_loc_reser r
  JOIN item i ON i.cod_empresa = r.cod_empresa AND i.cod_item = r.cod_item
 WHERE r.cod_empresa = '66'
   AND r.cod_item = '31C01M03000003'
   --AND r.ies_origem = 'V'
   --AND r.ies_situacao = 'N'
   --AND r.num_reserva = 1221648
  -- AND r.num_lote = '9H66000856775A'
  AND qtd_reservada > 0
;

/*
sup_par_resv_est - esta tabela guarda as informações de parâmetros que foram utilizadas para fazer uma reserva de estoque
*/

/* Problema
   É raro, mas eventualmente, ao gravar uma reserva de estoque ref ao processo de vendas,
    é possível que a reserva é efetivada (na tabela estoque_loc_reser), no entanto, o Logix não
    grava a sup_par_resv_est (que são os parâmetros que foram usados na geração da reserva)

   Causa
    ?

   Impacto
    Sem algumas informações da reserva, é impossível usar a mesma, para por exemplo criar a Ordem de Montagem
    Sem outra, por exemplo: transac_rever_item, é impossível desfazer a reserva

   Solução:
    Inserir manualmente a reserva

-- Exemplo de parametros utilizado por uma reserva no Processo de Vendas:

INSERT INTO sup_par_resv_est
            (empresa,reserva,parametro,des_parametro,parametro_ind,parametro_texto,parametro_val,parametro_num,parametro_dat)
     VALUES ('66',1149466,'transac_rever_item','Transac?o da reversao do item                               ', 2, NULL, 3286984, 460)
;

*/

/*

efetiva_parcial
Reserva de vendas que permite efetivac?o parcial
Parametro ind (indicador?): NULL, demais tb null

sit_est_reservada
Situac?o do estoque que esta sendo reservado.
Parametro ind: 'L', demais NULL

transac_rever_item
Transac?o da reversao do item
Parametro ind: '2' -- Suspeito que 2 seja para reservas de Venda
Parametro texto: NULL
Parametro val: Numero da transacao na estoque_trans, que será utilizada para podermos desfazer a reserva
Parametro num: Quantidade do movimento (estoque_trans.qtd_movto)

*/

/* Integridade do banco de dados Logix com relação a Reservas
*/

-- de Vendas

-- Consulta as reservas que estão ligadas a um Pedido de Venda, no entanto, não tem registro que permite a reversão desta reserva

SELECT *

  FROM estoque_loc_reser

 WHERE ( cod_empresa, Trim(num_docum) ) IN

  ( SELECT pig.cod_empresa,
          Trim ( LPad(pig.num_pedido, 6, '0') ) pedido
      FROM ped_itens_grade pig )

   AND ( cod_empresa, num_reserva ) NOT IN

  ( SELECT sp.empresa,
           sp.reserva
      FROM sup_par_resv_est sp
     WHERE sp.parametro = 'transac_rever_item'
     )

  AND ies_origem = 'V'
;



