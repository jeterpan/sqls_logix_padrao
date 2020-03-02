^SELECT *
  FROM grupo_ctr_estoq
 WHERE cod_empresa = '99'
;

SELECT *
  FROM item
 WHERE cod_empresa = '99'
   AND ies_ctr_estoque = 'S'
   AND gru_ctr_estoq = 4
;

SELECT * 
  FROM estoque
 WHERE cod_empresa = '99'
   AND cod_item = ''
;

UPDATE estoque
   SET qtd_liberada = '198289.469'
 WHERE cod_empresa = '99'
   AND cod_item = ''
;

SELECT * 
  FROM estoque_lote
 WHERE cod_empresa = '99'
   AND cod_item = ''
   AND  num_lote = '' 
;
  
UPDATE estoque_lote 
   SET qtd_saldo = '11089.05'
 WHERE cod_empresa = '99' AND num_lote = ''
;

SELECT Sum(qtd_saldo) 
  FROM estoque_lote_ender
 WHERE cod_empresa = '99'
   AND cod_item = '' 
;

UPDATE estoque_lote_ender 
   SET qtd_saldo = '11089.05'
 WHERE cod_empresa = '99' 
   AND num_lote = ''
;
