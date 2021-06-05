--CRIACAO DO BANCO DE DADOS
CREATE DATABASE BDVENDAS

--BANCO QUE SERA UTILIZADO
USE BDVENDAS

--CRIAÇÃO DE TABELA DE PERMISSOES
CREATE TABLE tblPermissoes
(
per_id INT IDENTITY(1,1) PRIMARY KEY,
per_tipoPermissao VARCHAR(1) NOT NULL,
per_descricao VARCHAR(50) NOT NULL
)

--CRIAÇÃO DA TABELA DE FUNCIONÁRIOS
CREATE TABLE tblFuncionarios
(
fun_id INT IDENTITY(1,1) PRIMARY KEY,
fun_nome VARCHAR(50) NOT NULL,
fun_senha VARCHAR(50) NOT NULL,
fun_per_id INT NOT NULL --chave estrangeira
)

--CRIAÇÃO DA TABELA DE ENDEREÇO
CREATE TABLE tblEndereco
(
end_id INT IDENTITY(1,1) PRIMARY KEY,
end_rua VARCHAR(50) NOT NULL,
end_bairro VARCHAR(50) NOT NULL,
end_numero INT NOT NULL,
end_cidade VARCHAR(50) NOT NULL,
end_cep VARCHAR(50) NOT NULL
)
--CRIAÇÃO DA TABELA DE CLIENTE
CREATE TABLE tblClientes
(
cli_id INT IDENTITY(1,1) PRIMARY KEY,
cli_rg VARCHAR(50) NOT NULL,
cli_cpf VARCHAR(50) NOT NULL,
cli_telefone VARCHAR (1) NOT NULL,
cli_email VARCHAR(50) NOT NULL,
cli_end_id VARCHAR(50) NOT NULL, --chave estrangeira
cli_dataCadastro DATETIME NOT NULL
)
--CRIAÇÃO DA TABELA DE CATEGORIA
CREATE TABLE tblCategoria
(
cat_id INT IDENTITY(1,1) PRIMARY KEY,
cat_descricao VARCHAR(50)
)
--CRIAÇÃO DA TABELA DE PRODUTOS
CREATE TABLE tblProdutos
(
prd_id INT IDENTITY(1,1) PRIMARY KEY,
prd_cat_id INT, --chave estrangeira
prd_descricao VARCHAR(50),
prd_preco MONEY,
prd_codigoBarras INT,
prd_fabricante VARCHAR(50),
prd_quantidade INT,
prd_plataforma VARCHAR(50),
prd_prazoGarantia INT
)
--CRIAÇÃO DA TABELA DE PAGAMENTO
CREATE TABLE tblPagamento
(
pag_id INT IDENTITY(1,1) PRIMARY KEY,
pag_status VARCHAR(1),
pag_descricao VARCHAR(50) 
)
--CRIAÇÃO DA TABELA DE STATUS DE VENDA
CREATE TABLE tblStatusVenda
(
svn_id INT IDENTITY(1,1) PRIMARY KEY,
svn_descricao VARCHAR(50)
)
--CRIAÇÃO DA TABELA DE VENDA
CREATE TABLE tblVendas
(
ven_id INT IDENTITY(1,1) PRIMARY KEY,
ven_cli_id INT,
ven_prd_id INT,
ven_codigoUnico INT,
ven_dataVenda DATETIME,
ven_preco MONEY,
ven_quantidadeVendida INT,
ven_svn_id INT, --chave estrangeira
ven_pag_id INT
)

--CRIAR PROCIDURE PARA INSERIR PERMISSÕES
GO
CREATE PROCEDURE inserirPermissoes --- Declarando o nome da procedure
@per_tipoPermissao AS VARCHAR(1),
@per_descricao AS VARCHAR(50) --- Declarando
AS
--EXECUTAR A PROCIDURE
--EXEC inserirPermissoes @per_tipoPermissao='A', @per_descricao='Atendente'
--EXEC inserirPermissoes @per_tipoPermissao='E', @per_descricao='Estoquista'
--EXEC inserirPermissoes @per_tipoPermissao='S', @per_descricao='Supervisor'
BEGIN
	INSERT INTO tblPermissoes
	VALUES(@per_tipoPermissao, @per_descricao)
