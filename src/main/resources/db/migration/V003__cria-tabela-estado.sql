CREATE TABLE estado(
   id SERIAL NOT NULL PRIMARY KEY ,
   nome VARCHAR NOT NULL	
);

insert into estado(nome) select distinct nome_estado from cidade;

alter table cidade add column estado_id BIGINT;

update cidade set estado_id = estado.id from estado where estado.nome = nome_estado;

alter table cidade add constraint fk_cidade_estado foreign key(estado_id) references estado(id);

alter table cidade drop column nome_estado; 

alter table cidade RENAME nome_cidade to nome ;