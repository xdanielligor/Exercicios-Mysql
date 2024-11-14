create database clinica_medica;
use clinica_medica; 

-- Tabelas principais 

create table Pacientes ( 
    id_paciente int primary key auto_increment, 
    nome varchar(100) not null, 
    data_nascimento date, 
    telefone varchar(15), 
    endereco varchar(200) 
); 

create table Especialidades ( 
    id_especialidade  int primary key auto_increment, 
    descricao varchar(100) not null 
);

create table Medicos ( 
    id_medico  int primary key auto_increment, 
    nome varchar(100) not null, 
    telefone varchar(15), 
    email varchar(100), 
    crm varchar(20) unique, 
    id_especialidade int, 
    foreign key (id_especialidade) references Especialidades(id_especialidade) 
); 

create table Salas ( 
    id_sala  int primary key auto_increment, 
    nome_sala varchar(50) not null 
); 

create table Agendamentos ( 
    id_agendamento int primary key auto_increment, 
    id_paciente int, 
    id_medico int, 
    id_sala int, 
    data_consulta date, 
    hora_consulta time, 
    status varchar (20) default 'Agendado'check (status in ('Agendado', 'Cancelado', 'Realizado')), 
    motivo_cancelamento varchar(200), 
    foreign key (id_paciente) references Pacientes(id_paciente), 
    foreign key (id_medico) references Medicos(id_medico), 
    foreign key (id_sala) references Salas(id_sala), 
    unique (id_sala, data_consulta, hora_consulta), -- Evitar conflito de sala e horário 
    unique (id_medico, data_consulta, hora_consulta) -- Evitar conflito de médico e horário 
); 

create table ConsultasRealizadas ( 
    id_consulta  int primary key auto_increment, 
    id_agendamento INT, 
    diagnostico varchar(500), 
    prescricao varchar(500), 
    observacoes TEXT, 
    foreign key (id_agendamento) references Agendamentos(id_agendamento) 
); 

create table HorariosFuncionamento ( 
    id_horario  int primary key auto_increment, 
    dia_semana varchar(10), -- Ex: 'Segunda', 'Terça' 
    hora_abertura time, 
    hora_fechamento time 
); 


-- Funcionalidades adicionais 

create table Notificacoes ( 
    id_notificacao int primary key auto_increment, 
    id_agendamento int, 
    id_paciente int,  -- Adicionando a coluna id_paciente
    tipo_notificacao varchar(50), 
    mensagem varchar(500), 
    foreign key (id_agendamento) references Agendamentos(id_agendamento),
    foreign key (id_paciente) references Pacientes(id_paciente) -- A referência agora é válida
); 

create table LimiteConsultas ( 
    id_limite int primary key auto_increment, 
    id_paciente int, 
    mes int, 
    ano int,
    total_consultas int default 0, 
    limite int default 5, 
    foreign key (id_paciente) references Pacientes(id_paciente), 
    unique (id_paciente, mes, ano) 
); 

Create table Cancelamentos (
    id_cancelamento int primary key auto_increment,
    id_agendamento int,
    id_paciente int,
    id_medico int,
    id_sala int,
    data_consulta date,
    hora_consulta time,
    motivo_cancelamento varchar(200),
    foreign key (id_agendamento) references Agendamentos(id_agendamento),
    foreign key (id_paciente) references Pacientes(id_paciente),
    foreign key (id_medico) references Medicos(id_medico),
    foreign key (id_sala) references Salas(id_sala)
);

CREATE TABLE PlanosSaude (
    id_plano int primary key auto_increment,
    nome_plano varchar(100) not null, -- Nome do plano de saúde
    tipo_plano varchar(50) not null, -- Tipo do plano (ex: 'Individual', 'Familiar')
    numero_carteirinha varchar(50) unique, -- Número da carteirinha do plano de saúde
    validade date, -- Data de validade do plano
    id_paciente int, -- ID do paciente que está vinculado ao plano
    foreign key (id_paciente) references Pacientes(id_paciente) -- Relacionamento com a tabela Pacientes
);

-- INSERINDO DADOS
-- PACIENTES 
insert into Pacientes (nome, data_nascimento, telefone,  endereco) values 
('Paula Fernandes', '1990-04-15', '11998765431',  'Rua das Flores, 123'), 
('Lucas Almeida', '1985-12-20', '11998765432',  'Av. Brasil, 456'), 
('Maria Souza', '2000-01-30', '11998765433',  'Praça da Sé, 789'), 
('Pedro Gomes', '1995-05-10', '11998765434',  'Rua A, 101'), 
('Julia Santos', '1988-08-25', '11998765435',  'Rua B, 202');

select *from Pacientes;

