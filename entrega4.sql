---------------
-- DDL
---------------
CREATE TABLE marca (
    id_marca SERIAL PRIMARY KEY,
    pais_origem VARCHAR(100),
    nome_marca VARCHAR(100)
);

CREATE TABLE modelo (
    id_modelo SERIAL PRIMARY KEY,
  	id_marca INT,
    nome_modelo VARCHAR(255),
    tipo_combustivel VARCHAR(50),
  	FOREIGN KEY (id_marca) REFERENCES marca(id_marca)
);

CREATE TABLE categoria (
    id_categoria SERIAL PRIMARY KEY,
    id_modelo INT,
    nome_categoria VARCHAR(100),
    FOREIGN KEY (id_modelo) REFERENCES modelo(id_modelo)
);

CREATE TABLE contrato (
    id_contrato SERIAL PRIMARY KEY,
    data_vencimento DATE,
    data_contrato DATE,
    entidade_contratada VARCHAR(255),
    entidade_contratante VARCHAR(255)
);

CREATE TABLE abastecimento (
    id_abastecimento SERIAL PRIMARY KEY,
    quantidade_litro FLOAT,
    valor_litro FLOAT,
    valor_total FLOAT,
    hora TIME,
    data DATE
);

CREATE TABLE quilometragem (
    id_quilometragem SERIAL PRIMARY KEY,
    id_abastecimento INT,
    FOREIGN KEY (id_abastecimento) REFERENCES abastecimento(id_abastecimento)
);

CREATE TABLE combustivel (
    id_combustivel SERIAL PRIMARY KEY,
    id_abastecimento INT,
    tipo VARCHAR(50),
    FOREIGN KEY (id_abastecimento) REFERENCES abastecimento(id_abastecimento)
);

CREATE TABLE veiculo (
    id_veiculo SERIAL PRIMARY KEY,
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

CREATE TABLE ocorrencia (
    id_ocorrencia SERIAL PRIMARY KEY,
    tipo VARCHAR(100),
    descricao VARCHAR(255),
    data DATE,
    gravidade VARCHAR(50)
);

CREATE TABLE oficina (
    id_oficina SERIAL PRIMARY KEY,
    cnpj CHAR(14),
    nome VARCHAR(255),
    telefone VARCHAR(20)
);

CREATE TABLE cnh (
    id_cnh SERIAL PRIMARY KEY,
    orgao_emissor VARCHAR(100),
    data_validade DATE,
    data_emissao DATE,
    categoria CHAR(2),
    numero VARCHAR(20)
);

CREATE TABLE multa (
    id_multa SERIAL PRIMARY KEY,
    descricao VARCHAR(255),
    data DATE,
    pontos INT,
    valor FLOAT
);

CREATE TABLE treinamento (
    id_treinamento SERIAL PRIMARY KEY,
    carga_horaria INT,
    descricao VARCHAR(255),
    nome VARCHAR(255)
);

CREATE TABLE motorista (
    id_motorista SERIAL PRIMARY KEY,
    id_endereco INT,
    nome VARCHAR(255),
    cpf CHAR(11),
    data_nascimento DATE,
    telefone VARCHAR(20),
    status VARCHAR(50)
);

CREATE TABLE rota (
    id_rota SERIAL PRIMARY KEY,
    id_endereco_origem INT,
    id_endereco_destino INT,
    tempo_estimado TIME,
    distancia FLOAT
);

CREATE TABLE endereco (
    id_endereco SERIAL PRIMARY KEY,
    logradouro VARCHAR(255),
    numero INT,
    cep CHAR(8),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf CHAR(2)
);

ALTER TABLE motorista
    ADD CONSTRAINT fk_motorista_endereco
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco);

ALTER TABLE rota
    ADD CONSTRAINT fk_rota_origem
    FOREIGN KEY (id_endereco_origem) REFERENCES endereco(id_endereco);

ALTER TABLE rota
    ADD CONSTRAINT fk_rota_destino
    FOREIGN KEY (id_endereco_destino) REFERENCES endereco(id_endereco);

CREATE TABLE viagem (
    id_viagem SERIAL PRIMARY KEY,
    data_saida TIMESTAMP,
    data_retorno TIMESTAMP,
    km_inicial FLOAT,
    km_final FLOAT,
    status VARCHAR(50)
);

