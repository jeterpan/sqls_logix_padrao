SELECT * 
  FROM audit_vdp
 WHERE cod_empresa = '99'
  AND num_pedido = 51771
;

-- -----------------------------------------------------------------------------

-- ITEM

-- -----------------------------------------------------------------------------

SELECT * 
  FROM audit_item
 WHERE cod_empresa = '88'
   AND cod_item = '01F01M77021003'
;

SELECT DISTINCT num_programa FROM audit_item

="NUM_PROGRAMA"
="man0585   "
="man10002  "
="man100022 "
="man10021  "

-- -----------------------------------------------------------------------------

-- cre2025 - Auditoria credito e cadastro cliente

SELECT * FROM cre_audit_cli_cca
WHERE cliente = '' -- CNPJ do Cliente (pode ser que ele tem um 0 zero adicional a esquerda. Mesmo que está no cadastro vdp10000 Cadastro de Clientes e Fornecedores
;
