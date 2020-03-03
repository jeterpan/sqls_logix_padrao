
-- -----------------------------------------------------------------------------
-- Processo de Importação (imp0019)
-- -----------------------------------------------------------------------------

SELECT *
  FROM processo_imp
 WHERE cod_empresa = '99'
   AND num_processo = 660
;

-- -----------------------------------------------------------------------------
-- Despesas do Processo de importação (imp0029 ou botão despesas no imp0019)
-- -----------------------------------------------------------------------------

SELECT *
  FROM despesa_processo
 WHERE cod_empresa = '99'
   AND num_processo = 660
;

-- -----------------------------------------------------------------------------
-- Despesas de importação (imp0073) - CADASTRO
-- -----------------------------------------------------------------------------

SELECT   d.cod_despesa
       , d.den_despesa
       , d.ies_base_calc_ii    -- Calcular II? - Indica se a despesa faz parte do cálculo do imposto de importação. (Importante: As despesas que fazem parte do cálculo do impostos de importação farão parte do valor da mercadoria na nota fiscal de importação.)
       , d.ies_base_calc_ipi   -- Calcular IPI? - Indica se a despesa faz parte do cálculo do IPI. (Importante: As despesas que fazem parte do cálculo do IPI farão parte do valor da mercadoria na nota fiscal de importação.)
       , d.ies_base_calc_icms  -- Calcular ICMS? - Indica se a despesa faz parte do cálculo do ICMS.
       , d.ies_tip_desp        -- Indica o tipo de despesa de importação.
       , CASE
           WHEN IES_TIP_DESP = 1 THEN '1-DESPESA'                               -- Entra na base de cálculo dos impostos, de acordo com os indicadores Calcula II?, Calcula IPI?, Calcula ICMS? e Calcula PIS/COFINS?, fazendo parte da nota fiscal de importação.
           WHEN IES_TIP_DESP = 2 THEN '2-FRETE NORMAL'                          -- Entra na base de cálculo dos impostos, fazendo parte da nota fiscal de importação e sendo exibido nos processos de importação como frete.
           WHEN IES_TIP_DESP = 3 THEN '3-FRETE PREPAID'                         -- Entra para efeito de cálculo dos impostos, fazendo parte da nota fiscal de importação, mas não aparece na tela de processos como frete.
           WHEN IES_TIP_DESP = 4 THEN '4-FRETE NOTA'                            -- Faz parte do saldo de câmbio do processo e sofre correção cambial.
           WHEN IES_TIP_DESP = 5 THEN '5-DESPESA ACESSORIA NOTA'                -- Faz parte do saldo de câmbio do processo e sofre correção cambial.
           WHEN IES_TIP_DESP = 6 THEN '6-ADIANTAMENTO'                          -- Este valor deve ser registrado na moeda padrão CON0040 (Cadastros e Tabelas - Parâmetros - Gerais - Parâmetros Contábeis). Ao prestar contas de adiantamento no CAP1890 (Contas a Pagar - Adiantamentos - Adiantamentos Viagem - Acerto Despesas) os valores destas despesas serão somados para efeito de comparação com o valor adiantado.
           WHEN IES_TIP_DESP = 7 THEN '7-FRETE ADIANTAMENTO'                    -- Este valor deve ser registrado na moeda padrão no CON0040 (Cadastros e Tabelas - Parâmetros - Gerais - Parâmetros Contábeis). Ao prestar conta de adiantamento no CAP1890 (Contas a Pagar - Adiantamentos - Adiantamentos Viagem - Acerto Despesas) os valores destas despesas serão somados para efeito de comparação com o valor adiantado.
           WHEN IES_TIP_DESP = 8 THEN '8-FRETE EXPORTADOR'                      -- Entra na base de cálculo dos impostos, fazendo parte da nota fiscal de importação, porém não será contabilizado e nem embutido no custo do item.
           WHEN IES_TIP_DESP = 9 THEN '9-DESPESA EXPORTADOR'                    -- Entra na base de cálculo dos impostos, de acordo com os indicadores Calcula II?, Calcula IPI?, Calcula ICMS?
         END AS TIPO_DESPESA
       , d.tip_rateio          -- Indica o tipo de rateio da despesa; T-Total | P-Parcial
       , d.cta_contab_credito  -- Conta contábil de crédito da despesa.
       , ( SELECT parametro_ind
             FROM imp_par_despesa p
            WHERE p.despesa_import = d.cod_despesa
              AND parametro = 'calcula_pis_cofins'
         ) AS x_calcula_pis_cofins -- Calcular PIS/Cofins? - Indica se a despesa faz parte do cálculo do PIS/COFINS.
       , ( SELECT parametro_ind
             FROM imp_par_despesa p
            WHERE p.despesa_import = d.cod_despesa
              AND parametro = 'soma_total_nota'
         ) AS x_soma_total_nota   -- Indica se a despesa será ou não considerada na impressão do total da nota fiscal.
  FROM despesa_imp d
