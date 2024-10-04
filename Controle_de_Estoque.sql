create database controle_de_estoque;

use controle_de_estoque;
-- /Criações de tabela e relacionamentos/

create table  if not exists Produtos(
  idProdutos int not null auto_increment,
  nome varchar(100),
  descricao varchar(50),
  preco decimal(10,2),
  quantEstoque int,
  fk_Fornecedores int,
  primary key(idProdutos)
);

 create table if not exists Fornecedores(
	idFornecedores int not null auto_increment,
	nome varchar(100),
    endereco varchar(225),
    telefone varchar(20),
    email varchar(100),
    primary key(idFornecedores)
 );
 
 create table if not exists Clientes(
  idClientes int not null auto_increment,
  nome varchar(100),
  telefone varchar(20),
  email varchar(100),
  endereço varchar(225),
  primary key(idClientes)
 );
 
 create table if not exists MovimentacaoEstoque(
	idMovimentacaoEstoque int not null auto_increment,
	dat date,
	descricao varchar(50),
	quant int,
    fk_Produtos int,
    fk_Pedidos int,
    primary key (idMovimentacaoEstoque)
    );

create table if not exists Pedidos(
	idPedidos int not null auto_increment,
    estatus varchar(45),
    fk_Clientes int,
    primary key(idPedidos)
);


create table if not exists ItensPedidos(
	idItensPedidos int not null auto_increment,
    quant int,
    fk_Pedidos int,
    fk_Produtos int,
    precoUnitario decimal(10,2),
    primary key(idItensPedidos)
);


-- /Inserindo chaves Estrangeiras/
Alter table Produtos 
Add foreign key (fk_Fornecedores) references Fornecedores(idfornecedores);

Alter table MovimentacaoEstoque 
Add foreign key (fk_Produtos) references Produtos(idProdutos),
Add foreign key (fk_Pedidos) references Pedidos(idPedidos);

Alter table Pedidos
Add foreign key (fk_Clientes) references Clientes(idClientes);

Alter table ItensPedidos
Add foreign key (fk_Pedidos) references Pedidos(idPedidos),
Add foreign key (fk_Produtos) references Produtos(idProdutos);

-- /Adicionando Valores/
insert into Fornecedores (nome, endereco, telefone, email) values 
('Distribuidora Global Ltda', 'Rua das Flores, 123', '(11) 98765-4321', 'contato@global.com'),
('Mercado Central Importações', 'Av. Central, 456', '(21) 99876-5432', 'vendas@mercadocentral.com'),
('Alfa Comércio de Produtos', 'Rua Alfa, 789', '(31) 91234-5678', 'alfa@comerciodeprodutos.com'),
('Beta Fornecimentos Ltda', 'Av. Beta, 101', '(41) 93456-7890', 'suporte@beta.com'),
('Gamma Suprimentos Industriais', 'Rua Gamma, 202', '(51) 92345-6789', 'contato@gamma.com'),
('Delta Produtos Alimentícios', 'Av. Delta, 303', '(61) 94567-8901', 'delta@alimenticios.com'),
('Epsilon Tecnologia e Equipamentos', 'Rua Epsilon, 404', '(71) 95678-9012', 'epsilon@tecnologia.com'),
('Omega Materiais de Construção', 'Av. Omega, 505', '(81) 96789-0123', 'vendas@omegaconstrucoes.com'),
('Sigma Fornecedora de Insumos', 'Rua Sigma, 606', '(91) 97890-1234', 'sigma@fornecedora.com'),
('Kappa Distribuição e Logística', 'Av. Kappa, 707', '(11) 98901-2345', 'kappa@distribuicao.com'),
('Lambida Distribuidora', 'Rua Laranja, 808', '(11) 99012-3456', 'contato@lambidadistribuidora.com'),
('Zeta Importações Ltda', 'Av. Zeta, 909', '(21) 98123-4567', 'vendas@zetaltda.com'),
('Theta Suprimentos Gerais', 'Rua Theta, 1010', '(31) 99234-5678', 'suporte@thetasuprimentos.com'),
('Iota Materiais e Equipamentos', 'Av. Iota, 1111', '(41) 99345-6789', 'iota@materiais.com'),
('Lambda Comércio e Distribuição', 'Rua Lambda, 1212', '(51) 99456-7890', 'contato@lambdacomercio.com'),
('Mu Produtos Especiais', 'Av. Mu, 1313', '(61) 99567-8901', 'mu@produtosespeciais.com'),
('Nu Comércio Global', 'Rua Nu, 1414', '(71) 99678-9012', 'nu@comercioglobal.com'),
('Xi Suprimentos Técnicos', 'Av. Xi, 1515', '(81) 99789-0123', 'contato@xisuprimentos.com'),
('Omicron Distribuição', 'Rua Omicron, 1616', '(91) 99890-1234', 'vendas@omicrondistribuicao.com'),
('Pi Fornecedora de Equipamentos', 'Av. Pi, 1717', '(11) 99901-2345', 'pi@fornecedoraequip.com');

