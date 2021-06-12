-- Create a new database called 'DatabaseName'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'VIDEOLOCADORA'
)
CREATE DATABASE VIDEOLOCADORA
GO

USE VIDEOLOCADORA
GO

-- ### CLIENTES ### --
CREATE TABLE dbo.CLIENTES(
    COD_CLIENTE INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    RG VARCHAR(9) NOT NULL,
    NOME VARCHAR(50) NOT NULL,
    ENDERECO VARCHAR(50) NOT NULL,
    BAIRRO VARCHAR(30) NOT NULL,
    CIDADE VARCHAR(30) NOT NULL,
    ESTADO VARCHAR(2) NOT NULL,
    TELEFONE VARCHAR(15) NOT NULL,
    EMAIL VARCHAR(30) NOT NULL,
    DATANASCIMENTO DATETIME NOT NULL,
    SEXO CHAR(1)
);

-- ### CATEGORIA ### --
CREATE TABLE dbo.CATEGORIA(
    COD_CATEGORIA INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    NOME_CATEGORIA VARCHAR(20) NOT NULL
);

-- ### FILME ### --
CREATE TABLE dbo.FILME(
    COD_FILME INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    FILME VARCHAR(30) NOT NULL,
    COD_CATEGORIA INT NOT NULL,
    DIRETOR VARCHAR(50) NOT NULL,
    VALOR_LOCACAO FLOAT NOT NULL,
    RESERVADA CHAR(1) NOT NULL
);

-- ### LOCAÇÕES ### --
CREATE TABLE dbo.LOCACOES(
    COD_LOCACAO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    COD_CLIENTE INT NOT NULL,
    COD_FILME INT NOT NULL,
    DATA_RETIRADA DATETIME NOT NULL,
    DATA_DEVOLUCAO DATETIME NOT NULL
);





-- ~~~ LOCACOES x CLIENTES ~~~ --
ALTER TABLE dbo.LOCACOES ADD FOREIGN KEY (COD_CLIENTE)
    REFERENCES dbo.CLIENTES(COD_CLIENTE)

-- ~~~ LOCACOES x FILME ~~~ --
ALTER TABLE dbo.LOCACOES ADD FOREIGN KEY (COD_FILME)
    REFERENCES dbo.FILME(COD_FILME)

-- ~~~ FILME x CATEGORIA ~~~ --
ALTER TABLE dbo.FILME ADD FOREIGN KEY (COD_CATEGORIA)
    REFERENCES dbo.CATEGORIA(COD_CATEGORIA)





-- &&& INSERTS CATEGORIA &&& --
INSERT INTO dbo.CATEGORIA VALUES
('Ação'),
('Romance'),
('Aventura'),
('Ficção'),
('Drama'),
('Terror'),
('Desenho'),
('Policial'),
('Comédia');

-- &&& INSERTS CLIENTES &&& --
SET DATEFORMAT ymd;
INSERT INTO dbo.CLIENTES VALUES
('32132232323', 'Edson Martin Feitosa', 'Rua Orlando Alvarenga, 1', 'JD. Vera Cruz', 'Sorocaba', 'SP', '998988778', 'edson.feitora@ig.com.br', '1982-11-30 00:00:00.000'),
('32132232323', 'Edson Martin Feitosa', 'Rua Orlando Alvarenga, 1', 'JD. Vera Cruz', 'Sorocaba', 'SP', '998988778', 'edson.feitora@ig.com.br', '1982-11-30 00:00:00.000'),
('32132232323', 'Edson Martin Feitosa', 'Rua Orlando Alvarenga, 1', 'JD. Vera Cruz', 'Sorocaba', 'SP', '998988778', 'edson.feitora@ig.com.br', '1982-11-30 00:00:00.000'),
('32132232323', 'Edson Martin Feitosa', 'Rua Orlando Alvarenga, 1', 'JD. Vera Cruz', 'Sorocaba', 'SP', '998988778', 'edson.feitora@ig.com.br', '1982-11-30 00:00:00.000'),
('32132232323', 'Edson Martin Feitosa', 'Rua Orlando Alvarenga, 1', 'JD. Vera Cruz', 'Sorocaba', 'SP', '998988778', 'edson.feitora@ig.com.br', '1982-11-30 00:00:00.000'),
('32132232323', 'Edson Martin Feitosa', 'Rua Orlando Alvarenga, 1', 'JD. Vera Cruz', 'Sorocaba', 'SP', '998988778', 'edson.feitora@ig.com.br', '1982-11-30 00:00:00.000'),
('32132232323', 'Edson Martin Feitosa', 'Rua Orlando Alvarenga, 1', 'JD. Vera Cruz', 'Sorocaba', 'SP', '998988778', 'edson.feitora@ig.com.br', '1982-11-30 00:00:00.000'),
('32132232323', 'Edson Martin Feitosa', 'Rua Orlando Alvarenga, 1', 'JD. Vera Cruz', 'Sorocaba', 'SP', '998988778', 'edson.feitora@ig.com.br', '1982-11-30 00:00:00.000'),
('32132232323', 'Edson Martin Feitosa', 'Rua Orlando Alvarenga, 1', 'JD. Vera Cruz', 'Sorocaba', 'SP', '998988778', 'edson.feitora@ig.com.br', '1982-11-30 00:00:00.000'),
('32132232323', 'Edson Martin Feitosa', 'Rua Orlando Alvarenga, 1', 'JD. Vera Cruz', 'Sorocaba', 'SP', '998988778', 'edson.feitora@ig.com.br', '1982-11-30 00:00:00.000');

-- &&& INSERTS FILME &&& --
INSERT INTO dbo.FILME VALUES
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n'),
('300', 1, 'Richard Donner', 3.5, 'n');

-- &&& INSERTS LOCACOES &&& --
INSERT INTO dbo.LOCACOES VALUES
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 1, '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000');

