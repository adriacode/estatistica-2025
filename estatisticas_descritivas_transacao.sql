WITH basic_stats AS (

    SELECT
        min(qtdPontos) AS Minimo,
        avg(qtdPontos) AS Media,
        max(qtdPontos) AS Maximo
    FROM points

),

tb_order AS (

    SELECT qtdPontos,
           row_number() OVER (ORDER BY qtdPontos) AS rn
    FROM points
    ORDER BY 1
    LIMIT (SELECT 2 * COUNT(*) / 4 FROM  points) + (SELECT COUNT(*) % 2 == 0 FROM  points)

),

tb_filter AS (

    SELECT *
    FROM tb_ORDER
    ORDER by rn DESC
    LIMIT 1 + (SELECT COUNT(*) % 2 == 0 FROM  points)

)

SELECT avg(qtdPontos) As mediana,
       basic_stats.*
FROM tb_filter, basic_stats