END
--CRIAR PROCIDURE PARA UPDATE PERMISSÕES
GO
CREATE PROCEDURE atualizaPermissoes --- Declarando o nome da procedure
@per_id AS INT,
@per_tipoPermissao AS VARCHAR(1),
@per_descricao AS VARCHAR(50) --- Declarando variável
AS
--EXECUTAR PROCIDURE
--EXEC atualizaPermissoes @per_id=1, @per_tipoPermissao='A', @per_descricao='Atendente'
BEGIN
	UPDATE tblPermissoes
	SET per_tipoPermissao = @per_tipoPermissao,
		per_descricao = @per_descricao
	WHERE per_id = @per_id
END
--CRIAR PROCIDURE PARA CONSULTAR PERMISSÕES
GO
CREATE PROCEDURE consultaPermissoes --- Declarando o nome da procedure
AS
--EXEC consultaPermissoes
BEGIN
	SELECT * FROM tblPermissoes
END


--CRIAR PROCIDURE PARA INSERIR FUNCIONÁRIOS
GO
CREATE PROCEDURE inserirFuncionarios --- Declarando o nome da procedure
@fun_nome AS VARCHAR(50),
@fun_senha AS VARCHAR(50),
@fun_per_id AS INT
AS
--EXECUTAR A PROCIDURE
--EXEC inserirFuncionarios @fun_nome='LAIZA', @fun_senha='12345', @fun_per_id=1
--EXEC inserirFuncionarios @fun_nome='MARIA', @fun_senha='23456', @fun_per_id=1
--EXEC inserirFuncionarios @fun_nome='JOÃO', @fun_senha='34567', @fun_per_id=2
--EXEC inserirFuncionarios @fun_nome='JOÃO', @fun_senha='34567', @fun_per_id=3
BEGIN
	INSERT INTO tblFuncionarios
	VALUES(@fun_nome, @fun_senha, @fun_per_id)
END
--CRIAR PROCIDURE PARA UPDATE FUNCIONARIOS
GO
CREATE PROCEDURE atualizafuncionarios
@fun_id AS INT,
@fun_nome AS VARCHAR(50),
@fun_senha AS VARCHAR(50),
@fun_per_id AS INT
AS
--EXECUTAR PROCIDURE
--EXEC atualizafuncionarios @fun_id=1, @fun_nome='LAIZA L.', @fun_senha='12345678', @fun_per_id=1
--EXEC atualizafuncionarios @fun_id=2, @fun_nome='FERNANDA', @fun_senha='12345678', @fun_per_id=2
--EXEC atualizafuncionarios @fun_id=3, @fun_nome='JUAN', @fun_senha='12345678', @fun_per_id=3
BEGIN
	UPDATE tblFuncionarios
	SET fun_nome = @fun_nome,
		fun_senha = @fun_senha,
		fun_per_id = @fun_per_id
	WHERE fun_id = @fun_id
END
--CRIAR PROCIDURE PARA CONSULTAR FUNCIONARIOS
GO
CREATE PROCEDURE consultaFuncionarios --- Declarando o nome da procedure
AS
--EXEC consultaFuncionarios
BEGIN
	SELECT t1.*, per_descricao FROM tblFuncionarios t1 
	JOIN tblPermissoes t2 ON (t1.fun_per_id = per_id)
END




--CRIAR PROCIDURE PARA INSERIR ENDEREÇOS
GO
CREATE PROCEDURE inserirEndereco --- Declarando o nome da procedure
@end_rua AS VARCHAR(50),
@end_bairro AS VARCHAR(50),
@end_numero AS INT,
@end_cidade AS VARCHAR(50),
@end_cep AS VARCHAR(50)
AS
--EXECUTAR A PROCIDURE
--EXEC inserirEndereco @end_rua = 'Rua Quinze De Novembro', @end_bairro='Bela Vista', @end_numero=603, @end_cidade='Engenheiro Coelho', @end_cep ='1610210'
--EXEC inserirEndereco @end_rua = 'Rua Santos Dumont', @end_bairro='Itaquera', @end_numero=306, @end_cidade='Campinas', @end_cep=896325
BEGIN
	INSERT INTO tblEndereco
	VALUES(@end_rua, @end_bairro, @end_numero, @end_cidade, @end_cep)
