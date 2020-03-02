WITH linha_de_produto AS
  (SELECT lpad(cod_lin_prod, 2, '0') cod_lin_prod,
          den_estr_linprod
   FROM linha_prod -- Área e Linha de Negócio (AEN) (vdp0340)

   WHERE cod_lin_prod > 0
     AND cod_lin_recei = 0
     AND cod_seg_merc = 0
     AND cod_cla_uso = 0 ),
     linha_de_receita AS
  (SELECT (lpad(cod_lin_prod, 2, '0') || lpad(cod_lin_recei, 2, '0')) AS cod_lin_recei,
          den_estr_linprod
   FROM linha_prod
   WHERE cod_lin_prod > 0
     AND cod_lin_recei > 0
     AND cod_seg_merc = 0
     AND cod_cla_uso = 0 ),
     segmento_de_mercado AS
  (SELECT (lpad(cod_lin_prod, 2, '0') || lpad(cod_lin_recei, 2, '0') || lpad(cod_seg_merc, 2, '0')) AS cod_seg_merc,
          den_estr_linprod
   FROM linha_prod
   WHERE cod_lin_prod > 0
     AND cod_lin_recei > 0
     AND cod_seg_merc > 0
     AND cod_cla_uso = 0 ),
     classe_de_uso AS
  (SELECT (lpad(cod_lin_prod, 2, '0') || lpad(cod_lin_recei, 2, '0') || lpad(cod_seg_merc, 2, '0') || lpad(cod_cla_uso, 2, '0')) AS cod_cla_uso,
          den_estr_linprod
   FROM linha_prod
   WHERE cod_lin_prod > 0
     AND cod_lin_recei > 0
     AND cod_seg_merc > 0
     AND cod_cla_uso > 0 )
SELECT i.cod_empresa,
       i.cod_item,
       lpad(i.cod_lin_prod, 2, '0') AS cod_lin_prod,
       lpad(i.cod_lin_recei, 2, '0') AS cod_lin_recei,
       lpad(i.cod_seg_merc, 2, '0') AS cod_seg_merc,
       lpad(i.cod_cla_uso, 2, '0') AS cod_cla_uso,
       lp.den_estr_linprod aen1,
       lr.den_estr_linprod aen2,
       sm.den_estr_linprod aen3,
       cu.den_estr_linprod aen4
FROM item i
LEFT JOIN linha_de_produto lp ON lp.cod_lin_prod = lpad(i.cod_lin_prod, 2, '0')
LEFT JOIN linha_de_receita lr ON lr.cod_lin_recei = lpad(i.cod_lin_prod, 2, '0') || lpad(i.cod_lin_recei, 2, '0')
LEFT JOIN segmento_de_mercado sm ON sm.cod_seg_merc = lpad(i.cod_lin_prod, 2, '0') || lpad(i.cod_lin_recei, 2, '0') || lpad(i.cod_seg_merc, 2, '0')
LEFT JOIN classe_de_uso cu ON cu.cod_cla_uso = lpad(i.cod_lin_prod, 2, '0') || lpad(i.cod_lin_recei, 2, '0') || lpad(i.cod_seg_merc, 2, '0') || lpad(i.cod_cla_uso, 2, '0')
ORDER BY i.cod_empresa,
         i.cod_lin_prod,
         i.cod_lin_recei,
         i.cod_cla_uso;
