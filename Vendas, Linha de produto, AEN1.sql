SELECT
    lpad(cod_lin_prod, 2, '0') cod_lin_prod,
    den_estr_linprod
FROM
    linha_prod   -- Área e Linha de Negócio (AEN) (vdp0340)
WHERE
        -- Filtro: Apenas AEN1
        cod_lin_prod > 0
    AND cod_lin_recei = 0
    AND cod_seg_merc = 0
    AND cod_cla_uso = 0
;