END
--CRIAR PROCIDURE PARA UPDATE ENDEREÇO
GO
CREATE PROCEDURE atualizaEndereco
@end_id AS INT,
@end_rua AS VARCHAR(50),
@end_bairro AS VARCHAR(50),
@end_numero AS INT,
@end_cidade AS VARCHAR(50),
@end_cep AS VARCHAR(50)
AS
--EXECUTAR PROCIDURE
--EXEC atualizaEndereco @end_id=1, @end_rua='Rua Santos Dumont', @end_bairro='Vila Prudente', @end_numero=390, @end_cidade='Engenheiro Coelho', @end_cep=168930
BEGIN
	UPDATE tblEndereco
	SET end_rua = @end_rua,
		end_bairro = @end_bairro,
		end_numero = @end_numero,
		end_cidade = @end_cidade,
		end_cep = @end_cep
	WHERE end_id = @end_id
END
--CRIAR PROCIDURE PARA CONSULTAR ENDEREÇOS
GO
CREATE PROCEDURE consultaEndereco --- Declarando o nome da procedure
AS
--EXEC consultaEndereco
BEGIN
	SELECT * FROM tblEndereco
END
--CRIAR PROCIDURE PARA INSERIR CLIENTES
GO
CREATE PROCEDURE inserirClientes --- Declarando o nome da procedure
@fun_id INT,
@cli_rg VARCHAR(50),
@cli_cpf VARCHAR(50),
@cli_telefone VARCHAR (1),
@cli_email VARCHAR(50),
@cli_end_id VARCHAR(50), --chave estrangeira
@cli_dataCadastro DATETIME
AS
--EXECUTAR A PROCIDURE
--EXEC inserirClientes @fun_id = 1,@cli_rg='123412341234', @cli_cpf='123412341234', @cli_telefone='1999999999', @cli_email='laiza_teste@teste.com', @cli_end_id='1', @cli_dataCadastro='20/11/2020'
--EXEC inserirClientes @fun_id = 2,@cli_rg='777777777777', @cli_cpf='777777777777', @cli_telefone='1911111111', @cli_email='maria_teste@teste.com', @cli_end_id='2', @cli_dataCadastro='01/06/2021'
BEGIN
	INSERT INTO tblClientes
	VALUES(@cli_rg, @cli_cpf, @cli_telefone, 
	@cli_email, @cli_end_id, @cli_dataCadastro)
END
--CRIAR PROCIDURE PARA UPDATE ENDEREÇO
GO
CREATE PROCEDURE atualizaCliente
@cli_id AS INT,
@cli_rg AS VARCHAR(50),
@cli_cpf AS VARCHAR(50),
@cli_telefone AS VARCHAR (1),
@cli_email AS VARCHAR(50),
@cli_end_id AS VARCHAR(50), --chave estrangeira
@cli_dataCadastro AS DATETIME
AS
--EXECUTAR PROCIDURE
--EXEC atualizaCliente @cli_id = 2 , @cli_rg='888888888888', @cli_cpf='777777777777', @cli_telefone='1911111111', @cli_email='maria_teste@teste.com', @cli_end_id='2', @cli_dataCadastro='01/06/2021'
BEGIN
	UPDATE tblClientes
	SET cli_rg = @cli_rg,
		cli_cpf = @cli_cpf,
		cli_telefone = @cli_telefone,
		cli_email = @cli_email,
		cli_end_id = @cli_end_id,
		cli_dataCadastro = @cli_dataCadastro
	WHERE cli_id = @cli_id
END
--CRIAR PROCIDURE PARA CONSULTAR CLIENTES
GO
CREATE PROCEDURE consultaClientes --- Declarando o nome da procedure
AS
--EXEC consultaClientes
BEGIN
	SELECT t1.*, t2.* FROM tblClientes t1
	JOIN tblEndereco t2 ON (t1.cli_end_id = t2.end_id)
END
--CRIAR PROCIDURE PARA INSERIR CATEGORIA
GO
CREATE PROCEDURE inserirCategoria --- Declarando o nome da procedure
@cat_descricao AS VARCHAR(50)
AS
--EXECUTAR A PROCIDURE
--EXEC inserirCategoria @cat_descricao='acessórios'
--EXEC inserirCategoria @cat_descricao='acessórios'
--EXEC inserirCategoria @cat_descricao='produtos geek'
BEGIN
	INSERT INTO tblCategoria
	VALUES(@cat_descricao)
