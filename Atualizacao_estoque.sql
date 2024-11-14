create database loja;
use loja;

create table vendas(
	id_venda int auto_increment primary key,
    id_produto int,
    quantidade int,
    preco_unitario decimal(10,2),
    data_venda date
);

-- inserir registros
insert into vendas(id_produto, quantidade, preco_unitario, data_venda)
values
(1, 10, 20.00, '2024-09-01'),
(2, 5, 50.00, '2024-09-02'),
(3, 8, 30.00, '2024-09-03'),
(1, 4, 20.00, '2024-09-04');

select * from vendas;

-- Função para calcular o valor da venda = (Quantidade * preco_unitario)
delimiter $$ 
	create function calcula_valor_venda (venda_id int)
    returns decimal(10,2)
    deterministic
    begin
		declare valor_total decimal(10,2);
        select quantidade * preco_unitario
        into valor_total
        from vendas
        where id_venda = venda_id;
        return valor_total;
	end$$ 
delimiter ;
-- Executar/chamar a função 
select calcula_valor_venda(1) as valor_total;
-- Consultar o valor total de todas as vendas 
select id_venda, calcula_valor_venda(id_venda) as valor_total from vendas;

-- Função que calcula o total de produto = somatoria de quantidade * preco_unitario
delimiter $$
	create function calcula_total_produto(produto_id int)
    returns decimal(10,2)
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
-- Chamar a função 
select calcula_total_produto(1) as total_vendas;
-- consultar o total de vendas para todos os produtos
select id_produto, calcula_total_produto(id_produto) as total_vendas
from (select distinct id_produto from vendas) as ProdutosDistintos;

-- Criar uma função para calcular a média de vendas
delimiter $$
	create function calcula_media_mes(produto_id int, ano int, mes int)
    returns decimal(10,2)
    deterministic 
    begin
		declare media_vendas decimal(10,2);
        select avg(quantidade * preco_unitario)
        into media_vendas
        from vendas 
        where id_produto = produto_id 
        and year(data_venda) = ano
        and month(data_venda) = mes;
        return ifnull(media_vendas, 0);
	end $$
delimiter ;
-- Chamar Função 
select calcula_media_mes(1, 2024, 9) as media_vendas_produto1;

-- Gatilhos (triggers) - automaticamente
use loja;
select * from vendas;
 
 create table resumovendas(
	id_produto int primary key,
    total_vendas decimal(15,2) default 0
);
select * from resumovendas;
insert into resumovendas(id_produto, total_vendas)
values(1, 0), (2, 0), (3, 0);

-- atualizar o total vendas
delimiter $$ 
	create trigger after_insert_venda
    after insert on vendas
    for each row 
    begin
		update resumovendas
        set total_vendas = total_vendas + new.quantidade * new.preco_unitario
        where id_produto = new.id_produto;
    end
$$ delimiter ;

drop trigger after_insert_venda;

select * from vendas;

select * from resumovendas;

insert into vendas(id_produto, quantidade, preco_unitario, data_venda)
values(2, 20, 15.00, '2024-10-23');

-- evitar venda de produto com estoque insuficiente 
create table estoque(
	id_produto int primary key,
    quantidade_disponivel int
    );
    
insert into estoque(id_produto, quantidade_disponivel)	
values(1, 50), (2, 30), (3, 20);

select * from estoque;

delimiter $$
	create trigger before_insert_vendas
    before insert on vendas 
    for each row 
    begin 
		declare qtd_disponivel int ;
        -- obter a quantidade disponivel do produto 
        select quantidade_disponivel
        into qtd_disponivel 
        from estoque 
        where id_produto = new.id_produto;
        -- verificar se a quantidade disponivel é suficiente 
        if qtd_disponivel < new.quantidade then
			SIGNAL SQLSTATE '45000'
			set message_text = 'Estoque insuficiente para realizar venda';
		end if;
		update estoque
        set quantidade_disponivel = quantidade_disponivel - new.quantidade
        where id_produto = new.id_produto;
    end
$$ delimiter ;

insert into vendas(id_produto, quantidade, preco_unitario, data_venda)
values(3, 25, 10.00, '2024-10-23');

-- trigger para registrar log de vendas canceladas
create table logcancelamento(
	id_venda int,
	id_produto int,
	quantidade int,
    preco_unitario decimal(10,2),
    data_venda date,
    data_cancelamento datetime default current_timestamp
        
);



select * from logcancelamento;
delimiter $$
create trigger after_delete_vendas
AFTER delete on vendas
for each row
begin
insert into logcancelamento(id_venda, id_produto, quantidade, preco_unitario, data_venda)
values(old.id_venda, old.id_produto, old.quantidade, old.preco_unitario, old.data_venda);
end
$$ delimiter ;
delete from vendas where id_venda = 3;

select * from logcancelamento;

select * from vendas;

select * from estoque;

-- criar uma nova trigger para devolver a quantidade para o estoque 
-- ao excluir uma venda, devolver a quantidade de produtos ao estoque.

delimiter $$
create trigger after_delete_vendas_restaurar_estoque
after delete on vendas
for each row 
begin 
	-- devolver a quantidade dos produtos ao estoque após exclusão da venda 
    update estoque 
    set quantidade_disponivel = quantidade_disponivel + OLD.quantidade 
    where id_produto = OLD.id_produto;
    
end;  
$$ delimiter ;

-- Trigger para não permitir vendas em datas férias da empresa

create table feriados(
	data_feriado DATE primary key,
    descricao varchar(100)
);

-- inserir feriados 
insert into feriados (data_feriado, descricao)
values('2024-12-25', 'Natal'), ('2024-01-01', 'Ano Novo');

select * from feriados;

delimiter $$
	create trigger before_insert_vendas_feriados
    before insert on vendas
    for each row
    begin
		declare existe_feriado int;
        -- verificar se a data da venda é um feriado
        select count(*)into existe_feriado
        from feriados 
        where data_feriado = NEW.data_venda;
        -- impedir a venda se for feriado 
        if existe_feriado > 0 then
        -- postar uma mensagem
        SIGNAL SQLSTATE '45000'
        set message_text = 'Venda não permitida em feriados!';
    end if;
end;
$$ delimiter ;

insert into vendas(id_produto, quantidade, preco_unitario, data_venda) values(3, 20, 10.00, '2024-12-25');


