select a.cod_empresa,
       a.den_sistema_ger, a.per_contabil, a.cod_seg_periodo,
       a.num_lote, a.num_lanc, a.num_conta,
       case when ies_sit_lanc = 'N' then a.val_lanc else a.val_lanc * -1 end  as val_lanc_deb,
       0 as val_lanc_cre, a.ies_tip_lanc,
       a.cod_lin_prod, a.cod_lin_recei, a.cod_seg_merc,
       a.cod_cla_uso,a.ies_sit_lanc,  b.tex_hist, nom_usuario, dat_movto
 from lancamentos a
 left join hist_compl b
   on a.cod_empresa 	= b.cod_empresa
  and a.den_sistema_ger = b.den_sistema_ger and a.per_contabil 	= b.per_contabil
  and a.cod_seg_periodo = b.cod_seg_periodo  and a.num_lote 	= b.num_lote
  and a.num_lanc 	= b.num_lanc and b.num_seq_linha = 1
 where a.cod_empresa in ( '01', '05', '07')
   and a.per_contabil = 2019 
   and a.cod_moeda = 1  
   and a.ies_tip_lanc in ( 'C', 'D')
   --and substr(num_conta,1,1) in ( '1', '2', '3' ) 
   and a.dat_movto between mdy(1,1,2019) and mdy(12,31,2019)
   and a.ies_sit_lanc <> 'R'
