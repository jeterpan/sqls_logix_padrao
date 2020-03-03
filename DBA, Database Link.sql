
DROP DATABASE LINK <nome do database link aqui>
;

CREATE DATABASE LINK <nome do database link aqui>
CONNECT TO usuario IDENTIFIED BY senha
USING '<nome do database link aqui>'
;

SELECT * FROM empresa@<nome do database link aqui>
;
