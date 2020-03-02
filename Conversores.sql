
^
-- -----------------------------------------------------------------------------

-- Reprocessar conversores:

--  Apague primeiro as tabelas abaixo

DELETE FROM ctrl_alt_logix_2 WHERE cod_sistema='WMS'AND num_conversor=734
;

DELETE FROM cnv_instr_realiz where cod_sistema='WMS' AND num_conversor=734
;

DELETE FROM cnv_log_execucao WHERE cod_sistema='WMS' AND num_conversor=734
;

-- Reprocessar o conversor no log6000

-- -----------------------------------------------------------------------------

-- Log de execucao de conversor (tabela ou parametros):

  SELECT *
    FROM cnv_log_execucao
   WHERE cod_sistema = 'WMS'
     AND num_conversor =         734
ORDER BY dat_execucao, cod_sistema, num_conversor, num_operacao
;

-- -----------------------------------------------------------------------------

-- Log6000 Processa conversores de tabela

-- -----------------------------------------------------------------------------

-- Log00086 Processa conversores de parametros

-- -----------------------------------------------------------------------------

-- Consulta de parametros

SELECT *
  FROM log_val_parametro
 WHERE parametro LIKE 'embarq%'
;

-- -----------------------------------------------------------------------------
