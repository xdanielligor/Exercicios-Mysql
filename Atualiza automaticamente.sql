create database loja;
use loja;
create table vendas(
	id_vendas int auto_increment primary key,
    id_produto int,
    quantidade int,
    preco_unitario decimal (10,2),
    data_venda date
);
-- Insrindo dados
insert into vendas (id_produto, quantidade, preco_unitario, data_venda)
values
(1,10,20.00, '2024-09-01'),
(2, 5 , 50.00, '2024-09-02'),
(3, 8, 30.00, '2024-09-03'),
(1,4, 20.00, '2024-09-04');

select *from vendas;

-- função para calcular o valor total da venda = (quantidade * preço_unitario)
delimiter $$
	create function calcula_valor_venda (venda_id int)
    returns decimal(10,2)
    deterministic 
    begin
		declare valor_total decimal (10,2);
        select quantidade * preco_unitario
        into valor_total
        from vendas
        where id_vendas = venda_id;
        return valor_total;
        
	end$$
    delimiter ;
    
-- Chamar a função 
select calcula_valor_venda(2) as valor_total;
 
-- Consultar o valor total de todas as vendas
select id_vendas, calcula_valor_venda(id_vendas) as valor_total from vendas;

-- Função que calcula_total_produtos = somatoria de quantidade * preco_unitario
delimiter $$
	create function calcula_total_produto(produto_id int)
    returns decimal (10,2)
	deterministic
	begin
		declare total_vendas decimal(10,2);
        select sum(quantidade * preco_unitario)
        into total_vendas
        from vendas
        where id_produto = produto_id;
        return ifnull(total_vendas, 0);
    
    end $$
    delimiter ;
    
-- chamar função
select calcula_total_produto(1) as total_vendas;

-- consultar o toral de vendas para os produtos
select id_produto, calcula_total_produto(id_produto) as total_vendas 
from (select distinct id_produto from vendas) as ProdutosDistintos;

-- Criar uma função para calcular a media de vendas de um mês
delimiter $$
	create function calcula_media_mes (produto_id int, ano int, mes int)
    returns decimal (10,2)
    deterministic
    begin
		declare media_vendas decimal(10,2);
		select avg(quantidade * preco_unitario)
		into media_vendas
        from vendas
        where id_produto = produto_id
        and YEAR(data_venda) = ano
        and MONTH (data_venda) = mes;
        return ifnull(media_vendas, 0);
    end$$
delimiter ; 

-- chamar a função
select calcula_media_mes (1,2024,9) as media_vendas_produto1;

-- gatilhos (triggers) - automaticamente
select * from vendas;

create table resumovendas(
 id_produto int primary key,
 total_vendas decimal(15,2) default 0
);

select *from resumovendas;
insert into resumovendas (id_produto, total_vendas)
values(1, 0) , (2,0) , (3,0) ;

-- atualizar o total de vendas
delimiter $$
	create trigger after_insert_venda
    AFTER insert on vendas
    for each row
    begin
		update resumovendas
        set total_vendas = total_vendas + NEW.quantidade * NEW.preco_unitario
        where id_produto = NEW.id_produto;
    end
$$ delimiter ;


insert into vendas (id_produto, quantidade, preco_unitario , data_venda) 
values (1,5, 15.00,  '2024-10-23');
select *from resumovendas;

-- evitar venda de produto com estoque insuficiente

create table estoque (
id_produto int primary key,
 quantidade_disponivel int);
 
insert into estoque (id_produto, quantidade_disponivel)
 values (1,50), (2,30) , (3,20);
 
 delimiter $$
	create trigger before_insert_vendas
    before insert on vendas
    for each row
    begin
		declare qtd_disponivel int;
        -- obter a quantidade desponivel do produto
        select quantidade_disponivel 
        into qtd_disponivel
        from estoque
        where id_produto = NEW.id_produto;
        -- verificar se a quantidade disponivel é suficiente
        if qtd_disponivel < NEW.quantidade then
			SIGNAL SQLSTATE '45000'
			set message_text = 'Estoque insuficiente para realizar venda';
        end if;
        update estoque 
        set quantidade_disponivel = quantidade_disponivel - NEW.quantidade
        where id_produto =NEW.id_produto;
    end
 $$ delimiter ;
 
 select * from estoque;
 
insert into vendas (id_produto, quantidade, preco_unitario, data_venda)
values
(3,25,10.00, '2024-10-23');


-- Trigger para registrar log de vendas canceladas, exclusão de registros
-- Criar tabela LOG_cancelamento, cancelar uma venda  que dia foi a venda e que dia canelou

create table logcancelamento(
	id_venda int,
    id_produto int,
    quantidade int,
    preco_unitario decimal(10,2),
    data_venda date,
    data_cancelamento  datetime
);
  delimiter $$
	create trigger after_delete_vendas
	after insert on logcancelamento
    for each row
    begin

  $$ delimiter ;