CREATE TABLE manutencao (
    id_manutencao SERIAL PRIMARY KEY,
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

CREATE TABLE define_rota (
    id_viagem INT,
    id_rota INT,
    PRIMARY KEY (id_viagem, id_rota),
    FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem),
    FOREIGN KEY (id_rota) REFERENCES rota(id_rota)
);

CREATE TABLE envolve (
    id_motorista INT,
    id_ocorrencia INT,
    PRIMARY KEY (id_motorista, id_ocorrencia),
    FOREIGN KEY (id_motorista) REFERENCES motorista(id_motorista),
    FOREIGN KEY (id_ocorrencia) REFERENCES ocorrencia(id_ocorrencia)
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

CREATE TABLE utiliza (
    id_viagem INT,
    id_veiculo INT,
    PRIMARY KEY (id_viagem, id_veiculo),
    FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem),
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo)
);

---------------
-- DML
---------------

INSERT INTO marca (pais_origem, nome_marca) VALUES
('Alemanha', 'Mercedes-Benz'),
('Itália',   'Iveco'),
('França',   'Renault'),
('Alemanha', 'Ford'),
('França',   'Peugeot'),
('Itália',   'Fiat'),
('Alemanha', 'Mercedes-Benz'),
('Alemanha', 'Volkswagen'),
('França',   'Renault'),
('França',   'Citroën');

INSERT INTO modelo (nome_modelo, tipo_combustivel, id_marca) VALUES
('Sprinter 415', 'Diesel',1),
('Daily 35S14', 'Diesel',2),
('Master L2H2', 'Diesel',3),
('Transit Custom', 'Diesel',4),
('Boxer 2.0', 'Diesel',5),
('Ducato Cargo', 'Diesel',6),
('Vito 116 CDI', 'Diesel',7),
('Crafter 35', 'Diesel',8),
('Trafic L1H1', 'Diesel',9),
('Jumper Furgão', 'Diesel',10);

INSERT INTO categoria (id_modelo, nome_categoria) VALUES
(1,  'Furgão de Carga'),
(2,  'Van de Passageiros'),
(3,  'Furgão Refrigerado'),
(4,  'Utilitário Leve'),
(5,  'Furgão de Carga'),
(6,  'Van de Passageiros'),
(7,  'Utilitário Leve'),
(8,  'Furgão de Carga'),
(9,  'Furgão Refrigerado'),
(10, 'Van de Passageiros');

INSERT INTO contrato (data_vencimento, data_contrato, entidade_contratada, entidade_contratante) VALUES
('2026-01-15', '2024-01-15', 'Locadora Rápido Sul Ltda.',         'Transportes Horizonte S.A.'),
('2026-03-20', '2024-03-20', 'Frotalink Gestão de Frotas Ltda.',  'Transportes Horizonte S.A.'),
('2025-07-10', '2023-07-10', 'AutoFlex Veículos Ltda.',           'Transportes Horizonte S.A.'),
('2027-02-28', '2025-02-28', 'Locadora Rápido Sul Ltda.',         'Transportes Horizonte S.A.'),
('2026-09-05', '2024-09-05', 'BrasFlota Soluções Ltda.',          'Transportes Horizonte S.A.'),
('2026-06-30', '2024-06-30', 'Frotalink Gestão de Frotas Ltda.',  'Transportes Horizonte S.A.'),
('2027-11-12', '2025-11-12', 'AutoFlex Veículos Ltda.',           'Transportes Horizonte S.A.'),
('2025-12-01', '2023-12-01', 'BrasFlota Soluções Ltda.',          'Transportes Horizonte S.A.'),
('2026-08-22', '2024-08-22', 'Locadora Rápido Sul Ltda.',         'Transportes Horizonte S.A.'),
('2027-04-18', '2025-04-18', 'Frotalink Gestão de Frotas Ltda.',  'Transportes Horizonte S.A.');

INSERT INTO abastecimento (quantidade_litro, valor_litro, valor_total, hora, data) VALUES
(60.00,  6.29, 377.40, '07:15:00', '2025-01-10'),
(45.50,  6.35, 288.93, '11:30:00', '2025-01-18'),
(70.00,  6.20, 434.00, '08:00:00', '2025-02-03'),
(55.00,  6.45, 354.75, '14:20:00', '2025-02-17'),
(80.00,  6.18, 494.40, '09:45:00', '2025-03-05'),
(50.00,  6.50, 325.00, '16:10:00', '2025-03-22'),
(65.00,  6.30, 409.50, '07:55:00', '2025-04-08'),
(40.00,  6.55, 262.00, '12:00:00', '2025-04-25'),
(75.00,  6.25, 468.75, '10:30:00', '2025-05-14'),
(58.00,  6.40, 371.20, '15:45:00', '2025-05-30');