END
--CRIAR PROCIDURE PARA UPDATE CATEGORIA
GO
CREATE PROCEDURE atualizaCategoria
@cat_id AS INT,
@cat_descricao AS VARCHAR(50)
AS
--EXECUTAR PROCIDURE
--EXEC atualizaCategoria @cat_id = 1 , @cat_descricao='jogos'
BEGIN
	UPDATE tblCategoria
	SET cat_descricao = @cat_descricao
	WHERE cat_id = @cat_id
END
--CRIAR PROCIDURE PARA CONSULTAR CATEGORIA
GO
CREATE PROCEDURE consultaCategoria --- Declarando o nome da procedure
AS
--EXEC consultaCategoria
BEGIN
	SELECT * from tblCategoria
END




--CRIAR PROCIDURE PARA INSERIR PRODUTOS
GO
CREATE PROCEDURE inserirProdutos --- Declarando o nome da procedure
@fun_id AS INT,
@prd_cat_id AS INT, --chave estrangeira
@prd_descricao AS VARCHAR(50),
@prd_preco AS MONEY,
@prd_codigoBarras AS INT,
@prd_fabricante AS VARCHAR(50),
@prd_quantidade AS INT,
@prd_plataforma AS VARCHAR(50),
@prd_prazoGarantia AS INT
AS
--EXECUTAR A PROCIDURE
--EXEC inserirProdutos @fun_id = 2, @prd_cat_id='2', @prd_descricao='GTA V', @prd_preco='50,00', @prd_codigoBarras='01020304', @prd_fabricante='Rockstar Games', @prd_quantidade=2, @prd_plataforma='console', @prd_prazoGarantia='5'
BEGIN
    DECLARE @permissao INT
	SET @permissao = (
	SELECT t2.fun_per_id FROM tblPermissoes t1 
	JOIN tblFuncionarios t2 ON (t1.per_id = t2.fun_per_id) 
	WHERE t2.fun_id = @fun_id
	)
	--VERIFICA SE FUNCIONARIO É DO TIPO ESTOQUISTA
	IF(@permissao = 2)
		BEGIN
			INSERT INTO tblProdutos
			VALUES(
			@prd_cat_id, @prd_descricao, @prd_preco, 
			@prd_codigoBarras, @prd_fabricante, @prd_quantidade, 
			@prd_plataforma, @prd_prazoGarantia
			)
		END
	ELSE PRINT 'USUARIO NAO POSSUI PERMISSAO'
END
--CRIAR PROCIDURE PARA UPDATE PRODUTOS
GO
CREATE PROCEDURE atualizaProdutos
@fun_id AS INT,
@prd_id AS INT,
@prd_cat_id AS INT, --chave estrangeira
@prd_descricao AS VARCHAR(50),
@prd_preco AS MONEY,
@prd_codigoBarras AS INT,
@prd_fabricante AS VARCHAR(50),
@prd_quantidade AS INT,
@prd_plataforma AS VARCHAR(50),
@prd_prazoGarantia AS INT
AS
--EXECUTAR PROCIDURE
--EXEC atualizaProdutos @fun_id = 2, @prd_id = 1, @prd_cat_id='1', @prd_descricao='GTA V', @prd_preco='50,00', @prd_codigoBarras='1234567', @prd_fabricante='Rockstar Games', @prd_quantidade=3, @prd_plataforma='console', @prd_prazoGarantia='4'
BEGIN
 DECLARE @permissao INT
	SET @permissao = (
	SELECT t2.fun_per_id FROM tblPermissoes t1 
	JOIN tblFuncionarios t2 ON (t1.per_id = t2.fun_per_id) WHERE t2.fun_id = @fun_id)
	--VERIFICA SE FUNCIONARIO É DO TIPO ESTOQUISTA
	IF(@permissao = 2)
		BEGIN
	UPDATE tblProdutos
	SET prd_cat_id = @prd_cat_id, 
		prd_descricao = @prd_descricao, 
		prd_preco = @prd_preco, 
		prd_codigoBarras = @prd_codigoBarras, 
		prd_fabricante = @prd_fabricante, 
		prd_quantidade = @prd_quantidade, 
		prd_plataforma = @prd_plataforma, 
		prd_prazoGarantia = @prd_prazoGarantia
	WHERE prd_id = @prd_id
		END
	ELSE PRINT 'USUARIO NAO POSSUI PERMISSAO'
