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
-- DROP TABLE FIX_FERIADOS
-- GO
-- DROP TABLE MOV_FERIADOS
-- GO
-- DROP FUNCTION MOV_FERIADOS_GET
-- GO
-- DROP FUNCTION GET_PASCOA
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

ALTER TABLE dbo.PARCELAS
ADD Dia_Semana VARCHAR(40);
GO



--------------------------------------
CREATE TABLE FIX_FERIADOS(
    Dia_Mes DATE,
    Descricao_Feriado_FIX VARCHAR(40)
);
GO
-- SELECT * FROM FIX_FERIADOS
INSERT INTO dbo.FIX_FERIADOS VALUES
    ('2021-01-01', 'Ano-Novo'),
    ('2021-04-21', 'Tiradentes'),
    ('2021-05-01', 'Dia do Trabalhador'),
    ('2021-09-07', 'Independência do Brasil'),
    ('2021-10-12', 'Nossa Senhora Aparecida'),
    ('2021-11-02', 'Finados'),
    ('2021-11-15', 'Proclamação da República'),
    ('2021-12-25', 'Natal');
GO

-- DROP TABLE FIX_FERIADOS
--------------------------------------

--------------------------------------
-- Função GETPASCOA
CREATE FUNCTION GET_PASCOA(@y INT)
    RETURNS DATE AS

BEGIN

    DECLARE
    @X1 INT,
    @X2 INT,
    @X3 INT,
    @X4 INT,
    @X5 INT,
    @X6 INT,
    
    @seculo INT,

    @PASCOA DATE,
    @PASCOA_DIA INT,
    @PASCOA_MES INT;

    SET @seculo = @y / 100
    
    SET @X1 = @y % 19
    SET @X2 = (@seculo - 17) / 25
    SET @X3 = (@seculo - CAST(@seculo / 4 AS INT) -CAST((@seculo - @X2) / 3 AS INT) + 19 * @X1 + 15) % 30
    SET @X4 = @X3 - CAST(@X3 / 28 AS INT) * (1 * -CAST(@X3 / 28 AS INT) * CAST(29 / (@X3 + 1) AS INT)) * CAST(((21 -@X1) / 11) AS INT)
    SET @X5 = (@y + CAST(@y / 4 AS INT) + @X4 + 2 - @seculo + CAST(@seculo / 4 AS INT)) % 7
    SET @X6 = @X4 - @X5

    SET @PASCOA_MES = 3 + CAST((@X6 + 40) / 44 AS INT)
    SET @PASCOA_DIA = @X6 + 28 - 31 * CAST((@PASCOA_MES / 4) AS INT)

    SET @PASCOA = CAST(@PASCOA_MES AS VARCHAR(2)) + '-' + CAST(@PASCOA_DIA AS VARCHAR(2)) + '-' + CAST(@y AS VARCHAR(4))

RETURN @PASCOA;
END
GO
--------------------------------------

--------------------------------------
CREATE TABLE MOV_FERIADOS(
    Ano INT,
    Data_Feriado DATE,
    Descricao_Feriado_MOV VARCHAR(40)
);
GO

-- SELECT * FROM MOV_FERIADOS
CREATE FUNCTION MOV_FERIADOS_GET(@y INT = NULL)
    RETURNS @MOV TABLE (Dia_Mes DATE, Descricao_Feriado_MOV VARCHAR(40)) AS

BEGIN

    DECLARE
    @PASCOA DATE,
    @P_DIA INT,
    @P_MES INT,
    @P_ANO INT

    IF(@y IS NULL)
    BEGIN
        SET @y = DATEPART(year, GETDATE());
    END

    SET @PASCOA = dbo.GET_PASCOA(@y);
    SET @P_DIA = DATEPART(day, @PASCOA);
    SET @P_MES = DATEPART(month, @PASCOA);
    SET @P_ANO = DATEPART(year, @PASCOA)
    
    INSERT INTO @MOV (Dia_Mes, Descricao_Feriado_MOV) VALUES
    (DATEADD(day, -2, @PASCOA), '6ª Feira Santa'),
    (DATEADD(day, -47, @PASCOA), 'Carnaval'),
    (DATEADD(day, -60, @PASCOA), 'Corpus Christi'),
    (DATEADD(day, -46, @PASCOA), '4ª Feira de Cinzas')

    RETURN;
