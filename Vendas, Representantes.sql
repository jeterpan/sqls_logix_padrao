-- Representantes Ativos (que tiveram faturamento nos último 30 dias)

WITH

  representantes_ativos AS (

            SELECT * FROM representante WHERE cod_repres IN (

              SELECT DISTINCT rn.representante
                FROM fat_nf_repr rn   -- Representantes da Nota Fiscal
        NATURAL JOIN fat_nf_mestre nf -- Nota Fiscal Mestre
               WHERE nf.dat_hor_emissao BETWEEN To_Date( SYSDATE - 30, 'DD/MM/RRRR HH24:MI:SS' )
                                            AND To_Date(SYSDATE, 'DD/MM/RRRR HH24:MI:SS')
       )
      )
SELECT *
  FROM representantes_ativos
;
