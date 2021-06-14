-- Lista 3 SQL
USE VIDEOLOCADORA

/*
1 - Realizar a inserção de um novo cliente, 
os dados de cadastro são o seguinte:

a - RG: 222.123.234-80
b - Nome: Dino da Silva Sauro
c - Endereço: Rua Joaquim Silveira, 34
d - Bairro: Jd. Romano
e - Cidade: São Roque
f - Estado: SP
g - Sexo: m
*/
SET DATEFORMAT ymd;
INSERT INTO dbo.CLIENTES VALUES
('212312312', 'Dino da Silva Sauro', 'Rua Joaquim Silveira, 34', 'Jd. Romano',
'São Roque', 'SP', '998999887', 'dino@gmail.com', '1981-03-21', 'm');

/*
2 -  O Cliente Dino realizou a locação de
dois filmes no dia de hoje, os filmes foram:

a - Amadeus
b - Constantine
*/
INSERT INTO dbo.LOCACOES VALUES
(11, 11, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + DAY(2)),
(11, 8, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + DAY(2));

UPDATE dbo.FILME
SET RESERVADA = 's'
WHERE FILME = 'Amadeus'

UPDATE dbo.FILME
SET RESERVADA = 's'
WHERE FILME = 'Constantine'

/*
3 - Nesse mesmo dia um pouco antes chegou um novo 
lançamento de filme, o filme Missão Impossível 3 
e o cliente Dino da Silva Sauro ficou interessado 
em alugar junto com os outros dois filmes, para 
que essa locação seja realizada é necessário 
cadastrar o filme:

a - Filme: Missão Impossível 3
b - COD_CATEGORIA: 1
c - Diretor: J.J.Abrams
d - Valor: R$7.00

Após realizar o cadastro do filme, registrar junto
com a locação dos filmes Amadeus e Constantine do
cliente Dino da Silva Sauro
*/
INSERT INTO dbo.FILME VALUES
('Missão Impossível 3', 1, 'J. J. Abrams', 7.00, 'n');

INSERT INTO dbo.LOCACOES VALUES
(11, 20, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + DAY(2))

UPDATE dbo.FILME
SET RESERVADA = 's'
WHERE FILME = 'Missão Impossível 3';

/*
4 - Atualizar o nome da categoria "Desenho"
para "Animação"
*/
UPDATE dbo.CATEGORIA
SET NOME_CATEGORIA = 'Animação'
WHERE COD_CATEGORIA = 7

/*
5 - Um cliente ligrou e pediu para deixar 
reservado todos os filmes do diretor "Terry
Gilliam", realizar essa atualização:
*/
UPDATE dbo.FILME
SET RESERVADA = 's'
WHERE DIRETOR = 'Terry Gilliam'

/*
6 - O cliente "Rafael Nunes Sales" mudou
para a "Rua Guilherme Orlando, 333" no
"Jd. Santa Rosália" e seu novo telefone
é "1532145543", realizar essas atualizações:
*/
UPDATE dbo.CLIENTES
SET
    [ENDERECO] = 'Rua Guilherme Orlando, 333',
    [BAIRRO] = 'Jd. Santa Rosália',
    [TELEFONE] = '1532145543'
WHERE NOME = 'Rafael Nunes Sales'

/*
7 - Atualizar o nome das categorias de
filmes deixando-as com todas as letras
maiúsculas
*/
UPDATE dbo.CATEGORIA
SET NOME_CATEGORIA = UPPER(NOME_CATEGORIA)

/*
8 - Realizar um ajuste no valor do filme
para 50% no valor atual para os filmes
"A Mexicana", "A Verdade Nua e Crua"
e "Austrália"
*/
UPDATE dbo.FILME
SET VALOR_LOCACAO = VALOR_LOCACAO * 0.5
WHERE FILME IN ('A Mexicana', 'A Verdade Nua e Crua', 'Austrália')

/*
9 - Excluir todas as categorias de filmes
que não possuem filmes cadastrados
*/
DELETE cat
FROM dbo.CATEGORIA cat
LEFT JOIN dbo.FILME fil
    on cat.COD_CATEGORIA = fil.COD_CATEGORIA
WHERE fil.FILME IS NULL;

/*
10 - Inserir o seu registro na tabela
de clientes:
*/
SET DATEFORMAT ymd
INSERT INTO dbo.CLIENTES VALUES
('999999999', 'Filipe Vieira Campos', 'Baker Street, 221B', 'West End',
'Londres', 'LD', '996530798', 'filipe.campos@etec.sp.gov.br',
'2004-10-14 00:04:00.000', 'm')



-- SELECTS Finais
SELECT * FROM dbo.LOCACOES
SELECT * FROM dbo.FILME
SELECT * FROM dbo.CLIENTES
SELECT * FROM dbo.CATEGORIA

















