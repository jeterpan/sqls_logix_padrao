-- Revisar, pois não está trazendo registros da 66
SELECT
 
          l.*
        , hp.tex_hist
        , hc.tex_hist
        , p.den_conta

  FROM lancamentos l
  
  JOIN hist_padrao hp ON ( hp.cod_empresa = l.cod_empresa AND hp.cod_hist = l.cod_hist )

  JOIN plano_contas p ON ( p.cod_empresa = l.cod_empresa AND p.num_conta = l.num_conta )
  
left JOIN hist_compl hc ON (     hc.cod_empresa = l.cod_empresa 
                               AND hc.num_lanc = l.num_lanc 
                               AND hc.per_contabil = l.per_contabil 
                               AND hc.cod_seg_periodo = l.cod_seg_periodo
                               AND hc.num_lote = l.num_lote
                               AND hc.num_seq_linha = 1 
                             )

WHERE l.cod_empresa = '66'
  AND Trim(l.per_contabil) = '2019'
;
