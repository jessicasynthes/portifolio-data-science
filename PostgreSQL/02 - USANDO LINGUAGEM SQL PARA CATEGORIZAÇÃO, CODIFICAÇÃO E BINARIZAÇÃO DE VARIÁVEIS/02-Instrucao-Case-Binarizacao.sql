SELECT *
FROM schema2.pacientes;

-- INSTRUÇÃO CASE PARA BINARIZAÇÃO --

-- Verificando classes
SELECT DISTINCT classe
FROM schema2.pacientes;

-- Binarização com CASE

SELECT classe,
	CASE
		WHEN classe = 'sem-recorrencia-eventos' THEN 0
		WHEN classe = 'com-recorrencia-eventos' THEN 1
	END AS classe_transformada
FROM schema2.pacientes;

SELECT irradiando,
	CASE
		WHEN irradiando = 'não' THEN 0
		WHEN irradiando = 'sim' THEN 1
	END AS irradiando_transformada
FROM schema2.pacientes;

SELECT node_caps,
	CASE
		WHEN node_caps = 'não' THEN 0
		WHEN node_caps = 'sim' THEN 1
	END AS node_caps_transformada
FROM schema2.pacientes;

-- Categorização

SELECT seio,
	CASE
		WHEN seio = 'esquerdo' THEN 'E'
		WHEN seio = 'direito' THEN 'D'
	END AS seio_transformada
FROM schema2.pacientes;

SELECT DISTINCT tamanho_tumor
FROM schema2.pacientes
ORDER BY tamanho_tumor;

SELECT tamanho_tumor,
	CASE
		WHEN tamanho_tumor = '0-4' OR tamanho_tumor = '5-9' THEN 'Muito Pequeno'
		WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN 'Pequeno'
		WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN 'Médio'
		WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN 'Grande'
		WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN 'Muito Grande'
		WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN 'Tratamento Urgente'
	END AS tamanho_tumor_transformada
FROM schema2.pacientes;

-- Label Encoding da variável tamanho_tumor (6 categorias)


SELECT tamanho_tumor,
	CASE
		WHEN tamanho_tumor = '0-4' OR tamanho_tumor = '5-9' THEN '1'
		WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN '2'
		WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN '3'
		WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN '4'
		WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN '5'
		WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN '6'
	END AS tamanho_tumor_transformada
FROM schema2.pacientes;

SELECT seio,
	CASE
		WHEN seio = 'esquerdo' THEN '1'
		WHEN seio = 'direito' THEN '2'
	END AS seio_transformada
FROM schema2.pacientes;

SELECT
	CASE
		WHEN quadrante = 'esquerdo-inferior' THEN 1
		WHEN quadrante = 'esquerdo-superior' THEN 2
		WHEN quadrante = 'direito-inferior' THEN 3
		WHEN quadrante = 'direito-superior' THEN 4
		WHEN quadrante = 'central' THEN 5
		ELSE 6
	END AS quadrante_tratada
FROM schema2.pacientes;

-- One-Hot Encoding

SELECT DISTINCT menopausa
FROM schema2.pacientes;

SELECT menopausa,
	CASE
		WHEN menopausa = 'acima_de_40' THEN 1
		ELSE 0
	END AS acima_de_40,
	CASE
		WHEN menopausa = 'pré-menopausa' THEN 1
		ELSE 0
	END AS pre_menopausa,
	CASE
		WHEN menopausa = 'abaixo_de_40' THEN 1
		ELSE 0
	END AS abaixo_de_40
FROM schema2.pacientes;
