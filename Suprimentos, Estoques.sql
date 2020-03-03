-- -----------------------------------------------------------------------------
-- SUP0170 / SUP50001 - CONSULTA DE ESTOQUES
-- -----------------------------------------------------------------------------

      SELECT   cod_empresa
             , cod_item
             , den_item_reduz
             , cod_unid_med
             , ies_tip_item
             , '', ''
             , qtd_liberada
             , qtd_lib_excep
             , qtd_rejeitada
             , qtd_impedida
             , qtd_reservada
             , qtd_disp_venda
             , '' , '', 0, 0, 0, 0
             , dat_ult_entrada
             , dat_ult_saida
             , dat_ult_invent

        FROM estoque

NATURAL JOIN item

       WHERE cod_empresa = '66'
         AND cod_item = '24B01M02200307'
         AND ies_ctr_estoque = 'S'
;


-- -----------------------------------------------------------------------------

SELECT UNIQUE
                estoque.COD_EMPRESA
              , estoque.COD_ITEM
              , item.DEN_ITEM_REDUZ
              , item.COD_UNID_MED
              , item.IES_TIP_ITEM
              , ''
              , estoque.QTD_LIBERADA
              , estoque.QTD_LIB_EXCEP
              , estoque.QTD_REJEITADA
              , estoque.QTD_IMPEDIDA
              , estoque.QTD_RESERVADA
              , estoque.QTD_DISP_VENDA
              , '', '' , 0, 0, 0, 0
              , estoque.DAT_ULT_ENTRADA
              , estoque.DAT_ULT_SAIDA
              , estoque.DAT_ULT_INVENT
         FROM estoque, estoque_lote, item
        WHERE estoque.COD_EMPRESA = "COD_EMPRESA"
          AND estoque_lote.COD_EMPRESA = "COD_EMPRESA"
          AND estoque_lote.COD_ITEM = estoque.COD_ITEM

          AND estoque_lote.QTD_SALDO < 0
          AND item.COD_EMPRESA = "COD_EMPRESA"
          AND item.COD_ITEM = estoque.COD_ITEM
          AND item.IES_CTR_ESTOQUE = "S"
;
      SELECT
                cod_empresa
              , cod_item
              , den_item_reduz
              , cod_unid_med
              , ies_tip_item
              , ''
              , qtd_liberada
              , qtd_lib_excep
              , qtd_rejeitada
              , qtd_impedida
              , qtd_reservada
              , qtd_disp_venda
              , '', '' , 0, 0, 0, 0
              , dat_ult_entrada
              , dat_ult_saida
              , dat_ult_invent

        FROM estoque
NATURAL JOIN estoque_lote
NATURAL JOIN item

       WHERE cod_empresa = ""
         AND estoque_lote.qtd_saldo < 0
         AND ies_ctr_estoque = "S"
;

/*

ESTOQUE

Fonte: http://tdn.totvs.com/pages/releaseview.action?pageId=233745610

Os saldos de estoques, apresentados no SUP0170/SUP50001, são:

Lib. normal: soma das quantidades em estoque com situação "L".

Lib. Excep.: soma das quantidades em estoque com situação "E".

Rejeitada: soma das quantidades em estoque com situação "R".

Inspeção: soma das quantidades em estoque com situação "I", está situação pode ser item em inspeção também.

Reservada: soma das quantidades reservadas no SUP5740/SUP50004 ainda pendentes de efetivação.

Qtd em Terceiros: soma das quantidade remessas para em terceiros do SUP2280/SUP54033 quantidade remessa menos quantidade recebida, que é a soma dos retornos no SUP2290/SUP54032.

Qtd de Terceiros: soma das quantidade recebidas De terceiros em poder da empresa do SUP2270/SUP54031 quantidade recebida menos quantidade devolvida, que é a soma das devoluções no SUP2300/SUP54028.

Qtd.Proc.Contag.: quantidade aguardando contagem no SUP0530 ou SUP0331 - Contagem.

Qtd.em Trânsito: soma das quantidades das notas tipo = 7 do SUP3760 - Entrada Notas fiscais.

Qtd. na Empresa:
Se SUP5110 - Parâmetros Movimentação Automática - Baixa Itens Utilizados = "2 - Baixa no retorno": Soma Qtd na Empresa = Lib. normal + Lib. Excep + Rejeitada + Disp Venda + Inspeção - Qtd.em Terceiros.
Se "1 - Baixa no remessa" e SUP6200 - Parâmetros Diversos - Baixa Componen Utilizados <> "N".
Soma Qtd na Empresa = Lib. normal +  Lib. Excep + Rejeitada + Disp Venda + Inspeção
Se "1 - Baixa no remessa" e SUP6200 - Baixa Componen Utilizadoa = "N" Soma: Qtd na Empresa =  Lib. normal + Lib. Excep + Rejeitada + Disp Venda + Inspeção - Qtd.em Terceiro

 Entrega Futura: Notas no SUP3760, quando tipo NFM - quantidade já recebida nas notas NFPs relacionadas.
----------------------------

Conceito técnico (tabelas):

Busca itens conforme select para listar no SUP0170/SUP50001:

*/