;

/*
-- fonte: https://tdn.totvs.com/pages/releaseview.action?pageId=284471394


Importante:

Os indicadores de despesas 1,2,3,4 e 5 serão considerados no cálculo do pagamento de imposto, IMP0017 (Pagamento Impostos) e IMP0019 (Cadastro dos Processos). Os tipos de despesas 2, 4 e 8 (informações de frete) aparecem no valor de frete no processo de importação.

Os indicadores de despesa tipo 6 e 7 serão utilizados no acerto de contas de adiantamento.

---

campo: Tipo rateio

Indica o tipo de rateio da despesa.

T - Total. O valor da despesa será rateado entre todos os pedidos do processo;

P - Parcial. O valor da despesa será rateada entre os pedidos selecionados para a mesma.

---

campo: Soma total da Nota

Indica se a despesa será ou não considerada na impressão do total da nota fiscal.

Nota:

Este campo só poderá ser informado nas despesas tipo 1(normal) e que não possuam impostos e será considerado para definir as despesas cadastradas para o processo de importação será considerada ou não na impressão do total da nota fiscal.

Depois de lançar uma despesa no imp0029 com "Somar total nota?" assinalado e incluir nota fiscal amarrada ao processo de importação, ao executar o IMP0029, status   "E" (encerrar) a despesa lançada será rateada entre os itens da nota fiscal e será considerada no total da nota fiscal (quando for enviada para SEFAZ).

*/

SELECT
       --*
       DISTINCT parametro
  FROM imp_par_despesa
;

-- -----------------------------------------------------------------------------

SELECT * FROM evento_imp
;

SELECT * 
  FROM imp_desp_proc_item
;

SELECT * FROM imp_desp_proc_item
WHERE empresa = '66'
AND processo = 281
;

SELECT di.ies_tip_desp,
       CASE
        WHEN ies_tip_desp = 1 THEN '1-DESPESA'
        WHEN ies_tip_desp = 2 THEN '2-FRETE NORMAL'
        WHEN ies_tip_desp = 3 THEN '3-FRETE PREPAID'
        WHEN ies_tip_desp = 4 THEN '4-FRETE NOTA'
        WHEN ies_tip_desp = 5 THEN '5-DESPESA ACESSORIA NOTA'
        WHEN ies_tip_desp = 6 THEN '6-ADIANTAMENTO'
        WHEN ies_tip_desp = 7 THEN '7-FRETE ADIANTAMENTO'
        WHEN ies_tip_desp = 8 THEN '8-FRETE EXPORTADOR'
        WHEN ies_tip_desp = 9 THEN '9-DESPESA EXPORTADOR'
       END AS x_tipo_despesa,

       Sum ( val_desp * ( SELECT val_cotacao from cotacao WHERE cod_moeda = dp.cod_moeda AND dat_ref = dp.dat_desp ) ) AS x_total_tipo_despesa
       --dp.cod_moeda,
       --dp.dat_desp
  FROM despesa_processo dp -- Despesas do processo de importação

  JOIN despesa_imp di -- Despesas de importação, cadastro
    ON di.cod_despesa = dp.cod_despesa

   --AND di.ies_tip_desp IN (6)

 WHERE cod_empresa = '99'
   AND num_processo = 660