END
--CRIAR PROCIDURE PARA CONSULTAR PRODUTOS
GO
CREATE PROCEDURE consultaProdutos --- Declarando o nome da procedure
AS
--EXEC consultaProdutos
BEGIN
	SELECT t1.*, t2.cat_descricao from tblProdutos t1
	JOIN tblCategoria t2 ON (t1.prd_cat_id = t2.cat_id)
END





--CRIAR PROCIDURE PARA INSERIR PAGAMENTO
GO
CREATE PROCEDURE inserirPagamento --- Declarando o nome da procedure
@pag_status AS VARCHAR(1),
@pag_descricao AS VARCHAR(50) 
AS
--EXECUTAR A PROCIDURE
--EXEC inserirPagamento @pag_status='A', @pag_descricao='Aprovado'
--EXEC inserirPagamento @pag_status='R', @pag_descricao='Recusado'
--EXEC inserirPagamento @pag_status='E', @pag_descricao='Em Andamento'
BEGIN
    INSERT INTO tblPagamento
	VALUES(@pag_status, @pag_descricao)
END
--CRIAR PROCIDURE PARA UPDATE PAGAMENTO
GO
CREATE PROCEDURE atualizaPagamento
@pag_id AS INT,
@pag_status AS VARCHAR(1),
@pag_descricao AS VARCHAR(50) 
AS
--EXECUTAR PROCIDURE
--EXEC atualizaPagamento @pag_id=1, @pag_status='A', @pag_descricao='Aprovado'
BEGIN
	UPDATE tblPagamento
	SET pag_status = @pag_status, 
		pag_descricao = @pag_descricao
	WHERE pag_id = @pag_id
END
--CRIAR PROCIDURE PARA CONSULTAR PAGAMENTO
GO
CREATE PROCEDURE consultaPagamento --- Declarando o nome da procedure
AS
--EXEC consultaPagamento
BEGIN
	SELECT * from tblPagamento
END









--CRIAR PROCIDURE PARA INSERIR STATUS VENDA
GO
CREATE PROCEDURE inserirStatusVenda --- Declarando o nome da procedure
@svn_descricao AS VARCHAR(50)
AS
--EXECUTAR A PROCIDURE
--EXEC inserirStatusVenda @svn_descricao = 'Aguardando Aprovacao'
--EXEC inserirStatusVenda @svn_descricao = 'Recusado'
--EXEC inserirStatusVenda @svn_descricao = 'Aprovado'
BEGIN
    INSERT INTO tblStatusVenda
	VALUES(@svn_descricao)
END
--CRIAR PROCIDURE PARA UPDATE STATUS VENDA
GO
CREATE PROCEDURE atualizaStatusVenda
@svn_id AS INT,
@svn_descricao AS VARCHAR(50) 
AS
--EXECUTAR PROCIDURE
--EXEC atualizaStatusVenda @svn_id = 1, @svn_descricao = 'Aprovado'
BEGIN
	UPDATE tblStatusVenda
	SET svn_descricao = @svn_descricao
	WHERE svn_id = @svn_id
END
--CRIAR PROCIDURE PARA CONSULTAR STATUS VENDA
GO
CREATE PROCEDURE consultaStatusVenda --- Declarando o nome da procedure
AS
--EXEC consultaStatusVenda
BEGIN
	SELECT * from tblStatusVenda
END



















--CRIAR PROCIDURE PARA INSERIR VENDAS
GO
CREATE PROCEDURE inserirVendas --- Declarando o nome da procedure
@ven_cli_id AS INT,
@ven_prd_id AS INT,
@ven_codigoUnico AS INT,
@ven_dataVenda AS DATETIME,
@ven_quantidadeVendida AS INT,
@ven_svn_id AS INT, --chave estrangeira
@ven_pag_id AS INT
AS
--EXECUTAR A PROCIDURE
--EXEC inserirVendas @ven_cli_id = 1, @ven_prd_id = 1, @ven_codigoUnico = 320, @ven_dataVenda='20/05/2021', @ven_quantidadeVendida=5, @ven_svn_id=1, @ven_pag_id=3
--EXEC inserirVendas @ven_cli_id = 1, @ven_prd_id = 1, @ven_codigoUnico = 320, @ven_dataVenda='20/05/2021', @ven_quantidadeVendida=1, @ven_svn_id=1, @ven_pag_id=3
BEGIN
	DECLARE @preco MONEY
	SET @preco = (SELECT prd_preco FROM tblProdutos WHERE prd_id = @ven_prd_id)
	SET @preco = (@preco * @ven_quantidadeVendida)
    INSERT INTO tblVendas
	VALUES(@ven_cli_id, @ven_prd_id, @ven_codigoUnico, @ven_dataVenda, @preco, @ven_quantidadeVendida, @ven_svn_id, @ven_pag_id)
