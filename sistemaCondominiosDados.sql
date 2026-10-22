
USE sistema_condominio;

-- 1. USUARIOS
INSERT INTO usuarios
(id_usuario, nome, cpf, email, telefone, senha, perfil_acesso, status)
VALUES
(1, 'Ana Oliveira', '111.111.111-11', 'ana@exemplo.com',
 '(61) 99911-1111', 'senha_teste_1', 'administrador', 'ativo'),
(2, 'Carlos Mendes', '222.222.222-22', 'carlos@exemplo.com',
 '(61) 99922-2222', 'senha_teste_2', 'porteiro', 'ativo'),
(3, 'Juliana Costa', '333.333.333-33', 'juliana@exemplo.com',
 '(61) 99933-3333', 'senha_teste_3', 'sindico', 'ativo');

-- 2. CONDOMINIOS
INSERT INTO condominios
(id_condominio, nome, cnpj, endereco, telefone, email, data_cadastro)
VALUES
(1, 'Residencial Jardim das Flores', '12.345.678/0001-90',
 'Rua das Acacias, 100, Brasilia - DF',
 '(61) 3333-1000', 'contato@jardimflores.exemplo', '2026-01-10');

-- 3. AREAS COMUNS
INSERT INTO areas_comuns
(id_area, nome, descricao, capacidade, horario_funcionamento, status)
VALUES
(1, 'Salao de Festas', 'Espaco para eventos e comemoracoes', 80,
 '08:00-23:00', 'ativa'),
(2, 'Churrasqueira', 'Area de lazer com churrasqueira', 25,
 '09:00-22:00', 'ativa'),
(3, 'Academia', 'Espaco para atividades fisicas', 20,
 '05:00-23:00', 'ativa');

-- 4. UNIDADES
INSERT INTO unidades
(id_unidade, numero, bloco, andar, tipo, status, id_condominio)
VALUES
(1, '101', 'A', 1, 'apartamento', 'ocupada', 1),
(2, '102', 'A', 1, 'apartamento', 'ocupada', 1),
(3, '201', 'A', 2, 'apartamento', 'ocupada', 1),
(4, '301', 'B', 3, 'apartamento', 'disponivel', 1);

-- 5. MORADORES
INSERT INTO moradores
(id_morador, nome, cpf, email, telefone, tipo_morador, id_unidade)
VALUES
(1, 'Roberto Almeida', '444.444.444-44',
 'roberto@exemplo.com', '(61) 98811-1111', 'proprietario', 1),
(2, 'Mariana Santos', '555.555.555-55',
 'mariana@exemplo.com', '(61) 98822-2222', 'inquilino', 2),
(3, 'Pedro Henrique', '666.666.666-66',
 'pedro@exemplo.com', '(61) 98833-3333', 'proprietario', 3),
(4, 'Fernanda Lima', '777.777.777-77',
 'fernanda@exemplo.com', '(61) 98844-4444', 'proprietario', 1);

-- 6. VISITANTES
INSERT INTO visitantes
(id_visitante, nome, cpf, telefone, data_visita, horario_previsto,
 id_morador_responsavel, status_autorizacao)
VALUES
(1, 'Lucas Ferreira', '888.888.888-88', '(61) 97711-1111',
 '2026-10-05', '14:30:00', 1, 'autorizado'),
(2, 'Beatriz Rocha', '999.999.999-99', '(61) 97722-2222',
 '2026-10-06', '19:00:00', 2, 'pendente');

-- 7. VEICULOS
INSERT INTO veiculos
(id_veiculo, placa, modelo, marca, cor, tipo, id_morador)
VALUES
(1, 'ABC1D23', 'Onix', 'Chevrolet', 'Prata', 'carro', 1),
(2, 'DEF4G56', 'HB20', 'Hyundai', 'Branco', 'carro', 2),
(3, 'GHI7J89', 'CG 160', 'Honda', 'Preta', 'moto', 3);

-- 8. ACESSOS
INSERT INTO acessos
(id_acesso, tipo_acesso, data_acesso, horario_entrada, horario_saida,
 id_morador, id_visitante, id_veiculo, id_responsavel_registro)
VALUES
(1, 'morador', '2026-10-01', '07:45:00', '18:10:00',
 1, NULL, 1, 2),
(2, 'visitante', '2026-10-01', '14:20:00', '16:00:00',
 NULL, 1, NULL, 2),
(3, 'morador', '2026-10-02', '08:05:00', NULL,
 2, NULL, 2, 2);

-- 9. RESERVAS
INSERT INTO reservas
(id_reserva, data_reserva, horario_inicial, horario_final,
 status, id_area, id_morador)
VALUES
(1, '2026-10-10', '14:00:00', '18:00:00', 'confirmada', 1, 1),
(2, '2026-10-12', '12:00:00', '16:00:00', 'pendente', 2, 2),
(3, '2026-10-15', '18:00:00', '19:00:00', 'confirmada', 3, 3);

-- 10. OCORRENCIAS
INSERT INTO ocorrencias
(id_ocorrencia, titulo, descricao, data_ocorrencia, categoria,
 status, prioridade, id_usuario_responsavel)
VALUES
(1, 'Lampada queimada no corredor',
 'Lampada do segundo andar precisa ser substituida.',
 '2026-10-01 09:30:00', 'manutencao', 'aberta', 'baixa', 3),
(2, 'Barulho fora do horario',
 'Relato de barulho excessivo durante a noite.',
 '2026-10-02 23:15:00', 'convivencia', 'em_analise', 'media', 1);

-- 11. AVISOS
INSERT INTO avisos
(id_aviso, titulo, conteudo, data_publicacao, data_validade,
 id_autor, publico_alvo, status)
VALUES
(1, 'Limpeza da caixa d agua',
 'A limpeza sera realizada no dia 20 de outubro.',
 '2026-10-02 10:00:00', '2026-10-20', 3, 'todos', 'ativo'),
(2, 'Manutencao do portao',
 'O portao de entrada passara por manutencao.',
 '2026-10-03 08:00:00', '2026-10-10', 1, 'moradores', 'ativo');

-- 12. PRESTADORES DE SERVICO
INSERT INTO prestadores_servico
(id_prestador, nome_razao_social, cpf_cnpj, telefone,
 email, tipo_servico, status)
VALUES
(1, 'Eletrica Solucoes Ltda', '23.456.789/0001-01',
 '(61) 3333-2000', 'contato@eletrica.exemplo',
 'eletrica', 'ativo'),
(2, 'Hidraulica Brasil Ltda', '34.567.890/0001-12',
 '(61) 3333-3000', 'contato@hidraulica.exemplo',
 'hidraulica', 'ativo');

-- 13. PAGAMENTOS
INSERT INTO pagamentos
(id_pagamento, descricao, valor, data_vencimento, data_pagamento,
 status, forma_pagamento, id_unidade)
VALUES
(1, 'Condominio outubro - unidade 101', 650.00,
 '2026-10-10', NULL, 'pendente', NULL, 1),
(2, 'Condominio setembro - unidade 102', 650.00,
 '2026-09-10', '2026-09-09', 'pago', 'pix', 2),
(3, 'Taxa de manutencao - unidade 201', 120.00,
 '2026-10-15', NULL, 'pendente', NULL, 3),
(4, 'Condominio outubro - unidade 201', 650.00,
 '2026-10-10', NULL, 'pendente', NULL, 3);