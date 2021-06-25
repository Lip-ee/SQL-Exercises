-- (01) - Procedure para Pesquisar
---------------------------------------
CREATE PROCEDURE PesquisarCliente
    @CodCliente NVARCHAR(50)
AS
    SELECT * FROM dbo.CLIENTES
    WHERE COD_CLIENTE = @CodCliente;
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE PesquisarCategoria
    @NomeCategoria NVARCHAR(50)
AS
    SELECT * FROM dbo.CATEGORIA
    WHERE NOME_CATEGORIA = @NomeCategoria;
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE PesquisarFilme
    @CodFilme NVARCHAR(50)
AS
    SELECT * FROM dbo.FILME
    WHERE COD_FILME = @CodFilme;
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE PesquisarLocacao
    @CodLocacao NVARCHAR(50)
AS
    SELECT * FROM dbo.LOCACOES
    WHERE COD_LOCACAO = @CodLocacao;
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
---------------------------------------

--------------------------------------
CREATE PROCEDURE AdicionarCategoria
    @NomeCategoria NVARCHAR(50)
AS
    INSERT INTO dbo.CATEGORIA VALUES
    (@NomeCategoria);
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
---------------------------------------



-- (03) - Procedure para Excluir
---------------------------------------
CREATE PROCEDURE ExcluirCliente
    @CodCliente NVARCHAR(50)
AS
    DELETE FROM dbo.CLIENTES
    WHERE COD_CLIENTE = @CodCliente
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE ExcluirCategoria
    @NomeCategoria NVARCHAR(50)
AS
    DELETE FROM dbo.CATEGORIA
    WHERE NOME_CATEGORIA = @NomeCategoria
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE ExcluirFilme
    @CodFilme NVARCHAR(50)
AS
    DELETE FROM dbo.FILME
    WHERE COD_FILME = @CodFilme
GO
---------------------------------------

---------------------------------------
CREATE PROCEDURE ExcluirLocacao
    @CodLocacao NVARCHAR(50)
AS
    DELETE FROM dbo.LOCACOES
    WHERE COD_LOCACAO = @CodLocacao
GO
---------------------------------------



-- (04) - Procedure para Alterar
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