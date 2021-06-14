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
('212312312', 'Dino da Silva Sauro', 'Rua Joaquim Silveira, 34', 'Jd. Romano', 'São Roque', 'SP', '998999887', 'dino@gmail.com', '1981-03-21', 'm');

/*
2 -  O Cliente Dino realizou a locação de
dois filmes no dia de hoje, os filmes foram:

a - Amadeus
b - Constantine
*/
INSERT INTO dbo.LOCACOES VALUES
(13, 11, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + DAY(2)),
(13, 8, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + DAY(2));

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













