-- Solução de Trigger Tabela Parcelas/Vendas

-- Configs
USE VIDEOLOCADORA
GO

-- Reset
-- USE VIDEOLOCADORA
-- DROP TABLE PARCELAS
-- GO
-- DROP TABLE VENDAS
-- GO


-- Tables
CREATE TABLE VENDAS(
    ID_Venda INT IDENTITY PRIMARY KEY,
    Data_Venda DATETIME,
    ID_Cliente INT FOREIGN KEY REFERENCES dbo.CLIENTES(COD_CLIENTE),
    Valor_Total MONEY,
    nParcelas INT
);
GO
-- SELECT * FROM VENDAS;
-- DROP TABLE VENDAS;

CREATE TABLE PARCELAS(
    ID_Venda INT FOREIGN KEY REFERENCES dbo.VENDAS(ID_Venda),
    ID_Parcela INT,
    Data_Vencimento DATETIME,
    Valor MONEY,
    Data_Pagamento DATETIME,
    Multa MONEY
);
GO
-- SELECT * FROM PARCELAS;
-- DROP TABLE PARCELAS;



-- Trigger
SET DATEFORMAT dmy;
GO

CREATE TRIGGER tgrAddParcela ON dbo.VENDAS
AFTER INSERT AS
BEGIN
    DECLARE
    @Parc_Now INT,
    @Parc_Total INT,
    @Parc_Data DATE

    SET @Parc_Now = 0
    SET @Parc_Total = (SELECT nParcelas FROM inserted)
    
    WHILE (@Parc_Now < @Parc_Total)
    BEGIN

        SET @Parc_Data = DATEADD(MONTH, @Parc_Now, (SELECT Data_Venda FROM inserted))

        INSERT INTO dbo.PARCELAS VALUES
        (
            (SELECT ID_Venda FROM inserted),
            @Parc_Now + 1,
            @Parc_Data,
            (SELECT Valor_Total / @Parc_Total FROM inserted),
            null,
            null
        );

        SET @Parc_Now += 1

    END
END
GO



-- Inserts
INSERT INTO dbo.VENDAS VALUES
('14-10-2004', 12, 84.84, 2);

-- Selects
SELECT * FROM dbo.VENDAS;
SELECT * FROM dbo.PARCELAS;