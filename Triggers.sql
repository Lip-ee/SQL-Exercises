/*
Utilizando o Banco de Dados Videolocadora, criar Triggers
que atualizem a coluna RESERVADA da tabela FILME:
*/

USE VIDEOLOCADORA
GO

/*
1 - Quando for incluída uma locação para o filme,
alterar o valor para 's':
*/
-- DROP TRIGGER tgrAltLocacao = caso precise resetar o trigger

CREATE TRIGGER tgrAltLocacao ON dbo.LOCACOES
AFTER INSERT AS
BEGIN
    DECLARE
    @CODFILME NVARCHAR(50)

    SELECT @CODFILME = COD_FILME FROM inserted

    UPDATE dbo.FILME SET RESERVADA = 's'
    WHERE COD_FILME = @CODFILME
END
GO

-- pequena alteração que tive que fazer para a coluna aceitar NULL
ALTER TABLE dbo.LOCACOES
ALTER COLUMN DATA_DEVOLUCAO DATETIME 

-- insert new locacao
INSERT INTO dbo.LOCACOES VALUES
(12, 1, CURRENT_TIMESTAMP, NULL)
GO

-- show tables
SELECT * FROM dbo.LOCACOES
GO
SELECT * FROM dbo.FILME
GO




/*
2 - Quando o filme for devolvido e a Data_Devolução que
estava NULL for alterada por uma data válida, alterar o
valor para 'n':
*/
-- DROP TRIGGER tgrAltDevolucao = caso precise resetar o trigger

CREATE TRIGGER tgrAltDevolucao ON dbo.LOCACOES
AFTER UPDATE AS
BEGIN
    DECLARE
    @CODFILME NVARCHAR(50)

    SELECT @CODFILME = COD_FILME FROM inserted

    UPDATE dbo.FILME SET RESERVADA = 'n'
    WHERE COD_FILME = @CODFILME
END
GO

-- update row
UPDATE dbo.LOCACOES SET DATA_DEVOLUCAO = '2021-08-12 17:58:26.810'
WHERE COD_LOCACAO = 1031

-- show tables
SELECT * FROM dbo.LOCACOES
GO
SELECT * FROM dbo.FILME
GO





/*
3 - Quando uma locação de um filme for excluída, 
alterar também o valor para 'n':
*/
-- DROP TRIGGER tgrDelLocacao = caso precise resetar o trigger

CREATE TRIGGER tgrDelLocacao ON dbo.LOCACOES
AFTER DELETE AS
BEGIN
    DECLARE
    @CODFILME NVARCHAR(50)

    SELECT @CODFILME = COD_FILME FROM deleted

    UPDATE dbo.FILME SET RESERVADA = 'n'
    WHERE COD_FILME = @CODFILME
END
GO

-- delete row
DELETE FROM dbo.LOCACOES
WHERE COD_LOCACAO = 1031

-- show tables
SELECT * FROM dbo.LOCACOES
GO
SELECT * FROM dbo.FILME
GO



/*
TESTE TRIGGER
*/

-- USE TestDB

-- -- caixa
-- CREATE TABLE CAIXA(
--     DATA DATETIME,
--     SALDO_INICIAL DECIMAL(10,2),
--     SALDO_FINAL DECIMAL(10,2)
-- )
-- GO

-- -- histórico de vendas
-- CREATE TABLE VENDAS(
--     DATA DATETIME,
--     CODIGO INT,
--     VALOR DECIMAL(10,2)
-- )
-- GO

-- -- primeiro registro
-- INSERT INTO CAIXA VALUES
-- (CONVERT(DATETIME, CONVERT(VARCHAR, GETDATE(), 103)), 100, 100)
-- GO

-- -- TRIGGER de Insert
-- CREATE TRIGGER tgrHisVENDAS ON VENDAS
-- FOR INSERT AS
-- BEGIN
--     -- declarando variáveis locais
--     DECLARE
--     @VALOR DECIMAL(10,2),
--     @DATA DATETIME

--     -- igualando as variáveis locais e estrangeiras
--     SELECT @DATA = DATA, @VALOR = VALOR FROM inserted -- inserted = tabela temporária

--     -- função do trigger (update do valor final do caixa)
--     UPDATE CAIXA SET SALDO_FINAL = SALDO_FINAL + @VALOR
--     WHERE DATA = @DATA
-- END
-- GO

-- INSERT INTO VENDAS VALUES
-- (CONVERT(DATETIME, CONVERT(VARCHAR, GETDATE(), 103)), 1, 10)
-- GO

-- -- selects
-- SELECT * FROM CAIXA
-- SELECT * FROM VENDAS