INSERT INTO quilometragem (id_abastecimento) VALUES
(1), (2), (3), (4), (5),
(6), (7), (8), (9), (10);

INSERT INTO combustivel (id_abastecimento, tipo) VALUES
(1,  'Diesel S10'),
(2,  'Diesel S500'),
(3,  'Diesel S10'),
(4,  'Diesel S10'),
(5,  'Diesel S500'),
(6,  'Diesel S10'),
(7,  'Diesel S10'),
(8,  'Diesel S500'),
(9,  'Diesel S10'),
(10, 'Diesel S10');

INSERT INTO veiculo (id_contrato, id_modelo, id_quilometragem, placa, ano, status, ano_fabricacao) VALUES
(1,  1,  1,  'BRA2E19', 2022, 'Ativo',         2022),
(2,  2,  2,  'MNO3F28', 2021, 'Ativo',         2021),
(3,  3,  3,  'PQR4G37', 2023, 'Ativo',         2023),
(4,  4,  4,  'STU5H46', 2020, 'Em manutenção', 2020),
(5,  5,  5,  'VWX6I55', 2022, 'Ativo',         2022),
(6,  6,  6,  'YZA7J64', 2021, 'Ativo',         2021),
(7,  7,  7,  'BCD8K73', 2023, 'Ativo',         2023),
(8,  8,  8,  'EFG9L82', 2019, 'Inativo',       2019),
(9,  9,  9,  'HIJ0M91', 2022, 'Ativo',         2022),
(10, 10, 10, 'KLM1N00', 2024, 'Ativo',         2024);

INSERT INTO ocorrencia (tipo, descricao, data, gravidade) VALUES
('Acidente',    'Colisão traseira em via urbana',              '2025-01-12', 'Alta'),
('Pane',        'Pane elétrica no painel do veículo',          '2025-01-25', 'Média'),
('Acidente',    'Capotamento em rodovia estadual',             '2025-02-08', 'Alta'),
('Infração',    'Excesso de velocidade em zona escolar',       '2025-02-20', 'Baixa'),
('Pane',        'Superaquecimento do motor',                   '2025-03-10', 'Alta'),
('Avaria',      'Porta lateral com fechamento defeituoso',     '2025-03-28', 'Baixa'),
('Acidente',    'Abalroamento lateral em estacionamento',      '2025-04-05', 'Média'),
('Infração',    'Avanço de sinal vermelho',                    '2025-04-19', 'Média'),
('Pane',        'Falha no sistema de freios ABS',              '2025-05-02', 'Alta'),
('Avaria',      'Pneu furado em rodovia federal',              '2025-05-20', 'Baixa');

INSERT INTO oficina (cnpj, nome, telefone) VALUES
('12345678000101', 'Oficina Central do Sul',     '(35) 3221-4455'),
('23456789000102', 'Auto Mecânica Mineira Ltda.','(31) 3344-5566'),
('34567890000103', 'Mecânica Rodoviária Express','(11) 2233-4477'),
('45678901000104', 'Borracharia e Mecânica Belo','(35) 3456-7788'),
('56789012000105', 'Centro Diesel Especializado','(31) 4455-6699'),
('67890123000106', 'Oficina Horizonte Motors',   '(35) 3567-8800'),
('78901234000107', 'MultiServiços Automotivos',  '(11) 3678-9911'),
('89012345000108', 'Elétrica e Mecânica Geral',  '(35) 3789-0022'),
('90123456000109', 'Freios & Suspensão Pro',     '(31) 4890-1133'),
('01234567000110', 'Truck Center Minas',         '(35) 3901-2244');