END
GO

SELECT * FROM dbo.MOV_FERIADOS_GET(2021)
SELECT * FROM dbo.MOV_FERIADOS_GET(2020)
GO
-- DROP TABLE MOV_FERIADOS
--------------------------------------





-- Trigger
SET DATEFORMAT dmy;
GO

CREATE TRIGGER tgrAddParcela ON dbo.VENDAS
AFTER INSERT AS
BEGIN
    -- Declarando as variáveis locais do trigger
    DECLARE
    @Parc_Now INT,
    @Parc_Total INT,
    @Parc_Data DATE,
    @Parc_Ano INT

    -- Atribuindo o valor de @Parc_Now e @Parc_Total
    SET @Parc_Now = 0
    SET @Parc_Total = (SELECT nParcelas FROM inserted)
    
    -- Enquanto existirem parcelas a serem pagas?
    WHILE (@Parc_Now < @Parc_Total)
    BEGIN

        -- Atribuindo o valor de @Parc_Data e @Parc_Ano
        SET @Parc_Data = DATEADD(MONTH, @Parc_Now, (SELECT Data_Venda FROM inserted))
        SET @Parc_Ano = CAST(YEAR(@Parc_Data) AS INT)

        WHILE(
            -- Verificando se o Dia e o Mês da parcela estão dentro da tabela de Feriados Fixos:
            CONVERT(VARCHAR, DATEPART(day, @Parc_Data)) + '-' +
            CONVERT(VARCHAR, DATEPART(month, @Parc_Data))
            IN (SELECT CONVERT(VARCHAR, DATEPART(day, Dia_Mes)) + '-' +
            CONVERT(VARCHAR, DATEPART(month, Dia_Mes)) FROM FIX_FERIADOS)

            OR

            -- Ou se estão dentro da tabela de Feriados Móveis
            @Parc_Data IN (SELECT Dia_Mes FROM dbo.MOV_FERIADOS_GET(@Parc_Ano))
        )
        
        BEGIN
            -- Adicionando +1 dia no valor de @Parc_Data
            SET @Parc_Data = DATEADD(day, 1, @Parc_Data)
        END

        -- Se o dia da parcela for Sábado:
        IF (DATENAME(weekday, @Parc_Data)) = 'Sábado'
            -- Adicionar +2 dias no valor de @Parc_Data (para cair na Segunda)
            SET @Parc_Data = DATEADD(day, 2, @Parc_Data);
        
        -- Se o dia da parcela for Domingo:
        ELSE IF (DATENAME(weekday, @Parc_Data)) = 'Domingo'
            -- Adicionar +1 dia no valor de @Parc_Data (para cair na Segunda)
            SET @Parc_Data = DATEADD(day, 1, @Parc_Data);

        -- Preenchendo os campos da tabela Parcelas após a verificação dos feriados
        INSERT INTO dbo.PARCELAS VALUES
        (
            (SELECT ID_Venda FROM inserted),
            @Parc_Now + 1,
            @Parc_Data,
            (SELECT Valor_Total / @Parc_Total FROM inserted),
            null,
            null,
            DATENAME(weekday, @Parc_Data)
        );

        SET @Parc_Now += 1

    END
END
GO
-- DROP TRIGGER tgrAddParcela



-- Inserts
INSERT INTO dbo.VENDAS VALUES
('14-10-2004', 12, 84.84, 2);

-- Selects
SELECT * FROM dbo.VENDAS;
SELECT * FROM dbo.PARCELAS;





-- 1) Criar as tabelas FeriadosFixos (FIX_FERIADOS) e FeriadosMóveis (MOV_FERIADOS)
-- 2) Adicionar uma coluna de Dia_Semana na tabela dbo.PARCELAS