SELECT ESTOQUE.COD_EMPRESA,
ESTOQUE.COD_ITEM,
ITEM.DEN_ITEM_REDUZ,
ITEM.COD_UNID_MED,
ITEM.IES_TIP_ITEM, "" "",
ESTOQUE.QTD_LIBERADA,
ESTOQUE.QTD_LIB_EXCEP,
ESTOQUE.QTD_REJEITADA,
ESTOQUE.QTD_IMPEDIDA,
ESTOQUE.QTD_RESERVADA,
ESTOQUE.QTD_DISP_VENDA,
"" "","" "", 0, 0, 0, 0,
ESTOQUE.DAT_ULT_ENTRADA,
ESTOQUE.DAT_ULT_SAIDA,
ESTOQUE.DAT_ULT_INVENT
FROM ESTOQUE, ITEM
WHERE ITEM.COD_EMPRESA = ESTOQUE.COD_EMPRESA
AND ESTOQUE.COD_ITEM = "COD_ITEM"
AND ITEM.COD_ITEM = ESTOQUE.COD_ITEM
AND ITEM.IES_CTR_ESTOQUE = "S"

--------------
SELECT UNIQUE ESTOQUE.COD_EMPRESA, ESTOQUE.COD_ITEM,
ITEM.DEN_ITEM_REDUZ, ITEM.COD_UNID_MED,
ITEM.IES_TIP_ITEM, "" "",
ESTOQUE.QTD_LIBERADA, ESTOQUE.QTD_LIB_EXCEP,
ESTOQUE.QTD_REJEITADA, ESTOQUE.QTD_IMPEDIDA,
ESTOQUE.QTD_RESERVADA, ESTOQUE.QTD_DISP_VENDA,
"" "","" "", 0, 0, 0, 0 ,
ESTOQUE.DAT_ULT_ENTRADA, ESTOQUE.DAT_ULT_SAIDA,
ESTOQUE.DAT_ULT_INVENT
FROM ESTOQUE, ESTOQUE_LOTE, ITEM
WHERE ESTOQUE.COD_EMPRESA = "COD_EMPRESA"
AND ESTOQUE_LOTE.COD_EMPRESA = "COD_EMPRESA"
AND ESTOQUE_LOTE.COD_ITEM = ESTOQUE.COD_ITEM
AND ESTOQUE_LOTE.QTD_SALDO < 0
AND ITEM.COD_EMPRESA = "COD_EMPRESA"
AND ITEM.COD_ITEM = ESTOQUE.COD_ITEM
AND ITEM.IES_CTR_ESTOQUE = "S"
---------------------------------------------------------
SELEÇÃO DAS INFORMAÇÕES (CAMPOS):
- LIB. NORMAL:
DADOS_TELA.QTD_LIBERADA + DADOS_TELA.QTD_LIB_EXCEP +
DADOS_TELA.QTD_REJEITADA + DADOS_TELA.QTD_IMPEDIDA -
DADOS_TELA.QTD_RESERVADA
--------------
- LIB. EXCEP.: AO REALIZAR A INSPECAO NO SUP0570 O USUARIO PODE LIBERAR A
MATERIAL EXEPCIONALMENTE, IRA FICAR NA TABELA ESTOQUE COM ESTA SITUACAO E N
A ESTOQUE_LOTE COM CAMPO IES_SITUA_QTD = "E".
CAMPO QTD_LIBER_EXCEP DA TABELA AVISO_REC COM ESTA QUANTIDADE.
-------------
- REJEITADA:
REJEITA MATERIAL PELO SUP0570, IRA FICAR COM QUANTIDADE NA TABELA ESTOQUE
- CAMPO QTD_REJEITADA, CAMPO IES_SITUA_QTD = "R" DA TABELA ESTOQUE_LOTE, E
NA AVISO_REC IRA FICAR COM A QUANTIDADE REJEITA CAMPO: QTD_REJEIT.
------------
- INSPECAO:
NA TABELA AVISO_REC, CAMPOS COM SITUACAO:
IES_SITUA_AR = I
IES_LIBERACAO_CONT = S
IES_LIBERACAO_INSP = N
TABELA ESTOQUE - CAMPO QTD_IMPEDIDA COM A QUANTIDADE
TABELA ESTOQUE_LOTE - CAMPO IES_SITUA_QTD = I
------------
- RESERVADA:
SOMA DAS RESERVAS AINDA PENDENTES DA TABELA ESTOQUE_LOC_RESER.
------------
- QTD.EM TERCEIROS:
QTD_EM_TERCEIROS + (ITEM_EM_TERC.QTD_TOT_REMESSA -
ITEM_EM_TERC.QTD_TOT_RECEBIDA)