insert into Produtos (nome, descricao, preco, quantEstoque, fk_Fornecedores) values
('Caneta Esferográfica Azul', 'Caneta azul de escrita suave', 1.50, 500, 1),
('Papel Sulfite A4 500 folhas', 'Papel branco, tamanho A4, pacote com 500 folhas', 15.90, 300, 2),
('Caderno Universitário 200 folhas', 'Caderno espiral com capa dura', 12.00, 150, 3),
('Grampeador de Mesa', 'Grampeador de metal resistente', 25.00, 100, 4),
('Toner para Impressora Laser', 'Toner preto compatível com várias marcas', 199.90, 50, 5),
('Calculadora Científica', 'Calculadora com funções científicas avançadas', 79.90, 75, 6),
('Mouse Sem Fio', 'Mouse ergonômico com conexão USB', 39.90, 200, 7),
('Teclado Mecânico', 'Teclado com iluminação RGB e teclas mecânicas', 299.90, 120, 8),
('Monitor LED 24 polegadas', 'Monitor Full HD com ajuste de altura', 899.90, 50, 9),
('HD Externo 1TB', 'Disco rígido externo com conexão USB 3.0', 349.90, 70, 10),
('Pendrive 32GB', 'Pendrive com conexão USB 3.0', 29.90, 400, 1),
('Agenda Executiva 2024', 'Agenda de couro com espaço para anotações diárias', 49.90, 80, 2),
('Mochila para Notebook 15.6 polegadas', 'Mochila resistente com várias divisórias', 129.90, 60, 3),
('Carregador Portátil 10.000mAh', 'Power bank com duas portas USB', 99.90, 90, 4),
('Fone de Ouvido Bluetooth', 'Fone de ouvido sem fio com microfone', 149.90, 120, 5),
('Impressora Multifuncional', 'Impressora com scanner e copiadora integrada', 799.90, 40, 6),
('Caixa de Som Bluetooth', 'Caixa de som portátil com conexão Bluetooth', 89.90, 150, 7),
('Mesa Digitalizadora', 'Mesa digitalizadora para desenho gráfico', 499.90, 30, 8),
('Cabo HDMI 2 metros', 'Cabo HDMI de alta velocidade', 24.90, 300, 9),
('Webcam Full HD', 'Webcam com resolução 1080p e microfone embutido', 199.90, 100, 10);

