-- Esta é a consulta feita pelo programa WMS6360
-- Apresenta o que será processado

SELECT
    deposit,
    tip_docum,
    nota_fiscal,
    serie_nota_fiscal,
    pedido,
    trans_solicitacao_carga_mestre
FROM
    wms_solicitacao_carga_mestre
WHERE
    empresa = '99'
    AND sit_solicitacao = '3'

    AND NOT EXISTS (
        ( SELECT DISTINCT
            1
        FROM
            wms_plnjt_embq_solic_carga
            INNER JOIN wms_planejto_embarq ON ( wms_planejto_embarq.empresa = wms_plnjt_embq_solic_carga.empresa
                                                AND wms_planejto_embarq.planejto_embarq = wms_plnjt_embq_solic_carga.planejto_embarq
                                                )
        WHERE
            wms_plnjt_embq_solic_carga.empresa = '99'
            AND wms_plnjt_embq_solic_carga.planejto_embarq = wms_planejto_embarq.planejto_embarq
            AND wms_plnjt_embq_solic_carga.trans_solicitacao_carga_mestre = wms_solicitacao_carga_mestre.trans_solicitacao_carga_mestre
            AND wms_plnjt_embq_solic_carga.sit_fiscal = 'N'
            AND wms_planejto_embarq.sit_planejto_embarq != 'C'
        )
    )
ORDER BY
    nota_fiscal,
    pedido
;