OBS.: Se item com grade e/ou dimensional, considera também tabela sup_itterc_grade.
------------
- QTD.DE TERCEIROS:
SELECT ITEM_DE_TERC.QTD_TOT_RECEBIDA,
ITEM_DE_TERC.QTD_TOT_DEVOLVIDA
FROM ITEM_DE_TERC
WHERE ITEM_DE_TERC.COD_EMPRESA = "COD_EMPRESA"
AND ITEM_DE_TERC.COD_ITEM = "COD_ITEM"
AND ITEM_DE_TERC.QTD_TOT_RECEBIDA <> ITEM_DE_TERC.QTD_TOT_DEVOLVIDA
--
SALDO_DE_TERC = SALDO_DE_TERC + (QTD_TOT_RECEBIDA - QTD_TOT_DEVOLVA)

OBS.: Se item com grade e/ou dimensional, considera também tabela sup_item_terc_end.
-----------
- QTD.PROC.CONTAG:
NA TABELA AVISO_REC CAMPOS COM SITUACAO:
IES_SITUA_AR = C
IES_LIBERACAO_CONT = N
IES_LIBERACAO_INSP = N
IES_ITEM_ESTOQ = S
-----------
- QTD.EM TRANSITO:
SELECT AVISO_REC.QTD_DECLARAD_NF,
AVISO_REC.NUM_OC, AVISO_REC.NUM_AVISO_REC
FROM AVISO_REC, NF_SUP
WHERE AVISO_REC.COD_EMPRESA = "COD_EMPRESA"
AND AVISO_REC.COD_ITEM = "COD_ITEM"
AND AVISO_REC.IES_LIBERACAO_CONT = "N"
AND NF_SUP.COD_EMPRESA = "COD_EMPRESA"
AND NF_SUP.NUM_AVISO_REC = AVISO_REC.NUM_AVISO_REC
AND NF_SUP.IES_NF_AGUARD_NFE = "7"
-QTD_EM_TRANSITO =QTD_EM_TRANSITO + (QTD_CONTAGEM * FAT_CONVER_UNID)
-----------
- QTD. NA EMPRESA:
SE SUP5110-BAIXA DOS ITENS UTILIZADOS = "2"
ENTAO QTD_NA_EMPRESA = DADOS_TELA.QTD_LIBERADA +
DADOS_TELA.QTD_LIB_EXCEP +
DADOS_TELA.QTD_REJEITADA +
DADOS_TELA.QTD_DISP_VENDA +
DADOS_TELA.QTD_IMPEDIDA -
DADOS_TELA.QTD_EM_TERCEIROS
SENAO
SE SUP6200-BAIXA COMPONENTES UTILIZADOS <> "N"
ENTAO QTD_NA_EMPRESA = DADOS_TELA.QTD_LIBERADA +
DADOS_TELA.QTD_LIB_EXCEP +
DADOS_TELA.QTD_REJEITADA +
DADOS_TELA.QTD_DISP_VENDA +
DADOS_TELA.QTD_IMPEDIDA
SENAO QTD_NA_EMPRESA = P_DADOS_TELA.QTD_LIBERADA +
DADOS_TELA.QTD_LIB_EXCEP +
DADOS_TELA.QTD_REJEITADA +
DADOS_TELA.QTD_DISP_VENDA +
DADOS_TELA.QTD_IMPEDIDA -
DADOS_TELA.QTD_EM_TERCEIROS
-----------
- ENTREGA FUTURA:
SELECT (QTD_RECEBIDA - QTD_REGULARIZADA),
NUM_NF,
SER_NF,
SSR_NF,
COD_FORNECEDOR
FROM NF_PEND
WHERE COD_EMPRESA = "COD_EMPRESA"
AND COD_ITEM = "COD_ITEM"
-----------

