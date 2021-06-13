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
    COD_CLIENTE    INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    RG             VARCHAR(9)                    NOT NULL,
    NOME           VARCHAR(50)                   NOT NULL,
    ENDERECO       VARCHAR(50)                   NOT NULL,
    BAIRRO         VARCHAR(30)                   NOT NULL,
    CIDADE         VARCHAR(30)                   NOT NULL,
    ESTADO         VARCHAR(2)                    NOT NULL,
    TELEFONE       VARCHAR(15)                   NOT NULL,
    EMAIL          VARCHAR(30)                   NOT NULL,
    DATANASCIMENTO DATETIME                      NOT NULL,
    SEXO           CHAR(1)
);

-- ### CATEGORIA ### --
CREATE TABLE dbo.CATEGORIA(
    COD_CATEGORIA  INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    NOME_CATEGORIA VARCHAR(20)                   NOT NULL
);

-- ### FILME ### --
CREATE TABLE dbo.FILME(
    COD_FILME     INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    FILME         VARCHAR(30)                   NOT NULL,
    COD_CATEGORIA INT                           NOT NULL,
    DIRETOR       VARCHAR(50)                   NOT NULL,
    VALOR_LOCACAO FLOAT                         NOT NULL,
    RESERVADA     CHAR(1)                       NOT NULL
);

