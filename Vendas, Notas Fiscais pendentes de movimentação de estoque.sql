
/*
 vdp0771 - Notas Fiscais Pendentes de movimentação de estoque

 No Logix é possível parametrizar para a baixa do estoque não ser online (batch) (raramente utilizado).

 Se estiver parametrizado para online então nesta consulta são apresentadas
 - Notas Fiscais canceladas
 - Notas Fiscais que usaram Natureza de Operação que estão relacionadas a operações de estoque que não movimenta estoque
 - Pendências de movimentação de estoque devido não ter ainda a liberação do embarque WMS (wms6496)

 Este programa permite também forçar a movimentação de estoque (no caso, batch) do que ainda está pendente
  Não sei o que este programa faria com relação aos casos em que falta liberação de embarque wms
  (imagino que a liberacao do embarque segue a mesma linha de pensamento do faturamento, se está configurado para online a baixa, então vai baixar online tão logo tiver a liberacao de embarque)
*/


SELECT UNIQUE
    'N',
    fat_nf_mestre.trans_nota_fiscal,
    fat_nf_mestre.sit_nota_fiscal,
    fat_nf_mestre.nota_fiscal,
    fat_nf_mestre.serie_nota_fiscal,
    fat_nf_mestre.subserie_nf,
    fat_nf_mestre.espc_nota_fiscal,
    fat_nf_mestre.tip_nota_fiscal,
    fat_nf_mestre.dat_hor_emissao
FROM
    fat_nf_mestre,
    fat_nf_integr
WHERE
    fat_nf_mestre.empresa = '99'
    AND fat_nf_mestre.dat_hor_emissao >= '01/06/2019'
    AND fat_nf_mestre.dat_hor_emissao < '22/06/2019'
    AND fat_nf_integr.status_intg_est IN (
        'P',
        'E'
    )
    AND fat_nf_integr.empresa = fat_nf_mestre.empresa
    AND fat_nf_integr.trans_nota_fiscal = fat_nf_mestre.trans_nota_fiscal
    AND fat_nf_integr.sit_nota_fiscal = fat_nf_mestre.sit_nota_fiscal
ORDER BY
    fat_nf_mestre.serie_nota_fiscal,
    fat_nf_mestre.subserie_nf,
    fat_nf_mestre.nota_fiscal
;