insert into Clientes (nome, telefone, email, endereço) values
('Ana Silva', '(11) 98765-4321', 'ana.silva@example.com', 'Rua das Acácias, 123'),
('Bruno Souza', '(21) 99876-5432', 'bruno.souza@example.com', 'Av. Paulista, 456'),
('Carlos Pereira', '(31) 91234-5678', 'carlos.pereira@example.com', 'Rua Minas Gerais, 789'),
('Daniela Oliveira', '(41) 93456-7890', 'daniela.oliveira@example.com', 'Av. Paraná, 101'),
('Eduardo Fernandes', '(51) 92345-6789', 'eduardo.fernandes@example.com', 'Rua das Flores, 202'),
('Fernanda Costa', '(61) 94567-8901', 'fernanda.costa@example.com', 'Av. Brasília, 303'),
('Gabriel Almeida', '(71) 95678-9012', 'gabriel.almeida@example.com', 'Rua Bahia, 404'),
('Helena Santos', '(81) 96789-0123', 'helena.santos@example.com', 'Av. Recife, 505'),
('Igor Rodrigues', '(91) 97890-1234', 'igor.rodrigues@example.com', 'Rua Pará, 606'),
('Juliana Castro', '(11) 98901-2345', 'juliana.castro@example.com', 'Av. São Paulo, 707'),
('Leonardo Lima', '(21) 98123-4567', 'leonardo.lima@example.com', 'Rua Rio de Janeiro, 808'),
('Mariana Ribeiro', '(31) 99234-5678', 'mariana.ribeiro@example.com', 'Av. Belo Horizonte, 909'),
('Nicolas Araújo', '(41) 99345-6789', 'nicolas.araujo@example.com', 'Rua Curitiba, 1010'),
('Olivia Martins', '(51) 99456-7890', 'olivia.martins@example.com', 'Av. Porto Alegre, 1111'),
('Pedro Carvalho', '(61) 99567-8901', 'pedro.carvalho@example.com', 'Rua Goiânia, 1212'),
('Quésia Ferreira', '(71) 99678-9012', 'quesia.ferreira@example.com', 'Av. Salvador, 1313'),
('Rafael Mendes', '(81) 99789-0123', 'rafael.mendes@example.com', 'Rua Recife, 1414'),
('Sofia Gonçalves', '(91) 99890-1234', 'sofia.goncalves@example.com', 'Av. Belém, 1515'),
('Thiago Batista', '(11) 99901-2345', 'thiago.batista@example.com', 'Rua Santos, 1616'),
('Ursula Macedo', '(21) 98012-3456', 'ursula.macedo@example.com', 'Av. Fortaleza, 1717');

insert into Pedidos (estatus, fk_Clientes) values
('Pendente', 1),
('Concluido', 1),
('Concluido', 1),
('Concluído', 2),
('Cancelado', 3),
('Pendente', 4),
('Concluído', 5),
('Pendente', 6),
('Concluído', 7),
('Cancelado', 8),
('Pendente', 9),
('Concluído', 10),
('Pendente', 11),
('Concluído', 12),
('Cancelado', 13),
('Pendente', 14),
('Concluído', 15),
('Pendente', 16),
('Concluído', 17),
('Cancelado', 18),
('Pendente', 19),
('Concluído', 20);

insert into ItensPedidos (quant, fk_Pedidos, fk_Produtos, precoUnitario) values
(2, 1, 1, 1.50),     -- 2 unidades de "Caneta Esferográfica Azul" no Pedido 1
(1, 1, 2, 15.90),    -- 1 unidade de "Papel Sulfite A4 500 folhas" no Pedido 1
(3, 2, 3, 12.00),    -- 3 unidades de "Caderno Universitário 200 folhas" no Pedido 2
(1, 2, 4, 25.00),    -- 1 unidade de "Grampeador de Mesa" no Pedido 2
(5, 3, 5, 199.90),   -- 5 unidades de "Toner para Impressora Laser" no Pedido 3
(2, 4, 6, 79.90),    -- 2 unidades de "Calculadora Científica" no Pedido 4
(4, 4, 7, 39.90),    -- 4 unidades de "Mouse Sem Fio" no Pedido 4
(1, 5, 8, 299.90),   -- 1 unidade de "Teclado Mecânico" no Pedido 5
(2, 6, 9, 899.90),   -- 2 unidades de "Monitor LED 24 polegadas" no Pedido 6
(3, 6, 10, 349.90),  -- 3 unidades de "HD Externo 1TB" no Pedido 6
(5, 7, 11, 29.90),   -- 5 unidades de "Pendrive 32GB" no Pedido 7
(2, 8, 12, 49.90),   -- 2 unidades de "Agenda Executiva 2024" no Pedido 8
(1, 8, 13, 129.90),  -- 1 unidade de "Mochila para Notebook 15.6 polegadas" no Pedido 8
(4, 9, 14, 99.90),   -- 4 unidades de "Carregador Portátil 10.000mAh" no Pedido 9
(3, 10, 15, 149.90), -- 3 unidades de "Fone de Ouvido Bluetooth" no Pedido 10
(2, 11, 16, 799.90), -- 2 unidades de "Impressora Multifuncional" no Pedido 11
(1, 12, 17, 89.90),  -- 1 unidade de "Caixa de Som Bluetooth" no Pedido 12
(5, 13, 18, 499.90), -- 5 unidades de "Mesa Digitalizadora" no Pedido 13
(3, 14, 19, 24.90),  -- 3 unidades de "Cabo HDMI 2 metros" no Pedido 14
(2, 15, 20, 199.90); -- 2 unidades de "Webcam Full HD" no Pedido 15

