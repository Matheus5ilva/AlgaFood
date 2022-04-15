CREATE TABLE pedido(
   id SERIAL NOT NULL PRIMARY KEY,
   subtotal decimal(10,2) NOT NULL,
   taxa_frete decimal(10,2) NOT NULL,
   valor_total decimal(10,2) NOT NULL,
   
   restaurante_id BIGINT NOT NULL, 
   usuario_cliente_id BIGINT NOT NULL,
   forma_pagamento_id BIGINT NOT NULL, 
   
   endereco_cidade_id BIGINT NOT NULL, 
   endereco_cep VARCHAR(9) NOT NULL,
   endereco_logradouro VARCHAR(100) NOT NULL,
   endereco_numero VARCHAR(20) NOT NULL,
   endereco_complemento VARCHAR(60) NOT NULL,
   endereco_bairro VARCHAR(60) NOT NULL,
   
   status VARCHAR(9) NOT NULL,
   data_criacao TIMESTAMP NOT NULL,
   data_confirmacao TIMESTAMP NOT NULL,
   data_cancelamento TIMESTAMP NOT NULL,
   data_entrega TIMESTAMP NOT NULL,
   
  constraint fk_pedido_restaurante foreign key (restaurante_id) references restaurante (id),
  constraint fk_pedido_usuario_cliente foreign key (usuario_cliente_id) references usuario (id),
  constraint fk_pedido_forma_pagamento foreign key (forma_pagamento_id) references forma_pagamento (id)
);

create table item_pedido(
	id SERIAL NOT NULL PRIMARY KEY,
	quantidade smallint NOT NULL,
	preco_item decimal(10,2) NOT NULL,
	preco_total decimal(10,2) NOT NULL,
	observacao VARCHAR(255) NOT NULL,
	pedido_id BIGINT NOT NULL,
	produto_id BIGINT NOT NULL,
	
	constraint fk_item_pedido_pedido foreign key (pedido_id) references pedido (id),
    constraint fk_item_pedido_produto foreign key (produto_id) references produto (id)
	
);

ALTER TABLE item_pedido
ADD CONSTRAINT uk_item_pedido_produto UNIQUE (pedido_id, produto_id);