INSERT INTO cnh (orgao_emissor, data_validade, data_emissao, categoria, numero) VALUES
('DETRAN-MG', '2028-03-15', '2018-03-15', 'D', '01234567890'),
('DETRAN-SP', '2027-07-20', '2017-07-20', 'E', '12345678901'),
('DETRAN-MG', '2029-11-05', '2019-11-05', 'D', '23456789012'),
('DETRAN-RJ', '2026-09-30', '2021-09-30', 'C', '34567890123'),
('DETRAN-MG', '2028-01-18', '2018-01-18', 'D', '45678901234'),
('DETRAN-MG', '2030-06-22', '2020-06-22', 'E', '56789012345'),
('DETRAN-PR', '2027-04-10', '2017-04-10', 'D', '67890123456'),
('DETRAN-MG', '2029-08-14', '2019-08-14', 'D', '78901234567'),
('DETRAN-GO', '2026-12-01', '2021-12-01', 'C', '89012345678'),
('DETRAN-MG', '2031-02-27', '2021-02-27', 'E', '90123456789');

INSERT INTO multa (descricao, data, pontos, valor) VALUES
('Excesso de velocidade acima de 50% do limite',    '2025-01-14', 7,  880.41),
('Avanço de sinal vermelho',                        '2025-01-28', 7,  293.47),
('Uso de celular ao volante',                       '2025-02-10', 5,  293.47),
('Não uso do cinto de segurança',                   '2025-02-22', 3,  195.23),
('Estacionamento em local proibido',                '2025-03-08', 3,  195.23),
('Ultrapassagem proibida em faixa dupla',           '2025-03-25', 5,  293.47),
('Excesso de velocidade até 20% do limite',         '2025-04-07', 3,  130.16),
('Conduzir veículo com CNH vencida',                '2025-04-21', 7,  293.47),
('Transitar em calçada ou passeio',                 '2025-05-05', 5,  293.47),
('Avançar preferencial em cruzamento',              '2025-05-23', 4,  195.23);

INSERT INTO treinamento (carga_horaria, descricao, nome) VALUES
(8,  'Técnicas seguras de condução em rodovias federais e estaduais', 'Direção Defensiva Avançada'),
(4,  'Procedimentos em caso de acidente ou pane na via',              'Primeiros Socorros no Trânsito'),
(6,  'Uso correto de EPI e normas de segurança operacional',          'Segurança do Trabalho para Motoristas'),
(8,  'Redução de consumo de combustível por técnica de condução',     'Condução Econômica'),
(4,  'Normas para transporte seguro de cargas fracionadas',           'Transporte de Cargas Especiais'),
(6,  'Leitura de rotas, GPS e planejamento de viagens longas',        'Roteirização e Logística'),
(4,  'Cuidados básicos com o veículo e identificação de falhas',      'Manutenção Preventiva Básica'),
(8,  'Atualização sobre legislação de trânsito vigente',              'Legislação de Trânsito'),
(4,  'Técnicas de comunicação e atendimento ao cliente',              'Relacionamento com o Cliente'),
(6,  'Gestão do tempo e planejamento de jornada do motorista',        'Gestão de Jornada');

INSERT INTO motorista (id_endereco, nome, cpf, data_nascimento, telefone, status) VALUES
(NULL, 'Carlos Eduardo Souza',    '12345678901', '1985-06-15', '(35) 99801-2345', 'Ativo'),
(NULL, 'Marcos Antônio Pereira',  '23456789012', '1979-11-22', '(35) 99802-3456', 'Ativo'),
(NULL, 'José Roberto Lima',       '34567890123', '1990-03-08', '(35) 99803-4567', 'Ativo'),
(NULL, 'Anderson Luís Ferreira',  '45678901234', '1983-09-17', '(35) 99804-5678', 'Afastado'),
(NULL, 'Ricardo Gomes da Silva',  '56789012345', '1975-01-30', '(35) 99805-6789', 'Ativo'),
(NULL, 'Fábio Henrique Rocha',    '67890123456', '1988-07-04', '(35) 99806-7890', 'Ativo'),
(NULL, 'Leandro Aparecido Costa', '78901234567', '1992-12-19', '(35) 99807-8901', 'Ativo'),
(NULL, 'Paulo César Martins',     '89012345678', '1980-04-25', '(35) 99808-9012', 'Ativo'),
(NULL, 'Rogério de Oliveira',     '90123456789', '1977-08-11', '(35) 99809-0123', 'Inativo'),
(NULL, 'Bruno Henrique Alves',    '01234567890', '1995-02-28', '(35) 99810-1234', 'Ativo');