insert into MovimentacaoEstoque (dat, descricao, quant, fk_Produtos, fk_Pedidos) values
('2024-09-01', 'Entrada de estoque', 100, 1, NULL),    -- Entrada de 100 unidades do produto 1 (Caneta Esferográfica Azul)
('2024-09-02', 'Saída para pedido', 2, 1, 1),          -- Saída de 2 unidades do produto 1 para o pedido 1
('2024-09-03', 'Entrada de estoque', 200, 2, NULL),    -- Entrada de 200 unidades do produto 2 (Papel Sulfite A4 500 folhas)
('2024-09-04', 'Saída para pedido', 1, 2, 1),          -- Saída de 1 unidade do produto 2 para o pedido 1
('2024-09-05', 'Entrada de estoque', 50, 3, NULL),     -- Entrada de 50 unidades do produto 3 (Caderno Universitário 200 folhas)
('2024-09-06', 'Saída para pedido', 3, 3, 2),          -- Saída de 3 unidades do produto 3 para o pedido 2
('2024-09-07', 'Entrada de estoque', 20, 4, NULL),     -- Entrada de 20 unidades do produto 4 (Grampeador de Mesa)
('2024-09-08', 'Saída para pedido', 1, 4, 2),          -- Saída de 1 unidade do produto 4 para o pedido 2
('2024-09-09', 'Entrada de estoque', 30, 5, NULL),     -- Entrada de 30 unidades do produto 5 (Toner para Impressora Laser)
('2024-09-10', 'Saída para pedido', 5, 5, 3),          -- Saída de 5 unidades do produto 5 para o pedido 3
('2024-09-11', 'Entrada de estoque', 60, 6, NULL),     -- Entrada de 60 unidades do produto 6 (Calculadora Científica)
('2024-09-12', 'Saída para pedido', 2, 6, 4),          -- Saída de 2 unidades do produto 6 para o pedido 4
('2024-09-13', 'Entrada de estoque', 100, 7, NULL),    -- Entrada de 100 unidades do produto 7 (Mouse Sem Fio)
('2024-09-14', 'Saída para pedido', 4, 7, 4),          -- Saída de 4 unidades do produto 7 para o pedido 4
('2024-09-15', 'Entrada de estoque', 50, 8, NULL),     -- Entrada de 50 unidades do produto 8 (Teclado Mecânico)
('2024-09-16', 'Saída para pedido', 1, 8, 5),          -- Saída de 1 unidade do produto 8 para o pedido 5
('2024-09-17', 'Entrada de estoque', 40, 9, NULL),     -- Entrada de 40 unidades do produto 9 (Monitor LED 24 polegadas)
('2024-09-18', 'Saída para pedido', 2, 9, 6),          -- Saída de 2 unidades do produto 9 para o pedido 6
('2024-09-19', 'Entrada de estoque', 80, 10, NULL),    -- Entrada de 80 unidades do produto 10 (HD Externo 1TB)
('2024-09-20', 'Saída para pedido', 3, 10, 6);         -- Saída de 3 unidades do produto 10 para o pedido 6


-- /Querrys/
-- 1. Atualizar a quantidade de estoque após uma movimentação de sáida. 
update Produtos
set quantEstoque = quantEstoque - (select quant from MovimentacaoEstoque where idMovimentacaoEstoque = 4)  -- quantidade do ID 4 é 1
where idProdutos = (select fk_Produtos from MovimentacaoEstoque where idMovimentacaoEstoque = 1);

select *from movimentacaoEstoque;
select *from produtos;

select nome, quantEstoque from Produtos
where idProdutos = 1;


