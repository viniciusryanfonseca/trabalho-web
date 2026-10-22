
CREATE DATABASE IF NOT EXISTS sistema_condominio
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE sistema_condominio;

-- 1. USUARIO
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    senha VARCHAR(255) NOT NULL,
    perfil_acesso VARCHAR(30) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ativo'
);

-- 2. CONDOMINIO
CREATE TABLE condominios (
    id_condominio INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    cnpj VARCHAR(18) UNIQUE,
    endereco VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(150),
    data_cadastro DATE NOT NULL
);

-- 3. AREA COMUM
CREATE TABLE areas_comuns (
    id_area INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    capacidade INT,
    horario_funcionamento VARCHAR(100),
    status VARCHAR(20) NOT NULL DEFAULT 'ativa'
);

-- 4. UNIDADE
CREATE TABLE unidades (
    id_unidade INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(20) NOT NULL,
    bloco VARCHAR(20),
    andar INT,
    tipo VARCHAR(30) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ativa',
    id_condominio INT NOT NULL,

    CONSTRAINT fk_unidade_condominio
        FOREIGN KEY (id_condominio)
        REFERENCES condominios(id_condominio)
);

-- 5. MORADOR
CREATE TABLE moradores (
    id_morador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(150),
    telefone VARCHAR(20),
    tipo_morador VARCHAR(30) NOT NULL,
    id_unidade INT NOT NULL,

    CONSTRAINT fk_morador_unidade
        FOREIGN KEY (id_unidade)
        REFERENCES unidades(id_unidade)
);

-- 6. VISITANTE
CREATE TABLE visitantes (
    id_visitante INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14),
    telefone VARCHAR(20),
    data_visita DATE NOT NULL,
    horario_previsto TIME,
    id_morador_responsavel INT NOT NULL,
    status_autorizacao VARCHAR(30) NOT NULL DEFAULT 'pendente',

    CONSTRAINT fk_visitante_morador
        FOREIGN KEY (id_morador_responsavel)
        REFERENCES moradores(id_morador)
);

-- 7. VEICULO
CREATE TABLE veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(60) NOT NULL,
    marca VARCHAR(60),
    cor VARCHAR(30),
    tipo VARCHAR(30),
    id_morador INT NOT NULL,

    CONSTRAINT fk_veiculo_morador
        FOREIGN KEY (id_morador)
        REFERENCES moradores(id_morador)
);

-- 8. ACESSO
CREATE TABLE acessos (
    id_acesso INT AUTO_INCREMENT PRIMARY KEY,
    tipo_acesso VARCHAR(30) NOT NULL,
    data_acesso DATE NOT NULL,
    horario_entrada TIME NOT NULL,
    horario_saida TIME,
    id_morador INT,
    id_visitante INT,
    id_veiculo INT,
    id_responsavel_registro INT NOT NULL,

    CONSTRAINT fk_acesso_morador
        FOREIGN KEY (id_morador)
        REFERENCES moradores(id_morador),

    CONSTRAINT fk_acesso_visitante
        FOREIGN KEY (id_visitante)
        REFERENCES visitantes(id_visitante),

    CONSTRAINT fk_acesso_veiculo
        FOREIGN KEY (id_veiculo)
        REFERENCES veiculos(id_veiculo),

    CONSTRAINT fk_acesso_usuario
        FOREIGN KEY (id_responsavel_registro)
        REFERENCES usuarios(id_usuario)
);

-- 9. RESERVA
CREATE TABLE reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    data_reserva DATE NOT NULL,
    horario_inicial TIME NOT NULL,
    horario_final TIME NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pendente',
    id_area INT NOT NULL,
    id_morador INT NOT NULL,

    CONSTRAINT fk_reserva_area
        FOREIGN KEY (id_area)
        REFERENCES areas_comuns(id_area),

    CONSTRAINT fk_reserva_morador
        FOREIGN KEY (id_morador)
        REFERENCES moradores(id_morador)
);

-- 10. OCORRENCIA
CREATE TABLE ocorrencias (
    id_ocorrencia INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT NOT NULL,
    data_ocorrencia DATETIME NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'aberta',
    prioridade VARCHAR(20) NOT NULL DEFAULT 'media',
    id_usuario_responsavel INT NOT NULL,

    CONSTRAINT fk_ocorrencia_usuario
        FOREIGN KEY (id_usuario_responsavel)
        REFERENCES usuarios(id_usuario)
);

-- 11. AVISO
CREATE TABLE avisos (
    id_aviso INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    conteudo TEXT NOT NULL,
    data_publicacao DATETIME NOT NULL,
    data_validade DATE,
    id_autor INT NOT NULL,
    publico_alvo VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ativo',

    CONSTRAINT fk_aviso_usuario
        FOREIGN KEY (id_autor)
        REFERENCES usuarios(id_usuario)
);

-- 12. PRESTADOR DE SERVICO
CREATE TABLE prestadores_servico (
    id_prestador INT AUTO_INCREMENT PRIMARY KEY,
    nome_razao_social VARCHAR(150) NOT NULL,
    cpf_cnpj VARCHAR(18) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(150),
    tipo_servico VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ativo'
);

-- 13. PAGAMENTO
CREATE TABLE pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(200) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_vencimento DATE NOT NULL,
    data_pagamento DATE,
    status VARCHAR(30) NOT NULL DEFAULT 'pendente',
    forma_pagamento VARCHAR(30),
    id_unidade INT NOT NULL,

    CONSTRAINT fk_pagamento_unidade
        FOREIGN KEY (id_unidade)
        REFERENCES unidades(id_unidade)
);