END
--CRIAR PROCIDURE PARA UPDATE VENDAS
GO
CREATE PROCEDURE atualizaVendas
@ven_id AS INT,
@ven_cli_id AS INT,
@ven_prd_id AS INT,
@ven_codigoUnico AS INT,
@ven_dataVenda AS DATETIME,
@ven_quantidadeVendida AS INT,
@ven_pag_id AS INT
AS
--EXECUTAR PROCIDURE
--EXEC atualizaVendas @ven_id=1, @ven_cli_id = 1, @ven_prd_id = 1, @ven_codigoUnico = 320, @ven_dataVenda='20/05/2021', @ven_quantidadeVendida=1, @ven_pag_id=1
BEGIN
	DECLARE @preco MONEY
	SET @preco = (SELECT prd_preco FROM tblProdutos WHERE prd_id = @ven_prd_id)
	SET @preco = (@preco * @ven_quantidadeVendida)
		IF(@ven_pag_id = 1)
			BEGIN
				UPDATE tblVendas
				SET ven_cli_id = @ven_cli_id,
					ven_prd_id = @ven_prd_id, 
					ven_codigoUnico = @ven_codigoUnico, 
					ven_dataVenda = @ven_dataVenda, 
					ven_preco = @preco, 
					ven_quantidadeVendida = @ven_quantidadeVendida, 
					ven_svn_id = 3, 
					ven_pag_id = @ven_pag_id
				WHERE ven_id = @ven_id
			END
		ELSE 
			BEGIN
				UPDATE tblVendas
				SET ven_cli_id = @ven_cli_id,
					ven_prd_id = @ven_prd_id, 
					ven_codigoUnico = @ven_codigoUnico, 
					ven_dataVenda = @ven_dataVenda, 
					ven_preco = @preco, 
					ven_quantidadeVendida = @ven_quantidadeVendida,
					ven_svn_id = 2, 
					ven_pag_id = @ven_pag_id
				WHERE ven_id = @ven_id
				PRINT 'PAGAMENTO RECUSADO'
			END
END
--CRIAR PROCIDURE PARA CONSULTAR VENDAS
GO
CREATE PROCEDURE consultaVendas --- Declarando o nome da procedure
AS
--EXEC consultaVendas
BEGIN
	SELECT t1.ven_id AS id, t1.ven_cli_id as idCliente, 
	t1.ven_codigoUnico as codigoUnico, t1.ven_dataVenda as dataVenda, 
	t1.ven_quantidadeVendida as quantidade, t3.svn_descricao as StatusVenda,
	t2.pag_descricao, t1.ven_preco
	from tblVendas t1
	JOIN tblPagamento t2 ON(t1.ven_pag_id = t2.pag_id)
	JOIN tblStatusVenda t3 ON(t1.ven_svn_id = t3.svn_id)
	JOIN tblClientes t4 ON(t1.ven_cli_id = t4.cli_id)
END
--CRIAR PROCIDURE PARA DELETAR PRODUTO DA VENDA
GO
CREATE PROCEDURE excluiProdutos --- Declarando o nome da procedure
@ven_id AS INT,
@fun_id AS INT
AS
--EXEC excluiProdutos @ven_id=1, @fun_id=1 
BEGIN

	DECLARE @permissao INT
	SET @permissao = (SELECT t2.fun_per_id FROM tblPermissoes t1 
	JOIN tblFuncionarios t2 ON (t1.per_id = t2.fun_per_id) WHERE t2.fun_id = @fun_id)
	--VERIFICA SE FUNCIONARIO É DO TIPO ATENDENTE OU SUPERVISOR
	IF(@permissao = 1 OR @permissao = 3)
		BEGIN
			DELETE FROM tblVendas WHERE ven_id = @ven_id
		END
END