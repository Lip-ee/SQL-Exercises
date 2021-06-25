-- (01) - Procedure para Pesquisar
---------------------------------------
CREATE PROCEDURE PesquisarCliente
    @CodCliente NVARCHAR(50)
AS
    SELECT * FROM dbo.CLIENTES
    WHERE COD_CLIENTE = @CodCliente;
GO

EXEC PesquisarCliente N'12'
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE PesquisarCategoria
    @NomeCategoria NVARCHAR(50)
AS
    SELECT * FROM dbo.CATEGORIA
    WHERE NOME_CATEGORIA = @NomeCategoria;
GO

EXEC PesquisarCategoria N'AÇÃO'
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE PesquisarFilme
    @CodFilme NVARCHAR(50)
AS
    SELECT * FROM dbo.FILME
    WHERE COD_FILME = @CodFilme;
GO

EXEC PesquisarFilme N'7'
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE PesquisarLocacao
    @CodLocacao NVARCHAR(50)
AS
    SELECT * FROM dbo.LOCACOES
    WHERE COD_LOCACAO = @CodLocacao;
GO

EXEC PesquisarLocacao N'12'
GO
---------------------------------------



-- (02) - Procedure para Incluir (Adicionar)
---------------------------------------
SET DATEFORMAT ymd
GO

CREATE PROCEDURE AdicionarCliente
    @RG NVARCHAR(50),
    @Nome NVARCHAR(75),
    @Endereco NVARCHAR(100),
    @Bairro NVARCHAR(50),
    @Cidade NVARCHAR(50),
    @Estado NVARCHAR(5),
    @Telefone NVARCHAR(20),
    @Email NVARCHAR(50),
    @DataNasc DATE,
    @Sexo CHAR(1)
AS
    INSERT INTO dbo.CLIENTES VALUES
    (@RG,
    @Nome,
    @Endereco,
    @Bairro,
    @Cidade,
    @Estado,
    @Telefone,
    @Email,
    @DataNasc,
    @Sexo);
GO

-- Pequena Homenagem ao meu tio Adriano
-- Faleceu dia 22/06/21
-- Deixará saudades <3
EXEC AdicionarCliente
    N'000000000',
    N'Adriano Vieira',
    N'Debaixo das Asas do Senhor Jesus',
    N'Céu',
    N'Céu',
    N'CE',
    N'xxxxx-xxxx',
    N'adriano.moscot@gmail.com',
    '2021-06-22',
    'm'
GO
---------------------------------------

--------------------------------------
CREATE PROCEDURE AdicionarCategoria
    @NomeCategoria NVARCHAR(50)
AS
    INSERT INTO dbo.CATEGORIA VALUES
    (@NomeCategoria);
GO

EXEC AdicionarCategoria
    N'SUSPENSE'
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE AdicionarFilme
    @NomeFilme NVARCHAR(50),
    @CodCategoria NVARCHAR(20),
    @Diretor NVARCHAR(50),
    @ValorLocacao FLOAT,
    @Reservada CHAR(1)
AS
    INSERT INTO dbo.FILME VALUES
    (@NomeFilme,
    @CodCategoria,
    @Diretor,
    @ValorLocacao,
    @Reservada);
GO

EXEC AdicionarFilme
    N'John Wick - De volta ao Jogo',
    N'1',
    N'Chad Stanhelski',
    42.42,
    'n'
GO
---------------------------------------

---------------------------------------
SET DATEFORMAT ymd
GO

CREATE PROCEDURE AdicionarLocacao
    @CodCliente NVARCHAR(20),
    @CodFilme NVARCHAR(20),
    @DataRetirada DATE,
    @DataDevolução DATE
AS
    INSERT INTO dbo.LOCACOES VALUES 
    (@CodCliente,
    @CodFilme,
    @DataRetirada,
    @DataDevolução);
GO

EXEC AdicionarLocacao
    N'12',
    N'21',
    '2021-06-25',
    '2021-06-27'
GO
---------------------------------------



-- (03) - Procedure para Alterar
---------------------------------------
CREATE PROCEDURE AlterarCliente
    @CodCliente NVARCHAR(20),
    @RG NVARCHAR(50),
    @Nome NVARCHAR(75),
    @Endereco NVARCHAR(100),
    @Bairro NVARCHAR(50),
    @Cidade NVARCHAR(50),
    @Estado NVARCHAR(5),
    @Telefone NVARCHAR(20),
    @Email NVARCHAR(50),
    @DataNasc DATE,
    @Sexo CHAR(1)
AS
    UPDATE dbo.CLIENTES SET
    RG = @RG,
    NOME = @Nome,
    ENDERECO = @Endereco,
    BAIRRO = @Bairro,
    CIDADE = @Cidade,
    ESTADO = @Estado,
    TELEFONE = @Telefone,
    EMAIL =  @Email,
    DATANASCIMENTO =  @DataNasc,
    SEXO = @Sexo
    WHERE COD_CLIENTE = @CodCliente
GO

EXEC AlterarCliente
    N'5',
    N'459876543',
    N'Rafael Nunes Sales',
    N'Rua Guilherme Orlando, 333',
    N'JD. Santa Rosália',
    N'Sorocaba',
    N'SP',
    N'932145543',
    N'rafael@hacker.com.br',
    '1999-02-24 00:00:00.000',
    'm'
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE AlterarCategoria
    @CodCategoria NVARCHAR(20),
    @NomeCategoria NVARCHAR(50)
AS
    UPDATE dbo.CATEGORIA SET
    NOME_CATEGORIA = @NomeCategoria
    WHERE COD_CATEGORIA = @CodCategoria
GO

