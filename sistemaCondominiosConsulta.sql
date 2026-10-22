
USE sistema_condominio;

SELECT 'usuarios' AS tabela, COUNT(*) AS registros FROM usuarios
UNION ALL
SELECT 'condominios', COUNT(*) FROM condominios
UNION ALL
SELECT 'unidades', COUNT(*) FROM unidades
UNION ALL
SELECT 'moradores', COUNT(*) FROM moradores
UNION ALL
SELECT 'visitantes', COUNT(*) FROM visitantes
UNION ALL
SELECT 'veiculos', COUNT(*) FROM veiculos
UNION ALL
SELECT 'acessos', COUNT(*) FROM acessos
UNION ALL
SELECT 'reservas', COUNT(*) FROM reservas
UNION ALL
SELECT 'areas_comuns', COUNT(*) FROM areas_comuns
UNION ALL
SELECT 'ocorrencias', COUNT(*) FROM ocorrencias
UNION ALL
SELECT 'avisos', COUNT(*) FROM avisos
UNION ALL
SELECT 'prestadores_servico', COUNT(*) FROM prestadores_servico
UNION ALL
SELECT 'pagamentos', COUNT(*) FROM pagamentos;

SELECT
    m.nome AS morador,
    u.numero AS unidade,
    c.nome AS condominio
FROM moradores m
INNER JOIN unidades u
    ON m.id_unidade = u.id_unidade
INNER JOIN condominios c
    ON u.id_condominio = c.id_condominio;