-- ESPECIALIDADE
INSERT INTO Especialidades (descricao) VALUES 
('Cardiologia'), 
('Pediatria'), 
('Dermatologia'), 
('Ortopedia'), 
('Ginecologia');

select *from Especialidades;

-- MEDICOS
INSERT INTO Medicos (nome, telefone, email, crm, id_especialidade) VALUES 
('Dr. Carlos Silva', '11987654321', 'carlos.silva@clinicamedica.com', 'CRM12345', 1), 
('Dra. Ana Pereira', '11987654322', 'ana.pereira@clinicamedica.com', 'CRM12346', 2), 
('Dr. João Souza', '11987654323', 'joao.souza@clinicamedica.com', 'CRM12347', 3), 
('Dra. Mariana Oliveira', '11987654324', 'mariana.oliveira@clinicamedica.com', 'CRM12348', 4), 
('Dr. Roberto Lima', '11987654325', 'roberto.lima@clinicamedica.com', 'CRM12349', 5);
select *from Medicos;

-- SALAS
INSERT INTO Salas (nome_sala) VALUES 
('Sala 1'), 
('Sala 2'), 
('Sala 3'), 
('Sala 4'), 
('Sala 5');
select *from Salas;

-- AGENDAMENTOS
INSERT INTO Agendamentos (id_paciente, id_medico, id_sala, data_consulta, hora_consulta, status) VALUES 
(1, 1, 1, '2024-11-15', '09:00:00', 'Agendado'), 
(2, 2, 2, '2024-11-15', '10:00:00', 'Realizado'), 
(3, 3, 3, '2024-11-16', '11:00:00', 'Agendado'), 
(4, 4, 4, '2024-11-16', '14:00:00', 'Realizado'), 
(5, 5, 5, '2024-11-17', '15:00:00', 'Agendado');
select *from Agendamentos;

-- CONSULTAS REALIZADAS
INSERT INTO ConsultasRealizadas (id_agendamento, diagnostico, prescricao, observacoes) VALUES 
(2, 'Bronquite infantil', 'Xarope expectorante', 'Prescrito repouso e hidratação'), 
(4, 'Fratura no braço', 'Imobilização com gesso', 'Retorno para nova radiografia em 4 semanas');

select *from ConsultasRealizadas;

-- HORARIO DE FUNCIONAMENTO
INSERT INTO HorariosFuncionamento (dia_semana, hora_abertura, hora_fechamento) VALUES 
('Segunda', '08:00:00', '18:00:00'), 
('Terça', '08:00:00', '18:00:00'), 
('Quarta', '08:00:00', '18:00:00'), 
('Quinta', '08:00:00', '18:00:00'), 
('Sexta', '08:00:00', '18:00:00'), 
('Sábado', '08:00:00', '12:00:00');
select *from HorariosFuncionamento;

-- NOTIFICAÇÕES
INSERT INTO Notificacoes (id_paciente, id_agendamento, tipo_notificacao, mensagem) VALUES 
(1, 1, 'Lembrete', 'Sua consulta está agendada para 15/11/2024 às 09:00'), 
(2, 2, 'Lembrete', 'Sua consulta está agendada para 15/11/2024 às 10:00'), 
(3, 3, 'Confirmação', 'Confirmação de consulta em 16/11/2024 às 11:00'), 
(4, 4, 'Confirmação', 'Confirmação de consulta em 16/11/2024 às 14:00'), 
(5, 5, 'Lembrete', 'Sua consulta está agendada para 17/11/2024 às 15:00');
select *from Notificacoes;


-- LIMITE CONSULTAS
INSERT INTO LimiteConsultas (id_paciente, mes, ano, total_consultas, limite) VALUES 
(1, 11, 2024, 1, 5), 
(2, 11, 2024, 1, 5), 
(3, 11, 2024, 1, 5), 
(4, 11, 2024, 1, 5), 
(5, 11, 2024, 1, 5);
select *from LimiteConsultas;

-- PLANO DE SAUDE 
INSERT INTO PlanosSaude (nome_plano, tipo_plano, numero_carteirinha, validade, id_paciente) VALUES
('Unimed', 'Individual', '1234567890', '2025-12-31', 1),
('Amil', 'Familiar', '0987654321', '2026-06-30', 2),
('Bradesco Saúde', 'Individual', '1122334455', '2024-11-30', 3),
('SulAmérica', 'Familiar', '6677889900', '2027-03-15', 4),
('Porto Seguro Saúde', 'Individual', '5544332211', '2025-08-01', 5);
select *from PlanosSaude;


-- EXERCICIOS TRIGGER 