GROUP BY di.ies_tip_desp
;

SELECT dp.cod_empresa,
       dp.num_seq,
       dp.cod_despesa,
       di.ies_tip_desp,
       VAL_DESP,
       val_desp * ( SELECT val_cotacao from cotacao WHERE cod_moeda = dp.cod_moeda AND dat_ref = dp.dat_desp )
       --dp.cod_moeda,
       --dp.dat_desp
  FROM despesa_processo dp
  JOIN despesa_imp di
    ON di.cod_despesa = dp.cod_despesa
   AND di.ies_tip_desp IN (6,7)
 WHERE cod_empresa = '99'
   AND num_processo = 281
--GROUP BY di.ies_tip_desp
ORDER BY dp.num_seq
;


SELECT val_cotacao FROM cotacao WHERE cod_moeda = 3 AND dat_ref = '31/01/2018'
;

SELECT * 
  FROM MOV_ADIANT
 WHERE COD_EMPRESA = '99'
   AND COD_FORNECEDOR = '' -- CNPJ do Fornecedor
   AND NUM_AD_NF_ORIG = 22877
;

SELECT cod_empresa, dat_mov, ies_ent_bx, cod_fornecedor, num_ad_nf_orig, ser_nf, ssr_nf, val_mov, val_saldo_novo, ies_ad_ap_mov, num_ad_ap_mov, cod_tip_val_mov, hor_mov
  FROM MOV_ADIANT
 WHERE .COD_EMPRESA='99'
 -- AND NUM_AD_NF_ORIG=NULL
  AND .IES_ENT_BX='B'
  AND .COD_FORNECEDOR='' -- CNPJ
;

SELECT * FROM ADIANT
;

-- -----------------------------------------------------------------------------

-- Levantando os tipos existentes no banco de dados:

SELECT DISTINCT ies_tip_desp FROM despesa_imp
;
/*
IES_TIP_DESP
1 - DESPESA
2 - FRETE NORMAL
3 - FRETE PREPAID
4 - FRETE NOTA
5 - DESPESA ACESSORIA NOTA
6 - ADIANTAMENTO
7 - FRETE ADIANTAMENTO
8 - FRETE EXPORTADOR
9 - DESPESA EXPORTADOR

*/

-- -----------------------------------------------------------------------------

-- Auditoria do SUP

-- -----------------------------------------------------------------------------

SELECT
       CASE WHEN num_prog = 'SUP1960' THEN 'Alteração de compradora das Ordens de Compra'
            WHEN num_prog = 'IMP0106' THEN 'Alteração do Tipo de despesa e/ou Percentual do IPI da OC'
            WHEN num_prog = 'SUP22090' THEN 'Alteração da Data de entrega do Pedido de Compra'
            WHEN num_prog = 'SUP0420' THEN 'Elaboração do Pedido de Compra'
            WHEN num_prog = 'SUP1582' THEN 'Alteração do Pedido de Compra'
            WHEN num_prog = 'SUP1600' THEN 'Cancelamento do Pedido de Compra'
            WHEN num_prog = 'SUP20213' THEN 'Programação de entrega'
            WHEN num_prog = 'sup22001' THEN 'Manutenção dos Pedidos de Compra'
            WHEN num_prog = 'SUP0360' THEN 'Programação de entrega'
            WHEN num_prog = 'SUP6720' THEN 'Programação de entrega'
            WHEN num_prog = 'SUP4330' THEN 'Elaboração automática do Pedido de Compra'
            WHEN num_prog = 'SUP22036' THEN 'Alteração do comprador das Ordens de Compra'
            WHEN num_prog = 'SUP16039' THEN 'Cancelamento de Pedido de Compra com Adiantamento'
            WHEN num_prog = 'sup1582' THEN 'Alteração do Pedido de Compra'
            WHEN num_prog = 'SUP7850' THEN 'Alteração Data de Entrega'
            WHEN num_prog = 'SUP10020' THEN 'Alteração do Pedido de Compra'
       END AS x_programa
-- SELECT
       -- *
       -- DISTINCT num_prog
  FROM audit_sup
;
