/*
Problema
vdp0753 Ao usar a opção Cancela NF Logix aparece a mensagem:
Uma ou mais notas fiscais informadas não foram canceladas por não ter o número de protocolo

Causa

Solução
Pegar o protocolo no site da Sefaz Nacional (se não tiver, ver se tem na Estadual)
Atualizar o protocolo manualmente com o comando abaixo
*/

SELECT *
  FROM obf_nf_eletr
 WHERE empresa = '66'
   AND nota_fiscal = 94028
;

-- CUIDADO: ESTA NO AMBIENTE CORRETO ???
-- UPDATE obf_nf_eletr
   SET   protoc_env_canc = '' -- PROTOCOLO ENCONTRADO NO SITE DA RECEITA
       , dat_rec_protoc_2 = SYSDATE
       , status_envio_nfe = 7 -- NF Cancelada
 WHERE empresa = '66'
   AND nota_fiscal = 94059
   --AND chave_acesso = ''
;

-- Executar novamente a opção Cancela NF Logix no vdp0753

-- -----------------------------------------------------------------------------


STATUS DA TABELA SPED050

Status NFe 
[1] NFe Recebida
[2] NFe Assinada
[3] NFe com falha no schema XML
[4] NFe transmitida
[5] NFe com problemas
[6] NFe autorizada
[7] Cancelamento

Status Cancelamento/inutilizacao
[1] NFe Recebida
[2] NFe Cancelada
[3] NFe com falha de cancelamento/inutilizacao

Status Mail  
[1] A transmitir
[2] Transmitido
[3] Bloqueio de transmissao – cancelamento/inutiliza

Status do SPED052
[1] Lote transmitido
[2] Lote recebido com sucesso
[3] Lote com erro

---

SELECT * FROM sped050
WHERE nfe_id = '' -- CHAVE DE ACESSO
;

SELECT * FROM sped051
;

SELECT * FROM sped053
WHERE date_lote = '20190519' 
ORDER BY time_lote DESC 
;

SELECT * FROM sped054
WHERE nfe_chv='' -- CHAVE DE ACESSO
;