-- ### LOCAÇÕES ### --
CREATE TABLE dbo.LOCACOES(
    COD_LOCACAO    INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    COD_CLIENTE    INT                           NOT NULL,
    COD_FILME      INT                           NOT NULL,
    DATA_RETIRADA  DATETIME                      NOT NULL,
    DATA_DEVOLUCAO DATETIME                      NOT NULL
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
('32132232323', 'Edson Martin Feitosa',              'Rua Orlando Alvarenga, 1',      'JD. Vera Cruz',          'Sorocaba',   'SP', '998988778', 'edson@terra.com.br',   '1982-04-29 00:00:00.000'),
('12341234123', 'Rafael Fernando de Moreaes Moreno', 'Rua Francisco de Souza, 123',   'JD. Nova Esperança',     'São Roque',  'SP', '993423432', 'rafael@uou.com.br',    '1981-05-28 00:00:00.000'),
('34563456345', 'JOão da Silva',                     'Rua Mario Quintana, 132',       'JD. Bartolomeu',         'Sorocaba',   'SP', '998458778', 'joao@ig.com.br',       '1980-06-27 00:00:00.000'),
('57456824367', 'Maria Chiquinha',                   'Rua Padre Luiz, 1345',          'JD. Vera Cruz',          'Sorocaba',   'SP', '993458778', 'maria@terra.com.br',   '1983-07-26 00:00:00.000'),
('45987654673', 'Rafael Nunes Sales',                'Rua Orlando Alvarenga, 174',    'JD. Vera Cruz',          'Sorocaba',   'SP', '998934548', 'rafael@ig.com.br',     '1984-08-25 00:00:00.000'),
('63298424566', 'Daniela Martin Feitosa',            'Rua Guilherme Oliveira, 34561', 'JD. Vera das Acássicas', 'Votorantim', 'SP', '958988778', 'daniela@uou.com.br',   '1985-09-24 00:00:00.000'),
('24842347854', 'Renata Cristina',                   'Rua Orlando Alvarenga, 143',    'JD. Vera Cruz',          'Sorocaba',   'SP', '994588778', 'renata@ig.com.br',     '1986-10-23 00:00:00.000'),
('45134643564', 'Joaquim Ferreira de Souza Junior',  'Rua Outubro Vermelho, 1333',    'JD. Santa Rosália',      'Votorantim', 'SP', '998934778', 'joaquim@terra.com.br', '1987-11-22 00:00:00.000'),
('15345967895', 'Ladislau Ferreira',                 'Rua Orlando Alvarenga, 1454',   'JD. Vera Cruz',          'Sorocaba',   'SP', '993988778', 'ladislau@uou.com.br',  '1988-12-21 00:00:00.000'),
('15242357685', 'Vanessa Oliveira',                  'Rua das Flores, 111',           'JD. do Sol',             'Votorantim', 'SP', '945488778', 'vanessa@ig.com.br',    '1989-12-20 00:00:00.000');

-- &&& INSERTS FILME &&& --
INSERT INTO dbo.FILME VALUES
('300',                            1, 'Richard Donner',   3.5, 'n'),
('Máquina Mortífera',              1, 'Richard DOoner',   3.6, 'n'),
('A Mexicana',                     2, 'Burr Steers',      2,   's'),
('A Verdade Nua e Crua',           2, 'Roberto Luketic',  4,   'n'),
('A Vida é Bela',                  2, 'Roberto Benigni',  3.5, 's'),
('Austrália',                      3, 'Baz Luhrmann',     4,   's'),
('Ultimato Bourn',                 3, 'Paul Greengrass',  3.5, 'n'),
('Constantine',                    4, 'Francis Lawrence', 2.5, 's'),
('Os Irmãos Grimm',                4, 'Terry GIliiam',    3.5, 'n'),
('Os Doze Macacos',                4, 'Terry Gilliam',    2.5, 'n'),
('Amadeus',                        5, 'Milos Forman',     10,  'n'),
('As Torres Gêmeas',               5, 'Oliver Stone',     2.5, 's'),
('Platoon',                        1, 'Oliver Stone',     5.5, 's'),
('O Advogado do Diabo',            6, 'Taylor Hackford',  1.5, 's'),
('Beowulf',                        7, 'Robert Zemeckis',  1,   'n'),
('Bolt o Super Cão',               8, 'Byron Howard',     1.5, 's'),
('Apertem o Cinto o Piloto Sumiu', 9, 'Jim Abrahams',     3.6, 's'),
('Doze é Demais',                  9, 'Shawn Levy',       9.2, 's'),
('Uma Noite no Museu',             9, 'Shawn Levy',       2.5, 'n');

-- &&& INSERTS LOCACOES &&& --
INSERT INTO dbo.LOCACOES VALUES
(1, 1,   '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 6,   '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 8,   '2010-03-20 19:05:43.887', '2010-03-23 00:00:00.000'),
(1, 2,   '2010-03-15 00:00:00.887', '2010-03-17 00:00:00.000'),
(1, 13,  '2010-03-15 00:00:00.887', '2010-03-17 00:00:00.000'),
(2, 5,   '2010-03-20 19:05:43.887', '2010-03-21 00:00:00.000'),
(3, 3,   '2010-03-18 19:05:43.887', '2010-03-20 00:00:00.000'),
(3, 19,  '2010-03-18 19:05:43.887', '2010-03-20 00:00:00.000'),
(4, 17,  '2010-03-01 19:05:43.887', '2010-03-03 00:00:00.000'),
(5, 5,   '2010-03-03 19:05:43.887', '2010-03-05 00:00:00.000'),
(6, 7,   '2010-03-03 19:05:43.887', '2010-03-04 00:00:00.000'),
(6, 9,   '2010-03-03 19:05:43.887', '2010-03-04 00:00:00.000'),
(7, 16,  '2010-03-13 19:05:43.887', '2010-03-15 00:00:00.000'),
(7, 1,   '2010-03-13 19:05:43.887', '2010-03-15 00:00:00.000'),
(7, 5,   '2010-03-14 19:05:43.887', '2010-03-16 00:00:00.000'),
(7, 8,   '2010-03-14 19:05:43.887', '2010-03-16 00:00:00.000'),
(7, 11,  '2010-03-14 19:05:43.887', '2010-03-16 00:00:00.000'),
(7, 12,  '2010-03-15 19:05:43.887', '2010-03-17 00:00:00.000'),
(8, 9,   '2010-03-20 19:05:43.887', '2010-03-21 00:00:00.000'),
(9, 3,   '2010-03-21 19:05:43.887', '2010-03-22 00:00:00.000'),
(9, 6,   '2010-03-21 19:05:43.887', '2010-03-22 00:00:00.000'),
(10, 10, '2010-03-20 19:05:43.887', '2010-03-21 00:00:00.000');

