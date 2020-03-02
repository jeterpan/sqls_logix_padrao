SELECT   empresa
       , planejto_embarq
       , transportador
       , sit_planejto_embarq
       , CASE WHEN sit_planejto_embarq = '1' THEN 'Planejamento'
              WHEN sit_planejto_embarq = '2' THEN 'Aguardando transferência'
              WHEN sit_planejto_embarq = '3' THEN 'Em processo transferência'
              WHEN sit_planejto_embarq = '4' THEN 'Aguardando embarque'
              WHEN sit_planejto_embarq = '5' THEN 'Em Processo de Embarque'
              WHEN sit_planejto_embarq = '6' THEN 'Embarcado'
              WHEN sit_planejto_embarq = '7' THEN 'Aguardando desembarque'
              WHEN sit_planejto_embarq = '8' THEN 'Em processo desembarque'
              WHEN sit_planejto_embarq = '9' THEN 'Desembarcado'
              WHEN sit_planejto_embarq = 'A' THEN 'Encerrado'
              WHEN sit_planejto_embarq = 'B' THEN 'Regime Especial'
              WHEN sit_planejto_embarq = 'C' THEN 'Cancelado'
              WHEN sit_planejto_embarq = 'D' THEN 'Aguardando reconferência'
              WHEN sit_planejto_embarq = 'M' THEN 'Sugestão de mão de obra'
         END AS x_sit_planejto_embarq
       , ctr_ent_sai_veic_docum
       , data_emissao
       , usuario
       , regist_qtd_vol_plnjt_embarque
       , tip_embarque
       , valor_rastreamento
       , num_viagem

  FROM wms_planejto_embarq
;
