CREATE DATABASE bdLivraria
GO
USE bdLivraria
CREATE TABLE tbAutor(
	codigoAutor		INTEGER NOT NULL
	,	nome		VARCHAR(100)
	,	nascimento	DATE
	,	pais		VARCHAR(50)
	,	biografia	VARCHAR(MAX)
	PRIMARY KEY (codigoAutor) 
);
CREATE TABLE tbLivro(
	codigoLivro	INTEGER NOT NULL
	,	nome	VARCHAR(100)
	,	lingua	VARCHAR(50)
	,	ano		INTEGER
	PRIMARY KEY(codigoLivro)
);
CREATE TABLE tbEditora(
	codigoEditora	INTEGER NOT NULL
	,	nome		VARCHAR(50)
	,	logradouro	VARCHAR(255)
	,	numero		INTEGER
	,	cep			CHAR(8)
	,	telefone	CHAR(11)
	PRIMARY KEY (codigoEditora)
);
CREATE TABLE tbEdicoes(
	isbn			INTEGER NOT NULL
	,	preco		DECIMAL(7,2)
	,	ano			INTEGER
	,	numPaginas	INTEGER
	,	qtdEstoque	INTEGER
	PRIMARY KEY(isbn)
);
GO
CREATE TABLE tbLivroAutor(
	codigoLivro_Livro		INTEGER
	,	codigoAutor_Autor	INTEGER
	PRIMARY KEY(codigoLivro_Livro,codigoAutor_Autor)
	FOREIGN KEY (codigoLivro_Livro)		REFERENCES tbLivro(codigoLivro)
	,	FOREIGN KEY (codigoAutor_Autor) REFERENCES tbAutor(codigoAutor)
);
CREATE TABLE tbLivroEdicoesEditora(
	edicoesIsbn				  INTEGER NOT NULL
	,	codigoEditora_editora INTEGER NOT NULL
	,	codigoLivro_Livro	  INTEGER NOT NULL
	PRIMARY KEY (edicoesIsbn,codigoEditora_editora,codigoLivro_Livro)
	FOREIGN KEY (edicoesIsbn)				REFERENCES tbEdicoes(isbn)
	,	FOREIGN KEY (codigoEditora_editora)	REFERENCES tbEditora(codigoEditora)
	,	FOREIGN KEY (codigoLivro_Livro)		REFERENCES tbLivro(codigoLivro)	
);
--==============================MODIFICACOES=====================
EXEC sp_rename 'dbo.tbEdicoes.ano','anoEdicao','COLUMN'

ALTER TABLE tbEditora
ALTER COLUMN nome VARCHAR(30)

ALTER TABLE tbAutor
DROP COLUMN nascimento
ALTER TABLE tbAutor
ADD nascimento INTEGER
--==============================INSERTS=====================
INSERT INTO tbLivro (codigoLivro,nome,lingua,ano) 
	VALUES
		(1001,'CCNA 4.1','PT-BR',2015)
		,	(1002,'HTML 5','PT-BR',2017)
		,	(1003,'Redes de Computadores','EN',2010)
		,	(1004,'Android em Ação','PT-BR',2018)
		
INSERT INTO tbAutor (codigoAutor,nome,nascimento,pais,biografia)
	VALUES
		(10001,'Inácio da Silva',1975,'Brasil','Programador WEB desde 1995')
		,	(10002,'Andrew Tannenbaum',1944,'EUA','Chefe do Departamento de Sistemas de Computação da Universidade de Vrij')
		,	(10003,'Luis Rocha',1967,'Brasil','Programador Mobile desde 2000')
		,	(10004,'David Halliday',1916,'EUA','Físico PH.D desde 1941')

INSERT INTO tbLivroAutor (codigoLivro_Livro,codigoAutor_Autor)
	VALUES
		(1001,10001)
		,	(1002,10003)
		,	(1003,10002)
		,	(1004,10003)
		
INSERT INTO tbEdicoes (isbn,preco,anoEdicao,numPaginas,qtdEstoque)
	VALUES
		(0130661023,189.99,2018,653,10)
		
--============================Atualizacoes====================
UPDATE tbAutor
SET biografia = 'Chefe do Departamento de Sistemas de Computação da Universidade de Vrije'
WHERE codigoAutor = 10002

UPDATE tbEdicoes
SET qtdEstoque = qtdEstoque-2
WHERE isbn = 0130661023

DELETE FROM tbAutor
WHERE codigoAutor = 10004