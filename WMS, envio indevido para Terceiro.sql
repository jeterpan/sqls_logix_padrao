/*

Problema
Foi enviado indevidamente para terceiro saldo de Item que controla WMS. E é sabido, que pelo menos até o momento (13/05/2019), isso não deveria acontecer, visto que o módulo WMS não está preparado para fazer o retorno de Item que esta EM TERC

Solução
- Terceiro deve emitir NF de retorno sem aplicação, retornando todo o material.
- E o mais fácil é excluir a remessa no controle de terceiros do que tentar fazer um retorno.
- Mesmo para excluir a remessa, será necessário definir o item em questão como Não controla WMS (você pode colocá-lo temporariamente no wms0003 como exceção).
- Em seguida, altere o lote do item na estoque_lote_ender para não conter informações de WMS (para ser possível excluir a remessa através de programa Não WMS) (sup2280). Cuidado, guarde as informações pois você precisará delas em seguida.
- Exclua a remessa via sup2280; isso fará a reversão dos movimentos que levaram o item para EM TERC; devolvendo o item para o local de origem dentro da empresa.
- Acerte novamente o(s) lote(s) devolvendo as informações de estoque (identificação de estoque e depositante) na estoque_lote_ender.
- Ative novamente o controle de WMS do item (exemplo: removendo ele do wms0003 exceções)

*/

SELECT * FROM estoque_lote_ender
WHERE cod_empresa = '99'
AND cod_item = ''
AND num_lote = ''
--AND cod_local = 'EM TERC'
--AND qtd_saldo = 14 -- 666190508094030657
;

SELECT * FROM estoque_lote_ender
WHERE cod_empresa = '99'
AND cod_item = ''
AND num_lote = ''
AND cod_local = 'EM TERC'
AND qtd_saldo = 11 -- 166190419104007202
;

UPDATE estoque_lote_ender
SET identif_estoque = '666190508094030657'
, deposit = '' -- CNPJ do Depositante (Em indústria, a própria Indústria) (Observe que pode ter um 0 zero a mais a esquerda / mesma forma como está cadatrado no log00083)
WHERE cod_empresa = '99'
AND cod_item = ''
AND num_lote = ''
AND cod_local = 'VEICULO'
AND qtd_saldo = 25 -- 666190508094030657
;

UPDATE estoque_lote_ender
SET identif_estoque = '666190508094030657'
, deposit = '' -- CNPJ do Terceiro
WHERE cod_empresa = '99'
AND cod_item = ''
AND num_lote = ''
AND cod_local = 'VEICULO'
AND qtd_saldo = 11 -- 166190419104007202
;

SELECT DISTINCT DEPOSIT FROM estoque_lote_ender
;

