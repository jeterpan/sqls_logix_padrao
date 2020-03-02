
-- -----------------------------------------------------------------------------
-- log00098 Diretórios de relatórios

--  DIRETÓRIOS GERAIS
--  log00096 Caminhos de diretórios por Empresa
-- -----------------------------------------------------------------------------

SELECT *
  FROM path_logix_v2
;

-- -----------------------------------------------------------------------------
-- log00098 Diretórios de relatórios

--  DIRETÓRIOS GERAIS
--  log00097 Caminhos de diretórios por Sistema
-- -----------------------------------------------------------------------------

SELECT *
  FROM path_logix_v2
 WHERE cod_sistema = 'CAP' -- Char(3); exemplo: CAP
;

-- -----------------------------------------------------------------------------
-- log00098 Diretórios de relatórios

--  DIRETÓRIOS DE USUÁRIOS
--  log00117 Diretórios para relatórios de usuários por Empresa
--  Este cadastro prevalece sobre o cadastro geral de diretório para relatórios
-- -----------------------------------------------------------------------------

SELECT *
  FROM log_usu_dir_relat
 WHERE usuario = '' -- char(8); exemplo jsilva
   AND empresa = '' -- CHAR(2); exemplo 66
;

-- -----------------------------------------------------------------------------
-- log00098 Diretórios de relatórios

--  DIRETÓRIOS DE USUÁRIOS
--  log00097 Caminhos de diretórios por Sistema
-- -----------------------------------------------------------------------------

SELECT *
  FROM log_usu_dir_relat
 WHERE usuario = '' -- CHAR(8); exemplo: jsilva
   AND sistema_fonte = '' -- CHAR(3); exemplo: LST
;