INSERT INTO rota (id_endereco_origem, id_endereco_destino, tempo_estimado, distancia) VALUES
(NULL, NULL, '02:30:00', 180.5),
(NULL, NULL, '01:45:00', 120.0),
(NULL, NULL, '03:00:00', 240.0),
(NULL, NULL, '00:50:00',  55.0),
(NULL, NULL, '04:15:00', 350.0),
(NULL, NULL, '01:20:00',  90.0),
(NULL, NULL, '02:00:00', 160.0),
(NULL, NULL, '03:30:00', 280.0),
(NULL, NULL, '00:40:00',  42.0),
(NULL, NULL, '05:00:00', 420.0);
	
INSERT INTO endereco (logradouro, numero, cep, bairro, cidade, uf) VALUES
('Rua das Acácias',           123, '37700000', 'Centro',           'Poços de Caldas',  'MG'),
('Avenida Brasil',            456, '37701000', 'Jardim das Rosas', 'Poços de Caldas',  'MG'),
('Rua Minas Gerais',          789, '37702000', 'Vila Nova',        'Poços de Caldas',  'MG'),
('Rua São Paulo',             321, '37703000', 'Novo Horizonte',   'Poços de Caldas',  'MG'),
('Avenida Prefeito Tuany',    654, '37704000', 'Jardim Centenário','Poços de Caldas',  'MG'),
('Rua Pinheiro Chagas',       987, '37705000', 'São João',         'Andradas',         'MG'),
('Avenida Dona Alexandrina',  147, '37801000', 'Centro',           'Varginha',         'MG'),
('Rua Sete de Setembro',      258, '37902000', 'Centro',           'Alfenas',          'MG'),
('Rua Major Pinheiro Fróis',  369, '37470000', 'Centro',           'Itajubá',          'MG'),
('Avenida Wenceslau Braz',    741, '37500000', 'Centro',           'Itajubá',          'MG');

UPDATE motorista SET id_endereco = 1  WHERE id_motorista = 1;
UPDATE motorista SET id_endereco = 2  WHERE id_motorista = 2;
UPDATE motorista SET id_endereco = 3  WHERE id_motorista = 3;
UPDATE motorista SET id_endereco = 4  WHERE id_motorista = 4;
UPDATE motorista SET id_endereco = 5  WHERE id_motorista = 5;
UPDATE motorista SET id_endereco = 6  WHERE id_motorista = 6;
UPDATE motorista SET id_endereco = 7  WHERE id_motorista = 7;
UPDATE motorista SET id_endereco = 8  WHERE id_motorista = 8;
UPDATE motorista SET id_endereco = 9  WHERE id_motorista = 9;
UPDATE motorista SET id_endereco = 10 WHERE id_motorista = 10;
 
UPDATE rota SET id_endereco_origem = 1,  id_endereco_destino = 3  WHERE id_rota = 1;
UPDATE rota SET id_endereco_origem = 2,  id_endereco_destino = 7  WHERE id_rota = 2;
UPDATE rota SET id_endereco_origem = 3,  id_endereco_destino = 8  WHERE id_rota = 3;
UPDATE rota SET id_endereco_origem = 4,  id_endereco_destino = 9  WHERE id_rota = 4;
UPDATE rota SET id_endereco_origem = 5,  id_endereco_destino = 10 WHERE id_rota = 5;
UPDATE rota SET id_endereco_origem = 6,  id_endereco_destino = 1  WHERE id_rota = 6;
UPDATE rota SET id_endereco_origem = 7,  id_endereco_destino = 2  WHERE id_rota = 7;
UPDATE rota SET id_endereco_origem = 8,  id_endereco_destino = 4  WHERE id_rota = 8;
UPDATE rota SET id_endereco_origem = 9,  id_endereco_destino = 5  WHERE id_rota = 9;
UPDATE rota SET id_endereco_origem = 10, id_endereco_destino = 6  WHERE id_rota = 10;