-- 2. Atualizar o preço de um produto.
update Produtos
set preco = 15.99  -- novo preço
where idProdutos = 3;  -- 'Caderno espiral com capa dura', 12.00

select nome, preco from Produtos
where idProdutos = 3 ;


-- 3. Atualizar as informações de contato de um fornecedor.
update Fornecedores
set telefone = '(11) 91234-5678', email = 'novo.email@example.com', endereco = 'Nova Rua, 99' -- novas informações
where idFornecedores = 1;  -- "1" id do fornecedor específico

select telefone, email, endereco from Fornecedores
where idFornecedores = 1;


--  4. Consultar produtos com quantidade abaixo do limite (estoque mínimo).
select min(quantEstoque) from Produtos;  -- Minimo 30 

select nome, quantEstoque from Produtos  -- Nome da Cliente
where quantEstoque = 30;

select * from Produtos
WHERE quantEstoque < 50;  -- substitua "50" pelo limite mínimo desejado


-- 5. Consultar todos os produtos no estoque.
select * from Produtos;


-- 6. Consultar pedidos feitos por um cliente específico.  
select * from Pedidos
where fk_Clientes = 1; 
 
 select p.estatus, c.nome
 from Pedidos p join Clientes c
 on c.idClientes = p.fk_Clientes
 where idClientes = 1;  -- Para saber o nome da cliente coloque o ID.



-- 7. Consultar todos os pedidos de um cliente e listar seus itens
select p.idPedidos, p.estatus, i.idItensPedidos, i.quant, i.precoUnitario, pr.nome 
from Pedidos p join ItensPedidos i 
on p.idPedidos = i.fk_Pedidos
join Produtos pr on i.fk_Produtos = pr.idProdutos
WHERE p.fk_Clientes = 1;     -- Valor total dos Produtos 1079,40


-- 8. Consultar todas as movimentações de estoque de um produto específico. 
select * from MovimentacaoEstoque
where fk_Produtos = 1; 


-- 9. Consultar produtos fornecidos por um fornecedor específico. 
select p.nome, p.descricao, p.preco, p.quantEstoque, f.nome 
from Produtos p join Fornecedores f
on  f.idFornecedores = p.fk_Fornecedores
where idProdutos = 5;  -- ID do fornecedor
  

-- 10. Consultar o total de pedidos feitos por um cliente.  
select c.nome, COUNT(p.idPedidos) as total_pedidos
from Clientes c join Pedidos p 
on c.idClientes = p.fk_Clientes
WHERE c.idClientes = 1;  -- Referenciado ao exercicio 6


-- 11. Consultar o valor total vendido por cliente 
select c.nome, SUM(i.quant * i.precoUnitario) as total_vendido
from Pedidos p join Clientes c 
on p.fk_Clientes = c.idClientes
join ItensPedidos i on p.idPedidos = i.fk_Pedidos
where c.idClientes = 1;    -- referenciado ao exercicio 7 


-- 12. Consultar todos os produtos feitos em um determinado período. 
select P.nome, SUM(ME.quant) as totalVendido, MIN(ME.dat) as primeiraVenda, MAX(ME.dat) as ultimaVenda
from Produtos P
join MovimentacaoEstoque ME on P.idProdutos = ME.fk_Produtos
where ME.descricao = 'Saída para pedido'
and ME.dat between '2024-09-01' and '2024-09-20'
group by P.nome
order by totalVendido desc;


-- 13. Consultar os produtos mais vendidos (quantidade total de saídas). 
select pr.nome, SUM(i.quant) as quantidade_vendida
from ItensPedidos i
join Produtos pr on i.fk_Produtos = pr.idProdutos
group by pr.nome
order by quantidade_vendida desc;


-- 14. Consultar o valor total vendidos em um período específico.
select SUM(IP.quant * IP.precoUnitario) as valorTotalVendido
from ItensPedidos IP
join Pedidos P on IP.fk_Pedidos = P.idPedidos
join MovimentacaoEstoque ME on P.idPedidos = ME.fk_Pedidos
where ME.descricao = 'Saída para pedido'
and ME.dat between '2024-09-01' and '2024-09-07';


