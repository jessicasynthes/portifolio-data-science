CREATE TABLE schema2.pacientes_resultado
AS
SELECT 
  CASE 
    WHEN classe = 'sem-recorrencia-eventos' THEN 0 
    WHEN classe = 'com-recorrencia-eventos' THEN 1
  END as classe,
  CASE 
    WHEN tamanho_tumor = '0-4'   OR tamanho_tumor = '5-9'   THEN '1'
    WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN '2'
    WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN '3'
    WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN '4'
    WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN '5'
    WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN '6'
  END AS tamanho_tumor,
  CASE 
    WHEN node_caps = 'não' THEN 0 
    WHEN node_caps = 'sim' THEN 1
    ELSE 2
  END AS node_caps,
  deg_malig,
  CASE 
    WHEN seio = 'esquerdo' THEN '1' 
    WHEN seio = 'direito' THEN '2'
  END AS seio,
  CASE 
    WHEN quadrante = 'esquerdo_inferior' THEN 1 
    WHEN quadrante = 'direito_superior' THEN 2 
    WHEN quadrante = 'esquerdo_superior' THEN 3
    WHEN quadrante = 'direito_inferior' THEN 4
    WHEN quadrante = 'central' THEN 5
    ELSE 6
  END AS quadrante,
  CASE 
    WHEN irradiando = 'não' THEN 0 
    WHEN irradiando = 'sim' THEN 1
  END AS irradiando,
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


SELECT *
FROM schema2.pacientes_resultado