EXEC AlterarCategoria
    N'1',
    N'ACTION'
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE AlterarFilme
    @CodFilme NVARCHAR(20),
    @NomeFilme NVARCHAR(50),
    @CodCategoria NVARCHAR(20),
    @Diretor NVARCHAR(50),
    @ValorLocacao FLOAT,
    @Reservada CHAR(1)
AS
    UPDATE dbo.FILME SET
    FILME = @NomeFilme,
    COD_CATEGORIA = @CodCategoria,
    DIRETOR = @Diretor,
    VALOR_LOCACAO = @ValorLocacao,
    RESERVADA = @Reservada
    WHERE COD_FILME = @CodFilme
GO

EXEC AlterarFilme
    N'21',
    'John Wick - De Volta ao Jogo',
    N'1',
    'Chad Stanhelski',
    42.42,
    's'
GO
---------------------------------------

---------------------------------------
SET DATEFORMAT ymd
GO

CREATE PROCEDURE AlterarLocacao
    @CodLocacao NVARCHAR(50),
    @CodCliente NVARCHAR(20),
    @CodFilme NVARCHAR(20),
    @DataRetirada DATE,
    @DataDevolução DATE
AS
    UPDATE dbo.LOCACOES SET
    COD_CLIENTE = @CodCliente,
    COD_FILME = @CodFilme,
    DATA_RETIRADA = @DataRetirada,
    DATA_DEVOLUCAO = @DataDevolução
    WHERE COD_LOCACAO = @CodLocacao 
GO

EXEC AlterarLocacao
    N'26',
    N'12',
    N'21',
    '2021-06-25',
    '2022-06-27'
GO
---------------------------------------

-- (04) - Procedure para Excluir
---------------------------------------
CREATE PROCEDURE ExcluirCliente
    @CodCliente NVARCHAR(50)
AS
    DELETE FROM dbo.CLIENTES
    WHERE COD_CLIENTE = @CodCliente
GO

EXEC ExcluirCliente
    N'9'
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE ExcluirCategoria
    @NomeCategoria NVARCHAR(50)
AS
    DELETE FROM dbo.CATEGORIA
    WHERE NOME_CATEGORIA = @NomeCategoria
GO

EXEC ExcluirCategoria
    N'SUSPENSE'
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE ExcluirFilme
    @CodFilme NVARCHAR(50)
AS
    DELETE FROM dbo.FILME
    WHERE COD_FILME = @CodFilme
GO

EXEC ExcluirFilme
    N'15'
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE ExcluirLocacao
    @CodLocacao NVARCHAR(50)
AS
    DELETE FROM dbo.LOCACOES
    WHERE COD_LOCACAO = @CodLocacao
GO

EXEC ExcluirLocacao
    N'25'
GO
---------------------------------------

/*
(05) - Criar uma Stored Procedure que
mostre os clientes aniversariantes
do mês fornecido pelo user
*/ ------------------------------------
CREATE PROCEDURE AniversarioClientesMes
    @Mes INT
AS
    SELECT NOME FROM dbo.CLIENTES
    WHERE DATEPART(MONTH, DATANASCIMENTO) = @Mes
GO

EXEC AniversarioClientesMes
    10
GO
---------------------------------------

/*
(06) - Criar uma Stored Procedure que 
resuma a quantidade de aniversariantes
por mês (info geral de aniversariantes)
*/ ------------------------------------
CREATE PROCEDURE AniversarioClientesGeral
AS
    -- Criando uma variável p/ armazenar meses (espécie de Vetor)
    DECLARE @Meses TABLE (Mes NVARCHAR(20), NumMes INT)
    -- Inserindo os meses na variável anterior
    INSERT INTO @Meses VALUES
    ('JAN', 01),
    ('FEV', 02),
    ('MAR', 03),
    ('ABR', 04),
    ('MAI', 05),
    ('JUN', 06),
    ('JUL', 07),
    ('AGO', 08),
    ('SET', 09),
    ('OUT', 10),
    ('NOV', 11),
    ('DEZ', 12);

    SELECT me.Mes AS 'Mês:', COUNT(cl.COD_CLIENTE) AS 'Qtd. Aniversariantes'
    FROM @Meses me LEFT JOIN dbo.CLIENTES cl
        on DATEPART(MONTH, cl.DATANASCIMENTO) = me.NumMes
    GROUP BY Mes, me.NumMes
    ORDER BY me.NumMes ASC
GO

EXEC AniversarioClientesGeral
GO
---------------------------------------



-- SELECTS
---------------------------------------
-- SELECT * FROM dbo.FILME
-- SELECT * FROM dbo.CATEGORIA
-- SELECT * FROM dbo.LOCACOES
-- SELECT * FROM dbo.CLIENTES
---------------------------------------

-- Reset Procedures
---------------------------------------
-- DROP PROCEDURE PesquisarCliente
-- DROP PROCEDURE PesquisarCategoria
-- DROP PROCEDURE PesquisarFilme
-- DROP PROCEDURE PesquisarLocacao
-- DROP PROCEDURE AdicionarCliente
-- DROP PROCEDURE AdicionarCategoria
-- DROP PROCEDURE AdicionarFilme
-- DROP PROCEDURE AdicionarLocacao
-- DROP PROCEDURE ExcluirCliente
-- DROP PROCEDURE ExcluirCategoria
-- DROP PROCEDURE ExcluirFilme
-- DROP PROCEDURE ExcluirLocacao
-- DROP PROCEDURE AlterarCliente
-- DROP PROCEDURE AlterarCategoria
-- DROP PROCEDURE AlterarFilme
-- DROP PROCEDURE AlterarLocacao
---------------------------------------