-- 15. Consultar os pedidos e respectivos clientes com valor total maior que um limite.
select p.idPedidos, c.nome, SUM(i.quant * i.precoUnitario) AS valor_total
from Pedidos p
join Clientes c on p.fk_Clientes = c.idClientes
join ItensPedidos i on p.idPedidos = i.fk_Pedidos
group by p.idPedidos, c.nome
having valor_total > 500;  -- substitua "500" pelo valor limite desejado


-- 16. Consultar a quantidade total de movimentações de entrada e saída de um produto.  
select pr.nome,
  SUM(case when m.descricao = 'Entrada de estoque' then m.quant else 0 END) as total_entrada,
  SUM(case when m.descricao = 'Saída para pedido' then m.quant else 0 END) as total_saida
from MovimentacaoEstoque m join Produtos pr 
on m.fk_Produtos = pr.idProdutos
where pr.idProdutos = 5  -- substitua "1" pelo id do produto específico
group by pr.nome;


-- 17. Consultar o estoque atual de um produto com base nas movimentações de entrada e saída  
select pr.nome,
  (SUM(case when m.descricao = 'Entrada de estoque' then m.quant else 0 END) -
   SUM(case when m.descricao = 'Saída para pedido' then m.quant else 0 END)) as estoque_atual
FROM MovimentacaoEstoque m
JOIN Produtos pr ON m.fk_Produtos = pr.idProdutos
WHERE pr.idProdutos = 1  -- substitua "1" pelo id do produto específico
GROUP BY pr.nome;


-- 18. Consultar o número total de produtos em estoque para cada fornecedor 
select f.nome, SUM(p.quantEstoque) as total_produtos
from Produtos p join Fornecedores f 
on p.fk_Fornecedores = f.idFornecedores
group by f.nome
;


-- 19. Listar fornecedores que ainda não forneceram nenhum produto.  
select f.nome from Fornecedores f
left join Produtos p on f.idFornecedores = p.fk_Fornecedores
where p.idProdutos is null;




-- 20. Listar produtos com movimentações de saída maiores que um determinado valor 
select pr.nome, SUM(m.quant) as total_saida
from MovimentacaoEstoque m
join Produtos pr on m.fk_Produtos = pr.idProdutos
where m.descricao = 'Saída para pedido'
group by pr.nome
having total_saida >= 3;  -- substitua "3" pelo valor limite desejado



-- 21. Consultar todos os clientes que fizeram pedidos de um determinado produto.  
select distinct c.nome, c.telefone, c.email 
from Clientes c join Pedidos p 
on c.idClientes = p.fk_Clientes
join ItensPedidos ip on p.idPedidos = ip.fk_Pedidos
join Produtos pr on ip.fk_Produtos = pr.idProdutos
where pr.idProdutos = 15; -- Substitua '15' pelo id do produto desejado


-- 22. Consultar todas as movimentações de estoque em um determinado período
select * from MovimentacaoEstoque
where dat between '2024-09-01' and '2024-09-07'; -- Substitua as datas pelo período desejado


-- 23. Consultar a quantidade de produtos fornecidos por cada fornecedor 
select f.nome as Fornecedor, COUNT(p.idProdutos) as total_produtos_fornecidos
from Fornecedores f
join Produtos p on f.idFornecedores = p.fk_Fornecedores
group by f.nome;


-- 24. Calcular o total de um pedido com base nos itens. 
select p.idPedidos, SUM(ip.quant * ip.precoUnitario) as total_pedido
from Pedidos p join ItensPedidos ip 
on p.idPedidos = ip.fk_Pedidos
where p.idPedidos = 10 -- Substitua '10' pelo id do pedido desejado
group by p.idPedidos;



-- 25. Excluir um cliente da base de dados.  
delete from Clientes 
where idClientes = 1; -- Substitua '1' pelo id do cliente a ser excluído


-- 26. Excluir um pedido e seus itens. 
delete from ItensPedidos
where fk_Pedidos = 1; -- Substitua '1' pelo id do pedido a ser excluído

-- Excluir o pedido
DELETE FROM Pedidos
WHERE idPedidos = 1; -- Substitua '1' pelo id do pedido a ser excluído