INSERT INTO viagem (data_saida, data_retorno, km_inicial, km_final, status) VALUES
('2025-01-10 06:00:00', '2025-01-10 09:00:00',  12000.0,  12180.5, 'Concluída'),
('2025-01-18 07:30:00', '2025-01-18 09:15:00',  45000.0,  45120.0, 'Concluída'),
('2025-02-03 05:45:00', '2025-02-03 09:00:00',  78000.0,  78240.0, 'Concluída'),
('2025-02-17 08:00:00', '2025-02-17 08:55:00',  23000.0,  23055.0, 'Concluída'),
('2025-03-05 06:30:00', '2025-03-05 11:00:00',  56000.0,  56350.0, 'Concluída'),
('2025-03-22 07:00:00', '2025-03-22 08:30:00',  34000.0,  34090.0, 'Concluída'),
('2025-04-08 06:15:00', '2025-04-08 08:45:00',  67000.0,  67160.0, 'Concluída'),
('2025-04-25 05:30:00', '2025-04-25 09:30:00',  90000.0,  90280.0, 'Concluída'),
('2025-05-14 07:45:00', '2025-05-14 08:32:00', 102000.0, 102042.0, 'Concluída'),
('2025-05-30 06:00:00', '2025-05-30 12:00:00', 115000.0, 115420.0, 'Concluída');

INSERT INTO manutencao (id_ocorrencia, id_oficina, quilometragem_atual, data_entrada, data_saida, tipo_manutencao, custo_total, observacoes) VALUES
(1,  1,  12200.0, '2025-01-13', '2025-01-17', 'Corretiva', 3200.00, 'Reparo de para-choque e lataria traseira'),
(2,  2,  45010.0, '2025-01-26', '2025-01-28', 'Corretiva', 1800.00, 'Substituição do módulo de controle elétrico'),
(3,  3,  78250.0, '2025-02-09', '2025-02-20', 'Corretiva', 8500.00, 'Recuperação de estrutura após capotamento'),
(5,  4,  56360.0, '2025-03-11', '2025-03-15', 'Corretiva', 4200.00, 'Troca de bomba d''água e correia do motor'),
(6,  5,  34095.0, '2025-03-29', '2025-03-30', 'Preventiva',  350.00, 'Ajuste e lubrificação da porta lateral'),
(7,  6,  67165.0, '2025-04-06', '2025-04-09', 'Corretiva', 2100.00, 'Funilaria e pintura do painel lateral'),
(9,  7,  90290.0, '2025-05-03', '2025-05-08', 'Corretiva', 5600.00, 'Substituição do conjunto ABS e sensores'),
(10, 8, 102045.0, '2025-05-21', '2025-05-21', 'Preventiva',  280.00, 'Troca de pneu e alinhamento'),
(2,  9,  45100.0, '2025-06-01', '2025-06-03', 'Preventiva',  620.00, 'Revisão do sistema elétrico preventiva'),
(5,  10, 56500.0, '2025-06-10', NULL,          'Corretiva', 3900.00, 'Aguardando peça para reparo do motor');

INSERT INTO define_rota (id_viagem, id_rota) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

INSERT INTO envolve (id_motorista, id_ocorrencia) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

INSERT INTO participa (id_treinamento, id_motorista) VALUES
(1, 1), (1, 2), (2, 3), (2, 4), (3, 5),
(3, 6), (4, 7), (4, 8), (5, 9), (5, 10);

INSERT INTO participacao_treinamento (id_treinamento, id_motorista, resultado, data_conclusao) VALUES
(1, 1, 'Aprovado',   '2025-01-20'),
(1, 2, 'Aprovado',   '2025-01-20'),
(2, 3, 'Aprovado',   '2025-02-05'),
(2, 4, 'Reprovado',  '2025-02-05'),
(3, 5, 'Aprovado',   '2025-02-25'),
(3, 6, 'Aprovado',   '2025-02-25'),
(4, 7, 'Aprovado',   '2025-03-15'),
(4, 8, 'Aprovado',   '2025-03-15'),
(5, 9, 'Reprovado',  '2025-04-10'),
(5, 10,'Aprovado',   '2025-04-10');

INSERT INTO possui (id_cnh, id_motorista) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

INSERT INTO realiza (id_motorista, id_viagem) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

INSERT INTO recebe (id_motorista, id_multa) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

INSERT INTO refere (id_treinamento, id_participacao_treinamento) VALUES
(1, 1), (1, 2), (2, 3), (2, 4), (3, 5),
(3, 6), (4, 7), (4, 8), (5, 9), (5, 10);

INSERT INTO utiliza (id_viagem, id_veiculo) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

---------------
--  Consultas Q1 a Q10
---------------