SELECT el.cod_empresa
       , el.cod_item
       , el.cod_local
       , el.num_lote
       , el.ies_situa_qtd
       , el.qtd_saldo
       , el.num_transac -- = est_trans_relac.num_transac_dest -- e est_trans_relac.num_transac_orig é o número da transação na estoque_trans que gerou esta transação aqui na estoque_lote
  FROM estoque_lote el
;

SELECT *
  FROM est_trans_relac
;

SELECT *

  FROM estoque_trans_end ete

  JOIN estoque_trans et ON et.cod_empresa = ete.cod_empresa AND et.num_transac = ete.num_transac

 WHERE ete.cod_empresa = '99'
   AND ete.identif_estoque = '' -- Identificação de estoque WMS

ORDER BY et.dat_proces DESC, et.hor_operac DESC
;

SELECT *
  FROM estoque_lote_ender ele

  JOIN item i ON i.cod_empresa = ele.cod_empresa AND i.cod_item = ele.cod_item
;

-- -----------------------------------------------------------------------------
-- Consulta de estoque SIMPLES (Qualquer tipo de item)
-- -----------------------------------------------------------------------------

      SELECT *

        FROM estoque

NATURAL JOIN item

       WHERE cod_empresa = '66'
         --AND cod_item = '24B01M02200307'
         AND ies_ctr_estoque = 'S'

    ORDER BY qtd_liberada DESC
;


-- Lotes liberados (e Não reservados)

   SELECT l.*

     FROM estoque_lote l

    WHERE cod_empresa = '99'
      --AND cod_item = '29C01I02200307'
      AND NOT EXISTS ( SELECT cod_empresa, num_lote FROM estoque_loc_reser r WHERE r.cod_empresa = l.cod_empresa AND r.num_lote = l.num_lote )

;

-- -----------------------------------------------------------------------------
-- Consulta de estoque Itens WMS
-- -----------------------------------------------------------------------------

WITH
    itens_wms
  AS
    (
      SELECT i.cod_empresa, i.cod_item

        FROM item i
            -- wms0002 -- Grupos de Controle de estoque que controlam WMS
        JOIN wms_grp_ctr_est g ON g.cod_empresa = i.cod_empresa AND g.grp_ctr_estoque = i.gru_ctr_estoq

       WHERE NOT EXISTS ( SELECT 1
                                  -- wms0003 - Itens exceções controle WMS
                            FROM wms_item_ctr_est e -- Exceções
                           WHERE e.cod_empresa = i.cod_empresa AND  e.cod_item = i.cod_item
                             AND ind_item_ctr_wms = 'N' -- S-Controla WMS, N-Não controla WMS
                        )
    )

      SELECT *

        FROM estoque

NATURAL JOIN itens_wms

ORDER BY qtd_liberada DESC
;