-- 1 Horário de Funcionamento: Agendamentos só podem ocorrer dentro do horário de funcionamento definido na tabela HorariosFuncionamento.

DELIMITER //
CREATE TRIGGER verificar_horario_agendamento
BEFORE INSERT ON Agendamentos
FOR EACH ROW
BEGIN
    DECLARE dia_semana VARCHAR(10);
    
    -- Determinar o dia da semana (Domingo = 1, Segunda = 2, ..., Sábado = 7)
    SET dia_semana = DAYOFWEEK(NEW.data_consulta);
    
    -- Verificar se é Domingo
    IF dia_semana = 1 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: A clínica não abre aos domingos.';
    
    -- Verificar horário para Sábado (08:00 - 12:00)
    ELSEIF dia_semana = 7 THEN
        IF NEW.hora_consulta < '08:00:00' OR NEW.hora_consulta > '12:00:00' THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Erro: Agendamentos permitidos apenas entre 08:00 e 12:00 aos sábados.';
        END IF;
    
    -- Verificar horário para dias da semana (Segunda a Sexta - 08:00 - 18:00)
    ELSE
        IF NEW.hora_consulta < '08:00:00' OR NEW.hora_consulta > '18:00:00' THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Erro: Agendamentos permitidos apenas entre 08:00 e 18:00 de segunda a sexta-feira.';
        END IF;
    END IF;
    
END;
//
DELIMITER ;

-- Teste: Agendamento válido em dia útil
INSERT INTO Agendamentos (id_paciente, id_medico, id_sala, data_consulta, hora_consulta) 
VALUES (1, 1, 1, '2024-11-14', '09:00:00');

-- Teste: Agendamento fora do horário em dia útil
INSERT INTO Agendamentos (id_paciente, id_medico, id_sala, data_consulta, hora_consulta) 
VALUES (1, 1, 1, '2024-11-14', '19:00:00');

-- Teste: Agendamento aos domingos (não permitido)
INSERT INTO Agendamentos (id_paciente, id_medico, id_sala, data_consulta, hora_consulta) 
VALUES (2, 2, 2, '2024-11-17', '10:00:00');



-- 2 Limite de Consultas Mensais: Cada paciente só pode agendar até 5 consultas por mês.

DELIMITER //
CREATE TRIGGER verificar_limite_consultas
BEFORE INSERT ON Agendamentos
FOR EACH ROW
BEGIN
    DECLARE consultas_mes INT;

    -- Verificar o número de consultas do paciente no mês atual
    SELECT total_consultas 
    INTO consultas_mes
    FROM LimiteConsultas
    WHERE id_paciente = NEW.id_paciente
    AND mes = MONTH(NEW.data_consulta)
    AND ano = YEAR(NEW.data_consulta);

    -- Caso o número de consultas seja maior ou igual ao limite, impedir a inserção
    IF consultas_mes >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Você excedeu o limite de marcações para este mês';
    ELSE
        -- Incrementar o total de consultas na tabela LimiteConsultas
        UPDATE LimiteConsultas
        SET total_consultas = total_consultas + 1
        WHERE id_paciente = NEW.id_paciente
        AND mes = MONTH(NEW.data_consulta)
        AND ano = YEAR(NEW.data_consulta);
    END IF;
END //
DELIMITER ;

-- Inserir mais 4 consultas para o paciente 1
INSERT INTO Agendamentos (id_paciente, id_medico, id_sala, data_consulta, hora_consulta, status) VALUES 
(1, 1, 1, '2024-11-15', '09:01:00', 'Agendado'),
(1, 2, 2, '2024-11-15', '10:01:00', 'Agendado'),
(1, 3, 3, '2024-11-16', '11:01:00', 'Agendado'),
(1, 4, 4, '2024-11-16', '11:51:00', 'Agendado');

-- Excedendo o limite de consultas
INSERT INTO Agendamentos (id_paciente, id_medico, id_sala, data_consulta, hora_consulta, status) VALUES 
(1, 5, 5, '2024-11-19', '15:01:00', 'Agendado');





-- 3 Conflito de Sala: Um mesmo horário e sala não podem ser reservados para mais de um paciente.
DELIMITER // 
CREATE TRIGGER evitar_conflito_sala 
BEFORE INSERT ON Agendamentos 
FOR EACH ROW 
BEGIN 
    DECLARE conflito INT; 
    SELECT COUNT(*) INTO conflito 
    FROM Agendamentos 
    WHERE id_sala = NEW.id_sala 
    AND data_consulta = NEW.data_consulta
    AND hora_consulta = NEW.hora_consulta;     
    IF conflito > 0 THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sala já ocupada para este horário.'; 
    END IF; 
END // 
DELIMITER ; 

 -- TESTE DE CONFLITO