-- Q1 - Motoristas Ativos
SELECT 	nome, 
		cpf
FROM 	motorista
WHERE 	status ILIKE 'Ativo';

-- Q2 - Manutenções corretivas ainda abertas (sem data de saída)
SELECT 	id_manutencao,
		tipo_manutencao,
		data_entrada,
		custo_total,
		observacoes
FROM 	manutencao
WHERE 	tipo_manutencao ILIKE 'Corretiva'
  AND 	data_saida IS NULL;
  
-- Q3 - Motoristas com as viagens que realizaram, incluindo datas e status
SELECT 	A.nome,
		C.data_saida,
		C.data_retorno,
		C.status
FROM 	motorista A
JOIN 	realiza B ON B.id_motorista = A.id_motorista
JOIN 	viagem C ON C.id_viagem = B.id_viagem;

-- Q4 - Motoristas e seu endereço onde moram
SELECT 	A.nome,
		B.logradouro,
		B.numero,
		B.bairro,
		B.cidade,
		B.uf
FROM 	motorista A
JOIN 	endereco B ON A.id_endereco = B.id_endereco;

-- Q5 - Veículos com dados de viagem, incluindo os que não realizaram viagem
SELECT 	A.placa, 
		A.ano, 
		A.status,
		C.data_saida, 
		C.km_inicial, 
		C.km_final
FROM 	veiculo A
LEFT JOIN utiliza B ON B.id_veiculo = A.id_veiculo
LEFT JOIN viagem C ON C.id_viagem = B.id_viagem;

-- Q6 - Motoristas com mais de uma multa, somando pontos e valor total
SELECT 	A.nome,
		COUNT(C.id_multa) AS total_multas,
		SUM(C.pontos) AS total_pontos,
		SUM(C.valor) AS valor_total
FROM 	motorista A
JOIN 	recebe B ON B.id_motorista = A.id_motorista
JOIN 	multa C ON C.id_multa = B.id_multa
GROUP BY A.nome
HAVING COUNT(C.id_multa) > 1;

-- Q7 - Motoristas com distância acima da Média
SELECT DISTINCT 
		A.nome, 
		A.status
FROM 	motorista A
JOIN 	realiza B ON B.id_motorista = A.id_motorista
JOIN 	viagem  C ON C.id_viagem = B.id_viagem
WHERE (C.km_final - C.km_inicial) > (
    SELECT AVG(D.km_final - D.km_inicial) FROM viagem D
);

-- Q8 - Motoristas que tiveram algum treinamento
SELECT 	A.nome,
		A.status
FROM 	motorista A
WHERE EXISTS (
    SELECT 1
	FROM participa B
    WHERE B.id_motorista = A.id_motorista
);

-- Q9 - Mostra os dados completos do veículo
CREATE VIEW vw_veiculo_completo AS
SELECT 	A.id_veiculo,
		A.placa,
		A.ano,
		A.status,
		A.ano_fabricacao,
		B.nome_modelo,
		B.tipo_combustivel,
		C.nome_marca,
		C.pais_origem
FROM	veiculo A
JOIN	modelo B ON A.id_modelo = B.id_modelo 
JOIN	marca C ON B.id_marca = C.id_marca;

-- Q10 - Relatório de riscos por motorista(multas, ocorrências, CNH próxima do vencimento)
SELECT 	A.nome,
		COUNT(DISTINCT B.id_ocorrencia) AS total_ocorrencias,
		COUNT(DISTINCT C.id_multa)      AS total_multas,
		SUM(D.pontos)                  AS total_pontos_multa,
		F.data_validade,
		CASE
			WHEN F.data_validade < CURRENT_DATE + 90 THEN 'CNH a vencer em '||F.data_validade - CURRENT_DATE||' dias'
			ELSE 'CNH regular'
		END AS situacao_cnh
FROM 	motorista A
LEFT JOIN envolve B ON B.id_motorista = A.id_motorista
LEFT JOIN recebe  C ON C.id_motorista = A.id_motorista
LEFT JOIN multa  D ON D.id_multa = C.id_multa
JOIN 	possui E ON A.id_motorista = E.id_motorista
JOIN	cnh F ON E.id_cnh = F.id_cnh
GROUP BY A.id_motorista, A.nome, F.data_validade 
ORDER BY total_pontos_multa DESC NULLS LAST;
