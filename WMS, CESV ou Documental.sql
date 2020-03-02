-- CESV / Documental
select   empresa
       , ctr_ent_sai_veic_docum -- CESV ou Documental
       , tip_registro
       , CASE WHEN tip_registro = 'D' THEN 'Documental'
              WHEN tip_registro = 'C' THEN 'CESV' -- Nunca usei CESV, então não tenho certeza se o tipo é C
         END AS x_tipo_Registro
       , sit_ctr_ent_sai_veic_docum
       , CASE WHEN sit_ctr_ent_sai_veic_docum = 1 THEN 'Pendente'
              WHEN sit_ctr_ent_sai_veic_docum = 2 THEN 'Aberta'
              WHEN sit_ctr_ent_sai_veic_docum = 3 THEN 'Em Planejamento'
              WHEN sit_ctr_ent_sai_veic_docum = 4 THEN 'Planejada'
              WHEN sit_ctr_ent_sai_veic_docum = 5 THEN 'Ag. Veículo Portaria p/ Entrada'
              WHEN sit_ctr_ent_sai_veic_docum = 6 THEN 'Ag. Veículo Doca'
              WHEN sit_ctr_ent_sai_veic_docum = 7 THEN 'Em Proesso de Descarga'
              WHEN sit_ctr_ent_sai_veic_docum = 8 THEN 'Descarga Finalizada'
              WHEN sit_ctr_ent_sai_veic_docum = 9 THEN 'Ag. Veículo Portaria p/ Saída'
              WHEN sit_ctr_ent_sai_veic_docum = 10 THEN 'Concluída' -- Após ter liberado o caminhão (wms6496), seja para o processo de Recebimento ou Expedição, ela fica como Concluída
              WHEN sit_ctr_ent_sai_veic_docum = 11 THEN 'Bloqueada'
              WHEN sit_ctr_ent_sai_veic_docum = 12 THEN 'Interrompida'
              WHEN sit_ctr_ent_sai_veic_docum = 13 THEN 'Cancelada'
              WHEN sit_ctr_ent_sai_veic_docum = 14 THEN 'Ag. Autoriz. Divergência Horário'
              WHEN sit_ctr_ent_sai_veic_docum = 15 THEN 'Ag. Autoriz. Divergência Motorista'
              WHEN sit_ctr_ent_sai_veic_docum = 16 THEN 'Ag. Autoriz. Divergência Recepção'
              WHEN sit_ctr_ent_sai_veic_docum = 17 THEN 'Em processo de carga'
              WHEN sit_ctr_ent_sai_veic_docum = 18 THEN 'Carga finalizada'
              WHEN sit_ctr_ent_sai_veic_docum = 19 THEN 'Ag. Entrada para estacionamento'
              WHEN sit_ctr_ent_sai_veic_docum = 20 THEN 'Em Estacionamento'
              WHEN sit_ctr_ent_sai_veic_docum = 21 THEN 'Bloqueada por lacre'
         END AS x_sit_cesv
       , tip_ctr_ent_sai_veic_docum
       , CASE WHEN tip_ctr_ent_sai_veic_docum = 'R' THEN 'Recebimento'
              WHEN tip_ctr_ent_sai_veic_docum = 'E' THEN 'Expedicao' 
         END AS x_tipo_CESV
       , transportador
       , placa_veiculo
       , placa_carreta_1
       , placa_carreta_2
       , tip_docum_motorista
       , identif_tip_docum
       , docum_motorista
       , nom_motorista
       , cracha_motorista
       , tip_veiculo
       , devolucao
       , controle_lacre
       , cross_dock
       , dat_inclusao
       , hor_inclusao
       , respons_inclusao
       , carga_solta_paletizada
       , dat_hor_liberacao_entrada
       , respons_liberacao_entrada
       , dat_hor_entrada_portaria
       , respons_entrada_portaria
       , data_hor_saida_portaria
       , resp_liberacao_saida_portaria
       , peso_entrada
       , peso_saida
       , peso_intermediario
       , estado_placa
       , termo_impresso
       , dat_hor_emissao_termo
       , certificado
       , destino_carga
       , num_carga
       , num_agendamento
       , cavalo_mecanico_ausente
       , eh_comboio
       , cesv_docum_mestre

  from wms_ctr_ent_sai_veic_docum
;