INSERT INTO Agendamentos (id_paciente, id_medico, id_sala, data_consulta, hora_consulta, status)
VALUES (2, 1, 1, '2024-11-15', '09:00:00', 'Agendado');




-- 4 Histórico de Consultas: Ao concluir uma consulta, ela é registrada na tabela ConsultasRealizadas e removida da tabela Agendamentos.
DELIMITER //
CREATE TRIGGER trg_ConsultaRealizada_AfterUpdate
AFTER UPDATE ON Agendamentos
FOR EACH ROW
BEGIN
    -- Verifica se o status foi alterado para "Realizado"
    IF NEW.status = 'Realizado' AND OLD.status != 'Realizado' THEN
        -- Insere um registro na tabela ConsultasRealizadas
        INSERT INTO ConsultasRealizadas (id_agendamento, diagnostico, prescricao, observacoes)
        VALUES (NEW.id_agendamento, 'Diagnóstico a definir', 'Prescrição a definir', 'Observações a definir');
		  
    END IF;
END //
DELIMITER ;

-- Agendamentos Atuais
SELECT * FROM Agendamentos;

-- Atualizando um agendamento para o status "Realizado"
UPDATE Agendamentos
SET status = 'Realizado'
WHERE id_agendamento = 1;

DELETE FROM Agendamentos
WHERE status = 'Realizado';

-- Verificando a tabela ConsultasRealizadas
SELECT * FROM ConsultasRealizadas;





-- 5 Notificações de Agendamento: Ao agendar uma consulta, uma notificação de confirmação deve ser registrada na tabela Notificacoes.

DELIMITER $$
CREATE TRIGGER after_agendamento_insert
AFTER INSERT ON Agendamentos
FOR EACH ROW
BEGIN
    DECLARE tipo_notificacao VARCHAR(50);
    DECLARE mensagem VARCHAR(500);

    -- Definir o tipo de notificação e a mensagem com base no status do agendamento
    IF NEW.status = 'Agendado' THEN
        SET tipo_notificacao = 'Lembrete';
        SET mensagem = CONCAT('Sua consulta está agendada para ', DATE_FORMAT(NEW.data_consulta, '%d/%m/%Y'), ' às ', NEW.hora_consulta);
    ELSEIF NEW.status = 'Realizado' THEN
        SET tipo_notificacao = 'Confirmação';
        SET mensagem = CONCAT('Confirmação de consulta em ', DATE_FORMAT(NEW.data_consulta, '%d/%m/%Y'), ' às ', NEW.hora_consulta);
    ELSE
        SET tipo_notificacao = 'Cancelamento';
        SET mensagem = CONCAT('Sua consulta agendada para ', DATE_FORMAT(NEW.data_consulta, '%d/%m/%Y'), ' foi cancelada');
    END IF;

    -- Inserir notificação na tabela Notificacoes
    INSERT INTO Notificacoes (id_agendamento, id_paciente, tipo_notificacao, mensagem)
    VALUES (NEW.id_agendamento, NEW.id_paciente, tipo_notificacao, mensagem);
END $$
DELIMITER ;

SELECT * FROM Notificacoes;

-- Adicionando um lembrete
INSERT INTO Agendamentos (id_paciente, id_medico, id_sala, data_consulta, hora_consulta, status) 
VALUES (3, 1, 1, '2024-11-18', '10:00:00', 'Agendado');



-- 6 Cancelamento de Consultas: Ao cancelar uma consulta, o registro e o motivo do cancelamento devem ser salvos na tabela Cancelamentos.
DELIMITER $$
CREATE TRIGGER trg_agendamento_cancelado
AFTER UPDATE ON Agendamentos
FOR EACH ROW
BEGIN
    -- Verificando se o agendamento foi cancelado
    IF NEW.status = 'Cancelado' AND OLD.status != 'Cancelado' THEN
        -- Inserindo os dados na tabela Cancelamentos
        INSERT INTO Cancelamentos (id_agendamento, id_paciente, id_medico, id_sala, data_consulta, hora_consulta, motivo_cancelamento)
        VALUES (NEW.id_agendamento, NEW.id_paciente, NEW.id_medico, NEW.id_sala, NEW.data_consulta, NEW.hora_consulta, NEW.motivo_cancelamento);
    END IF;
END $$
DELIMITER ;

-- Verificando a tabela cancelamento
select * from Cancelamentos;

-- Inserido dados na tabela cancelamento
UPDATE Agendamentos
SET status = 'Cancelado', motivo_cancelamento = 'Paciente não pode comparecer.'
WHERE id_agendamento = 1;

-- Verificando se o dado foi inserido
select * from Cancelamentos;


