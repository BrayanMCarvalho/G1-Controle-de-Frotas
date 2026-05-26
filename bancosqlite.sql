CREATE TABLE abastecimento (
    id_abastecimento INT PRIMARY KEY,
    quantidade_litro FLOAT,
    valor_litro FLOAT,
    valor_total FLOAT,
    hora TIME,
    data DATE
);

CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY,
    id_modelo INT,
    nome_categoria VARCHAR(100),
    FOREIGN KEY (id_modelo) REFERENCES modelo(id_modelo)
);

CREATE TABLE cnh (
    id_cnh INT PRIMARY KEY,
    orgao_emissor VARCHAR(100),
    data_validade DATE,
    data_emissao DATE,
    categoria CHAR(2),
    numero VARCHAR(20)
);

CREATE TABLE combustivel (
    id_combustivel INT PRIMARY KEY,
    id_abastecimento INT,
    tipo VARCHAR(50),
    FOREIGN KEY (id_abastecimento) REFERENCES abastecimento(id_abastecimento)
);

CREATE TABLE contrato (
    id_contrato INT PRIMARY KEY,
    data_vencimento DATE,
    data_contrato DATE,
    entidade_contratada VARCHAR(255),
    entidade_contratante VARCHAR(255)
);

CREATE TABLE define_rota (
    id_viagem INT,
    id_rota INT,
    PRIMARY KEY (id_viagem, id_rota),
    FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem),
    FOREIGN KEY (id_rota) REFERENCES rota(id_rota)
);

CREATE TABLE endereco (
    id_endereco INT PRIMARY KEY,
    logradouro VARCHAR(255),
    numero INT,
    cep CHAR(8),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf CHAR(2),
    id_motorista INT,
    id_rota INT,
    FOREIGN KEY (id_motorista) REFERENCES motorista(id_motorista),
    FOREIGN KEY (id_rota) REFERENCES rota(id_rota)
);

CREATE TABLE envolve (
    id_motorista INT,
    id_ocorrencia INT,
    PRIMARY KEY (id_motorista, id_ocorrencia),
    FOREIGN KEY (id_motorista) REFERENCES motorista(id_motorista),
    FOREIGN KEY (id_ocorrencia) REFERENCES ocorrencia(id_ocorrencia)
);

CREATE TABLE manutencao (
    id_manutencao INT PRIMARY KEY,
    id_ocorrencia INT,
    id_oficina INT,
    quilometragem_atual FLOAT,
    data_entrada DATE,
    data_saida DATE,
    tipo_manutencao VARCHAR(100),
    custo_total FLOAT,
    observacoes VARCHAR(255),
    FOREIGN KEY (id_ocorrencia) REFERENCES ocorrencia(id_ocorrencia),
    FOREIGN KEY (id_oficina) REFERENCES oficina(id_oficina)
);

CREATE TABLE marca (
    id_marca INT PRIMARY KEY,
    id_modelo INT,
    pais_origem VARCHAR(100),
    nome_marca VARCHAR(100),
    FOREIGN KEY (id_modelo) REFERENCES modelo(id_modelo)
);

CREATE TABLE modelo (
    id_modelo INT PRIMARY KEY,
    nome_modelo VARCHAR(255),
    tipo_combustivel VARCHAR(50)
);

CREATE TABLE motorista (
    id_motorista INT PRIMARY KEY,
    id_endereco INT,
    nome VARCHAR(255),
    cpf CHAR(11),
    data_nascimento DATE,
    telefone VARCHAR(20),
    numero_cnh VARCHAR(20),
    categoria_cnh CHAR(2),
    validade_cnh DATE,
    status VARCHAR(50)
);

CREATE TABLE multa (
    id_multa INT PRIMARY KEY,
    descricao VARCHAR(255),
    data DATE,
    pontos INT,
    valor FLOAT
);

CREATE TABLE ocorrencia (
    id_ocorrencia INT PRIMARY KEY,
    tipo VARCHAR(100),
    descricao VARCHAR(255),
    data DATE,
    gravidade VARCHAR(50)
);

CREATE TABLE oficina (
    id_oficina INT PRIMARY KEY,
    cnpj CHAR(14),
    nome VARCHAR(255),
    telefone VARCHAR(20)
);

CREATE TABLE participa (
    id_treinamento INT,
    id_motorista INT,
    PRIMARY KEY (id_treinamento, id_motorista),
    FOREIGN KEY (id_treinamento) REFERENCES treinamento(id_treinamento),
    FOREIGN KEY (id_motorista) REFERENCES motorista(id_motorista)
);

CREATE TABLE participacao_treinamento (
    id_treinamento INT,
    id_motorista INT,
    resultado VARCHAR(100),
    data_conclusao DATE,
    PRIMARY KEY (id_treinamento, id_motorista)
);

CREATE TABLE possui (
    id_cnh INT,
    id_motorista INT,
    PRIMARY KEY (id_cnh, id_motorista),
    FOREIGN KEY (id_cnh) REFERENCES cnh(id_cnh),
    FOREIGN KEY (id_motorista) REFERENCES motorista(id_motorista)
);

CREATE TABLE quilometragem (
    id_quilometragem INT PRIMARY KEY,
    id_abastecimento INT,
    FOREIGN KEY (id_abastecimento) REFERENCES abastecimento(id_abastecimento)
);

CREATE TABLE realiza (
    id_motorista INT,
    id_viagem INT,
    PRIMARY KEY (id_motorista, id_viagem),
    FOREIGN KEY (id_motorista) REFERENCES motorista(id_motorista),
    FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem)
);

CREATE TABLE recebe (
    id_motorista INT,
    id_multa INT,
    PRIMARY KEY (id_motorista, id_multa),
    FOREIGN KEY (id_motorista) REFERENCES motorista(id_motorista),
    FOREIGN KEY (id_multa) REFERENCES multa(id_multa)
);

CREATE TABLE refere (
    id_treinamento INT,
    id_participacao_treinamento INT,
    PRIMARY KEY (id_treinamento, id_participacao_treinamento)
);

CREATE TABLE rota (
    id_rota INT PRIMARY KEY,
    id_endereco_origem INT,
    id_endereco_destino INT,
    tempo_estimado TIME,
    distancia FLOAT
);

CREATE TABLE treinamento (
    id_treinamento INT PRIMARY KEY,
    carga_horaria INT,
    descricao VARCHAR(255),
    nome VARCHAR(255)
);

CREATE TABLE utiliza (
    id_viagem INT,
    id_veiculo INT,
    PRIMARY KEY (id_viagem, id_veiculo),
    FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem),
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo)
);

CREATE TABLE veiculo (
    id_veiculo INT PRIMARY KEY,
    id_contrato INT,
    id_modelo INT,
    id_quilometragem INT,
    placa VARCHAR(10),
    ano INT,
    status VARCHAR(50),
    ano_fabricacao INT,
    FOREIGN KEY (id_contrato) REFERENCES contrato(id_contrato),
    FOREIGN KEY (id_modelo) REFERENCES modelo(id_modelo),
    FOREIGN KEY (id_quilometragem) REFERENCES quilometragem(id_quilometragem)
);

CREATE TABLE viagem (
    id_viagem INT PRIMARY KEY,
    data_saida DATETIME,
    data_retorno DATETIME,
    km_inicial FLOAT,
    km_final FLOAT,
    status VARCHAR(50)
);
