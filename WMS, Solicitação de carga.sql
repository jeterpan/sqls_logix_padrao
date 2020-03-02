SELECT   empresa
       , trans_solicitacao_carga_mestre
       , deposit, tip_docum
       , sit_solicitacao
       , CASE
            WHEN sit_solicitacao = 'A' THEN 'Acolhido'                    -- Solicitação de carga incluída com sucesso.
            WHEN sit_solicitacao = 'I' THEN 'Inconsistente'               -- Houve alguma inconsistência na inclusão da solicitação.
            WHEN sit_solicitacao = 'L' THEN 'Plano gerado'                -- após processado o plano separação no WMS60001.
            WHEN sit_solicitacao = 'O' THEN 'Onda gerada'                 -- após processada a onda de separação no WMS60001.
            WHEN sit_solicitacao = 'S' THEN 'Em separação'                -- iniciado o processo de separação.
            WHEN sit_solicitacao = 'F' THEN 'Conferência'                 -- finalizado o processo de separação e está apto à conferência ou está com a conferência em andamento.
            WHEN sit_solicitacao = 'P' THEN 'Pesagem'                     -- caso gere pesagem no armazém.
            WHEN sit_solicitacao = 'N' THEN 'Aguardando NF'               -- após finalizada a conferência enquanto não é vinculado nenhum plano de embarque  N para quando é informado Nota Fiscal no WMS6325.
            WHEN sit_solicitacao = 'X' THEN 'Aguardando expedição'        -- após finalizada a conferência enquanto não é vinculado nenhum plano de embarque  N para quando é informado Pedido no WMS6325.
            WHEN sit_solicitacao = 'Q' THEN 'Embarque iniciado'           -- após feita iniciado o embarque no WMS6370.
            WHEN sit_solicitacao = 'Z' THEN 'Embarque finalizado'         -- após finalizado o embarque no WMS6370.
            WHEN sit_solicitacao = 'U' THEN 'Aguardando desembarque'      -- após a exclusão documento no WMS6255 e gerados os movimentos de desembarque.
            WHEN sit_solicitacao = 'E' THEN 'Expedido'                    -- processo de expedição concluído  após a liberação do veículo no WMS6197 e feita a baixa de estoque.
            WHEN sit_solicitacao = 'C' THEN 'Cancelada'                   -- efetuado o cancelamento completo da solicitação.
            WHEN sit_solicitacao = 'B' THEN 'Bloqueada'                   -- permanece nesta situação enquanto a solicitação de carga está em alteração.
            WHEN sit_solicitacao = 'M' THEN 'Na central do planejador'    -- permanece nesta situação enquanto as atividades são alocadas no WMS6430
            WHEN sit_solicitacao = 'V' THEN 'Aguardando veíc doca'        -- permanece neste situação enquanto aguarda o veículo entrar no armazém e iniciar o embarque.
            WHEN sit_solicitacao = '2' THEN 'Solic devolvida VDP'         -- Quando implantado o módulo de WMS, o fluxo de armazenagem passa a ser controlado por este módulo. No entanto, há situações onde não queremos que ele controle este fluxo e podemos devolver o processo para o módulo de VDP continuar controlando. Exemplo: Se excluirmos uma Solicitação de faturamento que foi incluída via programas do WMS e incluirmos ela manualmente no vdp0742, ela não será considerada mais que é do fluxo de processo WMS, ela será considerada como: Devolvida ao VDP (é possível consultar isso no vdp0752, campo Origem: Creio que O é ref a OM (que é proveniente do VDP) e creio que estará W ali quando o processo estiver na responsabilidade do WMS
            WHEN sit_solicitacao = '3' THEN 'Aguardando baixa estoque'    -- permanece nesta situação caso esteja parametrizado baixa de estoque posterior no contrato do depositante ou ocorreu algum erro na baixa de estoque no WMS6197  neste caso o documento fica pendente para baixa de estoque no WMS6360.
            WHEN sit_solicitacao = '4' THEN 'Baixado estoque'             --
       END AS x_sit_solicitacao

       , aprovacao_fiscal_obr
       , nota_fiscal
       , serie_nota_fiscal
       , cfop
       , pedido
       , dat_inclusao
       , dat_emissao
       , dat_agendnto_inicial
       , dat_agendnto_fim
       , pedido_urgent
       , retirad_cliente
       , transportador
       , redespac
       , num_viagem
       , peso_liquido
       , peso_bruto
       , qtd_volume
       , val_docum
       , val_mercadoria
       , val_base_ipi
       , val_ipi
       , val_frete
       , val_seguro
       , val_outra_desp_acessoria
       , val_base_icms
       , val_icms
       , val_base_icms_subst
       , val_icms_subst
       , conhecimento_transporte
       , filial_transportadora
       , sequencial_embarq
       , ord_montag
       , selecao_manual
       , etiqueta_volume_impressa
       , integracao_tms_wms
       , destinatario
       , seql_endereco_destinatario
       , separacao_direta_veiculo
       , trans_importacao
       , permt_ini_confer_ant_finl_sepr
       , permt_ini_pesg_ant_finl_confer
       , permt_ini_emb_ant_fin_conf_pes
       , rastreada
       , obriga_volume_etiquetado
       , especie_volume
       , val_desconto_merc

  FROM wms_solicitacao_carga_mestre
;
