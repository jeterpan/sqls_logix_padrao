WITH linha_de_produto 
     AS (SELECT Lpad(cod_lin_prod, 2, '0') cod_lin_prod, 
                den_estr_linprod 
         FROM   linha_prod -- Área e Linha de Negócio (AEN) (vdp0340) 
         WHERE  cod_lin_prod > 0 
                AND cod_lin_recei = 0 
                AND cod_seg_merc = 0 
                AND cod_cla_uso = 0), 
     linha_de_receita 
     AS (SELECT ( Lpad(cod_lin_prod, 2, '0') 
                  || Lpad(cod_lin_recei, 2, '0') ) AS cod_lin_recei, 
                den_estr_linprod 
         FROM   linha_prod 
         WHERE  cod_lin_prod > 0 
                AND cod_lin_recei > 0 
                AND cod_seg_merc = 0 
                AND cod_cla_uso = 0), 
     segmento_de_mercado 
     AS (SELECT ( Lpad(cod_lin_prod, 2, '0') 
                  || Lpad(cod_lin_recei, 2, '0') 
                  || Lpad(cod_seg_merc, 2, '0') ) AS cod_seg_merc, 
                den_estr_linprod 
         FROM   linha_prod 
         WHERE  cod_lin_prod > 0 
                AND cod_lin_recei > 0 
                AND cod_seg_merc > 0 
                AND cod_cla_uso = 0), 
     classe_de_uso 
     AS (SELECT ( Lpad(cod_lin_prod, 2, '0') 
                  || Lpad(cod_lin_recei, 2, '0') 
                  || Lpad(cod_seg_merc, 2, '0') 
                  || Lpad(cod_cla_uso, 2, '0') ) AS cod_cla_uso, 
                den_estr_linprod 
         FROM   linha_prod 
         WHERE  cod_lin_prod > 0 
                AND cod_lin_recei > 0 
                AND cod_seg_merc > 0 
                AND cod_cla_uso > 0) 
SELECT i.cod_empresa, 
       i.cod_item, 
       Lpad(i.cod_lin_prod, 2, '0')  AS cod_lin_prod, 
       Lpad(i.cod_lin_recei, 2, '0') AS cod_lin_recei, 
       Lpad(i.cod_seg_merc, 2, '0')  AS cod_seg_merc, 
       Lpad(i.cod_cla_uso, 2, '0')   AS cod_cla_uso, 
       lp.den_estr_linprod           aen1, 
       lr.den_estr_linprod           aen2, 
       sm.den_estr_linprod           aen3, 
       cu.den_estr_linprod           aen4 
FROM   item i 
       left join linha_de_produto lp 
              ON lp.cod_lin_prod = Lpad(i.cod_lin_prod, 2, '0') 
       left join linha_de_receita lr 
              ON lr.cod_lin_recei = Lpad(i.cod_lin_prod, 2, '0') 
                                    || Lpad(i.cod_lin_recei, 2, '0') 
       left join segmento_de_mercado sm 
              ON sm.cod_seg_merc = Lpad(i.cod_lin_prod, 2, '0') 
                                   || Lpad(i.cod_lin_recei, 2, '0') 
                                   || Lpad(i.cod_seg_merc, 2, '0') 
       left join classe_de_uso cu 
              ON cu.cod_cla_uso = Lpad(i.cod_lin_prod, 2, '0') 
                                  || Lpad(i.cod_lin_recei, 2, '0') 
                                  || Lpad(i.cod_seg_merc, 2, '0') 
                                  || Lpad(i.cod_cla_uso, 2, '0') 
WHERE  ( i.cod_empresa, i.cod_item, Lpad(i.cod_lin_prod, 2, '0'), 
                Lpad(i.cod_lin_recei, 2 
                , '0'), 
         Lpad(i.cod_seg_merc, 2, '0'), Lpad(i.cod_cla_uso, 2, '0') 
         , lp.den_estr_linprod 
                , lr.den_estr_linprod, 
         sm.den_estr_linprod, cu.den_estr_linprod ) NOT IN (SELECT 
       cod_empresa, 
       cod_item, 
       cod_lin_prod, 
       cod_lin_recei, 
       cod_seg_merc, 
       cod_cla_uso, 
       aen1, 
       aen2, 
       aen3, 
       aen4 
                                                            FROM   vw_item_aen) 
ORDER  BY i.cod_empresa, 
          i.cod_lin_prod, 
          i.cod_lin_recei, 
          i.cod_cla_uso; 